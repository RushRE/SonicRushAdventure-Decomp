	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start EffectSailTrick3__Create
EffectSailTrick3__Create: // 0x0216CC64
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r7, r1
	ldr r0, _0216CD60 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x53
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r1, #0x10
	stmia sp, {r1, r6}
	str r0, [sp, #8]
	ldr r2, _0216CD64 // =aSbTrickBac_1
	mov r0, r4
	mov r1, #0
	mov r3, #0x200
	bl ObjObjectAction3dBACLoad
	cmp r7, #6
	blo _0216CCDC
	ldr r1, [r4, #0x20]
	sub r0, r7, #6
	orr r1, r1, #1
	mov r0, r0, lsl #0x10
	str r1, [r4, #0x20]
	mov r7, r0, lsr #0x10
_0216CCDC:
	add r0, r7, #0x10
	mov r1, r0, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x20]
	mov r2, #0x1d
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldr r1, [r4, #0x134]
	mov r0, r4
	strb r2, [r1, #0xa]
	ldr r1, [r4, #0x134]
	mov r2, #7
	strb r2, [r1, #0xb]
	bl SailObject__InitCommon
	mov r0, r4
	mov r1, r5
	mov r2, #0x400
	bl StageTask__SetParent
	mov r0, #0x2200
	rsb r0, r0, #0
	str r0, [r4, #0x6c]
	ldr r0, [r4, #0x20]
	tst r0, #1
	ldrne r0, [r4, #0x38]
	rsbne r0, r0, #0
	strne r0, [r4, #0x38]
	mov r0, r4
	bl EffectSailTrick3__SetupObject
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216CD60: .word 0x00001010
_0216CD64: .word aSbTrickBac_1
	arm_func_end EffectSailTrick3__Create

	arm_func_start SailJetJumpRamp__Create
SailJetJumpRamp__Create: // 0x0216CD68
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x28
	ldr r4, _0216CEC4 // =_0218BC74
	add r3, sp, #8
	mov r6, r0
	mov r2, #0xf
_0216CD80:
	ldrb r1, [r4, #0]
	ldrb r0, [r4, #1]
	add r4, r4, #2
	strb r1, [r3]
	strb r0, [r3, #1]
	add r3, r3, #2
	subs r2, r2, #1
	bne _0216CD80
	ldrb r0, [r4, #0]
	strb r0, [r3]
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x61
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0216CEC8 // =aSbJumpNsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, r4
	bl SailObject__InitCommon
	mov r0, r4
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r0, [r6, #0x28]
	str r0, [r4, #0x28]
	ldr r0, [r6, #0x34]
	tst r0, #0x80000000
	ldrne r0, [r4, #0x28]
	cmpne r0, #0
	cmpne r0, #1
	cmpne r0, #0x1e
	beq _0216CE40
	tst r0, #1
	subne r0, r0, #1
	strne r0, [r4, #0x28]
	addeq r0, r0, #1
	streq r0, [r4, #0x28]
_0216CE40:
	ldr r2, [r4, #0x28]
	add r1, sp, #8
	ldrb r1, [r1, r2]
	mov r0, r4
	bl EffectSailTrick3__Create
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0xc00
	bl SailObject__Func_21658D0
	mov r0, r4
	mov r1, #0
	bl StageTask__GetCollider
	mov r1, #0
	strh r1, [r0, #0x2c]
	strh r1, [r0, #0x2e]
	ldr r2, _0216CECC // =0x0000FFFE
	ldr r1, _0216CED0 // =SailJetJumpRamp__OnDefend
	strh r2, [r0, #0x32]
	str r1, [r0, #0x24]
	mov r1, #0x800
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	mov r0, r4
	str r1, [r4, #0x40]
	bl SailJetJumpRamp__SetupObject
	mov r0, r4
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216CEC4: .word _0218BC74
_0216CEC8: .word aSbJumpNsbmd_0
_0216CECC: .word 0x0000FFFE
_0216CED0: .word SailJetJumpRamp__OnDefend
	arm_func_end SailJetJumpRamp__Create

	arm_func_start SailJetCreateDashPanel
SailJetCreateDashPanel: // 0x0216CED4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x62
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	str r6, [sp]
	str r0, [sp, #4]
	mov r0, r5
	mov r1, #0
	ldr r2, _0216D014 // =aSbDashNsbmd_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0x63
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r5
	mov r1, #0
	ldr r2, _0216D018 // =aSbDashNsbta
	bl ObjAction3dNNMotionLoad
	ldr r0, [r5, #0x12c]
	mov r3, #0
	str r3, [sp]
	mov r1, #3
	ldr r2, [r0, #0x154]
	bl AnimatorMDL__SetAnimation
	ldr r1, [r5, #0x20]
	mov r0, r5
	orr r1, r1, #4
	str r1, [r5, #0x20]
	bl SailObject__InitCommon
	mov r0, r5
	mov r1, r7
	bl SailObject__InitFromMapObject
	ldr r1, [r7, #0x28]
	mov r0, r5
	str r1, [r5, #0x28]
	add r1, r4, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r0, r5
	mov r1, #0
	mov r2, #0xc00
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, r5
	mov r1, #0
	bl StageTask__GetCollider
	mov r1, #0
	strh r1, [r0, #0x2c]
	strh r1, [r0, #0x2e]
	ldr r1, _0216D01C // =0x0000FFFE
	strh r1, [r0, #0x32]
	ldr r2, _0216D020 // =SailJetDashPanel_OnDefend
	mov r1, #0x1000
	str r2, [r0, #0x24]
	str r1, [r5, #0x38]
	str r1, [r5, #0x3c]
	str r1, [r5, #0x40]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	add r1, r1, #0x8000
	strh r1, [r5, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r5
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216D014: .word aSbDashNsbmd_0
_0216D018: .word aSbDashNsbta
_0216D01C: .word 0x0000FFFE
_0216D020: .word SailJetDashPanel_OnDefend
	arm_func_end SailJetCreateDashPanel

	arm_func_start SailJetBob__Create
SailJetBob__Create: // 0x0216D024
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x13
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0216D148 // =aSbBobNsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, r4
	bl SailObject__InitCommon
	mov r0, r4
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r0, [r4, #0x48]
	sub r0, r0, #0x1800
	str r0, [r4, #0x48]
	bl SailManager__GetShipType
	cmp r0, #2
	moveq r0, #0x6000
	streq r0, [r5, #0x120]
	streq r0, [r5, #0x11c]
	mov r0, #0x190
	str r0, [r5, #0x118]
	ldrsh r2, [r6, #0x38]
	mov r0, r4
	add r1, r5, #0x28
	mov r2, r2, lsl #7
	add r2, r2, #0xd00
	str r2, [r5, #0x138]
	ldr r2, [r4, #0x24]
	mov r3, #0xc00
	orr r2, r2, #2
	str r2, [r4, #0x24]
	mov r2, #0
	str r3, [r5, #0x124]
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0xa80
	bl SailObject__Func_21658D0
	mov r0, r4
	bl StageTask__InitSeqPlayer
	ldrh r0, [r6, #0x30]
	cmp r0, #0xb
	mov r0, r4
	beq _0216D120
	bl SailJetBirdBob__SetupObject
	b _0216D124
_0216D120:
	bl SailJetBob__SetupObject
_0216D124:
	mov r0, #2
	bl SaveGame__CheckZoneBeaten
	cmp r0, #0
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #8
	streq r0, [r4, #0x18]
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216D148: .word aSbBobNsbmd_0
	arm_func_end SailJetBob__Create

	arm_func_start SailJetShark__Create
SailJetShark__Create: // 0x0216D14C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x14
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0216D2B4 // =aSbSharkNsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0x15
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r0, [sp]
	ldr r2, _0216D2B8 // =aSbSharkNsbca
	mov r3, r7
	mov r0, r4
	mov r1, #0
	bl ObjAction3dNNMotionLoad
	mov r1, #0
	ldr r0, [r4, #0x12c]
	mov r3, r1
	str r1, [sp]
	ldr r2, [r0, #0x148]
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	bl SailObject__InitCommon
	mov r0, r4
	mov r1, r6
	bl SailObject__InitFromMapObject
	mov r0, #0x1f4
	str r0, [r5, #0x118]
	bl SailManager__GetShipType
	cmp r0, #2
	moveq r0, #0x4000
	streq r0, [r5, #0x120]
	streq r0, [r5, #0x11c]
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0x800
	bl SailObject__Func_21658D0
	mov r0, r4
	bl StageTask__InitSeqPlayer
	ldrh r0, [r6, #0x30]
	cmp r0, #6
	beq _0216D2A0
	ldrsh r0, [r6, #0x38]
	mov r0, r0, lsl #8
	str r0, [r5, #0x138]
	ldr r0, [r6, #0x34]
	tst r0, #0x80000000
	ldrne r0, [r5, #0x138]
	rsbne r0, r0, #0
	strne r0, [r5, #0x138]
	ldrsh r1, [r6, #0x3a]
	mov r0, r4
	mov r1, r1, lsl #7
	add r1, r1, #0x400
	str r1, [r5, #0x13c]
	ldr r1, [r4, #0x48]
	sub r1, r1, #0x800
	str r1, [r4, #0x48]
	bl SailJetShark__SetupObject2
	b _0216D2A8
_0216D2A0:
	mov r0, r4
	bl SailJetShark__SetupObject
_0216D2A8:
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216D2B4: .word aSbSharkNsbmd_0
_0216D2B8: .word aSbSharkNsbca
	arm_func_end SailJetShark__Create

	arm_func_start SailJetBird__Create
SailJetBird__Create: // 0x0216D2BC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x16
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0216D3FC // =aSbBirdNsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, r4
	bl SailObject__InitCommon
	mov r0, r4
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r0, [r4, #0x48]
	sub r0, r0, #0x1800
	str r0, [r4, #0x48]
	bl SailManager__GetShipType
	cmp r0, #2
	moveq r0, #0x800
	streq r0, [r5, #0x120]
	streq r0, [r5, #0x11c]
	mov r0, #0xc8
	str r0, [r5, #0x118]
	ldrsh r2, [r6, #0x38]
	mov r0, r4
	add r1, r5, #0x28
	mov r2, r2, lsl #7
	add r2, r2, #0xd00
	str r2, [r5, #0x138]
	ldr r2, [r4, #0x24]
	mov r3, #0x800
	orr r2, r2, #2
	str r2, [r4, #0x24]
	mov r2, #0
	str r3, [r5, #0x124]
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0xa80
	bl SailObject__Func_21658D0
	mov r0, r4
	bl StageTask__InitSeqPlayer
	ldrh r0, [r6, #0x30]
	cmp r0, #0xc
	beq _0216D3B8
	mov r0, r4
	bl SailJetBirdBob__SetupObject
	b _0216D3F0
_0216D3B8:
	ldrsh r0, [r6, #0x38]
	mov r0, r0, lsl #8
	str r0, [r5, #0x138]
	ldr r0, [r6, #0x34]
	tst r0, #0x80000000
	ldrne r0, [r5, #0x138]
	rsbne r0, r0, #0
	strne r0, [r5, #0x138]
	ldrsh r1, [r6, #0x3a]
	mov r0, r4
	mov r1, r1, lsl #7
	add r1, r1, #0x400
	str r1, [r5, #0x13c]
	bl SailJetBird__SetupObject
_0216D3F0:
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216D3FC: .word aSbBirdNsbmd_0
	arm_func_end SailJetBird__Create

	arm_func_start EffectSailFlash__CreateFromJohnny
EffectSailFlash__CreateFromJohnny: // 0x0216D400
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x50
	add r3, sp, #0x44
	mov r2, #0
	add r1, sp, #0x38
	mov r10, r0
	str r2, [r3]
	str r2, [r3, #4]
	str r2, [r3, #8]
	str r2, [r1]
	str r2, [r1, #4]
	str r2, [r1, #8]
	bl SailManager__GetWork
	mov r4, r0
	ldr r11, [r10, #0x124]
	bl SailManager__GetWork
	ldrh r1, [r4, #0x10]
	mov r7, #0x1000
	mov r2, #0x480
	ldr r8, [r0, #0x98]
	add r0, r2, r1, lsl #8
	str r0, [sp]
	mov r0, #0x1000
	rsb r0, r0, #0
	mov r9, #0
	rsb r7, r7, #0
	str r0, [sp, #4]
	add r6, sp, #8
	add r5, sp, #0x44
	add r4, sp, #0x2c
_0216D478:
	mov r0, #0x1000
	str r0, [sp, #0x44]
	mov r0, #0
	str r7, [sp, #0x48]
	str r0, [sp, #0x4c]
	ldr r1, [r11, #0x178]
	ldr r0, [r8, #0x44]
	cmp r9, #0
	sub r2, r1, r0
	rsb r0, r2, #0
	mov r1, r0, asr #4
	mov r0, r2, asr #3
	str r0, [sp, #0x3c]
	mov r0, r2, asr #2
	str r1, [sp, #0x38]
	str r0, [sp, #0x40]
	beq _0216D4CC
	rsb r0, r1, #0
	str r0, [sp, #0x38]
	ldr r0, [sp, #4]
	str r0, [sp, #0x44]
_0216D4CC:
	ldrh r1, [r10, #0x32]
	mov r0, r6
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	ldr r1, _0216D578 // =FX_SinCosTable_
	mov r3, r2, lsl #1
	ldrsh r1, [r1, r3]
	ldr r3, _0216D578 // =FX_SinCosTable_
	add r2, r3, r2, lsl #1
	ldrsh r2, [r2, #2]
	bl MTX_RotY33_
	mov r0, r5
	mov r1, r6
	mov r2, r5
	bl MTX_MultVec33
	mov r0, r5
	add r1, r10, #0x44
	mov r2, r5
	bl VEC_Add
	add r0, sp, #0x38
	mov r1, r6
	mov r2, r0
	bl MTX_MultVec33
	ldmia r5, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	mov r0, r4
	add r1, sp, #0x38
	mov r2, r4
	bl VEC_Add
	ldr r3, [sp]
	mov r0, r10
	mov r1, r5
	mov r2, r4
	bl SailTorpedo2__Create
	mov r0, r5
	bl EffectSailFlash__Create
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #2
	blo _0216D478
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216D578: .word FX_SinCosTable_
	arm_func_end EffectSailFlash__CreateFromJohnny

	arm_func_start SailJetJumpRamp__SetupObject
SailJetJumpRamp__SetupObject: // 0x0216D57C
	ldr r1, [r0, #0x124]
	ldr r2, _0216D5A0 // =SailJetJumpRamp__State_216D604
	add r1, r1, #0x100
	str r2, [r0, #0xf4]
	ldrh r1, [r1, #0x6e]
	ldr ip, _0216D5A4 // =SailObject__ApplyRotation
	add r1, r1, #0x8000
	strh r1, [r0, #0x32]
	bx ip
	.align 2, 0
_0216D5A0: .word SailJetJumpRamp__State_216D604
_0216D5A4: .word SailObject__ApplyRotation
	arm_func_end SailJetJumpRamp__SetupObject

	arm_func_start SailJetJumpRamp__OnDefend
SailJetJumpRamp__OnDefend: // 0x0216D5A8
	stmdb sp!, {r4, lr}
	ldr r3, [r0, #0x3c]
	ldr r4, [r1, #0x3c]
	ldr r0, [r3, #0x6c]
	ldr r1, [r4, #0x6c]
	ldr r0, [r0, #0x124]
	ldr r2, [r1, #0x124]
	ldr r1, [r1, #0x28]
	add r0, r0, #0x100
	strh r1, [r0, #0xda]
	ldr r1, [r2, #0x164]
	ldr r1, [r1, #0x10]
	strh r1, [r0, #0xdc]
	ldrsh r1, [r0, #0xdc]
	mov r1, r1, asr #7
	strh r1, [r0, #0xdc]
	ldr r0, [r3, #0x6c]
	bl SailPlayer__Gimmick_JumpRamp
	ldr r1, [r4, #0x6c]
	ldr r0, [r1, #0x18]
	orr r0, r0, #2
	str r0, [r1, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end SailJetJumpRamp__OnDefend

	arm_func_start SailJetJumpRamp__State_216D604
SailJetJumpRamp__State_216D604: // 0x0216D604
	bx lr
	arm_func_end SailJetJumpRamp__State_216D604

	arm_func_start SailJetDashPanel_OnDefend
SailJetDashPanel_OnDefend: // 0x0216D608
	stmdb sp!, {r4, lr}
	ldr r2, [r0, #0x3c]
	ldr r4, [r1, #0x3c]
	ldr r3, [r2, #0x6c]
	ldr r2, [r3, #0x1c]
	tst r2, #1
	beq _0216D660
	ldr r1, [r4, #0x6c]
	mov r0, r3
	ldr r2, [r1, #0x28]
	add r1, r2, #0x1e
	add r2, r2, #0x1a
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	bl SailPlayer__Gimmick_DashPanel
	ldr r1, [r4, #0x6c]
	ldr r0, [r1, #0x18]
	orr r0, r0, #2
	str r0, [r1, #0x18]
	ldmia sp!, {r4, pc}
_0216D660:
	bl ObjRect__FuncNoHit
	ldmia sp!, {r4, pc}
	arm_func_end SailJetDashPanel_OnDefend

	arm_func_start SailJetBird__SetupObject
SailJetBird__SetupObject: // 0x0216D668
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r3, _0216D74C // =FX_SinCosTable_
	ldr r0, [r4, #0x13c]
	ldr r2, _0216D750 // =SailJetBird__State_216D754
	str r0, [r4, #0x134]
	ldr r1, [r4, #0x138]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r1, [r3, r1]
	smull r3, r1, r0, r1
	adds r3, r3, #0x800
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x134]
	str r2, [r5, #0xf4]
	bl SailManager__GetShipType
	cmp r0, #2
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x13c]
	ldr r2, _0216D74C // =FX_SinCosTable_
	add r0, r0, r0, lsl #1
	str r0, [r4, #0x134]
	ldr r1, [r4, #0x138]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r2, [r2, r1]
	mov r1, #5
	smull r3, r2, r0, r2
	adds r3, r3, #0x800
	adc r0, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [r4, #0x134]
	ldr r0, [r5, #0x24]
	orr r0, r0, #1
	str r0, [r5, #0x24]
	str r1, [r4, #0x13c]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x28]
	cmp r0, #0
	strne r0, [r4, #0x13c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216D74C: .word FX_SinCosTable_
_0216D750: .word SailJetBird__State_216D754
	arm_func_end SailJetBird__SetupObject

	arm_func_start SailJetBird__State_216D754
SailJetBird__State_216D754: // 0x0216D754
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x24
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetShipType
	cmp r0, #2
	bne _0216D7E0
	ldr r1, [r4, #0x164]
	ldr r0, [r1, #0x34]
	tst r0, #2
	ldreq r0, [r1, #0x28]
	cmpeq r0, #0
	beq _0216D7B0
	ldr r0, [r4, #0x128]
	cmp r0, #0
	ldreq r0, [r5, #0x28]
	cmpeq r0, #0x14
	bne _0216D7B0
	ldr r0, [r4, #0x13c]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SailJetBird__Func_21834D8
	str r0, [r4, #0x128]
_0216D7B0:
	ldr r0, [r4, #0x128]
	cmp r0, #0
	beq _0216D7CC
	sub r1, r0, #1
	mov r0, r5
	str r1, [r4, #0x128]
	bl SailHoverEnemyHover__Func_2187134
_0216D7CC:
	ldr r0, [r4, #0x128]
	cmp r0, #0
	ldreq r0, [r5, #0x28]
	addeq r0, r0, #1
	streq r0, [r5, #0x28]
_0216D7E0:
	ldr r0, [r4, #0x128]
	cmp r0, #0
	bne _0216D7F8
	mov r0, r5
	add r1, r5, #0x98
	bl SailObject__Func_216690C
_0216D7F8:
	add r0, r4, #0x100
	ldrh r0, [r0, #0x6e]
	ldr r1, [r4, #0x138]
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	cmp r1, #0
	mov r4, r0, lsr #0x10
	beq _0216D860
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _0216D884 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0
	bl MTX_RotY33_
	add r0, r5, #0x98
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
_0216D860:
	mov r1, #0
	mov r0, r5
	str r1, [r5, #0x9c]
	bl SailObject__Func_2166D18
	mov r0, r5
	strh r4, [r5, #0x32]
	bl SailObject__ApplyRotation
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216D884: .word FX_SinCosTable_
	arm_func_end SailJetBird__State_216D754

	arm_func_start SailJetBob__SetupObject
SailJetBob__SetupObject: // 0x0216D888
	stmdb sp!, {r4, lr}
	ldr r4, [r0, #0x124]
	ldr r1, _0216D8C0 // =SailJetBob__State_216D8C4
	str r1, [r0, #0xf4]
	bl SailManager__GetShipType
	cmp r0, #2
	ldmneia sp!, {r4, pc}
	mov r0, #5
	str r0, [r4, #0x13c]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x28]
	cmp r0, #0
	strne r0, [r4, #0x13c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216D8C0: .word SailJetBob__State_216D8C4
	arm_func_end SailJetBob__SetupObject

	arm_func_start SailJetBob__State_216D8C4
SailJetBob__State_216D8C4: // 0x0216D8C4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	mov r5, #0x14
	ldr r0, [r4, #0x164]
	mov r1, #0
	ldr r0, [r0, #0x34]
	tst r0, #8
	mov r0, r6
	movne r5, #4
	str r1, [r6, #0x9c]
	bl SailObject__Func_2166D18
	bl SailManager__GetShipType
	cmp r0, #2
	bne _0216D994
	ldr r1, [r4, #0x164]
	ldr r0, [r1, #0x34]
	tst r0, #2
	ldreq r0, [r1, #0x28]
	cmpeq r0, #0
	beq _0216D940
	ldr r0, [r4, #0x128]
	cmp r0, #0
	ldreq r0, [r6, #0x28]
	cmpeq r0, r5
	bne _0216D940
	ldr r0, [r4, #0x13c]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SailJetBird__Func_21834D8
	str r0, [r4, #0x128]
_0216D940:
	ldr r0, [r6, #0x24]
	bic r0, r0, #1
	str r0, [r6, #0x24]
	ldr r0, [r4, #0x128]
	cmp r0, #0
	beq _0216D980
	mov r0, #0
	str r0, [r4, #0x17c]
	ldr r1, [r4, #0x128]
	mov r0, r6
	sub r1, r1, #1
	str r1, [r4, #0x128]
	bl SailHoverEnemyHover__Func_2187134
	ldr r0, [r6, #0x24]
	orr r0, r0, #1
	str r0, [r6, #0x24]
_0216D980:
	ldr r0, [r4, #0x128]
	cmp r0, #0
	ldreq r0, [r6, #0x28]
	addeq r0, r0, #1
	streq r0, [r6, #0x28]
_0216D994:
	mov r0, r6
	bl SailObject__Func_2166728
	ldr r1, [r6, #0x48]
	mov r0, r6
	str r1, [r4, #0x14]
	bl SailObject__Func_2166834
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SailJetBob__State_216D8C4

	arm_func_start SailJetBirdBob__SetupObject
SailJetBirdBob__SetupObject: // 0x0216D9B0
	ldr r2, [r0, #0x124]
	mov r3, #0x800
	ldr r1, _0216D9C8 // =SailJetBirdBob__State_216D9CC
	str r3, [r2, #0x134]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0216D9C8: .word SailJetBirdBob__State_216D9CC
	arm_func_end SailJetBirdBob__SetupObject

	arm_func_start SailJetBirdBob__State_216D9CC
SailJetBirdBob__State_216D9CC: // 0x0216D9CC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r5, r0
	ldr r1, [r5, #0x44]
	ldr r2, [r5, #0x4c]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r2, #0
	rsblt r2, r2, #0
	ldr r4, [r5, #0x124]
	cmp r1, r2
	ldr r3, _0216DAE0 // =0x00000F5E
	ldr ip, _0216DAE4 // =0x0000065D
	mov lr, #0
	ble _0216DA40
	umull r0, r8, r1, r3
	mla r8, r1, lr, r8
	umull r7, r6, r2, ip
	mov r1, r1, asr #0x1f
	mla r8, r1, r3, r8
	adds r0, r0, #0x800
	adc r3, r8, #0
	adds r1, r7, #0x800
	mov r7, r0, lsr #0xc
	mla r6, r2, lr, r6
	mov r0, r2, asr #0x1f
	mla r6, r0, ip, r6
	adc r0, r6, #0
	mov r1, r1, lsr #0xc
	b _0216DA78
_0216DA40:
	umull r0, r8, r2, r3
	mla r8, r2, lr, r8
	umull r7, r6, r1, ip
	mov r2, r2, asr #0x1f
	mla r8, r2, r3, r8
	adds r0, r0, #0x800
	adc r3, r8, #0
	adds r2, r7, #0x800
	mov r7, r0, lsr #0xc
	mla r6, r1, lr, r6
	mov r0, r1, asr #0x1f
	mla r6, r0, ip, r6
	adc r0, r6, #0
	mov r1, r2, lsr #0xc
_0216DA78:
	orr r1, r1, r0, lsl #20
	orr r7, r7, r3, lsl #20
	add r6, r7, r1
	mov r1, #0
	mov r0, r5
	str r1, [r5, #0x9c]
	bl SailObject__Func_2166D18
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	strh r1, [r5, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r5
	add r1, r5, #0x98
	bl SailObject__Func_216690C
	cmp r6, #0x16000
	ldmgeia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r4, #0x134]
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r4, #0x134]
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r5
	bl SailJetBirdBob__Func_216DAE8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216DAE0: .word 0x00000F5E
_0216DAE4: .word 0x0000065D
	arm_func_end SailJetBirdBob__State_216D9CC

	arm_func_start SailJetBirdBob__Func_216DAE8
SailJetBirdBob__Func_216DAE8: // 0x0216DAE8
	ldr r3, [r0, #0x124]
	ldr r2, _0216DB00 // =SailJetBirdBob__State_216DB04
	mov r1, #0
	str r2, [r0, #0xf4]
	str r1, [r3, #0x128]
	bx lr
	.align 2, 0
_0216DB00: .word SailJetBirdBob__State_216DB04
	arm_func_end SailJetBirdBob__Func_216DAE8

	arm_func_start SailJetBirdBob__State_216DB04
SailJetBirdBob__State_216DB04: // 0x0216DB04
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r3, _0216DC54 // =0x00000F5E
	ldr r0, [r4, #0x15c]
	ldr ip, _0216DC58 // =0x0000065D
	ldr r0, [r0, #0x124]
	mov lr, #0
	ldr r0, [r0, #0x10]
	rsb r0, r0, #0
	str r0, [r4, #0x134]
	ldr r1, [r5, #0x44]
	ldr r2, [r5, #0x4c]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r1, r2
	ble _0216DB8C
	umull r0, r8, r1, r3
	mla r8, r1, lr, r8
	umull r7, r6, r2, ip
	mov r1, r1, asr #0x1f
	mla r8, r1, r3, r8
	adds r0, r0, #0x800
	adc r3, r8, #0
	adds r1, r7, #0x800
	mov r7, r0, lsr #0xc
	mla r6, r2, lr, r6
	mov r0, r2, asr #0x1f
	mla r6, r0, ip, r6
	adc r0, r6, #0
	mov r1, r1, lsr #0xc
	b _0216DBC4
_0216DB8C:
	umull r0, r8, r2, r3
	mla r8, r2, lr, r8
	umull r7, r6, r1, ip
	mov r2, r2, asr #0x1f
	mla r8, r2, r3, r8
	adds r0, r0, #0x800
	adc r3, r8, #0
	adds r2, r7, #0x800
	mov r7, r0, lsr #0xc
	mla r6, r1, lr, r6
	mov r0, r1, asr #0x1f
	mla r6, r0, ip, r6
	adc r0, r6, #0
	mov r1, r2, lsr #0xc
_0216DBC4:
	orr r7, r7, r3, lsl #20
	orr r1, r1, r0, lsl #20
	add r1, r7, r1
	cmp r1, #0x18000
	ldrlt r0, [r4, #0x134]
	sublt r0, r0, #0x200
	strlt r0, [r4, #0x134]
	cmp r1, #0x18000
	ldrgt r0, [r4, #0x134]
	add r1, r5, #0x98
	addgt r0, r0, #0x200
	strgt r0, [r4, #0x134]
	mov r0, r5
	bl SailObject__Func_216690C
	ldr r1, [r4, #0x128]
	cmp r1, #0x14
	blt _0216DC10
	mov r0, r5
	bl SailObject__ShakeScreen
_0216DC10:
	ldr r0, [r4, #0x128]
	cmp r0, #0x18
	ble _0216DC28
	mov r0, r5
	bl SailJetBirdBob__Func_216DC5C
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0216DC28:
	add r1, r0, #1
	mov r0, r5
	str r1, [r4, #0x128]
	bl SailObject__Func_2166728
	mov r0, r5
	bl SailObject__Func_2166834
	mov r1, #0
	mov r0, r5
	str r1, [r5, #0x9c]
	bl SailObject__Func_2166D18
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216DC54: .word 0x00000F5E
_0216DC58: .word 0x0000065D
	arm_func_end SailJetBirdBob__State_216DB04

	arm_func_start SailJetBirdBob__Func_216DC5C
SailJetBirdBob__Func_216DC5C: // 0x0216DC5C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r1, [r0, #0x124]
	ldr r3, _0216DD40 // =SailJetBirdBob__State_216DD4C
	mov r2, #0
	str r3, [r0, #0xf4]
	str r2, [r1, #0x128]
	ldr r2, [r0, #0x4c]
	ldr r4, [r1, #0x18]
	ldr r3, [r1, #0x10]
	ldr r0, [r0, #0x44]
	sub r2, r4, r2
	subs r0, r3, r0
	rsbmi r0, r0, #0
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r0, r2
	ldr r3, _0216DD44 // =0x00000F5E
	ldr ip, _0216DD48 // =0x0000065D
	mov lr, #0
	ble _0216DCEC
	umull r7, r6, r0, r3
	mla r6, r0, lr, r6
	umull r5, r4, r2, ip
	mov r0, r0, asr #0x1f
	mla r6, r0, r3, r6
	adds r7, r7, #0x800
	adc r6, r6, #0
	adds r3, r5, #0x800
	mov r5, r7, lsr #0xc
	mla r4, r2, lr, r4
	mov r0, r2, asr #0x1f
	mla r4, r0, ip, r4
	adc r0, r4, #0
	mov r2, r3, lsr #0xc
	orr r5, r5, r6, lsl #20
	b _0216DD28
_0216DCEC:
	umull r7, r6, r2, r3
	mla r6, r2, lr, r6
	umull r5, r4, r0, ip
	mla r4, r0, lr, r4
	mov r2, r2, asr #0x1f
	mov r0, r0, asr #0x1f
	mla r6, r2, r3, r6
	adds r7, r7, #0x800
	adc r3, r6, #0
	adds r2, r5, #0x800
	mla r4, r0, ip, r4
	mov r5, r7, lsr #0xc
	adc r0, r4, #0
	mov r2, r2, lsr #0xc
	orr r5, r5, r3, lsl #20
_0216DD28:
	orr r2, r2, r0, lsl #20
	add r0, r5, r2
	str r0, [r1, #0x13c]
	mov r0, #0
	str r0, [r1, #0x140]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216DD40: .word SailJetBirdBob__State_216DD4C
_0216DD44: .word 0x00000F5E
_0216DD48: .word 0x0000065D
	arm_func_end SailJetBirdBob__Func_216DC5C

	arm_func_start SailJetBirdBob__State_216DD4C
SailJetBirdBob__State_216DD4C: // 0x0216DD4C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x30
	mov r6, r0
	ldr r4, [r6, #0x12c]
	ldr r5, [r6, #0x124]
	bl SailManager__GetWork
	ldr r0, [r0, #0x98]
	ldrsh r0, [r0, #0x38]
	cmp r0, #0
	beq _0216DDCC
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _0216DF58 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0
	bl MTX_RotY33_
	add r0, r6, #0x44
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
	add r0, r5, #0x10
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
_0216DDCC:
	ldr r0, [r5, #0x128]
	cmp r0, #1
	beq _0216DE04
	cmp r0, #2
	beq _0216DE2C
	mov r0, r6
	bl SailObject__Func_21667BC
	ldr r0, [r5, #0x140]
	ldr r1, [r5, #0x13c]
	bl FX_Div
	cmp r0, #0x400
	movgt r0, #1
	strgt r0, [r5, #0x128]
	b _0216DE38
_0216DE04:
	ldr r0, [r5, #0x14]
	sub r0, r0, #0x100
	str r0, [r5, #0x14]
	ldr r0, [r5, #0x140]
	ldr r1, [r5, #0x13c]
	bl FX_Div
	cmp r0, #0x800
	movgt r0, #2
	strgt r0, [r5, #0x128]
	b _0216DE38
_0216DE2C:
	ldr r0, [r5, #0x14]
	sub r0, r0, #0x400
	str r0, [r5, #0x14]
_0216DE38:
	mov r0, r6
	bl SailObject__Func_2166834
	ldr r0, [r6, #0x24]
	mov r1, #0
	orr r0, r0, #1
	str r0, [r6, #0x24]
	ldr r2, [r5, #0x138]
	add r0, sp, #0x24
	str r2, [sp, #0x2c]
	str r1, [sp, #0x24]
	str r1, [sp, #0x28]
	add r1, r4, #0x24
	add r2, r6, #0x98
	bl MTX_MultVec33
	ldr r0, [r6, #0x9c]
	ldr r3, _0216DF5C // =0x00000F5E
	rsb r0, r0, #0
	str r0, [r6, #0x9c]
	ldr r1, [r6, #0x98]
	ldr r2, [r6, #0xa0]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r1, r2
	ldr r4, _0216DF60 // =0x0000065D
	mov ip, #0
	ble _0216DEF0
	umull r0, lr, r1, r3
	mla lr, r1, ip, lr
	umull r8, r7, r2, r4
	mov r1, r1, asr #0x1f
	mla lr, r1, r3, lr
	adds r0, r0, #0x800
	adc r3, lr, #0
	adds r1, r8, #0x800
	mov r8, r0, lsr #0xc
	mla r7, r2, ip, r7
	mov r0, r2, asr #0x1f
	mla r7, r0, r4, r7
	adc r0, r7, #0
	mov r1, r1, lsr #0xc
	orr r8, r8, r3, lsl #20
	orr r1, r1, r0, lsl #20
	add r2, r8, r1
	b _0216DF34
_0216DEF0:
	umull r0, r8, r2, r3
	mla r8, r2, ip, r8
	umull r7, lr, r1, r4
	mov r2, r2, asr #0x1f
	mla r8, r2, r3, r8
	adds r0, r0, #0x800
	adc r3, r8, #0
	adds r2, r7, #0x800
	mov r7, r0, lsr #0xc
	mla lr, r1, ip, lr
	mov r0, r1, asr #0x1f
	mla lr, r0, r4, lr
	adc r0, lr, #0
	mov r1, r2, lsr #0xc
	orr r7, r7, r3, lsl #20
	orr r1, r1, r0, lsl #20
	add r2, r7, r1
_0216DF34:
	ldr r1, [r5, #0x140]
	add r0, r5, #0x10
	add r3, r1, r2
	add r1, r6, #0x98
	mov r2, r0
	str r3, [r5, #0x140]
	bl VEC_Add
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216DF58: .word FX_SinCosTable_
_0216DF5C: .word 0x00000F5E
_0216DF60: .word 0x0000065D
	arm_func_end SailJetBirdBob__State_216DD4C

	arm_func_start SailJetShark__SetupObject2
SailJetShark__SetupObject2: // 0x0216DF64
	stmdb sp!, {r3, lr}
	ldr r2, [r0, #0x124]
	ldr lr, _0216DFC4 // =FX_SinCosTable_
	ldr r1, [r2, #0x13c]
	ldr ip, _0216DFC8 // =SailJetShark__State_216DFCC
	str r1, [r2, #0x134]
	ldr r3, [r2, #0x138]
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, asr #4
	mov r3, r3, lsl #1
	add r3, r3, #1
	mov r3, r3, lsl #1
	ldrsh r3, [lr, r3]
	smull lr, r3, r1, r3
	adds lr, lr, #0x800
	adc r1, r3, #0
	mov r3, lr, lsr #0xc
	orr r3, r3, r1, lsl #20
	str r3, [r2, #0x134]
	str ip, [r0, #0xf4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216DFC4: .word FX_SinCosTable_
_0216DFC8: .word SailJetShark__State_216DFCC
	arm_func_end SailJetShark__SetupObject2

	arm_func_start SailJetShark__State_216DFCC
SailJetShark__State_216DFCC: // 0x0216DFCC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x24
	mov r5, r0
	ldr r4, [r5, #0x124]
	add r1, r5, #0x98
	bl SailObject__Func_216690C
	add r0, r4, #0x100
	ldr r1, [r4, #0x138]
	ldrh r0, [r0, #0x6e]
	cmp r1, #0
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	beq _0216E04C
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _0216E070 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0
	bl MTX_RotY33_
	add r0, r5, #0x98
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
_0216E04C:
	mov r1, #0
	mov r0, r5
	str r1, [r5, #0x9c]
	bl SailObject__Func_2166D18
	mov r0, r5
	strh r4, [r5, #0x32]
	bl SailObject__ApplyRotation
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216E070: .word FX_SinCosTable_
	arm_func_end SailJetShark__State_216DFCC

	arm_func_start SailJetShark__SetupObject
SailJetShark__SetupObject: // 0x0216E074
	ldr r1, [r0, #0x20]
	mov r2, #0x400
	orr r1, r1, #0x20
	orr r1, r1, #0x1000
	str r1, [r0, #0x20]
	ldr r3, [r0, #0x18]
	ldr r1, _0216E0A4 // =SailJetShark__State_216E0A8
	orr r3, r3, #0x12
	str r3, [r0, #0x18]
	str r2, [r0, #0x48]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0216E0A4: .word SailJetShark__State_216E0A8
	arm_func_end SailJetShark__SetupObject

	arm_func_start SailJetShark__State_216E0A8
SailJetShark__State_216E0A8: // 0x0216E0A8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r0, [r0, #0x98]
	mvn ip, #0
	ldrh r1, [r0, #0x34]
	ldr lr, _0216E188 // =FX_SinCosTable_
	mov r0, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	ldrsh r6, [lr, r1]
	mov r3, ip, lsl #0xc
	add r2, r2, #1
	umull r7, r1, r6, r3
	mla r1, r6, ip, r1
	mov ip, r6, asr #0x1f
	mov r2, r2, lsl #1
	ldrsh lr, [lr, r2]
	mla r1, ip, r3, r1
	adds r2, r7, #0x800
	mov r3, lr, asr #0x1f
	mov ip, r3, lsl #0xc
	str r0, [sp, #4]
	mov r3, #0x800
	adc r1, r1, #0
	mov r6, r2, lsr #0xc
	adds r3, r3, lr, lsl #12
	orr r6, r6, r1, lsl #20
	orr ip, ip, lr, lsr #20
	adc r1, ip, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	rsb r1, r2, #0
	str r6, [sp]
	add r0, r4, #0x100
	str r1, [sp, #8]
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	add r1, r1, #0x8000
	strh r1, [r5, #0x32]
	bl SailObject__ApplyRotation
	add r0, sp, #0
	add r1, r5, #0x44
	bl VEC_DotProduct
	mov r1, #0x3000
	rsb r1, r1, #0
	cmp r0, r1
	addge sp, sp, #0xc
	ldmgeia sp!, {r4, r5, r6, r7, pc}
	mov r0, r5
	bl SailJetShark__Func_216E18C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216E188: .word FX_SinCosTable_
	arm_func_end SailJetShark__State_216E0A8

	arm_func_start SailJetShark__Func_216E18C
SailJetShark__Func_216E18C: // 0x0216E18C
	ldr r2, [r0, #0x20]
	ldr r1, [r0, #0x124]
	bic r2, r2, #0x20
	str r2, [r0, #0x20]
	bic r3, r2, #0x1000
	str r3, [r0, #0x20]
	ldr r2, _0216E204 // =SailJetShark__State_216E214
	ldr r3, _0216E208 // =_mt_math_rand
	str r2, [r0, #0xf4]
	mov r2, #0
	str r2, [r0, #0x2c]
	mov r0, #0x8000
	str r0, [r1, #0x140]
	ldr ip, [r3]
	ldr r0, _0216E20C // =0x00196225
	ldr r2, _0216E210 // =0x3C6EF35F
	mla r2, ip, r0, r2
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r2, [r3]
	tst r0, #1
	ldrne r0, [r1, #0x140]
	rsbne r0, r0, #0
	strne r0, [r1, #0x140]
	mov r0, #0x1dc0
	str r0, [r1, #0x13c]
	mov r0, #0
	str r0, [r1, #0x144]
	bx lr
	.align 2, 0
_0216E204: .word SailJetShark__State_216E214
_0216E208: .word _mt_math_rand
_0216E20C: .word 0x00196225
_0216E210: .word 0x3C6EF35F
	arm_func_end SailJetShark__Func_216E18C

	arm_func_start SailJetShark__State_216E214
SailJetShark__State_216E214: // 0x0216E214
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	add r1, r5, #0x98
	ldr r2, [r4, #0x15c]
	ldr r2, [r2, #0x124]
	ldr r2, [r2, #0x10]
	rsb r3, r2, #0
	str r3, [r4, #0x134]
	ldr r2, [r4, #0x13c]
	sub r2, r3, r2
	str r2, [r4, #0x134]
	bl SailObject__Func_216690C
	add r0, r5, #0x44
	bl GetSailSeaSurfacePosition
	add r1, r0, #0x400
	ldr r2, [r4, #0x144]
	add r0, r4, #0x100
	add r1, r2, r1
	str r1, [r5, #0x48]
	ldrh r2, [r0, #0x6e]
	ldr r1, [r4, #0x140]
	mov r0, r5
	add r1, r2, r1
	strh r1, [r5, #0x32]
	bl SailObject__ApplyRotation
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #6
	ldmleia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x144]
	mov r1, #0x80
	mov r2, #0x800
	bl ObjSpdUpSet
	str r0, [r4, #0x144]
	ldr r0, [r4, #0x13c]
	mov r1, #0x2c0
	bl ObjSpdDownSet
	str r0, [r4, #0x13c]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl EffectSailWaterSplash2__Create
	ldr r1, [r0, #0x24]
	mov r2, #0x800
	orr r1, r1, #1
	str r1, [r0, #0x24]
	str r2, [r0, #0x38]
	mov r1, #0x1000
	str r1, [r0, #0x3c]
	str r2, [r0, #0x40]
	mov r0, r5
	bl SailJetShark__Func_216E2F0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailJetShark__State_216E214

	arm_func_start SailJetShark__Func_216E2F0
SailJetShark__Func_216E2F0: // 0x0216E2F0
	ldr r1, [r0, #0x18]
	mov r2, #0
	bic r1, r1, #0x10
	orr r1, r1, #2
	str r1, [r0, #0x18]
	ldr r1, _0216E314 // =SailJetShark__State_216E318
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0216E314: .word SailJetShark__State_216E318
	arm_func_end SailJetShark__Func_216E2F0

	arm_func_start SailJetShark__State_216E318
SailJetShark__State_216E318: // 0x0216E318
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	add r1, r5, #0x98
	ldr r2, [r4, #0x15c]
	ldr r2, [r2, #0x124]
	ldr r2, [r2, #0x10]
	rsb r2, r2, #0
	str r2, [r4, #0x134]
	bl SailObject__Func_216690C
	ldr r0, [r4, #0x144]
	mov r1, #0x80
	mov r2, #0x800
	bl ObjSpdUpSet
	str r0, [r4, #0x144]
	add r0, r5, #0x44
	bl GetSailSeaSurfacePosition
	add r1, r0, #0x400
	ldr r2, [r4, #0x144]
	add r0, r4, #0x100
	add r1, r2, r1
	str r1, [r5, #0x48]
	ldrh r2, [r0, #0x6e]
	ldr r1, [r4, #0x140]
	mov r0, r5
	add r1, r2, r1
	strh r1, [r5, #0x32]
	bl SailObject__ApplyRotation
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #6
	ldmleia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl SailJetShark__Func_216E3A8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailJetShark__State_216E318

	arm_func_start SailJetShark__Func_216E3A8
SailJetShark__Func_216E3A8: // 0x0216E3A8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, #1
	bl AnimatorMDL__SetAnimation
	mov r0, r4
	mov r1, #0x2000
	bl SailObject__SetAnimSpeed
	ldr r0, [r4, #0x20]
	mov r1, #0
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x18]
	mov r2, #0x30
	bic r0, r0, #2
	str r0, [r4, #0x18]
	ldr r3, [r4, #0x1c]
	mov r0, #0xf00
	orr r3, r3, #0x80
	str r3, [r4, #0x1c]
	str r2, [r4, #0xd8]
	str r0, [r4, #0xdc]
	ldr r0, _0216E464 // =SailJetShark__State_216E468
	str r1, [r4, #0x2c]
	str r0, [r4, #0xf4]
	sub r0, r1, #0x3e0
	str r0, [r4, #0x9c]
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #1
	str r1, [r4, #0x24]
	bl SailObject__Func_2166728
	mov r0, #0xa000
	rsb r0, r0, #0
	str r0, [r4, #0x2c]
	mov r0, #0
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x138]
	add r2, r4, #0x44
	mov r1, #0x11
	bl SailAudio__PlaySpatialSequence
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216E464: .word SailJetShark__State_216E468
	arm_func_end SailJetShark__Func_216E3A8

	arm_func_start SailJetShark__State_216E468
SailJetShark__State_216E468: // 0x0216E468
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x30
	mov r6, r0
	ldr r4, [r6, #0x12c]
	ldr r5, [r6, #0x124]
	bl SailManager__GetWork
	ldr r0, [r0, #0x98]
	ldrsh r0, [r0, #0x38]
	cmp r0, #0
	beq _0216E4E8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _0216E5F8 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0xc
	bl MTX_RotY33_
	add r0, r6, #0x44
	add r1, sp, #0xc
	mov r2, r0
	bl MTX_MultVec33
	add r0, r5, #0x10
	add r1, sp, #0xc
	mov r2, r0
	bl MTX_MultVec33
_0216E4E8:
	add r0, r5, #0x10
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r2, [r5, #0x14]
	ldr r1, [r6, #0x2c]
	mov r0, r6
	add r1, r2, r1
	str r1, [r5, #0x14]
	bl SailObject__Func_2166834
	add r0, sp, #0
	add r3, r5, #0x10
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r6, #0x2c]
	mov r1, #0x800
	mov r2, #0x8000
	bl ObjSpdUpSet
	str r0, [r6, #0x2c]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	mov r0, #0x9d0
	str r0, [sp, #8]
	add r0, sp, #0
	add r1, r4, #0x24
	mov r2, r0
	bl MTX_MultVec33
	ldr r1, [sp]
	add r0, r5, #0x10
	str r1, [r6, #0x98]
	ldr r3, [sp, #8]
	mov r2, r0
	add r1, r6, #0x98
	str r3, [r6, #0xa0]
	bl VEC_Add
	ldr r0, [r6, #0x28]
	cmp r0, #0
	addne sp, sp, #0x30
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, [r6, #0x9c]
	cmp r0, #0
	addle sp, sp, #0x30
	ldmleia sp!, {r4, r5, r6, pc}
	mov r0, #0x800
	ldr r1, [r6, #0x48]
	rsb r0, r0, #0
	cmp r1, r0
	addle sp, sp, #0x30
	ldmleia sp!, {r4, r5, r6, pc}
	mov r0, r6
	bl EffectSailWaterSplash2__Create
	ldr r1, [r0, #0x24]
	mov r2, #0x800
	orr r1, r1, #1
	str r1, [r0, #0x24]
	str r2, [r0, #0x38]
	mov r1, #0x1000
	str r1, [r0, #0x3c]
	str r2, [r0, #0x40]
	mov r0, #1
	str r0, [r6, #0x28]
	ldr r0, [r6, #0x138]
	add r2, r6, #0x44
	mov r1, #9
	bl SailAudio__PlaySpatialSequence
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216E5F8: .word FX_SinCosTable_
	arm_func_end SailJetShark__State_216E468

	arm_func_start EffectSailTrick3__SetupObject
EffectSailTrick3__SetupObject: // 0x0216E5FC
	ldr r1, _0216E610 // =EffectSailTrick3__State_216E614
	str r1, [r0, #0xf4]
	ldr r1, [r0, #0x38]
	str r1, [r0, #0x28]
	bx lr
	.align 2, 0
_0216E610: .word EffectSailTrick3__State_216E614
	arm_func_end EffectSailTrick3__SetupObject

	arm_func_start EffectSailTrick3__State_216E614
EffectSailTrick3__State_216E614: // 0x0216E614
	ldr r1, [r0, #0x11c]
	ldr ip, _0216E634 // =SailObject__Func_2166D18
	ldr r1, [r1, #0x18]
	tst r1, #2
	ldrne r1, [r0, #0x18]
	orrne r1, r1, #4
	strne r1, [r0, #0x18]
	bx ip
	.align 2, 0
_0216E634: .word SailObject__Func_2166D18
	arm_func_end EffectSailTrick3__State_216E614

	.rodata

_0218BC74: // 0x0218BC74
    .byte 0, 2, 0, 0, 2, 2, 1, 7, 0, 0, 2, 2, 0, 0, 2, 2, 3, 9, 3, 9, 0, 0, 3, 9, 3, 9, 3, 9, 5, 5, 4, 0

	.data

aSbTrickBac_1: // 0x0218D3C4
	.asciz "sb_trick.bac"
    .align 4

aSbJumpNsbmd_0: // 0x0218D3D4
	.asciz "sb_jump.nsbmd"
    .align 4

aSbDashNsbmd_0: // 0x0218D3E4
	.asciz "sb_dash.nsbmd"
    .align 4

aSbDashNsbta: // 0x0218D3F4
	.asciz "sb_dash.nsbta"
    .align 4

aSbBobNsbmd_0: // 0x0218D404
	.asciz "sb_bob.nsbmd"
    .align 4

aSbSharkNsbmd_0: // 0x0218D414
	.asciz "sb_shark.nsbmd"
    .align 4

aSbSharkNsbca: // 0x0218D424
	.asciz "sb_shark.nsbca"
    .align 4

aSbBirdNsbmd_0: // 0x0218D434
	.asciz "sb_bird.nsbmd"
    .align 4