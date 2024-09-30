	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start BalloonSpawner__Create
BalloonSpawner__Create: // 0x02182AD8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x368
	ldr r0, _02182BC8 // =StageTask_Main
	ldr r1, _02182BCC // =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x368
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r3, [r4, #0x1c]
	ldr r0, _02182BD0 // =BalloonSpawner__State_2182F58
	orr r3, r3, #0x2100
	str r3, [r4, #0x1c]
	str r0, [r4, #0xf4]
	mov r2, r5
	ldrsb r5, [r7, #6]
	mov r3, #0
	ldr r0, _02182BD4 // =0x00000152
	str r5, [sp]
	ldrsb r5, [r7, #7]
	mov r1, r6
	str r5, [sp, #4]
	ldrb r5, [r7, #8]
	str r5, [sp, #8]
	ldrb r5, [r7, #9]
	str r5, [sp, #0xc]
	str r3, [sp, #0x10]
	ldrh r3, [r7, #4]
	bl GameObject__SpawnObject
	str r0, [r4, #0x364]
	cmp r0, #0
	strne r4, [r0, #0x11c]
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02182BC8: .word StageTask_Main
_02182BCC: .word GameObject__Destructor
_02182BD0: .word BalloonSpawner__State_2182F58
_02182BD4: .word 0x00000152
	arm_func_end BalloonSpawner__Create

	arm_func_start Balloon__Create
Balloon__Create: // 0x02182BD8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r5, #0x1800
	mov r8, r0
	str r5, [sp]
	mov r0, #2
	mov r7, r1
	mov r4, r2
	str r0, [sp, #4]
	ldr r5, _02182F2C // =0x000004AC
	ldr r0, _02182F30 // =StageTask_Main
	ldr r1, _02182F34 // =Balloon__Destructor
	mov r2, #0
	mov r6, r3
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r0, r5
	bl GetTaskWork_
	ldr r2, _02182F2C // =0x000004AC
	mov r5, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r5
	mov r1, r8
	mov r2, r7
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r1, [r5, #0x1c]
	mov r0, #0xa1
	orr r1, r1, #0xa300
	orr r1, r1, #0x80000
	str r1, [r5, #0x1c]
	ldr r1, [r5, #0x18]
	orr r1, r1, #0x10
	str r1, [r5, #0x18]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02182F38 // =gameArchiveStage
	mov r1, #0x10
	ldr r2, [r0, #0]
	mov r0, r5
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02182F3C // =aActAcGmkBalloo
	add r1, r5, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r5
	mov r1, #2
	mov r2, #6
	bl ObjActionAllocSpritePalette
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r5
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r5
	mov r1, #2
	bl StageTask__SetAnimation
	mov r0, #0xa1
	add r4, r5, #0x364
	bl GetObjectFileWork
	ldr r1, _02182F38 // =gameArchiveStage
	mov r3, r0
	ldr r2, [r1, #0]
	ldr r1, _02182F3C // =aActAcGmkBalloo
	str r2, [sp]
	mov r0, r4
	mov r2, #0x1a
	bl ObjAction2dBACLoad
	ldr r0, [r4, #0x3c]
	mov r1, #0
	orr r0, r0, #0x200
	str r0, [r4, #0x3c]
	ldr r0, [r5, #0x20c]
	mov r2, #0x61
	ldr r0, [r0, #0]
	bl ObjDrawAllocSpritePalette
	strh r0, [r4, #0x50]
	ldrh r0, [r4, #0x50]
	strh r0, [r4, #0x92]
	strh r0, [r4, #0x90]
	ldr r1, [r4, #0x3c]
	mov r0, r4
	orr r2, r1, #0x10
	mov r1, #0x17
	str r2, [r4, #0x3c]
	bl StageTask__SetOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetOAMPriority
	mov r0, r4
	mov r1, #0
	bl AnimatorSpriteDS__SetAnimation
	add r0, r5, #8
	add r4, r0, #0x400
	mov r0, #0xa1
	bl GetObjectFileWork
	ldr r1, _02182F38 // =gameArchiveStage
	mov r3, r0
	ldr r2, [r1, #0]
	ldr r1, _02182F3C // =aActAcGmkBalloo
	str r2, [sp]
	mov r0, r4
	mov r2, #2
	bl ObjAction2dBACLoad
	ldr r0, [r5, #0x20c]
	mov r1, #1
	ldr r0, [r0, #0]
	mov r2, #0x61
	bl ObjDrawAllocSpritePalette
	strh r0, [r4, #0x50]
	ldrh r2, [r4, #0x50]
	mov r0, r4
	mov r1, #0x17
	strh r2, [r4, #0x92]
	strh r2, [r4, #0x90]
	ldr r2, [r4, #0x3c]
	orr r2, r2, #0x10
	str r2, [r4, #0x3c]
	bl StageTask__SetOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetOAMPriority
	mov r0, r4
	mov r1, #1
	bl AnimatorSpriteDS__SetAnimation
	mov r2, #8
	str r5, [r5, #0x234]
	str r2, [sp]
	sub r1, r2, #0x18
	add r0, r5, #0x218
	sub r2, r2, #0x10
	mov r3, #0x10
	bl ObjRect__SetBox2D
	mov r1, #0
	add r0, r5, #0x218
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, _02182F40 // =0x0000FFFE
	add r0, r5, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02182F44 // =Balloon__OnDefend
	str r0, [r5, #0x23c]
	ldr r0, [r5, #0x230]
	orr r0, r0, #0x400
	str r0, [r5, #0x230]
	bl AllocSndHandle
	ldr r1, _02182F48 // =Balloon__Draw
	str r0, [r5, #0x138]
	str r1, [r5, #0xfc]
	cmp r6, #0
	beq _02182F20
	mov r6, #0
	str r6, [r5, #0x234]
	str r6, [r5, #0x3c]
	ldr r0, _02182F4C // =Balloon__State_2183094
	str r6, [r5, #0x38]
	str r0, [r5, #0xf4]
	ldr r0, [r5, #0x48]
	ldr r7, [r5, #0x44]
	ldr r4, _02182F50 // =FX_SinCosTable_
	mov r9, r6
	sub r8, r0, #0x28000
_02182E8C:
	mov r0, r9, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r4, r1, lsl #1
	mov r1, r1, lsl #1
	ldrsh r2, [r0, #2]
	ldrsh r1, [r4, r1]
	mov r0, r7
	mov r2, r2, lsl #0xd
	mov r2, r2, asr #0xc
	mov r1, r1, lsl #0xd
	mov r3, r1, asr #0xc
	rsb r1, r2, #0
	mov lr, r1, asr #8
	rsb ip, r3, #0
	mov r1, r8
	str lr, [sp]
	mov ip, ip, asr #8
	str ip, [sp, #4]
	bl EffectHoverCrystalSparkle__Create
	add r0, r9, #0x2000
	add r6, r6, #1
	mov r0, r0, lsl #0x10
	cmp r6, #8
	mov r9, r0, lsr #0x10
	blt _02182E8C
	mov r4, #0x73
	sub r1, r4, #0x74
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	ldr r0, _02182F54 // =defaultSfxPlayer
	add r1, r5, #0x44
	bl ProcessSpatialSfx
_02182F20:
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02182F2C: .word 0x000004AC
_02182F30: .word StageTask_Main
_02182F34: .word Balloon__Destructor
_02182F38: .word gameArchiveStage
_02182F3C: .word aActAcGmkBalloo
_02182F40: .word 0x0000FFFE
_02182F44: .word Balloon__OnDefend
_02182F48: .word Balloon__Draw
_02182F4C: .word Balloon__State_2183094
_02182F50: .word FX_SinCosTable_
_02182F54: .word defaultSfxPlayer
	arm_func_end Balloon__Create

	arm_func_start BalloonSpawner__State_2182F58
BalloonSpawner__State_2182F58: // 0x02182F58
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r1, [r4, #0x364]
	cmp r1, #0
	beq _02182FA4
	ldr r0, [r1, #0x18]
	tst r0, #0xc
	bne _02182F88
	ldr r0, [r1, #0x11c]
	cmp r0, #0
	bne _02182FA4
_02182F88:
	mov r0, #0
	str r0, [r4, #0x364]
	ldr r0, [r4, #0x340]
	ldrsb r0, [r0, #6]
	add r0, r0, r0, lsl #1
	rsb r0, r0, #0xb4
	str r0, [r4, #0x2c]
_02182FA4:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	sub r0, r0, #1
	cmp r0, #0
	addgt sp, sp, #0x14
	str r0, [r4, #0x2c]
	ldmgtia sp!, {r3, r4, pc}
	ldr r3, [r4, #0x340]
	mov r0, #0
	str r0, [r4, #0x2c]
	ldrsb r2, [r3, #6]
	mov r1, #1
	ldr r0, _02183024 // =0x00000152
	str r2, [sp]
	ldrsb r2, [r3, #7]
	str r2, [sp, #4]
	ldrb r2, [r3, #8]
	str r2, [sp, #8]
	ldrb r2, [r3, #9]
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	ldrh r3, [r3, #4]
	ldr r1, [r4, #0x44]
	ldr r2, [r4, #0x48]
	bl GameObject__SpawnObject
	str r0, [r4, #0x364]
	cmp r0, #0
	strne r4, [r0, #0x11c]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02183024: .word 0x00000152
	arm_func_end BalloonSpawner__State_2182F58

	arm_func_start Balloon__Destructor
Balloon__Destructor: // 0x02183028
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r8, r0
	bl GetTaskWork_
	mov r5, r0
	mov r6, r5
	add r7, r5, #0x364
	mov r4, #0
	mov r9, #0xa1
_02183048:
	add r0, r6, #0x300
	ldrh r0, [r0, #0xb4]
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	mov r0, r9
	bl GetObjectFileWork
	mov r1, r7
	bl ObjAction2dBACRelease
	add r4, r4, #1
	cmp r4, #2
	add r6, r6, #0xa4
	add r7, r7, #0xa4
	blt _02183048
	ldr r0, [r5, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, r8
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end Balloon__Destructor

	arm_func_start Balloon__State_2183094
Balloon__State_2183094: // 0x02183094
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r1, [r0, #0x2c]
	add r1, r1, #0x99
	add r1, r1, #0x100
	str r1, [r0, #0x2c]
	cmp r1, #0x1000
	blt _021830CC
	mov r1, #0x1000
	str r1, [r0, #0x3c]
	str r1, [r0, #0x38]
	str r0, [r0, #0x234]
	mov r1, #0
	str r1, [r0, #0xf4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021830CC:
	mov r1, r1, lsl #0x10
	mov r7, r1, asr #0x10
	mov r4, #0
	mov r6, r7, asr #0x1f
	mov r5, #1
	mov r2, r4
	mov r1, #0x800
_021830E8:
	rsb r3, r4, #0x1000
	umull lr, ip, r3, r7
	mla ip, r3, r6, ip
	mov r3, r3, asr #0x1f
	mla ip, r3, r7, ip
	adds lr, lr, r1
	adc r3, ip, r2
	mov ip, lr, lsr #0xc
	orr ip, ip, r3, lsl #20
	cmp r5, #0
	add r4, r4, ip
	sub r5, r5, #1
	bne _021830E8
	str r4, [r0, #0x3c]
	str r4, [r0, #0x38]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end Balloon__State_2183094

	arm_func_start Balloon__State_2183128
Balloon__State_2183128: // 0x02183128
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r5, r0
	ldr r1, [r5, #0x1c]
	ldr r4, [r5, #0x35c]
	tst r1, #0xf
	beq _02183150
	bl Balloon__Func_2183434
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
_02183150:
	cmp r4, #0
	beq _0218317C
	ldr r0, [r4, #0x6d8]
	cmp r0, r5
	bne _0218317C
	ldrsh r1, [r5, #0x34]
	ldrsh r0, [r4, #0x34]
	subs r0, r1, r0
	rsbmi r0, r0, #0
	cmp r0, #0x1000
	blt _021831B0
_0218317C:
	ldr r0, [r5, #0x1c]
	ldr r1, _0218335C // =Balloon__State_2183370
	bic r0, r0, #0x2000
	str r0, [r5, #0x1c]
	ldr r2, [r5, #0xbc]
	mov r0, r5
	str r2, [r5, #0x98]
	ldr r2, [r5, #0xc0]
	str r2, [r5, #0x9c]
	str r1, [r5, #0xf4]
	bl Balloon__State_2183370
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
_021831B0:
	ldr r1, [r5, #0x44]
	mov r0, #0
	str r1, [r5, #0x8c]
	ldr r1, [r5, #0x48]
	add r2, sp, #0xc
	str r1, [r5, #0x90]
	ldrh r6, [r4, #0x34]
	add r3, sp, #8
	sub r1, r0, #0x10000
	strh r6, [r5, #0x34]
	str r6, [sp]
	bl AkMath__Func_2002C98
	ldr r2, [r4, #0x44]
	ldr r1, [sp, #0xc]
	mov r0, #0
	add r1, r2, r1
	str r1, [r5, #0x44]
	ldr r3, [r4, #0x48]
	ldr r1, [sp, #8]
	add r2, sp, #0xc
	add r1, r3, r1
	str r1, [r5, #0x48]
	ldr r1, [r4, #0x4c]
	add r3, sp, #8
	str r1, [r5, #0x4c]
	ldr r6, [r5, #0x44]
	ldr r4, [r5, #0x8c]
	sub r1, r0, #0x3c
	sub r4, r6, r4
	str r4, [r5, #0xbc]
	ldr r6, [r5, #0x48]
	ldr r4, [r5, #0x90]
	sub r4, r6, r4
	str r4, [r5, #0xc0]
	ldrh r4, [r5, #0x34]
	str r4, [sp]
	bl AkMath__Func_2002C98
	ldr r2, [sp, #8]
	ldr r3, [sp, #0xc]
	add r0, r2, #0x14
	sub r1, r3, #0x14
	sub r2, r2, #0x14
	add r3, r3, #0x14
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r0, r5
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, r3, asr #0x10
	str r4, [sp]
	bl StageTask__SetHitbox
	ldr r0, _02183360 // =playerGameStatus
	ldr r0, [r0, #0xc]
	tst r0, #7
	bne _02183348
	ldrh r4, [r5, #0x34]
	mov r0, #0
	add r2, sp, #0xc
	add r3, sp, #8
	sub r1, r0, #0x42000
	str r4, [sp]
	bl AkMath__Func_2002C98
	ldr r2, _02183364 // =_mt_math_rand
	ldr r0, _02183368 // =0x00196225
	ldr r4, [r2, #0]
	ldr r1, _0218336C // =0x3C6EF35F
	mov r3, #0
	mla r6, r4, r0, r1
	mla r1, r6, r0, r1
	mov r4, r6, lsr #0x10
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	sub r0, r0, #4
	mov r4, r0, lsl #0xc
	str r1, [r2]
	mov r1, r4, asr #7
	stmia sp, {r1, r3}
	ldr r1, [r2, #0]
	ldr r2, [r5, #0xbc]
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	and ip, r3, #7
	ldr r1, [r5, #0xc0]
	rsb r2, r2, #0
	rsb r3, r1, #0
	ldr r6, [r5, #0x44]
	ldr lr, [sp, #0xc]
	ldr r4, [r5, #0x48]
	ldr r1, [sp, #8]
	add r6, r6, lr
	sub ip, ip, #4
	add r1, r4, r1
	add r0, r6, r0, lsl #12
	add r1, r1, ip, lsl #12
	mov r2, r2, asr #4
	mov r3, r3, asr #3
	bl EffectHoverCrystalSparkle__Create
_02183348:
	ldr r0, [r5, #0x138]
	add r1, r5, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0218335C: .word Balloon__State_2183370
_02183360: .word playerGameStatus
_02183364: .word _mt_math_rand
_02183368: .word 0x00196225
_0218336C: .word 0x3C6EF35F
	arm_func_end Balloon__State_2183128

	arm_func_start Balloon__State_2183370
Balloon__State_2183370: // 0x02183370
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #0xf
	beq _02183394
	bl Balloon__Func_2183434
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_02183394:
	ldr r0, [r4, #0x9c]
	ldr r2, [r4, #0x2c]
	mvn r1, #0xff
	bl ObjSpdUpSet
	str r0, [r4, #0x9c]
	ldr r0, [r4, #0x98]
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
	ldrh r0, [r4, #0x34]
	mov r1, #0
	mov r2, #0x80
	bl ObjRoopMove16
	strh r0, [r4, #0x34]
	ldrh r2, [r4, #0x34]
	mov r0, #0
	sub r1, r0, #0x3c
	str r2, [sp]
	add r2, sp, #8
	add r3, sp, #4
	bl AkMath__Func_2002C98
	ldr r2, [sp, #4]
	ldr r3, [sp, #8]
	add r1, r2, #0x14
	mov r1, r1, lsl #0x10
	mov r1, r1, asr #0x10
	str r1, [sp]
	sub r1, r2, #0x14
	mov r1, r1, lsl #0x10
	mov r2, r1, asr #0x10
	sub r1, r3, #0x14
	add r3, r3, #0x14
	mov r1, r1, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r0, r4
	mov r1, r1, asr #0x10
	mov r3, r3, asr #0x10
	bl StageTask__SetHitbox
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	arm_func_end Balloon__State_2183370

	arm_func_start Balloon__Func_2183434
Balloon__Func_2183434: // 0x02183434
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	sub r2, r1, #0x44000
	mov r3, #1
	mov r4, r0
	bl CreateEffectExplosion
	mov r1, #0
	mov r2, #0x4000
	rsb r2, r2, #0
	mov r0, r4
	str r2, [sp]
	mov ip, #9
	sub r2, r1, #0x44000
	sub r3, r1, #0x2000
	str ip, [sp, #4]
	bl CreateEffectEnemyDebris
	mov r2, #0x4000
	rsb r2, r2, #0
	mov r1, #0
	mov r0, r4
	str r2, [sp]
	mov r2, #9
	str r2, [sp, #4]
	sub r2, r1, #0x44000
	mov r3, #0x2000
	bl CreateEffectEnemyDebris
	mov r0, #0
	str r0, [sp]
	mov r1, #0x69
	str r1, [sp, #4]
	sub r1, r1, #0x6a
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end Balloon__Func_2183434

	arm_func_start Balloon__OnDefend
Balloon__OnDefend: // 0x021834D4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x18]
	mov r1, #0
	orr r0, r0, #2
	str r0, [r4, #0x18]
	str r1, [r4, #0x234]
	ldr r0, [r4, #0x340]
	ldrsb r0, [r0, #6]
	cmp r0, #0
	blt _02183534
	cmp r0, #0x10
	movgt r0, #0x10
	mov r1, r0
_02183534:
	mov r0, r1, lsl #0xb
	add r2, r0, #0x2000
	mov r0, r5
	mov r1, r4
	str r2, [r4, #0x2c]
	bl Player__Action_BalloonRide
	mov r2, #0
	str r5, [r4, #0x35c]
	str r2, [r4, #0x11c]
	ldr r0, [r4, #0x18]
	sub r1, r2, #0x28
	bic r0, r0, #0x10
	str r0, [r4, #0x18]
	str r1, [sp]
	sub r1, r2, #0x14
	mov r0, r4
	sub r2, r2, #0x50
	mov r3, #0x14
	bl StageTask__SetHitbox
	ldr r2, [r4, #0x1c]
	mov r0, #0x68
	orr r3, r2, #0x10
	ldr r2, _021835CC // =Balloon__State_2183128
	str r3, [r4, #0x1c]
	str r2, [r4, #0xf4]
	mov r2, #0
	str r2, [sp]
	sub r1, r0, #0x69
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021835CC: .word Balloon__State_2183128
	arm_func_end Balloon__OnDefend

	arm_func_start Balloon__Draw
Balloon__Draw: // 0x021835D0
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x128]
	bl StageTask__Draw2D
	ldr r5, [r4, #0x20]
	mov r0, r4
	orr r2, r5, #4
	add r1, r4, #0x364
	str r2, [r4, #0x20]
	bl StageTask__Draw2D
	add r1, r4, #8
	mov r0, r4
	add r1, r1, #0x400
	bl StageTask__Draw2D
	str r5, [r4, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Balloon__Draw

	.data
	
aActAcGmkBalloo: // 0x02189C90
	.asciz "/act/ac_gmk_balloon.bac"
	.align 4