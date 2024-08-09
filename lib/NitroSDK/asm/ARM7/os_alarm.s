	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start OSi_AlarmHandler
OSi_AlarmHandler: // 0x037FD988
	stmdb sp!, {r0, lr}
	bl OSi_ArrangeTimer
	ldmia sp!, {r0, lr}
	bx lr
	arm_func_end OSi_AlarmHandler

	arm_func_start OSi_ArrangeTimer
OSi_ArrangeTimer: // 0x037FD998
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r1, #0
	ldr r0, _037FDA8C // =0x04000106
	strh r1, [r0]
	mov r0, #0x10
	bl OS_DisableIrqMask
	ldr r1, _037FDA90 // =0x0380FFF8
	ldr r0, [r1]
	orr r0, r0, #0x10
	str r0, [r1]
	bl OS_GetTick
	ldr r2, _037FDA94 // =0x038085CC
	ldr r4, [r2]
	cmp r4, #0
	beq _037FDA80
	ldr ip, [r4, #0xc]
	ldr r3, [r4, #0x10]
	cmp r1, r3
	cmpeq r0, ip
	bhs _037FD9F8
	mov r0, r4
	bl OSi_SetTimer
	b _037FDA80
_037FD9F8:
	ldr r1, [r4, #0x18]
	str r1, [r2]
	cmp r1, #0
	moveq r0, #0
	streq r0, [r2, #4]
	movne r0, #0
	strne r0, [r1, #0x14]
	ldr r5, [r4]
	ldr r2, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	mov r0, #0
	cmp r1, r0
	cmpeq r2, r0
	streq r0, [r4]
	cmp r5, #0
	beq _037FDA44
	ldr r0, [r4, #4]
	mov lr, pc
	bx r5
_037FDA44:
	ldr r2, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	mov r1, #0
	cmp r0, r1
	cmpeq r2, r1
	beq _037FDA6C
	str r5, [r4]
	mov r0, r4
	mov r2, r1
	bl OSi_InsertAlarm
_037FDA6C:
	ldr r0, _037FDA94 // =0x038085CC
	ldr r0, [r0]
	cmp r0, #0
	beq _037FDA80
	bl OSi_SetTimer
_037FDA80:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FDA8C: .word 0x04000106
_037FDA90: .word 0x0380FFF8
_037FDA94: .word 0x038085CC
	arm_func_end OSi_ArrangeTimer

	arm_func_start OS_CancelAlarm
OS_CancelAlarm: // 0x037FDA98
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r1, [r5]
	cmp r1, #0
	bne _037FDAC0
	bl OS_RestoreInterrupts
	b _037FDB18
_037FDAC0:
	ldr r0, [r5, #0x18]
	cmp r0, #0
	ldreq r2, [r5, #0x14]
	ldreq r1, _037FDB24 // =0x038085CC
	streq r2, [r1, #4]
	ldrne r1, [r5, #0x14]
	strne r1, [r0, #0x14]
	ldr r1, [r5, #0x14]
	cmp r1, #0
	strne r0, [r1, #0x18]
	bne _037FDB00
	ldr r1, _037FDB24 // =0x038085CC
	str r0, [r1]
	cmp r0, #0
	beq _037FDB00
	bl OSi_SetTimer
_037FDB00:
	mov r0, #0
	str r0, [r5]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	mov r0, r4
	bl OS_RestoreInterrupts
_037FDB18:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FDB24: .word 0x038085CC
	arm_func_end OS_CancelAlarm

	arm_func_start OS_SetPeriodicAlarm
OS_SetPeriodicAlarm: // 0x037FDB28
	stmdb sp!, {r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #4
	movs r4, r0
	mov sb, r1
	mov r8, r2
	mov r7, r3
	ldr r6, [sp, #0x20]
	beq _037FDB54
	ldr r0, [r4]
	cmp r0, #0
	beq _037FDB58
_037FDB54:
	bl OS_Terminate
_037FDB58:
	bl OS_DisableInterrupts
	mov r5, r0
	str r7, [r4, #0x1c]
	str r6, [r4, #0x20]
	str sb, [r4, #0x24]
	str r8, [r4, #0x28]
	ldr r0, [sp, #0x24]
	str r0, [r4]
	ldr r0, [sp, #0x28]
	str r0, [r4, #4]
	mov r0, r4
	mov r1, #0
	mov r2, r1
	bl OSi_InsertAlarm
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, sb, lr}
	bx lr
	arm_func_end OS_SetPeriodicAlarm

	arm_func_start OS_SetAlarm
OS_SetAlarm: // 0x037FDBA4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	movs r7, r0
	mov r6, r1
	mov r5, r2
	mov r8, r3
	beq _037FDBC8
	ldr r0, [r7]
	cmp r0, #0
	beq _037FDBCC
_037FDBC8:
	bl OS_Terminate
_037FDBCC:
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, #0
	str r0, [r7, #0x1c]
	str r0, [r7, #0x20]
	str r8, [r7]
	ldr r0, [sp, #0x18]
	str r0, [r7, #4]
	bl OS_GetTick
	mov r2, r0
	mov r0, r7
	adds r3, r6, r2
	adc r2, r5, r1
	mov r1, r3
	bl OSi_InsertAlarm
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end OS_SetAlarm

	arm_func_start OSi_InsertAlarm
OSi_InsertAlarm: // 0x037FDC18
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	ldr r2, [r8, #0x1c]
	ldr r1, [r8, #0x20]
	mov r0, #0
	cmp r1, r0
	cmpeq r2, r0
	beq _037FDC94
	bl OS_GetTick
	ldr r7, [r8, #0x24]
	ldr r6, [r8, #0x28]
	cmp r6, r1
	cmpeq r7, r0
	bhs _037FDC94
	ldr r5, [r8, #0x1c]
	ldr r4, [r8, #0x20]
	subs r0, r0, r7
	sbc r1, r1, r6
	mov r2, r5
	mov r3, r4
	bl _ll_udiv
	mov r2, #1
	adds r2, r0, r2
	adc r0, r1, #0
	umull r3, r1, r5, r2
	mla r1, r5, r0, r1
	mla r1, r4, r2, r1
	adds r7, r7, r3
	adc r6, r6, r1
_037FDC94:
	str r7, [r8, #0xc]
	str r6, [r8, #0x10]
	ldr r0, _037FDD44 // =0x038085CC
	ldr r4, [r0]
	mov r1, #0
	b _037FDD00
_037FDCAC:
	ldr r2, [r4, #0xc]
	ldr r0, [r4, #0x10]
	subs r3, r7, r2
	sbc r2, r6, r0
	subs r0, r3, r1
	sbcs r0, r2, r1
	bge _037FDCFC
	ldr r0, [r4, #0x14]
	str r0, [r8, #0x14]
	str r8, [r4, #0x14]
	str r4, [r8, #0x18]
	ldr r0, [r8, #0x14]
	cmp r0, #0
	strne r8, [r0, #0x18]
	bne _037FDD3C
	ldr r0, _037FDD44 // =0x038085CC
	str r8, [r0]
	mov r0, r8
	bl OSi_SetTimer
	b _037FDD3C
_037FDCFC:
	ldr r4, [r4, #0x18]
_037FDD00:
	cmp r4, #0
	bne _037FDCAC
	mov r0, #0
	str r0, [r8, #0x18]
	ldr r0, _037FDD44 // =0x038085CC
	ldr r1, [r0, #4]
	str r8, [r0, #4]
	str r1, [r8, #0x14]
	cmp r1, #0
	strne r8, [r1, #0x18]
	bne _037FDD3C
	str r8, [r0, #4]
	str r8, [r0]
	mov r0, r8
	bl OSi_SetTimer
_037FDD3C:
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_037FDD44: .word 0x038085CC
	arm_func_end OSi_InsertAlarm

	arm_func_start OS_CreateAlarm
OS_CreateAlarm: // 0x037FDD48
	mov r1, #0
	str r1, [r0]
	str r1, [r0, #8]
	bx lr
	arm_func_end OS_CreateAlarm

	arm_func_start OS_IsAlarmAvailable
OS_IsAlarmAvailable: // 0x037FDD58
	ldr r0, _037FDD64 // =0x038085C8
	ldrh r0, [r0]
	bx lr
	.align 2, 0
_037FDD64: .word 0x038085C8
	arm_func_end OS_IsAlarmAvailable

	arm_func_start OS_InitAlarm
OS_InitAlarm: // 0x037FDD68
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _037FDDB0 // =0x038085C8
	ldrh r0, [r1]
	cmp r0, #0
	bne _037FDDA4
	mov r0, #1
	strh r0, [r1]
	bl OSi_SetTimerReserved
	mov r1, #0
	ldr r0, _037FDDB4 // =0x038085CC
	str r1, [r0]
	str r1, [r0, #4]
	mov r0, #0x10
	bl OS_DisableIrqMask
_037FDDA4:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FDDB0: .word 0x038085C8
_037FDDB4: .word 0x038085CC
	arm_func_end OS_InitAlarm

	arm_func_start OSi_SetTimer
OSi_SetTimer: // 0x037FDDB8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	bl OS_GetTick
	mov r2, #0
	ldr r3, _037FDE44 // =0x04000106
	strh r2, [r3]
	ldr ip, [r4, #0xc]
	ldr r3, [r4, #0x10]
	subs r5, ip, r0
	sbc r4, r3, r1
	mov r0, #1
	ldr r1, _037FDE48 // =OSi_AlarmHandler
	bl OSi_EnterTimerCallback
	mov r1, #0
	subs r0, r5, r1
	sbcs r0, r4, r1
	ldrlt r1, _037FDE4C // =0x0000FFFE
	blt _037FDE1C
	mov r0, #0x10000
	subs r0, r5, r0
	sbcs r0, r4, r1
	mvnlt r0, r5
	movlt r0, r0, lsl #0x10
	movlt r1, r0, lsr #0x10
_037FDE1C:
	ldr r0, _037FDE50 // =0x04000104
	strh r1, [r0]
	mov r1, #0xc1
	ldr r0, _037FDE44 // =0x04000106
	strh r1, [r0]
	mov r0, #0x10
	bl OS_EnableIrqMask
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FDE44: .word 0x04000106
_037FDE48: .word OSi_AlarmHandler
_037FDE4C: .word 0x0000FFFE
_037FDE50: .word 0x04000104
	arm_func_end OSi_SetTimer