	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailHUDInitEvent__Create
SailHUDInitEvent__Create: // 0x0216E638
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	bl SailManager__GetWork
	mov r1, #0x1000
	mov r4, r0
	mov r2, #0
	str r1, [sp]
	mov r5, #1
	str r5, [sp, #4]
	mov r5, #8
	ldr r0, _0216E6AC // =SailHUDInitEvent__Main
	ldr r1, _0216E6B0 // =SailHUDInitEvent__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r5, r0
	mov r1, r5
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear16
	ldr r1, [r4, #0x24]
	mov r0, r5
	orr r1, r1, #0x800
	orr r1, r1, #1
	str r1, [r4, #0x24]
	bl SailHUDInitEvent__SetupHUD
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216E6AC: .word SailHUDInitEvent__Main
_0216E6B0: .word SailHUDInitEvent__Destructor
	arm_func_end SailHUDInitEvent__Create

	arm_func_start SailClearedEvent__Create
SailClearedEvent__Create: // 0x0216E6B4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl SailManager__GetWork
	mov r4, r0
	ldr r0, _0216E874 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	mov r5, r0
	ldr r0, [r5, #0x120]
	ldr r1, _0216E878 // =SailClearedEvent__Destructor
	bl SetTaskDestructorEvent
	mov r0, r5
	bl StageTask__InitSeqPlayer
	ldr r0, [r4, #0x24]
	orr r0, r0, #3
	str r0, [r4, #0x24]
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	mov r6, #0
	cmp r0, #0
	ldrne r6, [r0, #0x124]
	cmp r6, #0
	beq _0216E74C
	ldr r2, [r6, #0x1a8]
	ldr r0, [r6, #0x1a4]
	mov r1, #0x64
	mla r3, r0, r1, r2
	str r3, [r6, #0x1a8]
	ldr r2, [r6, #0x1ac]
	mov r0, #0x1f4
	mla r3, r2, r0, r3
	str r3, [r6, #0x1a8]
	add r0, r6, #0x100
	ldrh r2, [r0, #0xc6]
	ldr r0, _0216E87C // =0x05F5E0FF
	mla r1, r2, r1, r3
	str r1, [r6, #0x1a8]
	cmp r1, r0
	strhi r0, [r6, #0x1a8]
_0216E74C:
	cmp r6, #0
	beq _0216E760
	ldrh r0, [r4, #0x12]
	cmp r0, #2
	beq _0216E778
_0216E760:
	ldrh r0, [r4, #0x12]
	cmp r0, #3
	beq _0216E778
	ldr r0, [r4, #0x24]
	tst r0, #0x100000
	beq _0216E858
_0216E778:
	ldr r0, [r4, #0x24]
	tst r0, #0x200000
	bne _0216E858
	ldr r7, _0216E880 // =0x0000FFFF
	bl SailManager__GetShipType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0216E834
_0216E798: // jump table
	b _0216E7A8 // case 0
	b _0216E7D8 // case 1
	b _0216E7F8 // case 2
	b _0216E818 // case 3
_0216E7A8:
	ldr r0, [r4, #0x24]
	ldr r1, [r4, #0x20]
	tst r0, #0x100000
	ldrneh r0, [r4, #0x10]
	addne r0, r0, #2
	ldreqh r0, [r4, #0x14]
	subeq r0, r0, #0x33
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__SetVikingCupJetskiRecord
	mov r7, r0
	b _0216E834
_0216E7D8:
	ldrh r0, [r4, #0x14]
	ldr r1, [r6, #0x1a8]
	sub r0, r0, #0x3d
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__SetVikingCupSailboatRecord
	mov r7, r0
	b _0216E834
_0216E7F8:
	ldrh r0, [r4, #0x14]
	ldr r1, [r6, #0x1a8]
	sub r0, r0, #0x47
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__SetVikingCupHovercraftRecord
	mov r7, r0
	b _0216E834
_0216E818:
	ldrh r0, [r4, #0x14]
	ldr r1, [r6, #0x1a8]
	sub r0, r0, #0x51
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__SetVikingCupSubmarineRecord
	mov r7, r0
_0216E834:
	ldr r0, _0216E880 // =0x0000FFFF
	cmp r7, r0
	ldrne r0, [r5, #0x24]
	orrne r0, r0, #8
	strne r0, [r5, #0x24]
	cmp r7, #0
	ldreq r0, [r5, #0x24]
	orreq r0, r0, #0x10
	streq r0, [r5, #0x24]
_0216E858:
	mov r0, r5
	bl CreateSailHUDClearText
	mov r0, #5
	bl SetPadReplayState
	mov r0, #5
	bl SetTouchReplayState
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216E874: .word 0x00001010
_0216E878: .word SailClearedEvent__Destructor
_0216E87C: .word 0x05F5E0FF
_0216E880: .word 0x0000FFFF
	arm_func_end SailClearedEvent__Create

	arm_func_start SailRetireEvent__CreateFailText
SailRetireEvent__CreateFailText: // 0x0216E884
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	bl SailManager__GetWork
	mov r2, #0x1000
	mov r1, #0
	mov r5, r0
	str r2, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #8
	ldr r0, _0216E980 // =SailRetireEvent__Main
	mov r2, r1
	mov r3, r1
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear16
	ldr r0, [r5, #0x24]
	orr r0, r0, #9
	str r0, [r5, #0x24]
	ldr r0, [r5, #0x70]
	cmp r0, #0
	beq _0216E934
	bl SailPlayer__HasRetired
	cmp r0, #0
	beq _0216E934
	ldr r0, _0216E984 // =defaultTrackPlayer
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	sub r1, r0, #1
	mov ip, #4
	mov r2, r1
	mov r3, r1
	str ip, [sp]
	bl PlayTrack
	ldr r0, _0216E988 // =gameState
	mov r1, #6
	strb r1, [r0, #0xdc]
	b _0216E940
_0216E934:
	ldr r0, _0216E988 // =gameState
	mov r1, #0
	strb r1, [r0, #0xdc]
_0216E940:
	ldr r0, [r5, #0xc]
	cmp r0, #0
	bne _0216E958
	ldrh r0, [r5, #0x12]
	cmp r0, #1
	bls _0216E968
_0216E958:
	bl SailHUDRetireText__Create
	ldr r0, [r4, #4]
	orr r0, r0, #1
	str r0, [r4, #4]
_0216E968:
	mov r0, #5
	bl SetPadReplayState
	mov r0, #5
	bl SetTouchReplayState
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216E980: .word SailRetireEvent__Main
_0216E984: .word defaultTrackPlayer
_0216E988: .word gameState
	arm_func_end SailRetireEvent__CreateFailText

	arm_func_start SailRetireEvent__CreateFadeOut
SailRetireEvent__CreateFadeOut: // 0x0216E98C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	bl SailManager__GetWork
	mov r2, #0x1000
	mov r1, #0
	mov r5, r0
	str r2, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #8
	ldr r0, _0216EA70 // =SailRetireEvent__Main
	mov r2, r1
	mov r3, r1
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear16
	ldr r0, _0216EA74 // =gameState
	mov r1, #0
	strb r1, [r0, #0xdc]
	add r0, r5, #0x500
	ldrsh r0, [r0, #0xd0]
	sub r0, r0, #2
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	movls r0, #0x63
	strls r0, [r4]
	add r0, r5, #0x500
	ldrsh r0, [r0, #0xd0]
	cmp r0, #0
	bne _0216EA48
	mov r0, #0x16
	str r0, [r4]
	ldr r0, [r5, #0x24]
	tst r0, #0x40
	bne _0216EA40
	tst r0, #8
	beq _0216EA48
_0216EA40:
	mov r0, #0x63
	str r0, [r4]
_0216EA48:
	ldr r0, [r5, #0x24]
	tst r0, #0x8000
	bne _0216EA60
	tst r0, #0x40000
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, pc}
_0216EA60:
	mov r0, #0x63
	str r0, [r4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216EA70: .word SailRetireEvent__Main
_0216EA74: .word gameState
	arm_func_end SailRetireEvent__CreateFadeOut

	arm_func_start SailHUDInitEvent__Destructor
SailHUDInitEvent__Destructor: // 0x0216EA78
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	bl SailManager__GetWork
	ldmia sp!, {r3, pc}
	arm_func_end SailHUDInitEvent__Destructor

	arm_func_start SailHUDInitEvent__Main
SailHUDInitEvent__Main: // 0x0216EA88
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #4]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	blx r1
	ldmia sp!, {r3, pc}
	arm_func_end SailHUDInitEvent__Main

	arm_func_start SailHUDInitEvent__SetupHUD
SailHUDInitEvent__SetupHUD: // 0x0216EAA4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	ldr r2, _0216EB4C // =SailHUDInitEvent__State_Finished
	mov r1, #0xf0
	stmia r5, {r1, r2}
	mov r4, r0
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _0216EAEC
	mov r0, #0
	bl SailJetHUDText__Create
	mov r0, #1
	bl SailJetHUDText__Create
	bl SailJetHUDTextVS__Create
	bl SailJetHUDTouchPrompt__Create
	bl SailJetHUDCountdown__Create
	ldmia sp!, {r3, r4, r5, pc}
_0216EAEC:
	bl SailHUDShipTitle__Create
	ldr r0, [r4, #0x24]
	tst r0, #0x1000
	bne _0216EB00
	bl SailHUDReadyText__Create
_0216EB00:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0216EB38
_0216EB14: // jump table
	b _0216EB2C // case 0
	b _0216EB2C // case 1
	b _0216EB2C // case 2
	b _0216EB2C // case 3
	b _0216EB2C // case 4
	b _0216EB2C // case 5
_0216EB2C:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _0216EB3C
_0216EB38:
	mov r0, #1
_0216EB3C:
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	bl SailHUDShipSubtitle__Create
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216EB4C: .word SailHUDInitEvent__State_Finished
	arm_func_end SailHUDInitEvent__SetupHUD

	arm_func_start SailHUDInitEvent__State_Finished
SailHUDInitEvent__State_Finished: // 0x0216EB50
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0]
	subs r1, r1, #1
	str r1, [r0]
	ldmplia sp!, {r3, pc}
	bl DestroyCurrentTask
	ldmia sp!, {r3, pc}
	arm_func_end SailHUDInitEvent__State_Finished

	arm_func_start SailJetHUDText__Create
SailJetHUDText__Create: // 0x0216EB6C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	ldr r0, _0216EC0C // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x70
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	ldr r3, _0216EC10 // =0x0000FFFF
	ldr r2, _0216EC14 // =aSbJetLogoFixBa
	stmia sp, {r3, r5}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r4
	bl StageTask__SetAnimation
	ldr r3, [r4, #0x134]
	mov r1, #0x1000
	ldr r2, [r3, #0xf4]
	mov r0, r4
	bic r2, r2, #0x3f000000
	orr r2, r2, #0x28000000
	str r2, [r3, #0xf4]
	ldr r2, [r4, #0x20]
	orr r2, r2, #0x20000
	str r2, [r4, #0x20]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	bl SailJetHUDText__SetupObject
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0216EC0C: .word 0x00001010
_0216EC10: .word 0x0000FFFF
_0216EC14: .word aSbJetLogoFixBa
	arm_func_end SailJetHUDText__Create

	arm_func_start SailJetHUDText__SetupObject
SailJetHUDText__SetupObject: // 0x0216EC18
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r2, #4
	ldr r1, _0216EC74 // =SailJetHUDText__State_216EC78
	str r2, [r4, #0x2c]
	str r1, [r4, #0xf4]
	mov r1, #0x168000
	str r1, [r4, #0x44]
	mov r1, #0x28000
	str r1, [r4, #0x48]
	bl StageTask__GetAnimID
	cmp r0, #2
	ldmneia sp!, {r4, pc}
	mov r1, #0x68000
	rsb r1, r1, #0
	mov r0, #0
	mov r2, r0
	str r1, [r4, #0x44]
	mov r3, #0x58000
	mov r1, #0x18
	str r3, [r4, #0x48]
	bl SailAudio__PlaySpatialSequence
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216EC74: .word SailJetHUDText__State_216EC78
	arm_func_end SailJetHUDText__SetupObject

	arm_func_start SailJetHUDText__State_216EC78
SailJetHUDText__State_216EC78: // 0x0216EC78
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl StageTask__GetAnimID
	cmp r0, #1
	moveq r4, #0x18000
	ldr r0, [r5, #0x2c]
	movne r4, #0x70000
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r5, #0x2c]
	bne _0216ECC4
	mov r0, #0x400
	str r0, [sp]
	ldr r0, [r5, #0x44]
	mov r1, r4
	mov r2, #2
	mov r3, #0
	bl ObjShiftSet
	str r0, [r5, #0x44]
_0216ECC4:
	ldr r0, [r5, #0x44]
	cmp r0, r4
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl SailJetHUDText__Func_216ECDC
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailJetHUDText__State_216EC78

	arm_func_start SailJetHUDText__Func_216ECDC
SailJetHUDText__Func_216ECDC: // 0x0216ECDC
	mov r2, #0x18
	ldr r1, _0216ECF0 // =SailJetHUDText__State_216ECF4
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0216ECF0: .word SailJetHUDText__State_216ECF4
	arm_func_end SailJetHUDText__Func_216ECDC

	arm_func_start SailJetHUDText__State_216ECF4
SailJetHUDText__State_216ECF4: // 0x0216ECF4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	bl StageTask__GetAnimID
	cmp r0, #1
	moveq r2, #0x18000
	subeq r5, r2, #0x78000
	ldr r0, [r4, #0x2c]
	movne r2, #0x70000
	movne r5, #0x160000
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x2c]
	bne _0216ED50
	mov r0, #0
	str r0, [sp]
	mov r0, #0x400
	str r0, [sp, #4]
	ldr r0, [r4, #0x44]
	mov r1, r5
	mov r3, #1
	bl ObjDiffSet
	str r0, [r4, #0x44]
_0216ED50:
	ldr r0, [r4, #0x44]
	cmp r0, r5
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #4
	streq r0, [r4, #0x18]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailJetHUDText__State_216ECF4

	arm_func_start SailJetHUDTextVS__Create
SailJetHUDTextVS__Create: // 0x0216ED6C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r0, _0216EE04 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x70
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	ldr r2, _0216EE08 // =0x0000FFFF
	mov r1, #0
	stmia sp, {r2, r5}
	str r0, [sp, #8]
	ldr r2, _0216EE0C // =aSbJetLogoFixBa
	mov r0, r4
	mov r3, #0x400
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #3
	bl StageTask__SetAnimation
	ldr r3, [r4, #0x134]
	mov r1, #0x1000
	ldr r2, [r3, #0xf4]
	mov r0, r4
	bic r2, r2, #0x3f000000
	orr r2, r2, #0x28000000
	str r2, [r3, #0xf4]
	ldr r2, [r4, #0x20]
	orr r2, r2, #0x20000
	str r2, [r4, #0x20]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	bl SailJetHUDTextVS__SetupObject
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216EE04: .word 0x00001010
_0216EE08: .word 0x0000FFFF
_0216EE0C: .word aSbJetLogoFixBa
	arm_func_end SailJetHUDTextVS__Create

	arm_func_start SailJetHUDTextVS__SetupObject
SailJetHUDTextVS__SetupObject: // 0x0216EE10
	mov r2, #0xa
	ldr r1, _0216EE5C // =SailJetHUDTextVS__State_216EE60
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	mov r1, #0x80000
	str r1, [r0, #0x44]
	mov r1, #0x40000
	str r1, [r0, #0x48]
	mov r1, #1
	str r1, [r0, #0x4c]
	mov r1, #0x4000
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	ldr r2, [r0, #0x20]
	mov r1, #0x10000
	orr r2, r2, #0x20
	str r2, [r0, #0x20]
	str r1, [r0, #0x28]
	bx lr
	.align 2, 0
_0216EE5C: .word SailJetHUDTextVS__State_216EE60
	arm_func_end SailJetHUDTextVS__SetupObject

	arm_func_start SailJetHUDTextVS__State_216EE60
SailJetHUDTextVS__State_216EE60: // 0x0216EE60
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x2c]
	subs r1, r0, #1
	str r1, [r4, #0x2c]
	bpl _0216EF10
	mvn r0, #0x11
	cmp r1, r0
	bne _0216EEA0
	mov r0, #0
	mov r3, #0x8000
	mov r2, r0
	mov r1, #0x17
	str r3, [r4, #4]
	bl SailAudio__PlaySpatialSequence
_0216EEA0:
	ldr r1, [r4, #0x20]
	mov r0, #0x80
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	str r0, [sp]
	ldr r0, [r4, #0x38]
	mov r1, #0x1000
	mov r2, #2
	mov r3, #0x800
	bl ObjShiftSet
	str r0, [r4, #0x38]
	mov r0, #0x80
	str r0, [sp]
	ldr r0, [r4, #0x38]
	mov r1, #0x1000
	mov r2, #2
	mov r3, #0x800
	bl ObjShiftSet
	str r0, [r4, #0x3c]
	mov r0, #0x80
	str r0, [sp]
	ldr r0, [r4, #0x28]
	mov r1, #0
	mov r2, #2
	mov r3, #0x3000
	bl ObjShiftSet
	str r0, [r4, #0x28]
	strh r0, [r4, #0x34]
_0216EF10:
	ldr r1, [r4, #0x2c]
	mvn r0, #0x11
	cmp r1, r0
	addge sp, sp, #4
	ldmgeia sp!, {r3, r4, pc}
	ldrh r0, [r4, #0x34]
	cmp r0, #0
	ldreq r0, [r4, #0x38]
	cmpeq r0, #0x1000
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, pc}
	mov r0, r4
	bl SailJetHUDTextVS__Func_216EF4C
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end SailJetHUDTextVS__State_216EE60

	arm_func_start SailJetHUDTextVS__Func_216EF4C
SailJetHUDTextVS__Func_216EF4C: // 0x0216EF4C
	mov r2, #0x1a
	ldr r1, _0216EF60 // =SailJetHUDTextVS__State_216EF64
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0216EF60: .word SailJetHUDTextVS__State_216EF64
	arm_func_end SailJetHUDTextVS__Func_216EF4C

	arm_func_start SailJetHUDTextVS__State_216EF64
SailJetHUDTextVS__State_216EF64: // 0x0216EF64
	ldr r1, [r0, #0x2c]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x2c]
	bxne lr
	ldr ip, [r0, #0x134]
	ldr r2, [ip, #0xf4]
	mov r1, r2, lsl #0xb
	mov r1, r1, lsr #0x1b
	sub r1, r1, #3
	bic r3, r2, #0x1f0000
	mov r2, r1, lsl #0x1b
	orr r2, r3, r2, lsr #11
	str r2, [ip, #0xf4]
	cmp r1, #1
	bxge lr
	ldr r1, [r0, #0x18]
	orr r1, r1, #4
	str r1, [r0, #0x18]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	bx lr
	arm_func_end SailJetHUDTextVS__State_216EF64

	arm_func_start SailJetHUDTouchPrompt__Create
SailJetHUDTouchPrompt__Create: // 0x0216EFC0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r0, _0216F058 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x70
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	ldr r2, _0216F05C // =0x0000FFFF
	mov r1, #0
	stmia sp, {r2, r5}
	str r0, [sp, #8]
	ldr r2, _0216F060 // =aSbJetLogoFixBa
	mov r0, r4
	mov r3, #0x800
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #8
	bl StageTask__SetAnimation
	ldr r3, [r4, #0x134]
	mov r1, #0x1000
	ldr r2, [r3, #0xf4]
	mov r0, r4
	bic r2, r2, #0x3f000000
	orr r2, r2, #0x29000000
	str r2, [r3, #0xf4]
	ldr r2, [r4, #0x20]
	orr r2, r2, #0x20000
	str r2, [r4, #0x20]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	bl SailJetHUDTouchPrompt__SetupObject
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216F058: .word 0x00001010
_0216F05C: .word 0x0000FFFF
_0216F060: .word aSbJetLogoFixBa
	arm_func_end SailJetHUDTouchPrompt__Create

	arm_func_start SailJetHUDTouchPrompt__SetupObject
SailJetHUDTouchPrompt__SetupObject: // 0x0216F064
	mov r2, #0x1c
	ldr r1, _0216F09C // =SailJetHUDTouchPrompt__State_216F0A0
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	mov r1, #0x80000
	str r1, [r0, #0x44]
	mov r1, #0x40000
	str r1, [r0, #0x48]
	sub r1, r2, #0x1d
	str r1, [r0, #0x4c]
	ldr r1, [r0, #0x20]
	orr r1, r1, #4
	str r1, [r0, #0x20]
	bx lr
	.align 2, 0
_0216F09C: .word SailJetHUDTouchPrompt__State_216F0A0
	arm_func_end SailJetHUDTouchPrompt__SetupObject

	arm_func_start SailJetHUDTouchPrompt__State_216F0A0
SailJetHUDTouchPrompt__State_216F0A0: // 0x0216F0A0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x2c]
	mov r2, #0x1000
	cmp r1, #0
	subne r0, r1, #1
	strne r0, [r4, #0x2c]
	bne _0216F120
	ldr r1, [r4, #0x20]
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x28]
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _0216F10C
_0216F0DC: // jump table
	b _0216F0EC // case 0
	b _0216F100 // case 1
	b _0216F108 // case 2
	b _0216F108 // case 3
_0216F0EC:
	mov r1, #4
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x20]
	bic r0, r0, #4
	str r0, [r4, #0x20]
_0216F100:
	mov r2, #0xc00
	b _0216F10C
_0216F108:
	mov r2, #0x1200
_0216F10C:
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	str r2, [r4, #0x38]
	str r2, [r4, #0x3c]
_0216F120:
	ldr r0, [r4, #0x28]
	cmp r0, #5
	ldmlsia sp!, {r4, pc}
	mov r0, r4
	bl SailJetHUDTouchPrompt__Func_216F138
	ldmia sp!, {r4, pc}
	arm_func_end SailJetHUDTouchPrompt__State_216F0A0

	arm_func_start SailJetHUDTouchPrompt__Func_216F138
SailJetHUDTouchPrompt__Func_216F138: // 0x0216F138
	mov r2, #0x8a
	ldr r1, _0216F154 // =SailJetHUDTouchPrompt__State_216F158
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	mov r1, #0xa
	str r1, [r0, #0x28]
	bx lr
	.align 2, 0
_0216F154: .word SailJetHUDTouchPrompt__State_216F158
	arm_func_end SailJetHUDTouchPrompt__Func_216F138

	arm_func_start SailJetHUDTouchPrompt__State_216F158
SailJetHUDTouchPrompt__State_216F158: // 0x0216F158
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r1, [r5, #0x2c]
	mov r4, #0x1000
	cmp r1, #0
	beq _0216F234
	sub r1, r1, #1
	str r1, [r5, #0x2c]
	cmp r1, #0x54
	bgt _0216F1A0
	bge _0216F1E8
	cmp r1, #0x18
	bgt _0216F194
	beq _0216F1E8
	b _0216F1F0
_0216F194:
	cmp r1, #0x36
	beq _0216F1E8
	b _0216F1F0
_0216F1A0:
	cmp r1, #0x5a
	bgt _0216F1B0
	beq _0216F1D0
	b _0216F1F0
_0216F1B0:
	cmp r1, #0x63
	bne _0216F1F0
	mov r1, #8
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	bic r0, r0, #4
	str r0, [r5, #0x20]
	b _0216F1F0
_0216F1D0:
	mov r1, #4
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	bic r0, r0, #4
	str r0, [r5, #0x20]
	b _0216F1F0
_0216F1E8:
	mov r0, #0
	str r0, [r5, #0x28]
_0216F1F0:
	ldr r0, [r5, #0x28]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0216F21C
_0216F200: // jump table
	b _0216F210 // case 0
	b _0216F210 // case 1
	b _0216F218 // case 2
	b _0216F218 // case 3
_0216F210:
	mov r4, #0xf00
	b _0216F21C
_0216F218:
	mov r4, #0x1100
_0216F21C:
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	str r4, [r5, #0x38]
	str r4, [r5, #0x3c]
	ldmia sp!, {r3, r4, r5, pc}
_0216F234:
	ldr r3, [r5, #0x134]
	ldr r1, [r3, #0xf4]
	mov r0, r1, lsl #0xb
	mov r0, r0, lsr #0x1b
	sub r0, r0, #0xa
	bic r2, r1, #0x1f0000
	mov r1, r0, lsl #0x1b
	orr r1, r2, r1, lsr #11
	str r1, [r3, #0xf4]
	cmp r0, #1
	ldmgeia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldr r0, [r5, #0x20]
	orr r0, r0, #0x20
	str r0, [r5, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailJetHUDTouchPrompt__State_216F158

	arm_func_start SailJetHUDCountdown__Create
SailJetHUDCountdown__Create: // 0x0216F27C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r0, _0216F314 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x70
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	ldr r2, _0216F318 // =0x0000FFFF
	mov r1, #0
	stmia sp, {r2, r5}
	str r0, [sp, #8]
	ldr r2, _0216F31C // =aSbJetLogoFixBa
	mov r0, r4
	mov r3, #0x900
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #7
	bl StageTask__SetAnimation
	ldr r3, [r4, #0x134]
	mov r1, #0x1000
	ldr r2, [r3, #0xf4]
	mov r0, r4
	bic r2, r2, #0x3f000000
	orr r2, r2, #0x28000000
	str r2, [r3, #0xf4]
	ldr r2, [r4, #0x20]
	orr r2, r2, #0x20000
	str r2, [r4, #0x20]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	bl SailJetHUDCountdown__SetupObject
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216F314: .word 0x00001010
_0216F318: .word 0x0000FFFF
_0216F31C: .word aSbJetLogoFixBa
	arm_func_end SailJetHUDCountdown__Create

	arm_func_start SailJetHUDCountdown__SetupObject
SailJetHUDCountdown__SetupObject: // 0x0216F320
	mov r1, #0x50
	str r1, [r0, #0x2c]
	mov r2, #0x1e
	ldr r1, _0216F378 // =SailJetHUDCountdown__State_216F37C
	str r2, [r0, #0x28]
	str r1, [r0, #0xf4]
	mov r1, #0x80000
	str r1, [r0, #0x44]
	mov r1, #0x40000
	str r1, [r0, #0x48]
	ldr r2, [r0, #0x20]
	mov r1, #0x2000
	orr r2, r2, #0x20
	str r2, [r0, #0x20]
	ldr r3, [r0, #0x134]
	ldr r2, [r3, #0xf4]
	bic r2, r2, #0x1f0000
	orr r2, r2, #0x10000
	str r2, [r3, #0xf4]
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bx lr
	.align 2, 0
_0216F378: .word SailJetHUDCountdown__State_216F37C
	arm_func_end SailJetHUDCountdown__SetupObject

	arm_func_start SailJetHUDCountdown__State_216F37C
SailJetHUDCountdown__State_216F37C: // 0x0216F37C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	ldr r1, [r5, #0x2c]
	mov r4, r0
	cmp r1, #0
	beq _0216F3B8
	subs r0, r1, #1
	str r0, [r5, #0x2c]
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #0
	mov r2, r0
	mov r1, #0x64
	bl SailAudio__PlaySpatialSequence
	ldmia sp!, {r3, r4, r5, pc}
_0216F3B8:
	ldr r0, [r5, #0x20]
	bic r0, r0, #0x20
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _0216F4AC
	cmp r0, #0x16
	blo _0216F41C
	rsb r0, r0, #0x1f
	mov r0, r0, lsl #0x12
	mov ip, r0, lsr #0x10
	ldr r3, [r5, #0x134]
	cmp ip, #0x1f
	ldr r0, [r3, #0xf4]
	mov r1, #0x200
	movhi ip, #0x1f
	bic r2, r0, #0x1f0000
	mov r0, ip, lsl #0x1b
	orr r0, r2, r0, lsr #11
	rsb r1, r1, #0
	str r0, [r3, #0xf4]
	ldr r0, [r5, #0x38]
	sub r2, r1, #0xe00
	bl ObjSpdUpSet
	b _0216F434
_0216F41C:
	ldr r2, [r5, #0x134]
	mov r0, #0x1000
	ldr r1, [r2, #0xf4]
	bic r1, r1, #0x1f0000
	orr r1, r1, #0x1f0000
	str r1, [r2, #0xf4]
_0216F434:
	str r0, [r5, #0x38]
	str r0, [r5, #0x3c]
	mov r0, r5
	bl StageTask__GetAnimID
	cmp r0, #5
	beq _0216F458
	cmp r0, #6
	beq _0216F488
	b _0216F49C
_0216F458:
	ldr r0, [r5, #0x28]
	cmp r0, #0x1a
	ldrlo r0, [r4, #0x24]
	biclo r0, r0, #0x100
	strlo r0, [r4, #0x24]
	ldr r0, [r5, #0x28]
	cmp r0, #0x15
	bhs _0216F49C
	ldr r0, [r4, #0x24]
	bic r0, r0, #0x80
	str r0, [r4, #0x24]
	b _0216F49C
_0216F488:
	ldr r0, [r5, #0x28]
	cmp r0, #5
	ldrlo r0, [r4, #0x24]
	orrlo r0, r0, #0x80
	strlo r0, [r4, #0x24]
_0216F49C:
	ldr r0, [r5, #0x28]
	sub r0, r0, #1
	str r0, [r5, #0x28]
	ldmia sp!, {r3, r4, r5, pc}
_0216F4AC:
	mov r0, #0x1e
	str r0, [r5, #0x28]
	ldr r3, [r5, #0x134]
	mov r1, #0x2000
	ldr r2, [r3, #0xf4]
	mov r0, r5
	bic r2, r2, #0x1f0000
	orr r2, r2, #0x10000
	str r2, [r3, #0xf4]
	str r1, [r5, #0x38]
	str r1, [r5, #0x3c]
	bl StageTask__GetAnimID
	cmp r0, #5
	beq _0216F4F8
	cmp r0, #6
	beq _0216F520
	cmp r0, #7
	beq _0216F54C
	ldmia sp!, {r3, r4, r5, pc}
_0216F4F8:
	mov r0, r5
	bl SailHUDGoText__Create
	ldr r1, [r5, #0x18]
	mov r0, #0
	orr r3, r1, #4
	mov r2, r0
	mov r1, #0xd
	str r3, [r5, #0x18]
	bl SailAudio__PlaySpatialSequence
	ldmia sp!, {r3, r4, r5, pc}
_0216F520:
	mov r0, #0
	mov r2, r0
	mov r1, #0x64
	bl SailAudio__PlaySpatialSequence
	mov r0, r5
	mov r1, #5
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x24]
	orr r0, r0, #0x100
	str r0, [r4, #0x24]
	ldmia sp!, {r3, r4, r5, pc}
_0216F54C:
	mov r0, #0
	mov r2, r0
	mov r1, #0x64
	bl SailAudio__PlaySpatialSequence
	mov r0, r5
	mov r1, #6
	bl StageTask__SetAnimation
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailJetHUDCountdown__State_216F37C

	arm_func_start SailHUDShipTitle__Create
SailHUDShipTitle__Create: // 0x0216F56C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r0, _0216F5F4 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x28
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	ldr r3, _0216F5F8 // =0x0000FFFF
	ldr r2, _0216F5FC // =aSbFixTitleBac
	stmia sp, {r3, r5}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r3, [r4, #0x134]
	mov r1, #0x1000
	ldr r2, [r3, #0xf4]
	mov r0, r4
	bic r2, r2, #0x3f000000
	orr r2, r2, #0x28000000
	str r2, [r3, #0xf4]
	ldr r2, [r4, #0x20]
	orr r2, r2, #0x20000
	str r2, [r4, #0x20]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	bl SailHUDShipTitle__SetupObject
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216F5F4: .word 0x00001010
_0216F5F8: .word 0x0000FFFF
_0216F5FC: .word aSbFixTitleBac
	arm_func_end SailHUDShipTitle__Create

	arm_func_start SailHUDShipTitle__SetupObject
SailHUDShipTitle__SetupObject: // 0x0216F600
	mov r2, #1
	ldr r1, _0216F624 // =SailHUDShipTitle__State_216F628
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	mov r1, #0x168000
	str r1, [r0, #0x44]
	mov r1, #0x40000
	str r1, [r0, #0x48]
	bx lr
	.align 2, 0
_0216F624: .word SailHUDShipTitle__State_216F628
	arm_func_end SailHUDShipTitle__SetupObject

	arm_func_start SailHUDShipTitle__State_216F628
SailHUDShipTitle__State_216F628: // 0x0216F628
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x2c]
	bne _0216F668
	mov r0, #0x400
	str r0, [sp]
	ldr r0, [r4, #0x44]
	mov r1, #0x80000
	mov r2, #2
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #0x44]
_0216F668:
	ldr r0, [r4, #0x44]
	cmp r0, #0x80000
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, pc}
	mov r0, r4
	bl SailHUDShipTitle__Func_216F688
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end SailHUDShipTitle__State_216F628

	arm_func_start SailHUDShipTitle__Func_216F688
SailHUDShipTitle__Func_216F688: // 0x0216F688
	mov r2, #0x20
	ldr r1, _0216F69C // =SailHUDShipTitle__State_216F6A0
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0216F69C: .word SailHUDShipTitle__State_216F6A0
	arm_func_end SailHUDShipTitle__Func_216F688

	arm_func_start SailHUDShipTitle__State_216F6A0
SailHUDShipTitle__State_216F6A0: // 0x0216F6A0
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	bl SailManager__GetWork
	ldr r1, [r5, #0x2c]
	mov r4, r0
	cmp r1, #0
	subne r0, r1, #1
	strne r0, [r5, #0x2c]
	bne _0216F6F0
	mov r1, #0
	str r1, [sp]
	mov r0, #0x400
	str r0, [sp, #4]
	ldr r0, [r5, #0x44]
	sub r1, r1, #0x60000
	mov r2, #0x80000
	mov r3, #1
	bl ObjDiffSet
	str r0, [r5, #0x44]
_0216F6F0:
	mov r0, #0x60000
	ldr r1, [r5, #0x44]
	rsb r0, r0, #0
	cmp r1, r0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x24]
	tst r0, #0x1000
	bicne r0, r0, #0x800
	strne r0, [r4, #0x24]
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailHUDShipTitle__State_216F6A0

	arm_func_start SailHUDShipSubtitle__Create
SailHUDShipSubtitle__Create: // 0x0216F72C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r0, _0216F7C0 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x28
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	ldr r3, _0216F7C4 // =0x0000FFFF
	ldr r2, _0216F7C8 // =aSbFixTitleBac
	stmia sp, {r3, r5}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimation
	ldr r3, [r4, #0x134]
	mov r1, #0x1000
	ldr r2, [r3, #0xf4]
	mov r0, r4
	bic r2, r2, #0x3f000000
	orr r2, r2, #0x28000000
	str r2, [r3, #0xf4]
	ldr r2, [r4, #0x20]
	orr r2, r2, #0x20000
	str r2, [r4, #0x20]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	bl SailHUDShipSubtitle__SetupObject
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216F7C0: .word 0x00001010
_0216F7C4: .word 0x0000FFFF
_0216F7C8: .word aSbFixTitleBac
	arm_func_end SailHUDShipSubtitle__Create

	arm_func_start SailHUDShipSubtitle__SetupObject
SailHUDShipSubtitle__SetupObject: // 0x0216F7CC
	mov r2, #0xe
	ldr r1, _0216F810 // =SailHUDShipSubtitle__State_216F814
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	mov r1, #0x80000
	str r1, [r0, #0x44]
	mov r1, #0x70000
	str r1, [r0, #0x48]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x134]
	ldr r0, [r1, #0xf4]
	bic r0, r0, #0x1f0000
	orr r0, r0, #0x10000
	str r0, [r1, #0xf4]
	bx lr
	.align 2, 0
_0216F810: .word SailHUDShipSubtitle__State_216F814
	arm_func_end SailHUDShipSubtitle__SetupObject

	arm_func_start SailHUDShipSubtitle__State_216F814
SailHUDShipSubtitle__State_216F814: // 0x0216F814
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x2c]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x2c]
	ldmneia sp!, {r3, pc}
	ldr r1, [r0, #0x20]
	bic r1, r1, #0x20
	str r1, [r0, #0x20]
	ldr r3, [r0, #0x134]
	ldr r2, [r3, #0xf4]
	mov r1, r2, lsl #0xb
	mov r1, r1, lsr #0x1b
	cmp r1, #0x1f
	ldmhsia sp!, {r3, pc}
	add r1, r1, #3
	bic r2, r2, #0x1f0000
	mov r1, r1, lsl #0x1b
	orr r1, r2, r1, lsr #11
	str r1, [r3, #0xf4]
	ldr r1, [r0, #0x134]
	ldr r1, [r1, #0xf4]
	mov r1, r1, lsl #0xb
	mov r1, r1, lsr #0x1b
	cmp r1, #0x1f
	ldmneia sp!, {r3, pc}
	bl SailHUDShipSubtitle__Func_216F884
	ldmia sp!, {r3, pc}
	arm_func_end SailHUDShipSubtitle__State_216F814

	arm_func_start SailHUDShipSubtitle__Func_216F884
SailHUDShipSubtitle__Func_216F884: // 0x0216F884
	mov r2, #0x1e
	ldr r1, _0216F898 // =SailHUDShipSubtitle__State_216F89C
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0216F898: .word SailHUDShipSubtitle__State_216F89C
	arm_func_end SailHUDShipSubtitle__Func_216F884

	arm_func_start SailHUDShipSubtitle__State_216F89C
SailHUDShipSubtitle__State_216F89C: // 0x0216F89C
	ldr r1, [r0, #0x2c]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x2c]
	bxne lr
	ldr r3, [r0, #0x134]
	ldr r2, [r3, #0xf4]
	mov r1, r2, lsl #0xb
	mov r1, r1, lsr #0x1b
	cmp r1, #1
	bxls lr
	sub r1, r1, #3
	bic r2, r2, #0x1f0000
	mov r1, r1, lsl #0x1b
	orr r1, r2, r1, lsr #11
	str r1, [r3, #0xf4]
	ldr r1, [r0, #0x134]
	ldr r1, [r1, #0xf4]
	mov r1, r1, lsl #0xb
	mov r1, r1, lsr #0x1b
	cmp r1, #1
	ldreq r1, [r0, #0x18]
	orreq r1, r1, #4
	streq r1, [r0, #0x18]
	bx lr
	arm_func_end SailHUDShipSubtitle__State_216F89C

	arm_func_start SailHUDReadyText__Create
SailHUDReadyText__Create: // 0x0216F900
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r0, _0216F994 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x29
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	ldr r3, _0216F998 // =0x0000FFFF
	ldr r2, _0216F99C // =aSbLogoFixBac
	stmia sp, {r3, r5}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r3, [r4, #0x134]
	mov r1, #0x1000
	ldr r2, [r3, #0xf4]
	mov r0, r4
	bic r2, r2, #0x3f000000
	orr r2, r2, #0x28000000
	str r2, [r3, #0xf4]
	ldr r2, [r4, #0x20]
	orr r2, r2, #0x20000
	str r2, [r4, #0x20]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	bl SailHUDReadyText__SetupObject
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216F994: .word 0x00001010
_0216F998: .word 0x0000FFFF
_0216F99C: .word aSbLogoFixBac
	arm_func_end SailHUDReadyText__Create

	arm_func_start SailHUDGoText__Create
SailHUDGoText__Create: // 0x0216F9A0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r0, _0216FA44 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x29
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	ldr r3, _0216FA48 // =0x0000FFFF
	ldr r2, _0216FA4C // =aSbLogoFixBac
	stmia sp, {r3, r5}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimation
	ldr r3, [r4, #0x134]
	mov r2, #0x1000
	ldr r0, [r3, #0xf4]
	mov r1, #0x80000
	bic r0, r0, #0x3f000000
	orr r0, r0, #0x28000000
	str r0, [r3, #0xf4]
	ldr r3, [r4, #0x20]
	mov r0, #0x40000
	orr r3, r3, #0x20000
	str r3, [r4, #0x20]
	str r2, [r4, #0x38]
	str r2, [r4, #0x3c]
	str r2, [r4, #0x40]
	str r1, [r4, #0x44]
	str r0, [r4, #0x48]
	mov r0, r4
	bl SailHUDReadyGoText__Func_216FB90
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216FA44: .word 0x00001010
_0216FA48: .word 0x0000FFFF
_0216FA4C: .word aSbLogoFixBac
	arm_func_end SailHUDGoText__Create

	arm_func_start SailHUDReadyText__SetupObject
SailHUDReadyText__SetupObject: // 0x0216FA50
	mov r1, #0x48
	str r1, [r0, #0x2c]
	mov r2, #0x14
	ldr r1, _0216FA98 // =SailHUDReadyText__State_216FA9C
	str r2, [r0, #0x28]
	str r1, [r0, #0xf4]
	mov r1, #0x80000
	str r1, [r0, #0x44]
	mov r1, #0x50000
	str r1, [r0, #0x48]
	ldr r2, [r0, #0x20]
	mov r1, #0
	orr r2, r2, #0x20
	str r2, [r0, #0x20]
	str r1, [r0, #0x3c]
	mov r1, #0x2000
	str r1, [r0, #0x38]
	bx lr
	.align 2, 0
_0216FA98: .word SailHUDReadyText__State_216FA9C
	arm_func_end SailHUDReadyText__SetupObject

	arm_func_start SailHUDReadyText__State_216FA9C
SailHUDReadyText__State_216FA9C: // 0x0216FA9C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x2c]
	bne _0216FB0C
	ldr r0, [r4, #0x20]
	mov r2, #0
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	str r2, [sp]
	mov r0, #0x400
	str r0, [sp, #4]
	ldr r0, [r4, #0x3c]
	mov r1, #0x1000
	mov r3, #1
	bl ObjDiffSet
	str r0, [r4, #0x3c]
	mov r0, #0x800
	str r0, [sp]
	ldr r0, [r4, #0x38]
	mov r1, #0x1000
	mov r2, #1
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #0x38]
_0216FB0C:
	ldr r0, [r4, #0x3c]
	cmp r0, #0x1000
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x28]
	cmp r0, #0
	subne r0, r0, #1
	addne sp, sp, #8
	strne r0, [r4, #0x28]
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0x134]
	ldr r1, [r2, #0xf4]
	mov r0, r1, lsl #0xb
	mov r0, r0, lsr #0x1b
	sub r0, r0, #2
	bic r1, r1, #0x1f0000
	mov r0, r0, lsl #0x1b
	orr r0, r1, r0, lsr #11
	str r0, [r2, #0xf4]
	ldr r2, [r4, #0x134]
	ldr r0, [r2, #0xf4]
	mov r1, r0, lsl #0xb
	mov r1, r1, lsr #0x1b
	cmp r1, #2
	addhs sp, sp, #8
	ldmhsia sp!, {r4, pc}
	bic r0, r0, #0x1f0000
	orr r1, r0, #0x1f0000
	mov r0, r4
	str r1, [r2, #0xf4]
	bl SailHUDReadyGoText__Func_216FB90
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end SailHUDReadyText__State_216FA9C

	arm_func_start SailHUDReadyGoText__Func_216FB90
SailHUDReadyGoText__Func_216FB90: // 0x0216FB90
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r1, [r0, #0x24]
	mov r2, #0x1000
	bic r1, r1, #1
	bic r1, r1, #0x800
	str r1, [r0, #0x24]
	ldr ip, [r4, #0x134]
	mov r1, #0x10
	ldr r3, [ip, #0xf4]
	mov r0, #0
	bic r3, r3, #0x1f0000
	orr r3, r3, #0x1f0000
	str r3, [ip, #0xf4]
	str r2, [r4, #0x38]
	str r2, [r4, #0x3c]
	str r1, [r4, #0x2c]
	str r0, [r4, #0x28]
	ldr r2, _0216FC0C // =SailHUDReadyGoText__State_216FC10
	mov r0, r4
	mov r1, #1
	str r2, [r4, #0xf4]
	bl StageTask__SetAnimation
	mov r0, #0x8000
	str r0, [r4, #4]
	mov r0, #0xe00
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FC0C: .word SailHUDReadyGoText__State_216FC10
	arm_func_end SailHUDReadyGoText__Func_216FB90

	arm_func_start SailHUDReadyGoText__State_216FC10
SailHUDReadyGoText__State_216FC10: // 0x0216FC10
	ldr r1, [r0, #0x2c]
	cmp r1, #0
	beq _0216FC7C
	cmp r1, #0xe
	beq _0216FC5C
	cmp r1, #0xf
	beq _0216FC48
	cmp r1, #0x10
	bne _0216FC6C
	mov r1, #0x1400
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x40]
	b _0216FC6C
_0216FC48:
	mov r1, #0x1200
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x40]
	b _0216FC6C
_0216FC5C:
	mov r1, #0x1000
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x40]
_0216FC6C:
	ldr r1, [r0, #0x2c]
	sub r1, r1, #1
	str r1, [r0, #0x2c]
	bx lr
_0216FC7C:
	ldr ip, [r0, #0x134]
	ldr r2, [ip, #0xf4]
	mov r1, r2, lsl #0xb
	mov r1, r1, lsr #0x1b
	sub r1, r1, #3
	bic r3, r2, #0x1f0000
	mov r2, r1, lsl #0x1b
	orr r2, r3, r2, lsr #11
	str r2, [ip, #0xf4]
	cmp r1, #1
	bxge lr
	ldr r1, [r0, #0x18]
	orr r1, r1, #4
	str r1, [r0, #0x18]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	bx lr
	arm_func_end SailHUDReadyGoText__State_216FC10

	arm_func_start SailClearedEvent__Destructor
SailClearedEvent__Destructor: // 0x0216FCC4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	mov r4, r0
	mov r0, r5
	bl GetTaskWork_
	ldr r0, [r0, #0x24]
	tst r0, #4
	ldreq r0, [r4, #0x24]
	biceq r0, r0, #1
	streq r0, [r4, #0x24]
	mov r0, r5
	bl StageTask_Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailClearedEvent__Destructor

	arm_func_start CreateSailHUDClearText
CreateSailHUDClearText: // 0x0216FCFC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r2, _0216FD7C // =SailHUDClearText__State_216FE64
	mov r1, #0
	str r2, [r4, #0xf4]
	str r1, [r4, #0x2c]
	mov r1, #1
	str r1, [r4, #0x28]
	ldr r0, [r0, #0x24]
	tst r0, #0x4000
	bne _0216FD38
	mov r0, r4
	mov r1, #2
	bl SailHUDFinishText__Create
_0216FD38:
	mov r0, r4
	bl SailHUDClearScoreText__Create
	bl SailManager__GetShipType
	cmp r0, #0
	bne _0216FD54
	mov r0, r4
	bl SailHUDClearTimeText__Create
_0216FD54:
	mov r0, r4
	mov r1, #0
	bl SailHUDClearTextBackdrop__Create
	mov r0, r4
	mov r1, #1
	bl SailHUDClearTextBackdrop__Create
	mov r0, r4
	mov r1, #2
	bl SailHUDClearTextBackdrop__Create
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FD7C: .word SailHUDClearText__State_216FE64
	arm_func_end CreateSailHUDClearText

	arm_func_start SailHUDClearText__Func_216FD80
SailHUDClearText__Func_216FD80: // 0x0216FD80
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x24]
	tst r0, #2
	beq _0216FDAC
	ldr r0, [r4, #0x138]
	bl SailAudio__FadeSequence
	ldr r0, [r4, #0x24]
	bic r0, r0, #2
	str r0, [r4, #0x24]
_0216FDAC:
	ldr r0, [r4, #0x24]
	tst r0, #0x20
	bne _0216FDF4
	ldr r0, _0216FE5C // =defaultTrackPlayer
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	sub r1, r0, #1
	mov ip, #6
	mov r2, r1
	mov r3, r1
	str ip, [sp]
	bl PlayTrack
	mov r0, #0x47
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x24]
	orr r0, r0, #0x20
	str r0, [r4, #0x24]
_0216FDF4:
	ldr r0, [r4, #0x24]
	tst r0, #8
	beq _0216FE30
	ldr r0, _0216FE60 // =saveGame
	mov r1, #0x20
	bl SaveGame__SaveData
	cmp r0, #2
	bne _0216FE24
	bl SailManager__GetWork
	ldr r1, [r0, #0x24]
	orr r1, r1, #0x800000
	str r1, [r0, #0x24]
_0216FE24:
	ldr r0, [r4, #0x24]
	bic r0, r0, #8
	str r0, [r4, #0x24]
_0216FE30:
	ldr r0, [r4, #0x24]
	tst r0, #0x10
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, pc}
	mov r0, r4
	bl SailHUDNewRecordIcon__Create
	ldr r0, [r4, #0x24]
	bic r0, r0, #0x10
	str r0, [r4, #0x24]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216FE5C: .word defaultTrackPlayer
_0216FE60: .word saveGame
	arm_func_end SailHUDClearText__Func_216FD80

	arm_func_start SailHUDClearText__State_216FE64
SailHUDClearText__State_216FE64: // 0x0216FE64
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	ldr r1, [r5, #0x2c]
	mov r4, r0
	add r1, r1, #1
	str r1, [r5, #0x2c]
	cmp r1, #4
	ldmleia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x24]
	tst r0, #0x20
	cmpeq r1, #0x46
	bne _0216FEB4
	ldr r0, [r5, #0x138]
	mov r1, #0x66
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	ldr r0, [r5, #0x24]
	orr r0, r0, #2
	str r0, [r5, #0x24]
_0216FEB4:
	ldr r0, [r5, #0x2c]
	cmp r0, #0x46
	movgt r0, #0x47
	strgt r0, [r5, #0x2c]
	ldr r0, _0216FF38 // =padInput
	ldrh r0, [r0, #4]
	cmp r0, #0
	bne _0216FEF0
	ldr r0, _0216FF3C // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	bne _0216FEF0
	ldr r0, [r4, #0x24]
	tst r0, #0x800000
	beq _0216FF18
_0216FEF0:
	ldr r0, [r5, #0x28]
	cmp r0, #0
	mov r0, r5
	bne _0216FF08
	bl SailHUDClearText__Func_216FF90
	ldmia sp!, {r3, r4, r5, pc}
_0216FF08:
	bl SailHUDClearText__Func_216FD80
	ldr r0, [r5, #0x24]
	orr r0, r0, #1
	str r0, [r5, #0x24]
_0216FF18:
	ldr r0, [r5, #0x28]
	cmp r0, #0
	movne r0, #0
	strne r0, [r5, #0x28]
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl SailHUDClearText__Func_216FD80
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216FF38: .word padInput
_0216FF3C: .word touchInput
	arm_func_end SailHUDClearText__State_216FE64

	arm_func_start SailHUDClearText__Func_216FF40
SailHUDClearText__Func_216FF40: // 0x0216FF40
	ldr r2, [r0, #0x11c]
	cmp r2, #0
	bxeq lr
	ldr r1, [r2, #0xf4]
	ldr r0, _0216FF68 // =SailHUDClearText__State_216FE64
	cmp r1, r0
	ldreq r0, [r2, #0x28]
	addeq r0, r0, #1
	streq r0, [r2, #0x28]
	bx lr
	.align 2, 0
_0216FF68: .word SailHUDClearText__State_216FE64
	arm_func_end SailHUDClearText__Func_216FF40

	arm_func_start SailHUDClearText__Func_216FF6C
SailHUDClearText__Func_216FF6C: // 0x0216FF6C
	ldr r0, [r0, #0x11c]
	cmp r0, #0
	beq _0216FF88
	ldr r0, [r0, #0x24]
	tst r0, #1
	movne r0, #1
	bxne lr
_0216FF88:
	mov r0, #0
	bx lr
	arm_func_end SailHUDClearText__Func_216FF6C

	arm_func_start SailHUDClearText__Func_216FF90
SailHUDClearText__Func_216FF90: // 0x0216FF90
	ldr r2, _0216FFA4 // =SailHUDClearText__State_216FFA8
	mov r1, #0x18
	str r2, [r0, #0xf4]
	str r1, [r0, #0x2c]
	bx lr
	.align 2, 0
_0216FFA4: .word SailHUDClearText__State_216FFA8
	arm_func_end SailHUDClearText__Func_216FF90

	arm_func_start SailHUDClearText__State_216FFA8
SailHUDClearText__State_216FFA8: // 0x0216FFA8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	ldr r1, [r5, #0x2c]
	mov r4, r0
	subs r0, r1, #1
	str r0, [r5, #0x2c]
	ldr r1, _0217008C // =gameState
	bmi _0216FFEC
	ldr r0, _02170090 // =padInput
	ldrh r0, [r0, #4]
	cmp r0, #0
	bne _0216FFEC
	ldr r0, _02170094 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	ldmeqia sp!, {r3, r4, r5, pc}
_0216FFEC:
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldr r2, [r4, #0xc]
	cmp r2, #0
	bne _02170024
	ldrh r0, [r4, #0x12]
	cmp r0, #1
	bhi _02170024
	bl SailArriveMessage__Create
	ldr r0, [r5, #0x24]
	orr r0, r0, #4
	str r0, [r5, #0x24]
	ldmia sp!, {r3, r4, r5, pc}
_02170024:
	ldr r0, [r4, #0x24]
	tst r0, #0x800000
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r0, [r4, #0x12]
	cmp r0, #6
	bne _02170048
	ldr r0, [r1, #0x7c]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
_02170048:
	cmp r2, #0
	beq _0217006C
	ldrb r1, [r1, #0x150]
	cmp r1, #6
	bhi _0217006C
	ldr r0, _02170098 // =saveGame+0x000001D0
	bl SaveGame__HasChaosEmerald
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
_0217006C:
	ldrh r0, [r4, #0x12]
	cmp r0, #6
	ldmeqia sp!, {r3, r4, r5, pc}
	bl SailArriveMessageOptionFail__Create
	ldr r0, [r5, #0x24]
	orr r0, r0, #4
	str r0, [r5, #0x24]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217008C: .word gameState
_02170090: .word padInput
_02170094: .word touchInput
_02170098: .word saveGame+0x000001D0
	arm_func_end SailHUDClearText__State_216FFA8

	arm_func_start SailHUDClearScoreText__Create
SailHUDClearScoreText__Create: // 0x0217009C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	ldr r0, _02170144 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x2d
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	ldr r3, _02170148 // =0x0000FFFF
	ldr r2, _0217014C // =aSbFixClearBac
	stmia sp, {r3, r5}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimation
	ldr ip, [r4, #0x134]
	mov r3, #0x1000
	ldr r2, [ip, #0xf4]
	mov r1, r6
	bic r2, r2, #0x3f000000
	orr r2, r2, #0x28000000
	str r2, [ip, #0xf4]
	ldr ip, [r4, #0x20]
	mov r0, r4
	orr ip, ip, #0x20000
	str ip, [r4, #0x20]
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	mov r2, #0
	str r3, [r4, #0x40]
	bl StageTask__SetParent
	mov r0, r4
	bl SailHUDClearText__Func_2170150
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02170144: .word 0x00001010
_02170148: .word 0x0000FFFF
_0217014C: .word aSbFixClearBac
	arm_func_end SailHUDClearScoreText__Create

	arm_func_start SailHUDClearText__Func_2170150
SailHUDClearText__Func_2170150: // 0x02170150
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0x30
	ldr r0, _0217018C // =SailHUDClearText__State_2170190
	str r1, [r4, #0x2c]
	str r0, [r4, #0xf4]
	mov r0, #0x168000
	str r0, [r4, #0x44]
	mov r0, #0x20000
	str r0, [r4, #0x48]
	bl SailManager__GetShipType
	cmp r0, #0
	moveq r0, #0x38000
	streq r0, [r4, #0x48]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217018C: .word SailHUDClearText__State_2170190
	arm_func_end SailHUDClearText__Func_2170150

	arm_func_start SailHUDClearText__State_2170190
SailHUDClearText__State_2170190: // 0x02170190
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	bl SailHUDClearText__Func_216FF40
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x2c]
	bne _021701D4
	mov r0, #0x800
	str r0, [sp]
	ldr r0, [r4, #0x44]
	mov r1, #0x80000
	mov r2, #2
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #0x44]
_021701D4:
	mov r0, r4
	bl SailHUDClearText__Func_216FF6C
	cmp r0, #0
	movne r0, #0x80000
	strne r0, [r4, #0x44]
	ldr r0, [r4, #0x44]
	cmp r0, #0x80000
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, pc}
	mov r0, r4
	bl SailHUDClearText__Func_2170208
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end SailHUDClearText__State_2170190

	arm_func_start SailHUDClearText__Func_2170208
SailHUDClearText__Func_2170208: // 0x02170208
	ldr r2, _0217021C // =SailHUDClearText__State_2170220
	mov r1, #0
	str r2, [r0, #0xf4]
	str r1, [r0, #0x28]
	bx lr
	.align 2, 0
_0217021C: .word SailHUDClearText__State_2170220
	arm_func_end SailHUDClearText__Func_2170208

	arm_func_start SailHUDClearText__State_2170220
SailHUDClearText__State_2170220: // 0x02170220
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	mov r5, #0
	cmp r0, #0
	ldrne r5, [r0, #0x124]
	cmp r5, #0
	beq _02170290
	ldr r1, [r4, #0x28]
	ldr r0, [r5, #0x1a8]
	cmp r1, r0
	beq _02170260
	mov r0, r4
	bl SailHUDClearText__Func_216FF40
_02170260:
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x28]
	ldr r1, [r5, #0x1a8]
	mov r2, #4
	bl ObjShiftSet
	str r0, [r4, #0x28]
	mov r0, r4
	bl SailHUDClearText__Func_216FF6C
	cmp r0, #0
	ldrne r0, [r5, #0x1a8]
	strne r0, [r4, #0x28]
_02170290:
	ldr r1, [r4, #0x28]
	ldr r2, _0217033C // =0x05F5E100
	add r0, sp, #4
	bl SailHUD__GetScore
	ldr r0, [sp, #4]
	mov r5, #7
	mov r3, #0x1c
	mov r2, #0xf
_021702B0:
	tst r0, r2, lsl r3
	bne _021702D0
	sub r1, r5, #1
	mov r1, r1, lsl #0x10
	mov r5, r1, asr #0x10
	cmp r5, #0
	sub r3, r3, #4
	bgt _021702B0
_021702D0:
	mov r3, #0
	str r3, [sp]
	ldr r1, [r4, #0x48]
	ldr ip, [r4, #0x44]
	add r2, r5, r5, lsl #2
	add r2, r2, ip, asr #12
	mov r1, r1, asr #0xc
	sub ip, r2, #6
	add r2, r1, #0xc
	mov r1, ip, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	bl SailHUD__Func_2174A94
	ldr r0, [r4, #0x11c]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r0, #0xf4]
	ldr r0, _02170340 // =SailHUDClearText__State_216FFA8
	cmp r1, r0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl SailHUDClearText__Func_2170344
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217033C: .word 0x05F5E100
_02170340: .word SailHUDClearText__State_216FFA8
	arm_func_end SailHUDClearText__State_2170220

	arm_func_start SailHUDClearText__Func_2170344
SailHUDClearText__Func_2170344: // 0x02170344
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	mov r1, #0
	cmp r0, #0
	ldrne r1, [r0, #0x124]
	cmp r1, #0
	beq _02170378
	ldr r1, [r1, #0x1a8]
	ldr r2, _0217038C // =0x05F5E100
	add r0, r4, #0x28
	bl SailHUD__GetScore
_02170378:
	mov r1, #0x20
	ldr r0, _02170390 // =SailHUDClearText__State_2170394
	str r1, [r4, #0x2c]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217038C: .word 0x05F5E100
_02170390: .word SailHUDClearText__State_2170394
	arm_func_end SailHUDClearText__Func_2170344

	arm_func_start SailHUDClearText__State_2170394
SailHUDClearText__State_2170394: // 0x02170394
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r2, #0
	str r2, [sp]
	mov r1, #0x1000
	str r1, [sp, #4]
	mov r4, r0
	ldr r0, [r4, #0x44]
	sub r1, r1, #0x61000
	mov r2, #0x80000
	mov r3, #1
	bl ObjDiffSet
	str r0, [r4, #0x44]
	ldr r0, [r4, #0x28]
	mov lr, #7
	mov r2, #0xf
_021703D4:
	mov r1, lr, lsl #2
	tst r0, r2, lsl r1
	bne _021703F0
	sub r1, lr, #1
	mov r1, r1, lsl #0x10
	movs lr, r1, lsr #0x10
	bne _021703D4
_021703F0:
	cmp lr, #0
	subeq r1, lr, #1
	mov r3, #0
	moveq r1, r1, lsl #0x10
	str r3, [sp]
	moveq lr, r1, lsr #0x10
	ldr r1, [r4, #0x48]
	ldr ip, [r4, #0x44]
	add r2, lr, lr, lsl #2
	add r2, r2, ip, asr #12
	mov r1, r1, asr #0xc
	sub ip, r2, #6
	add r2, r1, #0xc
	mov r1, ip, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	bl SailHUD__Func_2174A94
	mov r0, #0x60000
	ldr r1, [r4, #0x44]
	rsb r0, r0, #0
	cmp r1, r0
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #4
	streq r0, [r4, #0x18]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end SailHUDClearText__State_2170394

	arm_func_start SailHUDClearTimeText__Create
SailHUDClearTimeText__Create: // 0x0217045C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	ldr r0, _02170504 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x2d
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	ldr r3, _02170508 // =0x0000FFFF
	ldr r2, _0217050C // =aSbFixClearBac
	stmia sp, {r3, r5}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr ip, [r4, #0x134]
	mov r3, #0x1000
	ldr r2, [ip, #0xf4]
	mov r1, r6
	bic r2, r2, #0x3f000000
	orr r2, r2, #0x28000000
	str r2, [ip, #0xf4]
	ldr ip, [r4, #0x20]
	mov r0, r4
	orr ip, ip, #0x20000
	str ip, [r4, #0x20]
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	mov r2, #0
	str r3, [r4, #0x40]
	bl StageTask__SetParent
	mov r0, r4
	bl SailHUDClearText2__Func_2170510
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02170504: .word 0x00001010
_02170508: .word 0x0000FFFF
_0217050C: .word aSbFixClearBac
	arm_func_end SailHUDClearTimeText__Create

	arm_func_start SailHUDClearText2__Func_2170510
SailHUDClearText2__Func_2170510: // 0x02170510
	mov r2, #0x28
	ldr r1, _02170534 // =SailHUDClearText2__State_2170538
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	mov r1, #0x168000
	str r1, [r0, #0x44]
	mov r1, #0x10000
	str r1, [r0, #0x48]
	bx lr
	.align 2, 0
_02170534: .word SailHUDClearText2__State_2170538
	arm_func_end SailHUDClearText2__Func_2170510

	arm_func_start SailHUDClearText2__State_2170538
SailHUDClearText2__State_2170538: // 0x02170538
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	bl SailHUDClearText__Func_216FF40
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x2c]
	bne _0217057C
	mov r0, #0x800
	str r0, [sp]
	ldr r0, [r4, #0x44]
	mov r1, #0x80000
	mov r2, #2
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #0x44]
_0217057C:
	mov r0, r4
	bl SailHUDClearText__Func_216FF6C
	cmp r0, #0
	movne r0, #0x80000
	strne r0, [r4, #0x44]
	ldr r0, [r4, #0x44]
	cmp r0, #0x80000
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, pc}
	mov r0, r4
	bl SailHUDClearText2__Func_21705B0
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end SailHUDClearText2__State_2170538

	arm_func_start SailHUDClearText2__Func_21705B0
SailHUDClearText2__Func_21705B0: // 0x021705B0
	ldr r2, _021705C4 // =SailHUDClearText2__State_21705C8
	mov r1, #0
	str r2, [r0, #0xf4]
	str r1, [r0, #0x28]
	bx lr
	.align 2, 0
_021705C4: .word SailHUDClearText2__State_21705C8
	arm_func_end SailHUDClearText2__Func_21705B0

	arm_func_start SailHUDClearText2__State_21705C8
SailHUDClearText2__State_21705C8: // 0x021705C8
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	bl SailManager__GetWork
	mov r5, r0
	ldr r1, [r4, #0x28]
	ldr r0, [r5, #0x20]
	cmp r1, r0
	beq _021705F4
	mov r0, r4
	bl SailHUDClearText__Func_216FF40
_021705F4:
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x28]
	ldr r1, [r5, #0x20]
	mov r2, #4
	bl ObjShiftSet
	str r0, [r4, #0x28]
	mov r0, r4
	bl SailHUDClearText__Func_216FF6C
	cmp r0, #0
	ldrne r0, [r5, #0x20]
	strne r0, [r4, #0x28]
	ldr r1, [r4, #0x28]
	add r0, sp, #4
	bl MultibootManager__Func_2063CF4
	mov r0, #4
	str r0, [sp]
	ldr r1, [r4, #0x44]
	ldr r0, [r4, #0x48]
	mov r1, r1, asr #0xc
	mov r0, r0, asr #0xc
	add r1, r1, #0x14
	add r0, r0, #0xc
	mov r2, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	ldr r0, [sp, #4]
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, #5
	bl SailHUD__Func_2174A94
	ldr r0, [r4, #0x11c]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r0, #0xf4]
	ldr r0, _021706A0 // =SailHUDClearText__State_216FFA8
	cmp r1, r0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl SailHUDClearText2__Func_21706A4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021706A0: .word SailHUDClearText__State_216FFA8
	arm_func_end SailHUDClearText2__State_21705C8

	arm_func_start SailHUDClearText2__Func_21706A4
SailHUDClearText2__Func_21706A4: // 0x021706A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r1, [r0, #0x20]
	add r0, r4, #0x28
	bl MultibootManager__Func_2063CF4
	mov r1, #2
	ldr r0, _021706D0 // =SailHUDClearText2__State_21706D4
	str r1, [r4, #0x2c]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021706D0: .word SailHUDClearText2__State_21706D4
	arm_func_end SailHUDClearText2__Func_21706A4

	arm_func_start SailHUDClearText2__State_21706D4
SailHUDClearText2__State_21706D4: // 0x021706D4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x2c]
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	bpl _02170714
	mov r0, #0
	mov r1, #0x1000
	stmia sp, {r0, r1}
	ldr r0, [r4, #0x44]
	sub r1, r1, #0x61000
	mov r2, #0x80000
	mov r3, #1
	bl ObjDiffSet
	str r0, [r4, #0x44]
_02170714:
	mov r0, #4
	str r0, [sp]
	ldr r1, [r4, #0x44]
	ldr r0, [r4, #0x48]
	mov r1, r1, asr #0xc
	mov r0, r0, asr #0xc
	add r1, r1, #0x14
	add r0, r0, #0xc
	mov r2, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	ldr r0, [r4, #0x28]
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, #5
	bl SailHUD__Func_2174A94
	mov r0, #0x60000
	ldr r1, [r4, #0x44]
	rsb r0, r0, #0
	cmp r1, r0
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #4
	streq r0, [r4, #0x18]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end SailHUDClearText2__State_21706D4

	arm_func_start SailHUDClearTextBackdrop__Create
SailHUDClearTextBackdrop__Create: // 0x02170774
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	mov r5, r1
	ldr r0, _02170830 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x2d
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _02170834 // =0x0000FFFF
	ldr r2, _02170838 // =aSbFixClearBac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimation
	ldr ip, [r4, #0x134]
	mov r3, #0x1000
	ldr r2, [ip, #0xf4]
	mov r1, r7
	bic r2, r2, #0x3f000000
	orr r2, r2, #0x28000000
	str r2, [ip, #0xf4]
	ldr ip, [r4, #0x20]
	mov r0, r4
	orr ip, ip, #0x20000
	str ip, [r4, #0x20]
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	str r3, [r4, #0x40]
	mov r2, #0
	str r5, [r4, #0x28]
	bl StageTask__SetParent
	mov r1, r5
	mov r0, r4
	bl SailHUDClearScoreBonus__Create
	mov r0, r4
	bl SailHUDClearTextBackdrop__SetupObject
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02170830: .word 0x00001010
_02170834: .word 0x0000FFFF
_02170838: .word aSbFixClearBac
	arm_func_end SailHUDClearTextBackdrop__Create

	arm_func_start SailHUDClearTextBackdrop__SetupObject
SailHUDClearTextBackdrop__SetupObject: // 0x0217083C
	mov r2, #0x38
	str r2, [r0, #0x2c]
	ldr r1, [r0, #0x28]
	mov r3, #0x70000
	add r2, r2, r1, lsl #3
	ldr r1, _0217087C // =SailHUDClearTextBackdrop__State_2170880
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	mov r1, #0x168000
	str r1, [r0, #0x44]
	str r3, [r0, #0x48]
	ldr r2, [r0, #0x28]
	mov r1, #0x18000
	mla r1, r2, r1, r3
	str r1, [r0, #0x48]
	bx lr
	.align 2, 0
_0217087C: .word SailHUDClearTextBackdrop__State_2170880
	arm_func_end SailHUDClearTextBackdrop__SetupObject

	arm_func_start SailHUDClearTextBackdrop__State_2170880
SailHUDClearTextBackdrop__State_2170880: // 0x02170880
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	bl SailHUDClearText__Func_216FF40
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x2c]
	bne _021708C4
	mov r0, #0x800
	str r0, [sp]
	ldr r0, [r4, #0x44]
	mov r1, #0x80000
	mov r2, #2
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #0x44]
_021708C4:
	mov r0, r4
	bl SailHUDClearText__Func_216FF6C
	cmp r0, #0
	movne r0, #0x80000
	strne r0, [r4, #0x44]
	ldr r0, [r4, #0x44]
	cmp r0, #0x80000
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, pc}
	mov r0, r4
	bl SailHUDClearTextBackdrop__Func_21708F8
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end SailHUDClearTextBackdrop__State_2170880

	arm_func_start SailHUDClearTextBackdrop__Func_21708F8
SailHUDClearTextBackdrop__Func_21708F8: // 0x021708F8
	ldr r2, _0217090C // =SailHUDClearTextBackdrop__State_2170910
	mov r1, #0
	str r2, [r0, #0xf4]
	str r1, [r0, #0x2c]
	bx lr
	.align 2, 0
_0217090C: .word SailHUDClearTextBackdrop__State_2170910
	arm_func_end SailHUDClearTextBackdrop__Func_21708F8

	arm_func_start SailHUDClearTextBackdrop__State_2170910
SailHUDClearTextBackdrop__State_2170910: // 0x02170910
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	mov r1, #0
	cmp r0, #0
	ldrne r1, [r0, #0x124]
	cmp r1, #0
	beq _021709A8
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _0217095C
	cmp r0, #1
	beq _02170964
	cmp r0, #2
	addeq r0, r1, #0x100
	ldreqh r5, [r0, #0xc6]
	b _02170968
_0217095C:
	ldr r5, [r1, #0x1a4]
	b _02170968
_02170964:
	ldr r5, [r1, #0x1ac]
_02170968:
	ldr r0, [r4, #0x2c]
	cmp r0, r5
	beq _0217097C
	mov r0, r4
	bl SailHUDClearText__Func_216FF40
_0217097C:
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x2c]
	mov r1, r5
	mov r2, #4
	bl ObjShiftSet
	str r0, [r4, #0x2c]
	mov r0, r4
	bl SailHUDClearText__Func_216FF6C
	cmp r0, #0
	strne r5, [r4, #0x2c]
_021709A8:
	ldr r1, [r4, #0x2c]
	ldr r2, _02170A24 // =0x00002710
	add r0, sp, #4
	bl SailHUD__GetScore
	mov r3, #0
	str r3, [sp]
	ldr r1, [r4, #0x44]
	ldr r0, [r4, #0x48]
	mov r1, r1, asr #0xc
	mov r0, r0, asr #0xc
	add r1, r1, #0x3b
	sub r0, r0, #9
	mov r2, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	ldr r0, [sp, #4]
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	bl SailHUD__Func_2174A94
	ldr r0, [r4, #0x11c]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r0, #0xf4]
	ldr r0, _02170A28 // =SailHUDClearText__State_216FFA8
	cmp r1, r0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl SailHUDClearTextBackdrop__Func_2170A2C
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02170A24: .word 0x00002710
_02170A28: .word SailHUDClearText__State_216FFA8
	arm_func_end SailHUDClearTextBackdrop__State_2170910

	arm_func_start SailHUDClearTextBackdrop__Func_2170A2C
SailHUDClearTextBackdrop__Func_2170A2C: // 0x02170A2C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	ldr r2, [r0, #0x70]
	mov r1, #4
	str r1, [r5, #0x2c]
	ldr r0, [r5, #0x28]
	cmp r2, #0
	add r0, r1, r0, lsl #1
	str r0, [r5, #0x2c]
	mov r1, #0
	ldrne r1, [r2, #0x124]
	cmp r1, #0
	beq _02170AA4
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _02170A88
	cmp r0, #1
	beq _02170A90
	cmp r0, #2
	addeq r0, r1, #0x100
	ldreqh r4, [r0, #0xc6]
	b _02170A94
_02170A88:
	ldr r4, [r1, #0x1a4]
	b _02170A94
_02170A90:
	ldr r4, [r1, #0x1ac]
_02170A94:
	ldr r2, _02170AB0 // =0x00002710
	mov r1, r4
	add r0, r5, #0x28
	bl SailHUD__GetScore
_02170AA4:
	ldr r0, _02170AB4 // =SailHUDClearTextBackdrop__State_2170AB8
	str r0, [r5, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02170AB0: .word 0x00002710
_02170AB4: .word SailHUDClearTextBackdrop__State_2170AB8
	arm_func_end SailHUDClearTextBackdrop__Func_2170A2C

	arm_func_start SailHUDClearTextBackdrop__State_2170AB8
SailHUDClearTextBackdrop__State_2170AB8: // 0x02170AB8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x2c]
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	bpl _02170AF8
	mov r0, #0
	mov r1, #0x1000
	stmia sp, {r0, r1}
	ldr r0, [r4, #0x44]
	sub r1, r1, #0x61000
	mov r2, #0x80000
	mov r3, #1
	bl ObjDiffSet
	str r0, [r4, #0x44]
_02170AF8:
	mov r3, #0
	str r3, [sp]
	ldr r1, [r4, #0x44]
	ldr r0, [r4, #0x48]
	mov r1, r1, asr #0xc
	mov r0, r0, asr #0xc
	add r1, r1, #0x3b
	sub r0, r0, #9
	mov r2, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	ldr r0, [r4, #0x28]
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	bl SailHUD__Func_2174A94
	mov r0, #0x60000
	ldr r1, [r4, #0x44]
	rsb r0, r0, #0
	cmp r1, r0
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #4
	streq r0, [r4, #0x18]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end SailHUDClearTextBackdrop__State_2170AB8

	arm_func_start SailHUDClearScoreBonus__Create
SailHUDClearScoreBonus__Create: // 0x02170B54
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	mov r5, r1
	ldr r0, _02170C0C // =0x00001006
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x2d
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _02170C10 // =0x0000FFFF
	ldr r2, _02170C14 // =aSbFixClearBac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	add r1, r5, #3
	mov r1, r1, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr ip, [r4, #0x134]
	mov r3, #0x1000
	ldr r2, [ip, #0xf4]
	mov r1, r7
	bic r2, r2, #0x3f000000
	orr r2, r2, #0x28000000
	str r2, [ip, #0xf4]
	ldr ip, [r4, #0x20]
	mov r0, r4
	orr ip, ip, #0x20000
	str ip, [r4, #0x20]
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	str r3, [r4, #0x40]
	mov r2, #0
	str r5, [r4, #0x28]
	bl StageTask__SetParent
	mov r0, r4
	bl SailHUDClearScoreBonus__SetupObject
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02170C0C: .word 0x00001006
_02170C10: .word 0x0000FFFF
_02170C14: .word aSbFixClearBac
	arm_func_end SailHUDClearScoreBonus__Create

	arm_func_start SailHUDClearScoreBonus__SetupObject
SailHUDClearScoreBonus__SetupObject: // 0x02170C18
	ldr r1, _02170C58 // =SailHUDClearScoreBonus__State_2170C5C
	mov r3, #0x70000
	str r1, [r0, #0xf4]
	mov r1, #0x80000
	str r1, [r0, #0x44]
	str r3, [r0, #0x48]
	ldr r2, [r0, #0x28]
	mov r1, #0x18000
	mla r1, r2, r1, r3
	str r1, [r0, #0x48]
	ldr r2, [r0, #0x20]
	mov r1, #0
	orr r2, r2, #0x20
	str r2, [r0, #0x20]
	str r1, [r0, #0x3c]
	bx lr
	.align 2, 0
_02170C58: .word SailHUDClearScoreBonus__State_2170C5C
	arm_func_end SailHUDClearScoreBonus__SetupObject

	arm_func_start SailHUDClearScoreBonus__State_2170C5C
SailHUDClearScoreBonus__State_2170C5C: // 0x02170C5C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r4, [r5, #0x11c]
	ldr r0, _02170CFC // =SailHUDClearTextBackdrop__State_2170910
	ldr r1, [r4, #0x44]
	sub r1, r1, #0x48000
	str r1, [r5, #0x44]
	ldr r1, [r4, #0x48]
	sub r1, r1, #0x6000
	str r1, [r5, #0x48]
	ldr r1, [r4, #0xf4]
	cmp r1, r0
	ldreq r0, [r5, #0x20]
	biceq r0, r0, #0x20
	streq r0, [r5, #0x20]
	ldr r0, [r5, #0x20]
	tst r0, #0x20
	bne _02170CCC
	mov r2, #0
	str r2, [sp]
	mov r0, #0x400
	str r0, [sp, #4]
	ldr r0, [r5, #0x3c]
	mov r1, #0x1000
	mov r3, #1
	bl ObjDiffSet
	str r0, [r5, #0x3c]
_02170CCC:
	ldr r1, [r4, #0xf4]
	ldr r0, _02170D00 // =SailHUDClearTextBackdrop__State_2170AB8
	cmp r1, r0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [r5, #0x20]
	mov r0, #0x1000
	bic r1, r1, #0x20
	str r1, [r5, #0x20]
	str r0, [r5, #0x3c]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02170CFC: .word SailHUDClearTextBackdrop__State_2170910
_02170D00: .word SailHUDClearTextBackdrop__State_2170AB8
	arm_func_end SailHUDClearScoreBonus__State_2170C5C

	arm_func_start SailHUDFinishText__Create
SailHUDFinishText__Create: // 0x02170D04
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r7, r1
	bl SailManager__GetWork
	mov r4, r0
	ldr r0, _02170E84 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	ldrh r1, [r4, #0x12]
	mov r4, r0
	cmp r1, #1
	bne _02170D94
	mov r0, #0x2a
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02170E30
	ldr r0, _02170E88 // =aBbSbBb
	mov r1, #0x1b
	mov r2, #0
	bl ReadFileFromBundle
	mov r6, r0
	mov r0, #0x2a
	bl GetObjectFileWork
	str r6, [r0]
	mov r0, #0x2a
	bl GetObjectFileWork
	ldr r3, _02170E8C // =0x0000FFFF
	mov r1, #0
	str r3, [sp]
	stmib sp, {r0, r1}
	mov r0, r4
	mov r2, r1
	bl ObjObjectAction3dBACLoad
	b _02170E30
_02170D94:
	cmp r1, #6
	bne _02170DF8
	mov r0, #0x2b
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02170E30
	ldr r0, _02170E88 // =aBbSbBb
	mov r1, #0x1c
	mov r2, #0
	bl ReadFileFromBundle
	mov r6, r0
	mov r0, #0x2b
	bl GetObjectFileWork
	str r6, [r0]
	mov r0, #0x2b
	bl GetObjectFileWork
	ldr r3, _02170E8C // =0x0000FFFF
	mov r1, #0
	str r3, [sp]
	stmib sp, {r0, r1}
	mov r0, r4
	mov r2, r1
	bl ObjObjectAction3dBACLoad
	b _02170E30
_02170DF8:
	mov r0, #0x29
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _02170E8C // =0x0000FFFF
	ldr r2, _02170E90 // =aSbLogoFixBac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r0, r4
	mov r1, #0
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, r7
	bl StageTask__SetAnimation
_02170E30:
	ldr r2, [r4, #0x134]
	mov r3, #0x1000
	ldr r1, [r2, #0xf4]
	mov r0, r4
	bic r1, r1, #0x3f000000
	orr r1, r1, #0x28000000
	str r1, [r2, #0xf4]
	ldr r2, [r4, #0x20]
	mov r1, r5
	orr r2, r2, #0x20000
	str r2, [r4, #0x20]
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	mov r2, #0
	str r3, [r4, #0x40]
	bl StageTask__SetParent
	mov r0, r4
	bl SailHUDFinishText__SetupObject
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02170E84: .word 0x00001010
_02170E88: .word aBbSbBb
_02170E8C: .word 0x0000FFFF
_02170E90: .word aSbLogoFixBac
	arm_func_end SailHUDFinishText__Create

	arm_func_start SailHUDFinishText__SetupObject
SailHUDFinishText__SetupObject: // 0x02170E94
	mov r1, #1
	str r1, [r0, #0x2c]
	mov r2, #0x10
	ldr r1, _02170EDC // =SailHUDFinishText__State_2170EE0
	str r2, [r0, #0x28]
	str r1, [r0, #0xf4]
	mov r1, #0x80000
	str r1, [r0, #0x44]
	mov r1, #0x60000
	str r1, [r0, #0x48]
	ldr r2, [r0, #0x20]
	mov r1, #0
	orr r2, r2, #0x20
	str r2, [r0, #0x20]
	str r1, [r0, #0x3c]
	mov r1, #0x2000
	str r1, [r0, #0x38]
	bx lr
	.align 2, 0
_02170EDC: .word SailHUDFinishText__State_2170EE0
	arm_func_end SailHUDFinishText__SetupObject

	arm_func_start SailHUDFinishText__State_2170EE0
SailHUDFinishText__State_2170EE0: // 0x02170EE0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x2c]
	bne _02170F50
	ldr r0, [r4, #0x20]
	mov r2, #0
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	str r2, [sp]
	mov r0, #0x400
	str r0, [sp, #4]
	ldr r0, [r4, #0x3c]
	mov r1, #0x1000
	mov r3, #1
	bl ObjDiffSet
	str r0, [r4, #0x3c]
	mov r0, #0x800
	str r0, [sp]
	ldr r0, [r4, #0x38]
	mov r1, #0x1000
	mov r2, #1
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #0x38]
_02170F50:
	ldr r0, [r4, #0x3c]
	cmp r0, #0x1000
	bne _02170FC0
	ldr r0, [r4, #0x28]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x28]
	bne _02170FC0
	ldr r2, [r4, #0x134]
	ldr r1, [r2, #0xf4]
	mov r0, r1, lsl #0xb
	mov r0, r0, lsr #0x1b
	sub r0, r0, #2
	bic r1, r1, #0x1f0000
	mov r0, r0, lsl #0x1b
	orr r0, r1, r0, lsr #11
	str r0, [r2, #0xf4]
	ldr r0, [r4, #0x134]
	ldr r0, [r0, #0xf4]
	mov r0, r0, lsl #0xb
	mov r0, r0, lsr #0x1b
	cmp r0, #2
	bhs _02170FC0
	ldr r0, [r4, #0x18]
	add sp, sp, #8
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
_02170FC0:
	mov r0, r4
	bl SailHUDClearText__Func_216FF6C
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end SailHUDFinishText__State_2170EE0

	arm_func_start SailRetireEvent__Main
SailRetireEvent__Main: // 0x02170FE8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailManager__GetWork
	ldr r2, [r4, #0]
	ldr r1, _02171350 // =padInput
	add r2, r2, #1
	str r2, [r4]
	ldrh r2, [r1, #4]
	ldr r1, _02171354 // =0x00000C03
	mov r5, r0
	tst r2, r1
	ldr r6, _02171358 // =gameState
	bne _02171040
	ldr r0, _0217135C // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	bne _02171040
	ldr r0, [r5, #0x24]
	tst r0, #0x800000
	beq _02171050
_02171040:
	ldr r0, [r4, #0]
	cmp r0, #0x63
	movlt r0, #0x64
	strlt r0, [r4]
_02171050:
	ldr r0, [r4, #0]
	cmp r0, #0x64
	bne _0217107C
	ldr r0, [r4, #4]
	tst r0, #1
	beq _02171070
	bl SailArriveMessageOptionFail__Create
	b _0217107C
_02171070:
	mov r0, #5
	mov r1, #0x1000
	bl CreateDrawFadeTask
_0217107C:
	ldr r0, [r4, #4]
	tst r0, #1
	beq _021710B4
	ldr r0, [r4, #0]
	cmp r0, #0x64
	ble _021710B4
	ldr r0, [r5, #0x24]
	tst r0, #0x10
	movne r0, #0x64
	strne r0, [r4]
	bne _021710B4
	mov r0, #5
	mov r1, #0x1000
	bl CreateDrawFadeTask
_021710B4:
	ldr r0, [r4, #0]
	cmp r0, #0x78
	addle sp, sp, #8
	ldmleia sp!, {r4, r5, r6, pc}
	add r0, r5, #0x500
	ldrsh r0, [r0, #0xd0]
	ldr r2, _02171358 // =gameState
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _02171248
_021710DC: // jump table
	b _0217112C // case 0
	b _02171100 // case 1
	b _021711E0 // case 2
	b _02171188 // case 3
	b _02171248 // case 4
	b _02171238 // case 5
	b _02171238 // case 6
	b _02171248 // case 7
	b _02171238 // case 8
_02171100:
	mov r0, #0
	str r0, [r2, #0x14]
	ldr r1, [r5, #4]
	mov r0, #0xb
	str r1, [r2, #0x80]
	bl SaveGame__SetUnknown1
	bl MultibootManager__Func_2063C40
	mov r0, #0
	str r0, [r6, #0xb0]
	bl SeaMapManager__ClearGlobalNodeList
	b _02171248
_0217112C:
	mov r0, #0
	bl SaveGame__SetUnknown1
	ldrh r0, [r5, #0x12]
	cmp r0, #6
	bne _02171150
	ldr r0, _02171358 // =gameState
	mov r1, #5
	strb r1, [r0, #0xdc]
	b _02171174
_02171150:
	cmp r0, #2
	cmpne r0, #3
	beq _02171168
	ldr r0, [r5, #0x24]
	tst r0, #0x100000
	beq _02171174
_02171168:
	add r0, r5, #0x500
	mov r1, #8
	strh r1, [r0, #0xd0]
_02171174:
	bl MultibootManager__Func_2063C40
	mov r0, #0
	str r0, [r6, #0xb0]
	bl SeaMapManager__ClearGlobalNodeList
	b _02171248
_02171188:
	ldr r0, [r5, #0x24]
	tst r0, #0x8000
	bne _02171248
	tst r0, #0x20000
	bne _02171248
	ldr r0, [r5, #0xc]
	cmp r0, #0
	bne _021711C8
	mov r0, #1
	str r0, [r6, #0xa4]
	ldr r1, [r5, #8]
	mov r0, #6
	sub r1, r1, #0x39
	strh r1, [r6, #0xb4]
	bl SaveGame__SetUnknown1
	b _02171248
_021711C8:
	mov r1, #0
	mov r0, #7
	str r1, [r6, #0xa4]
	strh r1, [r6, #0xb4]
	bl SaveGame__SetUnknown1
	b _02171248
_021711E0:
	bl SailManager__GetWork
	ldr r4, [r0, #0x98]
	add r1, sp, #4
	ldr r0, [r4, #0x58]
	add r2, sp, #0
	sub r0, r0, #1
	bl SeaMapManager__Func_2045BF8
	ldr r2, [r6, #0xb0]
	ldr r1, [r4, #0x58]
	ldr r0, [sp, #4]
	add r2, r2, r1
	ldr r1, [sp]
	sub r2, r2, #1
	bl SeaMapUnknown204AB60__Func_204B4F0
	ldr r0, [r4, #0x58]
	ldr r1, [r6, #0xb0]
	ldr r4, [r6, #0xac]
	add r0, r1, r0
	str r0, [r6, #0xb0]
	bl MultibootManager__Func_2063C40
	str r4, [r6, #0xac]
	b _02171248
_02171238:
	bl MultibootManager__Func_2063C40
	mov r0, #0
	str r0, [r6, #0xb0]
	bl SeaMapManager__ClearGlobalNodeList
_02171248:
	ldrh r0, [r5, #0x12]
	cmp r0, #2
	cmpne r0, #3
	beq _02171294
	ldr r0, [r5, #0x24]
	tst r0, #0x100000
	bne _02171294
	tst r0, #0x200000
	bne _02171294
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	mov r1, #0
	cmp r0, #0
	ldrne r1, [r0, #0x124]
	cmp r1, #0
	beq _02171294
	ldr r1, [r1, #0x1a4]
	ldr r0, _02171360 // =saveGame+0x00000028
	bl SaveGame__GiveRings
_02171294:
	ldr r0, [r5, #0x24]
	tst r0, #0x800000
	beq _021712AC
	mov r0, #0x20
	bl RequestNewSysEventChange
	b _021712CC
_021712AC:
	add r0, r5, #0x500
	ldrsh r0, [r0, #0xd0]
	cmp r0, #8
	bne _021712C8
	mov r0, #0x2b
	bl RequestNewSysEventChange
	b _021712CC
_021712C8:
	bl RequestSysEventChange
_021712CC:
	bl NextSysEvent
	ldr r0, [r5, #0x24]
	tst r0, #0x40000
	bne _0217130C
	ldr r0, [r6, #0xbc]
	cmp r0, #0
	beq _021712F4
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r6, #0xbc]
_021712F4:
	ldr r0, [r6, #0xc0]
	cmp r0, #0
	beq _0217130C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r6, #0xc0]
_0217130C:
	mov r0, #5
	bl SetPadReplayState
	mov r0, #5
	bl SetTouchReplayState
	bl CheckSailExitEventHasMap
	cmp r0, #0
	beq _0217132C
	bl SailSeaMapView__Func_218B56C
_0217132C:
	mov r4, #0
_02171330:
	mov r0, r4
	bl DestroyTaskGroup
	add r0, r4, #1
	and r4, r0, #0xff
	cmp r4, #6
	blo _02171330
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02171350: .word padInput
_02171354: .word 0x00000C03
_02171358: .word gameState
_0217135C: .word touchInput
_02171360: .word saveGame+0x00000028
	arm_func_end SailRetireEvent__Main

	arm_func_start SailHUDRetireText__Create
SailHUDRetireText__Create: // 0x02171364
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	bl SailManager__GetWork
	mov r4, r0
	bl SailManager__GetWork
	ldr r0, _02171470 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	ldr r1, [r4, #0xc]
	mov r4, r0
	cmp r1, #0
	beq _021713F4
	mov r0, #0x71
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _021713C8
	ldr r0, _02171474 // =aBbSbBb
	mov r1, #0x1e
	mov r2, #0
	bl ReadFileFromBundle
	mov r5, r0
	mov r0, #0x71
	bl GetObjectFileWork
	str r5, [r0]
_021713C8:
	mov r0, #0x71
	bl GetObjectFileWork
	ldr r3, _02171478 // =0x0000FFFF
	mov r1, #0
	str r3, [sp]
	str r0, [sp, #4]
	mov r0, r4
	mov r2, r1
	str r1, [sp, #8]
	bl ObjObjectAction3dBACLoad
	b _0217142C
_021713F4:
	mov r0, #0x29
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	ldr r3, _02171478 // =0x0000FFFF
	ldr r2, _0217147C // =aSbLogoFixBac
	stmia sp, {r3, r5}
	str r0, [sp, #8]
	mov r0, r4
	mov r1, #0
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #3
	bl StageTask__SetAnimation
_0217142C:
	ldr r3, [r4, #0x134]
	mov r1, #0x1000
	ldr r2, [r3, #0xf4]
	mov r0, r4
	bic r2, r2, #0x3f000000
	orr r2, r2, #0x28000000
	str r2, [r3, #0xf4]
	ldr r2, [r4, #0x20]
	orr r2, r2, #0x20000
	str r2, [r4, #0x20]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	bl SailHUDRetireText__SetupObject
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02171470: .word 0x00001010
_02171474: .word aBbSbBb
_02171478: .word 0x0000FFFF
_0217147C: .word aSbLogoFixBac
	arm_func_end SailHUDRetireText__Create

	arm_func_start SailHUDRetireText__SetupObject
SailHUDRetireText__SetupObject: // 0x02171480
	mov r2, #0
	str r2, [r0, #0x2c]
	ldr r1, _021714C8 // =SailHUDRetireText__State_21714CC
	str r2, [r0, #0x28]
	str r1, [r0, #0xf4]
	mov r1, #0x80000
	str r1, [r0, #0x44]
	mov r1, #0x50000
	str r1, [r0, #0x48]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x134]
	ldr r0, [r1, #0xf4]
	bic r0, r0, #0x1f0000
	orr r0, r0, #0x10000
	str r0, [r1, #0xf4]
	bx lr
	.align 2, 0
_021714C8: .word SailHUDRetireText__State_21714CC
	arm_func_end SailHUDRetireText__SetupObject

	arm_func_start SailHUDRetireText__State_21714CC
SailHUDRetireText__State_21714CC: // 0x021714CC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r1, [r4, #0x2c]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r4, #0x2c]
	bne _02171540
	ldr r1, [r4, #0x20]
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	ldr r3, [r4, #0x134]
	ldr r2, [r3, #0xf4]
	mov r1, r2, lsl #0xb
	mov r1, r1, lsr #0x1b
	cmp r1, #0x1f
	bhs _02171540
	add r1, r1, #3
	bic r2, r2, #0x1f0000
	mov r1, r1, lsl #0x1b
	orr r1, r2, r1, lsr #11
	str r1, [r3, #0xf4]
	ldr r1, [r4, #0x134]
	ldr r1, [r1, #0xf4]
	mov r1, r1, lsl #0xb
	mov r1, r1, lsr #0x1b
	cmp r1, #0x1f
	moveq r1, #0x8000
	streq r1, [r4, #4]
_02171540:
	ldr r0, [r0, #0x24]
	tst r0, #0x10
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #4
	strne r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end SailHUDRetireText__State_21714CC

	arm_func_start SailHUDNewRecordIcon__Create
SailHUDNewRecordIcon__Create: // 0x02171558
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	bl SailManager__GetWork
	bl SailManager__GetWork
	ldr r0, _02171624 // =0x00001010
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x52
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _021715B0
	ldr r0, _02171628 // =aBbSbBb
	mov r1, #0x1d
	mov r2, #0
	bl ReadFileFromBundle
	mov r6, r0
	mov r0, #0x52
	bl GetObjectFileWork
	str r6, [r0]
_021715B0:
	mov r0, #0x52
	bl GetObjectFileWork
	mov r1, #0
	ldr ip, _0217162C // =0x0000FFFF
	mov r3, r0
	mov r0, r4
	mov r2, r1
	stmia sp, {r1, ip}
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x410
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x128]
	mov r1, #1
	str r1, [r0, #0x58]
	mov r1, #0x1000
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	mov r0, r4
	mov r1, r5
	mov r2, #0
	bl StageTask__SetParent
	mov r0, r4
	bl SailHUDNewRecordIcon__SetupObject
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02171624: .word 0x00001010
_02171628: .word aBbSbBb
_0217162C: .word 0x0000FFFF
	arm_func_end SailHUDNewRecordIcon__Create

	arm_func_start SailHUDNewRecordIcon__SetupObject
SailHUDNewRecordIcon__SetupObject: // 0x02171630
	stmdb sp!, {r4, lr}
	ldr r1, _02171690 // =VRAMSystem__GFXControl
	mov r2, #0x10
	ldr r4, [r1, #0]
	str r2, [r0, #0x28]
	ldrh r1, [r4, #0x20]
	mov r3, #2
	ldr r2, _02171694 // =SailHUDNewRecordIcon__State_2171698
	orr r1, r1, #0x100
	strh r1, [r4, #0x20]
	ldr lr, [r0, #0x28]
	mov r1, #0x80000
	sub ip, lr, #0x10
	orr ip, lr, ip, lsl #8
	strh ip, [r4, #0x22]
	str r3, [r0, #0x2c]
	str r2, [r0, #0xf4]
	str r1, [r0, #0x44]
	mov r1, #0x88000
	str r1, [r0, #0x48]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02171690: .word VRAMSystem__GFXControl
_02171694: .word SailHUDNewRecordIcon__State_2171698
	arm_func_end SailHUDNewRecordIcon__SetupObject

	arm_func_start SailHUDNewRecordIcon__State_2171698
SailHUDNewRecordIcon__State_2171698: // 0x02171698
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	ldr r1, [r5, #0x2c]
	ldr r0, _0217173C // =VRAMSystem__GFXControl
	cmp r1, #0
	ldr r4, [r0, #0]
	beq _021716E8
	subs r0, r1, #1
	str r0, [r5, #0x2c]
	bne _021716E8
	ldr r1, [r5, #0x20]
	mov r0, #0
	bic r1, r1, #0x20
	mov r2, r0
	str r1, [r5, #0x20]
	mov r3, #0x10000
	mov r1, #0x17
	str r3, [r5, #4]
	bl SailAudio__PlaySpatialSequence
_021716E8:
	ldr r0, [r5, #0x28]
	cmp r0, #0x10
	subne r0, r0, #1
	strne r0, [r5, #0x28]
	bne _02171714
	ldr r1, [r5, #0x11c]
	ldr r0, _02171740 // =SailHUDClearText__State_216FFA8
	ldr r1, [r1, #0xf4]
	cmp r1, r0
	moveq r0, #0xf
	streq r0, [r5, #0x28]
_02171714:
	ldr r1, [r5, #0x28]
	sub r0, r1, #0x10
	orr r0, r1, r0, lsl #8
	strh r0, [r4, #0x22]
	ldr r0, [r5, #0x28]
	cmp r0, #0
	ldreq r0, [r5, #0x18]
	orreq r0, r0, #4
	streq r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217173C: .word VRAMSystem__GFXControl
_02171740: .word SailHUDClearText__State_216FFA8
	arm_func_end SailHUDNewRecordIcon__State_2171698

		arm_func_start SailMessageCommon__Init
SailMessageCommon__Init: // 0x02171744
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x28
	ldr r4, [r0, #0x124]
	mov r0, #2
	mov r6, r2
	str r0, [sp]
	ldrh r0, [sp, #0x40]
	mov r5, r3
	str r6, [sp, #4]
	str r5, [sp, #8]
	mov r2, #0
	ldrh r3, [sp, #0x44]
	str r0, [sp, #0xc]
	mov r0, #1
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, #0xe
	str r0, [sp, #0x1c]
	mov r0, #0x41
	str r0, [sp, #0x20]
	mov r0, #0x40
	str r0, [sp, #0x24]
	mov r7, r1
	ldr r0, [r4, #4]
	ldr r1, [r4, #0]
	mov r3, r2
	bl FontWindowAnimator__Load1
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _02171810
	mov r1, #2
	stmia sp, {r1, r6}
	ldrh r1, [sp, #0x40]
	str r5, [sp, #8]
	ldrh r2, [sp, #0x44]
	str r1, [sp, #0xc]
	mov r1, #1
	str r2, [sp, #0x10]
	str r1, [sp, #0x14]
	str r1, [sp, #0x18]
	mov r1, #0xe
	str r1, [sp, #0x1c]
	mov r1, #0x41
	str r1, [sp, #0x20]
	mov r1, #0x40
	mov r2, #0
	str r1, [sp, #0x24]
	ldr r1, [r4, #0]
	mov r3, r2
	bl FontWindowAnimator__Load1
_02171810:
	ldrh r2, [sp, #0x4c]
	ldrh r1, [sp, #0x50]
	ldrh r0, [sp, #0x54]
	str r2, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	ldrh r3, [sp, #0x48]
	ldr r0, [r4, #0xc]
	ldr r1, [r4, #0]
	bl FontAnimator__LoadFont2
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _02171880
	ldrh r3, [sp, #0x4c]
	mov r1, #1
	mov r2, #0
	str r3, [sp]
	stmib sp, {r1, r2}
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	ldrh r3, [sp, #0x48]
	ldr r1, [r4, #0xc]
	bl FontUnknown2058D78__Init
_02171880:
	ldr r0, [r4, #0x14]
	cmp r0, #0
	beq _021718C8
	ldrh r3, [sp, #0x58]
	ldrh r1, [sp, #0x5c]
	mov r2, #0
	str r3, [sp]
	stmib sp, {r1, r2}
	str r2, [sp, #0xc]
	mov r3, #1
	str r3, [sp, #0x10]
	str r3, [sp, #0x14]
	ldr r1, [r4, #0]
	bl FontWindowMWControl__Load
	ldr r0, [r4, #0x14]
	mov r1, #0x2000
	add r0, r0, #0x34
	bl SetPaletteAnimationSpeed
_021718C8:
	ldr r0, [r4, #0xc]
	bl FontAnimator__LoadPaletteFunc2
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _021718F0
	bl FontUnknown2058D78__LoadPalette2
	ldr r0, [r4, #0x10]
	mov r1, #0
	mov r2, #0x114
	bl FontUnknown2058D78__Func_2058F2C
_021718F0:
	ldr r0, [r4, #0xc]
	mov r1, r7
	bl FontAnimator__LoadMPCFile
	ldrh r1, [r4, #0x24]
	ldr r0, [r4, #0xc]
	bl FontAnimator__SetMsgSequence
	ldr r0, [r4, #0xc]
	mov r1, #0
	bl FontAnimator__SetDialog
	ldrh r0, [sp, #0x40]
	cmp r0, #0x20
	blo _02171934
	mov r1, #0
	ldr r0, [r4, #0xc]
	mov r2, r1
	bl FontAnimator__InitStartPos
	b _02171944
_02171934:
	ldr r0, [r4, #0xc]
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
_02171944:
	ldr r0, [r4, #4]
	bl FontWindowAnimator__SetWindowClosed
	ldr r0, [r4, #8]
	cmp r0, #0
	addeq sp, sp, #0x28
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	bl FontWindowAnimator__SetWindowClosed
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SailMessageCommon__Init

	arm_func_start SailMessageCommon__LoadMPC
SailMessageCommon__LoadMPC: // 0x02171968
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x20
	mov r5, r0
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _021719AC
_02171988: // jump table
	b _021719A0 // case 0
	b _021719A0 // case 1
	b _021719A0 // case 2
	b _021719A0 // case 3
	b _021719A0 // case 4
	b _021719A0 // case 5
_021719A0:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _021719B0
_021719AC:
	mov r0, #1
_021719B0:
	and r4, r0, #0xff
	cmp r4, #5
	add r0, sp, #0
	mov r1, r5
	movhi r4, #5
	bl STD_CopyString
	ldr r1, _02171A04 // =0x0218D448
	add r0, sp, #0
	ldr r1, [r1, r4, lsl #2]
	bl STD_ConcatenateString
	ldr r1, _02171A08 // =_0218D444
	add r0, sp, #0
	ldr r1, [r1, #0]
	bl STD_ConcatenateString
	bl SailManager__GetArchive
	mov r2, r0
	add r1, sp, #0
	mov r0, #0
	bl ObjDataLoad
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02171A04: .word 0x0218D448
_02171A08: .word _0218D444
	arm_func_end SailMessageCommon__LoadMPC

	arm_func_start SailMessageCommon__LoadTutorialText
SailMessageCommon__LoadTutorialText: // 0x02171A0C
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r6, [r5, #0]
	mov r4, r1
	cmp r6, #0
	beq _02171A30
	mov r1, r6
	bl ObjDataSet
	b _02171AB0
_02171A30:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02171A68
_02171A44: // jump table
	b _02171A5C // case 0
	b _02171A5C // case 1
	b _02171A5C // case 2
	b _02171A5C // case 3
	b _02171A5C // case 4
	b _02171A5C // case 5
_02171A5C:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _02171A6C
_02171A68:
	mov r0, #1
_02171A6C:
	and r6, r0, #0xff
	bl SailManager__GetShipType
	mov r1, #6
	mla r1, r0, r1, r4
	cmp r6, #5
	mov r0, r1, lsl #0x10
	movhi r6, #5
	add r0, r6, r0, lsr #16
	mov r1, r0, lsl #0x10
	ldr r0, _02171AB8 // =aBbSbBb
	mov r1, r1, lsr #0x10
	mov r2, #0
	bl ReadFileFromBundle
	mov r6, r0
	mov r0, r5
	mov r1, r6
	bl ObjDataSet
_02171AB0:
	mov r0, r6
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02171AB8: .word aBbSbBb
	arm_func_end SailMessageCommon__LoadTutorialText

	arm_func_start SailArriveMessage__Create
SailArriveMessage__Create: // 0x02171ABC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	bl SailManager__GetWork
	mov r6, r0
	mov r0, #0x69
	mov r1, #2
	bl CreateStageTaskEx_
	ldr r2, _02171C94 // =SailMessageCommon__In_2172BE8
	mov r4, r0
	mov r1, #0x34
	str r2, [r4, #0xf8]
	bl StageTask__AllocateWorker
	mov r5, r0
	str r4, [r5, #0x18]
	ldr r1, [r6, #0x24]
	mov r0, #3
	orr r1, r1, #0x11
	str r1, [r6, #0x24]
	strh r0, [r5, #0x24]
	ldr r0, [r6, #0x24]
	tst r0, #0x40
	movne r0, #2
	strneh r0, [r5, #0x24]
	ldr r0, [r6, #0x24]
	tst r0, #0x20
	beq _02171B3C
	mov r0, #1
	strh r0, [r5, #0x24]
	ldr r0, [r6, #0x24]
	tst r0, #0x80000
	movne r0, #0
	strneh r0, [r5, #0x24]
_02171B3C:
	ldr r0, [r6, #0x24]
	tst r0, #0x4000
	beq _02171B60
	mov r0, #4
	strh r0, [r5, #0x24]
	bl SaveGame__CheckProgress12
	cmp r0, #0
	moveq r0, #6
	streqh r0, [r5, #0x24]
_02171B60:
	ldrh r0, [r6, #0x12]
	cmp r0, #1
	moveq r0, #5
	streqh r0, [r5, #0x24]
	bl SailManager__GetShipType
	cmp r0, #3
	bne _02171BAC
	ldrh r0, [r5, #0x24]
	cmp r0, #0
	moveq r0, #0xa
	streqh r0, [r5, #0x24]
	ldrh r0, [r5, #0x24]
	cmp r0, #1
	moveq r0, #0xb
	streqh r0, [r5, #0x24]
	ldrh r0, [r5, #0x24]
	cmp r0, #3
	moveq r0, #0xc
	streqh r0, [r5, #0x24]
_02171BAC:
	ldr r0, [r4, #0x120]
	ldr r1, _02171C98 // =SailArriveMessage__Destructor
	bl SetTaskDestructorEvent
	add r0, r6, #0x174
	bl FontWindowAnimator__Release
	add r0, r6, #0x23c
	bl FontAnimator__Release
	add r0, r6, #0xc4
	str r0, [r5]
	add r0, r6, #0x174
	str r0, [r5, #4]
	add r0, r6, #0x23c
	str r0, [r5, #0xc]
	mov r0, #0
	str r0, [r5, #0x14]
	ldr r0, _02171C9C // =aSbArriveMsg
	bl SailMessageCommon__LoadMPC
	mov r3, #0x20
	mov r1, r0
	str r3, [sp]
	mov r2, #8
	str r2, [sp, #4]
	str r2, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r2, #0
	str r2, [sp, #0x18]
	mov r0, r4
	mov r3, r2
	str r2, [sp, #0x1c]
	bl SailMessageCommon__Init
	ldr r1, _02171CA0 // =renderCoreGFXControlA
	mov r2, #0
	mov r0, r4
	strh r2, [r1, #6]
	bl SailCharacterPortrait__Create
	ldrh r0, [r6, #0x12]
	cmp r0, #1
	ldrneh r0, [r5, #0x24]
	cmpne r0, #3
	cmpne r0, #0xc
	cmpne r0, #6
	beq _02171C6C
	mov r0, r4
	bl SailArriveMessageOptionSuccess__Create
	str r0, [r5, #0x1c]
_02171C6C:
	ldrh r0, [r5, #0x24]
	cmp r0, #3
	cmpne r0, #0xc
	moveq r0, #1
	streqh r0, [r5, #0x2a]
	mov r0, r4
	bl SailMessageCommon__SetupObject
	mov r0, r4
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02171C94: .word SailMessageCommon__In_2172BE8
_02171C98: .word SailArriveMessage__Destructor
_02171C9C: .word aSbArriveMsg
_02171CA0: .word renderCoreGFXControlA
	arm_func_end SailArriveMessage__Create

	arm_func_start SailArriveMessage__Destructor
SailArriveMessage__Destructor: // 0x02171CA4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	mov r4, r0
	mov r0, r5
	bl GetTaskWork_
	ldr r0, [r0, #0x124]
	ldrsh r0, [r0, #0x2a]
	cmp r0, #0
	beq _02171CD8
	cmp r0, #1
	beq _02171D10
	b _02171D40
_02171CD8:
	ldr r0, [r4, #0x24]
	tst r0, #0x4000
	beq _02171CF4
	add r0, r4, #0x500
	mov r1, #3
	strh r1, [r0, #0xd0]
	b _02171D40
_02171CF4:
	tst r0, #0x40
	add r0, r4, #0x500
	movne r1, #2
	strneh r1, [r0, #0xd0]
	moveq r1, #1
	streqh r1, [r0, #0xd0]
	b _02171D40
_02171D10:
	ldr r0, [r4, #0x24]
	tst r0, #0x4000
	addeq r0, r4, #0x500
	moveq r1, #0
	streqh r1, [r0, #0xd0]
	beq _02171D40
	orr r0, r0, #0x20000
	orr r0, r0, #8
	str r0, [r4, #0x24]
	add r0, r4, #0x500
	mov r1, #3
	strh r1, [r0, #0xd0]
_02171D40:
	ldr r1, [r4, #0x24]
	mov r0, r5
	bic r1, r1, #1
	bic r1, r1, #0x10
	str r1, [r4, #0x24]
	bl StageTask_Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailArriveMessage__Destructor

	arm_func_start SailArriveMessageOptionSuccess__Create
SailArriveMessageOptionSuccess__Create: // 0x02171D5C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x20
	mov r7, r0
	bl SailManager__GetWork
	mov r6, r0
	mov r0, #5
	mov r1, #2
	bl CreateStageTaskEx_
	ldr r2, _02171ED0 // =SailMessageCommon__In_2172BE8
	mov r4, r0
	mov r1, #0x34
	str r2, [r4, #0xf8]
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, r4
	mov r1, r7
	mov r2, #0
	str r4, [r5, #0x18]
	bl StageTask__SetParent
	mov r0, #7
	strh r0, [r5, #0x24]
	ldr r0, [r6, #0x24]
	tst r0, #0x40
	movne r0, #8
	strneh r0, [r5, #0x24]
	ldr r0, [r6, #0x24]
	tst r0, #0x4000
	movne r0, #9
	strneh r0, [r5, #0x24]
	bl SailManager__GetShipType
	cmp r0, #3
	ldreqh r0, [r5, #0x24]
	mov r1, #1
	cmpeq r0, #7
	moveq r0, #0xd
	streqh r0, [r5, #0x24]
	add r0, r6, #0x300
	strh r1, [r5, #0x2c]
	bl FontWindowAnimator__Release
	add r0, r6, #0x364
	bl FontAnimator__Release
	add r0, r6, #0x28
	add r0, r0, #0x400
	bl FontWindowMWControl__Release
	add r0, r6, #0xc4
	str r0, [r5]
	add r0, r6, #0x300
	str r0, [r5, #4]
	add r0, r6, #0x364
	str r0, [r5, #0xc]
	add r0, r6, #0x28
	add r0, r0, #0x400
	str r0, [r5, #0x14]
	ldr r0, _02171ED4 // =aSbArriveMsg
	bl SailMessageCommon__LoadMPC
	mov r3, #0x10
	mov r6, r0
	str r3, [sp]
	mov r1, #6
	str r1, [sp, #4]
	mov r2, #8
	str r2, [sp, #8]
	mov r0, #0xb
	str r0, [sp, #0xc]
	str r3, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r0, #0x70
	str r0, [sp, #0x18]
	str r3, [sp, #0x1c]
	mov r0, r4
	mov r1, r6
	mov r3, #0xa
	bl SailMessageCommon__Init
	ldr r0, [r5, #0xc]
	mov r1, r6
	bl FontAnimator__LoadMPCFile
	ldrh r1, [r5, #0x24]
	ldr r0, [r5, #0xc]
	bl FontAnimator__SetMsgSequence
	ldr r0, [r5, #0xc]
	mov r1, #0
	bl FontAnimator__SetDialog
	ldr r0, [r5, #0xc]
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	ldr r0, [r5, #4]
	bl FontWindowAnimator__SetWindowClosed
	mov r0, r4
	bl SailMessageCommon__SetupObject
	mov r0, r4
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02171ED0: .word SailMessageCommon__In_2172BE8
_02171ED4: .word aSbArriveMsg
	arm_func_end SailArriveMessageOptionSuccess__Create

	arm_func_start SailArriveMessageOptionFail__Create
SailArriveMessageOptionFail__Create: // 0x02171ED8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x20
	bl SailManager__GetWork
	mov r6, r0
	mov r0, #5
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	ldr r0, [r4, #0x120]
	mov r1, #3
	bl SetTaskPauseLevel
	mov r0, r4
	mov r1, #0x34
	bl StageTask__AllocateWorker
	mov r5, r0
	str r4, [r5, #0x18]
	ldr r0, [r6, #0x24]
	ldr r1, _02172000 // =SailArriveMessage2__Destructor
	orr r0, r0, #0x11
	str r0, [r6, #0x24]
	ldr r0, [r4, #0x120]
	bl SetTaskDestructorEvent
	mov r0, #0xe
	strh r0, [r5, #0x24]
	mov r0, #2
	strh r0, [r5, #0x2c]
	ldrh r0, [r6, #0x12]
	mov r7, #8
	cmp r0, #6
	bne _02171F68
	mov r0, #0x11
	strh r0, [r5, #0x24]
	ldrsh r0, [r5, #0x2c]
	mov r7, #6
	sub r0, r0, #1
	strh r0, [r5, #0x2c]
_02171F68:
	add r0, r6, #0x300
	bl FontWindowAnimator__Release
	add r0, r6, #0x364
	bl FontAnimator__Release
	add r0, r6, #0x28
	add r0, r0, #0x400
	bl FontWindowMWControl__Release
	add r0, r6, #0xc4
	str r0, [r5]
	add r0, r6, #0x300
	str r0, [r5, #4]
	add r0, r6, #0x364
	str r0, [r5, #0xc]
	add r0, r6, #0x28
	add r0, r0, #0x400
	str r0, [r5, #0x14]
	ldr r0, _02172004 // =aSbArriveMsg
	bl SailMessageCommon__LoadMPC
	mov r3, #0x10
	mov r1, r0
	stmia sp, {r3, r7}
	mov r2, #8
	str r2, [sp, #8]
	mov r0, #9
	str r0, [sp, #0xc]
	str r3, [sp, #0x10]
	str r7, [sp, #0x14]
	mov r0, #0x70
	str r0, [sp, #0x18]
	str r3, [sp, #0x1c]
	mov r0, r4
	mov r3, r2
	bl SailMessageCommon__Init
	mov r0, r4
	bl SailMessageCommon__SetupObject
	mov r0, r4
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02172000: .word SailArriveMessage2__Destructor
_02172004: .word aSbArriveMsg
	arm_func_end SailArriveMessageOptionFail__Create

	arm_func_start SailArriveMessage2__Destructor
SailArriveMessage2__Destructor: // 0x02172008
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl SailManager__GetWork
	mov r4, r0
	mov r0, r6
	ldr r5, _021720F4 // =gameState
	bl GetTaskWork_
	ldrh r1, [r4, #0x12]
	ldr r2, [r0, #0x124]
	cmp r1, #6
	ldreqsh r0, [r2, #0x2a]
	cmpeq r0, #1
	moveq r0, #2
	streqh r0, [r2, #0x2a]
	ldrsh r0, [r2, #0x2a]
	cmp r0, #0
	cmpne r0, #1
	beq _02172064
	cmp r0, #2
	ldreq r0, [r4, #0x24]
	orreq r0, r0, #0x2000000
	streq r0, [r4, #0x24]
	b _021720D8
_02172064:
	add r0, r4, #0x500
	mov r1, #4
	strh r1, [r0, #0xd0]
	ldrsh r0, [r2, #0x2a]
	cmp r0, #0
	ldr r0, [r4, #0x24]
	orreq r0, r0, #0x8000
	orrne r0, r0, #0x40000
	str r0, [r4, #0x24]
	ldrh r0, [r4, #0x12]
	str r0, [r5, #0x70]
	ldrh r0, [r4, #0x14]
	str r0, [r5, #0x74]
	ldr r0, [r4, #0x18]
	str r0, [r5, #0x78]
	ldr r0, [r4, #0x2c]
	str r0, [r5, #0xac]
	ldr r0, [r4, #0xc]
	str r0, [r5, #0xa4]
	ldrh r0, [r4, #0x10]
	strh r0, [r5, #0xb4]
	ldr r0, [r4, #0x24]
	tst r0, #0x100000
	ldrneh r0, [r5, #0xb4]
	addne r0, r0, #0xa
	strneh r0, [r5, #0xb4]
	ldr r0, [r4, #0x24]
	orr r0, r0, #0x2000000
	str r0, [r4, #0x24]
_021720D8:
	ldr r1, [r4, #0x24]
	mov r0, r6
	bic r1, r1, #1
	bic r1, r1, #0x10
	str r1, [r4, #0x24]
	bl StageTask_Destructor
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021720F4: .word gameState
	arm_func_end SailArriveMessage2__Destructor

	arm_func_start SailPauseMessage__Create
SailPauseMessage__Create: // 0x021720F8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x20
	bl SailManager__GetWork
	mov r6, r0
	mov r0, #0x69
	mov r1, #2
	mov r7, #0
	bl CreateStageTaskEx_
	mov r4, r0
	ldr r0, [r4, #0x120]
	mov r1, #3
	bl SetTaskPauseLevel
	ldr r2, _02172270 // =SailMessageCommon__In_2172BE8
	mov r0, r4
	mov r1, #0x34
	str r2, [r4, #0xf8]
	bl StageTask__AllocateWorker
	mov r5, r0
	str r4, [r5, #0x18]
	ldr r1, [r6, #0x24]
	mov r0, r7
	orr r1, r1, #0x10
	str r1, [r6, #0x24]
	ldrh r2, [r5, #0x26]
	ldr r1, _02172274 // =SailPauseMessage__Destructor
	orr r2, r2, #0x20
	strh r2, [r5, #0x26]
	strh r0, [r5, #0x24]
	ldr r0, [r4, #0x120]
	bl SetTaskDestructorEvent
	add r0, r6, #0xa8
	add r0, r0, #0x400
	bl FontWindowAnimator__Release
	add r0, r6, #0x10c
	add r0, r0, #0x400
	bl FontAnimator__Release
	add r0, r6, #0xc4
	str r0, [r5]
	add r0, r6, #0xa8
	add r0, r0, #0x400
	str r0, [r5, #4]
	add r0, r6, #0x10c
	add r0, r0, #0x400
	str r0, [r5, #0xc]
	mov r0, r7
	str r0, [r5, #0x14]
	ldr r0, _02172278 // =aSbPauseMsg
	bl SailMessageCommon__LoadMPC
	mov r1, r0
	ldr r0, [r6, #0x24]
	mov lr, #0x10
	tst r0, #0x1000
	ldrne r0, [r6, #0x18]
	mov ip, #4
	cmpne r0, #0
	movne r7, #4
	add r0, r7, #7
	add r2, r7, #6
	mov r3, r2, lsl #0x10
	str lr, [sp]
	mov r0, r0, lsl #0x10
	str ip, [sp, #4]
	mov r2, #8
	str r2, [sp, #8]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	str lr, [sp, #0x10]
	str ip, [sp, #0x14]
	mov r7, #0
	str r7, [sp, #0x18]
	mov r0, r4
	mov r3, r3, lsr #0x10
	str r7, [sp, #0x1c]
	bl SailMessageCommon__Init
	ldr r0, _0217227C // =renderCoreGFXControlA
	mov r1, r7
	strh r1, [r0, #6]
	ldr r0, [r6, #0x24]
	tst r0, #0x1000
	ldrne r0, [r6, #0x18]
	cmpne r0, #0
	beq _02172250
	ldrh r0, [r5, #0x26]
	orr r0, r0, #0x40
	strh r0, [r5, #0x26]
	b _0217225C
_02172250:
	mov r0, r4
	bl SailPauseMessageOptions__Create
	str r0, [r5, #0x1c]
_0217225C:
	mov r0, r4
	bl SailPauseMessage__SetupObject
	mov r0, r4
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02172270: .word SailMessageCommon__In_2172BE8
_02172274: .word SailPauseMessage__Destructor
_02172278: .word aSbPauseMsg
_0217227C: .word renderCoreGFXControlA
	arm_func_end SailPauseMessage__Create

	arm_func_start SailPauseMessage__Destructor
SailPauseMessage__Destructor: // 0x02172280
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	mov r4, r0
	mov r0, r5
	bl GetTaskWork_
	ldr r1, [r4, #0x24]
	mov r0, r5
	bic r1, r1, #0x10
	str r1, [r4, #0x24]
	bl StageTask_Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailPauseMessage__Destructor

	arm_func_start SailPauseMessageOptions__Create
SailPauseMessageOptions__Create: // 0x021722B0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	mov r4, r0
	bl SailManager__GetWork
	mov r6, r0
	mov r0, #5
	mov r1, #2
	bl CreateStageTaskEx_
	mov r5, r0
	ldr r0, [r5, #0x120]
	mov r1, #3
	bl SetTaskPauseLevel
	ldr r1, _021723C4 // =SailMessageCommon__In_2172BE8
	mov r0, r5
	str r1, [r5, #0xf8]
	mov r1, #0x34
	bl StageTask__AllocateWorker
	mov r1, r4
	mov r4, r0
	mov r0, r5
	mov r2, #0
	str r5, [r4, #0x18]
	bl StageTask__SetParent
	mov r0, #1
	strh r0, [r4, #0x24]
	mov r0, #2
	strh r0, [r4, #0x2c]
	ldrh r1, [r4, #0x26]
	add r0, r6, #0x300
	orr r1, r1, #0x60
	strh r1, [r4, #0x26]
	bl FontWindowAnimator__Release
	add r0, r6, #0x364
	bl FontAnimator__Release
	add r0, r6, #0x28
	add r0, r0, #0x400
	bl FontWindowMWControl__Release
	add r0, r6, #0xc4
	str r0, [r4]
	add r0, r6, #0x300
	str r0, [r4, #4]
	add r0, r6, #0x364
	str r0, [r4, #0xc]
	add r0, r6, #0x28
	add r0, r0, #0x400
	str r0, [r4, #0x14]
	ldr r0, _021723C8 // =aSbPauseMsg
	bl SailMessageCommon__LoadMPC
	mov r3, #0x10
	mov r1, r0
	str r3, [sp]
	mov r2, #8
	str r2, [sp, #4]
	str r2, [sp, #8]
	mov r0, #0xb
	str r0, [sp, #0xc]
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r0, #0x70
	str r0, [sp, #0x18]
	str r3, [sp, #0x1c]
	mov r0, r5
	mov r3, #0xa
	bl SailMessageCommon__Init
	mov r0, r5
	bl SailPauseMessage__SetupObject
	mov r0, r5
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021723C4: .word SailMessageCommon__In_2172BE8
_021723C8: .word aSbPauseMsg
	arm_func_end SailPauseMessageOptions__Create

	arm_func_start SailTrainingDialog__Create
SailTrainingDialog__Create: // 0x021723CC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x20
	mov r7, r0
	bl SailManager__GetWork
	mov r6, r0
	mov r0, #0x69
	mov r1, #2
	bl CreateStageTaskEx_
	ldr r2, _02172584 // =SailMessageCommon__In_2172BE8
	mov r4, r0
	mov r1, #0x34
	str r2, [r4, #0xf8]
	bl StageTask__AllocateWorker
	mov r5, r0
	str r4, [r5, #0x18]
	ldr r1, [r6, #0x24]
	mov r0, #0
	orr r1, r1, #0x11
	str r1, [r6, #0x24]
	strh r0, [r5, #0x24]
	cmp r7, #0
	beq _02172480
	ldr r0, _02172588 // =0x0000FFFF
	cmp r7, r0
	moveq r0, #8
	streqh r0, [r5, #0x24]
	beq _0217248C
	sub r0, r0, #1
	cmp r7, r0
	bne _0217245C
	mov r0, #0xa
	strh r0, [r5, #0x24]
	ldrh r0, [r5, #0x26]
	orr r0, r0, #0x100
	strh r0, [r5, #0x26]
	b _0217248C
_0217245C:
	add r0, r7, #0xb
	strh r0, [r5, #0x24]
	ldrh r0, [r5, #0x26]
	orr r0, r0, #0x80
	strh r0, [r5, #0x26]
	ldrh r0, [r5, #0x26]
	orr r0, r0, #0x100
	strh r0, [r5, #0x26]
	b _0217248C
_02172480:
	ldrh r0, [r5, #0x26]
	orr r0, r0, #0x100
	strh r0, [r5, #0x26]
_0217248C:
	ldr r0, [r4, #0x120]
	ldr r1, _0217258C // =SailTrainingDialog__Destructor
	bl SetTaskDestructorEvent
	add r0, r6, #0x1d8
	bl FontWindowAnimator__Release
	add r0, r6, #0x174
	bl FontWindowAnimator__Release
	add r0, r6, #0x23c
	bl FontAnimator__Release
	add r0, r6, #0xc4
	str r0, [r5]
	add r0, r6, #0x174
	str r0, [r5, #4]
	add r0, r6, #0x1d8
	str r0, [r5, #8]
	add r0, r6, #0x23c
	str r0, [r5, #0xc]
	add r0, r6, #0x7c
	add r0, r0, #0x400
	str r0, [r5, #0x10]
	mov r0, #0
	str r0, [r5, #0x14]
	mov r0, #0x50
	bl GetObjectFileWork
	mov r1, #0x24
	bl SailMessageCommon__LoadTutorialText
	str r0, [r5, #0x30]
	mov r2, #0x20
	str r2, [sp]
	mov r1, #8
	str r1, [sp, #4]
	str r1, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	str r2, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r2, #0
	str r2, [sp, #0x18]
	str r2, [sp, #0x1c]
	mov r0, r4
	ldr r1, [r5, #0x30]
	mov r3, r2
	bl SailMessageCommon__Init
	mov r1, #0
	ldr r0, _02172590 // =renderCoreGFXControlA
	ldr r2, _02172594 // =0x0000FEEC
	strh r1, [r0, #6]
	ldr r1, _02172598 // =renderCoreGFXControlB
	mov r0, r4
	strh r2, [r1, #6]
	bl SailCharacterPortrait__Create
	ldrh r0, [r5, #0x24]
	cmp r0, #8
	bne _02172570
	mov r0, r4
	bl SailTrainingYesNoOption__Create
	str r0, [r5, #0x1c]
_02172570:
	mov r0, r4
	bl SailMessageCommon__SetupObject
	mov r0, r4
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02172584: .word SailMessageCommon__In_2172BE8
_02172588: .word 0x0000FFFF
_0217258C: .word SailTrainingDialog__Destructor
_02172590: .word renderCoreGFXControlA
_02172594: .word 0x0000FEEC
_02172598: .word renderCoreGFXControlB
	arm_func_end SailTrainingDialog__Create

	arm_func_start SailTrainingDialog__Destructor
SailTrainingDialog__Destructor: // 0x0217259C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl SailManager__GetWork
	mov r5, r0
	mov r0, r6
	bl GetTaskWork_
	ldr r4, [r0, #0x124]
	ldrh r0, [r4, #0x24]
	cmp r0, #1
	cmpne r0, #2
	cmpne r0, #9
	beq _02172604
	cmp r0, #7
	cmpne r0, #0xa
	cmpne r0, #6
	ldreq r0, [r5, #0x24]
	biceq r0, r0, #1
	streq r0, [r5, #0x24]
	ldr r0, [r5, #0x24]
	bic r0, r0, #0x10
	str r0, [r5, #0x24]
	ldrh r0, [r4, #0x26]
	tst r0, #0x200
	ldrne r0, [r5, #0x24]
	bicne r0, r0, #0x10000
	strne r0, [r5, #0x24]
_02172604:
	ldr r0, [r4, #0x30]
	cmp r0, #0
	beq _02172624
	mov r0, #0x50
	bl GetObjectFileWork
	bl ObjDataRelease
	mov r0, #0
	str r0, [r4, #0x30]
_02172624:
	mov r0, r6
	bl StageTask_Destructor
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SailTrainingDialog__Destructor

	arm_func_start SailTrainingContinueOption__Create
SailTrainingContinueOption__Create: // 0x02172630
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x20
	mov r7, r0
	bl SailManager__GetWork
	mov r6, r0
	mov r0, #6
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	ldr r0, [r4, #0x120]
	ldr r1, _0217273C // =SailTrainingDialog__Destructor
	bl SetTaskDestructorEvent
	mov r0, r4
	mov r1, #0x34
	bl StageTask__AllocateWorker
	mov r5, r0
	str r4, [r5, #0x18]
	mov r0, #1
	strh r0, [r5, #0x24]
	cmp r7, #1
	movhs r0, #2
	strhsh r0, [r5, #0x24]
	mov r1, #0
	add r0, r6, #0x300
	strh r1, [r5, #0x2c]
	bl FontWindowAnimator__Release
	add r0, r6, #0x364
	bl FontAnimator__Release
	add r0, r6, #0x28
	add r0, r0, #0x400
	bl FontWindowMWControl__Release
	add r0, r6, #0xc4
	str r0, [r5]
	add r0, r6, #0x300
	str r0, [r5, #4]
	add r0, r6, #0x364
	str r0, [r5, #0xc]
	add r0, r6, #0x28
	add r0, r0, #0x400
	str r0, [r5, #0x14]
	mov r0, #0x50
	bl GetObjectFileWork
	mov r1, #0x24
	bl SailMessageCommon__LoadTutorialText
	str r0, [r5, #0x30]
	mov r3, #0x10
	str r3, [sp]
	mov r1, #4
	str r1, [sp, #4]
	mov r2, #8
	str r2, [sp, #8]
	mov r0, #0xd
	str r0, [sp, #0xc]
	str r3, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r0, #0x70
	str r0, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r1, [r5, #0x30]
	mov r0, r4
	mov r3, #0xc
	bl SailMessageCommon__Init
	mov r0, r4
	bl SailTrainingContinueOption__SetupObject
	mov r0, r4
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0217273C: .word SailTrainingDialog__Destructor
	arm_func_end SailTrainingContinueOption__Create

	arm_func_start SailTrainingFinishedDialog__Create
SailTrainingFinishedDialog__Create: // 0x02172740
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x20
	mov r7, r0
	bl SailManager__GetWork
	mov r6, r0
	mov r0, #0x69
	mov r1, #2
	bl CreateStageTaskEx_
	ldr r2, _021728C8 // =SailMessageCommon__In_2172BE8
	mov r4, r0
	mov r1, #0x34
	str r2, [r4, #0xf8]
	bl StageTask__AllocateWorker
	mov r5, r0
	str r4, [r5, #0x18]
	ldr r0, [r6, #0x24]
	cmp r7, #0
	orr r0, r0, #0x10
	orr r0, r0, #0x10000
	str r0, [r6, #0x24]
	beq _021727BC
	mov r0, #7
	strh r0, [r5, #0x24]
	ldr r0, [r6, #0x18]
	cmp r0, #0
	movne r0, #6
	strneh r0, [r5, #0x24]
	ldr r0, [r6, #0x24]
	orr r0, r0, #1
	str r0, [r6, #0x24]
	b _02172804
_021727BC:
	mov r0, #3
	ldr r3, _021728CC // =_obj_disp_rand
	strh r0, [r5, #0x24]
	ldr ip, [r3]
	ldr r1, _021728D0 // =0x00196225
	ldr r2, _021728D4 // =0x3C6EF35F
	mla r1, ip, r1, r2
	str r1, [r3]
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	ldrh r2, [r5, #0x24]
	and r1, r1, #3
	add r1, r2, r1
	strh r1, [r5, #0x24]
	ldrh r1, [r5, #0x24]
	cmp r1, #5
	strhih r0, [r5, #0x24]
_02172804:
	ldrh r0, [r5, #0x26]
	ldr r1, _021728D8 // =SailTrainingDialog__Destructor
	orr r0, r0, #0x200
	strh r0, [r5, #0x26]
	ldr r0, [r4, #0x120]
	bl SetTaskDestructorEvent
	add r0, r6, #0x174
	bl FontWindowAnimator__Release
	add r0, r6, #0x23c
	bl FontAnimator__Release
	add r0, r6, #0xc4
	str r0, [r5]
	add r0, r6, #0x174
	str r0, [r5, #4]
	add r0, r6, #0x23c
	str r0, [r5, #0xc]
	mov r0, #0
	str r0, [r5, #0x14]
	mov r0, #0x50
	bl GetObjectFileWork
	mov r1, #0x24
	bl SailMessageCommon__LoadTutorialText
	str r0, [r5, #0x30]
	mov r2, #0x20
	str r2, [sp]
	mov r1, #8
	str r1, [sp, #4]
	str r1, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	str r2, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r2, #0
	str r2, [sp, #0x18]
	str r2, [sp, #0x1c]
	ldr r1, [r5, #0x30]
	mov r0, r4
	mov r3, r2
	bl SailMessageCommon__Init
	mov r2, #0
	ldr r1, _021728DC // =renderCoreGFXControlA
	mov r0, r4
	strh r2, [r1, #6]
	bl SailCharacterPortrait__Create
	mov r0, r4
	bl SailMessageCommon__SetupObject
	mov r0, r4
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021728C8: .word SailMessageCommon__In_2172BE8
_021728CC: .word _obj_disp_rand
_021728D0: .word 0x00196225
_021728D4: .word 0x3C6EF35F
_021728D8: .word SailTrainingDialog__Destructor
_021728DC: .word renderCoreGFXControlA
	arm_func_end SailTrainingFinishedDialog__Create

	arm_func_start SailTrainingYesNoOption__Create
SailTrainingYesNoOption__Create: // 0x021728E0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	mov r4, r0
	bl SailManager__GetWork
	mov r6, r0
	mov r0, #5
	mov r1, #2
	bl CreateStageTaskEx_
	mov r5, r0
	ldr r0, [r5, #0x120]
	ldr r1, _021729F0 // =SailTrainingDialog__Destructor
	bl SetTaskDestructorEvent
	mov r0, r5
	mov r1, #0x34
	bl StageTask__AllocateWorker
	mov r1, r4
	mov r4, r0
	str r5, [r4, #0x18]
	mov r0, r5
	mov r2, #0
	bl StageTask__SetParent
	mov r0, #9
	strh r0, [r4, #0x24]
	mov r0, #1
	strh r0, [r4, #0x2c]
	add r0, r6, #0x300
	bl FontWindowAnimator__Release
	add r0, r6, #0x364
	bl FontAnimator__Release
	add r0, r6, #0x28
	add r0, r0, #0x400
	bl FontWindowMWControl__Release
	add r0, r6, #0xc4
	str r0, [r4]
	add r0, r6, #0x300
	str r0, [r4, #4]
	add r0, r6, #0x364
	str r0, [r4, #0xc]
	add r0, r6, #0x28
	add r0, r0, #0x400
	str r0, [r4, #0x14]
	mov r0, #0x50
	bl GetObjectFileWork
	mov r1, #0x24
	bl SailMessageCommon__LoadTutorialText
	str r0, [r4, #0x30]
	mov r3, #0x10
	str r3, [sp]
	mov r1, #6
	str r1, [sp, #4]
	mov r2, #8
	str r2, [sp, #8]
	mov r0, #0xd
	str r0, [sp, #0xc]
	str r3, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r0, #0x70
	str r0, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r1, [r4, #0x30]
	mov r0, r5
	mov r3, #0xc
	bl SailMessageCommon__Init
	mov r0, r5
	bl SailMessageCommon__SetupObject
	mov r0, r5
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021729F0: .word SailTrainingDialog__Destructor
	arm_func_end SailTrainingYesNoOption__Create

	arm_func_start SailMessageCommon__Func_21729F4
SailMessageCommon__Func_21729F4: // 0x021729F4
	ldr r0, [r0, #0x124]
	ldrsh r0, [r0, #0x2a]
	bx lr
	arm_func_end SailMessageCommon__Func_21729F4

	arm_func_start SailMessageCommon__SetupObject
SailMessageCommon__SetupObject: // 0x02172A00
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldrh r0, [r4, #0x26]
	ldr r1, _02172A6C // =SailMessageCommon__FontCallback
	mov r2, r4
	orr r0, r0, #0x10
	strh r0, [r4, #0x26]
	ldr r0, [r4, #0xc]
	bl FontAnimator__SetCallback
	ldr r0, [r5, #0x11c]
	cmp r0, #0
	ldrne r0, _02172A70 // =SailMessageCommon__State_2172A78
	strne r0, [r5, #0xf4]
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02172A50
	bl FontWindowAnimator__SetWindowClosed
_02172A50:
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _02172A60
	bl FontWindowAnimator__SetWindowClosed
_02172A60:
	ldr r0, _02172A74 // =SailMessageCommon__State_2172AD0
	str r0, [r5, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02172A6C: .word SailMessageCommon__FontCallback
_02172A70: .word SailMessageCommon__State_2172A78
_02172A74: .word SailMessageCommon__State_2172AD0
	arm_func_end SailMessageCommon__SetupObject

	arm_func_start SailMessageCommon__State_2172A78
SailMessageCommon__State_2172A78: // 0x02172A78
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r0, [r5, #0x11c]
	ldr r0, [r0, #0x124]
	ldr r0, [r0, #0xc]
	bl FontAnimator__IsLastDialog
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, _02172ACC // =SailMessageCommon__State_2172AD0
	str r0, [r5, #0xf4]
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02172AB8
	bl FontWindowAnimator__SetWindowClosed
_02172AB8:
	ldr r0, [r4, #8]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	bl FontWindowAnimator__SetWindowClosed
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02172ACC: .word SailMessageCommon__State_2172AD0
	arm_func_end SailMessageCommon__State_2172A78

	arm_func_start SailMessageCommon__State_2172AD0
SailMessageCommon__State_2172AD0: // 0x02172AD0
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	mov r5, r0
	ldr r0, [r5, #0x24]
	tst r0, #0x800
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, r5, r6, pc}
	ldrh r0, [r4, #0x26]
	tst r0, #0x4000
	bne _02172B70
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #4]
	mov r1, #1
	mov r2, #4
	bl FontWindowAnimator__InitAnimation
	ldr r0, [r4, #4]
	bl FontWindowAnimator__StartAnimating
	ldr r0, [r4, #4]
	bl FontWindowAnimator__ProcessWindowAnim
	ldr r0, [r4, #0x14]
	cmp r0, #0
	beq _02172B48
	mov r0, #0
	mov r2, r0
	mov r1, #0x65
	bl SailAudio__PlaySpatialSequence
_02172B48:
	ldrh r1, [r4, #0x26]
	mov r0, #0
	add sp, sp, #4
	orr r1, r1, #0x4000
	strh r1, [r4, #0x26]
	ldr r1, [r5, #0x24]
	orr r1, r1, #0x10000
	str r1, [r5, #0x24]
	str r0, [r6, #0x2c]
	ldmia sp!, {r3, r4, r5, r6, pc}
_02172B70:
	ldr r0, [r6, #0x2c]
	cmp r0, #0
	bne _02172BAC
	ldr r0, [r4, #4]
	bl FontWindowAnimator__ProcessWindowAnim
	ldr r0, [r4, #4]
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _02172BD8
	ldr r0, [r6, #0x2c]
	add r0, r0, #1
	str r0, [r6, #0x2c]
	ldr r0, [r4, #4]
	bl FontWindowAnimator__SetWindowOpen
	b _02172BD8
_02172BAC:
	add r0, r0, #1
	str r0, [r6, #0x2c]
	cmp r0, #2
	ble _02172BD8
	ldrh r0, [r4, #0x26]
	tst r0, #0x200
	ldreq r0, [r5, #0x24]
	biceq r0, r0, #0x10000
	streq r0, [r5, #0x24]
	mov r0, r6
	bl SailMessageCommon__Func_2172CB4
_02172BD8:
	mov r0, r6
	bl SailMessageCommon__Func_2173828
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end SailMessageCommon__State_2172AD0

	arm_func_start SailMessageCommon__In_2172BE8
SailMessageCommon__In_2172BE8: // 0x02172BE8
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r2, [r0, #0x124]
	ldr r1, [r2, #0x1c]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, [r1, #0x18]
	ldr r1, [r1, #0x124]
	tst r0, #0x400
	beq _02172C28
	ldrh r1, [r2, #0x26]
	mov r0, #0
	orr r1, r1, #8
	strh r1, [r2, #0x26]
	str r0, [r2, #0x1c]
	ldmia sp!, {r3, pc}
_02172C28:
	tst r0, #4
	ldmeqia sp!, {r3, pc}
	ldrsh r0, [r1, #0x2a]
	cmp r0, #0
	strneh r0, [r2, #0x2a]
	ldrh r1, [r2, #0x26]
	mov r0, #0
	orr r1, r1, #0xc
	strh r1, [r2, #0x26]
	str r0, [r2, #0x1c]
	ldmia sp!, {r3, pc}
	arm_func_end SailMessageCommon__In_2172BE8

	arm_func_start SailPauseMessage__SetupObject
SailPauseMessage__SetupObject: // 0x02172C54
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x124]
	ldr r1, _02172C78 // =SailMessageCommon__FontCallback
	ldr r0, [r2, #0xc]
	bl FontAnimator__SetCallback
	ldr r0, _02172C7C // =SailPauseMessage__State_2172C80
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172C78: .word SailMessageCommon__FontCallback
_02172C7C: .word SailPauseMessage__State_2172C80
	arm_func_end SailPauseMessage__SetupObject

	arm_func_start SailPauseMessage__State_2172C80
SailPauseMessage__State_2172C80: // 0x02172C80
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x11c]
	cmp r0, #0
	beq _02172CA8
	ldr r0, [r0, #0x124]
	ldr r0, [r0, #0xc]
	bl FontAnimator__IsLastDialog
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
_02172CA8:
	mov r0, r4
	bl SailMessageCommon__Func_2172CB4
	ldmia sp!, {r4, pc}
	arm_func_end SailPauseMessage__State_2172C80

	arm_func_start SailMessageCommon__Func_2172CB4
SailMessageCommon__Func_2172CB4: // 0x02172CB4
	stmdb sp!, {r3, lr}
	ldr lr, [r0, #0x124]
	mov r3, #1
	ldrh ip, [lr, #0x26]
	mov r2, #0
	ldr r1, _02172CE8 // =SailMessageCommon__State_SelectOption
	orr ip, ip, #1
	strh ip, [lr, #0x26]
	strh r3, [lr, #0x28]
	str r2, [r0, #0x2c]
	str r2, [r0, #0x28]
	str r1, [r0, #0xf4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02172CE8: .word SailMessageCommon__State_SelectOption
	arm_func_end SailMessageCommon__Func_2172CB4

	arm_func_start SailMessageCommon__State_SelectOption
SailMessageCommon__State_SelectOption: // 0x02172CEC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	mov r10, r0
	ldr r6, [r10, #0x124]
	ldrh r0, [r6, #0x26]
	bic r0, r0, #0x2000
	strh r0, [r6, #0x26]
	ldrh r2, [r6, #0x26]
	tst r2, #0x200
	bne _02173028
	ldr r0, [r6, #0x14]
	cmp r0, #0
	beq _02172FA4
	ldr r1, [r6, #0x20]
	cmp r1, #0
	bne _02172E04
	tst r2, #0x40
	beq _02172D64
	ldr r1, _021732D8 // =padInput
	ldrh r1, [r1, #4]
	tst r1, #0xa
	beq _02172D64
	mov r1, #1
	bl FontWindowMWControl__SetPaletteAnim
	ldr r0, [r6, #0x14]
	bl FontWindowMWControl__Draw
	mov r0, #4
	str r0, [r6, #0x20]
	mov r0, #0
	strh r0, [r6, #0x2a]
_02172D64:
	ldr r0, [r6, #0x20]
	cmp r0, #0
	bne _02172E04
	ldr r0, _021732D8 // =padInput
	ldrh r1, [r0, #4]
	tst r1, #1
	beq _02172DA0
	ldr r0, [r6, #0x14]
	mov r1, #1
	bl FontWindowMWControl__SetPaletteAnim
	ldr r0, [r6, #0x14]
	bl FontWindowMWControl__Draw
	mov r0, #4
	str r0, [r6, #0x20]
	b _02172E04
_02172DA0:
	ldrh r0, [r0, #8]
	tst r0, #0x40
	beq _02172DD0
	ldr r0, [r6, #0x14]
	bl FontWindowMWControl__ValidatePaletteAnim
	ldrsh r1, [r6, #0x2a]
	mov r0, #0
	mov r2, r0
	sub r3, r1, #1
	mov r1, #0x63
	strh r3, [r6, #0x2a]
	bl SailAudio__PlaySpatialSequence
_02172DD0:
	ldr r0, _021732D8 // =padInput
	ldrh r0, [r0, #8]
	tst r0, #0x80
	beq _02172E04
	ldr r0, [r6, #0x14]
	bl FontWindowMWControl__ValidatePaletteAnim
	ldrsh r1, [r6, #0x2a]
	mov r0, #0
	mov r2, r0
	add r3, r1, #1
	mov r1, #0x63
	strh r3, [r6, #0x2a]
	bl SailAudio__PlaySpatialSequence
_02172E04:
	ldr r0, [r6, #0x20]
	cmp r0, #0
	bne _02172F7C
	ldr r11, _021732DC // =touchInput
	ldrh r0, [r11, #0x12]
	tst r0, #0xd
	beq _02172F7C
	ldr r0, [r6, #4]
	ldrsh r2, [r6, #0x2c]
	ldrsh r3, [r0, #0x10]
	ldrsh r1, [r0, #0x12]
	ldrh r0, [r0, #0x14]
	mov r3, r3, lsl #3
	mov r1, r1, lsl #3
	add r4, r3, #8
	add r1, r1, #8
	mov r3, r0, lsl #3
	mov r0, r4, lsl #0x10
	mov r1, r1, lsl #0x10
	sub r3, r3, #0x10
	add r2, r2, #1
	cmp r2, #0
	mov r8, r0, asr #0x10
	mov r9, r1, asr #0x10
	mov r0, r3, lsl #0x10
	mov r7, #0
	ble _02172F7C
	add r0, r8, r0, asr #16
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	add r5, sp, #8
_02172E80:
	add r0, r9, #0x10
	mov r0, r0, lsl #0x10
	mov ip, r0, asr #0x10
	mov r0, r5
	mov r1, r8
	mov r2, r9
	mov r3, r4
	str ip, [sp]
	bl ObjRect__SetBox2D
	ldrh r1, [r11, #0x14]
	ldrh r2, [r11, #0x16]
	mov r0, r5
	mov r3, #0
	bl ObjRect__RectPointCheck
	cmp r0, #0
	beq _02172F54
	ldr r0, _021732DC // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #8
	beq _02172EF8
	ldrsh r0, [r6, #0x2a]
	cmp r0, r7
	bne _02172EF8
	ldr r0, [r6, #0x14]
	mov r1, #1
	bl FontWindowMWControl__SetPaletteAnim
	ldr r0, [r6, #0x14]
	bl FontWindowMWControl__Draw
	mov r0, #4
	str r0, [r6, #0x20]
_02172EF8:
	ldr r0, _021732DC // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	beq _02172F28
	ldrsh r0, [r6, #0x2a]
	cmp r0, r7
	beq _02172F24
	mov r0, #0
	mov r2, r0
	mov r1, #0x63
	bl SailAudio__PlaySpatialSequence
_02172F24:
	strh r7, [r6, #0x2a]
_02172F28:
	ldr r0, _021732DC // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	beq _02172F7C
	ldrsh r0, [r6, #0x2a]
	cmp r0, r7
	bne _02172F7C
	ldrh r0, [r6, #0x26]
	orr r0, r0, #0x2000
	strh r0, [r6, #0x26]
	b _02172F7C
_02172F54:
	ldrsh r2, [r6, #0x2c]
	add r0, r9, #0x10
	add r1, r7, #1
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	add r2, r2, #1
	cmp r2, r1, asr #16
	mov r9, r0, asr #0x10
	mov r7, r1, asr #0x10
	bgt _02172E80
_02172F7C:
	ldrsh r0, [r6, #0x2a]
	cmp r0, #0
	ldrltsh r0, [r6, #0x2c]
	strlth r0, [r6, #0x2a]
	ldrsh r1, [r6, #0x2a]
	ldrsh r0, [r6, #0x2c]
	cmp r1, r0
	movgt r0, #0
	strgth r0, [r6, #0x2a]
	b _02173000
_02172FA4:
	tst r2, #0x100
	bne _02172FC8
	ldr r1, _021732D8 // =padInput
	ldr r0, _021732E0 // =0x00000C03
	ldrh r1, [r1, #4]
	tst r1, r0
	movne r0, r2
	orrne r0, r0, #8
	strneh r0, [r6, #0x26]
_02172FC8:
	ldrh r1, [r6, #0x26]
	tst r1, #0x40
	beq _02172FE8
	ldr r0, _021732D8 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #8
	orrne r0, r1, #8
	strneh r0, [r6, #0x26]
_02172FE8:
	ldr r0, _021732DC // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	ldrneh r0, [r6, #0x26]
	orrne r0, r0, #8
	strneh r0, [r6, #0x26]
_02173000:
	ldr r0, [r6, #0x20]
	cmp r0, #0
	beq _0217306C
	subs r0, r0, #1
	str r0, [r6, #0x20]
	bne _0217306C
	ldrh r0, [r6, #0x26]
	orr r0, r0, #8
	strh r0, [r6, #0x26]
	b _0217306C
_02173028:
	ldr r0, [r6, #0xc]
	bl FontAnimator__GetDialogID
	mov r1, r0
	ldr r0, [r6, #0xc]
	bl FontAnimator__GetDialogLineCount
	mov r1, #0x18
	mul r1, r0, r1
	ldr r2, [r10, #0x2c]
	add r0, r2, #1
	str r0, [r10, #0x2c]
	cmp r0, r1
	ble _0217306C
	mov r0, #0
	str r0, [r10, #0x2c]
	ldrh r0, [r6, #0x26]
	orr r0, r0, #8
	strh r0, [r6, #0x26]
_0217306C:
	ldr r0, [r6, #0xc]
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	ldrh r0, [r6, #0x26]
	beq _02173174
	tst r0, #8
	beq _021731AC
	tst r0, #0x100
	beq _02173098
	tst r0, #0x800
	beq _021731AC
_02173098:
	ldrh r1, [r6, #0x26]
	mov r0, #0
	bic r1, r1, #8
	strh r1, [r6, #0x26]
	ldrh r1, [r6, #0x26]
	bic r1, r1, #0x800
	strh r1, [r6, #0x26]
	str r0, [r6, #0x20]
	ldr r0, [r6, #0xc]
	bl FontAnimator__IsLastDialog
	cmp r0, #0
	beq _0217314C
	ldr r0, [r6, #0x1c]
	cmp r0, #0
	bne _021731AC
	ldrh r0, [r6, #0x26]
	tst r0, #0x80
	beq _02173100
	mov r0, #0
	mov r2, r0
	mov r1, #0x62
	bl SailAudio__PlaySpatialSequence
	mov r0, r10
	bl SailMessageCommon__Func_217344C
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02173100:
	ldr r0, [r6, #0x14]
	cmp r0, #0
	bne _02173120
	mov r0, #0
	mov r2, r0
	mov r1, #0x62
	bl SailAudio__PlaySpatialSequence
	b _0217313C
_02173120:
	ldr r0, [r10, #0x11c]
	cmp r0, #0
	bne _0217313C
	mov r0, #0
	mov r2, r0
	mov r1, #0x62
	bl SailAudio__PlaySpatialSequence
_0217313C:
	mov r0, r10
	bl SailMessageCommon__Func_2173658
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0217314C:
	ldr r0, [r6, #0xc]
	bl FontAnimator__AdvanceDialog
	ldr r0, [r6, #0x14]
	cmp r0, #0
	bne _021731AC
	mov r0, #0
	mov r2, r0
	mov r1, #0x62
	bl SailAudio__PlaySpatialSequence
	b _021731AC
_02173174:
	tst r0, #8
	bne _02173184
	tst r0, #0x20
	beq _021731A0
_02173184:
	ldrh r0, [r6, #0x26]
	mov r1, #0
	bic r0, r0, #8
	strh r0, [r6, #0x26]
	ldr r0, [r6, #0xc]
	bl FontAnimator__LoadCharacters
	b _021731AC
_021731A0:
	ldr r0, [r6, #0xc]
	mov r1, #1
	bl FontAnimator__LoadCharacters
_021731AC:
	ldrh r0, [r6, #0x26]
	tst r0, #0x100
	beq _02173200
	tst r0, #0x800
	bne _02173200
	ldr r0, [r6, #0xc]
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	beq _02173200
	ldr r0, [r6, #0xc]
	bl FontAnimator__IsLastDialog
	cmp r0, #0
	beq _021731EC
	mov r0, #2
	bl SailTrainingContinueOption__Create
	b _021731F4
_021731EC:
	mov r0, #0
	bl SailTrainingContinueOption__Create
_021731F4:
	ldrh r0, [r6, #0x26]
	orr r0, r0, #0x800
	strh r0, [r6, #0x26]
_02173200:
	mov r0, r10
	bl SailMessageCommon__Func_2173828
	ldr r0, [r6, #0x14]
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r6, #0xc]
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r6, #4]
	ldrsh r2, [r6, #0x2a]
	ldrsh r0, [r1, #0x12]
	ldrh r3, [r6, #0x26]
	ldrsh r4, [r1, #0x10]
	mov r0, r0, lsl #3
	add r1, r0, #8
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #4
	mov r0, r4, lsl #3
	add r1, r2, r1, asr #16
	add r0, r0, #8
	mov r2, r1, lsl #0x10
	mov r0, r0, lsl #0x10
	mov r2, r2, asr #0x10
	tst r3, #0x2000
	mov r1, r0, asr #0x10
	addne r0, r2, #1
	movne r0, r0, lsl #0x10
	movne r2, r0, asr #0x10
	ldr r0, [r6, #0x14]
	bl FontWindowMWControl__SetPosition
	ldr r0, [r6, #0x14]
	add r1, sp, #6
	add r2, sp, #4
	bl FontWindowMWControl__GetOffset
	mov r0, #0x10
	strh r0, [sp, #4]
	ldrh r0, [r6, #0x26]
	ldrh r1, [sp, #6]
	tst r0, #0x2000
	ldrneh r0, [sp, #4]
	subne r0, r0, #2
	strneh r0, [sp, #4]
	ldrh r2, [sp, #4]
	ldr r0, [r6, #0x14]
	bl FontWindowMWControl__SetOffset
	ldr r0, [r6, #0x14]
	bl FontWindowMWControl__Draw
	ldr r0, [r6, #0x14]
	bl FontWindowMWControl__CallWindowFunc2
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021732D8: .word padInput
_021732DC: .word touchInput
_021732E0: .word 0x00000C03
	arm_func_end SailMessageCommon__State_SelectOption

	arm_func_start SailTrainingContinueOption__SetupObject
SailTrainingContinueOption__SetupObject: // 0x021732E4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, _02173320 // =SailMessageCommon__FontCallback
	ldr r0, [r4, #0xc]
	mov r2, r4
	bl FontAnimator__SetCallback
	mov r1, #0
	str r1, [r5, #0x2c]
	ldr r0, _02173324 // =SailTrainingContinueOption__State_2173328
	str r1, [r5, #0x28]
	str r0, [r5, #0xf4]
	ldr r0, [r4, #0xc]
	bl FontAnimator__LoadCharacters
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02173320: .word SailMessageCommon__FontCallback
_02173324: .word SailTrainingContinueOption__State_2173328
	arm_func_end SailTrainingContinueOption__SetupObject

	arm_func_start SailTrainingContinueOption__State_2173328
SailTrainingContinueOption__State_2173328: // 0x02173328
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r0, [r4, #0xc]
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	beq _02173374
	ldr r0, _02173448 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	beq _02173380
	ldr r0, [r4, #0x20]
	cmp r0, #0
	beq _02173368
	cmp r0, #1
	ble _02173380
_02173368:
	mov r0, #1
	str r0, [r4, #0x20]
	b _02173380
_02173374:
	ldr r0, [r4, #0xc]
	mov r1, #0
	bl FontAnimator__LoadCharacters
_02173380:
	ldr r0, [r4, #0x20]
	cmp r0, #0
	beq _021733B8
	subs r0, r0, #1
	str r0, [r4, #0x20]
	bne _021733B8
	ldrh r0, [r4, #0x26]
	orr r0, r0, #8
	strh r0, [r4, #0x26]
	ldrh r0, [r4, #0x24]
	cmp r0, #2
	ldreqh r0, [r4, #0x26]
	orreq r0, r0, #0x400
	streqh r0, [r4, #0x26]
_021733B8:
	ldrh r0, [r4, #0x26]
	tst r0, #8
	mov r0, r5
	beq _021733D0
	bl SailMessageCommon__Func_2173658
	ldmia sp!, {r3, r4, r5, pc}
_021733D0:
	bl SailMessageCommon__Func_2173828
	ldr r0, [r4, #0x14]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0xc]
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r4, #4]
	ldrsh r0, [r4, #0x2a]
	ldrsh r3, [r1, #0x12]
	ldrsh r1, [r1, #0x10]
	mov r2, r0, lsl #4
	mov r0, r3, lsl #3
	add r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #3
	add r2, r2, r0, asr #16
	add r0, r1, #8
	mov r1, r2, lsl #0x10
	mov r3, r0, lsl #0x10
	ldr r0, [r4, #0x14]
	mov r2, r1, asr #0x10
	mov r1, r3, asr #0x10
	bl FontWindowMWControl__SetPosition
	ldr r0, [r4, #0x14]
	bl FontWindowMWControl__Draw
	ldr r0, [r4, #0x14]
	bl FontWindowMWControl__CallWindowFunc2
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02173448: .word touchInput
	arm_func_end SailTrainingContinueOption__State_2173328

	arm_func_start SailMessageCommon__Func_217344C
SailMessageCommon__Func_217344C: // 0x0217344C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, _021734B4 // =SailMessageCommon__State_21734B8
	mov r0, #0
	str r1, [r5, #0xf4]
	str r0, [r5, #0x2c]
	str r0, [r5, #0x28]
	ldrh r0, [r4, #0x26]
	tst r0, #0x1000
	beq _021734A8
	mov r0, #0xb
	strh r0, [r4, #0x24]
	add r0, r0, #0x3dc
	str r0, [r5, #0x2c]
	ldrh r1, [r4, #0x24]
	ldr r0, [r4, #0xc]
	bl FontAnimator__SetMsgSequence
	ldr r0, [r4, #0xc]
	mov r1, #0
	bl FontAnimator__SetDialog
	ldr r0, [r4, #0xc]
	bl FontAnimator__ClearPixels
_021734A8:
	mov r0, r5
	bl SailMessageCommon__Func_2173828
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021734B4: .word SailMessageCommon__State_21734B8
	arm_func_end SailMessageCommon__Func_217344C

	arm_func_start SailMessageCommon__State_21734B8
SailMessageCommon__State_21734B8: // 0x021734B8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	mov r5, r0
	ldr r1, [r5, #0x24]
	tst r1, #0x2000
	beq _021734E4
	mov r0, r6
	bl SailMessageCommon__Func_2173658
	ldmia sp!, {r4, r5, r6, pc}
_021734E4:
	ldrsh r2, [r4, #0x2e]
	mov r0, #0x114
	rsb r0, r0, #0
	cmp r2, r0
	bge _02173548
	tst r1, #1
	beq _021735C0
	strh r0, [r4, #0x2e]
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02173538
	bl FontWindowAnimator__SetWindowClosed
	ldrsh r1, [r4, #0x2e]
	ldr r0, _02173650 // =renderCoreGFXControlA
	rsb r1, r1, #0
	strh r1, [r0, #6]
	ldr r0, [r4, #4]
	bl FontWindowAnimator__Release
	mov r0, #0
	str r0, [r4, #4]
	b _021735C0
_02173538:
	ldr r0, [r5, #0x24]
	bic r0, r0, #1
	str r0, [r5, #0x24]
	b _021735C0
_02173548:
	ldr r0, [r4, #0xc]
	mov r1, #0
	bl FontAnimator__Func_2058D48
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _02173578
	ldrsh r2, [r4, #0x2e]
	mov r1, #0
	add r2, r2, #0x114
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	bl FontUnknown2058D78__Func_2058F2C
_02173578:
	ldrsh r1, [r4, #0x2e]
	ldr r0, _02173650 // =renderCoreGFXControlA
	rsb r1, r1, #0
	strh r1, [r0, #6]
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _021735A8
	ldrsh r1, [r4, #0x2e]
	ldr r0, _02173654 // =renderCoreGFXControlB
	add r1, r1, #0x114
	rsb r1, r1, #0
	strh r1, [r0, #6]
_021735A8:
	ldrsh r0, [r4, #0x2e]
	mov r0, r0, lsl #0xc
	str r0, [r6, #0x48]
	ldrsh r0, [r4, #0x2e]
	sub r0, r0, #0x30
	strh r0, [r4, #0x2e]
_021735C0:
	ldr r0, [r5, #0x24]
	tst r0, #1
	bne _02173644
	ldr r0, [r4, #0xc]
	bl FontAnimator__GetDialogID
	mov r1, r0
	ldr r0, [r4, #0xc]
	bl FontAnimator__GetDialogLineCount
	mov r1, #0x50
	mul r1, r0, r1
	ldr r2, [r6, #0x2c]
	add r0, r2, #1
	str r0, [r6, #0x2c]
	cmp r0, r1
	ble _02173638
	mov r0, #0
	str r0, [r6, #0x2c]
	ldr r0, [r4, #0xc]
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	beq _02173638
	ldr r0, [r4, #0xc]
	bl FontAnimator__IsLastDialog
	cmp r0, #0
	ldr r0, [r4, #0xc]
	beq _02173634
	mov r1, #0
	bl FontAnimator__SetDialog
	b _02173638
_02173634:
	bl FontAnimator__AdvanceDialog
_02173638:
	ldr r0, [r4, #0xc]
	mov r1, #1
	bl FontAnimator__LoadCharacters
_02173644:
	mov r0, r6
	bl SailMessageCommon__Func_2173828
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02173650: .word renderCoreGFXControlA
_02173654: .word renderCoreGFXControlB
	arm_func_end SailMessageCommon__State_21734B8

	arm_func_start SailMessageCommon__Func_2173658
SailMessageCommon__Func_2173658: // 0x02173658
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldrh r2, [r4, #0x26]
	tst r2, #0x10
	ldrne r1, [r4, #4]
	cmpne r1, #0
	bne _021736C0
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02173698
	bl FontWindowAnimator__SetWindowClosed
_02173698:
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _021736A8
	bl FontWindowAnimator__SetWindowClosed
_021736A8:
	ldr r0, [r4, #0x10]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r4, #0xc]
	bl FontUnknown2058D78__Release
	ldmia sp!, {r3, r4, r5, pc}
_021736C0:
	bic r1, r2, #1
	strh r1, [r4, #0x26]
	ldrh r2, [r4, #0x26]
	ldr r1, _021736F0 // =SailMessageCommon__State_21736F4
	orr r2, r2, #2
	bic r2, r2, #0x4000
	strh r2, [r4, #0x26]
	ldr r2, [r0, #0x24]
	orr r2, r2, #0x10000
	str r2, [r0, #0x24]
	str r1, [r5, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021736F0: .word SailMessageCommon__State_21736F4
	arm_func_end SailMessageCommon__Func_2173658

	arm_func_start SailMessageCommon__State_21736F4
SailMessageCommon__State_21736F4: // 0x021736F4
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r1, [r6, #0x18]
	mov r5, r0
	tst r1, #4
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, r5, r6, pc}
	ldrh r0, [r4, #0x26]
	tst r0, #0x4000
	bne _02173758
	orr r0, r0, #0x4000
	strh r0, [r4, #0x26]
	mov r3, #0
	str r3, [sp]
	mov r1, #4
	ldr r0, [r4, #4]
	mov r2, r1
	bl FontWindowAnimator__InitAnimation
	ldr r0, [r4, #4]
	bl FontWindowAnimator__StartAnimating
	ldr r0, [r4, #4]
	bl FontWindowAnimator__ProcessWindowAnim
_02173758:
	ldrh r0, [r4, #0x26]
	tst r0, #0x8000
	bne _021737A8
	ldr r0, [r4, #4]
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	ldr r0, [r4, #4]
	beq _021737A0
	bl FontWindowAnimator__SetWindowClosed
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _0217378C
	bl FontWindowAnimator__SetWindowClosed
_0217378C:
	ldrh r0, [r4, #0x26]
	add sp, sp, #4
	orr r0, r0, #0x8000
	strh r0, [r4, #0x26]
	ldmia sp!, {r3, r4, r5, r6, pc}
_021737A0:
	bl FontWindowAnimator__ProcessWindowAnim
	b _021737E8
_021737A8:
	tst r0, #0x200
	ldreq r0, [r5, #0x24]
	biceq r0, r0, #0x10000
	streq r0, [r5, #0x24]
	ldr r0, [r4, #4]
	bl FontWindowAnimator__SetWindowOpen
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _021737D4
	ldr r1, [r4, #0xc]
	bl FontUnknown2058D78__Release
_021737D4:
	ldr r0, [r6, #0x18]
	add sp, sp, #4
	orr r0, r0, #8
	str r0, [r6, #0x18]
	ldmia sp!, {r3, r4, r5, r6, pc}
_021737E8:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _021737F8
	bl FontWindowAnimator__Draw
_021737F8:
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _02173808
	bl FontWindowAnimator__Draw
_02173808:
	ldr r0, [r6, #0x11c]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r4, #0]
	bl FontWindow__PrepareSwapBuffer
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end SailMessageCommon__State_21736F4

	arm_func_start SailMessageCommon__Func_2173828
SailMessageCommon__Func_2173828: // 0x02173828
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, [r4, #4]
	cmp r1, #0
	beq _021738D4
	ldr r0, _021739C8 // =renderCoreGFXControlA
	ldrsh r2, [r1, #0x12]
	ldrsh r1, [r0, #6]
	mov r0, r2, lsl #0x13
	rsb r0, r1, r0, asr #16
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
	cmp r1, #0xc0
	bge _021738A4
	mvn r0, #0x3f
	cmp r1, r0
	ble _021738A4
	ldr r0, [r4, #0xc]
	mov r1, #0x40
	bl FontAnimator__DisableFlags
	mov r2, #0x4000000
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #2
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	b _021738D4
_021738A4:
	ldr r0, [r4, #0xc]
	mov r1, #0x40
	bl FontAnimator__EnableFlags
	mov r2, #0x4000000
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #2
	orr r0, r1, r0, lsl #8
	str r0, [r2]
_021738D4:
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _02173970
	ldr r2, [r4, #8]
	ldr r1, _021739CC // =renderCoreGFXControlB
	ldrsh r3, [r2, #0x12]
	ldrsh r2, [r1, #6]
	mov r1, r3, lsl #0x13
	rsb r1, r2, r1, asr #16
	mov r1, r1, lsl #0x10
	mov r2, r1, asr #0x10
	cmp r2, #0xc0
	bge _02173944
	mvn r1, #0x3f
	cmp r2, r1
	ble _02173944
	mov r1, #0x40
	bl FontUnknown2058D78__DisableFlags
	ldr r2, _021739D0 // =0x04001000
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #2
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	b _02173970
_02173944:
	mov r1, #0x40
	bl FontUnknown2058D78__EnableFlags
	ldr r2, _021739D0 // =0x04001000
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #2
	orr r0, r1, r0, lsl #8
	str r0, [r2]
_02173970:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02173980
	bl FontWindowAnimator__Draw
_02173980:
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _02173990
	bl FontWindowAnimator__Draw
_02173990:
	ldr r1, [r5, #0xf4]
	ldr r0, _021739D4 // =SailMessageCommon__State_2172AD0
	cmp r1, r0
	ldrne r0, _021739D8 // =SailMessageCommon__State_21736F4
	cmpne r1, r0
	beq _021739B0
	ldr r0, [r4, #0xc]
	bl FontAnimator__Draw
_021739B0:
	ldr r0, [r5, #0x11c]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0]
	bl FontWindow__PrepareSwapBuffer
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021739C8: .word renderCoreGFXControlA
_021739CC: .word renderCoreGFXControlB
_021739D0: .word 0x04001000
_021739D4: .word SailMessageCommon__State_2172AD0
_021739D8: .word SailMessageCommon__State_21736F4
	arm_func_end SailMessageCommon__Func_2173828

	arm_func_start SailMessageCommon__FontCallback
SailMessageCommon__FontCallback: // 0x021739DC
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r6, r0
	sub r0, r6, #0xb
	mov r5, r1
	mov r4, r2
	cmp r0, #0xd
	addls pc, pc, r0, lsl #2
	b _02173CC0
_02173A00: // jump table
	b _02173A38 // case 0
	b _02173A48 // case 1
	b _02173A58 // case 2
	b _02173A68 // case 3
	b _02173A78 // case 4
	b _02173A8C // case 5
	b _02173A8C // case 6
	b _02173A8C // case 7
	b _02173B04 // case 8
	b _02173B5C // case 9
	b _02173BB4 // case 10
	b _02173C08 // case 11
	b _02173C08 // case 12
	b _02173C68 // case 13
_02173A38:
	mov r0, #1
	add sp, sp, #4
	strh r0, [r4, #0x28]
	ldmia sp!, {r3, r4, r5, r6, pc}
_02173A48:
	mov r0, #2
	add sp, sp, #4
	strh r0, [r4, #0x28]
	ldmia sp!, {r3, r4, r5, r6, pc}
_02173A58:
	mov r0, #3
	add sp, sp, #4
	strh r0, [r4, #0x28]
	ldmia sp!, {r3, r4, r5, r6, pc}
_02173A68:
	mov r0, #4
	add sp, sp, #4
	strh r0, [r4, #0x28]
	ldmia sp!, {r3, r4, r5, r6, pc}
_02173A78:
	ldrh r0, [r4, #0x26]
	add sp, sp, #4
	orr r0, r0, #0x1000
	strh r0, [r4, #0x26]
	ldmia sp!, {r3, r4, r5, r6, pc}
_02173A8C:
	add r1, sp, #2
	add r2, sp, #0
	mov r0, r5
	bl FontAnimator__GetMsgPosition
	ldrsh r1, [sp, #2]
	ldrsh r0, [sp]
	add r1, r1, #0x48
	add r0, r0, #0x10
	strh r1, [sp, #2]
	strh r0, [sp]
	ldr r0, [r4, #0x18]
	cmp r0, #0
	beq _02173AD8
	sub r1, r6, #0x10
	mov r1, r1, lsl #0x10
	ldrsh r2, [sp, #2]
	ldrsh r3, [sp]
	mov r1, r1, lsr #0x10
	bl SailBoatWeaponIconHUD__Create
_02173AD8:
	cmp r6, #0x10
	mov r0, r5
	bne _02173AF4
	mov r1, #8
	bl FontAnimator__AdvanceXPos
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_02173AF4:
	mov r1, #0xd
	bl FontAnimator__AdvanceXPos
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_02173B04:
	add r1, sp, #2
	add r2, sp, #0
	mov r0, r5
	bl FontAnimator__GetMsgPosition
	ldrsh r1, [sp, #2]
	ldrsh r0, [sp]
	add r1, r1, #0x50
	add r0, r0, #0x10
	strh r1, [sp, #2]
	strh r0, [sp]
	ldr r0, [r4, #0x18]
	cmp r0, #0
	beq _02173B48
	ldrsh r2, [sp, #2]
	ldrsh r3, [sp]
	mov r1, #1
	bl SailJetBoostHUD__Create
_02173B48:
	mov r0, r5
	mov r1, #0x1d
	bl FontAnimator__AdvanceXPos
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_02173B5C:
	add r1, sp, #2
	add r2, sp, #0
	mov r0, r5
	bl FontAnimator__GetMsgPosition
	ldrsh r1, [sp, #2]
	ldrsh r0, [sp]
	add r1, r1, #0x50
	add r0, r0, #0x10
	strh r1, [sp, #2]
	strh r0, [sp]
	ldr r0, [r4, #0x18]
	cmp r0, #0
	beq _02173BA0
	ldrsh r2, [sp, #2]
	ldrsh r3, [sp]
	mov r1, #0
	bl SailJetBoostHUD__Create
_02173BA0:
	mov r0, r5
	mov r1, #0x1d
	bl FontAnimator__AdvanceXPos
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_02173BB4:
	add r1, sp, #2
	add r2, sp, #0
	mov r0, r5
	bl FontAnimator__GetMsgPosition
	ldrsh r1, [sp, #2]
	ldrsh r0, [sp]
	add r1, r1, #0x50
	add r0, r0, #0x10
	strh r1, [sp, #2]
	strh r0, [sp]
	ldr r0, [r4, #0x18]
	cmp r0, #0
	beq _02173BF4
	ldrsh r1, [sp, #2]
	ldrsh r2, [sp]
	bl SailHoverChargeHUD__Create
_02173BF4:
	mov r0, r5
	mov r1, #0x1e
	bl FontAnimator__AdvanceXPos
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_02173C08:
	add r1, sp, #2
	add r2, sp, #0
	mov r0, r5
	bl FontAnimator__GetMsgPosition
	ldrsh r1, [sp, #2]
	ldrsh r0, [sp]
	add r1, r1, #0x48
	add r0, r0, #0x10
	strh r1, [sp, #2]
	strh r0, [sp]
	ldr r0, [r4, #0x18]
	cmp r0, #0
	beq _02173C54
	sub r1, r6, #0x16
	mov r1, r1, lsl #0x10
	ldrsh r2, [sp, #2]
	ldrsh r3, [sp]
	mov r1, r1, lsr #0x10
	bl SailSubReticleHUD__Create
_02173C54:
	mov r0, r5
	mov r1, #0xf
	bl FontAnimator__AdvanceXPos
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_02173C68:
	add r1, sp, #2
	add r2, sp, #0
	mov r0, r5
	bl FontAnimator__GetMsgPosition
	ldrsh r1, [sp, #2]
	ldrsh r0, [sp]
	add r1, r1, #0x4c
	add r0, r0, #0x10
	strh r1, [sp, #2]
	strh r0, [sp]
	ldr r0, [r4, #0x18]
	cmp r0, #0
	beq _02173CB4
	sub r1, r6, #0x16
	mov r1, r1, lsl #0x10
	ldrsh r2, [sp, #2]
	ldrsh r3, [sp]
	mov r1, r1, lsr #0x10
	bl SailSubReticleHUD__Create
_02173CB4:
	mov r0, r5
	mov r1, #0xd
	bl FontAnimator__AdvanceXPos
_02173CC0:
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end SailMessageCommon__FontCallback

	arm_func_start SailCharacterPortrait__Create
SailCharacterPortrait__Create: // 0x02173CC8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r4, r0
	bl SailManager__GetWork
	mov r6, r0
	mov r0, #0xcd
	mov r1, #2
	bl CreateStageTaskEx_
	mov r1, r4
	mov r2, #0x400
	mov r4, r0
	bl StageTask__SetParent
	ldr r0, [r6, #0x24]
	tst r0, #0x1000
	ldrne r0, [r4, #0x18]
	bicne r0, r0, #0x800000
	strne r0, [r4, #0x18]
	mov r0, #0x35
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	str r0, [sp]
	ldr r1, _02173DA0 // =0x0000FFFF
	ldr r2, _02173DA4 // =aNlTreBac
	str r1, [sp, #4]
	mov r0, r4
	mov r3, r5
	mov r1, #0
	bl ObjObjectAction2dBACLoad
	ldr r0, [r6, #0x24]
	mov r1, #0
	tst r0, #0x1000
	beq _02173D5C
	mov r0, r4
	mov r2, #1
	bl ObjActionAllocSpritePalette
	b _02173D68
_02173D5C:
	ldr r2, _02173DA8 // =0x00000401
	mov r0, r4
	bl ObjActionAllocSpritePalette
_02173D68:
	ldr r3, [r4, #0x128]
	mov r0, r4
	ldr r2, [r3, #0x3c]
	mov r1, #1
	bic r2, r2, #0x10
	str r2, [r3, #0x3c]
	bl StageTask__SetAnimation
	ldr r1, _02173DAC // =SailCharacterPortrait__Last
	mov r0, r4
	str r1, [r4, #0x10c]
	bl SailCharacterPortrait__SetupObject
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02173DA0: .word 0x0000FFFF
_02173DA4: .word aNlTreBac
_02173DA8: .word 0x00000401
_02173DAC: .word SailCharacterPortrait__Last
	arm_func_end SailCharacterPortrait__Create

	arm_func_start SailCharacterPortrait__SetupObject
SailCharacterPortrait__SetupObject: // 0x02173DB0
	ldr r1, _02173DC8 // =SailCharacterPortrait__State_2173DCC
	str r1, [r0, #0xf4]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	bx lr
	.align 2, 0
_02173DC8: .word SailCharacterPortrait__State_2173DCC
	arm_func_end SailCharacterPortrait__SetupObject

	arm_func_start SailCharacterPortrait__State_2173DCC
SailCharacterPortrait__State_2173DCC: // 0x02173DCC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x11c]
	ldr r4, [r0, #0x124]
	ldrh r0, [r4, #0x26]
	tst r0, #2
	ldrne r0, [r5, #0x18]
	orrne r0, r0, #4
	strne r0, [r5, #0x18]
	ldrh r0, [r4, #0x26]
	tst r0, #1
	ldr r0, [r5, #0x20]
	beq _02173E38
	tst r0, #0x20
	ldreqh r1, [r4, #0x28]
	ldreq r0, [r5, #0x28]
	cmpeq r1, r0
	beq _02173E20
	ldrh r1, [r4, #0x28]
	mov r0, r5
	bl StageTask__SetAnimation
_02173E20:
	ldr r0, [r5, #0x20]
	bic r0, r0, #0x20
	str r0, [r5, #0x20]
	ldrh r0, [r4, #0x28]
	str r0, [r5, #0x28]
	b _02173E40
_02173E38:
	orr r0, r0, #0x20
	str r0, [r5, #0x20]
_02173E40:
	ldr r4, _02173E68 // =g_obj
	mov r0, #0
	ldr r2, [r4, #0x28]
	mov r1, r0
	orr r5, r2, #8
	mov r2, r0
	sub r3, r0, #0x114000
	str r5, [r4, #0x28]
	bl SetObjCameraPosition
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02173E68: .word g_obj
	arm_func_end SailCharacterPortrait__State_2173DCC

	arm_func_start SailCharacterPortrait__Last
SailCharacterPortrait__Last: // 0x02173E6C
	stmdb sp!, {r3, lr}
	ldr ip, _02173E98 // =g_obj
	mov r0, #0
	ldr r2, [ip, #0x28]
	mov r1, r0
	bic lr, r2, #8
	mov r2, r0
	mov r3, r0
	str lr, [ip, #0x28]
	bl SetObjCameraPosition
	ldmia sp!, {r3, pc}
	.align 2, 0
_02173E98: .word g_obj
	arm_func_end SailCharacterPortrait__Last

	arm_func_start SailBoatWeaponIconHUD__Create
SailBoatWeaponIconHUD__Create: // 0x02173E9C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r5, r1
	mov r8, r2
	mov r7, r3
	bl SailManager__GetWork
	mov r6, r0
	mov r0, #0xcd
	mov r1, #2
	bl CreateStageTaskEx_
	mov r1, r4
	mov r2, #0x400
	mov r4, r0
	bl StageTask__SetParent
	mov r0, r8, lsl #0xc
	str r0, [r4, #0x68]
	mov r0, r7, lsl #0xc
	str r0, [r4, #0x6c]
	ldr r0, [r6, #0x24]
	tst r0, #0x1000
	ldrne r0, [r4, #0x18]
	bicne r0, r0, #0x800000
	strne r0, [r4, #0x18]
	mov r0, #0x4c
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02173F30
	ldr r0, _02173F9C // =aBbSbBb
	mov r1, #0x20
	mov r2, #0
	bl ReadFileFromBundle
	mov r6, r0
	mov r0, #0x4c
	bl GetObjectFileWork
	str r6, [r0]
_02173F30:
	mov r0, #0x4c
	bl GetObjectFileWork
	mov r1, #0
	ldr ip, _02173FA0 // =0x0000FFFF
	mov r3, r0
	mov r0, r4
	mov r2, r1
	stmia sp, {r1, ip}
	bl ObjObjectAction2dBACLoad
	ldr r2, _02173FA4 // =0x00000415
	mov r0, r4
	mov r1, #0
	bl ObjActionAllocSpritePalette
	ldr r3, [r4, #0x128]
	mov r0, r4
	ldr r2, [r3, #0x3c]
	mov r1, r5
	bic r2, r2, #0x10
	str r2, [r3, #0x3c]
	bl StageTask__SetAnimation
	ldr r1, _02173FA8 // =SailCharacterPortrait__Last
	mov r0, r4
	str r1, [r4, #0x10c]
	bl SailBoatWeaponIconHUD__SetupObject
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02173F9C: .word aBbSbBb
_02173FA0: .word 0x0000FFFF
_02173FA4: .word 0x00000415
_02173FA8: .word SailCharacterPortrait__Last
	arm_func_end SailBoatWeaponIconHUD__Create

	arm_func_start SailBoatWeaponIconHUD__SetupObject
SailBoatWeaponIconHUD__SetupObject: // 0x02173FAC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x11c]
	ldr r0, _02173FD4 // =SailBoatWeaponIconHUD__State_2173FD8
	ldr r1, [r1, #0x124]
	str r0, [r4, #0xf4]
	ldr r0, [r1, #0xc]
	bl FontAnimator__GetDialogID
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02173FD4: .word SailBoatWeaponIconHUD__State_2173FD8
	arm_func_end SailBoatWeaponIconHUD__SetupObject

	arm_func_start SailBoatWeaponIconHUD__State_2173FD8
SailBoatWeaponIconHUD__State_2173FD8: // 0x02173FD8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x11c]
	ldr r0, [r0, #0x124]
	ldr r0, [r0, #0xc]
	bl FontAnimator__GetDialogID
	ldr r1, [r4, #0x28]
	cmp r1, r0
	beq _02174014
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
_02174014:
	ldr r4, _0217403C // =g_obj
	mov r0, #0
	ldr r2, [r4, #0x28]
	mov r1, r0
	orr ip, r2, #8
	mov r2, r0
	sub r3, r0, #0x114000
	str ip, [r4, #0x28]
	bl SetObjCameraPosition
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217403C: .word g_obj
	arm_func_end SailBoatWeaponIconHUD__State_2173FD8

	arm_func_start SailJetBoostHUD__Create
SailJetBoostHUD__Create: // 0x02174040
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r5, r1
	mov r8, r2
	mov r7, r3
	bl SailManager__GetWork
	mov r6, r0
	mov r0, #0xcd
	mov r1, #2
	bl CreateStageTaskEx_
	mov r1, r4
	mov r2, #0x400
	mov r4, r0
	bl StageTask__SetParent
	mov r0, r8, lsl #0xc
	str r0, [r4, #0x68]
	mov r0, r7, lsl #0xc
	str r0, [r4, #0x6c]
	ldr r0, [r6, #0x24]
	tst r0, #0x1000
	ldrne r0, [r4, #0x18]
	bicne r0, r0, #0x800000
	strne r0, [r4, #0x18]
	mov r0, #0x4d
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _021740D4
	ldr r0, _02174140 // =aBbSbBb
	mov r1, #0x1f
	mov r2, #0
	bl ReadFileFromBundle
	mov r6, r0
	mov r0, #0x4d
	bl GetObjectFileWork
	str r6, [r0]
_021740D4:
	mov r0, #0x4d
	bl GetObjectFileWork
	mov r1, #0
	ldr ip, _02174144 // =0x0000FFFF
	mov r3, r0
	mov r0, r4
	mov r2, r1
	stmia sp, {r1, ip}
	bl ObjObjectAction2dBACLoad
	ldr r2, _02174148 // =0x0000041C
	mov r0, r4
	mov r1, #0
	bl ObjActionAllocSpritePalette
	ldr r3, [r4, #0x128]
	mov r0, r4
	ldr r2, [r3, #0x3c]
	mov r1, r5
	bic r2, r2, #0x10
	str r2, [r3, #0x3c]
	bl StageTask__SetAnimation
	ldr r1, _0217414C // =SailCharacterPortrait__Last
	mov r0, r4
	str r1, [r4, #0x10c]
	bl SailBoatWeaponIconHUD__SetupObject
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02174140: .word aBbSbBb
_02174144: .word 0x0000FFFF
_02174148: .word 0x0000041C
_0217414C: .word SailCharacterPortrait__Last
	arm_func_end SailJetBoostHUD__Create

	arm_func_start SailHoverChargeHUD__Create
SailHoverChargeHUD__Create: // 0x02174150
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r7, r1
	mov r6, r2
	bl SailManager__GetWork
	mov r5, r0
	mov r0, #0xcd
	mov r1, #2
	bl CreateStageTaskEx_
	mov r1, r4
	mov r2, #0x400
	mov r4, r0
	bl StageTask__SetParent
	mov r0, r7, lsl #0xc
	str r0, [r4, #0x68]
	mov r0, r6, lsl #0xc
	str r0, [r4, #0x6c]
	ldr r0, [r5, #0x24]
	tst r0, #0x1000
	ldrne r0, [r4, #0x18]
	bicne r0, r0, #0x800000
	strne r0, [r4, #0x18]
	mov r0, #0x4e
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _021741E0
	ldr r0, _0217424C // =aBbSbBb
	mov r1, #0x21
	mov r2, #0
	bl ReadFileFromBundle
	mov r5, r0
	mov r0, #0x4e
	bl GetObjectFileWork
	str r5, [r0]
_021741E0:
	mov r0, #0x4e
	bl GetObjectFileWork
	mov r1, #0
	ldr ip, _02174250 // =0x0000FFFF
	mov r3, r0
	mov r0, r4
	mov r2, r1
	stmia sp, {r1, ip}
	bl ObjObjectAction2dBACLoad
	ldr r2, _02174254 // =0x0000041D
	mov r0, r4
	mov r1, #0
	bl ObjActionAllocSpritePalette
	ldr r3, [r4, #0x128]
	mov r0, r4
	ldr r2, [r3, #0x3c]
	mov r1, #0
	bic r2, r2, #0x10
	str r2, [r3, #0x3c]
	bl StageTask__SetAnimation
	ldr r1, _02174258 // =SailCharacterPortrait__Last
	mov r0, r4
	str r1, [r4, #0x10c]
	bl SailBoatWeaponIconHUD__SetupObject
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0217424C: .word aBbSbBb
_02174250: .word 0x0000FFFF
_02174254: .word 0x0000041D
_02174258: .word SailCharacterPortrait__Last
	arm_func_end SailHoverChargeHUD__Create

	arm_func_start SailSubReticleHUD__Create
SailSubReticleHUD__Create: // 0x0217425C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r5, r1
	mov r8, r2
	mov r7, r3
	bl SailManager__GetWork
	mov r6, r0
	mov r0, #0xcd
	mov r1, #2
	bl CreateStageTaskEx_
	mov r1, r4
	mov r2, #0x400
	mov r4, r0
	bl StageTask__SetParent
	mov r0, r8, lsl #0xc
	str r0, [r4, #0x68]
	mov r0, r7, lsl #0xc
	str r0, [r4, #0x6c]
	ldr r0, [r6, #0x24]
	tst r0, #0x1000
	ldrne r0, [r4, #0x18]
	bicne r0, r0, #0x800000
	strne r0, [r4, #0x18]
	mov r0, #0x4f
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _021742F0
	ldr r0, _0217435C // =aBbSbBb
	mov r1, #0x22
	mov r2, #0
	bl ReadFileFromBundle
	mov r6, r0
	mov r0, #0x4f
	bl GetObjectFileWork
	str r6, [r0]
_021742F0:
	mov r0, #0x4f
	bl GetObjectFileWork
	mov r1, #0
	ldr ip, _02174360 // =0x0000FFFF
	mov r3, r0
	mov r0, r4
	mov r2, r1
	stmia sp, {r1, ip}
	bl ObjObjectAction2dBACLoad
	ldr r2, _02174364 // =0x0000041E
	mov r0, r4
	mov r1, #0
	bl ObjActionAllocSpritePalette
	ldr r3, [r4, #0x128]
	mov r0, r4
	ldr r2, [r3, #0x3c]
	mov r1, r5
	bic r2, r2, #0x10
	str r2, [r3, #0x3c]
	bl StageTask__SetAnimation
	ldr r1, _02174368 // =SailCharacterPortrait__Last
	mov r0, r4
	str r1, [r4, #0x10c]
	bl SailBoatWeaponIconHUD__SetupObject
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0217435C: .word aBbSbBb
_02174360: .word 0x0000FFFF
_02174364: .word 0x0000041E
_02174368: .word SailCharacterPortrait__Last
	arm_func_end SailSubReticleHUD__Create

	arm_func_start SailHUD__Create
SailHUD__Create: // 0x0217436C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r0, #0x4800
	str r0, [sp]
	mov r0, #3
	str r0, [sp, #4]
	ldr r4, _021744D4 // =0x00002E1C
	ldr r0, _021744D8 // =SailHUD__Main
	ldr r1, _021744DC // =SailHUD__Destructor
	mov r2, #0
	mov r3, #1
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _021744D4 // =0x00002E1C
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	bl SailManager__GetShipType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02174414
_021743C8: // jump table
	b _021743D8 // case 0
	b _021743E8 // case 1
	b _021743F8 // case 2
	b _02174408 // case 3
_021743D8:
	ldr r0, [r4, #0]
	orr r0, r0, #0x40
	str r0, [r4]
	b _02174414
_021743E8:
	ldr r0, [r4, #0]
	orr r0, r0, #0xa0
	str r0, [r4]
	b _02174414
_021743F8:
	ldr r0, [r4, #0]
	orr r0, r0, #0x1c0
	str r0, [r4]
	b _02174414
_02174408:
	ldr r0, [r4, #0]
	orr r0, r0, #0x4e0
	str r0, [r4]
_02174414:
	mov r0, r4
	bl SailHUD__InitCommonSprites
	mov r0, r4
	bl SailHUD__InitBoatSprites
	mov r0, r4
	bl SailHUD__InitSubmarineSprites
	mov r1, #0x100000
	mov r0, r1, asr #1
	str r1, [r4, #0x1c]
	str r0, [r4, #0x20]
	mov r0, r0, asr #1
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x1c]
	mov r1, #0x20000
	bl FX_Div
	mov r2, r0, asr #0xc
	mov r0, #0x120000
	mov r1, #0x20000
	strh r2, [r4, #0x2c]
	bl FX_Div
	mov r1, r0, asr #0xc
	mov r2, #0x30000
	ldr r0, _021744E0 // =0x0000FFFF
	strh r1, [r4, #0x2e]
	strh r0, [r4, #0x34]
	sub r0, r0, #0x10000
	str r0, [r4, #0x8c]
	str r0, [r4, #0x7c]
	ldr r0, [r4, #0]
	mov r3, #0
	orr r0, r0, #2
	str r0, [r4]
	rsb r2, r2, #0
_02174498:
	add r0, r4, r3, lsl #3
	add r0, r0, #0x2000
	str r2, [r0, #0xb00]
	cmp r3, #0xb
	ldrhs r1, [r0, #0xb00]
	rsbhs r1, r1, #0
	strhs r1, [r0, #0xb00]
	add r0, r3, #1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	cmp r3, #0x64
	blo _02174498
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021744D4: .word 0x00002E1C
_021744D8: .word SailHUD__Main
_021744DC: .word SailHUD__Destructor
_021744E0: .word 0x0000FFFF
	arm_func_end SailHUD__Create

	arm_func_start SailBoatWeaponHUD__Create
SailBoatWeaponHUD__Create: // 0x021744E4
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x1c
	mov r6, r0
	ldr r4, [r6, #0x124]
	ldr r0, [r4, #0x11c]
	cmp r0, #0
	ble _0217450C
	ldr r0, [r4, #0x120]
	cmp r0, #0
	bne _02174518
_0217450C:
	add sp, sp, #0x1c
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, pc}
_02174518:
	mov r0, #0x4800
	str r0, [sp]
	mov r2, #3
	str r2, [sp, #4]
	mov r5, #0x1a0
	ldr r0, _0217478C // =SailBoatWeaponHUD__Main
	ldr r1, _02174790 // =SailBoatWeaponHUD__Destructor
	mov r2, #0
	mov r3, #1
	str r5, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r5, r0
	mov r1, r5
	mov r0, #0
	mov r2, #0x1a0
	bl MIi_CpuClear16
	str r6, [r5]
	ldr r0, [r4, #0x120]
	mov r1, #0x20000
	bl FX_Div
	str r0, [r5, #8]
	mov r0, #0
	str r0, [r5, #0xc]
	bl SailManager__GetShipType
	cmp r0, #2
	moveq r0, #0x1000
	streq r0, [r5, #0xc]
	mov r0, #0x42
	bl GetObjectFileWork
	mov r4, r0
	bl SailManager__GetArchive
	mov r2, r0
	ldr r1, _02174794 // =aSbSilFixBac
	mov r0, r4
	bl ObjDataLoad
	mov r1, #0x15
	mov r4, r0
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r1, _02174798 // =0x05000200
	mov r0, #1
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r5, #0x10
	mov r1, r4
	mov r2, #0x15
	mov r3, #0x10
	bl AnimatorSprite__Init
	ldr r2, _0217479C // =0x00000413
	mov r0, r4
	mov r1, #0x15
	bl ObjDrawAllocSpritePalette
	mov r1, #0
	strh r0, [r5, #0x60]
	add r0, r5, #0x10
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	mov r1, #0x1d
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r1, _02174798 // =0x05000200
	mov r0, #1
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r5, #0x74
	mov r1, r4
	mov r2, #0x1d
	mov r3, #0x10
	bl AnimatorSprite__Init
	mov r1, #0x1d
	mov r0, r4
	rsb r2, r1, #0x430
	bl ObjDrawAllocSpritePalette
	mov r1, #0
	strh r0, [r5, #0xc4]
	mov r2, r1
	add r0, r5, #0x74
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	mov r1, #0x15
	add r6, r5, #0xd8
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r1, _02174798 // =0x05000200
	mov r0, #1
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r6
	mov r1, r4
	mov r2, #0x15
	mov r3, #0x10
	bl AnimatorSprite__Init
	mov r0, r4
	mov r1, #0x15
	ldr r2, _0217479C // =0x00000413
	bl ObjDrawAllocSpritePalette
	strh r0, [r6, #0x50]
	add r6, r5, #0x13c
	mov r0, r4
	mov r1, #0x14
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r1, _02174798 // =0x05000200
	mov r0, #1
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r6
	mov r1, r4
	mov r2, #0x14
	mov r3, #0x10
	bl AnimatorSprite__Init
	mov r0, r4
	mov r1, #0x14
	ldr r2, _0217479C // =0x00000413
	bl ObjDrawAllocSpritePalette
	strh r0, [r6, #0x50]
	mov r0, r6
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0217478C: .word SailBoatWeaponHUD__Main
_02174790: .word SailBoatWeaponHUD__Destructor
_02174794: .word aSbSilFixBac
_02174798: .word 0x05000200
_0217479C: .word 0x00000413
	arm_func_end SailBoatWeaponHUD__Create

	arm_func_start SailScoreBonus__CreateWorld
SailScoreBonus__CreateWorld: // 0x021747A0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r3, #0x4800
	mov r7, r0
	mov r6, r1
	str r3, [sp]
	mov r3, #3
	str r3, [sp, #4]
	mov r4, #0x10
	ldr r0, _02174888 // =SailScoreBonus__Main
	mov r1, #0
	mov r5, r2
	mov r2, r1
	mov r3, #1
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	ldr r2, _0217488C // =0x00002710
	mov r1, r6
	add r0, r4, #0xc
	bl SailHUD__GetScore
	mov r0, r7
	add r1, sp, #0x10
	add r2, sp, #0xc
	bl NNS_G3dWorldPosToScrPos
	ldr r0, [sp, #0x10]
	cmp r5, #0
	strh r0, [r4]
	ldr r0, [sp, #0xc]
	ldr r3, _02174890 // =_obj_disp_rand
	strh r0, [r4, #2]
	strneh r5, [r4, #8]
	moveq r0, #1
	streqh r0, [r4, #8]
	mov r0, #4
	strh r0, [r4, #6]
	mov r0, #0x20
	strh r0, [r4, #4]
	ldr ip, [r3]
	ldr r1, _02174894 // =0x00196225
	ldr r2, _02174898 // =0x3C6EF35F
	mov r0, r4
	mla r1, ip, r1, r2
	str r1, [r3]
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	ldrh r2, [r4, #4]
	and r1, r1, #7
	add r1, r2, r1
	strh r1, [r4, #4]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02174888: .word SailScoreBonus__Main
_0217488C: .word 0x00002710
_02174890: .word _obj_disp_rand
_02174894: .word 0x00196225
_02174898: .word 0x3C6EF35F
	arm_func_end SailScoreBonus__CreateWorld

	arm_func_start SailScoreBonus__CreateScreen
SailScoreBonus__CreateScreen: // 0x0217489C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r4, #0x4800
	mov r6, r0
	mov r5, r1
	mov r7, r3
	str r4, [sp]
	mov r3, #3
	str r3, [sp, #4]
	mov r4, #0x10
	ldr r0, _02174970 // =SailScoreBonus__Main
	mov r1, #0
	mov r8, r2
	mov r2, r1
	mov r3, #1
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x10
	bl MIi_CpuClear16
	ldr r2, _02174974 // =0x00002710
	mov r1, r8
	add r0, r4, #0xc
	bl SailHUD__GetScore
	strh r6, [r4]
	cmp r7, #0
	strh r5, [r4, #2]
	strneh r7, [r4, #8]
	moveq r0, #1
	streqh r0, [r4, #8]
	mov r0, #4
	strh r0, [r4, #6]
	mov r0, #0x20
	strh r0, [r4, #4]
	ldr r3, _02174978 // =_obj_disp_rand
	ldr r1, _0217497C // =0x00196225
	ldr r5, [r3, #0]
	ldr r2, _02174980 // =0x3C6EF35F
	mov r0, r4
	mla r1, r5, r1, r2
	str r1, [r3]
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	ldrh r2, [r4, #4]
	and r1, r1, #7
	add r1, r2, r1
	strh r1, [r4, #4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02174970: .word SailScoreBonus__Main
_02174974: .word 0x00002710
_02174978: .word _obj_disp_rand
_0217497C: .word 0x00196225
_02174980: .word 0x3C6EF35F
	arm_func_end SailScoreBonus__CreateScreen

	arm_func_start SailHUD__GetScore
SailHUD__GetScore: // 0x02174984
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r1
	mov r6, r2
	mov r4, r0
	cmp r7, r6
	mov r5, #0
	blo _021749AC
	cmp r6, #0
	moveq r7, r5
	subne r7, r6, #1
_021749AC:
	mov r0, #0
	str r0, [r4]
	cmp r6, #0x64
	blo _02174A24
	mov r0, r6
	mov r1, #0xa
	bl FX_DivS32
	mov r6, r0
	mov r5, #0
	mov r8, #0xa
_021749D4:
	cmp r7, r6
	blo _021749FC
	mov r0, r7
	mov r1, r6
	bl FX_DivS32
	mul r1, r0, r6
	ldr r2, [r4, #0]
	sub r7, r7, r1
	orr r0, r2, r0, lsl r5
	str r0, [r4]
_021749FC:
	add r0, r5, #4
	mov r0, r0, lsl #0x10
	cmp r6, #0xa
	mov r5, r0, asr #0x10
	bls _02174A24
	mov r0, r6
	mov r1, r8
	bl FX_DivS32
	mov r6, r0
	b _021749D4
_02174A24:
	ldr r0, [r4, #0]
	mov r3, r5
	orr r0, r0, r7, lsl r5
	str r0, [r4]
	cmp r5, r5, asr #1
	mov r2, r5, asr #1
	ldmltia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0xf
_02174A44:
	ldr r8, [r4, #0]
	sub r1, r3, r5
	and r6, r8, r0, lsl r5
	and ip, r8, r0, lsl r1
	mov lr, r0, lsl r5
	mov r7, r6, lsr r5
	orr r6, lr, r0, lsl r1
	mov ip, ip, lsr r1
	mov r1, r7, lsl r1
	mvn r6, r6
	and lr, r8, r6
	orr r1, r1, ip, lsl r5
	sub r6, r5, #4
	mov r6, r6, lsl #0x10
	orr r1, lr, r1
	str r1, [r4]
	cmp r2, r6, asr #16
	mov r5, r6, asr #0x10
	ble _02174A44
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end SailHUD__GetScore

	arm_func_start SailHUD__Func_2174A94
SailHUD__Func_2174A94: // 0x02174A94
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r7, r3
	bl SailManager__GetWork
	ldrh r1, [sp, #0x28]
	ldr r0, [r0, #0xa4]
	cmp r1, #4
	beq _02174AEC
	cmp r1, #5
	beq _02174B28
	cmp r1, #6
	beq _02174B64
	mov r1, r6
	mov r2, r5
	mov r3, r4
	str r7, [sp]
	bl SailHUD__Func_2177B80
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
_02174AEC:
	str r7, [sp]
	mov r1, #0x4c
	str r1, [sp, #4]
	mov r1, #0xa
	str r1, [sp, #8]
	mov ip, #6
	mov r3, r4
	mov r1, r6
	mov r2, r5
	str ip, [sp, #0xc]
	mov r4, #0
	str r4, [sp, #0x10]
	bl SailHUD__Func_2177C10
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
_02174B28:
	str r7, [sp]
	mov r1, #0x40
	str r1, [sp, #4]
	mov r1, #8
	str r1, [sp, #8]
	mov r1, #5
	str r1, [sp, #0xc]
	ldr ip, _02174BA0 // =0x0000040A
	mov r1, r6
	mov r2, r5
	mov r3, r4
	str ip, [sp, #0x10]
	bl SailHUD__Func_2177C10
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
_02174B64:
	str r7, [sp]
	mov r1, #0x40
	mov ip, #5
	str r1, [sp, #4]
	mov r1, #8
	str r1, [sp, #8]
	mov r1, r6
	mov r2, r5
	mov r3, r4
	str ip, [sp, #0xc]
	rsb r4, ip, #0x410
	str r4, [sp, #0x10]
	bl SailHUD__Func_2177C10
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02174BA0: .word 0x0000040A
	arm_func_end SailHUD__Func_2174A94

	arm_func_start SailHUD__Func_2174BA4
SailHUD__Func_2174BA4: // 0x02174BA4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r1, [r0, #0xa4]
	cmp r4, #0
	ldr r0, [r1, #0]
	bicne r0, r0, #0x200
	orreq r0, r0, #0x200
	str r0, [r1]
	ldmia sp!, {r4, pc}
	arm_func_end SailHUD__Func_2174BA4

	arm_func_start SailHUD__Destructor
SailHUD__Destructor: // 0x02174BCC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r4, r0
	bl GetCurrentTaskWork_
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x26
	bl GetObjectFileWork
	bl ObjDataRelease
	mov r0, #0x27
	bl GetObjectFileWork
	bl ObjDataRelease
	ldr r0, [r4, #0]
	tst r0, #0x40
	bne _02174C20
	mov r0, #0x42
	bl GetObjectFileWork
	bl ObjDataRelease
	mov r0, #0x43
	bl GetObjectFileWork
	bl ObjDataRelease
_02174C20:
	ldr r0, [r4, #0]
	tst r0, #0x400
	beq _02174C38
	mov r0, #0x59
	bl GetObjectFileWork
	bl ObjDataRelease
_02174C38:
	mov r7, #0
	add r6, r4, #0x94
	mov r5, r7
	mov r4, r7
	mov r8, #0x64
_02174C4C:
	mla r9, r7, r8, r6
	ldr r1, [r9, #0x44]
	cmp r1, #0
	beq _02174C74
	mov r0, r5
	bl VRAMSystem__FreeSpriteVram
	str r4, [r9, #0x44]
	ldrh r0, [r9, #0x50]
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
_02174C74:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0x64
	blo _02174C4C
	ldr r0, _02174C9C // =0x0000040A
	bl ObjDrawReleaseSprite
	ldr r0, _02174CA0 // =0x0000040B
	bl ObjDrawReleaseSprite
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02174C9C: .word 0x0000040A
_02174CA0: .word 0x0000040B
	arm_func_end SailHUD__Destructor

	arm_func_start SailHUD__Main
SailHUD__Main: // 0x02174CA4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailManager__GetWork
	mov r0, r4
	bl SailHUD__Func_2175A58
	mov r0, r4
	bl SailHUD__Func_21764A8
	mov r0, r4
	bl SailHUD__Func_2175FA4
	mov r0, r4
	bl SailHUD__Func_2176578
	ldrh r0, [r4, #4]
	add r0, r0, #1
	strh r0, [r4, #4]
	ldmia sp!, {r4, pc}
	arm_func_end SailHUD__Main

	arm_func_start SailHUD__InitAnimator
SailHUD__InitAnimator: // 0x02174CE4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x1c
	mov r8, r0
	mov r5, r3
	mov r6, r2
	mov r7, r1
	mov r0, r5
	mov r1, r6
	add r3, r8, #0x94
	mov r2, #0x64
	mla r4, r7, r2, r3
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r1, _02174D94 // =0x05000200
	ldrb r0, [sp, #0x38]
	str r1, [sp, #0x10]
	ldrb r1, [sp, #0x3c]
	str r0, [sp, #0x14]
	mov r0, r4
	str r1, [sp, #0x18]
	mov r1, r5
	mov r2, r6
	mov r3, #0x10
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, r6
	ldrsh r2, [sp, #0x40]
	bl ObjDrawAllocSpritePalette
	strh r0, [r4, #0x50]
	add r0, r8, r7, lsl #3
	add r0, r0, #0x2000
	ldr r2, [sp, #0x44]
	ldr r1, [sp, #0x48]
	str r2, [r0, #0x7dc]
	str r1, [r0, #0x7e0]
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02174D94: .word 0x05000200
	arm_func_end SailHUD__InitAnimator

	arm_func_start SailHUD__InitCommonSprites
SailHUD__InitCommonSprites: // 0x02174D98
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r10, r0
	mov r0, #0x26
	bl GetObjectFileWork
	mov r4, r0
	bl SailManager__GetArchive
	mov r2, r0
	ldr r1, _02175490 // =aSbFixBac
	mov r0, r4
	bl ObjDataLoad
	mov r4, r0
	bl SailManager__GetShipType
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, #1
	str r0, [sp]
	str r0, [sp, #4]
	ldr r1, _02175494 // =0x00000402
	mov r0, #0x2000
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, r10
	mov r1, #0
	mov r3, r4
	bl SailHUD__InitAnimator
	mov r0, #1
	str r0, [sp]
	str r0, [sp, #4]
	ldr r1, _02175498 // =0x00000404
	mov r0, #0xa6000
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, #0x4000
	str r0, [sp, #0x10]
	mov r0, r10
	mov r1, #8
	mov r2, #4
	mov r3, r4
	bl SailHUD__InitAnimator
	ldr r0, [r10, #0]
	tst r0, #0x20
	bne _02174E80
	mov r1, #1
	str r1, [sp]
	mov r2, #2
	ldr r0, _02175498 // =0x00000404
	str r2, [sp, #4]
	str r0, [sp, #8]
	mov r2, #0xa6000
	mov r0, r10
	mov r3, r4
	str r2, [sp, #0xc]
	mov r5, #0xd000
	mov r2, #0x12
	str r5, [sp, #0x10]
	bl SailHUD__InitAnimator
_02174E80:
	mov r0, #1
	str r0, [sp]
	mov r1, #3
	str r1, [sp, #4]
	ldr r0, _0217549C // =0x00000405
	mov r5, #0
	str r0, [sp, #8]
	str r5, [sp, #0xc]
	mov r0, r10
	mov r3, r4
	mov r1, #2
	mov r2, #0x1c
	str r5, [sp, #0x10]
	bl SailHUD__InitAnimator
	bl SailManager__GetShipType
	cmp r0, #0
	subeq r5, r5, #0xc000
	mov r0, #1
	str r0, [sp]
	mov r1, #3
	ldr r0, _0217549C // =0x00000405
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r5, [sp, #0xc]
	mov r5, #0
	mov r0, r10
	mov r3, r4
	mov r2, #0x1d
	str r5, [sp, #0x10]
	bl SailHUD__InitAnimator
	mov r0, #1
	str r0, [sp]
	mov r1, #2
	str r1, [sp, #4]
	ldr r0, _021754A0 // =0x00000403
	mov r1, #0x24000
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r5, #0xf000
	mov r0, r10
	mov r3, r4
	mov r1, #4
	mov r2, #6
	str r5, [sp, #0x10]
	bl SailHUD__InitAnimator
	mov r0, #1
	str r0, [sp]
	mov r1, #2
	str r1, [sp, #4]
	ldr r0, _021754A0 // =0x00000403
	mov r1, #0x2c000
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r2, r5
	str r2, [sp, #0x10]
	mov r0, r10
	mov r3, r4
	mov r1, #5
	mov r2, #7
	bl SailHUD__InitAnimator
	mov r0, #1
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	ldr r1, _021754A0 // =0x00000403
	mov r0, #0x2c000
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, #0x10000
	str r0, [sp, #0x10]
	mov r0, r10
	mov r1, #6
	mov r2, #8
	mov r3, r4
	bl SailHUD__InitAnimator
	mov r1, #0
	add r0, r10, #0x2ec
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r10, #0x328]
	mov r0, #0x2000
	orr r1, r1, #4
	str r1, [r10, #0x328]
	str r0, [r10, #0x324]
	mov r0, #1
	str r0, [sp]
	str r0, [sp, #4]
	ldr r1, _021754A0 // =0x00000403
	mov r0, #0x2c000
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, #0x10000
	str r0, [sp, #0x10]
	mov r0, r10
	mov r1, #7
	mov r2, #0xb
	mov r3, r4
	bl SailHUD__InitAnimator
	ldr r0, [r10, #0]
	tst r0, #0x20
	bne _02175084
	mov r1, #1
	str r1, [sp]
	str r1, [sp, #4]
	ldr r0, _02175498 // =0x00000404
	mov r1, #0xaf000
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r5, #0xd000
	mov r0, r10
	mov r3, r4
	mov r1, #9
	mov r2, #0x13
	str r5, [sp, #0x10]
	bl SailHUD__InitAnimator
	mov r1, #1
	str r1, [sp]
	str r1, [sp, #4]
	ldr r0, _02175498 // =0x00000404
	mov r3, r4
	str r0, [sp, #8]
	mov r1, #0xaf000
	str r1, [sp, #0xc]
	mov r4, r5
	mov r0, r10
	mov r1, #0xa
	mov r2, #0x13
	str r4, [sp, #0x10]
	bl SailHUD__InitAnimator
_02175084:
	mov r0, #0x27
	bl GetObjectFileWork
	mov r4, r0
	bl SailManager__GetArchive
	mov r2, r0
	ldr r1, _021754A4 // =aSbNumberBac
	mov r0, r4
	bl ObjDataLoad
	mov r7, #0
	ldr r11, _021754A8 // =0x05000200
	mov r8, r0
	add r5, r10, #0x94
	mov r4, r7
_021750B8:
	add r0, r7, #0xb
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	add r1, r7, #0x30
	mov r0, #0x64
	mla r9, r1, r0, r5
	mov r0, r8
	mov r1, r6
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	str r4, [sp]
	str r4, [sp, #4]
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r11, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, r9
	mov r1, r8
	mov r2, r6
	mov r3, #0x10
	str r4, [sp, #0x18]
	bl AnimatorSprite__Init
	ldr r2, _021754AC // =0x00000406
	mov r1, r6
	mov r0, r8
	bl ObjDrawAllocSpritePalette
	mov r1, #0
	strh r0, [r9, #0x50]
	mov r0, r9
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0xa
	bls _021750B8
	mov r9, #0
	ldr r4, _021754A8 // =0x05000200
	add r6, r10, #0x94
	mov r5, r9
	mov r11, #1
_02175168:
	add r1, r9, #0x3b
	mov r0, #0x64
	mla r7, r1, r0, r6
	mov r0, r8
	mov r1, #0
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	str r5, [sp]
	str r5, [sp, #4]
	str r0, [sp, #8]
	str r5, [sp, #0xc]
	str r4, [sp, #0x10]
	str r11, [sp, #0x14]
	mov r0, r7
	mov r1, r8
	mov r2, r5
	mov r3, #0x810
	str r11, [sp, #0x18]
	bl AnimatorSprite__Init
	ldr r2, _021754AC // =0x00000406
	mov r0, r8
	mov r1, #0
	bl ObjDrawAllocSpritePalette
	strh r0, [r7, #0x50]
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #3
	bls _02175168
	add r2, r10, #0x930
	mov r0, r8
	mov r1, #0xa
	add r4, r2, #0x1000
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, _021754A8 // =0x05000200
	mov r2, #1
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r0, r4
	mov r1, r8
	mov r2, #0xa
	mov r3, #0x10
	bl AnimatorSprite__Init
	mov r1, #0xa
	mov r0, r8
	add r2, r1, #0x3fc
	bl ObjDrawAllocSpritePalette
	mov r1, #0
	strh r0, [r4, #0x50]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r7, #0
	ldr r11, _021754A8 // =0x05000200
	add r5, r10, #0x94
	mov r4, r7
_02175274:
	add r0, r7, #0x16
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	add r1, r7, #0x40
	mov r0, #0x64
	mla r6, r1, r0, r5
	mov r0, r8
	mov r1, r9
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	str r4, [sp]
	str r4, [sp, #4]
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r11, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r6
	mov r1, r8
	mov r2, r9
	mov r3, #0x10
	bl AnimatorSprite__Init
	ldr r2, _021754AC // =0x00000406
	mov r1, r9
	mov r0, r8
	bl ObjDrawAllocSpritePalette
	mov r1, #0
	strh r0, [r6, #0x50]
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0xb
	bls _02175274
	mov r7, #0
	ldr r11, _021754A8 // =0x05000200
	add r5, r10, #0x94
	mov r4, r7
_02175320:
	add r0, r7, #0x24
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	add r1, r7, #0x4c
	mov r0, #0x64
	mla r6, r1, r0, r5
	mov r0, r8
	mov r1, r9
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	str r4, [sp]
	str r4, [sp, #4]
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r11, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r6
	mov r1, r8
	mov r2, r9
	mov r3, #0x10
	bl AnimatorSprite__Init
	ldr r2, _021754B0 // =0x00000407
	mov r1, r9
	mov r0, r8
	bl ObjDrawAllocSpritePalette
	mov r1, #0
	strh r0, [r6, #0x50]
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0xb
	bls _02175320
	mov r9, #0
	ldr r4, _021754A8 // =0x05000200
	add r6, r10, #0x94
	mov r5, r9
	mov r11, #1
_021753D0:
	add r0, r9, #0x30
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
	add r2, r9, #0x58
	mov r1, #0x64
	mla r7, r2, r1, r6
	mov r0, r8
	mov r1, r10
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	str r5, [sp]
	str r5, [sp, #4]
	str r0, [sp, #8]
	str r5, [sp, #0xc]
	str r4, [sp, #0x10]
	str r11, [sp, #0x14]
	mov r0, r7
	mov r1, r8
	mov r2, r10
	mov r3, #0x10
	str r11, [sp, #0x18]
	bl AnimatorSprite__Init
	ldr r2, _021754AC // =0x00000406
	mov r1, r10
	mov r0, r8
	bl ObjDrawAllocSpritePalette
	mov r1, #0
	strh r0, [r7, #0x50]
	mov r0, r7
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #0xb
	bls _021753D0
	mov r1, #0x22
	mov r0, r8
	add r2, r1, #0x3e8
	bl ObjDrawAllocSpritePalette
	mov r1, #0x23
	mov r0, r8
	add r2, r1, #0x3e8
	bl ObjDrawAllocSpritePalette
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02175490: .word aSbFixBac
_02175494: .word 0x00000402
_02175498: .word 0x00000404
_0217549C: .word 0x00000405
_021754A0: .word 0x00000403
_021754A4: .word aSbNumberBac
_021754A8: .word 0x05000200
_021754AC: .word 0x00000406
_021754B0: .word 0x00000407
	arm_func_end SailHUD__InitCommonSprites

	arm_func_start SailHUD__InitBoatSprites
SailHUD__InitBoatSprites: // 0x021754B4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r10, r0
	ldr r0, [r10, #0]
	tst r0, #0x40
	addne sp, sp, #0x1c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #0x42
	bl GetObjectFileWork
	mov r4, r0
	bl SailManager__GetArchive
	mov r2, r0
	ldr r1, _02175960 // =aSbSilFixBac
	mov r0, r4
	bl ObjDataLoad
	ldr r5, _02175964 // =0x00000414
	mov r7, r0
	mov r8, #0
	add r4, r10, #0x94
	mov r6, #1
	mov r11, #0xa8000
_02175508:
	mov r0, #0x3a000
	mul r0, r8, r0
	str r6, [sp]
	str r6, [sp, #4]
	add r9, r8, #0xb
	mov r1, r9, lsl #0x10
	str r5, [sp, #8]
	add r0, r0, #0x2a000
	str r0, [sp, #0xc]
	mov r0, r10
	mov r2, #0
	mov r1, r1, lsr #0x10
	mov r3, r7
	str r11, [sp, #0x10]
	bl SailHUD__InitAnimator
	mov r0, #0x64
	mla r2, r9, r0, r4
	add r0, r8, #1
	ldr r1, [r2, #0x3c]
	mov r0, r0, lsl #0x10
	orr r1, r1, #0x800
	mov r8, r0, lsr #0x10
	str r1, [r2, #0x3c]
	cmp r8, #3
	blo _02175508
	mov r1, #1
	str r1, [sp]
	str r1, [sp, #4]
	ldr r0, _02175968 // =0x00000416
	mov r1, #0x2a000
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r4, #0xa8000
	mov r0, r10
	mov r3, r7
	mov r1, #0x20
	mov r2, #0x13
	str r4, [sp, #0x10]
	bl SailHUD__InitAnimator
	ldr r6, _0217596C // =0x00000415
	mov r9, #0
	mov r8, #1
	mov r5, #0xab000
	mov r11, #2
	mov r4, #0x7000
_021755BC:
	mul r2, r9, r4
	str r8, [sp]
	str r8, [sp, #4]
	add r0, r9, #0x11
	mov r1, r0, lsl #0x10
	str r6, [sp, #8]
	add r0, r2, #0x31000
	str r0, [sp, #0xc]
	mov r0, r10
	mov r2, r11
	mov r3, r7
	mov r1, r1, lsr #0x10
	str r5, [sp, #0x10]
	bl SailHUD__InitAnimator
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #6
	bls _021755BC
	add r0, r10, #0x2000
	mov r1, #0x31000
	str r1, [r0, #0x894]
	mov r1, #1
	str r1, [sp]
	str r1, [sp, #4]
	ldr r0, _0217596C // =0x00000415
	mov r1, #0x2d000
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r4, #0xab000
	mov r0, r10
	mov r3, r7
	mov r1, #0x18
	mov r2, #4
	str r4, [sp, #0x10]
	bl SailHUD__InitAnimator
	ldr r5, _0217596C // =0x00000415
	mov r9, #0
	mov r6, #1
	mov r4, #0xac000
	mov r11, #0x2000
_02175660:
	str r6, [sp]
	str r6, [sp, #4]
	add r8, r9, #0x19
	mov r0, r9, lsl #0x10
	mov r1, r8, lsl #0x10
	str r5, [sp, #8]
	add r0, r0, #0x68000
	str r0, [sp, #0xc]
	mov r0, r10
	mov r2, #5
	mov r3, r7
	mov r1, r1, lsr #0x10
	str r4, [sp, #0x10]
	bl SailHUD__InitAnimator
	mov r0, #0x64
	mla r1, r8, r0, r10
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	str r11, [r1, #0xcc]
	cmp r9, #2
	bls _02175660
	mov r1, #1
	str r1, [sp]
	str r1, [sp, #4]
	ldr r0, _0217596C // =0x00000415
	mov r1, #0xa4000
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r4, #0xac000
	mov r0, r10
	mov r3, r7
	mov r1, #0x1c
	mov r2, #7
	str r4, [sp, #0x10]
	bl SailHUD__InitAnimator
	mov r1, #1
	str r1, [sp]
	str r1, [sp, #4]
	ldr r0, _02175970 // =0x00000413
	mov r1, #0xb7000
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, r10
	mov r3, r7
	mov r1, #0x1d
	mov r2, #0xa
	str r4, [sp, #0x10]
	bl SailHUD__InitAnimator
	add r0, r10, #0x3e8
	ldr r2, [r0, #0x83c]
	mov r1, #1
	orr r2, r2, #4
	str r2, [r0, #0x83c]
	str r1, [sp]
	str r1, [sp, #4]
	ldr r0, _02175970 // =0x00000413
	mov r1, #0xb6000
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r2, r4
	str r2, [sp, #0x10]
	mov r0, r10
	mov r3, r7
	mov r1, #0x1e
	mov r2, #9
	bl SailHUD__InitAnimator
	mov r0, r7
	mov r1, #0xb
	add r4, r10, #0xcb0
	bl Sprite__GetSpriteSize2FromAnim
	add r1, r0, r0, lsl #1
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r1, _02175974 // =0x05000200
	mov r0, #1
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r4
	mov r1, r7
	mov r2, #0xb
	mov r3, #0x10
	bl AnimatorSprite__Init
	ldr r2, _02175970 // =0x00000413
	mov r0, r7
	mov r1, #0xb
	bl ObjDrawAllocSpritePalette
	strh r0, [r4, #0x50]
	add r0, r10, #0x2000
	mov r1, #0xb7000
	str r1, [r0, #0x8d4]
	mov r1, #0xac000
	str r1, [r0, #0x8d8]
	mov r1, #1
	str r1, [sp]
	str r1, [sp, #4]
	ldr r0, _02175968 // =0x00000416
	mov r1, #0x2a000
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r4, #0xa8000
	mov r0, r10
	mov r3, r7
	mov r1, #0x21
	mov r2, #0x1e
	str r4, [sp, #0x10]
	bl SailHUD__InitAnimator
	mov r1, #1
	str r1, [sp]
	str r1, [sp, #4]
	ldr r0, _02175968 // =0x00000416
	mov r1, #0x2a000
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, r10
	mov r3, r7
	mov r1, #0x22
	mov r2, #0x1f
	str r4, [sp, #0x10]
	bl SailHUD__InitAnimator
	ldr r5, _02175968 // =0x00000416
	mov r8, #0
	mov r6, #1
	mov r4, #0xaa000
_02175868:
	str r6, [sp]
	str r6, [sp, #4]
	mov r3, r8, lsl #3
	add r1, r8, #0x23
	add r0, r8, #0x20
	mov r1, r1, lsl #0x10
	mov r2, r0, lsl #0x10
	str r5, [sp, #8]
	add r0, r3, #0x2e000
	str r0, [sp, #0xc]
	mov r0, r10
	mov r3, r7
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
	str r4, [sp, #0x10]
	bl SailHUD__InitAnimator
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #0xa
	blo _02175868
	mov r0, #0x43
	bl GetObjectFileWork
	mov r4, r0
	bl SailManager__GetArchive
	mov r2, r0
	ldr r1, _02175978 // =aSbSilKeyBac
	mov r0, r4
	bl ObjDataLoad
	ldr r5, _0217596C // =0x00000415
	mov r8, r0
	mov r9, #0
	add r4, r10, #0x94
	mov r6, #1
	mov r11, #0xa8000
_021758F4:
	mov r0, #0x3a000
	mul r0, r9, r0
	str r6, [sp]
	str r6, [sp, #4]
	add r7, r9, #0xe
	mov r1, r7, lsl #0x10
	str r5, [sp, #8]
	add r0, r0, #0x2f000
	str r0, [sp, #0xc]
	mov r0, r10
	mov r2, r9
	mov r3, r8
	mov r1, r1, lsr #0x10
	str r11, [sp, #0x10]
	bl SailHUD__InitAnimator
	mov r0, #0x64
	mla r2, r7, r0, r4
	add r0, r9, #1
	ldr r1, [r2, #0x3c]
	mov r0, r0, lsl #0x10
	orr r1, r1, #0x800
	mov r9, r0, lsr #0x10
	str r1, [r2, #0x3c]
	cmp r9, #3
	blo _021758F4
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02175960: .word aSbSilFixBac
_02175964: .word 0x00000414
_02175968: .word 0x00000416
_0217596C: .word 0x00000415
_02175970: .word 0x00000413
_02175974: .word 0x05000200
_02175978: .word aSbSilKeyBac
	arm_func_end SailHUD__InitBoatSprites

	arm_func_start SailHUD__InitSubmarineSprites
SailHUD__InitSubmarineSprites: // 0x0217597C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r0, [r4, #0]
	tst r0, #0x400
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, pc}
	mov r0, #0x59
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	mov r2, r0
	ldr r1, _02175A4C // =aSbFixSubBpmBac
	mov r0, r5
	bl ObjDataLoad
	mov r5, r0
	mov r0, #1
	str r0, [sp]
	str r0, [sp, #4]
	ldr r1, _02175A50 // =0x0000040D
	mov r0, #0x10000
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, #0xac000
	str r0, [sp, #0x10]
	mov r0, r4
	mov r1, #0x2e
	mov r2, #0
	mov r3, r5
	bl SailHUD__InitAnimator
	add r0, r4, #0x28c
	add r2, r0, #0x1000
	ldr r1, [r2, #0x3c]
	mov r0, r4
	orr r1, r1, #4
	orr r1, r1, #0x2000
	str r1, [r2, #0x3c]
	mov ip, #0
	str ip, [r2, #0x38]
	mov r2, #1
	str r2, [sp]
	ldr r4, _02175A54 // =0x0000040E
	str r2, [sp, #4]
	str r4, [sp, #8]
	mov r1, #0x90000
	str ip, [sp, #0xc]
	str r1, [sp, #0x10]
	mov r3, r5
	mov r1, #0x2f
	bl SailHUD__InitAnimator
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02175A4C: .word aSbFixSubBpmBac
_02175A50: .word 0x0000040D
_02175A54: .word 0x0000040E
	arm_func_end SailHUD__InitSubmarineSprites

	arm_func_start SailHUD__Func_2175A58
SailHUD__Func_2175A58: // 0x02175A58
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	mov r8, #0
	str r0, [sp, #4]
	bl SailManager__GetWork
	mov r4, r0
	ldr r0, [sp, #4]
	cmp r0, #0
	ldrne r8, [r0, #0x124]
	cmp r8, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r10, #0x10]
	str r0, [r10, #0x14]
	ldr r0, [r8, #0x1b8]
	str r0, [r10, #0x10]
	ldr r0, [r10, #0]
	tst r0, #0x100
	ldrne r0, [r8, #0x1fc]
	ldreq r0, [r8, #0x1bc]
	str r0, [r10, #0x18]
	ldr r1, [r10, #0x10]
	ldr r0, [r10, #0x14]
	cmp r0, r1
	beq _02175ADC
	ble _02175ADC
	mov r0, #0x20
	strh r0, [r10, #0x30]
	mov r0, #0x10
	strh r0, [r10, #0x32]
_02175ADC:
	ldr r0, [r10, #0]
	tst r0, #1
	bne _02175B0C
	ldr r0, [r10, #0x10]
	str r0, [r10, #8]
	ldr r0, [r10, #0x10]
	str r0, [r10, #0x28]
	ldr r0, [r10, #0x18]
	str r0, [r10, #0xc]
	ldr r0, [r10, #0]
	orr r0, r0, #1
	str r0, [r10]
_02175B0C:
	add r0, r8, #0x100
	ldrh r1, [r0, #0xc4]
	add r0, r10, #0x78
	mov r2, #0x3e8
	bl SailHUD__GetScore
	ldr r1, [r8, #0x1a8]
	ldr r2, _02175FA0 // =0x05F5E100
	add r0, r10, #0x88
	bl SailHUD__GetScore
	ldr r0, [r10, #0]
	tst r0, #0x80
	bne _02175B48
	ldr r1, [r4, #0x20]
	add r0, r10, #0x90
	bl MultibootManager__Func_2063CF4
_02175B48:
	ldr r0, [r10, #0]
	tst r0, #0x40
	bne _02175F3C
	add r5, r8, #0x200
	ldrh r1, [r10, #0x34]
	ldrh r0, [r5, #0xe]
	cmp r1, r0
	beq _02175BEC
	mov r9, #0
	add r7, r10, #0x94
	mov r11, r9
	mov r6, #1
	mov r4, #0x64
_02175B7C:
	add r1, r9, #0xb
	mul r2, r1, r4
	ldrh r0, [r5, #0xe]
	mov r1, r6
	cmp r0, r9
	moveq r1, r11
	add r0, r7, r2
	bl AnimatorSprite__SetAnimation
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #3
	blo _02175B7C
	add r0, r10, #0x114
	add r0, r0, #0xc00
	mov r1, #0x13
	bl AnimatorSprite__SetAnimation
	add r2, r8, #0x200
	ldrh r3, [r2, #0xe]
	mov r0, #0x3a000
	add r1, r10, #0x2000
	mul r0, r3, r0
	add r0, r0, #0x2a000
	str r0, [r1, #0x8dc]
	mov r0, #0xa8000
	str r0, [r1, #0x8e0]
	ldrh r0, [r2, #0xe]
	strh r0, [r10, #0x34]
_02175BEC:
	mov r5, #0x400
	mov r9, #0
	add r4, r8, #0x200
	mov r11, #0xe000
	mov r7, r5
	mov r6, #2
_02175C04:
	ldrh r0, [r4, #0xe]
	cmp r0, r9
	bne _02175C30
	str r7, [sp]
	add r0, r10, r9, lsl #2
	mov r1, #0
	ldr r0, [r0, #0x5c]
	mov r2, r6
	mov r3, r1
	bl ObjShiftSet
	b _02175C4C
_02175C30:
	str r5, [sp]
	add r0, r10, r9, lsl #2
	ldr r0, [r0, #0x5c]
	mov r1, r11
	mov r2, #2
	mov r3, #0
	bl ObjShiftSet
_02175C4C:
	add r1, r10, r9, lsl #2
	str r0, [r1, #0x5c]
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #3
	blo _02175C04
	ldr r1, [r10, #0x38]
	ldr r0, [r8, #0x214]
	cmp r1, r0
	beq _02175CD0
	mov r1, #0
	mov r3, #0x7000
_02175C80:
	add r0, r1, #1
	add r2, r10, r1, lsl #3
	mov r1, r0, lsl #0x10
	add r0, r2, #0x2000
	mov r1, r1, lsr #0x10
	str r3, [r0, #0x7a4]
	cmp r1, #5
	bls _02175C80
	ldr r1, [r10, #0x38]
	ldr r0, [r8, #0x214]
	cmp r1, r0
	ble _02175CD0
	add r0, r10, #0x990
	mov r1, #3
	bl AnimatorSprite__SetAnimation
	mov r0, #5
	strh r0, [r10, #0x70]
	add r0, r10, #0x2000
	mov r1, #0
	str r1, [r0, #0x7d8]
_02175CD0:
	ldr r0, [r10, #0x50]
	cmp r0, #0
	bne _02175D40
	mov r5, #0
	mov r4, #0x2000
_02175CE4:
	add r0, r10, r5, lsl #3
	add r0, r0, #0x2000
	ldr r0, [r0, #0x7a4]
	mov r1, r4
	bl ObjSpdDownSet
	add r1, r5, #1
	add r3, r10, r5, lsl #3
	mov r2, r1, lsl #0x10
	add r1, r3, #0x2000
	mov r5, r2, lsr #0x10
	str r0, [r1, #0x7a4]
	cmp r5, #5
	bls _02175CE4
	ldrh r0, [r10, #0x70]
	cmp r0, #0
	beq _02175D40
	add r0, r10, #0x2000
	ldr r1, [r0, #0x7d8]
	sub r1, r1, #0x2000
	str r1, [r0, #0x7d8]
	ldrh r0, [r10, #0x70]
	sub r0, r0, #1
	strh r0, [r10, #0x70]
_02175D40:
	ldr r0, [r8, #0x214]
	str r0, [r10, #0x38]
	ldr r1, [r8, #0x218]
	ldr r0, [r10, #0x3c]
	cmp r0, r1
	bge _02175D90
	mov r7, #0
	add r4, r10, #0x94
	mov r6, #5
	mov r5, #0x64
_02175D68:
	add r1, r7, #0x19
	mla r0, r1, r5, r4
	mov r1, r6
	bl AnimatorSprite__SetAnimation
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #2
	bls _02175D68
	b _02175DBC
_02175D90:
	ble _02175DBC
	mov r0, r0, asr #0xc
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add r2, r10, #0x94
	add r1, r0, #0x19
	mov r0, #0x64
	mla r0, r1, r0, r2
	mov r1, #6
	bl AnimatorSprite__SetAnimation
_02175DBC:
	ldr r0, [r8, #0x218]
	str r0, [r10, #0x3c]
	ldr r2, [r8, #0x21c]
	ldr r1, [r10, #0x40]
	cmp r1, r2
	beq _02175E64
	add r0, r10, #0x384
	add r4, r0, #0x800
	cmp r1, r2
	ldrh r0, [r4, #0xc]
	ble _02175E14
	cmp r0, #7
	bne _02175E34
	mov r0, r4
	mov r1, #8
	bl AnimatorSprite__SetAnimation
	ldr r1, [r4, #0x3c]
	mov r0, #0x2000
	orr r1, r1, #4
	str r1, [r4, #0x3c]
	str r0, [r4, #0x38]
	b _02175E34
_02175E14:
	cmp r0, #8
	bne _02175E34
	mov r0, r4
	mov r1, #7
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x3c]
	bic r0, r0, #4
	str r0, [r4, #0x3c]
_02175E34:
	ldr r0, [r8, #0x21c]
	mov r1, #0xaa
	str r0, [r10, #0x40]
	bl FX_DivS32
	strh r0, [r10, #0x6e]
	ldr r0, [r10, #0x40]
	cmp r0, #0
	beq _02175E64
	ldrsh r0, [r10, #0x6e]
	cmp r0, #0
	addeq r0, r0, #1
	streqh r0, [r10, #0x6e]
_02175E64:
	mov r9, #0
	mov r11, #0x55
	mov r5, #0x100
	mov r6, #0x200
	mov r4, #8
_02175E78:
	add r1, r10, r9, lsl #2
	add r0, r8, r9, lsl #2
	ldr r7, [r1, #0x44]
	ldr r0, [r0, #0x220]
	cmp r7, r0
	beq _02175EF0
	cmp r9, #0
	beq _02175EAC
	cmp r9, #1
	beq _02175EC4
	cmp r9, #2
	beq _02175EDC
	b _02175EF0
_02175EAC:
	mov r0, r7
	mov r1, r6
	bl FX_DivS32
	add r1, r10, r9, lsl #1
	strh r0, [r1, #0x68]
	b _02175EF0
_02175EC4:
	mov r0, r7
	mov r1, r5
	bl FX_DivS32
	add r1, r10, r9, lsl #1
	strh r0, [r1, #0x68]
	b _02175EF0
_02175EDC:
	mov r0, r7
	mov r1, r11
	bl FX_DivS32
	add r1, r10, r9, lsl #1
	strh r0, [r1, #0x68]
_02175EF0:
	add r0, r8, r9, lsl #2
	ldr r0, [r0, #0x220]
	add r1, r10, r9, lsl #2
	str r0, [r1, #0x44]
	cmp r7, #0
	beq _02175F14
	ldr r0, [r1, #0x44]
	cmp r0, #0
	streq r4, [r1, #0x50]
_02175F14:
	add r1, r10, r9, lsl #2
	ldr r0, [r1, #0x50]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r1, #0x50]
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #3
	blo _02175E78
_02175F3C:
	ldr r0, [r10, #0]
	tst r0, #0x100
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #4]
	ldr r1, [r0, #0x24]
	add r0, r10, #0x228
	add r0, r0, #0x1000
	tst r1, #0x2000
	ldrh r1, [r0, #0xc]
	beq _02175F84
	cmp r1, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02175F84:
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02175FA0: .word 0x05F5E100
	arm_func_end SailHUD__Func_2175A58

	arm_func_start SailHUD__Func_2175FA4
SailHUD__Func_2175FA4: // 0x02175FA4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	mov r9, r0
	bl SailManager__GetWork
	str r0, [sp, #0x10]
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #8]
	ldr r0, [sp, #0xc]
	cmp r0, #0
	ldrne r0, [r0, #0x124]
	strne r0, [sp, #8]
	ldr r0, [sp, #0x10]
	ldr r0, [r0, #0x24]
	tst r0, #1
	bne _021760F8
	ldr r0, [r9, #0]
	tst r0, #2
	beq _021760F8
	mov r7, #0
	mov r4, #0x400
	mov r10, #2
	mov r8, #1
	mov r6, r4
	mov r5, r10
	mov r11, r7
_02176014:
	cmp r7, #0xa
	addls pc, pc, r7, lsl #2
	b _0217604C
_02176020: // jump table
	b _0217604C // case 0
	b _02176088 // case 1
	b _0217604C // case 2
	b _0217604C // case 3
	b _0217604C // case 4
	b _0217604C // case 5
	b _0217604C // case 6
	b _0217604C // case 7
	b _02176088 // case 8
	b _02176088 // case 9
	b _02176088 // case 10
_0217604C:
	ldrh r0, [r9, #4]
	cmp r0, #8
	bls _021760C0
	add r0, r9, r7, lsl #3
	add r0, r0, #0x2000
	str r6, [sp]
	mov r1, #0
	ldr r0, [r0, #0xb00]
	mov r2, r5
	mov r3, r1
	bl ObjShiftSet
	add r1, r9, r7, lsl #3
	add r1, r1, #0x2000
	str r0, [r1, #0xb00]
	b _021760C0
_02176088:
	ldrh r0, [r9, #4]
	cmp r0, #0xb
	bls _021760C0
	add r0, r9, r7, lsl #3
	add r0, r0, #0x2000
	str r4, [sp]
	mov r1, #0
	ldr r0, [r0, #0xb00]
	mov r2, r10
	mov r3, r1
	bl ObjShiftSet
	add r1, r9, r7, lsl #3
	add r1, r1, #0x2000
	str r0, [r1, #0xb00]
_021760C0:
	add r0, r9, r7, lsl #3
	add r0, r0, #0x2000
	ldr r0, [r0, #0xb00]
	cmp r0, #0
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	movne r8, r11
	cmp r7, #0x64
	blo _02176014
	cmp r8, #0
	ldrne r0, [r9, #0]
	bicne r0, r0, #2
	strne r0, [r9]
_021760F8:
	ldr r0, [sp, #0x10]
	ldr r0, [r0, #0x24]
	tst r0, #2
	beq _02176198
	mov r10, #0
	mov r4, #0x30000
	mov r5, #0x400
	rsb r4, r4, #0
	mov r6, r10
	mov r8, r10
	mov r7, r5
	mov r11, #0x30000
_02176128:
	cmp r10, #0xb
	mov r3, #2
	blo _02176158
	str r8, [sp]
	add r0, r9, r10, lsl #3
	str r7, [sp, #4]
	add r0, r0, #0x2000
	ldr r0, [r0, #0xb00]
	mov r1, r11
	mov r2, r8
	bl ObjDiffSet
	b _02176178
_02176158:
	str r6, [sp]
	add r0, r9, r10, lsl #3
	str r5, [sp, #4]
	add r0, r0, #0x2000
	ldr r0, [r0, #0xb00]
	mov r1, r4
	mov r2, r6
	bl ObjDiffSet
_02176178:
	add r1, r9, r10, lsl #3
	add r1, r1, #0x2000
	str r0, [r1, #0xb00]
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
	cmp r10, #0x64
	blo _02176128
_02176198:
	ldr r1, [r9, #0x10]
	ldr r0, [r9, #0x24]
	cmp r1, r0
	bge _02176210
	ldr r0, [r9, #0]
	bic r0, r0, #8
	orr r0, r0, #0x10
	str r0, [r9]
	ldrh r0, [r9, #4]
	tst r0, #4
	mov r0, #0x26
	beq _021761EC
	bl GetObjectFileWork
	add r1, r9, #0x300
	ldrh r2, [r1, #0x3c]
	ldr r0, [r0, #0]
	mov r1, #0xa
	and r2, r2, #0xff
	mov r3, #0
	bl ObjDraw__TintSprite
	b _0217629C
_021761EC:
	bl GetObjectFileWork
	add r1, r9, #0x300
	ldrh r2, [r1, #0x3c]
	ldr r0, [r0, #0]
	mov r1, #9
	and r2, r2, #0xff
	mov r3, #0
	bl ObjDraw__TintSprite
	b _0217629C
_02176210:
	ldr r0, [r9, #0x20]
	cmp r1, r0
	ldr r0, [r9, #0]
	bge _02176260
	bic r0, r0, #0x10
	str r0, [r9]
	tst r0, #8
	bne _0217629C
	orr r1, r0, #8
	mov r0, #0x26
	str r1, [r9]
	bl GetObjectFileWork
	add r1, r9, #0x300
	ldrh r2, [r1, #0x3c]
	ldr r0, [r0, #0]
	mov r1, #9
	and r2, r2, #0xff
	mov r3, #0
	bl ObjDraw__TintSprite
	b _0217629C
_02176260:
	tst r0, #0x18
	beq _0217629C
	mov r0, #0x26
	bl GetObjectFileWork
	add r1, r9, #0x300
	ldrh r2, [r1, #0x3c]
	ldr r0, [r0, #0]
	mov r1, #8
	and r2, r2, #0xff
	mov r3, #0
	bl ObjDraw__TintSprite
	ldr r0, [r9, #0]
	bic r0, r0, #0x10
	bic r0, r0, #8
	str r0, [r9]
_0217629C:
	ldr r0, [r9, #0]
	tst r0, #0x20
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0xc]
	add r4, r9, #0x3b4
	cmp r0, #0
	beq _02176304
	ldr r0, [r0, #0x24]
	tst r0, #1
	ldreq r0, [sp, #8]
	ldreq r0, [r0, #0x1fc]
	cmpeq r0, #0
	beq _02176304
	ldrh r0, [r4, #0xc]
	cmp r0, #5
	beq _02176328
	mov r0, r4
	mov r1, #5
	bl AnimatorSprite__SetAnimation
	ldr r1, [r4, #0x3c]
	mov r0, #0x2000
	orr r1, r1, #4
	str r1, [r4, #0x3c]
	str r0, [r4, #0x38]
	b _02176328
_02176304:
	ldrh r0, [r4, #0xc]
	cmp r0, #4
	beq _02176328
	mov r0, r4
	mov r1, #4
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x3c]
	bic r0, r0, #4
	str r0, [r4, #0x3c]
_02176328:
	ldr r0, [sp, #8]
	cmp r0, #0
	addne r0, r0, #0x100
	ldrnesh r0, [r0, #0xee]
	cmpne r0, #0
	bne _02176358
	ldr r0, [r9, #0]
	ands r1, r0, #0x100
	beq _02176400
	ldr r0, [r9, #0xc]
	cmp r0, #0x120000
	blt _02176400
_02176358:
	ldrh r0, [r9, #4]
	mov r1, #0
	mov r2, r1
	tst r0, #4
	ldrh r0, [r4, #0x50]
	beq _021763D4
	mov r3, r1
	bl ObjDraw__TintPaletteRow
	ldr r0, [r9, #0]
	mov r1, #1
	tst r0, #0x100
	mov r2, #3
	beq _021763B0
	mvn r0, #0xe
	str r0, [sp]
	add r0, r0, #7
	str r0, [sp, #4]
	ldrh r0, [r4, #0x50]
	mov r3, #0x1f
	bl ObjDraw__TintPaletteColors
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_021763B0:
	mov r0, #0
	str r0, [sp]
	sub r0, r0, #8
	str r0, [sp, #4]
	ldrh r0, [r4, #0x50]
	mov r3, #0x1f
	bl ObjDraw__TintPaletteColors
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_021763D4:
	mov r3, r1
	bl ObjDraw__TintPaletteRow
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	ldrh r0, [r4, #0x50]
	mov r1, #1
	mov r2, #3
	bl ObjDraw__TintPaletteColors
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02176400:
	cmp r1, #0
	bne _02176414
	ldr r0, [r9, #0x18]
	cmp r0, #0x1e000
	bge _02176428
_02176414:
	cmp r1, #0
	beq _02176480
	ldr r0, [r9, #0xc]
	cmp r0, #0x60000
	blt _02176480
_02176428:
	ldrh r0, [r9, #4]
	tst r0, #4
	mov r0, #0x26
	beq _0217645C
	bl GetObjectFileWork
	ldrh r2, [r4, #0x50]
	ldr r0, [r0, #0]
	mov r1, #4
	and r2, r2, #0xff
	mov r3, #0
	bl ObjDraw__TintSprite
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0217645C:
	bl GetObjectFileWork
	ldrh r2, [r4, #0x50]
	ldr r0, [r0, #0]
	mov r1, #0x1b
	and r2, r2, #0xff
	mov r3, #0
	bl ObjDraw__TintSprite
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02176480:
	mov r0, #0x26
	bl GetObjectFileWork
	ldrh r2, [r4, #0x50]
	ldr r0, [r0, #0]
	mov r1, #4
	and r2, r2, #0xff
	mov r3, #0
	bl ObjDraw__TintSprite
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end SailHUD__Func_2175FA4

	arm_func_start SailHUD__Func_21764A8
SailHUD__Func_21764A8: // 0x021764A8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r1, #0x800
	mov r4, r0
	str r1, [sp]
	ldr r0, [r4, #8]
	ldr r1, [r4, #0x10]
	mov r2, #1
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #8]
	ldrsh r0, [r4, #0x30]
	cmp r0, #0
	bne _02176514
	ldr r1, [r4, #0x10]
	ldr r0, [r4, #0x28]
	cmp r0, r1
	ldrle r0, [r4, #8]
	strle r0, [r4, #0x28]
	ble _0217651C
	mov r2, #0x800
	str r2, [sp]
	mov r2, #4
	mov r3, #0x4000
	bl ObjShiftSet
	str r0, [r4, #0x28]
	b _0217651C
_02176514:
	sub r0, r0, #1
	strh r0, [r4, #0x30]
_0217651C:
	ldrsh r0, [r4, #0x32]
	cmp r0, #0
	subne r0, r0, #1
	strneh r0, [r4, #0x32]
	ldr r0, [r4, #0]
	tst r0, #0x100
	beq _02176550
	ldr r1, [r4, #0x18]
	ldr r0, [r4, #0xc]
	cmp r0, r1
	addlt sp, sp, #4
	strlt r1, [r4, #0xc]
	ldmltia sp!, {r3, r4, pc}
_02176550:
	mov r0, #0x800
	str r0, [sp]
	ldr r0, [r4, #0xc]
	ldr r1, [r4, #0x18]
	mov r2, #2
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #0xc]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end SailHUD__Func_21764A8

	arm_func_start SailHUD__Func_2176578
SailHUD__Func_2176578: // 0x02176578
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x18
	mov r4, r0
	bl SailManager__GetWork
	ldr r7, [r0, #0x70]
	bl SailManager__GetWork
	add r1, sp, #0x14
	mov r6, #0
	strh r6, [r1]
	strh r6, [r1, #2]
	mov r5, r0
	cmp r7, #0
	ldr r0, [r4, #0]
	ldrne r6, [r7, #0x124]
	tst r0, #4
	addne sp, sp, #0x18
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldrsh r0, [r4, #0x32]
	cmp r0, #0
	beq _021765F4
	mov r0, r0, asr #1
	ldr r1, _02176A70 // =StageTask__shakeOffsetTable
	and r0, r0, #0xf
	ldrsb r0, [r1, r0]
	strh r0, [sp, #0x14]
	ldrsh r0, [r4, #0x32]
	mov r0, r0, asr #1
	add r0, r0, #1
	and r0, r0, #0xf
	ldrsb r0, [r1, r0]
	strh r0, [sp, #0x16]
_021765F4:
	ldr r0, [r5, #0x24]
	tst r0, #2
	bne _021766B8
	cmp r6, #0
	beq _02176690
	add r0, r6, #0x100
	ldrsh r0, [r0, #0xe2]
	cmp r0, #0x20
	bgt _02176620
	tst r0, #1
	bne _02176690
_02176620:
	bl SailManager__GetShipType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02176690
_02176630: // jump table
	b _02176640 // case 0
	b _0217667C // case 1
	b _02176640 // case 2
	b _0217667C // case 3
_02176640:
	ldr r0, [r4, #0]
	tst r0, #0x200
	bne _02176690
	add r0, r6, #0x100
	ldrh r0, [r0, #0xc4]
	mov r1, #0xc
	mov r2, #0x25
	cmp r0, #9
	movhi r1, #0x18
	cmp r0, #0x63
	movhi r1, #0x24
	mov r0, r4
	mov r3, #0
	bl SailHUD__Func_2177F08
	b _02176690
_0217667C:
	mov r0, r4
	mov r1, #0xd7
	mov r2, #0x16
	mov r3, #0
	bl SailHUD__Func_2177F08
_02176690:
	add r0, r4, #0x2000
	ldr r1, [r0, #0xb48]
	mov r0, r4
	mov r1, r1, asr #0xc
	add r1, r1, #4
	mov r1, r1, lsl #0x10
	mov r2, r1, asr #0x10
	mov r1, #0xf3
	mov r3, #0
	bl SailHUD__Func_2177E0C
_021766B8:
	ldr r0, [r5, #0x24]
	tst r0, #2
	bne _0217671C
	ldr r0, [r4, #0]
	tst r0, #0x80
	bne _0217671C
	mov r0, #5
	str r0, [sp]
	mov r0, #0x58
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	mov r0, #8
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	add r0, r4, #0x2000
	ldr r0, [r0, #0xb48]
	ldr r1, [r4, #0x90]
	add r0, r0, #0x1000
	mov r2, r0, lsl #4
	mov r0, r4
	mov r3, r2, asr #0x10
	mov r2, #0xa0
	bl SailHUD__Func_2177C10
_0217671C:
	mov r9, #0
	add r7, r4, #0x94
	mov r6, r9
	mov r5, #0x64
_0217672C:
	mla r8, r9, r5, r7
	ldr r0, [r8, #0x14]
	cmp r0, #0
	beq _0217678C
	mov r0, r8
	mov r1, r6
	mov r2, r6
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, r9, lsl #3
	add r0, r0, #0x2000
	ldrsh r3, [sp, #0x14]
	ldr r2, [r0, #0x7dc]
	ldr r1, [r0, #0xafc]
	add r2, r3, r2, asr #12
	add r1, r2, r1, asr #12
	strh r1, [r8, #8]
	ldrsh r2, [sp, #0x16]
	ldr r1, [r0, #0x7e0]
	ldr r0, [r0, #0xb00]
	add r1, r2, r1, asr #12
	add r1, r1, r0, asr #12
	mov r0, r8
	strh r1, [r8, #0xa]
	bl AnimatorSprite__DrawFrame
_0217678C:
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #4
	blo _0217672C
	ldrh r0, [r4, #4]
	ands r1, r0, #1
	ldrne r0, [r4, #8]
	ldreq r0, [r4, #0x28]
	mov r0, r0, lsl #4
	mov r9, r0, lsr #0x10
	cmp r9, #4
	bhs _021767E4
	cmp r1, #0
	ldrne r0, [r4, #8]
	cmpne r0, #0
	movne r9, #4
	cmp r1, #0
	bne _021767E4
	ldr r0, [r4, #0x28]
	cmp r0, #0
	movne r9, #4
_021767E4:
	mov r6, #0
	add r8, r4, #0x2ec
	mov r0, r8
	mov r1, r6
	mov r2, r6
	bl AnimatorSprite__ProcessAnimation
	ldrh r0, [r4, #0x2c]
	mov r5, r6
	cmp r0, #0
	bls _02176880
	sub r7, r9, #4
	add r10, r4, #0x2000
_02176814:
	cmp r7, r6
	blt _02176880
	ldrsh r2, [sp, #0x14]
	ldr r1, [r10, #0x80c]
	mov r0, r5, lsl #3
	add r0, r0, r1, asr #12
	ldr r1, [r10, #0xb2c]
	add r0, r2, r0
	add r0, r0, r1, asr #12
	strh r0, [r8, #8]
	ldrsh r2, [sp, #0x16]
	ldr r1, [r10, #0x810]
	ldr r0, [r10, #0xb30]
	add r1, r2, r1, asr #12
	add r1, r1, r0, asr #12
	mov r0, r8
	strh r1, [r8, #0xa]
	bl AnimatorSprite__DrawFrame
	add r0, r6, #0x20
	add r1, r5, #1
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	ldrh r2, [r4, #0x2c]
	mov r6, r0, lsr #0x10
	mov r5, r1, lsr #0x10
	cmp r2, r1, lsr #16
	bhi _02176814
_02176880:
	cmp r5, #1
	blo _0217691C
	and r0, r9, #0x1f
	mov r0, r0, asr #2
	add r0, r0, #1
	rsb r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #7
	add r6, r4, #0x350
	bhs _0217691C
	add r0, r0, #0xb
	mov r1, r0, lsl #0x10
	mov r0, r6
	mov r1, r1, lsr #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r1, r4, #0x2000
	sub r0, r5, #1
	mov r0, r0, lsl #0x10
	ldrsh r3, [sp, #0x14]
	ldr r2, [r1, #0x814]
	mov r0, r0, lsr #0xd
	add r0, r0, r2, asr #12
	ldr r2, [r1, #0xb34]
	add r0, r3, r0
	add r0, r0, r2, asr #12
	strh r0, [r6, #8]
	ldrsh r3, [sp, #0x16]
	ldr r2, [r1, #0x818]
	ldr r0, [r1, #0xb38]
	add r1, r3, r2, asr #12
	add r1, r1, r0, asr #12
	mov r0, r6
	strh r1, [r6, #0xa]
	bl AnimatorSprite__DrawFrame
_0217691C:
	add r5, r4, #0x224
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x2000
	ldrsh r3, [sp, #0x14]
	ldr r2, [r0, #0x7fc]
	ldr r1, [r0, #0xb1c]
	add r2, r3, r2, asr #12
	add r1, r2, r1, asr #12
	strh r1, [r5, #8]
	ldrsh r2, [sp, #0x16]
	ldr r1, [r0, #0x800]
	ldr r0, [r0, #0xb20]
	add r1, r2, r1, asr #12
	add r1, r1, r0, asr #12
	mov r0, r5
	strh r1, [r5, #0xa]
	bl AnimatorSprite__DrawFrame
	add r5, r4, #0x288
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldrh r0, [r4, #0x2c]
	mov r6, #0
	cmp r0, #0
	bls _021769EC
	add r7, r4, #0x2000
_02176994:
	ldrsh r2, [sp, #0x14]
	ldr r1, [r7, #0x804]
	mov r0, r6, lsl #3
	add r0, r0, r1, asr #12
	ldr r1, [r7, #0xb24]
	add r0, r2, r0
	add r0, r0, r1, asr #12
	strh r0, [r5, #8]
	ldrsh r2, [sp, #0x16]
	ldr r1, [r7, #0x808]
	ldr r0, [r7, #0xb28]
	add r1, r2, r1, asr #12
	add r1, r1, r0, asr #12
	mov r0, r5
	strh r1, [r5, #0xa]
	bl AnimatorSprite__DrawFrame
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	ldrh r1, [r4, #0x2c]
	mov r6, r0, lsr #0x10
	cmp r1, r0, lsr #16
	bhi _02176994
_021769EC:
	add r0, r4, #0x2000
	add r1, r6, #2
	ldrsh r3, [sp, #0x14]
	ldr r2, [r0, #0x7fc]
	mov r1, r1, lsl #3
	add r1, r1, r2, asr #12
	add r5, r4, #0x224
	ldr r2, [r0, #0xb1c]
	add r1, r3, r1
	add r1, r1, r2, asr #12
	strh r1, [r5, #8]
	ldrsh r2, [sp, #0x16]
	ldr r1, [r0, #0x800]
	ldr r0, [r0, #0xb20]
	add r1, r2, r1, asr #12
	add r0, r1, r0, asr #12
	strh r0, [r5, #0xa]
	ldr r1, [r5, #0x3c]
	mov r0, r5
	orr r1, r1, #0x80
	str r1, [r5, #0x3c]
	bl AnimatorSprite__DrawFrame
	ldr r1, [r5, #0x3c]
	mov r0, r4
	bic r1, r1, #0x80
	str r1, [r5, #0x3c]
	bl SailHUD__Func_2176A74
	mov r0, r4
	bl SailHUD__Func_2176C6C
	mov r0, r4
	bl SailHUD__Func_2177560
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02176A70: .word StageTask__shakeOffsetTable
	arm_func_end SailHUD__Func_2176578

	arm_func_start SailHUD__Func_2176A74
SailHUD__Func_2176A74: // 0x02176A74
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	add r2, sp, #0
	mov r1, #0
	mov r8, r0
	strh r1, [r2]
	strh r1, [r2, #2]
	ldr r0, [r8, #0]
	tst r0, #4
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	tst r0, #0x20
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldrsh r0, [r8, #0x32]
	cmp r0, #0
	beq _02176AD8
	mov r0, r0, asr #1
	ldr r1, _02176C68 // =StageTask__shakeOffsetTable
	and r0, r0, #0xf
	ldrsb r0, [r1, r0]
	strh r0, [sp]
	ldrsh r0, [r8, #0x32]
	mov r0, r0, asr #1
	add r0, r0, #1
	and r0, r0, #0xf
	ldrsb r0, [r1, r0]
	strh r0, [sp, #2]
_02176AD8:
	add r4, r8, #0x3b4
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r8, #0x2000
	ldrsh r3, [sp]
	ldr r2, [r0, #0x81c]
	ldr r1, [r0, #0xb3c]
	add r2, r3, r2, asr #12
	add r1, r2, r1, asr #12
	strh r1, [r4, #8]
	ldr r1, [r0, #0x820]
	ldrsh r2, [sp, #2]
	ldr r0, [r0, #0xb40]
	add r1, r2, r1, asr #12
	add r1, r1, r0, asr #12
	mov r0, r4
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	add r0, r8, #0x18
	ldr r1, [r8, #0xc]
	mov r6, #0
	mov r3, r1, lsl #4
	add r7, r0, #0x400
	mov r0, r7
	mov r1, r6
	mov r2, r6
	mov r5, r3, lsr #0x10
	bl AnimatorSprite__ProcessAnimation
	ldrh r1, [r8, #0x2e]
	mov r4, r6
	cmp r1, #0
	bls _02176BD0
	add r9, r8, #0x2000
_02176B64:
	add r0, r6, #0x20
	mov r0, r0, lsl #0x10
	cmp r5, r0, lsr #16
	mov r6, r0, lsr #0x10
	blo _02176BD0
	ldrsh r2, [sp]
	ldr r1, [r9, #0x824]
	mov r0, r4, lsl #3
	add r0, r0, r1, asr #12
	ldr r1, [r9, #0xb44]
	add r0, r2, r0
	add r0, r0, r1, asr #12
	strh r0, [r7, #8]
	ldrsh r2, [sp, #2]
	ldr r1, [r9, #0x828]
	ldr r0, [r9, #0xb48]
	add r1, r2, r1, asr #12
	add r1, r1, r0, asr #12
	mov r0, r7
	strh r1, [r7, #0xa]
	bl AnimatorSprite__DrawFrame
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	ldrh r1, [r8, #0x2e]
	mov r4, r0, lsr #0x10
	cmp r1, r0, lsr #16
	bhi _02176B64
_02176BD0:
	cmp r4, r1
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	and r0, r5, #0x1f
	mov r0, r0, asr #2
	rsb r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	add r0, r8, #0x7c
	add r5, r0, #0x400
	cmp r1, #8
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r0, r1, #0x13
	mov r1, r0, lsl #0x10
	mov r0, r5
	mov r1, r1, lsr #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r8, #0x2000
	ldrsh r3, [sp]
	ldr r2, [r0, #0x82c]
	mov r1, r4, lsl #3
	add r1, r1, r2, asr #12
	ldr r2, [r0, #0xb4c]
	add r1, r3, r1
	add r1, r1, r2, asr #12
	strh r1, [r5, #8]
	ldrsh r2, [sp, #2]
	ldr r1, [r0, #0x830]
	ldr r0, [r0, #0xb50]
	add r1, r2, r1, asr #12
	add r1, r1, r0, asr #12
	mov r0, r5
	strh r1, [r5, #0xa]
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02176C68: .word StageTask__shakeOffsetTable
	arm_func_end SailHUD__Func_2176A74

	arm_func_start SailHUD__Func_2176C6C
SailHUD__Func_2176C6C: // 0x02176C6C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	add r2, sp, #8
	mov r1, #0
	mov r9, r0
	strh r1, [r2]
	strh r1, [r2, #2]
	ldr r0, [r9, #0]
	tst r0, #4
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	tst r0, #0x40
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrsh r0, [r9, #0x32]
	cmp r0, #0
	beq _02176CDC
	mov r0, r0, asr #1
	ldr r1, _0217755C // =StageTask__shakeOffsetTable
	and r0, r0, #0xf
	ldrsb r0, [r1, r0]
	strh r0, [sp, #8]
	ldrsh r0, [r9, #0x32]
	mov r0, r0, asr #1
	add r0, r0, #1
	and r0, r0, #0xf
	ldrsb r0, [r1, r0]
	strh r0, [sp, #0xa]
_02176CDC:
	add r0, r9, #0x114
	add r4, r0, #0xc00
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r9, #0x2000
	ldrsh r3, [sp, #8]
	ldr r2, [r0, #0x8dc]
	ldr r1, [r0, #0xbfc]
	add r2, r3, r2, asr #12
	add r1, r2, r1, asr #12
	strh r1, [r4, #8]
	ldrsh r2, [sp, #0xa]
	ldr r1, [r0, #0x8e0]
	ldr r0, [r0, #0xc00]
	add r1, r2, r1, asr #12
	add r0, r1, r0, asr #12
	strh r0, [r4, #0xa]
	ldrh r1, [r9, #0x34]
	ldrsh r2, [r4, #0xa]
	mov r0, r4
	add r1, r9, r1, lsl #2
	ldr r1, [r1, #0x5c]
	add r1, r2, r1, asr #12
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	ldrh r0, [r9, #4]
	tst r0, #4
	beq _02176DF8
	mov r5, #0
	add r0, r9, #0x178
	add r6, r0, #0xc00
	add r7, r9, #0x2000
	mov r4, r5
	mov r8, #0x3a
_02176D6C:
	add r0, r9, r5, lsl #2
	ldr r0, [r0, #0x44]
	cmp r0, #0
	beq _02176DE4
	mov r0, r6
	mov r1, r4
	mov r2, r4
	bl AnimatorSprite__ProcessAnimation
	ldrsh r0, [sp, #8]
	ldr r1, [r7, #0x8e4]
	ldr r2, [r7, #0xc04]
	add r0, r0, r1, asr #12
	add r0, r0, r2, asr #12
	strh r0, [r6, #8]
	ldrsh r0, [sp, #0xa]
	ldr r1, [r7, #0x8e8]
	ldr r2, [r7, #0xc08]
	add r0, r0, r1, asr #12
	add r0, r0, r2, asr #12
	strh r0, [r6, #0xa]
	add r0, r9, r5, lsl #2
	ldrsh r2, [r6, #0xa]
	ldr r1, [r0, #0x5c]
	mov r0, r6
	add r1, r2, r1, asr #12
	strh r1, [r6, #0xa]
	ldrsh r1, [r6, #8]
	mla r1, r5, r8, r1
	strh r1, [r6, #8]
	bl AnimatorSprite__DrawFrame
_02176DE4:
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #3
	blo _02176D6C
_02176DF8:
	mov r5, #0
	add r0, r9, #0x1dc
	add r6, r0, #0xc00
	add r7, r9, #0x2000
	mov r4, r5
	mov r8, #0x3a
_02176E10:
	add r0, r9, r5, lsl #2
	ldr r0, [r0, #0x50]
	cmp r0, #0
	beq _02176E88
	mov r0, r6
	mov r1, r4
	mov r2, r4
	bl AnimatorSprite__ProcessAnimation
	ldrsh r0, [sp, #8]
	ldr r1, [r7, #0x8e4]
	ldr r2, [r7, #0xc04]
	add r0, r0, r1, asr #12
	add r0, r0, r2, asr #12
	strh r0, [r6, #8]
	ldrsh r0, [sp, #0xa]
	ldr r1, [r7, #0x8e8]
	ldr r2, [r7, #0xc08]
	add r0, r0, r1, asr #12
	add r0, r0, r2, asr #12
	strh r0, [r6, #0xa]
	add r0, r9, r5, lsl #2
	ldrsh r2, [r6, #0xa]
	ldr r1, [r0, #0x5c]
	mov r0, r6
	add r1, r2, r1, asr #12
	strh r1, [r6, #0xa]
	ldrsh r1, [r6, #8]
	mla r1, r5, r8, r1
	strh r1, [r6, #8]
	bl AnimatorSprite__DrawFrame
_02176E88:
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #3
	blo _02176E10
	mov r7, #0
	add r6, r9, #0x94
	mov r5, r7
	mov r4, #0x64
_02176EAC:
	add r0, r7, #0xe
	mla r8, r0, r4, r6
	ldr r0, [r8, #0x14]
	cmp r0, #0
	ldrneh r0, [r9, #0x34]
	cmpne r0, r7
	beq _02176F2C
	mov r0, r8
	mov r1, r5
	mov r2, r5
	bl AnimatorSprite__ProcessAnimation
	add r0, r9, r7, lsl #3
	add r0, r0, #0x2000
	ldrsh r3, [sp, #8]
	ldr r2, [r0, #0x84c]
	ldr r1, [r0, #0xb6c]
	add r2, r3, r2, asr #12
	add r1, r2, r1, asr #12
	strh r1, [r8, #8]
	ldrsh r2, [sp, #0xa]
	ldr r1, [r0, #0x850]
	ldr r0, [r0, #0xb70]
	add r1, r2, r1, asr #12
	add r0, r1, r0, asr #12
	strh r0, [r8, #0xa]
	add r0, r9, r7, lsl #2
	ldrsh r2, [r8, #0xa]
	ldr r1, [r0, #0x5c]
	mov r0, r8
	add r1, r2, r1, asr #12
	strh r1, [r8, #0xa]
	bl AnimatorSprite__DrawFrame
_02176F2C:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #3
	blo _02176EAC
	mov r0, #0
	str r0, [sp]
_02176F48:
	ldr r0, [sp]
	add r4, r9, r0, lsl #2
	ldr r0, [r4, #0x44]
	cmp r0, #0
	beq _0217703C
	ldr r0, [sp]
	mov r1, #0x3a
	mul r7, r0, r1
	add r0, r9, r0, lsl #1
	ldrsh r6, [r0, #0x68]
	add r0, r9, #0x160
	mov r5, #0
	add r11, r9, #0x94
	str r0, [sp, #4]
	add r10, r9, #0x2000
_02176F84:
	cmp r6, #8
	ldrge r0, [sp, #4]
	addge r8, r0, #0x1000
	bge _02176FAC
	cmp r6, #0
	addle r8, r9, #0xe40
	ble _02176FAC
	add r1, r6, #0x23
	mov r0, #0x64
	mla r8, r1, r0, r11
_02176FAC:
	ldrsh r0, [sp, #8]
	ldr r1, [r10, #0x8f4]
	ldr r2, [r10, #0xc14]
	add r0, r0, r1, asr #12
	add r0, r0, r2, asr #12
	strh r0, [r8, #8]
	ldrsh r2, [r8, #8]
	mov r1, #0
	mov r0, r8
	add r2, r2, r7
	strh r2, [r8, #8]
	ldrsh r3, [r8, #8]
	mov r2, r1
	add r3, r3, r5, lsl #3
	strh r3, [r8, #8]
	ldrsh r3, [sp, #0xa]
	ldr ip, [r10, #0x8f8]
	ldr lr, [r10, #0xc18]
	add r3, r3, ip, asr #12
	add r3, r3, lr, asr #12
	strh r3, [r8, #0xa]
	ldrsh ip, [r8, #0xa]
	ldr r3, [r4, #0x5c]
	add r3, ip, r3, asr #12
	strh r3, [r8, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r8
	bl AnimatorSprite__DrawFrame
	sub r0, r6, #8
	mov r0, r0, lsl #0x10
	add r1, r5, #1
	mov r6, r0, asr #0x10
	mov r0, r1, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #6
	blo _02176F84
_0217703C:
	ldr r0, [sp]
	add r0, r9, r0, lsl #2
	ldr r0, [r0, #0x50]
	cmp r0, #0
	beq _021770F0
	add r0, r9, #0x1c4
	add r4, r0, #0x1000
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r2, r9, #0x2000
	ldrsh r0, [sp, #8]
	ldr r1, [r2, #0x93c]
	ldr r3, [r2, #0xc5c]
	add r0, r0, r1, asr #12
	add r0, r0, r3, asr #12
	strh r0, [r4, #8]
	ldr r0, [sp]
	ldrsh r5, [r4, #8]
	mov r1, #0x3a
	add r3, r9, r0, lsl #2
	mla r1, r0, r1, r5
	strh r1, [r4, #8]
	ldr r1, [r2, #0x940]
	ldrsh r0, [sp, #0xa]
	ldr r2, [r2, #0xc60]
	mov r5, #0
	add r0, r0, r1, asr #12
	add r0, r0, r2, asr #12
	strh r0, [r4, #0xa]
	ldrsh r1, [r4, #0xa]
	ldr r0, [r3, #0x5c]
	add r0, r1, r0, asr #12
	strh r0, [r4, #0xa]
_021770C8:
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldrsh r1, [r4, #8]
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	add r1, r1, #8
	mov r5, r0, lsr #0x10
	strh r1, [r4, #8]
	cmp r5, #6
	blo _021770C8
_021770F0:
	ldr r0, [sp]
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp]
	cmp r0, #3
	blo _02176F48
	ldrh r0, [r9, #0x70]
	cmp r0, #0
	beq _02177188
	add r4, r9, #0x990
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r9, #0x2000
	ldrsh r3, [sp, #8]
	ldr r2, [r0, #0x894]
	ldr r1, [r0, #0x7d4]
	ldr r5, [r0, #0xbb4]
	add r1, r2, r1
	add r1, r3, r1, asr #12
	add r1, r1, r5, asr #12
	strh r1, [r4, #8]
	ldrsh r3, [sp, #0xa]
	ldr r2, [r0, #0x898]
	ldr r1, [r0, #0x7d8]
	ldr r5, [r0, #0xbb8]
	add r0, r2, r1
	add r0, r3, r0, asr #12
	add r0, r0, r5, asr #12
	strh r0, [r4, #0xa]
	ldrsh r2, [r4, #0xa]
	ldr r1, [r9, #0x5c]
	mov r0, r4
	add r1, r2, r1, asr #12
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
_02177188:
	mov r8, #0
	mov r6, #0x11
	add r5, r9, #0x94
	mov r4, r8
	mov r10, #0x64
_0217719C:
	mla r7, r6, r10, r5
	ldr r0, [r7, #0x14]
	cmp r0, #0
	beq _02177230
	ldr r0, [r9, #0x38]
	cmp r8, r0, asr #12
	bge _02177250
	mov r0, r7
	mov r1, r4
	mov r2, r4
	bl AnimatorSprite__ProcessAnimation
	add r0, r9, r6, lsl #3
	add r2, r0, #0x2000
	add r0, r9, r8, lsl #3
	add r3, r0, #0x2000
	ldrsh r0, [sp, #8]
	ldr ip, [r2, #0x7dc]
	ldr r11, [r3, #0x7a4]
	ldr r1, [r2, #0xafc]
	add r11, ip, r11
	add r0, r0, r11, asr #12
	add r0, r0, r1, asr #12
	strh r0, [r7, #8]
	ldrsh r11, [sp, #0xa]
	ldr r1, [r2, #0x7e0]
	ldr r0, [r3, #0x7a8]
	ldr r2, [r2, #0xb00]
	add r0, r1, r0
	add r0, r11, r0, asr #12
	add r0, r0, r2, asr #12
	strh r0, [r7, #0xa]
	ldrsh r2, [r7, #0xa]
	ldr r1, [r9, #0x5c]
	mov r0, r7
	add r1, r2, r1, asr #12
	strh r1, [r7, #0xa]
	bl AnimatorSprite__DrawFrame
_02177230:
	add r0, r6, #1
	add r2, r8, #1
	mov r1, r0, lsl #0x10
	mov r0, r2, lsl #0x10
	mov r6, r1, lsr #0x10
	cmp r6, #0x16
	mov r8, r0, lsr #0x10
	bls _0217719C
_02177250:
	add r0, r9, #0x1f4
	add r4, r0, #0x800
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r9, #0x2000
	ldrsh r3, [sp, #8]
	ldr r2, [r0, #0x89c]
	ldr r1, [r0, #0xbbc]
	add r2, r3, r2, asr #12
	add r1, r2, r1, asr #12
	strh r1, [r4, #8]
	ldr r1, [r0, #0x8a0]
	ldrsh r2, [sp, #0xa]
	ldr r0, [r0, #0xbc0]
	add r1, r2, r1, asr #12
	add r0, r1, r0, asr #12
	strh r0, [r4, #0xa]
	ldrsh r2, [r4, #0xa]
	ldr r1, [r9, #0x5c]
	mov r0, r4
	add r1, r2, r1, asr #12
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r7, #0x19
	add r6, r9, #0x94
	mov r5, #0
	mov r4, #0x64
_021772C4:
	mla r8, r7, r4, r6
	ldr r0, [r8, #0x14]
	cmp r0, #0
	beq _02177334
	mov r0, r8
	mov r1, r5
	mov r2, r5
	bl AnimatorSprite__ProcessAnimation
	add r0, r9, r7, lsl #3
	add r0, r0, #0x2000
	ldrsh r3, [sp, #8]
	ldr r2, [r0, #0x7dc]
	ldr r1, [r0, #0xafc]
	add r2, r3, r2, asr #12
	add r1, r2, r1, asr #12
	strh r1, [r8, #8]
	ldrsh r2, [sp, #0xa]
	ldr r1, [r0, #0x7e0]
	ldr r0, [r0, #0xb00]
	add r1, r2, r1, asr #12
	add r0, r1, r0, asr #12
	strh r0, [r8, #0xa]
	ldrsh r2, [r8, #0xa]
	ldr r1, [r9, #0x60]
	mov r0, r8
	add r1, r2, r1, asr #12
	strh r1, [r8, #0xa]
	bl AnimatorSprite__DrawFrame
_02177334:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0x1b
	bls _021772C4
	add r10, r9, #0xcb0
	mov r8, #0
	ldrsh r7, [r9, #0x6e]
	ldr r11, [r10, #0x44]
	add r4, r9, #0x2000
	mov r5, r8
	mov r6, #0x12
_02177364:
	mov r1, r6
	cmp r7, #8
	blt _0217738C
	ldr r1, [r10, #0x44]
	sub r0, r7, #8
	mov r0, r0, lsl #0x10
	add r1, r1, #0x40
	str r1, [r10, #0x44]
	mov r7, r0, asr #0x10
	b _02177418
_0217738C:
	cmp r7, #0
	rsbgt r0, r7, #0x12
	movgt r0, r0, lsl #0x10
	movgt r1, r0, lsr #0x10
	mov r0, r10
	bl AnimatorSprite__SetAnimation
	mov r0, r10
	mov r1, r5
	mov r2, r5
	bl AnimatorSprite__ProcessAnimation
	ldrsh r0, [sp, #8]
	ldr r1, [r4, #0x8d4]
	ldr r2, [r4, #0xbf4]
	add r0, r0, r1, asr #12
	add r0, r0, r2, asr #12
	add r0, r0, r8, lsl #3
	strh r0, [r10, #8]
	ldrsh r0, [sp, #0xa]
	ldr r1, [r4, #0x8d8]
	ldr r2, [r4, #0xbf8]
	add r0, r0, r1, asr #12
	add r0, r0, r2, asr #12
	strh r0, [r10, #0xa]
	ldrsh r2, [r10, #0xa]
	ldr r1, [r9, #0x64]
	mov r0, r10
	add r1, r2, r1, asr #12
	strh r1, [r10, #0xa]
	bl AnimatorSprite__DrawFrame
	sub r0, r7, #8
	mov r0, r0, lsl #0x10
	ldr r1, [r10, #0x44]
	mov r7, r0, asr #0x10
	add r0, r1, #0x40
	str r0, [r10, #0x44]
_02177418:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #3
	blo _02177364
	str r11, [r10, #0x44]
	mov r6, #0x1c
	add r5, r9, #0x94
	mov r4, #0
	mov r8, #0x64
_02177440:
	mla r7, r6, r8, r5
	mov r0, r7
	mov r1, r4
	mov r2, r4
	bl AnimatorSprite__ProcessAnimation
	add r0, r9, r6, lsl #3
	add r0, r0, #0x2000
	ldrsh r3, [sp, #8]
	ldr r2, [r0, #0x7dc]
	ldr r1, [r0, #0xafc]
	add r2, r3, r2, asr #12
	add r1, r2, r1, asr #12
	strh r1, [r7, #8]
	ldrsh r2, [sp, #0xa]
	ldr r1, [r0, #0x7e0]
	ldr r0, [r0, #0xb00]
	add r1, r2, r1, asr #12
	add r0, r1, r0, asr #12
	strh r0, [r7, #0xa]
	ldrsh r2, [r7, #0xa]
	ldr r1, [r9, #0x64]
	mov r0, r7
	add r1, r2, r1, asr #12
	strh r1, [r7, #0xa]
	bl AnimatorSprite__DrawFrame
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0x1e
	bls _02177440
	mov r7, #0
	add r6, r9, #0x94
	mov r5, r7
	mov r4, #0x64
_021774C8:
	add r0, r7, #0xb
	mla r8, r0, r4, r6
	ldr r0, [r8, #0x14]
	cmp r0, #0
	beq _02177540
	mov r0, r8
	mov r1, r5
	mov r2, r5
	bl AnimatorSprite__ProcessAnimation
	add r0, r9, r7, lsl #3
	add r0, r0, #0x2000
	ldrsh r3, [sp, #8]
	ldr r2, [r0, #0x834]
	ldr r1, [r0, #0xb54]
	add r2, r3, r2, asr #12
	add r1, r2, r1, asr #12
	strh r1, [r8, #8]
	ldrsh r2, [sp, #0xa]
	ldr r1, [r0, #0x838]
	ldr r0, [r0, #0xb58]
	add r1, r2, r1, asr #12
	add r0, r1, r0, asr #12
	strh r0, [r8, #0xa]
	add r0, r9, r7, lsl #2
	ldrsh r2, [r8, #0xa]
	ldr r1, [r0, #0x5c]
	mov r0, r8
	add r1, r2, r1, asr #12
	strh r1, [r8, #0xa]
	bl AnimatorSprite__DrawFrame
_02177540:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #3
	blo _021774C8
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0217755C: .word StageTask__shakeOffsetTable
	arm_func_end SailHUD__Func_2176C6C

	arm_func_start SailHUD__Func_2177560
SailHUD__Func_2177560: // 0x02177560
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	add r2, sp, #0
	mov r1, #0
	strh r1, [r2]
	strh r1, [r2, #2]
	ldr r1, [r5, #0]
	tst r1, #4
	ldmneia sp!, {r3, r4, r5, pc}
	tst r1, #0x400
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrsh r1, [r5, #0x32]
	cmp r1, #0
	beq _021775C8
	mov r1, r1, asr #1
	ldr r2, _02177784 // =StageTask__shakeOffsetTable
	and r1, r1, #0xf
	ldrsb r1, [r2, r1]
	strh r1, [sp]
	ldrsh r1, [r5, #0x32]
	mov r1, r1, asr #1
	add r1, r1, #1
	and r1, r1, #0xf
	ldrsb r1, [r2, r1]
	strh r1, [sp, #2]
_021775C8:
	ldr r1, [r0, #0x1c]
	add r0, r5, #0x28c
	cmp r1, #0x14
	add r4, r0, #0x1000
	ldreq r0, _02177788 // =0x0000100C
	mov r1, #0
	streq r0, [r4, #0x38]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r5, #0x2000
	ldrsh r3, [sp]
	ldr r2, [r0, #0x94c]
	ldr r1, [r0, #0xc6c]
	add r2, r3, r2, asr #12
	add r1, r2, r1, asr #12
	strh r1, [r4, #8]
	ldr r1, [r0, #0x950]
	ldrsh r2, [sp, #2]
	ldr r0, [r0, #0xc70]
	add r1, r2, r1, asr #12
	add r0, r1, r0, asr #12
	strh r0, [r4, #0xa]
	ldr r1, [r4, #0x3c]
	mov r0, r4
	bic r1, r1, #0x80
	str r1, [r4, #0x3c]
	bl AnimatorSprite__DrawFrame
	add r1, r5, #0x2000
	ldrsh r3, [sp]
	ldr r2, [r1, #0x94c]
	ldr r0, [r1, #0xc6c]
	add r2, r3, r2, asr #12
	add r0, r2, r0, asr #12
	strh r0, [r4, #8]
	ldrsh r2, [r4, #8]
	mov r0, r4
	add r2, r2, #0xe0
	strh r2, [r4, #8]
	ldr r2, [r1, #0x950]
	ldrsh r3, [sp, #2]
	ldr r1, [r1, #0xc70]
	add r2, r3, r2, asr #12
	add r1, r2, r1, asr #12
	strh r1, [r4, #0xa]
	ldr r1, [r4, #0x3c]
	orr r1, r1, #0x80
	str r1, [r4, #0x3c]
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0x3c]
	tst r0, #0x40000000
	beq _021776CC
	ldrh r0, [r5, #0x72]
	add r0, r0, #1
	strh r0, [r5, #0x72]
	ldrh r0, [r5, #0x72]
	tst r0, #7
	bne _021776CC
	ldr r0, [r5, #0x10]
	cmp r0, #0
	beq _021776CC
	mov r0, #0
	mov r2, r0
	mov r1, #0x42
	bl SailAudio__PlaySpatialSequence
_021776CC:
	add r0, r5, #0x2f0
	add r4, r0, #0x1000
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r5, #0x2000
	ldrsh r3, [sp]
	ldr r2, [r0, #0x954]
	ldr r1, [r0, #0xc74]
	add r2, r3, r2, asr #12
	add r1, r2, r1, asr #12
	strh r1, [r4, #8]
	ldrsh r2, [sp, #2]
	ldr r1, [r0, #0x958]
	ldr r0, [r0, #0xc78]
	add r1, r2, r1, asr #12
	add r0, r1, r0, asr #12
	strh r0, [r4, #0xa]
	ldr r1, [r4, #0x3c]
	mov r0, r4
	bic r1, r1, #0x80
	str r1, [r4, #0x3c]
	bl AnimatorSprite__DrawFrame
	add r1, r5, #0x2000
	ldrsh r3, [sp]
	ldr r2, [r1, #0x954]
	ldr r0, [r1, #0xc74]
	add r2, r3, r2, asr #12
	add r0, r2, r0, asr #12
	strh r0, [r4, #8]
	ldrsh r2, [r4, #8]
	mov r0, r4
	add r2, r2, #0x100
	strh r2, [r4, #8]
	ldrsh r3, [sp, #2]
	ldr r2, [r1, #0x958]
	ldr r1, [r1, #0xc78]
	add r2, r3, r2, asr #12
	add r1, r2, r1, asr #12
	strh r1, [r4, #0xa]
	ldr r1, [r4, #0x3c]
	orr r1, r1, #0x80
	str r1, [r4, #0x3c]
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02177784: .word StageTask__shakeOffsetTable
_02177788: .word 0x0000100C
	arm_func_end SailHUD__Func_2177560

	arm_func_start SailBoatWeaponHUD__Destructor
SailBoatWeaponHUD__Destructor: // 0x0217778C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r4, r0
	bl GetCurrentTaskWork_
	mov r0, r4
	bl GetTaskWork_
	mov r7, r0
	mov r0, #0x42
	bl GetObjectFileWork
	bl ObjDataRelease
	mov r8, #0
	add r6, r7, #0x10
	mov r5, r8
	mov r4, r8
	mov r9, #0x64
_021777C4:
	mla r10, r8, r9, r6
	ldr r1, [r10, #0x44]
	cmp r1, #0
	beq _021777DC
	mov r0, r5
	bl VRAMSystem__FreeSpriteVram
_021777DC:
	str r4, [r10, #0x44]
	ldrh r0, [r10, #0x50]
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #3
	blo _021777C4
	add r4, r7, #0x13c
	ldr r1, [r4, #0x44]
	cmp r1, #0
	beq _02177818
	mov r0, #0
	bl VRAMSystem__FreeSpriteVram
_02177818:
	mov r0, #0
	str r0, [r4, #0x44]
	ldrh r0, [r4, #0x50]
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end SailBoatWeaponHUD__Destructor

	arm_func_start SailBoatWeaponHUD__Main
SailBoatWeaponHUD__Main: // 0x02177830
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x14
	bl GetCurrentTaskWork_
	mov r7, r0
	ldr r0, [r7, #0]
	ldr r1, [r7, #8]
	ldr r5, [r0, #0x124]
	ldr r0, [r5, #0x11c]
	bl FX_Div
	mov r0, r0, asr #0xc
	strh r0, [r7, #6]
	ldr r0, [r7, #0]
	ldr r0, [r0, #0x18]
	tst r0, #4
	bne _02177878
	ldr r0, [r5, #0x11c]
	cmp r0, #0
	bgt _02177880
_02177878:
	mov r0, #0x40
	strh r0, [r7, #4]
_02177880:
	ldrh r0, [r7, #4]
	add r0, r0, #1
	strh r0, [r7, #4]
	ldrh r0, [r7, #4]
	cmp r0, #0x40
	blo _021778AC
	mov r0, #0
	str r0, [r5, #0x168]
	bl DestroyCurrentTask
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
_021778AC:
	ldr r0, [r7, #0]
	ldrsh r4, [r7, #6]
	add r0, r0, #0x44
	add r3, sp, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [sp, #0xc]
	add r1, sp, #4
	rsb r8, r0, #0
	str r8, [sp, #0xc]
	ldr r6, [r5, #8]
	ldr r0, [r5, #0x50]
	add r2, sp, #0
	add r0, r6, r0
	add r6, r8, r0
	str r6, [sp, #0xc]
	ldr r5, [r7, #0xc]
	mov r0, r3
	add r3, r6, r5
	str r3, [sp, #0xc]
	bl NNS_G3dWorldPosToScrPos
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	mov r9, #0
	mov r10, r9
	mov r5, r9
	mov r6, #0x15
_0217791C:
	add r8, r7, #0x10
	cmp r4, #0
	addle r8, r7, #0x74
	ble _02177960
	cmp r4, #8
	bge _02177960
	rsb r0, r4, #8
	add r0, r6, r0
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	add r0, r7, #0xd8
	mov r8, r0
	bl AnimatorSprite__SetAnimation
	mov r1, r5
	mov r2, r5
	mov r0, r8
	bl AnimatorSprite__ProcessAnimation
_02177960:
	ldr r1, [sp, #4]
	mov r0, r8
	add r1, r1, r10
	sub r1, r1, #0x10
	strh r1, [r8, #8]
	ldr r1, [sp]
	strh r1, [r8, #0xa]
	bl AnimatorSprite__DrawFrame
	sub r0, r4, #8
	mov r0, r0, lsl #0x10
	add r9, r9, #1
	cmp r9, #4
	mov r4, r0, asr #0x10
	add r10, r10, #8
	blt _0217791C
	ldr r1, [sp, #4]
	add r0, r7, #0x13c
	sub r1, r1, #0x11
	strh r1, [r0, #8]
	ldr r1, [sp]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end SailBoatWeaponHUD__Main

	arm_func_start SailScoreBonus__Main
SailScoreBonus__Main: // 0x021779C0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailManager__GetWork
	ldrh r1, [r4, #4]
	sub r1, r1, #1
	strh r1, [r4, #4]
	ldrh r1, [r4, #4]
	cmp r1, #0
	bne _021779F8
	bl DestroyCurrentTask
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_021779F8:
	cmp r1, #8
	bhi _02177A08
	tst r1, #1
	beq _02177A34
_02177A08:
	ldrsh r2, [r4, #2]
	mov r1, #0
	str r2, [sp]
	str r1, [sp, #4]
	ldrh r1, [r4, #6]
	str r1, [sp, #8]
	ldrh r2, [r4, #8]
	ldrsh r3, [r4, #0]
	ldr r0, [r0, #0xa4]
	ldr r1, [r4, #0xc]
	bl SailHUD__DrawNumbers
_02177A34:
	ldrh r0, [r4, #6]
	cmp r0, #0
	subne r0, r0, #1
	strneh r0, [r4, #6]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	arm_func_end SailScoreBonus__Main

	arm_func_start SailHUD__DrawNumbers
SailHUD__DrawNumbers: // 0x02177A4C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	ldrh r11, [sp, #0x3c]
	str r0, [sp]
	add r0, r0, #0x94
	ldrsh r9, [sp, #0x38]
	ldrh r7, [sp, #0x40]
	str r1, [sp, #4]
	str r2, [sp, #8]
	mov r10, r3
	mov r4, #0
	mov r8, #7
	mov r5, #0x1c
	mov r6, #0x23
	str r0, [sp, #0xc]
_02177A88:
	ldr r0, [sp, #4]
	cmp r8, r11
	mov r0, r0, lsr r5
	and r0, r0, #0xf
	blt _02177AA4
	cmp r8, #0
	bne _02177AA8
_02177AA4:
	mov r4, #1
_02177AA8:
	cmp r0, #0
	cmpeq r4, #0
	beq _02177AEC
	add r2, r0, #0x30
	ldr r0, [sp, #0xc]
	mov r1, #0x64
	mla r0, r2, r1, r0
	sub r1, r10, r6
	strh r1, [r0, #8]
	sub r2, r7, r8
	strh r9, [r0, #0xa]
	cmp r2, #0
	ldrgtsh r1, [r0, #0xa]
	mov r4, #1
	addgt r1, r1, r2
	strgth r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
_02177AEC:
	sub r5, r5, #4
	sub r6, r6, #5
	sub r0, r8, #1
	mov r0, r0, lsl #0x10
	movs r8, r0, asr #0x10
	bpl _02177A88
	ldr r0, [sp, #8]
	cmp r0, #1
	addls sp, sp, #0x10
	ldmlsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp]
	add r1, r10, #5
	add r0, r0, #0x33c
	add r0, r0, #0x1400
	strh r1, [r0, #8]
	strh r9, [r0, #0xa]
	ldrsh r2, [r0, #0xa]
	ldrh r1, [sp, #0x40]
	sub r1, r2, r1
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, [sp]
	add r2, r0, #0x94
	ldr r0, [sp, #8]
	add r1, r0, #0x30
	mov r0, #0x64
	mla r0, r1, r0, r2
	add r1, r10, #0xa
	strh r1, [r0, #8]
	strh r9, [r0, #0xa]
	ldrsh r2, [r0, #0xa]
	ldrh r1, [sp, #0x40]
	sub r1, r2, r1
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end SailHUD__DrawNumbers

	arm_func_start SailHUD__Func_2177B80
SailHUD__Func_2177B80: // 0x02177B80
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldrh r9, [sp, #0x28]
	mov r10, r1
	mov r11, r2
	str r3, [sp]
	mov r6, #0
	mov r5, #7
	mov r7, #0x1c
	mov r8, #0x46
	add r4, r0, #0x94
_02177BA8:
	mov r0, r10, lsr r7
	and r0, r0, #0xf
	cmp r5, r9
	blt _02177BC0
	cmp r5, #0
	bne _02177BC4
_02177BC0:
	mov r6, #1
_02177BC4:
	cmp r0, #0
	cmpeq r6, #0
	beq _02177BF4
	add r1, r0, #0x4c
	mov r0, #0x64
	mla r0, r1, r0, r4
	sub r1, r11, r8
	strh r1, [r0, #8]
	ldr r1, [sp]
	mov r6, #1
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
_02177BF4:
	sub r0, r5, #1
	mov r0, r0, lsl #0x10
	sub r7, r7, #4
	movs r5, r0, asr #0x10
	sub r8, r8, #0xa
	bpl _02177BA8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end SailHUD__Func_2177B80

	arm_func_start SailHUD__Func_2177C10
SailHUD__Func_2177C10: // 0x02177C10
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	ldr r10, [sp, #0x60]
	mov r4, r0
	str r2, [sp, #4]
	mov r0, #0
	str r1, [sp]
	mov r11, r3
	cmp r10, #0
	str r0, [sp, #0x24]
	beq _02177C48
	ldr r0, _02177E08 // =0x00000406
	bl ObjDrawGetRowForID
	str r0, [sp, #0x1c]
_02177C48:
	ldrh r0, [sp, #0x54]
	mov r2, #0x64
	ldrsh r8, [sp, #0x58]
	str r0, [sp, #0xc]
	add r0, r4, #0x94
	str r0, [sp, #0x28]
	ldr r0, [sp, #0xc]
	mov r1, r10, lsl #0x10
	add r4, r0, #0xa
	add r3, r0, #0xb
	ldr r0, [sp, #0x28]
	ldrsh r5, [sp, #0x5c]
	mla r6, r4, r2, r0
	mla r7, r3, r2, r0
	ldrh r0, [sp, #0x50]
	mov r9, #7
	str r0, [sp, #0x10]
	mov r0, r1, asr #0x10
	str r0, [sp, #8]
	mov r0, #0x1c
	str r0, [sp, #0x18]
	rsb r0, r8, r8, lsl #3
	str r0, [sp, #0x14]
_02177CA4:
	ldr r0, [sp, #0x10]
	ldr r1, [sp]
	cmp r9, r0
	ldr r0, [sp, #0x18]
	mov r0, r1, lsr r0
	and r1, r0, #0xf
	blt _02177CC8
	cmp r9, #0
	bne _02177CD0
_02177CC8:
	mov r0, #1
	str r0, [sp, #0x24]
_02177CD0:
	cmp r1, #0
	ldreq r0, [sp, #0x24]
	cmpeq r0, #0
	beq _02177DD8
	ldr r0, [sp, #0xc]
	cmp r10, #0
	add r2, r0, r1
	ldr r0, [sp, #0x28]
	mov r1, #0x64
	mla r4, r2, r1, r0
	mov r0, #1
	str r0, [sp, #0x24]
	beq _02177D10
	ldr r0, [sp, #8]
	bl ObjDrawGetRowForID
	strh r0, [r4, #0x50]
_02177D10:
	ldr r0, [sp, #0x14]
	mov r1, r9, asr #1
	mla r2, r1, r5, r0
	ldr r0, [sp, #4]
	sub r0, r0, r2
	strh r0, [r4, #8]
	strh r11, [r4, #0xa]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	cmp r10, #0
	ldrne r0, [sp, #0x1c]
	strneh r0, [r4, #0x50]
	cmp r9, #4
	cmpne r9, #6
	bne _02177D94
	ldrsh r0, [r4, #8]
	cmp r10, #0
	mov r4, r6
	str r0, [sp, #0x20]
	beq _02177D6C
	ldr r0, [sp, #8]
	bl ObjDrawGetRowForID
	strh r0, [r6, #0x50]
_02177D6C:
	ldr r0, [sp, #0x20]
	add r0, r0, r8
	add r0, r0, r5, asr #4
	strh r0, [r6, #8]
	strh r11, [r6, #0xa]
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	cmp r10, #0
	ldrne r0, [sp, #0x1c]
	strneh r0, [r6, #0x50]
_02177D94:
	cmp r9, #2
	bne _02177DD8
	ldrsh r4, [r4, #8]
	cmp r10, #0
	beq _02177DB4
	ldr r0, [sp, #8]
	bl ObjDrawGetRowForID
	strh r0, [r7, #0x50]
_02177DB4:
	add r0, r4, r8
	add r0, r0, r5, asr #4
	strh r0, [r7, #8]
	strh r11, [r7, #0xa]
	mov r0, r7
	bl AnimatorSprite__DrawFrame
	cmp r10, #0
	ldrne r0, [sp, #0x1c]
	strneh r0, [r7, #0x50]
_02177DD8:
	ldr r0, [sp, #0x18]
	sub r0, r0, #4
	str r0, [sp, #0x18]
	ldr r0, [sp, #0x14]
	sub r0, r0, r8
	str r0, [sp, #0x14]
	sub r0, r9, #1
	mov r0, r0, lsl #0x10
	movs r9, r0, asr #0x10
	bpl _02177CA4
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02177E08: .word 0x00000406
	arm_func_end SailHUD__Func_2177C10

	arm_func_start SailHUD__Func_2177E0C
SailHUD__Func_2177E0C: // 0x02177E0C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	add r4, sp, #4
	mov r6, #0
	mov r10, r0
	strh r6, [r4]
	strh r6, [r4, #2]
	ldrsh r0, [r10, #0x32]
	mov r9, r1
	mov r11, r2
	str r3, [sp]
	cmp r0, #0
	beq _02177E6C
	mov r0, r0, asr #1
	ldr r1, _02177F04 // =StageTask__shakeOffsetTable
	and r0, r0, #0xf
	ldrsb r0, [r1, r0]
	strh r0, [sp, #4]
	ldrsh r0, [r10, #0x32]
	mov r0, r0, asr #1
	add r0, r0, #1
	and r0, r0, #0xf
	ldrsb r0, [r1, r0]
	strh r0, [sp, #6]
_02177E6C:
	mov r5, #7
	mov r7, #0x1c
	mov r8, #0x2a
	add r4, r10, #0x94
_02177E7C:
	ldr r0, [sp]
	ldr r1, [r10, #0x88]
	cmp r5, r0
	mov r0, r1, lsr r7
	and r0, r0, #0xf
	blt _02177E9C
	cmp r5, #0
	bne _02177EA0
_02177E9C:
	mov r6, #1
_02177EA0:
	cmp r0, #0
	cmpeq r6, #0
	beq _02177EDC
	add r1, r0, #0x40
	mov r0, #0x64
	mla r0, r1, r0, r4
	ldrsh r1, [sp, #4]
	mov r6, #1
	add r1, r9, r1
	sub r1, r1, r8
	strh r1, [r0, #8]
	ldrsh r1, [sp, #6]
	add r1, r11, r1
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
_02177EDC:
	sub r0, r5, #1
	mov r0, r0, lsl #0x10
	sub r7, r7, #4
	movs r5, r0, asr #0x10
	sub r8, r8, #6
	bpl _02177E7C
	ldr r0, [r10, #0x88]
	str r0, [r10, #0x8c]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02177F04: .word StageTask__shakeOffsetTable
	arm_func_end SailHUD__Func_2177E0C

	arm_func_start SailHUD__Func_2177F08
SailHUD__Func_2177F08: // 0x02177F08
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	add r5, sp, #8
	mov r4, #0
	mov r10, r0
	strh r4, [r5]
	strh r4, [r5, #2]
	ldr r0, [r10, #0x78]
	mov r9, r1
	mov r11, r2
	str r3, [sp]
	cmp r0, #0
	addeq sp, sp, #0xc
	streq r0, [r10, #0x7c]
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrsh r0, [r10, #0x32]
	cmp r0, #0
	beq _02177F7C
	mov r0, r0, asr #1
	ldr r1, _02178108 // =StageTask__shakeOffsetTable
	and r0, r0, #0xf
	ldrsb r0, [r1, r0]
	strh r0, [sp, #8]
	ldrsh r0, [r10, #0x32]
	mov r0, r0, asr #1
	add r0, r0, #1
	and r0, r0, #0xf
	ldrsb r0, [r1, r0]
	strh r0, [sp, #0xa]
_02177F7C:
	ldr r1, [r10, #0x7c]
	ldr r0, [r10, #0x78]
	cmp r1, r0
	beq _02177FE0
	cmp r1, #0
	moveq r0, #4
	mov r6, #0
	streqh r0, [r10, #0x86]
	mov r1, r6
	mov r2, #4
	mov r0, #0xf
_02177FA8:
	ldr r5, [r10, #0x7c]
	ldr r3, [r10, #0x78]
	and r5, r5, r0, lsl r1
	and r3, r3, r0, lsl r1
	cmp r5, r3
	addne r3, r10, r6, lsl #1
	strneh r2, [r3, #0x80]
	add r3, r6, #1
	mov r3, r3, lsl #0x10
	mov r6, r3, asr #0x10
	cmp r6, #3
	add r1, r1, #4
	add r2, r2, #2
	blt _02177FA8
_02177FE0:
	add r0, r10, #0x94
	mov r8, #7
	mov r6, #0x1c
	mov r7, #0x54
	str r0, [sp, #4]
_02177FF4:
	ldr r0, [sp]
	ldr r1, [r10, #0x78]
	cmp r8, r0
	mov r0, r1, lsr r6
	and r3, r0, #0xf
	blt _02178014
	cmp r8, #0
	bne _02178018
_02178014:
	mov r4, #1
_02178018:
	cmp r3, #0
	cmpeq r4, #0
	beq _0217809C
	ldr r0, [sp, #4]
	add r2, r8, #0x3b
	mov r1, #0x64
	mla r5, r2, r1, r0
	mov r0, r3, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r5
	mov r4, #1
	bl AnimatorSprite__SetAnimation
	ldrsh r2, [sp, #8]
	add r1, r10, r8, lsl #1
	mov r0, r5
	add r2, r9, r2
	sub r2, r2, r7
	strh r2, [r5, #8]
	ldrsh ip, [sp, #0xa]
	ldrsh r3, [r1, #0x80]
	mov r1, #0
	add ip, r11, ip
	sub r3, ip, r3
	mov r2, r1
	strh r3, [r5, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	add r1, r10, r8, lsl #1
	ldrsh r0, [r1, #0x80]
	cmp r0, #0
	subne r0, r0, #1
	strneh r0, [r1, #0x80]
_0217809C:
	sub r0, r8, #1
	mov r0, r0, lsl #0x10
	movs r8, r0, asr #0x10
	sub r6, r6, #4
	sub r7, r7, #0xc
	bpl _02177FF4
	ldrsh r1, [sp, #8]
	add r0, r10, #0x930
	add r2, r9, #8
	add r1, r2, r1
	add r0, r0, #0x1000
	strh r1, [r0, #8]
	ldrsh r1, [sp, #0xa]
	sub r2, r11, #0xc
	ldrsh r3, [r10, #0x86]
	add r1, r2, r1
	add r1, r1, r3, lsl #1
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	ldrsh r0, [r10, #0x86]
	cmp r0, #0
	subne r0, r0, #1
	strneh r0, [r10, #0x86]
	ldr r0, [r10, #0x78]
	str r0, [r10, #0x7c]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02178108: .word StageTask__shakeOffsetTable
	arm_func_end SailHUD__Func_2177F08

	.data

_0218D444: // 0x0218D444
	.byte 0x78, 0xD4, 0x18, 0x02, 0x90, 0xD4, 0x18, 0x02, 0x88, 0xD4, 0x18, 0x02
	.byte 0x80, 0xD4, 0x18, 0x02, 0x60, 0xD4, 0x18, 0x02, 0x70, 0xD4, 0x18, 0x02, 0x68, 0xD4, 0x18, 0x02
	.byte 0x5F, 0x64, 0x65, 0x75, 0x00, 0x00, 0x00, 0x00, 0x5F, 0x73, 0x70, 0x61, 0x00, 0x00, 0x00, 0x00
	.byte 0x5F, 0x69, 0x74, 0x61, 0x00, 0x00, 0x00, 0x00, 0x2E, 0x6D, 0x70, 0x63, 0x00, 0x00, 0x00, 0x00
	.byte 0x5F, 0x66, 0x72, 0x61, 0x00, 0x00, 0x00, 0x00, 0x5F, 0x65, 0x6E, 0x67, 0x00, 0x00, 0x00, 0x00
	.byte 0x5F, 0x6A, 0x70, 0x6E, 0x00
    .align 4

aSbJetLogoFixBa: // 0x0218D498
	.asciz "sb_jet_logo_fix.bac"
    .align 4

aSbFixTitleBac: // 0x0218D4AC
	.asciz "sb_fix_title.bac"
    .align 4

aSbLogoFixBac: // 0x0218D4C0
	.asciz "sb_logo_fix.bac"
    .align 4

aSbFixClearBac: // 0x0218D4D0
	.asciz "sb_fix_clear.bac"
    .align 4

aBbSbBb: // 0x0218D4E4
	.asciz "bb/sb.bb"
    .align 4

aSbArriveMsg: // 0x0218D4F0
	.asciz "sb_arrive_msg"
    .align 4

aSbPauseMsg: // 0x0218D500
	.asciz "sb_pause_msg"
    .align 4

aNlTreBac: // 0x0218D510
	.asciz "nl_tre.bac"
    .align 4
	
aSbSilFixBac: // 0x0218D51C
	.asciz "sb_sil_fix.bac"
    .align 4

aSbFixBac: // 0x0218D52C
	.asciz "sb_fix.bac"
    .align 4

aSbNumberBac: // 0x0218D538
	.asciz "sb_number.bac"
    .align 4

aSbSilKeyBac: // 0x0218D548
	.asciz "sb_sil_key.bac"
    .align 4

aSbFixSubBpmBac: // 0x0218D558
	.asciz "sb_fix_sub_bpm.bac"
    .align 4