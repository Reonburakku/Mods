// Fase 0: ¿es determinista? ¿es lo bastante rápido para rollback?
// Uso: node tests/determinism.mjs [ruta.nes]
import { TestConsole, BTN, rng } from "./lib/console.mjs";

const rom = process.argv[2] ?? "rom/Contra.nes";
let fails = 0;
const check = (ok, msg) => { console.log(`${ok ? "OK   " : "FALLO"} ${msg}`); if (!ok) fails++; };

// Partida grabada: arranque, 2 jugadores, y luego entradas aleatorias (semilla fija)
function recording(frames, seed) {
  const r = rng(seed), inputs = [];
  const push = (n, a, b = 0) => { for (let i = 0; i < n; i++) inputs.push([a, b]); };
  push(240, 0); push(4, BTN.START); push(60, 0);
  push(4, BTN.SELECT); push(20, 0);                   // elegir "2 PLAYERS"
  push(4, BTN.START); push(200, 0);
  let a = 0, b = 0;
  while (inputs.length < frames) {
    if (r() < 0.1) a = Math.floor(r() * 256) & ~(BTN.START | BTN.SELECT);
    if (r() < 0.1) b = Math.floor(r() * 256) & ~(BTN.START | BTN.SELECT);
    inputs.push([a, b]);
  }
  return inputs;
}

function play(inputs) {
  const c = new TestConsole(rom);
  const hashes = inputs.map((inp) => { c.frame(inp); return c.ramHash(); });
  return { c, hashes };
}

const FR = 3600;                               // 1 minuto de juego
const rec = recording(FR, 1234);

// 1. Dos ejecuciones desde cero con las mismas entradas dan la misma RAM en cada fotograma
const run1 = play(rec), run2 = play(rec);
const firstDiff = run1.hashes.findIndex((h, i) => h !== run2.hashes[i]);
check(firstDiff === -1, `misma partida dos veces: RAM idéntica en los ${FR} fotogramas` +
  (firstDiff >= 0 ? ` (difiere en el fotograma ${firstDiff})` : ""));
run1.c.screenshot("tests/out/04-determinismo-final.png");

// 2. Guardar estado, avanzar, cargar y repetir: mismo resultado (base del rollback)
{
  const c = new TestConsole(rom);
  const mid = 1800;
  for (let i = 0; i < mid; i++) c.frame(rec[i]);
  const st = c.saveState();
  const a = []; for (let i = mid; i < mid + 600; i++) { c.frame(rec[i]); a.push(c.ramHash()); }
  c.loadState(st);
  const b = []; for (let i = mid; i < mid + 600; i++) { c.frame(rec[i]); b.push(c.ramHash()); }
  check(a.every((h, i) => h === b[i]), "guardar estado → avanzar → cargar → repetir: RAM idéntica");
  check(a.every((h, i) => h === run1.hashes[mid + i]), "el estado cargado coincide con la partida sin interrupciones");
  // el estado también funciona en otra instancia (lo que haría un dispositivo que se une)
  const d = new TestConsole(rom);
  d.loadState(st);
  const e = []; for (let i = mid; i < mid + 600; i++) { d.frame(rec[i]); e.push(d.ramHash()); }
  check(e.every((h, i) => h === a[i]), "estado transferido a otra consola: RAM idéntica");
  console.log(`      tamaño del estado: ${(st.length / 1024).toFixed(0)} KB (JSON sin comprimir)`);
}

// 3. Velocidad
for (const sound of [false, true]) {
  const c = new TestConsole(rom, { sound });
  const n = 1200, t0 = performance.now();
  for (let i = 0; i < n; i++) c.frame(rec[i + 600]);
  const fps = n / ((performance.now() - t0) / 1000);
  console.log(`      velocidad ${sound ? "con sonido" : "sin sonido"}: ${fps.toFixed(0)} fps (${(fps / 60).toFixed(1)}x tiempo real)`);
}
{
  const c = new TestConsole(rom);
  for (let i = 0; i < 1800; i++) c.frame(rec[i]);
  const n = 100, t0 = performance.now();
  for (let i = 0; i < n; i++) c.saveState();
  const ts = (performance.now() - t0) / n;
  const st = c.saveState(), t1 = performance.now();
  for (let i = 0; i < n; i++) c.loadState(st);
  const tl = (performance.now() - t1) / n;
  console.log(`      guardar estado: ${ts.toFixed(2)} ms, cargar estado: ${tl.toFixed(2)} ms`);
}

process.exitCode = fails ? 1 : 0;
