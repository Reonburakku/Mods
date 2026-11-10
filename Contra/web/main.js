// Página principal: carga de la ROM, menú, sala de juego en red y bucle de juego.
import { ROM_BASE_URL, OVERCLOCK_OVERRIDE } from "./config.js";
import { loadRom } from "./rom/loader.js";
import { Core, FPS } from "./emu/core.js";
import { Screen } from "./ui/screen.js";
import { Audio } from "./ui/audio.js";
import { LocalInput, setupTouch } from "./ui/input.js";
import { ramHash } from "./net/lockstep.js";

const $ = (id) => document.getElementById(id);
const ui = {
  overlay: $("overlay"), status: $("status"), progress: $("progress"), error: $("error"),
  menu: $("scr-menu"), lobby: $("scr-lobby"),
  playLocal: $("play-local"), netCreate: $("net-create"), joinForm: $("join-form"), joinCode: $("join-code"),
  lobbyCode: $("lobby-code"), copyLink: $("copy-link"), myName: $("my-name"), myLocal: $("my-local"),
  lobbyList: $("lobby-list"), lobbyMsg: $("lobby-msg"), lobbyStart: $("lobby-start"), lobbyLeave: $("lobby-leave"),
  wait: $("wait"), waitMsg: $("wait-msg"), waitLeave: $("wait-leave"), hint: $("hint"),
  info: $("info"), touch: $("touch"), help: $("help"),
  mute: $("btn-mute"), helpBtn: $("btn-help"), fullscreen: $("btn-fullscreen"),
};

const screen = new Screen($("screen"));
const input = new LocalInput();
setupTouch(ui.touch, input);
ui.touch.hidden = !matchMedia("(pointer: coarse)").matches;
addEventListener("touchstart", () => { ui.touch.hidden = false; }, { once: true, passive: true });

let rom = null;
let core = null;
let audio = null;
let session = null;        // NetSession durante el juego en red

const store = {
  get(k, d) { try { return localStorage.getItem(k) ?? d; } catch { return d; } },
  set(k, v) { try { localStorage.setItem(k, v); } catch { /* sin almacenamiento */ } },
};

function show(section) {
  for (const s of [ui.menu, ui.lobby]) s.hidden = s !== section;
}

function fail(msg) {
  ui.error.textContent = msg;
  ui.error.hidden = !msg;
}

// ------------------------------------------------------------------ carga
async function boot() {
  try {
    rom = await loadRom(ROM_BASE_URL, (msg, f) => {
      ui.status.textContent = msg;
      if (f !== undefined) {
        ui.progress.hidden = false;
        ui.progress.firstElementChild.style.width = `${Math.round(f * 100)}%`;
      }
    });
    ui.progress.hidden = true;
    ui.status.textContent = `ROM v${rom.manifest.version}${rom.fromCache ? " (en caché)" : ""}`;
    const code = new URLSearchParams(location.hash.slice(1)).get("sala");
    show(ui.menu);
    if (code) {
      ui.joinCode.value = code;
      ui.joinForm.querySelector("button").focus();
    } else {
      ui.playLocal.focus();
    }
  } catch (e) {
    console.error(e);
    ui.status.textContent = "No se pudo cargar el juego";
    fail(e.message);
  }
}

/** El audio solo puede arrancar tras un gesto del usuario: se llama desde los botones. */
async function ensureAudio() {
  if (audio) return;
  try {
    audio = await Audio.create();
    await audio.resume();
  } catch (e) {
    console.warn("Sin sonido:", e);
    audio = null;
  }
  ui.mute.disabled = !audio;
}

/** Overclock que usará este dispositivo si juega solo o si es el anfitrión. */
function chosenOverclock() {
  return OVERCLOCK_OVERRIDE ?? rom.manifest.overclock ?? 0;
}

function newCore(overclock) {
  core = new Core(rom.bytes, {
    overclock,
    ...(audio ? { sampleRate: audio.sampleRate, onAudio: audio.onSample } : {}),
  });
}

// ------------------------------------------------------------------ juego local
ui.playLocal.addEventListener("click", async () => {
  await ensureAudio();
  newCore(chosenOverclock());
  ui.overlay.hidden = true;
  startLoop(localStep);
});

function localStep() {
  core.frame(input.read());
  return true;
}

// ------------------------------------------------------------------ juego en red
async function openRoom(code, host) {
  fail("");
  const net = await import("./net/session.js");
  const why = net.netplaySupported();
  if (why) { fail(why); return; }
  await ensureAudio();
  code = net.normalizeCode(code);
  if (code.length < 4) { fail("El código de sala no es válido."); return; }
  ui.myName.value = store.get("contra4p.name", "Jugador");
  ui.myLocal.value = "1";
  session = new net.NetSession({
    code, host,
    me: { name: ui.myName.value, local: 1, sha1: rom.manifest.sha1, version: rom.manifest.version },
    maxPlayers: rom.manifest.players ?? 2,
    overclock: chosenOverclock(),
  });
  session.onLobby = renderLobby;
  session.onError = (msg) => { fail(msg); };
  session.onStart = startNetGame;
  session.onPeerLeft = (_id, name) => {
    netState.left = name;
  };
  history.replaceState(null, "", `#sala=${code}`);
  ui.lobbyCode.textContent = code;
  ui.lobbyStart.hidden = !host;
  ui.status.textContent = host ? "Comparte el código o el enlace" : "Conectando con la sala…";
  show(ui.lobby);
  renderLobby(session.players);
}

ui.netCreate.addEventListener("click", async () => {
  const { newRoomCode } = await import("./net/session.js");
  openRoom(newRoomCode(), true);
});

ui.joinForm.addEventListener("submit", (e) => {
  e.preventDefault();
  openRoom(ui.joinCode.value, false);
});

ui.copyLink.addEventListener("click", async () => {
  const url = `${location.origin}${location.pathname}${location.search}#sala=${session.code}`;
  try {
    await navigator.clipboard.writeText(url);
    ui.copyLink.textContent = "¡Copiado!";
  } catch {
    prompt("Copia este enlace:", url);
  }
  setTimeout(() => { ui.copyLink.textContent = "Copiar enlace"; }, 1500);
});

ui.myName.addEventListener("change", () => {
  const name = ui.myName.value.trim().slice(0, 16) || "Jugador";
  ui.myName.value = name;
  store.set("contra4p.name", name);
  session?.setMe({ name });
});
ui.myLocal.addEventListener("change", () => session?.setMe({ local: Number(ui.myLocal.value) }));

ui.lobbyStart.addEventListener("click", async () => {
  ui.lobbyStart.disabled = true;
  ui.lobbyMsg.textContent = "Midiendo la latencia…";
  await session.start();
});

ui.lobbyLeave.addEventListener("click", leaveRoom);
ui.waitLeave.addEventListener("click", leaveRoom);

function leaveRoom() {
  session?.leave();
  history.replaceState(null, "", location.pathname + location.search);
  location.reload();
}

function renderLobby(players) {
  ui.lobbyList.replaceChildren(...players.map((p) => {
    const li = document.createElement("li");
    const name = document.createElement("span");
    name.className = "name";
    name.textContent = p.name + (p.self ? " (tú)" : "");
    const tag = document.createElement("span");
    tag.className = "tag";
    tag.textContent = [p.host ? "anfitrión" : "", p.ping != null ? `${p.ping} ms` : ""].filter(Boolean).join(" · ");
    const slots = document.createElement("span");
    slots.className = p.romOk ? "slots" : "slots bad";
    slots.textContent = !p.romOk ? `ROM distinta (v${p.version ?? "?"})`
      : p.slots.length ? p.slots.map((s) => `J${s + 1}`).join(" ") : "sin plaza";
    li.append(name, tag, slots);
    return li;
  }));
  const others = players.length - 1;
  if (!session?.isHost) ui.status.textContent = others ? "Conectado a la sala" : "Conectando con la sala…";
  if (session?.isHost) {
    const why = session.cannotStart();
    ui.lobbyStart.disabled = !!why;
    ui.lobbyMsg.textContent = why ?? "Todo listo.";
  } else {
    ui.lobbyMsg.textContent = others === 0 ? "Buscando a los demás jugadores…"
      : "Esperando a que el anfitrión empiece la partida.";
  }
}

const netState = { stallSince: 0, left: null, hashMsg: null };

function startNetGame(game) {
  newCore(game.overclock);         // el del anfitrión: tiene que ser igual en todos
  ui.overlay.hidden = true;
  netState.stallSince = 0;
  startLoop(netStep, () => { session.flush(netState.hashMsg); netState.hashMsg = null; }, { background: true });
  console.info("Partida en red", game);
}

function netStep() {
  const ls = session.lockstep;
  if (!ls.ready()) return false;
  const f = ls.frame;
  const local = input.read().slice(0, ls.localSlots.length);
  core.frame(ls.advance(local));
  if (ls.needsHash(f)) netState.hashMsg = ls.recordHash(f, ramHash(core.mem));
  return true;
}

function netStatus(now, ran) {
  const ls = session.lockstep;
  if (ran) netState.stallSince = 0;
  else if (!netState.stallSince) netState.stallSince = now;
  const stalled = netState.stallSince && now - netState.stallSince > 500;
  if (netState.left) {
    ui.waitMsg.textContent = `${netState.left} se ha desconectado. La partida no puede seguir.`;
  } else if (stalled) {
    ui.waitMsg.textContent = `Esperando a ${ls.waitingFor().map((p) => session.nameOf(p)).join(", ")}…`;
  }
  ui.wait.hidden = !(stalled || netState.left);
  ui.waitLeave.hidden = !netState.left;
  if ((netState.hintTick = (netState.hintTick ?? 0) + 1) % 15 === 0) updateHint(ls.localSlots);
}

// Aviso para los jugadores de este dispositivo que todavía no están en la partida.
// Direcciones de la ROM (src/ram4p.inc): $38/$39 = J1/J2 fuera; Ctx_Over $606E/$606F = J3/J4 fuera;
// PlayActive $607A <> 0 mientras la lógica de jugadores se ejecuta (no en título ni presentación).
const START_KEYS = ["H o Enter", "- (guion)"];
function updateHint(localSlots) {
  const m = core.mem;
  const inGame = m[0x607a] !== 0;
  const msgs = [];
  if (inGame) {
    localSlots.forEach((slot, i) => {
      const key = matchMedia("(pointer: coarse)").matches ? "START" : START_KEYS[i];
      if (slot >= 2 && (rom.manifest.players ?? 2) >= 4 && m[0x606e + slot - 2] !== 0) {
        msgs.push(`J${slot + 1}: pulsa START (${key}) para entrar`);
      } else if (slot === 1 && m[0x39] !== 0 && m[0x22] === 0) {
        msgs.push("J2 no está en esta partida: el anfitrión eligió 1 PLAYER");
      }
    });
  }
  ui.hint.textContent = msgs.join(" · ");
  ui.hint.hidden = msgs.length === 0;
}

// ------------------------------------------------------------------ bucle
// Paso fijo a 60,0988 fps independiente de la frecuencia de la pantalla.
// step() ejecuta un fotograma y devuelve false si no puede (esperando entradas).
const FRAME_MS = 1000 / FPS;
const MAX_CATCHUP = 4;
let acc = 0;
let last = 0;
let fpsCount = 0;
let fpsTime = 0;
let step = null;
let afterTick = null;

let ticker = null;         // Worker que mantiene vivo el juego en red con la pestaña oculta

function startLoop(stepFn, afterFn = null, { background = false } = {}) {
  step = stepFn;
  afterTick = afterFn;
  last = performance.now();
  requestAnimationFrame(rafLoop);
  if (background) {
    ticker = new Worker(new URL("./ui/ticker-worker.js", import.meta.url));
    // si requestAnimationFrame lleva un rato sin llegar (pestaña oculta o tapada), tomar el relevo
    ticker.onmessage = () => {
      const now = performance.now();
      if (now - lastRaf > 50) tick(now);
    };
    ticker.postMessage(FRAME_MS);
  }
}

let lastRaf = 0;

function rafLoop(now) {
  lastRaf = performance.now();
  tick(now);
  requestAnimationFrame(rafLoop);
}

function tick(now) {
  acc += now - last;
  last = now;
  if (acc > FRAME_MS * MAX_CATCHUP) acc = FRAME_MS * MAX_CATCHUP;
  let ran = 0;
  while (acc >= FRAME_MS) {
    if (!step()) break;
    acc -= FRAME_MS;
    ran++;
  }
  if (ran) {
    if (!document.hidden) screen.draw(core.frameBuffer);
    audio?.flush();
    fpsCount += ran;
  }
  if (session?.lockstep) netStatus(now, ran > 0);
  afterTick?.();
  if (now - fpsTime >= 1000) {
    const parts = [`${fpsCount} fps`];
    if (session?.lockstep) {
      const ls = session.lockstep;
      const pings = [...session.pings.values()];
      if (pings.length) parts.unshift(`ping ${Math.max(...pings)} ms · retardo ${ls.delay}`);
      parts.unshift(`tú: ${ls.localSlots.map((s) => `J${s + 1}`).join("+")}`);
      if (ls.desyncFrame !== null) parts.unshift(`⚠ desincronizado (f${ls.desyncFrame})`);
    }
    const pads = input.gamepads().length;
    if (pads) parts.push(`${pads} mando${pads > 1 ? "s" : ""}`);
    ui.info.textContent = parts.join(" · ");
    fpsCount = 0;
    fpsTime = now;
  }
}

// Al volver a la pestaña no "recuperar" de golpe el tiempo perdido.
document.addEventListener("visibilitychange", () => {
  if (!document.hidden) {
    last = performance.now();
    if (!session?.lockstep) acc = 0;
    audio?.resume();
  }
});

// ------------------------------------------------------------------ barra
ui.mute.addEventListener("click", () => {
  if (!audio) return;
  audio.setMuted(!audio.muted);
  ui.mute.textContent = audio.muted ? "🔇" : "🔊";
});

ui.helpBtn.addEventListener("click", () => {
  input.enabled = false;
  input.pressed.clear();
  input.keys = [0, 0];
  ui.help.showModal();
});
ui.help.addEventListener("close", () => { input.enabled = true; });

function toggleFullscreen() {
  if (document.fullscreenElement) document.exitFullscreen();
  else document.documentElement.requestFullscreen?.({ navigationUI: "hide" })
    .then(() => window.screen.orientation?.lock?.("landscape").catch(() => {}))
    .catch(() => {});
}
ui.fullscreen.addEventListener("click", toggleFullscreen);
addEventListener("keydown", (e) => {
  const typing = e.target instanceof HTMLInputElement || e.target instanceof HTMLSelectElement;
  if (e.code === "KeyF" && !typing && !e.ctrlKey && !e.metaKey && !ui.help.open) toggleFullscreen();
});

boot();
