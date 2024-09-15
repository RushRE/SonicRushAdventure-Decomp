	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start InitNetworkErrorMenu
InitNetworkErrorMenu: // 0x02173B88
	ldr ip, _02173B94 // =NetworkErrorMenu__Create
	mov r0, #0
	bx ip
	.align 2, 0
_02173B94: .word NetworkErrorMenu__Create
	arm_func_end InitNetworkErrorMenu

	arm_func_start NetworkErrorMenu__Create
NetworkErrorMenu__Create: // 0x02173B98
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x88
	ldr r1, _02174344 // =gameState
	mov r9, r0
	ldr r0, [r1, #0x164]
	cmp r0, #0
	beq _02173BC8
	cmp r0, #1
	bne _02173BD8
	bl GetMatchManagerStatus
	cmp r0, #2
	beq _02173BD8
_02173BC8:
	mov r0, #0
	bl RenderCore_SetNextFoldMode
	mov r0, #0
	bl RenderCore_DisableSoftReset
_02173BD8:
	ldr r0, _02174344 // =gameState
	ldr r0, [r0, #0x164]
	cmp r0, #1
	bne _02173C08
	bl SaveGame__Func_2060458
	cmp r0, #0
	bne _02173C08
	mov r0, #0x20
	bl RequestNewSysEventChange
	bl NextSysEvent
	add sp, sp, #0x88
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02173C08:
	bl SetupDisplayForCorruptSaveWarning
	mov r0, #0x1000
	str r0, [sp]
	mov r0, #1
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _02174348 // =0x000006E4
	ldr r0, _0217434C // =NetworkErrorMenu__Main
	ldr r1, _02174350 // =NetworkErrorMenu__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02174348 // =0x000006E4
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	ldr r0, _02174354 // =aNarcDmwfErrorL
	mvn r1, #0
	bl FSRequestFileSync
	mov r5, r0
	ldr r0, [r5]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	str r0, [r4, #4]
	ldr r1, [r4, #4]
	mov r0, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	ldr r0, [r4, #4]
	mov r1, #0
	bl FileUnknown__GetAOUFile
	mov r5, r0
	ldr r0, [r4, #4]
	mov r1, #1
	bl FileUnknown__GetAOUFile
	mov r6, r0
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02173CDC
_02173CB8: // jump table
	b _02173CD0 // case 0
	b _02173CD0 // case 1
	b _02173CD0 // case 2
	b _02173CD0 // case 3
	b _02173CD0 // case 4
	b _02173CD0 // case 5
_02173CD0:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	b _02173CE0
_02173CDC:
	mov r0, #1
_02173CE0:
	add r0, r0, #4
	mov r1, r0, lsl #0x10
	ldr r0, [r4, #4]
	mov r1, r1, lsr #0x10
	bl FileUnknown__GetAOUFile
	ldr r2, _02174358 // =VRAMSystem__VRAM_BG
	ldr r1, _0217435C // =VRAMSystem__VRAM_PALETTE_BG
	ldr r7, [r2]
	ldr r8, [r1]
	mov r3, #0
	str r3, [sp]
	stmib sp, {r3, r8}
	str r3, [sp, #0xc]
	str r7, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r10, r0
	str r3, [sp, #0x18]
	mov r0, #0x1e
	str r0, [sp, #0x1c]
	str r3, [sp, #0x20]
	str r3, [sp, #0x24]
	mov r1, #0x20
	str r1, [sp, #0x28]
	mov r1, #0x18
	str r1, [sp, #0x2c]
	add r0, sp, #0x40
	mov r1, r5
	mov r2, #0x38
	bl InitBackgroundEx
	add r0, sp, #0x40
	bl DrawBackground
	cmp r9, #0
	bne _02173E18
	mov r0, #1
	str r0, [sp]
	mov r3, #0
	stmib sp, {r3, r8}
	str r3, [sp, #0xc]
	str r7, [sp, #0x10]
	str r3, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #0x1f
	str r0, [sp, #0x1c]
	str r3, [sp, #0x20]
	mov r1, r6
	str r3, [sp, #0x24]
	mov r2, #0x20
	str r2, [sp, #0x28]
	mov r6, #0x11
	add r0, sp, #0x40
	mov r2, #0x38
	str r6, [sp, #0x2c]
	bl InitBackgroundEx
	add r0, sp, #0x40
	bl DrawBackground
	mov r0, #1
	str r0, [sp]
	mov r3, #0
	stmib sp, {r3, r8}
	str r3, [sp, #0xc]
	str r7, [sp, #0x10]
	str r3, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #0x1f
	str r0, [sp, #0x1c]
	str r3, [sp, #0x20]
	mov r0, r6
	str r0, [sp, #0x24]
	mov r2, #0x20
	str r2, [sp, #0x28]
	mov r2, #7
	str r2, [sp, #0x2c]
	mov r1, r10
	add r0, sp, #0x40
	mov r2, #0x38
	bl InitBackgroundEx
	add r0, sp, #0x40
	bl DrawBackground
_02173E18:
	mov r2, #0
	str r2, [sp]
	ldr r0, _0217435C // =VRAMSystem__VRAM_PALETTE_BG
	str r2, [sp, #4]
	ldr r1, [r0, #4]
	ldr r0, _02174358 // =VRAMSystem__VRAM_BG
	str r1, [sp, #8]
	str r2, [sp, #0xc]
	ldr r1, [r0, #4]
	mov r0, #0xc
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r0, #0x1d
	str r0, [sp, #0x1c]
	str r2, [sp, #0x20]
	str r2, [sp, #0x24]
	mov r2, #0x20
	mov r1, r5
	str r2, [sp, #0x28]
	mov r5, #0x18
	add r0, sp, #0x40
	mov r2, #0x38
	mov r3, #1
	str r5, [sp, #0x2c]
	bl InitBackgroundEx
	add r0, sp, #0x40
	bl DrawBackground
	ldr r0, _02174360 // =aFntFontAllFnt_5_ovl03
	mov r1, #0
	bl FSRequestFileSync
	str r0, [r4]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02173ED0
_02173EAC: // jump table
	b _02173EC4 // case 0
	b _02173EC4 // case 1
	b _02173EC4 // case 2
	b _02173EC4 // case 3
	b _02173EC4 // case 4
	b _02173EC4 // case 5
_02173EC4:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	b _02173ED4
_02173ED0:
	mov r0, #1
_02173ED4:
	mov r1, r0, lsl #0x10
	ldr r0, _02174364 // =aBbDmwfLangBb_1
	mov r1, r1, lsr #0x10
	mov r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r4, #8]
	add r0, r4, #0xc
	bl FontWindow__Init
	ldr r1, [r4]
	add r0, r4, #0xc
	mov r2, #1
	bl FontWindow__LoadFromMemory
	ldr r0, [r4, #8]
	mov r1, #1
	bl FileUnknown__GetAOUFile
	ldr r1, _02174344 // =gameState
	mov r6, r0
	ldr r0, [r1, #0x164]
	cmp r0, #0
	mov r0, #2
	bne _02173F48
	str r0, [sp, #0x3c]
	mov r0, #9
	str r0, [sp, #0x38]
	mov r0, #0x1c
	str r0, [sp, #0x34]
	mov r0, #6
	str r0, [sp, #0x30]
	b _02173F64
_02173F48:
	str r0, [sp, #0x3c]
	mov r0, #3
	str r0, [sp, #0x38]
	mov r0, #0x1c
	str r0, [sp, #0x34]
	mov r0, #0x12
	str r0, [sp, #0x30]
_02173F64:
	add r0, r4, #0xbc
	bl FontAnimator__Init
	ldr r0, [sp, #0x38]
	mov r2, #0
	str r0, [sp]
	ldr r0, [sp, #0x34]
	add r1, r4, #0xc
	str r0, [sp, #4]
	ldr r0, [sp, #0x30]
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	str r2, [sp, #0x10]
	str r0, [sp, #0x14]
	ldr r3, [sp, #0x3c]
	add r0, r4, #0xbc
	str r2, [sp, #0x18]
	mov r2, #8
	bl FontAnimator__LoadFont2
	mov r1, r6
	add r0, r4, #0xbc
	bl FontAnimator__LoadMPCFile
	add r0, r4, #0xbc
	mov r1, #1
	bl FontAnimator__SetCallbackType
	add r0, r4, #0xbc
	bl FontAnimator__LoadPaletteFunc2
	bl NetworkErrorMenu__GetErrorMessage
	mov r1, r0
	add r0, r4, #0xbc
	bl FontAnimator__SetMsgSequence
	add r0, r4, #0xbc
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	add r0, r4, #0xbc
	mov r1, #0
	bl FontAnimator__LoadCharacters
	ldr r0, _02174344 // =gameState
	ldr r0, [r0, #0x164]
	cmp r0, #1
	bne _021741A0
	add r0, r4, #0x180
	bl FontAnimator__Init
	mov r0, #0x14
	str r0, [sp]
	mov r0, #0xf
	str r0, [sp, #4]
	mov r3, #2
	str r3, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	mov r2, #0
	str r2, [sp, #0x10]
	str r0, [sp, #0x14]
	add r0, r4, #0x180
	add r1, r4, #0xc
	str r2, [sp, #0x18]
	mov r2, #8
	bl FontAnimator__LoadFont2
	mov r1, r6
	add r0, r4, #0x180
	bl FontAnimator__LoadMPCFile
	add r0, r4, #0x180
	mov r1, #1
	bl FontAnimator__SetCallbackType
	add r0, r4, #0x180
	mov r1, #0x37
	bl FontAnimator__SetMsgSequence
	add r0, r4, #0x180
	mov r1, #2
	mov r2, #0
	bl FontAnimator__InitStartPos
	add r0, r4, #0x180
	mov r1, #0
	bl FontAnimator__LoadCharacters
	ldr r0, _02174344 // =gameState
	ldr r1, _02174368 // =0x000186A0
	ldr r0, [r0, #0x160]
	rsb r7, r0, #0
	cmp r7, r1
	ble _021740B8
	mov r0, r7
	bl FX_ModS32
	mov r7, r0
_021740B8:
	ldr r8, _0217436C // =0x00002710
	add r10, r4, #0x244
	mov r5, #0
	mov r11, #0x14
_021740C8:
	mov r0, r10
	bl FontAnimator__Init
	str r11, [sp]
	mov r0, #2
	str r0, [sp, #4]
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #1
	add r3, r5, #0x13
	str r0, [sp, #0x14]
	mov r0, #0
	mov r3, r3, lsl #0x10
	str r0, [sp, #0x18]
	mov r0, r10
	add r1, r4, #0xc
	mov r2, #8
	mov r3, r3, lsr #0x10
	bl FontAnimator__LoadFont2
	mov r0, r10
	mov r1, r6
	bl FontAnimator__LoadMPCFile
	mov r0, r10
	mov r1, #1
	bl FontAnimator__SetCallbackType
	mov r0, r7
	mov r1, r8
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	mul r0, r9, r8
	sub r7, r7, r0
	mov r0, r8
	mov r1, #0xa
	bl FX_DivS32
	add r1, r9, #0x38
	mov r1, r1, lsl #0x10
	mov r8, r0
	mov r1, r1, lsr #0x10
	mov r0, r10
	bl FontAnimator__SetMsgSequence
	mov r0, r10
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	mov r0, r10
	mov r1, #0
	bl FontAnimator__LoadCharacters
	add r5, r5, #1
	add r10, r10, #0xc4
	cmp r5, #5
	blt _021740C8
_021741A0:
	add r0, r4, #0x218
	add r0, r0, #0x400
	bl FontWindowAnimator__Init
	ldr r0, [sp, #0x3c]
	mov r7, #2
	sub r0, r0, #1
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x38]
	mov r1, r1, lsr #0x10
	sub r0, r0, #2
	mov r3, r0, lsl #0x10
	ldr r0, [sp, #0x34]
	add r6, r4, #0x218
	add r0, r0, #2
	mov r5, r0, lsl #0x10
	ldr r0, [sp, #0x30]
	mov r2, #0
	str r7, [sp]
	add r0, r0, #4
	str r1, [sp, #4]
	mov r1, r3, lsr #0x10
	mov r0, r0, lsl #0x10
	str r1, [sp, #8]
	mov r1, r5, lsr #0x10
	str r1, [sp, #0xc]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, #3
	str r0, [sp, #0x1c]
	mov r0, #0x2bc
	str r0, [sp, #0x20]
	mov r3, r2
	str r2, [sp, #0x24]
	add r0, r6, #0x400
	add r1, r4, #0xc
	bl FontWindowAnimator__Load1
	ldr r0, [r4, #4]
	mov r1, r7
	bl FileUnknown__GetAOUFile
	mov r5, r0
	mov r0, #1
	mov r1, #4
	bl VRAMSystem__AllocSpriteVram
	mov r1, r5
	mov r5, #1
	str r5, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	add r0, r4, #0x27c
	ldr r3, _02174370 // =0x05000600
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	add r0, r0, #0x400
	mov r3, #4
	str r5, [sp, #0x18]
	bl AnimatorSprite__Init
	mov r1, r5
	add r0, r4, #0x600
	strh r1, [r0, #0xcc]
	ldr r1, _02174344 // =gameState
	ldr r1, [r1, #0x164]
	cmp r1, #0
	mov r1, #0xd8
	streqh r1, [r0, #0x84]
	moveq r1, #0x68
	strneh r1, [r0, #0x84]
	movne r1, #0x98
	strh r1, [r0, #0x86]
	add r0, r4, #0x27c
	mov r1, #0
	mov r2, r1
	add r0, r0, #0x400
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x3c
	str r0, [r4, #0x6e0]
	bl LoadConnectionStatusIconAssets
	mov r1, #1
	mov r0, #2
	str r1, [sp]
	mov r3, #0xea
	str r3, [sp, #4]
	mov r4, #0x16
	mov r2, r0
	mov r3, #0
	str r4, [sp, #8]
	bl CreateConnectionStatusIcon
	mov r1, #0x4000000
	ldr r0, [r1]
	add r2, r1, #0x1000
	bic r0, r0, #0x1f00
	orr r0, r0, #0x300
	str r0, [r1]
	ldr r1, [r2]
	mov r0, #4
	bic r1, r1, #0x1f00
	orr r1, r1, #0x1300
	str r1, [r2]
	bl StartSamplingTouchInput
	add sp, sp, #0x88
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02174344: .word gameState
_02174348: .word 0x000006E4
_0217434C: .word NetworkErrorMenu__Main
_02174350: .word NetworkErrorMenu__Destructor
_02174354: .word aNarcDmwfErrorL
_02174358: .word VRAMSystem__VRAM_BG
_0217435C: .word VRAMSystem__VRAM_PALETTE_BG
_02174360: .word aFntFontAllFnt_5_ovl03
_02174364: .word aBbDmwfLangBb_1
_02174368: .word 0x000186A0
_0217436C: .word 0x00002710
_02174370: .word 0x05000600
	arm_func_end NetworkErrorMenu__Create

	arm_func_start NetworkErrorMenu__Destructor
NetworkErrorMenu__Destructor: // 0x02174374
	stmdb sp!, {r4, r5, r6, lr}
	bl GetTaskWork_
	mov r1, #0x5000000
	mov r2, #0
	mov r3, #0x4000000
	strh r2, [r1]
	add r1, r1, #0x400
	strh r2, [r1]
	ldr r1, [r3]
	add r2, r3, #0x1000
	bic r1, r1, #0x1f00
	str r1, [r3]
	ldr r1, [r2]
	mov r4, r0
	bic r0, r1, #0x1f00
	str r0, [r2]
	bl StopSamplingTouchInput
	add r0, r4, #0xbc
	bl FontAnimator__Release
	ldr r0, _02174450 // =gameState
	ldr r0, [r0, #0x164]
	cmp r0, #1
	bne _021743F8
	add r0, r4, #0x180
	bl FontAnimator__Release
	add r6, r4, #0x244
	mov r5, #0
_021743E0:
	mov r0, r6
	bl FontAnimator__Release
	add r5, r5, #1
	cmp r5, #5
	add r6, r6, #0xc4
	blt _021743E0
_021743F8:
	add r0, r4, #0x218
	add r0, r0, #0x400
	bl FontWindowAnimator__Release
	add r0, r4, #0xc
	bl FontWindow__Release
	ldr r0, [r4]
	cmp r0, #0
	beq _0217441C
	bl _FreeHEAP_USER
_0217441C:
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _0217442C
	bl _FreeHEAP_USER
_0217442C:
	bl ReleaseConnectionStatusIconAssets
	add r0, r4, #0x27c
	add r0, r0, #0x400
	bl AnimatorSprite__Release
	ldr r0, [r4, #4]
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl _FreeHEAP_USER
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02174450: .word gameState
	arm_func_end NetworkErrorMenu__Destructor

	arm_func_start NetworkErrorMenu__Main
NetworkErrorMenu__Main: // 0x02174454
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x600
	ldrh r0, [r0, #0x88]
	cmp r0, #2
	bne _021744E8
	ldr r0, _02174594 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	bne _0217449C
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _021744E8
	ldr r0, _02174598 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	beq _021744E8
_0217449C:
	bl DestroyCurrentTask
	mov r4, #0
	bl GetSysEventList
	ldrsh r0, [r0, #0xe]
	sub r0, r0, #0x13
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _021744D8
_021744BC: // jump table
	b _021744D4 // case 0
	b _021744D4 // case 1
	b _021744D4 // case 2
	b _021744D4 // case 3
	b _021744D8 // case 4
	b _021744D4 // case 5
_021744D4:
	mov r4, #1
_021744D8:
	mov r0, r4
	bl RequestSysEventChange
	bl NextSysEvent
	ldmia sp!, {r4, r5, r6, pc}
_021744E8:
	add r0, r4, #0x218
	add r0, r0, #0x400
	bl FontWindowAnimator__Draw
	add r0, r4, #0xbc
	bl FontAnimator__Draw
	ldr r0, _0217459C // =gameState
	ldr r1, [r0, #0x164]
	cmp r1, #1
	bne _02174540
	ldr r0, [r0, #0x160]
	cmp r0, #0
	beq _02174540
	add r0, r4, #0x180
	bl FontAnimator__Draw
	add r6, r4, #0x244
	mov r5, #0
_02174528:
	mov r0, r6
	bl FontAnimator__Draw
	add r5, r5, #1
	cmp r5, #5
	add r6, r6, #0xc4
	blt _02174528
_02174540:
	add r0, r4, #0xc
	bl FontWindow__PrepareSwapBuffer
	ldr r0, [r4, #0x6e0]
	cmp r0, #0
	beq _02174570
	subs r0, r0, #1
	str r0, [r4, #0x6e0]
	bne _02174570
	add r0, r4, #0x27c
	add r0, r0, #0x400
	mov r1, #2
	bl AnimatorSprite__SetAnimation
_02174570:
	add r0, r4, #0x27c
	mov r1, #0
	mov r2, r1
	add r0, r0, #0x400
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x27c
	add r0, r0, #0x400
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02174594: .word padInput
_02174598: .word touchInput
_0217459C: .word gameState
	arm_func_end NetworkErrorMenu__Main

	arm_func_start NetworkErrorMenu__GetErrorMessage
NetworkErrorMenu__GetErrorMessage: // 0x021745A0
	stmdb sp!, {r4, lr}
	ldr r0, _02174800 // =gameState
	ldr r1, [r0, #0x164]
	cmp r1, #0
	moveq r0, #0x42
	ldmeqia sp!, {r4, pc}
	ldr r1, [r0, #0x160]
	ldr r0, _02174804 // =0x00004E85
	rsb r4, r1, #0
	cmp r4, r0
	beq _021745E4
	ldr r0, _02174808 // =0x000059D8
	cmp r4, r0
	blt _021745EC
	ldr r0, _0217480C // =0x00005DBF
	cmp r4, r0
	bgt _021745EC
_021745E4:
	mov r0, #0x2b
	ldmia sp!, {r4, pc}
_021745EC:
	ldr r0, _02174810 // =0x00004E8C
	cmp r4, r0
	moveq r0, #0x2c
	ldmeqia sp!, {r4, pc}
	add r0, r0, #2
	cmp r4, r0
	moveq r0, #0x2d
	ldmeqia sp!, {r4, pc}
	cmp r4, #0xc800
	blt _02174624
	ldr r0, _02174814 // =0x0000C863
	cmp r4, r0
	movle r0, #0x2e
	ldmleia sp!, {r4, pc}
_02174624:
	ldr r0, _02174818 // =0x0000C350
	cmp r4, r0
	blt _02174640
	add r0, r0, #0x63
	cmp r4, r0
	movle r0, #0x2f
	ldmleia sp!, {r4, pc}
_02174640:
	ldr r1, _0217481C // =0x0000C79F
	cmp r4, r1
	moveq r0, #0x31
	ldmeqia sp!, {r4, pc}
	sub r0, r1, #0x67
	cmp r4, r0
	blt _02174668
	sub r0, r1, #4
	cmp r4, r0
	ble _02174698
_02174668:
	ldr r0, _02174820 // =0x0000C79C
	cmp r4, r0
	blt _02174680
	add r0, r0, #0x63
	cmp r4, r0
	ble _02174698
_02174680:
	ldr r0, _02174824 // =0x0000C864
	cmp r4, r0
	blt _021746A0
	add r0, r0, #0x63
	cmp r4, r0
	bgt _021746A0
_02174698:
	mov r0, #0x30
	ldmia sp!, {r4, pc}
_021746A0:
	ldr r0, _02174828 // =0x0000CB20
	cmp r4, r0
	blt _021746B8
	add r0, r0, #3
	cmp r4, r0
	ble _021746E8
_021746B8:
	ldr r0, _0217482C // =0x0000CB84
	cmp r4, r0
	blt _021746D0
	add r0, r0, #3
	cmp r4, r0
	ble _021746E8
_021746D0:
	ldr r0, _02174830 // =0x0000CBE8
	cmp r4, r0
	blt _021746F0
	add r0, r0, #3
	cmp r4, r0
	bgt _021746F0
_021746E8:
	mov r0, #0x32
	ldmia sp!, {r4, pc}
_021746F0:
	ldr r0, _02174834 // =0x00004E20
	cmp r4, r0
	blt _02174708
	ldr r0, _02174838 // =0x00005207
	cmp r4, r0
	ble _021747B0
_02174708:
	ldr r0, _02174828 // =0x0000CB20
	cmp r4, r0
	blt _02174720
	add r0, r0, #0x63
	cmp r4, r0
	ble _021747B0
_02174720:
	ldr r0, _0217482C // =0x0000CB84
	cmp r4, r0
	blt _02174738
	add r0, r0, #0x63
	cmp r4, r0
	ble _021747B0
_02174738:
	ldr r0, _02174830 // =0x0000CBE8
	cmp r4, r0
	blt _02174750
	add r0, r0, #0x63
	cmp r4, r0
	ble _021747B0
_02174750:
	ldr r0, _0217483C // =0x0000CC4C
	cmp r4, r0
	blt _02174768
	add r0, r0, #0x63
	cmp r4, r0
	ble _021747B0
_02174768:
	ldr r0, _02174840 // =0x0000CF08
	cmp r4, r0
	blt _02174780
	add r0, r0, #0x63
	cmp r4, r0
	ble _021747B0
_02174780:
	ldr r0, _02174844 // =0x0000CF6C
	cmp r4, r0
	blt _02174798
	add r0, r0, #0x63
	cmp r4, r0
	ble _021747B0
_02174798:
	ldr r0, _02174848 // =0x0000CFD0
	cmp r4, r0
	blt _021747B8
	add r0, r0, #0x63
	cmp r4, r0
	bgt _021747B8
_021747B0:
	mov r0, #0x2a
	ldmia sp!, {r4, pc}
_021747B8:
	ldr r0, _0217484C // =0x00013A2E
	cmp r4, r0
	moveq r0, #0x33
	ldmeqia sp!, {r4, pc}
	bl GetMatchManagerStatus
	cmp r0, #2
	bne _021747F8
	ldr r0, _02174850 // =0x00007918
	cmp r4, r0
	blt _021747F0
	ldr r0, _02174854 // =0x00007CFF
	cmp r4, r0
	movle r0, #0x36
	ldmleia sp!, {r4, pc}
_021747F0:
	mov r0, #0x35
	ldmia sp!, {r4, pc}
_021747F8:
	mov r0, #0x34
	ldmia sp!, {r4, pc}
	.align 2, 0
_02174800: .word gameState
_02174804: .word 0x00004E85
_02174808: .word 0x000059D8
_0217480C: .word 0x00005DBF
_02174810: .word 0x00004E8C
_02174814: .word 0x0000C863
_02174818: .word 0x0000C350
_0217481C: .word 0x0000C79F
_02174820: .word 0x0000C79C
_02174824: .word 0x0000C864
_02174828: .word 0x0000CB20
_0217482C: .word 0x0000CB84
_02174830: .word 0x0000CBE8
_02174834: .word 0x00004E20
_02174838: .word 0x00005207
_0217483C: .word 0x0000CC4C
_02174840: .word 0x0000CF08
_02174844: .word 0x0000CF6C
_02174848: .word 0x0000CFD0
_0217484C: .word 0x00013A2E
_02174850: .word 0x00007918
_02174854: .word 0x00007CFF
	arm_func_end NetworkErrorMenu__GetErrorMessage

	.data
	
aNarcDmwfErrorL: // 0x0217EECC
	.asciz "/narc/dmwf_error_lz7.narc"
	.align 4
	
aFntFontAllFnt_5_ovl03: // 0x0217EEE8
	.asciz "fnt/font_all.fnt"
	.align 4
	
aBbDmwfLangBb_1: // 0x0217EEFC
	.asciz "/bb/dmwf_lang.bb"
	.align 4
