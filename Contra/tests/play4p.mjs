// Fase 3: partida a 4 jugadores con la ROM modificada.
// Uso: node tests/play4p.mjs   -> capturas en tests/out/4p-*.png
import { readFileSync } from "node:fs";
import { TestConsole, BTN } from "./lib/console.mjs";

// Símbolos de la ROM (los genera tools/build.py): nombre -> dirección
const SYM = Object.fromEntries(readFileSync("build/contra.sym", "utf8").trim().split(/\r?\n/)
  .map((l) => { const [ba, name] = l.split(" "); return [name, parseInt(ba.split(":")[1], 16)]; }));

const c = new TestConsole("build/contra.nes");
let fails = 0;
const check = (ok, msg) => { console.log(`${ok ? "OK   " : "FALLO"} ${msg}`); if (!ok) fails++; };
// Direcciones de src/ram4p.inc
const Ctx_Over = 0x606e, Ctx_Spr = 0x6070, Ctx_X = 0x6074, Ctx_Lives = 0x606c;
const ctx = (a, i) => c.ram(a + i);

// En la demo automática del título J3/J4 no pueden entrar
{
  const d = new TestConsole("build/contra.nes");
  d.run(2640, [0, 0, BTN.START, BTN.START]);
  check(d.ram(Ctx_Over) && d.ram(Ctx_Over + 1) && !d.ram(0x607a), "en la demo automática J3/J4 no entran aunque pulsen START");
}

// Título -> "2 PLAYERS" -> empezar
c.run(240);
c.press(0, BTN.START, 4, 60);
c.press(0, BTN.SELECT, 4, 20);
c.press(0, BTN.START, 4, 600);   // presentación del nivel ("STAGE 1")
check(ctx(Ctx_Over, 0) && ctx(Ctx_Over, 1), "J3/J4 empiezan fuera de la partida");

// J3 y J4 pulsan START
const step = (n, inp) => c.run(n, inp);
step(4, [0, 0, BTN.START, BTN.START]);
step(120, [0, 0, 0, 0]);
check(!ctx(Ctx_Over, 0) && !ctx(Ctx_Over, 1), "J3/J4 entran al pulsar START");
check(ctx(Ctx_Lives, 0) === 2 && ctx(Ctx_Lives, 1) === 2, "J3/J4 empiezan con 3 vidas (valor 2)");
c.screenshot("tests/out/4p-1-entran.png");
console.log(`      sprites J3/J4: ${ctx(Ctx_Spr, 0)}, ${ctx(Ctx_Spr, 1)}  X: ${ctx(Ctx_X, 0)}, ${ctx(Ctx_X, 1)}`);

// J3 a la derecha, J4 quieto: la X de J3 debe crecer y la de J4 no
const x3 = ctx(Ctx_X, 0), x4 = ctx(Ctx_X, 1);
step(40, [0, 0, BTN.RIGHT, 0]);
console.log(`      tras 40 fotogramas con J3 a la derecha: X J3 ${x3} -> ${ctx(Ctx_X, 0)}, X J4 ${x4} -> ${ctx(Ctx_X, 1)}`);
check(ctx(Ctx_X, 0) > x3 + 20 && Math.abs(ctx(Ctx_X, 1) - x4) <= 2, "J3 se mueve con el mando 3 y J4 no");
c.screenshot("tests/out/4p-2-j3-derecha.png");

// Todos disparan y avanzan
for (let i = 0; i < 300; i++) {
  const fire = i & 8 ? BTN.B : 0;
  c.frame([BTN.RIGHT | fire, fire, BTN.RIGHT | fire, (i & 64 ? BTN.LEFT : BTN.RIGHT) | fire | (i % 50 < 3 ? BTN.A : 0)]);
}
c.screenshot("tests/out/4p-3-todos.png");
console.log(`      X J1 ${c.ram(0x334)}, J2 ${c.ram(0x335)}, J3 ${ctx(Ctx_X, 0)}, J4 ${ctx(Ctx_X, 1)}`);

// Colores propios: los sprites de J3/J4 van marcados con las paletas extra 1 y 2, y con el
// mismo dibujo que J1 (mismos tiles); sin límite de sprites la simulación no cambia
{
  const ext = c.nes.ppu.spriteExt, oam = c.nes.ppu.spriteMem;
  const tiles = (p) => [...Array(64).keys()].filter((n) => ext[n] === p).map((n) => oam[n * 4 + 1]);
  const t3 = tiles(1), t4 = tiles(2);
  console.log(`      sprites con paleta extra: J3 ${t3.length}, J4 ${t4.length}`);
  check(t3.length >= 3 && t4.length >= 3, "J3/J4 se dibujan con sus paletas extra (verde y amarillo)");
  check(c.ram(0x5046) === 0x1a && c.ram(0x504a) === 0x28, "colores definidos por la ROM: traje verde $1A y amarillo $28");
}

// Solo J3 dispara: aparecen balas en la tabla compartida (tipo de bala en $0388,x)
{
  const bullets = () => [...Array(16).keys()].filter((i) => c.ram(0x388 + i)).length;
  for (let i = 0; i < 30; i++) c.frame([0, 0, i & 4 ? BTN.B : 0, 0]);
  check(bullets() > 0, `J3 dispara (${bullets()} balas activas)`);
}

// J1/J2 quietos, J3/J4 avanzan: la pantalla avanza y arrastra a J1/J2 hacia la izquierda
// (dentro de una pareja, el juego no avanza si el compañero está en el borde izquierdo)
{
  const x1 = c.ram(0x334);
  for (let i = 0; i < 240; i++) c.frame([0, 0, BTN.RIGHT, BTN.RIGHT]);
  console.log(`      J3/J4 empujan: X J1 ${x1} -> ${c.ram(0x334)}, X J3 ${ctx(Ctx_X, 0)}, X J4 ${ctx(Ctx_X, 1)} (estado J4 $91=${c.ram(0x6021)}, Y ${ctx(0x6072, 1)})`);
  // J4 camina a la derecha (+1) y la pantalla avanza (-1): se queda en el mismo sitio de la pantalla
  check(c.ram(0x334) < x1 - 50, "J3/J4 hacen avanzar la pantalla y J1 se desplaza con ella");
  c.screenshot("tests/out/4p-4-j34-empujan.png");
}

// Partida larga a 4 jugadores con entradas aleatorias: sin cuelgues
{
  let r = 12345;
  const rnd = () => ((r = (r * 1103515245 + 12345) & 0x7fffffff) / 0x7fffffff);
  const held = [0, 0, 0, 0];
  let crashed = null;
  try {
    for (let i = 0; i < 7200; i++) {
      for (let p = 0; p < 4; p++) if (rnd() < 0.08) held[p] = Math.floor(rnd() * 256) & ~BTN.SELECT & ~(p < 2 ? BTN.START : 0);
      c.frame(held);
    }
  } catch (e) { crashed = e.message; }
  check(!crashed, "2 minutos a 4 jugadores con entradas aleatorias sin colgarse" + (crashed ? ` (${crashed})` : ""));
  c.screenshot("tests/out/4p-5-aleatorio.png");
  console.log(`      vidas J1-J4: ${c.ram(0x32)}, ${c.ram(0x33)}, ${ctx(Ctx_Lives, 0)}, ${ctx(Ctx_Lives, 1)} · fuera: ${c.ram(0x38)}, ${c.ram(0x39)}, ${ctx(Ctx_Over, 0)}, ${ctx(Ctx_Over, 1)}`);
}

// Los enemigos también dañan a J3/J4: en partidas aleatorias (semillas fijas) J3/J4 deben
// morir en una proporción parecida a J1/J2 (antes solo morían por caídas: ~la mitad).
// Se cuenta en la rutina de muerte del juego (L_D9FA: "dec $32,x" en $DA03, "sta $38,x" en
// $DA08) mirando qué pareja está cargada (Pass34); leer la RAM entre fotogramas no vale porque
// en fotogramas lentos el emulador puede cortar en mitad de un intercambio de contexto.
{
  const deaths = [0, 0, 0, 0], aims = [0, 0];
  for (const seed of [1, 2, 3]) {
    const d = new TestConsole("build/contra.nes");
    const cpu = d.nes.cpu, w = cpu.write.bind(cpu);
    cpu.write = (a, v) => {
      const end = (cpu.REG_PC + 1) & 0xffff;
      if ((end === 0xda05 && (a === 0x32 || a === 0x33)) || (end === 0xda0a && (a === 0x38 || a === 0x39))) {
        deaths[(a & 1) + (cpu.mem[0x6018] ? 2 : 0)]++;
      }
      // puntería: "sta $0A" con la posición del objetivo (L_F557 = J1/J2, T4_y = J3/J4)
      if (a === 0x0a && end === 0xf559) aims[0]++;
      if (a === 0x0a && end === SYM.T4_y + 2) aims[1]++;
      w(a, v);
    };
    d.run(240); d.press(0, BTN.START, 4, 60); d.press(0, BTN.SELECT, 4, 20); d.press(0, BTN.START, 4, 600);
    d.run(4, [0, 0, BTN.START, BTN.START]); d.run(60);
    let r = seed;
    const rnd = () => ((r = (r * 1103515245 + 12345) & 0x7fffffff) / 0x7fffffff);
    const held = [0, 0, 0, 0];
    for (let i = 0; i < 21600; i++) {
      for (let p = 0; p < 4; p++) if (rnd() < 0.08) held[p] = (Math.floor(rnd() * 256) & ~0x30) | BTN.RIGHT;
      const inp = [...held];
      if (d.ram(Ctx_Over)) inp[2] |= BTN.START;
      if (d.ram(Ctx_Over + 1)) inp[3] |= BTN.START;
      d.frame(inp);
    }
  }
  console.log(`      muertes en 3 partidas aleatorias de 6 min: J1 ${deaths[0]}, J2 ${deaths[1]}, J3 ${deaths[2]}, J4 ${deaths[3]}`);
  const a = deaths[0] + deaths[1], b = deaths[2] + deaths[3];
  check(b >= a * 0.6, "los enemigos dañan a J3/J4 (mueren en proporción parecida a J1/J2)");
  console.log(`      disparos apuntados: a J1/J2 ${aims[0]}, a J3/J4 ${aims[1]}`);
  check(aims[1] > 0 && aims[1] >= (aims[0] + aims[1]) * 0.25, "los enemigos también apuntan a J3/J4");
}

// Reglas de 4 jugadores: game over solo sin nadie; J3/J4 entran una vez por partida;
// continuar tras el game over les deja volver a entrar
{
  const g = new TestConsole("build/contra.nes");
  const m = g.nes.cpu.mem;
  g.run(240); g.press(0, BTN.START, 4, 60); g.press(0, BTN.SELECT, 4, 20); g.press(0, BTN.START, 4, 600);
  g.run(4, [0, 0, BTN.START, BTN.START]); g.run(60);
  m[0x38] = 1; m[0x39] = 1; m[0x32] = 0; m[0x33] = 0;            // J1/J2 eliminados
  g.run(300, [0, 0, BTN.RIGHT, BTN.RIGHT]);
  check(g.ram(0x2c) === 4 && g.ram(0x607a) !== 0, "J1/J2 eliminados y J3/J4 vivos: la partida sigue");
  m[Ctx_Over + 1] = 1;                                            // J4 eliminado
  g.run(60, [0, 0, 0, BTN.START]);
  check(g.ram(Ctx_Over + 1) === 1, "J4 no puede volver a entrar con START en la misma partida");
  check(g.ram(0x2c) === 4, "queda J3: la partida sigue");
  m[Ctx_Over] = 1;                                                // J3 eliminado: no queda nadie
  g.run(10);
  check(g.ram(0x2c) !== 4, "sin nadie en juego: game over");
  // pantalla de game over -> CONTINUE (Start) -> J3/J4 pueden volver a entrar
  g.run(400);
  g.press(0, BTN.START, 4, 700);
  g.run(4, [0, 0, BTN.START, 0]); g.run(30);
  check(g.ram(Ctx_Over) === 0, "tras continuar, J3 puede volver a entrar con START");
  g.screenshot("tests/out/4p-continuar.png");
}

// Puntos: van a quien dispara. Todos avanzan (si no, el compañero en el borde frena la
// pantalla y no llegan enemigos) y solo uno dispara. J3/J4 tienen marcador propio
// (Score34 $6080/$6082); recoger armas también da puntos, por eso se compara con margen.
{
  const score = (g) => [0x7e2, 0x7e4, 0x6080, 0x6082].map((a) => g.ram(a) | g.ram(a + 1) << 8);
  const results = [];
  for (const shooter of [0, 2, 3]) {
    const g = new TestConsole("build/contra.nes");
    g.core.nes.setOverclock(60); g.core.overclock = 60;
    g.run(240); g.press(0, BTN.START, 4, 60); g.press(0, BTN.SELECT, 4, 20); g.press(0, BTN.START, 4, 600);
    g.run(4, [0, 0, BTN.START, BTN.START]); g.run(120);
    for (let i = 0; i < 3000; i++) {
      const move = (i % 240) < 160 ? BTN.RIGHT : 0;
      const inp = [move, move, move, move];
      inp[shooter] |= i & 4 ? BTN.B : 0;
      g.frame(inp);
    }
    const sc = score(g);
    results.push(`J${shooter + 1} dispara: ${sc.join(", ")}`);
    const others = sc.filter((_, k) => k !== shooter);
    check(sc[shooter] > Math.max(...others), `los puntos de J${shooter + 1} van a su marcador`);
  }
  console.log(`      puntos J1-J4 (x100): ${results.join(" · ")}`);
}

// Robo de vidas (A estando fuera): dentro de la pareja como el original y, si el compañero
// no puede dar, a la otra pareja
{
  const setup = (joinJ34 = true) => {
    const g = new TestConsole("build/contra.nes");
    g.run(240); g.press(0, BTN.START, 4, 60); g.press(0, BTN.SELECT, 4, 20); g.press(0, BTN.START, 4, 600);
    if (joinJ34) { g.run(4, [0, 0, BTN.START, BTN.START]); g.run(120); }
    return g;
  };
  const pressA = (g, slot) => { const inp = [0, 0, 0, 0]; inp[slot] = BTN.A; g.run(2, inp); g.run(30); };
  const m = (g) => g.nes.cpu.mem;
  // J1 fuera y J2 sin vidas que dar: J1 recibe una vida de J3
  {
    const g = setup();
    m(g)[0x38] = 1; m(g)[0x32] = 0; m(g)[0x33] = 0;
    m(g)[Ctx_Lives] = 2;
    pressA(g, 0);
    check(g.ram(0x38) === 0 && g.ram(Ctx_Lives) === 1, "J1 fuera pide vida con A y se la da J3");
  }
  // J3 fuera y J4 sin vidas que dar: J3 recibe una vida de J1
  {
    const g = setup();
    m(g)[Ctx_Over] = 1; m(g)[Ctx_Lives] = 0; m(g)[Ctx_Lives + 1] = 0;
    m(g)[0x32] = 2;
    pressA(g, 2);
    check(g.ram(Ctx_Over) === 0 && g.ram(0x32) === 1, "J3 fuera pide vida con A y se la da J1");
  }
  // J3 sin haber entrado nunca: no puede pedir vida
  {
    const g = setup(false);
    m(g)[0x32] = 2;
    pressA(g, 2);
    check(g.ram(Ctx_Over) === 1 && g.ram(0x32) === 2, "J3 sin haber entrado no puede pedir vida");
  }
  // Dentro de la pareja manda el original: J2 fuera pide a J1 y J3/J4 no pierden nada
  {
    const g = setup();
    m(g)[0x39] = 1; m(g)[0x33] = 0; m(g)[0x32] = 2;
    m(g)[Ctx_Lives] = 2; m(g)[Ctx_Lives + 1] = 2;
    pressA(g, 1);
    check(g.ram(0x39) === 0 && g.ram(0x32) === 1 && g.ram(Ctx_Lives) === 2 && g.ram(Ctx_Lives + 1) === 2,
      "J2 fuera recibe la vida de J1 (como el original) sin tocar a J3/J4");
  }
}

// Empezar en otro nivel (Contra no tiene selector): se mantiene $30 durante la presentación
function startAtStage(stage) {
  const g = new TestConsole("build/contra.nes");
  g.core.nes.setOverclock(60); g.core.overclock = 60;
  g.run(240); g.press(0, BTN.START, 4, 60); g.press(0, BTN.SELECT, 4, 20); g.run(4, [BTN.START, 0, 0, 0]);
  for (let i = 0; i < 700; i++) { if (g.ram(0x2c) < 2) g.nes.cpu.mem[0x30] = stage; g.frame([0, 0, 0, 0]); }
  g.run(4, [0, 0, BTN.START, BTN.START]);
  return g;
}

// Base (nivel 2): J3/J4 aparecen separados de J1/J2 (si no, se taparían)
{
  const g = startAtStage(1);
  g.run(60);
  const x = [g.ram(0x334), g.ram(0x335), g.ram(Ctx_X), g.ram(Ctx_X + 1)];
  console.log(`      base: X de aparición J1-J4: ${x.join(", ")}`);
  check(g.ram(0x40) !== 0 && x[2] === x[0] - 24 && x[3] === x[1] + 24, "en la base J3/J4 aparecen a 24 píxeles de J1/J2");
}

// Cascada (nivel 3): si solo J3/J4 hacen subir la pantalla, J1/J2 bajan con ella
{
  const g = startAtStage(2);
  g.run(150);
  let r = 5;
  const rnd = () => ((r = (r * 1103515245 + 12345) & 0x7fffffff) / 0x7fffffff);
  const held = [0, 0, 0, 0];
  let pushB = 0, j1down = 0;
  for (let i = 0; i < 2400; i++) {
    for (const p of [2, 3]) if (rnd() < 0.15) held[p] = BTN.UP | BTN.B | (rnd() < 0.6 ? BTN.A : 0) | (rnd() < 0.3 ? BTN.LEFT : rnd() < 0.5 ? BTN.RIGHT : 0);
    const y = g.ram(0x31a);
    g.frame(held);
    if (g.ram(0x6079) && !g.ram(0x6078)) { pushB++; if (g.ram(0x31a) > y) j1down++; }
  }
  console.log(`      cascada: ${pushB} fotogramas empujando solo J3/J4; en ${j1down} J1 bajó`);
  check(g.ram(0x41) !== 0 && pushB > 0 && j1down > 0, "en la cascada J3/J4 hacen subir la pantalla y J1/J2 bajan con ella");
}

process.exitCode = fails ? 1 : 0;
