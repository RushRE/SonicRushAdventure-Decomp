	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailSubTargetHUD__Create
SailSubTargetHUD__Create: // 0x0217FFB4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r8, r0
	mov r7, r1
	ldr r0, _0218016C // =0x00001010
	mov r1, #1
	mov r6, r2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #2
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x24
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x2c
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	ldr r3, _02180170 // =0x0000FFFF
	ldr r2, _02180174 // =aSbSubFixBac
	stmia sp, {r3, r9}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r3, [r4, #0x134]
	mov r0, r4
	ldr r2, [r3, #0xf4]
	mov r1, #0
	bic r2, r2, #0x3f000000
	orr r2, r2, #0x29000000
	str r2, [r3, #0xf4]
	bl StageTask__SetAnimation
	mov r0, r4
	bl SailObject__InitCommon
	ldr r0, [r4, #0x20]
	mov r1, #0x1000
	orr r0, r0, #0x20000
	str r0, [r4, #0x20]
	ldr r2, [r4, #0x24]
	mov r0, r4
	orr r2, r2, #1
	str r2, [r4, #0x24]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	ldr ip, [r4, #0x134]
	mov r1, r8
	ldr r3, [ip, #0xcc]
	mov r2, #0x200
	orr r3, r3, #0x2000
	str r3, [ip, #0xcc]
	bl StageTask__SetParent
	ldr r1, _02180178 // =0x00000CBF
	mov r0, r4
	bl SailObject__SetSpriteColor
	mov r1, #0
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl StageTask__InitCollider
	mov r0, r4
	mov r1, #0
	bl StageTask__GetCollider
	ldr r2, _0218017C // =SailSubTargetHUD__OnDefend_2182144
	ldr r1, _02180180 // =0x00080004
	str r2, [r0, #0x24]
	orr r1, r1, #0x800
	str r1, [r0, #0x18]
	ldr r1, _02180184 // =SailSubTargetHUD__Check_21820C8
	str r5, [r0, #0x3c]
	str r1, [r0, #0x28]
	mov r1, #8
	strh r1, [r0, #0x34]
	mov r1, #0
	strh r1, [r0, #0x2c]
	mov r1, #0xa
	strh r1, [r0, #0x2e]
	mov r0, #0x1a000
	str r0, [r5]
	ldr r0, _02180188 // =SailSubTargetHUD__State_2181290
	str r7, [r5, #0x10]
	str r0, [r4, #0xf4]
	ldr r0, [r8, #0x24]
	tst r0, #0x10000
	ldrne r0, [r4, #0x24]
	orrne r0, r0, #0x10000
	strne r0, [r4, #0x24]
	ldr r0, [r8, #0x24]
	tst r0, #0x100
	beq _02180150
	str r6, [r5, #0x1c]
	ldr r0, [r4, #0x24]
	ldr r1, _0218018C // =SailSubTargetHUD__State_2181558
	orr r0, r0, #0x100
	str r0, [r4, #0x24]
	mov r0, r4
	str r1, [r4, #0xf4]
	bl SailSubTargetLockOnHUD2__Create
	mov r0, r4
	mov r1, #0
	bl SailSubArrowHUD__Create
_02180150:
	mov r0, r4
	bl SailSubTouchPrompt__Create
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0218016C: .word 0x00001010
_02180170: .word 0x0000FFFF
_02180174: .word aSbSubFixBac
_02180178: .word 0x00000CBF
_0218017C: .word SailSubTargetHUD__OnDefend_2182144
_02180180: .word 0x00080004
_02180184: .word SailSubTargetHUD__Check_21820C8
_02180188: .word SailSubTargetHUD__State_2181290
_0218018C: .word SailSubTargetHUD__State_2181558
	arm_func_end SailSubTargetHUD__Create

	arm_func_start SailUnknown2180190__Create
SailUnknown2180190__Create: // 0x02180190
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, _02180254 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r5, r0
	mov r1, #2
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x10
	bl StageTask__AllocateWorker
	mov r4, r0
	ldr r1, [r5, #0x18]
	mov r0, r5
	orr r1, r1, #0x10
	str r1, [r5, #0x18]
	mov r1, #0
	mov r2, r1
	mov r3, r1
	bl StageTask__InitCollider
	mov r0, r5
	mov r1, #0
	bl StageTask__GetCollider
	mov r1, r6
	mov r2, #0
	str r2, [r0, #0x24]
	ldr ip, _02180258 // =0x00080004
	ldr r3, _0218025C // =SailSubTargetHUD__Check_21820C8
	str ip, [r0, #0x18]
	str r4, [r0, #0x3c]
	str r3, [r0, #0x28]
	ldr r3, _02180260 // =0x00000804
	mov ip, #0xa
	strh r3, [r0, #0x34]
	ldrh lr, [r0, #0x30]
	mov r3, #0x1000
	orr lr, lr, #2
	strh lr, [r0, #0x30]
	strh ip, [r0, #0x2c]
	strh ip, [r0, #0x2e]
	str r3, [r4]
	mov r0, r5
	bl StageTask__SetParent
	mov r0, r5
	bl StageTask__InitSeqPlayer
	ldr r1, _02180264 // =SailUnknown2180190__State_21819A0
	mov r0, r5
	str r1, [r5, #0xf4]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02180254: .word 0x00001010
_02180258: .word 0x00080004
_0218025C: .word SailSubTargetHUD__Check_21820C8
_02180260: .word 0x00000804
_02180264: .word SailUnknown2180190__State_21819A0
	arm_func_end SailUnknown2180190__Create

	arm_func_start SailSubTargetLockOnHUD__Create
SailSubTargetLockOnHUD__Create: // 0x02180268
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r6, r0
	mov r5, r1
	ldr r0, _02180348 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x2c
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	ldr r3, _0218034C // =0x0000FFFF
	ldr r2, _02180350 // =aSbSubFixBac
	stmia sp, {r3, r7}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #9
	bl StageTask__SetAnimation
	ldr r0, [r6, #0x24]
	tst r0, #0x10000
	beq _021802EC
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0x1000
	bl SailObject__SetAnimSpeed
_021802EC:
	mov r0, r4
	bl SailObject__InitCommon
	ldr r0, [r4, #0x20]
	mov r3, #0x1000
	orr r0, r0, #0x20000
	str r0, [r4, #0x20]
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #1
	str r1, [r4, #0x24]
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	mov r1, r6
	mov r2, #0
	str r3, [r4, #0x40]
	bl StageTask__SetParent
	add r0, r5, #5
	ldr r1, _02180354 // =SailSubTargetLockOnHUD__State_2181B70
	str r0, [r4, #0x28]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02180348: .word 0x00001010
_0218034C: .word 0x0000FFFF
_02180350: .word aSbSubFixBac
_02180354: .word SailSubTargetLockOnHUD__State_2181B70
	arm_func_end SailSubTargetLockOnHUD__Create

	arm_func_start SailSubTouchPrompt__Create
SailSubTouchPrompt__Create: // 0x02180358
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _02180438 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x58
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _0218043C // =0x0000FFFF
	ldr r2, _02180440 // =aSbSubLogoFixBa
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x24]
	tst r0, #0x100
	beq _021803CC
	mov r0, r4
	mov r1, #4
	bl StageTask__SetAnimation
_021803CC:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	bl SailObject__InitCommon
	ldr r1, [r4, #0x20]
	mov r0, #0
	orr r1, r1, #0x20000
	orr r1, r1, #0x20
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x24]
	mov r3, #0x1000
	orr r1, r1, #1
	str r1, [r4, #0x24]
	str r0, [r4, #0x28]
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	mov r0, r4
	mov r1, r5
	mov r2, #0x200
	str r3, [r4, #0x40]
	bl StageTask__SetParent
	ldr r1, _02180444 // =SailSubTouchPrompt__State_2181D4C
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02180438: .word 0x00001010
_0218043C: .word 0x0000FFFF
_02180440: .word aSbSubLogoFixBa
_02180444: .word SailSubTouchPrompt__State_2181D4C
	arm_func_end SailSubTouchPrompt__Create

	arm_func_start SailSubArrowHUD__Create
SailSubArrowHUD__Create: // 0x02180448
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r7, r1
	ldr r0, _02180514 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x2c
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r2, _02180518 // =0x0000FFFF
	mov r1, #0
	stmia sp, {r2, r6}
	str r0, [sp, #8]
	ldr r2, _0218051C // =aSbSubFixBac
	mov r0, r4
	mov r3, #0x80
	bl ObjObjectAction3dBACLoad
	cmp r7, #0
	mov r0, r4
	beq _021804B8
	mov r1, #0x11
	bl StageTask__SetAnimation
	b _021804C0
_021804B8:
	mov r1, #0xe
	bl StageTask__SetAnimation
_021804C0:
	mov r0, r4
	bl SailObject__InitCommon
	mov r0, #0x1000
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x20000
	str r1, [r4, #0x20]
	ldr r2, [r4, #0x24]
	mov r1, r5
	orr r3, r2, #1
	mov r2, #0
	str r3, [r4, #0x24]
	bl StageTask__SetParent
	ldr r1, _02180520 // =SailSubArrowHUD__State_2181BDC
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02180514: .word 0x00001010
_02180518: .word 0x0000FFFF
_0218051C: .word aSbSubFixBac
_02180520: .word SailSubArrowHUD__State_2181BDC
	arm_func_end SailSubArrowHUD__Create

	arm_func_start SailSubTargetLockOnHUD2__Create
SailSubTargetLockOnHUD2__Create: // 0x02180524
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	ldr r0, _021805F8 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x2c
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	ldr r3, _021805FC // =0x0000FFFF
	ldr r2, _02180600 // =aSbSubFixBac
	stmia sp, {r3, r5}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #9
	bl StageTask__SetAnimation
	mov r0, r4
	bl SailObject__InitCommon
	ldr r0, [r4, #0x20]
	mov r3, #0x1000
	orr r0, r0, #0x20000
	str r0, [r4, #0x20]
	ldr r2, [r4, #0x24]
	mov r1, r6
	orr r2, r2, #1
	str r2, [r4, #0x24]
	ldr ip, [r4, #0x20]
	mov r0, r4
	orr ip, ip, #0x24
	orr ip, ip, #0x1000
	str ip, [r4, #0x20]
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	str r3, [r4, #0x40]
	ldr ip, [r4, #0x134]
	mov r2, #0
	ldr r3, [ip, #0xf4]
	bic r3, r3, #0x3f000000
	orr r3, r3, #0x28000000
	str r3, [ip, #0xf4]
	bl StageTask__SetParent
	ldr r1, _02180604 // =SailSubTargetLockOnHUD2__State_2181E80
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_021805F8: .word 0x00001010
_021805FC: .word 0x0000FFFF
_02180600: .word aSbSubFixBac
_02180604: .word SailSubTargetLockOnHUD2__State_2181E80
	arm_func_end SailSubTargetLockOnHUD2__Create

	arm_func_start SailSubTorpedo1__Create
SailSubTorpedo1__Create: // 0x02180608
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x2c
	mov r7, r0
	mov r6, r1
	bl CreateStageTask_
	mov r5, r0
	mov r1, #2
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x23
	bl GetObjectFileWork
	mov r8, r0
	bl SailManager__GetArchive
	str r8, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02180780 // =aSbTorpedoNsbmd_1
	mov r0, r5
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #0x20000000
	orr r1, r1, #0x40
	str r1, [r5, #0x24]
	bl SailObject__InitCommon
	mov r0, r7
	add r1, r5, #0x44
	bl SailObject__Func_2165A9C
	ldr r1, [r5, #0x4c]
	ldr r3, _02180784 // =FX_SinCosTable_
	add r1, r1, #0x12000
	str r1, [r5, #0x4c]
	ldrh r1, [r7, #0x32]
	add r0, sp, #8
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
	add r0, r5, #0x44
	add r1, sp, #8
	mov r2, r0
	bl MTX_MultVec33
	add r0, r5, #0x44
	add r1, r7, #0x44
	mov r2, r0
	bl VEC_Add
	mov r1, r7
	mov r0, r5
	mov r2, #0
	bl StageTask__SetParent
	mov r0, r5
	add r1, r4, #0x28
	mov r2, #1
	bl SailObject__SetupHitbox
	mov r0, r5
	mov r1, #1
	mov r2, #0x800
	mov r3, #0
	bl SailObject__Func_21658D0
	str r6, [r4, #0x15c]
	ldr r1, [r5, #0x44]
	mov r0, r5
	str r1, [r4, #0x138]
	ldr r1, [r5, #0x48]
	str r1, [r4, #0x13c]
	ldr r1, [r5, #0x4c]
	str r1, [r4, #0x140]
	bl SailObject__Func_2166728
	mov r0, r5
	bl SailObject__Func_2166834
	mov r0, r5
	bl EffectSailSubmarineWater2__Create
	mov r0, #0
	mov r2, r0
	mov r1, #0x49
	bl SailAudio__PlaySpatialSequence
	ldr r1, _02180788 // =SailSubTorpedo2__State_2181F50
	mov r0, r5
	str r1, [r5, #0xf4]
	add sp, sp, #0x2c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02180780: .word aSbTorpedoNsbmd_1
_02180784: .word FX_SinCosTable_
_02180788: .word SailSubTorpedo2__State_2181F50
	arm_func_end SailSubTorpedo1__Create

	arm_func_start SailSubTorpedo2__Create
SailSubTorpedo2__Create: // 0x0218078C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x2c
	mov r8, r0
	mov r7, r1
	mov r6, r2
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x23
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	str r9, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02180914 // =aSbTorpedoNsbmd_1
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #0x20000000
	orr r1, r1, #0x40
	str r1, [r4, #0x24]
	bl SailObject__InitCommon
	ldrh r1, [r8, #0x32]
	ldr r3, _02180918 // =FX_SinCosTable_
	add r0, sp, #8
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
	mov r0, r6
	add r1, sp, #8
	add r2, r4, #0x44
	bl MTX_MultVec33
	add r0, r4, #0x44
	add r1, r8, #0x44
	mov r2, r0
	bl VEC_Add
	mov r0, r4
	mov r1, r8
	mov r2, #0
	bl StageTask__SetParent
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #1
	bl SailObject__SetupHitbox
	mov r0, r4
	mov r1, #1
	mov r2, #0x800
	mov r3, #0
	bl SailObject__Func_21658D0
	mov r0, #0x12000
	str r0, [r5, #0x98]
	ldr r1, [r8, #0xf4]
	ldr r0, _0218091C // =SailSubDepth__State_21831F8
	cmp r1, r0
	moveq r0, #0x40000
	streq r0, [r5, #0x98]
	str r7, [r5, #0x15c]
	ldr r1, [r4, #0x44]
	mov r0, r4
	str r1, [r5, #0x138]
	ldr r1, [r4, #0x48]
	str r1, [r5, #0x13c]
	ldr r1, [r4, #0x4c]
	str r1, [r5, #0x140]
	bl SailObject__Func_2166728
	mov r0, r4
	bl SailObject__Func_2166834
	mov r0, r4
	bl EffectSailSubmarineWater2__Create
	mov r0, r4
	bl StageTask__InitSeqPlayer
	ldr r0, [r4, #0x138]
	mov r1, #0x49
	add r2, r4, #0x44
	bl SailAudio__PlaySpatialSequence
	ldr r1, _02180920 // =SailSubTorpedo2__State_2181F50
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02180914: .word aSbTorpedoNsbmd_1
_02180918: .word FX_SinCosTable_
_0218091C: .word SailSubDepth__State_21831F8
_02180920: .word SailSubTorpedo2__State_2181F50
	arm_func_end SailSubTorpedo2__Create

	arm_func_start SailSubBoat02__Create
SailSubBoat02__Create: // 0x02180924
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r7, r0
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x53
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	str r6, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02180A1C // =aSbSBoat02Nsbmd_1
	mov r0, r5
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #0x20000000
	str r1, [r5, #0x24]
	bl SailObject__InitCommon
	mov r1, r7
	mov r0, r5
	bl SailObject__InitFromMapObject
	ldr r1, [r4, #0x174]
	mov r0, #0x64
	sub r1, r1, #0x10000
	str r1, [r4, #0x174]
	str r0, [r4, #0x118]
	ldr r1, [r5, #0x24]
	mov r0, #0
	orr r1, r1, #2
	str r1, [r5, #0x24]
	str r0, [sp, #8]
	str r0, [sp, #0x10]
	mov r0, #0x1000
	str r0, [sp, #0xc]
	mov r0, r5
	add r1, sp, #8
	bl SailObject__Func_2165AF4
	add r1, r4, #0x28
	mov r0, r5
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r5
	mov r2, #0x2000
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, r5
	bl StageTask__InitSeqPlayer
	mov r0, r5
	bl SailSubBoat__SetupObject
	mov r0, r5
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02180A1C: .word aSbSBoat02Nsbmd_1
	arm_func_end SailSubBoat02__Create

	arm_func_start SailSubDepth__Create
SailSubDepth__Create: // 0x02180A20
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x54
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02180C50 // =aSbSDepthNsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #0x20000000
	str r1, [r4, #0x24]
	bl SailObject__InitCommon
	mov r0, r4
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r1, [r5, #0x174]
	mov r0, #0x1f4
	sub r1, r1, #0x10000
	str r1, [r5, #0x174]
	str r0, [r5, #0x118]
	ldr r0, [r6, #0x28]
	add r1, sp, #8
	str r0, [r5, #0x138]
	ldr r0, [r6, #0x38]
	str r0, [r5, #0x13c]
	ldr r0, [r6, #0x34]
	tst r0, #0x80000000
	ldrne r0, [r5, #0x13c]
	eorne r0, r0, #1
	strne r0, [r5, #0x13c]
	ldr r0, [r4, #0x24]
	orr r0, r0, #2
	orr r2, r0, #0x100
	str r2, [r4, #0x24]
	mov r2, #0
	mov r0, r4
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	bl SailObject__Func_2165AF4
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0x2800
	bl SailObject__Func_21658D0
	mov r0, #0xc00
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	mov r0, r4
	mov r1, #0
	bl StageTask__InitExWork
	ldrh r0, [r6, #0x30]
	sub r0, r0, #0xf
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _02180B74
_02180B50: // jump table
	b _02180B84 // case 0
	b _02180B94 // case 1
	b _02180BA4 // case 2
	b _02180BB4 // case 3
	b _02180BC4 // case 4
	b _02180B74 // case 5
	b _02180B74 // case 6
	b _02180BD4 // case 7
	b _02180BE4 // case 8
_02180B74:
	ldr r0, [r4, #0x140]
	ldr r1, _02180C54 // =_0218C444
	bl ObjExWork__Func_2076EE4
	b _02180BF0
_02180B84:
	ldr r0, [r4, #0x140]
	ldr r1, _02180C58 // =_0218C4B4
	bl ObjExWork__Func_2076EE4
	b _02180BF0
_02180B94:
	ldr r0, [r4, #0x140]
	ldr r1, _02180C5C // =_0218C524
	bl ObjExWork__Func_2076EE4
	b _02180BF0
_02180BA4:
	ldr r0, [r4, #0x140]
	ldr r1, _02180C58 // =_0218C4B4
	bl ObjExWork__Func_2076EE4
	b _02180BF0
_02180BB4:
	ldr r0, [r4, #0x140]
	ldr r1, _02180C60 // =_0218C63C
	bl ObjExWork__Func_2076EE4
	b _02180BF0
_02180BC4:
	ldr r0, [r4, #0x140]
	ldr r1, _02180C64 // =_0218C594
	bl ObjExWork__Func_2076EE4
	b _02180BF0
_02180BD4:
	ldr r0, [r4, #0x140]
	ldr r1, _02180C68 // =_0218C6E4
	bl ObjExWork__Func_2076EE4
	b _02180BF0
_02180BE4:
	ldr r0, [r4, #0x140]
	ldr r1, _02180C6C // =_0218C7A8
	bl ObjExWork__Func_2076EE4
_02180BF0:
	ldr r0, [r5, #0x13c]
	cmp r0, #0
	beq _02180C0C
	ldr r1, [r4, #0x140]
	ldr r0, [r1, #0x10]
	eor r0, r0, #0x20
	str r0, [r1, #0x10]
_02180C0C:
	ldr r1, [r6, #0x28]
	ldr r0, [r4, #0x140]
	rsb r1, r1, #0
	mov r1, r1, lsl #8
	strh r1, [r0, #0x30]
	ldr r1, [r4, #0x1c]
	mov r0, r4
	orr r1, r1, #0x2000
	str r1, [r4, #0x1c]
	bl ExWork__Func_2076D90
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl SailSubDepth__SetupObject
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02180C50: .word aSbSDepthNsbmd_0
_02180C54: .word _0218C444
_02180C58: .word _0218C4B4
_02180C5C: .word _0218C524
_02180C60: .word _0218C63C
_02180C64: .word _0218C594
_02180C68: .word _0218C6E4
_02180C6C: .word _0218C7A8
	arm_func_end SailSubDepth__Create

	arm_func_start SailSubMine__Create
SailSubMine__Create: // 0x02180C70
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #2
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r1, #0
	stmia sp, {r1, r6}
	str r0, [sp, #8]
	ldr r2, _02180D70 // =aSbMineBac_1
	mov r0, r5
	mov r3, r1
	bl ObjObjectAction3dBACLoad
	mov r0, #0x36
	bl GetObjectFileWork
	mov r1, #0
	mov r3, r0
	mov r0, r5
	mov r2, r1
	bl ObjObjectActionAllocTexture
	ldr r2, [r5, #0x134]
	mov r0, r5
	ldr r1, [r2, #0xcc]
	orr r1, r1, #0x18
	str r1, [r2, #0xcc]
	bl SailObject__InitCommon
	mov r1, r7
	mov r0, r5
	bl SailObject__InitFromMapObject
	ldr r1, [r4, #0x174]
	mov r0, #0xc8
	sub r1, r1, #0x10000
	str r1, [r4, #0x174]
	str r0, [r4, #0x118]
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #2
	str r1, [r5, #0x24]
	add r1, r4, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r5
	mov r2, #0x2000
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, #0x1e000
	str r0, [r4, #0x98]
	mov r0, r5
	bl StageTask__InitSeqPlayer
	mov r0, r5
	bl SailSubMine__SetupObject
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02180D70: .word aSbMineBac_1
	arm_func_end SailSubMine__Create

	arm_func_start SailSubMine2__Create
SailSubMine2__Create: // 0x02180D74
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #2
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r1, #0
	stmia sp, {r1, r6}
	str r0, [sp, #8]
	ldr r2, _02180E80 // =aSbMineBac_1
	mov r0, r5
	mov r3, r1
	bl ObjObjectAction3dBACLoad
	mov r0, #0x36
	bl GetObjectFileWork
	mov r1, #0
	mov r3, r0
	mov r0, r5
	mov r2, r1
	bl ObjObjectActionAllocTexture
	ldr r2, [r5, #0x134]
	mov r0, r5
	ldr r1, [r2, #0xcc]
	orr r1, r1, #0x18
	str r1, [r2, #0xcc]
	bl SailObject__InitCommon
	mov r1, r7
	mov r0, r5
	bl SailObject__InitFromMapObject
	ldr r1, [r4, #0x174]
	mov r0, #0xc8
	sub r1, r1, #0x10000
	str r1, [r4, #0x174]
	str r0, [r4, #0x118]
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #2
	str r1, [r5, #0x24]
	add r1, r4, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r5
	mov r2, #0x2000
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, #0x1e000
	str r0, [r4, #0x98]
	ldr r1, [r5, #0x1c]
	mov r0, r5
	orr r1, r1, #0x2000
	str r1, [r5, #0x1c]
	bl StageTask__InitSeqPlayer
	mov r0, r5
	bl SailSubMine2__SetupObject
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02180E80: .word aSbMineBac_1
	arm_func_end SailSubMine2__Create

	arm_func_start SailSubShark__Create
SailSubShark__Create: // 0x02180E84
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x55
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0218106C // =aSbBSharkNsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0x56
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r0, [sp]
	ldr r2, _02181070 // =aSbBSharkNsbca
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
	ldr r0, [r6, #0x34]
	tst r0, #0x80000000
	ldrne r0, [r5, #0x13c]
	eorne r0, r0, #1
	strne r0, [r5, #0x13c]
	ldr r1, [r5, #0x174]
	mov r0, #0x190
	sub r1, r1, #0x10000
	str r1, [r5, #0x174]
	str r0, [r5, #0x118]
	ldr r0, [r4, #0x24]
	add r1, sp, #8
	orr r0, r0, #2
	orr r2, r0, #0x100
	str r2, [r4, #0x24]
	mov r2, #0
	mov r0, r4
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	bl SailObject__Func_2165AF4
	mov r3, #0x3000
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	str r3, [r4, #0x40]
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0x2800
	bl SailObject__Func_21658D0
	mov r0, #0x30000
	str r0, [r5, #0x98]
	mov r0, r4
	mov r1, #0
	bl StageTask__InitExWork
	ldr r0, [r4, #0x140]
	ldr r1, _02181074 // =_0218C47C
	bl ObjExWork__Func_2076EE4
	ldrh r0, [r6, #0x30]
	cmp r0, #6
	cmpne r0, #8
	cmpne r0, #0xa
	cmpne r0, #0x15
	bne _0218100C
	ldr r1, [r4, #0x140]
	ldr r0, [r1, #0x10]
	orr r0, r0, #0x20
	str r0, [r1, #0x10]
_0218100C:
	ldr r0, [r5, #0x13c]
	cmp r0, #0
	beq _02181028
	ldr r1, [r4, #0x140]
	ldr r0, [r1, #0x10]
	eor r0, r0, #0x20
	str r0, [r1, #0x10]
_02181028:
	ldr r1, [r6, #0x28]
	ldr r0, [r4, #0x140]
	rsb r1, r1, #0
	mov r1, r1, lsl #8
	strh r1, [r0, #0x30]
	ldr r1, [r4, #0x1c]
	mov r0, r4
	orr r1, r1, #0x2000
	str r1, [r4, #0x1c]
	bl ExWork__Func_2076D90
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl SailSubShark__SetupObject
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0218106C: .word aSbBSharkNsbmd_0
_02181070: .word aSbBSharkNsbca
_02181074: .word _0218C47C
	arm_func_end SailSubShark__Create

	arm_func_start SailSubItem__Create
SailSubItem__Create: // 0x02181078
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x18
	mov r7, r0
	bl SailManager__GetWork
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x25
	bl GetObjectFileWork
	mov r8, r0
	bl SailManager__GetArchive
	ldr r3, _021811EC // =0x0000FFFF
	ldr r2, _021811F0 // =aSbItemBac_0
	stmia sp, {r3, r8}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	bl SailObject__InitCommon
	mov r0, r4
	mov r1, r7
	bl SailObject__InitFromMapObject
	ldr r1, [r5, #0x174]
	mov r0, #0x64
	sub r1, r1, #0x10000
	str r1, [r5, #0x174]
	str r0, [r5, #0x118]
	ldr r0, [r4, #0x24]
	orr r0, r0, #0x10000
	str r0, [r4, #0x24]
	ldr r0, [r7, #0x28]
	str r0, [r4, #0x28]
	cmp r0, #0x10
	movhi r0, #0
	strhi r0, [r4, #0x28]
	ldrh r0, [r6, #0x12]
	cmp r0, #6
	bne _0218113C
	ldr r0, [r4, #0x28]
	cmp r0, #3
	movls r0, #0xb
	strls r0, [r4, #0x28]
_0218113C:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #1
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x28]
	mov r1, r1, lsr #2
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	mov r2, #0
	add r1, sp, #0xc
	mov r0, r4
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	bl SailObject__Func_2165AF4
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r2, #0x2000
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, r4
	mov r1, #0
	bl StageTask__GetCollider
	mov r1, #0
	strh r1, [r0, #0x2c]
	mov r0, #0x280
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl SailSubBoat__SetupObject
	mov r0, r4
	bl SailItem3__Create
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021811EC: .word 0x0000FFFF
_021811F0: .word aSbItemBac_0
	arm_func_end SailSubItem__Create

	arm_func_start SailSubTargetLockOnHUD__UpdateLockOnPos
SailSubTargetLockOnHUD__UpdateLockOnPos: // 0x021811F4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r5, r0
	add r1, sp, #8
	ldr r4, [r5, #0x124]
	bl SailObject__Func_2165A9C
	ldr r1, [sp, #0xc]
	add r0, sp, #8
	rsb r1, r1, #0
	str r1, [sp, #0xc]
	mov r2, r0
	add r1, r5, #0x44
	bl VEC_Add
	ldr r1, [sp, #0xc]
	add r0, sp, #8
	rsb r3, r1, #0
	add r1, sp, #4
	add r2, sp, #0
	str r3, [sp, #0xc]
	bl NNS_G3dWorldPosToScrPos
	ldr r1, [sp, #4]
	add r0, r4, #0x100
	strh r1, [r0, #0x88]
	ldr r1, [sp]
	strh r1, [r0, #0x8a]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	arm_func_end SailSubTargetLockOnHUD__UpdateLockOnPos

	arm_func_start SailSubTargetLockOnHUD__SetPosition
SailSubTargetLockOnHUD__SetPosition: // 0x02181260
	ldr r1, [r0, #0x11c]
	mov r2, #0
	ldr r1, [r1, #0x124]
	add r1, r1, #0x100
	ldrsh r3, [r1, #0x88]
	mov r3, r3, lsl #0xc
	str r3, [r0, #0x44]
	ldrsh r1, [r1, #0x8a]
	mov r1, r1, lsl #0xc
	str r1, [r0, #0x48]
	str r2, [r0, #0x4c]
	bx lr
	arm_func_end SailSubTargetLockOnHUD__SetPosition

	arm_func_start SailSubTargetHUD__State_2181290
SailSubTargetHUD__State_2181290: // 0x02181290
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r6, [r7, #0x124]
	mov r1, #0
	ldr r4, [r7, #0x11c]
	bl StageTask__GetCollider
	ldr r1, [r6, #0x10]
	ldr r2, [r7, #0x2c]
	add r1, r1, #5
	mov r5, r0
	cmp r2, r1
	bgt _02181344
	sub r0, r1, r2
	mov r0, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	bl FX_Div
	mov r1, r0, asr #0x1f
	mov r2, r1, lsl #0xc
	mov r1, #0x800
	adds r1, r1, r0, lsl #12
	orr r2, r2, r0, lsr #20
	adc r0, r2, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0xe00
	str r0, [r7, #0x38]
	str r0, [r7, #0x3c]
	str r0, [r7, #0x40]
	ldr r0, [r6, #0x10]
	ldr r1, [r7, #0x2c]
	add r0, r0, #5
	cmp r1, r0
	bne _02181344
	ldr r0, [r7, #0x24]
	tst r0, #0x80
	bne _02181344
	mov r0, r7
	mov r1, #0xa
	bl StageTask__SetAnimation
	ldr r0, [r7, #0x20]
	ldr r1, _02181554 // =0x00007FFF
	orr r2, r0, #4
	mov r0, r7
	str r2, [r7, #0x20]
	bl SailObject__SetSpriteColor
_02181344:
	ldr r0, [r7, #0x2c]
	cmp r0, #4
	ldreq r0, [r5, #0x18]
	biceq r0, r0, #0x800
	streq r0, [r5, #0x18]
	ldr r0, [r5, #0x18]
	tst r0, #0x100
	beq _02181450
	bic r0, r0, #0x100
	str r0, [r5, #0x18]
	ldr r1, [r6, #0x10]
	ldr r0, [r7, #0x2c]
	cmp r0, r1
	bge _02181390
	ldr r0, [r7, #0x24]
	tst r0, #0x10000
	addeq r0, r1, #0x1e
	streq r0, [r7, #0x2c]
	beq _02181450
_02181390:
	ldr r1, [r7, #0x18]
	mov r0, r7
	orr r1, r1, #2
	str r1, [r7, #0x18]
	ldr r2, [r7, #0x24]
	mov r1, #0xb
	orr r2, r2, #0x80
	str r2, [r7, #0x24]
	bl StageTask__SetAnimation
	ldr r0, [r7, #0x20]
	ldr r1, _02181554 // =0x00007FFF
	bic r2, r0, #4
	mov r0, r7
	str r2, [r7, #0x20]
	bl SailObject__SetSpriteColor
	mov r0, #0x1000
	str r0, [r7, #0x38]
	str r0, [r7, #0x3c]
	str r0, [r7, #0x40]
	ldr r0, [r6, #0x10]
	ldr r1, [r7, #0x2c]
	add r0, r0, #0xf
	subs r0, r1, r0
	rsbmi r0, r0, #0
	cmp r0, #2
	bgt _02181408
	ldr r0, [r7, #0x24]
	orr r0, r0, #0x2000
	str r0, [r7, #0x24]
	b _02181420
_02181408:
	cmp r0, #8
	ldr r0, [r7, #0x24]
	orrle r0, r0, #0x1000
	strle r0, [r7, #0x24]
	orrgt r0, r0, #0x800
	strgt r0, [r7, #0x24]
_02181420:
	ldr r0, [r7, #0x24]
	mov r1, #0x45
	tst r0, #0x2000
	movne r1, #0x74
	cmp r4, #0
	ldr r0, [r7, #0x138]
	beq _02181448
	add r2, r4, #0x44
	bl SailAudio__PlaySpatialSequence
	b _02181450
_02181448:
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
_02181450:
	ldr r2, [r7, #0x24]
	tst r2, #0x80
	bne _021814F8
	ldr r0, [r7, #0x18]
	tst r0, #2
	bne _021814F8
	tst r2, #0x10000
	bne _021814F8
	ldr r0, [r6, #0x10]
	ldr r1, [r7, #0x2c]
	add r0, r0, #0x1e
	cmp r1, r0
	blt _021814F8
	orr r1, r2, #0x400
	str r1, [r7, #0x24]
	mov r0, r7
	mov r1, #0xd
	bl StageTask__SetAnimation
	ldr r0, [r7, #0x20]
	ldr r1, _02181554 // =0x00007FFF
	bic r2, r0, #4
	mov r0, r7
	str r2, [r7, #0x20]
	bl SailObject__SetSpriteColor
	ldr r1, [r7, #0x18]
	mov r0, #0x1000
	orr r1, r1, #2
	str r1, [r7, #0x18]
	str r0, [r7, #0x38]
	str r0, [r7, #0x3c]
	str r0, [r7, #0x40]
	mov r0, #0x4000
	str r0, [r7, #4]
	cmp r4, #0
	ldr r0, [r7, #0x138]
	mov r1, #0x47
	beq _021814F0
	add r2, r4, #0x44
	bl SailAudio__PlaySpatialSequence
	b _021814F8
_021814F0:
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
_021814F8:
	mov r0, r7
	bl StageTask__GetAnimID
	cmp r0, #0xb
	blo _02181524
	ldr r0, [r7, #0x20]
	tst r0, #8
	beq _02181524
	ldr r0, [r7, #0x18]
	orr r0, r0, #4
	str r0, [r7, #0x18]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02181524:
	cmp r4, #0
	beq _02181534
	mov r0, r7
	bl SailSubTargetLockOnHUD__SetPosition
_02181534:
	add r0, r7, #0x44
	add r3, r6, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r7, #0x2c]
	add r0, r0, #1
	str r0, [r7, #0x2c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02181554: .word 0x00007FFF
	arm_func_end SailSubTargetHUD__State_2181290

	arm_func_start SailSubTargetHUD__State_2181558
SailSubTargetHUD__State_2181558: // 0x02181558
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	mov r1, #0
	ldr r6, [r7, #0x124]
	ldr r4, [r7, #0x11c]
	bl StageTask__GetCollider
	mov r5, r0
	mov r0, r7
	bl StageTask__GetAnimID
	cmp r0, #9
	bhs _02181630
	ldr r0, [r6, #0x10]
	ldr r2, [r7, #0x2c]
	add r1, r0, #5
	cmp r2, r1
	bgt _02181630
	sub r0, r1, r2
	mov r0, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	bl FX_Div
	mov r1, r0, asr #0x1f
	mov r2, r1, lsl #0xc
	mov r1, #0x800
	adds r1, r1, r0, lsl #12
	orr r2, r2, r0, lsr #20
	adc r0, r2, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0xe00
	str r0, [r7, #0x38]
	str r0, [r7, #0x3c]
	str r0, [r7, #0x40]
	ldr r0, [r6, #0x10]
	ldr r1, [r7, #0x2c]
	add r0, r0, #5
	cmp r1, r0
	bne _02181630
	mov r0, r7
	mov r1, #0x16
	bl StageTask__SetAnimation
	ldr r1, [r7, #0x20]
	mov r0, r7
	bic r2, r1, #4
	mov r1, #0
	str r2, [r7, #0x20]
	bl SailObject__SetAnimSpeed
	mov r0, #0
	strh r0, [r6, #0x20]
	ldr r0, [r7, #0x20]
	ldr r1, _0218199C // =0x00007FFF
	orr r2, r0, #0x20
	mov r0, r7
	str r2, [r7, #0x20]
	bl SailObject__SetSpriteColor
_02181630:
	ldr r0, [r7, #0x2c]
	cmp r0, #4
	ldreq r0, [r5, #0x18]
	biceq r0, r0, #0x800
	streq r0, [r5, #0x18]
	ldr r0, [r5, #0x18]
	tst r0, #0x100
	mov r0, r7
	beq _02181814
	bl StageTask__GetAnimID
	cmp r0, #0
	bne _021816B0
	mov r2, #0x1000
	str r2, [r7, #0x38]
	str r2, [r7, #0x3c]
	mov r0, r7
	mov r1, #0x16
	str r2, [r7, #0x40]
	bl StageTask__SetAnimation
	mov r0, #0
	strh r0, [r6, #0x20]
	ldr r0, [r7, #0x20]
	ldr r1, _0218199C // =0x00007FFF
	bic r2, r0, #4
	mov r0, r7
	str r2, [r7, #0x20]
	bl SailObject__SetSpriteColor
	ldr r1, [r7, #0x2c]
	ldr r0, [r6, #0x10]
	sub r0, r0, r1
	add r0, r1, r0, lsl #1
	str r0, [r7, #0x2c]
_021816B0:
	mov r0, #5
	strh r0, [r5, #0x2e]
	ldr r1, [r5, #0x18]
	mov r0, #0x1e000
	bic r1, r1, #0x100
	str r1, [r5, #0x18]
	str r0, [r6]
	ldr r0, [r7, #0x24]
	tst r0, #0x80
	bne _02181714
	ldr r1, [r7, #0x20]
	mov r0, r7
	bic r1, r1, #0x20
	str r1, [r7, #0x20]
	ldr r1, [r6, #0x1c]
	bl SailObject__SetAnimSpeed
	cmp r4, #0
	ldr r0, [r7, #0x138]
	mov r1, #0x45
	beq _0218170C
	add r2, r4, #0x44
	bl SailAudio__PlaySpatialSequence
	b _02181714
_0218170C:
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
_02181714:
	mov r0, r7
	bl StageTask__GetAnimID
	cmp r0, #0x16
	bne _02181804
	ldr r0, [r7, #0x20]
	tst r0, #8
	bne _02181744
	ldr r0, [r7, #0x134]
	ldrh r1, [r6, #0x20]
	ldrh r0, [r0, #0x9e]
	cmp r1, r0
	bls _021817EC
_02181744:
	ldr r1, [r7, #0x18]
	mov r0, r7
	orr r2, r1, #2
	mov r1, #0x15
	str r2, [r7, #0x18]
	bl StageTask__SetAnimation
	mov r0, r7
	mov r1, #0x1000
	bl SailObject__SetAnimSpeed
	ldr r0, [r6, #0x10]
	ldr r1, [r7, #0x2c]
	add r0, r0, #0xf
	subs r1, r1, r0
	ldr r0, [r6, #0x18]
	rsbmi r1, r1, #0
	subs r0, r1, r0
	rsbmi r0, r0, #0
	cmp r0, #2
	bgt _021817A0
	ldr r0, [r7, #0x24]
	orr r0, r0, #0x2000
	str r0, [r7, #0x24]
	b _021817B8
_021817A0:
	cmp r0, #8
	ldr r0, [r7, #0x24]
	orrle r0, r0, #0x1000
	strle r0, [r7, #0x24]
	orrgt r0, r0, #0x800
	strgt r0, [r7, #0x24]
_021817B8:
	ldr r0, [r7, #0x24]
	mov r1, #0x45
	tst r0, #0x2000
	movne r1, #0x74
	cmp r4, #0
	ldr r0, [r7, #0x138]
	beq _021817E0
	add r2, r4, #0x44
	bl SailAudio__PlaySpatialSequence
	b _021817F8
_021817E0:
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	b _021817F8
_021817EC:
	ldr r0, [r6, #0x18]
	add r0, r0, #1
	str r0, [r6, #0x18]
_021817F8:
	ldr r0, [r7, #0x134]
	ldrh r0, [r0, #0x9e]
	strh r0, [r6, #0x20]
_02181804:
	ldr r0, [r7, #0x24]
	orr r0, r0, #0x80
	str r0, [r7, #0x24]
	b _0218185C
_02181814:
	bl StageTask__GetAnimID
	cmp r0, #0x16
	bne _0218185C
	ldr r0, [r7, #0x24]
	tst r0, #0x80
	beq _0218185C
	ldr r0, [r7, #0x18]
	tst r0, #2
	bne _0218185C
	mov r0, r7
	mov r1, #0
	bl SailObject__SetAnimSpeed
	ldr r0, [r7, #0x24]
	bic r0, r0, #0x80
	str r0, [r7, #0x24]
	ldr r0, [r7, #0x20]
	orr r0, r0, #0x20
	str r0, [r7, #0x20]
_0218185C:
	cmp r4, #0
	beq _021818F4
	ldr r0, [r4, #0x24]
	tst r0, #0x400
	beq _021818F4
	mov r0, r7
	bl StageTask__GetAnimID
	cmp r0, #0xd
	beq _021818F4
	ldr r1, [r7, #0x24]
	mov r0, r7
	orr r2, r1, #0x400
	mov r1, #0xd
	str r2, [r7, #0x24]
	bl StageTask__SetAnimation
	mov r0, r7
	mov r1, #0x1000
	bl SailObject__SetAnimSpeed
	ldr r1, _0218199C // =0x00007FFF
	mov r0, r7
	bl SailObject__SetSpriteColor
	ldr r0, [r7, #0x20]
	mov r1, #0x1000
	bic r0, r0, #4
	bic r0, r0, #0x20
	str r0, [r7, #0x20]
	ldr r2, [r7, #0x18]
	mov r0, #0x4000
	orr r2, r2, #2
	str r2, [r7, #0x18]
	str r1, [r7, #0x38]
	str r1, [r7, #0x3c]
	str r1, [r7, #0x40]
	str r0, [r7, #4]
	ldr r0, [r7, #0x138]
	add r2, r4, #0x44
	mov r1, #0x47
	bl SailAudio__PlaySpatialSequence
_021818F4:
	mov r0, r7
	bl StageTask__GetAnimID
	cmp r0, #0xb
	beq _02181914
	mov r0, r7
	bl StageTask__GetAnimID
	cmp r0, #0x15
	bne _02181930
_02181914:
	ldr r0, [r7, #0x20]
	tst r0, #8
	beq _02181930
	ldr r0, [r7, #0x18]
	orr r0, r0, #4
	str r0, [r7, #0x18]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02181930:
	mov r0, r7
	bl StageTask__GetAnimID
	cmp r0, #0xd
	bne _0218196C
	ldr r0, [r7, #0x20]
	tst r0, #8
	beq _0218196C
	ldr r0, [r6, #0x14]
	add r0, r0, #1
	str r0, [r6, #0x14]
	cmp r0, #8
	ldrgt r0, [r7, #0x18]
	orrgt r0, r0, #4
	strgt r0, [r7, #0x18]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0218196C:
	cmp r4, #0
	beq _0218197C
	mov r0, r7
	bl SailSubTargetLockOnHUD__SetPosition
_0218197C:
	add r0, r7, #0x44
	add r3, r6, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r7, #0x2c]
	add r0, r0, #1
	str r0, [r7, #0x2c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0218199C: .word 0x00007FFF
	arm_func_end SailSubTargetHUD__State_2181558

	arm_func_start SailUnknown2180190__State_21819A0
SailUnknown2180190__State_21819A0: // 0x021819A0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r1, [r7, #0x11c]
	ldr r6, [r7, #0x124]
	cmp r1, #0
	bne _021819C8
	ldr r0, [r7, #0x18]
	orr r0, r0, #4
	str r0, [r7, #0x18]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021819C8:
	mov r1, #0
	bl StageTask__GetCollider
	mov r5, r0
	ldr r1, [r7, #0x11c]
	ldr r0, [r5, #0x18]
	ldr r4, [r1, #0x124]
	tst r0, #0x200
	beq _02181A8C
	add r0, r4, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #1
	ldreq r0, [r7, #0x18]
	orreq r0, r0, #2
	streq r0, [r7, #0x18]
	ldr r0, [r7, #0x2c]
	tst r0, #3
	bne _02181AC8
	add r0, r4, #0x100
	ldrh r2, [r0, #0xc4]
	ldr r1, _02181B68 // =0x000003E7
	mov r3, #1
	add r2, r2, #1
	strh r2, [r0, #0xc4]
	ldrh r2, [r0, #0xc4]
	cmp r2, r1
	strhih r1, [r0, #0xc4]
	add r0, r4, #0x100
	ldrh r2, [r0, #0xc4]
	ldrh r1, [r0, #0xc6]
	cmp r1, r2
	strloh r2, [r0, #0xc6]
	ldr r1, [r4, #0x1a8]
	ldr r0, _02181B6C // =0x05F5E0FF
	add r1, r1, #0x14
	str r1, [r4, #0x1a8]
	cmp r1, r0
	strhi r0, [r4, #0x1a8]
	ldr r0, [r4, #0x28]
	ldr r2, [r4, #0x24]
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	sub r1, r0, #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, asr #0x10
	mov r2, #0x14
	bl SailScoreBonus__CreateScreen
	b _02181AC8
_02181A8C:
	ldr r0, [r7, #0x2c]
	cmp r0, #2
	blt _02181AA8
	mov r0, #2
	str r0, [r7, #0x2c]
	ldr r0, [r7, #0x138]
	bl SailAudio__FadeSequence
_02181AA8:
	add r0, r4, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #1
	bne _02181AC8
	ldr r0, [r7, #0x18]
	orr r0, r0, #4
	str r0, [r7, #0x18]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02181AC8:
	ldr r1, [r4, #0x24]
	mov r0, #0
	mov r1, r1, lsl #0xc
	str r1, [r7, #0x44]
	ldr r1, [r4, #0x28]
	mov r1, r1, lsl #0xc
	str r1, [r7, #0x48]
	str r0, [r7, #0x4c]
	ldr r1, [r7, #0x2c]
	cmp r1, #1
	bne _02181B14
	mov r1, #5
	strh r1, [r5, #0x2c]
	ldr r1, [r5, #0x18]
	tst r1, #0x200
	bne _02181B14
	mov r2, r0
	mov r1, #0x44
	bl SailAudio__PlaySpatialSequence
_02181B14:
	ldr r0, [r7, #0x2c]
	cmp r0, #3
	bne _02181B3C
	ldr r0, [r5, #0x18]
	tst r0, #0x200
	beq _02181B3C
	ldr r0, [r7, #0x138]
	mov r1, #0x46
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
_02181B3C:
	ldr r1, [r7, #0x2c]
	add r0, r7, #0x44
	add r1, r1, #1
	str r1, [r7, #0x2c]
	ldr r1, [r5, #0x18]
	add r3, r6, #4
	bic r1, r1, #0x200
	str r1, [r5, #0x18]
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02181B68: .word 0x000003E7
_02181B6C: .word 0x05F5E0FF
	arm_func_end SailUnknown2180190__State_21819A0

	arm_func_start SailSubTargetLockOnHUD__State_2181B70
SailSubTargetLockOnHUD__State_2181B70: // 0x02181B70
	stmdb sp!, {r3, lr}
	ldr r3, [r0, #0x11c]
	cmp r3, #0
	bne _02181B90
	ldr r1, [r0, #0x18]
	orr r1, r1, #4
	str r1, [r0, #0x18]
	ldmia sp!, {r3, pc}
_02181B90:
	ldr r1, [r0, #0x28]
	ldr r2, [r0, #0x2c]
	cmp r1, r2
	bne _02181BB0
	ldr r1, [r0, #0x18]
	orr r1, r1, #4
	str r1, [r0, #0x18]
	ldmia sp!, {r3, pc}
_02181BB0:
	ldr r1, [r3, #0x24]
	tst r1, #0x480
	beq _02181BCC
	ldr r1, [r0, #0x18]
	orr r1, r1, #4
	str r1, [r0, #0x18]
	ldmia sp!, {r3, pc}
_02181BCC:
	add r1, r2, #1
	str r1, [r0, #0x2c]
	bl SailSubTargetLockOnHUD__SetPosition
	ldmia sp!, {r3, pc}
	arm_func_end SailSubTargetLockOnHUD__State_2181B70

	arm_func_start SailSubArrowHUD__State_2181BDC
SailSubArrowHUD__State_2181BDC: // 0x02181BDC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x11c]
	cmp r4, #0
	beq _02181BFC
	ldr r0, [r4, #0x24]
	tst r0, #0x3c00
	beq _02181C0C
_02181BFC:
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_02181C0C:
	ldr r1, [r4, #0x11c]
	cmp r1, #0
	beq _02181C54
	ldr r0, [r1, #0x9c]
	ldr r1, [r1, #0x98]
	bl FX_Atan2Idx
	strh r0, [r5, #0x34]
	mov r0, r5
	bl SailObject__ApplyRotation
	ldr r0, [r4, #0x11c]
	ldr r1, [r0, #0x9c]
	ldr r0, [r0, #0x98]
	orrs r0, r1, r0
	ldr r0, [r5, #0x20]
	bicne r0, r0, #0x20
	strne r0, [r5, #0x20]
	orreq r0, r0, #0x20
	streq r0, [r5, #0x20]
_02181C54:
	mov r0, r4
	bl StageTask__GetAnimID
	cmp r0, #0
	beq _02181D38
	cmp r0, #0x16
	bne _02181D38
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	mov r0, r5
	beq _02181CDC
	bl StageTask__GetAnimID
	cmp r0, #0x11
	mov r0, r5
	blo _02181CB4
	bl StageTask__GetAnimID
	cmp r0, #0x12
	beq _02181D38
	mov r0, r5
	mov r1, #0x12
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	b _02181D38
_02181CB4:
	bl StageTask__GetAnimID
	cmp r0, #0xf
	beq _02181D38
	mov r0, r5
	mov r1, #0xf
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	b _02181D38
_02181CDC:
	bl StageTask__GetAnimID
	cmp r0, #0x11
	mov r0, r5
	blo _02181D14
	bl StageTask__GetAnimID
	cmp r0, #0x13
	beq _02181D38
	mov r0, r5
	mov r1, #0x13
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	bic r0, r0, #4
	str r0, [r5, #0x20]
	b _02181D38
_02181D14:
	bl StageTask__GetAnimID
	cmp r0, #0x10
	beq _02181D38
	mov r0, r5
	mov r1, #0x10
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	bic r0, r0, #4
	str r0, [r5, #0x20]
_02181D38:
	ldr r0, [r4, #0x44]
	str r0, [r5, #0x44]
	ldr r0, [r4, #0x48]
	str r0, [r5, #0x48]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSubArrowHUD__State_2181BDC

	arm_func_start SailSubTouchPrompt__State_2181D4C
SailSubTouchPrompt__State_2181D4C: // 0x02181D4C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x11c]
	cmp r4, #0
	bne _02181D80
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	cmp r0, #0x14
	ldrhi r0, [r5, #0x18]
	orrhi r0, r0, #4
	strhi r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_02181D80:
	ldr r1, [r4, #0x24]
	tst r1, #0x400
	beq _02181D9C
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_02181D9C:
	bl StageTask__GetAnimID
	cmp r0, #0
	cmpne r0, #4
	bne _02181E64
	mov r0, r4
	bl StageTask__GetAnimID
	cmp r0, #9
	beq _02181DDC
	mov r0, r4
	bl StageTask__GetAnimID
	cmp r0, #0xa
	beq _02181DDC
	mov r0, r4
	bl StageTask__GetAnimID
	cmp r0, #0x16
	bne _02181DEC
_02181DDC:
	ldr r0, [r5, #0x20]
	bic r0, r0, #0x20
	str r0, [r5, #0x20]
	b _02181E64
_02181DEC:
	ldr r0, [r4, #0x24]
	tst r0, #0x3800
	beq _02181E64
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #4
	ble _02181E64
	ldr r0, [r5, #0x20]
	bic r0, r0, #0x20
	bic r0, r0, #4
	str r0, [r5, #0x20]
	ldr r0, [r4, #0x24]
	tst r0, #0x800
	beq _02181E34
	mov r0, r5
	mov r1, #1
	bl StageTask__SetAnimation
_02181E34:
	ldr r0, [r4, #0x24]
	tst r0, #0x1000
	beq _02181E4C
	mov r0, r5
	mov r1, #2
	bl StageTask__SetAnimation
_02181E4C:
	ldr r0, [r4, #0x24]
	tst r0, #0x2000
	beq _02181E64
	mov r0, r5
	mov r1, #3
	bl StageTask__SetAnimation
_02181E64:
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x44]
	str r0, [r5, #0x44]
	ldr r0, [r4, #0x48]
	str r0, [r5, #0x48]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSubTouchPrompt__State_2181D4C

	arm_func_start SailSubTargetLockOnHUD2__State_2181E80
SailSubTargetLockOnHUD2__State_2181E80: // 0x02181E80
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x11c]
	cmp r4, #0
	bne _02181EA4
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_02181EA4:
	ldr r1, [r4, #0x44]
	mov r0, r4
	str r1, [r5, #0x44]
	ldr r1, [r4, #0x48]
	str r1, [r5, #0x48]
	bl StageTask__GetAnimID
	cmp r0, #0x16
	bne _02181F30
	ldr r1, [r5, #0x20]
	ldr r0, _02181F4C // =0xFFFFEFDF
	and r0, r1, r0
	str r0, [r5, #0x20]
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	mov r0, r5
	beq _02181F0C
	bl StageTask__GetAnimID
	cmp r0, #0x14
	beq _02181F30
	mov r0, r5
	mov r1, #0x14
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	b _02181F30
_02181F0C:
	bl StageTask__GetAnimID
	cmp r0, #0xc
	beq _02181F30
	mov r0, r5
	mov r1, #0xc
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
_02181F30:
	ldr r0, [r4, #0x24]
	tst r0, #0x3c00
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02181F4C: .word 0xFFFFEFDF
	arm_func_end SailSubTargetLockOnHUD2__State_2181E80

	arm_func_start SailSubTorpedo2__State_2181F50
SailSubTorpedo2__State_2181F50: // 0x02181F50
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r5, r0
	ldr r4, [r5, #0x124]
	add r2, sp, #4
	mov r1, #0
	str r1, [r2]
	str r1, [r2, #4]
	str r1, [r2, #8]
	ldr r1, [r5, #0x11c]
	cmp r1, #0
	bne _02181F94
	ldr r0, [r5, #0x18]
	add sp, sp, #0x10
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_02181F94:
	mov r1, #1
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	beq _02181FBC
	ldr r0, [r5, #0x18]
	add sp, sp, #0x10
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_02181FBC:
	ldr r0, [r4, #0x15c]
	cmp r0, #0
	bne _02182000
	ldr r1, [r5, #0x8c]
	ldr r0, [r5, #0x44]
	add sp, sp, #0x10
	sub r0, r1, r0
	str r0, [r5, #0x98]
	ldr r1, [r5, #0x90]
	ldr r0, [r5, #0x48]
	sub r0, r1, r0
	str r0, [r5, #0x9c]
	ldr r1, [r5, #0x94]
	ldr r0, [r5, #0x4c]
	sub r0, r1, r0
	str r0, [r5, #0xa0]
	ldmia sp!, {r3, r4, r5, pc}
_02182000:
	ldrh r0, [r5, #0]
	mov r1, #0x1000
	mov r2, #1
	cmp r0, #1
	mov r0, #0x40
	str r0, [sp]
	bne _0218202C
	ldr r0, [r5, #0x2c]
	mov r3, #0x200
	bl ObjShiftSet
	b _02182038
_0218202C:
	ldr r0, [r5, #0x2c]
	mov r3, #0x380
	bl ObjShiftSet
_02182038:
	str r0, [r5, #0x2c]
	ldr r0, [r4, #0x15c]
	add r1, sp, #4
	bl SailObject__Func_2165A9C
	add r0, r5, #0x44
	add r3, r5, #0x8c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x15c]
	ldr r1, [r5, #0x2c]
	ldr r0, [r0, #0x44]
	mov r2, r1, lsl #0x10
	ldr r1, [r4, #0x138]
	mov r2, r2, lsr #0x10
	bl ObjAlphaSet
	str r0, [r5, #0x44]
	ldr r1, [r4, #0x15c]
	ldr r0, [r5, #0x2c]
	ldr r3, [r1, #0x48]
	mov r2, r0, lsl #0x10
	ldr r1, [sp, #8]
	mov r2, r2, lsr #0x10
	sub r0, r3, r1
	ldr r1, [r4, #0x13c]
	bl ObjAlphaSet
	str r0, [r5, #0x48]
	ldr r0, [r4, #0x15c]
	ldr r2, [r5, #0x2c]
	ldr r1, [r4, #0x140]
	mov r2, r2, lsl #0x10
	ldr r0, [r0, #0x4c]
	mov r2, r2, lsr #0x10
	bl ObjAlphaSet
	str r0, [r5, #0x4c]
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSubTorpedo2__State_2181F50

	arm_func_start SailSubTargetHUD__Check_21820C8
SailSubTargetHUD__Check_21820C8: // 0x021820C8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r4, [r0, #0x3c]
	ldr r5, [r1, #0x3c]
	cmp r4, #0
	cmpne r5, #0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	add r2, sp, #0
	add r0, r4, #4
	add r1, r5, #4
	bl VEC_Subtract
	add r0, sp, #0
	mov r1, r0
	bl VEC_DotProduct
	ldr r2, [r4, #0]
	ldr r1, [r5, #0]
	mov r4, #0
	add r3, r2, r1
	smull r2, r1, r3, r3
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	sub r0, r0, r2
	cmp r0, #0
	movle r4, #1
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end SailSubTargetHUD__Check_21820C8

	arm_func_start SailSubTargetHUD__OnDefend_2182144
SailSubTargetHUD__OnDefend_2182144: // 0x02182144
	stmdb sp!, {r3, lr}
	ldr ip, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	ldr r1, [ip, #0x11c]
	ldr r3, [ip, #0x124]
	cmp r1, #0
	ldrne r0, [r0, #0x11c]
	cmpne r0, #0
	ldmeqia sp!, {r3, pc}
	ldr r2, [r1, #0x24]
	tst r2, #0x100
	ldmneia sp!, {r3, pc}
	ldr r2, [ip, #0x24]
	tst r2, #0x10000
	bne _0218219C
	ldr r2, [r3, #0x10]
	ldr r3, [ip, #0x2c]
	cmp r3, r2
	ldmltia sp!, {r3, pc}
	add r2, r2, #0x1e
	cmp r3, r2
	ldmgtia sp!, {r3, pc}
_0218219C:
	bl SailSubTorpedo1__Create
	ldmia sp!, {r3, pc}
	arm_func_end SailSubTargetHUD__OnDefend_2182144

	arm_func_start SailSubBoat__SetupObject
SailSubBoat__SetupObject: // 0x021821A4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r2, _021821F8 // =SailSubBoat__State_21821FC
	mov r1, #0x5000
	str r2, [r5, #0xf4]
	rsb r1, r1, #0
	str r1, [r4, #0x184]
	mov r1, #2
	str r1, [r5, #0x2c]
	ldr r2, [r5, #0x18]
	mov r1, #0x12
	orr r2, r2, #2
	str r2, [r5, #0x18]
	bl SailSubTargetLockOnHUD__Create
	mov r0, r5
	mov r1, #0x12
	mov r2, #0
	bl SailSubTargetHUD__Create
	str r0, [r4, #0x160]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021821F8: .word SailSubBoat__State_21821FC
	arm_func_end SailSubBoat__SetupObject

	arm_func_start SailSubBoat__State_21821FC
SailSubBoat__State_21821FC: // 0x021821FC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x2c]
	ldr r4, [r5, #0x124]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r5, #0x2c]
	bne _02182230
	ldr r0, [r4, #0x184]
	ldr r1, _021822C0 // =0x000006C8
	ldr r2, _021822C4 // =0x00001C8D
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
_02182230:
	ldr r1, [r5, #0x24]
	tst r1, #0x10000
	bne _02182250
	mov r0, r5
	bl SailObject__Func_2166728
	mov r0, r5
	bl SailObject__Func_2166834
	b _02182294
_02182250:
	ldr r0, [r4, #0x160]
	cmp r0, #0
	beq _02182294
	ldr r0, [r0, #0x24]
	tst r0, #0x80
	beq _0218227C
	orr r0, r1, #0x80
	str r0, [r5, #0x24]
	ldr r0, [r5, #0x18]
	bic r0, r0, #2
	str r0, [r5, #0x18]
_0218227C:
	ldr r0, [r4, #0x160]
	ldr r1, [r5, #0x24]
	ldr r0, [r0, #0x24]
	and r0, r0, #0x2800
	orr r0, r1, r0
	str r0, [r5, #0x24]
_02182294:
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r1, [r4, #0x184]
	ldr r0, _021822C4 // =0x00001C8D
	cmp r1, r0
	bne _021822B4
	mov r0, r5
	bl SailSubBoat__Func_21822C8
_021822B4:
	mov r0, r5
	bl SailSubTargetLockOnHUD__UpdateLockOnPos
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021822C0: .word 0x000006C8
_021822C4: .word 0x00001C8D
	arm_func_end SailSubBoat__State_21821FC

	arm_func_start SailSubBoat__Func_21822C8
SailSubBoat__Func_21822C8: // 0x021822C8
	ldr r3, [r0, #0x124]
	ldr r2, _021822E8 // =SailSubBoat__State_21822F0
	ldr r1, _021822EC // =0x00001C8D
	str r2, [r0, #0xf4]
	str r1, [r3, #0x184]
	mov r1, #0x1e
	str r1, [r0, #0x2c]
	bx lr
	.align 2, 0
_021822E8: .word SailSubBoat__State_21822F0
_021822EC: .word 0x00001C8D
	arm_func_end SailSubBoat__Func_21822C8

	arm_func_start SailSubBoat__State_21822F0
SailSubBoat__State_21822F0: // 0x021822F0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r1, [r5, #0x24]
	ldr r4, [r5, #0x124]
	tst r1, #0x10000
	bne _02182314
	bl SailObject__Func_2166728
	mov r0, r5
	bl SailObject__Func_2166834
_02182314:
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x160]
	cmp r0, #0
	beq _02182388
	ldr r0, [r0, #0x24]
	tst r0, #0x80
	beq _0218234C
	ldr r0, [r5, #0x24]
	orr r0, r0, #0x80
	str r0, [r5, #0x24]
	ldr r0, [r5, #0x18]
	bic r0, r0, #2
	str r0, [r5, #0x18]
_0218234C:
	ldr r0, [r4, #0x160]
	ldr r0, [r0, #0x24]
	tst r0, #0x400
	beq _02182370
	ldr r1, [r5, #0x24]
	mov r0, #1
	orr r1, r1, #0x400
	str r1, [r5, #0x24]
	str r0, [r5, #0x2c]
_02182370:
	ldr r0, [r4, #0x160]
	ldr r1, [r5, #0x24]
	ldr r0, [r0, #0x24]
	and r0, r0, #0x2800
	orr r0, r1, r0
	str r0, [r5, #0x24]
_02182388:
	mov r0, r5
	bl SailSubTargetLockOnHUD__UpdateLockOnPos
	ldr r0, [r5, #0x24]
	tst r0, #0x80
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x2c]
	sub r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0
	bgt _021823CC
	ldr r0, [r5, #0x24]
	tst r0, #0x10000
	bne _021823CC
	tst r0, #0x400
	beq _021823CC
	mov r0, r5
	bl SailSubItem__Func_21823EC
_021823CC:
	ldr r0, [r5, #0x2c]
	cmp r0, #0
	ldmgeia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x184]
	mov r1, #0xc0
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSubBoat__State_21822F0

	arm_func_start SailSubItem__Func_21823EC
SailSubItem__Func_21823EC: // 0x021823EC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r2, _02182490 // =SailSubItem__State_2182494
	mov r1, #0
	str r2, [r5, #0xf4]
	str r1, [r4, #0x184]
	ldr r3, [r5, #0x24]
	add r2, r4, #0x100
	orr r3, r3, #1
	orr r3, r3, #0x400
	str r3, [r5, #0x24]
	ldrh r3, [r2, #0x6e]
	ldr r2, [r5, #0x2c]
	add r2, r3, r2
	strh r2, [r5, #0x32]
	ldr r2, [r4, #0x164]
	ldr r2, [r2, #0x34]
	tst r2, #1
	bne _0218246C
	sub r3, r1, #0x3600
	mov r2, #0x2000
	str r2, [sp, #8]
	str r3, [sp, #4]
	str r1, [sp]
	ldr r1, [r4, #0x15c]
	add r2, sp, #0
	bl SailSubTorpedo2__Create
	mov r0, #0x4000
	str r0, [r5, #4]
	str r0, [r5, #8]
_0218246C:
	mov r1, #0
	str r1, [r5, #0x28]
	ldr r0, [r4, #0x170]
	cmp r0, #0
	movgt r0, #1
	suble r0, r1, #1
	str r0, [r5, #0x2c]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02182490: .word SailSubItem__State_2182494
	arm_func_end SailSubItem__Func_21823EC

	arm_func_start SailSubItem__State_2182494
SailSubItem__State_2182494: // 0x02182494
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r1, [r6, #8]
	ldr r4, [r6, #0x124]
	cmp r1, #0
	mov r5, #0x1000
	bne _021824CC
	add r1, r4, #0x100
	ldrh r2, [r1, #0x6e]
	ldr r1, [r6, #0x2c]
	add r1, r2, r1
	strh r1, [r6, #0x32]
	bl SailObject__ApplyRotation
_021824CC:
	ldr r0, [r6, #0x2c]
	mov r3, #1
	cmp r0, #0
	bge _021824FC
	mov r2, #0x400
	str r2, [sp]
	mov r1, #0x20
	str r1, [sp, #4]
	sub r1, r2, #0x4c00
	mov r2, #0
	bl ObjDiffSet
	b _02182518
_021824FC:
	mov r1, #0x400
	str r1, [sp]
	mov ip, #0x20
	mov r1, #0x4800
	mov r2, #0
	str ip, [sp, #4]
	bl ObjDiffSet
_02182518:
	str r0, [r6, #0x2c]
	ldr r0, [r6, #0x28]
	mov r2, #0
	add r0, r0, #1
	str r0, [r6, #0x28]
	ldr r1, [r6, #0x2c]
	cmp r0, #0x28
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	ldr r0, _021825D0 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	movhi r5, r5, lsl #0xc
	ldrsh r1, [r0, r1]
	rsb r3, r5, #0
	smull ip, r1, r3, r1
	adds r3, ip, #0x800
	adc r1, r1, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r1, lsl #20
	str r3, [r4, #0x184]
	ldr r1, [r6, #0x2c]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r0, [r0, r1]
	smull r1, r0, r5, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x17c]
	ldr r0, [r4, #0x184]
	cmp r0, #0
	mov r0, r6
	strlt r2, [r4, #0x184]
	bl SailObject__Func_2166A2C
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021825D0: .word FX_SinCosTable_
	arm_func_end SailSubItem__State_2182494

	arm_func_start SailSubMine__SetupObject
SailSubMine__SetupObject: // 0x021825D4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r2, _0218262C // =SailSubMine__State_2182630
	mov r1, #0
	str r2, [r5, #0xf4]
	str r1, [r4, #0x180]
	mov r1, #0x1000
	str r1, [r4, #0x184]
	mov r1, #0x42
	str r1, [r5, #0x2c]
	ldr r2, [r5, #0x18]
	mov r1, #0x24
	orr r2, r2, #2
	str r2, [r5, #0x18]
	bl SailSubTargetLockOnHUD__Create
	mov r0, r5
	mov r1, #0x24
	mov r2, #0
	bl SailSubTargetHUD__Create
	str r0, [r4, #0x160]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0218262C: .word SailSubMine__State_2182630
	arm_func_end SailSubMine__SetupObject

	arm_func_start SailSubMine__State_2182630
SailSubMine__State_2182630: // 0x02182630
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x2c]
	ldr r4, [r5, #0x124]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r5, #0x2c]
	bne _02182678
	ldr r0, [r5, #0x18]
	tst r0, #2
	beq _02182678
	bic r0, r0, #2
	str r0, [r5, #0x18]
	mov r0, #0x4000
	str r0, [r4, #0x50]
	ldr r0, [r5, #0x24]
	orr r0, r0, #0x400
	str r0, [r5, #0x24]
_02182678:
	ldr r0, [r4, #0x160]
	cmp r0, #0
	beq _021826A8
	ldr r0, [r0, #0x24]
	tst r0, #0x80
	beq _021826A8
	ldr r0, [r5, #0x24]
	orr r0, r0, #0x80
	str r0, [r5, #0x24]
	ldr r0, [r5, #0x18]
	bic r0, r0, #2
	str r0, [r5, #0x18]
_021826A8:
	mov r0, r5
	mov r1, #0
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	beq _021826D0
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_021826D0:
	ldr r0, [r5, #0x2c]
	cmp r0, #0
	ble _021826EC
	cmp r0, #0x1e
	ldrle r0, _0218271C // =0x00001C8D
	strle r0, [r4, #0x184]
	ble _021826F4
_021826EC:
	mov r0, #0x1000
	str r0, [r4, #0x184]
_021826F4:
	mov r0, r5
	bl SailObject__Func_2166A2C
	mov r0, r5
	bl SailSubTargetLockOnHUD__UpdateLockOnPos
	bl SailVoyageManager__GetVoyageVelocity
	ldr r0, [r0, #8]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0x184]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0218271C: .word 0x00001C8D
	arm_func_end SailSubMine__State_2182630

	arm_func_start SailSubMine2__SetupObject
SailSubMine2__SetupObject: // 0x02182720
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, _021827C0 // =SailSubMine2__State_21827C8
	mov r0, #0x1c000
	str r1, [r5, #0xf4]
	ldr r1, [r5, #0x24]
	rsb r0, r0, #0
	orr r1, r1, #0x100
	str r1, [r5, #0x24]
	ldr r2, [r4, #0x178]
	mov r1, #0
	sub r2, r2, #0x48000
	str r2, [r4, #0x178]
	str r0, [r4, #0x174]
	ldr r2, [r5, #0x24]
	mov r0, #0x500
	orr r2, r2, #1
	str r2, [r5, #0x24]
	str r1, [r4, #0x184]
	str r0, [r4, #0x180]
	str r1, [r4, #0x17c]
	add r0, r4, #0x17c
	add r3, r5, #0x98
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0x30
	str r0, [r5, #0x2c]
	ldr r1, [r5, #0x18]
	mov r0, r5
	orr r2, r1, #2
	mov r1, #0x12
	str r2, [r5, #0x18]
	bl SailSubTargetLockOnHUD__Create
	ldr r2, _021827C4 // =0x00006AAA
	mov r0, r5
	mov r1, #0x12
	bl SailSubTargetHUD__Create
	str r0, [r4, #0x160]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021827C0: .word SailSubMine2__State_21827C8
_021827C4: .word 0x00006AAA
	arm_func_end SailSubMine2__SetupObject

	arm_func_start SailSubMine2__State_21827C8
SailSubMine2__State_21827C8: // 0x021827C8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r0, [r4, #0x160]
	cmp r0, #0
	beq _021827F4
	ldr r0, [r0, #0x24]
	tst r0, #0x80
	ldrne r0, [r5, #0x24]
	orrne r0, r0, #0x80
	strne r0, [r5, #0x24]
_021827F4:
	bl SailVoyageManager__GetVoyageVelocity
	ldr r0, [r0, #8]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0x184]
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r5, #0x2c]
	cmp r0, #0x1e
	movle r0, #0
	strle r0, [r4, #0x180]
	ldr r0, [r5, #0x2c]
	subs r0, r0, #1
	str r0, [r5, #0x2c]
	beq _0218283C
	ldr r0, [r5, #0x24]
	tst r0, #0x80
	beq _02182844
_0218283C:
	mov r0, r5
	bl SailSubMine2__Func_2182850
_02182844:
	mov r0, r5
	bl SailSubTargetLockOnHUD__UpdateLockOnPos
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSubMine2__State_21827C8

	arm_func_start SailSubMine2__Func_2182850
SailSubMine2__Func_2182850: // 0x02182850
	ldr ip, [r0, #0x124]
	ldr r1, _02182890 // =SailSubMine2__State_2182894
	mov r3, #0
	str r1, [r0, #0xf4]
	mov r2, #0x12
	str r3, [ip, #0x17c]
	mov r1, #0x500
	str r1, [ip, #0x180]
	str r3, [ip, #0x184]
	add r2, r2, #9
	mov r1, #0x280
	str r2, [r0, #0x2c]
	str r1, [ip, #0x180]
	sub r0, r1, #0xa80
	str r0, [ip, #0x184]
	bx lr
	.align 2, 0
_02182890: .word SailSubMine2__State_2182894
	arm_func_end SailSubMine2__Func_2182850

	arm_func_start SailSubMine2__State_2182894
SailSubMine2__State_2182894: // 0x02182894
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, [r4, #0x160]
	cmp r1, #0
	beq _021828F0
	ldr r0, [r5, #0x18]
	tst r0, #2
	beq _021828F0
	ldr r0, [r1, #0x24]
	ands r2, r0, #0x3800
	beq _021828F0
	ldr r0, [r5, #0x24]
	mov r1, r5
	orr r0, r0, r2
	str r0, [r5, #0x24]
	ldr r0, [r4, #0x15c]
	bl SailSubTorpedo1__Create
	ldr r1, [r5, #0x18]
	mov r0, #0
	bic r1, r1, #2
	str r1, [r5, #0x18]
	str r0, [r4, #0x180]
_021828F0:
	mov r0, r5
	mov r1, #0
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	beq _02182918
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_02182918:
	bl SailVoyageManager__GetVoyageVelocity
	ldr r0, [r0, #8]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0x184]
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r5, #0x2c]
	subs r0, r0, #1
	str r0, [r5, #0x2c]
	bne _02182964
	ldr r1, [r5, #0x24]
	mov r0, #0x10000
	orr r1, r1, #0x400
	str r1, [r5, #0x24]
	ldr r1, [r5, #0x18]
	bic r1, r1, #2
	str r1, [r5, #0x18]
	str r0, [r4, #0x50]
_02182964:
	ldr r0, [r5, #0x2c]
	cmp r0, #0
	ldmleia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl SailSubTargetLockOnHUD__UpdateLockOnPos
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSubMine2__State_2182894

	arm_func_start SailSubShark__SetupObject
SailSubShark__SetupObject: // 0x0218297C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	ldr r1, _02182A44 // =SailSubShark__State_2182A54
	mov r0, #0x5000
	str r1, [r6, #0xf4]
	rsb r0, r0, #0
	str r0, [r4, #0x184]
	mov r0, #2
	str r0, [r6, #0x2c]
	ldr r0, [r6, #0x18]
	ldr r5, _02182A48 // =0x00006AAA
	orr r0, r0, #2
	str r0, [r6, #0x18]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0x14
	bgt _02182A00
	bge _02182A1C
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _02182A20
_021829D4: // jump table
	b _02182A20 // case 0
	b _02182A20 // case 1
	b _02182A20 // case 2
	b _02182A20 // case 3
	b _02182A20 // case 4
	b _02182A20 // case 5
	b _02182A20 // case 6
	b _02182A0C // case 7
	b _02182A0C // case 8
	b _02182A14 // case 9
	b _02182A14 // case 10
_02182A00:
	cmp r0, #0x15
	beq _02182A1C
	b _02182A20
_02182A0C:
	mov r5, r5, lsr #1
	b _02182A20
_02182A14:
	ldr r5, _02182A4C // =0x0000238E
	b _02182A20
_02182A1C:
	ldr r5, _02182A50 // =0x0000D555
_02182A20:
	mov r0, r6
	mov r1, #0x12
	bl SailSubTargetLockOnHUD__Create
	mov r0, r6
	mov r2, r5
	mov r1, #0x12
	bl SailSubTargetHUD__Create
	str r0, [r4, #0x160]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02182A44: .word SailSubShark__State_2182A54
_02182A48: .word 0x00006AAA
_02182A4C: .word 0x0000238E
_02182A50: .word 0x0000D555
	arm_func_end SailSubShark__SetupObject

	arm_func_start SailSubShark__State_2182A54
SailSubShark__State_2182A54: // 0x02182A54
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, [r4, #0x2c]
	ldr r5, [r4, #0x124]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x2c]
	bne _02182A88
	ldr r0, [r5, #0x184]
	ldr r1, _02182AC8 // =0x000006C8
	ldr r2, _02182ACC // =0x00001C8D
	bl ObjSpdUpSet
	str r0, [r5, #0x184]
_02182A88:
	add r0, r5, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r4
	strh r1, [r4, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r4
	bl SailObject__Func_2166A2C
	ldr r1, [r5, #0x184]
	ldr r0, _02182ACC // =0x00001C8D
	cmp r1, r0
	bne _02182ABC
	mov r0, r4
	bl SailSubShark__Func_2182AD0
_02182ABC:
	mov r0, r4
	bl SailSubTargetLockOnHUD__UpdateLockOnPos
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02182AC8: .word 0x000006C8
_02182ACC: .word 0x00001C8D
	arm_func_end SailSubShark__State_2182A54

	arm_func_start SailSubShark__Func_2182AD0
SailSubShark__Func_2182AD0: // 0x02182AD0
	ldr r3, [r0, #0x124]
	ldr r2, _02182AF0 // =SailSubShark__State_2182AF8
	ldr r1, _02182AF4 // =0x00001C8D
	str r2, [r0, #0xf4]
	str r1, [r3, #0x184]
	mov r1, #0x1e
	str r1, [r0, #0x2c]
	bx lr
	.align 2, 0
_02182AF0: .word SailSubShark__State_2182AF8
_02182AF4: .word 0x00001C8D
	arm_func_end SailSubShark__Func_2182AD0

	arm_func_start SailSubShark__State_2182AF8
SailSubShark__State_2182AF8: // 0x02182AF8
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r5, [r4, #0x124]
	add r1, r5, #0x100
	ldrh r1, [r1, #0x6e]
	strh r1, [r4, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r4
	bl SailObject__Func_2166A2C
	ldr r0, [r5, #0x160]
	cmp r0, #0
	beq _02182B3C
	ldr r0, [r0, #0x24]
	tst r0, #0x80
	ldrne r0, [r4, #0x24]
	orrne r0, r0, #0x80
	strne r0, [r4, #0x24]
_02182B3C:
	ldr r0, [r4, #0x2c]
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	beq _02182B58
	ldr r0, [r4, #0x24]
	tst r0, #0x80
	beq _02182B60
_02182B58:
	mov r0, r4
	bl SailSubShark__Func_2182B6C
_02182B60:
	mov r0, r4
	bl SailSubTargetLockOnHUD__UpdateLockOnPos
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSubShark__State_2182AF8

	arm_func_start SailSubShark__Func_2182B6C
SailSubShark__Func_2182B6C: // 0x02182B6C
	ldr r3, [r0, #0x124]
	ldr r2, _02182C28 // =SailSubShark__State_2182C2C
	mov r1, #0x12
	str r2, [r0, #0xf4]
	str r1, [r0, #0x2c]
	ldr r1, [r3, #0x164]
	ldrh r1, [r1, #0x30]
	cmp r1, #0x14
	bgt _02182BCC
	bge _02182BF8
	cmp r1, #0xa
	addls pc, pc, r1, lsl #2
	b _02182C18
_02182BA0: // jump table
	b _02182C18 // case 0
	b _02182C18 // case 1
	b _02182C18 // case 2
	b _02182C18 // case 3
	b _02182C18 // case 4
	b _02182C18 // case 5
	b _02182C18 // case 6
	b _02182BD8 // case 7
	b _02182BD8 // case 8
	b _02182BE8 // case 9
	b _02182BE8 // case 10
_02182BCC:
	cmp r1, #0x15
	beq _02182BF8
	b _02182C18
_02182BD8:
	ldr r1, [r0, #0x2c]
	mov r1, r1, lsl #1
	str r1, [r0, #0x2c]
	b _02182C18
_02182BE8:
	ldr r1, [r0, #0x2c]
	add r1, r1, r1, lsl #1
	str r1, [r0, #0x2c]
	b _02182C18
_02182BF8:
	ldr r2, [r0, #0x2c]
	mov r1, #0x1800
	mov r2, r2, asr #1
	str r2, [r0, #0x2c]
	ldr r2, [r0, #0x140]
	str r1, [r2, #0x20]
	str r1, [r2, #0x24]
	str r1, [r2, #0x28]
_02182C18:
	ldr r1, [r0, #0x2c]
	add r1, r1, #9
	str r1, [r0, #0x2c]
	bx lr
	.align 2, 0
_02182C28: .word SailSubShark__State_2182C2C
	arm_func_end SailSubShark__Func_2182B6C

	arm_func_start SailSubShark__State_2182C2C
SailSubShark__State_2182C2C: // 0x02182C2C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl ExWork__Func_2076D90
	ldr r0, [r5, #0x98]
	add r1, r4, #0x100
	rsb r0, r0, #0
	str r0, [r4, #0x17c]
	ldr r2, [r5, #0x9c]
	mov r0, r5
	str r2, [r4, #0x180]
	ldrh r1, [r1, #0x6e]
	strh r1, [r5, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r1, [r4, #0x160]
	cmp r1, #0
	beq _02182CB4
	ldr r0, [r5, #0x18]
	tst r0, #2
	beq _02182CB4
	ldr r0, [r1, #0x24]
	ands r2, r0, #0x3800
	beq _02182CB4
	ldr r0, [r5, #0x24]
	mov r1, r5
	orr r0, r0, r2
	str r0, [r5, #0x24]
	ldr r0, [r4, #0x15c]
	bl SailSubTorpedo1__Create
	ldr r0, [r5, #0x18]
	bic r0, r0, #2
	str r0, [r5, #0x18]
_02182CB4:
	ldr r0, [r5, #0x2c]
	subs r1, r0, #1
	str r1, [r5, #0x2c]
	bne _02182CDC
	ldr r0, [r5, #0x18]
	tst r0, #2
	beq _02182CDC
	mov r0, r5
	bl SailSubShark__Func_2182CF4
	ldmia sp!, {r3, r4, r5, pc}
_02182CDC:
	cmp r1, #0
	movle r0, #0
	strle r0, [r4, #0x17c]
	mov r0, r5
	bl SailSubTargetLockOnHUD__UpdateLockOnPos
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSubShark__State_2182C2C

	arm_func_start SailSubShark__Func_2182CF4
SailSubShark__Func_2182CF4: // 0x02182CF4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x30
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, _02182DBC // =SailSubShark__State_2182DC4
	mov r0, #0x1e
	str r1, [r5, #0xf4]
	str r0, [r5, #0x2c]
	ldr r1, [r5, #0x18]
	mov r0, #0x5000
	bic r1, r1, #2
	str r1, [r5, #0x18]
	str r0, [r4, #0x50]
	add r0, r5, #0x44
	add r3, r4, #0x10
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0
	mov r0, #0x1e000
	str r0, [sp, #0x2c]
	add r0, r4, #0x100
	str r1, [sp, #0x24]
	str r1, [sp, #0x28]
	ldrh r1, [r0, #0x6e]
	ldr r3, _02182DC0 // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #0x24
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
	add r0, r4, #0x10
	add r1, sp, #0x24
	mov r2, r0
	bl VEC_Add
	mov r0, #0
	str r0, [r5, #0x2c]
	str r0, [r5, #0x28]
	ldr r0, [r5, #0x24]
	orr r0, r0, #0x400
	str r0, [r5, #0x24]
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02182DBC: .word SailSubShark__State_2182DC4
_02182DC0: .word FX_SinCosTable_
	arm_func_end SailSubShark__Func_2182CF4

	arm_func_start SailSubShark__State_2182DC4
SailSubShark__State_2182DC4: // 0x02182DC4
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x14
	mov r5, r0
	ldr r4, [r5, #0x124]
	mov r1, #0x280
	ldr r6, [r4, #0x17c]
	mov r0, r6
	bl ObjSpdDownSet
	str r0, [r4, #0x17c]
	cmp r0, #0
	bne _02182E64
	cmp r6, #0
	ldrne r0, [r4, #0x170]
	strne r0, [r5, #0x2c]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #1
	bne _02182E64
	ldr r0, [r4, #0x170]
	cmp r0, #0
	bge _02182E40
	mov r3, #0x800
	str r3, [sp]
	mov r1, #0xc0
	str r1, [sp, #4]
	ldr r2, [r5, #0x2c]
	sub r1, r3, #0x4800
	mov r3, #1
	bl ObjDiffSet
	str r0, [r4, #0x170]
	b _02182E64
_02182E40:
	mov r1, #0x800
	str r1, [sp]
	mov r1, #0xc0
	str r1, [sp, #4]
	ldr r2, [r5, #0x2c]
	mov r1, #0x4000
	mov r3, #1
	bl ObjDiffSet
	str r0, [r4, #0x170]
_02182E64:
	mov r0, #0xe000
	ldr r1, [r4, #0x174]
	rsb r0, r0, #0
	cmp r1, r0
	ldr r0, [r4, #0x180]
	mov r2, #0x600
	bge _02182E8C
	mov r1, #0x40
	bl ObjSpdUpSet
	b _02182E94
_02182E8C:
	mvn r1, #0x3f
	bl ObjSpdUpSet
_02182E94:
	str r0, [r4, #0x180]
	mov r1, #0x1c0
	ldr r0, [r4, #0x184]
	rsb r1, r1, #0
	mov r2, #0x2400
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
	mov r0, #0x100
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	ldr r0, [r5, #0x28]
	mov r1, #0x1000
	mov r2, #0
	mov r3, #1
	bl ObjDiffSet
	str r0, [r5, #0x28]
	add r0, r4, #0x10
	add r3, sp, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r5
	bl SailObject__Func_2166728
	ldr r2, [r5, #0x28]
	ldr r0, [r4, #0x10]
	mov r2, r2, lsl #0x10
	ldr r1, [sp, #8]
	mov r2, r2, lsr #0x10
	bl ObjAlphaSet
	str r0, [r4, #0x10]
	ldr r2, [r5, #0x28]
	ldr r0, [r4, #0x14]
	mov r2, r2, lsl #0x10
	ldr r1, [sp, #0xc]
	mov r2, r2, lsr #0x10
	bl ObjAlphaSet
	str r0, [r4, #0x14]
	ldr r2, [r5, #0x28]
	ldr r0, [r4, #0x18]
	mov r2, r2, lsl #0x10
	ldr r1, [sp, #0x10]
	mov r2, r2, lsr #0x10
	bl ObjAlphaSet
	str r0, [r4, #0x18]
	mov r0, r5
	bl SailObject__Func_2166834
	add r0, sp, #8
	add r3, r4, #0x10
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r5
	bl SailObject__Func_2166A2C
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end SailSubShark__State_2182DC4

	arm_func_start SailSubDepth__SetupObject
SailSubDepth__SetupObject: // 0x02182F6C
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, _02183028 // =SailSubDepth__State_218303C
	mov r0, #0x5000
	str r1, [r5, #0xf4]
	rsb r0, r0, #0
	str r0, [r4, #0x184]
	mov r0, #2
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x18]
	ldr r6, _0218302C // =0x00006AAA
	orr r0, r0, #2
	str r0, [r5, #0x18]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0x16
	bgt _02182FDC
	bge _02182FF8
	cmp r0, #0xf
	bgt _02182FF0
	cmp r0, #0xc
	blt _02182FF0
	beq _02183004
	cmp r0, #0xd
	cmpne r0, #0xf
	beq _02182FE8
	b _02182FF0
_02182FDC:
	cmp r0, #0x17
	beq _02183000
	b _02182FF0
_02182FE8:
	ldr r6, _02183030 // =0x00003555
	b _02183004
_02182FF0:
	ldr r6, _02183034 // =0x0000238E
	b _02183004
_02182FF8:
	sub r6, r6, #0x5000
	b _02183004
_02183000:
	ldr r6, _02183038 // =0x00001555
_02183004:
	mov r0, r5
	mov r1, #0x12
	bl SailSubTargetLockOnHUD__Create
	mov r0, r5
	mov r2, r6
	mov r1, #0x12
	bl SailSubTargetHUD__Create
	str r0, [r4, #0x160]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02183028: .word SailSubDepth__State_218303C
_0218302C: .word 0x00006AAA
_02183030: .word 0x00003555
_02183034: .word 0x0000238E
_02183038: .word 0x00001555
	arm_func_end SailSubDepth__SetupObject

	arm_func_start SailSubDepth__State_218303C
SailSubDepth__State_218303C: // 0x0218303C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x2c]
	ldr r4, [r5, #0x124]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r5, #0x2c]
	bne _02183070
	ldr r0, [r4, #0x184]
	ldr r1, _021830AC // =0x000006C8
	ldr r2, _021830B0 // =0x00001C8D
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
_02183070:
	mov r0, r5
	bl SailObject__Func_2166728
	mov r0, r5
	bl SailObject__Func_2166834
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r1, [r4, #0x184]
	ldr r0, _021830B0 // =0x00001C8D
	cmp r1, r0
	bne _021830A0
	mov r0, r5
	bl SailSubDepth__Func_21830B4
_021830A0:
	mov r0, r5
	bl SailSubTargetLockOnHUD__UpdateLockOnPos
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021830AC: .word 0x000006C8
_021830B0: .word 0x00001C8D
	arm_func_end SailSubDepth__State_218303C

	arm_func_start SailSubDepth__Func_21830B4
SailSubDepth__Func_21830B4: // 0x021830B4
	ldr r3, [r0, #0x124]
	ldr r2, _021830D4 // =SailSubDepth__State_21830DC
	ldr r1, _021830D8 // =0x00001C8D
	str r2, [r0, #0xf4]
	str r1, [r3, #0x184]
	mov r1, #0x1e
	str r1, [r0, #0x2c]
	bx lr
	.align 2, 0
_021830D4: .word SailSubDepth__State_21830DC
_021830D8: .word 0x00001C8D
	arm_func_end SailSubDepth__Func_21830B4

	arm_func_start SailSubDepth__State_21830DC
SailSubDepth__State_21830DC: // 0x021830DC
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r5, [r4, #0x124]
	bl SailObject__Func_2166728
	mov r0, r4
	bl SailObject__Func_2166834
	mov r0, r4
	bl SailObject__Func_2166A2C
	ldr r0, [r5, #0x160]
	cmp r0, #0
	beq _0218311C
	ldr r0, [r0, #0x24]
	tst r0, #0x80
	ldrne r0, [r4, #0x24]
	orrne r0, r0, #0x80
	strne r0, [r4, #0x24]
_0218311C:
	ldr r0, [r4, #0x2c]
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	beq _02183138
	ldr r0, [r4, #0x24]
	tst r0, #0x80
	beq _02183140
_02183138:
	mov r0, r4
	bl SailSubDepth__Func_218314C
_02183140:
	mov r0, r4
	bl SailSubTargetLockOnHUD__UpdateLockOnPos
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSubDepth__State_21830DC

	arm_func_start SailSubDepth__Func_218314C
SailSubDepth__Func_218314C: // 0x0218314C
	ldr r3, [r0, #0x124]
	ldr r2, _021831F4 // =SailSubDepth__State_21831F8
	mov r1, #0x12
	str r2, [r0, #0xf4]
	str r1, [r0, #0x2c]
	ldr r1, [r3, #0x164]
	ldrh r1, [r1, #0x30]
	cmp r1, #0x16
	bgt _02183198
	bge _021831C4
	cmp r1, #0xf
	bgt _021831B4
	cmp r1, #0xc
	blt _021831B4
	beq _021831E4
	cmp r1, #0xd
	cmpne r1, #0xf
	beq _021831A4
	b _021831B4
_02183198:
	cmp r1, #0x17
	beq _021831D4
	b _021831B4
_021831A4:
	ldr r1, [r0, #0x2c]
	mov r1, r1, lsl #1
	str r1, [r0, #0x2c]
	b _021831E4
_021831B4:
	ldr r1, [r0, #0x2c]
	add r1, r1, r1, lsl #1
	str r1, [r0, #0x2c]
	b _021831E4
_021831C4:
	ldr r1, [r0, #0x2c]
	mov r1, r1, lsl #2
	str r1, [r0, #0x2c]
	b _021831E4
_021831D4:
	ldr r2, [r0, #0x2c]
	mov r1, #6
	mul r1, r2, r1
	str r1, [r0, #0x2c]
_021831E4:
	ldr r1, [r0, #0x2c]
	add r1, r1, #9
	str r1, [r0, #0x2c]
	bx lr
	.align 2, 0
_021831F4: .word SailSubDepth__State_21831F8
	arm_func_end SailSubDepth__Func_218314C

	arm_func_start SailSubDepth__State_21831F8
SailSubDepth__State_21831F8: // 0x021831F8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl ExWork__Func_2076D90
	ldr r1, [r5, #0x98]
	mov r0, r5
	rsb r1, r1, #0
	str r1, [r4, #0x17c]
	ldr r1, [r5, #0x9c]
	str r1, [r4, #0x180]
	bl SailObject__Func_2166728
	mov r0, r5
	bl SailObject__Func_2166834
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r1, [r4, #0x160]
	cmp r1, #0
	beq _0218327C
	ldr r0, [r5, #0x18]
	tst r0, #2
	beq _0218327C
	ldr r0, [r1, #0x24]
	ands r2, r0, #0x3800
	beq _0218327C
	ldr r0, [r5, #0x24]
	mov r1, r5
	orr r0, r0, r2
	str r0, [r5, #0x24]
	ldr r0, [r4, #0x15c]
	bl SailSubTorpedo1__Create
	ldr r0, [r5, #0x18]
	bic r0, r0, #2
	str r0, [r5, #0x18]
_0218327C:
	ldr r0, [r5, #0x2c]
	subs r1, r0, #1
	str r1, [r5, #0x2c]
	bne _021832A4
	ldr r0, [r5, #0x18]
	tst r0, #2
	beq _021832A4
	mov r0, r5
	bl SailSubDepth__Func_21832D8
	ldmia sp!, {r3, r4, r5, pc}
_021832A4:
	cmp r1, #9
	bgt _021832CC
	ldr r0, [r5, #0x98]
	mov r1, #0x180
	bl ObjSpdDownSet
	str r0, [r5, #0x98]
	ldr r0, [r5, #0x9c]
	mov r1, #0x180
	bl ObjSpdDownSet
	str r0, [r5, #0x9c]
_021832CC:
	mov r0, r5
	bl SailSubTargetLockOnHUD__UpdateLockOnPos
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSubDepth__State_21831F8

	arm_func_start SailSubDepth__Func_21832D8
SailSubDepth__Func_21832D8: // 0x021832D8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r2, _02183384 // =SailSubDepth__State_2183388
	mov r1, #0
	str r2, [r5, #0xf4]
	str r1, [r4, #0x184]
	ldr r3, [r5, #0x24]
	add r2, r4, #0x100
	orr r3, r3, #1
	str r3, [r5, #0x24]
	ldrh r3, [r2, #0x6e]
	ldr r2, [r5, #0x2c]
	add r2, r3, r2
	strh r2, [r5, #0x32]
	ldr r2, [r4, #0x164]
	ldr r2, [r2, #0x34]
	tst r2, #1
	bne _02183354
	sub r3, r1, #0x3600
	mov r2, #0x2000
	str r2, [sp, #8]
	str r3, [sp, #4]
	str r1, [sp]
	ldr r1, [r4, #0x15c]
	add r2, sp, #0
	bl SailSubTorpedo2__Create
	mov r0, #0x4000
	str r0, [r5, #4]
	str r0, [r5, #8]
_02183354:
	ldr r0, [r5, #0x24]
	mov r1, #0
	orr r0, r0, #0x400
	str r0, [r5, #0x24]
	str r1, [r5, #0x28]
	ldr r0, [r4, #0x170]
	cmp r0, #0
	movgt r0, #1
	suble r0, r1, #1
	str r0, [r5, #0x2c]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02183384: .word SailSubDepth__State_2183388
	arm_func_end SailSubDepth__Func_21832D8

	arm_func_start SailSubDepth__State_2183388
SailSubDepth__State_2183388: // 0x02183388
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r1, [r6, #8]
	ldr r4, [r6, #0x124]
	cmp r1, #0
	mov r5, #0x1000
	bne _021833C0
	add r1, r4, #0x100
	ldrh r2, [r1, #0x6e]
	ldr r1, [r6, #0x2c]
	add r1, r2, r1
	strh r1, [r6, #0x32]
	bl SailObject__ApplyRotation
_021833C0:
	ldr r0, [r6, #0x2c]
	mov r3, #1
	cmp r0, #0
	bge _021833F0
	mov r2, #0x400
	str r2, [sp]
	mov r1, #0x20
	str r1, [sp, #4]
	sub r1, r2, #0x4c00
	mov r2, #0
	bl ObjDiffSet
	b _0218340C
_021833F0:
	mov r1, #0x400
	str r1, [sp]
	mov ip, #0x20
	mov r1, #0x4800
	mov r2, #0
	str ip, [sp, #4]
	bl ObjDiffSet
_0218340C:
	str r0, [r6, #0x2c]
	ldr r0, [r6, #0x28]
	mov r2, #0
	add r0, r0, #1
	str r0, [r6, #0x28]
	ldr r1, [r6, #0x2c]
	cmp r0, #0x28
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	ldr r0, _021834D4 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	movhi r5, r5, lsl #0xc
	ldrsh r1, [r0, r1]
	rsb r3, r5, #0
	smull ip, r1, r3, r1
	adds r3, ip, #0x800
	adc r1, r1, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r1, lsl #20
	str r3, [r4, #0x184]
	ldr r1, [r6, #0x2c]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r0, [r0, r1]
	smull r1, r0, r5, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x17c]
	ldr r0, [r4, #0x184]
	mov r1, #0x100
	cmp r0, #0
	strlt r2, [r4, #0x184]
	ldr r0, [r4, #0x180]
	bl ObjSpdDownSet
	str r0, [r4, #0x180]
	mov r0, r6
	bl SailObject__Func_2166A2C
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021834D4: .word FX_SinCosTable_
	arm_func_end SailSubDepth__State_2183388

	.rodata

_0218C444: // 0x0218C444
    .word 0, 0, 0
	.word 0, 0xFFFFFEF0, 0
	.byte 8
	.byte 0
	.align 4
	
	.word 0, 0, 0
	.word 0, 0, 0
	.byte 0
	.byte 0
	.align 4

_0218C47C: // 0x0218C47C
    .word 0, 0, 0
	.word 0xF0, 0, 0
	.byte 8
	.byte 0
	.align 4
	
	.word 0, 0, 0
	.word 0, 0, 0
	.byte 0
	.byte 0
	.align 4

_0218C4B4: // 0x0218C4B4
    .word 0, 0, 0
	.word 0, 0xFFFFFEF0, 0
	.byte 8
	.byte 0
	.align 4

	.word 0, 0xFFFFF780, 0
	.word 0, 0, 0
	.byte 1
	.byte 0
	.align 4

	.word 0, 0xFFFFF780, 0
	.word 0xFFFFFF78, 0x88, 0
	.byte 0x10
	.byte 0
	.align 4
	
	.word 0, 0, 0	
	.word 0, 0, 0
	.byte 0
	.byte 0
	.align 4

_0218C524: // 0x0218C524
    .word 0, 0, 0
	.word 0, 0xFFFFFEF0, 0
	.byte 8
	.byte 0
	.align 4

	.word 0, 0xFFFFF780, 0
	.word 0, 0, 0
	.byte 0x13
	.byte 0
	.align 4

	.word 0, 0xFFFFF780, 0
	.word 0xFFFFFF78, 0x88, 0
	.byte 0x10
	.byte 0
	.align 4
	
	.word 0, 0, 0
	.word 0, 0, 0
	.byte 0
	.byte 0
	.align 4

_0218C594: // 0x0218C594
    .word 0, 0, 0
	.word 0, 0xFFFFFEF0, 0
	.byte 8
	.byte 0
	.align 4

	.word 0, 0xFFFFF780, 0
	.word 0, 0, 0
	.byte 1
	.byte 0
	.align 4

	.word 0, 0xFFFFF780, 0
	.word 0xFFFFFF78, 0x88, 0
	.byte 0x10
	.byte 0
	.align 4

	.word 0xFFFFF780, 0, 0
	.word 0, 0, 0
	.byte 3
	.byte 0
	.align 4

	.word 0xFFFFF780, 0, 0
	.word 0x88, 0x88, 0
	.byte 0x10
	.byte 0
	.align 4
	
	.word 0, 0, 0
	.word 0, 0, 0
	.byte 0
	.byte 0
	.align 4

_0218C63C: // 0x0218C63C
    .word 0, 0, 0
	.word 0, 0xFFFFFEF0, 0
	.byte 8
	.byte 0
	.align 4

	.word 0, 0xFFFFF780, 0
	.word 0, 0, 0
	.byte 1
	.byte 0
	.align 4

	.word 0, 0xFFFFF780, 0
	.word 0xFFFFFF78, 0x88, 0
	.byte 0x10
	.byte 0
	.align 4

	.word 0xFFFFF780, 0, 0
	.word 0, 0, 0
	.byte 3
	.byte 0
	.align 4

	.word 0xFFFFF780, 0, 0
	.word 0x88, 0xFFFFFF78, 0
	.byte 0x10
	.byte 0
	.align 4
	
	.word 0, 0, 0
	.word 0, 0, 0
	.byte 0
	.byte 0
	.align 4

_0218C6E4: // 0x0218C6E4
    .word 0, 0, 0
	.word 0, 0xFFFFFE40, 0
	.byte 8
	.byte 0
	.align 4

	.word 0, 0xFFFFF200, 0
	.word 0, 0, 0
	.byte 0x16
	.byte 0
	.align 4

	.word 0, 0xFFFFF200, 0
	.word 0xFFFFFF50, 0x100, 0
	.byte 8
	.byte 0
	.align 4

	.word 0xFFFFFA80, 0, 0
	.word 0, 0, 0
	.byte 0xE
	.byte 0
	.align 4

	.word 0xFFFFFA80, 0, 0
	.word 0xB0, 0x1C0, 0
	.byte 8
	.byte 0
	.align 4

	.word 0, 0xE00, 0
	.word 0, 0, 0
	.byte 0x32
	.byte 0
	.align 4
	
	.word 0, 0, 0
	.word 0, 0, 0
	.byte 0
	.byte 0
	.align 4

_0218C7A8: // 0x0218C7A8
    .word 0, 0, 0
	.word 0, 0xFFFFFEE0, 0
	.byte 8
	.byte 0
	.align 4

	.word 0, 0xFFFFF700, 0
	.word 0, 0, 0
	.byte 0x16
	.byte 0
	.align 4

	.word 0, 0xFFFFF700, 0
	.word 0xFFFFFF30, 0x100, 0
	.byte 8
	.byte 0
	.align 4

	.word 0xFFFFF980, 0, 0
	.word 0, 0, 0
	.byte 0xE
	.byte 0
	.align 4

	.word 0xFFFFF980, 0, 0
	.word 0xD0, 0x120, 0
	.byte 8
	.byte 0
	.align 4

	.word 0, 0x900, 0
	.word 0, 0, 0
	.byte 0x16
	.byte 0
	.align 4

	.word 0, 0x900, 0
	.word 0xD0, 0xFFFFFEE0, 0
	.byte 8
	.byte 0
	.align 4

	.word 0x680, 0, 0
	.word 0, 0, 0
	.byte 0x1E
	.byte 0
	.align 4
	
	.word 0, 0, 0
	.word 0, 0, 0
	.byte 0
	.byte 0
	.align 4

	.data

aSbSubFixBac: // 0x0218D660
	.asciz "sb_sub_fix.bac"
    .align 4

aSbSubLogoFixBa: // 0x0218D670
	.asciz "sb_sub_logo_fix.bac"
    .align 4

aSbTorpedoNsbmd_1: // 0x0218D684
	.asciz "sb_torpedo.nsbmd"
    .align 4

aSbSBoat02Nsbmd_1: // 0x0218D698
	.asciz "sb_s_boat02.nsbmd"
    .align 4

aSbSDepthNsbmd_0: // 0x0218D6AC
	.asciz "sb_s_depth.nsbmd"
    .align 4

aSbMineBac_1: // 0x0218D6C0
	.asciz "sb_mine.bac"
    .align 4

aSbBSharkNsbmd_0: // 0x0218D6CC
	.asciz "sb_b_shark.nsbmd"
    .align 4

aSbBSharkNsbca: // 0x0218D6E0
	.asciz "sb_b_shark.nsbca"
    .align 4

aSbItemBac_0: // 0x0218D6F4
	.asciz "sb_item.bac"
    .align 4