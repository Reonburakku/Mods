// Fase 1: juego local (1-2 jugadores en este dispositivo).
// Flujo: descargar ROM (o caché) → botón "Jugar" (necesario para activar el audio) → bucle.
import { ROM_BASE_URL } from "./config.js";
import { loadRom } from "./rom/loader.js";
import { Core, FPS } from "./emu/core.js";
import { Screen } from "./ui/screen.js";
import { Audio } from "./ui/audio.js";
import { LocalInput, setupTouch } from "./ui/input.js";

const $ = (id) => document.getElementById(id);
const ui = {
  overlay: $("overlay"), status: $("status"), progress: $("progress"), play: $("play"),
  error: $("error"), info: $("info"), touch: $("touch"), help: $("help"),
  mute: $("btn-mute"), helpBtn: $("btn-help"), fullscreen: $("btn-fullscreen"),
};

const screen = new Screen($("screen"));
const input = new LocalInput();
setupTouch(ui.touch, input);

const isTouch = matchMedia("(pointer: coarse)").matches;
ui.touch.hidden = !isTouch;
addEventListener("touchstart", () => { ui.touch.hidden = false; }, { once: true, passive: true });

let rom = null;
let core = null;
let audio = null;

// ------------------------------------------------------------------ carga
async function boot() {
  try {
    const res = await loadRom(ROM_BASE_URL, (msg, f) => {
      ui.status.textContent = msg;
      if (f !== undefined) {
        ui.progress.hidden = false;
        ui.progress.firstElementChild.style.width = `${Math.round(f * 100)}%`;
      }
    });
    rom = res;
    ui.progress.hidden = true;
    ui.status.textContent = `ROM v${res.manifest.version}${res.fromCache ? " (en caché)" : ""}`;
    ui.play.hidden = false;
    ui.play.focus();
  } catch (e) {
    console.error(e);
    ui.status.textContent = "No se pudo cargar el juego";
    ui.error.textContent = e.message;
    ui.error.hidden = false;
  }
}

ui.play.addEventListener("click", async () => {
  ui.play.disabled = true;
  try {
    audio = await Audio.create();
    await audio.resume();
  } catch (e) {
    console.warn("Sin sonido:", e);
    audio = null;
  }
  core = new Core(rom.bytes, audio ? { sampleRate: audio.sampleRate, onAudio: audio.onSample } : {});
  ui.overlay.hidden = true;
  ui.mute.disabled = !audio;
  start();
});

// ------------------------------------------------------------------ bucle
// Paso fijo a 60,0988 fps independiente de la frecuencia de la pantalla (60, 120, 144 Hz…).
const FRAME_MS = 1000 / FPS;
const MAX_CATCHUP = 4;          // si el navegador se atasca, no intentar recuperar más
let acc = 0;
let last = 0;
let running = false;
let fpsCount = 0;
let fpsTime = 0;

function start() {
  running = true;
  last = performance.now();
  requestAnimationFrame(tick);
}

function tick(now) {
  if (!running) return;
  acc += now - last;
  last = now;
  if (acc > FRAME_MS * MAX_CATCHUP) acc = FRAME_MS * MAX_CATCHUP;
  let ran = 0;
  while (acc >= FRAME_MS) {
    core.frame(input.read());
    acc -= FRAME_MS;
    ran++;
  }
  if (ran) {
    screen.draw(core.frameBuffer);
    audio?.flush();
    fpsCount += ran;
  }
  if (now - fpsTime >= 1000) {
    const pads = input.gamepads().length;
    ui.info.textContent = `${fpsCount} fps${pads ? ` · ${pads} mando${pads > 1 ? "s" : ""}` : ""}`;
    fpsCount = 0;
    fpsTime = now;
  }
  requestAnimationFrame(tick);
}

// Al cambiar de pestaña el navegador pausa requestAnimationFrame: al volver, no
// "recuperar" el tiempo perdido de golpe.
document.addEventListener("visibilitychange", () => {
  if (!document.hidden) { last = performance.now(); acc = 0; audio?.resume(); }
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
  if (e.code === "KeyF" && !e.ctrlKey && !e.metaKey && !ui.help.open) toggleFullscreen();
});

boot();
