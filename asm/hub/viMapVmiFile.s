	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start ViMapVmiFile__Constructor
ViMapVmiFile__Constructor: // 0x0216100C
	stmdb sp!, {r4, lr}
	ldr r1, _02161028 // =0x0217370C
	mov r4, r0
	str r1, [r4]
	bl ViMapVmiFile__Func_2161074
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161028: .word 0x0217370C
	arm_func_end ViMapVmiFile__Constructor

	arm_func_start ViMapVmiFile__VTableFunc_216102C
ViMapVmiFile__VTableFunc_216102C: // 0x0216102C
	stmdb sp!, {r4, lr}
	ldr r1, _02161048 // =0x0217370C
	mov r4, r0
	str r1, [r4]
	bl ViMapVmiFile__Func_2161074
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161048: .word 0x0217370C
	arm_func_end ViMapVmiFile__VTableFunc_216102C

	arm_func_start ViMapVmiFile__VTableFunc_216104C
ViMapVmiFile__VTableFunc_216104C: // 0x0216104C
	stmdb sp!, {r4, lr}
	ldr r1, _02161070 // =0x0217370C
	mov r4, r0
	str r1, [r4]
	bl ViMapVmiFile__Func_2161074
	mov r0, r4
	bl CPPHelpers__Free
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161070: .word 0x0217370C
	arm_func_end ViMapVmiFile__VTableFunc_216104C

	arm_func_start ViMapVmiFile__Func_2161074
ViMapVmiFile__Func_2161074: // 0x02161074
	mov r1, #0
	str r1, [r0, #4]
	str r1, [r0, #8]
	bx lr
	arm_func_end ViMapVmiFile__Func_2161074

	arm_func_start ViMapVmiFile__Func_2161084
ViMapVmiFile__Func_2161084: // 0x02161084
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl ViMapVmiFile__Func_2161074
	str r4, [r5, #4]
	add r0, r4, #4
	str r0, [r5, #8]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViMapVmiFile__Func_2161084

	arm_func_start ViMapVmiFile__Func_21610A4
ViMapVmiFile__Func_21610A4: // 0x021610A4
	ldr r0, [r0, #4]
	ldrh r0, [r0]
	bx lr
	arm_func_end ViMapVmiFile__Func_21610A4

	arm_func_start ViMapVmiFile__Func_21610B0
ViMapVmiFile__Func_21610B0: // 0x021610B0
	mov r2, #0xc
	mul r2, r1, r2
	ldr r0, [r0, #8]
	ldrh r0, [r0, r2]
	mov r0, r0, lsl #0x13
	mov r0, r0, lsr #0x10
	bx lr
	arm_func_end ViMapVmiFile__Func_21610B0

	arm_func_start ViMapVmiFile__Func_21610CC
ViMapVmiFile__Func_21610CC: // 0x021610CC
	ldr r2, [r0, #8]
	mov r0, #0xc
	mla r0, r1, r0, r2
	ldrh r0, [r0, #2]
	mov r0, r0, lsl #0x13
	mov r0, r0, lsr #0x10
	bx lr
	arm_func_end ViMapVmiFile__Func_21610CC

	arm_func_start ViMapVmiFile__Func_21610E8
ViMapVmiFile__Func_21610E8: // 0x021610E8
	mov r2, #0xc
	mul r2, r1, r2
	ldr r0, [r0, #8]
	ldrh r0, [r0, r2]
	bx lr
	arm_func_end ViMapVmiFile__Func_21610E8

	arm_func_start ViMapVmiFile__Func_21610FC
ViMapVmiFile__Func_21610FC: // 0x021610FC
	ldr r2, [r0, #8]
	mov r0, #0xc
	mla r0, r1, r0, r2
	ldrh r0, [r0, #2]
	bx lr
	arm_func_end ViMapVmiFile__Func_21610FC

	arm_func_start ViMapVmiFile__Func_2161110
ViMapVmiFile__Func_2161110: // 0x02161110
	ldr r2, [r0, #8]
	mov r0, #0xc
	mla r0, r1, r0, r2
	ldrh r0, [r0, #4]
	mov r0, r0, lsl #0x13
	mov r0, r0, lsr #0x10
	bx lr
	arm_func_end ViMapVmiFile__Func_2161110

	arm_func_start ViMapVmiFile__Func_216112C
ViMapVmiFile__Func_216112C: // 0x0216112C
	ldr r2, [r0, #8]
	mov r0, #0xc
	mla r0, r1, r0, r2
	ldrh r0, [r0, #6]
	mov r0, r0, lsl #0x13
	mov r0, r0, lsr #0x10
	bx lr
	arm_func_end ViMapVmiFile__Func_216112C

	arm_func_start ViMapVmiFile__Func_2161148
ViMapVmiFile__Func_2161148: // 0x02161148
	ldr r2, [r0, #8]
	mov r0, #0xc
	mla r0, r1, r0, r2
	ldrh r0, [r0, #4]
	bx lr
	arm_func_end ViMapVmiFile__Func_2161148

	arm_func_start ViMapVmiFile__Func_216115C
ViMapVmiFile__Func_216115C: // 0x0216115C
	ldr r2, [r0, #8]
	mov r0, #0xc
	mla r0, r1, r0, r2
	ldrh r0, [r0, #6]
	bx lr
	arm_func_end ViMapVmiFile__Func_216115C

	arm_func_start ViMapVmiFile__Func_2161170
ViMapVmiFile__Func_2161170: // 0x02161170
	ldr r2, [r0, #8]
	mov r0, #0xc
	mla r0, r1, r0, r2
	ldrh r0, [r0, #8]
	bx lr
	arm_func_end ViMapVmiFile__Func_2161170
