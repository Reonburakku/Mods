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
- `ppu/index.js`: paletas extra de sprites (extensión cosmética). La ROM marca entradas del
  OAM en `$5000-$503F` (valor = nº de paleta extra, 0 = normal) y define los colores en
  `$5040 + 4*n + 1..3`. La tabla se copia con la DMA de OAM (`spriteExt`) y se guarda el
  índice de OAM de cada sprite evaluado (`scanlineSpriteIndex`). En una NES real esas
  escrituras se ignoran.
- `ppu/index.js` + `nes.js`: sin límite de 8 sprites por línea (`setSpriteLimit(false)`).
  La evaluación del hardware no cambia (flags de desbordamiento y sprite 0 iguales); una
  pasada aparte recoge todos los sprites de cada línea solo para dibujarlos.
