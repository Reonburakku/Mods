"""
Conocimiento manual sobre la ROM. Edita este archivo y vuelve a ejecutar disasm.py
para mejorar el desensamblado (OJO: disasm.py sobrescribe src/*.asm, así que hazlo
antes de empezar a modificar el código, o guarda tus cambios aparte).

Las direcciones se dan como (banco, dirección). El banco 7 es el fijo ($C000-$FFFF).
"""

# Puntos de entrada de código que el análisis automático no encuentra
# (rutinas a las que solo se llega por tablas de punteros, etc.).
ENTRIES = [
]

# Tablas de tablas de rutinas: (banco, dirección, nº entradas, banco de destino, desplazamiento)
# Cada entrada apunta (menos 'desplazamiento') a una tabla de punteros a rutinas.
ROUTINE_TABLE_TABLES = [
    # IA de enemigos: tipo de enemigo -> tabla de rutinas por estado (en el banco 0 o en el 7)
    (7, 0xE6A8, 16, 0, 2),
]

# Tablas de punteros: (banco, dirección, número de entradas .word)
WORD_TABLES = [
]

# Nombres para etiquetas: (banco, dirección) -> nombre
LABELS = {
    (7, 0xC001): "Reset",
    (7, 0xC060): "NMI",
    (7, 0xC0B5): "IRQ",
    (7, 0xC117): "DisablePPU",
    (7, 0xC126): "ClearRAMPages",
    (7, 0xC139): "SwitchBank",          # Y = banco; guarda el anterior en $07EC
    (7, 0xC13F): "SwitchBankNoSave",    # Y = banco
    (7, 0xC146): "RestoreBank",
    (7, 0xC14C): "SwitchToSoundBank",
    (7, 0xC15E): "RestoreFromSoundBank",
    (7, 0xC857): "JumpTable",           # jsr JumpTable / .word ... (A = índice)
    (7, 0xFFD0): "BankSelectTable",     # bytes 0-7 (evita conflictos de bus en UNROM)
}

# Comentarios antes de una dirección: (banco, dirección) -> texto
COMMENTS = {
    (7, 0xC001): "Punto de entrada al encender / reset",
    (7, 0xC060): "Interrupción de VBlank (cada fotograma)",
    (7, 0xC139): "Cambia al banco Y (0-6) en $8000-$BFFF.\n"
                 "UNROM: se escribe en una dirección que contiene el mismo valor para evitar conflictos de bus.",
    (7, 0xC857): "Tabla de saltos en línea: tras 'jsr JumpTable' van .word con destinos; A = índice.",
}

# Variables de RAM con nombre (se escriben en src/nes.inc)
RAM = {
    "CurrentBank": 0x07EC,
    "SavedSoundBank": 0x07ED,
}
