	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Truck3D__Create
Truck3D__Create: // 0x0216EAC4
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x6c
	ldr r3, _0216F2A0 // =0x000010F6
	mov r6, r0
	str r3, [sp]
	mov r0, #2
	mov r5, r1
	mov r4, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r7, _0216F2A4 // =0x00003F84
	ldr r0, _0216F2A8 // =StageTask_Main
	ldr r1, _0216F2AC // =Truck3D__Destructor
	mov r3, r2
	str r7, [sp, #8]
	bl TaskCreate_
	mov r7, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r7, r0
	addeq sp, sp, #0x6c
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, r7
	bl GetTaskWork_
	ldr r2, _0216F2A4 // =0x00003F84
	mov fp, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, fp
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	mov r0, #0x800
	bl _AllocHeadHEAP_SYSTEM
	add r1, fp, #0x3000
	str r0, [r1, #0xd58]
	ldr r1, [fp, #0x1c]
	ldr r0, _0216F2B0 // =0x048200C0
	bic r1, r1, #0x200
	orr r0, r1, r0
	str r0, [fp, #0x1c]
	mvn r0, #0x80000000
	str r0, [fp, #0xe80]
	sub r1, r0, #0x80000000
	add r0, fp, #0x3d00
	strh r1, [r0, #0x36]
	mov r0, #0xb4
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0216F2B4 // =gameArchiveStage
	mov r1, #0x18
	ldr r2, [r0]
	mov r0, fp
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _0216F2B8 // =aActAcGmkTruckB_0
	add r1, fp, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, fp
	mov r1, #0
	mov r2, #0x39
	bl ObjActionAllocSpritePalette
	mov r0, fp
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, fp
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, fp
	mov r1, #0
	bl StageTask__SetAnimation
	mov r0, #0xb7
	bl GetObjectFileWork
	mov r4, r0
	ldr r1, _0216F2B4 // =gameArchiveStage
	str r4, [sp]
	ldr r2, [r1]
	mov r0, fp
	str r2, [sp, #4]
	ldr r2, _0216F2BC // =aModGmkTruckNsb
	add r1, fp, #0x364
	mov r3, #0
	bl ObjAction3dNNModelLoad
	mov r7, #0
	ldr r0, [fp, #0x20]
	ldr r8, _0216F2C0 // =0x00004F32
	orr r0, r0, #0x200
	str r0, [fp, #0x20]
	str r8, [fp, #0x37c]
	str r8, [fp, #0x380]
	str r8, [fp, #0x384]
	add sb, fp, #0x4e0
	mov r6, r7
	mov r5, r7
	b _0216EC80
_0216EC48:
	mov r0, sb
	mov r1, r6
	bl AnimatorMDL__Init
	str r5, [sp]
	ldr r1, [r4]
	mov r0, sb
	mov r3, r5
	add r2, r7, #1
	bl AnimatorMDL__SetResource
	str r8, [sb, #0x18]
	str r8, [sb, #0x1c]
	str r8, [sb, #0x20]
	add r7, r7, #1
	add sb, sb, #0x144
_0216EC80:
	cmp r7, #6
	blt _0216EC48
	ldr r0, _0216F2B4 // =gameArchiveStage
	ldr r1, _0216F2C4 // =aActAcItmRing3d_0
	ldr r2, [r0]
	mov r0, #0
	bl ObjDataLoad
	mov r4, r0
	mov r0, #0x80
	mov r1, #0
	add r5, fp, #0x78
	bl VRAMSystem__AllocTexture
	mov r6, r0
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	ldr r2, _0216F2C8 // =0x00000844
	mov r1, #0
	stmia sp, {r2, r6}
	str r0, [sp, #8]
	add r0, r5, #0xc00
	mov r2, r4
	mov r3, r1
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	strb r0, [r5, #0xc0a]
	mov r0, #7
	strb r0, [r5, #0xc0b]
	ldr r1, [r5, #0xcf4]
	add r0, r5, #0xc00
	orr r1, r1, #0x8000
	str r1, [r5, #0xcf4]
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, [r5, #0xccc]
	mov r1, #0
	orr r0, r0, #0x10
	str r0, [r5, #0xccc]
	mov r0, #0x300
	add r6, fp, #0x17c
	bl VRAMSystem__AllocTexture
	mov r5, r0
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0x860
	stmia sp, {r1, r5}
	str r0, [sp, #8]
	mov r2, r4
	add r0, r6, #0xc00
	mov r1, #0
	mov r3, #1
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	strb r0, [r6, #0xc0a]
	mov r0, #7
	strb r0, [r6, #0xc0b]
	ldr r1, [r6, #0xcf4]
	add r0, r6, #0xc00
	orr r1, r1, #0x8000
	str r1, [r6, #0xcf4]
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r1, [r6, #0xccc]
	ldr r0, _0216F2B4 // =gameArchiveStage
	orr r1, r1, #0x18
	str r1, [r6, #0xccc]
	ldr r2, [r0]
	ldr r1, _0216F2CC // =aActAcGmkTruckC
	mov r0, #0
	bl ObjDataLoad
	mov r4, r0
	add r2, fp, #0x15c
	mov r0, #0x400
	mov r1, #0
	add r5, r2, #0x3c00
	bl VRAMSystem__AllocTexture
	mov r6, r0
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0x840
	stmia sp, {r1, r6}
	mov r1, #0
	str r0, [sp, #8]
	mov r0, r5
	mov r2, r4
	mov r3, r1
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	strb r0, [r5, #0xa]
	mov r0, #7
	strb r0, [r5, #0xb]
	ldr r1, [r5, #0xf4]
	mov r0, r5
	orr r1, r1, #0x8000
	str r1, [r5, #0xf4]
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r1, [r5, #0xcc]
	add r0, fp, #0xe60
	orr r1, r1, #0x10
	str r1, [r5, #0xcc]
	add r5, r0, #0x3000
	mov r0, #0x400
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r1, #0x810
	str r1, [sp]
	str r0, [sp, #4]
	add r0, fp, #0x3000
	ldr r1, [r0, #0xe38]
	mov r2, r4
	str r1, [sp, #8]
	mov r0, r5
	mov r1, #0
	mov r3, #1
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	strb r0, [r5, #0xa]
	mov r0, #7
	strb r0, [r5, #0xb]
	ldr r1, [r5, #0xf4]
	mov r0, r5
	orr r1, r1, #0x8000
	str r1, [r5, #0xf4]
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r2, _0216F2B4 // =gameArchiveStage
	ldr r1, _0216F2D0 // =aBpaGmkTruckCan
	ldr r2, [r2]
	mov r0, #0
	bl ObjDataLoad
	mov r1, r0
	mov r0, #5
	str r0, [sp]
	add r0, fp, #0x364
	ldr r4, [r5, #0xdc]
	add r0, r0, #0x3c00
	mov r2, #0
	mov r3, #2
	str r4, [sp, #4]
	bl InitPaletteAnimator
	mov sl, #0xc
	mov r8, #0
	ldr sb, _0216F2D4 // =0x0218866C
	add r7, sp, #0x24
	mov r4, sl
	mov r5, sl
	mov r6, sl
	b _0216EF5C
_0216EEEC:
	mov r1, r8, lsl #1
	mov r0, #0xc
	mul r0, r1, r0
	add r2, r1, #1
	mov r1, #0xc
	mul r1, r2, r1
	ldr r2, [sb, r1]
	ldr r0, [sb, r0]
	mov r1, #0x88
	sub r0, r0, r2
	bl FX_DivS32
	mul r1, r8, sl
	str r0, [r7, r1]
	add r2, r7, r1
	mov r1, r8, lsl #1
	add r0, r1, #1
	mla ip, r0, r4, sb
	mla r0, r1, r5, sb
	ldr r1, [r0, #8]
	ldr r0, [ip, #8]
	ldr r3, [ip, #4]
	sub r0, r1, r0
	mov r1, #0x88
	str r3, [r2, #4]
	bl FX_DivS32
	mla r1, r8, r6, r7
	str r0, [r1, #8]
	add r8, r8, #1
_0216EF5C:
	cmp r8, #6
	blt _0216EEEC
	add r0, fp, #0x3000
	add r4, fp, #0x144
	ldr r1, [r0, #0xd58]
	add r0, r4, #0x3c00
	mov r2, #0x800
	bl G3_BeginMakeDL
	add r0, r4, #0x3c00
	mov r1, #1
	bl G3C_MtxMode
	add r0, r4, #0x3c00
	mov r1, #0
	bl G3C_Color
	mov r7, #0
	mov sb, r7
	mov sl, r7
	b _0216F0E4
_0216EFA4:
	mov r0, #0x1c
	mul r1, r7, r0
	mov r0, r1, asr #3
	add r0, r1, r0, lsr #28
	mov r0, r0, asr #4
	mov r1, #0
	add r0, r0, #3
	add r5, r7, #1
	str r1, [sp]
	and r0, r0, #0x1f
	str r0, [sp, #4]
	mov r2, r1
	add r0, r4, #0x3c00
	mov r3, #3
	str r1, [sp, #8]
	add sb, sb, r5
	bl G3C_PolygonAttr
	add r0, r4, #0x3c00
	mov r1, #3
	bl G3C_Begin
	mov r8, #0
	ldr r6, _0216F2D4 // =0x0218866C
	add r5, sp, #0x24
	b _0216F0CC
_0216F004:
	mov r0, r8, lsl #1
	add r1, r0, #1
	mov r0, #0xc
	mul r2, r1, r0
	mul r3, r8, r0
	add r0, r6, r2
	ldr r1, [r6, r2]
	ldr r2, [r5, r3]
	ldr r0, [r0, #8]
	mla r1, sb, r2, r1
	add r3, r5, r3
	ldmib r3, {r2, r3}
	mla r3, sb, r3, r0
	str r1, [sp, #0x18]
	mov r1, r1, lsl #7
	mov r0, r2, lsl #7
	str r2, [sp, #0x1c]
	mov r2, r0, asr #0x10
	mov r0, r3, lsl #7
	str r3, [sp, #0x20]
	mov r3, r0, asr #0x10
	mov r1, r1, asr #0x10
	add r0, r4, #0x3c00
	bl G3C_Vtx
	mov r0, r8, lsl #1
	add r1, r0, #1
	mov r0, #0xc
	mul r0, r1, r0
	mov r2, #0xc
	mul r3, r8, r2
	ldr r1, [r6, r0]
	ldr r2, [r5, r3]
	add r0, r6, r0
	mla r1, sl, r2, r1
	add r3, r5, r3
	ldmib r3, {r2, r3}
	ldr r0, [r0, #8]
	str r1, [sp, #0xc]
	mla r3, sl, r3, r0
	mov r1, r1, lsl #7
	mov r0, r2, lsl #7
	str r2, [sp, #0x10]
	mov r2, r0, asr #0x10
	mov r0, r3, lsl #7
	str r3, [sp, #0x14]
	mov r3, r0, asr #0x10
	mov r1, r1, asr #0x10
	add r0, r4, #0x3c00
	bl G3C_Vtx
	add r8, r8, #1
_0216F0CC:
	cmp r8, #6
	blt _0216F004
	add r0, r4, #0x3c00
	bl G3C_End
	mov sl, sb
	add r7, r7, #1
_0216F0E4:
	cmp r7, #0x10
	blt _0216EFA4
	add r0, r4, #0x3c00
	bl G3_EndMakeDL
	add r0, fp, #0x3000
	ldr r0, [r0, #0xd58]
	mov r1, #0x800
	bl DC_FlushRange
	mov r3, #0x20
	ldr r2, _0216F2D8 // =0x00000201
	str fp, [fp, #0x234]
	add r0, fp, #0x200
	strh r2, [r0, #0x4c]
	ldr r0, [fp, #0x230]
	sub r1, r3, #0x40
	bic r0, r0, #0x300
	orr r0, r0, #0x20
	str r0, [fp, #0x230]
	mov r2, r1
	add r0, fp, #0x218
	str r3, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	add r0, fp, #0x218
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, _0216F2DC // =0x0000FFFF
	add r0, fp, #0x218
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	ldr r0, [fp, #0x230]
	mov r3, #0x20
	orr r0, r0, #0x400
	bic r0, r0, #4
	str r0, [fp, #0x230]
	sub r1, r3, #0x40
	str fp, [fp, #0x274]
	add r0, fp, #0x258
	mov r2, r1
	str r3, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	add r0, fp, #0x258
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, _0216F2E0 // =0x0000FFEF
	add r0, fp, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [fp, #0x270]
	ldr r0, _0216F2E4 // =Truck3D__OnDefend_21712A4
	orr r1, r1, #0x400
	str r1, [fp, #0x270]
	str r0, [fp, #0x27c]
	mov r0, #0
	str r0, [fp, #0x2b4]
	mov r0, #0x15
	str r0, [sp]
	sub r1, r0, #0x35
	mov r0, fp
	mov r2, #5
	mov r3, #0x20
	bl StageTask__SetHitbox
	ldr r0, _0216F2E8 // =StageTask__DefaultDiffData
	str fp, [fp, #0x2d8]
	mov r3, #0x40
	str r0, [fp, #0x2fc]
	add r0, fp, #0x300
	strh r3, [r0, #8]
	strh r3, [r0, #0xa]
	sub r1, r3, #0x60
	add r0, fp, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r3, #0x62
	strh r1, [r0, #0xf2]
	mov r0, #0xc000
	str r0, [fp, #0xe0]
	mov r2, #0x200
	str r2, [fp, #0xd0]
	mov r1, #0xb000
	ldr r0, _0216F2EC // =Truck3D__State_2170D44
	str r1, [fp, #0xd4]
	str r0, [fp, #0xf4]
	sub r0, r2, #0x280
	strh r0, [fp, #0xe]
	mov r0, #0x100
	strh r0, [fp, #0x12]
	mov r7, #0
	ldr r5, _0216F2F0 // =0x021886FC
	ldr r4, _0216F2F4 // =0x02188704
	ldr r8, _0216F2F8 // =0x0218860C
	mov r6, #0xc
	b _0216F284
_0216F258:
	mul r1, r7, r6
	ldrb r3, [r5, r7]
	ldrb r2, [r4, r7]
	add r0, r8, r1
	str r3, [sp]
	str r2, [sp, #4]
	ldmib r0, {r2, r3}
	ldr r1, [r8, r1]
	mov r0, fp
	bl EffectTruckJewel__Create
	add r7, r7, #1
_0216F284:
	cmp r7, #8
	blt _0216F258
	bl AllocSndHandle
	str r0, [fp, #0x138]
	mov r0, fp
	add sp, sp, #0x6c
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_0216F2A0: .word 0x000010F6
_0216F2A4: .word 0x00003F84
_0216F2A8: .word StageTask_Main
_0216F2AC: .word Truck3D__Destructor
_0216F2B0: .word 0x048200C0
_0216F2B4: .word gameArchiveStage
_0216F2B8: .word aActAcGmkTruckB_0
_0216F2BC: .word aModGmkTruckNsb
_0216F2C0: .word 0x00004F32
_0216F2C4: .word aActAcItmRing3d_0
_0216F2C8: .word 0x00000844
_0216F2CC: .word aActAcGmkTruckC
_0216F2D0: .word aBpaGmkTruckCan
_0216F2D4: .word 0x0218866C
_0216F2D8: .word 0x00000201
_0216F2DC: .word 0x0000FFFF
_0216F2E0: .word 0x0000FFEF
_0216F2E4: .word Truck3D__OnDefend_21712A4
_0216F2E8: .word StageTask__DefaultDiffData
_0216F2EC: .word Truck3D__State_2170D44
_0216F2F0: .word 0x021886FC
_0216F2F4: .word 0x02188704
_0216F2F8: .word 0x0218860C
	arm_func_end Truck3D__Create

	arm_func_start Truck3D__Func_216F2FC
Truck3D__Func_216F2FC: // 0x0216F2FC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r1
	ldr r1, [r4, #0x340]
	ldrh r1, [r1, #2]
	cmp r1, #0xad
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x354]
	tst r1, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	orr r1, r1, #1
	str r1, [r4, #0x354]
	str r0, [r4, #0x35c]
	mov r0, #0
	str r0, [r4, #0x2d8]
	ldr r0, [r4, #0x2f4]
	mov r1, #0x15
	orr r0, r0, #0x100
	str r0, [r4, #0x2f4]
	ldr r2, [r4, #0xbc]
	ldr r0, _0216F3C0 // =Truck3D__State_2170E10
	str r2, [r4, #0x98]
	str r2, [r4, #0xc8]
	str r0, [r4, #0xf4]
	str r1, [sp]
	mov r0, r4
	sub r1, r1, #0x1b
	mov r2, #5
	mov r3, #6
	bl StageTask__SetHitbox
	ldr r0, [r4, #0x354]
	mov r1, #0
	bic r0, r0, #0x10
	str r0, [r4, #0x354]
	ldr r0, [r4, #0x138]
	bl NNS_SndPlayerStopSeq
	mov r2, #0
	mov r0, #0x62
	str r2, [sp]
	sub r1, r0, #0x63
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216F3C0: .word Truck3D__State_2170E10
	arm_func_end Truck3D__Func_216F2FC

	.data

.public _021895C0
_021895C0:
	.byte 0xE9, 0x3B, 0xFE, 0xFF, 0x00, 0xC0, 0xF9, 0xFF, 0x88, 0x80, 0xFC, 0xFF, 0x25, 0x8E, 0xF7, 0xFF
	.byte 0xAD, 0x4E, 0xFA, 0xFF, 0xC5, 0xD2, 0xF5, 0xFF, 0xAD, 0x0E, 0xF4, 0xFF, 0xAD, 0x0E, 0xF4, 0xFF
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xF8, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xF6, 0xFF
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xF4, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xF6, 0xFF
	.byte 0x17, 0xC4, 0x01, 0x00, 0x00, 0xC0, 0xF9, 0xFF, 0x78, 0x7F, 0x03, 0x00, 0x25, 0x8E, 0xF7, 0xFF
	.byte 0x53, 0xB1, 0x05, 0x00, 0xC5, 0xD2, 0xF5, 0xFF, 0x53, 0xF1, 0x0B, 0x00, 0xAD, 0x0E, 0xF4, 0xFF

aActAcGmkTruckB_0: // 0x02189620
	.asciz "/act/ac_gmk_truck.bac"
	.align 4
	
aModGmkTruckNsb: // 0x02189638
	.asciz "/mod/gmk_truck.nsbmd"
	.align 4
	
aActAcItmRing3d_0: // 0x02189650
	.asciz "/act/ac_itm_ring3d.bac"
	.align 4
	
aActAcGmkTruckC: // 0x02189668
	.asciz "/act/ac_gmk_truck_candle3d.bac"
	.align 4
	
aBpaGmkTruckCan: // 0x02189688
	.asciz "/bpa/gmk_truck_candle.bpa"
	.align 4