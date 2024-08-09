	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Object54__Create
Object54__Create: // 0x0216E0C8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, _0216E38C // =0x000010F6
	mov r7, r0
	str r3, [sp]
	mov r0, #2
	mov r6, r1
	mov r4, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r5, _0216E390 // =0x000004CC
	ldr r0, _0216E394 // =StageTask_Main
	ldr r1, _0216E398 // =Winch__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r5
	bl GetTaskWork_
	ldr r2, _0216E390 // =0x000004CC
	mov r5, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r5
	mov r1, r7
	mov r2, r6
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r1, [r5, #0x1c]
	mov r0, #0xb3
	orr r1, r1, #0x2100
	str r1, [r5, #0x1c]
	ldr r1, [r5, #0x20]
	orr r1, r1, #0x10000
	str r1, [r5, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0216E39C // =gameArchiveStage
	mov r1, #0x20
	ldr r2, [r0]
	mov r0, r5
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r5, #0x168
	ldr r2, _0216E3A0 // =aActAcGmkWinchB
	bl ObjObjectAction2dBACLoad
	ldr r1, [r5, #0x1a4]
	mov r0, r5
	orr r1, r1, #0x200
	str r1, [r5, #0x1a4]
	mov r1, #0
	mov r2, #0x33
	bl ObjActionAllocSpritePalette
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r5
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimation
	add r6, r5, #0x364
	mov r0, #0xb3
	bl GetObjectFileWork
	mov r3, r0
	ldr r1, _0216E39C // =gameArchiveStage
	mov r0, r6
	ldr r2, [r1]
	ldr r1, _0216E3A0 // =aActAcGmkWinchB
	str r2, [sp]
	mov r2, #0xc
	bl ObjAction2dBACLoad
	ldr r0, [r6, #0x3c]
	mov r1, #1
	orr r0, r0, #0x200
	str r0, [r6, #0x3c]
	ldr r0, [r6, #0x14]
	mov r2, #0x33
	bl ObjDrawAllocSpritePalette
	mov r4, r0
	strh r4, [r6, #0x50]
	ldrh r0, [r6, #0x50]
	strh r0, [r6, #0x92]
	ldrh r2, [r6, #0x92]
	mov r0, r6
	mov r1, #1
	strh r2, [r6, #0x90]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r6
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r6
	mov r1, #2
	bl StageTask__SetOAMPriority
	add r0, r5, #8
	add r6, r0, #0x400
	mov r0, #0xb3
	bl GetObjectFileWork
	ldr r1, _0216E39C // =gameArchiveStage
	mov r3, r0
	ldr r2, [r1]
	ldr r1, _0216E3A0 // =aActAcGmkWinchB
	str r2, [sp]
	mov r0, r6
	mov r2, #1
	bl ObjAction2dBACLoad
	strh r4, [r6, #0x50]
	ldrh r2, [r6, #0x50]
	mov r0, r6
	mov r1, #2
	strh r2, [r6, #0x92]
	strh r2, [r6, #0x90]
	ldr r2, [r6, #0x3c]
	orr r2, r2, #0x10
	str r2, [r6, #0x3c]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r6
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r6
	mov r1, #2
	bl StageTask__SetOAMPriority
	ldrh r0, [r7, #4]
	mov r4, #0x50
	tst r0, #1
	movne r0, #0x3e
	mvneq r0, #0x3d
	sub r1, r0, #0x10
	add r0, r0, #0x10
	mov r2, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	str r5, [r5, #0x234]
	mov r3, r2, asr #0x10
	add r0, r5, #0x218
	mov r1, r1, asr #0x10
	mov r2, #0x30
	str r4, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r5, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _0216E3A4 // =0x0000FFFE
	add r0, r5, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _0216E3A8 // =ovl00_216E964
	mov r0, #0x3c000
	str r1, [r5, #0x23c]
	ldr r1, [r5, #0x230]
	rsb r0, r0, #0
	orr r1, r1, #0x400
	str r1, [r5, #0x230]
	str r0, [r5, #0x4ac]
	mov r0, #0x10000
	str r0, [r5, #0x4b0]
	ldrh r0, [r7, #4]
	mov r1, #0x20000
	tst r0, #1
	ldrne r0, [r5, #0x4ac]
	rsbne r0, r0, #0
	strne r0, [r5, #0x4ac]
	ldr r0, _0216E3AC // =ovl00_216E710
	str r1, [r5, #0x4c0]
	str r0, [r5, #0xfc]
	bl AllocSndHandle
	str r0, [r5, #0x138]
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216E38C: .word 0x000010F6
_0216E390: .word 0x000004CC
_0216E394: .word StageTask_Main
_0216E398: .word Winch__Destructor
_0216E39C: .word gameArchiveStage
_0216E3A0: .word aActAcGmkWinchB
_0216E3A4: .word 0x0000FFFE
_0216E3A8: .word ovl00_216E964
_0216E3AC: .word ovl00_216E710
	arm_func_end Object54__Create

	arm_func_start Winch__Destructor
Winch__Destructor: // 0x0216E3B0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x300
	ldrh r0, [r0, #0xf4]
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	mov r0, #0xb3
	bl GetObjectFileWork
	add r1, r4, #0x364
	bl ObjAction2dBACRelease
	mov r0, #0xb3
	bl GetObjectFileWork
	add r1, r4, #8
	add r1, r1, #0x400
	bl ObjAction2dBACRelease
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Winch__Destructor

	arm_func_start ovl00_216E400
ovl00_216E400: // 0x0216E400
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x354]
	tst r1, #1
	bne _0216E468
	ldr r0, [r4, #0x35c]
	ldr r0, [r0, #0x6d8]
	cmp r0, r4
	beq _0216E468
	orr r0, r1, #1
	str r0, [r4, #0x354]
	ldr r0, [r4, #0x4bc]
	mov r1, #0
	rsb r0, r0, #0
	mov r0, r0, asr #2
	str r0, [r4, #0x4c4]
	ldr r0, [r4, #0x138]
	bl NNS_SndPlayerStopSeq
	mov ip, #0x5c
	sub r1, ip, #0x5d
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
_0216E468:
	ldr r0, [r4, #0x4c4]
	cmp r0, #0
	ble _0216E4E8
	add r1, r4, #0x400
	ldrh r2, [r1, #0xca]
	mov r0, r0, lsl #0xa
	add r0, r2, r0, lsr #16
	strh r0, [r1, #0xca]
	ldr r1, [r4, #0x4c0]
	ldr r0, [r4, #0x4c4]
	add r0, r1, r0
	str r0, [r4, #0x4c0]
	ldr r0, [r4, #0x4c4]
	sub r0, r0, r0, asr #5
	str r0, [r4, #0x4c4]
	ldr r1, [r4, #0x4b8]
	ldr r0, [r4, #0x4c0]
	cmp r0, r1
	blt _0216E4D4
	str r1, [r4, #0x4c0]
	mov r0, #0
	str r0, [r4, #0x4c4]
	ldr r0, [r4, #0x4c0]
	cmp r0, #0xa0000
	movge r0, #0x10000
	strge r0, [r4, #4]
	b _0216E5C0
_0216E4D4:
	ldr r0, [r4, #0x4c4]
	cmp r0, #0x1000
	movlt r0, #0
	strlt r0, [r4, #0x4c4]
	b _0216E5C0
_0216E4E8:
	bge _0216E574
	add r1, r4, #0x400
	ldrh r2, [r1, #0xca]
	mov r0, r0, lsl #0xa
	add r0, r2, r0, lsr #16
	strh r0, [r1, #0xca]
	ldr r1, [r4, #0x4c0]
	ldr r0, [r4, #0x4c4]
	add r0, r1, r0
	str r0, [r4, #0x4c0]
	ldr r0, [r4, #0x4c4]
	add r0, r0, r0, asr #4
	str r0, [r4, #0x4c4]
	ldr r1, [r4, #0x4bc]
	rsb r0, r0, #0
	cmp r0, r1
	rsbgt r0, r1, #0
	strgt r0, [r4, #0x4c4]
	ldr r0, [r4, #0x4c0]
	cmp r0, #0
	bgt _0216E5C0
	mov r1, #0
	ldr r0, _0216E5F4 // =ovl00_216E5F8
	str r1, [r4, #0x4c0]
	str r0, [r4, #0xf4]
	str r1, [r4, #0x2c]
	str r1, [r4, #0x28]
	ldr r0, [r4, #0x24]
	orr r0, r0, #1
	str r0, [r4, #0x24]
	str r1, [r4, #0x98]
	ldr r0, [r4, #0x4bc]
	rsb r0, r0, #0
	str r0, [r4, #0x9c]
	b _0216E5C0
_0216E574:
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0x10
	blt _0216E5C0
	ldr r0, [r4, #0x4bc]
	mov r1, #0
	rsb r0, r0, #0
	mov r0, r0, asr #2
	str r0, [r4, #0x4c4]
	ldr r0, [r4, #0x138]
	bl NNS_SndPlayerStopSeq
	mov ip, #0x5c
	sub r1, ip, #0x5d
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
_0216E5C0:
	ldr r1, [r4, #0x44]
	ldr r0, [r4, #0x4ac]
	add r0, r1, r0
	str r0, [r4, #0x8c]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x4b0]
	ldr r2, [r4, #0x4c0]
	add r0, r1, r0
	add r0, r2, r0
	add r0, r0, #0x1a000
	str r0, [r4, #0x90]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E5F4: .word ovl00_216E5F8
	arm_func_end ovl00_216E400

	arm_func_start ovl00_216E5F8
ovl00_216E5F8: // 0x0216E5F8
	ldr r1, [r0, #0x28]
	cmp r1, #0
	beq _0216E618
	cmp r1, #1
	beq _0216E664
	cmp r1, #2
	beq _0216E6A4
	bx lr
_0216E618:
	add r2, r0, #0x400
	ldrh r1, [r2, #0xc8]
	add r1, r1, #0x400
	strh r1, [r2, #0xc8]
	ldr r1, [r0, #0x4c0]
	sub r1, r1, #0x1800
	str r1, [r0, #0x4c0]
	ldr r1, [r0, #0x4c4]
	ldrh r3, [r2, #0xca]
	mov r1, r1, lsl #0xa
	add r1, r3, r1, lsr #16
	strh r1, [r2, #0xca]
	ldrh r1, [r2, #0xc8]
	cmp r1, #0x1000
	bxlo lr
	ldr r1, [r0, #0x28]
	add r1, r1, #1
	str r1, [r0, #0x28]
	bx lr
_0216E664:
	ldr r1, [r0, #0x2c]
	add r2, r0, #0x400
	add r1, r1, #1
	str r1, [r0, #0x2c]
	ldr r1, [r0, #0x4c4]
	ldrh r3, [r2, #0xca]
	mov r1, r1, lsl #0xa
	add r1, r3, r1, lsr #16
	strh r1, [r2, #0xca]
	ldr r1, [r0, #0x2c]
	cmp r1, #0x18
	bxlt lr
	ldr r1, [r0, #0x28]
	add r1, r1, #1
	str r1, [r0, #0x28]
	bx lr
_0216E6A4:
	add r1, r0, #0x400
	ldrh r2, [r1, #0xc8]
	sub r2, r2, #0x100
	strh r2, [r1, #0xc8]
	ldr r2, [r0, #0x4c0]
	add r2, r2, #0xc00
	str r2, [r0, #0x4c0]
	ldrh r2, [r1, #0xca]
	add r2, r2, #0x60
	strh r2, [r1, #0xca]
	ldrh r2, [r1, #0xc8]
	cmp r2, #0x8000
	movhi r2, #0
	strhih r2, [r1, #0xc8]
	ldr r1, [r0, #0x4c0]
	cmp r1, #0x20000
	bxlt lr
	add r1, r0, #0x400
	mov r2, #0
	strh r2, [r1, #0xc8]
	mov r1, #0x20000
	str r1, [r0, #0x4c0]
	str r2, [r0, #0xf4]
	ldr r1, [r0, #0x18]
	bic r1, r1, #2
	str r1, [r0, #0x18]
	bx lr
	arm_func_end ovl00_216E5F8

	arm_func_start ovl00_216E710
ovl00_216E710: // 0x0216E710
	stmdb sp!, {r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #0x2c
	bl GetCurrentTaskWork_
	mov r1, #0
	mov r6, r0
	strh r1, [sp, #0x16]
	strh r1, [sp, #0x14]
	ldr r0, [r6, #0x340]
	mov r5, #0
	ldrh r0, [r0, #4]
	add r4, sp, #0xc
	add sb, sp, #0x1c
	tst r0, #1
	add r0, r6, #0x400
	ldrneh r0, [r0, #0xca]
	mov r8, r5
	add r7, sp, #0x14
	strneh r0, [sp, #0x18]
	ldreqh r0, [r0, #0xca]
	rsbeq r0, r0, #0
	streqh r0, [sp, #0x18]
	ldr r0, _0216E960 // =_0218859C
	ldrh r3, [r0]
	ldrh r2, [r0, #2]
	ldrh r1, [r0, #4]
	ldrh r0, [r0, #6]
	strh r3, [sp, #0xc]
	strh r2, [sp, #0xe]
	strh r1, [sp, #0x10]
	strh r0, [sp, #0x12]
_0216E788:
	mov r0, r5, lsl #1
	ldrh r0, [r4, r0]
	ldr r1, [r6, #0x20]
	mov r2, r7
	orr r0, r1, r0
	str r0, [sp, #0x1c]
	str sb, [sp]
	str r8, [sp, #4]
	str r8, [sp, #8]
	ldr r0, [r6, #0x128]
	mov r3, r8
	add r1, r6, #0x44
	bl StageTask__Draw2DEx
	add r5, r5, #1
	cmp r5, #4
	blt _0216E788
	ldr r0, [r6, #0x340]
	ldrh r0, [r0, #4]
	tst r0, #1
	add r0, r6, #0x400
	ldreqh r0, [r0, #0xc8]
	streqh r0, [sp, #0x18]
	beq _0216E7F0
	ldrh r0, [r0, #0xc8]
	rsb r0, r0, #0
	strh r0, [sp, #0x18]
_0216E7F0:
	mov r1, #0x10000
	str r1, [sp, #0x1c]
	ldr r0, [r6, #0x340]
	mov r3, #0
	ldrh r0, [r0, #4]
	tst r0, #1
	orrne r0, r1, #1
	strne r0, [sp, #0x1c]
	ldr r1, [r6, #0x44]
	ldr r0, [r6, #0x4ac]
	ldr r2, [r6, #0x50]
	add r0, r1, r0
	add r0, r2, r0
	str r0, [sp, #0x20]
	ldr r1, [r6, #0x48]
	ldr r0, [r6, #0x4b0]
	ldr r2, [r6, #0x54]
	add r0, r1, r0
	ldr r1, [r6, #0x4c0]
	add r0, r2, r0
	add r0, r1, r0
	str r0, [sp, #0x24]
	ldr r2, [r6, #0x4c]
	ldr r1, [r6, #0x4b4]
	add r0, sp, #0x1c
	add r1, r2, r1
	str r1, [sp, #0x28]
	str r0, [sp]
	str r3, [sp, #4]
	add r1, sp, #0x20
	add r2, sp, #0x14
	str r3, [sp, #8]
	add r0, r6, #0x364
	bl StageTask__Draw2DEx
	ldr r0, [r6, #0x4c0]
	cmp r0, #0
	addle sp, sp, #0x2c
	ldmleia sp!, {r4, r5, r6, r7, r8, sb, pc}
	ldr r0, [sp, #0x1c]
	add r5, r6, #8
	orr r0, r0, #0x100
	orr r0, r0, #0x10000
	str r0, [sp, #0x1c]
	ldr r7, [r6, #0x4c0]
	mov r4, r7, asr #0xc
	ands r3, r4, #7
	beq _0216E8F0
	ldr r1, [r6, #0x48]
	ldr r0, [r6, #0x4b0]
	ldr r2, [r6, #0x54]
	add r0, r1, r0
	add r0, r2, r0
	add r0, r7, r0
	sub r0, r0, #0x6000
	sub r1, r0, r3, lsl #12
	mov r2, #0
	str r1, [sp, #0x24]
	add r0, sp, #0x1c
	stmia sp, {r0, r2}
	add r1, sp, #0x20
	mov r3, r2
	add r0, r5, #0x400
	str r2, [sp, #8]
	bl StageTask__Draw2DEx
_0216E8F0:
	ldr r1, [r6, #0x48]
	ldr r0, [r6, #0x4b0]
	ldr r2, [r6, #0x54]
	add r0, r1, r0
	add r0, r2, r0
	sub r0, r0, #0x6000
	str r0, [sp, #0x24]
	movs r4, r4, asr #3
	addeq sp, sp, #0x2c
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, pc}
	add r8, sp, #0x1c
	mov r7, #0
	add r6, sp, #0x20
_0216E924:
	str r8, [sp]
	str r7, [sp, #4]
	mov r1, r6
	mov r2, r7
	mov r3, r7
	str r7, [sp, #8]
	add r0, r5, #0x400
	bl StageTask__Draw2DEx
	ldr r0, [sp, #0x24]
	subs r4, r4, #1
	add r0, r0, #0x8000
	str r0, [sp, #0x24]
	bne _0216E924
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_0216E960: .word _0218859C
	arm_func_end ovl00_216E710

	arm_func_start ovl00_216E964
ovl00_216E964: // 0x0216E964
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r1, #0x1c]
	ldr r4, [r0, #0x1c]
	cmp r5, #0
	cmpne r4, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r4]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	str r4, [r5, #0x35c]
	ldr r0, [r5, #0x18]
	orr r0, r0, #2
	str r0, [r5, #0x18]
	ldr r0, [r4, #0x1c]
	tst r0, #1
	beq _0216E9C0
	ldr r0, [r4, #0xc8]
	cmp r0, #0
	rsblt r0, r0, #0
	b _0216E9DC
_0216E9C0:
	ldr r0, [r4, #0x9c]
	ldr r1, [r4, #0x98]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	add r0, r1, r0
_0216E9DC:
	str r0, [r5, #0x4bc]
	ldr r0, [r5, #0x4bc]
	cmp r0, #0x4000
	movlt r0, #0x4000
	strlt r0, [r5, #0x4bc]
	blt _0216EA00
	cmp r0, #0xc000
	movgt r0, #0xc000
	strgt r0, [r5, #0x4bc]
_0216EA00:
	ldr r0, [r5, #0x4bc]
	mov r0, r0, lsl #4
	str r0, [r5, #0x4b8]
	cmp r0, #0xa0000
	movlt r0, #0xa0000
	strlt r0, [r5, #0x4b8]
	blt _0216EA28
	cmp r0, #0x120000
	movgt r0, #0x120000
	strgt r0, [r5, #0x4b8]
_0216EA28:
	add r0, r5, #0x400
	mov r2, #0
	strh r2, [r0, #0xc8]
	ldr r1, [r5, #0x4bc]
	mov r0, #0x20000
	str r1, [r5, #0x4c4]
	str r0, [r5, #0x4c0]
	str r2, [r5, #0x24]
	str r2, [r5, #0x2c]
	ldr r1, [r5, #0x354]
	ldr r0, _0216EAC0 // =ovl00_216E400
	bic r1, r1, #1
	str r1, [r5, #0x354]
	str r0, [r5, #0xf4]
	ldr r0, [r5, #0x340]
	mov r1, r5
	ldrh r0, [r0, #4]
	tst r0, #1
	moveq r2, #1
	mov r0, r4
	bl Player__Func_20212C8
	mov r0, r4
	mov r1, r5
	bl Player__Action_AllowTrickCombos
	ldr r0, [r5, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	str r0, [sp]
	mov r1, #0x5b
	str r1, [sp, #4]
	sub r1, r1, #0x5c
	ldr r0, [r5, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216EAC0: .word ovl00_216E400
	arm_func_end ovl00_216E964

	.rodata
	
_0218859C: // 0x0218859C
    .hword 0                   
	
_0218859E: // 0x0218859E
    .hword 1                   

_021885A0: // 0x021885A0
    .hword 2                   

_021885A2: // 0x021885A2
    .hword 3                   

_021885A4: // 0x021885A4
    .byte 2                   
	
_021885A5: // 0x021885A5
    .byte 4                   

_021885A6: // 0x021885A6
    .byte 1                   

_021885A7: // 0x021885A7
    .byte 6                   

_021885A8: // 0x021885A8
    .byte 3                   

_021885A9: // 0x021885A9
    .byte 7                   

_021885AA: // 0x021885AA
    .hword 0x4000              

_021885AC: // 0x021885AC
    .hword 0                   

_021885AE: // 0x021885AE
    .hword 0xC000              

_021885B0: // 0x021885B0
    .word 0x200000, 0x200000, 0x200000
	
_021885BC: // 0x021885BC
    .word 0, 0                
	
_021885C4: // 0x021885C4
	.word 0x40000, 0, 0

_021885D0: // 0x021885D0
	.word 0x40000, 0x40000, 0x40000

_021885DC: // 0x021885DC
    .word 0xFFFD0000, 0x5000  
	
_021885E4: // 0x021885E4
    .word 0xFFFB0000          

_021885E8: // 0x021885E8
	.word 0x30000, 0x5000, 0xFFFB0000, 0xFFFD0000, 0x5000, 0x50000
	.word 0x30000, 0x5000, 0x50000

_0218860C: // 0x0218860C
    .word 0xFFFEC000, 0xFFFF3000, 0xA000, 0xFFFF8000, 0xFFFEE000
	.word 0x7000, 0xFFFFC000, 0xFFFF5000, 0

_02188630: // 0x02188630
	.word 0xFFFEC000, 0xFFFEC000, 0

_0218863C: // 0x0218863C
	.word 0xFFFF3000, 0xFFFEB000, 0xFFFF9000, 0xFFFF2000, 0xFFFEC000
	.word 0

_02188654: // 0x02188654
	.word 0xFFFF4000, 0xFFFE7000, 0xFFFF8000, 0xFFFF2000, 0xFFFF3000
	.word 0xFFFF6000

_0218866C: // 0x0218866C
    .word 0xFFDA8000, 0x4000, 0x64000, 0xFFFE2000, 0x4000, 0x64000
	.word 0xFFDA8000, 0x4000, 0xFFFCE000, 0xFFFE2000, 0x4000
	.word 0xFFFCE000, 0xFFDA8000, 0x4000, 0xFFC7C000, 0xFFFEC000
	.word 0x4000, 0xFFFC4000, 0x258000, 0x4000, 0xFFC7C000, 0x14000
	.word 0x4000, 0xFFFC4000, 0x258000, 0x4000, 0xFFFCE000, 0x1E000
	.word 0x4000, 0xFFFCE000, 0x258000, 0x4000, 0x64000, 0x1E000
	.word 0x4000, 0x64000

_021886FC: // 0x021886FC
    .word 0x20403, 0x1010002  
	
_02188704: // 0x02188704
    .word 0x1000000, 0x10001  

	.data
	
aActAcGmkWinchB: // 0x021895A8
	.asciz "/act/ac_gmk_winch.bac"
	.align 4