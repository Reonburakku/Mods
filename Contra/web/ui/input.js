// Entradas locales: teclado, mandos (Gamepad API) y controles táctiles.
// Máximo 2 jugadores por dispositivo: read() devuelve [byteJugador1, byteJugador2].
// Las teclas se identifican por su posición física (event.code), así funciona
// igual con teclado español, inglés, etc.
import { BTN } from "../emu/core.js";

const KEYS_P1 = {
  KeyW: BTN.UP, KeyS: BTN.DOWN, KeyA: BTN.LEFT, KeyD: BTN.RIGHT,
  KeyJ: BTN.B, KeyK: BTN.A, KeyG: BTN.SELECT, KeyH: BTN.START, Enter: BTN.START,
};
const KEYS_P2 = {
  ArrowUp: BTN.UP, ArrowDown: BTN.DOWN, ArrowLeft: BTN.LEFT, ArrowRight: BTN.RIGHT,
  Comma: BTN.B, Period: BTN.A, KeyM: BTN.SELECT, Slash: BTN.START,
};

// Mando estándar (Gamepad API "standard"): 0 abajo, 1 derecha, 2 izquierda, 3 arriba
const PAD_BUTTONS = [
  [0, BTN.A], [1, BTN.A], [2, BTN.B], [3, BTN.B],
  [8, BTN.SELECT], [9, BTN.START],
  [12, BTN.UP], [13, BTN.DOWN], [14, BTN.LEFT], [15, BTN.RIGHT],
];
const STICK_DEADZONE = 0.5;

export class LocalInput {
  constructor() {
    this.keys = [0, 0];
    this.touch = 0;
    // Botones pulsados desde el último fotograma: aunque se suelten antes de que
    // el juego lea el mando, cuentan durante al menos un fotograma.
    this.latched = [0, 0];
    this.pressed = new Set();
    this.enabled = true;
    addEventListener("keydown", (e) => this.onKey(e, true));
    addEventListener("keyup", (e) => this.onKey(e, false));
    addEventListener("blur", () => { this.pressed.clear(); this.keys = [0, 0]; });
  }

  onKey(e, down) {
    if (e.ctrlKey || e.metaKey || e.altKey) return;
    const p1 = KEYS_P1[e.code], p2 = KEYS_P2[e.code];
    if (p1 === undefined && p2 === undefined) return;
    if (!this.enabled) return;
    e.preventDefault();               // que las flechas no desplacen la página
    if (down) {
      this.pressed.add(e.code);
      this.latched[0] |= p1 ?? 0;
      this.latched[1] |= p2 ?? 0;
    } else {
      this.pressed.delete(e.code);
    }
    let a = 0, b = 0;
    for (const code of this.pressed) {
      a |= KEYS_P1[code] ?? 0;
      b |= KEYS_P2[code] ?? 0;
    }
    this.keys = [a, b];
  }

  /** Estado de los mandos de los jugadores locales en este fotograma. */
  read() {
    const out = [this.keys[0] | this.touch | this.latched[0], this.keys[1] | this.latched[1]];
    this.latched = [0, 0];
    const pads = navigator.getGamepads ? [...navigator.getGamepads()].filter(Boolean) : [];
    pads.slice(0, 2).forEach((pad, i) => { out[i] |= readPad(pad); });
    return out.map(cleanDpad);
  }

  /** Nombres de los mandos conectados (para mostrarlos en la interfaz). */
  gamepads() {
    return navigator.getGamepads ? [...navigator.getGamepads()].filter(Boolean).map((p) => p.id) : [];
  }
}

function readPad(pad) {
  let v = 0;
  for (const [i, bit] of PAD_BUTTONS) if (pad.buttons[i]?.pressed) v |= bit;
  const [x = 0, y = 0] = pad.axes;
  if (x < -STICK_DEADZONE) v |= BTN.LEFT;
  if (x > STICK_DEADZONE) v |= BTN.RIGHT;
  if (y < -STICK_DEADZONE) v |= BTN.UP;
  if (y > STICK_DEADZONE) v |= BTN.DOWN;
  return v;
}

/** Una cruceta real no puede pulsar izquierda+derecha ni arriba+abajo a la vez. */
function cleanDpad(v) {
  if ((v & (BTN.LEFT | BTN.RIGHT)) === (BTN.LEFT | BTN.RIGHT)) v &= ~(BTN.LEFT | BTN.RIGHT);
  if ((v & (BTN.UP | BTN.DOWN)) === (BTN.UP | BTN.DOWN)) v &= ~(BTN.UP | BTN.DOWN);
  return v;
}

/** Controles táctiles para el jugador 1. */
export function setupTouch(root, input) {
  const dpad = root.querySelector("[data-pad=dpad]");
  const knob = dpad.querySelector("span");
  const buttons = [...root.querySelectorAll("[data-btn]")];
  let dpadBits = 0;
  const btnBits = new Map();   // pointerId -> bit
  const update = () => {
    let v = dpadBits;
    for (const bit of btnBits.values()) v |= bit;
    input.touch = v;
  };

  // Cruceta: dirección según el ángulo desde el centro (8 direcciones)
  let dpadPointer = null;
  const moveDpad = (e) => {
    const r = dpad.getBoundingClientRect();
    const dx = e.clientX - (r.left + r.width / 2);
    const dy = e.clientY - (r.top + r.height / 2);
    const dist = Math.hypot(dx, dy);
    dpadBits = 0;
    if (dist > r.width * 0.12) {
      const ang = Math.atan2(dy, dx);                    // 0 = derecha, positivo = abajo
      const sector = Math.round(ang / (Math.PI / 4));    // -4..4
      const dirs = {
        0: BTN.RIGHT, 1: BTN.RIGHT | BTN.DOWN, 2: BTN.DOWN, 3: BTN.LEFT | BTN.DOWN,
        4: BTN.LEFT, [-4]: BTN.LEFT, [-3]: BTN.LEFT | BTN.UP, [-2]: BTN.UP, [-1]: BTN.RIGHT | BTN.UP,
      };
      dpadBits = dirs[sector];
      input.latched[0] |= dpadBits;
    }
    const k = Math.min(dist, r.width * 0.3) / (dist || 1);
    knob.style.transform = `translate(${dx * k}px, ${dy * k}px)`;
    update();
  };
  dpad.addEventListener("pointerdown", (e) => {
    dpadPointer = e.pointerId;
    dpad.setPointerCapture(e.pointerId);
    moveDpad(e);
  });
  dpad.addEventListener("pointermove", (e) => { if (e.pointerId === dpadPointer) moveDpad(e); });
  const endDpad = (e) => {
    if (e.pointerId !== dpadPointer) return;
    dpadPointer = null;
    dpadBits = 0;
    knob.style.transform = "";
    update();
  };
  dpad.addEventListener("pointerup", endDpad);
  dpad.addEventListener("pointercancel", endDpad);

  for (const b of buttons) {
    const bit = BTN[b.dataset.btn];
    b.addEventListener("pointerdown", (e) => {
      e.preventDefault();
      b.setPointerCapture(e.pointerId);
      btnBits.set(e.pointerId, bit);
      input.latched[0] |= bit;
      b.classList.add("on");
      navigator.vibrate?.(8);
      update();
    });
    const end = (e) => {
      if (!btnBits.has(e.pointerId)) return;
      btnBits.delete(e.pointerId);
      b.classList.remove("on");
      update();
    };
    b.addEventListener("pointerup", end);
    b.addEventListener("pointercancel", end);
    b.addEventListener("contextmenu", (e) => e.preventDefault());
  }
}
