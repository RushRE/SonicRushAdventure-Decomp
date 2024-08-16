	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Snowslide__Create
Snowslide__Create: // 0x02175D8C
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
	ldr r0, _02175FB4 // =StageTask_Main
	ldr r1, _02175FB8 // =GameObject__Destructor
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
	ldr r1, [r4, #0x1c]
	add r0, r4, #0x218
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x20
	str r1, [r4, #0x20]
	str r4, [r4, #0x234]
	ldrsb r2, [r7, #7]
	ldrsb r1, [r7, #6]
	ldrb r3, [r7, #9]
	add r3, r2, r3
	mov r3, r3, lsl #0x10
	mov r3, r3, asr #0x10
	str r3, [sp]
	ldrb r3, [r7, #8]
	add r3, r1, r3
	mov r3, r3, lsl #0x10
	mov r3, r3, asr #0x10
	bl ObjRect__SetBox2D
	ldrh r0, [r7, #2]
	cmp r0, #0xc2
	bne _02175F00
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _02175FBC // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _02175FC0 // =ovl00_217673C
	add r0, r4, #0x258
	str r1, [r4, #0x23c]
	str r4, [r4, #0x274]
	ldrsb r6, [r7, #6]
	ldrsb r2, [r7, #7]
	ldrb r5, [r7, #9]
	sub r1, r6, #0x30
	mov r3, r1, lsl #0x10
	add r1, r2, r5
	mov r1, r1, lsl #0x10
	mov r1, r1, asr #0x10
	str r1, [sp]
	sub r1, r6, #0x10
	mov r5, r1, lsl #0x10
	mov r1, r3, asr #0x10
	mov r3, r5, asr #0x10
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x258
	bl ObjRect__SetAttackStat
	ldr r1, _02175FBC // =0x0000FFFE
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02175FC4 // =ovl00_21766F0
	b _02175F90
_02175F00:
	ldr r5, _02175FC8 // =0x00000201
	add r3, r4, #0x200
	add r0, r4, #0x218
	mov r1, #0x10
	mov r2, #0
	strh r5, [r3, #0x4c]
	bl ObjRect__SetAttackStat
	ldr r1, _02175FCC // =0x0000FFFF
	add r0, r4, #0x218
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	mov r0, #0
	str r0, [r4, #0x23c]
	str r4, [r4, #0x274]
	ldrsb r2, [r7, #7]
	ldrb r3, [r7, #9]
	ldrsb r1, [r7, #6]
	add r0, r4, #0x258
	add r3, r2, r3
	mov r3, r3, lsl #0x10
	mov r3, r3, asr #0x10
	str r3, [sp]
	ldrb r3, [r7, #8]
	add r3, r1, r3
	mov r3, r3, lsl #0x10
	mov r3, r3, asr #0x10
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x258
	bl ObjRect__SetAttackStat
	ldr r1, _02175FBC // =0x0000FFFE
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02175FD0 // =ovl00_21767FC
_02175F90:
	str r0, [r4, #0x27c]
	ldr r0, [r4, #0x230]
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	bl AllocSndHandle
	str r0, [r4, #0x138]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02175FB4: .word StageTask_Main
_02175FB8: .word GameObject__Destructor
_02175FBC: .word 0x0000FFFE
_02175FC0: .word ovl00_217673C
_02175FC4: .word ovl00_21766F0
_02175FC8: .word 0x00000201
_02175FCC: .word 0x0000FFFF
_02175FD0: .word ovl00_21767FC
	arm_func_end Snowslide__Create

	arm_func_start IceTree__Create
IceTree__Create: // 0x02175FD4
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
	ldr r0, _02176174 // =StageTask_Main
	ldr r1, _02176178 // =GameObject__Destructor
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
	ldr r1, [r4, #0x1c]
	mov r0, #0xca
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0217617C // =gameArchiveStage
	mov r1, #0
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02176180 // =aActAcDecIceTre
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, #0xcb
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #0x36
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #0
	mov r2, #0x40
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	ldrh r0, [r7, #4]
	tst r0, #1
	mov r0, r4
	beq _021760F4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	b _021760FC
_021760F4:
	mov r1, #3
	bl StageTask__SetAnimatorPriority
_021760FC:
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimation
	mov r1, #0x10
	str r4, [r4, #0x234]
	mov r5, #2
	add r0, r4, #0x218
	sub r2, r1, #0x44
	mov r3, #0x3c
	str r5, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	ldr r5, _02176184 // =0x00000201
	add r3, r4, #0x200
	mov r2, r1
	add r0, r4, #0x218
	strh r5, [r3, #0x4c]
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r1, _02176188 // =ovl00_2176854
	mov r0, r4
	str r1, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02176174: .word StageTask_Main
_02176178: .word GameObject__Destructor
_0217617C: .word gameArchiveStage
_02176180: .word aActAcDecIceTre
_02176184: .word 0x00000201
_02176188: .word ovl00_2176854
	arm_func_end IceTree__Create

	arm_func_start ovl00_217618C
ovl00_217618C: // 0x0217618C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _02176350 // =gPlayer
	mov r4, r0
	ldr r2, [r1]
	ldr r0, [r2, #0x5d8]
	tst r0, #0x400
	bne _021761C8
	ldr r1, [r2, #0x44]
	ldr r0, [r4, #0x44]
	subs r0, r1, r0
	rsbmi r1, r0, #0
	movpl r1, r0
	cmp r1, #0x400000
	blt _021761DC
_021761C8:
	ldr r0, [r4, #0x18]
	add sp, sp, #8
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
_021761DC:
	cmp r0, #0x80000
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	ldr r1, _02176350 // =gPlayer
	add r0, r2, #0x600
	mov r2, #0x50
	strh r2, [r0, #0xe0]
	ldr r0, [r1]
	mov r1, #0x28
	add r0, r0, #0x600
	strh r1, [r0, #0xe2]
	ldr r0, [r4, #0x48]
	mov ip, #0x10
	add r0, r0, #0xa0000
	str r0, [r4, #0x48]
	sub r1, ip, #0x30
	str r4, [r4, #0x234]
	mov r2, r1
	add r0, r4, #0x218
	mov r3, #0
	str ip, [sp]
	bl ObjRect__SetBox2D
	add r0, r4, #0x218
	mov r1, #4
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, _02176354 // =0x0000FFFF
	add r0, r4, #0x218
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	mov r0, #0
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	mov r3, #0x10
	orr r0, r0, #4
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	sub r1, r3, #0x20
	str r4, [r4, #0x274]
	add r0, r4, #0x258
	mov r2, r1
	str r3, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	add r0, r4, #0x258
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, _02176358 // =0x0000FFEF
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _0217635C // =ovl00_2176788
	mov r3, #6
	str r0, [r4, #0x27c]
	ldr r1, [r4, #0x270]
	mov r0, r4
	orr r1, r1, #4
	orr r1, r1, #0x400
	str r1, [r4, #0x270]
	sub r1, r3, #0xc
	str r3, [sp]
	mov r2, r1
	bl StageTask__SetHitbox
	ldr r0, [r4, #0x18]
	ldr r1, _02176360 // =ovl00_2176364
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x1c]
	mov r2, #0
	bic r0, r0, #0x2100
	orr r0, r0, #0x2c0
	orr r0, r0, #0x20000
	str r0, [r4, #0x1c]
	mov r0, #0xd800
	str r0, [r4, #0xc8]
	str r1, [r4, #0xf4]
	mov r0, #0x55
	str r2, [sp]
	sub r1, r0, #0x56
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	mov r0, #9
	bl ShakeScreen
	mov r0, #8
	str r0, [r4, #0x28]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02176350: .word gPlayer
_02176354: .word 0x0000FFFF
_02176358: .word 0x0000FFEF
_0217635C: .word ovl00_2176788
_02176360: .word ovl00_2176364
	arm_func_end ovl00_217618C

	arm_func_start ovl00_2176364
ovl00_2176364: // 0x02176364
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r1, _021766BC // =gPlayer
	mov r5, r0
	ldr r1, [r1]
	ldr r2, [r5, #0x2c]
	ldrb r4, [r1, #0x5d0]
	cmp r2, #0
	bne _021763AC
	ldr r0, [r1, #0x5d8]
	tst r0, #0x400
	bne _021763A0
	ldr r0, _021766C0 // =playerGameStatus
	ldr r0, [r0]
	tst r0, #1
	bne _021763AC
_021763A0:
	mov r0, #0x10
	str r0, [r5, #0x2c]
	b _02176484
_021763AC:
	ldr r1, [r1, #0x44]
	ldr r0, [r5, #0x44]
	subs r0, r1, r0
	rsbmi r0, r0, #0
	cmp r0, #0x400000
	bge _021763E0
	ldr r1, [r5, #0xbc]
	ldr r0, [r5, #0xc0]
	adds r0, r1, r0
	beq _021763E0
	ldr r0, [r5, #0x1c]
	tst r0, #1
	bne _02176420
_021763E0:
	ldr r1, [r5, #0x18]
	mov r0, #0
	orr r1, r1, #4
	str r1, [r5, #0x18]
	bl ShakeScreen
	mov r0, #8
	bl ShakeScreen
	ldr r1, _021766BC // =gPlayer
	mov r2, #0
	ldr r0, [r1]
	add r0, r0, #0x600
	strh r2, [r0, #0xe0]
	ldr r0, [r1]
	add r0, r0, #0x600
	strh r2, [r0, #0xe2]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02176420:
	cmp r2, #0
	beq _02176484
	ldr r0, [r5, #0x2c]
	subs r0, r0, #1
	str r0, [r5, #0x2c]
	bne _02176484
	ldr r0, [r5, #0x18]
	mov r1, #0
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldr r0, [r5, #0x138]
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	bl ShakeScreen
	mov r0, #8
	bl ShakeScreen
	ldr r1, _021766BC // =gPlayer
	mov r2, #0
	ldr r0, [r1]
	add r0, r0, #0x600
	strh r2, [r0, #0xe0]
	ldr r0, [r1]
	add r0, r0, #0x600
	strh r2, [r0, #0xe2]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02176484:
	ldr r1, _021766BC // =gPlayer
	ldr r0, [r5, #0x44]
	ldr r3, [r1]
	ldr r2, [r3, #0x44]
	cmp r2, r0
	add r0, r3, #0x600
	bge _021764B8
	mov r2, #0
	strh r2, [r0, #0xe0]
	ldr r0, [r1]
	add r0, r0, #0x600
	strh r2, [r0, #0xe2]
	b _021764D0
_021764B8:
	mov r2, #0x50
	strh r2, [r0, #0xe0]
	ldr r0, [r1]
	mov r1, #0x28
	add r0, r0, #0x600
	strh r1, [r0, #0xe2]
_021764D0:
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _021764F0
	subs r0, r0, #1
	str r0, [r5, #0x28]
	bne _021764F0
	mov r0, #0xd
	bl ShakeScreen
_021764F0:
	ldr r0, [r5, #0x354]
	tst r0, #1
	beq _02176550
	ldr r0, _021766BC // =gPlayer
	ldr r1, _021766C4 // =0x021897A0
	ldr r0, [r0]
	ldr r2, [r5, #0x44]
	ldr r3, [r0, #0x44]
	ldr r0, [r1, r4, lsl #2]
	sub r1, r3, r2
	cmp r1, r0
	blt _02176530
	ldr r0, _021766C8 // =_02189798
	ldr r0, [r0, r4, lsl #2]
	str r0, [r5, #0xc8]
	b _02176598
_02176530:
	ldr r0, _021766CC // =0x021897A8
	ldr r0, [r0, r4, lsl #2]
	cmp r1, r0
	bgt _02176598
	ldr r0, _021766D0 // =0x021897B8
	ldr r0, [r0, r4, lsl #2]
	str r0, [r5, #0xc8]
	b _02176598
_02176550:
	ldr r0, _021766BC // =gPlayer
	ldr r1, _021766D4 // =0x021897B0
	ldr r0, [r0]
	ldr r2, [r5, #0x44]
	ldr r3, [r0, #0x44]
	ldr r0, [r1, r4, lsl #2]
	sub r1, r3, r2
	cmp r1, r0
	bgt _02176598
	ldr r1, [r5, #0x1c]
	ldr r0, _021766D0 // =0x021897B8
	bic r1, r1, #0x20000
	str r1, [r5, #0x1c]
	ldr r0, [r0, r4, lsl #2]
	str r0, [r5, #0xc8]
	ldr r0, [r5, #0x354]
	orr r0, r0, #1
	str r0, [r5, #0x354]
_02176598:
	ldr r0, _021766C0 // =playerGameStatus
	ldr r0, [r0, #0xc]
	tst r0, #1
	bne _02176628
	ldr r3, _021766D8 // =_mt_math_rand
	ldr r0, _021766DC // =0x00196225
	ldr r4, [r3]
	ldr r1, _021766E0 // =0x3C6EF35F
	ldr r2, _021766E4 // =0x000003FF
	mla r6, r4, r0, r1
	mla r4, r6, r0, r1
	mla r0, r4, r0, r1
	str r0, [r3]
	mov r3, r4, lsr #0x10
	mov r1, r0, lsr #0x10
	mov r0, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r4, r6, lsr #0x10
	mov r6, r0, lsr #0x10
	mov r3, r1, lsr #0x10
	ldr r1, [r5, #0xbc]
	mov r0, r4, lsl #0x10
	and r4, r3, #0x1f
	and r3, r6, #0x1f
	rsb ip, r1, #0
	ldr r7, [r5, #0x44]
	sub r6, r4, #0xf
	ldr lr, [r5, #0x48]
	sub r1, r3, #0x18
	and r4, r2, r0, lsr #16
	mvn r3, #0xff
	add r0, r7, r6, lsl #12
	add r1, lr, r1, lsl #12
	mov r2, ip, asr #4
	sub r3, r3, r4
	bl EffectSnowslide__Create
_02176628:
	ldr r0, _021766C0 // =playerGameStatus
	ldr r0, [r0, #0xc]
	add r0, r0, #4
	tst r0, #0x1f
	bne _021766AC
	ldr r3, _021766D8 // =_mt_math_rand
	ldr r0, _021766DC // =0x00196225
	ldr r4, [r3]
	ldr r1, _021766E0 // =0x3C6EF35F
	ldr r2, _021766E8 // =0x00000FFF
	mla ip, r4, r0, r1
	mla r4, ip, r0, r1
	mla r1, r4, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	and r0, r2, r0, lsr #16
	str r1, [r3]
	sub r0, r0, #0x3000
	str r0, [sp]
	ldr r0, [r3]
	mov r3, r4, lsr #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r3, lsl #0x10
	and r3, r2, r0, lsr #16
	ldr r0, _021766EC // =0x021897C0
	and r1, r1, #7
	ldrb r0, [r0, r1]
	ldr r1, [r5, #0x44]
	ldr r2, [r5, #0x48]
	add r3, r3, #0x8000
	bl EffectSnowslideDebris__Create
_021766AC:
	ldr r0, [r5, #0x138]
	add r1, r5, #0x44
	bl ProcessSpatialSfx
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021766BC: .word gPlayer
_021766C0: .word playerGameStatus
_021766C4: .word 0x021897A0
_021766C8: .word _02189798
_021766CC: .word 0x021897A8
_021766D0: .word 0x021897B8
_021766D4: .word 0x021897B0
_021766D8: .word _mt_math_rand
_021766DC: .word 0x00196225
_021766E0: .word 0x3C6EF35F
_021766E4: .word 0x000003FF
_021766E8: .word 0x00000FFF
_021766EC: .word 0x021897C0
	arm_func_end ovl00_2176364

	arm_func_start ovl00_21766F0
ovl00_21766F0: // 0x021766F0
	ldr r2, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r2, #0
	cmpne r0, #0
	bxeq lr
	ldrh r0, [r0]
	cmp r0, #1
	bxne lr
	ldr r1, [r2, #0xf4]
	ldr r0, _02176734 // =ovl00_217618C
	cmp r1, r0
	ldrne r0, _02176738 // =ovl00_2176364
	cmpne r1, r0
	ldrne r0, [r2, #0x354]
	orrne r0, r0, #2
	strne r0, [r2, #0x354]
	bx lr
	.align 2, 0
_02176734: .word ovl00_217618C
_02176738: .word ovl00_2176364
	arm_func_end ovl00_21766F0

	arm_func_start ovl00_217673C
ovl00_217673C: // 0x0217673C
	ldr r2, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r2, #0
	cmpne r0, #0
	bxeq lr
	ldrh r0, [r0]
	cmp r0, #1
	bxne lr
	ldr r0, [r2, #0x354]
	tst r0, #2
	bxeq lr
	bic r1, r0, #2
	ldr r0, _02176784 // =ovl00_217618C
	str r1, [r2, #0x354]
	str r0, [r2, #0xf4]
	mov r0, #0
	str r0, [r2, #0x23c]
	bx lr
	.align 2, 0
_02176784: .word ovl00_217618C
	arm_func_end ovl00_217673C

	arm_func_start ovl00_2176788
ovl00_2176788: // 0x02176788
	stmdb sp!, {r3, lr}
	ldr r2, [r1, #0x1c]
	ldr r1, [r0, #0x1c]
	cmp r2, #0
	cmpne r1, #0
	ldmeqia sp!, {r3, pc}
	ldrh r0, [r1]
	cmp r0, #3
	ldreq r0, [r1, #0x340]
	ldreqh r0, [r0, #2]
	cmpeq r0, #0xc3
	ldmneia sp!, {r3, pc}
	ldr r1, [r2, #0x18]
	mov r0, #0
	orr r1, r1, #8
	str r1, [r2, #0x18]
	bl ShakeScreen
	mov r0, #8
	bl ShakeScreen
	ldr r1, _021767F8 // =gPlayer
	mov r2, #0
	ldr r0, [r1]
	add r0, r0, #0x600
	strh r2, [r0, #0xe0]
	ldr r0, [r1]
	add r0, r0, #0x600
	strh r2, [r0, #0xe2]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021767F8: .word gPlayer
	arm_func_end ovl00_2176788

	arm_func_start ovl00_21767FC
ovl00_21767FC: // 0x021767FC
	ldr r2, [r1, #0x1c]
	ldr r1, [r0, #0x1c]
	cmp r2, #0
	cmpne r1, #0
	bxeq lr
	ldrh r0, [r1]
	cmp r0, #1
	bxne lr
	add r0, r1, #0x600
	mov r1, #0
	strh r1, [r0, #0xe0]
	strh r1, [r0, #0xe2]
	str r1, [r2, #0x27c]
	bx lr
	arm_func_end ovl00_21767FC

	arm_func_start ovl00_2176834
ovl00_2176834: // 0x02176834
	ldrh r1, [r0, #0x34]
	add r1, r1, #0x800
	strh r1, [r0, #0x34]
	ldrh r1, [r0, #0x34]
	cmp r1, #0x5000
	movhs r1, #0
	strhs r1, [r0, #0xf4]
	bx lr
	arm_func_end ovl00_2176834

	arm_func_start ovl00_2176854
ovl00_2176854: // 0x02176854
	stmdb sp!, {r4, lr}
	ldr r1, [r1, #0x1c]
	ldr r2, [r0, #0x1c]
	cmp r1, #0
	cmpne r2, #0
	ldmeqia sp!, {r4, pc}
	ldrh r0, [r2]
	cmp r0, #3
	ldreq r0, [r2, #0x340]
	ldreqh r0, [r0, #2]
	cmpeq r0, #0xc2
	ldmneia sp!, {r4, pc}
	ldr r2, [r1, #0x20]
	ldr r0, _021768F8 // =ovl00_2176834
	bic r2, r2, #0x100
	str r2, [r1, #0x20]
	ldr r2, [r1, #0x18]
	ldr ip, _021768FC // =_mt_math_rand
	orr r2, r2, #2
	str r2, [r1, #0x18]
	str r0, [r1, #0xf4]
	ldr lr, [ip]
	ldr r0, _02176900 // =0x00196225
	ldr r2, _02176904 // =0x3C6EF35F
	ldr r3, _02176908 // =0x000001FF
	mla r4, lr, r0, r2
	mla r2, r4, r0, r2
	str r2, [ip]
	mov r0, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r2, r2, lsr #0x10
	ldr lr, [r1, #0x44]
	ldr r1, [r1, #0x48]
	mov r2, r2, lsl #0x10
	and ip, r3, r0, lsr #16
	sub r0, lr, #0x10000
	sub r1, r1, #0x30000
	and r2, r3, r2, lsr #16
	rsb r3, ip, #0
	bl EffectSnowslide__Create
	ldmia sp!, {r4, pc}
	.align 2, 0
_021768F8: .word ovl00_2176834
_021768FC: .word _mt_math_rand
_02176900: .word 0x00196225
_02176904: .word 0x3C6EF35F
_02176908: .word 0x000001FF
	arm_func_end ovl00_2176854

	.data
	
_02189798:
	.byte 0x00, 0xE0, 0x00, 0x00, 0x00, 0xD0, 0x00, 0x00
	.byte 0x00, 0x00, 0x04, 0x00, 0x00, 0x80, 0x04, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x80, 0x03, 0x00
	.byte 0x00, 0x00, 0x03, 0x00, 0x00, 0x80, 0x03, 0x00, 0x00, 0xA8, 0x00, 0x00, 0x00, 0xA0, 0x00, 0x00
	.byte 0x00, 0x01, 0x02, 0x00, 0x01, 0x02, 0x00, 0x01

aActAcDecIceTre: // 0x021897C8
	.asciz "/act/ac_dec_ice_tree.bac"
	.align 4