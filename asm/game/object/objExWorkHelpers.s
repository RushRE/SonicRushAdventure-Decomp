	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start sub_20773A0
sub_20773A0: // 0x020773A0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0xa8
	mov r6, r0
	ldr r0, [r6, #8]
	mov r5, r1
	cmp r0, #0
	ldr r4, [r5, #0x38]
	addne sp, sp, #0xa8
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, [r5, #0x10]
	bic r0, r0, #2
	str r0, [r5, #0x10]
	ldrsh r0, [r5, #0xa]
	cmp r0, #0
	bne _02077684
	ldrsh r1, [r5, #2]
	mov r0, #0x1c
	add r1, r1, #1
	strh r1, [r5, #2]
	ldrsh r1, [r5, #2]
	smlabb r1, r1, r0, r4
	ldrb r1, [r1, #0x18]
	strh r1, [r5, #0xa]
	ldrsh r1, [r5, #0xa]
	cmp r1, #0
	bne _02077448
	ldr r1, [r5, #0x10]
	orr r1, r1, #2
	str r1, [r5, #0x10]
	tst r1, #0x40
	beq _02077434
	ldrsh r1, [r5, #0x56]
	smlabb r0, r1, r0, r4
	strh r1, [r5, #2]
	ldrb r0, [r0, #0x18]
	strh r0, [r5, #0xa]
	b _02077448
_02077434:
	ldrsh r0, [r5, #2]
	add sp, sp, #0xa8
	sub r0, r0, #1
	strh r0, [r5, #2]
	ldmia sp!, {r4, r5, r6, pc}
_02077448:
	ldrsh r1, [r5, #2]
	mov r0, #0x1c
	smlabb r0, r1, r0, r4
	ldrb r0, [r0, #0x19]
	tst r0, #1
	strneh r1, [r5, #0x56]
	ldr r0, [r5, #0x10]
	tst r0, #0x2000000
	bne _02077684
	ldrsh r1, [r5, #2]
	mov r0, #0x1c
	smulbb r3, r1, r0
	add r0, r4, r3
	ldmib r0, {r1, r2}
	ldr r0, [r4, r3]
	str r0, [sp, #0x9c]
	str r2, [sp, #0xa4]
	str r1, [sp, #0xa0]
	ldr r1, [r5, #0x20]
	cmp r1, #0
	ldreq r0, [r5, #0x24]
	cmpeq r0, #0
	ldreq r0, [r5, #0x28]
	cmpeq r0, #0
	beq _02077508
	ldr r0, [sp, #0x9c]
	ldr r2, [sp, #0xa0]
	smull r3, r1, r0, r1
	adds r3, r3, #0x800
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x9c]
	ldr r0, [r5, #0x24]
	ldr r1, [sp, #0xa4]
	smull r3, r0, r2, r0
	adds r2, r3, #0x800
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [sp, #0xa0]
	ldr r0, [r5, #0x28]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0xa4]
_02077508:
	ldrh r1, [r5, #0x2c]
	ldrh r0, [r5, #0x2e]
	ldrh r2, [r5, #0x30]
	orr r0, r1, r0
	orrs r0, r2, r0
	beq _0207761C
	add r0, sp, #0x54
	bl MTX_Identity33_
	ldrh r0, [r5, #0x2c]
	cmp r0, #0
	beq _02077574
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _020778BC // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0x78
	bl MTX_RotX33_
	add r0, sp, #0x54
	add r1, sp, #0x78
	mov r2, r0
	bl MTX_Concat33
_02077574:
	ldrh r0, [r5, #0x2e]
	cmp r0, #0
	beq _020775C0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _020778BC // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0x78
	bl MTX_RotY33_
	add r0, sp, #0x54
	add r1, sp, #0x78
	mov r2, r0
	bl MTX_Concat33
_020775C0:
	ldrh r0, [r5, #0x30]
	cmp r0, #0
	beq _0207760C
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _020778BC // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0x78
	bl MTX_RotZ33_
	add r0, sp, #0x54
	add r1, sp, #0x78
	mov r2, r0
	bl MTX_Concat33
_0207760C:
	add r0, sp, #0x9c
	add r1, sp, #0x54
	mov r2, r0
	bl MTX_MultVec33
_0207761C:
	ldr r0, [r5, #0x10]
	tst r0, #0x20
	ldrne r0, [sp, #0x9c]
	rsbne r0, r0, #0
	strne r0, [sp, #0x9c]
	ldr r0, [r5, #0x10]
	tst r0, #0x10
	ldrne r0, [sp, #0xa0]
	rsbne r0, r0, #0
	strne r0, [sp, #0xa0]
	ldr r0, [r5, #0x10]
	tst r0, #0x200
	beq _0207766C
	ldr r2, [sp, #0xa4]
	ldr r1, [sp, #0xa0]
	ldr r0, [sp, #0x9c]
	str r0, [r5, #0x14]
	str r1, [r5, #0x18]
	str r2, [r5, #0x1c]
	b _02077684
_0207766C:
	ldr r2, [sp, #0xa4]
	ldr r1, [sp, #0xa0]
	ldr r0, [sp, #0x9c]
	str r0, [r6, #0x98]
	str r1, [r6, #0x9c]
	str r2, [r6, #0xa0]
_02077684:
	ldr r0, [r5, #0x10]
	tst r0, #0x2000000
	bne _020778A8
	ldrsh r1, [r5, #2]
	mov r0, #0x1c
	smlabb r0, r1, r0, r4
	ldr r2, [r0, #0x14]
	ldr r1, [r0, #0x10]
	ldr r0, [r0, #0xc]
	str r0, [sp, #0x48]
	str r2, [sp, #0x50]
	str r1, [sp, #0x4c]
	ldr r1, [r5, #0x20]
	cmp r1, #0
	ldreq r0, [r5, #0x24]
	cmpeq r0, #0
	ldreq r0, [r5, #0x28]
	cmpeq r0, #0
	beq _0207772C
	ldr r0, [sp, #0x48]
	ldr r2, [sp, #0x4c]
	smull r3, r1, r0, r1
	adds r3, r3, #0x800
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x48]
	ldr r0, [r5, #0x24]
	ldr r1, [sp, #0x50]
	smull r3, r0, r2, r0
	adds r2, r3, #0x800
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [sp, #0x4c]
	ldr r0, [r5, #0x28]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x50]
_0207772C:
	ldrh r1, [r5, #0x2c]
	ldrh r0, [r5, #0x2e]
	ldrh r2, [r5, #0x30]
	orr r0, r1, r0
	orrs r0, r2, r0
	beq _02077840
	add r0, sp, #0
	bl MTX_Identity33_
	ldrh r0, [r5, #0x2c]
	cmp r0, #0
	beq _02077798
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _020778BC // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0x24
	bl MTX_RotX33_
	add r0, sp, #0
	add r1, sp, #0x24
	mov r2, r0
	bl MTX_Concat33
_02077798:
	ldrh r0, [r5, #0x2e]
	cmp r0, #0
	beq _020777E4
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _020778BC // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0x24
	bl MTX_RotY33_
	add r0, sp, #0
	add r1, sp, #0x24
	mov r2, r0
	bl MTX_Concat33
_020777E4:
	ldrh r0, [r5, #0x30]
	cmp r0, #0
	beq _02077830
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _020778BC // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0x24
	bl MTX_RotZ33_
	add r0, sp, #0
	add r1, sp, #0x24
	mov r2, r0
	bl MTX_Concat33
_02077830:
	add r0, sp, #0x48
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
_02077840:
	ldr r0, [r5, #0x10]
	tst r0, #0x20
	ldrne r0, [sp, #0x48]
	rsbne r0, r0, #0
	strne r0, [sp, #0x48]
	ldr r0, [r5, #0x10]
	tst r0, #0x10
	ldrne r0, [sp, #0x4c]
	rsbne r0, r0, #0
	strne r0, [sp, #0x4c]
	ldr r0, [r5, #0x10]
	tst r0, #0x200
	beq _02077898
	add r0, r6, #0x74
	add r1, r5, #0x14
	mov r2, r0
	bl VEC_Add
	add r0, r5, #0x14
	add r1, sp, #0x48
	mov r2, r0
	bl VEC_Add
	b _020778A8
_02077898:
	add r0, r6, #0x98
	add r1, sp, #0x48
	mov r2, r0
	bl VEC_Add
_020778A8:
	ldrsh r0, [r5, #0xa]
	sub r0, r0, #1
	strh r0, [r5, #0xa]
	add sp, sp, #0xa8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020778BC: .word FX_SinCosTable_
	arm_func_end sub_20773A0

	arm_func_start sub_20778C0
sub_20778C0: // 0x020778C0
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	ldr r1, [r5, #0x10]
	ldr r4, [r5, #0x34]
	bic r1, r1, #1
	str r1, [r5, #0x10]
	ldrsh r1, [r5, #8]
	mov r6, r0
	cmp r1, #0
	bne _0207799C
	ldrsh r0, [r5]
	add r0, r0, #1
	strh r0, [r5]
	ldrsh r0, [r5]
	add r0, r4, r0, lsl #2
	ldrb r0, [r0, #2]
	strh r0, [r5, #8]
	ldrsh r0, [r5, #8]
	cmp r0, #0
	bne _0207794C
	ldr r0, [r5, #0x10]
	orr r0, r0, #1
	str r0, [r5, #0x10]
	tst r0, #0x40
	beq _0207793C
	ldrsh r0, [r5, #0x54]
	strh r0, [r5]
	add r0, r4, r0, lsl #2
	ldrb r0, [r0, #2]
	strh r0, [r5, #8]
	b _0207794C
_0207793C:
	ldrsh r0, [r5]
	sub r0, r0, #1
	strh r0, [r5]
	ldmia sp!, {r4, r5, r6, pc}
_0207794C:
	ldrsh r1, [r5]
	add r0, r4, r1, lsl #2
	ldrb r0, [r0, #3]
	tst r0, #1
	strneh r1, [r5, #0x54]
	ldr r0, [r5, #0x10]
	tst r0, #0x1000000
	bne _0207799C
	ldrsh r1, [r5]
	mov r0, r6
	mov r1, r1, lsl #2
	ldrh r1, [r4, r1]
	bl StageTask__SetAnimation
	ldrsh r0, [r5]
	add r0, r4, r0, lsl #2
	ldrb r0, [r0, #3]
	tst r0, #2
	ldrne r0, [r6, #0x20]
	orrne r0, r0, #4
	strne r0, [r6, #0x20]
_0207799C:
	ldrsh r0, [r5, #8]
	sub r0, r0, #1
	strh r0, [r5, #8]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20778C0

	arm_func_start sub_20779AC
sub_20779AC: // 0x020779AC
	stmdb sp!, {r3, lr}
	ldr r3, [r1, #0x10]
	ldr r2, [r1, #0x3c]
	bic r3, r3, #4
	str r3, [r1, #0x10]
	ldrsh r3, [r1, #0xc]
	cmp r3, #0
	bne _02077A70
	ldrsh r3, [r1, #4]
	add r3, r3, #1
	strh r3, [r1, #4]
	ldrsh r3, [r1, #4]
	add r3, r2, r3, lsl #4
	ldrb r3, [r3, #0xc]
	strh r3, [r1, #0xc]
	ldrsh r3, [r1, #0xc]
	cmp r3, #0
	bne _02077A30
	ldr r3, [r1, #0x10]
	orr r3, r3, #4
	str r3, [r1, #0x10]
	tst r3, #0x40
	beq _02077A20
	ldrsh r3, [r1, #0x58]
	strh r3, [r1, #4]
	add r3, r2, r3, lsl #4
	ldrb r3, [r3, #0xc]
	strh r3, [r1, #0xc]
	b _02077A30
_02077A20:
	ldrsh r0, [r1, #4]
	sub r0, r0, #1
	strh r0, [r1, #4]
	ldmia sp!, {r3, pc}
_02077A30:
	ldrsh ip, [r1, #4]
	add r3, r2, ip, lsl #4
	ldrb r3, [r3, #0xd]
	tst r3, #1
	strneh ip, [r1, #0x58]
	ldr r3, [r1, #0x10]
	tst r3, #0x4000000
	bne _02077A70
	ldrsh lr, [r1, #4]
	add r3, r2, lr, lsl #4
	ldr ip, [r3, #8]
	ldr r3, [r3, #4]
	ldr r2, [r2, lr, lsl #4]
	str r2, [r0, #0x38]
	str r3, [r0, #0x3c]
	str ip, [r0, #0x40]
_02077A70:
	ldrsh r0, [r1, #0xc]
	sub r0, r0, #1
	strh r0, [r1, #0xc]
	ldmia sp!, {r3, pc}
	arm_func_end sub_20779AC

	arm_func_start sub_2077A80
sub_2077A80: // 0x02077A80
	ldr r3, [r1, #0x10]
	ldr r2, [r1, #0x40]
	bic r3, r3, #1
	str r3, [r1, #0x10]
	ldrsh r3, [r1, #0xe]
	cmp r3, #0
	bne _02077B50
	ldrsh r3, [r1, #6]
	add r3, r3, #1
	strh r3, [r1, #6]
	ldrsh r3, [r1, #6]
	add r3, r2, r3, lsl #3
	ldrb r3, [r3, #6]
	strh r3, [r1, #0xe]
	ldrsh r3, [r1, #0xe]
	cmp r3, #0
	bne _02077B00
	ldr r3, [r1, #0x10]
	orr r3, r3, #1
	str r3, [r1, #0x10]
	tst r3, #0x40
	beq _02077AF0
	ldrsh r3, [r1, #0x5a]
	strh r3, [r1, #6]
	add r3, r2, r3, lsl #3
	ldrb r3, [r3, #6]
	strh r3, [r1, #0xe]
	b _02077B00
_02077AF0:
	ldrsh r0, [r1, #6]
	sub r0, r0, #1
	strh r0, [r1, #6]
	bx lr
_02077B00:
	ldrsh ip, [r1, #6]
	add r3, r2, ip, lsl #3
	ldrb r3, [r3, #7]
	tst r3, #1
	strneh ip, [r1, #0x5a]
	ldr r3, [r1, #0x10]
	tst r3, #0x8000000
	bne _02077B50
	ldrsh r3, [r1, #6]
	mov r3, r3, lsl #3
	ldrh r3, [r2, r3]
	strh r3, [r0, #0x30]
	ldrsh r3, [r1, #6]
	add r3, r2, r3, lsl #3
	ldrh r3, [r3, #2]
	strh r3, [r0, #0x32]
	ldrsh r3, [r1, #6]
	add r2, r2, r3, lsl #3
	ldrh r2, [r2, #4]
	strh r2, [r0, #0x34]
_02077B50:
	ldrsh r0, [r1, #0xe]
	sub r0, r0, #1
	strh r0, [r1, #0xe]
	bx lr
	arm_func_end sub_2077A80