// Partidas grabadas para las pruebas: arranque, menú y entradas aleatorias con semilla fija.
import { BTN } from "../../web/emu/core.js";
import { rng } from "./console.mjs";

/**
 * @param {number} frames  duración total
 * @param {number} seed
 * @param {{players?: 1|2, slots?: number}} o  players: opción del menú; slots: mandos con entradas aleatorias
 * @returns {number[][]} entradas por fotograma, 4 mandos
 */
export function recording(frames, seed, { players = 2, slots = 2 } = {}) {
  const r = rng(seed), inputs = [];
  const push = (n, p1) => { for (let i = 0; i < n; i++) inputs.push([p1, 0, 0, 0]); };
  push(240, 0); push(4, BTN.START); push(60, 0);
  if (players === 2) { push(4, BTN.SELECT); push(20, 0); }
  push(4, BTN.START); push(200, 0);
  const held = [0, 0, 0, 0];
  while (inputs.length < frames) {
    for (let s = 0; s < slots; s++) {
      if (r() < 0.1) held[s] = Math.floor(r() * 256) & ~(BTN.START | BTN.SELECT);
    }
    inputs.push([...held]);
  }
  return inputs.slice(0, frames);
}
