// Dibuja el fotograma del núcleo (256x240, 0xBBGGRR) en el canvas.
// Se recortan 8 líneas arriba y abajo, como hacían los televisores NTSC (queda 256x224).
import { WIDTH, HEIGHT } from "../emu/core.js";

const CROP_TOP = 8;

export class Screen {
  constructor(canvas) {
    this.ctx = canvas.getContext("2d", { alpha: false });
    this.image = this.ctx.createImageData(WIDTH, HEIGHT);
    this.pixels = new Uint32Array(this.image.data.buffer);   // ABGR en little-endian
  }

  draw(frameBuffer) {
    const px = this.pixels;
    for (let i = 0; i < px.length; i++) px[i] = 0xff000000 | frameBuffer[i];
    this.ctx.putImageData(this.image, 0, -CROP_TOP);
  }
}
