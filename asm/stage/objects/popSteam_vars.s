	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public PopSteam__offsetTable
PopSteam__offsetTable: // 0x021884FC
    .hword 0xFFF0, 0xFFE4
    .hword 0xFFF0, 0xFFE4
    .hword 0xFFFC, 0xFFF0
    .hword 0xFFFC, 0xFFF0

	.data
	
aActAcGmkPopSte: // 0x02189188
	.asciz "/act/ac_gmk_pop_steam.bac"
	.align 4