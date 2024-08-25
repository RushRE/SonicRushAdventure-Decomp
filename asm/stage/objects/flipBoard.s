	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start FlipBoard__Create
FlipBoard__Create: // 0x0216977C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _0216996C // =0x00000408
	ldr r0, _02169970 // =StageTask_Main
	ldr r1, _02169974 // =FlipBoard__Destructor
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
	ldr r2, _0216996C // =0x00000408
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xa7
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x10
	str r1, [r4, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02169978 // =gameArchiveStage
	ldr r1, _0216997C // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _02169980 // =aActAcGmkFlipBo
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x3d
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	add r5, r4, #0x364
	mov r0, #0xa7
	bl GetObjectFileWork
	mov r3, r0
	ldr r1, _02169978 // =gameArchiveStage
	mov r0, r5
	ldr r2, [r1]
	ldr r1, _02169980 // =aActAcGmkFlipBo
	str r2, [sp]
	mov r2, #0x23
	bl ObjAction2dBACLoad
	add r0, r4, #0x100
	ldrh r2, [r0, #0xb8]
	mov r0, r5
	mov r1, #1
	strh r2, [r5, #0x50]
	strh r2, [r5, #0x92]
	strh r2, [r5, #0x90]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r5
	mov r1, #2
	bl StageTask__SetOAMPriority
	ldr r1, _02169984 // =FlipBoard__Draw
	add r0, r4, #0x218
	str r1, [r4, #0xfc]
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, _02169988 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _0216998C // =FlipBoard__OnDefend
	mov r1, #0x18
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	mov r3, #0
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	str r3, [r4, #0x13c]
	ldr r0, _02169990 // =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	add r0, r4, #0x300
	mov r2, #0x78
	strh r2, [r0, #8]
	strh r1, [r0, #0xa]
	sub r1, r1, #0x54
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	ldr r1, _02169994 // =FlipBoard__State_21699C4
	strh r3, [r0, #0xf2]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216996C: .word 0x00000408
_02169970: .word StageTask_Main
_02169974: .word FlipBoard__Destructor
_02169978: .word gameArchiveStage
_0216997C: .word 0x0000FFFF
_02169980: .word aActAcGmkFlipBo
_02169984: .word FlipBoard__Draw
_02169988: .word 0x0000FFFE
_0216998C: .word FlipBoard__OnDefend
_02169990: .word StageTask__DefaultDiffData
_02169994: .word FlipBoard__State_21699C4
	arm_func_end FlipBoard__Create

	arm_func_start FlipBoard__Destructor
FlipBoard__Destructor: // 0x02169998
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #1
	bl GetObjectFileWork
	add r1, r4, #0x364
	bl ObjAction2dBACRelease
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end FlipBoard__Destructor

	arm_func_start FlipBoard__State_21699C4
FlipBoard__State_21699C4: // 0x021699C4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x20]
	tst r1, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x10
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
	arm_func_end FlipBoard__State_21699C4

	arm_func_start FlipBoard__Draw
FlipBoard__Draw: // 0x021699FC
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x20]
	mov r2, #0
	str r1, [sp, #0xc]
	add r0, sp, #0xc
	stmia sp, {r0, r2}
	mov r3, r2
	str r2, [sp, #8]
	add r0, r4, #0x364
	add r1, r4, #0x44
	bl StageTask__Draw2DEx
	ldr r1, [r4, #0x128]
	mov r0, r4
	bl StageTask__Draw2D
	ldr r0, [sp, #0xc]
	tst r0, #8
	movne r0, #0
	strne r0, [r4, #0xfc]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	arm_func_end FlipBoard__Draw

	arm_func_start FlipBoard__OnDefend
FlipBoard__OnDefend: // 0x02169A58
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x340]
	mov r1, #0
	ldrsb r3, [r0, #6]
	sub r2, r1, #0x1800
	mov r0, r5
	mul r2, r3, r2
	sub r2, r2, #0x7800
	bl Player__Func_201FD6C
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x364
	mov r1, #1
	bl StageTask__SetOAMPriority
	ldr r1, [r4, #0x20]
	mov r0, #0
	bic r1, r1, #0x10
	str r1, [r4, #0x20]
	str r0, [sp]
	mov r1, #0x51
	str r1, [sp, #4]
	sub r1, r1, #0x52
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end FlipBoard__OnDefend

	.data
	
aActAcGmkFlipBo: // 0x021893BC
	.asciz "/act/ac_gmk_flip_board.bac"
	.align 4