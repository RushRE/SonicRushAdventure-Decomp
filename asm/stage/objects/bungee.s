	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Bungee__Create
Bungee__Create: // 0x02185768
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
	ldr r0, _021858DC // =StageTask_Main
	ldr r1, _021858E0 // =GameObject__Destructor
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
	mov r0, #0xa3
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _021858E4 // =gameArchiveStage
	mov r1, #1
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _021858E8 // =aActAcGmkBungee
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x6a
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	ldr r1, _021858EC // =ovl00_21859C0
	add r0, r4, #0x218
	str r1, [r4, #0xfc]
	str r4, [r4, #0x234]
	ldrsb r2, [r7, #7]
	ldrsb r1, [r7, #6]
	ldrb r3, [r7, #9]
	add r3, r2, r3
	mov r3, r3, lsl #0x10
	mov r3, r3, asr #0x10
	str r3, [sp]
	ldrb r3, [r7, #8]
	add r3, r1, r3
	mov r3, r3, lsl #0x10
	mov r3, r3, asr #0x10
	bl ObjRect__SetBox2D
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, _021858F0 // =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x230]
	ldr r0, _021858F4 // =ovl00_2185934
	orr r1, r1, #0xc0
	str r1, [r4, #0x230]
	str r0, [r4, #0x23c]
	ldr r1, [r4, #0x1c]
	ldr r0, _021858F8 // =ovl00_21858FC
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	str r0, [r4, #0xf4]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021858DC: .word StageTask_Main
_021858E0: .word GameObject__Destructor
_021858E4: .word gameArchiveStage
_021858E8: .word aActAcGmkBungee
_021858EC: .word ovl00_21859C0
_021858F0: .word 0x0000FFFE
_021858F4: .word ovl00_2185934
_021858F8: .word ovl00_21858FC
	arm_func_end Bungee__Create

	arm_func_start ovl00_21858FC
ovl00_21858FC: // 0x021858FC
	ldr r2, [r0, #0x35c]
	cmp r2, #0
	bxeq lr
	ldr r1, [r2, #0x6d8]
	cmp r1, r0
	ldreq r1, [r2, #0x2c]
	streq r1, [r0, #0x2c]
	bxeq lr
	ldr r2, [r0, #0x18]
	mov r1, #0
	bic r2, r2, #2
	str r2, [r0, #0x18]
	str r1, [r0, #0x35c]
	bx lr
	arm_func_end ovl00_21858FC

	arm_func_start ovl00_2185934
ovl00_2185934: // 0x02185934
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	ldreqh r0, [r5]
	cmpeq r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, [r5, #0x1c]
	tst r0, #0x10
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, [r5, #0xc8]
	ldr r0, [r5, #0x648]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r1, r0
	ldmltia sp!, {r4, r5, r6, pc}
	str r5, [r4, #0x35c]
	ldr r1, [r4, #0x18]
	add r0, r4, #0x218
	orr r1, r1, #2
	str r1, [r4, #0x18]
	bl ObjRect__CenterX
	mov r6, r0
	add r0, r4, #0x218
	bl ObjRect__CenterY
	mov r3, r0
	mov r0, r5
	mov r1, r4
	mov r2, r6
	bl Player__Gimmick_Bungee
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl00_2185934

	arm_func_start ovl00_21859C0
ovl00_21859C0: // 0x021859C0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x60
	bl GetCurrentTaskWork_
	mov r7, r0
	ldr r0, [r7, #0x35c]
	cmp r0, #0
	beq _02185AC4
	ldrh r1, [r0, #0x34]
	mov r0, #0
	add r2, sp, #0x10
	str r1, [sp]
	add r3, sp, #0xc
	sub r1, r0, #0xe000
	bl AkMath__Func_2002C98
	ldr r2, [r7, #0x35c]
	ldr r1, [r7, #0x44]
	ldr r0, [sp, #0x10]
	ldr r2, [r2, #0x44]
	add r0, r1, r0
	sub r0, r2, r0
	mov r1, #8
	bl FX_DivS32
	ldr r3, [r7, #0x35c]
	ldr r2, [r7, #0x48]
	ldr r1, [sp, #0xc]
	ldr r3, [r3, #0x48]
	add r1, r2, r1
	mov r4, r0
	sub r0, r3, r1
	mov r1, #8
	bl FX_DivS32
	ldr r8, [r7, #0x44]
	ldr sb, [r7, #0x48]
	mov r6, #0
	add r5, sp, #0x14
_02185A4C:
	mla r2, r4, r6, r8
	mla r3, r0, r6, sb
	add r1, r6, #1
	str r2, [r5, r6, lsl #3]
	add r2, r5, r6, lsl #3
	and r6, r1, #0xff
	str r3, [r2, #4]
	cmp r6, #8
	blo _02185A4C
	ldr r5, [r7, #0x2c]
	cmp r5, #0
	beq _02185ABC
	mov r6, #1
	add r2, sp, #0x14
_02185A84:
	add r0, r6, r5, lsl #1
	and r1, r0, #7
	ldr r0, [r2, r6, lsl #3]
	sub r4, r1, #4
	add r0, r0, r4, lsl #12
	str r0, [r2, r6, lsl #3]
	add r3, r2, r6, lsl #3
	ldr r1, [r3, #4]
	add r0, r6, #1
	add r1, r1, r4, lsl #12
	and r6, r0, #0xff
	str r1, [r3, #4]
	cmp r6, #8
	blo _02185A84
_02185ABC:
	mov sb, #8
	b _02185AD8
_02185AC4:
	ldr r0, [r7, #0x44]
	mov sb, #1
	str r0, [sp, #0x14]
	ldr r0, [r7, #0x48]
	str r0, [sp, #0x18]
_02185AD8:
	ldr r8, [r7, #0x128]
	mov sl, #0
	str sl, [sp, #0x5c]
	cmp sb, #0
	addls sp, sp, #0x60
	ldmlsia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	add r5, r7, #0x20
	add r6, sp, #0x14
	mov r4, sl
	add fp, sp, #0x54
_02185B00:
	add r0, r6, sl, lsl #3
	ldr r1, [r6, sl, lsl #3]
	ldr r0, [r0, #4]
	str r1, [sp, #0x54]
	str r0, [sp, #0x58]
	str r5, [sp]
	str r4, [sp, #4]
	mov r0, r8
	mov r1, fp
	mov r2, r4
	add r3, r7, #0x38
	str r4, [sp, #8]
	bl StageTask__Draw2DEx
	add r0, sl, #1
	and sl, r0, #0xff
	cmp sl, sb
	blo _02185B00
	add sp, sp, #0x60
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end ovl00_21859C0

	.data
	
aActAcGmkBungee: // 0x02189DBC
	.asciz "/act/ac_gmk_bungee.bac"
	.align 4