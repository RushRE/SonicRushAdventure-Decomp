	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start PopSteam__Create
PopSteam__Create: // 0x02166380
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	mov r3, #0x1800
	mov r5, r0
	mov r8, r1
	str r3, [sp]
	mov r0, #2
	mov r6, #0
	str r0, [sp, #4]
	ldr r4, _0216687C // =0x00000428
	mov r7, r2
	ldr r0, _02166880 // =StageTask_Main
	ldr r1, _02166884 // =PopSteam__Destructor
	mov r2, r6
	mov r3, r6
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, r6
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0x20
	moveq r0, r6
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r4
	bl GetTaskWork_
	ldr r2, _0216687C // =0x00000428
	mov r4, r0
	mov r1, r6
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r5
	mov r2, r8
	mov r3, r7
	bl GameObject__InitFromObject
	bl AllocSndHandle
	str r0, [r4, #0x138]
	ldrh r0, [r5, #2]
	ldrsb r1, [r5, #6]
	cmp r0, #0x56
	addhs r0, r6, #1
	movhs r0, r0, lsl #0x10
	mov r1, r1, lsl #3
	movhs r6, r0, asr #0x10
	add r0, r4, #0x400
	add r1, r1, #0x78
	strh r1, [r0, #0x14]
	ldrsh r1, [r0, #0x14]
	cmp r1, #0x78
	movlt r1, #0x78
	blt _02166454
	cmp r1, #0x100
	movgt r1, #0x100
_02166454:
	add r0, r4, #0x400
	strh r1, [r0, #0x14]
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldrh r0, [r5, #2]
	cmp r0, #0x56
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #1
	streq r0, [r4, #0x20]
	ldrh r0, [r5, #2]
	cmp r0, #0x55
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #2
	streq r0, [r4, #0x20]
	mov r0, #0xaa
	bl GetObjectFileWork
	ldr r1, _02166888 // =gameArchiveStage
	mov r3, r0
	ldr r1, [r1, #0]
	ldr r2, _0216688C // =aActAcGmkPopSte
	str r1, [sp]
	mov r7, #0
	mov r0, r4
	add r1, r4, #0x168
	str r7, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r6, lsl #1
	add r0, r0, #0xab
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #2
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, r7
	mov r2, #0x22
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r1, r6, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldrh r0, [r5, #4]
	tst r0, #1
	beq _0216662C
	mov r0, #0xaa
	add r7, r4, #0x364
	bl GetObjectFileWork
	ldr r1, _02166888 // =gameArchiveStage
	mov r3, r0
	ldr r8, [r1, #0]
	ldr r1, _0216688C // =aActAcGmkPopSte
	ldr r2, _02166890 // =0x0000FFFF
	mov r0, r7
	str r8, [sp]
	bl ObjAction2dBACLoad
	mov r0, r7
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r7
	mov r1, #2
	bl StageTask__SetOAMPriority
	ldr r2, [r7, #0x64]
	mov r0, r6, lsl #0x11
	orr r2, r2, #0x810
	mov r1, r0, lsr #0x10
	mov r0, r7
	str r2, [r7, #0x64]
	bl AnimatorSpriteDS__SetAnimation
	ldr r0, [r4, #0x128]
	mov r1, #0
	ldrh r2, [r0, #0x50]
	ldr r0, _02166894 // =StageTask__DefaultDiffData
	mov r6, #0x20
	strh r2, [r7, #0x90]
	strh r2, [r7, #0x92]
	ldrh r3, [r7, #0x90]
	add r2, r4, #0x300
	ldr r8, _02166898 // =_021884FC
	strh r3, [r7, #0x50]
	str r1, [r4, #0x13c]
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	ldrh r7, [r5, #2]
	add r3, r4, #0x200
	add r0, r4, #0x218
	strh r6, [r2, #8]
	sub r7, r7, #0x54
	strh r6, [r2, #0xa]
	mov r2, r7, lsl #2
	ldrsh r6, [r8, r2]
	add r7, r8, r7, lsl #2
	mov r2, r1
	strh r6, [r3, #0xf0]
	ldrsh r6, [r7, #2]
	strh r6, [r3, #0xf2]
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _0216689C // =PopSteam__OnDefend_2166C34
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x354]
	orr r0, r0, #1
	str r0, [r4, #0x354]
	b _021666D8
_0216662C:
	str r4, [r4, #0x274]
	ldrh r0, [r5, #2]
	cmp r0, #0x56
	cmpne r0, #0x57
	bne _02166664
	mov r0, #0x10
	str r0, [sp]
	add r0, r4, #0x400
	mov r1, #0
	ldrsh r3, [r0, #0x14]
	add r0, r4, #0x258
	sub r2, r1, #0x10
	bl ObjRect__SetBox2D
	b _02166690
_02166664:
	mov r1, r7
	str r1, [sp]
	add r0, r4, #0x400
	ldrsh r2, [r0, #0x14]
	add r0, r4, #0x258
	sub r1, r1, #0x10
	rsb r2, r2, #0
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	mov r3, #0x10
	bl ObjRect__SetBox2D
_02166690:
	add r0, r4, #0x400
	ldrsh r2, [r0, #0x14]
	mov r6, #0x58
	sub r1, r6, #0x59
	strh r2, [r0, #0x16]
	ldr r0, [r4, #0x354]
	mov r3, #0
	orr r0, r0, #2
	str r0, [r4, #0x354]
	ldr r0, [r4, #0x138]
	mov r2, r1
	str r3, [sp]
	mov r3, r1
	str r6, [sp, #4]
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
_021666D8:
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x258
	bl ObjRect__SetAttackStat
	ldr r1, _021668A0 // =0x0000FFFE
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _021668A4 // =PopSteam__OnDefend_2166B6C
	mov r0, #0x30000
	str r1, [r4, #0x27c]
	ldr r1, [r4, #0x270]
	orr r1, r1, #0x400
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x340]
	ldrsb r1, [r1, #7]
	mov r1, r1, lsl #0xb
	add r1, r1, #0x4000
	bl FX_DivS32
	mov r7, #0
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x418]
	str r0, [r4, #0x420]
	mov r0, r0, asr #1
	str r0, [r4, #0x424]
	ldrh r0, [r5, #2]
	ldrsb r1, [r5, #7]
	ldr r3, [r4, #0x418]
	sub r2, r0, #0x54
	ldr r0, [r4, #0x44]
	mov r1, r1, lsl #0xb
	str r0, [sp, #0x14]
	ldr r0, [r4, #0x48]
	str r7, [sp, #0x1c]
	str r7, [sp, #0x18]
	mov r8, r7
	mov r6, r3, asr #0xd
	add r1, r1, #0x6000
	cmp r2, #3
	str r0, [sp, #0x10]
	mov r9, r7
	str r7, [sp, #0xc]
	mov r11, r7
	addls pc, pc, r2, lsl #2
	b _0216679C
_0216678C: // jump table
	b _021667CC // case 0
	b _021667E0 // case 1
	b _0216679C // case 2
	b _021667B8 // case 3
_0216679C:
	rsb r0, r1, #0
	mul r2, r0, r6
	mov r8, #0x10000
	str r0, [sp, #0x1c]
	str r2, [sp, #0xc]
	rsb r8, r8, #0
	b _021667EC
_021667B8:
	mul r0, r1, r6
	str r0, [sp, #0xc]
	str r1, [sp, #0x1c]
	mov r8, #0x10000
	b _021667EC
_021667CC:
	rsb r0, r1, #0
	mul r11, r0, r6
	str r0, [sp, #0x18]
	sub r9, r7, #0x10000
	b _021667EC
_021667E0:
	mul r11, r1, r6
	str r1, [sp, #0x18]
	mov r9, #0x10000
_021667EC:
	add r0, r4, #0x400
	ldrsh r0, [r0, #0x16]
	mov r0, r0, lsl #0xc
	bl FX_DivS32
	mov r1, r6
	mov r10, r0, lsl #0xc
	bl FX_DivS32
	mov r5, r0
	b _02166858
_02166810:
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x14]
	str r0, [sp]
	ldr r2, [sp, #0x10]
	ldr r3, [sp, #0x1c]
	mov r0, r7
	add r1, r1, r8
	add r2, r2, r9
	str r10, [sp, #4]
	bl EffectSteamEffect__Create
	eor r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	ldr r0, [sp, #0xc]
	add r9, r9, r11
	add r8, r8, r0
	sub r10, r10, r6, lsl #12
	sub r5, r5, #1
_02166858:
	cmp r5, #0
	bgt _02166810
	ldr r0, _021668A8 // =PopSteam__Draw
	ldr r1, _021668AC // =PopSteam__State_21668F8
	str r0, [r4, #0xfc]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216687C: .word 0x00000428
_02166880: .word StageTask_Main
_02166884: .word PopSteam__Destructor
_02166888: .word gameArchiveStage
_0216688C: .word aActAcGmkPopSte
_02166890: .word 0x0000FFFF
_02166894: .word StageTask__DefaultDiffData
_02166898: .word _021884FC
_0216689C: .word PopSteam__OnDefend_2166C34
_021668A0: .word 0x0000FFFE
_021668A4: .word PopSteam__OnDefend_2166B6C
_021668A8: .word PopSteam__Draw
_021668AC: .word PopSteam__State_21668F8
	arm_func_end PopSteam__Create

	arm_func_start PopSteam__Destructor
PopSteam__Destructor: // 0x021668B0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #4]
	tst r0, #1
	beq _021668E0
	mov r0, #0xaa
	bl GetObjectFileWork
	add r1, r4, #0x364
	bl ObjAction2dBACRelease
_021668E0:
	ldr r0, [r4, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end PopSteam__Destructor

	arm_func_start PopSteam__State_21668F8
PopSteam__State_21668F8: // 0x021668F8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r9, r0
	ldr r0, [r9, #0x2c]
	cmp r0, #0
	beq _02166934
	subs r0, r0, #1
	str r0, [r9, #0x2c]
	ldr r0, [r9, #0x270]
	biceq r0, r0, #0x40000
	streq r0, [r9, #0x270]
	beq _02166934
	tst r0, #0x40000
	moveq r0, #0
	streq r0, [r9, #0x2c]
_02166934:
	ldr r0, [r9, #0x354]
	tst r0, #4
	beq _021669F0
	ldr r0, [r9, #0x340]
	add r1, r9, #0x400
	ldrsb r0, [r0, #7]
	ldrsh r2, [r1, #0x16]
	mov r0, r0, lsl #0xb
	add r0, r0, #0x6000
	mov r0, r0, lsl #4
	add r0, r2, r0, asr #16
	strh r0, [r1, #0x16]
	ldrsh r2, [r1, #0x14]
	ldrsh r0, [r1, #0x16]
	cmp r0, r2
	blt _02166984
	strh r2, [r1, #0x16]
	ldr r0, [r9, #0x354]
	bic r0, r0, #4
	str r0, [r9, #0x354]
_02166984:
	ldr r0, [r9, #0x340]
	mov r1, #0
	ldrh r0, [r0, #2]
	add r0, r0, #0xaa
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _021669C8
	mov r0, #0x10
	str r0, [sp]
	add r0, r9, #0x400
	ldrsh r3, [r0, #0x16]
	add r0, r9, #0x258
	sub r2, r1, #0x10
	bl ObjRect__SetBox2D
	b _021669F0
_021669C8:
	str r1, [sp]
	add r0, r9, #0x400
	ldrsh r2, [r0, #0x16]
	add r0, r9, #0x258
	sub r1, r1, #0x10
	rsb r2, r2, #0
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	mov r3, #0x10
	bl ObjRect__SetBox2D
_021669F0:
	ldr r0, [r9, #0x354]
	tst r0, #2
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r4, _02166B5C // =0x0000FFFF
	mov r8, #0
	bl GetObjSpeed
	ldr r1, [r9, #0x41c]
	add r0, r1, r0
	str r0, [r9, #0x41c]
	bl GetObjSpeed
	ldr r1, [r9, #0x424]
	add r0, r1, r0
	str r0, [r9, #0x424]
	ldr r1, [r9, #0x41c]
	ldr r0, [r9, #0x418]
	cmp r1, r0
	blt _02166A48
	mov r0, r8
	str r0, [r9, #0x41c]
	mov r4, #1
	b _02166A90
_02166A48:
	ldr r1, [r9, #0x424]
	ldr r0, [r9, #0x420]
	cmp r1, r0
	blt _02166A90
	mov r4, r8
	ldr r2, _02166B60 // =_mt_math_rand
	str r4, [r9, #0x424]
	ldr r3, [r2, #0]
	ldr r0, _02166B64 // =0x00196225
	ldr r1, _02166B68 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0xf
	sub r0, r0, #7
	str r1, [r2]
	mov r8, r0, lsl #0xc
_02166A90:
	ldr r0, _02166B5C // =0x0000FFFF
	cmp r4, r0
	beq _02166B48
	ldr r0, [r9, #0x340]
	mov r5, #0
	ldrsb r1, [r0, #7]
	ldrh r0, [r0, #2]
	mov r6, r5
	mov r1, r1, lsl #0xb
	sub r0, r0, #0x54
	cmp r0, #3
	add r1, r1, #0x6000
	addls pc, pc, r0, lsl #2
	b _02166AD8
_02166AC8: // jump table
	b _02166AF4 // case 0
	b _02166B04 // case 1
	b _02166AD8 // case 2
	b _02166AE8 // case 3
_02166AD8:
	mov r7, #0x10000
	rsb r5, r1, #0
	rsb r7, r7, #0
	b _02166B10
_02166AE8:
	mov r5, r1
	mov r7, #0x10000
	b _02166B10
_02166AF4:
	mov r7, r8
	rsb r6, r1, #0
	sub r8, r5, #0x10000
	b _02166B10
_02166B04:
	mov r6, r1
	mov r7, r8
	mov r8, #0x10000
_02166B10:
	add r0, r9, #0x400
	ldrsh r0, [r0, #0x16]
	mov r0, r0, lsl #0xc
	bl FX_DivS32
	mov r0, r0, lsl #0xc
	str r6, [sp]
	str r0, [sp, #4]
	ldr r1, [r9, #0x44]
	ldr r2, [r9, #0x48]
	mov r0, r4
	mov r3, r5
	add r1, r1, r7
	add r2, r2, r8
	bl EffectSteamEffect__Create
_02166B48:
	ldr r0, [r9, #0x138]
	add r1, r9, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02166B5C: .word 0x0000FFFF
_02166B60: .word _mt_math_rand
_02166B64: .word 0x00196225
_02166B68: .word 0x3C6EF35F
	arm_func_end PopSteam__State_21668F8

	arm_func_start PopSteam__OnDefend_2166B6C
PopSteam__OnDefend_2166B6C: // 0x02166B6C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r4, [r1, #0x1c]
	mov r2, #0
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	mov r3, r2
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x340]
	ldrsb r1, [r0, #7]
	ldrh r0, [r0, #2]
	mov r1, r1, lsl #0xb
	sub r0, r0, #0x54
	cmp r0, #3
	add r1, r1, #0x6000
	addls pc, pc, r0, lsl #2
	b _02166BF4
_02166BC8: // jump table
	b _02166BD8 // case 0
	b _02166BE0 // case 1
	b _02166BE8 // case 2
	b _02166BF0 // case 3
_02166BD8:
	rsb r3, r1, #0
	b _02166BF4
_02166BE0:
	mov r3, r1
	b _02166BF4
_02166BE8:
	rsb r2, r1, #0
	b _02166BF4
_02166BF0:
	mov r2, r1
_02166BF4:
	add r0, r4, #0x400
	ldrsh ip, [r0, #0x14]
	mov r0, r5
	mov r1, r4
	mov ip, ip, lsl #0xc
	str ip, [sp]
	mov ip, #1
	str ip, [sp, #4]
	bl Player__Action_PopSteam
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	mov r0, #0x3c
	str r0, [r4, #0x2c]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end PopSteam__OnDefend_2166B6C

	arm_func_start PopSteam__OnDefend_2166C34
PopSteam__OnDefend_2166C34: // 0x02166C34
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r4, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r4, #0
	cmpne r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r1, [r0, #0]
	cmp r1, #5
	bne _02166C90
	ldr r1, [r0, #0x11c]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r0, [r1, #0]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r1, #0x1c]
	bic r0, r0, #4
	str r0, [r1, #0x1c]
	b _02166CBC
_02166C90:
	cmp r1, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	moveq r1, #1
	movne r1, #0
	tst r1, #0x10
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	bl Player__Action_DestroyAttackRecoil
_02166CBC:
	mov r0, #3
	bl ShakeScreen
	mov r0, #0
	str r0, [r4, #0x234]
	ldr r1, [r4, #0x230]
	bic r1, r1, #4
	orr r1, r1, #0x800
	str r1, [r4, #0x230]
	str r0, [r4, #0x2d8]
	ldr r1, [r4, #0x354]
	bic r1, r1, #1
	orr r1, r1, #6
	str r1, [r4, #0x354]
	str r4, [r4, #0x274]
	ldr r1, [r4, #0x340]
	ldr r5, [r4, #0x44]
	ldrh r1, [r1, #2]
	ldr r6, [r4, #0x48]
	sub r1, r1, #0x54
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _02166D60
_02166D14: // jump table
	b _02166D24 // case 0
	b _02166D34 // case 1
	b _02166D44 // case 2
	b _02166D54 // case 3
_02166D24:
	mov r7, r0
	sub r6, r6, #0x10000
	sub r8, r0, #0x4000
	b _02166D60
_02166D34:
	mov r7, r0
	add r6, r6, #0x10000
	mov r8, #0x4000
	b _02166D60
_02166D44:
	sub r7, r0, #0x4000
	mov r8, r7
	sub r5, r5, #0x10000
	b _02166D60
_02166D54:
	mov r7, #0x4000
	add r5, r5, #0x10000
	sub r8, r7, #0x8000
_02166D60:
	mov r1, r5
	mov r2, r6
	sub r3, r7, #0x2800
	mov r0, #0
	str r8, [sp]
	bl EffectSteamDust__Create
	add ip, r8, #0x2000
	mov r1, r5
	mov r2, r6
	add r3, r7, #0x1800
	mov r0, #1
	str ip, [sp]
	bl EffectSteamDust__Create
	sub r0, r8, #0x2000
	str r0, [sp]
	mov r1, r5
	mov r0, #0
	mov r2, r6
	mov r3, r7
	bl EffectSteamDust__Create
	add r0, r8, #0x1000
	str r0, [sp]
	mov r0, #1
	mov r1, r5
	mov r2, r6
	sub r3, r7, #0x1800
	bl EffectSteamDust__Create
	sub r0, r8, #0x1000
	str r0, [sp]
	mov r1, r5
	mov r2, r6
	add r3, r7, #0x2800
	mov r0, #0
	bl EffectSteamDust__Create
	mov r0, #0
	str r0, [sp]
	mov r1, #0x43
	str r1, [sp, #4]
	sub r1, r1, #0x44
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #0
	str r0, [sp]
	mov r0, #0x58
	str r0, [sp, #4]
	sub r1, r0, #0x59
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end PopSteam__OnDefend_2166C34

	arm_func_start PopSteam__Draw
PopSteam__Draw: // 0x02166E40
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x128]
	bl StageTask__Draw2D
	ldr r0, [r4, #0x354]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r5, [r4, #0x20]
	mov r0, r4
	orr r2, r5, #4
	add r1, r4, #0x364
	str r2, [r4, #0x20]
	bl StageTask__Draw2D
	str r5, [r4, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end PopSteam__Draw

	.rodata

_021884FC: // 0x021884FC
    .word 0xFFE4FFF0, 0xFFE4FFF0, 0xFFF0FFFC, 0xFFF0FFFC

	.data
	
aActAcGmkPopSte: // 0x02189188
	.asciz "/act/ac_gmk_pop_steam.bac"
	.align 4