	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CARDi_Request
CARDi_Request: // 0x020F0EE8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r6, r0
	ldr r0, [r6, #0x114]
	mov r5, r1
	mov r4, r2
	ands r0, r0, #2
	bne _020F0F60
	ldr r1, [r6, #0x114]
	mov r0, #0xb
	orr r2, r1, #2
	mov r1, #1
	str r2, [r6, #0x114]
	bl PXI_IsCallbackReady
	cmp r0, #0
	bne _020F0F50
	mov r9, #0x64
	mov r8, #0xb
	mov r7, #1
_020F0F34:
	mov r0, r9
	bl OS_SpinWait
	mov r0, r8
	mov r1, r7
	bl PXI_IsCallbackReady
	cmp r0, #0
	beq _020F0F34
_020F0F50:
	mov r0, r6
	mov r1, #0
	mov r2, #1
	bl CARDi_Request
_020F0F60:
	ldr r0, [r6]
	mov r1, #0x60
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	mov r9, #0xb
	mov r8, #1
	mov r7, #0
	mov r11, #0x60
_020F0F80:
	str r5, [r6, #4]
	ldr r0, [r6, #0x114]
	orr r0, r0, #0x20
	str r0, [r6, #0x114]
_020F0F90:
	mov r0, r9
	mov r1, r5
	mov r2, r8
	bl PXI_SendWordByFifo
	cmp r0, #0
	blt _020F0F90
	cmp r5, #0
	bne _020F0FCC
	ldr r10, [r6]
_020F0FB4:
	mov r0, r9
	mov r1, r10
	mov r2, r8
	bl PXI_SendWordByFifo
	cmp r0, #0
	blt _020F0FB4
_020F0FCC:
	bl OS_DisableInterrupts
	ldr r1, [r6, #0x114]
	mov r10, r0
	ands r0, r1, #0x20
	beq _020F0FF4
_020F0FE0:
	mov r0, r7
	bl OS_SleepThread
	ldr r0, [r6, #0x114]
	ands r0, r0, #0x20
	bne _020F0FE0
_020F0FF4:
	mov r0, r10
	bl OS_RestoreInterrupts
	ldr r0, [r6]
	mov r1, r11
	bl DC_InvalidateRange
	ldr r0, [r6]
	ldr r0, [r0]
	cmp r0, #4
	bne _020F1024
	sub r4, r4, #1
	cmp r4, #0
	bgt _020F0F80
_020F1024:
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	arm_func_end CARDi_Request

	arm_func_start CARDi_TaskThread
CARDi_TaskThread: // 0x020F103C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r5, _020F1094 // =0x021500E0
	mov r6, #0
	add r7, r5, #0x44
_020F1050:
	bl OS_DisableInterrupts
	ldr r1, [r5, #0x114]
	mov r4, r0
	ands r0, r1, #8
	bne _020F107C
_020F1064:
	mov r0, r6
	str r7, [r5, #0x104]
	bl OS_SleepThread
	ldr r0, [r5, #0x114]
	ands r0, r0, #8
	beq _020F1064
_020F107C:
	mov r0, r4
	bl OS_RestoreInterrupts
	ldr r1, [r5, #0x40]
	mov r0, r5
	blx r1
	b _020F1050
	.align 2, 0
_020F1094: .word 0x021500E0
	arm_func_end CARDi_TaskThread

	arm_func_start CARDi_OnFifoRecv
CARDi_OnFifoRecv: // 0x020F1098
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0xb
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	cmp r2, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	ldr r1, _020F10E4 // =0x021500E0
	ldr r0, [r1, #0x114]
	bic r0, r0, #0x20
	str r0, [r1, #0x114]
	ldr r0, [r1, #0x104]
	bl OS_WakeupThreadDirect
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F10E4: .word 0x021500E0
	arm_func_end CARDi_OnFifoRecv

	arm_func_start CARDi_SendtoPxi
CARDi_SendtoPxi: // 0x020F10E8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r1, r7
	mov r0, #0xe
	mov r2, #0
	bl PXI_SendWordByFifo
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r5, #0xe
	mov r4, #0
_020F1120:
	mov r0, r6
	blx SVC_WaitByLoop
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	bne _020F1120
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end CARDi_SendtoPxi
