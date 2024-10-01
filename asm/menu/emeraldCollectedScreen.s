	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
_02162E84: // 0x02162E84
    .space 0x04
	.align 4

EmeraldCollectedScreen__Singleton: // 0x02162E88
    .space 0x04 // Task*
	.align 4

	.text

	thumb_func_start EmeraldCollectedScreen__Create
EmeraldCollectedScreen__Create: // 0x02154ED4
	push {r3, r4, lr}
	sub sp, #0xc
	mov r0, #0x41
	str r0, [sp]
	mov r2, #0
	ldr r0, _02154F2C // =0x00001148
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02154F30 // =EmeraldCollectedScreen__Main_Core
	ldr r1, _02154F34 // =EmeraldCollectedScreen__Destructor
	mov r3, r2
	bl TaskCreate_
	ldr r1, _02154F38 // =_02162E84
	str r0, [r1, #4]
	bl GetTaskWork_
	mov r4, r0
	bl EmeraldCollectedScreen__Init
	mov r1, #0
	mov r0, #0x21
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02154F3C // =EmeraldCollectedScreen__Main_UpdateManager
	str r1, [sp, #8]
	mov r2, r1
	mov r3, r1
	bl TaskCreate_
	mov r1, #0
	str r0, [r4]
	mov r0, #0x81
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02154F40 // =EmeraldCollectedScreen__Main_DrawManager
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r4, #4]
	add sp, #0xc
	pop {r3, r4, pc}
	.align 2, 0
_02154F2C: .word 0x00001148
_02154F30: .word EmeraldCollectedScreen__Main_Core
_02154F34: .word EmeraldCollectedScreen__Destructor
_02154F38: .word _02162E84
_02154F3C: .word EmeraldCollectedScreen__Main_UpdateManager
_02154F40: .word EmeraldCollectedScreen__Main_DrawManager
	thumb_func_end EmeraldCollectedScreen__Create

	thumb_func_start EmeraldCollectedScreen__Destructor
EmeraldCollectedScreen__Destructor: // 0x02154F44
	ldr r0, _02154F4C // =_02162E84
	mov r1, #0
	str r1, [r0, #4]
	bx lr
	.align 2, 0
_02154F4C: .word _02162E84
	thumb_func_end EmeraldCollectedScreen__Destructor

	thumb_func_start EmeraldCollectedScreen__SetState
EmeraldCollectedScreen__SetState: // 0x02154F50
	mov r2, #0
	str r2, [r0, #0xc]
	str r1, [r0, #8]
	bx lr
	thumb_func_end EmeraldCollectedScreen__SetState

	thumb_func_start EmeraldCollectedScreen__SetupDisplay
EmeraldCollectedScreen__SetupDisplay: // 0x02154F58
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r2, #1
	lsl r2, r2, #0x1a
	ldr r1, [r2, #0]
	ldr r0, _021550B4 // =0xFFFFE0FF
	and r1, r0
	str r1, [r2]
	ldr r2, _021550B8 // =0x04001000
	ldr r1, [r2, #0]
	and r0, r1
	str r0, [r2]
	mov r0, #1
	mov r1, #0
	mov r2, r0
	bl GX_SetGraphicsMode
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r0, _021550BC // =renderCurrentDisplay
	mov r1, #0
	str r1, [r0]
	bl VRAMSystem__Reset
	mov r0, #8
	bl VRAMSystem__SetupTextureBank
	mov r0, #0x40
	bl VRAMSystem__SetupTexturePalBank
	mov r0, #1
	bl VRAMSystem__SetupBGBank
	mov r0, #1
	lsl r0, r0, #0xa
	str r0, [sp]
	ldr r1, _021550C0 // =0x00200010
	mov r0, #2
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupOBJBank
	mov r0, #0x10
	bl VRAMSystem__SetupBGExtPalBank
	mov r0, #0x20
	bl VRAMSystem__SetupOBJExtPalBank
	mov r0, #4
	bl VRAMSystem__SetupSubBGBank
	mov r0, #2
	lsl r0, r0, #8
	str r0, [sp]
	lsr r0, r0, #1
	mov r1, #0x10
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupSubOBJBank
	mov r0, #0x80
	bl VRAMSystem__SetupSubBGExtPalBank
	mov r0, #0
	bl VRAMSystem__SetupSubOBJExtPalBank
	ldr r0, _021550C4 // =0x04000008
	mov r5, #3
	ldrh r1, [r0, #0]
	mov r2, #1
	mov r3, #2
	bic r1, r5
	strh r1, [r0]
	ldrh r1, [r0, #2]
	mov r4, #3
	bic r1, r5
	orr r1, r2
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	bic r1, r5
	orr r1, r3
	strh r1, [r0, #4]
	ldrh r1, [r0, #6]
	bic r1, r5
	orr r1, r4
	strh r1, [r0, #6]
	ldr r1, _021550C8 // =0x04001008
	ldrh r6, [r1, #0]
	bic r6, r5
	strh r6, [r1]
	ldrh r6, [r1, #2]
	bic r6, r5
	orr r2, r6
	strh r2, [r1, #2]
	ldrh r2, [r1, #4]
	bic r2, r5
	orr r2, r3
	strh r2, [r1, #4]
	ldrh r2, [r1, #6]
	mov r3, #0
	bic r2, r5
	orr r2, r4
	strh r2, [r1, #6]
	ldr r2, _021550CC // =renderCoreGFXControlB
	mov r4, #0x43
	strh r3, [r2, #0xe]
	ldrh r3, [r2, #0xe]
	strh r3, [r2, #0xc]
	strh r3, [r2, #0xa]
	strh r3, [r2, #8]
	strh r3, [r2, #6]
	strh r3, [r2, #4]
	strh r3, [r2, #2]
	strh r3, [r2]
	ldr r2, _021550D0 // =renderCoreGFXControlA
	strh r3, [r2, #0xe]
	strh r3, [r2, #0xc]
	strh r3, [r2, #0xa]
	strh r3, [r2, #8]
	strh r3, [r2, #6]
	strh r3, [r2, #4]
	strh r3, [r2, #2]
	strh r3, [r2]
	ldrh r2, [r0, #4]
	mov r3, r2
	ldr r2, _021550D4 // =0x00000704
	and r3, r4
	orr r3, r2
	strh r3, [r0, #4]
	ldrh r3, [r0, #6]
	mov r5, r3
	mov r3, r2
	and r5, r4
	sub r3, #0xfc
	orr r3, r5
	strh r3, [r0, #6]
	ldrh r0, [r1, #6]
	mov r3, r0
	mov r0, r2
	and r3, r4
	add r0, #0x80
	orr r0, r3
	strh r0, [r1, #6]
	lsl r0, r2, #0x18
	mov r3, #0x1f
	ldr r2, [r0, #0]
	lsl r3, r3, #8
	and r2, r3
	lsr r6, r2, #8
	ldr r2, [r0, #0]
	ldr r4, _021550B4 // =0xFFFFE0FF
	mov r5, r2
	mov r2, #0x1d
	orr r2, r6
	and r5, r4
	lsl r2, r2, #8
	orr r2, r5
	sub r1, #8
	str r2, [r0]
	ldr r0, [r1, #0]
	and r0, r3
	lsr r3, r0, #8
	ldr r0, [r1, #0]
	mov r2, r0
	mov r0, #0x18
	orr r0, r3
	and r2, r4
	lsl r0, r0, #8
	orr r0, r2
	str r0, [r1]
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	nop
_021550B4: .word 0xFFFFE0FF
_021550B8: .word 0x04001000
_021550BC: .word renderCurrentDisplay
_021550C0: .word 0x00200010
_021550C4: .word 0x04000008
_021550C8: .word 0x04001008
_021550CC: .word renderCoreGFXControlB
_021550D0: .word renderCoreGFXControlA
_021550D4: .word 0x00000704
	thumb_func_end EmeraldCollectedScreen__SetupDisplay

	thumb_func_start EmeraldCollectedScreen__Init
EmeraldCollectedScreen__Init: // 0x021550D8
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r2, _02155128 // =0x00001148
	mov r0, #0
	mov r1, r5
	bl MIi_CpuClear32
	mov r0, r5
	add r0, #0x1c
	bl EmeraldCollectedScreen__InitEmeraldConfig
	bl EmeraldCollectedScreen__SetupDisplay
	mov r4, r5
	add r4, #0x14
	mov r0, r4
	bl EmeraldCollectedScreen__LoadArchives
	bl ReleaseAudioSystem
	bl AllocSndHandle
	ldr r1, _0215512C // =0x00001144
	str r0, [r5, r1]
	mov r0, #0x1b
	bl LoadSysSound
	mov r0, r5
	add r0, #0x1c
	mov r1, r4
	bl EmeraldCollectedScreen__InitGraphics
	bl ResetTouchInput
	ldr r1, _02155130 // =EmeraldCollectedScreen__State_21556EC
	mov r0, r5
	bl EmeraldCollectedScreen__SetState
	pop {r3, r4, r5, pc}
	nop
_02155128: .word 0x00001148
_0215512C: .word 0x00001144
_02155130: .word EmeraldCollectedScreen__State_21556EC
	thumb_func_end EmeraldCollectedScreen__Init

	thumb_func_start EmeraldCollectedScreen__Release
EmeraldCollectedScreen__Release: // 0x02155134
	push {r4, lr}
	mov r4, r0
	bl ReleaseTouchInput
	ldr r0, [r4, #0]
	bl DestroyTask
	ldr r0, [r4, #4]
	bl DestroyTask
	mov r0, r4
	add r0, #0x1c
	bl EmeraldCollectedScreen__ReleaseGraphics
	ldr r0, _02155174 // =0x00001144
	mov r1, #0
	ldr r0, [r4, r0]
	bl NNS_SndPlayerStopSeq
	ldr r0, _02155174 // =0x00001144
	ldr r0, [r4, r0]
	bl NNS_SndHandleReleaseSeq
	bl ReleaseSysSound
	add r4, #0x14
	mov r0, r4
	bl EmeraldCollectedScreen__ReleaseAssets
	bl DestroyCurrentTask
	pop {r4, pc}
	.align 2, 0
_02155174: .word 0x00001144
	thumb_func_end EmeraldCollectedScreen__Release

	thumb_func_start EmeraldCollectedScreen__LoadArchives
EmeraldCollectedScreen__LoadArchives: // 0x02155178
	push {r3, r4, lr}
	sub sp, #4
	mov r2, #0
	mov r4, r0
	ldr r0, _021551A0 // =aNarcEmdmLz7Nar
	str r2, [sp]
	sub r1, r2, #1
	mov r3, #1
	bl ArchiveFile__Load
	str r0, [r4]
	ldr r0, _021551A4 // =aNarcActComBLz7_0
	mov r1, #9
	mov r2, #0
	bl ArchiveFileUnknown__LoadFileFromArchive
	str r0, [r4, #4]
	add sp, #4
	pop {r3, r4, pc}
	nop
_021551A0: .word aNarcEmdmLz7Nar
_021551A4: .word aNarcActComBLz7_0
	thumb_func_end EmeraldCollectedScreen__LoadArchives

	thumb_func_start EmeraldCollectedScreen__ReleaseAssets
EmeraldCollectedScreen__ReleaseAssets: // 0x021551A8
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0]
	bl _FreeHEAP_USER
	mov r0, #0
	mov r1, r4
	mov r2, #8
	bl MIi_CpuClear32
	pop {r4, pc}
	thumb_func_end EmeraldCollectedScreen__ReleaseAssets

	thumb_func_start EmeraldCollectedScreen__InitGraphics
EmeraldCollectedScreen__InitGraphics: // 0x021551C4
	push {r4, r5, r6, r7, lr}
	sub sp, #0xec
	str r0, [sp, #0x28]
	mov r0, #1
	str r0, [sp]
	add r0, sp, #0x44
	str r0, [sp, #4]
	mov r0, #8
	str r0, [sp, #8]
	add r0, sp, #0x48
	str r0, [sp, #0xc]
	mov r0, #9
	str r0, [sp, #0x10]
	add r0, sp, #0x4c
	str r0, [sp, #0x14]
	mov r0, #0xa
	str r0, [sp, #0x18]
	add r0, sp, #0x50
	str r0, [sp, #0x1c]
	mov r0, #0xb
	mov r4, r1
	str r0, [sp, #0x20]
	mov r2, #0
	str r2, [sp, #0x24]
	ldr r0, [r4, #0]
	add r1, sp, #0x30
	add r3, sp, #0x34
	bl LoadAssetsForStageClearEx
	bl EmeraldCollectedScreen__IsChaosEmeralds
	cmp r0, #0
	add r1, sp, #0x38
	beq _02155224
	mov r0, #3
	str r0, [sp]
	add r0, sp, #0x40
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	ldr r0, [r4, #0]
	mov r2, #2
	add r3, sp, #0x3c
	bl LoadAssetsForStageClearEx
	b _0215523E
_02155224:
	mov r0, #6
	str r0, [sp]
	add r0, sp, #0x40
	str r0, [sp, #4]
	mov r0, #7
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	ldr r0, [r4, #0]
	mov r2, #5
	add r3, sp, #0x3c
	bl LoadAssetsForStageClearEx
_0215523E:
	ldr r1, [sp, #0x38]
	mov r0, #3
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0xa4
	mov r2, #0x38
	mov r3, #1
	bl InitBackground
	add r0, sp, #0xa4
	bl DrawBackground
	ldr r1, [sp, #0x3c]
	mov r0, #2
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0xa4
	mov r2, #0x38
	mov r3, #0
	bl InitBackground
	add r0, sp, #0xa4
	bl DrawBackground
	mov r0, #3
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	ldr r1, [sp, #0x40]
	add r0, sp, #0xa4
	mov r2, #0x38
	mov r3, #0
	bl InitBackground
	add r0, sp, #0xa4
	bl DrawBackground
	ldr r4, [sp, #0x28]
	ldr r5, _021554C0 // =_0216156C
	mov r6, #0
	add r4, #8
_021552A0:
	ldrh r0, [r5, #0]
	ldrh r2, [r5, #2]
	lsl r1, r0, #2
	add r0, sp, #0x30
	ldr r7, [r0, r1]
	ldr r1, [r5, #4]
	mov r0, r7
	bl SpriteUnknown__Func_204C3CC
	ldr r1, [r5, #4]
	mov r3, #2
	str r1, [sp]
	str r0, [sp, #4]
	ldrb r0, [r5, #0xc]
	mov r1, r7
	lsl r3, r3, #0xa
	str r0, [sp, #8]
	ldrb r0, [r5, #0xd]
	str r0, [sp, #0xc]
	ldrb r0, [r5, #0xe]
	str r0, [sp, #0x10]
	ldrh r2, [r5, #2]
	mov r0, r4
	bl SpriteUnknown__Func_204C90C
	ldr r0, [r5, #8]
	mov r1, #0
	str r0, [r4, #8]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	add r4, #0x64
	add r5, #0x10
	cmp r6, #7
	blo _021552A0
	bl EmeraldCollectedScreen__IsChaosEmeralds
	cmp r0, #0
	beq _021552F8
	ldr r0, _021554C4 // =_021615DC
	str r0, [sp, #0x2c]
	b _021552FC
_021552F8:
	ldr r0, _021554C8 // =_0216166C
	str r0, [sp, #0x2c]
_021552FC:
	mov r1, #0xb1
	ldr r0, [sp, #0x28]
	lsl r1, r1, #2
	mov r6, #7
	add r5, r0, r1
_02155306:
	sub r0, r6, #7
	lsl r1, r0, #4
	ldr r0, [sp, #0x2c]
	add r4, r0, r1
	ldrh r0, [r0, r1]
	ldrh r2, [r4, #2]
	lsl r1, r0, #2
	add r0, sp, #0x30
	ldr r7, [r0, r1]
	ldr r1, [r4, #4]
	mov r0, r7
	bl SpriteUnknown__Func_204C3CC
	ldr r1, [r4, #4]
	mov r3, #2
	str r1, [sp]
	str r0, [sp, #4]
	ldrb r0, [r4, #0xc]
	mov r1, r7
	lsl r3, r3, #0xa
	str r0, [sp, #8]
	ldrb r0, [r4, #0xd]
	str r0, [sp, #0xc]
	ldrb r0, [r4, #0xe]
	str r0, [sp, #0x10]
	ldrh r2, [r4, #2]
	mov r0, r5
	bl SpriteUnknown__Func_204C90C
	ldr r0, [r4, #8]
	mov r1, #0
	str r0, [r5, #8]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	add r5, #0x64
	cmp r6, #0x10
	blo _02155306
	ldr r1, [sp, #0x28]
	mov r5, #0
	mov r3, #1
	mov r7, #0xaf
	mov r4, r5
	add r1, #8
	lsl r7, r7, #2
	mov r0, r3
_02155366:
	ldr r6, [sp, #0x28]
	mov r2, r3
	ldrh r6, [r6, #4]
	lsl r2, r5
	tst r2, r6
	bne _0215537C
	add r2, r4, r7
	add r2, r1, r2
	ldr r6, [r2, #0x3c]
	orr r6, r0
	str r6, [r2, #0x3c]
_0215537C:
	add r5, r5, #1
	add r4, #0x64
	cmp r5, #7
	blo _02155366
	ldr r0, [sp, #0x50]
	ldr r1, _021554CC // =0x001FFFFF
	bl LoadDrawState
	mov r0, #0
	add r1, sp, #0x54
	mov r2, #0x50
	bl MIi_CpuClear16
	ldr r0, [sp, #0x50]
	add r1, sp, #0x54
	bl GetDrawStateCameraView
	ldr r0, [sp, #0x50]
	add r1, sp, #0x54
	bl GetDrawStateCameraProjection
	bl EmeraldCollectedScreen__IsChaosEmeralds
	cmp r0, #0
	beq _021553D2
	mov r2, #0x69
	ldr r0, [sp, #0x64]
	mvn r2, r2
	mov r3, r2
	asr r1, r0, #0x1f
	add r3, #0x69
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	str r1, [sp, #0x6c]
	b _021553F4
_021553D2:
	mov r2, #0xd4
	ldr r0, [sp, #0x64]
	mvn r2, r2
	mov r3, r2
	asr r1, r0, #0x1f
	add r3, #0xd4
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	str r1, [sp, #0x6c]
_021553F4:
	mov r0, #0
	str r0, [sp, #0x68]
	add r0, sp, #0x54
	bl Camera3D__LoadState
	ldr r2, [sp, #0x44]
	ldr r1, _021554D0 // =0x0000078C
	ldr r0, [sp, #0x28]
	str r2, [r0, r1]
	ldr r0, [r0, r1]
	bl NNS_G3dResDefaultSetup
	ldr r1, _021554D4 // =0x00000648
	ldr r0, [sp, #0x28]
	add r4, r0, r1
	mov r0, r4
	mov r1, #0
	bl AnimatorMDL__Init
	ldr r0, [sp, #0x28]
	mov r1, #6
	ldrsh r5, [r0, r1]
	bl EmeraldCollectedScreen__IsChaosEmeralds
	cmp r0, #0
	beq _02155438
	mov r3, #0
	str r3, [sp]
	ldr r1, [sp, #0x44]
	mov r0, r4
	mov r2, r5
	bl AnimatorMDL__SetResource
	b _02155446
_02155438:
	mov r3, #0
	str r3, [sp]
	ldr r1, [sp, #0x44]
	mov r0, r4
	add r2, r5, #7
	bl AnimatorMDL__SetResource
_02155446:
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [r4, #0x20]
	str r0, [r4, #0x1c]
	str r0, [r4, #0x18]
	mov r1, #0
	str r1, [sp]
	ldr r2, [sp, #0x48]
	mov r0, r4
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	mov r0, #0
	str r0, [sp]
	ldr r2, [sp, #0x4c]
	mov r0, r4
	mov r1, #1
	mov r3, r5
	bl AnimatorMDL__SetAnimation
	mov r0, #0x43
	lsl r0, r0, #2
	ldrh r1, [r4, r0]
	mov r2, #1
	orr r1, r2
	strh r1, [r4, r0]
	add r1, r0, #2
	ldrh r1, [r4, r1]
	add r0, r0, #2
	orr r1, r2
	strh r1, [r4, r0]
	mov r0, #0
	str r0, [r4, #0x48]
	str r0, [r4, #0x4c]
	str r0, [r4, #0x50]
	ldr r0, [r4, #4]
	orr r0, r2
	str r0, [r4, #4]
	mov r0, r4
	bl AnimatorMDL__ProcessAnimation
	mov r0, #4
	strb r0, [r4, #0xa]
	mov r0, #3
	add r4, #0x90
	str r0, [sp]
	ldr r1, _021554D8 // =EmeraldCollectedScreen__RenderCallback
	mov r0, r4
	mov r2, #0
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	ldr r1, _021554DC // =0x000007A8
	ldr r0, [sp, #0x28]
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl EmeraldCollectedScreen__InitSparkles
	add sp, #0xec
	pop {r4, r5, r6, r7, pc}
	nop
_021554C0: .word _0216156C
_021554C4: .word _021615DC
_021554C8: .word _0216166C
_021554CC: .word 0x001FFFFF
_021554D0: .word 0x0000078C
_021554D4: .word 0x00000648
_021554D8: .word EmeraldCollectedScreen__RenderCallback
_021554DC: .word 0x000007A8
	thumb_func_end EmeraldCollectedScreen__InitGraphics

	thumb_func_start EmeraldCollectedScreen__ReleaseGraphics
EmeraldCollectedScreen__ReleaseGraphics: // 0x021554E0
	push {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, _02155528 // =0x000007A8
	add r0, r6, r0
	bl EmeraldCollectedScreen__ReleaseSparkles
	ldr r0, _0215552C // =0x00000648
	mov r5, r6
	add r5, #8
	add r4, r6, r0
	cmp r5, r4
	beq _02155504
_021554F8:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _021554F8
_02155504:
	ldr r0, _0215552C // =0x00000648
	add r0, r6, r0
	add r0, #0x90
	bl NNS_G3dRenderObjResetCallBack
	ldr r0, _0215552C // =0x00000648
	ldr r1, _02155530 // =0x0000078C
	add r0, r6, r0
	add r1, r6, r1
	cmp r0, r1
	beq _0215551E
	bl AnimatorMDL__Release
_0215551E:
	ldr r0, _02155530 // =0x0000078C
	ldr r0, [r6, r0]
	bl NNS_G3dResDefaultRelease
	pop {r4, r5, r6, pc}
	.align 2, 0
_02155528: .word 0x000007A8
_0215552C: .word 0x00000648
_02155530: .word 0x0000078C
	thumb_func_end EmeraldCollectedScreen__ReleaseGraphics

	thumb_func_start EmeraldCollectedScreen__HandleUpdating
EmeraldCollectedScreen__HandleUpdating: // 0x02155534
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	add r7, #0x1c
	ldr r0, _02155650 // =0x000007A8
	mov r5, r7
	add r4, r7, r0
	ldr r0, _02155654 // =renderCoreGFXControlA
	add r5, #8
	ldrh r1, [r0, #8]
	sub r1, r1, #2
	strh r1, [r0, #8]
	ldrh r1, [r0, #0xc]
	add r1, r1, #2
	strh r1, [r0, #0xc]
	ldr r0, _02155658 // =0x00000648
	add r6, r7, r0
	cmp r5, r6
	beq _02155568
_02155558:
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r5, #0x64
	cmp r5, r6
	bne _02155558
_02155568:
	ldr r0, _02155658 // =0x00000648
	ldr r1, _0215565C // =0x0000078C
	add r0, r7, r0
	add r1, r7, r1
	cmp r0, r1
	beq _02155578
	bl AnimatorMDL__ProcessAnimation
_02155578:
	ldr r1, _02155660 // =0x0000079C
	ldr r0, [r7, r1]
	lsl r2, r0, #0xc
	ldr r0, _02155664 // =0x00000964
	str r2, [r4, r0]
	add r2, r1, #4
	ldr r2, [r7, r2]
	lsl r3, r2, #0xc
	add r2, r0, #4
	str r3, [r4, r2]
	mov r2, r1
	mov r3, r0
	add r2, #0x64
	add r3, #0x14
	add r1, #8
	str r2, [r4, r3]
	ldr r3, [r7, r1]
	ldr r1, _02155668 // =0x00163000
	cmp r3, r1
	ble _021555BC
	mov r2, #2
	mov r1, r0
	lsl r2, r2, #0xc
	add r1, #0x10
	str r2, [r4, r1]
	mov r1, r0
	lsr r2, r2, #1
	add r1, #0x14
	str r2, [r4, r1]
	mov r1, #0xf
	lsl r1, r1, #0xe
	add r0, #0x18
	str r1, [r4, r0]
	b _02155648
_021555BC:
	mov r1, #0x55
	lsl r1, r1, #0xe
	cmp r3, r1
	bge _021555DC
	mov r3, #1
	mov r1, r0
	lsl r3, r3, #0xc
	add r1, #0x10
	str r3, [r4, r1]
	mov r1, r0
	add r1, #0x14
	str r2, [r4, r1]
	lsl r1, r3, #1
	add r0, #0x18
	str r1, [r4, r0]
	b _02155648
_021555DC:
	sub r0, r3, r1
	mov r1, #0xf
	bl _s32_div_f
	cmp r0, #0
	bge _021555EC
	mov r0, #0
	b _021555F6
_021555EC:
	mov r1, #1
	lsl r1, r1, #0xc
	cmp r0, r1
	ble _021555F6
	mov r0, r1
_021555F6:
	mov r1, #1
	lsl r1, r1, #0xc
	add r6, r0, r1
	ldr r0, _0215566C // =0x00000974
	asr r5, r6, #0x1f
	str r6, [r4, r0]
	lsr r0, r6, #0x15
	lsl r3, r5, #0xb
	orr r3, r0
	lsl r2, r6, #0xb
	mov r7, #0
	lsr r0, r1, #1
	add r0, r2, r0
	adc r3, r7
	lsl r2, r3, #0x14
	lsr r0, r0, #0xc
	orr r0, r2
	lsr r1, r1, #1
	add r1, r0, r1
	ldr r0, _0215566C // =0x00000974
	mov r2, #0x3a
	add r0, r0, #4
	str r1, [r4, r0]
	mov r0, r6
	mov r1, r5
	lsl r2, r2, #0xc
	mov r3, r7
	bl _ull_mul
	mov r2, #2
	mov r3, r7
	lsl r2, r2, #0xa
	add r5, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r5, #0xc
	orr r1, r0
	lsl r0, r2, #2
	add r1, r1, r0
	ldr r0, _02155670 // =0x0000097C
	str r1, [r4, r0]
_02155648:
	mov r0, r4
	bl EmeraldCollectedScreen__ProcessSparkles
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02155650: .word 0x000007A8
_02155654: .word renderCoreGFXControlA
_02155658: .word 0x00000648
_0215565C: .word 0x0000078C
_02155660: .word 0x0000079C
_02155664: .word 0x00000964
_02155668: .word 0x00163000
_0215566C: .word 0x00000974
_02155670: .word 0x0000097C
	thumb_func_end EmeraldCollectedScreen__HandleUpdating

	thumb_func_start EmeraldCollectedScreen__HandleDrawing
EmeraldCollectedScreen__HandleDrawing: // 0x02155674
	push {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	add r4, #0x1c
	mov r0, #0x16
	mov r5, r4
	lsl r0, r0, #6
	add r5, #8
	add r6, r4, r0
	cmp r5, r6
	beq _02155694
_02155688:
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	add r5, #0x64
	cmp r5, r6
	bne _02155688
_02155694:
	ldr r5, _021556D8 // =_0216156C
	mov r6, #0
	mov r7, #1
_0215569A:
	mov r1, r7
	ldrh r0, [r4, #4]
	lsl r1, r6
	tst r0, r1
	beq _021556A8
	ldr r0, _021556DC // =0x000005E4
	b _021556AC
_021556A8:
	mov r0, #0x16
	lsl r0, r0, #6
_021556AC:
	ldr r1, [r5, #8]
	add r0, r4, r0
	str r1, [r0, #8]
	bl AnimatorSprite__DrawFrame
	add r6, r6, #1
	add r5, #0x10
	cmp r6, #7
	blo _0215569A
	ldr r0, _021556E0 // =0x00000648
	ldr r1, _021556E4 // =0x0000078C
	add r0, r4, r0
	add r1, r4, r1
	cmp r0, r1
	beq _021556CE
	bl AnimatorMDL__Draw
_021556CE:
	ldr r0, _021556E8 // =0x000007A8
	add r0, r4, r0
	bl EmeraldCollectedScreen__DrawSparkles
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021556D8: .word _0216156C
_021556DC: .word 0x000005E4
_021556E0: .word 0x00000648
_021556E4: .word 0x0000078C
_021556E8: .word 0x000007A8
	thumb_func_end EmeraldCollectedScreen__HandleDrawing

	thumb_func_start EmeraldCollectedScreen__State_21556EC
EmeraldCollectedScreen__State_21556EC: // 0x021556EC
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x10]
	mov r2, #3
	orr r0, r2
	str r0, [r4, #0x10]
	ldr r1, _02155728 // =0x0213D300
	mov r0, #0x18
	ldrsh r0, [r1, r0]
	cmp r0, #0
	beq _02155714
	bge _02155706
	mov r2, #2
_02155706:
	lsl r0, r2, #0x10
	mov r1, #1
	lsr r0, r0, #0x10
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	b _0215571C
_02155714:
	mov r0, #2
	lsl r1, r0, #0xb
	bl CreateDrawFadeTask
_0215571C:
	ldr r1, _0215572C // =EmeraldCollectedScreen__State_2155730
	mov r0, r4
	bl EmeraldCollectedScreen__SetState
	pop {r4, pc}
	nop
_02155728: .word 0x0213D300
_0215572C: .word EmeraldCollectedScreen__State_2155730
	thumb_func_end EmeraldCollectedScreen__State_21556EC

	thumb_func_start EmeraldCollectedScreen__State_2155730
EmeraldCollectedScreen__State_2155730: // 0x02155730
	push {r4, lr}
	sub sp, #8
	mov r4, r0
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _02155764
	mov r0, #0x26
	mov r1, #0
	bl PlaySysTrack
	mov r0, #0x24
	str r0, [sp]
	mov r1, #0
	str r1, [sp, #4]
	sub r1, r1, #1
	ldr r0, _02155768 // =0x00001144
	mov r2, r1
	ldr r0, [r4, r0]
	mov r3, r1
	bl PlaySfxEx
	ldr r1, _0215576C // =EmeraldCollectedScreen__State_2155770
	mov r0, r4
	bl EmeraldCollectedScreen__SetState
_02155764:
	add sp, #8
	pop {r4, pc}
	.align 2, 0
_02155768: .word 0x00001144
_0215576C: .word EmeraldCollectedScreen__State_2155770
	thumb_func_end EmeraldCollectedScreen__State_2155730

	thumb_func_start EmeraldCollectedScreen__State_2155770
EmeraldCollectedScreen__State_2155770: // 0x02155770
	push {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, [r4, #0xc]
	cmp r0, #0x10
	bls _021557AC
	mov r1, r4
	ldr r0, _021557B0 // =0x00000648
	add r1, #0x1c
	add r0, r1, r0
	ldr r2, [r0, #4]
	mov r5, #1
	bic r2, r5
	str r2, [r0, #4]
	ldr r2, _021557B4 // =0x0000010E
	ldrh r3, [r0, r2]
	bic r3, r5
	strh r3, [r0, r2]
	sub r3, r2, #2
	ldrh r3, [r0, r3]
	sub r2, r2, #2
	bic r3, r5
	strh r3, [r0, r2]
	ldr r0, _021557B8 // =0x000007A8
	add r0, r1, r0
	bl EmeraldCollectedScreen__EnableSparkles
	ldr r1, _021557BC // =EmeraldCollectedScreen__State_21557C0
	mov r0, r4
	bl EmeraldCollectedScreen__SetState
_021557AC:
	pop {r3, r4, r5, pc}
	nop
_021557B0: .word 0x00000648
_021557B4: .word 0x0000010E
_021557B8: .word 0x000007A8
_021557BC: .word EmeraldCollectedScreen__State_21557C0
	thumb_func_end EmeraldCollectedScreen__State_2155770

	thumb_func_start EmeraldCollectedScreen__State_21557C0
EmeraldCollectedScreen__State_21557C0: // 0x021557C0
	push {r4, lr}
	ldr r2, _02155804 // =padInput
	ldr r1, _02155808 // =0x00000664
	ldrh r3, [r2, #4]
	mov r2, #1
	add r1, r0, r1
	tst r2, r3
	bne _021557DA
	ldr r2, _0215580C // =touchInput
	ldrh r3, [r2, #0x12]
	mov r2, #4
	tst r2, r3
	beq _021557E2
_021557DA:
	ldr r1, _02155810 // =EmeraldCollectedScreen__State_2155974
	bl EmeraldCollectedScreen__SetState
	pop {r4, pc}
_021557E2:
	ldr r2, [r1, #4]
	mov r4, #1
	bic r2, r4
	str r2, [r1, #4]
	ldr r2, _02155814 // =0x0000010E
	ldrh r3, [r1, r2]
	bic r3, r4
	strh r3, [r1, r2]
	sub r3, r2, #2
	ldrh r3, [r1, r3]
	sub r2, r2, #2
	bic r3, r4
	strh r3, [r1, r2]
	ldr r1, _02155818 // =EmeraldCollectedScreen__State_215581C
	bl EmeraldCollectedScreen__SetState
	pop {r4, pc}
	.align 2, 0
_02155804: .word padInput
_02155808: .word 0x00000664
_0215580C: .word touchInput
_02155810: .word EmeraldCollectedScreen__State_2155974
_02155814: .word 0x0000010E
_02155818: .word EmeraldCollectedScreen__State_215581C
	thumb_func_end EmeraldCollectedScreen__State_21557C0

	thumb_func_start EmeraldCollectedScreen__State_215581C
EmeraldCollectedScreen__State_215581C: // 0x0215581C
	push {r3, lr}
	ldr r1, _02155848 // =padInput
	ldrh r2, [r1, #4]
	mov r1, #1
	tst r1, r2
	bne _02155832
	ldr r1, _0215584C // =touchInput
	ldrh r2, [r1, #0x12]
	mov r1, #4
	tst r1, r2
	beq _0215583A
_02155832:
	ldr r1, _02155850 // =EmeraldCollectedScreen__State_2155974
	bl EmeraldCollectedScreen__SetState
	pop {r3, pc}
_0215583A:
	ldr r1, [r0, #0xc]
	cmp r1, #0x96
	bls _02155846
	ldr r1, _02155854 // =EmeraldCollectedScreen__State_2155858
	bl EmeraldCollectedScreen__SetState
_02155846:
	pop {r3, pc}
	.align 2, 0
_02155848: .word padInput
_0215584C: .word touchInput
_02155850: .word EmeraldCollectedScreen__State_2155974
_02155854: .word EmeraldCollectedScreen__State_2155858
	thumb_func_end EmeraldCollectedScreen__State_215581C

	thumb_func_start EmeraldCollectedScreen__State_2155858
EmeraldCollectedScreen__State_2155858: // 0x02155858
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x14]
	mov r4, r5
	add r1, sp, #0
	mov r2, #9
	mov r3, #0
	add r4, #0x1c
	bl LoadAssetsForStageClearEx
	ldr r0, _021558CC // =padInput
	ldrh r1, [r0, #4]
	mov r0, #1
	tst r0, r1
	bne _02155880
	ldr r0, _021558D0 // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #4
	tst r0, r1
	beq _0215588A
_02155880:
	ldr r1, _021558D4 // =EmeraldCollectedScreen__State_2155974
	mov r0, r5
	bl EmeraldCollectedScreen__SetState
	pop {r3, r4, r5, pc}
_0215588A:
	mov r0, #6
	ldrsh r0, [r4, r0]
	mov r3, #0x62
	ldr r1, _021558D8 // =_0216156C
	lsl r0, r0, #4
	add r1, r1, r0
	mov r2, #8
	ldrsh r2, [r1, r2]
	mov r0, #0x79
	lsl r0, r0, #4
	sub r2, #0x80
	add r0, r4, r0
	mov r4, r2
	lsl r3, r3, #2
	mul r4, r3
	add r4, #0x80
	str r4, [r0]
	mov r2, #0xa
	ldrsh r1, [r1, r2]
	sub r1, #0x60
	neg r1, r1
	mov r2, r1
	mul r2, r3
	add r2, #0x60
	ldr r1, _021558DC // =0xFFFFB000
	str r2, [r0, #4]
	str r1, [r0, #8]
	ldr r1, _021558E0 // =EmeraldCollectedScreen__State_21558E4
	mov r0, r5
	bl EmeraldCollectedScreen__SetState
	pop {r3, r4, r5, pc}
	nop
_021558CC: .word padInput
_021558D0: .word touchInput
_021558D4: .word EmeraldCollectedScreen__State_2155974
_021558D8: .word _0216156C
_021558DC: .word 0xFFFFB000
_021558E0: .word EmeraldCollectedScreen__State_21558E4
	thumb_func_end EmeraldCollectedScreen__State_2155858

	thumb_func_start EmeraldCollectedScreen__State_21558E4
EmeraldCollectedScreen__State_21558E4: // 0x021558E4
	push {r4, r5, r6, lr}
	sub sp, #0x10
	mov r5, r0
	mov r6, r5
	ldr r0, _02155960 // =0x00000648
	add r6, #0x1c
	add r4, r6, r0
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	ldr r0, [r5, #0xc]
	mov r1, #0xbe
	lsl r0, r0, #0xc
	bl _u32_div_f
	lsl r0, r0, #0x10
	asr r3, r0, #0x10
	mov r0, #1
	lsl r0, r0, #0xc
	cmp r3, r0
	ble _02155912
	mov r3, r0
_02155912:
	ldr r0, _02155964 // =0xFFFFF800
	mov r2, #0x79
	str r0, [sp]
	mov r0, r4
	lsl r2, r2, #4
	add r0, #0x48
	add r1, sp, #4
	add r2, r6, r2
	bl Task__Unknown204BE48__LerpVec3
	ldr r0, _02155968 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #1
	tst r0, r1
	bne _0215593A
	ldr r0, _0215596C // =touchInput
	mov r1, #4
	ldrh r0, [r0, #0x12]
	tst r0, r1
	beq _02155946
_0215593A:
	ldr r1, _02155970 // =EmeraldCollectedScreen__State_2155974
	mov r0, r5
	bl EmeraldCollectedScreen__SetState
	add sp, #0x10
	pop {r4, r5, r6, pc}
_02155946:
	mov r0, #0x43
	lsl r0, r0, #2
	ldrh r2, [r4, r0]
	lsl r0, r1, #0xd
	tst r0, r2
	beq _0215595A
	ldr r1, _02155970 // =EmeraldCollectedScreen__State_2155974
	mov r0, r5
	bl EmeraldCollectedScreen__SetState
_0215595A:
	add sp, #0x10
	pop {r4, r5, r6, pc}
	nop
_02155960: .word 0x00000648
_02155964: .word 0xFFFFF800
_02155968: .word padInput
_0215596C: .word touchInput
_02155970: .word EmeraldCollectedScreen__State_2155974
	thumb_func_end EmeraldCollectedScreen__State_21558E4

	thumb_func_start EmeraldCollectedScreen__State_2155974
EmeraldCollectedScreen__State_2155974: // 0x02155974
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	mov r4, r0
	mov r1, r4
	ldr r0, _021559F8 // =0x0000064C
	add r1, #0x1c
	ldr r2, [r1, r0]
	mov r7, #1
	orr r2, r7
	str r2, [r1, r0]
	mov r5, #6
	ldrsh r2, [r1, r5]
	mov r0, r1
	add r0, #8
	add r3, r2, #7
	mov r2, #0x64
	mul r2, r3
	add r6, r0, r2
	ldr r2, [r6, #0x3c]
	mov r3, #1
	bic r2, r3
	str r2, [r6, #0x3c]
	ldrsh r6, [r1, r5]
	mov r2, #0x64
	mul r2, r6
	add r2, r0, r2
	ldr r0, [r2, #0x3c]
	bic r0, r3
	str r0, [r2, #0x3c]
	ldrsh r0, [r1, r5]
	mov r2, r7
	ldrh r3, [r1, #4]
	lsl r2, r0
	mov r0, r3
	orr r0, r2
	strh r0, [r1, #4]
	ldr r0, _021559FC // =0x000007A8
	add r0, r1, r0
	bl EmeraldCollectedScreen__DisableSparkles
	mov r0, #3
	lsl r1, r7, #0xa
	bl CreateDrawFadeTask
	ldr r0, _02155A00 // =0x00001144
	mov r1, #0
	ldr r0, [r4, r0]
	bl NNS_SndPlayerStopSeq
	mov r0, #0x24
	str r0, [sp]
	mov r0, r7
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, _02155A04 // =EmeraldCollectedScreen__State_2155A08
	mov r0, r4
	bl EmeraldCollectedScreen__SetState
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021559F8: .word 0x0000064C
_021559FC: .word 0x000007A8
_02155A00: .word 0x00001144
_02155A04: .word EmeraldCollectedScreen__State_2155A08
	thumb_func_end EmeraldCollectedScreen__State_2155974

	thumb_func_start EmeraldCollectedScreen__State_2155A08
EmeraldCollectedScreen__State_2155A08: // 0x02155A08
	push {r4, lr}
	mov r4, r0
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _02155A1C
	ldr r1, _02155A20 // =EmeraldCollectedScreen__State_2155A24
	mov r0, r4
	bl EmeraldCollectedScreen__SetState
_02155A1C:
	pop {r4, pc}
	nop
_02155A20: .word EmeraldCollectedScreen__State_2155A24
	thumb_func_end EmeraldCollectedScreen__State_2155A08

	thumb_func_start EmeraldCollectedScreen__State_2155A24
EmeraldCollectedScreen__State_2155A24: // 0x02155A24
	push {r4, lr}
	sub sp, #8
	mov r4, r0
	ldr r0, _02155A70 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #1
	tst r0, r1
	bne _02155A3E
	ldr r0, _02155A74 // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #4
	tst r0, r1
	beq _02155A4A
_02155A3E:
	ldr r1, _02155A78 // =EmeraldCollectedScreen__State_2155B70
	mov r0, r4
	bl EmeraldCollectedScreen__SetState
	add sp, #8
	pop {r4, pc}
_02155A4A:
	ldr r0, [r4, #0xc]
	cmp r0, #0x20
	bls _02155A6C
	mov r0, #0x24
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, _02155A7C // =EmeraldCollectedScreen__State_2155A80
	mov r0, r4
	bl EmeraldCollectedScreen__SetState
_02155A6C:
	add sp, #8
	pop {r4, pc}
	.align 2, 0
_02155A70: .word padInput
_02155A74: .word touchInput
_02155A78: .word EmeraldCollectedScreen__State_2155B70
_02155A7C: .word EmeraldCollectedScreen__State_2155A80
	thumb_func_end EmeraldCollectedScreen__State_2155A24

	thumb_func_start EmeraldCollectedScreen__State_2155A80
EmeraldCollectedScreen__State_2155A80: // 0x02155A80
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x10
	mov r4, r0
	str r0, [sp]
	add r4, #0x1c
	bl EmeraldCollectedScreen__IsChaosEmeralds
	cmp r0, #0
	beq _02155A98
	ldr r0, _02155B2C // =_021615DC
	str r0, [sp, #4]
	b _02155A9C
_02155A98:
	ldr r0, _02155B30 // =_0216166C
	str r0, [sp, #4]
_02155A9C:
	mov r5, #0
	mov r7, #1
	mov r6, #0x21
	add r4, #8
_02155AA4:
	ldr r0, [sp]
	ldr r0, [r0, #0xc]
	cmp r0, r7
	bne _02155ADC
	mov r0, r5
	bl EmeraldCollectedScreen__GetEmeraldUnknown
	mov r1, r0
	add r0, r1, #7
	mov r2, #0x64
	mul r2, r0
	str r2, [sp, #8]
	add r0, r4, r2
	lsl r2, r1, #4
	ldr r1, [sp, #4]
	add r1, r1, r2
	ldrh r1, [r1, #2]
	add r1, #0xe
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	ldr r0, [sp, #8]
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
_02155ADC:
	ldr r0, [sp]
	ldr r0, [r0, #0xc]
	cmp r0, r6
	bne _02155B0E
	mov r0, r5
	bl EmeraldCollectedScreen__GetEmeraldUnknown
	mov r1, r0
	add r0, r1, #7
	mov r2, #0x64
	mul r2, r0
	str r2, [sp, #0xc]
	add r0, r4, r2
	lsl r2, r1, #4
	ldr r1, [sp, #4]
	add r1, r1, r2
	ldrh r1, [r1, #2]
	bl AnimatorSprite__SetAnimation
	ldr r0, [sp, #0xc]
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
_02155B0E:
	add r5, r5, #1
	add r7, r7, #4
	add r6, r6, #4
	cmp r5, #7
	blo _02155AA4
	ldr r0, [sp]
	ldr r0, [r0, #0xc]
	cmp r0, #0x3d
	bls _02155B28
	ldr r0, [sp]
	ldr r1, _02155B34 // =EmeraldCollectedScreen__State_2155B38
	bl EmeraldCollectedScreen__SetState
_02155B28:
	add sp, #0x10
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02155B2C: .word _021615DC
_02155B30: .word _0216166C
_02155B34: .word EmeraldCollectedScreen__State_2155B38
	thumb_func_end EmeraldCollectedScreen__State_2155A80

	thumb_func_start EmeraldCollectedScreen__State_2155B38
EmeraldCollectedScreen__State_2155B38: // 0x02155B38
	push {r3, lr}
	ldr r1, _02155B64 // =padInput
	ldrh r2, [r1, #4]
	mov r1, #1
	tst r1, r2
	bne _02155B4E
	ldr r1, _02155B68 // =touchInput
	ldrh r2, [r1, #0x12]
	mov r1, #4
	tst r1, r2
	beq _02155B56
_02155B4E:
	ldr r1, _02155B6C // =EmeraldCollectedScreen__State_2155B70
	bl EmeraldCollectedScreen__SetState
	pop {r3, pc}
_02155B56:
	ldr r1, [r0, #0xc]
	cmp r1, #0x78
	bls _02155B62
	ldr r1, _02155B6C // =EmeraldCollectedScreen__State_2155B70
	bl EmeraldCollectedScreen__SetState
_02155B62:
	pop {r3, pc}
	.align 2, 0
_02155B64: .word padInput
_02155B68: .word touchInput
_02155B6C: .word EmeraldCollectedScreen__State_2155B70
	thumb_func_end EmeraldCollectedScreen__State_2155B38

	thumb_func_start EmeraldCollectedScreen__State_2155B70
EmeraldCollectedScreen__State_2155B70: // 0x02155B70
	push {r4, lr}
	mov r4, r0
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	mov r0, #0xc
	bl FadeSysTrack
	ldr r1, _02155B8C // =EmeraldCollectedScreen__State_2155B90
	mov r0, r4
	bl EmeraldCollectedScreen__SetState
	pop {r4, pc}
	.align 2, 0
_02155B8C: .word EmeraldCollectedScreen__State_2155B90
	thumb_func_end EmeraldCollectedScreen__State_2155B70

	thumb_func_start EmeraldCollectedScreen__State_2155B90
EmeraldCollectedScreen__State_2155B90: // 0x02155B90
	push {r4, lr}
	mov r4, r0
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _02155BB0
	bl DestroyDrawFadeTask
	ldr r1, [r4, #0x10]
	mov r0, #3
	bic r1, r0
	str r1, [r4, #0x10]
	ldr r1, _02155BB4 // =EmeraldCollectedScreen__State_ChangeEvent
	mov r0, r4
	bl EmeraldCollectedScreen__SetState
_02155BB0:
	pop {r4, pc}
	nop
_02155BB4: .word EmeraldCollectedScreen__State_ChangeEvent
	thumb_func_end EmeraldCollectedScreen__State_2155B90

	thumb_func_start EmeraldCollectedScreen__State_ChangeEvent
EmeraldCollectedScreen__State_ChangeEvent: // 0x02155BB8
	push {r4, lr}
	mov r4, r0
	mov r0, #0x28
	bl RequestNewSysEventChange
	bl NextSysEvent
	mov r0, r4
	bl EmeraldCollectedScreen__Release
	pop {r4, pc}
	.align 2, 0
	thumb_func_end EmeraldCollectedScreen__State_ChangeEvent

	thumb_func_start EmeraldCollectedScreen__GetEmeraldUnknown
EmeraldCollectedScreen__GetEmeraldUnknown: // 0x02155BD0
	cmp r0, #6
	bhi _02155C0A
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02155BE0: // jump table
	.hword _02155BEE - _02155BE0 - 2 // case 0
	.hword _02155BF2 - _02155BE0 - 2 // case 1
	.hword _02155BF6 - _02155BE0 - 2 // case 2
	.hword _02155BFA - _02155BE0 - 2 // case 3
	.hword _02155BFE - _02155BE0 - 2 // case 4
	.hword _02155C02 - _02155BE0 - 2 // case 5
	.hword _02155C06 - _02155BE0 - 2 // case 6
_02155BEE:
	mov r0, #0
	bx lr
_02155BF2:
	mov r0, #2
	bx lr
_02155BF6:
	mov r0, #4
	bx lr
_02155BFA:
	mov r0, #6
	bx lr
_02155BFE:
	mov r0, #1
	bx lr
_02155C02:
	mov r0, #3
	bx lr
_02155C06:
	mov r0, #5
	bx lr
_02155C0A:
	mov r0, #0
	bx lr
	.align 2, 0
	thumb_func_end EmeraldCollectedScreen__GetEmeraldUnknown

	thumb_func_start EmeraldCollectedScreen__IsChaosEmeralds
EmeraldCollectedScreen__IsChaosEmeralds: // 0x02155C10
	push {r3, lr}
	ldr r0, _02155C20 // =_02162E84
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r0, [r0, #0x1c]
	pop {r3, pc}
	nop
_02155C20: .word _02162E84
	thumb_func_end EmeraldCollectedScreen__IsChaosEmeralds

	thumb_func_start EmeraldCollectedScreen__InitEmeraldConfig
EmeraldCollectedScreen__InitEmeraldConfig: // 0x02155C24
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r4, #0
	strh r4, [r5, #4]
	sub r0, r4, #1
	strh r0, [r5, #6]
	ldr r0, _02155CDC // =0x02139594
	ldr r7, _02155CE0 // =0x0213461C
	ldrb r0, [r0, #0x10]
	cmp r0, #0xff
	beq _02155C80
	mov r0, #1
	str r0, [r5]
	mov r6, r0
_02155C40:
	lsl r1, r4, #0x18
	mov r0, r7
	lsr r1, r1, #0x18
	bl SaveGame__HasChaosEmerald
	cmp r0, #0
	beq _02155C58
	mov r0, r6
	ldrh r1, [r5, #4]
	lsl r0, r4
	orr r0, r1
	strh r0, [r5, #4]
_02155C58:
	add r4, r4, #1
	cmp r4, #7
	blo _02155C40
	mov r1, #0x15
	ldr r0, _02155CE4 // =gameState
	lsl r1, r1, #4
	ldrb r0, [r0, r1]
	mov r2, #0xff
	strh r0, [r5, #6]
	ldr r0, _02155CE4 // =gameState
	strb r2, [r0, r1]
	mov r0, #6
	ldrsh r0, [r5, r0]
	mov r1, #1
	ldrh r2, [r5, #4]
	lsl r1, r0
	mvn r0, r1
	and r0, r2
	strh r0, [r5, #4]
	pop {r3, r4, r5, r6, r7, pc}
_02155C80:
	ldr r2, _02155CE8 // =0x00000151
	ldr r0, _02155CE4 // =gameState
	ldrb r0, [r0, r2]
	cmp r0, #0xff
	beq _02155CCC
	str r4, [r5]
	mov r6, #1
_02155C8E:
	lsl r1, r4, #0x18
	ldr r0, _02155CEC // =0x02134474
	lsr r1, r1, #0x18
	bl SaveGame__HasSolEmerald
	cmp r0, #0
	beq _02155CA6
	mov r0, r6
	ldrh r1, [r5, #4]
	lsl r0, r4
	orr r0, r1
	strh r0, [r5, #4]
_02155CA6:
	add r4, r4, #1
	cmp r4, #7
	blo _02155C8E
	ldr r1, _02155CE8 // =0x00000151
	ldr r0, _02155CE4 // =gameState
	mov r2, #0xff
	ldrb r0, [r0, r1]
	strh r0, [r5, #6]
	ldr r0, _02155CE4 // =gameState
	strb r2, [r0, r1]
	mov r0, #6
	ldrsh r0, [r5, r0]
	mov r1, #1
	ldrh r2, [r5, #4]
	lsl r1, r0
	mvn r0, r1
	and r0, r2
	strh r0, [r5, #4]
	pop {r3, r4, r5, r6, r7, pc}
_02155CCC:
	mov r3, #0xff
	mov r1, r3
	ldr r0, _02155CE4 // =gameState
	add r1, #0x51
	strb r3, [r0, r1]
	strb r3, [r0, r2]
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02155CDC: .word 0x02139594
_02155CE0: .word 0x0213461C
_02155CE4: .word gameState
_02155CE8: .word 0x00000151
_02155CEC: .word 0x02134474
	thumb_func_end EmeraldCollectedScreen__InitEmeraldConfig

	thumb_func_start EmeraldCollectedScreen__RenderCallback
EmeraldCollectedScreen__RenderCallback: // 0x02155CF0
	push {r3, r4, lr}
	sub sp, #0x44
	ldr r0, _02155D34 // =_02162E84
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	add r0, sp, #0x14
	mov r1, #0
	add r4, #0x1c
	bl NNS_G3dGetCurrentMtx
	ldr r0, [sp, #0x38]
	add r1, sp, #0
	str r0, [sp, #8]
	ldr r0, [sp, #0x3c]
	add r2, sp, #4
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x40]
	str r0, [sp, #0x10]
	add r0, sp, #8
	bl NNS_G3dWorldPosToScrPos
	ldr r0, [sp]
	ldr r1, _02155D38 // =0x0000079C
	str r0, [r4, r1]
	add r0, r1, #4
	ldr r2, [sp, #4]
	add r1, #8
	str r2, [r4, r0]
	ldr r0, [sp, #0x40]
	str r0, [r4, r1]
	add sp, #0x44
	pop {r3, r4, pc}
	.align 2, 0
_02155D34: .word _02162E84
_02155D38: .word 0x0000079C
	thumb_func_end EmeraldCollectedScreen__RenderCallback

	thumb_func_start EmeraldCollectedScreen__InitSparkles
EmeraldCollectedScreen__InitSparkles: // 0x02155D3C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r6, r1
	ldr r1, _02155DBC // =0x0000096C
	mov r5, r0
	mov r4, #0
	mov r2, #2
	str r4, [r5, r1]
	add r0, r1, #4
	str r4, [r5, r0]
	mov r0, r1
	lsl r2, r2, #0xa
	add r0, #0xc
	str r2, [r5, r0]
	lsl r0, r2, #2
	add r1, #0x10
	str r0, [r5, r1]
_02155D5E:
	mov r0, r4
	add r0, #0xb
	lsl r0, r0, #0x10
	lsr r7, r0, #0x10
	mov r0, r6
	mov r1, #0
	mov r2, r7
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r3, _02155DC0 // =0x00000A04
	mov r0, r5
	mov r1, r6
	mov r2, r7
	bl SpriteUnknown__Func_204C90C
	ldr r0, _02155DC4 // =_mt_math_rand
	ldr r1, [r0, #0]
	ldr r0, _02155DC8 // =0x00196225
	mov r2, r1
	mul r2, r0
	ldr r0, _02155DCC // =0x3C6EF35F
	add r1, r2, r0
	ldr r0, _02155DC4 // =_mt_math_rand
	mov r2, #0
	str r1, [r0]
	lsr r1, r1, #0x10
	lsl r1, r1, #0x10
	mov r0, r5
	lsr r1, r1, #0x10
	mov r3, r2
	bl AnimatorSprite__AnimateManual
	add r4, r4, #1
	add r5, #0x64
	cmp r4, #0xa
	blo _02155D5E
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	nop
_02155DBC: .word 0x0000096C
_02155DC0: .word 0x00000A04
_02155DC4: .word _mt_math_rand
_02155DC8: .word 0x00196225
_02155DCC: .word 0x3C6EF35F
	thumb_func_end EmeraldCollectedScreen__InitSparkles

	thumb_func_start EmeraldCollectedScreen__ReleaseSparkles
EmeraldCollectedScreen__ReleaseSparkles: // 0x02155DD0
	push {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #0xfa
	mov r5, r6
	lsl r0, r0, #2
	beq _02155DEA
	add r4, r6, r0
_02155DDE:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _02155DDE
_02155DEA:
	mov r0, #0x96
	mov r1, #0
	lsl r0, r0, #4
	str r1, [r6, r0]
	pop {r4, r5, r6, pc}
	thumb_func_end EmeraldCollectedScreen__ReleaseSparkles

	thumb_func_start EmeraldCollectedScreen__EnableSparkles
EmeraldCollectedScreen__EnableSparkles: // 0x02155DF4
	push {r3, r4, r5, r6, r7, lr}
	mov r1, #0xfa
	lsl r1, r1, #2
	ldr r4, _02155E6C // =_mt_math_rand
	ldr r7, _02155E70 // =0x3C6EF35F
	str r0, [sp]
	mov r6, #0
	add r5, r0, r1
_02155E04:
	ldr r1, [r4, #0]
	ldr r0, _02155E74 // =0x00196225
	mov r2, r1
	mul r2, r0
	ldr r0, _02155E70 // =0x3C6EF35F
	mov r1, #0xa
	add r0, r2, r0
	str r0, [r4]
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl _s32_div_f
	strb r1, [r5, #0x14]
	ldr r1, [r4, #0]
	ldr r0, _02155E74 // =0x00196225
	mov r2, r1
	mul r2, r0
	ldr r0, _02155E70 // =0x3C6EF35F
	mov r1, #0x32
	add r0, r2, r0
	str r0, [r4]
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl _s32_div_f
	add r0, r1, #1
	strb r0, [r5, #0x15]
	ldr r1, [r4, #0]
	ldr r0, _02155E74 // =0x00196225
	mul r0, r1
	add r0, r0, r7
	str r0, [r4]
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	mov r1, #0x30
	bl _s32_div_f
	strb r1, [r5, #0x16]
	add r6, r6, #1
	add r5, #0x1c
	cmp r6, #0x32
	blo _02155E04
	mov r1, #0x96
	ldr r0, [sp]
	mov r2, #1
	lsl r1, r1, #4
	str r2, [r0, r1]
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02155E6C: .word _mt_math_rand
_02155E70: .word 0x3C6EF35F
_02155E74: .word 0x00196225
	thumb_func_end EmeraldCollectedScreen__EnableSparkles

	thumb_func_start EmeraldCollectedScreen__DisableSparkles
EmeraldCollectedScreen__DisableSparkles: // 0x02155E78
	mov r1, #0x96
	mov r2, #0
	lsl r1, r1, #4
	str r2, [r0, r1]
	bx lr
	.align 2, 0
	thumb_func_end EmeraldCollectedScreen__DisableSparkles

	thumb_func_start EmeraldCollectedScreen__ProcessSparkles
EmeraldCollectedScreen__ProcessSparkles: // 0x02155E84
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r0, #0xfa
	lsl r0, r0, #2
	add r4, r5, r0
	mov r0, #0x96
	lsl r0, r0, #4
	add r0, r5, r0
	str r0, [sp]
	cmp r4, r0
	bne _02155E9C
	b _02156008
_02155E9C:
	ldr r6, _02156024 // =_mt_math_rand
_02155E9E:
	ldrb r1, [r4, #0x15]
	cmp r1, #0
	bne _02155EF6
	ldr r1, [r4, #0]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4]
	ldr r1, [r4, #4]
	ldr r0, [r4, #0xc]
	add r0, r1, r0
	str r0, [r4, #4]
	ldr r0, _02156028 // =0x0000096C
	ldr r1, [r4, #8]
	ldr r0, [r5, r0]
	add r0, r1, r0
	str r0, [r4, #8]
	mov r0, #0x97
	lsl r0, r0, #4
	ldr r1, [r4, #0xc]
	ldr r0, [r5, r0]
	add r0, r1, r0
	str r0, [r4, #0xc]
	ldrb r1, [r4, #0x16]
	sub r0, r1, #1
	strb r0, [r4, #0x16]
	cmp r1, #0
	beq _02155ED6
	b _02155FFE
_02155ED6:
	ldr r1, [r6, #0]
	ldr r0, _0215602C // =0x00196225
	mov r2, r1
	mul r2, r0
	ldr r0, _02156030 // =0x3C6EF35F
	mov r1, #0x32
	add r0, r2, r0
	str r0, [r6]
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl _s32_div_f
	add r0, r1, #1
	strb r0, [r4, #0x15]
	b _02155FFE
_02155EF6:
	mov r0, #0x96
	lsl r0, r0, #4
	ldr r0, [r5, r0]
	cmp r0, #0
	beq _02155FFE
	sub r0, r1, #1
	strb r0, [r4, #0x15]
	ldrb r0, [r4, #0x15]
	cmp r0, #0
	bne _02155FFE
	ldr r1, [r6, #0]
	ldr r0, _0215602C // =0x00196225
	mov r2, r1
	mul r2, r0
	ldr r0, _02156030 // =0x3C6EF35F
	add r0, r2, r0
	str r0, [r6]
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r7, r0, #0x10
	bl Task__Unknown204BE48__Rand
	ldr r1, [r6, #0]
	ldr r0, _0215602C // =0x00196225
	mov r2, r1
	mul r2, r0
	ldr r0, _02156030 // =0x3C6EF35F
	add r2, r2, r0
	str r2, [r6]
	ldr r0, _02156034 // =0x00000964
	lsr r2, r2, #0x10
	lsl r2, r2, #0x10
	ldr r1, [r5, r0]
	add r0, #0x18
	lsr r2, r2, #0x10
	lsl r2, r2, #0x10
	ldr r0, [r5, r0]
	asr r2, r2, #0x14
	mul r2, r0
	asr r0, r2, #0xc
	add r0, r1, r0
	str r0, [r4]
	ldr r1, [r6, #0]
	ldr r0, _0215602C // =0x00196225
	mov r2, r1
	mul r2, r0
	ldr r0, _02156030 // =0x3C6EF35F
	add r2, r2, r0
	str r2, [r6]
	ldr r0, _02156038 // =0x00000968
	lsr r2, r2, #0x10
	lsl r2, r2, #0x10
	ldr r1, [r5, r0]
	add r0, #0x14
	lsr r2, r2, #0x10
	lsl r2, r2, #0x10
	ldr r0, [r5, r0]
	asr r2, r2, #0x14
	mul r2, r0
	asr r0, r2, #0xc
	add r0, r1, r0
	str r0, [r4, #4]
	lsl r0, r7, #0x10
	lsr r0, r0, #0x10
	asr r0, r0, #4
	lsl r1, r0, #2
	ldr r0, _0215603C // =FX_SinCosTable_
	ldr r2, _02156040 // =0x00000978
	add r7, r0, r1
	ldrsh r0, [r0, r1]
	ldr r2, [r5, r2]
	asr r1, r0, #0x1f
	asr r3, r2, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r0, r0, r2
	ldr r2, _02156044 // =0x00000000
	adc r1, r2
	lsl r1, r1, #0x14
	lsr r0, r0, #0xc
	orr r0, r1
	str r0, [r4, #8]
	mov r0, #2
	ldr r2, _02156040 // =0x00000978
	ldrsh r0, [r7, r0]
	ldr r2, [r5, r2]
	asr r1, r0, #0x1f
	asr r3, r2, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _02156044 // =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	ldr r0, _02156048 // =0x00000974
	str r1, [r4, #0xc]
	ldr r0, [r5, r0]
	str r0, [r4, #0x10]
	ldr r1, [r6, #0]
	ldr r0, _0215602C // =0x00196225
	mov r2, r1
	mul r2, r0
	ldr r0, _02156030 // =0x3C6EF35F
	mov r1, #0xa
	add r0, r2, r0
	str r0, [r6]
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl _s32_div_f
	strb r1, [r4, #0x14]
	ldr r1, [r6, #0]
	ldr r0, _0215602C // =0x00196225
	mov r2, r1
	mul r2, r0
	ldr r0, _02156030 // =0x3C6EF35F
	mov r1, #0x30
	add r0, r2, r0
	str r0, [r6]
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl _s32_div_f
	strb r1, [r4, #0x16]
_02155FFE:
	ldr r0, [sp]
	add r4, #0x1c
	cmp r4, r0
	beq _02156008
	b _02155E9E
_02156008:
	mov r0, #0xfa
	lsl r0, r0, #2
	beq _02156022
	mov r6, #0
	add r4, r5, r0
_02156012:
	mov r0, r5
	mov r1, r6
	mov r2, r6
	bl AnimatorSprite__ProcessAnimation
	add r5, #0x64
	cmp r5, r4
	bne _02156012
_02156022:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02156024: .word _mt_math_rand
_02156028: .word 0x0000096C
_0215602C: .word 0x00196225
_02156030: .word 0x3C6EF35F
_02156034: .word 0x00000964
_02156038: .word 0x00000968
_0215603C: .word FX_SinCosTable_
_02156040: .word 0x00000978
_02156044: .word 0x00000000
_02156048: .word 0x00000974
	thumb_func_end EmeraldCollectedScreen__ProcessSparkles

	thumb_func_start EmeraldCollectedScreen__DrawSparkles
EmeraldCollectedScreen__DrawSparkles: // 0x0215604C
	push {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	mov r0, #0xfa
	lsl r0, r0, #2
	mov r4, #0
	add r5, r6, r0
	mov r7, #1
_0215605A:
	ldrb r0, [r5, #0x15]
	cmp r0, #0
	bne _0215609C
	ldrb r1, [r5, #0x14]
	mov r0, #0x64
	mul r0, r1
	ldr r1, [r5, #0]
	add r0, r6, r0
	asr r1, r1, #0xc
	strh r1, [r0, #8]
	ldr r1, [r5, #4]
	asr r1, r1, #0xc
	strh r1, [r0, #0xa]
	mov r1, r4
	tst r1, r7
	beq _02156080
	bl AnimatorSprite__DrawFrame
	b _0215609C
_02156080:
	mov r1, #1
	ldr r2, [r5, #0x10]
	lsl r1, r1, #0xc
	cmp r2, r1
	bgt _02156090
	bl AnimatorSprite__DrawFrame
	b _0215609C
_02156090:
	ldr r1, _021560A8 // =0x00000974
	mov r3, #0
	ldr r1, [r6, r1]
	mov r2, r1
	bl AnimatorSprite__DrawFrameRotoZoom
_0215609C:
	add r4, r4, #1
	add r5, #0x1c
	cmp r4, #0x32
	blo _0215605A
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021560A8: .word 0x00000974
	thumb_func_end EmeraldCollectedScreen__DrawSparkles

	thumb_func_start EmeraldCollectedScreen__Main_Core
EmeraldCollectedScreen__Main_Core: // 0x021560AC
	push {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0xc]
	add r1, r1, #1
	str r1, [r0, #0xc]
	ldr r1, [r0, #8]
	cmp r1, #0
	beq _021560C0
	blx r1
_021560C0:
	pop {r3, pc}
	.align 2, 0
	thumb_func_end EmeraldCollectedScreen__Main_Core

	thumb_func_start EmeraldCollectedScreen__Main_UpdateManager
EmeraldCollectedScreen__Main_UpdateManager: // 0x021560C4
	push {r3, lr}
	ldr r0, _021560DC // =_02162E84
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r2, [r0, #0x10]
	mov r1, #1
	tst r1, r2
	beq _021560DA
	bl EmeraldCollectedScreen__HandleUpdating
_021560DA:
	pop {r3, pc}
	.align 2, 0
_021560DC: .word _02162E84
	thumb_func_end EmeraldCollectedScreen__Main_UpdateManager

	thumb_func_start EmeraldCollectedScreen__Main_DrawManager
EmeraldCollectedScreen__Main_DrawManager: // 0x021560E0
	push {r3, lr}
	ldr r0, _021560F8 // =_02162E84
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r2, [r0, #0x10]
	mov r1, #2
	tst r1, r2
	beq _021560F6
	bl EmeraldCollectedScreen__HandleDrawing
_021560F6:
	pop {r3, pc}
	.align 2, 0
_021560F8: .word _02162E84
	thumb_func_end EmeraldCollectedScreen__Main_DrawManager

	.rodata
	
_0216156C: // 0x0216156C
    .hword 0
	
_0216156E: // 0x0216156E
    .hword 4
	
_02161570: // 0x02161570
    .word 0
	
_02161574: // 0x02161574
    .word 0x400020
	
_02161578: // 0x02161578
    .byte 0xA
	
_02161579: // 0x02161579
    .byte 2
	
_0216157A: // 0x0216157A
	.hword 0x1E, 0, 5, 0, 0, 0x40, 0x80, 0x20A, 0x1E, 0, 6, 0
	.hword 0, 0x60, 0x40, 0x20A, 0x1E, 0, 7, 0, 0, 0x80, 0x80
	.hword 0x20A, 0x1E, 0, 8, 0, 0, 0xA0, 0x40, 0x20B, 0x1E, 0
	.hword 9, 0, 0, 0xC0, 0x80, 0x20B, 0x1E, 0, 0xA, 0, 0, 0xE0
	.hword 0x40, 0x20B, 0x1E

_021615DC: // 0x021615DC
    .word 1, 0
	
_021615E4: // 0x021615E4
	.hword 0x10, 0x30, 0x201, 0xF, 1, 1, 0, 0, 0x30, 0x70, 0x202
	.hword 0xF, 1, 2, 0, 0, 0x50, 0x30, 0x203, 0xF, 1, 3, 0, 0
	.hword 0x70, 0x70, 0x204, 0xF, 1, 4, 0, 0, 0x90, 0x30, 0x205
	.hword 0xF, 1, 5, 0, 0, 0xB0, 0x70, 0x206, 0xF, 1, 6, 0, 0
	.hword 0xD0, 0x30, 0x207, 0xF, 0, 0, 0, 0, 0, 0, 0x208, 0x1F
	.hword 0, 1, 0, 0, 0, 0, 0x209, 0x1F

_0216166C: // 0x0216166C
	.hword 1, 7, 0, 0, 0x10, 0x30, 0x201, 0xF, 1, 8, 0, 0, 0x30
	.hword 0x70, 0x202, 0xF, 1, 9, 0, 0, 0x50, 0x30, 0x203, 0xF
	.hword 1, 0xA, 0, 0, 0x70, 0x70, 0x204, 0xF, 1, 0xB, 0, 0
	.hword 0x90, 0x30, 0x205, 0xF, 1, 0xC, 0, 0, 0xB0, 0x70, 0x206
	.hword 0xF, 1, 0xD, 0, 0, 0xD0, 0x30, 0x207, 0xF, 0, 2, 0
	.hword 0, 0, 0, 0x208, 0x1F, 0, 3, 0, 0, 0, 0, 0x209, 0x1F

	.data

aNarcEmdmLz7Nar: // 0x02162A08
	.asciz "/narc/emdm_lz7.narc"
	.align 4

aNarcActComBLz7_0: // 0x02162A1C
	.asciz "/narc/act_com_b_lz7.narc"
	.align 4