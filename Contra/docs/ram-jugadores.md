# Mapa de la RAM por jugador (medido)

Obtenido con `node tests/ram-map.mjs`: una partida de 10 minutos a 2 jugadores con entradas aleatorias, registrando cada escritura indexada (`sta base,x`, `sta base,y`…). El listado completo se genera en `tests/out/ram-map.txt`.

## Datos de cada jugador (arrays de 2 entradas, índice X = 0/1)

| Zona | Qué es | Notas |
|---|---|---|
| `$0090-$00DB` | **Estado del jugador**: unos 38 arrays de 2 bytes intercalados (`$90,x`, `$92,x` … `$DA,x`) | Página cero. Lo escriben sobre todo `$D4xx-$DBxx` del banco fijo y algunas rutinas del banco 2 (`$B0xx-$B2xx`) y del banco 6 (`$B3xx-$B5xx`). `$DAD3-$DB25` inicializa todos a la vez. |
| `$0032,x` | Vidas | `$C469`, `$DA03` |
| `$0038,x` | Estado de partida del jugador (game over…) | `$DA08`; `$D3C0-$D3CA` construye una máscara de jugadores vivos con `$38`/`$39` |
| `$00F1/$F5/$F9,x` | Mandos (pulsado, recién pulsado, anterior) | Ahora los escribe `ReadPads4` (`$F6xx`) |
| `$0300,x` `$031A,x` `$0334,x` `$034E,x` | Slots 0-1 de la **tabla de objetos en pantalla** (26 slots) | Jugadores = slots 0-1; los enemigos usan los slots 2+ (índice de enemigo + 2) |

## Otras tablas relevantes

| Zona | Qué es |
|---|---|
| `$0368-$04B7` | **Balas de los jugadores**: 21 arrays de 16 entradas (índices vistos: 0-3 y 10-15; probablemente 0-9 para J1 y 10-15 para J2, o viceversa) |
| `$04B8-$05F7` | **Enemigos**: 20 arrays de 16 entradas |
| `$0200-$02FF` | Copia de la OAM (64 sprites), la escribe el banco 1 (`$AED9-$B025`) |
| `$0600-$06FF`, `$0700-$07FF` | Búferes de actualización de la PPU y otros |

## Consecuencia para 4 jugadores: "intercambio de contexto"

Reescribir todas las instrucciones que usan `$90,x … $DA,x` para 4 jugadores no es viable: son cientos de instrucciones en 3 bancos y la página cero no tiene sitio.

En su lugar se propone **ejecutar la lógica de jugadores dos veces por fotograma**:

1. Pasada normal con J1/J2 (como el original).
2. Guardar `$90-$DB`, `$32-$33`, `$38-$39`, los slots 0-1 de objetos y los mandos `$F1/$F5/$F9` en la RAM extra, y cargar en su lugar los de J3/J4.
3. Ejecutar la misma rutina de jugadores, que trata a J3/J4 como si fueran J1/J2.
4. Guardar J3/J4 y restaurar J1/J2.

Coste: unos 80 bytes × 4 copias por fotograma (~2000 ciclos). Hay que confirmar que cabe en el tiempo de fotograma.

### Qué hay que resolver aparte

- **Sprites de J3/J4:** necesitan sus propios slots en la tabla de objetos (o dibujarse aparte). Si no, en el paso 2 sobrescribirían los de J1/J2.
- **Balas:** las 16 entradas están repartidas entre J1 y J2. Con 4 jugadores hay que repartirlas o ampliarlas (por ejemplo, 8 por jugador) y mover la tabla a la RAM extra.
- **Enemigos que apuntan o chocan con jugadores:** las rutinas de enemigos recorren X = 0-1 para elegir objetivo y detectar colisiones. Hay que ampliarlas a 4 o ejecutarlas también en el contexto de J3/J4.
- **Lógica entre jugadores:** `eor #$01` ("el otro jugador", por ejemplo para quitarle una vida) y la máscara de vivos de 2 bits (`$D3C0-$D3CA`).
- **Scroll:** quién empuja la pantalla, que tiene que considerar a los 4.
- **Interfaz:** vidas de J3/J4 en el HUD y menú de 1-4 jugadores.
