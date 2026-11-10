// Fase 3: la ROM modificada (build/contra.nes).
// Uso: node tests/rom4p.mjs
//
// Nota: ya no se puede exigir que sea idéntica a la original fotograma a fotograma.
// Contra genera su azar en el bucle de espera ($C057), que da más o menos vueltas según
// lo que tarde la NMI; cualquier cambio en la NMI (como leer 4 mandos) cambia el azar.
// La ampliación a 16 bancos sí se comprobó idéntica antes de tocar la NMI.
import { readFileSync } from "node:fs";
import { Core, BTN } from "../web/emu/core.js";
import { recording } from "./lib/recording.mjs";
import { TestConsole, rng } from "./lib/console.mjs";

const ORIGINAL = readFileSync("rom/Contra.nes");
const MODIFIED = readFileSync("build/contra.nes");
let fails = 0;
const check = (ok, msg) => { console.log(`${ok ? "OK   " : "FALLO"} ${msg}`); if (!ok) fails++; };

// Direcciones de src/ram4p.inc
const Pad4Held = 0x6000, Pad4Sig = 0x6014, FourScoreOn = 0x6016;

// 1. El Contra original no se entera del Four Score (solo lee 8 bits por puerto)
{
  const a = new Core(ORIGINAL, { fourScore: false }), b = new Core(ORIGINAL, { fourScore: true });
  const rec = recording(3600, 99, { players: 2 });
  let diff = -1;
  for (let f = 0; f < rec.length && diff < 0; f++) {
    a.frame(rec[f]); b.frame(rec[f]);
    for (let i = 0; i < 0x800; i++) if (a.mem[i] !== b.mem[i]) { diff = f; break; }
  }
  check(diff < 0, "original con y sin Four Score: idéntico en 3600 fotogramas");
}

// 2. Los 4 mandos llegan a la RAM; J1/J2 también a las variables originales ($F1/$F5/$F9)
for (const fourScore of [true, false]) {
  const c = new Core(MODIFIED, { fourScore });
  const r = rng(5);
  let bad = null, skipped = 0;
  for (let i = 0; i < 120; i++) c.frame([0, 0, 0, 0]);   // arranque (la NMI aún no está activa)
  for (let f = 0; f < 600 && !bad; f++) {
    const inp = [0, 1, 2, 3].map(() => Math.floor(r() * 256) & ~(BTN.START | BTN.SELECT));
    // mantener cada combinación 4 fotogramas: las dos lecturas de una NMI deben coincidir
    // y, si el juego va ocupado, su NMI se salta la lectura en algún fotograma (como el original)
    c.mem[Pad4Sig] = 0x55;                 // testigo: ReadRaw4 lo sobrescribe siempre que lee
    for (let k = 0; k < 4; k++) c.frame(inp);
    if (c.mem[Pad4Sig] === 0x55) { skipped++; continue; }   // pantalla de carga: NMI sin lectura
    const got = [0, 1, 2, 3].map((i) => c.mem[Pad4Held + i]);
    const want = fourScore ? inp : [inp[0], inp[1], 0, 0];
    // según el modo de juego ($1D bit 2) el mando 2 también controla a J1, como en el
    // original; el modo puede cambiar en el mismo fotograma, así que valen las dos opciones
    const j1ok = got[0] === want[0] || got[0] === (want[0] | want[1]);
    if (!j1ok || got[1] !== want[1] || got[2] !== want[2] || got[3] !== want[3]) {
      bad = `f${f}: leído ${got.map((x) => x.toString(16))}, esperado ${want.map((x) => x.toString(16))}`;
    } else if (c.mem[0xf9] !== got[0] || c.mem[0xfa] !== got[1]) {
      // $F9/$FA solo los escribe la lectura de mandos ($F1/$F5 también los escribe la demo)
      bad = `f${f}: $F9/$FA = ${c.mem[0xf9].toString(16)}/${c.mem[0xfa].toString(16)} no coincide con J1/J2`;
    } else if (c.mem[FourScoreOn] !== (fourScore ? 1 : 0)) {
      bad = `f${f}: FourScoreOn = ${c.mem[FourScoreOn]}`;
    }
  }
  check(!bad && skipped < 100, `${fourScore ? "con" : "sin"} Four Score: J1-J4 se leen bien ` +
    `(${600 - skipped} combinaciones comprobadas, ${skipped} durante pantallas de carga)` + (bad ? ` (${bad})` : ""));
}

// 3. Se juega: partida a 2 jugadores de 2 minutos con entradas aleatorias, sin colgarse
{
  const c = new TestConsole("build/contra.nes");
  const rec = recording(7200, 1234, { players: 2 });
  let crashed = null;
  try { for (const inp of rec) c.frame(inp); } catch (e) { crashed = e.message; }
  check(!crashed, "partida de 2 minutos a 2 jugadores sin colgarse" + (crashed ? ` (${crashed})` : ""));
  c.screenshot("tests/out/rom4p-partida.png");
}

process.exitCode = fails ? 1 : 0;
