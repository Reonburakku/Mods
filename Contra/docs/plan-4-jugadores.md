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
4. **Datos por jugador mediante intercambio de contexto** (ver [ram-jugadores.md](ram-jugadores.md)): la lógica de jugadores se ejecuta una segunda vez con el estado de J3/J4 cargado en las posiciones de J1/J2. Además hay que adaptar la lógica de `eor #$01`.
5. **Bucles de jugadores de 0-1 a 0-3** y máscaras de jugadores vivos de 4 bits.
6. **Jugadores 3 y 4 en pantalla:** reparto de los 64 sprites de OAM, paletas compartidas (solo hay 4 paletas de sprites), balas y colisiones.
7. **Reglas de juego:** aparición, muertes, robo de vidas, game over, continuar, scroll (quién empuja la pantalla) y el nivel en vista trasera (base).
8. **Menú** de 1-4 jugadores y HUD de vidas para 4.
