	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start EnemyProtJet__Create
EnemyProtJet__Create: // 0x02156190
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r7, r0
	mov r6, r1
	mov r5, r2
	beq _021561BC
	ldrb r0, [r7]
	cmp r0, #0xff
	ldreqb r0, [r7, #1]
	cmpeq r0, #0xff
	beq _021561E0
_021561BC:
	ldr r0, _0215636C // =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _021561E0
	ldrh r0, [r7, #4]
	tst r0, #0x80
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
_021561E0:
	mov r0, #0x1500
	mov r2, #0
	str r0, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x394
	ldr r0, _02156370 // =StageTask_Main
	ldr r1, _02156374 // =GameObject__Destructor
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
	mov r2, #0x394
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x100
	str r1, [r4, #0x1c]
	bl ovl00_215638C
	ldrh r0, [r7, #4]
	ands r0, r0, #3
	beq _021562B0
	cmp r0, #1
	bne _021562F0
	add r0, r4, #0x300
	mov r2, #0
	ldr r1, _02156378 // =ovl00_21563B4
	strh r2, [r0, #0x78]
	str r1, [r4, #0x364]
	strh r2, [r0, #0x7c]
	strh r2, [r0, #0x7e]
	mov r1, #0x400
	strh r1, [r0, #0x80]
	b _021562F0
_021562B0:
	add r0, r4, #0x300
	mov r2, #1
	ldr r1, _0215637C // =ovl00_21563E4
	strh r2, [r0, #0x78]
	str r1, [r4, #0x364]
	strh r2, [r0, #0x7c]
	mov r1, #2
	strh r1, [r0, #0x7e]
	mov r0, #0x1000
	str r0, [r4, #0x384]
	mov r0, #0x2000
	str r0, [r4, #0x388]
	mov r0, #0x5000
	str r0, [r4, #0x38c]
	mov r0, #0x14000
	str r0, [r4, #0x390]
_021562F0:
	mov r0, #8
	bl GetObjectFileWork
	ldr r1, _02156380 // =gameArchiveStage
	ldr r2, _02156384 // =0x0000FFFF
	ldr r3, [r1]
	ldr r1, _02156388 // =_02188BE8
	str r3, [sp]
	str r2, [sp, #4]
	mov r3, r0
	ldr r2, [r1]
	mov r0, r4
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x28
	bl ObjActionAllocSpritePalette
	mov r0, r4
	ldr r1, [r4, #0x364]
	blx r1
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215636C: .word gameState
_02156370: .word StageTask_Main
_02156374: .word GameObject__Destructor
_02156378: .word ovl00_21563B4
_0215637C: .word ovl00_21563E4
_02156380: .word gameArchiveStage
_02156384: .word 0x0000FFFF
_02156388: .word _02188BE8
	arm_func_end EnemyProtJet__Create

	arm_func_start ovl00_215638C
ovl00_215638C: // 0x0215638C
	ldr r1, [r0, #0x340]
	ldr r2, [r0, #0x48]
	ldrsb r1, [r1, #7]
	add r2, r2, r1, lsl #12
	str r2, [r0, #0x36c]
	ldr r1, [r0, #0x340]
	ldrb r1, [r1, #9]
	add r1, r2, r1, lsl #12
	str r1, [r0, #0x374]
	bx lr
	arm_func_end ovl00_215638C

	arm_func_start ovl00_21563B4
ovl00_21563B4: // 0x021563B4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r1, [r1, #0x7c]
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _021563E0 // =ovl00_2156428
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021563E0: .word ovl00_2156428
	arm_func_end ovl00_21563B4

	arm_func_start ovl00_21563E4
ovl00_21563E4: // 0x021563E4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r1, [r1, #0x7c]
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x20]
	mov r1, #2
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldr r2, [r4, #0x384]
	ldr r0, _02156424 // =ovl00_2156468
	rsb r2, r2, #0
	str r2, [r4, #0x9c]
	str r1, [r4, #0x28]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156424: .word ovl00_2156468
	arm_func_end ovl00_21563E4

	arm_func_start ovl00_2156428
ovl00_2156428: // 0x02156428
	add r1, r0, #0x300
	ldrh r3, [r1, #0x7e]
	ldr r2, _02156464 // =FX_SinCosTable_
	mov r3, r3, asr #4
	mov r3, r3, lsl #1
	add r3, r3, #1
	mov r3, r3, lsl #1
	ldrsh r2, [r2, r3]
	mov r2, r2, asr #2
	str r2, [r0, #0x9c]
	ldrh r2, [r1, #0x7e]
	ldrh r0, [r1, #0x80]
	add r0, r2, r0
	strh r0, [r1, #0x7e]
	bx lr
	.align 2, 0
_02156464: .word FX_SinCosTable_
	arm_func_end ovl00_2156428

	arm_func_start ovl00_2156468
ovl00_2156468: // 0x02156468
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x28]
	cmp r1, #2
	bne _0215650C
	ldr r3, [r4, #0x36c]
	ldr r2, [r4, #0x48]
	cmp r2, r3
	movlt r0, #1
	strlt r0, [r4, #0x28]
	blt _021565BC
	ldr r1, [r4, #0x38c]
	sub r2, r2, r3
	cmp r2, r1
	bge _021564F4
	ldr r2, [r4, #0x128]
	add r1, r4, #0x300
	ldrh r1, [r1, #0x7e]
	ldrh r2, [r2, #0xc]
	cmp r2, r1
	beq _021564D0
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
_021564D0:
	ldr r0, [r4, #0x9c]
	mov r1, #0x80
	bl ObjSpdDownSet
	mov r1, #0x400
	rsb r1, r1, #0
	str r0, [r4, #0x9c]
	cmp r0, r1
	strgt r1, [r4, #0x9c]
	b _021565BC
_021564F4:
	ldr r0, [r4, #0x9c]
	ldr r2, [r4, #0x384]
	mvn r1, #0xff
	bl ObjSpdUpSet
	str r0, [r4, #0x9c]
	b _021565BC
_0215650C:
	cmp r1, #1
	bne _021565BC
	ldr r3, [r4, #0x374]
	ldr r2, [r4, #0x48]
	cmp r2, r3
	movgt r0, #2
	strgt r0, [r4, #0x28]
	bgt _021565BC
	ldr r1, [r4, #0x390]
	sub r2, r3, r2
	cmp r2, r1
	bge _021565A8
	ldr r2, [r4, #0x128]
	add r1, r4, #0x300
	ldrh r1, [r1, #0x7c]
	ldrh r2, [r2, #0xc]
	cmp r2, r1
	beq _02156588
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, #0x82
	orr r2, r1, #4
	sub r1, r0, #0x83
	str r2, [r4, #0x20]
	mov r2, #0
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02156588:
	ldr r0, [r4, #0x9c]
	mov r1, #0x220
	bl ObjSpdDownSet
	str r0, [r4, #0x9c]
	cmp r0, #0x400
	movlt r0, #0x400
	strlt r0, [r4, #0x9c]
	b _021565BC
_021565A8:
	ldr r0, [r4, #0x9c]
	ldr r2, [r4, #0x388]
	mov r1, #0x80
	bl ObjSpdUpSet
	str r0, [r4, #0x9c]
_021565BC:
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl00_2156468

	.data
	
_02188BE8:
	.word aActAcEneProtJe

aActAcEneProtJe: // 0x02188BEC
	.asciz "/act/ac_ene_prot_jet.bac"
	.align 4