	.include "asm/macros.inc"
	.include "global.inc"

	.data
	
.public LargePiston__unknown2Table
LargePiston__unknown2Table: // 0x021891C0
	.byte 0x00, 0x40, 0x00, 0x98, 0x00, 0x00, 0x00, 0x40, 0x00, 0xE0, 0x00, 0x00, 0x00, 0x50, 0x00, 0xA0
	.byte 0x00, 0x00, 0x00, 0x18, 0x00, 0x05, 0xE2, 0x58, 0x00, 0x18, 0x00, 0x0D, 0x00, 0xA0, 0x00, 0x50
	.byte 0x00, 0x60, 0x00, 0x00
	
.public LargePiston__unknownTable
LargePiston__unknownTable: // 0x021891E4
	.byte 0x00, 0x00, 0xF0, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x00
	.byte 0x00, 0x00, 0xFA, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x07, 0x00, 0x00, 0x40, 0x01, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x68, 0xFF, 0xFF, 0x00, 0x60, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x4C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF
	.byte 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x40, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0xE0, 0xFF, 0xFF, 0x00, 0x00, 0xCE, 0xFF, 0x00, 0x80, 0x0C, 0x00, 0x00, 0x00, 0x0C, 0x00
	.byte 0x00, 0x20, 0xF4, 0xFF, 0x00, 0x80, 0xFD, 0xFF, 0x00, 0x40, 0x07, 0x00, 0x00, 0xC4, 0x04, 0x00
	.byte 0x00, 0x20, 0xFE, 0xFF, 0x00, 0x68, 0xFF, 0xFF, 0x00, 0x30, 0xFC, 0xFF, 0x00, 0x00, 0x00, 0x00
	.byte 0x99, 0x79, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF
	.byte 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x01, 0x00, 0x00, 0xC0, 0xFF, 0xFF
	.byte 0x00, 0xC0, 0xFF, 0xFF, 0x00, 0x80, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00
	.byte 0x00, 0xE0, 0xFF, 0xFF, 0x00, 0x00, 0x32, 0x00, 0x00, 0x80, 0x0C, 0x00, 0x00, 0x00, 0x0C, 0x00
	.byte 0x00, 0xE0, 0x0B, 0x00, 0x00, 0x80, 0xFD, 0xFF, 0x00, 0x40, 0x07, 0x00, 0x00, 0x3C, 0xFB, 0xFF
	.byte 0x00, 0x20, 0xFE, 0xFF, 0x00, 0x68, 0xFF, 0xFF, 0x00, 0xD0, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x99, 0x79, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF
	.byte 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x01, 0x00, 0x00, 0x40, 0x00, 0x00
	.byte 0x00, 0xC0, 0xFF, 0xFF, 0x00, 0x80, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0xFF, 0x00, 0x10, 0x00, 0x00
	.byte 0x00, 0xE0, 0xFF, 0xFF

aModGmkLPistonN: // 0x02189304
	.asciz "/mod/gmk_l_piston.nsbmd"
	.align 4

aActAcGmkLPisto: // 0x0218931C
	.asciz "/act/ac_gmk_l_piston.bac"
	.align 4