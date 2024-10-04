	.include "asm/macros.inc"
	.include "global.inc"

	.rodata
	
.public SoundTest__touchAreaTable
SoundTest__touchAreaTable: // 0x02161908
	.hword 1, 2, 3, 4, 0xB

.public _02161912
_02161912: // 0x02161912
	.hword 5, 3, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	.hword 1, 1, 1, 2, 2, 3, 5

.public _02161942
_02161942: // 0x02161942
	.hword 0, 0xC, 0, 3, 0, 0, 1, 0, 0, 2, 2, 0, 0, 4, 3, 0, 0
	.hword 6, 4, 0, 0, 0xA, 5, 0, 0, 0xB, 5, 0, 0, 0xD, 6, 0x803
	.hword 0, 0xE, 6, 0, 0, 0xF, 7, 0x403, 1, 0, 8, 0, 0, 8, 9
	.hword 0, 0, 0x2D8, 4, 0x1C71, 8, 0x1C, 0, 4, 0, 0x10, 0
	.hword 0x10, 0, 8, 0, 0x10, 0, 8, 0, 0x30, 0, 0x400, 0, 0x30
	.hword 0, 0, 0, 0x20, 0, 7, 0, 0x15, 0