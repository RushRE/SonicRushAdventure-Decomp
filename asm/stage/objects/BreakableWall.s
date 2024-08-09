	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start BreakableWall__Create
BreakableWall__Create: // 0x02160284
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _021604EC // =0x00000464
	ldr r0, _021604F0 // =StageTask_Main
	ldr r1, _021604F4 // =GameObject__Destructor
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
	ldr r2, _021604EC // =0x00000464
	mov r1, #0
	mov r4, r0
	bl MI_CpuFill8
	ldrh r0, [r8, #2]
	mov r1, r8
	mov r2, r7
	cmp r0, #0x77
	ldreqh r0, [r8, #4]
	mov r3, r6
	andeq r5, r0, #3
	mov r0, r4
	movne r5, #3
	bl GameObject__InitFromObject
	mov r0, #0x3d
	bl GetObjectFileWork
	ldr r1, _021604F8 // =gameArchiveStage
	mov r3, r0
	ldr r0, [r1]
	ldr r2, _021604FC // =aActAcGmkWallBr
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #6
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x20c]
	mov r1, r5
	ldr r0, [r0]
	bl Sprite__GetSpriteSize2FromAnim
	mov r6, r0
	mov r0, r5, lsl #1
	add r0, r0, #0x3e
	bl GetObjectFileWork
	mov r2, r0
	mov r1, r6
	mov r0, r4
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, r5
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r1, #0
	add r0, r4, #0x218
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldrh r0, [r8, #2]
	mov r2, #0
	cmp r0, #0x77
	bne _021603F8
	ldr r1, _02160500 // =0x0000FFFE
	add r0, r4, #0x218
	bl ObjRect__SetDefenceStat
	ldr r0, _02160504 // =BreakableWall__ppDef_2160518
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	b _0216044C
_021603F8:
	ldr r1, _02160508 // =0x0000FFFD
	add r0, r4, #0x218
	bl ObjRect__SetDefenceStat
	ldr r0, _0216050C // =BreakableWall__ppDef_21608E0
	mov r1, #0
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	mov r2, r1
	orr r3, r0, #0x400
	add r0, r4, #0x258
	str r3, [r4, #0x230]
	bl ObjRect__SetAttackStat
	ldr r1, _02160508 // =0x0000FFFD
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02160510 // =BreakableWall__ppDef_2160A88
	str r0, [r4, #0x27c]
	ldr r0, [r4, #0x270]
	orr r0, r0, #0x400
	str r0, [r4, #0x270]
_0216044C:
	cmp r5, #3
	addls pc, pc, r5, lsl #2
	b _021604BC
_02160458: // jump table
	b _02160468 // case 0
	b _02160468 // case 1
	b _02160468 // case 2
	b _02160494 // case 3
_02160468:
	mov r0, #0
	str r0, [r4, #0x13c]
	ldr r0, _02160514 // =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	add r0, r4, #0x300
	mov r1, #0x20
	strh r1, [r0, #8]
	mov r1, #0x40
	strh r1, [r0, #0xa]
	b _021604BC
_02160494:
	mov r0, #0
	str r0, [r4, #0x13c]
	ldr r0, _02160514 // =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	add r0, r4, #0x300
	mov r1, #0x40
	strh r1, [r0, #8]
	mov r1, #0x20
	strh r1, [r0, #0xa]
_021604BC:
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x48]
	bl Player__UseUpsideDownGravity
	cmp r0, #0
	movne r0, #0x8000
	strneh r0, [r4, #0xce]
	ldr r1, [r4, #0x1c]
	mov r0, r4
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021604EC: .word 0x00000464
_021604F0: .word StageTask_Main
_021604F4: .word GameObject__Destructor
_021604F8: .word gameArchiveStage
_021604FC: .word aActAcGmkWallBr
_02160500: .word 0x0000FFFE
_02160504: .word BreakableWall__ppDef_2160518
_02160508: .word 0x0000FFFD
_0216050C: .word BreakableWall__ppDef_21608E0
_02160510: .word BreakableWall__ppDef_2160A88
_02160514: .word StageTask__DefaultDiffData
	arm_func_end BreakableWall__Create

	arm_func_start BreakableWall__ppDef_2160518
BreakableWall__ppDef_2160518: // 0x02160518
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	mov r4, #0
	mov r6, r4
	cmp r5, #0
	ldr r7, [r1, #0x1c]
	beq _02160564
	ldrh r2, [r5]
	cmp r2, #1
	moveq r4, r5
	beq _02160564
	cmp r2, #3
	bne _02160564
	ldr r3, [r5, #0x340]
	ldr r2, _021608D4 // =0x0000014A
	ldrh r3, [r3, #2]
	cmp r3, r2
	moveq r6, r5
_02160564:
	cmp r4, #0
	beq _021607A0
	ldr r3, [r7, #0x340]
	ldr r5, [r4, #0xc8]
	ldrh r3, [r3, #4]
	ldr r8, [r4, #0x98]
	cmp r5, #0
	rsblt r2, r5, #0
	movge r2, r5
	cmp r8, #0
	and r6, r3, #3
	rsblt r3, r8, #0
	movge r3, r8
	cmp r2, r3
	bge _021605B0
	mov r5, r8
	cmp r8, #0
	rsblt r8, r8, #0
	mov r2, r8
_021605B0:
	cmp r6, #0
	bne _021605E0
	ldr r3, [r4, #0x648]
	cmp r2, r3
	bgt _02160608
	ldr r8, [r7, #0x44]
	ldr r3, [r4, #0x44]
	add r8, r8, #0x10000
	subs r3, r8, r3
	rsbmi r3, r3, #0
	cmp r3, #0x20000
	blt _02160608
_021605E0:
	cmp r6, #1
	bne _021605F4
	ldr r3, [r4, #0x648]
	cmp r2, r3
	bgt _02160608
_021605F4:
	cmp r6, #2
	bne _02160734
	ldr r2, [r4, #0x5d8]
	tst r2, #0x80
	beq _02160734
_02160608:
	mov r0, #3
	bl ShakeScreen
	ldr r1, _021608D8 // =BreakableWall__State_2160C30
	ldr r0, _021608DC // =BreakableWall__Draw_2160D20
	str r1, [r7, #0xf4]
	str r0, [r7, #0xfc]
	ldr r0, [r7, #0x18]
	mov r6, #0
	orr r0, r0, #2
	str r0, [r7, #0x18]
	str r6, [r7, #0x2d8]
	ldr r0, [r7, #0x1a4]
	mov r2, r5, asr #1
	bic r0, r0, #0x800
	str r0, [r7, #0x1a4]
	ldr r0, [r7, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x77
	bne _02160694
	cmp r2, #0
	subgt r3, r6, #0x100
	mov r5, #0
	movle r3, #0x100
	mov r6, r5
	sub r8, r5, #0x5000
_0216066C:
	add r1, r2, r6
	add r0, r7, r5, lsl #3
	str r1, [r0, #0x3e4]
	add r5, r5, #1
	str r8, [r0, #0x3e8]
	cmp r5, #0x10
	add r6, r6, r3
	add r8, r8, #0x800
	blt _0216066C
	b _02160708
_02160694:
	mov ip, #0x1000
	rsb ip, ip, #0
	mov r1, r6
	mov r3, r6
	sub r2, r6, #0x5000
	sub r5, r6, #0x6000
	add lr, ip, #0x800
_021606B0:
	sub r8, ip, r1
	add r0, r7, r6, lsl #3
	str r8, [r0, #0x3e4]
	str r2, [r0, #0x3e8]
	ldr sb, [r0, #0x3e4]
	sub r8, lr, r3
	rsb sb, sb, #0
	str sb, [r0, #0x3ec]
	str r2, [r0, #0x3f0]
	str r8, [r0, #0x3f4]
	str r5, [r0, #0x3f8]
	ldr r8, [r0, #0x3f4]
	add r6, r6, #4
	rsb r8, r8, #0
	str r8, [r0, #0x3fc]
	str r5, [r0, #0x400]
	cmp r6, #0x10
	add r1, r1, #0x400
	add r2, r2, #0x1000
	add r3, r3, #0x200
	add r5, r5, #0x1000
	blt _021606B0
_02160708:
	mov r5, #0x42
	sub r1, r5, #0x43
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlaySfxEx
	mov r0, #0x4000
	add sp, sp, #8
	str r0, [r4, #8]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
_02160734:
	bl ObjRect__FuncNoHit
	cmp r6, #2
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	ldr r0, [r4, #0x118]
	cmp r0, r7
	ldr r0, [r7, #0x354]
	bne _02160790
	tst r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	mov r4, #0x36
	sub r1, r4, #0x37
	mov r0, #0
	stmia sp, {r0, r4}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r7, #0x354]
	add sp, sp, #8
	orr r0, r0, #1
	str r0, [r7, #0x354]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
_02160790:
	bic r0, r0, #1
	add sp, sp, #8
	str r0, [r7, #0x354]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
_021607A0:
	cmp r6, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	mov r0, #3
	ldr r4, [r6, #0x98]
	bl ShakeScreen
	ldr r1, _021608D8 // =BreakableWall__State_2160C30
	ldr r0, _021608DC // =BreakableWall__Draw_2160D20
	str r1, [r7, #0xf4]
	str r0, [r7, #0xfc]
	ldr r0, [r7, #0x18]
	mov r5, #0
	orr r0, r0, #2
	str r0, [r7, #0x18]
	str r5, [r7, #0x2d8]
	ldr r0, [r7, #0x1a4]
	mov r4, r4, asr #1
	bic r0, r0, #0x800
	str r0, [r7, #0x1a4]
	ldr r0, [r7, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x77
	bne _0216083C
	cmp r4, #0
	subgt r2, r5, #0x100
	mov r3, #0
	movle r2, #0x100
	mov r5, r3
	sub r6, r3, #0x5000
_02160814:
	add r1, r4, r5
	add r0, r7, r3, lsl #3
	str r1, [r0, #0x3e4]
	add r3, r3, #1
	str r6, [r0, #0x3e8]
	cmp r3, #0x10
	add r5, r5, r2
	add r6, r6, #0x800
	blt _02160814
	b _021608B0
_0216083C:
	mov r6, #0x1000
	rsb r6, r6, #0
	mov r1, r5
	mov r3, r5
	sub r2, r5, #0x5000
	sub r4, r5, #0x6000
	add ip, r6, #0x800
_02160858:
	sub r8, r6, r1
	add r0, r7, r5, lsl #3
	str r8, [r0, #0x3e4]
	str r2, [r0, #0x3e8]
	ldr r8, [r0, #0x3e4]
	sub lr, ip, r3
	rsb r8, r8, #0
	str r8, [r0, #0x3ec]
	str r2, [r0, #0x3f0]
	str lr, [r0, #0x3f4]
	str r4, [r0, #0x3f8]
	ldr lr, [r0, #0x3f4]
	add r5, r5, #4
	rsb lr, lr, #0
	str lr, [r0, #0x3fc]
	str r4, [r0, #0x400]
	cmp r5, #0x10
	add r1, r1, #0x400
	add r2, r2, #0x1000
	add r3, r3, #0x200
	add r4, r4, #0x1000
	blt _02160858
_021608B0:
	mov r4, #0x42
	sub r1, r4, #0x43
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_021608D4: .word 0x0000014A
_021608D8: .word BreakableWall__State_2160C30
_021608DC: .word BreakableWall__Draw_2160D20
	arm_func_end BreakableWall__ppDef_2160518

	arm_func_start BreakableWall__ppDef_21608E0
BreakableWall__ppDef_21608E0: // 0x021608E0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #8
	ldr r3, [r0, #0x1c]
	ldr r6, [r1, #0x1c]
	cmp r3, #0
	mov r4, #0
	beq _02160908
	ldrh r2, [r3]
	cmp r2, #1
	moveq r4, r3
_02160908:
	cmp r4, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	ldr r2, [r4, #0xc0]
	cmp r2, #0
	bge _02160A74
	ldr r5, [r4, #0xc8]
	ldr r0, [r4, #0x9c]
	cmp r5, #0
	rsblt r1, r5, #0
	movge r1, r5
	cmp r0, #0
	rsblt r2, r0, #0
	movge r2, r0
	cmp r1, r2
	movlt r5, r0
	mov r0, #3
	bl ShakeScreen
	ldr r1, _02160A80 // =BreakableWall__State_2160C30
	ldr r0, _02160A84 // =BreakableWall__Draw_2160D20
	str r1, [r6, #0xf4]
	str r0, [r6, #0xfc]
	ldr r0, [r6, #0x18]
	mov ip, #0
	orr r0, r0, #2
	str r0, [r6, #0x18]
	str ip, [r6, #0x2d8]
	ldr r0, [r6, #0x1a4]
	mov r2, r5, asr #1
	bic r0, r0, #0x800
	str r0, [r6, #0x1a4]
	ldr r0, [r6, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x77
	bne _021609D4
	mov r5, #0
	cmp r2, #0
	subgt r3, ip, #0x100
	movle r3, #0x100
	mov r7, r5
	sub r8, r5, #0x5000
_021609AC:
	add r1, r2, r7
	add r0, r6, r5, lsl #3
	str r1, [r0, #0x3e4]
	add r5, r5, #1
	str r8, [r0, #0x3e8]
	cmp r5, #0x10
	add r7, r7, r3
	add r8, r8, #0x800
	blt _021609AC
	b _02160A48
_021609D4:
	mov lr, #0x1000
	rsb lr, lr, #0
	mov r1, ip
	mov r3, ip
	sub r2, ip, #0x5000
	sub r5, ip, #0x6000
	add r7, lr, #0x800
_021609F0:
	sub r8, lr, r1
	add r0, r6, ip, lsl #3
	str r8, [r0, #0x3e4]
	str r2, [r0, #0x3e8]
	ldr sb, [r0, #0x3e4]
	sub r8, r7, r3
	rsb sb, sb, #0
	str sb, [r0, #0x3ec]
	str r2, [r0, #0x3f0]
	str r8, [r0, #0x3f4]
	str r5, [r0, #0x3f8]
	ldr r8, [r0, #0x3f4]
	add ip, ip, #4
	rsb r8, r8, #0
	str r8, [r0, #0x3fc]
	str r5, [r0, #0x400]
	cmp ip, #0x10
	add r1, r1, #0x400
	add r2, r2, #0x1000
	add r3, r3, #0x200
	add r5, r5, #0x1000
	blt _021609F0
_02160A48:
	mov r5, #0x42
	sub r1, r5, #0x43
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlaySfxEx
	mov r0, #0x4000
	add sp, sp, #8
	str r0, [r4, #8]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
_02160A74:
	bl ObjRect__FuncNoHit
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_02160A80: .word BreakableWall__State_2160C30
_02160A84: .word BreakableWall__Draw_2160D20
	arm_func_end BreakableWall__ppDef_21608E0

	arm_func_start BreakableWall__ppDef_2160A88
BreakableWall__ppDef_2160A88: // 0x02160A88
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #8
	ldr r3, [r0, #0x1c]
	ldr r6, [r1, #0x1c]
	cmp r3, #0
	mov r4, #0
	beq _02160AB0
	ldrh r2, [r3]
	cmp r2, #1
	moveq r4, r3
_02160AB0:
	cmp r4, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	ldr r2, [r4, #0xc0]
	cmp r2, #0
	ble _02160C1C
	ldr r5, [r4, #0xc8]
	ldr r0, [r4, #0x9c]
	cmp r5, #0
	rsblt r1, r5, #0
	movge r1, r5
	cmp r0, #0
	rsblt r2, r0, #0
	movge r2, r0
	cmp r1, r2
	movlt r5, r0
	mov r0, #3
	bl ShakeScreen
	ldr r1, _02160C28 // =BreakableWall__State_2160C30
	ldr r0, _02160C2C // =BreakableWall__Draw_2160D20
	str r1, [r6, #0xf4]
	str r0, [r6, #0xfc]
	ldr r0, [r6, #0x18]
	mov ip, #0
	orr r0, r0, #2
	str r0, [r6, #0x18]
	str ip, [r6, #0x2d8]
	ldr r0, [r6, #0x1a4]
	mov r2, r5, asr #1
	bic r0, r0, #0x800
	str r0, [r6, #0x1a4]
	ldr r0, [r6, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x77
	bne _02160B7C
	mov r5, #0
	cmp r2, #0
	subgt r3, ip, #0x100
	movle r3, #0x100
	mov r7, r5
	sub r8, r5, #0x5000
_02160B54:
	add r1, r2, r7
	add r0, r6, r5, lsl #3
	str r1, [r0, #0x3e4]
	add r5, r5, #1
	str r8, [r0, #0x3e8]
	cmp r5, #0x10
	add r7, r7, r3
	add r8, r8, #0x800
	blt _02160B54
	b _02160BF0
_02160B7C:
	mov lr, #0x1000
	rsb lr, lr, #0
	mov r1, ip
	mov r3, ip
	sub r2, ip, #0x5000
	sub r5, ip, #0x6000
	add r7, lr, #0x800
_02160B98:
	sub r8, lr, r1
	add r0, r6, ip, lsl #3
	str r8, [r0, #0x3e4]
	str r2, [r0, #0x3e8]
	ldr sb, [r0, #0x3e4]
	sub r8, r7, r3
	rsb sb, sb, #0
	str sb, [r0, #0x3ec]
	str r2, [r0, #0x3f0]
	str r8, [r0, #0x3f4]
	str r5, [r0, #0x3f8]
	ldr r8, [r0, #0x3f4]
	add ip, ip, #4
	rsb r8, r8, #0
	str r8, [r0, #0x3fc]
	str r5, [r0, #0x400]
	cmp ip, #0x10
	add r1, r1, #0x400
	add r2, r2, #0x1000
	add r3, r3, #0x200
	add r5, r5, #0x1000
	blt _02160B98
_02160BF0:
	mov r5, #0x42
	sub r1, r5, #0x43
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlaySfxEx
	mov r0, #0x4000
	add sp, sp, #8
	str r0, [r4, #8]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
_02160C1C:
	bl ObjRect__FuncNoHit
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_02160C28: .word BreakableWall__State_2160C30
_02160C2C: .word BreakableWall__Draw_2160D20
	arm_func_end BreakableWall__ppDef_2160A88

	arm_func_start BreakableWall__State_2160C30
BreakableWall__State_2160C30: // 0x02160C30
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	mov sl, r0
	ldr r0, [sl, #0x340]
	ldr r5, _02160D1C // =0x00FFF000
	ldrh r0, [r0, #2]
	rsb r6, r5, #0
	mov sb, #0
	cmp r0, #0x77
	moveq r7, #0x2a0
	moveq r8, #0x180
	ldrh r0, [sl, #0xce]
	movne r7, #0x2c0
	movne r8, #0x10
	cmp r0, #0
	rsbne r7, r7, #0
	mov fp, r6
	mov r4, r6
_02160C74:
	add r0, sl, sb, lsl #3
	ldr r2, [r0, #0x364]
	ldr r1, [r0, #0x3e4]
	add r1, r2, r1
	str r1, [r0, #0x364]
	ldr r2, [r0, #0x368]
	ldr r1, [r0, #0x3e8]
	add r1, r2, r1
	str r1, [r0, #0x368]
	ldr r1, [r0, #0x364]
	cmp r1, r4
	movlt r1, r6
	blt _02160CB0
	cmp r1, r5
	movgt r1, r5
_02160CB0:
	add r0, sl, sb, lsl #3
	str r1, [r0, #0x364]
	ldr r1, [r0, #0x368]
	cmp r1, fp
	movlt r1, r6
	blt _02160CD0
	cmp r1, r5
	movgt r1, r5
_02160CD0:
	add r0, sl, sb, lsl #3
	str r1, [r0, #0x368]
	ldr r0, [r0, #0x3e4]
	mov r1, r8
	bl ObjSpdDownSet
	add r1, sl, sb, lsl #3
	str r0, [r1, #0x3e4]
	ldr r0, [r1, #0x3e8]
	mov r1, r7
	mov r2, #0x30000
	bl ObjSpdUpSet
	add r1, sb, #1
	add r2, sl, sb, lsl #3
	mov r1, r1, lsl #0x10
	mov sb, r1, lsr #0x10
	str r0, [r2, #0x3e8]
	cmp sb, #0x10
	blo _02160C74
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02160D1C: .word 0x00FFF000
	arm_func_end BreakableWall__State_2160C30

	arm_func_start BreakableWall__Draw_2160D20
BreakableWall__Draw_2160D20: // 0x02160D20
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	add r1, r0, #0x168
	str r0, [sp, #4]
	str r1, [sp]
	bl StageTask__Draw2D
	mov r8, #0
_02160D40:
	ldr r0, [sp]
	mov r4, #0
	add r2, r0, r8, lsl #2
	ldr r0, [sp, #4]
	mov sb, #0x200
	add r5, r0, #0x364
	ldr r1, [r2, #0x94]
	ldrsh r6, [r2, #0x68]
	ldrsh r7, [r2, #0x6a]
	rsb sb, sb, #0
	mov fp, r4
	ldr sl, _02160E84 // =0x000001FF
	b _02160E60
_02160D74:
	ldr r2, [r5]
	ldr r0, [r5, #4]
	mov ip, r2, asr #0xc
	add lr, r6, r2, asr #12
	mov r3, r4, lsr #0x1f
	rsb r2, r3, r4, lsl #31
	add r2, r3, r2, ror #31
	add r2, lr, r2, lsl #4
	mov r2, r2, lsl #0x10
	mov r3, r2, asr #0x10
	adds r2, r3, #0x10
	mov r2, r0, asr #0xc
	add r0, r7, r0, asr #12
	add lr, r4, r4, lsr #31
	mov lr, lr, asr #1
	add r0, r0, lr, lsl #3
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	bmi _02160DD8
	cmp r3, #0x100
	bge _02160DD8
	adds r3, r0, #8
	bmi _02160DD8
	cmp r0, #0xc0
	blt _02160DE4
_02160DD8:
	mov r2, fp
	mov r0, #0xc0
	b _02160E24
_02160DE4:
	mov r0, ip, lsl #0x10
	mov r3, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r0, r0, asr #0x10
	ldrh r2, [r1, #2]
	ldrh ip, [r1]
	and r2, r2, sl
	mov r2, r2, lsl #0x10
	add r2, r3, r2, asr #16
	and r3, ip, #0xff
	mov r3, r3, lsl #0x10
	add r3, r0, r3, asr #16
	mov r0, r2, lsl #0x10
	mov r2, r0, asr #0x10
	mov r0, r3, lsl #0x10
	mov r0, r0, asr #0x10
_02160E24:
	and r3, r2, sl
	and r2, r0, #0xff
	ldrh ip, [r1, #2]
	mov r0, r8
	and ip, ip, sb
	orr r3, ip, r3
	strh r3, [r1, #2]
	ldrh r3, [r1]
	bic r3, r3, #0xff
	orr r2, r3, r2
	strh r2, [r1]
	bl OAMSystem__Func_207D624
	mov r1, r0
	add r4, r4, #1
	add r5, r5, #8
_02160E60:
	cmp r4, #0x10
	bge _02160E70
	cmp r1, #0
	bne _02160D74
_02160E70:
	add r8, r8, #1
	cmp r8, #2
	blt _02160D40
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02160E84: .word 0x000001FF
	arm_func_end BreakableWall__Draw_2160D20

	.data
	
aActAcGmkWallBr: // 0x02188F10
	.asciz "/act/ac_gmk_wall_braek.bac"
	.align 4