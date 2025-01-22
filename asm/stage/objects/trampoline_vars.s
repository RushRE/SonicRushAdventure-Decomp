	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public Trampoline3D__dword_218A390
Trampoline3D__dword_218A390: // 0x0218A390
	.space 0x04

	.rodata

.public Trampoline__word_218874C
Trampoline__word_218874C: // 0x0218874C
    .hword 1, 2, 2
	.align 4

	.data
	
.public Trampoline__elevationTable
Trampoline__elevationTable:
	.byte 0x00, 0xFE
	.align 4

aActAcGmkTrampo: // 0x021898E4
	.asciz "/act/ac_gmk_trampoline3d.bac"
	.align 4