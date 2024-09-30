	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start RopeTar__Create
RopeTar__Create: // 0x0216219C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x2c
	ldr r3, _02162490 // =0x000010F6
	mov r7, r0
	str r3, [sp]
	mov r0, #2
	mov r6, r1
	mov r4, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r5, _02162494 // =0x00000954
	ldr r0, _02162498 // =StageTask_Main
	ldr r1, _0216249C // =RopeTar__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0x2c
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	mov r0, r5
	bl GetTaskWork_
	ldr r2, _02162494 // =0x00000954
	mov r5, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r5
	mov r1, r7
	mov r2, r6
	mov r3, r4
	bl GameObject__InitFromObject
	add r0, r5, #0x400
	mov r1, #0xc
	strh r1, [r0, #0x14]
	ldrh r0, [r7, #4]
	tst r0, #1
	ldreq r1, _021624A0 // =playerGameStatus
	ldr r0, _021624A4 // =0x6C16C16D
	ldreq r3, [r1, #0xc]
	moveq r2, #0xb4
	beq _0216225C
	ldr r1, _021624A0 // =playerGameStatus
	mov r2, #0xb4
	ldr r1, [r1, #0xc]
	add r3, r1, #0x5a
_0216225C:
	umull r0, r1, r3, r0
	sub r0, r3, r1
	add r1, r1, r0, lsr #1
	mov r1, r1, lsr #7
	umull r0, r1, r2, r1
	sub r1, r3, r0
	mov r0, r1, lsl #0x10
	mov r3, r0, asr #0x10
	mov r0, #0x5b
	add r1, r5, #0x400
	smulbb r2, r3, r0
	strh r3, [r1, #0x16]
	mov r0, #0xa1
	strh r2, [r1, #0x18]
	bl GetObjectFileWork
	ldr r1, _021624A8 // =gameArchiveStage
	mov r3, r0
	ldr r1, [r1, #0]
	ldr r2, _021624AC // =aActAcGmkRopeTa
	str r1, [sp]
	mov r4, #0
	mov r0, r5
	add r1, r5, #0x168
	str r4, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, #0xa2
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r5
	mov r1, #8
	bl ObjObjectActionAllocSprite
	mov r0, r5
	mov r1, r4
	bl StageTask__SetAnimation
	mov r0, r5
	mov r1, r4
	mov r2, #0xb
	bl ObjActionAllocSpritePalette
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r5
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	add r4, r5, #0x364
	mov r0, #0xa4
	bl GetObjectFileWork
	str r0, [r4, #0xa8]
	mov r1, #0
	mov r2, #1
	bl ObjActionAllocSprite
	mov r6, r0
	ldr r0, [r4, #0xa8]
	mov r1, #1
	add r0, r0, #8
	mov r2, r1
	bl ObjActionAllocSprite
	mov r1, #0x810
	str r1, [sp]
	mov r3, #0
	stmib sp, {r3, r6}
	ldr r2, _021624B0 // =0x05000200
	str r3, [sp, #0xc]
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	str r0, [sp, #0x18]
	add r2, r2, #0x400
	str r3, [sp, #0x1c]
	str r2, [sp, #0x20]
	mov r1, #2
	str r1, [sp, #0x24]
	mov r0, #0x17
	str r0, [sp, #0x28]
	ldr r1, [r5, #0x128]
	mov r0, r4
	ldr r1, [r1, #0xa4]
	mov r2, #1
	ldr r1, [r1, #0]
	bl AnimatorSpriteDS__Init
	ldr r0, [r5, #0x128]
	mov r6, #0x10
	ldrh r0, [r0, #0x50]
	ldr r3, _021624B4 // =0x00000102
	mov r2, #4
	strh r0, [r4, #0x90]
	strh r0, [r4, #0x92]
	ldrh r7, [r4, #0x90]
	add r0, r5, #0x400
	sub r1, r6, #0x14
	strh r7, [r4, #0x50]
	strh r3, [r0, #0xe4]
	str r2, [sp]
	str r2, [sp, #4]
	mov r2, r1
	add r0, r5, #0x4b0
	sub r3, r6, #0x20
	str r6, [sp, #8]
	bl ObjRect__SetBox3D
	mov r1, #0
	mov r2, r1
	add r0, r5, #0x4b0
	bl ObjRect__SetAttackStat
	ldr r1, _021624B8 // =0x0000FFFE
	add r0, r5, #0x4b0
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _021624BC // =RopeTar__Func_21628A4
	str r5, [r5, #0x4cc]
	str r0, [r5, #0x4d4]
	ldr r0, [r5, #0x4c8]
	add r7, r5, #0x400
	orr r0, r0, #0x400
	str r0, [r5, #0x4c8]
	ldrsh r0, [r7, #0x14]
	add r6, r5, #0x4f0
	mov r4, #1
	cmp r0, #1
	ble _02162464
	mov r8, #0x40
_02162438:
	mov r1, r6
	mov r2, r8
	add r0, r5, #0x4b0
	bl MI_CpuCopy8
	add r0, r4, #0x10
	strh r0, [r6, #0xa]
	ldrsh r0, [r7, #0x14]
	add r4, r4, #1
	add r6, r6, #0x40
	cmp r4, r0
	blt _02162438
_02162464:
	ldr r1, [r5, #0x1c]
	mov r0, r5
	orr r1, r1, #0x2100
	str r1, [r5, #0x1c]
	ldr r1, [r5, #0x20]
	orr r1, r1, #0x100
	str r1, [r5, #0x20]
	bl RopeTar__Action_Init
	mov r0, r5
	add sp, sp, #0x2c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02162490: .word 0x000010F6
_02162494: .word 0x00000954
_02162498: .word StageTask_Main
_0216249C: .word RopeTar__Destructor
_021624A0: .word playerGameStatus
_021624A4: .word 0x6C16C16D
_021624A8: .word gameArchiveStage
_021624AC: .word aActAcGmkRopeTa
_021624B0: .word 0x05000200
_021624B4: .word 0x00000102
_021624B8: .word 0x0000FFFE
_021624BC: .word RopeTar__Func_21628A4
	arm_func_end RopeTar__Create

	arm_func_start RopeTar__Destructor
RopeTar__Destructor: // 0x021624C0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x40c]
	mov r1, #0
	bl ObjActionReleaseSprite
	ldr r0, [r4, #0x40c]
	mov r1, #1
	add r0, r0, #8
	bl ObjActionReleaseSprite
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end RopeTar__Destructor

	arm_func_start RopeTar__Action_Init
RopeTar__Action_Init: // 0x021624F8
	ldr r1, _02162514 // =RopeTar__State_2162520
	ldr r2, _02162518 // =RopeTar__Draw_2162700
	str r1, [r0, #0xf4]
	ldr r1, _0216251C // =RopeTar__Collide_21627A4
	str r2, [r0, #0xfc]
	str r1, [r0, #0x108]
	bx lr
	.align 2, 0
_02162514: .word RopeTar__State_2162520
_02162518: .word RopeTar__Draw_2162700
_0216251C: .word RopeTar__Collide_21627A4
	arm_func_end RopeTar__Action_Init

	arm_func_start RopeTar__State_2162520
RopeTar__State_2162520: // 0x02162520
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	add r0, r4, #0x400
	ldrsh r1, [r0, #0x16]
	add r2, r4, #0x400
	add r1, r1, #1
	strh r1, [r0, #0x16]
	ldrsh r1, [r0, #0x16]
	cmp r1, #0xb4
	movge r1, #0
	strgeh r1, [r0, #0x16]
	ldrsh r3, [r2, #0x16]
	mov r1, #0x5b
	mov r0, r4
	smulbb r1, r3, r1
	strh r1, [r2, #0x18]
	bl RopeTar__Func_216299C
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	beq _021626DC
	ldr r0, [r0, #0x6d8]
	cmp r0, r4
	bne _021626C8
	add r1, r4, #0x400
	ldrsh r0, [r1, #0x14]
	ldrh lr, [r1, #0x1a]
	sub r0, r0, #1
	cmp lr, r0
	bge _02162664
	ldrh r2, [r1, #0x1c]
	add r0, r4, lr, lsl #3
	ldr r0, [r0, #0x420]
	and ip, r2, #1
	ldr r5, [r4, #0x44]
	rsb r3, ip, #2
	mov r2, r0, asr #1
	add r0, lr, #1
	add r0, r4, r0, lsl #3
	ldr r0, [r0, #0x420]
	mla r2, r3, r2, r5
	mov r0, r0, asr #1
	mla r0, ip, r0, r2
	str r0, [r4, #0x8c]
	ldrh r5, [r1, #0x1a]
	ldrh r3, [r1, #0x1c]
	ldr ip, [r4, #0x48]
	add r0, r4, r5, lsl #3
	ldr r2, [r0, #0x424]
	and lr, r3, #1
	add r0, r5, #1
	add r0, r4, r0, lsl #3
	ldr r0, [r0, #0x424]
	rsb r3, lr, #2
	mov r2, r2, asr #1
	mla r2, r3, r2, ip
	mov r0, r0, asr #1
	mla r0, lr, r0, r2
	str r0, [r4, #0x90]
	ldrh r3, [r1, #0x1a]
	ldrh r2, [r1, #0x1c]
	add r0, r3, #1
	add r0, r4, r0, lsl #1
	add r0, r0, #0x900
	ldrh r0, [r0, #0x30]
	and ip, r2, #1
	add r3, r4, r3, lsl #1
	mov r2, r0, asr #1
	add r0, r3, #0x900
	ldrh r3, [r0, #0x30]
	mul r0, ip, r2
	rsb ip, ip, #2
	mov r2, r3, asr #1
	mla r0, ip, r2, r0
	strh r0, [r4, #0x34]
	ldrh r0, [r1, #0x1c]
	add r0, r0, #1
	strh r0, [r1, #0x1c]
	ldrh r0, [r1, #0x1c]
	mov r0, r0, asr #1
	strh r0, [r1, #0x1a]
	b _021626A4
_02162664:
	add r0, r4, lr, lsl #3
	ldr r2, [r4, #0x44]
	ldr r0, [r0, #0x420]
	add r0, r2, r0
	str r0, [r4, #0x8c]
	ldrh r0, [r1, #0x1a]
	ldr r2, [r4, #0x48]
	add r0, r4, r0, lsl #3
	ldr r0, [r0, #0x424]
	add r0, r2, r0
	str r0, [r4, #0x90]
	ldrh r0, [r1, #0x1a]
	add r0, r4, r0, lsl #1
	add r0, r0, #0x900
	ldrh r0, [r0, #0x30]
	strh r0, [r4, #0x34]
_021626A4:
	ldr r0, [r4, #0x35c]
	ldr r0, [r0, #0x20]
	tst r0, #1
	ldrh r0, [r4, #0x34]
	subne r0, r0, #0x4000
	strneh r0, [r4, #0x34]
	addeq r0, r0, #0x4000
	streqh r0, [r4, #0x34]
	ldmia sp!, {r3, r4, r5, pc}
_021626C8:
	mov r0, #0
	str r0, [r4, #0x35c]
	mov r0, #0x1e
	str r0, [r4, #0x2c]
	ldmia sp!, {r3, r4, r5, pc}
_021626DC:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	ldreq r0, [r4, #0x18]
	biceq r0, r0, #2
	streq r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end RopeTar__State_2162520

	arm_func_start RopeTar__Draw_2162700
RopeTar__Draw_2162700: // 0x02162700
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x18
	bl GetCurrentTaskWork_
	mov r9, r0
	ldr r1, [r9, #0x128]
	bl StageTask__Draw2D
	add r10, r9, #0x400
	ldrsh r0, [r10, #0x14]
	mov r8, #0
	cmp r0, #0
	addle sp, sp, #0x18
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r7, r9, #0x44
	add r5, r9, #0x20
	add r6, sp, #0xc
	mov r4, r8
_02162740:
	ldmia r7, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	add r1, r9, r8, lsl #3
	ldr r3, [sp, #0xc]
	ldr r0, [r1, #0x420]
	ldr r2, [sp, #0x10]
	add r0, r3, r0
	str r0, [sp, #0xc]
	ldr r0, [r1, #0x424]
	mov r1, r6
	add r0, r2, r0
	str r0, [sp, #0x10]
	str r5, [sp]
	str r4, [sp, #4]
	mov r2, r4
	mov r3, r4
	str r4, [sp, #8]
	add r0, r9, #0x364
	bl StageTask__Draw2DEx
	ldrsh r0, [r10, #0x14]
	add r8, r8, #1
	cmp r8, r0
	blt _02162740
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end RopeTar__Draw_2162700

	arm_func_start RopeTar__Collide_21627A4
RopeTar__Collide_21627A4: // 0x021627A4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	add r0, r5, #0x400
	ldr r2, [r5, #0x18]
	ldrsh r7, [r0, #0x14]
	ldr r1, _0216289C // =gPlayer
	add r6, r5, #0x4b0
	tst r2, #0xc
	ldr r0, [r1, #0]
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, _021628A0 // =g_obj
	ldr r1, [r1, #0x28]
	tst r1, #0x40
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	tst r2, #2
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	sub r1, r7, #1
	add r2, r5, r1, lsl #3
	ldr r2, [r2, #0x420]
	ldr r3, [r5, #0x44]
	cmp r2, #0
	addlt r2, r3, r2
	sublt r4, r2, #0x20000
	addlt r3, r3, #0x20000
	blt _02162818
	add r2, r3, r2
	sub r4, r3, #0x20000
	add r3, r2, #0x20000
_02162818:
	ldr r2, [r0, #0x44]
	cmp r2, r4
	cmpge r3, r2
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r3, [r5, #0x48]
	ldr r2, [r0, #0x48]
	sub r0, r3, #0x20000
	cmp r2, r0
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r5, r1, lsl #3
	ldr r0, [r0, #0x424]
	add r0, r3, r0
	add r0, r0, #0x20000
	cmp r0, r2
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
	mov r4, #0
	cmp r7, #0
	cmpgt r7, #0
	ldmleia sp!, {r3, r4, r5, r6, r7, pc}
_02162864:
	add r2, r5, r4, lsl #3
	ldr r1, [r2, #0x420]
	mov r0, r6
	mov r1, r1, asr #0xc
	str r1, [r6, #0xc]
	ldr r1, [r2, #0x424]
	mov r1, r1, asr #0xc
	str r1, [r6, #0x10]
	bl ObjRect__Register
	add r4, r4, #1
	cmp r4, r7
	add r6, r6, #0x40
	blt _02162864
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216289C: .word gPlayer
_021628A0: .word g_obj
	arm_func_end RopeTar__Collide_21627A4

	arm_func_start RopeTar__Func_21628A4
RopeTar__Func_21628A4: // 0x021628A4
	stmdb sp!, {r4, lr}
	ldr r2, [r1, #0x1c]
	ldr r4, [r0, #0x1c]
	cmp r2, #0
	cmpne r4, #0
	ldmeqia sp!, {r4, pc}
	ldrh r0, [r4, #0]
	cmp r0, #1
	ldmneia sp!, {r4, pc}
	str r4, [r2, #0x35c]
	ldr r3, [r2, #0x18]
	add r0, r2, #0x400
	orr r3, r3, #2
	str r3, [r2, #0x18]
	ldrsh r1, [r1, #0xa]
	sub r1, r1, #0x10
	strh r1, [r0, #0x1a]
	ldrh r1, [r0, #0x1a]
	mov r1, r1, lsl #1
	strh r1, [r0, #0x1c]
	ldrh r1, [r0, #0x1a]
	ldr r3, [r2, #0x44]
	add r1, r2, r1, lsl #3
	ldr r1, [r1, #0x420]
	add r1, r3, r1
	str r1, [r2, #0x8c]
	ldrh r1, [r0, #0x1a]
	ldr r3, [r2, #0x48]
	add r1, r2, r1, lsl #3
	ldr r1, [r1, #0x424]
	add r1, r3, r1
	str r1, [r2, #0x90]
	ldrh r1, [r0, #0x1a]
	add r1, r2, r1, lsl #1
	add r1, r1, #0x900
	ldrh r1, [r1, #0x30]
	strh r1, [r2, #0x34]
	ldrh r0, [r0, #0x1a]
	ldr r1, [r4, #0x20]
	tst r1, #1
	add r0, r2, r0, lsl #1
	beq _0216295C
	add r0, r0, #0x900
	ldrh r0, [r0, #0x30]
	sub r0, r0, #0x4000
	b _02162968
_0216295C:
	add r0, r0, #0x900
	ldrh r0, [r0, #0x30]
	add r0, r0, #0x4000
_02162968:
	strh r0, [r2, #0x34]
	mov r1, r2
	mov r0, r4
	mov r2, #0
	mov r3, #0x4000
	bl Player__Gimmick_201D314
	mov r0, r4
	mov r1, #0x27
	bl Player__ChangeAction
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
	arm_func_end RopeTar__Func_21628A4

	arm_func_start RopeTar__Func_216299C
RopeTar__Func_216299C: // 0x0216299C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r4, r0
	add r1, r4, #0x400
	ldrsh r0, [r1, #0x14]
	ldrsh r5, [r1, #0x18]
	str r0, [sp]
	ldr r1, [sp]
	mov r0, #0x1000
	bl _s32_div_f
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	cmp r5, #0x1000
	str r0, [sp, #8]
	bge _02162A8C
	ldr r2, _02162E04 // =0xFFFF9556
	mov r1, r5, asr #0x1f
	mov r0, #1
	mov r7, #0x4000
	mov r6, #0
	mov r3, #0x800
_021629F0:
	add r7, r7, r2
	umull r9, r8, r7, r5
	mla r8, r7, r1, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, r5, r8
	adds r9, r9, r3
	adc r7, r8, r6
	mov r8, r9, lsr #0xc
	orr r8, r8, r7, lsl #20
	add r7, r8, #0xaa
	cmp r0, #0
	add r7, r7, #0x6a00
	sub r0, r0, #1
	bne _021629F0
	mov r0, r7, lsl #0x10
	mov r7, #0
	mov r11, r0, lsr #0x10
	ldr r2, _02162E08 // =0xFFFFEAAB
	mov r0, #3
	mov r6, r7
	mov r3, #0x800
_02162A44:
	add r8, r7, r2
	umull r7, r9, r8, r5
	adds r7, r7, r3
	mov r10, r7, lsr #0xc
	mla r9, r8, r1, r9
	mov r7, r8, asr #0x1f
	mla r9, r7, r5, r9
	adc r7, r9, r6
	orr r10, r10, r7, lsl #20
	add r7, r10, #0x55
	cmp r0, #0
	add r7, r7, #0x1500
	sub r0, r0, #1
	bne _02162A44
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
	b _02162CD0
_02162A8C:
	cmp r5, #0x2000
	bge _02162B50
	sub r0, r5, #0x1000
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	ldr r2, _02162E0C // =0x00001556
	mov r3, r5, asr #0x1f
	mov r1, #1
	mov r0, #0x4000
	mov r7, #0
	mov r6, #0x800
_02162AB8:
	sub r8, r2, r0
	umull r10, r9, r8, r5
	mla r9, r8, r3, r9
	mov r8, r8, asr #0x1f
	mla r9, r8, r5, r9
	adds r10, r10, r6
	adc r8, r9, r7
	mov r9, r10, lsr #0xc
	orr r9, r9, r8, lsl #20
	cmp r1, #0
	add r0, r0, r9
	sub r1, r1, #1
	bne _02162AB8
	mov r0, r0, lsl #0x10
	mov r1, #0
	ldr r6, _02162E10 // =0x00001555
	mov r11, r0, lsr #0x10
	mov r2, #3
	mov r8, r1
	mov r7, #0x800
_02162B08:
	sub r10, r6, r1
	umull r0, ip, r10, r5
	mla ip, r10, r3, ip
	mov r9, r10, asr #0x1f
	adds r0, r0, r7
	mla ip, r9, r5, ip
	adc r9, ip, r8
	mov r0, r0, lsr #0xc
	orr r0, r0, r9, lsl #20
	cmp r2, #0
	add r1, r1, r0
	sub r2, r2, #1
	bne _02162B08
	rsb r0, r1, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
	b _02162CD0
_02162B50:
	cmp r5, #0x3000
	bge _02162C1C
	sub r0, r5, #0x2000
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	ldr r3, _02162E14 // =0xFFFFEAAA
	mov r1, r2, asr #0x1f
	mov r0, #1
	mov r7, #0x4000
	mov r6, #0
	mov r5, #0x800
_02162B7C:
	add r7, r7, r3
	umull r9, r8, r7, r2
	mla r8, r7, r1, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, r2, r8
	adds r9, r9, r5
	adc r7, r8, r6
	mov r8, r9, lsr #0xc
	orr r8, r8, r7, lsl #20
	add r7, r8, #0x56
	cmp r0, #0
	add r7, r7, #0x1500
	sub r0, r0, #1
	bne _02162B7C
	mov r0, r7, lsl #0x10
	mov r7, #0
	mov r11, r0, lsr #0x10
	ldr r3, _02162E08 // =0xFFFFEAAB
	mov r0, #3
	mov r6, r7
	mov r5, #0x800
_02162BD0:
	add r8, r7, r3
	umull r7, r9, r8, r2
	adds r7, r7, r5
	mov r10, r7, lsr #0xc
	mla r9, r8, r1, r9
	mov r7, r8, asr #0x1f
	mla r9, r7, r2, r9
	adc r7, r9, r6
	orr r10, r10, r7, lsl #20
	add r7, r10, #0x55
	cmp r0, #0
	add r7, r7, #0x1500
	sub r0, r0, #1
	bne _02162BD0
	rsb r0, r7, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
	b _02162CD0
_02162C1C:
	sub r0, r5, #0x3000
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	ldr r2, _02162E18 // =0x00006AAA
	mov r3, r5, asr #0x1f
	mov r1, #1
	mov r0, #0x4000
	mov r7, #0
	mov r6, #0x800
_02162C40:
	sub r8, r2, r0
	umull r10, r9, r8, r5
	mla r9, r8, r3, r9
	mov r8, r8, asr #0x1f
	mla r9, r8, r5, r9
	adds r10, r10, r6
	adc r8, r9, r7
	mov r9, r10, lsr #0xc
	orr r9, r9, r8, lsl #20
	cmp r1, #0
	add r0, r0, r9
	sub r1, r1, #1
	bne _02162C40
	mov r0, r0, lsl #0x10
	mov r1, #0
	ldr r6, _02162E10 // =0x00001555
	mov r11, r0, lsr #0x10
	mov r2, #3
	mov r8, r1
	mov r7, #0x800
_02162C90:
	sub r10, r6, r1
	umull r0, ip, r10, r5
	mla ip, r10, r3, ip
	mov r9, r10, asr #0x1f
	adds r0, r0, r7
	mla ip, r9, r5, ip
	adc r9, ip, r8
	mov r0, r0, lsr #0xc
	orr r0, r0, r9, lsl #20
	cmp r2, #0
	add r1, r1, r0
	sub r2, r2, #1
	bne _02162C90
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
_02162CD0:
	ldr r0, [sp, #4]
	ldr r2, _02162E1C // =FX_SinCosTable_
	cmp r0, #0x8000
	mov r0, r11, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r3, r0, lsl #1
	add r0, r4, #0x900
	strh r11, [r0, #0x30]
	add r1, r3, #1
	mov r0, r1, lsl #1
	ldrsh r1, [r2, r0]
	ldr r9, [sp, #8]
	mov r0, r3, lsl #1
	mov r1, r1, lsl #4
	str r1, [r4, #0x420]
	ldrsh r1, [r2, r0]
	movlo r10, #0
	ldr r0, [sp]
	movhs r10, #0x10000
	cmp r0, #1
	mov r0, r1, lsl #4
	mov r5, #1
	addle sp, sp, #0xc
	str r0, [r4, #0x424]
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02162D38:
	ldr r2, [sp, #4]
	mov r8, r9, asr #0x1f
	mov r6, #1
	mov r1, #0
	mov r0, #0x800
_02162D4C:
	sub r3, r2, r10
	umull lr, ip, r3, r9
	mla ip, r3, r8, ip
	mov r2, r3, asr #0x1f
	adds r3, lr, r0
	mla ip, r2, r9, ip
	mov r7, r6
	adc r2, ip, r1
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	cmp r7, #0
	sub r6, r6, #1
	add r2, r10, r3
	bne _02162D4C
	add r0, r11, r2
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r0, r3, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	add r1, r4, r5, lsl #1
	add r6, r1, #0x900
	mov r2, r0, lsl #1
	add r1, r4, r5, lsl #3
	strh r3, [r6, #0x30]
	ldr r0, _02162E1C // =FX_SinCosTable_
	ldr r7, [r1, #0x418]
	add r3, r0, r2, lsl #1
	ldrsh r6, [r3, #2]
	ldr r3, [sp, #8]
	add r5, r5, #1
	add r6, r7, r6, lsl #3
	str r6, [r1, #0x420]
	add r3, r9, r3
	mov r6, r2, lsl #1
	mov r2, r3, lsl #0x10
	ldrsh r3, [r0, r6]
	ldr r0, [sp]
	ldr r6, [r1, #0x41c]
	cmp r5, r0
	add r0, r6, r3, lsl #3
	str r0, [r1, #0x424]
	mov r9, r2, asr #0x10
	blt _02162D38
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02162E04: .word 0xFFFF9556
_02162E08: .word 0xFFFFEAAB
_02162E0C: .word 0x00001556
_02162E10: .word 0x00001555
_02162E14: .word 0xFFFFEAAA
_02162E18: .word 0x00006AAA
_02162E1C: .word FX_SinCosTable_
	arm_func_end RopeTar__Func_216299C

	.data
	
aActAcGmkRopeTa: // 0x02188FD0
	.asciz "/act/ac_gmk_rope_tar.bac"
	.align 4