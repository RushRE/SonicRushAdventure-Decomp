	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public DecorationSys__TempDecorBitfield
DecorationSys__TempDecorBitfield: // 0x02189EA4
	.space 0x04 * 2

.public decorUnknownList
decorUnknownList: // 0x02189EAC
	.space 0x08 * 4

.public DecorationSys__TempDecorList
DecorationSys__TempDecorList: // 0x02189ECC
	.space 0x04 * 32

.public decorFileList
decorFileList: // 0x02189F4C
	.space 0x08 * 20 // File

.public decorSpriteRefList
decorSpriteRefList: // 0x02189FEC
	.space 0x10 * 55 // File[2]