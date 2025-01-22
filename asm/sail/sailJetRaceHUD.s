	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailChallengeHUD__Create
SailChallengeHUD__Create: // 0x021880BC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	bl SailManager__GetWork
	mov r0, #0x4800
	mov r4, #4
	str r0, [sp]
	mov r2, #0
	ldr r0, _02188138 // =SailChallengeHUD__Main
	ldr r1, _0218813C // =SailChallengeHUD__Destructor
	mov r3, r2
	str r4, [sp, #4]
	rsb r4, r4, #0x6e0
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02188140 // =0x000006DC
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	mov r0, #0x23000
	str r0, [r4, #0x228]
	ldrh r1, [r4, #4]
	mov r0, r4
	orr r1, r1, #1
	strh r1, [r4, #4]
	bl SailChallengeHUD__Func_2188FCC
	mov r0, r4
	bl SailChallengeHUD__Func_2188E5C
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02188138: .word SailChallengeHUD__Main
_0218813C: .word SailChallengeHUD__Destructor
_02188140: .word 0x000006DC
	arm_func_end SailChallengeHUD__Create

	arm_func_start SailJetRaceGoalHUD__Create
SailJetRaceGoalHUD__Create: // 0x02188144
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r0
	mov r9, r1
	mov r8, r2
	bl SailManager__GetWork
	mov r5, r0
	ldr r0, _021882DC // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r6, r0
	mov r1, #8
	bl StageTask__AllocateWorker
	ldr r1, [r6, #0x18]
	mov r7, r0
	orr r1, r1, #0x400000
	bic r1, r1, #0x800000
	mov r0, #0x45
	str r1, [r6, #0x18]
	bl GetObjectFileWork
	mov r11, r0
	bl SailManager__GetArchive
	mov r4, r0
	mov r0, #0x45
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	mov r1, #5
	bl Sprite__GetSpriteSize2FromAnim
	str r4, [sp]
	str r0, [sp, #4]
	ldr r2, _021882E0 // =aSbFixVsjUpBac
	mov r3, r11
	mov r0, r6
	mov r1, #0
	bl ObjObjectAction2dBACLoad
	cmp r8, #0
	beq _02188228
	ldr r0, [r6, #0x24]
	ldr r2, _021882E4 // =0x00000805
	orr r0, r0, #1
	str r0, [r6, #0x24]
	ldr r0, [r5, #0xc]
	cmp r0, #0
	mov r0, r6
	beq _02188210
	mov r1, #8
	bl ObjActionAllocSpritePalette
	mov r0, r6
	mov r1, #8
	bl StageTask__SetAnimation
	b _02188244
_02188210:
	mov r1, #0xa
	bl ObjActionAllocSpritePalette
	mov r0, r6
	mov r1, #0xa
	bl StageTask__SetAnimation
	b _02188244
_02188228:
	ldr r2, _021882E8 // =0x00000804
	mov r0, r6
	mov r1, #5
	bl ObjActionAllocSpritePalette
	mov r0, r6
	mov r1, #5
	bl StageTask__SetAnimation
_02188244:
	mov r0, r6
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	ldr r0, [r6, #0x24]
	tst r0, #1
	beq _0218826C
	mov r0, #0xe4000
	str r0, [r6, #0x44]
	mov r0, #0x9e000
	b _021882B8
_0218826C:
	bl SailManager__GetWork
	ldr r1, [r0, #0x98]
	mov r0, r9, lsl #0x13
	ldrh r1, [r1, #0xb8]
	mov r1, r1, lsl #0x13
	bl FX_Div
	mov r1, #0xcc000
	umull r4, r3, r0, r1
	mov r2, #0
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	adds r4, r4, #0x800
	adc r0, r3, #0
	mov r1, r4, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x18000
	str r0, [r6, #0x44]
	mov r0, #0x9d000
_021882B8:
	str r0, [r6, #0x48]
	mov r1, r10, lsl #0x13
	str r1, [r7, #4]
	mov r1, r9, lsl #0x13
	mov r0, r6
	str r1, [r7]
	bl SailJetRaceGoalHUD__SetupObject
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021882DC: .word 0x00001010
_021882E0: .word aSbFixVsjUpBac
_021882E4: .word 0x00000805
_021882E8: .word 0x00000804
	arm_func_end SailJetRaceGoalHUD__Create

	arm_func_start SailJetRaceProgressMarkerHUD__Create
SailJetRaceProgressMarkerHUD__Create: // 0x021882EC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r7, r0
	mov r6, r1
	bl SailManager__GetWork
	ldr r0, _02188400 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r4, r0
	ldr r0, [r4, #0x18]
	cmp r7, #0
	orr r0, r0, #0x400000
	bic r0, r0, #0x800000
	movne r5, #2
	moveq r5, #0
	str r0, [r4, #0x18]
	cmp r6, #0
	ldrne r0, [r4, #0x24]
	orrne r0, r0, #1
	strne r0, [r4, #0x24]
	mov r0, #0x45
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	mov r8, r0
	mov r0, #0x45
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	mov r1, r5
	bl Sprite__GetSpriteSize2FromAnim
	str r8, [sp]
	str r0, [sp, #4]
	ldr r2, _02188404 // =aSbFixVsjUpBac
	mov r3, r9
	mov r0, r4
	mov r1, #0
	bl ObjObjectAction2dBACLoad
	cmp r7, #0
	beq _0218839C
	ldr r2, _02188408 // =0x00000803
	mov r0, r4
	mov r1, r5
	bl ObjActionAllocSpritePalette
	b _021883AC
_0218839C:
	ldr r2, _0218840C // =0x00000802
	mov r0, r4
	mov r1, r5
	bl ObjActionAllocSpritePalette
_021883AC:
	mov r0, r4
	mov r1, r5
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorOAMOrder
	mov r1, #0x18000
	mov r0, r4
	str r1, [r4, #0x44]
	mov r1, #0x9d000
	str r1, [r4, #0x48]
	mov r1, r7
	mov r2, r6
	bl SailJetRaceProgressIconHUD__Create
	mov r0, r4
	bl SailJetRaceProgressMarkerHUD__SetupObject
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02188400: .word 0x00001010
_02188404: .word aSbFixVsjUpBac
_02188408: .word 0x00000803
_0218840C: .word 0x00000802
	arm_func_end SailJetRaceProgressMarkerHUD__Create

	arm_func_start SailJetRaceProgressIconHUD__Create
SailJetRaceProgressIconHUD__Create: // 0x02188410
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r8, r0
	mov r7, r1
	mov r6, r2
	bl SailManager__GetWork
	ldr r0, _02188540 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r4, r0
	ldr r0, [r4, #0x18]
	cmp r7, #0
	orr r0, r0, #0x400000
	bic r0, r0, #0x800000
	movne r5, #3
	moveq r5, #1
	str r0, [r4, #0x18]
	cmp r6, #0
	ldrne r0, [r4, #0x24]
	orrne r0, r0, #1
	strne r0, [r4, #0x24]
	mov r0, #0x45
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	mov r6, r0
	mov r0, #0x45
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	mov r1, r5
	bl Sprite__GetSpriteSize2FromAnim
	str r6, [sp]
	str r0, [sp, #4]
	ldr r2, _02188544 // =aSbFixVsjUpBac
	mov r3, r9
	mov r0, r4
	mov r1, #0
	bl ObjObjectAction2dBACLoad
	cmp r7, #0
	beq _021884C4
	ldr r2, _02188548 // =0x00000803
	mov r0, r4
	mov r1, r5
	bl ObjActionAllocSpritePalette
	b TripleGrindRail__stru_21884D4
_021884C4:
	ldr r2, _0218854C // =0x00000802
	mov r0, r4
	mov r1, r5
	bl ObjActionAllocSpritePalette
TripleGrindRail__stru_21884D4:
	mov r0, r4
	mov r1, r5
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorOAMOrder
	ldr r5, [r4, #0x128]
	mov r0, r4
	ldr r3, [r5, #0x3c]
	mov r1, r8
	orr r3, r3, #0x200
	mov r2, #0x400
	str r3, [r5, #0x3c]
	bl StageTask__SetParent
	mov r0, #0xf000
	rsb r0, r0, #0
	str r0, [r4, #0x6c]
	cmp r7, #0
	subne r0, r0, #0x5000
	strne r0, [r4, #0x6c]
	mov r0, r4
	bl SailJetRaceProgressIconHUD__SetupObject
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02188540: .word 0x00001010
_02188544: .word aSbFixVsjUpBac
_02188548: .word 0x00000803
_0218854C: .word 0x00000802
	arm_func_end SailJetRaceProgressIconHUD__Create

	arm_func_start SailJetRaceOpponentWarningHUD__Create
SailJetRaceOpponentWarningHUD__Create: // 0x02188550
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x24]
	tst r0, #0xb
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, _02188624 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r6, r0
	mov r0, #0x46
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	mov r4, r0
	mov r0, #0x46
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	mov r1, #6
	bl Sprite__GetSpriteSize2FromAnim
	str r4, [sp]
	str r0, [sp, #4]
	ldr r2, _02188628 // =aSbFixVsjUnderB
	mov r3, r5
	mov r0, r6
	mov r1, #0
	bl ObjObjectAction2dBACLoad
	ldr r2, _0218862C // =0x00000419
	mov r0, r6
	mov r1, #6
	bl ObjActionAllocSpritePalette
	mov r0, r6
	mov r1, #6
	bl StageTask__SetAnimation
	mov r0, r6
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	mov r0, r6
	mov r1, #0
	bl StageTask__SetAnimatorOAMOrder
	ldr r2, [r6, #0x20]
	mov r1, r7
	orr r2, r2, #0x24
	str r2, [r6, #0x20]
	mov r0, r6
	mov r2, #0
	bl StageTask__SetParent
	mov r0, r6
	bl SailJetRaceOpponentWarningHUD__SetupObject
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02188624: .word 0x00001010
_02188628: .word aSbFixVsjUnderB
_0218862C: .word 0x00000419
	arm_func_end SailJetRaceOpponentWarningHUD__Create

	arm_func_start SailJetRaceCheckpointTextHUD__Create
SailJetRaceCheckpointTextHUD__Create: // 0x02188630
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x24]
	tst r0, #0xb
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	bl SailManager__GetShipType
	cmp r0, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	bl SailManager__GetShipType
	cmp r0, #3
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, _02188734 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r6, r0
	mov r0, #0x46
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	mov r4, r0
	mov r0, #0x46
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	mov r1, #0
	bl Sprite__GetSpriteSize2FromAnim
	str r4, [sp]
	str r0, [sp, #4]
	ldr r2, _02188738 // =aSbFixVsjUnderB
	mov r3, r5
	mov r0, r6
	mov r1, #0
	bl ObjObjectAction2dBACLoad
	ldr r2, _0218873C // =0x00000409
	mov r0, r6
	mov r1, #0
	bl ObjActionAllocSpritePalette
	cmp r7, #0
	mov r0, r6
	bne _021886EC
	mov r1, #0
	bl StageTask__SetAnimation
	b _021886F4
_021886EC:
	mov r1, #1
	bl StageTask__SetAnimation
_021886F4:
	mov r0, r6
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	mov r0, r6
	mov r1, #0
	bl StageTask__SetAnimatorOAMOrder
	mov r1, #0x50000
	mov r0, r6
	str r1, [r6, #0x44]
	bl SailJetRaceCheckpointTextHUD__SetupObject
	mov r0, #0
	mov r2, r0
	mov r1, #0x22
	bl SailAudio__PlaySpatialSequence
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02188734: .word 0x00001010
_02188738: .word aSbFixVsjUnderB
_0218873C: .word 0x00000409
	arm_func_end SailJetRaceCheckpointTextHUD__Create

	arm_func_start SailJetRaceCheckpointIconHUD__Create
SailJetRaceCheckpointIconHUD__Create: // 0x02188740
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r0
	mov r9, r1
	mov r8, r2
	mov r7, r3
	bl SailManager__GetWork
	ldr r0, [r0, #0x24]
	tst r0, #3
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SailManager__GetShipType
	cmp r0, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SailManager__GetShipType
	cmp r0, #3
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, _021888B0 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #0x40
	mov r5, r0
	bl StageTask__AllocateWorker
	mov r6, r0
	mov r0, #0x46
	bl GetObjectFileWork
	mov r11, r0
	bl SailManager__GetArchive
	mov r4, r0
	mov r0, #0x46
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	mov r1, #2
	bl Sprite__GetSpriteSize2FromAnim
	str r4, [sp]
	str r0, [sp, #4]
	ldr r2, _021888B4 // =aSbFixVsjUnderB
	mov r3, r11
	mov r0, r5
	mov r1, #0
	bl ObjObjectAction2dBACLoad
	ldr r2, _021888B8 // =0x00000409
	mov r0, r5
	mov r1, #2
	bl ObjActionAllocSpritePalette
	cmp r8, #0
	mov r0, r5
	bne _0218881C
	mov r1, #2
	bl StageTask__SetAnimation
	ldr r0, _021888BC // =0x0000040A
	bl ObjDrawGetPaletteForID
	b _0218882C
_0218881C:
	mov r1, #3
	bl StageTask__SetAnimation
	ldr r0, _021888C0 // =0x0000040B
	bl ObjDrawGetPaletteForID
_0218882C:
	mov r4, r0
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimatorOAMOrder
	cmp r4, #0
	beq _02188860
	mov r0, r4
	mov r1, r6
	mov r2, #0x20
	bl MIi_CpuCopy16
_02188860:
	mov r0, #0x50000
	str r0, [r5, #0x44]
	cmp r9, #0
	bne _0218887C
	cmp r8, #0
	subne r0, r0, #0x59000
	strne r0, [r5, #0x48]
_0218887C:
	cmp r9, #0
	beq _02188890
	cmp r8, #0
	moveq r0, #0x9000
	streq r0, [r5, #0x48]
_02188890:
	mov r1, r10
	add r0, r5, #0x28
	bl MultibootManager__Func_2063CF4
	mov r0, r5
	str r7, [r5, #0x2c]
	bl SailJetRaceCheckpointIconHUD__SetupObject
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021888B0: .word 0x00001010
_021888B4: .word aSbFixVsjUnderB
_021888B8: .word 0x00000409
_021888BC: .word 0x0000040A
_021888C0: .word 0x0000040B
	arm_func_end SailJetRaceCheckpointIconHUD__Create

	arm_func_start SailChallengeHUD__Destructor
SailChallengeHUD__Destructor: // 0x021888C4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r5, r0
	bl SailManager__GetWork
	mov r4, r0
	mov r0, r5
	bl GetTaskWork_
	mov r7, r0
	mov r0, #0x44
	bl GetObjectFileWork
	bl ObjDataRelease
	mov r0, #0x45
	bl GetObjectFileWork
	bl ObjDataRelease
	ldr r0, [r4, #0xc]
	cmp r0, #0
	bne _02188910
	ldrh r0, [r4, #0x12]
	cmp r0, #2
	bne _0218891C
_02188910:
	mov r0, #0x46
	bl GetObjectFileWork
	bl ObjDataRelease
_0218891C:
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _02188934
	mov r0, #0x47
	bl GetObjectFileWork
	bl ObjDataRelease
_02188934:
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _0218894C
	mov r0, #0x47
	bl GetObjectFileWork
	bl ObjDataRelease
_0218894C:
	ldr r0, [r4, #0x24]
	tst r0, #0x200000
	beq _02188964
	mov r0, #0x48
	bl GetObjectFileWork
	bl ObjDataRelease
_02188964:
	mov r8, #0
	add r6, r7, #0x22c
	mov r5, #1
	mov r4, r8
	mov r9, #0x64
_02188978:
	mla r10, r8, r9, r6
	ldr r1, [r10, #0x44]
	cmp r1, #0
	beq _02188990
	mov r0, r5
	bl VRAMSystem__FreeSpriteVram
_02188990:
	str r4, [r10, #0x44]
	ldrh r0, [r10, #0x50]
	add r0, r0, #0x10
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #7
	blo _02188978
	add r0, r7, #0xe8
	add r4, r0, #0x400
	ldr r1, [r4, #0x44]
	cmp r1, #0
	beq _021889D4
	mov r0, #1
	bl VRAMSystem__FreeSpriteVram
_021889D4:
	mov r0, #0
	str r0, [r4, #0x44]
	ldrh r0, [r4, #0x50]
	add r0, r0, #0x10
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	add r0, r7, #0x14c
	add r4, r0, #0x400
	ldr r1, [r4, #0x44]
	cmp r1, #0
	beq _02188A08
	mov r0, #1
	bl VRAMSystem__FreeSpriteVram
_02188A08:
	ldrh r0, [r4, #0x50]
	add r0, r0, #0x10
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	add r4, r7, #0x5b0
	ldr r1, [r4, #0x44]
	cmp r1, #0
	beq _02188A30
	mov r0, #0
	bl VRAMSystem__FreeSpriteVram
_02188A30:
	ldrh r0, [r4, #0x50]
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	add r0, r7, #0x214
	add r4, r0, #0x400
	ldr r1, [r4, #0x44]
	cmp r1, #0
	beq _02188A58
	mov r0, #0
	bl VRAMSystem__FreeSpriteVram
_02188A58:
	ldrh r0, [r4, #0x50]
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	add r0, r7, #0x278
	add r4, r0, #0x400
	ldr r1, [r4, #0x44]
	cmp r1, #0
	beq _02188A80
	mov r0, #1
	bl VRAMSystem__FreeSpriteVram
_02188A80:
	ldrh r0, [r4, #0x50]
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end SailChallengeHUD__Destructor

	arm_func_start SailChallengeHUD__Main
SailChallengeHUD__Main: // 0x02188A90
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	mov r6, r0
	bl SailManager__GetWork
	mov r7, r0
	ldr r0, [r7, #0xc]
	cmp r0, #0
	beq _02188CAC
	ldr r0, [r6, #0]
	tst r0, #0x40
	andeq r0, r0, #0x3f
	rsbeq r0, r0, #0x40
	moveq r0, r0, lsl #0x16
	beq _02188AD8
	mov r0, r0, lsl #0x1a
	mov r0, r0, lsr #0x14
	mov r0, r0, lsl #0x10
_02188AD8:
	mov r4, r0, lsr #0x10
	add r0, r6, #0x46
	add r1, r6, #6
	add r2, r6, #0x26
	mov r3, #0x10
	str r4, [sp]
	bl ObjDraw__ChangeColors
	add r0, r6, #0x500
	ldrh r0, [r0, #0x38]
	add r0, r0, #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ObjDraw__GetHWPaletteRow
	mov r3, r0
	add r0, r6, #0x46
	mov r1, #0x10
	mov r2, #0
	bl QueueUncompressedPalette
	ldr r0, [r6, #0]
	tst r0, #0x80
	beq _02188BF4
	and r9, r0, #0x7f
	add r0, r6, #0x46
	mov r8, #0
	add r4, r0, #0x100
	add r5, r6, #0x66
	mov r10, #0x10
	mov r11, #0x64
_02188B48:
	cmp r9, r8
	bne _02188BA0
	mov r0, #0xa
	mov r2, #0xa
	stmia sp, {r0, r10}
	add r0, r5, r8, lsl #5
	add r1, r4, r8, lsl #5
	mov r3, r2
	bl ObjDraw__TintColorArray
	mla r0, r8, r11, r6
	add r0, r0, #0x200
	ldrh r0, [r0, #0x7c]
	add r0, r0, #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ObjDraw__GetHWPaletteRow
	mov r3, r0
	add r0, r5, r8, lsl #5
	mov r1, #0x10
	mov r2, #0
	bl QueueUncompressedPalette
	b _02188BE0
_02188BA0:
	add r0, r8, #2
	cmp r9, r0
	bne _02188BE0
	mov r0, #0x64
	mla r0, r8, r0, r6
	add r0, r0, #0x200
	ldrh r0, [r0, #0x7c]
	add r0, r0, #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ObjDraw__GetHWPaletteRow
	mov r3, r0
	add r0, r4, r8, lsl #5
	mov r1, #0x10
	mov r2, #0
	bl QueueUncompressedPalette
_02188BE0:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #7
	blo _02188B48
_02188BF4:
	add r0, r6, #0x214
	add r4, r0, #0x400
	ldrh r0, [r4, #0xc]
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _02188CAC
_02188C0C: // jump table
	b _02188CAC // case 0
	b _02188CAC // case 1
	b _02188CAC // case 2
	b _02188CAC // case 3
	b _02188C30 // case 4
	b _02188C54 // case 5
	b _02188CAC // case 6
	b _02188C78 // case 7
	b _02188C94 // case 8
_02188C30:
	ldrh r0, [r7, #0x28]
	cmp r0, #0
	beq _02188CAC
	mov r0, r4
	mov r1, #7
	bl AnimatorSprite__SetAnimation
	mov r0, #0x2000
	str r0, [r4, #0x38]
	b _02188CAC
_02188C54:
	ldrh r0, [r7, #0x28]
	cmp r0, #0
	bne _02188CAC
	mov r0, r4
	mov r1, #8
	bl AnimatorSprite__SetAnimation
	mov r0, #0x2000
	str r0, [r4, #0x38]
	b _02188CAC
_02188C78:
	ldr r0, [r4, #0x3c]
	tst r0, #0x40000000
	beq _02188CAC
	mov r0, r4
	mov r1, #5
	bl AnimatorSprite__SetAnimation
	b _02188CAC
_02188C94:
	ldr r0, [r4, #0x3c]
	tst r0, #0x40000000
	beq _02188CAC
	mov r0, r4
	mov r1, #4
	bl AnimatorSprite__SetAnimation
_02188CAC:
	ldr r0, [r7, #0x24]
	tst r0, #1
	bne _02188CFC
	ldrh r0, [r6, #4]
	tst r0, #1
	beq _02188D24
	mov r0, #0x400
	str r0, [sp]
	mov r1, #0
	ldr r0, [r6, #0x228]
	mov r3, r1
	mov r2, #2
	bl ObjShiftSet
	str r0, [r6, #0x228]
	cmp r0, #0
	bne _02188D24
	ldrh r0, [r6, #4]
	bic r0, r0, #1
	strh r0, [r6, #4]
	b _02188D24
_02188CFC:
	tst r0, #2
	beq _02188D24
	mov r0, #0x400
	str r0, [sp]
	ldr r0, [r6, #0x228]
	mov r1, #0x23000
	mov r2, #2
	mov r3, #0
	bl ObjShiftSet
	str r0, [r6, #0x228]
_02188D24:
	add r4, r6, #0x14c
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x400
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x400
	bl AnimatorSprite__DrawFrame
	ldr r0, [r7, #0xc]
	cmp r0, #0
	beq _02188E1C
	add r4, r6, #0xe8
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x400
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x400
	bl AnimatorSprite__DrawFrame
	add r0, r6, #0x214
	ldr r1, [r6, #0x228]
	add r4, r0, #0x400
	rsb r0, r1, #0
	mov r3, r0, asr #0xc
	mov r1, #0
	mov r0, r4
	mov r2, r1
	strh r3, [r4, #8]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldr r1, [r6, #0x228]
	add r4, r6, #0x5b0
	rsb r1, r1, #0
	mov r1, r1, asr #0xc
	strh r1, [r4, #8]
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r10, #0
	ldr r9, _02188E58 // =saveGame+0x000001D0
	add r8, r6, #0x22c
	mov r11, r10
	mov r4, #0x64
_02188DD8:
	mov r0, r9
	and r1, r10, #0xff
	bl SaveGame__HasChaosEmerald
	cmp r0, #0
	beq _02188E08
	mul r5, r10, r4
	mov r1, r11
	mov r2, r11
	add r0, r8, r5
	bl AnimatorSprite__ProcessAnimation
	add r0, r8, r5
	bl AnimatorSprite__DrawFrame
_02188E08:
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
	cmp r10, #7
	blo _02188DD8
_02188E1C:
	ldr r0, [r7, #0x24]
	tst r0, #0x200000
	beq _02188E44
	add r4, r6, #0x278
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x400
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x400
	bl AnimatorSprite__DrawFrame
_02188E44:
	ldr r0, [r6, #0]
	add r0, r0, #1
	str r0, [r6]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02188E58: .word saveGame+0x000001D0
	arm_func_end SailChallengeHUD__Main

	arm_func_start SailChallengeHUD__Func_2188E5C
SailChallengeHUD__Func_2188E5C: // 0x02188E5C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x54
	bl SailManager__GetWork
	mov r4, r0
	mov r6, #0
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02188EA8
_02188E84: // jump table
	b _02188E9C // case 0
	b _02188E9C // case 1
	b _02188E9C // case 2
	b _02188E9C // case 3
	b _02188E9C // case 4
	b _02188E9C // case 5
_02188E9C:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _02188EAC
_02188EA8:
	mov r0, #1
_02188EAC:
	and r5, r0, #0xff
	cmp r5, #5
	ldr r0, [r4, #0xc]
	movhi r5, #5
	cmp r0, #0
	addne r0, r5, #1
	movne r0, r0, lsl #0x10
	movne r6, r0, lsr #0x10
	ldr r0, _02188FC8 // =aBbSbBb_0
	mov r1, r6
	mov r2, #0
	bl ReadFileFromBundle
	mov r7, r0
	bl GetBackgroundWidth
	mov r6, r0
	mov r0, r7
	bl GetBackgroundHeight
	mov r1, #3
	stmia sp, {r1, r6}
	str r0, [sp, #8]
	add r0, sp, #0xc
	mov r1, r7
	mov r2, #0x38
	mov r3, #1
	bl InitBackground
	add r0, sp, #0xc
	bl DrawBackground
	mov r0, r7
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x24]
	ands r1, r0, #0x1000
	ldreqh r0, [r4, #0x12]
	cmpeq r0, #0
	addeq sp, sp, #0x54
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldrh r0, [r4, #0x12]
	add r0, r0, #0xfe
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	movls r0, #0x13
	bls _02188F64
	cmp r1, #0
	movne r0, #7
	moveq r0, #0xd
_02188F64:
	add r0, r0, r5
	mov r1, r0, lsl #0x10
	ldr r0, _02188FC8 // =aBbSbBb_0
	mov r1, r1, lsr #0x10
	mov r2, #0
	bl ReadFileFromBundle
	mov r5, r0
	bl GetBackgroundWidth
	mov r4, r0
	mov r0, r5
	bl GetBackgroundHeight
	mov r1, #2
	stmia sp, {r1, r4}
	str r0, [sp, #8]
	add r0, sp, #0xc
	mov r1, r5
	mov r2, #0x38
	mov r3, #1
	bl InitBackground
	add r0, sp, #0xc
	bl DrawBackground
	mov r0, r5
	bl _FreeHEAP_USER
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02188FC8: .word aBbSbBb_0
	arm_func_end SailChallengeHUD__Func_2188E5C

	arm_func_start SailChallengeHUD__Func_2188FCC
SailChallengeHUD__Func_2188FCC: // 0x02188FCC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	mov r10, r0
	bl SailManager__GetWork
	str r0, [sp, #0x1c]
	mov r0, #0x45
	bl GetObjectFileWork
	mov r4, r0
	bl SailManager__GetArchive
	mov r2, r0
	ldr r1, _02189454 // =aSbFixVsjUpBac
	mov r0, r4
	bl ObjDataLoad
	add r1, r10, #0x14c
	add r5, r1, #0x400
	mov r1, #4
	mov r4, r0
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r3, #1
	str r3, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r1, _02189458 // =0x05000600
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	str r3, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r0, r5
	mov r1, r4
	mov r2, #4
	mov r3, #0x10
	bl AnimatorSprite__Init
	mov r1, #4
	mov r0, r4
	add r2, r1, #0x800
	bl ObjDrawAllocSpritePalette
	strh r0, [r5, #0x50]
	mov r0, #0x18
	strh r0, [r5, #8]
	mov r0, #0x9d
	strh r0, [r5, #0xa]
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _021890A0
	ldr r0, [sp, #0x1c]
	ldrh r0, [r0, #0x12]
	cmp r0, #2
	bne _021890C4
_021890A0:
	mov r0, #0x46
	bl GetObjectFileWork
	mov r4, r0
	bl SailManager__GetArchive
	mov r2, r0
	ldr r1, _0218945C // =aSbFixVsjUnderB
	mov r0, r4
	bl ObjDataLoad
	mov r4, r0
_021890C4:
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	beq _021891B0
	mov r0, r4
	mov r1, #9
	add r5, r10, #0x5b0
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02189458 // =0x05000600
	str r1, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, r5
	str r1, [sp, #0x18]
	mov r1, r4
	mov r2, #9
	mov r3, #0x10
	bl AnimatorSprite__Init
	mov r0, r4
	mov r1, #9
	add r2, r1, #0x3fc
	bl ObjDrawAllocSpritePalette
	strh r0, [r5, #0x50]
	add r0, r10, #0x214
	add r5, r0, #0x400
	mov r0, r4
	mov r1, #5
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r1, _02189458 // =0x05000600
	mov r0, #1
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r0, r5
	mov r1, r4
	mov r2, #5
	mov r3, #0x10
	bl AnimatorSprite__Init
	mov r0, r4
	mov r1, #5
	ldr r2, _02189460 // =0x00000408
	bl ObjDrawAllocSpritePalette
	strh r0, [r5, #0x50]
_021891B0:
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	beq _02189384
	mov r0, #0x47
	bl GetObjectFileWork
	mov r4, r0
	bl SailManager__GetArchive
	mov r2, r0
	ldr r1, _02189464 // =aSbFixEmeraldBa
	mov r0, r4
	bl ObjDataLoad
	add r1, r10, #0xe8
	add r4, r1, #0x400
	mov r1, #0xe
	mov r8, r0
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r3, #1
	str r3, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r1, _02189458 // =0x05000600
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	str r3, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r0, r4
	mov r1, r8
	mov r2, #0xe
	mov r3, #0x10
	bl AnimatorSprite__Init
	ldr r2, _02189468 // =0x00000801
	mov r0, r8
	mov r1, #0xe
	bl ObjDrawAllocSpritePalette
	strh r0, [r4, #0x50]
	mov r0, #0x58
	strh r0, [r4, #8]
	mov r0, #0x5e
	strh r0, [r4, #0xa]
	ldr r0, _02189468 // =0x00000801
	bl ObjDrawGetPaletteForID
	add r1, r10, #6
	mov r2, #0x20
	bl MIi_CpuCopy16
	ldr r1, [sp, #0x1c]
	ldrh r2, [r4, #0x50]
	ldrh r1, [r1, #0x10]
	mov r0, r8
	and r2, r2, #0xff
	add r1, r1, #0xf
	mov r1, r1, lsl #0x10
	mov r3, #1
	mov r1, r1, lsr #0x10
	bl ObjDraw__TintSprite
	ldr r0, _02189468 // =0x00000801
	bl ObjDrawGetPaletteForID
	add r1, r10, #0x26
	mov r2, #0x20
	bl MIi_CpuCopy16
	add r0, r10, #0x46
	mov r6, #0
	add r5, r10, #0x22c
	add r4, r0, #0x100
	mov r11, #1
_021892C4:
	mov r0, #0x64
	mla r9, r6, r0, r5
	mov r0, r8
	mov r1, r6
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	str r11, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, _02189458 // =0x05000600
	mov r2, r6
	str r0, [sp, #0x10]
	mov r0, r1
	str r11, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r9
	mov r1, r8
	mov r3, #0x10
	bl AnimatorSprite__Init
	add r0, r6, #7
	add r7, r0, #0x800
	mov r2, r7, lsl #0x10
	mov r0, r8
	mov r1, r6
	mov r2, r2, asr #0x10
	bl ObjDrawAllocSpritePalette
	mov r1, r7, lsl #0x10
	strh r0, [r9, #0x50]
	mov r0, r1, asr #0x10
	mov r1, r6, lsl #5
	add r1, r1, #0x10
	strh r1, [r9, #8]
	mov r1, #0x37
	strh r1, [r9, #0xa]
	bl ObjDrawGetPaletteForID
	add r1, r4, r6, lsl #5
	mov r2, #0x20
	bl MIi_CpuCopy16
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #7
	blo _021892C4
_02189384:
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0x24]
	tst r0, #0x200000
	addeq sp, sp, #0x20
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, _0218946C // =aBbSbBb_0
	mov r1, #0x23
	mov r2, #0
	bl ReadFileFromBundle
	mov r5, r0
	mov r0, #0x48
	bl GetObjectFileWork
	mov r1, r5
	bl ObjDataSet
	add r1, r10, #0x278
	mov r0, r5
	add r4, r1, #0x400
	mov r1, #0
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r3, #1
	str r3, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r1, _02189458 // =0x05000600
	mov r0, r4
	str r1, [sp, #0x10]
	str r3, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r1, r5
	mov r3, #0x10
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #0
	ldr r2, _02189470 // =0x00000804
	bl ObjDrawAllocSpritePalette
	strh r0, [r4, #0x50]
	mov r0, #0xec
	strh r0, [r4, #8]
	mov r0, #0x14
	strh r0, [r4, #0xa]
	ldr r1, [r4, #0x3c]
	mov r0, #0x2000
	orr r1, r1, #4
	str r1, [r4, #0x3c]
	str r0, [r4, #0x38]
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02189454: .word aSbFixVsjUpBac
_02189458: .word 0x05000600
_0218945C: .word aSbFixVsjUnderB
_02189460: .word 0x00000408
_02189464: .word aSbFixEmeraldBa
_02189468: .word 0x00000801
_0218946C: .word aBbSbBb_0
_02189470: .word 0x00000804
	arm_func_end SailChallengeHUD__Func_2188FCC

	arm_func_start SailJetRaceGoalHUD__SetupObject
SailJetRaceGoalHUD__SetupObject: // 0x02189474
	ldr r1, _02189480 // =SailJetRaceGoalHUD__State_2189484
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_02189480: .word SailJetRaceGoalHUD__State_2189484
	arm_func_end SailJetRaceGoalHUD__SetupObject

	arm_func_start SailJetRaceGoalHUD__State_2189484
SailJetRaceGoalHUD__State_2189484: // 0x02189484
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, r0
	ldr r4, [r9, #0x124]
	bl SailManager__GetWork
	ldr r5, [r0, #0x98]
	bl SailManager__GetWork
	mov r6, r0
	mov r7, #0
	bl SailManager__GetWork
	ldr r8, [r0, #0x8c]
	mov r0, r9
	cmp r8, #0
	ldrne r7, [r8, #0x124]
	bl StageTask__GetAnimID
	cmp r0, #0xb
	addls pc, pc, r0, lsl #2
	b _02189608
_021894C8: // jump table
	b _02189608 // case 0
	b _02189608 // case 1
	b _02189608 // case 2
	b _02189608 // case 3
	b _02189608 // case 4
	b _021894F8 // case 5
	b _0218954C // case 6
	b _02189608 // case 7
	b _021894F8 // case 8
	b _021895D0 // case 9
	b _021894F8 // case 10
	b _021895D0 // case 11
_021894F8:
	ldr r0, [r6, #0x24]
	tst r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r1, [r5, #0x44]
	ldr r0, [r4, #4]
	cmp r1, r0
	blt _02189608
	mov r0, r9
	bl StageTask__GetAnimID
	add r0, r0, #1
	mov r1, r0, lsl #0x10
	mov r0, r9
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	mov r0, r9
	mov r1, #0x1000
	bl SailObject__SetAnimSpeed
	ldr r0, [r9, #0x20]
	orr r0, r0, #4
	str r0, [r9, #0x20]
	b _02189608
_0218954C:
	ldr r1, [r5, #0x44]
	ldr r0, [r4, #0]
	cmp r1, r0
	blt _02189608
	mov r0, r9
	mov r1, #7
	bl StageTask__SetAnimation
	ldr r1, [r9, #0x20]
	mov r0, #0x4000
	bic r1, r1, #4
	str r1, [r9, #0x20]
	str r0, [r9, #4]
	ldr r0, [r9, #0x24]
	tst r0, #2
	bne _02189590
	mov r0, #0
	bl SailJetRaceCheckpointTextHUD__Create
_02189590:
	ldr r0, [r9, #0x24]
	tst r0, #8
	bne _021895B0
	ldrh r1, [r6, #0x28]
	ldr r0, [r6, #0x20]
	ldr r3, [r9, #0x2c]
	mov r2, #0
	bl SailJetRaceCheckpointIconHUD__Create
_021895B0:
	ldr r1, [r9, #0x24]
	mov r0, #0
	orr r3, r1, #0xa
	mov r2, r0
	mov r1, #0x52
	str r3, [r9, #0x24]
	bl SailAudio__PlaySpatialSequence
	b _02189608
_021895D0:
	ldr r1, [r5, #0x44]
	ldr r0, [r4, #0]
	cmp r1, r0
	blt _02189608
	ldr r0, [r9, #0x20]
	tst r0, #4
	beq _021895FC
	bic r0, r0, #4
	str r0, [r9, #0x20]
	mov r0, #0x4000
	str r0, [r9, #4]
_021895FC:
	ldr r0, [r9, #0x24]
	orr r0, r0, #0xa
	str r0, [r9, #0x24]
_02189608:
	cmp r7, #0
	beq _02189688
	ldr r1, [r7, #0x25c]
	ldr r0, [r4, #0]
	cmp r1, r0
	blt _02189688
	ldr r0, [r9, #0x24]
	tst r0, #2
	bne _02189650
	and r0, r0, #1
	bl SailJetRaceCheckpointTextHUD__Create
	ldr r0, [r9, #0x24]
	tst r0, #1
	beq _02189650
	mov r0, r8
	bl SailPlayer__Action_RivalReachedGoal
	mov r0, #0x5b
	bl SailAudio__PlaySequence
_02189650:
	ldr r0, [r9, #0x24]
	tst r0, #4
	bne _0218967C
	ldrh r1, [r6, #0x28]
	ldr r0, [r6, #0x20]
	ldr r3, [r9, #0x2c]
	eor r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, #1
	bl SailJetRaceCheckpointIconHUD__Create
_0218967C:
	ldr r0, [r9, #0x24]
	orr r0, r0, #6
	str r0, [r9, #0x24]
_02189688:
	ldr r0, [r9, #0x24]
	tst r0, #2
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r9, #0x2c]
	add r0, r0, #1
	str r0, [r9, #0x2c]
	cmp r0, #0x12c
	ldrgt r0, [r9, #0x24]
	orrgt r0, r0, #0xc
	strgt r0, [r9, #0x24]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end SailJetRaceGoalHUD__State_2189484

	arm_func_start SailJetRaceProgressMarkerHUD__SetupObject
SailJetRaceProgressMarkerHUD__SetupObject: // 0x021896B4
	ldr r1, _021896C0 // =SailJetRaceProgressMarkerHUD__State_21896C4
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_021896C0: .word SailJetRaceProgressMarkerHUD__State_21896C4
	arm_func_end SailJetRaceProgressMarkerHUD__SetupObject

	arm_func_start SailJetRaceProgressMarkerHUD__State_21896C4
SailJetRaceProgressMarkerHUD__State_21896C4: // 0x021896C4
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r1, [r4, #0x24]
	ldr r5, [r0, #0x98]
	tst r1, #1
	beq _021896EC
	bl SailManager__GetWork
	ldr r1, [r0, #0x8c]
	b _021896F4
_021896EC:
	bl SailManager__GetWork
	ldr r1, [r0, #0x70]
_021896F4:
	ldr r0, [r4, #0x24]
	ldr r1, [r1, #0x124]
	tst r0, #1
	ldrne r0, [r1, #0x25c]
	ldrh r1, [r5, #0xb8]
	ldreq r0, [r5, #0x44]
	mov r1, r1, lsl #0x13
	bl FX_Div
	mov r1, #0xcc000
	umull ip, r3, r0, r1
	mov r2, #0
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	adds ip, ip, #0x800
	adc r0, r3, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r0, lsl #20
	ldr r1, [r4, #0x44]
	add r0, r2, #0x18000
	cmp r1, r0
	strlt r0, [r4, #0x44]
	ldr r0, [r4, #0x44]
	cmp r0, #0xe4000
	movgt r0, #0xe4000
	strgt r0, [r4, #0x44]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailJetRaceProgressMarkerHUD__State_21896C4

	arm_func_start SailJetRaceProgressIconHUD__SetupObject
SailJetRaceProgressIconHUD__SetupObject: // 0x02189760
	ldr r1, _0218976C // =SailJetRaceProgressIconHUD__State_2189770
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0218976C: .word SailJetRaceProgressIconHUD__State_2189770
	arm_func_end SailJetRaceProgressIconHUD__SetupObject

	arm_func_start SailJetRaceProgressIconHUD__State_2189770
SailJetRaceProgressIconHUD__State_2189770: // 0x02189770
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	bl SailManager__GetWork
	ldr r0, [r7, #0x24]
	tst r0, #1
	beq _02189794
	bl SailManager__GetWork
	ldr r6, [r0, #0x8c]
	b _0218979C
_02189794:
	bl SailManager__GetWork
	ldr r6, [r0, #0x70]
_0218979C:
	ldr r0, [r6, #0x20]
	ldr r4, [r6, #0x124]
	tst r0, #0x20
	ldr r0, [r7, #0x20]
	orrne r0, r0, #0x20
	biceq r0, r0, #0x20
	str r0, [r7, #0x20]
	add r0, r4, #0x100
	ldrh r0, [r0, #0xc0]
	cmp r0, #6
	ldr r0, [r7, #0x24]
	bne _021897F8
	tst r0, #2
	bne _021897E8
	mov r0, #0x8000
	str r0, [r7, #4]
	ldr r0, [r7, #0x24]
	orr r0, r0, #2
	str r0, [r7, #0x24]
_021897E8:
	ldrh r0, [r7, #0x34]
	add r0, r0, #0x1000
	strh r0, [r7, #0x34]
	b _021898D4
_021897F8:
	tst r0, #2
	beq _02189814
	mov r0, #0
	strh r0, [r7, #0x34]
	ldr r0, [r7, #0x24]
	bic r0, r0, #2
	str r0, [r7, #0x24]
_02189814:
	bl SailManager__GetShipType
	cmp r0, #0
	bne _021898D4
	ldr r0, [r6, #0x24]
	tst r0, #1
	bne _021898D4
	ldrh r0, [r7, #0x34]
	mov r5, #0
	tst r0, #0x8000
	rsbne r0, r0, #0
	strneh r0, [r7, #0x34]
	add r0, r4, #0x100
	ldrh r0, [r0, #0xc0]
	movne r5, #1
	cmp r0, #8
	blo _0218989C
	cmp r0, #9
	bhi _0218989C
	ldr r0, [r7, #0x24]
	tst r0, #0x10
	bne _02189878
	orr r0, r0, #0x10
	str r0, [r7, #0x24]
	mov r0, #0
	strh r0, [r7, #0x34]
_02189878:
	mov r3, #0
	str r3, [sp]
	ldrh r0, [r7, #0x34]
	mov r5, #1
	mov r2, r5
	mov r1, #0x1000
	bl ObjShiftSet
	strh r0, [r7, #0x34]
	b _021898C4
_0218989C:
	mov r1, #0
	str r1, [sp]
	ldrh r0, [r7, #0x34]
	mov r3, r1
	mov r2, #1
	bl ObjShiftSet
	strh r0, [r7, #0x34]
	ldr r0, [r7, #0x24]
	bic r0, r0, #0x10
	str r0, [r7, #0x24]
_021898C4:
	cmp r5, #0
	ldrneh r0, [r7, #0x34]
	rsbne r0, r0, #0
	strneh r0, [r7, #0x34]
_021898D4:
	bl SailManager__GetShipType
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r6, #0x24]
	tst r0, #1
	ldr r0, [r7, #0x24]
	beq _0218993C
	tst r0, #4
	bne _0218991C
	orr r0, r0, #4
	str r0, [r7, #0x24]
	mov r0, #0x8000
	str r0, [r7, #4]
	mov r1, #0
	strh r1, [r7, #0x34]
	ldr r0, [r7, #0x24]
	tst r0, #8
	streq r1, [r7, #0x2c]
_0218991C:
	mov r3, #0
	str r3, [sp]
	ldrh r0, [r7, #0x34]
	mov r1, #0x1000
	mov r2, #1
	bl ObjShiftSet
	strh r0, [r7, #0x34]
	b _02189944
_0218993C:
	bic r0, r0, #4
	str r0, [r7, #0x24]
_02189944:
	add r0, r4, #0x100
	ldrh r0, [r0, #0xc0]
	cmp r0, #0xb
	blo _0218998C
	cmp r0, #0xe
	bhi _0218998C
	ldr r0, [r7, #0x24]
	tst r0, #8
	bne _02189998
	orr r0, r0, #8
	str r0, [r7, #0x24]
	mov r0, #0x8000
	str r0, [r7, #4]
	ldr r0, [r7, #0x24]
	tst r0, #4
	moveq r0, #0
	streq r0, [r7, #0x2c]
	b _02189998
_0218998C:
	ldr r0, [r7, #0x24]
	bic r0, r0, #8
	str r0, [r7, #0x24]
_02189998:
	ldr r0, [r6, #0x24]
	tst r0, #1
	bne _021899BC
	add r0, r4, #0x100
	ldrh r0, [r0, #0xc0]
	cmp r0, #0xb
	blo _021899F4
	cmp r0, #0xe
	bhi _021899F4
_021899BC:
	ldr r0, [r7, #0x2c]
	ldr r1, [r7, #0x2c]
	tst r0, #8
	movne r0, r0, lsl #0x1d
	movne r0, r0, lsr #0x16
	andeq r0, r0, #7
	rsbeq r0, r0, #8
	moveq r0, r0, lsl #7
	add r1, r1, #1
	add r0, r0, #0x1000
	str r1, [r7, #0x2c]
	str r0, [r7, #0x38]
	str r0, [r7, #0x3c]
	b _02189A00
_021899F4:
	mov r0, #0x1000
	str r0, [r7, #0x38]
	str r0, [r7, #0x3c]
_02189A00:
	mov r0, r7
	bl StageTask__GetAnimID
	cmp r0, #1
	ldr r0, [r6, #0x48]
	movne r0, r0, lsl #1
	rsbne r0, r0, #0x14000
	strne r0, [r7, #0x6c]
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r0, lsl #1
	sub r0, r0, #0xf000
	str r0, [r7, #0x6c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SailJetRaceProgressIconHUD__State_2189770

	arm_func_start SailJetRaceOpponentWarningHUD__SetupObject
SailJetRaceOpponentWarningHUD__SetupObject: // 0x02189A30
	ldr r1, _02189A3C // =SailJetRaceOpponentWarningHUD__State_2189A40
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_02189A3C: .word SailJetRaceOpponentWarningHUD__State_2189A40
	arm_func_end SailJetRaceOpponentWarningHUD__SetupObject

	arm_func_start SailJetRaceOpponentWarningHUD__State_2189A40
SailJetRaceOpponentWarningHUD__State_2189A40: // 0x02189A40
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r1, [r4, #0x11c]
	ldr r0, [r0, #0x98]
	ldr r3, [r1, #0x124]
	ldr r2, [r0, #0x44]
	ldr r0, [r3, #0x25c]
	mov ip, #0x1000
	subs r0, r2, r0
	bpl _02189A7C
	ldr r2, [r4, #0x20]
	orr r2, r2, #0x20
	str r2, [r4, #0x20]
	b _02189AAC
_02189A7C:
	ldr r2, [r4, #0x20]
	cmp r0, #0x90000
	orrgt r2, r2, #0x20
	strgt r2, [r4, #0x20]
	bgt _02189AAC
	bic r2, r2, #0x20
	cmp r0, #0x10000
	str r2, [r4, #0x20]
	subgt r2, r0, #0x10000
	subgt ip, ip, r2, asr #8
	str ip, [r4, #0x38]
	str ip, [r4, #0x3c]
_02189AAC:
	ldr r3, [r3, #0x24]
	mov r2, #0xb8000
	mov r3, r3, lsl #0xc
	str r3, [r4, #0x44]
	str r2, [r4, #0x48]
	ldr r1, [r1, #0x24]
	tst r1, #1
	ldreq r1, [r4, #0x18]
	orreq r1, r1, #4
	streq r1, [r4, #0x18]
	ldr r1, [r4, #0x20]
	tst r1, #0x20
	ldmneia sp!, {r4, pc}
	cmp r0, #0xc000
	bge _02189B00
	ldr r0, [r4, #0x2c]
	tst r0, #1
	orrne r0, r1, #0x20
	strne r0, [r4, #0x20]
	biceq r0, r1, #0x20
	streq r0, [r4, #0x20]
_02189B00:
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	ldmia sp!, {r4, pc}
	arm_func_end SailJetRaceOpponentWarningHUD__State_2189A40

	arm_func_start SailJetRaceCheckpointTextHUD__SetupObject
SailJetRaceCheckpointTextHUD__SetupObject: // 0x02189B10
	ldr r1, _02189B1C // =SailJetRaceCheckpointTextHUD__State_2189B20
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_02189B1C: .word SailJetRaceCheckpointTextHUD__State_2189B20
	arm_func_end SailJetRaceCheckpointTextHUD__SetupObject

	arm_func_start SailJetRaceCheckpointTextHUD__State_2189B20
SailJetRaceCheckpointTextHUD__State_2189B20: // 0x02189B20
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x2c]
	mov r2, #1
	cmp r0, #0x12c
	ble _02189B54
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x44]
	mov r1, #0x50000
	bl ObjShiftSet
	b _02189B68
_02189B54:
	mov r1, #0
	str r1, [sp]
	ldr r0, [r4, #0x44]
	mov r3, r1
	bl ObjShiftSet
_02189B68:
	str r0, [r4, #0x44]
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	cmp r0, #0x12c
	addle sp, sp, #4
	str r0, [r4, #0x2c]
	ldmleia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x44]
	cmp r0, #0x50000
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #4
	streq r0, [r4, #0x18]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end SailJetRaceCheckpointTextHUD__State_2189B20

	arm_func_start SailJetRaceCheckpointIconHUD__SetupObject
SailJetRaceCheckpointIconHUD__SetupObject: // 0x02189BA0
	ldr r1, _02189BAC // =SailJetRaceCheckpointIconHUD__State_2189BB0
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_02189BAC: .word SailJetRaceCheckpointIconHUD__State_2189BB0
	arm_func_end SailJetRaceCheckpointIconHUD__SetupObject

	arm_func_start SailJetRaceCheckpointIconHUD__State_2189BB0
SailJetRaceCheckpointIconHUD__State_2189BB0: // 0x02189BB0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r9, r0
	bl SailManager__GetWork
	mov r7, #0x22
	ldr r2, [r9, #0x2c]
	add r1, r7, #0x10c
	mov r4, r0
	cmp r2, r1
	ldr r5, [r9, #0x124]
	mov r6, #5
	ble _02189C00
	mov r3, #0
	str r3, [sp]
	ldr r0, [r9, #0x44]
	mov r1, #0x50000
	mov r2, #1
	bl ObjShiftSet
	str r0, [r9, #0x44]
	b _02189C24
_02189C00:
	cmp r2, #2
	ble _02189C24
	mov r1, #0
	str r1, [sp]
	ldr r0, [r9, #0x44]
	mov r3, r1
	mov r2, #1
	bl ObjShiftSet
	str r0, [r9, #0x44]
_02189C24:
	ldr r1, [r9, #0x2c]
	mov r0, r9
	add r1, r1, #1
	str r1, [r9, #0x2c]
	bl StageTask__GetAnimID
	cmp r0, #3
	bne _02189C5C
	add r0, r6, #1
	mov r1, r0, lsl #0x10
	mov r7, #0x2b
	add r0, r7, #0x3e0
	mov r6, r1, lsr #0x10
	bl ObjDrawGetPaletteForID
	b _02189C64
_02189C5C:
	ldr r0, WaterGrindRail__byte_2189D28 // =0x0000040A
	bl ObjDrawGetPaletteForID
_02189C64:
	mov r8, r0
	cmp r8, #0
	beq _02189CC8
	ldr r0, [r4, #0x1c]
	tst r0, #4
	beq _02189CB4
	mov r2, #5
	mov r1, r5
	mov r3, r2
	str r2, [sp]
	mov r4, #0x10
	add r0, r5, #0x20
	str r4, [sp, #4]
	bl ObjDraw__TintColorArray
	mov r3, r8
	add r0, r5, #0x20
	mov r1, r4
	mov r2, #0
	bl QueueUncompressedPalette
	b _02189CC8
_02189CB4:
	mov r0, r5
	mov r3, r8
	mov r1, #0x10
	mov r2, #0
	bl QueueUncompressedPalette
_02189CC8:
	str r6, [sp]
	ldr r1, [r9, #0x44]
	ldr r0, [r9, #0x48]
	mov r1, r1, asr #0xc
	add r1, r1, #0xf6
	add r0, r7, r0, asr #12
	mov r2, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	ldr r0, [r9, #0x28]
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, #5
	bl SailHUD__Func_2174A94
	ldr r0, [r9, #0x2c]
	cmp r0, #0x12c
	addle sp, sp, #8
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r9, #0x44]
	cmp r0, #0x50000
	ldreq r0, [r9, #0x18]
	orreq r0, r0, #4
	streq r0, [r9, #0x18]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
WaterGrindRail__byte_2189D28: .word 0x0000040A
	arm_func_end SailJetRaceCheckpointIconHUD__State_2189BB0

	.data

aSbFixVsjUpBac: // 0x0218D790
	.asciz "sb_fix_vsj_up.bac"
    .align 4

aSbFixVsjUnderB: // 0x0218D7A4
	.asciz "sb_fix_vsj_under.bac"
    .align 4

aBbSbBb_0: // 0x0218D7BC
	.asciz "bb/sb.bb"
    .align 4

aSbFixEmeraldBa: // 0x0218D7C8
	.asciz "sb_fix_emerald.bac"
    .align 4