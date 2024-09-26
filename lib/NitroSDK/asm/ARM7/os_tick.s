	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start OS_GetTick
OS_GetTick: // 0x037FD7AC
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	bl OS_DisableInterrupts
	ldr r1, _037FD84C // =0x04000100
	ldrh r1, [r1]
	strh r1, [sp]
	ldr r1, _037FD850 // =OSi_TickCounter
	ldr ip, [r1]
	ldr r3, [r1, #4]
	ldr r2, _037FD854 // =0x0000FFFF
	mvn r1, #0
	and r2, r3, r2
	and r1, ip, r1
	str r1, [sp, #4]
	str r2, [sp, #8]
	ldr r1, _037FD858 // =0x04000214
	ldr r1, [r1]
	ands r1, r1, #8
	beq _037FD820
	ldrh r1, [sp]
	ands r1, r1, #0x8000
	bne _037FD820
	ldr r3, [sp, #4]
	ldr r2, [sp, #8]
	mov r1, #1
	adds r3, r3, r1
	adc r1, r2, #0
	str r3, [sp, #4]
	str r1, [sp, #8]
_037FD820:
	bl OS_RestoreInterrupts
	ldr r2, [sp, #4]
	ldr r0, [sp, #8]
	mov r1, r0, lsl #0x10
	orr r1, r1, r2, lsr #16
	ldrh r0, [sp]
	orr r1, r1, r0, asr #31
	orr r0, r0, r2, lsl #16
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FD84C: .word 0x04000100
_037FD850: .word OSi_TickCounter
_037FD854: .word 0x0000FFFF
_037FD858: .word 0x04000214
	arm_func_end OS_GetTick

	arm_func_start OSi_CountUpTick
OSi_CountUpTick: // 0x037FD85C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _037FD8D0 // =OSi_TickCounter
	ldr ip, [r1]
	ldr r2, [r1, #4]
	mov r3, #0
	mov r0, #1
	adds ip, ip, r0
	adc r0, r2, #0
	str ip, [r1]
	str r0, [r1, #4]
	ldr r0, _037FD8D4 // =OSi_NeedResetTimer
	ldr r1, [r0]
	cmp r1, #0
	beq _037FD8B4
	ldr r2, _037FD8D8 // =0x04000102
	strh r3, [r2]
	ldr r1, _037FD8DC // =0x04000100
	strh r3, [r1]
	mov r1, #0xc1
	strh r1, [r2]
	str r3, [r0]
_037FD8B4:
	mov r0, #0
	ldr r1, _037FD8E0 // =OSi_CountUpTick
	mov r2, r0
	bl OSi_EnterTimerCallback
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FD8D0: .word OSi_TickCounter
_037FD8D4: .word OSi_NeedResetTimer
_037FD8D8: .word 0x04000102
_037FD8DC: .word 0x04000100
_037FD8E0: .word OSi_CountUpTick
	arm_func_end OSi_CountUpTick

	arm_func_start OS_IsTickAvailable
OS_IsTickAvailable: // 0x037FD8E4
	ldr r0, _037FD8F0 // =OSi_UseTick
	ldrh r0, [r0]
	bx lr
	.align 2, 0
_037FD8F0: .word OSi_UseTick
	arm_func_end OS_IsTickAvailable

	arm_func_start OS_InitTick
OS_InitTick: // 0x037FD8F4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _037FD970 // =OSi_UseTick
	ldrh r1, [r0]
	cmp r1, #0
	bne _037FD964
	mov r1, #1
	strh r1, [r0]
	mov r0, #0
	bl OSi_SetTimerReserved
	mov r2, #0
	ldr r0, _037FD974 // =OSi_TickCounter
	str r2, [r0]
	str r2, [r0, #4]
	ldr r1, _037FD978 // =0x04000102
	strh r2, [r1]
	ldr r0, _037FD97C // =0x04000100
	strh r2, [r0]
	mov r0, #0xc1
	strh r0, [r1]
	mov r0, #8
	ldr r1, _037FD980 // =OSi_CountUpTick
	bl OS_SetIrqFunction
	mov r0, #8
	bl OS_EnableIrqMask
	mov r1, #0
	ldr r0, _037FD984 // =OSi_NeedResetTimer
	str r1, [r0]
_037FD964:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FD970: .word OSi_UseTick
_037FD974: .word OSi_TickCounter
_037FD978: .word 0x04000102
_037FD97C: .word 0x04000100
_037FD980: .word OSi_CountUpTick
_037FD984: .word OSi_NeedResetTimer
	arm_func_end OS_InitTick