"""Tabla de opcodes oficiales del 6502 (compartida por disasm.py y asm.py)."""

# Modos de direccionamiento y tamaño total de la instrucción (opcode + operando)
MODE_SIZE = {
    "imp": 1, "acc": 1, "imm": 2,
    "zp": 2, "zpx": 2, "zpy": 2,
    "abs": 3, "absx": 3, "absy": 3,
    "ind": 3, "indx": 2, "indy": 2,
    "rel": 2,
}

_TABLE = """
00 brk imp  01 ora indx 05 ora zp   06 asl zp   08 php imp  09 ora imm  0a asl acc
0d ora abs  0e asl abs  10 bpl rel  11 ora indy 15 ora zpx  16 asl zpx  18 clc imp
19 ora absy 1d ora absx 1e asl absx 20 jsr abs  21 and indx 24 bit zp   25 and zp
26 rol zp   28 plp imp  29 and imm  2a rol acc  2c bit abs  2d and abs  2e rol abs
30 bmi rel  31 and indy 35 and zpx  36 rol zpx  38 sec imp  39 and absy 3d and absx
3e rol absx 40 rti imp  41 eor indx 45 eor zp   46 lsr zp   48 pha imp  49 eor imm
4a lsr acc  4c jmp abs  4d eor abs  4e lsr abs  50 bvc rel  51 eor indy 55 eor zpx
56 lsr zpx  58 cli imp  59 eor absy 5d eor absx 5e lsr absx 60 rts imp  61 adc indx
65 adc zp   66 ror zp   68 pla imp  69 adc imm  6a ror acc  6c jmp ind  6d adc abs
6e ror abs  70 bvs rel  71 adc indy 75 adc zpx  76 ror zpx  78 sei imp  79 adc absy
7d adc absx 7e ror absx 81 sta indx 84 sty zp   85 sta zp   86 stx zp   88 dey imp
8a txa imp  8c sty abs  8d sta abs  8e stx abs  90 bcc rel  91 sta indy 94 sty zpx
95 sta zpx  96 stx zpy  98 tya imp  99 sta absy 9a txs imp  9d sta absx a0 ldy imm
a1 lda indx a2 ldx imm  a4 ldy zp   a5 lda zp   a6 ldx zp   a8 tay imp  a9 lda imm
aa tax imp  ac ldy abs  ad lda abs  ae ldx abs  b0 bcs rel  b1 lda indy b4 ldy zpx
b5 lda zpx  b6 ldx zpy  b8 clv imp  b9 lda absy ba tsx imp  bc ldy absx bd lda absx
be ldx absy c0 cpy imm  c1 cmp indx c4 cpy zp   c5 cmp zp   c6 dec zp   c8 iny imp
c9 cmp imm  ca dex imp  cc cpy abs  cd cmp abs  ce dec abs  d0 bne rel  d1 cmp indy
d5 cmp zpx  d6 dec zpx  d8 cld imp  d9 cmp absy dd cmp absx de dec absx e0 cpx imm
e1 sbc indx e4 cpx zp   e5 sbc zp   e6 inc zp   e8 inx imp  e9 sbc imm  ea nop imp
ec cpx abs  ed sbc abs  ee inc abs  f0 beq rel  f1 sbc indy f5 sbc zpx  f6 inc zpx
f8 sed imp  f9 sbc absy fd sbc absx fe inc absx
"""

# opcode -> (mnemonic, mode)
OPCODES = {}
_tok = _TABLE.split()
for i in range(0, len(_tok), 3):
    OPCODES[int(_tok[i], 16)] = (_tok[i + 1], _tok[i + 2])

# (mnemonic, mode) -> opcode
ENCODE = {v: k for k, v in OPCODES.items()}

BRANCHES = {"bpl", "bmi", "bvc", "bvs", "bcc", "bcs", "bne", "beq"}
