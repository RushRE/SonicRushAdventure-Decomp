	.include "asm/macros.inc"
	.include "global.inc"

.public VSLobbyMenu__sVars

	.text

	thumb_func_start VSCharacterSelect__Alloc
VSCharacterSelect__Alloc: // 0x0216229C
	push {r3, lr}
	ldr r0, _021622B0 // =0x00000408
	blx _AllocHeadHEAP_SYSTEM
	ldr r1, _021622B4 // =VSLobbyMenu__sVars
	str r0, [r1, #4]
	bl VSCharacterSelect__Init
	pop {r3, pc}
	nop
_021622B0: .word 0x00000408
_021622B4: .word VSLobbyMenu__sVars
	thumb_func_end VSCharacterSelect__Alloc

	thumb_func_start VSCharacterSelect__Free
VSCharacterSelect__Free: // 0x021622B8
	push {r3, lr}
	ldr r0, _021622D4 // =VSLobbyMenu__sVars
	ldr r0, [r0, #4]
	bl VSCharacterSelect__Release
	ldr r0, _021622D4 // =VSLobbyMenu__sVars
	ldr r0, [r0, #4]
	blx _FreeHEAP_SYSTEM
	ldr r0, _021622D4 // =VSLobbyMenu__sVars
	mov r1, #0
	str r1, [r0, #4]
	pop {r3, pc}
	nop
_021622D4: .word VSLobbyMenu__sVars
	thumb_func_end VSCharacterSelect__Free

	thumb_func_start VSCharacterSelect__Create
VSCharacterSelect__Create: // 0x021622D8
	push {r4, r5, lr}
	sub sp, #0xc
	ldr r0, _02162344 // =VSLobbyMenu__sVars
	ldr r5, [r0, #4]
	ldr r0, [r5, #0x18]
	mov r4, r5
	add r4, #0x1c
	cmp r0, #0
	beq _021622F2
	mov r0, #4
	add sp, #0xc
	str r0, [r4]
	pop {r4, r5, pc}
_021622F2:
	ldr r0, _02162348 // =0x00003041
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0216234C // =VSCharacterSelect__Main1
	str r1, [sp, #8]
	mov r2, r1
	mov r3, r1
	blx TaskCreate_
	mov r1, #0
	str r0, [r5]
	ldr r0, _02162350 // =0x00003021
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02162354 // =VSCharacterSelect__Main2
	str r1, [sp, #8]
	mov r3, r1
	blx TaskCreate_
	mov r1, #0
	str r0, [r5, #4]
	ldr r0, _02162358 // =0x00003081
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0216235C // =VSCharacterSelect__Main3
	mov r3, r1
	str r1, [sp, #8]
	blx TaskCreate_
	str r0, [r5, #8]
	ldr r1, _02162360 // =VSCharacterSelect__State_Init
	mov r0, r5
	bl VSCharacterSelect__SetState
	mov r0, #1
	str r0, [r4]
	add sp, #0xc
	pop {r4, r5, pc}
	.align 2, 0
_02162344: .word VSLobbyMenu__sVars
_02162348: .word 0x00003041
_0216234C: .word VSCharacterSelect__Main1
_02162350: .word 0x00003021
_02162354: .word VSCharacterSelect__Main2
_02162358: .word 0x00003081
_0216235C: .word VSCharacterSelect__Main3
_02162360: .word VSCharacterSelect__State_Init
	thumb_func_end VSCharacterSelect__Create

	thumb_func_start VSCharacterSelect__Func_2162364
VSCharacterSelect__Func_2162364: // 0x02162364
	ldr r0, _02162370 // =VSLobbyMenu__sVars
	mov r1, #1
	ldr r0, [r0, #4]
	str r1, [r0, #0x18]
	bx lr
	nop
_02162370: .word VSLobbyMenu__sVars
	thumb_func_end VSCharacterSelect__Func_2162364

	thumb_func_start VSCharacterSelect__Func_2162374
VSCharacterSelect__Func_2162374: // 0x02162374
	ldr r0, _02162388 // =VSLobbyMenu__sVars
	ldr r0, [r0, #4]
	ldr r0, [r0, #0x1c]
	cmp r0, #1
	bne _02162382
	mov r0, #0
	bx lr
_02162382:
	mov r0, #1
	bx lr
	nop
_02162388: .word VSLobbyMenu__sVars
	thumb_func_end VSCharacterSelect__Func_2162374

	thumb_func_start VSCharacterSelect__SetState
VSCharacterSelect__SetState: // 0x0216238C
	str r1, [r0, #0xc]
	mov r1, #0
	str r1, [r0, #0x10]
	bx lr
	thumb_func_end VSCharacterSelect__SetState

	thumb_func_start VSCharacterSelect__Init
VSCharacterSelect__Init: // 0x02162394
	push {r4, lr}
	mov r4, r0
	ldr r2, _021623B4 // =0x00000408
	mov r0, #0
	mov r1, r4
	blx MIi_CpuClear16
	mov r0, r4
	add r0, #0x1c
	bl VSCharacterSelect__Unknown1__Init
	add r4, #0x30
	mov r0, r4
	bl VSCharacterSelect__LoadAssets
	pop {r4, pc}
	.align 2, 0
_021623B4: .word 0x00000408
	thumb_func_end VSCharacterSelect__Init

	thumb_func_start VSCharacterSelect__Release
VSCharacterSelect__Release: // 0x021623B8
	push {r4, lr}
	mov r4, r0
	add r0, #0x30
	bl VSCharacterSelect__ReleaseAssets
	mov r0, r4
	add r0, #0x1c
	bl VSCharacterSelect__Unknown1__Release
	ldr r2, _021623D8 // =0x00000408
	mov r0, #0
	mov r1, r4
	blx MIi_CpuClear16
	pop {r4, pc}
	nop
_021623D8: .word 0x00000408
	thumb_func_end VSCharacterSelect__Release

	thumb_func_start VSCharacterSelect__Unknown1__Init
VSCharacterSelect__Unknown1__Init: // 0x021623DC
	mov r2, #0
	str r2, [r0]
	mov r1, #2
	str r1, [r0, #4]
	str r1, [r0, #8]
	strh r2, [r0, #0xc]
	bx lr
	.align 2, 0
	thumb_func_end VSCharacterSelect__Unknown1__Init

	thumb_func_start VSCharacterSelect__Unknown1__Release
VSCharacterSelect__Unknown1__Release: // 0x021623EC
	mov r1, #2
	str r1, [r0]
	bx lr
	.align 2, 0
	thumb_func_end VSCharacterSelect__Unknown1__Release

	thumb_func_start VSCharacterSelect__LoadAssets
VSCharacterSelect__LoadAssets: // 0x021623F4
	push {r4, lr}
	sub sp, #8
	mov r3, #0
	mov r4, r0
	sub r1, r3, #1
	ldr r0, _02162454 // =aNarcDmcsVsNarc
	str r3, [sp]
	mov r2, r1
	blx ArchiveFile__Load
	str r0, [r4]
	blx RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	bhi _02162434
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02162420: // jump table
	.hword _0216242C - _02162420 - 2 // case 0
	.hword _0216242C - _02162420 - 2 // case 1
	.hword _0216242C - _02162420 - 2 // case 2
	.hword _0216242C - _02162420 - 2 // case 3
	.hword _0216242C - _02162420 - 2 // case 4
	.hword _0216242C - _02162420 - 2 // case 5
_0216242C:
	blx RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	b _02162436
_02162434:
	mov r0, #1
_02162436:
	lsl r1, r0, #2
	ldr r0, _02162458 // =0x0217EC04
	ldr r2, _0216245C // =aDmcsVsBac
	ldr r0, [r0, r1]
	add r1, r4, #4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	ldr r0, [r4]
	add r4, #8
	mov r3, r4
	bl StageClear__LoadFiles
	add sp, #8
	pop {r4, pc}
	.align 2, 0
_02162454: .word aNarcDmcsVsNarc
_02162458: .word 0x0217EC04
_0216245C: .word aDmcsVsBac
	thumb_func_end VSCharacterSelect__LoadAssets

	thumb_func_start VSCharacterSelect__ReleaseAssets
VSCharacterSelect__ReleaseAssets: // 0x02162460
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4]
	blx _FreeHEAP_USER
	mov r0, #0
	mov r1, r4
	mov r2, #0xc
	blx MIi_CpuClear32
	pop {r4, pc}
	.align 2, 0
	thumb_func_end VSCharacterSelect__ReleaseAssets

	thumb_func_start VSCharacterSelect__InitSprites
VSCharacterSelect__InitSprites: // 0x02162478
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	ldr r4, _02162594 // =0x0217DE98
	str r0, [sp, #0x14]
	str r1, [sp, #0x18]
	mov r6, #0
	mov r5, r0
_02162486:
	cmp r6, #7
	bne _02162494
	mov r0, #1
	bl VSLobbyMenu__Func_2163BDC
	mov r7, r0
	b _0216249C
_02162494:
	ldrh r0, [r4]
	lsl r1, r0, #2
	ldr r0, [sp, #0x18]
	ldr r7, [r0, r1]
_0216249C:
	ldrh r2, [r4, #2]
	mov r0, r7
	mov r1, #1
	blx SpriteUnknown__Func_204C3CC
	mov r1, #1
	str r1, [sp]
	str r0, [sp, #4]
	ldrb r0, [r4, #8]
	mov r3, #2
	mov r1, r7
	str r0, [sp, #8]
	ldrb r0, [r4, #9]
	lsl r3, r3, #0xa
	str r0, [sp, #0xc]
	ldrb r0, [r4, #0xa]
	str r0, [sp, #0x10]
	ldrh r2, [r4, #2]
	mov r0, r5
	blx SpriteUnknown__Func_204C90C
	ldr r0, [r4, #4]
	mov r1, #0
	str r0, [r5, #8]
	mov r0, r5
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	cmp r6, #4
	beq _021624E0
	cmp r6, #5
	beq _021624E0
	cmp r6, #7
	bne _021624EA
_021624E0:
	ldr r1, [r5, #0x3c]
	mov r0, #0xc
	orr r0, r1
	str r0, [r5, #0x3c]
	b _021624F2
_021624EA:
	ldr r1, [r5, #0x3c]
	mov r0, #8
	orr r0, r1
	str r0, [r5, #0x3c]
_021624F2:
	add r6, r6, #1
	add r4, #0xc
	add r5, #0x64
	cmp r6, #8
	blo _02162486
	mov r1, #0x19
	ldr r0, [sp, #0x14]
	lsl r1, r1, #4
	add r0, r0, r1
	ldr r1, _02162598 // =0x0217DE98
	ldrh r1, [r1, #0x32]
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	blx AnimatorSprite__SetAnimation
	bl VSLobbyMenu__GetTouchField
	mov r4, r0
	mov r1, #0x32
	ldr r0, [sp, #0x14]
	lsl r1, r1, #4
	add r5, r0, r1
	mov r1, #0x2c
	add r0, sp, #0x1c
	strh r1, [r0]
	mov r1, #0x44
	strh r1, [r0, #2]
	mov r1, #0x74
	strh r1, [r0, #4]
	mov r1, #0xa0
	strh r1, [r0, #6]
	mov r1, #0
	str r1, [sp]
	ldr r2, _0216259C // =TouchField__PointInRect
	mov r0, r5
	add r3, sp, #0x1c
	str r1, [sp, #4]
	blx TouchField__InitAreaShape
	mov r0, r4
	mov r1, r5
	mov r2, #0
	blx TouchField__AddArea
	ldr r1, [r5, #0x14]
	mov r0, #0x80
	orr r0, r1
	str r0, [r5, #0x14]
	mov r1, #0xd6
	ldr r0, [sp, #0x14]
	lsl r1, r1, #2
	add r5, r0, r1
	mov r1, #0x8c
	add r0, sp, #0x1c
	strh r1, [r0]
	mov r1, #0x44
	strh r1, [r0, #2]
	mov r1, #0xd4
	strh r1, [r0, #4]
	mov r1, #0xa0
	strh r1, [r0, #6]
	mov r1, #0
	str r1, [sp]
	ldr r2, _0216259C // =TouchField__PointInRect
	mov r0, r5
	add r3, sp, #0x1c
	str r1, [sp, #4]
	blx TouchField__InitAreaShape
	mov r0, r4
	mov r1, r5
	mov r2, #0
	blx TouchField__AddArea
	ldr r1, [r5, #0x14]
	mov r0, #0x80
	orr r0, r1
	str r0, [r5, #0x14]
	add sp, #0x24
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02162594: .word 0x0217DE98
_02162598: .word 0x0217DE98
_0216259C: .word TouchField__PointInRect
	thumb_func_end VSCharacterSelect__InitSprites

	thumb_func_start VSCharacterSelect__ReleaseSprites
VSCharacterSelect__ReleaseSprites: // 0x021625A0
	push {r3, r4, r5, lr}
	mov r5, r0
	bl VSLobbyMenu__GetTouchField
	mov r1, #0x32
	lsl r1, r1, #4
	add r1, r5, r1
	mov r4, r0
	blx TouchField__RemoveArea
	mov r1, #0xd6
	lsl r1, r1, #2
	mov r0, r4
	add r1, r5, r1
	blx TouchField__RemoveArea
	mov r0, #0x32
	lsl r0, r0, #4
	beq _021625D4
	add r4, r5, r0
_021625C8:
	mov r0, r5
	blx AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _021625C8
_021625D4:
	pop {r3, r4, r5, pc}
	.align 2, 0
	thumb_func_end VSCharacterSelect__ReleaseSprites

	thumb_func_start VSCharacterSelect__InitFonts
VSCharacterSelect__InitFonts: // 0x021625D8
	push {r3, r4, r5, lr}
	sub sp, #0x20
	mov r5, r0
	mov r0, #0
	bl VSLobbyMenu__Func_2163BDC
	mov r4, r0
	mov r0, r5
	blx FontAniHeader__Func_2054CF8
	mov r0, #3
	str r0, [sp]
	mov r0, #4
	str r0, [sp, #4]
	mov r0, #0x1a
	str r0, [sp, #8]
	mov r0, #0x11
	str r0, [sp, #0xc]
	mov r0, #1
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r0, #0x1f
	str r0, [sp, #0x18]
	mov r0, #9
	mov r1, #0
	str r0, [sp, #0x1c]
	mov r0, r5
	mov r2, r4
	mov r3, r1
	blx FontWindowAnimator__Unknown__Load2
	mov r0, #1
	lsl r0, r0, #0xc
	strh r0, [r5, #0x38]
	add sp, #0x20
	pop {r3, r4, r5, pc}
	thumb_func_end VSCharacterSelect__InitFonts

	thumb_func_start VSCharacterSelect__ReleaseFonts
VSCharacterSelect__ReleaseFonts: // 0x02162620
	ldr r3, _02162624 // =FontAniHeader__Unknown__Release
	bx r3
	.align 2, 0
_02162624: .word FontAniHeader__Unknown__Release
	thumb_func_end VSCharacterSelect__ReleaseFonts

	thumb_func_start VSCharacterSelect__DrawSprites
VSCharacterSelect__DrawSprites: // 0x02162628
	push {r4, r5, r6, lr}
	mov r5, r0
	add r0, #0x1c
	mov r1, #0xc
	ldrsh r2, [r0, r1]
	lsl r1, r1, #9
	add r5, #0x3c
	cmp r2, r1
	bge _02162642
	mov r1, #2
	lsl r1, r1, #0xa
	add r1, r2, r1
	b _02162646
_02162642:
	mov r1, #2
	lsl r1, r1, #0xc
_02162646:
	strh r1, [r0, #0xc]
	mov r0, #0x32
	lsl r0, r0, #4
	beq _02162662
	mov r6, #0
	add r4, r5, r0
_02162652:
	mov r0, r5
	mov r1, r6
	mov r2, r6
	blx AnimatorSprite__ProcessAnimation
	add r5, #0x64
	cmp r5, r4
	bne _02162652
_02162662:
	pop {r4, r5, r6, pc}
	thumb_func_end VSCharacterSelect__DrawSprites

	thumb_func_start VSCharacterSelect__DrawText
VSCharacterSelect__DrawText: // 0x02162664
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	str r0, [sp, #4]
	mov r4, r0
	add r0, #0x1c
	mov r2, #0xf3
	mov r6, #0x4b
	ldr r1, [sp, #4]
	lsl r2, r2, #2
	add r7, r1, r2
	ldr r5, [r0, #4]
	add r4, #0x3c
	lsl r6, r6, #2
	mov r2, #0
	add r1, r4, r6
	cmp r5, #5
	bhi _021626AA
	add r5, r5, r5
	add r5, pc
	ldrh r5, [r5, #6]
	lsl r5, r5, #0x10
	asr r5, r5, #0x10
	add pc, r5
_02162692: // jump table
	.hword _021626AA - _02162692 - 2 // case 0
	.hword _021626AA - _02162692 - 2 // case 1
	.hword _0216269E - _02162692 - 2 // case 2
	.hword _021626A4 - _02162692 - 2 // case 3
	.hword _0216269E - _02162692 - 2 // case 4
	.hword _021626A4 - _02162692 - 2 // case 5
_0216269E:
	ldr r3, _02162758 // =0x0217DEC8
	add r6, #0x64
	b _021626B4
_021626A4:
	ldr r3, _0216275C // =0x0217DED4
	add r6, #0xc8
	b _021626B4
_021626AA:
	ldr r6, [r1, #0x3c]
	mov r5, #1
	orr r5, r6
	str r5, [r1, #0x3c]
	b _021626C2
_021626B4:
	ldr r5, [r3, #4]
	add r2, r4, r6
	str r5, [r1, #8]
	ldr r6, [r1, #0x3c]
	mov r5, #1
	bic r6, r5
	str r6, [r1, #0x3c]
_021626C2:
	cmp r2, #0
	beq _021626DC
	mov r1, #0xc
	ldrsh r1, [r0, r1]
	mov r5, #4
	ldrsh r5, [r3, r5]
	asr r1, r1, #0xc
	sub r5, r5, r1
	strh r5, [r2, #8]
	mov r5, #6
	ldrsh r3, [r3, r5]
	sub r1, r3, r1
	strh r1, [r2, #0xa]
_021626DC:
	ldr r0, [r0, #8]
	mov r1, r4
	add r1, #0xc8
	cmp r0, #4
	beq _021626EC
	cmp r0, #5
	beq _021626F0
	b _021626F4
_021626EC:
	ldr r3, _02162760 // =0x0217DE98
	b _021626FE
_021626F0:
	ldr r3, _02162764 // =0x0217DEA4
	b _021626FE
_021626F4:
	ldr r2, [r1, #0x3c]
	mov r0, #1
	orr r0, r2
	str r0, [r1, #0x3c]
	b _0216270A
_021626FE:
	ldr r0, [r3, #4]
	str r0, [r1, #8]
	ldr r2, [r1, #0x3c]
	mov r0, #1
	bic r2, r0
	str r2, [r1, #0x3c]
_0216270A:
	ldr r0, [sp, #4]
	ldrh r1, [r0, #0x14]
	mov r0, #4
	tst r0, r1
	beq _02162728
	mov r0, #0x32
	lsl r0, r0, #4
	beq _02162728
	add r5, r4, r0
_0216271C:
	mov r0, r4
	blx AnimatorSprite__DrawFrame
	add r4, #0x64
	cmp r4, r5
	bne _0216271C
_02162728:
	ldr r0, [sp, #4]
	ldrh r1, [r0, #0x14]
	mov r0, #2
	tst r0, r1
	beq _02162754
	mov r0, #0x38
	ldrsh r1, [r7, r0]
	cmp r1, #0
	ble _02162754
	mov r0, #0x3a
	ldrsh r2, [r7, r0]
	cmp r2, #0
	ble _02162754
	mov r0, #0x44
	str r0, [sp]
	mov r0, r7
	mov r3, #0x68
	blx FontWindowAnimator__Unknown__Func_205509C
	mov r0, r7
	blx FontWindowAnimator__Unknown__Func_2054F64
_02162754:
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02162758: .word 0x0217DEC8
_0216275C: .word 0x0217DED4
_02162760: .word 0x0217DE98
_02162764: .word 0x0217DEA4
	thumb_func_end VSCharacterSelect__DrawText

	thumb_func_start VSCharacterSelect__State_Init
VSCharacterSelect__State_Init: // 0x02162768
	push {r4, lr}
	mov r4, r0
	mov r1, r4
	add r0, #0x3c
	add r1, #0x30
	bl VSCharacterSelect__InitSprites
	mov r0, #0xf3
	lsl r0, r0, #2
	mov r1, r4
	add r0, r4, r0
	add r1, #0x30
	bl VSCharacterSelect__InitFonts
	mov r0, #5
	mov r1, #0
	bl VSLobbyMenu__Func_2163CE0
	ldrh r1, [r4, #0x14]
	mov r0, #2
	orr r0, r1
	strh r0, [r4, #0x14]
	ldr r1, _021627A0 // =VSCharacterSelect__State_21627A4
	mov r0, r4
	bl VSCharacterSelect__SetState
	pop {r4, pc}
	nop
_021627A0: .word VSCharacterSelect__State_21627A4
	thumb_func_end VSCharacterSelect__State_Init

	thumb_func_start VSCharacterSelect__State_21627A4
VSCharacterSelect__State_21627A4: // 0x021627A4
	push {r4, r5, r6, lr}
	mov r1, #0xf3
	lsl r1, r1, #2
	mov r2, r0
	ldr r3, [r0, #0x10]
	add r4, r0, r1
	add r2, #0x3c
	cmp r3, #0xc
	bls _021627E8
	mov r3, r1
	sub r3, #0x98
	ldr r6, [r2, r3]
	mov r5, #0x80
	mov r3, r1
	bic r6, r5
	sub r3, #0x98
	str r6, [r2, r3]
	mov r3, r1
	sub r3, #0x60
	ldr r3, [r2, r3]
	sub r1, #0x60
	bic r3, r5
	str r3, [r2, r1]
	mov r1, #1
	lsl r1, r1, #0xc
	strh r1, [r4, #0x3a]
	ldrh r2, [r0, #0x14]
	mov r1, #7
	orr r1, r2
	strh r1, [r0, #0x14]
	ldr r1, _021627F4 // =VSCharacterSelect__State_21627F8
	bl VSCharacterSelect__SetState
	pop {r4, r5, r6, pc}
_021627E8:
	lsl r0, r3, #0xc
	mov r1, #0xc
	blx _u32_div_f
	strh r0, [r4, #0x3a]
	pop {r4, r5, r6, pc}
	.align 2, 0
_021627F4: .word VSCharacterSelect__State_21627F8
	thumb_func_end VSCharacterSelect__State_21627A4

	thumb_func_start VSCharacterSelect__State_21627F8
VSCharacterSelect__State_21627F8: // 0x021627F8
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r6, r0
	mov r1, #0
	str r1, [sp, #8]
	mov r4, r6
	mov r5, r6
	ldr r1, [r6, #0x18]
	add r4, #0x3c
	add r5, #0x1c
	cmp r1, #0
	beq _02162822
	ldrh r2, [r6, #0x14]
	mov r1, #4
	bic r2, r1
	ldr r1, _021629B8 // =VSCharacterSelect__State_2162AF4
	strh r2, [r6, #0x14]
	bl VSCharacterSelect__SetState
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_02162822:
	bl VSLobbyMenu__Func_2163DF4
	cmp r0, #0
	beq _02162842
	mov r0, #1
	str r0, [r6, #0x2c]
	ldrh r1, [r6, #0x14]
	mov r0, #4
	bic r1, r0
	strh r1, [r6, #0x14]
	ldr r1, _021629B8 // =VSCharacterSelect__State_2162AF4
	mov r0, r6
	bl VSCharacterSelect__SetState
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_02162842:
	bl VSLobbyMenu__Func_2163CA0
	cmp r0, #1
	beq _02162850
	cmp r0, #2
	beq _02162856
	b _0216285A
_02162850:
	mov r0, #4
	str r0, [r5, #8]
	b _0216285A
_02162856:
	mov r0, #5
	str r0, [r5, #8]
_0216285A:
	ldr r0, _021629BC // =padInput
	mov r1, #0x20
	ldrh r0, [r0, #8]
	tst r1, r0
	bne _0216286A
	mov r3, #0x10
	tst r0, r3
	beq _02162884
_0216286A:
	ldr r0, [r5, #4]
	cmp r0, #2
	bne _0216287A
	mov r0, #3
	str r0, [r5, #4]
	mov r0, #1
	str r0, [sp, #8]
	b _021628AC
_0216287A:
	mov r0, #2
	str r0, [r5, #4]
	mov r0, #1
	str r0, [sp, #8]
	b _021628AC
_02162884:
	mov r0, #0xcd
	lsl r0, r0, #2
	ldr r2, [r4, r0]
	lsl r1, r3, #0x12
	tst r1, r2
	beq _0216289A
	mov r0, #2
	str r0, [r5, #4]
	mov r0, #1
	str r0, [sp, #8]
	b _021628AC
_0216289A:
	add r0, #0x38
	ldr r1, [r4, r0]
	lsl r0, r3, #0x12
	tst r0, r1
	beq _021628AC
	mov r0, #3
	str r0, [r5, #4]
	mov r0, #1
	str r0, [sp, #8]
_021628AC:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _02162916
	mov r0, #0
	strh r0, [r5, #0xc]
	ldr r0, [r5, #4]
	cmp r0, #2
	bne _021628E6
	ldr r1, _021629C0 // =0x0217DEC8
	mov r0, #0x19
	ldrh r1, [r1, #2]
	lsl r0, r0, #4
	add r0, r4, r0
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	blx AnimatorSprite__SetAnimation
	ldr r7, _021629C4 // =0x0217DED4
	mov r0, #0x7d
	lsl r0, r0, #2
	add r0, r4, r0
	ldrh r1, [r7, #2]
	str r0, [sp]
	blx AnimatorSprite__SetAnimation
	ldr r1, [r7, #4]
	ldr r0, [sp]
	b _0216290E
_021628E6:
	ldr r1, _021629C4 // =0x0217DED4
	mov r0, #0x7d
	ldrh r1, [r1, #2]
	lsl r0, r0, #2
	add r0, r4, r0
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	blx AnimatorSprite__SetAnimation
	ldr r7, _021629C0 // =0x0217DEC8
	mov r0, #0x19
	lsl r0, r0, #4
	add r0, r4, r0
	ldrh r1, [r7, #2]
	str r0, [sp, #4]
	blx AnimatorSprite__SetAnimation
	ldr r1, [r7, #4]
	ldr r0, [sp, #4]
_0216290E:
	str r1, [r0, #8]
	mov r0, #2
	blx PlaySysMenuNavSfx
_02162916:
	ldr r0, [r5, #4]
	cmp r0, #2
	beq _02162922
	cmp r0, #3
	beq _02162926
	b _02162928
_02162922:
	ldr r7, _021629C0 // =0x0217DEC8
	b _02162928
_02162926:
	ldr r7, _021629C4 // =0x0217DED4
_02162928:
	mov r3, #4
	ldrsh r2, [r7, r3]
	mov r1, #0xaf
	lsl r1, r1, #2
	add r0, r4, r1
	add r2, r2, #4
	strh r2, [r0, #8]
	mov r2, #6
	ldrsh r2, [r7, r2]
	add r2, #8
	strh r2, [r0, #0xa]
	ldr r0, _021629BC // =padInput
	ldrh r2, [r0, #4]
	ldr r0, _021629C8 // =0x00000C09
	tst r0, r2
	beq _02162970
	ldr r0, [r5, #4]
	cmp r0, #2
	beq _02162956
	cmp r0, #3
	beq _0216295E
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_02162956:
	mov r0, #0
	bl VSLobbyMenu__Func_2163BFC
	b _02162964
_0216295E:
	mov r0, #1
	bl VSLobbyMenu__Func_2163BFC
_02162964:
	ldr r1, _021629CC // =VSCharacterSelect__State_21629D0
	mov r0, r6
	bl VSCharacterSelect__SetState
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_02162970:
	mov r0, r1
	add r0, #0x78
	ldr r2, [r4, r0]
	lsl r0, r3, #0x10
	tst r0, r2
	beq _02162994
	ldr r0, [r5, #4]
	cmp r0, #2
	bne _021629B2
	mov r0, #0
	bl VSLobbyMenu__Func_2163BFC
	ldr r1, _021629CC // =VSCharacterSelect__State_21629D0
	mov r0, r6
	bl VSCharacterSelect__SetState
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_02162994:
	add r1, #0xb0
	ldr r1, [r4, r1]
	lsl r0, r3, #0x10
	tst r0, r1
	beq _021629B2
	ldr r0, [r5, #4]
	cmp r0, #3
	bne _021629B2
	mov r0, #1
	bl VSLobbyMenu__Func_2163BFC
	ldr r1, _021629CC // =VSCharacterSelect__State_21629D0
	mov r0, r6
	bl VSCharacterSelect__SetState
_021629B2:
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_021629B8: .word VSCharacterSelect__State_2162AF4
_021629BC: .word padInput
_021629C0: .word 0x0217DEC8
_021629C4: .word 0x0217DED4
_021629C8: .word 0x00000C09
_021629CC: .word VSCharacterSelect__State_21629D0
	thumb_func_end VSCharacterSelect__State_21627F8

	thumb_func_start VSCharacterSelect__State_21629D0
VSCharacterSelect__State_21629D0: // 0x021629D0
	push {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	ldr r1, [r6, #0x18]
	mov r4, r6
	mov r5, r6
	add r4, #0x3c
	add r5, #0x1c
	cmp r1, #0
	beq _021629F2
	ldrh r2, [r6, #0x14]
	mov r1, #4
	bic r2, r1
	ldr r1, _02162AAC // =VSCharacterSelect__State_2162AF4
	strh r2, [r6, #0x14]
	bl VSCharacterSelect__SetState
	pop {r3, r4, r5, r6, r7, pc}
_021629F2:
	bl VSLobbyMenu__Func_2163C6C
	cmp r0, #0
	beq _02162AAA
	cmp r0, #1
	beq _02162A04
	cmp r0, #2
	beq _02162A58
	pop {r3, r4, r5, r6, r7, pc}
_02162A04:
	ldr r0, [r5, #4]
	cmp r0, #2
	beq _02162A10
	cmp r0, #3
	beq _02162A20
	b _02162A2E
_02162A10:
	mov r0, #4
	str r0, [r5, #4]
	mov r0, #0x19
	lsl r0, r0, #4
	add r7, r4, r0
	ldr r0, _02162AB0 // =0x0217DEC8
	str r0, [sp]
	b _02162A2E
_02162A20:
	mov r0, #5
	str r0, [r5, #4]
	mov r0, #0x7d
	lsl r0, r0, #2
	add r7, r4, r0
	ldr r0, _02162AB4 // =0x0217DED4
	str r0, [sp]
_02162A2E:
	ldr r1, [sp]
	mov r0, r7
	ldrh r1, [r1, #2]
	add r1, r1, #2
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	blx AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r7
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	mov r0, #0
	blx PlaySysMenuNavSfx
	ldr r1, _02162AB8 // =VSCharacterSelect__State_2162AC0
	mov r0, r6
	bl VSCharacterSelect__SetState
	pop {r3, r4, r5, r6, r7, pc}
_02162A58:
	ldr r0, [r5, #4]
	cmp r0, #2
	beq _02162A64
	cmp r0, #3
	beq _02162A74
	b _02162A82
_02162A64:
	mov r0, #4
	str r0, [r5, #8]
	ldr r0, _02162AB0 // =0x0217DEC8
	str r0, [sp]
	mov r0, #0x19
	lsl r0, r0, #4
	add r7, r4, r0
	b _02162A82
_02162A74:
	mov r0, #5
	str r0, [r5, #8]
	ldr r0, _02162AB4 // =0x0217DED4
	str r0, [sp]
	mov r0, #0x7d
	lsl r0, r0, #2
	add r7, r4, r0
_02162A82:
	ldr r1, [sp]
	mov r0, r7
	ldrh r1, [r1, #2]
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	blx AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r7
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	mov r0, #4
	blx PlaySysSfx
	ldr r1, _02162ABC // =VSCharacterSelect__State_21627F8
	mov r0, r6
	bl VSCharacterSelect__SetState
_02162AAA:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02162AAC: .word VSCharacterSelect__State_2162AF4
_02162AB0: .word 0x0217DEC8
_02162AB4: .word 0x0217DED4
_02162AB8: .word VSCharacterSelect__State_2162AC0
_02162ABC: .word VSCharacterSelect__State_21627F8
	thumb_func_end VSCharacterSelect__State_21629D0

	thumb_func_start VSCharacterSelect__State_2162AC0
VSCharacterSelect__State_2162AC0: // 0x02162AC0
	push {r3, lr}
	ldr r1, [r0, #0x18]
	cmp r1, #0
	beq _02162AD8
	ldrh r2, [r0, #0x14]
	mov r1, #4
	bic r2, r1
	ldr r1, _02162AF0 // =VSCharacterSelect__State_2162AF4
	strh r2, [r0, #0x14]
	bl VSCharacterSelect__SetState
	pop {r3, pc}
_02162AD8:
	ldr r1, [r0, #0x10]
	cmp r1, #0x20
	bls _02162AEC
	ldrh r2, [r0, #0x14]
	mov r1, #4
	bic r2, r1
	ldr r1, _02162AF0 // =VSCharacterSelect__State_2162AF4
	strh r2, [r0, #0x14]
	bl VSCharacterSelect__SetState
_02162AEC:
	pop {r3, pc}
	nop
_02162AF0: .word VSCharacterSelect__State_2162AF4
	thumb_func_end VSCharacterSelect__State_2162AC0

	thumb_func_start VSCharacterSelect__State_2162AF4
VSCharacterSelect__State_2162AF4: // 0x02162AF4
	push {r4, lr}
	mov r1, #0xf3
	lsl r1, r1, #2
	ldr r2, [r0, #0x10]
	add r4, r0, r1
	cmp r2, #0xc
	bls _02162B32
	mov r1, #0
	strh r1, [r4, #0x3a]
	ldrh r2, [r0, #0x14]
	mov r1, #7
	bic r2, r1
	strh r2, [r0, #0x14]
	ldr r1, [r0, #0x18]
	cmp r1, #0
	beq _02162B1C
	ldr r1, _02162B40 // =VSCharacterSelect__State_2162B48
	bl VSCharacterSelect__SetState
	pop {r4, pc}
_02162B1C:
	ldr r1, [r0, #0x2c]
	cmp r1, #0
	beq _02162B2A
	ldr r1, _02162B44 // =VSCharacterSelect__State_2162B9C
	bl VSCharacterSelect__SetState
	pop {r4, pc}
_02162B2A:
	ldr r1, _02162B40 // =VSCharacterSelect__State_2162B48
	bl VSCharacterSelect__SetState
	pop {r4, pc}
_02162B32:
	mov r1, #0xc
	sub r0, r1, r2
	lsl r0, r0, #0xc
	blx _u32_div_f
	strh r0, [r4, #0x3a]
	pop {r4, pc}
	.align 2, 0
_02162B40: .word VSCharacterSelect__State_2162B48
_02162B44: .word VSCharacterSelect__State_2162B9C
	thumb_func_end VSCharacterSelect__State_2162AF4

	thumb_func_start VSCharacterSelect__State_2162B48
VSCharacterSelect__State_2162B48: // 0x02162B48
	push {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	ldrh r1, [r6, #0x14]
	str r0, [sp]
	add r0, #0x1c
	str r0, [sp]
	mov r0, #7
	bic r1, r0
	mov r0, #0xf3
	lsl r0, r0, #2
	add r0, r6, r0
	strh r1, [r6, #0x14]
	bl VSCharacterSelect__ReleaseFonts
	mov r0, r6
	add r0, #0x3c
	bl VSCharacterSelect__ReleaseSprites
	mov r5, r6
	mov r0, #0xc
	beq _02162B84
	mov r4, r6
	mov r7, #0
	add r4, #0xc
_02162B78:
	ldr r0, [r5]
	blx DestroyTask
	stmia r5!, {r7}
	cmp r5, r4
	bne _02162B78
_02162B84:
	ldr r0, [r6, #0x18]
	cmp r0, #0
	bne _02162B92
	ldr r0, [sp]
	mov r1, #2
	str r1, [r0]
	pop {r3, r4, r5, r6, r7, pc}
_02162B92:
	ldr r0, [sp]
	mov r1, #4
	str r1, [r0]
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
	thumb_func_end VSCharacterSelect__State_2162B48

	thumb_func_start VSCharacterSelect__State_2162B9C
VSCharacterSelect__State_2162B9C: // 0x02162B9C
	push {r4, lr}
	mov r4, r0
	mov r0, #0
	bl VSLobbyMenu__Func_2163BFC
	ldr r1, _02162BB0 // =VSCharacterSelect__State_2162BB4
	mov r0, r4
	bl VSCharacterSelect__SetState
	pop {r4, pc}
	.align 2, 0
_02162BB0: .word VSCharacterSelect__State_2162BB4
	thumb_func_end VSCharacterSelect__State_2162B9C

	thumb_func_start VSCharacterSelect__State_2162BB4
VSCharacterSelect__State_2162BB4: // 0x02162BB4
	push {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x18]
	cmp r1, #0
	beq _02162BC4
	ldr r1, _02162BEC // =VSCharacterSelect__State_2162B48
	bl VSCharacterSelect__SetState
_02162BC4:
	bl VSLobbyMenu__Func_2163C6C
	cmp r0, #0
	beq _02162BE8
	cmp r0, #1
	beq _02162BD6
	cmp r0, #2
	beq _02162BE0
	pop {r4, pc}
_02162BD6:
	ldr r1, _02162BEC // =VSCharacterSelect__State_2162B48
	mov r0, r4
	bl VSCharacterSelect__SetState
	pop {r4, pc}
_02162BE0:
	ldr r1, _02162BF0 // =VSCharacterSelect__State_2162BF4
	mov r0, r4
	bl VSCharacterSelect__SetState
_02162BE8:
	pop {r4, pc}
	nop
_02162BEC: .word VSCharacterSelect__State_2162B48
_02162BF0: .word VSCharacterSelect__State_2162BF4
	thumb_func_end VSCharacterSelect__State_2162BB4

	thumb_func_start VSCharacterSelect__State_2162BF4
VSCharacterSelect__State_2162BF4: // 0x02162BF4
	push {r4, lr}
	mov r4, r0
	mov r0, #1
	bl VSLobbyMenu__Func_2163BFC
	ldr r1, _02162C08 // =VSCharacterSelect__State_2162BB4
	mov r0, r4
	bl VSCharacterSelect__SetState
	pop {r4, pc}
	.align 2, 0
_02162C08: .word VSCharacterSelect__State_2162BB4
	thumb_func_end VSCharacterSelect__State_2162BF4

	thumb_func_start VSCharacterSelect__Main1
VSCharacterSelect__Main1: // 0x02162C0C
	push {r3, lr}
	ldr r0, _02162C1C // =VSLobbyMenu__sVars
	ldr r0, [r0, #4]
	ldr r1, [r0, #0xc]
	cmp r1, #0
	beq _02162C1A
	blx r1
_02162C1A:
	pop {r3, pc}
	.align 2, 0
_02162C1C: .word VSLobbyMenu__sVars
	thumb_func_end VSCharacterSelect__Main1

	thumb_func_start VSCharacterSelect__Main2
VSCharacterSelect__Main2: // 0x02162C20
	push {r3, lr}
	ldr r0, _02162C3C // =VSLobbyMenu__sVars
	ldr r0, [r0, #4]
	ldr r1, [r0, #0x10]
	add r1, r1, #1
	str r1, [r0, #0x10]
	ldrh r2, [r0, #0x14]
	mov r1, #1
	tst r1, r2
	beq _02162C38
	bl VSCharacterSelect__DrawSprites
_02162C38:
	pop {r3, pc}
	nop
_02162C3C: .word VSLobbyMenu__sVars
	thumb_func_end VSCharacterSelect__Main2

	thumb_func_start VSCharacterSelect__Main3
VSCharacterSelect__Main3: // 0x02162C40
	push {r3, lr}
	ldr r0, _02162C54 // =VSLobbyMenu__sVars
	mov r1, #6
	ldr r0, [r0, #4]
	ldrh r2, [r0, #0x14]
	tst r1, r2
	beq _02162C52
	bl VSCharacterSelect__DrawText
_02162C52:
	pop {r3, pc}
	.align 2, 0
_02162C54: .word VSLobbyMenu__sVars
	thumb_func_end VSCharacterSelect__Main3

	.data
	
aDmcsVsItaBac: // 0x0217EA84
	.asciz "/dmcs_vs_ita.bac"
	.align 4
	
aDmcsVsFraBac: // 0x0217EA98
	.asciz "/dmcs_vs_fra.bac"
	.align 4
	
aDmcsVsJpnBac: // 0x0217EAAC
	.asciz "/dmcs_vs_jpn.bac"
	.align 4
	
aDmcsVsSpaBac: // 0x0217EAC0
	.asciz "/dmcs_vs_spa.bac"
	.align 4
	
aDmcsVsEngBac: // 0x0217EAD4
	.asciz "/dmcs_vs_eng.bac"
	.align 4
	
aDmcsVsDeuBac: // 0x0217EAE8
	.asciz "/dmcs_vs_deu.bac"
	.align 4
	
aDmwlStateItaBa: // 0x0217EAFC
	.asciz "/dmwl_state_ita.bac"
	.align 4
	
aDmwlStateSpaBa: // 0x0217EB10
	.asciz "/dmwl_state_spa.bac"
	.align 4
	
aDmvsTitleItaBa_0: // 0x0217EB24
	.asciz "/dmvs_title_ita.bac"
	.align 4
	
aDmvsTitleSpaBa_0: // 0x0217EB38
	.asciz "/dmvs_title_spa.bac"
	.align 4
	
aDmvsTitleJpnBa_0: // 0x0217EB4C
	.asciz "/dmvs_title_jpn.bac"
	.align 4
	
aDmvsTitleEngBa_0: // 0x0217EB60
	.asciz "/dmvs_title_eng.bac"
	.align 4
	
aDmwlStateJpnBa: // 0x0217EB74
	.asciz "/dmwl_state_jpn.bac"
	.align 4
	
aDmwlStateEngBa: // 0x0217EB88
	.asciz "/dmwl_state_eng.bac"
	.align 4
	
aDmvsTitleFraBa_0: // 0x0217EB9C
	.asciz "/dmvs_title_fra.bac"
	.align 4
	
aDmwlStateFraBa: // 0x0217EBB0
	.asciz "/dmwl_state_fra.bac"
	.align 4
	
aDmwlStateDeuBa: // 0x0217EBC4
	.asciz "/dmwl_state_deu.bac"
	.align 4
	
aDmvsTitleDeuBa_0: // 0x0217EBD8
	.asciz "/dmvs_title_deu.bac"
	.align 4
	
_0217EBEC: // 0x0217EBEC
	.word aDmwlStateJpnBa		//  "/dmwl_state_jpn.bac"
	.word aDmwlStateEngBa		//  "/dmwl_state_eng.bac"
	.word aDmwlStateFraBa		//  "/dmwl_state_fra.bac"
	.word aDmwlStateDeuBa		//  "/dmwl_state_deu.bac"
	.word aDmwlStateItaBa		//  "/dmwl_state_ita.bac"
	.word aDmwlStateSpaBa		//  "/dmwl_state_spa.bac"

_0217EC04: // 0x0217EC04
	.word aDmcsVsJpnBac			// "/dmcs_vs_jpn.bac"
	.word aDmcsVsEngBac			// "/dmcs_vs_eng.bac"
	.word aDmcsVsFraBac			// "/dmcs_vs_fra.bac"
	.word aDmcsVsDeuBac			// "/dmcs_vs_deu.bac"
	.word aDmcsVsItaBac			// "/dmcs_vs_ita.bac"
	.word aDmcsVsSpaBac			// "/dmcs_vs_spa.bac"

_0217EC1C: // 0x0217EC1C
	.word aDmvsTitleJpnBa_0 	// "/dmvs_title_jpn.bac"
	.word aDmvsTitleEngBa_0 	// "/dmvs_title_eng.bac"
	.word aDmvsTitleFraBa_0 	// "/dmvs_title_fra.bac"
	.word aDmvsTitleDeuBa_0 	// "/dmvs_title_deu.bac"
	.word aDmvsTitleItaBa_0 	// "/dmvs_title_ita.bac"
	.word aDmvsTitleSpaBa_0 	// "/dmvs_title_spa.bac"

aNarcDmcsVsNarc: // 0x0217EC34
	.asciz "/narc/dmcs_vs.narc"
	.align 4
	
aDmcsVsBac: // 0x0217EC48
	.asciz "/dmcs_vs.bac"
	.align 4