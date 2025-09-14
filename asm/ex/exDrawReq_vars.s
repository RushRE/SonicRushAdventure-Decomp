	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

.public exDrawFadeTask__word_2176444
exDrawFadeTask__word_2176444: // 0x02176444
	.space 0x04

.public exDrawFadeTask__word_2176448
exDrawFadeTask__word_2176448: // 0x02176448
	.space 0x04

.public exDrawReqTask__word_217644C
exDrawReqTask__word_217644C: // 0x0217644C
	.space 0x02

	.align 4

.public exDrawReqTask__unk_2176450
exDrawReqTask__unk_2176450: // 0x02176450
    .space 0x04
	
.public exDrawReqTask__dword_2176454
exDrawReqTask__dword_2176454: // 0x02176454
    .space 0x04
	
.public exDrawReqTask__Value_2176458
exDrawReqTask__Value_2176458: // 0x02176458
    .space 0x04
	
.public exDrawReqTask__dword_217645C
exDrawReqTask__dword_217645C: // 0x0217645C
    .space 0x04
	
.public exDrawReqTask__unk_2176460
exDrawReqTask__unk_2176460: // 0x02176460
    .space 0x04

	.data
	
aExdrawreqtask: // 0x021743E0
	.asciz "exDrawReqTask"