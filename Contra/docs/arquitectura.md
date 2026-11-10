# Arquitectura: Contra para 4 jugadores en la web

## Objetivo

- Página web **estática**, sin servidor propio (GitHub Pages, Netlify o similar).
- Hasta **4 jugadores** en la misma partida, con **máximo 2 por dispositivo**. Por ejemplo, 2 dispositivos con 2 jugadores cada uno, o 4 dispositivos con 1.
- Funciona en PC (teclado o mandos) y en móvil (controles táctiles).

## La idea clave: la "consola" la ponemos nosotros

En la web, la NES es un emulador que corre en la página y que controlamos por completo. Eso significa que los límites del hardware original se convierten en opciones nuestras:

| Límite de la NES original | En nuestra consola web |
|---|---|
| 8 sprites por línea (parpadeo) | Se desactiva en el emulador |
| 2 KB de RAM | Añadimos 8 KB de RAM extra en `$6000-$7FFF` |
| 128 KB de ROM | Se amplía a 256 KB (16 bancos UNROM) |
| CPU lenta: ralentizaciones con mucha acción | Overclock opcional (líneas de escaneo extra) |
| 2 mandos | 4 mandos con el protocolo estándar del Four Score |
| 64 sprites en total | Se mantiene al principio. Ampliable más adelante con una extensión propia si de verdad hace falta |

**Regla de diseño:** el juego modificado solo usará cosas que existen en el hardware real (Four Score, RAM extra, más bancos). Las mejoras puramente de emulador (sin límite de sprites, overclock) son opciones, no requisitos. Así la ROM también se puede depurar en Mesen o FCEUX, y la lógica del juego no depende de un emulador concreto.

## Capas

```
┌─────────────────────────────────────────────────────────────┐
│ 5. Interfaz: sala / código de partida, asignación de mandos, │
│    controles táctiles, pantalla completa, configuración      │
├─────────────────────────────────────────────────────────────┤
│ 4. Netplay: sincronización por entradas (lockstep → rollback)│
│    • cada fotograma solo viajan los botones (1 byte/jugador) │
│    • comprobación de hash de la RAM para detectar desfases   │
├─────────────────────────────────────────────────────────────┤
│ 3. Transporte: WebRTC DataChannel entre navegadores (P2P)    │
│    • señalización sin servidor propio (relays públicos)      │
├─────────────────────────────────────────────────────────────┤
│ 2. Consola virtual: emulador NES determinista                │
│    step(entradas[4]) · saveState/loadState · hashRAM         │
│    Four Score · RAM $6000 · sin límite de sprites            │
├─────────────────────────────────────────────────────────────┤
│ 1. Juego: ROM de Contra modificada (6502) para 4 jugadores   │
│    (este repositorio: src/*.asm → build/contra.nes)          │
└─────────────────────────────────────────────────────────────┘
```

### 1. Juego (ROM modificada)

Las fases de [plan-4-jugadores.md](plan-4-jugadores.md) siguen valiendo, pero son más sencillas gracias a la RAM y los bancos extra:

- **Datos de los jugadores 3 y 4:** en `$6000+`. No hace falta tocar las tablas originales de 2 entradas.
- **Código nuevo:** en los bancos 8-15. Se llega a él con saltos desde los puntos de enganche, sin desplazar código existente.
- **Mandos:** lectura Four Score (24 bits por puerto).

### 2. Consola virtual (emulador)

Requisitos:

- **Determinista:** mismas entradas dan el mismo resultado en todos los navegadores. Por eso no puede depender del reloj ni de la velocidad del dispositivo, el audio no puede afectar al estado y no puede usar números aleatorios externos.
- `runFrame(inputs)`: avanza exactamente 1 fotograma con los botones de los 4 jugadores.
- `saveState()` / `loadState()` rápidos, para el rollback y para que alguien se una a mitad de partida.
- Rápido: el rollback necesita re-simular varios fotogramas en uno, también en móviles.
- **Se ejecuta también en Node, sin navegador.** Así yo puedo probar automáticamente cada cambio de la ROM: meter pulsaciones, leer la RAM y sacar capturas. Esto sustituye la idea de usar Mesen para las pruebas.

Elegido: **jsnes 2.1.0** (JavaScript, licencia Apache-2.0, sencillo de modificar). Lo haríamos un fork con Four Score, RAM en `$6000`, límite de sprites opcional y estados rápidos. Si se queda corto de velocidad para el rollback en móvil, lo cambiaríamos por un núcleo en WebAssembly (por ejemplo, TetaNES, en Rust). La interfaz de la capa 2 se mantiene igual para que el cambio no afecte al resto.

Resultados de la fase 0 (PC de desarrollo, Node 26; pruebas en `tests/`):

| Prueba | Resultado |
|---|---|
| Contra arranca, título, partida de 1 y 2 jugadores | OK |
| Misma partida (3600 fotogramas de entradas aleatorias) ejecutada dos veces | RAM idéntica en cada fotograma |
| Guardar estado → avanzar → cargar → repetir | Idéntico, también en otra instancia |
| Velocidad | ~800-860 fps (unas 14 veces tiempo real), con o sin sonido |
| `toJSON` / `fromJSON` | 12,8 ms / 3,8 ms, 1,4 MB |

**Conclusión:** la velocidad da para rollback de hasta unos 8 fotogramas en PC. En móvil habrá que medirlo en la fase 1.

El estado de jsnes no sirve tal cual para rollback: guardar tarda casi un fotograma entero (16,7 ms). Ocupa tanto porque incluye búferes que se pueden reconstruir: la imagen, `bgbuffer`, `pixrendered`, la tabla de espejos de VRAM, los 64 KB del mapa de CPU con la ROM incluida, y los tiles decodificados. El fork tendrá un estado binario con solo lo esencial: RAM 2 KB, RAM `$6000` 8 KB, VRAM, OAM, paletas y registros. Debería ocupar unos 30 KB y guardarse en menos de 1 ms.

### 3. Transporte (WebRTC sin servidor)

- Los navegadores se conectan directamente entre sí (P2P) mediante WebRTC DataChannel en modo no fiable y desordenado, como UDP, que es lo que conviene para enviar entradas.
- Para que se encuentren hace falta "señalización". Sin servidor propio se usa la librería **Trystero**, que aprovecha relays públicos (Nostr, MQTT o trackers de BitTorrent) solo para el saludo inicial. Después todo va directo entre jugadores.
- Con 4 dispositivos como máximo, se usa una **malla** (cada uno conectado con todos), que da la latencia más baja.
- **Limitación:** en algunas redes (NAT simétrico, algunas redes de empresa o móviles) el P2P directo falla y haría falta un servidor TURN. Se deja como configuración opcional: quien tenga uno puede ponerlo, pero la página no depende de él.

### 4. Netplay

Primero **lockstep con retardo de entrada**:

- Cada dispositivo aplica sus entradas con 2-3 fotogramas de retraso y las envía a los demás.
- Un fotograma solo se ejecuta cuando están las entradas de todos.
- Es simple y robusto. Se nota como un pequeño retraso en los controles.

Después **rollback** (como GGPO):

- Se ejecuta enseguida "adivinando" que los demás siguen pulsando lo mismo.
- Si llega una entrada distinta, se carga el estado guardado y se re-simulan los fotogramas.
- Los controles responden al instante, a cambio de más CPU.

Mensajes:

- `input {frame, slot, buttons}`, con redundancia: cada paquete repite los últimos N fotogramas por si alguno se pierde.
- `hash {frame, crc}` cada ~60 fotogramas. Si hay desfase, el anfitrión envía su estado completo y todos se resincronizan.
- `join`, `ready`, `start` y `state` para entrar a mitad de partida con un estado completo (~10-20 KB).

Plazas: el anfitrión reparte los jugadores 1-4. Cada dispositivo declara cuántos jugadores locales tiene (1 o 2) y recibe sus plazas.

### 5. Interfaz

- **Pantallas:** carga de ROM → sala (crear o unirse con código o enlace) → asignación de mandos → partida.
- **Controles:** teclado (2 esquemas para 2 jugadores locales), API Gamepad (mandos USB o Bluetooth) y cruceta táctil en móvil. El máximo de 2 jugadores locales lo impone esta capa.
- **Indicadores:** ping, retardo y aviso de desconexión. Si alguien se cae, su jugador se queda quieto y puede reconectarse cargando el estado.

## Distribución de la ROM: Azure Blob Storage

La ROM ya modificada se publica en un contenedor de Azure Blob Storage y la página la descarga al arrancar.

```
Azure Blob (contenedor "roms")
  manifest.json          {"version": "0.3.0", "file": "contra4p-0.3.0.nes", "sha1": "…"}
  contra4p-0.3.0.nes     ROM final ya parcheada (nombre con versión = inmutable)
```

Flujo en el navegador:

1. Descargar `manifest.json` siempre, sin caché (`Cache-Control: no-cache`).
2. Si la ROM de esa versión ya está guardada en IndexedDB, usarla sin descargar.
3. Si no, descargar el `.nes`, comprobar su SHA-1 contra el manifiesto y guardarlo en IndexedDB.
4. En la sala, todos los dispositivos intercambian versión y SHA-1. Si no coinciden, no se puede empezar la partida.

Configuración necesaria en Azure:

- **CORS** en la cuenta de almacenamiento: permitir `GET` desde el dominio de la web (y `http://localhost` para desarrollo). Sin esto, el navegador bloquea la descarga.
- **Caché:** los `.nes` con versión en el nombre con `Cache-Control: public, max-age=31536000, immutable`. El manifiesto con `no-cache`.
- **Publicar una versión nueva:** primero se sube el `.nes`, después se actualiza el manifiesto. Así nadie recibe un manifiesto que apunta a un archivo que todavía no existe.
- **Despliegue:** `tools/` tendrá un script que construye la ROM, calcula el SHA-1 y lo sube con `az storage blob upload`.

Con esto ya no hace falta el parcheador en el navegador ni que cada jugador tenga su propia ROM: todos descargan exactamente el mismo archivo.

### Acceso: blob público (decidido)

- El contenedor tiene acceso de lectura anónimo a nivel de blob (`--public-access blob`). Así se pueden descargar los archivos por su URL, pero no listar el contenido del contenedor.
- La página no necesita credenciales.
- El script de despliegue usa las credenciales de quien publica (`az login`). Nunca van en la web.
- Los aspectos legales de distribuir la ROM son responsabilidad del propietario del proyecto.

## Estructura del repositorio

```
src/, tools/        ROM modificada (lo que ya existe)
tools/deploy.py     construye la ROM, genera manifest.json y sube ambos a Azure Blob
web/
  index.html
  emu/              fork del emulador (capa 2)
  net/              transporte + netplay (capas 3-4)
  ui/               interfaz, entradas, táctil (capa 5)
  rom/              descarga desde Azure Blob, verificación SHA-1, caché en IndexedDB
tests/              pruebas en Node: ejecutan la ROM sin navegador y
                    comprueban RAM, determinismo y sincronización
```

## Fases

Cada fase deja algo jugable.

0. **Base de pruebas.** Emulador en Node, Contra arranca, partida grabada (entradas) reproducible y siempre con el mismo hash de RAM.
1. **Web local.** Descargar la ROM desde Azure Blob (con caché), jugar 1-2 jugadores en un dispositivo (teclado, mando y táctil).
2. **Netplay con el Contra original.** 2 dispositivos con 1 jugador cada uno. Valida toda la parte de red con un juego que ya funciona, antes de tocar la ROM. ✅ Hecha:
   - `web/net/lockstep.js`: retardo de entrada y reenvío hasta confirmación. Funciona igual con un canal fiable o no.
   - `web/net/session.js`: sala con Trystero/Nostr. El anfitrión reparte las plazas y elige el retardo con `recommendedDelay()` a partir del ping (mediana y percentil 90).
   - `tests/netplay.mjs`: red simulada (retardo, jitter, pérdidas, relojes desfasados) con 2-4 dispositivos. La RAM es idéntica en todos los casos y el juego va a ~100% de velocidad.
   - Probada con dos pestañas del navegador: los dos dispositivos van a 60 fps sin desincronizaciones.
   - Requiere `https://` o `localhost`: Trystero usa `crypto.subtle`.
   - Con la pestaña oculta, un Worker mantiene el bucle para no bloquear a los demás.
   - Pendiente para la fase 5: recuperación tras desincronización o desconexión (ahora solo se avisa).
3. **ROM para 4 jugadores**, probada en local con 4 mandos simulados en las pruebas de Node.
4. **Netplay a 4:** 2 dispositivos con 2 jugadores o 4 dispositivos con 1.
5. **Pulido:** rollback, unirse a mitad de partida, reconexión y móviles.

Las fases 1-2 (web) y 3 (ROM) son independientes y se pueden trabajar en paralelo.
