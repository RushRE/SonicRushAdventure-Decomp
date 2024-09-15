	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ObjectUnknown1__Create
ObjectUnknown1__Create: // 0x0216BB24
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x10
	mov r4, r0
	ldrh r0, [r4, #4]
	mvn r7, #0
	mov r9, r1
	mov r5, r2
	mov r8, r7
	tst r0, #1
	ldrsb r2, [r4, #7]
	mov r1, #0x64
	ldrsb r3, [r4, #6]
	beq _0216BB70
	smulbb r2, r2, r1
	ldr r1, _0216BD4C // =0x00002710
	ldrb r6, [r4, #8]
	mla r1, r3, r1, r2
	add r8, r6, r1
	b _0216BB84
_0216BB70:
	smulbb r2, r2, r1
	ldr r1, _0216BD4C // =0x00002710
	ldrb r6, [r4, #8]
	mla r1, r3, r1, r2
	add r7, r6, r1
_0216BB84:
	tst r0, #4
	beq _0216BBE4
	ldr r0, _0216BD50 // =mapCamera
	ldrb r2, [r4, #9]
	ldr r0, [r0, #0xe0]
	mov r3, #0
	tst r0, #1
	mov r0, r7
	beq _0216BBB4
	mov r1, r8
	bl MapFarSys__Func_200B524
	b _0216BBD0
_0216BBB4:
	mov r1, r8
	bl MapFarSys__Func_200B524
	ldrb r2, [r4, #9]
	mov r0, r7
	mov r1, r8
	mov r3, #1
	bl MapFarSys__Func_200B524
_0216BBD0:
	mov r0, #0xff
	strb r0, [r4]
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0216BBE4:
	mov r0, #0x1800
	mov r2, #0
	str r0, [sp]
	mov r6, #2
	str r6, [sp, #4]
	mov r6, #0x36c
	ldr r0, _0216BD54 // =StageTask_Main
	ldr r1, _0216BD58 // =GameObject__Destructor
	mov r3, r2
	str r6, [sp, #8]
	bl TaskCreate_
	mov r6, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r6, r0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r6
	bl GetTaskWork_
	mov r6, r0
	mov r1, #0
	mov r2, #0x36c
	bl MI_CpuFill8
	mov r0, r6
	mov r2, r9
	mov r3, r5
	mov r1, r4
	bl GameObject__InitFromObject
	ldr r0, [r6, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r6, #0x1c]
	ldr r0, [r6, #0x20]
	orr r0, r0, #0x20
	str r0, [r6, #0x20]
	str r7, [r6, #0x364]
	str r8, [r6, #0x368]
	ldrh r0, [r4, #4]
	tst r0, #8
	beq _0216BD38
	ldr r0, _0216BD50 // =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	ldrsb r1, [r0, #0x46]
	streqb r1, [sp, #0xc]
	ldreqsb r0, [r0, #0xb6]
	streqb r0, [sp, #0xd]
	beq _0216BCB0
	mvn r0, #0
	strb r0, [sp, #0xd]
	strb r1, [sp, #0xc]
_0216BCB0:
	ldr r5, _0216BD5C // =gPlayerList
	add r10, sp, #0xc
	mov r9, #0
_0216BCBC:
	ldrsb r0, [r10]
	cmp r0, #0
	blt _0216BD24
	ldr r3, [r5, r0, lsl #2]
	ldr r2, [r6, #0x44]
	ldr r1, [r3, #0x44]
	sub r0, r2, #0x40000
	cmp r1, r0
	blt _0216BD24
	add r0, r2, #0x40000
	cmp r1, r0
	bgt _0216BD24
	ldr r2, [r6, #0x48]
	ldr r1, [r3, #0x48]
	sub r0, r2, #0x40000
	cmp r1, r0
	blt _0216BD24
	add r0, r2, #0x40000
	cmp r1, r0
	bgt _0216BD24
	ldrb r2, [r4, #9]
	mov r3, r9, lsl #0x18
	mov r0, r7
	mov r1, r8
	mov r3, r3, asr #0x18
	bl MapFarSys__Func_200B524
_0216BD24:
	add r9, r9, #1
	cmp r9, #2
	add r10, r10, #1
	blt _0216BCBC
	b _0216BD40
_0216BD38:
	ldr r0, _0216BD60 // =ObjectUnknown1__State_216BD64
	str r0, [r6, #0xf4]
_0216BD40:
	mov r0, r6
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0216BD4C: .word 0x00002710
_0216BD50: .word mapCamera
_0216BD54: .word StageTask_Main
_0216BD58: .word GameObject__Destructor
_0216BD5C: .word gPlayerList
_0216BD60: .word ObjectUnknown1__State_216BD64
	arm_func_end ObjectUnknown1__Create

	arm_func_start ObjectUnknown1__State_216BD64
ObjectUnknown1__State_216BD64: // 0x0216BD64
	stmdb sp!, {r4, r5, r6, lr}
	ldr r5, _0216BDF8 // =mapCamera
	mov r6, r0
	ldr r0, [r5, #0xe0]
	tst r0, #1
	beq _0216BDB0
	bl MapSys__GetCameraA
	mov r1, r0
	mov r0, r6
	bl ObjectUnknown1__Func_216BDFC
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #0x340]
	ldr r0, [r6, #0x364]
	ldrb r2, [r1, #9]
	ldr r1, [r6, #0x368]
	mov r3, #0
	bl MapFarSys__Func_200B524
	ldmia sp!, {r4, r5, r6, pc}
_0216BDB0:
	mov r4, #0
_0216BDB4:
	mov r0, r6
	mov r1, r5
	bl ObjectUnknown1__Func_216BDFC
	cmp r0, #0
	beq _0216BDE4
	ldr r0, [r6, #0x340]
	mov r3, r4, lsl #0x18
	ldrb r2, [r0, #9]
	ldr r0, [r6, #0x364]
	ldr r1, [r6, #0x368]
	mov r3, r3, asr #0x18
	bl MapFarSys__Func_200B524
_0216BDE4:
	add r4, r4, #1
	cmp r4, #2
	add r5, r5, #0x70
	blt _0216BDB4
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216BDF8: .word mapCamera
	arm_func_end ObjectUnknown1__State_216BD64

	arm_func_start ObjectUnknown1__Func_216BDFC
ObjectUnknown1__Func_216BDFC: // 0x0216BDFC
	ldr r2, [r0, #0x340]
	mov r3, #0
	ldrh r2, [r2, #4]
	tst r2, #1
	beq _0216BE38
	tst r2, #2
	ldr r1, [r1, #8]
	ldr r0, [r0, #0x368]
	beq _0216BE2C
	cmp r1, r0, lsl #12
	movlo r3, #1
	b _0216BE5C
_0216BE2C:
	cmp r1, r0, lsl #12
	movhs r3, #1
	b _0216BE5C
_0216BE38:
	tst r2, #2
	ldr r1, [r1, #4]
	ldr r0, [r0, #0x364]
	beq _0216BE54
	cmp r1, r0, lsl #12
	movlo r3, #1
	b _0216BE5C
_0216BE54:
	cmp r1, r0, lsl #12
	movhs r3, #1
_0216BE5C:
	mov r0, r3
	bx lr
	arm_func_end ObjectUnknown1__Func_216BDFC