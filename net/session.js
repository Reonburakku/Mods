// Capa 3 + sala: conexión entre navegadores (WebRTC vía Trystero) y protocolo de sala.
//
// - Quien crea la sala es el anfitrión: reparte las plazas y da la salida.
// - Todos se conectan con todos (malla); la señalización usa relays públicos de
//   Nostr y después el tráfico va directo entre navegadores.
// - Durante la partida solo viajan los mensajes de Lockstep ("in" y "h").
import { joinRoom, selfId } from "./vendor/trystero-nostr/index.mjs";
import { Lockstep, recommendedDelay } from "./lockstep.js";
import { TURN_SERVERS, LOCAL_LOOPBACK } from "../config.js";

const APP_ID = "contra4p-netplay-v1";
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

function connectionHelp(error) {
  if (/after exchanging SDP/.test(error)) {
    return "No se pudo establecer la conexión directa entre los dos navegadores. " +
      "Prueba sin VPN, en otra red, o configura un servidor TURN (?turn=turn:host:3478|usuario|clave).";
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
   */
  constructor({ code, host, me, maxPlayers, overclock = 0 }) {
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
    // callbacks
    this.onLobby = () => {};        // la sala ha cambiado
    this.onStart = () => {};        // empieza la partida
    this.onPeerLeft = () => {};     // (peerId, name) se ha ido alguien
    this.onError = () => {};

    this.room = joinRoom({
      appId: APP_ID,
      password: code,
      turnConfig: TURN_SERVERS,
      // opción interna de Trystero 0.26 (vendor fijado): candidatos "*.local" -> 127.0.0.1
      _test_only_mdnsHostFallbackToLoopback: LOCAL_LOOPBACK,
    }, code, {
      onJoinError: (e) => this.onError(connectionHelp(e.error)),
    });
    this.ctl = this.room.makeAction("ctl");
    this.net = this.room.makeAction("game");
    this.ctl.onMessage = (msg, { peerId }) => this.onCtl(peerId, msg);
    this.net.onMessage = (msg, { peerId }) => this.lockstep?.receive(peerId, msg);
    this.room.onPeerJoin = (peerId) => this.sendHello(peerId);
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

  onLeave(peerId) {
    const info = this.peers.get(peerId);
    this.peers.delete(peerId);
    this.pings.delete(peerId);
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
      return { ...d, host: d.id === this.hostId, romOk, slots, ping: this.pings.get(d.id) };
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
  /** Envía las entradas pendientes y, si lo hay, un hash. */
  flush(hashMsg = null) {
    // solo a los dispositivos que siguen conectados (tras una desconexión no hay a quién enviar)
    for (const [peer, m] of this.lockstep.outgoing()) {
      if (this.peers.has(peer)) this.net.send(m, { target: peer }).catch(() => {});
    }
    const live = this.lockstep.peers.filter((p) => this.peers.has(p));
    if (hashMsg && live.length) this.net.send(hashMsg, { target: live }).catch(() => {});
  }

  nameOf(peerId) { return this.peers.get(peerId)?.name ?? "?"; }

  leave() {
    clearInterval(this.pingTimer);
    this.room.leave().catch(() => {});
  }
}
