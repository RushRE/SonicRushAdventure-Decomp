	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SoundTest__Create
SoundTest__Create: // 0x0215C734
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	bl ResetTouchInput
	mov r0, #0xa
	str r0, [sp]
	mov r2, #0
	ldr ip, _0215C770 // =0x00000B88
	str r0, [sp, #4]
	ldr r0, _0215C774 // =SoundTest__Main_Init
	ldr r1, _0215C778 // =SoundTest__Destructor
	mov r3, r2
	str ip, [sp, #8]
	bl TaskCreate_
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0215C770: .word 0x00000B88
_0215C774: .word SoundTest__Main_Init
_0215C778: .word SoundTest__Destructor
	arm_func_end SoundTest__Create

	arm_func_start SoundTest__Init
SoundTest__Init: // 0x0215C77C
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r2, _0215C870 // =0x00000B88
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear32
	ldr r3, _0215C874 // =0x04000204
	mov r0, r4
	ldrh r2, [r3, #0]
	mov r1, #0
	and r2, r2, #0x8000
	mov r2, r2, asr #0xf
	str r2, [r4, #0xb84]
	ldrh r2, [r3, #0]
	orr r2, r2, #0x8000
	strh r2, [r3]
	strh r1, [r4, #2]
	bl SoundTest__SetupDisplay
	mov r0, r4
	bl SoundTest__LoadAssets
	ldr r0, [r4, #0x44]
	bl SoundTest__GetSongCount
	strh r0, [r4]
	ldrh r0, [r4, #0]
	mov r0, r0, lsl #2
	bl _AllocHeadHEAP_SYSTEM
	str r0, [r4, #0x48]
	ldrh r2, [r4, #0]
	ldr r1, [r4, #0x48]
	mov r0, #0
	mov r2, r2, lsl #2
	bl MIi_CpuClear32
	add r0, r4, #0x4c
	bl FontFile__Init
	ldr r1, [r4, #0x40]
	add r0, r4, #0x4c
	bl FontFile__InitFromHeader
	mov r0, r4
	bl SoundTest__SetupAssets
	mov r0, r4
	bl SoundTest__SetupBackgrounds
	mov r0, r4
	bl SoundTest__InitAudio
	ldrh r0, [r4, #0]
	mov r6, #0
	cmp r0, #0
	ldmleia sp!, {r4, r5, r6, pc}
	mov r5, #1
_0215C83C:
	mov r1, r6, lsl #0x10
	ldr r0, [r4, #0x44]
	mov r1, r1, lsr #0x10
	bl SoundTest__GetSongUnlockFlags
	bl SoundTest__CheckSongUnlocked
	cmp r0, #0
	ldrne r0, [r4, #0x48]
	strne r5, [r0, r6, lsl #2]
	ldrh r0, [r4, #0]
	add r6, r6, #1
	cmp r6, r0
	blt _0215C83C
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215C870: .word 0x00000B88
_0215C874: .word 0x04000204
	arm_func_end SoundTest__Init

	arm_func_start SoundTest__SetupDisplay
SoundTest__SetupDisplay: // 0x0215C878
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r1, _0215CB50 // =renderCoreGFXControlA
	mvn r2, #0xf
	ldr r0, _0215CB54 // =renderCoreGFXControlB
	strh r2, [r1, #0x58]
	strh r2, [r0, #0x58]
	ldrsh r1, [r1, #0x58]
	ldr r0, _0215CB58 // =0x0400006C
	bl GXx_SetMasterBrightness_
	ldr r1, _0215CB54 // =renderCoreGFXControlB
	ldr r0, _0215CB5C // =0x0400106C
	ldrsh r1, [r1, #0x58]
	bl GXx_SetMasterBrightness_
	ldr r2, _0215CB60 // =0x04000304
	ldr r0, _0215CB64 // =0xFFFFFDF1
	ldrh r1, [r2, #0]
	and r0, r1, r0
	orr r0, r0, #0xe
	orr r0, r0, #0x200
	strh r0, [r2]
	ldrh r0, [r2, #0]
	orr r0, r0, #0xc
	strh r0, [r2]
	bl VRAMSystem__Reset
	mov r0, #1
	bl VRAMSystem__SetupTextureBank
	mov r0, #0x20
	bl VRAMSystem__SetupTexturePalBank
	mov r0, #2
	bl VRAMSystem__SetupBGBank
	mov r0, #0x200
	str r0, [sp]
	mov r0, #0x10
	add r1, r0, #0x200000
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupOBJBank
	mov r0, #0x40
	bl VRAMSystem__SetupBGExtPalBank
	mov r0, #0
	bl VRAMSystem__SetupOBJExtPalBank
	mov r0, #0
	bl VRAMSystem__InitSpriteBuffer
	mov r0, #4
	bl VRAMSystem__SetupSubBGBank
	mov r0, #0x400
	str r0, [sp]
	mov r0, #8
	ldr r1, _0215CB68 // =0x00200010
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupSubOBJBank
	mov r0, #0x80
	bl VRAMSystem__SetupSubBGExtPalBank
	mov r0, #0x100
	bl VRAMSystem__SetupSubOBJExtPalBank
	mov r0, #1
	bl VRAMSystem__InitSpriteBuffer
	mov r3, #0x4000000
	ldr r1, [r3, #0]
	mov r0, #1
	bic r1, r1, #0x38000000
	str r1, [r3]
	ldr r2, [r3, #0]
	mov r1, #0
	bic r2, r2, #0x7000000
	str r2, [r3]
	mov r2, r0
	bl GX_SetGraphicsMode
	ldr r3, _0215CB6C // =0x0400000A
	ldrh r0, [r3, #0]
	and r0, r0, #0x43
	orr r0, r0, #4
	strh r0, [r3]
	ldrh r0, [r3, #2]
	sub r4, r3, #2
	mov ip, #0x4000000
	and r0, r0, #0x43
	orr r0, r0, #0x108
	strh r0, [r3, #2]
	ldrh r2, [r3, #4]
	mov r0, #0
	mov r1, #0x6000000
	and r2, r2, #0x43
	orr r2, r2, #0x20c
	orr r2, r2, #0x4000
	strh r2, [r3, #4]
	ldrh lr, [r3, #2]
	mov r2, #0x80000
	bic lr, lr, #3
	strh lr, [r3, #2]
	ldrh lr, [r3]
	bic lr, lr, #3
	orr lr, lr, #1
	strh lr, [r3]
	ldrh lr, [r4]
	bic lr, lr, #3
	orr lr, lr, #2
	strh lr, [r4]
	ldrh lr, [r3, #4]
	bic lr, lr, #3
	orr lr, lr, #3
	strh lr, [r3, #4]
	ldr r3, [ip]
	bic r3, r3, #0x1f00
	orr r3, r3, #0xf00
	str r3, [ip]
	bl MIi_CpuClearFast
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r3, _0215CB70 // =0x04001008
	ldr r1, _0215CB54 // =renderCoreGFXControlB
	ldrh ip, [r3]
	mov r0, #0
	mov r2, #0x10
	and ip, ip, #0x43
	orr ip, ip, #4
	strh ip, [r3]
	ldrh ip, [r3, #2]
	and ip, ip, #0x43
	orr ip, ip, #0x108
	strh ip, [r3, #2]
	ldrh ip, [r3, #4]
	and ip, ip, #0x43
	orr ip, ip, #0x20c
	strh ip, [r3, #4]
	ldrh ip, [r3, #6]
	and ip, ip, #0x43
	orr ip, ip, #0x310
	strh ip, [r3, #6]
	bl MIi_CpuClear32
	ldr r2, _0215CB74 // =0x0400100E
	ldrh r0, [r2, #0]
	sub r1, r2, #2
	bic r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1, #0]
	bic r0, r0, #3
	orr r0, r0, #1
	strh r0, [r1]
	sub r1, r2, #4
	ldrh r0, [r1, #0]
	sub r3, r2, #6
	sub ip, r2, #0xe
	bic r0, r0, #3
	orr r0, r0, #2
	strh r0, [r1]
	ldrh r2, [r3, #0]
	mov r0, #0
	mov r1, #0x6200000
	bic r2, r2, #3
	orr r2, r2, #3
	strh r2, [r3]
	ldr r3, [ip]
	mov r2, #0x20000
	bic r3, r3, #0x1f00
	orr r3, r3, #0x1f00
	str r3, [ip]
	bl MIi_CpuClearFast
	ldr r1, _0215CB50 // =renderCoreGFXControlA
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	ldr r1, _0215CB54 // =renderCoreGFXControlB
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	ldr r1, _0215CB78 // =renderCurrentDisplay
	mov r2, #1
	ldr r0, _0215CB7C // =0x0213D2E0
	str r2, [r1]
	bl RenderCore_DisableBlending
	ldr r0, _0215CB80 // =0x0213D284
	bl RenderCore_DisableBlending
	ldr r1, _0215CB50 // =renderCoreGFXControlA
	mov r2, #0
	ldr r0, _0215CB54 // =renderCoreGFXControlB
	str r2, [r1, #0x1c]
	str r2, [r0, #0x1c]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0215CB50: .word renderCoreGFXControlA
_0215CB54: .word renderCoreGFXControlB
_0215CB58: .word 0x0400006C
_0215CB5C: .word 0x0400106C
_0215CB60: .word 0x04000304
_0215CB64: .word 0xFFFFFDF1
_0215CB68: .word 0x00200010
_0215CB6C: .word 0x0400000A
_0215CB70: .word 0x04001008
_0215CB74: .word 0x0400100E
_0215CB78: .word renderCurrentDisplay
_0215CB7C: .word 0x0213D2E0
_0215CB80: .word 0x0213D284
	arm_func_end SoundTest__SetupDisplay

	arm_func_start SoundTest__LoadAssets
SoundTest__LoadAssets: // 0x0215CB84
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _0215CCE8 // =aNarcDmsouLz7Na
	mov r1, #0
	bl ArchiveFileUnknown__LoadFile
	str r0, [r4, #4]
	mov r1, #0
	bl FileUnknown__GetAOUFile
	str r0, [r4, #8]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0215CBE0
_0215CBBC: // jump table
	b _0215CBD4 // case 0
	b _0215CBD4 // case 1
	b _0215CBD4 // case 2
	b _0215CBD4 // case 3
	b _0215CBD4 // case 4
	b _0215CBD4 // case 5
_0215CBD4:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _0215CBE4
_0215CBE0:
	mov r0, #1
_0215CBE4:
	add r0, r0, #1
	mov r1, r0, lsl #0x10
	ldr r0, [r4, #4]
	mov r1, r1, lsr #0x10
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0xc]
	ldr r0, [r4, #4]
	mov r1, #7
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x10]
	ldr r0, [r4, #4]
	mov r1, #9
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x14]
	ldr r0, [r4, #4]
	mov r1, #0xa
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x18]
	ldr r0, [r4, #4]
	mov r1, #8
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x1c]
	ldr r0, [r4, #4]
	mov r1, #0xb
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x20]
	ldr r0, [r4, #4]
	mov r1, #0xc
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x24]
	ldr r0, [r4, #4]
	mov r1, #0xd
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x28]
	ldr r0, [r4, #4]
	mov r1, #0xe
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x2c]
	ldr r0, [r4, #4]
	mov r1, #0xf
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x30]
	ldr r0, [r4, #4]
	mov r1, #0x10
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x34]
	ldr r0, _0215CCEC // =aStSoundTestLz7
	mov r1, #0
	bl BundleFileUnknown__LoadFile
	str r0, [r4, #0x44]
	ldr r0, _0215CCF0 // =aBbViNpcBb_ovl04
	mov r1, #0x14
	mov r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r4, #0x38]
	mov r1, #0
	ldr r0, _0215CCF4 // =aNarcViBgLz7Nar_ovl04
	mov r2, r1
	bl ArchiveFileUnknown__LoadFileFromArchive
	str r0, [r4, #0x3c]
	ldr r0, _0215CCF8 // =aFntFontIplFnt_ovl04
	mov r1, #0
	bl FSRequestFileSync
	str r0, [r4, #0x40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CCE8: .word aNarcDmsouLz7Na
_0215CCEC: .word aStSoundTestLz7
_0215CCF0: .word aBbViNpcBb_ovl04
_0215CCF4: .word aNarcViBgLz7Nar_ovl04
_0215CCF8: .word aFntFontIplFnt_ovl04
	arm_func_end SoundTest__LoadAssets

	arm_func_start SoundTest__SetupAssets
SoundTest__SetupAssets: // 0x0215CCFC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x64
	mov r1, #1
	str r1, [sp]
	mov r1, #0x20
	mov r4, r0
	str r1, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	ldr r1, [r4, #0x1c]
	add r0, sp, #0x1c
	mov r2, #0x38
	mov r3, #0
	bl InitBackground
	add r0, sp, #0x1c
	bl DrawBackground
	mov r0, #3
	str r0, [sp]
	mov r0, #0x40
	str r0, [sp, #4]
	mov r0, #0x20
	str r0, [sp, #8]
	ldr r1, [r4, #0x3c]
	add r0, sp, #0x1c
	mov r2, #0x38
	mov r3, #0
	bl InitBackground
	add r0, sp, #0x1c
	bl DrawBackground
	mov r1, #1
	add r0, r4, #0x500
	strh r1, [r0, #0x14]
	add r0, r4, #0x110
	mov r1, #0
	bl AnimatorMDL__Init
	ldr r0, [r4, #0x38]
	bl NNS_G3dResDefaultSetup
	mov r2, #0
	str r2, [sp]
	ldr r1, [r4, #0x38]
	add r0, r4, #0x110
	mov r3, r2
	bl AnimatorMDL__SetResource
	mov r1, #0
	str r1, [sp]
	add r3, r4, #0x500
	ldrh r3, [r3, #0x14]
	ldr r2, [r4, #0x24]
	add r0, r4, #0x110
	bl AnimatorMDL__SetAnimation
	mov r3, #0
	mov r2, #1
_0215CDCC:
	mov r0, r2, lsl r3
	tst r0, #1
	beq _0215CDEC
	add r0, r4, r3, lsl #1
	add r0, r0, #0x200
	ldrh r1, [r0, #0x1c]
	orr r1, r1, #2
	strh r1, [r0, #0x1c]
_0215CDEC:
	add r3, r3, #1
	cmp r3, #5
	blo _0215CDCC
	add r0, r4, #0x254
	mov r1, #0
	bl AnimatorMDL__Init
	ldr r0, [r4, #0x28]
	bl NNS_G3dResDefaultSetup
	mov r2, #0
	str r2, [sp]
	ldr r1, [r4, #0x28]
	mov r3, r2
	add r0, r4, #0x254
	bl AnimatorMDL__SetResource
	add r0, r4, #0x398
	mov r1, #0
	bl AnimatorMDL__Init
	ldr r0, [r4, #0x30]
	bl NNS_G3dResDefaultSetup
	mov r2, #0
	str r2, [sp]
	ldr r1, [r4, #0x30]
	add r0, r4, #0x398
	mov r3, r2
	bl AnimatorMDL__SetResource
	mov r1, #0
	str r1, [sp]
	ldr r2, [r4, #0x34]
	add r0, r4, #0x398
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	mov r3, #0
	mov r2, #1
_0215CE70:
	mov r0, r2, lsl r3
	tst r0, #1
	beq _0215CE90
	add r0, r4, r3, lsl #1
	add r0, r0, #0x400
	ldrh r1, [r0, #0xa4]
	orr r1, r1, #2
	strh r1, [r0, #0xa4]
_0215CE90:
	add r3, r3, #1
	cmp r3, #5
	blo _0215CE70
	mov r0, #0x900
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x510]
	mov r0, #4
	str r0, [sp]
	mov r0, #0x14
	mov r1, #0
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	mov r0, #3
	str r0, [sp, #0xc]
	ldr r0, [r4, #0x510]
	mov r3, r1
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov ip, #0x20
	add r0, r4, #0x4e0
	mov r2, #2
	str ip, [sp, #0x18]
	bl Unknown2056570__Init
	add r0, r4, #0x4e0
	mov r1, #1
	bl Unknown2056570__Func_2056688
	ldr r0, _0215CF24 // =0x02110460
	ldr r1, _0215CF28 // =0x05000022
	mov r2, #8
	bl MIi_CpuCopy16
	mov r1, #0
	ldr r0, _0215CF2C // =SoundTest__StateDraw3D_DrawStage
	str r1, [r4, #0x4dc]
	str r0, [r4, #0x518]
	add sp, sp, #0x64
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0215CF24: .word 0x02110460
_0215CF28: .word 0x05000022
_0215CF2C: .word SoundTest__StateDraw3D_DrawStage
	arm_func_end SoundTest__SetupAssets

	arm_func_start SoundTest__SetupBackgrounds
SoundTest__SetupBackgrounds: // 0x0215CF30
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x7c
	ldr r1, _0215D1F8 // =_021618FC
	mov r10, r0
	ldrh r0, [r1, #0xa]
	ldrh r3, [r1, #8]
	mov r2, #0
	strh r0, [sp, #0x22]
	strh r3, [sp, #0x20]
	ldrh r4, [r1, #4]
	ldrh r3, [r1, #6]
	mov r1, #0x20
	mov r0, #0x18
	strh r3, [sp, #0x1e]
	strh r4, [sp, #0x1c]
	str r2, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r1, [r10, #0x10]
	add r0, sp, #0x34
	mov r2, #0x38
	mov r3, #1
	bl InitBackground
	add r0, sp, #0x34
	bl DrawBackground
	mov r0, #2
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	ldr r1, [r10, #0x18]
	add r0, sp, #0x34
	mov r2, #0x38
	mov r3, #1
	bl InitBackground
	add r0, sp, #0x34
	bl DrawBackground
	mov r0, r10
	bl SoundTest__Func_215D6C4
	add r0, r10, #0x11c
	ldr r4, _0215D1FC // =_02161942
	add r6, r0, #0x400
	mov r5, #0
_0215CFE0:
	add r3, r4, r5, lsl #3
	ldrb r1, [r3, #7]
	mov r2, r5, lsl #3
	mov r0, r6
	str r1, [sp]
	ldrh r1, [r3, #4]
	str r1, [sp, #4]
	ldrh r1, [r4, r2]
	ldrh r2, [r3, #2]
	ldrb r3, [r3, #6]
	add r1, r10, r1, lsl #2
	ldr r1, [r1, #8]
	bl SoundTest__SetAnimation2D
	add r5, r5, #1
	cmp r5, #0xc
	add r6, r6, #0x64
	blt _0215CFE0
	add r0, r10, #0x800
	mov r1, #0x80
	strh r1, [r0, #0xa8]
	mov r1, #0xa0
	strh r1, [r0, #0xaa]
	ldr r0, [r10, #0x8dc]
	mov r2, #0
	orr r0, r0, #0x200
	str r0, [r10, #0x8dc]
	str r2, [r10, #0xb54]
	add r0, r10, #0x1cc
	ldr r1, _0215D200 // =0x05000440
	str r2, [sp]
	str r1, [sp, #4]
	ldr r1, [r10, #0x20]
	add r0, r0, #0x800
	mov r3, #2
	bl InitPaletteAnimator
	add r0, r10, #0x1ec
	add r0, r0, #0x800
	bl TouchField__Init
	add r0, r10, #0x204
	add r8, r0, #0x800
	add r0, r10, #0x11c
	ldr r7, _0215D204 // =TouchField__PointInCircle
	ldr r11, _0215D208 // =_02161908
	mov r9, #0
	add r5, r0, #0x400
	add r4, r10, #0x1ec
	add r6, sp, #0x24
_0215D09C:
	mov r0, r9, lsl #1
	ldrh r2, [r11, r0]
	cmp r2, #1
	bne _0215D0D8
	mov r0, #0x17000
	str r0, [sp, #0x24]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	mov r0, r8
	add r1, sp, #0x20
	mov r2, r7
	mov r3, r6
	bl TouchField__InitAreaShape
	b _0215D130
_0215D0D8:
	cmp r2, #2
	bne _0215D10C
	mov r0, #0x17000
	str r0, [sp, #0x24]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	mov r0, r8
	add r1, sp, #0x1c
	mov r2, r7
	mov r3, r6
	bl TouchField__InitAreaShape
	b _0215D130
_0215D10C:
	mov r0, #0x64
	mla r1, r2, r0, r5
	mov r0, #0
	str r0, [sp]
	mov r2, #0
	str r0, [sp, #4]
	mov r0, r8
	mov r3, r2
	bl TouchField__InitAreaSprite
_0215D130:
	ldr r2, _0215D20C // =0x0000FFFF
	add r0, r4, #0x800
	mov r1, r8
	bl TouchField__AddArea
	add r9, r9, #1
	add r8, r8, #0x38
	cmp r9, #5
	blt _0215D09C
	mov r0, #0x900
	bl _AllocHeadHEAP_USER
	str r0, [r10, #0xb4c]
	mov r0, #4
	str r0, [sp]
	mov r3, #0
	add r0, r10, #0x31c
	str r3, [sp, #4]
	mov r1, #0x18
	str r1, [sp, #8]
	mov r2, #3
	str r2, [sp, #0xc]
	ldr r1, [r10, #0xb4c]
	add r0, r0, #0x800
	str r1, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r4, #0x20
	mov r1, #1
	str r4, [sp, #0x18]
	bl Unknown2056570__Init
	add r0, r10, #0x31c
	add r0, r0, #0x800
	mov r1, #3
	bl Unknown2056570__Func_2056688
	ldr r0, _0215D210 // =0x02110460
	ldr r1, _0215D214 // =0x05000462
	mov r2, #8
	bl MIi_CpuCopy16
	mov r0, r10
	bl SoundTest__SetTrackInfo
	mov r0, r10
	ldrh r1, [r10, #2]
	mov r2, #1
	bl SoundTest__SetTrackNumber
	mov r1, #0x18
	add r0, r10, #0xb00
	strh r1, [r0, #0x50]
	strh r1, [r0, #0x52]
	ldr r0, _0215D218 // =SoundTest__State_FadeIn
	str r0, [r10, #0xb80]
	add sp, sp, #0x7c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215D1F8: .word _021618FC
_0215D1FC: .word _02161942
_0215D200: .word 0x05000440
_0215D204: .word TouchField__PointInCircle
_0215D208: .word _02161908
_0215D20C: .word 0x0000FFFF
_0215D210: .word 0x02110460
_0215D214: .word 0x05000462
_0215D218: .word SoundTest__State_FadeIn
	arm_func_end SoundTest__SetupBackgrounds

	arm_func_start SoundTest__Release
SoundTest__Release: // 0x0215D21C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SoundTest__ReleaseAudio
	mov r0, r4
	bl SoundTest__ReleaseSprites
	mov r0, r4
	bl SoundTest__ReleaseModels
	add r0, r4, #0x4c
	bl FontFile__Release
	mov r0, r4
	bl SoundTest__ReleaseAssets
	mov r0, r4
	bl SoundTest__ReleaseUnknown
	ldr r0, [r4, #0x48]
	cmp r0, #0
	beq _0215D268
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r4, #0x48]
_0215D268:
	ldr r0, [r4, #0xb84]
	ldr r1, _0215D29C // =0x04000204
	cmp r0, #1
	cmpne r0, #0
	movne r0, #0
	strne r0, [r4, #0xb84]
	ldrh r0, [r1, #0]
	ldr r2, [r4, #0xb84]
	bic r0, r0, #0x8000
	orr r0, r0, r2, lsl #15
	strh r0, [r1]
	bl SoundTest__EnableSleepOnFold
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D29C: .word 0x04000204
	arm_func_end SoundTest__Release

	arm_func_start SoundTest__ReleaseUnknown
SoundTest__ReleaseUnknown: // 0x0215D2A0
	bx lr
	arm_func_end SoundTest__ReleaseUnknown

	arm_func_start SoundTest__ReleaseAssets
SoundTest__ReleaseAssets: // 0x0215D2A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0215D2C4
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #4]
_0215D2C4:
	ldr r0, [r4, #0x44]
	cmp r0, #0
	beq _0215D2DC
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x44]
_0215D2DC:
	ldr r0, [r4, #0x38]
	cmp r0, #0
	beq _0215D2EC
	bl _FreeHEAP_USER
_0215D2EC:
	ldr r0, [r4, #0x3c]
	cmp r0, #0
	beq _0215D2FC
	bl _FreeHEAP_USER
_0215D2FC:
	ldr r0, [r4, #0x40]
	cmp r0, #0
	beq _0215D30C
	bl _FreeHEAP_USER
_0215D30C:
	add r1, r4, #8
	mov r0, #0
	mov r2, #0x3c
	bl MIi_CpuClear32
	ldmia sp!, {r4, pc}
	arm_func_end SoundTest__ReleaseAssets

	arm_func_start SoundTest__ReleaseModels
SoundTest__ReleaseModels: // 0x0215D320
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x110
	bl AnimatorMDL__Release
	add r1, r4, #0x110
	mov r0, #0
	mov r2, #0x144
	bl MIi_CpuClear16
	ldr r0, [r4, #0x38]
	bl NNS_G3dResDefaultRelease
	add r0, r4, #0x254
	bl AnimatorMDL__Release
	mov r0, #0
	add r1, r4, #0x254
	mov r2, #0x144
	bl MIi_CpuClear16
	ldr r0, [r4, #0x28]
	bl NNS_G3dResDefaultRelease
	add r0, r4, #0x398
	bl AnimatorMDL__Release
	mov r0, #0
	add r1, r4, #0x398
	mov r2, #0x144
	bl MIi_CpuClear16
	ldr r0, [r4, #0x30]
	bl NNS_G3dResDefaultRelease
	add r0, r4, #0x4e0
	bl Unknown2056570__Func_2056670
	ldr r0, [r4, #0x510]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x510]
	ldmia sp!, {r4, pc}
	arm_func_end SoundTest__ReleaseModels

	arm_func_start SoundTest__ReleaseSprites
SoundTest__ReleaseSprites: // 0x0215D3AC
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	add r0, r4, #0x1cc
	add r0, r0, #0x800
	bl ReleasePaletteAnimator
	add r0, r4, #0x11c
	add r6, r0, #0x400
	mov r5, #0
_0215D3CC:
	mov r0, r6
	bl AnimatorSprite__Release
	add r5, r5, #1
	cmp r5, #0xc
	add r6, r6, #0x64
	blt _0215D3CC
	add r0, r4, #0x11c
	add r1, r0, #0x400
	mov r0, #0
	mov r2, #0x4b0
	bl MIi_CpuClear32
	ldr r0, [r4, #0xb58]
	cmp r0, #0
	beq _0215D418
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r4, #0xb58]
	str r0, [r4, #0xb5c]
	str r0, [r4, #0xb60]
_0215D418:
	ldr r0, [r4, #0xb68]
	cmp r0, #0
	beq _0215D430
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r4, #0xb68]
_0215D430:
	add r0, r4, #0x31c
	add r0, r0, #0x800
	bl Unknown2056570__Func_2056670
	ldr r0, [r4, #0xb4c]
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0xb4c]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SoundTest__ReleaseSprites

	arm_func_start SoundTest__Main_Init
SoundTest__Main_Init: // 0x0215D458
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SoundTest__Init
	mov r0, r4
	mov r1, #0
	bl SoundTest__InitTouchAreas
	ldr r0, _0215D480 // =SoundTest__Main_Active
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D480: .word SoundTest__Main_Active
	arm_func_end SoundTest__Main_Init

	arm_func_start SoundTest__Main_Active
SoundTest__Main_Active: // 0x0215D484
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x518]
	cmp r1, #0
	ldreq r0, [r4, #0xb80]
	cmpeq r0, #0
	bne _0215D4C4
	bl DestroyCurrentTask
	ldr r1, _0215D4FC // =gameState
	mov r2, #1
	mov r0, #0
	strb r2, [r1, #0xdc]
	bl RequestSysEventChange
	bl NextSysEvent
	b _0215D4E8
_0215D4C4:
	cmp r1, #0
	beq _0215D4D4
	mov r0, r4
	blx r1
_0215D4D4:
	ldr r1, [r4, #0xb80]
	cmp r1, #0
	beq _0215D4E8
	mov r0, r4
	blx r1
_0215D4E8:
	ldr r1, _0215D500 // =renderCoreGFXControlA
	ldr r0, _0215D504 // =renderCoreGFXControlB
	ldrsh r1, [r1, #0x58]
	strh r1, [r0, #0x58]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D4FC: .word gameState
_0215D500: .word renderCoreGFXControlA
_0215D504: .word renderCoreGFXControlB
	arm_func_end SoundTest__Main_Active

	arm_func_start SoundTest__Destructor
SoundTest__Destructor: // 0x0215D508
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl SoundTest__Release
	ldmia sp!, {r3, pc}
	arm_func_end SoundTest__Destructor

	arm_func_start SoundTest__DisableDraw3D
SoundTest__DisableDraw3D: // 0x0215D518
	mov r1, #0
	str r1, [r0, #0x518]
	bx lr
	arm_func_end SoundTest__DisableDraw3D

	arm_func_start SoundTest__SetKoalaAnim
SoundTest__SetKoalaAnim: // 0x0215D524
	stmdb sp!, {r3, lr}
	add r2, r0, #0x500
	ldrh r3, [r2, #0x14]
	cmp r3, r1
	ldmeqia sp!, {r3, pc}
	strh r1, [r2, #0x14]
	mov ip, #0
	mov r3, #1
_0215D544:
	mov r1, r3, lsl ip
	tst r1, #1
	beq _0215D564
	add r1, r0, ip, lsl #1
	add r1, r1, #0x200
	ldrh r2, [r1, #0x1c]
	orr r2, r2, #4
	strh r2, [r1, #0x1c]
_0215D564:
	add ip, ip, #1
	cmp ip, #5
	blo _0215D544
	ldr r2, _0215D59C // =0x00000199
	add r1, r0, #0x200
	strh r2, [r1, #0x42]
	mov r1, #0
	str r1, [sp]
	add r2, r0, #0x500
	ldrh r3, [r2, #0x14]
	ldr r2, [r0, #0x24]
	add r0, r0, #0x110
	bl AnimatorMDL__SetAnimation
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215D59C: .word 0x00000199
	arm_func_end SoundTest__SetKoalaAnim

	arm_func_start SoundTest__StateDraw3D_DrawStage
SoundTest__StateDraw3D_DrawStage: // 0x0215D5A0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r2, _0215D6B0 // =0xBFFF0000
	ldr r1, _0215D6B4 // =NNS_G3dGlb
	mov r4, r0
	str r2, [r1, #0xa0]
	ldr r0, [r4, #0x2c]
	ldr r1, _0215D6B8 // =0x001FFFFF
	bl LoadDrawState
	mov r0, #0
	ldr r2, _0215D6BC // =0x00007FFF
	mov r1, r0
	mov r3, r0
	str r0, [sp]
	bl G3X_SetClearColor
	mov r0, #0
	str r0, [r4, #0x158]
	str r0, [r4, #0x15c]
	str r0, [r4, #0x160]
	mov r1, #0x1000
	str r1, [r4, #0x128]
	str r1, [r4, #0x12c]
	add r0, r4, #0x134
	str r1, [r4, #0x130]
	bl MTX_Identity33_
	add r0, r4, #0x110
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x110
	bl AnimatorMDL__Draw
	mov r0, #0
	str r0, [r4, #0x29c]
	str r0, [r4, #0x2a0]
	str r0, [r4, #0x2a4]
	mov r1, #0x1000
	str r1, [r4, #0x26c]
	str r1, [r4, #0x270]
	add r0, r4, #0x278
	str r1, [r4, #0x274]
	bl MTX_Identity33_
	add r0, r4, #0x254
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x254
	bl AnimatorMDL__Draw
	mov r0, #0
	str r0, [r4, #0x3e0]
	str r0, [r4, #0x3e4]
	sub r0, r0, #0x1e000
	str r0, [r4, #0x3e8]
	mov r0, #0x1000
	str r0, [r4, #0x3b0]
	str r0, [r4, #0x3b4]
	str r0, [r4, #0x3b8]
	add r0, r4, #0x3bc
	bl MTX_Identity33_
	add r0, r4, #0x398
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x398
	bl AnimatorMDL__Draw
	ldr r1, [r4, #0x4dc]
	ldr r0, _0215D6C0 // =renderCoreGFXControlA
	add r1, r1, #1
	str r1, [r4, #0x4dc]
	mov r1, r1, lsr #6
	strh r1, [r0, #0xc]
	mov r1, #0x1f
	strh r1, [r0, #0xe]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0215D6B0: .word 0xBFFF0000
_0215D6B4: .word NNS_G3dGlb
_0215D6B8: .word 0x001FFFFF
_0215D6BC: .word 0x00007FFF
_0215D6C0: .word renderCoreGFXControlA
	arm_func_end SoundTest__StateDraw3D_DrawStage

	arm_func_start SoundTest__Func_215D6C4
SoundTest__Func_215D6C4: // 0x0215D6C4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x20
	mov r4, r0
	ldr r0, [r4, #0x14]
	bl GetBackgroundPalette
	ldr r3, _0215D840 // =0x05000420
	add r0, r0, #4
	mov r1, #0x10
	mov r2, #0
	bl LoadUncompressedPalette
	mov r0, #0x600
	bl _AllocHeadHEAP_USER
	mov r5, r0
	mov r1, r5
	mov r0, #0x1000
	mov r2, #0x600
	bl MIi_CpuClear16
	mov r2, #0
	mov lr, #1
	mov r6, #0xd
	mov r0, r2
	mov r1, r2
_0215D71C:
	mov r3, r1
_0215D720:
	add r7, r3, #9
	mov r7, r7, lsl #0x10
	mov r7, r7, lsr #0xb
	mov ip, r0
	add r9, r5, r7, lsl #1
_0215D734:
	add r7, ip, r6
	mov r7, r7, lsl #0x10
	add r8, lr, #1
	add ip, ip, #1
	orr lr, lr, #0x1000
	mov r7, r7, lsr #0xf
	strh lr, [r7, r9]
	mov r7, r8, lsl #0x10
	cmp ip, #2
	mov lr, r7, lsr #0x10
	blt _0215D734
	add r3, r3, #1
	cmp r3, #3
	blt _0215D720
	add r2, r2, #1
	cmp r2, #3
	add r6, r6, #2
	blt _0215D71C
	mov r0, r5
	mov r1, #0x600
	bl DC_StoreRange
	mov r1, #0
	str r1, [sp]
	mov r0, #0xc
	stmib sp, {r0, r1}
	mov r0, #1
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r3, #0x20
	mov r0, r5
	mov r2, r1
	str r3, [sp, #0x18]
	mov r6, #0x18
	str r6, [sp, #0x1c]
	bl Mappings__LoadUnknown
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x140
	bl _AllocHeadHEAP_SYSTEM
	str r0, [r4, #0xb68]
	mov r0, #0x240
	bl _AllocHeadHEAP_SYSTEM
	mov r1, #0
	str r0, [r4, #0xb58]
	add r0, r0, #0xc0
	str r0, [r4, #0xb5c]
	add r0, r0, #0xc0
	str r0, [r4, #0xb60]
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl SoundTest__Func_215D844
	mov r2, #0
	mov r0, r4
	mov r1, #1
	mov r3, r2
	bl SoundTest__Func_215D844
	mov r2, #0
	mov r0, r4
	mov r1, #2
	mov r3, r2
	bl SoundTest__Func_215D844
	mov r0, #1
	str r0, [r4, #0xb64]
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0215D840: .word 0x05000420
	arm_func_end SoundTest__Func_215D6C4

	arm_func_start SoundTest__Func_215D844
SoundTest__Func_215D844: // 0x0215D844
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	ldr r0, [r4, #0x14]
	mov r5, r1
	mov r6, r2
	mov r7, r3
	bl GetBackgroundPixels
	mov r1, #0x12
	mul r2, r6, r1
	mov r6, #0x10
	smulbb r1, r7, r1
	rsb r2, r2, #0xb8
	sub r1, r2, r1, asr #12
	mov r3, r1, lsl #0x10
	str r6, [sp]
	mov r1, #0x28
	str r1, [sp, #4]
	ldr r2, [r4, #0xb68]
	mov r1, #2
	str r2, [sp, #8]
	str r1, [sp, #0xc]
	mov r2, #0
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	add r0, r0, #4
	mov r3, r3, lsr #0x10
	str r2, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	add r0, r4, r5, lsl #2
	mov lr, #0
	ldr r2, [r0, #0xb58]
	ldr r1, [r4, #0xb68]
	mov r0, lr
_0215D8CC:
	ldr r3, _0215DA08 // =_02161912
	mov r5, r0, lsl #1
	ldrh r9, [r3, r5]
	mov ip, #0
	mov r3, ip
	mov r8, ip
	cmp r9, #0
	ble _0215D924
_0215D8EC:
	and r5, lr, #7
	ldr r7, [r1, #0]
	ldr r6, [r1, #0x20]
	cmp r5, #7
	add r5, lr, #1
	add r1, r1, #4
	mov r5, r5, lsl #0x10
	add r8, r8, #1
	addeq r1, r1, #0x20
	orr r3, r3, r7
	orr ip, ip, r6
	cmp r8, r9
	mov lr, r5, lsr #0x10
	blt _0215D8EC
_0215D924:
	cmp r0, #0xc
	rsblt r9, r0, #0xb
	subge r9, r0, #0xc
	mov r8, #0
	mov r6, r8
	orr r5, r9, r9, lsl #4
	mov r7, #4
_0215D940:
	mov r10, r3, lsr r6
	and r10, r10, #0xff
	cmp r10, #0x10
	bhi _0215D970
	bhs _0215D97C
	cmp r10, #1
	bhi _0215D980
	cmp r10, #0
	beq _0215D980
	cmp r10, #1
	addeq r3, r3, r9, lsl r6
	b _0215D980
_0215D970:
	cmp r10, #0x11
	addeq r3, r3, r5, lsl r6
	b _0215D980
_0215D97C:
	add r3, r3, r9, lsl r7
_0215D980:
	mov r10, ip, lsr r6
	and r10, r10, #0xff
	cmp r10, #0x10
	bhi _0215D9B0
	bhs _0215D9BC
	cmp r10, #1
	bhi _0215D9C0
	cmp r10, #0
	beq _0215D9C0
	cmp r10, #1
	addeq ip, ip, r9, lsl r6
	b _0215D9C0
_0215D9B0:
	cmp r10, #0x11
	addeq ip, ip, r5, lsl r6
	b _0215D9C0
_0215D9BC:
	add ip, ip, r9, lsl r7
_0215D9C0:
	add r8, r8, #1
	cmp r8, #4
	add r6, r6, #8
	add r7, r7, #8
	blt _0215D940
	str r3, [r2]
	and r3, r0, #7
	str ip, [r2, #0x20]
	add r2, r2, #4
	cmp r3, #7
	add r0, r0, #1
	addeq r2, r2, #0x20
	cmp r0, #0x18
	blt _0215D8CC
	mov r0, #1
	str r0, [r4, #0xb64]
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0215DA08: .word _02161912
	arm_func_end SoundTest__Func_215D844

	arm_func_start SoundTest__SetTrackNumber
SoundTest__SetTrackNumber: // 0x0215DA0C
	stmdb sp!, {r4, r5, r6, lr}
	add r1, r1, #1
	mov r3, r1, lsl #0x10
	mov r1, r3, lsr #0x10
	ldr r4, _0215DA9C // =0x51EB851F
	mov ip, r1, lsr #0x1f
	smull lr, r1, r4, r1
	add r1, ip, r1, asr #5
	mov r4, #0x64
	mul r4, r1, r4
	rsb r3, r4, r3, lsr #16
	mov r3, r3, lsl #0x10
	mov r6, r3, lsr #0x10
	add r5, r0, #0xb00
	ldr lr, _0215DAA0 // =0x66666667
	mov r4, r6, lsr #0x1f
	smull ip, r6, lr, r6
	add r6, r4, r6, asr #2
	mov r4, #0xa
	strh r1, [r5, #0x6c]
	mul r4, r6, r4
	strh r6, [r5, #0x6e]
	rsb r1, r4, r3, lsr #16
	strh r1, [r5, #0x70]
	cmp r2, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r1, [r5, #0x6c]
	mov r1, r1, lsl #0xc
	str r1, [r0, #0xb74]
	ldrh r1, [r5, #0x6e]
	mov r1, r1, lsl #0xc
	str r1, [r0, #0xb78]
	ldrh r1, [r5, #0x70]
	mov r1, r1, lsl #0xc
	str r1, [r0, #0xb7c]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215DA9C: .word 0x51EB851F
_0215DAA0: .word 0x66666667
	arm_func_end SoundTest__SetTrackNumber

	arm_func_start SoundTest__AnimateTrackNumber
SoundTest__AnimateTrackNumber: // 0x0215DAA4
	stmdb sp!, {r4, r5, r6, lr}
	mov r1, #0
	mov r3, #1
	mov ip, r1
	mov lr, r1
	mov r4, r3
_0215DABC:
	add r2, r0, r1, lsl #1
	add r2, r2, #0xb00
	add r5, r0, r1, lsl #2
	ldrh r2, [r2, #0x6c]
	ldr r5, [r5, #0xb74]
	cmp r5, r2, lsl #12
	mov r6, r2, lsl #0xc
	beq _0215DB40
	subs r2, r5, r6
	rsbmi r2, r2, #0
	cmp r2, #0x400
	addle r2, r0, r1, lsl #2
	strle r6, [r2, #0xb74]
	ble _0215DB40
	cmp r5, r6
	bge _0215DB0C
	cmp r2, #0x5000
	movge r2, r4
	movlt r2, lr
	b _0215DB18
_0215DB0C:
	cmp r2, #0x5000
	movge r2, ip
	movlt r2, r3
_0215DB18:
	cmp r2, #0
	beq _0215DB2C
	subs r5, r5, #0x400
	addmi r5, r5, #0xa000
	b _0215DB38
_0215DB2C:
	add r5, r5, #0x400
	cmp r5, #0xa000
	subge r5, r5, #0xa000
_0215DB38:
	add r2, r0, r1, lsl #2
	str r5, [r2, #0xb74]
_0215DB40:
	add r1, r1, #1
	cmp r1, #3
	blt _0215DABC
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SoundTest__AnimateTrackNumber

	arm_func_start SoundTest__CheckDigitsIdle
SoundTest__CheckDigitsIdle: // 0x0215DB50
	mov r3, #0
_0215DB54:
	add r1, r0, r3, lsl #1
	add r1, r1, #0xb00
	add r2, r0, r3, lsl #2
	ldrh r1, [r1, #0x6c]
	ldr r2, [r2, #0xb74]
	cmp r2, r1, lsl #12
	movne r0, #0
	bxne lr
	add r3, r3, #1
	cmp r3, #3
	blt _0215DB54
	mov r0, #1
	bx lr
	arm_func_end SoundTest__CheckDigitsIdle

	arm_func_start SoundTest__ProcessAnimations
SoundTest__ProcessAnimations: // 0x0215DB88
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	movs r4, r1
	add r6, r5, #0x580
	beq _0215DBC8
	ldr r0, _0215DD9C // =padInput
	ldrh r0, [r0, #0]
	tst r0, #1
	bne _0215DBC0
	add r0, r5, #0x204
	add r0, r0, #0x800
	bl SoundTest__Func_215EB80
	cmp r0, #0
	beq _0215DBC8
_0215DBC0:
	mov r1, #1
	b _0215DBCC
_0215DBC8:
	mov r1, #0
_0215DBCC:
	ldrh r0, [r6, #0xc]
	cmp r0, r1
	beq _0215DBE0
	mov r0, r6
	bl AnimatorSprite__SetAnimation
_0215DBE0:
	add r0, r5, #0x1e4
	cmp r4, #0
	add r6, r0, #0x400
	beq _0215DC2C
	mov r0, r5
	bl SoundTest__IsPlayingTrack
	cmp r0, #0
	beq _0215DC10
	ldr r0, _0215DD9C // =padInput
	ldrh r0, [r0, #0]
	tst r0, #2
	bne _0215DC24
_0215DC10:
	add r0, r5, #0x23c
	add r0, r0, #0x800
	bl SoundTest__Func_215EB80
	cmp r0, #0
	beq _0215DC2C
_0215DC24:
	mov r1, #3
	b _0215DC30
_0215DC2C:
	mov r1, #2
_0215DC30:
	ldrh r0, [r6, #0xc]
	cmp r0, r1
	beq _0215DC44
	mov r0, r6
	bl AnimatorSprite__SetAnimation
_0215DC44:
	add r0, r5, #0x248
	cmp r4, #0
	add r6, r0, #0x400
	beq _0215DC80
	ldr r0, _0215DD9C // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x10
	bne _0215DC78
	add r0, r5, #0x274
	add r0, r0, #0x800
	bl SoundTest__Func_215EB80
	cmp r0, #0
	beq _0215DC80
_0215DC78:
	mov r1, #5
	b _0215DC84
_0215DC80:
	mov r1, #4
_0215DC84:
	ldrh r0, [r6, #0xc]
	cmp r0, r1
	beq _0215DC98
	mov r0, r6
	bl AnimatorSprite__SetAnimation
_0215DC98:
	add r0, r5, #0x2ac
	cmp r4, #0
	add r6, r0, #0x400
	beq _0215DCD0
	ldr r1, _0215DD9C // =padInput
	ldrh r1, [r1, #0]
	tst r1, #0x20
	bne _0215DCC8
	add r0, r0, #0x800
	bl SoundTest__Func_215EB80
	cmp r0, #0
	beq _0215DCD0
_0215DCC8:
	mov r1, #7
	b _0215DCD4
_0215DCD0:
	mov r1, #6
_0215DCD4:
	ldrh r0, [r6, #0xc]
	cmp r0, r1
	beq _0215DCE8
	mov r0, r6
	bl AnimatorSprite__SetAnimation
_0215DCE8:
	add r0, r5, #0x168
	cmp r4, #0
	add r4, r0, #0x800
	beq _0215DD10
	add r0, r5, #0x2e4
	add r0, r0, #0x800
	bl SoundTest__Func_215EB80
	cmp r0, #0
	movne r1, #9
	bne _0215DD14
_0215DD10:
	mov r1, #8
_0215DD14:
	ldrh r0, [r4, #0xc]
	cmp r0, r1
	beq _0215DD28
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_0215DD28:
	add r1, r5, #0x104
	mov r0, r5
	add r4, r1, #0x800
	bl SoundTest__IsPlayingTrack
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	mov r0, r0, lsl #0x10
	ldrh r2, [r4, #0xc]
	mov r1, r0, lsr #0x10
	cmp r2, r0, lsr #16
	beq _0215DD60
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_0215DD60:
	add r0, r5, #0x11c
	mov r6, #0
	add r7, r0, #0x400
	mov r4, r6
_0215DD70:
	mov r0, r7
	mov r1, r4
	mov r2, r4
	bl AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	cmp r6, #0xc
	add r7, r7, #0x64
	blt _0215DD70
	mov r0, r5
	bl SoundTest__AnimateTrackNumber
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215DD9C: .word padInput
	arm_func_end SoundTest__ProcessAnimations

	arm_func_start SoundTest__Draw
SoundTest__Draw: // 0x0215DDA0
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	add r0, r5, #0x11c
	add r0, r0, #0x400
	bl AnimatorSprite__DrawFrame
	ldr r6, _0215DED4 // =0x00000FFF
	mov r4, #0
_0215DDBC:
	add r0, r5, r4, lsl #2
	ldr r2, [r0, #0xb74]
	mov r1, r4, lsl #0x10
	and r0, r2, r6
	mov r2, r2, lsl #4
	mov r3, r0, lsl #0x10
	mov r0, r5
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
	mov r3, r3, asr #0x10
	bl SoundTest__Func_215D844
	add r4, r4, #1
	cmp r4, #3
	blt _0215DDBC
	ldr r0, [r5, #0xb64]
	cmp r0, #0
	beq _0215DE20
	ldr r0, [r5, #0xb58]
	mov r1, #0x240
	bl DC_StoreRange
	ldr r0, [r5, #0xb58]
	ldr r3, _0215DED8 // =0x06208020
	mov r1, #0x240
	mov r2, #0
	bl QueueUncompressedPixels
_0215DE20:
	mov r0, r5
	bl SoundTest__ProcessPendulumAngle
	mov r0, r5
	bl SoundTest__GetPendulumAngle
	ldr r1, _0215DEDC // =0x000016C1
	mul r1, r0, r1
	mov r1, r1, asr #0xc
	add r0, r5, #0x580
	str r1, [r5, #0xb54]
	bl AnimatorSprite__DrawFrame
	add r0, r5, #0x1e4
	add r0, r0, #0x400
	bl AnimatorSprite__DrawFrame
	add r0, r5, #0x248
	add r0, r0, #0x400
	bl AnimatorSprite__DrawFrame
	add r0, r5, #0x2ac
	add r0, r0, #0x400
	bl AnimatorSprite__DrawFrame
	add r0, r5, #0x710
	bl AnimatorSprite__DrawFrame
	add r0, r5, #0x374
	add r0, r0, #0x400
	bl AnimatorSprite__DrawFrame
	add r0, r5, #0x3d8
	add r0, r0, #0x400
	bl AnimatorSprite__DrawFrame
	add r0, r5, #0x3c
	add r0, r0, #0x800
	bl AnimatorSprite__DrawFrame
	add r0, r5, #0x8a0
	mov r1, #0x1000
	mov r2, r1
	ldr r3, [r5, #0xb54]
	sub r3, r3, #0xb60
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	bl AnimatorSprite__DrawFrameRotoZoom
	add r0, r5, #0x104
	add r0, r0, #0x800
	bl AnimatorSprite__DrawFrame
	add r0, r5, #0x168
	add r0, r0, #0x800
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215DED4: .word 0x00000FFF
_0215DED8: .word 0x06208020
_0215DEDC: .word 0x000016C1
	arm_func_end SoundTest__Draw

	arm_func_start SoundTest__SetTrackInfo
SoundTest__SetTrackInfo: // 0x0215DEE0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r1, [r5, #2]
	ldr r0, [r5, #0x44]
	bl SoundTest__GetSongInfoName
	mov r4, r0
	ldrh r1, [r5, #2]
	ldr r0, [r5, #0x44]
	bl SoundTest__GetSongInfoLength
	add r1, r5, #0x31c
	mov r3, r0
	mov r0, #3
	str r0, [sp]
	mov r0, r5
	add r1, r1, #0x800
	mov r2, r4
	bl SoundTest__SetTrackName
	add r0, r5, #0x31c
	add r0, r0, #0x800
	bl Unknown2056570__Func_2056B8C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SoundTest__SetTrackInfo

	arm_func_start SoundTest__InitTouchAreas
SoundTest__InitTouchAreas: // 0x0215DF34
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	add r0, r4, #0x204
	mov r7, r1
	add r6, r0, #0x800
	mov r5, #0
_0215DF4C:
	mov r0, r6
	bl TouchField__ResetArea
	add r5, r5, #1
	cmp r5, #5
	add r6, r6, #0x38
	blt _0215DF4C
	cmp r7, #0
	mov r1, #0
	beq _0215DF90
_0215DF70:
	ldr r0, [r4, #0xa18]
	add r1, r1, #1
	orr r0, r0, #0x40
	str r0, [r4, #0xa18]
	cmp r1, #5
	add r4, r4, #0x38
	blt _0215DF70
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215DF90:
	ldr r0, [r4, #0xa18]
	add r1, r1, #1
	bic r0, r0, #0x40
	str r0, [r4, #0xa18]
	cmp r1, #5
	add r4, r4, #0x38
	blt _0215DF90
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SoundTest__InitTouchAreas

	arm_func_start SoundTest__ProcessInputLock
SoundTest__ProcessInputLock: // 0x0215DFB0
	stmdb sp!, {r4, lr}
	ldr r1, _0215E04C // =padInput
	mov r4, r0
	ldrh r0, [r1, #0]
	tst r0, #0x10
	bne _0215DFDC
	add r0, r4, #0x274
	add r0, r0, #0x800
	bl SoundTest__Func_215EB80
	cmp r0, #0
	beq _0215DFF4
_0215DFDC:
	add r0, r4, #0xb00
	ldrh r1, [r0, #0x50]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x50]
	b _0215E000
_0215DFF4:
	add r0, r4, #0xb00
	mov r1, #0x18
	strh r1, [r0, #0x50]
_0215E000:
	ldr r0, _0215E04C // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x20
	bne _0215E024
	add r0, r4, #0x2ac
	add r0, r0, #0x800
	bl SoundTest__Func_215EB80
	cmp r0, #0
	beq _0215E03C
_0215E024:
	add r0, r4, #0xb00
	ldrh r1, [r0, #0x52]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x52]
	ldmia sp!, {r4, pc}
_0215E03C:
	add r0, r4, #0xb00
	mov r1, #0x18
	strh r1, [r0, #0x52]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E04C: .word padInput
	arm_func_end SoundTest__ProcessInputLock

	arm_func_start SoundTest__CheckRightBtnDown
SoundTest__CheckRightBtnDown: // 0x0215E050
	stmdb sp!, {r4, lr}
	ldr r1, _0215E09C // =padInput
	mov r4, r0
	ldrh r0, [r1, #4]
	tst r0, #0x10
	movne r0, #1
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x274
	add r0, r0, #0x800
	bl SoundTest__CheckTouchAreaHold
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r4, pc}
	add r0, r4, #0xb00
	ldrh r0, [r0, #0x50]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E09C: .word padInput
	arm_func_end SoundTest__CheckRightBtnDown

	arm_func_start SoundTest__CheckLeftBtnDown
SoundTest__CheckLeftBtnDown: // 0x0215E0A0
	stmdb sp!, {r4, lr}
	ldr r1, _0215E0EC // =padInput
	mov r4, r0
	ldrh r0, [r1, #4]
	tst r0, #0x20
	movne r0, #1
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x2ac
	add r0, r0, #0x800
	bl SoundTest__CheckTouchAreaHold
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r4, pc}
	add r0, r4, #0xb00
	ldrh r0, [r0, #0x52]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E0EC: .word padInput
	arm_func_end SoundTest__CheckLeftBtnDown

	arm_func_start SoundTest__State_FadeIn
SoundTest__State_FadeIn: // 0x0215E0F0
	stmdb sp!, {r4, lr}
	ldr r1, _0215E144 // =renderCoreGFXControlA
	mov r4, r0
	ldrsh r2, [r1, #0x58]
	cmp r2, #0
	subgt r0, r2, #1
	strgth r0, [r1, #0x58]
	bgt _0215E12C
	addlt r0, r2, #1
	strlth r0, [r1, #0x58]
	blt _0215E12C
	mov r1, #0
	bl SoundTest__InitTouchAreas
	ldr r0, _0215E148 // =SoundTest__State_TrackStopped
	str r0, [r4, #0xb80]
_0215E12C:
	mov r0, r4
	mov r1, #0
	bl SoundTest__ProcessAnimations
	mov r0, r4
	bl SoundTest__Draw
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E144: .word renderCoreGFXControlA
_0215E148: .word SoundTest__State_TrackStopped
	arm_func_end SoundTest__State_FadeIn

	arm_func_start SoundTest__State_FadeOut
SoundTest__State_FadeOut: // 0x0215E14C
	stmdb sp!, {r4, lr}
	ldr r2, _0215E194 // =renderCoreGFXControlA
	mvn r1, #0xf
	ldrsh r3, [r2, #0x58]
	mov r4, r0
	cmp r3, r1
	subgt r1, r3, #1
	strgth r1, [r2, #0x58]
	bgt _0215E180
	bl SoundTest__DisableDraw3D
	mov r0, #0
	str r0, [r4, #0xb80]
	ldmia sp!, {r4, pc}
_0215E180:
	mov r1, #0
	bl SoundTest__ProcessAnimations
	mov r0, r4
	bl SoundTest__Draw
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E194: .word renderCoreGFXControlA
	arm_func_end SoundTest__State_FadeOut

	arm_func_start SoundTest__State_TrackStopped
SoundTest__State_TrackStopped: // 0x0215E198
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	add r0, r7, #0x1ec
	mov r4, #0
	add r0, r0, #0x800
	mov r5, r4
	mov r6, r4
	bl TouchField__Process
	mov r0, r7
	bl SoundTest__ProcessInputLock
	ldr r0, _0215E324 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #2
	bne _0215E1E4
	add r0, r7, #0x2e4
	add r0, r0, #0x800
	bl SoundTest__CheckTouchAreaPress
	cmp r0, #0
	beq _0215E1EC
_0215E1E4:
	mov r4, #1
	b _0215E284
_0215E1EC:
	ldr r0, _0215E324 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	bne _0215E210
	add r0, r7, #0x204
	add r0, r0, #0x800
	bl SoundTest__CheckTouchAreaPress
	cmp r0, #0
	beq _0215E218
_0215E210:
	mov r5, #1
	b _0215E284
_0215E218:
	mov r0, r7
	bl SoundTest__CheckDigitsIdle
	cmp r0, #0
	beq _0215E250
	mov r0, r7
	bl SoundTest__CheckRightBtnDown
	cmp r0, #0
	beq _0215E250
	ldrh r1, [r7, #2]
	mov r0, r7
	bl SoundTest__MoveSelectionRight
	strh r0, [r7, #2]
	mov r6, #1
	b _0215E284
_0215E250:
	mov r0, r7
	bl SoundTest__CheckDigitsIdle
	cmp r0, #0
	beq _0215E284
	mov r0, r7
	bl SoundTest__CheckLeftBtnDown
	cmp r0, #0
	beq _0215E284
	ldrh r1, [r7, #2]
	mov r0, r7
	bl SoundTest__MoveSelectionLeft
	strh r0, [r7, #2]
	mov r6, #1
_0215E284:
	mov r2, #0
	mov r0, r7
	mov r1, #1
	str r2, [r7, #0xf8]
	bl SoundTest__ProcessAnimations
	mov r0, r7
	bl SoundTest__Draw
	cmp r4, #0
	beq _0215E2C0
	mov r0, r7
	mov r1, #0
	bl SoundTest__InitTouchAreas
	ldr r0, _0215E328 // =SoundTest__State_FadeOut
	str r0, [r7, #0xb80]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215E2C0:
	cmp r5, #0
	beq _0215E300
	add r0, r7, #0x1cc
	add r0, r0, #0x800
	mov r1, #0
	bl SetPaletteAnimation
	mov r0, r7
	mov r1, #0
	bl SoundTest__SetKoalaAnim
	ldrh r1, [r7, #2]
	mov r0, r7
	bl SoundTest__PlaySong
	bl SoundTest__DisableSleepOnFold
	ldr r0, _0215E32C // =SoundTest__State_TrackPlaying
	str r0, [r7, #0xb80]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215E300:
	cmp r6, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldrh r1, [r7, #2]
	mov r0, r7
	mov r2, #0
	bl SoundTest__SetTrackNumber
	mov r0, r7
	bl SoundTest__SetTrackInfo
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215E324: .word padInput
_0215E328: .word SoundTest__State_FadeOut
_0215E32C: .word SoundTest__State_TrackPlaying
	arm_func_end SoundTest__State_TrackStopped

	arm_func_start SoundTest__State_TrackPlaying
SoundTest__State_TrackPlaying: // 0x0215E330
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	add r0, r8, #0x1ec
	mov r4, #0
	add r0, r0, #0x800
	mov r5, r4
	mov r6, r4
	mov r7, r4
	bl TouchField__Process
	mov r0, r8
	bl SoundTest__ProcessInputLock
	add r0, r8, #0x2e4
	add r0, r0, #0x800
	bl SoundTest__CheckTouchAreaPress
	cmp r0, #0
	movne r4, #1
	bne _0215E448
	ldr r0, _0215E578 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	bne _0215E398
	add r0, r8, #0x204
	add r0, r0, #0x800
	bl SoundTest__CheckTouchAreaPress
	cmp r0, #0
	beq _0215E3A0
_0215E398:
	mov r5, #1
	b _0215E448
_0215E3A0:
	ldr r0, _0215E578 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #2
	bne _0215E3D4
	add r0, r8, #0x23c
	add r0, r0, #0x800
	bl SoundTest__CheckTouchAreaPress
	cmp r0, #0
	bne _0215E3D4
	mov r0, r8
	bl SoundTest__IsPlayingTrack
	cmp r0, #0
	bne _0215E3DC
_0215E3D4:
	mov r6, #1
	b _0215E448
_0215E3DC:
	mov r0, r8
	bl SoundTest__CheckDigitsIdle
	cmp r0, #0
	beq _0215E414
	mov r0, r8
	bl SoundTest__CheckRightBtnDown
	cmp r0, #0
	beq _0215E414
	ldrh r1, [r8, #2]
	mov r0, r8
	bl SoundTest__MoveSelectionRight
	strh r0, [r8, #2]
	mov r7, #1
	b _0215E448
_0215E414:
	mov r0, r8
	bl SoundTest__CheckDigitsIdle
	cmp r0, #0
	beq _0215E448
	mov r0, r8
	bl SoundTest__CheckLeftBtnDown
	cmp r0, #0
	beq _0215E448
	ldrh r1, [r8, #2]
	mov r0, r8
	bl SoundTest__MoveSelectionLeft
	strh r0, [r8, #2]
	mov r7, #1
_0215E448:
	mov r0, r8
	mov r1, #1
	bl SoundTest__ProcessAnimations
	mov r0, r8
	bl SoundTest__Draw
	cmp r6, #0
	bne _0215E47C
	add r0, r8, #0x1cc
	add r0, r0, #0x800
	bl AnimatePalette
	add r0, r8, #0x1cc
	add r0, r0, #0x800
	bl DrawAnimatedPalette
_0215E47C:
	cmp r4, #0
	beq _0215E4AC
	mov r0, r8
	mov r1, #0
	bl SoundTest__InitTouchAreas
	mov r0, r8
	mov r1, #0
	bl SoundTest__ReleaseSoundPlayers
	bl SoundTest__EnableSleepOnFold
	ldr r0, _0215E57C // =SoundTest__State_FadeOut
	str r0, [r8, #0xb80]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0215E4AC:
	cmp r5, #0
	beq _0215E4C4
	ldrh r1, [r8, #2]
	mov r0, r8
	bl SoundTest__PlaySong
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0215E4C4:
	cmp r6, #0
	beq _0215E508
	ldr r0, [r8, #0x18]
	bl GetBackgroundPalette
	ldr r2, _0215E580 // =0x05000440
	mov r1, #0
	bl LoadCompressedPalette
	mov r0, r8
	mov r1, #1
	bl SoundTest__SetKoalaAnim
	mov r0, r8
	mov r1, #0
	bl SoundTest__ReleaseSoundPlayers
	bl SoundTest__EnableSleepOnFold
	ldr r0, _0215E584 // =SoundTest__State_TrackStopped
	str r0, [r8, #0xb80]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0215E508:
	mov r0, r8
	bl SoundTest__CheckTrackStopped
	cmp r0, #0
	beq _0215E554
	ldr r0, [r8, #0x18]
	bl GetBackgroundPalette
	ldr r2, _0215E580 // =0x05000440
	mov r1, #0
	bl LoadCompressedPalette
	mov r0, r8
	mov r1, #1
	bl SoundTest__SetKoalaAnim
	mov r0, r8
	mov r1, #1
	bl SoundTest__ReleaseSoundPlayers
	bl SoundTest__EnableSleepOnFold
	ldr r0, _0215E584 // =SoundTest__State_TrackStopped
	str r0, [r8, #0xb80]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0215E554:
	cmp r7, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r1, [r8, #2]
	mov r0, r8
	mov r2, #0
	bl SoundTest__SetTrackNumber
	mov r0, r8
	bl SoundTest__SetTrackInfo
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215E578: .word padInput
_0215E57C: .word SoundTest__State_FadeOut
_0215E580: .word 0x05000440
_0215E584: .word SoundTest__State_TrackStopped
	arm_func_end SoundTest__State_TrackPlaying

	arm_func_start SoundTest__InitAudio
SoundTest__InitAudio: // 0x0215E588
	stmdb sp!, {r4, lr}
	ldr r1, _0215E5E8 // =0x0000FFFF
	mov r4, r0
	strh r1, [r4, #0xd8]
	strh r1, [r4, #0xda]
	strh r1, [r4, #0xdc]
	mov r0, #0
	str r0, [r4, #0xe0]
	str r0, [r4, #0xe4]
	str r0, [r4, #0xec]
	mov r0, #0x80
	bl _AllocHeadHEAP_SYSTEM
	str r0, [r4, #0xf0]
	mov r0, #0
	str r0, [r4, #0xf4]
	str r0, [r4, #0xf8]
	add r1, r4, #0x100
	mov r2, #0x10
	str r0, [r4, #0xfc]
	bl MIi_CpuClear32
	bl ReleaseAudioSystem
	add r0, r4, #0xe8
	bl NNS_SndStrmHandleInit
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E5E8: .word 0x0000FFFF
	arm_func_end SoundTest__InitAudio

	arm_func_start SoundTest__ReleaseAudio
SoundTest__ReleaseAudio: // 0x0215E5EC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	bl SoundTest__ReleaseSoundPlayers
	ldr r0, [r4, #0xf0]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r4, #0xf0]
	ldmia sp!, {r4, pc}
	arm_func_end SoundTest__ReleaseAudio

	arm_func_start SoundTest__PlaySong
SoundTest__PlaySong: // 0x0215E618
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x2c
	mov r9, r0
	ldr r4, [r9, #0x44]
	mov r8, r1
	mov r0, r4
	bl SoundTest__GetSongSndArcID
	mov r5, r0
	mov r0, r4
	mov r1, r8
	bl SoundTest__GetSongGroupID
	mov r6, r0
	mov r0, r4
	mov r1, r8
	bl SoundTest__GetSongSeqArcNo
	mov r10, r0
	mov r0, r4
	mov r1, r8
	bl SoundTest__GetSongSeqID
	mov r7, r0
	ldrh r0, [r9, #0xda]
	cmp r5, r0
	ldreqh r0, [r9, #0xdc]
	cmpeq r6, r0
	beq _0215E6F0
	mov r0, r9
	mov r1, #0
	bl SoundTest__ReleaseSoundPlayers
	ldr r1, _0215E820 // =_02162D28
	add r0, sp, #0xc
	ldr r1, [r1, r5, lsl #2]
	bl STD_CopyString
	ldr r1, _0215E824 // =aSoundDataSdat
	add r0, sp, #0xc
	bl STD_ConcatenateString
	mov r0, r4
	mov r1, r8
	bl SoundTest__GetSongIsStageArc
	cmp r0, #0
	add r0, sp, #0xc
	bne _0215E6D4
	bl LoadAudioSndArc
	ldr r1, _0215E828 // =audioManagerSndHeap
	mov r0, r6
	ldr r1, [r1, #0]
	bl NNS_SndArcLoadGroup
	b _0215E6E4
_0215E6D4:
	mov r1, #0
	bl FSRequestFileSync
	str r0, [r9, #0xe4]
	bl InitAudioSystemForStage
_0215E6E4:
	strh r5, [r9, #0xda]
	strh r6, [r9, #0xdc]
	b _0215E6F8
_0215E6F0:
	bl NNS_SndCaptureStopSampling
	bl NNS_SndStopSoundAll
_0215E6F8:
	mov r0, r4
	mov r1, r8
	bl SoundTest__GetSongType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0215E79C
_0215E710: // jump table
	b _0215E720 // case 0
	b _0215E73C // case 1
	b _0215E75C // case 2
	b _0215E77C // case 3
_0215E720:
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	str r7, [sp]
	bl PlayTrack
	b _0215E79C
_0215E73C:
	mov r0, #0
	sub r1, r0, #1
	str r10, [sp]
	mov r2, r1
	mov r3, r1
	str r7, [sp, #4]
	bl PlaySfxEx
	b _0215E79C
_0215E75C:
	mov r0, #0
	sub r1, r0, #1
	str r10, [sp]
	mov r2, r1
	mov r3, r1
	str r7, [sp, #4]
	bl PlayVoiceClipEx
	b _0215E79C
_0215E77C:
	ldr r1, _0215E828 // =audioManagerSndHeap
	mov r0, #0xa
	ldr r1, [r1, #0]
	bl NNS_SndArcStrmInit
	mov r1, r7
	add r0, r9, #0xe8
	mov r2, #0
	bl NNS_SndArcStrmStart
_0215E79C:
	mov r1, #2
	str r1, [sp]
	ldr r0, _0215E82C // =SoundTest__CaptureCallback
	mov r1, #0x80
	stmib sp, {r0, r9}
	ldr r0, [r9, #0xf0]
	mov r2, #1
	mov r3, #0x1f40
	bl NNS_SndCaptureStartSampling
	ldrh r0, [r9, #0xd8]
	cmp r8, r0
	beq _0215E80C
	mov r0, r4
	mov r1, r8
	bl SoundTest__GetSongInfoName
	mov r5, r0
	mov r0, r4
	mov r1, r8
	bl SoundTest__GetSongInfoLength
	mov r3, r0
	mov r1, #1
	mov r0, r9
	str r1, [sp]
	mov r2, r5
	add r1, r9, #0x4e0
	bl SoundTest__SetTrackName
	add r0, r9, #0x4e0
	bl Unknown2056570__Func_2056B8C
_0215E80C:
	strh r8, [r9, #0xd8]
	mov r0, #1
	str r0, [r9, #0xe0]
	add sp, sp, #0x2c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0215E820: .word _02162D28
_0215E824: .word aSoundDataSdat
_0215E828: .word audioManagerSndHeap
_0215E82C: .word SoundTest__CaptureCallback
	arm_func_end SoundTest__PlaySong

	arm_func_start SoundTest__IsPlayingTrack
SoundTest__IsPlayingTrack: // 0x0215E830
	ldr r0, [r0, #0xe0]
	bx lr
	arm_func_end SoundTest__IsPlayingTrack

	arm_func_start SoundTest__ReleaseSoundPlayers
SoundTest__ReleaseSoundPlayers: // 0x0215E838
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0
	mov r4, r1
	str r0, [r5, #0xe0]
	bl NNS_SndCaptureStopSampling
	cmp r4, #0
	ldmneia sp!, {r3, r4, r5, pc}
	bl NNS_SndStopSoundAll
	ldr r0, [r5, #0xe8]
	cmp r0, #0
	beq _0215E87C
	add r0, r5, #0xe8
	mov r1, #0
	bl NNS_SndArcStrmStop
	add r0, r5, #0xe8
	bl NNS_SndStrmHandleRelease
_0215E87C:
	bl ReleaseAudioSystem
	ldr r0, [r5, #0xe4]
	cmp r0, #0
	beq _0215E898
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r5, #0xe4]
_0215E898:
	ldr r1, _0215E8C0 // =0x0000FFFF
	mov r0, #0
	strh r1, [r5, #0xda]
	strh r1, [r5, #0xdc]
	str r0, [r5, #0xf4]
	add r1, r5, #0x100
	mov r2, #0x10
	str r0, [r5, #0xf8]
	bl MIi_CpuClear32
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215E8C0: .word 0x0000FFFF
	arm_func_end SoundTest__ReleaseSoundPlayers

	arm_func_start SoundTest__CheckTrackStopped
SoundTest__CheckTrackStopped: // 0x0215E8C4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrh r4, [r6, #0xd8]
	ldr r0, [r6, #0x44]
	bl SoundTest__GetSongCount
	cmp r4, r0
	movhs r0, #1
	ldmhsia sp!, {r4, r5, r6, pc}
	ldr r0, [r6, #0x44]
	mov r1, r4
	bl SoundTest__GetSongType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0215E964
_0215E8FC: // jump table
	b _0215E90C // case 0
	b _0215E924 // case 1
	b _0215E93C // case 2
	b _0215E954 // case 3
_0215E90C:
	ldr r0, _0215E974 // =defaultTrackPlayer
	ldr r0, [r0, #0]
	cmp r0, #0
	movne r5, #1
	moveq r5, #0
	b _0215E964
_0215E924:
	ldr r0, _0215E978 // =defaultSfxPlayer
	ldr r0, [r0, #0]
	cmp r0, #0
	movne r5, #1
	moveq r5, #0
	b _0215E964
_0215E93C:
	ldr r0, _0215E97C // =defaultVoicePlayer
	ldr r0, [r0, #0]
	cmp r0, #0
	movne r5, #1
	moveq r5, #0
	b _0215E964
_0215E954:
	ldr r0, [r6, #0xe8]
	cmp r0, #0
	movne r5, #1
	moveq r5, #0
_0215E964:
	cmp r5, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215E974: .word defaultTrackPlayer
_0215E978: .word defaultSfxPlayer
_0215E97C: .word defaultVoicePlayer
	arm_func_end SoundTest__CheckTrackStopped

	arm_func_start SoundTest__CaptureCallback
SoundTest__CaptureCallback: // 0x0215E980
	stmdb sp!, {r3, r4, r5, lr}
	mov ip, #0
	mov lr, ip
	cmp r2, #0
	ldr r3, [sp, #0x10]
	bls _0215E9C4
_0215E998:
	ldrsb r4, [r0, lr]
	ldrsb r5, [r1, lr]
	add lr, lr, #1
	cmp r4, #0
	rsblt r4, r4, #0
	cmp r5, #0
	rsblt r5, r5, #0
	add ip, ip, r4
	cmp lr, r2
	add ip, ip, r5
	blo _0215E998
_0215E9C4:
	ldr r0, [r3, #0x108]
	mov r1, #0
	str r0, [r3, #0x10c]
	ldr r0, [r3, #0x104]
	str r0, [r3, #0x108]
	ldr r0, [r3, #0x100]
	str r0, [r3, #0x104]
	str ip, [r3, #0x100]
_0215E9E4:
	add r0, r3, r1, lsl #2
	ldr r0, [r0, #0x100]
	cmp r0, #0
	moveq ip, #0
	beq _0215EA04
	add r1, r1, #1
	cmp r1, #4
	blt _0215E9E4
_0215EA04:
	str ip, [r3, #0xf8]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SoundTest__CaptureCallback

	arm_func_start SoundTest__ProcessPendulumAngle
SoundTest__ProcessPendulumAngle: // 0x0215EA0C
	ldr r3, [r0, #0xfc]
	ldr r2, [r0, #0xf8]
	cmp r2, r3
	ble _0215EA34
	sub r1, r2, r3
	cmp r1, #0x100
	strlt r2, [r0, #0xfc]
	addge r1, r3, #0x100
	strge r1, [r0, #0xfc]
	bx lr
_0215EA34:
	sub r1, r3, r2
	cmp r1, #0x20
	strlt r2, [r0, #0xfc]
	subge r1, r3, #0x20
	strge r1, [r0, #0xfc]
	bx lr
	arm_func_end SoundTest__ProcessPendulumAngle

	arm_func_start SoundTest__GetPendulumAngle
SoundTest__GetPendulumAngle: // 0x0215EA4C
	stmdb sp!, {r3, lr}
	ldr r0, [r0, #0xfc]
	mov r1, #0x1000
	mov r0, r0, lsl #0xc
	bl FX_DivS32
	cmp r0, #0x1000
	movgt r0, #0x1000
	ldmia sp!, {r3, pc}
	arm_func_end SoundTest__GetPendulumAngle

	arm_func_start SoundTest__SetTrackName
SoundTest__SetTrackName: // 0x0215EA6C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x1c
	mov r4, r1
	mov r5, r0
	mov r7, r3
	mov r0, r4
	mov r8, r2
	bl Unknown2056570__Func_205683C
	cmp r7, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	add r0, r7, #1
	bl _AllocHeadHEAP_DTCM
	mov r6, r0
	mov r0, r8
	mov r1, r6
	mov r2, r7
	bl MI_CpuCopy8
	mov r1, #0
	ldrsh r0, [sp, #0x38]
	strb r1, [r6, r7]
	mov r2, #0x60
	str r2, [sp]
	stmib sp, {r0, r1}
	str r1, [sp, #0xc]
	mov r0, #8
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r2, r1
	mov r3, r4
	add r0, r5, #0x4c
	str r6, [sp, #0x18]
	bl FontFile__Func_2053010
	mov r0, r6
	bl _FreeHEAP_DTCM
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	arm_func_end SoundTest__SetTrackName

	arm_func_start SoundTest__SetAnimation2D
SoundTest__SetAnimation2D: // 0x0215EB00
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x1c
	mov r7, r1
	mov r6, r2
	mov r4, r0
	mov r0, r7
	mov r1, r6
	mov r5, r3
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r1, r7
	mov r2, r6
	mov r3, #1
	str r3, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr ip, _0215EB7C // =0x05000600
	ldrb r0, [sp, #0x30]
	str ip, [sp, #0x10]
	str r5, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r4
	bl AnimatorSprite__Init
	ldrh r0, [sp, #0x34]
	strh r0, [r4, #0x50]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215EB7C: .word 0x05000600
	arm_func_end SoundTest__SetAnimation2D

	arm_func_start SoundTest__Func_215EB80
SoundTest__Func_215EB80: // 0x0215EB80
	ldr r0, [r0, #0x14]
	tst r0, #0x800
	bne _0215EB98
	tst r0, #0x10
	movne r0, #1
	bxne lr
_0215EB98:
	mov r0, #0
	bx lr
	arm_func_end SoundTest__Func_215EB80

	arm_func_start SoundTest__CheckTouchAreaPress
SoundTest__CheckTouchAreaPress: // 0x0215EBA0
	ldr r0, [r0, #0x14]
	tst r0, #0x40000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end SoundTest__CheckTouchAreaPress

	arm_func_start SoundTest__CheckTouchAreaHold
SoundTest__CheckTouchAreaHold: // 0x0215EBB4
	ldr r0, [r0, #0x14]
	tst r0, #0x400000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end SoundTest__CheckTouchAreaHold

	arm_func_start SoundTest__MoveSelectionRight
SoundTest__MoveSelectionRight: // 0x0215EBC8
	stmdb sp!, {r3, lr}
	ldrh r2, [r0, #0]
	ldr lr, [r0, #0x48]
	mov r3, r1
	sub ip, r2, #1
	mov r2, #0
_0215EBE0:
	cmp r1, ip
	movge r1, r2
	bge _0215EBF8
	add r0, r1, #1
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
_0215EBF8:
	ldr r0, [lr, r1, lsl #2]
	cmp r0, #0
	bne _0215EC0C
	cmp r1, r3
	bne _0215EBE0
_0215EC0C:
	mov r0, r1
	ldmia sp!, {r3, pc}
	arm_func_end SoundTest__MoveSelectionRight

	arm_func_start SoundTest__MoveSelectionLeft
SoundTest__MoveSelectionLeft: // 0x0215EC14
	ldr ip, [r0, #0x48]
	mov r3, r1
_0215EC1C:
	cmp r1, #0
	ldreqh r1, [r0, #0]
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	ldr r2, [ip, r1, lsl #2]
	cmp r2, #0
	bne _0215EC44
	cmp r1, r3
	bne _0215EC1C
_0215EC44:
	mov r0, r1
	bx lr
	arm_func_end SoundTest__MoveSelectionLeft

	arm_func_start SoundTest__DisableSleepOnFold
SoundTest__DisableSleepOnFold: // 0x0215EC4C
	ldr ip, _0215EC58 // =RenderCore_SetNextFoldMode
	mov r0, #1
	bx ip
	.align 2, 0
_0215EC58: .word RenderCore_SetNextFoldMode
	arm_func_end SoundTest__DisableSleepOnFold

	arm_func_start SoundTest__EnableSleepOnFold
SoundTest__EnableSleepOnFold: // 0x0215EC5C
	ldr ip, _0215EC68 // =RenderCore_SetNextFoldMode
	mov r0, #0
	bx ip
	.align 2, 0
_0215EC68: .word RenderCore_SetNextFoldMode
	arm_func_end SoundTest__EnableSleepOnFold

	arm_func_start SoundTest__CheckSongUnlocked
SoundTest__CheckSongUnlocked: // 0x0215EC6C
	stmdb sp!, {r3, lr}
	cmp r0, #0xff
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	cmp r0, #0x80
	bne _0215EC98
	bl SaveGame__GetGameProgress
	cmp r0, #0x27
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
_0215EC98:
	bl SaveGame__GetMissionStatus
	cmp r0, #3
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end SoundTest__CheckSongUnlocked

	arm_func_start SoundTest__GetSongCount
SoundTest__GetSongCount: // 0x0215ECAC
	ldrh r0, [r0, #0]
	bx lr
	arm_func_end SoundTest__GetSongCount

	arm_func_start SoundTest__GetSongSndArcID
SoundTest__GetSongSndArcID: // 0x0215ECB4
	stmdb sp!, {r3, lr}
	bl SoundTest__GetSongInfo
	ldrb r0, [r0, #1]
	ldmia sp!, {r3, pc}
	arm_func_end SoundTest__GetSongSndArcID

	arm_func_start SoundTest__GetSongIsStageArc
SoundTest__GetSongIsStageArc: // 0x0215ECC4
	stmdb sp!, {r3, lr}
	bl SoundTest__GetSongInfo
	ldrb r0, [r0, #2]
	ldmia sp!, {r3, pc}
	arm_func_end SoundTest__GetSongIsStageArc

	arm_func_start SoundTest__GetSongType
SoundTest__GetSongType: // 0x0215ECD4
	stmdb sp!, {r3, lr}
	bl SoundTest__GetSongInfo
	ldrb r0, [r0, #3]
	ldmia sp!, {r3, pc}
	arm_func_end SoundTest__GetSongType

	arm_func_start SoundTest__GetSongGroupID
SoundTest__GetSongGroupID: // 0x0215ECE4
	stmdb sp!, {r3, lr}
	bl SoundTest__GetSongInfo
	ldrh r0, [r0, #4]
	ldmia sp!, {r3, pc}
	arm_func_end SoundTest__GetSongGroupID

	arm_func_start SoundTest__GetSongSeqArcNo
SoundTest__GetSongSeqArcNo: // 0x0215ECF4
	stmdb sp!, {r3, lr}
	bl SoundTest__GetSongInfo
	ldrh r0, [r0, #6]
	ldmia sp!, {r3, pc}
	arm_func_end SoundTest__GetSongSeqArcNo

	arm_func_start SoundTest__GetSongSeqID
SoundTest__GetSongSeqID: // 0x0215ED04
	stmdb sp!, {r3, lr}
	bl SoundTest__GetSongInfo
	ldrh r0, [r0, #8]
	ldmia sp!, {r3, pc}
	arm_func_end SoundTest__GetSongSeqID

	arm_func_start SoundTest__GetSongUnlockFlags
SoundTest__GetSongUnlockFlags: // 0x0215ED14
	stmdb sp!, {r3, lr}
	bl SoundTest__GetSongInfo
	ldrb r0, [r0, #0]
	ldmia sp!, {r3, pc}
	arm_func_end SoundTest__GetSongUnlockFlags

	arm_func_start SoundTest__GetSongInfoName
SoundTest__GetSongInfoName: // 0x0215ED24
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SoundTest__GetSongInfo
	ldr r0, [r0, #0xc]
	add r0, r4, r0
	ldmia sp!, {r4, pc}
	arm_func_end SoundTest__GetSongInfoName

	arm_func_start SoundTest__GetSongInfoLength
SoundTest__GetSongInfoLength: // 0x0215ED3C
	stmdb sp!, {r3, lr}
	bl SoundTest__GetSongInfo
	ldrh r0, [r0, #0xa]
	ldmia sp!, {r3, pc}
	arm_func_end SoundTest__GetSongInfoLength

	arm_func_start SoundTest__GetSongInfo
SoundTest__GetSongInfo: // 0x0215ED4C
	add r0, r0, #0x10
	add r0, r0, r1, lsl #4
	bx lr
	arm_func_end SoundTest__GetSongInfo

	.rodata

.public _021618FC
_021618FC: // 0x021618FC
    .word 0x400
	
.public _02161900
_02161900: // 0x02161900
    .hword 0x67
	
.public _02161902
_02161902: // 0x02161902
    .hword 0x7F
	
.public _02161904
_02161904: // 0x02161904
    .hword 0x99
	
.public _02161906
_02161906: // 0x02161906
    .hword 0x7F
	
.public _02161908
_02161908: // 0x02161908
	.hword 1, 2, 3, 4, 0xB

.public _02161912
_02161912: // 0x02161912
	.hword 5, 3, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	.hword 1, 1, 1, 2, 2, 3, 5

.public _02161942
_02161942: // 0x02161942
	.hword 0, 0xC, 0, 3, 0, 0, 1, 0, 0, 2, 2, 0, 0, 4, 3, 0, 0
	.hword 6, 4, 0, 0, 0xA, 5, 0, 0, 0xB, 5, 0, 0, 0xD, 6, 0x803
	.hword 0, 0xE, 6, 0, 0, 0xF, 7, 0x403, 1, 0, 8, 0, 0, 8, 9
	.hword 0, 0, 0x2D8, 4, 0x1C71, 8, 0x1C, 0, 4, 0, 0x10, 0
	.hword 0x10, 0, 8, 0, 0x10, 0, 8, 0, 0x30, 0, 0x400, 0, 0x30
	.hword 0, 0, 0, 0x20, 0, 7, 0, 0x15, 0

	.data

aExtra: // 0x02162BC4
	.asciz "extra/"
	.align 4

aSndZ61: // 0x02162BCC
	.asciz "snd/z61/"
	.align 4

aSndZ7b: // 0x02162BD8
	.asciz "snd/z7b/"
	.align 4

aSndZ91: // 0x02162BE4
	.asciz "snd/z91/"
	.align 4

aSndZ6b: // 0x02162BF0
	.asciz "snd/z6b/"
	.align 4

aSndZfb: // 0x02162BFC
	.asciz "snd/zfb/"
	.align 4

aSndZ62: // 0x02162C08
	.asciz "snd/z62/"
	.align 4

aSndZ21: // 0x02162C14
	.asciz "snd/z21/"
	.align 4

aSndZ5b: // 0x02162C20
	.asciz "snd/z5b/"
	.align 4

aSndZ52: // 0x02162C2C
	.asciz "snd/z52/"
	.align 4

aSndZ51: // 0x02162C38
	.asciz "snd/z51/"
	.align 4

aSndZ71: // 0x02162C44
	.asciz "snd/z71/"
	.align 4

aSndZ41: // 0x02162C50
	.asciz "snd/z41/"
	.align 4

aSndZ72: // 0x02162C5C
	.asciz "snd/z72/"
	.align 4

aSndZ3b: // 0x02162C68
	.asciz "snd/z3b/"
	.align 4

aSndZ32: // 0x02162C74
	.asciz "snd/z32/"
	.align 4

aSndZ31: // 0x02162C80
	.asciz "snd/z31/"
	.align 4

aSndZ2b: // 0x02162C8C
	.asciz "snd/z2b/"
	.align 4

aSndZ22: // 0x02162C98
	.asciz "snd/z22/"
	.align 4

aSndSb1: // 0x02162CA4
	.asciz "snd/sb1/"
	.align 4

aSndZ1t: // 0x02162CB0
	.asciz "snd/z1t/"
	.align 4

aSndZ1b: // 0x02162CBC
	.asciz "snd/z1b/"
	.align 4

aSndZ12: // 0x02162CC8
	.asciz "snd/z12/"
	.align 4

aSndZ11: // 0x02162CD4
	.asciz "snd/z11/"
	.align 4

aSndSb4: // 0x02162CE0
	.asciz "snd/sb4/"
	.align 4

aSndSb3: // 0x02162CEC
	.asciz "snd/sb3/"
	.align 4

aSndSb2: // 0x02162CF8
	.asciz "snd/sb2/"
	.align 4

aSndZ4b: // 0x02162D04
	.asciz "snd/z4b/"
	.align 4

aSndZ42: // 0x02162D10
	.asciz "snd/z42/"
	.align 4

aSndSys: // 0x02162D1C
	.asciz "snd/sys/"
	.align 4

.public _02162D28
_02162D28:
	.word aSndSys, aExtra, aSndSb1, aSndSb2, aSndSb3, aSndSb4
	.word aSndZ11, aSndZ12, aSndZ1b, aSndZ1t, aSndZ21, aSndZ22
	.word aSndZ2b, aSndZ31, aSndZ32, aSndZ3b, aSndZ41, aSndZ42
	.word aSndZ4b, aSndZ51, aSndZ52, aSndZ5b, aSndZ61, aSndZ62
	.word aSndZ6b, aSndZ71, aSndZ72, aSndZ7b, aSndZ91, aSndZfb

aNarcDmsouLz7Na: // 0x02162DA0
	.asciz "narc/dmsou_lz7.narc"
	.align 4

aStSoundTestLz7: // 0x02162DB4
	.asciz "st/sound_test_lz7.st"
	.align 4

aBbViNpcBb_ovl04: // 0x02162DCC
	.asciz "bb/vi_npc.bb"
	.align 4

aNarcViBgLz7Nar_ovl04: // 0x02162DDC
	.asciz "narc/vi_bg_lz7.narc"
	.align 4

aFntFontIplFnt_ovl04: // 0x02162DF0
	.asciz "fnt/font_ipl.fnt"
	.align 4

aSoundDataSdat: // 0x02162E04
	.asciz "sound_data.sdat"
	.align 4