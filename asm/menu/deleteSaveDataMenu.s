	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DeleteSaveDataMenu__Create
DeleteSaveDataMenu__Create: // 0x021529B0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r2, #0
	str r2, [sp]
	ldr r0, _02152A38 // =DeleteSaveDataMenu__Main
	ldr r1, _02152A3C // =DeleteSaveDataMenu__Destructor
	mov r3, r2
	str r2, [sp, #4]
	mov r4, #0x3e4
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x3e4
	bl MIi_CpuClear32
	mov r0, r4
	bl DeleteSaveDataMenu__LoadAssets
	mov r2, #1
	add r0, r4, #0x300
	strh r2, [r0, #0xc8]
	rsb r1, r2, #0x10000
	strh r1, [r0, #0xca]
	mov r1, #0
	str r1, [r4, #0x3d0]
	str r1, [r4, #0x3d4]
	ldr r0, _02152A40 // =DeleteSaveDataMenu__Func_215316C
	str r2, [r4, #0x3d8]
	str r0, [r4, #0x3dc]
	str r1, [r4, #0x3e0]
	bl LoadSysSoundVillage
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02152A38: .word DeleteSaveDataMenu__Main
_02152A3C: .word DeleteSaveDataMenu__Destructor
_02152A40: .word DeleteSaveDataMenu__Func_215316C
	arm_func_end DeleteSaveDataMenu__Create

	arm_func_start DeleteSaveDataMenu__LoadAssets
DeleteSaveDataMenu__LoadAssets: // 0x02152A44
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DeleteSaveDataMenu__Func_2152B20
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02152A88
_02152A64: // jump table
	b _02152A7C // case 0
	b _02152A7C // case 1
	b _02152A7C // case 2
	b _02152A7C // case 3
	b _02152A7C // case 4
	b _02152A7C // case 5
_02152A7C:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	b _02152A8C
_02152A88:
	mov r0, #1
_02152A8C:
	mov r1, r0, lsl #0x10
	ldr r0, _02152B14 // =aBbDmSaveDelBb
	mov r1, r1, lsr #0x10
	mov r2, #0
	bl ReadFileFromBundle
	str r0, [r4, #0x3b8]
	ldr r0, _02152B18 // =aFntFontAllFnt_5_ovl04
	mov r1, #0
	bl FSRequestFileSync
	str r0, [r4, #0x3bc]
	mov r0, r4
	bl FontWindow__Init
	ldr r1, [r4, #0x3bc]
	mov r0, r4
	mov r2, #1
	bl FontWindow__LoadFromMemory
	mov r0, r4
	bl FontWindow__Load_mw_frame
	mov r0, r4
	mov r1, #0
	bl FontWindow__SetDMA
	ldr r0, _02152B1C // =aNarcDmSdActLz7
	mov r1, #0
	bl BundleFileUnknown__LoadFile
	str r0, [r4, #0x3c0]
	mov r0, r4
	bl DeleteSaveDataMenu__Func_2152D2C
	mov r0, r4
	bl DeleteSaveDataMenu__Func_2152D98
	mov r0, r4
	bl DeleteSaveDataMenu__Func_2152EB4
	mov r0, r4
	bl DeleteSaveDataMenu__Func_2152F6C
	ldmia sp!, {r4, pc}
	.align 2, 0
_02152B14: .word aBbDmSaveDelBb
_02152B18: .word aFntFontAllFnt_5_ovl04
_02152B1C: .word aNarcDmSdActLz7
	arm_func_end DeleteSaveDataMenu__LoadAssets

	arm_func_start DeleteSaveDataMenu__Func_2152B20
DeleteSaveDataMenu__Func_2152B20: // 0x02152B20
	stmdb sp!, {r3, lr}
	ldr r1, _02152D04 // =renderCoreGFXControlA
	ldrsh r0, [r1, #0x58]
	cmp r0, #0
	ldrgt r0, _02152D08 // =renderCoreGFXControlB
	movgt r2, #0x10
	mvnle r2, #0xf
	strh r2, [r1, #0x58]
	ldrle r0, _02152D08 // =renderCoreGFXControlB
	ldr r1, _02152D04 // =renderCoreGFXControlA
	strh r2, [r0, #0x58]
	ldrsh r1, [r1, #0x58]
	ldr r0, _02152D0C // =0x0400006C
	bl GXx_SetMasterBrightness_
	ldr r1, _02152D08 // =renderCoreGFXControlB
	ldr r0, _02152D10 // =0x0400106C
	ldrsh r1, [r1, #0x58]
	bl GXx_SetMasterBrightness_
	ldr r3, _02152D14 // =0x04000304
	ldr r1, _02152D18 // =0xFFFFFDF1
	ldrh r2, [r3]
	mov r0, #0
	and r1, r2, r1
	orr r1, r1, #0xe
	orr r1, r1, #0x200
	strh r1, [r3]
	ldrh r1, [r3]
	bic r1, r1, #0xc
	strh r1, [r3]
	bl VRAMSystem__Init
	mov r1, #0
	mov r2, r1
	mov r0, #1
	bl GX_SetGraphicsMode
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r3, _02152D1C // =0x04000008
	ldr ip, _02152D20 // =0x0400100E
	ldrh r2, [r3]
	ldr r1, _02152D04 // =renderCoreGFXControlA
	mov r0, #0
	and r2, r2, #0x43
	orr r2, r2, #0x18
	strh r2, [r3]
	ldrh lr, [r3, #2]
	mov r2, #0x10
	and lr, lr, #0x43
	orr lr, lr, #0x110
	strh lr, [r3, #2]
	ldrh lr, [r3, #4]
	and lr, lr, #0x43
	orr lr, lr, #0x208
	strh lr, [r3, #4]
	ldrh lr, [r3, #6]
	and lr, lr, #0x43
	orr lr, lr, #0x304
	strh lr, [r3, #6]
	ldrh r3, [ip]
	and r3, r3, #0x43
	orr r3, r3, #0x304
	strh r3, [ip]
	bl MIi_CpuClear32
	ldr r1, _02152D08 // =renderCoreGFXControlB
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear32
	ldr r0, _02152D1C // =0x04000008
	ldrh r1, [r0]
	bic r1, r1, #3
	strh r1, [r0]
	ldrh r1, [r0, #2]
	bic r1, r1, #3
	orr r1, r1, #1
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	bic r1, r1, #3
	orr r1, r1, #2
	strh r1, [r0, #4]
	ldrh r1, [r0, #6]
	ldr lr, _02152D24 // =0x0400100A
	mov r3, #0x4000000
	bic r1, r1, #3
	orr r1, r1, #3
	strh r1, [r0, #6]
	ldr r1, [r3]
	add r2, r0, #0x1000
	bic r0, r1, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r3]
	ldrh r1, [r2]
	sub ip, lr, #0xa
	mov r0, #0
	bic r1, r1, #3
	strh r1, [r2]
	ldrh r3, [lr]
	mov r1, #0x6000000
	mov r2, #0x80000
	bic r3, r3, #3
	orr r3, r3, #1
	strh r3, [lr]
	ldrh r3, [lr, #2]
	bic r3, r3, #3
	orr r3, r3, #2
	strh r3, [lr, #2]
	ldrh r3, [lr, #4]
	bic r3, r3, #3
	orr r3, r3, #3
	strh r3, [lr, #4]
	ldr r3, [ip]
	bic r3, r3, #0x1f00
	orr r3, r3, #0x800
	str r3, [ip]
	bl MIi_CpuClearFast
	mov r0, #0
	mov r1, #0x6200000
	mov r2, #0x20000
	bl MIi_CpuClearFast
	ldr r0, _02152D28 // =renderCurrentDisplay
	mov r1, #1
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02152D04: .word renderCoreGFXControlA
_02152D08: .word renderCoreGFXControlB
_02152D0C: .word 0x0400006C
_02152D10: .word 0x0400106C
_02152D14: .word 0x04000304
_02152D18: .word 0xFFFFFDF1
_02152D1C: .word 0x04000008
_02152D20: .word 0x0400100E
_02152D24: .word 0x0400100A
_02152D28: .word renderCurrentDisplay
	arm_func_end DeleteSaveDataMenu__Func_2152B20

	arm_func_start DeleteSaveDataMenu__Func_2152D2C
DeleteSaveDataMenu__Func_2152D2C: // 0x02152D2C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x28
	mov r4, r0
	add r0, r4, #0xb0
	bl FontWindowAnimator__Init
	mov r2, #0
	mov r1, #2
	stmia sp, {r1, r2}
	str r2, [sp, #8]
	mov r0, #0x20
	str r0, [sp, #0xc]
	mov r0, #0xc
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	str r1, [sp, #0x18]
	str r1, [sp, #0x1c]
	mov r0, #1
	str r0, [sp, #0x20]
	mov r1, r4
	mov r3, r2
	add r0, r4, #0xb0
	str r2, [sp, #0x24]
	bl FontWindowAnimator__Load1
	add r0, r4, #0x114
	bl FontWindowAnimator__Init
	add sp, sp, #0x28
	ldmia sp!, {r4, pc}
	arm_func_end DeleteSaveDataMenu__Func_2152D2C

	arm_func_start DeleteSaveDataMenu__Func_2152D98
DeleteSaveDataMenu__Func_2152D98: // 0x02152D98
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	add r0, r4, #0x178
	bl FontAnimator__Init
	mov r3, #1
	str r3, [sp]
	mov r0, #0x1e
	str r0, [sp, #4]
	mov r0, #0xa
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r1, r4
	str r3, [sp, #0x18]
	add r0, r4, #0x178
	bl FontAnimator__LoadFont1
	ldr r1, [r4, #0x3b8]
	add r0, r4, #0x178
	bl FontAnimator__LoadMPCFile
	add r0, r4, #0x178
	mov r1, #0
	bl FontAnimator__SetMsgSequence
	add r0, r4, #0x178
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	add r0, r4, #0x178
	bl FontAnimator__ClearPixels
	add r0, r4, #0x178
	bl FontAnimator__LoadMappingsFunc
	add r0, r4, #0x178
	bl FontAnimator__LoadPaletteFunc
	add r0, r4, #0x23c
	bl FontAnimator__Init
	mov r0, #0xe
	str r0, [sp]
	mov r0, #0x16
	str r0, [sp, #4]
	mov r0, #6
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r4, #0x23c
	mov r1, r4
	mov r3, #5
	bl FontAnimator__LoadFont1
	add r0, r4, #0x23c
	ldr r1, [r4, #0x3b8]
	bl FontAnimator__LoadMPCFile
	add r0, r4, #0x23c
	mov r1, #0
	bl FontAnimator__SetMsgSequence
	add r0, r4, #0x23c
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	add r0, r4, #0x23c
	bl FontAnimator__ClearPixels
	add r0, r4, #0x23c
	bl FontAnimator__LoadMappingsFunc
	add r0, r4, #0x23c
	bl FontAnimator__LoadPaletteFunc
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
	arm_func_end DeleteSaveDataMenu__Func_2152D98

	arm_func_start DeleteSaveDataMenu__Func_2152EB4
DeleteSaveDataMenu__Func_2152EB4: // 0x02152EB4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	mov r5, r0
	add r0, r5, #0x300
	bl FontWindowMWControl__Init
	mov r0, #0xb0
	str r0, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	mov r2, #0
	str r2, [sp, #8]
	mov r3, #1
	str r3, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r1, r5
	str r2, [sp, #0x14]
	add r0, r5, #0x300
	bl FontWindowMWControl__Load
	ldr r0, [r5, #0x3c0]
	mov r1, #0
	bl FileUnknown__GetAOUFile
	mov r4, r0
	mov r1, #0
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r4
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r3, _02152F68 // =0x05000200
	add r0, r5, #0x354
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r3, #4
	bl AnimatorSprite__Init
	add r0, r5, #0x300
	mov r1, #1
	strh r1, [r0, #0xa4]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02152F68: .word 0x05000200
	arm_func_end DeleteSaveDataMenu__Func_2152EB4

	arm_func_start DeleteSaveDataMenu__Func_2152F6C
DeleteSaveDataMenu__Func_2152F6C: // 0x02152F6C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x54
	ldr r0, _02153000 // =aNarcDmniLz7Nar_ovl04
	mov r1, #8
	mov r2, #0
	bl ArchiveFileUnknown__LoadFileFromArchive
	mov r4, r0
	mov r0, #3
	str r0, [sp]
	mov r2, #0x20
	str r2, [sp, #4]
	mov ip, #0x18
	add r0, sp, #0xc
	mov r1, r4
	mov r2, #0x38
	mov r3, #0
	str ip, [sp, #8]
	bl InitBackground
	add r0, sp, #0xc
	bl DrawBackground
	mov r0, #3
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0xc
	mov r1, r4
	mov r2, #0x38
	mov r3, #1
	bl InitBackground
	add r0, sp, #0xc
	bl DrawBackground
	mov r0, r4
	bl _FreeHEAP_USER
	add sp, sp, #0x54
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02153000: .word aNarcDmniLz7Nar_ovl04
	arm_func_end DeleteSaveDataMenu__Func_2152F6C

	arm_func_start DeleteSaveDataMenu__Func_2153004
DeleteSaveDataMenu__Func_2153004: // 0x02153004
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DeleteSaveDataMenu__Func_21530D4
	mov r0, r4
	bl DeleteSaveDataMenu__Func_21530B8
	mov r0, r4
	bl DeleteSaveDataMenu__Func_215309C
	mov r0, r4
	bl DeleteSaveDataMenu__Func_2153080
	ldr r0, [r4, #0x3c0]
	bl _FreeHEAP_USER
	mov r0, r4
	bl FontWindow__Release
	ldr r0, [r4, #0x3bc]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x3b8]
	bl _FreeHEAP_USER
	mov r0, r4
	bl DeleteSaveDataMenu__Func_2153058
	bl ReleaseSysSound
	ldmia sp!, {r4, pc}
	arm_func_end DeleteSaveDataMenu__Func_2153004

	arm_func_start DeleteSaveDataMenu__Func_2153058
DeleteSaveDataMenu__Func_2153058: // 0x02153058
	stmdb sp!, {r3, lr}
	mov r0, #0
	mov r1, #0x6000000
	mov r2, #0x80000
	bl MIi_CpuClearFast
	mov r0, #0
	mov r1, #0x6200000
	mov r2, #0x20000
	bl MIi_CpuClearFast
	ldmia sp!, {r3, pc}
	arm_func_end DeleteSaveDataMenu__Func_2153058

	arm_func_start DeleteSaveDataMenu__Func_2153080
DeleteSaveDataMenu__Func_2153080: // 0x02153080
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x114
	bl FontWindowAnimator__Release
	add r0, r4, #0xb0
	bl FontWindowAnimator__Release
	ldmia sp!, {r4, pc}
	arm_func_end DeleteSaveDataMenu__Func_2153080

	arm_func_start DeleteSaveDataMenu__Func_215309C
DeleteSaveDataMenu__Func_215309C: // 0x0215309C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x23c
	bl FontAnimator__Release
	add r0, r4, #0x178
	bl FontAnimator__Release
	ldmia sp!, {r4, pc}
	arm_func_end DeleteSaveDataMenu__Func_215309C

	arm_func_start DeleteSaveDataMenu__Func_21530B8
DeleteSaveDataMenu__Func_21530B8: // 0x021530B8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x354
	bl AnimatorSprite__Release
	add r0, r4, #0x300
	bl FontWindowMWControl__Release
	ldmia sp!, {r4, pc}
	arm_func_end DeleteSaveDataMenu__Func_21530B8

	arm_func_start DeleteSaveDataMenu__Func_21530D4
DeleteSaveDataMenu__Func_21530D4: // 0x021530D4
	bx lr
	arm_func_end DeleteSaveDataMenu__Func_21530D4

	arm_func_start DeleteSaveDataMenu__Main
DeleteSaveDataMenu__Main: // 0x021530D8
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x3dc]
	cmp r1, #0
	beq _02153100
	blx r1
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	ldmia sp!, {r4, pc}
_02153100:
	ldr r0, [r4, #0x3d4]
	cmp r0, #0
	beq _02153130
	ldr r0, [r4, #0x3d8]
	cmp r0, #0
	movne r4, #0
	bne _02153140
	ldr r0, _02153158 // =gameState
	mov r1, #1
	str r1, [r0, #0x168]
	mov r4, #2
	b _02153140
_02153130:
	ldr r0, _02153158 // =gameState
	mov r1, #2
	strb r1, [r0, #0xdc]
	mov r4, #1
_02153140:
	bl DestroyCurrentTask
	mov r0, r4, lsl #0x10
	mov r0, r0, asr #0x10
	bl RequestSysEventChange
	bl NextSysEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02153158: .word gameState
	arm_func_end DeleteSaveDataMenu__Main

	arm_func_start DeleteSaveDataMenu__Destructor
DeleteSaveDataMenu__Destructor: // 0x0215315C
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl DeleteSaveDataMenu__Func_2153004
	ldmia sp!, {r3, pc}
	arm_func_end DeleteSaveDataMenu__Destructor

	arm_func_start DeleteSaveDataMenu__Func_215316C
DeleteSaveDataMenu__Func_215316C: // 0x0215316C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r1, _021531FC // =renderCoreGFXControlA
	mov r4, r0
	ldrsh r0, [r1, #0x58]
	cmp r0, #0
	addlt r0, r0, #1
	strlth r0, [r1, #0x58]
	ldr r0, _021531FC // =renderCoreGFXControlA
	ldrsh r1, [r0, #0x58]
	cmp r1, #0
	subgt r1, r1, #1
	strgth r1, [r0, #0x58]
	ldr r1, _021531FC // =renderCoreGFXControlA
	ldr r0, _02153200 // =renderCoreGFXControlB
	ldrsh r1, [r1, #0x58]
	cmp r1, #0
	strh r1, [r0, #0x58]
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, pc}
	mov r3, #0
	add r0, r4, #0xb0
	mov r1, #1
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xb0
	bl FontWindowAnimator__StartAnimating
	add r0, r4, #0xb0
	bl FontWindowAnimator__Func_20599B4
	mov r1, #0
	ldr r0, _02153204 // =DeleteSaveDataMenu__Func_2153208
	str r1, [r4, #0x3c4]
	str r0, [r4, #0x3dc]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021531FC: .word renderCoreGFXControlA
_02153200: .word renderCoreGFXControlB
_02153204: .word DeleteSaveDataMenu__Func_2153208
	arm_func_end DeleteSaveDataMenu__Func_215316C

	arm_func_start DeleteSaveDataMenu__Func_2153208
DeleteSaveDataMenu__Func_2153208: // 0x02153208
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xb0
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0xb0
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0xb0
	bl FontWindowAnimator__SetWindowOpen
	add r0, r4, #0x178
	mov r1, #0
	bl FontAnimator__SetMsgSequence
	add r0, r4, #0x178
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	mov r0, r0, lsl #1
	rsb r0, r0, #0xa
	mov r1, r0, lsl #0x12
	add r0, r4, #0x178
	mov r1, r1, asr #0x10
	bl FontAnimator__AdvanceLine
	mov r1, #0
	ldr r0, _02153274 // =DeleteSaveDataMenu__Func_2153278
	str r1, [r4, #0x3c4]
	str r0, [r4, #0x3dc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02153274: .word DeleteSaveDataMenu__Func_2153278
	arm_func_end DeleteSaveDataMenu__Func_2153208

	arm_func_start DeleteSaveDataMenu__Func_2153278
DeleteSaveDataMenu__Func_2153278: // 0x02153278
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x178
	mov r1, #1
	bl FontAnimator__LoadCharacters
	add r0, r4, #0x178
	bl FontAnimator__Draw
	add r0, r4, #0x178
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x300
	mov r1, #2
	strh r1, [r0, #0xc8]
	mov r2, #1
	ldr r1, _021532D4 // =DeleteSaveDataMenu__Func_21538C4
	strh r2, [r0, #0xca]
	str r1, [r4, #0x3e0]
	mov r1, #0
	ldr r0, _021532D8 // =DeleteSaveDataMenu__Func_21532DC
	str r1, [r4, #0x3c4]
	str r0, [r4, #0x3dc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021532D4: .word DeleteSaveDataMenu__Func_21538C4
_021532D8: .word DeleteSaveDataMenu__Func_21532DC
	arm_func_end DeleteSaveDataMenu__Func_2153278

	arm_func_start DeleteSaveDataMenu__Func_21532DC
DeleteSaveDataMenu__Func_21532DC: // 0x021532DC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x3e0]
	cmp r1, #0
	beq _021532F8
	blx r1
	ldmia sp!, {r4, pc}
_021532F8:
	add r0, r4, #0x300
	ldrh r0, [r0, #0xc8]
	cmp r0, #0
	beq _0215331C
	cmp r0, #1
	beq _0215333C
	cmp r0, #2
	beq _0215335C
	b _02153380
_0215331C:
	add r0, r4, #0x178
	mov r1, #2
	bl FontAnimator__SetMsgSequence
	mov r1, #0
	ldr r0, _021533A8 // =DeleteSaveDataMenu__Func_21533B4
	str r1, [r4, #0x3c4]
	str r0, [r4, #0x3dc]
	b _02153380
_0215333C:
	add r0, r4, #0x178
	mov r1, #4
	bl FontAnimator__SetMsgSequence
	mov r1, #0
	ldr r0, _021533AC // =DeleteSaveDataMenu__Func_21534D4
	str r1, [r4, #0x3c4]
	str r0, [r4, #0x3dc]
	b _02153380
_0215335C:
	mov r2, #0
	add r0, r4, #0x178
	mov r1, #8
	str r2, [r4, #0x3d4]
	bl FontAnimator__SetMsgSequence
	mov r1, #0
	ldr r0, _021533B0 // =DeleteSaveDataMenu__Func_2153794
	str r1, [r4, #0x3c4]
	str r0, [r4, #0x3dc]
_02153380:
	add r0, r4, #0x178
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	mov r0, r0, lsl #1
	rsb r0, r0, #0xa
	mov r1, r0, lsl #0x12
	add r0, r4, #0x178
	mov r1, r1, asr #0x10
	bl FontAnimator__AdvanceLine
	ldmia sp!, {r4, pc}
	.align 2, 0
_021533A8: .word DeleteSaveDataMenu__Func_21533B4
_021533AC: .word DeleteSaveDataMenu__Func_21534D4
_021533B0: .word DeleteSaveDataMenu__Func_2153794
	arm_func_end DeleteSaveDataMenu__Func_21532DC

	arm_func_start DeleteSaveDataMenu__Func_21533B4
DeleteSaveDataMenu__Func_21533B4: // 0x021533B4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x178
	mov r1, #1
	bl FontAnimator__LoadCharacters
	add r0, r4, #0x178
	bl FontAnimator__Draw
	add r0, r4, #0x178
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x300
	mov r1, #1
	strh r1, [r0, #0xc8]
	mov r2, #3
	ldr r1, _02153410 // =DeleteSaveDataMenu__Func_21538C4
	strh r2, [r0, #0xca]
	str r1, [r4, #0x3e0]
	mov r1, #0
	ldr r0, _02153414 // =DeleteSaveDataMenu__Func_2153418
	str r1, [r4, #0x3c4]
	str r0, [r4, #0x3dc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02153410: .word DeleteSaveDataMenu__Func_21538C4
_02153414: .word DeleteSaveDataMenu__Func_2153418
	arm_func_end DeleteSaveDataMenu__Func_21533B4

	arm_func_start DeleteSaveDataMenu__Func_2153418
DeleteSaveDataMenu__Func_2153418: // 0x02153418
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x3e0]
	cmp r1, #0
	beq _02153434
	blx r1
	ldmia sp!, {r4, pc}
_02153434:
	add r0, r4, #0x300
	ldrh r0, [r0, #0xc8]
	cmp r0, #0
	beq _02153450
	cmp r0, #1
	beq _02153480
	b _021534A4
_02153450:
	mov r0, #0
	str r0, [r4, #0x3d0]
	mov r2, #1
	add r0, r4, #0x178
	mov r1, #6
	str r2, [r4, #0x3d4]
	bl FontAnimator__SetMsgSequence
	mov r1, #0
	ldr r0, _021534CC // =DeleteSaveDataMenu__Func_21535F0
	str r1, [r4, #0x3c4]
	str r0, [r4, #0x3dc]
	b _021534A4
_02153480:
	mov r2, #0
	add r0, r4, #0x178
	mov r1, #8
	str r2, [r4, #0x3d4]
	bl FontAnimator__SetMsgSequence
	mov r1, #0
	ldr r0, _021534D0 // =DeleteSaveDataMenu__Func_2153794
	str r1, [r4, #0x3c4]
	str r0, [r4, #0x3dc]
_021534A4:
	add r0, r4, #0x178
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	mov r0, r0, lsl #1
	rsb r0, r0, #0xa
	mov r1, r0, lsl #0x12
	add r0, r4, #0x178
	mov r1, r1, asr #0x10
	bl FontAnimator__AdvanceLine
	ldmia sp!, {r4, pc}
	.align 2, 0
_021534CC: .word DeleteSaveDataMenu__Func_21535F0
_021534D0: .word DeleteSaveDataMenu__Func_2153794
	arm_func_end DeleteSaveDataMenu__Func_2153418

	arm_func_start DeleteSaveDataMenu__Func_21534D4
DeleteSaveDataMenu__Func_21534D4: // 0x021534D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x178
	mov r1, #1
	bl FontAnimator__LoadCharacters
	add r0, r4, #0x178
	bl FontAnimator__Draw
	add r0, r4, #0x178
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x300
	mov r1, #1
	strh r1, [r0, #0xc8]
	mov r2, #5
	ldr r1, _02153530 // =DeleteSaveDataMenu__Func_21538C4
	strh r2, [r0, #0xca]
	str r1, [r4, #0x3e0]
	mov r1, #0
	ldr r0, _02153534 // =DeleteSaveDataMenu__Func_2153538
	str r1, [r4, #0x3c4]
	str r0, [r4, #0x3dc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02153530: .word DeleteSaveDataMenu__Func_21538C4
_02153534: .word DeleteSaveDataMenu__Func_2153538
	arm_func_end DeleteSaveDataMenu__Func_21534D4

	arm_func_start DeleteSaveDataMenu__Func_2153538
DeleteSaveDataMenu__Func_2153538: // 0x02153538
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x3e0]
	cmp r1, #0
	beq _02153554
	blx r1
	ldmia sp!, {r4, pc}
_02153554:
	add r0, r4, #0x300
	ldrh r0, [r0, #0xc8]
	cmp r0, #0
	beq _02153570
	cmp r0, #1
	beq _0215359C
	b _021535C0
_02153570:
	mov r2, #1
	str r2, [r4, #0x3d0]
	add r0, r4, #0x178
	mov r1, #6
	str r2, [r4, #0x3d4]
	bl FontAnimator__SetMsgSequence
	mov r1, #0
	ldr r0, _021535E8 // =DeleteSaveDataMenu__Func_21535F0
	str r1, [r4, #0x3c4]
	str r0, [r4, #0x3dc]
	b _021535C0
_0215359C:
	mov r2, #0
	add r0, r4, #0x178
	mov r1, #8
	str r2, [r4, #0x3d4]
	bl FontAnimator__SetMsgSequence
	mov r1, #0
	ldr r0, _021535EC // =DeleteSaveDataMenu__Func_2153794
	str r1, [r4, #0x3c4]
	str r0, [r4, #0x3dc]
_021535C0:
	add r0, r4, #0x178
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	mov r0, r0, lsl #1
	rsb r0, r0, #0xa
	mov r1, r0, lsl #0x12
	add r0, r4, #0x178
	mov r1, r1, asr #0x10
	bl FontAnimator__AdvanceLine
	ldmia sp!, {r4, pc}
	.align 2, 0
_021535E8: .word DeleteSaveDataMenu__Func_21535F0
_021535EC: .word DeleteSaveDataMenu__Func_2153794
	arm_func_end DeleteSaveDataMenu__Func_2153538

	arm_func_start DeleteSaveDataMenu__Func_21535F0
DeleteSaveDataMenu__Func_21535F0: // 0x021535F0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x178
	mov r1, #1
	bl FontAnimator__LoadCharacters
	add r0, r4, #0x178
	bl FontAnimator__Draw
	add r0, r4, #0x178
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	ldr r0, _02153630 // =DeleteSaveDataMenu__Func_2153634
	str r1, [r4, #0x3c4]
	str r0, [r4, #0x3dc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02153630: .word DeleteSaveDataMenu__Func_2153634
	arm_func_end DeleteSaveDataMenu__Func_21535F0

	arm_func_start DeleteSaveDataMenu__Func_2153634
DeleteSaveDataMenu__Func_2153634: // 0x02153634
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	add r0, r4, #0x178
	mov r1, #1
	bl FontAnimator__LoadCharacters
	add r0, r4, #0x178
	bl FontAnimator__Draw
	ldr r0, [r4, #0x3d0]
	bl DeleteSaveDataMenu__Func_2153C64
	str r0, [r4, #0x3d8]
	cmp r0, #0
	add r0, r4, #0x178
	beq _021536B0
	mov r1, #7
	bl FontAnimator__SetMsgSequence
	add r0, r4, #0x178
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	mov r0, r0, lsl #1
	rsb r0, r0, #0xa
	mov r1, r0, lsl #0x12
	add r0, r4, #0x178
	mov r1, r1, asr #0x10
	bl FontAnimator__AdvanceLine
	mov r1, #0
	ldr r0, _021536F4 // =DeleteSaveDataMenu__Func_21536FC
	str r1, [r4, #0x3c4]
	add sp, sp, #4
	str r0, [r4, #0x3dc]
	ldmia sp!, {r3, r4, pc}
_021536B0:
	bl FontAnimator__ClearPixels
	add r0, r4, #0x178
	bl FontAnimator__Draw
	mov r3, #0
	add r0, r4, #0xb0
	mov r1, #4
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xb0
	bl FontWindowAnimator__StartAnimating
	mov r1, #1
	ldr r0, _021536F8 // =DeleteSaveDataMenu__Func_215382C
	str r1, [r4, #0x3cc]
	str r0, [r4, #0x3dc]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021536F4: .word DeleteSaveDataMenu__Func_21536FC
_021536F8: .word DeleteSaveDataMenu__Func_215382C
	arm_func_end DeleteSaveDataMenu__Func_2153634

	arm_func_start DeleteSaveDataMenu__Func_21536FC
DeleteSaveDataMenu__Func_21536FC: // 0x021536FC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	add r0, r4, #0x178
	mov r1, #1
	bl FontAnimator__LoadCharacters
	add r0, r4, #0x178
	bl FontAnimator__Draw
	add r0, r4, #0x178
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x3c4]
	add r0, r0, #1
	cmp r0, #0x78
	addlo sp, sp, #4
	str r0, [r4, #0x3c4]
	ldmloia sp!, {r3, r4, pc}
	add r0, r4, #0x178
	bl FontAnimator__ClearPixels
	add r0, r4, #0x178
	bl FontAnimator__Draw
	mov r3, #0
	add r0, r4, #0xb0
	mov r1, #4
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xb0
	bl FontWindowAnimator__StartAnimating
	mov r1, #1
	ldr r0, _02153790 // =DeleteSaveDataMenu__Func_215382C
	str r1, [r4, #0x3cc]
	str r0, [r4, #0x3dc]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02153790: .word DeleteSaveDataMenu__Func_215382C
	arm_func_end DeleteSaveDataMenu__Func_21536FC

	arm_func_start DeleteSaveDataMenu__Func_2153794
DeleteSaveDataMenu__Func_2153794: // 0x02153794
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	add r0, r4, #0x178
	mov r1, #1
	bl FontAnimator__LoadCharacters
	add r0, r4, #0x178
	bl FontAnimator__Draw
	add r0, r4, #0x178
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x3c4]
	add r0, r0, #1
	cmp r0, #0x78
	addlo sp, sp, #4
	str r0, [r4, #0x3c4]
	ldmloia sp!, {r3, r4, pc}
	add r0, r4, #0x178
	bl FontAnimator__ClearPixels
	add r0, r4, #0x178
	bl FontAnimator__Draw
	mov r3, #0
	add r0, r4, #0xb0
	mov r1, #4
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xb0
	bl FontWindowAnimator__StartAnimating
	mov r1, #1
	ldr r0, _02153828 // =DeleteSaveDataMenu__Func_215382C
	str r1, [r4, #0x3cc]
	str r0, [r4, #0x3dc]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02153828: .word DeleteSaveDataMenu__Func_215382C
	arm_func_end DeleteSaveDataMenu__Func_2153794

	arm_func_start DeleteSaveDataMenu__Func_215382C
DeleteSaveDataMenu__Func_215382C: // 0x0215382C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xb0
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0xb0
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x3cc]
	cmp r0, #0
	add r0, r4, #0xb0
	beq _0215386C
	bl FontWindowAnimator__SetWindowClosed
	mov r0, #0
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
_0215386C:
	bl FontWindowAnimator__SetWindowOpen
	ldr r0, _0215387C // =DeleteSaveDataMenu__Func_2153880
	str r0, [r4, #0x3dc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215387C: .word DeleteSaveDataMenu__Func_2153880
	arm_func_end DeleteSaveDataMenu__Func_215382C

	arm_func_start DeleteSaveDataMenu__Func_2153880
DeleteSaveDataMenu__Func_2153880: // 0x02153880
	ldr r2, _021538BC // =renderCoreGFXControlA
	mvn r1, #0xf
	ldrsh r3, [r2, #0x58]
	cmp r3, r1
	subgt r1, r3, #1
	strgth r1, [r2, #0x58]
	ldr r1, _021538BC // =renderCoreGFXControlA
	ldr r2, _021538C0 // =renderCoreGFXControlB
	ldrsh r3, [r1, #0x58]
	mvn r1, #0xf
	cmp r3, r1
	strh r3, [r2, #0x58]
	moveq r1, #0
	streq r1, [r0, #0x3dc]
	bx lr
	.align 2, 0
_021538BC: .word renderCoreGFXControlA
_021538C0: .word renderCoreGFXControlB
	arm_func_end DeleteSaveDataMenu__Func_2153880

	arm_func_start DeleteSaveDataMenu__Func_21538C4
DeleteSaveDataMenu__Func_21538C4: // 0x021538C4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x28
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0xca]
	add r0, r4, #0x23c
	bl FontAnimator__SetMsgSequence
	add r0, r4, #0x23c
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	mov r0, r0, lsl #1
	mov r3, #2
	add r0, r0, #2
	mov r0, r0, lsl #0x10
	mov r2, #0
	str r3, [sp]
	mov r1, #4
	str r1, [sp, #4]
	mov r1, #0xd
	str r1, [sp, #8]
	mov r1, #0x18
	str r1, [sp, #0xc]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	str r3, [sp, #0x18]
	str r3, [sp, #0x1c]
	mov r0, #0x200
	str r0, [sp, #0x20]
	mov r1, r4
	mov r3, r2
	add r0, r4, #0x114
	str r2, [sp, #0x24]
	bl FontWindowAnimator__Load1
	mov r3, #0
	str r3, [sp]
	add r0, r4, #0x114
	mov r1, #1
	mov r2, #8
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0x114
	bl FontWindowAnimator__StartAnimating
	add r0, r4, #0x114
	bl FontWindowAnimator__Func_20599B4
	ldr r0, _02153984 // =DeleteSaveDataMenu__Func_2153988
	str r0, [r4, #0x3e0]
	add sp, sp, #0x28
	ldmia sp!, {r4, pc}
	.align 2, 0
_02153984: .word DeleteSaveDataMenu__Func_2153988
	arm_func_end DeleteSaveDataMenu__Func_21538C4

	arm_func_start DeleteSaveDataMenu__Func_2153988
DeleteSaveDataMenu__Func_2153988: // 0x02153988
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x114
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0x114
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x114
	bl FontWindowAnimator__SetWindowOpen
	add r0, r4, #0x23c
	mov r1, #0
	bl FontAnimator__LoadCharacters
	add r0, r4, #0x300
	mov r1, #0
	bl FontWindowMWControl__SetPaletteAnim
	add r0, r4, #0x300
	bl FontWindowMWControl__ValidatePaletteAnim
	add r0, r4, #0x300
	mov r1, #0x28
	ldrh r2, [r0, #0xc8]
	mov r2, r2, lsl #4
	add r2, r2, #0x70
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	bl FontWindowMWControl__SetPosition
	add r0, r4, #0x354
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	ldr r0, _02153A08 // =DeleteSaveDataMenu__Func_2153A0C
	str r0, [r4, #0x3e0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02153A08: .word DeleteSaveDataMenu__Func_2153A0C
	arm_func_end DeleteSaveDataMenu__Func_2153988

	arm_func_start DeleteSaveDataMenu__Func_2153A0C
DeleteSaveDataMenu__Func_2153A0C: // 0x02153A0C
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, #0
	mov r6, r0
	mov r1, r4
	add r0, r6, #0x23c
	mov r5, r4
	bl FontAnimator__GetDialogLineCount
	ldr r1, _02153B90 // =padInput
	ldrh r1, [r1, #4]
	tst r1, #0x40
	beq _02153A58
	add r0, r6, #0x300
	ldrh r1, [r0, #0xc8]
	cmp r1, #0
	beq _02153A8C
	sub r1, r1, #1
	strh r1, [r0, #0xc8]
	mov r4, #1
	b _02153A8C
_02153A58:
	tst r1, #0x80
	beq _02153A84
	add r1, r6, #0x300
	ldrh r2, [r1, #0xc8]
	sub r0, r0, #1
	cmp r2, r0
	bge _02153A8C
	add r0, r2, #1
	strh r0, [r1, #0xc8]
	mov r4, #1
	b _02153A8C
_02153A84:
	tst r1, #2
	movne r5, #1
_02153A8C:
	cmp r4, #0
	beq _02153AC8
	add r0, r6, #0x300
	bl FontWindowMWControl__ValidatePaletteAnim
	add r0, r6, #0x300
	ldrh r2, [r0, #0xc8]
	mov r1, #0x28
	mov r2, r2, lsl #4
	add r2, r2, #0x70
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	bl FontWindowMWControl__SetPosition
	add r0, r6, #0x354
	mov r1, #0
	bl AnimatorSprite__SetAnimation
_02153AC8:
	add r0, r6, #0x23c
	bl FontAnimator__Draw
	add r0, r6, #0x300
	bl FontWindowMWControl__Draw
	add r0, r6, #0x300
	bl FontWindowMWControl__CallWindowFunc2
	mov r1, #0
	mov r0, #0x28
	add r3, r6, #0x300
	strh r0, [r3, #0x5c]
	mov lr, #0x78
	strh lr, [r3, #0x5e]
	ldrh ip, [r3, #0xc8]
	add r0, r6, #0x354
	mov r2, r1
	add ip, lr, ip, lsl #4
	strh ip, [r3, #0x5e]
	bl AnimatorSprite__ProcessAnimation
	add r0, r6, #0x354
	bl AnimatorSprite__DrawFrame
	cmp r4, #0
	beq _02153B2C
	mov r0, #2
	bl PlaySysMenuNavSfx
	ldmia sp!, {r4, r5, r6, pc}
_02153B2C:
	cmp r5, #0
	beq _02153B5C
	add r0, r6, #0x300
	mov r1, #1
	bl FontWindowMWControl__SetPaletteAnim
	mov r0, #0
	str r0, [r6, #0x3c4]
	ldr r1, _02153B94 // =DeleteSaveDataMenu__Func_2153B98
	mov r0, #1
	str r1, [r6, #0x3e0]
	bl PlaySysMenuNavSfx
	ldmia sp!, {r4, r5, r6, pc}
_02153B5C:
	ldr r0, _02153B90 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	ldmeqia sp!, {r4, r5, r6, pc}
	add r0, r6, #0x300
	mov r1, #1
	bl FontWindowMWControl__SetPaletteAnim
	mov r0, #0
	ldr r1, _02153B94 // =DeleteSaveDataMenu__Func_2153B98
	str r0, [r6, #0x3c4]
	str r1, [r6, #0x3e0]
	bl PlaySysMenuNavSfx
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02153B90: .word padInput
_02153B94: .word DeleteSaveDataMenu__Func_2153B98
	arm_func_end DeleteSaveDataMenu__Func_2153A0C

	arm_func_start DeleteSaveDataMenu__Func_2153B98
DeleteSaveDataMenu__Func_2153B98: // 0x02153B98
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	add r0, r4, #0x300
	bl FontWindowMWControl__Draw
	add r0, r4, #0x300
	bl FontWindowMWControl__CallWindowFunc2
	ldr r1, [r4, #0x3c4]
	add r0, r4, #0x23c
	add r1, r1, #1
	str r1, [r4, #0x3c4]
	bl FontAnimator__ClearPixels
	add r0, r4, #0x23c
	bl FontAnimator__Draw
	mov r3, #0
	str r3, [sp]
	add r0, r4, #0x114
	mov r1, #4
	mov r2, #8
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0x114
	bl FontWindowAnimator__StartAnimating
	mov r0, #1
	str r0, [r4, #0x3cc]
	ldr r0, _02153C08 // =DeleteSaveDataMenu__Func_2153C0C
	str r0, [r4, #0x3e0]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02153C08: .word DeleteSaveDataMenu__Func_2153C0C
	arm_func_end DeleteSaveDataMenu__Func_2153B98

	arm_func_start DeleteSaveDataMenu__Func_2153C0C
DeleteSaveDataMenu__Func_2153C0C: // 0x02153C0C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x114
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0x114
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x3cc]
	cmp r0, #0
	add r0, r4, #0x114
	beq _02153C4C
	bl FontWindowAnimator__SetWindowClosed
	mov r0, #0
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
_02153C4C:
	bl FontWindowAnimator__SetWindowOpen
	add r0, r4, #0x114
	bl FontWindowAnimator__Release
	mov r0, #0
	str r0, [r4, #0x3e0]
	ldmia sp!, {r4, pc}
	arm_func_end DeleteSaveDataMenu__Func_2153C0C

	arm_func_start DeleteSaveDataMenu__Func_2153C64
DeleteSaveDataMenu__Func_2153C64: // 0x02153C64
	stmdb sp!, {r3, lr}
	cmp r0, #0
	beq _02153C8C
	ldr r0, _02153CB4 // =saveGame
	ldr r1, _02153CB8 // =0x000001FE
	bl SaveGame__ClearData
	ldr r0, _02153CB4 // =saveGame
	ldr r1, _02153CB8 // =0x000001FE
	bl SaveGame__SaveData
	b _02153CA4
_02153C8C:
	ldr r0, _02153CB4 // =saveGame
	mov r1, #0xc
	bl SaveGame__ClearData
	ldr r0, _02153CB4 // =saveGame
	ldr r1, _02153CB8 // =0x000001FE
	bl SaveGame__SaveData
_02153CA4:
	cmp r0, #2
	moveq r0, #0
	movne r0, #1
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153CB4: .word saveGame
_02153CB8: .word 0x000001FE
	arm_func_end DeleteSaveDataMenu__Func_2153C64
	
	.data

aBbDmSaveDelBb: // 0x02162980
	.asciz "bb/dm_save_del.bb"
	.align 4

aFntFontAllFnt_5_ovl04: // 0x02162994
	.asciz "fnt/font_all.fnt"
	.align 4

aNarcDmSdActLz7: // 0x021629A8
	.asciz "narc/dm_sd_act_lz7.narc"
	.align 4

aNarcDmniLz7Nar_ovl04: // 0x021629C0
	.asciz "narc/dmni_lz7.narc"
	.align 4