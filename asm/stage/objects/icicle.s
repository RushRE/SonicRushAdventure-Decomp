	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Icicle__Create
Icicle__Create: // 0x02168C7C
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
	ldr r4, _02168F18 // =0x00000478
	ldr r0, _02168F1C // =StageTask_Main
	ldr r1, _02168F20 // =GameObject__Destructor
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
	ldr r2, _02168F18 // =0x00000478
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0x9f
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02168F24 // =gameArchiveStage
	mov r1, #0
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _02168F28 // =aActAcGmkIcicle
	bl ObjObjectAction2dBACLoad
	mov r0, #0xa0
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #0x40
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #0
	mov r2, #0x23
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, #0xa2
	bl GetObjectFileWork
	mov r3, #0
	str r3, [sp]
	str r0, [sp, #4]
	ldr r1, _02168F24 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1]
	add r1, r4, #0x364
	str r2, [sp, #8]
	ldr r2, _02168F2C // =aActAcGmkIcicle_0
	bl ObjObjectAction3dBACLoad
	mov r0, #0xa3
	bl GetObjectFileWork
	mov r3, r0
	mov r0, r4
	mov r1, #0x1000
	mov r2, #0x10
	bl ObjObjectActionAllocTexture
	mov r0, #0xa3
	bl GetObjectFileWork
	ldrh r0, [r0, #4]
	bic r0, r0, #0x8000
	cmp r0, #1
	bgt _02168E0C
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
_02168E0C:
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldrsb r5, [r7, #6]
	cmp r5, #0
	movlt r5, #0
	blt _02168E30
	cmp r5, #3
	movgt r5, #3
_02168E30:
	cmp r5, #0
	ldrne r0, [r4, #0x1a4]
	orrne r0, r0, #0x200
	strne r0, [r4, #0x1a4]
	mov r0, r5, lsl #0xb
	add r0, r0, #0x1000
	str r0, [r4, #0x3c]
	ldr r1, [r4, #0x340]
	mov r0, #0x1000
	ldrsb r1, [r1, #6]
	mov r1, r1, lsl #7
	add r1, r1, #0x100
	mov r1, r1, lsl #0xc
	bl FX_Div
	str r0, [r4, #0x24]
	str r4, [r4, #0x234]
	ldr r1, [r4, #0x230]
	mov r0, r5, lsl #0x17
	orr r1, r1, #0x1000
	mov r2, #0x20
	str r1, [r4, #0x230]
	sub r1, r2, #0x40
	str r2, [sp]
	mov r0, r0, asr #0x10
	stmib sp, {r0, r2}
	mov r3, r1
	add r0, r4, #0x218
	sub r2, r2, #0x110
	bl ObjRect__SetBox3D
	ldr r0, [r4, #0x44]
	mov r1, #0
	mov r0, r0, asr #0xc
	str r0, [r4, #0x224]
	ldr r0, [r4, #0x48]
	mov r2, r1
	mov r0, r0, asr #0xc
	str r0, [r4, #0x228]
	ldr r3, [r4, #0x4c]
	add r0, r4, #0x218
	mov r3, r3, asr #0xc
	str r3, [r4, #0x22c]
	bl ObjRect__SetAttackStat
	ldr r1, _02168F30 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _02168F34 // =Icicle__OnDefend
	ldr r0, _02168F38 // =Icicle__Draw
	str r1, [r4, #0x23c]
	ldr r2, [r4, #0x230]
	ldr r1, _02168F3C // =Icicle__State_Active
	orr r2, r2, #0x400
	str r2, [r4, #0x230]
	str r0, [r4, #0xfc]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02168F18: .word 0x00000478
_02168F1C: .word StageTask_Main
_02168F20: .word GameObject__Destructor
_02168F24: .word gameArchiveStage
_02168F28: .word aActAcGmkIcicle
_02168F2C: .word aActAcGmkIcicle_0
_02168F30: .word 0x0000FFFE
_02168F34: .word Icicle__OnDefend
_02168F38: .word Icicle__Draw
_02168F3C: .word Icicle__State_Active
	arm_func_end Icicle__Create

	arm_func_start Icicle__State_Active
Icicle__State_Active: // 0x02168F40
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	beq _02168F74
	ldr r0, [r0, #0x6d8]
	cmp r0, r4
	beq _02168F94
	mov r0, #0
	str r0, [r4, #0x35c]
	mov r0, #0x3c
	str r0, [r4, #0x2c]
	b _02168F94
_02168F74:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	beq _02168F94
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	ldreq r0, [r4, #0x18]
	biceq r0, r0, #2
	streq r0, [r4, #0x18]
_02168F94:
	ldr r0, [r4, #0x28]
	cmp r0, #0
	bne _02169070
	ldr r3, _02169080 // =_mt_math_rand
	ldr r5, [r4, #0x340]
	ldr r0, [r3]
	ldr r1, _02169084 // =0x00196225
	ldr r2, _02169088 // =0x3C6EF35F
	ldrsb r5, [r5, #6]
	mla lr, r0, r1, r2
	mov r0, r5, lsl #7
	add ip, r0, #0x100
	mov r0, lr, lsr #0x10
	sub r5, ip, #1
	mov r0, r0, lsl #0x10
	and r0, r5, r0, lsr #16
	mov r5, ip, lsl #0xc
	mla ip, lr, r1, r2
	mov r1, ip, lsr #0x10
	mov r2, r1, lsl #0x10
	str lr, [r3]
	ldr lr, [r4, #0x24]
	sub r5, r5, r0, lsl #12
	mov r1, #0x16
	mul r1, r5, r1
	smull lr, r5, r1, lr
	adds r1, lr, #0x800
	mov lr, r1, lsr #0xc
	mov r1, r2, lsr #0x10
	adc r5, r5, #0
	str ip, [r3]
	mov r2, #0
	str r2, [sp]
	tst r1, #1
	ldr r1, [r4, #0x48]
	orr lr, lr, r5, lsl #20
	add r1, r1, r0, lsl #12
	ldr ip, [r4, #0x44]
	rsbne lr, lr, #0
	mov r3, r2
	add r0, ip, lr
	sub r1, r1, #0x100000
	bl EffectIceSparkles__Create
	ldr r2, _02169080 // =_mt_math_rand
	ldr r0, _02169084 // =0x00196225
	ldr r3, [r2]
	ldr r1, _02169088 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0xf
	str r1, [r2]
	add r0, r0, #8
	str r0, [r4, #0x28]
_02169070:
	ldr r0, [r4, #0x28]
	sub r0, r0, #1
	str r0, [r4, #0x28]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02169080: .word _mt_math_rand
_02169084: .word 0x00196225
_02169088: .word 0x3C6EF35F
	arm_func_end Icicle__State_Active

	arm_func_start Icicle__Draw
Icicle__Draw: // 0x0216908C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r1, #0x100000
	mov r4, r0
	rsb r1, r1, #0
	str r1, [r4, #0x54]
	ldr r1, [r4, #0x134]
	bl StageTask__Draw3D
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #1
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x134]
	bl StageTask__Draw3D
	ldr r1, [r4, #0x128]
	mov r0, r4
	bl StageTask__Draw2D
	ldr r1, [r4, #0x20]
	mov r0, r4
	bic r1, r1, #1
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x128]
	bl StageTask__Draw2D
	ldmia sp!, {r4, pc}
	arm_func_end Icicle__Draw

	arm_func_start Icicle__OnDefend
Icicle__OnDefend: // 0x021690EC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r1
	mov r8, r0
	ldr r4, [r7, #0x1c]
	ldr r5, [r8, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r0, [r5]
	cmp r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r4, #0x340]
	ldr r1, [r4, #0x48]
	ldrsb r2, [r0, #6]
	ldr r0, [r5, #0x48]
	sub r1, r1, #0x100000
	mov r2, r2, lsl #7
	add r2, r2, #0x100
	cmp r0, r1
	mov r6, r2, lsl #0xc
	movle r0, #0x44000
	ble _0216915C
	sub r0, r0, r1
	sub r1, r6, r0
	mov r0, #0x44
	mul r0, r1, r0
	mov r1, r6
	bl FX_Div
_0216915C:
	ldr r2, [r5, #0x44]
	ldr r1, [r4, #0x44]
	mov r0, r0, asr #1
	subs r1, r2, r1
	rsbmi r1, r1, #0
	add r0, r0, #0x6000
	cmp r1, r0
	ble _0216918C
	mov r0, r8
	mov r1, r7
	bl ObjRect__FuncNoHit
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0216918C:
	str r5, [r4, #0x35c]
	ldr r1, [r4, #0x18]
	mov r0, r5
	orr r3, r1, #2
	mov r1, r4
	mov r2, r6
	str r3, [r4, #0x18]
	bl Player__Gimmick_IcicleGrab
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end Icicle__OnDefend

	.data
	
aActAcGmkIcicle: // 0x02189338
	.asciz "/act/ac_gmk_icicle.bac"
	.align 4
	
aActAcGmkIcicle_0: // 0x02189350
	.asciz "/act/ac_gmk_icicle3d.bac"
	.align 4