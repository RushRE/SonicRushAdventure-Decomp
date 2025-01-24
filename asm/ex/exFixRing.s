	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exFixRingTask__Main
exFixRingTask__Main: // 0x021697E0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetExTaskWorkCurrent_
	mov r7, r0
	bl GetCurrentTask
	ldr r1, _021699A8 // =0x021766A8
	mov r2, #0x11
	str r0, [r1, #0x10]
	strh r2, [r7, #0x10]
	mov r1, #1
	add r0, r7, #0x10
	strh r1, [r7, #0x12]
	bl exFixAdminTask__LoadSprite
	add r0, r7, #0x90
	mov r1, #0xe000
	bl exDrawReqTask__SetConfigPriority
	mov r0, #0
	strh r0, [r7, #0x78]
	strh r0, [r7, #0x7a]
	ldrb r1, [r7, #0x92]
	add r0, r7, #0x10
	orr r1, r1, #0x20
	strb r1, [r7, #0x92]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	add r0, r7, #0x90
	bl exDrawReqTask__Func_21641F0
	add r0, r7, #0x1a
	ldr r11, _021699AC // =0x02175CC8
	mov r8, #0
	add r6, r7, #0x98
	add r5, r7, #0x118
	add r4, r0, #0x100
_0216985C:
	mov r0, #0x88
	mul r9, r8, r0
	mov r0, r8, lsl #1
	ldrh r1, [r11, r0]
	add r10, r7, r9
	add r0, r6, r9
	strh r1, [r10, #0x98]
	mov r1, #2
	strh r1, [r10, #0x9a]
	bl exFixAdminTask__LoadSprite
	ldr r1, _021699B0 // =0x0000E001
	add r0, r5, r9
	bl exDrawReqTask__SetConfigPriority
	add r1, r10, #0x100
	mov r0, #0
	strh r0, [r1]
	strh r0, [r1, #2]
	ldrb r1, [r4, r9]
	add r0, r6, r9
	orr r1, r1, #0x20
	strb r1, [r4, r9]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	add r0, r5, r9
	bl exDrawReqTask__Func_21641F0
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #0xa
	blo _0216985C
	add r0, r7, #0x1e8
	add r1, r7, #0x268
	add r2, r7, #0x6a
	ldr r11, _021699B4 // =0x02175CA0
	mov r10, #0
	add r6, r0, #0x400
	add r5, r1, #0x400
	add r4, r2, #0x600
_021698F0:
	mov r0, #0x88
	mul r8, r10, r0
	mov r0, r10, lsl #1
	ldrh r1, [r11, r0]
	add r9, r7, r8
	add r2, r9, #0x500
	strh r1, [r2, #0xe8]
	mov r1, #2
	add r0, r6, r8
	strh r1, [r2, #0xea]
	bl exFixAdminTask__LoadSprite
	ldr r1, _021699B0 // =0x0000E001
	add r0, r5, r8
	bl exDrawReqTask__SetConfigPriority
	add r1, r9, #0x600
	mov r0, #0
	strh r0, [r1, #0x50]
	strh r0, [r1, #0x52]
	ldrb r1, [r4, r8]
	add r0, r6, r8
	orr r1, r1, #0x20
	strb r1, [r4, r8]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	add r0, r5, r8
	bl exDrawReqTask__Func_2164218
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
	cmp r10, #0xa
	blo _021698F0
	mov r0, #0x17
	strh r0, [r7, #2]
	mov r1, #0x10
	strh r1, [r7, #4]
	mov r0, #0x21
	strh r0, [r7, #6]
	strh r1, [r7, #8]
	mov r0, #0x2b
	strh r0, [r7, #0xa]
	strh r1, [r7, #0xc]
	mov r0, #0x3c
	strh r0, [r7]
	bl GetExTaskCurrent
	ldr r1, _021699B8 // =exFixRingTask__Main_Active
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021699A8: .word 0x021766A8
_021699AC: .word 0x02175CC8
_021699B0: .word 0x0000E001
_021699B4: .word 0x02175CA0
_021699B8: .word exFixRingTask__Main_Active
	arm_func_end exFixRingTask__Main

	arm_func_start exFixRingTask__Func8
exFixRingTask__Func8: // 0x021699BC
	ldr ip, _021699C4 // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_021699C4: .word GetExTaskWorkCurrent_
	arm_func_end exFixRingTask__Func8

	arm_func_start exFixRingTask__Destructor
exFixRingTask__Destructor: // 0x021699C8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	bl exFixAdminTask__ReleaseSprite
	add r0, r4, #0x1e8
	add r6, r4, #0x98
	mov r7, #0
	add r5, r0, #0x400
	mov r4, #0x88
_021699F0:
	mul r8, r7, r4
	add r0, r6, r8
	bl exFixAdminTask__ReleaseSprite
	add r0, r5, r8
	bl exFixAdminTask__ReleaseSprite
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0xa
	blo _021699F0
	ldr r0, _02169A28 // =0x021766A8
	mov r1, #0
	str r1, [r0, #0x10]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02169A28: .word 0x021766A8
	arm_func_end exFixRingTask__Destructor

	arm_func_start exFixRingTask__Main_Active
exFixRingTask__Main_Active: // 0x02169A2C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exSysTask__GetStatus
	mov r5, r0
	add r0, r4, #0x10
	bl exDrawReqTask__Sprite2D__Animate
	add r0, r4, #0x10
	add r1, r4, #0x90
	bl exDrawReqTask__AddRequest
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	beq _02169AD4
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #7
	beq _02169AD4
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #9
	beq _02169AD4
	ldrh r0, [r5, #6]
	cmp r0, #0
	beq _02169ACC
	ldrsh r1, [r4, #0]
	sub r0, r1, #1
	strh r0, [r4]
	cmp r1, #0
	bge _02169AD4
	mov r0, #0x3c
	strh r0, [r4]
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	beq _02169AD4
	ldrh r0, [r5, #6]
	sub r0, r0, #1
	strh r0, [r5, #6]
	b _02169AD4
_02169ACC:
	mov r0, #0x3c
	strh r0, [r4]
_02169AD4:
	ldrh ip, [r5, #6]
	ldr r0, _02169D04 // =0x66666667
	ldr r2, _02169D08 // =0x51EB851F
	smull r3, r6, r0, ip
	smull r3, r5, r2, ip
	mov r1, ip, lsr #0x1f
	ldr r8, _02169D0C // =0x10624DD3
	add r6, r1, r6, asr #2
	mov r7, #0xa
	smull r6, r3, r7, r6
	smull r7, r3, r8, ip
	add r5, r1, r5, asr #5
	mov r8, #0x64
	smull r5, r7, r8, r5
	add r3, r1, r3, asr #6
	mov r8, #0x3e8
	sub r6, ip, r6
	sub r5, ip, r5
	smull r7, r1, r8, r3
	sub r3, r5, r6
	mov r1, r3, lsr #0x1f
	smull r3, r5, r0, r3
	add r5, r1, r5, asr #2
	sub r3, ip, r7
	add r0, r6, r5
	sub r1, r3, r0
	smull r0, r7, r2, r1
	mov r0, r1, lsr #0x1f
	adds r7, r0, r7, asr #5
	cmpeq r5, #0
	mov r9, #0
	bne _02169C34
	add r0, r4, #0x1e8
	add r8, r0, #0x400
_02169B5C:
	mov r0, r8
	bl exDrawReqTask__Sprite2D__Animate
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, asr #0x10
	cmp r9, #0xa
	add r8, r8, #0x88
	blo _02169B5C
	mov r0, #0x88
	mul r1, r7, r0
	add r0, r4, r1
	ldrsh r3, [r4, #2]
	add r2, r0, #0x600
	add r0, r4, #0x1e8
	strh r3, [r2, #0x50]
	add r3, r4, #0x268
	ldrsh r7, [r4, #4]
	add r0, r0, #0x400
	add r3, r3, #0x400
	add r0, r0, r1
	add r1, r3, r1
	strh r7, [r2, #0x52]
	bl exDrawReqTask__AddRequest
	mov r0, #0x88
	mul r7, r5, r0
	add r2, r4, r7
	add r0, r4, #0x1e8
	add r1, r4, #0x268
	add r0, r0, #0x400
	add r1, r1, #0x400
	ldrsh r3, [r4, #6]
	add r2, r2, #0x600
	add r0, r0, r7
	strh r3, [r2, #0x50]
	ldrsh r3, [r4, #8]
	add r1, r1, r7
	strh r3, [r2, #0x52]
	bl exDrawReqTask__AddRequest
	mov r0, #0x88
	mul r5, r6, r0
	add r2, r4, r5
	add r0, r4, #0x1e8
	add r1, r4, #0x268
	add r0, r0, #0x400
	add r1, r1, #0x400
	ldrsh r3, [r4, #0xa]
	add r2, r2, #0x600
	add r0, r0, r5
	strh r3, [r2, #0x50]
	ldrsh r3, [r4, #0xc]
	add r1, r1, r5
	strh r3, [r2, #0x52]
	bl exDrawReqTask__AddRequest
	b _02169CF4
_02169C34:
	add r8, r4, #0x98
_02169C38:
	mov r0, r8
	bl exDrawReqTask__Sprite2D__Animate
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, asr #0x10
	cmp r9, #0xa
	add r8, r8, #0x88
	blo _02169C38
	mov r0, #0x88
	mul r8, r7, r0
	add r0, r4, r8
	ldrsh r1, [r4, #2]
	add r2, r0, #0x100
	add r0, r4, #0x98
	strh r1, [r2]
	ldrsh r3, [r4, #4]
	add r1, r4, #0x118
	add r0, r0, r8
	add r1, r1, r8
	strh r3, [r2, #2]
	bl exDrawReqTask__AddRequest
	mov r0, #0x88
	mul r7, r5, r0
	add r2, r4, r7
	add r0, r4, #0x98
	add r1, r4, #0x118
	ldrsh r3, [r4, #6]
	add r2, r2, #0x100
	add r0, r0, r7
	strh r3, [r2]
	ldrsh r3, [r4, #8]
	add r1, r1, r7
	strh r3, [r2, #2]
	bl exDrawReqTask__AddRequest
	mov r0, #0x88
	mul r5, r6, r0
	add r2, r4, r5
	add r0, r4, #0x98
	add r1, r4, #0x118
	ldrsh r3, [r4, #0xa]
	add r2, r2, #0x100
	add r0, r0, r5
	strh r3, [r2]
	ldrsh r3, [r4, #0xc]
	add r1, r1, r5
	strh r3, [r2, #2]
	bl exDrawReqTask__AddRequest
_02169CF4:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02169D04: .word 0x66666667
_02169D08: .word 0x51EB851F
_02169D0C: .word 0x10624DD3
	arm_func_end exFixRingTask__Main_Active

	arm_func_start exFixRingTask__Create
exFixRingTask__Create: // 0x02169D10
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _02169D78 // =0x00000B38
	str r4, [sp]
	ldr r0, _02169D7C // =aExfixringtask
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02169D80 // =exFixRingTask__Main
	ldr r1, _02169D84 // =exFixRingTask__Destructor
	ldr r2, _02169D88 // =0x00001801
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	ldr r2, _02169D78 // =0x00000B38
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, _02169D8C // =exFixRingTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169D78: .word 0x00000B38
_02169D7C: .word aExfixringtask
_02169D80: .word exFixRingTask__Main
_02169D84: .word exFixRingTask__Destructor
_02169D88: .word 0x00001801
_02169D8C: .word exFixRingTask__Func8
	arm_func_end exFixRingTask__Create

	arm_func_start exFixRingTask__Destroy
exFixRingTask__Destroy: // 0x02169D90
	stmdb sp!, {r3, lr}
	ldr r0, _02169DB4 // =0x021766A8
	ldr r0, [r0, #0x10]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, _02169DB8 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02169DB4: .word 0x021766A8
_02169DB8: .word ExTask_State_Destroy
	arm_func_end exFixRingTask__Destroy