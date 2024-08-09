	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start OS_JamMessage
OS_JamMessage: // 0x037FCC54
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r0
	mov r5, r1
	mov r7, r2
	bl OS_DisableInterrupts
	mov r4, r0
	and r8, r7, #1
	add r7, r6, #8
	b _037FCC98
_037FCC78:
	cmp r8, #0
	bne _037FCC90
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #0
	b _037FCCC4
_037FCC90:
	mov r0, r7
	bl OS_SleepThread
_037FCC98:
	ldr r0, [r6, #0x1c]
	cmp r0, #0
	beq _037FCC78
	cmp r5, #0
	ldrne r1, [r6, #0x10]
	ldrne r0, [r6, #0x18]
	ldrne r0, [r1, r0, lsl #2]
	strne r0, [r5]
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #1
_037FCCC4:
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end OS_JamMessage

	arm_func_start OS_ReceiveMessage
OS_ReceiveMessage: // 0x037FCCCC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r0
	mov r5, r1
	mov r7, r2
	bl OS_DisableInterrupts
	mov r4, r0
	and r8, r7, #1
	add r7, r6, #8
	b _037FCD10
_037FCCF0:
	cmp r8, #0
	bne _037FCD08
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #0
	b _037FCD64
_037FCD08:
	mov r0, r7
	bl OS_SleepThread
_037FCD10:
	ldr r0, [r6, #0x1c]
	cmp r0, #0
	beq _037FCCF0
	cmp r5, #0
	ldrne r1, [r6, #0x10]
	ldrne r0, [r6, #0x18]
	ldrne r0, [r1, r0, lsl #2]
	strne r0, [r5]
	ldr r0, [r6, #0x18]
	add r0, r0, #1
	ldr r1, [r6, #0x14]
	bl _s32_div_f
	str r1, [r6, #0x18]
	ldr r0, [r6, #0x1c]
	sub r0, r0, #1
	str r0, [r6, #0x1c]
	mov r0, r6
	bl OS_WakeupThread
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #1
_037FCD64:
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end OS_ReceiveMessage

	arm_func_start OS_SendMessage
OS_SendMessage: // 0x037FCD6C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	mov r5, r1
	mov r7, r2
	bl OS_DisableInterrupts
	mov r4, r0
	and r7, r7, #1
	b _037FCDB0
_037FCD90:
	cmp r7, #0
	bne _037FCDA8
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #0
	b _037FCDF4
_037FCDA8:
	mov r0, r6
	bl OS_SleepThread
_037FCDB0:
	ldr r2, [r6, #0x1c]
	ldr r1, [r6, #0x14]
	cmp r1, r2
	ble _037FCD90
	ldr r0, [r6, #0x18]
	add r0, r0, r2
	bl _s32_div_f
	ldr r0, [r6, #0x10]
	str r5, [r0, r1, lsl #2]
	ldr r0, [r6, #0x1c]
	add r0, r0, #1
	str r0, [r6, #0x1c]
	add r0, r6, #8
	bl OS_WakeupThread
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #1
_037FCDF4:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end OS_SendMessage

	arm_func_start OS_InitMessageQueue
OS_InitMessageQueue: // 0x037FCE00
	mov ip, #0
	str ip, [r0, #4]
	ldr r3, [r0, #4]
	str r3, [r0]
	str ip, [r0, #0xc]
	ldr r3, [r0, #0xc]
	str r3, [r0, #8]
	str r1, [r0, #0x10]
	str r2, [r0, #0x14]
	str ip, [r0, #0x18]
	str ip, [r0, #0x1c]
	bx lr
	arm_func_end OS_InitMessageQueue