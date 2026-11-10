// Consola para pruebas en Node: el mismo núcleo que usa la web (web/emu/core.js)
// más utilidades de test (pulsar botones, hash de RAM, capturas PNG).
import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { dirname } from "node:path";
import { deflateSync, crc32 } from "node:zlib";
import { Core, BTN, WIDTH, HEIGHT } from "../../web/emu/core.js";

export { BTN };

export class TestConsole {
  constructor(romPath, { sound = false } = {}) {
    this.core = new Core(readFileSync(romPath), { onAudio: sound ? () => {} : null });
    this.nes = this.core.nes;
  }

  get frameCount() { return this.core.frameCount; }
  frame(inputs = [0, 0]) { this.core.frame(inputs); }
  run(n, inputs = [0, 0]) { for (let i = 0; i < n; i++) this.core.frame(inputs); }

  /** Mantiene pulsado un botón unos fotogramas y luego lo suelta. */
  press(player, bits, hold = 4, after = 10) {
    const inp = [0, 0];
    inp[player] = bits;
    this.run(hold, inp);
    this.run(after);
  }

  ram(addr) { return this.core.mem[addr]; }

  /** CRC32 de la RAM interna (2 KB) + la RAM extra $6000-$7FFF. */
  ramHash() {
    const m = this.core.mem;
    return crc32(m.subarray(0x6000, 0x8000), crc32(m.subarray(0, 0x800)));
  }

  saveState() { return JSON.stringify(this.core.saveState()); }
  loadState(s) { this.core.loadState(JSON.parse(s)); }

  screenshot(path) {
    mkdirSync(dirname(path), { recursive: true });
    const w = WIDTH, h = HEIGHT, fb = this.core.frameBuffer;
    const raw = Buffer.alloc((w * 3 + 1) * h);
    for (let y = 0; y < h; y++) {
      for (let x = 0; x < w; x++) {
        const v = fb[y * w + x];        // 0xBBGGRR
        const o = y * (w * 3 + 1) + 1 + x * 3;
        raw[o] = v & 0xff; raw[o + 1] = (v >> 8) & 0xff; raw[o + 2] = (v >> 16) & 0xff;
      }
    }
    const chunk = (type, data) => {
      const len = Buffer.alloc(4); len.writeUInt32BE(data.length);
      const td = Buffer.concat([Buffer.from(type), data]);
      const crc = Buffer.alloc(4); crc.writeUInt32BE(crc32(td));
      return Buffer.concat([len, td, crc]);
    };
    const ihdr = Buffer.alloc(13);
    ihdr.writeUInt32BE(w, 0); ihdr.writeUInt32BE(h, 4);
    ihdr[8] = 8; ihdr[9] = 2;
    writeFileSync(path, Buffer.concat([
      Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]),
      chunk("IHDR", ihdr), chunk("IDAT", deflateSync(raw)), chunk("IEND", Buffer.alloc(0)),
    ]));
  }
}

/** Generador pseudoaleatorio determinista (mulberry32) para grabar partidas de prueba. */
export function rng(seed) {
  return () => {
    seed = (seed + 0x6d2b79f5) | 0;
    let t = Math.imul(seed ^ (seed >>> 15), 1 | seed);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}
