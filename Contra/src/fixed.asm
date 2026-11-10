; ============================================================
; Contra (USA) - banco fijo  ($C000-$FFFF)  [último banco de la ROM]
; Generado por tools/disasm.py. Las etiquetas L_ son código, D_ son datos.
; ============================================================
.include "nes.inc"
.include "ram4p.inc"
.base $C000

    .byte $07
; Punto de entrada al encender / reset

Reset:
    cld                         ; C001  D8
    sei                         ; C002  78

L_C003:
    lda PPUSTATUS               ; C003  AD 02 20
    bpl L_C003                  ; C006  10 FB

L_C008:
    lda PPUSTATUS               ; C008  AD 02 20
    bpl L_C008                  ; C00B  10 FB
    lda #$00                    ; C00D  A9 00
    sta $18                     ; C00F  85 18
    jsr DisablePPU              ; C011  20 17 C1
    ldx #$FF                    ; C014  A2 FF
    txs                         ; C016  9A
    lda #$01                    ; C017  A9 01
    ldx #$01                    ; C019  A2 01
    ldy #$BF                    ; C01B  A0 BF
    jsr ClearRAMPages           ; C01D  20 26 C1
    lda #$07                    ; C020  A9 07
    ldx #$05                    ; C022  A2 05
    ldy #$DF                    ; C024  A0 DF
    jsr ClearRAMPages           ; C026  20 26 C1
    ldx #$F0                    ; C029  A2 F0

L_C02B:
    txa                         ; C02B  8A
    cmp $0700,x                 ; C02C  DD 00 07
    bne L_C036                  ; C02F  D0 05
    inx                         ; C031  E8
    bne L_C02B                  ; C032  D0 F7
    beq L_C049                  ; C034  F0 13

L_C036:
    ldx #$F0                    ; C036  A2 F0

L_C038:
    txa                         ; C038  8A
    sta $0700,x                 ; C039  9D 00 07
    inx                         ; C03C  E8
    bne L_C038                  ; C03D  D0 F9
    lda #$C8                    ; C03F  A9 C8
    sta $07E0                   ; C041  8D E0 07
    lda #$00                    ; C044  A9 00
    sta $07E1                   ; C046  8D E1 07

L_C049:
    lda #$00                    ; C049  A9 00
    sta $0700                   ; C04B  8D 00 07
    jsr L_C0DC                  ; C04E  20 DC C0
    jsr L_C183                  ; C051  20 83 C1
    jsr L_C0E7                  ; C054  20 E7 C0

L_C057:
    lda $1A                     ; C057  A5 1A
    adc $34                     ; C059  65 34
    sta $34                     ; C05B  85 34
    jmp L_C057                  ; C05D  4C 57 C0

; Interrupción de VBlank (cada fotograma)

NMI:
    php                         ; C060  08
    pha                         ; C061  48
    txa                         ; C062  8A
    pha                         ; C063  48
    tya                         ; C064  98
    pha                         ; C065  48
    lda PPUSTATUS               ; C066  AD 02 20
    ldy $1B                     ; C069  A4 1B
    bne L_C0B6                  ; C06B  D0 49
    jsr DisablePPU              ; C06D  20 17 C1
    sta OAMADDR                 ; C070  8D 03 20
    ldy #$02                    ; C073  A0 02
    sty OAMDMA                  ; C075  8C 14 40
    jsr L_CC81                  ; C078  20 81 CC
    jsr L_CBC9                  ; C07B  20 C9 CB
    lda $FE                     ; C07E  A5 FE
    ldx $20                     ; C080  A6 20
    beq L_C08A                  ; C082  F0 06
    dec $20                     ; C084  C6 20
    beq L_C08A                  ; C086  F0 02
    lda #$00                    ; C088  A9 00

L_C08A:
    sta PPUMASK                 ; C08A  8D 01 20
    jsr L_C0F7                  ; C08D  20 F7 C0
    inc $1B                     ; C090  E6 1B
    ldy #$01                    ; C092  A0 01
    jsr SwitchBank              ; C094  20 39 C1
    jsr L1_80D5                 ; C097  20 D5 80
    jsr ReadPads4               ; C09A  20 5B C3  [4P] antes: jsr L_C35B
    jsr L_C23B                  ; C09D  20 3B C2
    ldy #$01                    ; C0A0  A0 01
    jsr SwitchBank              ; C0A2  20 39 C1
    jsr L1_AE9D                 ; C0A5  20 9D AE
    jsr L_CBB9                  ; C0A8  20 B9 CB
    lda #$00                    ; C0AB  A9 00
    sta $1B                     ; C0AD  85 1B

L_C0AF:
    pla                         ; C0AF  68
    tay                         ; C0B0  A8
    pla                         ; C0B1  68
    tax                         ; C0B2  AA
    pla                         ; C0B3  68
    plp                         ; C0B4  28

IRQ:
    rti                         ; C0B5  40


L_C0B6:
    lda $FE                     ; C0B6  A5 FE
    ldx $20                     ; C0B8  A6 20
    beq L_C0BE                  ; C0BA  F0 02
    lda #$00                    ; C0BC  A9 00

L_C0BE:
    sta PPUMASK                 ; C0BE  8D 01 20
    lda $8000                   ; C0C1  AD 00 80
    pha                         ; C0C4  48
    lda $1B                     ; C0C5  A5 1B
    bmi L_C0D1                  ; C0C7  30 08
    ldy #$01                    ; C0C9  A0 01
    jsr SwitchBankNoSave        ; C0CB  20 3F C1
    jsr L1_80D5                 ; C0CE  20 D5 80

L_C0D1:
    pla                         ; C0D1  68
    tay                         ; C0D2  A8
    jsr SwitchBankNoSave        ; C0D3  20 3F C1
    jsr L_C104                  ; C0D6  20 04 C1
    jmp L_C0AF                  ; C0D9  4C AF C0


L_C0DC:
    lda #$0F                    ; C0DC  A9 0F
    sta SND_CHN                 ; C0DE  8D 15 40
    lda #$C0                    ; C0E1  A9 C0
    sta JOY2                    ; C0E3  8D 17 40
    rts                         ; C0E6  60


L_C0E7:
    lda #$05                    ; C0E7  A9 05
    sta $20                     ; C0E9  85 20
    lda #$B0                    ; C0EB  A9 B0
    sta $FF                     ; C0ED  85 FF
    sta PPUCTRL                 ; C0EF  8D 00 20
    lda #$05                    ; C0F2  A9 05
    sta $20                     ; C0F4  85 20
    rts                         ; C0F6  60


L_C0F7:
    lda PPUSTATUS               ; C0F7  AD 02 20
    lda #$20                    ; C0FA  A9 20
    sta PPUADDR                 ; C0FC  8D 06 20
    lda #$00                    ; C0FF  A9 00
    sta PPUADDR                 ; C101  8D 06 20

L_C104:
    lda PPUSTATUS               ; C104  AD 02 20
    lda $FD                     ; C107  A5 FD
    sta PPUSCROLL               ; C109  8D 05 20
    lda $FC                     ; C10C  A5 FC
    sta PPUSCROLL               ; C10E  8D 05 20
    lda $FF                     ; C111  A5 FF
    sta PPUCTRL                 ; C113  8D 00 20
    rts                         ; C116  60


DisablePPU:
    lda #$00                    ; C117  A9 00
    sta PPUADDR                 ; C119  8D 06 20
    sta PPUADDR                 ; C11C  8D 06 20
    sta PPUCTRL                 ; C11F  8D 00 20
    sta PPUMASK                 ; C122  8D 01 20
    rts                         ; C125  60


ClearRAMPages:
    sta $01                     ; C126  85 01
    lda #$00                    ; C128  A9 00
    sta $00                     ; C12A  85 00

L_C12C:
    sta ($00),y                 ; C12C  91 00
    dey                         ; C12E  88
    cpy #$FF                    ; C12F  C0 FF
    bne L_C12C                  ; C131  D0 F9
    dec $01                     ; C133  C6 01
    dex                         ; C135  CA
    bpl L_C12C                  ; C136  10 F4
    rts                         ; C138  60

; Cambia al banco Y (0-6) en $8000-$BFFF.
; UNROM: se escribe en una dirección que contiene el mismo valor para evitar conflictos de bus.

SwitchBank:
    lda $8000                   ; C139  AD 00 80
    sta CurrentBank             ; C13C  8D EC 07

SwitchBankNoSave:
    lda BankSelectTable,y       ; C13F  B9 D0 FF
    sta BankSelectTable,y       ; C142  99 D0 FF
    rts                         ; C145  60


RestoreBank:
    ldy CurrentBank             ; C146  AC EC 07
    jmp SwitchBankNoSave        ; C149  4C 3F C1


SwitchToSoundBank:
    pha                         ; C14C  48
    tya                         ; C14D  98
    pha                         ; C14E  48
    lda $8000                   ; C14F  AD 00 80
    sta SavedSoundBank          ; C152  8D ED 07
    ldy #$01                    ; C155  A0 01
    jsr SwitchBankNoSave        ; C157  20 3F C1
    pla                         ; C15A  68
    tay                         ; C15B  A8
    pla                         ; C15C  68
    rts                         ; C15D  60


RestoreFromSoundBank:
    pha                         ; C15E  48
    tya                         ; C15F  98
    pha                         ; C160  48
    ldy SavedSoundBank          ; C161  AC ED 07
    jsr SwitchBankNoSave        ; C164  20 3F C1
    pla                         ; C167  68
    tay                         ; C168  A8
    pla                         ; C169  68
    rts                         ; C16A  60


L_C16B:
    pha                         ; C16B  48
    lda $1B                     ; C16C  A5 1B
    ora #$80                    ; C16E  09 80
    sta $1B                     ; C170  85 1B
    pla                         ; C172  68
    jsr SwitchToSoundBank       ; C173  20 4C C1
    jsr L1_879B                 ; C176  20 9B 87
    jsr RestoreFromSoundBank    ; C179  20 5E C1
    lda $1B                     ; C17C  A5 1B
    and #$7F                    ; C17E  29 7F
    sta $1B                     ; C180  85 1B
    rts                         ; C182  60


L_C183:
    sty $F7                     ; C183  84 F7
    ldy #$01                    ; C185  A0 01
    jsr SwitchToSoundBank       ; C187  20 4C C1
    jsr L1_8712                 ; C18A  20 12 87
    jsr RestoreFromSoundBank    ; C18D  20 5E C1
    ldy $F7                     ; C190  A4 F7
    rts                         ; C192  60


L_C193:
    sta $F3                     ; C193  85 F3
    sty $F7                     ; C195  84 F7
    ldy #$03                    ; C197  A0 03
    jsr SwitchBank              ; C199  20 39 C1
    lda $F3                     ; C19C  A5 F3
    ldy $F7                     ; C19E  A4 F7
    jsr L_C536                  ; C1A0  20 36 C5
    jmp RestoreBank             ; C1A3  4C 46 C1

    .byte $85,$F3,$84,$F7,$A0,$03,$20,$39,$C1,$A5,$F3,$A4,$F7,$20,$F8,$C6
    .byte $4C,$46,$C1

L_C1B9:
    ldy #$06                    ; C1B9  A0 06
    jsr SwitchBank              ; C1BB  20 39 C1
    jmp L6_B94A                 ; C1BE  4C 4A B9


L_C1C1:
    ldy #$06                    ; C1C1  A0 06
    jsr SwitchBank              ; C1C3  20 39 C1
    jmp L6_B3C7                 ; C1C6  4C C7 B3


L_C1C9:
    ldy #$00                    ; C1C9  A0 00
    jsr SwitchBank              ; C1CB  20 39 C1
    jmp L_E61E                  ; C1CE  4C 1E E6


L_C1D1:
    ldy #$02                    ; C1D1  A0 02
    jsr SwitchBank              ; C1D3  20 39 C1
    jmp L2_B419                 ; C1D6  4C 19 B4


L_C1D9:
    ldy #$00                    ; C1D9  A0 00
    jsr SwitchBank              ; C1DB  20 39 C1
    jmp L_E689                  ; C1DE  4C 89 E6


L_C1E1:
    ldy #$02                    ; C1E1  A0 02
    jsr SwitchBank              ; C1E3  20 39 C1
    jmp L2_B523                 ; C1E6  4C 23 B5


L_C1E9:
    ldy #$03                    ; C1E9  A0 03
    jsr SwitchBank              ; C1EB  20 39 C1
    jmp L_DC4B                  ; C1EE  4C 4B DC


L_C1F1:
    ldy #$03                    ; C1F1  A0 03
    jsr SwitchBank              ; C1F3  20 39 C1
    jmp L_DBE6                  ; C1F6  4C E6 DB


L_C1F9:
    ldy #$02                    ; C1F9  A0 02
    jsr SwitchBank              ; C1FB  20 39 C1
    jmp L_CCB8                  ; C1FE  4C B8 CC


L_C201:
    jmp L_C8C4                  ; C201  4C C4 C8


L_C204:
    jmp L_C8C6                  ; C204  4C C6 C8


L_C207:
    ldy #$02                    ; C207  A0 02
    jsr SwitchBank              ; C209  20 39 C1
    jmp L2_AFFB                 ; C20C  4C FB AF


L_C20F:
    ldy #$02                    ; C20F  A0 02
    jsr SwitchBank              ; C211  20 39 C1
    jmp L2_AFF2                 ; C214  4C F2 AF


L_C217:
    sta $F3                     ; C217  85 F3
    ldy #$06                    ; C219  A0 06
    jsr SwitchBank              ; C21B  20 39 C1
    lda $F3                     ; C21E  A5 F3
    jmp L_CB60                  ; C220  4C 60 CB


L_C223:
    ldy #$04                    ; C223  A0 04
    jsr SwitchBank              ; C225  20 39 C1
    jmp L4_B8B9                 ; C228  4C B9 B8


L_C22B:
    ldy #$05                    ; C22B  A0 05
    jsr SwitchBank              ; C22D  20 39 C1
    jmp L5_B35E                 ; C230  4C 5E B3


L_C233:
    ldy #$03                    ; C233  A0 03
    jsr SwitchBank              ; C235  20 39 C1
    jmp L3_BDFA                 ; C238  4C FA BD


L_C23B:
    inc $1A                     ; C23B  E6 1A
    lda $18                     ; C23D  A5 18
    beq L_C248                  ; C23F  F0 07
    cmp #$03                    ; C241  C9 03
    bcs L_C248                  ; C243  B0 03
    jsr L_C3BC                  ; C245  20 BC C3

L_C248:
    lda $18                     ; C248  A5 18
    jsr JumpTable               ; C24A  20 57 C8
    .word L_C25B                    ; C24D
    .word L_C274                    ; C24F
    .word L_C2B1                    ; C251
    .word L_C2C7                    ; C253
    .word L_C2F4                    ; C255
    .word L_CE30                    ; C257
    .word L_C223                    ; C259

L_C25B:
    jsr L_C9A1                  ; C25B  20 A1 C9
    jsr L_C8A8                  ; C25E  20 A8 C8
    ldy #$00                    ; C261  A0 00
    sty $3F                     ; C263  84 3F
    iny                         ; C265  C8
    sty $FD                     ; C266  84 FD
    iny                         ; C268  C8
    sty $2B                     ; C269  84 2B
    lda #$B1                    ; C26B  A9 B1
    sta $FF                     ; C26D  85 FF
    jmp L_C301                  ; C26F  4C 01 C3

D_C272:
    .byte $A2,$B2

L_C274:
    jsr L_C331                  ; C274  20 31 C3
    lda $FD                     ; C277  A5 FD
    beq L_C282                  ; C279  F0 07
    inc $FD                     ; C27B  E6 FD
    bne L_C2B0                  ; C27D  D0 31
    jsr L_C3F9                  ; C27F  20 F9 C3

L_C282:
    lda #$2C                    ; C282  A9 2C
    sta $0334                   ; C284  8D 34 03
    lda #$AA                    ; C287  A9 AA
    sta $0300                   ; C289  8D 00 03
    ldx $22                     ; C28C  A6 22
    lda D_C272,x                ; C28E  BD 72 C2
    sta $031A                   ; C291  8D 1A 03
    lda #$00                    ; C294  A9 00
    sta $034E                   ; C296  8D 4E 03
    lda #$AB                    ; C299  A9 AB
    sta $0301                   ; C29B  8D 01 03
    lda #$B3                    ; C29E  A9 B3
    sta $0335                   ; C2A0  8D 35 03
    lda #$77                    ; C2A3  A9 77
    sta $031B                   ; C2A5  8D 1B 03
    jsr L_C315                  ; C2A8  20 15 C3
    bne L_C2B0                  ; C2AB  D0 03
    jmp L_C305                  ; C2AD  4C 05 C3


L_C2B0:
    rts                         ; C2B0  60


L_C2B1:
    ldx $19                     ; C2B1  A6 19
    bne L_C2BA                  ; C2B3  D0 05
    inc $19                     ; C2B5  E6 19
    jmp L_C41C                  ; C2B7  4C 1C C4


L_C2BA:
    jsr L_CE27                  ; C2BA  20 27 CE
    lda $1F                     ; C2BD  A5 1F
    beq L_C300                  ; C2BF  F0 3F
    lda #$00                    ; C2C1  A9 00
    sta $23                     ; C2C3  85 23
    beq L_C30E                  ; C2C5  F0 47

L_C2C7:
    ldx $19                     ; C2C7  A6 19
    bne L_C2D3                  ; C2C9  D0 08
    lda #$00                    ; C2CB  A9 00
    sta $1C                     ; C2CD  85 1C
    lda #$40                    ; C2CF  A9 40
    bne L_C2FC                  ; C2D1  D0 29

L_C2D3:
    jsr L_C40F                  ; C2D3  20 0F C4
    lda $2A                     ; C2D6  A5 2A
    beq L_C2DC                  ; C2D8  F0 02
    dec $2A                     ; C2DA  C6 2A

L_C2DC:
    ora $28                     ; C2DC  05 28
    beq L_C305                  ; C2DE  F0 25
    lda #$01                    ; C2E0  A9 01
    clc                         ; C2E2  18
    adc $22                     ; C2E3  65 22
    sta $00                     ; C2E5  85 00
    lda #$08                    ; C2E7  A9 08
    and $1A                     ; C2E9  25 1A
    asl a                       ; C2EB  0A
    asl a                       ; C2EC  0A
    asl a                       ; C2ED  0A
    asl a                       ; C2EE  0A
    ora $00                     ; C2EF  05 00
    jmp L_C217                  ; C2F1  4C 17 C2


L_C2F4:
    jsr NewGame4P               ; C2F4  20 3E C4  [4P] antes: jsr L_C43E
    jmp L_C305                  ; C2F7  4C 05 C3


L_C2FA:
    lda #$80                    ; C2FA  A9 80

L_C2FC:
    sta $2A                     ; C2FC  85 2A
    inc $19                     ; C2FE  E6 19

L_C300:
    rts                         ; C300  60


L_C301:
    lda #$80                    ; C301  A9 80
    sta $2A                     ; C303  85 2A

L_C305:
    inc $18                     ; C305  E6 18

L_C307:
    lda #$00                    ; C307  A9 00
    sta $1F                     ; C309  85 1F
    sta $19                     ; C30B  85 19
    rts                         ; C30D  60


L_C30E:
    sta $18                     ; C30E  85 18
    jsr L_C328                  ; C310  20 28 C3
    bne L_C307                  ; C313  D0 F2

L_C315:
    lda $2A                     ; C315  A5 2A
    ora $2B                     ; C317  05 2B
    beq L_C327                  ; C319  F0 0C
    dec $2A                     ; C31B  C6 2A
    bne L_C327                  ; C31D  D0 08
    lda $2B                     ; C31F  A5 2B
    beq L_C325                  ; C321  F0 02
    dec $2B                     ; C323  C6 2B

L_C325:
    lda #$01                    ; C325  A9 01

L_C327:
    rts                         ; C327  60


L_C328:
    ldx #$40                    ; C328  A2 40
    stx $2A                     ; C32A  86 2A
    ldx #$02                    ; C32C  A2 02
    stx $2B                     ; C32E  86 2B
    rts                         ; C330  60


L_C331:
    ldy $3F                     ; C331  A4 3F
    bmi L_C350                  ; C333  30 1B
    lda $F5                     ; C335  A5 F5
    and #$CF                    ; C337  29 CF
    beq L_C350                  ; C339  F0 15
    cmp D_C351,y                ; C33B  D9 51 C3
    beq L_C345                  ; C33E  F0 05
    lda #$FF                    ; C340  A9 FF
    sta $3F                     ; C342  85 3F
    rts                         ; C344  60


L_C345:
    iny                         ; C345  C8
    sty $3F                     ; C346  84 3F
    cpy #$0A                    ; C348  C0 0A
    bcc L_C350                  ; C34A  90 04
    lda #$01                    ; C34C  A9 01
    sta $24                     ; C34E  85 24

L_C350:
    rts                         ; C350  60

D_C351:
    .byte $08,$08,$04,$04,$02,$01,$02,$01,$40,$80

L_C35B:
    jsr L_C397                  ; C35B  20 97 C3
    lda $04                     ; C35E  A5 04
    sta $00                     ; C360  85 00
    lda $05                     ; C362  A5 05
    sta $01                     ; C364  85 01
    jsr L_C397                  ; C366  20 97 C3
    ldx #$01                    ; C369  A2 01

L_C36B:
    lda $04,x                   ; C36B  B5 04
    cmp $00,x                   ; C36D  D5 00
    beq L_C375                  ; C36F  F0 04
    lda $F9,x                   ; C371  B5 F9
    sta $04,x                   ; C373  95 04

L_C375:
    dex                         ; C375  CA
    bpl L_C36B                  ; C376  10 F3
    lda $1D                     ; C378  A5 1D
    and #$04                    ; C37A  29 04
    bne L_C384                  ; C37C  D0 06
    lda $04                     ; C37E  A5 04
    ora $05                     ; C380  05 05
    sta $04                     ; C382  85 04

L_C384:
    ldx #$01                    ; C384  A2 01

L_C386:
    lda $04,x                   ; C386  B5 04
    tay                         ; C388  A8
    eor $F9,x                   ; C389  55 F9
    and $04,x                   ; C38B  35 04
    sta $F5,x                   ; C38D  95 F5
    sty $F1,x                   ; C38F  94 F1
    sty $F9,x                   ; C391  94 F9
    dex                         ; C393  CA
    bpl L_C386                  ; C394  10 F0
    rts                         ; C396  60


L_C397:
    ldx #$01                    ; C397  A2 01
    stx JOY1                    ; C399  8E 16 40
    dex                         ; C39C  CA
    stx JOY1                    ; C39D  8E 16 40
    ldy #$08                    ; C3A0  A0 08

L_C3A2:
    lda JOY1                    ; C3A2  AD 16 40
    sta $07                     ; C3A5  85 07
    lsr a                       ; C3A7  4A
    ora $07                     ; C3A8  05 07
    lsr a                       ; C3AA  4A
    rol $04                     ; C3AB  26 04
    lda JOY2                    ; C3AD  AD 17 40
    sta $07                     ; C3B0  85 07
    lsr a                       ; C3B2  4A
    ora $07                     ; C3B3  05 07
    lsr a                       ; C3B5  4A
    rol $05                     ; C3B6  26 05
    dey                         ; C3B8  88
    bne L_C3A2                  ; C3B9  D0 E7
    rts                         ; C3BB  60


L_C3BC:
    jsr L_C40F                  ; C3BC  20 0F C4
    lda $F5                     ; C3BF  A5 F5
    and #$30                    ; C3C1  29 30
    beq L_C3E6                  ; C3C3  F0 21
    jsr L_C328                  ; C3C5  20 28 C3
    ldx $18                     ; C3C8  A6 18
    cpx #$01                    ; C3CA  E0 01
    bne L_C3E7                  ; C3CC  D0 19
    ldx $FD                     ; C3CE  A6 FD
    bne L_C3F9                  ; C3D0  D0 27
    and #$20                    ; C3D2  29 20
    bne L_C3DB                  ; C3D4  D0 05
    lda #$03                    ; C3D6  A9 03
    jmp L_C30E                  ; C3D8  4C 0E C3


L_C3DB:
    inc $22                     ; C3DB  E6 22
    lda #$02                    ; C3DD  A9 02
    sec                         ; C3DF  38
    sbc $22                     ; C3E0  E5 22
    bne L_C3E6                  ; C3E2  D0 02
    sta $22                     ; C3E4  85 22

L_C3E6:
    rts                         ; C3E6  60


L_C3E7:
    lda #$00                    ; C3E7  A9 00
    sta $23                     ; C3E9  85 23
    jsr L_C9A1                  ; C3EB  20 A1 C9
    jsr L_C8A8                  ; C3EE  20 A8 C8
    jsr L_C3F9                  ; C3F1  20 F9 C3
    lda #$01                    ; C3F4  A9 01
    jmp L_C30E                  ; C3F6  4C 0E C3


L_C3F9:
    lda #$00                    ; C3F9  A9 00
    sta $FD                     ; C3FB  85 FD
    lda #$B0                    ; C3FD  A9 B0
    sta $FF                     ; C3FF  85 FF
    lda #$A4                    ; C401  A9 A4
    sta $28                     ; C403  85 28
    lda #$04                    ; C405  A9 04
    jsr L_C217                  ; C407  20 17 C2
    lda #$26                    ; C40A  A9 26
    jmp L_C16B                  ; C40C  4C 6B C1


L_C40F:
    lda $1A                     ; C40F  A5 1A
    and #$01                    ; C411  29 01
    bne L_C3E6                  ; C413  D0 D1
    lda $28                     ; C415  A5 28
    beq L_C3E6                  ; C417  F0 CD
    dec $28                     ; C419  C6 28
    rts                         ; C41B  60


L_C41C:
    jsr L_C47F                  ; C41C  20 7F C4
    lda #$07                    ; C41F  A9 07
    sta $1D                     ; C421  85 1D
    lda #$00                    ; C423  A9 00
    sta $1A                     ; C425  85 1A
    sta $34                     ; C427  85 34
    lda $27                     ; C429  A5 27
    cmp #$03                    ; C42B  C9 03
    bcc L_C431                  ; C42D  90 02
    lda #$00                    ; C42F  A9 00

L_C431:
    sta $27                     ; C431  85 27
    sta $30                     ; C433  85 30
    inc $27                     ; C435  E6 27
    lda #$62                    ; C437  A9 62
    sta $32                     ; C439  85 32
    sta $33                     ; C43B  85 33
    rts                         ; C43D  60


L_C43E:
    jsr L_C47F                  ; C43E  20 7F C4
    sta $27                     ; C441  85 27
    lda #$03                    ; C443  A9 03
    sta $3A                     ; C445  85 3A

L_C447:
    ldx #$03                    ; C447  A2 03
    lda #$00                    ; C449  A9 00

L_C44B:
    sta $07E2,x                 ; C44B  9D E2 07
    dex                         ; C44E  CA
    bpl L_C44B                  ; C44F  10 FA
    sta $1C                     ; C451  85 1C
    sta $38                     ; C453  85 38
    ldx $22                     ; C455  A6 22
    lda D_C47B,x                ; C457  BD 7B C4
    sta $1D                     ; C45A  85 1D
    lda D_C47D,x                ; C45C  BD 7D C4
    sta $39                     ; C45F  85 39

L_C461:
    lda #$02                    ; C461  A9 02
    ldy $24                     ; C463  A4 24
    beq L_C469                  ; C465  F0 02
    lda #$1D                    ; C467  A9 1D

L_C469:
    sta $32,x                   ; C469  95 32
    dex                         ; C46B  CA
    bpl L_C461                  ; C46C  10 F3
    lda #$C8                    ; C46E  A9 C8
    sta $3C                     ; C470  85 3C
    sta $3E                     ; C472  85 3E
    lda #$00                    ; C474  A9 00
    sta $3D                     ; C476  85 3D
    sta $3F                     ; C478  85 3F
    rts                         ; C47A  60

D_C47B:
    .byte $01,$07
D_C47D:
    .byte $01,$00

L_C47F:
    ldx #$28                    ; C47F  A2 28

L_C481:
    lda #$00                    ; C481  A9 00

L_C483:
    sta $00,x                   ; C483  95 00
    inx                         ; C485  E8
    cpx #$F0                    ; C486  E0 F0
    bne L_C483                  ; C488  D0 F9
    ldx #$07                    ; C48A  A2 07
    ldy #$03                    ; C48C  A0 03
    sty $01                     ; C48E  84 01
    sta $00                     ; C490  85 00
    ldy #$00                    ; C492  A0 00

L_C494:
    sta ($00),y                 ; C494  91 00
    iny                         ; C496  C8
    bne L_C494                  ; C497  D0 FB
    inc $01                     ; C499  E6 01
    cpx $01                     ; C49B  E4 01
    bne L_C494                  ; C49D  D0 F5

L_C49F:
    rts                         ; C49F  60


L_C4A0:
    lda $1C                     ; C4A0  A5 1C
    bne L_C49F                  ; C4A2  D0 FB
    lda #$00                    ; C4A4  A9 00
    sta $01                     ; C4A6  85 01

L_C4A8:
    tya                         ; C4A8  98
    sta $02                     ; C4A9  85 02
    asl a                       ; C4AB  0A
    tay                         ; C4AC  A8
    lda $00                     ; C4AD  A5 00
    adc $07E2,y                 ; C4AF  79 E2 07
    sta $07E2,y                 ; C4B2  99 E2 07
    lda $01                     ; C4B5  A5 01
    adc $07E3,y                 ; C4B7  79 E3 07
    bcc L_C4C1                  ; C4BA  90 05
    lda #$FF                    ; C4BC  A9 FF
    sta $07E2,y                 ; C4BE  99 E2 07

L_C4C1:
    sta $07E3,y                 ; C4C1  99 E3 07
    ldx $01                     ; C4C4  A6 01
    beq L_C4CD                  ; C4C6  F0 05
    lda #$88                    ; C4C8  A9 88
    clc                         ; C4CA  18
    bcc L_C4E5                  ; C4CB  90 18

L_C4CD:
    cmp a:$003D,y               ; C4CD  D9 3D 00
    bcc L_C517                  ; C4D0  90 45
    bne L_C4DC                  ; C4D2  D0 08
    lda $07E2,y                 ; C4D4  B9 E2 07
    cmp a:$003C,y               ; C4D7  D9 3C 00
    bcc L_C517                  ; C4DA  90 3B

L_C4DC:
    lda a:$003D,y               ; C4DC  B9 3D 00
    cmp #$75                    ; C4DF  C9 75
    bcs L_C517                  ; C4E1  B0 34
    lda #$2C                    ; C4E3  A9 2C

L_C4E5:
    adc a:$003C,y               ; C4E5  79 3C 00
    sta a:$003C,y               ; C4E8  99 3C 00
    lda #$01                    ; C4EB  A9 01
    ldx $01                     ; C4ED  A6 01
    beq L_C4F3                  ; C4EF  F0 02
    lda #$13                    ; C4F1  A9 13

L_C4F3:
    adc a:$003D,y               ; C4F3  79 3D 00
    bcc L_C4FD                  ; C4F6  90 05
    lda #$FF                    ; C4F8  A9 FF
    sta a:$003C,y               ; C4FA  99 3C 00

L_C4FD:
    sta a:$003D,y               ; C4FD  99 3D 00
    ldx $02                     ; C500  A6 02
    inc $32,x                   ; C502  F6 32
    lda $32,x                   ; C504  B5 32
    cmp #$63                    ; C506  C9 63
    bcc L_C50C                  ; C508  90 02
    lda #$63                    ; C50A  A9 63

L_C50C:
    sta $32,x                   ; C50C  95 32
    lda $01                     ; C50E  A5 01
    bne L_C517                  ; C510  D0 05
    lda #$20                    ; C512  A9 20
    jsr L_C16B                  ; C514  20 6B C1

L_C517:
    lda $07E3,y                 ; C517  B9 E3 07
    cmp $07E1                   ; C51A  CD E1 07
    bcc L_C535                  ; C51D  90 16
    bne L_C529                  ; C51F  D0 08
    lda $07E2,y                 ; C521  B9 E2 07
    cmp $07E0                   ; C524  CD E0 07
    bcc L_C535                  ; C527  90 0C

L_C529:
    lda $07E2,y                 ; C529  B9 E2 07
    sta $07E0                   ; C52C  8D E0 07
    lda $07E3,y                 ; C52F  B9 E3 07
    sta $07E1                   ; C532  8D E1 07

L_C535:
    rts                         ; C535  60


L_C536:
    sta $11                     ; C536  85 11
    lda $21                     ; C538  A5 21
    cmp #$40                    ; C53A  C9 40
    bcs L_C535                  ; C53C  B0 F7
    jsr L_C7BB                  ; C53E  20 BB C7
    ldx $21                     ; C541  A6 21
    lda $30                     ; C543  A5 30
    ldy $40                     ; C545  A4 40
    bpl L_C54B                  ; C547  10 02
    lda #$08                    ; C549  A9 08

L_C54B:
    asl a                       ; C54B  0A
    asl a                       ; C54C  0A
    tay                         ; C54D  A8
    lda D_C6D3,y                ; C54E  B9 D3 C6
    sta $16                     ; C551  85 16
    lda D_C6D4,y                ; C553  B9 D4 C6
    sta $17                     ; C556  85 17
    lda $0F                     ; C558  A5 0F
    bne L_C575                  ; C55A  D0 19
    lda D_C6D5,y                ; C55C  B9 D5 C6
    sta $0E                     ; C55F  85 0E
    lda D_C6D6,y                ; C561  B9 D6 C6
    sta $0F                     ; C564  85 0F
    ldy $10                     ; C566  A4 10
    lda $00                     ; C568  A5 00
    bne L_C5D0                  ; C56A  D0 64
    jsr L_C83C                  ; C56C  20 3C C8
    lda ($0E),y                 ; C56F  B1 0E
    sta $0700,x                 ; C571  9D 00 07
    inx                         ; C574  E8

L_C575:
    lda #$00                    ; C575  A9 00
    sta $11                     ; C577  85 11
    lda $10                     ; C579  A5 10
    asl a                       ; C57B  0A
    asl a                       ; C57C  0A
    rol $11                     ; C57D  26 11
    asl a                       ; C57F  0A
    rol $11                     ; C580  26 11
    asl a                       ; C582  0A
    rol $11                     ; C583  26 11
    adc $16                     ; C585  65 16
    sta $16                     ; C587  85 16
    lda $11                     ; C589  A5 11
    adc $17                     ; C58B  65 17
    sta $17                     ; C58D  85 17
    lda #$01                    ; C58F  A9 01
    sta $0700,x                 ; C591  9D 00 07
    inx                         ; C594  E8
    lda #$04                    ; C595  A9 04
    sta $14                     ; C597  85 14
    sta $0700,x                 ; C599  9D 00 07
    inx                         ; C59C  E8
    sta $0700,x                 ; C59D  9D 00 07
    inx                         ; C5A0  E8
    ldy #$00                    ; C5A1  A0 00

L_C5A3:
    lda $0D                     ; C5A3  A5 0D
    sta $0700,x                 ; C5A5  9D 00 07
    inx                         ; C5A8  E8
    lda $0C                     ; C5A9  A5 0C
    sta $0700,x                 ; C5AB  9D 00 07
    inx                         ; C5AE  E8

L_C5AF:
    lda ($16),y                 ; C5AF  B1 16
    sta $0700,x                 ; C5B1  9D 00 07
    inx                         ; C5B4  E8
    iny                         ; C5B5  C8
    tya                         ; C5B6  98
    and #$03                    ; C5B7  29 03
    bne L_C5AF                  ; C5B9  D0 F4
    lda $0C                     ; C5BB  A5 0C
    clc                         ; C5BD  18
    adc #$20                    ; C5BE  69 20
    sta $0C                     ; C5C0  85 0C
    lda $0D                     ; C5C2  A5 0D
    adc #$00                    ; C5C4  69 00
    sta $0D                     ; C5C6  85 0D
    dec $14                     ; C5C8  C6 14
    bne L_C5A3                  ; C5CA  D0 D7
    stx $21                     ; C5CC  86 21
    clc                         ; C5CE  18
    rts                         ; C5CF  60


L_C5D0:
    tax                         ; C5D0  AA
    lda ($0E),y                 ; C5D1  B1 0E
    dex                         ; C5D3  CA
    stx $01                     ; C5D4  86 01
    bne L_C601                  ; C5D6  D0 29
    tax                         ; C5D8  AA
    and #$33                    ; C5D9  29 33
    asl a                       ; C5DB  0A
    asl a                       ; C5DC  0A
    sta $08                     ; C5DD  85 08
    txa                         ; C5DF  8A
    and #$CC                    ; C5E0  29 CC
    lsr a                       ; C5E2  4A
    lsr a                       ; C5E3  4A
    sta $09                     ; C5E4  85 09
    ldx $02                     ; C5E6  A6 02
    ldy $0600,x                 ; C5E8  BC 00 06
    lda ($46),y                 ; C5EB  B1 46
    and #$33                    ; C5ED  29 33
    ora $08                     ; C5EF  05 08
    sta $08                     ; C5F1  85 08
    ldy $0601,x                 ; C5F3  BC 01 06
    lda ($46),y                 ; C5F6  B1 46
    and #$CC                    ; C5F8  29 CC
    ora $09                     ; C5FA  05 09
    sta $09                     ; C5FC  85 09
    jmp L_C67B                  ; C5FE  4C 7B C6


L_C601:
    dex                         ; C601  CA
    bne L_C631                  ; C602  D0 2D
    ldx #$00                    ; C604  A2 00
    stx $09                     ; C606  86 09
    asl a                       ; C608  0A
    rol $09                     ; C609  26 09
    asl a                       ; C60B  0A
    rol $09                     ; C60C  26 09
    asl a                       ; C60E  0A
    rol $09                     ; C60F  26 09
    asl a                       ; C611  0A
    rol $09                     ; C612  26 09
    sta $08                     ; C614  85 08
    ldx $02                     ; C616  A6 02
    ldy $0600,x                 ; C618  BC 00 06
    lda ($46),y                 ; C61B  B1 46
    and #$0F                    ; C61D  29 0F
    ora $08                     ; C61F  05 08
    sta $08                     ; C621  85 08
    ldy $0608,x                 ; C623  BC 08 06
    lda ($46),y                 ; C626  B1 46
    and #$F0                    ; C628  29 F0
    ora $09                     ; C62A  05 09
    sta $09                     ; C62C  85 09
    jmp L_C67B                  ; C62E  4C 7B C6


L_C631:
    ldx #$00                    ; C631  A2 00
    stx $08                     ; C633  86 08
    stx $0B                     ; C635  86 0B
    lsr a                       ; C637  4A
    ror $08                     ; C638  66 08
    lsr a                       ; C63A  4A
    ror $08                     ; C63B  66 08
    and #$0C                    ; C63D  29 0C
    sta $0A                     ; C63F  85 0A
    lda ($0E),y                 ; C641  B1 0E
    asl a                       ; C643  0A
    rol $0B                     ; C644  26 0B
    asl a                       ; C646  0A
    rol $0B                     ; C647  26 0B
    and #$30                    ; C649  29 30
    sta $09                     ; C64B  85 09
    ldx $02                     ; C64D  A6 02
    ldy $0600,x                 ; C64F  BC 00 06
    lda ($46),y                 ; C652  B1 46
    and #$3F                    ; C654  29 3F
    ora $08                     ; C656  05 08
    sta $08                     ; C658  85 08
    ldy $0601,x                 ; C65A  BC 01 06
    lda ($46),y                 ; C65D  B1 46
    and #$CF                    ; C65F  29 CF
    ora $09                     ; C661  05 09
    sta $09                     ; C663  85 09
    ldy $0608,x                 ; C665  BC 08 06
    lda ($46),y                 ; C668  B1 46
    and #$F3                    ; C66A  29 F3
    ora $0A                     ; C66C  05 0A
    sta $0A                     ; C66E  85 0A
    ldy $0609,x                 ; C670  BC 09 06
    lda ($46),y                 ; C673  B1 46
    and #$FC                    ; C675  29 FC
    ora $0B                     ; C677  05 0B
    sta $0B                     ; C679  85 0B

L_C67B:
    lda $01                     ; C67B  A5 01
    asl a                       ; C67D  0A
    tay                         ; C67E  A8
    ldx $21                     ; C67F  A6 21
    lda #$01                    ; C681  A9 01
    sta $0700,x                 ; C683  9D 00 07
    inx                         ; C686  E8
    lda D_C6CD,y                ; C687  B9 CD C6
    sta $0700,x                 ; C68A  9D 00 07
    inx                         ; C68D  E8
    lda D_C6CE,y                ; C68E  B9 CE C6
    sta $0700,x                 ; C691  9D 00 07
    inx                         ; C694  E8
    ldy #$00                    ; C695  A0 00

L_C697:
    lda $15                     ; C697  A5 15
    sta $0700,x                 ; C699  9D 00 07
    inx                         ; C69C  E8
    lda $14                     ; C69D  A5 14
    sta $0700,x                 ; C69F  9D 00 07
    inx                         ; C6A2  E8
    lda a:$0008,y               ; C6A3  B9 08 00
    sta $0700,x                 ; C6A6  9D 00 07
    inx                         ; C6A9  E8
    lda $00                     ; C6AA  A5 00
    cmp #$02                    ; C6AC  C9 02
    beq L_C6B8                  ; C6AE  F0 08
    iny                         ; C6B0  C8
    lda a:$0008,y               ; C6B1  B9 08 00
    sta $0700,x                 ; C6B4  9D 00 07
    inx                         ; C6B7  E8

L_C6B8:
    lda $01                     ; C6B8  A5 01
    beq L_C6CA                  ; C6BA  F0 0E
    iny                         ; C6BC  C8
    lda $14                     ; C6BD  A5 14
    clc                         ; C6BF  18
    adc #$08                    ; C6C0  69 08
    sta $14                     ; C6C2  85 14
    lda #$00                    ; C6C4  A9 00
    sta $01                     ; C6C6  85 01
    beq L_C697                  ; C6C8  F0 CD

L_C6CA:
    jmp L_C575                  ; C6CA  4C 75 C5

D_C6CD:
    .byte $02
D_C6CE:
    .byte $01,$01,$02,$02,$02
D_C6D3:
    .byte $B1
D_C6D4:
    .byte $83
D_C6D5:
    .byte $AC
D_C6D6:
    .byte $86,$A8,$88,$91,$8E,$68,$93,$5F,$96,$A8,$88,$91,$8E,$A8,$9B,$B9
    .byte $9D,$AE,$A4,$67,$A5,$EA,$AB,$AE,$AD,$5A,$B2,$43,$B5,$1A,$BA,$C4
    .byte $BD,$60,$85,$11,$A5,$21,$C9,$50,$B0,$F7,$20,$BB,$C7,$A5,$10,$0A
    .byte $0A,$65,$10,$A8,$A5,$30,$0A,$AA,$BD,$9F,$C7,$85,$16,$BD,$A0,$C7
    .byte $85,$17,$A2,$02,$B1,$16,$10,$03,$29,$07,$AA,$86,$14,$A6,$21,$A5
    .byte $0F,$D0,$33,$B1,$16,$84,$0E,$A4,$00,$F0,$0C,$88,$F0,$07,$88,$F0
    .byte $02,$0A,$0A,$0A,$0A,$0A,$0A,$85,$08,$A6,$02,$BC,$00,$06,$B1,$46
    .byte $A4,$00,$39,$B7,$C7,$05,$08,$85,$08,$A6,$21,$20,$3C,$C8,$A5,$08
    .byte $9D,$00,$07,$E8,$A4,$0E,$C8,$A9,$01,$9D,$00,$07,$E8,$A9,$02,$9D
    .byte $00,$07,$E8,$A5,$14,$9D,$00,$07,$E8,$A9,$02,$85,$15,$A5,$0D,$9D
    .byte $00,$07,$E8,$A5,$0C,$9D,$00,$07,$E8,$B1,$16,$9D,$00,$07,$E8,$C8
    .byte $C6,$15,$D0,$F5,$A5,$0C,$18,$69,$20,$85,$0C,$A5,$0D,$69,$00,$85
    .byte $0D,$C6,$14,$D0,$D4,$86,$21,$18,$60,$01,$80,$E1,$86,$F8,$8E,$E1
    .byte $86,$98,$96,$D8,$9D,$6E,$A5,$CA,$AD,$7A,$B5
D_C7B1:
    .byte $20,$24
D_C7B3:
    .byte $23,$27
D_C7B5:
    .byte $00,$40,$FC,$F3,$CF,$3F

L_C7BB:
    lda $10                     ; C7BB  A5 10
    and #$80                    ; C7BD  29 80
    sta $0F                     ; C7BF  85 0F
    lda $10                     ; C7C1  A5 10
    and #$7F                    ; C7C3  29 7F
    sta $10                     ; C7C5  85 10
    tya                         ; C7C7  98
    clc                         ; C7C8  18
    adc $FC                     ; C7C9  65 FC
    bcs L_C7D1                  ; C7CB  B0 04
    cmp #$F0                    ; C7CD  C9 F0
    bcc L_C7D3                  ; C7CF  90 02

L_C7D1:
    adc #$0F                    ; C7D1  69 0F

L_C7D3:
    and #$F8                    ; C7D3  29 F8
    sta $12                     ; C7D5  85 12
    lsr a                       ; C7D7  4A
    lsr a                       ; C7D8  4A
    tay                         ; C7D9  A8
    lsr a                       ; C7DA  4A
    and #$02                    ; C7DB  29 02
    sta $00                     ; C7DD  85 00
    tya                         ; C7DF  98
    and #$38                    ; C7E0  29 38
    sta $14                     ; C7E2  85 14
    lda #$00                    ; C7E4  A9 00
    asl $12                     ; C7E6  06 12
    rol a                       ; C7E8  2A
    asl $12                     ; C7E9  06 12
    rol a                       ; C7EB  2A
    sta $13                     ; C7EC  85 13
    lda $11                     ; C7EE  A5 11
    clc                         ; C7F0  18
    adc $FD                     ; C7F1  65 FD
    sta $11                     ; C7F3  85 11
    lda $FF                     ; C7F5  A5 FF
    and #$01                    ; C7F7  29 01
    bcc L_C7FD                  ; C7F9  90 02
    eor #$01                    ; C7FB  49 01

L_C7FD:
    tay                         ; C7FD  A8
    lda D_C7B3,y                ; C7FE  B9 B3 C7
    ora #$03                    ; C801  09 03
    sta $15                     ; C803  85 15
    lda D_C7B1,y                ; C805  B9 B1 C7
    ora $13                     ; C808  05 13
    sta $13                     ; C80A  85 13
    sta $0D                     ; C80C  85 0D
    lda D_C7B5,y                ; C80E  B9 B5 C7
    sta $02                     ; C811  85 02
    lda $11                     ; C813  A5 11
    and #$F8                    ; C815  29 F8
    lsr a                       ; C817  4A
    lsr a                       ; C818  4A
    lsr a                       ; C819  4A
    tay                         ; C81A  A8
    lsr a                       ; C81B  4A
    tax                         ; C81C  AA
    and #$01                    ; C81D  29 01
    ora $00                     ; C81F  05 00
    sta $00                     ; C821  85 00
    txa                         ; C823  8A
    lsr a                       ; C824  4A
    ora $14                     ; C825  05 14
    sta $03                     ; C827  85 03
    clc                         ; C829  18
    adc #$C0                    ; C82A  69 C0
    sta $14                     ; C82C  85 14
    tya                         ; C82E  98
    ora $12                     ; C82F  05 12
    sta $12                     ; C831  85 12
    sta $0C                     ; C833  85 0C
    lda $02                     ; C835  A5 02
    ora $03                     ; C837  05 03
    sta $02                     ; C839  85 02
    rts                         ; C83B  60


L_C83C:
    lda #$01                    ; C83C  A9 01
    sta $0700,x                 ; C83E  9D 00 07
    inx                         ; C841  E8
    sta $0700,x                 ; C842  9D 00 07
    inx                         ; C845  E8
    sta $0700,x                 ; C846  9D 00 07
    inx                         ; C849  E8
    lda $15                     ; C84A  A5 15
    sta $0700,x                 ; C84C  9D 00 07
    inx                         ; C84F  E8
    lda $14                     ; C850  A5 14
    sta $0700,x                 ; C852  9D 00 07
    inx                         ; C855  E8
    rts                         ; C856  60

; Tabla de saltos en línea: tras 'jsr JumpTable' van .word con destinos; A = índice.

JumpTable:
    asl a                       ; C857  0A
    sty $03                     ; C858  84 03
    tay                         ; C85A  A8
    iny                         ; C85B  C8
    pla                         ; C85C  68
    sta $00                     ; C85D  85 00
    pla                         ; C85F  68
    sta $01                     ; C860  85 01
    lda ($00),y                 ; C862  B1 00
    sta $02                     ; C864  85 02
    iny                         ; C866  C8
    lda ($00),y                 ; C867  B1 00
    ldy $03                     ; C869  A4 03
    sta $03                     ; C86B  85 03
    jmp ($0002)                 ; C86D  6C 02 00

    .byte $86,$00,$84,$01

L_C874:
    lda #$00                    ; C874  A9 00
    sta $02                     ; C876  85 02
    ldy #$10                    ; C878  A0 10
    rol $00                     ; C87A  26 00
    rol $01                     ; C87C  26 01

L_C87E:
    rol $02                     ; C87E  26 02
    lda $02                     ; C880  A5 02
    cmp $03                     ; C882  C5 03
    bcc L_C88A                  ; C884  90 04
    sbc $03                     ; C886  E5 03
    sta $02                     ; C888  85 02

L_C88A:
    rol $00                     ; C88A  26 00
    rol $01                     ; C88C  26 01
    dey                         ; C88E  88
    bne L_C87E                  ; C88F  D0 ED
    rts                         ; C891  60


L_C892:
    clc                         ; C892  18
    adc $00,x                   ; C893  75 00
    sta $00,x                   ; C895  95 00
    bcc L_C89B                  ; C897  90 02
    inc $01,x                   ; C899  F6 01

L_C89B:
    rts                         ; C89B  60

    .byte $49,$FF,$38,$75,$00,$95,$00,$B0,$02,$D6,$01,$60

L_C8A8:
    jsr L_C183                  ; C8A8  20 83 C1
    jsr L_C47F                  ; C8AB  20 7F C4
    lda #$1E                    ; C8AE  A9 1E
    sta $FE                     ; C8B0  85 FE
    ldy #$00                    ; C8B2  A0 00
    sty $6A                     ; C8B4  84 6A
    iny                         ; C8B6  C8
    sty $1C                     ; C8B7  84 1C
    lda #$0B                    ; C8B9  A9 0B
    jsr L_C204                  ; C8BB  20 04 C2
    lda #$06                    ; C8BE  A9 06
    jsr L_C217                  ; C8C0  20 17 C2

L_C8C3:
    rts                         ; C8C3  60


L_C8C4:
    lda $30                     ; C8C4  A5 30

L_C8C6:
    asl a                       ; C8C6  0A
    tay                         ; C8C7  A8
    lda L_C8E3,y                ; C8C8  B9 E3 C8
    sta $06                     ; C8CB  85 06
    lda L_C8E3+1,y              ; C8CD  B9 E4 C8
    sta $07                     ; C8D0  85 07
    ldy #$00                    ; C8D2  A0 00
    sty $05                     ; C8D4  84 05

L_C8D6:
    lda ($06),y                 ; C8D6  B1 06
    bmi L_C8C3                  ; C8D8  30 E9
    jsr L_C9A3                  ; C8DA  20 A3 C9
    inc $05                     ; C8DD  E6 05
    ldy $05                     ; C8DF  A4 05
    bne L_C8D6                  ; C8E1  D0 F3

L_C8E3:
    sbc $05C8,x                 ; C8E3  FD C8 05
    cmp #$16                    ; C8E6  C9 16
    cmp #$0D                    ; C8E8  C9 0D
    cmp #$1E                    ; C8EA  C9 1E
    cmp #$26                    ; C8EC  C9 26
    cmp #$2E                    ; C8EE  C9 2E
    cmp #$36                    ; C8F0  C9 36
    cmp #$3B                    ; C8F2  C9 3B
    cmp #$40                    ; C8F4  C9 40
    cmp #$46                    ; C8F6  C9 46
    cmp #$48                    ; C8F8  C9 48
    cmp #$4B                    ; C8FA  C9 4B
    cmp #$03                    ; C8FC  C9 03
    .byte $13,$19,$1A,$14,$16,$05,$FF,$03,$04,$06,$0A,$0F,$10,$11,$FF,$03
    .byte $04,$06,$0A,$0F,$10,$11,$12,$FF,$03,$13,$19,$1A,$14,$16,$07,$FF
    .byte $03,$13,$19,$1A,$15,$16,$0B,$FF,$03,$13,$19,$1A,$15,$16,$0C,$FF
    .byte $03,$13,$19,$1A,$15,$16,$0D,$FF,$03,$13,$19,$0E,$FF,$03,$04,$13
    .byte $08,$FF,$03,$04,$13,$08,$09,$FF,$01,$FF,$01,$02,$FF,$01,$03,$17
    .byte $18,$FF
D_C950:
    .byte $36
D_C951:
    .byte $CB
D_C952:
    .byte $00,$2D,$AA,$04,$97,$90,$02,$01,$80,$04,$AE,$85,$04,$01,$80,$05
    .byte $FC,$99,$04,$61,$8A,$05,$6C,$88,$04,$CD,$99,$04,$05,$A0,$04,$E0
    .byte $93,$05,$01,$80,$06,$DC,$8C,$06,$D6,$9B,$06,$46,$A3,$04,$03,$A0
    .byte $84,$E7,$A3,$04,$40,$A9,$04,$A1,$87,$04,$14,$A8,$05,$7A,$B0,$06
    .byte $5C,$B1,$06,$DF,$AD,$05,$0D,$B3,$05,$1B,$A3,$05,$00,$A5,$05

L_C9A1:
    lda #$00                    ; C9A1  A9 00

L_C9A3:
    sta $04                     ; C9A3  85 04
    asl a                       ; C9A5  0A
    adc $04                     ; C9A6  65 04
    tax                         ; C9A8  AA
    lda D_C950,x                ; C9A9  BD 50 C9
    sta $00                     ; C9AC  85 00
    lda D_C951,x                ; C9AE  BD 51 C9
    sta $01                     ; C9B1  85 01
    lda D_C952,x                ; C9B3  BD 52 C9
    and #$80                    ; C9B6  29 80
    sta $04                     ; C9B8  85 04
    lda D_C952,x                ; C9BA  BD 52 C9
    and #$07                    ; C9BD  29 07
    tay                         ; C9BF  A8
    jsr SwitchBank              ; C9C0  20 39 C1
    jsr DisablePPU              ; C9C3  20 17 C1
    sta $21                     ; C9C6  85 21
    sta $FC                     ; C9C8  85 FC
    sta $FD                     ; C9CA  85 FD

L_C9CC:
    lda PPUSTATUS               ; C9CC  AD 02 20
    ldy #$01                    ; C9CF  A0 01
    lda ($00),y                 ; C9D1  B1 00
    sta PPUADDR                 ; C9D3  8D 06 20
    dey                         ; C9D6  88
    lda ($00),y                 ; C9D7  B1 00
    sta PPUADDR                 ; C9D9  8D 06 20
    lda #$02                    ; C9DC  A9 02
    ldx $04                     ; C9DE  A6 04
    bpl L_C9E3                  ; C9E0  10 01
    asl a                       ; C9E2  0A

L_C9E3:
    ldx #$00                    ; C9E3  A2 00
    jsr L_C892                  ; C9E5  20 92 C8

L_C9E8:
    ldy #$00                    ; C9E8  A0 00
    lda ($00),y                 ; C9EA  B1 00
    cmp #$FF                    ; C9EC  C9 FF
    beq L_CA5B                  ; C9EE  F0 6B
    cmp #$7F                    ; C9F0  C9 7F
    beq L_CA51                  ; C9F2  F0 5D
    tay                         ; C9F4  A8
    bpl L_CA1D                  ; C9F5  10 26
    and #$7F                    ; C9F7  29 7F
    sta $02                     ; C9F9  85 02
    ldy #$01                    ; C9FB  A0 01

L_C9FD:
    lda ($00),y                 ; C9FD  B1 00
    ldx $04                     ; C9FF  A6 04
    bpl L_CA06                  ; CA01  10 03
    jsr L_CA36                  ; CA03  20 36 CA

L_CA06:
    sta PPUDATA                 ; CA06  8D 07 20
    cpy $02                     ; CA09  C4 02
    beq L_CA10                  ; CA0B  F0 03
    iny                         ; CA0D  C8
    bne L_C9FD                  ; CA0E  D0 ED

L_CA10:
    lda #$01                    ; CA10  A9 01
    clc                         ; CA12  18
    adc $02                     ; CA13  65 02

L_CA15:
    ldx #$00                    ; CA15  A2 00
    jsr L_C892                  ; CA17  20 92 C8
    jmp L_C9E8                  ; CA1A  4C E8 C9


L_CA1D:
    ldy #$01                    ; CA1D  A0 01
    sta $02                     ; CA1F  85 02
    lda ($00),y                 ; CA21  B1 00
    ldy $02                     ; CA23  A4 02
    ldx $04                     ; CA25  A6 04
    bpl L_CA2C                  ; CA27  10 03
    jsr L_CA36                  ; CA29  20 36 CA

L_CA2C:
    sta PPUDATA                 ; CA2C  8D 07 20
    dey                         ; CA2F  88
    bne L_CA2C                  ; CA30  D0 FA
    lda #$02                    ; CA32  A9 02
    bne L_CA15                  ; CA34  D0 DF

L_CA36:
    sta $03                     ; CA36  85 03
    asl $03                     ; CA38  06 03
    ror a                       ; CA3A  6A
    asl $03                     ; CA3B  06 03
    ror a                       ; CA3D  6A
    asl $03                     ; CA3E  06 03
    ror a                       ; CA40  6A
    asl $03                     ; CA41  06 03
    ror a                       ; CA43  6A
    asl $03                     ; CA44  06 03
    ror a                       ; CA46  6A
    asl $03                     ; CA47  06 03
    ror a                       ; CA49  6A
    asl $03                     ; CA4A  06 03
    ror a                       ; CA4C  6A
    asl $03                     ; CA4D  06 03
    ror a                       ; CA4F  6A
    rts                         ; CA50  60


L_CA51:
    lda #$01                    ; CA51  A9 01
    ldx #$00                    ; CA53  A2 00
    jsr L_C892                  ; CA55  20 92 C8
    jmp L_C9CC                  ; CA58  4C CC C9


L_CA5B:
    jsr RestoreBank             ; CA5B  20 46 C1
    jmp L_C0E7                  ; CA5E  4C E7 C0


L_CA61:
    lda #$1E                    ; CA61  A9 1E
    sta $02                     ; CA63  85 02
    lda #$07                    ; CA65  A9 07
    clc                         ; CA67  18
    adc $1E                     ; CA68  65 1E
    jsr L_C217                  ; CA6A  20 17 C2
    ldx $1E                     ; CA6D  A6 1E
    lda $38,x                   ; CA6F  B5 38
    eor #$01                    ; CA71  49 01
    clc                         ; CA73  18
    adc $32,x                   ; CA74  75 32
    beq L_CAA6                  ; CA76  F0 2E
    bpl L_CA7C                  ; CA78  10 02
    lda #$00                    ; CA7A  A9 00

L_CA7C:
    ldx #$00                    ; CA7C  A2 00

L_CA7E:
    sta $00                     ; CA7E  85 00
    cmp #$0A                    ; CA80  C9 0A
    bcc L_CA8E                  ; CA82  90 0A
    sbc #$0A                    ; CA84  E9 0A
    inx                         ; CA86  E8
    cpx #$0A                    ; CA87  E0 0A
    bcc L_CA7E                  ; CA89  90 F3
    ldx #$09                    ; CA8B  A2 09
    txa                         ; CA8D  8A

L_CA8E:
    ldy $21                     ; CA8E  A4 21
    ora #$30                    ; CA90  09 30
    cpx #$00                    ; CA92  E0 00
    bne L_CA9A                  ; CA94  D0 04
    cmp #$30                    ; CA96  C9 30
    beq L_CAA5                  ; CA98  F0 0B

L_CA9A:
    sta $06FE,y                 ; CA9A  99 FE 06
    txa                         ; CA9D  8A
    beq L_CAA5                  ; CA9E  F0 05
    ora #$30                    ; CAA0  09 30
    sta $06FD,y                 ; CAA2  99 FD 06

L_CAA5:
    rts                         ; CAA5  60


L_CAA6:
    txa                         ; CAA6  8A
    clc                         ; CAA7  18
    adc #$0F                    ; CAA8  69 0F
    jmp L_C217                  ; CAAA  4C 17 C2


L_CAAD:
    lda #$0C                    ; CAAD  A9 0C
    jsr L_C217                  ; CAAF  20 17 C2
    lda $30                     ; CAB2  A5 30
    clc                         ; CAB4  18
    adc #$31                    ; CAB5  69 31
    sta $06FE,x                 ; CAB7  9D FE 06
    lda $30                     ; CABA  A5 30
    adc #$11                    ; CABC  69 11
    jmp L_C217                  ; CABE  4C 17 C2


L_CAC1:
    lda #$09                    ; CAC1  A9 09
    jsr L_C217                  ; CAC3  20 17 C2
    lda $07E0                   ; CAC6  AD E0 07
    sta $00                     ; CAC9  85 00
    lda $07E1                   ; CACB  AD E1 07
    sta $01                     ; CACE  85 01
    jsr L_CAF8                  ; CAD0  20 F8 CA
    lda #$0A                    ; CAD3  A9 0A
    jsr L_C217                  ; CAD5  20 17 C2
    lda $07E2                   ; CAD8  AD E2 07
    sta $00                     ; CADB  85 00
    lda $07E3                   ; CADD  AD E3 07
    sta $01                     ; CAE0  85 01
    jsr L_CAF8                  ; CAE2  20 F8 CA
    lda $22                     ; CAE5  A5 22
    beq L_CB2E                  ; CAE7  F0 45

L_CAE9:
    lda #$0B                    ; CAE9  A9 0B
    jsr L_C217                  ; CAEB  20 17 C2
    lda $07E4                   ; CAEE  AD E4 07
    sta $00                     ; CAF1  85 00
    lda $07E5                   ; CAF3  AD E5 07
    sta $01                     ; CAF6  85 01

L_CAF8:
    lda $1A                     ; CAF8  A5 1A
    and #$10                    ; CAFA  29 10
    bne L_CB2E                  ; CAFC  D0 30
    lda #$05                    ; CAFE  A9 05
    sta $04                     ; CB00  85 04

L_CB02:
    lda #$0A                    ; CB02  A9 0A
    sta $03                     ; CB04  85 03
    jsr L_C874                  ; CB06  20 74 C8
    lda $02                     ; CB09  A5 02
    ora #$30                    ; CB0B  09 30
    sta $06FC,x                 ; CB0D  9D FC 06
    dex                         ; CB10  CA
    lda $00                     ; CB11  A5 00
    ora $01                     ; CB13  05 01
    beq L_CB1B                  ; CB15  F0 04
    dec $04                     ; CB17  C6 04
    bne L_CB02                  ; CB19  D0 E7

L_CB1B:
    ldx $21                     ; CB1B  A6 21
    lda $04                     ; CB1D  A5 04
    sec                         ; CB1F  38
    sbc #$05                    ; CB20  E9 05
    ora $02                     ; CB22  05 02
    beq L_CB2F                  ; CB24  F0 09
    lda #$30                    ; CB26  A9 30
    sta $06FD,x                 ; CB28  9D FD 06

L_CB2B:
    sta $06FE,x                 ; CB2B  9D FE 06

L_CB2E:
    rts                         ; CB2E  60


L_CB2F:
    sta $06FC,x                 ; CB2F  9D FC 06
    lda #$30                    ; CB32  A9 30
    bne L_CB2B                  ; CB34  D0 F5
    .byte $00,$20,$78,$00,$78,$00,$78,$00,$78,$00,$78,$00,$78,$00,$78,$00
    .byte $78,$00,$40,$00,$7F,$00,$24,$78,$00,$78,$00,$78,$00,$78,$00,$78
    .byte $00,$78,$00,$78,$00,$78,$00,$40,$00,$FF

L_CB60:
    pha                         ; CB60  48
    lda #$02                    ; CB61  A9 02
    sta $03                     ; CB63  85 03
    lda #$01                    ; CB65  A9 01
    jsr L_CBBD                  ; CB67  20 BD CB
    pla                         ; CB6A  68
    sta $02                     ; CB6B  85 02
    asl a                       ; CB6D  0A
    tax                         ; CB6E  AA
    lda D6_B262,x               ; CB6F  BD 62 B2
    sta $00                     ; CB72  85 00
    lda D6_B263,x               ; CB74  BD 63 B2
    sta $01                     ; CB77  85 01
    ldx $21                     ; CB79  A6 21
    ldy #$00                    ; CB7B  A0 00

L_CB7D:
    lda ($00),y                 ; CB7D  B1 00
    iny                         ; CB7F  C8
    cmp #$FF                    ; CB80  C9 FF
    beq L_CBC3                  ; CB82  F0 3F
    cmp #$FE                    ; CB84  C9 FE
    beq L_CBA1                  ; CB86  F0 19
    cmp #$FD                    ; CB88  C9 FD
    beq L_CBA5                  ; CB8A  F0 19
    sta $0700,x                 ; CB8C  9D 00 07
    lda $02                     ; CB8F  A5 02
    bpl L_CB9E                  ; CB91  10 0B
    lda $03                     ; CB93  A5 03
    bne L_CB9C                  ; CB95  D0 05
    sta $0700,x                 ; CB97  9D 00 07
    beq L_CB9E                  ; CB9A  F0 02

L_CB9C:
    dec $03                     ; CB9C  C6 03

L_CB9E:
    inx                         ; CB9E  E8
    bne L_CB7D                  ; CB9F  D0 DC

L_CBA1:
    lda #$FF                    ; CBA1  A9 FF
    bne L_CBBF                  ; CBA3  D0 1A

L_CBA5:
    lda #$FF                    ; CBA5  A9 FF
    jsr L_CBBF                  ; CBA7  20 BF CB
    lda #$02                    ; CBAA  A9 02
    sta $03                     ; CBAC  85 03
    lda #$01                    ; CBAE  A9 01
    jsr L_CBBF                  ; CBB0  20 BF CB
    bne L_CB7D                  ; CBB3  D0 C8
    lda #$FF                    ; CBB5  A9 FF

L_CBB7:
    bne L_CBBD                  ; CBB7  D0 04

L_CBB9:
    lda #$00                    ; CBB9  A9 00
    beq L_CBBD                  ; CBBB  F0 00

L_CBBD:
    ldx $21                     ; CBBD  A6 21

L_CBBF:
    sta $0700,x                 ; CBBF  9D 00 07
    inx                         ; CBC2  E8

L_CBC3:
    stx $21                     ; CBC3  86 21

L_CBC5:
    rts                         ; CBC5  60

    .byte $00,$04,$00

L_CBC9:
    lda $23                     ; CBC9  A5 23
    bne L_CC3F                  ; CBCB  D0 72
    ldy #$00                    ; CBCD  A0 00
    sty $08                     ; CBCF  84 08

L_CBD1:
    lda $08                     ; CBD1  A5 08
    cmp #$3F                    ; CBD3  C9 3F
    bne L_CBE5                  ; CBD5  D0 0E
    sta PPUADDR                 ; CBD7  8D 06 20
    lda #$00                    ; CBDA  A9 00
    sta PPUADDR                 ; CBDC  8D 06 20
    sta PPUADDR                 ; CBDF  8D 06 20
    sta PPUADDR                 ; CBE2  8D 06 20

L_CBE5:
    ldx $0700,y                 ; CBE5  BE 00 07
    beq L_CC1C                  ; CBE8  F0 32
    lda $FF                     ; CBEA  A5 FF
    and #$18                    ; CBEC  29 18
    ora L_CBC5,x                ; CBEE  1D C5 CB
    sta PPUCTRL                 ; CBF1  8D 00 20
    iny                         ; CBF4  C8
    lda PPUSTATUS               ; CBF5  AD 02 20
    lda $0700,y                 ; CBF8  B9 00 07
    sta $08                     ; CBFB  85 08
    sta PPUADDR                 ; CBFD  8D 06 20
    iny                         ; CC00  C8
    lda $0700,y                 ; CC01  B9 00 07
    sta PPUADDR                 ; CC04  8D 06 20
    iny                         ; CC07  C8
    cpx #$03                    ; CC08  E0 03
    bne L_CC2E                  ; CC0A  D0 22
    lda $0700,y                 ; CC0C  B9 00 07
    sta $09                     ; CC0F  85 09

L_CC11:
    iny                         ; CC11  C8
    lda $0700,y                 ; CC12  B9 00 07
    sta PPUDATA                 ; CC15  8D 07 20
    dec $09                     ; CC18  C6 09
    bne L_CC11                  ; CC1A  D0 F5

L_CC1C:
    lda #$00                    ; CC1C  A9 00
    sta $0700                   ; CC1E  8D 00 07
    sta $21                     ; CC21  85 21
    lda $FF                     ; CC23  A5 FF
    sta PPUCTRL                 ; CC25  8D 00 20
    rts                         ; CC28  60


L_CC29:
    lda #$FF                    ; CC29  A9 FF

L_CC2B:
    sta PPUDATA                 ; CC2B  8D 07 20

L_CC2E:
    lda $0700,y                 ; CC2E  B9 00 07
    iny                         ; CC31  C8
    cmp #$FF                    ; CC32  C9 FF
    bne L_CC2B                  ; CC34  D0 F5
    lda $0700,y                 ; CC36  B9 00 07
    cmp #$04                    ; CC39  C9 04
    bcs L_CC29                  ; CC3B  B0 EC
    bcc L_CBD1                  ; CC3D  90 92

L_CC3F:
    ldx #$00                    ; CC3F  A2 00
    lda $FF                     ; CC41  A5 FF
    and #$18                    ; CC43  29 18
    sta $02                     ; CC45  85 02

L_CC47:
    ldy $0700,x                 ; CC47  BC 00 07
    beq L_CC1C                  ; CC4A  F0 D0
    lda $02                     ; CC4C  A5 02
    ora L_CBC5,y                ; CC4E  19 C5 CB
    sta PPUCTRL                 ; CC51  8D 00 20
    inx                         ; CC54  E8
    lda $0700,x                 ; CC55  BD 00 07
    sta $00                     ; CC58  85 00
    inx                         ; CC5A  E8
    lda $0700,x                 ; CC5B  BD 00 07
    sta $01                     ; CC5E  85 01

L_CC60:
    ldy $00                     ; CC60  A4 00
    inx                         ; CC62  E8
    lda $0700,x                 ; CC63  BD 00 07
    sta PPUADDR                 ; CC66  8D 06 20
    inx                         ; CC69  E8
    lda $0700,x                 ; CC6A  BD 00 07
    sta PPUADDR                 ; CC6D  8D 06 20

L_CC70:
    inx                         ; CC70  E8
    lda $0700,x                 ; CC71  BD 00 07
    sta PPUDATA                 ; CC74  8D 07 20
    dey                         ; CC77  88
    bne L_CC70                  ; CC78  D0 F6
    dec $01                     ; CC7A  C6 01
    bne L_CC60                  ; CC7C  D0 E2
    inx                         ; CC7E  E8
    bne L_CC47                  ; CC7F  D0 C6

L_CC81:
    ldx $36                     ; CC81  A6 36
    beq L_CCB7                  ; CC83  F0 32
    lda $21                     ; CC85  A5 21
    cmp #$30                    ; CC87  C9 30
    bcs L_CCB7                  ; CC89  B0 2C
    lda $FF                     ; CC8B  A5 FF
    and #$18                    ; CC8D  29 18
    sta PPUCTRL                 ; CC8F  8D 00 20
    lda #$3F                    ; CC92  A9 3F
    sta PPUADDR                 ; CC94  8D 06 20
    lda #$00                    ; CC97  A9 00
    sta PPUADDR                 ; CC99  8D 06 20
    tay                         ; CC9C  A8

L_CC9D:
    lda $07C0,y                 ; CC9D  B9 C0 07
    sta PPUDATA                 ; CCA0  8D 07 20
    iny                         ; CCA3  C8
    dex                         ; CCA4  CA
    bne L_CC9D                  ; CCA5  D0 F6
    lda #$3F                    ; CCA7  A9 3F
    sta PPUADDR                 ; CCA9  8D 06 20
    stx PPUADDR                 ; CCAC  8E 06 20
    stx PPUADDR                 ; CCAF  8E 06 20
    stx PPUADDR                 ; CCB2  8E 06 20
    stx $36                     ; CCB5  86 36

L_CCB7:
    rts                         ; CCB7  60


L_CCB8:
    lda $71                     ; CCB8  A5 71
    beq L_CCB7                  ; CCBA  F0 FB
    bmi L_CCE4                  ; CCBC  30 26
    lda $30                     ; CCBE  A5 30
    asl a                       ; CCC0  0A
    asl a                       ; CCC1  0A
    adc $30                     ; CCC2  65 30
    tay                         ; CCC4  A8
    lda D_CD2C,y                ; CCC5  B9 2C CD
    sta $6C                     ; CCC8  85 6C
    lda D_CD2D,y                ; CCCA  B9 2D CD
    sta $6D                     ; CCCD  85 6D
    lda D_CD2E,y                ; CCCF  B9 2E CD
    sta $6E                     ; CCD2  85 6E
    lda D_CD2F,y                ; CCD4  B9 2F CD
    sta $6F                     ; CCD7  85 6F
    lda D_CD30,y                ; CCD9  B9 30 CD
    beq L_CD27                  ; CCDC  F0 49
    sta $70                     ; CCDE  85 70
    lda #$80                    ; CCE0  A9 80
    sta $71                     ; CCE2  85 71

L_CCE4:
    ldx $21                     ; CCE4  A6 21
    cpx #$10                    ; CCE6  E0 10
    bcs L_CCB7                  ; CCE8  B0 CD
    lda #$01                    ; CCEA  A9 01
    sta $0700,x                 ; CCEC  9D 00 07
    sta $0702,x                 ; CCEF  9D 02 07
    inx                         ; CCF2  E8
    lda #$20                    ; CCF3  A9 20
    sta $0700,x                 ; CCF5  9D 00 07
    inx                         ; CCF8  E8
    inx                         ; CCF9  E8
    lda $6D                     ; CCFA  A5 6D
    sta $0700,x                 ; CCFC  9D 00 07
    inx                         ; CCFF  E8
    lda $6C                     ; CD00  A5 6C
    sta $0700,x                 ; CD02  9D 00 07
    inx                         ; CD05  E8
    ldy #$00                    ; CD06  A0 00

L_CD08:
    lda ($6E),y                 ; CD08  B1 6E
    sta $0700,x                 ; CD0A  9D 00 07
    iny                         ; CD0D  C8
    inx                         ; CD0E  E8
    cpy #$20                    ; CD0F  C0 20
    bne L_CD08                  ; CD11  D0 F5
    stx $21                     ; CD13  86 21
    dec $70                     ; CD15  C6 70
    beq L_CD27                  ; CD17  F0 0E
    lda #$20                    ; CD19  A9 20
    ldx #$6E                    ; CD1B  A2 6E
    jsr L_C892                  ; CD1D  20 92 C8
    lda #$20                    ; CD20  A9 20
    ldx #$6C                    ; CD22  A2 6C
    jmp L_C892                  ; CD24  4C 92 C8


L_CD27:
    lda #$00                    ; CD27  A9 00
    sta $71                     ; CD29  85 71
    rts                         ; CD2B  60

D_CD2C:
    .byte $80
D_CD2D:
    .byte $1A
D_CD2E:
    .byte $52
D_CD2F:
    .byte $92
D_CD30:
    .byte $2C,$00,$10,$52,$92,$00,$60,$14,$D2,$97,$5D,$00,$10,$52,$92,$00
    .byte $A0,$16,$72,$A3,$1D,$80,$0A,$12,$A7,$22,$00,$10,$52,$92,$00,$60
    .byte $1B,$52,$AB,$25

L_CD54:
    lda $40                     ; CD54  A5 40
    bmi L_CDBC                  ; CD56  30 64
    lda $37                     ; CD58  A5 37
    beq L_CD64                  ; CD5A  F0 08
    lda #$80                    ; CD5C  A9 80
    sta $37                     ; CD5E  85 37
    lda #$20                    ; CD60  A9 20
    bne L_CD6F                  ; CD62  D0 0B

L_CD64:
    lda $1A                     ; CD64  A5 1A
    and #$03                    ; CD66  29 03
    bne L_CDBC                  ; CD68  D0 52
    lda $1A                     ; CD6A  A5 1A
    and #$0C                    ; CD6C  29 0C
    asl a                       ; CD6E  0A

L_CD6F:
    sta $14                     ; CD6F  85 14
    ldx $21                     ; CD71  A6 21
    lda #$01                    ; CD73  A9 01
    sta $0700,x                 ; CD75  9D 00 07
    sta $0702,x                 ; CD78  9D 02 07
    inx                         ; CD7B  E8
    lda #$40                    ; CD7C  A9 40
    sta $0700,x                 ; CD7E  9D 00 07
    inx                         ; CD81  E8
    inx                         ; CD82  E8
    lda #$1F                    ; CD83  A9 1F
    sta $0700,x                 ; CD85  9D 00 07
    inx                         ; CD88  E8
    lda #$C0                    ; CD89  A9 C0
    sta $0700,x                 ; CD8B  9D 00 07
    inx                         ; CD8E  E8
    lda D_CDBD                  ; CD8F  AD BD CD
    sta $10                     ; CD92  85 10
    lda D_CDBE                  ; CD94  AD BE CD
    sta $11                     ; CD97  85 11
    lda #$07                    ; CD99  A9 07
    sta $13                     ; CD9B  85 13
    stx $12                     ; CD9D  86 12
    ldx $14                     ; CD9F  A6 14
    ldy #$00                    ; CDA1  A0 00

L_CDA3:
    lda ($10),y                 ; CDA3  B1 10
    ora D_CDFF,x                ; CDA5  1D FF CD
    sta ($12),y                 ; CDA8  91 12
    inx                         ; CDAA  E8
    txa                         ; CDAB  8A
    and #$07                    ; CDAC  29 07
    ora $14                     ; CDAE  05 14
    tax                         ; CDB0  AA
    iny                         ; CDB1  C8
    cpy #$40                    ; CDB2  C0 40
    bcc L_CDA3                  ; CDB4  90 ED
    tya                         ; CDB6  98
    clc                         ; CDB7  18
    adc $12                     ; CDB8  65 12
    sta $21                     ; CDBA  85 21

L_CDBC:
    rts                         ; CDBC  60

D_CDBD:
    .byte $BF
D_CDBE:
    .byte $CD,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FE,$FC,$F8,$F0,$E0,$C0,$80,$00,$00,$01,$03,$07,$0F,$1F,$3F
    .byte $7F,$7F,$3F,$1F,$0F,$07,$03,$01,$00,$00,$80,$C0,$E0,$F0,$F8,$FC
    .byte $FE
D_CDFF:
    .byte $00,$00,$04,$44,$EB,$32,$20,$00,$00,$00,$10,$30,$EB,$6A,$44,$00
    .byte $00,$00,$08,$0C,$D7,$56,$22,$00,$00,$00,$20,$22,$D7,$4C,$04,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00

L_CE27:
    lda $2C                     ; CE27  A5 2C
    cmp #$04                    ; CE29  C9 04
    bne L_CE32                  ; CE2B  D0 05
    jsr L_C22B                  ; CE2D  20 2B C2

L_CE30:
    lda $2C                     ; CE30  A5 2C

L_CE32:
    jsr JumpTable               ; CE32  20 57 C8
    .word L_CE4B                    ; CE35
    .word L_CE7E                    ; CE37
    .word L_CE9B                    ; CE39
    .word L_CED8                    ; CE3B
    .word L_CEE3                    ; CE3D
    .word L_CF2E                    ; CE3F
    .word L_CF9D                    ; CE41
    .word L_CFE1                    ; CE43
    .word L_CFEA                    ; CE45
    .word L_D01F                    ; CE47
    .word L_D02E                    ; CE49

L_CE4B:
    jsr L_C183                  ; CE4B  20 83 C1
    jsr L_C9A1                  ; CE4E  20 A1 C9
    lda #$06                    ; CE51  A9 06
    jsr L_C217                  ; CE53  20 17 C2
    ldy #$02                    ; CE56  A0 02
    jsr SwitchBank              ; CE58  20 39 C1
    lda $30                     ; CE5B  A5 30
    asl a                       ; CE5D  0A
    asl a                       ; CE5E  0A
    asl a                       ; CE5F  0A
    asl a                       ; CE60  0A
    asl a                       ; CE61  0A
    tay                         ; CE62  A8
    ldx #$00                    ; CE63  A2 00
    stx $3B                     ; CE65  86 3B
    stx $0194                   ; CE67  8E 94 01

L_CE6A:
    lda D2_B319,y               ; CE6A  B9 19 B3
    sta $40,x                   ; CE6D  95 40
    iny                         ; CE6F  C8
    inx                         ; CE70  E8
    cpx #$20                    ; CE71  E0 20
    bne L_CE6A                  ; CE73  D0 F5
    jsr L_DB9D                  ; CE75  20 9D DB
    jsr L_C1D9                  ; CE78  20 D9 C1

L_CE7B:
    inc $2C                     ; CE7B  E6 2C
    rts                         ; CE7D  60


L_CE7E:
    lda $1C                     ; CE7E  A5 1C
    bne L_CE97                  ; CE80  D0 15
    jsr L_CAAD                  ; CE82  20 AD CA
    lda #$00                    ; CE85  A9 00
    sta $1E                     ; CE87  85 1E
    jsr L_CA61                  ; CE89  20 61 CA
    lda $22                     ; CE8C  A5 22
    beq L_CE95                  ; CE8E  F0 05
    sta $1E                     ; CE90  85 1E
    jsr L_CA61                  ; CE92  20 61 CA

L_CE95:
    lda #$C0                    ; CE95  A9 C0

L_CE97:
    sta $2A                     ; CE97  85 2A
    bne L_CE7B                  ; CE99  D0 E0

L_CE9B:
    jsr L_C315                  ; CE9B  20 15 C3
    bne L_CEC5                  ; CE9E  D0 25
    jsr L_C9A1                  ; CEA0  20 A1 C9
    jsr L_C201                  ; CEA3  20 01 C2
    lda #$20                    ; CEA6  A9 20
    jsr L_D081                  ; CEA8  20 81 D0
    lda $30                     ; CEAB  A5 30
    asl a                       ; CEAD  0A
    tay                         ; CEAE  A8
    lda D_CEC8,y                ; CEAF  B9 C8 CE
    sta $FC                     ; CEB2  85 FC
    lda $1C                     ; CEB4  A5 1C
    bne L_CEBE                  ; CEB6  D0 06
    lda D_CEC9,y                ; CEB8  B9 C9 CE
    jsr L_C16B                  ; CEBB  20 6B C1

L_CEBE:
    lda #$FF                    ; CEBE  A9 FF
    sta $23                     ; CEC0  85 23
    inc $2C                     ; CEC2  E6 2C

L_CEC4:
    rts                         ; CEC4  60


L_CEC5:
    jmp L_CAC1                  ; CEC5  4C C1 CA

D_CEC8:
    .byte $E0
D_CEC9:
    .byte $2A,$E8,$3E,$00,$2E,$E8,$3E,$E0,$32,$E0,$36,$E0,$2A,$E0,$3A

L_CED8:
    jsr L_C1F1                  ; CED8  20 F1 C1
    bne L_CEC4                  ; CEDB  D0 E7
    lda #$FF                    ; CEDD  A9 FF
    sta $6A                     ; CEDF  85 6A
    bne L_CE7B                  ; CEE1  D0 98

L_CEE3:
    jsr L_D038                  ; CEE3  20 38 D0

L_CEE6:
    lda $25                     ; CEE6  A5 25
    bne L_CF09                  ; CEE8  D0 1F
    lda $3B                     ; CEEA  A5 3B
    bne L_CF25                  ; CEEC  D0 37

L_CEEE:
    jsr L_D371                  ; CEEE  20 71 D3
    jsr AllOut4P                ; CEF1  A5 38 25  [4P] antes: lda $38 / and $39
    nop
    bne L_CF0A                  ; CEF5  D0 13      game over si no queda nadie

L_CEF7:
    jsr L_C1E9                  ; CEF7  20 E9 C1
    jsr L_C1C9                  ; CEFA  20 C9 C1
    jsr L_C1D1                  ; CEFD  20 D1 C1
    jsr L_C1E1                  ; CF00  20 E1 C1
    jsr L_D105                  ; CF03  20 05 D1
    jsr L_C1F9                  ; CF06  20 F9 C1

L_CF09:
    rts                         ; CF09  60


L_CF0A:
    lda #$60                    ; CF0A  A9 60
    sta $29                     ; CF0C  85 29
    lda #$0A                    ; CF0E  A9 0A
    bne L_CF27                  ; CF10  D0 15

L_CF12:
    lda #$00                    ; CF12  A9 00
    sta $3B                     ; CF14  85 3B
    lda #$05                    ; CF16  A9 05
    jsr L_CF27                  ; CF18  20 27 CF

L_CF1B:
    lda #$00                    ; CF1B  A9 00
    sta $23                     ; CF1D  85 23
    sta $0700                   ; CF1F  8D 00 07
    jmp L_C183                  ; CF22  4C 83 C1


L_CF25:
    lda #$08                    ; CF25  A9 08

L_CF27:
    sta $2C                     ; CF27  85 2C
    lda #$00                    ; CF29  A9 00
    sta $2D                     ; CF2B  85 2D
    rts                         ; CF2D  60


L_CF2E:
    lda #$00                    ; CF2E  A9 00
    sta $6A                     ; CF30  85 6A
    sta $37                     ; CF32  85 37
    lda $AA                     ; CF34  A5 AA
    sta $10                     ; CF36  85 10
    lda $AB                     ; CF38  A5 AB
    sta $11                     ; CF3A  85 11
    ldx #$40                    ; CF3C  A2 40
    jsr L_C481                  ; CF3E  20 81 C4
    lda $3B                     ; CF41  A5 3B
    beq L_CF6E                  ; CF43  F0 29
    lda $10                     ; CF45  A5 10
    sta $AA                     ; CF47  85 AA
    lda $11                     ; CF49  A5 11
    sta $AB                     ; CF4B  85 AB
    inc $30                     ; CF4D  E6 30
    lda $30                     ; CF4F  A5 30
    cmp #$08                    ; CF51  C9 08
    bcc L_CF60                  ; CF53  90 0B
    jsr L_C301                  ; CF55  20 01 C3
    inc $31                     ; CF58  E6 31
    lda #$09                    ; CF5A  A9 09
    sta $30                     ; CF5C  85 30
    bne L_CF65                  ; CF5E  D0 05

L_CF60:
    lda #$0A                    ; CF60  A9 0A
    jsr L_C204                  ; CF62  20 04 C2

L_CF65:
    lda #$00                    ; CF65  A9 00
    sta $2C                     ; CF67  85 2C
    sta $2D                     ; CF69  85 2D
    sta $6A                     ; CF6B  85 6A
    rts                         ; CF6D  60


L_CF6E:
    lda $1C                     ; CF6E  A5 1C
    bne L_CF9A                  ; CF70  D0 28
    jsr L_C9A1                  ; CF72  20 A1 C9
    lda #$0A                    ; CF75  A9 0A
    jsr L_C204                  ; CF77  20 04 C2
    lda #$06                    ; CF7A  A9 06
    jsr L_C217                  ; CF7C  20 17 C2
    lda #$0D                    ; CF7F  A9 0D
    jsr L_C217                  ; CF81  20 17 C2
    lda #$4E                    ; CF84  A9 4E
    jsr L_C16B                  ; CF86  20 6B C1
    dec $3A                     ; CF89  C6 3A
    bmi L_CF95                  ; CF8B  30 08
    lda #$0E                    ; CF8D  A9 0E
    jsr L_C217                  ; CF8F  20 17 C2
    jmp L_CE7B                  ; CF92  4C 7B CE


L_CF95:
    lda #$07                    ; CF95  A9 07
    jmp L_CF27                  ; CF97  4C 27 CF


L_CF9A:
    inc $1F                     ; CF9A  E6 1F
    rts                         ; CF9C  60


L_CF9D:
    lda $F5                     ; CF9D  A5 F5
    and #$10                    ; CF9F  29 10
    beq L_CFBB                  ; CFA1  F0 18
    jsr L_C183                  ; CFA3  20 83 C1
    lda $6B                     ; CFA6  A5 6B
    bne L_CFDC                  ; CFA8  D0 32
    jsr Continue4P              ; CFAA  20 47 C4  [4P] antes: jsr L_C447
    lda #$00                    ; CFAD  A9 00
    sta $2C                     ; CFAF  85 2C

L_CFB1:
    sta $0334                   ; CFB1  8D 34 03
    sta $031A                   ; CFB4  8D 1A 03
    sta $0300                   ; CFB7  8D 00 03
    rts                         ; CFBA  60


L_CFBB:
    lda $F5                     ; CFBB  A5 F5
    and #$20                    ; CFBD  29 20
    beq L_CFC7                  ; CFBF  F0 06
    lda $6B                     ; CFC1  A5 6B
    eor #$01                    ; CFC3  49 01
    sta $6B                     ; CFC5  85 6B

L_CFC7:
    lda #$52                    ; CFC7  A9 52
    sta $0334                   ; CFC9  8D 34 03
    lda #$AA                    ; CFCC  A9 AA
    sta $0300                   ; CFCE  8D 00 03
    ldx $6B                     ; CFD1  A6 6B
    lda D_C272,x                ; CFD3  BD 72 C2
    sta $031A                   ; CFD6  8D 1A 03
    jmp L_CAC1                  ; CFD9  4C C1 CA


L_CFDC:
    lda #$00                    ; CFDC  A9 00
    jmp L_C30E                  ; CFDE  4C 0E C3


L_CFE1:
    lda $F5                     ; CFE1  A5 F5
    and #$10                    ; CFE3  29 10
    bne L_CFDC                  ; CFE5  D0 F5
    jmp L_CAC1                  ; CFE7  4C C1 CA


L_CFEA:
    jsr L_CEEE                  ; CFEA  20 EE CE
    lda $2C                     ; CFED  A5 2C
    cmp #$0A                    ; CFEF  C9 0A
    beq L_D01E                  ; CFF1  F0 2B
    ldy $2A                     ; CFF3  A4 2A
    beq L_CFFF                  ; CFF5  F0 08
    iny                         ; CFF7  C8
    beq L_D01E                  ; CFF8  F0 24
    jsr L_C315                  ; CFFA  20 15 C3
    bne L_D01E                  ; CFFD  D0 1F

L_CFFF:
    ldx #$01                    ; CFFF  A2 01
    ldy #$00                    ; D001  A0 00

L_D003:
    lda $38,x                   ; D003  B5 38
    bne L_D00E                  ; D005  D0 07
    lda $90,x                   ; D007  B5 90
    cmp #$01                    ; D009  C9 01
    bne L_D00E                  ; D00B  D0 01
    iny                         ; D00D  C8

L_D00E:
    dex                         ; D00E  CA
    bpl L_D003                  ; D00F  10 F2
    jsr CountAlive4P            ; D011  98 8D 94  [4P] antes: tya / sta $0194
    nop
    beq L_D01E                  ; D015  F0 07
    lda #$46                    ; D017  A9 46
    jsr L_C16B                  ; D019  20 6B C1
    inc $2C                     ; D01C  E6 2C

L_D01E:
    rts                         ; D01E  60


L_D01F:
    jsr L_C233                  ; D01F  20 33 C2
    jsr L_D371                  ; D022  20 71 D3
    jsr L_C1E9                  ; D025  20 E9 C1
    jsr L_C1C9                  ; D028  20 C9 C1
    jmp L_D105                  ; D02B  4C 05 D1


L_D02E:
    jsr L_CEF7                  ; D02E  20 F7 CE
    dec $29                     ; D031  C6 29
    bne L_D01E                  ; D033  D0 E9
    jmp L_CF12                  ; D035  4C 12 CF


L_D038:
    lda $1C                     ; D038  A5 1C
    ora $26                     ; D03A  05 26
    ora $20                     ; D03C  05 20
    bne L_D063                  ; D03E  D0 23
    lda $F5                     ; D040  A5 F5
    ldy $25                     ; D042  A4 25
    bne L_D053                  ; D044  D0 0D
    and #$10                    ; D046  29 10
    beq L_D063                  ; D048  F0 19
    lda #$01                    ; D04A  A9 01
    sta $25                     ; D04C  85 25
    lda #$54                    ; D04E  A9 54
    jmp L_C16B                  ; D050  4C 6B C1


L_D053:
    jsr L_D38B                  ; D053  20 8B D3
    jsr L_C20F                  ; D056  20 0F C2
    lda $F5                     ; D059  A5 F5
    and #$10                    ; D05B  29 10
    beq L_D063                  ; D05D  F0 04
    lda #$00                    ; D05F  A9 00
    sta $25                     ; D061  85 25

L_D063:
    rts                         ; D063  60


L_D064:
    lda #$FF                    ; D064  A9 FF
    sta $48                     ; D066  85 48
    lda $30                     ; D068  A5 30
    asl a                       ; D06A  0A
    asl a                       ; D06B  0A
    asl a                       ; D06C  0A
    asl a                       ; D06D  0A
    sec                         ; D06E  38
    sbc $30                     ; D06F  E5 30
    tay                         ; D071  A8
    ldx #$00                    ; D072  A2 00

L_D074:
    lda D_D19E,y                ; D074  B9 9E D1
    sta $49,x                   ; D077  95 49
    iny                         ; D079  C8
    inx                         ; D07A  E8
    cpx #$0F                    ; D07B  E0 0F
    bne L_D074                  ; D07D  D0 F5
    lda #$20                    ; D07F  A9 20

L_D081:
    sta $02                     ; D081  85 02
    sta $36                     ; D083  85 36
    lda $1A                     ; D085  A5 1A
    and #$30                    ; D087  29 30
    sta $03                     ; D089  85 03
    ldx #$00                    ; D08B  A2 00
    stx $00                     ; D08D  86 00

L_D08F:
    lda #$00                    ; D08F  A9 00
    sta $07                     ; D091  85 07
    ldy $00                     ; D093  A4 00
    lda a:$0050,y               ; D095  B9 50 00
    asl a                       ; D098  0A
    adc a:$0050,y               ; D099  79 50 00
    rol $07                     ; D09C  26 07
    adc D_D225                  ; D09E  6D 25 D2
    sta $06                     ; D0A1  85 06
    lda $07                     ; D0A3  A5 07
    adc D_D226                  ; D0A5  6D 26 D2
    sta $07                     ; D0A8  85 07
    ldy #$00                    ; D0AA  A0 00
    lda #$0F                    ; D0AC  A9 0F
    sta $07C0,x                 ; D0AE  9D C0 07
    inx                         ; D0B1  E8

L_D0B2:
    lda $74                     ; D0B2  A5 74
    bne L_D0D0                  ; D0B4  D0 1A

L_D0B6:
    lda ($06),y                 ; D0B6  B1 06

L_D0B8:
    sta $07C0,x                 ; D0B8  9D C0 07
    iny                         ; D0BB  C8
    inx                         ; D0BC  E8
    cpy #$03                    ; D0BD  C0 03
    bne L_D0B2                  ; D0BF  D0 F1
    inc $00                     ; D0C1  E6 00
    cpx $02                     ; D0C3  E4 02
    bne L_D08F                  ; D0C5  D0 C8
    lda $74                     ; D0C7  A5 74
    beq L_D0CF                  ; D0C9  F0 04
    bmi L_D0CF                  ; D0CB  30 02
    dec $74                     ; D0CD  C6 74

L_D0CF:
    rts                         ; D0CF  60


L_D0D0:
    sty $03                     ; D0D0  84 03
    ldy $40                     ; D0D2  A4 40
    bmi L_D0DC                  ; D0D4  30 06
    ldy $03                     ; D0D6  A4 03
    cpx #$04                    ; D0D8  E0 04
    bcc L_D0B6                  ; D0DA  90 DA

L_D0DC:
    ldy $03                     ; D0DC  A4 03
    cpx #$10                    ; D0DE  E0 10
    bcs L_D0B6                  ; D0E0  B0 D4
    lda $74                     ; D0E2  A5 74
    bmi L_D0F9                  ; D0E4  30 13
    cmp #$09                    ; D0E6  C9 09
    bcs L_D0F9                  ; D0E8  B0 0F
    tay                         ; D0EA  A8
    lda L_D0FB+1,y              ; D0EB  B9 FC D0
    sta $04                     ; D0EE  85 04
    ldy $03                     ; D0F0  A4 03
    lda ($06),y                 ; D0F2  B1 06
    sec                         ; D0F4  38
    sbc $04                     ; D0F5  E5 04
    bcs L_D0B8                  ; D0F7  B0 BF

L_D0F9:
    lda #$0F                    ; D0F9  A9 0F

L_D0FB:
    bne L_D0B8                  ; D0FB  D0 BB
    .byte $00,$00,$10,$10,$20,$20,$30,$30

L_D105:
    lda $36                     ; D105  A5 36
    cmp $18                     ; D107  C5 18
    bcs L_D16B                  ; D109  B0 60
    lda $1A                     ; D10B  A5 1A
    and #$07                    ; D10D  29 07
    cmp #$05                    ; D10F  C9 05
    bne L_D14A                  ; D111  D0 37
    lda $78                     ; D113  A5 78
    bne L_D14A                  ; D115  D0 33
    inc $72                     ; D117  E6 72
    lda $72                     ; D119  A5 72
    ldy $30                     ; D11B  A4 30
    cmp D_D181,y                ; D11D  D9 81 D1
    bcc L_D126                  ; D120  90 04
    lda #$00                    ; D122  A9 00
    sta $72                     ; D124  85 72

L_D126:
    tay                         ; D126  A8
    lda a:$004C,y               ; D127  B9 4C 00
    sta $53                     ; D12A  85 53
    lda $40                     ; D12C  A5 40
    bmi L_D16C                  ; D12E  30 3C
    lda $30                     ; D130  A5 30
    beq L_D140                  ; D132  F0 0C
    cmp #$07                    ; D134  C9 07
    beq L_D145                  ; D136  F0 0D
    cmp #$08                    ; D138  C9 08
    beq L_D17C                  ; D13A  F0 40
    lda $48                     ; D13C  A5 48
    bmi L_D145                  ; D13E  30 05

L_D140:
    lda D_D196,y                ; D140  B9 96 D1

L_D143:
    sta $52                     ; D143  85 52

L_D145:
    lda #$10                    ; D145  A9 10
    jsr L_D081                  ; D147  20 81 D0

L_D14A:
    lda $7D                     ; D14A  A5 7D
    beq L_D16B                  ; D14C  F0 1D
    dec $7D                     ; D14E  C6 7D
    lda $7D                     ; D150  A5 7D
    lsr a                       ; D152  4A
    bcs L_D16B                  ; D153  B0 16
    and #$03                    ; D155  29 03
    tay                         ; D157  A8
    lda D_D192,y                ; D158  B9 92 D1
    sta $07D0                   ; D15B  8D D0 07
    sta $07D4                   ; D15E  8D D4 07
    sta $07D8                   ; D161  8D D8 07
    sta $07DC                   ; D164  8D DC 07
    lda #$20                    ; D167  A9 20
    sta $36                     ; D169  85 36

L_D16B:
    rts                         ; D16B  60


L_D16C:
    lda $30                     ; D16C  A5 30
    and #$02                    ; D16E  29 02
    asl a                       ; D170  0A
    adc $72                     ; D171  65 72
    tay                         ; D173  A8
    lda D_D18A,y                ; D174  B9 8A D1
    sta $52                     ; D177  85 52
    jmp L_D145                  ; D179  4C 45 D1


L_D17C:
    lda D_D19A,y                ; D17C  B9 9A D1
    bne L_D143                  ; D17F  D0 C2
D_D181:
    .byte $04,$04,$03,$04,$04,$04,$04,$04,$04
D_D18A:
    .byte $13,$14,$15,$14,$1B,$1C,$1D,$1C
D_D192:
    .byte $0F,$30,$16,$11
D_D196:
    .byte $04,$5C,$04,$5D
D_D19A:
    .byte $66,$6A,$6B,$6A
D_D19E:
    .byte $06,$A8,$A8,$23,$23,$23,$23,$02,$03,$04,$23,$00,$01,$22,$07,$00
    .byte $FF,$FF,$16,$17,$18,$17,$11,$12,$13,$16,$00,$01,$22,$21,$07,$FF
    .byte $FF,$27,$54,$55,$54,$0B,$25,$26,$27,$00,$01,$22,$07,$00,$FF,$FF
    .byte $1E,$1F,$20,$1F,$19,$1A,$1C,$1E,$00,$01,$22,$2B,$20,$F0,$F0,$42
    .byte $42,$42,$42,$3D,$3E,$40,$42,$00,$01,$22,$06,$0C,$DE,$DE,$3A,$3B
    .byte $3A,$3C,$39,$39,$04,$3A,$00,$01,$22,$56,$0E,$F1,$F1,$5A,$5F,$5A
    .byte $5B,$45,$46,$59,$5F,$00,$01,$22,$07,$05,$B6,$B6,$4B,$50,$4B,$50
    .byte $48,$49,$4A,$4B,$00,$01,$43,$44,$00,$00,$00,$67,$68,$69,$68,$25
    .byte $65,$66,$67,$6D,$6C,$22,$64
D_D225:
    .byte $27
D_D226:
    .byte $D2,$37,$12,$0F,$36,$16,$0F,$19,$29,$08,$28,$18,$08,$16,$30,$10
    .byte $11,$21,$30,$16,$20,$00,$20,$00,$0F,$11,$30,$21,$10,$00,$09,$00
    .byte $0C,$20,$0A,$1A,$00,$28,$18,$07,$1C,$2C,$0C,$0C,$1C,$2C,$2C,$0C
    .byte $1C,$10,$2B,$0F,$06,$00,$08,$20,$00,$08,$06,$00,$08,$16,$00,$08
    .byte $26,$00,$08,$20,$00,$06,$20,$00,$16,$20,$00,$26,$0C,$18,$09,$20
    .byte $18,$09,$06,$18,$09,$16,$18,$09,$26,$18,$09,$20,$18,$06,$20,$18
    .byte $16,$20,$18,$26,$20,$22,$02,$20,$26,$16,$01,$30,$10,$36,$06,$02
    .byte $30,$10,$00,$28,$18,$08,$05,$18,$08,$36,$06,$22,$36,$06,$32,$20
    .byte $1B,$0F,$20,$22,$1C,$10,$00,$0C,$00,$06,$20,$38,$09,$06,$38,$09
    .byte $16,$38,$09,$26,$0F,$20,$2C,$0F,$20,$26,$00,$20,$1A,$01,$20,$00
    .byte $20,$27,$17,$20,$26,$07,$20,$27,$16,$20,$26,$06,$00,$10,$13,$16
    .byte $20,$00,$06,$20,$00,$26,$20,$00,$20,$10,$1C,$20,$10,$0A,$20,$00
    .byte $17,$20,$12,$00,$07,$00,$17,$20,$16,$00,$30,$28,$16,$30,$25,$14
    .byte $27,$17,$06,$20,$10,$00,$06,$1B,$0B,$10,$00,$07,$36,$15,$06,$35
    .byte $15,$04,$35,$16,$1C,$18,$13,$03,$26,$13,$03,$14,$13,$03,$2B,$13
    .byte $03,$26,$16,$03,$20,$13,$27,$20,$16,$27,$00,$00,$00,$15,$18,$08
    .byte $35,$18,$08,$20,$12,$17,$15,$1B,$0B,$0F,$1B,$0B,$24,$13,$03,$27
    .byte $17,$06,$17,$06,$0F,$06,$30,$10,$26,$30,$10,$00,$00,$00,$20,$27
    .byte $17,$10,$26,$06,$10,$16,$07,$20,$22,$02,$22,$20,$02,$20,$10,$00
    .byte $18,$07,$1A,$16,$18,$07,$20,$10,$11,$20,$11,$11,$20,$2C,$11,$26
    .byte $18,$07,$16,$18,$07,$16,$00,$00,$0B,$1B,$3B

L_D371:
    jsr Players4P               ; D371  20 B4 D3  [4P] antes: jsr L_D3B4
    lda $73                     ; D374  A5 73
    cmp #$02                    ; D376  C9 02
    bcc L_D37C                  ; D378  90 02
    lda #$00                    ; D37A  A9 00

L_D37C:
    sta $73                     ; D37C  85 73
    lda $75                     ; D37E  A5 75
    ora $76                     ; D380  05 76
    beq L_D388                  ; D382  F0 04
    lda #$01                    ; D384  A9 01
    sta $68                     ; D386  85 68

L_D388:
    jsr L_C1B9                  ; D388  20 B9 C1

L_D38B:
    ldy #$07                    ; D38B  A0 07

L_D38D:
    tya                         ; D38D  98
    asl a                       ; D38E  0A
    sta $08                     ; D38F  85 08
    lda $1A                     ; D391  A5 1A
    and #$01                    ; D393  29 01
    ora $08                     ; D395  05 08
    tax                         ; D397  AA
    lda $0368,x                 ; D398  BD 68 03
    sta $0302,y                 ; D39B  99 02 03
    lda $0378,x                 ; D39E  BD 78 03
    sta $0350,y                 ; D3A1  99 50 03
    lda $03B8,x                 ; D3A4  BD B8 03
    sta $031C,y                 ; D3A7  99 1C 03
    lda $03C8,x                 ; D3AA  BD C8 03
    sta $0336,y                 ; D3AD  99 36 03
    dey                         ; D3B0  88
    bpl L_D38D                  ; D3B1  10 DA
    rts                         ; D3B3  60


L_D3B4:
    lda #$00                    ; D3B4  A9 00
    sta $68                     ; D3B6  85 68
    sta $A2                     ; D3B8  85 A2
    sta $A3                     ; D3BA  85 A3
    sta $8E                     ; D3BC  85 8E
    sta $2F                     ; D3BE  85 2F
    ldy $38                     ; D3C0  A4 38
    bne L_D3C6                  ; D3C2  D0 02
    ora #$01                    ; D3C4  09 01

L_D3C6:
    ldy $39                     ; D3C6  A4 39
    bne L_D3CC                  ; D3C8  D0 02
    ora #$02                    ; D3CA  09 02

L_D3CC:
    tax                         ; D3CC  AA
    beq L_D3E6                  ; D3CD  F0 17
    dex                         ; D3CF  CA
    stx $DF                     ; D3D0  86 DF
    txa                         ; D3D2  8A
    and #$01                    ; D3D3  29 01
    tax                         ; D3D5  AA
    jsr L_D460                  ; D3D6  20 60 D4
    lda $DF                     ; D3D9  A5 DF
    cmp #$02                    ; D3DB  C9 02
    bne L_D3E6                  ; D3DD  D0 07
    inx                         ; D3DF  E8
    jsr L_D460                  ; D3E0  20 60 D4
    jsr L_D42C                  ; D3E3  20 2C D4

L_D3E6:
    lda $2C                     ; D3E6  A5 2C
    cmp #$04                    ; D3E8  C9 04
    bne L_D42B                  ; D3EA  D0 3F
    lda $22                     ; D3EC  A5 22
    beq L_D42B                  ; D3EE  F0 3B
    ldx #$01                    ; D3F0  A2 01

L_D3F2:
    lda $38,x                   ; D3F2  B5 38
    bne L_D3FB                  ; D3F4  D0 05
    dex                         ; D3F6  CA
    bpl L_D3F2                  ; D3F7  10 F9
    bmi L_D42B                  ; D3F9  30 30

L_D3FB:
    lda $F5,x                   ; D3FB  B5 F5
    and #$80                    ; D3FD  29 80
    beq L_D42B                  ; D3FF  F0 2A
    txa                         ; D401  8A
    eor #$01                    ; D402  49 01
    tay                         ; D404  A8
    lda a:$0032,y               ; D405  B9 32 00
    beq L_D42B                  ; D408  F0 21
    cmp #$01                    ; D40A  C9 01
    bne L_D415                  ; D40C  D0 07
    lda a:$0090,y               ; D40E  B9 90 00
    cmp #$01                    ; D411  C9 01
    bne L_D42B                  ; D413  D0 16

L_D415:
    lda a:$0032,y               ; D415  B9 32 00
    sec                         ; D418  38
    sbc #$01                    ; D419  E9 01
    cmp #$FF                    ; D41B  C9 FF
    bne L_D421                  ; D41D  D0 02
    lda #$00                    ; D41F  A9 00

L_D421:
    sta a:$0032,y               ; D421  99 32 00
    jsr L_DAD1                  ; D424  20 D1 DA
    sta $90,x                   ; D427  95 90
    sta $38,x                   ; D429  95 38

L_D42B:
    rts                         ; D42B  60


L_D42C:
    lda $40                     ; D42C  A5 40
    bne L_D453                  ; D42E  D0 23
    lda $41                     ; D430  A5 41
    bne L_D43D                  ; D432  D0 09
    jsr L_D454                  ; D434  20 54 D4
    beq L_D43C                  ; D437  F0 03
    dec $0334,x                 ; D439  DE 34 03

L_D43C:
    rts                         ; D43C  60


L_D43D:
    lda $75                     ; D43D  A5 75
    bne L_D453                  ; D43F  D0 12
    jsr L_D454                  ; D441  20 54 D4
    beq L_D453                  ; D444  F0 0D
    lda $031A,x                 ; D446  BD 1A 03
    clc                         ; D449  18
    adc $68                     ; D44A  65 68
    sta $031A,x                 ; D44C  9D 1A 03
    bcc L_D453                  ; D44F  90 02
    inc $BA,x                   ; D451  F6 BA

L_D453:
    rts                         ; D453  60


L_D454:
    ldx #$00                    ; D454  A2 00
    lda $A2                     ; D456  A5 A2
    cmp $A3                     ; D458  C5 A3
    beq L_D45F                  ; D45A  F0 03
    bcc L_D45F                  ; D45C  90 01
    inx                         ; D45E  E8

L_D45F:
    rts                         ; D45F  60


L_D460:
    jsr L_D4A0                  ; D460  20 A0 D4
    lda $AE,x                   ; D463  B5 AE
    beq L_D46C                  ; D465  F0 05
    dec $AE,x                   ; D467  D6 AE
    jmp L_D476                  ; D469  4C 76 D4


L_D46C:
    lda $90,x                   ; D46C  B5 90
    cmp #$01                    ; D46E  C9 01
    bne L_D476                  ; D470  D0 04
    lda #$01                    ; D472  A9 01
    sta $8E                     ; D474  85 8E

L_D476:
    lda $B0,x                   ; D476  B5 B0
    beq L_D482                  ; D478  F0 08
    lda $1A                     ; D47A  A5 1A
    and #$07                    ; D47C  29 07
    bne L_D482                  ; D47E  D0 02
    dec $B0,x                   ; D480  D6 B0

L_D482:
    lda $CE,x                   ; D482  B5 CE
    beq L_D488                  ; D484  F0 02
    dec $CE,x                   ; D486  D6 CE

L_D488:
    lda #$00                    ; D488  A9 00
    sta $D4,x                   ; D48A  95 D4
    lda $AA,x                   ; D48C  B5 AA
    and #$07                    ; D48E  29 07
    tay                         ; D490  A8
    lda D_D49B,y                ; D491  B9 9B D4
    cmp $2F                     ; D494  C5 2F
    bcc L_D49A                  ; D496  90 02
    sta $2F                     ; D498  85 2F

L_D49A:
    rts                         ; D49A  60

D_D49B:
    .byte $00,$02,$01,$03,$02

L_D4A0:
    ldy $30                     ; D4A0  A4 30
    lda $40                     ; D4A2  A5 40
    asl a                       ; D4A4  0A
    lda D_D4BB,y                ; D4A5  B9 BB D4
    bcc L_D4AC                  ; D4A8  90 02
    lda #$03                    ; D4AA  A9 03

L_D4AC:
    sta $08                     ; D4AC  85 08
    lda $90,x                   ; D4AE  B5 90
    jsr JumpTable               ; D4B0  20 57 C8
    .word L_D4C3                    ; D4B3
    .word L_D534                    ; D4B5
    .word L_D593                    ; D4B7
    .word L_D3E6                    ; D4B9
D_D4BB:
    .byte $00,$01,$02,$01,$00,$00,$00,$00

L_D4C3:
    jsr L_DAD5                  ; D4C3  20 D5 DA
    txa                         ; D4C6  8A
    asl a                       ; D4C7  0A
    asl a                       ; D4C8  0A
    clc                         ; D4C9  18
    adc $08                     ; D4CA  65 08
    tay                         ; D4CC  A8
    lda D_D524,y                ; D4CD  B9 24 D5
    sta $031A,x                 ; D4D0  9D 1A 03
    lda D_D52C,y                ; D4D3  B9 2C D5
    sta $0334,x                 ; D4D6  9D 34 03
    lda #$01                    ; D4D9  A9 01
    sta $A0,x                   ; D4DB  95 A0
    lda $40                     ; D4DD  A5 40
    bne L_D505                  ; D4DF  D0 24
    jsr L_D514                  ; D4E1  20 14 D5
    bcc L_D505                  ; D4E4  90 1F
    lda #$10                    ; D4E6  A9 10
    sta $0334,x                 ; D4E8  9D 34 03

L_D4EB:
    jsr L_D514                  ; D4EB  20 14 D5
    bcc L_D505                  ; D4EE  90 15
    lda $0334,x                 ; D4F0  BD 34 03
    clc                         ; D4F3  18
    adc #$10                    ; D4F4  69 10
    sta $0334,x                 ; D4F6  9D 34 03
    cmp #$E0                    ; D4F9  C9 E0
    bcs L_D500                  ; D4FB  B0 03
    jmp L_D4EB                  ; D4FD  4C EB D4


L_D500:
    lda #$30                    ; D500  A9 30
    sta $0334,x                 ; D502  9D 34 03

L_D505:
    lda #$02                    ; D505  A9 02
    sta $A6,x                   ; D507  95 A6
    lda #$00                    ; D509  A9 00
    sta $C6,x                   ; D50B  95 C6
    lda #$80                    ; D50D  A9 80
    sta $AE,x                   ; D50F  95 AE
    inc $90,x                   ; D511  F6 90
    rts                         ; D513  60


L_D514:
    jsr L_D9A3                  ; D514  20 A3 D9
    asl a                       ; D517  0A
    bcs L_D523                  ; D518  B0 09
    lda $031A,x                 ; D51A  BD 1A 03
    clc                         ; D51D  18
    adc #$20                    ; D51E  69 20
    jmp L_DAA1                  ; D520  4C A1 DA


L_D523:
    rts                         ; D523  60

D_D524:
    .byte $20,$60,$50,$60,$20,$60,$50,$60
D_D52C:
    .byte $30,$70,$30,$70,$20,$90,$20,$90

L_D534:
    jsr L_D56B                  ; D534  20 6B D5
    jsr L_C207                  ; D537  20 07 C2
    lda $C2,x                   ; D53A  B5 C2
    sta $C0,x                   ; D53C  95 C0
    lda $BA,x                   ; D53E  B5 BA
    bne L_D549                  ; D540  D0 07
    lda $031A,x                 ; D542  BD 1A 03
    cmp #$E8                    ; D545  C9 E8
    bcs L_D54A                  ; D547  B0 01

L_D549:
    rts                         ; D549  60


L_D54A:
    lda #$52                    ; D54A  A9 52
    jsr L_C16B                  ; D54C  20 6B C1
    jsr L_D888                  ; D54F  20 88 D8
    sta $B2,x                   ; D552  95 B2
    sta $C8,x                   ; D554  95 C8
    sta $D2,x                   ; D556  95 D2
    sta $A6,x                   ; D558  95 A6
    sta $9E,x                   ; D55A  95 9E
    lda #$01                    ; D55C  A9 01
    sta $B4,x                   ; D55E  95 B4
    lda #$FD                    ; D560  A9 FD
    sta $C6,x                   ; D562  95 C6
    lda #$80                    ; D564  A9 80
    sta $C4,x                   ; D566  95 C4
    inc $90,x                   ; D568  F6 90
    rts                         ; D56A  60


L_D56B:
    jsr L_D912                  ; D56B  20 12 D9
    jsr L_D97A                  ; D56E  20 7A D9
    jsr L_C1C1                  ; D571  20 C1 C1
    jsr L_D5EE                  ; D574  20 EE D5

L_D577:
    lda $75                     ; D577  A5 75
    ora $76                     ; D579  05 76
    beq L_D592                  ; D57B  F0 15
    lda $41                     ; D57D  A5 41
    bne L_D58F                  ; D57F  D0 0E
    lda $0334,x                 ; D581  BD 34 03
    ldy #$00                    ; D584  A0 00
    cmp D_D668,y                ; D586  D9 68 D6
    bcc L_D592                  ; D589  90 07
    dec $0334,x                 ; D58B  DE 34 03
    rts                         ; D58E  60


L_D58F:
    inc $031A,x                 ; D58F  FE 1A 03

L_D592:
    rts                         ; D592  60


L_D593:
    jsr L_D577                  ; D593  20 77 D5
    jsr L_D773                  ; D596  20 73 D7
    lda D_D5E8,y                ; D599  B9 E8 D5
    sta $BC,x                   ; D59C  95 BC
    lda $9E,x                   ; D59E  B5 9E
    beq L_D5A9                  ; D5A0  F0 07
    dec $9E,x                   ; D5A2  D6 9E
    bne L_D5E5                  ; D5A4  D0 3F
    jmp L_D9FA                  ; D5A6  4C FA D9


L_D5A9:
    lda D_D5EB,y                ; D5A9  B9 EB D5
    sta $98,x                   ; D5AC  95 98
    lda $C2,x                   ; D5AE  B5 C2
    cmp #$05                    ; D5B0  C9 05
    bcc L_D5C1                  ; D5B2  90 0D
    lda $B4,x                   ; D5B4  B5 B4
    ora #$02                    ; D5B6  09 02
    sta $B4,x                   ; D5B8  95 B4
    lda #$00                    ; D5BA  A9 00
    sec                         ; D5BC  38
    sbc $98,x                   ; D5BD  F5 98
    sta $98,x                   ; D5BF  95 98

L_D5C1:
    lda $C6,x                   ; D5C1  B5 C6
    bmi L_D5DF                  ; D5C3  30 1A
    cmp #$02                    ; D5C5  C9 02
    bcc L_D5DF                  ; D5C7  90 16
    lda $BA,x                   ; D5C9  B5 BA
    cmp #$01                    ; D5CB  C9 01
    beq L_D5DB                  ; D5CD  F0 0C
    jsr L_D9A3                  ; D5CF  20 A3 D9
    beq L_D5DF                  ; D5D2  F0 0B
    cmp #$02                    ; D5D4  C9 02
    beq L_D5DF                  ; D5D6  F0 07
    jsr L_D8EF                  ; D5D8  20 EF D8

L_D5DB:
    lda #$40                    ; D5DB  A9 40
    sta $9E,x                   ; D5DD  95 9E

L_D5DF:
    jsr L_D9C8                  ; D5DF  20 C8 D9
    jsr L_D5FB                  ; D5E2  20 FB D5

L_D5E5:
    jmp L_C207                  ; D5E5  4C 07 C2

D_D5E8:
    .byte $04,$04,$06
D_D5EB:
    .byte $FF,$00,$00

L_D5EE:
    lda $D0,x                   ; D5EE  B5 D0
    bne L_D5F8                  ; D5F0  D0 06
    lda #$00                    ; D5F2  A9 00
    sta $98,x                   ; D5F4  95 98
    sta $96,x                   ; D5F6  95 96

L_D5F8:
    jsr L_D66B                  ; D5F8  20 6B D6

L_D5FB:
    lda $98,x                   ; D5FB  B5 98
    clc                         ; D5FD  18
    adc $D4,x                   ; D5FE  75 D4
    sta $98,x                   ; D600  95 98
    lda $B2,x                   ; D602  B5 B2
    bmi L_D664                  ; D604  30 5E
    lda $98,x                   ; D606  B5 98
    ora $96,x                   ; D608  15 96
    beq L_D664                  ; D60A  F0 58
    lda $98,x                   ; D60C  B5 98
    bmi L_D63F                  ; D60E  30 2F
    lda $3B                     ; D610  A5 3B
    bmi L_D631                  ; D612  30 1D
    lda #$08                    ; D614  A9 08
    jsr L_DB28                  ; D616  20 28 DB
    bcs L_D664                  ; D619  B0 49
    jsr L_D773                  ; D61B  20 73 D7
    lda $0334,x                 ; D61E  BD 34 03
    cmp D_D665,y                ; D621  D9 65 D6
    bcs L_D664                  ; D624  B0 3E
    ldy $84                     ; D626  A4 84
    beq L_D631                  ; D628  F0 07
    ldy $30                     ; D62A  A4 30
    cmp D_D637,y                ; D62C  D9 37 D6
    bcs L_D664                  ; D62F  B0 33

L_D631:
    jsr L_DA0B                  ; D631  20 0B DA
    jmp L_D655                  ; D634  4C 55 D6

D_D637:
    .byte $90,$FF,$FF,$FF,$A0,$D0,$B0,$B0

L_D63F:
    lda #$F8                    ; D63F  A9 F8
    jsr L_DB28                  ; D641  20 28 DB
    bcs L_D664                  ; D644  B0 1E
    lda $3B                     ; D646  A5 3B
    bmi L_D655                  ; D648  30 0B
    jsr L_D773                  ; D64A  20 73 D7
    lda $0334,x                 ; D64D  BD 34 03
    cmp D_D668,y                ; D650  D9 68 D6
    bcc L_D664                  ; D653  90 0F

L_D655:
    lda $92,x                   ; D655  B5 92
    clc                         ; D657  18
    adc $96,x                   ; D658  75 96
    sta $92,x                   ; D65A  95 92
    lda $0334,x                 ; D65C  BD 34 03
    adc $98,x                   ; D65F  75 98
    sta $0334,x                 ; D661  9D 34 03

L_D664:
    rts                         ; D664  60

D_D665:
    .byte $E6,$E0,$D0
D_D668:
    .byte $1A,$20,$30

L_D66B:
    lda #$03                    ; D66B  A9 03
    sta $BC,x                   ; D66D  95 BC
    lda $CA,x                   ; D66F  B5 CA
    beq L_D67F                  ; D671  F0 0C
    lda #$00                    ; D673  A9 00
    sta $CA,x                   ; D675  95 CA
    sta $D0,x                   ; D677  95 D0
    jsr L_D858                  ; D679  20 58 D8
    jmp L_D6D3                  ; D67C  4C D3 D6


L_D67F:
    lda $C8,x                   ; D67F  B5 C8
    beq L_D686                  ; D681  F0 03
    jmp L_D830                  ; D683  4C 30 D8


L_D686:
    lda $A4,x                   ; D686  B5 A4
    beq L_D68D                  ; D688  F0 03
    jmp L_D77F                  ; D68A  4C 7F D7


L_D68D:
    lda $A0,x                   ; D68D  B5 A0
    beq L_D694                  ; D68F  F0 03
    jmp L_D7AF                  ; D691  4C AF D7


L_D694:
    lda $D0,x                   ; D694  B5 D0
    beq L_D69B                  ; D696  F0 03
    jmp L_D83F                  ; D698  4C 3F D8


L_D69B:
    lda $B2,x                   ; D69B  B5 B2
    bne L_D6F8                  ; D69D  D0 59
    lda $F5,x                   ; D69F  B5 F5
    and #$80                    ; D6A1  29 80
    beq L_D6F8                  ; D6A3  F0 53
    lda $F1,x                   ; D6A5  B5 F1
    and #$07                    ; D6A7  29 07
    cmp #$04                    ; D6A9  C9 04
    bne L_D6D3                  ; D6AB  D0 26
    lda #$02                    ; D6AD  A9 02
    sta $BC,x                   ; D6AF  95 BC
    jsr L_DA91                  ; D6B1  20 91 DA
    bcs L_D6D2                  ; D6B4  B0 1C
    lda #$81                    ; D6B6  A9 81
    bne L_D6C4                  ; D6B8  D0 0A

L_D6BA:
    lda $C2,x                   ; D6BA  B5 C2
    cmp #$05                    ; D6BC  C9 05
    lda #$21                    ; D6BE  A9 21
    bcc L_D6C4                  ; D6C0  90 02
    lda #$41                    ; D6C2  A9 41

L_D6C4:
    sta $A4,x                   ; D6C4  95 A4
    lda $031A,x                 ; D6C6  BD 1A 03
    clc                         ; D6C9  18
    adc #$14                    ; D6CA  69 14
    bcc L_D6D0                  ; D6CC  90 02
    lda #$FF                    ; D6CE  A9 FF

L_D6D0:
    sta $B8,x                   ; D6D0  95 B8

L_D6D2:
    rts                         ; D6D2  60


L_D6D3:
    lda $C2,x                   ; D6D3  B5 C2
    cmp #$05                    ; D6D5  C9 05
    lda #$91                    ; D6D7  A9 91
    bcs L_D6DD                  ; D6D9  B0 02
    lda #$11                    ; D6DB  A9 11

L_D6DD:
    sta $A0,x                   ; D6DD  95 A0
    lda #$00                    ; D6DF  A9 00
    sta $9E,x                   ; D6E1  95 9E
    sta $A6,x                   ; D6E3  95 A6
    lda $40                     ; D6E5  A5 40
    lsr a                       ; D6E7  4A
    lda #$FB                    ; D6E8  A9 FB
    ldy #$F0                    ; D6EA  A0 F0
    bcc L_D6F2                  ; D6EC  90 04
    lda #$FC                    ; D6EE  A9 FC
    ldy #$90                    ; D6F0  A0 90

L_D6F2:
    sta $C6,x                   ; D6F2  95 C6
    tya                         ; D6F4  98
    sta $C4,x                   ; D6F5  95 C4
    rts                         ; D6F7  60


L_D6F8:
    lda $F1,x                   ; D6F8  B5 F1
    lsr a                       ; D6FA  4A
    bcs L_D75C                  ; D6FB  B0 5F
    lsr a                       ; D6FD  4A
    bcs L_D760                  ; D6FE  B0 60
    ldy #$02                    ; D700  A0 02
    lsr a                       ; D702  4A
    bcs L_D70A                  ; D703  B0 05
    dey                         ; D705  88
    lsr a                       ; D706  4A
    bcs L_D70E                  ; D707  B0 05
    dey                         ; D709  88

L_D70A:
    tya                         ; D70A  98

L_D70B:
    sta $BC,x                   ; D70B  95 BC
    rts                         ; D70D  60


L_D70E:
    lda $40                     ; D70E  A5 40
    lsr a                       ; D710  4A
    bcc L_D70A                  ; D711  90 F7
    jsr L_D70A                  ; D713  20 0A D7
    lda $37                     ; D716  A5 37
    bne L_D723                  ; D718  D0 09
    lda #$30                    ; D71A  A9 30
    sta $C8,x                   ; D71C  95 C8
    lda #$1C                    ; D71E  A9 1C
    jmp L_C16B                  ; D720  4C 6B C1


L_D723:
    stx $10                     ; D723  86 10
    txa                         ; D725  8A
    eor #$01                    ; D726  49 01
    tax                         ; D728  AA
    lda $38,x                   ; D729  B5 38
    bne L_D737                  ; D72B  D0 0A
    lda $90,x                   ; D72D  B5 90
    cmp #$01                    ; D72F  C9 01
    bne L_D756                  ; D731  D0 23
    lda $A0,x                   ; D733  B5 A0
    bne L_D756                  ; D735  D0 1F

L_D737:
    ldx #$01                    ; D737  A2 01

L_D739:
    lda #$05                    ; D739  A9 05
    sta $BC,x                   ; D73B  95 BC
    lda $D0,x                   ; D73D  B5 D0
    bne L_D750                  ; D73F  D0 0F
    lda #$01                    ; D741  A9 01
    sta $73                     ; D743  85 73
    sta $D0,x                   ; D745  95 D0
    lda #$00                    ; D747  A9 00
    sta $A6,x                   ; D749  95 A6
    sta $9E,x                   ; D74B  95 9E
    jsr L_D89B                  ; D74D  20 9B D8

L_D750:
    dex                         ; D750  CA
    bpl L_D739                  ; D751  10 E6
    ldx $10                     ; D753  A6 10
    rts                         ; D755  60


L_D756:
    ldx $10                     ; D756  A6 10
    lda #$00                    ; D758  A9 00
    beq L_D70B                  ; D75A  F0 AF

L_D75C:
    lda #$01                    ; D75C  A9 01
    bne L_D762                  ; D75E  D0 02

L_D760:
    lda #$FF                    ; D760  A9 FF

L_D762:
    ldy $B2,x                   ; D762  B4 B2
    beq L_D770                  ; D764  F0 0A
    sta $08                     ; D766  85 08
    lda $F1,x                   ; D768  B5 F1
    and #$04                    ; D76A  29 04
    bne L_D772                  ; D76C  D0 04
    lda $08                     ; D76E  A5 08

L_D770:
    sta $98,x                   ; D770  95 98

L_D772:
    rts                         ; D772  60


L_D773:
    ldy #$00                    ; D773  A0 00
    lda $40                     ; D775  A5 40
    beq L_D77E                  ; D777  F0 05
    iny                         ; D779  C8
    asl a                       ; D77A  0A
    bcs L_D77E                  ; D77B  B0 01
    iny                         ; D77D  C8

L_D77E:
    rts                         ; D77E  60


L_D77F:
    lda $031A,x                 ; D77F  BD 1A 03
    cmp $B8,x                   ; D782  D5 B8
    bcc L_D791                  ; D784  90 0B
    jsr L_D9A3                  ; D786  20 A3 D9
    beq L_D791                  ; D789  F0 06
    jsr L_D8EF                  ; D78B  20 EF D8
    jmp L_D867                  ; D78E  4C 67 D8


L_D791:
    jsr L_D9C8                  ; D791  20 C8 D9
    lda $031A,x                 ; D794  BD 1A 03
    cmp $B8,x                   ; D797  D5 B8
    bcc L_D7AA                  ; D799  90 0F
    jsr L_D820                  ; D79B  20 20 D8
    beq L_D7AA                  ; D79E  F0 0A
    sta $08                     ; D7A0  85 08
    lda $A4,x                   ; D7A2  B5 A4
    and #$9F                    ; D7A4  29 9F
    ora $08                     ; D7A6  05 08
    sta $A4,x                   ; D7A8  95 A4

L_D7AA:
    lda $A4,x                   ; D7AA  B5 A4
    jmp L_D814                  ; D7AC  4C 14 D8


L_D7AF:
    lda $C6,x                   ; D7AF  B5 C6
    bmi L_D7DB                  ; D7B1  30 28
    ldy $40                     ; D7B3  A4 40
    bne L_D7CD                  ; D7B5  D0 16

L_D7B7:
    cmp #$01                    ; D7B7  C9 01
    bcc L_D7F4                  ; D7B9  90 39
    lda $C6,x                   ; D7BB  B5 C6
    cmp #$04                    ; D7BD  C9 04
    bcs L_D7CD                  ; D7BF  B0 0C
    lda $031A,x                 ; D7C1  BD 1A 03
    clc                         ; D7C4  18
    adc $FC                     ; D7C5  65 FC
    and #$0F                    ; D7C7  29 0F
    cmp #$08                    ; D7C9  C9 08
    bcs L_D7F4                  ; D7CB  B0 27

L_D7CD:
    jsr L_D9A3                  ; D7CD  20 A3 D9
    beq L_D7F4                  ; D7D0  F0 22
    jsr L_D8EF                  ; D7D2  20 EF D8
    jsr L_D803                  ; D7D5  20 03 D8
    jmp L_D867                  ; D7D8  4C 67 D8


L_D7DB:
    lda $3B                     ; D7DB  A5 3B
    bmi L_D7F4                  ; D7DD  30 15
    lda $031A,x                 ; D7DF  BD 1A 03
    clc                         ; D7E2  18
    adc #$F6                    ; D7E3  69 F6
    tay                         ; D7E5  A8
    lda $0334,x                 ; D7E6  BD 34 03
    jsr L_E0BB                  ; D7E9  20 BB E0
    bpl L_D7F4                  ; D7EC  10 06
    lda #$00                    ; D7EE  A9 00
    sta $C6,x                   ; D7F0  95 C6
    sta $C4,x                   ; D7F2  95 C4

L_D7F4:
    jsr L_D9EC                  ; D7F4  20 EC D9
    lda $41                     ; D7F7  A5 41
    beq L_D800                  ; D7F9  F0 05
    jsr L_DA0B                  ; D7FB  20 0B DA
    bcs L_D803                  ; D7FE  B0 03

L_D800:
    jsr L_D9CB                  ; D800  20 CB D9

L_D803:
    jsr L_D820                  ; D803  20 20 D8
    beq L_D812                  ; D806  F0 0A
    sta $08                     ; D808  85 08
    lda $A0,x                   ; D80A  B5 A0
    and #$9F                    ; D80C  29 9F
    ora $08                     ; D80E  05 08
    sta $A0,x                   ; D810  95 A0

L_D812:
    lda $A0,x                   ; D812  B5 A0

L_D814:
    asl a                       ; D814  0A
    bpl L_D81A                  ; D815  10 03
    jmp L_D760                  ; D817  4C 60 D7


L_D81A:
    asl a                       ; D81A  0A
    bpl L_D82F                  ; D81B  10 12
    jmp L_D75C                  ; D81D  4C 5C D7


L_D820:
    ldy #$00                    ; D820  A0 00
    lda $F1,x                   ; D822  B5 F1
    lsr a                       ; D824  4A
    bcc L_D829                  ; D825  90 02
    ldy #$20                    ; D827  A0 20

L_D829:
    lsr a                       ; D829  4A
    bcc L_D82E                  ; D82A  90 02
    ldy #$40                    ; D82C  A0 40

L_D82E:
    tya                         ; D82E  98

L_D82F:
    rts                         ; D82F  60


L_D830:
    lda #$01                    ; D830  A9 01
    sta $BC,x                   ; D832  95 BC
    dec $C8,x                   ; D834  D6 C8
    lda $37                     ; D836  A5 37
    beq L_D83E                  ; D838  F0 04
    lda #$00                    ; D83A  A9 00
    sta $C8,x                   ; D83C  95 C8

L_D83E:
    rts                         ; D83E  60


L_D83F:
    lda #$05                    ; D83F  A9 05
    sta $BC,x                   ; D841  95 BC
    lda $94,x                   ; D843  B5 94
    clc                         ; D845  18
    adc $9A,x                   ; D846  75 9A
    sta $94,x                   ; D848  95 94
    lda $031A,x                 ; D84A  BD 1A 03
    adc $9C,x                   ; D84D  75 9C
    sta $031A,x                 ; D84F  9D 1A 03
    lda $73                     ; D852  A5 73
    cmp #$02                    ; D854  C9 02
    bcc L_D866                  ; D856  90 0E

L_D858:
    lda #$00                    ; D858  A9 00
    sta $D0,x                   ; D85A  95 D0
    lda $A8,x                   ; D85C  B5 A8
    sta $031A,x                 ; D85E  9D 1A 03
    lda $BE,x                   ; D861  B5 BE
    sta $0334,x                 ; D863  9D 34 03

L_D866:
    rts                         ; D866  60


L_D867:
    lda $A0,x                   ; D867  B5 A0
    ora $A4,x                   ; D869  15 A4
    beq L_D87A                  ; D86B  F0 0D
    lda #$00                    ; D86D  A9 00
    sta $A6,x                   ; D86F  95 A6
    sta $9E,x                   ; D871  95 9E
    sta $B8,x                   ; D873  95 B8
    lda #$03                    ; D875  A9 03
    jsr L_C16B                  ; D877  20 6B C1

L_D87A:
    lda $C2,x                   ; D87A  B5 C2
    cmp #$05                    ; D87C  C9 05
    lda $D8,x                   ; D87E  B5 D8
    and #$3F                    ; D880  29 3F
    bcc L_D886                  ; D882  90 02
    ora #$40                    ; D884  09 40

L_D886:
    sta $D8,x                   ; D886  95 D8

L_D888:
    lda #$00                    ; D888  A9 00
    sta $A0,x                   ; D88A  95 A0
    sta $A4,x                   ; D88C  95 A4
    sta $BC,x                   ; D88E  95 BC
    lda #$00                    ; D890  A9 00
    sta $C4,x                   ; D892  95 C4
    sta $C6,x                   ; D894  95 C6
    sta $9A,x                   ; D896  95 9A
    sta $9C,x                   ; D898  95 9C
    rts                         ; D89A  60


L_D89B:
    lda #$00                    ; D89B  A9 00
    sta $12                     ; D89D  85 12
    lda #$58                    ; D89F  A9 58
    jsr L_D8CD                  ; D8A1  20 CD D8
    lda $0F                     ; D8A4  A5 0F
    sta $9C,x                   ; D8A6  95 9C
    lda $0E                     ; D8A8  A5 0E
    sta $9A,x                   ; D8AA  95 9A
    lda $031A,x                 ; D8AC  BD 1A 03
    sta $A8,x                   ; D8AF  95 A8
    lda $0334,x                 ; D8B1  BD 34 03
    sta $BE,x                   ; D8B4  95 BE
    sec                         ; D8B6  38
    sbc #$80                    ; D8B7  E9 80
    sta $12                     ; D8B9  85 12
    bcs L_D8C1                  ; D8BB  B0 04
    eor #$FF                    ; D8BD  49 FF
    adc #$01                    ; D8BF  69 01

L_D8C1:
    jsr L_D8CD                  ; D8C1  20 CD D8
    lda $0F                     ; D8C4  A5 0F
    sta $98,x                   ; D8C6  95 98
    lda $0E                     ; D8C8  A5 0E
    sta $96,x                   ; D8CA  95 96
    rts                         ; D8CC  60


L_D8CD:
    sta $0F                     ; D8CD  85 0F
    lda #$00                    ; D8CF  A9 00
    sta $0E                     ; D8D1  85 0E
    ldy #$07                    ; D8D3  A0 07

L_D8D5:
    lsr $0F                     ; D8D5  46 0F
    ror $0E                     ; D8D7  66 0E
    dey                         ; D8D9  88
    bne L_D8D5                  ; D8DA  D0 F9
    lda $12                     ; D8DC  A5 12
    bpl L_D8E1                  ; D8DE  10 01
    rts                         ; D8E0  60


L_D8E1:
    lda #$00                    ; D8E1  A9 00
    sec                         ; D8E3  38
    sbc $0E                     ; D8E4  E5 0E
    sta $0E                     ; D8E6  85 0E
    lda #$00                    ; D8E8  A9 00
    sbc $0F                     ; D8EA  E5 0F
    sta $0F                     ; D8EC  85 0F
    rts                         ; D8EE  60


L_D8EF:
    jsr L_D773                  ; D8EF  20 73 D7
    lda D_D90F,y                ; D8F2  B9 0F D9
    bne L_D90B                  ; D8F5  D0 14
    lda $FC                     ; D8F7  A5 FC
    and #$0F                    ; D8F9  29 0F
    ora #$F0                    ; D8FB  09 F0
    sta $00                     ; D8FD  85 00
    clc                         ; D8FF  18
    adc $031A,x                 ; D900  7D 1A 03
    and #$F0                    ; D903  29 F0
    sec                         ; D905  38
    sbc $00                     ; D906  E5 00
    clc                         ; D908  18
    adc #$04                    ; D909  69 04

L_D90B:
    sta $031A,x                 ; D90B  9D 1A 03
    rts                         ; D90E  60

D_D90F:
    .byte $00,$C9,$A8

L_D912:
    ldy #$20                    ; D912  A0 20
    lda $A0                     ; D914  A5 A0
    beq L_D91A                  ; D916  F0 02
    ldy #$30                    ; D918  A0 30

L_D91A:
    lda $08                     ; D91A  A5 08
    cmp #$03                    ; D91C  C9 03
    beq L_D92A                  ; D91E  F0 0A
    ldy #$00                    ; D920  A0 00
    lda $C0,x                   ; D922  B5 C0
    cmp #$05                    ; D924  C9 05
    bcc L_D92A                  ; D926  90 02
    ldy #$10                    ; D928  A0 10

L_D92A:
    sty $08                     ; D92A  84 08
    lda $F1,x                   ; D92C  B5 F1
    and #$0F                    ; D92E  29 0F
    clc                         ; D930  18
    adc $08                     ; D931  65 08
    tay                         ; D933  A8
    lda D_D93A,y                ; D934  B9 3A D9
    sta $C2,x                   ; D937  95 C2
    rts                         ; D939  60

D_D93A:
    .byte $02,$02,$07,$02,$04,$03,$06,$02,$00,$01,$08,$02,$07,$02,$07,$02
    .byte $07,$02,$07,$02,$05,$03,$06,$02,$09,$01,$08,$02,$07,$02,$07,$02
    .byte $00,$02,$07,$00,$00,$02,$07,$02,$00,$01,$08,$02,$07,$02,$07,$02
    .byte $00,$02,$07,$00,$0A,$03,$06,$02,$00,$01,$08,$02,$07,$02,$07,$02

L_D97A:
    lda $B6,x                   ; D97A  B5 B6
    bne L_D996                  ; D97C  D0 18
    lda $B2,x                   ; D97E  B5 B2
    ora $A0,x                   ; D980  15 A0
    ora $A4,x                   ; D982  15 A4
    ora $D0,x                   ; D984  15 D0
    bne L_D99A                  ; D986  D0 12
    lda $DA,x                   ; D988  B5 DA
    lsr a                       ; D98A  4A
    bcs L_D996                  ; D98B  B0 09
    jsr L_D9A3                  ; D98D  20 A3 D9
    beq L_D9A0                  ; D990  F0 0E
    cmp #$02                    ; D992  C9 02
    beq L_D99B                  ; D994  F0 05

L_D996:
    lda #$00                    ; D996  A9 00
    sta $A4,x                   ; D998  95 A4

L_D99A:
    rts                         ; D99A  60


L_D99B:
    lda #$01                    ; D99B  A9 01
    sta $B2,x                   ; D99D  95 B2
    rts                         ; D99F  60


L_D9A0:
    jmp L_D6BA                  ; D9A0  4C BA D6


L_D9A3:
    lda $40                     ; D9A3  A5 40
    bmi L_D9BC                  ; D9A5  30 15
    bne L_D9B8                  ; D9A7  D0 0F
    lda $031A,x                 ; D9A9  BD 1A 03
    clc                         ; D9AC  18
    adc #$10                    ; D9AD  69 10
    bcs L_D9C5                  ; D9AF  B0 14
    tay                         ; D9B1  A8
    lda $0334,x                 ; D9B2  BD 34 03
    jmp L_E0BB                  ; D9B5  4C BB E0


L_D9B8:
    lda #$A0                    ; D9B8  A9 A0
    bne L_D9BE                  ; D9BA  D0 02

L_D9BC:
    lda #$C8                    ; D9BC  A9 C8

L_D9BE:
    cmp $031A,x                 ; D9BE  DD 1A 03
    lda #$01                    ; D9C1  A9 01
    bcc L_D9C7                  ; D9C3  90 02

L_D9C5:
    lda #$00                    ; D9C5  A9 00

L_D9C7:
    rts                         ; D9C7  60


L_D9C8:
    jsr L_D9EC                  ; D9C8  20 EC D9

L_D9CB:
    lda $C6,x                   ; D9CB  B5 C6
    asl a                       ; D9CD  0A
    lda #$00                    ; D9CE  A9 00
    bcc L_D9D4                  ; D9D0  90 02
    lda #$FF                    ; D9D2  A9 FF

L_D9D4:
    sta $08                     ; D9D4  85 08
    lda $94,x                   ; D9D6  B5 94
    clc                         ; D9D8  18
    adc $C4,x                   ; D9D9  75 C4
    sta $94,x                   ; D9DB  95 94
    lda $031A,x                 ; D9DD  BD 1A 03
    adc $C6,x                   ; D9E0  75 C6
    sta $031A,x                 ; D9E2  9D 1A 03
    lda $BA,x                   ; D9E5  B5 BA
    adc $08                     ; D9E7  65 08
    sta $BA,x                   ; D9E9  95 BA
    rts                         ; D9EB  60


L_D9EC:
    clc                         ; D9EC  18
    lda $C4,x                   ; D9ED  B5 C4
    adc #$23                    ; D9EF  69 23
    sta $C4,x                   ; D9F1  95 C4
    lda $C6,x                   ; D9F3  B5 C6
    adc #$00                    ; D9F5  69 00
    sta $C6,x                   ; D9F7  95 C6
    rts                         ; D9F9  60


L_D9FA:
    jsr L_DAD1                  ; D9FA  20 D1 DA
    sta $90,x                   ; D9FD  95 90
    lda $32,x                   ; D9FF  B5 32
    beq L_DA06                  ; DA01  F0 03
    dec $32,x                   ; DA03  D6 32
    rts                         ; DA05  60


L_DA06:
    lda #$01                    ; DA06  A9 01
    sta $38,x                   ; DA08  95 38
    rts                         ; DA0A  60


L_DA0B:
    lda $40                     ; DA0B  A5 40
    ora $75                     ; DA0D  05 75
    ora $76                     ; DA0F  05 76
    bne L_DA5E                  ; DA11  D0 4B
    lda $90,x                   ; DA13  B5 90
    cmp #$01                    ; DA15  C9 01
    bne L_DA5E                  ; DA17  D0 45
    lda $41                     ; DA19  A5 41
    bne L_DA63                  ; DA1B  D0 46
    lda $58                     ; DA1D  A5 58
    bmi L_DA5E                  ; DA1F  30 3D
    ldy $DF                     ; DA21  A4 DF
    lda $0334,x                 ; DA23  BD 34 03
    cmp D_DA60,y                ; DA26  D9 60 DA
    bcc L_DA5E                  ; DA29  90 33
    cpy #$02                    ; DA2B  C0 02
    bne L_DA3A                  ; DA2D  D0 0B
    txa                         ; DA2F  8A
    eor #$01                    ; DA30  49 01
    tay                         ; DA32  A8
    lda $0334,y                 ; DA33  B9 34 03
    cmp #$21                    ; DA36  C9 21
    bcc L_DA58                  ; DA38  90 1E

L_DA3A:
    jsr L_E136                  ; DA3A  20 36 E1
    beq L_DA5E                  ; DA3D  F0 1F
    lda $96,x                   ; DA3F  B5 96
    clc                         ; DA41  18
    adc $92,x                   ; DA42  75 92
    sta $92,x                   ; DA44  95 92
    lda $98,x                   ; DA46  B5 98
    adc #$00                    ; DA48  69 00
    sta $68                     ; DA4A  85 68
    lda #$01                    ; DA4C  A9 01
    sta $A2,x                   ; DA4E  95 A2
    lda #$00                    ; DA50  A9 00
    sta $96,x                   ; DA52  95 96
    sta $98,x                   ; DA54  95 98
    sec                         ; DA56  38
    rts                         ; DA57  60


L_DA58:
    lda #$00                    ; DA58  A9 00
    sta $96,x                   ; DA5A  95 96
    sta $98,x                   ; DA5C  95 98

L_DA5E:
    clc                         ; DA5E  18
    rts                         ; DA5F  60

D_DA60:
    .byte $80,$80,$B0

L_DA63:
    lda $031A,x                 ; DA63  BD 1A 03
    cmp #$50                    ; DA66  C9 50
    bcs L_DA8F                  ; DA68  B0 25
    lda $C6,x                   ; DA6A  B5 C6
    bpl L_DA8F                  ; DA6C  10 21
    jsr L_E136                  ; DA6E  20 36 E1
    beq L_DA8F                  ; DA71  F0 1C
    lda $94,x                   ; DA73  B5 94
    clc                         ; DA75  18
    adc $C4,x                   ; DA76  75 C4
    sta $94,x                   ; DA78  95 94
    lda $031A,x                 ; DA7A  BD 1A 03
    adc $C6,x                   ; DA7D  75 C6
    sta $08                     ; DA7F  85 08
    lda $031A,x                 ; DA81  BD 1A 03
    sec                         ; DA84  38
    sbc $08                     ; DA85  E5 08
    sta $68                     ; DA87  85 68
    lda #$01                    ; DA89  A9 01
    sta $A2,x                   ; DA8B  95 A2
    sec                         ; DA8D  38
    rts                         ; DA8E  60


L_DA8F:
    clc                         ; DA8F  18
    rts                         ; DA90  60


L_DA91:
    lda $58                     ; DA91  A5 58
    cmp #$FF                    ; DA93  C9 FF
    beq L_DA9B                  ; DA95  F0 04
    lda $41                     ; DA97  A5 41
    bne L_DACD                  ; DA99  D0 32

L_DA9B:
    lda $031A,x                 ; DA9B  BD 1A 03
    clc                         ; DA9E  18
    adc #$10                    ; DA9F  69 10

L_DAA1:
    tay                         ; DAA1  A8
    lsr a                       ; DAA2  4A
    lsr a                       ; DAA3  4A
    lsr a                       ; DAA4  4A
    lsr a                       ; DAA5  4A
    sta $08                     ; DAA6  85 08
    lda $0334,x                 ; DAA8  BD 34 03
    jsr L_E087                  ; DAAB  20 87 E0
    bmi L_DACF                  ; DAAE  30 1F

L_DAB0:
    inc $08                     ; DAB0  E6 08
    lda $08                     ; DAB2  A5 08
    cmp #$0E                    ; DAB4  C9 0E
    bcs L_DACE                  ; DAB6  B0 16
    lda $13                     ; DAB8  A5 13
    and #$C0                    ; DABA  29 C0
    sta $17                     ; DABC  85 17
    lda $13                     ; DABE  A5 13
    clc                         ; DAC0  18
    adc #$04                    ; DAC1  69 04
    and #$3F                    ; DAC3  29 3F
    ora $17                     ; DAC5  05 17
    tay                         ; DAC7  A8
    jsr L_E0B5                  ; DAC8  20 B5 E0
    beq L_DAB0                  ; DACB  F0 E3

L_DACD:
    clc                         ; DACD  18

L_DACE:
    rts                         ; DACE  60


L_DACF:
    sec                         ; DACF  38
    rts                         ; DAD0  60


L_DAD1:
    lda #$00                    ; DAD1  A9 00
    sta $AA,x                   ; DAD3  95 AA

L_DAD5:
    lda #$00                    ; DAD5  A9 00
    sta $0300,x                 ; DAD7  9D 00 03
    sta $031A,x                 ; DADA  9D 1A 03
    sta $0334,x                 ; DADD  9D 34 03
    sta $034E,x                 ; DAE0  9D 4E 03
    sta $92,x                   ; DAE3  95 92
    sta $94,x                   ; DAE5  95 94
    sta $96,x                   ; DAE7  95 96
    sta $98,x                   ; DAE9  95 98
    sta $9A,x                   ; DAEB  95 9A
    sta $9C,x                   ; DAED  95 9C
    sta $9E,x                   ; DAEF  95 9E
    sta $A0,x                   ; DAF1  95 A0
    sta $A2,x                   ; DAF3  95 A2
    sta $A4,x                   ; DAF5  95 A4
    sta $A6,x                   ; DAF7  95 A6
    sta $A8,x                   ; DAF9  95 A8
    sta $AC,x                   ; DAFB  95 AC
    sta $AE,x                   ; DAFD  95 AE
    sta $B0,x                   ; DAFF  95 B0
    sta $B2,x                   ; DB01  95 B2
    sta $B4,x                   ; DB03  95 B4
    sta $B6,x                   ; DB05  95 B6
    sta $B8,x                   ; DB07  95 B8
    sta $BA,x                   ; DB09  95 BA
    sta $BC,x                   ; DB0B  95 BC
    sta $BE,x                   ; DB0D  95 BE
    sta $C0,x                   ; DB0F  95 C0
    sta $C2,x                   ; DB11  95 C2
    sta $C4,x                   ; DB13  95 C4
    sta $C6,x                   ; DB15  95 C6
    sta $C8,x                   ; DB17  95 C8
    sta $CA,x                   ; DB19  95 CA
    sta $CC,x                   ; DB1B  95 CC
    sta $CE,x                   ; DB1D  95 CE
    sta $D0,x                   ; DB1F  95 D0
    sta $D6,x                   ; DB21  95 D6
    sta $D8,x                   ; DB23  95 D8
    sta $DA,x                   ; DB25  95 DA
    rts                         ; DB27  60


L_DB28:
    clc                         ; DB28  18
    adc $0334,x                 ; DB29  7D 34 03
    sta $0A                     ; DB2C  85 0A
    ldy #$0B                    ; DB2E  A0 0B
    lda $D6,x                   ; DB30  B5 D6
    cmp #$17                    ; DB32  C9 17
    bne L_DB38                  ; DB34  D0 02
    ldy #$00                    ; DB36  A0 00

L_DB38:
    sty $08                     ; DB38  84 08
    lda $BA,x                   ; DB3A  B5 BA
    bne L_DB4A                  ; DB3C  D0 0C
    lda $031A,x                 ; DB3E  BD 1A 03
    sec                         ; DB41  38
    sbc $08                     ; DB42  E5 08
    bcc L_DB4A                  ; DB44  90 04
    cmp #$10                    ; DB46  C9 10
    bcs L_DB4C                  ; DB48  B0 02

L_DB4A:
    lda #$0A                    ; DB4A  A9 0A

L_DB4C:
    sta $09                     ; DB4C  85 09
    jsr L_D9A3                  ; DB4E  20 A3 D9
    bne L_DB5A                  ; DB51  D0 07
    lda $A0,x                   ; DB53  B5 A0
    lsr a                       ; DB55  4A
    lda #$1B                    ; DB56  A9 1B
    bcs L_DB5F                  ; DB58  B0 05

L_DB5A:
    lda #$0A                    ; DB5A  A9 0A
    clc                         ; DB5C  18
    adc $08                     ; DB5D  65 08

L_DB5F:
    sta $08                     ; DB5F  85 08
    lda $09                     ; DB61  A5 09
    clc                         ; DB63  18
    adc $FC                     ; DB64  65 FC
    and #$0F                    ; DB66  29 0F
    sta $0B                     ; DB68  85 0B
    lda #$10                    ; DB6A  A9 10
    sec                         ; DB6C  38
    sbc $0B                     ; DB6D  E5 0B
    sta $0B                     ; DB6F  85 0B
    lda $0A                     ; DB71  A5 0A
    ldy $09                     ; DB73  A4 09
    jsr L_E087                  ; DB75  20 87 E0
    bmi L_DB99                  ; DB78  30 1F

L_DB7A:
    lda $0B                     ; DB7A  A5 0B
    cmp $08                     ; DB7C  C5 08
    bcs L_DB9B                  ; DB7E  B0 1B
    adc #$10                    ; DB80  69 10
    sta $0B                     ; DB82  85 0B
    lda $13                     ; DB84  A5 13
    and #$C0                    ; DB86  29 C0
    sta $17                     ; DB88  85 17
    lda $13                     ; DB8A  A5 13
    clc                         ; DB8C  18
    adc #$04                    ; DB8D  69 04
    and #$3F                    ; DB8F  29 3F
    ora $17                     ; DB91  05 17
    tay                         ; DB93  A8
    jsr L_E0AF                  ; DB94  20 AF E0
    bpl L_DB7A                  ; DB97  10 E1

L_DB99:
    sec                         ; DB99  38
    rts                         ; DB9A  60


L_DB9B:
    clc                         ; DB9B  18
    rts                         ; DB9C  60


L_DB9D:
    lda $41                     ; DB9D  A5 41
    bne L_DBC4                  ; DB9F  D0 23
    lda $40                     ; DBA1  A5 40
    bne L_DBDB                  ; DBA3  D0 36
    lda #$30                    ; DBA5  A9 30

L_DBA7:
    sta $61                     ; DBA7  85 61
    lda #$00                    ; DBA9  A9 00
    sta $64                     ; DBAB  85 64
    sta $65                     ; DBAD  85 65
    sta $69                     ; DBAF  85 69
    sta $60                     ; DBB1  85 60
    sta $62                     ; DBB3  85 62
    lda #$20                    ; DBB5  A9 20
    sta $63                     ; DBB7  85 63
    lda #$C0                    ; DBB9  A9 C0
    sta $66                     ; DBBB  85 66
    lda #$23                    ; DBBD  A9 23
    sta $67                     ; DBBF  85 67
    jmp L_E169                  ; DBC1  4C 69 E1


L_DBC4:
    lda #$00                    ; DBC4  A9 00
    sta $65                     ; DBC6  85 65
    sta $64                     ; DBC8  85 64
    sta $69                     ; DBCA  85 69
    lda #$1D                    ; DBCC  A9 1D
    sta $60                     ; DBCE  85 60
    lda #$A0                    ; DBD0  A9 A0
    sta $62                     ; DBD2  85 62
    lda #$23                    ; DBD4  A9 23
    sta $63                     ; DBD6  85 63
    jmp L_E169                  ; DBD8  4C 69 E1


L_DBDB:
    lda #$10                    ; DBDB  A9 10
    sta $74                     ; DBDD  85 74
    jsr L_D081                  ; DBDF  20 81 D0
    lda #$20                    ; DBE2  A9 20
    bne L_DBA7                  ; DBE4  D0 C1

L_DBE6:
    lda $41                     ; DBE6  A5 41
    bne L_DC1A                  ; DBE8  D0 30
    lda $40                     ; DBEA  A5 40
    bne L_DC3E                  ; DBEC  D0 50
    jsr L_DE1A                  ; DBEE  20 1A DE
    jsr L_DF48                  ; DBF1  20 48 DF
    inc $62                     ; DBF4  E6 62
    inc $60                     ; DBF6  E6 60
    dec $61                     ; DBF8  C6 61
    beq L_DC19                  ; DBFA  F0 1D
    lda $60                     ; DBFC  A5 60
    cmp #$20                    ; DBFE  C9 20
    bcc L_DC17                  ; DC00  90 15
    lda #$00                    ; DC02  A9 00
    sta $62                     ; DC04  85 62
    sta $60                     ; DC06  85 60
    lda #$24                    ; DC08  A9 24
    sta $63                     ; DC0A  85 63
    lda #$27                    ; DC0C  A9 27
    sta $67                     ; DC0E  85 67
    lda #$40                    ; DC10  A9 40
    sta $69                     ; DC12  85 69
    jsr L_E162                  ; DC14  20 62 E1

L_DC17:
    lda #$FF                    ; DC17  A9 FF

L_DC19:
    rts                         ; DC19  60


L_DC1A:
    jsr L_DEBE                  ; DC1A  20 BE DE
    jsr L_DF96                  ; DC1D  20 96 DF
    lda $62                     ; DC20  A5 62
    sec                         ; DC22  38
    sbc #$20                    ; DC23  E9 20
    sta $62                     ; DC25  85 62
    lda $63                     ; DC27  A5 63
    sbc #$00                    ; DC29  E9 00
    sta $63                     ; DC2B  85 63
    dec $60                     ; DC2D  C6 60
    bpl L_DC17                  ; DC2F  10 E6
    jsr L_DBC4                  ; DC31  20 C4 DB
    lda #$40                    ; DC34  A9 40
    sta $69                     ; DC36  85 69
    jsr L_E162                  ; DC38  20 62 E1
    lda #$00                    ; DC3B  A9 00
    rts                         ; DC3D  60


L_DC3E:
    jsr L_DE1A                  ; DC3E  20 1A DE
    jsr L_DF48                  ; DC41  20 48 DF
    inc $62                     ; DC44  E6 62
    inc $60                     ; DC46  E6 60
    dec $61                     ; DC48  C6 61
    rts                         ; DC4A  60


L_DC4B:
    lda $41                     ; DC4B  A5 41
    beq L_DC52                  ; DC4D  F0 03
    jmp L_DCD8                  ; DC4F  4C D8 DC


L_DC52:
    lda $40                     ; DC52  A5 40
    beq L_DC59                  ; DC54  F0 03
    jmp L_DD5F                  ; DC56  4C 5F DD


L_DC59:
    lda $76                     ; DC59  A5 76
    beq L_DC61                  ; DC5B  F0 04
    dec $76                     ; DC5D  C6 76
    bne L_DC6B                  ; DC5F  D0 0A

L_DC61:
    lda $75                     ; DC61  A5 75
    beq L_DC6F                  ; DC63  F0 0A
    dec $75                     ; DC65  C6 75
    bne L_DC6B                  ; DC67  D0 02
    inc $84                     ; DC69  E6 84

L_DC6B:
    lda #$01                    ; DC6B  A9 01
    sta $68                     ; DC6D  85 68

L_DC6F:
    lda $68                     ; DC6F  A5 68
    clc                         ; DC71  18
    adc $77                     ; DC72  65 77
    beq L_DCC9                  ; DC74  F0 53
    sta $17                     ; DC76  85 17

L_DC78:
    inc $65                     ; DC78  E6 65
    bne L_DC95                  ; DC7A  D0 19
    inc $64                     ; DC7C  E6 64
    lda $64                     ; DC7E  A5 64
    cmp $48                     ; DC80  C5 48
    bne L_DC8B                  ; DC82  D0 07
    lda #$01                    ; DC84  A9 01
    sta $71                     ; DC86  85 71
    jsr L_D064                  ; DC88  20 64 D0

L_DC8B:
    lda #$00                    ; DC8B  A9 00
    sta $82                     ; DC8D  85 82
    lda $FF                     ; DC8F  A5 FF
    eor #$01                    ; DC91  49 01
    sta $FF                     ; DC93  85 FF

L_DC95:
    lda $65                     ; DC95  A5 65
    and #$07                    ; DC97  29 07
    bne L_DCCA                  ; DC99  D0 2F
    jsr L_DE1A                  ; DC9B  20 1A DE
    inc $62                     ; DC9E  E6 62
    inc $60                     ; DCA0  E6 60
    lda $60                     ; DCA2  A5 60
    cmp #$20                    ; DCA4  C9 20
    bcc L_DCC3                  ; DCA6  90 1B
    lda $69                     ; DCA8  A5 69
    eor #$40                    ; DCAA  49 40
    sta $69                     ; DCAC  85 69
    jsr L_E15B                  ; DCAE  20 5B E1
    lda #$00                    ; DCB1  A9 00
    sta $62                     ; DCB3  85 62
    sta $60                     ; DCB5  85 60
    lda $63                     ; DCB7  A5 63
    eor #$04                    ; DCB9  49 04
    sta $63                     ; DCBB  85 63
    lda $67                     ; DCBD  A5 67
    eor #$04                    ; DCBF  49 04
    sta $67                     ; DCC1  85 67

L_DCC3:
    inc $FD                     ; DCC3  E6 FD
    dec $17                     ; DCC5  C6 17
    bne L_DC78                  ; DCC7  D0 AF

L_DCC9:
    rts                         ; DCC9  60


L_DCCA:
    lda $65                     ; DCCA  A5 65
    and #$0F                    ; DCCC  29 0F
    cmp #$03                    ; DCCE  C9 03
    bne L_DCC3                  ; DCD0  D0 F1
    jsr L_DF48                  ; DCD2  20 48 DF
    jmp L_DCC3                  ; DCD5  4C C3 DC


L_DCD8:
    lda $75                     ; DCD8  A5 75
    beq L_DCEA                  ; DCDA  F0 0E
    lda #$10                    ; DCDC  A9 10
    sta $74                     ; DCDE  85 74
    lda #$01                    ; DCE0  A9 01
    sta $68                     ; DCE2  85 68
    dec $75                     ; DCE4  C6 75
    bne L_DCEA                  ; DCE6  D0 02
    inc $84                     ; DCE8  E6 84

L_DCEA:
    lda $68                     ; DCEA  A5 68
    beq L_DD50                  ; DCEC  F0 62
    sta $17                     ; DCEE  85 17

L_DCF0:
    inc $65                     ; DCF0  E6 65
    lda $65                     ; DCF2  A5 65
    cmp #$F0                    ; DCF4  C9 F0
    bcc L_DD11                  ; DCF6  90 19
    lda #$00                    ; DCF8  A9 00
    sta $65                     ; DCFA  85 65
    sta $82                     ; DCFC  85 82
    inc $64                     ; DCFE  E6 64
    lda $64                     ; DD00  A5 64
    cmp $48                     ; DD02  C5 48
    bne L_DD11                  ; DD04  D0 0B
    lda #$01                    ; DD06  A9 01
    sta $71                     ; DD08  85 71
    lda #$80                    ; DD0A  A9 80
    sta $74                     ; DD0C  85 74
    jsr L_D064                  ; DD0E  20 64 D0

L_DD11:
    lda $65                     ; DD11  A5 65
    and #$07                    ; DD13  29 07
    bne L_DD51                  ; DD15  D0 3A
    jsr L_DEBE                  ; DD17  20 BE DE
    lda $62                     ; DD1A  A5 62
    sec                         ; DD1C  38
    sbc #$20                    ; DD1D  E9 20
    sta $62                     ; DD1F  85 62
    lda $63                     ; DD21  A5 63
    sbc #$00                    ; DD23  E9 00
    sta $63                     ; DD25  85 63
    dec $60                     ; DD27  C6 60
    bpl L_DD40                  ; DD29  10 15
    lda $69                     ; DD2B  A5 69
    eor #$40                    ; DD2D  49 40
    sta $69                     ; DD2F  85 69
    jsr L_E162                  ; DD31  20 62 E1
    lda #$1D                    ; DD34  A9 1D
    sta $60                     ; DD36  85 60
    lda #$A0                    ; DD38  A9 A0
    sta $62                     ; DD3A  85 62
    lda #$23                    ; DD3C  A9 23
    sta $63                     ; DD3E  85 63

L_DD40:
    dec $FC                     ; DD40  C6 FC
    lda $FC                     ; DD42  A5 FC
    cmp #$FF                    ; DD44  C9 FF
    bne L_DD4C                  ; DD46  D0 04
    lda #$EF                    ; DD48  A9 EF
    sta $FC                     ; DD4A  85 FC

L_DD4C:
    dec $17                     ; DD4C  C6 17
    bne L_DCF0                  ; DD4E  D0 A0

L_DD50:
    rts                         ; DD50  60


L_DD51:
    lda $65                     ; DD51  A5 65
    and #$0F                    ; DD53  29 0F
    cmp #$07                    ; DD55  C9 07
    bne L_DD40                  ; DD57  D0 E7
    jsr L_DF96                  ; DD59  20 96 DF
    jmp L_DD40                  ; DD5C  4C 40 DD


L_DD5F:
    lda $37                     ; DD5F  A5 37
    bpl L_DDC0                  ; DD61  10 5D
    lda $61                     ; DD63  A5 61
    bmi L_DDC3                  ; DD65  30 5C
    bne L_DDAD                  ; DD67  D0 44
    lda $73                     ; DD69  A5 73
    beq L_DDBF                  ; DD6B  F0 52
    lda #$00                    ; DD6D  A9 00
    sta $60                     ; DD6F  85 60
    sta $62                     ; DD71  85 62
    sta $66                     ; DD73  85 66
    lda #$20                    ; DD75  A9 20
    sta $61                     ; DD77  85 61
    lda $63                     ; DD79  A5 63
    eor #$04                    ; DD7B  49 04
    sta $63                     ; DD7D  85 63
    lda $67                     ; DD7F  A5 67
    eor #$04                    ; DD81  49 04
    sta $67                     ; DD83  85 67
    lda $64                     ; DD85  A5 64
    cmp $48                     ; DD87  C5 48
    bne L_DDA3                  ; DD89  D0 18
    lda $65                     ; DD8B  A5 65
    cmp #$03                    ; DD8D  C9 03
    bne L_DDA3                  ; DD8F  D0 12
    ldy #$00                    ; DD91  A0 00

L_DD93:
    lda D_DE14,y                ; DD93  B9 14 DE
    sta a:$0042,y               ; DD96  99 42 00
    iny                         ; DD99  C8
    cpy #$06                    ; DD9A  C0 06
    bne L_DD93                  ; DD9C  D0 F5
    lda $30                     ; DD9E  A5 30
    lsr a                       ; DDA0  4A
    bcs L_DDAA                  ; DDA1  B0 07

L_DDA3:
    lda $64                     ; DDA3  A5 64
    asl a                       ; DDA5  0A
    asl a                       ; DDA6  0A
    sec                         ; DDA7  38
    adc $65                     ; DDA8  65 65

L_DDAA:
    jsr L_E16B                  ; DDAA  20 6B E1

L_DDAD:
    jsr L_DE1A                  ; DDAD  20 1A DE

L_DDB0:
    jsr L_DF48                  ; DDB0  20 48 DF
    inc $60                     ; DDB3  E6 60
    inc $62                     ; DDB5  E6 62
    dec $61                     ; DDB7  C6 61
    bne L_DDBF                  ; DDB9  D0 04
    lda #$80                    ; DDBB  A9 80
    sta $61                     ; DDBD  85 61

L_DDBF:
    rts                         ; DDBF  60


L_DDC0:
    jmp L_CD54                  ; DDC0  4C 54 CD


L_DDC3:
    lda #$00                    ; DDC3  A9 00
    sta $61                     ; DDC5  85 61
    inc $73                     ; DDC7  E6 73
    inc $65                     ; DDC9  E6 65
    lda $65                     ; DDCB  A5 65
    cmp #$04                    ; DDCD  C9 04
    bne L_DE0D                  ; DDCF  D0 3C
    inc $CA                     ; DDD1  E6 CA
    inc $CB                     ; DDD3  E6 CB
    lda #$00                    ; DDD5  A9 00
    sta $37                     ; DDD7  85 37
    sta $65                     ; DDD9  85 65
    sta $82                     ; DDDB  85 82
    inc $64                     ; DDDD  E6 64
    lda $64                     ; DDDF  A5 64
    cmp $58                     ; DDE1  C5 58
    bne L_DE04                  ; DDE3  D0 1F
    lda #$80                    ; DDE5  A9 80
    sta $40                     ; DDE7  85 40
    jsr L_D064                  ; DDE9  20 64 D0
    jsr L_C183                  ; DDEC  20 83 C1
    lda $30                     ; DDEF  A5 30
    lsr a                       ; DDF1  4A
    ora #$08                    ; DDF2  09 08
    jsr L_C204                  ; DDF4  20 04 C2
    lda #$42                    ; DDF7  A9 42
    jsr L_C16B                  ; DDF9  20 6B C1
    lda #$B1                    ; DDFC  A9 B1
    sta $FF                     ; DDFE  85 FF
    lda #$E0                    ; DE00  A9 E0
    sta $FC                     ; DE02  85 FC

L_DE04:
    lda #$0C                    ; DE04  A9 0C
    sta $74                     ; DE06  85 74
    lda #$20                    ; DE08  A9 20
    jsr L_D081                  ; DE0A  20 81 D0

L_DE0D:
    lda $FF                     ; DE0D  A5 FF
    eor #$01                    ; DE0F  49 01
    sta $FF                     ; DE11  85 FF
    rts                         ; DE13  60

D_DE14:
    .byte $13,$90,$7A,$B5,$7A,$BD

L_DE1A:
    ldx $21                     ; DE1A  A6 21
    lda #$02                    ; DE1C  A9 02
    sta $0700,x                 ; DE1E  9D 00 07
    lda #$1C                    ; DE21  A9 1C
    inx                         ; DE23  E8
    sta $0700,x                 ; DE24  9D 00 07
    lda #$01                    ; DE27  A9 01
    inx                         ; DE29  E8
    sta $0700,x                 ; DE2A  9D 00 07
    lda $63                     ; DE2D  A5 63
    inx                         ; DE2F  E8
    sta $0700,x                 ; DE30  9D 00 07
    sta $12                     ; DE33  85 12
    lda $62                     ; DE35  A5 62
    inx                         ; DE37  E8
    sta $0700,x                 ; DE38  9D 00 07
    inx                         ; DE3B  E8
    ldy #$FF                    ; DE3C  A0 FF
    lsr a                       ; DE3E  4A
    bcs L_DE55                  ; DE3F  B0 14
    sta $13                     ; DE41  85 13
    lsr $12                     ; DE43  46 12
    lsr $12                     ; DE45  46 12
    lsr $12                     ; DE47  46 12
    ror a                       ; DE49  6A
    lsr a                       ; DE4A  4A
    sta $12                     ; DE4B  85 12
    lda $13                     ; DE4D  A5 13
    and #$03                    ; DE4F  29 03
    sta $13                     ; DE51  85 13
    ldy #$00                    ; DE53  A0 00

L_DE55:
    sty $11                     ; DE55  84 11
    lda $60                     ; DE57  A5 60
    and #$03                    ; DE59  29 03
    sta $02                     ; DE5B  85 02
    lda $60                     ; DE5D  A5 60
    lsr a                       ; DE5F  4A
    lsr a                       ; DE60  4A
    ora $69                     ; DE61  05 69
    sta $10                     ; DE63  85 10
    tay                         ; DE65  A8

L_DE66:
    lda #$00                    ; DE66  A9 00
    sta $08                     ; DE68  85 08
    lda $0600,y                 ; DE6A  B9 00 06
    asl a                       ; DE6D  0A
    asl a                       ; DE6E  0A
    rol $08                     ; DE6F  26 08
    asl a                       ; DE71  0A
    rol $08                     ; DE72  26 08
    asl a                       ; DE74  0A
    rol $08                     ; DE75  26 08
    adc $44                     ; DE77  65 44
    sta $00                     ; DE79  85 00
    lda $08                     ; DE7B  A5 08
    adc $45                     ; DE7D  65 45
    sta $01                     ; DE7F  85 01
    ldy $02                     ; DE81  A4 02
    lda ($00),y                 ; DE83  B1 00
    sta $0700,x                 ; DE85  9D 00 07
    jsr L_DFFF                  ; DE88  20 FF DF
    inx                         ; DE8B  E8
    iny                         ; DE8C  C8
    iny                         ; DE8D  C8
    iny                         ; DE8E  C8
    iny                         ; DE8F  C8
    lda ($00),y                 ; DE90  B1 00
    sta $0700,x                 ; DE92  9D 00 07
    inx                         ; DE95  E8
    iny                         ; DE96  C8
    iny                         ; DE97  C8
    iny                         ; DE98  C8
    iny                         ; DE99  C8
    lda ($00),y                 ; DE9A  B1 00
    sta $0700,x                 ; DE9C  9D 00 07
    jsr L_DFFF                  ; DE9F  20 FF DF
    inx                         ; DEA2  E8
    iny                         ; DEA3  C8
    iny                         ; DEA4  C8
    iny                         ; DEA5  C8
    iny                         ; DEA6  C8
    lda ($00),y                 ; DEA7  B1 00
    sta $0700,x                 ; DEA9  9D 00 07
    inx                         ; DEAC  E8
    lda $10                     ; DEAD  A5 10
    clc                         ; DEAF  18
    adc #$08                    ; DEB0  69 08
    sta $10                     ; DEB2  85 10
    tay                         ; DEB4  A8
    and #$3F                    ; DEB5  29 3F
    cmp #$38                    ; DEB7  C9 38
    bcc L_DE66                  ; DEB9  90 AB
    stx $21                     ; DEBB  86 21
    rts                         ; DEBD  60


L_DEBE:
    ldx $21                     ; DEBE  A6 21
    lda #$01                    ; DEC0  A9 01
    sta $0700,x                 ; DEC2  9D 00 07
    sta $0702,x                 ; DEC5  9D 02 07
    lda #$20                    ; DEC8  A9 20
    inx                         ; DECA  E8
    sta $0700,x                 ; DECB  9D 00 07
    inx                         ; DECE  E8
    lda $63                     ; DECF  A5 63
    inx                         ; DED1  E8
    sta $0700,x                 ; DED2  9D 00 07
    lda $62                     ; DED5  A5 62
    inx                         ; DED7  E8
    sta $0700,x                 ; DED8  9D 00 07
    inx                         ; DEDB  E8
    lda #$00                    ; DEDC  A9 00
    sta $11                     ; DEDE  85 11
    sta $13                     ; DEE0  85 13
    lda $60                     ; DEE2  A5 60
    and #$03                    ; DEE4  29 03
    asl a                       ; DEE6  0A
    asl a                       ; DEE7  0A
    sta $02                     ; DEE8  85 02
    lda $60                     ; DEEA  A5 60
    and #$1C                    ; DEEC  29 1C
    asl a                       ; DEEE  0A
    ora $69                     ; DEEF  05 69
    sta $10                     ; DEF1  85 10
    lda $60                     ; DEF3  A5 60
    lsr a                       ; DEF5  4A
    ror $11                     ; DEF6  66 11
    asl a                       ; DEF8  0A
    asl a                       ; DEF9  0A
    sta $12                     ; DEFA  85 12
    ldy $10                     ; DEFC  A4 10

L_DEFE:
    lda #$00                    ; DEFE  A9 00
    sta $08                     ; DF00  85 08
    lda $0600,y                 ; DF02  B9 00 06
    asl a                       ; DF05  0A
    asl a                       ; DF06  0A
    rol $08                     ; DF07  26 08
    asl a                       ; DF09  0A
    rol $08                     ; DF0A  26 08
    asl a                       ; DF0C  0A
    rol $08                     ; DF0D  26 08
    adc $44                     ; DF0F  65 44
    sta $00                     ; DF11  85 00
    lda $08                     ; DF13  A5 08
    adc $45                     ; DF15  65 45
    sta $01                     ; DF17  85 01
    ldy $02                     ; DF19  A4 02
    lda ($00),y                 ; DF1B  B1 00
    sta $0700,x                 ; DF1D  9D 00 07
    jsr L_DFFF                  ; DF20  20 FF DF
    inx                         ; DF23  E8
    iny                         ; DF24  C8
    lda ($00),y                 ; DF25  B1 00
    sta $0700,x                 ; DF27  9D 00 07
    inx                         ; DF2A  E8
    iny                         ; DF2B  C8
    lda ($00),y                 ; DF2C  B1 00
    sta $0700,x                 ; DF2E  9D 00 07
    jsr L_DFFF                  ; DF31  20 FF DF
    inx                         ; DF34  E8
    iny                         ; DF35  C8
    lda ($00),y                 ; DF36  B1 00
    sta $0700,x                 ; DF38  9D 00 07
    inx                         ; DF3B  E8
    inc $10                     ; DF3C  E6 10
    lda $10                     ; DF3E  A5 10
    tay                         ; DF40  A8
    and #$07                    ; DF41  29 07
    bne L_DEFE                  ; DF43  D0 B9
    stx $21                     ; DF45  86 21
    rts                         ; DF47  60


L_DF48:
    ldx $21                     ; DF48  A6 21
    lda #$01                    ; DF4A  A9 01
    sta $0700,x                 ; DF4C  9D 00 07
    inx                         ; DF4F  E8
    sta $0700,x                 ; DF50  9D 00 07
    inx                         ; DF53  E8
    lda #$07                    ; DF54  A9 07
    sta $0700,x                 ; DF56  9D 00 07
    inx                         ; DF59  E8
    lda $60                     ; DF5A  A5 60
    lsr a                       ; DF5C  4A
    lsr a                       ; DF5D  4A
    ora #$C0                    ; DF5E  09 C0
    sta $00                     ; DF60  85 00
    and #$0F                    ; DF62  29 0F
    ora $69                     ; DF64  05 69
    sta $10                     ; DF66  85 10
    tay                         ; DF68  A8

L_DF69:
    lda $67                     ; DF69  A5 67
    sta $0700,x                 ; DF6B  9D 00 07
    inx                         ; DF6E  E8
    lda $00                     ; DF6F  A5 00
    sta $0700,x                 ; DF71  9D 00 07
    inx                         ; DF74  E8
    lda $0600,y                 ; DF75  B9 00 06
    tay                         ; DF78  A8
    lda ($46),y                 ; DF79  B1 46
    sta $0700,x                 ; DF7B  9D 00 07
    inx                         ; DF7E  E8
    lda $00                     ; DF7F  A5 00
    clc                         ; DF81  18
    adc #$08                    ; DF82  69 08
    sta $00                     ; DF84  85 00
    cmp #$F8                    ; DF86  C9 F8
    bcs L_DF93                  ; DF88  B0 09
    lda $10                     ; DF8A  A5 10
    adc #$08                    ; DF8C  69 08
    sta $10                     ; DF8E  85 10
    tay                         ; DF90  A8
    bcc L_DF69                  ; DF91  90 D6

L_DF93:
    stx $21                     ; DF93  86 21
    rts                         ; DF95  60


L_DF96:
    ldx $21                     ; DF96  A6 21
    lda #$01                    ; DF98  A9 01
    sta $0700,x                 ; DF9A  9D 00 07
    sta $0702,x                 ; DF9D  9D 02 07
    lda #$08                    ; DFA0  A9 08
    inx                         ; DFA2  E8
    sta $0700,x                 ; DFA3  9D 00 07
    inx                         ; DFA6  E8
    lda #$23                    ; DFA7  A9 23
    inx                         ; DFA9  E8
    sta $0700,x                 ; DFAA  9D 00 07
    lda $60                     ; DFAD  A5 60
    asl a                       ; DFAF  0A
    and #$38                    ; DFB0  29 38
    ora $69                     ; DFB2  05 69
    sta $10                     ; DFB4  85 10
    and #$BF                    ; DFB6  29 BF
    clc                         ; DFB8  18
    adc #$C0                    ; DFB9  69 C0
    inx                         ; DFBB  E8
    sta $0700,x                 ; DFBC  9D 00 07
    inx                         ; DFBF  E8

L_DFC0:
    lda $60                     ; DFC0  A5 60
    and #$03                    ; DFC2  29 03
    cmp #$03                    ; DFC4  C9 03
    beq L_DFE0                  ; DFC6  F0 18
    lda $10                     ; DFC8  A5 10
    tay                         ; DFCA  A8
    lda $0600,y                 ; DFCB  B9 00 06
    tay                         ; DFCE  A8
    lda ($46),y                 ; DFCF  B1 46

L_DFD1:
    sta $0700,x                 ; DFD1  9D 00 07
    inx                         ; DFD4  E8
    inc $10                     ; DFD5  E6 10
    lda $10                     ; DFD7  A5 10
    and #$07                    ; DFD9  29 07
    bne L_DFC0                  ; DFDB  D0 E3
    stx $21                     ; DFDD  86 21
    rts                         ; DFDF  60


L_DFE0:
    lda $10                     ; DFE0  A5 10
    tay                         ; DFE2  A8
    lda $0600,y                 ; DFE3  B9 00 06
    tay                         ; DFE6  A8
    lda ($46),y                 ; DFE7  B1 46
    and #$F0                    ; DFE9  29 F0
    sta $11                     ; DFEB  85 11
    lda $10                     ; DFED  A5 10
    eor #$40                    ; DFEF  49 40
    tay                         ; DFF1  A8
    lda $0600,y                 ; DFF2  B9 00 06
    tay                         ; DFF5  A8
    lda ($46),y                 ; DFF6  B1 46
    and #$0F                    ; DFF8  29 0F
    ora $11                     ; DFFA  05 11
    jmp L_DFD1                  ; DFFC  4C D1 DF


L_DFFF:
    sty $14                     ; DFFF  84 14
    ldy $11                     ; E001  A4 11
    bne L_E074                  ; E003  D0 6F
    tay                         ; E005  A8
    beq L_E014                  ; E006  F0 0C
    cmp $49                     ; E008  C5 49
    bcs L_E010                  ; E00A  B0 04
    lda #$01                    ; E00C  A9 01
    bne L_E022                  ; E00E  D0 12

L_E010:
    cmp $4A                     ; E010  C5 4A
    bcs L_E018                  ; E012  B0 04

L_E014:
    lda #$00                    ; E014  A9 00
    beq L_E022                  ; E016  F0 0A

L_E018:
    cmp $4B                     ; E018  C5 4B
    bcs L_E020                  ; E01A  B0 04
    lda #$02                    ; E01C  A9 02
    bne L_E022                  ; E01E  D0 02

L_E020:
    lda #$03                    ; E020  A9 03

L_E022:
    ldy $13                     ; E022  A4 13
    bne L_E038                  ; E024  D0 12
    asl a                       ; E026  0A
    asl a                       ; E027  0A
    asl a                       ; E028  0A
    asl a                       ; E029  0A
    asl a                       ; E02A  0A
    asl a                       ; E02B  0A
    sta $15                     ; E02C  85 15
    ldy $12                     ; E02E  A4 12
    lda $0680,y                 ; E030  B9 80 06
    and #$3F                    ; E033  29 3F
    jmp L_E065                  ; E035  4C 65 E0


L_E038:
    dey                         ; E038  88
    bne L_E04B                  ; E039  D0 10
    asl a                       ; E03B  0A
    asl a                       ; E03C  0A
    asl a                       ; E03D  0A
    asl a                       ; E03E  0A
    sta $15                     ; E03F  85 15
    ldy $12                     ; E041  A4 12
    lda $0680,y                 ; E043  B9 80 06
    and #$CF                    ; E046  29 CF
    jmp L_E065                  ; E048  4C 65 E0


L_E04B:
    dey                         ; E04B  88
    bne L_E05C                  ; E04C  D0 0E
    asl a                       ; E04E  0A
    asl a                       ; E04F  0A
    sta $15                     ; E050  85 15
    ldy $12                     ; E052  A4 12
    lda $0680,y                 ; E054  B9 80 06
    and #$F3                    ; E057  29 F3
    jmp L_E065                  ; E059  4C 65 E0


L_E05C:
    sta $15                     ; E05C  85 15
    ldy $12                     ; E05E  A4 12
    lda $0680,y                 ; E060  B9 80 06
    and #$FC                    ; E063  29 FC

L_E065:
    ora $15                     ; E065  05 15
    sta $0680,y                 ; E067  99 80 06
    lda $41                     ; E06A  A5 41
    bne L_E077                  ; E06C  D0 09
    tya                         ; E06E  98
    clc                         ; E06F  18
    adc #$04                    ; E070  69 04
    sta $12                     ; E072  85 12

L_E074:
    ldy $14                     ; E074  A4 14
    rts                         ; E076  60


L_E077:
    inc $13                     ; E077  E6 13
    lda $13                     ; E079  A5 13
    cmp #$04                    ; E07B  C9 04
    bcc L_E074                  ; E07D  90 F5
    lda #$00                    ; E07F  A9 00
    sta $13                     ; E081  85 13
    inc $12                     ; E083  E6 12
    bne L_E074                  ; E085  D0 ED

L_E087:
    jsr L_E0BB                  ; E087  20 BB E0

L_E08A:
    pha                         ; E08A  48
    bcc L_E0AD                  ; E08B  90 20
    lda $13                     ; E08D  A5 13
    sta $16                     ; E08F  85 16
    and #$C0                    ; E091  29 C0
    sta $17                     ; E093  85 17
    lda $16                     ; E095  A5 16
    clc                         ; E097  18
    adc #$04                    ; E098  69 04
    and #$3F                    ; E09A  29 3F
    ora $17                     ; E09C  05 17
    tay                         ; E09E  A8
    jsr L_E0B5                  ; E09F  20 B5 E0
    asl a                       ; E0A2  0A
    lda $16                     ; E0A3  A5 16
    sta $13                     ; E0A5  85 13
    bcc L_E0AD                  ; E0A7  90 04
    pla                         ; E0A9  68
    lda #$80                    ; E0AA  A9 80
    rts                         ; E0AC  60


L_E0AD:
    pla                         ; E0AD  68
    rts                         ; E0AE  60


L_E0AF:
    jsr L_E0B5                  ; E0AF  20 B5 E0
    jmp L_E08A                  ; E0B2  4C 8A E0


L_E0B5:
    lda #$00                    ; E0B5  A9 00

L_E0B7:
    sta $15                     ; E0B7  85 15
    beq L_E105                  ; E0B9  F0 4A

L_E0BB:
    sta $13                     ; E0BB  85 13

L_E0BD:
    lda #$00                    ; E0BD  A9 00
    sta $10                     ; E0BF  85 10
    beq L_E0C5                  ; E0C1  F0 02
    sta $13                     ; E0C3  85 13

L_E0C5:
    tya                         ; E0C5  98
    sta $15                     ; E0C6  85 15
    clc                         ; E0C8  18
    adc $FC                     ; E0C9  65 FC
    bcs L_E0D1                  ; E0CB  B0 04
    cmp #$F0                    ; E0CD  C9 F0
    bcc L_E0D3                  ; E0CF  90 02

L_E0D1:
    adc #$0F                    ; E0D1  69 0F

L_E0D3:
    sta $11                     ; E0D3  85 11
    lda $13                     ; E0D5  A5 13
    clc                         ; E0D7  18
    adc $FD                     ; E0D8  65 FD
    sta $12                     ; E0DA  85 12
    lda $FF                     ; E0DC  A5 FF
    eor $10                     ; E0DE  45 10
    and #$01                    ; E0E0  29 01
    bcc L_E0E6                  ; E0E2  90 02
    eor #$01                    ; E0E4  49 01

L_E0E6:
    tay                         ; E0E6  A8
    lda $11                     ; E0E7  A5 11
    lsr a                       ; E0E9  4A
    lsr a                       ; E0EA  4A
    and #$3C                    ; E0EB  29 3C
    sta $11                     ; E0ED  85 11
    lda $12                     ; E0EF  A5 12
    lsr a                       ; E0F1  4A
    lsr a                       ; E0F2  4A
    lsr a                       ; E0F3  4A
    lsr a                       ; E0F4  4A
    sta $12                     ; E0F5  85 12
    lsr a                       ; E0F7  4A
    lsr a                       ; E0F8  4A
    ora $11                     ; E0F9  05 11
    ora D_E130,y                ; E0FB  19 30 E1
    tay                         ; E0FE  A8
    lda $12                     ; E0FF  A5 12
    and #$03                    ; E101  29 03
    sta $12                     ; E103  85 12

L_E105:
    sty $13                     ; E105  84 13
    lda $15                     ; E107  A5 15
    cmp #$E0                    ; E109  C9 E0
    lda #$00                    ; E10B  A9 00
    bcs L_E12A                  ; E10D  B0 1B
    lda $0680,y                 ; E10F  B9 80 06
    ldy $12                     ; E112  A4 12
    beq L_E11E                  ; E114  F0 08
    dey                         ; E116  88
    beq L_E120                  ; E117  F0 07
    dey                         ; E119  88
    beq L_E122                  ; E11A  F0 06
    bne L_E124                  ; E11C  D0 06

L_E11E:
    lsr a                       ; E11E  4A
    lsr a                       ; E11F  4A

L_E120:
    lsr a                       ; E120  4A
    lsr a                       ; E121  4A

L_E122:
    lsr a                       ; E122  4A
    lsr a                       ; E123  4A

L_E124:
    and #$03                    ; E124  29 03
    tay                         ; E126  A8
    lda D_E132,y                ; E127  B9 32 E1

L_E12A:
    sta $14                     ; E12A  85 14
    lsr a                       ; E12C  4A
    lda $14                     ; E12D  A5 14
    rts                         ; E12F  60

D_E130:
    .byte $00,$40
D_E132:
    .byte $00,$01,$02,$80

L_E136:
    lda $3B                     ; E136  A5 3B
    bne L_E156                  ; E138  D0 1C
    lda $58                     ; E13A  A5 58
    bmi L_E154                  ; E13C  30 16
    cmp $64                     ; E13E  C5 64
    bne L_E156                  ; E140  D0 14
    ldy $41                     ; E142  A4 41
    lda $65                     ; E144  A5 65
    cmp D_E157,y                ; E146  D9 57 E1
    bcc L_E156                  ; E149  90 0B
    lda D_E159,y                ; E14B  B9 59 E1
    sta $75                     ; E14E  85 75
    lda #$FF                    ; E150  A9 FF
    sta $58                     ; E152  85 58

L_E154:
    lda #$00                    ; E154  A9 00

L_E156:
    rts                         ; E156  60

D_E157:
    .byte $A0,$C0
D_E159:
    .byte $60,$40

L_E15B:
    lda $64                     ; E15B  A5 64
    clc                         ; E15D  18
    adc #$02                    ; E15E  69 02
    bne L_E16B                  ; E160  D0 09

L_E162:
    lda $64                     ; E162  A5 64
    clc                         ; E164  18
    adc #$01                    ; E165  69 01
    bne L_E16B                  ; E167  D0 02

L_E169:
    lda $64                     ; E169  A5 64

L_E16B:
    asl a                       ; E16B  0A
    tax                         ; E16C  AA
    ldy #$02                    ; E16D  A0 02
    jsr SwitchBank              ; E16F  20 39 C1
    txa                         ; E172  8A
    tay                         ; E173  A8
    lda ($42),y                 ; E174  B1 42
    sta $00                     ; E176  85 00
    iny                         ; E178  C8
    lda ($42),y                 ; E179  B1 42
    sta $01                     ; E17B  85 01
    ldy #$00                    ; E17D  A0 00
    ldx $69                     ; E17F  A6 69

L_E181:
    lda ($00),y                 ; E181  B1 00
    iny                         ; E183  C8
    cmp #$80                    ; E184  C9 80
    bcs L_E1A6                  ; E186  B0 1E
    sta $0600,x                 ; E188  9D 00 06
    inx                         ; E18B  E8

L_E18C:
    lda $41                     ; E18C  A5 41
    bne L_E19B                  ; E18E  D0 0B
    cpx #$38                    ; E190  E0 38
    beq L_E1A3                  ; E192  F0 0F
    cpx #$78                    ; E194  E0 78
    bcc L_E181                  ; E196  90 E9
    jmp RestoreBank             ; E198  4C 46 C1


L_E19B:
    cpx #$40                    ; E19B  E0 40
    beq L_E1A3                  ; E19D  F0 04
    cpx #$80                    ; E19F  E0 80
    bcc L_E181                  ; E1A1  90 DE

L_E1A3:
    jmp RestoreBank             ; E1A3  4C 46 C1


L_E1A6:
    cmp #$F0                    ; E1A6  C9 F0
    bcs L_E1BB                  ; E1A8  B0 11
    and #$7F                    ; E1AA  29 7F
    sta $02                     ; E1AC  85 02
    lda ($00),y                 ; E1AE  B1 00
    iny                         ; E1B0  C8

L_E1B1:
    sta $0600,x                 ; E1B1  9D 00 06
    inx                         ; E1B4  E8
    dec $02                     ; E1B5  C6 02
    bne L_E1B1                  ; E1B7  D0 F8
    beq L_E18C                  ; E1B9  F0 D1

L_E1BB:
    and #$0F                    ; E1BB  29 0F
    asl a                       ; E1BD  0A
    asl a                       ; E1BE  0A
    asl a                       ; E1BF  0A
    ora $69                     ; E1C0  05 69
    sty $03                     ; E1C2  84 03
    tay                         ; E1C4  A8
    lda #$08                    ; E1C5  A9 08
    sta $02                     ; E1C7  85 02

L_E1C9:
    lda $0600,y                 ; E1C9  B9 00 06
    sta $0600,x                 ; E1CC  9D 00 06
    inx                         ; E1CF  E8
    iny                         ; E1D0  C8
    dec $02                     ; E1D1  C6 02
    bne L_E1C9                  ; E1D3  D0 F4
    ldy $03                     ; E1D5  A4 03
    bne L_E18C                  ; E1D7  D0 B3

L_E1D9:
    ldx #$01                    ; E1D9  A2 01

L_E1DB:
    ldy $83                     ; E1DB  A4 83
    lda $90,x                   ; E1DD  B5 90
    cmp #$01                    ; E1DF  C9 01
    bne L_E25C                  ; E1E1  D0 79
    lda $40                     ; E1E3  A5 40
    lsr a                       ; E1E5  4A
    bcc L_E1F7                  ; E1E6  90 0F
    lda $0528,y                 ; E1E8  B9 28 05
    cmp #$01                    ; E1EB  C9 01
    bne L_E22A                  ; E1ED  D0 3B
    lda $BC,x                   ; E1EF  B5 BC
    cmp #$02                    ; E1F1  C9 02
    bne L_E22A                  ; E1F3  D0 35
    beq L_E25C                  ; E1F5  F0 65

L_E1F7:
    lda $0598,y                 ; E1F7  B9 98 05
    asl a                       ; E1FA  0A
    bpl L_E22A                  ; E1FB  10 2D
    asl a                       ; E1FD  0A
    bpl L_E21C                  ; E1FE  10 1C
    lda $0324,y                 ; E200  B9 24 03
    sec                         ; E203  38
    sbc $031A,x                 ; E204  FD 1A 03
    bcc L_E212                  ; E207  90 09
    cmp #$08                    ; E209  C9 08
    lda $0598,y                 ; E20B  B9 98 05
    and #$EF                    ; E20E  29 EF
    bcs L_E217                  ; E210  B0 05

L_E212:
    lda $0598,y                 ; E212  B9 98 05
    ora #$10                    ; E215  09 10

L_E217:
    sta $0598,y                 ; E217  99 98 05
    bne L_E22A                  ; E21A  D0 0E

L_E21C:
    lda $A0,x                   ; E21C  B5 A0
    beq L_E22A                  ; E21E  F0 0A
    lda $C6,x                   ; E220  B5 C6
    bmi L_E25C                  ; E222  30 38
    cmp #$01                    ; E224  C9 01
    bcc L_E25C                  ; E226  90 34
    bcs L_E22A                  ; E228  B0 00

L_E22A:
    ldy #$00                    ; E22A  A0 00
    lda $B2,x                   ; E22C  B5 B2
    beq L_E238                  ; E22E  F0 08
    lda $F1,x                   ; E230  B5 F1
    and #$04                    ; E232  29 04
    bne L_E25C                  ; E234  D0 26
    beq L_E245                  ; E236  F0 0D

L_E238:
    iny                         ; E238  C8
    lda $A0,x                   ; E239  B5 A0
    bne L_E245                  ; E23B  D0 08
    iny                         ; E23D  C8
    lda $D6,x                   ; E23E  B5 D6
    cmp #$17                    ; E240  C9 17
    beq L_E245                  ; E242  F0 01
    iny                         ; E244  C8

L_E245:
    jsr L_E411                  ; E245  20 11 E4
    lda $031A,x                 ; E248  BD 1A 03
    sec                         ; E24B  38
    sbc $08                     ; E24C  E5 08
    cmp $0A                     ; E24E  C5 0A
    bcs L_E25C                  ; E250  B0 0A
    lda $0334,x                 ; E252  BD 34 03
    sec                         ; E255  38
    sbc $09                     ; E256  E5 09
    cmp $0B                     ; E258  C5 0B
    bcc L_E29F                  ; E25A  90 43

L_E25C:
    dex                         ; E25C  CA
    bmi L_E262                  ; E25D  30 03
    jmp L_E1DB                  ; E25F  4C DB E1


L_E262:
    ldx $83                     ; E262  A6 83
    rts                         ; E264  60


L_E265:
    lda $031A,x                 ; E265  BD 1A 03
    cmp $B8,x                   ; E268  D5 B8
    bcc L_E25C                  ; E26A  90 F0
    lda #$01                    ; E26C  A9 01
    sta $0568,y                 ; E26E  99 68 05
    lda $0518,y                 ; E271  B9 18 05
    clc                         ; E274  18
    adc $04D8,y                 ; E275  79 D8 04
    lda $0508,y                 ; E278  B9 08 05
    adc #$00                    ; E27B  69 00
    clc                         ; E27D  18
    adc $D4,x                   ; E27E  75 D4
    sta $D4,x                   ; E280  95 D4
    lda $0598,y                 ; E282  B9 98 05
    asl a                       ; E285  0A
    asl a                       ; E286  0A
    asl a                       ; E287  0A
    lda #$E4                    ; E288  A9 E4
    bcc L_E28E                  ; E28A  90 02
    lda #$E8                    ; E28C  A9 E8

L_E28E:
    clc                         ; E28E  18
    adc $0324,y                 ; E28F  79 24 03
    sta $031A,x                 ; E292  9D 1A 03
    lda #$01                    ; E295  A9 01
    sta $B6,x                   ; E297  95 B6
    jsr L_D867                  ; E299  20 67 D8
    jmp L_E25C                  ; E29C  4C 5C E2


L_E29F:
    ldy $83                     ; E29F  A4 83
    lda $033E,y                 ; E2A1  B9 3E 03
    sec                         ; E2A4  38
    sbc $0334,x                 ; E2A5  FD 34 03
    bcs L_E2AE                  ; E2A8  B0 04
    eor #$FF                    ; E2AA  49 FF
    adc #$01                    ; E2AC  69 01

L_E2AE:
    cmp #$80                    ; E2AE  C9 80
    bcs L_E25C                  ; E2B0  B0 AA
    lda $0598,y                 ; E2B2  B9 98 05
    asl a                       ; E2B5  0A
    bpl L_E2BC                  ; E2B6  10 04
    and #$20                    ; E2B8  29 20
    beq L_E265                  ; E2BA  F0 A9

L_E2BC:
    lda $0528,y                 ; E2BC  B9 28 05
    beq L_E2EC                  ; E2BF  F0 2B
    lda $AE,x                   ; E2C1  B5 AE
    bne L_E25C                  ; E2C3  D0 97
    lda $B0,x                   ; E2C5  B5 B0
    bne L_E2D6                  ; E2C7  D0 0D
    jsr L_D54A                  ; E2C9  20 4A D5
    lda $0528,y                 ; E2CC  B9 28 05
    cmp #$01                    ; E2CF  C9 01
    beq L_E340                  ; E2D1  F0 6D
    ldx $83                     ; E2D3  A6 83
    rts                         ; E2D5  60


L_E2D6:
    stx $17                     ; E2D6  86 17
    ldx $83                     ; E2D8  A6 83
    lda $0578,x                 ; E2DA  BD 78 05
    beq L_E2EB                  ; E2DD  F0 0C
    cmp #$F0                    ; E2DF  C9 F0
    bcs L_E2EB                  ; E2E1  B0 08
    lda #$00                    ; E2E3  A9 00
    sta $0578,x                 ; E2E5  9D 78 05
    jsr L_E942                  ; E2E8  20 42 E9

L_E2EB:
    rts                         ; E2EB  60


L_E2EC:
    stx $10                     ; E2EC  86 10
    lda #$0A                    ; E2EE  A9 0A
    sta $00                     ; E2F0  85 00
    txa                         ; E2F2  8A
    tay                         ; E2F3  A8
    jsr L_C4A0                  ; E2F4  20 A0 C4
    ldx $10                     ; E2F7  A6 10
    ldy $83                     ; E2F9  A4 83
    lda #$1F                    ; E2FB  A9 1F
    jsr L_C16B                  ; E2FD  20 6B C1
    lda $05A8,y                 ; E300  B9 A8 05
    and #$07                    ; E303  29 07
    beq L_E325                  ; E305  F0 1E
    cmp #$05                    ; E307  C9 05
    bcc L_E32D                  ; E309  90 22
    beq L_E316                  ; E30B  F0 09
    jsr L_E9E5                  ; E30D  20 E5 E9
    lda #$20                    ; E310  A9 20
    sta $7D                     ; E312  85 7D
    bne L_E340                  ; E314  D0 2A

L_E316:
    lda #$80                    ; E316  A9 80
    ldy $30                     ; E318  A4 30
    cpy #$06                    ; E31A  C0 06
    bne L_E320                  ; E31C  D0 02
    lda #$90                    ; E31E  A9 90

L_E320:
    sta $B0,x                   ; E320  95 B0
    jmp L_E340                  ; E322  4C 40 E3


L_E325:
    lda #$10                    ; E325  A9 10
    sta $08                     ; E327  85 08
    ldy #$FF                    ; E329  A0 FF
    bne L_E339                  ; E32B  D0 0C

L_E32D:
    ldy #$F0                    ; E32D  A0 F0
    sta $08                     ; E32F  85 08
    eor $AA,x                   ; E331  55 AA
    and #$0F                    ; E333  29 0F
    beq L_E339                  ; E335  F0 02
    ldy #$E0                    ; E337  A0 E0

L_E339:
    tya                         ; E339  98
    and $AA,x                   ; E33A  35 AA
    ora $08                     ; E33C  05 08
    sta $AA,x                   ; E33E  95 AA

L_E340:
    ldx $83                     ; E340  A6 83
    jmp L_E809                  ; E342  4C 09 E8


L_E345:
    lda $0598,x                 ; E345  BD 98 05
    and #$30                    ; E348  29 30
    asl a                       ; E34A  0A
    asl a                       ; E34B  0A
    sta $10                     ; E34C  85 10
    ldy #$04                    ; E34E  A0 04
    jsr L_E411                  ; E350  20 11 E4
    ldx #$0F                    ; E353  A2 0F

L_E355:
    lda $0368,x                 ; E355  BD 68 03
    beq L_E38A                  ; E358  F0 30
    lda $0438,x                 ; E35A  BD 38 04
    cmp #$01                    ; E35D  C9 01
    bne L_E38A                  ; E35F  D0 29
    lda $40                     ; E361  A5 40
    lsr a                       ; E363  4A
    bcc L_E378                  ; E364  90 12
    ldy $10                     ; E366  A4 10
    bpl L_E371                  ; E368  10 07
    lda $0388,x                 ; E36A  BD 88 03
    bmi L_E378                  ; E36D  30 09
    bpl L_E38A                  ; E36F  10 19

L_E371:
    lda $0418,x                 ; E371  BD 18 04
    cmp #$02                    ; E374  C9 02
    bcs L_E38A                  ; E376  B0 12

L_E378:
    lda $03B8,x                 ; E378  BD B8 03
    sbc $08                     ; E37B  E5 08
    cmp $0A                     ; E37D  C5 0A
    bcs L_E38A                  ; E37F  B0 09
    lda $03C8,x                 ; E381  BD C8 03
    sbc $09                     ; E384  E5 09
    cmp $0B                     ; E386  C5 0B
    bcc L_E390                  ; E388  90 06

L_E38A:
    dex                         ; E38A  CA
    bpl L_E355                  ; E38B  10 C8
    ldx $83                     ; E38D  A6 83
    rts                         ; E38F  60


L_E390:
    ldy $83                     ; E390  A4 83
    lda $033E,y                 ; E392  B9 3E 03
    sec                         ; E395  38
    sbc $03C8,x                 ; E396  FD C8 03
    bcs L_E39F                  ; E399  B0 04
    eor #$FF                    ; E39B  49 FF
    adc #$01                    ; E39D  69 01

L_E39F:
    cmp #$80                    ; E39F  C9 80
    bcs L_E38A                  ; E3A1  B0 E7
    lda $0448,x                 ; E3A3  BD 48 04
    jsr L_E3D8                  ; E3A6  20 D8 E3
    lda $0388,x                 ; E3A9  BD 88 03
    cmp #$05                    ; E3AC  C9 05
    bne L_E3C7                  ; E3AE  D0 17

L_E3B0:
    stx $08                     ; E3B0  86 08
    txa                         ; E3B2  8A
    ldx #$00                    ; E3B3  A2 00
    cmp #$0A                    ; E3B5  C9 0A
    bcc L_E3BB                  ; E3B7  90 02
    ldx #$0A                    ; E3B9  A2 0A

L_E3BB:
    lda $0438,x                 ; E3BB  BD 38 04
    cmp #$01                    ; E3BE  C9 01
    beq L_E3C7                  ; E3C0  F0 05
    inx                         ; E3C2  E8
    cpx $08                     ; E3C3  E4 08
    bne L_E3BB                  ; E3C5  D0 F4

L_E3C7:
    jsr L_E3CD                  ; E3C7  20 CD E3
    ldx $83                     ; E3CA  A6 83
    rts                         ; E3CC  60


L_E3CD:
    lda #$02                    ; E3CD  A9 02
    sta $0438,x                 ; E3CF  9D 38 04
    lda #$06                    ; E3D2  A9 06
    sta $0418,x                 ; E3D4  9D 18 04
    rts                         ; E3D7  60


L_E3D8:
    sta $17                     ; E3D8  85 17
    stx $11                     ; E3DA  86 11
    ldy $83                     ; E3DC  A4 83
    lda $0578,y                 ; E3DE  B9 78 05
    beq L_E40B                  ; E3E1  F0 28
    cmp #$F0                    ; E3E3  C9 F0
    bcs L_E40B                  ; E3E5  B0 24
    sbc #$00                    ; E3E7  E9 00
    bcs L_E3ED                  ; E3E9  B0 02
    lda #$00                    ; E3EB  A9 00

L_E3ED:
    sta $0578,y                 ; E3ED  99 78 05
    bne L_E3FA                  ; E3F0  D0 08
    ldx $83                     ; E3F2  A6 83
    jsr L_E942                  ; E3F4  20 42 E9
    ldx $11                     ; E3F7  A6 11
    rts                         ; E3F9  60


L_E3FA:
    lda $0598,y                 ; E3FA  B9 98 05
    and #$04                    ; E3FD  29 04
    beq L_E40B                  ; E3FF  F0 0A
    lda $0548,y                 ; E401  B9 48 05
    tay                         ; E404  A8
    lda D_E40C,y                ; E405  B9 0C E4
    jsr L_C16B                  ; E408  20 6B C1

L_E40B:
    rts                         ; E40B  60

D_E40C:
    .byte $16,$16,$16,$18,$14

L_E411:
    stx $11                     ; E411  86 11
    ldx $83                     ; E413  A6 83
    tya                         ; E415  98
    asl a                       ; E416  0A
    tay                         ; E417  A8
    lda D_E4E8,y                ; E418  B9 E8 E4
    sta $0E                     ; E41B  85 0E
    lda D_E4E9,y                ; E41D  B9 E9 E4
    sta $0F                     ; E420  85 0F
    lda $0588,x                 ; E422  BD 88 05
    and #$0F                    ; E425  29 0F
    cmp #$0F                    ; E427  C9 0F
    beq L_E44B                  ; E429  F0 20
    asl a                       ; E42B  0A
    asl a                       ; E42C  0A
    tay                         ; E42D  A8
    lda $0324,x                 ; E42E  BD 24 03
    adc ($0E),y                 ; E431  71 0E
    sta $08                     ; E433  85 08
    iny                         ; E435  C8
    lda $033E,x                 ; E436  BD 3E 03
    clc                         ; E439  18
    adc ($0E),y                 ; E43A  71 0E
    sta $09                     ; E43C  85 09
    iny                         ; E43E  C8
    lda ($0E),y                 ; E43F  B1 0E
    sta $0A                     ; E441  85 0A
    iny                         ; E443  C8
    lda ($0E),y                 ; E444  B1 0E
    sta $0B                     ; E446  85 0B
    ldx $11                     ; E448  A6 11
    rts                         ; E44A  60


L_E44B:
    lda $05A8,x                 ; E44B  BD A8 05
    asl a                       ; E44E  0A
    asl a                       ; E44F  0A
    lda $05B8,x                 ; E450  BD B8 05
    bcc L_E459                  ; E453  90 04
    eor #$FF                    ; E455  49 FF
    adc #$00                    ; E457  69 00

L_E459:
    clc                         ; E459  18
    adc #$08                    ; E45A  69 08
    sta $0C                     ; E45C  85 0C
    tya                         ; E45E  98
    asl a                       ; E45F  0A
    tay                         ; E460  A8
    lda D_E4C4,y                ; E461  B9 C4 E4
    sta $08                     ; E464  85 08
    lda D_E4C5,y                ; E466  B9 C5 E4
    sta $09                     ; E469  85 09
    lda D_E4C6,y                ; E46B  B9 C6 E4
    sta $0A                     ; E46E  85 0A
    lda D_E4C7,y                ; E470  B9 C7 E4
    sta $0B                     ; E473  85 0B
    lda $05A8,x                 ; E475  BD A8 05
    lsr a                       ; E478  4A
    lsr a                       ; E479  4A
    lsr a                       ; E47A  4A
    lsr a                       ; E47B  4A
    and #$0C                    ; E47C  29 0C
    tay                         ; E47E  A8
    lda D_E4D8,y                ; E47F  B9 D8 E4
    jsr L_E4B6                  ; E482  20 B6 E4
    clc                         ; E485  18
    adc $08                     ; E486  65 08
    clc                         ; E488  18
    adc $0324,x                 ; E489  7D 24 03
    sta $08                     ; E48C  85 08
    lda D_E4D9,y                ; E48E  B9 D9 E4
    jsr L_E4B6                  ; E491  20 B6 E4
    clc                         ; E494  18
    adc $09                     ; E495  65 09
    clc                         ; E497  18
    adc $033E,x                 ; E498  7D 3E 03
    sta $09                     ; E49B  85 09
    lda D_E4DA,y                ; E49D  B9 DA E4
    jsr L_E4B6                  ; E4A0  20 B6 E4
    clc                         ; E4A3  18
    adc $0A                     ; E4A4  65 0A
    sta $0A                     ; E4A6  85 0A
    lda D_E4DB,y                ; E4A8  B9 DB E4
    jsr L_E4B6                  ; E4AB  20 B6 E4
    clc                         ; E4AE  18
    adc $0B                     ; E4AF  65 0B

L_E4B1:
    sta $0B                     ; E4B1  85 0B
    ldx $11                     ; E4B3  A6 11
    rts                         ; E4B5  60


L_E4B6:
    cmp #$FE                    ; E4B6  C9 FE
    bcc L_E4C3                  ; E4B8  90 09
    lsr a                       ; E4BA  4A
    lda $0C                     ; E4BB  A5 0C
    bcs L_E4C3                  ; E4BD  B0 04
    eor #$FF                    ; E4BF  49 FF
    adc #$01                    ; E4C1  69 01

L_E4C3:
    rts                         ; E4C3  60

D_E4C4:
    .byte $00
D_E4C5:
    .byte $FB
D_E4C6:
    .byte $0A
D_E4C7:
    .byte $0A,$F8,$FC,$10,$08,$F4,$F5,$04,$16,$F1,$FC,$1D,$08,$FE,$FE,$04
    .byte $04
D_E4D8:
    .byte $FA
D_E4D9:
    .byte $F8
D_E4DA:
    .byte $0C
D_E4DB:
    .byte $FF,$FA,$FE,$0C,$FF,$F8,$FA,$FF,$0C,$FE,$F6,$FF,$14
D_E4E8:
    .byte $F2
D_E4E9:
    .byte $E4,$2E,$E5,$6A,$E5,$A6,$E5,$E2,$E5,$F1,$F7,$28,$12,$FE,$F9,$14
    .byte $14,$F8,$F3,$1A,$1A,$F2,$ED,$26,$26,$E0,$F0,$08,$20,$FD,$F8,$10
    .byte $10,$F5,$F7,$20,$12,$E7,$E2,$3C,$3C,$F1,$E2,$28,$3C,$E4,$D3,$48
    .byte $5A,$00,$F6,$16,$16,$08,$F1,$12,$1E,$F5,$F1,$20,$1E,$EA,$EC,$37
    .byte $28,$F3,$F3,$11,$1A,$EA,$F8,$1E,$10,$F6,$FA,$0C,$0C,$F1,$F5,$12
    .byte $16,$EA,$EE,$24,$24,$E0,$F0,$08,$20,$F5,$F9,$0E,$0E,$ED,$F8,$1E
    .byte $10,$DF,$E3,$3A,$3A,$E9,$E3,$26,$3A,$DC,$D4,$46,$58,$F8,$F7,$14
    .byte $14,$00,$F2,$10,$1C,$ED,$F2,$1E,$1C,$E2,$ED,$35,$26,$F3,$F1,$12
    .byte $1E,$F4,$F1,$0D,$1E,$F3,$F4,$04,$18,$EC,$ED,$10,$26,$E6,$E7,$1C
    .byte $32,$E0,$F0,$08,$20,$F1,$F2,$06,$1C,$E9,$F1,$16,$1E,$DB,$DC,$32
    .byte $48,$E5,$DC,$1E,$48,$D8,$CD,$3E,$66,$F4,$F0,$19,$22,$FC,$EB,$08
    .byte $2A,$E3,$F2,$1A,$1C,$DE,$E6,$2D,$34,$E9,$EA,$0D,$2C,$F3,$F8,$24
    .byte $10,$F0,$FB,$1F,$0A,$EA,$F5,$2B,$16,$E3,$EE,$39,$24,$E0,$F0,$08
    .byte $20,$EE,$F9,$23,$0E,$E6,$F8,$33,$10,$D8,$E3,$4F,$3A,$E2,$E3,$3B
    .byte $3A,$D5,$D4,$5B,$58,$F1,$F7,$29,$14,$F9,$F2,$25,$1C,$E4,$F2,$35
    .byte $1C,$DA,$ED,$4A,$26,$E6,$F1,$2A,$1E,$EE,$F5,$24,$16,$FC,$FC,$08
    .byte $08,$F5,$F5,$16,$16,$EF,$EF,$22,$22,$E0,$F0,$08,$20,$FA,$FA,$0C
    .byte $0C,$F3,$FA,$16,$0C,$E4,$E4,$38,$38,$EE,$E4,$24,$38,$E1,$D5,$44
    .byte $56,$FD,$F8,$12,$12,$05,$F3,$0E,$1A,$F3,$F3,$1A,$1A,$E7,$EE,$33
    .byte $24,$F2,$F2,$13,$1C

L_E61E:
    lda #$00                    ; E61E  A9 00
    sta $B6                     ; E620  85 B6
    sta $B7                     ; E622  85 B7
    ldx #$0F                    ; E624  A2 0F

L_E626:
    lda $04B8,x                 ; E626  BD B8 04
    beq L_E655                  ; E629  F0 2A
    stx $83                     ; E62B  86 83
    asl a                       ; E62D  0A
    sta $04                     ; E62E  85 04
    jsr L_E659                  ; E630  20 59 E6
    lda $030A,x                 ; E633  BD 0A 03
    beq L_E655                  ; E636  F0 1D
    lda $40                     ; E638  A5 40
    lsr a                       ; E63A  4A
    bcc L_E644                  ; E63B  90 07
    lda $0324,x                 ; E63D  BD 24 03
    cmp #$9C                    ; E640  C9 9C
    bcc L_E64D                  ; E642  90 09

L_E644:
    lda $0598,x                 ; E644  BD 98 05
    lsr a                       ; E647  4A
    bcs L_E64D                  ; E648  B0 03
    jsr L_E1D9                  ; E64A  20 D9 E1

L_E64D:
    lda $0598,x                 ; E64D  BD 98 05
    bmi L_E655                  ; E650  30 03
    jsr L_E345                  ; E652  20 45 E3

L_E655:
    dex                         ; E655  CA
    bpl L_E626                  ; E656  10 CE
    rts                         ; E658  60


L_E659:
    lda $0528,x                 ; E659  BD 28 05
    asl a                       ; E65C  0A
    tay                         ; E65D  A8
    lsr a                       ; E65E  4A
    cmp #$10                    ; E65F  C9 10
    bcs L_E67B                  ; E661  B0 18
    lda D_E6A8,y                ; E663  B9 A8 E6
    sta $02                     ; E666  85 02
    lda D_E6A8+1,y              ; E668  B9 A9 E6

L_E66B:
    sta $03                     ; E66B  85 03
    ldy $04                     ; E66D  A4 04
    lda ($02),y                 ; E66F  B1 02
    sta $04                     ; E671  85 04
    iny                         ; E673  C8
    lda ($02),y                 ; E674  B1 02
    sta $05                     ; E676  85 05
    jmp ($0004)                 ; E678  6C 04 00


L_E67B:
    tya                         ; E67B  98
    sbc #$20                    ; E67C  E9 20
    tay                         ; E67E  A8
    lda ($80),y                 ; E67F  B1 80
    sta $02                     ; E681  85 02
    iny                         ; E683  C8
    lda ($80),y                 ; E684  B1 80
    jmp L_E66B                  ; E686  4C 6B E6


L_E689:
    lda $30                     ; E689  A5 30
    asl a                       ; E68B  0A
    tay                         ; E68C  A8
    lda D_E698,y                ; E68D  B9 98 E6
    sta $80                     ; E690  85 80
    lda D_E699,y                ; E692  B9 99 E6
    sta $81                     ; E695  85 81
    rts                         ; E697  60

D_E698:
    .byte $C8
D_E699:
    .word L_CEE6                    ; E699
    .word L_F0E6                    ; E69B
    .word L_CEE6                    ; E69D
    .byte $E6,$FC,$E6,$0A,$E7,$14,$E7,$26,$E7
D_E6A8:
    .word $7FFF                     ; E6A8
    .word D0_8147-2                 ; E6AA
    .word D0_8205-2                 ; E6AC
    .word D0_8305-2                 ; E6AE
    .word L0_8376+1                 ; E6B0
    .word L0_8607-1                 ; E6B2
    .word D0_8946-2                 ; E6B4
    .word L0_84B6                   ; E6B6
    .word D_EFB7-2                  ; E6B8
    .word D_E734-2                  ; E6BA
    .word D_F077-2                  ; E6BC
    .word D_F1C4-2                  ; E6BE
    .word D_F13B-2                  ; E6C0
    .word D_E734-2                  ; E6C2
    .word L_F0BA+1                  ; E6C4
    .word D_F119-2                  ; E6C6
    .byte $47,$8B,$C7,$8B,$50,$8C,$65,$8E,$80,$8F,$C7,$8F,$8A,$90,$0E,$91
    .byte $B8,$92,$6E,$93,$58,$94,$2F,$95,$17,$8D,$C0,$95,$33,$8F,$F3,$9E
    .byte $4F,$A0,$47,$A1,$58,$A2,$FC,$A2,$E3,$97,$3A,$98,$55,$98,$7B,$98
    .byte $16,$99,$8A,$9A,$82,$A3,$A9,$A3,$0C,$A4,$81,$A9,$98,$A6,$EA,$A8
    .byte $6A,$A9,$97,$A9,$4B,$AA,$9A,$AA,$7D,$AB,$40,$AE,$B9,$AE,$C8,$AF
    .byte $F9,$B0,$1C,$B1,$78,$B1,$D7,$B1,$01,$B2,$72,$B2,$2C,$B3,$22,$B4
    .byte $E0,$B6,$F4,$B7,$66,$B8,$29,$BA,$B5,$BB,$80,$BC
D_E734:
    .word L_E736                    ; E734

L_E736:
    rts                         ; E736  60

    .byte $20,$4B,$E7,$A9,$00,$9D,$68,$05,$60,$20,$83,$C1,$A9,$57,$20,$EA
    .byte $EA,$20,$E5,$E9

L_E74B:
    lda $0598,x                 ; E74B  BD 98 05
    ora #$81                    ; E74E  09 81
    bne L_E75E                  ; E750  D0 0C

L_E752:
    lda #$0D                    ; E752  A9 0D
    sta $0588,x                 ; E754  9D 88 05
    lda $0598,x                 ; E757  BD 98 05
    and #$BE                    ; E75A  29 BE
    ora #$80                    ; E75C  09 80

L_E75E:
    sta $0598,x                 ; E75E  9D 98 05
    and #$02                    ; E761  29 02
    beq L_E76A                  ; E763  F0 05
    lda #$19                    ; E765  A9 19
    jsr L_C16B                  ; E767  20 6B C1

L_E76A:
    lda $0358,x                 ; E76A  BD 58 03
    and #$FC                    ; E76D  29 FC
    ora #$06                    ; E76F  09 06
    sta $0358,x                 ; E771  9D 58 03
    lda $030A,x                 ; E774  BD 0A 03
    bne L_E77C                  ; E777  D0 03
    jmp L_E809                  ; E779  4C 09 E8


L_E77C:
    lda #$FF                    ; E77C  A9 FF
    sta $0568,x                 ; E77E  9D 68 05
    lda #$01                    ; E781  A9 01
    sta $030A,x                 ; E783  9D 0A 03
    jsr L_E8A7                  ; E786  20 A7 E8
    lda #$01                    ; E789  A9 01

L_E78B:
    sta $0538,x                 ; E78B  9D 38 05

L_E78E:
    lda $04B8,x                 ; E78E  BD B8 04
    beq L_E80E                  ; E791  F0 7B
    inc $04B8,x                 ; E793  FE B8 04
    rts                         ; E796  60

    .byte $BD,$B8,$04,$F0,$72,$FE,$B8,$04,$A9,$24,$4C,$6B,$C1,$A9,$03,$A0
    .byte $02,$D0,$12,$A9,$02,$A0,$03,$D0,$0C

L_E7B0:
    lda $0598,x                 ; E7B0  BD 98 05
    ldy #$03                    ; E7B3  A0 03
    and #$08                    ; E7B5  29 08
    beq L_E7BA                  ; E7B7  F0 01
    iny                         ; E7B9  C8

L_E7BA:
    lda #$00                    ; E7BA  A9 00
    sty $08                     ; E7BC  84 08
    sta $09                     ; E7BE  85 09
    jsr L_E8A7                  ; E7C0  20 A7 E8
    lda $04B8,x                 ; E7C3  BD B8 04
    beq L_E805                  ; E7C6  F0 3D
    dec $0538,x                 ; E7C8  DE 38 05
    bne L_E805                  ; E7CB  D0 38
    inc $0568,x                 ; E7CD  FE 68 05
    ldy $0568,x                 ; E7D0  BC 68 05
    cpy $08                     ; E7D3  C4 08
    bcs L_E78E                  ; E7D5  B0 B7
    iny                         ; E7D7  C8
    cpy $08                     ; E7D8  C4 08
    bcc L_E7DF                  ; E7DA  90 03
    jsr L_EB07                  ; E7DC  20 07 EB

L_E7DF:
    lda #$0A                    ; E7DF  A9 0A
    sta $0538,x                 ; E7E1  9D 38 05
    ldy $09                     ; E7E4  A4 09
    bne L_E7F0                  ; E7E6  D0 08
    lda $0598,x                 ; E7E8  BD 98 05
    and #$08                    ; E7EB  29 08
    beq L_E7F0                  ; E7ED  F0 01
    iny                         ; E7EF  C8

L_E7F0:
    tya                         ; E7F0  98
    asl a                       ; E7F1  0A
    tay                         ; E7F2  A8
    lda D_E823,y                ; E7F3  B9 23 E8
    sta $0A                     ; E7F6  85 0A
    lda D_E824,y                ; E7F8  B9 24 E8
    sta $0B                     ; E7FB  85 0B
    ldy $0568,x                 ; E7FD  BC 68 05
    lda ($0A),y                 ; E800  B1 0A
    sta $030A,x                 ; E802  9D 0A 03

L_E805:
    rts                         ; E805  60


L_E806:
    jsr L_E8A7                  ; E806  20 A7 E8

L_E809:
    lda #$00                    ; E809  A9 00
    sta $04B8,x                 ; E80B  9D B8 04

L_E80E:
    lda #$00                    ; E80E  A9 00
    sta $030A,x                 ; E810  9D 0A 03
    rts                         ; E813  60

    .byte $20,$0E,$E8,$4C,$8E,$E7

L_E81A:
    ldy $04B8,x                 ; E81A  BC B8 04
    beq L_E80E                  ; E81D  F0 EF
    sta $04B8,x                 ; E81F  9D B8 04
    rts                         ; E822  60

D_E823:
    .byte $2B
D_E824:
    .byte $E8,$2E,$E8,$32,$E8,$35,$E8,$38,$39,$3A,$37,$35,$36,$37,$9D,$9E
    .byte $9F,$36,$37

L_E837:
    lda $41                     ; E837  A5 41
    beq L_E84A                  ; E839  F0 0F
    jsr L_E8E2                  ; E83B  20 E2 E8
    cmp #$E8                    ; E83E  C9 E8
    bcs L_E858                  ; E840  B0 16

L_E842:
    jsr L_E90A                  ; E842  20 0A E9
    cmp #$08                    ; E845  C9 08
    bcc L_E858                  ; E847  90 0F

L_E849:
    rts                         ; E849  60


L_E84A:
    jsr L_E900                  ; E84A  20 00 E9
    cmp #$08                    ; E84D  C9 08
    bcc L_E858                  ; E84F  90 07

L_E851:
    jsr L_E8EC                  ; E851  20 EC E8
    cmp #$E8                    ; E854  C9 E8
    bcc L_E849                  ; E856  90 F1

L_E858:
    jmp L_E809                  ; E858  4C 09 E8


L_E85B:
    lda $41                     ; E85B  A5 41
    beq L_E86F                  ; E85D  F0 10
    ldy #$00                    ; E85F  A0 00
    lda $04E8,x                 ; E861  BD E8 04
    clc                         ; E864  18
    adc $68                     ; E865  65 68
    jsr L_E883                  ; E867  20 83 E8
    beq L_E858                  ; E86A  F0 EC
    jmp L_E842                  ; E86C  4C 42 E8


L_E86F:
    jsr L_E900                  ; E86F  20 00 E9
    cmp #$08                    ; E872  C9 08
    bcc L_E880                  ; E874  90 0A
    ldy #$00                    ; E876  A0 00
    lda $04E8,x                 ; E878  BD E8 04
    jsr L_E883                  ; E87B  20 83 E8
    bne L_E8B8                  ; E87E  D0 38

L_E880:
    jmp L_E809                  ; E880  4C 09 E8


L_E883:
    bpl L_E886                  ; E883  10 01
    dey                         ; E885  88

L_E886:
    sty $01                     ; E886  84 01
    sta $00                     ; E888  85 00
    lda $04C8,x                 ; E88A  BD C8 04
    clc                         ; E88D  18
    adc $04F8,x                 ; E88E  7D F8 04
    sta $04C8,x                 ; E891  9D C8 04
    lda $0324,x                 ; E894  BD 24 03
    adc $00                     ; E897  65 00
    sta $0324,x                 ; E899  9D 24 03
    lda $0568,x                 ; E89C  BD 68 05
    adc $01                     ; E89F  65 01
    sta $0568,x                 ; E8A1  9D 68 05
    cmp #$01                    ; E8A4  C9 01
    rts                         ; E8A6  60


L_E8A7:
    lda $41                     ; E8A7  A5 41
    beq L_E8B9                  ; E8A9  F0 0E
    lda $0324,x                 ; E8AB  BD 24 03
    clc                         ; E8AE  18
    adc $68                     ; E8AF  65 68
    sta $0324,x                 ; E8B1  9D 24 03
    cmp #$E8                    ; E8B4  C9 E8
    bcs L_E880                  ; E8B6  B0 C8

L_E8B8:
    rts                         ; E8B8  60


L_E8B9:
    lda $033E,x                 ; E8B9  BD 3E 03
    sec                         ; E8BC  38
    sbc $68                     ; E8BD  E5 68
    sta $033E,x                 ; E8BF  9D 3E 03
    cmp #$08                    ; E8C2  C9 08
    bcc L_E880                  ; E8C4  90 BA
    rts                         ; E8C6  60

    .byte $20,$42,$E8,$4C,$51,$E8

L_E8CD:
    jsr L_E8D9                  ; E8CD  20 D9 E8

L_E8D0:
    lda #$00                    ; E8D0  A9 00
    sta $04F8,x                 ; E8D2  9D F8 04
    sta $04E8,x                 ; E8D5  9D E8 04
    rts                         ; E8D8  60


L_E8D9:
    lda #$00                    ; E8D9  A9 00
    sta $0518,x                 ; E8DB  9D 18 05
    sta $0508,x                 ; E8DE  9D 08 05
    rts                         ; E8E1  60


L_E8E2:
    jsr L_E8EC                  ; E8E2  20 EC E8
    clc                         ; E8E5  18
    adc $68                     ; E8E6  65 68
    sta $0324,x                 ; E8E8  9D 24 03
    rts                         ; E8EB  60


L_E8EC:
    lda $04C8,x                 ; E8EC  BD C8 04
    clc                         ; E8EF  18
    adc $04F8,x                 ; E8F0  7D F8 04
    sta $04C8,x                 ; E8F3  9D C8 04
    lda $0324,x                 ; E8F6  BD 24 03
    adc $04E8,x                 ; E8F9  7D E8 04
    sta $0324,x                 ; E8FC  9D 24 03
    rts                         ; E8FF  60


L_E900:
    jsr L_E90A                  ; E900  20 0A E9
    sec                         ; E903  38
    sbc $68                     ; E904  E5 68
    sta $033E,x                 ; E906  9D 3E 03
    rts                         ; E909  60


L_E90A:
    lda $04D8,x                 ; E90A  BD D8 04
    clc                         ; E90D  18
    adc $0518,x                 ; E90E  7D 18 05
    sta $04D8,x                 ; E911  9D D8 04
    lda $033E,x                 ; E914  BD 3E 03
    adc $0508,x                 ; E917  7D 08 05
    sta $033E,x                 ; E91A  9D 3E 03
    rts                         ; E91D  60


L_E91E:
    lda #$00                    ; E91E  A9 00
    sec                         ; E920  38
    sbc $0518,x                 ; E921  FD 18 05
    sta $0518,x                 ; E924  9D 18 05
    lda #$00                    ; E927  A9 00
    sbc $0508,x                 ; E929  FD 08 05
    sta $0508,x                 ; E92C  9D 08 05
    rts                         ; E92F  60

    .byte $A9,$00,$38,$FD,$F8,$04,$9D,$F8,$04,$A9,$00,$FD,$E8,$04,$9D,$E8
    .byte $04,$60

L_E942:
    lda $0588,x                 ; E942  BD 88 05
    lsr a                       ; E945  4A
    lsr a                       ; E946  4A
    lsr a                       ; E947  4A
    lsr a                       ; E948  4A
    tay                         ; E949  A8
    cpy #$0A                    ; E94A  C0 0A
    bne L_E95E                  ; E94C  D0 10
    lda #$88                    ; E94E  A9 88
    sta $00                     ; E950  85 00
    lda #$13                    ; E952  A9 13
    sta $01                     ; E954  85 01
    ldy $17                     ; E956  A4 17
    jsr L_C4A8                  ; E958  20 A8 C4
    jmp L_E96A                  ; E95B  4C 6A E9


L_E95E:
    lda D_E9A3,y                ; E95E  B9 A3 E9
    beq L_E96A                  ; E961  F0 07
    sta $00                     ; E963  85 00
    ldy $17                     ; E965  A4 17
    jsr L_C4A0                  ; E967  20 A0 C4

L_E96A:
    ldx $83                     ; E96A  A6 83
    lda $0588,x                 ; E96C  BD 88 05
    and #$0F                    ; E96F  29 0F
    sta $0588,x                 ; E971  9D 88 05

L_E974:
    lda $0528,x                 ; E974  BD 28 05
    cmp #$10                    ; E977  C9 10
    ldy #$10                    ; E979  A0 10
    bcc L_E981                  ; E97B  90 04
    lda $30                     ; E97D  A5 30
    asl a                       ; E97F  0A
    tay                         ; E980  A8

L_E981:
    lda D_E9AD,y                ; E981  B9 AD E9
    sta $08                     ; E984  85 08
    lda D_E9AE,y                ; E986  B9 AE E9
    sta $09                     ; E989  85 09
    lda $0528,x                 ; E98B  BD 28 05
    lsr a                       ; E98E  4A
    tay                         ; E98F  A8
    lda ($08),y                 ; E990  B1 08
    bcs L_E998                  ; E992  B0 04
    lsr a                       ; E994  4A
    lsr a                       ; E995  4A
    lsr a                       ; E996  4A
    lsr a                       ; E997  4A

L_E998:
    and #$0F                    ; E998  29 0F
    cmp $04B8,x                 ; E99A  DD B8 04
    bcc L_E9A2                  ; E99D  90 03
    sta $04B8,x                 ; E99F  9D B8 04

L_E9A2:
    rts                         ; E9A2  60

D_E9A3:
    .byte $00,$01,$03,$05,$0A,$14,$1E,$32,$64,$96
D_E9AD:
    .byte $BF
D_E9AE:
    .word L_C1E9                    ; E9AE
    .word L_CAE9                    ; E9B0
    .word L_C1E9                    ; E9B2
    .byte $E9,$CD,$E9,$D1,$E9,$D4,$E9,$D9,$E9,$BF,$E9,$04,$53,$75,$56,$50
    .byte $44,$44,$43,$33,$20,$43,$45,$53,$33,$43,$33,$43,$54,$30,$22,$24
    .byte $65,$33,$50,$A5,$20,$00,$07,$30,$05,$30,$44,$35,$50,$43,$34,$63
    .byte $40

L_E9E5:
    stx $10                     ; E9E5  86 10
    ldx #$0F                    ; E9E7  A2 0F

L_E9E9:
    lda $04B8,x                 ; E9E9  BD B8 04
    beq L_EA10                  ; E9EC  F0 22
    lda $030A,x                 ; E9EE  BD 0A 03
    beq L_EA10                  ; E9F1  F0 1D
    lda $0528,x                 ; E9F3  BD 28 05
    cmp #$02                    ; E9F6  C9 02
    beq L_EA10                  ; E9F8  F0 16
    cmp #$03                    ; E9FA  C9 03
    beq L_EA10                  ; E9FC  F0 12
    lda $0578,x                 ; E9FE  BD 78 05
    cmp #$F0                    ; EA01  C9 F0
    beq L_EA10                  ; EA03  F0 0B
    jsr L_E974                  ; EA05  20 74 E9
    lda $05A8,x                 ; EA08  BD A8 05
    ora #$80                    ; EA0B  09 80
    sta $05A8,x                 ; EA0D  9D A8 05

L_EA10:
    dex                         ; EA10  CA
    bpl L_E9E9                  ; EA11  10 D6
    ldx $10                     ; EA13  A6 10
    rts                         ; EA15  60


L_EA16:
    stx $10                     ; EA16  86 10
    ldx #$0F                    ; EA18  A2 0F

L_EA1A:
    jsr L_E809                  ; EA1A  20 09 E8
    dex                         ; EA1D  CA
    bpl L_EA1A                  ; EA1E  10 FA
    ldx $10                     ; EA20  A6 10
    rts                         ; EA22  60

    .byte $A9,$00,$A8,$85,$11,$84,$14,$A5,$12,$4A,$29,$03,$85,$00,$A5,$13
    .byte $29,$07,$06,$12,$2A,$06,$12,$2A,$06,$12,$06,$12,$2A,$06,$12,$2A
    .byte $85,$04,$A9,$02,$85,$01,$A5,$00,$85,$02,$20,$64,$EA,$46,$11,$46
    .byte $11,$46,$14,$46,$14,$A5,$04,$18,$69,$04,$85,$04,$C6,$01,$D0,$E6
    .byte $60,$A5,$04,$85,$07,$A9,$01,$85,$06,$A4,$02,$B9,$A7,$EA,$85,$05
    .byte $A5,$06,$4A,$A5,$11,$B0,$02,$A5,$14,$29,$03,$C8,$C0,$04,$B0,$05
    .byte $0A,$0A,$4C,$7E,$EA,$85,$03,$A4,$07,$B9,$80,$06,$25,$05,$05,$03
    .byte $99,$80,$06,$E6,$02,$A5,$02,$29,$03,$85,$02,$D0,$02,$E6,$07,$C6
    .byte $06,$10,$C6,$60,$3F,$CF,$F3,$FC,$A9,$89,$85,$0A,$A9,$09,$D0,$0A

L_EAB3:
    lda #$89                    ; EAB3  A9 89
    bne L_EAB9                  ; EAB5  D0 02
    lda #$08                    ; EAB7  A9 08

L_EAB9:
    sta $0A                     ; EAB9  85 0A
    lda #$06                    ; EABB  A9 06
    sta $0B                     ; EABD  85 0B
    stx $10                     ; EABF  86 10
    jsr L_EDCE                  ; EAC1  20 CE ED
    bne L_EAE7                  ; EAC4  D0 21
    lda #$02                    ; EAC6  A9 02
    sta $0528,x                 ; EAC8  9D 28 05
    jsr L_EE47                  ; EACB  20 47 EE
    lda $0B                     ; EACE  A5 0B
    sta $04B8,x                 ; EAD0  9D B8 04
    lda #$01                    ; EAD3  A9 01
    sta $030A,x                 ; EAD5  9D 0A 03
    lda $0A                     ; EAD8  A5 0A
    sta $0598,x                 ; EADA  9D 98 05
    lda $08                     ; EADD  A5 08
    sta $0324,x                 ; EADF  9D 24 03
    lda $09                     ; EAE2  A5 09
    sta $033E,x                 ; EAE4  9D 3E 03

L_EAE7:
    ldx $10                     ; EAE7  A6 10
    rts                         ; EAE9  60

    .byte $20,$6B,$C1,$A9,$FF,$85,$2A,$A9,$01,$85,$3B,$60,$85,$2A,$A9,$00
    .byte $85,$2B,$4C,$09,$E8,$A9,$01,$D0,$06,$A9,$80,$D0,$02

L_EB07:
    lda #$81                    ; EB07  A9 81
    ora $0598,x                 ; EB09  1D 98 05
    bne L_EB1B                  ; EB0C  D0 0D
    lda #$FE                    ; EB0E  A9 FE
    bne L_EB18                  ; EB10  D0 06

L_EB12:
    lda #$7F                    ; EB12  A9 7F
    bne L_EB18                  ; EB14  D0 02

L_EB16:
    lda #$7E                    ; EB16  A9 7E

L_EB18:
    and $0598,x                 ; EB18  3D 98 05

L_EB1B:
    sta $0598,x                 ; EB1B  9D 98 05
    rts                         ; EB1E  60


L_EB1F:
    clc                         ; EB1F  18
    adc $0324,x                 ; EB20  7D 24 03
    sta $0324,x                 ; EB23  9D 24 03
    rts                         ; EB26  60


L_EB27:
    clc                         ; EB27  18
    adc $033E,x                 ; EB28  7D 3E 03
    sta $033E,x                 ; EB2B  9D 3E 03
    rts                         ; EB2E  60


L_EB2F:
    lda #$00                    ; EB2F  A9 00
    tay                         ; EB31  A8

L_EB32:
    clc                         ; EB32  18
    adc $033E,x                 ; EB33  7D 3E 03
    sta $09                     ; EB36  85 09
    tya                         ; EB38  98
    clc                         ; EB39  18
    adc $0324,x                 ; EB3A  7D 24 03
    sta $08                     ; EB3D  85 08
    rts                         ; EB3F  60


L_EB40:
    lda #$10                    ; EB40  A9 10

L_EB42:
    clc                         ; EB42  18
    adc $04F8,x                 ; EB43  7D F8 04
    sta $04F8,x                 ; EB46  9D F8 04
    lda $04E8,x                 ; EB49  BD E8 04
    adc #$00                    ; EB4C  69 00
    sta $04E8,x                 ; EB4E  9D E8 04
    rts                         ; EB51  60

    .byte $85,$0A,$A9,$00,$A8

L_EB57:
    sty $08                     ; EB57  84 08
    sta $09                     ; EB59  85 09
    txa                         ; EB5B  8A
    tay                         ; EB5C  A8
    jsr L_EDCE                  ; EB5D  20 CE ED
    bne L_EB83                  ; EB60  D0 21
    lda $0A                     ; EB62  A5 0A
    sta $0528,x                 ; EB64  9D 28 05
    jsr L_EE47                  ; EB67  20 47 EE
    lda $0324,y                 ; EB6A  B9 24 03
    clc                         ; EB6D  18
    adc $08                     ; EB6E  65 08
    sta $0324,x                 ; EB70  9D 24 03
    lda $033E,y                 ; EB73  B9 3E 03
    clc                         ; EB76  18
    adc $09                     ; EB77  65 09
    sta $033E,x                 ; EB79  9D 3E 03
    txa                         ; EB7C  8A
    tay                         ; EB7D  A8
    ldx $83                     ; EB7E  A6 83
    lda #$00                    ; EB80  A9 00
    rts                         ; EB82  60


L_EB83:
    ldx $83                     ; EB83  A6 83
    lda #$01                    ; EB85  A9 01
    rts                         ; EB87  60


L_EB88:
    lda #$04                    ; EB88  A9 04

L_EB8A:
    sta $01                     ; EB8A  85 01
    lda $FC                     ; EB8C  A5 FC
    and #$0F                    ; EB8E  29 0F
    ora #$F0                    ; EB90  09 F0
    sta $00                     ; EB92  85 00
    clc                         ; EB94  18
    adc $0324,x                 ; EB95  7D 24 03
    and #$F0                    ; EB98  29 F0
    sec                         ; EB9A  38
    sbc $00                     ; EB9B  E5 00
    clc                         ; EB9D  18
    adc $01                     ; EB9E  65 01
    sta $0324,x                 ; EBA0  9D 24 03
    rts                         ; EBA3  60

    .byte $20,$08,$EC,$4C,$AD,$EB

L_EBAA:
    jsr L_EBB5                  ; EBAA  20 B5 EB
    bcc L_EBB4                  ; EBAD  90 05
    lda #$01                    ; EBAF  A9 01
    sta $0538,x                 ; EBB1  9D 38 05

L_EBB4:
    rts                         ; EBB4  60


L_EBB5:
    sta $10                     ; EBB5  85 10
    lda $0324,x                 ; EBB7  BD 24 03
    sec                         ; EBBA  38
    sbc #$0C                    ; EBBB  E9 0C
    bcc L_EC23                  ; EBBD  90 64
    tay                         ; EBBF  A8
    lda $033E,x                 ; EBC0  BD 3E 03
    sec                         ; EBC3  38
    sbc #$0C                    ; EBC4  E9 0C
    bcc L_EC23                  ; EBC6  90 5B
    jsr L_C193                  ; EBC8  20 93 C1
    ldx $83                     ; EBCB  A6 83
    rts                         ; EBCD  60

    .byte $84,$07,$48,$20,$B7,$EB,$68,$B0,$30,$85,$10,$A5,$07,$D0,$07,$A9
    .byte $00,$A0,$0F,$20,$26,$EA,$BD,$24,$03,$18,$69,$14,$B0,$37,$A8,$BD
    .byte $3E,$03,$38,$E9,$0C,$90,$2E,$20,$93,$C1,$B0,$0B,$A5,$07,$D0,$07
    .byte $A9,$01,$A0,$01,$20,$26,$EA,$A6,$83,$60,$09,$80,$85,$10,$BD,$24
    .byte $03,$38,$E9,$04,$90,$0F,$A8,$BD,$3E,$03,$38,$E9,$04,$90,$06,$20
    .byte $A6,$C1,$A6,$83,$60

L_EC23:
    clc                         ; EC23  18
    ldx $83                     ; EC24  A6 83
    rts                         ; EC26  60


L_EC27:
    ldy #$00                    ; EC27  A0 00
    lda #$00                    ; EC29  A9 00
    jsr L_EC35                  ; EC2B  20 35 EC
    jmp L_E08A                  ; EC2E  4C 8A E0


L_EC31:
    ldy #$00                    ; EC31  A0 00

L_EC33:
    lda #$00                    ; EC33  A9 00

L_EC35:
    clc                         ; EC35  18
    adc $033E,x                 ; EC36  7D 3E 03
    sta $13                     ; EC39  85 13
    tya                         ; EC3B  98
    clc                         ; EC3C  18
    adc $0324,x                 ; EC3D  7D 24 03
    bcs L_EC46                  ; EC40  B0 04
    tay                         ; EC42  A8
    jmp L_E0BD                  ; EC43  4C BD E0


L_EC46:
    lda #$00                    ; EC46  A9 00
    rts                         ; EC48  60

    .byte $A0,$00

L_EC4B:
    lda $0324,x                 ; EC4B  BD 24 03
    sta $01                     ; EC4E  85 01
    lda $05B8,x                 ; EC50  BD B8 05
    sta $03                     ; EC53  85 03
    lda $04E8,x                 ; EC55  BD E8 04
    sta $04                     ; EC58  85 04
    lda $04F8,x                 ; EC5A  BD F8 04
    sta $05                     ; EC5D  85 05
    jsr L_EC93                  ; EC5F  20 93 EC
    lda $00                     ; EC62  A5 00
    sta $04E8,x                 ; EC64  9D E8 04
    lda $01                     ; EC67  A5 01
    sta $04F8,x                 ; EC69  9D F8 04
    rts                         ; EC6C  60

    .byte $A0,$00

L_EC6F:
    lda $033E,x                 ; EC6F  BD 3E 03
    sta $01                     ; EC72  85 01
    lda $05C8,x                 ; EC74  BD C8 05
    sta $03                     ; EC77  85 03
    lda $0508,x                 ; EC79  BD 08 05
    sta $04                     ; EC7C  85 04
    lda $0518,x                 ; EC7E  BD 18 05
    sta $05                     ; EC81  85 05
    jsr L_EC93                  ; EC83  20 93 EC
    lda $00                     ; EC86  A5 00
    sta $0508,x                 ; EC88  9D 08 05
    lda $01                     ; EC8B  A5 01
    sta $0518,x                 ; EC8D  9D 18 05
    rts                         ; EC90  60

    .byte $A0,$00

L_EC93:
    lda $01                     ; EC93  A5 01
    sec                         ; EC95  38
    sbc $03                     ; EC96  E5 03
    sta $01                     ; EC98  85 01
    lda #$00                    ; EC9A  A9 00
    sbc #$00                    ; EC9C  E9 00
    sta $00                     ; EC9E  85 00
    sta $07                     ; ECA0  85 07
    tya                         ; ECA2  98
    beq L_ECB9                  ; ECA3  F0 14
    bmi L_ECB0                  ; ECA5  30 09

L_ECA7:
    asl $01                     ; ECA7  06 01
    rol $00                     ; ECA9  26 00
    dey                         ; ECAB  88
    bne L_ECA7                  ; ECAC  D0 F9
    beq L_ECB9                  ; ECAE  F0 09

L_ECB0:
    lsr $07                     ; ECB0  46 07
    ror $00                     ; ECB2  66 00
    ror $01                     ; ECB4  66 01
    iny                         ; ECB6  C8
    bne L_ECB0                  ; ECB7  D0 F7

L_ECB9:
    lda $05                     ; ECB9  A5 05
    sec                         ; ECBB  38
    sbc $01                     ; ECBC  E5 01
    sta $01                     ; ECBE  85 01
    lda $04                     ; ECC0  A5 04
    sbc $00                     ; ECC2  E5 00
    sta $00                     ; ECC4  85 00
    rts                         ; ECC6  60


L_ECC7:
    jsr L_ECF5                  ; ECC7  20 F5 EC
    tya                         ; ECCA  98
    eor #$01                    ; ECCB  49 01
    sta $0C                     ; ECCD  85 0C
    lda $08                     ; ECCF  A5 08
    sta $0A                     ; ECD1  85 0A
    lda $09                     ; ECD3  A5 09
    sta $0B                     ; ECD5  85 0B
    jsr L_ED0E                  ; ECD7  20 0E ED
    tya                         ; ECDA  98
    eor #$01                    ; ECDB  49 01
    cmp $0C                     ; ECDD  C5 0C
    bne L_ECE4                  ; ECDF  D0 03
    tya                         ; ECE1  98
    sta $0C                     ; ECE2  85 0C

L_ECE4:
    tax                         ; ECE4  AA
    tay                         ; ECE5  A8
    lda $08,x                   ; ECE6  B5 08
    ldx $0C                     ; ECE8  A6 0C
    cmp $0A,x                   ; ECEA  D5 0A
    bcc L_ECF2                  ; ECEC  90 04
    ldy $0C                     ; ECEE  A4 0C
    lda $0A,x                   ; ECF0  B5 0A

L_ECF2:
    ldx $83                     ; ECF2  A6 83
    rts                         ; ECF4  60


L_ECF5:
    lda $0334                   ; ECF5  AD 34 03
    sec                         ; ECF8  38
    sbc $033E,x                 ; ECF9  FD 3E 03
    bcs L_ED02                  ; ECFC  B0 04
    eor #$FF                    ; ECFE  49 FF
    adc #$01                    ; ED00  69 01

L_ED02:
    sta $08                     ; ED02  85 08
    lda $0335                   ; ED04  AD 35 03
    sec                         ; ED07  38
    sbc $033E,x                 ; ED08  FD 3E 03
    jmp L_ED24                  ; ED0B  4C 24 ED


L_ED0E:
    lda $031A                   ; ED0E  AD 1A 03
    sec                         ; ED11  38
    sbc $0324,x                 ; ED12  FD 24 03
    bcs L_ED1B                  ; ED15  B0 04
    eor #$FF                    ; ED17  49 FF
    adc #$01                    ; ED19  69 01

L_ED1B:
    sta $08                     ; ED1B  85 08
    lda $031B                   ; ED1D  AD 1B 03
    sec                         ; ED20  38
    sbc $0324,x                 ; ED21  FD 24 03

L_ED24:
    bcs L_ED2A                  ; ED24  B0 04
    eor #$FF                    ; ED26  49 FF
    adc #$01                    ; ED28  69 01

L_ED2A:
    sta $09                     ; ED2A  85 09
    ldy #$FE                    ; ED2C  A0 FE
    lda $90                     ; ED2E  A5 90
    cmp #$01                    ; ED30  C9 01
    beq L_ED36                  ; ED32  F0 02
    sty $08                     ; ED34  84 08

L_ED36:
    ldy #$FF                    ; ED36  A0 FF
    lda $91                     ; ED38  A5 91
    cmp #$01                    ; ED3A  C9 01
    beq L_ED40                  ; ED3C  F0 02
    sty $09                     ; ED3E  84 09

L_ED40:
    lda $09                     ; ED40  A5 09
    ldy #$01                    ; ED42  A0 01
    cmp $08                     ; ED44  C5 08
    bcc L_ED4B                  ; ED46  90 03
    dey                         ; ED48  88
    lda $08                     ; ED49  A5 08

L_ED4B:
    rts                         ; ED4B  60

    .byte $A5,$09,$A0,$06,$D9,$5F,$ED,$90,$08,$88,$30,$02,$B0,$F6,$A9,$00
    .byte $60,$98,$60,$FF,$94,$8C,$84,$7C,$74,$6C

L_ED66:
    lda $05C8,x                 ; ED66  BD C8 05
    clc                         ; ED69  18
    adc $05E8,x                 ; ED6A  7D E8 05
    sta $05C8,x                 ; ED6D  9D C8 05
    lda $05D8,x                 ; ED70  BD D8 05
    adc $0558,x                 ; ED73  7D 58 05
    sta $05D8,x                 ; ED76  9D D8 05
    lda $04C8,x                 ; ED79  BD C8 04
    clc                         ; ED7C  18
    adc $04F8,x                 ; ED7D  7D F8 04
    sta $04C8,x                 ; ED80  9D C8 04
    lda $05B8,x                 ; ED83  BD B8 05
    adc $04E8,x                 ; ED86  7D E8 04
    sta $05B8,x                 ; ED89  9D B8 05
    cmp #$F0                    ; ED8C  C9 F0
    bcs L_ED9A                  ; ED8E  B0 0A
    clc                         ; ED90  18
    adc $05D8,x                 ; ED91  7D D8 05
    sta $0324,x                 ; ED94  9D 24 03
    jmp L_E842                  ; ED97  4C 42 E8


L_ED9A:
    jmp L_E809                  ; ED9A  4C 09 E8

    .byte $BD,$3E,$03,$20,$4E,$ED,$0A,$A8,$B9,$BC,$ED,$9D,$18,$05,$B9,$BD
    .byte $ED,$9D,$08,$05,$A9,$00,$9D,$F8,$04,$A9,$01,$9D,$E8,$04,$60,$AA
    .byte $00,$71,$00,$38,$00,$00,$00,$C8,$FF,$8F,$FF,$56,$FF

L_EDCA:
    ldx #$06                    ; EDCA  A2 06
    bne L_EDD0                  ; EDCC  D0 02

L_EDCE:
    ldx #$0F                    ; EDCE  A2 0F

L_EDD0:
    lda $04B8,x                 ; EDD0  BD B8 04
    beq L_EDD8                  ; EDD3  F0 03
    dex                         ; EDD5  CA
    bpl L_EDD0                  ; EDD6  10 F8

L_EDD8:
    rts                         ; EDD8  60


L_EDD9:
    ldx #$0F                    ; EDD9  A2 0F

L_EDDB:
    lda $0528,x                 ; EDDB  BD 28 05
    cmp #$01                    ; EDDE  C9 01
    beq L_EDD8                  ; EDE0  F0 F6
    dex                         ; EDE2  CA
    bpl L_EDDB                  ; EDE3  10 F6
    ldx #$00                    ; EDE5  A2 00
    rts                         ; EDE7  60

    .byte $A2,$0F,$20,$FC,$ED,$CA,$10,$FA,$60

L_EDF1:
    lda #$00                    ; EDF1  A9 00
    sta $030A,x                 ; EDF3  9D 0A 03
    beq L_EE19                  ; EDF6  F0 21
    lda #$00                    ; EDF8  A9 00
    beq L_EE3A                  ; EDFA  F0 3E
    lda #$00                    ; EDFC  A9 00
    sta $04B8,x                 ; EDFE  9D B8 04
    sta $0578,x                 ; EE01  9D 78 05
    sta $0528,x                 ; EE04  9D 28 05
    sta $030A,x                 ; EE07  9D 0A 03

L_EE0A:
    sta $05A8,x                 ; EE0A  9D A8 05
    sta $0324,x                 ; EE0D  9D 24 03
    sta $033E,x                 ; EE10  9D 3E 03
    sta $04C8,x                 ; EE13  9D C8 04
    sta $04D8,x                 ; EE16  9D D8 04

L_EE19:
    sta $0358,x                 ; EE19  9D 58 03
    sta $04F8,x                 ; EE1C  9D F8 04
    sta $0518,x                 ; EE1F  9D 18 05
    sta $04E8,x                 ; EE22  9D E8 04
    sta $0508,x                 ; EE25  9D 08 05
    sta $0538,x                 ; EE28  9D 38 05
    sta $0548,x                 ; EE2B  9D 48 05
    sta $0558,x                 ; EE2E  9D 58 05
    sta $0568,x                 ; EE31  9D 68 05
    sta $0598,x                 ; EE34  9D 98 05
    sta $0588,x                 ; EE37  9D 88 05

L_EE3A:
    sta $05B8,x                 ; EE3A  9D B8 05
    sta $05C8,x                 ; EE3D  9D C8 05
    sta $05D8,x                 ; EE40  9D D8 05
    sta $05E8,x                 ; EE43  9D E8 05
    rts                         ; EE46  60


L_EE47:
    lda #$01                    ; EE47  A9 01
    sta $04B8,x                 ; EE49  9D B8 04
    sta $030A,x                 ; EE4C  9D 0A 03
    lda #$00                    ; EE4F  A9 00
    jsr L_EE0A                  ; EE51  20 0A EE
    tya                         ; EE54  98
    pha                         ; EE55  48
    lda $0528,x                 ; EE56  BD 28 05
    cmp #$10                    ; EE59  C9 10
    ldy #$10                    ; EE5B  A0 10
    bcc L_EE63                  ; EE5D  90 04
    lda $30                     ; EE5F  A5 30
    asl a                       ; EE61  0A
    tay                         ; EE62  A8

L_EE63:
    lda D_EE8D,y                ; EE63  B9 8D EE
    sta $8C                     ; EE66  85 8C
    lda D_EE8E,y                ; EE68  B9 8E EE
    sta $8D                     ; EE6B  85 8D
    lda $0528,x                 ; EE6D  BD 28 05
    asl a                       ; EE70  0A
    asl a                       ; EE71  0A
    tay                         ; EE72  A8
    lda ($8C),y                 ; EE73  B1 8C
    sta $0598,x                 ; EE75  9D 98 05
    iny                         ; EE78  C8
    lda ($8C),y                 ; EE79  B1 8C
    sta $0588,x                 ; EE7B  9D 88 05
    iny                         ; EE7E  C8
    lda ($8C),y                 ; EE7F  B1 8C
    sta $0578,x                 ; EE81  9D 78 05
    iny                         ; EE84  C8
    lda ($8C),y                 ; EE85  B1 8C
    sta $0548,x                 ; EE87  9D 48 05
    pla                         ; EE8A  68
    tay                         ; EE8B  A8
    rts                         ; EE8C  60

D_EE8D:
    .byte $9F
D_EE8E:
    .byte $EE,$AB,$EE,$EF,$EE,$AB,$EE,$07,$EF,$23,$EF,$37,$EF,$5B,$EF,$9F
    .byte $EE,$82,$22,$01,$00,$80,$00,$01,$00,$0F,$32,$F0,$00,$0B,$32,$01
    .byte $00,$8F,$22,$08,$00,$83,$10,$01,$00,$83,$30,$01,$00,$8F,$30,$08
    .byte $00,$0F,$52,$F1,$00,$00,$00,$01,$00,$0F,$42,$F0,$00,$8A,$05,$01
    .byte $00,$83,$42,$01,$00,$00,$00,$01,$00,$0E,$33,$0A,$00,$80,$01,$01
    .byte $00,$0F,$42,$10,$00,$0C,$82,$20,$00,$89,$00,$01,$00,$8D,$02,$01
    .byte $00,$2F,$22,$05,$00,$81,$03,$01,$00,$9F,$35,$04,$00,$9F,$05,$01
    .byte $00,$13,$16,$01,$00,$13,$16,$01,$00,$13,$36,$01,$00,$13,$16,$01
    .byte $00,$89,$00,$F1,$00,$81,$00,$F1,$00,$8F,$13,$02,$01,$8F,$02,$01
    .byte $00,$0A,$15,$01,$00,$03,$30,$01,$00,$03,$30,$01,$00,$81,$00,$F1
    .byte $00,$C0,$04,$F0,$00,$80,$02,$F0,$00,$81,$00,$F0,$00,$8F,$31,$05
    .byte $00,$8D,$83,$F1,$02,$0E,$52,$F1,$00,$81,$00,$F0,$00,$81,$02,$F1
    .byte $00,$85,$79,$F0,$00,$81,$00,$F0,$00,$8D,$93,$20,$00,$02,$20,$01
    .byte $00,$0A,$12,$01,$00,$81,$0F,$F0,$00,$81,$0F,$F0,$00,$81,$0F,$F0
    .byte $00,$04,$9D,$01,$02,$80,$05,$01,$00,$80,$0A,$F0,$00,$8D,$0F,$10
    .byte $00,$0C,$0F,$10,$00,$81,$00,$F0,$00,$6E,$0C,$03,$00,$6E,$0C,$03
    .byte $00,$0C,$93,$20,$00,$8F,$72,$08,$00,$89,$00,$01,$00,$04,$78,$01
    .byte $02,$06,$22,$01,$01,$06,$42,$01,$01,$02,$22,$01,$00,$06,$33,$01
    .byte $01,$06,$62,$10,$01,$04,$A7,$01,$03
D_EFB7:
    .word L_EFC7                    ; EFB7
    .word L_EFD4                    ; EFB9
    .word L_F007                    ; EFBB
    .word L_F048                    ; EFBD
    .word L_F06D                    ; EFBF
    .word L_E74B                    ; EFC1
    .word L_E7B0                    ; EFC3
    .word L_E806                    ; EFC5

L_EFC7:
    lda #$08                    ; EFC7  A9 08
    sta $05B8,x                 ; EFC9  9D B8 05
    lda #$50                    ; EFCC  A9 50

L_EFCE:
    sta $0538,x                 ; EFCE  9D 38 05
    jmp L_E78E                  ; EFD1  4C 8E E7


L_EFD4:
    lda $8E                     ; EFD4  A5 8E
    beq L_EFEC                  ; EFD6  F0 14
    dec $0538,x                 ; EFD8  DE 38 05
    bne L_EFEC                  ; EFDB  D0 0F
    jsr L_EFFC                  ; EFDD  20 FC EF
    bcs L_EFEC                  ; EFE0  B0 0A
    lda $0568,x                 ; EFE2  BD 68 05
    cmp #$02                    ; EFE5  C9 02
    bcs L_EFED                  ; EFE7  B0 04
    inc $0568,x                 ; EFE9  FE 68 05

L_EFEC:
    rts                         ; EFEC  60


L_EFED:
    lda $05B8,x                 ; EFED  BD B8 05
    sta $0578,x                 ; EFF0  9D 78 05
    lda #$04                    ; EFF3  A9 04
    sta $0558,x                 ; EFF5  9D 58 05
    lda #$40                    ; EFF8  A9 40
    bne L_EFCE                  ; EFFA  D0 D2

L_EFFC:
    lda #$06                    ; EFFC  A9 06
    sta $0538,x                 ; EFFE  9D 38 05
    lda $0568,x                 ; F001  BD 68 05
    jmp L_EBAA                  ; F004  4C AA EB


L_F007:
    lda $0558,x                 ; F007  BD 58 05
    beq L_F02D                  ; F00A  F0 21
    dec $0558,x                 ; F00C  DE 58 05
    bne L_F02D                  ; F00F  D0 1C
    lda #$02                    ; F011  A9 02
    sta $16                     ; F013  85 16

L_F015:
    ldy $16                     ; F015  A4 16
    lda D_F042,y                ; F017  B9 42 F0
    ldy #$08                    ; F01A  A0 08
    jsr L_EB32                  ; F01C  20 32 EB
    ldy $16                     ; F01F  A4 16
    lda D_F045,y                ; F021  B9 45 F0
    ldy #$07                    ; F024  A0 07
    jsr L_F2BF                  ; F026  20 BF F2
    dec $16                     ; F029  C6 16
    bpl L_F015                  ; F02B  10 E8

L_F02D:
    dec $0538,x                 ; F02D  DE 38 05
    bne L_EFEC                  ; F030  D0 BA
    lda $0578,x                 ; F032  BD 78 05
    sta $05B8,x                 ; F035  9D B8 05
    lda #$F1                    ; F038  A9 F1
    sta $0578,x                 ; F03A  9D 78 05
    lda #$06                    ; F03D  A9 06
    jmp L_EFCE                  ; F03F  4C CE EF

D_F042:
    .byte $F8,$00,$08
D_F045:
    .byte $48,$46,$44

L_F048:
    dec $0538,x                 ; F048  DE 38 05
    bne L_EFEC                  ; F04B  D0 9F
    jsr L_EFFC                  ; F04D  20 FC EF
    bcs L_F05A                  ; F050  B0 08
    lda $0568,x                 ; F052  BD 68 05
    beq L_F05B                  ; F055  F0 04
    dec $0568,x                 ; F057  DE 68 05

L_F05A:
    rts                         ; F05A  60


L_F05B:
    lda $2F                     ; F05B  A5 2F
    cmp #$02                    ; F05D  C9 02
    lda #$C0                    ; F05F  A9 C0
    bcc L_F065                  ; F061  90 02
    lda #$60                    ; F063  A9 60

L_F065:
    sta $0538,x                 ; F065  9D 38 05
    lda #$02                    ; F068  A9 02
    jmp L_E81A                  ; F06A  4C 1A E8


L_F06D:
    lda #$05                    ; F06D  A9 05
    jsr L_EBB5                  ; F06F  20 B5 EB
    bcs L_F05A                  ; F072  B0 E6
    jmp L_E78E                  ; F074  4C 8E E7

D_F077:
    .word D_F085                    ; F077
    .word L_F08A                    ; F079
    .word L_F0B0                    ; F07B
    .word L_F0B1                    ; F07D
    .word L_E74B                    ; F07F
    .word L_E7B0                    ; F081
    .word L_E806                    ; F083
D_F085:
    .word L0_80A9                   ; F085
    .byte $4C,$CE,$EF

L_F08A:
    dec $0538,x                 ; F08A  DE 38 05
    bne L_F0B0                  ; F08D  D0 21
    lda #$04                    ; F08F  A9 04
    sta $0538,x                 ; F091  9D 38 05
    lda $0568,x                 ; F094  BD 68 05
    clc                         ; F097  18
    adc #$03                    ; F098  69 03
    jsr L_EBAA                  ; F09A  20 AA EB
    bcs L_F0B0                  ; F09D  B0 11
    inc $0568,x                 ; F09F  FE 68 05
    lda $0568,x                 ; F0A2  BD 68 05
    cmp #$02                    ; F0A5  C9 02
    bcc L_F0B0                  ; F0A7  90 07
    lda #$0A                    ; F0A9  A9 0A
    sta $0578,x                 ; F0AB  9D 78 05
    bcs L_F0BA                  ; F0AE  B0 0A

L_F0B0:
    rts                         ; F0B0  60


L_F0B1:
    lda #$05                    ; F0B1  A9 05
    jsr L_EBB5                  ; F0B3  20 B5 EB
    bcs L_F0B0                  ; F0B6  B0 F8
    inc $87                     ; F0B8  E6 87

L_F0BA:
    jmp L_E78E                  ; F0BA  4C 8E E7

D_F0BD:
    .word L_F0C9                    ; F0BD
    .word L_F0DB                    ; F0BF
    .word L_F0EC                    ; F0C1
    .word L_E74B                    ; F0C3
    .word L_E7B0                    ; F0C5
    .word L_E806                    ; F0C7

L_F0C9:
    lda #$BD                    ; F0C9  A9 BD
    sta $030A,x                 ; F0CB  9D 0A 03
    lda $05A8,x                 ; F0CE  BD A8 05
    asl a                       ; F0D1  0A
    asl a                       ; F0D2  0A
    asl a                       ; F0D3  0A
    asl a                       ; F0D4  0A
    clc                         ; F0D5  18
    adc #$01                    ; F0D6  69 01
    jmp L_EFCE                  ; F0D8  4C CE EF


L_F0DB:
    jsr L_E8A7                  ; F0DB  20 A7 E8
    dec $0538,x                 ; F0DE  DE 38 05
    bne L_F0EB                  ; F0E1  D0 08
    inc $030A,x                 ; F0E3  FE 0A 03

L_F0E6:
    lda #$05                    ; F0E6  A9 05
    jmp L_EFCE                  ; F0E8  4C CE EF


L_F0EB:
    rts                         ; F0EB  60


L_F0EC:
    jsr L_E8A7                  ; F0EC  20 A7 E8
    dec $0538,x                 ; F0EF  DE 38 05
    bne L_F0EB                  ; F0F2  D0 F7
    lda #$0C                    ; F0F4  A9 0C
    jsr L_C16B                  ; F0F6  20 6B C1
    lda #$0F                    ; F0F9  A9 0F
    sta $0A                     ; F0FB  85 0A
    lda #$F0                    ; F0FD  A9 F0
    ldy #$FC                    ; F0FF  A0 FC
    jsr L_EB57                  ; F101  20 57 EB
    lda $05A8,x                 ; F104  BD A8 05
    asl a                       ; F107  0A
    asl a                       ; F108  0A
    asl a                       ; F109  0A
    asl a                       ; F10A  0A
    clc                         ; F10B  18
    adc #$30                    ; F10C  69 30
    sta $0538,x                 ; F10E  9D 38 05
    dec $030A,x                 ; F111  DE 0A 03
    lda #$02                    ; F114  A9 02
    jmp L_E81A                  ; F116  4C 1A E8

D_F119:
    .word L_F11F                    ; F119
    .word L_F131                    ; F11B
    .word L_E809                    ; F11D

L_F11F:
    lda #$FD                    ; F11F  A9 FD
    sta $0508,x                 ; F121  9D 08 05
    lda #$80                    ; F124  A9 80
    sta $0518,x                 ; F126  9D 18 05
    lda #$1F                    ; F129  A9 1F
    sta $030A,x                 ; F12B  9D 0A 03

L_F12E:
    jmp L_E78E                  ; F12E  4C 8E E7


L_F131:
    lda $033E,x                 ; F131  BD 3E 03
    cmp #$F0                    ; F134  C9 F0
    bcs L_F12E                  ; F136  B0 F6
    jmp L_E837                  ; F138  4C 37 E8

D_F13B:
    .word D_F147                    ; F13B
    .word L_F14C                    ; F13D
    .word L_F183                    ; F13F
    .word L_E74B                    ; F141
    .word L_E7B0                    ; F143
    .word L_E806                    ; F145
D_F147:
    .word L0_80A9                   ; F147
    .byte $4C,$CE,$EF

L_F14C:
    lda #$4B                    ; F14C  A9 4B
    sta $030A,x                 ; F14E  9D 0A 03
    lda $0538,x                 ; F151  BD 38 05
    asl a                       ; F154  0A
    asl a                       ; F155  0A
    asl a                       ; F156  0A
    asl a                       ; F157  0A
    lda #$08                    ; F158  A9 08
    bcc L_F15E                  ; F15A  90 02
    lda #$00                    ; F15C  A9 00

L_F15E:
    sta $0358,x                 ; F15E  9D 58 03
    jsr L_E8A7                  ; F161  20 A7 E8
    dec $0538,x                 ; F164  DE 38 05
    bne L_F175                  ; F167  D0 0C
    lda $0324,x                 ; F169  BD 24 03
    cmp #$B8                    ; F16C  C9 B8
    bcs L_F176                  ; F16E  B0 06
    lda #$10                    ; F170  A9 10
    sta $0538,x                 ; F172  9D 38 05

L_F175:
    rts                         ; F175  60


L_F176:
    jsr L_EB16                  ; F176  20 16 EB
    lda #$10                    ; F179  A9 10
    sta $0558,x                 ; F17B  9D 58 05
    lda #$30                    ; F17E  A9 30
    jmp L_EFCE                  ; F180  4C CE EF


L_F183:
    lda #$4C                    ; F183  A9 4C
    sta $030A,x                 ; F185  9D 0A 03
    lda #$00                    ; F188  A9 00
    ldy $05B8,x                 ; F18A  BC B8 05
    beq L_F194                  ; F18D  F0 05
    dec $05B8,x                 ; F18F  DE B8 05
    lda #$08                    ; F192  A9 08

L_F194:
    sta $0358,x                 ; F194  9D 58 03
    dec $0538,x                 ; F197  DE 38 05
    beq L_F1B4                  ; F19A  F0 18
    dec $0558,x                 ; F19C  DE 58 05
    bne L_F1B1                  ; F19F  D0 10
    lda #$07                    ; F1A1  A9 07
    sta $05B8,x                 ; F1A3  9D B8 05
    lda #$0B                    ; F1A6  A9 0B
    sta $0A                     ; F1A8  85 0A
    ldy #$E8                    ; F1AA  A0 E8
    lda #$05                    ; F1AC  A9 05
    jsr L_EB57                  ; F1AE  20 57 EB

L_F1B1:
    jmp L_E8A7                  ; F1B1  4C A7 E8


L_F1B4:
    jsr L_E8A7                  ; F1B4  20 A7 E8
    lda #$C0                    ; F1B7  A9 C0
    sta $0538,x                 ; F1B9  9D 38 05
    jsr L_EB07                  ; F1BC  20 07 EB
    lda #$02                    ; F1BF  A9 02
    jmp L_E81A                  ; F1C1  4C 1A E8

D_F1C4:
    .word L_F1D6                    ; F1C4
    .word L_F237                    ; F1C6
    .word L_F26E                    ; F1C8
    .word L_E74B                    ; F1CA
    .word L_E7B0                    ; F1CC
    .word L_E806                    ; F1CE
    .word L_E752                    ; F1D0
    .word L_E7B0                    ; F1D2
    .word L_E806                    ; F1D4

L_F1D6:
    lda #$8A                    ; F1D6  A9 8A
    ldy $05A8,x                 ; F1D8  BC A8 05
    beq L_F1DF                  ; F1DB  F0 02
    lda #$80                    ; F1DD  A9 80

L_F1DF:
    sta $0598,x                 ; F1DF  9D 98 05
    lda #$20                    ; F1E2  A9 20
    sta $030A,x                 ; F1E4  9D 0A 03
    lda #$06                    ; F1E7  A9 06
    sta $0358,x                 ; F1E9  9D 58 03
    lda $05A8,x                 ; F1EC  BD A8 05
    bne L_F1F9                  ; F1EF  D0 08
    lda $05B8,x                 ; F1F1  BD B8 05
    beq L_F1F9                  ; F1F4  F0 03
    clc                         ; F1F6  18
    adc #$03                    ; F1F7  69 03

L_F1F9:
    asl a                       ; F1F9  0A
    asl a                       ; F1FA  0A
    tay                         ; F1FB  A8
    lda D_F217,y                ; F1FC  B9 17 F2
    sta $04F8,x                 ; F1FF  9D F8 04
    lda D_F218,y                ; F202  B9 18 F2
    sta $04E8,x                 ; F205  9D E8 04
    lda D_F219,y                ; F208  B9 19 F2
    sta $0518,x                 ; F20B  9D 18 05
    lda D_F21A,y                ; F20E  B9 1A F2
    sta $0508,x                 ; F211  9D 08 05

L_F214:
    jmp L_E78E                  ; F214  4C 8E E7

D_F217:
    .byte $00
D_F218:
    .byte $FB
D_F219:
    .byte $00
D_F21A:
    .byte $00,$00,$FE,$00,$00,$40,$FE,$90,$00,$40,$FE,$70,$FF,$00,$FB,$C0
    .byte $FF,$00,$FB,$80,$FF,$00,$FB,$40,$FF,$00,$FB,$00,$FF

L_F237:
    jsr L_EB40                  ; F237  20 40 EB
    jsr L_E837                  ; F23A  20 37 E8
    lda $05A8,x                 ; F23D  BD A8 05
    bne L_F24F                  ; F240  D0 0D
    lda $04E8,x                 ; F242  BD E8 04
    bpl L_F214                  ; F245  10 CD
    lda $0324,x                 ; F247  BD 24 03
    cmp #$30                    ; F24A  C9 30
    bcc L_F214                  ; F24C  90 C6

L_F24E:
    rts                         ; F24E  60


L_F24F:
    lda $04E8,x                 ; F24F  BD E8 04
    bmi L_F24E                  ; F252  30 FA
    jsr L_ECF5                  ; F254  20 F5 EC
    lda $0324,x                 ; F257  BD 24 03
    cmp $031A,y                 ; F25A  D9 1A 03
    bcc L_F24E                  ; F25D  90 EF
    jsr L_EC31                  ; F25F  20 31 EC
    beq L_F24E                  ; F262  F0 EA
    lda #$24                    ; F264  A9 24
    jsr L_C16B                  ; F266  20 6B C1
    lda #$07                    ; F269  A9 07
    jmp L_E81A                  ; F26B  4C 1A E8


L_F26E:
    jsr L_E837                  ; F26E  20 37 E8
    lda #$03                    ; F271  A9 03
    sta $08                     ; F273  85 08
    txa                         ; F275  8A
    tay                         ; F276  A8

L_F277:
    jsr L_EDCE                  ; F277  20 CE ED
    bne L_F299                  ; F27A  D0 1D
    lda #$0B                    ; F27C  A9 0B
    sta $0528,x                 ; F27E  9D 28 05
    jsr L_EE47                  ; F281  20 47 EE
    lda $033E,y                 ; F284  B9 3E 03
    sta $033E,x                 ; F287  9D 3E 03
    lda $0324,y                 ; F28A  B9 24 03
    sta $0324,x                 ; F28D  9D 24 03
    lda $08                     ; F290  A5 08
    sta $05A8,x                 ; F292  9D A8 05
    dec $08                     ; F295  C6 08
    bne L_F277                  ; F297  D0 DE

L_F299:
    ldx $83                     ; F299  A6 83
    jmp L_E78E                  ; F29B  4C 8E E7

    .byte $84,$06,$85,$00,$A9,$01,$85,$0F,$A5,$0A,$10,$0A,$A5,$0C,$85,$0A
    .byte $20,$5E,$F5,$4C,$B7,$F2,$20,$2C,$F5,$05,$00,$85,$0A,$4C,$D8,$F2

L_F2BE:
    asl a                       ; F2BE  0A

L_F2BF:
    sty $06                     ; F2BF  84 06
    sta $0A                     ; F2C1  85 0A
    and #$1F                    ; F2C3  29 1F
    ldy #$00                    ; F2C5  A0 00
    cmp #$07                    ; F2C7  C9 07
    bcc L_F2D1                  ; F2C9  90 06
    cmp #$12                    ; F2CB  C9 12
    bcs L_F2D1                  ; F2CD  B0 02
    ldy #$02                    ; F2CF  A0 02

L_F2D1:
    cmp #$0D                    ; F2D1  C9 0D
    bcc L_F2D6                  ; F2D3  90 01
    iny                         ; F2D5  C8

L_F2D6:
    sty $07                     ; F2D6  84 07
    lda $0A                     ; F2D8  A5 0A
    and #$E0                    ; F2DA  29 E0
    cmp #$20                    ; F2DC  C9 20
    beq L_F2E4                  ; F2DE  F0 04
    lda $8E                     ; F2E0  A5 8E
    beq L_F32F                  ; F2E2  F0 4B

L_F2E4:
    jsr L_EDCE                  ; F2E4  20 CE ED
    bne L_F32F                  ; F2E7  D0 46
    lda #$01                    ; F2E9  A9 01
    sta $0528,x                 ; F2EB  9D 28 05
    jsr L_EE47                  ; F2EE  20 47 EE
    lda $0A                     ; F2F1  A5 0A
    lsr a                       ; F2F3  4A
    lsr a                       ; F2F4  4A
    lsr a                       ; F2F5  4A
    lsr a                       ; F2F6  4A
    lsr a                       ; F2F7  4A
    sta $05B8,x                 ; F2F8  9D B8 05
    lda $06                     ; F2FB  A5 06
    cmp #$07                    ; F2FD  C9 07
    bcc L_F303                  ; F2FF  90 02
    lda #$07                    ; F301  A9 07

L_F303:
    sta $06                     ; F303  85 06
    lda $08                     ; F305  A5 08
    sta $0324,x                 ; F307  9D 24 03
    lda $09                     ; F30A  A5 09
    sta $033E,x                 ; F30C  9D 3E 03
    lda $0A                     ; F30F  A5 0A
    and #$1F                    ; F311  29 1F
    jsr L_F334                  ; F313  20 34 F3
    lda $05                     ; F316  A5 05
    sta $04E8,x                 ; F318  9D E8 04
    lda $04                     ; F31B  A5 04
    sta $04F8,x                 ; F31D  9D F8 04
    lda $0B                     ; F320  A5 0B
    sta $0508,x                 ; F322  9D 08 05
    lda $0A                     ; F325  A5 0A
    sta $0518,x                 ; F327  9D 18 05
    ldx $83                     ; F32A  A6 83
    lda #$00                    ; F32C  A9 00
    rts                         ; F32E  60


L_F32F:
    ldx $83                     ; F32F  A6 83
    lda #$01                    ; F331  A9 01
    rts                         ; F333  60


L_F334:
    tay                         ; F334  A8
    lda D_F37F,y                ; F335  B9 7F F3
    tay                         ; F338  A8
    lda D_F398,y                ; F339  B9 98 F3
    sta $04                     ; F33C  85 04
    lda #$00                    ; F33E  A9 00
    sta $05                     ; F340  85 05
    jsr L_F3A5                  ; F342  20 A5 F3
    lda $04                     ; F345  A5 04
    sta $0A                     ; F347  85 0A
    lda $05                     ; F349  A5 05
    sta $0B                     ; F34B  85 0B
    lda D_F397,y                ; F34D  B9 97 F3
    sta $04                     ; F350  85 04
    lda #$00                    ; F352  A9 00
    sta $05                     ; F354  85 05
    jsr L_F3A5                  ; F356  20 A5 F3
    lda $07                     ; F359  A5 07
    lsr a                       ; F35B  4A
    bcc L_F36B                  ; F35C  90 0D
    lda #$00                    ; F35E  A9 00
    sec                         ; F360  38
    sbc $04                     ; F361  E5 04
    sta $04                     ; F363  85 04
    lda #$00                    ; F365  A9 00
    sbc $05                     ; F367  E5 05
    sta $05                     ; F369  85 05

L_F36B:
    lda $07                     ; F36B  A5 07
    lsr a                       ; F36D  4A
    lsr a                       ; F36E  4A
    bcc L_F37E                  ; F36F  90 0D
    lda #$00                    ; F371  A9 00
    sec                         ; F373  38
    sbc $0A                     ; F374  E5 0A
    sta $0A                     ; F376  85 0A
    lda #$00                    ; F378  A9 00
    sbc $0B                     ; F37A  E5 0B
    sta $0B                     ; F37C  85 0B

L_F37E:
    rts                         ; F37E  60

D_F37F:
    .byte $00,$02,$04,$06,$08,$0A,$0C,$0A,$08,$06,$04,$02,$00,$02,$04,$06
    .byte $08,$0A,$0C,$0A,$08,$06,$04,$02
D_F397:
    .byte $00
D_F398:
    .byte $FF,$42,$F7,$80,$DD,$B5,$B5,$DD,$80,$F7,$42,$FF,$00

L_F3A5:
    lda $06                     ; F3A5  A5 06
    and #$07                    ; F3A7  29 07
    jsr JumpTable               ; F3A9  20 57 C8
    .word L_F3BE                    ; F3AC
    .word L_F3C3                    ; F3AE
    .word L_F3E4                    ; F3B0
    .word L_F3CA                    ; F3B2
    .word L_F3D3                    ; F3B4
    .word L_F3E5                    ; F3B6
    .word L_F3F0                    ; F3B8
    .word L_F3FF                    ; F3BA
    .word L_F415                    ; F3BC

L_F3BE:
    lsr $05                     ; F3BE  46 05
    ror $04                     ; F3C0  66 04
    rts                         ; F3C2  60


L_F3C3:
    lsr $05                     ; F3C3  46 05
    ror $04                     ; F3C5  66 04
    jmp L_F3D3                  ; F3C7  4C D3 F3


L_F3CA:
    lda $05                     ; F3CA  A5 05
    lsr a                       ; F3CC  4A
    lda $04                     ; F3CD  A5 04
    ror a                       ; F3CF  6A
    lsr a                       ; F3D0  4A
    bpl L_F3D9                  ; F3D1  10 06

L_F3D3:
    lda $05                     ; F3D3  A5 05
    lsr a                       ; F3D5  4A
    lda $04                     ; F3D6  A5 04
    ror a                       ; F3D8  6A

L_F3D9:
    clc                         ; F3D9  18
    adc $04                     ; F3DA  65 04
    sta $04                     ; F3DC  85 04
    lda $05                     ; F3DE  A5 05
    adc #$00                    ; F3E0  69 00
    sta $05                     ; F3E2  85 05

L_F3E4:
    rts                         ; F3E4  60


L_F3E5:
    lda $05                     ; F3E5  A5 05
    lsr a                       ; F3E7  4A
    lda $04                     ; F3E8  A5 04
    ror a                       ; F3EA  6A
    sta $00                     ; F3EB  85 00
    lsr a                       ; F3ED  4A
    bpl L_F3F8                  ; F3EE  10 08

L_F3F0:
    lda $05                     ; F3F0  A5 05
    lsr a                       ; F3F2  4A
    lda $04                     ; F3F3  A5 04
    ror a                       ; F3F5  6A
    sta $00                     ; F3F6  85 00

L_F3F8:
    lsr a                       ; F3F8  4A
    clc                         ; F3F9  18
    adc $00                     ; F3FA  65 00
    jmp L_F3D9                  ; F3FC  4C D9 F3


L_F3FF:
    lda $05                     ; F3FF  A5 05
    lsr a                       ; F401  4A
    lda $04                     ; F402  A5 04
    ror a                       ; F404  6A
    sta $00                     ; F405  85 00
    lsr a                       ; F407  4A
    sta $01                     ; F408  85 01
    clc                         ; F40A  18
    adc $00                     ; F40B  65 00
    lsr $01                     ; F40D  46 01
    clc                         ; F40F  18
    adc $01                     ; F410  65 01
    jmp L_F3D9                  ; F412  4C D9 F3


L_F415:
    asl $04                     ; F415  06 04
    rol $05                     ; F417  26 05
    rts                         ; F419  60

    .byte $20,$51,$F4,$4C,$23,$F4

L_F420:
    jsr L_F44D                  ; F420  20 4D F4
    bmi L_F44B                  ; F423  30 26
    bne L_F435                  ; F425  D0 0E
    inc $05B8,x                 ; F427  FE B8 05
    lda $05B8,x                 ; F42A  BD B8 05
    cmp $06                     ; F42D  C5 06
    bcc L_F442                  ; F42F  90 11
    lda #$00                    ; F431  A9 00
    beq L_F43F                  ; F433  F0 0A

L_F435:
    dec $05B8,x                 ; F435  DE B8 05
    bpl L_F442                  ; F438  10 08
    lda $06                     ; F43A  A5 06
    sec                         ; F43C  38
    sbc #$01                    ; F43D  E9 01

L_F43F:
    sta $05B8,x                 ; F43F  9D B8 05

L_F442:
    lda $05B8,x                 ; F442  BD B8 05
    cmp $0C                     ; F445  C5 0C
    beq L_F44B                  ; F447  F0 02
    clc                         ; F449  18
    rts                         ; F44A  60


L_F44B:
    sec                         ; F44B  38
    rts                         ; F44C  60


L_F44D:
    lda #$00                    ; F44D  A9 00
    beq L_F453                  ; F44F  F0 02

L_F451:
    lda #$01                    ; F451  A9 01

L_F453:
    sta $0F                     ; F453  85 0F
    lda $0A                     ; F455  A5 0A
    bpl L_F463                  ; F457  10 0A
    lda $0C                     ; F459  A5 0C
    sta $0A                     ; F45B  85 0A
    jsr L_F55E                  ; F45D  20 5E F5
    jmp L_F466                  ; F460  4C 66 F4


L_F463:
    jsr L_F52C                  ; F463  20 2C F5

L_F466:
    sta $0C                     ; F466  85 0C
    lda $0F                     ; F468  A5 0F
    lsr a                       ; F46A  4A
    lda #$06                    ; F46B  A9 06
    ldy #$0C                    ; F46D  A0 0C
    bcc L_F475                  ; F46F  90 04
    lda #$0C                    ; F471  A9 0C
    ldy #$18                    ; F473  A0 18

L_F475:
    sta $05                     ; F475  85 05
    sty $06                     ; F477  84 06
    lda $07                     ; F479  A5 07
    and #$02                    ; F47B  29 02
    beq L_F486                  ; F47D  F0 07
    lda $05                     ; F47F  A5 05
    sec                         ; F481  38
    sbc $0C                     ; F482  E5 0C
    sta $0C                     ; F484  85 0C

L_F486:
    lsr $07                     ; F486  46 07
    bcc L_F497                  ; F488  90 0D
    lda $06                     ; F48A  A5 06
    sec                         ; F48C  38
    sbc $0C                     ; F48D  E5 0C
    cmp $06                     ; F48F  C5 06
    bcc L_F495                  ; F491  90 02
    lda #$00                    ; F493  A9 00

L_F495:
    sta $0C                     ; F495  85 0C

L_F497:
    lda #$00                    ; F497  A9 00
    sta $0E                     ; F499  85 0E
    lda $05B8,x                 ; F49B  BD B8 05
    clc                         ; F49E  18
    adc $05                     ; F49F  65 05
    cmp $06                     ; F4A1  C5 06
    bcc L_F4A9                  ; F4A3  90 04
    inc $0E                     ; F4A5  E6 0E
    sbc $06                     ; F4A7  E5 06

L_F4A9:
    sta $0D                     ; F4A9  85 0D
    lda $0C                     ; F4AB  A5 0C
    cmp $05B8,x                 ; F4AD  DD B8 05
    beq L_F4C9                  ; F4B0  F0 17
    ldy $0E                     ; F4B2  A4 0E
    bne L_F4C0                  ; F4B4  D0 0A
    bcc L_F4C6                  ; F4B6  90 0E
    cmp $0D                     ; F4B8  C5 0D
    bcs L_F4C6                  ; F4BA  B0 0A

L_F4BC:
    lda #$00                    ; F4BC  A9 00
    beq L_F4C8                  ; F4BE  F0 08

L_F4C0:
    bcs L_F4BC                  ; F4C0  B0 FA
    cmp $0D                     ; F4C2  C5 0D
    bcc L_F4BC                  ; F4C4  90 F6

L_F4C6:
    lda #$01                    ; F4C6  A9 01

L_F4C8:
    rts                         ; F4C8  60


L_F4C9:
    lda #$80                    ; F4C9  A9 80
    bne L_F4C8                  ; F4CB  D0 FB
    jsr L_EB2F                  ; F4CD  20 2F EB
    lda #$02                    ; F4D0  A9 02
    sta $0F                     ; F4D2  85 0F
    jsr L_F52C                  ; F4D4  20 2C F5
    sta $0C                     ; F4D7  85 0C
    ldy $05D8,x                 ; F4D9  BC D8 05
    lda $07                     ; F4DC  A5 07
    lsr a                       ; F4DE  4A
    lsr a                       ; F4DF  4A
    bcc L_F4E9                  ; F4E0  90 07
    lda #$20                    ; F4E2  A9 20
    sec                         ; F4E4  38
    sbc $0C                     ; F4E5  E5 0C
    sta $0C                     ; F4E7  85 0C

L_F4E9:
    lsr $07                     ; F4E9  46 07
    bcc L_F4F6                  ; F4EB  90 09
    lda #$40                    ; F4ED  A9 40
    sec                         ; F4EF  38
    sbc $0C                     ; F4F0  E5 0C
    and #$3F                    ; F4F2  29 3F
    sta $0C                     ; F4F4  85 0C

L_F4F6:
    lda #$00                    ; F4F6  A9 00
    sta $0E                     ; F4F8  85 0E
    lda $0508,y                 ; F4FA  B9 08 05
    clc                         ; F4FD  18
    adc #$20                    ; F4FE  69 20
    cmp #$40                    ; F500  C9 40
    bcc L_F508                  ; F502  90 04
    inc $0E                     ; F504  E6 0E
    sbc #$40                    ; F506  E9 40

L_F508:
    sta $0D                     ; F508  85 0D
    lda $0C                     ; F50A  A5 0C
    cmp $0508,y                 ; F50C  D9 08 05
    beq L_F528                  ; F50F  F0 17
    ldy $0E                     ; F511  A4 0E
    bne L_F51F                  ; F513  D0 0A
    bcc L_F525                  ; F515  90 0E
    cmp $0D                     ; F517  C5 0D
    bcs L_F525                  ; F519  B0 0A

L_F51B:
    lda #$00                    ; F51B  A9 00
    beq L_F527                  ; F51D  F0 08

L_F51F:
    bcs L_F51B                  ; F51F  B0 FA
    cmp $0D                     ; F521  C5 0D
    bcc L_F51B                  ; F523  90 F6

L_F525:
    lda #$01                    ; F525  A9 01

L_F527:
    rts                         ; F527  60


L_F528:
    lda #$80                    ; F528  A9 80
    bne L_F527                  ; F52A  D0 FB

L_F52C:
    jsr Target4P                ; F52C  A5 0A 29  [4P] antes: lda $0A / and #$01 / tay
    nop
    nop
    lda a:$0090,y               ; F531  B9 90 00
    cmp #$01                    ; F534  C9 01
    beq L_F54D                  ; F536  F0 15
    tya                         ; F538  98
    eor #$01                    ; F539  49 01
    tay                         ; F53B  A8
    lda a:$0090,y               ; F53C  B9 90 00
    cmp #$01                    ; F53F  C9 01
    beq L_F54D                  ; F541  F0 0A
    lda #$FF                    ; F543  A9 FF
    sta $0A                     ; F545  85 0A
    lda #$80                    ; F547  A9 80
    sta $0B                     ; F549  85 0B
    bne L_F55E                  ; F54B  D0 11

L_F54D:
    lda $40                     ; F54D  A5 40
    lsr a                       ; F54F  4A
    lda #$B0                    ; F550  A9 B0
    bcs L_F557                  ; F552  B0 03
    lda $031A,y                 ; F554  B9 1A 03

L_F557:
    sta $0A                     ; F557  85 0A
    lda $0334,y                 ; F559  B9 34 03
    sta $0B                     ; F55C  85 0B

L_F55E:
    ldy #$00                    ; F55E  A0 00
    lda $0A                     ; F560  A5 0A
    sec                         ; F562  38
    sbc $08                     ; F563  E5 08
    bcs L_F56C                  ; F565  B0 05
    eor #$FF                    ; F567  49 FF
    adc #$01                    ; F569  69 01
    iny                         ; F56B  C8

L_F56C:
    lsr a                       ; F56C  4A
    lsr a                       ; F56D  4A
    lsr a                       ; F56E  4A
    lsr a                       ; F56F  4A
    lsr a                       ; F570  4A
    sta $0A                     ; F571  85 0A
    lda $0B                     ; F573  A5 0B
    sec                         ; F575  38
    sbc $09                     ; F576  E5 09
    bcs L_F580                  ; F578  B0 06
    eor #$FF                    ; F57A  49 FF
    adc #$01                    ; F57C  69 01
    iny                         ; F57E  C8
    iny                         ; F57F  C8

L_F580:
    lsr a                       ; F580  4A
    lsr a                       ; F581  4A
    lsr a                       ; F582  4A
    lsr a                       ; F583  4A
    lsr a                       ; F584  4A
    sty $07                     ; F585  84 07
    lsr a                       ; F587  4A
    sta $0B                     ; F588  85 0B
    php                         ; F58A  08
    lda $0F                     ; F58B  A5 0F
    asl a                       ; F58D  0A
    tay                         ; F58E  A8
    lda D_F5AC,y                ; F58F  B9 AC F5
    sta $0C                     ; F592  85 0C
    lda D_F5AD,y                ; F594  B9 AD F5
    sta $0D                     ; F597  85 0D
    lda $0A                     ; F599  A5 0A
    asl a                       ; F59B  0A
    asl a                       ; F59C  0A
    adc $0B                     ; F59D  65 0B
    tay                         ; F59F  A8
    lda ($0C),y                 ; F5A0  B1 0C
    plp                         ; F5A2  28
    bcs L_F5A9                  ; F5A3  B0 04
    lsr a                       ; F5A5  4A
    lsr a                       ; F5A6  4A
    lsr a                       ; F5A7  4A
    lsr a                       ; F5A8  4A

L_F5A9:
    and #$0F                    ; F5A9  29 0F
    rts                         ; F5AB  60

D_F5AC:
    .byte $B2
D_F5AD:
    .byte $F5,$D2,$F5,$F2,$F5,$00,$00,$00,$00,$32,$11,$00,$00,$32,$11,$11
    .byte $11,$32,$22,$11,$11,$33,$22,$11,$11,$33,$22,$22,$11,$33,$22,$22
    .byte $11,$33,$22,$22,$22,$00,$00,$00,$00,$63,$21,$11,$11,$64,$32,$21
    .byte $11,$65,$43,$22,$22,$65,$44,$33,$22,$65,$54,$33,$32,$65,$54,$43
    .byte $33,$65,$54,$44,$33,$80,$00,$00,$00,$F8,$53,$32,$21,$FB,$86,$54
    .byte $33,$FD,$A8,$75,$54,$FE,$B9,$87,$65,$FE,$CB,$98,$76,$FE,$DB,$A9
    .byte $87,$FF,$DC,$BA,$98
; ============================================================
; [4P] Código nuevo en el espacio libre del banco fijo
; ============================================================

; Sustituye a L_C35B (lectura de mandos, desde la NMI).
; J1/J2 terminan exactamente como en el original ($F1/$F5/$F9, $00/$01, $04/$05, X, Y).
; Además deja los 4 mandos en Pad4Held/Pad4New/Pad4Prev.
ReadPads4:
    lda Ram4Magic               ; la primera vez (RAM extra sin inicializar): borrar $6000-$60FF
    cmp #$C4
    bne RP4_init
    lda Ram4Magic+1
    cmp #$4A
    beq RP4_ready
RP4_init:
    lda #$00
    tax
RP4_clear:
    sta $6000,x
    inx
    bne RP4_clear
    lda #$01                    ; J3/J4 fuera de la partida
    sta Ctx_Over
    sta Ctx_Over+1
    ldx #$06                    ; colores de las paletas extra (J3 verde, J4 amarillo)
RP4_pal:
    lda ExtColorTable,x
    sta ExtPalColors+5,x
    dex
    bpl RP4_pal
    lda #$C4
    sta Ram4Magic
    lda #$4A
    sta Ram4Magic+1
RP4_ready:
    lda PlayActive              ; contador "partida en marcha" (lo repone Players4P)
    beq RP4_idle
    dec PlayActive
RP4_idle:
    jsr ReadRaw4
    ldx #$03
RP4_copy:
    lda Pad4RawA,x
    sta Pad4RawB,x
    dex
    bpl RP4_copy
    lda Pad4RawA                ; como el original: $00/$01 = primera lectura
    sta $00
    lda Pad4RawA+1
    sta $01
    jsr ReadRaw4
    lda $F9                     ; J1/J2: el "anterior" es el del juego original
    sta Pad4Prev
    lda $FA
    sta Pad4Prev+1
    ldx #$03
RP4_check:                      ; si las dos lecturas no coinciden, se repite el anterior
    lda Pad4RawA,x
    cmp Pad4RawB,x
    beq RP4_same
    lda Pad4Prev,x
    sta Pad4RawA,x
RP4_same:
    dex
    bpl RP4_check
    lda $1D                     ; original: fuera de este modo, el mando 2 también mueve a J1
    and #$04
    bne RP4_nomerge
    lda Pad4RawA
    ora Pad4RawA+1
    sta Pad4RawA
RP4_nomerge:
    lda Pad4RawA
    sta $04
    lda Pad4RawA+1
    sta $05
    ldx #$03
RP4_edges:
    lda Pad4RawA,x
    tay
    eor Pad4Prev,x
    and Pad4RawA,x
    sta Pad4New,x
    tya
    sta Pad4Held,x
    sta Pad4Prev,x
    dex
    bpl RP4_edges
    ldx #$01                    ; copiar J1/J2 a las variables originales
RP4_out:
    lda Pad4New,x
    sta $F5,x
    lda Pad4Held,x
    sta $F1,x
    sta $F9,x
    tay
    dex
    bpl RP4_out
    rts

; Paleta extra 1 (J3): piel, traje verde, contorno · paleta extra 2 (J4): piel, traje amarillo, contorno
; (se copia a $5045-$504B: colores 1-3 de la paleta 1, un byte sin uso, colores 1-3 de la paleta 2)
ExtColorTable:
    .byte $37,$1A,$0F,$00,$36,$28,$0F

; Lee 24 bits de cada puerto: mando principal (J1/J2), mando extra (J3/J4) y firma.
; Sin adaptador Four Score, J3/J4 quedan a 0.
ReadRaw4:
    ldx #$01
    stx JOY1
    dex
    stx JOY1
    ldy #$08
RR4_main:                       ; igual que el original (bits 0 y 1: mandos de Famicom)
    lda JOY1
    sta $07
    lsr a
    ora $07
    lsr a
    rol Pad4RawA
    lda JOY2
    sta $07
    lsr a
    ora $07
    lsr a
    rol Pad4RawA+1
    dey
    bne RR4_main
    ldy #$08
RR4_extra:
    lda JOY1
    lsr a
    rol Pad4RawA+2
    lda JOY2
    lsr a
    rol Pad4RawA+3
    dey
    bne RR4_extra
    ldy #$08
RR4_sig:
    lda JOY1
    lsr a
    rol Pad4Sig
    lda JOY2
    lsr a
    rol Pad4Sig+1
    dey
    bne RR4_sig
    lda Pad4Sig
    cmp #$10
    bne RR4_none
    lda Pad4Sig+1
    cmp #$20
    bne RR4_none
    lda #$01
    sta FourScoreOn
    rts
RR4_none:
    lda #$00
    sta FourScoreOn
    sta Pad4RawA+2
    sta Pad4RawA+3
    rts


; ------------------------------------------------------------
; [4P] Jugadores 3 y 4 por intercambio de contexto
; ------------------------------------------------------------
; Sustituye a "jsr L_D3B4" (actualización de jugadores) en L_D371.
; 1) J1/J2 como en el original. 2) Con Four Score: se intercambia el estado de
; J1/J2 con el de J3/J4 (Ctx34), se ejecuta la MISMA rutina (J3/J4 hacen de J1/J2)
; y se vuelve a intercambiar.
Players4P:
    jsr L_D3B4
    lda FourScoreOn
    beq P4_off
    lda $1C                     ; $1C <> 0: título / demo automática -> sin J3/J4
    beq P4_go
P4_off:
    rts
P4_go:
    lda #30                     ; señal "partida en marcha" para la web
    sta PlayActive
    lda $2F                     ; resultados compartidos de la pasada 1
    sta Comb2F
    lda $8E
    sta Comb8E
    lda $68
    sta Comb68
    lda $F1                     ; mandos: J3/J4 en el lugar de J1/J2
    sta SaveF1
    lda $F2
    sta SaveF1+1
    lda $F5
    sta SaveF1+2
    lda $F6
    sta SaveF1+3
    lda Pad4Held+2
    sta $F1
    lda Pad4Held+3
    sta $F2
    lda Pad4New+2
    sta $F5
    lda Pad4New+3
    sta $F6
    jsr SwapCtx34
    lda #$01
    sta Pass34
    jsr Join34
    jsr L_D3B4
    lda $83                     ; Collide34 usa $83 (enemigo en curso): conservarlo
    pha
    jsr Collide34
    pla
    sta $83
    lda #$00
    sta Pass34
    lda $2F                     ; $2F = máximo de las dos pasadas
    cmp Comb2F
    bcs P4_2F
    lda Comb2F
    sta $2F
P4_2F:
    lda $8E                     ; $8E = alguna de las dos
    ora Comb8E
    sta $8E
    lda $68                     ; $68 (empuje de la pantalla) = máximo
    cmp Comb68
    bcs P4_68
    lda Comb68
    sta $68
P4_68:
    lda $A2                     ; ¿quién ha empujado la pantalla?
    ora $A3
    sta PushB
    lda Ctx34+$12               ; $A2/$A3 de J1/J2 (están en el contexto)
    ora Ctx34+$13
    sta PushA
    lda $40                     ; solo en niveles horizontales (como L_D42C)
    ora $41
    bne P4_noshiftB
    lda PushA
    beq P4_noshiftB
    lda PushB
    bne P4_noshiftB
    jsr ShiftLivePair           ; J1/J2 empujan y J3/J4 no: J3/J4 se desplazan
P4_noshiftB:
    jsr SwapCtx34
    lda SaveF1
    sta $F1
    lda SaveF1+1
    sta $F2
    lda SaveF1+2
    sta $F5
    lda SaveF1+3
    sta $F6
    lda $40
    ora $41
    bne P4_end
    lda PushB
    beq P4_end
    lda PushA
    bne P4_end
    jsr ShiftLivePair           ; J3/J4 empujan y J1/J2 no: J1/J2 se desplazan
P4_end:
    rts

; Desplaza 1 píxel a la izquierda a los jugadores cargados (X=0/1) que estén en juego.
ShiftLivePair:
    ldx #$01
SLP_loop:
    lda $38,x
    bne SLP_next
    lda $0300,x
    beq SLP_next
    lda $0334,x
    cmp #$10
    bcc SLP_next
    dec $0334,x
SLP_next:
    dex
    bpl SLP_loop
    rts

; Intercambia el estado de la pareja cargada con el de Ctx34.
SwapCtx34:
    ldx #CTX_ZP_LEN-1
SC_zp:
    lda $90,x
    ldy Ctx34,x
    sty $90,x
    sta Ctx34,x
    dex
    bpl SC_zp
    ldx #$01
SC_pair:
    lda $32,x
    ldy Ctx_Lives,x
    sty $32,x
    sta Ctx_Lives,x
    lda $38,x
    ldy Ctx_Over,x
    sty $38,x
    sta Ctx_Over,x
    lda $0300,x
    pha
    lda Ctx_Spr,x
    sta $0300,x
    pla
    sta Ctx_Spr,x
    lda $031A,x
    pha
    lda Ctx_Y,x
    sta $031A,x
    pla
    sta Ctx_Y,x
    lda $0334,x
    pha
    lda Ctx_X,x
    sta $0334,x
    pla
    sta Ctx_X,x
    lda $034E,x
    pha
    lda Ctx_Attr,x
    sta $034E,x
    pla
    sta Ctx_Attr,x
    dex
    bpl SC_pair
    rts

; Con J3/J4 cargados: quien no haya entrado todavía en esta partida y pulse START,
; entra con 3 vidas (una sola vez; después de su game over queda fuera como J1/J2).
Join34:
    ldx #$01
J34_loop:
    lda $38,x
    beq J34_next
    lda Joined34,x
    bne J34_next
    lda $F5,x
    and #PAD_START
    beq J34_next
    lda #$02
    sta $32,x
    lda #$01
    sta Joined34,x
    jsr L_DAD1                  ; mismo reinicio que tras perder una vida (A=0 al volver)
    sta $90,x
    sta $38,x
J34_next:
    dex
    bpl J34_loop
    rts

; Game over solo cuando no queda nadie: sustituye a "lda $38 / and $39" (CEF1).
; Devuelve A/Z como el original: distinto de 0 (Z=0) = todos fuera.
AllOut4P:
    lda $38
    and $39
    beq AO_done                 ; J1 o J2 sigue jugando
    lda FourScoreOn
    beq AO_out
    lda $1C
    bne AO_out
    lda Ctx_Over                ; J3/J4 (en el contexto): fuera = distinto de 0
    and Ctx_Over+1
    rts
AO_out:
    lda #$01
AO_done:
    rts

; Final de nivel: el juego cuenta los jugadores vivos de pie ($90 = 1) para seguir.
; Sustituye a "tya / sta $0194" (Y = vivos de J1/J2): suma también J3/J4.
CountAlive4P:
    lda FourScoreOn
    beq CA_store
    lda $1C
    bne CA_store
    ldx #$01
CA_loop:
    lda Ctx_Over,x
    bne CA_next
    lda Ctx34,x                 ; $90 de J3/J4
    cmp #$01
    bne CA_next
    iny
CA_next:
    dex
    bpl CA_loop
CA_store:
    tya
    sta $0194
    ora #$00                    ; Z como el original (beq si no hay nadie)
    rts

; Partida nueva / continuar: además de lo original, J3/J4 quedan fuera de la partida.
NewGame4P:
    jsr L_C43E
    jmp Reset34
Continue4P:
    jsr L_C447
Reset34:
    php
    pha
    txa
    pha
    lda #$00
    ldx #$57
R34_clear:
    sta Ctx34,x
    dex
    bpl R34_clear
    sta Joined34                ; A = 0: pueden volver a entrar
    sta Joined34+1
    lda #$01
    sta Ctx_Over
    sta Ctx_Over+1
    pla
    tax
    pla
    plp
    rts


; ------------------------------------------------------------
; [4P] Enemigos contra J3/J4
; ------------------------------------------------------------
; Se llama desde Players4P con J3/J4 ya cargados en el lugar de J1/J2 (así no hace
; falta otro intercambio de contexto, que es lo más caro). Repite el choque
; enemigo-jugador (L_E1D9) con las mismas condiciones que el bucle de enemigos
; (L_E61E). Usa las posiciones de los enemigos del fotograma anterior.
Collide34:
    lda $38                     ; nadie de J3/J4 en juego: nada que hacer
    and $39
    bne C34_end
    lda #$00                    ; como L_E61E: "sobre plataforma enemiga" se recalcula
    sta $B6
    sta $B7
    ldx #$0F
C34_loop:
    lda $04B8,x                 ; enemigo activo
    beq C34_next
    lda $030A,x                 ; con sprite en pantalla
    beq C34_next
    lda $40
    lsr a
    bcc C34_check
    lda $0324,x
    cmp #$9C
    bcc C34_next
C34_check:
    lda $0598,x                 ; bit 0: no choca con jugadores
    lsr a
    bcs C34_next
    stx $83
    jsr L_E1D9                  ; vuelve con X = $83
C34_next:
    dex
    bpl C34_loop
C34_end:
    rts

; Sustituye al principio de L_F52C (a qué jugador apunta un enemigo).
; Original: Y = $0A & 1 (J1 o J2). Con J3/J4 en juego, la mitad de las veces
; (según el enemigo y cada 64 fotogramas) apunta a J3/J4 si alguno está vivo.
Target4P:
    lda FourScoreOn
    beq T4_orig
    lda $1C
    bne T4_orig
    lda $1A                     ; (contador / 64) xor nº de enemigo -> pareja
    asl a
    rol a
    rol a
    eor $83
    and #$01
    beq T4_orig
    lda $0A
    and #$01
    tay
    lda Ctx34,y                 ; $90 de J3/J4: 1 = vivo y jugando
    cmp #$01
    beq T4_use
    tya
    eor #$01
    tay
    lda Ctx34,y
    cmp #$01
    bne T4_orig
T4_use:
    lda $40                     ; igual que L_F54D, con la posición de J3/J4
    lsr a
    lda #$B0
    bcs T4_y
    lda Ctx_Y,y
T4_y:
    sta $0A
    lda Ctx_X,y
    sta $0B
    pla                         ; no volver a L_F52C: seguir en L_F55E
    pla
    jmp L_F55E
T4_orig:
    lda $0A
    and #$01
    tay
    rts

; --- espacio libre (lo que quede hasta $FC00) ---
.org $FC00, $FF
    .byte $AA,$AA,$AA,$AA,$AA,$AF,$F0,$9E,$9F,$F0,$06,$AE,$7C,$1B,$98,$F0
    .byte $00,$03,$00,$0C,$01,$CE,$01,$80,$00,$00,$00,$00,$00,$0F,$1F,$FF
    .byte $FB,$F3,$CF,$F3,$EF,$DE,$B8,$F9,$A6,$A2,$24,$39,$81,$43,$80,$86
    .byte $19,$02,$38,$51,$87,$86,$15,$39,$8C,$A6,$55,$4D,$16,$8C,$A3,$45
    .byte $45,$90,$CA,$56,$22,$52,$70,$D6,$53,$16,$D3,$54,$D7,$4B,$37,$4B
    .byte $5B,$6B,$56,$CE,$B5,$5B,$5D,$59,$B6,$D5,$AB,$D6,$B5,$D7,$6B,$6D
    .byte $AD,$AE,$B6,$D6,$B5,$B5,$AA,$D6,$AA,$AC,$AA,$A9,$54,$A9,$94,$A4
    .byte $A9,$4A,$4A,$8A,$92,$54,$A5,$49,$29,$4A,$54,$A5,$29,$52,$A5,$4A
    .byte $A5,$54,$A9,$54,$AA,$95,$2A,$AA,$94,$95,$2A,$AA,$55,$55,$2A,$56
    .byte $66,$AA,$9A,$AA,$B5,$5A,$AD,$AB,$5A,$B5,$6B,$6B,$6B,$5A,$B5,$AA
    .byte $B5,$56,$AA,$D5,$55,$56,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$95,$55,$55
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FE,$FF,$DE,$FF,$E3,$EF,$8C,$44,$40,$31,$37,$09,$80,$18,$60,$00
    .byte $C0,$20,$2F,$3A,$A3,$EE,$3C,$EF,$77,$57,$EF,$9F,$AF,$FF,$DE,$BF
    .byte $9E,$C9,$24,$41,$09,$09,$09,$29,$00,$00,$04,$00,$18,$74,$9B,$BF
    .byte $76,$EB,$CF,$7B,$DF,$FD,$F3,$E7,$C6,$F3,$81,$E2,$68,$31,$1C,$31
    .byte $88,$6A,$C0,$8F,$06,$0A,$61,$C6,$38,$D4,$C5,$C7,$2F,$1D,$63,$A7
    .byte $D0,$FC,$63,$CF,$B8,$F1,$B1,$CF,$F1,$DC,$76,$33,$EE,$30,$E2,$D0
    .byte $08,$38,$84,$01,$42,$0E,$07,$0C,$1D,$1E,$7D,$9E,$7F,$E7,$EF,$3F
    .byte $7F,$3F,$87,$DC,$63,$18,$73,$0C,$23,$18,$88,$53,$11,$06,$0D,$62
    .byte $03,$3C,$33,$24,$E7,$7C,$AE,$F3,$E7,$1F,$F8,$F0,$F3,$CF,$71,$AE
    .byte $1C,$8E,$CF,$08,$CE,$0C,$CC,$18,$31,$C2,$40,$E1,$8E,$18,$2C,$D1
    .byte $91,$ED,$9F,$0F,$CF,$A7,$3C,$FF,$93,$C7,$CC,$F5,$38,$39,$B8,$19
    .byte $47,$88,$46,$D6,$04,$76,$31,$85,$1C,$58,$63,$9C,$61,$79,$8C,$F3
    .byte $98,$F7,$78,$27,$C7,$9F,$64,$77,$39,$0F,$8C,$F5,$86,$2F,$91,$8C
    .byte $71,$C7,$21,$E1,$C4,$19,$8C,$41,$66,$07,$A6,$2E,$8A,$E7,$43,$CF
    .byte $9E,$1F,$9E,$71,$F3,$E3,$B7,$18,$FC,$63,$C3,$18,$C3,$B0,$E0,$E3
    .byte $0F,$08,$E0,$71,$8C,$C1,$8F,$19,$C3,$39,$39,$99,$F1,$BC,$74,$76
    .byte $E2,$F3,$C7,$97,$19,$E3,$63,$39,$87,$C6,$37,$0F,$09,$C6,$71,$23
    .byte $88,$E0,$A9,$83,$8B,$19,$87,$66,$71,$8C,$EF,$0D,$DA,$F4,$73,$EE
    .byte $1C,$DB,$8E,$76,$1A,$39,$0E,$71,$C6,$2E,$31,$C3,$9C,$59,$07,$A1
    .byte $C0,$F1,$19,$9C,$58,$CE,$2E,$2D,$6E,$3C,$E3,$39,$E3,$8E,$B8,$E7
    .byte $1C,$E3,$A7,$0D,$8E,$47,$94,$B7,$05,$C2,$39,$E6,$26,$36,$19,$8C
    .byte $74,$98,$CD,$47,$38,$59,$E8,$D3,$53,$B8,$F2,$6E,$AC,$B3,$B4,$E5
    .byte $71,$27,$8E,$8C,$8F,$1A,$3C,$8A,$73,$8E,$1C,$6B,$29,$8E,$1C,$2C
    .byte $68,$D9,$31,$E3,$55,$47,$39,$AB,$2D,$97,$38,$D3,$B1,$CE,$38,$F1
    .byte $D4,$B3,$4E,$A9,$62,$AD,$54,$B2,$38,$C9,$A8,$AC,$A9,$18,$E6,$51
    .byte $9A,$73,$29,$9E,$39,$9A,$D5,$A7,$96,$D3,$65,$9D,$58,$BA,$61,$DA
    .byte $46,$AA,$3C,$52,$B1,$A5,$66,$63,$8D,$31,$E0,$E5,$95,$2A,$CC,$B2
    .byte $9C,$AC,$AB,$39,$66,$A7,$4B,$99,$5A,$6A,$CC,$AB,$8B,$55,$A6,$A6
    .byte $AA,$3C,$5A,$39,$38,$E2,$A4,$B9,$30,$B9,$54,$AA,$95,$AA,$65,$5A
    .byte $9C,$C7,$59,$B2,$AE,$6B,$34,$DC,$B2,$D4,$B1,$D4,$63,$C5,$34,$6A
    .byte $65,$69,$65,$4C,$E3,$35,$4C,$71,$A5,$54,$D6,$33,$4D,$71,$92,$EA
    .byte $9A,$AB,$56,$55,$5A,$CA,$6A,$CE,$33,$3A,$3C,$65,$56,$39,$8D,$62
    .byte $C6,$6A,$33,$49,$A9,$55,$61,$AC,$AD,$2A,$AA,$D5,$8D,$6A,$AC,$D5
    .byte $5A,$D3,$95,$3A,$C8,$E6,$95,$94,$AD,$4B,$16,$5A,$62,$E3,$4C,$CB
    .byte $2A,$B3,$2A,$AA,$96,$A6,$5A,$9A,$AA,$AA,$AC,$D3,$55,$55,$55,$A6
    .byte $A6,$AA,$AA,$B4,$CB,$2C,$D2,$CA,$CA,$AA,$96,$95,$55,$52,$CA,$AA
    .byte $96,$66,$55,$55,$AA,$96,$AB,$2C,$AD,$59,$65,$A6,$AA,$AC,$B3,$34
    .byte $CB,$4C,$AA,$CA,$AA,$A5,$A6,$56,$55,$54,$D3,$2A,$C6,$AA,$6A,$96
    .byte $A6,$66,$AA,$AA,$B2,$B4,$D5,$55,$66,$9A,$AA,$AA,$AA,$AA,$AA,$AA
    .byte $AA,$AA,$AA,$AA,$9A,$A6,$56,$55,$52,$B2,$AA,$AA,$AA,$96,$AA,$65
    .byte $AA,$AA,$AA,$B5,$55,$56,$6A,$6A,$AA,$AA,$AA,$6A,$72,$9A,$AA,$9A
    .byte $9A,$A9,$96,$59,$55,$55,$55,$52,$D2,$B2,$AA,$A9,$AA,$AA,$AA,$AC
    .byte $B2,$CC,$D5,$55,$55,$65,$96,$59,$AA,$AA,$9A,$9A,$9A,$AA,$6A,$56
    .byte $A5,$65,$95,$55,$55,$55,$54,$B5,$32,$AA,$AA,$B2,$AA,$B2,$AA,$AB
    .byte $55,$55,$55,$55,$55,$69,$AA,$AA,$96,$9A,$99,$5A,$59,$5A,$55,$65
    .byte $96,$59,$55,$55,$55,$55,$55,$52,$B4,$AA,$AA,$AA,$AA,$B2,$D3,$55
    .byte $55,$55,$55,$55,$56,$55,$66,$AA,$AA,$AA,$AA,$A6,$9A,$AA,$65,$55
    .byte $55,$55,$55,$55,$32,$CC,$AA,$AA,$AA,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
BankSelectTable:
; [4P] Ampliada a 16 bancos (antes $00-$07 y el texto "RD008" sin uso).
; UNROM: para cambiar al banco N se escribe N en una dirección que ya contiene N.
    .byte $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$43,$4F,$4E,$54,$52,$41
    .byte $8A,$6B,$00,$00,$38,$02,$01,$05,$A4,$1C
    .word NMI                       ; FFFA
    .word Reset                     ; FFFC
    .word IRQ                       ; FFFE
