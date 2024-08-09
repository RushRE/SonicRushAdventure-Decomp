	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start PADi_xyButtonAlarmHandler
PADi_xyButtonAlarmHandler: // 0x037FED3C
	stmdb sp!, {r4, lr}
	mov r4, #0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	ldr r0, _037FED74 // =0x04000136
	ldrh r1, [r0]
	ands r0, r1, #0x80
	movne r4, #0x8000
	and r0, r1, #0xb
	orr r1, r4, r0, lsl #10
	ldr r0, _037FED78 // =0x027FFFA8
	strh r1, [r0]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FED74: .word 0x04000136
_037FED78: .word 0x027FFFA8
	arm_func_end PADi_xyButtonAlarmHandler

	arm_func_start PAD_InitXYButton
PAD_InitXYButton: // 0x037FED7C
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	bl OS_IsTickAvailable
	cmp r0, #0
	beq _037FED9C
	bl OS_IsAlarmAvailable
	cmp r0, #0
	bne _037FEDA4
_037FED9C:
	mov r0, #0
	b _037FEE00
_037FEDA4:
	ldr r0, _037FEE0C // =0x03808674
	ldr r0, [r0]
	cmp r0, #0
	movne r0, #0
	bne _037FEE00
	ldr r0, _037FEE10 // =0x03808678
	bl OS_CreateAlarm
	bl OS_GetTick
	mov r2, r0
	ldr r0, _037FEE14 // =PADi_xyButtonAlarmHandler
	str r0, [sp, #4]
	mov r0, #0
	str r0, [sp, #8]
	ldr r3, _037FEE18 // =0x0000082E
	str r0, [sp]
	ldr r0, _037FEE10 // =0x03808678
	adds ip, r2, r3
	adc r2, r1, #0
	mov r1, ip
	bl OS_SetPeriodicAlarm
	mov r0, #1
	ldr r1, _037FEE0C // =0x03808674
	str r0, [r1]
_037FEE00:
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FEE0C: .word 0x03808674
_037FEE10: .word 0x03808678
_037FEE14: .word PADi_xyButtonAlarmHandler
_037FEE18: .word 0x0000082E
	arm_func_end PAD_InitXYButton