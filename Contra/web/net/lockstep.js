// Capa 4: sincronización por entradas (lockstep con retardo de entrada).
//
// Cada dispositivo ejecuta el juego completo. Solo viajan los botones: lo que un
// jugador pulsa en el fotograma F se aplica en el fotograma F + delay en TODOS los
// dispositivos. Un fotograma solo se ejecuta cuando están las entradas de todas las
// plazas, así que todos simulan exactamente lo mismo.
//
// Fiabilidad sin depender del transporte: cada paquete repite todas las entradas
// que el otro todavía no ha confirmado (campo "a" = último fotograma recibido sin
// huecos), así que una pérdida se recupera en el siguiente paquete.
//
// Sin DOM ni red: la usan la web (con WebRTC) y las pruebas (con una red simulada).

export const MAX_SLOTS = 4;
const MAX_FRAMES_PER_PACKET = 120;

export class Lockstep {
  /**
   * @param {object} o
   * @param {number[]} o.localSlots   plazas (0-3) que controla este dispositivo
   * @param {Record<string, number[]>} o.peerSlots  plazas de cada otro dispositivo
   * @param {number} [o.delay]        retardo de entrada en fotogramas
   * @param {number} [o.hashInterval] cada cuántos fotogramas comparar la RAM
   */
  constructor({ localSlots, peerSlots, delay = 3, hashInterval = 60 }) {
    this.localSlots = localSlots;
    this.peerSlots = peerSlots;
    this.delay = delay;
    this.hashInterval = hashInterval;
    this.frame = 0;                       // siguiente fotograma a ejecutar
    this.activeMask = 0;                  // plazas en juego
    for (const s of [...localSlots, ...Object.values(peerSlots).flat()]) this.activeMask |= 1 << s;
    this.inputs = new Map();              // fotograma -> Uint8Array(MAX_SLOTS)
    this.known = new Map();               // fotograma -> máscara de plazas recibidas
    this.lastLocal = delay - 1;           // último fotograma con entrada local fijada
    this.received = {};                   // peer -> último fotograma recibido sin huecos
    this.acked = {};                      // peer -> último fotograma nuestro que ha confirmado
    this.localHashes = new Map();
    this.remoteHashes = new Map();        // fotograma -> {peer: hash}
    this.desyncFrame = null;
    this.stalls = 0;
    for (const p of Object.keys(peerSlots)) { this.received[p] = delay - 1; this.acked[p] = delay - 1; }
    // Los primeros "delay" fotogramas no tienen entradas de nadie: sin botones
    for (let f = 0; f < delay; f++) {
      this.inputs.set(f, new Uint8Array(MAX_SLOTS));
      this.known.set(f, this.activeMask);
    }
  }

  get peers() { return Object.keys(this.peerSlots); }

  /** ¿Están todas las entradas del siguiente fotograma? */
  ready() {
    return this.known.get(this.frame) === this.activeMask;
  }

  /**
   * Ejecuta un paso: fija la entrada local (para frame + delay) y devuelve las
   * entradas del fotograma actual. Llamar solo si ready().
   * @param {number[]} local  bytes de los jugadores locales, en el orden de localSlots
   * @returns {Uint8Array} entradas de las 4 plazas para este fotograma
   */
  advance(local) {
    if (!this.ready()) throw new Error(`fotograma ${this.frame} sin todas las entradas`);
    const target = this.frame + this.delay;
    if (target > this.lastLocal) {
      const row = this.row(target);
      this.localSlots.forEach((s, i) => { row[s] = local[i] | 0; });
      this.mark(target, this.localSlots);
      this.lastLocal = target;
    }
    const out = this.inputs.get(this.frame);
    // olvidar fotogramas antiguos que ya nadie va a pedir
    const old = this.frame - MAX_FRAMES_PER_PACKET * 2;
    this.inputs.delete(old);
    this.known.delete(old);
    this.frame++;
    return out;
  }

  /** Mensajes a enviar ahora: [peerId, mensaje][] */
  outgoing() {
    const msgs = [];
    for (const p of this.peers) {
      const from = this.acked[p] + 1;
      const to = Math.min(this.lastLocal, from + MAX_FRAMES_PER_PACKET - 1);
      const v = [];
      for (let f = from; f <= to; f++) {
        const row = this.inputs.get(f);
        for (const s of this.localSlots) v.push(row[s]);
      }
      msgs.push([p, { t: "in", f: from, v, a: this.received[p] }]);
    }
    return msgs;
  }

  /** Procesa un mensaje de otro dispositivo. */
  receive(peer, msg) {
    if (!(peer in this.peerSlots)) return;
    if (msg.t === "in") {
      const slots = this.peerSlots[peer];
      const n = slots.length;
      for (let i = 0; i * n < msg.v.length; i++) {
        const f = msg.f + i;
        if (f < this.frame) continue;                 // ya ejecutado
        const row = this.row(f);
        slots.forEach((s, k) => { row[s] = msg.v[i * n + k]; });
        this.mark(f, slots);
      }
      const slotMask = slots.reduce((m, s) => m | (1 << s), 0);
      let r = this.received[peer];
      while (((this.known.get(r + 1) ?? 0) & slotMask) === slotMask) r++;
      this.received[peer] = r;
      if (msg.a > this.acked[peer]) this.acked[peer] = msg.a;
    } else if (msg.t === "h") {
      let m = this.remoteHashes.get(msg.f);
      if (!m) this.remoteHashes.set(msg.f, (m = {}));
      m[peer] = msg.h;
      this.checkHash(msg.f);
    }
  }

  /**
   * Llamar tras ejecutar cada fotograma con el hash de la RAM (o null para no
   * calcularlo). Devuelve un mensaje de hash para difundir, o null.
   */
  needsHash(frameJustRun) { return frameJustRun % this.hashInterval === 0; }

  recordHash(frame, h) {
    this.localHashes.set(frame, h);
    this.localHashes.delete(frame - this.hashInterval * 10);
    this.checkHash(frame);
    return { t: "h", f: frame, h };
  }

  checkHash(frame) {
    const mine = this.localHashes.get(frame);
    const theirs = this.remoteHashes.get(frame);
    if (mine === undefined || !theirs) return;
    for (const h of Object.values(theirs)) {
      if (h !== mine && this.desyncFrame === null) this.desyncFrame = frame;
    }
    if (Object.keys(theirs).length === this.peers.length) this.remoteHashes.delete(frame);
  }

  /** Plazas de las que falta la entrada del siguiente fotograma (para mostrar "esperando a…"). */
  waitingFor() {
    const have = this.known.get(this.frame) ?? 0;
    return this.peers.filter((p) => this.peerSlots[p].some((s) => !(have & (1 << s))));
  }

  row(f) {
    let r = this.inputs.get(f);
    if (!r) this.inputs.set(f, (r = new Uint8Array(MAX_SLOTS)));
    return r;
  }

  mark(f, slots) {
    let m = this.known.get(f) ?? 0;
    for (const s of slots) m |= 1 << s;
    this.known.set(f, m);
  }
}

/** Hash rápido (FNV-1a 32 bits) de la RAM del juego: interna $0000-$07FF y extra $6000-$7FFF. */
export function ramHash(mem) {
  let h = 0x811c9dc5;
  for (let i = 0; i < 0x800; i++) h = Math.imul(h ^ mem[i], 0x01000193);
  for (let i = 0x6000; i < 0x8000; i++) h = Math.imul(h ^ mem[i], 0x01000193);
  return h >>> 0;
}

/**
 * Retardo de entrada recomendado según la latencia medida entre dispositivos.
 * Las entradas tienen que llegar antes de que el otro las necesite: medio viaje de ida
 * y vuelta + variación + un fotograma de margen.
 * @param {number} rttMs  ida y vuelta (el peor de los dispositivos)
 * @param {number} jitterMs variación observada del rtt
 */
export function recommendedDelay(rttMs, jitterMs = 0) {
  const frameMs = 1000 / 60.0988;
  return Math.min(12, Math.max(2, Math.ceil((rttMs / 2 + jitterMs) / frameMs) + 1));
}
