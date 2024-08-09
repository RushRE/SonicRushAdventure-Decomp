	.include "asm/macros.inc"
	.include "global.inc"

	.bss

Platform__activeCount: // 0x0218A388
	.space 0x02
	.align 4

Platform__value_218A48C: // 0x0218A38C
	.space 0x04
	
	.text

	arm_func_start Platform__Create
Platform__Create: // 0x02175298
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r8, r0
	ldrh r0, [r8, #2]
	mov r7, r1
	mov r6, r2
	cmp r0, #0xbe
	cmpne r0, #0xbf
	ldr r0, _021755FC // =0x000010F6
	mov r5, #0x364
	str r0, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	moveq r5, #0x3f4
	ldr r0, _02175600 // =StageTask_Main
	ldr r1, _02175604 // =Platform__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r2, r5
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	ldr r0, _02175608 // =0x00000149
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x18]
	orr r1, r1, #2
	str r1, [r4, #0x18]
	ldrh r1, [r8, #2]
	cmp r1, r0
	moveq r5, #6
	beq _02175374
	cmp r1, #0xbe
	moveq r5, #3
	beq _02175374
	cmp r1, #0x14c
	moveq r5, #5
	subne r5, r1, #0xbb
_02175374:
	ldrh r0, [r8, #2]
	mov r6, #0
	cmp r0, #0xbf
	bne _021753B4
	mov r0, #0x4a
	bl GetObjectFileWork
	ldr r1, _0217560C // =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, _02175610 // =aActAcGmkLandBa
	str r1, [sp]
	mov r0, r4
	add r1, r4, #0x168
	str r6, [sp, #4]
	bl ObjObjectAction2dBACLoad
	b _021753E0
_021753B4:
	mov r0, #0x49
	bl GetObjectFileWork
	ldr r1, _0217560C // =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, _02175610 // =aActAcGmkLandBa
	str r1, [sp]
	mov r0, r4
	add r1, r4, #0x168
	str r6, [sp, #4]
	bl ObjObjectAction2dBACLoad
_021753E0:
	mov r0, r5, lsl #1
	add r0, r0, #0x4b
	bl GetObjectFileWork
	ldr r1, _02175614 // =0x02189764
	mov r3, r5, lsl #1
	mov r2, r0
	ldrh r1, [r1, r3]
	mov r0, r4
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #0
	mov r2, #0x4a
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r2, r5, lsl #1
	ldr r1, _02175618 // =0x02189772
	ldrh r1, [r1, r2]
	bl StageTask__SetAnimation
	str r4, [r4, #0x2d8]
	ldr r0, _0217561C // =StageTask__DefaultDiffData
	str r0, [r4, #0x2fc]
	ldrh r0, [r8, #4]
	tst r0, #0x80
	bne _0217546C
	ldrh r0, [r8, #2]
	cmp r0, #0xbd
	addne r0, r4, #0x200
	movne r1, #1
	strneh r1, [r0, #0xfa]
_0217546C:
	ldr r0, _02175620 // =_0218975C
	ldrb r0, [r0, r5]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02175554
_02175480: // jump table
	b _02175490 // case 0
	b _021754DC // case 1
	b _02175508 // case 2
	b _02175530 // case 3
_02175490:
	add r0, r4, #0x300
	mov r3, #0x18
	mov r1, #0x30
	strh r1, [r0, #8]
	strh r3, [r0, #0xa]
	sub r2, r3, #0x30
	add r1, r4, #0x200
	strh r2, [r1, #0xf0]
	sub r2, r3, #0x23
	strh r2, [r1, #0xf2]
	ldr r2, [r4, #0x304]
	cmp r2, #0
	beq _02175554
	mov r2, #8
	strh r2, [r0, #0xa]
	ldrsh r0, [r1, #0xf2]
	add r0, r0, #4
	strh r0, [r1, #0xf2]
	b _02175554
_021754DC:
	add r0, r4, #0x300
	mov r2, #0x18
	mov r1, #0x60
	strh r1, [r0, #8]
	strh r2, [r0, #0xa]
	sub r1, r2, #0x48
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r2, #0x23
	strh r1, [r0, #0xf2]
	b _02175554
_02175508:
	mov r2, #0x30
	add r0, r4, #0x300
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	sub r1, r2, #0x48
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r2, #0x47
	strh r1, [r0, #0xf2]
	b _02175554
_02175530:
	mov r2, #0x20
	add r0, r4, #0x300
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	sub r1, r2, #0x30
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r2, #0x2f
	strh r1, [r0, #0xf2]
_02175554:
	ldrh r0, [r8, #2]
	cmp r0, #0xc1
	bne _02175590
	ldr r1, _02175624 // =Platform__activeCount
	ldrsh r0, [r1]
	cmp r0, #0
	ldreq r0, [r1, #4]
	cmpeq r0, #0
	ldreq r0, _02175628 // =playerGameStatus
	ldreq r0, [r0, #0xc]
	streq r0, [r1, #4]
	ldr r0, _02175624 // =Platform__activeCount
	ldrsh r1, [r0]
	add r1, r1, #1
	strh r1, [r0]
_02175590:
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x48]
	bl Player__UseUpsideDownGravity
	cmp r0, #0
	beq _021755C0
	ldr r1, [r4, #0x20]
	add r0, r4, #0x200
	orr r1, r1, #2
	str r1, [r4, #0x20]
	ldrsh r1, [r0, #0xf2]
	sub r1, r1, #2
	strh r1, [r0, #0xf2]
_021755C0:
	bl AllocSndHandle
	str r0, [r4, #0x138]
	ldrh r1, [r8, #2]
	cmp r1, #0xbf
	cmpne r1, #0xc1
	ldrne r0, _02175608 // =0x00000149
	cmpne r1, r0
	beq _021755F0
	mov r0, r4
	bl Platform__Func_2175768
	ldr r0, _0217562C // =Platform__State_217568C
	str r0, [r4, #0xf4]
_021755F0:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021755FC: .word 0x000010F6
_02175600: .word StageTask_Main
_02175604: .word Platform__Destructor
_02175608: .word 0x00000149
_0217560C: .word gameArchiveStage
_02175610: .word aActAcGmkLandBa
_02175614: .word 0x02189764
_02175618: .word 0x02189772
_0217561C: .word StageTask__DefaultDiffData
_02175620: .word _0218975C
_02175624: .word Platform__activeCount
_02175628: .word playerGameStatus
_0217562C: .word Platform__State_217568C
	arm_func_end Platform__Create

	arm_func_start Platform__Destructor
Platform__Destructor: // 0x02175630
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	mov r1, #0
	str r1, [r0, #0x13c]
	ldr r0, [r0, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0xc1
	bne _0217567C
	ldr r0, _02175688 // =Platform__activeCount
	ldrsh r1, [r0]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0]
	ldr r0, _02175688 // =Platform__activeCount
	ldrsh r1, [r0]
	cmp r1, #0
	moveq r1, #0
	streq r1, [r0, #4]
_0217567C:
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r4, pc}
	.align 2, 0
_02175688: .word Platform__activeCount
	arm_func_end Platform__Destructor

	arm_func_start Platform__State_217568C
Platform__State_217568C: // 0x0217568C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r1, [r4, #0x28]
	ldr r5, [r4, #0x13c]
	cmp r1, #0x1e
	bhs _021756A8
	bl Platform__Func_2175860
_021756A8:
	ldr r0, [r5, #4]
	cmp r0, #0
	beq _021756E4
	ldr r0, [r0, #0x114]
	cmp r0, r4
	bne _021756E4
	ldr r0, [r4, #0x354]
	orr r0, r0, #1
	str r0, [r4, #0x354]
	ldr r0, [r4, #0x20]
	tst r0, #2
	mov r0, #0x2000
	rsbne r0, r0, #0
	strne r0, [r4, #0x54]
	streq r0, [r4, #0x54]
_021756E4:
	ldr r1, [r4, #0x340]
	ldrh r0, [r1, #4]
	tst r0, #0x40
	bne _02175700
	ldrh r0, [r1, #2]
	cmp r0, #0xbe
	ldmneia sp!, {r3, r4, r5, pc}
_02175700:
	ldr r0, [r4, #0x354]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	cmp r0, #0x1e
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0xbe
	bne _0217573C
	mov r0, r4
	bl Platform__Func_217599C
	ldmia sp!, {r3, r4, r5, pc}
_0217573C:
	ldr r1, [r4, #0x1c]
	mov r0, #0
	bic r1, r1, #0x2000
	orr r1, r1, #0x80
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x44]
	str r1, [r4, #0x8c]
	ldr r1, [r4, #0x48]
	str r1, [r4, #0x90]
	str r0, [r4, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Platform__State_217568C

	arm_func_start Platform__Func_2175768
Platform__Func_2175768: // 0x02175768
	stmdb sp!, {r4, lr}
	ldr r3, [r0, #0x340]
	ldr r2, [r0, #0x44]
	ldrsb r1, [r3, #6]
	ldrb r3, [r3, #8]
	add r1, r1, r2, asr #12
	add r1, r1, r3, asr #1
	str r1, [r0, #0x8c]
	ldr r3, [r0, #0x340]
	ldr r2, [r0, #0x48]
	ldrsb r1, [r3, #7]
	ldrb r3, [r3, #9]
	add r1, r1, r2, asr #12
	add r1, r1, r3, asr #1
	str r1, [r0, #0x90]
	ldr r1, [r0, #0x340]
	ldrb r4, [r1, #9]
	ldrb r3, [r1, #8]
	orrs r1, r3, r4
	ldmeqia sp!, {r4, pc}
	cmp r4, r3
	bhs _021757D4
	ldr r2, [r0, #0x44]
	mov r1, r3, asr #1
	mov r2, r2, asr #0xc
	ldr r3, [r0, #0x8c]
	b _021757E4
_021757D4:
	ldr r2, [r0, #0x48]
	ldr r3, [r0, #0x90]
	mov r1, r4, asr #1
	mov r2, r2, asr #0xc
_021757E4:
	ldr r4, _02175858 // =FX_SinCosTable_
	mov ip, #0x300
_021757EC:
	mov lr, ip, lsl #0x16
	mov lr, lr, lsr #0x10
	mov lr, lr, lsl #0x10
	mov lr, lr, lsr #0x10
	mov lr, lr, asr #4
	mov lr, lr, lsl #2
	ldrsh lr, [r4, lr]
	mul lr, r1, lr
	add lr, r3, lr, asr #12
	cmp lr, r2
	bgt _0217582C
	sub ip, ip, #4
	mov ip, ip, lsl #0x10
	mov ip, ip, lsr #0x10
	cmp ip, #0x100
	bhi _021757EC
_0217582C:
	str ip, [r0, #0x2c]
	ldr r1, [r0, #0x340]
	ldr r2, _0217585C // =0x00003FFF
	ldrh r1, [r1, #4]
	and r1, r1, #0x30
	mov r1, r1, asr #4
	mov r1, r1, lsl #0x18
	sub r1, ip, r1, asr #16
	and r1, r1, r2
	str r1, [r0, #0x2c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02175858: .word FX_SinCosTable_
_0217585C: .word 0x00003FFF
	arm_func_end Platform__Func_2175768

	arm_func_start Platform__Func_2175860
Platform__Func_2175860: // 0x02175860
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r3, [r0, #0x340]
	ldr r1, [r0, #0x2c]
	ldrh lr, [r3, #4]
	ldrb r2, [r3, #8]
	ldrb r3, [r3, #9]
	and r5, lr, #7
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0xf
	mov r4, r3, lsl #0xf
	ands r7, r5, #0xff
	mov r6, r1, lsr #0x10
	mov r3, r2, asr #0x10
	mov ip, r4, asr #0x10
	ldr r1, [r0, #0x8c]
	ldr r2, [r0, #0x90]
	beq _021758BC
	ldr r5, _02175990 // =playerGameStatus
	ldr r4, _02175994 // =0x000003FF
	ldr r5, [r5, #0xc]
	mla r6, r5, r7, r6
	and r4, r6, r4
	b _021758D0
_021758BC:
	ldr r4, _02175990 // =playerGameStatus
	ldr r4, [r4, #0xc]
	add r4, r4, r6, asr #2
	mov r4, r4, lsl #0x18
	mov r4, r4, lsr #0x16
_021758D0:
	mov r4, r4, lsl #0x10
	mov r4, r4, lsr #0x10
	tst lr, #8
	beq _02175934
	mov r5, r4, lsl #6
	add r4, r5, #0x8000
	mov lr, r4, lsl #0x10
	mov r4, r5, lsl #0x10
	mov r5, lr, lsr #0x10
	mov lr, r5, lsl #0x10
	mov r5, lr, lsr #0x10
	mov r4, r4, lsr #0x10
	mov r4, r4, lsl #0x10
	mov r5, r5, asr #4
	mov r4, r4, lsr #0x10
	mov r4, r4, asr #4
	ldr lr, _02175998 // =FX_SinCosTable_
	mov r5, r5, lsl #2
	ldrsh r5, [lr, r5]
	mov r4, r4, lsl #2
	ldrsh r4, [lr, r4]
	smulbb r5, r3, r5
	smulbb r3, ip, r4
	add r4, r1, r5, asr #12
	b _02175960
_02175934:
	mov lr, r4, lsl #0x16
	mov r4, lr, lsr #0x10
	mov lr, r4, lsl #0x10
	mov r4, lr, lsr #0x10
	mov r5, r4, asr #4
	ldr r4, _02175998 // =FX_SinCosTable_
	mov r5, r5, lsl #2
	ldrsh r5, [r4, r5]
	mul r4, r3, r5
	mul r3, ip, r5
	add r4, r1, r4, asr #12
_02175960:
	add r1, r2, r3, asr #12
	mov r3, r1, lsl #0xc
	ldr r1, [r0, #0x44]
	mov r2, r4, lsl #0xc
	sub r1, r2, r1
	str r1, [r0, #0xbc]
	ldr r1, [r0, #0x48]
	sub r1, r3, r1
	str r1, [r0, #0xc0]
	str r2, [r0, #0x44]
	str r3, [r0, #0x48]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02175990: .word playerGameStatus
_02175994: .word 0x000003FF
_02175998: .word FX_SinCosTable_
	arm_func_end Platform__Func_2175860

	arm_func_start Platform__Func_217599C
Platform__Func_217599C: // 0x0217599C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x1a4]
	mov r0, #0x42
	bic r1, r1, #0x800
	str r1, [r4, #0x1a4]
	mov r1, #0
	str r1, [r4, #0x2c]
	str r1, [sp]
	sub r1, r0, #0x43
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r1, _02175A00 // =Platform__State_2175A08
	ldr r0, _02175A04 // =Platform__Draw_2175C08
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02175A00: .word Platform__State_2175A08
_02175A04: .word Platform__Draw_2175C08
	arm_func_end Platform__Func_217599C

	arm_func_start Platform__State_2175A08
Platform__State_2175A08: // 0x02175A08
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #8
	str r0, [sp]
	ldr r0, [r0, #0x2c]
	mov r8, #8
	add r1, r0, #1
	ldr r0, [sp]
	str r1, [r0, #0x2c]
	ldr r1, [r0, #0x340]
	mov r0, #0xa
	str r0, [sp, #4]
	ldrh r0, [r1, #2]
	cmp r0, #0xbf
	bne _02175A60
	ldrsb r0, [r1, #7]
	cmp r0, #0
	movne r8, r0
	ldrb r0, [r1, #8]
	cmp r0, #0
	movne r0, r0, lsl #0x18
	movne r0, r0, asr #0x18
	strne r0, [sp, #4]
_02175A60:
	ldr r0, [sp]
	ldr r0, [r0, #0x13c]
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _02175AA8
	ldr r1, [r0, #0x114]
	ldr r0, [sp]
	cmp r1, r0
	bne _02175AA8
	ldr r0, [r0, #0x20]
	mov r1, #0x2000
	tst r0, #2
	ldreq r0, [sp]
	streq r1, [r0, #0x54]
	beq _02175AA8
	ldr r0, [sp]
	rsb r1, r1, #0
	str r1, [r0, #0x54]
_02175AA8:
	mov r0, #3
	sub r1, r0, #1
	ldr r0, [sp]
	and r7, r1, #0xff
	ldr r6, [r0, #0x2c]
	mov r5, #0
_02175AC0:
	ldr r0, [sp, #4]
	rsb r1, r7, #3
	mul sb, r1, r0
	mov r0, #3
	sub r0, r0, #1
	and sl, r0, #0xff
	ldr r0, [sp]
	add r1, r7, r7, lsl #1
	add r4, r0, r1, lsl #3
	mov fp, #0xff000000
_02175AE8:
	mul r0, r5, r8
	sub r3, r0, sb
	cmp r3, r6
	bge _02175B48
	add r2, r4, sl, lsl #3
	ldr r1, [r2, #0x368]
	ldr r0, [r2, #0x3b0]
	add r0, r1, r0
	str r0, [r2, #0x368]
	cmp r0, #0xff000000
	movlt r0, fp
	blt _02175B20
	cmp r0, #0x1000000
	movgt r0, #0x1000000
_02175B20:
	sub r1, r6, r3
	add r2, r4, sl, lsl #3
	mov r1, r1, lsl #5
	str r0, [r2, #0x368]
	ldr r0, [r2, #0x3b0]
	add r1, r1, #0x80
	mov r2, #0x30000
	bl ObjSpdUpSet
	add r1, r4, sl, lsl #3
	str r0, [r1, #0x3b0]
_02175B48:
	add r1, r5, #1
	sub r0, sl, #1
	cmp sl, #0
	and r5, r1, #0xff
	and sl, r0, #0xff
	bne _02175AE8
	sub r0, r7, #1
	cmp r7, #0
	and r7, r0, #0xff
	bne _02175AC0
	ldr r0, [sp]
	ldr r0, [r0, #0x368]
	cmp r0, #0
	beq _02175B94
	ldr r0, [sp]
	mov r1, #0
	str r1, [r0, #0x2d8]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
_02175B94:
	ldr r0, [sp]
	ldr r0, [r0, #0x370]
	cmp r0, #0
	beq _02175BCC
	ldr r0, [sp]
	mov r1, #0x10
	add r0, r0, #0x300
	strh r1, [r0, #8]
	ldr r0, [sp]
	sub r1, r1, #0x18
	add r0, r0, #0x200
	strh r1, [r0, #0xf0]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
_02175BCC:
	ldr r0, [sp]
	ldr r0, [r0, #0x378]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r0, [sp]
	mov r1, #0x20
	add r0, r0, #0x300
	strh r1, [r0, #8]
	ldr r0, [sp]
	sub r1, r1, #0x30
	add r0, r0, #0x200
	strh r1, [r0, #0xf0]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end Platform__State_2175A08

	arm_func_start Platform__Draw_2175C08
Platform__Draw_2175C08: // 0x02175C08
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x10
	bl GetCurrentTaskWork_
	add r1, r0, #0x168
	str r0, [sp, #0xc]
	str r1, [sp, #8]
	bl StageTask__Draw2D
	mov sb, #0
_02175C28:
	ldr r0, [sp, #8]
	mov fp, #0x200
	add r1, r0, sb, lsl #2
	ldr r0, [sp, #0xc]
	ldr r5, [r1, #0x94]
	add r8, r0, #0x364
	ldrsh r0, [r1, #0x68]
	mov r6, #0
	rsb fp, fp, #0
	str r0, [sp, #4]
	ldrsh r0, [r1, #0x6a]
	str r0, [sp]
	b _02175D64
_02175C5C:
	mov r0, r6
	mov r1, #3
	bl FX_DivS32
	ldmia r8, {r2, r4}
	ldr r1, [sp, #4]
	mov sl, r4, asr #0xc
	add r1, r1, r2, asr #12
	add r0, r1, r0, lsl #4
	sub r0, r0, #0x18
	mov r0, r0, lsl #0x10
	mov r7, r0, asr #0x10
	mov r0, r6
	mov r1, #3
	bl FX_ModS32
	ldr r1, [sp]
	add r1, r1, r4, asr #12
	add r0, r1, r0, lsl #3
	sub r0, r0, #0xc
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
	adds r0, r7, #0x10
	bmi _02175CCC
	cmp r7, #0x100
	bge _02175CCC
	adds r0, r1, #8
	bmi _02175CCC
	cmp r1, #0xc0
	blt _02175CD8
_02175CCC:
	mov r1, #0
	mov r2, #0xc0
	b _02175D20
_02175CD8:
	ldrh r1, [r5]
	mov r0, sl, lsl #0x10
	ldrh r4, [r5, #2]
	mov r2, r0, asr #0x10
	ldr r0, _02175D88 // =0x000001FF
	and r1, r1, #0xff
	mov r1, r1, lsl #0x10
	and r0, r4, r0
	ldr r3, [r8]
	add r2, r2, r1, asr #16
	mov r1, r3, lsl #4
	mov r0, r0, lsl #0x10
	mov r1, r1, asr #0x10
	add r0, r1, r0, asr #16
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r2, r0, asr #0x10
_02175D20:
	ldrh r4, [r5, #2]
	ldr r0, _02175D88 // =0x000001FF
	and r2, r2, #0xff
	and r3, r1, r0
	and r4, r4, fp
	orr r3, r4, r3
	strh r3, [r5, #2]
	ldrh r3, [r5]
	mov r0, sb
	mov r1, r5
	bic r3, r3, #0xff
	orr r2, r3, r2
	strh r2, [r5]
	bl OAMSystem__Func_207D624
	mov r5, r0
	add r6, r6, #1
	add r8, r8, #8
_02175D64:
	cmp r6, #9
	bge _02175D74
	cmp r5, #0
	bne _02175C5C
_02175D74:
	add sb, sb, #1
	cmp sb, #2
	blt _02175C28
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02175D88: .word 0x000001FF
	arm_func_end Platform__Draw_2175C08

	.data
	
_0218975C:
	.byte 0x00, 0x01, 0x02, 0x00
	.byte 0x00, 0x03, 0x00, 0x00, 0x10, 0x00, 0x18, 0x00, 0x20, 0x00, 0x10, 0x00, 0x10, 0x00, 0x08, 0x00
	.byte 0x10, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00

aActAcGmkLandBa: // 0x02189780
	.asciz "/act/ac_gmk_land.bac"
	.align 4