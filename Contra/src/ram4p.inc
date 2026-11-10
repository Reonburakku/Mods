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

; --- intercambio de contexto J3/J4 (Players4P en fixed.asm) ---
Pass34        = $6018     ; 1 mientras se ejecuta la lógica de jugadores con J3/J4
SaveF1        = $6019     ; [4] $F1,$F2,$F5,$F6 de J1/J2 durante la pasada de J3/J4
Comb2F        = $601D     ; resultados compartidos de la pasada de J1/J2
Comb8E        = $601E
Comb68        = $601F
Ctx34         = $6020     ; [88] estado de la pareja que NO está cargada (J3/J4 normalmente)
CTX_ZP_LEN    = $4C       ;   +$00..+$4B: $90-$DB (estado del jugador, arrays de 2)
Ctx_Lives     = $606C     ;   [2] $32/$33  vidas
Ctx_Over      = $606E     ;   [2] $38/$39  0 = jugando, distinto de 0 = fuera de la partida
Ctx_Spr       = $6070     ;   [2] $0300/$0301 sprite (0 = no se dibuja)
Ctx_Y         = $6072     ;   [2] $031A/$031B Y
Ctx_X         = $6074     ;   [2] $0334/$0335 X
Ctx_Attr      = $6076     ;   [2] $034E/$034F atributos
PushA         = $6078     ; la pareja J1/J2 empujó la pantalla en este fotograma
PushB         = $6079     ; la pareja J3/J4 empujó la pantalla
PlayActive    = $607A     ; Players4P lo pone a 30; ReadPads4 lo baja. <> 0 = partida en marcha
                          ; (lo lee la web para avisar "pulsa START para entrar")
