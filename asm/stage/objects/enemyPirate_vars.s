	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public _021881DC
_021881DC: // 0x021881DC
    .hword 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x50, 0x52, 0, 7, 5, 6, 0xD, 5, 7

.public _021881F8
_021881F8: // 0x021881F8
    .hword 0x78, 0x78, 0x78, 0x78, 0x78, 0x78, 0x78, 0
	
.public _02188208
_02188208: // 0x02188208
    .hword 0, 0, 0x3000, 0xFFFB, 0xB000, 0xFFFC, 0x7000, 0xFFFC

.public _02188218
_02188218: // 0x02188218
    .word 0xF, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15
	
.public _02188234
_02188234: // 0x02188234
    .word 0xA000              
	
.public _02188238
_02188238: // 0x02188238
    .word 0xFFFC3000, 0xFFFF1000, 0xFFFBD000, 0xFFFCB000, 0xFFFDA000, 0xFFFD6000, 0xFFFDB000
	
.public _02188254
_02188254: // 0x02188254
	.hword 0xFF9C, 0xFFC0, 0, 0
	.hword 0xFF9C, 0xFFC0, 0, 0
	.hword 0xFF80, 0xFFC0, 0, 0
	.hword 0xFF9C, 0xFFC0, 0, 0
	.hword 0xFF9C, 0xFFC0, 0, 0
	.hword 0xFFB7, 0, 0x17, 0x80
	.hword 0xFF6A, 0, 0, 0x80

.public _0218828C
_0218828C: // 0x0218828C
    .word 0, 0xFFFC0000
	.word 0, 0xFFFC0000
	.word 0, 0xFFFC0000
	.word 0, 0xFFFC0000
	.word 0, 0xFFFC0000
	.word 0, 0xFFFC0000
	.word 0, 0xFFFC0000

.public _021882C4
_021882C4: // 0x021882C4
    .word 0                   
	
.public _021882C8
_021882C8: // 0x021882C8
    .word 0                   
	
.public _021882CC
_021882CC: // 0x021882CC
	.word 0xFFFEE000, 0xFFFD9000, 0, 0

.public _021882DC
_021882DC: // 0x021882DC
	.word 0xFFFEC000, 0xFFFCE000, 0xFFFE7000, 0xFFFC4000, 0xFFFE7000
	.word 0x11000, 0xFFFDB000, 0x11000
	
	.data

aActAcEnePrtBom: // 0x02188CA4
	.asciz "/act/ac_ene_prt_bomb.bac"
	.align 4
	
aActAcEnePrtHog: // 0x02188CC0
	.asciz "/act/ac_ene_prt_hogun.bac"
	.align 4
	
aActAcEneHobarG: // 0x02188CDC
	.asciz "/act/ac_ene_hobar_gun.bac"
	.align 4
	
aActAcEnePrtKni: // 0x02188CF8
	.asciz "/act/ac_ene_prt_knife.bac"
	.align 4
	
aActAcEnePSkele: // 0x02188D14
	.asciz "/act/ac_ene_p_skeleton.bac"
	.align 4
	
aActAcEneHobarB: // 0x02188D30
	.asciz "/act/ac_ene_hobar_bomb.bac"
	.align 4
	
.public _02188D4C
_02188D4C:
	.word aActAcEnePrtKni // "/act/ac_ene_prt_knife.bac"

.public _02188D50
_02188D50:
	.word aActAcEnePrtBaz // "/act/ac_ene_prt_bazooka.bac"

.public _02188D54
_02188D54:
	.word aActAcEnePrtHog // "/act/ac_ene_prt_hogun.bac"

.public _02188D58
_02188D58:
	.word aActAcEnePrtBom //  "/act/ac_ene_prt_bomb.bac"

.public _02188D5C
_02188D5C:
	.word aActAcEnePSkele // "/act/ac_ene_p_skeleton.bac"

.public _02188D60
_02188D60:
	.word aActAcEneHobarB //  "/act/ac_ene_hobar_bomb.bac"

.public _02188D64
_02188D64:
	.word aActAcEneHobarG //  "/act/ac_ene_hobar_gun.bac"

aActAcEnePrtBaz: // 0x02188D68
	.asciz "/act/ac_ene_prt_bazooka.bac"
	.align 4