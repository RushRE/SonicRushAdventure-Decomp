	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start TruckLava3D__Create
TruckLava3D__Create: // 0x0217078C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x148
	mov r3, #0x1800
	mov r8, r0
	mov r6, r1
	mov r4, r2
	mov r2, #0
	str r3, [sp]
	mov r5, #2
	str r5, [sp, #4]
	mov r5, #0x3b0
	ldr r0, _02170ABC // =StageTask_Main
	ldr r1, _02170AC0 // =TruckLava3D__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0x148
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r5
	bl GetTaskWork_
	mov r5, r0
	mov r1, #0
	mov r2, #0x3b0
	bl MI_CpuFill8
	mov r0, r5
	mov r1, r8
	mov r2, r6
	mov r3, r4
	bl GameObject__InitFromObject
	mov r0, #0x100
	bl _AllocHeadHEAP_SYSTEM
	str r0, [r5, #0x3ac]
	ldr r0, [r5, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r5, #0x1c]
	ldr r0, [r5, #0x20]
	orr r0, r0, #0x100
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x18]
	orr r0, r0, #0x10
	str r0, [r5, #0x18]
	ldrsb r0, [r8, #6]
	cmp r0, #0
	moveq r1, #1
	movne r1, #0
	ldr r0, _02170AC4 // =gameArchiveStage
	mov r3, r1, lsl #0x10
	ldr r2, [r0]
	ldr r1, _02170AC8 // =aActAcGmkTruckL
	mov r0, #0
	mov r6, r3, lsr #0x10
	bl ObjDataLoad
	mov r4, r0
	mov r0, #0x800
	mov r1, #0
	bl VRAMSystem__AllocTexture
	str r0, [r5, #0x390]
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	str r0, [r5, #0x394]
	mov r1, #0
	str r1, [sp]
	mov r2, r4
	ldr r4, [r5, #0x390]
	mov r3, r6
	str r4, [sp, #4]
	ldr r4, [r5, #0x394]
	add r0, sp, #0x44
	str r4, [sp, #8]
	bl AnimatorSprite3D__Init
	mov r1, #0
	add r0, sp, #0x44
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r2, _02170AC4 // =gameArchiveStage
	ldr r1, _02170ACC // =aBpaGmkTruckLav
	ldr r2, [r2]
	mov r0, #0
	bl ObjDataLoad
	mov r1, r0
	mov r0, #5
	str r0, [sp]
	ldr r2, [r5, #0x394]
	add r0, r5, #0x370
	str r2, [sp, #4]
	mov r2, #0
	mov r3, #2
	bl InitPaletteAnimator
	ldr r1, [r5, #0x3ac]
	add r0, r5, #0x398
	mov r2, #0x100
	bl G3_BeginMakeDL
	mov r1, #0
	str r1, [sp]
	mov r0, #0x1f
	str r0, [sp, #4]
	mov r0, #0x8000
	str r0, [sp, #8]
	add r0, r5, #0x398
	mov r2, r1
	mov r3, #3
	bl G3C_PolygonAttr
	ldr r3, [r5, #0x394]
	ldr r1, _02170AD0 // =0x0001FFFF
	add r0, r5, #0x398
	mov r2, #3
	and r1, r3, r1
	bl G3C_TexPlttBase
	mov r1, #3
	str r1, [sp]
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	mov r2, #1
	str r2, [sp, #0xc]
	ldr r3, [r5, #0x390]
	rsb r0, r2, #0x80000
	and r0, r3, r0
	str r0, [sp, #0x10]
	add r0, r5, #0x398
	mov r3, r1
	bl G3C_TexImageParam
	add r0, r5, #0x398
	mov r1, #3
	bl G3C_MtxMode
	add r0, sp, #0x14
	bl MTX_Identity43_
	add r1, sp, #0x14
	add r0, r5, #0x398
	bl G3C_LoadMtx43
	add r0, r5, #0x398
	mov r1, #1
	bl G3C_MtxMode
	add r0, r5, #0x398
	mov r1, #3
	bl G3C_Begin
	ldr r1, _02170AD4 // =0x00007FFF
	add r0, r5, #0x398
	bl G3C_Color
	ldr r7, _02170AD8 // =0x021885DC
	ldr r4, _02170ADC // =0x021885BC
	mov r6, #0
_021709DC:
	add r0, r4, r6, lsl #3
	ldmia r0, {r1, r2}
	add r0, r5, #0x398
	bl G3C_TexCoord
	ldmia r7, {r1, r2}
	ldr r0, [r7, #8]
	mov r1, r1, lsl #7
	mov r3, r0, lsl #7
	mov r2, r2, lsl #7
	add r0, r5, #0x398
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, r3, asr #0x10
	bl G3C_Vtx
	add r6, r6, #1
	cmp r6, #4
	add r7, r7, #0xc
	blt _021709DC
	add r0, r5, #0x398
	bl G3C_End
	add r0, r5, #0x398
	bl G3_EndMakeDL
	ldr r0, [r5, #0x3ac]
	mov r1, #0x100
	bl DC_FlushRange
	ldr r1, _02170AE0 // =TruckLava3D__Draw_2170B24
	mov r0, #0x18
	str r1, [r5, #0xfc]
	str r5, [r5, #0x274]
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r3, #0x46
	str r3, [sp, #8]
	add r0, r5, #0x258
	sub r1, r3, #0x5e
	sub r2, r3, #0x86
	sub r3, r3, #0x8c
	bl ObjRect__SetBox3D
	ldrsb r0, [r8, #6]
	cmp r0, #0
	beq _02170A94
	add r0, r5, #0x258
	mov r1, #4
	mov r2, #0x40
	bl ObjRect__SetAttackStat
_02170A94:
	ldr r1, _02170AE4 // =0x0000FFFF
	add r0, r5, #0x258
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	ldr r1, [r5, #0x270]
	mov r0, r5
	orr r1, r1, #0x400
	str r1, [r5, #0x270]
	add sp, sp, #0x148
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02170ABC: .word StageTask_Main
_02170AC0: .word TruckLava3D__Destructor
_02170AC4: .word gameArchiveStage
_02170AC8: .word aActAcGmkTruckL
_02170ACC: .word aBpaGmkTruckLav
_02170AD0: .word 0x0001FFFF
_02170AD4: .word 0x00007FFF
_02170AD8: .word 0x021885DC
_02170ADC: .word 0x021885BC
_02170AE0: .word TruckLava3D__Draw_2170B24
_02170AE4: .word 0x0000FFFF
	arm_func_end TruckLava3D__Create

	arm_func_start TruckLava3D__Destructor
TruckLava3D__Destructor: // 0x02170AE8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x370
	bl ReleasePaletteAnimator
	ldr r0, [r4, #0x3ac]
	bl _FreeHEAP_SYSTEM
	ldr r0, [r4, #0x390]
	bl VRAMSystem__FreeTexture
	ldr r0, [r4, #0x394]
	bl VRAMSystem__FreePalette
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TruckLava3D__Destructor

	arm_func_start TruckLava3D__Draw_2170B24
TruckLava3D__Draw_2170B24: // 0x02170B24
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x48
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x11c]
	cmp r0, #0
	addeq sp, sp, #0x48
	ldmeqia sp!, {r4, pc}
	ldr r0, [r0, #0x18]
	tst r0, #0xc
	addne sp, sp, #0x48
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x370
	bl AnimatePalette
	add r0, r4, #0x370
	bl CheckPaletteAnimationIsValid
	cmp r0, #0
	beq _02170B74
	add r0, r4, #0x370
	bl DrawAnimatedPalette
_02170B74:
	ldr r0, _02170C88 // =0x021885B0
	add r3, sp, #0x3c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, _02170C8C // =g_obj
	ldr r2, [r0, #0x40]
	cmp r2, #0
	beq _02170BA4
	add r0, sp, #8
	add r1, sp, #4
	blx r2
	b _02170BB4
_02170BA4:
	ldr r1, [r0, #0x2c]
	str r1, [sp, #8]
	ldr r0, [r0, #0x30]
	str r0, [sp, #4]
_02170BB4:
	ldrh r1, [r4, #0x32]
	ldr r3, _02170C90 // =FX_SinCosTable_
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
	blx MTX_RotY33_
	ldr r2, [r4, #0x44]
	ldr r0, [sp, #8]
	ldr r1, [sp, #4]
	sub r0, r2, r0
	str r0, [sp, #0x30]
	ldr r2, [r4, #0x48]
	add r0, sp, #0x3c
	sub r1, r2, r1
	rsb r1, r1, #0
	str r1, [sp, #0x34]
	ldr r1, [r4, #0x4c]
	str r1, [sp, #0x38]
	bl NNS_G3dGlbSetBaseScale
	ldr r1, _02170C94 // =0x021472FC
	add r0, sp, #0xc
	bl MI_Copy36B
	ldr r1, _02170C98 // =NNS_G3dGlb
	add r0, sp, #0x30
	ldr r2, [r1, #0xfc]
	bic r2, r2, #0xa4
	str r2, [r1, #0xfc]
	bl NNS_G3dGlbSetBaseTrans
	mov r2, #1
	str r2, [sp]
	mov r0, #0x10
	add r1, sp, #0
	bl NNS_G3dGeBufferOP_N
	bl NNS_G3dGlbFlushP
	ldr r1, [r4, #0x398]
	ldr r0, [r4, #0x3a0]
	tst r1, #3
	ldrne r1, [r4, #0x39c]
	sub r1, r1, r0
	ldr r0, [r4, #0x3ac]
	bl NNS_G3dGeSendDL
	add sp, sp, #0x48
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170C88: .word 0x021885B0
_02170C8C: .word g_obj
_02170C90: .word FX_SinCosTable_
_02170C94: .word 0x021472FC
_02170C98: .word NNS_G3dGlb
	arm_func_end TruckLava3D__Draw_2170B24

	arm_func_start Truck3D__Destructor
Truck3D__Destructor: // 0x02170C9C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	str r0, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	add r0, r4, #0x3000
	ldr r0, [r0, #0xd58]
	bl _FreeHEAP_SYSTEM
	add r7, r4, #0x4e0
	mov r6, #0
_02170CCC:
	mov r0, r7
	bl AnimatorMDL__Release
	add r6, r6, #1
	cmp r6, #6
	add r7, r7, #0x144
	blt _02170CCC
	add r0, r4, #0x78
	add r0, r0, #0xc00
	bl AnimatorSprite3D__Release
	add r0, r4, #0x17c
	add r0, r0, #0xc00
	bl AnimatorSprite3D__Release
	add r0, r4, #0x15c
	add r0, r0, #0x3c00
	bl AnimatorSprite3D__Release
	add r0, r4, #0xe60
	add r1, r4, #0x3000
	mov r2, #0
	add r0, r0, #0x3000
	str r2, [r1, #0xf3c]
	bl AnimatorSprite3D__Release
	add r0, r4, #0x364
	add r0, r0, #0x3c00
	bl ReleasePaletteAnimator
	ldr r0, [r4, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end Truck3D__Destructor

	arm_func_start Truck3D__State_2170D44
Truck3D__State_2170D44: // 0x02170D44
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x354]
	ands r1, r0, #0x10
	bne _02170DA4
	ldr r0, [r4, #0xbc]
	cmp r0, #0
	ldreq r0, [r4, #0xc0]
	cmpeq r0, #0
	beq _02170DA4
	ldr r1, [r4, #0x354]
	mov r0, #0x61
	orr r1, r1, #0x10
	str r1, [r4, #0x354]
	mov r1, #0
	str r1, [sp]
	sub r1, r0, #0x62
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _02170DD8
_02170DA4:
	cmp r1, #0
	beq _02170DD8
	ldr r0, [r4, #0xbc]
	cmp r0, #0
	ldreq r0, [r4, #0xc0]
	cmpeq r0, #0
	bne _02170DD8
	ldr r0, [r4, #0x354]
	mov r1, #0
	bic r0, r0, #0x10
	str r0, [r4, #0x354]
	ldr r0, [r4, #0x138]
	bl NNS_SndPlayerStopSeq
_02170DD8:
	ldr r0, [r4, #0xc8]
	mov r1, #0x80
	bl ObjSpdDownSet
	str r0, [r4, #0xc8]
	ldr r0, [r4, #0x98]
	mov r1, #0x80
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
	ldr r0, [r4, #0xb0]
	cmp r0, #0
	movlt r0, #0
	strlt r0, [r4, #0xb0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end Truck3D__State_2170D44

	arm_func_start Truck3D__State_2170E10
Truck3D__State_2170E10: // 0x02170E10
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r4, r0
	bl Truck3D__Func_21711D8
	ldr r2, [r4, #0x1c]
	tst r2, #1
	bne _02170EC4
	orr r1, r2, #0x10
	orr r1, r1, #0x8000
	str r1, [r4, #0x1c]
	ldr r0, _0217105C // =Truck3D__State_2171064
	ldr r3, _02171060 // =FX_SinCosTable_
	str r0, [r4, #0xf4]
	ldrh r0, [r4, #0x34]
	ldr r2, [r4, #0xc8]
	mov r1, #0
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r0, [r3, r0]
	smull r5, r0, r2, r0
	adds r2, r5, #0x800
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [r4, #0x98]
	ldrh r0, [r4, #0x34]
	ldr r2, [r4, #0xc8]
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r0, [r3, r0]
	smull r3, r0, r2, r0
	adds r2, r3, #0x800
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [r4, #0x9c]
	ldr r0, [r4, #0x354]
	orr r0, r0, #4
	str r0, [r4, #0x354]
	ldr r0, [r4, #0x138]
	bl NNS_SndPlayerStopSeq
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02170EC4:
	ldr r1, [r4, #0x35c]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r1, #0x6d8]
	cmp r0, r4
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r1, #0x5d8]
	tst r0, #0x400
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r0, r1, #0x700
	ldrh r0, [r0, #0x22]
	tst r0, #3
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	orr r1, r2, #0x10
	orr r1, r1, #0x8000
	ldr r0, _0217105C // =Truck3D__State_2171064
	str r1, [r4, #0x1c]
	str r0, [r4, #0xf4]
	ldrh r1, [r4, #0x34]
	mov r6, #0x800
	mov r0, #0
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	ldr ip, _02171060 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	ldrsh r1, [ip, r1]
	ldr r2, [r4, #0xc8]
	sub r5, r0, #1
	smull r1, r0, r2, r1
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x98]
	ldrh r0, [r4, #0x34]
	ldr r3, [r4, #0xc8]
	sub lr, r6, #0x4800
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r2, [ip, r0]
	add r0, r4, #0x218
	mov r1, #2
	smull r7, r2, r3, r2
	adds r3, r7, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r4, #0x9c]
	ldrh r7, [r4, #0x34]
	ldr r3, [r4, #0x98]
	mov r2, #0x40
	mov r7, r7, asr #4
	mov r7, r7, lsl #2
	ldrsh r8, [ip, r7]
	mov r7, r8, asr #0x1f
	mov r7, r7, lsl #0xe
	adds r9, r6, r8, lsl #14
	orr r7, r7, r8, lsr #18
	adc r6, r7, #0
	mov r7, r9, lsr #0xc
	orr r7, r7, r6, lsl #20
	add r3, r3, r7
	str r3, [r4, #0x98]
	ldrh r6, [r4, #0x34]
	ldr r3, [r4, #0x9c]
	mov r6, r6, asr #4
	mov r6, r6, lsl #1
	add r6, r6, #1
	mov r6, r6, lsl #1
	ldrsh r6, [ip, r6]
	umull r7, ip, r6, lr
	mla ip, r6, r5, ip
	mov r5, r6, asr #0x1f
	mla ip, r5, lr, ip
	adds r6, r7, #0x800
	adc r5, ip, #0
	mov r6, r6, lsr #0xc
	orr r6, r6, r5, lsl #20
	add r3, r3, r6
	str r3, [r4, #0x9c]
	ldr r3, [r4, #0x354]
	bic r3, r3, #4
	str r3, [r4, #0x354]
	bl ObjRect__SetAttackStat
	ldr r0, [r4, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	str r0, [sp]
	mov r1, #2
	str r1, [sp, #4]
	sub r1, r1, #3
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0217105C: .word Truck3D__State_2171064
_02171060: .word FX_SinCosTable_
	arm_func_end Truck3D__State_2170E10

	arm_func_start Truck3D__State_2171064
Truck3D__State_2171064: // 0x02171064
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl Truck3D__Func_21711D8
	ldrh r0, [r4, #0x34]
	mov r1, #0
	mov r2, #0x200
	bl ObjRoopMove16
	strh r0, [r4, #0x34]
	ldr r1, [r4, #0x35c]
	cmp r1, #0
	beq _021710E0
	ldr r0, [r1, #0x6d8]
	cmp r0, r4
	bne _021710E0
	ldr r0, [r1, #0x5d8]
	tst r0, #0x400
	bne _021710E0
	ldr r0, [r4, #0x354]
	tst r0, #4
	bne _021710E0
	add r0, r1, #0x700
	ldrh r0, [r0, #0x22]
	tst r0, #3
	beq _021710E0
	mov r0, #0x400
	ldr r1, [r4, #0x9c]
	rsb r0, r0, #0
	cmp r1, r0
	addlt r0, r0, #0x3c0
	strlt r0, [r4, #0x9c]
_021710E0:
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	ldrgt r0, [r4, #0x354]
	orrgt r0, r0, #4
	strgt r0, [r4, #0x354]
	ldr r2, [r4, #0x1c]
	tst r2, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, _021711CC // =0xFFFF7FEF
	ldr r1, _021711D0 // =Truck3D__State_2170E10
	and r0, r2, r0
	str r0, [r4, #0x1c]
	str r1, [r4, #0xf4]
	ldr r0, [r4, #0x98]
	ldr r2, [r4, #0xc8]
	cmp r0, #0
	rsblt r1, r0, #0
	movge r1, r0
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r2, r1
	strlt r0, [r4, #0xc8]
	ldrh r1, [r4, #0x34]
	ldr r2, [r4, #0x98]
	ldr r0, _021711D4 // =FX_SinCosTable_
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	cmp r2, #0
	ldrsh r0, [r0, r1]
	rsblt r2, r2, #0
	smull r1, r0, r2, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	ldr r2, [r4, #0xc8]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	mov r1, #0
	str r0, [r4, #0xc8]
	str r1, [r4, #0x98]
	mov r2, r1
	str r1, [r4, #0x9c]
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r2, [r4, #0x230]
	mov r0, #0x62
	bic r2, r2, #4
	str r2, [r4, #0x230]
	mov r2, #0
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
_021711CC: .word 0xFFFF7FEF
_021711D0: .word Truck3D__State_2170E10
_021711D4: .word FX_SinCosTable_
	arm_func_end Truck3D__State_2171064

	arm_func_start Truck3D__Func_21711D8
Truck3D__Func_21711D8: // 0x021711D8
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r6, [r4, #0xc8]
	ldr r5, [r4, #0x98]
	mov r0, r6
	mov r1, #0x40
	bl ObjSpdDownSet
	str r0, [r4, #0xc8]
	ldr r0, [r4, #0x98]
	mov r1, #0x40
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
	cmp r6, #0x6000
	bge _02171224
	ldr r0, [r4, #0xc8]
	mov r1, #0x800
	mov r2, #0x9000
	bl ObjSpdUpSet
	str r0, [r4, #0xc8]
_02171224:
	cmp r6, #0x6000
	ble _0217123C
	ldr r0, [r4, #0xc8]
	cmp r0, #0x6000
	movlt r0, #0x6000
	strlt r0, [r4, #0xc8]
_0217123C:
	ldr r0, [r4, #0x1c]
	tst r0, #0x10
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r5, #0x6000
	bge _02171264
	ldr r0, [r4, #0x98]
	mov r1, #0x800
	mov r2, #0x9000
	bl ObjSpdUpSet
	str r0, [r4, #0x98]
_02171264:
	cmp r5, #0x6000
	ldmleia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #0x98]
	cmp r0, #0x6000
	movlt r0, #0x6000
	strlt r0, [r4, #0x98]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end Truck3D__Func_21711D8

	arm_func_start Truck3D__State_2171280
Truck3D__State_2171280: // 0x02171280
	ldrh r1, [r0, #0x34]
	add r1, r1, #0x800
	strh r1, [r0, #0x34]
	ldrh r1, [r0, #0x34]
	cmp r1, #0x2000
	ldrhs r1, [r0, #0x18]
	orrhs r1, r1, #4
	strhs r1, [r0, #0x18]
	bx lr
	arm_func_end Truck3D__State_2171280

	arm_func_start Truck3D__OnDefend_21712A4
Truck3D__OnDefend_21712A4: // 0x021712A4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, [r1, #0x1c]
	ldr r2, [r0, #0x1c]
	cmp r4, #0
	cmpne r2, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldrh r0, [r2]
	cmp r0, #3
	ldreq r0, [r2, #0x340]
	ldreqh r0, [r0, #2]
	cmpeq r0, #0xae
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	beq _0217132C
	ldr r1, [r0, #0x6d8]
	cmp r1, r4
	bne _0217132C
	ldr r1, [r0, #0x5d8]
	tst r1, #0x400
	bne _0217132C
	ldr r1, [r2, #0x340]
	ldrh r1, [r1, #4]
	tst r1, #1
	moveq r2, #1
	movne r2, #0
	mov r1, r4
	bl Player__Func_202178C
_0217132C:
	ldr r0, _02171364 // =Truck3D__State_2171280
	mov r1, #0
	str r0, [r4, #0xf4]
	ldr r0, [r4, #0x138]
	bl NNS_SndPlayerStopSeq
	mov r4, #0x63
	sub r1, r4, #0x64
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02171364: .word Truck3D__State_2171280
	arm_func_end Truck3D__OnDefend_21712A4

	arm_func_start Truck3D__State_2171368
Truck3D__State_2171368: // 0x02171368
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x28
	mov r4, r0
	ldr r1, [r4, #0x28]
	cmp r1, #5
	addls pc, pc, r1, lsl #2
	b _02171710
_02171384: // jump table
	b _0217139C // case 0
	b _0217143C // case 1
	b _02171498 // case 2
	b _0217150C // case 3
	b _021715D8 // case 4
	b _021716CC // case 5
_0217139C:
	ldr r0, [r4, #0x1c]
	tst r0, #1
	addne sp, sp, #0x28
	ldmneia sp!, {r3, r4, r5, pc}
	add r0, r1, #1
	str r0, [r4, #0x28]
	ldr r1, [r4, #0x1c]
	mov r0, #0
	bic r1, r1, #0x80
	str r1, [r4, #0x1c]
	str r0, [r4, #0x9c]
	ldr r1, [r4, #0x98]
	ldr r0, [r4, #0xc8]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r0, #0
	rsblt r2, r0, #0
	movge r2, r0
	cmp r2, r1
	strgt r0, [r4, #0x98]
	mov r0, #0
	str r0, [r4, #0xc8]
	ldr r1, [r4, #0x98]
	mov r0, #0xc0000
	str r1, [r4, #0x2c]
	ldr r1, [r4, #0x98]
	bl FX_Div
	mov r1, r0
	ldr r0, [r4, #0x98]
	bl FX_Div
	rsb r1, r0, #0
	str r1, [r4, #0xa4]
	ldr r0, [r4, #0x98]
	add r0, r0, r1
	str r0, [r4, #0x98]
	ldr r0, [r4, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, pc}
_0217143C:
	ldr r1, [r4, #0x2c]
	cmp r1, #0
	blt _02171454
	ldr r0, [r4, #0x98]
	cmp r0, #0
	ble _02171470
_02171454:
	cmp r1, #0
	addge sp, sp, #0x28
	ldmgeia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x98]
	cmp r0, #0
	addlt sp, sp, #0x28
	ldmltia sp!, {r3, r4, r5, pc}
_02171470:
	ldr r1, [r4, #0x28]
	mov r0, #0
	add r1, r1, #1
	str r1, [r4, #0x28]
	str r0, [r4, #0x98]
	str r0, [r4, #0xa4]
	mov r0, #0x1e
	add sp, sp, #0x28
	str r0, [r4, #0x2c]
	ldmia sp!, {r3, r4, r5, pc}
_02171498:
	ldr r0, [r4, #0x2c]
	subs r0, r0, #1
	addne sp, sp, #0x28
	str r0, [r4, #0x2c]
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x80
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	beq _021714F0
	ldr r1, [r0, #0x6d8]
	cmp r1, r4
	bne _021714F0
	ldr r1, [r0, #0x5d8]
	tst r1, #0x400
	bne _021714F0
	mov r1, r4
	bl Player__Func_2021A84
_021714F0:
	ldr r1, [r4, #0x20]
	mov r0, #0
	bic r1, r1, #0x200
	str r1, [r4, #0x20]
	add sp, sp, #0x28
	str r0, [r4, #0x2c]
	ldmia sp!, {r3, r4, r5, pc}
_0217150C:
	ldr r0, [r4, #0x2c]
	add r0, r0, #0x800
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x4c]
	add r0, r0, #0xcc
	add r0, r0, #0xc00
	str r0, [r4, #0x4c]
	cmp r0, #0x30000
	movge r0, #0x30000
	strge r0, [r4, #0x4c]
	ldr r0, [r4, #0x2c]
	cmp r0, #0x2c000
	blt _021715C8
	ldr r0, [r4, #0x28]
	mov ip, #0x2c000
	add r0, r0, #1
	str r0, [r4, #0x28]
	mov r0, #1
	mov r1, #0
	mov r2, #3
	mov r3, #0x400
	str ip, [r4, #0x2c]
	bl G3X_SetFog
	mov r2, #0
	ldr r0, _02171718 // =0x04000358
	mov r1, #0x1f0000
	str r1, [r0]
	mov r3, r2
	mov ip, #4
	mov lr, #8
	mov r5, #0xc
	add r0, sp, #8
_0217158C:
	strb r3, [r0, r2, lsl #2]
	add r1, r0, r2, lsl #2
	strb ip, [r1, #1]
	strb lr, [r1, #2]
	add r2, r2, #1
	strb r5, [r1, #3]
	cmp r2, #8
	add r3, r3, #0x10
	add ip, ip, #0x10
	add lr, lr, #0x10
	add r5, r5, #0x10
	blt _0217158C
	mov r1, #0x7f
	strb r1, [sp, #0x27]
	bl G3X_SetFogTable
_021715C8:
	ldr r0, [r4, #0x2c]
	add sp, sp, #0x28
	strh r0, [r4, #0x32]
	ldmia sp!, {r3, r4, r5, pc}
_021715D8:
	ldr r0, [r4, #0xfc]
	cmp r0, #0
	bne _02171634
	ldr r1, [r4, #0xe80]
	mvn r0, #0x80000000
	cmp r1, r0
	beq _02171634
	ldr r0, [r4, #0x20]
	mov r2, #0
	orr r1, r0, #0x40
	ldr r0, _0217171C // =Truck3D__Draw_21724F4
	str r1, [r4, #0x20]
	str r0, [r4, #0xfc]
	ldr r1, [r4, #0xe80]
	add r0, r4, #0x3000
	str r1, [r0, #0xd28]
	str r2, [r0, #0xd2c]
	str r2, [r0, #0xd24]
	ldr r1, [r4, #0x44]
	str r1, [r0, #0xd38]
	ldr r1, [r4, #0xe80]
	str r1, [r0, #0xd3c]
	str r2, [r0, #0xd40]
_02171634:
	ldr r0, [r4, #0xe80]
	ldr r1, [r4, #0x48]
	sub r0, r0, #0x15000
	cmp r1, r0
	addlt sp, sp, #0x28
	ldmltia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x28]
	mov r1, #0
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldr r2, [r4, #0xe80]
	mov r0, #8
	sub r2, r2, #0x15000
	str r2, [r4, #0x48]
	ldr r2, [r4, #0x1c]
	bic r2, r2, #0x80
	orr r2, r2, #0x2000
	str r2, [r4, #0x1c]
	str r1, [r4, #0x9c]
	bl ShakeScreen
	mov r0, #8
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	addeq sp, sp, #0x28
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r0, #0x6d8]
	cmp r1, r4
	addne sp, sp, #0x28
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [r0, #0x5d8]
	tst r1, #0x400
	addne sp, sp, #0x28
	ldmneia sp!, {r3, r4, r5, pc}
	mov r1, r4
	bl Player__Func_2021AE8
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, pc}
_021716CC:
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	cmp r0, #0
	addgt sp, sp, #0x28
	str r0, [r4, #0x2c]
	ldmgtia sp!, {r3, r4, r5, pc}
	ldr r1, _02171720 // =Truck3D__State_2171724
	mov r0, #0x64
	str r1, [r4, #0xf4]
	mov r1, #0
	str r1, [sp]
	sub r1, r0, #0x65
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02171710:
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02171718: .word 0x04000358
_0217171C: .word Truck3D__Draw_21724F4
_02171720: .word Truck3D__State_2171724
	arm_func_end Truck3D__State_2171368

	arm_func_start Truck3D__State_2171724
Truck3D__State_2171724: // 0x02171724
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r5, r0
	add r0, r5, #0x3000
	ldr r1, [r0, #0xd08]
	cmp r1, #0xa00
	bge _02171754
	add r1, r1, #0x20
	str r1, [r0, #0xd08]
	cmp r1, #0xa00
	movge r1, #0xa00
	strge r1, [r0, #0xd08]
_02171754:
	add r0, r5, #0x44
	add r3, r5, #0x8c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r5, #0x3000
	ldr r1, [r5, #0x44]
	ldr r0, [r0, #0xd08]
	add r0, r1, r0
	str r0, [r5, #0x44]
	ldr r2, [r5, #0x354]
	tst r2, #8
	beq _02171808
	ldr r0, _02171F84 // =g_obj
	ldr r1, [r5, #0xd8]
	ldr r0, [r0, #0x10]
	ldr r3, [r5, #0x9c]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r1, r3, r1
	str r1, [r5, #0x9c]
	ldr r0, [r5, #0xdc]
	cmp r1, r0
	strgt r0, [r5, #0x9c]
	ldr r1, [r5, #0x48]
	ldr r0, [r5, #0x9c]
	add r1, r1, r0
	str r1, [r5, #0x48]
	ldr r0, [r5, #0xe80]
	sub r0, r0, #0x15000
	cmp r1, r0
	blt _02171878
	str r0, [r5, #0x48]
	ldr r1, [r5, #0x354]
	mov r0, #0
	bic r1, r1, #8
	str r1, [r5, #0x354]
	str r0, [r5, #0x9c]
	bl GetSfxVolume
	mov r1, r0
	ldr r0, [r5, #0x138]
	bl NNS_SndPlayerSetVolume
	b _02171878
_02171808:
	ldr r1, [r5, #0x35c]
	cmp r1, #0
	beq _02171878
	ldr r0, [r1, #0x6d8]
	cmp r0, r5
	bne _02171878
	ldr r0, [r1, #0x5d8]
	tst r0, #0x400
	bne _02171878
	add r0, r1, #0x700
	ldrh r0, [r0, #0x22]
	tst r0, #3
	beq _02171878
	orr r1, r2, #8
	mov r0, #0x4000
	str r1, [r5, #0x354]
	rsb r0, r0, #0
	str r0, [r5, #0x9c]
	ldr r0, [r5, #0x138]
	mov r1, #0
	bl NNS_SndPlayerSetVolume
	mov r4, #2
	sub r1, r4, #3
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
_02171878:
	ldr r2, [r5, #0x44]
	ldr r1, [r5, #0x8c]
	add r0, r5, #0x10c
	sub r1, r2, r1
	str r1, [r5, #0xbc]
	ldr r3, [r5, #0x48]
	ldr r1, [r5, #0x90]
	add r2, r5, #0x3000
	sub r1, r3, r1
	str r1, [r5, #0xc0]
	ldr r4, [r5, #0x4c]
	ldr r1, [r5, #0x94]
	mov r3, #0
	sub r1, r4, r1
	str r1, [r5, #0xc4]
	ldr r4, [r2, #0xd08]
	mov r1, #0x9600
	umull r7, r6, r4, r1
	mla r6, r4, r3, r6
	mov r4, r4, asr #0x1f
	adds r7, r7, #0x800
	mla r6, r4, r1, r6
	adc r1, r6, #0
	mov r4, r7, lsr #0xc
	ldr r6, [r2, #0xd0c]
	orr r4, r4, r1, lsl #20
	add r1, r6, r4
	str r1, [r2, #0xd0c]
	ldr r1, [r5, #0x44]
	add r0, r0, #0x3c00
	str r1, [r2, #0xd38]
	ldr r1, [r2, #0xd0c]
	cmp r1, #0x12c000
	ble _02171AC8
	add r2, r5, #0x3d00
	ldrsh r4, [r2, #4]
	ldrsh r1, [r2, #6]
	add r4, r4, #1
	and r4, r4, #7
	cmp r4, r1
	beq _02171AC8
	ldr r4, [r0]
	add r1, r5, #0x284
	sub r4, r4, #0x12c000
	str r4, [r0]
	ldrsh r2, [r2, #4]
	add r1, r1, #0xc00
	mov r0, #0x5d0
	smlabb r4, r2, r0, r1
	mov r0, r4
	strb r3, [r4, #0xae]
	bl Truck3D__Func_216FB6C
	add r1, r5, #0x3d00
	ldrsh r3, [r1, #4]
	add r0, r5, #0x284
	mov r2, #0x5d0
	add r3, r3, #1
	and r3, r3, #7
	strh r3, [r1, #4]
	ldrsh r1, [r1, #4]
	add r3, r0, #0xc00
	smulbb r1, r1, r2
	ldrb r0, [r3, r1]
	add r6, r3, r1
	cmp r0, #3
	blo _021719A4
	cmp r0, #5
	bhi _021719A4
	mov r7, #0x65
	sub r1, r7, #0x66
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r7}
	bl PlaySfxEx
_021719A4:
	ldrsb r1, [r6, #0xb0]
	mvn r0, #0
	cmp r1, r0
	bne _021719D8
	mov r2, #1
	strb r2, [r6, #0xb0]
	add r0, r5, #0x3d00
	ldrsh r1, [r0, #4]
	mov r0, #0x5d0
	add r1, r1, #1
	and r1, r1, #7
	smlabb r0, r1, r0, r5
	strb r2, [r0, #0xf33]
_021719D8:
	ldrsb r2, [r4, #0xb0]
	mov r0, #0xc
	add r1, r5, #0x124
	mla r0, r2, r0, r6
	add r0, r0, #0x78
	add r3, r1, #0x3c00
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldrsb r2, [r4, #0xb0]
	mov r0, #6
	add r1, r5, #0x3d00
	mla r8, r2, r0, r6
	ldrh r7, [r8, #0x9c]
	ldrh r3, [r8, #0x9e]
	mov r2, #1
	mov r0, r6
	strh r7, [r1, #0x30]
	strh r3, [r1, #0x32]
	ldrh r3, [r8, #0xa0]
	strh r3, [r1, #0x34]
	ldrh r7, [r1, #0x30]
	ldrh r3, [r1, #0x32]
	strh r7, [r1, #0x1c]
	strh r3, [r1, #0x1e]
	ldrh r3, [r1, #0x34]
	strh r3, [r1, #0x20]
	ldrsb r1, [r4, #0xb0]
	ldrb r3, [r6, #0xae]
	mov r1, r2, lsl r1
	and r1, r1, #0xff
	and r1, r3, r1
	strb r1, [r6, #0xae]
	bl Truck3D__Func_216FB6C
	add r0, r5, #0x3d00
	ldrsh r1, [r0, #0x36]
	ldrsh r0, [r0, #4]
	cmp r1, r0
	bne _02171AC8
	ldr r1, _02171F88 // =Truck3D__State_2171F98
	add r0, r5, #0x3000
	str r1, [r5, #0xf4]
	mov r1, #0
	str r1, [r0, #0xd08]
	str r1, [r5, #0x28]
	ldr r2, [r5, #0x35c]
	cmp r2, #0
	beq _02171AC8
	ldr r0, [r2, #0x6d8]
	cmp r0, r5
	bne _02171AC8
	ldr r0, [r2, #0x5d8]
	tst r0, #0x400
	bne _02171AC8
	ldr r0, [r2, #0x5dc]
	mov r1, #0x40
	orr r0, r0, #0x20
	str r0, [r2, #0x5dc]
	ldr r0, [r5, #0x35c]
	add r0, r0, #0x600
	strh r1, [r0, #0xde]
_02171AC8:
	add r0, r5, #0x3d00
	ldrsh r1, [r0, #4]
	add r0, r5, #0x284
	add r2, r0, #0xc00
	mov r0, #0x5d0
	smlabb r4, r1, r0, r2
	ldrsb r0, [r4, #0xb0]
	cmp r0, #1
	add r0, r5, #0x3000
	bne _02171B04
	mov r1, #0
	str r1, [r0, #0xd10]
	ldr r1, [r0, #0xd0c]
	str r1, [r0, #0xd18]
	b _02171C40
_02171B04:
	ldr r0, [r0, #0xd0c]
	mov r1, #0x12c000
	bl FX_Div
	ldrsb r1, [r4, #0xb0]
	mov r0, r0, lsl #0x12
	mov r3, r0, lsr #0x10
	cmp r1, #2
	ldrne r6, _02171F8C // =0xFFF40EAD
	bne _02171B38
	rsb r0, r3, #0x10000
	mov r0, r0, lsl #0x10
	ldr r6, _02171F90 // =0x000BF153
	mov r3, r0, lsr #0x10
_02171B38:
	add r0, r5, #0x3d00
	ldrh r2, [r0, #0x32]
	ldr r1, _02171F94 // =FX_SinCosTable_
	add r8, r5, #0x3000
	add r2, r2, r3
	strh r2, [r0, #0x1e]
	ldrh r3, [r0, #0x32]
	ldr r2, [r8, #0xd24]
	ldr r0, [r8, #0xd2c]
	sub r7, r3, #0x4000
	mov r7, r7, lsl #0x10
	mov r7, r7, lsr #0x10
	mov r7, r7, lsl #0x10
	mov r7, r7, lsr #0x10
	mov r7, r7, asr #4
	mov r9, r7, lsl #1
	add r7, r9, #1
	mov r9, r9, lsl #1
	mov r7, r7, lsl #1
	ldrsh r9, [r1, r9]
	ldrsh r7, [r1, r7]
	smull r1, ip, r6, r9
	adds r1, r1, #0x800
	smull r9, r7, r6, r7
	adc ip, ip, #0
	adds r6, r9, #0x800
	mov r9, r1, lsr #0xc
	adc r1, r7, #0
	mov r6, r6, lsr #0xc
	orr r9, r9, ip, lsl #20
	orr r6, r6, r1, lsl #20
	cmp r3, #0x8000
	add r1, r2, r9
	add r6, r0, r6
	bne _02171BDC
	sub r0, r1, r2
	str r0, [r8, #0xd10]
	ldr r0, [r8, #0xd2c]
	sub r0, r6, r0
	str r0, [r8, #0xd18]
	b _02171C40
_02171BDC:
	cmp r3, #0xc000
	bne _02171C00
	sub r0, r6, r0
	rsb r0, r0, #0
	str r0, [r8, #0xd10]
	ldr r0, [r8, #0xd24]
	sub r0, r1, r0
	str r0, [r8, #0xd18]
	b _02171C40
_02171C00:
	cmp r3, #0
	bne _02171C28
	sub r0, r1, r2
	rsb r0, r0, #0
	str r0, [r8, #0xd10]
	ldr r0, [r8, #0xd2c]
	sub r0, r6, r0
	rsb r0, r0, #0
	str r0, [r8, #0xd18]
	b _02171C40
_02171C28:
	sub r0, r6, r0
	str r0, [r8, #0xd10]
	ldr r0, [r8, #0xd24]
	sub r0, r1, r0
	rsb r0, r0, #0
	str r0, [r8, #0xd18]
_02171C40:
	add r0, r5, #0x3d00
	ldrsh r1, [r0, #4]
	ldrsh r0, [r0, #6]
	add r1, r1, #1
	and r3, r1, #7
	cmp r3, r0
	beq _02171E00
	add r0, r5, #0x284
	add r1, r0, #0xc00
	mov r0, #0x5d0
	smlabb r7, r3, r0, r1
	ldrsb r2, [r7, #0xb0]
	mov r0, r3, lsl #0x10
	mvn r1, #0
	cmp r2, r1
	mov r0, r0, asr #0x10
	bne _02171E00
	ldrb r2, [r7]
	cmp r2, #3
	blo _02171CF8
	add r1, r5, #0x3000
	ldr r1, [r1, #0xd0c]
	cmp r1, #0x96000
	blt _02171D2C
	ldr r1, [r5, #0x35c]
	add r1, r1, #0x700
	ldrh r1, [r1, #0x20]
	tst r1, #0x20
	beq _02171CD8
	cmp r2, #2
	beq _02171CCC
	add r1, r2, #0xfc
	and r1, r1, #0xff
	cmp r1, #1
	bhi _02171D2C
_02171CCC:
	mov r1, #0
	strb r1, [r7, #0xb0]
	b _02171D2C
_02171CD8:
	tst r1, #0x10
	beq _02171D2C
	cmp r2, #1
	cmpne r2, #3
	cmpne r2, #5
	moveq r1, #2
	streqb r1, [r7, #0xb0]
	b _02171D2C
_02171CF8:
	cmp r2, #0
	beq _02171D18
	cmp r2, #1
	beq _02171D24
	cmp r2, #2
	moveq r1, #0
	streqb r1, [r7, #0xb0]
	b _02171D2C
_02171D18:
	mov r1, #1
	strb r1, [r7, #0xb0]
	b _02171D2C
_02171D24:
	mov r1, #2
	strb r1, [r7, #0xb0]
_02171D2C:
	add r0, r0, #1
	add r1, r5, #0x3d00
	and r8, r0, #7
	ldrsh r0, [r1, #6]
	cmp r8, r0
	beq _02171DD8
	mov r0, #0x5d0
	mul r9, r8, r0
	add r0, r5, r9
	ldrb r0, [r0, #0xf32]
	cmp r0, #0
	bne _02171DD8
	add r0, r5, #0x284
	add r6, r0, #0xc00
	mov r1, r7
	add r0, r6, r9
	bl Truck3D__Func_2173304
	add r0, r5, #0x3d00
	ldrsh r1, [r0, #0x36]
	mvn r0, #0
	cmp r1, r0
	beq _02171DCC
	add r0, r1, #1
	cmp r8, r0
	bne _02171DCC
	add r0, r5, #0xe8
	add r3, r0, #0x1000
	ldrh r2, [r3, r9]
	add r0, r5, #0x29c
	add r1, r5, #0x450
	bic r2, r2, #0xc
	strh r2, [r3, r9]
	add r2, r0, #0x1000
	ldrh r0, [r2, r9]
	add r1, r1, #0x1000
	bic r0, r0, #0xc
	strh r0, [r2, r9]
	ldrh r0, [r1, r9]
	bic r0, r0, #0xc
	strh r0, [r1, r9]
_02171DCC:
	mov r0, r5
	add r1, r6, r9
	bl Truck3D__Func_216F760
_02171DD8:
	ldrsb r1, [r7, #0xb0]
	mvn r0, #0
	cmp r1, r0
	addne r0, r5, #0x3d00
	ldrnesh r0, [r0, #6]
	cmpne r8, r0
	beq _02171E00
	mov r0, #0x5d0
	smlabb r0, r8, r0, r5
	strb r1, [r0, #0xf33]
_02171E00:
	ldr r0, [r5, #0x354]
	tst r0, #8
	bne _02171E30
	ldr r0, [r5, #0x35c]
	cmp r0, #0
	beq _02171E30
	ldr r1, [r0, #0x6d8]
	cmp r1, r5
	bne _02171E30
	ldr r1, [r0, #0x5d8]
	tst r1, #0x400
	beq _02171E4C
_02171E30:
	ldrh r0, [r5, #0x34]
	mov r1, #0
	mov r2, #0x80
	bl ObjRoopMove16
	add sp, sp, #8
	strh r0, [r5, #0x34]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02171E4C:
	ldrsb r1, [r4, #0xb0]
	cmp r1, #1
	bne _02171F4C
	add r1, r5, #0x3d00
	ldrsh r2, [r1, #4]
	ldrsh r1, [r1, #6]
	add r2, r2, #1
	and r2, r2, #7
	cmp r2, r1
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r1, #0x5d0
	mla r1, r2, r1, r5
	add r1, r1, #0xf00
	ldrsb r2, [r1, #0x34]
	cmp r2, #1
	mvnne r1, #0
	cmpne r2, r1
	bne _02171F00
	add r0, r0, #0x700
	ldrh r0, [r0, #0x20]
	tst r0, #0x20
	beq _02171EC4
	ldrh r0, [r5, #0x34]
	mov r1, #0xfa00
	mov r2, #0x40
	bl ObjRoopMove16
	add sp, sp, #8
	strh r0, [r5, #0x34]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02171EC4:
	tst r0, #0x10
	ldrh r0, [r5, #0x34]
	beq _02171EE8
	mov r1, #0x600
	mov r2, #0x40
	bl ObjRoopMove16
	add sp, sp, #8
	strh r0, [r5, #0x34]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02171EE8:
	mov r1, #0
	mov r2, #0x80
	bl ObjRoopMove16
	add sp, sp, #8
	strh r0, [r5, #0x34]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02171F00:
	cmp r2, #0
	bne _02171F24
	ldrh r0, [r5, #0x34]
	mov r1, #0xfa00
	mov r2, #0x40
	bl ObjRoopMove16
	add sp, sp, #8
	strh r0, [r5, #0x34]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02171F24:
	cmp r2, #2
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldrh r0, [r5, #0x34]
	mov r1, #0x600
	mov r2, #0x40
	bl ObjRoopMove16
	add sp, sp, #8
	strh r0, [r5, #0x34]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02171F4C:
	cmp r1, #0
	ldrh r0, [r5, #0x34]
	mov r2, #0x80
	bne _02171F70
	mov r1, #0xf600
	bl ObjRoopMove16
	add sp, sp, #8
	strh r0, [r5, #0x34]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02171F70:
	mov r1, #0xa00
	bl ObjRoopMove16
	strh r0, [r5, #0x34]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02171F84: .word g_obj
_02171F88: .word Truck3D__State_2171F98
_02171F8C: .word 0xFFF40EAD
_02171F90: .word 0x000BF153
_02171F94: .word FX_SinCosTable_
	arm_func_end Truck3D__State_2171724

	arm_func_start Truck3D__State_2171F98
Truck3D__State_2171F98: // 0x02171F98
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x44
	add r3, r4, #0x8c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r4, #0x3000
	ldr r1, [r4, #0x44]
	ldr r0, [r0, #0xd08]
	add r0, r1, r0
	str r0, [r4, #0x44]
	ldr r0, [r4, #0x354]
	tst r0, #8
	beq _02172054
	ldr r0, _021724D8 // =g_obj
	ldr r1, [r4, #0xd8]
	ldr r0, [r0, #0x10]
	ldr r3, [r4, #0x9c]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r1, r3, r1
	str r1, [r4, #0x9c]
	ldr r0, [r4, #0xdc]
	cmp r1, r0
	strgt r0, [r4, #0x9c]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x9c]
	add r1, r1, r0
	str r1, [r4, #0x48]
	ldr r0, [r4, #0xe80]
	sub r0, r0, #0x15000
	cmp r1, r0
	blt _02172054
	str r0, [r4, #0x48]
	ldr r1, [r4, #0x354]
	mov r0, #0
	bic r1, r1, #8
	str r1, [r4, #0x354]
	str r0, [r4, #0x9c]
	bl GetSfxVolume
	mov r1, r0
	ldr r0, [r4, #0x138]
	bl NNS_SndPlayerSetVolume
_02172054:
	ldr r2, [r4, #0x44]
	ldr r0, [r4, #0x8c]
	add r1, r4, #0x3000
	sub r0, r2, r0
	str r0, [r4, #0xbc]
	ldr r2, [r4, #0x48]
	ldr r0, [r4, #0x90]
	sub r0, r2, r0
	str r0, [r4, #0xc0]
	ldr r2, [r4, #0x4c]
	ldr r0, [r4, #0x94]
	sub r0, r2, r0
	str r0, [r4, #0xc4]
	ldr r0, [r1, #0xd0c]
	add r0, r0, #0x1dc0
	add r0, r0, #0x4000
	str r0, [r1, #0xd0c]
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _021720B4
	cmp r0, #1
	beq _02172348
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_021720B4:
	ldr r1, [r4, #0x4c]
	cmp r1, #0
	beq _021720D8
	ldr r0, _021724DC // =0xFFFFF334
	add r0, r1, r0
	str r0, [r4, #0x4c]
	cmp r0, #0
	movle r0, #0
	strle r0, [r4, #0x4c]
_021720D8:
	ldrh r0, [r4, #0x34]
	mov r1, #0
	mov r2, #0x100
	bl ObjRoopMove16
	add r3, r4, #0x3000
	strh r0, [r4, #0x34]
	ldr r0, [r3, #0xd0c]
	cmp r0, #0x12c000
	ble _02172180
	sub r0, r0, #0x12c000
	str r0, [r3, #0xd0c]
	add r0, r4, #0x3d00
	ldrsh r5, [r0, #4]
	mov r0, #0x5d0
	add r2, r4, #0x124
	smlabb r1, r5, r0, r4
	add r5, r5, #1
	add r1, r1, #0xf00
	and r5, r5, #7
	smlabb r5, r5, r0, r4
	ldrsb r1, [r1, #0x34]
	mov r0, #0xc
	add sp, sp, #8
	mla r0, r1, r0, r5
	add r0, r0, #0x2fc
	add r0, r0, #0xc00
	add r5, r2, #0x3c00
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldr r1, _021724E0 // =0x00005DC0
	mov r0, #1
	str r1, [r3, #0xd08]
	strh r0, [r4, #0x32]
	ldr r1, [r4, #0x28]
	mov r0, #0
	add r1, r1, #1
	str r1, [r4, #0x28]
	ldr r1, [r3, #0xd0c]
	rsb r1, r1, #0
	str r1, [r3, #0xd10]
	str r0, [r3, #0xd18]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02172180:
	mov r1, #0x12c000
	bl FX_Div
	mov r0, r0, lsl #0x12
	mov r0, r0, lsr #0x10
	add r1, r0, #0xc000
	rsb r0, r0, #0x10000
	mov r3, r0, lsl #0x10
	strh r1, [r4, #0x32]
	add r0, r4, #0x3d00
	ldrh r2, [r0, #0x32]
	ldr r1, _021724E4 // =FX_SinCosTable_
	ldr ip, _021724E8 // =0x000BF153
	add r0, r2, r3, lsr #16
	sub r0, r0, #0x4000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r5, r0, lsl #1
	mov r0, r5, lsl #1
	ldrsh r7, [r1, r0]
	add r0, r5, #1
	mov r0, r0, lsl #1
	ldrsh r5, [r1, r0]
	umull r0, r8, r7, ip
	mov lr, #0
	umull r1, r6, r5, ip
	adds r9, r0, #0x800
	mla r8, r7, lr, r8
	mov r0, r7, asr #0x1f
	mla r8, r0, ip, r8
	adc r0, r8, #0
	adds r7, r1, #0x800
	mov r1, r9, lsr #0xc
	mla r6, r5, lr, r6
	mov r5, r5, asr #0x1f
	mla r6, r5, ip, r6
	adc r5, r6, #0
	mov r6, r7, lsr #0xc
	cmp r2, #0x8000
	mov r3, r3, lsr #0x10
	orr r1, r1, r0, lsl #20
	orr r6, r6, r5, lsl #20
	bne _02172244
	add r0, r4, #0x3000
	str r1, [r0, #0xd10]
	str r6, [r0, #0xd18]
	b _02172290
_02172244:
	cmp r2, #0xc000
	bne _02172260
	rsb r2, r6, #0
	add r0, r4, #0x3000
	str r2, [r0, #0xd10]
	str r1, [r0, #0xd18]
	b _02172290
_02172260:
	cmp r2, #0
	bne _02172280
	rsb r1, r1, #0
	add r0, r4, #0x3000
	str r1, [r0, #0xd10]
	rsb r1, r6, #0
	str r1, [r0, #0xd18]
	b _02172290
_02172280:
	add r0, r4, #0x3000
	str r6, [r0, #0xd10]
	rsb r1, r1, #0
	str r1, [r0, #0xd18]
_02172290:
	ldr r0, _021724EC // =0x00003FFF
	rsb r1, r3, #0x10000
	and r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r5, r0, lsl #1
	ldr r2, _021724E4 // =FX_SinCosTable_
	mov r0, r5, lsl #1
	ldrsh r3, [r2, r0]
	add r0, r5, #1
	mov r0, r0, lsl #1
	ldrsh ip, [r2, r0]
	ldr r1, _021724E8 // =0x000BF153
	mov r2, #0
	umull r0, r6, r3, r1
	umull r5, lr, ip, r1
	adds r7, r0, #0x800
	mla r6, r3, r2, r6
	mla lr, ip, r2, lr
	mov r0, r3, asr #0x1f
	mla r6, r0, r1, r6
	mov r2, ip, asr #0x1f
	adc r3, r6, #0
	mov r0, r7, lsr #0xc
	orr r0, r0, r3, lsl #20
	add r3, r4, #0x3000
	str r0, [r3, #0xd38]
	adds r5, r5, #0x800
	mla lr, r2, r1, lr
	mov r6, r0, asr #2
	ldr r4, [r4, #0x44]
	add r0, r6, r0, lsl #1
	sub r4, r4, r0
	adc r2, lr, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r2, lsl #20
	rsb r0, r1, #0
	add r0, r5, r0
	str r4, [r3, #0xd38]
	rsb r0, r0, #0
	add sp, sp, #8
	str r0, [r3, #0xd40]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02172348:
	ldr r2, [r1, #0xd0c]
	mov r0, #0
	rsb r2, r2, #0
	str r2, [r1, #0xd10]
	str r0, [r1, #0xd18]
	ldr r1, [r4, #0x35c]
	cmp r1, #0
	beq _021723C0
	ldr r0, [r1, #0x6d8]
	cmp r0, r4
	bne _021723C0
	ldr r0, [r1, #0x5d8]
	tst r0, #0x400
	bne _021723C0
	add r0, r1, #0x600
	ldrsh r1, [r0, #0xde]
	cmp r1, #0
	subgt r1, r1, #2
	strgth r1, [r0, #0xde]
	ldr r0, [r4, #0x35c]
	add r0, r0, #0x600
	ldrsh r1, [r0, #0xde]
	cmp r1, #0
	bgt _021723C0
	mov r1, #0
	strh r1, [r0, #0xde]
	ldr r1, [r4, #0x35c]
	ldr r0, [r1, #0x5dc]
	bic r0, r0, #0x20
	str r0, [r1, #0x5dc]
_021723C0:
	ldr r1, [r4, #0x4c]
	cmp r1, #0
	beq _02172420
	ldr r0, _021724DC // =0xFFFFF334
	add r0, r1, r0
	str r0, [r4, #0x4c]
	cmp r0, #0
	bgt _02172420
	mov r0, #0
	str r0, [r4, #0x4c]
	ldr r1, [r4, #0x35c]
	cmp r1, #0
	beq _02172414
	ldr r0, [r1, #0x6d8]
	cmp r0, r4
	bne _02172414
	ldr r0, [r1, #0x5d8]
	tst r0, #0x400
	ldreq r0, [r1, #0x20]
	orreq r0, r0, #0x200
	streq r0, [r1, #0x20]
_02172414:
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x200
	str r0, [r4, #0x20]
_02172420:
	add r0, r4, #0x3000
	ldr r1, [r0, #0xd0c]
	cmp r1, #0x1ac000
	addle sp, sp, #8
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r1, [r4, #0x18]
	mov r3, #0
	orr r1, r1, #1
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x354]
	ldr r2, _021724F0 // =Truck3D__State_2170E10
	bic r1, r1, #2
	str r1, [r4, #0x354]
	ldr ip, [r4, #0x1c]
	mov r1, r4
	orr ip, ip, #0x80
	bic ip, ip, #0x2000
	str ip, [r4, #0x1c]
	ldr r0, [r0, #0xd08]
	str r0, [r4, #0xc8]
	str r3, [r4, #0x9c]
	strh r3, [r4, #0x32]
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x40
	str r0, [r4, #0x20]
	str r3, [r4, #0xfc]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x200
	str r0, [r4, #0x20]
	str r2, [r4, #0xf4]
	ldr r0, [r4, #0x35c]
	bl Player__Func_2021B44
	ldr r0, [r4, #0x138]
	mov r1, #0
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
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_021724D8: .word g_obj
_021724DC: .word 0xFFFFF334
_021724E0: .word 0x00005DC0
_021724E4: .word FX_SinCosTable_
_021724E8: .word 0x000BF153
_021724EC: .word 0x00003FFF
_021724F0: .word Truck3D__State_2170E10
	arm_func_end Truck3D__State_2171F98

	arm_func_start Truck3D__Draw_21724F4
Truck3D__Draw_21724F4: // 0x021724F4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x150
	bl GetCurrentTaskWork_
	ldr r2, _0217300C // =0x00012100
	add r4, sp, #0x8c
	mov r3, #0
	ldr r1, _02173010 // =g_obj
	strh r3, [r4]
	strh r3, [r4, #2]
	strh r3, [r4, #4]
	str r2, [sp, #0x88]
	ldr r2, [r1, #0x40]
	str r0, [sp, #0x5c]
	cmp r2, #0
	beq _02172540
	add r0, sp, #0x98
	add r1, sp, #0x94
	blx r2
	b _02172550
_02172540:
	ldr r0, [r1, #0x2c]
	str r0, [sp, #0x98]
	ldr r0, [r1, #0x30]
	str r0, [sp, #0x94]
_02172550:
	ldr r0, [sp, #0x5c]
	ldr r2, _02173014 // =0x00003FFF
	add r1, r0, #0x3d00
	ldrsh r0, [r1, #4]
	str r0, [sp, #0x54]
	ldr r0, [sp, #0x5c]
	ldrh r3, [r1, #0x1e]
	add r0, r0, #0x284
	add r4, r0, #0xc00
	ldr r0, [sp, #0x54]
	mov r1, #0x5d0
	smlabb r0, r0, r1, r4
	str r0, [sp, #0x58]
	tst r3, r2
	bne _021725A0
	ldr r0, [sp, #0x5c]
	ldr r1, [r0, #0xf4]
	ldr r0, _02173018 // =Truck3D__State_2171F98
	cmp r1, r0
	bne _0217263C
_021725A0:
	ldr r0, [sp, #0x58]
	ldr r3, _0217301C // =FX_SinCosTable_
	ldrsb r0, [r0, #0xb0]
	cmp r0, #2
	ldr r0, [sp, #0x5c]
	ldreq r1, _02173020 // =0x000BF153
	add r0, r0, #0x3d00
	ldrh r4, [r0, #0x32]
	ldr r0, [sp, #0x5c]
	ldrne r1, _02173024 // =0xFFF40EAD
	add r2, r0, #0x3000
	sub r0, r4, #0x4000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r4, r0, lsl #1
	add r0, r4, #1
	mov r4, r4, lsl #1
	ldrsh r4, [r3, r4]
	mov r0, r0, lsl #1
	ldrsh r3, [r3, r0]
	smull r4, r5, r1, r4
	adds r6, r4, #0x800
	smull r4, r3, r1, r3
	adc r1, r5, #0
	ldr r0, [r2, #0xd24]
	mov r5, r6, lsr #0xc
	orr r5, r5, r1, lsl #20
	adds r4, r4, #0x800
	adc r1, r3, #0
	mov r3, r4, lsr #0xc
	add r0, r0, r5
	ldr r2, [r2, #0xd2c]
	orr r3, r3, r1, lsl #20
	str r0, [sp, #0x50]
	add r11, r2, r3
	b _02172650
_0217263C:
	ldr r0, [sp, #0x5c]
	add r1, r0, #0x3000
	ldr r0, [r1, #0xd24]
	ldr r11, [r1, #0xd2c]
	str r0, [sp, #0x50]
_02172650:
	ldr r0, [sp, #0x58]
	ldrb r0, [r0, #0xae]
	cmp r0, #0
	beq _02172F0C
_02172660:
	ldr r0, [sp, #0x58]
	ldr r7, _0217301C // =FX_SinCosTable_
	str r0, [sp, #0x44]
	mov r4, r0
	str r0, [sp, #0x40]
	add r0, r0, #0xb4
	str r0, [sp, #0x3c]
	mov r0, #0
	str r0, [sp, #0x64]
	ldr r0, [sp, #0x5c]
	add r8, sp, #0x114
	add r0, r0, #0x15c
	str r0, [sp, #0x70]
	ldr r0, [sp, #0x5c]
	add r6, sp, #0xe4
	add r0, r0, #0xe60
	str r0, [sp, #0x6c]
	ldr r0, [sp, #0x5c]
	add r0, r0, #0x4e0
	str r0, [sp, #0x68]
	ldr r0, [sp, #0x5c]
	add r5, r0, #0x3000
	add r0, r0, #0x3d00
	str r0, [sp, #0x74]
_021726C0:
	ldr r0, [sp, #0x58]
	mov r1, #1
	ldrb r2, [r0, #0xae]
	ldr r0, [sp, #0x64]
	tst r2, r1, lsl r0
	beq _02172E84
	ldr r0, [sp, #0x5c]
	mov r2, #0x144
	ldr r1, [r0, #0x44]
	mov r0, r8
	str r1, [sp, #0x144]
	ldr r1, [sp, #0x44]
	ldr r1, [r1, #0x7c]
	str r1, [sp, #0x148]
	ldr r1, [sp, #0x5c]
	ldr r1, [r1, #0x4c]
	str r1, [sp, #0x14c]
	ldr r1, [sp, #0x58]
	ldrb r10, [r1]
	ldr r1, [sp, #0x74]
	ldrh r3, [r1, #0x1e]
	ldr r1, [sp, #0x68]
	mla r9, r10, r2, r1
	sub r1, r3, #0x8000
	strh r1, [sp, #0x8e]
	ldr r1, [sp, #0x44]
	ldr r2, [r1, #0x80]
	ldr r3, [r1, #0x78]
	ldr r1, [sp, #0x50]
	sub r10, r2, r11
	sub r1, r3, r1
	str r1, [sp, #0x4c]
	ldrh r1, [r4, #0x9e]
	sub r1, r1, #0x8000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r7, r2, lsl #1
	ldrsh r1, [r7, r1]
	ldrsh r2, [r2, #2]
	blx MTX_RotY43_
	mov r0, r6
	bl MTX_Identity43_
	ldr r2, [sp, #0x4c]
	mov r0, r6
	mov r1, r6
	mov r3, #0
	str r10, [sp]
	bl MTX_TransApply43
	mov r0, r8
	mov r1, r6
	mov r2, r8
	bl MTX_Concat43
	ldrh r1, [sp, #0x8e]
	mov r0, r6
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r7, r2, lsl #1
	ldrsh r1, [r7, r1]
	ldrsh r2, [r2, #2]
	blx MTX_RotY43_
	mov r0, r8
	mov r1, r6
	mov r2, r8
	bl MTX_Concat43
	mov r0, r6
	bl MTX_Identity43_
	ldr r1, [r5, #0xd18]
	mov r0, r6
	str r1, [sp]
	ldr r2, [r5, #0xd10]
	ldr r3, [r5, #0xd14]
	mov r1, r6
	bl MTX_TransApply43
	mov r0, r8
	mov r1, r6
	mov r2, r8
	bl MTX_Concat43
	mov r0, r8
	add r1, r9, #0x24
	bl MI_Copy36B
	ldr r2, [sp, #0x144]
	ldr r0, [sp, #0x98]
	add r1, sp, #0x144
	sub r0, r2, r0
	str r0, [r9, #0x48]
	ldr r3, [sp, #0x148]
	ldr r0, [sp, #0x94]
	add r2, sp, #0x8c
	sub r0, r3, r0
	rsb r0, r0, #0
	str r0, [r9, #0x4c]
	ldr r0, [sp, #0x14c]
	mov r3, #0
	str r0, [r9, #0x50]
	ldr r0, _02173010 // =g_obj
	ldr r10, [r9, #0x48]
	ldrsh r0, [r0, #0xc]
	add r0, r10, r0, lsl #12
	str r0, [r9, #0x48]
	ldr r0, _02173010 // =g_obj
	ldr r10, [r9, #0x4c]
	ldrsh r0, [r0, #0xe]
	add r0, r10, r0, lsl #12
	str r0, [r9, #0x4c]
	ldr r10, [r9, #0x48]
	ldr r0, [sp, #0x138]
	add r0, r10, r0
	str r0, [r9, #0x48]
	ldr r10, [r9, #0x4c]
	ldr r0, [sp, #0x13c]
	sub r0, r10, r0
	str r0, [r9, #0x4c]
	ldr r10, [r9, #0x50]
	ldr r0, [sp, #0x140]
	add r0, r10, r0
	str r0, [r9, #0x50]
	add r0, sp, #0x88
	str r0, [sp]
	mov r0, r3
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x58]
	mov r9, #0x144
	ldrb r10, [r0]
	ldr r0, [sp, #0x68]
	mla r0, r10, r9, r0
	bl StageTask__Draw3DEx
	mov r0, #0
	str r0, [sp, #0x60]
	ldr r0, [sp, #0x40]
	str r0, [sp, #0x2c]
_021728FC:
	mov r9, #0
_02172900:
	ldr r0, [sp, #0x2c]
	add r0, r0, r9, lsl #2
	ldr r10, [r0, #0xc]
	cmp r10, #0
	beq _02172920
	ldr r0, [r10, #0x18]
	tst r0, #0xc
	beq _02172934
_02172920:
	ldr r0, [sp, #0x2c]
	add r1, r0, r9, lsl #2
	mov r0, #0
	str r0, [r1, #0xc]
	b _02172AA4
_02172934:
	ldr r2, [r10, #0x364]
	ldr r0, [sp, #0x50]
	ldr r1, [r10, #0x36c]
	sub r0, r2, r0
	str r0, [sp, #0x20]
	sub r0, r1, r11
	ldrh r1, [r4, #0x9e]
	str r0, [sp, #0x14]
	mov r0, r8
	sub r1, r1, #0x8000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r7, r2, lsl #1
	ldrsh r1, [r7, r1]
	ldrsh r2, [r2, #2]
	blx MTX_RotY43_
	mov r0, r6
	bl MTX_Identity43_
	ldr r0, [sp, #0x14]
	ldr r2, [sp, #0x20]
	str r0, [sp]
	mov r0, r6
	mov r1, r6
	mov r3, #0
	bl MTX_TransApply43
	mov r0, r8
	mov r1, r6
	mov r2, r8
	bl MTX_Concat43
	ldrh r1, [sp, #0x8e]
	mov r0, r6
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r7, r2, lsl #1
	ldrsh r1, [r7, r1]
	ldrsh r2, [r2, #2]
	blx MTX_RotY43_
	mov r0, r8
	mov r1, r6
	mov r2, r8
	bl MTX_Concat43
	mov r0, r6
	bl MTX_Identity43_
	ldr r1, [r5, #0xd18]
	mov r0, r6
	str r1, [sp]
	ldr r2, [r5, #0xd10]
	ldr r3, [r5, #0xd14]
	mov r1, r6
	bl MTX_TransApply43
	mov r0, r8
	mov r1, r6
	mov r2, r8
	bl MTX_Concat43
	ldr r1, [sp, #0x144]
	ldr r0, [sp, #0x138]
	add r0, r1, r0
	str r0, [r10, #0x44]
	ldr r0, [r10, #0x368]
	str r0, [r10, #0x48]
	ldr r1, [sp, #0x14c]
	ldr r0, [sp, #0x140]
	add r0, r1, r0
	str r0, [r10, #0x4c]
	ldr r0, [sp, #0x60]
	ldrh r1, [sp, #0x8e]
	cmp r0, #0
	ldrh r0, [r4, #0x9e]
	sub r0, r0, #0x8000
	add r0, r1, r0
	strh r0, [r10, #0x32]
	bne _02172A90
	ldrh r0, [r10, #0x32]
	sub r0, r0, #0x4000
	strh r0, [r10, #0x32]
	b _02172AA4
_02172A90:
	ldr r0, [sp, #0x60]
	cmp r0, #2
	ldreqh r0, [r10, #0x32]
	addeq r0, r0, #0x4000
	streqh r0, [r10, #0x32]
_02172AA4:
	add r9, r9, #1
	cmp r9, #3
	blt _02172900
	ldr r0, [sp, #0x2c]
	add r0, r0, #0xc
	str r0, [sp, #0x2c]
	ldr r0, [sp, #0x60]
	add r0, r0, #1
	str r0, [sp, #0x60]
	cmp r0, #3
	blt _021728FC
	mov r0, #0
	str r0, [sp, #0x10]
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x3c]
	str r0, [sp, #0x34]
	add r0, r0, #0x100
	str r0, [sp, #0x7c]
_02172AEC:
	ldr r0, [sp, #0x34]
	mov r9, #0
	str r0, [sp, #0x30]
	ldr r0, [sp, #0x7c]
	ldrh r1, [r0, #0xb0]
	ldr r0, [sp, #0x38]
	mov r0, r1, asr r0
	and r0, r0, #3
	mov r0, r0, lsl #0x10
	str r0, [sp, #0x78]
_02172B14:
	mov r0, #1
	mov r1, r0, lsl r9
	ldr r0, [sp, #0x78]
	tst r1, r0, lsr #16
	beq _02172E40
	cmp r9, #0
	moveq r1, #1
	movne r1, #0
	orr r0, r1, #0x100
	orr r0, r0, #0x10000
	str r0, [sp, #0x84]
	mov r0, #0
	ldr r10, [sp, #0x30]
	str r0, [sp, #0x48]
_02172B4C:
	ldr r0, [r10, #4]
	cmp r0, #0
	beq _02172E28
	ldr r2, [r10]
	ldr r0, [sp, #0x50]
	ldr r1, [r10, #8]
	sub r0, r2, r0
	str r0, [sp, #0x24]
	sub r0, r1, r11
	ldrh r1, [r4, #0x9e]
	str r0, [sp, #0x18]
	mov r0, r8
	sub r1, r1, #0x8000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r7, r2, lsl #1
	ldrsh r1, [r7, r1]
	ldrsh r2, [r2, #2]
	blx MTX_RotY43_
	mov r0, r6
	bl MTX_Identity43_
	ldr r0, [sp, #0x18]
	ldr r2, [sp, #0x24]
	str r0, [sp]
	mov r0, r6
	mov r1, r6
	mov r3, #0
	bl MTX_TransApply43
	mov r0, r8
	mov r1, r6
	mov r2, r8
	bl MTX_Concat43
	ldrh r1, [sp, #0x8e]
	mov r0, r6
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r7, r2, lsl #1
	ldrsh r1, [r7, r1]
	ldrsh r2, [r2, #2]
	blx MTX_RotY43_
	mov r0, r8
	mov r1, r6
	mov r2, r8
	bl MTX_Concat43
	mov r0, r6
	bl MTX_Identity43_
	ldr r1, [r5, #0xd18]
	mov r0, r6
	str r1, [sp]
	ldr r2, [r5, #0xd10]
	ldr r3, [r5, #0xd14]
	mov r1, r6
	bl MTX_TransApply43
	mov r0, r8
	mov r1, r6
	mov r2, r8
	bl MTX_Concat43
	ldr r2, [sp, #0x144]
	ldr r0, [sp, #0x138]
	ldr r1, [sp, #0x14c]
	add r0, r2, r0
	str r0, [sp, #0xd8]
	ldr r0, [sp, #0x5c]
	ldr r2, [r10, #4]
	ldr r3, [r0, #0xe80]
	ldr r0, [sp, #0x140]
	add r2, r3, r2
	add r0, r1, r0
	str r2, [sp, #0xdc]
	str r0, [sp, #0xe0]
	add r0, sp, #0x84
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x70]
	mov r2, #0
	add r0, r0, #0x3c00
	add r1, sp, #0xd8
	mov r3, r2
	bl StageTask__Draw3DEx
	ldr r2, [r10, #0xd8]
	ldr r0, [sp, #0x50]
	ldr r1, [r10, #0xe0]
	sub r0, r2, r0
	str r0, [sp, #0x28]
	sub r0, r1, r11
	ldrh r1, [r4, #0x9e]
	str r0, [sp, #0x1c]
	mov r0, r8
	sub r1, r1, #0x8000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r7, r2, lsl #1
	ldrsh r1, [r7, r1]
	ldrsh r2, [r2, #2]
	blx MTX_RotY43_
	mov r0, r6
	bl MTX_Identity43_
	ldr r0, [sp, #0x1c]
	ldr r2, [sp, #0x28]
	str r0, [sp]
	mov r0, r6
	mov r1, r6
	mov r3, #0
	bl MTX_TransApply43
	mov r0, r8
	mov r1, r6
	mov r2, r8
	bl MTX_Concat43
	ldrh r1, [sp, #0x8e]
	mov r0, r6
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r7, r2, lsl #1
	ldrsh r1, [r7, r1]
	ldrsh r2, [r2, #2]
	blx MTX_RotY43_
	mov r0, r8
	mov r1, r6
	mov r2, r8
	bl MTX_Concat43
	mov r0, r6
	bl MTX_Identity43_
	ldr r1, [r5, #0xd18]
	mov r0, r6
	str r1, [sp]
	ldr r2, [r5, #0xd10]
	ldr r3, [r5, #0xd14]
	mov r1, r6
	bl MTX_TransApply43
	mov r0, r8
	mov r1, r6
	mov r2, r8
	bl MTX_Concat43
	ldr r2, [sp, #0x144]
	ldr r0, [sp, #0x138]
	ldr r1, [sp, #0x14c]
	add r0, r2, r0
	str r0, [sp, #0xd8]
	ldr r0, [sp, #0x5c]
	ldr r2, [r10, #0xdc]
	ldr r3, [r0, #0xe80]
	ldr r0, [sp, #0x140]
	add r2, r3, r2
	add r0, r1, r0
	str r2, [sp, #0xdc]
	str r0, [sp, #0xe0]
	add r0, sp, #0x84
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x6c]
	mov r2, #0
	add r0, r0, #0x3000
	add r1, sp, #0xd8
	mov r3, r2
	bl StageTask__Draw3DEx
_02172E28:
	ldr r0, [sp, #0x48]
	add r10, r10, #0xc
	add r0, r0, #1
	str r0, [sp, #0x48]
	cmp r0, #3
	blt _02172B4C
_02172E40:
	ldr r0, [sp, #0x30]
	add r9, r9, #1
	add r0, r0, #0x24
	str r0, [sp, #0x30]
	cmp r9, #2
	blt _02172B14
	ldr r0, [sp, #0x38]
	add r0, r0, #2
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x34]
	add r0, r0, #0x48
	str r0, [sp, #0x34]
	ldr r0, [sp, #0x10]
	add r0, r0, #1
	str r0, [sp, #0x10]
	cmp r0, #3
	blt _02172AEC
_02172E84:
	ldr r0, [sp, #0x44]
	add r4, r4, #6
	add r0, r0, #0xc
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x40]
	add r0, r0, #0x24
	str r0, [sp, #0x40]
	ldr r0, [sp, #0x3c]
	add r0, r0, #0x1b4
	str r0, [sp, #0x3c]
	ldr r0, [sp, #0x64]
	add r0, r0, #1
	str r0, [sp, #0x64]
	cmp r0, #3
	blt _021726C0
	ldr r0, [sp, #0x5c]
	add r0, r0, #0x3d00
	ldrsh r1, [r0, #6]
	ldr r0, [sp, #0x54]
	cmp r0, r1
	beq _02172F0C
	add r2, r0, #1
	ldr r0, [sp, #0x5c]
	add r1, r0, #0x284
	and r0, r2, #7
	str r0, [sp, #0x54]
	add r2, r1, #0xc00
	mov r1, #0x5d0
	mov r0, r0
	smlabb r0, r0, r1, r2
	str r0, [sp, #0x58]
	ldrb r0, [r0, #0xae]
	cmp r0, #0
	bne _02172660
_02172F0C:
	mov r0, #0x200000
	str r0, [sp, #0xd4]
	str r0, [sp, #0xd0]
	str r0, [sp, #0xcc]
	ldr r0, [sp, #0x5c]
	ldr r2, [sp, #0x94]
	add r1, r0, #0x3000
	ldr r3, [r1, #0xd38]
	ldr r0, [sp, #0x98]
	sub r0, r3, r0
	str r0, [sp, #0xc0]
	ldr r3, [r1, #0xd3c]
	add r0, sp, #0x9c
	sub r2, r3, r2
	rsb r2, r2, #0
	str r2, [sp, #0xc4]
	ldr r1, [r1, #0xd40]
	str r1, [sp, #0xc8]
	bl MTX_Identity33_
	add r0, sp, #0xcc
	bl NNS_G3dGlbSetBaseScale
	ldr r1, _02173028 // =0x021472FC
	add r0, sp, #0x9c
	bl MI_Copy36B
	ldr r1, _0217302C // =NNS_G3dGlb
	add r0, sp, #0xc0
	ldr r2, [r1, #0xfc]
	bic r2, r2, #0xa4
	str r2, [r1, #0xfc]
	bl NNS_G3dGlbSetBaseTrans
	mov r2, #1
	mov r0, #0x10
	add r1, sp, #0x80
	str r2, [sp, #0x80]
	bl NNS_G3dGeBufferOP_N
	bl NNS_G3dGlbFlushP
	ldr r0, [sp, #0x5c]
	add r0, r0, #0x3000
	ldr r1, [r0, #0xd44]
	tst r1, #3
	ldrne r1, [r0, #0xd48]
	ldr r0, [r0, #0xd4c]
	sub r1, r1, r0
	ldr r0, [sp, #0x5c]
	add r0, r0, #0x3000
	ldr r0, [r0, #0xd58]
	bl NNS_G3dGeSendDL
	ldr r0, [sp, #0x5c]
	add r0, r0, #0x364
	add r0, r0, #0x3c00
	bl AnimatePalette
	ldr r0, [sp, #0x5c]
	add r0, r0, #0x364
	add r0, r0, #0x3c00
	bl CheckPaletteAnimationIsValid
	cmp r0, #0
	addeq sp, sp, #0x150
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x5c]
	add r0, r0, #0x364
	add r0, r0, #0x3c00
	bl DrawAnimatedPalette
	add sp, sp, #0x150
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0217300C: .word 0x00012100
_02173010: .word g_obj
_02173014: .word 0x00003FFF
_02173018: .word Truck3D__State_2171F98
_0217301C: .word FX_SinCosTable_
_02173020: .word 0x000BF153
_02173024: .word 0xFFF40EAD
_02173028: .word 0x021472FC
_0217302C: .word NNS_G3dGlb
	arm_func_end Truck3D__Draw_21724F4

	arm_func_start Object58__OnDefend_2173030
Object58__OnDefend_2173030: // 0x02173030
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldrh r0, [r5]
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, r5, r6, pc}
	ldr r6, [r5, #0x6d8]
	cmp r6, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldrh r0, [r6]
	cmp r0, #3
	ldreq r0, [r6, #0x340]
	ldreqh r0, [r0, #2]
	cmpeq r0, #0xad
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0xb2
	beq _021730A8
	cmp r0, #0xb3
	beq _02173184
	b _021731C4
_021730A8:
	ldr r0, [r4, #0x48]
	mov r1, #0
	add r0, r0, #0x180000
	str r0, [r6, #0xe80]
	mov r0, r6
	mov r2, r1
	mov r3, r1
	str r1, [sp]
	bl Truck3D__Func_217322C
	mov r1, #0
	mov r0, r6
	mov r2, r1
	mov r3, r1
	str r1, [sp]
	bl Truck3D__Func_217322C
	mov r1, #0
	mov r0, r6
	mov r2, r1
	str r1, [sp]
	mov r3, r1
	bl Truck3D__Func_217322C
	mov r0, #1
	strb r0, [r6, #0xf33]
	ldr r0, [r6, #0xe80]
	mov r1, #0x8000
	add r0, r0, #0x15000
	str r0, [r6, #0xf0c]
	add r0, r6, #0xf00
	strh r1, [r0, #0x28]
	add r0, r6, #0x54
	add r0, r0, #0x1400
	mov r1, #2
	strb r1, [r6, #0xf32]
	add r1, r6, #0x284
	add r1, r1, #0xc00
	bl Truck3D__Func_2173304
	mov r1, #1
	strb r1, [r6, #0xf34]
	add r0, r6, #0x1000
	strb r1, [r0, #0x503]
	add r0, r6, #0x224
	add r0, r0, #0x1800
	add r1, r6, #0x54
	add r1, r1, #0x1400
	bl Truck3D__Func_2173304
	mov r2, #1
	add r0, r6, #0x1000
	add r1, r6, #0x3000
	strb r2, [r0, #0x504]
	strb r2, [r0, #0xad3]
	ldr r2, [r5, #0x44]
	ldr r0, [r4, #0x44]
	sub r0, r2, r0
	str r0, [r1, #0xd0c]
	b _021731F0
_02173184:
	add r1, r6, #0x3d00
	ldrsh r3, [r1, #6]
	mov r2, #0
	mov r0, r6
	strh r3, [r1, #0x36]
	mov r3, r2
	mov r1, #1
	str r2, [sp]
	bl Truck3D__Func_217322C
	mov r1, #0
	mov r0, r6
	mov r2, r1
	mov r3, r1
	str r1, [sp]
	bl Truck3D__Func_217322C
	b _021731F0
_021731C4:
	cmp r0, #0xb7
	blo _021731E4
	mov r1, #0
	mov r0, r6
	mov r2, r1
	mov r3, r1
	str r1, [sp]
	bl Truck3D__Func_217322C
_021731E4:
	ldr r1, [r4, #0x340]
	mov r0, r6
	bl Truck3D__Func_2173204
_021731F0:
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end Object58__OnDefend_2173030

	arm_func_start Truck3D__Func_2173204
Truck3D__Func_2173204: // 0x02173204
	stmdb sp!, {r3, lr}
	ldrb r2, [r1, #8]
	str r2, [sp]
	ldrh ip, [r1, #2]
	ldrb r2, [r1, #6]
	ldrb r3, [r1, #7]
	sub r1, ip, #0xb4
	and r1, r1, #0xff
	bl Truck3D__Func_217322C
	ldmia sp!, {r3, pc}
	arm_func_end Truck3D__Func_2173204

	arm_func_start Truck3D__Func_217322C
Truck3D__Func_217322C: // 0x0217322C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	add r4, r0, #0x3d00
	ldrsh r9, [r4, #6]
	ldrsh r5, [r4, #4]
	sub r5, r9, r5
	mov r5, r5, lsl #0x10
	mov r5, r5, asr #0x10
	cmp r5, #6
	ldmgeia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mvn lr, #1
	cmp r5, lr
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r5, r9, #1
	and r8, r5, #7
	mov ip, #0x5d0
	strh r8, [r4, #6]
	mov r6, r2, asr #4
	add r10, r0, #0x284
	smulbb ip, r9, ip
	ldrb r7, [sp, #0x20]
	add r9, r10, #0xc00
	strb r1, [r9, ip]
	mov r0, r7, asr #4
	add r1, r9, ip
	and r2, r2, #0xf
	strb r2, [r1, #1]
	and r2, r3, #0xf
	strb r2, [r1, #2]
	and r2, r7, #0xf
	strb r2, [r1, #3]
	and r2, r6, #0xf
	mov r5, r3, asr #4
	strh r2, [r1, #4]
	and r2, r5, #0xf
	strh r2, [r1, #6]
	and r0, r0, #0xf
	strh r0, [r1, #8]
	add r0, lr, #1
	strb r0, [r1, #0xb0]
	strb r0, [r1, #0xaf]
	ldrb r0, [r9, ip]
	mov r4, #0
	cmp r0, #6
	movhs r0, #0
	strhsb r0, [r1]
	mov r0, r4
_021732E4:
	add r3, r1, r4
	ldrb r2, [r3, #1]
	add r4, r4, #1
	cmp r2, #6
	strhsb r0, [r3, #1]
	cmp r4, #3
	blt _021732E4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end Truck3D__Func_217322C

	arm_func_start Truck3D__Func_2173304
Truck3D__Func_2173304: // 0x02173304
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x88
	ldr r2, _02173E74 // =0x021885A4
	str r1, [sp, #8]
	str r0, [sp, #4]
	ldr r0, [sp, #8]
	ldrb r9, [r2]
	ldrb r8, [r2, #1]
	ldrb r7, [r2, #2]
	ldrb r6, [r2, #3]
	ldrb r5, [r2, #4]
	ldrb r1, [r2, #5]
	strb r8, [sp, #0x83]
	ldrh r4, [r2, #6]
	ldrh r3, [r2, #8]
	ldrh r2, [r2, #0xa]
	ldrb r0, [r0]
	add r10, sp, #0x82
	strb r9, [sp, #0x82]
	ldr r8, [sp, #4]
	strb r7, [sp, #0x84]
	strb r6, [sp, #0x85]
	strb r5, [sp, #0x86]
	strb r1, [sp, #0x87]
	ldrb r1, [r10, r0]
	mov r0, r8
	mov r9, r8
	strb r1, [r0, #0xae]
	add r0, r0, #0xb4
	str r0, [sp, #0x34]
	mov r0, #0
	strh r4, [sp, #0x7c]
	strh r3, [sp, #0x7e]
	strh r2, [sp, #0x80]
	str r0, [sp, #0x44]
_02173390:
	ldr r0, [sp, #4]
	mov r1, #1
	ldrb r2, [r0, #0xae]
	ldr r0, [sp, #0x44]
	tst r2, r1, lsl r0
	beq _02173E44
	ldr r0, [sp, #8]
	mov r1, #0xc
	ldrsb r2, [r0, #0xaf]
	add r3, r8, #0x78
	mla r0, r2, r1, r0
	add r0, r0, #0x78
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [sp, #8]
	mov r1, #6
	ldrsb r4, [r0, #0xaf]
	add r2, sp, #0x7c
	mla r7, r4, r1, r0
	ldr r0, [sp, #0x44]
	ldrh r6, [r7, #0x9c]
	ldrh r5, [r7, #0x9e]
	mov r0, r0, lsl #1
	ldrh r4, [r2, r0]
	strh r6, [r9, #0x9c]
	strh r5, [r9, #0x9e]
	ldrh r0, [r7, #0xa0]
	cmp r4, #0
	strh r0, [r9, #0xa0]
	ldrh r0, [r9, #0x9e]
	add r0, r0, r4
	strh r0, [r9, #0x9e]
	ldr r0, [sp, #8]
	ldrsb r2, [r0, #0xaf]
	mla r0, r2, r1, r0
	ldrh r0, [r0, #0x9e]
	mov r1, #0
	beq _02173490
	cmp r4, #0x8000
	addlo r0, r0, #0x2000
	addhs r0, r0, #0xe000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r6, r0, lsl #1
	ldr r2, _02173E78 // =FX_SinCosTable_
	mov r0, r6, lsl #1
	ldrsh r3, [r2, r0]
	ldr r0, _02173E7C // =0x0010E3B5
	add r2, r2, r6, lsl #1
	umull r5, r4, r3, r0
	mla r4, r3, r1, r4
	mov r3, r3, asr #0x1f
	mla r4, r3, r0, r4
	adds r5, r5, #0x800
	adc r3, r4, #0
	mov r4, r5, lsr #0xc
	ldr r5, [r8, #0x78]
	orr r4, r4, r3, lsl #20
	add r3, r5, r4
	str r3, [r8, #0x78]
	b _021734E0
_02173490:
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r7, r0, lsl #1
	ldr r2, _02173E78 // =FX_SinCosTable_
	mov r0, r7, lsl #1
	ldrsh r4, [r2, r0]
	mov r0, #0x12c000
	add r2, r2, r7, lsl #1
	umull r6, r5, r4, r0
	mla r5, r4, r1, r5
	mov r4, r4, asr #0x1f
	mla r5, r4, r0, r5
	adds r6, r6, #0x800
	adc r4, r5, #0
	mov r5, r6, lsr #0xc
	orr r5, r5, r4, lsl #20
	ldr r4, [r3]
	add r4, r4, r5
	str r4, [r3]
_021734E0:
	ldrsh r2, [r2, #2]
	ldr r5, [r8, #0x80]
	ldr r6, _02173E80 // =_mt_math_rand
	umull r4, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r1, r4, #0x800
	adc r0, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r5, r1
	str r0, [r8, #0x80]
	ldr r0, [sp, #4]
	ldr r4, _02173E84 // =0x00196225
	ldrb r1, [r0]
	add r0, sp, #0x82
	ldr r5, _02173E88 // =0x3C6EF35F
	ldrb r1, [r0, r1]
	add r7, sp, #0x74
	add r11, sp, #0x78
	tst r1, #2
	movne r0, #1
	strne r0, [sp, #0x14]
	moveq r0, #3
	streq r0, [sp, #0x14]
	tst r1, #1
	movne r0, #1
	strne r0, [sp, #0x10]
	moveq r0, #3
	streq r0, [sp, #0x10]
	tst r1, #4
	movne r0, #1
	strne r0, [sp, #0xc]
	moveq r0, #3
	streq r0, [sp, #0xc]
	ldr r0, [sp, #0x34]
	str r0, [sp, #0x30]
	mov r0, #0
	str r0, [sp, #0x40]
	mov r0, #0x30000
	str r0, [sp, #0x54]
	ldr r0, _02173E8C // =0xFFFFFAAB
	rsb r0, r0, #0
	str r0, [sp, #0x48]
	ldr r0, [sp, #0x54]
	rsb r0, r0, #0
	str r0, [sp, #0x54]
	sub r0, r0, #0x8000
	str r0, [sp, #0x58]
	ldr r0, [sp, #0x54]
	sub r0, r0, #0xca000
	str r0, [sp, #0x50]
	ldr r0, _02173E90 // =0x00003556
	rsb r0, r0, #0x8000
	str r0, [sp, #0x5c]
	ldr r0, [sp, #0x34]
	add r0, r0, #0x1b0
	str r0, [sp, #0x4c]
	ldr r0, _02173E94 // =0x000EF153
	sub r0, r0, #0x30000
	str r0, [sp, #0x60]
	ldr r0, _02173E94 // =0x000EF153
	sub r0, r0, #0x30000
	str r0, [sp, #0x68]
	ldr r0, _02173E8C // =0xFFFFFAAB
	rsb r0, r0, #0x1000
	str r0, [sp, #0x64]
	ldr r0, _02173E94 // =0x000EF153
	sub r0, r0, #0x30000
	str r0, [sp, #0x6c]
	ldr r0, _02173E94 // =0x000EF153
	sub r0, r0, #0x30000
	str r0, [sp, #0x70]
_02173608:
	ldr r0, [sp, #4]
	ldrb r1, [r0]
	add r0, sp, #0x82
	ldrb r2, [r0, r1]
	ldr r0, [sp, #0x40]
	mov r1, #1
	tst r2, r1, lsl r0
	beq _02173E24
	cmp r0, #0
	bne _02173864
	ldr r0, [sp, #0x14]
	cmp r0, #0
	ldr r0, _02173E90 // =0x00003556
	str r0, [sp, #0x2c]
	mov r0, #0
	str r0, [sp, #0x3c]
	ble _02173810
	ldr r10, [sp, #0x30]
_02173650:
	ldr r0, [r6]
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #2
	str r1, [r6]
	movne r0, #0
	strne r0, [r10, #0x28]
	bne _021737F4
	ldr r0, [sp, #0x2c]
	ldr r1, _02173E94 // =0x000EF153
	str r0, [sp]
	mov r0, #0
	mov r2, r7
	mov r3, r11
	bl AkMath__Func_2002C98
	ldr r1, [sp, #0x78]
	ldr r0, [sp, #0x60]
	mov r2, r7
	sub r0, r1, r0
	str r0, [sp, #0x78]
	ldrh r0, [r9, #0x9e]
	mov r3, r11
	sub r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [sp, #0x74]
	ldr r1, [sp, #0x78]
	bl AkMath__Func_2002C98
	ldr r1, [sp, #0x78]
	ldr r0, [r8, #0x78]
	mov r2, r7
	add r0, r1, r0
	str r0, [r10, #0x24]
	ldr r0, [r6]
	mov r3, r11
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	sub r0, r0, #0x64
	str r1, [r6]
	mov r0, r0, lsl #0xc
	str r0, [r10, #0x28]
	ldr r1, [sp, #0x74]
	ldr r0, [r8, #0x80]
	add r0, r1, r0
	str r0, [r10, #0x2c]
	ldr r0, [r6]
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	str r1, [r6]
	ldrne r1, [sp, #0x48]
	ldr r0, [sp, #0x2c]
	ldreq r1, _02173E8C // =0xFFFFFAAB
	add r0, r0, r1
	ldr r1, _02173E94 // =0x000EF153
	str r0, [sp]
	mov r0, #0
	add r1, r1, #0x8000
	bl AkMath__Func_2002C98
	ldr r1, [sp, #0x78]
	ldr r0, [sp, #0x68]
	mov r2, r7
	sub r0, r1, r0
	str r0, [sp, #0x78]
	ldrh r0, [r9, #0x9e]
	mov r3, r11
	sub r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [sp, #0x74]
	ldr r1, [sp, #0x78]
	bl AkMath__Func_2002C98
	ldr r1, [sp, #0x2c]
	ldr r0, [sp, #0x64]
	ldr r3, [sp, #0x78]
	sub r0, r1, r0
	ldr r2, [r8, #0x78]
	mov r0, r0, lsl #0x10
	add r1, r3, r2
	mov r0, r0, lsr #0x10
	str r1, [r10, #0xfc]
	str r0, [sp, #0x2c]
	ldr r0, [r6]
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	sub r0, r0, #0x5a
	str r1, [r6]
	mov r0, r0, lsl #0xc
	str r0, [r10, #0x100]
	ldr r1, [sp, #0x74]
	ldr r0, [r8, #0x80]
	add r0, r1, r0
	str r0, [r10, #0x104]
_021737F4:
	ldr r0, [sp, #0x3c]
	add r10, r10, #0xc
	add r1, r0, #1
	ldr r0, [sp, #0x14]
	str r1, [sp, #0x3c]
	cmp r1, r0
	blt _02173650
_02173810:
	ldr r0, [sp, #0x3c]
	cmp r0, #3
	bge _0217384C
	mov r2, r0
	ldr r0, [sp, #0x30]
	mov r1, #0xc
	mla r1, r2, r1, r0
_0217382C:
	mov r0, #0
	str r0, [r1, #0x28]
	ldr r0, [sp, #0x3c]
	add r1, r1, #0xc
	add r0, r0, #1
	str r0, [sp, #0x3c]
	cmp r0, #3
	blt _0217382C
_0217384C:
	ldr r0, [sp, #0x4c]
	ldrh r0, [r0]
	orr r1, r0, #2
	ldr r0, [sp, #0x4c]
	strh r1, [r0]
	b _02173E24
_02173864:
	cmp r0, #1
	bne _02173BF4
	ldr r0, [sp, #0x10]
	cmp r0, #0
	ldr r0, [sp, #0x50]
	str r0, [sp, #0x38]
	mov r0, #0
	str r0, [sp, #0x1c]
	ble _021739E8
	ldr r10, [sp, #0x30]
_0217388C:
	ldr r0, [r6]
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #2
	str r1, [r6]
	movne r0, #0
	strne r0, [r10, #4]
	bne _021739CC
	ldrh r2, [r9, #0x9e]
	ldr r0, [sp, #0x38]
	ldr r1, [sp, #0x54]
	sub r2, r2, #0x8000
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	str r2, [sp]
	mov r2, r7
	mov r3, r11
	bl AkMath__Func_2002C98
	ldr r1, [sp, #0x78]
	ldr r0, [r8, #0x78]
	mov r2, r7
	add r0, r1, r0
	str r0, [r10]
	ldr r0, [r6]
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	sub r0, r0, #0x64
	str r1, [r6]
	mov r0, r0, lsl #0xc
	str r0, [r10, #4]
	ldr r1, [sp, #0x74]
	ldr r0, [r8, #0x80]
	add r0, r1, r0
	str r0, [r10, #8]
	ldr r0, [r6]
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	str r1, [r6]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	ldrh r3, [r9, #0x9e]
	ldreq r0, [sp, #0x54]
	movne r1, #0x19000
	addeq r1, r0, #0x17000
	ldr r0, [sp, #0x38]
	sub r3, r3, #0x8000
	mov r3, r3, lsl #0x10
	add r0, r0, r1
	mov r3, r3, lsr #0x10
	str r3, [sp]
	ldr r1, [sp, #0x58]
	mov r3, r11
	bl AkMath__Func_2002C98
	ldr r0, [sp, #0x38]
	ldr r2, [sp, #0x78]
	add r0, r0, #0x64000
	ldr r1, [r8, #0x78]
	str r0, [sp, #0x38]
	add r0, r2, r1
	str r0, [r10, #0xd8]
	ldr r0, [r6]
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	sub r0, r0, #0x5a
	str r1, [r6]
	mov r0, r0, lsl #0xc
	str r0, [r10, #0xdc]
	ldr r1, [sp, #0x74]
	ldr r0, [r8, #0x80]
	add r0, r1, r0
	str r0, [r10, #0xe0]
_021739CC:
	ldr r0, [sp, #0x1c]
	add r10, r10, #0xc
	add r1, r0, #1
	ldr r0, [sp, #0x10]
	str r1, [sp, #0x1c]
	cmp r1, r0
	blt _0217388C
_021739E8:
	ldr r0, [sp, #0x1c]
	cmp r0, #3
	bge _02173A24
	mov r2, r0
	ldr r0, [sp, #0x30]
	mov r1, #0xc
	mla r1, r2, r1, r0
_02173A04:
	mov r0, #0
	str r0, [r1, #4]
	ldr r0, [sp, #0x1c]
	add r1, r1, #0xc
	add r0, r0, #1
	str r0, [sp, #0x1c]
	cmp r0, #3
	blt _02173A04
_02173A24:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	ldr r0, [sp, #0x50]
	str r0, [sp, #0x18]
	mov r0, #0
	str r0, [sp, #0x20]
	ble _02173BA0
	ldr r10, [sp, #0x30]
_02173A44:
	ldr r0, [r6]
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #2
	str r1, [r6]
	movne r0, #0
	strne r0, [r10, #0x28]
	bne _02173B84
	ldrh r2, [r9, #0x9e]
	ldr r0, [sp, #0x18]
	mov r1, #0x30000
	sub r2, r2, #0x8000
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	str r2, [sp]
	mov r2, r7
	mov r3, r11
	bl AkMath__Func_2002C98
	ldr r1, [sp, #0x78]
	ldr r0, [r8, #0x78]
	mov r2, r7
	add r0, r1, r0
	str r0, [r10, #0x24]
	ldr r0, [r6]
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	sub r0, r0, #0x64
	str r1, [r6]
	mov r0, r0, lsl #0xc
	str r0, [r10, #0x28]
	ldr r1, [sp, #0x74]
	ldr r0, [r8, #0x80]
	add r0, r1, r0
	str r0, [r10, #0x2c]
	ldr r0, [r6]
	mla r1, r0, r4, r5
	str r1, [r6]
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	ldrh r3, [r9, #0x9e]
	mov r0, r0, lsr #0x10
	tst r0, #1
	sub r3, r3, #0x8000
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	str r3, [sp]
	ldreq r0, [sp, #0x54]
	movne r1, #0x19000
	addeq r1, r0, #0x17000
	ldr r0, [sp, #0x18]
	mov r3, r11
	add r0, r0, r1
	mov r1, #0x38000
	bl AkMath__Func_2002C98
	ldr r0, [sp, #0x18]
	ldr r2, [sp, #0x78]
	add r0, r0, #0x64000
	ldr r1, [r8, #0x78]
	str r0, [sp, #0x18]
	add r0, r2, r1
	str r0, [r10, #0xfc]
	ldr r0, [r6]
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	sub r0, r0, #0x5a
	str r1, [r6]
	mov r0, r0, lsl #0xc
	str r0, [r10, #0x100]
	ldr r1, [sp, #0x74]
	ldr r0, [r8, #0x80]
	add r0, r1, r0
	str r0, [r10, #0x104]
_02173B84:
	ldr r0, [sp, #0x20]
	add r10, r10, #0xc
	add r1, r0, #1
	ldr r0, [sp, #0xc]
	str r1, [sp, #0x20]
	cmp r1, r0
	blt _02173A44
_02173BA0:
	ldr r0, [sp, #0x20]
	cmp r0, #3
	bge _02173BDC
	mov r2, r0
	ldr r0, [sp, #0x30]
	mov r1, #0xc
	mla r1, r2, r1, r0
_02173BBC:
	mov r0, #0
	str r0, [r1, #0x28]
	ldr r0, [sp, #0x20]
	add r1, r1, #0xc
	add r0, r0, #1
	str r0, [sp, #0x20]
	cmp r0, #3
	blt _02173BBC
_02173BDC:
	ldr r0, [sp, #0x4c]
	ldrh r0, [r0]
	orr r1, r0, #0xc
	ldr r0, [sp, #0x4c]
	strh r1, [r0]
	b _02173E24
_02173BF4:
	ldr r0, [sp, #0x14]
	cmp r0, #0
	ldr r0, [sp, #0x5c]
	str r0, [sp, #0x28]
	mov r0, #0
	str r0, [sp, #0x24]
	ble _02173DD4
	ldr r10, [sp, #0x30]
_02173C14:
	ldr r0, [r6]
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #2
	str r1, [r6]
	movne r0, #0
	strne r0, [r10, #4]
	bne _02173DB8
	ldr r0, [sp, #0x28]
	ldr r1, _02173E94 // =0x000EF153
	str r0, [sp]
	mov r0, #0
	mov r2, r7
	mov r3, r11
	bl AkMath__Func_2002C98
	ldr r1, [sp, #0x78]
	ldr r0, [sp, #0x6c]
	mov r2, r7
	add r0, r1, r0
	str r0, [sp, #0x78]
	ldrh r0, [r9, #0x9e]
	mov r3, r11
	sub r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [sp, #0x74]
	ldr r1, [sp, #0x78]
	bl AkMath__Func_2002C98
	ldr r1, [sp, #0x78]
	ldr r0, [r8, #0x78]
	mov r2, r7
	add r0, r1, r0
	str r0, [r10]
	ldr r0, [r6]
	mov r3, r11
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	sub r0, r0, #0x64
	str r1, [r6]
	mov r0, r0, lsl #0xc
	str r0, [r10, #4]
	ldr r1, [sp, #0x74]
	ldr r0, [r8, #0x80]
	add r0, r1, r0
	str r0, [r10, #8]
	ldr r0, [r6]
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r6]
	tst r0, #1
	ldrne r1, [sp, #0x48]
	ldr r0, [sp, #0x28]
	ldreq r1, _02173E8C // =0xFFFFFAAB
	add r0, r0, r1
	ldr r1, _02173E94 // =0x000EF153
	str r0, [sp]
	mov r0, #0
	add r1, r1, #0x8000
	bl AkMath__Func_2002C98
	ldr r1, [sp, #0x78]
	ldr r0, [sp, #0x70]
	mov r2, r7
	add r0, r1, r0
	str r0, [sp, #0x78]
	ldrh r0, [r9, #0x9e]
	mov r3, r11
	sub r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [sp, #0x74]
	ldr r1, [sp, #0x78]
	bl AkMath__Func_2002C98
	ldr r0, [sp, #0x28]
	ldr r2, [sp, #0x78]
	ldr r1, [r8, #0x78]
	add r0, r0, #0x55
	add r0, r0, #0x1500
	add r1, r2, r1
	mov r0, r0, lsl #0x10
	str r1, [r10, #0xd8]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x28]
	ldr r0, [r6]
	mla r1, r0, r4, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	sub r0, r0, #0x5a
	str r1, [r6]
	mov r0, r0, lsl #0xc
	str r0, [r10, #0xdc]
	ldr r1, [sp, #0x74]
	ldr r0, [r8, #0x80]
	add r0, r1, r0
	str r0, [r10, #0xe0]
_02173DB8:
	ldr r0, [sp, #0x24]
	add r10, r10, #0xc
	add r1, r0, #1
	ldr r0, [sp, #0x14]
	str r1, [sp, #0x24]
	cmp r1, r0
	blt _02173C14
_02173DD4:
	ldr r0, [sp, #0x24]
	cmp r0, #3
	bge _02173E10
	mov r2, r0
	ldr r0, [sp, #0x30]
	mov r1, #0xc
	mla r1, r2, r1, r0
_02173DF0:
	mov r0, #0
	str r0, [r1, #4]
	ldr r0, [sp, #0x24]
	add r1, r1, #0xc
	add r0, r0, #1
	str r0, [sp, #0x24]
	cmp r0, #3
	blt _02173DF0
_02173E10:
	ldr r0, [sp, #0x4c]
	ldrh r0, [r0]
	orr r1, r0, #0x10
	ldr r0, [sp, #0x4c]
	strh r1, [r0]
_02173E24:
	ldr r0, [sp, #0x30]
	add r0, r0, #0x48
	str r0, [sp, #0x30]
	ldr r0, [sp, #0x40]
	add r0, r0, #1
	str r0, [sp, #0x40]
	cmp r0, #3
	blt _02173608
_02173E44:
	ldr r0, [sp, #0x44]
	add r8, r8, #0xc
	add r0, r0, #1
	str r0, [sp, #0x44]
	cmp r0, #3
	ldr r0, [sp, #0x34]
	add r9, r9, #6
	add r0, r0, #0x1b4
	str r0, [sp, #0x34]
	blt _02173390
	add sp, sp, #0x88
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02173E74: .word 0x021885A4
_02173E78: .word FX_SinCosTable_
_02173E7C: .word 0x0010E3B5
_02173E80: .word _mt_math_rand
_02173E84: .word 0x00196225
_02173E88: .word 0x3C6EF35F
_02173E8C: .word 0xFFFFFAAB
_02173E90: .word 0x00003556
_02173E94: .word 0x000EF153
	arm_func_end Truck3D__Func_2173304

	.data
	
aActAcGmkTruckL: // 0x021896FC
	.asciz "/act/ac_gmk_truck_lava.bac"
	.align 4
	
aBpaGmkTruckLav: // 0x02189718
	.asciz "/bpa/gmk_truck_lava.bpa"
	.align 4