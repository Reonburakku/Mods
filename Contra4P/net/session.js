// Capa 3 + sala: conexión entre navegadores (WebRTC vía Trystero) y protocolo de sala.
//
// - Quien crea la sala es el anfitrión: reparte las plazas y da la salida.
// - Todos se conectan con todos (malla); la señalización usa relays públicos de
//   Nostr y después el tráfico va directo entre navegadores.
// - Durante la partida solo viajan los mensajes de Lockstep ("in" y "h").
import { joinRoom, selfId } from "./vendor/trystero-nostr/index.mjs";
import { Lockstep, recommendedDelay } from "./lockstep.js";
import { LOCAL_LOOPBACK, FORCE_RELAY } from "../config.js";

const APP_ID = "contra4p-netplay-v1";
// Canal propio para la partida, sin fiabilidad ni orden (como UDP): el lockstep ya
// repite lo que falta, y un canal fiable se atasca con cualquier pérdida (sobre todo
// a través de un TURN) y acumula segundos de retraso. Se negocia con un id fijo en la
// misma conexión de Trystero, sin renegociar.
const FAST_CHANNEL_ID = 77;
const RESEND_MS = 50;              // sin novedades: repetir cada 50 ms (pérdidas y confirmaciones)
const MAX_BUFFERED = 8 * 1024;     // si el canal tiene esto pendiente, no añadir más
const MSG_IN = 1, MSG_HASH = 2;

/** "in" -> [1, f(4), a(4), v...]; "h" -> [2, f(4), h(4)] */
function encode(m) {
  if (m.t === "in") {
    const b = new Uint8Array(9 + m.v.length);
    const d = new DataView(b.buffer);
    b[0] = MSG_IN; d.setUint32(1, m.f); d.setInt32(5, m.a);
    b.set(m.v, 9);
    return b;
  }
  const b = new Uint8Array(9);
  const d = new DataView(b.buffer);
  b[0] = MSG_HASH; d.setUint32(1, m.f); d.setUint32(5, m.h);
  return b;
}

function decode(buf) {
  const b = new Uint8Array(buf);
  if (b.length < 9) return null;
  const d = new DataView(b.buffer, b.byteOffset, b.byteLength);
  if (b[0] === MSG_IN) return { t: "in", f: d.getUint32(1), a: d.getInt32(5), v: [...b.subarray(9)] };
  if (b[0] === MSG_HASH) return { t: "h", f: d.getUint32(1), h: d.getUint32(5) };
  return null;
}
const CODE_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";   // sin O/0, I/1
export const MAX_LOCAL_PLAYERS = 2;

export function newRoomCode() {
  const r = crypto.getRandomValues(new Uint8Array(6));
  return [...r].map((b) => CODE_CHARS[b % CODE_CHARS.length]).join("");
}

export function normalizeCode(s) {
  return (s ?? "").toUpperCase().replace(/[^A-Z0-9]/g, "").slice(0, 12);
}

export function netplaySupported() {
  if (!globalThis.RTCPeerConnection) return "Este navegador no permite conexiones WebRTC.";
  if (!globalThis.crypto?.subtle) {
    return "El juego en red necesita una conexión segura: abre la página con https:// (o en localhost).";
  }
  return null;
}

function connectionHelp(error, hasTurn) {
  if (/after exchanging SDP/.test(error)) {
    return "No se pudo establecer la conexión directa entre los dos navegadores. " +
      "Prueba sin VPN o en otra red" +
      (hasTurn ? "." : ", o configura un servidor TURN (?turn=turn:host:3478|usuario|clave).");
  }
  return `No se pudo entrar en la sala: ${error}`;
}

export class NetSession {
  /**
   * @param {object} o
   * @param {string} o.code       código de sala
   * @param {boolean} o.host      true si este dispositivo la crea
   * @param {{name: string, local: number, sha1: string, version: string}} o.me
   * @param {number} o.maxPlayers plazas que admite la ROM (2 el Contra original, 4 la modificada)
   * @param {RTCIceServer[]} o.turn servidores TURN (ver loadTurnServers en config.js)
   */
  constructor({ code, host, me, maxPlayers, overclock = 0, turn = [] }) {
    this.code = code;
    this.isHost = host;
    this.me = { ...me };
    this.maxPlayers = maxPlayers;
    this.overclock = overclock;     // solo cuenta el del anfitrión
    this.selfId = selfId;
    this.hostId = host ? selfId : null;
    this.peers = new Map();         // peerId -> {name, local, sha1, version}
    this.players = [];              // lista de la sala (la decide el anfitrión)
    this.lockstep = null;
    this.game = null;               // {slots, delay} al empezar
    this.pings = new Map();         // peerId -> ms
    this.fast = new Map();          // peerId -> RTCDataChannel sin fiabilidad
    this.links = new Map();         // peerId -> {relay, rtt}: ruta real de la conexión
    this.sent = new Map();          // peerId -> {at, upTo, frame}: último envío de entradas
    // callbacks
    this.onLobby = () => {};        // la sala ha cambiado
    this.onStart = () => {};        // empieza la partida
    this.onPeerLeft = () => {};     // (peerId, name) se ha ido alguien
    this.onError = () => {};

    this.room = joinRoom({
      appId: APP_ID,
      password: code,
      turnConfig: turn,
      // Todas las rutas (candidatos ICE) dentro de la oferta, en un solo mensaje. Con
      // candidatos sueltos ("trickle"), los relays de Nostr pueden perder o frenar alguno
      // y entonces los navegadores no encuentran la ruta directa aunque exista.
      trickleIce: false,
      rtcConfig: FORCE_RELAY ? { iceTransportPolicy: "relay" } : undefined,
      // opción interna de Trystero 0.26 (vendor fijado): candidatos "*.local" -> 127.0.0.1
      _test_only_mdnsHostFallbackToLoopback: LOCAL_LOOPBACK,
    }, code, {
      onJoinError: (e) => this.onError(connectionHelp(e.error, turn.length > 0)),
    });
    this.ctl = this.room.makeAction("ctl");
    this.net = this.room.makeAction("game");
    this.ctl.onMessage = (msg, { peerId }) => this.onCtl(peerId, msg);
    this.net.onMessage = (msg, { peerId }) => this.lockstep?.receive(peerId, msg);
    this.room.onPeerJoin = (peerId) => { this.openFast(peerId); this.sendHello(peerId); };
    this.room.onPeerLeave = (peerId) => this.onLeave(peerId);
    this.updateLobby();
    this.pingTimer = setInterval(() => this.measurePings(), 2000);
  }

  // ------------------------------------------------------------------ sala
  sendHello(target) {
    this.ctl.send({ t: "hello", ...this.me, host: this.isHost }, { target }).catch(() => {});
  }

  /** Cambia nombre o nº de jugadores locales y avisa a los demás. */
  setMe(changes) {
    Object.assign(this.me, changes);
    for (const p of this.peers.keys()) this.sendHello(p);
    this.updateLobby();
  }

  onCtl(peerId, msg) {
    if (msg.t === "hello") {
      this.peers.set(peerId, {
        name: String(msg.name ?? "Jugador").slice(0, 16),
        local: Math.min(MAX_LOCAL_PLAYERS, Math.max(1, msg.local | 0)),
        sha1: msg.sha1, version: msg.version,
      });
      if (msg.host) this.hostId = peerId;
      this.updateLobby();
    } else if (msg.t === "start" && peerId === this.hostId && !this.lockstep) {
      this.begin(msg);
    }
  }

  /**
   * Ruta que usa la conexión con un dispositivo, según las estadísticas de WebRTC:
   * relay = pasa por el servidor TURN; rtt = ida y vuelta en ms (null si no se sabe).
   */
  async linkInfo(peerId) {
    const pc = this.room.getPeers()[peerId];
    if (!pc?.getStats) return null;
    try {
      const stats = await pc.getStats();
      let pair = null;
      stats.forEach((r) => {
        if (r.type === "transport" && r.selectedCandidatePairId) pair = stats.get(r.selectedCandidatePairId);
      });
      if (!pair) stats.forEach((r) => { if (r.type === "candidate-pair" && r.nominated && r.state === "succeeded") pair = r; });
      if (!pair) return null;
      const local = stats.get(pair.localCandidateId), remote = stats.get(pair.remoteCandidateId);
      return {
        relay: local?.candidateType === "relay" || remote?.candidateType === "relay",
        rtt: pair.currentRoundTripTime != null ? Math.round(pair.currentRoundTripTime * 1000) : null,
      };
    } catch { return null; }
  }

  /** Abre el canal rápido con un dispositivo (los dos lados lo crean con el mismo id). */
  openFast(peerId) {
    if (this.fast.has(peerId)) return;
    const pc = this.room.getPeers()[peerId];
    if (!pc) return;
    try {
      const ch = pc.createDataChannel("contra4p-fast", {
        negotiated: true, id: FAST_CHANNEL_ID, ordered: false, maxRetransmits: 0,
      });
      ch.binaryType = "arraybuffer";
      ch.onmessage = (e) => {
        const msg = decode(e.data);
        if (msg) this.lockstep?.receive(peerId, msg);
      };
      this.fast.set(peerId, ch);
    } catch (e) {
      console.warn("Sin canal rápido; se usa el canal fiable:", e);
    }
  }

  /** Envía un mensaje de partida: por el canal rápido si está abierto, si no por el fiable. */
  sendGame(peerId, msg) {
    const ch = this.fast.get(peerId);
    if (ch?.readyState === "open") {
      if (ch.bufferedAmount <= MAX_BUFFERED) ch.send(encode(msg));
      return;
    }
    this.net.send(msg, { target: peerId }).catch(() => {});
  }

  onLeave(peerId) {
    this.fast.get(peerId)?.close();
    this.fast.delete(peerId);
    this.sent.delete(peerId);
    const info = this.peers.get(peerId);
    this.peers.delete(peerId);
    this.pings.delete(peerId);
    this.links.delete(peerId);
    if (this.lockstep && this.game.slots[peerId]) this.onPeerLeft(peerId, info?.name ?? "?");
    if (peerId === this.hostId && !this.lockstep) this.onError("El anfitrión ha cerrado la sala.");
    this.updateLobby();
  }

  /** Lista de dispositivos de la sala, anfitrión primero, con sus plazas previstas. */
  updateLobby() {
    const devices = [{ id: this.selfId, ...this.me, self: true }];
    for (const [id, p] of this.peers) devices.push({ id, ...p, self: false });
    devices.sort((a, b) => (b.id === this.hostId) - (a.id === this.hostId) || a.id.localeCompare(b.id));
    let next = 0;
    this.players = devices.map((d) => {
      const romOk = d.sha1 === this.me.sha1;
      const slots = [];
      for (let i = 0; i < d.local && romOk && next < this.maxPlayers; i++) slots.push(next++);
      return { ...d, host: d.id === this.hostId, romOk, slots, ping: this.pings.get(d.id), link: this.links.get(d.id) };
    });
    this.onLobby(this.players);
  }

  /** ¿Puede el anfitrión empezar? Devuelve null o el motivo por el que no. */
  cannotStart() {
    const inGame = this.players.filter((p) => p.slots.length);
    if (inGame.length < 2) return "Hace falta al menos otro dispositivo en la sala.";
    if (this.players.some((p) => !p.romOk)) return "Algún dispositivo tiene otra versión de la ROM.";
    const wanted = this.players.reduce((n, p) => n + p.local, 0);
    if (wanted > this.maxPlayers) return `Esta ROM admite ${this.maxPlayers} jugadores y hay ${wanted}.`;
    return null;
  }

  async measurePings() {
    for (const id of this.peers.keys()) {
      try {
        this.pings.set(id, await this.room.ping(id));
      } catch { /* desconectado */ }
      const link = await this.linkInfo(id);
      if (link) this.links.set(id, link);
    }
    if (!this.lockstep) this.updateLobby();
  }

  /** Solo el anfitrión: mide la latencia, decide el retardo y da la salida. */
  async start() {
    if (!this.isHost || this.cannotStart()) return;
    const samples = [];
    for (let i = 0; i < 8; i++) {
      for (const id of this.peers.keys()) {
        try { samples.push(await this.room.ping(id)); } catch { /* ignorar */ }
      }
    }
    samples.sort((a, b) => a - b);
    // mediana como latencia típica; la variación, hasta el percentil 90
    const rtt = samples.length ? samples[Math.floor(samples.length / 2)] : 100;
    const jitter = samples.length ? samples[Math.floor(samples.length * 0.9)] - rtt : 20;
    const slots = Object.fromEntries(this.players.filter((p) => p.slots.length).map((p) => [p.id, p.slots]));
    const msg = { t: "start", slots, delay: recommendedDelay(rtt, jitter), rtt, overclock: this.overclock };
    await this.ctl.send(msg, { target: Object.keys(slots).filter((id) => id !== this.selfId) });
    this.begin(msg);
  }

  begin(msg) {
    const mine = msg.slots[this.selfId];
    if (!mine) { this.onError("La partida ha empezado sin este dispositivo."); return; }
    const peerSlots = { ...msg.slots };
    delete peerSlots[this.selfId];
    this.game = { slots: msg.slots, delay: msg.delay, rtt: msg.rtt, overclock: msg.overclock | 0 };
    this.lockstep = new Lockstep({ localSlots: mine, peerSlots, delay: msg.delay });
    this.onStart(this.game);
  }

  // ------------------------------------------------------------------ partida
  /**
   * Envía las entradas pendientes y, si lo hay, un hash. Se llama en cada vuelta del
   * bucle (60-144 veces por segundo), pero solo envía a cada dispositivo cuando hay
   * algo nuevo (entrada local o confirmación) y como mucho una vez por fotograma;
   * sin novedades, repite cada RESEND_MS para recuperar pérdidas.
   */
  flush(hashMsg = null) {
    const ls = this.lockstep;
    const now = performance.now();
    // solo a los dispositivos que siguen conectados (tras una desconexión no hay a quién enviar)
    for (const [peer, m] of ls.outgoing()) {
      if (!this.peers.has(peer)) continue;
      if (!this.fast.has(peer)) this.openFast(peer);
      const last = this.sent.get(peer);
      const fresh = !last || ls.lastLocal !== last.upTo || ls.received[peer] !== last.ack;
      const sameFrame = last && last.frame === ls.frame;
      if (last && (sameFrame || !fresh) && now - last.at < RESEND_MS) continue;
      this.sendGame(peer, m);
      this.sent.set(peer, { at: now, upTo: ls.lastLocal, ack: ls.received[peer], frame: ls.frame });
    }
    if (hashMsg) for (const p of ls.peers) if (this.peers.has(p)) this.sendGame(p, hashMsg);
  }

  nameOf(peerId) { return this.peers.get(peerId)?.name ?? "?"; }

  leave() {
    clearInterval(this.pingTimer);
    for (const ch of this.fast.values()) ch.close();
    this.room.leave().catch(() => {});
  }
}
