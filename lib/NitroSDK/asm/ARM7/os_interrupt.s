	.include "asm/macros.inc"
	.include "global.inc"
	
	.public _038083A4
	.public OS_IRQTable

	.text

	arm_func_start OS_ResetRequestIrqMask
OS_ResetRequestIrqMask: // 0x037FBCBC
	ldr ip, _037FBCE8 // =0x04000208
	ldrh r3, [ip]
	mov r1, #0
	strh r1, [ip]
	ldr r2, _037FBCEC // =0x04000214
	ldr r1, [r2]
	str r0, [r2]
	ldrh r0, [ip]
	strh r3, [ip]
	mov r0, r1
	bx lr
	.align 2, 0
_037FBCE8: .word 0x04000208
_037FBCEC: .word 0x04000214
	arm_func_end OS_ResetRequestIrqMask

	arm_func_start OS_DisableIrqMask
OS_DisableIrqMask: // 0x037FBCF0
	ldr ip, _037FBD24 // =0x04000208
	ldrh r3, [ip]
	mov r1, #0
	strh r1, [ip]
	ldr r2, _037FBD28 // =0x04000210
	ldr r1, [r2]
	mvn r0, r0
	and r0, r1, r0
	str r0, [r2]
	ldrh r0, [ip]
	strh r3, [ip]
	mov r0, r1
	bx lr
	.align 2, 0
_037FBD24: .word 0x04000208
_037FBD28: .word 0x04000210
	arm_func_end OS_DisableIrqMask

	arm_func_start OS_EnableIrqMask
OS_EnableIrqMask: // 0x037FBD2C
	ldr ip, _037FBD5C // =0x04000208
	ldrh r3, [ip]
	mov r1, #0
	strh r1, [ip]
	ldr r2, _037FBD60 // =0x04000210
	ldr r1, [r2]
	orr r0, r1, r0
	str r0, [r2]
	ldrh r0, [ip]
	strh r3, [ip]
	mov r0, r1
	bx lr
	.align 2, 0
_037FBD5C: .word 0x04000208
_037FBD60: .word 0x04000210
	arm_func_end OS_EnableIrqMask

	arm_func_start OS_SetIrqMask
OS_SetIrqMask: // 0x037FBD64
	ldr ip, _037FBD90 // =0x04000208
	ldrh r3, [ip]
	mov r1, #0
	strh r1, [ip]
	ldr r2, _037FBD94 // =0x04000210
	ldr r1, [r2]
	str r0, [r2]
	ldrh r0, [ip]
	strh r3, [ip]
	mov r0, r1
	bx lr
	.align 2, 0
_037FBD90: .word 0x04000208
_037FBD94: .word 0x04000210
	arm_func_end OS_SetIrqMask

	arm_func_start OSi_EnterTimerCallback
OSi_EnterTimerCallback: // 0x037FBD98
	stmdb sp!, {r4, lr}
	mov r3, #0xc
	mul r4, r0, r3
	ldr r3, _037FBDD8 // =0x038083DC
	str r1, [r3, r4]
	ldr r1, _037FBDDC // =0x038083E4
	str r2, [r1, r4]
	mov r1, #1
	add r0, r0, #3
	mov r0, r1, lsl r0
	bl OS_EnableIrqMask
	mov r1, #1
	ldr r0, _037FBDE0 // =0x038083E0
	str r1, [r0, r4]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FBDD8: .word 0x038083DC
_037FBDDC: .word 0x038083E4
_037FBDE0: .word 0x038083E0
	arm_func_end OSi_EnterTimerCallback

	arm_func_start OS_SetIrqFunction
OS_SetIrqFunction: // 0x037FBDE4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, #0
	mov r7, r9
	ldr lr, _037FBE80 // =OS_IRQTable
	ldr r4, _037FBE84 // =0x0380840C
	ldr r6, _037FBE88 // =OSi_IrqCallbackInfo
	mov ip, r9
	mov r3, #1
	mov r2, #0xc
_037FBE0C:
	ands r5, r0, #1
	beq _037FBE64
	mov r8, r7
	cmp r9, #8
	blt _037FBE30
	cmp r9, #0xb
	suble r5, r9, #8
	mlale r8, r5, r2, r6
	ble _037FBE54
_037FBE30:
	cmp r9, #3
	blt _037FBE48
	cmp r9, #6
	addle r5, r9, #1
	mlale r8, r5, r2, r6
	ble _037FBE54
_037FBE48:
	cmp r9, #0
	moveq r8, r4
	strne r1, [lr, r9, lsl #2]
_037FBE54:
	cmp r8, #0
	strne r1, [r8]
	strne ip, [r8, #8]
	strne r3, [r8, #4]
_037FBE64:
	mov r0, r0, lsr #1
	add r9, r9, #1
	cmp r9, #0x19
	blt _037FBE0C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_037FBE80: .word OS_IRQTable
_037FBE84: .word 0x0380840C
_037FBE88: .word OSi_IrqCallbackInfo
	arm_func_end OS_SetIrqFunction

	arm_func_start OS_InitIrqTable
OS_InitIrqTable: // 0x037FBE8C
	mov r1, #0
	ldr r0, _037FBEA8 // =_038083A4
	str r1, [r0, #4]
	str r1, [r0]
	ldr r0, _037FBEAC // =0x027FFC3C
	str r1, [r0]
	bx lr
	.align 2, 0
_037FBEA8: .word _038083A4
_037FBEAC: .word 0x027FFC3C
	arm_func_end OS_InitIrqTable