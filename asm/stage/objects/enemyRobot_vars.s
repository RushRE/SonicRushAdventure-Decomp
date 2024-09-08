	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public _02188194
_02188194: // 0x02188194
    .hword 0x14, 0x15, 0x14, 0x25, 0x24, 0

.public _021881A0
_021881A0: // 0x021881A0
    .word 3, 4, 5, 6, 7

.public _021881B4
_021881B4: // 0x021881B4
    .hword 0xFF76, 0xFFD8, 0xFFF6, 0xFFF8
	.hword 0xFF42, 0xFFB8, 0xFFF6, 0xFFF8
	.hword 0xFF9C, 0x1E, 0xFFEC, 0x80
	.hword 0xFF92, 0xFFB8, 0xFFF6, 0xFFF8
	.hword 0xFF92, 0xFFB8, 0xFFF6, 0xFFF8

	.data

.public _02188B48
_02188B48:
	.word 0x1E0078, 0xF0003C, 0x78

.public _02188B54
_02188B54:
	.word aActAcEneTriBac 	// "/act/ac_ene_tri.bac"
	.word aActAcEneFlyFis  	// "/act/ac_ene_fly_fish.bac"
	.word aActAcEnePteraB  	// "/act/ac_ene_ptera.bac"
	.word aActAcEneProtSp  	// "/act/ac_ene_prot_span.bac"
	.word aActAcEneProtDa_0	// "/act/ac_ene_prot_damp.bac"

aActAcEneTriBac: // 0x02188B68
	.asciz "/act/ac_ene_tri.bac"
	.align 4
	
aActAcEnePteraB: // 0x02188B7C
	.asciz "/act/ac_ene_ptera.bac"
	.align 4
	
aActAcEneFlyFis: // 0x02188B94
	.asciz "/act/ac_ene_fly_fish.bac"
	.align 4
	
aActAcEneProtSp: // 0x02188BB0
	.asciz "/act/ac_ene_prot_span.bac"
	.align 4
	
aActAcEneProtDa_0: // 0x02188BCC
	.asciz "/act/ac_ene_prot_damp.bac"
	.align 4