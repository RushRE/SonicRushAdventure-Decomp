	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start ViMapVmpFile__Constructor
ViMapVmpFile__Constructor: // 0x02161184
	stmdb sp!, {r4, lr}
	ldr r1, _021611A0 // =0x021736EC
	mov r4, r0
	str r1, [r4]
	bl ViMapVmpFile__Func_21611EC
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021611A0: .word 0x021736EC
	arm_func_end ViMapVmpFile__Constructor

	arm_func_start ViMapVmpFile__VTableFunc_21611A4
ViMapVmpFile__VTableFunc_21611A4: // 0x021611A4
	stmdb sp!, {r4, lr}
	ldr r1, _021611C0 // =0x021736EC
	mov r4, r0
	str r1, [r4]
	bl ViMapVmpFile__Func_21611EC
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021611C0: .word 0x021736EC
	arm_func_end ViMapVmpFile__VTableFunc_21611A4

	arm_func_start ViMapVmpFile__VTableFunc_21611C4
ViMapVmpFile__VTableFunc_21611C4: // 0x021611C4
	stmdb sp!, {r4, lr}
	ldr r1, _021611E8 // =0x021736EC
	mov r4, r0
	str r1, [r4]
	bl ViMapVmpFile__Func_21611EC
	mov r0, r4
	bl CPPHelpers__Free
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021611E8: .word 0x021736EC
	arm_func_end ViMapVmpFile__VTableFunc_21611C4

	arm_func_start ViMapVmpFile__Func_21611EC
ViMapVmpFile__Func_21611EC: // 0x021611EC
	mov r1, #0
	str r1, [r0, #4]
	bx lr
	arm_func_end ViMapVmpFile__Func_21611EC

	arm_func_start ViMapVmpFile__Func_21611F8
ViMapVmpFile__Func_21611F8: // 0x021611F8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl ViMapVmpFile__Func_21611EC
	str r4, [r5, #4]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViMapVmpFile__Func_21611F8

	arm_func_start ViMapVmpFile__Func_2161210
ViMapVmpFile__Func_2161210: // 0x02161210
	ldr r0, [r0, #4]
	bx lr
	arm_func_end ViMapVmpFile__Func_2161210
