	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start VRotateCrane__Create
VRotateCrane__Create: // 0x0216D5A4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, _0216D8E4 // =0x000010F6
	mov r7, r0
	str r3, [sp]
	mov r0, #2
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _0216D8E8 // =0x00000634
	ldr r0, _0216D8EC // =StageTask_Main
	ldr r1, _0216D8F0 // =VRotateCrane__Destructor
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
	ldr r2, _0216D8E8 // =0x00000634
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xad
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x300
	str r1, [r4, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0216D8F4 // =gameArchiveStage
	mov r1, #0
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _0216D8F8 // =aActAcGmkVrotCr
	bl ObjObjectAction2dBACLoad
	mov r0, #0xaf
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #0x3a
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #0
	mov r2, #0x32
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimation
	mov r0, #0xae
	bl GetObjectFileWork
	str r0, [sp]
	ldr r1, _0216D8F4 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	add r1, r4, #0x364
	str r2, [sp, #4]
	ldr r2, _0216D8FC // =aModGmkVrotCran
	mov r3, #0
	bl ObjAction3dNNModelLoad
	ldr r0, _0216D900 // =0x000034CC
	add r5, r4, #0x4e0
	str r0, [r4, #0x37c]
	str r0, [r4, #0x380]
	str r0, [r4, #0x384]
	mov r0, #0xad
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0216D8F4 // =gameArchiveStage
	ldr r1, _0216D8F8 // =aActAcGmkVrotCr
	ldr r6, [r0, #0]
	mov r0, r5
	mov r2, #0
	str r6, [sp]
	bl ObjAction2dBACLoad
	mov r0, #0xb1
	bl GetObjectFileWork
	mov r1, #0
	mov r2, #0xb
	bl ObjActionAllocSprite
	str r0, [r5, #0x78]
	mov r0, #0xb2
	bl GetObjectFileWork
	mov r1, #1
	mov r2, #0xb
	bl ObjActionAllocSprite
	str r0, [r5, #0x7c]
	ldr r1, [r4, #0x128]
	mov r0, r5
	ldrh r2, [r1, #0x50]
	mov r1, #0
	strh r2, [r5, #0x50]
	strh r2, [r5, #0x92]
	strh r2, [r5, #0x90]
	ldr r2, [r5, #0x3c]
	orr r2, r2, #0x10
	str r2, [r5, #0x3c]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r5
	mov r1, #2
	bl StageTask__SetOAMPriority
	ldrh r0, [r7, #2]
	mov r3, #0
	cmp r0, #0xa7
	cmpne r0, #0xa9
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #1
	streq r0, [r4, #0x20]
	str r4, [r4, #0x234]
	ldrh r0, [r7, #2]
	cmp r0, #0xa6
	cmpne r0, #0xa7
	bne _0216D7E8
	mov r5, #0x8e
	add r0, r4, #0x218
	sub r1, r5, #0xbe
	mov r2, #0x6a
	str r5, [sp]
	bl ObjRect__SetBox2D
	b _0216D800
_0216D7E8:
	mvn r5, #0x69
	add r0, r4, #0x218
	add r1, r5, #0x3a
	sub r2, r5, #0x24
	str r5, [sp]
	bl ObjRect__SetBox2D
_0216D800:
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _0216D904 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _0216D908 // =VRotateCrane__OnDefend
	mov r1, #0
	str r0, [r4, #0x23c]
	ldr r2, [r4, #0x230]
	ldr r5, _0216D90C // =StageTask__DefaultDiffData
	orr r2, r2, #0x400
	str r2, [r4, #0x230]
	str r1, [r4, #0x13c]
	str r4, [r4, #0x2d8]
	add r6, r4, #0x2d8
	str r5, [r6, #0x24]
	mov r2, #0x30
	mov r3, #0x20
	strh r2, [r6, #0x30]
	strh r3, [r6, #0x32]
	sub r2, r3, #0x50
	strh r2, [r6, #0x18]
	sub r2, r3, #0x30
	strh r2, [r6, #0x1a]
	add r0, r4, #0x184
	add r2, r0, #0x400
	str r4, [r4, #0x584]
	str r5, [r2, #0x24]
	mov r0, #0x18
	mov r1, #0x98
	strh r0, [r2, #0x30]
	strh r1, [r2, #0x32]
	sub r0, r1, #0xa4
	strh r0, [r2, #0x18]
	ldrh r0, [r7, #2]
	cmp r0, #0xa6
	cmpne r0, #0xa7
	mvneq r0, #0xf
	streqh r0, [r2, #0x1a]
	beq _0216D8C8
	sub r0, r1, #0x120
	strh r0, [r2, #0x1a]
	ldrh r0, [r7, #2]
	cmp r0, #0xa8
	cmpne r0, #0xa9
	moveq r0, #0x8000
	streqh r0, [r4, #0x30]
_0216D8C8:
	ldr r0, _0216D910 // =VRotateCrane__Draw
	ldr r1, _0216D914 // =VRotateCrane__Collide
	str r0, [r4, #0xfc]
	mov r0, r4
	str r1, [r4, #0x108]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216D8E4: .word 0x000010F6
_0216D8E8: .word 0x00000634
_0216D8EC: .word StageTask_Main
_0216D8F0: .word VRotateCrane__Destructor
_0216D8F4: .word gameArchiveStage
_0216D8F8: .word aActAcGmkVrotCr
_0216D8FC: .word aModGmkVrotCran
_0216D900: .word 0x000034CC
_0216D904: .word 0x0000FFFE
_0216D908: .word VRotateCrane__OnDefend
_0216D90C: .word StageTask__DefaultDiffData
_0216D910: .word VRotateCrane__Draw
_0216D914: .word VRotateCrane__Collide
	arm_func_end VRotateCrane__Create

	arm_func_start VRotateCrane__Destructor
VRotateCrane__Destructor: // 0x0216D918
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0xb1
	bl GetObjectFileWork
	mov r1, #0
	bl ObjActionReleaseSprite
	mov r0, #0xb2
	bl GetObjectFileWork
	mov r1, #1
	bl ObjActionReleaseSprite
	mov r1, #0
	str r1, [r4, #0x558]
	mov r0, #0xad
	str r1, [r4, #0x55c]
	bl GetObjectFileWork
	add r1, r4, #0x4e0
	bl ObjAction2dBACRelease
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end VRotateCrane__Destructor

	arm_func_start VRotateCrane__State_216D970
VRotateCrane__State_216D970: // 0x0216D970
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x340]
	ldr r2, [r5, #0x28]
	ldrh r1, [r0, #2]
	mov r0, r2, lsl #0x10
	mov r4, r0, lsr #0x10
	ldrh r0, [r5, #0x34]
	cmp r1, #0xa6
	cmpne r1, #0xa9
	rsbeq r0, r0, #0x10000
	moveq r0, r0, lsl #0x10
	mov r2, #0x100
	str r2, [sp]
	moveq r0, r0, lsr #0x10
	mov r1, r4
	mov r2, #2
	mov r3, #0x400
	bl ObjShiftSet
	ldr r1, [r5, #0x340]
	mov r0, r0, lsl #0x10
	ldrh r1, [r1, #2]
	mov r2, r0, lsr #0x10
	cmp r1, #0xa6
	cmpne r1, #0xa9
	rsbeq r0, r2, #0x10000
	streqh r0, [r5, #0x34]
	strneh r2, [r5, #0x34]
	cmp r2, r4
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, _0216DA04 // =VRotateCrane__State_216DA08
	mov r0, #0
	str r1, [r5, #0xf4]
	str r0, [r5, #0x2c]
	ldrh r0, [r5, #0x34]
	str r0, [r5, #0x28]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216DA04: .word VRotateCrane__State_216DA08
	arm_func_end VRotateCrane__State_216D970

	arm_func_start VRotateCrane__State_216DA08
VRotateCrane__State_216DA08: // 0x0216DA08
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r1, [r0, #0x2c]
	add r1, r1, #0x44
	str r1, [r0, #0x2c]
	cmp r1, #0x1000
	ble _0216DA68
	ldr r1, _0216DD48 // =VRotateCrane__State_216DD4C
	mov r4, #0
	str r1, [r0, #0xf4]
	str r4, [r0, #0x2c]
	ldr r1, [r0, #0x340]
	mov r2, #0
	ldrh r1, [r1, #2]
	add r1, r1, #0x5a
	add r1, r1, #0xff00
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r1, #1
	ldr r1, [r0, #0x28]
	movls r4, #0x8000
	rsb r1, r1, #0x10000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	b _0216DD38
_0216DA68:
	cmp r1, #0x800
	ldr r2, [r0, #0x340]
	ble _0216DBE4
	ldrh r2, [r2, #2]
	sub r1, r1, #0x800
	mov r1, r1, lsl #0x11
	str r2, [sp]
	add r2, r2, #0x5a
	add r2, r2, #0xff00
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	cmp r2, #1
	mov r2, #2
	mov r4, #0
	bhi _0216DAF4
	mov r9, r1, asr #0x10
	mov r8, r9, asr #0x1f
	mov r1, #0x4000
	mov r3, #0x800
_0216DAB4:
	rsb r5, r1, #0x8000
	umull r7, r6, r5, r9
	mla r6, r5, r8, r6
	mov r5, r5, asr #0x1f
	mla r6, r5, r9, r6
	adds r7, r7, r3
	adc r5, r6, r4
	mov r6, r7, lsr #0xc
	orr r6, r6, r5, lsl #20
	cmp r2, #0
	add r1, r1, r6
	sub r2, r2, #1
	bne _0216DAB4
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
	b _0216DB40
_0216DAF4:
	mov r9, r1, asr #0x10
	mov r8, r9, asr #0x1f
	mov r1, #0x4000
	mov r3, #0x800
_0216DB04:
	rsb r5, r1, #0
	umull r7, r6, r5, r9
	mla r6, r5, r8, r6
	mov r5, r5, asr #0x1f
	mla r6, r5, r9, r6
	adds r7, r7, r3
	adc r5, r6, r4
	mov r6, r7, lsr #0xc
	orr r6, r6, r5, lsl #20
	cmp r2, #0
	add r1, r1, r6
	sub r2, r2, #1
	bne _0216DB04
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
_0216DB40:
	ldr r7, [r0, #0x28]
	mov r5, #0
	cmp r7, #0x8000
	rsbhi r1, r7, #0x10000
	movhi r1, r1, lsl #0x10
	movls r1, r7, lsl #0x10
	mov r10, r1, lsr #0x10
	mov r6, #2
	mov r1, r5
	mov r11, #0x800
_0216DB68:
	sub r3, r10, r5
	umull r2, ip, r3, r9
	adds r2, r2, r11
	mov lr, r2, lsr #0xc
	mla ip, r3, r8, ip
	mov r2, r3, asr #0x1f
	mla ip, r2, r9, ip
	adc r2, ip, r1
	orr lr, lr, r2, lsl #20
	cmp r6, #0
	add r5, r5, lr
	sub r6, r6, #1
	bne _0216DB68
	ldr r1, [sp]
	mov r2, r5, lsl #0x10
	cmp r1, #0xa7
	mov r1, r2, lsr #0x10
	ldrne r2, [sp]
	cmpne r2, #0xa9
	sub r2, r10, r1
	bne _0216DBC0
	b _0216DBC4
_0216DBC0:
	rsb r2, r2, #0x10000
_0216DBC4:
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	cmp r7, #0x8000
	bhs _0216DD38
	rsb r1, r1, #0x10000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	b _0216DD38
_0216DBE4:
	ldrh r3, [r2, #2]
	mov r1, r1, lsl #0x11
	mov r7, r1, asr #0x10
	add r2, r3, #0x5a
	add r2, r2, #0xff00
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	cmp r2, #1
	bhi _0216DC54
	mov r6, r7, asr #0x1f
	mov r10, #2
	mov r9, #0x4000
	mov r2, #0
	mov r1, #0x800
_0216DC1C:
	umull r8, r5, r9, r7
	mla r5, r9, r6, r5
	mov r4, r9, asr #0x1f
	adds r8, r8, r1
	mla r5, r4, r7, r5
	adc r4, r5, r2
	mov r9, r8, lsr #0xc
	cmp r10, #0
	orr r9, r9, r4, lsl #20
	sub r10, r10, #1
	bne _0216DC1C
	mov r1, r9, lsl #0x10
	mov r4, r1, lsr #0x10
	b _0216DCA4
_0216DC54:
	mov r6, r7, asr #0x1f
	mov r1, #2
	mov r5, #0x4000
	mov r4, #0
	mov r2, #0x800
_0216DC68:
	sub r5, r5, #0x8000
	umull r9, r8, r5, r7
	mla r8, r5, r6, r8
	mov r5, r5, asr #0x1f
	mla r8, r5, r7, r8
	adds r9, r9, r2
	adc r5, r8, r4
	mov r8, r9, lsr #0xc
	orr r8, r8, r5, lsl #20
	cmp r1, #0
	add r5, r8, #0x8000
	sub r1, r1, #1
	bne _0216DC68
	mov r1, r5, lsl #0x10
	mov r4, r1, lsr #0x10
_0216DCA4:
	ldr r5, [r0, #0x28]
	mov r2, #2
	cmp r5, #0x8000
	rsbhi r1, r5, #0x10000
	movhi r1, r1, lsl #0x10
	movls r1, r5, lsl #0x10
	mov r8, r1, lsr #0x10
	mov r1, #0
	mov r10, r1
	mov r9, #0x800
_0216DCCC:
	sub ip, r1, r8
	umull r1, lr, ip, r7
	mla lr, ip, r6, lr
	mov r11, ip, asr #0x1f
	adds r1, r1, r9
	mla lr, r11, r7, lr
	adc r11, lr, r10
	mov r1, r1, lsr #0xc
	orr r1, r1, r11, lsl #20
	cmp r2, #0
	add r1, r8, r1
	sub r2, r2, #1
	bne _0216DCCC
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r3, #0xa7
	cmpne r3, #0xa9
	sub r2, r8, r1
	bne _0216DD1C
	b _0216DD20
_0216DD1C:
	rsb r2, r2, #0x10000
_0216DD20:
	cmp r5, #0x8000
	rsbhi r1, r1, #0x10000
	mov r2, r2, lsl #0x10
	movhi r1, r1, lsl #0x10
	mov r2, r2, lsr #0x10
	movhi r1, r1, lsr #0x10
_0216DD38:
	strh r4, [r0, #0x30]
	strh r2, [r0, #0x32]
	strh r1, [r0, #0x34]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216DD48: .word VRotateCrane__State_216DD4C
	arm_func_end VRotateCrane__State_216DA08

	arm_func_start VRotateCrane__State_216DD4C
VRotateCrane__State_216DD4C: // 0x0216DD4C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x340]
	ldrh r0, [r4, #0x34]
	ldrh r1, [r1, #2]
	mov ip, #0x200
	mov r2, #2
	add r1, r1, #0x59
	add r1, r1, #0xff00
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r1, #1
	rsbls r0, r0, #0x10000
	movls r0, r0, lsl #0x10
	movls r0, r0, lsr #0x10
	mov r1, #0
	mov r3, #0x600
	str ip, [sp]
	bl ObjShiftSet
	mov r0, r0, lsl #0x10
	movs r1, r0, lsr #0x10
	bne _0216DEA4
	ldr r0, [r4, #0x24]
	mov r3, #0
	orr r0, r0, #2
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x28]
	mov ip, #0x67
	cmp r0, #0x8000
	rsbhi r0, r0, #0x10000
	strhi r0, [r4, #0x28]
	ldr r0, [r4, #0x28]
	mov r0, r0, lsl #3
	str r0, [r4, #0xc8]
	ldr r0, [r4, #0x20]
	tst r0, #1
	ldreq r0, [r4, #0xc8]
	rsbeq r0, r0, #0
	streq r0, [r4, #0xc8]
	str r3, [r4, #0xf4]
	ldr r1, [r4, #0x20]
	add r0, r4, #0x184
	orr r1, r1, #0x200
	str r1, [r4, #0x20]
	str r4, [r4, #0x2d8]
	str r4, [r4, #0x584]
	ldr r1, [r4, #0x340]
	add r2, r0, #0x400
	ldrh r0, [r1, #2]
	mov r1, #0x30
	add r0, r0, #0x5a
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	subls r0, r3, #0x88
	subhi r0, r3, #0x10
	strh r0, [r2, #0x1a]
	add r0, r4, #0x1dc
	add r2, r0, #0x400
	str r4, [r4, #0x5dc]
	mov r0, #0x40
	strh r0, [r2, #0x30]
	strh r1, [r2, #0x32]
	sub r0, r1, #0x60
	strh r0, [r2, #0x18]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	add r0, r0, #0x5a
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	subls r0, r1, #0xb8
	movhi r0, #0x58
	strh r0, [r2, #0x1a]
	sub r1, ip, #0x68
	mov r0, #0
	strh r0, [r4, #0x34]
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0216DEA4:
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	add r0, r0, #0x59
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	rsbls r0, r1, #0x10000
	movls r0, r0, lsl #0x10
	movls r1, r0, lsr #0x10
	strh r1, [r4, #0x34]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end VRotateCrane__State_216DD4C

	arm_func_start VRotateCrane__Draw
VRotateCrane__Draw: // 0x0216DED8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x20]
	bic r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x12c]
	bl StageTask__Draw3D
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldrh r0, [r4, #0x30]
	cmp r0, #0
	cmpne r0, #0x8000
	bne _0216DF38
	ldr r5, [r4, #0x20]
	cmp r0, #0x8000
	orreq r0, r5, #2
	streq r0, [r4, #0x20]
	ldr r1, [r4, #0x128]
	mov r0, r4
	bl StageTask__Draw2D
	str r5, [r4, #0x20]
_0216DF38:
	mov r2, #0
	add r0, r4, #0x20
	stmia sp, {r0, r2}
	mov r3, r2
	add r0, r4, #0x4e0
	add r1, r4, #0x44
	str r2, [sp, #8]
	bl StageTask__Draw2DEx
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end VRotateCrane__Draw

	arm_func_start VRotateCrane__Collide
VRotateCrane__Collide: // 0x0216DF60
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x18]
	tst r1, #0xc
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x234]
	cmp r1, #0
	beq _0216DF8C
	add r1, r4, #0x218
	bl StageTask__HandleCollider
_0216DF8C:
	mov r0, r4
	bl StageTask__ViewCheck_Default
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x2d8]
	cmp r0, #0
	beq _0216DFB0
	add r0, r4, #0x2d8
	bl ObjCollisionObjectRegist
_0216DFB0:
	ldr r0, [r4, #0x584]
	cmp r0, #0
	beq _0216DFC8
	add r0, r4, #0x184
	add r0, r0, #0x400
	bl ObjCollisionObjectRegist
_0216DFC8:
	ldr r0, [r4, #0x5dc]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x1dc
	add r0, r0, #0x400
	bl ObjCollisionObjectRegist
	ldmia sp!, {r4, pc}
	arm_func_end VRotateCrane__Collide

	arm_func_start VRotateCrane__OnDefend
VRotateCrane__OnDefend: // 0x0216DFE4
	stmdb sp!, {r3, lr}
	ldr r1, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r1, #0
	cmpne r0, #0
	ldmeqia sp!, {r3, pc}
	ldrh r2, [r0, #0]
	cmp r2, #1
	ldreqb r2, [r0, #0x5d1]
	cmpeq r2, #0
	ldmneia sp!, {r3, pc}
	ldr r2, [r1, #0x18]
	mov ip, #0
	orr r2, r2, #2
	str r2, [r1, #0x18]
	str ip, [r1, #0x24]
	str ip, [r1, #0x2c]
	ldr r3, [r1, #0x20]
	ldr r2, _0216E0C4 // =VRotateCrane__State_216D970
	bic r3, r3, #0x200
	str r3, [r1, #0x20]
	str ip, [r1, #0x2d8]
	str ip, [r1, #0x584]
	str r2, [r1, #0xf4]
	ldr r2, [r0, #0x1c]
	tst r2, #0x8000
	beq _0216E070
	ldr r2, [r0, #0x9c]
	ldr r3, [r0, #0x98]
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r3, #0
	rsblt r3, r3, #0
	add r2, r3, r2
	b _0216E09C
_0216E070:
	ldr r2, [r0, #0x98]
	ldr r3, [r0, #0xc8]
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r3, #0
	rsblt r3, r3, #0
	ldr ip, [r0, #0x9c]
	add r2, r3, r2
	cmp ip, #0
	rsblt ip, ip, #0
	add r2, ip, r2
_0216E09C:
	mov r2, r2, asr #3
	str r2, [r1, #0x28]
	cmp r2, #0x800
	movlo r2, #0x800
	blo _0216E0B8
	cmp r2, #0x2000
	movhi r2, #0x2000
_0216E0B8:
	str r2, [r1, #0x28]
	bl Player__Action_CraneGrab
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216E0C4: .word VRotateCrane__State_216D970
	arm_func_end VRotateCrane__OnDefend

	.data
	
aActAcGmkVrotCr: // 0x02189570
	.asciz "/act/ac_gmk_vrot_crane.bac"
	.align 4
	
aModGmkVrotCran: // 0x0218958C
	.asciz "/mod/gmk_vrot_crane.nsbmd"
	.align 4