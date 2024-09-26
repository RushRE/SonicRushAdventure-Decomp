	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start OSi_GetVFrame
OSi_GetVFrame: // 0x037FDE54
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, _037FDE98 // =OSi_PreviousVCount
	ldr r1, [r1]
	cmp r4, r1
	ldrlt r1, _037FDE9C // =OSi_VFrameCount
	ldrlt r2, [r1]
	addlt r2, r2, #1
	strlt r2, [r1]
	ldr r1, _037FDE98 // =OSi_PreviousVCount
	str r4, [r1]
	bl OS_RestoreInterrupts
	ldr r0, _037FDE9C // =OSi_VFrameCount
	ldr r0, [r0]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FDE98: .word OSi_PreviousVCount
_037FDE9C: .word OSi_VFrameCount
	arm_func_end OSi_GetVFrame

	arm_func_start OSi_CompareVCount
OSi_CompareVCount: // 0x037FDEA0
	ldr r3, [r0, #0xc]
	subs r3, r1, r3
	ldrsh r1, [r0, #0x10]
	sub r2, r2, r1
	bmi _037FDEC4
	cmp r3, #0
	bne _037FDECC
	cmp r2, #0
	bge _037FDECC
_037FDEC4:
	mov r0, #0
	bx lr
_037FDECC:
	cmp r2, #0
	ldrlt r1, _037FDEEC // =0x00000107
	addlt r2, r2, r1
	ldrsh r0, [r0, #0x12]
	cmp r2, r0
	movle r0, #1
	movgt r0, #2
	bx lr
	.align 2, 0
_037FDEEC: .word 0x00000107
	arm_func_end OSi_CompareVCount

	arm_func_start OSi_VAlarmHandler
OSi_VAlarmHandler: // 0x037FDEF0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r0, #4
	bl OS_DisableIrqMask
	ldr r2, _037FE064 // =0x04000004
	ldrh r0, [r2]
	bic r0, r0, #0x20
	strh r0, [r2]
	ldr r1, _037FE068 // =0x0380FFF8
	ldr r0, [r1]
	orr r0, r0, #4
	str r0, [r1]
	ldrh r2, [r2]
	mov r0, r2, asr #8
	and r1, r0, #0xff
	mov r0, r2, lsl #1
	and r0, r0, #0x100
	orr r0, r1, r0
	sub r0, r0, #1
	bl OSi_GetVFrame
	ldr r9, _037FE06C // =0x04000006
	mov r6, #4
	ldr r5, _037FE064 // =0x04000004
	mov r4, #0
	ldr r11, _037FE070 // =OSi_VFrameCount
	b _037FE048
_037FDF58:
	ldrh r8, [r9]
	mov r0, r8
	bl OSi_GetVFrame
	mov r7, r0
	mov r0, r10
	mov r1, r7
	mov r2, r8
	bl OSi_CompareVCount
	cmp r0, #0
	beq _037FDF94
	cmp r0, #1
	beq _037FDFD4
	cmp r0, #2
	beq _037FE02C
	b _037FE048
_037FDF94:
	mov r0, r10
	bl OSi_SetNextVAlarm
	ldrh r1, [r9]
	ldrsh r0, [r10, #0x10]
	cmp r0, r1
	bne _037FE058
	ldr r0, [r10, #0xc]
	cmp r0, r7
	bne _037FE058
	mov r0, r6
	bl OS_DisableIrqMask
	ldrh r0, [r5]
	bic r0, r0, #0x20
	strh r0, [r5]
	mov r0, r6
	bl OS_ResetRequestIrqMask
_037FDFD4:
	ldr r7, [r10]
	mov r0, r10
	bl OSi_DetachVAlarm
	str r4, [r10]
	cmp r7, #0
	beq _037FDFF8
	ldr r0, [r10, #4]
	mov lr, pc
	bx r7
_037FDFF8:
	ldr r0, [r10, #0x1c]
	cmp r0, #0
	beq _037FE048
	ldr r0, [r10, #0x24]
	cmp r0, #0
	bne _037FE048
	str r7, [r10]
	ldr r0, [r11]
	add r0, r0, #1
	str r0, [r10, #0xc]
	mov r0, r10
	bl OSi_AppendVAlarm
	b _037FE048
_037FE02C:
	mov r0, r10
	bl OSi_DetachVAlarm
	mov r0, r10
	bl OSi_AppendVAlarm
	ldr r0, [r11]
	add r0, r0, #1
	str r0, [r10, #0xc]
_037FE048:
	ldr r0, _037FE074 // =OSi_VAlarmQueue
	ldr r10, [r0]
	cmp r10, #0
	bne _037FDF58
_037FE058:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_037FE064: .word 0x04000004
_037FE068: .word 0x0380FFF8
_037FE06C: .word 0x04000006
_037FE070: .word OSi_VFrameCount
_037FE074: .word OSi_VAlarmQueue
	arm_func_end OSi_VAlarmHandler

	arm_func_start OS_CancelVAlarms
OS_CancelVAlarms: // 0x037FE078
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	bl OS_DisableInterrupts
	mov r5, r0
	cmp r7, #0
	bne _037FE098
	bl OS_Terminate
_037FE098:
	ldr r0, _037FE0F0 // =OSi_VAlarmQueue
	ldr r0, [r0]
	cmp r0, #0
	ldrne r6, [r0, #0x18]
	moveq r6, #0
	mov r4, #0
	b _037FE0D4
_037FE0B4:
	ldr r1, [r0, #8]
	cmp r1, r7
	bne _037FE0C4
	bl OS_CancelVAlarm
_037FE0C4:
	mov r0, r6
	cmp r6, #0
	ldrne r6, [r6, #0x18]
	moveq r6, r4
_037FE0D4:
	cmp r0, #0
	bne _037FE0B4
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037FE0F0: .word OSi_VAlarmQueue
	arm_func_end OS_CancelVAlarms

	arm_func_start OS_CancelVAlarm
OS_CancelVAlarm: // 0x037FE0F4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	mov r4, r0
	mov r1, #1
	str r1, [r5, #0x24]
	ldr r1, [r5]
	cmp r1, #0
	bne _037FE124
	bl OS_RestoreInterrupts
	b _037FE13C
_037FE124:
	mov r0, r5
	bl OSi_DetachVAlarm
	mov r0, #0
	str r0, [r5]
	mov r0, r4
	bl OS_RestoreInterrupts
_037FE13C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end OS_CancelVAlarm

	arm_func_start OS_SetVAlarmTag
OS_SetVAlarmTag: // 0x037FE148
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	movs r4, r1
	bne _037FE160
	bl OS_Terminate
_037FE160:
	cmp r5, #0
	strne r4, [r5, #8]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end OS_SetVAlarmTag

	arm_func_start OSi_SetNextVAlarm
OSi_SetNextVAlarm: // 0x037FE174
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #4
	ldr r1, _037FE1C8 // =OSi_VAlarmHandler
	bl OS_SetIrqFunction
	ldrsh ip, [r4, #0x10]
	and r3, ip, #0x100
	ldr r1, _037FE1CC // =0x04000004
	ldrh r0, [r1]
	and r2, r0, #0x3f
	and r0, ip, #0xff
	orr r0, r2, r0, lsl #8
	orr r0, r0, r3, asr #1
	strh r0, [r1]
	ldrh r0, [r1]
	orr r0, r0, #0x20
	strh r0, [r1]
	mov r0, #4
	bl OS_EnableIrqMask
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FE1C8: .word OSi_VAlarmHandler
_037FE1CC: .word 0x04000004
	arm_func_end OSi_SetNextVAlarm

	arm_func_start OS_SetPeriodicVAlarm
OS_SetPeriodicVAlarm: // 0x037FE1D0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl OS_DisableInterrupts
	mov r4, r0
	cmp r8, #0
	beq _037FE204
	ldr r0, [r8]
	cmp r0, #0
	beq _037FE208
_037FE204:
	bl OS_Terminate
_037FE208:
	ldr r0, _037FE264 // =0x04000006
	ldrh r9, [r0]
	mov r0, r9
	bl OSi_GetVFrame
	mov r1, #1
	str r1, [r8, #0x1c]
	strh r7, [r8, #0x10]
	cmp r7, r9
	addle r0, r0, #1
	str r0, [r8, #0xc]
	strh r6, [r8, #0x12]
	str r5, [r8]
	ldr r0, [sp, #0x20]
	str r0, [r8, #4]
	mov r0, #0
	str r0, [r8, #0x24]
	mov r0, r8
	bl OSi_InsertVAlarm
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_037FE264: .word 0x04000006
	arm_func_end OS_SetPeriodicVAlarm

	arm_func_start OS_SetVAlarm
OS_SetVAlarm: // 0x037FE268
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl OS_DisableInterrupts
	mov r4, r0
	cmp r8, #0
	beq _037FE29C
	ldr r0, [r8]
	cmp r0, #0
	beq _037FE2A0
_037FE29C:
	bl OS_Terminate
_037FE2A0:
	ldr r0, _037FE2FC // =0x04000006
	ldrh r9, [r0]
	mov r0, r9
	bl OSi_GetVFrame
	mov r1, #0
	str r1, [r8, #0x1c]
	strh r7, [r8, #0x10]
	cmp r7, r9
	addle r0, r0, #1
	str r0, [r8, #0xc]
	strh r6, [r8, #0x12]
	str r5, [r8]
	ldr r0, [sp, #0x20]
	str r0, [r8, #4]
	mov r0, #0
	str r0, [r8, #0x24]
	mov r0, r8
	bl OSi_InsertVAlarm
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_037FE2FC: .word 0x04000006
	arm_func_end OS_SetVAlarm

	arm_func_start OS_CreateVAlarm
OS_CreateVAlarm: // 0x037FE300
	mov r1, #0
	str r1, [r0]
	str r1, [r0, #8]
	str r1, [r0, #0x20]
	bx lr
	arm_func_end OS_CreateVAlarm

	arm_func_start OSi_DetachVAlarm
OSi_DetachVAlarm: // 0x037FE314
	cmp r0, #0
	bxeq lr
	ldr r2, [r0, #0x14]
	ldr r1, [r0, #0x18]
	cmp r1, #0
	strne r2, [r1, #0x14]
	ldreq r0, _037FE348 // =OSi_VAlarmQueue
	streq r2, [r0, #4]
	cmp r2, #0
	strne r1, [r2, #0x18]
	ldreq r0, _037FE348 // =OSi_VAlarmQueue
	streq r1, [r0]
	bx lr
	.align 2, 0
_037FE348: .word OSi_VAlarmQueue
	arm_func_end OSi_DetachVAlarm

	arm_func_start OSi_AppendVAlarm
OSi_AppendVAlarm: // 0x037FE34C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _037FE38C // =OSi_VAlarmQueue
	ldr r3, [r1, #4]
	str r3, [r0, #0x14]
	mov r2, #0
	str r2, [r0, #0x18]
	str r0, [r1, #4]
	cmp r3, #0
	strne r0, [r3, #0x18]
	bne _037FE380
	str r0, [r1]
	bl OSi_SetNextVAlarm
_037FE380:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FE38C: .word OSi_VAlarmQueue
	arm_func_end OSi_AppendVAlarm

	arm_func_start OSi_InsertVAlarm
OSi_InsertVAlarm: // 0x037FE390
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _037FE414 // =OSi_VAlarmQueue
	ldr r3, [r1]
	b _037FE3FC
_037FE3A4:
	ldr r2, [r0, #0xc]
	ldr r1, [r3, #0xc]
	cmp r1, r2
	blo _037FE3F8
	cmp r1, r2
	bne _037FE3CC
	ldrsh r2, [r3, #0x10]
	ldrsh r1, [r0, #0x10]
	cmp r2, r1
	ble _037FE3F8
_037FE3CC:
	ldr r1, [r3, #0x14]
	str r1, [r0, #0x14]
	str r3, [r0, #0x18]
	str r0, [r3, #0x14]
	cmp r1, #0
	strne r0, [r1, #0x18]
	bne _037FE408
	ldr r1, _037FE414 // =OSi_VAlarmQueue
	str r0, [r1]
	bl OSi_SetNextVAlarm
	b _037FE408
_037FE3F8:
	ldr r3, [r3, #0x18]
_037FE3FC:
	cmp r3, #0
	bne _037FE3A4
	bl OSi_AppendVAlarm
_037FE408:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FE414: .word OSi_VAlarmQueue
	arm_func_end OSi_InsertVAlarm

	arm_func_start OS_IsVAlarmAvailable
OS_IsVAlarmAvailable: // 0x037FE418
	ldr r0, _037FE424 // =OSi_UseVAlarm
	ldrh r0, [r0]
	bx lr
	.align 2, 0
_037FE424: .word OSi_UseVAlarm
	arm_func_end OS_IsVAlarmAvailable

	arm_func_start OS_InitVAlarm
OS_InitVAlarm: // 0x037FE428
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _037FE480 // =OSi_UseVAlarm
	ldrh r1, [r0]
	cmp r1, #0
	bne _037FE474
	mov r1, #1
	strh r1, [r0]
	mov r1, #0
	ldr r0, _037FE484 // =OSi_VAlarmQueue
	str r1, [r0]
	str r1, [r0, #4]
	mov r0, #4
	bl OS_DisableIrqMask
	mov r1, #0
	ldr r0, _037FE488 // =OSi_VFrameCount
	str r1, [r0]
	ldr r0, _037FE48C // =OSi_PreviousVCount
	str r1, [r0]
_037FE474:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FE480: .word OSi_UseVAlarm
_037FE484: .word OSi_VAlarmQueue
_037FE488: .word OSi_VFrameCount
_037FE48C: .word OSi_PreviousVCount
	arm_func_end OS_InitVAlarm