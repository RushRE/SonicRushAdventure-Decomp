	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start EnemySnowball__Create
EnemySnowball__Create: // 0x02158580
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r7, r0
	mov r6, r1
	mov r5, r2
	beq _021585AC
	ldrb r0, [r7]
	cmp r0, #0xff
	ldreqb r0, [r7, #1]
	cmpeq r0, #0xff
	beq _021585D0
_021585AC:
	ldr r0, _021586D4 // =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _021585D0
	ldrh r0, [r7, #4]
	tst r0, #0x80
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
_021585D0:
	mov r0, #0x1500
	mov r2, #0
	str r0, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x3c4
	ldr r0, _021586D8 // =StageTask_Main
	ldr r1, _021586DC // =GameObject__Destructor
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
	mov r2, #0x3c4
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	mov r1, r7
	mov r2, r6
	mov r3, r5
	ldr r5, [r4, #0x23c]
	mov r0, r4
	str r5, [r4, #0x3c0]
	bl EnemySnowball__Func_215886C
	mov r0, #0xd
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _021586E0 // =gameArchiveStage
	ldr r1, _021586E4 // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _021586E8 // =aActAcEneSnowba
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x37
	bl ObjActionAllocSpritePalette
	mov r0, r4
	bl EnemySnowballShot__Func_215896C
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021586D4: .word gameState
_021586D8: .word StageTask_Main
_021586DC: .word GameObject__Destructor
_021586E0: .word gameArchiveStage
_021586E4: .word 0x0000FFFF
_021586E8: .word aActAcEneSnowba
	arm_func_end EnemySnowball__Create

	arm_func_start EnemySnowballShot__Create
EnemySnowballShot__Create: // 0x021586EC
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
	ldr r0, _0215882C // =StageTask_Main
	ldr r1, _02158830 // =GameObject__Destructor
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
	ldr r0, [r4, #0x20]
	mov r1, #3
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	mvn r3, #2
	orr r0, r0, #0x50
	bic r0, r0, #0x200
	str r0, [r4, #0x1c]
	mov r0, r4
	mov r2, r1
	str r3, [sp]
	bl StageTask__SetHitbox
	mov r0, #0xd
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02158834 // =gameArchiveStage
	ldr r1, _02158838 // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _0215883C // =aActAcEneSnowba
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #5
	mov r2, #0x4b
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #5
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _02158840 // =EnemySnowballShot__State_2158D24
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215882C: .word StageTask_Main
_02158830: .word GameObject__Destructor
_02158834: .word gameArchiveStage
_02158838: .word 0x0000FFFF
_0215883C: .word aActAcEneSnowba
_02158840: .word EnemySnowballShot__State_2158D24
	arm_func_end EnemySnowballShot__Create

	arm_func_start EnemySnowball__Func_2158844
EnemySnowball__Func_2158844: // 0x02158844
	ldr r1, [r0, #0x340]
	ldr r2, [r0, #0x44]
	ldrsb r1, [r1, #6]
	add r2, r2, r1, lsl #12
	str r2, [r0, #0x3a8]
	ldr r1, [r0, #0x340]
	ldrb r1, [r1, #8]
	add r1, r2, r1, lsl #12
	str r1, [r0, #0x3b0]
	bx lr
	arm_func_end EnemySnowball__Func_2158844

	arm_func_start EnemySnowball__Func_215886C
EnemySnowball__Func_215886C: // 0x0215886C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r0, #0
	strb r0, [r4, #0x3a4]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x80
	str r0, [r4, #0x1c]
	ldrh r0, [r1, #4]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	mov r0, r4
	bl EnemySnowball__Func_2158844
	mov ip, #0x3c
	add r0, r4, #0x364
	sub r1, ip, #0xb4
	sub r2, ip, #0x78
	mov r3, #0
	str ip, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x364
	bl ObjRect__SetAttackStat
	ldr r1, _02158924 // =0x0000FFFE
	add r0, r4, #0x364
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _02158928 // =0x00000102
	add r0, r4, #0x300
	strh r1, [r0, #0x98]
	ldr r1, [r4, #0x37c]
	ldr r0, _0215892C // =EnemySnowball__Func_2158B60
	orr r1, r1, #0xc0
	str r1, [r4, #0x37c]
	str r0, [r4, #0x388]
	ldr r0, _02158930 // =EnemySnowballShot__OnDefend_2158AC4
	str r4, [r4, #0x380]
	str r0, [r4, #0x23c]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02158924: .word 0x0000FFFE
_02158928: .word 0x00000102
_0215892C: .word EnemySnowball__Func_2158B60
_02158930: .word EnemySnowballShot__OnDefend_2158AC4
	arm_func_end EnemySnowball__Func_215886C

	arm_func_start EnemySnowballShot__Func_2158934
EnemySnowballShot__Func_2158934: // 0x02158934
	mov r1, #1
	strb r1, [r0, #0x3a4]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x100
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x1c]
	orr r1, r1, #0x80
	str r1, [r0, #0x1c]
	ldr r1, [r0, #0x37c]
	orr r1, r1, #0x800
	str r1, [r0, #0x37c]
	ldr r1, [r0, #0x3c0]
	str r1, [r0, #0x23c]
	bx lr
	arm_func_end EnemySnowballShot__Func_2158934

	arm_func_start EnemySnowballShot__Func_215896C
EnemySnowballShot__Func_215896C: // 0x0215896C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrb r1, [r4, #0x3a4]
	cmp r1, #0
	bne _021589A0
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _021589D4 // =EnemySnowballShot__State_21589DC
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	b _021589C4
_021589A0:
	cmp r1, #1
	bne _021589C4
	mov r1, #4
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _021589D8 // =EnemySnowballShot__State_2158A14
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
_021589C4:
	ldr r0, [r4, #0x354]
	bic r0, r0, #1
	str r0, [r4, #0x354]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021589D4: .word EnemySnowballShot__State_21589DC
_021589D8: .word EnemySnowballShot__State_2158A14
	arm_func_end EnemySnowballShot__Func_215896C

	arm_func_start EnemySnowballShot__State_21589DC
EnemySnowballShot__State_21589DC: // 0x021589DC
	ldr r1, [r0, #0x28]
	add r1, r1, #1
	str r1, [r0, #0x28]
	cmp r1, #0x78
	blo _02158A04
	ldr r2, [r0, #0x37c]
	mov r1, #0
	orr r2, r2, #4
	str r2, [r0, #0x37c]
	str r1, [r0, #0x28]
_02158A04:
	ldr ip, _02158A10 // =StageTask__HandleCollider
	add r1, r0, #0x364
	bx ip
	.align 2, 0
_02158A10: .word StageTask__HandleCollider
	arm_func_end EnemySnowballShot__State_21589DC

	arm_func_start EnemySnowballShot__State_2158A14
EnemySnowballShot__State_2158A14: // 0x02158A14
	ldr r1, [r0, #0x20]
	tst r1, #1
	mov r1, #0xc00
	rsbeq r1, r1, #0
	str r1, [r0, #0x98]
	ldr r1, [r0, #0x1c]
	bic r1, r1, #0x400
	str r1, [r0, #0x1c]
	tst r1, #4
	beq _02158A68
	ldr r2, [r0, #0x44]
	mov r1, #0
	str r2, [r0, #0x3b8]
	str r1, [r0, #0x98]
	ldr r1, [r0, #0x20]
	eor r1, r1, #1
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x1c]
	orr r1, r1, #0x400
	str r1, [r0, #0x1c]
	bx lr
_02158A68:
	ldr r1, [r0, #0x3a8]
	ldr r2, [r0, #0x44]
	cmp r2, r1
	bge _02158A98
	str r1, [r0, #0x44]
	str r1, [r0, #0x3b8]
	mov r1, #0
	str r1, [r0, #0x98]
	ldr r1, [r0, #0x20]
	eor r1, r1, #1
	str r1, [r0, #0x20]
	bx lr
_02158A98:
	ldr r1, [r0, #0x3b0]
	cmp r2, r1
	bxle lr
	str r1, [r0, #0x44]
	str r1, [r0, #0x3b8]
	mov r1, #0
	str r1, [r0, #0x98]
	ldr r1, [r0, #0x20]
	eor r1, r1, #1
	str r1, [r0, #0x20]
	bx lr
	arm_func_end EnemySnowballShot__State_2158A14

	arm_func_start EnemySnowballShot__OnDefend_2158AC4
EnemySnowballShot__OnDefend_2158AC4: // 0x02158AC4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r2, #3
	ldr r4, [r1, #0x1c]
	bl GameObject__BadnikBreak
	and r0, r0, #0xff
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	mov ip, #0x28
	sub r1, ip, #0x29
	mov r0, #0
	stmia sp, {r0, ip}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	mov r0, r4
	mov r1, #2
	bl GameObject__SetAnimation
	ldr r0, _02158B2C // =EnemySnowballShot__State_2158B30
	str r0, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158B2C: .word EnemySnowballShot__State_2158B30
	arm_func_end EnemySnowballShot__OnDefend_2158AC4

	arm_func_start EnemySnowballShot__State_2158B30
EnemySnowballShot__State_2158B30: // 0x02158B30
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x20]
	tst r1, #8
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x340]
	ldr r2, [r4, #0x44]
	ldr r3, [r4, #0x48]
	bl EnemySnowballShot__Func_2158934
	mov r0, r4
	bl EnemySnowballShot__Func_215896C
	ldmia sp!, {r4, pc}
	arm_func_end EnemySnowballShot__State_2158B30

	arm_func_start EnemySnowball__Func_2158B60
EnemySnowball__Func_2158B60: // 0x02158B60
	stmdb sp!, {r4, lr}
	ldr r4, [r1, #0x1c]
	mov r1, #0
	mov r0, r4
	sub r2, r1, #0x35000
	bl CreateEffectFound
	ldr r1, _02158B90 // =EnemySnowball__Func_2158B94
	mov r0, #0
	str r1, [r4, #0xf4]
	str r0, [r4, #0x28]
	str r0, [r4, #0x2c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158B90: .word EnemySnowball__Func_2158B94
	arm_func_end EnemySnowball__Func_2158B60

	arm_func_start EnemySnowball__Func_2158B94
EnemySnowball__Func_2158B94: // 0x02158B94
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r0, [r4, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, #1
	beq _02158C0C
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	cmp r0, #0x1e
	addle sp, sp, #0x14
	str r0, [r4, #0x2c]
	ldmleia sp!, {r3, r4, pc}
	mov r1, #0
	mov r0, #0x7c
	str r1, [sp]
	sub r1, r0, #0x7d
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	mov r0, r4
	mov r1, #1
	bl GameObject__SetAnimation
	mov r0, #0
	str r0, [r4, #0x2c]
_02158C0C:
	ldr r0, [r4, #0x20]
	tst r0, #0x10
	ldreq r1, [r4, #0x128]
	ldreqh r0, [r1, #0xc]
	cmpeq r0, #1
	bne _02158D00
	ldrh r0, [r1, #0xe]
	cmp r0, #7
	blo _02158D00
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	cmp r0, #0x1e
	blo _02158D00
	ldr r0, [r4, #0x354]
	tst r0, #1
	bne _02158D00
	mov r1, #0
	mov r0, #0x7b
	str r1, [sp]
	sub r1, r0, #0x7c
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r1, [r4, #0x37c]
	mov r0, #0
	bic r1, r1, #4
	str r1, [r4, #0x37c]
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x354]
	mov r3, #0
	orr r0, r0, #1
	str r0, [r4, #0x354]
	ldr r0, [r4, #0x20]
	tst r0, #1
	ldr r0, [r4, #0x44]
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	addne r1, r0, #0x4000
	ldr r2, [r4, #0x48]
	subeq r1, r0, #0x4000
	ldr r0, _02158D20 // =0x00000155
	sub r2, r2, #0x18000
	bl GameObject__SpawnObject
	mov r2, #0
	str r2, [r0, #0x9c]
	str r2, [r0, #0x98]
	ldr r1, [r4, #0x20]
	tst r1, #1
	movne r1, #0x2000
	strne r1, [r0, #0x98]
	subeq r1, r2, #0x2000
	streq r1, [r0, #0x98]
_02158D00:
	ldr r0, [r4, #0x20]
	tst r0, #8
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	mov r0, r4
	bl EnemySnowballShot__Func_215896C
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02158D20: .word 0x00000155
	arm_func_end EnemySnowball__Func_2158B94

	arm_func_start EnemySnowballShot__State_2158D24
EnemySnowballShot__State_2158D24: // 0x02158D24
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x1c]
	tst r1, #0xf
	ldmeqia sp!, {r3, pc}
	ldr r2, [r0, #0x18]
	mov r1, #0
	orr ip, r2, #4
	mov r2, r1
	mov r3, #1
	str ip, [r0, #0x18]
	bl CreateEffectExplosion
	ldmia sp!, {r3, pc}
	arm_func_end EnemySnowballShot__State_2158D24

	.data
	
aActAcEneSnowba: // 0x02188C70
	.asciz "/act/ac_ene_snowball.bac"
	.align 4