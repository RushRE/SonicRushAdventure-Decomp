	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exFixTimeTask__Main
exFixTimeTask__Main: // 0x02168F78
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetExTaskWorkCurrent_
	mov r5, r0
	bl GetCurrentTask
	ldr r1, _02169388 // =0x021766A8
	str r0, [r1, #0xc]
	bl exTimeGamePlayTask__Create
	ldr r1, _0216938C // =0x021766BC
	mov r0, #0x12
	str r1, [r5]
	strh r0, [r1, #0x18]
	ldr r0, [r5, #0]
	mov r1, #2
	strh r1, [r0, #0x1a]
	ldr r0, [r5, #0]
	add r0, r0, #0x18
	bl ovl09_2168EA4
	ldr r0, [r5, #0]
	mov r1, #0xe000
	add r0, r0, #0x98
	bl ovl09_21641E8
	ldr r0, [r5, #0]
	mov r1, #0
	strh r1, [r0, #0x80]
	ldr r0, [r5, #0]
	strh r1, [r0, #0x82]
	ldr r1, [r5, #0]
	ldrb r0, [r1, #0x9a]
	orr r0, r0, #0x20
	strb r0, [r1, #0x9a]
	ldr r0, [r5, #0]
	add r0, r0, #0x18
	bl ovl09_2161B6C
	ldr r0, [r5, #0]
	add r0, r0, #0x98
	bl ovl09_21641F0
	mov r9, #0
_0216900C:
	mov r0, #0x88
	cmp r9, #0
	muleq r4, r9, r0
	ldreq r0, [r5, #0]
	moveq r1, #0x29
	beq _02169030
	mul r4, r9, r0
	ldr r0, [r5, #0]
	mov r1, #0x35
_02169030:
	add r0, r0, r4
	strh r1, [r0, #0xa0]
	mov r0, #0x88
	mul r6, r9, r0
	ldr r0, [r5, #0]
	mov r1, #2
	add r0, r0, r6
	strh r1, [r0, #0xa2]
	ldr r0, [r5, #0]
	add r0, r0, #0xa0
	add r0, r0, r6
	bl ovl09_2168EA4
	ldr r0, [r5, #0]
	mov r1, #0xe000
	add r0, r0, #0x120
	add r0, r0, r6
	bl ovl09_21641E8
	ldr r0, [r5, #0]
	mov r1, #0
	add r0, r0, r6
	add r0, r0, #0x100
	strh r1, [r0, #8]
	ldr r0, [r5, #0]
	add r0, r0, r6
	add r0, r0, #0x100
	strh r1, [r0, #0xa]
	ldr r0, [r5, #0]
	add r0, r0, #0x22
	add r1, r0, #0x100
	ldrb r0, [r1, r6]
	orr r0, r0, #0x20
	strb r0, [r1, r6]
	ldr r0, [r5, #0]
	add r0, r0, #0xa0
	add r0, r0, r6
	bl ovl09_2161B6C
	ldr r0, [r5, #0]
	cmp r9, #0
	add r0, r0, #0x120
	beq _021690DC
	add r0, r0, r4
	bl ovl09_2164218
	b _021690E4
_021690DC:
	add r0, r0, r4
	bl ovl09_21641F0
_021690E4:
	ldr r0, [r5, #0]
	cmp r9, #0
	movne r1, #0x36
	add r0, r0, r4
	moveq r1, #0x2a
	add r0, r0, #0x100
	strh r1, [r0, #0xb0]
	ldr r0, [r5, #0]
	mov r1, #2
	add r0, r0, r6
	add r0, r0, #0x100
	strh r1, [r0, #0xb2]
	ldr r0, [r5, #0]
	add r0, r0, #0x1b0
	add r0, r0, r6
	bl ovl09_2168EA4
	ldr r0, [r5, #0]
	mov r1, #0xe000
	add r0, r0, #0x230
	add r0, r0, r6
	bl ovl09_21641E8
	ldr r0, [r5, #0]
	mov r1, #0
	add r0, r0, r6
	add r0, r0, #0x200
	strh r1, [r0, #0x18]
	ldr r0, [r5, #0]
	add r0, r0, r6
	add r0, r0, #0x200
	strh r1, [r0, #0x1a]
	ldr r0, [r5, #0]
	add r0, r0, #0x32
	add r1, r0, #0x200
	ldrb r0, [r1, r6]
	orr r0, r0, #0x20
	strb r0, [r1, r6]
	ldr r0, [r5, #0]
	add r0, r0, #0x1b0
	add r0, r0, r6
	bl ovl09_2161B6C
	ldr r0, [r5, #0]
	cmp r9, #0
	add r0, r0, #0x230
	beq _021691A0
	add r0, r0, r4
	bl ovl09_2164218
	b _021691A8
_021691A0:
	add r0, r0, r4
	bl ovl09_21641F0
_021691A8:
	mov r0, #0x550
	mul r6, r9, r0
	mov r10, #0
	ldr r11, _02169390 // =0x02175CDC
	mov r4, r10
_021691BC:
	mov r0, #0x88
	mul r7, r10, r0
	cmp r9, #0
	beq _021691EC
	ldr r0, [r5, #0]
	mov r1, r10, lsl #1
	add r0, r6, r0
	add r0, r7, r0
	ldrh r1, [r11, r1]
	add r0, r0, #0x200
	strh r1, [r0, #0xc0]
	b _0216920C
_021691EC:
	ldr r1, [r5, #0]
	ldr r0, _02169394 // =0x02175CF0
	mov r2, r10, lsl #1
	ldrh r2, [r0, r2]
	add r0, r6, r1
	add r0, r7, r0
	add r0, r0, #0x200
	strh r2, [r0, #0xc0]
_0216920C:
	mov r0, #0x88
	mul r8, r10, r0
	ldr r0, [r5, #0]
	add r0, r6, r0
	add r0, r8, r0
	add r1, r0, #0x200
	mov r0, #2
	strh r0, [r1, #0xc2]
	ldr r0, [r5, #0]
	add r0, r0, #0x2c0
	add r0, r0, r6
	add r0, r0, r8
	bl ovl09_2168EA4
	ldr r0, [r5, #0]
	ldr r1, _02169398 // =0x0000E001
	add r0, r0, #0x340
	add r0, r0, r6
	add r0, r0, r8
	bl ovl09_21641E8
	ldr r0, [r5, #0]
	add r0, r6, r0
	add r0, r8, r0
	add r0, r0, #0x300
	strh r4, [r0, #0x28]
	ldr r0, [r5, #0]
	add r0, r6, r0
	add r0, r8, r0
	add r0, r0, #0x300
	strh r4, [r0, #0x2a]
	ldr r0, [r5, #0]
	add r0, r0, #0x42
	add r0, r0, #0x300
	add r1, r0, r6
	ldrb r0, [r1, r8]
	orr r0, r0, #0x20
	strb r0, [r1, r8]
	ldr r0, [r5, #0]
	add r0, r0, #0x2c0
	add r0, r0, r6
	add r0, r0, r8
	bl ovl09_2161B6C
	ldr r0, [r5, #0]
	cmp r9, #0
	add r0, r0, #0x340
	beq _021692D0
	add r0, r0, r6
	add r0, r0, r7
	bl ovl09_2164218
	b _021692DC
_021692D0:
	add r0, r0, r6
	add r0, r0, r7
	bl ovl09_21641F0
_021692DC:
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
	cmp r10, #0xa
	blo _021691BC
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #2
	blo _0216900C
	ldr r0, [r5, #0]
	mov r1, #0
	strh r1, [r0]
	ldr r0, [r5, #0]
	mov r1, #0xb3
	strh r1, [r0, #2]
	ldr r1, [r5, #0]
	mov r0, #0xd
	strh r0, [r1, #4]
	ldr r1, [r5, #0]
	mov r2, #0xc7
	strh r2, [r1, #6]
	ldr r1, [r5, #0]
	mov r2, #0xd3
	strh r0, [r1, #8]
	ldr r1, [r5, #0]
	mov r3, #0xe8
	strh r2, [r1, #0xa]
	ldr r1, [r5, #0]
	mov r2, #0xf4
	strh r0, [r1, #0xc]
	ldr r1, [r5, #0]
	strh r3, [r1, #0xe]
	ldr r1, [r5, #0]
	strh r0, [r1, #0x10]
	ldr r1, [r5, #0]
	strh r2, [r1, #0x12]
	ldr r1, [r5, #0]
	strh r0, [r1, #0x14]
	bl GetExTaskCurrent
	ldr r1, _0216939C // =ovl09_216944C
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02169388: .word 0x021766A8
_0216938C: .word 0x021766BC
_02169390: .word 0x02175CDC
_02169394: .word 0x02175CF0
_02169398: .word 0x0000E001
_0216939C: .word ovl09_216944C
	arm_func_end exFixTimeTask__Main

	arm_func_start exFixTimeTask__Func8
exFixTimeTask__Func8: // 0x021693A0
	ldr ip, _021693A8 // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_021693A8: .word GetExTaskWorkCurrent_
	arm_func_end exFixTimeTask__Func8

	arm_func_start exFixTimeTask__Destructor
exFixTimeTask__Destructor: // 0x021693AC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exFixTimeTask__Func_2173C78
	ldr r0, [r4, #0]
	add r0, r0, #0x18
	bl ovl09_2168F68
	ldr r0, [r4, #0]
	add r0, r0, #0xa0
	bl ovl09_2168F68
	ldr r0, [r4, #0]
	add r0, r0, #0x128
	bl ovl09_2168F68
	ldr r0, [r4, #0]
	add r0, r0, #0x1b0
	bl ovl09_2168F68
	ldr r0, [r4, #0]
	add r0, r0, #0x238
	bl ovl09_2168F68
	mov r5, #0
	mov r7, #0x88
_02169400:
	mul r6, r5, r7
	ldr r0, [r4, #0]
	add r0, r0, #0x2c0
	add r0, r0, r6
	bl ovl09_2168F68
	ldr r0, [r4, #0]
	add r0, r0, #0x810
	add r0, r0, r6
	bl ovl09_2168F68
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #0xa
	blo _02169400
	ldr r0, _02169448 // =0x021766A8
	mov r1, #0
	str r1, [r0, #0xc]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02169448: .word 0x021766A8
	arm_func_end exFixTimeTask__Destructor

	arm_func_start ovl09_216944C
ovl09_216944C: // 0x0216944C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	bl GetExTaskWorkCurrent_
	mov r5, r0
	bl exSysTask__GetStatus
	mov r4, r0
	ldrh r0, [r4, #0xa]
	ldr r1, [r5, #0]
	cmp r0, #9
	ldrh r8, [r1, #0]
	blo _02169484
	mov r0, #1
	strh r0, [r1]
	ldr r0, [r5, #0]
	ldrh r8, [r0, #0]
_02169484:
	mov r0, #0x550
	mul r7, r8, r0
	mov r6, #0
	mov r9, #0x88
_02169494:
	ldr r0, [r5, #0]
	add r0, r0, #0x2c0
	add r0, r0, r7
	mla r0, r6, r9, r0
	bl ovl09_2161908
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0xa
	blo _02169494
	mov r0, #0x550
	mul r6, r8, r0
	ldr r3, [r5, #0]
	ldrh r2, [r4, #0xa]
	add r0, r3, r6
	mov r1, #0x88
	mla r0, r2, r1, r0
	ldrsh r2, [r3, #2]
	add r0, r0, #0x300
	strh r2, [r0, #0x28]
	ldr r3, [r5, #0]
	ldrh r2, [r4, #0xa]
	add r0, r3, r6
	ldrsh r3, [r3, #4]
	mla r0, r2, r1, r0
	add r0, r0, #0x300
	strh r3, [r0, #0x2a]
	ldr r0, [r5, #0]
	ldrh r3, [r4, #0xa]
	add r2, r0, #0x2c0
	add r0, r0, #0x340
	mul r7, r3, r1
	add r2, r2, r6
	add r1, r0, r6
	add r0, r2, r7
	add r1, r1, r7
	bl ovl09_2164034
	ldr r3, [r5, #0]
	ldrh r2, [r4, #0xc]
	add r0, r3, r6
	mov r1, #0x88
	mla r0, r2, r1, r0
	ldrsh r2, [r3, #6]
	add r0, r0, #0x300
	strh r2, [r0, #0x28]
	ldr r3, [r5, #0]
	ldrh r2, [r4, #0xc]
	add r0, r3, r6
	ldrsh r3, [r3, #8]
	mla r0, r2, r1, r0
	add r0, r0, #0x300
	strh r3, [r0, #0x2a]
	ldr r0, [r5, #0]
	ldrh r3, [r4, #0xc]
	add r2, r0, #0x2c0
	add r0, r0, #0x340
	mul r7, r3, r1
	add r2, r2, r6
	add r1, r0, r6
	add r0, r2, r7
	add r1, r1, r7
	bl ovl09_2164034
	ldr r3, [r5, #0]
	ldrh r2, [r4, #0xe]
	add r0, r3, r6
	mov r1, #0x88
	mla r0, r2, r1, r0
	ldrsh r2, [r3, #0xa]
	add r0, r0, #0x300
	strh r2, [r0, #0x28]
	ldr r3, [r5, #0]
	ldrh r2, [r4, #0xe]
	add r0, r3, r6
	ldrsh r3, [r3, #0xc]
	mla r0, r2, r1, r0
	add r0, r0, #0x300
	strh r3, [r0, #0x2a]
	ldr r0, [r5, #0]
	ldrh r3, [r4, #0xe]
	add r2, r0, #0x2c0
	add r0, r0, #0x340
	mul r7, r3, r1
	add r2, r2, r6
	add r1, r0, r6
	add r0, r2, r7
	add r1, r1, r7
	bl ovl09_2164034
	ldr r3, [r5, #0]
	ldrh r2, [r4, #0x10]
	add r0, r3, r6
	mov r1, #0x88
	mla r0, r2, r1, r0
	ldrsh r2, [r3, #0xe]
	add r0, r0, #0x300
	strh r2, [r0, #0x28]
	ldr r3, [r5, #0]
	ldrh r2, [r4, #0x10]
	add r0, r3, r6
	ldrsh r3, [r3, #0x10]
	mla r0, r2, r1, r0
	add r0, r0, #0x300
	strh r3, [r0, #0x2a]
	ldrh r2, [r4, #0x10]
	ldr r0, [r5, #0]
	mul r3, r2, r1
	add r1, r0, #0x2c0
	add r0, r0, #0x340
	add r2, r1, r6
	add r1, r0, r6
	add r0, r2, r3
	add r1, r1, r3
	bl ovl09_2164034
	ldr r3, [r5, #0]
	ldrh r2, [r4, #0x12]
	add r0, r3, r6
	mov r1, #0x88
	mla r0, r2, r1, r0
	ldrsh r2, [r3, #0x12]
	add r0, r0, #0x300
	strh r2, [r0, #0x28]
	ldr r3, [r5, #0]
	ldrh r2, [r4, #0x12]
	add r0, r3, r6
	ldrsh r3, [r3, #0x14]
	mla r0, r2, r1, r0
	add r0, r0, #0x300
	strh r3, [r0, #0x2a]
	ldr r0, [r5, #0]
	ldrh r3, [r4, #0x12]
	add r2, r0, #0x2c0
	add r0, r0, #0x340
	mul r4, r3, r1
	add r2, r2, r6
	add r1, r0, r6
	add r0, r2, r4
	add r1, r1, r4
	bl ovl09_2164034
	ldr r1, [r5, #0]
	mov r0, #0x88
	mul r4, r8, r0
	add r0, r1, #0xa0
	add r1, r1, #0x120
	add r0, r0, r4
	add r1, r1, r4
	bl ovl09_2164034
	ldr r1, [r5, #0]
	add r0, r1, #0x1b0
	add r1, r1, #0x230
	add r0, r0, r4
	add r1, r1, r4
	bl ovl09_2164034
	ldr r0, [r5, #0]
	add r0, r0, #0x18
	bl ovl09_2161908
	ldr r1, [r5, #0]
	add r0, r1, #0x18
	add r1, r1, #0x98
	bl ovl09_2164034
	ldr r0, [r5, #0]
	add r0, r0, #0xa0
	add r0, r0, r4
	bl ovl09_2161908
	ldr r0, [r5, #0]
	add r0, r0, #0x1b0
	add r0, r0, r4
	bl ovl09_2161908
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end ovl09_216944C

	arm_func_start exFixTimeTask__Create
exFixTimeTask__Create: // 0x0216973C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #4
	ldr r0, _021697A4 // =aExfixtimetask
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021697A8 // =exFixTimeTask__Main
	ldr r1, _021697AC // =exFixTimeTask__Destructor
	mov r2, #0x1800
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r1, #0
	mov r2, #4
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, _021697B0 // =exFixTimeTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_021697A4: .word aExfixtimetask
_021697A8: .word exFixTimeTask__Main
_021697AC: .word exFixTimeTask__Destructor
_021697B0: .word exFixTimeTask__Func8
	arm_func_end exFixTimeTask__Create

	arm_func_start ovl09_21697B4
ovl09_21697B4: // 0x021697B4
	stmdb sp!, {r3, lr}
	ldr r0, _021697D8 // =0x021766A8
	ldr r0, [r0, #0xc]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, _021697DC // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021697D8: .word 0x021766A8
_021697DC: .word ExTask_State_Destroy
	arm_func_end ovl09_21697B4