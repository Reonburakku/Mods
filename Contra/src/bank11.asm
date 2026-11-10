; ============================================================
; Banco 11  ($8000-$BFFF)  [intercambiable, NUEVO: no existe en la ROM original]
; Libre para el código y los datos de 4 jugadores.
; Cambiar a este banco: ldy #$0B / jsr SwitchBank
; ============================================================
.include "nes.inc"
.base $8000

    .byte $0B                       ; número de banco (SwitchBank lo lee en $8000)

; --- espacio libre hasta el final del banco ---
.org $C000, $FF
