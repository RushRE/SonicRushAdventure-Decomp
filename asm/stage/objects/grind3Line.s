	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
Grind3Line__Singleton: // 0x0218A378
	.space 0x04 // Task*
	
	.text

	arm_func_start Grind3LineSpring__Create
Grind3LineSpring__Create: // 0x0216350C
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
	ldr r0, _0216364C // =StageTask_Main
	ldr r1, _02163650 // =GameObject__Destructor
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
	mov r0, #0xb0
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02163654 // =gameArchiveStage
	ldr r1, _02163658 // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _0216365C // =aActAcGmkGrd3lS
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x56
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, _02163660 // =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02163664 // =Grind3LineSpring__OnDefend_2163F9C
	ldr r2, _02163668 // =Grind3LineSpring__State_2163F64
	str r0, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	mov r0, r4
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	ldr r3, [r4, #0x1c]
	mov r1, #0
	orr r3, r3, #0x2100
	str r3, [r4, #0x1c]
	str r2, [r4, #0xf4]
	bl StageTask__SetAnimation
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216364C: .word StageTask_Main
_02163650: .word GameObject__Destructor
_02163654: .word gameArchiveStage
_02163658: .word 0x0000FFFF
_0216365C: .word aActAcGmkGrd3lS
_02163660: .word 0x0000FFFE
_02163664: .word Grind3LineSpring__OnDefend_2163F9C
_02163668: .word Grind3LineSpring__State_2163F64
	arm_func_end Grind3LineSpring__Create

	arm_func_start Grind3Line__Create
Grind3Line__Create: // 0x0216366C
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r6, r0
	mov r5, r1
	mov r4, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r7, _02163A6C // =0x0000117C
	ldr r0, _02163A70 // =StageTask_Main
	ldr r1, _02163A74 // =Grind3Line__Destructor
	mov r3, r2
	str r7, [sp, #8]
	bl TaskCreate_
	mov r7, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r7, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, r7
	bl GetTaskWork_
	ldr r2, _02163A6C // =0x0000117C
	mov r1, #0
	mov r7, r0
	bl MI_CpuFill8
	ldr r2, _02163A78 // =Grind3Line__Singleton
	mov r0, r7
	str r7, [r2]
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	ldrsb r0, [r6, #6]
	mov r3, #0
	ldr r2, _02163A7C // =aModGmkGrd3line
	cmp r0, #8
	movlt r0, #8
	sub r0, r0, #4
	add r0, r5, r0, lsl #18
	sub r1, r0, #0x22c000
	mov r0, #0x200
	str r1, [r7, #0xe08]
	rsb r0, r0, #0
	strh r0, [r7, #0xe]
	mov r0, #0x200
	strh r0, [r7, #0x14]
	ldr r0, [r7, #0xe04]
	add r1, r7, #0x364
	orr r0, r0, #1
	str r0, [r7, #0xe04]
	ldr r0, _02163A80 // =gameArchiveStage
	str r3, [sp]
	ldr r4, [r0]
	mov r0, r7
	str r4, [sp, #4]
	bl ObjAction3dNNModelLoad
	ldr r0, _02163A80 // =gameArchiveStage
	ldr r2, _02163A84 // =aModGmkGrd3line_0
	ldr r4, [r0]
	mov r0, r7
	add r1, r7, #0x364
	mov r3, #0
	str r4, [sp]
	bl ObjAction3dNNMotionLoad
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x12c]
	mov r1, #3
	ldr r2, [r0, #0x154]
	bl AnimatorMDL__SetAnimation
	ldr r1, [r7, #0x20]
	mov r0, #0
	orr r1, r1, #4
	str r1, [r7, #0x20]
	str r0, [r7, #0x47c]
	ldr r2, [r7, #0x20]
	ldr r1, _02163A88 // =0x000034CC
	orr r2, r2, #0x100
	str r2, [r7, #0x20]
	str r1, [r7, #0x37c]
	str r1, [r7, #0x380]
	str r1, [r7, #0x384]
	ldr r2, _02163A8C // =0x00141BB2
	ldr r1, _02163A90 // =aActAcEffGrd3lL_0
	str r2, [r7, #0x50]
	ldr r3, [r7, #0x20]
	ldr r2, _02163A80 // =gameArchiveStage
	orr r3, r3, #0x20
	str r3, [r7, #0x20]
	ldr r2, [r2]
	bl ObjDataLoad
	mov sb, r0
	add sl, r7, #0x4e0
	mov r8, #0
	mov r5, #0x860
	mov r4, #0x1d
	mov fp, #7
	b _02163884
_02163804:
	mov r1, r8, lsl #0x10
	mov r0, sb
	mov r1, r1, lsr #0x10
	bl Sprite__GetTextureSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r1, r8, lsl #0x10
	mov r6, r0
	mov r0, sb
	mov r1, r1, lsr #0x10
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocPalette
	stmia sp, {r5, r6}
	mov r3, r8, lsl #0x10
	str r0, [sp, #8]
	mov r0, sl
	mov r1, #0
	mov r2, sb
	mov r3, r3, lsr #0x10
	bl AnimatorSprite3D__Init
	strb r4, [sl, #0xa]
	mov r1, #0
	strb fp, [sl, #0xb]
	mov r0, sl
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, [sl, #0xcc]
	add r8, r8, #1
	orr r0, r0, #0x18
	str r0, [sl, #0xcc]
	add sl, sl, #0x104
_02163884:
	cmp r8, #7
	blt _02163804
	mov r8, #0
	mov r2, #0x100000
	mov r0, #0xc
	b _021638A8
_0216389C:
	mla r1, r8, r0, r7
	str r2, [r1, #0xe1c]
	add r8, r8, #1
_021638A8:
	cmp r8, #0x40
	blt _0216389C
	mov r8, #0
	mov r2, #0x100000
	mov r0, #0xc
	b _021638D0
_021638C0:
	mla r1, r8, r0, r7
	add r1, r1, #0x1000
	str r2, [r1, #0x120]
	add r8, r8, #1
_021638D0:
	cmp r8, #8
	blt _021638C0
	ldr r0, _02163A80 // =gameArchiveStage
	ldr r1, _02163A94 // =aActAcItmRing3d
	ldr r2, [r0]
	mov r0, #0
	bl ObjDataLoad
	mov r4, r0
	mov r0, #0x80
	mov r1, #0
	add r5, r7, #0x3fc
	bl VRAMSystem__AllocTexture
	mov r6, r0
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	ldr r2, _02163A98 // =0x00000844
	mov r1, #0
	stmia sp, {r2, r6}
	str r0, [sp, #8]
	add r0, r5, #0x800
	mov r2, r4
	mov r3, r1
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	strb r0, [r5, #0x80a]
	mov r0, #7
	mov r1, #0
	strb r0, [r5, #0x80b]
	add r0, r5, #0x800
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r1, [r5, #0x8cc]
	mov r0, #0x300
	orr r1, r1, #0x10
	str r1, [r5, #0x8cc]
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r5, r0
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0x860
	stmia sp, {r1, r5}
	str r0, [sp, #8]
	mov r2, r4
	add r0, r7, #0xd00
	mov r1, #0
	mov r3, #1
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	strb r0, [r7, #0xd0a]
	mov r0, #7
	mov r1, #0
	strb r0, [r7, #0xd0b]
	add r0, r7, #0xd00
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, [r7, #0xdcc]
	mov r1, #0
	orr r0, r0, #0x18
	str r0, [r7, #0xdcc]
	ldr r0, _02163A9C // =StageTask__DefaultDiffData
	str r1, [r7, #0x13c]
	str r0, [r7, #0x2fc]
	mov r2, #0x200
	add r0, r7, #0x300
	strh r2, [r0, #8]
	mov r2, #8
	strh r2, [r0, #0xa]
	sub r0, r2, #0xc8
	add r3, r7, #0x200
	strh r0, [r3, #0xf0]
	mov r2, r1
	add r0, r7, #0x218
	strh r1, [r3, #0xf2]
	bl ObjRect__SetAttackStat
	ldr r1, _02163AA0 // =0x0000FFFE
	add r0, r7, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	mov r4, #0
	add r0, r7, #0x218
	sub r1, r4, #0x80
	sub r2, r4, #0xc0
	mov r3, #0x80
	str r4, [sp]
	bl ObjRect__SetBox2D
	ldr r1, _02163AA4 // =0x00000102
	add r0, r7, #0x200
	strh r1, [r0, #0x4c]
	ldr r0, _02163AA8 // =Grind3Line__OnDefend_21649AC
	str r7, [r7, #0x234]
	str r0, [r7, #0x23c]
	ldr r1, [r7, #0x230]
	mov r0, r7
	orr r1, r1, #0x400
	str r1, [r7, #0x230]
	ldr r1, [r7, #0x1c]
	orr r1, r1, #0x100
	str r1, [r7, #0x1c]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02163A6C: .word 0x0000117C
_02163A70: .word StageTask_Main
_02163A74: .word Grind3Line__Destructor
_02163A78: .word Grind3Line__Singleton
_02163A7C: .word aModGmkGrd3line
_02163A80: .word gameArchiveStage
_02163A84: .word aModGmkGrd3line_0
_02163A88: .word 0x000034CC
_02163A8C: .word 0x00141BB2
_02163A90: .word aActAcEffGrd3lL_0
_02163A94: .word aActAcItmRing3d
_02163A98: .word 0x00000844
_02163A9C: .word StageTask__DefaultDiffData
_02163AA0: .word 0x0000FFFE
_02163AA4: .word 0x00000102
_02163AA8: .word Grind3Line__OnDefend_21649AC
	arm_func_end Grind3Line__Create

	arm_func_start Grind3LineSpikeBall__Create
Grind3LineSpikeBall__Create: // 0x02163AAC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, _02163D4C // =Grind3Line__Singleton
	mov r7, r0
	ldr r3, [r3]
	mov r6, r1
	cmp r3, #0
	mov r5, r2
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r3, #0x44]
	cmp r6, r0
	addle sp, sp, #0xc
	movle r0, #0
	ldmleia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r3, #0xe04]
	tst r0, #1
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r0, #0x1800
	str r0, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _02163D50 // =0x0000117C
	ldr r0, _02163D54 // =StageTask_Main
	ldr r1, _02163D58 // =GameObject__Destructor
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
	mov r2, #0x480
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldrsb r2, [r7, #6]
	cmp r2, #0
	movlt r2, #0
	blt _02163B8C
	cmp r2, #2
	movgt r2, #2
_02163B8C:
	ldr r0, _02163D5C // =0x00059184
	ldr r1, _02163D60 // =0x000E8A2E
	mla r0, r2, r0, r1
	str r0, [r4, #0x478]
	ldrh r0, [r7, #2]
	cmp r0, #0x7a
	beq _02163BB0
	cmp r0, #0x7b
	beq _02163C88
_02163BB0:
	mov r0, #0xb1
	bl GetObjectFileWork
	mov r3, #0
	str r3, [sp]
	str r0, [sp, #4]
	ldr r0, _02163D64 // =gameArchiveStage
	ldr r2, _02163D68 // =aActAcGmkBallSi
	ldr r5, [r0]
	mov r0, r4
	add r1, r4, #0x364
	str r5, [sp, #8]
	bl ObjObjectAction3dBACLoad
	mov r0, #0xb2
	bl GetObjectFileWork
	mov r3, r0
	mov r0, r4
	mov r1, #0x800
	mov r2, #0x10
	bl ObjObjectActionAllocTexture
	mov r0, #0xb2
	bl GetObjectFileWork
	ldrh r0, [r0, #4]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _02163C3C
	ldr r0, [r4, #0x430]
	mov r2, r4
	orr r0, r0, #0x60
	str r0, [r4, #0x430]
	ldr r1, [r4, #0x104]
	add r0, r4, #0x364
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, [r4, #0x430]
	orr r0, r0, #0x18
	str r0, [r4, #0x430]
_02163C3C:
	add r0, r4, #0x218
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, _02163D6C // =0x0000FFFF
	add r0, r4, #0x218
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x230]
	mov r0, #0x2800
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x20]
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	b _02163D14
_02163C88:
	ldr r0, _02163D4C // =Grind3Line__Singleton
	add r1, r4, #0x364
	ldr r0, [r0]
	mov r2, #0x104
	add r0, r0, #0xd00
	bl MI_CpuCopy8
	mov r5, #4
	str r4, [r4, #0x234]
	mov r0, #8
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	add r0, r4, #0x218
	sub r1, r5, #0xc
	sub r2, r5, #0x14
	sub r3, r5, #8
	str r5, [sp, #8]
	bl ObjRect__SetBox3D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _02163D70 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x230]
	ldr r0, _02163D74 // =Grind3LineSpikeBall__OnDefend_2164CB4
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	str r0, [r4, #0x23c]
	mov r0, #0x2800
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
_02163D14:
	ldr r0, [r4, #0x18]
	ldr r1, _02163D78 // =Grind3LineSpikeBall__State_2164A40
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x1c]
	mov r0, r4
	orr r2, r2, #0x2100
	str r2, [r4, #0x1c]
	ldr r2, [r4, #0x20]
	orr r2, r2, #0x20
	str r2, [r4, #0x20]
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02163D4C: .word Grind3Line__Singleton
_02163D50: .word 0x0000117C
_02163D54: .word StageTask_Main
_02163D58: .word GameObject__Destructor
_02163D5C: .word 0x00059184
_02163D60: .word 0x000E8A2E
_02163D64: .word gameArchiveStage
_02163D68: .word aActAcGmkBallSi
_02163D6C: .word 0x0000FFFF
_02163D70: .word 0x0000FFFE
_02163D74: .word Grind3LineSpikeBall__OnDefend_2164CB4
_02163D78: .word Grind3LineSpikeBall__State_2164A40
	arm_func_end Grind3LineSpikeBall__Create

	arm_func_start Grind3LineRingLoss__Create
Grind3LineRingLoss__Create: // 0x02163D7C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x18
	ldr r1, _02163F44 // =Grind3Line__Singleton
	mov r8, r0
	ldr r0, [r1]
	ldr r4, _02163F48 // =0x00000488
	cmp r0, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r0, [r0, #0xe04]
	tst r0, #1
	addne sp, sp, #0x18
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, #0x1800
	mov r2, #0
	str r0, [sp]
	mov r5, #2
	str r5, [sp, #4]
	add r5, r4, #0x1e4
	ldr r0, _02163F4C // =StageTask_Main
	ldr r1, _02163F50 // =GameObject__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, r5
	bl GetTaskWork_
	add r2, r4, #0x1e4
	mov r1, #0
	mov r5, r0
	bl MI_CpuFill8
	mov r0, #3
	strh r0, [r5]
	bl GetStageRingScale
	str r0, [r5, #0x38]
	str r0, [r5, #0x3c]
	str r0, [r5, #0x40]
	add r0, r8, #0x600
	ldrsh sl, [r0, #0x7e]
	mov r1, #0
	add lr, r5, #0x16c
	strh r1, [r0, #0x7e]
	cmp sl, #0x40
	movgt sl, #0x40
	add ip, sp, #0xc
	str sl, [r5, #0x168]
	add r0, r8, #0x44
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r0, _02163F54 // =ringManagerWork
	ldrb r1, [r8, #0x5d1]
	ldr r0, [r0]
	cmp sl, #0
	add r0, r0, r1
	ldrb r1, [r0, #0x364]
	add r0, r5, #0x6c
	add r8, r0, #0x400
	add sb, lr, #0x400
	add r4, r4, r1, lsl #8
	mov fp, #0
	ble _02163F14
	ldr r3, _02163F58 // =FX_SinCosTable_
_02163E88:
	ldmia ip, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	cmp r4, #0
	blt _02163EF4
	mov r1, r4, lsl #0x18
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	mov r2, r1, lsl #1
	add r1, r3, r1, lsl #1
	ldrsh r6, [r3, r2]
	ldrsh r2, [r1, #2]
	mov r0, r4, asr #8
	cmp r0, #6
	add r1, r4, #0x10
	rsbge r0, r0, #9
	mov r4, r6, lsl #4
	mov r4, r4, asr r0
	mov r2, r2, lsl #4
	mov r0, r2, asr r0
	sub r6, r4, r4, asr #2
	sub r7, r0, r0, asr #2
	orr r4, r1, #0x80
_02163EF4:
	str r6, [r8], #4
	add fp, fp, #1
	cmp fp, sl
	str r7, [sb], #4
	rsb r4, r4, #0
	rsb r6, r6, #0
	add lr, lr, #0xc
	blt _02163E88
_02163F14:
	ldr r0, [r5, #0x18]
	ldr r1, _02163F5C // =Grind3LineRingLoss__Draw_2164E10
	orr r0, r0, #0x10
	str r0, [r5, #0x18]
	ldr r2, [r5, #0x1c]
	ldr r0, _02163F60 // =Grind3LineRingLoss__State_2164D08
	orr r2, r2, #0x2100
	str r2, [r5, #0x1c]
	str r1, [r5, #0xfc]
	str r0, [r5, #0xf4]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02163F44: .word Grind3Line__Singleton
_02163F48: .word 0x00000488
_02163F4C: .word StageTask_Main
_02163F50: .word GameObject__Destructor
_02163F54: .word ringManagerWork
_02163F58: .word FX_SinCosTable_
_02163F5C: .word Grind3LineRingLoss__Draw_2164E10
_02163F60: .word Grind3LineRingLoss__State_2164D08
	arm_func_end Grind3LineRingLoss__Create

	arm_func_start Grind3LineSpring__State_2163F64
Grind3LineSpring__State_2163F64: // 0x02163F64
	stmdb sp!, {r3, lr}
	add r1, r0, #0x100
	ldrh r1, [r1, #0x74]
	cmp r1, #1
	ldmneia sp!, {r3, pc}
	ldr r1, [r0, #0x20]
	tst r1, #8
	ldmeqia sp!, {r3, pc}
	ldr r2, [r0, #0x230]
	mov r1, #0
	bic r2, r2, #0x100
	str r2, [r0, #0x230]
	bl StageTask__SetAnimation
	ldmia sp!, {r3, pc}
	arm_func_end Grind3LineSpring__State_2163F64

	arm_func_start Grind3LineSpring__OnDefend_2163F9C
Grind3LineSpring__OnDefend_2163F9C: // 0x02163F9C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	cmp r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [r4, #0x44]
	mov r0, r4
	str r1, [r5, #0x44]
	ldr r2, [r4, #0x48]
	mov r1, #1
	str r2, [r5, #0x48]
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x340]
	ldrsb ip, [r0, #6]
	cmp ip, #0x30
	movlt ip, #0x30
	blt _02163FFC
	cmp ip, #0x40
	movgt ip, #0x40
_02163FFC:
	ldr r1, _02164048 // =0xB60B60B7
	mov r3, ip, lsl #0xf
	smull r0, r2, r1, r3
	add r2, r2, ip, lsl #15
	mov ip, r3, lsr #0x1f
	ldr r3, _0216404C // =0xFFFEEEF0
	mov r0, r5
	mov r1, r4
	add r2, ip, r2, asr #6
	bl Player__Func_201D684
	add r0, r5, #0x500
	mov r1, #0x5a
	ldr r2, _02164050 // =0x00000611
	strh r1, [r0, #0xfa]
	mov r0, r5
	mov r1, r4
	str r2, [r5, #0xd8]
	bl Player__Action_AllowTrickCombos
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02164048: .word 0xB60B60B7
_0216404C: .word 0xFFFEEEF0
_02164050: .word 0x00000611
	arm_func_end Grind3LineSpring__OnDefend_2163F9C

	arm_func_start Grind3Line__Destructor
Grind3Line__Destructor: // 0x02164054
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, #0
	ldr r5, _021640D4 // =Grind3Line__Singleton
	mov r4, r0
	mov r7, r6
_02164068:
	ldr r0, [r5]
	add r0, r0, #0x4e0
	add r0, r0, r7
	bl AnimatorSprite3D__Release
	add r6, r6, #1
	cmp r6, #7
	add r7, r7, #0x104
	blt _02164068
	ldr r0, _021640D4 // =Grind3Line__Singleton
	ldr r0, [r0]
	add r0, r0, #0x3fc
	add r0, r0, #0x800
	bl AnimatorSprite3D__Release
	ldr r0, _021640D4 // =Grind3Line__Singleton
	ldr r0, [r0]
	add r0, r0, #0xd00
	bl AnimatorSprite3D__Release
	ldr r2, _021640D4 // =Grind3Line__Singleton
	mov r3, #0
	ldr r1, _021640D8 // =g_obj
	mov r0, #0x1000
	str r3, [r2]
	str r3, [r1, #0x14]
	bl SetStageRingScale
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021640D4: .word Grind3Line__Singleton
_021640D8: .word g_obj
	arm_func_end Grind3Line__Destructor

	arm_func_start Grind3Line__State_21640DC
Grind3Line__State_21640DC: // 0x021640DC
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _021641D0 // =0x00141BB2
	mov r5, r0
	str r1, [r5, #0x50]
	ldrh r0, [r5, #0x30]
	cmp r0, #0
	beq _02164164
	sub r0, r0, #0x350
	strh r0, [r5, #0x30]
	ldrh r0, [r5, #0x30]
	cmp r0, #0
	beq _02164114
	cmp r0, #0x8000
	bls _0216411C
_02164114:
	mov r0, #0
	strh r0, [r5, #0x30]
_0216411C:
	add r0, r5, #0x388
	bl MTX_Identity33_
	ldrh r1, [r5, #0x30]
	ldr r3, _021641D4 // =FX_SinCosTable_
	add r0, r5, #0x388
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	blx MTX_RotX33_
_02164164:
	ldr r4, [r5, #0x35c]
	ldr r0, [r4, #0x6d8]
	cmp r0, r5
	bne _02164180
	ldr r0, [r4, #0x5d8]
	tst r0, #0x400
	beq _0216419C
_02164180:
	mov r1, #0
	ldr r0, _021641D8 // =Grind3Line__State_216497C
	str r1, [r5, #0x35c]
	str r0, [r5, #0xf4]
	mov r0, #0x258
	str r0, [r5, #0x28]
	ldmia sp!, {r3, r4, r5, pc}
_0216419C:
	ldr r0, [r4, #0x1c]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl Player__Gimmick_Grind3Line
	ldr r1, [r4, #0x5dc]
	ldr r0, _021641DC // =Grind3Line__State_21641E0
	orr r1, r1, #0x600
	str r1, [r4, #0x5dc]
	str r0, [r5, #0xf4]
	mov r0, #0x400
	str r0, [r5, #0xe0c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021641D0: .word 0x00141BB2
_021641D4: .word FX_SinCosTable_
_021641D8: .word Grind3Line__State_216497C
_021641DC: .word Grind3Line__State_21641E0
	arm_func_end Grind3Line__State_21640DC

	arm_func_start Grind3Line__State_21641E0
Grind3Line__State_21641E0: // 0x021641E0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x50
	ldr r1, _0216479C // =0x00141BB2
	mov r6, r0
	str r1, [r6, #0x50]
	ldr r4, [r6, #0x35c]
	ldr r0, [r4, #0x6d8]
	cmp r0, r6
	bne _02164210
	ldr r0, [r4, #0x5d8]
	tst r0, #0x400
	beq _02164230
_02164210:
	mov r1, #0
	ldr r0, _021647A0 // =Grind3Line__State_216497C
	str r1, [r6, #0x35c]
	str r0, [r6, #0xf4]
	mov r0, #0x258
	add sp, sp, #0x50
	str r0, [r6, #0x28]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
_02164230:
	ldr r2, [r6, #0x44]
	ldr r1, [r6, #0xe08]
	cmp r1, r2
	bgt _02164280
	mov r0, r4
	bl Player__Func_201DD24
	ldr r1, [r4, #0x5dc]
	ldr r0, _021647A4 // =g_obj
	bic r1, r1, #0x600
	str r1, [r4, #0x5dc]
	mov r1, #0
	str r1, [r0, #0x14]
	str r1, [r6, #0x47c]
	ldr r1, [r6, #0xe04]
	ldr r0, _021647A8 // =Grind3Line__State_216492C
	orr r1, r1, #2
	str r1, [r6, #0xe04]
	add sp, sp, #0x50
	str r0, [r6, #0xf4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
_02164280:
	sub r0, r1, #0x9600
	cmp r0, r2
	bgt _021642A8
	ldr r0, [r6, #0xe04]
	orr r0, r0, #1
	str r0, [r6, #0xe04]
	ldr r0, [r4, #0x5d8]
	orr r0, r0, #0x200000
	str r0, [r4, #0x5d8]
	b _021642C0
_021642A8:
	ldr r0, _021647AC // =0xFFFE0200
	add r0, r1, r0
	cmp r0, r2
	ldrle r0, [r6, #0xe04]
	orrle r0, r0, #1
	strle r0, [r6, #0xe04]
_021642C0:
	ldr r0, [r6, #0xe0c]
	add r0, r0, #0x10
	str r0, [r6, #0xe0c]
	cmp r0, #0x1000
	movgt r0, #0x1000
	strgt r0, [r6, #0xe0c]
	ldr r1, [r6, #0xe0c]
	mov r0, #0x600
	mul r2, r1, r0
	mov r0, r2, asr #0xb
	add r0, r2, r0, lsr #20
	ldr r1, _021647A4 // =g_obj
	mov r0, r0, asr #0xc
	str r0, [r1, #0x14]
	ldr r0, _021647B0 // =mapCamera
	ldr r2, [r6, #0xe0c]
	ldr r0, [r0, #0xe0]
	mov r1, r2, lsl #1
	tst r0, #1
	add r5, r1, r2, lsl #2
	beq _02164330
	mov r1, r5
	mov r0, #0
	bl MapFarSys__AdvanceScrollSpeed
	mov r1, r5
	mov r0, #1
	bl MapFarSys__AdvanceScrollSpeed
	b _0216433C
_02164330:
	ldrb r0, [r4, #0x5d3]
	mov r1, r5
	bl MapFarSys__AdvanceScrollSpeed
_0216433C:
	ldr r0, [r6, #0xe0c]
	ldr r2, _021647B4 // =0x88888889
	mov r1, r0, lsl #0xc
	mov r0, r1, asr #0xb
	add r0, r1, r0, lsr #20
	mov r0, r0, asr #0xc
	mov r7, r0, lsl #2
	mov r3, r7, lsl #0xe
	smull r0, r5, r2, r3
	mov r0, r3, lsr #0x1f
	add r5, r5, r7, lsl #14
	mov r1, #0
	add r5, r0, r5, asr #5
	add r4, r6, #0x3fc
	mov r2, r1
	str r7, [r6, #0x47c]
	mov r5, r5, asr #0xe
	add r3, r6, #0xe00
	add r0, r4, #0x800
	strh r5, [r3, #0x14]
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, _021647B8 // =_021884D4
	add r4, r6, #0x218
	mov r5, #0x1100
	str r5, [sp, #0x1c]
	add r3, sp, #0x38
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0x190000
	str r0, [sp, #0x14]
	add r0, r6, #0x4e0
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	ldr r7, _021647BC // =Grind3Line__Singleton
	rsb r0, r0, #0
	add r4, r4, #0xc00
	mvn fp, #0
	mov r5, #0
	str r0, [sp, #0x14]
_021643D8:
	ldr r0, [r4, #4]
	cmp r0, #0x100000
	moveq fp, r5
	beq _02164514
	ldr r0, [r7]
	ldrh r1, [r4, #8]
	add r0, r0, #0xe00
	ldrh r0, [r0, #0x14]
	add r0, r0, r0, asr #2
	sub r0, r1, r0
	strh r0, [r4, #8]
	ldrh r1, [r4, #8]
	ldr r0, _021647C0 // =0x00006AAC
	cmp r1, r0
	bls _02164424
	ldr r0, [r4, #4]
	ldr r1, [sp, #0x14]
	cmp r0, r1
	bge _02164434
_02164424:
	mov r0, #0x100000
	str r0, [r4, #4]
	mov fp, r5
	b _02164514
_02164434:
	ldr r2, [r7]
	add r1, sp, #0x44
	add r2, r2, #0xe00
	ldrh r8, [r2, #0x14]
	mov r2, #0
	add r3, sp, #0x38
	mov r8, r8, lsl #4
	rsb r8, r8, #0
	add r0, r0, r8
	str r0, [r4, #4]
	ldrh r0, [r4, #0xa]
	ldrh sl, [r4, #8]
	ldr ip, [r4]
	add r8, r0, r0, lsl #6
	ldr r0, [sp, #0x10]
	mov sl, sl, asr #4
	add r0, r0, r8, lsl #2
	ldr r8, _021647C4 // =FX_SinCosTable_
	ldr sb, [r7]
	add r8, r8, sl, lsl #2
	ldrsh sl, [r8, #2]
	ldr r8, [sb, #0x44]
	smull lr, ip, sl, ip
	adds lr, lr, #0x800
	mov sl, r2
	adc sl, ip, sl
	mov ip, lr, lsr #0xc
	orr ip, ip, sl, lsl #20
	add sl, r8, ip
	ldr r8, _0216479C // =0x00141BB2
	add r8, sl, r8
	str r8, [sp, #0x44]
	ldr r8, [sb, #0x48]
	ldr sb, [r4, #4]
	add r8, sb, r8
	str r8, [sp, #0x48]
	ldrh r8, [r4, #8]
	ldr sb, [r4]
	mov r8, r8, asr #4
	mov sl, r8, lsl #2
	ldr r8, _021647C4 // =FX_SinCosTable_
	ldrsh r8, [r8, sl]
	smull sl, sb, r8, sb
	adds sl, sl, #0x800
	mov r8, r2
	adc r8, sb, r8
	mov sb, sl, lsr #0xc
	orr sb, sb, r8, lsl #20
	str sb, [sp, #0x4c]
	add r8, sp, #0x1c
	str r8, [sp]
	mov r8, r2
	str r8, [sp, #4]
	str r8, [sp, #8]
	str r8, [sp, #0xc]
	bl StageTask__Draw3DEx
_02164514:
	add r5, r5, #1
	cmp r5, #0x40
	add r4, r4, #0xc
	blt _021643D8
	ldr r0, [r6, #0xe04]
	tst r0, #3
	bne _021645A4
	add r0, r6, #0xe00
	ldrsh r1, [r0, #0x16]
	sub r1, r1, #1
	strh r1, [r0, #0x16]
	ldrsh r0, [r0, #0x16]
	cmp r0, #0
	bgt _021645A4
	mvn r0, #0
	cmp fp, r0
	beq _021645A4
	ldr r1, _021647BC // =Grind3Line__Singleton
	add r0, r6, #0x218
	ldr r3, [r1]
	add r2, r0, #0xc00
	add r0, r3, #0xe00
	ldrh r3, [r0, #0x14]
	mov r1, #0xc
	mla r0, fp, r1, r2
	rsb r4, r3, #0x100
	bl Grind3Line__Func_21647D8
	mov r0, r4, asr #5
	add r1, r0, r4, asr #3
	cmp r1, #3
	movlt r1, #3
	blt _0216459C
	cmp r1, #0x30
	movgt r1, #0x30
_0216459C:
	add r0, r6, #0xe00
	strh r1, [r0, #0x16]
_021645A4:
	ldr r0, _021647C8 // =_021884E0
	add r3, sp, #0x20
	ldmia r0, {r0, r1, r2}
	mov r5, #0x1100
	add r4, r6, #0x11c
	str r5, [sp, #0x18]
	add r5, r4, #0x1000
	stmia r3, {r0, r1, r2}
	ldr r4, _021647C4 // =FX_SinCosTable_
	mvn r8, #0
	mov r7, #0
	add sb, r6, #0x2f8
_021645D4:
	ldr r0, [r5, #4]
	cmp r0, #0x100000
	moveq r8, r7
	beq _021646D4
	ldr r0, _021647BC // =Grind3Line__Singleton
	ldrh r1, [r5, #8]
	ldr r0, [r0]
	add r0, r0, #0xe00
	ldrh r0, [r0, #0x14]
	sub r0, r1, r0
	strh r0, [r5, #8]
	ldrh r1, [r5, #8]
	ldr r0, _021647C0 // =0x00006AAC
	cmp r1, r0
	bhi _02164620
	mov r0, #0x100000
	str r0, [r5, #4]
	mov r8, r7
	b _021646D4
_02164620:
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	add r0, r4, r0, lsl #2
	ldrsh r3, [r0, #2]
	ldr r2, [r5]
	ldr r0, _021647BC // =Grind3Line__Singleton
	smull fp, sl, r3, r2
	adds r3, fp, #0x800
	ldr r1, [r0]
	adc r2, sl, #0
	mov r3, r3, lsr #0xc
	ldr r0, [r1, #0x44]
	orr r3, r3, r2, lsl #20
	add r2, r0, r3
	ldr r0, _0216479C // =0x00141BB2
	add r3, sp, #0x20
	add r0, r2, r0
	str r0, [sp, #0x2c]
	ldr r1, [r1, #0x48]
	ldr r2, [r5, #4]
	add r0, sb, #0x800
	add r1, r2, r1
	str r1, [sp, #0x30]
	ldrh r2, [r5, #8]
	ldr fp, [r5]
	add r1, sp, #0x2c
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh sl, [r4, r2]
	mov r2, #0
	smull ip, fp, sl, fp
	adds sl, ip, #0x800
	mov ip, r2
	adc fp, fp, ip
	mov sl, sl, lsr #0xc
	orr sl, sl, fp, lsl #20
	str sl, [sp, #0x34]
	add sl, sp, #0x18
	str sl, [sp]
	mov sl, r2
	str sl, [sp, #4]
	str sl, [sp, #8]
	str sl, [sp, #0xc]
	bl StageTask__Draw3DEx
_021646D4:
	add r7, r7, #1
	cmp r7, #8
	add r5, r5, #0xc
	blt _021645D4
	ldr r0, [r6, #0xe04]
	tst r0, #3
	addne sp, sp, #0x50
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	add r0, r6, #0x1100
	ldrsh r1, [r0, #0x18]
	sub r1, r1, #1
	strh r1, [r0, #0x18]
	ldrsh r0, [r0, #0x18]
	cmp r0, #0
	addgt sp, sp, #0x50
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mvn r0, #0
	cmp r8, r0
	addeq sp, sp, #0x50
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r1, _021647BC // =Grind3Line__Singleton
	add r0, r6, #0x11c
	ldr r3, [r1]
	add r2, r0, #0x1000
	add r0, r3, #0xe00
	ldrh r3, [r0, #0x14]
	mov r1, #0xc
	mla r0, r8, r1, r2
	rsb r4, r3, #0x100
	bl Grind3Line__Func_21648CC
	cmp r4, #0x14
	movlt r4, #0x14
	blt _02164760
	cmp r4, #0xa5
	movgt r4, #0xa5
_02164760:
	ldr r3, _021647CC // =_mt_math_rand
	ldr r0, _021647D0 // =0x00196225
	ldr r5, [r3]
	ldr r1, _021647D4 // =0x3C6EF35F
	add r2, r6, #0x1100
	mla r1, r5, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	str r1, [r3]
	add r0, r0, r4
	strh r0, [r2, #0x18]
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_0216479C: .word 0x00141BB2
_021647A0: .word Grind3Line__State_216497C
_021647A4: .word g_obj
_021647A8: .word Grind3Line__State_216492C
_021647AC: .word 0xFFFE0200
_021647B0: .word mapCamera
_021647B4: .word 0x88888889
_021647B8: .word _021884D4
_021647BC: .word Grind3Line__Singleton
_021647C0: .word 0x00006AAC
_021647C4: .word FX_SinCosTable_
_021647C8: .word _021884E0
_021647CC: .word _mt_math_rand
_021647D0: .word 0x00196225
_021647D4: .word 0x3C6EF35F
	arm_func_end Grind3Line__State_21641E0

	arm_func_start Grind3Line__Func_21647D8
Grind3Line__Func_21647D8: // 0x021647D8
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	ldr r5, _021648AC // =_021884EC
	add r4, sp, #0
	mov r3, #4
_021647EC:
	ldrh r2, [r5]
	ldrh r1, [r5, #2]
	add r5, r5, #4
	strh r2, [r4]
	strh r1, [r4, #2]
	add r4, r4, #4
	subs r3, r3, #1
	bne _021647EC
	ldr lr, _021648B0 // =_mt_math_rand
	ldr r3, _021648B4 // =0x00196225
	ldr r1, [lr]
	ldr ip, _021648B8 // =0x3C6EF35F
	ldr r2, _021648BC // =0x000001FF
	mla r4, r1, r3, ip
	mov r1, r4, lsr #0x10
	mov r1, r1, lsl #0x10
	and r1, r2, r1, lsr #16
	rsb r1, r1, #0x80
	str r4, [lr]
	mov r1, r1, lsl #0xc
	str r1, [r0, #4]
	ldr r1, [lr]
	ldr r2, _021648C0 // =0x000034CC
	mla r5, r1, r3, ip
	mov r1, r5, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r4, r1, #0x3f
	ldr r1, _021648C4 // =0x00141BB2
	sub r4, r4, #0x1f
	mla r2, r4, r2, r1
	str r5, [lr]
	str r2, [r0]
	ldr r1, _021648C8 // =0x0000D554
	add r2, sp, #0
	strh r1, [r0, #8]
	ldr r1, [lr]
	mla r3, r1, r3, ip
	mov r1, r3, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x1d
	mov r1, r1, lsr #0x1c
	ldrh r1, [r2, r1]
	str r3, [lr]
	strh r1, [r0, #0xa]
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021648AC: .word _021884EC
_021648B0: .word _mt_math_rand
_021648B4: .word 0x00196225
_021648B8: .word 0x3C6EF35F
_021648BC: .word 0x000001FF
_021648C0: .word 0x000034CC
_021648C4: .word 0x00141BB2
_021648C8: .word 0x0000D554
	arm_func_end Grind3Line__Func_21647D8

	arm_func_start Grind3Line__Func_21648CC
Grind3Line__Func_21648CC: // 0x021648CC
	stmdb sp!, {r3, lr}
	ldr r3, _02164918 // =_mt_math_rand
	ldr r1, _0216491C // =0x00196225
	ldr lr, [r3]
	ldr r2, _02164920 // =0x3C6EF35F
	ldr ip, _02164924 // =0x001CF9F6
	mla r2, lr, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0x1f
	add r1, r1, #8
	str r2, [r3]
	mov r1, r1, lsl #0xc
	str r1, [r0, #4]
	ldr r1, _02164928 // =0x0000D8E2
	str ip, [r0]
	strh r1, [r0, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02164918: .word _mt_math_rand
_0216491C: .word 0x00196225
_02164920: .word 0x3C6EF35F
_02164924: .word 0x001CF9F6
_02164928: .word 0x0000D8E2
	arm_func_end Grind3Line__Func_21648CC

	arm_func_start Grind3Line__State_216492C
Grind3Line__State_216492C: // 0x0216492C
	ldr r1, [r0, #0x35c]
	ldr r1, [r1, #0x2c]
	cmp r1, #0
	strne r1, [r0, #0xe10]
	ldr r1, _02164974 // =0x00141BB2
	str r1, [r0, #0x50]
	ldr r1, [r0, #0xe10]
	str r1, [r0, #0x58]
	ldr r1, [r0, #0x35c]
	ldr r1, [r1, #0x28]
	cmp r1, #0
	bxeq lr
	ldr r1, _02164978 // =Grind3Line__State_216497C
	str r1, [r0, #0xf4]
	ldr r1, [r0, #0x35c]
	ldr r1, [r1, #0x28]
	str r1, [r0, #0x28]
	bx lr
	.align 2, 0
_02164974: .word 0x00141BB2
_02164978: .word Grind3Line__State_216497C
	arm_func_end Grind3Line__State_216492C

	arm_func_start Grind3Line__State_216497C
Grind3Line__State_216497C: // 0x0216497C
	ldr r1, [r0, #0x28]
	subs r1, r1, #1
	str r1, [r0, #0x28]
	ldreq r1, [r0, #0x18]
	orreq r1, r1, #4
	streq r1, [r0, #0x18]
	ldr r1, _021649A8 // =0x00141BB2
	str r1, [r0, #0x50]
	ldr r1, [r0, #0xe10]
	str r1, [r0, #0x58]
	bx lr
	.align 2, 0
_021649A8: .word 0x00141BB2
	arm_func_end Grind3Line__State_216497C

	arm_func_start Grind3Line__OnDefend_21649AC
Grind3Line__OnDefend_21649AC: // 0x021649AC
	stmdb sp!, {r4, lr}
	ldr r4, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r4, #0
	cmpne r0, #0
	ldmeqia sp!, {r4, pc}
	ldrh r1, [r0]
	cmp r1, #1
	ldmneia sp!, {r4, pc}
	ldr r2, [r0, #0xf4]
	ldr r1, _02164A38 // =Player__State_201D748
	cmp r2, r1
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0xe04]
	mov r1, r4
	bic r2, r2, #1
	str r2, [r4, #0xe04]
	ldr r2, [r4, #0x230]
	bic r2, r2, #4
	str r2, [r4, #0x230]
	str r0, [r4, #0x35c]
	bl Player__Func_201D7BC
	mov r0, #0x2000
	bl SetStageRingScale
	ldr r1, _02164A3C // =Grind3Line__State_21640DC
	mov r0, #0x3000
	str r1, [r4, #0xf4]
	strh r0, [r4, #0x30]
	ldr r1, [r4, #0x20]
	mov r0, #0
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	str r0, [r4, #0x47c]
	str r4, [r4, #0x2d8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164A38: .word Player__State_201D748
_02164A3C: .word Grind3Line__State_21640DC
	arm_func_end Grind3Line__OnDefend_21649AC

	arm_func_start Grind3LineSpikeBall__State_2164A40
Grind3LineSpikeBall__State_2164A40: // 0x02164A40
	stmdb sp!, {r4, lr}
	ldr r1, _02164AC4 // =Grind3Line__Singleton
	mov r4, r0
	ldr r2, [r1]
	cmp r2, #0
	beq _02164A64
	ldr r1, [r2, #0xe04]
	tst r1, #3
	beq _02164A74
_02164A64:
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
_02164A74:
	ldr r1, [r2, #0x44]
	ldr r2, [r4, #0x44]
	add r1, r1, #0xa0000
	cmp r2, r1
	ldmgtia sp!, {r4, pc}
	ldr r2, _02164AC8 // =0x0000CE38
	add r1, r4, #0x400
	strh r2, [r1, #0x7c]
	ldr r2, [r4, #0x20]
	ldr r1, _02164ACC // =Grind3LineSpikeBall__State_2164AD4
	bic r2, r2, #0x20
	str r2, [r4, #0x20]
	str r1, [r4, #0xf4]
	bl Grind3LineSpikeBall__State_2164AD4
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x7b
	ldreq r0, _02164AD0 // =Grind3LineSpikeBall__Draw_2164C00
	streq r0, [r4, #0xfc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164AC4: .word Grind3Line__Singleton
_02164AC8: .word 0x0000CE38
_02164ACC: .word Grind3LineSpikeBall__State_2164AD4
_02164AD0: .word Grind3LineSpikeBall__Draw_2164C00
	arm_func_end Grind3LineSpikeBall__State_2164A40

	arm_func_start Grind3LineSpikeBall__State_2164AD4
Grind3LineSpikeBall__State_2164AD4: // 0x02164AD4
	stmdb sp!, {r4, lr}
	ldr r3, _02164BEC // =Grind3Line__Singleton
	ldr r4, [r3]
	cmp r4, #0
	ldrne r1, _02164BF0 // =g_obj
	ldrne r1, [r1, #0x14]
	cmpne r1, #0
	beq _02164B00
	ldr r1, [r4, #0xe04]
	tst r1, #2
	beq _02164B10
_02164B00:
	ldr r1, [r0, #0x18]
	orr r1, r1, #4
	str r1, [r0, #0x18]
	ldmia sp!, {r4, pc}
_02164B10:
	add r2, r0, #0x400
	add r1, r4, #0xe00
	ldrh ip, [r2, #0x7c]
	ldrh r4, [r1, #0x14]
	ldr r1, _02164BF4 // =0x000071C8
	sub r4, ip, r4
	strh r4, [r2, #0x7c]
	ldrh r2, [r2, #0x7c]
	cmp r2, r1
	bhi _02164B48
	ldr r1, [r0, #0x18]
	orr r1, r1, #4
	str r1, [r0, #0x18]
	ldmia sp!, {r4, pc}
_02164B48:
	ldr r1, [r0, #0x340]
	ldrh r1, [r1, #2]
	cmp r1, #0x7a
	bne _02164B68
	ldr r1, [r3]
	ldr r1, [r1, #0x47c]
	mov r1, r1, asr #1
	str r1, [r0, #0x42c]
_02164B68:
	add r2, r0, #0x400
	ldrh r3, [r2, #0x7c]
	ldr r1, _02164BEC // =Grind3Line__Singleton
	ldr lr, _02164BF8 // =FX_SinCosTable_
	mov r3, r3, asr #4
	mov r3, r3, lsl #1
	add r3, r3, #1
	mov r3, r3, lsl #1
	ldrsh ip, [lr, r3]
	ldr r3, [r0, #0x478]
	ldr r4, [r1]
	smull r3, r1, ip, r3
	adds r3, r3, #0x800
	adc r1, r1, #0
	mov r3, r3, lsr #0xc
	ldr ip, [r4, #0x44]
	orr r3, r3, r1, lsl #20
	ldr r1, _02164BFC // =0x00141BB2
	add r3, ip, r3
	add r1, r3, r1
	str r1, [r0, #0x44]
	ldrh r2, [r2, #0x7c]
	ldr r1, [r0, #0x478]
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r2, [lr, r2]
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x4c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164BEC: .word Grind3Line__Singleton
_02164BF0: .word g_obj
_02164BF4: .word 0x000071C8
_02164BF8: .word FX_SinCosTable_
_02164BFC: .word 0x00141BB2
	arm_func_end Grind3LineSpikeBall__State_2164AD4

	arm_func_start Grind3LineSpikeBall__Draw_2164C00
Grind3LineSpikeBall__Draw_2164C00: // 0x02164C00
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x354]
	mov r2, #0
	tst r0, #1
	add r0, sp, #0x10
	beq _02164C70
	mov r1, #0x100
	str r1, [sp, #0x10]
	str r0, [sp]
	str r2, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	add r0, r4, #0x364
	add r1, r4, #0x44
	add r3, r4, #0x38
	bl StageTask__Draw3DEx
	ldr r0, [sp, #0x10]
	tst r0, #0x40000000
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x18]
	add sp, sp, #0x14
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, pc}
_02164C70:
	ldr r1, _02164CAC // =0x00001104
	add r3, r4, #0x38
	str r1, [sp, #0x10]
	str r0, [sp]
	str r2, [sp, #4]
	str r2, [sp, #8]
	ldr r0, _02164CB0 // =Grind3Line__Singleton
	str r2, [sp, #0xc]
	ldr r0, [r0]
	add r1, r4, #0x44
	add r0, r0, #0x3fc
	add r0, r0, #0x800
	bl StageTask__Draw3DEx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02164CAC: .word 0x00001104
_02164CB0: .word Grind3Line__Singleton
	arm_func_end Grind3LineSpikeBall__Draw_2164C00

	arm_func_start Grind3LineSpikeBall__OnDefend_2164CB4
Grind3LineSpikeBall__OnDefend_2164CB4: // 0x02164CB4
	stmdb sp!, {r4, lr}
	ldr r4, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r4, #0
	ldmeqia sp!, {r4, pc}
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldrh r1, [r0]
	cmp r1, #1
	ldreqb r1, [r0, #0x5d1]
	cmpeq r1, #0
	ldmneia sp!, {r4, pc}
	mov r1, #1
	bl Player__GiveRings
	ldr r1, [r4, #0x354]
	mov r0, #0
	orr r1, r1, #1
	orr r1, r1, #0x10000
	str r1, [r4, #0x354]
	str r0, [r4, #0x234]
	ldmia sp!, {r4, pc}
	arm_func_end Grind3LineSpikeBall__OnDefend_2164CB4

	arm_func_start Grind3LineRingLoss__State_2164D08
Grind3LineRingLoss__State_2164D08: // 0x02164D08
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0xc
	ldr r1, _02164E04 // =Grind3Line__Singleton
	mov sl, r0
	ldr r1, [r1]
	ldr r6, [sl, #0x168]
	cmp r1, #0
	ldrne r0, _02164E08 // =g_obj
	mov fp, #1
	ldrne r0, [r0, #0x14]
	cmpne r0, #0
	beq _02164D44
	ldr r0, [r1, #0xe04]
	tst r0, #2
	beq _02164D58
_02164D44:
	ldr r0, [sl, #0x18]
	add sp, sp, #0xc
	orr r0, r0, #4
	str r0, [sl, #0x18]
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_02164D58:
	add r7, sl, #0x16c
	add r0, sl, #0x6c
	cmp r6, #0
	add r8, r0, #0x400
	add sb, r7, #0x400
	mov r5, #0
	ble _02164DEC
	mov r4, r5
_02164D78:
	ldr r1, [r7]
	ldr r0, [r8]
	mov r2, #0x20
	add r0, r1, r0
	str r0, [r7]
	ldr r0, _02164E0C // =0x02118D5C
	ldr r1, [sb]
	ldrsh r0, [r0]
	ldr r3, [r7, #4]
	add r1, r1, r0
	add r1, r3, r1
	str r1, [r7, #4]
	ldr r1, [sb]
	mov r3, r4
	add r0, r1, r0
	str r0, [sb]
	str r4, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	ldmia r7, {r0, r1}
	bl StageTask__ViewOutCheck
	cmp r0, #0
	add r5, r5, #1
	moveq fp, #0
	cmp r5, r6
	add r7, r7, #0xc
	add r8, r8, #4
	add sb, sb, #4
	blt _02164D78
_02164DEC:
	cmp fp, #0
	ldrne r0, [sl, #0x18]
	orrne r0, r0, #4
	strne r0, [sl, #0x18]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02164E04: .word Grind3Line__Singleton
_02164E08: .word g_obj
_02164E0C: .word 0x02118D5C
	arm_func_end Grind3LineRingLoss__State_2164D08

	arm_func_start Grind3LineRingLoss__Draw_2164E10
Grind3LineRingLoss__Draw_2164E10: // 0x02164E10
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #0x20
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x38
	add r7, sp, #0x14
	ldmia r0, {r0, r1, r2}
	ldr r3, _02164EA0 // =0x00001104
	stmia r7, {r0, r1, r2}
	str r3, [sp, #0x10]
	ldr sb, [r4, #0x168]
	mov r8, #0
	cmp sb, #0
	addle sp, sp, #0x20
	ldmleia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	add sl, r4, #0x16c
	ldr r4, _02164EA4 // =Grind3Line__Singleton
	add r6, sp, #0x10
	mov r5, r8
_02164E5C:
	str r6, [sp]
	str r5, [sp, #4]
	str r5, [sp, #8]
	str r5, [sp, #0xc]
	ldr r0, [r4]
	mov r1, sl
	add r0, r0, #0x3fc
	mov r2, r5
	mov r3, r7
	add r0, r0, #0x800
	bl StageTask__Draw3DEx
	add r8, r8, #1
	cmp r8, sb
	add sl, sl, #0xc
	blt _02164E5C
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	.align 2, 0
_02164EA0: .word 0x00001104
_02164EA4: .word Grind3Line__Singleton
	arm_func_end Grind3LineRingLoss__Draw_2164E10

	.rodata

_021884D4: // 0x021884D4
    .word 0x1800, 0x1800, 0x1800
	
_021884E0: // 0x021884E0
    .word 0x1000, 0x1000, 0x1000
	
_021884EC: // 0x021884EC
    .hword 0, 1, 2, 3, 4, 5, 0, 2

	.data
	
aActAcGmkGrd3lS: // 0x0218905C
	.asciz "/act/ac_gmk_grd3l_spring.bac"
	.align 4
	
aModGmkGrd3line: // 0x0218907C
	.asciz "/mod/gmk_grd_3line.nsbmd"
	.align 4
	
aModGmkGrd3line_0: // 0x02189098
	.asciz "/mod/gmk_grd_3line.nsbta"
	.align 4
	
aActAcEffGrd3lL_0: // 0x021890B4
	.asciz "/act/ac_eff_grd3l_leaf3d.bac"
	.align 4
	
aActAcItmRing3d: // 0x021890D4
	.asciz "/act/ac_itm_ring3d.bac"
	.align 4
	
aActAcGmkBallSi: // 0x021890EC
	.asciz "/act/ac_gmk_ball_siron3d.bac"
	.align 4
