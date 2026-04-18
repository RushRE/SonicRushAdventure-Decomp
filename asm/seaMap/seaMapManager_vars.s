	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public sSeaMapManagerUnknown
sSeaMapManagerUnknown: // 0x0210FA78
	.hword 0x600, 0x240, 0x300, 0x120, 0x200, 0xC0

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