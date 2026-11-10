; ============================================================
; Contra (USA) - banco 1  ($8000-$BFFF)  [intercambiable]
; Generado por tools/disasm.py. Las etiquetas L_ son código, D_ son datos.
; ============================================================
.include "nes.inc"
; Las etiquetas del banco fijo (L_xxxx) son visibles desde aquí.
.base $8000

    .byte $01
D1_8001:
    .byte $DD
D1_8002:
    .byte $91,$E5,$91,$EA,$91,$F7,$91,$04,$92,$16,$92,$29,$92,$3C,$92,$DB
    .byte $A3,$E8,$A3,$EE,$A3,$F5,$A3,$02,$A4,$0F,$A4,$06,$A7,$5F,$AA,$6C
    .byte $AA,$73,$AA,$04,$AB,$11,$AB,$1E,$AB,$29,$AB,$78,$AA,$CA,$98,$D5
    .byte $98,$EA,$98,$F1,$98,$FD,$98,$04,$99,$09,$99,$15,$99,$1C,$99,$28
    .byte $99,$71,$9E,$7D,$9E,$43,$9C,$50,$9C,$59,$9C,$65,$9C,$64,$A0,$72
    .byte $A0,$80,$A0,$88,$A0,$84,$9E,$90,$9E,$9C,$9E,$13,$A7,$1B,$A7,$28
    .byte $A7,$D2,$AB,$DA,$AB,$EA,$AB,$EB,$AB,$85,$AA

L1_806D:
    lda #$30                    ; 806D  A9 30
    sta SQ1_VOL,x               ; 806F  9D 00 40
    jsr L1_8705                 ; 8072  20 05 87
    bne L1_808D                 ; 8075  D0 16

L1_8077:
    lda $0124,x                 ; 8077  BD 24 01
    and #$41                    ; 807A  29 41
    ora $012F                   ; 807C  0D 2F 01
    bne L1_806D                 ; 807F  D0 EC

L1_8081:
    lda $0160,x                 ; 8081  BD 60 01
    ora $014E,x                 ; 8084  1D 4E 01
    sta SQ1_VOL,y               ; 8087  99 00 40
    jsr L1_8705                 ; 808A  20 05 87

L1_808D:
    lda $0172,x                 ; 808D  BD 72 01
    sta SQ1_LO,y                ; 8090  99 02 40
    jsr L1_8705                 ; 8093  20 05 87
    lda $010C,x                 ; 8096  BD 0C 01
    sta SQ1_HI,y                ; 8099  99 03 40
    jmp L1_8705                 ; 809C  4C 05 87


L1_809F:
    lda $25                     ; 809F  A5 25
    cmp $012F                   ; 80A1  CD 2F 01
    beq L1_80D4                 ; 80A4  F0 2E
    sta $012F                   ; 80A6  8D 2F 01
    cmp #$00                    ; 80A9  C9 00
    beq L1_80B0                 ; 80AB  F0 03
    jmp L1_8751                 ; 80AD  4C 51 87


L1_80B0:
    lda $010A                   ; 80B0  AD 0A 01
    beq L1_80C8                 ; 80B3  F0 13
    lda $0128                   ; 80B5  AD 28 01
    bpl L1_80C0                 ; 80B8  10 06
    lda $012D                   ; 80BA  AD 2D 01
    sta SQ1_SWEEP               ; 80BD  8D 01 40

L1_80C0:
    ldx #$04                    ; 80C0  A2 04
    ldy #$00                    ; 80C2  A0 00
    jsr L1_8081                 ; 80C4  20 81 80
    rts                         ; 80C7  60


L1_80C8:
    lda $0106                   ; 80C8  AD 06 01
    beq L1_80D4                 ; 80CB  F0 07
    ldx #$00                    ; 80CD  A2 00
    ldy #$00                    ; 80CF  A0 00
    jsr L1_8077                 ; 80D1  20 77 80

L1_80D4:
    rts                         ; 80D4  60


L1_80D5:
    jsr L1_809F                 ; 80D5  20 9F 80
    ldx #$00                    ; 80D8  A2 00
    ldy #$00                    ; 80DA  A0 00

L1_80DC:
    stx $0120                   ; 80DC  8E 20 01
    sty $0123                   ; 80DF  8C 23 01
    lda $0106,x                 ; 80E2  BD 06 01
    beq L1_80EB                 ; 80E5  F0 04
    tay                         ; 80E7  A8
    jsr L1_8103                 ; 80E8  20 03 81

L1_80EB:
    inx                         ; 80EB  E8
    cpx #$06                    ; 80EC  E0 06
    beq L1_8102                 ; 80EE  F0 12
    cpx #$05                    ; 80F0  E0 05
    bne L1_80F9                 ; 80F2  D0 05
    lda #$0C                    ; 80F4  A9 0C
    jmp L1_80FE                 ; 80F6  4C FE 80


L1_80F9:
    txa                         ; 80F9  8A
    asl a                       ; 80FA  0A
    asl a                       ; 80FB  0A
    and #$0F                    ; 80FC  29 0F

L1_80FE:
    tay                         ; 80FE  A8
    jmp L1_80DC                 ; 80FF  4C DC 80


L1_8102:
    rts                         ; 8102  60


L1_8103:
    lda $012F                   ; 8103  AD 2F 01
    beq L1_810F                 ; 8106  F0 07
    lda $0106,x                 ; 8108  BD 06 01
    cmp #$54                    ; 810B  C9 54
    bne L1_8102                 ; 810D  D0 F3

L1_810F:
    jsr L1_861D                 ; 810F  20 1D 86
    lda $0124,x                 ; 8112  BD 24 01
    dec $0100,x                 ; 8115  DE 00 01
    bne L1_811D                 ; 8118  D0 03
    jmp L1_8259                 ; 811A  4C 59 82


L1_811D:
    and #$41                    ; 811D  29 41
    bne L1_818F                 ; 811F  D0 6E
    cpx #$02                    ; 8121  E0 02
    beq L1_818F                 ; 8123  F0 6A
    cpx #$03                    ; 8125  E0 03
    beq L1_818F                 ; 8127  F0 66
    cpx #$02                    ; 8129  E0 02
    bcs L1_8140                 ; 812B  B0 13
    lda $0178,x                 ; 812D  BD 78 01
    bmi L1_8140                 ; 8130  30 0E
    inc $017A,x                 ; 8132  FE 7A 01
    lda $017E,x                 ; 8135  BD 7E 01
    cmp $017A,x                 ; 8138  DD 7A 01
    bcs L1_8140                 ; 813B  B0 03
    jsr L1_81F5                 ; 813D  20 F5 81

L1_8140:
    lda $0124,x                 ; 8140  BD 24 01
    and #$20                    ; 8143  29 20
    bne L1_814C                 ; 8145  D0 05
    lda $011E,x                 ; 8147  BD 1E 01
    bmi L1_81BD                 ; 814A  30 71

L1_814C:
    lda $0124,x                 ; 814C  BD 24 01
    tay                         ; 814F  A8
    and #$04                    ; 8150  29 04
    bne L1_81A7                 ; 8152  D0 53

L1_8154:
    lda $011E,x                 ; 8154  BD 1E 01
    asl a                       ; 8157  0A
    tay                         ; 8158  A8
    lda D1_8001,y               ; 8159  B9 01 80
    sta $E4                     ; 815C  85 E4
    lda D1_8002,y               ; 815E  B9 02 80
    sta $E5                     ; 8161  85 E5

L1_8163:
    lda $012A,x                 ; 8163  BD 2A 01
    tay                         ; 8166  A8
    lda ($E4),y                 ; 8167  B1 E4
    cmp #$FE                    ; 8169  C9 FE
    bcs L1_8190                 ; 816B  B0 23
    inc $012A,x                 ; 816D  FE 2A 01
    and #$1F                    ; 8170  29 1F

L1_8172:
    sta $0160,x                 ; 8172  9D 60 01

L1_8175:
    cmp #$02                    ; 8175  C9 02
    bcc L1_8181                 ; 8177  90 08
    sec                         ; 8179  38
    sbc $013C                   ; 817A  ED 3C 01
    bpl L1_8181                 ; 817D  10 02
    lda #$00                    ; 817F  A9 00

L1_8181:
    ora $014E,x                 ; 8181  1D 4E 01
    jsr L1_8637                 ; 8184  20 37 86
    bcs L1_818C                 ; 8187  B0 03
    sta SQ1_VOL,x               ; 8189  9D 00 40

L1_818C:
    ldx $0120                   ; 818C  AE 20 01

L1_818F:
    rts                         ; 818F  60


L1_8190:
    bne L1_819E                 ; 8190  D0 0C
    iny                         ; 8192  C8
    lda ($E4),y                 ; 8193  B1 E4
    sta $012A,x                 ; 8195  9D 2A 01
    jsr L1_81AC                 ; 8198  20 AC 81
    jmp L1_8163                 ; 819B  4C 63 81


L1_819E:
    lda $0124,x                 ; 819E  BD 24 01
    ora #$04                    ; 81A1  09 04
    sta $0124,x                 ; 81A3  9D 24 01
    rts                         ; 81A6  60


L1_81A7:
    tya                         ; 81A7  98
    and #$02                    ; 81A8  29 02
    bne L1_81D8                 ; 81AA  D0 2C

L1_81AC:
    lda $0100,x                 ; 81AC  BD 00 01
    cmp $0130,x                 ; 81AF  DD 30 01
    bcs L1_81BC                 ; 81B2  B0 08
    lda $0124,x                 ; 81B4  BD 24 01
    ora #$06                    ; 81B7  09 06
    sta $0124,x                 ; 81B9  9D 24 01

L1_81BC:
    rts                         ; 81BC  60


L1_81BD:
    dec $012A,x                 ; 81BD  DE 2A 01
    bmi L1_81CD                 ; 81C0  30 0B
    dec $0160,x                 ; 81C2  DE 60 01
    bmi L1_81E3                 ; 81C5  30 1C
    lda $0160,x                 ; 81C7  BD 60 01
    jmp L1_8175                 ; 81CA  4C 75 81


L1_81CD:
    lda $0124,x                 ; 81CD  BD 24 01
    ora #$20                    ; 81D0  09 20
    sta $0124,x                 ; 81D2  9D 24 01
    jmp L1_819E                 ; 81D5  4C 9E 81


L1_81D8:
    dec $0160,x                 ; 81D8  DE 60 01
    beq L1_81E3                 ; 81DB  F0 06
    lda $0160,x                 ; 81DD  BD 60 01
    jmp L1_8175                 ; 81E0  4C 75 81


L1_81E3:
    inc $0160,x                 ; 81E3  FE 60 01
    rts                         ; 81E6  60


L1_81E7:
    lda ($E0),y                 ; 81E7  B1 E0
    cmp #$FD                    ; 81E9  C9 FD
    bcc L1_81F2                 ; 81EB  90 05
    and #$0F                    ; 81ED  29 0F
    jmp L1_84A2                 ; 81EF  4C A2 84


L1_81F2:
    jmp L1_82D5                 ; 81F2  4C D5 82


L1_81F5:
    tya                         ; 81F5  98
    pha                         ; 81F6  48
    ldy $0123                   ; 81F7  AC 23 01
    sec                         ; 81FA  38
    sbc $017E,x                 ; 81FB  FD 7E 01
    sta $E4                     ; 81FE  85 E4
    lda $0180,x                 ; 8200  BD 80 01
    and #$F0                    ; 8203  29 F0
    lsr a                       ; 8205  4A
    lsr a                       ; 8206  4A
    lsr a                       ; 8207  4A
    lsr a                       ; 8208  4A
    cmp $E4                     ; 8209  C5 E4
    bne L1_8222                 ; 820B  D0 15
    lda $017E,x                 ; 820D  BD 7E 01
    sta $017A,x                 ; 8210  9D 7A 01
    inc $0178,x                 ; 8213  FE 78 01
    lda $0178,x                 ; 8216  BD 78 01
    cmp #$04                    ; 8219  C9 04
    bcc L1_8222                 ; 821B  90 05
    lda #$00                    ; 821D  A9 00
    sta $0178,x                 ; 821F  9D 78 01

L1_8222:
    lda $0178,x                 ; 8222  BD 78 01
    and #$01                    ; 8225  29 01
    bne L1_8235                 ; 8227  D0 0C
    lda $017C,x                 ; 8229  BD 7C 01

L1_822C:
    sta SQ1_LO,y                ; 822C  99 02 40
    jsr L1_8705                 ; 822F  20 05 87
    pla                         ; 8232  68
    tay                         ; 8233  A8
    rts                         ; 8234  60


L1_8235:
    lda $0180,x                 ; 8235  BD 80 01
    and #$0F                    ; 8238  29 0F
    sta $E4                     ; 823A  85 E4
    lda $0178,x                 ; 823C  BD 78 01
    and #$02                    ; 823F  29 02
    bne L1_8250                 ; 8241  D0 0D
    lda $E4                     ; 8243  A5 E4
    clc                         ; 8245  18
    adc $017C,x                 ; 8246  7D 7C 01
    bcc L1_822C                 ; 8249  90 E1
    lda #$FF                    ; 824B  A9 FF
    jmp L1_822C                 ; 824D  4C 2C 82


L1_8250:
    lda $017C,x                 ; 8250  BD 7C 01
    sec                         ; 8253  38
    sbc $E4                     ; 8254  E5 E4
    jmp L1_822C                 ; 8256  4C 2C 82


L1_8259:
    lsr a                       ; 8259  4A
    bcs L1_81E7                 ; 825A  B0 8B

L1_825C:
    lda $0120                   ; 825C  AD 20 01
    cmp #$03                    ; 825F  C9 03
    beq L1_8288                 ; 8261  F0 25
    lda ($E0),y                 ; 8263  B1 E0
    and #$F0                    ; 8265  29 F0
    cmp #$C0                    ; 8267  C9 C0
    bcs L1_826E                 ; 8269  B0 03
    jmp L1_8395                 ; 826B  4C 95 83


L1_826E:
    and #$30                    ; 826E  29 30
    lsr a                       ; 8270  4A
    lsr a                       ; 8271  4A
    lsr a                       ; 8272  4A
    tax                         ; 8273  AA
    lda D1_86CD,x               ; 8274  BD CD 86
    sta $E4                     ; 8277  85 E4
    lda D1_86CD+1,x             ; 8279  BD CE 86
    sta $E5                     ; 827C  85 E5
    ldx $0120                   ; 827E  AE 20 01
    lda ($E0),y                 ; 8281  B1 E0
    and #$0F                    ; 8283  29 0F
    jmp ($00E4)                 ; 8285  6C E4 00


L1_8288:
    lda ($E0),y                 ; 8288  B1 E0
    and #$F0                    ; 828A  29 F0
    cmp #$F0                    ; 828C  C9 F0
    bne L1_8297                 ; 828E  D0 07
    lda ($E0),y                 ; 8290  B1 E0
    and #$0F                    ; 8292  29 0F
    jmp L1_84A2                 ; 8294  4C A2 84


L1_8297:
    cmp #$D0                    ; 8297  C9 D0
    beq L1_829E                 ; 8299  F0 03
    jmp L1_85B7                 ; 829B  4C B7 85


L1_829E:
    lda ($E0),y                 ; 829E  B1 E0
    and #$0F                    ; 82A0  29 0F
    sta $0154,x                 ; 82A2  9D 54 01
    iny                         ; 82A5  C8
    jmp L1_8288                 ; 82A6  4C 88 82


L1_82A9:
    lda ($E0),y                 ; 82A9  B1 E0
    lsr a                       ; 82AB  4A
    lsr a                       ; 82AC  4A
    lsr a                       ; 82AD  4A
    lsr a                       ; 82AE  4A
    cmp #$0C                    ; 82AF  C9 0C
    beq L1_82C9                 ; 82B1  F0 16
    tax                         ; 82B3  AA
    sta $0121                   ; 82B4  8D 21 01
    lda D1_82CD,x               ; 82B7  BD CD 82
    jsr L_C16B                  ; 82BA  20 6B C1
    lda $0121                   ; 82BD  AD 21 01
    cmp #$03                    ; 82C0  C9 03
    bcc L1_82C9                 ; 82C2  90 05
    lda #$02                    ; 82C4  A9 02
    jsr L_C16B                  ; 82C6  20 6B C1

L1_82C9:
    ldx $0120                   ; 82C9  AE 20 01
    rts                         ; 82CC  60

D1_82CD:
    .byte $02,$5A,$5B,$5A,$5B,$25,$5C,$5D

L1_82D5:
    and #$F0                    ; 82D5  29 F0
    cmp #$20                    ; 82D7  C9 20
    bne L1_82F3                 ; 82D9  D0 18
    lda ($E0),y                 ; 82DB  B1 E0
    and #$0F                    ; 82DD  29 0F
    bne L1_82E4                 ; 82DF  D0 03
    iny                         ; 82E1  C8
    lda ($E0),y                 ; 82E2  B1 E0

L1_82E4:
    sta $0154,x                 ; 82E4  9D 54 01
    iny                         ; 82E7  C8
    lda ($E0),y                 ; 82E8  B1 E0
    sta $014E,x                 ; 82EA  9D 4E 01
    iny                         ; 82ED  C8
    beq L1_82F3                 ; 82EE  F0 03
    jmp L1_81E7                 ; 82F0  4C E7 81


L1_82F3:
    cmp #$10                    ; 82F3  C9 10
    bne L1_8339                 ; 82F5  D0 42
    lda ($E0),y                 ; 82F7  B1 E0
    iny                         ; 82F9  C8
    cmp #$10                    ; 82FA  C9 10
    bne L1_832E                 ; 82FC  D0 30
    lda ($E0),y                 ; 82FE  B1 E0
    bne L1_830E                 ; 8300  D0 0C
    lda $0124,x                 ; 8302  BD 24 01
    and #$7F                    ; 8305  29 7F
    sta $0124,x                 ; 8307  9D 24 01
    lda #$7F                    ; 830A  A9 7F
    bne L1_8318                 ; 830C  D0 0A

L1_830E:
    lda $0124,x                 ; 830E  BD 24 01
    ora #$80                    ; 8311  09 80
    sta $0124,x                 ; 8313  9D 24 01
    lda ($E0),y                 ; 8316  B1 E0

L1_8318:
    cpx #$04                    ; 8318  E0 04
    bne L1_831F                 ; 831A  D0 03
    sta $012D                   ; 831C  8D 2D 01

L1_831F:
    jsr L1_8637                 ; 831F  20 37 86
    bcs L1_8327                 ; 8322  B0 03
    sta SQ1_SWEEP,x             ; 8324  9D 01 40

L1_8327:
    ldx $0120                   ; 8327  AE 20 01
    iny                         ; 832A  C8
    jmp L1_81E7                 ; 832B  4C E7 81


L1_832E:
    lda $0124,x                 ; 832E  BD 24 01
    ora #$10                    ; 8331  09 10
    sta $0124,x                 ; 8333  9D 24 01
    jmp L1_81E7                 ; 8336  4C E7 81


L1_8339:
    lda $0154,x                 ; 8339  BD 54 01
    sta $0100,x                 ; 833C  9D 00 01
    lda ($E0),y                 ; 833F  B1 E0
    cmp #$F8                    ; 8341  C9 F8
    bne L1_8348                 ; 8343  D0 03
    iny                         ; 8345  C8
    lda ($E0),y                 ; 8346  B1 E0

L1_8348:
    lsr a                       ; 8348  4A
    lsr a                       ; 8349  4A
    lsr a                       ; 834A  4A
    lsr a                       ; 834B  4A
    sta $0142,x                 ; 834C  9D 42 01
    lda $014E,x                 ; 834F  BD 4E 01
    and #$10                    ; 8352  29 10
    beq L1_8375                 ; 8354  F0 1F
    lda $0142,x                 ; 8356  BD 42 01
    ora $014E,x                 ; 8359  1D 4E 01

L1_835C:
    jsr L1_8637                 ; 835C  20 37 86
    bcs L1_8364                 ; 835F  B0 03
    sta SQ1_VOL,x               ; 8361  9D 00 40

L1_8364:
    ldx $0120                   ; 8364  AE 20 01
    lda ($E0),y                 ; 8367  B1 E0
    and #$0F                    ; 8369  29 0F
    sta $EF                     ; 836B  85 EF
    iny                         ; 836D  C8
    lda ($E0),y                 ; 836E  B1 E0
    sta $EE                     ; 8370  85 EE
    jmp L1_8409                 ; 8372  4C 09 84


L1_8375:
    lda $014E,x                 ; 8375  BD 4E 01
    jmp L1_835C                 ; 8378  4C 5C 83


L1_837B:
    lda $0144                   ; 837B  AD 44 01
    sta TRI_LINEAR              ; 837E  8D 08 40
    jmp L1_83AD                 ; 8381  4C AD 83


L1_8384:
    lda $0142,x                 ; 8384  BD 42 01
    jsr L1_8172                 ; 8387  20 72 81
    lda $011E,x                 ; 838A  BD 1E 01
    and #$0F                    ; 838D  29 0F
    sta $012A,x                 ; 838F  9D 2A 01
    jmp L1_83AD                 ; 8392  4C AD 83


L1_8395:
    jsr L1_85B7                 ; 8395  20 B7 85
    cpx #$02                    ; 8398  E0 02
    beq L1_837B                 ; 839A  F0 DF
    lda $011E,x                 ; 839C  BD 1E 01
    bmi L1_8384                 ; 839F  30 E3
    lda #$00                    ; 83A1  A9 00
    sta $012A,x                 ; 83A3  9D 2A 01
    sty $E6                     ; 83A6  84 E6
    jsr L1_8154                 ; 83A8  20 54 81
    ldy $E6                     ; 83AB  A4 E6

L1_83AD:
    lda $0124,x                 ; 83AD  BD 24 01
    and #$99                    ; 83B0  29 99
    sta $0124,x                 ; 83B2  9D 24 01
    lda ($E0),y                 ; 83B5  B1 E0
    and #$F0                    ; 83B7  29 F0
    lsr a                       ; 83B9  4A
    lsr a                       ; 83BA  4A
    lsr a                       ; 83BB  4A
    tax                         ; 83BC  AA
    tya                         ; 83BD  98
    pha                         ; 83BE  48
    ldy $0120                   ; 83BF  AC 20 01
    lda $0132,y                 ; 83C2  B9 32 01
    beq L1_83CD                 ; 83C5  F0 06
    txa                         ; 83C7  8A
    clc                         ; 83C8  18
    adc $0132,y                 ; 83C9  79 32 01
    tax                         ; 83CC  AA

L1_83CD:
    pla                         ; 83CD  68
    tay                         ; 83CE  A8
    lda D1_86D5,x               ; 83CF  BD D5 86
    sta $EE                     ; 83D2  85 EE
    lda D1_86D6,x               ; 83D4  BD D6 86
    sta $EF                     ; 83D7  85 EF
    ldx $0120                   ; 83D9  AE 20 01
    lda $015A,x                 ; 83DC  BD 5A 01
    tax                         ; 83DF  AA

L1_83E0:
    cpx #$04                    ; 83E0  E0 04
    beq L1_83EB                 ; 83E2  F0 07
    lsr $EF                     ; 83E4  46 EF
    ror $EE                     ; 83E6  66 EE
    inx                         ; 83E8  E8
    bne L1_83E0                 ; 83E9  D0 F5

L1_83EB:
    ldx $0120                   ; 83EB  AE 20 01
    cpx #$02                    ; 83EE  E0 02
    bcs L1_8409                 ; 83F0  B0 17
    lda $0178,x                 ; 83F2  BD 78 01
    bmi L1_8409                 ; 83F5  30 12
    lda $EE                     ; 83F7  A5 EE
    sta $017C,x                 ; 83F9  9D 7C 01
    lda $0124,x                 ; 83FC  BD 24 01
    and #$10                    ; 83FF  29 10
    beq L1_8406                 ; 8401  F0 03
    inc $017C,x                 ; 8403  FE 7C 01

L1_8406:
    ldx $0120                   ; 8406  AE 20 01

L1_8409:
    lda $0124,x                 ; 8409  BD 24 01
    and #$10                    ; 840C  29 10
    beq L1_8416                 ; 840E  F0 06
    inc $EE                     ; 8410  E6 EE
    bne L1_8416                 ; 8412  D0 02
    inc $EF                     ; 8414  E6 EF

L1_8416:
    lda $EF                     ; 8416  A5 EF
    cpx #$02                    ; 8418  E0 02
    beq L1_8433                 ; 841A  F0 17
    cpx #$05                    ; 841C  E0 05
    beq L1_8431                 ; 841E  F0 11
    cmp $010C,x                 ; 8420  DD 0C 01
    bne L1_8433                 ; 8423  D0 0E
    lda $0124,x                 ; 8425  BD 24 01
    bmi L1_8431                 ; 8428  30 07
    lda $014E,x                 ; 842A  BD 4E 01
    and #$10                    ; 842D  29 10
    bne L1_8440                 ; 842F  D0 0F

L1_8431:
    lda $EF                     ; 8431  A5 EF

L1_8433:
    sta $010C,x                 ; 8433  9D 0C 01
    ora #$08                    ; 8436  09 08
    jsr L1_8637                 ; 8438  20 37 86
    bcs L1_8440                 ; 843B  B0 03
    sta SQ1_HI,x                ; 843D  9D 03 40

L1_8440:
    lda $EE                     ; 8440  A5 EE
    ldx $0120                   ; 8442  AE 20 01
    cpx #$02                    ; 8445  E0 02
    bcs L1_844C                 ; 8447  B0 03
    sta $0172,x                 ; 8449  9D 72 01

L1_844C:
    jsr L1_8637                 ; 844C  20 37 86
    bcs L1_8454                 ; 844F  B0 03
    sta SQ1_LO,x                ; 8451  9D 02 40

L1_8454:
    ldx $0120                   ; 8454  AE 20 01

L1_8457:
    iny                         ; 8457  C8
    tya                         ; 8458  98
    clc                         ; 8459  18
    adc $E0                     ; 845A  65 E0
    sta $0112,x                 ; 845C  9D 12 01
    lda #$00                    ; 845F  A9 00
    adc $E1                     ; 8461  65 E1
    sta $0118,x                 ; 8463  9D 18 01
    rts                         ; 8466  60


L1_8467:
    lda $0166,x                 ; 8467  BD 66 01
    sta $E0                     ; 846A  85 E0
    lda $016C,x                 ; 846C  BD 6C 01
    sta $E1                     ; 846F  85 E1
    lda $0124,x                 ; 8471  BD 24 01
    and #$F7                    ; 8474  29 F7
    sta $0124,x                 ; 8476  9D 24 01
    ldy #$00                    ; 8479  A0 00
    jmp L1_84DC                 ; 847B  4C DC 84


L1_847E:
    lda $0124,x                 ; 847E  BD 24 01
    and #$08                    ; 8481  29 08
    bne L1_8467                 ; 8483  D0 E2
    lda $0106,x                 ; 8485  BD 06 01
    sta $E6                     ; 8488  85 E6
    lda #$00                    ; 848A  A9 00

L1_848C:
    sta $0106,x                 ; 848C  9D 06 01
    txa                         ; 848F  8A
    asl a                       ; 8490  0A
    tax                         ; 8491  AA
    lda D1_86BF,x               ; 8492  BD BF 86
    sta $E4                     ; 8495  85 E4
    lda D1_86BF+1,x             ; 8497  BD C0 86
    sta $E5                     ; 849A  85 E5
    ldx $0120                   ; 849C  AE 20 01
    jmp ($00E4)                 ; 849F  6C E4 00


L1_84A2:
    cmp #$0E                    ; 84A2  C9 0E
    beq L1_84C6                 ; 84A4  F0 20
    bcs L1_847E                 ; 84A6  B0 D6
    jsr L1_862A                 ; 84A8  20 2A 86
    iny                         ; 84AB  C8
    tya                         ; 84AC  98
    clc                         ; 84AD  18
    adc $E0                     ; 84AE  65 E0
    sta $0166,x                 ; 84B0  9D 66 01
    lda #$00                    ; 84B3  A9 00
    tay                         ; 84B5  A8
    adc $E1                     ; 84B6  65 E1
    sta $016C,x                 ; 84B8  9D 6C 01
    lda $0124,x                 ; 84BB  BD 24 01
    ora #$08                    ; 84BE  09 08
    sta $0124,x                 ; 84C0  9D 24 01
    jmp L1_84D9                 ; 84C3  4C D9 84


L1_84C6:
    inc $0148,x                 ; 84C6  FE 48 01
    lda $0148,x                 ; 84C9  BD 48 01
    iny                         ; 84CC  C8
    cmp ($E0),y                 ; 84CD  D1 E0
    beq L1_84E8                 ; 84CF  F0 17
    bmi L1_84D6                 ; 84D1  30 03
    dec $0148,x                 ; 84D3  DE 48 01

L1_84D6:
    jsr L1_862A                 ; 84D6  20 2A 86

L1_84D9:
    jsr L1_861D                 ; 84D9  20 1D 86

L1_84DC:
    lda $0124,x                 ; 84DC  BD 24 01
    lsr a                       ; 84DF  4A
    bcs L1_84E5                 ; 84E0  B0 03
    jmp L1_825C                 ; 84E2  4C 5C 82


L1_84E5:
    jmp L1_81E7                 ; 84E5  4C E7 81


L1_84E8:
    lda #$00                    ; 84E8  A9 00
    sta $0148,x                 ; 84EA  9D 48 01
    iny                         ; 84ED  C8
    iny                         ; 84EE  C8
    iny                         ; 84EF  C8
    tya                         ; 84F0  98
    clc                         ; 84F1  18
    adc $E0                     ; 84F2  65 E0
    sta $E0                     ; 84F4  85 E0
    lda #$00                    ; 84F6  A9 00
    tay                         ; 84F8  A8
    adc $E1                     ; 84F9  65 E1
    sta $E1                     ; 84FB  85 E1
    jmp L1_84DC                 ; 84FD  4C DC 84


L1_8500:
    jsr L1_85BB                 ; 8500  20 BB 85
    lda #$00                    ; 8503  A9 00
    cpx #$02                    ; 8505  E0 02
    beq L1_850C                 ; 8507  F0 03
    lda $014E,x                 ; 8509  BD 4E 01

L1_850C:
    jsr L1_8637                 ; 850C  20 37 86
    bcs L1_8514                 ; 850F  B0 03
    sta SQ1_VOL,x               ; 8511  9D 00 40

L1_8514:
    ldx $0120                   ; 8514  AE 20 01
    lda $0124,x                 ; 8517  BD 24 01
    ora #$40                    ; 851A  09 40
    sta $0124,x                 ; 851C  9D 24 01
    jmp L1_8457                 ; 851F  4C 57 84


L1_8522:
    sta $0154,x                 ; 8522  9D 54 01
    iny                         ; 8525  C8
    lda ($E0),y                 ; 8526  B1 E0
    cpx #$02                    ; 8528  E0 02
    beq L1_8555                 ; 852A  F0 29
    and #$0F                    ; 852C  29 0F
    sec                         ; 852E  38
    sbc $013C                   ; 852F  ED 3C 01
    bpl L1_8539                 ; 8532  10 05
    lda #$00                    ; 8534  A9 00
    jmp L1_848C                 ; 8536  4C 8C 84


L1_8539:
    sta $0142,x                 ; 8539  9D 42 01
    lda ($E0),y                 ; 853C  B1 E0
    and #$F0                    ; 853E  29 F0
    sta $014E,x                 ; 8540  9D 4E 01
    iny                         ; 8543  C8
    lda ($E0),y                 ; 8544  B1 E0
    sta $011E,x                 ; 8546  9D 1E 01
    iny                         ; 8549  C8
    lda ($E0),y                 ; 854A  B1 E0
    and #$0F                    ; 854C  29 0F
    sta $0136,x                 ; 854E  9D 36 01
    iny                         ; 8551  C8
    jmp L1_825C                 ; 8552  4C 5C 82


L1_8555:
    sta $0144                   ; 8555  8D 44 01
    iny                         ; 8558  C8
    jmp L1_825C                 ; 8559  4C 5C 82


L1_855C:
    cmp #$05                    ; 855C  C9 05
    bcs L1_8567                 ; 855E  B0 07
    sta $015A,x                 ; 8560  9D 5A 01
    iny                         ; 8563  C8
    jmp L1_825C                 ; 8564  4C 5C 82


L1_8567:
    cmp #$08                    ; 8567  C9 08
    beq L1_8577                 ; 8569  F0 0C
    cmp #$0B                    ; 856B  C9 0B
    beq L1_8583                 ; 856D  F0 14
    cmp #$0C                    ; 856F  C9 0C
    beq L1_85A5                 ; 8571  F0 32
    iny                         ; 8573  C8
    jmp L1_825C                 ; 8574  4C 5C 82


L1_8577:
    lda $0124,x                 ; 8577  BD 24 01
    eor #$10                    ; 857A  49 10
    sta $0124,x                 ; 857C  9D 24 01
    iny                         ; 857F  C8
    jmp L1_825C                 ; 8580  4C 5C 82


L1_8583:
    iny                         ; 8583  C8
    lda ($E0),y                 ; 8584  B1 E0
    sta $017E,x                 ; 8586  9D 7E 01
    cmp #$FF                    ; 8589  C9 FF
    beq L1_859C                 ; 858B  F0 0F
    iny                         ; 858D  C8
    lda ($E0),y                 ; 858E  B1 E0
    sta $0180,x                 ; 8590  9D 80 01
    lda #$00                    ; 8593  A9 00
    sta $0178,x                 ; 8595  9D 78 01
    iny                         ; 8598  C8
    jmp L1_825C                 ; 8599  4C 5C 82


L1_859C:
    lda #$80                    ; 859C  A9 80
    sta $0178,x                 ; 859E  9D 78 01
    iny                         ; 85A1  C8
    jmp L1_825C                 ; 85A2  4C 5C 82


L1_85A5:
    iny                         ; 85A5  C8
    lda ($E0),y                 ; 85A6  B1 E0
    asl a                       ; 85A8  0A
    sta $0132,x                 ; 85A9  9D 32 01
    iny                         ; 85AC  C8
    jmp L1_825C                 ; 85AD  4C 5C 82


L1_85B0:
    jsr L1_8457                 ; 85B0  20 57 84
    dey                         ; 85B3  88
    jmp L1_82A9                 ; 85B4  4C A9 82


L1_85B7:
    lda ($E0),y                 ; 85B7  B1 E0
    and #$0F                    ; 85B9  29 0F

L1_85BB:
    sta $E4                     ; 85BB  85 E4
    beq L1_85CC                 ; 85BD  F0 0D
    lda $0154,x                 ; 85BF  BD 54 01

L1_85C2:
    clc                         ; 85C2  18
    adc $0154,x                 ; 85C3  7D 54 01
    dec $E4                     ; 85C6  C6 E4
    bne L1_85C2                 ; 85C8  D0 F8
    beq L1_85CF                 ; 85CA  F0 03

L1_85CC:
    lda $0154,x                 ; 85CC  BD 54 01

L1_85CF:
    sta $0100,x                 ; 85CF  9D 00 01
    cpx #$02                    ; 85D2  E0 02
    bcs L1_85E0                 ; 85D4  B0 0A
    lda $0178,x                 ; 85D6  BD 78 01
    bmi L1_85E0                 ; 85D9  30 05
    lda #$00                    ; 85DB  A9 00
    sta $017A,x                 ; 85DD  9D 7A 01

L1_85E0:
    cpx #$02                    ; 85E0  E0 02
    beq L1_85F1                 ; 85E2  F0 0D
    cpx #$03                    ; 85E4  E0 03
    beq L1_85B0                 ; 85E6  F0 C8
    lda $0136,x                 ; 85E8  BD 36 01
    jsr L1_85F2                 ; 85EB  20 F2 85
    sta $0130,x                 ; 85EE  9D 30 01

L1_85F1:
    rts                         ; 85F1  60


L1_85F2:
    and #$0F                    ; 85F2  29 0F
    sta $E4                     ; 85F4  85 E4
    lda #$00                    ; 85F6  A9 00
    sta $E6                     ; 85F8  85 E6
    sta $E7                     ; 85FA  85 E7

L1_85FC:
    dec $E4                     ; 85FC  C6 E4
    bmi L1_860E                 ; 85FE  30 0E
    clc                         ; 8600  18
    lda $0100,x                 ; 8601  BD 00 01
    adc $E6                     ; 8604  65 E6
    sta $E6                     ; 8606  85 E6
    bcc L1_85FC                 ; 8608  90 F2
    inc $E7                     ; 860A  E6 E7
    bne L1_85FC                 ; 860C  D0 EE

L1_860E:
    asl a                       ; 860E  0A
    rol $E7                     ; 860F  26 E7
    asl a                       ; 8611  0A
    rol $E7                     ; 8612  26 E7
    asl a                       ; 8614  0A
    rol $E7                     ; 8615  26 E7
    asl a                       ; 8617  0A
    rol $E7                     ; 8618  26 E7
    lda $E7                     ; 861A  A5 E7
    rts                         ; 861C  60


L1_861D:
    ldy #$00                    ; 861D  A0 00
    lda $0112,x                 ; 861F  BD 12 01
    sta $E0                     ; 8622  85 E0
    lda $0118,x                 ; 8624  BD 18 01
    sta $E1                     ; 8627  85 E1
    rts                         ; 8629  60


L1_862A:
    iny                         ; 862A  C8
    lda ($E0),y                 ; 862B  B1 E0
    sta $0112,x                 ; 862D  9D 12 01
    iny                         ; 8630  C8
    lda ($E0),y                 ; 8631  B1 E0
    sta $0118,x                 ; 8633  9D 18 01
    rts                         ; 8636  60


L1_8637:
    pha                         ; 8637  48
    cpx #$01                    ; 8638  E0 01
    bcc L1_8642                 ; 863A  90 06

L1_863C:
    clc                         ; 863C  18
    ldx $0123                   ; 863D  AE 23 01
    pla                         ; 8640  68
    rts                         ; 8641  60


L1_8642:
    inx                         ; 8642  E8
    inx                         ; 8643  E8
    inx                         ; 8644  E8
    inx                         ; 8645  E8
    lda $0106,x                 ; 8646  BD 06 01
    beq L1_863C                 ; 8649  F0 F1
    ldx $0120                   ; 864B  AE 20 01
    sec                         ; 864E  38
    pla                         ; 864F  68

L1_8650:
    rts                         ; 8650  60


L1_8651:
    lda #$30                    ; 8651  A9 30
    jsr L1_8637                 ; 8653  20 37 86
    bcs L1_865B                 ; 8656  B0 03
    sta SQ1_VOL,x               ; 8658  9D 00 40

L1_865B:
    ldx $0120                   ; 865B  AE 20 01
    cpx #$01                    ; 865E  E0 01
    bne L1_8650                 ; 8660  D0 EE
    lda $E6                     ; 8662  A5 E6
    cmp #$57                    ; 8664  C9 57
    bne L1_8650                 ; 8666  D0 E8
    lda $0194                   ; 8668  AD 94 01
    beq L1_8650                 ; 866B  F0 E3
    lda #$46                    ; 866D  A9 46
    jsr L_C16B                  ; 866F  20 6B C1
    rts                         ; 8672  60


L1_8673:
    lda #$0B                    ; 8673  A9 0B
    sta SND_CHN                 ; 8675  8D 15 40
    lda #$00                    ; 8678  A9 00
    sta TRI_LINEAR              ; 867A  8D 08 40
    lda #$0F                    ; 867D  A9 0F
    sta SND_CHN                 ; 867F  8D 15 40
    rts                         ; 8682  60


L1_8683:
    ldx $0123                   ; 8683  AE 23 01
    lda #$30                    ; 8686  A9 30
    sta SQ1_VOL,x               ; 8688  9D 00 40
    jsr L1_8705                 ; 868B  20 05 87
    lda #$7F                    ; 868E  A9 7F
    sta SQ1_SWEEP,x             ; 8690  9D 01 40
    txa                         ; 8693  8A
    lsr a                       ; 8694  4A
    lsr a                       ; 8695  4A
    tax                         ; 8696  AA
    lda $0106,x                 ; 8697  BD 06 01
    beq L1_86B7                 ; 869A  F0 1B
    ldy $0123                   ; 869C  AC 23 01
    jsr L1_8077                 ; 869F  20 77 80
    ldx $0120                   ; 86A2  AE 20 01
    rts                         ; 86A5  60


L1_86A6:
    lda #$30                    ; 86A6  A9 30
    sta NOISE_VOL               ; 86A8  8D 0C 40
    lda $E6                     ; 86AB  A5 E6
    cmp #$4A                    ; 86AD  C9 4A
    bne L1_8650                 ; 86AF  D0 9F
    lda #$4E                    ; 86B1  A9 4E
    jsr L_C16B                  ; 86B3  20 6B C1
    rts                         ; 86B6  60


L1_86B7:
    ldx $0120                   ; 86B7  AE 20 01
    lda $E6                     ; 86BA  A5 E6
    jmp L1_8650                 ; 86BC  4C 50 86

D1_86BF:
    .word L1_8651                   ; 86BF
    .word L1_8651                   ; 86C1
    .word L1_8673                   ; 86C3
    .word L1_86A6                   ; 86C5
    .word L1_8683                   ; 86C7
    .word L1_86A6                   ; 86C9
    .word L1_8651                   ; 86CB
D1_86CD:
    .word L1_8500                   ; 86CD
    .word L1_8522                   ; 86CF
    .word L1_855C                   ; 86D1
    .word L1_84A2                   ; 86D3
D1_86D5:
    .byte $AE
D1_86D6:
    .byte $06,$4E,$06,$F4,$05,$9E,$05,$4E,$05,$01,$05,$B9,$04,$76,$04,$36
    .byte $04,$F9,$03,$C0,$03,$8A,$03,$57,$03,$27,$03,$FA,$02,$CF,$02,$A7
    .byte $02,$81,$02,$5D,$02,$3B,$02,$1B,$02,$FD,$01,$E0,$01,$C5,$01

L1_8705:
    nop                         ; 8705  EA
    nop                         ; 8706  EA
    nop                         ; 8707  EA
    nop                         ; 8708  EA
    nop                         ; 8709  EA
    nop                         ; 870A  EA
    nop                         ; 870B  EA
    nop                         ; 870C  EA
    nop                         ; 870D  EA
    nop                         ; 870E  EA
    rts                         ; 870F  60

D1_8710:
    .byte $E8
D1_8711:
    .byte $88

L1_8712:
    txa                         ; 8712  8A
    pha                         ; 8713  48
    tya                         ; 8714  98
    pha                         ; 8715  48
    lda #$00                    ; 8716  A9 00
    tax                         ; 8718  AA

L1_8719:
    sta $0106,x                 ; 8719  9D 06 01
    inx                         ; 871C  E8
    cpx #$06                    ; 871D  E0 06
    bcc L1_8719                 ; 871F  90 F8
    sta $0140                   ; 8721  8D 40 01
    sta $013E                   ; 8724  8D 3E 01
    sta $013C                   ; 8727  8D 3C 01
    jsr L1_8673                 ; 872A  20 73 86
    lda #$30                    ; 872D  A9 30
    sta SQ1_VOL                 ; 872F  8D 00 40
    jsr L1_8705                 ; 8732  20 05 87
    sta SQ2_VOL                 ; 8735  8D 04 40
    jsr L1_8705                 ; 8738  20 05 87
    sta NOISE_VOL               ; 873B  8D 0C 40
    jsr L1_8705                 ; 873E  20 05 87
    ldx #$7F                    ; 8741  A2 7F
    stx SQ1_SWEEP               ; 8743  8E 01 40
    jsr L1_8705                 ; 8746  20 05 87
    stx SQ2_SWEEP               ; 8749  8E 05 40
    pla                         ; 874C  68
    tay                         ; 874D  A8
    pla                         ; 874E  68
    tax                         ; 874F  AA
    rts                         ; 8750  60


L1_8751:
    jsr L1_8673                 ; 8751  20 73 86
    lda #$30                    ; 8754  A9 30
    sta SQ1_VOL                 ; 8756  8D 00 40
    jsr L1_8705                 ; 8759  20 05 87
    sta SQ2_VOL                 ; 875C  8D 04 40
    jsr L1_8705                 ; 875F  20 05 87
    sta NOISE_VOL               ; 8762  8D 0C 40
    jsr L1_8705                 ; 8765  20 05 87
    ldx #$7F                    ; 8768  A2 7F
    stx SQ1_SWEEP               ; 876A  8E 01 40
    jsr L1_8705                 ; 876D  20 05 87
    stx SQ2_SWEEP               ; 8770  8E 05 40
    rts                         ; 8773  60

    .byte $8A,$48,$98,$48,$A2,$00,$86,$E6,$AD,$0A,$01,$F0,$09,$8E,$0A,$01
    .byte $8E,$23,$01,$20,$83,$86,$68,$A8,$68,$AA,$60,$8D,$3E,$01,$8D,$41
    .byte $01,$A9,$00,$8D,$3C,$01,$60

L1_879B:
    sta $0122                   ; 879B  8D 22 01
    cmp #$01                    ; 879E  C9 01
    bne L1_87A5                 ; 87A0  D0 03
    jmp L1_8712                 ; 87A2  4C 12 87


L1_87A5:
    cmp #$5A                    ; 87A5  C9 5A
    bcc L1_87AC                 ; 87A7  90 03
    jmp L1_88A8                 ; 87A9  4C A8 88


L1_87AC:
    cmp #$57                    ; 87AC  C9 57
    bne L1_87B6                 ; 87AE  D0 06
    jsr L1_8712                 ; 87B0  20 12 87
    jmp L1_87D4                 ; 87B3  4C D4 87


L1_87B6:
    cmp #$46                    ; 87B6  C9 46
    bne L1_87C7                 ; 87B8  D0 0D
    lda $0107                   ; 87BA  AD 07 01
    cmp #$57                    ; 87BD  C9 57
    bne L1_87C2                 ; 87BF  D0 01
    rts                         ; 87C1  60


L1_87C2:
    cmp #$46                    ; 87C2  C9 46
    bne L1_87C7                 ; 87C4  D0 01
    rts                         ; 87C6  60


L1_87C7:
    cmp #$2A                    ; 87C7  C9 2A
    beq L1_87CF                 ; 87C9  F0 04
    cmp #$2E                    ; 87CB  C9 2E
    bne L1_87D4                 ; 87CD  D0 05

L1_87CF:
    lda #$00                    ; 87CF  A9 00
    sta DMC_RAW                 ; 87D1  8D 11 40

L1_87D4:
    txa                         ; 87D4  8A
    pha                         ; 87D5  48
    tya                         ; 87D6  98
    pha                         ; 87D7  48
    lda D1_8710                 ; 87D8  AD 10 87
    sta $EC                     ; 87DB  85 EC
    lda D1_8711                 ; 87DD  AD 11 87
    sta $ED                     ; 87E0  85 ED
    lda #$03                    ; 87E2  A9 03
    sta $EA                     ; 87E4  85 EA

L1_87E6:
    lda $0122                   ; 87E6  AD 22 01
    clc                         ; 87E9  18
    adc $EC                     ; 87EA  65 EC
    sta $EC                     ; 87EC  85 EC
    lda #$00                    ; 87EE  A9 00
    adc $ED                     ; 87F0  65 ED
    sta $ED                     ; 87F2  85 ED
    dec $EA                     ; 87F4  C6 EA
    bne L1_87E6                 ; 87F6  D0 EE
    ldy #$00                    ; 87F8  A0 00
    sty $EB                     ; 87FA  84 EB
    lda ($EC),y                 ; 87FC  B1 EC
    lsr a                       ; 87FE  4A
    lsr a                       ; 87FF  4A
    lsr a                       ; 8800  4A
    and #$03                    ; 8801  29 03
    sta $EA                     ; 8803  85 EA

L1_8805:
    lda $EB                     ; 8805  A5 EB
    asl a                       ; 8807  0A
    clc                         ; 8808  18
    adc $EB                     ; 8809  65 EB
    tay                         ; 880B  A8
    lda ($EC),y                 ; 880C  B1 EC
    and #$07                    ; 880E  29 07
    tax                         ; 8810  AA
    lda $0122                   ; 8811  AD 22 01
    cmp $0106,x                 ; 8814  DD 06 01
    bcc L1_888E                 ; 8817  90 75
    lda #$00                    ; 8819  A9 00
    sta $0106,x                 ; 881B  9D 06 01
    iny                         ; 881E  C8
    lda ($EC),y                 ; 881F  B1 EC
    sta $0112,x                 ; 8821  9D 12 01
    sta $E8                     ; 8824  85 E8
    iny                         ; 8826  C8
    lda ($EC),y                 ; 8827  B1 EC
    sta $0118,x                 ; 8829  9D 18 01
    sta $E9                     ; 882C  85 E9
    lda #$F8                    ; 882E  A9 F8
    sta $010C,x                 ; 8830  9D 0C 01
    lda #$01                    ; 8833  A9 01
    sta $0100,x                 ; 8835  9D 00 01
    cpx #$03                    ; 8838  E0 03
    bcs L1_884A                 ; 883A  B0 0E
    cpx #$02                    ; 883C  E0 02
    beq L1_8845                 ; 883E  F0 05
    lda #$80                    ; 8840  A9 80
    sta $0178,x                 ; 8842  9D 78 01

L1_8845:
    lda #$00                    ; 8845  A9 00
    sta $0132,x                 ; 8847  9D 32 01

L1_884A:
    lda #$00                    ; 884A  A9 00
    sta $0148,x                 ; 884C  9D 48 01
    tay                         ; 884F  A8
    lda ($E8),y                 ; 8850  B1 E8
    iny                         ; 8852  C8
    cmp #$30                    ; 8853  C9 30
    bcc L1_885E                 ; 8855  90 07
    dey                         ; 8857  88
    sty $013E                   ; 8858  8C 3E 01
    sty $013C                   ; 885B  8C 3C 01

L1_885E:
    tya                         ; 885E  98
    sta $0124,x                 ; 885F  9D 24 01
    lda $0122                   ; 8862  AD 22 01
    sta $0106,x                 ; 8865  9D 06 01
    txa                         ; 8868  8A
    cmp #$01                    ; 8869  C9 01
    bcc L1_889C                 ; 886B  90 2F
    cpx #$05                    ; 886D  E0 05
    bne L1_8876                 ; 886F  D0 05
    lda #$0C                    ; 8871  A9 0C
    jmp L1_887A                 ; 8873  4C 7A 88


L1_8876:
    asl a                       ; 8876  0A
    asl a                       ; 8877  0A
    and #$0F                    ; 8878  29 0F

L1_887A:
    tax                         ; 887A  AA
    lda #$00                    ; 887B  A9 00
    cpx #$08                    ; 887D  E0 08
    beq L1_8883                 ; 887F  F0 02
    lda #$30                    ; 8881  A9 30

L1_8883:
    sta SQ1_VOL,x               ; 8883  9D 00 40
    jsr L1_8705                 ; 8886  20 05 87
    lda #$7F                    ; 8889  A9 7F
    sta SQ1_SWEEP,x             ; 888B  9D 01 40

L1_888E:
    inc $EB                     ; 888E  E6 EB
    dec $EA                     ; 8890  C6 EA
    bpl L1_8899                 ; 8892  10 05
    pla                         ; 8894  68
    tay                         ; 8895  A8
    pla                         ; 8896  68
    tax                         ; 8897  AA
    rts                         ; 8898  60


L1_8899:
    jmp L1_8805                 ; 8899  4C 05 88


L1_889C:
    ora #$04                    ; 889C  09 04
    tay                         ; 889E  A8
    lda $0106,y                 ; 889F  B9 06 01
    bne L1_888E                 ; 88A2  D0 EA
    txa                         ; 88A4  8A
    jmp L1_8876                 ; 88A5  4C 76 88


L1_88A8:
    sec                         ; 88A8  38
    sbc #$5A                    ; 88A9  E9 5A
    sta $0122                   ; 88AB  8D 22 01
    tya                         ; 88AE  98
    pha                         ; 88AF  48
    lda $0122                   ; 88B0  AD 22 01
    asl a                       ; 88B3  0A
    asl a                       ; 88B4  0A
    tay                         ; 88B5  A8
    lda #$0F                    ; 88B6  A9 0F
    sta SND_CHN                 ; 88B8  8D 15 40
    lda D1_88DB,y               ; 88BB  B9 DB 88
    sta DMC_FREQ                ; 88BE  8D 10 40
    lda D1_88DC,y               ; 88C1  B9 DC 88
    sta DMC_RAW                 ; 88C4  8D 11 40
    lda D1_88DD,y               ; 88C7  B9 DD 88
    sta DMC_START               ; 88CA  8D 12 40
    lda D1_88DE,y               ; 88CD  B9 DE 88
    sta DMC_LEN                 ; 88D0  8D 13 40
    lda #$1F                    ; 88D3  A9 1F
    sta SND_CHN                 ; 88D5  8D 15 40
    pla                         ; 88D8  68
    tay                         ; 88D9  A8
    rts                         ; 88DA  60

D1_88DB:
    .byte $0F
D1_88DC:
    .byte $2F
D1_88DD:
    .byte $F0
D1_88DE:
    .byte $05,$0F,$75,$F3,$25,$0F,$00,$F0,$05,$0F,$00,$F3,$25,$03,$24,$8A
    .byte $05,$02,$8A,$0C,$25,$8A,$05,$36,$8A,$04,$41,$8A,$0C,$78,$8A,$05
    .byte $82,$8A,$05,$90,$8A,$05,$81,$8C,$0C,$B3,$8A,$05,$DC,$8A,$0C,$05
    .byte $8B,$05,$32,$8B,$0C,$59,$8B,$05,$90,$8B,$0C,$F3,$8B,$05,$07,$8C
    .byte $0C,$19,$8C,$05,$27,$8C,$04,$BA,$8C,$04,$49,$8D,$0C,$D4,$8C,$05
    .byte $F7,$8C,$04,$1C,$8D,$04,$33,$8D,$04,$DD,$8D,$04,$76,$8D,$0C,$A5
    .byte $8E,$05,$C6,$8E,$04,$2F,$8E,$04,$47,$8E,$04,$5E,$8E,$14,$E3,$8E
    .byte $01,$E3,$8E,$05,$83,$8F,$05,$C2,$8F,$05,$01,$90,$18,$95,$91,$01
    .byte $AB,$91,$02,$C3,$91,$03,$D3,$91,$18,$28,$94,$01,$4E,$92,$02,$C7
    .byte $95,$03,$75,$97,$18,$85,$99,$01,$71,$9A,$02,$67,$9B,$03,$CE,$9B
    .byte $18,$A4,$9C,$01,$32,$9D,$02,$9A,$9D,$03,$1E,$9E,$18,$A8,$9E,$01
    .byte $46,$9F,$02,$B8,$9F,$03,$03,$A0,$18,$92,$A0,$01,$A7,$A1,$02,$95
    .byte $A2,$03,$2F,$A3,$18,$68,$A4,$01,$70,$A5,$02,$EB,$A5,$03,$7A,$A6
    .byte $18,$93,$A7,$01,$78,$A8,$02,$FB,$A8,$03,$0E,$AA,$18,$92,$AA,$01
    .byte $B3,$AA,$02,$D4,$AA,$03,$EF,$AA,$18,$9F,$AC,$01,$1A,$AD,$02,$05
    .byte $AE,$03,$87,$AE,$18,$34,$AB,$01,$5C,$AB,$02,$86,$AB,$03,$B2,$AB
    .byte $0C,$17,$91,$05,$6A,$91,$04,$0A,$8A,$0C,$3C,$90,$05,$55,$90,$14
    .byte $94,$90,$01,$98,$90,$05,$DC,$90,$03,$24,$8A,$03,$24,$8A,$03,$24
    .byte $8A,$03,$24,$8A,$21,$30,$60,$03,$F8,$10,$01,$FF,$25,$82,$00,$D5
    .byte $00,$8E,$00,$A9,$22,$B0,$E0,$6A,$D0,$6A,$B0,$6A,$A0,$6A,$90,$6A
    .byte $70,$6A,$50,$6A,$40,$6A,$FF,$21,$30,$40,$F0,$00,$00,$00,$00,$21
    .byte $F0,$F8,$20,$0A,$F8,$10,$0B,$FF,$21,$0F,$A0,$0C,$00,$00,$23,$30
    .byte $30,$02,$FF,$21,$70,$10,$83,$F3,$8C,$F2,$F6,$F3,$15,$73,$77,$D3
    .byte $8C,$00,$00,$D3,$15,$00,$00,$D3,$8C,$B3,$45,$33,$11,$B3,$50,$73
    .byte $33,$B4,$00,$00,$00,$B2,$DD,$00,$00,$00,$00,$A3,$50,$00,$00,$73
    .byte $22,$00,$00,$53,$50,$00,$00,$32,$EE,$FF,$26,$30,$10,$99,$60,$8E
    .byte $F8,$20,$8E,$FF,$21,$30,$B0,$06,$70,$02,$50,$06,$30,$02,$F8,$10
    .byte $02,$FF,$21,$30,$C0,$0E,$C0,$0F,$FE,$02,$90,$8A,$24,$30,$A0,$0F
    .byte $90,$0E,$80,$0F,$70,$0F,$60,$0F,$50,$0F,$40,$0F,$30,$0F,$F8,$20
    .byte $0F,$F8,$10,$0F,$FF,$25,$70,$10,$83,$D2,$86,$B0,$C0,$21,$F0,$A0
    .byte $09,$25,$70,$60,$F2,$21,$F0,$A0,$0A,$25,$70,$51,$2B,$41,$76,$31
    .byte $D3,$F8,$22,$44,$F8,$12,$DD,$F8,$13,$99,$F8,$14,$7E,$FF,$21,$30
    .byte $F0,$09,$D0,$0E,$F8,$20,$0A,$F8,$20,$09,$00,$00,$FE,$02,$DC,$8A
    .byte $23,$30,$70,$0B,$F8,$20,$0E,$30,$0E,$F8,$20,$0B,$00,$00,$30,$0A
    .byte $F8,$20,$0D,$F8,$10,$0B,$FF,$21,$F0,$10,$83,$C2,$3B,$81,$0D,$71
    .byte $C5,$C0,$08,$FE,$02,$05,$8B,$25,$F0,$60,$F2,$21,$F0,$B0,$08,$25
    .byte $F0,$51,$2B,$41,$76,$31,$D3,$F8,$22,$44,$F8,$12,$DD,$F8,$13,$99
    .byte $F8,$14,$7E,$FF,$21,$30,$F0,$09,$D0,$0E,$F8,$20,$0A,$F8,$10,$09
    .byte $FE,$02,$32,$8B,$23,$30,$70,$0B,$F8,$20,$0E,$30,$0E,$F8,$20,$0B
    .byte $00,$00,$30,$0A,$F8,$20,$0D,$F8,$10,$0B,$FF,$22,$30,$10,$83,$30
    .byte $39,$40,$40,$50,$47,$60,$50,$70,$5A,$80,$65,$90,$71,$A0,$7F,$A0
    .byte $8F,$90,$A0,$90,$B4,$80,$CA,$80,$E2,$80,$FE,$81,$1D,$71,$40,$71
    .byte $68,$61,$94,$61,$C5,$61,$FC,$62,$36,$62,$81,$52,$CF,$53,$27,$53
    .byte $8A,$FF,$21,$30,$30,$0B,$40,$0A,$50,$09,$60,$08,$70,$07,$70,$06
    .byte $80,$06,$80,$06,$80,$06,$80,$06,$80,$06,$80,$06,$80,$07,$80,$06
    .byte $80,$07,$80,$07,$80,$08,$80,$07,$80,$08,$80,$08,$80,$09,$80,$08
    .byte $80,$09,$80,$09,$80,$0A,$70,$09,$70,$0A,$70,$0A,$70,$0B,$70,$0A
    .byte $70,$0B,$70,$0B,$70,$0C,$70,$0B,$70,$0C,$70,$0C,$60,$0D,$60,$0C
    .byte $60,$0D,$60,$0D,$50,$0E,$50,$0D,$50,$0E,$50,$0E,$50,$0E,$50,$0E
    .byte $40,$0E,$40,$0E,$FF,$23,$F0,$10,$82,$B0,$35,$90,$50,$70,$78,$FE
    .byte $03,$F3,$8B,$30,$B4,$F8,$21,$0D,$FF,$23,$30,$40,$06,$50,$08,$60
    .byte $0A,$FE,$03,$07,$8C,$30,$0C,$F8,$10,$0D,$FF,$2A,$30,$10,$8B,$B2
    .byte $66,$72,$66,$32,$66,$F8,$12,$66,$FF,$21,$30,$B0,$0E,$B0,$0D,$B0
    .byte $0C,$B0,$0B,$B0,$0A,$B0,$09,$B0,$08,$B0,$07,$B0,$06,$B0,$05,$70
    .byte $0E,$70,$0D,$70,$0C,$70,$0B,$70,$0A,$70,$09,$70,$08,$70,$07,$70
    .byte $06,$70,$05,$30,$0E,$30,$0D,$30,$0C,$30,$0B,$30,$0A,$30,$09,$30
    .byte $08,$30,$07,$30,$06,$30,$05,$F8,$10,$0E,$F8,$10,$0D,$F8,$10,$0C
    .byte $F8,$10,$0B,$F8,$10,$0A,$F8,$10,$09,$F8,$10,$08,$F8,$10,$07,$F8
    .byte $10,$06,$FF,$22,$30,$F0,$0E,$F0,$0D,$F0,$0C,$A0,$07,$A0,$08,$B0
    .byte $09,$C0,$0A,$C0,$0B,$C0,$0C,$C0,$0D,$23,$30,$F0,$0E,$E0,$0E,$D0
    .byte $0E,$C0,$0E,$B0,$0E,$A0,$0E,$90,$0E,$80,$0E,$70,$0E,$60,$0E,$50
    .byte $0E,$40,$0E,$30,$0E,$F8,$20,$0E,$F8,$10,$0E,$FF,$21,$30,$90,$20
    .byte $C0,$08,$60,$80,$FE,$02,$BA,$8C,$30,$20,$24,$30,$30,$80,$30,$20
    .byte $50,$08,$F8,$10,$80,$FF,$23,$F0,$10,$82,$B0,$33,$22,$30,$10,$8E
    .byte $B0,$66,$70,$5A,$50,$50,$40,$48,$30,$40,$30,$3F,$F8,$20,$3F,$F8
    .byte $20,$3F,$F8,$10,$3F,$F8,$10,$3F,$FF,$21,$30,$D0,$0B,$50,$0A,$30
    .byte $09,$70,$0A,$50,$09,$50,$09,$40,$0A,$40,$0B,$30,$0B,$40,$0B,$30
    .byte $0B,$F8,$20,$0B,$F8,$20,$0B,$F8,$10,$0B,$F8,$10,$0A,$FF,$21,$30
    .byte $10,$81,$F0,$59,$24,$F0,$10,$82,$F0,$FE,$C0,$35,$90,$59,$70,$D5
    .byte $51,$59,$31,$7F,$FF,$28,$B0,$10,$83,$F1,$0D,$28,$F0,$10,$82,$F0
    .byte $FE,$C0,$D5,$50,$B3,$30,$A0,$F8,$10,$A0,$FF,$23,$B0,$10,$82,$F2
    .byte $70,$00,$00,$23,$B0,$F1,$AB,$F1,$67,$E1,$AB,$D1,$67,$C1,$AB,$B1
    .byte $67,$A1,$AB,$91,$67,$81,$AB,$71,$67,$61,$AB,$51,$67,$41,$AB,$31
    .byte $67,$F8,$21,$AB,$F8,$11,$67,$FF,$21,$B0,$00,$00,$FD,$84,$8D,$FD
    .byte $84,$8D,$FD,$84,$8D,$FF,$21,$F0,$10,$85,$F8,$12,$E0,$F8,$22,$C0
    .byte $32,$A0,$42,$80,$52,$60,$62,$40,$72,$20,$82,$00,$91,$E0,$A1,$C0
    .byte $B1,$A0,$C1,$80,$D1,$60,$D1,$50,$D1,$48,$D1,$44,$D1,$40,$10,$86
    .byte $E1,$40,$A1,$41,$FE,$0C,$AE,$8D,$B1,$40,$B1,$40,$A1,$40,$A1,$40
    .byte $51,$40,$24,$F0,$10,$82,$B1,$40,$B1,$40,$71,$40,$71,$40,$31,$40
    .byte $31,$40,$F8,$11,$40,$F8,$11,$40,$F8,$11,$40,$F8,$11,$40,$FF,$23
    .byte $F0,$F8,$10,$1F,$F8,$20,$20,$30,$21,$40,$22,$50,$23,$60,$24,$70
    .byte $25,$80,$26,$90,$27,$A0,$28,$A0,$29,$A0,$2A,$90,$2B,$90,$2C,$90
    .byte $2D,$80,$2E,$80,$2F,$80,$30,$70,$31,$70,$32,$70,$33,$60,$34,$60
    .byte $35,$60,$36,$50,$37,$50,$38,$50,$39,$40,$3A,$40,$3B,$40,$3C,$30
    .byte $3D,$30,$3E,$30,$3F,$30,$40,$F8,$20,$41,$F8,$20,$42,$F8,$20,$43
    .byte $FF,$21,$B0,$10,$82,$C3,$02,$21,$70,$F8,$20,$66,$21,$B0,$C3,$01
    .byte $03,$01,$C3,$01,$21,$70,$30,$33,$FF,$28,$B0,$10,$8B,$A3,$FA,$B1
    .byte $7D,$70,$7F,$50,$5F,$40,$5F,$30,$5F,$F8,$20,$5F,$F8,$10,$5F,$FF
    .byte $22,$30,$F0,$7F,$21,$30,$F0,$7F,$00,$00,$00,$00,$25,$F0,$D0,$3F
    .byte $22,$30,$D0,$7F,$25,$F0,$B0,$3F,$22,$30,$B0,$7F,$25,$F0,$90,$3F
    .byte $22,$30,$90,$7F,$25,$F0,$70,$3F,$22,$30,$70,$7F,$25,$F0,$50,$3F
    .byte $22,$50,$30,$7F,$25,$F0,$30,$3F,$22,$30,$30,$7F,$25,$F0,$F8,$10
    .byte $3F,$22,$30,$F8,$10,$7F,$FF,$21,$30,$10,$89,$D1,$FD,$FE,$28,$A5
    .byte $8E,$C1,$FD,$B1,$FD,$B1,$FD,$91,$FD,$91,$FD,$71,$FD,$61,$FD,$51
    .byte $FD,$51,$FD,$31,$FD,$31,$FD,$FF,$21,$30,$70,$06,$FE,$28,$C6,$8E
    .byte $60,$06,$60,$06,$50,$06,$50,$06,$50,$06,$40,$06,$40,$06,$40,$06
    .byte $30,$06,$30,$06,$FF,$21,$30,$10,$82,$63,$83,$33,$63,$F8,$23,$53
    .byte $00,$00,$73,$83,$33,$64,$F8,$23,$53,$00,$00,$FE,$0F,$F0,$8E,$83
    .byte $83,$43,$65,$33,$53,$F8,$13,$33,$FE,$10,$FD,$8E,$93,$83,$43,$66
    .byte $33,$53,$F8,$13,$33,$FE,$10,$0A,$8F,$A3,$83,$43,$67,$33,$53,$F8
    .byte $13,$33,$FE,$10,$17,$8F,$93,$83,$43,$66,$33,$53,$F8,$13,$33,$FE
    .byte $08,$24,$8F,$83,$83,$43,$65,$33,$53,$F8,$13,$33,$FE,$08,$31,$8F
    .byte $73,$83,$33,$65,$F8,$23,$53,$00,$00,$FE,$08,$3E,$8F,$63,$83,$33
    .byte $63,$F8,$23,$53,$00,$00,$FE,$08,$4B,$8F,$53,$83,$F8,$23,$63,$F8
    .byte $13,$53,$00,$00,$FE,$08,$58,$8F,$43,$83,$F8,$23,$63,$F8,$13,$53
    .byte $00,$00,$FE,$08,$66,$8F,$33,$83,$F8,$13,$63,$F8,$13,$53,$00,$00
    .byte $FE,$08,$74,$8F,$FF,$2E,$30,$F8,$20,$0E,$F8,$20,$0E,$FE,$03,$85
    .byte $8F,$30,$0E,$30,$0E,$FE,$04,$8F,$8F,$40,$0E,$40,$0E,$FE,$04,$97
    .byte $8F,$50,$0E,$50,$0E,$FE,$06,$9F,$8F,$40,$0E,$40,$0E,$FE,$04,$A7
    .byte $8F,$30,$0E,$30,$0E,$FE,$04,$AF,$8F,$F8,$20,$0E,$F8,$20,$0E,$FE
    .byte $04,$B7,$8F,$FF,$21,$30,$F0,$0E,$F0,$0F,$FE,$02,$C2,$8F,$22,$30
    .byte $F0,$0F,$F0,$08,$F0,$0F,$F0,$08,$F0,$0F,$F0,$0C,$F0,$0B,$F0,$0B
    .byte $F0,$0B,$E0,$0B,$D0,$0B,$C0,$0D,$B0,$0C,$A0,$0B,$90,$0B,$B0,$0B
    .byte $70,$0B,$60,$0B,$23,$30,$50,$0B,$40,$0B,$30,$0C,$F8,$20,$0C,$F8
    .byte $10,$0B,$FF,$21,$30,$F0,$0E,$F0,$0F,$FE,$04,$01,$90,$22,$30,$F0
    .byte $0F,$F0,$08,$F0,$0F,$27,$30,$F0,$0C,$F0,$0B,$F0,$0B,$F0,$0B,$E0
    .byte $0B,$D0,$0B,$C0,$0D,$B0,$0C,$A0,$0B,$90,$0B,$80,$0B,$70,$0B,$60
    .byte $0C,$50,$0B,$40,$0B,$30,$0C,$F8,$20,$0C,$F8,$10,$0B,$FF,$23,$B0
    .byte $10,$83,$D2,$11,$D2,$11,$26,$B0,$C0,$B8,$B0,$BC,$A0,$C0,$90,$C5
    .byte $70,$CA,$50,$CF,$30,$D4,$FF,$21,$30,$F0,$0E,$F0,$0F,$FE,$02,$55
    .byte $90,$25,$30,$F0,$0F,$F0,$0A,$F0,$0F,$F0,$0A,$F0,$0F,$F0,$0C,$F0
    .byte $0C,$F0,$0B,$F0,$0B,$E0,$0B,$D0,$0C,$C0,$0D,$B0,$0D,$A0,$0C,$90
    .byte $0C,$B0,$0C,$70,$0C,$60,$0C,$23,$30,$50,$0C,$40,$0C,$30,$0D,$F8
    .byte $20,$0D,$F8,$20,$0C,$FF,$21,$B0,$00,$00,$25,$B0,$10,$83,$F1,$FD
    .byte $10,$83,$F0,$FE,$2F,$B0,$10,$83,$F0,$FE,$10,$83,$91,$12,$10,$83
    .byte $B1,$23,$10,$83,$D1,$01,$10,$83,$91,$12,$10,$83,$51,$1D,$10,$83
    .byte $41,$2E,$10,$83,$31,$40,$10,$83,$31,$1D,$10,$83,$F8,$21,$2E,$10
    .byte $83,$F8,$21,$40,$10,$83,$F8,$11,$1D,$24,$B0,$00,$00,$FF,$21,$30
    .byte $F0,$0E,$F0,$0F,$FE,$04,$DC,$90,$22,$30,$F0,$0F,$F0,$08,$F0,$0F
    .byte $2A,$30,$F0,$0C,$F0,$0B,$F0,$0B,$F0,$0B,$E0,$0B,$D0,$0B,$C0,$0D
    .byte $B0,$0C,$A0,$0B,$90,$0B,$80,$0B,$70,$0B,$60,$0C,$50,$0B,$40,$0B
    .byte $30,$0C,$F8,$20,$0C,$F8,$10,$0B,$FF,$23,$F0,$10,$81,$F0,$FE,$70
    .byte $FE,$30,$FE,$22,$30,$00,$00,$22,$30,$10,$83,$F0,$8E,$F0,$97,$F0
    .byte $9B,$F0,$AD,$F0,$B7,$F0,$CD,$F0,$D9,$F0,$F4,$E1,$02,$E1,$21,$E1
    .byte $32,$E1,$57,$D1,$6B,$D1,$97,$D1,$AF,$D1,$E4,$C2,$01,$C2,$3F,$C2
    .byte $61,$C2,$AB,$B2,$D3,$B3,$2B,$B3,$5B,$B3,$C4,$B3,$FA,$B4,$76,$B4
    .byte $BA,$B5,$4E,$B5,$9E,$B6,$4E,$B6,$AE,$B6,$AE,$FF,$23,$30,$50,$0C
    .byte $40,$06,$30,$03,$22,$30,$00,$00,$24,$30,$50,$02,$50,$03,$50,$04
    .byte $50,$05,$50,$06,$50,$07,$60,$08,$60,$09,$60,$0A,$60,$0B,$70,$0C
    .byte $70,$0D,$70,$0E,$70,$0F,$FF,$E8,$D9,$F8,$87,$0A,$E3,$03,$D9,$F7
    .byte $84,$06,$E2,$93,$73,$23,$DA,$F7,$84,$02,$E2,$4F,$FF,$D9,$39,$86
    .byte $0A,$E3,$53,$D9,$3A,$87,$05,$E1,$03,$E2,$B3,$73,$DA,$38,$85,$03
    .byte $95,$E1,$21,$47,$FF,$D9,$6F,$E3,$53,$E1,$43,$23,$E2,$B3,$DA,$90
    .byte $E3,$95,$21,$97,$FF,$D9,$33,$03,$03,$33,$DA,$55,$11,$17,$FF,$05
    .byte $06,$07,$06,$05,$04,$03,$FF,$03,$04,$03,$02,$FF,$07,$06,$05,$04
    .byte $03,$02,$01,$00,$00,$00,$02,$02,$FF,$06,$05,$04,$03,$02,$01,$00
    .byte $00,$00,$00,$01,$01,$FF,$07,$06,$05,$04,$03,$03,$02,$01,$00,$00
    .byte $00,$00,$00,$00,$00,$02,$02,$FF,$07,$06,$05,$04,$03,$00,$00,$00
    .byte $00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$FF,$05,$04,$03,$02,$01
    .byte $01,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$FF,$06,$05
    .byte $04,$03,$02,$02,$02,$01,$00,$00,$00,$00,$00,$00,$00,$01,$01,$FF
    .byte $EC,$01,$EB,$2A,$22,$D6,$F7,$84,$00,$E1,$40,$20,$E2,$B0,$90,$B0
    .byte $90,$70,$60,$70,$60,$40,$20,$40,$E3,$90,$B0,$E2,$20,$D6,$F0,$00
    .byte $04,$E2,$49,$B0,$C0,$90,$B1,$E1,$10,$2F,$E2,$49,$B0,$C0,$90,$B1
    .byte $E1,$10,$E2,$7E,$C0,$FE,$02,$6B,$92,$D6,$F7,$02,$00,$E2,$B0,$C0
    .byte $D6,$F7,$84,$01,$B2,$E1,$12,$D6,$F7,$02,$00,$20,$C0,$20,$C0,$D6
    .byte $F1,$80,$00,$C0,$20,$C0,$20,$D6,$F7,$02,$00,$E1,$10,$C0,$D6,$F7
    .byte $84,$01,$12,$22,$D6,$F7,$02,$00,$40,$C0,$40,$C0,$20,$D6,$F7,$84
    .byte $01,$42,$D6,$F7,$02,$00,$E2,$B0,$C0,$D6,$F7,$84,$01,$B2,$E1,$12
    .byte $D6,$F7,$02,$00,$20,$C0,$20,$C0,$D6,$F1,$80,$00,$C0,$20,$C0,$20
    .byte $D6,$F7,$02,$00,$E1,$10,$C0,$D6,$F7,$84,$01,$12,$22,$D6,$F7,$00
    .byte $00,$43,$93,$D6,$F7,$84,$00,$E1,$60,$40,$E0,$10,$E1,$B0,$90,$80
    .byte $60,$40,$60,$40,$E1,$10,$E2,$B0,$E1,$10,$E2,$B0,$90,$80,$EB,$2A
    .byte $24,$D6,$F7,$85,$01,$E3,$B2,$C0,$D6,$F7,$04,$00,$B0,$E2,$11,$20
    .byte $61,$41,$20,$11,$E3,$90,$D6,$F7,$84,$03,$BF,$D6,$F7,$04,$00,$83
    .byte $90,$B2,$E2,$13,$20,$42,$63,$80,$91,$B0,$E1,$13,$E2,$B0,$EB,$2A
    .byte $22,$D6,$F7,$84,$03,$E3,$B0,$E2,$20,$40,$60,$40,$60,$E3,$B1,$B0
    .byte $E2,$20,$40,$61,$90,$80,$90,$81,$40,$6F,$E3,$83,$90,$B2,$E2,$13
    .byte $20,$42,$60,$60,$60,$C0,$60,$81,$90,$E1,$13,$E2,$B3,$D6,$F7,$05
    .byte $00,$E2,$90,$90,$90,$92,$90,$90,$90,$91,$91,$D6,$F7,$84,$03,$82
    .byte $D6,$F7,$05,$00,$60,$60,$60,$62,$60,$60,$60,$61,$61,$D6,$F7,$84
    .byte $03,$82,$D6,$F7,$05,$00,$90,$90,$90,$92,$90,$90,$90,$91,$91,$D6
    .byte $F7,$84,$03,$82,$D6,$F7,$05,$00,$60,$60,$60,$62,$60,$80,$90,$B0
    .byte $E1,$10,$E2,$B1,$D6,$F7,$84,$03,$82,$D6,$F7,$05,$00,$E1,$10,$10
    .byte $10,$12,$10,$10,$10,$11,$11,$D6,$F7,$84,$03,$E2,$B2,$D6,$F7,$05
    .byte $00,$90,$90,$90,$92,$90,$90,$90,$91,$91,$D6,$F7,$84,$03,$B2,$D6
    .byte $F7,$05,$00,$E1,$10,$10,$10,$12,$10,$10,$10,$11,$11,$D6,$F7,$84
    .byte $03,$22,$D6,$F7,$05,$00,$40,$40,$40,$42,$40,$40,$40,$43,$D6,$F8
    .byte $00,$00,$E3,$B0,$E2,$20,$40,$60,$40,$60,$E3,$B1,$B0,$E2,$20,$40
    .byte $60,$40,$60,$91,$90,$80,$90,$60,$40,$60,$E3,$B1,$B0,$E2,$20,$40
    .byte $C0,$60,$C0,$80,$C0,$92,$FE,$FF,$6B,$92,$EC,$01,$E8,$D6,$F6,$01
    .byte $04,$E2,$B0,$90,$60,$40,$60,$40,$20,$10,$20,$10,$E3,$B0,$90,$90
    .byte $40,$60,$90,$D6,$F6,$01,$04,$E3,$B9,$E2,$60,$C0,$40,$61,$70,$9F
    .byte $E3,$B9,$E2,$60,$C0,$40,$61,$80,$2E,$C0,$FE,$02,$45,$94,$D6,$F7
    .byte $03,$00,$E2,$60,$C0,$62,$82,$90,$C0,$90,$C0,$D6,$B6,$85,$00,$C0
    .byte $E2,$60,$90,$B0,$D6,$F7,$03,$00,$E2,$80,$C0,$82,$92,$B0,$C0,$B0
    .byte $C0,$90,$D6,$F4,$81,$00,$B2,$D6,$F7,$03,$00,$E2,$60,$C0,$62,$82
    .byte $90,$C0,$90,$C0,$D6,$B6,$85,$00,$C0,$E2,$60,$90,$B0,$D6,$F7,$03
    .byte $00,$E2,$80,$C0,$82,$92,$D6,$F5,$83,$00,$B3,$E1,$43,$D6,$F3,$81
    .byte $00,$E1,$60,$40,$60,$40,$E0,$10,$E1,$B0,$90,$80,$60,$40,$60,$40
    .byte $E1,$10,$E2,$B0,$E1,$10,$E2,$B0,$D6,$F5,$83,$03,$E3,$63,$D6,$F7
    .byte $07,$03,$60,$E2,$11,$20,$61,$41,$20,$11,$E3,$90,$D6,$F7,$86,$00
    .byte $E4,$B0,$B0,$B1,$B0,$D6,$F7,$85,$00,$E3,$12,$22,$E4,$B0,$E3,$40
    .byte $62,$D6,$F5,$07,$00,$E3,$43,$60,$82,$93,$B0,$E2,$12,$23,$20,$41
    .byte $60,$93,$80,$D6,$F7,$84,$03,$E3,$B0,$E2,$20,$40,$60,$40,$60,$E3
    .byte $B1,$B0,$E2,$20,$40,$61,$90,$80,$90,$81,$40,$D6,$37,$84,$03,$E2
    .byte $60,$40,$60,$E3,$B1,$B0,$E2,$20,$40,$61,$90,$80,$90,$B1,$E1,$10
    .byte $D6,$F7,$84,$03,$E3,$43,$60,$82,$93,$B0,$E2,$12,$20,$20,$20,$C0
    .byte $20,$41,$60,$93,$83,$D6,$F7,$06,$00,$E2,$60,$60,$60,$62,$60,$60
    .byte $60,$61,$61,$42,$20,$20,$20,$22,$20,$20,$20,$21,$21,$42,$60,$60
    .byte $60,$62,$60,$60,$60,$61,$61,$42,$20,$20,$20,$22,$20,$40,$60,$80
    .byte $90,$81,$42,$90,$90,$90,$92,$90,$90,$90,$91,$91,$82,$60,$60,$60
    .byte $62,$60,$60,$60,$61,$61,$82,$90,$90,$90,$92,$90,$90,$90,$91,$81
    .byte $92,$B0,$B0,$B0,$B2,$B0,$B0,$B0,$B3,$D6,$F6,$00,$00,$E3,$60,$B0
    .byte $E2,$10,$20,$10,$20,$E3,$61,$60,$B0,$E2,$10,$20,$10,$20,$61,$60
    .byte $40,$60,$20,$10,$20,$E3,$61,$60,$B0,$E2,$10,$C0,$D6,$F6,$01,$04
    .byte $20,$C0,$40,$C0,$62,$FE,$FF,$45,$94,$EC,$01,$D6,$12,$E1,$40,$20
    .byte $E2,$B0,$90,$B0,$90,$70,$60,$70,$60,$40,$20,$40,$E3,$90,$B0,$E2
    .byte $20,$D6,$0F,$E3,$B0,$90,$B0,$41,$40,$70,$90,$B0,$90,$B0,$E2,$21
    .byte $20,$10,$20,$E3,$B0,$90,$B0,$41,$40,$70,$90,$B0,$C0,$E2,$20,$E3
    .byte $B0,$E2,$20,$11,$E3,$90,$FE,$03,$DF,$95,$E3,$B0,$90,$B0,$41,$40
    .byte $70,$90,$B0,$90,$B0,$E2,$21,$20,$10,$20,$E3,$B0,$90,$B0,$41,$40
    .byte $70,$90,$B0,$90,$B0,$E2,$21,$20,$40,$60,$D6,$12,$E3,$B1,$B2,$E2
    .byte $12,$21,$E3,$B0,$E2,$41,$60,$90,$B0,$11,$11,$C0,$22,$41,$41,$20
    .byte $D6,$7F,$40,$40,$40,$D6,$12,$E3,$B1,$B2,$E2,$12,$21,$E3,$B0,$E2
    .byte $41,$60,$90,$B0,$11,$12,$22,$E2,$D6,$7F,$40,$40,$40,$40,$90,$90
    .byte $90,$90,$D6,$10,$E1,$60,$40,$E0,$10,$E1,$B0,$90,$80,$60,$40,$60
    .byte $40,$10,$E2,$B0,$E1,$10,$E2,$B0,$90,$80,$D6,$10,$E3,$B1,$B1,$B0
    .byte $E2,$11,$20,$E3,$B1,$E2,$10,$21,$E3,$60,$90,$A0,$B0,$B0,$B1,$B0
    .byte $D6,$1A,$E2,$12,$22,$D6,$10,$E3,$B0,$E2,$40,$D6,$7F,$60,$60,$60
    .byte $D6,$0F,$41,$40,$40,$41,$40,$40,$E3,$91,$90,$90,$91,$90,$90,$E2
    .byte $21,$20,$20,$21,$20,$20,$E3,$61,$60,$60,$40,$60,$80,$90,$B1,$B0
    .byte $B0,$FE,$04,$BC,$96,$E2,$21,$20,$20,$FE,$04,$C3,$96,$41,$40,$40
    .byte $41,$40,$40,$E3,$91,$90,$90,$91,$90,$90,$E2,$20,$20,$21,$D6,$20
    .byte $20,$41,$20,$D6,$3F,$63,$43,$D6,$10,$E2,$60,$60,$60,$60,$C1,$60
    .byte $60,$60,$60,$C0,$60,$C0,$D6,$2F,$42,$D6,$10,$20,$20,$20,$20,$C1
    .byte $20,$20,$20,$20,$C0,$20,$C0,$D6,$2F,$42,$D6,$10,$60,$60,$60,$60
    .byte $C1,$60,$60,$60,$60,$C0,$60,$C0,$D6,$2F,$42,$D6,$10,$20,$20,$20
    .byte $20,$C1,$20,$40,$60,$80,$90,$80,$C0,$D6,$2F,$42,$D6,$10,$60,$60
    .byte $60,$60,$C1,$60,$60,$60,$60,$C0,$60,$C0,$40,$60,$80,$20,$20,$20
    .byte $20,$C1,$20,$20,$20,$20,$C0,$20,$C0,$20,$20,$40,$60,$60,$60,$60
    .byte $C1,$60,$60,$60,$60,$C0,$60,$C0,$20,$40,$60,$40,$40,$40,$40,$C1
    .byte $40,$40,$40,$40,$C1,$C3,$CF,$C7,$D6,$10,$E3,$C0,$60,$C0,$80,$C0
    .byte $D6,$2F,$92,$FE,$FF,$DF,$95,$D6,$00,$00,$00,$00,$FE,$03,$75,$97
    .byte $40,$40,$30,$40,$30,$30,$30,$30,$20,$00,$30,$30,$00,$10,$00,$10
    .byte $20,$30,$30,$30,$30,$30,$30,$30,$20,$00,$30,$30,$00,$10,$00,$10
    .byte $20,$40,$30,$40,$FE,$03,$82,$97,$30,$30,$30,$30,$20,$00,$30,$30
    .byte $00,$10,$00,$10,$20,$30,$30,$30,$30,$30,$30,$30,$20,$00,$30,$30
    .byte $20,$20,$00,$20,$20,$00,$20,$20,$40,$00,$40,$30,$00,$20,$00,$30
    .byte $40,$10,$40,$10,$00,$30,$30,$30,$40,$00,$40,$30,$00,$40,$00,$30
    .byte $40,$10,$40,$10,$40,$40,$30,$30,$40,$00,$40,$30,$00,$40,$00,$30
    .byte $40,$10,$40,$10,$00,$30,$30,$30,$40,$00,$40,$30,$00,$40,$00,$30
    .byte $40,$10,$40,$10,$40,$40,$30,$40,$30,$00,$00,$00,$10,$00,$00,$00
    .byte $30,$00,$00,$00,$40,$00,$40,$40,$30,$30,$30,$30,$20,$00,$30,$30
    .byte $00,$10,$00,$10,$20,$30,$30,$30,$30,$30,$30,$30,$20,$00,$30,$30
    .byte $00,$10,$00,$10,$20,$30,$40,$40,$30,$30,$30,$30,$20,$00,$30,$30
    .byte $00,$10,$00,$10,$20,$30,$30,$30,$30,$30,$30,$30,$20,$00,$30,$30
    .byte $00,$10,$00,$10,$30,$40,$40,$40,$30,$30,$30,$30,$20,$00,$30,$30
    .byte $00,$10,$00,$10,$20,$30,$30,$30,$FE,$03,$56,$98,$40,$40,$40,$00
    .byte $40,$41,$40,$20,$01,$00,$20,$01,$00,$30,$30,$30,$30,$20,$00,$30
    .byte $30,$30,$10,$00,$10,$20,$31,$30,$FE,$03,$77,$98,$30,$30,$30,$30
    .byte $20,$00,$40,$40,$40,$20,$40,$20,$10,$40,$30,$30,$30,$30,$30,$30
    .byte $20,$00,$30,$30,$30,$10,$00,$10,$20,$31,$30,$FE,$03,$9A,$98,$40
    .byte $40,$40,$40,$10,$00,$40,$40,$40,$40,$C1,$C3,$33,$FE,$06,$B9,$98
    .byte $30,$40,$30,$40,$30,$40,$00,$30,$FE,$FF,$82,$97,$07,$06,$05,$04
    .byte $03,$03,$00,$00,$00,$02,$FF,$03,$04,$05,$06,$07,$07,$07,$06,$06
    .byte $06,$06,$05,$05,$05,$05,$04,$04,$04,$04,$03,$FF,$06,$07,$06,$05
    .byte $04,$03,$FF,$06,$07,$06,$05,$04,$03,$00,$00,$00,$00,$01,$FF,$04
    .byte $05,$06,$05,$04,$03,$FF,$04,$05,$04,$03,$FF,$03,$04,$03,$03,$03
    .byte $03,$00,$00,$00,$00,$01,$FF,$04,$05,$06,$05,$04,$03,$FF,$08,$07
    .byte $06,$05,$04,$03,$00,$00,$00,$00,$01,$FF,$FF,$D6,$35,$19,$03,$E2
    .byte $41,$D6,$F5,$1D,$02,$50,$71,$D6,$F5,$1C,$02,$92,$51,$D6,$F5,$1D
    .byte $02,$20,$E3,$B1,$D6,$F5,$1E,$04,$E3,$90,$E2,$70,$D6,$F8,$86,$0A
    .byte $E4,$92,$E3,$00,$E4,$90,$E3,$20,$20,$E4,$91,$E3,$00,$00,$E4,$92
    .byte $71,$60,$FE,$02,$29,$99,$D6,$F7,$1D,$02,$E2,$91,$70,$90,$B1,$90
    .byte $B0,$E1,$01,$E2,$B0,$E1,$00,$23,$E2,$B1,$70,$B0,$E1,$01,$E2,$B0
    .byte $E1,$00,$21,$00,$20,$43,$FF,$D6,$B8,$18,$01,$E3,$9F,$E2,$2F,$4F
    .byte $7F,$D6,$B8,$18,$00,$BF,$D6,$B3,$80,$01,$BF,$FD,$29,$99,$D6,$F8
    .byte $87,$00,$E4,$71,$E2,$40,$E4,$90,$90,$E2,$40,$E4,$90,$90,$E2,$20
    .byte $E4,$90,$90,$E2,$00,$E4,$90,$90,$E2,$41,$E4,$71,$E2,$40,$E4,$90
    .byte $90,$E2,$40,$E4,$90,$90,$E2,$20,$E4,$90,$90,$E2,$00,$E4,$90,$90
    .byte $E2,$41,$FD,$29,$99,$E8,$D6,$36,$85,$00,$E2,$90,$70,$40,$20,$40
    .byte $20,$00,$E3,$90,$E2,$00,$E3,$90,$70,$90,$C3,$C7,$E8,$D6,$F7,$1F
    .byte $02,$E3,$40,$40,$41,$51,$51,$D6,$36,$83,$02,$E2,$01,$00,$00,$00
    .byte $00,$20,$42,$21,$41,$61,$01,$00,$00,$00,$00,$20,$42,$21,$00,$E3
    .byte $B2,$E2,$01,$00,$00,$00,$00,$20,$42,$21,$41,$61,$00,$20,$40,$21
    .byte $40,$60,$41,$60,$70,$61,$70,$91,$FE,$FF,$99,$99,$D6,$F7,$19,$02
    .byte $E2,$91,$D6,$F7,$1A,$02,$B0,$E1,$01,$D6,$F7,$19,$02,$22,$E2,$B1
    .byte $D6,$F7,$1A,$02,$70,$41,$D6,$F7,$1B,$04,$E2,$90,$E1,$70,$65,$E2
    .byte $90,$E1,$60,$48,$FE,$02,$2A,$9A,$D6,$F7,$19,$03,$E1,$51,$20,$50
    .byte $71,$50,$70,$91,$70,$90,$B3,$71,$40,$70,$91,$70,$90,$B1,$90,$B0
    .byte $E0,$03,$FF,$D6,$F6,$17,$00,$E1,$70,$40,$60,$71,$70,$40,$60,$70
    .byte $40,$60,$71,$70,$40,$60,$FE,$06,$75,$9A,$FD,$2A,$9A,$D6,$F7,$1F
    .byte $02,$E3,$71,$E1,$90,$E2,$90,$90,$E1,$70,$E2,$90,$90,$E1,$60,$E2
    .byte $90,$90,$E1,$40,$E2,$90,$90,$E1,$71,$FE,$02,$8F,$9A,$FD,$2A,$9A
    .byte $D6,$F9,$87,$00,$E1,$90,$70,$40,$20,$40,$20,$00,$E2,$90,$E1,$00
    .byte $E2,$90,$70,$90,$C3,$C7,$D6,$F7,$1F,$02,$E3,$90,$90,$91,$81,$81
    .byte $D6,$F8,$85,$02,$E2,$91,$90,$90,$90,$90,$B0,$E1,$02,$E2,$B1,$E1
    .byte $01,$21,$E2,$91,$90,$90,$90,$90,$B0,$E1,$02,$E2,$B1,$90,$72,$91
    .byte $90,$90,$90,$90,$B0,$E1,$02,$E2,$B1,$E1,$01,$21,$E2,$40,$60,$70
    .byte $61,$70,$90,$71,$90,$B0,$91,$B0,$E1,$01,$FE,$FF,$88,$9A,$D6,$14
    .byte $E3,$91,$D6,$0E,$E2,$00,$E3,$90,$E2,$20,$20,$D6,$14,$E3,$91,$D6
    .byte $0E,$E2,$00,$00,$D6,$1B,$E3,$92,$D6,$0F,$71,$80,$FE,$04,$0C,$9B
    .byte $D6,$14,$E3,$51,$D6,$0E,$90,$50,$E2,$20,$20,$D6,$14,$E3,$91,$D6
    .byte $0E,$E2,$00,$00,$D6,$1B,$E3,$92,$D6,$0F,$51,$60,$D6,$15,$E3,$71
    .byte $D6,$0E,$B0,$70,$E2,$20,$20,$D6,$14,$E3,$B1,$D6,$0E,$E2,$00,$00
    .byte $D6,$1B,$E3,$92,$D6,$0F,$51,$60,$FF,$D6,$0D,$E2,$90,$FE,$60,$6A
    .byte $9B,$FD,$0C,$9B,$D6,$0F,$E3,$71,$E2,$90,$E3,$90,$90,$E2,$70,$E3
    .byte $90,$90,$E2,$60,$E3,$90,$90,$E2,$40,$E3,$90,$90,$E2,$71,$FE,$02
    .byte $72,$9B,$FD,$0C,$9B,$D6,$0F,$E2,$90,$70,$40,$20,$40,$20,$00,$E3
    .byte $90,$E2,$00,$E3,$90,$70,$90,$C3,$C7,$90,$90,$90,$C0,$B0,$C0,$B0
    .byte $C0,$D6,$0F,$E2,$91,$91,$CB,$91,$91,$C7,$71,$71,$91,$91,$CB,$E2
    .byte $90,$90,$90,$90,$C2,$01,$20,$40,$20,$20,$40,$61,$FE,$FF,$6F,$9B
    .byte $D6,$00,$FE,$50,$CF,$9B,$40,$FE,$10,$D4,$9B,$30,$10,$30,$30,$40
    .byte $30,$00,$30,$31,$30,$30,$40,$31,$30,$30,$10,$30,$30,$40,$30,$00
    .byte $30,$31,$30,$30,$40,$40,$00,$40,$FE,$07,$D9,$9B,$40,$40,$40,$40
    .byte $40,$40,$40,$40,$40,$40,$40,$40,$C3,$40,$42,$33,$40,$40,$40,$C0
    .byte $40,$30,$40,$30,$31,$31,$00,$00,$01,$00,$00,$01,$00,$02,$31,$31
    .byte $00,$00,$01,$00,$00,$01,$01,$01,$31,$31,$00,$00,$01,$00,$00,$01
    .byte $00,$02,$30,$30,$30,$30,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40
    .byte $41,$FE,$FF,$D9,$9B,$08,$07,$06,$05,$04,$00,$00,$00,$00,$00,$00
    .byte $01,$FF,$08,$07,$06,$05,$04,$03,$02,$01,$FF,$07,$06,$05,$04,$03
    .byte $02,$01,$00,$00,$00,$01,$FF,$04,$03,$02,$02,$02,$00,$00,$00,$00
    .byte $00,$01,$FF,$D6,$F7,$24,$00,$E2,$91,$E1,$21,$31,$20,$01,$E2,$A0
    .byte $E1,$01,$E2,$71,$91,$91,$E1,$21,$31,$20,$51,$30,$71,$E2,$71,$91
    .byte $D6,$35,$25,$00,$E1,$21,$91,$E0,$21,$E1,$91,$FE,$02,$92,$9C,$21
    .byte $51,$91,$91,$21,$51,$FF,$E8,$D6,$37,$26,$00,$E3,$41,$FE,$10,$AA
    .byte $9C,$E8,$D6,$F8,$86,$05,$E2,$50,$46,$D6,$36,$84,$0F,$81,$41,$81
    .byte $91,$FE,$04,$B0,$9C,$D6,$F8,$86,$05,$E2,$80,$76,$D6,$36,$84,$0F
    .byte $B1,$71,$B1,$E1,$01,$FE,$04,$C3,$9C,$D6,$F8,$86,$05,$E2,$B0,$A6
    .byte $D6,$36,$84,$0F,$E2,$21,$21,$21,$21,$D6,$F8,$86,$05,$E1,$10,$06
    .byte $D6,$36,$84,$0F,$E2,$41,$41,$41,$41,$FE,$02,$D7,$9C,$FD,$71,$9C
    .byte $91,$91,$FD,$71,$9C,$93,$FE,$FF,$B0,$9C,$D6,$F7,$24,$00,$E1,$21
    .byte $91,$A1,$90,$71,$50,$71,$01,$21,$21,$91,$A1,$90,$E0,$01,$E1,$A0
    .byte $E0,$01,$E1,$01,$2F,$C1,$D6,$35,$25,$00,$E1,$51,$91,$E0,$21,$01
    .byte $E1,$51,$91,$FF,$D6,$F7,$23,$00,$E4,$41,$FE,$10,$37,$9D,$D6,$F8
    .byte $86,$05,$E2,$90,$86,$D6,$37,$86,$00,$B1,$91,$B1,$E1,$01,$FE,$04
    .byte $3C,$9D,$D6,$F8,$86,$05,$E1,$00,$E2,$B6,$D6,$37,$86,$00,$E1,$21
    .byte $01,$21,$31,$FE,$04,$50,$9D,$D6,$F8,$86,$05,$E1,$30,$26,$D6,$37
    .byte $86,$00,$E2,$A1,$91,$A1,$E1,$01,$D6,$F8,$86,$05,$E1,$50,$46,$D6
    .byte $37,$86,$00,$E2,$A1,$91,$A1,$E1,$01,$FE,$02,$65,$9D,$FD,$08,$9D
    .byte $E0,$21,$01,$FD,$08,$9D,$E0,$23,$FE,$FF,$3C,$9D,$D6,$0E,$E2,$41
    .byte $FE,$10,$9D,$9D,$D6,$0E,$50,$D6,$20,$42,$D6,$0E,$41,$41,$41,$41
    .byte $41,$41,$FE,$04,$A2,$9D,$D6,$0E,$80,$D6,$20,$72,$D6,$0E,$71,$71
    .byte $71,$71,$71,$71,$FE,$04,$B4,$9D,$D6,$0E,$E2,$B0,$D6,$20,$A2,$D6
    .byte $0E,$A1,$A1,$A1,$A1,$A1,$A1,$E1,$10,$D6,$20,$02,$D6,$0E,$01,$01
    .byte $01,$01,$01,$01,$FE,$02,$C6,$9D,$D6,$0E,$E2,$21,$FE,$10,$E9,$9D
    .byte $21,$91,$FE,$08,$EE,$9D,$D6,$0E,$E2,$21,$FE,$10,$F7,$9D,$21,$91
    .byte $FE,$08,$FC,$9D,$FE,$FF,$A2,$9D,$30,$32,$31,$31,$31,$31,$41,$30
    .byte $00,$FE,$03,$06,$9E,$30,$32,$31,$31,$30,$00,$31,$30,$00,$31,$FF
    .byte $D6,$31,$FE,$10,$1F,$9E,$FD,$06,$9E,$FD,$06,$9E,$30,$32,$31,$31
    .byte $31,$31,$41,$30,$00,$FE,$03,$2A,$9E,$31,$31,$31,$31,$40,$40,$41
    .byte $40,$40,$41,$31,$31,$41,$31,$31,$31,$41,$30,$00,$FE,$03,$41,$9E
    .byte $31,$31,$41,$31,$41,$41,$41,$40,$40,$31,$31,$41,$31,$31,$31,$41
    .byte $30,$00,$FE,$03,$57,$9E,$31,$31,$41,$31,$41,$41,$40,$40,$41,$FE
    .byte $FF,$24,$9E,$08,$07,$06,$05,$04,$03,$00,$00,$00,$00,$01,$FF,$06
    .byte $07,$06,$05,$04,$03,$FF,$05,$04,$03,$03,$03,$03,$00,$00,$00,$00
    .byte $01,$FF,$08,$07,$06,$05,$04,$03,$03,$00,$00,$00,$01,$FF,$06,$05
    .byte $04,$03,$02,$00,$00,$00,$00,$00,$01,$FF,$E8,$D6,$F9,$87,$00,$E3
    .byte $C8,$D6,$F9,$87,$00,$E3,$70,$80,$A0,$D6,$37,$84,$05,$E2,$08,$00
    .byte $10,$30,$71,$56,$50,$30,$10,$31,$19,$31,$13,$E3,$A1,$73,$E2,$08
    .byte $00,$10,$30,$71,$56,$50,$30,$10,$31,$13,$D6,$38,$86,$04,$E2,$81
    .byte $73,$E2,$31,$13,$E3,$A1,$73,$D6,$37,$21,$00,$E2,$01,$00,$D6,$B7
    .byte $21,$00,$E3,$32,$62,$02,$FE,$04,$E5,$9E,$D6,$37,$21,$00,$E3,$71
    .byte $70,$D6,$B7,$21,$00,$E3,$A2,$E2,$12,$E3,$72,$FE,$03,$F8,$9E,$D6
    .byte $37,$21,$00,$E2,$71,$70,$D6,$F7,$21,$00,$E3,$A2,$E2,$80,$80,$80
    .byte $A0,$A0,$A0,$D6,$F4,$82,$00,$E0,$51,$00,$E1,$80,$E0,$00,$E1,$80
    .byte $50,$80,$50,$00,$50,$00,$E2,$80,$E1,$50,$00,$E2,$80,$E1,$00,$E2
    .byte $80,$50,$80,$50,$FE,$FF,$AF,$9E,$D6,$F9,$87,$04,$E2,$C8,$D6,$F8
    .byte $85,$05,$E2,$00,$10,$30,$E2,$58,$50,$70,$80,$E1,$01,$E2,$A6,$A0
    .byte $80,$70,$81,$79,$81,$73,$31,$03,$FE,$02,$54,$9F,$D6,$F7,$21,$00
    .byte $E2,$51,$50,$E3,$32,$62,$02,$FE,$04,$6E,$9F,$E1,$01,$00,$E3,$A2
    .byte $E2,$12,$E3,$72,$FE,$03,$79,$9F,$E1,$01,$00,$E3,$A2,$E1,$10,$10
    .byte $10,$30,$30,$30,$D6,$F7,$83,$00,$E0,$50,$00,$E1,$80,$E0,$00,$E1
    .byte $80,$50,$80,$50,$00,$50,$00,$E2,$80,$E1,$50,$00,$E2,$80,$E1,$00
    .byte $E2,$80,$50,$80,$50,$00,$FE,$FF,$4C,$9F,$D6,$0E,$E2,$C8,$D6,$0E
    .byte $E2,$00,$10,$30,$50,$C0,$50,$FE,$0F,$C2,$9F,$00,$10,$30,$50,$C0
    .byte $50,$FE,$0F,$CC,$9F,$00,$10,$30,$D6,$12,$E2,$52,$32,$62,$02,$FE
    .byte $04,$D8,$9F,$E2,$02,$E3,$A2,$E2,$12,$E3,$72,$FE,$03,$E1,$9F,$E2
    .byte $01,$00,$E3,$A2,$D6,$10,$E2,$10,$10,$10,$30,$30,$30,$D6,$90,$5B
    .byte $38,$FE,$FF,$BC,$9F,$D6,$20,$FE,$09,$04,$A0,$D6,$40,$40,$40,$31
    .byte $30,$40,$00,$00,$31,$30,$40,$30,$30,$FE,$03,$0D,$A0,$31,$30,$40
    .byte $00,$00,$31,$30,$40,$40,$40,$31,$30,$40,$00,$00,$31,$30,$40,$30
    .byte $30,$FE,$03,$25,$A0,$31,$30,$40,$00,$00,$31,$30,$40,$40,$40,$31
    .byte $30,$40,$00,$00,$31,$00,$40,$00,$00,$FE,$07,$3D,$A0,$31,$30,$40
    .byte $30,$30,$40,$40,$40,$40,$40,$40,$30,$00,$00,$FE,$06,$56,$A0,$40
    .byte $40,$40,$FE,$FF,$09,$A0,$07,$06,$05,$04,$03,$03,$03,$03,$00,$00
    .byte $00,$00,$01,$FF,$05,$04,$03,$03,$03,$03,$03,$03,$00,$00,$00,$00
    .byte $01,$FF,$05,$06,$07,$06,$05,$04,$03,$FF,$0B,$0A,$09,$08,$07,$06
    .byte $05,$04,$03,$FF,$DC,$F7,$29,$02,$E1,$1D,$7D,$3D,$9D,$D7,$37,$28
    .byte $00,$E3,$A2,$E2,$32,$A1,$E1,$31,$E2,$01,$E1,$53,$E8,$D7,$B9,$87
    .byte $00,$E3,$00,$50,$50,$E2,$00,$E1,$00,$E2,$00,$E8,$FE,$02,$9B,$A0
    .byte $E8,$D7,$34,$82,$00,$E2,$A1,$E2,$A0,$E1,$A0,$80,$60,$50,$30,$10
    .byte $00,$E2,$A0,$80,$FE,$02,$C5,$A0,$E2,$A0,$E1,$A0,$80,$60,$50,$30
    .byte $10,$00,$E8,$E8,$D7,$FA,$88,$00,$E3,$00,$E2,$00,$FE,$03,$E6,$A0
    .byte $D7,$F7,$85,$00,$E4,$A0,$E3,$A0,$E4,$A1,$A1,$D7,$FA,$88,$00,$E3
    .byte $00,$E2,$00,$FE,$03,$FD,$A0,$D7,$F7,$85,$00,$E4,$90,$E3,$90,$E4
    .byte $91,$91,$D7,$FA,$88,$00,$E3,$00,$E2,$00,$FE,$03,$14,$A1,$D7,$F7
    .byte $85,$00,$E4,$80,$E3,$80,$E4,$81,$81,$D7,$37,$84,$00,$E2,$30,$E3
    .byte $A0,$70,$E2,$20,$E3,$90,$60,$E2,$10,$E3,$80,$60,$E2,$00,$E3,$60
    .byte $30,$D7,$FA,$88,$00,$E3,$00,$E2,$00,$FE,$03,$43,$A1,$D7,$F7,$85
    .byte $00,$E4,$A0,$E3,$A0,$E4,$A1,$A1,$D7,$FA,$88,$00,$E3,$00,$E2,$00
    .byte $FE,$03,$5A,$A1,$D7,$F7,$85,$00,$E4,$90,$E3,$90,$E4,$91,$91,$E8
    .byte $D7,$F6,$84,$02,$E3,$80,$80,$80,$80,$80,$80,$81,$80,$A2,$E2,$80
    .byte $80,$80,$80,$80,$80,$81,$A1,$E1,$30,$70,$60,$60,$60,$30,$30,$30
    .byte $60,$60,$20,$20,$50,$50,$10,$10,$60,$60,$60,$30,$30,$30,$80,$80
    .byte $50,$50,$A0,$E0,$12,$FE,$FF,$9B,$A0,$DC,$F7,$29,$02,$E1,$6D,$E0
    .byte $0D,$E1,$8D,$E0,$2D,$D7,$F7,$27,$00,$E2,$32,$62,$E1,$31,$61,$E2
    .byte $51,$E1,$93,$D7,$3B,$89,$00,$E4,$00,$50,$50,$E3,$00,$E2,$00,$E3
    .byte $00,$FE,$02,$B3,$A1,$D7,$39,$86,$00,$E2,$A0,$E1,$A0,$80,$60,$50
    .byte $30,$10,$00,$E2,$A0,$80,$FE,$03,$D3,$A1,$D7,$37,$2A,$04,$E1,$75
    .byte $D7,$FA,$87,$00,$E4,$A0,$E3,$A0,$E4,$A1,$A1,$D7,$37,$2A,$04,$E1
    .byte $65,$D7,$FA,$87,$00,$E4,$90,$E3,$90,$E4,$91,$91,$D7,$37,$2A,$04
    .byte $E1,$55,$D7,$FA,$87,$00,$E4,$80,$E3,$80,$E4,$81,$81,$D7,$FB,$8A
    .byte $00,$E1,$30,$E3,$A0,$70,$E2,$20,$E3,$90,$60,$E2,$10,$E3,$80,$60
    .byte $E2,$00,$E3,$60,$30,$D7,$37,$2A,$04,$E1,$75,$D7,$FA,$87,$00,$E4
    .byte $A0,$E3,$A0,$E4,$A1,$A1,$D7,$37,$2A,$04,$E1,$65,$D7,$FA,$87,$00
    .byte $E4,$90,$E3,$90,$E4,$91,$91,$D7,$F8,$86,$02,$E2,$10,$10,$10,$10
    .byte $10,$10,$11,$10,$32,$E1,$10,$10,$10,$10,$10,$10,$11,$31,$70,$A0
    .byte $E0,$30,$30,$30,$E1,$A0,$A0,$A0,$E0,$20,$20,$E1,$A0,$A0,$E0,$10
    .byte $10,$E1,$80,$80,$E0,$30,$30,$30,$E1,$A0,$A0,$A0,$E0,$50,$50,$00
    .byte $00,$60,$82,$FE,$FF,$B3,$A1,$D7,$12,$E2,$33,$43,$33,$43,$33,$43
    .byte $FE,$04,$95,$A2,$D7,$0F,$E2,$00,$E1,$00,$FE,$16,$A2,$A2,$D7,$20
    .byte $E1,$12,$02,$D7,$12,$E2,$A1,$81,$D7,$20,$A2,$82,$D7,$12,$61,$51
    .byte $D7,$20,$62,$52,$D7,$12,$31,$11,$D7,$0E,$E2,$00,$E1,$00,$E2,$00
    .byte $E1,$00,$E2,$00,$E1,$00,$D7,$90,$E1,$05,$FE,$03,$C6,$A2,$D7,$17
    .byte $E1,$30,$E2,$A0,$70,$E1,$20,$E2,$90,$60,$E1,$10,$E2,$80,$60,$E1
    .byte $00,$E2,$60,$30,$D7,$0E,$E2,$00,$E1,$00,$E2,$00,$E1,$00,$E2,$00
    .byte $E1,$00,$D7,$90,$E1,$05,$FE,$02,$F2,$A2,$D7,$0E,$E2,$10,$E1,$10
    .byte $FE,$0C,$0A,$A3,$D7,$2F,$E2,$32,$32,$21,$21,$D7,$10,$10,$10,$10
    .byte $10,$D7,$2F,$32,$32,$51,$51,$D7,$10,$60,$80,$80,$80,$FE,$FF,$A2
    .byte $A2,$D7,$33,$FE,$16,$30,$A3,$40,$40,$40,$40,$40,$40,$40,$30,$30
    .byte $30,$30,$30,$00,$00,$40,$00,$30,$00,$40,$00,$40,$00,$00,$00,$30
    .byte $30,$40,$40,$40,$40,$FE,$02,$3D,$A3,$30,$00,$00,$30,$00,$00,$40
    .byte $00,$30,$00,$FE,$02,$57,$A3,$30,$00,$00,$30,$00,$00,$40,$40,$40
    .byte $40,$30,$30,$30,$30,$30,$30,$40,$40,$40,$30,$40,$30,$FE,$03,$6F
    .byte $A3,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$30,$30,$30
    .byte $30,$30,$30,$40,$40,$40,$30,$40,$30,$30,$30,$30,$30,$30,$30,$40
    .byte $40,$40,$40,$40,$40,$30,$30,$30,$40,$30,$30,$30,$00,$30,$40,$30
    .byte $30,$30,$30,$30,$40,$30,$30,$30,$00,$30,$40,$40,$40,$40,$30,$30
    .byte $40,$30,$30,$40,$30,$40,$30,$40,$40,$40,$40,$40,$30,$30,$40,$30
    .byte $30,$40,$30,$40,$30,$40,$40,$40,$30,$FE,$FF,$3D,$A3,$07,$07,$06
    .byte $05,$04,$03,$00,$00,$00,$01,$01,$01,$FF,$07,$06,$05,$04,$03,$FF
    .byte $03,$04,$05,$04,$03,$02,$FF,$06,$07,$06,$05,$04,$03,$00,$00,$00
    .byte $00,$01,$01,$FF,$07,$06,$05,$04,$03,$00,$00,$00,$00,$00,$01,$01
    .byte $FF,$05,$04,$03,$03,$03,$00,$00,$00,$00,$00,$01,$01,$FF,$D6,$35
    .byte $08,$02,$E2,$41,$41,$D6,$35,$0A,$01,$71,$41,$B2,$92,$71,$FE,$03
    .byte $1C,$A4,$D6,$35,$08,$02,$E2,$41,$41,$D6,$35,$0A,$01,$71,$41,$92
    .byte $B2,$E1,$01,$D6,$F7,$08,$02,$E2,$51,$51,$D6,$35,$0A,$01,$91,$51
    .byte $E1,$02,$E2,$B2,$91,$FE,$03,$41,$A4,$D6,$F7,$08,$02,$51,$51,$D6
    .byte $35,$0A,$01,$91,$51,$B2,$E1,$02,$11,$FF,$EC,$01,$D6,$F7,$08,$02
    .byte $E2,$41,$41,$D6,$F5,$0A,$01,$71,$41,$B2,$92,$71,$FE,$03,$68,$A4
    .byte $D6,$F7,$08,$02,$E2,$41,$41,$D6,$F5,$0A,$01,$71,$41,$92,$B2,$E1
    .byte $01,$D6,$F7,$08,$02,$E2,$51,$51,$D6,$F5,$0A,$01,$91,$51,$E1,$02
    .byte $E2,$B2,$91,$FE,$03,$8F,$A4,$D6,$F7,$08,$02,$51,$51,$D6,$F5,$0A
    .byte $01,$91,$51,$B2,$E1,$02,$11,$D6,$37,$0B,$02,$E2,$00,$01,$E3,$B4
    .byte $D6,$F7,$0D,$03,$E2,$91,$91,$B3,$D6,$37,$0B,$02,$E3,$90,$91,$B4
    .byte $D6,$F7,$0D,$03,$E1,$01,$01,$23,$D6,$37,$0B,$02,$E2,$00,$01,$E3
    .byte $B4,$D6,$F7,$0D,$03,$E1,$41,$41,$53,$D6,$37,$0B,$02,$E3,$90,$91
    .byte $B4,$D6,$F7,$0D,$02,$E1,$90,$92,$90,$92,$FD,$1C,$A4,$D6,$35,$84
    .byte $08,$E3,$73,$43,$83,$43,$FE,$04,$FB,$A4,$71,$71,$41,$41,$81,$81
    .byte $41,$41,$FE,$04,$08,$A5,$FD,$1C,$A4,$FE,$FF,$B5,$A4,$D6,$F7,$08
    .byte $02,$E2,$91,$91,$D6,$F7,$09,$01,$E1,$01,$E2,$91,$E1,$32,$22,$01
    .byte $FE,$03,$1B,$A5,$D6,$F7,$08,$02,$E2,$91,$91,$D6,$F7,$09,$01,$E1
    .byte $01,$E2,$91,$E1,$22,$32,$41,$D6,$F7,$08,$02,$E2,$B1,$B1,$D6,$F7
    .byte $09,$01,$E1,$21,$E2,$B1,$E1,$52,$42,$21,$FE,$03,$45,$A5,$D6,$F7
    .byte $08,$02,$E2,$B1,$B1,$D6,$F7,$09,$01,$E1,$21,$E2,$B1,$E1,$42,$52
    .byte $61,$FF,$EC,$01,$FD,$1B,$A5,$D6,$F7,$0B,$02,$E2,$50,$51,$44,$D6
    .byte $B7,$0C,$03,$E1,$21,$21,$43,$D6,$F7,$0B,$02,$E2,$20,$21,$44,$D6
    .byte $B7,$0C,$03,$E1,$51,$51,$73,$D6,$F7,$0B,$02,$E2,$50,$51,$44,$D6
    .byte $B7,$0C,$03,$E1,$91,$91,$B3,$D6,$F7,$0B,$02,$E2,$20,$21,$44,$D6
    .byte $B7,$0C,$03,$E0,$20,$22,$40,$42,$FD,$1B,$A5,$D6,$38,$87,$08,$E2
    .byte $03,$E3,$93,$E2,$13,$E3,$93,$FE,$04,$B9,$A5,$E2,$01,$01,$E3,$91
    .byte $91,$E2,$11,$11,$E3,$91,$91,$FE,$04,$C9,$A5,$FE,$FF,$70,$A5,$D6
    .byte $10,$E3,$91,$FE,$20,$E0,$A5,$B1,$FE,$20,$E5,$A5,$FF,$EC,$01,$D6
    .byte $10,$E2,$91,$91,$CB,$FE,$04,$EB,$A5,$E3,$B1,$FE,$20,$F7,$A5,$D6
    .byte $10,$E2,$50,$50,$C0,$D6,$7F,$44,$D6,$10,$21,$21,$43,$20,$20,$C0
    .byte $D6,$7F,$44,$D6,$10,$51,$51,$73,$50,$50,$C0,$D6,$7F,$44,$D6,$10
    .byte $91,$91,$B3,$20,$20,$C0,$D6,$7F,$44,$D6,$10,$20,$22,$40,$42,$FD
    .byte $DD,$A5,$D6,$15,$E2,$03,$93,$13,$93,$FE,$04,$30,$A6,$01,$01,$91
    .byte $91,$11,$11,$91,$91,$FE,$04,$3B,$A6,$FD,$DD,$A5,$FE,$FF,$FD,$A5
    .byte $31,$01,$41,$01,$31,$31,$41,$01,$FE,$03,$4E,$A6,$31,$01,$41,$01
    .byte $31,$31,$41,$40,$40,$31,$01,$41,$01,$31,$31,$41,$01,$FE,$03,$63
    .byte $A6,$31,$01,$41,$01,$40,$40,$41,$41,$40,$40,$FF,$D6,$31,$31,$03
    .byte $03,$03,$FE,$03,$7A,$A6,$31,$31,$33,$33,$40,$40,$41,$31,$01,$41
    .byte $01,$31,$31,$41,$01,$FE,$03,$8B,$A6,$31,$01,$41,$01,$31,$31,$41
    .byte $40,$40,$40,$40,$30,$40,$00,$00,$31,$31,$31,$41,$00,$00,$FE,$03
    .byte $A0,$A6,$40,$40,$30,$40,$00,$00,$31,$40,$40,$00,$00,$40,$40,$00
    .byte $00,$FD,$4E,$A6,$31,$31,$41,$01,$31,$31,$41,$01,$31,$01,$41,$01
    .byte $31,$31,$41,$01,$31,$31,$41,$01,$31,$31,$41,$01,$31,$01,$41,$01
    .byte $31,$31,$40,$40,$40,$40,$31,$31,$41,$31,$FE,$03,$E4,$A6,$31,$31
    .byte $41,$41,$31,$31,$41,$31,$FE,$03,$F0,$A6,$40,$40,$41,$40,$40,$40
    .byte $40,$FD,$4E,$A6,$FE,$FF,$A0,$A6,$05,$06,$05,$04,$03,$02,$00,$00
    .byte $00,$00,$00,$01,$FF,$0C,$0B,$0A,$09,$08,$07,$06,$FF,$08,$07,$06
    .byte $05,$04,$03,$03,$00,$00,$00,$00,$01,$FF,$0A,$09,$08,$07,$06,$05
    .byte $04,$00,$00,$00,$00,$01,$FF,$E4,$60,$80,$60,$90,$60,$80,$60,$80
    .byte $60,$B0,$60,$80,$FE,$02,$35,$A7,$E4,$80,$90,$80,$B0,$80,$90,$80
    .byte $90,$80,$E3,$10,$E4,$80,$90,$FE,$02,$46,$A7,$E4,$90,$B0,$90,$E3
    .byte $10,$E4,$90,$B0,$90,$B0,$90,$E3,$10,$E4,$90,$B0,$FE,$02,$59,$A7
    .byte $E4,$B0,$E3,$10,$E4,$B0,$E3,$20,$E4,$B0,$E3,$10,$E4,$B0,$E3,$10
    .byte $E4,$B0,$E3,$20,$E4,$B0,$E3,$10,$10,$20,$10,$40,$10,$20,$10,$40
    .byte $10,$50,$10,$80,$FF,$D7,$36,$0E,$00,$E2,$60,$61,$60,$90,$80,$63
    .byte $40,$50,$E2,$60,$E3,$61,$60,$E2,$90,$80,$91,$81,$41,$80,$81,$80
    .byte $B0,$90,$83,$60,$70,$E2,$80,$E3,$81,$80,$E2,$B0,$90,$B1,$91,$81
    .byte $90,$91,$90,$E1,$10,$E2,$B0,$93,$E2,$70,$80,$90,$E3,$91,$90,$E1
    .byte $10,$E2,$B0,$E1,$11,$E2,$B1,$91,$B0,$B1,$B0,$E1,$20,$10,$E2,$B3
    .byte $E2,$B0,$E1,$00,$10,$E2,$11,$10,$E1,$40,$50,$11,$51,$81,$FE,$02
    .byte $93,$A7,$E8,$D7,$38,$2F,$00,$E2,$20,$21,$E3,$B0,$B1,$D7,$38,$87
    .byte $00,$E2,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$10,$20,$20
    .byte $20,$20,$20,$20,$D7,$38,$2F,$00,$E2,$20,$21,$80,$81,$E1,$10,$10
    .byte $10,$10,$10,$10,$10,$10,$10,$10,$10,$E2,$B0,$E1,$10,$10,$10,$10
    .byte $10,$10,$E2,$60,$61,$40,$41,$D7,$38,$87,$00,$E2,$20,$20,$20,$20
    .byte $20,$20,$20,$20,$20,$20,$20,$10,$20,$20,$20,$20,$20,$20,$D7,$36
    .byte $2F,$00,$E2,$20,$21,$80,$81,$E1,$10,$10,$10,$10,$10,$10,$10,$10
    .byte $10,$10,$10,$10,$40,$40,$40,$40,$40,$40,$D7,$F6,$2F,$00,$E8,$E1
    .byte $60,$60,$60,$60,$61,$C5,$FE,$FF,$93,$A7,$D7,$F8,$2E,$00,$FD,$35
    .byte $A7,$FD,$35,$A7,$D7,$F8,$30,$00,$E2,$60,$61,$40,$41,$D7,$F8,$87
    .byte $00,$E1,$60,$60,$60,$60,$60,$60,$80,$80,$80,$80,$80,$80,$90,$90
    .byte $90,$90,$90,$90,$B0,$B0,$B0,$B0,$B0,$B0,$60,$60,$60,$60,$60,$60
    .byte $80,$80,$80,$80,$80,$80,$90,$90,$90,$90,$90,$90,$E0,$10,$10,$10
    .byte $10,$10,$10,$E1,$60,$60,$60,$60,$60,$60,$80,$80,$80,$80,$80,$80
    .byte $90,$90,$90,$90,$90,$90,$B0,$B0,$B0,$B0,$B0,$B0,$60,$60,$60,$60
    .byte $60,$60,$80,$80,$80,$80,$80,$80,$90,$90,$90,$90,$90,$90,$E0,$10
    .byte $10,$10,$10,$D7,$F8,$30,$00,$11,$C5,$FE,$FF,$78,$A8,$D7,$12,$E2
    .byte $60,$60,$C0,$60,$90,$80,$D7,$7F,$63,$D7,$10,$40,$50,$E2,$60,$D7
    .byte $12,$E3,$61,$60,$E2,$90,$80,$D1,$2F,$E2,$80,$DD,$28,$90,$D7,$28
    .byte $81,$41,$D7,$12,$80,$80,$C0,$80,$B0,$90,$D7,$7F,$83,$D7,$10,$60
    .byte $70,$E2,$80,$D7,$12,$E3,$81,$80,$E2,$B0,$90,$D7,$2F,$B1,$91,$81
    .byte $D7,$12,$90,$90,$C0,$90,$E1,$10,$E2,$B0,$D7,$7F,$93,$D7,$10,$E2
    .byte $70,$80,$90,$E3,$91,$90,$E1,$10,$E2,$B0,$D7,$2F,$E1,$11,$E2,$B1
    .byte $91,$D7,$12,$B0,$B0,$C0,$B0,$E1,$20,$10,$D7,$7F,$E2,$B3,$D7,$10
    .byte $E2,$B0,$E1,$00,$10,$D7,$12,$E2,$11,$10,$E1,$40,$50,$D7,$2F,$11
    .byte $51,$81,$FE,$02,$FB,$A8,$D7,$12,$E2,$60,$61,$40,$41,$D7,$10,$E2
    .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$10,$20,$20,$20,$20
    .byte $20,$20,$D7,$12,$E2,$20,$21,$80,$81,$D7,$10,$60,$60,$60,$60,$60
    .byte $60,$60,$60,$60,$60,$60,$40,$60,$60,$60,$60,$60,$60,$D7,$12,$E2
    .byte $60,$61,$40,$41,$D7,$10,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
    .byte $20,$10,$20,$20,$20,$20,$20,$20,$D7,$12,$20,$21,$80,$81,$D7,$0F
    .byte $60,$60,$60,$60,$60,$60,$80,$80,$80,$80,$80,$80,$90,$90,$90,$90
    .byte $90,$90,$D7,$0F,$60,$60,$60,$60,$60,$C0,$C5,$FE,$FF,$FB,$A8,$40
    .byte $40,$00,$40,$40,$00,$40,$40,$40,$40,$40,$30,$FE,$03,$03,$AA,$FF
    .byte $D7,$30,$40,$10,$30,$40,$30,$30,$10,$00,$10,$40,$40,$30,$40,$10
    .byte $30,$40,$30,$40,$30,$40,$30,$40,$40,$FE,$07,$0E,$AA,$30,$40,$10
    .byte $30,$40,$30,$30,$10,$00,$10,$40,$40,$30,$40,$10,$30,$40,$30,$40
    .byte $40,$40,$40,$40,$40,$FD,$FD,$A9,$FD,$FD,$A9,$FD,$FD,$A9,$FD,$FD
    .byte $A9,$40,$40,$40,$40,$40,$00,$40,$30,$40,$30,$40,$40,$FE,$FF,$0E
    .byte $AA,$08,$07,$06,$05,$04,$03,$03,$00,$00,$00,$00,$01,$FF,$06,$07
    .byte $06,$05,$04,$03,$FF,$04,$05,$04,$03,$FF,$09,$08,$07,$06,$05,$04
    .byte $03,$00,$00,$00,$00,$01,$FF,$08,$07,$06,$05,$04,$03,$03,$00,$00
    .byte $00,$00,$01,$FF,$D7,$F7,$35,$00,$E1,$C0,$10,$10,$10,$12,$30,$30
    .byte $30,$30,$E2,$B0,$B0,$B0,$B1,$D7,$F7,$0F,$00,$E2,$40,$50,$90,$D7
    .byte $F7,$11,$02,$BD,$FF,$D7,$F7,$16,$00,$E1,$C0,$40,$40,$40,$42,$60
    .byte $60,$60,$60,$20,$20,$20,$21,$D7,$F7,$0F,$00,$E2,$90,$B0,$E1,$20
    .byte $D7,$F7,$10,$02,$4D,$FF,$D7,$10,$E2,$C0,$90,$90,$90,$90,$C1,$B0
    .byte $B0,$B0,$B0,$70,$70,$70,$70,$C0,$E3,$70,$90,$E2,$00,$D7,$90,$4D
    .byte $FF,$D7,$C0,$40,$40,$40,$40,$11,$40,$40,$40,$40,$40,$40,$40,$40
    .byte $C0,$30,$40,$40,$40,$FF,$08,$07,$06,$05,$04,$03,$03,$00,$00,$00
    .byte $00,$01,$FF,$06,$05,$04,$03,$03,$03,$03,$00,$00,$00,$00,$01,$FF
    .byte $05,$04,$03,$02,$02,$02,$00,$00,$00,$01,$FF,$08,$07,$06,$05,$04
    .byte $03,$00,$00,$00,$01,$FF,$E8,$D7,$B7,$12,$02,$E2,$C0,$41,$42,$D7
    .byte $F7,$13,$02,$70,$90,$B0,$40,$41,$22,$03,$E1,$00,$20,$45,$E2,$22
    .byte $32,$41,$E8,$D7,$F3,$14,$00,$E1,$41,$11,$E2,$A1,$97,$FF,$D7,$F8
    .byte $12,$02,$E2,$C0,$91,$92,$70,$90,$B0,$90,$91,$72,$53,$D7,$38,$12
    .byte $02,$E1,$00,$20,$45,$D7,$F8,$12,$02,$E2,$72,$82,$91,$D7,$37,$15
    .byte $00,$E0,$41,$11,$E1,$A1,$97,$FF,$D7,$10,$E2,$C0,$90,$C0,$90,$C0
    .byte $C0,$E3,$70,$90,$B0,$90,$91,$72,$D7,$7F,$53,$D7,$2F,$E2,$00,$20
    .byte $D7,$7F,$45,$D7,$10,$E3,$72,$82,$91,$D7,$0F,$E2,$41,$11,$E3,$A1
    .byte $D7,$90,$97,$FF,$D7,$C0,$30,$00,$31,$C0,$00,$00,$00,$40,$40,$30
    .byte $40,$40,$30,$43,$00,$00,$05,$30,$00,$00,$30,$00,$00,$31,$D7,$01
    .byte $01,$01,$01,$FF,$07,$08,$07,$06,$05,$04,$03,$FF,$07,$06,$05,$04
    .byte $03,$03,$03,$03,$03,$03,$00,$00,$00,$00,$01,$FF,$FF,$FF,$D6,$37
    .byte $85,$03,$E2,$75,$E4,$00,$00,$01,$01,$C1,$E2,$77,$E4,$00,$00,$01
    .byte $01,$C1,$E2,$B7,$E4,$00,$00,$E2,$52,$72,$91,$47,$07,$E2,$57,$52
    .byte $42,$21,$07,$E3,$42,$52,$71,$E2,$25,$70,$90,$77,$E3,$B7,$B2,$E2
    .byte $02,$21,$E2,$75,$E4,$00,$00,$01,$01,$C1,$E2,$77,$E4,$00,$00,$01
    .byte $01,$C1,$E2,$B7,$E4,$00,$00,$E2,$52,$72,$91,$47,$07,$27,$22,$02
    .byte $E3,$B1,$E2,$07,$42,$52,$71,$E2,$25,$20,$40,$27,$70,$90,$B1,$90
    .byte $B0,$E1,$01,$E2,$57,$D6,$37,$32,$00,$E1,$01,$01,$E2,$B1,$E1,$03
    .byte $01,$E2,$B1,$E1,$01,$E2,$B1,$B1,$91,$B3,$B1,$91,$B1,$91,$91,$71
    .byte $91,$D6,$37,$85,$03,$92,$B2,$E1,$01,$D6,$37,$84,$08,$43,$23,$03
    .byte $E2,$B3,$D6,$37,$32,$00,$E1,$21,$21,$01,$23,$21,$01,$21,$21,$21
    .byte $11,$23,$21,$11,$21,$21,$21,$01,$21,$D6,$37,$85,$03,$22,$42,$51
    .byte $FF,$E8,$FD,$EC,$AB,$E1,$47,$57,$FD,$EC,$AB,$E1,$47,$5F,$FF,$D6
    .byte $F8,$31,$03,$E2,$77,$72,$E1,$22,$09,$02,$52,$49,$92,$B2,$E0,$01
    .byte $E1,$77,$47,$97,$92,$72,$51,$47,$42,$22,$01,$E2,$7F,$27,$42,$52
    .byte $71,$E2,$77,$72,$E1,$22,$09,$02,$52,$49,$92,$B2,$E0,$01,$E1,$77
    .byte $47,$57,$52,$42,$21,$47,$42,$22,$01,$E2,$75,$70,$90,$77,$B0,$E1
    .byte $00,$21,$00,$20,$41,$D6,$F8,$31,$03,$E1,$97,$79,$53,$41,$59,$43
    .byte $21,$07,$02,$22,$41,$D6,$F9,$85,$08,$E1,$93,$73,$53,$43,$D6,$F8
    .byte $31,$03,$9F,$77,$72,$52,$41,$57,$52,$72,$91,$FF,$FD,$AD,$AC,$77
    .byte $B7,$FD,$AD,$AC,$77,$BF,$FF,$D6,$7F,$E2,$05,$D6,$0E,$00,$00,$01
    .byte $01,$C1,$00,$00,$FE,$03,$25,$AD,$D6,$7F,$05,$D6,$0E,$00,$00,$41
    .byte $41,$C1,$41,$D6,$7F,$55,$D6,$0E,$50,$50,$51,$51,$C1,$50,$50,$D6
    .byte $7F,$45,$D6,$0E,$40,$40,$41,$41,$C1,$40,$40,$D6,$7F,$75,$D6,$0E
    .byte $70,$70,$71,$71,$C1,$70,$70,$FE,$02,$59,$AD,$D6,$7F,$E2,$05,$D6
    .byte $0E,$00,$00,$01,$01,$C1,$00,$00,$FE,$03,$69,$AD,$D6,$7F,$05,$D6
    .byte $0E,$00,$00,$41,$41,$C1,$41,$D6,$7F,$55,$D6,$0E,$50,$50,$51,$51
    .byte $C1,$50,$50,$D6,$7F,$45,$D6,$0E,$40,$40,$41,$41,$C1,$40,$40,$D6
    .byte $7F,$75,$D6,$0E,$70,$70,$71,$71,$C1,$70,$70,$FE,$02,$9D,$AD,$D6
    .byte $7F,$E2,$05,$D6,$0E,$00,$00,$01,$01,$C1,$00,$00,$D6,$7F,$E3,$B5
    .byte $D6,$0E,$B0,$B0,$B1,$B1,$C1,$B0,$B0,$D6,$7F,$A5,$D6,$0E,$A0,$A0
    .byte $A1,$A1,$C1,$A0,$A0,$D6,$7F,$95,$D6,$0E,$90,$90,$91,$91,$C1,$90
    .byte $90,$D6,$7F,$E2,$25,$D6,$0E,$20,$20,$21,$21,$C1,$20,$20,$D6,$7F
    .byte $15,$D6,$0E,$10,$10,$11,$11,$C1,$10,$10,$D6,$7F,$25,$D6,$0E,$20
    .byte $20,$21,$21,$C1,$20,$20,$FF,$FD,$25,$AD,$D6,$7F,$E3,$B5,$D6,$0E
    .byte $B0,$B0,$E2,$71,$71,$C1,$71,$FD,$25,$AD,$D6,$90,$E3,$BF,$B7,$FF
    .byte $D6,$31,$01,$41,$00,$00,$31,$31,$41,$01,$FE,$03,$1E,$AE,$31,$01
    .byte $41,$00,$00,$31,$41,$01,$40,$40,$31,$01,$41,$00,$00,$31,$31,$41
    .byte $01,$FE,$03,$36,$AE,$31,$01,$41,$00,$00,$31,$31,$41,$41,$31,$01
    .byte $41,$00,$00,$31,$31,$41,$01,$FE,$03,$4C,$AE,$31,$01,$41,$00,$00
    .byte $31,$31,$41,$40,$40,$31,$01,$41,$00,$00,$31,$31,$41,$01,$FE,$03
    .byte $63,$AE,$31,$01,$41,$00,$00,$31,$31,$41,$41,$31,$01,$01,$30,$30
    .byte $31,$31,$41,$01,$FE,$07,$79,$AE,$FF,$FD,$1E,$AE,$31,$01,$01,$30
    .byte $30,$41,$41,$31,$40,$40,$FD,$1E,$AE,$33,$03,$33,$03,$C7,$FF

L1_AE9D:
    lda $35                     ; AE9D  A5 35
    clc                         ; AE9F  18
    adc #$4C                    ; AEA0  69 4C
    sta $35                     ; AEA2  85 35
    sta $04                     ; AEA4  85 04
    ldy #$3F                    ; AEA6  A0 3F
    sty $07                     ; AEA8  84 07
    lda $6A                     ; AEAA  A5 6A
    beq L1_AEB1                 ; AEAC  F0 03
    jsr L1_AFC0                 ; AEAE  20 C0 AF

L1_AEB1:
    ldx #$19                    ; AEB1  A2 19

L1_AEB3:
    stx $05                     ; AEB3  86 05
    lda $0300,x                 ; AEB5  BD 00 03
    beq L1_AECC                 ; AEB8  F0 12
    ldy $034E,x                 ; AEBA  BC 4E 03
    sty $00                     ; AEBD  84 00
    ldy $031A,x                 ; AEBF  BC 1A 03
    sty $01                     ; AEC2  84 01
    ldy $0334,x                 ; AEC4  BC 34 03
    sty $02                     ; AEC7  84 02
    jsr L1_AEE3                 ; AEC9  20 E3 AE

L1_AECC:
    ldy $07                     ; AECC  A4 07
    bmi L1_AEE2                 ; AECE  30 12
    ldx $05                     ; AED0  A6 05
    dex                         ; AED2  CA
    bpl L1_AEB3                 ; AED3  10 DE
    ldx $04                     ; AED5  A6 04

L1_AED7:
    lda #$F4                    ; AED7  A9 F4
    sta $0200,x                 ; AED9  9D 00 02
    jsr L1_B02A                 ; AEDC  20 2A B0
    dey                         ; AEDF  88
    bpl L1_AED7                 ; AEE0  10 F5

L1_AEE2:
    rts                         ; AEE2  60


L1_AEE3:
    asl a                       ; AEE3  0A
    tay                         ; AEE4  A8
    bcs L1_AEF2                 ; AEE5  B0 0B
    lda L1_B02E,y               ; AEE7  B9 2E B0
    sta $08                     ; AEEA  85 08
    lda L1_B02F,y               ; AEEC  B9 2F B0
    jmp L1_AEFA                 ; AEEF  4C FA AE


L1_AEF2:
    lda D1_B12E,y               ; AEF2  B9 2E B1
    sta $08                     ; AEF5  85 08
    lda D1_B12F,y               ; AEF7  B9 2F B1

L1_AEFA:
    sta $09                     ; AEFA  85 09
    ldy #$00                    ; AEFC  A0 00
    lda ($08),y                 ; AEFE  B1 08
    beq L1_AEE2                 ; AF00  F0 E0
    iny                         ; AF02  C8
    cmp #$FE                    ; AF03  C9 FE
    bne L1_AF0A                 ; AF05  D0 03
    jmp L1_AF9B                 ; AF07  4C 9B AF


L1_AF0A:
    sta $03                     ; AF0A  85 03
    lda $00                     ; AF0C  A5 00
    and #$C8                    ; AF0E  29 C8
    sta $0B                     ; AF10  85 0B
    lda $00                     ; AF12  A5 00
    lsr a                       ; AF14  4A
    lsr a                       ; AF15  4A
    lsr a                       ; AF16  4A
    ldx #$FC                    ; AF17  A2 FC
    lda #$23                    ; AF19  A9 23
    bcs L1_AF21                 ; AF1B  B0 04
    ldx #$FF                    ; AF1D  A2 FF
    lda #$20                    ; AF1F  A9 20

L1_AF21:
    and $00                     ; AF21  25 00
    sta $00                     ; AF23  85 00
    stx $0D                     ; AF25  86 0D
    ldx $04                     ; AF27  A6 04

L1_AF29:
    lda ($08),y                 ; AF29  B1 08
    cmp #$80                    ; AF2B  C9 80
    bne L1_AF45                 ; AF2D  D0 16
    lda $0B                     ; AF2F  A5 0B
    and #$F7                    ; AF31  29 F7
    sta $0B                     ; AF33  85 0B
    iny                         ; AF35  C8
    lda ($08),y                 ; AF36  B1 08
    sta $06                     ; AF38  85 06
    iny                         ; AF3A  C8
    lda ($08),y                 ; AF3B  B1 08
    sta $09                     ; AF3D  85 09
    lda $06                     ; AF3F  A5 06
    sta $08                     ; AF41  85 08
    ldy #$00                    ; AF43  A0 00

L1_AF45:
    lda ($08),y                 ; AF45  B1 08
    sta $0C                     ; AF47  85 0C
    lda $0B                     ; AF49  A5 0B
    asl a                       ; AF4B  0A
    and #$10                    ; AF4C  29 10
    beq L1_AF52                 ; AF4E  F0 02
    inc $0C                     ; AF50  E6 0C

L1_AF52:
    lda $0C                     ; AF52  A5 0C
    bcc L1_AF5D                 ; AF54  90 07
    sta $0C                     ; AF56  85 0C
    lda #$F0                    ; AF58  A9 F0
    sbc $0C                     ; AF5A  E5 0C
    clc                         ; AF5C  18

L1_AF5D:
    adc $01                     ; AF5D  65 01
    sta $0200,x                 ; AF5F  9D 00 02
    iny                         ; AF62  C8
    lda ($08),y                 ; AF63  B1 08
    sta $0201,x                 ; AF65  9D 01 02
    iny                         ; AF68  C8
    lda ($08),y                 ; AF69  B1 08
    and $0D                     ; AF6B  25 0D
    ora $00                     ; AF6D  05 00
    eor $0B                     ; AF6F  45 0B
    sta $0202,x                 ; AF71  9D 02 02
    iny                         ; AF74  C8
    lda $0B                     ; AF75  A5 0B
    asl a                       ; AF77  0A
    asl a                       ; AF78  0A
    lda ($08),y                 ; AF79  B1 08
    bcc L1_AF84                 ; AF7B  90 07
    sta $0C                     ; AF7D  85 0C
    lda #$F8                    ; AF7F  A9 F8
    sbc $0C                     ; AF81  E5 0C
    clc                         ; AF83  18

L1_AF84:
    bmi L1_AF95                 ; AF84  30 0F
    adc $02                     ; AF86  65 02
    bcs L1_AF8D                 ; AF88  B0 03

L1_AF8A:
    jsr L1_B025                 ; AF8A  20 25 B0

L1_AF8D:
    iny                         ; AF8D  C8
    dec $03                     ; AF8E  C6 03
    bne L1_AF29                 ; AF90  D0 97
    stx $04                     ; AF92  86 04
    rts                         ; AF94  60


L1_AF95:
    adc $02                     ; AF95  65 02
    bcs L1_AF8A                 ; AF97  B0 F1
    bcc L1_AF8D                 ; AF99  90 F2

L1_AF9B:
    ldx $04                     ; AF9B  A6 04
    lda #$F8                    ; AF9D  A9 F8
    clc                         ; AF9F  18
    adc $01                     ; AFA0  65 01
    sta $0200,x                 ; AFA2  9D 00 02
    lda ($08),y                 ; AFA5  B1 08
    sta $0201,x                 ; AFA7  9D 01 02
    iny                         ; AFAA  C8
    lda ($08),y                 ; AFAB  B1 08
    ora $00                     ; AFAD  05 00
    sta $0202,x                 ; AFAF  9D 02 02
    lda $02                     ; AFB2  A5 02
    sec                         ; AFB4  38
    sbc #$04                    ; AFB5  E9 04
    bcc L1_AFBE                 ; AFB7  90 05
    jsr L1_B025                 ; AFB9  20 25 B0
    stx $04                     ; AFBC  86 04

L1_AFBE:
    iny                         ; AFBE  C8
    rts                         ; AFBF  60


L1_AFC0:
    lda $22                     ; AFC0  A5 22
    ldy $1C                     ; AFC2  A4 1C
    beq L1_AFC8                 ; AFC4  F0 02
    lda #$01                    ; AFC6  A9 01

L1_AFC8:
    sta $00                     ; AFC8  85 00
    ldx $04                     ; AFCA  A6 04

L1_AFCC:
    ldy #$04                    ; AFCC  A0 04
    lda $1C                     ; AFCE  A5 1C
    bne L1_AFE7                 ; AFD0  D0 15
    ldy $00                     ; AFD2  A4 00
    lda a:$0038,y               ; AFD4  B9 38 00
    ldy #$04                    ; AFD7  A0 04
    lsr a                       ; AFD9  4A
    bcs L1_AFE7                 ; AFDA  B0 0B
    ldy $00                     ; AFDC  A4 00
    lda a:$0032,y               ; AFDE  B9 32 00
    ldy #$00                    ; AFE1  A0 00
    cmp #$04                    ; AFE3  C9 04
    bcc L1_AFE9                 ; AFE5  90 02

L1_AFE7:
    lda #$04                    ; AFE7  A9 04

L1_AFE9:
    sta $01                     ; AFE9  85 01

L1_AFEB:
    dec $01                     ; AFEB  C6 01
    bmi L1_B00E                 ; AFED  30 1F
    lda #$10                    ; AFEF  A9 10
    sta $0200,x                 ; AFF1  9D 00 02
    lda D1_B015,y               ; AFF4  B9 15 B0
    sta $0201,x                 ; AFF7  9D 01 02
    lda $00                     ; AFFA  A5 00
    sta $0202,x                 ; AFFC  9D 02 02
    lsr a                       ; AFFF  4A
    lda D1_B01D,y               ; B000  B9 1D B0
    bcc L1_B007                 ; B003  90 02
    adc #$AF                    ; B005  69 AF

L1_B007:
    jsr L1_B025                 ; B007  20 25 B0
    iny                         ; B00A  C8
    jmp L1_AFEB                 ; B00B  4C EB AF


L1_B00E:
    dec $00                     ; B00E  C6 00
    bpl L1_AFCC                 ; B010  10 BA
    stx $04                     ; B012  86 04
    rts                         ; B014  60

D1_B015:
    .byte $0A,$0A,$0A,$0A,$02,$04,$06,$08
D1_B01D:
    .byte $10,$1C,$28,$34,$10,$1C,$28,$34

L1_B025:
    sta $0203,x                 ; B025  9D 03 02
    dec $07                     ; B028  C6 07

L1_B02A:
    txa                         ; B02A  8A
    clc                         ; B02B  18
    adc #$C4                    ; B02C  69 C4

L1_B02E:
    tax                         ; B02E  AA

L1_B02F:
    rts                         ; B02F  60

    .byte $CE
    .word L_CFB1                    ; B031
    .word L_E4B1                    ; B033
    .byte $B1,$F9,$B1,$0E,$B2,$1A,$B2,$26,$B2,$29,$B2,$3A,$B2,$47,$B2,$58
    .byte $B2,$69,$B2,$7A,$B2,$8A,$B2,$9A,$B2,$AA,$B2,$B6,$B2,$C2,$B2,$CE
    .byte $B2,$DE,$B2,$EE,$B2,$FE,$B2,$0E,$B3,$1F,$B3,$28,$B3,$31,$B3,$3A
    .byte $B3,$4A,$B3,$56,$B3,$66,$B3,$69,$B3,$6C,$B3,$6F,$B3,$72,$B3,$75
    .byte $B3,$78,$B3,$81,$B3,$84,$B3,$95,$B3,$A6,$B3,$B2,$B3,$C3,$B3,$DC
    .byte $B3,$E8,$B3,$FD,$B3,$12,$B4,$23,$B4,$30,$B4,$38,$B4,$40,$B4,$48
    .byte $B4,$50,$B4,$58,$B4,$79,$B4,$8E,$B4,$97,$B4,$B0,$B4,$D1,$B4,$F2
    .byte $B4,$03,$B5,$14,$B5,$25,$B5,$31,$B5,$3D,$B5,$4D,$B5,$62,$B5,$72
    .byte $B5,$82,$B5,$87,$B5,$94,$B5,$98,$B5,$9B,$B5,$B8,$B5,$C1,$B5,$DA
    .byte $B5,$E3,$B5,$F0,$B5,$FD,$B5,$05,$B6,$06,$B6,$23,$B6,$33,$B6,$43
    .byte $B6,$53,$B6,$70,$B6,$91,$B6,$B2,$B6,$CB,$B6,$E4,$B6,$E4,$B6,$E4
    .byte $B6,$E4,$B6,$E5,$B6,$06,$B7,$1A,$B7,$2E,$B7,$42,$B7,$4E,$B7,$56
    .byte $B7,$5F,$B7,$80,$B7,$80,$B7,$80,$B7,$81,$B7,$A2,$B7,$BE,$B7,$D2
    .byte $B7,$DE,$B7,$EA,$B7,$F3,$B7,$FC,$B7,$FF,$B7,$08,$B8,$11,$B8,$14
    .byte $B8,$1D,$B8,$26,$B8,$2F,$B8,$38,$B8,$41,$B8,$4A,$B8,$53,$B8,$5C
    .byte $B8,$65,$B8,$72,$B8,$7F,$B8,$8C,$B8
D1_B12E:
    .byte $8C
D1_B12F:
    .byte $B8,$95,$B8,$9E,$B8,$A3,$B8,$A8,$B8,$AD,$B8,$C2,$B8,$D3,$B8,$E0
    .byte $B8,$F1,$B8,$02,$B9,$17,$B9,$34,$B9,$3C,$B9,$44,$B9,$4C,$B9,$54
    .byte $B9,$65,$B9,$75,$B9,$7A,$B9,$8B,$B9,$9C,$B9,$AD,$B9,$BE,$B9,$D3
    .byte $B9,$E0,$B9,$E9,$B9,$F2,$B9,$FF,$B9,$0C,$BA,$0F,$BA,$18,$BA,$21
    .byte $BA,$2A,$BA,$2F,$BA,$32,$BA,$37,$BA,$3C,$BA,$41,$BA,$44,$BA,$49
    .byte $BA,$4C,$BA,$50,$BA,$59,$BA,$B2,$BA,$CB,$BA,$D7,$BA,$F0,$BA,$FC
    .byte $BA,$05,$BB,$0E,$BB,$17,$BB,$30,$BB,$51,$BB,$6E,$BB,$77,$BB,$77
    .byte $BB,$D0,$BB,$19,$BC,$45,$BC,$4E,$BC,$57,$BC,$74,$BC,$91,$BC,$96
    .byte $BC,$9B,$BC,$A0,$BC,$A5,$BC,$CD,$BC,$D2,$BC,$DB,$BC,$E8,$BC,$F1
    .byte $BC,$FE,$BC,$13,$BD,$30,$BD,$59,$BD,$7E,$BD,$AB,$BD,$D0,$BD,$00
    .byte $05,$EE,$28,$01,$FB,$EE,$2A,$01,$03,$FE,$34,$00,$F8,$FE,$36,$00
    .byte $00,$0E,$40,$00,$F8,$05,$EF,$2C,$01,$FC,$EF,$2E,$01,$04,$FD,$38
    .byte $00,$F8,$FD,$3A,$00,$00,$0D,$42,$00,$04,$05,$EE,$30,$01,$FA,$EE
    .byte $32,$01,$02,$FE,$3C,$00,$F7,$FE,$3E,$00,$FF,$0E,$42,$00,$FE,$05
    .byte $EE,$30,$01,$FA,$EE,$32,$01,$02,$80,$D8,$B1,$05,$EE,$28,$01,$FB
    .byte $EE,$2A,$01,$03,$80,$02,$B2,$FE,$EC,$02,$04,$F2,$44,$01,$F8,$F2
    .byte $48,$01,$00,$02,$46,$00,$F8,$02,$4A,$00,$00,$03,$F8,$4C,$00,$F6
    .byte $F8,$4E,$01,$FE,$F8,$50,$01,$06,$04,$F3,$68,$01,$F6,$03,$6A,$00
    .byte $F6,$F7,$6C,$00,$FE,$F7,$6E,$00,$06,$04,$F9,$70,$00,$F8,$FA,$74
    .byte $00,$FF,$EA,$72,$00,$FC,$FF,$76,$01,$FA,$04,$00,$78,$01,$F0,$00
    .byte $7A,$01,$F8,$00,$7C,$00,$00,$00,$7E,$00,$08,$06,$EE,$94,$01,$F9
    .byte $EE,$96,$01,$01,$EE,$98,$01,$09,$80,$D8,$B1,$06,$EF,$94,$01,$F9
    .byte $EF,$96,$01,$01,$EF,$98,$01,$09,$80,$ED,$B1,$06,$EE,$94,$01,$F9
    .byte $EE,$96,$01,$01,$EE,$98,$01,$09,$80,$02,$B2,$05,$EE,$8C,$01,$FB
    .byte $EE,$8E,$01,$03,$80,$D8,$B1,$05,$EF,$8C,$01,$FB,$EF,$8E,$01,$03
    .byte $80,$ED,$B1,$05,$EE,$8C,$01,$FB,$EE,$8E,$01,$03,$80,$02,$B2,$06
    .byte $EE,$86,$01,$F8,$EE,$88,$01,$00,$F3,$8A,$01,$05,$80,$D8,$B1,$06
    .byte $EF,$86,$01,$F8,$EF,$88,$01,$00,$F4,$8A,$01,$05,$80,$ED,$B1,$06
    .byte $EE,$86,$01,$F8,$EE,$88,$01,$00,$F3,$8A,$01,$05,$80,$02,$B2,$06
    .byte $DE,$82,$01,$01,$EE,$80,$01,$F9,$EE,$84,$01,$01,$80,$02,$B2,$04
    .byte $00,$9C,$00,$F0,$00,$9E,$00,$F8,$00,$A0,$01,$00,$00,$A2,$01,$08
    .byte $02,$FA,$DC,$01,$F8,$FA,$DC,$41,$00,$02,$F2,$DE,$01,$F8,$F2,$E0
    .byte $01,$00,$02,$FA,$E2,$01,$F8,$FA,$E4,$01,$00,$05,$DF,$82,$01,$01
    .byte $EF,$80,$01,$F9,$EF,$84,$01,$01,$80,$20,$B3,$04,$EF,$8C,$01,$FB
    .byte $EF,$8E,$01,$03,$80,$20,$B3,$05,$EF,$94,$01,$F9,$EF,$96,$01,$01
    .byte $EF,$98,$01,$09,$80,$20,$B3,$FE,$0E,$02,$FE,$10,$02,$FE,$12,$02
    .byte $FE,$14,$02,$FE,$16,$02,$FE,$18,$02,$02,$F8,$92,$02,$F4,$F8,$92
    .byte $02,$FC,$FE,$90,$02,$04,$00,$DC,$03,$F0,$00,$DE,$01,$F8,$00,$E0
    .byte $01,$00,$00,$E2,$03,$08,$04,$F0,$D6,$01,$F8,$F0,$D8,$01,$00,$00
    .byte $CE,$03,$F8,$00,$CC,$03,$00,$04,$F0,$BE,$01,$F8,$F0,$C0,$01,$00
    .byte $80,$9E,$B3,$04,$F0,$AE,$01,$F8,$F0,$B0,$01,$00,$00,$BA,$01,$F8
    .byte $00,$BC,$01,$00,$06,$F6,$E4,$02,$F0,$F6,$E6,$02,$F8,$F6,$E8,$02
    .byte $00,$F6,$FC,$02,$08,$04,$EA,$00,$F9,$04,$EA,$00,$05,$06,$04,$EC
    .byte $00,$F9,$04,$EC,$00,$05,$80,$C4,$B3,$05,$F0,$F2,$41,$F8,$F0,$B6
    .byte $01,$00,$F0,$B8,$01,$08,$00,$F4,$41,$F8,$00,$BC,$01,$00,$05,$F0
    .byte $F6,$41,$F8,$F0,$AA,$01,$00,$F8,$AC,$01,$08,$00,$F4,$41,$F8,$00
    .byte $BC,$01,$00,$04,$F0,$FA,$41,$F8,$F0,$F8,$41,$00,$00,$F4,$41,$F8
    .byte $00,$FC,$41,$00,$03,$F8,$1C,$01,$FC,$F8,$1A,$01,$F4,$F8,$1A,$41
    .byte $04,$03,$F8,$1E,$01,$FC,$80,$28,$B4,$03,$F8,$20,$01,$FC,$80,$28
    .byte $B4,$03,$F8,$22,$01,$FC,$80,$28,$B4,$03,$F8,$24,$01,$FC,$80,$28
    .byte $B4,$03,$F8,$26,$01,$FC,$80,$28,$B4,$08,$F0,$54,$02,$F0,$F0,$56
    .byte $02,$F8,$F0,$58,$02,$00,$F0,$5A,$02,$08,$00,$5A,$C2,$F0,$00,$58
    .byte $C2,$F8,$00,$56,$C2,$00,$00,$54,$C2,$08,$05,$F0,$56,$02,$FC,$F0
    .byte $5A,$02,$04,$F8,$52,$02,$F4,$00,$56,$C2,$FC,$00,$54,$C2,$04,$02
    .byte $F8,$52,$82,$F8,$F4,$5A,$02,$00,$06,$F0,$5E,$02,$F8,$F0,$5E,$42
    .byte $00,$F8,$5C,$02,$F0,$F8,$5C,$C2,$08,$00,$5E,$82,$F8,$00,$5E,$C2
    .byte $00,$08,$F0,$60,$02,$F0,$F0,$62,$02,$F8,$F0,$62,$42,$00,$F0,$60
    .byte $42,$08,$00,$60,$82,$F0,$00,$62,$82,$F8,$00,$62,$C2,$00,$00,$60
    .byte $C2,$08,$08,$F0,$64,$02,$F0,$F0,$66,$02,$F8,$F0,$66,$42,$00,$F0
    .byte $64,$42,$08,$00,$64,$82,$F0,$00,$66,$82,$F8,$00,$66,$C2,$00,$00
    .byte $64,$C2,$08,$04,$F0,$BE,$01,$F8,$F0,$C0,$01,$00,$00,$CA,$03,$F8
    .byte $00,$CC,$03,$00,$04,$F0,$C2,$01,$F8,$F0,$C4,$01,$00,$00,$CE,$03
    .byte $F8,$00,$D0,$03,$00,$04,$F0,$C6,$01,$F8,$F0,$C8,$01,$00,$00,$D2
    .byte $03,$F8,$00,$D4,$03,$00,$04,$F0,$BE,$01,$F8,$F0,$C0,$01,$00,$80
    .byte $1D,$B5,$04,$F0,$C6,$01,$F8,$F0,$C8,$01,$00,$80,$FB,$B4,$05,$F0
    .byte $D6,$01,$F8,$F0,$D8,$01,$00,$F0,$DA,$03,$08,$80,$1D,$B5,$05,$F0
    .byte $A8,$01,$F8,$F0,$AA,$01,$00,$F8,$AC,$01,$08,$00,$BA,$01,$F8,$00
    .byte $BC,$01,$00,$05,$F0,$AE,$01,$F8,$F0,$B0,$01,$00,$E0,$B2,$01,$02
    .byte $80,$5A,$B5,$05,$F0,$B4,$01,$F8,$F0,$B6,$01,$00,$F0,$B8,$01,$08
    .byte $80,$5A,$B5,$01,$F0,$EA,$41,$FC,$03,$F0,$F0,$41,$F8,$F0,$EE,$41
    .byte $00,$F0,$EC,$41,$08,$03,$80,$73,$B5,$FE,$0C,$02,$07,$F0,$EE,$03
    .byte $F0,$F0,$F0,$03,$F8,$F0,$F0,$43,$00,$F0,$EE,$43,$08,$00,$F2,$03
    .byte $F4,$00,$FC,$03,$FC,$00,$F2,$43,$04,$02,$F8,$EA,$02,$F8,$F8,$EC
    .byte $02,$00,$06,$F0,$E6,$03,$F4,$F0,$E8,$03,$FC,$F0,$D7,$03,$04,$00
    .byte $D9,$03,$F4,$00,$DB,$03,$FC,$00,$DD,$03,$04,$02,$F8,$DC,$01,$F8
    .byte $F8,$DE,$01,$00,$03,$E8,$E2,$03,$00,$F8,$E0,$01,$F8,$F8,$E4,$01
    .byte $00,$03,$F8,$A4,$01,$F4,$F8,$A6,$01,$FC,$F8,$A4,$41,$04,$03,$F8
    .byte $00,$01,$FC,$80,$28,$B4,$00,$07,$DE,$7C,$01,$FA,$EE,$7E,$01,$F8
    .byte $EE,$80,$01,$00,$FE,$78,$00,$F8,$FE,$78,$40,$FF,$0E,$7A,$00,$F6
    .byte $0E,$7A,$40,$01,$05,$DE,$7C,$01,$FB,$EE,$8C,$01,$FA,$EE,$8E,$01
    .byte $02,$80,$D8,$B1,$06,$DF,$7C,$01,$FB,$EF,$8C,$01,$FA,$EF,$8E,$01
    .byte $02,$80,$ED,$B1,$06,$DE,$7C,$01,$FB,$EE,$8C,$01,$FA,$EE,$8E,$01
    .byte $02,$80,$02,$B2,$07,$F4,$82,$01,$F8,$F4,$84,$01,$00,$0A,$86,$00
    .byte $F4,$0A,$86,$40,$04,$04,$88,$00,$F8,$04,$88,$40,$00,$FA,$8A,$00
    .byte $FC,$08,$E2,$70,$01,$01,$F5,$72,$01,$F0,$ED,$74,$01,$F8,$ED,$76
    .byte $01,$00,$FD,$78,$00,$F8,$FD,$78,$40,$FF,$0D,$7A,$00,$F6,$0D,$7A
    .byte $40,$01,$08,$FA,$68,$00,$F0,$FA,$6A,$00,$F8,$FA,$6A,$40,$00,$FA
    .byte $68,$40,$08,$0A,$6C,$01,$F0,$0A,$6E,$01,$F8,$0A,$6E,$41,$00,$0A
    .byte $6C,$41,$08,$06,$F4,$94,$01,$F4,$EF,$96,$01,$FC,$EF,$98,$01,$04
    .byte $FF,$BE,$00,$F8,$FF,$90,$00,$00,$0F,$92,$00,$00,$06,$F1,$9A,$01
    .byte $F4,$F1,$9C,$01,$FC,$F2,$9E,$01,$04,$01,$90,$40,$FA,$01,$BE,$40
    .byte $02,$11,$92,$40,$FA,$00,$08,$FE,$A6,$02,$F8,$FE,$A6,$42,$00,$FE
    .byte $9E,$03,$F8,$FE,$9E,$43,$00,$EE,$9A,$03,$F8,$EE,$9A,$43,$00,$F6
    .byte $9C,$03,$F0,$F6,$9C,$43,$08,$08,$FE,$A6,$02,$F8,$FE,$A6,$42,$00
    .byte $FE,$A0,$03,$F8,$FE,$A0,$43,$00,$80,$F6,$B6,$08,$F6,$A8,$02,$F0
    .byte $F6,$A8,$42,$08,$FE,$A2,$03,$F8,$FE,$A2,$43,$00,$80,$F6,$B6,$08
    .byte $FE,$AA,$02,$F8,$FE,$AA,$42,$00,$FE,$A4,$03,$F8,$FE,$A4,$43,$00
    .byte $80,$F6,$B6,$08,$FE,$AC,$02,$F8,$FE,$AC,$42,$00,$80,$37,$B7,$09
    .byte $FE,$AE,$02,$FC,$80,$1B,$B7,$02,$F8,$B0,$03,$F8,$F8,$B2,$03,$00
    .byte $08,$F0,$B4,$03,$F0,$F0,$B6,$03,$F8,$F0,$B8,$03,$00,$F0,$BA,$03
    .byte $08,$00,$BC,$03,$F0,$00,$BE,$03,$F8,$00,$C0,$03,$00,$00,$C2,$03
    .byte $08,$00,$08,$F0,$DC,$03,$F8,$F0,$DC,$43,$00,$00,$D2,$03,$F8,$00
    .byte $D2,$43,$00,$00,$D0,$03,$F0,$00,$D0,$43,$08,$F0,$DA,$03,$F0,$F0
    .byte $DA,$43,$08,$08,$F0,$DE,$03,$F8,$F0,$DE,$43,$00,$00,$D6,$03,$F8
    .byte $00,$D6,$43,$00,$00,$D4,$03,$F0,$00,$D4,$43,$08,$80,$9A,$B7,$08
    .byte $F0,$E0,$03,$F8,$F0,$E0,$43,$00,$00,$D8,$03,$F8,$00,$D8,$43,$00
    .byte $80,$B3,$B7,$08,$F0,$E2,$02,$F8,$F0,$E2,$42,$00,$80,$AB,$B7,$08
    .byte $F0,$E4,$02,$F8,$F0,$E4,$42,$00,$80,$C7,$B7,$02,$F8,$E8,$03,$F8
    .byte $F8,$E6,$02,$FE,$02,$F8,$EC,$03,$FA,$F8,$EA,$02,$01,$FE,$EC,$03
    .byte $02,$F8,$EA,$42,$F7,$F8,$EC,$43,$FE,$02,$F8,$E6,$42,$FA,$F8,$E8
    .byte $43,$00,$FE,$EC,$02,$02,$F8,$E6,$00,$F8,$F8,$E6,$40,$00,$02,$F8
    .byte $E6,$00,$F8,$F8,$E6,$C0,$00,$02,$F8,$E8,$00,$F8,$F8,$E8,$40,$00
    .byte $02,$F8,$E6,$80,$F8,$F8,$E6,$40,$00,$02,$F8,$EA,$80,$F8,$F8,$EA
    .byte $40,$00,$02,$F8,$E6,$00,$F8,$F8,$E6,$C0,$00,$02,$F8,$F4,$02,$F8
    .byte $F8,$F6,$02,$00,$02,$F8,$F8,$03,$F8,$F8,$F8,$43,$00,$02,$F8,$FA
    .byte $01,$F8,$F8,$FA,$41,$00,$03,$F8,$FC,$03,$F4,$F8,$33,$03,$FC,$F8
    .byte $35,$03,$04,$03,$F8,$37,$03,$F4,$F8,$39,$03,$FC,$F8,$3B,$03,$04
    .byte $03,$F8,$3D,$03,$F4,$F8,$3F,$03,$FC,$F8,$41,$03,$04,$02,$F8,$CA
    .byte $02,$F8,$F8,$CA,$42,$00,$02,$F8,$CC,$02,$F8,$F8,$CC,$42,$00,$01
    .byte $F8,$A2,$02,$FC,$01,$F8,$A0,$02,$FC,$01,$F8,$A2,$02,$FC,$05,$F0
    .byte $F2,$03,$08,$F0,$EE,$03,$F8,$F0,$F0,$03,$00,$00,$F4,$03,$F6,$00
    .byte $F6,$03,$FE,$04,$E8,$F8,$03,$FE,$F8,$FA,$03,$F6,$F8,$CE,$03,$FE
    .byte $08,$DD,$03,$03,$03,$F0,$DF,$03,$F8,$F0,$E1,$03,$00,$00,$E3,$03
    .byte $FC,$04,$F0,$E5,$43,$F9,$F0,$E5,$03,$00,$00,$E7,$43,$F9,$00,$E7
    .byte $03,$00,$04,$F0,$E9,$43,$F9,$F0,$E9,$03,$00,$00,$EB,$43,$F9,$00
    .byte $EB,$03,$00,$05,$F0,$ED,$03,$F4,$F0,$EF,$03,$FC,$F0,$ED,$43,$04
    .byte $00,$F1,$03,$F8,$00,$F3,$03,$00,$07,$F2,$F5,$03,$F4,$F2,$F7,$03
    .byte $FC,$F2,$F5,$43,$04,$02,$F9,$03,$F8,$02,$FB,$03,$00,$12,$B0,$03
    .byte $F7,$12,$B2,$03,$00,$05,$F0,$FC,$02,$08,$80,$B2,$B8,$05,$F8,$A6
    .byte $02,$04,$80,$C3,$B8,$04,$FF,$C4,$02,$00,$80,$D4,$B8,$05,$00,$C6
    .byte $02,$F4,$80,$E1,$B8,$04,$F0,$C8,$42,$F9,$F0,$C8,$02,$00,$00,$CA
    .byte $02,$F8,$00,$CC,$02,$00,$08,$0C,$FD,$02,$F4,$0C,$FD,$02,$FC,$0C
    .byte $FD,$02,$04,$80,$9B,$B2,$01,$F8,$A0,$02,$FC,$04,$EB,$CE,$01,$FF
    .byte $EC,$A8,$03,$FB,$FC,$AA,$03,$F6,$FB,$AC,$03,$FE,$04,$ED,$AE,$01
    .byte $FE,$ED,$B0,$03,$FB,$FD,$B2,$03,$F7,$FD,$B4,$03,$FF,$04,$ED,$B6
    .byte $01,$FF,$ED,$B8,$03,$FB,$FD,$BA,$03,$F4,$FD,$BC,$03,$FC,$04,$EB
    .byte $DA,$01,$FF,$ED,$C0,$03,$FC,$FD,$C2,$43,$F9,$FD,$C2,$03,$00,$05
    .byte $E8,$D0,$01,$FA,$E8,$D2,$03,$FC,$F8,$D4,$03,$F4,$F8,$D6,$03,$FC
    .byte $F8,$D8,$03,$04,$03,$F0,$DA,$01,$FF,$FC,$DC,$03,$FB,$00,$DE,$03
    .byte $03,$02,$FE,$E0,$01,$F8,$FE,$E0,$41,$00,$02,$FE,$E2,$01,$F8,$FE
    .byte $E2,$41,$00,$03,$FD,$E4,$01,$F4,$FD,$E6,$01,$FC,$FD,$E4,$41,$04
    .byte $03,$FC,$E8,$01,$F4,$FC,$EA,$41,$FC,$FC,$E8,$41,$04,$FE,$C8,$02
    .byte $02,$F8,$CA,$02,$F8,$F8,$CA,$C2,$00,$02,$F8,$CC,$02,$F8,$F8,$CC
    .byte $C2,$00,$02,$F8,$EC,$01,$F8,$F8,$EE,$01,$00,$01,$F8,$F0,$01,$FD
    .byte $FE,$F2,$01,$01,$F8,$F4,$01,$FB,$01,$F8,$F6,$01,$FD,$01,$F8,$F8
    .byte $01,$FD,$FE,$FA,$01,$01,$F8,$FC,$01,$FD,$FE,$C4,$01,$FE,$C6,$01
    .byte $00,$02,$F8,$CE,$01,$F8,$F8,$D0,$01,$00,$16,$00,$DA,$01,$00,$00
    .byte $DE,$01,$08,$00,$E2,$01,$10,$10,$DC,$02,$00,$10,$E0,$02,$08,$10
    .byte $E4,$02,$10,$20,$EA,$00,$05,$20,$F4,$00,$15,$30,$EC,$00,$05,$30
    .byte $F6,$00,$15,$40,$EE,$00,$05,$40,$F8,$00,$15,$FD,$D6,$02,$F8,$02
    .byte $D4,$02,$F0,$04,$D2,$02,$E8,$0C,$D8,$02,$F8,$1F,$E6,$00,$F5,$1F
    .byte $E8,$00,$FD,$24,$F0,$00,$0D,$24,$FA,$00,$1D,$34,$F2,$00,$0D,$34
    .byte $FC,$00,$1D,$06,$00,$B0,$C2,$04,$00,$B2,$C2,$FC,$00,$B4,$C2,$F4
    .byte $F0,$B6,$C2,$04,$F0,$B8,$C2,$FC,$F0,$BA,$C2,$F4,$06,$F0,$EA,$C2
    .byte $FC,$F0,$EC,$C2,$F4,$80,$B3,$BA,$06,$00,$F0,$C2,$04,$00,$F2,$C2
    .byte $FC,$00,$F4,$C2,$F4,$F0,$AA,$C2,$F4,$F0,$AC,$C2,$FC,$F0,$AE,$C2
    .byte $FC,$06,$F0,$F6,$C2,$04,$F0,$A8,$C2,$FC,$80,$D8,$BA,$02,$F8,$FA
    .byte $03,$F8,$F8,$FA,$43,$00,$02,$F8,$FC,$03,$F8,$F8,$FC,$43,$00,$02
    .byte $F8,$F8,$03,$F8,$F8,$F8,$43,$00,$06,$F0,$C0,$03,$F8,$F0,$C2,$03
    .byte $00,$00,$C4,$03,$F0,$00,$C6,$03,$F8,$00,$C8,$03,$00,$00,$CA,$03
    .byte $08,$08,$F1,$CC,$03,$F0,$F1,$CE,$03,$F8,$F1,$D0,$03,$00,$F1,$D2
    .byte $03,$08,$01,$D4,$03,$F0,$01,$D6,$03,$F8,$01,$D8,$03,$00,$01,$DA
    .byte $03,$08,$07,$F0,$DC,$03,$F8,$F0,$DE,$03,$00,$F0,$E0,$03,$08,$00
    .byte $E2,$03,$F0,$00,$E4,$03,$F8,$00,$E6,$03,$00,$00,$E8,$03,$08,$02
    .byte $F8,$BC,$03,$F8,$F8,$BE,$03,$00,$16,$D8,$DC,$02,$F0,$D8,$DE,$02
    .byte $F8,$D8,$E0,$02,$00,$D8,$E2,$02,$08,$E4,$FD,$03,$E8,$E8,$E4,$03
    .byte $E0,$E8,$E6,$02,$F0,$E8,$E8,$02,$F8,$E8,$EA,$02,$00,$E7,$A8,$03
    .byte $06,$E7,$AA,$03,$0E,$F7,$B4,$03,$0B,$F8,$AC,$03,$E8,$F8,$AE,$03
    .byte $F0,$F8,$B0,$03,$F8,$F8,$B2,$03,$00,$08,$B8,$03,$E8,$08,$BA,$03
    .byte $F0,$08,$BC,$03,$F8,$08,$BE,$03,$00,$08,$C0,$03,$08,$08,$C2,$03
    .byte $10,$12,$F9,$D8,$03,$F0,$F9,$DA,$03,$F8,$F9,$FF,$03,$00,$09,$B6
    .byte $03,$F0,$09,$07,$03,$F8,$09,$09,$03,$00,$DA,$DC,$02,$F0,$DA,$DE
    .byte $02,$F8,$DA,$E0,$02,$00,$DA,$E2,$02,$08,$E6,$FD,$03,$E8,$EA,$E4
    .byte $03,$E0,$EA,$E6,$02,$F0,$EA,$E8,$02,$F8,$EA,$EA,$02,$00,$E9,$A8
    .byte $03,$06,$E9,$AA,$03,$0E,$F9,$B4,$03,$0B,$15,$F8,$CA,$03,$E8,$F8
    .byte $CC,$03,$F0,$F8,$CE,$03,$F8,$F8,$D0,$03,$00,$F7,$D4,$03,$08,$F7
    .byte $D6,$03,$10,$08,$C4,$03,$D8,$08,$C6,$03,$E0,$08,$C8,$03,$E8,$08
    .byte $D2,$03,$00,$80,$78,$BB,$02,$F8,$DF,$00,$F8,$F8,$DF,$40,$00,$02
    .byte $F8,$FB,$00,$F8,$F8,$FB,$40,$00,$07,$F4,$EE,$03,$F0,$F4,$F2,$03
    .byte $F8,$04,$F0,$03,$F0,$04,$F4,$03,$F8,$04,$F8,$00,$00,$F4,$F6,$01
    .byte $00,$F4,$FA,$01,$08,$07,$F4,$EE,$03,$F2,$F4,$F2,$03,$FA,$04,$F0
    .byte $03,$F2,$04,$F4,$03,$FA,$04,$F8,$00,$01,$F4,$F6,$01,$01,$F4,$FA
    .byte $01,$09,$01,$EF,$33,$02,$FF,$01,$EF,$35,$02,$FF,$01,$EF,$37,$02
    .byte $FC,$01,$EF,$39,$02,$FC,$13,$D8,$9D,$02,$F0,$D8,$D7,$02,$F8,$D8
    .byte $D9,$02,$00,$E0,$3D,$03,$E0,$E0,$47,$03,$E8,$E8,$0B,$03,$D8,$E8
    .byte $9F,$02,$F0,$E8,$DB,$03,$F8,$E8,$DD,$03,$00,$80,$A8,$BB,$01,$FF
    .byte $FD,$00,$FC,$02,$F8,$A8,$00,$F8,$F8,$AA,$00,$00,$03,$F8,$AC,$00
    .byte $F8,$F8,$AE,$00,$00,$F8,$A6,$01,$07,$02,$F8,$B0,$00,$F8,$F8,$B2
    .byte $00,$00,$03,$F8,$B4,$00,$F8,$F8,$B6,$00,$00,$F8,$A6,$01,$05,$05
    .byte $F8,$B8,$00,$F3,$F8,$BA,$00,$FB,$F8,$BC,$00,$03,$03,$A6,$01,$FB
    .byte $03,$A6,$01,$05,$07,$F0,$BE,$40,$08,$F0,$C0,$40,$00,$F0,$C2,$40
    .byte $F8,$F0,$C4,$40,$F0,$00,$C6,$40,$08,$00,$C8,$40,$00,$00,$CA,$40
    .byte $F8,$0A,$F0,$CC,$00,$E8,$F0,$CE,$00,$F0,$F0,$D0,$00,$F8,$F0,$D2
    .byte $00,$00,$F0,$D4,$00,$08,$F0,$D6,$00,$10,$00,$D8,$00,$F8,$00,$DA
    .byte $00,$00,$04,$A6,$01,$F8,$04,$A6,$01,$07,$09,$F0,$DC,$40,$14,$F0
    .byte $DE,$40,$0C,$F0,$E0,$40,$04,$F0,$E2,$40,$FC,$F0,$E4,$40,$F4,$F0
    .byte $E6,$40,$EC,$00,$E8,$40,$04,$00,$EA,$40,$FC,$00,$EC,$40,$F4,$0B
    .byte $F0,$EE,$40,$14,$F0,$F0,$40,$0C,$F0,$F2,$40,$04,$F0,$E2,$40,$FC
    .byte $F0,$E4,$40,$F4,$F0,$F4,$40,$EC,$00,$E8,$40,$04,$00,$EA,$40,$FC
    .byte $00,$EC,$40,$F4,$0A,$A6,$01,$08,$02,$A6,$01,$F7,$09,$F0,$F6,$40
    .byte $14,$F0,$DE,$40,$0C,$F0,$E0,$40,$04,$F0,$F8,$40,$FC,$F0,$FA,$40
    .byte $F4,$F0,$FC,$40,$EC,$00,$E8,$40,$04,$00,$EA,$40,$FC,$00,$EC,$40
    .byte $F4,$05,$00,$63,$03,$00,$00,$65,$03,$08,$00,$65,$03,$10,$00,$65
    .byte $03,$18,$00,$89,$03,$20
; --- espacio libre: 539 bytes ($BDE5-$BFFF) ---
.org $C000, $FF
