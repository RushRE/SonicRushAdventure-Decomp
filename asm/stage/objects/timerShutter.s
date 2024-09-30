	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start TimerShutter__Create
TimerShutter__Create: // 0x02180004
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	mov r3, #0x1800
	mov r6, r0
	mov r5, r1
	mov r4, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r7, _02180390 // =0x0000069C
	ldr r0, _02180394 // =StageTask_Main
	ldr r1, _02180398 // =TimerShutter__Destructor
	mov r3, r2
	str r7, [sp, #8]
	bl TaskCreate_
	mov r7, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r7, r0
	addeq sp, sp, #0x24
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r7
	bl GetTaskWork_
	ldr r2, _02180390 // =0x0000069C
	mov r8, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r8
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r0, [r8, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r8, #0x1c]
	ldrsb r0, [r6, #7]
	cmp r0, #0
	movlt r0, #0
	blt _021800B0
	cmp r0, #9
	movgt r0, #9
_021800B0:
	ldrsb r1, [r6, #6]
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	cmp r1, #0
	str r0, [sp, #0x18]
	movlt r1, #0
	blt _021800D4
	cmp r1, #0x3b
	movgt r1, #0x3b
_021800D4:
	mov r0, r1, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x14]
	mov r1, #0xa
	bl FX_DivS32
	mov r2, r0, lsl #0x10
	ldr r0, [sp, #0x14]
	mov r1, #0xa
	mov r4, r2, asr #0x10
	bl FX_ModS32
	mov r1, r0, lsl #0x10
	mov r0, #0x75
	mov r5, r1, asr #0x10
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0218039C // =gameArchiveStage
	mov r1, #0
	ldr r2, [r0, #0]
	mov r0, r8
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _021803A0 // =aActAcGmkTimerS
	add r1, r8, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, #0x76
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r8
	mov r1, #0x18
	bl ObjObjectActionAllocSprite
	mov r0, r8
	mov r1, #4
	mov r2, #0x5d
	bl ObjActionAllocSpritePalette
	mov r0, r8
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r8
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r8
	mov r1, #4
	bl StageTask__SetAnimation
	mov r0, #0x75
	add r9, r8, #0x364
	bl GetObjectFileWork
	ldr r1, _0218039C // =gameArchiveStage
	mov r3, r0
	ldr r2, [r1, #0]
	ldr r1, _021803A0 // =aActAcGmkTimerS
	str r2, [sp]
	mov r0, r9
	mov r2, #0x11
	bl ObjAction2dBACLoad
	ldr r1, [r8, #0x128]
	mov r0, r9
	ldrh r2, [r1, #0x50]
	mov r1, #0
	strh r2, [r9, #0x50]
	strh r2, [r9, #0x92]
	strh r2, [r9, #0x90]
	ldr r2, [r9, #0x3c]
	orr r2, r2, #0x10
	str r2, [r9, #0x3c]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r9
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r9
	mov r1, #2
	bl StageTask__SetOAMPriority
	ldr r0, [sp, #0x18]
	add r2, r4, #6
	add r6, r0, #6
	add r1, r5, #6
	add r0, r8, #8
	mov r3, #5
	strh r6, [sp, #0x1c]
	strh r3, [sp, #0x1e]
	strh r2, [sp, #0x20]
	strh r1, [sp, #0x22]
	add r9, r0, #0x400
	mov r10, #0
	mov r7, #0x75
	ldr r6, _021803A0 // =aActAcGmkTimerS
	mov r11, #2
	add r5, sp, #0x1c
	ldr r4, _0218039C // =gameArchiveStage
	b _021802C4
_02180238:
	mov r0, r7
	bl GetObjectFileWork
	ldr r1, [r4, #0]
	mov r3, r0
	str r1, [sp]
	mov r0, r9
	mov r1, r6
	mov r2, r11
	bl ObjAction2dBACLoad
	ldr r0, [r8, #0x20c]
	mov r1, r10, lsl #1
	ldrh r1, [r5, r1]
	ldr r0, [r0, #0]
	mov r2, #0x5f
	bl ObjDrawAllocSpritePalette
	strh r0, [r9, #0x50]
	strh r0, [r9, #0x92]
	strh r0, [r9, #0x90]
	ldr r1, [r9, #0x3c]
	mov r0, r9
	orr r1, r1, #0x10
	str r1, [r9, #0x3c]
	mov r1, r10, lsl #1
	ldrh r1, [r5, r1]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r9
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r9
	mov r1, #2
	bl StageTask__SetOAMPriority
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, asr #0x10
	add r9, r9, #0xa4
_021802C4:
	cmp r10, #4
	blt _02180238
	ldr r0, [sp, #0x18]
	mov r1, #0x3c
	smulbb r0, r0, r1
	mul r2, r0, r1
	mov r3, #0
	str r3, [r8, #0x13c]
	ldr r0, [sp, #0x14]
	mov r4, #0x38
	smlabb r1, r0, r1, r2
	ldr r0, _021803A4 // =StageTask__DefaultDiffData
	str r8, [r8, #0x2d8]
	str r0, [r8, #0x2fc]
	add r0, r8, #0x300
	mov r2, #0x30
	strh r2, [r0, #8]
	strh r4, [r0, #0xa]
	sub r2, r4, #0x50
	add r0, r8, #0x200
	strh r2, [r0, #0xf0]
	sub r2, r4, #0x70
	strh r2, [r0, #0xf2]
	ldr r0, _021803A8 // =playerGameStatus
	str r1, [r8, #0x698]
	ldr r0, [r0, #0xc]
	cmp r0, r1
	blo _02180374
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r1, [r8, #0x44]
	ldr r2, [r8, #0x48]
	ldr r0, _021803AC // =0x0000014B
	bl GameObject__SpawnObject
	cmp r0, #0
	beq _0218037C
	str r8, [r0, #0x11c]
	add r0, r8, #0x364
	mov r1, #3
	bl AnimatorSpriteDS__SetAnimation
	b _0218037C
_02180374:
	ldr r0, _021803B0 // =TimerShutter__State_2180640
	str r0, [r8, #0xf4]
_0218037C:
	ldr r1, _021803B4 // =TimerShutter__Draw
	mov r0, r8
	str r1, [r8, #0xfc]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02180390: .word 0x0000069C
_02180394: .word StageTask_Main
_02180398: .word TimerShutter__Destructor
_0218039C: .word gameArchiveStage
_021803A0: .word aActAcGmkTimerS
_021803A4: .word StageTask__DefaultDiffData
_021803A8: .word playerGameStatus
_021803AC: .word 0x0000014B
_021803B0: .word TimerShutter__State_2180640
_021803B4: .word TimerShutter__Draw
	arm_func_end TimerShutter__Create

	arm_func_start TimerShutterWater__Create
TimerShutterWater__Create: // 0x021803B8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, _021805B0 // =0x00001801
	mov r7, r0
	str r3, [sp]
	mov r0, #2
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _021805B4 // =0x00000408
	ldr r0, _021805B8 // =StageTask_Main
	ldr r1, _021805BC // =TimerShutter2__Destructor
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
	ldr r2, _021805B4 // =0x00000408
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0x75
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x18]
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _021805C0 // =gameArchiveStage
	mov r1, #8
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _021805C4 // =aActAcGmkTimerS
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x10
	mov r2, #0x5d
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0x10
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x20]
	add r5, r4, #0x364
	orr r0, r0, #4
	str r0, [r4, #0x20]
	mov r0, #0x75
	bl GetObjectFileWork
	ldr r1, _021805C0 // =gameArchiveStage
	mov r3, r0
	ldr r2, [r1, #0]
	ldr r1, _021805C4 // =aActAcGmkTimerS
	str r2, [sp]
	mov r0, r5
	mov r2, #0x10
	bl ObjAction2dBACLoad
	ldr r1, [r4, #0x128]
	mov r0, r5
	ldrh r2, [r1, #0x50]
	mov r1, #0x11
	strh r2, [r5, #0x50]
	strh r2, [r5, #0x92]
	strh r2, [r5, #0x90]
	ldr r2, [r5, #0x3c]
	orr r2, r2, #0x10
	str r2, [r5, #0x3c]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r5
	mov r1, #2
	bl StageTask__SetOAMPriority
	mov r2, #0
	str r4, [r4, #0x234]
	add r0, r4, #0x218
	sub r1, r2, #0x14
	mov r3, #0x14
	str r2, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _021805C8 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _021805CC // =TimerShutterWater__OnDefend
	mov r0, #0x40000
	str r1, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	rsb r0, r0, #0
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	str r0, [r4, #0x2c]
	ldr r1, _021805D0 // =TimerShutterWater__State_218082C
	ldr r0, _021805D4 // =TimerShutterWater__Draw
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021805B0: .word 0x00001801
_021805B4: .word 0x00000408
_021805B8: .word StageTask_Main
_021805BC: .word TimerShutter2__Destructor
_021805C0: .word gameArchiveStage
_021805C4: .word aActAcGmkTimerS
_021805C8: .word 0x0000FFFE
_021805CC: .word TimerShutterWater__OnDefend
_021805D0: .word TimerShutterWater__State_218082C
_021805D4: .word TimerShutterWater__Draw
	arm_func_end TimerShutterWater__Create

	arm_func_start TimerShutter__Destructor
TimerShutter__Destructor: // 0x021805D8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x75
	bl GetObjectFileWork
	add r1, r4, #0x364
	bl ObjAction2dBACRelease
	add r0, r4, #8
	add r6, r0, #0x400
	mov r5, #0
	mov r4, #0x75
_02180608:
	ldrh r0, [r6, #0x50]
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	mov r0, r4
	bl GetObjectFileWork
	mov r1, r6
	bl ObjAction2dBACRelease
	add r5, r5, #1
	cmp r5, #4
	add r6, r6, #0xa4
	blt _02180608
	mov r0, r7
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end TimerShutter__Destructor

	arm_func_start TimerShutter__State_2180640
TimerShutter__State_2180640: // 0x02180640
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	ldr r1, _021806EC // =playerGameStatus
	mov r4, r0
	ldr r2, [r4, #0x698]
	ldr r0, [r1, #0xc]
	cmp r0, r2
	blo _021806AC
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r1, [r4, #0x44]
	ldr r2, [r4, #0x48]
	ldr r0, _021806F0 // =0x0000014B
	bl GameObject__SpawnObject
	cmp r0, #0
	strne r4, [r0, #0x11c]
	add r0, r4, #0x364
	mov r1, #3
	bl AnimatorSpriteDS__SetAnimation
	mov r0, #0
	add sp, sp, #0x14
	str r0, [r4, #0xf4]
	ldmia sp!, {r3, r4, pc}
_021806AC:
	sub r0, r2, r0
	cmp r0, r2, lsr #2
	movlo r1, #2
	blo _021806C8
	cmp r0, r2, lsr #1
	movlo r1, #1
	movhs r1, #0
_021806C8:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x70]
	cmp r0, r1
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	add r0, r4, #0x364
	bl AnimatorSpriteDS__SetAnimation
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021806EC: .word playerGameStatus
_021806F0: .word 0x0000014B
	arm_func_end TimerShutter__State_2180640

	arm_func_start TimerShutter__Draw
TimerShutter__Draw: // 0x021806F4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x1c
	bl GetCurrentTaskWork_
	mov r5, r0
	ldr r1, [r5, #0x20]
	mov r7, #0
	add r0, r5, #8
	ldr r4, _021807FC // =_02188768
	str r1, [sp, #0xc]
	str r7, [sp, #0x18]
	add r6, r0, #0x400
	add r10, sp, #0xc
	mov r9, r7
	add r8, sp, #0x10
_0218072C:
	mov r0, r7, lsl #1
	ldrsb r1, [r4, r0]
	ldr r2, [r5, #0x44]
	add r0, r4, r7, lsl #1
	add r1, r2, r1, lsl #12
	str r1, [sp, #0x10]
	ldrsb r1, [r0, #1]
	ldr r2, [r5, #0x48]
	mov r0, r6
	add r1, r2, r1, lsl #12
	str r1, [sp, #0x14]
	str r10, [sp]
	str r9, [sp, #4]
	mov r1, r8
	mov r2, r9
	add r3, r5, #0x38
	str r9, [sp, #8]
	bl StageTask__Draw2DEx
	add r7, r7, #1
	cmp r7, #4
	add r6, r6, #0xa4
	blt _0218072C
	ldr r2, [r5, #0x20]
	add r0, r5, #0x300
	str r2, [sp, #0xc]
	ldr r1, [r5, #0x44]
	add r3, r5, #0x38
	str r1, [sp, #0x10]
	ldr r1, [r5, #0x48]
	str r1, [sp, #0x14]
	ldrh r0, [r0, #0x70]
	add r1, sp, #0x10
	cmp r0, #3
	orreq r0, r2, #4
	streq r0, [sp, #0xc]
	add r0, sp, #0xc
	mov r2, #0
	stmia sp, {r0, r2}
	add r0, r5, #0x364
	str r2, [sp, #8]
	bl StageTask__Draw2DEx
	add r0, r5, #0x20
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r2, [sp, #8]
	ldr r0, [r5, #0x128]
	add r1, sp, #0x10
	add r3, r5, #0x38
	bl StageTask__Draw2DEx
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_021807FC: .word _02188768
	arm_func_end TimerShutter__Draw

	arm_func_start TimerShutter2__Destructor
TimerShutter2__Destructor: // 0x02180800
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x75
	bl GetObjectFileWork
	add r1, r4, #0x364
	bl ObjAction2dBACRelease
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TimerShutter2__Destructor

	arm_func_start TimerShutterWater__State_218082C
TimerShutterWater__State_218082C: // 0x0218082C
	ldr r1, [r0, #0x2c]
	adds r1, r1, #0x6000
	str r1, [r0, #0x2c]
	movpl r1, #0
	strpl r1, [r0, #0x2c]
	strpl r1, [r0, #0xf4]
	ldr r1, [r0, #0x2c]
	add r0, r0, #0x200
	add r1, r1, #0x40000
	mov r1, r1, asr #0xc
	strh r1, [r0, #0x20]
	bx lr
	arm_func_end TimerShutterWater__State_218082C

	arm_func_start TimerShutterWater__Draw
TimerShutterWater__Draw: // 0x0218085C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x1c
	bl GetCurrentTaskWork_
	mov r7, r0
	ldr r0, [r7, #0x2c]
	cmp r0, #0
	bne _021808B8
	ldr r0, [r7, #0x20]
	mov r2, #0
	str r0, [sp, #0xc]
	ldr r1, [r7, #0x44]
	add r0, sp, #0xc
	str r1, [sp, #0x10]
	ldr r3, [r7, #0x48]
	add r1, sp, #0x10
	add r3, r3, #0x40000
	str r3, [sp, #0x14]
	str r2, [sp, #0x18]
	stmia sp, {r0, r2}
	add r0, r7, #0x364
	add r3, r7, #0x38
	str r2, [sp, #8]
	bl StageTask__Draw2DEx
_021808B8:
	ldr r0, [r7, #0x44]
	mov r9, #0
	str r9, [sp, #0x18]
	str r0, [sp, #0x10]
	ldr r0, [r7, #0x20]
	mov r10, #0x20000
	str r0, [sp, #0xc]
	ldr r8, [r7, #0x2c]
	rsb r10, r10, #0
	add r6, sp, #0xc
	mov r5, r9
	add r4, sp, #0x10
_021808E8:
	add r0, r8, r9
	cmp r0, r10
	ble _02180930
	ldr r0, [r7, #0x48]
	mov r1, r4
	add r0, r0, r8
	add r0, r9, r0
	str r0, [sp, #0x14]
	str r6, [sp]
	str r5, [sp, #4]
	str r5, [sp, #8]
	ldr r0, [r7, #0x128]
	mov r2, r5
	add r3, r7, #0x38
	bl StageTask__Draw2DEx
	ldr r0, [sp, #0xc]
	orr r0, r0, #0x1000
	str r0, [sp, #0xc]
_02180930:
	add r9, r9, #0x20000
	cmp r9, #0x40000
	blt _021808E8
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end TimerShutterWater__Draw

	arm_func_start TimerShutterWater__OnDefend
TimerShutterWater__OnDefend: // 0x02180944
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, [r1, #0x1c]
	ldr r4, [r0, #0x1c]
	cmp r2, #0
	cmpne r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r4, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r2, #0x44]
	ldr r1, [r4, #0x44]
	mov r2, #0x3000
	cmp r1, r0
	mov r1, #0x2000
	rsble r1, r1, #0
	movle r5, #0x8000
	mov r0, r4
	rsb r2, r2, #0
	subgt r5, r1, #0xa000
	bl Player__Action_HurtAlt
	mov r2, #0x4000
	mov r0, r4
	mov r1, r5
	rsb r2, r2, #0
	mov r3, #0
	bl EffectWaterGush__Create
	mov r2, #0xc000
	mov r0, r4
	mov r1, r5
	rsb r2, r2, #0
	mov r3, #0
	bl EffectWaterGush__Create
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TimerShutterWater__OnDefend

	.rodata
	
.public _02188768
_02188768: // 0x02188768
    .byte 0xF5, 0xED, 0xFC, 0xE8, 2, 0xED, 0xC, 0xED

	.data
	
aActAcGmkTimerS: // 0x02189B84
	.asciz "/act/ac_gmk_timer_shutter.bac"
	.align 4