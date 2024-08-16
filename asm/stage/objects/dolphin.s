	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Dolphin__Create
Dolphin__Create: // 0x021817E0
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
	mov r4, #0x4e0
	ldr r0, _02181974 // =StageTask_Main
	ldr r1, _02181978 // =GameObject__Destructor
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
	mov r2, #0x4e0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xa9
	orr r1, r1, #0x2140
	orr r1, r1, #0x80000
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	str r0, [sp]
	ldr r1, _0218197C // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1]
	add r1, r4, #0x364
	str r2, [sp, #4]
	ldr r2, _02181980 // =aModGmkDolphinN
	mov r3, #0
	bl ObjAction3dNNModelLoad
	mov r0, #0xaa
	bl GetObjectFileWork
	mov r3, r0
	ldr r1, _0218197C // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1]
	add r1, r4, #0x364
	str r2, [sp]
	ldr r2, _02181984 // =aModGmkDolphinN_0
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _02181988 // =0x000034CC
	orr r1, r1, #0x204
	str r1, [r4, #0x20]
	str r0, [r4, #0x37c]
	str r0, [r4, #0x380]
	str r0, [r4, #0x384]
	str r4, [r4, #0x234]
	mov r2, #0xc
	str r2, [sp]
	add r0, r4, #0x218
	sub r1, r2, #0x18
	sub r2, r2, #0x1c
	mov r3, #0x10
	bl ObjRect__SetBox2D
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, _0218198C // =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02181990 // =ovl00_2181F9C
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	ldrh r0, [r7, #4]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02181974: .word StageTask_Main
_02181978: .word GameObject__Destructor
_0218197C: .word gameArchiveStage
_02181980: .word aModGmkDolphinN
_02181984: .word aModGmkDolphinN_0
_02181988: .word 0x000034CC
_0218198C: .word 0x0000FFFE
_02181990: .word ovl00_2181F9C
	arm_func_end Dolphin__Create

	arm_func_start DolphinHoop__Create
DolphinHoop__Create: // 0x02181994
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
	ldr r4, _02181C70 // =0x0000040C
	ldr r0, _02181C74 // =StageTask_Main
	ldr r1, _02181C78 // =DolphinHoop__Destructor
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
	ldr r2, _02181C70 // =0x0000040C
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldrh r2, [r7, #2]
	add r1, r4, #0x400
	mov r0, #0xab
	sub r2, r2, #0xd8
	strh r2, [r1, #8]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02181C7C // =gameArchiveStage
	ldr r1, _02181C80 // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02181C84 // =aActAcGmkDolphi
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	ldrh r0, [r7, #2]
	cmp r0, #0xdd
	add r0, r4, #0x400
	ldrh r1, [r0, #8]
	moveq r2, #0x62
	movne r2, #0x63
	mov r2, r2, lsl #0x10
	ldr r0, _02181C88 // =0x02189BF0
	mov r1, r1, lsl #2
	ldrh r1, [r0, r1]
	mov r0, r4
	mov r2, r2, asr #0x10
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	add r0, r4, #0x400
	ldrh r2, [r0, #8]
	ldr r1, _02181C8C // =_02189BE0
	mov r0, r4
	ldrb r1, [r1, r2, lsl #1]
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x400
	ldrh r2, [r0, #8]
	ldr r1, _02181C88 // =0x02189BF0
	mov r0, r4
	mov r2, r2, lsl #2
	ldrh r1, [r1, r2]
	bl StageTask__SetAnimation
	add r0, r4, #0x400
	ldrh r2, [r0, #8]
	ldr r1, _02181C90 // =0x02189BF2
	ldr r0, _02181C80 // =0x0000FFFF
	mov r2, r2, lsl #2
	ldrh r1, [r1, r2]
	cmp r1, r0
	beq _02181B94
	mov r0, #0xab
	add r5, r4, #0x364
	bl GetObjectFileWork
	ldr r1, _02181C7C // =gameArchiveStage
	mov r3, r0
	ldr r6, [r1]
	ldr r1, _02181C84 // =aActAcGmkDolphi
	ldr r2, _02181C80 // =0x0000FFFF
	mov r0, r5
	str r6, [sp]
	bl ObjAction2dBACLoad
	ldr r0, [r4, #0x128]
	add r1, r4, #0x400
	ldrh r3, [r0, #0x50]
	ldr r2, _02181C90 // =0x02189BF2
	mov r0, r5
	strh r3, [r5, #0x50]
	strh r3, [r5, #0x92]
	strh r3, [r5, #0x90]
	ldr r3, [r5, #0x3c]
	orr r3, r3, #0x10
	str r3, [r5, #0x3c]
	ldrh r1, [r1, #8]
	mov r1, r1, lsl #2
	ldrh r1, [r2, r1]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	add r1, r4, #0x400
	ldrh r2, [r1, #8]
	ldr r1, _02181C94 // =0x02189BE1
	mov r0, r5
	ldrb r1, [r1, r2, lsl #1]
	bl StageTask__SetOAMPriority
_02181B94:
	mov r2, #0x1c
	sub r1, r2, #0x2c
	str r4, [r4, #0x234]
	mov r5, #0x10
	str r5, [sp]
	str r2, [sp, #4]
	mov r3, r1
	add r0, r4, #0x218
	sub r2, r2, #0x38
	str r5, [sp, #8]
	bl ObjRect__SetBox3D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _02181C98 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _02181C9C // =ovl00_2182184
	add r0, r4, #0x400
	str r1, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	ldrh r0, [r0, #8]
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _02181C40
_02181C08: // jump table
	b _02181C40 // case 0
	b _02181C28 // case 1
	b _02181C40 // case 2
	b _02181C34 // case 3
	b _02181C40 // case 4
	b _02181C40 // case 5
	b _02181C28 // case 6
	b _02181C34 // case 7
_02181C28:
	mov r0, #0x5a000
	str r0, [r4, #0x4c]
	b _02181C40
_02181C34:
	mov r0, #0x5a000
	rsb r0, r0, #0
	str r0, [r4, #0x4c]
_02181C40:
	ldrh r0, [r7, #4]
	ldr r1, _02181CA0 // =ovl00_218206C
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	ldr r0, _02181CA4 // =ovl00_2182230
	str r0, [r4, #0xfc]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02181C70: .word 0x0000040C
_02181C74: .word StageTask_Main
_02181C78: .word DolphinHoop__Destructor
_02181C7C: .word gameArchiveStage
_02181C80: .word 0x0000FFFF
_02181C84: .word aActAcGmkDolphi
_02181C88: .word 0x02189BF0
_02181C8C: .word _02189BE0
_02181C90: .word 0x02189BF2
_02181C94: .word 0x02189BE1
_02181C98: .word 0x0000FFFE
_02181C9C: .word ovl00_2182184
_02181CA0: .word ovl00_218206C
_02181CA4: .word ovl00_2182230
	arm_func_end DolphinHoop__Create

	arm_func_start ovl00_2181CA8
ovl00_2181CA8: // 0x02181CA8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r2, [r4, #0x1c]
	mov r1, #0xa
	bic r2, r2, #0x2100
	str r2, [r4, #0x1c]
	mov r2, #8
	str r2, [sp]
	sub r2, r1, #0x1e
	mov r3, #0x10
	bl StageTask__SetHitbox
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, #1
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _02181D18 // =ovl00_2181D1C
	bic r1, r1, #0x204
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x354]
	orr r1, r1, #1
	str r1, [r4, #0x354]
	str r0, [r4, #0xf4]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02181D18: .word ovl00_2181D1C
	arm_func_end ovl00_2181CA8

	arm_func_start ovl00_2181D1C
ovl00_2181D1C: // 0x02181D1C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x58
	mov r5, r0
	ldr r4, [r5, #0x35c]
	cmp r4, #0
	beq _02181D4C
	ldr r0, [r4, #0x6d8]
	cmp r0, r5
	bne _02181D4C
	ldr r0, [r4, #0x5d8]
	tst r0, #0x400
	beq _02181D70
_02181D4C:
	ldr r0, [r5, #0x1c]
	ldr r1, _02181EF0 // =ovl00_2181EF8
	orr r0, r0, #0x100
	str r0, [r5, #0x1c]
	mov r0, r5
	str r1, [r5, #0xf4]
	bl ovl00_2181EF8
	add sp, sp, #0x58
	ldmia sp!, {r3, r4, r5, pc}
_02181D70:
	ldr r0, [r5, #0x354]
	tst r0, #1
	beq _02181DB8
	ldr r0, [r5, #0x20]
	tst r0, #8
	beq _02181DB8
	ldr r0, [r5, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, #2
	bl AnimatorMDL__SetAnimation
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x354]
	bic r0, r0, #1
	str r0, [r5, #0x354]
_02181DB8:
	ldr r1, [r5, #0x44]
	add r0, sp, #0x34
	str r1, [r5, #0x8c]
	ldr r1, [r5, #0x48]
	str r1, [r5, #0x90]
	ldr r1, [r5, #0x4c]
	str r1, [r5, #0x94]
	bl MTX_Identity33_
	ldrh r1, [r4, #0x32]
	ldr r3, _02181EF4 // =FX_SinCosTable_
	add r0, sp, #0x34
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	blx MTX_RotY33_
	ldrh r1, [r4, #0x32]
	ldr r3, _02181EF4 // =FX_SinCosTable_
	add r0, sp, #0x10
	strh r1, [r5, #0x32]
	ldrh r1, [r4, #0x34]
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	blx MTX_RotZ33_
	ldrh r2, [r4, #0x34]
	add r0, sp, #0x34
	add r1, sp, #0x10
	strh r2, [r5, #0x34]
	mov r2, r0
	bl MTX_Concat33
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #0xc]
	mov r0, #0x8000
	str r0, [sp, #8]
	add r0, sp, #4
	add r1, sp, #0x34
	mov r2, r0
	bl MTX_MultVec33
	ldr r1, [r4, #0x44]
	ldr r0, [sp, #4]
	add r0, r1, r0
	str r0, [r5, #0x44]
	ldr r1, [r4, #0x48]
	ldr r0, [sp, #8]
	add r0, r1, r0
	str r0, [r5, #0x48]
	ldr r1, [r4, #0x4c]
	ldr r0, [sp, #0xc]
	add r0, r1, r0
	str r0, [r5, #0x4c]
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x8c]
	sub r0, r1, r0
	str r0, [r5, #0xbc]
	ldr r1, [r5, #0x48]
	ldr r0, [r5, #0x90]
	sub r0, r1, r0
	str r0, [r5, #0xc0]
	ldr r1, [r5, #0x4c]
	ldr r0, [r5, #0x94]
	sub r0, r1, r0
	str r0, [r5, #0xc4]
	add sp, sp, #0x58
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02181EF0: .word ovl00_2181EF8
_02181EF4: .word FX_SinCosTable_
	arm_func_end ovl00_2181D1C

	arm_func_start ovl00_2181EF8
ovl00_2181EF8: // 0x02181EF8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x20]
	mov r4, #0x300
	tst r0, #1
	ldr r0, _02181F98 // =mapCamera
	rsbne r4, r4, #0
	ldrh r0, [r0, #0x6e]
	ldr r2, [r5, #0x48]
	addne r1, r4, #0x100
	add r0, r0, #0x20
	moveq r1, #0x200
	cmp r0, r2, asr #12
	blt _02181F44
	ldrsh r0, [r5, #0x34]
	mov r2, #0x3000
	bl ObjSpdUpSet
	strh r0, [r5, #0x34]
	b _02181F80
_02181F44:
	ldrh r0, [r5, #0x34]
	mov r1, #0
	mov r2, #0x100
	bl ObjRoopMove16
	strh r0, [r5, #0x34]
	ldrsh r0, [r5, #0x32]
	mov r1, r4
	mov r2, #0x2000
	bl ObjSpdUpSet
	strh r0, [r5, #0x32]
	ldr r0, [r5, #0xa0]
	mov r1, #0x200
	mov r2, #0x4000
	bl ObjSpdUpSet
	str r0, [r5, #0xa0]
_02181F80:
	ldr r0, [r5, #0xc8]
	mov r1, r4
	mov r2, #0xc000
	bl ObjSpdUpSet
	str r0, [r5, #0xc8]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02181F98: .word mapCamera
	arm_func_end ovl00_2181EF8

	arm_func_start ovl00_2181F9C
ovl00_2181F9C: // 0x02181F9C
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
	ldr r1, [r4, #0x18]
	mov r0, r5
	orr r2, r1, #2
	mov r1, r4
	str r2, [r4, #0x18]
	bl Player__Gimmick_2023944
	mov r0, r4
	str r5, [r4, #0x35c]
	bl ovl00_2181CA8
	ldr ip, _02182014 // =0x00000121
	mov r0, #0
	rsb r1, ip, #0x120
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02182014: .word 0x00000121
	arm_func_end ovl00_2181F9C

	arm_func_start DolphinHoop__Destructor
DolphinHoop__Destructor: // 0x02182018
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x400
	ldrh r2, [r0, #8]
	ldr r1, _02182064 // =0x02189BF2
	ldr r0, _02182068 // =0x0000FFFF
	mov r2, r2, lsl #2
	ldrh r1, [r1, r2]
	cmp r1, r0
	beq _02182058
	mov r0, #0xab
	bl GetObjectFileWork
	add r1, r4, #0x364
	bl ObjAction2dBACRelease
_02182058:
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02182064: .word 0x02189BF2
_02182068: .word 0x0000FFFF
	arm_func_end DolphinHoop__Destructor

	arm_func_start ovl00_218206C
ovl00_218206C: // 0x0218206C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r2, [r4, #0x340]
	ldr r1, _02182180 // =gPlayer
	ldrh r2, [r2, #2]
	ldr r3, [r1]
	sub r1, r2, #0xd8
	ldr r5, [r3, #0x4c]
	cmp r1, #7
	addls pc, pc, r1, lsl #2
	ldmia sp!, {r3, r4, r5, pc}
_02182098: // jump table
	b _02182104 // case 0
	b _021820B8 // case 1
	b _02182104 // case 2
	b _021820DC // case 3
	b _02182160 // case 4
	b _02182160 // case 5
	ldmia sp!, {r3, r4, r5, pc} // case 6
	b _021820DC // case 7
_021820B8:
	cmp r5, #0xa000
	add r0, r4, #0x364
	blt _021820D0
	mov r1, #2
	bl StageTask__SetOAMPriority
	ldmia sp!, {r3, r4, r5, pc}
_021820D0:
	mov r1, #1
	bl StageTask__SetOAMPriority
	ldmia sp!, {r3, r4, r5, pc}
_021820DC:
	mov r1, #0x1e000
	rsb r1, r1, #0
	cmp r5, r1
	bgt _021820F8
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	ldmia sp!, {r3, r4, r5, pc}
_021820F8:
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	ldmia sp!, {r3, r4, r5, pc}
_02182104:
	cmp r5, #0xa000
	blt _02182120
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x364
	mov r1, #2
	bl StageTask__SetOAMPriority
_02182120:
	mov r0, #0x1e000
	rsb r0, r0, #0
	cmp r5, r0
	mov r0, r4
	mov r1, #1
	bgt _0218214C
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x364
	mov r1, #1
	bl StageTask__SetOAMPriority
	ldmia sp!, {r3, r4, r5, pc}
_0218214C:
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x364
	mov r1, #2
	bl StageTask__SetOAMPriority
	ldmia sp!, {r3, r4, r5, pc}
_02182160:
	cmp r5, #0xa000
	blt _02182174
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	ldmia sp!, {r3, r4, r5, pc}
_02182174:
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02182180: .word gPlayer
	arm_func_end ovl00_218206C

	arm_func_start ovl00_2182184
ovl00_2182184: // 0x02182184
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
	ldreq r1, [r5, #0xf4]
	ldreq r0, _0218222C // =Player__State_2023A4C
	cmpeq r1, r0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	mov r0, r5
	mov r1, r4
	bl Player__Func_2024054
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0xdd
	mov r0, #0
	bne _0218220C
	mov ip, #0x3b
	sub r1, ip, #0x3c
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_0218220C:
	mov ip, #0x3a
	sub r1, ip, #0x3b
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0218222C: .word Player__State_2023A4C
	arm_func_end ovl00_2182184

	arm_func_start ovl00_2182230
ovl00_2182230: // 0x02182230
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x20
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r2, [sp, #8]
	ldr r0, [r4, #0x128]
	add r1, r4, #0x44
	add r3, r4, #0x38
	bl StageTask__Draw2DEx
	add r0, r4, #0x400
	ldrh r2, [r0, #8]
	ldr r1, _021822B4 // =0x02189BF2
	ldr r0, _021822B8 // =0x0000FFFF
	mov r2, r2, lsl #2
	ldrh r1, [r1, r2]
	cmp r1, r0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, pc}
	add r0, r4, #0x20
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	add r0, r4, #0x364
	add r1, r4, #0x44
	add r3, r4, #0x38
	str r2, [sp, #8]
	bl StageTask__Draw2DEx
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021822B4: .word 0x02189BF2
_021822B8: .word 0x0000FFFF
	arm_func_end ovl00_2182230

	.data
	
_02189BE0:
	.byte 0x01, 0x02, 0x01, 0x01, 0x01, 0x02, 0x02, 0x02, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x02, 0x02
	.byte 0x02, 0x00, 0x03, 0x00, 0x08, 0x00, 0x09, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00, 0x07, 0x00
	.byte 0x00, 0x00, 0xFF, 0xFF, 0x01, 0x00, 0xFF, 0xFF, 0x0B, 0x00, 0xFF, 0xFF, 0x0A, 0x00, 0xFF, 0xFF

aModGmkDolphinN: // 0x02189C10
	.asciz "/mod/gmk_dolphin.nsbmd"
	.align 4
	
aModGmkDolphinN_0: // 0x02189C28
	.asciz "/mod/gmk_dolphin.nsbca"
	.align 4
	
aActAcGmkDolphi: // 0x02189C40
	.asciz "/act/ac_gmk_dolphin_hoop.bac"
	.align 4