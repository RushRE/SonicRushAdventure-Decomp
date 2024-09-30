	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailGraphics__SetupDisplay
SailGraphics__SetupDisplay: // 0x02154450
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	ldr r4, _02154920 // =0x04000304
	ldr r0, _02154924 // =0xFFFFFDF1
	ldrh r3, [r4, #0]
	ldr r1, _02154928 // =renderCurrentDisplay
	mov r2, #0
	and r0, r3, r0
	orr r0, r0, #0xe
	orr r0, r0, #0x200
	strh r0, [r4]
	str r2, [r1]
	bl GX_DisableBankForBG
	bl GX_DisableBankForOBJ
	bl GX_DisableBankForBGExtPltt
	bl GX_DisableBankForOBJExtPltt
	bl GX_DisableBankForTex
	bl GX_DisableBankForTexPltt
	bl GX_DisableBankForClearImage
	bl GX_DisableBankForSubBG
	bl GX_DisableBankForSubOBJ
	bl GX_DisableBankForSubBGExtPltt
	bl GX_DisableBankForSubOBJExtPltt
	bl GX_DisableBankForARM7
	bl GX_DisableBankForLCDC
	mov r0, #0x400
	str r0, [sp]
	mov r0, #0x10
	add r1, r0, #0x100000
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupOBJBank
	mov r0, #0
	bl VRAMSystem__InitSpriteBuffer
	mov r0, #0x40
	bl VRAMSystem__SetupBGBank
	mov r0, #0xb
	bl VRAMSystem__SetupTextureBank
	mov r0, #0x20
	bl VRAMSystem__SetupTexturePalBank
	bl VRAMSystem__InitTextureBuffer
	bl VRAMSystem__InitPaletteBuffer
	mov r0, #1
	mov r1, #0
	mov r2, r0
	bl GX_SetGraphicsMode
	mov lr, #0x4000000
	ldr r0, [lr]
	mov r3, #0
	bic r0, r0, #0x38000000
	str r0, [lr]
	ldr r1, [lr]
	ldr r0, _0215492C // =renderCoreSwapBuffer
	bic r1, r1, #0x7000000
	str r1, [lr]
	mov ip, #1
	str ip, [r0, #4]
	str ip, [r0, #8]
	ldrh r0, [lr, #0x60]
	ldr r1, _02154930 // =0xFFFFCFFD
	and r0, r0, r1
	strh r0, [lr, #0x60]
	ldrh r0, [lr, #0x60]
	bic r0, r0, #0x3000
	orr r0, r0, #0x10
	strh r0, [lr, #0x60]
	ldrh r4, [lr, #0x60]
	ldr r0, _02154934 // =0x0000CFFB
	mov r2, r1, lsr #0x11
	and r1, r4, r0
	strh r1, [lr, #0x60]
	ldrh r1, [lr, #0x60]
	sub r4, r0, #0x1c
	mov r0, #0x7c00
	bic r1, r1, #0x3000
	orr r1, r1, #8
	strh r1, [lr, #0x60]
	ldrh r5, [lr, #0x60]
	mov r1, #0x1f
	and r4, r5, r4
	strh r4, [lr, #0x60]
	str ip, [sp]
	bl G3X_SetClearColor
	mov r0, #0
	mov r1, r0
	mov r3, r0
	mov r2, #6
	bl G3X_SetFog
	ldr r0, _0215492C // =renderCoreSwapBuffer
	ldr r4, _02154938 // =0x0400000A
	ldr r2, [r0, #8]
	ldr r0, [r0, #4]
	ldr r1, _0215493C // =0x04000540
	orr r2, r0, r2, lsl #1
	str r2, [r1]
	ldr r0, _02154940 // =0xBFFF0000
	sub r3, r4, #2
	str r0, [r1, #0x40]
	ldrh r0, [r4, #0]
	ldr r2, _02154944 // =renderCoreGFXControlA
	mov r1, #0x10
	and r0, r0, #0x43
	strh r0, [r4]
	ldrh r0, [r3, #0]
	bic r0, r0, #3
	orr r0, r0, #1
	strh r0, [r3]
	ldrh r3, [r4, #0]
	add r0, r4, #0x62
	bic r3, r3, #3
	strh r3, [r4]
	strh r1, [r2, #0x58]
	bl GXx_SetMasterBrightness_
	mov r1, #0x4000000
	ldr r0, [r1, #0]
	ldr r2, _02154944 // =renderCoreGFXControlA
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1300
	str r0, [r1]
	ldrh r3, [r2, #0x20]
	mov r0, #0
	mov r1, #1
	bic r3, r3, #0xc0
	strh r3, [r2, #0x20]
	add r2, sp, #0xa
	add r3, sp, #8
	bl GetVRAMCharacterConfig
	ldr r1, _02154948 // =VRAMSystem__VRAM_BG
	ldrh r3, [sp, #0xa]
	ldr r4, [r1, #0]
	ldrh r1, [sp, #8]
	mov r0, #0
	mov r2, #0x4000
	mov r1, r1, lsl #0xe
	add r1, r1, r3, lsl #16
	add r1, r4, r1
	bl MIi_CpuClear16
	add r0, sp, #8
	str r0, [sp]
	add r2, sp, #0x10
	add r3, sp, #0xa
	mov r0, #0
	mov r1, #1
	bl GetVRAMTileConfig
	ldrh r1, [sp, #8]
	ldrh r2, [sp, #0xa]
	mov r0, #0x40
	mov r1, r1, lsl #0xb
	add r1, r1, r2, lsl #16
	add r1, r4, r1
	mov r2, #0x800
	bl MIi_CpuClear16
	mov r0, #4
	bl VRAMSystem__SetupSubBGBank
	mov r0, #0x100
	ldr r1, _0215494C // =0x00100010
	mov r2, #0x40
	mov r3, #0
	str r0, [sp]
	bl VRAMSystem__SetupSubOBJBank
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r2, _02154950 // =0x0400100A
	ldr r3, _02154954 // =renderCoreGFXControlB
	ldrh r0, [r2, #0]
	sub r4, r2, #0xa
	mov r1, #0x10
	and r0, r0, #0x43
	orr r0, r0, #0x110
	orr r0, r0, #0x8000
	strh r0, [r2]
	ldrh ip, [r2]
	add r0, r2, #0x62
	bic ip, ip, #3
	strh ip, [r2]
	ldrh ip, [r2, #2]
	and ip, ip, #0x43
	orr ip, ip, #0x318
	strh ip, [r2, #2]
	ldrh ip, [r2, #2]
	bic ip, ip, #3
	orr ip, ip, #1
	strh ip, [r2, #2]
	ldrh ip, [r2, #4]
	and ip, ip, #0x43
	orr ip, ip, #8
	strh ip, [r2, #4]
	ldrh ip, [r2, #4]
	bic ip, ip, #3
	orr ip, ip, #2
	strh ip, [r2, #4]
	ldr r2, [r4, #0]
	bic r2, r2, #0x1f00
	orr r2, r2, #0x1e00
	str r2, [r4]
	strh r1, [r3, #0x58]
	bl GXx_SetMasterBrightness_
	ldr r3, _02154954 // =renderCoreGFXControlB
	mov r0, #1
	ldrh r4, [r3, #0x20]
	mov r1, r0
	add r2, sp, #6
	bic r4, r4, #0xc0
	strh r4, [r3, #0x20]
	add r3, sp, #4
	bl GetVRAMCharacterConfig
	ldrh r1, [sp, #4]
	ldr r0, _02154948 // =VRAMSystem__VRAM_BG
	ldrh r2, [sp, #6]
	mov r1, r1, lsl #0xe
	ldr r4, [r0, #4]
	add r0, r1, r2, lsl #16
	add r1, r4, r0
	mov r0, #0
	mov r2, #0x820
	bl MIi_CpuClear16
	add ip, sp, #4
	mov r0, #1
	add r2, sp, #0xc
	add r3, sp, #6
	mov r1, r0
	str ip, [sp]
	bl GetVRAMTileConfig
	ldrh r1, [sp, #4]
	ldrh r2, [sp, #6]
	mov r0, #0x40
	mov r1, r1, lsl #0xb
	add r1, r1, r2, lsl #16
	add r1, r4, r1
	mov r2, #0x1000
	bl MIi_CpuClear16
	add r2, sp, #6
	mov r0, #1
	mov r1, #2
	add r3, sp, #4
	bl GetVRAMCharacterConfig
	ldrh r1, [sp, #4]
	ldrh r3, [sp, #6]
	mov r0, #0
	mov r1, r1, lsl #0xe
	add r1, r1, r3, lsl #16
	mov r2, #0x8000
	add r1, r4, r1
	bl MIi_CpuClear16
	add r1, sp, #4
	str r1, [sp]
	mov r0, #1
	mov r1, #2
	add r2, sp, #0xc
	add r3, sp, #6
	bl GetVRAMTileConfig
	ldrh r1, [sp, #4]
	ldrh r3, [sp, #6]
	mov r0, #4
	mov r1, r1, lsl #0xb
	add r1, r1, r3, lsl #16
	mov r2, #0x800
	add r1, r4, r1
	bl MIi_CpuClear16
	mov r0, #1
	mov r1, #3
	add r2, sp, #6
	add r3, sp, #4
	bl GetVRAMCharacterConfig
	ldrh r1, [sp, #4]
	ldrh r3, [sp, #6]
	mov r0, #0
	mov r1, r1, lsl #0xe
	add r1, r1, r3, lsl #16
	mov r2, #0x8000
	add r1, r4, r1
	bl MIi_CpuClear16
	add r0, sp, #4
	str r0, [sp]
	add r2, sp, #0xc
	add r3, sp, #6
	mov r0, #1
	mov r1, #3
	bl GetVRAMTileConfig
	ldrh r1, [sp, #4]
	ldrh r2, [sp, #6]
	mov r0, #0
	mov r1, r1, lsl #0xb
	add r1, r1, r2, lsl #16
	add r1, r4, r1
	mov r2, #0x800
	bl MIi_CpuClear16
	ldr r1, _02154944 // =renderCoreGFXControlA
	mov r2, #0
	ldr r0, _02154954 // =renderCoreGFXControlB
	strh r2, [r1]
	strh r2, [r0]
	strh r2, [r1, #2]
	strh r2, [r0, #2]
	strh r2, [r1, #4]
	strh r2, [r0, #4]
	strh r2, [r1, #6]
	strh r2, [r0, #6]
	strh r2, [r1, #8]
	strh r2, [r0, #8]
	strh r2, [r1, #0xa]
	strh r2, [r0, #0xa]
	strh r2, [r1, #0xc]
	strh r2, [r0, #0xc]
	strh r2, [r1, #0xe]
	strh r2, [r0, #0xe]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02154920: .word 0x04000304
_02154924: .word 0xFFFFFDF1
_02154928: .word renderCurrentDisplay
_0215492C: .word renderCoreSwapBuffer
_02154930: .word 0xFFFFCFFD
_02154934: .word 0x0000CFFB
_02154938: .word 0x0400000A
_0215493C: .word 0x04000540
_02154940: .word 0xBFFF0000
_02154944: .word renderCoreGFXControlA
_02154948: .word VRAMSystem__VRAM_BG
_0215494C: .word 0x00100010
_02154950: .word 0x0400100A
_02154954: .word renderCoreGFXControlB
	arm_func_end SailGraphics__SetupDisplay

	arm_func_start SailGraphics__SetupLights
SailGraphics__SetupLights: // 0x02154958
	stmdb sp!, {r3, lr}
	ldr r1, _02154A10 // =0x00007FFF
	mov r0, #0
	bl NNS_G3dGlbLightColor
	ldr r1, _02154A14 // =0x00004631
	mov r0, #1
	bl NNS_G3dGlbLightColor
	ldr r1, _02154A18 // =0x00002108
	mov r0, #2
	bl NNS_G3dGlbLightColor
	ldr r1, _02154A1C // =0xFFFFF6C3
	mov r0, #0
	mov r2, r1
	mov r3, r1
	bl NNS_G3dGlbLightVector
	mov r0, #1
	ldr r1, _02154A20 // =0x0000093D
	mov r2, r1
	mov r3, r1
	bl NNS_G3dGlbLightVector
	mov r0, #2
	mov r1, #0
	sub r2, r1, #0x1000
	mov r3, r1
	bl NNS_G3dGlbLightVector
	mov r1, #3
	ldr r0, _02154A24 // =g_obj
	sub r2, r1, #0x940
	strh r1, [r0, #0x5c]
	rsb r1, r1, #0x940
	strh r2, [r0, #0x44]
	strh r2, [r0, #0x46]
	strh r2, [r0, #0x48]
	strh r1, [r0, #0x4a]
	strh r1, [r0, #0x4c]
	strh r1, [r0, #0x4e]
	mov r2, #0
	strh r2, [r0, #0x50]
	sub r1, r2, #0x1000
	strh r1, [r0, #0x52]
	strh r2, [r0, #0x54]
	ldr r1, _02154A28 // =0x00000FFF
	strh r1, [r0, #0x56]
	strh r2, [r0, #0x58]
	strh r2, [r0, #0x5a]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02154A10: .word 0x00007FFF
_02154A14: .word 0x00004631
_02154A18: .word 0x00002108
_02154A1C: .word 0xFFFFF6C3
_02154A20: .word 0x0000093D
_02154A24: .word g_obj
_02154A28: .word 0x00000FFF
	arm_func_end SailGraphics__SetupLights
