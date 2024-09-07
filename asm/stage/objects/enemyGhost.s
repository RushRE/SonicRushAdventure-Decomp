	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start EnemyGhost__Create
EnemyGhost__Create: // 0x02157370
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r7, r0
	mov r6, r1
	mov r5, r2
	beq _0215739C
	ldrb r0, [r7]
	cmp r0, #0xff
	ldreqb r0, [r7, #1]
	cmpeq r0, #0xff
	beq _021573C0
_0215739C:
	ldr r0, _02157608 // =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _021573C0
	ldrh r0, [r7, #4]
	tst r0, #0x80
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
_021573C0:
	mov r0, #0x1500
	str r0, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _0215760C // =0x0000047C
	ldr r0, _02157610 // =StageTask_Main
	ldr r1, _02157614 // =EnemyGhost__Destructor
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
	ldr r2, _0215760C // =0x0000047C
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x20]
	add r0, r4, #0x78
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x478]
	orr r1, r1, #0x100
	str r1, [r4, #0x478]
	ldrh r1, [r7, #4]
	tst r1, #1
	beq _02157480
	ldr r1, [r4, #0x20]
	orr r1, r1, #1
	str r1, [r4, #0x20]
	ldr r1, [r0, #0x400]
	orr r1, r1, #1
	str r1, [r0, #0x400]
_02157480:
	ldr r0, _02157618 // =EnemyGhost__Draw
	mov r2, #0
	str r0, [r4, #0xfc]
	ldr r0, [r4, #0x340]
	ldr r1, [r4, #0x44]
	ldrsb r0, [r0, #6]
	mov r5, #0x80
	mov r3, r2
	add r7, r1, r0, lsl #12
	str r7, [r4, #0x3b0]
	ldr r0, [r4, #0x340]
	sub r1, r5, #0xd0
	ldrb r6, [r0, #8]
	add r0, r4, #0x364
	add r6, r7, r6, lsl #12
	str r6, [r4, #0x3b8]
	str r5, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x364
	bl ObjRect__SetAttackStat
	ldr r1, _0215761C // =0x0000FFFE
	add r0, r4, #0x364
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _02157620 // =0x00000102
	add r0, r4, #0x300
	strh r1, [r0, #0x98]
	ldr r1, [r4, #0x37c]
	ldr r0, _02157624 // =EnemyGhost__OnDefend
	orr r1, r1, #0xc0
	str r1, [r4, #0x37c]
	str r0, [r4, #0x388]
	mov r0, #0xb
	str r4, [r4, #0x380]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02157628 // =gameArchiveStage
	ldr r1, _0215762C // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02157630 // =aActAcEneBGhost
	add r1, r4, #0x3c8
	bl ObjObjectAction2dBACLoad
	mov r0, #0xb
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02157628 // =gameArchiveStage
	ldr r1, _0215762C // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02157630 // =aActAcEneBGhost
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	add r0, r4, #0x3c8
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x3c8
	mov r1, #2
	bl StageTask__SetOAMPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x31
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x128]
	add r1, r4, #0x400
	ldrh r2, [r0, #0x90]
	mov r0, r4
	strh r2, [r1, #0x58]
	ldr r2, [r4, #0x128]
	ldrh r2, [r2, #0x92]
	strh r2, [r1, #0x5a]
	ldr r2, [r4, #0x128]
	ldrh r2, [r2, #0x50]
	strh r2, [r1, #0x18]
	ldr r1, [r4, #0x404]
	orr r1, r1, #0x10
	str r1, [r4, #0x404]
	bl EnemyGhost__Func_215799C
	mov r1, #0
	strb r1, [r4, #0x3c2]
	mov r0, r4
	str r1, [r4, #0x3c4]
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02157608: .word gameState
_0215760C: .word 0x0000047C
_02157610: .word StageTask_Main
_02157614: .word EnemyGhost__Destructor
_02157618: .word EnemyGhost__Draw
_0215761C: .word 0x0000FFFE
_02157620: .word 0x00000102
_02157624: .word EnemyGhost__OnDefend
_02157628: .word gameArchiveStage
_0215762C: .word 0x0000FFFF
_02157630: .word aActAcEneBGhost
	arm_func_end EnemyGhost__Create

	arm_func_start EnemyGhostBomb__Create
EnemyGhostBomb__Create: // 0x02157634
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
	ldr r0, _021577D4 // =StageTask_Main
	ldr r1, _021577D8 // =GameObject__Destructor
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
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x41
	bl ObjRect__SetDefenceStat
	ldr r1, _021577DC // =EnemyGhostBomb__OnDefend
	mov r0, r4
	str r1, [r4, #0x278]
	ldr r2, [r4, #0x20]
	mov r1, #0xa8
	orr r2, r2, #0x100
	str r2, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	mov r2, #0xf000
	orr r3, r3, #0x90
	str r3, [r4, #0x1c]
	bl StageTask__SetGravity
	mov r2, #4
	str r2, [sp]
	mov r0, r4
	sub r1, r2, #8
	sub r2, r2, #7
	mov r3, #3
	bl StageTask__SetHitbox
	mov r0, #0xb
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _021577E0 // =gameArchiveStage
	ldr r1, _021577E4 // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _021577E8 // =aActAcEneBGhost
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x31
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #5
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _021577EC // =EnemyGhostBomb__State_2157E1C
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, #0
	str r0, [sp]
	mov r0, #0x7f
	str r0, [sp, #4]
	sub r1, r0, #0x80
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021577D4: .word StageTask_Main
_021577D8: .word GameObject__Destructor
_021577DC: .word EnemyGhostBomb__OnDefend
_021577E0: .word gameArchiveStage
_021577E4: .word 0x0000FFFF
_021577E8: .word aActAcEneBGhost
_021577EC: .word EnemyGhostBomb__State_2157E1C
	arm_func_end EnemyGhostBomb__Create

	arm_func_start EnemyGhost__Func_21577F0
EnemyGhost__Func_21577F0: // 0x021577F0
	ldr r2, [r0, #0x3c4]
	ldr r1, [r0, #0x128]
	cmp r2, #0xf0
	bls _02157810
	mov r2, #0
	strb r2, [r0, #0x3c2]
	str r2, [r0, #0x3c4]
	b _02157864
_02157810:
	cmp r2, #0xe1
	movhi r2, #1
	strhib r2, [r0, #0x3c2]
	bhi _02157864
	cmp r2, #0xd2
	movhi r2, #2
	strhib r2, [r0, #0x3c2]
	bhi _02157864
	cmp r2, #0x96
	movhi r2, #3
	strhib r2, [r0, #0x3c2]
	bhi _02157864
	cmp r2, #0x87
	movhi r2, #2
	strhib r2, [r0, #0x3c2]
	bhi _02157864
	cmp r2, #0x78
	movhi r2, #1
	strhib r2, [r0, #0x3c2]
	movls r2, #0
	strlsb r2, [r0, #0x3c2]
_02157864:
	ldr r2, [r0, #0x18]
	bic r2, r2, #2
	str r2, [r0, #0x18]
	ldr r2, [r0, #0x37c]
	bic r2, r2, #0x800
	str r2, [r0, #0x37c]
	ldrb r2, [r0, #0x3c2]
	cmp r2, #3
	addls pc, pc, r2, lsl #2
	bx lr
_0215788C: // jump table
	b _0215789C // case 0
	b _021578C4 // case 1
	b _021578F8 // case 2
	b _0215795C // case 3
_0215789C:
	mov r2, #0
	str r2, [r1, #0x58]
	ldr r1, [r0, #0x20]
	bic r1, r1, #0x20
	str r1, [r0, #0x20]
	str r2, [r0, #0x420]
	ldr r1, [r0, #0x478]
	bic r1, r1, #0x20
	str r1, [r0, #0x478]
	bx lr
_021578C4:
	ldr r3, [r0, #0x20]
	mov r2, #1
	bic r3, r3, #0x20
	str r3, [r0, #0x20]
	ldr r3, [r0, #0x478]
	bic r3, r3, #0x20
	str r3, [r0, #0x478]
	str r2, [r1, #0x58]
	str r2, [r0, #0x420]
	ldr r1, [r0, #0x37c]
	orr r1, r1, #0x800
	str r1, [r0, #0x37c]
	bx lr
_021578F8:
	ldr r2, [r1, #0x58]
	cmp r2, #1
	bne _02157928
	mov r2, #0
	str r2, [r1, #0x58]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	str r2, [r0, #0x420]
	ldr r1, [r0, #0x478]
	orr r1, r1, #0x20
	b _02157948
_02157928:
	mov r2, #1
	str r2, [r1, #0x58]
	ldr r1, [r0, #0x20]
	bic r1, r1, #0x20
	str r1, [r0, #0x20]
	str r2, [r0, #0x420]
	ldr r1, [r0, #0x478]
	bic r1, r1, #0x20
_02157948:
	str r1, [r0, #0x478]
	ldr r1, [r0, #0x37c]
	orr r1, r1, #0x800
	str r1, [r0, #0x37c]
	bx lr
_0215795C:
	mov r2, #0
	str r2, [r1, #0x58]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	str r2, [r0, #0x420]
	ldr r1, [r0, #0x478]
	orr r1, r1, #0x20
	str r1, [r0, #0x478]
	ldr r1, [r0, #0x18]
	orr r1, r1, #2
	str r1, [r0, #0x18]
	ldr r1, [r0, #0x37c]
	orr r1, r1, #0x800
	str r1, [r0, #0x37c]
	bx lr
	arm_func_end EnemyGhost__Func_21577F0

	arm_func_start EnemyGhost__Func_215799C
EnemyGhost__Func_215799C: // 0x0215799C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	mov r2, #0x7e
	str r1, [sp]
	sub r1, r2, #0x7f
	str r2, [sp, #4]
	mov r4, r0
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r0, [r4, #0x478]
	bic r0, r0, #8
	bic r0, r0, #4
	str r0, [r4, #0x478]
	ldr r0, [r4, #0x3dc]
	cmp r0, #0
	beq _02157A00
	add r0, r4, #0x3c8
	mov r1, #3
	bl AnimatorSpriteDS__SetAnimation
_02157A00:
	mov r0, r4
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x478]
	ldr r0, _02157A40 // =EnemyGhost__State_2157A44
	orr r1, r1, #4
	str r1, [r4, #0x478]
	ldr r1, [r4, #0x20]
	orr r1, r1, #4
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x354]
	bic r1, r1, #2
	str r1, [r4, #0x354]
	str r0, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157A40: .word EnemyGhost__State_2157A44
	arm_func_end EnemyGhost__Func_215799C

	arm_func_start EnemyGhost__State_2157A44
EnemyGhost__State_2157A44: // 0x02157A44
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x138]
	add r1, r5, #0x44
	mov r4, #0
	bl ProcessSpatialSfx
	ldr r1, [r5, #0x3c4]
	mov r0, r5
	add r1, r1, #1
	str r1, [r5, #0x3c4]
	bl EnemyGhost__Func_21577F0
	add r0, r5, #0x300
	ldrh r2, [r0, #0xc0]
	ldr r1, _02157BD8 // =FX_SinCosTable_
	add r2, r2, #0x200
	strh r2, [r0, #0xc0]
	ldrh r0, [r0, #0xc0]
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r0, [r1, r0]
	mov r0, r0, asr #2
	str r0, [r5, #0x9c]
	ldr r1, [r5, #0x354]
	tst r1, #1
	beq _02157AF0
	ldr r0, [r5, #0x20]
	tst r0, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	bic r0, r1, #1
	str r0, [r5, #0x354]
	ldr r1, [r5, #0x20]
	mov r0, r5
	eor r1, r1, #1
	str r1, [r5, #0x20]
	ldr r1, [r5, #0x478]
	eor r1, r1, #1
	str r1, [r5, #0x478]
	bl EnemyGhost__Func_215799C
	ldr r0, [r5, #0x37c]
	orr r0, r0, #4
	str r0, [r5, #0x37c]
_02157AF0:
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	cmp r0, #0x3c
	blo _02157B18
	ldr r1, [r5, #0x37c]
	mov r0, #0
	orr r1, r1, #4
	str r1, [r5, #0x37c]
	str r0, [r5, #0x28]
_02157B18:
	mov r0, r5
	add r1, r5, #0x364
	bl StageTask__HandleCollider
	ldr r0, [r5, #0x20]
	tst r0, #1
	mov r0, #0xc00
	rsbeq r0, r0, #0
	str r0, [r5, #0x98]
	ldr r0, [r5, #0x3b0]
	ldr r1, [r5, #0x44]
	cmp r1, r0
	bge _02157B5C
	str r0, [r5, #0x44]
	mov r0, #0
	str r0, [r5, #0x98]
	mov r4, #1
	b _02157B78
_02157B5C:
	ldr r0, [r5, #0x3b8]
	cmp r1, r0
	ble _02157B78
	str r0, [r5, #0x44]
	mov r0, #0
	str r0, [r5, #0x98]
	mov r4, #1
_02157B78:
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x478]
	bic r0, r0, #8
	bic r0, r0, #4
	str r0, [r5, #0x478]
	ldr r0, [r5, #0x3dc]
	cmp r0, #0
	beq _02157BA8
	add r0, r5, #0x3c8
	mov r1, #4
	bl AnimatorSpriteDS__SetAnimation
_02157BA8:
	mov r0, r5
	mov r1, #2
	bl GameObject__SetAnimation
	ldr r1, [r5, #0x37c]
	mov r0, #0
	bic r1, r1, #4
	str r1, [r5, #0x37c]
	str r0, [r5, #0x98]
	ldr r0, [r5, #0x354]
	orr r0, r0, #1
	str r0, [r5, #0x354]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02157BD8: .word FX_SinCosTable_
	arm_func_end EnemyGhost__State_2157A44

	arm_func_start EnemyGhost__OnDefend
EnemyGhost__OnDefend: // 0x02157BDC
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	mov r5, r0
	ldr r1, [r4, #0x98]
	mov r0, r4
	str r1, [r4, #0x3ac]
	mov r2, #0
	mov r1, #1
	str r2, [r4, #0x98]
	bl GameObject__SetAnimation
	ldr r0, _02157C28 // =EnemyGhost__State_2157C2C
	str r0, [r4, #0xf4]
	ldr r0, [r5, #0x1c]
	ldr r0, [r0, #0x44]
	str r0, [r4, #0x3a4]
	ldr r0, [r5, #0x1c]
	ldr r0, [r0, #0x48]
	str r0, [r4, #0x3a8]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02157C28: .word EnemyGhost__State_2157C2C
	arm_func_end EnemyGhost__OnDefend

	arm_func_start EnemyGhost__State_2157C2C
EnemyGhost__State_2157C2C: // 0x02157C2C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	bl EnemyGhost__Func_21577F0
	add r0, r4, #0x300
	ldrh r2, [r0, #0xc0]
	ldr r1, _02157D68 // =FX_SinCosTable_
	add r2, r2, #0x200
	strh r2, [r0, #0xc0]
	ldrh r0, [r0, #0xc0]
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r0, [r1, r0]
	mov r0, r0, asr #2
	str r0, [r4, #0x9c]
	ldr r1, [r4, #0x128]
	ldrh r0, [r1, #0xc]
	cmp r0, #1
	addne sp, sp, #0x14
	ldmneia sp!, {r3, r4, pc}
	ldrh r0, [r1, #0xe]
	cmp r0, #7
	bne _02157D20
	ldr r0, [r4, #0x354]
	tst r0, #2
	bne _02157D20
	orr r0, r0, #2
	str r0, [r4, #0x354]
	ldr r0, [r4, #0x20]
	mov r3, #0
	tst r0, #1
	ldr r0, [r4, #0x44]
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r2, [r4, #0x48]
	addne r1, r0, #0x14000
	subeq r1, r0, #0x14000
	mov r0, #0x154
	add r2, r2, #0xa000
	bl GameObject__SpawnObject
	mov r2, #0
	str r2, [r0, #0x9c]
	str r2, [r0, #0x98]
	str r2, [r0, #0xc8]
	ldr r1, [r4, #0x20]
	tst r1, #1
	subeq r1, r2, #0x1000
	beq _02157D10
	ldr r2, [r0, #0x20]
	mov r1, #0x1000
	orr r2, r2, #1
	str r2, [r0, #0x20]
_02157D10:
	str r1, [r0, #0x98]
	mov r1, #0x400
	rsb r1, r1, #0
	str r1, [r0, #0x9c]
_02157D20:
	ldr r0, [r4, #0x20]
	tst r0, #8
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	ldr r0, _02157D6C // =EnemyGhost__State_2157D70
	mov r1, #0
	str r0, [r4, #0xf4]
	mov r0, r4
	str r1, [r4, #0x28]
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x37c]
	bic r0, r0, #4
	str r0, [r4, #0x37c]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02157D68: .word FX_SinCosTable_
_02157D6C: .word EnemyGhost__State_2157D70
	arm_func_end EnemyGhost__State_2157C2C

	arm_func_start EnemyGhost__State_2157D70
EnemyGhost__State_2157D70: // 0x02157D70
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x3c4]
	add r1, r1, #1
	str r1, [r4, #0x3c4]
	bl EnemyGhost__Func_21577F0
	add r0, r4, #0x300
	ldrh r2, [r0, #0xc0]
	ldr r1, _02157E18 // =FX_SinCosTable_
	add r2, r2, #0x200
	strh r2, [r0, #0xc0]
	ldrh r0, [r0, #0xc0]
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r0, [r1, r0]
	mov r0, r0, asr #2
	str r0, [r4, #0x9c]
	ldr r0, [r4, #0x2c]
	adds r0, r0, #1
	str r0, [r4, #0x2c]
	bmi _02157DDC
	mov r0, r4
	bl EnemyGhost__Func_215799C
	mov r0, #0
	str r0, [r4, #0x2c]
_02157DDC:
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x2c]
	cmp r0, #0x3c
	ldmltia sp!, {r4, pc}
	ldr r1, [r4, #0x37c]
	mov r0, #0
	orr r1, r1, #4
	str r1, [r4, #0x37c]
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x354]
	bic r0, r0, #2
	str r0, [r4, #0x354]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157E18: .word FX_SinCosTable_
	arm_func_end EnemyGhost__State_2157D70

	arm_func_start EnemyGhostBomb__State_2157E1C
EnemyGhostBomb__State_2157E1C: // 0x02157E1C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r0, [r4, #0x1c]
	tst r0, #0xf
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x354]
	tst r0, #4
	beq _02157E64
	mov r1, #0
	str r1, [r4, #0x98]
	str r1, [r4, #0x9c]
	ldr r0, _02157E88 // =EnemyGhostBomb__State_2157E8C
	str r1, [r4, #0x2c]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
_02157E64:
	orr r0, r0, #4
	str r0, [r4, #0x354]
	ldr r1, [r4, #0x98]
	mov r0, #0x800
	mov r1, r1, asr #1
	str r1, [r4, #0x98]
	rsb r0, r0, #0
	str r0, [r4, #0x9c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157E88: .word EnemyGhostBomb__State_2157E8C
	arm_func_end EnemyGhostBomb__State_2157E1C

	arm_func_start EnemyGhostBomb__State_2157E8C
EnemyGhostBomb__State_2157E8C: // 0x02157E8C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r1, [r4, #0x2c]
	add r1, r1, #1
	cmp r1, #0x3c
	addlt sp, sp, #0x14
	str r1, [r4, #0x2c]
	ldmltia sp!, {r3, r4, pc}
	ldr r2, [r4, #0x18]
	mov r1, #0
	orr r2, r2, #4
	str r2, [r4, #0x18]
	mvn r2, #0x13
	str r2, [sp]
	mov r2, #0xe
	str r2, [sp, #4]
	mov r2, #0xb
	str r2, [sp, #8]
	mov r3, #7
	mov r2, r1
	str r3, [sp, #0xc]
	mov ip, #1
	sub r3, r1, #0x11
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	arm_func_end EnemyGhostBomb__State_2157E8C

	arm_func_start EnemyGhostBomb__OnDefend
EnemyGhostBomb__OnDefend: // 0x02157F2C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	ldr r4, [r0, #0x1c]
	mov r1, #0
	ldr r2, [r4, #0x18]
	mvn r0, #0x13
	orr r2, r2, #4
	str r2, [r4, #0x18]
	str r0, [sp]
	mov r0, #0xe
	str r0, [sp, #4]
	mov r0, #0xb
	str r0, [sp, #8]
	mov r3, #7
	mov r0, r4
	mov r2, r1
	str r3, [sp, #0xc]
	mov ip, #1
	sub r3, r1, #0x11
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	arm_func_end EnemyGhostBomb__OnDefend

	arm_func_start EnemyGhost__Draw
EnemyGhost__Draw: // 0x02157FB8
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x128]
	cmp r1, #0
	ldrne r2, [r1, #0x14]
	cmpne r2, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	bl StageTask__Draw2D
	ldr r0, [r4, #0x404]
	ldr r5, [r4, #0x20]
	bic r0, r0, #0x184
	str r0, [r4, #0x404]
	ldr r1, [r4, #0x478]
	mov r0, r4
	bic r1, r1, #8
	str r1, [r4, #0x478]
	str r1, [r4, #0x20]
	add r1, r4, #0x3c8
	bl StageTask__Draw2D
	ldr r0, [r4, #0x20]
	str r0, [r4, #0x478]
	str r5, [r4, #0x20]
	ldr r0, [r4, #0x354]
	tst r0, #0x10000
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x128]
	mov r1, #0
	str r1, [r0, #0x58]
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	str r1, [r4, #0x420]
	ldr r0, [r4, #0x478]
	bic r0, r0, #0x20
	str r0, [r4, #0x478]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end EnemyGhost__Draw

	arm_func_start EnemyGhost__Destructor
EnemyGhost__Destructor: // 0x0215804C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x470]
	cmp r0, #0
	beq _02158090
	mov r1, #0
	bl ObjActionReleaseSprite
	ldr r0, [r4, #0x470]
	mov r1, #1
	add r0, r0, #8
	bl ObjActionReleaseSprite
	mov r0, #0
	str r0, [r4, #0x440]
	str r0, [r4, #0x444]
	b _021580C8
_02158090:
	ldr r1, [r4, #0x440]
	cmp r1, #0
	beq _021580A4
	mov r0, #0
	bl VRAMSystem__FreeSpriteVram
_021580A4:
	mov r0, #0
	str r0, [r4, #0x440]
	ldr r1, [r4, #0x444]
	cmp r1, #0
	beq _021580C0
	mov r0, #1
	bl VRAMSystem__FreeSpriteVram
_021580C0:
	mov r0, #0
	str r0, [r4, #0x444]
_021580C8:
	ldr r0, [r4, #0x46c]
	cmp r0, #0
	beq _021580DC
	bl ObjDataRelease
	b _021580F8
_021580DC:
	ldr r0, [r4, #0x3dc]
	cmp r0, #0
	beq _021580F8
	ldr r0, [r4, #0x18]
	tst r0, #0x100
	moveq r0, #0
	streq r0, [r4, #0x3dc]
_021580F8:
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end EnemyGhost__Destructor

	.data

aActAcEneBGhost: // 0x02188C40
	.asciz "/act/ac_ene_b_ghost.bac"
	.align 4