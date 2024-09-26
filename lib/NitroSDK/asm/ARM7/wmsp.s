	.include "asm/macros.inc"
	.include "global.inc"

    .section .wram,4

	arm_func_start WMSP_GetAllowedChannel
WMSP_GetAllowedChannel: // 0x038080A0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r1, _038081C8 // =0x00001FFF
	and r0, r0, r1
	mov r0, r0, lsl #0x10
	movs r6, r0, lsr #0x10
	moveq r0, #0
	beq _038081BC
	mov r9, #0
	mov r0, #1
	b _038080DC
_038080CC:
	mov r1, r0, lsl r9
	ands r1, r6, r1
	bne _038080E4
	add r9, r9, #1
_038080DC:
	cmp r9, #0x10
	blt _038080CC
_038080E4:
	mov r10, #0xf
	mov r0, #1
	b _03808100
_038080F0:
	mov r1, r0, lsl r10
	ands r1, r6, r1
	bne _03808108
	sub r10, r10, #1
_03808100:
	cmp r10, #0
	bne _038080F0
_03808108:
	sub r5, r10, r9
	cmp r5, #5
	movlt r0, #1
	movlt r0, r0, lsl r9
	movlt r0, r0, lsl #0x10
	movlt r0, r0, lsr #0x10
	blt _038081BC
	add r0, r10, r9
	mov r1, #2
	bl _s32_div_f
	mov r8, r0
	mov r7, #0
	mov r11, #2
	mov r4, #1
	b _0380816C
_03808144:
	mov r0, r7
	mov r1, r11
	bl _s32_div_f
	mov r0, r1, lsl #1
	sub r0, r0, #1
	mla r8, r7, r0, r8
	mov r0, r4, lsl r8
	ands r0, r6, r0
	bne _03808174
	add r7, r7, #1
_0380816C:
	cmp r7, r5
	blt _03808144
_03808174:
	sub r0, r10, r8
	cmp r0, #5
	blt _0380818C
	sub r0, r8, r9
	cmp r0, #5
	bge _038081A4
_0380818C:
	mov r0, #1
	mov r1, r0, lsl r9
	orr r0, r1, r0, lsl r10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	b _038081BC
_038081A4:
	mov r1, #1
	mov r0, r1, lsl r10
	orr r0, r0, r1, lsl r8
	orr r0, r0, r1, lsl r9
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
_038081BC:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_038081C8: .word 0x00001FFF
	arm_func_end WMSP_GetAllowedChannel

	arm_func_start WMSP_GetBuffer4Callback2Wm9
WMSP_GetBuffer4Callback2Wm9: // 0x038081CC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _0380821C // =0x027F997C
	bl OS_LockMutex
	mov r5, #0x100
	ldr r4, _03808220 // =0x027FFF96
	b _038081F0
_038081E8:
	mov r0, r5
	bl _Ven_SVC_WaitByLoop
_038081F0:
	ldrh r0, [r4]
	ands r1, r0, #1
	bne _038081E8
	orr r0, r0, #1
	strh r0, [r4]
	ldr r0, _03808224 // =0x027F9454
	ldr r0, [r0, #0x54c]
	ldr r0, [r0, #8]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_0380821C: .word 0x027F997C
_03808220: .word 0x027FFF96
_03808224: .word 0x027F9454
	arm_func_end WMSP_GetBuffer4Callback2Wm9

	arm_func_start WMSP_ReturnResult2Wm9
WMSP_ReturnResult2Wm9: // 0x03808228
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, #0x100
	mov r5, #0xa
	mov r4, #0
	b _0380824C
_03808244:
	mov r0, r6
	bl _Ven_SVC_WaitByLoop
_0380824C:
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	blt _03808244
	ldr r0, _03808278 // =0x027F997C
	bl OS_UnlockMutex
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_03808278: .word 0x027F997C
	arm_func_end WMSP_ReturnResult2Wm9