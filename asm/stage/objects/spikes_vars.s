	.include "asm/macros.inc"
	.include "global.inc"

	.data
	
.public Spikes__AnimVRAMOffset
Spikes__AnimVRAMOffset:
	.word 0x0000, 0x0A00, 0x0F00, 0x1200, 0x0000

aActAcGmkNeedle: // 0x02188EDC
	.asciz "/act/ac_gmk_needle.bac"
	.align 4