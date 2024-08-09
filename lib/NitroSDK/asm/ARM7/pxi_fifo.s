	.include "asm/macros.inc"
	.include "global.inc"
	.text

	arm_func_start PXIi_GetFromFifo
PXIi_GetFromFifo: // 0x037FE9CC
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #8
	ldr sl, _037FEAE0 // =0x04000184
	ldr r5, _037FEAE4 // =0x038085F4
	mov r7, #0x4100000
	mov r6, #0
	mvn r8, #3
	mvn sb, #2
	ldr r4, _037FEAE8 // =0x04000188
_037FE9F0:
	ldrh r0, [sl]
	ands r0, r0, #0x4000
	ldrneh r0, [sl]
	orrne r0, r0, #0xc000
	strneh r0, [sl]
	movne r1, sb
	bne _037FEA38
	bl OS_DisableInterrupts
	ldrh r1, [sl]
	ands r1, r1, #0x100
	beq _037FEA28
	bl OS_RestoreInterrupts
	mov r1, r8
	b _037FEA38
_037FEA28:
	ldr r1, [r7]
	str r1, [sp]
	bl OS_RestoreInterrupts
	mov r1, r6
_037FEA38:
	cmp r1, r8
	beq _037FEAD4
	mvn r0, #2
	cmp r1, r0
	beq _037FE9F0
	ldr r2, [sp]
	mov r0, r2, lsl #0x1b
	movs r0, r0, lsr #0x1b
	beq _037FE9F0
	ldr r3, [r5, r0, lsl #2]
	cmp r3, #0
	beq _037FEA80
	mov r1, r2, lsr #6
	mov r2, r2, lsl #0x1a
	mov r2, r2, lsr #0x1f
	mov lr, pc
	bx r3
_37FEA7C: // 0x037FEA7C
	b _037FE9F0
_037FEA80:
	mov r0, r2, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _037FE9F0
	orr r0, r2, #0x20
	str r0, [sp]
	ldrh r0, [sl]
	ands r0, r0, #0x4000
	ldrneh r0, [sl]
	orrne r0, r0, #0xc000
	strneh r0, [sl]
	bne _037FE9F0
	bl OS_DisableInterrupts
	ldrh r1, [sl]
	ands r1, r1, #2
	beq _037FEAC4
	bl OS_RestoreInterrupts
	b _037FE9F0
_037FEAC4:
	ldr r1, [sp]
	str r1, [r4]
	bl OS_RestoreInterrupts
	b _037FE9F0
_037FEAD4:
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, lr}
	bx lr
	.align 2, 0
_037FEAE0: .word 0x04000184
_037FEAE4: .word 0x038085F4
_037FEAE8: .word 0x04000188
	arm_func_end PXIi_GetFromFifo

	arm_func_start PXI_SendWordByFifo
PXI_SendWordByFifo: // 0x037FEAEC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, [sp]
	bic r3, r3, #0x1f
	and r0, r0, #0x1f
	orr r0, r3, r0
	str r0, [sp]
	bic r3, r0, #0x20
	and r0, r2, #1
	orr r0, r3, r0, lsl #5
	str r0, [sp]
	and r2, r0, #0x3f
	bic r0, r1, #0xfc000000
	orr r0, r2, r0, lsl #6
	str r0, [sp]
	ldr r1, _037FEB88 // =0x04000184
	ldrh r0, [r1]
	ands r0, r0, #0x4000
	ldrneh r0, [r1]
	orrne r0, r0, #0xc000
	strneh r0, [r1]
	mvnne r0, #0
	bne _037FEB7C
	bl OS_DisableInterrupts
	ldr r1, _037FEB88 // =0x04000184
	ldrh r1, [r1]
	ands r1, r1, #2
	beq _037FEB68
	bl OS_RestoreInterrupts
	mvn r0, #1
	b _037FEB7C
_037FEB68:
	ldr r2, [sp]
	ldr r1, _037FEB8C // =0x04000188
	str r2, [r1]
	bl OS_RestoreInterrupts
	mov r0, #0
_037FEB7C:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FEB88: .word 0x04000184
_037FEB8C: .word 0x04000188
	arm_func_end PXI_SendWordByFifo

	arm_func_start PXI_IsCallbackReady
PXI_IsCallbackReady: // 0x037FEB90
	mov r3, #1
	mov r2, r3, lsl r0
	ldr r0, _037FEBB4 // =0x027FFC00
	add r0, r0, r1, lsl #2
	ldr r0, [r0, #0x388]
	ands r0, r2, r0
	moveq r3, #0
	mov r0, r3
	bx lr
	.align 2, 0
_037FEBB4: .word 0x027FFC00
	arm_func_end PXI_IsCallbackReady

	arm_func_start PXI_SetFifoRecvCallback
PXI_SetFifoRecvCallback: // 0x037FEBB8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r5, r1
	bl OS_DisableInterrupts
	ldr r1, _037FEC1C // =0x038085F4
	str r5, [r1, r4, lsl #2]
	cmp r5, #0
	beq _037FEBF4
	ldr r3, _037FEC20 // =0x027FFC00
	ldr r2, [r3, #0x38c]
	mov r1, #1
	orr r1, r2, r1, lsl r4
	str r1, [r3, #0x38c]
	b _037FEC0C
_037FEBF4:
	ldr r3, _037FEC20 // =0x027FFC00
	ldr r2, [r3, #0x38c]
	mov r1, #1
	mvn r1, r1, lsl r4
	and r1, r2, r1
	str r1, [r3, #0x38c]
_037FEC0C:
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FEC1C: .word 0x038085F4
_037FEC20: .word 0x027FFC00
	arm_func_end PXI_SetFifoRecvCallback

	arm_func_start PXI_InitFifo
PXI_InitFifo: // 0x037FEC24
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl OS_DisableInterrupts
	mov r5, r0
	ldr r0, _037FECE4 // =0x038085F0
	ldrh r1, [r0]
	cmp r1, #0
	bne _037FECD4
	mov r1, #1
	strh r1, [r0]
	mov r2, #0
	ldr r0, _037FECE8 // =0x027FFC00
	str r2, [r0, #0x38c]
	mov r1, r2
	ldr r0, _037FECEC // =0x038085F4
_037FEC5C:
	str r1, [r0, r2, lsl #2]
	add r2, r2, #1
	cmp r2, #0x20
	blt _037FEC5C
	ldr r1, _037FECF0 // =0x0000C408
	ldr r0, _037FECF4 // =0x04000184
	strh r1, [r0]
	mov r0, #0x40000
	bl OS_ResetRequestIrqMask
	mov r0, #0x40000
	ldr r1, _037FECF8 // =PXIi_GetFromFifo
	bl OS_SetIrqFunction
	mov r0, #0x40000
	bl OS_EnableIrqMask
	mov r4, #8
	mov r6, r4
	ldr r8, _037FECFC // =0x04000180
	mov r7, #0x3e8
	b _037FECCC
_037FECA8:
	mov r0, r4, lsl #8
	strh r0, [r8]
	mov r0, r7
	bl OS_SpinWait
	ldrh r0, [r8]
	and r0, r0, #0xf
	cmp r0, r4
	movne r4, r6
	sub r4, r4, #1
_037FECCC:
	cmp r4, #0
	bge _037FECA8
_037FECD4:
	mov r0, r5
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_037FECE4: .word 0x038085F0
_037FECE8: .word 0x027FFC00
_037FECEC: .word 0x038085F4
_037FECF0: .word 0x0000C408
_037FECF4: .word 0x04000184
_037FECF8: .word PXIi_GetFromFifo
_037FECFC: .word 0x04000180
	arm_func_end PXI_InitFifo