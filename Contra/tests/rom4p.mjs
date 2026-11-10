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

// 4. Overclock (líneas extra de VBlank): sigue siendo determinista, también guardando/cargando
{
  const rec = recording(3000, 77, { players: 2 });
  const hash = (c) => { let h = 0x811c9dc5; for (let i = 0; i < 0x800; i++) h = Math.imul(h ^ c.mem[i], 0x01000193); return h >>> 0; };
  const a = new Core(MODIFIED, { overclock: 60 }), b = new Core(MODIFIED, { overclock: 60 });
  let same = true;
  for (let f = 0; f < 1500; f++) { a.frame(rec[f]); b.frame(rec[f]); if (hash(a) !== hash(b)) { same = false; break; } }
  const st = JSON.stringify(a.saveState());
  const c = new Core(MODIFIED, { overclock: 60 });
  c.loadState(JSON.parse(st));
  for (let f = 1500; f < 3000 && same; f++) { a.frame(rec[f]); c.frame(rec[f]); if (hash(a) !== hash(c)) same = false; }
  check(same, "con overclock: determinista y el estado guardado continúa igual en otra consola");
  // y no es lo mismo que sin overclock (si lo fuera, la opción no estaría haciendo nada)
  const d = new Core(MODIFIED, { overclock: 0 }), e = new Core(MODIFIED, { overclock: 60 });
  let differs = false;
  for (let f = 0; f < 3000 && !differs; f++) { d.frame(rec[f]); e.frame(rec[f]); if (hash(d) !== hash(e)) differs = true; }
  check(differs, "el overclock cambia la simulación (por eso todos los dispositivos deben usar el mismo valor)");
}

// 5. Quitar el límite de 8 sprites por línea solo cambia la imagen, no la simulación
{
  const rec = recording(3000, 55, { players: 2 });
  const a = new Core(MODIFIED, { spriteLimit: true }), b = new Core(MODIFIED, { spriteLimit: false });
  let same = true, imageDiffers = false;
  for (let f = 0; f < rec.length && same; f++) {
    a.frame(rec[f]); b.frame(rec[f]);
    for (let i = 0; i < 0x800; i++) if (a.mem[i] !== b.mem[i]) { same = false; break; }
    if (!imageDiffers) for (let i = 0; i < a.frameBuffer.length; i++) if (a.frameBuffer[i] !== b.frameBuffer[i]) { imageDiffers = true; break; }
  }
  check(same, "con y sin límite de sprites la RAM es idéntica (solo cambia la imagen)");
  check(imageDiffers, "sin límite de sprites la imagen sí cambia (se dibujan los que antes se descartaban)");
}

process.exitCode = fails ? 1 : 0;
