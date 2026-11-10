// Análisis: qué RAM escribe el juego indexada por jugador.
// Ejecuta una partida a 2 jugadores con entradas aleatorias y registra cada escritura
// en RAM hecha con direccionamiento indexado (sta base,x / base,y ...). Agrupa por
// dirección base y muestra qué valores de índice se usan: los arrays de los jugadores
// usan índice 0-1; los de enemigos/balas, rangos mayores.
// Uso: node tests/ram-map.mjs [rom] [fotogramas]   -> tests/out/ram-map.txt
import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { Core } from "../web/emu/core.js";
import { OPCODES } from "./lib/opcodes.mjs";
import { recording } from "./lib/recording.mjs";

const rom = process.argv[2] ?? "build/contra.nes";
const frames = Number(process.argv[3] ?? 36000);
const c = new Core(readFileSync(rom));
const cpu = c.nes.cpu;

/** base -> {mode, idx: Map(valorÍndice -> veces), sites: Set("banco:dir")} */
const arrays = new Map();
const write = cpu.write.bind(cpu);
cpu.write = (addr, val) => {
  if (addr < 0x0800 && (addr < 0x100 || addr >= 0x200) || (addr >= 0x6000 && addr < 0x8000)) {
    // REG_PC = dirección de la instrucción - 1 + tamaño: probar tamaños 2 y 3
    for (const size of [3, 2]) {
      const at = (cpu.REG_PC + 1 - size) & 0xffff;
      const info = OPCODES[cpu.mem[at]];
      if (!info || info.size !== size || !info.store) continue;
      let reg = null;
      if (info.mode.endsWith("x")) reg = cpu.REG_X;
      else if (info.mode.endsWith("y") && info.mode !== "indy") reg = cpu.REG_Y;
      if (reg === null) break;
      const base = info.mode.startsWith("zp") ? (addr - reg) & 0xff : (addr - reg) & 0xffff;
      let e = arrays.get(base);
      if (!e) arrays.set(base, (e = { idx: new Map(), sites: new Set() }));
      e.idx.set(reg, (e.idx.get(reg) ?? 0) + 1);
      const bank = at >= 0xc000 ? "F" : cpu.mem[0x8000];
      e.sites.add(`${bank}:${at.toString(16).toUpperCase()}`);
      break;
    }
  }
  write(addr, val);
};

const rec = recording(frames, 4242, { players: 2 });
// cada 2 minutos, Start dos veces (por si hay game over: continuar)
for (let f = 0; f < rec.length; f++) {
  const inp = rec[f];
  if (f % 7200 > 7000 && f % 7200 < 7004) inp[0] |= 0x10;
  c.frame(inp);
}

const hex = (n, w = 4) => "$" + n.toString(16).toUpperCase().padStart(w, "0");
const rows = [...arrays.entries()].sort((a, b) => a[0] - b[0]).map(([base, e]) => {
  const idx = [...e.idx.keys()].sort((a, b) => a - b);
  const kind = idx.every((i) => i <= 1) ? "JUGADOR (0-1)" : idx.length <= 4 ? "pequeño" : "";
  return `${hex(base)}  índices ${idx.length > 12 ? `${idx[0]}..${idx.at(-1)} (${idx.length})` : idx.join(",")}`.padEnd(46) +
    `${kind.padEnd(15)} escrito desde ${[...e.sites].slice(0, 6).join(" ")}${e.sites.size > 6 ? " …" : ""}`;
});
mkdirSync("tests/out", { recursive: true });
writeFileSync("tests/out/ram-map.txt", `RAM escrita con índice (${frames} fotogramas, 2 jugadores)\n\n` + rows.join("\n") + "\n");
console.log(rows.filter((r) => r.includes("JUGADOR")).join("\n"));
console.log(`\n${rows.length} arrays en total; listado completo en tests/out/ram-map.txt`);
