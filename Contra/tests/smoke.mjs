// Fase 0: Contra arranca en Node, se puede empezar partida y hacer capturas.
// Uso: node tests/smoke.mjs [ruta.nes]
import { TestConsole, BTN } from "./lib/console.mjs";

const rom = process.argv[2] ?? "rom/Contra.nes";
const out = "tests/out";
const c = new TestConsole(rom);

c.run(240);                         // intro (Konami / pantalla de título)
c.screenshot(`${out}/01-titulo.png`);
c.press(0, BTN.START, 4, 60);       // salta la animación del título
c.press(0, BTN.START, 4, 300);      // empezar partida 1 jugador
c.screenshot(`${out}/02-inicio-nivel.png`);
// andar a la derecha disparando unos segundos
for (let i = 0; i < 240; i++) c.frame([BTN.RIGHT | (i & 8 ? BTN.B : 0), 0]);
c.screenshot(`${out}/03-jugando.png`);
console.log(`fotogramas: ${c.frameCount}  hash RAM: ${c.ramHash().toString(16)}`);
