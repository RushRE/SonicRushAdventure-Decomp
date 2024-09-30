	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start AnchorRope__Create
AnchorRope__Create: // 0x0217690C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	ldr r3, _02176BD0 // =0x000010F6
	str r0, [sp, #0xc]
	str r3, [sp]
	mov r0, #2
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _02176BD4 // =0x0000076C
	ldr r0, _02176BD8 // =StageTask_Main
	ldr r1, _02176BDC // =AnchorRope__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r4
	bl GetTaskWork_
	ldr r2, _02176BD4 // =0x0000076C
	mov r1, #0
	mov r7, r0
	bl MI_CpuFill8
	ldr r1, [sp, #0xc]
	mov r0, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r7, #0x1c]
	mov r0, #0x9f
	orr r1, r1, #0x2100
	str r1, [r7, #0x1c]
	ldr r1, [r7, #0x20]
	orr r1, r1, #0x300
	str r1, [r7, #0x20]
	bl GetObjectFileWork
	ldr r2, _02176BE0 // =gameArchiveStage
	ldr r1, _02176BE4 // =aModGmkAnchorRo
	ldr r2, [r2, #0]
	bl ObjDataLoad
	mov r8, #0
	ldr r5, _02176BE8 // =0x021897E8
	ldr r4, _02176BEC // =0x000034CC
	ldr r11, _02176BF0 // =_021897E4
	str r0, [r7, #0x364]
	add r9, r7, #0x368
	add r10, r7, #0x5f0
	mov r6, r8
_021769E4:
	mov r0, r9
	mov r1, #0
	bl AnimatorMDL__Init
	str r6, [sp]
	mov r2, r8, lsl #1
	ldrh r2, [r5, r2]
	ldr r1, [r7, #0x364]
	mov r0, r9
	mov r3, r6
	bl AnimatorMDL__SetResource
	str r4, [r9, #0x18]
	str r4, [r9, #0x1c]
	mov r0, #0xa0
	str r4, [r9, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02176BE0 // =gameArchiveStage
	mov r2, r8, lsl #1
	ldr r1, [r0, #0]
	mov r0, r10
	str r1, [sp]
	ldrh r2, [r11, r2]
	ldr r1, _02176BF4 // =aActAcGmkAnchor
	bl ObjAction2dBACLoad
	mov r0, #0xa0
	bl GetObjectFileWork
	mov r1, r8, lsl #0x10
	ldr r2, _02176BF8 // =0x021897EC
	mov r3, r8, lsl #1
	ldrsh r2, [r2, r3]
	ldr r0, [r0, #0]
	mov r1, r1, lsr #0x10
	bl ObjDrawAllocSpritePalette
	strh r0, [r10, #0x50]
	ldrh r2, [r10, #0x50]
	mov r1, r8, lsl #0x10
	mov r0, r10
	strh r2, [r10, #0x92]
	strh r2, [r10, #0x90]
	ldr r2, [r10, #0x64]
	mov r1, r1, lsr #0x10
	orr r2, r2, #1
	str r2, [r10, #0x64]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r10
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r10
	mov r1, #2
	bl StageTask__SetOAMPriority
	add r8, r8, #1
	add r9, r9, #0x144
	add r10, r10, #0xa4
	cmp r8, #2
	blt _021769E4
	mov r1, #0
	mov r2, r1
	add r0, r7, #0x218
	str r7, [r7, #0x234]
	bl ObjRect__SetAttackStat
	ldr r1, _02176BFC // =0x0000FFFE
	add r0, r7, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02176C00 // =AnchorRope__OnDefend
	mov r4, #0x48
	str r0, [r7, #0x23c]
	ldr r0, [r7, #0x230]
	mov r2, #0x20
	orr r0, r0, #0x400
	str r0, [r7, #0x230]
	ldr r0, [sp, #0xc]
	ldrh r0, [r0, #2]
	cmp r0, #0xc5
	add r0, r7, #0x218
	bne _02176B38
	sub r1, r4, #0x108
	sub r3, r2, #0xb8
	str r4, [sp]
	bl ObjRect__SetBox2D
	add r0, r7, #0x700
	mov r1, #0xe000
	strh r1, [r0, #0x44]
	mov r2, #0xc000
	b _02176B58
_02176B38:
	mov r1, #0x98
	mov r3, #0xc0
	str r4, [sp]
	bl ObjRect__SetBox2D
	add r0, r7, #0x700
	mov r1, #0xe000
	strh r1, [r0, #0x44]
	mov r2, #0x4000
_02176B58:
	strh r2, [r0, #0x46]
	mov r1, #0x800
	strh r1, [r0, #0x4a]
	strh r2, [r0, #0x4c]
	mov r0, #0x90000
	str r0, [r7, #0x750]
	add r0, r7, #0x700
	ldrh r1, [r0, #0x44]
	strh r1, [r0, #0x5c]
	ldrh r1, [r0, #0x46]
	strh r1, [r0, #0x5e]
	ldrh r1, [r0, #0x4a]
	strh r1, [r0, #0x62]
	ldrh r1, [r0, #0x4c]
	strh r1, [r0, #0x64]
	ldr r0, [sp, #0xc]
	ldrh r0, [r0, #4]
	tst r0, #1
	movne r0, #0x20000
	moveq r0, #0x28000
	str r0, [r7, #0x768]
	mov r0, r7
	bl AnchorRope__Func_2177274
	ldr r0, _02176C04 // =AnchorRope__Draw
	str r0, [r7, #0xfc]
	bl AllocSndHandle
	str r0, [r7, #0x138]
	mov r0, r7
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02176BD0: .word 0x000010F6
_02176BD4: .word 0x0000076C
_02176BD8: .word StageTask_Main
_02176BDC: .word AnchorRope__Destructor
_02176BE0: .word gameArchiveStage
_02176BE4: .word aModGmkAnchorRo
_02176BE8: .word 0x021897E8
_02176BEC: .word 0x000034CC
_02176BF0: .word _021897E4
_02176BF4: .word aActAcGmkAnchor
_02176BF8: .word 0x021897EC
_02176BFC: .word 0x0000FFFE
_02176C00: .word AnchorRope__OnDefend
_02176C04: .word AnchorRope__Draw
	arm_func_end AnchorRope__Create

	arm_func_start AnchorRope__Destructor
AnchorRope__Destructor: // 0x02176C08
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r8, r0
	bl GetTaskWork_
	mov r6, r0
	add r5, r6, #0x368
	add r7, r6, #0x5f0
	mov r4, #0
	mov r9, #0xa0
_02176C28:
	mov r0, r5
	bl AnimatorMDL__Release
	add r0, r6, #0x600
	ldrh r0, [r0, #0x40]
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	mov r0, r9
	bl GetObjectFileWork
	mov r1, r7
	bl ObjAction2dBACRelease
	add r4, r4, #1
	cmp r4, #2
	add r5, r5, #0x144
	add r6, r6, #0xa4
	add r7, r7, #0xa4
	blt _02176C28
	mov r0, #0x9f
	bl GetObjectFileWork
	bl ObjDataRelease
	mov r0, r8
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end AnchorRope__Destructor

	arm_func_start AnchorRope__State_2176C80
AnchorRope__State_2176C80: // 0x02176C80
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	beq _02176CA0
	ldrne r0, [r0, #0x6d8]
	cmpne r0, r4
	beq _02176CBC
_02176CA0:
	mov r0, #0
	str r0, [r4, #0x35c]
	ldr r1, _02176E14 // =AnchorRope__State_2176E1C
	mov r0, r4
	str r1, [r4, #0xf4]
	bl AnchorRope__State_2176E1C
	ldmia sp!, {r4, pc}
_02176CBC:
	add r0, r4, #0x700
	ldrsh r0, [r0, #0x54]
	mov r1, #0x400
	rsb r1, r1, #0
	mov r2, #0x780
	bl ObjSpdUpSet
	add r1, r4, #0x700
	strh r0, [r1, #0x54]
	ldrsh r2, [r1, #0x54]
	ldr r1, [r4, #0x758]
	add r0, r4, #0x700
	cmp r2, #0
	rsblt r2, r2, #0
	add r1, r1, r2
	str r1, [r4, #0x758]
	ldrh r0, [r0, #0x44]
	mov r1, #0xc000
	mov r2, #0x100
	bl ObjRoopMove16
	add r1, r4, #0x700
	strh r0, [r1, #0x44]
	ldrh r0, [r1, #0x4a]
	mov r1, #0
	mov r2, #0x40
	bl ObjRoopMove16
	add r1, r4, #0x700
	strh r0, [r1, #0x4a]
	ldrh r2, [r1, #0x46]
	ldrsh r0, [r1, #0x54]
	add r0, r2, r0
	strh r0, [r1, #0x46]
	ldrh r2, [r1, #0x4c]
	ldrsh r0, [r1, #0x54]
	add r0, r2, r0
	strh r0, [r1, #0x4c]
	ldr r0, [r4, #0x750]
	sub r0, r0, #0x1500
	str r0, [r4, #0x750]
	cmp r0, #0x2a000
	movlt r0, #0x2a000
	strlt r0, [r4, #0x750]
	ldr r1, [r4, #0x758]
	ldr r0, [r4, #0x768]
	cmp r1, r0
	blo _02176DD0
	mov r0, #0
	str r0, [r4, #0x35c]
	ldr r1, [r4, #0x24]
	mov r0, #0x4000
	orr r1, r1, #1
	str r1, [r4, #0x24]
	str r0, [r4, #0x98]
	ldr r0, [r4, #0x340]
	mov r1, #0x4000
	ldrh r0, [r0, #2]
	rsb r1, r1, #0
	cmp r0, #0xd0
	ldreq r0, [r4, #0x98]
	rsbeq r0, r0, #0
	streq r0, [r4, #0x98]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #4]
	tst r0, #1
	ldrne r0, [r4, #0x98]
	rsbne r0, r0, #0
	strne r0, [r4, #0x98]
	ldr r0, _02176E14 // =AnchorRope__State_2176E1C
	str r1, [r4, #0x9c]
	str r0, [r4, #0xf4]
_02176DD0:
	mov r0, r4
	bl AnchorRope__Func_2177274
	ldr r0, [r4, #0x750]
	mov r1, #0x90000
	bl FX_Div
	ldr r1, _02176E18 // =0x000034CC
	mov r2, #0
	umull ip, r3, r0, r1
	adds ip, ip, #0x800
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x4cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02176E14: .word AnchorRope__State_2176E1C
_02176E18: .word 0x000034CC
	arm_func_end AnchorRope__State_2176C80

	arm_func_start AnchorRope__State_2176E1C
AnchorRope__State_2176E1C: // 0x02176E1C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	add r1, r4, #0x700
	ldrh r0, [r1, #0x44]
	ldrh r1, [r1, #0x5c]
	mov r2, #0x100
	bl ObjRoopMove16
	add r1, r4, #0x700
	strh r0, [r1, #0x44]
	ldrh r0, [r1, #0x4a]
	ldrh r1, [r1, #0x62]
	mov r2, #0x40
	bl ObjRoopMove16
	add r2, r4, #0x700
	strh r0, [r2, #0x4a]
	ldrh r0, [r2, #0x46]
	ldrh r1, [r2, #0x5e]
	ldrsh r2, [r2, #0x54]
	bl AkMath__Func_2002D28
	add r2, r4, #0x700
	strh r0, [r2, #0x46]
	ldrh r0, [r2, #0x4c]
	ldrh r1, [r2, #0x64]
	ldrsh r2, [r2, #0x54]
	bl AkMath__Func_2002D28
	add r1, r4, #0x700
	strh r0, [r1, #0x4c]
	ldr r0, [r4, #0x750]
	mov r1, #0x90000
	add r0, r0, #0x2a00
	str r0, [r4, #0x750]
	cmp r0, #0x90000
	movgt r0, #0x90000
	strgt r0, [r4, #0x750]
	ldr r0, [r4, #0x750]
	bl FX_Div
	ldr r1, _02176F68 // =0x000034CC
	mov r3, #0
	umull ip, r2, r0, r1
	mla r2, r0, r3, r2
	mov r0, r0, asr #0x1f
	mla r2, r0, r1, r2
	adds ip, ip, #0x800
	adc r0, r2, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x4cc]
	add r0, r4, #0x700
	ldrh r2, [r0, #0x44]
	ldrh r1, [r0, #0x5c]
	cmp r2, r1
	ldreqh r2, [r0, #0x4a]
	ldreqh r1, [r0, #0x62]
	cmpeq r2, r1
	ldreqh r2, [r0, #0x46]
	ldreqh r1, [r0, #0x5e]
	cmpeq r2, r1
	ldreqh r1, [r0, #0x4c]
	ldreqh r0, [r0, #0x64]
	cmpeq r1, r0
	bne _02176F58
	mov r0, #0x90000
	str r0, [r4, #0x750]
	str r3, [r4, #0xf4]
	ldr r1, [r4, #0x18]
	add r0, r4, #0xac
	bic r1, r1, #2
	str r1, [r4, #0x18]
	str r3, [sp]
	ldr r1, [r4, #0x364]
	add r0, r0, #0x400
	mov r2, #2
	bl AnimatorMDL__SetResource
	ldr r1, [r4, #0x20]
	ldr r0, _02176F68 // =0x000034CC
	orr r1, r1, #0x200
	str r1, [r4, #0x20]
	str r0, [r4, #0x4cc]
_02176F58:
	mov r0, r4
	bl AnchorRope__Func_2177274
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02176F68: .word 0x000034CC
	arm_func_end AnchorRope__State_2176E1C

	arm_func_start AnchorRope__Draw
AnchorRope__Draw: // 0x02176F6C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x48
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x20]
	add r3, sp, #0x18
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0xd0
	orreq r0, r1, #1
	streq r0, [sp, #0x10]
	add r0, r4, #0x338
	add r0, r0, #0x400
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r4, #0x38c
	bl MTX_Identity33_
	add r0, r4, #0x700
	ldrh r1, [r0, #0x44]
	ldr r3, _021771C4 // =FX_SinCosTable_
	add r0, sp, #0x24
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r5, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r5]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	add r0, r4, #0x38c
	add r1, sp, #0x24
	mov r2, r0
	bl MTX_Concat33
	add r0, r4, #0x700
	ldrh r1, [r0, #0x46]
	ldr r3, _021771C4 // =FX_SinCosTable_
	add r0, sp, #0x24
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
	bl MTX_RotY33_
	add r0, r4, #0x38c
	add r1, sp, #0x24
	mov r2, r0
	bl MTX_Concat33
	add r2, r4, #0x344
	add r0, sp, #0x14
	mov r3, #0
	stmia sp, {r0, r3}
	str r3, [sp, #8]
	add r0, r4, #0x368
	add r1, sp, #0x18
	add r2, r2, #0x400
	str r3, [sp, #0xc]
	bl StageTask__Draw3DEx
	mov r2, #0
	add r0, sp, #0x10
	stmia sp, {r0, r2}
	add r0, r4, #0x5f0
	add r1, sp, #0x18
	mov r3, r2
	str r2, [sp, #8]
	bl StageTask__Draw2DEx
	add r0, r4, #0xac
	add r5, r0, #0x400
	add r0, r4, #0x44
	add r3, sp, #0x18
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r5, #0x24
	bl MTX_Identity33_
	add r0, r4, #0x700
	ldrh r1, [r0, #0x4a]
	ldr r3, _021771C4 // =FX_SinCosTable_
	add r0, sp, #0x24
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
	bl MTX_RotX33_
	add r0, r5, #0x24
	add r1, sp, #0x24
	mov r2, r0
	bl MTX_Concat33
	add r0, r4, #0x700
	ldrh r1, [r0, #0x4c]
	ldr r3, _021771C4 // =FX_SinCosTable_
	add r0, sp, #0x24
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r2, r1, #1
	mov r1, r1, lsl #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, r5, #0x24
	add r1, sp, #0x24
	mov r2, r0
	bl MTX_Concat33
	add r2, r4, #0x4a
	add r1, sp, #0x14
	mov r3, #0
	stmia sp, {r1, r3}
	str r3, [sp, #8]
	mov r0, r5
	add r1, sp, #0x18
	add r2, r2, #0x700
	str r3, [sp, #0xc]
	bl StageTask__Draw3DEx
	mov r2, #0
	add r1, sp, #0x10
	stmia sp, {r1, r2}
	add r0, r4, #0x294
	add r0, r0, #0x400
	add r1, sp, #0x18
	mov r3, r2
	str r2, [sp, #8]
	bl StageTask__Draw2DEx
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021771C4: .word FX_SinCosTable_
	arm_func_end AnchorRope__Draw

	arm_func_start AnchorRope__OnDefend
AnchorRope__OnDefend: // 0x021771C8
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x35c]
	cmp r0, r5
	ldmeqia sp!, {r3, r4, r5, pc}
	str r5, [r4, #0x35c]
	ldr r0, [r4, #0x18]
	mov r1, #0x400
	orr r0, r0, #2
	str r0, [r4, #0x18]
	mov r0, #0x90000
	str r0, [r4, #0x750]
	rsb r1, r1, #0
	add r0, r4, #0x700
	strh r1, [r0, #0x54]
	mov r3, #0
	str r3, [r4, #0x758]
	str r3, [r4, #0x24]
	str r3, [sp]
	add r0, r4, #0xac
	ldr r1, [r4, #0x364]
	add r0, r0, #0x400
	mov r2, #1
	bl AnimatorMDL__SetResource
	ldr r1, [r4, #0x20]
	mov r0, r4
	bic r1, r1, #0x200
	str r1, [r4, #0x20]
	bl AnchorRope__Func_2177274
	ldr r2, _02177270 // =AnchorRope__State_2176C80
	mov r0, r5
	mov r1, r4
	str r2, [r4, #0xf4]
	bl Player__Func_2021B84
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02177270: .word AnchorRope__State_2176C80
	arm_func_end AnchorRope__OnDefend

	arm_func_start AnchorRope__Func_2177274
AnchorRope__Func_2177274: // 0x02177274
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x54
	mov r4, r0
	add r0, sp, #0x30
	bl MTX_Identity33_
	add r0, r4, #0x700
	ldrh r1, [r0, #0x4a]
	ldr r3, _02177484 // =FX_SinCosTable_
	add r0, sp, #0xc
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	add r0, sp, #0x30
	add r1, sp, #0xc
	mov r2, r0
	bl MTX_Concat33
	add r0, r4, #0x700
	ldrh r1, [r0, #0x4c]
	ldr r3, _02177484 // =FX_SinCosTable_
	add r0, sp, #0xc
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
	bl MTX_RotY33_
	add r0, sp, #0x30
	add r1, sp, #0xc
	mov r2, r0
	bl MTX_Concat33
	ldr r1, [r4, #0x750]
	mov r0, #0
	rsb r1, r1, #0
	str r1, [sp, #8]
	str r0, [sp]
	str r0, [sp, #4]
	add r0, sp, #0
	add r1, sp, #0x30
	mov r2, r0
	bl MTX_MultVec33
	ldr r2, [r4, #0x4c]
	ldr r0, [sp, #8]
	ldr r1, [r4, #0x48]
	add ip, r2, r0
	ldr r0, [sp, #4]
	ldr r2, [r4, #0x44]
	add r3, r1, r0
	ldr r1, [sp]
	add r0, sp, #0x30
	add r1, r2, r1
	str r1, [r4, #0x738]
	str r3, [r4, #0x73c]
	str ip, [r4, #0x740]
	bl MTX_Identity33_
	add r0, r4, #0x700
	ldrh r1, [r0, #0x44]
	ldr r3, _02177484 // =FX_SinCosTable_
	add r0, sp, #0xc
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	add r0, sp, #0x30
	add r1, sp, #0xc
	mov r2, r0
	bl MTX_Concat33
	add r0, r4, #0x700
	ldrh r1, [r0, #0x46]
	ldr r3, _02177484 // =FX_SinCosTable_
	add r0, sp, #0xc
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
	bl MTX_RotY33_
	add r0, sp, #0x30
	add r1, sp, #0xc
	mov r2, r0
	bl MTX_Concat33
	mov r3, #0
	mov r2, #0x3c000
	add r0, sp, #0
	str r2, [sp, #4]
	add r1, sp, #0x30
	mov r2, r0
	str r3, [sp]
	str r3, [sp, #8]
	bl MTX_MultVec33
	ldr ip, [r4, #0x740]
	ldr r2, [sp, #8]
	ldr r1, [r4, #0x738]
	ldr r0, [sp]
	add ip, ip, r2
	add r1, r1, r0
	ldr r3, [r4, #0x73c]
	ldr r2, [sp, #4]
	mov r0, #0xc000
	add r2, r3, r2
	str r1, [r4, #0x8c]
	str r2, [r4, #0x90]
	str ip, [r4, #0x94]
	strh r0, [r4, #0x30]
	add r0, r4, #0x700
	ldrh r0, [r0, #0x46]
	sub r0, r0, #0x4000
	strh r0, [r4, #0x32]
	add sp, sp, #0x54
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02177484: .word FX_SinCosTable_
	arm_func_end AnchorRope__Func_2177274

	.data
	
_021897E4:
	.byte 0x1C, 0x00, 0x10, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x48, 0x00

aModGmkAnchorRo: // 0x021897F0
	.asciz "/mod/gmk_anchor_rope.nsbmd"
	.align 4
	
aActAcGmkAnchor: // 0x0218980C
	.asciz "/act/ac_gmk_anchor_rope.bac"
	.align 4