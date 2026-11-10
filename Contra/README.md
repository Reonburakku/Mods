# Contra (NES) – desensamblado para mods

ROM: **Contra (USA)**, mapper 2 (UNROM), 8 bancos PRG de 16 KB, sin chip de gráficos (usa CHR-RAM).
SHA-1 de la original: `c9ea66bb7cb30ad5343f1721b1d4d3219859319b`

## Estructura

| Ruta | Qué es |
|---|---|
| `rom/Contra.nes` | ROM original (no la toques: se usa para comparar) |
| `src/bank0.asm` … `bank7.asm` | El código fuente desensamblado. **Aquí haces los cambios.** |
| `src/nes.inc` | Nombres de registros de hardware (PPU, APU, mandos) y variables de RAM |
| `src/header.bin` | Cabecera iNES de 16 bytes |
| `build/contra.nes` | La ROM que generas |
| `tools/build.py` | Ensamblador: `src/*.asm` → `build/contra.nes` |
| `tools/disasm.py` | Desensamblador: ROM → `src/*.asm` (ya ejecutado) |
| `tools/disasm_config.py` | Lo que sabemos a mano de la ROM: nombres, comentarios, tablas |

## Mapa de memoria

- `$C000-$FFFF`: **banco 7**, siempre cargado. Motor principal: arranque, NMI, cambio de banco, IA común.
- `$8000-$BFFF`: uno de los bancos 0-6, según cuál se haya seleccionado.
  - Banco 0: IA de enemigos. Banco 1: motor de sonido y música.
  - Bancos 2-6: sobre todo datos (niveles, gráficos comprimidos, música) y algo de código.
- El primer byte de cada banco (`$8000`) es su propio número; `SwitchBank` lo usa para saber qué banco está activo.
- Cambiar de banco: `ldy #N` + `jsr SwitchBank`.

## Flujo de trabajo

1. Edita `src/bankN.asm`.
2. Ejecuta:
   ```
   python tools/build.py
   ```
3. Abre `build/contra.nes` en un emulador. Te recomiendo **Mesen**, que tiene un depurador muy bueno para encontrar qué rutina hace qué.

`build.py` siempre te dice qué bytes cambiaron respecto a la original. Si no has tocado nada, dirá
`Idéntica a la ROM original.`

## Lectura del código

```
L_C003:
    lda PPUSTATUS               ; C003  AD 02 20
    bpl L_C003                  ; C006  10 FB
```
- `L_xxxx` / `L3_xxxx`: código (banco 7 / banco 3). `D_xxxx` / `D3_xxxx`: datos.
- El comentario de cada línea indica la dirección original y los bytes, así puedes cruzarlos con lo que ves en el depurador del emulador.
- `.byte` es todo lo que no se identificó como código. Son datos (gráficos, niveles, textos) o código al que no se pudo llegar automáticamente.
- `lda a:$0012`: fuerza la versión de 3 bytes de la instrucción. Así lo tenía el juego original, no lo cambies.

## Reglas importantes al modificar

1. **Lo más seguro es cambiar valores sin cambiar el tamaño**. Por ejemplo, `lda #$03` → `lda #$09`, o retocar una tabla `.byte`.
2. **Si añades o quitas bytes**, todo lo que hay detrás en ese banco se desplaza:
   - Las etiquetas (`jsr L_C8C4`, `.word L0_8147`) se recolocan solas.
   - Las **direcciones escritas como número** (por ejemplo `jsr $8712` o `lda $9A00,y`) **no se recolocan**. Tampoco las direcciones que estén dentro de bloques `.byte`. Si las desplazas, el juego se cuelga.
   - Por eso cada banco termina con un bloque de espacio libre y `.org`. Si añades pocos bytes, el espacio libre absorbe el cambio y lo que viene después del `.org` no se mueve. Aun así, el código entre tu cambio y el espacio libre sí se desplaza.
3. **Para meter código nuevo sin riesgo**, ponlo en el espacio libre y llega a él con un salto:
   ```
   ; donde quieras engancharte (sustituye una instrucción de 3 bytes)
       jsr MiRutina
   ...
   ; --- espacio libre ---
   MiRutina:
       ; instrucción original que has sustituido
       ; tu código nuevo
       rts
   .org $FC00, $FF          ; el resto del espacio libre se reduce solo
   ```
   Espacio libre disponible: banco 7 `$F612-$FBFF` (1518 bytes), banco 5 `$B632-$BFFF` (2510 bytes) y unos 500-700 bytes al final de la mayoría de los demás bancos.
4. Si te pasas del tamaño, `build.py` te dice exactamente cuántos bytes sobran.

## Mejorar el desensamblado

En `tools/disasm_config.py` puedes añadir nombres de etiquetas, comentarios, variables de RAM y puntos de entrada de código.

Hazlo **antes** de empezar a modificar `src/`. Regenerar sobrescribe tus cambios, por eso pide `--force`:
```
python tools/disasm.py --force
```

Para Contra existe un desensamblado comunitario muy documentado, [vermiceli/nes-contra-us](https://github.com/vermiceli/nes-contra-us). Sirve de referencia para saber qué hace cada rutina y qué significa cada variable de RAM.

## Web (fase 1: juego local)

Estructura en `web/` (ver [docs/arquitectura.md](docs/arquitectura.md)):

| Ruta | Qué es |
|---|---|
| `web/index.html`, `main.js`, `style.css` | La página y el bucle de juego (60,0988 fps fijos) |
| `web/config.js` | URL de la carpeta con `manifest.json` (desarrollo: `./rom-dev/`) |
| `web/rom/loader.js` | Descarga, verificación SHA-1 y caché en IndexedDB |
| `web/emu/core.js` | Núcleo del emulador; lo usan la web y las pruebas (`tests/`) |
| `web/emu/jsnes/` | Fork de jsnes 2.1.0 (Apache-2.0); los cambios se anotan en `FORK.md` |
| `web/ui/` | Pantalla, audio (AudioWorklet), teclado, mandos y táctil |

Probar en local:
```
python tools/build.py
python tools/release.py 0.0.1
python -m http.server 8080 --directory web
```
y abrir http://localhost:8080.

Publicar la ROM en Azure Blob (requiere `az login`):
```
python tools/release.py 0.1.0 --upload --account MI_CUENTA --container roms
```
Después, en `web/config.js`, poner `ROM_BASE_URL` a `https://MI_CUENTA.blob.core.windows.net/roms/`, o abrir la página con `?rom=<esa URL>`.

`web/rom-dev/` contiene la ROM: **no la subas** con la web; la ROM se sirve desde el blob.

Controles: jugador 1 con W A S D, J (disparar) y K (saltar), G (Select) y H o Enter (Start). Jugador 2 con flechas, coma, punto, M y guion. Mandos: el primero es el jugador 1. En móvil aparecen controles táctiles.
