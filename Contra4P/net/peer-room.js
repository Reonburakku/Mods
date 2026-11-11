// Sala P2P con PeerJS (como PortNes): todos conectados con todos (malla, hasta 4).
//
// - El servidor público de PeerJS solo sirve para encontrarse (señalización por WebSocket,
//   sin perder mensajes); después el tráfico va directo entre navegadores (o por el TURN
//   si la conexión directa no es posible).
// - El anfitrión se registra con un id derivado del código de sala; los demás se conectan
//   a él y el anfitrión les pasa la lista de miembros. Entre invitados llama el de id menor,
//   así no hay conexiones duplicadas.
// - Primero se intenta la conexión directa SIN servidor TURN (como PortNes): si el
//   navegador tiene un TURN desde el principio puede quedarse con la ruta del relay
//   (cientos de ms) aunque haya una directa. Solo si un invitado no consigue conectar
//   con el anfitrión en DIRECT_TIMEOUT_MS, vuelve a entrar con el TURN. Basta con que
//   un lado tenga la ruta del relay, así que el anfitrión no lo necesita.
// - Expone lo que usa la sala (session.js): selfId, makeAction, ping, getPeers,
//   onPeerJoin/onPeerLeave y leave.

const SCRIPT_URL = new URL("./vendor/peerjs/peerjs.min.js", import.meta.url);
const CONNECT_TIMEOUT_MS = 20000;
const DIRECT_TIMEOUT_MS = 20000;  // como PortNes: la ruta directa puede tardar en abrirse
const PING_TIMEOUT_MS = 5000;
const MAX_BUFFERED = 1024 * 1024;

let peerjsLoading = null;
function loadPeerJS() {
  if (globalThis.Peer) return Promise.resolve(globalThis.Peer);
  return (peerjsLoading ??= new Promise((resolve, reject) => {
    const s = document.createElement("script");
    s.src = SCRIPT_URL.href;
    s.onload = () => (globalThis.Peer ? resolve(globalThis.Peer) : reject(new Error("PeerJS no se ha cargado")));
    s.onerror = () => reject(new Error("No se pudo cargar PeerJS"));
    document.head.append(s);
  }));
}

function randomId(n = 10) {
  const chars = "abcdefghijkmnpqrstuvwxyz23456789";
  return [...crypto.getRandomValues(new Uint8Array(n))].map((b) => chars[b % chars.length]).join("");
}

/**
 * @param {object} o
 * @param {string} o.appId       prefijo único de la aplicación (ids en el servidor público)
 * @param {string} o.code        código de sala
 * @param {boolean} o.host       true si este dispositivo crea la sala
 * @param {RTCIceServer[]} o.stun       servidores STUN (ruta directa)
 * @param {RTCIceServer[]} o.turn       servidores TURN (último recurso)
 * @param {boolean} o.forceRelay        diagnóstico: todo por el TURN desde el principio
 * @param {(e: {error: string}) => void} o.onJoinError  "no-room" | "room-taken" | "signaling" | "ice" | otro texto
 */
export function createPeerRoom({ appId, code, host, stun, turn = [], forceRelay = false, onJoinError = () => {} }) {
  const hostId = `${appId}-${code}`.toLowerCase();
  let selfId = host ? hostId : `${hostId}-${randomId()}`;
  let useTurn = forceRelay && turn.length > 0;     // fase actual: directa o con TURN
  const rtcConfig = () => ({
    iceServers: [...stun, ...(useTurn ? turn : [])],
    ...(forceRelay ? { iceTransportPolicy: "relay" } : {}),
  });
  const conns = new Map();          // peerId -> DataConnection abierta
  const pending = new Map();        // peerId -> DataConnection conectando
  const actions = new Map();        // nombre -> {onMessage}
  const pings = new Map();          // nonce -> {resolve, reject, t0, timer}
  let peer = null;
  let left = false;
  let directFailure = null;         // diagnóstico si no hubo ruta directa con el anfitrión
  let everConnected = false;

  const room = {
    get selfId() { return selfId; },
    get usingTurn() { return useTurn; },
    /** Texto con las rutas (candidatos ICE) del intento directo fallido, o null. */
    get directFailure() { return directFailure; },
    onPeerJoin: null,
    onPeerLeave: null,

    makeAction(name) {
      const action = {
        onMessage: null,
        send(payload, { target } = {}) {
          const ids = target == null ? [...conns.keys()] : Array.isArray(target) ? target : [target];
          for (const id of ids) sendRaw(id, { a: name, p: payload });
          return Promise.resolve();
        },
      };
      actions.set(name, action);
      return action;
    },

    ping(id) {
      return new Promise((resolve, reject) => {
        if (!conns.has(id)) { reject(new Error("sin conexión")); return; }
        const nonce = randomId(8);
        const timer = setTimeout(() => { pings.delete(nonce); reject(new Error("ping sin respuesta")); }, PING_TIMEOUT_MS);
        pings.set(nonce, { resolve, timer, t0: performance.now() });
        sendRaw(id, { a: "_ping", p: nonce });
      });
    },

    getPeers() {
      return Object.fromEntries([...conns].map(([id, c]) => [id, c.peerConnection]));
    },

    leave() {
      left = true;
      for (const c of [...conns.values(), ...pending.values()]) c.close();
      conns.clear();
      pending.clear();
      peer?.destroy();
      return Promise.resolve();
    },
  };

  function sendRaw(id, msg) {
    const c = conns.get(id);
    if (!c?.open) return;
    if ((c.dataChannel?.bufferedAmount ?? 0) > MAX_BUFFERED) return;
    try { c.send(msg); } catch { /* canal cerrándose */ }
  }

  function memberList() { return [selfId, ...conns.keys()]; }

  function announceMembers() {
    if (!host) return;
    const ids = memberList();
    for (const id of conns.keys()) sendRaw(id, { a: "_peers", p: ids });
  }

  function dispatch(id, msg) {
    if (!msg || typeof msg.a !== "string") return;
    if (msg.a === "_ping") { sendRaw(id, { a: "_pong", p: msg.p }); return; }
    if (msg.a === "_pong") {
      const p = pings.get(msg.p);
      if (p) { pings.delete(msg.p); clearTimeout(p.timer); p.resolve(Math.round(performance.now() - p.t0)); }
      return;
    }
    if (msg.a === "_peers") {
      if (id !== hostId || !Array.isArray(msg.p)) return;
      for (const other of msg.p) {
        if (typeof other !== "string" || other === selfId) continue;
        if (!conns.has(other) && !pending.has(other) && selfId < other) connectTo(other);
      }
      return;
    }
    actions.get(msg.a)?.onMessage?.(msg.p, { peerId: id });
  }

  function drop(id, conn) {
    if (pending.get(id) === conn) pending.delete(id);
    if (conns.get(id) !== conn) return;
    conns.delete(id);
    room.onPeerLeave?.(id);
    announceMembers();
  }

  function setup(conn) {
    const id = conn.peer;
    let opened = false;
    const fallback = !host && id === hostId && !useTurn && turn.length > 0 && !everConnected;
    let gaveUp = false;
    const giveUp = async (why) => {
      if (opened || left || gaveUp) return;
      gaveUp = true;
      clearTimeout(timer);
      const diag = `${why}; ${await iceDetails(conn.peerConnection)}`;
      console.warn(`[red] sin conexión con ${id}: ${diag}`);
      pending.delete(id);
      conn.close();
      if (fallback) { directFailure = diag; retryWithTurn(); }
      // Solo el invitado informa de que no pudo entrar. El anfitrión descarta el intento
      // fallido y sigue esperando (el invitado puede reintentar con el TURN).
      else if (!host && id === hostId) onJoinError({ error: "ice", detail: diag });
    };
    const timer = setTimeout(() => giveUp("tiempo agotado"), fallback ? DIRECT_TIMEOUT_MS : CONNECT_TIMEOUT_MS);
    watchIce(conn, (state) => { if (state === "failed") giveUp("ICE failed"); });
    conn.on("open", () => {
      opened = true;
      clearTimeout(timer);
      pending.delete(id);
      const old = conns.get(id);
      if (old && old !== conn) old.close();
      conns.set(id, conn);
      everConnected = true;
      const pc = conn.peerConnection;
      pc?.addEventListener("connectionstatechange", () => {
        if (pc.connectionState === "failed" || pc.connectionState === "closed") drop(id, conn);
      });
      room.onPeerJoin?.(id);
      announceMembers();
    });
    conn.on("data", (msg) => dispatch(id, msg));
    conn.on("close", () => { clearTimeout(timer); drop(id, conn); });
    conn.on("error", () => { /* "close" llega después */ });
  }

  /** Llama a onState con cada cambio de estado ICE (la RTCPeerConnection aparece al poco). */
  function watchIce(conn, onState) {
    let tries = 0;
    const attach = () => {
      const pc = conn.peerConnection;
      if (!pc) { if (tries++ < 50) setTimeout(attach, 100); return; }
      const report = () => {
        console.info(`[red] ICE ${conn.peer}: ${pc.iceConnectionState}`);
        onState(pc.iceConnectionState);
      };
      pc.addEventListener("iceconnectionstatechange", report);
      pc.addEventListener("icecandidateerror", (e) => console.warn("[red] error de candidato ICE", e.url, e.errorCode, e.errorText));
      report();
    };
    attach();
  }

  /** Rutas encontradas por cada lado (como PortNes): "host/udp, srflx/udp"… */
  async function iceDetails(pc) {
    if (!pc) return "sin conexión WebRTC";
    try {
      const loc = new Set(), rem = new Set();
      (await pc.getStats()).forEach((r) => {
        const d = r.candidateType + (r.protocol ? `/${r.protocol}` : "");
        if (r.type === "local-candidate") loc.add(d);
        if (r.type === "remote-candidate") rem.add(d);
      });
      return `estado ${pc.iceConnectionState}; rutas propias: ${[...loc].join(", ") || "ninguna"}; ` +
        `del anfitrión: ${[...rem].join(", ") || "ninguna"}`;
    } catch { return `estado ${pc.iceConnectionState}`; }
  }

  /** Invitado sin ruta directa al anfitrión: vuelve a entrar (id nuevo) con el TURN. */
  function retryWithTurn() {
    if (left || useTurn) return;
    console.info("Sin conexión directa con el anfitrión: se reintenta con el servidor TURN.");
    useTurn = true;
    peer.destroy();
    selfId = `${hostId}-${randomId()}`;
    startPeer();
  }

  function connectTo(id) {
    const conn = peer.connect(id, { reliable: true, serialization: "json", metadata: { room: hostId } });
    pending.set(id, conn);
    setup(conn);
  }

  let PeerClass = null;
  function startPeer() {
    const Peer = PeerClass;
    peer = new Peer(selfId, { config: rtcConfig(), debug: 1 });
    peer.on("open", () => { if (!host) connectTo(hostId); });
    peer.on("connection", (conn) => {
      if (conn.metadata?.room !== hostId) { conn.close(); return; }
      pending.set(conn.peer, conn);
      setup(conn);
    });
    peer.on("disconnected", () => {
      // sin servidor de señalización: las conexiones abiertas siguen; reintentar para nuevas
      if (!left) setTimeout(() => { if (!left && peer.disconnected && !peer.destroyed) peer.reconnect(); }, 2000);
    });
    peer.on("error", (e) => {
      if (left) return;
      if (e.type === "peer-unavailable") {
        if (!everConnected) onJoinError({ error: "no-room" });
      } else if (e.type === "unavailable-id") {
        onJoinError({ error: "room-taken" });
      } else if (["network", "server-error", "socket-error", "socket-closed"].includes(e.type)) {
        if (!everConnected) onJoinError({ error: "signaling" });
      } else if (e.type === "browser-incompatible" || e.type === "webrtc") {
        onJoinError({ error: e.message || e.type });
      }
    });
  }

  loadPeerJS().then((Peer) => {
    if (left) return;
    PeerClass = Peer;
    startPeer();
  }).catch((e) => onJoinError({ error: e.message }));

  return room;
}
