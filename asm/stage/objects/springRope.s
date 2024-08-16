	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start SpringRope__Create
SpringRope__Create: // 0x02185B4C
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
	ldr r0, _02185D10 // =StageTask_Main
	ldr r1, _02185D14 // =GameObject__Destructor
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
	mov r0, #0x9f
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02185D18 // =gameArchiveStage
	ldr r1, _02185D1C // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02185D20 // =aActAcGmkRopeCB
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x69
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, #0xa0
	bl GetObjectFileWork
	str r0, [sp]
	ldr r1, _02185D18 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1]
	add r1, r4, #0x364
	str r2, [sp, #4]
	ldr r2, _02185D24 // =aModGmkRopeCNsb
	mov r3, #1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x20]
	ldr r0, _02185D28 // =0x000034CC
	orr r1, r1, #0x300
	str r1, [r4, #0x20]
	str r0, [r4, #0x37c]
	str r0, [r4, #0x380]
	str r0, [r4, #0x384]
	str r4, [r4, #0x234]
	ldrh r0, [r7, #4]
	mov r5, #0x48
	mov r2, #0x40
	tst r0, #1
	add r0, r4, #0x218
	beq _02185CA4
	mov r1, #0x84
	mov r3, #0x8c
	str r5, [sp]
	bl ObjRect__SetBox2D
	b _02185CB4
_02185CA4:
	sub r1, r5, #0xd0
	sub r3, r2, #0xc0
	str r5, [sp]
	bl ObjRect__SetBox2D
_02185CB4:
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _02185D2C // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x230]
	ldr r0, _02185D30 // =ovl00_2185F1C
	orr r1, r1, #0xc0
	str r1, [r4, #0x230]
	str r0, [r4, #0x23c]
	ldr r1, [r4, #0x1c]
	mov r0, r4
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl ovl00_2185F90
	ldr r1, _02185D34 // =ovl00_2185D38
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02185D10: .word StageTask_Main
_02185D14: .word GameObject__Destructor
_02185D18: .word gameArchiveStage
_02185D1C: .word 0x0000FFFF
_02185D20: .word aActAcGmkRopeCB
_02185D24: .word aModGmkRopeCNsb
_02185D28: .word 0x000034CC
_02185D2C: .word 0x0000FFFE
_02185D30: .word ovl00_2185F1C
_02185D34: .word ovl00_2185D38
	arm_func_end SpringRope__Create

	arm_func_start ovl00_2185D38
ovl00_2185D38: // 0x02185D38
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x4c
	mov r6, r0
	ldr r4, [r6, #0x35c]
	cmp r4, #0
	beq _02185E94
	ldr r0, [r4, #0x6d8]
	cmp r0, r6
	beq _02185D98
	ldr r0, [r6, #0x20]
	mov r3, #0
	orr r0, r0, #0x200
	str r0, [r6, #0x20]
	ldr r0, [r6, #0x18]
	mov r2, #1
	bic r0, r0, #2
	str r0, [r6, #0x18]
	str r3, [r6, #0x35c]
	ldr r0, [r6, #0x12c]
	str r3, [sp]
	ldr r1, [r0, #0x144]
	bl AnimatorMDL__SetResource
	add sp, sp, #0x4c
	ldmia sp!, {r3, r4, r5, r6, pc}
_02185D98:
	ldr r5, [r6, #0x12c]
	add r0, r5, #0x24
	bl MTX_Identity33_
	ldr r0, [r4, #0x28]
	ldr r2, _02185F0C // =FX_SinCosTable_
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0x28
	blx MTX_RotX33_
	add r0, r5, #0x24
	add r1, sp, #0x28
	mov r2, r0
	bl MTX_Concat33
	ldrh r1, [r4, #0x32]
	ldr r3, _02185F0C // =FX_SinCosTable_
	add r0, sp, #0x28
	sub r1, r1, #0x4000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	blx MTX_RotY33_
	add r0, r5, #0x24
	add r1, sp, #0x28
	mov r2, r0
	bl MTX_Concat33
	ldr r0, [r4, #0x2c]
	mov r1, #0xa0
	bl FX_DivS32
	ldr r1, _02185F10 // =0x000034CC
	add sp, sp, #0x4c
	mul r2, r0, r1
	str r1, [r5, #0x18]
	mov r0, r2, asr #0xc
	str r1, [r5, #0x1c]
	str r0, [r5, #0x20]
	ldrh r0, [r4, #0x32]
	cmp r0, #0x8000
	ldr r0, [r6, #0x354]
	orrlo r0, r0, #1
	strlo r0, [r6, #0x354]
	bichs r0, r0, #1
	strhs r0, [r6, #0x354]
	ldmia sp!, {r3, r4, r5, r6, pc}
_02185E94:
	ldr r4, [r6, #0x12c]
	ldr r1, [r6, #0x354]
	add r0, r4, #0x24
	bic r1, r1, #1
	str r1, [r6, #0x354]
	bl MTX_Identity33_
	ldr r2, _02185F14 // =0x02116550
	add r0, sp, #4
	ldrsh r1, [r2]
	ldrsh r2, [r2, #2]
	blx MTX_RotX33_
	add r0, r4, #0x24
	add r1, sp, #4
	mov r2, r0
	bl MTX_Concat33
	ldr r2, _02185F18 // =0x02113950
	add r0, sp, #4
	ldrsh r1, [r2]
	ldrsh r2, [r2, #2]
	blx MTX_RotY33_
	add r0, r4, #0x24
	add r1, sp, #4
	mov r2, r0
	bl MTX_Concat33
	ldr r0, _02185F10 // =0x000034CC
	str r0, [r4, #0x18]
	str r0, [r4, #0x1c]
	str r0, [r4, #0x20]
	add sp, sp, #0x4c
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02185F0C: .word FX_SinCosTable_
_02185F10: .word 0x000034CC
_02185F14: .word 0x02116550
_02185F18: .word 0x02113950
	arm_func_end ovl00_2185D38

	arm_func_start ovl00_2185F1C
ovl00_2185F1C: // 0x02185F1C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5]
	cmp r0, #1
	ldreq r0, [r4, #0x35c]
	cmpeq r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	str r5, [r4, #0x35c]
	ldr r0, [r4, #0x18]
	mov r2, #0
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x12c]
	mov r3, r2
	str r2, [sp]
	ldr r1, [r0, #0x144]
	bl AnimatorMDL__SetResource
	ldr r1, [r4, #0x20]
	mov r0, r5
	bic r3, r1, #0x200
	mov r1, r4
	mov r2, #0xa0000
	str r3, [r4, #0x20]
	bl Player__Action_SpringRope
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl00_2185F1C

	arm_func_start ovl00_2185F90
ovl00_2185F90: // 0x02185F90
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r0, [r4, #0x340]
	mov r3, #0
	ldrsb r1, [r0, #6]
	ldr r0, _02186044 // =0x0000014F
	stmia sp, {r1, r3}
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r1, [r4, #0x44]
	ldr r2, [r4, #0x48]
	bl GameObject__SpawnObject
	cmp r0, #0
	strne r4, [r0, #0x11c]
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r1, [r4, #0x44]
	ldr r0, [r4, #0x48]
	sub r1, r1, #0x90000
	add r2, r0, #0x40000
	mov r0, #0x150
	bl GameObject__SpawnObject
	cmp r0, #0
	strne r4, [r0, #0x11c]
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r2, [r4, #0x48]
	ldr r1, [r4, #0x44]
	ldr r0, _02186048 // =0x00000151
	add r2, r2, #0x18000
	bl GameObject__SpawnObject
	cmp r0, #0
	strne r4, [r0, #0x11c]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02186044: .word 0x0000014F
_02186048: .word 0x00000151
	arm_func_end ovl00_2185F90

	.data
	
aActAcGmkRopeCB: // 0x02189DD4
	.asciz "/act/ac_gmk_rope_c.bac"
	.align 4
	
aModGmkRopeCNsb: // 0x02189DEC
	.asciz "/mod/gmk_rope_c.nsbmd"
	.align 4