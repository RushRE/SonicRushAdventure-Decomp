	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public ObjDrawValue_21399A8
ObjDrawValue_21399A8: // 0x021399A8
    .space 0x1 * 2

.public ObjDrawValue_21399AA
ObjDrawValue_21399AA: // 0x021399AA
    .space 32 * 0x04

.public ObjDraw__Palette1
ObjDraw__Palette1: // 0x02139A2A
    .space 0x2 * 0x100

.public ObjDraw__Palette2
ObjDraw__Palette2: // 0x02139C2A
    .space 0x2 * 0x100
	.align 4
