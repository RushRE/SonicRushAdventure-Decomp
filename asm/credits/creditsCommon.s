	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start InitCreditsEvent
InitCreditsEvent: // 0x021544C8
	stmdb sp!, {r3, lr}
	ldr r0, _0215451C // =gameState
	ldr r0, [r0, #0x15c]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r3, pc}
_021544E0: // jump table
	b _021544F4 // case 0
	b _021544FC // case 1
	b _02154504 // case 2
	b _0215450C // case 3
	b _02154514 // case 4
_021544F4:
	bl Credits__Create
	ldmia sp!, {r3, pc}
_021544FC:
	bl CreditsEx__Create
	ldmia sp!, {r3, pc}
_02154504:
	bl FakeCredits__Create
	ldmia sp!, {r3, pc}
_0215450C:
	bl ExStageCreditsNotification__Create
	ldmia sp!, {r3, pc}
_02154514:
	bl PostGameMissionCreditsNotification__Create
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215451C: .word gameState
	arm_func_end InitCreditsEvent

	arm_func_start ovl05_2154520
ovl05_2154520: // 0x02154520
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl VRAMSystem__Reset
	cmp r5, #1
	ldr r3, _021548C4 // =0x04000304
	ldr r1, _021548C8 // =0xFFFFFDF1
	bne _02154568
	ldrh r2, [r3]
	mov r0, #3
	and r1, r2, r1
	orr r1, r1, #2
	orr r1, r1, #0x200
	strh r1, [r3]
	bl VRAMSystem__SetupBGBank
	mov r0, #0x40
	bl VRAMSystem__SetupBGExtPalBank
	b _02154594
_02154568:
	ldrh r2, [r3]
	mov r0, #2
	and r1, r2, r1
	orr r1, r1, #0xe
	orr r1, r1, #0x200
	strh r1, [r3]
	bl VRAMSystem__SetupTextureBank
	mov r0, #0x40
	bl VRAMSystem__SetupTexturePalBank
	mov r0, #1
	bl VRAMSystem__SetupBGBank
_02154594:
	mov r0, #0x10
	mov ip, #0x400
	add r1, r0, #0x100000
	mov r2, #0x40
	mov r3, #0
	str ip, [sp]
	bl VRAMSystem__SetupOBJBank
	mov r0, #0x20
	bl VRAMSystem__SetupOBJExtPalBank
	mov r0, #4
	bl VRAMSystem__SetupSubBGBank
	mov r0, #0x80
	bl VRAMSystem__SetupSubBGExtPalBank
	mov r0, #0x400
	str r0, [sp]
	ldr r1, _021548CC // =0x00100010
	mov r0, #8
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupSubOBJBank
	mov r0, #0x100
	bl VRAMSystem__SetupSubOBJExtPalBank
	ldr r3, _021548C4 // =0x04000304
	ldr r0, _021548D0 // =renderCurrentDisplay
	ldrh r2, [r3]
	mov r1, #1
	mov ip, #0
	orr r2, r2, #0x8000
	strh r2, [r3]
	str r1, [r0]
	mov r1, #0x5000000
	strh ip, [r1]
	add r1, r1, #0x400
	strh ip, [r1]
	ldr r1, _021548D4 // =renderCoreGFXControlA
	sub r0, r3, #0x298
	str ip, [r1, #0x1c]
	ldrh r3, [r1, #0x20]
	sub r2, ip, #0x10
	bic r3, r3, #0xc0
	strh r3, [r1, #0x20]
	strh r2, [r1, #0x58]
	strh ip, [r1, #0x5a]
	ldrsh r1, [r1, #0x58]
	bl GXx_SetMasterBrightness_
	mov r1, #0x4000000
	ldr r0, [r1]
	cmp r5, #1
	bic r0, r0, #0x38000000
	str r0, [r1]
	ldr r0, [r1]
	bic r0, r0, #0x7000000
	str r0, [r1]
	mov r0, #1
	mov r1, #0
	bne _02154698
	mov r2, r1
	bl GX_SetGraphicsMode
	ldr r1, _021548D8 // =0x04000008
	ldrh r0, [r1]
	and r0, r0, #0x43
	orr r0, r0, #0x5a0
	orr r0, r0, #0x2000
	strh r0, [r1]
	b _021546A0
_02154698:
	mov r2, r0
	bl GX_SetGraphicsMode
_021546A0:
	ldr r0, _021548DC // =0x0400000A
	ldr r1, _021548D4 // =renderCoreGFXControlA
	ldrh r2, [r0]
	mov r3, #0
	cmp r4, #0
	and r2, r2, #0x43
	orr r2, r2, #4
	strh r2, [r0]
	ldrh r2, [r0, #2]
	and r2, r2, #0x43
	orr r2, r2, #0x110
	strh r2, [r0, #2]
	ldrh ip, [r0, #4]
	sub r2, r0, #2
	and ip, ip, #0x43
	orr ip, ip, #0x318
	strh ip, [r0, #4]
	strh r3, [r1, #2]
	strh r3, [r1]
	strh r3, [r1, #6]
	strh r3, [r1, #4]
	strh r3, [r1, #0xa]
	strh r3, [r1, #8]
	strh r3, [r1, #0xe]
	strh r3, [r1, #0xc]
	ldrh r1, [r2]
	bic r1, r1, #3
	orr r1, r1, #3
	strh r1, [r2]
	ldrh r1, [r0]
	bic r1, r1, #3
	orr r1, r1, #2
	strh r1, [r0]
	ldrh r1, [r0, #2]
	bic r1, r1, #3
	orr r1, r1, #1
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	bic r1, r1, #3
	strh r1, [r0, #4]
	mov r1, #0x4000000
	beq _0215475C
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1c00
	str r0, [r1]
	b _0215476C
_0215475C:
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r1]
_0215476C:
	cmp r5, #1
	mov r0, #0
	bne _0215478C
	ldr r1, _021548E0 // =VRAMSystem__VRAM_BG
	mov r2, #0x40000
	ldr r1, [r1]
	bl MIi_CpuClear16
	b _0215479C
_0215478C:
	ldr r1, _021548E0 // =VRAMSystem__VRAM_BG
	mov r2, #0x20000
	ldr r1, [r1]
	bl MIi_CpuClear16
_0215479C:
	ldr r1, _021548E4 // =renderCoreGFXControlB
	mov r5, #0
	str r5, [r1, #0x1c]
	ldrh r3, [r1, #0x20]
	sub r2, r5, #0x10
	ldr r0, _021548E8 // =0x0400106C
	bic r3, r3, #0xc0
	strh r3, [r1, #0x20]
	strh r2, [r1, #0x58]
	strh r5, [r1, #0x5a]
	ldrsh r1, [r1, #0x58]
	bl GXx_SetMasterBrightness_
	mov r0, r5
	bl GXS_SetGraphicsMode
	ldr r0, _021548EC // =0x04001008
	ldr r1, _021548E4 // =renderCoreGFXControlB
	ldrh r3, [r0]
	mov r2, r5
	cmp r4, #0
	and r3, r3, #0x43
	orr r3, r3, #4
	strh r3, [r0]
	ldrh r3, [r0, #2]
	and r3, r3, #0x43
	orr r3, r3, #0x188
	strh r3, [r0, #2]
	ldrh r3, [r0, #4]
	and r3, r3, #0x43
	orr r3, r3, #0x210
	strh r3, [r0, #4]
	ldrh r3, [r0, #6]
	and r3, r3, #0x43
	orr r3, r3, #0x18
	orr r3, r3, #0x400
	strh r3, [r0, #6]
	strh r2, [r1, #2]
	strh r2, [r1]
	strh r2, [r1, #6]
	strh r2, [r1, #4]
	strh r2, [r1, #0xa]
	strh r2, [r1, #8]
	strh r2, [r1, #0xe]
	strh r2, [r1, #0xc]
	ldrh r1, [r0]
	bic r1, r1, #3
	orr r1, r1, #3
	strh r1, [r0]
	ldrh r1, [r0, #2]
	bic r1, r1, #3
	orr r1, r1, #2
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	bic r1, r1, #3
	orr r1, r1, #1
	strh r1, [r0, #4]
	ldrh r1, [r0, #6]
	bic r1, r1, #3
	strh r1, [r0, #6]
	sub r1, r0, #8
	beq _0215489C
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	str r0, [r1]
	b _021548AC
_0215489C:
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r1]
_021548AC:
	ldr r1, _021548E0 // =VRAMSystem__VRAM_BG
	mov r0, #0
	ldr r1, [r1, #4]
	mov r2, #0x20000
	bl MIi_CpuClear16
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021548C4: .word 0x04000304
_021548C8: .word 0xFFFFFDF1
_021548CC: .word 0x00100010
_021548D0: .word renderCurrentDisplay
_021548D4: .word renderCoreGFXControlA
_021548D8: .word 0x04000008
_021548DC: .word 0x0400000A
_021548E0: .word VRAMSystem__VRAM_BG
_021548E4: .word renderCoreGFXControlB
_021548E8: .word 0x0400106C
_021548EC: .word 0x04001008
	arm_func_end ovl05_2154520

	arm_func_start TextCutscene__LoadAssets
TextCutscene__LoadAssets: // 0x021548F0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _02154998 // =aNarcDmsrLz7Nar
	mov r1, #0
	bl FSRequestFileSync
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	str r0, [r6]
	mov r1, r0
	mov r0, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	cmp r5, #4
	addls pc, pc, r5, lsl #2
	ldmia sp!, {r4, r5, r6, pc}
_0215493C: // jump table
	b _02154950 // case 0
	ldmia sp!, {r4, r5, r6, pc} // case 1
	ldmia sp!, {r4, r5, r6, pc} // case 2
	b _02154950 // case 3
	b _02154950 // case 4
_02154950:
	ldr r0, _0215499C // =aNarcTkdmLz7Nar_ovl05
	mov r1, #0
	bl FSRequestFileSync
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	str r0, [r6, #4]
	mov r1, r0
	mov r0, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	ldr r0, _021549A0 // =aFntFontAllFnt_2_ovl05
	mov r1, #0
	bl FSRequestFileSync
	str r0, [r6, #8]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02154998: .word aNarcDmsrLz7Nar
_0215499C: .word aNarcTkdmLz7Nar_ovl05
_021549A0: .word aFntFontAllFnt_2_ovl05
	arm_func_end TextCutscene__LoadAssets

	arm_func_start ovl05_21549A4
ovl05_21549A4: // 0x021549A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xc]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r4, pc}
_021549C4: // jump table
	b _021549D8 // case 0
	ldmia sp!, {r4, pc} // case 1
	ldmia sp!, {r4, pc} // case 2
	b _021549D8 // case 3
	b _021549D8 // case 4
_021549D8:
	ldr r0, [r4, #4]
	bl _FreeHEAP_USER
	ldr r0, [r4, #8]
	bl _FreeHEAP_USER
	ldmia sp!, {r4, pc}
	arm_func_end ovl05_21549A4

	arm_func_start ovl05_21549EC
ovl05_21549EC: // 0x021549EC
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4]
	mov r1, #0
	ldr r0, [r0]
	bl FileUnknown__GetAOUFile
	ldr r1, [r4]
	mov r6, r0
	ldr r0, [r1]
	mov r1, #1
	bl FileUnknown__GetAOUFile
	ldr r1, [r4], #4
	mov r5, r0
	ldr r0, [r1]
	mov r1, #2
	bl FileUnknown__GetAOUFile
	ldr r1, _02154AB8 // =0x001FFFFF
	bl LoadDrawState
	mov r0, r6
	bl NNS_G3dResDefaultSetup
	mov r0, r4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	mov r1, r6
	mov r0, r4
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	mov r3, #0
	mov r2, r5
	mov r0, r4
	mov r1, #3
	str r3, [sp]
	bl AnimatorMDL__SetAnimation
	mov r3, #0
	mov r2, #1
_02154A84:
	mov r0, r2, lsl r3
	tst r0, #8
	beq _02154AA4
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0xc]
	orr r1, r1, #1
	strh r1, [r0, #0xc]
_02154AA4:
	add r3, r3, #1
	cmp r3, #5
	blo _02154A84
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02154AB8: .word 0x001FFFFF
	arm_func_end ovl05_21549EC

	arm_func_start ovl05_2154ABC
ovl05_2154ABC: // 0x02154ABC
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #4
	bl AnimatorMDL__Release
	ldr r0, [r4]
	mov r1, #0
	ldr r0, [r0]
	bl FileUnknown__GetAOUFile
	bl NNS_G3dResDefaultRelease
	ldmia sp!, {r4, pc}
	arm_func_end ovl05_2154ABC

	arm_func_start ovl05_2154AE4
ovl05_2154AE4: // 0x02154AE4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1bc
	mov r5, r0
	cmp r1, #0
	beq _02154B0C
	cmp r1, #1
	beq _02154B50
	cmp r1, #2
	beq _02154BD0
	b _02154C10
_02154B0C:
	ldr r0, [r5]
	mov r1, #3
	bl FileUnknown__GetAOUFile
	mov r2, #1
	str r2, [sp]
	mov r2, #0x20
	mov r1, r0
	str r2, [sp, #4]
	mov r4, #0x18
	add r0, sp, #0x174
	mov r2, #0x38
	mov r3, #0
	str r4, [sp, #8]
	bl InitBackground
	add r0, sp, #0x174
	bl DrawBackground
	b _02154C10
_02154B50:
	ldr r0, [r5]
	mov r1, #0xf
	bl FileUnknown__GetAOUFile
	mov r3, #0
	mov r1, r0
	str r3, [sp]
	mov r2, #0x20
	str r2, [sp, #4]
	mov r4, #0x18
	add r0, sp, #0x12c
	mov r2, #0x38
	str r4, [sp, #8]
	bl InitBackground
	add r0, sp, #0x12c
	bl DrawBackground
	ldr r0, [r5]
	mov r1, #3
	bl FileUnknown__GetAOUFile
	mov r1, r0
	mov r0, #1
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, r4
	str r0, [sp, #8]
	add r0, sp, #0xe4
	mov r2, #0x38
	mov r3, #0
	bl InitBackground
	add r0, sp, #0xe4
	bl DrawBackground
	b _02154C10
_02154BD0:
	ldr r0, [r5]
	mov r1, #0xe
	bl FileUnknown__GetAOUFile
	mov r2, #1
	str r2, [sp]
	mov r2, #0x20
	mov r1, r0
	str r2, [sp, #4]
	mov r4, #0x18
	add r0, sp, #0x9c
	mov r2, #0x38
	mov r3, #0
	str r4, [sp, #8]
	bl InitBackground
	add r0, sp, #0x9c
	bl DrawBackground
_02154C10:
	ldr r0, [r5]
	mov r1, #4
	bl FileUnknown__GetAOUFile
	mov r2, #0
	str r2, [sp]
	mov r2, #0x20
	mov r1, r0
	str r2, [sp, #4]
	mov r4, #0x18
	add r0, sp, #0x54
	mov r2, #0x38
	mov r3, #1
	str r4, [sp, #8]
	bl InitBackground
	add r0, sp, #0x54
	bl DrawBackground
	ldr r0, [r5]
	mov r1, #5
	bl FileUnknown__GetAOUFile
	mov r3, #1
	mov r1, r0
	str r3, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, r4
	str r0, [sp, #8]
	add r0, sp, #0xc
	mov r2, #0x38
	bl InitBackground
	add r0, sp, #0xc
	bl DrawBackground
	ldr r0, [r5, #0xc]
	cmp r0, #0
	beq _02154CAC
	cmp r0, #1
	beq _02154D30
	cmp r0, #2
	beq _02154D58
	b _02154D7C
_02154CAC:
	ldr r4, _02154F44 // =0x04001000
	ldr r1, _02154F48 // =0x0213D284
	ldr r2, [r4]
	ldr r0, [r4]
	and r2, r2, #0x1f00
	mov r3, r2, lsr #8
	bic r2, r0, #0x1f00
	bic r0, r3, #2
	orr r3, r2, r0, lsl #8
	mov r0, #0
	mov r2, #6
	str r3, [r4]
	bl MIi_CpuClear16
	ldr r0, _02154F4C // =renderCoreGFXControlB
	ldrh r1, [r0, #0x20]
	bic r1, r1, #0xc0
	orr r1, r1, #0x40
	strh r1, [r0, #0x20]
	ldrh r1, [r0, #0x20]
	orr r1, r1, #0x100
	strh r1, [r0, #0x20]
	ldrh r1, [r0, #0x20]
	orr r1, r1, #2
	orr r1, r1, #0x1000
	strh r1, [r0, #0x20]
	ldrh r1, [r0, #0x22]
	bic r1, r1, #0x1f
	strh r1, [r0, #0x22]
	ldrh r1, [r0, #0x22]
	bic r1, r1, #0x1f00
	orr r1, r1, #0x1000
	strh r1, [r0, #0x22]
	b _02154D7C
_02154D30:
	ldr r2, _02154F44 // =0x04001000
	ldr r1, [r2]
	ldr r0, [r2]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #2
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	b _02154D7C
_02154D58:
	ldr r2, _02154F44 // =0x04001000
	ldr r1, [r2]
	ldr r0, [r2]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #2
	orr r0, r1, r0, lsl #8
	str r0, [r2]
_02154D7C:
	ldr r0, [r5]
	mov r1, #6
	bl FileUnknown__GetAOUFile
	mov r4, r0
	bl GetBackgroundHeight
	mov r0, r0, lsl #3
	str r0, [r5, #0x44]
	sub r0, r0, #0xc0
	str r0, [r5, #0x3c]
	ldr r0, [r5, #0x44]
	mov r1, r4
	sub r0, r0, #0x1d0
	str r0, [r5, #0x40]
	mov r3, #2
	str r3, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r4, #0x18
	add r0, r5, #0x48
	mov r2, #0xc0
	str r4, [sp, #8]
	bl InitBackgroundDS
	add r0, r5, #0x48
	bl DrawBackgroundDS
	ldr r0, [r5, #0x48]
	mov r1, #9 // ROM DIFF: 9 = EU, 8 = US, 7 = JP
	orr r0, r0, #3
	str r0, [r5, #0x48]
	ldr r0, [r5]
	bl FileUnknown__GetAOUFile
	mov r4, r0
	bl GetBackgroundHeight
	mov r0, r0, lsl #3
	str r0, [r5, #0xe8]
	mov r0, #0x110
	rsb r0, r0, #0
	str r0, [r5, #0xdc]
	ldr r0, [r5, #0xe8]
	mov r3, #3
	sub r0, r0, #0xc0
	str r0, [r5, #0xe0]
	ldr r2, [r5, #0xe8]
	mov r0, #0x20
	sub r2, r2, #0x1d0
	str r2, [r5, #0xe4]
	str r3, [sp]
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	mov r1, r4
	add r0, r5, #0xec
	mov r2, #0xc0
	bl InitBackgroundDS
	add r0, r5, #0xec
	bl DrawBackgroundDS
	ldr r0, [r5, #0xec]
	mov r1, #0xc // ROM DIFF: 12 = EU, 11 = US, 10 = JP
	orr r0, r0, #3
	str r0, [r5, #0xec]
	ldr r0, [r5]
	bl FileUnknown__GetAOUFile
	mov r4, r0
	bl GetBackgroundHeight
	mov r0, r0, lsl #3
	str r0, [r5, #0x18c]
	mov r0, #0x110
	rsb r0, r0, #0
	str r0, [r5, #0x180]
	ldr r0, [r5, #0x18c]
	sub r0, r0, #0xc0
	str r0, [r5, #0x184]
	ldr r0, [r5, #0x18c]
	mov r3, #2
	sub r0, r0, #0x1d0
	str r0, [r5, #0x188]
	str r3, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	mov r1, r4
	str r0, [sp, #8]
	add r0, r5, #0x190
	mov r2, #0xc0
	bl InitBackgroundDS
	ldr r0, [r5]
	mov r1, #0xd
	bl FileUnknown__GetAOUFile
	mov r4, r0
	bl GetBackgroundHeight
	mov r0, r0, lsl #3
	str r0, [r5, #0x230]
	mov r0, #0x110
	mov r1, r4
	rsb r0, r0, #0
	str r0, [r5, #0x224]
	ldr r0, [r5, #0x230]
	mov r3, #3
	sub r0, r0, #0xc0
	str r0, [r5, #0x228]
	ldr r2, [r5, #0x230]
	mov r0, #0x20
	sub r2, r2, #0x1d0
	str r2, [r5, #0x22c]
	str r3, [sp]
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, r5, #0x234
	mov r2, #0xc0
	bl InitBackgroundDS
	mov r0, #1
	str r0, [r5, #0x18]
	add sp, sp, #0x1bc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02154F44: .word 0x04001000
_02154F48: .word 0x0213D284
_02154F4C: .word renderCoreGFXControlB
	arm_func_end ovl05_2154AE4

	arm_func_start ovl05_2154F50
ovl05_2154F50: // 0x02154F50
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x30
	mov sb, r1
	mov r8, r2
	mov sl, r0
	mov r0, sb
	mov r1, r8
	mov fp, r3
	bl Sprite__GetFormatFromAnim
	cmp r0, #0
	beq _02154F88
	cmp r0, #1
	beq _02154F9C
	b _02154FAC
_02154F88:
	ldr r6, _02155030 // =0x05000200
	mov r4, #0
	mov r5, r4
	add r7, r6, #0x400
	b _02154FAC
_02154F9C:
	mov r6, #0
	mov r7, r6
	mov r4, #2
	mov r5, #4
_02154FAC:
	mov r0, sb
	bl Sprite__GetSpriteSize2
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	str r0, [sp, #0x2c]
	mov r0, sb
	bl Sprite__GetSpriteSize2
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0x800
	mov r2, r8
	str r3, [sp]
	mov r3, #0
	ldr r8, [sp, #0x2c]
	str r3, [sp, #4]
	str r8, [sp, #8]
	str r4, [sp, #0xc]
	str r6, [sp, #0x10]
	str r3, [sp, #0x14]
	str r0, [sp, #0x18]
	str r5, [sp, #0x1c]
	str r7, [sp, #0x20]
	str r3, [sp, #0x24]
	mov r1, sb
	mov r0, sl
	str r3, [sp, #0x28]
	bl AnimatorSpriteDS__Init
	strh fp, [sl, #0x90]
	strh fp, [sl, #0x92]
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02155030: .word 0x05000200
	arm_func_end ovl05_2154F50

	arm_func_start ovl05_2155034
ovl05_2155034: // 0x02155034
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x1c
	mov sl, r0
	ldr r0, [sl]
	mov r1, #0x10
	bl FileUnknown__GetAOUFile
	mov r4, r0
	mov r2, #0
	mov r1, r4
	mov r3, r2
	add r0, sl, #0x2c8
	bl ovl05_2154F50
	mov r2, #1
	mov r1, r4
	mov r3, r2
	add r0, sl, #0x36c
	bl ovl05_2154F50
	ldr r0, [sl]
	mov r1, #0x11
	bl FileUnknown__GetAOUFile
	mov r2, #0
	mov r1, r0
	add r0, sl, #0x410
	mov r3, r2
	bl ovl05_2154F50
	ldr r0, [sl]
	mov r1, #0x12
	bl FileUnknown__GetAOUFile
	mov r7, #0
	mov sb, r0
	add r0, sl, #0xb4
	ldr r5, _02155130 // =0x05000200
	add r8, r0, #0x400
	mov fp, r7
	mov r6, r7
	mov r4, #1
_021550C4:
	mov r0, sb
	bl Sprite__GetSpriteSize2
	mov r1, r0
	mov r0, fp
	bl VRAMSystem__AllocSpriteVram
	str r6, [sp]
	str r6, [sp, #4]
	str r0, [sp, #8]
	str r6, [sp, #0xc]
	str r5, [sp, #0x10]
	mov r2, r7, lsl #0x10
	str r6, [sp, #0x14]
	ldr r3, _02155134 // =0x00000801
	mov r0, r8
	mov r1, sb
	mov r2, r2, lsr #0x10
	str r6, [sp, #0x18]
	bl AnimatorSprite__Init
	add r0, sl, #0x500
	add r7, r7, #1
	strh r4, [r0, #4]
	add r8, r8, #0x64
	add sl, sl, #0x64
	cmp r7, #0x12
	blt _021550C4
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02155130: .word 0x05000200
_02155134: .word 0x00000801
	arm_func_end ovl05_2155034

	arm_func_start ovl05_2155138
ovl05_2155138: // 0x02155138
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	add r5, r6, #0x2c8
	mov r4, #0
_02155148:
	mov r0, r5
	bl AnimatorSpriteDS__Release
	add r4, r4, #1
	cmp r4, #3
	add r5, r5, #0xa4
	blt _02155148
	add r0, r6, #0xb4
	add r4, r0, #0x400
	mov r5, #0
_0215516C:
	mov r0, r4
	bl AnimatorSprite__Release
	add r5, r5, #1
	cmp r5, #0x12
	add r4, r4, #0x64
	blt _0215516C
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl05_2155138

	arm_func_start ovl05_2155188
ovl05_2155188: // 0x02155188
	stmdb sp!, {r3, lr}
	ldr r0, _021551C0 // =0x0213D2D0
	mov r1, #0
	mov r2, #0x10
	bl MI_CpuFill8
	ldr r0, _021551C4 // =0x0213D274
	mov r1, #0
	mov r2, #0x10
	bl MI_CpuFill8
	mov r0, #1
	bl ClearTaskScope
	mov r0, #0
	bl ClearTaskScope
	ldmia sp!, {r3, pc}
	.align 2, 0
_021551C0: .word 0x0213D2D0
_021551C4: .word 0x0213D274
	arm_func_end ovl05_2155188

	arm_func_start ovl05_21551C8
ovl05_21551C8: // 0x021551C8
	ldr ip, _021551D4 // =ClearTaskScope
	mov r0, #1
	bx ip
	.align 2, 0
_021551D4: .word ClearTaskScope
	arm_func_end ovl05_21551C8

	arm_func_start ovl05_21551D8
ovl05_21551D8: // 0x021551D8
	stmdb sp!, {r3, lr}
	bl RequestSysEventChange
	bl NextSysEvent
	ldmia sp!, {r3, pc}
	arm_func_end ovl05_21551D8

	arm_func_start ovl05_21551E8
ovl05_21551E8: // 0x021551E8
	cmp r0, #0
	ldr r1, _02155240 // =renderCoreGFXControlB
	movlt r0, #0
	blt _02155200
	cmp r0, #0x10000
	movgt r0, #0x10000
_02155200:
	ldrh r3, [r1, #0x22]
	mov r2, r0, lsl #4
	mov r2, r2, lsr #0x10
	bic r3, r3, #0x1f
	and r2, r2, #0x1f
	orr r2, r3, r2
	strh r2, [r1, #0x22]
	rsb r0, r0, #0x10000
	ldrh r2, [r1, #0x22]
	mov r0, r0, lsl #4
	mov r0, r0, lsr #0x10
	bic r2, r2, #0x1f00
	mov r0, r0, lsl #0x1b
	orr r0, r2, r0, lsr #19
	strh r0, [r1, #0x22]
	bx lr
	.align 2, 0
_02155240: .word renderCoreGFXControlB
	arm_func_end ovl05_21551E8

	arm_func_start ovl05_2155244
ovl05_2155244: // 0x02155244
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	mov r8, #0
	mov r4, r0
	mov fp, r8
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _0215527C
_02155260: // jump table
	b _02155270 // case 0
	b _02155278 // case 1
	b _02155270 // case 2
	b _02155278 // case 3
_02155270:
	mov sb, #2
	b _0215527C
_02155278:
	mov sb, #3
_0215527C:
	mov r0, #0xa4
	mul sl, r1, r0
	add r6, r4, #0x38
	add r0, r4, sl
	add r2, r4, #0x48
	ldr r1, [r6, sl]
	ldr r0, [r0, #0x3c]
	add r7, r2, sl
	cmp r1, r0
	bgt _021552F0
	cmp r1, #0
	ble _021552B8
	mov r1, sb
	mov r0, #0
	bl ovl05_21555BC
_021552B8:
	mov r0, #0
	str r0, [r7, #0x48]
	ldr r1, [r6, sl]
	ldr r0, _02155398 // =renderCoreGFXControlA
	str r1, [r7, #0x4c]
	ldr r1, [r7, #0x48]
	mov r2, sb, lsl #2
	and r1, r1, #7
	strh r1, [r0, r2]
	ldr r1, [r7, #0x4c]
	ldr r0, _0215539C // =0x0213D2C2
	and r1, r1, #7
	strh r1, [r0, r2]
	b _02155300
_021552F0:
	mov r1, sb
	mov r0, #0
	mov r8, #1
	bl ovl05_2155578
_02155300:
	add r5, r4, #0x40
	ldr r1, [r6, sl]
	ldr r0, [r5, sl]
	cmp r1, r0
	bgt _02155350
	mov r0, #0
	str r0, [r7, #0x50]
	ldr r1, [r6, sl]
	ldr r0, _021553A0 // =renderCoreGFXControlB
	add r1, r1, #0x110
	str r1, [r7, #0x54]
	ldr r1, [r7, #0x50]
	mov r2, sb, lsl #2
	and r1, r1, #7
	strh r1, [r0, r2]
	ldr r1, [r7, #0x54]
	ldr r0, _021553A4 // =0x0213D266
	and r1, r1, #7
	strh r1, [r0, r2]
	b _02155360
_02155350:
	mov fp, #1
	mov r0, fp
	mov r1, sb
	bl ovl05_2155578
_02155360:
	mov r0, r7
	bl DrawBackgroundDS
	ldr r0, [r5, sl]
	ldr r1, [r6, sl]
	sub r0, r0, #0xc0
	cmp r1, r0
	ldrge r0, [r4, #0x14]
	orrge r0, r0, #4
	strge r0, [r4, #0x14]
	cmp r8, #0
	cmpne fp, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02155398: .word renderCoreGFXControlA
_0215539C: .word 0x0213D2C2
_021553A0: .word renderCoreGFXControlB
_021553A4: .word 0x0213D266
	arm_func_end ovl05_2155244

	arm_func_start ovl05_21553A8
ovl05_21553A8: // 0x021553A8
	stmdb sp!, {r3, r4, r5, lr}
	mov r2, #0xa4
	mul r4, r1, r2
	add r5, r0, #0x48
	ldr r1, [r5, r4]
	add r0, r5, r4
	bic r1, r1, #7
	str r1, [r5, r4]
	bl DrawBackgroundDS
	ldr r0, [r5, r4]
	orr r0, r0, #3
	str r0, [r5, r4]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl05_21553A8

	arm_func_start ovl05_21553DC
ovl05_21553DC: // 0x021553DC
	stmdb sp!, {r4, r5, r6, lr}
	mov ip, #0xa4
	mla lr, r2, ip, r0
	mul r5, r1, ip
	add r2, r0, r5
	add r4, r0, #0x2c8
	mov r1, #0
	ldrsh r6, [sp, #0x10]
	ldr r0, [lr, #0x38]
	add ip, r2, #0x300
	sub r0, r6, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	strh r3, [ip, #0x30]
	strh r0, [ip, #0x32]
	mov r2, r1
	strh r3, [ip, #0x34]
	sub r3, r0, #0x110
	add r0, r4, r5
	strh r3, [ip, #0x36]
	bl AnimatorSpriteDS__ProcessAnimation
	add r0, r4, r5
	bl AnimatorSpriteDS__DrawFrame
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl05_21553DC

	arm_func_start ovl05_215543C
ovl05_215543C: // 0x0215543C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r3, [r0, #0x2c]
	mov r4, #0
	cmp r3, #0x12
	bhs _02155490
	ldr r1, [r0, #0x28]
	tst r1, #3
	bne _02155480
	mov r1, #0x64
	mul r2, r3, r1
	add r3, r0, #0x4f0
	ldr r1, [r3, r2]
	bic r1, r1, #1
	str r1, [r3, r2]
	ldr r1, [r0, #0x2c]
	add r1, r1, #1
	str r1, [r0, #0x2c]
_02155480:
	ldr r1, [r0, #0x28]
	add r1, r1, #1
	str r1, [r0, #0x28]
	b _02155494
_02155490:
	mov r4, #1
_02155494:
	add r0, r0, #0xb4
	mov r6, #0
	add r7, r0, #0x400
	mov r5, r6
_021554A4:
	mov r0, r7
	mov r1, r5
	mov r2, r5
	bl AnimatorSprite__ProcessAnimation
	mov r0, r7
	bl AnimatorSprite__DrawFrame
	add r6, r6, #1
	cmp r6, #0x12
	add r7, r7, #0x64
	blt _021554A4
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ovl05_215543C

	arm_func_start ovl05_21554D4
ovl05_21554D4: // 0x021554D4
	ldr r2, _0215551C // =padInput
	ldrh r2, [r2]
	tst r2, #1
	mov r2, #0xa4
	mul r2, r1, r2
	beq _02155504
	add r3, r0, #0x38
	ldr r1, [r3, r2]
	ldr r0, [r0, #0x18]
	add r0, r1, r0, lsl #4
	str r0, [r3, r2]
	bx lr
_02155504:
	add r3, r0, #0x38
	ldr r1, [r3, r2]
	ldr r0, [r0, #0x18]
	add r0, r1, r0
	str r0, [r3, r2]
	bx lr
	.align 2, 0
_0215551C: .word padInput
	arm_func_end ovl05_21554D4

	arm_func_start ovl05_2155520
ovl05_2155520: // 0x02155520
	ldr r0, _02155574 // =VRAMSystem__GFXControl
	mov r3, #0
	ldr ip, [r0]
	mov r2, #0xff
	strb r3, [ip, #0x11]
	strb r3, [ip, #0x10]
	strb r3, [ip, #0x15]
	strb r3, [ip, #0x14]
	strb r3, [ip, #0x18]
	strb r2, [ip, #0x1a]
	mov r1, #1
	str r1, [ip, #0x1c]
	ldr r0, [r0, #4]
	strb r3, [r0, #0x11]
	strb r3, [r0, #0x10]
	strb r3, [r0, #0x15]
	strb r3, [r0, #0x14]
	strb r3, [r0, #0x18]
	strb r2, [r0, #0x1a]
	str r1, [r0, #0x1c]
	bx lr
	.align 2, 0
_02155574: .word VRAMSystem__GFXControl
	arm_func_end ovl05_2155520

	arm_func_start ovl05_2155578
ovl05_2155578: // 0x02155578
	ldr r3, _021555B8 // =VRAMSystem__GFXControl
	mov r2, #1
	ldr r3, [r3, r0, lsl #2]
	mov r0, #0
	strb r0, [r3, #0x11]
	strb r0, [r3, #0x10]
	strb r0, [r3, #0x15]
	strb r0, [r3, #0x14]
	strb r0, [r3, #0x18]
	mvn r0, r2, lsl r1
	ldrb r1, [r3, #0x1a]
	and r0, r0, #0xff
	and r0, r1, r0
	strb r0, [r3, #0x1a]
	str r2, [r3, #0x1c]
	bx lr
	.align 2, 0
_021555B8: .word VRAMSystem__GFXControl
	arm_func_end ovl05_2155578

	arm_func_start ovl05_21555BC
ovl05_21555BC: // 0x021555BC
	ldr r3, _021555FC // =VRAMSystem__GFXControl
	mov r2, #1
	ldr r3, [r3, r0, lsl #2]
	mov r0, #0
	strb r0, [r3, #0x11]
	strb r0, [r3, #0x10]
	strb r0, [r3, #0x15]
	strb r0, [r3, #0x14]
	strb r0, [r3, #0x18]
	mov r0, r2, lsl r1
	ldrb r1, [r3, #0x1a]
	and r0, r0, #0xff
	orr r0, r1, r0
	strb r0, [r3, #0x1a]
	str r2, [r3, #0x1c]
	bx lr
	.align 2, 0
_021555FC: .word VRAMSystem__GFXControl
	arm_func_end ovl05_21555BC

	arm_func_start ovl05_2155600
ovl05_2155600: // 0x02155600
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r1, #0
	bl ovl05_21554D4
	mov r0, r4
	mov r1, #0
	bl ovl05_2155244
	mov r1, #0
	mov ip, #0x1f8
	mov r0, r4
	mov r2, r1
	mov r3, #0x40
	str ip, [sp]
	bl ovl05_21553DC
	ldr r1, _02155698 // =0x00000638
	mov r0, r4
	str r1, [sp]
	mov r1, #1
	mov r2, #0
	mov r3, #0x40
	bl ovl05_21553DC
	ldr r0, [r4, #0x14]
	tst r0, #4
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, pc}
	bic r2, r0, #4
	mov r0, #0
	mov r1, #3
	str r2, [r4, #0x14]
	bl ovl05_2155578
	mov r0, #1
	mov r1, #3
	bl ovl05_21555BC
	ldr r0, _0215569C // =ovl05_21556A0
	str r0, [r4, #0x10]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02155698: .word 0x00000638
_0215569C: .word ovl05_21556A0
	arm_func_end ovl05_2155600

	arm_func_start ovl05_21556A0
ovl05_21556A0: // 0x021556A0
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	bl ovl05_21554D4
	mov r0, r4
	mov r1, #1
	bl ovl05_21554D4
	mov r0, r4
	mov r1, #0
	bl ovl05_2155244
	cmp r0, #0
	beq _021556FC
	ldr r1, [r4, #0x14]
	mov r0, #0
	bic r2, r1, #4
	mov r1, #2
	str r2, [r4, #0x14]
	bl ovl05_2155578
	mov r0, #1
	mov r1, #2
	bl ovl05_2155578
	ldr r0, _0215570C // =ovl05_2155710
	str r0, [r4, #0x10]
_021556FC:
	mov r0, r4
	mov r1, #1
	bl ovl05_2155244
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215570C: .word ovl05_2155710
	arm_func_end ovl05_21556A0

	arm_func_start ovl05_2155710
ovl05_2155710: // 0x02155710
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #1
	bl ovl05_21554D4
	mov r0, r4
	mov r1, #1
	bl ovl05_2155244
	ldr r0, [r4, #0x14]
	tst r0, #4
	ldmeqia sp!, {r4, pc}
	bic r2, r0, #4
	mov r0, r4
	mov r1, #2
	str r2, [r4, #0x14]
	bl ovl05_21553A8
	mov r0, #0
	mov r1, #2
	bl ovl05_2155578
	mov r0, #1
	mov r1, #2
	bl ovl05_21555BC
	ldr r0, _02155770 // =ovl05_2155774
	str r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155770: .word ovl05_2155774
	arm_func_end ovl05_2155710

	arm_func_start ovl05_2155774
ovl05_2155774: // 0x02155774
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #1
	bl ovl05_21554D4
	mov r0, r4
	mov r1, #2
	bl ovl05_21554D4
	mov r0, r4
	mov r1, #1
	bl ovl05_2155244
	cmp r0, #0
	beq _021557D0
	ldr r1, [r4, #0x14]
	mov r0, #0
	bic r2, r1, #4
	mov r1, #3
	str r2, [r4, #0x14]
	bl ovl05_2155578
	mov r0, #1
	mov r1, #3
	bl ovl05_2155578
	ldr r0, _021557E0 // =ovl05_21557E4
	str r0, [r4, #0x10]
_021557D0:
	mov r0, r4
	mov r1, #2
	bl ovl05_2155244
	ldmia sp!, {r4, pc}
	.align 2, 0
_021557E0: .word ovl05_21557E4
	arm_func_end ovl05_2155774

	arm_func_start ovl05_21557E4
ovl05_21557E4: // 0x021557E4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #2
	bl ovl05_21554D4
	mov r0, r4
	mov r1, #2
	bl ovl05_2155244
	ldr r0, [r4, #0x14]
	tst r0, #4
	ldmeqia sp!, {r4, pc}
	bic r2, r0, #4
	mov r0, r4
	mov r1, #3
	str r2, [r4, #0x14]
	bl ovl05_21553A8
	mov r0, #0
	mov r1, #3
	bl ovl05_2155578
	mov r0, #1
	mov r1, #3
	bl ovl05_21555BC
	ldr r0, _02155844 // =ovl05_2155848
	str r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155844: .word ovl05_2155848
	arm_func_end ovl05_21557E4

	arm_func_start ovl05_2155848
ovl05_2155848: // 0x02155848
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #2
	bl ovl05_21554D4
	mov r0, r4
	mov r1, #3
	bl ovl05_21554D4
	mov r0, r4
	mov r1, #2
	bl ovl05_2155244
	cmp r0, #0
	beq _021558A4
	ldr r1, [r4, #0x14]
	mov r0, #0
	bic r2, r1, #4
	mov r1, #2
	str r2, [r4, #0x14]
	bl ovl05_2155578
	mov r0, #1
	mov r1, #2
	bl ovl05_2155578
	ldr r0, _021558B4 // =ovl05_21558B8
	str r0, [r4, #0x10]
_021558A4:
	mov r0, r4
	mov r1, #3
	bl ovl05_2155244
	ldmia sp!, {r4, pc}
	.align 2, 0
_021558B4: .word ovl05_21558B8
	arm_func_end ovl05_2155848

	arm_func_start ovl05_21558B8
ovl05_21558B8: // 0x021558B8
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r2, [r4, #0x230]
	mov r1, #3
	sub r2, r2, #0xaf
	mov r2, r2, lsl #0x10
	mov r5, r2, asr #0x10
	bl ovl05_21554D4
	mov r0, r4
	mov r1, #2
	mov r2, #3
	mov r3, #0x80
	str r5, [sp]
	bl ovl05_21553DC
	mov r0, r4
	mov r1, #3
	bl ovl05_2155244
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r4, #0x14]
	ldr r0, _0215591C // =ovl05_2155920
	orr r1, r1, #8
	str r1, [r4, #0x14]
	str r0, [r4, #0x10]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215591C: .word ovl05_2155920
	arm_func_end ovl05_21558B8

	arm_func_start ovl05_2155920
ovl05_2155920: // 0x02155920
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	mov r2, r1
	add r3, r4, #0x400
	mov ip, #0x11
	add r0, r4, #0x410
	strh ip, [r3, #0x7a]
	bl AnimatorSpriteDS__ProcessAnimation
	add r0, r4, #0x410
	bl AnimatorSpriteDS__DrawFrame
	ldr r0, [r4, #0x14]
	tst r0, #0x10
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl05_215543C
	cmp r0, #0
	ldrne r0, [r4, #0x14]
	orrne r0, r0, #0x20
	strne r0, [r4, #0x14]
	ldmia sp!, {r4, pc}
	arm_func_end ovl05_2155920

    .data

aNarcDmsrLz7Nar: // 0x02173540
	.asciz "/narc/dmsr_lz7.narc"
	.align 4

aNarcTkdmLz7Nar_ovl05: // 0x02173554
	.asciz "/narc/tkdm_lz7.narc"
	.align 4

aFntFontAllFnt_2_ovl05: // 0x02173568
	.asciz "fnt/font_all.fnt"
	.align 4