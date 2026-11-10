# Plan: Contra para 4 jugadores simultáneos

## Lo que se ha averiguado del código original

| Pieza | Dónde | Por qué es un problema para 4 jugadores |
|---|---|---|
| Lectura de mandos | `L_C397` ($C397, banco 7) | Lee 8 bits de `$4016`/`$4017`. El adaptador Four Score necesita leer 24 bits por puerto: J1/J3 en `$4016` y J2/J4 en `$4017`. |
| Estado de los mandos | `$F1-$F2` (pulsado), `$F5-$F6` (recién pulsado), `$F9-$FA` (anterior) | Son arrays de 2 bytes en página cero, indexados con X = 0/1. Los bytes siguientes ya están ocupados, así que no caben 4 jugadores. |
| Datos por jugador | Arrays `,x` con X = 0/1 por todo el banco 7 (p. ej. `$38,x`, `$32,y`) | Todos tienen 2 entradas. Hay que moverlos a RAM con sitio para 4. |
| Lógica de "el otro jugador" | 16 apariciones de `eor #$01` | Con 4 jugadores no hay un único "otro" (por ejemplo, para quitarle una vida a un compañero). |
| Máscaras de jugadores vivos | `ora #$01` / `ora #$02` en $D3C4-$D3CA | Solo contemplan 2 bits. |
| Modo 1 o 2 jugadores | Variable `$22` y el menú del título | Hay que añadir 3 y 4 jugadores. |
| Página cero | 196 de 256 direcciones referenciadas | Prácticamente llena: los nuevos arrays van en la RAM extra `$6000-$7FFF`. |

## Contexto

El juego se ejecutará en nuestro emulador web (ver [arquitectura.md](arquitectura.md)). Por eso:

- Hay **8 KB de RAM extra en `$6000-$7FFF`**: los datos de los jugadores 3 y 4 van ahí, sin tocar las tablas originales.
- La ROM se amplía a **256 KB**: el código nuevo va en los bancos 7-14 (el 15 es el fijo). La tabla anti-conflictos de bus en `$FFD0` ya cubre 0-15.
- **Sin límite de 8 sprites por línea** (opción del emulador). El límite de 64 sprites en total sigue existiendo.
- Las pruebas se hacen con el mismo emulador ejecutándose en Node.

## Fases de la ROM

1. ✅ **Ampliar la ROM** a 16 bancos, con cabecera NES 2.0 que declare la RAM en `$6000`. Comprobado: idéntica a la original fotograma a fotograma. El banco fijo pasa a `src/fixed.asm` y los bancos nuevos 7-14 están vacíos.
2. ✅ **Mapa de RAM real:** en [ram-jugadores.md](ram-jugadores.md) (`tests/ram-map.mjs`). El estado de cada jugador ocupa `$90-$DB` en arrays de 2 entradas intercalados; la estrategia propuesta es el intercambio de contexto.
3. ✅ **Lectura Four Score** de 4 mandos en arrays de 4 (`Pad4Held/New/Prev` en `$6000+`, ver `src/ram4p.inc`). J1/J2 siguen funcionando como en el original. Al acabar esta fase, el juego sigue siendo de 2 jugadores.
   - Nota: desde aquí la ROM ya no es idéntica fotograma a fotograma a la original. Contra genera su azar en el bucle de espera (`$C057`), y la NMI ahora tarda algo más.
4. 🟡 **J3/J4 en juego mediante intercambio de contexto** (ver [ram-jugadores.md](ram-jugadores.md)). Hecho en la versión 0.1.0 de la ROM:
   - `Players4P` (`fixed.asm`): la lógica de jugadores (`L_D3B4`) se ejecuta otra vez con el estado de J3/J4 (`Ctx34` en `$6020`) cargado en el lugar de J1/J2. Los resultados compartidos se combinan: `$2F` y `$68` con el máximo, `$8E` con OR.
   - J3/J4 entran pulsando START durante la partida, con 3 vidas. Al empezar una partida o continuar quedan fuera.
   - Scroll: si una pareja empuja la pantalla y la otra no, los de la otra se desplazan 1 píxel por fotograma (como hace `L_D42C` dentro de una pareja). Solo en niveles horizontales.
   - Sprites: el dibujado (banco 1, `R4P_Next`) añade J3/J4 después de los 26 objetos.
   - Balas: comparten las 16 entradas. En la pasada de J3/J4, J3 busca hueco desde 2 y J4 desde 4 (`BulletBase4P`, banco 6).
   - Pruebas: `tests/play4p.mjs` (entrar, moverse, disparar, empujar la pantalla, 2 minutos sin cuelgues).
   - Enemigos contra J3/J4 (`Collide34`, dentro de la pasada de J3/J4): mismo choque enemigo-jugador (`L_E1D9`) y mismas condiciones que el bucle de enemigos. Usa las posiciones de los enemigos del fotograma anterior.
   - Puntería (`Target4P`, al principio de `L_F52C`): según el enemigo y cada 64 fotogramas, los enemigos apuntan a J3/J4 si alguno está vivo. Dentro de la pareja se respeta la elección original (`$0A`).
   - Pruebas (`tests/play4p.mjs`): J3/J4 mueren en proporción parecida a J1/J2 y reciben alrededor de la mitad de los disparos apuntados.
   - Coste: sin overclock, un 7,4 % de fotogramas lentos con 4 jugadores en juego intenso (0,1 % con 2). Cada intercambio de contexto cuesta unos 2.100 ciclos.
   - **Overclock del emulador** (`Core({overclock})`, fork de jsnes): repite la última línea de VBlank N veces. Con **60 líneas, 0 % de fotogramas lentos** y la emulación sigue a ~660 fps. Va en el manifiesto de la ROM (`overclock: 60`, `release.py --overclock`); en red lo fija el anfitrión al dar la salida. Comprobado: sigue siendo determinista (también guardando y cargando estado) y el audio mantiene las muestras por fotograma.

   - **Colores propios** (J3 verde, J4 amarillo) con una extensión cosmética del emulador: la ROM marca en `$5000-$503F` qué entradas del OAM son de J3/J4 (`MarkExtPal`, banco 1) y define los colores en `$5040+`. El emulador copia esas marcas con la DMA de OAM y dibuja esos sprites con su paleta extra. En una NES real esas escrituras se ignoran y J3/J4 se verían como J1/J2.
   - **Sin límite de 8 sprites por línea** en el emulador (solo la imagen; la simulación es idéntica, comprobado).

   - **Reglas** (0.1.6):
     - J3/J4 entran con START una sola vez por partida (`Joined34`); tras su game over quedan fuera, como J1/J2, hasta continuar o empezar otra partida.
     - El game over solo llega cuando están fuera los cuatro (`AllOut4P`, en `$CEF1`).
     - Para pasar de nivel tras el jefe también cuentan J3/J4 vivos (`CountAlive4P`, en `$D011`).

   - **Cascada y base** (0.1.7):
     - En la cascada, si una pareja hace subir la pantalla, los de la otra bajan `$68` píxeles (como hace `L_D42C` con el compañero) y, si se quedan atrás, caen.
     - En la base no hay desplazamiento. J3/J4 aparecen 24 píxeles a los lados de J1/J2 (`SpawnX4P`) para no taparse.
     - Para probar un nivel concreto, las pruebas mantienen `$30` (nivel) durante la presentación.

   - **Puntos** (0.1.8):
     - Las balas de J3/J4 llevan dueño 2/3 (`BulletOwner4P`, banco 6).
     - `Score4P` (entradas de `L_C4A0`/`L_C4A8`) suma los de J3/J4 en `Score34`, con su vida extra (`Thresh34`) y el récord.
     - La web muestra los 4 marcadores debajo de la pantalla, porque el marcador del juego solo tiene sitio para 1P/2P.

   - **Robo de vidas entre parejas** (0.1.9, `StealCross`):
     - Si el compañero de pareja no puede dar una vida (el original, `$D3E6`), quien está fuera y pulsa A la recibe del jugador de la otra pareja con más vidas.
     - Se aplican las mismas condiciones del original para el donante.
     - Solo puede pedir quien ha jugado esa partida.

   **Pendiente**: nada de la lista inicial. Ideas para más adelante:
   - Rollback en el juego en red (controles sin retardo).
   - Estado binario rápido del emulador.
   - Marcador de J3/J4 dentro del propio juego (pantalla de pausa y de game over).

5. ✅ **Bucles de jugadores de 0-1 a 0-3**: resuelto por el intercambio de contexto (fase 4), sin tocar los bucles originales.
6. ✅ **Jugadores 3 y 4 en pantalla** (fase 4: sprites, colores, balas, colisiones). Planteamiento inicial: reparto de los 64 sprites de OAM, paletas compartidas (solo hay 4 paletas de sprites), balas y colisiones.
7. ✅ **Reglas de juego** (fase 4). Planteamiento inicial: aparición, muertes, robo de vidas, game over, continuar, scroll (quién empuja la pantalla) y el nivel en vista trasera (base).
8. ✅ **Menú y HUD**: J3/J4 entran con START durante la partida (no hace falta menú) y la web muestra puntos y vidas de los 4.
