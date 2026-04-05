	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public SeaMapManager__ZoomOutScaleTable
SeaMapManager__ZoomOutScaleTable: // 0x0210FB1C
	.word 0x1000, 0x800, 0x555

.public SeaMapManager__ZoomInScaleTable
SeaMapManager__ZoomInScaleTable: // 0x0210FB28
	.word 0x1000, 0x2000, 0x3000

.public _0210FB34
_0210FB34:
	.word 0x00, 0x00, 0x00

.public dword_210FB40
dword_210FB40: // 0x0210FB40 
	.word 0, 0xFF, 0xFF00, 0xFFFF, 0xFF0000, 0xFF00FF, 0xFFFF00
	.word 0xFFFFFF, 0xFF000000, 0xFF0000FF, 0xFF00FF00, 0xFF00FFFF
	.word 0xFFFF0000, 0xFFFF00FF, 0xFFFFFF00, 0xFFFFFFFF

	.data
	
aBbChBb: // 0x0211993C
	.asciz "/bb/ch.bb"
	.align 4

.public aCh
aCh: // 0x02119948
	.asciz "ch"
	.align 4