	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start EnemySkymoon__Create
EnemySkymoon__Create: // 0x0215CFD8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r7, r0
	mov r6, r1
	mov r5, r2
	beq _0215D004
	ldrb r0, [r7]
	cmp r0, #0xff
	ldreqb r0, [r7, #1]
	cmpeq r0, #0xff
	beq _0215D028
_0215D004:
	ldr r0, _0215D208 // =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _0215D028
	ldrh r0, [r7, #4]
	tst r0, #0x80
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
_0215D028:
	mov r0, #0x1500
	mov r2, #0
	str r0, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x3b4
	ldr r0, _0215D20C // =StageTask_Main
	ldr r1, _0215D210 // =GameObject__Destructor
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
	mov r2, #0x3b4
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r0, [r4, #0x20]
	ldr r5, _0215D214 // =0x0000FFFF
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x8100
	str r0, [r4, #0x1c]
	ldrh r0, [r7, #2]
	cmp r0, #0x17
	bne _0215D104
	mov r0, #0x17
	bl GetObjectFileWork
	ldr r1, _0215D218 // =gameArchiveStage
	mov r3, r0
	ldr r0, [r1]
	ldr r2, _0215D21C // =aActAcEneSkymoo
	str r0, [sp]
	mov r0, r4
	add r1, r4, #0x168
	str r5, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x64
	bl ObjActionAllocSpritePalette
	b _0215D1A0
_0215D104:
	mov r0, #0x18
	bl GetObjectFileWork
	ldr r1, _0215D218 // =gameArchiveStage
	mov r3, r0
	ldr r0, [r1]
	ldr r2, _0215D220 // =aActAcEneLaserS
	str r0, [sp]
	mov r0, r4
	add r1, r4, #0x168
	str r5, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x65
	bl ObjActionAllocSpritePalette
	mov r0, #0x60
	str r0, [sp]
	sub r1, r0, #0x120
	add r0, r4, #0x364
	mov r2, #0
	mov r3, #0xc0
	bl ObjRect__SetBox2D
	mov r1, #0
	add r0, r4, #0x364
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x364
	sub r1, r5, #1
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _0215D224 // =0x00000102
	add r0, r4, #0x300
	strh r1, [r0, #0x98]
	ldr r1, [r4, #0x37c]
	ldr r0, _0215D228 // =EnemySkymoon__OnDefend_215D6A4
	orr r1, r1, #0xc0
	str r1, [r4, #0x37c]
	str r0, [r4, #0x388]
	str r4, [r4, #0x380]
_0215D1A0:
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	ldrh r0, [r7, #4]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	ldrb r0, [r7, #8]
	cmp r0, #0
	beq _0215D1F4
	ldrsb r0, [r7, #6]
	ldr r1, [r4, #0x44]
	add r1, r1, r0, lsl #12
	str r1, [r4, #0x3a4]
	ldrb r0, [r7, #8]
	add r0, r1, r0, lsl #12
	str r0, [r4, #0x3a8]
_0215D1F4:
	mov r0, r4
	bl EnemySkymoon__Func_215D390
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215D208: .word gameState
_0215D20C: .word StageTask_Main
_0215D210: .word GameObject__Destructor
_0215D214: .word 0x0000FFFF
_0215D218: .word gameArchiveStage
_0215D21C: .word aActAcEneSkymoo
_0215D220: .word aActAcEneLaserS
_0215D224: .word 0x00000102
_0215D228: .word EnemySkymoon__OnDefend_215D6A4
	arm_func_end EnemySkymoon__Create

	arm_func_start EnemySkymoonLaser__Create
EnemySkymoonLaser__Create: // 0x0215D22C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _0215D358 // =StageTask_Main
	ldr r1, _0215D35C // =GameObject__Destructor
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
	ldr r1, [r4, #0x20]
	mov r0, #0x18
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0xa100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0215D360 // =gameArchiveStage
	mov r1, #8
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _0215D364 // =aActAcEneLaserS
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #3
	mov r2, #0x1f
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #3
	bl GameObject__SetAnimation
	ldrh r0, [r7, #4]
	ldr r1, _0215D368 // =EnemySkymoonLaser__State_215D750
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215D358: .word StageTask_Main
_0215D35C: .word GameObject__Destructor
_0215D360: .word gameArchiveStage
_0215D364: .word aActAcEneLaserS
_0215D368: .word EnemySkymoonLaser__State_215D750
	arm_func_end EnemySkymoonLaser__Create

	arm_func_start EnemySkymoon__Func_215D36C
EnemySkymoon__Func_215D36C: // 0x0215D36C
	ldr r1, [r0, #0x3ac]
	cmp r1, #0
	bxeq lr
	subs r1, r1, #1
	str r1, [r0, #0x3ac]
	ldreq r1, [r0, #0x37c]
	orreq r1, r1, #4
	streq r1, [r0, #0x37c]
	bx lr
	arm_func_end EnemySkymoon__Func_215D36C

	arm_func_start EnemySkymoon__Func_215D390
EnemySkymoon__Func_215D390: // 0x0215D390
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x3a4]
	cmp r1, #0
	beq _0215D3AC
	bl EnemySkymoon__Func_215D414
	ldmia sp!, {r4, pc}
_0215D3AC:
	add r1, r4, #0x100
	ldrh r1, [r1, #0x74]
	cmp r1, #0
	beq _0215D3C4
	mov r1, #0
	bl GameObject__SetAnimation
_0215D3C4:
	ldr r1, [r4, #0x20]
	ldr r0, _0215D3DC // =EnemySkymoon__State_215D3E0
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D3DC: .word EnemySkymoon__State_215D3E0
	arm_func_end EnemySkymoon__Func_215D390

	arm_func_start EnemySkymoon__State_215D3E0
EnemySkymoon__State_215D3E0: // 0x0215D3E0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl EnemySkymoon__Func_215D50C
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x18
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl EnemySkymoon__Func_215D36C
	mov r0, r4
	add r1, r4, #0x364
	bl StageTask__HandleCollider
	ldmia sp!, {r4, pc}
	arm_func_end EnemySkymoon__State_215D3E0

	arm_func_start EnemySkymoon__Func_215D414
EnemySkymoon__Func_215D414: // 0x0215D414
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x100
	ldrh r1, [r1, #0x74]
	cmp r1, #0
	beq _0215D434
	mov r1, #0
	bl GameObject__SetAnimation
_0215D434:
	ldr r1, [r4, #0x20]
	ldr r0, _0215D44C // =EnemySkymoon__Func_215D450
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D44C: .word EnemySkymoon__Func_215D450
	arm_func_end EnemySkymoon__Func_215D414

	arm_func_start EnemySkymoon__Func_215D450
EnemySkymoon__Func_215D450: // 0x0215D450
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl EnemySkymoon__Func_215D50C
	ldr r0, [r4, #0x20]
	ldr r1, [r4, #0x44]
	tst r0, #1
	beq _0215D4A8
	ldr r0, [r4, #0x3a8]
	cmp r1, r0
	blt _0215D490
	mov r0, #0
	str r0, [r4, #0x98]
	ldr r0, [r4, #0x20]
	eor r0, r0, #1
	str r0, [r4, #0x20]
	b _0215D4E4
_0215D490:
	ldr r0, [r4, #0x98]
	mov r1, #0x200
	mov r2, #0x800
	bl ObjSpdUpSet
	str r0, [r4, #0x98]
	b _0215D4E4
_0215D4A8:
	ldr r0, [r4, #0x3a4]
	cmp r1, r0
	bgt _0215D4CC
	mov r0, #0
	str r0, [r4, #0x98]
	ldr r0, [r4, #0x20]
	eor r0, r0, #1
	str r0, [r4, #0x20]
	b _0215D4E4
_0215D4CC:
	mov r1, #0x200
	ldr r0, [r4, #0x98]
	rsb r1, r1, #0
	mov r2, #0x800
	bl ObjSpdUpSet
	str r0, [r4, #0x98]
_0215D4E4:
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x18
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl EnemySkymoon__Func_215D36C
	mov r0, r4
	add r1, r4, #0x364
	bl StageTask__HandleCollider
	ldmia sp!, {r4, pc}
	arm_func_end EnemySkymoon__Func_215D450

	arm_func_start EnemySkymoon__Func_215D50C
EnemySkymoon__Func_215D50C: // 0x0215D50C
	add r1, r0, #0x300
	ldrh ip, [r1, #0xb0]
	ldr r3, _0215D558 // =FX_SinCosTable_
	mov r2, #0x800
	add ip, ip, #0x100
	strh ip, [r1, #0xb0]
	ldrh r1, [r1, #0xb0]
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r3, [r3, r1]
	mov r1, r3, asr #0x1f
	mov r1, r1, lsl #0xa
	adds r2, r2, r3, lsl #10
	orr r1, r1, r3, lsr #22
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x9c]
	bx lr
	.align 2, 0
_0215D558: .word FX_SinCosTable_
	arm_func_end EnemySkymoon__Func_215D50C

	arm_func_start EnemySkymoon__Func_215D55C
EnemySkymoon__Func_215D55C: // 0x0215D55C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #1
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x1c]
	ldr r0, _0215D58C // =EnemySkymoon__State_215D590
	orr r1, r1, #0x2000
	str r1, [r4, #0x1c]
	str r0, [r4, #0xf4]
	mov r0, #0
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D58C: .word EnemySkymoon__State_215D590
	arm_func_end EnemySkymoon__Func_215D55C

	arm_func_start EnemySkymoon__State_215D590
EnemySkymoon__State_215D590: // 0x0215D590
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r2, [r4, #0x28]
	cmp r2, #0
	beq _0215D5C0
	cmp r2, #1
	beq _0215D644
	cmp r2, #2
	beq _0215D678
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
_0215D5C0:
	ldr r1, [r4, #0x20]
	tst r1, #8
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	add r1, r2, #1
	str r1, [r4, #0x28]
	mov r1, #0xf
	str r1, [r4, #0x2c]
	mov r1, #2
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x20]
	mov ip, #0xf000
	ands r0, r0, #1
	movne r3, #1
	moveq r3, #0
	cmp r0, #0
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r2, [r4, #0x48]
	mov r3, r3, lsl #0x10
	ldr r1, [r4, #0x44]
	rsbeq ip, ip, #0
	ldr r0, _0215D6A0 // =0x0000015D
	add r1, r1, ip
	sub r2, r2, #0x1000
	mov r3, r3, lsr #0x10
	bl GameObject__SpawnObject
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
_0215D644:
	ldr r1, [r4, #0x2c]
	sub r1, r1, #1
	cmp r1, #0
	addgt sp, sp, #0x14
	str r1, [r4, #0x2c]
	ldmgtia sp!, {r3, r4, pc}
	ldr r2, [r4, #0x28]
	mov r1, #1
	add r2, r2, #1
	str r2, [r4, #0x28]
	bl GameObject__SetAnimation
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
_0215D678:
	ldr r1, [r4, #0x20]
	tst r1, #8
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	ldr r1, [r4, #0x1c]
	bic r1, r1, #0x2000
	str r1, [r4, #0x1c]
	bl EnemySkymoon__Func_215D390
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0215D6A0: .word 0x0000015D
	arm_func_end EnemySkymoon__State_215D590

	arm_func_start EnemySkymoon__OnDefend_215D6A4
EnemySkymoon__OnDefend_215D6A4: // 0x0215D6A4
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	ldr r4, [r5, #0x1c]
	mov r6, r0
	ldr r0, [r4, #0x18]
	ldr r1, [r6, #0x1c]
	tst r0, #2
	ldreq r0, [r4, #0x340]
	ldreqh r0, [r0, #2]
	cmpeq r0, #0x18
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r3, [r1, #0x48]
	ldr r0, [r4, #0x48]
	ldr r2, [r1, #0x44]
	ldr r1, [r4, #0x44]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	ldr r1, _0215D748 // =0x00001555
	cmp r0, r1
	blo _0215D738
	ldr r1, _0215D74C // =0x00006AAA
	cmp r0, r1
	bhi _0215D738
	mov r1, #0x78
	str r1, [r4, #0x3ac]
	ldr r1, [r4, #0x37c]
	cmp r0, #0x4000
	bic r0, r1, #4
	str r0, [r4, #0x37c]
	ldr r0, [r4, #0x20]
	orrls r0, r0, #1
	bichi r0, r0, #1
	str r0, [r4, #0x20]
	mov r0, r4
	bl EnemySkymoon__Func_215D55C
	ldmia sp!, {r4, r5, r6, pc}
_0215D738:
	mov r0, r6
	mov r1, r5
	bl ObjRect__FuncNoHit
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215D748: .word 0x00001555
_0215D74C: .word 0x00006AAA
	arm_func_end EnemySkymoon__OnDefend_215D6A4

	arm_func_start EnemySkymoonLaser__State_215D750
EnemySkymoonLaser__State_215D750: // 0x0215D750
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x20]
	tst r1, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #4
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x20]
	tst r0, #1
	mov r0, #0x2000
	rsbeq r0, r0, #0
	str r0, [r4, #0x98]
	mov r0, #0x2000
	str r0, [r4, #0x9c]
	ldr r1, [r4, #0x1c]
	mov r0, #0
	bic r1, r1, #0x2000
	str r1, [r4, #0x1c]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	arm_func_end EnemySkymoonLaser__State_215D750

	.data
	
aActAcEneSkymoo: // 0x02188DC4
	.asciz "/act/ac_ene_skymoon.bac"
	.align 4
	
aActAcEneLaserS: // 0x02188DDC
	.asciz "/act/ac_ene_laser_skymoon.bac"
	.align 4