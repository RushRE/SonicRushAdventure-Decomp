	.include "asm/macros.inc"
	.include "global.inc"

	.data
	
.public _0218975C
_0218975C:
	.word 0x20100, 0x300

.public Platform__spriteTable
Platform__spriteTable:
	.hword 0x10, 0x18, 0x20, 0x10, 0x10, 8, 0x10
	.align 2

.public Platform__animTable
Platform__animTable:
	.hword 0, 1, 2, 3, 0, 4, 0
	.align 4

aActAcGmkLandBa: // 0x02189780
	.asciz "/act/ac_gmk_land.bac"
	.align 4