	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start ViMapVmcFile__Constructor
ViMapVmcFile__Constructor: // 0x02161218
	stmdb sp!, {r4, lr}
	ldr r1, _02161234 // =0x021736CC
	mov r4, r0
	str r1, [r4]
	bl ViMapVmcFile__Func_2161280
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161234: .word 0x021736CC
	arm_func_end ViMapVmcFile__Constructor

	arm_func_start ViMapVmcFile__VTableFunc_2161238
ViMapVmcFile__VTableFunc_2161238: // 0x02161238
	stmdb sp!, {r4, lr}
	ldr r1, _02161254 // =0x021736CC
	mov r4, r0
	str r1, [r4]
	bl ViMapVmcFile__Func_2161280
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161254: .word 0x021736CC
	arm_func_end ViMapVmcFile__VTableFunc_2161238

	arm_func_start ViMapVmcFile__VTableFunc_2161258
ViMapVmcFile__VTableFunc_2161258: // 0x02161258
	stmdb sp!, {r4, lr}
	ldr r1, _0216127C // =0x021736CC
	mov r4, r0
	str r1, [r4]
	bl ViMapVmcFile__Func_2161280
	mov r0, r4
	bl CPPHelpers__Free
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216127C: .word 0x021736CC
	arm_func_end ViMapVmcFile__VTableFunc_2161258

	arm_func_start ViMapVmcFile__Func_2161280
ViMapVmcFile__Func_2161280: // 0x02161280
	mov r1, #0
	str r1, [r0, #4]
	bx lr
	arm_func_end ViMapVmcFile__Func_2161280

	arm_func_start ViMapVmcFile__Func_216128C
ViMapVmcFile__Func_216128C: // 0x0216128C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl ViMapVmcFile__Func_2161280
	str r4, [r5, #4]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViMapVmcFile__Func_216128C

	arm_func_start ViMapVmcFile__Func_21612A4
ViMapVmcFile__Func_21612A4: // 0x021612A4
	ldr r0, [r0, #4]
	bx lr
	arm_func_end ViMapVmcFile__Func_21612A4
