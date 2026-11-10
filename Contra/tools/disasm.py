"""
Desensamblador de Contra (USA, NES, mapper UNROM).

Uso:  python tools/disasm.py [--force] [rom/Contra.nes] [src]

Genera src/bank0.asm ... src/bank7.asm y src/nes.inc.
Los bancos 0-6 se mapean en $8000-$BFFF (intercambiables), el 7 está fijo en $C000-$FFFF.

Cómo distingue código de datos:
  * Sigue el flujo de ejecución desde los vectores NMI/RESET/IRQ (análisis recursivo).
  * Sigue los cambios de banco: "ldy #N / jsr $C139" (o $C13F) selecciona el banco N,
    así que los jsr/jmp a $8000-$BFFF que vienen después se resuelven al banco N.
  * Entiende la rutina de tabla de saltos en línea "jsr $C857" seguida de una lista de .word.
  * Entradas extra (rutinas que solo se alcanzan por punteros) en tools/disasm_config.py.
Todo lo que no se identifica como código se emite como .byte, así que la reconstrucción
siempre es exacta.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from opcodes import OPCODES, MODE_SIZE, BRANCHES  # noqa: E402
import disasm_config as cfg  # noqa: E402

BANK_SIZE = 0x4000
FIXED = 7
BANKSWITCH_ROUTINES = {0xC139, 0xC13F}   # Y = número de banco
INLINE_JUMP_TABLE = 0xC857               # jsr $C857 + .word tabla (índice en A)
SOUND_BANK_SWITCH = 0xC14C               # cambia al banco de sonido
SOUND_BANK = 1
BANK_RESTORE_ROUTINES = {0xC146, 0xC15E} # vuelven al banco anterior (desconocido)

HW_REGS = {
    0x2000: "PPUCTRL", 0x2001: "PPUMASK", 0x2002: "PPUSTATUS", 0x2003: "OAMADDR",
    0x2004: "OAMDATA", 0x2005: "PPUSCROLL", 0x2006: "PPUADDR", 0x2007: "PPUDATA",
    0x4000: "SQ1_VOL", 0x4001: "SQ1_SWEEP", 0x4002: "SQ1_LO", 0x4003: "SQ1_HI",
    0x4004: "SQ2_VOL", 0x4005: "SQ2_SWEEP", 0x4006: "SQ2_LO", 0x4007: "SQ2_HI",
    0x4008: "TRI_LINEAR", 0x400A: "TRI_LO", 0x400B: "TRI_HI",
    0x400C: "NOISE_VOL", 0x400E: "NOISE_LO", 0x400F: "NOISE_HI",
    0x4010: "DMC_FREQ", 0x4011: "DMC_RAW", 0x4012: "DMC_START", 0x4013: "DMC_LEN",
    0x4014: "OAMDMA", 0x4015: "SND_CHN", 0x4016: "JOY1", 0x4017: "JOY2",
}


def base_of(bank):
    return 0xC000 if bank == FIXED else 0x8000


def in_bank(bank, addr):
    b = base_of(bank)
    return b <= addr < b + BANK_SIZE


def label_name(bank, addr, kind):
    """kind: 'L' código, 'D' datos.  Banco 7 -> L_C123 (global); banco n -> L3_8123."""
    custom = cfg.LABELS.get((bank, addr))
    if custom:
        return custom
    return f"{kind}_{addr:04X}" if bank == FIXED else f"{kind}{bank}_{addr:04X}"


class Disassembler:
    def __init__(self, rom):
        if rom[:4] != b"NES\x1a":
            sys.exit("No es una ROM iNES")
        self.header = rom[:16]
        self.banks = [rom[16 + i * BANK_SIZE:16 + (i + 1) * BANK_SIZE] for i in range(8)]
        # Por banco: dir -> (mnem, mode, operand, size)
        self.code = [dict() for _ in range(8)]
        self.covered = [dict() for _ in range(8)]   # dir -> dir de inicio de la instrucción/word
        self.words = [dict() for _ in range(8)]     # dir -> (banco destino o None, valor)
        self.refs = [dict() for _ in range(8)]      # dir de instrucción -> (banco destino, dir)
        self.code_targets = [set() for _ in range(8)]
        self.data_targets = [set() for _ in range(8)]
        self.entries = [set() for _ in range(8)]
        self.ambiguous = [set() for _ in range(8)]
        self.ctx_seen = set()
        self.queue = []

    # ---------------------------------------------------------------- tracing
    def decode(self, bank, addr):
        d = self.banks[bank]
        off = addr - base_of(bank)
        op = d[off]
        if op not in OPCODES or op == 0x00:          # brk casi siempre es dato
            return None
        mnem, mode = OPCODES[op]
        size = MODE_SIZE[mode]
        if off + size > BANK_SIZE:
            return None
        if size == 2:
            operand = d[off + 1]
            if mode == "rel":
                operand = (addr + 2 + ((operand ^ 0x80) - 0x80)) & 0xFFFF
        elif size == 3:
            operand = d[off + 1] | d[off + 2] << 8
        else:
            operand = None
        return mnem, mode, operand, size

    def free(self, bank, addr, size):
        cov = self.covered[bank]
        return all((addr + i) not in cov for i in range(size))

    def resolve(self, bank, target, ctx_bank):
        """Banco al que pertenece una dirección referenciada desde 'bank'."""
        if target >= 0xC000:
            return FIXED
        if 0x8000 <= target < 0xC000:
            if bank != FIXED:
                return bank
            return ctx_bank
        return None

    def push(self, bank, addr, ctx=None):
        if bank is not None and in_bank(bank, addr):
            self.code_targets[bank].add(addr)
            self.queue.append((bank, addr, ctx))

    def run(self):
        while self.queue:
            bank, addr, ctx = self.queue.pop()
            self.trace(bank, addr, ctx)

    def set_ref(self, bank, addr, tb, target):
        """Guarda a qué banco apunta una referencia; si dos contextos discrepan, se deja sin resolver."""
        key = addr
        if key in self.ambiguous[bank]:
            return
        old = self.refs[bank].get(key)
        if old is not None and old[0] is not None and tb is not None and old[0] != tb:
            self.ambiguous[bank].add(key)
            self.refs[bank][key] = (None, target)
            return
        if old is None or old[0] is None:
            self.refs[bank][key] = (tb, target)

    def trace(self, bank, addr, ctx_bank):
        """Sigue el código desde addr. ctx_bank = banco cargado en $8000 (si se sabe)."""
        ctx_y = None
        while in_bank(bank, addr):
            if addr in self.code[bank]:
                # ya desensamblado: en el banco fijo se recorre otra vez si conocemos
                # un banco activo nuevo, para resolver sus jsr/jmp a $8000-$BFFF
                if bank != FIXED or ctx_bank is None or (addr, ctx_bank) in self.ctx_seen:
                    return
                ins = self.code[bank][addr]
            else:
                ins = self.decode(bank, addr)
                if ins is None:
                    return
                if not self.free(bank, addr, ins[3]):
                    return
                self.code[bank][addr] = ins
                for i in range(ins[3]):
                    self.covered[bank][addr + i] = addr
            if bank == FIXED and ctx_bank is not None:
                self.ctx_seen.add((addr, ctx_bank))
            mnem, mode, operand, size = ins
            nxt = addr + size

            if mode == "rel":
                self.push(bank, operand, ctx_bank)
                self.set_ref(bank, addr, bank, operand)
            elif mnem in ("jsr", "jmp") and mode == "abs":
                tb = self.resolve(bank, operand, ctx_bank)
                self.set_ref(bank, addr, tb, operand)
                if mnem == "jsr" and operand in BANKSWITCH_ROUTINES and ctx_y is not None:
                    ctx_bank = ctx_y
                elif mnem == "jsr" and operand == SOUND_BANK_SWITCH:
                    ctx_bank = SOUND_BANK
                elif mnem == "jsr" and operand in BANK_RESTORE_ROUTINES:
                    ctx_bank = None
                if mnem == "jsr" and operand == INLINE_JUMP_TABLE:
                    self.push(FIXED, operand)
                    self.inline_table(bank, nxt, ctx_bank)
                    return
                if not (mnem == "jsr" and operand in BANKSWITCH_ROUTINES | BANK_RESTORE_ROUTINES
                        | {SOUND_BANK_SWITCH}):
                    self.push(tb, operand, ctx_bank if tb == FIXED else None)
                else:
                    self.push(tb, operand, None)
                if mnem == "jmp":
                    return
            elif mode in ("abs", "absx", "absy", "ind"):
                tb = self.resolve(bank, operand, ctx_bank)
                if tb is not None:
                    self.set_ref(bank, addr, tb, operand)
                    if in_bank(tb, operand):
                        self.data_targets[tb].add(operand)

            # contexto de Y para detectar el cambio de banco
            if mnem == "ldy" and mode == "imm":
                ctx_y = operand
            elif mnem in ("ldy", "tay", "iny", "dey", "jsr"):
                ctx_y = None

            if mnem in ("rts", "rti", "jmp"):
                return
            addr = nxt

    def inline_table(self, bank, addr, ctx_bank):
        limit = base_of(bank) + BANK_SIZE
        while addr + 1 < base_of(bank) + BANK_SIZE and addr < limit:
            off = addr - base_of(bank)
            val = self.banks[bank][off] | self.banks[bank][off + 1] << 8
            if addr in self.words[bank]:            # ya conocida: solo resolver con el contexto
                tb = self.resolve(bank, val, ctx_bank)
                if tb is not None and self.words[bank][addr][0] is None:
                    self.words[bank][addr] = (tb, val)
                self.push(tb, val, ctx_bank if tb == FIXED else None)
                addr += 2
                continue
            if not self.free(bank, addr, 2) or addr in self.code_targets[bank]:
                break
            tb = self.resolve(bank, val, ctx_bank)
            if tb is None or not in_bank(tb, val):
                break
            self.words[bank][addr] = (tb, val)
            self.covered[bank][addr] = addr
            self.covered[bank][addr + 1] = addr
            self.push(tb, val, ctx_bank if tb == FIXED else None)
            if tb == bank and val > addr:
                limit = min(limit, val)
            addr += 2

    # ------------------------------------------- tablas de punteros (heurística)
    def looks_like_code(self, bank, addr):
        """Prueba en seco: ¿parece código a partir de addr?"""
        if not in_bank(bank, addr):
            return False
        if addr in self.code[bank]:
            return True
        if addr in self.covered[bank]:
            return False
        for _ in range(120):
            if not in_bank(bank, addr):
                return False
            if addr in self.code[bank]:
                return True
            ins = self.decode(bank, addr)
            if ins is None or not self.free(bank, addr, ins[3]):
                return False
            mnem, mode, operand, size = ins
            if mnem in ("rts", "rti", "jmp"):
                return True
            if mnem == "jsr" and operand == INLINE_JUMP_TABLE:
                return True
            addr += size
        return False

    def word_at(self, bank, addr):
        off = addr - base_of(bank)
        if off < 0 or off + 1 >= BANK_SIZE:
            return None
        return self.banks[bank][off] | self.banks[bank][off + 1] << 8

    def find_pointer_tables(self):
        found = False
        for b in range(8):
            for start in sorted(self.data_targets[b]):
                for s in (start, start + 2):
                    if s in self.covered[b] or s in self.words[b]:
                        continue
                    run = []
                    a = s
                    while (a not in self.covered[b] and a + 1 not in self.covered[b]
                           and (a == s or a not in self.data_targets[b])):
                        val = self.word_at(b, a)
                        if val is None:
                            break
                        tb = self.resolve(b, val, None)
                        if tb is None or not self.looks_like_code(tb, val):
                            break
                        run.append((a, tb, val))
                        a += 2
                    if len(run) >= 2:
                        for a, tb, val in run:
                            self.words[b][a] = (tb, val)
                            self.covered[b][a] = self.covered[b][a + 1] = a
                            self.push(tb, val)
                        found = True
                        break
        return found

    # ------------------------------------------------------------- output
    def line_starts(self, bank):
        s = set(self.code[bank]) | set(self.words[bank])
        return s

    def ref_text(self, tb, addr, labels):
        """Texto del operando para una referencia resuelta (banco tb, dirección addr)."""
        if tb is None or not in_bank(tb, addr):
            return None
        lab = labels[tb]
        if addr in lab:
            return lab[addr]
        start = self.covered[tb].get(addr)
        if start is not None and start in lab:
            return f"{lab[start]}+{addr - start}"
        for k in (1, 2):
            if addr + k in lab:
                return f"{lab[addr + k]}-{k}"
        return None

    def build_labels(self):
        labels = [dict() for _ in range(8)]
        for b in range(8):
            for a in self.code_targets[b] | self.entries[b]:
                if a in self.code[b]:
                    labels[b][a] = label_name(b, a, "L")
                elif a in self.words[b]:
                    labels[b][a] = label_name(b, a, "D")
            for a in self.data_targets[b]:
                start = self.covered[b].get(a)
                if start is None:                     # en zona de datos: etiqueta propia
                    labels[b][a] = label_name(b, a, "D")
                elif start not in labels[b]:
                    kind = "L" if start in self.code[b] else "D"
                    labels[b][start] = label_name(b, start, kind)
            for a in list(self.code_targets[b]):
                start = self.covered[b].get(a)
                if start is not None and start != a and start not in labels[b]:
                    labels[b][start] = label_name(b, start, "L")
            for (bb, a), name in cfg.LABELS.items():
                if bb == b:
                    labels[b][a] = name
        return labels

    def fmt_operand(self, bank, addr, ins, labels):
        mnem, mode, operand, size = ins
        if mode in ("imp",):
            return ""
        if mode == "acc":
            return "a"
        if mode == "imm":
            return f"#${operand:02X}"
        ref = self.refs[bank].get(addr)
        text = None
        if ref is not None:
            text = self.ref_text(ref[0], ref[1], labels)
        if text is None and size == 3 and operand in HW_REGS:
            text = HW_REGS[operand]
        ram = {v: k for k, v in cfg.RAM.items()}
        if text is None and mode != "rel" and operand in ram:
            text = ram[operand]
            if mode in ("abs", "absx", "absy") and operand < 0x100:
                text = "a:" + text
        if text is None:
            text = f"${operand:02X}" if size == 2 and mode != "rel" else f"${operand:04X}"
            if mode in ("abs", "absx", "absy") and operand < 0x100:
                text = "a:" + text             # forzar modo absoluto (3 bytes)
        return {
            "zp": "{}", "abs": "{}", "rel": "{}",
            "zpx": "{},x", "absx": "{},x", "zpy": "{},y", "absy": "{},y",
            "ind": "({})", "indx": "({},x)", "indy": "({}),y",
        }[mode].format(text)

    def free_runs(self, bank, labels):
        """Bloques largos de relleno ($FF o $00) sin referencias: espacio libre."""
        d = self.banks[bank]
        base = base_of(bank)
        runs = []
        i = 0
        while i < BANK_SIZE:
            a = base + i
            if a in self.covered[bank] or d[i] not in (0xFF, 0x00):
                i += 1
                continue
            j = i
            while j < BANK_SIZE and d[j] == d[i] and (base + j) not in self.covered[bank] \
                    and (j == i or (base + j) not in labels[bank]):
                j += 1
            if j - i >= 64:
                runs.append((i, j, d[i]))
            i = j
        return runs

    def write_bank(self, bank, labels, out):
        d = self.banks[bank]
        base = base_of(bank)
        lab = labels[bank]
        runs = {s: (e, v) for s, e, v in self.free_runs(bank, labels)}
        lines = []
        w = lines.append
        w(f"; ============================================================")
        w(f"; Contra (USA) - banco {bank}  (${base:04X}-${base + BANK_SIZE - 1:04X})"
          + ("  [FIJO]" if bank == FIXED else "  [intercambiable]"))
        w(f"; Generado por tools/disasm.py. Las etiquetas L_ son código, D_ son datos.")
        w(f"; ============================================================")
        w('.include "nes.inc"')
        if bank != FIXED:
            w("; Las etiquetas del banco fijo (L_xxxx) son visibles desde aquí.")
        w(f".base ${base:04X}")
        w("")
        comments = {a: c for (b, a), c in cfg.COMMENTS.items() if b == bank}
        i = 0
        pending = []

        def flush():
            if pending:
                w("    .byte " + ",".join(f"${x:02X}" for x in pending))
                pending.clear()

        while i < BANK_SIZE:
            a = base + i
            if a in lab or a in comments or a in self.code[bank] or a in self.words[bank] or i in runs:
                flush()
            if a in comments:
                for c in comments[a].splitlines():
                    w(f"; {c}")
            if a in lab:
                if a in self.code[bank]:
                    w("")
                w(f"{lab[a]}:")
            if i in runs:
                e, v = runs[i]
                w(f"; --- espacio libre: {e - i} bytes (${a:04X}-${base + e - 1:04X}) ---")
                w(f".org ${base + e:04X}, ${v:02X}")
                i = e
                continue
            if a in self.code[bank]:
                ins = self.code[bank][a]
                mnem, mode, operand, size = ins
                ops = self.fmt_operand(bank, a, ins, labels)
                raw = " ".join(f"{x:02X}" for x in d[i:i + size])
                text = f"    {mnem} {ops}".rstrip()
                w(f"{text:<32}; {a:04X}  {raw}")
                if mnem in ("rts", "rti", "jmp"):
                    w("")
                i += size
                continue
            if a in self.words[bank]:
                tb, val = self.words[bank][a]
                t = self.ref_text(tb, val, labels) or f"${val:04X}"
                w(f"    .word {t:<26}; {a:04X}")
                i += 2
                continue
            pending.append(d[i])
            if len(pending) == 16:
                flush()
            i += 1
        flush()
        with open(os.path.join(out, f"bank{bank}.asm"), "w", encoding="utf-8", newline="\n") as f:
            f.write("\n".join(lines) + "\n")

    def write_includes(self, labels, out):
        with open(os.path.join(out, "nes.inc"), "w", encoding="utf-8", newline="\n") as f:
            f.write("; Registros de hardware de la NES\n")
            for a, n in sorted(HW_REGS.items()):
                f.write(f"{n:<11} = ${a:04X}\n")
            f.write("\n; Variables de RAM conocidas (edita tools/disasm_config.py para añadir)\n")
            for n, a in sorted(cfg.RAM.items(), key=lambda x: x[1]):
                f.write(f"{n:<24} = ${a:04X}\n" if a > 0xFF else f"{n:<24} = ${a:02X}\n")

    def stats(self):
        for b in range(8):
            c = sum(s[3] for s in self.code[b].values())
            wd = 2 * len(self.words[b])
            print(f"  banco {b}: {c:6d} bytes de código, {wd:5d} de tablas de punteros, "
                  f"{BANK_SIZE - c - wd:6d} de datos")


def main():
    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    rom_path = args[0] if len(args) > 0 else os.path.join(root, "rom", "Contra.nes")
    out = args[1] if len(args) > 1 else os.path.join(root, "src")
    if os.path.exists(os.path.join(out, "bank7.asm")) and "--force" not in sys.argv:
        sys.exit(f"{out} ya contiene un desensamblado. Volver a generarlo BORRARÍA tus cambios.\n"
                 f"Si de verdad quieres regenerarlo: python tools/disasm.py --force")
    os.makedirs(out, exist_ok=True)
    rom = open(rom_path, "rb").read()
    ds = Disassembler(rom)

    b7 = ds.banks[FIXED]
    for vec in (0xFFFA, 0xFFFC, 0xFFFE):
        off = vec - 0xC000
        ds.push(FIXED, b7[off] | b7[off + 1] << 8)
    for bank, addr in cfg.ENTRIES:
        ds.entries[bank].add(addr)
        ds.push(bank, addr)
    ds.run()
    # tablas de tablas de rutinas (configuradas a mano, p. ej. la IA de los enemigos)
    for bank, addr, count, tbank, skip in cfg.ROUTINE_TABLE_TABLES:
        for k in range(count):
            a = addr + 2 * k
            val = ds.word_at(bank, a)
            sub_bank = FIXED if val + skip >= 0xC000 else tbank
            ds.words[bank][a] = (sub_bank, val)
            ds.covered[bank][a] = ds.covered[bank][a + 1] = a
            sub = val + skip
            if not in_bank(sub_bank, sub):
                continue
            ds.data_targets[sub_bank].add(sub)
            ds.entries[sub_bank].add(sub)
            while sub not in ds.covered[sub_bank]:
                w = ds.word_at(sub_bank, sub)
                if w is None:
                    break
                wb = ds.resolve(sub_bank, w, tbank)
                if wb is None or not ds.looks_like_code(wb, w):
                    break
                ds.words[sub_bank][sub] = (wb, w)
                ds.covered[sub_bank][sub] = ds.covered[sub_bank][sub + 1] = sub
                ds.push(wb, w, tbank if wb == FIXED else None)
                sub += 2
            ds.run()
    # tablas de punteros a código referenciadas desde el código (lda tabla,y ...)
    while ds.find_pointer_tables():
        ds.run()
    # vectores como .word
    for vec in (0xFFFA, 0xFFFC, 0xFFFE):
        off = vec - 0xC000
        ds.words[FIXED][vec] = (FIXED, b7[off] | b7[off + 1] << 8)
        ds.covered[FIXED][vec] = ds.covered[FIXED][vec + 1] = vec
    for bank, addr, count in cfg.WORD_TABLES:
        for k in range(count):
            a = addr + 2 * k
            off = a - base_of(bank)
            val = ds.banks[bank][off] | ds.banks[bank][off + 1] << 8
            tb = ds.resolve(bank, val, None)
            ds.words[bank][a] = (tb, val)
            ds.covered[bank][a] = ds.covered[bank][a + 1] = a
            ds.data_targets[bank].add(addr)

    labels = ds.build_labels()
    for b in range(8):
        ds.write_bank(b, labels, out)
    ds.write_includes(labels, out)
    with open(os.path.join(out, "header.bin"), "wb") as f:
        f.write(ds.header)
    print("Desensamblado en", out)
    ds.stats()


if __name__ == "__main__":
    main()
