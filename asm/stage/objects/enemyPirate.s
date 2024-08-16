	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start EnemyPirate__Create
EnemyPirate__Create: // 0x02154E94
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	movs r8, r0
	mov r7, r1
	mov r6, r2
	beq _02154EC0
	ldrb r0, [r8]
	cmp r0, #0xff
	ldreqb r0, [r8, #1]
	cmpeq r0, #0xff
	beq _02154EE4
_02154EC0:
	ldr r0, _02155318 // =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _02154EE4
	ldrh r0, [r8, #4]
	tst r0, #0x80
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02154EE4:
	mov r0, #0x1500
	mov r2, #0
	str r0, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x3e8
	ldr r0, _0215531C // =StageTask_Main
	ldr r1, _02155320 // =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x3e8
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	ldrh r0, [r8, #2]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _021551EC
_02154F68: // jump table
	b _02154F7C // case 0
	b _02155020 // case 1
	b _02155064 // case 2
	b _021550C8 // case 3
	b _02155144 // case 4
_02154F7C:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #0
	orr r1, r1, #0xc0
	str r1, [r4, #0x1c]
	bl ovl00_2155378
	ldr r0, _02155324 // =ovl00_21553D0
	mov r2, r5
	str r0, [r4, #0x3ac]
	add r0, r4, #0x300
	strh r2, [r0, #0xc8]
	mov r1, #1
	strh r1, [r0, #0xca]
	rsb r1, r1, #0x10000
	strh r1, [r0, #0xcc]
	mov r2, #0xc00
	ldr r1, _02155328 // =ovl00_2155820
	str r2, [r4, #0x3d4]
	str r1, [r4, #0x3b0]
	mov r1, #0x200
	str r1, [r4, #0x3dc]
	mov r1, #0x4000
	str r1, [r4, #0x3e0]
	mov r1, #0xa
	strh r1, [r0, #0xe4]
	strh r1, [r0, #0xe6]
	mov r1, #2
	strh r1, [r0, #0xd8]
	ldrh r0, [r8, #4]
	tst r0, #0x40
	beq _021551EC
	ldr r0, _0215532C // =ovl00_21560E0
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x1c]
	bic r0, r0, #0x80
	orr r0, r0, #0x100
	str r0, [r4, #0x1c]
	b _021551EC
_02155020:
	ldr r0, [r4, #0x20]
	ldr r1, _02155330 // =ovl00_21557D8
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	mov r5, #1
	orr r0, r0, #0x100
	str r0, [r4, #0x1c]
	ldrh r0, [r8, #4]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	ldr r0, _02155334 // =ovl00_2155C5C
	str r1, [r4, #0x3ac]
	str r0, [r4, #0x3b0]
	b _021551EC
_02155064:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #2
	orr r1, r1, #0x140
	str r1, [r4, #0x1c]
	bl ovl00_2155378
	ldr r1, _02155338 // =ovl00_2155620
	add r0, r4, #0x300
	str r1, [r4, #0x3ac]
	mov r1, #0
	strh r1, [r0, #0xc8]
	mov r1, #4
	strh r1, [r0, #0xca]
	mov r1, #0xc00
	str r1, [r4, #0x3cc]
	mov r1, #0x1800
	str r1, [r4, #0x3d0]
	mov r2, #0x300
	ldr r1, _0215533C // =ovl00_21559D8
	strh r2, [r0, #0xd4]
	str r1, [r4, #0x3b0]
	b _021551EC
_021550C8:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #3
	orr r1, r1, #0xc0
	str r1, [r4, #0x1c]
	bl ovl00_2155378
	ldr r1, _02155324 // =ovl00_21553D0
	add r0, r4, #0x300
	str r1, [r4, #0x3ac]
	mov r2, #0
	strh r2, [r0, #0xc8]
	mov r1, #1
	strh r1, [r0, #0xca]
	mov r1, #2
	strh r1, [r0, #0xcc]
	mov r1, #0x78
	strh r1, [r0, #0xce]
	strh r2, [r0, #0xd0]
	mov r2, #0xc00
	ldr r1, _02155328 // =ovl00_2155820
	str r2, [r4, #0x3d4]
	str r1, [r4, #0x3b0]
	ldr r2, [r4, #0x354]
	mov r1, r5
	orr r2, r2, #0x8000
	str r2, [r4, #0x354]
	strh r1, [r0, #0xd8]
	b _021551EC
_02155144:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #4
	orr r1, r1, #0xc0
	str r1, [r4, #0x1c]
	bl ovl00_2155378
	ldr r0, _02155324 // =ovl00_21553D0
	mov r1, #0
	str r0, [r4, #0x3ac]
	add r0, r4, #0x300
	strh r1, [r0, #0xc8]
	mov r2, #5
	strh r2, [r0, #0xca]
	mov r2, #1
	strh r2, [r0, #0xcc]
	mov r2, #0xf0
	strh r2, [r0, #0xce]
	strh r1, [r0, #0xd0]
	mov r0, #0xc00
	ldr r3, _02155340 // =ovl00_2155E00
	str r0, [r4, #0x3d4]
	mov r2, r1
	add r0, r4, #0x298
	str r3, [r4, #0x3b0]
	bl ObjRect__SetAttackStat
	ldr r1, _02155344 // =0x0000FFFE
	add r0, r4, #0x298
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _02155348 // =0x00000102
	add r0, r4, #0x200
	strh r1, [r0, #0xcc]
	ldr r0, [r4, #0x2b0]
	ldr r1, _0215534C // =ovl00_2155FF0
	orr r0, r0, #0x400
	str r0, [r4, #0x2b0]
	mov r0, r4
	str r1, [r4, #0x2bc]
	bl EffectSteamBlasterSmoke__Create
_021551EC:
	ldr r0, _02155350 // =_021881A0
	add r1, r4, #0x300
	ldr r0, [r0, r5, lsl #2]
	strh r5, [r1, #0xc6]
	bl GetObjectFileWork
	ldr r1, _02155354 // =gameArchiveStage
	ldr r2, _02155358 // =0x0000FFFF
	ldr r3, [r1]
	ldr r1, _0215535C // =_02188B54
	str r3, [sp]
	str r2, [sp, #4]
	mov r3, r0
	ldr r2, [r1, r5, lsl #2]
	mov r0, r4
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r3, r5, lsl #1
	ldr r2, _02155360 // =_02188194
	ldrsh r2, [r2, r3]
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x1c]
	tst r0, #0x100
	bne _02155284
	mvn r6, #1
	mov r0, r4
	sub r1, r6, #6
	sub r2, r6, #8
	mov r3, #8
	str r6, [sp]
	bl StageTask__SetHitbox
_02155284:
	ldr r3, _02155364 // =0x021881BA
	mov r6, r5, lsl #3
	ldr r1, _02155368 // =_021881B4
	ldr r2, _0215536C // =0x021881B6
	ldr r0, _02155370 // =0x021881B8
	ldrsh r5, [r3, r6]
	ldrsh r1, [r1, r6]
	ldrsh r2, [r2, r6]
	ldrsh r3, [r0, r6]
	add r0, r4, #0x364
	str r5, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x364
	bl ObjRect__SetAttackStat
	ldr r1, _02155344 // =0x0000FFFE
	add r0, r4, #0x364
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _02155348 // =0x00000102
	add r0, r4, #0x300
	strh r1, [r0, #0x98]
	ldr r1, [r4, #0x37c]
	ldr r0, _02155374 // =ovl00_2156080
	orr r1, r1, #0x4c0
	str r1, [r4, #0x37c]
	str r0, [r4, #0x388]
	str r4, [r4, #0x380]
	ldr r1, [r4, #0x3ac]
	mov r0, r4
	blx r1
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02155318: .word gameState
_0215531C: .word StageTask_Main
_02155320: .word GameObject__Destructor
_02155324: .word ovl00_21553D0
_02155328: .word ovl00_2155820
_0215532C: .word ovl00_21560E0
_02155330: .word ovl00_21557D8
_02155334: .word ovl00_2155C5C
_02155338: .word ovl00_2155620
_0215533C: .word ovl00_21559D8
_02155340: .word ovl00_2155E00
_02155344: .word 0x0000FFFE
_02155348: .word 0x00000102
_0215534C: .word ovl00_2155FF0
_02155350: .word _021881A0
_02155354: .word gameArchiveStage
_02155358: .word 0x0000FFFF
_0215535C: .word _02188B54
_02155360: .word _02188194
_02155364: .word 0x021881BA
_02155368: .word _021881B4
_0215536C: .word 0x021881B6
_02155370: .word 0x021881B8
_02155374: .word ovl00_2156080
	arm_func_end EnemyPirate__Create

	arm_func_start ovl00_2155378
ovl00_2155378: // 0x02155378
	ldr r1, [r0, #0x340]
	ldr r2, [r0, #0x44]
	ldrsb r1, [r1, #6]
	add r2, r2, r1, lsl #12
	str r2, [r0, #0x3b4]
	ldr r1, [r0, #0x340]
	ldrb r1, [r1, #8]
	add r1, r2, r1, lsl #12
	str r1, [r0, #0x3bc]
	bx lr
	arm_func_end ovl00_2155378

	arm_func_start ovl00_21553A0
ovl00_21553A0: // 0x021553A0
	add r1, r0, #0x300
	ldrsh r2, [r1, #0xc4]
	cmp r2, #0
	bxeq lr
	sub r2, r2, #1
	strh r2, [r1, #0xc4]
	ldrsh r1, [r1, #0xc4]
	cmp r1, #0
	ldreq r1, [r0, #0x37c]
	orreq r1, r1, #4
	streq r1, [r0, #0x37c]
	bx lr
	arm_func_end ovl00_21553A0

	arm_func_start ovl00_21553D0
ovl00_21553D0: // 0x021553D0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r1, r4, #0x300
	ldrh r1, [r1, #0xc8]
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _0215544C // =ovl00_2155450
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r1, #0
	str r1, [r4, #0x2c]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	mov r0, #0x77
	str r1, [sp]
	sub r1, r0, #0x78
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215544C: .word ovl00_2155450
	arm_func_end ovl00_21553D0

	arm_func_start ovl00_2155450
ovl00_2155450: // 0x02155450
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r2, [r6, #0x354]
	add r4, r6, #0x3c8
	tst r2, #1
	mov r5, #0
	beq _021554A0
	ldr r1, [r6, #0x20]
	tst r1, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	bic r1, r2, #1
	str r1, [r6, #0x354]
	ldr r1, [r6, #0x20]
	eor r1, r1, #1
	str r1, [r6, #0x20]
	ldrh r1, [r4]
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
_021554A0:
	mov r0, r6
	bl ovl00_21553A0
	mov r0, r6
	add r1, r6, #0x364
	bl StageTask__HandleCollider
	ldrh r1, [r4, #4]
	ldr r0, _0215561C // =0x0000FFFF
	cmp r1, r0
	beq _02155590
	ldr r0, [r6, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, r1
	beq _02155524
	ldr r0, [r6, #0x2c]
	add r1, r0, #1
	str r1, [r6, #0x2c]
	ldrsh r0, [r4, #6]
	cmp r1, r0
	blt _02155590
	mov r0, #0
	str r0, [r6, #0xc8]
	ldrh r1, [r4, #4]
	mov r0, r6
	bl GameObject__SetAnimation
	ldrsh r0, [r4, #8]
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
	ldrsh r0, [r4, #8]
	str r0, [r6, #0x2c]
	ldmia sp!, {r4, r5, r6, pc}
_02155524:
	ldr r0, [r6, #0x20]
	tst r0, #4
	beq _02155568
	ldr r0, [r6, #0x2c]
	sub r0, r0, #1
	str r0, [r6, #0x2c]
	cmp r0, #0
	ldmgtia sp!, {r4, r5, r6, pc}
	mov r0, #0
	str r0, [r6, #0x2c]
	ldrh r1, [r4]
	mov r0, r6
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
	b _02155590
_02155568:
	tst r0, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, #0
	str r0, [r6, #0x2c]
	ldrh r1, [r4]
	mov r0, r6
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
_02155590:
	ldr r0, [r6, #0x20]
	tst r0, #1
	ldr r0, [r4, #0xc]
	rsbeq r0, r0, #0
	str r0, [r6, #0xc8]
	ldr r0, [r6, #0x1c]
	ldr r1, [r6, #0x44]
	tst r0, #4
	ldr r0, [r6, #0x3b4]
	movne r5, #1
	cmp r1, r0
	strlt r0, [r6, #0x44]
	movlt r5, #1
	blt _021555D8
	ldr r0, [r6, #0x3bc]
	cmp r1, r0
	strgt r0, [r6, #0x44]
	movgt r5, #1
_021555D8:
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r1, [r4, #2]
	ldr r0, _0215561C // =0x0000FFFF
	cmp r1, r0
	ldreq r0, [r6, #0x20]
	eoreq r0, r0, #1
	streq r0, [r6, #0x20]
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r6
	bl GameObject__SetAnimation
	mov r0, #0
	str r0, [r6, #0xc8]
	ldr r0, [r6, #0x354]
	orr r0, r0, #1
	str r0, [r6, #0x354]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215561C: .word 0x0000FFFF
	arm_func_end ovl00_2155450

	arm_func_start ovl00_2155620
ovl00_2155620: // 0x02155620
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r1, [r1, #0xc8]
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _0215564C // =ovl00_2155650
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215564C: .word ovl00_2155650
	arm_func_end ovl00_2155620

	arm_func_start ovl00_2155650
ovl00_2155650: // 0x02155650
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r2, [r6, #0x354]
	add r4, r6, #0x3c8
	tst r2, #1
	mov r5, #0
	beq _021556A8
	ldr r1, [r6, #0x20]
	tst r1, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	bic r1, r2, #1
	str r1, [r6, #0x354]
	ldr r1, [r6, #0x20]
	eor r1, r1, #1
	str r1, [r6, #0x20]
	ldrh r1, [r4]
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
_021556A8:
	ldr r0, [r6, #0x20]
	ldr r1, _021557D0 // =FX_SinCosTable_
	tst r0, #1
	ldr r0, [r4, #4]
	rsbeq r0, r0, #0
	str r0, [r6, #0xc8]
	ldrh r2, [r4, #0xe]
	ldrh r0, [r4, #0xc]
	add r0, r2, r0
	strh r0, [r4, #0xe]
	ldrh r2, [r4, #0xe]
	ldr r0, [r4, #8]
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r1, [r1, r2]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r6, #0x9c]
	ldr r0, [r6, #0x1c]
	ldr r1, [r6, #0x44]
	tst r0, #4
	ldr r0, [r6, #0x3b4]
	movne r5, #1
	cmp r1, r0
	strlt r0, [r6, #0x44]
	movlt r5, #1
	blt _02155730
	ldr r0, [r6, #0x3bc]
	cmp r1, r0
	strgt r0, [r6, #0x44]
	movgt r5, #1
_02155730:
	cmp r5, #0
	beq _02155774
	ldrh r1, [r4, #2]
	ldr r0, _021557D4 // =0x0000FFFF
	cmp r1, r0
	ldreq r0, [r6, #0x20]
	eoreq r0, r0, #1
	streq r0, [r6, #0x20]
	beq _02155774
	mov r0, r6
	bl GameObject__SetAnimation
	mov r0, #0
	str r0, [r6, #0xc8]
	str r0, [r6, #0x9c]
	ldr r0, [r6, #0x354]
	orr r0, r0, #1
	str r0, [r6, #0x354]
_02155774:
	mov r0, r6
	bl ovl00_21553A0
	mov r0, r6
	add r1, r6, #0x364
	bl StageTask__HandleCollider
	ldr r0, [r6, #0x20]
	tst r0, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r1, #0
	mov r0, #0x75
	str r1, [sp]
	sub r1, r0, #0x76
	str r0, [sp, #4]
	ldr r0, [r6, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r6, #0x138]
	add r1, r6, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021557D0: .word FX_SinCosTable_
_021557D4: .word 0x0000FFFF
	arm_func_end ovl00_2155650

	arm_func_start ovl00_21557D8
ovl00_21557D8: // 0x021557D8
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _02155800 // =ovl00_2155804
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155800: .word ovl00_2155804
	arm_func_end ovl00_21557D8

	arm_func_start ovl00_2155804
ovl00_2155804: // 0x02155804
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl00_21553A0
	mov r0, r4
	add r1, r4, #0x364
	bl StageTask__HandleCollider
	ldmia sp!, {r4, pc}
	arm_func_end ovl00_2155804

	arm_func_start ovl00_2155820
ovl00_2155820: // 0x02155820
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0xc8]
	add r2, r4, #0x3d8
	ldrsh r1, [r2, #0xc]
	cmp r1, #0
	beq _0215585C
	str r1, [r4, #0x2c]
	ldr r1, [r4, #0x20]
	ldr r0, _0215588C // =ovl00_2155894
	orr r1, r1, #0x10
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
_0215585C:
	ldrh r1, [r2]
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x354]
	ldr r1, _02155890 // =ovl00_21558F0
	tst r0, #0x8000
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #4
	streq r0, [r4, #0x20]
	mov r0, r4
	str r1, [r4, #0xf4]
	bl ovl00_2156100
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215588C: .word ovl00_2155894
_02155890: .word ovl00_21558F0
	arm_func_end ovl00_2155820

	arm_func_start ovl00_2155894
ovl00_2155894: // 0x02155894
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x2c]
	subs r1, r1, #1
	str r1, [r4, #0x2c]
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0x20]
	add r1, r4, #0x300
	bic r2, r2, #0x10
	str r2, [r4, #0x20]
	ldrh r1, [r1, #0xd8]
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x354]
	ldr r1, _021558EC // =ovl00_21558F0
	tst r0, #0x8000
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #4
	streq r0, [r4, #0x20]
	mov r0, r4
	str r1, [r4, #0xf4]
	bl ovl00_2156100
	ldmia sp!, {r4, pc}
	.align 2, 0
_021558EC: .word ovl00_21558F0
	arm_func_end ovl00_2155894

	arm_func_start ovl00_21558F0
ovl00_21558F0: // 0x021558F0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0x354]
	add r4, r6, #0x3d8
	tst r0, #0x8000
	mov r5, #0
	ldr r0, [r6, #0x20]
	bne _02155960
	tst r0, #1
	ldr r0, [r6, #0xc8]
	ldmib r4, {r1, r2}
	beq _02155928
	bl ObjSpdUpSet
	b _02155930
_02155928:
	rsb r1, r1, #0
	bl ObjSpdUpSet
_02155930:
	str r0, [r6, #0xc8]
	ldr r0, [r6, #0x3b4]
	ldr r1, [r6, #0x44]
	cmp r1, r0
	strlt r0, [r6, #0x44]
	movlt r5, #1
	blt _02155968
	ldr r0, [r6, #0x3bc]
	cmp r1, r0
	strgt r0, [r6, #0x44]
	movgt r5, #1
	b _02155968
_02155960:
	tst r0, #8
	movne r5, #1
_02155968:
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrsh r0, [r4, #0xe]
	cmp r0, #0
	beq _02155998
	mov r0, #0
	str r0, [r6, #0xc8]
	ldrsh r1, [r4, #0xe]
	ldr r0, _021559A8 // =ovl00_21559AC
	str r1, [r6, #0x2c]
	str r0, [r6, #0xf4]
	ldmia sp!, {r4, r5, r6, pc}
_02155998:
	ldr r1, [r6, #0x3ac]
	mov r0, r6
	blx r1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021559A8: .word ovl00_21559AC
	arm_func_end ovl00_21558F0

	arm_func_start ovl00_21559AC
ovl00_21559AC: // 0x021559AC
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x2c]
	subs r1, r1, #1
	str r1, [r0, #0x2c]
	ldmneia sp!, {r3, pc}
	ldr r1, [r0, #0x20]
	bic r1, r1, #0x10
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x3ac]
	blx r1
	ldmia sp!, {r3, pc}
	arm_func_end ovl00_21559AC

	arm_func_start ovl00_21559D8
ovl00_21559D8: // 0x021559D8
	stmdb sp!, {r4, lr}
	mov r1, #0
	mov r4, r0
	str r1, [r4, #0x9c]
	str r1, [r4, #0x98]
	str r1, [r4, #0xc8]
	ldr r3, [r4, #0x3a8]
	ldr r0, [r4, #0x48]
	ldr r2, [r4, #0x3a4]
	ldr r1, [r4, #0x44]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	strh r0, [r4, #0x34]
	ldr r0, [r4, #0x44]
	mov r2, #0x3000
	str r0, [r4, #0x3d8]
	ldr r1, [r4, #0x48]
	mov r0, r4
	str r1, [r4, #0x3dc]
	ldr r1, [r4, #0x354]
	rsb r2, r2, #0
	bic r1, r1, #0x8000
	str r1, [r4, #0x354]
	mov r1, #1
	str r2, [r4, #0xc8]
	bl GameObject__SetAnimation
	ldr r0, _02155A50 // =ovl00_2155A54
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155A50: .word ovl00_2155A54
	arm_func_end ovl00_21559D8

	arm_func_start ovl00_2155A54
ovl00_2155A54: // 0x02155A54
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0xc8]
	mov r1, #0x200
	bl ObjSpdDownSet
	str r0, [r4, #0xc8]
	ldr r0, [r4, #0x20]
	tst r0, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #2
	bl GameObject__SetAnimation
	ldr r2, _02155AC0 // =ovl00_2155AC4
	mov r0, #0x76
	sub r1, r0, #0x77
	str r2, [r4, #0xf4]
	mov r2, #0
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155AC0: .word ovl00_2155AC4
	arm_func_end ovl00_2155A54

	arm_func_start ovl00_2155AC4
ovl00_2155AC4: // 0x02155AC4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x354]
	mov r4, #0
	tst r0, #0x8000
	ldr r1, [r5, #0x48]
	beq _02155B60
	ldr r0, [r5, #0x3dc]
	cmp r1, r0
	bgt _02155B38
	ldr r0, [r5, #0x20]
	ands r2, r0, #1
	beq _02155B08
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x3d8]
	cmp r1, r0
	ble _02155B20
_02155B08:
	cmp r2, #0
	bne _02155B38
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x3d8]
	cmp r1, r0
	blt _02155B38
_02155B20:
	mov r0, #0
	str r0, [r5, #0xc8]
	ldr r0, [r5, #0x20]
	tst r0, #8
	movne r4, #1
	b _02155BB8
_02155B38:
	ldr r0, [r5, #0x20]
	tst r0, #8
	movne r0, #0x3000
	strne r0, [r5, #0xc8]
	bne _02155BB8
	ldr r0, [r5, #0xc8]
	ldr r1, _02155C54 // =0x00000199
	bl ObjSpdDownSet
	str r0, [r5, #0xc8]
	b _02155BB8
_02155B60:
	ldr r0, [r5, #0x3a8]
	cmp r1, r0
	blt _02155BA4
	ldr r0, [r5, #0x20]
	ands r2, r0, #1
	beq _02155B88
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x3a4]
	cmp r1, r0
	bge _02155BA0
_02155B88:
	cmp r2, #0
	bne _02155BA4
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x3a4]
	cmp r1, r0
	bgt _02155BA4
_02155BA0:
	mov r4, #1
_02155BA4:
	ldr r0, [r5, #0xc8]
	mov r1, #0x400
	mov r2, #0x6000
	bl ObjSpdUpSet
	str r0, [r5, #0xc8]
_02155BB8:
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x354]
	tst r0, #0x8000
	beq _02155C10
	ldr r0, [r5, #0x3d8]
	mov r1, #0
	str r0, [r5, #0x44]
	ldr r0, [r5, #0x3dc]
	mov r2, #0xa
	str r0, [r5, #0x48]
	str r1, [r5, #0xc8]
	strh r1, [r5, #0x34]
	mov r0, r5
	str r2, [r5, #0x2c]
	bl GameObject__SetAnimation
	ldr r1, [r5, #0x20]
	ldr r0, _02155C58 // =ovl00_21559AC
	orr r1, r1, #0x10
	str r1, [r5, #0x20]
	str r0, [r5, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
_02155C10:
	mov r0, #0x3000
	str r0, [r5, #0xc8]
	ldrh r2, [r5, #0x34]
	mov r1, #0x8000
	mov r0, r5
	add r2, r2, #0x8000
	strh r2, [r5, #0x34]
	str r1, [r5, #8]
	ldr r2, [r5, #0x354]
	mov r1, #3
	orr r2, r2, #0x8000
	str r2, [r5, #0x354]
	bl GameObject__SetAnimation
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02155C54: .word 0x00000199
_02155C58: .word ovl00_21559AC
	arm_func_end ovl00_2155AC4

	arm_func_start ovl00_2155C5C
ovl00_2155C5C: // 0x02155C5C
	mov r1, #0
	str r1, [r0, #0xc8]
	str r1, [r0, #0x28]
	mov r2, #3
	ldr r1, _02155C7C // =ovl00_2155C80
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_02155C7C: .word ovl00_2155C80
	arm_func_end ovl00_2155C5C

	arm_func_start ovl00_2155C80
ovl00_2155C80: // 0x02155C80
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x28]
	cmp r2, #0
	beq _02155CA8
	cmp r2, #1
	beq _02155D18
	cmp r2, #2
	beq _02155DD0
	ldmia sp!, {r4, pc}
_02155CA8:
	mov r1, #0x3000
	str r1, [r4, #0x9c]
	ldr r1, [r4, #0x2c]
	subs r1, r1, #1
	str r1, [r4, #0x2c]
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0x28]
	mov r1, #0
	add r2, r2, #1
	str r2, [r4, #0x28]
	str r1, [r4, #0x98]
	sub r1, r1, #0x6000
	str r1, [r4, #0x9c]
	ldr r2, [r4, #0x1c]
	mov r1, #1
	orr r2, r2, #0x80
	str r2, [r4, #0x1c]
	bl GameObject__SetAnimation
	ldr r0, _02155DFC // =mapCamera
	mov r1, #0
	ldrh r3, [r0, #0x6e]
	mov r0, r4
	mov r2, r1
	bl CreateEffectWaterSplash
	ldr r0, [r4, #0x354]
	orr r0, r0, #0x8000
	str r0, [r4, #0x354]
	ldmia sp!, {r4, pc}
_02155D18:
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	ldmleia sp!, {r4, pc}
	ldr r0, [r4, #0x34c]
	ldr r1, [r4, #0x48]
	add r0, r0, #0x10000
	cmp r1, r0
	blt _02155D90
	add r0, r2, #1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x20]
	mov r1, #0x2800
	eor r0, r0, #1
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	rsb r1, r1, #0
	bic r0, r0, #0x80
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	tst r0, #1
	mov r0, #0x800
	rsbeq r0, r0, #0
	str r0, [r4, #0x98]
	str r1, [r4, #0x9c]
	mov r0, r4
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
_02155D90:
	ldr r0, [r4, #0x354]
	tst r0, #0x8000
	ldmeqia sp!, {r4, pc}
	ldr r0, _02155DFC // =mapCamera
	ldr r1, [r4, #0x48]
	ldrh r3, [r0, #0x6e]
	cmp r1, r3, lsl #12
	ldmltia sp!, {r4, pc}
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl CreateEffectWaterSplash
	ldr r0, [r4, #0x354]
	bic r0, r0, #0x8000
	str r0, [r4, #0x354]
	ldmia sp!, {r4, pc}
_02155DD0:
	ldr r2, [r4, #0x34c]
	ldr r1, [r4, #0x48]
	cmp r1, r2
	ldmgtia sp!, {r4, pc}
	mov r1, #0
	str r2, [r4, #0x48]
	str r1, [r4, #0x9c]
	str r1, [r4, #0x98]
	ldr r1, [r4, #0x3ac]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155DFC: .word mapCamera
	arm_func_end ovl00_2155C80

	arm_func_start ovl00_2155E00
ovl00_2155E00: // 0x02155E00
	stmdb sp!, {r4, lr}
	mov r1, #0
	mov r4, r0
	str r1, [r4, #0x9c]
	str r1, [r4, #0x98]
	str r1, [r4, #0xc8]
	ldr r3, [r4, #0x20]
	sub r2, r1, #0x40000
	orr r3, r3, #0x10
	str r3, [r4, #0x20]
	bl CreateEffectFound
	mov r1, #0xc
	ldr r0, _02155E40 // =ovl00_2155E44
	str r1, [r4, #0x2c]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155E40: .word ovl00_2155E44
	arm_func_end ovl00_2155E00

	arm_func_start ovl00_2155E44
ovl00_2155E44: // 0x02155E44
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x2c]
	subs r1, r1, #1
	str r1, [r4, #0x2c]
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0x20]
	mov r1, #2
	bic r2, r2, #0x10
	str r2, [r4, #0x20]
	bl GameObject__SetAnimation
	ldr r0, _02155E7C // =ovl00_2155E80
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155E7C: .word ovl00_2155E80
	arm_func_end ovl00_2155E44

	arm_func_start ovl00_2155E80
ovl00_2155E80: // 0x02155E80
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x128]
	ldrh r1, [r1, #0xc]
	cmp r1, #2
	beq _02155EA8
	cmp r1, #3
	beq _02155F4C
	b _02155FD0
_02155EA8:
	ldr r1, [r4, #0x20]
	tst r1, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #3
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, #0x78
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0x2c]
	mov r1, #0
	str r4, [r4, #0x2b4]
	ldr r0, [r4, #0x2b0]
	mov r2, r1
	orr r0, r0, #4
	str r0, [r4, #0x2b0]
	mov r3, r1
	add r0, r4, #0x298
	str r1, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0x21000
	rsb r1, r1, #0
	mov r0, r4
	add r2, r1, #0x2000
	mov r3, #0x78
	bl EffectSteamBlasterSteam__Create
	mov r0, #0
	str r0, [sp]
	mov r0, #0x83
	sub r1, r0, #0x84
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02155F4C:
	ldr r1, [r4, #0x2c]
	subs r1, r1, #1
	str r1, [r4, #0x2c]
	beq _02155FAC
	rsb r1, r1, #0x78
	mov r0, #0xc
	mul r2, r1, r0
	mvn r3, #0xf
	cmp r2, #0x48
	movgt r2, #0x48
	sub r0, r3, #0x11
	sub r0, r0, r2
	mov r1, r0, lsl #0x10
	str r3, [sp]
	sub r2, r3, #0x18
	add r0, r4, #0x298
	mov r1, r1, asr #0x10
	sub r3, r3, #0x11
	bl ObjRect__SetBox2D
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02155FAC:
	mov r1, #4
	bl GameObject__SetAnimation
	mov r0, #0
	str r0, [r4, #0x2b4]
	ldr r0, [r4, #0x138]
	mov r1, #0x20
	bl NNS_SndPlayerStopSeq
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02155FD0:
	ldr r1, [r4, #0x20]
	tst r1, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3ac]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl00_2155E80

	arm_func_start ovl00_2155FF0
ovl00_2155FF0: // 0x02155FF0
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r4, [r1, #0x1c]
	ldr r3, [r0, #0x1c]
	cmp r4, #0
	cmpne r3, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r2, [r3]
	cmp r2, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r2, [r3, #0x5d8]
	tst r2, #0x80
	beq _02156038
	bl ObjRect__FuncNoHit
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_02156038:
	ldr r5, [r4, #0x48]
	ldr r0, [r3, #0x48]
	mov r2, #0x5000
	str r0, [r4, #0x48]
	ldr r0, [r4, #0x20]
	mov ip, #0
	tst r0, #1
	mov r0, #0x60000
	str r0, [sp]
	mov r0, r3
	rsbeq r2, r2, #0
	mov r1, r4
	sub r3, ip, #0x1000
	str ip, [sp, #4]
	bl Player__Gimmick_201E7DC
	str r5, [r4, #0x48]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl00_2155FF0

	arm_func_start ovl00_2156080
ovl00_2156080: // 0x02156080
	stmdb sp!, {r3, lr}
	ldr ip, [r1, #0x1c]
	ldr r2, [r0, #0x1c]
	ldr r0, [ip, #0x18]
	tst r0, #2
	ldmneia sp!, {r3, pc}
	ldr r0, [r2, #0x44]
	add r1, ip, #0x300
	str r0, [ip, #0x3a4]
	ldr r0, [r2, #0x48]
	ldr r2, _021560DC // =_02188B48
	str r0, [ip, #0x3a8]
	ldr r3, [ip, #0x37c]
	mov r0, ip
	bic r3, r3, #4
	str r3, [ip, #0x37c]
	ldrh r3, [r1, #0xc6]
	mov r3, r3, lsl #1
	ldrsh r2, [r2, r3]
	strh r2, [r1, #0xc4]
	ldr r1, [ip, #0x3b0]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_021560DC: .word _02188B48
	arm_func_end ovl00_2156080

	arm_func_start ovl00_21560E0
ovl00_21560E0: // 0x021560E0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl SetTutorialEnemyDestroy
	mov r0, r5
	mov r1, r4
	bl GameObject__OnDefend_Enemy
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl00_21560E0

	arm_func_start ovl00_2156100
ovl00_2156100: // 0x02156100
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0215612C
	cmp r0, #3
	beq _02156164
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215612C:
	mov r1, #0
	mov r0, #0x78
	str r1, [sp]
	sub r1, r0, #0x79
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02156164:
	mov r0, #0xf0
	mov r3, r4
	str r0, [sp]
	mov ip, #0x30
	mov r0, #0
	mov r1, #0x84
	mov r2, #0xf
	str ip, [sp, #4]
	bl CreateManagedSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl00_2156100

	.rodata

.public _02188194
_02188194: // 0x02188194
    .hword 0x14, 0x15, 0x14, 0x25, 0x24, 0

.public _021881A0
_021881A0: // 0x021881A0
    .word 3, 4, 5, 6, 7

.public _021881B4
_021881B4: // 0x021881B4
    .hword 0xFF76, 0xFFD8, 0xFFF6, 0xFFF8
	.hword 0xFF42, 0xFFB8, 0xFFF6, 0xFFF8
	.hword 0xFF9C, 0x1E, 0xFFEC, 0x80
	.hword 0xFF92, 0xFFB8, 0xFFF6, 0xFFF8
	.hword 0xFF92, 0xFFB8, 0xFFF6, 0xFFF8

	.data

_02188B48:
	.word 0x1E0078, 0xF0003C, 0x78

_02188B54:
	.word aActAcEneTriBac 	// "/act/ac_ene_tri.bac"
	.word aActAcEneFlyFis  	// "/act/ac_ene_fly_fish.bac"
	.word aActAcEnePteraB  	// "/act/ac_ene_ptera.bac"
	.word aActAcEneProtSp  	// "/act/ac_ene_prot_span.bac"
	.word aActAcEneProtDa_0	// "/act/ac_ene_prot_damp.bac"

aActAcEneTriBac: // 0x02188B68
	.asciz "/act/ac_ene_tri.bac"
	.align 4
	
aActAcEnePteraB: // 0x02188B7C
	.asciz "/act/ac_ene_ptera.bac"
	.align 4
	
aActAcEneFlyFis: // 0x02188B94
	.asciz "/act/ac_ene_fly_fish.bac"
	.align 4
	
aActAcEneProtSp: // 0x02188BB0
	.asciz "/act/ac_ene_prot_span.bac"
	.align 4
	
aActAcEneProtDa_0: // 0x02188BCC
	.asciz "/act/ac_ene_prot_damp.bac"
	.align 4