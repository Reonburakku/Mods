// Reproduce las muestras que genera el emulador (cola circular estéreo).
// Si la cola se vacía suena silencio; si se llena demasiado se descarta lo más
// antiguo, para que el retraso del sonido no crezca.
class NesAudio extends AudioWorkletProcessor {
  constructor() {
    super();
    this.size = 16384;
    this.left = new Float32Array(this.size);
    this.right = new Float32Array(this.size);
    this.read = 0;
    this.count = 0;
    this.maxLatency = Math.round(sampleRate * 0.1);   // 100 ms
    this.port.onmessage = (e) => this.push(e.data.left, e.data.right);
  }

  push(l, r) {
    for (let i = 0; i < l.length; i++) {
      if (this.count === this.size) { this.read = (this.read + 1) % this.size; this.count--; }
      const w = (this.read + this.count) % this.size;
      this.left[w] = l[i];
      this.right[w] = r[i];
      this.count++;
    }
    while (this.count > this.maxLatency) { this.read = (this.read + 1) % this.size; this.count--; }
  }

  process(_inputs, outputs) {
    const [outL, outR] = outputs[0];
    for (let i = 0; i < outL.length; i++) {
      if (this.count > 0) {
        outL[i] = this.left[this.read];
        if (outR) outR[i] = this.right[this.read];
        this.read = (this.read + 1) % this.size;
        this.count--;
      } else {
        outL[i] = 0;
        if (outR) outR[i] = 0;
      }
    }
    return true;
  }
}

registerProcessor("nes-audio", NesAudio);
