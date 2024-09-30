	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exFixRemainderTask__Main
exFixRemainderTask__Main: // 0x02169DBC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetExTaskWorkCurrent_
	mov r7, r0
	bl GetCurrentTask
	ldr r1, _02169F10 // =0x021766A8
	mov r2, #0x10
	str r0, [r1]
	strh r2, [r7, #8]
	mov r1, #0
	add r0, r7, #8
	strh r1, [r7, #0xa]
	bl ovl09_2168EA4
	add r0, r7, #0x88
	mov r1, #0xe000
	bl ovl09_21641E8
	mov r0, #0
	strh r0, [r7, #0x70]
	strh r0, [r7, #0x72]
	ldrb r1, [r7, #0x8a]
	add r0, r7, #8
	orr r1, r1, #0x20
	strb r1, [r7, #0x8a]
	bl ovl09_2161B80
	mov r0, #0x13
	strh r0, [r7, #0x90]
	mov r1, #2
	add r0, r7, #0x90
	strh r1, [r7, #0x92]
	bl ovl09_2168EA4
	ldr r1, _02169F14 // =0x0000E001
	add r0, r7, #0x110
	bl ovl09_21641E8
	mov r0, #0
	strh r0, [r7, #0xf8]
	strh r0, [r7, #0xfa]
	ldrb r1, [r7, #0x112]
	add r0, r7, #0x90
	orr r1, r1, #0x20
	strb r1, [r7, #0x112]
	bl ovl09_2161B80
	add r0, r7, #0x9a
	ldr r11, _02169F18 // =0x02175CB4
	mov r8, #0
	add r6, r7, #0x118
	add r5, r7, #0x198
	add r4, r0, #0x100
_02169E74:
	mov r0, #0x88
	mul r9, r8, r0
	mov r0, r8, lsl #1
	ldrh r1, [r11, r0]
	add r10, r7, r9
	add r2, r10, #0x100
	strh r1, [r2, #0x18]
	mov r1, #2
	add r0, r6, r9
	strh r1, [r2, #0x1a]
	bl ovl09_2168EA4
	ldr r1, _02169F14 // =0x0000E001
	add r0, r5, r9
	bl ovl09_21641E8
	add r1, r10, #0x100
	mov r0, #0
	strh r0, [r1, #0x80]
	strh r0, [r1, #0x82]
	ldrb r1, [r4, r9]
	add r0, r6, r9
	orr r1, r1, #0x20
	strb r1, [r4, r9]
	bl ovl09_2161B80
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #0xa
	blo _02169E74
	mov r0, #0x28
	strh r0, [r7]
	mov r1, #0xb6
	strh r1, [r7, #2]
	mov r0, #0x2f
	strh r0, [r7, #4]
	strh r1, [r7, #6]
	bl GetExTaskCurrent
	ldr r1, _02169F1C // =ovl09_2169F84
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02169F10: .word 0x021766A8
_02169F14: .word 0x0000E001
_02169F18: .word 0x02175CB4
_02169F1C: .word ovl09_2169F84
	arm_func_end exFixRemainderTask__Main

	arm_func_start exFixRemainderTask__Func8
exFixRemainderTask__Func8: // 0x02169F20
	ldr ip, _02169F28 // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_02169F28: .word GetExTaskWorkCurrent_
	arm_func_end exFixRemainderTask__Func8

	arm_func_start exFixRemainderTask__Destructor
exFixRemainderTask__Destructor: // 0x02169F2C
	stmdb sp!, {r4, r5, r6, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #8
	bl ovl09_2168F68
	add r0, r4, #0x90
	bl ovl09_2168F68
	add r5, r4, #0x118
	mov r6, #0
	mov r4, #0x88
_02169F54:
	mla r0, r6, r4, r5
	bl ovl09_2168F68
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0xa
	blo _02169F54
	ldr r0, _02169F80 // =0x021766A8
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02169F80: .word 0x021766A8
	arm_func_end exFixRemainderTask__Destructor

	arm_func_start ovl09_2169F84
ovl09_2169F84: // 0x02169F84
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetExTaskWorkCurrent_
	mov r5, r0
	bl exSysTask__GetStatus
	ldrb r1, [r0, #4]
	ldr r0, _0216A08C // =0x66666667
	ldr r3, _0216A090 // =0x51EB851F
	smull r2, r4, r0, r1
	mov r7, r1, lsr #0x1f
	smull r2, r8, r3, r1
	add r4, r7, r4, asr #2
	mov r6, #0xa
	smull r2, r3, r6, r4
	add r8, r7, r8, asr #5
	mov r6, #0x64
	smull r3, r4, r6, r8
	sub r4, r1, r2
	sub r8, r1, r3
	sub r2, r8, r4
	mov r1, r2, lsr #0x1f
	smull r2, r3, r0, r2
	add r3, r1, r3, asr #2
	mov r0, #0x88
	mul r6, r3, r0
	add r8, r5, #0x118
	add r0, r8, r6
	bl ovl09_2161908
	mov r0, #0x88
	mul r7, r4, r0
	mov r4, r8
	add r0, r4, r7
	bl ovl09_2161908
	add r0, r5, #0x90
	bl ovl09_2161908
	add r0, r5, #8
	bl ovl09_2161908
	add r1, r5, r6
	add r2, r1, #0x100
	ldrsh r3, [r5, #0]
	add r1, r5, #0x198
	add r0, r8, r6
	strh r3, [r2, #0x80]
	ldrsh r3, [r5, #2]
	add r1, r1, r6
	strh r3, [r2, #0x82]
	bl ovl09_2164034
	add r1, r5, r7
	add r2, r1, #0x100
	ldrsh r3, [r5, #4]
	add r1, r5, #0x198
	add r0, r4, r7
	strh r3, [r2, #0x80]
	ldrsh r3, [r5, #6]
	add r1, r1, r7
	strh r3, [r2, #0x82]
	bl ovl09_2164034
	add r0, r5, #0x90
	add r1, r5, #0x110
	bl ovl09_2164034
	add r0, r5, #8
	add r1, r5, #0x88
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216A08C: .word 0x66666667
_0216A090: .word 0x51EB851F
	arm_func_end ovl09_2169F84

	arm_func_start exFixRemainderTask__Create
exFixRemainderTask__Create: // 0x0216A094
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _0216A0FC // =0x00000668
	str r4, [sp]
	ldr r0, _0216A100 // =aExfixremainder
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0216A104 // =exFixRemainderTask__Main
	ldr r1, _0216A108 // =exFixRemainderTask__Destructor
	mov r2, #0x1800
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	ldr r2, _0216A0FC // =0x00000668
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, _0216A10C // =exFixRemainderTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A0FC: .word 0x00000668
_0216A100: .word aExfixremainder
_0216A104: .word exFixRemainderTask__Main
_0216A108: .word exFixRemainderTask__Destructor
_0216A10C: .word exFixRemainderTask__Func8
	arm_func_end exFixRemainderTask__Create

	arm_func_start ovl09_216A110
ovl09_216A110: // 0x0216A110
	stmdb sp!, {r3, lr}
	ldr r0, _0216A134 // =0x021766A8
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, _0216A138 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216A134: .word 0x021766A8
_0216A138: .word ExTask_State_Destroy
	arm_func_end ovl09_216A110