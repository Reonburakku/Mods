// Capa 2: consola virtual. Sin DOM: la usan la web y las pruebas de Node.
// Toda la emulación pasa por aquí para que el resto no dependa de jsnes.
import NES from "./jsnes/nes.js";
import Controller from "./jsnes/controller.js";

// Byte de botones de un mando (mismo orden que lee el juego): A B Select Start Arriba Abajo Izq Der
export const BTN = Object.freeze({
  A: 0x80, B: 0x40, SELECT: 0x20, START: 0x10, UP: 0x08, DOWN: 0x04, LEFT: 0x02, RIGHT: 0x01,
});

const BIT_TO_KEY = [
  [BTN.A, Controller.BUTTON_A], [BTN.B, Controller.BUTTON_B],
  [BTN.SELECT, Controller.BUTTON_SELECT], [BTN.START, Controller.BUTTON_START],
  [BTN.UP, Controller.BUTTON_UP], [BTN.DOWN, Controller.BUTTON_DOWN],
  [BTN.LEFT, Controller.BUTTON_LEFT], [BTN.RIGHT, Controller.BUTTON_RIGHT],
];

export const WIDTH = 256;
export const HEIGHT = 240;
export const FPS = 60.0988;   // NTSC

export class Core {
  /**
   * @param {Uint8Array} rom
   * @param {{sampleRate?: number, onAudio?: (l: number, r: number) => void}} opts
   *   Sin onAudio no se emula el sonido (más rápido; no afecta al estado del juego).
   *   fourScore: adaptador de 4 mandos conectado (un juego que lee solo 8 bits por
   *   puerto, como el Contra original, funciona igual con o sin él).
   */
  constructor(rom, { sampleRate = 48000, onAudio = null, fourScore = true } = {}) {
    /** Imagen del último fotograma: 0xBBGGRR por píxel. */
    this.frameBuffer = new Uint32Array(WIDTH * HEIGHT);
    this.nes = new NES({
      onFrame: (buf) => this.frameBuffer.set(buf),
      onAudioSample: onAudio ?? (() => {}),
      emulateSound: !!onAudio,
      sampleRate,
      fourScore,
    });
    this.nes.loadROM(rom);
    this.frameCount = 0;
  }

  /** Avanza exactamente un fotograma. inputs[p] = byte BTN del jugador p (0-3). */
  frame(inputs) {
    for (let p = 0; p < 4; p++) {
      const state = this.nes.controllers[p + 1].state;
      const v = inputs[p] | 0;
      for (const [bit, key] of BIT_TO_KEY) state[key] = v & bit ? 0x41 : 0x40;
    }
    this.nes.frame();
    this.frameCount++;
  }

  reset() { this.nes.reset(); }

  /** RAM de la CPU (lectura): 0x0000-0x07FF interna, 0x6000-0x7FFF extra. */
  get mem() { return this.nes.cpu.mem; }

  saveState() { return { frameCount: this.frameCount, nes: this.nes.toJSON() }; }
  loadState(s) { this.nes.fromJSON(s.nes); this.frameCount = s.frameCount; }
}
