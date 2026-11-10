# Fork de jsnes

Copia de `jsnes@2.1.0` (https://github.com/bfirsh/jsnes, licencia Apache-2.0, ver `LICENSE`),
carpeta `src/`, sin el directorio `browser/` (la interfaz es nuestra) ni los `.d.ts`.

Cambios respecto al original (anotar aquí cada modificación, como pide la licencia):

- `index.js`: ya no exporta `Browser`.
- `nes.js`: opción `fourScore` y mandos 3 y 4 (también en `toJSON`/`fromJSON`).
- `mappers/mapper0.js`: lectura serie de `$4016`/`$4017` con el protocolo Four Score
  (`_serialBit`). Sin `fourScore` se comporta como antes, salvo que tras 24 lecturas
  ya no vuelve a empezar desde el bit 0 (en hardware real sigue devolviendo 1).
- `ppu/index.js` + `nes.js`: overclock opcional (`setOverclock(n)`): la última línea de
  VBlank se repite n veces; la CPU ejecuta y la PPU no avanza. El audio se ajusta con
  `setFrameRate` para mantener las muestras por fotograma. Se guarda en el estado.
