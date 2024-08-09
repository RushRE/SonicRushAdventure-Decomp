	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FontAnimatorCore__Func_20583E8
FontAnimatorCore__Func_20583E8: // 0x020583E8
	mov r0, #0
	bx lr
	arm_func_end FontAnimatorCore__Func_20583E8

	arm_func_start FontAnimatorCore__Func_20583F0
FontAnimatorCore__Func_20583F0: // 0x020583F0
	mov r0, #0
	bx lr
	arm_func_end FontAnimatorCore__Func_20583F0

	arm_func_start FontAnimatorCore__Init
FontAnimatorCore__Init: // 0x020583F8
	mov r1, #0
	str r1, [r0]
	str r1, [r0, #4]
	bx lr
	arm_func_end FontAnimatorCore__Init

	arm_func_start FontAnimatorCore__LoadFont
FontAnimatorCore__LoadFont: // 0x02058408
	mov r2, #0
	str r2, [r0]
	str r1, [r0, #4]
	ldr ip, _02058420 // =FontAnimatorCore__Func_20583E8
	mov r0, r1
	bx ip
	.align 2, 0
_02058420: .word FontAnimatorCore__Func_20583E8
	arm_func_end FontAnimatorCore__LoadFont

	arm_func_start FontAnimatorCore__Release
FontAnimatorCore__Release: // 0x02058424
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0205843C
	bl FontAnimatorCore__Func_20583F0
_0205843C:
	mov r0, r4
	bl FontAnimatorCore__Init
	ldmia sp!, {r4, pc}
	arm_func_end FontAnimatorCore__Release
