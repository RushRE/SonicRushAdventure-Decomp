	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start OS_ResetSystem
OS_ResetSystem: // 0x037FE528
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl MI_StopDma
	mov r0, #1
	bl MI_StopDma
	mov r0, #2
	bl MI_StopDma
	mov r0, #3
	bl MI_StopDma
	mov r0, #0x40000
	bl OS_SetIrqMask
	mvn r0, #0
	bl OS_ResetRequestIrqMask
	bl SND_Shutdown
	mov r0, #0x10
	bl OSi_SendToPxi
	bl OSi_DoResetSystem
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end OS_ResetSystem

	arm_func_start OSi_SendToPxi
OSi_SendToPxi: // 0x037FE57C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0, lsl #8
	mov r5, #0xc
	mov r4, #0
_037FE58C:
	mov r0, r5
	mov r1, r6
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	bne _037FE58C
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end OSi_SendToPxi

	arm_func_start OSi_CommonCallback
OSi_CommonCallback: // 0x037FE5AC
	stmdb sp!, {lr}
	sub sp, sp, #4
	and r0, r1, #0x7f00
	mov r0, r0, lsl #8
	mov r0, r0, lsr #0x10
	cmp r0, #0x10
	moveq r1, #1
	ldreq r0, _037FE5E4 // =0x038085EC
	streqh r1, [r0]
	beq _037FE5D8
	bl OS_Terminate
_037FE5D8:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FE5E4: .word 0x038085EC
	arm_func_end OSi_CommonCallback

	arm_func_start OS_IsResetOccurred
OS_IsResetOccurred: // 0x037FE5E8
	ldr r0, _037FE5F4 // =0x038085EC
	ldrh r0, [r0]
	bx lr
	.align 2, 0
_037FE5F4: .word 0x038085EC
	arm_func_end OS_IsResetOccurred

	arm_func_start OS_InitReset
OS_InitReset: // 0x037FE5F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _037FE630 // =0x038085E8
	ldrh r1, [r0]
	cmp r1, #0
	bne _037FE624
	mov r1, #1
	strh r1, [r0]
	mov r0, #0xc
	ldr r1, _037FE634 // =OSi_CommonCallback
	bl PXI_SetFifoRecvCallback
_037FE624:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FE630: .word 0x038085E8
_037FE634: .word OSi_CommonCallback
	arm_func_end OS_InitReset