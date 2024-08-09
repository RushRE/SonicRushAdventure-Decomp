	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start Vi3dArrow__Constructor
Vi3dArrow__Constructor: // 0x0216823C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ViDockNpc__Func_2167384
	ldr r0, _02168264 // =0x021738F8
	mov r1, #0
	str r0, [r4]
	str r1, [r4, #0x300]
	mov r0, r4
	str r1, [r4, #0x304]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02168264: .word 0x021738F8
	arm_func_end Vi3dArrow__Constructor

	arm_func_start Vi3dArrow__VTableFunc_2168268
Vi3dArrow__VTableFunc_2168268: // 0x02168268
	stmdb sp!, {r4, lr}
	ldr r1, _0216828C // =0x021738F8
	mov r4, r0
	str r1, [r4]
	bl Vi3dArrow__Func_2168358
	mov r0, r4
	bl Vi3dObject__Func_216761C
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216828C: .word 0x021738F8
	arm_func_end Vi3dArrow__VTableFunc_2168268

	arm_func_start Vi3dArrow__VTableFunc_2168290
Vi3dArrow__VTableFunc_2168290: // 0x02168290
	stmdb sp!, {r4, lr}
	ldr r1, _021682BC // =0x021738F8
	mov r4, r0
	str r1, [r4]
	bl Vi3dArrow__Func_2168358
	mov r0, r4
	bl Vi3dObject__Func_216761C
	mov r0, r4
	bl CPPHelpers__Free
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021682BC: .word 0x021738F8
	arm_func_end Vi3dArrow__VTableFunc_2168290

	arm_func_start Vi3dArrow__LoadAssets
Vi3dArrow__LoadAssets: // 0x021682C0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	bl Vi3dArrow__Func_2168358
	ldr r0, _02168350 // =aBbViNpcBb_0
	mov r1, #0x1c
	mov r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r4, #0x300]
	ldr r0, _02168350 // =aBbViNpcBb_0
	mov r1, #0x1d
	mov r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r4, #0x304]
	mov r2, #0
	str r2, [sp]
	ldr r1, [r4, #0x304]
	ldr r0, _02168354 // =0x0000FFFF
	stmib sp, {r1, r2}
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r1, [r4, #0x300]
	mov r0, r4
	mov r3, r2
	bl Vi3dObject__Func_216763C
	mov r1, #0
	str r1, [sp]
	mov r0, r4
	mov r2, #1
	mov r3, r1
	str r1, [sp, #4]
	bl Vi3dObject__Func_2167900
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02168350: .word aBbViNpcBb_0
_02168354: .word 0x0000FFFF
	arm_func_end Vi3dArrow__LoadAssets

	arm_func_start Vi3dArrow__Func_2168358
Vi3dArrow__Func_2168358: // 0x02168358
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl Vi3dObject__Func_21677C4
	ldr r0, [r4, #0x304]
	cmp r0, #0
	beq _0216837C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x304]
_0216837C:
	ldr r0, [r4, #0x300]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x300]
	ldmia sp!, {r4, pc}
	arm_func_end Vi3dArrow__Func_2168358
