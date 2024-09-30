	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start DreamWing__Create
DreamWing__Create: // 0x02166E80
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x36c
	ldr r0, _02166FE0 // =StageTask_Main
	ldr r1, _02166FE4 // =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x36c
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xb8
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02166FE8 // =gameArchiveStage
	ldr r1, _02166FEC // =0x0000FFFF
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02166FF0 // =aActAcGmkDreamW
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x20
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldrh r0, [r7, #4]
	mov r1, #0
	mov r2, r1
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _02166FF4 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02166FF8 // =DreamWing__OnDefend
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	bl AllocSndHandle
	str r0, [r4, #0x138]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02166FE0: .word StageTask_Main
_02166FE4: .word GameObject__Destructor
_02166FE8: .word gameArchiveStage
_02166FEC: .word 0x0000FFFF
_02166FF0: .word aActAcGmkDreamW
_02166FF4: .word 0x0000FFFE
_02166FF8: .word DreamWing__OnDefend
	arm_func_end DreamWing__Create

	arm_func_start DreamWingPart__Create
DreamWingPart__Create: // 0x02166FFC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _021671B4 // =StageTask_Main
	ldr r1, _021671B8 // =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x340]
	ldrb r0, [r0, #9]
	cmp r0, #7
	movls r0, #1
	movhi r0, r0, asr #3
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x28]
	cmp r0, #0x10
	movhi r0, #0x10
	strhi r0, [r4, #0x28]
	mov r0, #0xb8
	bl GetObjectFileWork
	ldr r1, _021671BC // =gameArchiveStage
	mov r3, r0
	ldr r1, [r1, #0]
	ldr r2, _021671C0 // =aActAcGmkDreamW
	str r1, [sp]
	mov r5, #0
	mov r0, r4
	add r1, r4, #0x168
	str r5, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, #0xb9
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #1
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, r5
	mov r2, #0x20
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x16
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #3
	bl StageTask__SetAnimation
	mov r0, r5
	str r0, [r4, #0x13c]
	mov r1, #0x10
	ldr r0, _021671C4 // =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	add r0, r4, #0x300
	strh r1, [r0, #8]
	ldr r3, [r4, #0x28]
	sub r2, r1, #0x14
	mov r3, r3, lsl #3
	add r1, r4, #0x200
	strh r3, [r0, #0xa]
	strh r2, [r1, #0xf0]
	ldr r0, [r4, #0x28]
	mov r0, r0, lsl #3
	rsb r0, r0, #0
	add r0, r0, #4
	strh r0, [r1, #0xf2]
	ldrh r0, [r7, #4]
	tst r0, #1
	ldrnesh r0, [r1, #0xf0]
	subne r0, r0, #8
	strneh r0, [r1, #0xf0]
	ldr r1, _021671C8 // =DreamWingPart__Draw
	mov r0, r4
	str r1, [r4, #0xfc]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021671B4: .word StageTask_Main
_021671B8: .word GameObject__Destructor
_021671BC: .word gameArchiveStage
_021671C0: .word aActAcGmkDreamW
_021671C4: .word StageTask__DefaultDiffData
_021671C8: .word DreamWingPart__Draw
	arm_func_end DreamWingPart__Create

	arm_func_start DreamWing__State_21671CC
DreamWing__State_21671CC: // 0x021671CC
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	add r1, r5, #0x100
	ldrh r1, [r1, #0x74]
	cmp r1, #1
	bne _02167208
	ldr r1, [r5, #0x20]
	tst r1, #8
	beq _02167208
	mov r1, #2
	bl StageTask__SetAnimation
	mov r0, r5
	mov r1, #2
	bl StageTask__SetAnimatorPriority
_02167208:
	ldr r4, [r5, #0x35c]
	cmp r4, #0
	beq _021673B8
	ldr r0, [r4, #0x6d8]
	cmp r0, r5
	bne _021673B8
	ldr r0, [r5, #0x44]
	str r0, [r5, #0x8c]
	ldr r0, [r5, #0x48]
	str r0, [r5, #0x90]
	ldr r0, [r4, #0x44]
	str r0, [r5, #0x44]
	ldr r0, [r4, #0x48]
	sub r0, r0, #0x10000
	str r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x8c]
	sub r0, r1, r0
	str r0, [r5, #0xbc]
	ldr r1, [r5, #0x48]
	ldr r0, [r5, #0x90]
	sub r0, r1, r0
	str r0, [r5, #0xc0]
	ldr r0, [r4, #0x1c]
	tst r0, #0xf
	bne _02167280
	ldr r0, [r4, #0x98]
	str r0, [r5, #0x98]
	ldr r0, [r4, #0x9c]
	str r0, [r5, #0x9c]
_02167280:
	ldr r1, [r4, #0x28]
	ldr r0, [r5, #0x364]
	cmp r0, r1
	bhs _02167324
	str r1, [r5, #0x364]
	ldr r1, [r5, #0x354]
	mov r0, #0x12000
	orr r1, r1, #1
	str r1, [r5, #0x354]
	mov r1, #0
	str r1, [r5, #0x368]
	ldr r2, [r5, #0xc0]
	ldr r1, [r5, #0x20]
	rsb r2, r2, #0
	mov r2, r2, asr #2
	tst r1, #1
	rsb r0, r0, #0
	mov r1, #0x10000
	str r2, [sp]
	str r1, [sp, #4]
	ldr r1, [r5, #0xbc]
	ldr ip, [r5, #0x44]
	rsb r3, r1, #0
	movne r0, #0x12000
	add r1, ip, r0
	ldr r2, [r5, #0x48]
	mov r3, r3, asr #2
	mov r0, #1
	bl EffectSteamEffect__Create
	ldr r0, [r5, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r2, #0
	mov r0, #0x5a
	str r2, [sp]
	sub r1, r0, #0x5b
	str r0, [sp, #4]
	ldr r0, [r5, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02167324:
	ldr r1, [r5, #0x354]
	tst r1, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x24]
	tst r0, #2
	biceq r0, r1, #1
	addeq sp, sp, #8
	streq r0, [r5, #0x354]
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x368]
	add r0, r0, #1
	tst r0, #3
	addne sp, sp, #8
	str r0, [r5, #0x368]
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [r5, #0xc0]
	ldr r0, [r5, #0x20]
	rsb r1, r1, #0
	mov r1, r1, asr #2
	tst r0, #1
	mov r3, #0x12000
	rsb r3, r3, #0
	mov r0, #0x10000
	str r1, [sp]
	str r0, [sp, #4]
	ldr r0, [r5, #0xbc]
	ldr r1, [r5, #0x44]
	movne r3, #0x12000
	rsb r0, r0, #0
	add r1, r1, r3
	mov r3, r0, asr #2
	ldr r2, [r5, #0x48]
	mov r0, #0
	bl EffectSteamEffect__Create
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_021673B8:
	cmp r4, #0
	beq _021673D4
	ldr r1, [r5, #0x1c]
	mov r0, #0
	bic r1, r1, #0x2000
	str r1, [r5, #0x1c]
	str r0, [r5, #0x35c]
_021673D4:
	add r0, r5, #0x100
	ldrh r0, [r0, #0x74]
	cmp r0, #2
	moveq r0, #0
	streq r0, [r5, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end DreamWing__State_21671CC

	arm_func_start DreamWing__OnDefend
DreamWing__OnDefend: // 0x021673F0
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r2, [r5, #0]
	cmp r2, #1
	ldreqb r2, [r5, #0x5d1]
	cmpeq r2, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r2, [r5, #0x1c]
	tst r2, #1
	beq _02167488
	ldr r2, [r4, #0x20]
	ands r3, r2, #1
	bne _02167440
	ldr r2, [r5, #0xbc]
	cmp r2, #0
	blt _02167488
_02167440:
	cmp r3, #0
	beq _02167454
	ldr r2, [r5, #0xbc]
	cmp r2, #0
	bgt _02167488
_02167454:
	ldr r2, [r5, #0xbc]
	cmp r2, #0
	bne _02167490
	cmp r3, #0
	bne _02167474
	ldr r2, [r5, #0x20]
	tst r2, #1
	bne _02167488
_02167474:
	cmp r3, #0
	beq _02167490
	ldr r2, [r5, #0x20]
	tst r2, #1
	bne _02167490
_02167488:
	bl ObjRect__FuncNoHit
	ldmia sp!, {r3, r4, r5, pc}
_02167490:
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	str r5, [r4, #0x35c]
	ldr r0, [r4, #0x20]
	ldrh r2, [r5, #0x34]
	ands r0, r0, #1
	bne _021674C0
	cmp r2, #0
	beq _021674C0
	cmp r2, #0x8000
	bls _021674D0
_021674C0:
	cmp r0, #0
	beq _021674D4
	cmp r2, #0x8000
	bls _021674D4
_021674D0:
	mov r2, #0
_021674D4:
	cmp r0, #0
	addne r0, r2, #0x8000
	movne r0, r0, lsl #0x10
	movne r2, r0, lsr #0x10
	ldr r0, [r5, #0x98]
	ldr r1, [r5, #0xc8]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	add r1, r1, r0
	cmp r1, #0x3000
	movlt r1, #0x3000
	blt _02167514
	cmp r1, #0x9000
	movgt r1, #0x9000
_02167514:
	mov r0, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov ip, r0, lsl #1
	add r0, ip, #1
	ldr r2, _021675AC // =FX_SinCosTable_
	mov r3, r0, lsl #1
	mov r0, ip, lsl #1
	ldrsh r3, [r2, r3]
	ldrsh r2, [r2, r0]
	mov r0, r4
	smull r3, ip, r1, r3
	adds lr, r3, #0x800
	smull r3, r2, r1, r2
	adc r1, ip, #0
	adds r3, r3, #0x800
	mov ip, lr, lsr #0xc
	orr ip, ip, r1, lsl #20
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	str ip, [r4, #0x98]
	orr r2, r2, r1, lsl #20
	mov r1, #1
	str r2, [r4, #0x9c]
	bl StageTask__SetAnimation
	ldr r1, _021675B0 // =DreamWing__State_21671CC
	mov r0, r5
	str r1, [r4, #0xf4]
	ldr r2, [r4, #0x340]
	mov r1, r4
	ldrsb r2, [r2, #6]
	mov r2, r2, lsl #2
	add r2, r2, #0xa
	str r2, [sp]
	ldr r2, [r4, #0x98]
	ldr r3, [r4, #0x9c]
	bl Player__Action_DreamWing
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021675AC: .word FX_SinCosTable_
_021675B0: .word DreamWing__State_21671CC
	arm_func_end DreamWing__OnDefend

	arm_func_start DreamWingPart__Draw
DreamWingPart__Draw: // 0x021675B4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x18
	bl GetCurrentTaskWork_
	mov r3, r0
	add r0, r3, #0x44
	ldr r5, [r3, #0x128]
	add r8, sp, #0xc
	ldmia r0, {r0, r1, r2}
	stmia r8, {r0, r1, r2}
	ldr r4, [r3, #0x28]
	cmp r4, #0
	addle sp, sp, #0x18
	ldmleia sp!, {r4, r5, r6, r7, r8, pc}
	add r7, r3, #0x20
	mov r6, #0
_021675F0:
	str r7, [sp]
	str r6, [sp, #4]
	mov r0, r5
	mov r1, r8
	mov r2, r6
	mov r3, r6
	str r6, [sp, #8]
	bl StageTask__Draw2DEx
	ldr r0, [sp, #0x10]
	sub r4, r4, #1
	sub r0, r0, #0x8000
	str r0, [sp, #0x10]
	cmp r4, #0
	bgt _021675F0
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end DreamWingPart__Draw
	
	.data

aActAcGmkDreamW: // 0x021891A4
	.asciz "/act/ac_gmk_dream_wing.bac"
	.align 4