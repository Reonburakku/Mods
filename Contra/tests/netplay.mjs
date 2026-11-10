// Fase 2: dos (o más) consolas sincronizadas por una red simulada con retardo,
// variación (jitter), pérdida de paquetes y relojes ligeramente distintos.
// Comprueba que la RAM es idéntica en todos los dispositivos en cada fotograma.
// Uso: node tests/netplay.mjs [ruta.nes]
import { readFileSync } from "node:fs";
import { Core, BTN, FPS } from "../web/emu/core.js";
import { Lockstep, ramHash, recommendedDelay } from "../web/net/lockstep.js";
import { rng } from "./lib/console.mjs";

const rom = readFileSync(process.argv[2] ?? "rom/Contra.nes");
let fails = 0;
const check = (ok, msg) => { console.log(`${ok ? "OK   " : "FALLO"} ${msg}`); if (!ok) fails++; };

/**
 * Simula una partida en red.
 * devices: [{id, slots, clock}] clock = velocidad relativa del reloj (1 = exacto)
 */
function simulate({ devices, frames, latency, jitter, loss, delay = 3, seed = 7 }) {
  const r = rng(seed);
  const peerSlots = (me) => Object.fromEntries(devices.filter((d) => d.id !== me).map((d) => [d.id, d.slots]));
  const nodes = devices.map((d) => ({
    ...d,
    core: new Core(rom),
    ls: new Lockstep({ localSlots: d.slots, peerSlots: peerSlots(d.id), delay }),
    lost: 0,             // fotogramas que no se pudieron recuperar
    waitMs: 0,
    hashes: [],
    held: d.slots.map(() => 0),
  }));
  const queue = [];      // {at, to, from, msg}
  const send = (from, to, msg, now) => {
    if (r() < loss) return;
    const json = JSON.stringify(msg);                  // como por la red real
    queue.push({ at: now + latency + r() * jitter, to, from, msg: JSON.parse(json), bytes: json.length });
  };
  let bytes = 0, packets = 0, endTime = 0;
  const MAX_CATCHUP = 4;
  const tickMs = 1000 / FPS;
  // Entradas de prueba: tras arrancar, Start y elegir 2 jugadores; luego aleatorias
  const scripted = (f, slot) => {
    if (slot === 0 && f >= 240 && f < 244) return BTN.START;
    if (slot === 0 && f >= 300 && f < 304) return BTN.SELECT;
    if (slot === 0 && f >= 330 && f < 334) return BTN.START;
    return null;
  };

  for (let now = 0; nodes.some((n) => n.ls.frame < frames); now += 1) {
    // entregar paquetes
    for (let i = queue.length - 1; i >= 0; i--) {
      if (queue[i].at <= now) {
        const p = queue.splice(i, 1)[0];
        nodes.find((n) => n.id === p.to).ls.receive(p.from, p.msg);
        bytes += p.bytes; packets++;
      }
    }
    for (const n of nodes) {
      if (n.ls.frame >= frames) continue;
      // Igual que el bucle del navegador: los fotogramas "debidos" según el reloj;
      // tras una espera se recuperan hasta MAX_CATCHUP de golpe, el resto se pierde.
      const due = Math.floor((now * n.clock) / tickMs) - n.lost;
      if (due - n.ls.frame > MAX_CATCHUP) { n.lost += due - n.ls.frame - MAX_CATCHUP; }
      let ran = false;
      while (n.ls.frame < Math.floor((now * n.clock) / tickMs) - n.lost && n.ls.frame < frames) {
        if (!n.ls.ready()) { n.waitMs++; break; }
        const f = n.ls.frame;
        const local = n.slots.map((s, i) => {
          if (r() < 0.08) n.held[i] = Math.floor(r() * 256) & ~(BTN.START | BTN.SELECT);
          return scripted(f + delay, s) ?? (f + delay > 400 ? n.held[i] : 0);
        });
        const inputs = n.ls.advance(local);
        n.core.frame(inputs);
        ran = true;
        const h = ramHash(n.core.mem);
        n.hashes.push(h);
        if (n.ls.needsHash(f)) {
          const m = n.ls.recordHash(f, h);
          for (const p of n.ls.peers) send(n.id, p, m, now);
        }
      }
      if (ran || now % 16 === 0) for (const [p, m] of n.ls.outgoing()) send(n.id, p, m, now);
    }
    endTime = now;
    if (now > frames * 100) throw new Error("la simulación no avanza (bloqueo)");
  }
  return { nodes, bytes, packets, endTime };
}

function report(name, opts) {
  // el retardo se elige como en la web: a partir del ping medido (aquí, el de la red simulada)
  opts.delay ??= recommendedDelay(2 * (opts.latency + opts.jitter / 2), opts.jitter);
  const t0 = performance.now();
  const { nodes, bytes, packets, endTime } = simulate(opts);
  const ref = nodes[0].hashes;
  const diffAt = Math.min(...nodes.slice(1).map((n) => {
    const i = n.hashes.findIndex((h, k) => h !== ref[k]);
    return i < 0 ? Infinity : i;
  }));
  check(diffAt === Infinity && nodes.every((n) => n.ls.desyncFrame === null),
    `${name}: RAM idéntica en los ${opts.frames} fotogramas en ${nodes.length} dispositivos` +
    (diffAt !== Infinity ? ` (difiere en el fotograma ${diffAt})` : ""));
  const speed = (opts.frames / (endTime / tickMsReal)) * 100;
  console.log(`      retardo ${opts.delay} fotogramas · velocidad del juego ${speed.toFixed(1)}% · ` +
    `${(bytes / packets).toFixed(0)} bytes/paquete · ` +
    `${((performance.now() - t0) / 1000).toFixed(1)} s`);
  return nodes;
}

const tickMsReal = 1000 / FPS;
const FR = 2400;   // 40 s de juego
report("red local (20 ms, sin pérdidas)", {
  devices: [{ id: "A", slots: [0], clock: 1 }, { id: "B", slots: [1], clock: 1 }],
  frames: FR, latency: 10, jitter: 10, loss: 0,
});
report("internet (40-80 ms, 5% pérdidas, relojes ±0,5%)", {
  devices: [{ id: "A", slots: [0], clock: 1.005 }, { id: "B", slots: [1], clock: 0.995 }],
  frames: FR, latency: 40, jitter: 40, loss: 0.05,
});
const bad = report("red mala (100-200 ms, 20% pérdidas)", {
  devices: [{ id: "A", slots: [0], clock: 1 }, { id: "B", slots: [1], clock: 1 }],
  frames: FR, latency: 100, jitter: 100, loss: 0.2,
});
report("4 dispositivos, 1 plaza cada uno (preparado para la ROM de 4 jugadores)", {
  devices: [0, 1, 2, 3].map((s) => ({ id: "ABCD"[s], slots: [s], clock: 1 + (s - 1.5) * 0.002 })),
  frames: 1200, latency: 30, jitter: 30, loss: 0.05,
});
report("2 dispositivos con 2 plazas cada uno", {
  devices: [{ id: "A", slots: [0, 1], clock: 1 }, { id: "B", slots: [2, 3], clock: 1 }],
  frames: 1200, latency: 30, jitter: 30, loss: 0.05,
});

// Un desfase real se detecta: corromper la RAM de un dispositivo
{
  const a = new Lockstep({ localSlots: [0], peerSlots: { B: [1] }, delay: 2 });
  const b = new Lockstep({ localSlots: [1], peerSlots: { A: [0] }, delay: 2 });
  b.receive("A", a.recordHash(60, 111));
  a.receive("B", b.recordHash(60, 222));
  check(a.desyncFrame === 60 && b.desyncFrame === 60, "se detecta una desincronización (hashes distintos)");
}

process.exitCode = fails ? 1 : 0;
