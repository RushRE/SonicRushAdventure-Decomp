	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailRampTrick__Create
SailRampTrick__Create: // 0x0217810C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov ip, #0xf00
	mov r2, #0
	str ip, [sp]
	mov r4, #1
	ldr r0, _02178168 // =SailRampTrick__Main
	ldr r1, _0217816C // =SailRampTrick__Destructor
	mov r3, r2
	str r4, [sp, #4]
	sub r4, ip, #0x14
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02178170 // =0x00000EEC
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	mov r0, r4
	bl SailRampTrick__SetupAnimators
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02178168: .word SailRampTrick__Main
_0217816C: .word SailRampTrick__Destructor
_02178170: .word 0x00000EEC
	arm_func_end SailRampTrick__Create

	arm_func_start SailRampTrick__Destructor
SailRampTrick__Destructor: // 0x02178174
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl GetCurrentTaskWork_
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x53
	bl GetObjectFileWork
	bl ObjDataRelease
	mov r5, #0
_0217819C:
	add r0, r5, r5, lsl #4
	add r1, r4, r0, lsl #4
	ldr r0, [r1, #0xc]
	cmp r0, #1
	beq _021781C4
	cmp r0, #2
	beq _021781D0
	cmp r0, #3
	beq _021781DC
	b _021781E4
_021781C4:
	add r0, r1, #0xc
	bl AnimatorMDL__Release
	b _021781E4
_021781D0:
	add r0, r1, #0xc
	bl AnimatorShape3D__Release
	b _021781E4
_021781DC:
	add r0, r1, #0xc
	bl AnimatorSprite3D__Release
_021781E4:
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #0xe
	blo _0217819C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailRampTrick__Destructor

	arm_func_start SailRampTrick__Main
SailRampTrick__Main: // 0x021781FC
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailRampTrick__Func_21782C8
	mov r0, r4
	bl SailRampTrick__Func_217874C
	mov r0, r4
	bl SailRampTrick__Func_2179168
	ldmia sp!, {r4, pc}
	arm_func_end SailRampTrick__Main

	arm_func_start SailRampTrick__SetupAnimators
SailRampTrick__SetupAnimators: // 0x02178220
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #0xc
	mov sb, r0
	mov r0, #0x53
	bl GetObjectFileWork
	mov r4, r0
	bl SailManager__GetArchive
	mov r2, r0
	ldr r1, _021782C4 // =aSbTrickBac_0
	mov r0, r4
	bl ObjDataLoad
	mov r8, #0
	mov r7, r0
	mov r6, r8
	mov r5, r8
	mov r4, r8
_02178260:
	mov r0, r7
	bl Sprite__GetTextureSize
	mov r1, r6
	bl VRAMSystem__AllocTexture
	mov sl, r0
	mov r0, r7
	bl Sprite__GetPaletteSize
	mov r1, r5
	bl VRAMSystem__AllocPalette
	stmia sp, {r4, sl}
	str r0, [sp, #8]
	add r0, r8, r8, lsl #4
	add r0, sb, r0, lsl #4
	add r0, r0, #0xc
	mov r1, r4
	mov r2, r7
	mov r3, r4
	bl AnimatorSprite3D__Init
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #0xe
	blo _02178260
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	.align 2, 0
_021782C4: .word aSbTrickBac_0
	arm_func_end SailRampTrick__SetupAnimators

	arm_func_start SailRampTrick__Func_21782C8
SailRampTrick__Func_21782C8: // 0x021782C8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	mov r1, #0
	cmp r0, #0
	ldrne r1, [r0, #0x124]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	add r1, r4, #0xe00
	ldrh r1, [r1, #0xe2]
	tst r1, #4
	beq _02178324
	ldr r1, [r0, #0x1c]
	tst r1, #1
	bne _02178314
	ldr r1, [r0, #0x24]
	tst r1, #0x8000
	ldmeqia sp!, {r4, pc}
_02178314:
	add r1, r4, #0xe00
	ldrh r2, [r1, #0xe2]
	bic r2, r2, #4
	strh r2, [r1, #0xe2]
_02178324:
	ldr r1, [r0, #0x1c]
	tst r1, #0x10
	beq _0217838C
	ldr r3, [r0, #0x24]
	tst r3, #2
	bne _0217838C
	add r1, r4, #0xe00
	ldrh r2, [r1, #0xe2]
	tst r2, #8
	bne _0217838C
	tst r3, #0x8000
	bne _0217838C
	tst r2, #1
	bne _02178370
	orr r0, r2, #2
	strh r0, [r1, #0xe2]
	ldrh r0, [r1, #0xe2]
	orr r0, r0, #1
	strh r0, [r1, #0xe2]
_02178370:
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xe2]
	tst r0, #2
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl SailRampTrick__Func_2178408
	ldmia sp!, {r4, pc}
_0217838C:
	add r1, r4, #0xe00
	ldrh r1, [r1, #0xe2]
	tst r1, #1
	ldmeqia sp!, {r4, pc}
	ldr r0, [r0, #0x24]
	tst r0, #2
	bne _021783B0
	tst r1, #8
	beq _021783C0
_021783B0:
	add r0, r4, #0xe00
	ldrh r1, [r0, #0xe2]
	orr r1, r1, #4
	strh r1, [r0, #0xe2]
_021783C0:
	add r0, r4, #0xe00
	ldrh r1, [r0, #0xe2]
	mov r3, #0
	bic r1, r1, #9
	strh r1, [r0, #0xe2]
	ldrb r0, [r4, #0xee1]
	strb r0, [r4, #0xee0]
_021783DC:
	add r0, r3, r3, lsl #4
	add r2, r4, r0, lsl #4
	ldrb r1, [r2, #7]
	add r0, r3, #1
	mov r0, r0, lsl #0x10
	bic r1, r1, #1
	mov r3, r0, lsr #0x10
	strb r1, [r2, #7]
	cmp r3, #0xe
	blo _021783DC
	ldmia sp!, {r4, pc}
	arm_func_end SailRampTrick__Func_21782C8

	arm_func_start SailRampTrick__Func_2178408
SailRampTrick__Func_2178408: // 0x02178408
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r0
	bl SailManager__GetWork
	mov r1, #0
	ldr r0, [r0, #0x70]
	mov r5, r1
	mov r3, r1
	cmp r0, #0
	ldrne r1, [r0, #0x124]
	cmp r1, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r2, r4, #0xe00
	mov r0, #0
	strh r0, [r2, #0xe6]
	strh r0, [r2, #0xe4]
	add r1, r1, #0x100
	ldrh r0, [r1, #0xda]
	ldrsh r1, [r1, #0xdc]
	cmp r0, #0x1e
	strh r1, [r2, #0xe8]
	bne _021784A0
	ldr r3, _02178738 // =_mt_math_rand
	ldr r0, _0217873C // =0x00196225
	ldr r6, [r3]
	ldr r2, _02178740 // =0x3C6EF35F
	mov r1, #0x1e
	mla r2, r6, r0, r2
	mov r0, r2, lsr #0x10
	mov r6, r0, lsl #0x10
	mov r0, r6, lsr #0x10
	str r2, [r3]
	bl FX_DivS32
	mov r1, #0x1e
	mul r1, r0, r1
	rsb r0, r1, r6, lsr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r3, #1
_021784A0:
	ldr r1, _02178744 // =0x0218BC95
	cmp r3, #0
	ldrb r1, [r1, r0, lsl #6]
	mov ip, #0
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r6, r1, asr #0x10
	beq _02178508
	cmp r0, #6
	cmpne r0, #0xc
	cmpne r0, #0xe
	cmpne r0, #0x10
	cmpne r0, #0x18
	cmpne r0, #0x1a
	addeq r1, r4, #0xe00
	mvneq r2, #0x3f
	streqh r2, [r1, #0xe8]
	cmp r0, #7
	cmpne r0, #0xd
	cmpne r0, #0xf
	cmpne r0, #0x11
	cmpne r0, #0x19
	cmpne r0, #0x1b
	addeq r1, r4, #0xe00
	moveq r2, #0x40
	streqh r2, [r1, #0xe8]
_02178508:
	add r1, r0, #0x3e4
	add r1, r1, #0xfc00
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r1, #1
	ldr r1, _02178748 // =_0218BC94
	mvnls r6, #0x7f
	mov r3, #0
	add lr, r1, r0, lsl #6
_0217852C:
	mov r1, #0
_02178530:
	add r0, r1, r1, lsl #4
	add r2, r4, r0, lsl #4
	ldrb r0, [r2, #7]
	tst r0, #1
	beq _02178558
	add r0, r1, #1
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	cmp r1, #0xe
	blo _02178530
_02178558:
	mov r0, #0
	orr r1, r0, #9
	strb r1, [r2, #7]
	add r1, lr, r3, lsl #2
	ldrb r7, [r1, #3]
	tst r7, #0x20
	beq _02178590
	ldrb r7, [r2, #7]
	add r5, r5, #1
	mov r5, r5, lsl #0x10
	orr r7, r7, #0x20
	mov ip, r0
	strb r7, [r2, #7]
	mov r5, r5, lsr #0x10
_02178590:
	cmp r3, #0
	ldreqb r0, [r2, #7]
	add r7, r4, #0xe00
	orreq r0, r0, #0x20
	streqb r0, [r2, #7]
	cmp r5, #0
	ldrneb r0, [r2, #7]
	orrne r0, r0, #0x10
	strneb r0, [r2, #7]
	ldrb r8, [r4, #0xee1]
	add r0, ip, #1
	mov r0, r0, lsl #0x10
	strb r8, [r2, #0xb]
	ldrb r8, [r1]
	cmp r3, #0
	mov r8, r8, lsl #0x18
	mov r8, r8, lsr #0x1c
	strb r8, [r2, #4]
	strb ip, [r2, #5]
	ldrb r8, [r1, #1]
	mov ip, r0, lsr #0x10
	add r0, r8, r6
	add r0, r0, #0x80
	strh r0, [r2]
	ldrsh r8, [r2]
	ldrsh r0, [r7, #0xe8]
	add r0, r8, r0
	strh r0, [r2]
	ldrb r0, [r1, #2]
	strh r0, [r2, #2]
	ldrb r0, [r1]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	strb r0, [r2, #6]
	beq _02178664
	ldrb r0, [r1, #3]
	tst r0, #0x27
	bne _02178664
	mov r0, #0x16
	strb r0, [r2, #0xa]
	ldrb r0, [r2, #6]
	cmp r0, #4
	bls _02178654
	cmp r0, #0xc
	bhi _02178654
	ldrsh r0, [r2, #2]
	add r0, r0, #5
	strh r0, [r2, #2]
	b _021786F0
_02178654:
	ldrsh r0, [r2, #2]
	sub r0, r0, #6
	strh r0, [r2, #2]
	b _021786F0
_02178664:
	ldrb r0, [r1]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	and r0, r0, #3
	strb r0, [r2, #0xa]
	ldrb r0, [r2, #6]
	cmp r0, #4
	cmpne r0, #0xc
	moveq r0, #4
	streqb r0, [r2, #0xa]
	beq _021786AC
	tst r0, #4
	beq _021786AC
	ldrb r0, [r2, #0xa]
	eor r7, r0, #3
	and r0, r7, #0xff
	add r0, r0, #1
	strb r0, [r2, #0xa]
_021786AC:
	ldr r0, [r2, #0xd8]
	bic r0, r0, #0x180
	str r0, [r2, #0xd8]
	ldrb r0, [r2, #6]
	cmp r0, #4
	bls _021786D4
	cmp r0, #0xc
	ldrls r0, [r2, #0xd8]
	orrls r0, r0, #0x100
	strls r0, [r2, #0xd8]
_021786D4:
	ldrb r0, [r1]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	cmp r0, #8
	ldrhs r0, [r2, #0xd8]
	orrhs r0, r0, #0x80
	strhs r0, [r2, #0xd8]
_021786F0:
	ldrb r0, [r1, #3]
	and r0, r0, #7
	strb r0, [r2, #8]
	ldrb r0, [r4, #0xee1]
	add r0, r0, #1
	strb r0, [r4, #0xee1]
	ldrb r0, [r1, #3]
	tst r0, #0x10
	bne _02178724
	add r0, r3, #1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	b _0217852C
_02178724:
	add r0, r4, #0xe00
	ldrh r1, [r0, #0xe2]
	bic r1, r1, #2
	strh r1, [r0, #0xe2]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02178738: .word _mt_math_rand
_0217873C: .word 0x00196225
_02178740: .word 0x3C6EF35F
_02178744: .word 0x0218BC95
_02178748: .word _0218BC94
	arm_func_end SailRampTrick__Func_2178408

	arm_func_start SailRampTrick__Func_217874C
SailRampTrick__Func_217874C: // 0x0217874C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x50
	mov sl, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	mov sb, #0
	cmp r0, #0
	ldrne sb, [r0, #0x124]
	str r0, [sp, #0x18]
	cmp sb, #0
	addeq sp, sp, #0x50
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	add r0, sl, #0x2e4
	add r1, sl, #0xe6
	add r6, r0, #0xc00
	add r0, r1, #0xe00
	str r0, [sp, #0x1c]
	ldr r0, _02178BC4 // =0x00001770
	add r2, sl, #0xe2
	mov r0, r0, lsr #1
	str r0, [sp, #0x20]
	add r0, sb, #0x100
	mov r7, #0
	add fp, r2, #0xe00
	add r5, sl, #0xe00
	add r4, sb, #0x200
	str r0, [sp, #0x24]
_021787B8:
	add r0, r7, r7, lsl #4
	add r8, sl, r0, lsl #4
	ldrb r2, [r8, #7]
	tst r2, #1
	beq _02178BA8
	tst r2, #8
	beq _02178858
	ldrsb r1, [r8, #4]
	cmp r1, #0
	beq _02178BA8
	tst r2, #0x10
	beq _021787FC
	ldrsh r0, [r5, #0xe6]
	cmp r0, #0
	subne r0, r1, #1
	strneb r0, [r8, #4]
	b _02178804
_021787FC:
	sub r0, r1, #1
	strb r0, [r8, #4]
_02178804:
	ldrsb r0, [r8, #4]
	cmp r0, #0
	bne _02178BA8
	ldrb r0, [r8, #7]
	orr r0, r0, #2
	bic r0, r0, #8
	strb r0, [r8, #7]
	ldrb r0, [r8, #0xa]
	cmp r0, #0x16
	bne _0217883C
	add r0, r8, #0x9c
	mov r1, #0x16
	bl AnimatorSprite__SetAnimation
	b _0217884C
_0217883C:
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	add r0, r8, #0x9c
	bl AnimatorSprite__SetAnimation
_0217884C:
	mov r0, #0x2000
	str r0, [r8, #0xd4]
	b _02178BA8
_02178858:
	tst r2, #2
	beq _021788DC
	ldr r0, [r8, #0xd8]
	tst r0, #0x40000000
	beq _02178874
	tst r2, #0x20
	bne _02178880
_02178874:
	ldrsh r0, [r5, #0xe4]
	cmp r0, #0
	beq _021788DC
_02178880:
	ldrsb r0, [r8, #5]
	cmp r0, #0
	bne _021788D4
	ldrb r0, [r8, #7]
	bic r0, r0, #2
	strb r0, [r8, #7]
	ldrb r0, [r8, #0xa]
	cmp r0, #0x16
	bne _021788B4
	add r0, r8, #0x9c
	mov r1, #0x17
	bl AnimatorSprite__SetAnimation
	b _021788C8
_021788B4:
	add r0, r0, #5
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	add r0, r8, #0x9c
	bl AnimatorSprite__SetAnimation
_021788C8:
	mov r0, #0x2000
	str r0, [r8, #0xd4]
	b _021788DC
_021788D4:
	sub r0, r0, #1
	strb r0, [r8, #5]
_021788DC:
	ldrb r0, [r8, #7]
	tst r0, #4
	beq _021788FC
	ldr r0, [r8, #0xd8]
	tst r0, #0x40000000
	movne r0, #0
	strneb r0, [r8, #7]
	bne _02178BA8
_021788FC:
	ldrb r1, [sl, #0xee0]
	ldrb r0, [r8, #0xb]
	cmp r1, r0
	bne _02178BA8
	ldrsh r0, [r5, #0xe4]
	cmp r0, #0
	beq _0217899C
	ldrh r0, [r4, #0x3c]
	tst r0, #1
	bne _02178994
	ldrsh r0, [r6]
	sub r0, r0, #1
	strh r0, [r6]
	ldrsh r0, [r5, #0xe4]
	cmp r0, #0
	bne _0217899C
	ldrsh r2, [r8, #2]
	ldrsh r1, [r8]
	add r0, sp, #0x44
	mov r2, r2, lsl #0xc
	mov r1, r1, lsl #0xc
	str r1, [sp, #0x44]
	mov r1, #0
	str r2, [sp, #0x48]
	str r1, [sp, #0x4c]
	ldrh r1, [fp]
	orr r1, r1, #8
	strh r1, [fp]
	bl SailJetHUDCross__Create
	mov r0, #0
	mov r1, #0xc
	mov r2, r0
	bl SailAudio__PlaySpatialSequence
	mov r0, #0
	mov r1, #0x6a
	mov r2, r0
	bl SailAudio__PlaySpatialSequence
	b _02178BA8
_02178994:
	mov r0, #0xc
	strh r0, [r5, #0xe4]
_0217899C:
	ldrh r0, [r4, #0x3c]
	tst r0, #1
	beq _02178BA8
	add r0, sp, #0x34
	mov r1, r8
	bl SailRampTrick__Func_2178BCC
	ldrsh r0, [sp, #0x34]
	str r0, [sp]
	ldrsh r0, [sp, #0x36]
	str r0, [sp, #4]
	ldrsh r0, [sp, #0x38]
	str r0, [sp, #8]
	ldrsh r0, [sp, #0x3a]
	str r0, [sp, #0xc]
	ldrsh r0, [sp, #0x3c]
	str r0, [sp, #0x10]
	ldrsh r0, [sp, #0x3e]
	str r0, [sp, #0x14]
	ldrh r0, [r4, #0x30]
	ldrh r1, [r4, #0x32]
	ldrh r2, [r4, #0x34]
	ldrh r3, [r4, #0x36]
	bl SailRampTrick__Func_2178DC4
	cmp r0, #0
	bne _02178A4C
	ldrsh r0, [sp, #0x38]
	str r0, [sp]
	ldrsh r0, [sp, #0x3a]
	str r0, [sp, #4]
	ldrsh r0, [sp, #0x3c]
	str r0, [sp, #8]
	ldrsh r0, [sp, #0x3e]
	str r0, [sp, #0xc]
	ldrsh r0, [sp, #0x40]
	str r0, [sp, #0x10]
	ldrsh r0, [sp, #0x42]
	str r0, [sp, #0x14]
	ldrh r0, [r4, #0x30]
	ldrh r1, [r4, #0x32]
	ldrh r2, [r4, #0x34]
	ldrh r3, [r4, #0x36]
	bl SailRampTrick__Func_2178DC4
	cmp r0, #0
	beq _02178BA8
_02178A4C:
	ldrb r0, [r8, #7]
	bic r0, r0, #2
	strb r0, [r8, #7]
	and r0, r0, #0xff
	orr r0, r0, #4
	strb r0, [r8, #7]
	ldrb r0, [r8, #0xa]
	cmp r0, #0x16
	bne _02178A80
	add r0, r8, #0x9c
	mov r1, #0x18
	bl AnimatorSprite__SetAnimation
	b _02178A94
_02178A80:
	add r0, r0, #0xa
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	add r0, r8, #0x9c
	bl AnimatorSprite__SetAnimation
_02178A94:
	mov r0, #0x2000
	str r0, [r8, #0xd4]
	ldrb r0, [sl, #0xee0]
	add r0, r0, #1
	strb r0, [sl, #0xee0]
	mov r0, #0xc
	strh r0, [r5, #0xe4]
	ldrb r0, [r8, #8]
	cmp r0, #0
	beq _02178B98
	ldrsh r1, [r8]
	ldrsh r2, [r8, #2]
	add r0, sp, #0x28
	mov r1, r1, lsl #0xc
	str r1, [sp, #0x28]
	mov r1, #0
	mov r2, r2, lsl #0xc
	str r1, [sp, #0x30]
	str r2, [sp, #0x2c]
	ldrb r2, [r8, #8]
	ldr r1, [sp, #0x24]
	strh r2, [r1, #0xd8]
	bl EffectSailTrick__Create
	mov r0, #0
	strh r0, [r5, #0xe4]
	ldr r0, [sp, #0x1c]
	mov r1, #0x32
	ldrsh r0, [r0]
	add r2, r0, #1
	ldr r0, [sp, #0x1c]
	strh r2, [r0]
	ldr r0, [sp, #0x24]
	ldrh r0, [r0, #0xc4]
	bl FX_DivS32
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	ldrb r0, [r8, #8]
	cmp r0, #3
	beq _02178B44
	cmp r0, #4
	movne r2, #0x7d0
	ldreq r2, _02178BC4 // =0x00001770
	b _02178B48
_02178B44:
	ldr r2, [sp, #0x20]
_02178B48:
	ldr r0, [sb, #0x1a8]
	mla r1, r2, r3, r0
	ldr r0, _02178BC8 // =0x05F5E0FF
	str r1, [sb, #0x1a8]
	cmp r1, r0
	strhi r0, [sb, #0x1a8]
	ldrh r1, [r4, #0x32]
	ldrsh r0, [r4, #0x30]
	sub r1, r1, #0x28
	mov r1, r1, lsl #0x10
	mov r1, r1, asr #0x10
	bl SailScoreBonus__CreateScreen
	ldr r0, [sp, #0x18]
	mov r1, #0x20000
	bl SailPlayer__GiveBoost
	mov r0, #0
	mov r1, #0xb
	mov r2, r0
	bl SailAudio__PlaySpatialSequence
	b _02178BA8
_02178B98:
	mov r0, #0
	mov r1, #0xa
	mov r2, r0
	bl SailAudio__PlaySpatialSequence
_02178BA8:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0xe
	blo _021787B8
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02178BC4: .word 0x00001770
_02178BC8: .word 0x05F5E0FF
	arm_func_end SailRampTrick__Func_217874C

	arm_func_start SailRampTrick__Func_2178BCC
SailRampTrick__Func_2178BCC: // 0x02178BCC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x28
	ldrb r2, [r1, #6]
	ldrb r3, [r1, #0xa]
	mov r8, #0x1e
	mov r2, r2, lsl #0x1c
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, asr #4
	mov r4, r2, lsl #1
	cmp r3, #0x16
	add r2, r4, #1
	ldr r3, _02178DC0 // =FX_SinCosTable_
	mov r2, r2, lsl #1
	ldrsh r7, [r3, r2]
	moveq r8, #0x100
	mov r2, r4, lsl #1
	rsb ip, r8, #0
	ldrsh r5, [r3, r2]
	smull r2, r6, ip, r7
	mov sb, #0x14
	moveq sb, #8
	adds r4, r2, #0x800
	adc lr, r6, #0
	smull r2, fp, sb, r5
	mov r6, r4, lsr #0xc
	adds sl, r2, #0x800
	smull r4, r2, ip, r5
	str r2, [sp, #0x20]
	adc r2, fp, #0
	adds ip, r4, #0x800
	mov r4, sl, lsr #0xc
	rsb r3, sb, #0
	smull sl, fp, r3, r7
	orr r4, r4, r2, lsl #20
	ldr r2, [sp, #0x20]
	orr r6, r6, lr, lsl #20
	adc r2, r2, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r2, lsl #20
	str fp, [sp, #0x10]
	mov r2, sl
	adds fp, r2, #0x800
	ldr r2, [sp, #0x10]
	str sl, [sp, #0x18]
	adc sl, r2, #0
	mov r2, fp, lsr #0xc
	orr r2, r2, sl, lsl #20
	mov sl, r7, asr #0x1f
	str sl, [sp]
	mov sl, sb, asr #0x1f
	str sl, [sp, #4]
	mov sl, r5, asr #0x1f
	str sl, [sp, #8]
	mov sl, r3, asr #0x1f
	str sl, [sp, #0xc]
	add sl, ip, r2
	ldrsh fp, [r1]
	add lr, r6, r4
	str sl, [sp, #0x1c]
	add sl, fp, lr
	smull lr, fp, r8, r7
	strh sl, [r0]
	str fp, [sp, #0x14]
	ldrsh sl, [r1, #2]
	ldr fp, [sp, #0x1c]
	add sl, sl, fp
	strh sl, [r0, #2]
	adds fp, lr, #0x800
	ldr sl, [sp, #0x14]
	mov fp, fp, lsr #0xc
	adc sl, sl, #0
	orr sl, fp, sl, lsl #20
	str sl, [sp, #0x24]
	add fp, sl, r4
	smull sl, r4, r8, r5
	ldrsh r8, [r1]
	add r8, r8, fp
	strh r8, [r0, #4]
	adds sl, sl, #0x800
	adc r8, r4, #0
	mov r4, sl, lsr #0xc
	orr r4, r4, r8, lsl #20
	add fp, r4, r2
	ldrsh sl, [r1, #2]
	umull r8, r2, r3, r5
	add sl, sl, fp
	ldr fp, [sp, #8]
	strh sl, [r0, #6]
	mla r2, r3, fp, r2
	ldr r3, [sp, #0xc]
	mla r2, r3, r5, r2
	adds r5, r8, #0x800
	mov r3, r5, lsr #0xc
	adc r2, r2, #0
	orr r3, r3, r2, lsl #20
	ldr r2, [sp, #0x24]
	ldrsh r5, [r1]
	add r6, r6, r3
	add r2, r2, r3
	add r5, r5, r6
	strh r5, [r0, #8]
	ldr r6, [sp]
	umull r8, r3, sb, r7
	mla r3, sb, r6, r3
	ldr r6, [sp, #4]
	ldrsh r5, [r1, #2]
	mla r3, r6, r7, r3
	adds r7, r8, #0x800
	adc r6, r3, #0
	mov r3, r7, lsr #0xc
	orr r3, r3, r6, lsl #20
	add r6, ip, r3
	add r3, r4, r3
	add r4, r5, r6
	strh r4, [r0, #0xa]
	ldrsh r4, [r1]
	add r2, r4, r2
	strh r2, [r0, #0xc]
	ldrsh r1, [r1, #2]
	add r1, r1, r3
	strh r1, [r0, #0xe]
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02178DC0: .word FX_SinCosTable_
	arm_func_end SailRampTrick__Func_2178BCC

	arm_func_start SailRampTrick__Func_2178DC4
SailRampTrick__Func_2178DC4: // 0x02178DC4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x10
	ldr r4, [sp, #0x30]
	ldr r6, [sp, #0x34]
	str r4, [sp]
	mov r5, r2
	str r6, [sp, #4]
	ldr r2, [sp, #0x38]
	mov r4, r3
	str r2, [sp, #8]
	ldr ip, [sp, #0x3c]
	ldr r2, [sp, #0x28]
	ldr r3, [sp, #0x2c]
	mov r7, r0
	mov r6, r1
	str ip, [sp, #0xc]
	bl SailRampTrick__Func_2178EF0
	cmp r0, #0
	addne sp, sp, #0x10
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [sp, #0x28]
	ldr r1, [sp, #0x2c]
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, [sp, #0x30]
	ldr ip, [sp, #0x34]
	str r0, [sp, #8]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	str ip, [sp, #0xc]
	bl SailRampTrick__Func_217902C
	cmp r0, #0
	addne sp, sp, #0x10
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [sp, #0x30]
	ldr r1, [sp, #0x34]
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, [sp, #0x38]
	ldr ip, [sp, #0x3c]
	str r0, [sp, #8]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	str ip, [sp, #0xc]
	bl SailRampTrick__Func_217902C
	cmp r0, #0
	addne sp, sp, #0x10
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [sp, #0x38]
	ldr r1, [sp, #0x3c]
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, [sp, #0x28]
	ldr ip, [sp, #0x2c]
	str r0, [sp, #8]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	str ip, [sp, #0xc]
	bl SailRampTrick__Func_217902C
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SailRampTrick__Func_2178DC4

	arm_func_start SailRampTrick__Func_2178EF0
SailRampTrick__Func_2178EF0: // 0x02178EF0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x10
	ldr r7, [sp, #0x38]
	mov r8, r2
	ldr r5, [sp, #0x40]
	ldr r6, [sp, #0x3c]
	mov fp, r3
	ldr r4, [sp, #0x44]
	sub sl, r8, r5
	sub r2, fp, r6
	mul r2, sl, r2
	sub sb, r8, r7
	sub r3, fp, r4
	mul r3, sb, r3
	cmp r2, r3
	mov sl, r0
	mov sb, r1
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	str sl, [sp]
	str sb, [sp, #4]
	str r5, [sp, #8]
	mov r0, r8
	mov r1, fp
	mov r2, r7
	mov r3, r6
	str r4, [sp, #0xc]
	bl SailRampTrick__Func_2178FE8
	cmp r0, #0
	addlt sp, sp, #0x10
	movlt r0, #0
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	str sl, [sp]
	str sb, [sp, #4]
	str r7, [sp, #8]
	mov r0, r8
	mov r1, fp
	mov r2, r5
	mov r3, r4
	str r6, [sp, #0xc]
	bl SailRampTrick__Func_2178FE8
	cmp r0, #0
	addlt sp, sp, #0x10
	movlt r0, #0
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	str sl, [sp]
	str sb, [sp, #4]
	str r8, [sp, #8]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	str fp, [sp, #0xc]
	bl SailRampTrick__Func_2178FE8
	cmp r0, #0
	movge r0, #1
	movlt r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end SailRampTrick__Func_2178EF0

	arm_func_start SailRampTrick__Func_2178FE8
SailRampTrick__Func_2178FE8: // 0x02178FE8
	stmdb sp!, {r3, r4, r5, lr}
	ldr lr, [sp, #0x10]
	ldr ip, [sp, #0x18]
	sub r5, r1, r3
	sub lr, r0, lr
	sub r3, r0, ip
	mul lr, r5, lr
	ldr r4, [sp, #0x14]
	ldr ip, [sp, #0x1c]
	mul r3, r5, r3
	sub r5, r0, r2
	sub r2, r4, r1
	sub r0, ip, r1
	mla r1, r5, r2, lr
	mla r0, r5, r0, r3
	mul r0, r1, r0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailRampTrick__Func_2178FE8

	arm_func_start SailRampTrick__Func_217902C
SailRampTrick__Func_217902C: // 0x0217902C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x10
	mov sl, r0
	mov r8, r2
	mov sb, r1
	mov r7, r3
	cmp sl, r8
	ldr r6, [sp, #0x38]
	ldr r5, [sp, #0x3c]
	ldr r4, [sp, #0x40]
	ldr fp, [sp, #0x44]
	blt _02179080
	cmp sl, r6
	cmplt sl, r4
	blt _02179074
	cmp r8, r6
	cmpgt r8, r4
	ble _021790A4
_02179074:
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
_02179080:
	cmp r8, r6
	cmplt r8, r4
	blt _02179098
	cmp sl, r6
	cmpgt sl, r4
	ble _021790A4
_02179098:
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
_021790A4:
	cmp sb, r7
	blt _021790D0
	cmp sb, r5
	cmplt sb, fp
	blt _021790C4
	cmp r7, r5
	cmpgt r7, fp
	ble _021790F4
_021790C4:
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
_021790D0:
	cmp r7, r5
	cmplt r7, fp
	blt _021790E8
	cmp sb, r5
	cmpgt sb, fp
	ble _021790F4
_021790E8:
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
_021790F4:
	str r6, [sp]
	str r5, [sp, #4]
	str r4, [sp, #8]
	mov r0, sl
	mov r1, sb
	mov r2, r8
	mov r3, r7
	str fp, [sp, #0xc]
	bl SailRampTrick__Func_2178FE8
	cmp r0, #0
	addge sp, sp, #0x10
	movge r0, #0
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	str sl, [sp]
	str sb, [sp, #4]
	str r8, [sp, #8]
	mov r0, r6
	mov r1, r5
	mov r2, r4
	mov r3, fp
	str r7, [sp, #0xc]
	bl SailRampTrick__Func_2178FE8
	cmp r0, #0
	movlt r0, #1
	movge r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end SailRampTrick__Func_217902C

	arm_func_start SailRampTrick__Func_2179168
SailRampTrick__Func_2179168: // 0x02179168
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x20
	ldr r1, _02179280 // =0x00020100
	mov r7, #0
	add r6, sp, #0x14
	mov r8, r0
	str r7, [r6]
	str r7, [r6, #4]
	str r7, [r6, #8]
	str r1, [sp, #0x10]
	add r5, sp, #0x10
	mov r4, r7
_02179198:
	add r0, r7, r7, lsl #4
	add r0, r8, r0, lsl #4
	ldrb r1, [r0, #7]
	tst r1, #1
	beq _02179264
	tst r1, #8
	bne _02179264
	ldrsh r2, [r0]
	ldr r1, [sp, #0x10]
	mov r2, r2, lsl #0xc
	str r2, [sp, #0x14]
	ldrsh r3, [r0, #2]
	bic r2, r1, #3
	mov r1, r3, lsl #0xc
	str r2, [sp, #0x10]
	str r1, [sp, #0x18]
	ldr r1, [r0, #0xd8]
	tst r1, #0x80
	orrne r1, r2, #1
	strne r1, [sp, #0x10]
	ldr r1, [r0, #0xd8]
	tst r1, #0x100
	ldrne r1, [sp, #0x10]
	orrne r1, r1, #2
	strne r1, [sp, #0x10]
	ldrh r1, [r0, #0xa8]
	cmp r1, #5
	blo _02179220
	cmp r1, #9
	bhi _02179220
	ldr r1, [sp, #0x10]
	orr r1, r1, #4
	str r1, [sp, #0x10]
	b _0217922C
_02179220:
	ldr r1, [sp, #0x10]
	bic r1, r1, #4
	str r1, [sp, #0x10]
_0217922C:
	ldrh r1, [r0, #0xa8]
	mov r2, r4
	mov r3, r4
	cmp r1, #0x17
	ldreq r1, [sp, #0x10]
	add r0, r0, #0xc
	orreq r1, r1, #4
	streq r1, [sp, #0x10]
	str r5, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	mov r1, r6
	str r4, [sp, #0xc]
	bl StageTask__Draw3DEx
_02179264:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0xe
	blo _02179198
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02179280: .word 0x00020100
	arm_func_end SailRampTrick__Func_2179168

	.rodata
	
_0218BC94: // 0x0218BC94
	.byte 0x10
	.byte 0x80
	.byte 0x7C
	.byte 0

	.byte 0x10
	.byte 0x80
	.byte 0x6C
	.byte 0

	.byte 0x20
	.byte 0x80
	.byte 0x5C
	.byte 0

	.byte 0x20
	.byte 0x80
	.byte 0x4C
	.byte 0

	.byte 0x30
	.byte 0x80
	.byte 0x3C
	.byte 0x11

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x18
	.byte 0x80
	.byte 0x3C
	.byte 0

	.byte 0x18
	.byte 0x80
	.byte 0x4C
	.byte 0

	.byte 0x28
	.byte 0x80
	.byte 0x5C
	.byte 0

	.byte 0x28
	.byte 0x80
	.byte 0x6C
	.byte 0

	.byte 0x38
	.byte 0x80
	.byte 0x7C
	.byte 0x12

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x11
	.byte 0x6A
	.byte 0x88
	.byte 0

	.byte 0x11
	.byte 0x72
	.byte 0x79
	.byte 0

	.byte 0x21
	.byte 0x7A
	.byte 0x69
	.byte 0

	.byte 0x21
	.byte 0x82
	.byte 0x59
	.byte 0

	.byte 0x31
	.byte 0x8A
	.byte 0x49
	.byte 0

	.byte 0x31
	.byte 0x90
	.byte 0x38
	.byte 0x11

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x1F
	.byte 0x90
	.byte 0x88
	.byte 0

	.byte 0x1F
	.byte 0x88
	.byte 0x79
	.byte 0

	.byte 0x2F
	.byte 0x80
	.byte 0x69
	.byte 0

	.byte 0x2F
	.byte 0x78
	.byte 0x59
	.byte 0

	.byte 0x3F
	.byte 0x70
	.byte 0x49
	.byte 0

	.byte 0x3F
	.byte 0x6A
	.byte 0x38
	.byte 0x11

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x19
	.byte 0x90
	.byte 0x38
	.byte 0

	.byte 0x19
	.byte 0x89
	.byte 0x47
	.byte 0

	.byte 0x29
	.byte 0x81
	.byte 0x57
	.byte 0

	.byte 0x29
	.byte 0x79
	.byte 0x67
	.byte 0

	.byte 0x39
	.byte 0x71
	.byte 0x77
	.byte 0

	.byte 0x39
	.byte 0x6A
	.byte 0x88
	.byte 0x12

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x17
	.byte 0x6A
	.byte 0x38
	.byte 0

	.byte 0x17
	.byte 0x71
	.byte 0x47
	.byte 0

	.byte 0x27
	.byte 0x79
	.byte 0x57
	.byte 0

	.byte 0x27
	.byte 0x81
	.byte 0x67
	.byte 0

	.byte 0x37
	.byte 0x89
	.byte 0x77
	.byte 0

	.byte 0x37
	.byte 0x90
	.byte 0x88
	.byte 0x12

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x14
	.byte 0x50
	.byte 0x50
	.byte 0

	.byte 0x14
	.byte 0x66
	.byte 0x56
	.byte 0

	.byte 0x24
	.byte 0x7A
	.byte 0x56
	.byte 0

	.byte 0x24
	.byte 0x8E
	.byte 0x56
	.byte 0

	.byte 0x34
	.byte 0xA2
	.byte 0x56
	.byte 0

	.byte 0x34
	.byte 0xB4
	.byte 0x50
	.byte 0x11

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x1C
	.byte 0xB4
	.byte 0x50
	.byte 0

	.byte 0x1C
	.byte 0x9E
	.byte 0x4B
	.byte 0

	.byte 0x2C
	.byte 0x8A
	.byte 0x4B
	.byte 0

	.byte 0x2C
	.byte 0x76
	.byte 0x4B
	.byte 0

	.byte 0x3C
	.byte 0x62
	.byte 0x4B
	.byte 0

	.byte 0x3C
	.byte 0x50
	.byte 0x50
	.byte 0x12

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x10
	.byte 0x64
	.byte 0x7C
	.byte 0

	.byte 0x10
	.byte 0x64
	.byte 0x6C
	.byte 0

	.byte 0x20
	.byte 0x64
	.byte 0x5C
	.byte 0

	.byte 0x20
	.byte 0x64
	.byte 0x4C
	.byte 0

	.byte 0x30
	.byte 0x64
	.byte 0x3C
	.byte 1

	.byte 0x18
	.byte 0x9C
	.byte 0x3C
	.byte 0x20

	.byte 0x18
	.byte 0x9C
	.byte 0x4C
	.byte 0

	.byte 0x28
	.byte 0x9C
	.byte 0x5C
	.byte 0

	.byte 0x28
	.byte 0x9C
	.byte 0x6C
	.byte 0

	.byte 0x38
	.byte 0x9C
	.byte 0x7C
	.byte 0x12

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x10
	.byte 0x9C
	.byte 0x7C
	.byte 0

	.byte 0x10
	.byte 0x9C
	.byte 0x6C
	.byte 0

	.byte 0x20
	.byte 0x9C
	.byte 0x5C
	.byte 0

	.byte 0x20
	.byte 0x9C
	.byte 0x4C
	.byte 0

	.byte 0x30
	.byte 0x9C
	.byte 0x3C
	.byte 1

	.byte 0x18
	.byte 0x64
	.byte 0x3C
	.byte 0x20

	.byte 0x18
	.byte 0x64
	.byte 0x4C
	.byte 0

	.byte 0x28
	.byte 0x64
	.byte 0x5C
	.byte 0

	.byte 0x28
	.byte 0x64
	.byte 0x6C
	.byte 0

	.byte 0x38
	.byte 0x64
	.byte 0x7C
	.byte 0x12

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x18
	.byte 0x64
	.byte 0x3C
	.byte 0

	.byte 0x18
	.byte 0x64
	.byte 0x4C
	.byte 0

	.byte 0x28
	.byte 0x64
	.byte 0x5C
	.byte 0

	.byte 0x28
	.byte 0x64
	.byte 0x6C
	.byte 0

	.byte 0x38
	.byte 0x64
	.byte 0x7C
	.byte 2

	.byte 0x10
	.byte 0x9C
	.byte 0x7C
	.byte 0x20

	.byte 0x10
	.byte 0x9C
	.byte 0x6C
	.byte 0

	.byte 0x20
	.byte 0x9C
	.byte 0x5C
	.byte 0

	.byte 0x20
	.byte 0x9C
	.byte 0x4C
	.byte 0

	.byte 0x30
	.byte 0x9C
	.byte 0x3C
	.byte 0x11

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x18
	.byte 0x9C
	.byte 0x3C
	.byte 0

	.byte 0x18
	.byte 0x9C
	.byte 0x4C
	.byte 0

	.byte 0x28
	.byte 0x9C
	.byte 0x5C
	.byte 0

	.byte 0x28
	.byte 0x9C
	.byte 0x6C
	.byte 0

	.byte 0x38
	.byte 0x9C
	.byte 0x7C
	.byte 2

	.byte 0x10
	.byte 0x64
	.byte 0x7C
	.byte 0x20

	.byte 0x10
	.byte 0x64
	.byte 0x6C
	.byte 0

	.byte 0x20
	.byte 0x64
	.byte 0x5C
	.byte 0

	.byte 0x20
	.byte 0x64
	.byte 0x4C
	.byte 0

	.byte 0x30
	.byte 0x64
	.byte 0x3C
	.byte 0x11

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x11
	.byte 0x42
	.byte 0x88
	.byte 0

	.byte 0x11
	.byte 0x4B
	.byte 0x79
	.byte 0

	.byte 0x21
	.byte 0x53
	.byte 0x69
	.byte 0

	.byte 0x21
	.byte 0x5B
	.byte 0x59
	.byte 0

	.byte 0x31
	.byte 0x62
	.byte 0x48
	.byte 1

	.byte 0x17
	.byte 0x9A
	.byte 0x48
	.byte 0x20

	.byte 0x17
	.byte 0xA2
	.byte 0x58
	.byte 0

	.byte 0x27
	.byte 0xAA
	.byte 0x68
	.byte 0

	.byte 0x27
	.byte 0xB2
	.byte 0x78
	.byte 0

	.byte 0x37
	.byte 0xB8
	.byte 0x88
	.byte 0x12

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x1F
	.byte 0xB8
	.byte 0x88
	.byte 0

	.byte 0x1F
	.byte 0xB0
	.byte 0x79
	.byte 0

	.byte 0x2F
	.byte 0xA8
	.byte 0x69
	.byte 0

	.byte 0x2F
	.byte 0xA0
	.byte 0x59
	.byte 0

	.byte 0x3F
	.byte 0x9A
	.byte 0x48
	.byte 1

	.byte 0x19
	.byte 0x62
	.byte 0x48
	.byte 0x20

	.byte 0x19
	.byte 0x5A
	.byte 0x58
	.byte 0

	.byte 0x29
	.byte 0x52
	.byte 0x68
	.byte 0

	.byte 0x29
	.byte 0x4A
	.byte 0x78
	.byte 0

	.byte 0x39
	.byte 0x42
	.byte 0x88
	.byte 0x12

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x17
	.byte 0x42
	.byte 0x38
	.byte 0

	.byte 0x17
	.byte 0x4B
	.byte 0x47
	.byte 0

	.byte 0x27
	.byte 0x53
	.byte 0x57
	.byte 0

	.byte 0x27
	.byte 0x5B
	.byte 0x67
	.byte 0

	.byte 0x37
	.byte 0x62
	.byte 0x78
	.byte 2

	.byte 0x11
	.byte 0x9A
	.byte 0x78
	.byte 0x20

	.byte 0x11
	.byte 0xA3
	.byte 0x68
	.byte 0

	.byte 0x21
	.byte 0xAB
	.byte 0x58
	.byte 0

	.byte 0x21
	.byte 0xB3
	.byte 0x48
	.byte 0

	.byte 0x31
	.byte 0xB8
	.byte 0x38
	.byte 0x11

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x19
	.byte 0xB8
	.byte 0x38
	.byte 0

	.byte 0x19
	.byte 0xB0
	.byte 0x48
	.byte 0

	.byte 0x29
	.byte 0xA8
	.byte 0x58
	.byte 0

	.byte 0x29
	.byte 0xA0
	.byte 0x68
	.byte 0

	.byte 0x39
	.byte 0x9A
	.byte 0x78
	.byte 2

	.byte 0x1F
	.byte 0x62
	.byte 0x78
	.byte 0x20

	.byte 0x1F
	.byte 0x59
	.byte 0x68
	.byte 0

	.byte 0x2F
	.byte 0x51
	.byte 0x58
	.byte 0

	.byte 0x2F
	.byte 0x49
	.byte 0x48
	.byte 0

	.byte 0x3F
	.byte 0x42
	.byte 0x38
	.byte 0x11

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x10
	.byte 0x3C
	.byte 0x5C
	.byte 0

	.byte 0x11
	.byte 0x40
	.byte 0x48
	.byte 0

	.byte 0x22
	.byte 0x50
	.byte 0x36
	.byte 0

	.byte 0x23
	.byte 0x68
	.byte 0x2C
	.byte 0

	.byte 0x34
	.byte 0x84
	.byte 0x2A
	.byte 0

	.byte 0x35
	.byte 0xA0
	.byte 0x25
	.byte 0

	.byte 0x46
	.byte 0xB8
	.byte 0x3C
	.byte 0x13

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x10
	.byte 0xC4
	.byte 0x5C
	.byte 0

	.byte 0x1F
	.byte 0xC0
	.byte 0x48
	.byte 0

	.byte 0x2E
	.byte 0xAE
	.byte 0x36
	.byte 0

	.byte 0x2D
	.byte 0x98
	.byte 0x2C
	.byte 0

	.byte 0x3C
	.byte 0x7A
	.byte 0x1F
	.byte 0

	.byte 0x3B
	.byte 0x60
	.byte 0x25
	.byte 0

	.byte 0x4A
	.byte 0x48
	.byte 0x3C
	.byte 0x14

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x10
	.byte 0x80
	.byte 0x87
	.byte 0

	.byte 0x10
	.byte 0x80
	.byte 0x73
	.byte 0

	.byte 0x21
	.byte 0x84
	.byte 0x5C
	.byte 0

	.byte 0x22
	.byte 0x8C
	.byte 0x48
	.byte 0

	.byte 0x33
	.byte 0xA0
	.byte 0x3A
	.byte 0

	.byte 0x34
	.byte 0xB6
	.byte 0x32
	.byte 0x13

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x10
	.byte 0x80
	.byte 0x87
	.byte 0

	.byte 0x10
	.byte 0x80
	.byte 0x73
	.byte 0

	.byte 0x2F
	.byte 0x7C
	.byte 0x5C
	.byte 0

	.byte 0x2E
	.byte 0x74
	.byte 0x48
	.byte 0

	.byte 0x3D
	.byte 0x60
	.byte 0x3A
	.byte 0

	.byte 0x3C
	.byte 0x4A
	.byte 0x32
	.byte 0x13

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x11
	.byte 0x82
	.byte 0x88
	.byte 0

	.byte 0x11
	.byte 0x8B
	.byte 0x78
	.byte 0

	.byte 0x21
	.byte 0x93
	.byte 0x68
	.byte 0

	.byte 0x21
	.byte 0x9A
	.byte 0x58
	.byte 1

	.byte 0x1E
	.byte 0xA6
	.byte 0x36
	.byte 0x20

	.byte 0x1D
	.byte 0x90
	.byte 0x2F
	.byte 0

	.byte 0x2C
	.byte 0x77
	.byte 0x21
	.byte 0

	.byte 0x2B
	.byte 0x5E
	.byte 0x24
	.byte 0

	.byte 0x3A
	.byte 0x48
	.byte 0x38
	.byte 0x13

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x1F
	.byte 0x72
	.byte 0x88
	.byte 0

	.byte 0x1F
	.byte 0x69
	.byte 0x78
	.byte 0

	.byte 0x2F
	.byte 0x61
	.byte 0x68
	.byte 0

	.byte 0x2F
	.byte 0x5A
	.byte 0x58
	.byte 1

	.byte 0x32
	.byte 0x5B
	.byte 0x36
	.byte 0x20

	.byte 0x43
	.byte 0x72
	.byte 0x2F
	.byte 0

	.byte 0x54
	.byte 0x8A
	.byte 0x2C
	.byte 0

	.byte 0x65
	.byte 0xA4
	.byte 0x24
	.byte 0

	.byte 0x76
	.byte 0xB8
	.byte 0x38
	.byte 0x13

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x10
	.byte 0x4E
	.byte 0x87
	.byte 0

	.byte 0x10
	.byte 0x4E
	.byte 0x73
	.byte 0

	.byte 0x21
	.byte 0x52
	.byte 0x5C
	.byte 0

	.byte 0x22
	.byte 0x5A
	.byte 0x48
	.byte 0

	.byte 0x33
	.byte 0x6E
	.byte 0x3A
	.byte 0

	.byte 0x34
	.byte 0x84
	.byte 0x32
	.byte 3

	.byte 0x18
	.byte 0xAA
	.byte 0x50
	.byte 0x20

	.byte 0x18
	.byte 0xAA
	.byte 0x60
	.byte 0

	.byte 0x28
	.byte 0xAA
	.byte 0x70
	.byte 0

	.byte 0x28
	.byte 0xAA
	.byte 0x80
	.byte 0

	.byte 0x38
	.byte 0xAA
	.byte 0x90
	.byte 0x12

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x10
	.byte 0xB2
	.byte 0x87
	.byte 0

	.byte 0x10
	.byte 0xB2
	.byte 0x73
	.byte 0

	.byte 0x2F
	.byte 0xAE
	.byte 0x5C
	.byte 0

	.byte 0x2E
	.byte 0xA6
	.byte 0x48
	.byte 0

	.byte 0x3D
	.byte 0x92
	.byte 0x3A
	.byte 0

	.byte 0x3C
	.byte 0x7C
	.byte 0x32
	.byte 3

	.byte 0x18
	.byte 0x56
	.byte 0x50
	.byte 0x20

	.byte 0x18
	.byte 0x56
	.byte 0x60
	.byte 0

	.byte 0x28
	.byte 0x56
	.byte 0x70
	.byte 0

	.byte 0x28
	.byte 0x56
	.byte 0x80
	.byte 0

	.byte 0x38
	.byte 0x56
	.byte 0x90
	.byte 0x12

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x10
	.byte 0x30
	.byte 0x87
	.byte 0

	.byte 0x10
	.byte 0x30
	.byte 0x73
	.byte 0

	.byte 0x21
	.byte 0x34
	.byte 0x5C
	.byte 0

	.byte 0x22
	.byte 0x3C
	.byte 0x4D
	.byte 0

	.byte 0x33
	.byte 0x50
	.byte 0x3F
	.byte 0

	.byte 0x34
	.byte 0x66
	.byte 0x38
	.byte 3

	.byte 0x14
	.byte 0x9A
	.byte 0x38
	.byte 0x20

	.byte 0x15
	.byte 0xB0
	.byte 0x3A
	.byte 0

	.byte 0x26
	.byte 0xC4
	.byte 0x48
	.byte 0

	.byte 0x27
	.byte 0xCC
	.byte 0x5C
	.byte 0

	.byte 0x38
	.byte 0xD0
	.byte 0x73
	.byte 0

	.byte 0x38
	.byte 0xD0
	.byte 0x87
	.byte 0x13

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x10
	.byte 0xD0
	.byte 0x87
	.byte 0

	.byte 0x10
	.byte 0xD0
	.byte 0x73
	.byte 0

	.byte 0x2F
	.byte 0xCC
	.byte 0x5C
	.byte 0

	.byte 0x2E
	.byte 0xC4
	.byte 0x48
	.byte 0

	.byte 0x3D
	.byte 0xB0
	.byte 0x3F
	.byte 0

	.byte 0x3C
	.byte 0x9A
	.byte 0x38
	.byte 3

	.byte 0x1C
	.byte 0x66
	.byte 0x38
	.byte 0x20

	.byte 0x1B
	.byte 0x50
	.byte 0x3A
	.byte 0

	.byte 0x2A
	.byte 0x3C
	.byte 0x48
	.byte 0

	.byte 0x29
	.byte 0x34
	.byte 0x5C
	.byte 0

	.byte 0x38
	.byte 0x30
	.byte 0x73
	.byte 0

	.byte 0x38
	.byte 0x30
	.byte 0x87
	.byte 0x13

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x10
	.byte 0x34
	.byte 0x5C
	.byte 0

	.byte 0x11
	.byte 0x40
	.byte 0x48
	.byte 0

	.byte 0x22
	.byte 0x50
	.byte 0x36
	.byte 0

	.byte 0x23
	.byte 0x68
	.byte 0x2C
	.byte 0

	.byte 0x34
	.byte 0x84
	.byte 0x2A
	.byte 0

	.byte 0x35
	.byte 0xA0
	.byte 0x25
	.byte 0

	.byte 0x46
	.byte 0xB8
	.byte 0x3C
	.byte 3

	.byte 0x18
	.byte 0xC4
	.byte 0x6C
	.byte 0x20

	.byte 0x19
	.byte 0xBA
	.byte 0x80
	.byte 0

	.byte 0x2A
	.byte 0xAA
	.byte 0x92
	.byte 0

	.byte 0x2B
	.byte 0x94
	.byte 0x9C
	.byte 0

	.byte 0x3C
	.byte 0x78
	.byte 0x9E
	.byte 0

	.byte 0x3D
	.byte 0x5C
	.byte 0xA3
	.byte 0

	.byte 0x4E
	.byte 0x44
	.byte 0x8C
	.byte 0x13

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x10
	.byte 0xCC
	.byte 0x5C
	.byte 0

	.byte 0x1F
	.byte 0xC0
	.byte 0x48
	.byte 0

	.byte 0x2E
	.byte 0xAE
	.byte 0x36
	.byte 0

	.byte 0x2D
	.byte 0x98
	.byte 0x2C
	.byte 0

	.byte 0x3C
	.byte 0x7A
	.byte 0x1F
	.byte 0

	.byte 0x3B
	.byte 0x60
	.byte 0x25
	.byte 0

	.byte 0x4A
	.byte 0x48
	.byte 0x3C
	.byte 3

	.byte 0x18
	.byte 0x3C
	.byte 0x6C
	.byte 0x20

	.byte 0x17
	.byte 0x48
	.byte 0x80
	.byte 0

	.byte 0x26
	.byte 0x58
	.byte 0x92
	.byte 0

	.byte 0x25
	.byte 0x6E
	.byte 0x9C
	.byte 0

	.byte 0x34
	.byte 0x8A
	.byte 0xA9
	.byte 0

	.byte 0x33
	.byte 0xA6
	.byte 0xA3
	.byte 0

	.byte 0x42
	.byte 0xBE
	.byte 0x8C
	.byte 0x13

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x1E
	.byte 0x4C
	.byte 0x88
	.byte 0

	.byte 0x2F
	.byte 0x3C
	.byte 0x74
	.byte 0

	.byte 0x20
	.byte 0x38
	.byte 0x60
	.byte 0

	.byte 0x31
	.byte 0x40
	.byte 0x48
	.byte 0

	.byte 0x32
	.byte 0x50
	.byte 0x36
	.byte 0

	.byte 0x43
	.byte 0x68
	.byte 0x2C
	.byte 0

	.byte 0x44
	.byte 0x84
	.byte 0x2A
	.byte 0

	.byte 0x55
	.byte 0xA0
	.byte 0x25
	.byte 0

	.byte 0x56
	.byte 0xB8
	.byte 0x31
	.byte 0

	.byte 0x67
	.byte 0xC8
	.byte 0x45
	.byte 0

	.byte 0x68
	.byte 0xCC
	.byte 0x5D
	.byte 0

	.byte 0x79
	.byte 0xC4
	.byte 0x75
	.byte 0x14

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0x12
	.byte 0xB8
	.byte 0x88
	.byte 0

	.byte 0x21
	.byte 0xC8
	.byte 0x74
	.byte 0

	.byte 0x20
	.byte 0xCC
	.byte 0x60
	.byte 0

	.byte 0x3F
	.byte 0xC4
	.byte 0x48
	.byte 0

	.byte 0x3E
	.byte 0xB4
	.byte 0x36
	.byte 0

	.byte 0x4D
	.byte 0x9C
	.byte 0x2C
	.byte 0

	.byte 0x4C
	.byte 0x80
	.byte 0x1F
	.byte 0

	.byte 0x5B
	.byte 0x64
	.byte 0x25
	.byte 0

	.byte 0x5A
	.byte 0x4C
	.byte 0x31
	.byte 0

	.byte 0x69
	.byte 0x3C
	.byte 0x45
	.byte 0

	.byte 0x68
	.byte 0x38
	.byte 0x5D
	.byte 0

	.byte 0x77
	.byte 0x40
	.byte 0x75
	.byte 0x14

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.byte 0
	.byte 0
	.byte 0
	.byte 0

	.data

aSbTrickBac_0: // 0x0218D56C
	.asciz "sb_trick.bac"
    .align 4