	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start BankUnknown__GetBankID
BankUnknown__GetBankID: // 0x02051A1C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GX_GetBankForBG
	tst r4, r0
	movne r0, #0
	ldmneia sp!, {r4, pc}
	bl GX_GetBankForOBJ
	tst r4, r0
	movne r0, #1
	ldmneia sp!, {r4, pc}
	bl GX_GetBankForBGExtPltt
	tst r4, r0
	movne r0, #2
	ldmneia sp!, {r4, pc}
	bl GX_GetBankForOBJExtPltt
	tst r4, r0
	movne r0, #3
	ldmneia sp!, {r4, pc}
	bl GX_GetBankForTex
	tst r4, r0
	movne r0, #4
	ldmneia sp!, {r4, pc}
	bl GX_GetBankForTexPltt
	tst r4, r0
	movne r0, #5
	ldmneia sp!, {r4, pc}
	bl GX_GetBankForClearImage
	tst r4, r0
	movne r0, #6
	ldmneia sp!, {r4, pc}
	bl GX_GetBankForSubBG
	tst r4, r0
	movne r0, #7
	ldmneia sp!, {r4, pc}
	bl GX_GetBankForSubOBJ
	tst r4, r0
	movne r0, #8
	ldmneia sp!, {r4, pc}
	bl GX_GetBankForSubBGExtPltt
	tst r4, r0
	movne r0, #9
	ldmneia sp!, {r4, pc}
	bl GX_GetBankForSubOBJExtPltt
	tst r4, r0
	movne r0, #0xa
	ldmneia sp!, {r4, pc}
	bl GX_GetBankForARM7
	tst r4, r0
	movne r0, #0xb
	ldmneia sp!, {r4, pc}
	bl GX_GetBankForLCDC
	tst r4, r0
	movne r0, #0xc
	moveq r0, #0xe
	ldmia sp!, {r4, pc}
	arm_func_end BankUnknown__GetBankID