; ============================================================
; RAM extra de 4 jugadores ($6000-$7FFF, 8 KB declarados en la cabecera NES 2.0)
; ReadPads4 borra $6000-$60FF la primera vez (cuando Ram4Magic no es $C4,$4A).
; No se borra toda al arrancar porque tardaría ~4 fotogramas y cambiaría el ritmo del juego.
; Los arrays por jugador tienen 4 entradas: índice X = 0-3 (J1-J4).
; ============================================================

; --- mandos (los escribe ReadPads4 en cada NMI) ---
Pad4Held      = $6000     ; [4] botones pulsados ahora   (J1/J2 = copia de $F1/$F2)
Pad4New       = $6004     ; [4] recién pulsados          (J1/J2 = copia de $F5/$F6)
Pad4Prev      = $6008     ; [4] fotograma anterior       (J1/J2 = copia de $F9/$FA)
Pad4RawA      = $600C     ; [4] lectura en curso
Pad4RawB      = $6010     ; [4] primera lectura (se comparan para evitar fallos por DPCM)
Pad4Sig       = $6014     ; [2] firma leída en $4016/$4017 ($10/$20 = Four Score)
FourScoreOn   = $6016     ; 1 si hay adaptador Four Score
Ram4Magic     = $60FE     ; [2] $C4,$4A = RAM extra inicializada

; Bits de los botones (orden en que los deja la rutina de lectura)
PAD_A      = $80
PAD_B      = $40
PAD_SELECT = $20
PAD_START  = $10
PAD_UP     = $08
PAD_DOWN   = $04
PAD_LEFT   = $02
PAD_RIGHT  = $01
