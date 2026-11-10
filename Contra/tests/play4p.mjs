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

process.exitCode = fails ? 1 : 0;
