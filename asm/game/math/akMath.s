	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start AkMath__Func_2002C40
AkMath__Func_2002C40: // 0x02002C40
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #4]
	mov r4, r1
	ldr r0, [r0, #4]
	mov r1, r2
	add r0, r0, #0x40
	bl NNS_G3dGetResDictIdxByName
	ldr r1, [r5, #8]
	tst r1, #0x10
	ldrneb r1, [r5, #0xae]
	mvneq r1, #0
	cmp r0, r1
	movne r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	add r1, sp, #0
	mov r0, #0x13
	mov r2, #1
	str r4, [sp]
	bl NNS_G3dGeBufferOP_N
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end AkMath__Func_2002C40

	arm_func_start AkMath__Func_2002C98
AkMath__Func_2002C98: // 0x02002C98
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	ldrh r4, [sp, #0x20]
	ldr r5, _02002D24 // =FX_SinCosTable_
	mov r4, r4, asr #4
	mov r6, r4, lsl #1
	add r4, r6, #1
	mov r6, r6, lsl #1
	ldrsh ip, [r5, r6]
	mov r4, r4, lsl #1
	ldrsh r5, [r5, r4]
	smull r4, r8, r1, ip
	smull r7, r6, r0, r5
	adds r7, r7, #0x800
	adc lr, r6, #0
	adds sb, r4, #0x800
	mov r4, r7, lsr #0xc
	smull r6, r7, r0, ip
	adc r0, r8, #0
	adds r8, r6, #0x800
	mov ip, sb, lsr #0xc
	smull r6, r5, r1, r5
	adc r7, r7, #0
	adds r1, r6, #0x800
	mov r6, r8, lsr #0xc
	orr r4, r4, lr, lsl #20
	orr ip, ip, r0, lsl #20
	sub r4, r4, ip
	adc r0, r5, #0
	mov r1, r1, lsr #0xc
	orr r6, r6, r7, lsl #20
	orr r1, r1, r0, lsl #20
	str r4, [r2]
	add r0, r6, r1
	str r0, [r3]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_02002D24: .word FX_SinCosTable_
	arm_func_end AkMath__Func_2002C98

	arm_func_start AkMath__Func_2002D28
AkMath__Func_2002D28: // 0x02002D28
	cmp r0, r1
	moveq r0, r1
	bxeq lr
	cmp r2, #0
	subge r3, r1, r0
	sublt r3, r0, r1
	mov r3, r3, lsl #0x10
	cmp r2, #0
	rsblt ip, r2, #0
	mov r3, r3, lsr #0x10
	movge ip, r2
	cmp r3, ip
	ble _02002D68
	add r0, r0, r2
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
_02002D68:
	mov r0, r1
	bx lr
	arm_func_end AkMath__Func_2002D28

	arm_func_start AkMath__BlendColors
AkMath__BlendColors: // 0x02002D70
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	ldr r6, [sp, #0x20]
	and r4, r2, #0x1f
	mul r8, r4, r6
	and r4, r2, #0x3e0
	mov r4, r4, asr #5
	mul r5, r4, r6
	and r7, r1, #0x3e0
	sub lr, r3, r6
	and r4, r1, #0x1f
	mla r8, r4, lr, r8
	mov r7, r7, asr #5
	mla r4, r7, lr, r5
	ldr ip, _02002E80 // =0x04000280
	mov r5, #0
	strh r5, [ip]
	str r8, [ip, #0x10]
	str r3, [ip, #0x18]
	str r5, [ip, #0x1c]
_02002DBC:
	ldrh r7, [ip]
	tst r7, #0x8000
	bne _02002DBC
	and r2, r2, #0x7c00
	mov r2, r2, asr #0xa
	mul r6, r2, r6
	ldr r2, _02002E84 // =0x040002A0
	and r1, r1, #0x7c00
	mov r7, r1, asr #0xa
	mla r1, r7, lr, r6
	ldrsh sb, [r2]
	mov r8, #0
	sub r7, r2, #0x20
	strh r8, [ip]
	str r4, [r2, #-0x10]
	sub r4, r2, #8
	mov r6, sb, lsl #0x10
	stmia r4, {r3, r5}
	mov r4, r6, lsr #0x10
_02002E08:
	ldrh r2, [r7]
	tst r2, #0x8000
	bne _02002E08
	ldr lr, _02002E84 // =0x040002A0
	mov r2, #0
	ldrsh ip, [lr]
	sub r6, lr, #8
	and r4, r4, #0x1f
	strh r2, [r7]
	str r1, [lr, #-0x10]
	mov r2, ip, lsl #0x10
	mov r1, r2, lsr #0xb
	and r1, r1, #0x3e0
	stmia r6, {r3, r5}
	orr r1, r4, r1
	strh r1, [r0]
	sub r2, lr, #0x20
_02002E4C:
	ldrh r1, [r2]
	tst r1, #0x8000
	bne _02002E4C
	ldr r1, _02002E84 // =0x040002A0
	ldrh r2, [r0]
	ldrsh r1, [r1]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #6
	and r1, r1, #0x7c00
	mov r1, r1, lsl #0x10
	orr r1, r2, r1, lsr #16
	strh r1, [r0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_02002E80: .word 0x04000280
_02002E84: .word 0x040002A0
	arm_func_end AkMath__BlendColors