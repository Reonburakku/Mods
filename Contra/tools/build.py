"""
Ensamblador 6502 + constructor de la ROM de Contra.

Uso:  python tools/build.py            -> build/contra.nes y compara con rom/Contra.nes
      python tools/build.py -o mi.nes  -> otro nombre de salida

Sintaxis (parecida a ca65):
    etiqueta:                     define una etiqueta en la dirección actual
    NOMBRE = expr                 constante
    .include "archivo"            incluye otro archivo (ruta relativa al actual)
    .base $8000                   dirección de inicio del banco
    .org $9000[, $FF]             avanza hasta $9000 rellenando (por defecto $FF)
    .byte $01, 2, "TEXTO", <etq   bytes
    .word etq, $1234              palabras de 16 bits (little endian)
    lda a:$0012                   fuerza direccionamiento absoluto (3 bytes)
    lda z:etq                     fuerza página cero (2 bytes)
Expresiones: $hex %bin decimal 'c' simbolo *  con + - y < (byte bajo) > (byte alto).
Todas las etiquetas son globales: cualquier banco puede usar las de otro.
"""
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from opcodes import ENCODE, MODE_SIZE, BRANCHES  # noqa: E402

BANK_SIZE = 0x4000
MNEMONICS = {m for m, _ in ENCODE}


class AsmError(Exception):
    pass


class Bank:
    def __init__(self, number, path, globals_):
        self.number = number
        self.path = path
        self.globals = globals_
        self.locals = globals_
        self.lines = []          # (archivo, nº línea, texto)
        self.load(path)

    def load(self, path, depth=0):
        if depth > 10:
            raise AsmError("demasiados .include anidados")
        with open(path, encoding="utf-8") as f:
            for n, raw in enumerate(f, 1):
                text = strip_comment(raw).strip()
                m = re.match(r'\.include\s+"([^"]+)"', text, re.I)
                if m:
                    self.load(os.path.join(os.path.dirname(path), m.group(1)), depth + 1)
                elif text:
                    self.lines.append((path, n, text))

    # ------------------------------------------------------------ símbolos
    def lookup(self, name):
        if name in self.locals:
            return self.locals[name]
        if name in self.globals:
            return self.globals[name]
        return None

    def define(self, name, value, where):
        if name in self.locals and self.locals[name] != value:
            raise AsmError(f"{where}: símbolo '{name}' definido dos veces")
        self.locals[name] = value

    def eval(self, expr, pc, strict):
        expr = expr.strip()
        if expr.startswith("<"):
            v = self.eval(expr[1:], pc, strict)
            return None if v is None else v & 0xFF
        if expr.startswith(">"):
            v = self.eval(expr[1:], pc, strict)
            return None if v is None else (v >> 8) & 0xFF
        total = 0
        for sign, term in re.findall(r"([+-]?)\s*([^+\-\s]+)", expr):
            v = self.term(term, pc, strict)
            if v is None:
                return None
            total = total - v if sign == "-" else total + v
        return total

    def term(self, t, pc, strict):
        if t == "*":
            return pc
        if t.startswith("$"):
            return int(t[1:], 16)
        if t.startswith("%"):
            return int(t[1:], 2)
        if t.isdigit():
            return int(t)
        if len(t) == 3 and t[0] == t[2] == "'":
            return ord(t[1])
        v = self.lookup(t)
        if v is None and strict:
            raise AsmError(f"símbolo desconocido '{t}'")
        return v

    # ------------------------------------------------------------ ensamblado
    def assemble(self):
        self.sizes = {}
        self.run(pass2=False)
        return self.run(pass2=True)

    def run(self, pass2):
        out = bytearray()
        pc = None
        base = None
        for idx, (path, n, text) in enumerate(self.lines):
            where = f"{os.path.basename(path)}:{n}"
            try:
                # etiqueta (opcionalmente seguida de una instrucción)
                m = re.match(r"([A-Za-z_][\w]*):\s*(.*)$", text)
                if m:
                    if pc is None:
                        raise AsmError("etiqueta antes de .base")
                    if not pass2:
                        self.define(m.group(1), pc, where)
                    text = m.group(2)
                    if not text:
                        continue
                m = re.match(r"([A-Za-z_][\w]*)\s*=\s*(.+)$", text)
                if m:
                    if not pass2:
                        v = self.eval(m.group(2), pc, strict=True)
                        self.define(m.group(1), v, where)
                    continue
                low = text.lower()
                if low.startswith(".base"):
                    base = pc = self.eval(text[5:], pc, True)
                    continue
                if pc is None:
                    raise AsmError("falta .base")
                if low.startswith(".org"):
                    parts = split_args(text[4:])
                    target = self.eval(parts[0], pc, True)
                    fill = self.eval(parts[1], pc, True) if len(parts) > 1 else 0xFF
                    if target < pc:
                        raise AsmError(f".org ${target:04X} está detrás de la posición actual "
                                       f"${pc:04X}: te has pasado {pc - target} bytes del "
                                       f"espacio disponible")
                    out += bytes([fill]) * (target - pc)
                    pc = target
                    continue
                if low.startswith(".byte") or low.startswith(".db"):
                    for arg in split_args(text.split(None, 1)[1]):
                        if arg.startswith('"'):
                            out += arg[1:-1].encode("latin1")
                            pc += len(arg) - 2
                        else:
                            v = self.eval(arg, pc, pass2) if pass2 else 0
                            if pass2 and not 0 <= v <= 0xFF and not -128 <= v < 0:
                                raise AsmError(f"valor fuera de rango para .byte: {arg}")
                            out.append(v & 0xFF)
                            pc += 1
                    continue
                if low.startswith(".word") or low.startswith(".dw"):
                    for arg in split_args(text.split(None, 1)[1]):
                        v = self.eval(arg, pc, True) if pass2 else 0
                        out += bytes([v & 0xFF, (v >> 8) & 0xFF])
                        pc += 2
                    continue
                if low.startswith("."):
                    raise AsmError(f"directiva desconocida: {text.split()[0]}")
                code = self.instruction(idx, text, pc, pass2)
                out += code
                pc += len(code)
            except AsmError as e:
                raise AsmError(f"{where}: {e}\n    > {text}") from None
            except (ValueError, IndexError) as e:
                raise AsmError(f"{where}: sintaxis no válida ({e})\n    > {text}") from None
        return base, bytes(out)

    def instruction(self, idx, text, pc, pass2):
        parts = text.split(None, 1)
        mnem = parts[0].lower()
        arg = parts[1].strip() if len(parts) > 1 else ""
        if mnem not in MNEMONICS:
            raise AsmError(f"instrucción desconocida '{mnem}'")
        force = None
        mode = None
        expr = None
        a = arg.lower().replace(" ", "")
        if a in ("", "a") and ((mnem, "acc") in ENCODE or (mnem, "imp") in ENCODE):
            mode = "acc" if (mnem, "acc") in ENCODE else "imp"
        elif arg.startswith("#"):
            mode, expr = "imm", arg[1:]
        elif mnem in BRANCHES:
            mode, expr = "rel", arg
        elif re.match(r"^\(.*,\s*x\s*\)$", arg, re.I):
            mode, expr = "indx", re.sub(r",\s*[xX]\s*\)$", "", arg[1:])
        elif re.match(r"^\(.*\)\s*,\s*y$", arg, re.I):
            mode, expr = "indy", re.sub(r"\)\s*,\s*[yY]$", "", arg[1:])
        elif arg.startswith("(") and arg.endswith(")"):
            mode, expr = "ind", arg[1:-1]
        else:
            m = re.match(r"^(.*?)\s*,\s*([xyXY])$", arg)
            expr, idxreg = (m.group(1), m.group(2).lower()) if m else (arg, "")
            if expr[:2].lower() in ("a:", "z:"):
                force = expr[0].lower()
                expr = expr[2:]
            key = (idx, "zp")
            if pass2:
                small = self.sizes[key]
            else:
                v = self.eval(expr, pc, strict=False)
                zp_ok = (mnem, "zp" + idxreg) in ENCODE
                if force == "z":
                    small = True
                elif force == "a":
                    small = False
                else:
                    small = v is not None and 0 <= v <= 0xFF and zp_ok
                self.sizes[key] = small
            mode = ("zp" if small else "abs") + idxreg
        if (mnem, mode) not in ENCODE:
            raise AsmError(f"'{mnem}' no admite el modo {mode}")
        op = ENCODE[(mnem, mode)]
        size = MODE_SIZE[mode]
        if not pass2:
            return bytes(size)
        if size == 1:
            return bytes([op])
        v = self.eval(expr, pc, strict=True)
        if mode == "rel":
            off = v - (pc + 2)
            if not -128 <= off <= 127:
                raise AsmError(f"salto relativo fuera de rango ({off} bytes)")
            return bytes([op, off & 0xFF])
        if size == 2:
            if not -128 <= v <= 0xFF:
                raise AsmError(f"operando de 8 bits fuera de rango: ${v:X}")
            return bytes([op, v & 0xFF])
        return bytes([op, v & 0xFF, (v >> 8) & 0xFF])


def strip_comment(line):
    out, q = [], None
    for ch in line:
        if q:
            if ch == q:
                q = None
        elif ch in "\"'":
            q = ch
        elif ch == ";":
            break
        out.append(ch)
    return "".join(out)


def split_args(s):
    args, cur, q = [], "", None
    for ch in s:
        if q:
            cur += ch
            if ch == q:
                q = None
        elif ch in "\"":
            q = ch
            cur += ch
        elif ch == ",":
            args.append(cur.strip())
            cur = ""
        else:
            cur += ch
    if cur.strip():
        args.append(cur.strip())
    return args


def rom_bank_count(header):
    """Número de bancos de 16 KB según la cabecera (iNES o NES 2.0)."""
    count = header[4]
    if (header[7] & 0x0C) == 0x08:            # NES 2.0: 4 bits altos en el byte 9
        count |= (header[9] & 0x0F) << 8
    return count


def main():
    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    src = os.path.join(root, "src")
    out_path = os.path.join(root, "build", "contra.nes")
    if "-o" in sys.argv:
        out_path = sys.argv[sys.argv.index("-o") + 1]
    os.makedirs(os.path.dirname(os.path.abspath(out_path)), exist_ok=True)

    header = open(os.path.join(src, "header.bin"), "rb").read()
    count = rom_bank_count(header)
    # Bancos físicos 0..count-2: bankN.asm ($8000, intercambiables). El último: fixed.asm ($C000).
    files = [(f"bank{n}.asm", 0x8000) for n in range(count - 1)] + [("fixed.asm", 0xC000)]

    symbols = {}        # todas las etiquetas son globales (los prefijos L3_ etc. evitan choques)
    banks = []
    try:
        objs = []
        for n, (name, base) in enumerate(files):
            path = os.path.join(src, name)
            if not os.path.exists(path):
                raise AsmError(f"la cabecera indica {count} bancos pero falta {name}")
            objs.append((name, base, Bank(n, path, symbols)))
        for _, _, b in objs:             # pasada 1: tamaños y etiquetas de todos los bancos
            b.sizes = {}
            b.run(pass2=False)
        for name, expected, b in objs:   # pasada 2: código final
            base, data = b.run(pass2=True)
            if base != expected:
                raise AsmError(f"{name}: .base debe ser ${expected:04X}")
            if len(data) > BANK_SIZE:
                raise AsmError(f"{name} ocupa {len(data)} bytes: se pasa "
                               f"{len(data) - BANK_SIZE} bytes de los 16384 del banco")
            if len(data) < BANK_SIZE:
                print(f"aviso: {name} ocupa {len(data)} bytes; se rellena con $FF")
                data += bytes([0xFF]) * (BANK_SIZE - len(data))
            banks.append(data)
    except AsmError as e:
        sys.exit(f"ERROR: {e}")

    rom = header + b"".join(banks)
    with open(out_path, "wb") as f:
        f.write(rom)
    print(f"ROM generada: {out_path} ({len(rom)} bytes, {count} bancos)")

    # Comparación con la original: bancos 0-6 con 0-6, fixed.asm con el banco fijo original
    orig_path = os.path.join(root, "rom", "Contra.nes")
    if not os.path.exists(orig_path):
        return
    orig = open(orig_path, "rb").read()
    obanks = [orig[16 + i * BANK_SIZE:16 + (i + 1) * BANK_SIZE] for i in range(rom_bank_count(orig))]
    pairs = [(i, files[i][0], banks[i], obanks[i]) for i in range(len(obanks) - 1)]
    pairs.append((len(banks) - 1, "fixed.asm", banks[-1], obanks[-1]))
    total = 0
    lines = []
    for _, name, new, old in pairs:
        base = 0xC000 if name == "fixed.asm" else 0x8000
        diffs = [i for i in range(BANK_SIZE) if new[i] != old[i]]
        total += len(diffs)
        for i in diffs[:10]:
            lines.append(f"  {name} ${base + i:04X}: {old[i]:02X} -> {new[i]:02X}")
        if len(diffs) > 10:
            lines.append(f"  {name}: ... {len(diffs) - 10} más")
    extra = len(banks) - len(obanks)
    if total == 0 and extra == 0 and header == orig[:16]:
        print("Idéntica a la ROM original.")
        return
    print(f"Cambios respecto a la original: {total} bytes en los bancos originales"
          + (f", {extra} bancos nuevos" if extra else "")
          + (", cabecera distinta" if header != orig[:16] else ""))
    for line in lines[:40]:
        print(line)
    for i in range(len(obanks) - 1, len(banks) - 1):
        used = sum(1 for x in banks[i][1:] if x != 0xFF)
        if used:
            print(f"  bank{i}.asm (nuevo): {used} bytes usados")


if __name__ == "__main__":
    main()
