	.include "asm/macros.inc"
	.include "global.inc"

.public VSMenu__Singleton

	.text

	thumb_func_start VSMenuBackground__Destroy
VSMenuBackground__Destroy: // 0x02167164
	push {r3, r4, r5, lr}
	ldr r0, _02167188 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, #0x8f
	mov r4, r0
	lsl r5, r5, #2
	ldr r0, [r4, r5]
	cmp r0, #0
	beq _02167186
	mov r0, #0
	bl RenderCore_SetVBlankCallback
	ldr r0, [r4, r5]
	bl DestroyTask
_02167186:
	pop {r3, r4, r5, pc}
	.align 2, 0
_02167188: .word VSMenu__Singleton
	thumb_func_end VSMenuBackground__Destroy

	thumb_func_start VSMenuNetworkMessage__Func_216718C
VSMenuNetworkMessage__Func_216718C: // 0x0216718C
	push {r4, r5, lr}
	sub sp, #0x14
	ldr r0, _02167210 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r2, #0x93
	mov r4, r0
	lsl r2, r2, #2
	add r5, r4, r2
	mov r0, #0
	mov r1, r5
	add r2, r2, #4
	bl MIi_CpuClear16
	mov r0, r5
	add r0, #0x78
	bl FontWindow__Init
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r5, r0
	bl FontAnimator__Init
	mov r0, #0x7b
	lsl r0, r0, #2
	add r0, r5, r0
	bl FontWindowAnimator__Init
	mov r0, r5
	add r0, #0x78
	mov r1, #0
	mov r2, #1
	bl FontWindow__LoadFromMemory
	mov r1, #0
	str r1, [r5, #0x10]
	ldr r0, [r4, #0x2c]
	add r5, #0x14
	bl SpriteUnknown__GetSpriteSize
	mov r2, #0
	str r2, [sp]
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	str r2, [sp, #0x10]
	ldr r1, [r4, #0x2c]
	mov r0, r5
	mov r3, #5
	bl SpriteUnknown__Func_204C90C
	mov r0, #0x80
	strh r0, [r5, #8]
	mov r0, #0x90
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add sp, #0x14
	pop {r4, r5, pc}
	nop
_02167210: .word VSMenu__Singleton
	thumb_func_end VSMenuNetworkMessage__Func_216718C

	thumb_func_start VSMenuNetworkMessage__Func_2167214
VSMenuNetworkMessage__Func_2167214: // 0x02167214
	push {r4, lr}
	ldr r0, _02167260 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x93
	lsl r1, r1, #2
	add r4, r0, r1
	ldr r0, [r4, #0]
	cmp r0, #0
	beq _0216722E
	bl DestroyTask
_0216722E:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02167238
	bl DestroyTask
_02167238:
	mov r0, r4
	add r0, #0x14
	bl AnimatorSprite__Release
	mov r0, #0x7b
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__Release
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__Release
	add r4, #0x78
	mov r0, r4
	bl FontWindow__Release
	pop {r4, pc}
	nop
_02167260: .word VSMenu__Singleton
	thumb_func_end VSMenuNetworkMessage__Func_2167214

	thumb_func_start VSMenuNetworkMessage__Create
VSMenuNetworkMessage__Create: // 0x02167264
	push {r4, r5, lr}
	sub sp, #0xc
	mov r5, r0
	ldr r0, _021672E0 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _021672E4 // =0x0400000A
	mov r2, #0x93
	lsl r2, r2, #2
	add r4, r0, r2
	ldrh r3, [r1, #0]
	mov r0, #0x43
	add r2, #0xb4
	and r0, r3
	orr r0, r2
	strh r0, [r1]
	ldrh r3, [r1, #0]
	mov r2, #3
	mov r0, #1
	bic r3, r2
	orr r3, r0
	strh r3, [r1]
	ldrh r3, [r1, #2]
	bic r3, r2
	mov r2, #2
	orr r2, r3
	strh r2, [r1, #2]
	ldr r1, _021672E8 // =0x0000FFFF
	strh r1, [r4, #0xc]
	ldrh r1, [r4, #0xc]
	strh r1, [r4, #0xe]
	bl VSMenu__InitFontWindow
	mov r0, #1
	tst r0, r5
	beq _021672DA
	ldr r0, _021672EC // =0x00002045
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _021672F0 // =VSMenuNetworkMessage__Main1
	str r1, [sp, #8]
	mov r2, r1
	mov r3, r1
	bl TaskCreate_
	mov r1, #0
	str r0, [r4]
	ldr r0, _021672F4 // =0x00002085
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _021672F8 // =VSMenuNetworkMessage__Main2
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r4, #4]
_021672DA:
	add sp, #0xc
	pop {r4, r5, pc}
	nop
_021672E0: .word VSMenu__Singleton
_021672E4: .word 0x0400000A
_021672E8: .word 0x0000FFFF
_021672EC: .word 0x00002045
_021672F0: .word VSMenuNetworkMessage__Main1
_021672F4: .word 0x00002085
_021672F8: .word VSMenuNetworkMessage__Main2
	thumb_func_end VSMenuNetworkMessage__Create

	thumb_func_start VSMenu__InitFontWindow
VSMenu__InitFontWindow: // 0x021672FC
	push {r4, r5, r6, lr}
	sub sp, #0x30
	mov r5, r0
	ldr r0, _02167444 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r6, r0
	mov r0, #0x93
	lsl r0, r0, #2
	add r4, r6, r0
	ldr r1, [r4, #8]
	cmp r1, r5
	bne _0216731A
	b _0216743E
_0216731A:
	sub r0, #0x60
	add r0, r4, r0
	bl FontWindowAnimator__Release
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__Release
	mov r0, r4
	ldr r1, _02167448 // =aFntFontAllFnt_3_ovl03
	add r0, #0x78
	mov r2, #3
	bl FontWindow__LoadFromFile2
	mov r0, #5
	str r0, [sp]
	mov r0, #0x1a
	str r0, [sp, #4]
	mov r0, #0x11
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	mov r1, r4
	str r2, [sp, #0x10]
	mov r0, #6
	str r0, [sp, #0x14]
	mov r0, #2
	lsl r0, r0, #8
	str r0, [sp, #0x18]
	sub r0, #0xd8
	add r0, r4, r0
	add r1, #0x78
	mov r3, #3
	bl FontAnimator__LoadFont1
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__LoadMappingsFunc
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__LoadPaletteFunc
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__ClearPixels
	mov r0, #0x4a
	lsl r0, r0, #2
	ldr r1, [r6, #0xc]
	add r0, r4, r0
	bl FontAnimator__LoadMPCFile
	add r3, sp, #0x28
	mov r0, #0
	mov r1, #1
	add r2, sp, #0x28
	add r3, #2
	bl GetVRAMCharacterConfig
	add r1, sp, #0x24
	ldrh r2, [r1, #4]
	ldrh r1, [r1, #6]
	ldr r0, _0216744C // =VRAMSystem__VRAM_BG
	lsl r2, r2, #0x10
	ldr r5, [r0, #0]
	lsl r1, r1, #0xe
	add r1, r2, r1
	add r2, r5, r1
	mov r1, #1
	lsl r1, r1, #0xa
	add r1, r2, r1
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	add r0, sp, #0x24
	add r0, #2
	str r0, [sp]
	mov r0, #0
	mov r1, #1
	add r2, sp, #0x2c
	add r3, sp, #0x24
	bl GetVRAMTileConfig
	add r1, sp, #0x24
	ldrh r2, [r1, #0]
	ldrh r1, [r1, #2]
	mov r0, #0
	lsl r2, r2, #0x10
	lsl r1, r1, #0xb
	add r1, r2, r1
	mov r2, #2
	add r1, r5, r1
	lsl r2, r2, #0xa
	bl MIi_CpuClearFast
	mov r0, #3
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #5
	str r0, [sp, #8]
	mov r0, #0x1c
	str r0, [sp, #0xc]
	mov r0, #0x12
	str r0, [sp, #0x10]
	mov r2, #0
	mov r1, r4
	str r2, [sp, #0x14]
	mov r0, #1
	str r0, [sp, #0x18]
	mov r0, #0x1f
	str r0, [sp, #0x1c]
	mov r0, #7
	str r0, [sp, #0x20]
	mov r0, #0x7b
	lsl r0, r0, #2
	add r0, r4, r0
	add r1, #0x78
	mov r3, r2
	bl FontWindowAnimator__Load2
	mov r0, #0x7b
	lsl r0, r0, #2
	mov r1, #0
	add r0, r4, r0
	sub r2, r1, #4
	bl FontWindowAnimator__Func_2059B88
	mov r0, #0x7b
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0x40
	bl FontWindowAnimator__EnableFlags
	ldr r0, _02167450 // =0x02110460
	ldr r3, _02167454 // =0x050000C2
	mov r1, #4
	mov r2, #0
	bl QueueUncompressedPalette
_0216743E:
	add sp, #0x30
	pop {r4, r5, r6, pc}
	nop
_02167444: .word VSMenu__Singleton
_02167448: .word aFntFontAllFnt_3_ovl03
_0216744C: .word VRAMSystem__VRAM_BG
_02167450: .word 0x02110460
_02167454: .word 0x050000C2
	thumb_func_end VSMenu__InitFontWindow

	thumb_func_start VSMenu__Func_2167458
VSMenu__Func_2167458: // 0x02167458
	cmp r0, #0xa
	bne _02167460
	mov r0, #1
	str r0, [r2, #0x10]
_02167460:
	bx lr
	.align 2, 0
	thumb_func_end VSMenu__Func_2167458

	thumb_func_start VSMenu__Func_2167464
VSMenu__Func_2167464: // 0x02167464
	push {r4, r5, lr}
	sub sp, #0xc
	ldr r0, _021674C0 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #1
	ldr r5, _021674C4 // =0x0000091C
	mov r4, r0
	add r0, r4, r5
	mov r2, r1
	mov r3, #0
	bl StageSelectMenu__Unknown__Init
	mov r1, #0x30
	mov r0, #0x80
	str r0, [sp]
	add r0, r4, r5
	mov r2, r1
	mov r3, r1
	bl StageSelectMenu__Unknown__Func_216A1B8
	mov r0, #2
	str r0, [sp]
	mov r0, #8
	str r0, [sp, #4]
	str r0, [sp, #8]
	ldr r2, [r4, #0x1c]
	add r0, r4, r5
	mov r1, #1
	mov r3, #0
	bl StageSelectMenu__Unknown__SetAnimator
	mov r3, #1
	str r3, [sp]
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	ldr r2, [r4, #0x18]
	add r0, r4, r5
	mov r1, #2
	bl StageSelectMenu__Unknown__SetAnimator
	add sp, #0xc
	pop {r4, r5, pc}
	nop
_021674C0: .word VSMenu__Singleton
_021674C4: .word 0x0000091C
	thumb_func_end VSMenu__Func_2167464

	thumb_func_start VSMenu__Func_21674C8
VSMenu__Func_21674C8: // 0x021674C8
	push {r3, lr}
	ldr r0, _021674DC // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _021674E0 // =0x0000091C
	add r0, r0, r1
	bl StageSelectMenu__Unknown__Release
	pop {r3, pc}
	.align 2, 0
_021674DC: .word VSMenu__Singleton
_021674E0: .word 0x0000091C
	thumb_func_end VSMenu__Func_21674C8

	thumb_func_start VSMenuBackButton__TouchCallback
VSMenuBackButton__TouchCallback: // 0x021674E4
	push {r3, r4, r5, lr}
	mov r4, #1
	ldr r3, [r1, #0x14]
	mov r1, r2
	ldr r5, [r0, #0]
	lsl r4, r4, #0x10
	add r1, #0x64
	cmp r5, r4
	beq _02167504
	lsl r0, r4, #1
	cmp r5, r0
	beq _02167514
	lsl r0, r4, #2
	cmp r5, r0
	beq _02167524
	pop {r3, r4, r5, pc}
_02167504:
	lsr r0, r4, #5
	tst r0, r3
	bne _0216752E
	mov r0, r1
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	pop {r3, r4, r5, pc}
_02167514:
	lsr r0, r4, #5
	tst r0, r3
	bne _0216752E
	mov r0, r1
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	pop {r3, r4, r5, pc}
_02167524:
	ldr r1, [r2, #0xc]
	cmp r1, #0
	beq _0216752E
	ldr r0, [r2, #0x10]
	blx r1
_0216752E:
	pop {r3, r4, r5, pc}
	thumb_func_end VSMenuBackButton__TouchCallback

	thumb_func_start VSMenu__Func_2167530
VSMenu__Func_2167530: // 0x02167530
	push {r3, lr}
	cmp r0, #6
	bhi _02167590
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02167542: // jump table
	.hword _02167550 - _02167542 - 2 // case 0
	.hword _02167564 - _02167542 - 2 // case 1
	.hword _02167590 - _02167542 - 2 // case 2
	.hword _0216756C - _02167542 - 2 // case 3
	.hword _02167590 - _02167542 - 2 // case 4
	.hword _02167558 - _02167542 - 2 // case 5
	.hword _02167574 - _02167542 - 2 // case 6
_02167550:
	ldr r0, _02167594 // =VSMenu__Func_21675D4
	bl VSMenu__SetTouchCallback
	pop {r3, pc}
_02167558:
	ldr r0, _02167598 // =VSMenu__Singleton
	mov r1, r2
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	b _0216757C
_02167564:
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0216757C
_0216756C:
	mov r0, #1
	bl PlaySysMenuNavSfx
	b _0216757C
_02167574:
	mov r0, #2
	bl PlaySysMenuNavSfx
	pop {r3, pc}
_0216757C:
	ldr r0, _0216759C // =0x0000FFFF
	bl VSMenu__Func_21667F0
	ldr r0, _0216759C // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
_02167590:
	pop {r3, pc}
	nop
_02167594: .word VSMenu__Func_21675D4
_02167598: .word VSMenu__Singleton
_0216759C: .word 0x0000FFFF
	thumb_func_end VSMenu__Func_2167530

	thumb_func_start VSMenu__Func_21675A0
VSMenu__Func_21675A0: // 0x021675A0
	push {r3, lr}
	cmp r0, #0
	beq _021675B0
	cmp r0, #2
	beq _021675B8
	cmp r0, #4
	beq _021675C0
	pop {r3, pc}
_021675B0:
	ldrh r0, [r2, #4]
	bl VSMenu__SetNetworkMessageSequence
	pop {r3, pc}
_021675B8:
	ldr r0, _021675CC // =0x0000FFFF
	bl VSMenu__Func_21667F0
	pop {r3, pc}
_021675C0:
	ldr r0, _021675D0 // =VSMenu__Singleton
	ldr r1, [r2, #0]
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_021675CC: .word 0x0000FFFF
_021675D0: .word VSMenu__Singleton
	thumb_func_end VSMenu__Func_21675A0

	thumb_func_start VSMenu__Func_21675D4
VSMenu__Func_21675D4: // 0x021675D4
	ldr r1, _021675DC // =0x000007D4
	ldr r3, _021675E0 // =StageSelectMenu__Unknown__Func_2169D20
	ldr r1, [r0, r1]
	bx r3
	.align 2, 0
_021675DC: .word 0x000007D4
_021675E0: .word StageSelectMenu__Unknown__Func_2169D20
	thumb_func_end VSMenu__Func_21675D4

	thumb_func_start VSMenu__Func_21675E4
VSMenu__Func_21675E4: // 0x021675E4
	ldr r3, _021675EC // =VSMenu__ChangeEvent
	mov r0, #0
	bx r3
	nop
_021675EC: .word VSMenu__ChangeEvent
	thumb_func_end VSMenu__Func_21675E4

	thumb_func_start VSMenu__Main
VSMenu__Main: // 0x021675F0
	push {r3, r4, r5, lr}
	sub sp, #0x20
	ldr r0, _021676E4 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r5, _021676E8 // =0x0000091C
	mov r0, #0
	bl VSMenu__Func_21667F0
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A3C4
	mov r1, #0x30
	mov r0, #0x80
	str r0, [sp]
	add r0, r4, r5
	mov r2, r1
	mov r3, r1
	bl StageSelectMenu__Unknown__Func_216A1B8
	mov r0, #0x14
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	sub r0, r0, #6
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _021676EC // =VSMenu__Func_21675A0
	mov r2, #0x15
	str r0, [sp, #0x18]
	ldr r0, _021676F0 // =0x0217DFEC
	mov r3, #0x13
	str r0, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r1, #0x17
	str r1, [sp]
	mov r0, #6
	str r0, [sp, #4]
	sub r0, r0, #7
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	ldr r0, _021676EC // =VSMenu__Func_21675A0
	str r1, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r0, _021676F4 // =0x0217DFF4
	mov r2, #0x18
	str r0, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	add r0, r4, r5
	mov r3, #0x16
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r0, #0x1a
	str r0, [sp]
	mov r0, #7
	str r0, [sp, #4]
	sub r0, #8
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _021676EC // =VSMenu__Func_21675A0
	mov r2, #0x1b
	str r0, [sp, #0x18]
	ldr r0, _021676F8 // =0x0217DFFC
	mov r3, #0x19
	str r0, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r0, #0x1d
	str r0, [sp]
	mov r0, #8
	str r0, [sp, #4]
	sub r0, #9
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _021676EC // =VSMenu__Func_21675A0
	mov r2, #0x1e
	str r0, [sp, #0x18]
	ldr r0, _021676FC // =0x0217E004
	mov r3, #0x1c
	str r0, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A1DC
	ldr r0, _02167700 // =VSMenu__Func_21675E4
	mov r1, #0
	str r0, [sp]
	ldr r3, _02167704 // =VSMenu__Func_2167530
	add r0, r4, r5
	mov r2, r1
	bl StageSelectMenu__Unknown__Func_2169B78
	ldr r0, _02167708 // =VSMenu__Main_2167950
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r3, r4, r5, pc}
	.align 2, 0
_021676E4: .word VSMenu__Singleton
_021676E8: .word 0x0000091C
_021676EC: .word VSMenu__Func_21675A0
_021676F0: .word 0x0217DFEC
_021676F4: .word 0x0217DFF4
_021676F8: .word 0x0217DFFC
_021676FC: .word 0x0217E004
_02167700: .word VSMenu__Func_21675E4
_02167704: .word VSMenu__Func_2167530
_02167708: .word VSMenu__Main_2167950
	thumb_func_end VSMenu__Main

	thumb_func_start VSMenu__Main_216770C
VSMenu__Main_216770C: // 0x0216770C
	push {r4, r5, r6, lr}
	sub sp, #0x20
	ldr r0, _0216783C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, r0
	ldr r4, _02167840 // =0x0000091C
	mov r0, #4
	bl VSMenu__Func_21667F0
	add r0, r5, r4
	bl StageSelectMenu__Unknown__Func_216A3C4
	mov r1, #0x30
	mov r0, #0x80
	str r0, [sp]
	add r0, r5, r4
	mov r2, r1
	mov r3, r1
	bl StageSelectMenu__Unknown__Func_216A1B8
	mov r0, #0x26
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	sub r0, r0, #6
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02167844 // =VSMenu__Func_21675A0
	mov r2, #0x27
	str r0, [sp, #0x18]
	ldr r0, _02167848 // =0x0217E00C
	mov r3, #0x25
	str r0, [sp, #0x1c]
	ldr r1, [r5, #0x14]
	add r0, r5, r4
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r6, r0
	mov r0, #4
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x24]
	add r0, r5, r4
	mov r1, r6
	mov r3, #0
	bl StageSelectMenu__Unknown__Func_216A2D0
	mov r0, #3
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x24]
	add r0, r5, r4
	mov r1, r6
	mov r3, #5
	bl StageSelectMenu__Unknown__Func_216A348
	mov r0, #0x29
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	sub r0, r0, #7
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02167844 // =VSMenu__Func_21675A0
	mov r2, #0x2a
	str r0, [sp, #0x18]
	ldr r0, _0216784C // =0x0217E014
	mov r3, #0x28
	str r0, [sp, #0x1c]
	ldr r1, [r5, #0x14]
	add r0, r5, r4
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r0, #0x2c
	str r0, [sp]
	mov r0, #7
	str r0, [sp, #4]
	sub r0, #8
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02167844 // =VSMenu__Func_21675A0
	mov r2, #0x2d
	str r0, [sp, #0x18]
	ldr r0, _02167850 // =0x0217E01C
	mov r3, #0x2b
	str r0, [sp, #0x1c]
	ldr r1, [r5, #0x14]
	add r0, r5, r4
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r6, r0
	mov r0, #4
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x24]
	add r0, r5, r4
	mov r1, r6
	mov r3, #0
	bl StageSelectMenu__Unknown__Func_216A2D0
	mov r0, #3
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x24]
	add r0, r5, r4
	mov r1, r6
	mov r3, #5
	bl StageSelectMenu__Unknown__Func_216A348
	ldr r0, _02167854 // =VSMenu__Main
	mov r1, #0
	str r0, [sp]
	ldr r3, _02167858 // =VSMenu__Func_2167530
	add r0, r5, r4
	mov r2, r1
	bl StageSelectMenu__Unknown__Func_2169B78
	ldr r0, _0216785C // =VSMenu__Main_2167950
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r4, r5, r6, pc}
	nop
_0216783C: .word VSMenu__Singleton
_02167840: .word 0x0000091C
_02167844: .word VSMenu__Func_21675A0
_02167848: .word 0x0217E00C
_0216784C: .word 0x0217E014
_02167850: .word 0x0217E01C
_02167854: .word VSMenu__Main
_02167858: .word VSMenu__Func_2167530
_0216785C: .word VSMenu__Main_2167950
	thumb_func_end VSMenu__Main_216770C

	thumb_func_start VSMenu__Func_2167860
VSMenu__Func_2167860: // 0x02167860
	push {r3, r4, r5, lr}
	sub sp, #0x20
	ldr r0, _0216792C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r5, _02167930 // =0x0000091C
	mov r0, #2
	bl VSMenu__Func_21667F0
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A3C4
	mov r1, #0x30
	mov r0, #0x80
	str r0, [sp]
	add r0, r4, r5
	mov r2, r1
	mov r3, r1
	bl StageSelectMenu__Unknown__Func_216A1B8
	mov r0, #0x20
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	sub r0, r0, #6
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02167934 // =VSMenu__Func_21675A0
	mov r2, #0x21
	str r0, [sp, #0x18]
	ldr r0, _02167938 // =0x0217E024
	mov r3, #0x1f
	str r0, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r0, #0x35
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	sub r0, r0, #7
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02167934 // =VSMenu__Func_21675A0
	mov r2, #0x36
	str r0, [sp, #0x18]
	ldr r0, _0216793C // =0x0217E02C
	mov r3, #0x34
	str r0, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r0, #0x38
	str r0, [sp]
	mov r0, #7
	str r0, [sp, #4]
	sub r0, #8
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02167934 // =VSMenu__Func_21675A0
	mov r2, #0x39
	str r0, [sp, #0x18]
	ldr r0, _02167940 // =0x0217E034
	mov r3, #0x37
	str r0, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A1DC
	ldr r0, _02167944 // =VSMenu__Main_216770C
	mov r1, #0
	str r0, [sp]
	ldr r3, _02167948 // =VSMenu__Func_2167530
	add r0, r4, r5
	mov r2, r1
	bl StageSelectMenu__Unknown__Func_2169B78
	ldr r0, _0216794C // =VSMenu__Main_2167950
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r3, r4, r5, pc}
	nop
_0216792C: .word VSMenu__Singleton
_02167930: .word 0x0000091C
_02167934: .word VSMenu__Func_21675A0
_02167938: .word 0x0217E024
_0216793C: .word 0x0217E02C
_02167940: .word 0x0217E034
_02167944: .word VSMenu__Main_216770C
_02167948: .word VSMenu__Func_2167530
_0216794C: .word VSMenu__Main_2167950
	thumb_func_end VSMenu__Func_2167860

	thumb_func_start VSMenu__Main_2167950
VSMenu__Main_2167950: // 0x02167950
	push {r4, lr}
	ldr r0, _021679BC // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0x11
	bgt _0216796C
	bge _021679AA
	cmp r0, #0
	beq _0216797C
	b _021679AA
_0216796C:
	cmp r0, #0x19
	bgt _021679AA
	cmp r0, #0x16
	blt _021679AA
	beq _021679AA
	cmp r0, #0x19
	beq _02167994
	b _021679AA
_0216797C:
	ldr r0, _021679C0 // =0x00001148
	mov r1, #0
	str r1, [r4, r0]
	ldr r1, [r4, r0]
	add r0, r0, #4
	str r1, [r4, r0]
	ldr r0, _021679BC // =VSMenu__Singleton
	ldr r1, _021679C4 // =VSMenu__Main_21692B8
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r4, pc}
_02167994:
	ldr r0, _021679C0 // =0x00001148
	mov r1, #0
	str r1, [r4, r0]
	ldr r1, [r4, r0]
	add r0, r0, #4
	str r1, [r4, r0]
	ldr r0, _021679BC // =VSMenu__Singleton
	ldr r1, _021679C8 // =VSMenu__Main_2169324
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
_021679AA:
	ldr r0, _021679CC // =0x0000091C
	add r0, r4, r0
	bl StageSelectMenu__Unknown__Process
	ldr r0, _021679CC // =0x0000091C
	add r0, r4, r0
	bl StageSelectMenu__Unknown__Draw
	pop {r4, pc}
	.align 2, 0
_021679BC: .word VSMenu__Singleton
_021679C0: .word 0x00001148
_021679C4: .word VSMenu__Main_21692B8
_021679C8: .word VSMenu__Main_2169324
_021679CC: .word 0x0000091C
	thumb_func_end VSMenu__Main_2167950

	thumb_func_start VSMenu__Main_GotoHubMenu
VSMenu__Main_GotoHubMenu: // 0x021679D0
	push {r3, lr}
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	mov r0, #3
	bl VSMenu__Func_2166874
	ldr r0, _021679E8 // =VSMenu__Main_GotoVSMenu
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_021679E8: .word VSMenu__Main_GotoVSMenu
	thumb_func_end VSMenu__Main_GotoHubMenu

	thumb_func_start VSMenu__Main_GotoVSMenu
VSMenu__Main_GotoVSMenu: // 0x021679EC
	push {r3, lr}
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _02167A0A
	bl DestroyDrawFadeTask
	ldr r0, _02167A0C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl VSMenu__Destroy
	bl NextSysEvent
	bl DestroyCurrentTask
_02167A0A:
	pop {r3, pc}
	.align 2, 0
_02167A0C: .word VSMenu__Singleton
	thumb_func_end VSMenu__Main_GotoVSMenu

	thumb_func_start VSMenu__Main_2167A10
VSMenu__Main_2167A10: // 0x02167A10
	push {r4, lr}
	ldr r0, _02167A34 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0xa
	bl VSMenu__Func_21667F0
	ldr r0, _02167A38 // =0x00001874
	mov r1, #0
	add r0, r4, r0
	bl VSRecordsMenu__Create
	ldr r0, _02167A3C // =VSMenu__Main_2167A40
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_02167A34: .word VSMenu__Singleton
_02167A38: .word 0x00001874
_02167A3C: .word VSMenu__Main_2167A40
	thumb_func_end VSMenu__Main_2167A10

	thumb_func_start VSMenu__Main_2167A40
VSMenu__Main_2167A40: // 0x02167A40
	push {r3, lr}
	ldr r0, _02167A60 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _02167A64 // =0x00001874
	add r0, r0, r1
	bl VSRecordsMenu__Func_2173204
	cmp r0, #0
	beq _02167A5C
	ldr r0, _02167A68 // =VSMenu__Main
	bl SetCurrentTaskMainEvent
_02167A5C:
	pop {r3, pc}
	nop
_02167A60: .word VSMenu__Singleton
_02167A64: .word 0x00001874
_02167A68: .word VSMenu__Main
	thumb_func_end VSMenu__Main_2167A40

	thumb_func_start VSMenu__Main_2167A6C
VSMenu__Main_2167A6C: // 0x02167A6C
	push {r4, r5, r6, lr}
	sub sp, #0x20
	ldr r0, _02167B3C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, r0
	ldr r4, _02167B40 // =0x0000091C
	mov r0, #0xf
	bl VSMenu__Func_21667F0
	add r0, r5, r4
	bl StageSelectMenu__Unknown__Func_216A3C4
	mov r0, #0x70
	mov r1, #0x30
	str r0, [sp]
	add r0, r5, r4
	mov r2, #0x40
	mov r3, r1
	bl StageSelectMenu__Unknown__Func_216A1B8
	mov r0, #0x3b
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	sub r0, r0, #6
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02167B44 // =VSMenu__Func_21675A0
	mov r2, #0x3c
	str r0, [sp, #0x18]
	ldr r0, _02167B48 // =0x0217E06C
	mov r3, #0x3a
	str r0, [sp, #0x1c]
	ldr r1, [r5, #0x14]
	add r0, r5, r4
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r0, #0x3e
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	sub r0, r0, #7
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02167B44 // =VSMenu__Func_21675A0
	mov r2, #0x3f
	str r0, [sp, #0x18]
	ldr r0, _02167B4C // =0x0217E084
	mov r3, #0x3d
	str r0, [sp, #0x1c]
	ldr r1, [r5, #0x14]
	add r0, r5, r4
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r6, r0
	mov r0, #3
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x20]
	add r0, r5, r4
	mov r1, r6
	mov r3, #0
	bl StageSelectMenu__Unknown__Func_216A2D0
	mov r0, #3
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x20]
	add r0, r5, r4
	mov r1, r6
	mov r3, #5
	bl StageSelectMenu__Unknown__Func_216A348
	ldr r0, _02167B50 // =VSMenu__Main
	mov r1, #0
	str r0, [sp]
	ldr r3, _02167B54 // =VSMenu__Func_2167530
	add r0, r5, r4
	mov r2, r1
	bl StageSelectMenu__Unknown__Func_2169B78
	ldr r0, _02167B58 // =VSMenu__Main_2167950
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r4, r5, r6, pc}
	.align 2, 0
_02167B3C: .word VSMenu__Singleton
_02167B40: .word 0x0000091C
_02167B44: .word VSMenu__Func_21675A0
_02167B48: .word 0x0217E06C
_02167B4C: .word 0x0217E084
_02167B50: .word VSMenu__Main
_02167B54: .word VSMenu__Func_2167530
_02167B58: .word VSMenu__Main_2167950
	thumb_func_end VSMenu__Main_2167A6C

	thumb_func_start VSMenu__Main_2167B5C
VSMenu__Main_2167B5C: // 0x02167B5C
	push {r4, r5, r6, lr}
	sub sp, #0x20
	ldr r0, _02167C60 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, r0
	ldr r4, _02167C64 // =0x0000091C
	mov r0, #0xb
	bl VSMenu__Func_21667F0
	add r0, r5, r4
	bl StageSelectMenu__Unknown__Func_216A3C4
	mov r0, #0x70
	mov r1, #0x30
	str r0, [sp]
	add r0, r5, r4
	mov r2, #0x40
	mov r3, r1
	bl StageSelectMenu__Unknown__Func_216A1B8
	mov r0, #0x41
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	sub r0, r0, #6
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02167C68 // =VSMenu__Func_21675A0
	mov r2, #0x42
	str r0, [sp, #0x18]
	ldr r0, _02167C6C // =0x0217E074
	mov r3, #0x40
	str r0, [sp, #0x1c]
	ldr r1, [r5, #0x14]
	add r0, r5, r4
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r6, r0
	mov r0, #3
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x20]
	add r0, r5, r4
	mov r1, r6
	mov r3, #0
	bl StageSelectMenu__Unknown__Func_216A2D0
	mov r0, #3
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x20]
	add r0, r5, r4
	mov r1, r6
	mov r3, #5
	bl StageSelectMenu__Unknown__Func_216A348
	mov r0, #0x44
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	sub r0, r0, #7
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02167C68 // =VSMenu__Func_21675A0
	mov r2, #0x45
	str r0, [sp, #0x18]
	ldr r0, _02167C70 // =0x0217E07C
	mov r3, #0x43
	str r0, [sp, #0x1c]
	ldr r1, [r5, #0x14]
	add r0, r5, r4
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r6, r0
	mov r0, #3
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x20]
	add r0, r5, r4
	mov r1, r6
	mov r3, #0
	bl StageSelectMenu__Unknown__Func_216A2D0
	mov r0, #3
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x20]
	add r0, r5, r4
	mov r1, r6
	mov r3, #5
	bl StageSelectMenu__Unknown__Func_216A348
	ldr r0, _02167C74 // =VSMenu__Main_2167A6C
	mov r1, #0
	str r0, [sp]
	ldr r3, _02167C78 // =VSMenu__Func_2167530
	add r0, r5, r4
	mov r2, r1
	bl StageSelectMenu__Unknown__Func_2169B78
	ldr r0, _02167C7C // =VSMenu__Main_2167950
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r4, r5, r6, pc}
	nop
_02167C60: .word VSMenu__Singleton
_02167C64: .word 0x0000091C
_02167C68: .word VSMenu__Func_21675A0
_02167C6C: .word 0x0217E074
_02167C70: .word 0x0217E07C
_02167C74: .word VSMenu__Main_2167A6C
_02167C78: .word VSMenu__Func_2167530
_02167C7C: .word VSMenu__Main_2167950
	thumb_func_end VSMenu__Main_2167B5C

	thumb_func_start VSMenu__Main_2167C80
VSMenu__Main_2167C80: // 0x02167C80
	push {r3, r4, lr}
	sub sp, #0xc
	ldr r0, _02167CCC // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x11
	bl VSMenu__Func_21667F0
	mov r0, #1
	bl RenderCore_DisableSoftReset
	mov r0, #1
	bl RenderCore_SetNextFoldMode
	mov r0, #0
	str r0, [sp]
	mov r1, #0xe4
	str r1, [sp, #4]
	mov r1, #0xa6
	str r1, [sp, #8]
	mov r1, r0
	mov r2, #0xb
	mov r3, #1
	bl CreateConnectionStatusIcon
	ldr r0, _02167CD0 // =0x00000918
	mov r1, #2
	ldr r0, [r4, r0]
	lsl r1, r1, #0xe
	bl VSConnectionMenu__Create
	ldr r0, _02167CD4 // =VSMenu__Main_2167D8C
	bl SetCurrentTaskMainEvent
	add sp, #0xc
	pop {r3, r4, pc}
	.align 2, 0
_02167CCC: .word VSMenu__Singleton
_02167CD0: .word 0x00000918
_02167CD4: .word VSMenu__Main_2167D8C
	thumb_func_end VSMenu__Main_2167C80

	thumb_func_start VSMenu__Main_2167CD8
VSMenu__Main_2167CD8: // 0x02167CD8
	push {r3, r4, lr}
	sub sp, #0xc
	ldr r0, _02167D24 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x12
	bl VSMenu__Func_21667F0
	mov r0, #1
	bl RenderCore_DisableSoftReset
	mov r0, #1
	bl RenderCore_SetNextFoldMode
	mov r0, #0
	str r0, [sp]
	mov r1, #0xe4
	str r1, [sp, #4]
	mov r1, #0xa6
	str r1, [sp, #8]
	mov r1, r0
	mov r2, #0xb
	mov r3, #1
	bl CreateConnectionStatusIcon
	ldr r0, _02167D28 // =0x00000918
	ldr r1, _02167D2C // =0x00008004
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Create
	ldr r0, _02167D30 // =VSMenu__Main_2167D8C
	bl SetCurrentTaskMainEvent
	add sp, #0xc
	pop {r3, r4, pc}
	nop
_02167D24: .word VSMenu__Singleton
_02167D28: .word 0x00000918
_02167D2C: .word 0x00008004
_02167D30: .word VSMenu__Main_2167D8C
	thumb_func_end VSMenu__Main_2167CD8

	thumb_func_start VSMenu__Main_2167D34
VSMenu__Main_2167D34: // 0x02167D34
	push {r3, r4, lr}
	sub sp, #0xc
	ldr r0, _02167D80 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0xf
	bl VSMenu__Func_21667F0
	mov r0, #1
	bl RenderCore_DisableSoftReset
	mov r0, #1
	bl RenderCore_SetNextFoldMode
	mov r0, #0
	str r0, [sp]
	mov r1, #0xe4
	str r1, [sp, #4]
	mov r1, #0xa6
	str r1, [sp, #8]
	mov r1, r0
	mov r2, #0xb
	mov r3, #1
	bl CreateConnectionStatusIcon
	ldr r0, _02167D84 // =0x00000918
	mov r1, #0x81
	ldr r0, [r4, r0]
	lsl r1, r1, #8
	bl VSConnectionMenu__Create
	ldr r0, _02167D88 // =VSMenu__Main_2167D8C
	bl SetCurrentTaskMainEvent
	add sp, #0xc
	pop {r3, r4, pc}
	.align 2, 0
_02167D80: .word VSMenu__Singleton
_02167D84: .word 0x00000918
_02167D88: .word VSMenu__Main_2167D8C
	thumb_func_end VSMenu__Main_2167D34

	thumb_func_start VSMenu__Main_2167D8C
VSMenu__Main_2167D8C: // 0x02167D8C
	push {r4, lr}
	ldr r0, _02167E10 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _02167E14 // =0x00000918
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Func_216AC10
	cmp r0, #0
	beq _02167E0E
	ldr r0, _02167E14 // =0x00000918
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Func_216AC48
	cmp r0, #4
	bhi _02167E0E
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02167DBC: // jump table
	.hword _02167E0E - _02167DBC - 2 // case 0
	.hword _02167DC6 - _02167DBC - 2 // case 1
	.hword _02167DCE - _02167DBC - 2 // case 2
	.hword _02167E00 - _02167DBC - 2 // case 3
	.hword _02167E08 - _02167DBC - 2 // case 4
_02167DC6:
	mov r0, #1
	bl VSMenu__ChangeEvent
	pop {r4, pc}
_02167DCE:
	ldr r0, _02167E14 // =0x00000918
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Func_216AC44
	mov r4, r0
	mov r0, #0
	bl RenderCore_DisableSoftReset
	mov r0, #0
	bl RenderCore_SetNextFoldMode
	bl DestroyConnectionStatusIcon
	mov r0, #1
	lsl r0, r0, #8
	tst r0, r4
	bne _02167DF8
	ldr r0, _02167E18 // =VSMenu__Main_2167B5C
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02167DF8:
	ldr r0, _02167E1C // =VSMenu__Main_2167A6C
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02167E00:
	ldr r0, _02167E20 // =VSMenu__Main_21692B8
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02167E08:
	ldr r0, _02167E24 // =VSMenu__Main_2169324
	bl SetCurrentTaskMainEvent
_02167E0E:
	pop {r4, pc}
	.align 2, 0
_02167E10: .word VSMenu__Singleton
_02167E14: .word 0x00000918
_02167E18: .word VSMenu__Main_2167B5C
_02167E1C: .word VSMenu__Main_2167A6C
_02167E20: .word VSMenu__Main_21692B8
_02167E24: .word VSMenu__Main_2169324
	thumb_func_end VSMenu__Main_2167D8C

	thumb_func_start VSMenu__Main_2167E28
VSMenu__Main_2167E28: // 0x02167E28
	push {r4, r5, r6, lr}
	sub sp, #0x20
	ldr r0, _02167F2C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, r0
	ldr r4, _02167F30 // =0x0000091C
	mov r0, #0xb
	bl VSMenu__Func_21667F0
	add r0, r5, r4
	bl StageSelectMenu__Unknown__Func_216A3C4
	mov r0, #0x70
	mov r1, #0x30
	str r0, [sp]
	add r0, r5, r4
	mov r2, #0x40
	mov r3, r1
	bl StageSelectMenu__Unknown__Func_216A1B8
	mov r0, #0x41
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	sub r0, r0, #6
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02167F34 // =VSMenu__Func_21675A0
	mov r2, #0x42
	str r0, [sp, #0x18]
	ldr r0, _02167F38 // =0x0217E08C
	mov r3, #0x40
	str r0, [sp, #0x1c]
	ldr r1, [r5, #0x14]
	add r0, r5, r4
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r6, r0
	mov r0, #3
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x20]
	add r0, r5, r4
	mov r1, r6
	mov r3, #0
	bl StageSelectMenu__Unknown__Func_216A2D0
	mov r0, #3
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x20]
	add r0, r5, r4
	mov r1, r6
	mov r3, #5
	bl StageSelectMenu__Unknown__Func_216A348
	mov r0, #0x44
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	sub r0, r0, #7
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02167F34 // =VSMenu__Func_21675A0
	mov r2, #0x45
	str r0, [sp, #0x18]
	ldr r0, _02167F3C // =0x0217E094
	mov r3, #0x43
	str r0, [sp, #0x1c]
	ldr r1, [r5, #0x14]
	add r0, r5, r4
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r6, r0
	mov r0, #3
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x20]
	add r0, r5, r4
	mov r1, r6
	mov r3, #0
	bl StageSelectMenu__Unknown__Func_216A2D0
	mov r0, #3
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r5, #0x20]
	add r0, r5, r4
	mov r1, r6
	mov r3, #5
	bl StageSelectMenu__Unknown__Func_216A348
	ldr r0, _02167F40 // =VSMenu__Main
	mov r1, #0
	str r0, [sp]
	ldr r3, _02167F44 // =VSMenu__Func_2167530
	add r0, r5, r4
	mov r2, r1
	bl StageSelectMenu__Unknown__Func_2169B78
	ldr r0, _02167F48 // =VSMenu__Main_2167950
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r4, r5, r6, pc}
	nop
_02167F2C: .word VSMenu__Singleton
_02167F30: .word 0x0000091C
_02167F34: .word VSMenu__Func_21675A0
_02167F38: .word 0x0217E08C
_02167F3C: .word 0x0217E094
_02167F40: .word VSMenu__Main
_02167F44: .word VSMenu__Func_2167530
_02167F48: .word VSMenu__Main_2167950
	thumb_func_end VSMenu__Main_2167E28

	thumb_func_start VSMenu__Main_2167F4C
VSMenu__Main_2167F4C: // 0x02167F4C
	push {r3, r4, lr}
	sub sp, #0xc
	ldr r0, _02167F9C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x11
	bl VSMenu__Func_21667F0
	bl VSMenu__Main_2168090
	mov r0, #1
	bl RenderCore_DisableSoftReset
	mov r0, #1
	bl RenderCore_SetNextFoldMode
	mov r0, #0
	str r0, [sp]
	mov r1, #0xe4
	str r1, [sp, #4]
	mov r1, #0xa6
	str r1, [sp, #8]
	mov r1, r0
	mov r2, #0xb
	mov r3, #1
	bl CreateConnectionStatusIcon
	ldr r0, _02167FA0 // =0x00000918
	ldr r1, _02167FA4 // =0x00008001
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Create
	ldr r0, _02167FA8 // =VSMenu__Main_216800C
	bl SetCurrentTaskMainEvent
	add sp, #0xc
	pop {r3, r4, pc}
	nop
_02167F9C: .word VSMenu__Singleton
_02167FA0: .word 0x00000918
_02167FA4: .word 0x00008001
_02167FA8: .word VSMenu__Main_216800C
	thumb_func_end VSMenu__Main_2167F4C

	thumb_func_start VSMenu__Main_2167FAC
VSMenu__Main_2167FAC: // 0x02167FAC
	push {r3, r4, lr}
	sub sp, #0xc
	ldr r0, _02167FFC // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x12
	bl VSMenu__Func_21667F0
	bl VSMenu__Main_2168090
	mov r0, #1
	bl RenderCore_DisableSoftReset
	mov r0, #1
	bl RenderCore_SetNextFoldMode
	mov r0, #0
	str r0, [sp]
	mov r1, #0xe4
	str r1, [sp, #4]
	mov r1, #0xa6
	str r1, [sp, #8]
	mov r1, r0
	mov r2, #0xb
	mov r3, #1
	bl CreateConnectionStatusIcon
	ldr r0, _02168000 // =0x00000918
	ldr r1, _02168004 // =0x00008005
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Create
	ldr r0, _02168008 // =VSMenu__Main_216800C
	bl SetCurrentTaskMainEvent
	add sp, #0xc
	pop {r3, r4, pc}
	nop
_02167FFC: .word VSMenu__Singleton
_02168000: .word 0x00000918
_02168004: .word 0x00008005
_02168008: .word VSMenu__Main_216800C
	thumb_func_end VSMenu__Main_2167FAC

	thumb_func_start VSMenu__Main_216800C
VSMenu__Main_216800C: // 0x0216800C
	push {r4, lr}
	ldr r0, _0216807C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _02168080 // =0x00000918
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Func_216AC10
	cmp r0, #0
	beq _02168078
	bl VSMenu__Main_21680D8
	ldr r0, _02168080 // =0x00000918
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Func_216AC48
	cmp r0, #4
	bhi _02168078
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02168040: // jump table
	.hword _02168078 - _02168040 - 2 // case 0
	.hword _0216804A - _02168040 - 2 // case 1
	.hword _02168052 - _02168040 - 2 // case 2
	.hword _0216806A - _02168040 - 2 // case 3
	.hword _02168072 - _02168040 - 2 // case 4
_0216804A:
	mov r0, #1
	bl VSMenu__ChangeEvent
	pop {r4, pc}
_02168052:
	ldr r0, _02168084 // =VSMenu__Main_2167E28
	bl SetCurrentTaskMainEvent
	mov r0, #0
	bl RenderCore_DisableSoftReset
	mov r0, #0
	bl RenderCore_SetNextFoldMode
	bl DestroyConnectionStatusIcon
	pop {r4, pc}
_0216806A:
	ldr r0, _02168088 // =VSMenu__Main_21692B8
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02168072:
	ldr r0, _0216808C // =VSMenu__Main_2169324
	bl SetCurrentTaskMainEvent
_02168078:
	pop {r4, pc}
	nop
_0216807C: .word VSMenu__Singleton
_02168080: .word 0x00000918
_02168084: .word VSMenu__Main_2167E28
_02168088: .word VSMenu__Main_21692B8
_0216808C: .word VSMenu__Main_2169324
	thumb_func_end VSMenu__Main_216800C

	thumb_func_start VSMenu__Main_2168090
VSMenu__Main_2168090: // 0x02168090
	push {r4, lr}
	ldr r0, _021680C4 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _021680C8 // =0x00001874
	add r0, r4, r0
	bl VSRecordsMenu__ReleaseAssets
	ldr r0, _021680CC // =0x0000186C
	add r0, r4, r0
	bl VSViewFriendCodeMenu__ReleaseAssets
	ldr r0, _021680D0 // =0x00001864
	add r0, r4, r0
	bl VSRegisterFriendCodeMenu__Release
	ldr r0, _021680D4 // =0x00001294
	add r0, r4, r0
	bl VSFriendListMenu__ReleaseAssets
	bl VSMenu__Func_21674C8
	pop {r4, pc}
	nop
_021680C4: .word VSMenu__Singleton
_021680C8: .word 0x00001874
_021680CC: .word 0x0000186C
_021680D0: .word 0x00001864
_021680D4: .word 0x00001294
	thumb_func_end VSMenu__Main_2168090

	thumb_func_start VSMenu__Main_21680D8
VSMenu__Main_21680D8: // 0x021680D8
	push {r4, lr}
	ldr r0, _0216810C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl VSMenu__Func_2167464
	ldr r0, _02168110 // =0x00001294
	add r0, r4, r0
	bl VSFriendListMenu__LoadAssets
	ldr r0, _02168114 // =0x00001864
	add r0, r4, r0
	bl VSRegisterFriendCodeMenu__Init
	ldr r0, _02168118 // =0x0000186C
	add r0, r4, r0
	bl VSViewFriendCodeMenu__LoadAssets
	ldr r0, _0216811C // =0x00001874
	add r0, r4, r0
	bl VSRecordsMenu__LoadAssets
	pop {r4, pc}
	nop
_0216810C: .word VSMenu__Singleton
_02168110: .word 0x00001294
_02168114: .word 0x00001864
_02168118: .word 0x0000186C
_0216811C: .word 0x00001874
	thumb_func_end VSMenu__Main_21680D8

	thumb_func_start VSMenu__Main_2168120
VSMenu__Main_2168120: // 0x02168120
	push {r3, lr}
	sub sp, #8
	mov r0, #4
	bl VSMenu__Func_21667F0
	bl MultibootManager__Func_2061638
	cmp r0, #0
	beq _02168188
	bl MultibootManager__Func_20618F0
	cmp r0, #0
	bne _0216815C
	mov r0, #0x1e
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r2, #1
	str r2, [sp]
	mov r1, #0
	mov r3, #5
	str r1, [sp, #4]
	bl SaveSpriteButton__Func_2064588
	ldr r0, _021681B8 // =VSMenu__Main_2168388
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_0216815C:
	bl MultibootManager__Func_2061904
	cmp r0, #0
	bne _021681AC
	mov r0, #0x20
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #5
	bl SaveSpriteButton__Func_2064588
	ldr r0, _021681BC // =VSMenu__Main_2168424
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_02168188:
	mov r0, #0x1c
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #5
	bl SaveSpriteButton__Func_2064588
	ldr r0, _021681C0 // =VSMenu__Main_2168470
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_021681AC:
	ldr r0, _021681C4 // =VSMenu__Main_21681C8
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
	nop
_021681B8: .word VSMenu__Main_2168388
_021681BC: .word VSMenu__Main_2168424
_021681C0: .word VSMenu__Main_2168470
_021681C4: .word VSMenu__Main_21681C8
	thumb_func_end VSMenu__Main_2168120

	thumb_func_start VSMenu__Main_21681C8
VSMenu__Main_21681C8: // 0x021681C8
	push {r3, lr}
	sub sp, #8
	mov r0, #0x1d
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r2, #1
	str r2, [sp]
	mov r1, #0
	mov r3, #5
	str r1, [sp, #4]
	bl SaveSpriteButton__Func_2064588
	ldr r0, _021681F0 // =VSMenu__Main_21681F4
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
	nop
_021681F0: .word VSMenu__Main_21681F4
	thumb_func_end VSMenu__Main_21681C8

	thumb_func_start VSMenu__Main_21681F4
VSMenu__Main_21681F4: // 0x021681F4
	push {lr}
	sub sp, #0xc
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _02168276
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #0
	beq _02168220
	cmp r0, #1
	beq _02168264
	add sp, #0xc
	pop {pc}
_02168220:
	mov r0, #1
	bl RenderCore_DisableSoftReset
	mov r0, #1
	bl RenderCore_SetNextFoldMode
	mov r1, #0
	str r1, [sp]
	mov r0, #0xe4
	str r0, [sp, #4]
	mov r0, #0xa6
	str r0, [sp, #8]
	mov r0, #1
	mov r2, #0xb
	mov r3, r0
	bl CreateConnectionStatusIcon
	bl MultibootManager__Func_2061654
	mov r0, #0x23
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _0216827C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _02168280 // =0x00001958
	mov r2, #0
	str r2, [r0, r1]
	ldr r0, _02168284 // =VSMenu__Main_2168290
	bl SetCurrentTaskMainEvent
	add sp, #0xc
	pop {pc}
_02168264:
	ldr r0, _02168288 // =0x0000FFFF
	bl VSMenu__Func_21667F0
	ldr r0, _02168288 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _0216828C // =VSMenu__Main_216770C
	bl SetCurrentTaskMainEvent
_02168276:
	add sp, #0xc
	pop {pc}
	nop
_0216827C: .word VSMenu__Singleton
_02168280: .word 0x00001958
_02168284: .word VSMenu__Main_2168290
_02168288: .word 0x0000FFFF
_0216828C: .word VSMenu__Main_216770C
	thumb_func_end VSMenu__Main_21681F4

	thumb_func_start VSMenu__Main_2168290
VSMenu__Main_2168290: // 0x02168290
	push {r3, lr}
	sub sp, #8
	bl MultibootManager__Func_2060CC8
	cmp r0, #0x11
	bgt _021682B6
	cmp r0, #0xf
	blt _021682AE
	beq _0216832A
	cmp r0, #0x10
	beq _0216832A
	cmp r0, #0x11
	beq _021682BE
	add sp, #8
	pop {r3, pc}
_021682AE:
	cmp r0, #0
	beq _0216831A
	add sp, #8
	pop {r3, pc}
_021682B6:
	cmp r0, #0x19
	beq _02168324
	add sp, #8
	pop {r3, pc}
_021682BE:
	bl MultibootManager__Func_2061918
	cmp r0, #0
	beq _021682F6
	ldr r0, _02168330 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168334 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _02168338 // =0x00001958
	ldr r0, [r0, r1]
	cmp r0, #0
	beq _021682E6
	ldr r0, _0216833C // =VSMenu__Main_2168618
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_021682E6:
	ldr r0, _02168330 // =0x0000FFFF
	bl VSMenu__Func_21667F0
	ldr r0, _02168340 // =VSMenu__Main_21686EC
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_021682F6:
	mov r0, #0x24
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #5
	bl SaveSpriteButton__Func_2064588
	ldr r0, _02168344 // =VSMenu__Main_2168350
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_0216831A:
	ldr r0, _02168348 // =VSMenu__Main_21692B8
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_02168324:
	ldr r0, _0216834C // =VSMenu__Main_2169324
	bl SetCurrentTaskMainEvent
_0216832A:
	add sp, #8
	pop {r3, pc}
	nop
_02168330: .word 0x0000FFFF
_02168334: .word VSMenu__Singleton
_02168338: .word 0x00001958
_0216833C: .word VSMenu__Main_2168618
_02168340: .word VSMenu__Main_21686EC
_02168344: .word VSMenu__Main_2168350
_02168348: .word VSMenu__Main_21692B8
_0216834C: .word VSMenu__Main_2169324
	thumb_func_end VSMenu__Main_2168290

	thumb_func_start VSMenu__Main_2168350
VSMenu__Main_2168350: // 0x02168350
	push {r3, lr}
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216837E
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _0216837E
	ldr r0, _02168380 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168384 // =VSMenu__Main_2168D1C
	bl SetCurrentTaskMainEvent
_0216837E:
	pop {r3, pc}
	.align 2, 0
_02168380: .word 0x0000FFFF
_02168384: .word VSMenu__Main_2168D1C
	thumb_func_end VSMenu__Main_2168350

	thumb_func_start VSMenu__Main_2168388
VSMenu__Main_2168388: // 0x02168388
	push {lr}
	sub sp, #0xc
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216840A
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #0
	beq _021683B4
	cmp r0, #1
	beq _021683F8
	add sp, #0xc
	pop {pc}
_021683B4:
	mov r0, #1
	bl RenderCore_DisableSoftReset
	mov r0, #1
	bl RenderCore_SetNextFoldMode
	mov r1, #0
	str r1, [sp]
	mov r0, #0xe4
	str r0, [sp, #4]
	mov r0, #0xa6
	str r0, [sp, #8]
	mov r0, #1
	mov r2, #0xb
	mov r3, r0
	bl CreateConnectionStatusIcon
	bl MultibootManager__Func_2061654
	mov r0, #0x23
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168410 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _02168414 // =0x00001958
	mov r2, #1
	str r2, [r0, r1]
	ldr r0, _02168418 // =VSMenu__Main_2168290
	bl SetCurrentTaskMainEvent
	add sp, #0xc
	pop {pc}
_021683F8:
	ldr r0, _0216841C // =0x0000FFFF
	bl VSMenu__Func_21667F0
	ldr r0, _0216841C // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168420 // =VSMenu__Main_216770C
	bl SetCurrentTaskMainEvent
_0216840A:
	add sp, #0xc
	pop {pc}
	nop
_02168410: .word VSMenu__Singleton
_02168414: .word 0x00001958
_02168418: .word VSMenu__Main_2168290
_0216841C: .word 0x0000FFFF
_02168420: .word VSMenu__Main_216770C
	thumb_func_end VSMenu__Main_2168388

	thumb_func_start VSMenu__Main_2168424
VSMenu__Main_2168424: // 0x02168424
	push {r3, lr}
	sub sp, #8
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _02168466
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _02168466
	mov r0, #0x21
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r2, #1
	str r2, [sp]
	mov r1, #0
	mov r3, #5
	str r1, [sp, #4]
	bl SaveSpriteButton__Func_2064588
	ldr r0, _0216846C // =VSMenu__Main_21684A8
	bl SetCurrentTaskMainEvent
_02168466:
	add sp, #8
	pop {r3, pc}
	nop
_0216846C: .word VSMenu__Main_21684A8
	thumb_func_end VSMenu__Main_2168424

	thumb_func_start VSMenu__Main_2168470
VSMenu__Main_2168470: // 0x02168470
	push {r3, lr}
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216849E
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _0216849E
	ldr r0, _021684A0 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _021684A4 // =VSMenu__Main_21681C8
	bl SetCurrentTaskMainEvent
_0216849E:
	pop {r3, pc}
	.align 2, 0
_021684A0: .word 0x0000FFFF
_021684A4: .word VSMenu__Main_21681C8
	thumb_func_end VSMenu__Main_2168470

	thumb_func_start VSMenu__Main_21684A8
VSMenu__Main_21684A8: // 0x021684A8
	push {r3, lr}
	sub sp, #8
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216850A
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #0
	beq _021684D4
	cmp r0, #1
	beq _021684F8
	add sp, #8
	pop {r3, pc}
_021684D4:
	mov r0, #0x28
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #5
	bl SaveSpriteButton__Func_2064588
	ldr r0, _02168510 // =VSMenu__Main_216851C
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_021684F8:
	ldr r0, _02168514 // =0x0000FFFF
	bl VSMenu__Func_21667F0
	ldr r0, _02168514 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168518 // =VSMenu__Main_216770C
	bl SetCurrentTaskMainEvent
_0216850A:
	add sp, #8
	pop {r3, pc}
	nop
_02168510: .word VSMenu__Main_216851C
_02168514: .word 0x0000FFFF
_02168518: .word VSMenu__Main_216770C
	thumb_func_end VSMenu__Main_21684A8

	thumb_func_start VSMenu__Main_216851C
VSMenu__Main_216851C: // 0x0216851C
	push {r3, lr}
	sub sp, #8
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216855E
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _0216855E
	mov r0, #0x22
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r2, #1
	str r2, [sp]
	mov r1, #0
	mov r3, #5
	str r1, [sp, #4]
	bl SaveSpriteButton__Func_2064588
	ldr r0, _02168564 // =VSMenu__Main_2168568
	bl SetCurrentTaskMainEvent
_0216855E:
	add sp, #8
	pop {r3, pc}
	nop
_02168564: .word VSMenu__Main_2168568
	thumb_func_end VSMenu__Main_216851C

	thumb_func_start VSMenu__Main_2168568
VSMenu__Main_2168568: // 0x02168568
	push {lr}
	sub sp, #0xc
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _021685FE
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #0
	beq _02168594
	cmp r0, #1
	beq _021685DE
	add sp, #0xc
	pop {pc}
_02168594:
	mov r0, #1
	bl RenderCore_DisableSoftReset
	mov r0, #1
	bl RenderCore_SetNextFoldMode
	mov r1, #0
	str r1, [sp]
	mov r0, #0xe4
	str r0, [sp, #4]
	mov r0, #0xa6
	str r0, [sp, #8]
	mov r0, #1
	mov r2, #0xb
	mov r3, r0
	bl CreateConnectionStatusIcon
	ldr r0, _02168604 // =saveGame
	bl SaveGame__DeleteOnlineProfile_KeepFriends
	bl MultibootManager__Func_2061654
	mov r0, #0x23
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168608 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216860C // =0x00001958
	mov r2, #1
	str r2, [r0, r1]
	ldr r0, _02168610 // =VSMenu__Main_2168290
	bl SetCurrentTaskMainEvent
	add sp, #0xc
	pop {pc}
_021685DE:
	mov r0, #0x20
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #5
	bl SaveSpriteButton__Func_2064588
	ldr r0, _02168614 // =VSMenu__Main_2168424
	bl SetCurrentTaskMainEvent
_021685FE:
	add sp, #0xc
	pop {pc}
	nop
_02168604: .word saveGame
_02168608: .word VSMenu__Singleton
_0216860C: .word 0x00001958
_02168610: .word VSMenu__Main_2168290
_02168614: .word VSMenu__Main_2168424
	thumb_func_end VSMenu__Main_2168568

	thumb_func_start VSMenu__Main_2168618
VSMenu__Main_2168618: // 0x02168618
	push {r3, lr}
	sub sp, #8
	mov r0, #0x1f
	bl VSMenu__SetNetworkMessageSequence
	mov r0, #0xa
	bl TrySaveGameData
	cmp r0, #0
	beq _0216864A
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #5
	bl SaveSpriteButton__Func_2064588
	ldr r0, _02168654 // =VSMenu__Main_216865C
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_0216864A:
	ldr r0, _02168658 // =VSMenu__Main_216869C
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
	.align 2, 0
_02168654: .word VSMenu__Main_216865C
_02168658: .word VSMenu__Main_216869C
	thumb_func_end VSMenu__Main_2168618

	thumb_func_start VSMenu__Main_216865C
VSMenu__Main_216865C: // 0x0216865C
	push {r3, lr}
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _02168690
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _02168690
	ldr r0, _02168694 // =0x0000FFFF
	bl VSMenu__Func_21667F0
	ldr r0, _02168694 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168698 // =VSMenu__Main_21686EC
	bl SetCurrentTaskMainEvent
_02168690:
	pop {r3, pc}
	nop
_02168694: .word 0x0000FFFF
_02168698: .word VSMenu__Main_21686EC
	thumb_func_end VSMenu__Main_216865C

	thumb_func_start VSMenu__Main_216869C
VSMenu__Main_216869C: // 0x0216869C
	push {r3, lr}
	bl MultibootManager__Func_206150C
	ldr r0, _021686AC // =VSMenu__Main_21686B0
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_021686AC: .word VSMenu__Main_21686B0
	thumb_func_end VSMenu__Main_216869C

	thumb_func_start VSMenu__Main_21686B0
VSMenu__Main_21686B0: // 0x021686B0
	push {r3, lr}
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bgt _021686BE
	beq _021686D0
	pop {r3, pc}
_021686BE:
	cmp r0, #0x19
	bgt _021686E6
	cmp r0, #0x15
	blt _021686E6
	beq _021686E6
	cmp r0, #0x16
	beq _021686D0
	cmp r0, #0x19
	bne _021686E6
_021686D0:
	mov r0, #0
	bl RenderCore_DisableSoftReset
	mov r0, #0
	bl RenderCore_SetNextFoldMode
	bl DestroyConnectionStatusIcon
	ldr r0, _021686E8 // =VSMenu__Main_2169324
	bl SetCurrentTaskMainEvent
_021686E6:
	pop {r3, pc}
	.align 2, 0
_021686E8: .word VSMenu__Main_2169324
	thumb_func_end VSMenu__Main_21686B0

	thumb_func_start VSMenu__Main_21686EC
VSMenu__Main_21686EC: // 0x021686EC
	push {r3, r4, r5, lr}
	sub sp, #0x20
	ldr r0, _0216878C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r5, _02168790 // =0x0000091C
	mov r0, #5
	bl VSMenu__Func_21667F0
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A3C4
	mov r0, #0x70
	mov r1, #0x30
	str r0, [sp]
	add r0, r4, r5
	mov r2, #0x40
	mov r3, r1
	bl StageSelectMenu__Unknown__Func_216A1B8
	mov r0, #0x2f
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	sub r0, r0, #6
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02168794 // =VSMenu__Func_21675A0
	mov r2, #0x30
	str r0, [sp, #0x18]
	ldr r0, _02168798 // =0x0217E03C
	mov r3, #0x2e
	str r0, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r0, #0x32
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	sub r0, r0, #7
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02168794 // =VSMenu__Func_21675A0
	mov r2, #0x33
	str r0, [sp, #0x18]
	ldr r0, _0216879C // =0x0217E054
	mov r3, #0x31
	str r0, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A1DC
	ldr r0, _021687A0 // =VSMenu__Main_2168B84
	mov r1, #0
	str r0, [sp]
	ldr r3, _021687A4 // =VSMenu__Func_2167530
	add r0, r4, r5
	mov r2, r1
	bl StageSelectMenu__Unknown__Func_2169B78
	ldr r0, _021687A8 // =VSMenu__Main_2167950
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r3, r4, r5, pc}
	nop
_0216878C: .word VSMenu__Singleton
_02168790: .word 0x0000091C
_02168794: .word VSMenu__Func_21675A0
_02168798: .word 0x0217E03C
_0216879C: .word 0x0217E054
_021687A0: .word VSMenu__Main_2168B84
_021687A4: .word VSMenu__Func_2167530
_021687A8: .word VSMenu__Main_2167950
	thumb_func_end VSMenu__Main_21686EC

	thumb_func_start VSMenu__Main_21687AC
VSMenu__Main_21687AC: // 0x021687AC
	push {r3, r4, r5, lr}
	sub sp, #0x20
	ldr r0, _0216884C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r5, _02168850 // =0x0000091C
	mov r0, #0xb
	bl VSMenu__Func_21667F0
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A3C4
	mov r0, #0x70
	mov r1, #0x30
	str r0, [sp]
	add r0, r4, r5
	mov r2, #0x40
	mov r3, r1
	bl StageSelectMenu__Unknown__Func_216A1B8
	mov r0, #0x41
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	sub r0, r0, #6
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02168854 // =VSMenu__Func_21675A0
	mov r2, #0x42
	str r0, [sp, #0x18]
	ldr r0, _02168858 // =0x0217E044
	mov r3, #0x40
	str r0, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r0, #0x44
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	sub r0, r0, #7
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _02168854 // =VSMenu__Func_21675A0
	mov r2, #0x45
	str r0, [sp, #0x18]
	ldr r0, _0216885C // =0x0217E04C
	mov r3, #0x43
	str r0, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A1DC
	ldr r0, _02168860 // =VSMenu__Main_21686EC
	mov r1, #0
	str r0, [sp]
	ldr r3, _02168864 // =VSMenu__Func_2167530
	add r0, r4, r5
	mov r2, r1
	bl StageSelectMenu__Unknown__Func_2169B78
	ldr r0, _02168868 // =VSMenu__Main_2167950
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r3, r4, r5, pc}
	nop
_0216884C: .word VSMenu__Singleton
_02168850: .word 0x0000091C
_02168854: .word VSMenu__Func_21675A0
_02168858: .word 0x0217E044
_0216885C: .word 0x0217E04C
_02168860: .word VSMenu__Main_21686EC
_02168864: .word VSMenu__Func_2167530
_02168868: .word VSMenu__Main_2167950
	thumb_func_end VSMenu__Main_21687AC

	thumb_func_start VSMenu__Main_216886C
VSMenu__Main_216886C: // 0x0216886C
	push {r4, lr}
	ldr r0, _02168890 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x11
	bl VSMenu__Func_21667F0
	ldr r0, _02168894 // =0x00000918
	ldr r1, _02168898 // =0x00008002
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Create
	ldr r0, _0216889C // =VSMenu__Main_2168AFC
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_02168890: .word VSMenu__Singleton
_02168894: .word 0x00000918
_02168898: .word 0x00008002
_0216889C: .word VSMenu__Main_2168AFC
	thumb_func_end VSMenu__Main_216886C

	thumb_func_start VSMenu__Main_21688A0
VSMenu__Main_21688A0: // 0x021688A0
	push {r4, lr}
	ldr r0, _021688C4 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x12
	bl VSMenu__Func_21667F0
	ldr r0, _021688C8 // =0x00000918
	ldr r1, _021688CC // =0x00008006
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Create
	ldr r0, _021688D0 // =VSMenu__Main_2168AFC
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_021688C4: .word VSMenu__Singleton
_021688C8: .word 0x00000918
_021688CC: .word 0x00008006
_021688D0: .word VSMenu__Main_2168AFC
	thumb_func_end VSMenu__Main_21688A0

	thumb_func_start VSMenu__Main_21688D4
VSMenu__Main_21688D4: // 0x021688D4
	push {r3, r4, r5, lr}
	sub sp, #0x20
	ldr r0, _021689A4 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r5, _021689A8 // =0x0000091C
	bl SaveGame__GetFriendCount
	cmp r0, #0
	beq _0216897A
	mov r0, #0xb
	bl VSMenu__Func_21667F0
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A3C4
	mov r0, #0x70
	mov r1, #0x30
	str r0, [sp]
	add r0, r4, r5
	mov r2, #0x40
	mov r3, r1
	bl StageSelectMenu__Unknown__Func_216A1B8
	mov r0, #0x41
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	sub r0, r0, #6
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _021689AC // =VSMenu__Func_21675A0
	mov r2, #0x42
	str r0, [sp, #0x18]
	ldr r0, _021689B0 // =0x0217E05C
	mov r3, #0x40
	str r0, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r0, #0x44
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	sub r0, r0, #7
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _021689AC // =VSMenu__Func_21675A0
	mov r2, #0x45
	str r0, [sp, #0x18]
	ldr r0, _021689B4 // =0x0217E064
	mov r3, #0x43
	str r0, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	add r0, r4, r5
	bl StageSelectMenu__Unknown__Func_216A1DC
	ldr r0, _021689B8 // =VSMenu__Main_21686EC
	mov r1, #0
	str r0, [sp]
	ldr r3, _021689BC // =VSMenu__Func_2167530
	add r0, r4, r5
	mov r2, r1
	bl StageSelectMenu__Unknown__Func_2169B78
	ldr r0, _021689C0 // =VSMenu__Main_2167950
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r3, r4, r5, pc}
_0216897A:
	mov r0, #0xc
	bl VSMenu__Func_21667F0
	mov r0, #0x1b
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #5
	bl SaveSpriteButton__Func_2064588
	ldr r0, _021689C4 // =VSMenu__Main_2168A30
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r3, r4, r5, pc}
	.align 2, 0
_021689A4: .word VSMenu__Singleton
_021689A8: .word 0x0000091C
_021689AC: .word VSMenu__Func_21675A0
_021689B0: .word 0x0217E05C
_021689B4: .word 0x0217E064
_021689B8: .word VSMenu__Main_21686EC
_021689BC: .word VSMenu__Func_2167530
_021689C0: .word VSMenu__Main_2167950
_021689C4: .word VSMenu__Main_2168A30
	thumb_func_end VSMenu__Main_21688D4

	thumb_func_start VSMenu__Main_21689C8
VSMenu__Main_21689C8: // 0x021689C8
	push {r4, lr}
	ldr r0, _021689EC // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x11
	bl VSMenu__Func_21667F0
	ldr r0, _021689F0 // =0x00000918
	ldr r1, _021689F4 // =0x00008012
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Create
	ldr r0, _021689F8 // =VSMenu__Main_2168AFC
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_021689EC: .word VSMenu__Singleton
_021689F0: .word 0x00000918
_021689F4: .word 0x00008012
_021689F8: .word VSMenu__Main_2168AFC
	thumb_func_end VSMenu__Main_21689C8

	thumb_func_start VSMenu__Main_21689FC
VSMenu__Main_21689FC: // 0x021689FC
	push {r4, lr}
	ldr r0, _02168A20 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x12
	bl VSMenu__Func_21667F0
	ldr r0, _02168A24 // =0x00000918
	ldr r1, _02168A28 // =0x00008016
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Create
	ldr r0, _02168A2C // =VSMenu__Main_2168AFC
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_02168A20: .word VSMenu__Singleton
_02168A24: .word 0x00000918
_02168A28: .word 0x00008016
_02168A2C: .word VSMenu__Main_2168AFC
	thumb_func_end VSMenu__Main_21689FC

	thumb_func_start VSMenu__Main_2168A30
VSMenu__Main_2168A30: // 0x02168A30
	push {r3, lr}
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	beq _02168A40
	cmp r0, #0x19
	beq _02168A7C
	b _02168AB8
_02168A40:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064614
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	bne _02168A68
_02168A54:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _02168A54
_02168A68:
	ldr r0, _02168AEC // =0x0000FFFF
	bl VSMenu__Func_21667F0
	ldr r0, _02168AEC // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168AF0 // =VSMenu__Main_21692B8
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_02168A7C:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064614
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	bne _02168AA4
_02168A90:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _02168A90
_02168AA4:
	ldr r0, _02168AEC // =0x0000FFFF
	bl VSMenu__Func_21667F0
	ldr r0, _02168AEC // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168AF4 // =VSMenu__Main_2169324
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_02168AB8:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _02168AEA
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _02168AEA
	ldr r0, _02168AEC // =0x0000FFFF
	bl VSMenu__Func_21667F0
	ldr r0, _02168AEC // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168AF8 // =VSMenu__Main_21686EC
	bl SetCurrentTaskMainEvent
_02168AEA:
	pop {r3, pc}
	.align 2, 0
_02168AEC: .word 0x0000FFFF
_02168AF0: .word VSMenu__Main_21692B8
_02168AF4: .word VSMenu__Main_2169324
_02168AF8: .word VSMenu__Main_21686EC
	thumb_func_end VSMenu__Main_2168A30

	thumb_func_start VSMenu__Main_2168AFC
VSMenu__Main_2168AFC: // 0x02168AFC
	push {r4, lr}
	ldr r0, _02168B6C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _02168B70 // =0x00000918
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Func_216AC10
	cmp r0, #0
	beq _02168B6A
	ldr r0, _02168B70 // =0x00000918
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Func_216AC48
	cmp r0, #4
	bhi _02168B6A
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02168B2C: // jump table
	.hword _02168B6A - _02168B2C - 2 // case 0
	.hword _02168B36 - _02168B2C - 2 // case 1
	.hword _02168B3E - _02168B2C - 2 // case 2
	.hword _02168B5C - _02168B2C - 2 // case 3
	.hword _02168B64 - _02168B2C - 2 // case 4
_02168B36:
	mov r0, #1
	bl VSMenu__ChangeEvent
	pop {r4, pc}
_02168B3E:
	ldr r0, _02168B70 // =0x00000918
	ldr r0, [r4, r0]
	bl VSConnectionMenu__Func_216AC44
	mov r1, #0x10
	tst r0, r1
	bne _02168B54
	ldr r0, _02168B74 // =VSMenu__Main_21687AC
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02168B54:
	ldr r0, _02168B78 // =VSMenu__Main_21688D4
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02168B5C:
	ldr r0, _02168B7C // =VSMenu__Main_21692B8
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02168B64:
	ldr r0, _02168B80 // =VSMenu__Main_2169324
	bl SetCurrentTaskMainEvent
_02168B6A:
	pop {r4, pc}
	.align 2, 0
_02168B6C: .word VSMenu__Singleton
_02168B70: .word 0x00000918
_02168B74: .word VSMenu__Main_21687AC
_02168B78: .word VSMenu__Main_21688D4
_02168B7C: .word VSMenu__Main_21692B8
_02168B80: .word VSMenu__Main_2169324
	thumb_func_end VSMenu__Main_2168AFC

	thumb_func_start VSMenu__Main_2168B84
VSMenu__Main_2168B84: // 0x02168B84
	push {r3, lr}
	sub sp, #8
	mov r0, #4
	bl VSMenu__Func_21667F0
	mov r0, #0x25
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r2, #1
	str r2, [sp]
	mov r1, #0
	mov r3, #5
	str r1, [sp, #4]
	bl SaveSpriteButton__Func_2064588
	ldr r0, _02168BB0 // =VSMenu__Main_2168BB4
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
	.align 2, 0
_02168BB0: .word VSMenu__Main_2168BB4
	thumb_func_end VSMenu__Main_2168B84

	thumb_func_start VSMenu__Main_2168BB4
VSMenu__Main_2168BB4: // 0x02168BB4
	push {r3, lr}
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _02168BFC
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #0
	beq _02168BDC
	cmp r0, #1
	beq _02168BEA
	pop {r3, pc}
_02168BDC:
	mov r0, #0x26
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168C00 // =VSMenu__Main_2168C0C
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_02168BEA:
	ldr r0, _02168C04 // =0x0000FFFF
	bl VSMenu__Func_21667F0
	ldr r0, _02168C04 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168C08 // =VSMenu__Main_21686EC
	bl SetCurrentTaskMainEvent
_02168BFC:
	pop {r3, pc}
	nop
_02168C00: .word VSMenu__Main_2168C0C
_02168C04: .word 0x0000FFFF
_02168C08: .word VSMenu__Main_21686EC
	thumb_func_end VSMenu__Main_2168BB4

	thumb_func_start VSMenu__Main_2168C0C
VSMenu__Main_2168C0C: // 0x02168C0C
	push {r3, lr}
	bl VSMenu__CheckNetworkMessageMain
	cmp r0, #0
	beq _02168C3A
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	beq _02168C22
	cmp r0, #0x19
	bne _02168C30
_02168C22:
	bl MultibootManager__Func_2060C9C
	bl MultibootManager__Func_2061C58
	bl MultibootManager__Create
	b _02168C34
_02168C30:
	bl MultibootManager__Func_206150C
_02168C34:
	ldr r0, _02168C3C // =VSMenu__Main_2168C40
	bl SetCurrentTaskMainEvent
_02168C3A:
	pop {r3, pc}
	.align 2, 0
_02168C3C: .word VSMenu__Main_2168C40
	thumb_func_end VSMenu__Main_2168C0C

	thumb_func_start VSMenu__Main_2168C40
VSMenu__Main_2168C40: // 0x02168C40
	push {r3, lr}
	sub sp, #8
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bgt _02168C52
	beq _02168C68
	add sp, #8
	pop {r3, pc}
_02168C52:
	cmp r0, #0x19
	bgt _02168CC6
	cmp r0, #0x15
	blt _02168CC6
	beq _02168CC6
	cmp r0, #0x16
	beq _02168C78
	cmp r0, #0x19
	beq _02168C72
	add sp, #8
	pop {r3, pc}
_02168C68:
	ldr r0, _02168CCC // =VSMenu__Main_21692B8
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_02168C72:
	ldr r0, _02168CD0 // =VSMenu__Main_2169324
	bl SetCurrentTaskMainEvent
_02168C78:
	ldr r0, _02168CD4 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	mov r0, #0
	bl RenderCore_DisableSoftReset
	mov r0, #0
	bl RenderCore_SetNextFoldMode
	bl DestroyConnectionStatusIcon
	bl SaveGame__RefreshFriendList
	mov r0, #0xb
	bl TrySaveGameData
	cmp r0, #0
	beq _02168CC0
	mov r0, #0x27
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #5
	bl SaveSpriteButton__Func_2064588
	ldr r0, _02168CD8 // =VSMenu__Main_2168CDC
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_02168CC0:
	ldr r0, _02168CD0 // =VSMenu__Main_2169324
	bl SetCurrentTaskMainEvent
_02168CC6:
	add sp, #8
	pop {r3, pc}
	nop
_02168CCC: .word VSMenu__Main_21692B8
_02168CD0: .word VSMenu__Main_2169324
_02168CD4: .word 0x0000FFFF
_02168CD8: .word VSMenu__Main_2168CDC
	thumb_func_end VSMenu__Main_2168C40

	thumb_func_start VSMenu__Main_2168CDC
VSMenu__Main_2168CDC: // 0x02168CDC
	push {r3, lr}
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _02168D10
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _02168D10
	ldr r0, _02168D14 // =0x0000FFFF
	bl VSMenu__Func_21667F0
	ldr r0, _02168D14 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168D18 // =VSMenu__Main_216770C
	bl SetCurrentTaskMainEvent
_02168D10:
	pop {r3, pc}
	nop
_02168D14: .word 0x0000FFFF
_02168D18: .word VSMenu__Main_216770C
	thumb_func_end VSMenu__Main_2168CDC

	thumb_func_start VSMenu__Main_2168D1C
VSMenu__Main_2168D1C: // 0x02168D1C
	push {r3, lr}
	mov r0, #0x26
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168D2C // =VSMenu__Main_2168C0C
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_02168D2C: .word VSMenu__Main_2168C0C
	thumb_func_end VSMenu__Main_2168D1C

	thumb_func_start VSMenu__Main_2168D30
VSMenu__Main_2168D30: // 0x02168D30
	push {r4, lr}
	ldr r0, _02168D54 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #7
	bl VSMenu__Func_21667F0
	ldr r0, _02168D58 // =0x00001294
	mov r1, #0
	add r0, r4, r0
	bl VSFriendListMenu__Create
	ldr r0, _02168D5C // =VSMenu__Main_2168D60
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_02168D54: .word VSMenu__Singleton
_02168D58: .word 0x00001294
_02168D5C: .word VSMenu__Main_2168D60
	thumb_func_end VSMenu__Main_2168D30

	thumb_func_start VSMenu__Main_2168D60
VSMenu__Main_2168D60: // 0x02168D60
	push {r4, lr}
	ldr r0, _02168D94 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _02168D98 // =0x00001294
	add r0, r4, r0
	bl VSFriendListMenu__Func_2171368
	cmp r0, #0
	beq _02168D92
	ldr r0, _02168D98 // =0x00001294
	add r0, r4, r0
	bl VSFriendListMenu__Func_217137C
	cmp r0, #0
	beq _02168D8C
	ldr r0, _02168D9C // =VSMenu__Main_2168DA4
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02168D8C:
	ldr r0, _02168DA0 // =VSMenu__Func_2167860
	bl SetCurrentTaskMainEvent
_02168D92:
	pop {r4, pc}
	.align 2, 0
_02168D94: .word VSMenu__Singleton
_02168D98: .word 0x00001294
_02168D9C: .word VSMenu__Main_2168DA4
_02168DA0: .word VSMenu__Func_2167860
	thumb_func_end VSMenu__Main_2168D60

	thumb_func_start VSMenu__Main_2168DA4
VSMenu__Main_2168DA4: // 0x02168DA4
	push {r3, lr}
	ldr r0, _02168DC8 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r0, #3
	bl TrySaveGameData
	cmp r0, #0
	beq _02168DC0
	ldr r0, _02168DCC // =VSMenu__Func_2167860
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_02168DC0:
	ldr r0, _02168DD0 // =VSMenu__Main_2169324
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_02168DC8: .word VSMenu__Singleton
_02168DCC: .word VSMenu__Func_2167860
_02168DD0: .word VSMenu__Main_2169324
	thumb_func_end VSMenu__Main_2168DA4

	thumb_func_start VSMenu__Main_2168DD4
VSMenu__Main_2168DD4: // 0x02168DD4
	push {r3, lr}
	ldr r0, _02168DEC // =0x0000FFFF
	bl VSMenu__Func_21667F0
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	ldr r0, _02168DF0 // =VSMenu__Main_2168DF4
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_02168DEC: .word 0x0000FFFF
_02168DF0: .word VSMenu__Main_2168DF4
	thumb_func_end VSMenu__Main_2168DD4

	thumb_func_start VSMenu__Main_2168DF4
VSMenu__Main_2168DF4: // 0x02168DF4
	push {r4, lr}
	ldr r0, _02168E2C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _02168E28
	bl DestroyDrawFadeTask
	mov r0, #0
	bl VSMenu__Func_2166874
	mov r0, #0
	bl VSMenu__Func_216685C
	ldr r0, _02168E30 // =0x00001864
	mov r1, #0
	add r0, r4, r0
	bl VSRegisterFriendCodeMenu__Create
	ldr r0, _02168E34 // =VSMenu__Main_2168E38
	bl SetCurrentTaskMainEvent
_02168E28:
	pop {r4, pc}
	nop
_02168E2C: .word VSMenu__Singleton
_02168E30: .word 0x00001864
_02168E34: .word VSMenu__Main_2168E38
	thumb_func_end VSMenu__Main_2168DF4

	thumb_func_start VSMenu__Main_2168E38
VSMenu__Main_2168E38: // 0x02168E38
	push {r4, lr}
	ldr r0, _02168E6C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _02168E70 // =0x00001864
	add r0, r4, r0
	bl VSRegisterFriendCodeMenu__IsActive
	cmp r0, #0
	beq _02168E6A
	ldr r0, _02168E70 // =0x00001864
	add r0, r4, r0
	bl VSRegisterFriendCodeMenu__Func_2172A18
	cmp r0, #0
	beq _02168E64
	ldr r0, _02168E74 // =VSMenu__Main_2168E7C
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02168E64:
	ldr r0, _02168E78 // =VSMenu__Main_2168EAC
	bl SetCurrentTaskMainEvent
_02168E6A:
	pop {r4, pc}
	.align 2, 0
_02168E6C: .word VSMenu__Singleton
_02168E70: .word 0x00001864
_02168E74: .word VSMenu__Main_2168E7C
_02168E78: .word VSMenu__Main_2168EAC
	thumb_func_end VSMenu__Main_2168E38

	thumb_func_start VSMenu__Main_2168E7C
VSMenu__Main_2168E7C: // 0x02168E7C
	push {r3, lr}
	ldr r0, _02168EA0 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r0, #3
	bl TrySaveGameData
	cmp r0, #0
	beq _02168E98
	ldr r0, _02168EA4 // =VSMenu__Main_2168EAC
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_02168E98:
	ldr r0, _02168EA8 // =VSMenu__Main_2169324
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_02168EA0: .word VSMenu__Singleton
_02168EA4: .word VSMenu__Main_2168EAC
_02168EA8: .word VSMenu__Main_2169324
	thumb_func_end VSMenu__Main_2168E7C

	thumb_func_start VSMenu__Main_2168EAC
VSMenu__Main_2168EAC: // 0x02168EAC
	push {r3, lr}
	ldr r0, _02168F04 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r0, #3
	bl VSMenu__Func_2166874
	mov r0, #3
	bl VSMenuBackground__Create
	mov r0, #1
	bl VSMenu__Func_216685C
	mov r0, #0
	bl VSMenuNetworkMessage__Create
	ldr r0, _02168F08 // =0x04001008
	mov r1, #3
	ldrh r2, [r0, #0]
	bic r2, r1
	strh r2, [r0]
	ldrh r2, [r0, #6]
	bic r2, r1
	mov r1, #3
	orr r1, r2
	strh r1, [r0, #6]
	sub r0, #8
	ldr r2, [r0, #0]
	ldr r1, _02168F0C // =0xFFFFE0FF
	and r2, r1
	mov r1, #0x19
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r0]
	mov r0, #2
	lsl r1, r0, #0xb
	bl CreateDrawFadeTask
	ldr r0, _02168F10 // =VSMenu__Main_2168F14
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_02168F04: .word VSMenu__Singleton
_02168F08: .word 0x04001008
_02168F0C: .word 0xFFFFE0FF
_02168F10: .word VSMenu__Main_2168F14
	thumb_func_end VSMenu__Main_2168EAC

	thumb_func_start VSMenu__Main_2168F14
VSMenu__Main_2168F14: // 0x02168F14
	push {r3, lr}
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _02168F28
	bl DestroyDrawFadeTask
	ldr r0, _02168F2C // =VSMenu__Func_2167860
	bl SetCurrentTaskMainEvent
_02168F28:
	pop {r3, pc}
	nop
_02168F2C: .word VSMenu__Func_2167860
	thumb_func_end VSMenu__Main_2168F14

	thumb_func_start VSMenu__Main_2168F30
VSMenu__Main_2168F30: // 0x02168F30
	push {r4, lr}
	ldr r0, _02168F54 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #9
	bl VSMenu__Func_21667F0
	ldr r0, _02168F58 // =0x0000186C
	mov r1, #0
	add r0, r4, r0
	bl VSViewFriendCodeMenu__Create
	ldr r0, _02168F5C // =VSMenu__Main_2168F60
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_02168F54: .word VSMenu__Singleton
_02168F58: .word 0x0000186C
_02168F5C: .word VSMenu__Main_2168F60
	thumb_func_end VSMenu__Main_2168F30

	thumb_func_start VSMenu__Main_2168F60
VSMenu__Main_2168F60: // 0x02168F60
	push {r3, lr}
	ldr r0, _02168F80 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _02168F84 // =0x0000186C
	add r0, r0, r1
	bl VSViewFriendCodeMenu__IsActive
	cmp r0, #0
	beq _02168F7C
	ldr r0, _02168F88 // =VSMenu__Func_2167860
	bl SetCurrentTaskMainEvent
_02168F7C:
	pop {r3, pc}
	nop
_02168F80: .word VSMenu__Singleton
_02168F84: .word 0x0000186C
_02168F88: .word VSMenu__Func_2167860
	thumb_func_end VSMenu__Main_2168F60

	thumb_func_start VSMenu__Main_2168F8C
VSMenu__Main_2168F8C: // 0x02168F8C
	push {r3, lr}
	bl MultibootManager__Func_2060CC8
	cmp r0, #0x11
	bne _02168F9E
	mov r0, #4
	bl VSMenu__Func_21667F0
	b _02168FA4
_02168F9E:
	mov r0, #0
	bl VSMenu__Func_21667F0
_02168FA4:
	mov r0, #0x44
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02168FB4 // =VSMenu__Main_2168FB8
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_02168FB4: .word VSMenu__Main_2168FB8
	thumb_func_end VSMenu__Main_2168F8C

	thumb_func_start VSMenu__Main_2168FB8
VSMenu__Main_2168FB8: // 0x02168FB8
	push {r3, lr}
	sub sp, #8
	bl VSMenu__CheckNetworkMessageMain
	cmp r0, #0
	beq _02168FDE
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #5
	bl SaveSpriteButton__Func_2064588
	ldr r0, _02168FE4 // =VSMenu__Main_2168FE8
	bl SetCurrentTaskMainEvent
_02168FDE:
	add sp, #8
	pop {r3, pc}
	nop
_02168FE4: .word VSMenu__Main_2168FE8
	thumb_func_end VSMenu__Main_2168FB8

	thumb_func_start VSMenu__Main_2168FE8
VSMenu__Main_2168FE8: // 0x02168FE8
	push {r3, lr}
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	beq _02168FF8
	cmp r0, #0x19
	beq _02169028
	b _02169058
_02168FF8:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064614
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	bne _02169020
_0216900C:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216900C
_02169020:
	ldr r0, _021690A0 // =VSMenu__Main_21692B8
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_02169028:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064614
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	bne _02169050
_0216903C:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216903C
_02169050:
	ldr r0, _021690A4 // =VSMenu__Main_2169324
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_02169058:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216909C
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _02169096
	ldr r0, _021690A8 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	bl MultibootManager__Func_2060CC8
	cmp r0, #0x11
	bne _0216908E
	ldr r0, _021690AC // =VSMenu__Main_21686EC
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_0216908E:
	ldr r0, _021690B0 // =VSMenu__Main
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_02169096:
	ldr r0, _021690B0 // =VSMenu__Main
	bl SetCurrentTaskMainEvent
_0216909C:
	pop {r3, pc}
	nop
_021690A0: .word VSMenu__Main_21692B8
_021690A4: .word VSMenu__Main_2169324
_021690A8: .word 0x0000FFFF
_021690AC: .word VSMenu__Main_21686EC
_021690B0: .word VSMenu__Main
	thumb_func_end VSMenu__Main_2168FE8

	thumb_func_start VSMenu__Main_21690B4
VSMenu__Main_21690B4: // 0x021690B4
	push {r3, lr}
	sub sp, #8
	ldr r0, _021690E8 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r0, #4
	bl VSMenu__Func_21667F0
	mov r0, #0x29
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r2, #1
	str r2, [sp]
	mov r1, #0
	mov r3, #5
	str r1, [sp, #4]
	bl SaveSpriteButton__Func_2064588
	ldr r0, _021690EC // =VSMenu__Main_21690F0
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
	.align 2, 0
_021690E8: .word VSMenu__Singleton
_021690EC: .word VSMenu__Main_21690F0
	thumb_func_end VSMenu__Main_21690B4

	thumb_func_start VSMenu__Main_21690F0
VSMenu__Main_21690F0: // 0x021690F0
	push {r3, lr}
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _02169132
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #0
	beq _02169118
	cmp r0, #1
	beq _02169126
	pop {r3, pc}
_02169118:
	ldr r0, _02169134 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02169138 // =VSMenu__Main_2169140
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_02169126:
	ldr r0, _02169134 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _0216913C // =VSMenu__Main_216770C
	bl SetCurrentTaskMainEvent
_02169132:
	pop {r3, pc}
	.align 2, 0
_02169134: .word 0x0000FFFF
_02169138: .word VSMenu__Main_2169140
_0216913C: .word VSMenu__Main_216770C
	thumb_func_end VSMenu__Main_21690F0

	thumb_func_start VSMenu__Main_2169140
VSMenu__Main_2169140: // 0x02169140
	push {r3, lr}
	mov r0, #0
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _02169150 // =VSMenu__Main_2169154
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_02169150: .word VSMenu__Main_2169154
	thumb_func_end VSMenu__Main_2169140

	thumb_func_start VSMenu__Main_2169154
VSMenu__Main_2169154: // 0x02169154
	push {r3, lr}
	bl VSMenu__CheckNetworkMessageMain
	cmp r0, #0
	beq _02169178
	ldr r0, _0216917C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _02169180 // =0x0000187C
	mov r2, #0x18
	add r0, r0, r1
	mov r1, #9
	bl CreateSaveGameWorker
	ldr r0, _02169184 // =VSMenu__Main_2169188
	bl SetCurrentTaskMainEvent
_02169178:
	pop {r3, pc}
	nop
_0216917C: .word VSMenu__Singleton
_02169180: .word 0x0000187C
_02169184: .word VSMenu__Main_2169188
	thumb_func_end VSMenu__Main_2169154

	thumb_func_start VSMenu__Main_2169188
VSMenu__Main_2169188: // 0x02169188
	push {r4, lr}
	ldr r0, _021691C4 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _021691C8 // =0x0000187C
	add r0, r4, r0
	bl AwaitSaveGameCompletion
	cmp r0, #0
	beq _021691C0
	ldr r0, _021691C8 // =0x0000187C
	add r0, r4, r0
	bl GetSaveGameSuccess
	cmp r0, #0
	beq _021691BA
	ldr r0, _021691CC // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _021691D0 // =VSMenu__Main_21691D8
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_021691BA:
	ldr r0, _021691D4 // =VSMenu__Main_2169324
	bl SetCurrentTaskMainEvent
_021691C0:
	pop {r4, pc}
	nop
_021691C4: .word VSMenu__Singleton
_021691C8: .word 0x0000187C
_021691CC: .word 0x0000FFFF
_021691D0: .word VSMenu__Main_21691D8
_021691D4: .word VSMenu__Main_2169324
	thumb_func_end VSMenu__Main_2169188

	thumb_func_start VSMenu__Main_21691D8
VSMenu__Main_21691D8: // 0x021691D8
	push {r3, lr}
	sub sp, #8
	ldr r0, _02169230 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	bl MultibootManager__Func_2061638
	cmp r0, #0
	beq _0216920C
	ldr r0, _02169234 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	thumb_func_end VSMenu__Main_21691D8

	thumb_func_start VSMenu__Main_21691F8
VSMenu__Main_21691F8: // 0x021691F8
	bl CreateDrawFadeTask
	mov r0, #0xc
	bl FadeSysTrack
	ldr r0, _02169238 // =VSMenu__Main_2169288
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_0216920C:
	mov r0, #0x1c
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #5
	bl SaveSpriteButton__Func_2064588
	ldr r0, _0216923C // =VSMenu__Main_2169240
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
	.align 2, 0
_02169230: .word VSMenu__Singleton
_02169234: .word 0x0000FFFF
_02169238: .word VSMenu__Main_2169288
_0216923C: .word VSMenu__Main_2169240
	thumb_func_end VSMenu__Main_21691F8

	thumb_func_start VSMenu__Main_2169240
VSMenu__Main_2169240: // 0x02169240
	push {r3, lr}
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216927E
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _0216927E
	ldr r0, _02169280 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	mov r0, #0xc
	bl FadeSysTrack
	ldr r0, _02169284 // =VSMenu__Main_2169288
	bl SetCurrentTaskMainEvent
_0216927E:
	pop {r3, pc}
	.align 2, 0
_02169280: .word 0x0000FFFF
_02169284: .word VSMenu__Main_2169288
	thumb_func_end VSMenu__Main_2169240

	thumb_func_start VSMenu__Main_2169288
VSMenu__Main_2169288: // 0x02169288
	push {r3, lr}
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _021692B0
	ldr r0, _021692B4 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl VSMenu__Destroy
	bl MultibootManager__Func_2060C9C
	bl ReleaseSysSound
	mov r0, #0x21
	bl RequestNewSysEventChange
	bl NextSysEvent
	bl DestroyCurrentTask
_021692B0:
	pop {r3, pc}
	nop
_021692B4: .word VSMenu__Singleton
	thumb_func_end VSMenu__Main_2169288

	thumb_func_start VSMenu__Main_21692B8
VSMenu__Main_21692B8: // 0x021692B8
	push {r3, lr}
	ldr r1, _021692E4 // =0x0213D300
	mov r0, #0x18
	ldrsh r2, [r1, r0]
	mov r1, r0
	sub r1, #0x28
	cmp r2, r1
	bne _021692D2
	ldr r1, _021692E8 // =0x0213D2A4
	ldrsh r1, [r1, r0]
	sub r0, #0x28
	cmp r1, r0
	beq _021692DA
_021692D2:
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
_021692DA:
	ldr r0, _021692EC // =VSMenu__Main_21692F0
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_021692E4: .word 0x0213D300
_021692E8: .word 0x0213D2A4
_021692EC: .word VSMenu__Main_21692F0
	thumb_func_end VSMenu__Main_21692B8

	thumb_func_start VSMenu__Main_21692F0
VSMenu__Main_21692F0: // 0x021692F0
	push {r3, lr}
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _0216931C
	bl DestroyDrawFadeTask
	ldr r0, _02169320 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl VSMenu__Destroy
	bl MultibootManager__Func_2060C9C
	bl ReleaseSysSound
	mov r0, #0x1a
	bl RequestNewSysEventChange
	bl NextSysEvent
	bl DestroyCurrentTask
_0216931C:
	pop {r3, pc}
	nop
_02169320: .word VSMenu__Singleton
	thumb_func_end VSMenu__Main_21692F0

	thumb_func_start VSMenu__Main_2169324
VSMenu__Main_2169324: // 0x02169324
	push {r3, lr}
	ldr r1, _02169350 // =0x0213D300
	mov r0, #0x18
	ldrsh r2, [r1, r0]
	mov r1, r0
	sub r1, #0x28
	cmp r2, r1
	bne _0216933E
	ldr r1, _02169354 // =0x0213D2A4
	ldrsh r1, [r1, r0]
	sub r0, #0x28
	cmp r1, r0
	beq _02169346
_0216933E:
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
_02169346:
	ldr r0, _02169358 // =VSMenu__Main_216935C
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_02169350: .word 0x0213D300
_02169354: .word 0x0213D2A4
_02169358: .word VSMenu__Main_216935C
	thumb_func_end VSMenu__Main_2169324

	thumb_func_start VSMenu__Main_216935C
VSMenu__Main_216935C: // 0x0216935C
	push {r3, lr}
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _02169388
	bl DestroyDrawFadeTask
	ldr r0, _0216938C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl VSMenu__Destroy
	bl MultibootManager__Func_2060C9C
	bl ReleaseSysSound
	mov r0, #0x20
	bl RequestNewSysEventChange
	bl NextSysEvent
	bl DestroyCurrentTask
_02169388:
	pop {r3, pc}
	nop
_0216938C: .word VSMenu__Singleton
	thumb_func_end VSMenu__Main_216935C

	thumb_func_start VSMenuHeader__Main1
VSMenuHeader__Main1: // 0x02169390
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _021693F8 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r6, r0
	add r6, #0x30
	mov r0, #5
	mov r5, r6
	lsl r0, r0, #6
	add r5, #0x14
	add r4, r6, r0
	cmp r5, r4
	beq _021693BE
	mov r7, #0
_021693AE:
	mov r0, r5
	mov r1, r7
	mov r2, r7
	bl AnimatorSprite__ProcessAnimation
	add r5, #0x64
	cmp r5, r4
	bne _021693AE
_021693BE:
	ldrh r1, [r6, #8]
	ldr r0, _021693FC // =0x0000FFFF
	cmp r1, r0
	beq _021693F6
	ldrh r0, [r6, #0xa]
	mov r4, r6
	add r4, #0xdc
	cmp r0, r1
	beq _021693E4
	strh r1, [r6, #0xa]
	ldrh r1, [r6, #0xa]
	mov r0, r4
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
_021693E4:
	mov r0, #4
	strh r0, [r4, #0xa]
	ldr r0, _02169400 // =0x00000199
	str r0, [r6, #0x10]
	mov r0, #0
	strh r0, [r6, #0xc]
	ldr r0, _02169404 // =VSMenuHeader__Main_2169408
	bl SetCurrentTaskMainEvent
_021693F6:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021693F8: .word VSMenu__Singleton
_021693FC: .word 0x0000FFFF
_02169400: .word 0x00000199
_02169404: .word VSMenuHeader__Main_2169408
	thumb_func_end VSMenuHeader__Main1

	thumb_func_start VSMenuHeader__Main_2169408
VSMenuHeader__Main_2169408: // 0x02169408
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _02169480 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r6, r0
	add r6, #0x30
	mov r0, #5
	mov r5, r6
	lsl r0, r0, #6
	add r5, #0x14
	add r4, r6, r0
	cmp r5, r4
	beq _02169436
	mov r7, #0
_02169426:
	mov r0, r5
	mov r1, r7
	mov r2, r7
	bl AnimatorSprite__ProcessAnimation
	add r5, #0x64
	cmp r5, r4
	bne _02169426
_02169436:
	ldrh r0, [r6, #0xc]
	ldr r3, _02169484 // =0xFFFFE000
	add r0, r0, #1
	strh r0, [r6, #0xc]
	ldrh r0, [r6, #0xc]
	lsl r1, r0, #0xc
	asr r0, r1, #4
	lsr r0, r0, #0x1b
	add r0, r1, r0
	lsl r0, r0, #0xb
	asr r4, r0, #0x10
	mov r0, #4
	mov r1, #6
	mov r2, r4
	bl Task__Unknown204BE48__LerpValue
	mov r1, r6
	add r1, #0xe6
	strh r0, [r1]
	mov r1, #1
	ldr r0, _02169488 // =0x00000199
	ldr r3, _02169484 // =0xFFFFE000
	lsl r1, r1, #0xc
	mov r2, r4
	bl Task__Unknown204BE48__LerpValue
	str r0, [r6, #0x10]
	ldrh r0, [r6, #0xc]
	cmp r0, #0x20
	bls _0216947C
	mov r0, #0
	strh r0, [r6, #0xc]
	ldr r0, _0216948C // =VSMenuHeader__Main_2169490
	bl SetCurrentTaskMainEvent
_0216947C:
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02169480: .word VSMenu__Singleton
_02169484: .word 0xFFFFE000
_02169488: .word 0x00000199
_0216948C: .word VSMenuHeader__Main_2169490
	thumb_func_end VSMenuHeader__Main_2169408

	thumb_func_start VSMenuHeader__Main_2169490
VSMenuHeader__Main_2169490: // 0x02169490
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _021694D4 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r6, r0
	add r6, #0x30
	mov r0, #5
	mov r5, r6
	lsl r0, r0, #6
	add r5, #0x14
	add r4, r6, r0
	cmp r5, r4
	beq _021694BE
	mov r7, #0
_021694AE:
	mov r0, r5
	mov r1, r7
	mov r2, r7
	bl AnimatorSprite__ProcessAnimation
	add r5, #0x64
	cmp r5, r4
	bne _021694AE
_021694BE:
	ldrh r1, [r6, #0xa]
	ldrh r0, [r6, #8]
	cmp r1, r0
	beq _021694D0
	mov r0, #0
	strh r0, [r6, #0xc]
	ldr r0, _021694D8 // =VSMenuHeader__Main_21694DC
	bl SetCurrentTaskMainEvent
_021694D0:
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021694D4: .word VSMenu__Singleton
_021694D8: .word VSMenuHeader__Main_21694DC
	thumb_func_end VSMenuHeader__Main_2169490

	thumb_func_start VSMenuHeader__Main_21694DC
VSMenuHeader__Main_21694DC: // 0x021694DC
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _02169554 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r6, r0
	add r6, #0x30
	mov r0, #5
	mov r5, r6
	lsl r0, r0, #6
	add r5, #0x14
	add r4, r6, r0
	cmp r5, r4
	beq _0216950A
	mov r7, #0
_021694FA:
	mov r0, r5
	mov r1, r7
	mov r2, r7
	bl AnimatorSprite__ProcessAnimation
	add r5, #0x64
	cmp r5, r4
	bne _021694FA
_0216950A:
	ldrh r0, [r6, #0xc]
	mov r3, #2
	lsl r3, r3, #0xc
	add r0, r0, #1
	strh r0, [r6, #0xc]
	ldrh r0, [r6, #0xc]
	lsl r1, r0, #0xc
	asr r0, r1, #4
	lsr r0, r0, #0x1b
	add r0, r1, r0
	lsl r0, r0, #0xb
	asr r4, r0, #0x10
	mov r0, #6
	mov r1, #0x1a
	mov r2, r4
	bl Task__Unknown204BE48__LerpValue
	mov r1, r6
	add r1, #0xe6
	strh r0, [r1]
	mov r0, #1
	lsl r0, r0, #0xc
	ldr r1, _02169558 // =0x00000199
	mov r2, r4
	lsl r3, r0, #1
	bl Task__Unknown204BE48__LerpValue
	str r0, [r6, #0x10]
	ldrh r0, [r6, #0xc]
	cmp r0, #0x20
	bls _02169552
	mov r0, #0
	strh r0, [r6, #0xc]
	ldr r0, _0216955C // =VSMenuHeader__Main1
	bl SetCurrentTaskMainEvent
_02169552:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02169554: .word VSMenu__Singleton
_02169558: .word 0x00000199
_0216955C: .word VSMenuHeader__Main1
	thumb_func_end VSMenuHeader__Main_21694DC

	thumb_func_start VSMenuHeader__Main2
VSMenuHeader__Main2: // 0x02169560
	push {r3, r4, r5, lr}
	ldr r0, _021695C0 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #5
	add r4, #0x30
	lsl r0, r0, #6
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _021695BC
	mov r0, r4
	add r0, #0x14
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	add r0, #0x78
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0x10]
	cmp r0, #0
	ble _021695BC
	mov r1, #1
	mov r5, r4
	lsl r1, r1, #0xc
	add r5, #0xdc
	cmp r0, r1
	bne _021695A2
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	pop {r3, r4, r5, pc}
_021695A2:
	mov r0, #8
	ldrsh r0, [r5, r0]
	mov r3, #0
	add r0, r0, #3
	strh r0, [r5, #8]
	ldr r2, [r4, #0x10]
	mov r0, r5
	bl AnimatorSprite__DrawFrameRotoZoom
	mov r0, #8
	ldrsh r0, [r5, r0]
	sub r0, r0, #3
	strh r0, [r5, #8]
_021695BC:
	pop {r3, r4, r5, pc}
	nop
_021695C0: .word VSMenu__Singleton
	thumb_func_end VSMenuHeader__Main2

	thumb_func_start VSMenuBackButton__Main1
VSMenuBackButton__Main1: // 0x021695C4
	push {r3, r4, r5, lr}
	ldr r0, _02169634 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x5d
	lsl r1, r1, #2
	add r4, r0, r1
	mov r0, r4
	mov r5, r4
	add r0, #0x14
	add r5, #0x64
	bl TouchField__Process
	ldr r0, [r4, #0xc]
	ldr r1, [r5, #0x3c]
	cmp r0, #0
	beq _021695FA
	mov r0, #1
	bic r1, r0
	str r1, [r5, #0x3c]
	ldrh r0, [r4, #8]
	cmp r0, #0x10
	bhs _0216960A
	add r0, r0, #1
	strh r0, [r4, #8]
	b _0216960A
_021695FA:
	mov r0, #1
	orr r0, r1
	str r0, [r5, #0x3c]
	ldrh r0, [r4, #8]
	cmp r0, #0
	beq _0216960A
	sub r0, r0, #1
	strh r0, [r4, #8]
_0216960A:
	ldrh r2, [r4, #8]
	mov r0, #0xb0
	mov r1, r0
	lsl r3, r2, #0xc
	asr r2, r3, #3
	lsr r2, r2, #0x1c
	add r2, r3, r2
	lsl r2, r2, #0xc
	mov r3, #1
	asr r2, r2, #0x10
	lsl r3, r3, #0xc
	bl Task__Unknown204BE48__LerpValue
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	pop {r3, r4, r5, pc}
	nop
_02169634: .word VSMenu__Singleton
	thumb_func_end VSMenuBackButton__Main1

	thumb_func_start VSMenuBackButton__Main2
VSMenuBackButton__Main2: // 0x02169638
	push {r3, lr}
	ldr r0, _02169650 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x76
	lsl r1, r1, #2
	add r0, r0, r1
	bl AnimatorSprite__DrawFrame
	pop {r3, pc}
	nop
_02169650: .word VSMenu__Singleton
	thumb_func_end VSMenuBackButton__Main2

	thumb_func_start VSMenuBackground__Main1
VSMenuBackground__Main1: // 0x02169654
	bx lr
	.align 2, 0
	thumb_func_end VSMenuBackground__Main1

	thumb_func_start VSMenuBackground__VBlankCallback
VSMenuBackground__VBlankCallback: // 0x02169658
	push {r4, lr}
	ldr r0, _021696BC // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r3, #0x8f
	lsl r3, r3, #2
	add r0, r0, r3
	mov r2, #8
	ldrsh r4, [r0, r2]
	ldr r1, _021696C0 // =0x00000555
	add r1, r4, r1
	strh r1, [r0, #8]
	ldrsh r1, [r0, r2]
	lsl r1, r1, #4
	lsr r1, r1, #0x10
	beq _021696B8
	ldr r4, [r0, #0xc]
	mov r2, #1
	tst r2, r4
	beq _02169694
	ldr r4, _021696C4 // =0x0213D2CE
	sub r3, #0x3d
	ldrh r2, [r4, #0]
	add r2, r2, r1
	and r2, r3
	strh r2, [r4]
	ldrh r3, [r4, #0]
	ldr r2, _021696C8 // =0x0400001E
	strh r3, [r2]
_02169694:
	ldr r3, [r0, #0xc]
	mov r2, #2
	tst r2, r3
	beq _021696AE
	ldr r3, _021696CC // =0x0213D272
	ldrh r2, [r3, #0]
	add r2, r2, r1
	ldr r1, _021696D0 // =0x000001FF
	and r1, r2
	strh r1, [r3]
	ldrh r2, [r3, #0]
	ldr r1, _021696D4 // =0x0400101E
	strh r2, [r1]
_021696AE:
	mov r1, #8
	ldrsh r2, [r0, r1]
	ldr r1, _021696D8 // =0x00000FFF
	and r1, r2
	strh r1, [r0, #8]
_021696B8:
	pop {r4, pc}
	nop
_021696BC: .word VSMenu__Singleton
_021696C0: .word 0x00000555
_021696C4: .word 0x0213D2CE
_021696C8: .word 0x0400001E
_021696CC: .word 0x0213D272
_021696D0: .word 0x000001FF
_021696D4: .word 0x0400101E
_021696D8: .word 0x00000FFF
	thumb_func_end VSMenuBackground__VBlankCallback

	thumb_func_start VSMenuNetworkMessage__Main1
VSMenuNetworkMessage__Main1: // 0x021696DC
	push {r3, r4, lr}
	sub sp, #4
	ldr r0, _02169724 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x93
	lsl r1, r1, #2
	add r4, r0, r1
	ldrh r2, [r4, #0xc]
	ldr r0, _02169728 // =0x0000FFFF
	cmp r2, r0
	beq _02169716
	sub r1, #0x60
	mov r3, #0
	add r0, r4, r1
	mov r1, #1
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	mov r0, #0x7b
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__StartAnimating
	ldr r0, _0216972C // =VSMenuNetworkMessage__Main_2169730
	bl SetCurrentTaskMainEvent
_02169716:
	add r4, #0x78
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	add sp, #4
	pop {r3, r4, pc}
	nop
_02169724: .word VSMenu__Singleton
_02169728: .word 0x0000FFFF
_0216972C: .word VSMenuNetworkMessage__Main_2169730
	thumb_func_end VSMenuNetworkMessage__Main1

	thumb_func_start VSMenuNetworkMessage__Main_2169730
VSMenuNetworkMessage__Main_2169730: // 0x02169730
	push {r4, lr}
	ldr r0, _02169784 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x93
	lsl r1, r1, #2
	add r4, r0, r1
	sub r1, #0x60
	add r0, r4, r1
	mov r1, #0x40
	bl FontWindowAnimator__DisableFlags
	mov r0, #1
	lsl r0, r0, #0x1a
	mov r1, #0x1f
	ldr r2, [r0, #0]
	lsl r1, r1, #8
	and r1, r2
	lsr r3, r1, #8
	ldr r2, [r0, #0]
	ldr r1, _02169788 // =0xFFFFE0FF
	and r2, r1
	mov r1, #2
	orr r1, r3
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r0]
	mov r0, #0x7b
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__ProcessWindowAnim
	add r4, #0x78
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	ldr r0, _0216978C // =VSMenuNetworkMessage__Main_2169790
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	nop
_02169784: .word VSMenu__Singleton
_02169788: .word 0xFFFFE0FF
_0216978C: .word VSMenuNetworkMessage__Main_2169790
	thumb_func_end VSMenuNetworkMessage__Main_2169730

	thumb_func_start VSMenuNetworkMessage__Main_2169790
VSMenuNetworkMessage__Main_2169790: // 0x02169790
	push {r3, r4, lr}
	sub sp, #4
	ldr r0, _02169860 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x93
	lsl r1, r1, #2
	add r4, r0, r1
	sub r1, #0x60
	add r0, r4, r1
	bl FontWindowAnimator__ProcessWindowAnim
	mov r0, #0x7b
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _02169852
	mov r0, #0x7b
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__SetWindowOpen
	ldrh r1, [r4, #0xc]
	ldr r0, _02169864 // =0x0000FFFF
	cmp r1, r0
	beq _02169830
	mov r0, #0x4a
	lsl r0, r0, #2
	strh r1, [r4, #0xe]
	add r0, r4, r0
	mov r1, #0x40
	bl FontAnimator__EnableFlags
	mov r0, #0x4a
	lsl r0, r0, #2
	ldrh r1, [r4, #0xe]
	add r0, r4, r0
	bl FontAnimator__SetMsgSequence
	mov r0, #0x4a
	lsl r0, r0, #2
	ldr r1, _02169868 // =VSMenu__Func_2167458
	add r0, r4, r0
	mov r2, r4
	bl FontAnimator__SetCallback
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	mov r1, r0
	lsl r2, r1, #4
	lsr r1, r2, #0x1f
	add r1, r2, r1
	asr r2, r1, #1
	mov r1, #0x44
	mov r0, #0x4a
	sub r1, r1, r2
	lsl r0, r0, #2
	lsl r1, r1, #0x10
	add r0, r4, r0
	asr r1, r1, #0x10
	bl FontAnimator__AdvanceLine
	ldr r0, _0216986C // =VSMenuNetworkMessage__Main_2169874
	bl SetCurrentTaskMainEvent
	b _02169852
_02169830:
	mov r0, #0x7b
	lsl r0, r0, #2
	mov r3, #0
	add r0, r4, r0
	mov r1, #4
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	mov r0, #0x7b
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__StartAnimating
	ldr r0, _02169870 // =VSMenuNetworkMessage__Main_21699D8
	bl SetCurrentTaskMainEvent
_02169852:
	add r4, #0x78
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	add sp, #4
	pop {r3, r4, pc}
	nop
_02169860: .word VSMenu__Singleton
_02169864: .word 0x0000FFFF
_02169868: .word VSMenu__Func_2167458
_0216986C: .word VSMenuNetworkMessage__Main_2169874
_02169870: .word VSMenuNetworkMessage__Main_21699D8
	thumb_func_end VSMenuNetworkMessage__Main_2169790

	thumb_func_start VSMenuNetworkMessage__Main_2169874
VSMenuNetworkMessage__Main_2169874: // 0x02169874
	push {r3, r4, r5, lr}
	ldr r0, _021698EC // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x93
	lsl r1, r1, #2
	add r4, r0, r1
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0x20
	bl FontAnimator__LoadCharacters
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	beq _021698E2
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0x40
	bl FontAnimator__DisableFlags
	mov r5, r4
	add r5, #0x14
	ldr r0, [r4, #0x10]
	ldr r1, [r5, #0x3c]
	cmp r0, #0
	beq _021698D6
	mov r0, #1
	tst r0, r1
	beq _021698DC
	mov r0, #1
	bic r1, r0
	str r1, [r5, #0x3c]
	mov r0, r5
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	b _021698DC
_021698D6:
	mov r0, #1
	orr r0, r1
	str r0, [r5, #0x3c]
_021698DC:
	ldr r0, _021698F0 // =VSMenuNetworkMessage__Main_21698F4
	bl SetCurrentTaskMainEvent
_021698E2:
	add r4, #0x78
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	pop {r3, r4, r5, pc}
	.align 2, 0
_021698EC: .word VSMenu__Singleton
_021698F0: .word VSMenuNetworkMessage__Main_21698F4
	thumb_func_end VSMenuNetworkMessage__Main_2169874

	thumb_func_start VSMenuNetworkMessage__Main_21698F4
VSMenuNetworkMessage__Main_21698F4: // 0x021698F4
	push {r3, r4, r5, lr}
	ldr r0, _021699C8 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x93
	lsl r1, r1, #2
	add r4, r0, r1
	mov r5, r4
	add r5, #0x14
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldrh r1, [r4, #0xc]
	ldr r0, _021699CC // =0x0000FFFF
	cmp r1, r0
	bne _02169954
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__ClearPixels
	mov r0, #0x7b
	lsl r0, r0, #2
	mov r3, #0
	add r0, r4, r0
	mov r1, #4
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	mov r0, #0x7b
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__StartAnimating
	mov r0, #0
	str r0, [r4, #0x10]
	ldr r1, [r5, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r5, #0x3c]
	ldr r0, _021699D0 // =VSMenuNetworkMessage__Main_21699D8
	bl SetCurrentTaskMainEvent
	b _021699BE
_02169954:
	ldrh r0, [r4, #0xe]
	cmp r0, r1
	beq _021699BE
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0x40
	bl FontAnimator__EnableFlags
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__ClearPixels
	ldrh r1, [r4, #0xc]
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	strh r1, [r4, #0xe]
	bl FontAnimator__SetMsgSequence
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	mov r1, r0
	lsl r2, r1, #4
	lsr r1, r2, #0x1f
	add r1, r2, r1
	asr r2, r1, #1
	mov r1, #0x44
	mov r0, #0x4a
	sub r1, r1, r2
	lsl r0, r0, #2
	lsl r1, r1, #0x10
	add r0, r4, r0
	asr r1, r1, #0x10
	bl FontAnimator__AdvanceLine
	mov r0, #0
	str r0, [r4, #0x10]
	ldr r0, _021699D4 // =VSMenuNetworkMessage__Main_2169874
	bl SetCurrentTaskMainEvent
_021699BE:
	add r4, #0x78
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	pop {r3, r4, r5, pc}
	.align 2, 0
_021699C8: .word VSMenu__Singleton
_021699CC: .word 0x0000FFFF
_021699D0: .word VSMenuNetworkMessage__Main_21699D8
_021699D4: .word VSMenuNetworkMessage__Main_2169874
	thumb_func_end VSMenuNetworkMessage__Main_21698F4

	thumb_func_start VSMenuNetworkMessage__Main_21699D8
VSMenuNetworkMessage__Main_21699D8: // 0x021699D8
	push {r4, lr}
	ldr r0, _02169A44 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x93
	lsl r1, r1, #2
	add r4, r0, r1
	sub r1, #0x60
	add r0, r4, r1
	bl FontWindowAnimator__ProcessWindowAnim
	mov r0, #0x7b
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _02169A38
	mov r0, #0x7b
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0x40
	bl FontWindowAnimator__EnableFlags
	mov r0, #1
	lsl r0, r0, #0x1a
	mov r1, #0x1f
	ldr r2, [r0, #0]
	lsl r1, r1, #8
	and r1, r2
	lsr r3, r1, #8
	ldr r2, [r0, #0]
	ldr r1, _02169A48 // =0xFFFFE0FF
	and r2, r1
	mov r1, #2
	bic r3, r1
	lsl r1, r3, #8
	orr r1, r2
	str r1, [r0]
	mov r0, #0x7b
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__SetWindowOpen
	ldr r0, _02169A4C // =VSMenuNetworkMessage__Main1
	bl SetCurrentTaskMainEvent
_02169A38:
	add r4, #0x78
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	pop {r4, pc}
	nop
_02169A44: .word VSMenu__Singleton
_02169A48: .word 0xFFFFE0FF
_02169A4C: .word VSMenuNetworkMessage__Main1
	thumb_func_end VSMenuNetworkMessage__Main_21699D8

	thumb_func_start VSMenuNetworkMessage__Main2
VSMenuNetworkMessage__Main2: // 0x02169A50
	push {r4, lr}
	ldr r0, _02169A7C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x93
	lsl r1, r1, #2
	add r4, r0, r1
	sub r1, #0x60
	add r0, r4, r1
	bl FontWindowAnimator__Draw
	mov r0, #0x4a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__Draw
	add r4, #0x14
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	pop {r4, pc}
	.align 2, 0
_02169A7C: .word VSMenu__Singleton
	thumb_func_end VSMenuNetworkMessage__Main2
