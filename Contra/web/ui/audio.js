// Sonido: el núcleo entrega muestras una a una; las agrupamos por fotograma y
// las mandamos al reproductor. Debe crearse tras un gesto del usuario (clic/tecla).
//
// Reproductor preferido: AudioWorklet (hilo de audio propio, sin cortes).
// Alternativa: ScriptProcessorNode, porque AudioWorklet solo existe en contextos
// seguros (https:// o localhost) y no funciona al abrir la página por http://<IP>.
export class Audio {
  static async create() {
    const ctx = new AudioContext({ latencyHint: "interactive" });
    const gain = ctx.createGain();
    gain.connect(ctx.destination);
    let sink;
    if (ctx.audioWorklet) {
      await ctx.audioWorklet.addModule(new URL("./audio-worklet.js", import.meta.url));
      const node = new AudioWorkletNode(ctx, "nes-audio", { outputChannelCount: [2] });
      node.connect(gain);
      sink = (left, right) => node.port.postMessage({ left, right }, [left.buffer, right.buffer]);
    } else {
      sink = scriptProcessorSink(ctx, gain);
    }
    return new Audio(ctx, gain, sink);
  }

  constructor(ctx, gain, sink) {
    this.ctx = ctx;
    this.gain = gain;
    this.sink = sink;
    this.left = [];
    this.right = [];
    this.muted = false;
    /** Callback para el núcleo: una muestra estéreo. */
    this.onSample = (l, r) => { this.left.push(l); this.right.push(r); };
  }

  get sampleRate() { return this.ctx.sampleRate; }

  /** Envía las muestras acumuladas durante el fotograma. */
  flush() {
    if (this.left.length === 0) return;
    const left = Float32Array.from(this.left);
    const right = Float32Array.from(this.right);
    this.left.length = 0;
    this.right.length = 0;
    this.sink(left, right);
  }

  setMuted(m) {
    this.muted = m;
    this.gain.gain.value = m ? 0 : 1;
  }

  resume() { return this.ctx.resume(); }
}

/** Misma cola circular que audio-worklet.js, pero en el hilo principal. */
function scriptProcessorSink(ctx, dest) {
  const size = 16384;
  const bufL = new Float32Array(size), bufR = new Float32Array(size);
  const maxLatency = Math.round(ctx.sampleRate * 0.15);
  let read = 0, count = 0;
  const node = ctx.createScriptProcessor(2048, 0, 2);
  node.onaudioprocess = (e) => {
    const outL = e.outputBuffer.getChannelData(0), outR = e.outputBuffer.getChannelData(1);
    for (let i = 0; i < outL.length; i++) {
      if (count > 0) {
        outL[i] = bufL[read]; outR[i] = bufR[read];
        read = (read + 1) % size; count--;
      } else {
        outL[i] = 0; outR[i] = 0;
      }
    }
  };
  node.connect(dest);
  return (l, r) => {
    for (let i = 0; i < l.length; i++) {
      if (count === size) { read = (read + 1) % size; count--; }
      const w = (read + count) % size;
      bufL[w] = l[i]; bufR[w] = r[i];
      count++;
    }
    while (count > maxLatency) { read = (read + 1) % size; count--; }
  };
}
