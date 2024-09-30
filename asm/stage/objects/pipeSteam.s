	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start PipeFlow__Create
PipeFlow__Create: // 0x021610CC
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
	ldr r0, _021613F4 // =StageTask_Main
	ldr r1, _021613F8 // =GameObject__Destructor
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
	mov r0, #0x9f
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _021613FC // =gameArchiveStage
	ldr r1, _02161400 // =0x0000FFFF
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _02161404 // =aActAcGmkPipeFl_0
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, _02161408 // =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, [r4, #0x230]
	mov r3, #2
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	str r3, [sp]
	add r0, r4, #0x298
	sub r1, r3, #4
	mov r2, r1
	bl ObjRect__SetBox2D
	add r0, r4, #0x298
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x298
	ldr r1, _02161408 // =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x2b0]
	ldr r0, _0216140C // =PipeFlow__OnDefend_216188C
	orr r1, r1, #0x400
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x2bc]
	add r0, r4, #0x258
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x258
	ldr r1, _02161408 // =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x270]
	ldr r0, _02161410 // =PipeFlow__OnDefend_2161854
	orr r1, r1, #0x400
	str r1, [r4, #0x270]
	str r0, [r4, #0x27c]
	ldrh r0, [r7, #2]
	cmp r0, #0x73
	beq _02161264
	cmp r0, #0x74
	beq _021612B8
	cmp r0, #0x75
	beq _02161330
_02161264:
	ldr r0, _02161414 // =PipeFlow__OnDefend_216174C
	mov r2, #0x58
	str r0, [r4, #0x23c]
	mov r5, #0
	str r5, [r4, #0x13c]
	ldr r0, _02161418 // =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	add r0, r4, #0x300
	mov r1, #0x10
	strh r1, [r0, #8]
	strh r2, [r0, #0xa]
	sub r1, r2, #0x68
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r2, #0x74
	strh r1, [r0, #0xf2]
	mov r0, #4
	str r0, [r4, #0x28]
	mov r6, #9
	b _021613B0
_021612B8:
	ldr r0, _0216141C // =PipeSteam__OnDefend_21617B0
	mov r2, #0x18
	str r0, [r4, #0x23c]
	mov r3, #0
	str r3, [r4, #0x13c]
	ldr r0, _02161418 // =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	add r0, r4, #0x300
	mov r1, #0x38
	strh r1, [r0, #8]
	mov r1, #0x12
	strh r2, [r0, #0xa]
	sub r2, r2, #0x34
	add r0, r4, #0x200
	strh r2, [r0, #0xf0]
	strh r3, [r0, #0xf2]
	mov r0, #6
	str r0, [r4, #0x28]
	str r4, [r4, #0x274]
	str r1, [sp]
	add r0, r4, #0x258
	sub r1, r1, #0x14
	mov r2, #0xe
	mov r3, #2
	mov r5, #1
	mov r6, #0xa
	bl ObjRect__SetBox2D
	str r4, [r4, #0x2b4]
	b _021613B0
_02161330:
	ldr r0, _0216141C // =PipeSteam__OnDefend_21617B0
	mov r3, #0x58
	str r0, [r4, #0x23c]
	mov r0, #0
	str r0, [r4, #0x13c]
	ldr r0, _02161418 // =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	add r0, r4, #0x300
	mov r1, #0x10
	strh r1, [r0, #8]
	mov r5, #0x12
	mov r2, #0xe
	strh r3, [r0, #0xa]
	sub r1, r3, #0x78
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r3, #0x84
	strh r1, [r0, #0xf2]
	mov r0, #7
	str r0, [r4, #0x28]
	mov r0, #0x4000
	strh r0, [r4, #0x34]
	str r4, [r4, #0x274]
	add r0, r4, #0x258
	sub r1, r5, #0x24
	sub r3, r2, #0x1c
	str r5, [sp]
	mov r5, #2
	mov r6, #0xa
	bl ObjRect__SetBox2D
	str r4, [r4, #0x2b4]
_021613B0:
	mov r0, #0
	str r0, [r4, #0x24]
	ldr r1, [r4, #0x1c]
	mov r0, r4
	orr r3, r1, #0x2100
	mov r1, r5
	mov r2, r6
	str r3, [r4, #0x1c]
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, r5
	bl StageTask__SetAnimation
	ldr r1, _02161420 // =PipeSteam__State_2161728
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021613F4: .word StageTask_Main
_021613F8: .word GameObject__Destructor
_021613FC: .word gameArchiveStage
_02161400: .word 0x0000FFFF
_02161404: .word aActAcGmkPipeFl_0
_02161408: .word 0x0000FFFE
_0216140C: .word PipeFlow__OnDefend_216188C
_02161410: .word PipeFlow__OnDefend_2161854
_02161414: .word PipeFlow__OnDefend_216174C
_02161418: .word StageTask__DefaultDiffData
_0216141C: .word PipeSteam__OnDefend_21617B0
_02161420: .word PipeSteam__State_2161728
	arm_func_end PipeFlow__Create

	arm_func_start PipeSteam__Create
PipeSteam__Create: // 0x02161424
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _021616F8 // =StageTask_Main
	ldr r1, _021616FC // =GameObject__Destructor
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
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	mov r0, #0x9f
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02161700 // =gameArchiveStage
	ldr r1, _02161704 // =0x0000FFFF
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _02161708 // =aActAcGmkPipeSt
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, _0216170C // =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x230]
	mov r0, #1
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	str r0, [r4, #0x24]
	ldrh r0, [r8, #2]
	cmp r0, #0x7f
	blo _021615A8
	cmp r0, #0x82
	bhi _021615A8
	ldr r0, _02161710 // =PipeSteam__OnDefend_2161DA0
	str r0, [r4, #0x23c]
	ldrh r0, [r8, #2]
	sub r0, r0, #0x7f
	mov r0, r0, lsl #1
	str r0, [r4, #0x28]
	ldrh r0, [r8, #2]
	sub r0, r0, #0x7f
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0216159C
_02161568: // jump table
	b _02161578 // case 0
	b _02161598 // case 1
	b _02161584 // case 2
	b _0216158C // case 3
_02161578:
	ldr r0, [r4, #0x20]
	orr r0, r0, #1
	str r0, [r4, #0x20]
_02161584:
	mov r5, #0
	b _0216159C
_0216158C:
	ldr r0, [r4, #0x20]
	orr r0, r0, #2
	str r0, [r4, #0x20]
_02161598:
	mov r5, #1
_0216159C:
	ldr r0, _02161714 // =PipeSteam__State_2161728
	str r0, [r4, #0xf4]
	b _0216166C
_021615A8:
	ldrh r0, [r8, #2]
	cmp r0, #0x83
	blo _0216166C
	cmp r0, #0x86
	bhi _0216166C
	ldr r0, _02161718 // =PipeSteam__OnDefend_21617B0
	mov r3, #2
	str r0, [r4, #0x23c]
	sub r1, r3, #4
	str r4, [r4, #0x274]
	mov r2, r1
	add r0, r4, #0x258
	str r3, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x258
	bl ObjRect__SetAttackStat
	ldr r1, _0216170C // =0x0000FFFE
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x270]
	ldr r0, _0216171C // =PipeSteam__OnDefend_2161DE0
	orr r1, r1, #0x400
	str r1, [r4, #0x270]
	str r0, [r4, #0x27c]
	ldrh r0, [r8, #2]
	sub r0, r0, #0x83
	mov r0, r0, lsl #1
	str r0, [r4, #0x28]
	ldrh r0, [r8, #2]
	sub r0, r0, #0x83
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0216166C
_02161638: // jump table
	b _02161648 // case 0
	b _02161668 // case 1
	b _02161654 // case 2
	b _0216165C // case 3
_02161648:
	ldr r0, [r4, #0x20]
	orr r0, r0, #1
	str r0, [r4, #0x20]
_02161654:
	mov r5, #2
	b _0216166C
_0216165C:
	ldr r0, [r4, #0x20]
	orr r0, r0, #2
	str r0, [r4, #0x20]
_02161668:
	mov r5, #3
_0216166C:
	mov r1, #0
	str r1, [r4, #0x13c]
	ldr r0, _02161720 // =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	ldrh r0, [r8, #2]
	ldr r6, _02161724 // =PipeSteam__stru_21883B0
	add r3, r4, #0x300
	sub r2, r0, #0x7f
	mov r0, r2, lsl #3
	ldrsh r0, [r6, r0]
	add r8, r6, r2, lsl #3
	add r6, r4, #0x200
	strh r0, [r3, #8]
	ldrsh r7, [r8, #2]
	mov r0, r4
	mov r2, #0x20
	strh r7, [r3, #0xa]
	ldrsh r3, [r8, #4]
	strh r3, [r6, #0xf0]
	ldrsh r3, [r8, #6]
	strh r3, [r6, #0xf2]
	ldr r3, [r4, #0x1c]
	orr r3, r3, #0x2100
	str r3, [r4, #0x1c]
	ldr r3, [r4, #0x20]
	orr r3, r3, #0x100
	str r3, [r4, #0x20]
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, r5
	bl StageTask__SetAnimation
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021616F8: .word StageTask_Main
_021616FC: .word GameObject__Destructor
_02161700: .word gameArchiveStage
_02161704: .word 0x0000FFFF
_02161708: .word aActAcGmkPipeSt
_0216170C: .word 0x0000FFFE
_02161710: .word PipeSteam__OnDefend_2161DA0
_02161714: .word PipeSteam__State_2161728
_02161718: .word PipeSteam__OnDefend_21617B0
_0216171C: .word PipeSteam__OnDefend_2161DE0
_02161720: .word StageTask__DefaultDiffData
_02161724: .word PipeSteam__stru_21883B0
	arm_func_end PipeSteam__Create

	arm_func_start PipeSteam__State_2161728
PipeSteam__State_2161728: // 0x02161728
	ldr r1, [r0, #0x2c]
	cmp r1, #0
	bxeq lr
	subs r1, r1, #1
	str r1, [r0, #0x2c]
	ldreq r1, [r0, #0x18]
	biceq r1, r1, #2
	streq r1, [r0, #0x18]
	bx lr
	arm_func_end PipeSteam__State_2161728

	arm_func_start PipeFlow__OnDefend_216174C
PipeFlow__OnDefend_216174C: // 0x0216174C
	stmdb sp!, {r3, lr}
	ldr r1, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r1, #0
	cmpne r0, #0
	ldmeqia sp!, {r3, pc}
	ldrh r2, [r0, #0]
	cmp r2, #1
	ldmneia sp!, {r3, pc}
	ldr r3, [r1, #0x28]
	mov r2, #0x60
	str r2, [r1, #0x2c]
	ldr r2, [r1, #0x18]
	mov lr, r3, lsl #0xd
	orr r2, r2, #2
	str r2, [r1, #0x18]
	ldr ip, [r1, #0x24]
	ldr r3, _021617AC // =PipeFlow__dword_21883A0
	add r2, lr, #0x8000
	mov r2, r2, lsl #0x10
	ldr r3, [r3, ip, lsl #2]
	mov r2, r2, lsr #0x10
	bl Player__Gimmick_201C80C
	ldmia sp!, {r3, pc}
	.align 2, 0
_021617AC: .word PipeFlow__dword_21883A0
	arm_func_end PipeFlow__OnDefend_216174C

	arm_func_start PipeSteam__OnDefend_21617B0
PipeSteam__OnDefend_21617B0: // 0x021617B0
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x6d8]
	cmp r0, r4
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x1c]
	tst r0, #0x200
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x340]
	mov r2, #0
	ldrsb ip, [r0, #6]
	ldr lr, [r4, #0x24]
	ldr r0, _0216184C // =PipeSteam__dword_2188390
	cmp ip, #0
	ldr r1, [r0, lr, lsl #2]
	ldrgt r0, _02161850 // =PipeSteam__dword_2188398
	mov r3, r2
	ldrgt r0, [r0, lr, lsl #2]
	mlagt r1, ip, r0, r1
	cmp lr, #1
	movls r2, #1
	cmp lr, #0
	moveq r3, #0
	beq _02161834
	cmp lr, #1
	moveq r3, #1
_02161834:
	mov r0, r5
	bl Player__Func_201CBD0
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216184C: .word PipeSteam__dword_2188390
_02161850: .word PipeSteam__dword_2188398
	arm_func_end PipeSteam__OnDefend_21617B0

	arm_func_start PipeFlow__OnDefend_2161854
PipeFlow__OnDefend_2161854: // 0x02161854
	ldr r1, [r1, #0x1c]
	ldr r2, [r0, #0x1c]
	cmp r1, #0
	cmpne r2, #0
	bxeq lr
	ldrh r0, [r2, #0]
	cmp r0, #1
	bxne lr
	ldr r1, [r1, #0x24]
	ldr r0, _02161888 // =PipeFlow__dword_21883A8
	ldr r0, [r0, r1, lsl #2]
	str r0, [r2, #8]
	bx lr
	.align 2, 0
_02161888: .word PipeFlow__dword_21883A8
	arm_func_end PipeFlow__OnDefend_2161854

	arm_func_start PipeFlow__OnDefend_216188C
PipeFlow__OnDefend_216188C: // 0x0216188C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r2, [r1, #0x1c]
	ldr r1, [r0, #0x1c]
	cmp r2, #0
	cmpne r1, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [r1, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r1, #0x6d8]
	cmp r0, r2
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r1, #0x1c]
	tst r0, #0x200
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r2, #0x28]
	mov r5, #0
	cmp r0, #6
	sub r10, r5, #0x4000
	ldr r6, [r2, #0x44]
	ldr r7, [r2, #0x48]
	bne _02161A14
	ldr r8, _02161B48 // =0x02188F54
	ldr r9, _02161B4C // =_02188F2C
	ldr r11, _02161B50 // =_mt_math_rand
	mov r4, r5
_021618F4:
	ldr r3, [r11, #0]
	ldr r2, _02161B54 // =0x00196225
	ldr r0, _02161B58 // =0x3C6EF35F
	mov r1, r7
	mla r0, r3, r2, r0
	mov r3, r2
	ldr r2, _02161B58 // =0x3C6EF35F
	mla r2, r0, r3, r2
	str r2, [r11]
	str r5, [sp]
	ldr r2, [r11, #0]
	mov r0, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r0, r2, lsr #0x10
	and r2, r0, #3
	and r0, r3, #3
	ldr r3, [r8], #4
	sub r2, r2, #1
	add r2, r3, r2, lsl #10
	ldr r3, [r9], #4
	sub r0, r0, #1
	add r3, r3, r0, lsl #11
	add r0, r6, r10
	bl EffectPipeFlowPetal__Create
	eor r0, r5, #1
	add r4, r4, #1
	mov r0, r0, lsl #0x10
	cmp r4, #5
	add r10, r10, #0x2000
	mov r5, r0, lsr #0x10
	blt _021618F4
	mov r10, #0
	mov r4, #0x4000
	ldr r8, _02161B50 // =_mt_math_rand
	ldr r11, _02161B58 // =0x3C6EF35F
	sub r9, r10, #0x2400
	rsb r4, r4, #0
_02161994:
	ldr r2, [r8, #0]
	ldr r0, _02161B54 // =0x00196225
	mov r1, r7
	mla r0, r2, r0, r11
	ldr r2, _02161B54 // =0x00196225
	mov r3, r0, lsr #0x10
	mla r2, r0, r2, r11
	str r2, [r8]
	str r5, [sp]
	ldr r2, [r8, #0]
	mov r0, r2, lsr #0x10
	mov r2, r0, lsl #0x10
	mov r0, r3, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	and r0, r2, #7
	sub r2, r0, #3
	mov r3, r3, lsl #0x1d
	add r0, r6, r9
	mov r2, r2, lsl #0xc
	sub r3, r4, r3, lsr #18
	bl EffectPipeFlowSeed__Create
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #3
	add r10, r10, #1
	movhs r5, #0
	cmp r10, #0xa
	add r9, r9, #0x800
	blt _02161994
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02161A14:
	ldr r4, _02161B5C // =0x02188F40
	ldr r8, _02161B60 // =0x02188F68
	ldr r11, _02161B50 // =_mt_math_rand
	mov r9, r5
_02161A24:
	ldr r3, [r11, #0]
	ldr r2, _02161B54 // =0x00196225
	ldr r1, _02161B58 // =0x3C6EF35F
	mov r0, r6
	mla r1, r3, r2, r1
	mov r3, r2
	ldr r2, _02161B58 // =0x3C6EF35F
	mla r2, r1, r3, r2
	str r2, [r11]
	str r5, [sp]
	ldr r2, [r11, #0]
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r1, r2, lsr #0x10
	and r2, r1, #3
	and r1, r3, #3
	ldr r3, [r4], #4
	sub r2, r2, #1
	add r2, r3, r2, lsl #10
	ldr r3, [r8], #4
	sub r1, r1, #1
	add r3, r3, r1, lsl #11
	add r1, r7, r10
	bl EffectPipeFlowPetal__Create
	eor r0, r5, #1
	add r9, r9, #1
	mov r0, r0, lsl #0x10
	cmp r9, #5
	add r10, r10, #0x2000
	mov r5, r0, lsr #0x10
	blt _02161A24
	mov r10, #0
	mov r4, #0x3000
	ldr r8, _02161B50 // =_mt_math_rand
	ldr r11, _02161B58 // =0x3C6EF35F
	sub r9, r10, #0x2400
	rsb r4, r4, #0
_02161AC4:
	ldr r2, [r8, #0]
	ldr r0, _02161B54 // =0x00196225
	mov r1, r7
	mla r0, r2, r0, r11
	ldr r2, _02161B54 // =0x00196225
	mla r2, r0, r2, r11
	str r2, [r8]
	str r5, [sp]
	ldr r2, [r8, #0]
	mov r0, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	and r2, r2, #7
	sub r0, r2, #3
	mov r2, r0, lsl #0xb
	mov r3, r3, lsl #0x1d
	add r0, r6, r9
	add r2, r2, #0x3000
	sub r3, r4, r3, lsr #18
	bl EffectPipeFlowSeed__Create
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #3
	add r10, r10, #1
	movhs r5, #0
	cmp r10, #0xa
	add r9, r9, #0x800
	blt _02161AC4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02161B48: .word 0x02188F54
_02161B4C: .word _02188F2C
_02161B50: .word _mt_math_rand
_02161B54: .word 0x00196225
_02161B58: .word 0x3C6EF35F
_02161B5C: .word 0x02188F40
_02161B60: .word 0x02188F68
	arm_func_end PipeFlow__OnDefend_216188C

	arm_func_start PipeSteam___2161B64
PipeSteam___2161B64: // 0x02161B64
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x2c]
	sub r1, r1, #1
	str r1, [r4, #0x2c]
	cmp r1, #0
	ldmgtia sp!, {r4, pc}
	ldr r1, [r4, #0x128]
	ldrh r1, [r1, #0xc]
	cmp r1, #0
	bne _02161B9C
	mov r1, #4
	bl StageTask__SetAnimation
	b _02161BA4
_02161B9C:
	mov r1, #7
	bl StageTask__SetAnimation
_02161BA4:
	mov r0, #0
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	arm_func_end PipeSteam___2161B64

	arm_func_start PipeSteam__State_2161BB0
PipeSteam__State_2161BB0: // 0x02161BB0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	ldr r0, [r5, #0x2c]
	bl StageTask__DecrementBySpeed
	str r0, [r5, #0x2c]
	cmp r0, #0
	ldmgtia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r5, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, #5
	mov r0, r5
	bne _02161BEC
	mov r1, #6
	bl StageTask__SetAnimation
	b _02161BF4
_02161BEC:
	mov r1, #9
	bl StageTask__SetAnimation
_02161BF4:
	ldr r1, [r5, #0x20]
	mov r0, #0x20
	bic r1, r1, #4
	str r1, [r5, #0x20]
	bl ObjDrawReleaseSprite
	mov r0, r5
	mov r1, #6
	mov r2, #0x22
	bl ObjActionAllocSpritePalette
	ldr r0, _02161D1C // =PipeSteam__State_2161D20
	str r0, [r5, #0xf4]
	ldr r0, [r5, #0x340]
	ldr r4, [r5, #0x44]
	ldrh r0, [r0, #2]
	ldr r5, [r5, #0x48]
	sub r0, r0, #0x83
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02161C50
_02161C40: // jump table
	b _02161C50 // case 0
	b _02161C60 // case 1
	b _02161C70 // case 2
	b _02161C84 // case 3
_02161C50:
	mov r6, #0x4000
	sub r7, r6, #0x8000
	add r4, r4, #0x10000
	b _02161C90
_02161C60:
	add r5, r5, #0x10000
	mov r6, #0
	mov r7, #0x4000
	b _02161C90
_02161C70:
	mov r6, #0x4000
	rsb r6, r6, #0
	mov r7, r6
	sub r4, r4, #0x10000
	b _02161C90
_02161C84:
	mov r6, #0
	sub r7, r6, #0x4000
	sub r5, r5, #0x10000
_02161C90:
	sub ip, r7, #0x1000
	mov r1, r4
	mov r2, r5
	mov r3, r6
	mov r0, #0
	str ip, [sp]
	bl EffectSteamDust__Create
	add ip, r7, #0x2000
	mov r1, r4
	mov r2, r5
	add r3, r6, #0x1800
	mov r0, #0
	str ip, [sp]
	bl EffectSteamDust__Create
	mov r1, r4
	mov r2, r5
	str r7, [sp]
	mov r0, #1
	add r3, r6, #0x2800
	bl EffectSteamDust__Create
	add r0, r7, #0x1000
	str r0, [sp]
	mov r0, #0
	mov r1, r4
	mov r2, r5
	sub r3, r6, #0x1800
	bl EffectSteamDust__Create
	sub r0, r7, #0x2000
	str r0, [sp]
	mov r1, r4
	mov r2, r5
	sub r3, r6, #0x2800
	mov r0, #1
	bl EffectSteamDust__Create
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02161D1C: .word PipeSteam__State_2161D20
	arm_func_end PipeSteam__State_2161BB0

	arm_func_start PipeSteam__State_2161D20
PipeSteam__State_2161D20: // 0x02161D20
	ldr r1, [r0, #0x20]
	tst r1, #8
	bxeq lr
	mov r1, #0
	str r1, [r0, #0xf4]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x340]
	ldrh r1, [r1, #2]
	sub r1, r1, #0x7f
	cmp r1, #7
	addls pc, pc, r1, lsl #2
	bx lr
_02161D58: // jump table
	bx lr // case 0
	bx lr // case 1
	bx lr // case 2
	bx lr // case 3
	b _02161D78 // case 4
	b _02161D8C // case 5
	b _02161D78 // case 6
	b _02161D8C // case 7
_02161D78:
	add r0, r0, #0x200
	ldrsh r1, [r0, #0xf0]
	add r1, r1, #7
	strh r1, [r0, #0xf0]
	bx lr
_02161D8C:
	add r0, r0, #0x200
	ldrsh r1, [r0, #0xf2]
	sub r1, r1, #7
	strh r1, [r0, #0xf2]
	bx lr
	arm_func_end PipeSteam__State_2161D20

	arm_func_start PipeSteam__OnDefend_2161DA0
PipeSteam__OnDefend_2161DA0: // 0x02161DA0
	stmdb sp!, {r4, lr}
	ldr r4, [r1, #0x1c]
	ldr r2, [r0, #0x1c]
	cmp r4, #0
	cmpne r2, #0
	ldmeqia sp!, {r4, pc}
	ldrh r2, [r2, #0]
	cmp r2, #1
	ldmneia sp!, {r4, pc}
	bl PipeFlow__OnDefend_216174C
	mov r1, #8
	ldr r0, _02161DDC // =PipeSteam___2161B64
	str r1, [r4, #0x2c]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161DDC: .word PipeSteam___2161B64
	arm_func_end PipeSteam__OnDefend_2161DA0

	arm_func_start PipeSteam__OnDefend_2161DE0
PipeSteam__OnDefend_2161DE0: // 0x02161DE0
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [r4, #0x24]
	ldr r0, _02161E5C // =PipeFlow__dword_21883A8
	ldr r0, [r0, r1, lsl #2]
	str r0, [r5, #8]
	ldr r0, [r4, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, #2
	mov r0, r4
	bne _02161E34
	mov r1, #5
	bl StageTask__SetAnimation
	b _02161E3C
_02161E34:
	mov r1, #8
	bl StageTask__SetAnimation
_02161E3C:
	ldr r1, [r4, #0x20]
	ldr r0, _02161E60 // =PipeSteam__State_2161BB0
	orr r1, r1, #4
	str r1, [r4, #0x20]
	ldr r1, [r5, #8]
	str r1, [r4, #0x2c]
	str r0, [r4, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02161E5C: .word PipeFlow__dword_21883A8
_02161E60: .word PipeSteam__State_2161BB0
	arm_func_end PipeSteam__OnDefend_2161DE0
	
	.rodata

.public PipeSteam__dword_2188390
PipeSteam__dword_2188390: // 0x02188390
    .word 0xA000, 0xA000      
	
.public PipeSteam__dword_2188398
PipeSteam__dword_2188398: // PipeSteam__dword_2188398
    .word 0x800, 0x800        
	
.public PipeFlow__dword_21883A0
PipeFlow__dword_21883A0: // PipeFlow__dword_21883A0
    .word 0, 0                
	
.public PipeFlow__dword_21883A8
PipeFlow__dword_21883A8: // PipeFlow__dword_21883A8
    .word 0x10000, 0x20000    
	
.public PipeSteam__stru_21883B0
PipeSteam__stru_21883B0: // PipeSteam__stru_21883B0
    .hword 24, 48, -24, -24
	.hword 48, 24, -24, 0
	.hword 24, 48, -24, -24
	.hword 48, 24, -24, 0
	.hword 40, 48, -24, -24
	.hword 48, 40, -24, -16
	.hword 40, 48, -24, -24
	.hword 48, 40, -24, -16

	.data
	
_02188F2C:
	.byte 0x00, 0xA8, 0xFF, 0xFF
	.byte 0x00, 0xA0, 0xFF, 0xFF, 0x00, 0x98, 0xFF, 0xFF, 0x00, 0xA0, 0xFF, 0xFF, 0x00, 0xA8, 0xFF, 0xFF
	.byte 0x00, 0x50, 0x00, 0x00, 0x00, 0x58, 0x00, 0x00, 0x00, 0x60, 0x00, 0x00, 0x00, 0x68, 0x00, 0x00
	.byte 0x00, 0x70, 0x00, 0x00, 0x00, 0xD0, 0xFF, 0xFF, 0x00, 0xD8, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x28, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0xA0, 0xFF, 0xFF, 0x00, 0x90, 0xFF, 0xFF
	.byte 0x00, 0xA0, 0xFF, 0xFF, 0x00, 0x90, 0xFF, 0xFF, 0x00, 0xA0, 0xFF, 0xFF

aActAcGmkPipeFl_0: // 0x02188F7C
	.asciz "/act/ac_gmk_pipe_flw.bac"
	.align 4
	
aActAcGmkPipeSt: // 0x02188F98
	.asciz "/act/ac_gmk_pipe_steam.bac"
	.align 4