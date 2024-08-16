	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start FloatingFountain__Create
FloatingFountain__Create: // 0x021809C8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	ldr r3, _02180BE4 // =0x00001801
	mov r7, r0
	str r3, [sp]
	mov r0, #2
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _02180BE8 // =0x00000408
	ldr r0, _02180BEC // =StageTask_Main
	ldr r1, _02180BF0 // =FloatingFountain__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	ldr r2, _02180BE8 // =0x00000408
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xa5
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02180BF4 // =gameArchiveStage
	ldr r1, _02180BF8 // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02180BFC // =aActAcGmkFloatF
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x5d
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, #0xa5
	add r5, r4, #0x364
	bl GetObjectFileWork
	ldr r1, _02180BF4 // =gameArchiveStage
	mov r3, r0
	ldr r2, [r1]
	ldr r1, _02180BFC // =aActAcGmkFloatF
	str r2, [sp]
	mov r0, r5
	mov r2, #8
	bl ObjAction2dBACLoad
	ldr r1, [r4, #0x128]
	mov r0, r5
	ldrh r2, [r1, #0x50]
	mov r1, #2
	strh r2, [r5, #0x50]
	strh r2, [r5, #0x92]
	strh r2, [r5, #0x90]
	ldr r2, [r5, #0x3c]
	orr r2, r2, #0x10
	str r2, [r5, #0x3c]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r5
	mov r1, #0x16
	bl StageTask__SetOAMOrder
	mov r0, r5
	mov r1, #2
	bl StageTask__SetOAMPriority
	mov r1, #0
	add r0, r4, #0x218
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, _02180C00 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02180C04 // =ovl00_2180CF8
	mov r1, #0
	str r0, [r4, #0x23c]
	ldr r2, [r4, #0x230]
	mov r0, #0x14c
	orr r2, r2, #0x400
	str r2, [r4, #0x230]
	ldrsb r2, [r7, #6]
	str r2, [sp]
	ldrsb r2, [r7, #7]
	str r2, [sp, #4]
	ldrb r2, [r7, #8]
	str r2, [sp, #8]
	ldrb r2, [r7, #9]
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	ldrh r3, [r7, #4]
	ldr r1, [r4, #0x44]
	ldr r2, [r4, #0x48]
	bic r3, r3, #0xc0
	orr r3, r3, #0x80
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	bl GameObject__SpawnObject
	cmp r0, #0
	beq _02180BC8
	str r0, [r4, #0x11c]
	ldr r0, [r4, #0x18]
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
_02180BC8:
	ldr r1, _02180C08 // =ovl00_2180D98
	mov r0, r4
	str r1, [r4, #0xfc]
	bl ovl00_2180C38
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02180BE4: .word 0x00001801
_02180BE8: .word 0x00000408
_02180BEC: .word StageTask_Main
_02180BF0: .word FloatingFountain__Destructor
_02180BF4: .word gameArchiveStage
_02180BF8: .word 0x0000FFFF
_02180BFC: .word aActAcGmkFloatF
_02180C00: .word 0x0000FFFE
_02180C04: .word ovl00_2180CF8
_02180C08: .word ovl00_2180D98
	arm_func_end FloatingFountain__Create

	arm_func_start FloatingFountain__Destructor
FloatingFountain__Destructor: // 0x02180C0C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0xa5
	bl GetObjectFileWork
	add r1, r4, #0x364
	bl ObjAction2dBACRelease
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end FloatingFountain__Destructor

	arm_func_start ovl00_2180C38
ovl00_2180C38: // 0x02180C38
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _02180C60 // =ovl00_2180C64
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02180C60: .word ovl00_2180C64
	arm_func_end ovl00_2180C38

	arm_func_start ovl00_2180C64
ovl00_2180C64: // 0x02180C64
	ldr r1, [r0, #0x11c]
	cmp r1, #0
	bxeq lr
	add r1, r1, #0x44
	add r3, r0, #0x44
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	bx lr
	arm_func_end ovl00_2180C64

	arm_func_start ovl00_2180C84
ovl00_2180C84: // 0x02180C84
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #1
	bl StageTask__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _02180CAC // =ovl00_2180CB0
	bic r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02180CAC: .word ovl00_2180CB0
	arm_func_end ovl00_2180C84

	arm_func_start ovl00_2180CB0
ovl00_2180CB0: // 0x02180CB0
	stmdb sp!, {r3, lr}
	mov ip, r0
	ldr r0, [ip, #0x11c]
	cmp r0, #0
	beq _02180CD4
	add r0, r0, #0x44
	add r3, ip, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
_02180CD4:
	ldr r0, [ip, #0x20]
	tst r0, #8
	ldmeqia sp!, {r3, pc}
	ldr r1, [ip, #0x230]
	mov r0, ip
	bic r1, r1, #0x100
	str r1, [ip, #0x230]
	bl ovl00_2180C38
	ldmia sp!, {r3, pc}
	arm_func_end ovl00_2180CB0

	arm_func_start ovl00_2180CF8
ovl00_2180CF8: // 0x02180CF8
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
	mov r0, r4
	bl ovl00_2180C84
	ldr r0, [r4, #0x340]
	mov r1, #0
	ldrh r3, [r0, #4]
	sub r2, r1, #0x1800
	mov r0, r5
	and r3, r3, #0xc0
	mov r3, r3, asr #6
	mul r2, r3, r2
	sub r2, r2, #0x7800
	bl Player__Action_Spring
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	mov r0, r5
	bl EffectIceSparklesSpawner__Create
	mov r0, #0
	str r0, [sp]
	ldr r1, _02180D94 // =0x0000011D
	str r1, [sp, #4]
	rsb r1, r1, #0x11c
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02180D94: .word 0x0000011D
	arm_func_end ovl00_2180CF8

	arm_func_start ovl00_2180D98
ovl00_2180D98: // 0x02180D98
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x128]
	bl StageTask__Draw2D
	ldr r1, [r4, #0x20]
	add r0, sp, #0xc
	orr r1, r1, #4
	str r1, [sp, #0xc]
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	add r0, r4, #0x364
	add r1, r4, #0x44
	add r3, r4, #0x38
	str r2, [sp, #8]
	bl StageTask__Draw2DEx
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	arm_func_end ovl00_2180D98

	.data
	
aActAcGmkFloatF: // 0x02189BA4
	.asciz "/act/ac_gmk_float_fountain.bac"
	.align 4