; ============================================================
; Contra (USA) - banco 0  ($8000-$BFFF)  [intercambiable]
; Generado por tools/disasm.py. Las etiquetas L_ son código, D_ son datos.
; ============================================================
.include "nes.inc"
; Las etiquetas del banco fijo (L_xxxx) son visibles desde aquí.
.base $8000

    .byte $00
D0_8001:
    .word D0_8007                   ; 8001
    .word L0_8068                   ; 8003
    .word L0_8100                   ; 8005
D0_8007:
    .word L0_80A9                   ; 8007
    .word L0_989D                   ; 8009
    .word L0_A905                   ; 800B
    .word L0_9D22                   ; 800D
    .byte $88,$05,$A9,$05,$9D,$58,$03,$A5,$40,$F0,$16,$BD,$24,$03,$9D,$B8
    .byte $05,$20,$9D,$ED,$A9,$80,$9D,$E8,$05,$A9,$FD,$9D,$58,$05,$4C,$8E
    .byte $E7,$A0,$00,$A5,$41,$F0,$0B,$A0,$04,$BD,$3E,$03,$C9,$80,$90,$02
    .byte $A0,$08,$B9,$5C,$80,$9D,$F8,$04,$B9,$5D,$80,$9D,$E8,$04,$B9,$5E
    .byte $80,$9D,$18,$05,$B9,$5F,$80,$9D,$08,$05

L0_8059:
    jmp L_E78E                  ; 8059  4C 8E E7

    .byte $00,$FD,$80,$00,$00,$FD,$40,$00,$00,$FD,$C0,$FF

L0_8068:
    jsr L0_811C                 ; 8068  20 1C 81
    lda $40                     ; 806B  A5 40
    beq L0_8090                 ; 806D  F0 21
    lda $05E8,x                 ; 806F  BD E8 05
    clc                         ; 8072  18
    adc #$12                    ; 8073  69 12
    sta $05E8,x                 ; 8075  9D E8 05
    lda $0558,x                 ; 8078  BD 58 05
    adc #$00                    ; 807B  69 00
    sta $0558,x                 ; 807D  9D 58 05
    jsr L_ED66                  ; 8080  20 66 ED
    lda $05D8,x                 ; 8083  BD D8 05
    bmi L0_808F                 ; 8086  30 07
    lda #$A4                    ; 8088  A9 A4
    sta $0324,x                 ; 808A  9D 24 03
    bne L0_8059                 ; 808D  D0 CA

L0_808F:
    rts                         ; 808F  60


L0_8090:
    jsr L_E85B                  ; 8090  20 5B E8
    jsr L0_80C9                 ; 8093  20 C9 80
    bcc L0_80A3                 ; 8096  90 0B
    lda #$0A                    ; 8098  A9 0A
    jsr L_EB8A                  ; 809A  20 8A EB
    jsr L_E8CD                  ; 809D  20 CD E8
    jmp L_E78E                  ; 80A0  4C 8E E7


L0_80A3:
    lda $033E,x                 ; 80A3  BD 3E 03
    ldy $0508,x                 ; 80A6  BC 08 05

L0_80A9:
    bmi L0_80B8                 ; 80A9  30 0D
    cmp #$E8                    ; 80AB  C9 E8
    bcs L0_80C3                 ; 80AD  B0 14
    lda #$0A                    ; 80AF  A9 0A
    jsr L0_80E3                 ; 80B1  20 E3 80
    bmi L0_80C3                 ; 80B4  30 0D
    bpl L0_80C6                 ; 80B6  10 0E

L0_80B8:
    cmp #$18                    ; 80B8  C9 18
    bcc L0_80C3                 ; 80BA  90 07
    lda #$F6                    ; 80BC  A9 F6
    jsr L0_80E3                 ; 80BE  20 E3 80
    bpl L0_80C6                 ; 80C1  10 03

L0_80C3:
    jsr L_E91E                  ; 80C3  20 1E E9

L0_80C6:
    jmp L_EB40                  ; 80C6  4C 40 EB


L0_80C9:
    lda $0324,x                 ; 80C9  BD 24 03
    cmp #$20                    ; 80CC  C9 20
    bcc L0_80E1                 ; 80CE  90 11

L0_80D0:
    lda $0568,x                 ; 80D0  BD 68 05
    ora $04E8,x                 ; 80D3  1D E8 04
    bmi L0_80E1                 ; 80D6  30 09
    ldy #$08                    ; 80D8  A0 08
    jsr L_EC33                  ; 80DA  20 33 EC
    beq L0_80E1                 ; 80DD  F0 02
    sec                         ; 80DF  38
    rts                         ; 80E0  60


L0_80E1:
    clc                         ; 80E1  18
    rts                         ; 80E2  60


L0_80E3:
    clc                         ; 80E3  18
    adc $033E,x                 ; 80E4  7D 3E 03
    sta $08                     ; 80E7  85 08
    lda $59                     ; 80E9  A5 59
    beq L0_80E1                 ; 80EB  F0 F4
    lda $0568,x                 ; 80ED  BD 68 05
    bne L0_80F9                 ; 80F0  D0 07
    ldy $0324,x                 ; 80F2  BC 24 03
    cpy #$10                    ; 80F5  C0 10
    bcs L0_80FB                 ; 80F7  B0 02

L0_80F9:
    ldy #$10                    ; 80F9  A0 10

L0_80FB:
    lda $08                     ; 80FB  A5 08
    jmp L_E087                  ; 80FD  4C 87 E0


L0_8100:
    jsr L0_811C                 ; 8100  20 1C 81
    lda $40                     ; 8103  A5 40
    beq L0_810E                 ; 8105  F0 07
    lda $65                     ; 8107  A5 65
    beq L0_811B                 ; 8109  F0 10
    jmp L_E809                  ; 810B  4C 09 E8


L0_810E:
    jsr L_E85B                  ; 810E  20 5B E8
    jsr L0_80D0                 ; 8111  20 D0 80
    bcs L0_811B                 ; 8114  B0 05
    lda #$02                    ; 8116  A9 02
    jmp L_E81A                  ; 8118  4C 1A E8


L0_811B:
    rts                         ; 811B  60


L0_811C:
    lda #$00                    ; 811C  A9 00
    ldy $0568,x                 ; 811E  BC 68 05
    bne L0_813C                 ; 8121  D0 19
    lda $05A8,x                 ; 8123  BD A8 05
    and #$07                    ; 8126  29 07
    tay                         ; 8128  A8
    cmp #$06                    ; 8129  C9 06
    bne L0_8139                 ; 812B  D0 0C
    lda $1A                     ; 812D  A5 1A
    lsr a                       ; 812F  4A
    lsr a                       ; 8130  4A
    lsr a                       ; 8131  4A
    and #$03                    ; 8132  29 03
    ora #$04                    ; 8134  09 04
    sta $0358,x                 ; 8136  9D 58 03

L0_8139:
    lda D0_8140,y               ; 8139  B9 40 81

L0_813C:
    sta $030A,x                 ; 813C  9D 0A 03
    rts                         ; 813F  60

D0_8140:
    .byte $33,$34,$31,$2F,$32,$30,$4E
D0_8147:
    .word D0_814F                   ; 8147
    .word L0_8161                   ; 8149
    .word L0_81E4                   ; 814B
    .word L_E809                    ; 814D
D0_814F:
    .word L0_B8BC                   ; 814F
    .byte $05,$B9,$5B,$81,$9D,$88,$05,$4C,$8E,$E7,$01,$05,$05,$01,$02,$00

L0_8161:
    ldy $05B8,x                 ; 8161  BC B8 05
    bne L0_816E                 ; 8164  D0 08
    lda $30                     ; 8166  A5 30
    cmp #$04                    ; 8168  C9 04
    bne L0_816E                 ; 816A  D0 02
    ldy #$05                    ; 816C  A0 05

L0_816E:
    lda D0_81D8,y               ; 816E  B9 D8 81
    sta $030A,x                 ; 8171  9D 0A 03
    lda D0_81DE,y               ; 8174  B9 DE 81
    sta $0358,x                 ; 8177  9D 58 03
    jsr L_E837                  ; 817A  20 37 E8
    ldy $05B8,x                 ; 817D  BC B8 05
    bne L0_818E                 ; 8180  D0 0C
    lda $59                     ; 8182  A5 59
    bpl L0_818E                 ; 8184  10 08
    jsr L_EC27                  ; 8186  20 27 EC
    bpl L0_81A5                 ; 8189  10 1A
    jmp L_E809                  ; 818B  4C 09 E8


L0_818E:
    dey                         ; 818E  88
    beq L0_81BF                 ; 818F  F0 2E
    dey                         ; 8191  88
    dey                         ; 8192  88
    beq L0_81AA                 ; 8193  F0 15
    dey                         ; 8195  88
    bne L0_81A5                 ; 8196  D0 0D
    lda $1A                     ; 8198  A5 1A
    lsr a                       ; 819A  4A
    lsr a                       ; 819B  4A
    and #$03                    ; 819C  29 03
    tay                         ; 819E  A8
    lda D0_81A6,y               ; 819F  B9 A6 81
    sta $0358,x                 ; 81A2  9D 58 03

L0_81A5:
    rts                         ; 81A5  60

D0_81A6:
    .byte $01,$41,$C1,$81

L0_81AA:
    lda $0324,x                 ; 81AA  BD 24 03
    cmp #$B4                    ; 81AD  C9 B4
    bcs L0_81BC                 ; 81AF  B0 0B
    lda $033E,x                 ; 81B1  BD 3E 03
    cmp #$20                    ; 81B4  C9 20
    bcc L0_81BC                 ; 81B6  90 04
    cmp #$E0                    ; 81B8  C9 E0
    bcc L0_8201                 ; 81BA  90 45

L0_81BC:
    jmp L_E809                  ; 81BC  4C 09 E8


L0_81BF:
    lda #$14                    ; 81BF  A9 14
    jsr L_EB42                  ; 81C1  20 42 EB
    lda $0324,x                 ; 81C4  BD 24 03
    cmp #$D0                    ; 81C7  C9 D0
    bcc L0_8201                 ; 81C9  90 36
    lda #$00                    ; 81CB  A9 00
    sta $0568,x                 ; 81CD  9D 68 05
    lda #$01                    ; 81D0  A9 01
    sta $0538,x                 ; 81D2  9D 38 05

L0_81D5:
    jmp L_E78E                  ; 81D5  4C 8E E7

D0_81D8:
    .byte $1E,$21,$21,$1E,$79,$07
D0_81DE:
    .byte $01,$02,$02,$01,$01,$02

L0_81E4:
    jsr L_E8A7                  ; 81E4  20 A7 E8
    dec $0538,x                 ; 81E7  DE 38 05
    bne L0_8201                 ; 81EA  D0 15
    lda #$08                    ; 81EC  A9 08
    sta $0538,x                 ; 81EE  9D 38 05
    inc $0568,x                 ; 81F1  FE 68 05
    ldy $0568,x                 ; 81F4  BC 68 05
    cpy #$03                    ; 81F7  C0 03
    bcs L0_81D5                 ; 81F9  B0 DA
    lda D0_8202,y               ; 81FB  B9 02 82
    sta $030A,x                 ; 81FE  9D 0A 03

L0_8201:
    rts                         ; 8201  60

D0_8202:
    .byte $37,$36,$37
D0_8205:
    .word L0_821B                   ; 8205
    .word L0_8225                   ; 8207
    .word L0_8248                   ; 8209
    .word L0_82B0                   ; 820B
    .word L0_82BD                   ; 820D
    .word L_E74B                    ; 820F
    .word L_E7B0                    ; 8211
    .word L_E806                    ; 8213
    .word L_E74B                    ; 8215
    .word L_E7B0                    ; 8217
    .word L_E806                    ; 8219

L0_821B:
    lda #$01                    ; 821B  A9 01
    sta $0568,x                 ; 821D  9D 68 05
    lda #$20                    ; 8220  A9 20

L0_8222:
    jmp L_E78B                  ; 8222  4C 8B E7


L0_8225:
    jsr L_E8A7                  ; 8225  20 A7 E8
    lda #$F0                    ; 8228  A9 F0
    ldy #$30                    ; 822A  A0 30
    jsr L0_849C                 ; 822C  20 9C 84
    bcc L0_829F                 ; 822F  90 6E
    lda #$18                    ; 8231  A9 18
    ldy #$C8                    ; 8233  A0 C8
    jsr L0_849C                 ; 8235  20 9C 84
    bcs L0_8243                 ; 8238  B0 09
    dec $0538,x                 ; 823A  DE 38 05
    bne L0_829F                 ; 823D  D0 60
    lda #$08                    ; 823F  A9 08
    bne L0_8222                 ; 8241  D0 DF

L0_8243:
    lda #$04                    ; 8243  A9 04
    jmp L_E81A                  ; 8245  4C 1A E8


L0_8248:
    jsr L_E8A7                  ; 8248  20 A7 E8
    lda #$18                    ; 824B  A9 18
    ldy #$C8                    ; 824D  A0 C8
    jsr L0_849C                 ; 824F  20 9C 84
    bcs L0_8243                 ; 8252  B0 EF
    dec $0538,x                 ; 8254  DE 38 05
    bne L0_829F                 ; 8257  D0 46
    lda #$08                    ; 8259  A9 08
    sta $0538,x                 ; 825B  9D 38 05
    lda $05C8,x                 ; 825E  BD C8 05
    bne L0_827B                 ; 8261  D0 18
    jsr L0_82A4                 ; 8263  20 A4 82
    bcs L0_829F                 ; 8266  B0 37
    lda $0568,x                 ; 8268  BD 68 05
    cmp #$02                    ; 826B  C9 02
    bcc L0_829C                 ; 826D  90 2D
    dec $0568,x                 ; 826F  DE 68 05
    lda #$01                    ; 8272  A9 01
    sta $0578,x                 ; 8274  9D 78 05
    lda #$01                    ; 8277  A9 01
    bne L0_828F                 ; 8279  D0 14

L0_827B:
    jsr L0_82A4                 ; 827B  20 A4 82
    bcs L0_829F                 ; 827E  B0 1F
    lda $0568,x                 ; 8280  BD 68 05
    bne L0_82A0                 ; 8283  D0 1B
    inc $0568,x                 ; 8285  FE 68 05
    lda #$F0                    ; 8288  A9 F0
    sta $0578,x                 ; 828A  9D 78 05
    lda #$00                    ; 828D  A9 00

L0_828F:
    sta $05C8,x                 ; 828F  9D C8 05
    lda #$40                    ; 8292  A9 40
    sta $0538,x                 ; 8294  9D 38 05
    lda #$02                    ; 8297  A9 02
    jmp L_E81A                  ; 8299  4C 1A E8


L0_829C:
    inc $0568,x                 ; 829C  FE 68 05

L0_829F:
    rts                         ; 829F  60


L0_82A0:
    dec $0568,x                 ; 82A0  DE 68 05
    rts                         ; 82A3  60


L0_82A4:
    ldy $0568,x                 ; 82A4  BC 68 05
    lda D0_82AD,y               ; 82A7  B9 AD 82
    jmp L_EBAA                  ; 82AA  4C AA EB

D0_82AD:
    .byte $00,$01,$02

L0_82B0:
    jsr L_E8A7                  ; 82B0  20 A7 E8
    lda #$00                    ; 82B3  A9 00
    jsr L_EBB5                  ; 82B5  20 B5 EB
    bcs L0_82F4                 ; 82B8  B0 3A
    jmp L_E809                  ; 82BA  4C 09 E8


L0_82BD:
    jsr L_E8A7                  ; 82BD  20 A7 E8
    lda $30                     ; 82C0  A5 30
    asl a                       ; 82C2  0A
    tay                         ; 82C3  A8
    lda $05A8,x                 ; 82C4  BD A8 05
    and #$08                    ; 82C7  29 08
    beq L0_82CC                 ; 82C9  F0 01
    iny                         ; 82CB  C8

L0_82CC:
    lda D0_82F5,y               ; 82CC  B9 F5 82
    jsr L_EBB5                  ; 82CF  20 B5 EB
    bcs L0_829F                 ; 82D2  B0 CB

L0_82D4:
    lda #$19                    ; 82D4  A9 19
    jsr L_C16B                  ; 82D6  20 6B C1
    jsr L_EB2F                  ; 82D9  20 2F EB
    jsr L_EAB3                  ; 82DC  20 B3 EA
    lda $05A8,x                 ; 82DF  BD A8 05
    and #$07                    ; 82E2  29 07
    sta $05A8,x                 ; 82E4  9D A8 05
    jsr L_EDF1                  ; 82E7  20 F1 ED
    lda #$01                    ; 82EA  A9 01
    sta $04B8,x                 ; 82EC  9D B8 04
    lda #$00                    ; 82EF  A9 00
    sta $0528,x                 ; 82F1  9D 28 05

L0_82F4:
    rts                         ; 82F4  60

D0_82F5:
    .byte $16,$16,$16,$16,$16,$16,$16,$16,$19,$1A,$03,$04,$09,$09,$16,$16
D0_8305:
    .word L0_830B                   ; 8305
    .word L0_835D                   ; 8307
    .word L0_8376                   ; 8309

L0_830B:
    lda #$03                    ; 830B  A9 03
    sta $0358,x                 ; 830D  9D 58 03
    lda $0324,x                 ; 8310  BD 24 03
    sta $05B8,x                 ; 8313  9D B8 05
    lda $033E,x                 ; 8316  BD 3E 03
    sta $05C8,x                 ; 8319  9D C8 05
    lda $41                     ; 831C  A5 41
    bne L0_832E                 ; 831E  D0 0E
    lda #$20                    ; 8320  A9 20
    jsr L_EB1F                  ; 8322  20 1F EB
    lda #$10                    ; 8325  A9 10
    sta $033E,x                 ; 8327  9D 3E 03
    ldy #$00                    ; 832A  A0 00
    beq L0_833A                 ; 832C  F0 0C

L0_832E:
    lda #$20                    ; 832E  A9 20
    jsr L_EB27                  ; 8330  20 27 EB
    lda #$E0                    ; 8333  A9 E0
    sta $0324,x                 ; 8335  9D 24 03
    ldy #$04                    ; 8338  A0 04

L0_833A:
    lda D0_8355,y               ; 833A  B9 55 83
    sta $04F8,x                 ; 833D  9D F8 04
    lda D0_8356,y               ; 8340  B9 56 83
    sta $04E8,x                 ; 8343  9D E8 04
    lda D0_8357,y               ; 8346  B9 57 83
    sta $0518,x                 ; 8349  9D 18 05
    lda D0_8358,y               ; 834C  B9 58 83
    sta $0508,x                 ; 834F  9D 08 05
    jmp L_E78E                  ; 8352  4C 8E E7

D0_8355:
    .byte $00
D0_8356:
    .byte $00
D0_8357:
    .byte $80
D0_8358:
    .byte $01,$80,$FE,$00,$00

L0_835D:
    lda #$4D                    ; 835D  A9 4D
    sta $030A,x                 ; 835F  9D 0A 03
    lda $41                     ; 8362  A5 41
    bne L0_836E                 ; 8364  D0 08
    ldy #$01                    ; 8366  A0 01
    jsr L_EC4B                  ; 8368  20 4B EC
    jmp L0_8373                 ; 836B  4C 73 83


L0_836E:
    ldy #$01                    ; 836E  A0 01
    jsr L_EC6F                  ; 8370  20 6F EC

L0_8373:
    jmp L_E837                  ; 8373  4C 37 E8


L0_8376:
    jmp L0_82D4                 ; 8376  4C D4 82

D0_8379:
    .word L0_838D                   ; 8379
    .word L0_8397                   ; 837B
    .word L0_83AC                   ; 837D
    .word L0_83D5                   ; 837F
    .word L0_842E                   ; 8381
    .word L0_8482                   ; 8383
    .word L0_848F                   ; 8385
    .word L_E74B                    ; 8387
    .word L_E7B0                    ; 8389
    .word L_E806                    ; 838B

L0_838D:
    jsr L_E8A7                  ; 838D  20 A7 E8
    lda #$06                    ; 8390  A9 06
    sta $05B8,x                 ; 8392  9D B8 05
    bne L0_83A8                 ; 8395  D0 11

L0_8397:
    jsr L_E8A7                  ; 8397  20 A7 E8
    lda #$F0                    ; 839A  A9 F0
    ldy #$30                    ; 839C  A0 30
    jsr L0_849C                 ; 839E  20 9C 84
    bcc L0_83AB                 ; 83A1  90 08
    lda #$08                    ; 83A3  A9 08

L0_83A5:
    sta $0538,x                 ; 83A5  9D 38 05

L0_83A8:
    jmp L_E78E                  ; 83A8  4C 8E E7


L0_83AB:
    rts                         ; 83AB  60


L0_83AC:
    jsr L_E8A7                  ; 83AC  20 A7 E8
    dec $0538,x                 ; 83AF  DE 38 05
    bne L0_83AB                 ; 83B2  D0 F7
    lda #$08                    ; 83B4  A9 08
    sta $0538,x                 ; 83B6  9D 38 05
    lda $0568,x                 ; 83B9  BD 68 05
    clc                         ; 83BC  18
    adc #$03                    ; 83BD  69 03
    jsr L_EBAA                  ; 83BF  20 AA EB
    bcs L0_83AB                 ; 83C2  B0 E7
    inc $0568,x                 ; 83C4  FE 68 05
    lda $0568,x                 ; 83C7  BD 68 05
    cmp #$03                    ; 83CA  C9 03
    bcc L0_83AB                 ; 83CC  90 DD
    jsr L_EB12                  ; 83CE  20 12 EB
    lda #$08                    ; 83D1  A9 08
    bne L0_83A5                 ; 83D3  D0 D0

L0_83D5:
    jsr L0_8424                 ; 83D5  20 24 84
    bcc L0_83DF                 ; 83D8  90 05

L0_83DA:
    lda #$06                    ; 83DA  A9 06
    jmp L_E81A                  ; 83DC  4C 1A E8


L0_83DF:
    dec $0538,x                 ; 83DF  DE 38 05
    bne L0_840B                 ; 83E2  D0 27
    ldy $2F                     ; 83E4  A4 2F
    lda D0_846B,y               ; 83E6  B9 6B 84
    sta $0538,x                 ; 83E9  9D 38 05
    jsr L_ECF5                  ; 83EC  20 F5 EC
    sty $0A                     ; 83EF  84 0A
    jsr L_EB2F                  ; 83F1  20 2F EB
    jsr L_F420                  ; 83F4  20 20 F4
    php                         ; 83F7  08
    lda $05B8,x                 ; 83F8  BD B8 05
    sec                         ; 83FB  38
    sbc #$06                    ; 83FC  E9 06
    bcs L0_8402                 ; 83FE  B0 02
    adc #$0C                    ; 8400  69 0C

L0_8402:
    clc                         ; 8402  18
    adc #$05                    ; 8403  69 05
    jsr L_EBAA                  ; 8405  20 AA EB
    bcc L0_840C                 ; 8408  90 02
    plp                         ; 840A  28

L0_840B:
    rts                         ; 840B  60


L0_840C:
    plp                         ; 840C  28
    bcc L0_840B                 ; 840D  90 FC
    lda $05A8,x                 ; 840F  BD A8 05
    and #$03                    ; 8412  29 03
    tay                         ; 8414  A8
    lda D0_8420,y               ; 8415  B9 20 84
    sta $05C8,x                 ; 8418  9D C8 05
    lda #$08                    ; 841B  A9 08
    jmp L_E78B                  ; 841D  4C 8B E7

D0_8420:
    .byte $01,$02,$03,$03

L0_8424:
    jsr L_E8A7                  ; 8424  20 A7 E8
    lda #$18                    ; 8427  A9 18
    ldy #$C8                    ; 8429  A0 C8
    jmp L0_849C                 ; 842B  4C 9C 84


L0_842E:
    jsr L0_8424                 ; 842E  20 24 84
    bcs L0_83DA                 ; 8431  B0 A7
    dec $0538,x                 ; 8433  DE 38 05
    bne L0_846A                 ; 8436  D0 32
    ldy $05B8,x                 ; 8438  BC B8 05
    lda D0_8473,y               ; 843B  B9 73 84
    clc                         ; 843E  18
    adc $0324,x                 ; 843F  7D 24 03
    sta $08                     ; 8442  85 08
    lda D0_8476,y               ; 8444  B9 76 84
    clc                         ; 8447  18
    adc $033E,x                 ; 8448  7D 3E 03
    sta $09                     ; 844B  85 09
    tya                         ; 844D  98
    ldy #$04                    ; 844E  A0 04
    jsr L_F2BE                  ; 8450  20 BE F2
    lda #$10                    ; 8453  A9 10
    sta $0538,x                 ; 8455  9D 38 05
    dec $05C8,x                 ; 8458  DE C8 05
    bne L0_846A                 ; 845B  D0 0D
    ldy $2F                     ; 845D  A4 2F
    lda D0_846F,y               ; 845F  B9 6F 84
    sta $0538,x                 ; 8462  9D 38 05
    lda #$04                    ; 8465  A9 04
    jmp L_E81A                  ; 8467  4C 1A E8


L0_846A:
    rts                         ; 846A  60

D0_846B:
    .byte $30,$28,$20,$18
D0_846F:
    .byte $80,$60,$40,$30
D0_8473:
    .byte $00,$07,$0C
D0_8476:
    .byte $0D,$0C,$07,$00,$F9,$F4,$F3,$F4,$F9,$00,$07,$0C

L0_8482:
    jsr L_E8A7                  ; 8482  20 A7 E8
    lda #$03                    ; 8485  A9 03
    jsr L_EBB5                  ; 8487  20 B5 EB
    bcs L0_84B7                 ; 848A  B0 2B
    jmp L_E809                  ; 848C  4C 09 E8


L0_848F:
    jsr L_E8A7                  ; 848F  20 A7 E8
    lda #$16                    ; 8492  A9 16
    jsr L_EBB5                  ; 8494  20 B5 EB
    bcs L0_84B7                 ; 8497  B0 1E
    jmp L_E78E                  ; 8499  4C 8E E7


L0_849C:
    sta $08                     ; 849C  85 08
    sty $09                     ; 849E  84 09
    lda $41                     ; 84A0  A5 41
    bne L0_84AD                 ; 84A2  D0 09
    lda $033E,x                 ; 84A4  BD 3E 03
    cmp $08                     ; 84A7  C5 08
    bcs L0_84B6                 ; 84A9  B0 0B
    bcc L0_84B4                 ; 84AB  90 07

L0_84AD:
    lda $0324,x                 ; 84AD  BD 24 03
    cmp $09                     ; 84B0  C5 09
    bcc L0_84B6                 ; 84B2  90 02

L0_84B4:
    sec                         ; 84B4  38
    rts                         ; 84B5  60


L0_84B6:
    clc                         ; 84B6  18

L0_84B7:
    rts                         ; 84B7  60

D0_84B8:
    .word L0_84CA                   ; 84B8
    .word L0_84D4                   ; 84BA
    .word L0_84E8                   ; 84BC
    .word L0_8537                   ; 84BE
    .word L0_85D1                   ; 84C0
    .word L0_85E1                   ; 84C2
    .word L_E74B                    ; 84C4
    .word L_E7B0                    ; 84C6
    .word L_E806                    ; 84C8

L0_84CA:
    jsr L_E8A7                  ; 84CA  20 A7 E8
    lda #$06                    ; 84CD  A9 06
    sta $05B8,x                 ; 84CF  9D B8 05
    bne L0_84E2                 ; 84D2  D0 0E

L0_84D4:
    lda #$F0                    ; 84D4  A9 F0
    ldy #$40                    ; 84D6  A0 40
    jsr L0_849C                 ; 84D8  20 9C 84
    bcc L0_84E5                 ; 84DB  90 08
    lda #$01                    ; 84DD  A9 01

L0_84DF:
    sta $0538,x                 ; 84DF  9D 38 05

L0_84E2:
    jsr L_E78E                  ; 84E2  20 8E E7

L0_84E5:
    jmp L_E8A7                  ; 84E5  4C A7 E8


L0_84E8:
    jsr L0_850E                 ; 84E8  20 0E 85
    bcs L0_84E5                 ; 84EB  B0 F8
    inc $0568,x                 ; 84ED  FE 68 05
    lda $0568,x                 ; 84F0  BD 68 05
    cmp #$04                    ; 84F3  C9 04
    bcc L0_84E5                 ; 84F5  90 EE
    lda #$02                    ; 84F7  A9 02
    sta $05C8,x                 ; 84F9  9D C8 05
    lda #$28                    ; 84FC  A9 28
    ldy $31                     ; 84FE  A4 31
    beq L0_8504                 ; 8500  F0 02
    lda #$08                    ; 8502  A9 08

L0_8504:
    sta $0558,x                 ; 8504  9D 58 05
    jsr L_EB12                  ; 8507  20 12 EB
    lda #$10                    ; 850A  A9 10
    bne L0_84DF                 ; 850C  D0 D1

L0_850E:
    dec $0538,x                 ; 850E  DE 38 05
    bne L0_852A                 ; 8511  D0 17
    lda #$04                    ; 8513  A9 04
    sta $0538,x                 ; 8515  9D 38 05
    lda $05A8,x                 ; 8518  BD A8 05
    lsr a                       ; 851B  4A
    lda $0568,x                 ; 851C  BD 68 05
    bcc L0_8523                 ; 851F  90 02
    adc #$03                    ; 8521  69 03

L0_8523:
    tay                         ; 8523  A8
    lda D0_852C,y               ; 8524  B9 2C 85
    jmp L_EBAA                  ; 8527  4C AA EB


L0_852A:
    sec                         ; 852A  38
    rts                         ; 852B  60

D0_852C:
    .byte $16,$14
D0_852E:
    .byte $18,$11,$17,$15,$18,$11,$11,$12,$13

L0_8537:
    jsr L_E8A7                  ; 8537  20 A7 E8
    lda #$30                    ; 853A  A9 30
    ldy #$C0                    ; 853C  A0 C0
    jsr L0_849C                 ; 853E  20 9C 84
    bcc L0_8550                 ; 8541  90 0D
    lda #$02                    ; 8543  A9 02
    sta $0568,x                 ; 8545  9D 68 05
    jsr L_EB07                  ; 8548  20 07 EB
    lda #$01                    ; 854B  A9 01
    jmp L_E78B                  ; 854D  4C 8B E7


L0_8550:
    jsr L_ECC7                  ; 8550  20 C7 EC
    jsr L0_85F6                 ; 8553  20 F6 85
    tya                         ; 8556  98
    bcs L0_855B                 ; 8557  B0 02
    eor #$01                    ; 8559  49 01

L0_855B:
    sta $0A                     ; 855B  85 0A
    jsr L_EB2F                  ; 855D  20 2F EB
    jsr L_F44D                  ; 8560  20 4D F4
    sta $08                     ; 8563  85 08
    dec $0538,x                 ; 8565  DE 38 05
    bne L0_8591                 ; 8568  D0 27
    lda #$10                    ; 856A  A9 10
    sta $0538,x                 ; 856C  9D 38 05
    ldy $05B8,x                 ; 856F  BC B8 05
    lda $08                     ; 8572  A5 08
    bmi L0_8591                 ; 8574  30 1B
    bne L0_8581                 ; 8576  D0 09
    cpy #$08                    ; 8578  C0 08
    beq L0_8591                 ; 857A  F0 15
    inc $05B8,x                 ; 857C  FE B8 05
    bne L0_8588                 ; 857F  D0 07

L0_8581:
    cpy #$06                    ; 8581  C0 06
    beq L0_8591                 ; 8583  F0 0C
    dec $05B8,x                 ; 8585  DE B8 05

L0_8588:
    ldy $05B8,x                 ; 8588  BC B8 05
    lda D0_852E,y               ; 858B  B9 2E 85
    jsr L_EBAA                  ; 858E  20 AA EB

L0_8591:
    dec $0558,x                 ; 8591  DE 58 05
    bne L0_85CA                 ; 8594  D0 34
    ldy #$10                    ; 8596  A0 10
    dec $05C8,x                 ; 8598  DE C8 05
    bpl L0_85A4                 ; 859B  10 07
    lda #$02                    ; 859D  A9 02
    sta $05C8,x                 ; 859F  9D C8 05
    ldy #$50                    ; 85A2  A0 50

L0_85A4:
    tya                         ; 85A4  98
    sta $0558,x                 ; 85A5  9D 58 05
    ldy $0F                     ; 85A8  A4 0F
    jsr L0_85F6                 ; 85AA  20 F6 85
    bcc L0_85CA                 ; 85AD  90 1B
    ldy $05B8,x                 ; 85AF  BC B8 05
    lda L0_85C5,y               ; 85B2  B9 C5 85
    clc                         ; 85B5  18
    adc $0324,x                 ; 85B6  7D 24 03
    sta $08                     ; 85B9  85 08
    lda L0_85C7+1,y             ; 85BB  B9 C8 85
    clc                         ; 85BE  18
    adc $033E,x                 ; 85BF  7D 3E 03
    sta $09                     ; 85C2  85 09
    tya                         ; 85C4  98

L0_85C5:
    ldy #$05                    ; 85C5  A0 05

L0_85C7:
    jmp L_F2BE                  ; 85C7  4C BE F2


L0_85CA:
    rts                         ; 85CA  60

    .byte $00,$F8,$F0,$F2,$F2,$F8

L0_85D1:
    jsr L_E8A7                  ; 85D1  20 A7 E8
    jsr L0_850E                 ; 85D4  20 0E 85
    bcs L0_85CA                 ; 85D7  B0 F1
    dec $0568,x                 ; 85D9  DE 68 05
    bpl L0_85CA                 ; 85DC  10 EC
    jmp L_E809                  ; 85DE  4C 09 E8


L0_85E1:
    jsr L_E8A7                  ; 85E1  20 A7 E8
    lda $05A8,x                 ; 85E4  BD A8 05
    lsr a                       ; 85E7  4A
    lda #$16                    ; 85E8  A9 16
    bcc L0_85EE                 ; 85EA  90 02
    lda #$17                    ; 85EC  A9 17

L0_85EE:
    jsr L_EBB5                  ; 85EE  20 B5 EB
    bcs L0_85CA                 ; 85F1  B0 D7
    jmp L_E78E                  ; 85F3  4C 8E E7


L0_85F6:
    lda $0324,x                 ; 85F6  BD 24 03
    clc                         ; 85F9  18
    adc #$20                    ; 85FA  69 20
    cmp $031A,y                 ; 85FC  D9 1A 03
    bcc L0_8607                 ; 85FF  90 06
    lda $033E,x                 ; 8601  BD 3E 03
    cmp $0334,y                 ; 8604  D9 34 03

L0_8607:
    rts                         ; 8607  60

D0_8608:
    .word L0_861E                   ; 8608
    .word L0_8665                   ; 860A
    .word L0_86AF                   ; 860C
    .word L0_8803                   ; 860E
    .word L0_88C3                   ; 8610
    .word L0_8900                   ; 8612
    .word L_E74B                    ; 8614
    .word L_E7B0                    ; 8616
    .word L_E806                    ; 8618
    .word L0_888C                   ; 861A
    .word L0_88A1                   ; 861C

L0_861E:
    jsr L_E8A7                  ; 861E  20 A7 E8
    jsr L_EB88                  ; 8621  20 88 EB
    lda $05A8,x                 ; 8624  BD A8 05
    lsr a                       ; 8627  4A
    lsr a                       ; 8628  4A
    lsr a                       ; 8629  4A
    lsr a                       ; 862A  4A
    and #$03                    ; 862B  29 03
    tay                         ; 862D  A8
    lda D0_8634,y               ; 862E  B9 34 86
    jmp L_E78B                  ; 8631  4C 8B E7

D0_8634:
    .byte $01,$10,$20,$30

L0_8638:
    jsr L0_863E                 ; 8638  20 3E 86
    jmp L_E8D0                  ; 863B  4C D0 E8


L0_863E:
    ldy #$00                    ; 863E  A0 00
    lda $41                     ; 8640  A5 41
    beq L0_8646                 ; 8642  F0 02
    ldy #$04                    ; 8644  A0 04

L0_8646:
    sty $08                     ; 8646  84 08
    lda $05C8,x                 ; 8648  BD C8 05
    asl a                       ; 864B  0A
    clc                         ; 864C  18
    adc $08                     ; 864D  65 08
    tay                         ; 864F  A8
    lda D0_865D,y               ; 8650  B9 5D 86
    sta $0518,x                 ; 8653  9D 18 05
    lda D0_865E,y               ; 8656  B9 5E 86
    sta $0508,x                 ; 8659  9D 08 05

L0_865C:
    rts                         ; 865C  60

D0_865D:
    .byte $00
D0_865E:
    .byte $FF,$40,$01,$00,$FF,$00,$01

L0_8665:
    lda $41                     ; 8665  A5 41
    beq L0_866F                 ; 8667  F0 06
    jsr L_E8A7                  ; 8669  20 A7 E8
    jmp L0_8686                 ; 866C  4C 86 86


L0_866F:
    lda $68                     ; 866F  A5 68
    beq L0_8686                 ; 8671  F0 13
    lda $05A8,x                 ; 8673  BD A8 05
    and #$01                    ; 8676  29 01
    beq L0_8681                 ; 8678  F0 07
    and $1A                     ; 867A  25 1A
    lsr a                       ; 867C  4A
    bcs L0_8686                 ; 867D  B0 07
    bcc L0_865C                 ; 867F  90 DB

L0_8681:
    dec $0538,x                 ; 8681  DE 38 05
    beq L0_868B                 ; 8684  F0 05

L0_8686:
    dec $0538,x                 ; 8686  DE 38 05
    bne L0_865C                 ; 8689  D0 D1

L0_868B:
    ldy #$10                    ; 868B  A0 10
    jsr L_EC33                  ; 868D  20 33 EC
    bne L0_8695                 ; 8690  D0 03
    jmp L_E809                  ; 8692  4C 09 E8


L0_8695:
    jsr L_EB16                  ; 8695  20 16 EB
    lda $05A8,x                 ; 8698  BD A8 05
    and #$01                    ; 869B  29 01
    sta $05C8,x                 ; 869D  9D C8 05
    beq L0_86A7                 ; 86A0  F0 05
    lda #$0A                    ; 86A2  A9 0A
    sta $033E,x                 ; 86A4  9D 3E 03

L0_86A7:
    jsr L0_8638                 ; 86A7  20 38 86
    lda #$10                    ; 86AA  A9 10
    jmp L_E78B                  ; 86AC  4C 8B E7


L0_86AF:
    lda $05D8,x                 ; 86AF  BD D8 05
    beq L0_86E7                 ; 86B2  F0 33
    lda #$0A                    ; 86B4  A9 0A
    sta $0568,x                 ; 86B6  9D 68 05
    lda $04E8,x                 ; 86B9  BD E8 04
    bmi L0_86E1                 ; 86BC  30 23
    ldy #$10                    ; 86BE  A0 10
    jsr L_EC33                  ; 86C0  20 33 EC
    bmi L0_86C7                 ; 86C3  30 02
    bcc L0_86D8                 ; 86C5  90 11

L0_86C7:
    lda #$00                    ; 86C7  A9 00
    sta $05D8,x                 ; 86C9  9D D8 05
    sta $0568,x                 ; 86CC  9D 68 05
    jsr L_EB88                  ; 86CF  20 88 EB
    jsr L0_8638                 ; 86D2  20 38 86
    jmp L0_8794                 ; 86D5  4C 94 87


L0_86D8:
    cmp #$02                    ; 86D8  C9 02
    bne L0_86E1                 ; 86DA  D0 05
    lda #$0A                    ; 86DC  A9 0A
    jsr L_E81A                  ; 86DE  20 1A E8

L0_86E1:
    jsr L_EB40                  ; 86E1  20 40 EB
    jmp L0_8794                 ; 86E4  4C 94 87


L0_86E7:
    lda $05A8,x                 ; 86E7  BD A8 05
    and #$0C                    ; 86EA  29 0C
    beq L0_870D                 ; 86EC  F0 1F
    lda $8E                     ; 86EE  A5 8E
    beq L0_870D                 ; 86F0  F0 1B
    dec $0538,x                 ; 86F2  DE 38 05
    bne L0_870D                 ; 86F5  D0 16
    lda #$80                    ; 86F7  A9 80
    sta $0538,x                 ; 86F9  9D 38 05
    lda #$08                    ; 86FC  A9 08
    sta $0558,x                 ; 86FE  9D 58 05
    jsr L0_87D9                 ; 8701  20 D9 87
    sta $05D8,x                 ; 8704  9D D8 05
    jsr L_E78E                  ; 8707  20 8E E7
    jmp L0_87C5                 ; 870A  4C C5 87


L0_870D:
    inc $0548,x                 ; 870D  FE 48 05
    lda $0548,x                 ; 8710  BD 48 05
    and #$07                    ; 8713  29 07
    bne L0_8726                 ; 8715  D0 0F
    inc $0568,x                 ; 8717  FE 68 05
    lda $0568,x                 ; 871A  BD 68 05
    cmp #$06                    ; 871D  C9 06
    bcc L0_8726                 ; 871F  90 05
    lda #$00                    ; 8721  A9 00
    sta $0568,x                 ; 8723  9D 68 05

L0_8726:
    ldy #$10                    ; 8726  A0 10
    lda $0508,x                 ; 8728  BD 08 05
    jsr L_EC35                  ; 872B  20 35 EC
    bmi L0_8794                 ; 872E  30 64
    bcs L0_8794                 ; 8730  B0 62
    lda $05E8,x                 ; 8732  BD E8 05
    cmp #$02                    ; 8735  C9 02
    bcs L0_8746                 ; 8737  B0 0D
    lda $05A8,x                 ; 8739  BD A8 05
    and #$02                    ; 873C  29 02
    beq L0_8746                 ; 873E  F0 06
    jsr L0_87CB                 ; 8740  20 CB 87
    jmp L0_8794                 ; 8743  4C 94 87


L0_8746:
    inc $05D8,x                 ; 8746  FE D8 05
    jsr L_ECF5                  ; 8749  20 F5 EC
    lda $031A,y                 ; 874C  B9 1A 03
    sec                         ; 874F  38
    sbc $0324,x                 ; 8750  FD 24 03
    ldy #$04                    ; 8753  A0 04
    bcs L0_875D                 ; 8755  B0 06
    eor #$FF                    ; 8757  49 FF
    adc #$01                    ; 8759  69 01
    ldy #$00                    ; 875B  A0 00

L0_875D:
    cmp #$10                    ; 875D  C9 10
    bcs L0_8763                 ; 875F  B0 02
    ldy #$00                    ; 8761  A0 00

L0_8763:
    sty $08                     ; 8763  84 08
    lda $34                     ; 8765  A5 34
    and #$03                    ; 8767  29 03
    clc                         ; 8769  18
    adc $08                     ; 876A  65 08
    tay                         ; 876C  A8
    lda D0_87F3,y               ; 876D  B9 F3 87
    tay                         ; 8770  A8
    lda D0_87FB,y               ; 8771  B9 FB 87
    sta $04F8,x                 ; 8774  9D F8 04
    lda D0_87FC,y               ; 8777  B9 FC 87
    sta $04E8,x                 ; 877A  9D E8 04
    lda D0_87FD,y               ; 877D  B9 FD 87
    sta $0518,x                 ; 8780  9D 18 05
    lda D0_87FE,y               ; 8783  B9 FE 87
    sta $0508,x                 ; 8786  9D 08 05
    lda $05C8,x                 ; 8789  BD C8 05
    beq L0_8791                 ; 878C  F0 03
    jsr L_E91E                  ; 878E  20 1E E9

L0_8791:
    jmp L0_87C5                 ; 8791  4C C5 87


L0_8794:
    jsr L_EC27                  ; 8794  20 27 EC
    bpl L0_879E                 ; 8797  10 05
    lda #$07                    ; 8799  A9 07
    jmp L_E81A                  ; 879B  4C 1A E8


L0_879E:
    lda $05E8,x                 ; 879E  BD E8 05
    cmp #$02                    ; 87A1  C9 02
    bcs L0_87C5                 ; 87A3  B0 20
    lda #$F8                    ; 87A5  A9 F8
    ldy $05C8,x                 ; 87A7  BC C8 05
    beq L0_87AE                 ; 87AA  F0 02
    lda #$08                    ; 87AC  A9 08

L0_87AE:
    clc                         ; 87AE  18
    adc $033E,x                 ; 87AF  7D 3E 03
    cmp #$F0                    ; 87B2  C9 F0
    bcs L0_87C5                 ; 87B4  B0 0F
    cmp #$10                    ; 87B6  C9 10
    bcc L0_87C5                 ; 87B8  90 0B
    ldy $0324,x                 ; 87BA  BC 24 03
    jsr L_E087                  ; 87BD  20 87 E0
    bpl L0_87C5                 ; 87C0  10 03
    jsr L0_87CB                 ; 87C2  20 CB 87

L0_87C5:
    jsr L0_891A                 ; 87C5  20 1A 89
    jmp L_E837                  ; 87C8  4C 37 E8


L0_87CB:
    inc $05E8,x                 ; 87CB  FE E8 05
    lda $05C8,x                 ; 87CE  BD C8 05
    eor #$01                    ; 87D1  49 01
    sta $05C8,x                 ; 87D3  9D C8 05
    jmp L0_863E                 ; 87D6  4C 3E 86


L0_87D9:
    lda $2F                     ; 87D9  A5 2F
    and #$02                    ; 87DB  29 02
    asl a                       ; 87DD  0A
    sta $08                     ; 87DE  85 08
    lda $34                     ; 87E0  A5 34
    and #$03                    ; 87E2  29 03
    adc $08                     ; 87E4  65 08
    tay                         ; 87E6  A8
    lda D0_87EB,y               ; 87E7  B9 EB 87
    rts                         ; 87EA  60

D0_87EB:
    .byte $01,$01,$02,$01,$02,$01,$02,$02
D0_87F3:
    .byte $00,$00,$04,$00,$04,$00,$04,$04
D0_87FB:
    .byte $00
D0_87FC:
    .byte $FE
D0_87FD:
    .byte $48
D0_87FE:
    .byte $FF,$00,$FF,$60,$FF

L0_8803:
    lda $05A8,x                 ; 8803  BD A8 05
    and #$0C                    ; 8806  29 0C
    cmp #$05                    ; 8808  C9 05
    ldy #$00                    ; 880A  A0 00
    lda #$06                    ; 880C  A9 06
    bcc L0_8819                 ; 880E  90 09
    lda #$1B                    ; 8810  A9 1B
    sta $0588,x                 ; 8812  9D 88 05
    ldy #$02                    ; 8815  A0 02
    lda #$07                    ; 8817  A9 07

L0_8819:
    sta $0568,x                 ; 8819  9D 68 05
    dec $0558,x                 ; 881C  DE 58 05
    bne L0_8864                 ; 881F  D0 43
    dec $05D8,x                 ; 8821  DE D8 05
    bmi L0_886A                 ; 8824  30 44
    lda #$10                    ; 8826  A9 10
    sta $0558,x                 ; 8828  9D 58 05
    lda $05C8,x                 ; 882B  BD C8 05
    beq L0_8831                 ; 882E  F0 01
    iny                         ; 8830  C8

L0_8831:
    lda $0324,x                 ; 8831  BD 24 03
    clc                         ; 8834  18
    adc D0_8882,y               ; 8835  79 82 88
    sta $08                     ; 8838  85 08
    lda D0_8886,y               ; 883A  B9 86 88
    clc                         ; 883D  18
    bmi L0_8847                 ; 883E  30 07
    adc $033E,x                 ; 8840  7D 3E 03
    bcs L0_8864                 ; 8843  B0 1F
    bcc L0_8850                 ; 8845  90 09

L0_8847:
    adc $033E,x                 ; 8847  7D 3E 03
    bcc L0_8864                 ; 884A  90 18
    cmp #$08                    ; 884C  C9 08
    bcc L0_8864                 ; 884E  90 14

L0_8850:
    sta $09                     ; 8850  85 09
    ldy $05C8,x                 ; 8852  BC C8 05
    lda D0_888A,y               ; 8855  B9 8A 88
    ldy #$06                    ; 8858  A0 06
    jsr L_F2BE                  ; 885A  20 BE F2
    bne L0_8864                 ; 885D  D0 05
    lda #$06                    ; 885F  A9 06
    sta $05B8,x                 ; 8861  9D B8 05

L0_8864:
    jsr L0_891A                 ; 8864  20 1A 89
    jmp L_E8A7                  ; 8867  4C A7 E8


L0_886A:
    lda #$10                    ; 886A  A9 10
    sta $0588,x                 ; 886C  9D 88 05
    lda #$00                    ; 886F  A9 00
    sta $05D8,x                 ; 8871  9D D8 05
    sta $0568,x                 ; 8874  9D 68 05
    jsr L0_891A                 ; 8877  20 1A 89
    jsr L_E8A7                  ; 887A  20 A7 E8
    lda #$03                    ; 887D  A9 03
    jmp L_E81A                  ; 887F  4C 1A E8

D0_8882:
    .byte $F7,$F7,$0A,$0A
D0_8886:
    .byte $F0,$10,$F0,$10
D0_888A:
    .byte $06,$00

L0_888C:
    lda #$08                    ; 888C  A9 08
    sta $0568,x                 ; 888E  9D 68 05
    lda #$10                    ; 8891  A9 10
    jsr L0_88BA                 ; 8893  20 BA 88
    jsr L0_891A                 ; 8896  20 1A 89
    jsr L_E8A7                  ; 8899  20 A7 E8
    lda #$08                    ; 889C  A9 08
    jmp L_E78B                  ; 889E  4C 8B E7


L0_88A1:
    dec $0538,x                 ; 88A1  DE 38 05
    bne L0_88BD                 ; 88A4  D0 17
    lda #$08                    ; 88A6  A9 08
    sta $0538,x                 ; 88A8  9D 38 05
    inc $0568,x                 ; 88AB  FE 68 05
    lda $0568,x                 ; 88AE  BD 68 05
    cmp #$0A                    ; 88B1  C9 0A
    bcc L0_88B8                 ; 88B3  90 03
    jmp L_E809                  ; 88B5  4C 09 E8


L0_88B8:
    lda #$08                    ; 88B8  A9 08

L0_88BA:
    jsr L_EB1F                  ; 88BA  20 1F EB

L0_88BD:
    jsr L0_891A                 ; 88BD  20 1A 89
    jmp L_E8A7                  ; 88C0  4C A7 E8


L0_88C3:
    lda #$0B                    ; 88C3  A9 0B
    sta $0568,x                 ; 88C5  9D 68 05
    jsr L0_891A                 ; 88C8  20 1A 89

L0_88CB:
    jsr L_EB07                  ; 88CB  20 07 EB
    lda #$80                    ; 88CE  A9 80
    sta $04F8,x                 ; 88D0  9D F8 04
    lda #$FC                    ; 88D3  A9 FC
    sta $04E8,x                 ; 88D5  9D E8 04
    lda #$60                    ; 88D8  A9 60
    sta $0518,x                 ; 88DA  9D 18 05
    lda #$00                    ; 88DD  A9 00
    sta $0508,x                 ; 88DF  9D 08 05
    lda $033E,x                 ; 88E2  BD 3E 03
    cmp #$10                    ; 88E5  C9 10
    bcc L0_88ED                 ; 88E7  90 04
    cmp #$F0                    ; 88E9  C9 F0
    bcc L0_88F0                 ; 88EB  90 03

L0_88ED:
    jsr L_E8D9                  ; 88ED  20 D9 E8

L0_88F0:
    lda $05C8,x                 ; 88F0  BD C8 05
    beq L0_88F8                 ; 88F3  F0 03
    jsr L_E91E                  ; 88F5  20 1E E9

L0_88F8:
    jsr L_E8A7                  ; 88F8  20 A7 E8
    lda #$10                    ; 88FB  A9 10
    jmp L_E78B                  ; 88FD  4C 8B E7


L0_8900:
    jsr L0_891A                 ; 8900  20 1A 89

L0_8903:
    lda #$30                    ; 8903  A9 30
    jsr L_EB42                  ; 8905  20 42 EB
    lda $0324,x                 ; 8908  BD 24 03
    cmp #$08                    ; 890B  C9 08
    bcc L0_8917                 ; 890D  90 08
    jsr L_E837                  ; 890F  20 37 E8
    dec $0538,x                 ; 8912  DE 38 05
    bne L0_8939                 ; 8915  D0 22

L0_8917:
    jmp L_E78E                  ; 8917  4C 8E E7


L0_891A:
    ldy $0568,x                 ; 891A  BC 68 05
    lda D0_893A,y               ; 891D  B9 3A 89
    sta $030A,x                 ; 8920  9D 0A 03
    lda #$40                    ; 8923  A9 40
    ldy $05C8,x                 ; 8925  BC C8 05
    beq L0_892C                 ; 8928  F0 02
    lda #$00                    ; 892A  A9 00

L0_892C:
    ldy $05B8,x                 ; 892C  BC B8 05
    beq L0_8936                 ; 892F  F0 05
    dec $05B8,x                 ; 8931  DE B8 05
    ora #$08                    ; 8934  09 08

L0_8936:
    sta $0358,x                 ; 8936  9D 58 03

L0_8939:
    rts                         ; 8939  60

D0_893A:
    .byte $3B,$3C,$3D,$3F,$3C,$3E,$40,$26,$73,$18,$28,$27
D0_8946:
    .word L0_8958                   ; 8946
    .word L0_8982                   ; 8948
    .word L0_89D2                   ; 894A
    .word L0_8AB3                   ; 894C
    .word L0_8AF1                   ; 894E
    .word L0_8AFC                   ; 8950
    .word L_E74B                    ; 8952
    .word L_E7B0                    ; 8954
    .word L_E806                    ; 8956

L0_8958:
    ldy $05A8,x                 ; 8958  BC A8 05
    lda D0_8979,y               ; 895B  B9 79 89
    sta $0538,x                 ; 895E  9D 38 05
    lda D0_897F,y               ; 8961  B9 7F 89
    sta $0568,x                 ; 8964  9D 68 05
    jsr L_EB88                  ; 8967  20 88 EB
    lda $05A8,x                 ; 896A  BD A8 05
    cmp #$01                    ; 896D  C9 01
    bne L0_8976                 ; 896F  D0 05
    lda #$05                    ; 8971  A9 05
    jsr L_EB1F                  ; 8973  20 1F EB

L0_8976:
    jmp L_E78E                  ; 8976  4C 8E E7

D0_8979:
    .byte $01,$30,$80
D0_897C:
    .byte $01,$60,$80
D0_897F:
    .byte $03,$00,$00

L0_8982:
    jsr L0_8B02                 ; 8982  20 02 8B
    jsr L_E8A7                  ; 8985  20 A7 E8
    dec $0538,x                 ; 8988  DE 38 05
    bne L0_89CB                 ; 898B  D0 3E
    ldy $05A8,x                 ; 898D  BC A8 05
    beq L0_89B4                 ; 8990  F0 22
    lda #$08                    ; 8992  A9 08
    sta $0538,x                 ; 8994  9D 38 05
    inc $0568,x                 ; 8997  FE 68 05
    lda $0568,x                 ; 899A  BD 68 05
    cmp #$03                    ; 899D  C9 03
    bcc L0_89CB                 ; 899F  90 2A
    cpy #$01                    ; 89A1  C0 01
    bne L0_89AA                 ; 89A3  D0 05
    dec $0568,x                 ; 89A5  DE 68 05
    bne L0_89B4                 ; 89A8  D0 0A

L0_89AA:
    lda #$F2                    ; 89AA  A9 F2
    jsr L_EB1F                  ; 89AC  20 1F EB
    lda #$01                    ; 89AF  A9 01
    jsr L_EB27                  ; 89B1  20 27 EB

L0_89B4:
    jsr L_EB16                  ; 89B4  20 16 EB
    lda #$30                    ; 89B7  A9 30
    sta $0588,x                 ; 89B9  9D 88 05
    lda D0_89CC,y               ; 89BC  B9 CC 89
    sta $0558,x                 ; 89BF  9D 58 05
    lda D0_89CF,y               ; 89C2  B9 CF 89
    sta $05E8,x                 ; 89C5  9D E8 05
    jmp L_E78E                  ; 89C8  4C 8E E7


L0_89CB:
    rts                         ; 89CB  60

D0_89CC:
    .byte $40,$04,$10
D0_89CF:
    .byte $03,$01,$03

L0_89D2:
    jsr L0_8B02                 ; 89D2  20 02 8B
    jsr L_E8A7                  ; 89D5  20 A7 E8
    dec $0558,x                 ; 89D8  DE 58 05
    bne L0_89CB                 ; 89DB  D0 EE
    dec $05E8,x                 ; 89DD  DE E8 05
    bpl L0_89E5                 ; 89E0  10 03
    jmp L0_8A84                 ; 89E2  4C 84 8A


L0_89E5:
    lda #$18                    ; 89E5  A9 18
    sta $0558,x                 ; 89E7  9D 58 05
    jsr L_ECF5                  ; 89EA  20 F5 EC
    sty $0A                     ; 89ED  84 0A
    lda $0334,y                 ; 89EF  B9 34 03
    cmp $033E,x                 ; 89F2  DD 3E 03
    lda #$00                    ; 89F5  A9 00
    bcc L0_89FB                 ; 89F7  90 02
    lda #$01                    ; 89F9  A9 01

L0_89FB:
    sta $05C8,x                 ; 89FB  9D C8 05
    lda $05A8,x                 ; 89FE  BD A8 05
    lsr a                       ; 8A01  4A
    bcc L0_8A12                 ; 8A02  90 0E
    lda #$00                    ; 8A04  A9 00
    ldy $05C8,x                 ; 8A06  BC C8 05
    bne L0_8A0D                 ; 8A09  D0 02
    lda #$0C                    ; 8A0B  A9 0C

L0_8A0D:
    sta $0C                     ; 8A0D  85 0C
    jmp L0_8A25                 ; 8A0F  4C 25 8A


L0_8A12:
    ldy #$00                    ; 8A12  A0 00
    lda $05A8,x                 ; 8A14  BD A8 05
    cmp #$02                    ; 8A17  C9 02
    bne L0_8A1D                 ; 8A19  D0 02
    ldy #$F0                    ; 8A1B  A0 F0

L0_8A1D:
    lda #$00                    ; 8A1D  A9 00
    jsr L_EB32                  ; 8A1F  20 32 EB
    jsr L_F451                  ; 8A22  20 51 F4

L0_8A25:
    lda $0C                     ; 8A25  A5 0C
    clc                         ; 8A27  18
    adc #$06                    ; 8A28  69 06
    cmp #$18                    ; 8A2A  C9 18
    bcc L0_8A30                 ; 8A2C  90 02
    sbc #$18                    ; 8A2E  E9 18

L0_8A30:
    cmp #$0C                    ; 8A30  C9 0C
    bcc L0_8A3B                 ; 8A32  90 07
    sta $08                     ; 8A34  85 08
    lda #$18                    ; 8A36  A9 18
    sec                         ; 8A38  38
    sbc $08                     ; 8A39  E5 08

L0_8A3B:
    ldy #$00                    ; 8A3B  A0 00
    cmp #$05                    ; 8A3D  C9 05
    bcc L0_8A47                 ; 8A3F  90 06
    iny                         ; 8A41  C8
    cmp #$08                    ; 8A42  C9 08
    bcc L0_8A47                 ; 8A44  90 01
    iny                         ; 8A46  C8

L0_8A47:
    lda $05A8,x                 ; 8A47  BD A8 05
    cmp #$01                    ; 8A4A  C9 01
    beq L0_8A54                 ; 8A4C  F0 06
    lda D0_8AA7,y               ; 8A4E  B9 A7 8A
    sta $0568,x                 ; 8A51  9D 68 05

L0_8A54:
    lda $0324,x                 ; 8A54  BD 24 03
    clc                         ; 8A57  18
    adc D0_8AAA,y               ; 8A58  79 AA 8A
    sta $08                     ; 8A5B  85 08
    lda $05C8,x                 ; 8A5D  BD C8 05
    lsr a                       ; 8A60  4A
    lda D0_8AAD,y               ; 8A61  B9 AD 8A
    bcc L0_8A6A                 ; 8A64  90 04
    eor #$FF                    ; 8A66  49 FF
    adc #$00                    ; 8A68  69 00

L0_8A6A:
    clc                         ; 8A6A  18
    adc $033E,x                 ; 8A6B  7D 3E 03
    sta $09                     ; 8A6E  85 09
    ldy $05A8,x                 ; 8A70  BC A8 05
    lda D0_8AB0,y               ; 8A73  B9 B0 8A
    tay                         ; 8A76  A8
    lda $0C                     ; 8A77  A5 0C
    jsr L_F2BF                  ; 8A79  20 BF F2
    bne L0_8A83                 ; 8A7C  D0 05
    lda #$06                    ; 8A7E  A9 06
    sta $05D8,x                 ; 8A80  9D D8 05

L0_8A83:
    rts                         ; 8A83  60


L0_8A84:
    ldy $05A8,x                 ; 8A84  BC A8 05
    bne L0_8A95                 ; 8A87  D0 0C
    lda D0_89CF,y               ; 8A89  B9 CF 89
    sta $05E8,x                 ; 8A8C  9D E8 05
    lda #$80                    ; 8A8F  A9 80
    sta $0558,x                 ; 8A91  9D 58 05
    rts                         ; 8A94  60


L0_8A95:
    lda $05A8,x                 ; 8A95  BD A8 05
    lsr a                       ; 8A98  4A
    lda #$02                    ; 8A99  A9 02
    bcs L0_8A9F                 ; 8A9B  B0 02
    lda #$03                    ; 8A9D  A9 03

L0_8A9F:
    sta $0568,x                 ; 8A9F  9D 68 05
    lda #$80                    ; 8AA2  A9 80
    jmp L_E78B                  ; 8AA4  4C 8B E7

D0_8AA7:
    .byte $04,$03,$05
D0_8AAA:
    .byte $EE,$F5,$06
D0_8AAD:
    .byte $F3,$F1,$F1
D0_8AB0:
    .byte $03,$05,$03

L0_8AB3:
    dec $0538,x                 ; 8AB3  DE 38 05
    bne L0_8AEB                 ; 8AB6  D0 33
    jsr L_EB07                  ; 8AB8  20 07 EB
    lda #$08                    ; 8ABB  A9 08
    sta $0538,x                 ; 8ABD  9D 38 05
    dec $0568,x                 ; 8AC0  DE 68 05
    bne L0_8AD3                 ; 8AC3  D0 0E
    ldy $05A8,x                 ; 8AC5  BC A8 05
    lda D0_897C,y               ; 8AC8  B9 7C 89
    sta $0538,x                 ; 8ACB  9D 38 05
    lda #$02                    ; 8ACE  A9 02
    jsr L_E81A                  ; 8AD0  20 1A E8

L0_8AD3:
    lda $05A8,x                 ; 8AD3  BD A8 05
    cmp #$02                    ; 8AD6  C9 02
    bne L0_8AEB                 ; 8AD8  D0 11
    lda $0568,x                 ; 8ADA  BD 68 05
    cmp #$02                    ; 8ADD  C9 02
    bne L0_8AEB                 ; 8ADF  D0 0A
    lda #$0E                    ; 8AE1  A9 0E
    jsr L_EB1F                  ; 8AE3  20 1F EB
    lda #$FF                    ; 8AE6  A9 FF
    jsr L_EB27                  ; 8AE8  20 27 EB

L0_8AEB:
    jsr L0_8B02                 ; 8AEB  20 02 8B
    jmp L_E8A7                  ; 8AEE  4C A7 E8


L0_8AF1:
    lda #$06                    ; 8AF1  A9 06
    sta $0568,x                 ; 8AF3  9D 68 05
    jsr L0_8B02                 ; 8AF6  20 02 8B
    jmp L0_88CB                 ; 8AF9  4C CB 88


L0_8AFC:
    jsr L0_8B02                 ; 8AFC  20 02 8B
    jmp L0_8903                 ; 8AFF  4C 03 89


L0_8B02:
    ldy #$00                    ; 8B02  A0 00
    lda $05A8,x                 ; 8B04  BD A8 05
    cmp #$02                    ; 8B07  C9 02
    bcc L0_8B0D                 ; 8B09  90 02
    ldy #$02                    ; 8B0B  A0 02

L0_8B0D:
    lda D0_8B37,y               ; 8B0D  B9 37 8B
    sta $08                     ; 8B10  85 08
    lda D0_8B38,y               ; 8B12  B9 38 8B
    sta $09                     ; 8B15  85 09
    ldy $0568,x                 ; 8B17  BC 68 05
    lda ($08),y                 ; 8B1A  B1 08
    sta $030A,x                 ; 8B1C  9D 0A 03
    lda $05C8,x                 ; 8B1F  BD C8 05
    lsr a                       ; 8B22  4A
    lda #$40                    ; 8B23  A9 40
    bcc L0_8B29                 ; 8B25  90 02
    lda #$00                    ; 8B27  A9 00

L0_8B29:
    ldy $05D8,x                 ; 8B29  BC D8 05
    beq L0_8B33                 ; 8B2C  F0 05
    dec $05D8,x                 ; 8B2E  DE D8 05
    ora #$08                    ; 8B31  09 08

L0_8B33:
    sta $0358,x                 ; 8B33  9D 58 03
    rts                         ; 8B36  60

D0_8B37:
    .byte $3B
D0_8B38:
    .byte $8B,$42,$8B,$44,$45,$46,$43,$42,$41,$29,$44,$45,$46,$2C,$42,$2D
    .byte $29,$55,$8B,$5C,$8B,$BF,$8B,$4B,$E7,$B0,$E7,$06,$E8,$A9,$20,$9D
    .byte $58,$05,$D0,$6A,$20,$A7,$E8,$DE,$58,$05,$D0,$54,$20,$96,$8B,$B0
    .byte $4F,$A9,$28,$BC,$B8,$05,$F0,$02,$A9,$08,$9D,$58,$05,$98,$49,$02
    .byte $9D,$B8,$05,$F0,$3B,$A9,$F8,$A0,$00,$20,$32,$EB,$A5,$34,$29,$03
    .byte $A8,$B9,$92,$8B,$A8,$A9,$17,$4C,$BE,$F2,$01,$03,$05,$07,$BC,$B8
    .byte $05,$BD,$A8,$05,$4A,$90,$06,$C8,$A9,$F8,$20,$27,$EB,$B9,$B9,$8B
    .byte $20,$AA,$EB,$08,$BD,$A8,$05,$F0,$06,$C8,$A9,$08,$20,$27,$EB,$28
    .byte $60,$29,$26,$2A,$27,$2B,$28,$A0,$04,$20,$99,$8B,$B0,$F2,$4C,$8E
    .byte $E7,$D7,$8B,$A7,$E8,$40,$E7,$B0,$E7,$14,$E8,$DF,$8B,$E9,$8B,$A9
    .byte $1B,$20,$6B,$C1,$4C,$8E,$E7,$A9,$00,$9D,$B8,$05,$A9,$08,$4C,$8B
    .byte $E7,$DE,$38,$05,$D0,$22,$A9,$08,$9D,$38,$05,$BC,$B8,$05,$B9,$42
    .byte $8C,$20,$AA,$EB,$B0,$BA,$BC,$B8,$05,$B9,$4A,$8C,$20,$25,$EA,$20
    .byte $2F,$EB,$FE,$B8,$05,$4C,$B7,$EA,$BD,$38,$05,$C9,$01,$D0,$A1,$BD
    .byte $B8,$05,$0A,$A8,$B9,$31,$8C,$C9,$FF,$F0,$09,$20,$1F,$EB,$B9,$32
    .byte $8C,$4C,$27,$EB,$A9,$30,$4C,$F6,$EA,$F0,$F0,$20,$00,$E0,$20,$20
    .byte $00,$E0,$20,$20,$00,$E0,$20,$20,$00,$FF,$1E,$22,$1F,$23,$20,$24
    .byte $21,$25,$00,$00,$00,$04,$00,$04,$00,$04,$5C,$8C,$73,$8C,$4B,$E7
    .byte $B0,$E7,$F0,$8C,$20,$A7,$E8,$20,$F5,$EC,$C9,$18,$B0,$4E,$A9,$01
    .byte $9D,$38,$05,$A9,$00,$9D,$C8,$05,$4C,$8E,$E7,$20,$A7,$E8,$DE,$38
    .byte $05,$D0,$39,$BD,$B8,$05,$0A,$85,$08,$BD,$C8,$05,$C9,$02,$B0,$30
    .byte $18,$65,$08,$A8,$B9,$E0,$8C,$F0,$27,$85,$10,$BD,$24,$03,$18,$69
    .byte $F4,$A8,$BD,$C8,$05,$4A,$BD,$3E,$03,$B0,$02,$69,$E0,$18,$69,$F4
    .byte $20,$93,$C1,$A6,$83,$90,$06,$A9,$01,$9D,$38,$05,$60,$20,$23,$EA
    .byte $FE,$C8,$05,$BD,$C8,$05,$C9,$04,$B0,$AE,$A9,$24,$20,$6B,$C1,$A9
    .byte $04,$9D,$38,$05,$BC,$C8,$05,$B9,$EB,$8C,$85,$08,$B9,$E7,$8C,$A8
    .byte $A5,$08,$20,$32,$EB,$4C,$B7,$EA,$00,$1A,$1B,$1C,$19,$1C,$19,$1D
    .byte $00,$F0,$00,$10,$F0,$00,$10,$00,$20,$A7,$E8,$FE,$B8,$05,$BD,$B8
    .byte $05,$C9,$04,$B0,$19,$BD,$3E,$03,$69,$20,$B0,$12,$9D,$3E,$03,$A9
    .byte $01,$9D,$0A,$03,$A9,$01,$20,$68,$8C,$A9,$02,$4C,$1A,$E8,$4C,$09
    .byte $E8,$1F,$8D,$28,$8D,$09,$E8,$A9,$40,$9D,$38,$05,$4C,$8E,$E7,$60
    .byte $A5,$1A,$4A,$90,$FA,$A5,$8A,$D0,$F6,$DE,$38,$05,$D0,$F1,$BD,$A8
    .byte $05,$0A,$A8,$B9,$CF,$8D,$85,$0A,$B9,$D0,$8D,$85,$0B,$A5,$64,$0A
    .byte $A8,$B1,$0A,$85,$08,$C8,$B1,$0A,$85,$09,$BC,$B8,$05,$B1,$08,$29
    .byte $3F,$85,$0A,$B1,$08,$2A,$2A,$2A,$29,$03,$85,$0B,$C8,$B1,$08,$C8
    .byte $0A,$90,$0F,$A0,$00,$48,$E6,$88,$A5,$88,$C9,$07,$68,$90,$03,$4C
    .byte $09,$E8,$4A,$9D,$38,$05,$98,$9D,$B8,$05,$A4,$0B,$F0,$0A,$88,$F0
    .byte $0B,$88,$F0,$21,$A9,$17,$D0,$06,$A9,$15,$D0,$02,$A9,$16,$85,$08
    .byte $20,$CE,$ED,$D0,$2F,$A5,$08,$9D,$28,$05,$20,$47,$EE,$A5,$0A,$9D
    .byte $A8,$05,$4C,$CC,$8D,$A9,$03,$85,$0C,$20,$CE,$ED,$D0,$16,$A9,$18
    .byte $9D,$28,$05,$20,$47,$EE,$A5,$0A,$9D,$A8,$05,$A5,$0C,$9D,$B8,$05
    .byte $C6,$0C,$10,$E5,$A6,$83,$60,$D3,$8D,$09,$8E,$DD,$8D,$E3,$8D,$EF
    .byte $8D,$F3,$8D,$F9,$8D,$42,$30,$01,$01,$00,$C0,$46,$30,$81,$50,$01
    .byte $10,$00,$30,$00,$10,$01,$E0,$00,$30,$C5,$A0,$46,$20,$81,$60,$C3
    .byte $E1,$40,$30,$81,$60,$00,$10,$03,$30,$02,$10,$01,$40,$47,$10,$4A
    .byte $E0,$19,$8E,$25,$8E,$33,$8E,$3B,$8E,$43,$8E,$49,$8E,$51,$8E,$5D
    .byte $8E,$04,$30,$05,$60,$41,$60,$02,$30,$03,$60,$80,$E0,$4A,$50,$C3
    .byte $20,$C2,$20,$04,$20,$05,$50,$47,$50,$C2,$B0,$05,$40,$80,$60,$53
    .byte $60,$80,$E0,$57,$60,$40,$60,$41,$60,$40,$E0,$05,$30,$04,$60,$42
    .byte $E0,$4E,$40,$81,$60,$41,$60,$40,$E0,$04,$20,$03,$40,$4B,$60,$07
    .byte $20,$02,$40,$4B,$E0,$02,$30,$47,$40,$80,$60,$03,$20,$04,$D0,$75
    .byte $8E,$7D,$8E,$A4,$8E,$08,$8F,$40,$E7,$B0,$E7,$2D,$8F,$A9,$40,$9D
    .byte $38,$05,$4C,$8E,$E7,$A5,$87,$C9,$04,$90,$20,$DE,$38,$05,$D0,$1B
    .byte $A9,$40,$9D,$18,$05,$A9,$01,$9D,$08,$05,$A9,$10,$9D,$B8,$05,$20
    .byte $16,$EB,$A9,$20,$9D,$58,$05,$A9,$C0,$D0,$D4,$60,$A0,$00,$BD,$38
    .byte $05,$F0,$0C,$DE,$38,$05,$A5,$1A,$4A,$4A,$4A,$90,$02,$A0,$04,$84
    .byte $08,$FE,$68,$05,$BD,$68,$05,$4A,$4A,$4A,$29,$03,$18,$65,$08,$A8
    .byte $B9,$00,$8F,$9D,$0A,$03,$20,$37,$E8,$BD,$3E,$03,$BC,$08,$05,$30
    .byte $06,$C9,$B0,$90,$09,$B0,$04,$C9,$50,$B0,$03,$20,$1E,$E9,$A5,$8E
    .byte $F0,$B9,$DE,$58,$05,$D0,$B4,$A4,$2F,$B9,$FC,$8E,$9D,$58,$05,$A9
    .byte $1B,$4C,$52,$EB,$70,$50,$40,$28,$5D,$5E,$5F,$5E,$60,$61,$62,$61
    .byte $DE,$B8,$05,$F0,$48,$BD,$B8,$05,$C9,$01,$D0,$05,$A9,$52,$9D,$88
    .byte $05,$A9,$16,$20,$6B,$C1,$A9,$01,$9D,$78,$05,$A9,$20,$9D,$38,$05
    .byte $A9,$03,$4C,$1A,$E8,$20,$14,$E8,$A9,$60,$4C,$F6,$EA,$3F,$8F,$58
    .byte $8F,$4B,$E7,$B0,$E7,$06,$E8,$20,$F5,$EC,$84,$0A,$20,$2F,$EB,$A9
    .byte $06,$85,$06,$A9,$01,$85,$0F,$20,$2C,$F5,$20,$13,$F3,$4C,$8E,$E7
    .byte $A9,$63,$BC,$24,$03,$C0,$48,$90,$05,$20,$16,$EB,$A9,$64,$9D,$0A
    .byte $03,$A5,$1A,$4A,$4A,$29,$03,$A8,$BD,$58,$03,$29,$3F,$19,$7E,$8F
    .byte $9D,$58,$03,$4C,$37,$E8,$00,$40,$C0,$80,$8C,$8F,$94,$8F,$4B,$E7
    .byte $A4,$E7,$06,$E8,$A9,$72,$9D,$24,$03,$4C,$8E,$E7,$A0,$03,$BD,$24
    .byte $03,$D9,$C5,$8F,$B0,$03,$88,$D0,$F8,$98,$18,$69,$99,$9D,$0A,$03
    .byte $C0,$02,$90,$05,$A9,$2E,$9D,$88,$05,$20,$37,$E8,$BD,$24,$03,$C9
    .byte $AC,$90,$07,$C9,$BC,$B0,$04,$4C,$16,$EB,$60,$4C,$09,$E8,$7C,$8C
    .byte $9C,$D5,$8F,$E8,$8F,$7C,$90,$4B,$E7,$B0,$E7,$06,$E8,$BD,$24,$03
    .byte $9D,$B8,$05,$A9,$00,$9D,$E8,$05,$A9,$FD,$9D,$58,$05,$4C,$8E,$E7
    .byte $A0,$02,$BD,$B8,$05,$D9,$48,$90,$B0,$03,$88,$D0,$F8,$A5,$1A,$29
    .byte $07,$D0,$03,$FE,$68,$05,$BD,$68,$05,$D9,$4B,$90,$90,$02,$A9,$00
    .byte $9D,$68,$05,$B9,$4B,$90,$85,$0A,$98,$0A,$A8,$B9,$4E,$90,$85,$08
    .byte $B9,$4F,$90,$85,$09,$BC,$68,$05,$B1,$08,$9D,$0A,$03,$98,$18,$65
    .byte $0A,$A8,$B1,$08,$9D,$58,$03,$BD,$E8,$05,$18,$69,$0C,$9D,$E8,$05
    .byte $BD,$58,$05,$69,$00,$9D,$58,$05,$20,$66,$ED,$BD,$D8,$05,$10,$9D
    .byte $60,$80,$90,$04,$08,$08,$54,$90,$5C,$90,$6C,$90,$A8,$A9,$A6,$A9
    .byte $00,$00,$00,$C0,$A4,$A5,$A6,$A5,$A4,$A7,$A6,$A7,$00,$00,$00,$C0
    .byte $C0,$00,$00,$C0,$A0,$A1,$A2,$A1,$A0,$A3,$A2,$A3,$00,$00,$00,$C0
    .byte $C0,$00,$00,$C0,$A9,$24,$20,$6B,$C1,$A9,$AC,$9D,$24,$03,$20,$52
    .byte $E7,$4C,$8E,$E7,$9C,$90,$A8,$90,$C1,$90,$EE,$90,$08,$91,$37,$E7
    .byte $B0,$E7,$06,$E8,$BC,$A8,$05,$B9,$A4,$90,$D0,$1A,$50,$80,$B0,$F0
    .byte $BD,$B8,$05,$D0,$0A,$A9,$84,$20,$0A,$EC,$B0,$03,$FE,$B8,$05,$DE
    .byte $38,$05,$D0,$4B,$A9,$01,$4C,$77,$8E,$DE,$38,$05,$D0,$41,$A9,$08
    .byte $9D,$38,$05,$BC,$68,$05,$B9,$EB,$90,$20,$A4,$EB,$B0,$31,$FE,$68
    .byte $05,$BD,$68,$05,$C9,$03,$90,$27,$20,$12,$EB,$A9,$80,$9D,$58,$05
    .byte $4C,$8E,$E7,$85,$88,$89,$DE,$58,$05,$D0,$14,$A9,$50,$9D,$58,$05
    .byte $20,$F5,$EC,$84,$0A,$20,$2F,$EB,$A9,$60,$A0,$04,$4C,$9E,$F2,$60
    .byte $A9,$83,$20,$0A,$EC,$90,$D9,$60,$24,$91,$67,$91,$A0,$91,$CF,$91
    .byte $FB,$91,$37,$E7,$B0,$E7,$3B,$92,$51,$92,$AE,$92,$BD,$A8,$05,$4A
    .byte $4A,$29,$03,$A8,$4A,$A9,$25,$90,$07,$A9,$04,$9D,$48,$05,$A9,$22
    .byte $9D,$88,$05,$B9,$5F,$91,$9D,$78,$05,$B9,$63,$91,$9D,$C8,$05,$A0
    .byte $00,$BD,$A8,$05,$29,$04,$D0,$06,$BD,$A8,$05,$29,$03,$A8,$B9,$5B
    .byte $91,$D0,$42,$20,$80,$B0,$F0,$08,$05,$10,$05,$00,$03,$00,$03,$BD
    .byte $A8,$05,$29,$08,$D0,$19,$BD,$B8,$05,$D0,$14,$BD,$A8,$05,$4A,$4A
    .byte $4A,$A9,$84,$90,$02,$A9,$80,$20,$0A,$EC,$B0,$03,$FE,$B8,$05,$DE
    .byte $38,$05,$D0,$6E,$BD,$A8,$05,$29,$04,$F0,$03,$20,$C6,$91,$A9,$01
    .byte $9D,$58,$05,$A9,$01,$4C,$77,$8E,$DE,$38,$05,$D0,$55,$BD,$A8,$05
    .byte $29,$08,$D0,$1A,$A9,$08,$9D,$38,$05,$BC,$68,$05,$B9,$CC,$91,$20
    .byte $A4,$EB,$B0,$3E,$FE,$68,$05,$BD,$68,$05,$C9,$03,$90,$34,$20,$12
    .byte $EB,$4C,$8E,$E7,$85,$86,$87,$A5,$88,$C9,$07,$90,$25,$BD,$C8,$05
    .byte $D0,$20,$BD,$24,$03,$C9,$70,$B0,$19,$DE,$58,$05,$D0,$14,$A9,$28
    .byte $9D,$58,$05,$20,$F5,$EC,$84,$0A,$20,$2F,$EB,$A9,$60,$A0,$05,$4C
    .byte $9E,$F2,$60,$BC,$C8,$05,$BD,$A8,$05,$29,$08,$F0,$05,$98,$18,$69
    .byte $04,$A8,$B9,$33,$92,$20,$0A,$EC,$B0,$E8,$A0,$05,$DE,$C8,$05,$30
    .byte $17,$D0,$0C,$A9,$00,$9D,$48,$05,$A9,$25,$9D,$88,$05,$A0,$08,$98
    .byte $9D,$78,$05,$A9,$04,$4C,$1A,$E8,$4C,$8E,$E7,$83,$87,$82,$81,$83
    .byte $8A,$82,$81,$C6,$86,$D0,$78,$A9,$00,$9D,$0A,$03,$20,$E5,$E9,$A9
    .byte $03,$9D,$D8,$05,$A9,$04,$4C,$77,$8E,$DE,$38,$05,$D0,$40,$BC,$D8
    .byte $05,$B9,$A6,$92,$9D,$24,$03,$B9,$AA,$92,$9D,$3E,$03,$B9,$A2,$92
    .byte $20,$B5,$EB,$B0,$1F,$BC,$D8,$05,$98,$4A,$4A,$A9,$FC,$90,$02,$A9
    .byte $F4,$18,$79,$A6,$92,$85,$08,$B9,$AA,$92,$85,$09,$20,$AB,$EA,$DE
    .byte $D8,$05,$30,$06,$A9,$01,$9D,$38,$05,$60,$A9,$10,$D0,$B8,$BD,$38
    .byte $05,$C9,$01,$D0,$F4,$A9,$25,$4C,$6B,$C1,$02,$03,$01,$00,$78,$78
    .byte $58,$58,$70,$90,$90,$70,$DE,$38,$05,$D0,$DE,$A9,$01,$85,$37,$4C
    .byte $09,$E8,$C8,$92,$D5,$92,$46,$93,$60,$93,$4B,$E7,$AA,$E7,$06,$E8
    .byte $A0,$00,$20,$97,$96,$A9,$08,$9D,$58,$05,$4C,$8E,$E7,$20,$16,$93
    .byte $20,$C1,$96,$DE,$58,$05,$D0,$35,$A9,$10,$9D,$58,$05,$BD,$3E,$03
    .byte $C9,$68,$90,$29,$C9,$98,$B0,$25,$BD,$A8,$05,$4A,$29,$03,$A8,$D0
    .byte $03,$4C,$84,$97,$88,$D0,$0C,$FE,$B8,$05,$BD,$B8,$05,$4A,$90,$0D
    .byte $4C,$43,$97,$A0,$08,$A9,$00,$20,$32,$EB,$4C,$00,$97,$60,$A5,$1A
    .byte $29,$03,$D0,$0F,$FE,$68,$05,$BD,$68,$05,$C9,$03,$90,$02,$A9,$00
    .byte $9D,$68,$05,$BD,$68,$05,$18,$69,$93,$9D,$0A,$03,$BD,$58,$03,$BC
    .byte $08,$05,$30,$04,$29,$BF,$10,$02,$09,$40,$9D,$58,$03,$60,$20,$07
    .byte $EB,$A9,$96,$9D,$0A,$03,$A9,$80,$9D,$F8,$04,$A9,$FD,$9D,$E8,$04
    .byte $20,$D9,$E8,$A9,$10,$4C,$77,$8E,$20,$37,$E8,$A9,$38,$20,$42,$EB
    .byte $DE,$38,$05,$D0,$D8,$4C,$8E,$E7,$80,$93,$A5,$93,$46,$93,$60,$93
    .byte $37,$94,$4B,$E7,$AA,$E7,$06,$E8,$BD,$A8,$05,$4A,$4A,$90,$16,$A5
    .byte $89,$D0,$0A,$A5,$88,$F0,$06,$A9,$01,$85,$89,$D0,$08,$BD,$A8,$05
    .byte $29,$FD,$9D,$A8,$05,$A0,$02,$20,$97,$96,$4C,$8E,$E7,$A9,$97,$BC
    .byte $38,$05,$F0,$08,$A9,$93,$C0,$04,$90,$02,$A9,$98,$9D,$0A,$03,$BD
    .byte $A8,$05,$4A,$4A,$A9,$00,$90,$02,$A9,$05,$85,$08,$BD,$58,$03,$BC
    .byte $08,$05,$30,$04,$29,$BF,$10,$02,$09,$40,$29,$F8,$05,$08,$9D,$58
    .byte $03,$BD,$38,$05,$F0,$20,$DE,$38,$05,$BD,$A8,$05,$29,$02,$D0,$3A
    .byte $BD,$38,$05,$C9,$08,$D0,$33,$20,$F5,$EC,$84,$0A,$20,$2F,$EB,$A9
    .byte $60,$A0,$04,$4C,$9E,$F2,$20,$C1,$96,$BC,$B8,$05,$B9,$23,$94,$18
    .byte $7D,$24,$03,$9D,$24,$03,$FE,$B8,$05,$BD,$B8,$05,$C9,$14,$90,$0A
    .byte $A9,$00,$9D,$B8,$05,$A9,$10,$9D,$38,$05,$60,$FD,$FD,$FE,$FE,$FE
    .byte $FF,$FF,$FF,$00,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$BD
    .byte $A8,$05,$29,$02,$F0,$19,$BD,$3E,$03,$C9,$64,$90,$12,$C9,$9C,$B0
    .byte $0E,$BD,$A8,$05,$30,$09,$5E,$A8,$05,$5E,$A8,$05,$4C,$D4,$82,$4C
    .byte $8E,$E7,$68,$94,$79,$94,$46,$93,$60,$93,$4B,$E7,$AA,$E7,$29,$95
    .byte $A9,$01,$85,$8A,$20,$16,$95,$A0,$06,$20,$97,$96,$A9,$20,$4C,$77
    .byte $8E,$BD,$D8,$05,$F0,$49,$A9,$96,$9D,$0A,$03,$DE,$38,$05,$D0,$29
    .byte $A9,$08,$9D,$38,$05,$A9,$00,$9D,$D8,$05,$BD,$3E,$03,$20,$4E,$ED
    .byte $85,$0A,$20,$16,$95,$20,$7C,$96,$C5,$0A,$A9,$00,$90,$02,$A9,$80
    .byte $5D,$08,$05,$10,$03,$20,$1E,$E9,$60,$BD,$B8,$05,$F0,$10,$DE,$58
    .byte $05,$D0,$0B,$A9,$14,$9D,$58,$05,$DE,$B8,$05,$4C,$43,$97,$60,$20
    .byte $16,$93,$BD,$3E,$03,$BC,$08,$05,$30,$06,$C9,$A0,$B0,$0E,$90,$04
    .byte $C9,$60,$90,$08,$20,$C1,$96,$DE,$38,$05,$D0,$31,$BD,$3E,$03,$20
    .byte $4E,$ED,$85,$0A,$BC,$C8,$05,$20,$7C,$96,$A0,$18,$C5,$0A,$08,$D0
    .byte $02,$A0,$38,$98,$9D,$38,$05,$FE,$D8,$05,$A9,$04,$9D,$58,$05,$BD
    .byte $A8,$05,$4A,$29,$03,$28,$F0,$02,$A9,$00,$9D,$B8,$05,$60,$20,$F5
    .byte $EC,$B9,$90,$00,$C9,$01,$F0,$04,$98,$49,$01,$A8,$98,$9D,$C8,$05
    .byte $60,$20,$06,$E8,$A9,$00,$85,$8A,$60,$41,$95,$4C,$95,$82,$95,$46
    .byte $93,$60,$93,$4B,$E7,$AA,$E7,$06,$E8,$A0,$04,$20,$97,$96,$20,$9D
    .byte $95,$4C,$8E,$E7,$DE,$38,$05,$D0,$1A,$BD,$C8,$05,$C9,$01,$D0,$0A
    .byte $BD,$B8,$05,$C9,$02,$90,$03,$20,$1E,$E9,$20,$A7,$95,$B9,$76,$95
    .byte $4C,$77,$8E,$BD,$38,$05,$C9,$04,$D0,$03,$4C,$84,$97,$60,$3F,$39
    .byte $33,$2D,$18,$10,$10,$18,$FF,$FF,$FF,$FF,$20,$16,$93,$20,$C1,$96
    .byte $DE,$38,$05,$D0,$E8,$A9,$96,$9D,$0A,$03,$FE,$C8,$05,$20,$9D,$95
    .byte $A9,$02,$4C,$1A,$E8,$20,$A7,$95,$B9,$B6,$95,$9D,$38,$05,$60,$BD
    .byte $C8,$05,$0A,$0A,$85,$08,$BD,$B8,$05,$18,$65,$08,$A8,$60,$01,$07
    .byte $0D,$13,$18,$18,$18,$18,$10,$18,$18,$10,$C8,$95,$CD,$95,$09,$E8
    .byte $A9,$60,$4C,$77,$8E,$A5,$88,$C9,$07,$90,$03,$4C,$09,$E8,$A5,$1A
    .byte $4A,$90,$4D,$DE,$38,$05,$D0,$48,$BD,$A8,$05,$29,$07,$0A,$A8,$B9
    .byte $30,$96,$85,$10,$B9,$31,$96,$85,$11,$BC,$B8,$05,$B1,$10,$C9,$FF
    .byte $D0,$04,$A0,$00,$F0,$F6,$85,$0B,$29,$0F,$85,$0A,$C8,$B1,$10,$9D
    .byte $38,$05,$C8,$98,$9D,$B8,$05,$A5,$0B,$4A,$4A,$4A,$4A,$A8,$B9,$29
    .byte $96,$85,$09,$A9,$70,$85,$08,$98,$20,$03,$97,$BD,$38,$05,$F0,$C9
    .byte $60,$98,$90,$88,$80,$78,$70,$68,$34,$96,$6D,$96,$00,$00,$10,$00
    .byte $20,$00,$30,$00,$40,$00,$50,$00,$60,$F0,$01,$00,$11,$00,$21,$00
    .byte $31,$00,$41,$00,$51,$00,$61,$F0,$30,$10,$20,$00,$40,$10,$10,$00
    .byte $50,$10,$00,$00,$60,$F0,$00,$00,$60,$10,$10,$00,$50,$10,$20,$00
    .byte $40,$10,$30,$F0,$FF,$00,$00,$20,$00,$40,$00,$60,$F0,$10,$00,$30
    .byte $00,$50,$F0,$FF,$B9,$34,$03,$A0,$06,$D9,$90,$96,$90,$08,$88,$30
    .byte $02,$B0,$F6,$A9,$00,$60,$98,$60,$FF,$BC,$A4,$8C,$74,$5C,$44,$B9
    .byte $B9,$96,$9D,$18,$05,$B9,$BA,$96,$9D,$08,$05,$BD,$A8,$05,$4A,$A9
    .byte $A8,$90,$05,$20,$1E,$E9,$A9,$58,$9D,$3E,$03,$A9,$6D,$9D,$24,$03
    .byte $60,$20,$FF,$40,$FF,$40,$FF,$40,$FF,$BD,$D8,$04,$18,$7D,$18,$05
    .byte $9D,$D8,$04,$BD,$3E,$03,$7D,$08,$05,$9D,$3E,$03,$BC,$08,$05,$30
    .byte $06,$C9,$B0,$B0,$06,$90,$07,$C9,$50,$B0,$03,$4C,$09,$E8,$BC,$58
    .byte $03,$C9,$A0,$B0,$04,$C9,$60,$B0,$05,$98,$09,$20,$D0,$03,$98,$29
    .byte $DF,$9D,$58,$03,$60,$20,$2F,$EB,$20,$4C,$ED,$85,$0F,$A5,$8E,$F0
    .byte $29,$20,$CE,$ED,$D0,$24,$A9,$11,$20,$D4,$97,$A5,$0A,$9D,$A8,$05
    .byte $A5,$0F,$0A,$A8,$B9,$35,$97,$9D,$18,$05,$B9,$36,$97,$9D,$08,$05
    .byte $A9,$80,$9D,$F8,$04,$A9,$00,$9D,$E8,$04,$A6,$83,$60,$55,$00,$38
    .byte $00,$1C,$00,$00,$00,$E4,$FF,$C8,$FF,$AB,$FF,$20,$2F,$EB,$20,$4C
    .byte $ED,$85,$0F,$A5,$8E,$F0,$24,$20,$CE,$ED,$D0,$1F,$A9,$12,$20,$D4
    .byte $97,$A5,$0F,$0A,$A8,$B9,$76,$97,$9D,$18,$05,$B9,$77,$97,$9D,$08
    .byte $05,$A9,$80,$9D,$F8,$04,$A9,$00,$9D,$E8,$04,$A6,$83,$60,$55,$00
    .byte $38,$00,$1C,$00,$00,$00,$E4,$FF,$C8,$FF,$AB,$FF,$20,$2F,$EB,$A5
    .byte $09,$C9,$A0,$B0,$36,$C9,$60,$90,$32,$A5,$8E,$F0,$2E,$20,$4C,$ED
    .byte $85,$0F,$20,$CE,$ED,$D0,$24,$A9,$01,$20,$D4,$97,$A9,$03,$9D,$B8
    .byte $05,$A5,$0F,$0A,$A8,$B9,$C6,$97,$9D,$18,$05,$B9,$C7,$97,$9D,$08
    .byte $05,$A9,$40,$9D,$F8,$04,$A9,$01,$9D,$E8,$04,$A6,$83,$60,$D4,$00
    .byte $8D,$00,$46,$00,$00,$00,$BA,$FF,$73,$FF,$2C,$FF,$9D,$28,$05,$20
    .byte $47,$EE,$A5,$08,$9D,$24,$03,$A5,$09,$9D,$3E,$03,$60,$E9,$97,$1C
    .byte $98,$BD,$A8,$05,$0A,$A8,$B9,$0C,$98,$9D,$18,$05,$B9,$0D,$98,$9D
    .byte $08,$05,$B9,$14,$98,$9D,$C8,$05,$B9,$15,$98,$9D,$B8,$05,$20,$A7
    .byte $E8,$4C,$8E,$E7,$80,$FF,$C0,$00,$80,$FF,$80,$00,$50,$B0,$70,$C0
    .byte $48,$B8,$48,$B8,$A9,$48,$9D,$0A,$03,$20,$37,$E8,$BD,$3E,$03,$BC
    .byte $08,$05,$30,$07,$DD,$B8,$05,$90,$0A,$B0,$05,$DD,$C8,$05,$B0,$03
    .byte $4C,$1E,$E9,$60,$E9,$97,$40,$98,$A9,$49,$9D,$0A,$03,$A5,$1A,$4A
    .byte $4A,$4A,$4A,$A9,$00,$90,$02,$A9,$40,$9D,$58,$03,$4C,$21,$98,$5D
    .byte $98,$63,$98,$6B,$98,$20,$A7,$E8,$4C,$8E,$E7,$20,$A7,$E8,$A9,$08
    .byte $4C,$3B,$99,$20,$37,$E8,$DE,$38,$05,$D0,$5A,$A9,$E0,$9D,$38,$05
    .byte $A9,$13,$4C,$52,$EB,$89,$98,$8E,$98,$CE,$98,$4B,$E7,$B0,$E7,$06
    .byte $E8,$A9,$40,$4C,$3B,$99,$20,$C8,$98,$20,$37,$E8,$A5,$1A,$29,$03
    .byte $D0,$0F,$A5,$1A,$4A

L0_989D:
    lsr a                       ; 989D  4A
    lsr a                       ; 989E  4A
    bcc L0_98A6                 ; 989F  90 05
    inc $033E,x                 ; 98A1  FE 3E 03
    bcs L0_98A9                 ; 98A4  B0 03

L0_98A6:
    dec $033E,x                 ; 98A6  DE 3E 03

L0_98A9:
    dec $0538,x                 ; 98A9  DE 38 05
    bne L0_98CD                 ; 98AC  D0 1F
    jsr L_EB16                  ; 98AE  20 16 EB
    lda #$01                    ; 98B1  A9 01
    jmp L0_993B                 ; 98B3  4C 3B 99

    .byte $A5,$1A,$4A,$4A,$29,$03,$A8,$BD,$58,$03,$29,$3F,$19,$14,$99,$9D
    .byte $58,$03,$A9,$4A,$9D,$0A,$03

L0_98CD:
    rts                         ; 98CD  60

    .byte $20,$B6,$98,$BD,$24,$03,$DD,$B8,$05,$90,$28,$A0,$08,$20,$33,$EC
    .byte $90,$21,$A9,$05,$20,$6B,$C1,$A9,$40,$9D,$38,$05,$BD,$24,$03,$18
    .byte $69,$10,$90,$02,$A9,$FF,$9D,$B8,$05,$A9,$C0,$9D,$F8,$04,$A9,$FE
    .byte $9D,$E8,$04,$20,$40,$EB,$BD,$B8,$05,$18,$65,$68,$90,$02,$A9,$FF
    .byte $9D,$B8,$05,$4C,$37,$E8,$00,$40,$C0,$80,$2A,$99,$41,$99,$54,$99
    .byte $A2,$99,$EF,$99,$40,$E7,$B0,$E7,$14,$E8,$14,$9A,$A9,$20,$9D,$B8
    .byte $05,$A9,$02,$9D,$D8,$05,$A9,$01,$9D,$68,$05,$A9,$FF

L0_993B:
    sta $0538,x                 ; 993B  9D 38 05
    jmp L_E78E                  ; 993E  4C 8E E7

    .byte $20,$A7,$E8,$A5,$84,$F0,$1B,$A5,$74,$D0,$17,$DE,$38,$05,$D0,$12
    .byte $4C,$8E,$E7,$20,$76,$99,$B0,$0A,$BD,$68,$05,$C9,$02,$B0,$04,$FE
    .byte $68,$05,$60,$20,$12,$EB,$BD,$B8,$05,$9D,$78,$05,$A9,$06,$9D,$58
    .byte $05,$A9,$70,$D0,$C5,$20,$A7,$E8,$DE,$38,$05,$D0,$1C,$BD,$68,$05
    .byte $0A,$A8,$B9,$9C,$99,$85,$10,$B9,$9D,$99,$A0,$01,$20,$CE,$EB,$A9
    .byte $06,$90,$02,$A9,$01,$9D,$38,$05,$60,$38,$60,$A0,$A1,$A2,$A3,$A4
    .byte $A5,$20,$A7,$E8,$BD,$58,$05,$F0,$2A,$DE,$58,$05,$D0,$25,$A9,$02
    .byte $85,$16,$A0,$08,$A9,$00,$20,$32,$EB,$A0,$06,$A5,$85,$C9,$02,$90
    .byte $02,$A0,$07,$84,$0F,$A4,$16,$B9,$EC,$99,$A4,$0F,$20,$BF,$F2,$C6
    .byte $16,$10,$DF,$DE,$38,$05,$D0,$8A,$20,$03,$EB,$BD,$78,$05,$9D,$B8
    .byte $05,$A9,$F1,$9D,$78,$05,$A9,$06,$4C,$3B,$99,$88,$86,$84,$20,$76
    .byte $99,$B0,$08,$BD,$68,$05,$F0,$04,$DE,$68,$05,$60,$A5,$85,$C9,$02
    .byte $90,$02,$A9,$02,$A8,$B9,$11,$9A,$9D,$38,$05,$A9,$03,$4C,$1A,$E8
    .byte $C0,$70,$20,$DE,$D8,$05,$D0,$14,$A9,$01,$9D,$D8,$05,$20,$33,$9A
    .byte $B0,$0A,$FE,$C8,$05,$BD,$C8,$05,$C9,$0E,$B0,$01,$60,$A9,$60,$4C
    .byte $F6,$EA,$BC,$C8,$05,$B9,$62,$9A,$9D,$24,$03,$B9,$70,$9A,$9D,$3E
    .byte $03,$B9,$7E,$9A,$20,$B5,$EB,$B0,$12,$BC,$C8,$05,$B9,$62,$9A,$85
    .byte $08,$B9,$70,$9A,$85,$09,$20,$B3,$EA,$18,$60,$A9,$01,$9D,$D8,$05
    .byte $60,$20,$20,$20,$20,$40,$40,$60,$60,$80,$80,$A0,$A0,$C0,$C0,$50
    .byte $B0,$70,$90,$70,$90,$70,$90,$70,$90,$70,$90,$70,$90,$19,$19,$19
    .byte $19,$1A,$1B,$29,$2A,$1C,$1D,$1E,$1F,$26,$27,$9C,$9A,$C5,$9A,$63
    .byte $9B,$03,$9C,$DD,$9E,$4B,$E7,$B0,$E7,$06,$E8,$BD,$A8,$05,$4A,$A9
    .byte $38,$A0,$08,$90,$04,$A9,$28,$A0,$F8,$9D,$B8,$05,$9D,$48,$05,$98
    .byte $20,$27,$EB,$A9,$FF,$9D,$E8,$05,$A9,$04,$9D,$68,$05,$8A,$9D,$C8
    .byte $05,$4C,$8E,$E7,$20,$A7,$E8,$A5,$84,$F0,$09,$A5,$74,$D0,$05,$BD
    .byte $E8,$05,$30,$01,$60,$20,$CE,$ED,$D0,$46,$A9,$15,$9D,$28,$05,$20
    .byte $47,$EE,$20,$24,$9B,$86,$10,$A6,$83,$DE,$68,$05,$D0,$32,$A4,$10
    .byte $A9,$FF,$99,$D8,$05,$A9,$10,$99,$78,$05,$A9,$0C,$99,$98,$05,$A9
    .byte $01,$99,$C8,$05,$A9,$20,$99,$38,$05,$98,$9D,$18,$05,$20,$8E,$E7
    .byte $BD,$D8,$05,$AA,$10,$F7,$A6,$83,$A9,$00,$9D,$C8,$05,$9D,$68,$05
    .byte $A6,$83,$60,$A9,$02,$9D,$B8,$04,$A9,$8C,$9D,$98,$05,$A9,$52,$9D
    .byte $88,$05,$A9,$F1,$9D,$78,$05,$A9,$00,$9D,$B8,$05,$A4,$83,$B9,$A8
    .byte $05,$9D,$A8,$05,$B9,$24,$03,$9D,$24,$03,$B9,$3E,$03,$9D,$3E,$03
    .byte $B9,$C8,$05,$9D,$E8,$05,$85,$08,$8A,$99,$C8,$05,$A4,$08,$99,$D8
    .byte $05,$60,$20,$A7,$E8,$BD,$38,$05,$F0,$09,$A5,$1A,$4A,$90,$03,$DE
    .byte $38,$05,$60,$BD,$C8,$05,$F0,$45,$20,$F6,$9B,$20,$BF,$9B,$BD,$C8
    .byte $05,$30,$3A,$FE,$C8,$05,$BD,$C8,$05,$C9,$10,$90,$30,$A9,$FF,$9D
    .byte $C8,$05,$BC,$E8,$05,$A9,$01,$99,$C8,$05,$A9,$00,$99,$38,$05,$B9
    .byte $E8,$05,$10,$17,$98,$AA,$20,$8E,$E7,$A9,$00,$9D,$C8,$05,$BD,$D8
    .byte $05,$AA,$10,$F2,$A6,$83,$A9,$00,$9D,$68,$05,$A6,$83,$60,$BD,$A8
    .byte $05,$29,$01,$0A,$0A,$A8,$B9,$EE,$9B,$18,$7D,$C8,$04,$9D,$C8,$04
    .byte $B9,$EF,$9B,$7D,$24,$03,$9D,$24,$03,$B9,$F0,$9B,$18,$7D,$D8,$04
    .byte $9D,$D8,$04,$B9,$F1,$9B,$7D,$3E,$03,$9D,$3E,$03,$60,$4B,$FF,$B5
    .byte $00,$4B,$FF,$4B,$FF,$A9,$7A,$BC,$D8,$05,$10,$02,$A9,$7B,$9D,$0A
    .byte $03,$60,$20,$F6,$9B,$BD,$E8,$05,$30,$01,$60,$20,$1E,$9C,$BD,$68
    .byte $05,$C9,$04,$F0,$03,$20,$8A,$9D,$4C,$4E,$9E,$30,$D0,$BC,$68,$05
    .byte $D0,$4E,$20,$E8,$9C,$BD,$A8,$05,$29,$01,$A8,$BD,$F8,$04,$D0,$0F
    .byte $BD,$B8,$05,$D9,$6A,$9C,$F0,$23,$B9,$6E,$9C,$9D,$C8,$05,$60,$BD
    .byte $B8,$05,$D9,$6C,$9C,$F0,$07,$B9,$6F,$9C,$9D,$C8,$05,$60,$FE,$58
    .byte $05,$BD,$58,$05,$C9,$03,$D0,$03,$FE,$68,$05,$A9,$03,$9D,$38,$05
    .byte $BD,$F8,$04,$49,$01,$9D,$F8,$04,$60,$14,$0C,$2C,$34,$40,$C0,$40
    .byte $88,$D0,$0C,$20,$E8,$9C,$BD,$E8,$04,$D0,$03,$FE,$68,$05,$60,$88
    .byte $D0,$3D,$20,$E8,$9C,$BD,$A8,$05,$29,$01,$85,$08,$BD,$D8,$05,$AA
    .byte $A4,$08,$BD,$B8,$05,$D9,$BA,$9C,$F0,$09,$B9,$6E,$9C,$9D,$C8,$05
    .byte $A6,$83,$60,$BD,$D8,$05,$30,$03,$AA,$10,$E5,$A6,$83,$A5,$34,$65
    .byte $1A,$29,$03,$A8,$B9,$BC,$9C,$D0,$13,$08,$38,$40,$60,$30,$70,$88
    .byte $D0,$11,$20,$E8,$9C,$DE,$58,$05,$D0,$08,$A9,$C0,$9D,$58,$05,$FE
    .byte $68,$05,$60,$20,$08,$9D,$DE,$58,$05,$D0,$0B,$A9,$00,$9D,$F8,$04
    .byte $9D,$58,$05,$9D,$68,$05,$60,$DE,$48,$05,$D0,$1A,$A9,$90,$9D,$48
    .byte $05,$BD,$18,$05,$AA,$20,$F5,$EC,$84,$0A,$20,$2F,$EB,$A9,$80,$A0
    .byte $05,$20,$9E,$F2,$A6,$83,$60,$BD,$18,$05,$AA,$20,$F5,$EC,$84,$10
    .byte $8A,$A8,$86,$11,$BE,$E8,$05,$30,$6D,$A5,$10,$85,$0A,$20,$CD,$F4
    .byte $30

L0_9D22:
    inc $11A6                   ; 9D22  EE A6 11
    tay                         ; 9D25  A8
    bne L0_9D55                 ; 9D26  D0 2D

L0_9D28:
    lda $05E8,x                 ; 9D28  BD E8 05
    bmi L0_9D38                 ; 9D2B  30 0B
    ldy $05B8,x                 ; 9D2D  BC B8 05
    cpy #$08                    ; 9D30  C0 08
    bne L0_9D38                 ; 9D32  D0 04
    tax                         ; 9D34  AA
    jmp L0_9D28                 ; 9D35  4C 28 9D


L0_9D38:
    cpx $11                     ; 9D38  E4 11
    bne L0_9D4F                 ; 9D3A  D0 13
    lda $05D8,x                 ; 9D3C  BD D8 05
    bmi L0_9D4D                 ; 9D3F  30 0C
    tax                         ; 9D41  AA
    dec $05B8,x                 ; 9D42  DE B8 05
    lda $05B8,x                 ; 9D45  BD B8 05
    and #$3F                    ; 9D48  29 3F
    sta $05B8,x                 ; 9D4A  9D B8 05

L0_9D4D:
    ldx $11                     ; 9D4D  A6 11

L0_9D4F:
    inc $05B8,x                 ; 9D4F  FE B8 05
    jmp L0_9D7F                 ; 9D52  4C 7F 9D


L0_9D55:
    lda $05E8,x                 ; 9D55  BD E8 05
    bmi L0_9D65                 ; 9D58  30 0B
    ldy $05B8,x                 ; 9D5A  BC B8 05
    cpy #$38                    ; 9D5D  C0 38
    bne L0_9D65                 ; 9D5F  D0 04
    tax                         ; 9D61  AA
    jmp L0_9D55                 ; 9D62  4C 55 9D


L0_9D65:
    cpx $11                     ; 9D65  E4 11
    bne L0_9D7C                 ; 9D67  D0 13
    lda $05D8,x                 ; 9D69  BD D8 05
    bmi L0_9D7A                 ; 9D6C  30 0C
    tax                         ; 9D6E  AA
    inc $05B8,x                 ; 9D6F  FE B8 05
    lda $05B8,x                 ; 9D72  BD B8 05
    and #$3F                    ; 9D75  29 3F
    sta $05B8,x                 ; 9D77  9D B8 05

L0_9D7A:
    ldx $11                     ; 9D7A  A6 11

L0_9D7C:
    dec $05B8,x                 ; 9D7C  DE B8 05

L0_9D7F:
    lda $05B8,x                 ; 9D7F  BD B8 05
    and #$3F                    ; 9D82  29 3F
    sta $05B8,x                 ; 9D84  9D B8 05
    ldx $83                     ; 9D87  A6 83
    rts                         ; 9D89  60

    .byte $A9,$00,$85,$08,$85,$0E,$86,$10,$20,$AC,$9D,$A6,$10,$BD,$C8,$05
    .byte $05,$0E,$85,$0E,$BD,$D8,$05,$AA,$10,$EC,$A6,$83,$A5,$0E,$9D,$E8
    .byte $04,$60,$BD,$38,$05,$F0,$07,$DE,$38,$05,$A9,$00,$F0,$13,$BD,$C8
    .byte $05,$F0,$0E,$30,$07,$DE,$C8,$05,$A9,$01,$D0,$05,$FE,$C8,$05,$A9
    .byte $FF,$85,$0C,$A0,$00,$84,$0D,$18,$65,$08,$85,$0B,$F0,$6E,$30,$37
    .byte $BD,$E8,$05,$30,$1F,$BC,$B8,$05,$C0,$08,$D0,$18,$A4,$0C,$F0,$09
    .byte $30,$07,$A9,$00,$9D,$C8,$05,$F0,$18,$A9,$01,$9D,$38,$05,$DE,$C8
    .byte $05,$4C,$0B,$9E,$C6,$0D,$FE,$B8,$05,$BD,$B8,$05,$29,$3F,$9D,$B8
    .byte $05,$C6,$0B,$D0,$CB,$F0,$35,$BD,$E8,$05,$30,$1F,$BC,$B8,$05,$C0
    .byte $38,$D0,$18,$A4,$0C,$F0,$09,$10,$07,$A9,$00,$9D,$C8,$05,$F0,$18
    .byte $A9,$01,$9D,$38,$05,$FE,$C8,$05,$4C,$42,$9E,$E6,$0D,$DE,$B8,$05
    .byte $BD,$B8,$05,$29,$3F,$9D,$B8,$05,$E6,$0B,$D0,$CB,$A5,$08,$18,$65
    .byte $0D,$85,$08,$60,$A4,$83,$B9,$B8,$05,$99,$08,$05,$B9,$D8,$05,$30
    .byte $2F,$AA,$B9,$24,$03,$85,$08,$B9,$3E,$03,$85,$09,$B9,$08,$05,$18
    .byte $7D,$B8,$05,$29,$3F,$9D,$08,$05,$A8,$B9,$8D,$9E,$18,$65,$08,$9D
    .byte $24,$03,$B9,$9D,$9E,$18,$65,$09,$9D,$3E,$03,$8A,$A8,$4C,$56,$9E
    .byte $A6,$83,$60,$00,$01,$03,$04,$06,$07,$08,$0A,$0B,$0C,$0D,$0E,$0E
    .byte $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0E,$0E,$0D,$0C,$0B,$0A,$08,$07,$06
    .byte $04,$03,$01,$00,$FF,$FD,$FC,$FA,$F9,$F8,$F6,$F5,$F4,$F3,$F2,$F2
    .byte $F1,$F1,$F1,$F1,$F1,$F1,$F1,$F2,$F2,$F3,$F4,$F5,$F6,$F8,$F9,$FA
    .byte $FC,$FD,$FF,$00,$01,$03,$04,$06,$07,$08,$0A,$0B,$0C,$0D,$0E,$0E
    .byte $0F,$0F,$0F,$BD,$D8,$05,$10,$10,$E6,$85,$BD,$E8,$05,$30,$07,$AA
    .byte $20,$74,$E9,$4C,$E4,$9E,$A6,$83,$4C,$8E,$E7,$03,$9F,$25,$9F,$3D
    .byte $9F,$FF,$9F,$38,$A0,$B0,$E7,$42,$A0,$A9,$0A,$9D,$E8,$05,$BD,$3E
    .byte $03,$9D,$B8,$05,$A9,$80,$9D,$18,$05,$A9,$00,$9D,$08,$05,$A9,$80
    .byte $9D,$58,$05,$A9,$40,$9D,$38,$05,$4C,$8E,$E7,$A5,$87,$C9,$03,$90
    .byte $11,$DE,$38,$05,$D0,$0C,$A9,$A0,$9D,$58,$05,$20,$12,$EB,$A9,$20
    .byte $D0,$E3,$60,$A5,$1A,$29,$07,$D0,$0F,$FE,$68,$05,$BD,$68,$05,$C9
    .byte $03,$90,$02,$A9,$00,$9D,$68,$05,$BD,$D8,$05,$BC,$C8,$05,$F0,$0E
    .byte $DE,$C8,$05,$BD,$C8,$05,$4A,$BD,$D8,$05,$90,$02,$49,$01,$4A,$A9
    .byte $00,$90,$02,$A9,$03,$18,$7D,$68,$05,$A8,$B9,$F5,$9F,$9D,$0A,$03
    .byte $A5,$8E,$F0,$24,$DE,$58,$05,$D0,$1F,$A5,$2F,$0A,$0A,$0A,$85,$08
    .byte $A5,$34,$65,$1A,$85,$34,$4A,$29,$03,$A8,$B9,$FB,$9F,$38,$E5,$08
    .byte $9D,$58,$05,$A9,$1D,$20,$52,$EB,$BD,$38,$05,$F0,$08,$DE,$38,$05
    .byte $D0,$34,$20,$07,$EB,$BD,$F8,$04,$18,$7D,$18,$05,$9D,$F8,$04,$BD
    .byte $E8,$04,$7D,$08,$05,$9D,$E8,$04,$BC,$08,$05,$30,$08,$C9,$30,$90
    .byte $15,$A9,$20,$D0,$0B,$A8,$10,$0E,$20,$D0,$E8,$20,$12,$EB,$A9,$30
    .byte $9D,$38,$05,$20,$1E,$E9,$A5,$1A,$4A,$BD,$B8,$05,$B0,$06,$7D,$E8
    .byte $04,$4C,$F1,$9F,$FD,$E8,$04,$9D,$3E,$03,$60,$68,$69,$6A,$68,$6B
    .byte $6C,$8A,$A9,$63,$D7,$BD,$38,$05,$F0,$03,$DE,$38,$05,$DE,$E8,$05
    .byte $F0,$29,$BD,$E8,$05,$C9,$07,$B0,$0E,$C9,$01,$D0,$05,$A9,$52,$9D
    .byte $88,$05,$A9,$01,$9D,$D8,$05,$A9,$01,$9D,$78,$05,$A9,$10,$9D,$C8
    .byte $05,$A9,$16,$20,$6B,$C1,$A9,$03,$4C,$1A,$E8,$4C,$8E,$E7,$C6,$86
    .byte $D0,$03,$4C,$40,$E7,$4C,$4B,$E7,$A5,$86,$F0,$03,$4C,$09,$E8,$20
    .byte $14,$E8,$A9,$60,$4C,$F6,$EA,$5B,$A0,$94,$A0,$4B,$E7,$B0,$E7,$06
    .byte $E8,$20,$F5,$EC,$84,$0A,$98,$9D,$C8,$05,$20,$2F,$EB,$A5,$1A,$29
    .byte $03,$9D,$A8,$05,$A8,$B9,$90,$A0,$85,$06,$A9,$01,$85,$0F,$20,$2C
    .byte $F5,$48,$20,$13,$F3,$68,$20,$66,$F4,$A5,$0C,$9D,$B8,$05,$A9,$20
    .byte $9D,$58,$05,$4C,$8E,$E7,$01,$03,$04,$05,$BC,$A8,$05,$FE,$38,$05
    .byte $BD,$38,$05,$D9,$45,$A1,$90,$14,$A9,$00,$9D,$38,$05,$FE,$68,$05
    .byte $BD,$68,$05,$C9,$06,$90,$02,$A9,$00,$9D,$68,$05,$BD,$68,$05,$18
    .byte $69,$6D,$9D,$0A,$03,$20,$37,$E8,$BD,$D8,$05,$C9,$14,$B0,$3F,$DE
    .byte $58,$05,$D0,$3A,$A9,$08,$9D,$58,$05,$FE,$D8,$05,$20,$2F,$EB,$BD
    .byte $C8,$05,$85,$0A,$20,$1A,$F4,$B0,$25,$BD,$A8,$05,$09,$03,$9D,$A8
    .byte $05,$BD,$B8,$05,$0A,$A8,$B9,$09,$A1,$9D,$F8,$04,$B9,$0A,$A1,$9D
    .byte $E8,$04,$B9,$15,$A1,$9D,$18,$05,$B9,$16,$A1,$9D,$08,$05,$60,$00
    .byte $00,$63,$00,$C0,$00,$0F,$01,$4B,$01,$72,$01,$7E,$01,$72,$01,$4B
    .byte $01,$0F,$01,$C0,$00,$63,$00,$00,$00,$9D,$FF,$40,$FF,$F1,$FE,$B5
    .byte $FE,$8E,$FE,$82,$FE,$8E,$FE,$B5,$FE,$F1,$FE,$40,$FF,$9D,$FF,$00
    .byte $00,$63,$00,$C0,$00,$0F,$01,$4B,$01,$72,$01,$08,$06,$04,$02,$57
    .byte $A1,$8A,$A1,$F7,$A1,$45,$A2,$4B,$E7,$B0,$E7,$06,$E8,$BD,$A8,$05
    .byte $0A,$A8,$B9,$7E,$A1,$9D,$24,$03,$B9,$7F,$A1,$9D,$3E,$03,$BD,$A8
    .byte $05,$29,$01,$0A,$A8,$B9,$86,$A1,$9D,$18,$05,$B9,$87,$A1,$9D,$08
    .byte $05,$4C,$8E,$E7,$9C,$F0,$9C,$10,$61,$F0,$61,$10,$00,$FF,$00,$01
    .byte $20,$C5,$A1,$BD,$68,$05,$18,$69,$85,$9D,$0A,$03,$BD,$A8,$05,$4A
    .byte $A9,$47,$90,$02,$A9,$07,$9D,$58,$03,$20,$DB,$A1,$20,$37,$E8,$BD
    .byte $3E,$03,$C9,$D8,$B0,$2A,$C9,$28,$90,$26,$20,$F5,$EC,$C9,$10,$B0
    .byte $1F,$A9,$00,$9D,$68,$05,$A9,$01,$4C,$1F,$9F,$A5,$1A,$29,$03,$D0
    .byte $0F,$FE,$68,$05,$BD,$68,$05,$C9,$03,$90,$05,$A9,$00,$9D,$68,$05
    .byte $60,$A0,$00,$BD,$3E,$03,$C9,$DC,$B0,$04,$C9,$24,$B0,$02,$A0,$20
    .byte $84,$08,$BD,$58,$03,$29,$DF,$05,$08,$9D,$58,$03,$60,$DE,$38,$05
    .byte $D0,$FA,$A9,$08,$9D,$38,$05,$BD,$68,$05,$18,$69,$88,$9D,$0A,$03
    .byte $FE,$68,$05,$BD,$68,$05,$C9,$03,$90,$E2,$BD,$58,$03,$29,$DF,$9D
    .byte $58,$03,$20,$16,$EB,$BD,$A8,$05,$29,$01,$0A,$A8,$B9,$41,$A2,$9D
    .byte $18,$05,$B9,$42,$A2,$9D,$08,$05,$A9,$00,$9D,$F8,$04,$A9,$FF,$9D
    .byte $E8,$04,$A9,$10,$4C,$1F,$9F,$C0,$FF,$40,$00,$A9,$8B,$BC,$38,$05
    .byte $F0,$05,$DE,$38,$05,$A9,$8A,$9D,$0A,$03,$20,$40,$EB,$4C,$37,$E8
    .byte $57,$A1,$66,$A2,$BB,$A2,$4B,$E7,$B0,$E7,$06,$E8,$20,$C5,$A1,$BD
    .byte $68,$05,$18,$69,$8C,$9D,$0A,$03,$BD,$A8,$05,$4A,$A9,$46,$90,$02
    .byte $A9,$06,$9D,$58,$03,$20,$DB,$A1,$20,$37,$E8,$BD,$C8,$05,$D0,$45
    .byte $BD,$3E,$03,$C9,$D8,$B0,$3E,$C9,$28,$90,$3A,$BD,$A8,$05,$4A,$4A
    .byte $A9,$10,$90,$02,$A9,$30,$85,$0F,$20,$F5,$EC,$C5,$0F,$B0,$26,$A9
    .byte $8F,$9D,$0A,$03,$A9,$03,$9D,$B8,$05,$A9,$10,$9D,$58,$05,$4C,$8E
    .byte $E7,$DE,$58,$05,$F0,$10,$BD,$58,$05,$C9,$2C,$D0,$08,$BD,$58,$03
    .byte $29,$F7,$9D,$58,$03,$60,$A9,$90,$9D,$0A,$03,$DE,$B8,$05,$30,$1C
    .byte $A9,$30,$9D,$58,$05,$BD,$58,$03,$09,$08,$9D,$58,$03,$20,$F5,$EC
    .byte $84,$0A,$20,$2F,$EB,$A9,$00,$A0,$04,$4C,$9E,$F2,$FE,$C8,$05,$A9
    .byte $02,$4C,$1A,$E8,$04,$A3,$09,$A3,$09,$E8,$A9,$80,$4C,$1F,$9F,$A5
    .byte $87,$C9,$03,$90,$03,$4C,$09,$E8,$A5,$1A,$4A,$B0,$50,$DE,$38,$05
    .byte $D0,$4B,$BC,$B8,$05,$FE,$B8,$05,$B9,$68,$A3,$C9,$FF,$D0,$08,$A0
    .byte $00,$98,$9D,$B8,$05,$F0,$EE,$B9,$68,$A3,$30,$11,$29,$03,$85,$08
    .byte $B9,$68,$A3,$4A,$4A,$85,$09,$20,$4C,$A3,$4C,$1C,$A3,$0A,$9D,$38
    .byte $05,$60,$20,$CE,$ED,$D0,$14,$A5,$09,$4A,$A9,$1F,$90,$02,$A9,$1E
    .byte $9D,$28,$05,$20,$47,$EE,$A5,$08,$9D,$A8,$05,$A6,$83,$60,$00,$01
    .byte $02,$03,$D0,$06,$07,$A0,$04,$05,$C0,$00,$01,$B0,$02,$03,$D0,$04
    .byte $05,$06,$07,$D0,$00,$01,$02,$03,$FE,$FF,$8A,$A3,$99,$A3,$09,$E8
    .byte $20,$A7,$E8,$BD,$3E,$03,$C9,$C8,$B0,$42,$A9,$01,$4C,$8B,$E7,$20
    .byte $A7,$E8,$DE,$38,$05,$D0,$35,$A9,$80,$9D,$38,$05,$A9,$11,$4C,$52
    .byte $EB,$B5,$A3,$D7,$A3,$52,$E7,$B0,$E7,$06,$E8,$A9,$1A,$20,$6B,$C1
    .byte $A9,$20,$9D,$58,$03,$A9,$80,$9D,$18,$05,$A9,$00,$9D,$08,$05,$A9
    .byte $00,$9D,$F8,$04,$A9,$FE,$9D,$E8,$04,$4C,$8E,$E7,$60,$A5,$1A,$29
    .byte $07,$D0,$03,$FE,$68,$05,$BD,$68,$05,$29,$03,$A8,$B9,$0A,$A4,$9D
    .byte $0A,$03,$20,$37,$E8,$A9,$0A,$20,$42,$EB,$30,$E0,$A9,$00,$9D,$58
    .byte $03,$A0,$04,$20,$33,$EC,$F0,$D4,$A9,$24,$20,$6B,$C1,$4C,$8E,$E7
    .byte $74,$75,$76,$77,$1A,$A4,$48,$A4,$EE,$A4,$B5,$A5,$E3,$A5,$F8,$A5
    .byte $A9,$30,$9D,$3E,$03,$A9,$01,$9D,$D8,$04,$A9,$90,$9D,$24,$03,$A9
    .byte $0C,$9D,$B8,$05,$4A,$9D,$58,$05,$A9,$3F,$85,$78,$85,$7F,$85,$52
    .byte $A9,$41,$85,$53,$A9,$10,$20,$81,$D0,$A6,$83,$4C,$8E,$E7,$A5,$1A
    .byte $29,$01,$85,$77,$20,$C9,$A4,$BD,$D8,$04,$D0,$07,$BD,$3E,$03,$C9
    .byte $A0,$90,$4F,$BD,$78,$05,$F0,$0F,$DE,$58,$05,$D0,$0A,$A9,$1E,$20
    .byte $6B,$C1,$A9,$06,$9D,$58,$05,$A5,$1A,$29,$03,$A8,$B9,$DF,$A5,$85
    .byte $10,$A5,$1A,$29,$01,$D0,$11,$BD,$3E,$03,$38,$E9,$0C,$85,$09,$BD
    .byte $D8,$04,$E9,$00,$D0,$1B,$F0,$0F,$BD,$3E,$03,$18,$69,$14,$85,$09
    .byte $BD,$D8,$04,$69,$00,$D0,$0A,$BC,$24,$03,$A5,$09,$20,$93,$C1,$A6
    .byte $83,$60,$A9,$00,$85,$77,$BD,$A8,$05,$29,$01,$A8,$B9,$EC,$A4,$9D
    .byte $E8,$05,$A9,$47,$9D,$78,$05,$A9,$08,$9D,$38,$05,$4C,$8E,$E7,$A5
    .byte $68,$18,$65,$77,$85,$00,$BD,$3E,$03,$38,$E5,$00,$9D,$3E,$03,$B0
    .byte $10,$DE,$D8,$04,$BD,$78,$05,$F0,$08,$BD,$98,$05,$49,$81,$9D,$98
    .byte $05,$60,$00,$F8,$20,$AC,$A5,$90,$F8,$A5,$1A,$29,$01,$D0,$05,$DE
    .byte $E8,$05,$F0,$C8,$BD,$98,$05,$30,$E8,$DE,$38,$05,$D0,$E3,$BD,$D8
    .byte $05,$D0,$5E,$BD,$B8,$05,$85,$17,$20,$F5,$EC,$84,$0A,$A0,$F4,$A9
    .byte $00,$20,$32,$EB,$20,$1A,$F4,$BD,$B8,$05,$C9,$0A,$90,$04,$C9,$0D
    .byte $90,$07,$A5,$17,$9D,$B8,$05,$85,$0C,$C5,$0C,$D0,$05,$A9,$03,$9D
    .byte $D8,$05,$BD,$B8,$05,$38,$E9,$0A,$A8,$B9,$A0,$A5,$85,$10,$BD,$24
    .byte $03,$E9,$1C,$A8,$BD,$3E,$03,$E9,$2C,$85,$00,$BD,$D8,$04,$E9,$00
    .byte $D0,$43,$A5,$00,$20,$93,$C1,$A9,$01,$B0,$37,$A6,$83,$A9,$30,$D0
    .byte $31,$BD,$B8,$05,$38,$E9,$0A,$85,$00,$0A,$65,$00,$A8,$BD,$3E,$03
    .byte $F9,$A3,$A5,$85,$09,$BD,$D8,$04,$E9,$00,$90,$19,$BD,$24,$03,$F9
    .byte $A4,$A5,$85,$08,$B9,$A5,$A5,$BC,$A8,$05,$20,$BF,$F2,$DE,$D8,$05
    .byte $A9,$20,$9D,$38,$05,$60,$13,$12,$0F,$24,$03,$09,$29,$09,$0A,$2E
    .byte $14,$0C,$20,$80,$A6,$20,$C9,$A4,$4C,$C3,$A5,$A5,$1A,$29,$01,$85
    .byte $77,$20,$AC,$A5,$90,$1E,$4C,$5D,$A4,$BD,$D8,$04,$38,$10,$15,$BD
    .byte $3E,$03,$C9,$D0,$B0,$0E,$20,$09,$E8,$A9,$00,$85,$77,$85,$78,$85
    .byte $7F,$A6,$83,$18,$60,$10,$11,$14,$15,$20,$C9,$A4,$20,$07,$EB,$A9
    .byte $05,$9D,$B8,$05,$A9,$55,$20,$6B,$C1,$A9,$00,$4C,$8B,$E7,$A5,$1A
    .byte $29,$01,$85,$77,$20,$C9,$A4,$20,$C3,$A5,$90,$57,$BD,$38,$05,$D0
    .byte $53,$BD,$B8,$05,$30,$4D,$0A,$0A,$7D,$B8,$05,$A8,$BD,$3E,$03,$79
    .byte $63,$A6,$85,$00,$BD,$D8,$04,$79,$62,$A6,$D0,$34,$BD,$24,$03,$79
    .byte $64,$A6,$84,$07,$A8,$A9,$9B,$85,$10,$A5,$00,$20,$93,$C1,$B0,$23
    .byte $A6,$83,$A4,$07,$BD,$3E,$03,$79,$65,$A6,$85,$09,$BD,$24,$03,$18
    .byte $79,$66,$A6,$85,$08,$DE,$B8,$05,$A9,$04,$9D,$38,$05,$4C,$B3,$EA
    .byte $DE,$B8,$05,$60,$DE,$38,$05,$60,$00,$16,$04,$1C,$0E,$00,$16,$E4
    .byte $1C,$F2,$FF,$F6,$04,$00,$0E,$FF,$F6,$E4,$00,$F2,$FF,$D6,$04,$E4
    .byte $0E,$FF,$D6,$E4,$E4,$F2,$BD,$78,$05,$4A,$4A,$4A,$4A,$A8,$B9,$95
    .byte $A6,$85,$52,$A9,$10,$20,$81,$D0,$A6,$83,$60,$61,$60,$5F,$3F,$3F
    .byte $B2,$A6,$C3,$A6,$E6,$A6,$23,$A7,$61,$A7,$FD,$A7,$17,$A8,$2C,$A8
    .byte $34,$A8,$3F,$A8,$57,$A8,$B5,$A8,$A9,$10,$9D,$24,$03,$A9,$10,$85
    .byte $74,$20,$81,$D0,$A6,$83,$4C,$8E,$E7,$A5,$34,$29,$03,$A8,$B9,$E2
    .byte $A6,$9D,$3E,$03,$BD,$24,$03,$18,$69,$20,$C9,$71,$90,$02,$A9,$30
    .byte $9D,$24,$03,$A9,$03,$4C,$8B,$E7,$40,$60,$80,$80,$BC,$38,$05,$B9
    .byte $17,$A7,$85,$10,$98,$0A,$A8,$B9,$1B,$A7,$7D,$3E,$03,$85,$00,$B9
    .byte $1C,$A7,$18,$7D,$24,$03,$A8,$A5,$00,$20,$93,$C1,$A6,$83,$DE,$38
    .byte $05,$10,$09,$A9,$02,$9D,$B8,$05,$A9,$60,$D0,$C9,$60,$0D,$0E,$07
    .byte $08,$E4,$E4,$04,$E4,$E4,$04,$04,$04,$DE,$38,$05,$F0,$03,$4C,$B4
    .byte $A7,$20,$16,$EB,$20,$3B,$A7,$DE,$B8,$05,$10,$E0,$A9,$00,$4C,$8B
    .byte $E7,$A9,$0A,$9D,$38,$05,$BD,$B8,$05,$0A,$A8,$B9,$5A,$A7,$85,$07
    .byte $B9,$59,$A7,$A0,$00,$20,$EC,$A6,$A5,$07,$A0,$01,$4C,$EC,$A6,$0B
    .byte $05,$0A,$04,$09,$03,$0D,$0E,$DE,$38,$05,$F0,$45,$BD,$38,$05,$29
    .byte $0F,$D0,$47,$BD,$38,$05,$4A,$4A,$29,$0C,$A8,$B9,$E9,$A7,$85,$0A
    .byte $B9,$EA,$A7,$84,$17,$A0,$F4,$20,$57,$EB,$D0,$24,$A6,$17,$BD,$EB
    .byte $A7,$99,$08,$05,$A9,$10,$99,$38,$05,$A9,$02,$99,$88,$05,$8A,$29
    .byte $04,$D0,$05,$A9,$80,$99,$18,$05,$BD,$EC,$A7,$99,$0A,$03,$A6,$83
    .byte $60,$A9,$01,$9D,$B8,$05,$A9,$08,$D0,$60,$BD,$38,$05,$29,$07,$C9
    .byte $03,$D0,$ED,$BD,$38,$05,$85,$06,$A0,$00,$29,$08,$D0,$02,$A0,$02
    .byte $A9,$02,$9D,$38,$05,$B9,$FA,$A7,$85,$07,$B9,$F9,$A7,$A0,$02,$20
    .byte $EC,$A6,$A5,$07,$A0,$03,$20,$EC,$A6,$A5,$06,$9D,$38,$05,$60,$15
    .byte $14,$01,$7C,$16,$00,$00,$22,$15,$EC,$FE,$7C,$16,$00,$00,$22,$07
    .byte $08,$0C,$06,$DE,$38,$05,$D0,$B2,$20,$3B,$A7,$FE,$B8,$05,$BD,$B8
    .byte $05,$C9,$04,$D0,$2F,$20,$07,$EB,$A9,$20,$4C,$8B,$E7,$DE,$38,$05
    .byte $D0,$98,$A9,$18,$85,$74,$A9,$10,$20,$81,$D0,$A6,$83,$A9,$03,$4C
    .byte $8B,$E7,$BC,$38,$05,$A9,$9B,$4C,$EC,$A6,$DE,$38,$05,$D0,$05,$A9
    .byte $02,$4C,$1A,$E8,$60,$20,$83,$C1,$A9,$55,$20,$6B,$C1,$20,$07,$EB
    .byte $A9,$04,$9D,$B8,$05,$20,$E5,$E9,$A9,$10,$4C,$8B,$E7,$BD,$38,$05
    .byte $D0,$37,$BD,$B8,$05,$30,$41,$0A,$A8,$BD,$3E,$03,$85,$16,$79,$AB
    .byte $A8,$9D,$3E,$03,$BD,$24,$03,$85,$17,$18,$79,$AC,$A8,$9D,$24,$03
    .byte $C0,$10,$B0,$07,$A9,$9B,$20,$B5,$EB,$B0,$12,$20,$2F,$EB,$DE,$B8
    .byte $05,$A9,$08,$9D,$38,$05,$4C,$B3,$EA,$DE,$38,$05,$60,$A5,$16,$9D
    .byte $3E,$03,$A5,$17,$9D,$24,$03,$60,$A9,$02,$9D,$B8,$05,$A9,$04,$D0
    .byte $A9,$E0,$00,$00,$20,$20,$00,$F0,$F0,$00,$00,$BD,$38,$05,$D0,$D9
    .byte $BD,$B8,$05,$30,$1C,$0A,$7D,$B8,$05,$A8,$B9,$E3,$A8,$9D,$3E,$03
    .byte $B9,$E4,$A8,$9D,$24,$03,$B9,$E5,$A8,$20,$B5,$EB,$B0,$BE,$4C,$85
    .byte $A8,$20,$EA,$EA,$A9,$30,$4C,$F6,$EA,$C0,$80,$96,$C0,$A0,$97,$D0
    .byte $C0,$98,$FA,$A8,$05,$A9,$22,$A9,$4C,$A9,$4B,$E7,$B0,$E7,$06,$E8
    .byte $DE,$38,$05,$F0,$03,$4C,$55,$A9

L0_A902:
    jmp L_E78E                  ; A902  4C 8E E7


L0_A905:
    jsr L0_A952                 ; A905  20 52 A9
    jsr L_E842                  ; A908  20 42 E8
    lda $033E,x                 ; A90B  BD 3E 03
    cmp #$20                    ; A90E  C9 20
    bcc L0_A916                 ; A910  90 04
    cmp #$E0                    ; A912  C9 E0
    bcc L0_A94B                 ; A914  90 35

L0_A916:
    lda #$80                    ; A916  A9 80
    sta $04F8,x                 ; A918  9D F8 04
    lda #$01                    ; A91B  A9 01
    sta $04E8,x                 ; A91D  9D E8 04
    bne L0_A902                 ; A920  D0 E0
    jsr L0_A952                 ; A922  20 52 A9
    jsr L_E851                  ; A925  20 51 E8
    lda $0324,x                 ; A928  BD 24 03
    cmp #$A8                    ; A92B  C9 A8
    bcc L0_A94B                 ; A92D  90 1C
    lda #$A9                    ; A92F  A9 A9
    sta $0324,x                 ; A931  9D 24 03
    ldy #$01                    ; A934  A0 01
    lda $033E,x                 ; A936  BD 3E 03
    bpl L0_A93D                 ; A939  10 02
    ldy #$FE                    ; A93B  A0 FE

L0_A93D:
    tya                         ; A93D  98
    sta $0508,x                 ; A93E  9D 08 05
    lda #$80                    ; A941  A9 80
    sta $0518,x                 ; A943  9D 18 05
    jsr L_E8D0                  ; A946  20 D0 E8
    beq L0_A902                 ; A949  F0 B7

L0_A94B:
    rts                         ; A94B  60

    .byte $20,$52,$A9,$4C,$37,$E8

L0_A952:
    dec $0538,x                 ; A952  DE 38 05
    lda $0538,x                 ; A955  BD 38 05
    and #$03                    ; A958  29 03
    bne L0_A96B                 ; A95A  D0 0F
    inc $030A,x                 ; A95C  FE 0A 03
    lda $030A,x                 ; A95F  BD 0A 03
    cmp #$7F                    ; A962  C9 7F
    bcc L0_A96B                 ; A964  90 05
    sbc #$03                    ; A966  E9 03
    sta $030A,x                 ; A968  9D 0A 03

L0_A96B:
    rts                         ; A96B  60

    .byte $74,$A9,$4B,$E7,$B0,$E7,$06,$E8,$A9,$28,$20,$42,$EB,$BD,$24,$03
    .byte $C9,$B0,$90,$CF,$4C,$8E,$E7,$85,$A9,$A9,$C4,$9D,$0A,$03,$A5,$7F
    .byte $F0,$08,$A5,$68,$F0,$03,$DE,$3E,$03,$60,$4C,$A7,$E8,$A1,$A9,$C8
    .byte $A9,$0F,$AA,$2B,$AA,$A9,$04,$9D,$68,$05,$A9,$80,$1D,$A8,$05,$9D
    .byte $A8,$05,$A9,$08,$20,$1F,$EB,$BD,$A8,$05,$4A,$4A,$29,$03,$A8,$B9
    .byte $C4,$A9,$9D,$48,$05,$4C,$8B,$E7,$00,$20,$40,$60,$20,$5A,$AB,$20
    .byte $A7,$E8,$BD,$38,$05,$D0,$34,$20,$F5,$EC,$C9,$20,$B0,$4C,$BD,$3E
    .byte $03,$C9,$30,$90,$45,$A9,$09,$20,$6B,$C1,$20,$0E,$EB,$BD,$A8,$05
    .byte $29,$03,$A8,$B9,$0B,$AA,$9D,$C8,$05,$A9,$01,$9D,$0A,$03,$A9,$00
    .byte $9D,$B8,$05,$9D,$D8,$05,$9D,$E8,$05,$F0,$BA,$DE,$38,$05,$60,$05
    .byte $09,$0D,$0F,$20,$A7,$E8,$A0,$00,$20,$F5,$AA,$B0,$0D,$DE,$C8,$05
    .byte $F0,$09,$BD,$E8,$05,$69,$08,$9D,$E8,$05,$60,$A9,$10,$D0,$96,$20
    .byte $A7,$E8,$A0,$02,$20,$F5,$AA,$B0,$F1,$BD,$E8,$05,$E9,$07,$9D,$E8
    .byte $05,$10,$E7,$BD,$48,$05,$9D,$38,$05,$20,$07,$EB,$A9,$02,$4C,$1A
    .byte $E8,$55,$AA,$5A,$AA,$6C,$AA,$84,$AA,$A9,$40,$4C,$A8,$A9,$20,$5A
    .byte $AB,$20,$A7,$E8,$A5,$1A,$29,$7F,$DD,$48,$05,$D0,$1A,$4C,$DA,$A9
    .byte $20,$A7,$E8,$A0,$04,$20,$F5,$AA,$B0,$0D,$DE,$C8,$05,$F0,$AC,$BD
    .byte $D8,$05,$E9,$07,$9D,$D8,$05,$60,$20,$A7,$E8,$A0,$06,$20,$F5,$AA
    .byte $B0,$F5,$BD,$D8,$05,$69,$08,$9D,$D8,$05,$30,$EB,$F0,$E9,$10,$A3
    .byte $A4,$AA,$AE,$AA,$C3,$AA,$DE,$AA,$A9,$40,$9D,$58,$03,$A9,$00,$4C
    .byte $A8,$A9,$20,$5A,$AB,$20,$A7,$E8,$DE,$38,$05,$D0,$21,$A5,$34,$29
    .byte $3F,$9D,$48,$05,$4C,$DA,$A9,$20,$A7,$E8,$A0,$08,$20,$F5,$AA,$B0
    .byte $0D,$DE,$C8,$05,$F0,$09,$BD,$D8,$05,$69,$08,$9D,$D8,$05,$60,$4C
    .byte $27,$AA,$20,$A7,$E8,$A0,$0A,$20,$F5,$AA,$B0,$F2,$BD,$D8,$05,$E9
    .byte $07,$9D,$D8,$05,$10,$E8,$4C,$3F,$AA,$BD,$38,$05,$D0,$4F,$BD,$D8
    .byte $05,$1D,$E8,$05,$F0,$01,$C8,$B9,$4E,$AB,$85,$10,$BD,$E8,$05,$18
    .byte $7D,$24,$03,$A8,$88,$BD,$3E,$03,$38,$E9,$07,$85,$00,$BD,$D8,$05
    .byte $18,$30,$06,$65,$00,$90,$06,$18,$60,$65,$00,$90,$FB,$20,$A6,$C1
    .byte $B0,$1A,$A6,$83,$BD,$3E,$03,$C9,$30,$A9,$00,$90,$03,$18,$A9,$01
    .byte $9D,$38,$05,$BD,$D8,$05,$1D,$E8,$05,$9D,$B8,$05,$60,$DE,$38,$05
    .byte $38,$60,$87,$88,$80,$89,$84,$85,$80,$86,$81,$82,$80,$83,$DE,$58
    .byte $05,$BD,$58,$05,$29,$07,$D0,$C0,$BD,$58,$05,$4A,$4A,$4A,$29,$03
    .byte $1D,$68,$05,$A8,$B9,$77,$AB,$9D,$0A,$03,$60,$01,$BF,$C0,$BF,$01
    .byte $C1,$C2,$C1,$93,$AB,$B3,$AB,$BF,$AB,$7B,$AC,$D4,$AC,$16,$AD,$49
    .byte $AD,$61,$AD,$9B,$AD,$AD,$AD,$A5,$2F,$0A,$0A,$0A,$69,$40,$9D,$78
    .byte $05,$A5,$34,$9D,$B8,$05,$A9,$B8,$9D,$0A,$03,$A9,$9B,$9D,$24,$03
    .byte $A9,$31,$9D,$38,$05,$D0,$09,$20,$37,$E8,$DE,$38,$05,$F0,$01,$60
    .byte $4C,$8E,$E7,$20,$37,$E8,$BD,$B8,$05,$29,$03,$D0,$30,$20,$4A,$AC
    .byte $A9,$F9,$9D,$E8,$04,$A9,$80,$9D,$F8,$04,$A5,$34,$65,$1A,$29,$03
    .byte $0A,$A8,$B9,$6F,$AC,$9D,$08,$05,$B9,$70,$AC,$9D,$18,$05,$A9,$00
    .byte $9D,$E8,$05,$A9,$BA,$9D,$0A,$03,$A9,$05,$4C,$1A,$E8,$C9,$01,$D0
    .byte $14,$20,$4A,$AC,$FE,$E8,$05,$BD,$E8,$05,$C9,$04,$B0,$25,$A9,$20
    .byte $9D,$38,$05,$D0,$AB,$20,$4A,$AC,$A5,$34,$29,$01,$0A,$A8,$B9,$77
    .byte $AC,$9D,$08,$05,$B9,$78,$AC,$9D,$18,$05,$A9,$0C,$9D,$C8,$05,$A9
    .byte $06,$D0,$C7,$A9,$B8,$9D,$0A,$03,$20,$CD,$E8,$A5,$34,$9D,$B8,$05
    .byte $65,$1A,$29,$80,$1D,$38,$05,$9D,$38,$05,$A9,$03,$D0,$AC,$A0,$00
    .byte $A5,$39,$D0,$0B,$A5,$34,$29,$01,$A8,$A5,$38,$F0,$02,$A0,$01,$B9
    .byte $34,$03,$85,$08,$BD,$3E,$03,$C5,$08,$A9,$00,$B0,$02,$A9,$40,$9D
    .byte $58,$03,$60,$00,$80,$00,$00,$00,$00,$FF,$80,$01,$18,$FE,$E8,$20
    .byte $37,$E8,$A5,$8E,$F0,$4F,$DE,$38,$05,$F0,$2E,$BD,$38,$05,$C9,$0F
    .byte $B0,$05,$A9,$C3,$9D,$0A,$03,$A5,$1A,$29,$07,$C9,$03,$D0,$17,$BD
    .byte $78,$05,$C9,$20,$B0,$10,$A0,$51,$C9,$10,$B0,$02,$A0,$52,$98,$85
    .byte $57,$A9,$20,$20,$81,$D0,$A6,$83,$60,$A9,$14,$85,$0A,$A9,$F0,$A0
    .byte $E8,$20,$57,$EB,$D0,$0F,$BD,$58,$03,$29,$40,$F0,$08,$B9,$3E,$03
    .byte $69,$30,$99,$3E,$03,$4C,$2F,$AC,$20,$93,$AC,$20,$F9,$AC,$20,$37
    .byte $E8,$BD,$24,$03,$C9,$9B,$B0,$01,$60,$A9,$15,$20,$6B,$C1,$20,$CD
    .byte $E8,$A9,$9B,$9D,$24,$03,$A9,$B8,$9D,$0A,$03,$D0,$D8,$A9,$38,$20
    .byte $42,$EB,$BD,$3E,$03,$C9,$21,$90,$08,$C9,$C0,$90,$0C,$A9,$C0,$D0
    .byte $02,$A9,$20,$9D,$3E,$03,$20,$D9,$E8,$60,$20,$93,$AC,$20,$37,$E8
    .byte $BD,$3E,$03,$C9,$20,$90,$0A,$C9,$C0,$B0,$06,$DE,$C8,$05,$F0,$04
    .byte $60,$4C,$2F,$AC,$A9,$00,$9D,$E8,$05,$A9,$0C,$9D,$C8,$05,$FE,$D8
    .byte $05,$BD,$D8,$05,$29,$01,$18,$69,$B8,$9D,$0A,$03,$60,$20,$83,$C1
    .byte $A9,$55,$20,$EA,$EA,$20,$F8,$ED,$9D,$0A,$03,$85,$08,$85,$09,$20
    .byte $81,$AD,$4C,$8E,$E7,$A9,$08,$9D,$38,$05,$BD,$B8,$05,$C9,$04,$90
    .byte $05,$A9,$30,$4C,$8B,$E7,$FE,$B8,$05,$0A,$A8,$B9,$93,$AD,$85,$08
    .byte $B9,$94,$AD,$85,$09,$BD,$24,$03,$65,$08,$A8,$BD,$3E,$03,$65,$09
    .byte $84,$08,$85,$09,$4C,$B3,$EA,$F0,$F0,$10,$10,$F0,$10,$10,$F0,$DE
    .byte $38,$05,$F0,$00,$20,$F8,$ED,$A9,$08,$9D,$D8,$05,$A9,$0A,$4C,$8B
    .byte $E7,$DE,$38,$05,$F0,$22,$60,$A9,$8C,$85,$10,$BD,$C8,$05,$A8,$A9
    .byte $D0,$20,$A6,$C1,$A6,$83,$DE,$D8,$05,$D0,$03,$FE,$B8,$05,$BD,$C8
    .byte $05,$38,$E9,$08,$9D,$C8,$05,$60,$A9,$0A,$9D,$38,$05,$BD,$B8,$05
    .byte $C9,$01,$F0,$D3,$0A,$A8,$B9,$35,$AE,$85,$04,$B9,$36,$AE,$85,$05
    .byte $A0,$00,$B1,$04,$18,$69,$10,$85,$06,$A9,$D0,$85,$07,$86,$83,$A5
    .byte $07,$C8,$B1,$04,$C9,$FF,$F0,$17,$85,$10,$98,$48,$A5,$07,$A4,$06
    .byte $20,$A6,$C1,$68,$A8,$A5,$06,$18,$69,$10,$85,$06,$4C,$FB,$AD,$A6
    .byte $83,$A5,$06,$38,$E9,$20,$9D,$C8,$05,$FE,$B8,$05,$BD,$B8,$05,$C9
    .byte $03,$F0,$01,$60,$A9,$01,$4C,$F6,$EA,$3B,$AE,$3B,$AE,$3F,$AE,$90
    .byte $8B,$8A,$FF,$58,$8D,$FF,$48,$AE,$8A,$AE,$09,$E8,$A9,$06,$9D,$38
    .byte $05,$A9,$BB,$9D,$0A,$03,$A9,$FD,$9D,$08,$05,$A9,$00,$9D,$18,$05
    .byte $A2,$0F,$BD,$28,$05,$C9,$13,$F0,$03,$CA,$D0,$F6,$BD,$58,$03,$29
    .byte $40,$F0,$0C,$A6,$83,$A9,$03,$9D,$08,$05,$A9,$00,$9D,$18,$05,$A6
    .byte $83,$A9,$02,$9D,$E8,$04,$A9,$00,$9D,$F8,$04,$4C,$8E,$E7,$BD,$3E
    .byte $03,$C9,$E0,$B0,$F6,$DE,$38,$05,$F0,$0F,$BD,$24,$03,$C9,$AF,$B0
    .byte $02,$90,$03,$20,$D0,$E8,$4C,$37,$E8,$A9,$06,$9D,$38,$05,$FE,$B8
    .byte $05,$BD,$B8,$05,$29,$01,$18,$69,$BB,$9D,$0A,$03,$4C,$37,$E8,$C3
    .byte $AE,$E5,$AE,$30,$AF,$4D,$AF,$20,$A7,$E8,$BD,$A8,$05,$4A,$4A,$29
    .byte $03,$A8,$B9,$E1,$AE,$9D,$68,$05,$BD,$A8,$05,$29,$03,$9D,$A8,$05
    .byte $A9,$20,$4C,$8B,$E7,$00,$20,$40,$60,$20,$A7,$E8,$BD,$A8,$05,$C9
    .byte $03,$F0,$25,$A5,$1A,$29,$7F,$DD,$68,$05,$D0,$4D,$BD,$3E,$03,$C9
    .byte $2C,$90,$46,$BD,$A8,$05,$A8,$0A,$9D,$E8,$05,$B9,$2C,$AF,$9D,$C8
    .byte $05,$A9,$00,$9D,$D8,$05,$F0,$CA,$BD,$38,$05,$D0,$0E,$A5,$1A,$C9
    .byte $C0,$B0,$26,$20,$F5,$EC,$C9,$10,$90,$D2,$60,$DE,$38,$05,$38,$60
    .byte $04,$03,$08,$03,$20,$A7,$E8,$20,$6A,$AF,$B0,$0D,$DE,$C8,$05,$F0
    .byte $09,$A9,$08,$20,$1F,$EB,$FE,$D8,$05,$60,$FE,$E8,$05,$A9,$08,$D0
    .byte $91,$20,$A7,$E8,$20,$6A,$AF,$B0,$F0,$DE,$D8,$05,$30,$05,$A9,$F8
    .byte $4C,$1F,$EB,$BD,$68,$05,$9D,$38,$05,$A9,$02,$4C,$1A,$E8,$BD,$38
    .byte $05,$D0,$B8,$BD,$E8,$05,$0A,$A8,$B9,$A2,$AF,$85,$10,$B9,$A3,$AF
    .byte $85,$11,$BC,$D8,$05,$B1,$10,$85,$10,$BD,$3E,$03,$BC,$24,$03,$20
    .byte $A6,$C1,$B0,$11,$A6,$83,$BD,$3E,$03,$C9,$2C,$A9,$00,$90,$03,$18
    .byte $A9,$02,$9D,$38,$05,$60,$B2,$AF,$B6,$AF,$B2,$AF,$B6,$AF,$BA,$AF
    .byte $C2,$AF,$B2,$AF,$B6,$AF,$86,$86,$86,$86,$80,$80,$82,$84,$86,$86
    .byte $86,$86,$86,$86,$86,$86,$80,$80,$80,$80,$80,$80,$82,$84,$D6,$AF
    .byte $0C,$B0,$25,$B0,$00,$B2,$87,$B0,$9C,$B0,$BD,$A8,$05,$29,$0C,$4A
    .byte $A8,$B9,$00,$B0,$9D,$D8,$05,$B9,$01,$B0,$9D,$E8,$05,$BD,$A8,$05
    .byte $29,$03,$A8,$B9,$08,$B0,$9D,$58,$05,$20,$A7,$E8,$A9,$C0,$9D,$A8
    .byte $05,$4C,$8E,$E7,$30,$00,$50,$0F,$70,$1E,$40,$00,$0C,$08,$04,$02
    .byte $20,$A7,$E8,$20,$F5,$EC,$DD,$D8,$05,$B0,$5A,$20,$16,$EB,$A9,$06
    .byte $9D,$C8,$05,$BD,$E8,$05,$4C,$8B,$E7,$20,$A7,$E8,$BD,$38,$05,$D0
    .byte $41,$BD,$C8,$05,$0A,$7D,$C8,$05,$A8,$B9,$73,$B0,$85,$10,$B9,$74
    .byte $B0,$9D,$B8,$05,$B9,$72,$B0,$7D,$24,$03,$A8,$BD,$3E,$03,$E9,$0D
    .byte $20,$93,$C1,$B0,$20,$A6,$83,$BD,$C8,$05,$C9,$04,$B0,$07,$A9,$00
    .byte $A0,$0F,$20,$26,$EA,$BD,$58,$05,$9D,$38,$05,$DE,$C8,$05,$10,$05
    .byte $30,$8F,$DE,$38,$05,$60,$C0,$91,$D0,$D0,$91,$E0,$E0,$90,$F0,$E0
    .byte $8F,$F8,$F0,$8E,$00,$F0,$8D,$09,$F0,$8C,$09,$A9,$00,$9D,$E8,$05
    .byte $A9,$03,$9D,$38,$05,$20,$A7,$E8,$A9,$24,$20,$6B,$C1,$4C,$8E,$E7
    .byte $20,$A7,$E8,$BD,$E8,$05,$0A,$7D,$E8,$05,$A8,$B9,$E7,$B0,$85,$10
    .byte $B9,$E6,$B0,$7D,$24,$03,$84,$F0,$A8,$BD,$3E,$03,$E9,$0D,$90,$27
    .byte $20,$93,$C1,$B0,$B0,$A6,$83,$BD,$E8,$05,$29,$03,$F0,$03,$20,$23
    .byte $EA,$A4,$F0,$B9,$E8,$B0,$A8,$A9,$FC,$20,$32,$EB,$20,$B3,$EA,$FE
    .byte $E8,$05,$DE,$38,$05,$D0,$8E,$4C,$09,$E8,$00,$84,$08,$E0,$8B,$F0
    .byte $C0,$8A,$D0,$A0,$86,$B0,$00,$84,$08,$E0,$8B,$F0,$C0,$86,$D0,$03
    .byte $B1,$00,$B2,$91,$B0,$9C,$B0,$A9,$B8,$9D,$B8,$05,$BC,$A8,$05,$B9
    .byte $1A,$B1,$9D,$E8,$05,$B9,$1B,$B1,$9D,$38,$05,$4C,$F5,$AF,$04,$03
    .byte $00,$04,$22,$B1,$2C,$B1,$A9,$80,$9D,$68,$05,$A9,$01,$4C,$8B,$E7
    .byte $20,$A7,$E8,$BD,$68,$05,$10,$35,$DE,$38,$05,$D0,$40,$FE,$38,$05
    .byte $20,$CE,$ED,$D0,$25,$A9,$14,$9D,$28,$05,$20,$47,$EE,$A9,$F8,$9D
    .byte $3E,$03,$A9,$FF,$9D,$08,$05,$A9,$02,$9D,$E8,$05,$A9,$80,$9D,$A8
    .byte $05,$20,$ED,$B1,$8A,$A6,$83,$9D,$68,$05,$A6,$83,$60,$BC,$68,$05
    .byte $B9,$B8,$04,$D0,$08,$A9,$80,$9D,$68,$05,$9D,$38,$05,$60,$86,$B1
    .byte $86,$B1,$86,$B1,$4B,$E7,$B0,$E7,$06,$E8,$A5,$1A,$4A,$4A,$29,$01
    .byte $18,$69,$2A,$9D,$0A,$03,$20,$37,$E8,$BC,$E8,$05,$BD,$3E,$03,$18
    .byte $79,$D6,$B1,$85,$00,$A9,$00,$79,$D5,$B1,$85,$10,$A5,$00,$BC,$24
    .byte $03,$20,$C3,$E0,$D0,$0E,$A9,$00,$A0,$09,$20,$35,$EC,$D0,$BE,$A9
    .byte $20,$4C,$42,$EB,$BD,$A8,$05,$30,$0B,$BD,$E8,$05,$49,$02,$9D,$E8
    .byte $05,$4C,$1E,$E9,$A9,$04,$4C,$1A,$E8,$00,$0F,$FF,$F1,$E5,$B1,$FB
    .byte $B1,$86,$B1,$4B,$E7,$B0,$E7,$06,$E8,$A9,$C0,$20,$ED,$B1,$4C,$8E
    .byte $E7,$9D,$18,$05,$A9,$2A,$9D,$0A,$03,$A9,$C8,$9D,$24,$03,$60,$BD
    .byte $68,$05,$D0,$EA,$4C,$A7,$E8,$11,$B2,$19,$B2,$28,$B2,$40,$E7,$B0
    .byte $E7,$40,$B2,$48,$B2,$A9,$1B,$20,$6B,$C1,$4C,$8E,$E7,$20,$A7,$E8
    .byte $BD,$78,$05,$C9,$05,$B0,$04,$A9,$02,$85,$85,$60,$BD,$B8,$05,$D0
    .byte $08,$A9,$08,$20,$27,$EB,$FE,$B8,$05,$A9,$05,$20,$B5,$EB,$90,$01
    .byte $60,$4C,$8E,$E7,$20,$14,$E8,$A9,$20,$4C,$1F,$EB,$BC,$C8,$05,$B9
    .byte $72,$B2,$20,$B5,$EB,$B0,$E9,$A9,$05,$A0,$05,$20,$26,$EA,$20,$2F
    .byte $EB,$20,$B3,$EA,$20,$43,$B2,$FE,$C8,$05,$BD,$C8,$05,$C9,$02,$90
    .byte $CF,$A9,$80,$4C,$F6,$EA,$08,$04,$84,$B2,$9A,$B2,$C3,$B2,$EF,$B2
    .byte $0F,$B3,$4B,$E7,$B0,$E7,$06,$E8,$A9,$04,$20,$1F,$EB,$A9,$04,$9D
    .byte $B8,$05,$BD,$A8,$05,$4A,$A9,$60,$90,$02,$A9,$10,$D0,$26,$20,$A7
    .byte $E8,$A5,$84,$F0,$14,$DE,$38,$05,$D0,$0F,$20,$1B,$B3,$B0,$0A,$BD
    .byte $68,$05,$C9,$02,$B0,$04,$FE,$68,$05,$60,$20,$16,$EB,$A9,$10,$9D
    .byte $58,$05,$A9,$60,$4C,$8B,$E7,$20,$A7,$E8,$DE,$38,$05,$F0,$1D,$DE
    .byte $58,$05,$D0,$17,$A9,$0B,$20,$52,$EB,$D0,$10,$BD,$B8,$05,$99,$B8
    .byte $05,$DE,$B8,$05,$D0,$05,$A9,$04,$9D,$B8,$05,$60,$20,$07,$EB,$A9
    .byte $01,$D0,$D1,$20,$A7,$E8,$DE,$38,$05,$D0,$0D,$20,$1B,$B3,$B0,$08
    .byte $BD,$68,$05,$F0,$04,$DE,$68,$05,$60,$A9,$A0,$9D,$38,$05,$A9,$02
    .byte $4C,$1A,$E8,$A9,$03,$20,$1E,$B3,$B0,$EE,$E6,$85,$4C,$8E,$E7,$BD
    .byte $68,$05,$18,$69,$08,$20,$08,$EC,$A9,$01,$B0,$02,$A9,$08,$9D,$38
    .byte $05,$60,$38,$B3,$3C,$B3,$8F,$B3,$D0,$B3,$F5,$B3,$A9,$A0,$D0,$4C
    .byte $BD,$D8,$05,$C9,$1E,$B0,$06,$A5,$85,$C9,$02,$90,$05,$A9,$F0,$9D
    .byte $38,$05,$20,$F8,$B3,$B0,$0A,$BD,$68,$05,$C9,$02,$B0,$04,$FE,$68
    .byte $05,$60,$FE,$D8,$05,$A0,$00,$AD,$34,$03,$C9,$A0,$B0,$07,$AD,$35
    .byte $03,$C9,$A0,$90,$01,$C8,$98,$9D,$C8,$05,$A5,$34,$29,$03,$A8,$B9
    .byte $8B,$B3,$9D,$B8,$05,$A9,$10,$9D,$58,$05,$A9,$80,$4C,$8B,$E7,$03
    .byte $04,$02,$04,$20,$A7,$E8,$DE,$38,$05,$F0,$35,$DE,$58,$05,$D0,$2F
    .byte $A9,$05,$85,$0A,$A0,$00,$A9,$F8,$20,$57,$EB,$BD,$C8,$05,$D0,$10
    .byte $BD,$D8,$05,$C9,$14,$B0,$04,$A5,$85,$F0,$05,$A5,$34,$4A,$29,$01
    .byte $99,$A8,$05,$A9,$10,$DE,$B8,$05,$D0,$02,$A9,$FF,$9D,$58,$05,$60
    .byte $A9,$01,$D0,$B8,$20,$F8,$B3,$B0,$08,$BD,$68,$05,$F0,$04,$DE,$68
    .byte $05,$60,$A5,$34,$4A,$4A,$4A,$29,$03,$A8,$B9,$F1,$B3,$9D,$38,$05
    .byte $A9,$02,$4C,$1A,$E8,$F0,$80,$A0,$C0,$4C,$09,$E8,$20,$A7,$E8,$DE
    .byte $38,$05,$D0,$1C,$BD,$68,$05,$0A,$A8,$B9,$1E,$B4,$85,$10,$B9,$1F
    .byte $B4,$A0,$00,$20,$CE,$EB,$A9,$08,$90,$02,$A9,$01,$9D,$38,$05,$60
    .byte $38,$60,$03,$12,$13,$14,$07,$15,$4B,$B4,$7C,$B4,$45,$B5,$9B,$B6
    .byte $B2,$B6,$72,$B5,$D8,$B5,$01,$B6,$23,$B6,$43,$B6,$76,$B6,$02,$BD
    .byte $09,$E8,$A5,$31,$20,$46,$B4,$85,$07,$60,$0A,$0A,$0A,$0A,$60,$20
    .byte $61,$B4,$A9,$20,$9D,$E8,$05,$A9,$90,$9D,$B8,$05,$A9,$40,$85,$76
    .byte $A9,$03,$4C,$8B,$E7,$20,$3E,$B4,$A5,$2F,$20,$46,$B4,$18,$69,$37
    .byte $B0,$08,$65,$07,$B0,$04,$C9,$A0,$90,$02,$A9,$A0,$9D,$78,$05,$60
    .byte $BD,$3E,$03,$C9,$50,$B0,$03,$4C,$A7,$E8,$BD,$C8,$05,$F0,$03,$20
    .byte $E5,$B4,$BD,$D8,$05,$F0,$03,$20,$FD,$B4,$DE,$E8,$05,$D0,$22,$A9
    .byte $20,$9D,$E8,$05,$BD,$B8,$05,$C9,$90,$D0,$0B,$A9,$92,$9D,$B8,$05
    .byte $DE,$38,$05,$4C,$B7,$B4,$A9,$90,$9D,$B8,$05,$20,$E5,$B4,$20,$FD
    .byte $B4,$20,$A7,$E8,$BD,$38,$05,$D0,$03,$4C,$3D,$B5,$60,$86,$83,$A5
    .byte $08,$85,$10,$A5,$09,$38,$E9,$10,$A8,$A5,$0A,$38,$E9,$0E,$20,$93
    .byte $C1,$A6,$83,$A9,$00,$2A,$85,$0B,$60,$BD,$B8,$05,$85,$08,$18,$69
    .byte $01,$85,$0C,$A9,$10,$20,$57,$BD,$20,$1B,$B5,$A5,$0B,$9D,$C8,$05
    .byte $60,$BD,$B8,$05,$C9,$92,$F0,$02,$A9,$81,$18,$69,$02,$85,$08,$A0
    .byte $20,$A9,$11,$20,$5D,$BD,$20,$C9,$B4,$A5,$0B,$9D,$D8,$05,$60,$A5
    .byte $09,$85,$05,$A5,$0A,$85,$06,$A5,$0C,$85,$04,$20,$C9,$B4,$A5,$04
    .byte $85,$08,$A5,$05,$85,$09,$A5,$06,$38,$E9,$20,$85,$0A,$4C,$C9,$B4
    .byte $60,$20,$FD,$B4,$A9,$20,$4C,$8B,$E7,$20,$A7,$E8,$A5,$8E,$F0,$1C
    .byte $DE,$38,$05,$BD,$38,$05,$C9,$02,$90,$08,$D0,$E4,$A5,$2F,$C9,$03
    .byte $90,$DE,$A9,$11,$20,$52,$EB,$BD,$38,$05,$D0,$D4,$A9,$03,$9D,$38
    .byte $05,$A9,$02,$4C,$1A,$E8,$20,$A7,$E8,$A9,$00,$20,$86,$B5,$A5,$0B
    .byte $D0,$BE,$A9,$01,$9D,$C8,$05,$4C,$8E,$E7,$0A,$0A,$A8,$B9,$A8,$B5
    .byte $85,$08,$B9,$A9,$B5,$85,$0C,$B9,$AA,$B5,$18,$7D,$24,$03,$85,$09
    .byte $B9,$AB,$B5,$18,$7D,$3E,$03,$85,$0A,$4C,$1B,$B5,$83,$83,$00,$10
    .byte $95,$96,$C0,$30,$97,$83,$E0,$50,$84,$85,$F0,$10,$86,$87,$10,$10
    .byte $88,$89,$F0,$10,$8A,$8B,$10,$10,$8C,$8D,$F0,$10,$8E,$8F,$10,$10
    .byte $83,$83,$20,$F0,$83,$83,$40,$F0,$29,$29,$60,$F0,$20,$A7,$E8,$BD
    .byte $C8,$05,$F0,$14,$A9,$83,$85,$08,$A0,$20,$A9,$10,$20,$5D,$BD,$20
    .byte $C9,$B4,$A5,$0B,$9D,$C8,$05,$60,$A9,$E0,$20,$1F,$EB,$20,$72,$B5
    .byte $A9,$20,$4C,$1F,$EB,$20,$A7,$E8,$BD,$C8,$05,$F0,$0B,$A9,$01,$20
    .byte $86,$B5,$A5,$0B,$9D,$C8,$05,$60,$A9,$02,$20,$86,$B5,$A5,$0B,$D0
    .byte $F6,$FE,$C8,$05,$4C,$8E,$E7,$20,$A7,$E8,$A9,$83,$85,$08,$A9,$30
    .byte $20,$57,$BD,$20,$C9,$B4,$A0,$C0,$A9,$F0,$20,$5D,$BD,$A9,$83,$85
    .byte $08,$20,$C9,$B4,$4C,$19,$B6,$20,$A7,$E8,$BD,$C8,$05,$F0,$0E,$A9
    .byte $09,$20,$86,$B5,$48,$20,$61,$B6,$68,$9D,$C8,$05,$60,$A9,$0A,$20
    .byte $4D,$B6,$F0,$BD,$60,$A5,$12,$48,$20,$23,$EA,$68,$18,$69,$04,$85
    .byte $12,$A5,$13,$69,$00,$85,$13,$4C,$23,$EA,$20,$A7,$E8,$BD,$C8,$05
    .byte $F0,$1A,$A9,$0B,$20,$86,$B5,$48,$A5,$12,$38,$E9,$20,$85,$12,$A5
    .byte $13,$E9,$00,$85,$13,$20,$61,$B6,$68,$F0,$01,$60,$4C,$8E,$E7,$A9
    .byte $55,$20,$6B,$C1,$20,$A7,$E8,$20,$F8,$ED,$85,$08,$85,$09,$20,$D8
    .byte $B6,$A9,$05,$4C,$8B,$E7,$20,$A7,$E8,$DE,$38,$05,$D0,$DD,$A9,$05
    .byte $9D,$38,$05,$FE,$B8,$05,$BD,$B8,$05,$C9,$0C,$F0,$CF,$4C,$CC,$B6
    .byte $0A,$A8,$B9,$34,$BD,$85,$08,$B9,$35,$BD,$85,$09,$A4,$08,$A5,$09
    .byte $20,$32,$EB,$4C,$B3,$EA,$EC,$B6,$36,$B7,$4B,$E7,$B0,$E7,$06,$E8
    .byte $20,$D2,$B7,$1E,$D8,$05,$A5,$31,$18,$69,$02,$9D,$78,$05,$A9,$AC
    .byte $9D,$0A,$03,$A9,$06,$9D,$38,$05,$A5,$39,$D0,$15,$A5,$34,$65,$1A
    .byte $29,$1F,$18,$69,$0E,$9D,$E8,$05,$A5,$38,$F0,$05,$A9,$01,$9D,$E8
    .byte $05,$A5,$34,$29,$03,$D0,$02,$A9,$03,$0A,$BC,$A8,$05,$F0,$02,$A9
    .byte $06,$9D,$B8,$05,$FE,$B8,$04,$4C,$A6,$B7,$DE,$38,$05,$D0,$49,$A9
    .byte $06,$9D,$38,$05,$A0,$FF,$BD,$B8,$05,$18,$69,$01,$C9,$0C,$D0,$02
    .byte $A9,$00,$38,$E9,$03,$C8,$B0,$FA,$98,$0A,$85,$08,$BD,$C8,$05,$49
    .byte $01,$9D,$C8,$05,$BD,$58,$03,$29,$3F,$9D,$58,$03,$A5,$08,$C9,$04
    .byte $90,$0D,$BD,$58,$03,$09,$C0,$9D,$58,$03,$A5,$08,$38,$E9,$04,$18
    .byte $69,$AC,$7D,$C8,$05,$9D,$0A,$03,$DE,$D8,$05,$D0,$03,$20,$8F,$B7
    .byte $4C,$37,$E8,$BD,$E8,$05,$29,$3E,$F0,$22,$20,$D2,$B7,$20,$2F,$EB
    .byte $BD,$E8,$05,$29,$01,$85,$0A,$20,$20,$F4,$BD,$B8,$05,$0A,$0A,$A8
    .byte $20,$B9,$B7,$BD,$E8,$05,$18,$E9,$02,$9D,$E8,$05,$60

L0_B7B9:
    lda D0_B9EF,y               ; B7B9  B9 EF B9
    sta $04E8,x                 ; B7BC  9D E8 04
    lda D0_B9F0,y               ; B7BF  B9 F0 B9
    sta $04F8,x                 ; B7C2  9D F8 04
    lda D0_B9FB,y               ; B7C5  B9 FB B9
    sta $0508,x                 ; B7C8  9D 08 05
    lda D0_B9FC,y               ; B7CB  B9 FC B9
    sta $0518,x                 ; B7CE  9D 18 05
    rts                         ; B7D1  60

    .byte $A4,$8B,$E6,$8B,$B9,$E8,$B7,$C9,$FF,$D0,$07,$A9,$00,$85,$8B,$4C
    .byte $D2,$B7,$9D,$D8,$05,$60,$16,$0F,$08,$13,$3A,$06,$21,$3A,$1D,$14
    .byte $12,$28,$48,$FF,$02,$B8,$1F,$B8,$5E,$B8,$4B,$E7,$B0,$E7,$06,$E8
    .byte $A5,$2F,$69,$03,$85,$08,$A5,$31,$0A,$65,$08,$9D,$78,$05,$A9,$20
    .byte $9D,$D8,$05,$A9,$01,$20,$B5,$EB,$A9,$0A,$4C,$8B,$E7,$20,$A7,$E8
    .byte $BD,$3E,$03,$C9,$20,$B0,$01,$60,$A5,$8E,$F0,$13,$DE,$38,$05,$D0
    .byte $0E,$A9,$13,$20,$52,$EB,$A5,$34,$29,$1F,$69,$C0,$9D,$38,$05,$DE
    .byte $D8,$05,$D0,$17,$BD,$E8,$05,$29,$01,$18,$69,$00,$20,$B5,$EB,$A9
    .byte $01,$B0,$05,$FE,$E8,$05,$A9,$20,$9D,$D8,$05,$60,$A9,$02,$20,$B5
    .byte $EB,$B0,$F8,$4C,$8E,$E7,$74,$B8,$B3,$B8,$40,$B9,$4B,$E7,$B0,$E7
    .byte $06,$E8,$A5,$34,$29,$1F,$69,$50,$9D

L0_B87B:
    iny                         ; B87B  C8
    ora $A9                     ; B87C  05 A9
    cpy #$9D                    ; B87E  C0 9D
    sec                         ; B880  38
    ora $A5                     ; B881  05 A5
    and $12D0,y                 ; B883  39 D0 12
    lda $34                     ; B886  A5 34
    adc $1A                     ; B888  65 1A
    and #$01                    ; B88A  29 01
    sta $05D8,x                 ; B88C  9D D8 05
    lda $38                     ; B88F  A5 38
    beq L0_B898                 ; B891  F0 05
    lda #$01                    ; B893  A9 01
    sta $05D8,x                 ; B895  9D D8 05

L0_B898:
    lda #$B0                    ; B898  A9 B0
    sta $030A,x                 ; B89A  9D 0A 03
    lda $05D8,x                 ; B89D  BD D8 05
    sta $0A                     ; B8A0  85 0A
    jsr L_EB2F                  ; B8A2  20 2F EB
    jsr L_F451                  ; B8A5  20 51 F4
    lda $0C                     ; B8A8  A5 0C
    sta $05B8,x                 ; B8AA  9D B8 05
    inc $04B8,x                 ; B8AD  FE B8 04
    jmp L0_B8E8                 ; B8B0  4C E8 B8

    .byte $A9,$B0,$20,$AD,$B9,$20,$37,$E8,$BD

L0_B8BC:
    inx                         ; B8BC  E8
    ora $D0                     ; B8BD  05 D0
    adc ($20,x)                 ; B8BF  61 20
    beq L0_B87B                 ; B8C1  F0 B8
    cmp #$08                    ; B8C3  C9 08
    bne L0_B8CA                 ; B8C5  D0 03
    jsr L0_B8D0                 ; B8C7  20 D0 B8

L0_B8CA:
    dec $05C8,x                 ; B8CA  DE C8 05
    beq L0_B916                 ; B8CD  F0 47
    rts                         ; B8CF  60


L0_B8D0:
    ldy $05B8,x                 ; B8D0  BC B8 05
    lda $04F8,x                 ; B8D3  BD F8 04
    clc                         ; B8D6  18
    adc D0_B8F8,y               ; B8D7  79 F8 B8
    sta $04F8,x                 ; B8DA  9D F8 04
    lda $0518,x                 ; B8DD  BD 18 05
    clc                         ; B8E0  18
    adc D0_B8FE,y               ; B8E1  79 FE B8
    sta $0518,x                 ; B8E4  9D 18 05
    rts                         ; B8E7  60


L0_B8E8:
    lda $05B8,x                 ; B8E8  BD B8 05
    asl a                       ; B8EB  0A
    tay                         ; B8EC  A8
    jmp L0_B7B9                 ; B8ED  4C B9 B7

    .byte $BD,$38,$05,$4A,$4A,$4A,$4A,$60
D0_B8F8:
    .byte $00,$FD,$FA,$F8,$F6,$F5
D0_B8FE:
    .byte $F4,$F5,$F6,$F8,$FA,$FD,$00,$03,$06,$08,$0A,$0B,$0C,$0B,$0A,$08
    .byte $06,$03,$00,$FD,$FA,$F8,$F6,$F5

L0_B916:
    lda $34                     ; B916  A5 34
    and #$20                    ; B918  29 20
    clc                         ; B91A  18
    adc #$02                    ; B91B  69 02
    sta $05E8,x                 ; B91D  9D E8 05
    rts                         ; B920  60

    .byte $20,$CD,$E8,$DE,$E8,$05,$D0,$F7,$A9,$08,$9D,$E8,$05,$9D,$C8,$05
    .byte $FE,$B8,$04,$20,$A2,$B9,$20,$A2,$B9,$20,$A2,$B9,$4C,$A2,$B9,$A9
    .byte $B0,$20,$AD,$B9,$BD,$E8,$05,$F0,$42,$DE,$C8,$05,$F0,$03,$4C,$8C
    .byte $B9,$FE,$E8,$05,$FE,$E8,$05,$BD,$E8,$05,$9D,$C8,$05,$20,$A2,$B9
    .byte $BD,$B8,$05,$0A,$A8,$B9,$F2,$B9,$85,$08,$B9,$F1,$B9,$20,$8F,$B9
    .byte $9D,$E8,$04,$A5,$08,$9D,$F8,$04,$B9,$F8,$B9,$85,$08,$B9,$F7,$B9
    .byte $20,$8F,$B9,$9D,$08,$05,$A5,$08,$9D,$18,$05,$4C,$37,$E8,$85,$09
    .byte $85,$0A,$A5,$08,$0A,$26,$09,$18,$65,$08,$85,$08,$A5,$09,$65,$0A
    .byte $60,$20,$2F,$EB,$BD,$D8,$05,$85,$0A,$4C,$1A,$F4,$85,$08,$BD,$38
    .byte $05,$29,$0F,$A8,$20,$F0,$B8,$9D,$38,$05,$DE,$38,$05,$D0,$18,$B9
    .byte $EA,$B9,$C9,$FF,$D0,$05,$A0,$00,$4C,$C0,$B9,$C8,$18,$65,$08,$9D
    .byte $0A,$03,$A9,$08,$9D,$38,$05,$BD,$38,$05,$20,$46,$B4,$9D,$38,$05
    .byte $98,$18,$7D,$38,$05,$9D,$38,$05,$60,$00,$01,$02,$01,$FF
D0_B9EF:
    .byte $00
D0_B9F0:
    .byte $00,$00,$42,$00,$7F,$00,$B2,$00,$DD,$00,$F7
D0_B9FB:
    .byte $00
D0_B9FC:
    .byte $FF,$00,$F7,$00,$DD,$00,$B2,$00,$7F,$00,$42,$00,$00,$FF,$BE,$FF
    .byte $81,$FF,$4E,$FF,$23,$FF,$09,$FF,$01,$FF,$09,$FF,$23,$FF,$4E,$FF
    .byte $81,$FF,$BE,$00,$00,$00,$42,$00,$7F,$00,$B2,$00,$DD,$00,$F7,$3B
    .byte $BA,$44,$BB,$68,$BB,$8C,$BA,$2A,$BB,$4B,$E7,$B0,$E7,$06,$E8,$20
    .byte $6F,$BA,$20,$F8,$ED,$A9,$B3,$9D,$0A,$03,$A9,$FE,$9D,$08,$05,$A9
    .byte $80,$9D,$18,$05,$20,$D0,$E8,$A5,$39,$D0,$09,$A5,$34,$65,$1A,$29
    .byte $01,$9D,$B8,$05,$A5,$34,$4A,$65,$1A,$29,$02,$9D,$C8,$05,$A9,$04
    .byte $4C,$1A,$E8,$A5,$2F,$65,$31,$69,$01,$9D,$78,$05,$A9,$60,$9D,$38
    .byte $05,$BD,$24,$03,$C9,$80,$A9,$00,$B0,$02,$A9,$80,$9D,$58,$03,$60
    .byte $A9,$B3,$20,$AD,$B9,$BD,$D8,$05,$D0,$7D,$BD,$C8,$05,$F0,$78,$BD
    .byte $B8,$05,$A8,$B9,$1A,$03,$C9,$20,$90,$6D,$BD,$3E,$03,$38,$F9,$34
    .byte $03,$C9,$30,$B0,$62,$BD,$24,$03,$D9,$1A,$03,$B0,$20,$A9,$02,$9D
    .byte $E8,$04,$A9,$40,$9D,$F8,$04,$A5,$2F,$20,$46,$B4,$7D,$F8,$04,$9D
    .byte $F8,$04,$BD,$E8,$04,$69,$00,$9D,$E8,$04,$4C,$EE,$BA,$BD,$3E,$03
    .byte $38,$F9,$34,$03,$C9,$20,$B0,$2F,$A9,$FF,$9D,$E8,$04,$A9,$00,$9D
    .byte $F8,$04,$A9,$B3,$9D,$0A,$03,$BD,$58,$03,$29,$3F,$9D,$58,$03,$BD
    .byte $E8,$04,$30,$0A,$A9,$FF,$9D,$08,$05,$A9,$80,$9D,$18,$05,$FE,$D8
    .byte $05,$FE,$B8,$04,$4C,$37,$E8,$A9,$B8,$DD,$24,$03,$90,$07,$A9,$38
    .byte $DD,$24,$03,$90,$03,$9D,$24,$03,$20,$37,$E8,$4C,$D0,$E8,$20,$31
    .byte $EC,$90,$12,$20,$D0,$E8,$A9,$FE,$9D,$08,$05,$A9,$80,$9D,$18,$05
    .byte $A9,$04,$9D,$B8,$04,$4C,$37,$E8,$A9,$33,$9D,$88,$05,$20,$6F,$BA
    .byte $A9,$B6,$9D,$0A,$03,$A9,$FF,$9D,$08,$05,$A9,$B0,$9D,$18,$05,$A9
    .byte $FC,$9D,$D8,$05,$A9,$00,$9D,$E8,$05,$4C,$8E,$E7,$BD,$E8,$05,$18
    .byte $69,$28,$9D,$E8,$05,$BD,$D8,$05,$69,$00,$9D,$D8,$05,$BD,$24,$03
    .byte $C9,$80,$90,$0F,$BD,$D8,$05,$9D,$E8,$04,$BD,$E8,$05,$9D,$F8,$04
    .byte $4C,$A0,$BB,$BD,$D8,$05,$49,$FF,$9D,$E8,$04,$A9,$00,$38,$FD,$E8
    .byte $05,$9D,$F8,$04,$20,$37,$E8,$BD,$24,$03,$C9,$C1,$B0,$05,$C9,$30
    .byte $90,$01,$60,$A9,$B3,$9D,$0A,$03,$4C,$3E,$BA,$C3,$BB,$F0,$BB,$6D
    .byte $BC,$4B,$E7,$B0,$E7,$06,$E8,$A5,$31,$0A,$85,$08,$A5,$2F,$0A,$65
    .byte $08,$69,$18,$9D,$78,$05,$A5,$34,$65,$1A,$29,$3F,$69,$A0,$9D,$38
    .byte $05,$A0,$A5,$BD,$24,$03,$C9,$80,$B0,$02,$A0,$A1,$98,$9D,$B8,$05
    .byte $FE,$B8,$04,$60,$20,$A7,$E8,$BD,$E8,$05,$D0,$62,$DE,$38,$05,$BD
    .byte $38,$05,$F0,$09,$C9,$30,$F0,$37,$C9,$10,$F0,$33,$60,$A5,$8E,$F0
    .byte $0C,$A9,$14,$20,$52,$EB,$D0,$05,$A9,$02,$99,$B8,$04,$A5,$AA,$05
    .byte $AB,$29,$07,$85,$08,$A9,$0A,$38,$E5,$08,$9D,$E8,$05,$A5,$1A,$65
    .byte $34,$29,$03,$7D,$E8,$05,$9D,$E8,$05,$A9,$14,$9D,$38,$05,$60,$FE
    .byte $B8,$05,$FE,$D8,$05,$BD,$D8,$05,$C9,$03,$90,$0C,$DE,$B8,$05,$DE
    .byte $B8,$05,$DE,$D8,$05,$DE,$D8,$05,$BD,$B8,$05,$4C,$B5,$EB,$DE,$38
    .byte $05,$D0,$DB,$A9,$14,$9D,$38,$05,$20,$3B,$BC,$DE,$E8,$05,$F0,$9D
    .byte $60,$A0,$A8,$BD,$24,$03,$C9,$80,$B0,$02,$A0,$A4,$98,$20,$B5,$EB
    .byte $90,$01,$60,$4C,$8E,$E7,$92,$BC,$9D,$BC,$B4,$BC,$4C,$BD,$B2,$B6
    .byte $EB,$BC,$F8,$BC,$02,$BD,$20,$61,$B4,$A9,$0A,$9D,$38,$05,$4C,$8E
    .byte $E7,$20,$A7,$E8,$DE,$38,$05,$F0,$01,$60,$FE,$C8,$05,$BD,$78,$05
    .byte $4A,$D0,$02,$A9,$01,$4C,$8B,$E7,$20,$A7,$E8,$BD,$C8,$05,$F0,$15
    .byte $FE,$E8,$05,$BD,$E8,$05,$29,$01,$0A,$18,$69,$03,$20,$86,$B5,$A5
    .byte $0B,$9D,$C8,$05,$60,$BD,$E8,$05,$29,$01,$0A,$18,$69,$04,$20,$86
    .byte $B5,$A5,$0B,$9D,$C8,$05,$F0,$01,$60,$A9,$02,$9D,$B8,$04,$60,$A9
    .byte $07,$20,$86,$B5,$A5,$0B,$F0,$01,$60,$4C,$8E,$E7,$A9,$08,$20,$86
    .byte $B5,$A5,$0B,$F0,$F4,$60,$A2,$0F,$BD,$28,$05,$C9,$14,$F0,$1E,$C9
    .byte $15,$F0,$16,$C9,$12,$F0,$12,$C9,$13,$F0,$19,$C9,$11,$F0,$0A,$CA
    .byte $D0,$E6,$A6,$83,$A9,$A0,$4C,$F6,$EA,$A9,$03,$D0,$02,$A9,$06,$9D
    .byte $B8,$04,$D0,$EB,$A9,$04,$D0,$F7,$10,$10,$F0,$10,$F0,$F0,$10,$F0
    .byte $20,$20,$E0,$20,$E0,$E0,$20,$E0,$40,$40,$C0,$40,$C0,$C0,$50,$00
    .byte $20,$83,$C1,$A9,$57,$20,$EA,$EA,$4C,$A0,$B6,$A0,$00,$F0,$02,$A9
    .byte $00,$18,$7D,$3E,$03,$85,$0A,$98,$18,$7D,$24,$03,$85,$09,$60
; --- espacio libre: 661 bytes ($BD6B-$BFFF) ---
.org $C000, $FF
