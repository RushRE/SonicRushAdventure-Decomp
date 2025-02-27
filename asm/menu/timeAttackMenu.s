	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public TimeAttackMenu__Singleton
TimeAttackMenu__Singleton: // 0x0217EFF0
	.space 0x04 // Task*

	.text

	thumb_func_start TimeAttackMenu__Create
TimeAttackMenu__Create: // 0x0216C540
	push {lr}
	sub sp, #0xc
	ldr r0, _0216C568 // =0x00002001
	mov r2, #0
	str r0, [sp]
	ldr r0, _0216C56C // =0x00001518
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0216C570 // =TimeAttackMenu__Main
	ldr r1, _0216C574 // =TimeAttackMenu__Destructor
	mov r3, r2
	bl TaskCreate_
	ldr r1, _0216C578 // =TimeAttackMenu__Singleton
	str r0, [r1]
	bl TimeAttackMenu__Setup
	add sp, #0xc
	pop {pc}
	nop
_0216C568: .word 0x00002001
_0216C56C: .word 0x00001518
_0216C570: .word TimeAttackMenu__Main
_0216C574: .word TimeAttackMenu__Destructor
_0216C578: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Create

	thumb_func_start TimeAttackMenu__Func_216C57C
TimeAttackMenu__Func_216C57C: // 0x0216C57C
	push {r4, lr}
	mov r4, r0
	ldr r0, _0216C590 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x6b
	lsl r1, r1, #2
	strh r4, [r0, r1]
	pop {r4, pc}
	.align 2, 0
_0216C590: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Func_216C57C

	thumb_func_start TimeAttackMenu__Func_216C594
TimeAttackMenu__Func_216C594: // 0x0216C594
	push {r3, lr}
	ldr r0, _0216C5B4 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x69
	lsl r1, r1, #2
	ldr r0, [r0, r1]
	ldr r2, _0216C5B8 // =TimeAttackMessageWindow__Main1
	ldr r0, [r0, #8]
	cmp r2, r0
	beq _0216C5B0
	mov r0, #1
	pop {r3, pc}
_0216C5B0:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
_0216C5B4: .word TimeAttackMenu__Singleton
_0216C5B8: .word TimeAttackMessageWindow__Main1
	thumb_func_end TimeAttackMenu__Func_216C594

	thumb_func_start TimeAttackMenu__Func_216C5BC
TimeAttackMenu__Func_216C5BC: // 0x0216C5BC
	push {r3, lr}
	ldr r0, _0216C5DC // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x69
	lsl r1, r1, #2
	ldr r0, [r0, r1]
	ldr r2, _0216C5E0 // =TimeAttackMessageWindow__Main_SetNextSequence
	ldr r0, [r0, #8]
	cmp r2, r0
	bne _0216C5D8
	mov r0, #1
	pop {r3, pc}
_0216C5D8:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
_0216C5DC: .word TimeAttackMenu__Singleton
_0216C5E0: .word TimeAttackMessageWindow__Main_SetNextSequence
	thumb_func_end TimeAttackMenu__Func_216C5BC

	thumb_func_start TimeAttackMenu__Func_216C5E4
TimeAttackMenu__Func_216C5E4: // 0x0216C5E4
	push {r3, lr}
	ldr r0, _0216C5F8 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x86
	lsl r1, r1, #2
	add r0, r0, r1
	pop {r3, pc}
	nop
_0216C5F8: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Func_216C5E4

	thumb_func_start TimeAttackMenu__Func_216C5FC
TimeAttackMenu__Func_216C5FC: // 0x0216C5FC
	push {r3, lr}
	ldr r0, _0216C60C // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0xc]
	pop {r3, pc}
	nop
_0216C60C: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Func_216C5FC

	thumb_func_start TimeAttackMenu__Func_216C610
TimeAttackMenu__Func_216C610: // 0x0216C610
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _0216C63C // =TimeAttackMenu__Singleton
	mov r4, r1
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, #0xdc
	str r5, [r0, #0xc]
	str r4, [r0, #0x10]
	cmp r5, #0
	ldr r2, [r0, #0x40]
	beq _0216C632
	mov r1, #0x80
	bic r2, r1
	str r2, [r0, #0x40]
	pop {r3, r4, r5, pc}
_0216C632:
	mov r1, #0x80
	orr r1, r2
	str r1, [r0, #0x40]
	pop {r3, r4, r5, pc}
	nop
_0216C63C: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Func_216C610

	thumb_func_start TimeAttackMenu__Func_216C640
TimeAttackMenu__Func_216C640: // 0x0216C640
	push {r3, lr}
	ldr r0, _0216C654 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x47
	lsl r1, r1, #2
	ldr r0, [r0, r1]
	pop {r3, pc}
	nop
_0216C654: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Func_216C640

	thumb_func_start TimeAttackMenu__GetSpriteButton1
TimeAttackMenu__GetSpriteButton1: // 0x0216C658
	push {r3, lr}
	ldr r0, _0216C668 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216C66C // =0x00000E54
	add r0, r0, r1
	pop {r3, pc}
	.align 2, 0
_0216C668: .word TimeAttackMenu__Singleton
_0216C66C: .word 0x00000E54
	thumb_func_end TimeAttackMenu__GetSpriteButton1

	thumb_func_start TimeAttackMenu__Func_216C670
TimeAttackMenu__Func_216C670: // 0x0216C670
	push {r3, lr}
	ldr r0, _0216C680 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216C684 // =0x00001098
	add r0, r0, r1
	pop {r3, pc}
	.align 2, 0
_0216C680: .word TimeAttackMenu__Singleton
_0216C684: .word 0x00001098
	thumb_func_end TimeAttackMenu__Func_216C670

	thumb_func_start TimeAttackMenu__Func_216C688
TimeAttackMenu__Func_216C688: // 0x0216C688
	push {r3, r4, r5, lr}
	bl TimeAttackMenu__ResetDisplay
	ldr r0, _0216C704 // =renderCoreGFXControlA
	mov r1, #0
	strh r1, [r0, #4]
	ldrh r1, [r0, #4]
	strh r1, [r0, #6]
	strh r1, [r0]
	strh r1, [r0, #2]
	ldr r0, _0216C708 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216C70C // =0x00000DB8
	mov r3, #0x43
	add r2, r0, r1
	mov r0, #8
	ldrsh r0, [r2, r0]
	ldr r1, _0216C710 // =renderCoreGFXControlB
	sub r0, #0x22
	strh r0, [r1, #4]
	mov r0, #0xa
	ldrsh r2, [r2, r0]
	mov r0, #0x10
	sub r0, r0, r2
	strh r0, [r1, #6]
	ldr r1, _0216C714 // =0x0400000E
	ldr r2, _0216C718 // =0x00004018
	ldrh r0, [r1, #0]
	and r0, r3
	orr r0, r2
	strh r0, [r1]
	ldr r0, _0216C71C // =0x0400100E
	ldrh r4, [r0, #0]
	and r4, r3
	orr r2, r4
	sub r4, r1, #6
	strh r2, [r0]
	ldrh r2, [r4, #0]
	mov r5, r2
	and r5, r3
	lsl r2, r3, #3
	orr r2, r5
	strh r2, [r4]
	sub r2, r1, #4
	ldrh r1, [r2, #0]
	mov r4, r1
	mov r1, #0xc6
	and r4, r3
	lsl r1, r1, #2
	orr r1, r4
	strh r1, [r2]
	sub r1, r0, #4
	ldrh r0, [r1, #0]
	mov r2, r0
	ldr r0, _0216C720 // =0x0000821C
	and r2, r3
	orr r0, r2
	strh r0, [r1]
	pop {r3, r4, r5, pc}
	nop
_0216C704: .word renderCoreGFXControlA
_0216C708: .word TimeAttackMenu__Singleton
_0216C70C: .word 0x00000DB8
_0216C710: .word renderCoreGFXControlB
_0216C714: .word 0x0400000E
_0216C718: .word 0x00004018
_0216C71C: .word 0x0400100E
_0216C720: .word 0x0000821C
	thumb_func_end TimeAttackMenu__Func_216C688

	thumb_func_start TimeAttackMenu__Destructor
TimeAttackMenu__Destructor: // 0x0216C724
	ldr r0, _0216C72C // =TimeAttackMenu__Singleton
	mov r1, #0
	str r1, [r0]
	bx lr
	.align 2, 0
_0216C72C: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Destructor

	thumb_func_start TimeAttackMenu__Func_216C730
TimeAttackMenu__Func_216C730: // 0x0216C730
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _0216C7BC // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	cmp r5, #0
	beq _0216C748
	cmp r5, #1
	beq _0216C780
	b _0216C7A6
_0216C748:
	ldr r0, _0216C7C0 // =gameState
	ldr r0, [r0, #0x14]
	cmp r0, #3
	beq _0216C75A
	bl ReleaseGameState
	ldr r0, _0216C7C4 // =gameState+0x000000C0
	mov r1, #1
	strb r1, [r0, #0x1c]
_0216C75A:
	mov r0, #0
	bl RequestSysEventChange
	ldr r0, _0216C7C8 // =0x00001510
	mov r1, #0
	str r1, [r4, r0]
	ldr r1, _0216C7CC // =renderCoreGFXControlA+0x00000040
	mov r0, #0x18
	ldrsh r1, [r1, r0]
	sub r0, #0x28
	cmp r1, r0
	ble _0216C7A6
	cmp r1, #0x10
	bge _0216C7A6
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	b _0216C7A6
_0216C780:
	mov r0, #1
	bl RequestSysEventChange
	ldr r1, _0216C7CC // =renderCoreGFXControlA+0x00000040
	mov r0, #0x18
	ldrsh r1, [r1, r0]
	sub r0, #0x28
	cmp r1, r0
	ble _0216C7A6
	cmp r1, #0x10
	bge _0216C7A6
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	mov r0, #0xc
	bl FadeSysTrack
_0216C7A6:
	mov r0, #0
	mov r1, r0
	bl TimeAttackMenu__Func_216C610
	ldr r0, _0216C7BC // =TimeAttackMenu__Singleton
	ldr r1, _0216C7D0 // =TimeAttackMenu__Main_216D7E8
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r3, r4, r5, pc}
	nop
_0216C7BC: .word TimeAttackMenu__Singleton
_0216C7C0: .word gameState
_0216C7C4: .word gameState+0x000000C0
_0216C7C8: .word 0x00001510
_0216C7CC: .word renderCoreGFXControlA+0x00000040
_0216C7D0: .word TimeAttackMenu__Main_216D7E8
	thumb_func_end TimeAttackMenu__Func_216C730

	thumb_func_start TimeAttackMenu__Setup
TimeAttackMenu__Setup: // 0x0216C7D4
	push {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	bl GetTaskWork_
	mov r4, r0
	bl GetSysEventList
	mov r5, r0
	ldr r2, _0216C9AC // =0x00001518
	mov r0, #0
	mov r1, r4
	ldr r7, _0216C9B0 // =gameState
	bl MIi_CpuClear16
	ldr r0, _0216C9B4 // =0x00001504
	mov r1, #0
	str r1, [r4, r0]
	mov r0, #0xc
	ldrsh r0, [r5, r0]
	sub r0, #0x13
	cmp r0, #5
	bhi _0216C81C
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0216C80C: // jump table
	.hword _0216C818 - _0216C80C - 2 // case 0
	.hword _0216C818 - _0216C80C - 2 // case 1
	.hword _0216C81C - _0216C80C - 2 // case 2
	.hword _0216C81C - _0216C80C - 2 // case 3
	.hword _0216C81C - _0216C80C - 2 // case 4
	.hword _0216C818 - _0216C80C - 2 // case 5
_0216C818:
	mov r0, #2
	str r0, [r7, #0x14]
_0216C81C:
	bl TimeAttackMenu__SetupDisplay
	ldr r1, _0216C9B8 // =renderCoreGFXControlA+0x00000040
	mov r0, #0x18
	ldrsh r0, [r1, r0]
	cmp r0, #0
	beq _0216C840
	bge _0216C830
	mov r0, #2
	b _0216C832
_0216C830:
	mov r0, #3
_0216C832:
	lsl r0, r0, #0x10
	mov r1, #1
	lsr r0, r0, #0x10
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	b _0216C84A
_0216C840:
	mov r1, #1
	mov r0, #0x42
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
_0216C84A:
	bl MultibootManager__GetField8
	cmp r0, #0x18
	bne _0216C862
	bl MultibootManager__Create
	bl MultibootManager__GetField8
	cmp r0, #0x16
	beq _0216C862
	bl MultibootManager__Func_206150C
_0216C862:
	bl TimeAttackMenu__LoadArchives
	mov r0, #0xc
	ldrsh r0, [r5, r0]
	cmp r0, #7
	beq _0216C880
	bl LoadSysSoundVillage
	mov r0, #0
	bl PlaySysVillageTrack
	ldr r0, _0216C9BC // =0x00001510
	mov r1, #1
	str r1, [r4, r0]
	b _0216C8AE
_0216C880:
	bl SaveGame__Func_205BEDC
	cmp r0, #0
	bne _0216C89A
	bl LoadSysSoundVillage
	mov r0, #0
	bl PlaySysVillageTrack
	ldr r0, _0216C9BC // =0x00001510
	mov r1, #1
	str r1, [r4, r0]
	b _0216C8AE
_0216C89A:
	mov r0, #0x15
	bl LoadSysSound
	mov r0, #0x13
	mov r1, #0
	bl PlaySysTrack
	ldr r0, _0216C9BC // =0x00001510
	mov r1, #1
	str r1, [r4, r0]
_0216C8AE:
	bl TimeAttackMenuBG__Create
	bl TimeAttackMenu__InitTextWorker
	bl TimeAttackMessageWindow__Create
	ldr r0, _0216C9C0 // =0x00000E54
	add r0, r4, r0
	bl SaveSpriteButton__LoadAssets
	ldr r0, _0216C9C4 // =0x00001098
	add r0, r4, r0
	bl SaveSpriteButton__Func_206515C
	bl TimeAttackBackButton__Create
	bl LoadConnectionStatusIconAssets
	bl TimeAttackMenuHeader__Create
	bl CharacterSelectMenu__LoadAssets
	ldr r1, _0216C9C8 // =0x00000E24
	mov r2, #0
	str r0, [r4, r1]
	ldr r0, [r4, r1]
	ldr r1, _0216C9CC // =TimeAttackMenu__Func_216D574
	bl CharacterSelect__Func_215FC30
	bl StageSelectMenu__LoadAssets
	ldr r1, _0216C9D0 // =0x00000E28
	str r0, [r4, r1]
	add r1, #0x18
	add r0, r4, r1
	bl TimeAttackRecordsMenu__LoadAssets
	ldr r1, _0216C9D4 // =0x00000E2C
	add r0, r4, r1
	add r1, #0x14
	add r1, r4, r1
	bl TimeAttackLeaderboardsMenu__LoadAssets
	bl ResetTouchInput
	mov r0, #0xe
	ldrsh r0, [r5, r0]
	cmp r0, #0xf
	beq _0216C916
	cmp r0, #0x21
	beq _0216C944
	b _0216C94E
_0216C916:
	mov r0, #0xc
	ldrsh r0, [r5, r0]
	cmp r0, #0x16
	bne _0216C93A
	ldr r0, _0216C9B4 // =0x00001504
	mov r1, #1
	str r1, [r4, r0]
	ldr r0, _0216C9B0 // =gameState
	ldrh r0, [r0, #0x28]
	bl MenuHelpers__GetLeaderboardIDFromStageID
	ldr r1, _0216C9D8 // =0x00001514
	str r0, [r4, r1]
	ldr r1, _0216C9DC // =TimeAttackMenu__Main_216E850
	mov r0, r6
	bl SetTaskMainEvent
	pop {r3, r4, r5, r6, r7, pc}
_0216C93A:
	ldr r1, _0216C9E0 // =TimeAttackMenu__Main_216E660
	mov r0, r6
	bl SetTaskMainEvent
	pop {r3, r4, r5, r6, r7, pc}
_0216C944:
	ldr r0, _0216C9E4 // =TimeAttackMenu__Func_216D688
	mov r1, #0
	bl TimeAttackMenu__SetState
	pop {r3, r4, r5, r6, r7, pc}
_0216C94E:
	mov r1, #0xc
	ldrsh r1, [r5, r1]
	cmp r1, #7
	bgt _0216C95A
	beq _0216C98C
	pop {r3, r4, r5, r6, r7, pc}
_0216C95A:
	sub r1, #0x13
	cmp r1, #5
	bhi _0216C9A8
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add pc, r1
_0216C96C: // jump table
	.hword _0216C98C - _0216C96C - 2 // case 0
	.hword _0216C996 - _0216C96C - 2 // case 1
	.hword _0216C9A0 - _0216C96C - 2 // case 2
	.hword _0216C9A8 - _0216C96C - 2 // case 3
	.hword _0216C9A8 - _0216C96C - 2 // case 4
	.hword _0216C978 - _0216C96C - 2 // case 5
_0216C978:
	cmp r0, #0x1c
	bne _0216C982
	mov r0, #0
	strh r0, [r7, #0x28]
	str r0, [r7, #4]
_0216C982:
	ldr r0, _0216C9E4 // =TimeAttackMenu__Func_216D688
	mov r1, #0
	bl TimeAttackMenu__SetState
	pop {r3, r4, r5, r6, r7, pc}
_0216C98C:
	ldr r1, _0216C9E8 // =TimeAttackMenu__Main_InitCharacterSelect
	mov r0, r6
	bl SetTaskMainEvent
	pop {r3, r4, r5, r6, r7, pc}
_0216C996:
	ldr r1, _0216C9EC // =TimeAttackMenu__Main_216E180
	mov r0, r6
	bl SetTaskMainEvent
	pop {r3, r4, r5, r6, r7, pc}
_0216C9A0:
	ldr r1, _0216C9E0 // =TimeAttackMenu__Main_216E660
	mov r0, r6
	bl SetTaskMainEvent
_0216C9A8:
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0216C9AC: .word 0x00001518
_0216C9B0: .word gameState
_0216C9B4: .word 0x00001504
_0216C9B8: .word renderCoreGFXControlA+0x00000040
_0216C9BC: .word 0x00001510
_0216C9C0: .word 0x00000E54
_0216C9C4: .word 0x00001098
_0216C9C8: .word 0x00000E24
_0216C9CC: .word TimeAttackMenu__Func_216D574
_0216C9D0: .word 0x00000E28
_0216C9D4: .word 0x00000E2C
_0216C9D8: .word 0x00001514
_0216C9DC: .word TimeAttackMenu__Main_216E850
_0216C9E0: .word TimeAttackMenu__Main_216E660
_0216C9E4: .word TimeAttackMenu__Func_216D688
_0216C9E8: .word TimeAttackMenu__Main_InitCharacterSelect
_0216C9EC: .word TimeAttackMenu__Main_216E180
	thumb_func_end TimeAttackMenu__Setup

	thumb_func_start TimeAttackMenu__Destroy
TimeAttackMenu__Destroy: // 0x0216C9F0
	push {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl ReleaseTouchInput
	ldr r0, _0216CA64 // =0x00000E2C
	add r0, r4, r0
	bl TimeAttackLeaderboardsMenu__ReleaseAssets
	mov r0, #0x39
	lsl r0, r0, #6
	add r0, r4, r0
	bl TimeAttackRecordsMenu__ReleaseAssets
	ldr r0, _0216CA68 // =0x00000E28
	ldr r0, [r4, r0]
	bl StageSelectMenu__ReleaseAssets
	ldr r0, _0216CA68 // =0x00000E28
	mov r1, #0
	str r1, [r4, r0]
	sub r0, r0, #4
	ldr r0, [r4, r0]
	bl CharacterSelectMenu__ReleaseAssets
	ldr r0, _0216CA6C // =0x00000E24
	mov r1, #0
	str r1, [r4, r0]
	bl TimeAttackMenu__Func_216D0AC
	bl ReleaseConnectionStatusIconAssets
	bl TimeAttackMenu__Func_216D1C0
	ldr r0, _0216CA70 // =0x00001098
	add r0, r4, r0
	bl SaveSpriteButton__Func_20651A4
	ldr r0, _0216CA74 // =0x00000E54
	add r0, r4, r0
	bl SaveSpriteButton__Release
	bl TimeAttackMenu__ReleaseTextWorker
	bl TimeAttackMenu__Func_216CD08
	ldr r0, _0216CA78 // =0x00001510
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0216CA5A
	bl ReleaseSysSound
_0216CA5A:
	bl TimeAttackMenu__ReleaseArchives
	bl MultibootManager__Func_2060C9C
	pop {r4, pc}
	.align 2, 0
_0216CA64: .word 0x00000E2C
_0216CA68: .word 0x00000E28
_0216CA6C: .word 0x00000E24
_0216CA70: .word 0x00001098
_0216CA74: .word 0x00000E54
_0216CA78: .word 0x00001510
	thumb_func_end TimeAttackMenu__Destroy

	thumb_func_start TimeAttackMenu__SetupDisplay
TimeAttackMenu__SetupDisplay: // 0x0216CA7C
	push {r4, lr}
	bl TimeAttackMenu__ResetDisplay
	mov r0, #0
	bl VRAMSystem__Init
	mov r1, #0
	mov r0, #1
	mov r2, r1
	bl GX_SetGraphicsMode
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r0, _0216CAF4 // =renderCurrentDisplay
	mov r1, #1
	str r1, [r0]
	ldr r0, _0216CAF8 // =0x0400000E
	mov r2, #0x43
	ldrh r1, [r0, #0]
	ldr r4, _0216CAFC // =0x0400100E
	mov r3, r1
	ldr r1, _0216CB00 // =0x00004018
	and r3, r2
	orr r3, r1
	strh r3, [r0]
	ldrh r3, [r4, #0]
	and r3, r2
	orr r1, r3
	sub r3, r0, #6
	strh r1, [r4]
	ldrh r1, [r3, #0]
	mov r4, r1
	and r4, r2
	lsl r1, r2, #3
	orr r1, r4
	strh r1, [r3]
	sub r1, r0, #4
	ldrh r0, [r1, #0]
	and r2, r0
	mov r0, #0xc6
	lsl r0, r0, #2
	orr r0, r2
	strh r0, [r1]
	mov r0, #0
	mov r1, r0
	bl BackgroundUnknown__Func_204CA00
	mov r0, #0
	mov r1, #1
	bl BackgroundUnknown__Func_204CA00
	ldr r2, _0216CB04 // =0x0400100A
	mov r0, #0x43
	ldrh r1, [r2, #0]
	and r1, r0
	ldr r0, _0216CB08 // =0x0000821C
	orr r0, r1
	strh r0, [r2]
	pop {r4, pc}
	.align 2, 0
_0216CAF4: .word renderCurrentDisplay
_0216CAF8: .word 0x0400000E
_0216CAFC: .word 0x0400100E
_0216CB00: .word 0x00004018
_0216CB04: .word 0x0400100A
_0216CB08: .word 0x0000821C
	thumb_func_end TimeAttackMenu__SetupDisplay

	thumb_func_start TimeAttackMenu__ResetDisplay
TimeAttackMenu__ResetDisplay: // 0x0216CB0C
	push {r4, r5, r6, r7}
	ldr r0, _0216CB7C // =0x04000008
	mov r4, #3
	ldrh r1, [r0, #0]
	mov r2, #1
	mov r3, #2
	bic r1, r4
	strh r1, [r0]
	ldrh r1, [r0, #2]
	mov r5, #3
	ldr r6, _0216CB80 // =0xFFFFE0FF
	bic r1, r4
	orr r1, r2
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	bic r1, r4
	orr r1, r3
	strh r1, [r0, #4]
	ldrh r1, [r0, #6]
	bic r1, r4
	orr r1, r5
	strh r1, [r0, #6]
	sub r0, #8
	ldr r1, [r0, #0]
	mov r7, r1
	mov r1, #0x19
	and r7, r6
	lsl r1, r1, #8
	orr r1, r7
	str r1, [r0]
	ldr r0, _0216CB84 // =0x04001008
	ldrh r1, [r0, #0]
	bic r1, r4
	strh r1, [r0]
	ldrh r1, [r0, #2]
	bic r1, r4
	orr r1, r2
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	bic r1, r4
	orr r1, r3
	strh r1, [r0, #4]
	ldrh r1, [r0, #6]
	bic r1, r4
	orr r1, r5
	strh r1, [r0, #6]
	sub r0, #8
	ldr r1, [r0, #0]
	mov r2, r1
	and r2, r6
	lsl r1, r5, #0xb
	orr r1, r2
	str r1, [r0]
	pop {r4, r5, r6, r7}
	bx lr
	nop
_0216CB7C: .word 0x04000008
_0216CB80: .word 0xFFFFE0FF
_0216CB84: .word 0x04001008
	thumb_func_end TimeAttackMenu__ResetDisplay

	thumb_func_start TimeAttackMenu__LoadArchives
TimeAttackMenu__LoadArchives: // 0x0216CB88
	push {r4, lr}
	sub sp, #0x10
	ldr r0, _0216CC5C // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0
	ldr r0, _0216CC60 // =aBbDmtaMenuBb_0_ovl03
	str r2, [sp]
	mov r1, #6
	mov r3, #1
	bl ArchiveFile__Load
	str r0, [r4]
	mov r0, #1
	str r0, [sp]
	mov r0, r4
	add r0, #0x10
	str r0, [sp, #4]
	mov r0, #2
	mov r1, r4
	mov r3, r4
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	ldr r0, [r4, #0]
	add r1, #0x18
	add r3, #0x28
	bl StageClear__LoadFiles
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _0216CBF0
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0216CBDC: // jump table
	.hword _0216CBE8 - _0216CBDC - 2 // case 0
	.hword _0216CBE8 - _0216CBDC - 2 // case 1
	.hword _0216CBE8 - _0216CBDC - 2 // case 2
	.hword _0216CBE8 - _0216CBDC - 2 // case 3
	.hword _0216CBE8 - _0216CBDC - 2 // case 4
	.hword _0216CBE8 - _0216CBDC - 2 // case 5
_0216CBE8:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _0216CBF2
_0216CBF0:
	mov r1, #1
_0216CBF2:
	mov r2, #0
	ldr r0, _0216CC60 // =aBbDmtaMenuBb_0_ovl03
	str r2, [sp]
	mov r3, #1
	bl ArchiveFile__Load
	str r0, [r4, #4]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	mov r1, r4
	mov r3, r4
	ldr r0, [r4, #4]
	add r1, #0xc
	mov r2, #1
	add r3, #0x14
	bl StageClear__LoadFiles
	mov r2, #0
	ldr r0, _0216CC64 // =aBbNlBb_4
	str r2, [sp]
	mov r1, #9
	mov r3, r2
	bl ArchiveFile__Load
	str r0, [r4, #0x1c]
	mov r2, #0
	ldr r0, _0216CC64 // =aBbNlBb_4
	str r2, [sp]
	mov r1, #0xc
	mov r3, r2
	bl ArchiveFile__Load
	str r0, [r4, #0x20]
	mov r2, #0
	ldr r0, _0216CC64 // =aBbNlBb_4
	str r2, [sp]
	mov r1, #1
	mov r3, r2
	bl ArchiveFile__Load
	mov r2, #0
	str r0, [r4, #0x24]
	ldr r0, _0216CC68 // =aFntFontAllFnt_4_ovl03
	sub r1, r2, #1
	mov r3, r2
	str r2, [sp]
	bl ArchiveFile__Load
	str r0, [r4, #8]
	add sp, #0x10
	pop {r4, pc}
	nop
_0216CC5C: .word TimeAttackMenu__Singleton
_0216CC60: .word aBbDmtaMenuBb_0_ovl03
_0216CC64: .word aBbNlBb_4
_0216CC68: .word aFntFontAllFnt_4_ovl03
	thumb_func_end TimeAttackMenu__LoadArchives

	thumb_func_start TimeAttackMenu__ReleaseArchives
TimeAttackMenu__ReleaseArchives: // 0x0216CC6C
	push {r4, lr}
	ldr r0, _0216CCA0 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #8]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x24]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x20]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x1c]
	bl _FreeHEAP_USER
	ldr r0, [r4, #4]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0]
	bl _FreeHEAP_USER
	pop {r4, pc}
	nop
_0216CCA0: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__ReleaseArchives

	thumb_func_start TimeAttackMenuBG__Create
TimeAttackMenuBG__Create: // 0x0216CCA4
	push {r4, r5, lr}
	sub sp, #0xc
	ldr r0, _0216CCF8 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _0216CCFC // =gameState
	add r4, #0x2c
	ldr r0, [r0, #0x14]
	mov r5, #1
	cmp r0, #3
	bne _0216CCC2
	mov r5, #0
	b _0216CCD0
_0216CCC2:
	bl GetSysEventList
	mov r1, #0xc
	ldrsh r0, [r0, r1]
	cmp r0, #7
	bne _0216CCD0
	mov r5, #0
_0216CCD0:
	mov r1, #3
	add r0, r4, #4
	mov r2, r1
	mov r3, r5
	bl MainMenu__LoadMenuBG
	mov r1, #0
	ldr r0, _0216CD00 // =0x00002042
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0216CD04 // =TimeAttackMenuBG__Main
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r4]
	add sp, #0xc
	pop {r4, r5, pc}
	nop
_0216CCF8: .word TimeAttackMenu__Singleton
_0216CCFC: .word gameState
_0216CD00: .word 0x00002042
_0216CD04: .word TimeAttackMenuBG__Main
	thumb_func_end TimeAttackMenuBG__Create

	thumb_func_start TimeAttackMenu__Func_216CD08
TimeAttackMenu__Func_216CD08: // 0x0216CD08
	push {r4, lr}
	ldr r0, _0216CD24 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r0, #0x2c]
	add r4, #0x2c
	bl DestroyTask
	add r0, r4, #4
	bl MainMenu__Func_21567BC
	pop {r4, pc}
	.align 2, 0
_0216CD24: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Func_216CD08

	thumb_func_start TimeAttackMenu__InitTextWorker
TimeAttackMenu__InitTextWorker: // 0x0216CD28
	push {r4, r5, lr}
	sub sp, #0x14
	ldr r0, _0216CDAC // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r2, #0x69
	mov r4, r0
	lsl r2, r2, #2
	add r5, r4, r2
	mov r0, #0
	mov r1, r5
	add r2, #0xa8
	bl MIi_CpuClear16
	mov r0, r5
	add r0, #0x74
	bl FontWindow__Init
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r5, r0
	bl FontAnimator__Init
	mov r0, #0x7a
	lsl r0, r0, #2
	add r0, r5, r0
	bl FontWindowAnimator__Init
	mov r0, r5
	ldr r1, [r4, #8]
	add r0, #0x74
	mov r2, #1
	bl FontWindow__LoadFromMemory
	mov r1, #0
	str r1, [r5, #0xc]
	ldr r0, [r4, #0x28]
	add r5, #0x10
	bl SpriteUnknown__GetSpriteSize
	mov r2, #0
	str r2, [sp]
	str r0, [sp, #4]
	mov r0, #0xf
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	str r2, [sp, #0x10]
	ldr r1, [r4, #0x28]
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
_0216CDAC: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__InitTextWorker

	thumb_func_start TimeAttackMenu__ReleaseTextWorker
TimeAttackMenu__ReleaseTextWorker: // 0x0216CDB0
	push {r4, lr}
	ldr r0, _0216CDFC // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x69
	lsl r1, r1, #2
	add r4, r0, r1
	ldr r0, [r4, #0]
	cmp r0, #0
	beq _0216CDCA
	bl DestroyTask
_0216CDCA:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0216CDD4
	bl DestroyTask
_0216CDD4:
	mov r0, r4
	add r0, #0x10
	bl AnimatorSprite__Release
	mov r0, #0x7a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__Release
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__Release
	add r4, #0x74
	mov r0, r4
	bl FontWindow__Release
	pop {r4, pc}
	nop
_0216CDFC: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__ReleaseTextWorker

	thumb_func_start TimeAttackMessageWindow__Create
TimeAttackMessageWindow__Create: // 0x0216CE00
	push {r4, r5, lr}
	sub sp, #0x34
	ldr r0, _0216CF40 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216CF44 // =renderCoreGFXControlA
	mov r2, #0
	strh r2, [r1, #6]
	ldrh r3, [r1, #6]
	mov r4, r0
	mov r0, #0x69
	strh r3, [r1, #4]
	strh r3, [r1, #2]
	strh r3, [r1]
	mov r3, #3
	lsl r0, r0, #2
	add r5, r4, r0
	sub r0, #0x80
	str r3, [sp]
	mov r1, #0x1a
	str r1, [sp, #4]
	mov r1, #0x12
	str r1, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r1, #0xc
	str r1, [sp, #0x14]
	add r1, #0xf4
	str r1, [sp, #0x18]
	mov r1, r5
	add r0, r5, r0
	add r1, #0x74
	bl FontAnimator__LoadFont1
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r5, r0
	bl FontAnimator__LoadMappingsFunc
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r5, r0
	bl FontAnimator__LoadPaletteFunc
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r5, r0
	bl FontAnimator__ClearPixels
	mov r0, #0x49
	lsl r0, r0, #2
	ldr r1, [r4, #0xc]
	add r0, r5, r0
	bl FontAnimator__LoadMPCFile
	add r3, sp, #0x2c
	mov r0, #0
	mov r1, #1
	add r2, sp, #0x2c
	add r3, #2
	bl GetVRAMCharacterConfig
	add r1, sp, #0x28
	ldrh r2, [r1, #4]
	ldrh r1, [r1, #6]
	ldr r0, _0216CF48 // =VRAMSystem__VRAM_BG
	lsl r2, r2, #0x10
	ldr r4, [r0, #0]
	lsl r1, r1, #0xe
	add r1, r2, r1
	add r2, r4, r1
	mov r1, #0x19
	lsl r1, r1, #8
	add r1, r2, r1
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	add r0, sp, #0x28
	add r0, #2
	str r0, [sp]
	mov r0, #0
	mov r1, #1
	add r2, sp, #0x30
	add r3, sp, #0x28
	bl GetVRAMTileConfig
	add r1, sp, #0x28
	ldrh r2, [r1, #0]
	ldrh r1, [r1, #2]
	mov r0, #0
	lsl r2, r2, #0x10
	lsl r1, r1, #0xb
	add r1, r2, r1
	mov r2, #2
	add r1, r4, r1
	lsl r2, r2, #0xa
	bl MIi_CpuClearFast
	mov r0, #2
	str r0, [sp]
	str r0, [sp, #4]
	mov r0, #3
	str r0, [sp, #8]
	mov r0, #0x1c
	str r0, [sp, #0xc]
	mov r0, #0x12
	str r0, [sp, #0x10]
	mov r2, #0
	mov r1, r5
	str r2, [sp, #0x14]
	mov r0, #1
	str r0, [sp, #0x18]
	mov r0, #0xd
	str r0, [sp, #0x1c]
	mov r0, #0xc8
	str r0, [sp, #0x20]
	mov r0, #0x7a
	lsl r0, r0, #2
	add r0, r5, r0
	add r1, #0x74
	mov r3, r2
	str r2, [sp, #0x24]
	bl FontWindowAnimator__Load1
	ldr r0, _0216CF4C // =FontAnimator__Palettes+0x00000008
	ldr r3, _0216CF50 // =0x05000182
	mov r1, #4
	mov r2, #0
	bl QueueUncompressedPalette
	mov r1, #0
	ldr r0, _0216CF54 // =0x0000FFFF
	mov r2, r1
	strh r0, [r5, #8]
	ldrh r0, [r5, #8]
	mov r3, r1
	strh r0, [r5, #0xa]
	ldr r0, _0216CF58 // =0x00002045
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0216CF5C // =TimeAttackMessageWindow__Main1
	str r1, [sp, #8]
	bl TaskCreate_
	mov r1, #0
	str r0, [r5]
	ldr r0, _0216CF60 // =0x00002085
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0216CF64 // =TimeAttackMessageWindow__Main2
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r5, #4]
	add sp, #0x34
	pop {r4, r5, pc}
	.align 2, 0
_0216CF40: .word TimeAttackMenu__Singleton
_0216CF44: .word renderCoreGFXControlA
_0216CF48: .word VRAMSystem__VRAM_BG
_0216CF4C: .word FontAnimator__Palettes+0x00000008
_0216CF50: .word 0x05000182
_0216CF54: .word 0x0000FFFF
_0216CF58: .word 0x00002045
_0216CF5C: .word TimeAttackMessageWindow__Main1
_0216CF60: .word 0x00002085
_0216CF64: .word TimeAttackMessageWindow__Main2
	thumb_func_end TimeAttackMessageWindow__Create

	thumb_func_start TimeAttackMessageWindow__FontCallback
TimeAttackMessageWindow__FontCallback: // 0x0216CF68
	cmp r0, #0xa
	bne _0216CF70
	mov r0, #1
	str r0, [r2, #0xc]
_0216CF70:
	bx lr
	.align 2, 0
	thumb_func_end TimeAttackMessageWindow__FontCallback

	thumb_func_start TimeAttackMenuHeader__Create
TimeAttackMenuHeader__Create: // 0x0216CF74
	push {r4, r5, r6, r7, lr}
	sub sp, #0x1c
	ldr r0, _0216D08C // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x3f
	lsl r0, r0, #4
	mov r3, #1
	add r5, r4, r0
	mov r6, #0x26
	str r3, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	lsl r6, r6, #6
	ldr r1, [r4, #0x10]
	add r0, r5, r6
	mov r2, #0x38
	bl InitBackground
	add r0, r5, r6
	bl DrawBackground
	add r0, sp, #0x14
	add r0, #2
	str r0, [sp]
	mov r0, #1
	mov r1, r0
	add r2, sp, #0x18
	add r3, sp, #0x14
	bl GetVRAMTileConfig
	ldr r1, _0216D090 // =VRAMSystem__VRAM_BG
	add r3, sp, #0x14
	ldr r2, [r1, #4]
	ldrh r1, [r3, #0]
	ldrh r3, [r3, #2]
	mov r0, #0
	lsl r1, r1, #0x10
	lsl r3, r3, #0xb
	add r1, r1, r3
	add r1, r2, r1
	mov r2, #2
	lsl r2, r2, #0xa
	add r1, r1, r2
	bl MIi_CpuClearFast
	mov r0, r6
	ldr r1, _0216D094 // =0x0000FFFF
	add r0, #0xac
	strh r1, [r5, r0]
	sub r0, #0x64
	mov r1, #1
	ldr r7, [r4, #0x14]
	add r6, r5, r0
	mov r0, r7
	mov r2, #0
	mov r3, r1
	bl SpriteUnknown__Func_204C7A4
	mov r1, #1
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #9
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	ldr r3, _0216D098 // =0x00000804
	mov r0, r6
	mov r1, r7
	str r2, [sp, #0x10]
	bl SpriteUnknown__Func_204C90C
	mov r0, #0x22
	strh r0, [r6, #8]
	mov r0, #0xd0
	mov r1, #0
	strh r0, [r6, #0xa]
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	mov r1, #1
	add r0, #8
	mov r2, r1
	mov r3, #0
	bl StageSelectMenu__Unknown__Init
	mov r0, #2
	str r0, [sp]
	mov r0, #8
	str r0, [sp, #4]
	str r0, [sp, #8]
	mov r0, r5
	ldr r2, [r4, #0x1c]
	add r0, #8
	mov r1, #1
	mov r3, #0
	bl StageSelectMenu__Unknown__SetAnimator
	mov r0, #1
	str r0, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r3, [sp, #8]
	mov r0, r5
	ldr r2, [r4, #0x18]
	add r0, #8
	mov r1, #2
	bl StageSelectMenu__Unknown__SetAnimator
	mov r1, #0
	ldr r0, _0216D09C // =0x00002044
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0216D0A0 // =TimeAttackMenuHeader__Main1
	str r1, [sp, #8]
	mov r3, r1
	bl TaskCreate_
	mov r1, #0
	str r0, [r5]
	ldr r0, _0216D0A4 // =0x00002084
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0216D0A8 // =TimeAttackMenuHeader__Main2
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r5, #4]
	add sp, #0x1c
	pop {r4, r5, r6, r7, pc}
	nop
_0216D08C: .word TimeAttackMenu__Singleton
_0216D090: .word VRAMSystem__VRAM_BG
_0216D094: .word 0x0000FFFF
_0216D098: .word 0x00000804
_0216D09C: .word 0x00002044
_0216D0A0: .word TimeAttackMenuHeader__Main1
_0216D0A4: .word 0x00002084
_0216D0A8: .word TimeAttackMenuHeader__Main2
	thumb_func_end TimeAttackMenuHeader__Create

	thumb_func_start TimeAttackMenu__Func_216D0AC
TimeAttackMenu__Func_216D0AC: // 0x0216D0AC
	push {r3, r4, r5, lr}
	ldr r0, _0216D0E0 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x3f
	lsl r0, r0, #4
	add r5, r4, r0
	ldr r0, [r5, #4]
	bl DestroyTask
	mov r0, #0x3f
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	bl DestroyTask
	mov r0, r5
	add r0, #8
	bl StageSelectMenu__Unknown__Release
	ldr r0, _0216D0E4 // =0x000009C8
	add r0, r5, r0
	bl AnimatorSprite__Release
	pop {r3, r4, r5, pc}
	.align 2, 0
_0216D0E0: .word TimeAttackMenu__Singleton
_0216D0E4: .word 0x000009C8
	thumb_func_end TimeAttackMenu__Func_216D0AC

	thumb_func_start TimeAttackBackButton__Create
TimeAttackBackButton__Create: // 0x0216D0E8
	push {r3, r4, r5, r6, lr}
	sub sp, #0x14
	ldr r0, _0216D1A4 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r6, r0
	mov r4, r6
	add r4, #0xdc
	mov r0, r4
	add r0, #0x14
	bl TouchField__Init
	mov r1, #0
	mov r0, r4
	mov r5, r4
	str r1, [r4, #0x20]
	add r0, #0x24
	strb r1, [r0]
	mov r0, r4
	add r0, #0x26
	strb r1, [r0]
	ldr r0, [r6, #0x24]
	mov r1, #1
	add r5, #0x64
	bl SpriteUnknown__GetSpriteSize
	mov r1, #1
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0xf
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	ldr r1, [r6, #0x24]
	ldr r3, _0216D1A8 // =0x00000804
	mov r0, r5
	bl SpriteUnknown__Func_204C90C
	mov r0, #0x10
	strh r0, [r5, #8]
	mov r0, #0xb0
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, _0216D1AC // =TimeAttackBackButton__TouchCallback
	mov r1, r4
	str r0, [sp]
	mov r0, r4
	mov r2, #0
	add r0, #0x2c
	add r1, #0x64
	mov r3, r2
	str r4, [sp, #4]
	bl TouchField__InitAreaSprite
	mov r0, r4
	mov r1, r4
	add r0, #0x14
	add r1, #0x2c
	mov r2, #0
	bl TouchField__AddArea
	mov r1, #0
	str r1, [r4, #0xc]
	ldr r0, _0216D1B0 // =0x00002043
	str r1, [r4, #0x10]
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0216D1B4 // =TimeAttackBackButton__Main1
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	mov r1, #0
	add r6, #0xdc
	str r0, [r6]
	ldr r0, _0216D1B8 // =0x00002083
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0216D1BC // =TimeAttackBackButton__Main2
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r4, #4]
	add sp, #0x14
	pop {r3, r4, r5, r6, pc}
	.align 2, 0
_0216D1A4: .word TimeAttackMenu__Singleton
_0216D1A8: .word 0x00000804
_0216D1AC: .word TimeAttackBackButton__TouchCallback
_0216D1B0: .word 0x00002043
_0216D1B4: .word TimeAttackBackButton__Main1
_0216D1B8: .word 0x00002083
_0216D1BC: .word TimeAttackBackButton__Main2
	thumb_func_end TimeAttackBackButton__Create

	thumb_func_start TimeAttackMenu__Func_216D1C0
TimeAttackMenu__Func_216D1C0: // 0x0216D1C0
	push {r3, r4, r5, lr}
	ldr r0, _0216D1E8 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r5, r4
	add r5, #0xdc
	ldr r0, [r5, #4]
	bl DestroyTask
	add r4, #0xdc
	ldr r0, [r4, #0]
	bl DestroyTask
	add r5, #0x64
	mov r0, r5
	bl AnimatorSprite__Release
	pop {r3, r4, r5, pc}
	.align 2, 0
_0216D1E8: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Func_216D1C0

	thumb_func_start TimeAttackMenu__SetState
TimeAttackMenu__SetState: // 0x0216D1EC
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	ldr r0, _0216D218 // =TimeAttackMenu__Singleton
	mov r6, r1
	ldr r7, [r0, #0]
	mov r0, r7
	bl GetTaskWork_
	mov r4, r0
	bl TimeAttackMenu__ResetDisplay
	mov r0, r6
	bl TimeAttackMenu__Func_216D264
	ldr r0, _0216D21C // =0x000014F8
	ldr r1, _0216D220 // =TimeAttackMenu__Main
	str r5, [r4, r0]
	mov r0, r7
	bl SetTaskMainEvent
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0216D218: .word TimeAttackMenu__Singleton
_0216D21C: .word 0x000014F8
_0216D220: .word TimeAttackMenu__Main
	thumb_func_end TimeAttackMenu__SetState

	thumb_func_start TimeAttackMenu__Func_216D224
TimeAttackMenu__Func_216D224: // 0x0216D224
	push {r4, r5, r6, lr}
	mov r5, r0
	ldr r0, _0216D258 // =TimeAttackMenu__Singleton
	mov r4, r1
	ldr r6, [r0, #0]
	mov r0, r6
	bl GetTaskWork_
	ldr r1, _0216D25C // =0x000014F8
	mov r2, r1
	str r5, [r0, r1]
	add r2, #8
	str r4, [r0, r2]
	mov r2, #4
	tst r2, r4
	beq _0216D248
	mov r2, #0xc
	b _0216D24A
_0216D248:
	mov r2, #0x1c
_0216D24A:
	sub r1, r1, #4
	str r2, [r0, r1]
	ldr r1, _0216D260 // =TimeAttackMenu__Main_216D600
	mov r0, r6
	bl SetTaskMainEvent
	pop {r4, r5, r6, pc}
	.align 2, 0
_0216D258: .word TimeAttackMenu__Singleton
_0216D25C: .word 0x000014F8
_0216D260: .word TimeAttackMenu__Main_216D600
	thumb_func_end TimeAttackMenu__Func_216D224

	thumb_func_start TimeAttackMenu__Func_216D264
TimeAttackMenu__Func_216D264: // 0x0216D264
	push {r4, lr}
	mov r4, r0
	ldr r0, _0216D278 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216D27C // =0x00000E1C
	strh r4, [r0, r1]
	pop {r4, pc}
	nop
_0216D278: .word TimeAttackMenu__Singleton
_0216D27C: .word 0x00000E1C
	thumb_func_end TimeAttackMenu__Func_216D264

	thumb_func_start TimeAttackMenu__Func_216D280
TimeAttackMenu__Func_216D280: // 0x0216D280
	push {r3, lr}
	ldr r0, _0216D2A0 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x3f
	lsl r1, r1, #4
	ldr r0, [r0, r1]
	ldr r2, _0216D2A4 // =TimeAttackMenuHeader__Main1
	ldr r0, [r0, #8]
	cmp r2, r0
	beq _0216D29C
	mov r0, #1
	pop {r3, pc}
_0216D29C:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
_0216D2A0: .word TimeAttackMenu__Singleton
_0216D2A4: .word TimeAttackMenuHeader__Main1
	thumb_func_end TimeAttackMenu__Func_216D280

	thumb_func_start TimeAttackBackButton__TouchCallback
TimeAttackBackButton__TouchCallback: // 0x0216D2A8
	push {r3, r4, r5, lr}
	mov r4, #1
	ldr r3, [r1, #0x14]
	mov r1, r2
	ldr r5, [r0, #0]
	lsl r4, r4, #0x10
	add r1, #0x64
	cmp r5, r4
	beq _0216D2C8
	lsl r0, r4, #1
	cmp r5, r0
	beq _0216D2D8
	lsl r0, r4, #2
	cmp r5, r0
	beq _0216D2E8
	pop {r3, r4, r5, pc}
_0216D2C8:
	lsr r0, r4, #5
	tst r0, r3
	bne _0216D2F2
	mov r0, r1
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	pop {r3, r4, r5, pc}
_0216D2D8:
	lsr r0, r4, #5
	tst r0, r3
	bne _0216D2F2
	mov r0, r1
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	pop {r3, r4, r5, pc}
_0216D2E8:
	ldr r1, [r2, #0xc]
	cmp r1, #0
	beq _0216D2F2
	ldr r0, [r2, #0x10]
	blx r1
_0216D2F2:
	pop {r3, r4, r5, pc}
	thumb_func_end TimeAttackBackButton__TouchCallback

	thumb_func_start TimeAttackMenu__Func_216D2F4
TimeAttackMenu__Func_216D2F4: // 0x0216D2F4
	push {r3, lr}
	cmp r0, #6
	bhi _0216D34A
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0216D306: // jump table
	.hword _0216D314 - _0216D306 - 2 // case 0
	.hword _0216D32C - _0216D306 - 2 // case 1
	.hword _0216D34A - _0216D306 - 2 // case 2
	.hword _0216D31C - _0216D306 - 2 // case 3
	.hword _0216D34A - _0216D306 - 2 // case 4
	.hword _0216D34A - _0216D306 - 2 // case 5
	.hword _0216D334 - _0216D306 - 2 // case 6
_0216D314:
	ldr r0, _0216D34C // =TimeAttackMenu__Func_216D540
	bl TimeAttackMenu__Func_216C610
	pop {r3, pc}
_0216D31C:
	ldr r0, _0216D350 // =TimeAttackMenu__Func_216D5A4
	mov r1, #5
	bl TimeAttackMenu__Func_216D224
	mov r0, #1
	bl PlaySysMenuNavSfx
	b _0216D33C
_0216D32C:
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0216D33C
_0216D334:
	mov r0, #2
	bl PlaySysMenuNavSfx
	pop {r3, pc}
_0216D33C:
	ldr r0, _0216D354 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	mov r0, #0
	mov r1, r0
	bl TimeAttackMenu__Func_216C610
_0216D34A:
	pop {r3, pc}
	.align 2, 0
_0216D34C: .word TimeAttackMenu__Func_216D540
_0216D350: .word TimeAttackMenu__Func_216D5A4
_0216D354: .word 0x0000FFFF
	thumb_func_end TimeAttackMenu__Func_216D2F4

	thumb_func_start TimeAttackMenu__Func_216D358
TimeAttackMenu__Func_216D358: // 0x0216D358
	push {r3, lr}
	cmp r0, #4
	beq _0216D368
	cmp r0, #5
	beq _0216D368
	cmp r0, #6
	beq _0216D370
	pop {r3, pc}
_0216D368:
	mov r0, r1
	bl StageSelectMenu__Unknown__Func_216A4F0
	pop {r3, pc}
_0216D370:
	mov r0, #2
	bl PlaySysMenuNavSfx
	pop {r3, pc}
	thumb_func_end TimeAttackMenu__Func_216D358

	thumb_func_start TimeAttackMenu__Func_216D378
TimeAttackMenu__Func_216D378: // 0x0216D378
	push {r3, lr}
	cmp r0, #0
	beq _0216D384
	cmp r0, #2
	beq _0216D38C
	pop {r3, pc}
_0216D384:
	mov r0, #2
	bl TimeAttackMenu__Func_216C57C
	pop {r3, pc}
_0216D38C:
	ldr r0, _0216D398 // =TimeAttackMenu__Main_216E040
	mov r1, #0
	bl TimeAttackMenu__Func_216D224
	pop {r3, pc}
	nop
_0216D398: .word TimeAttackMenu__Main_216E040
	thumb_func_end TimeAttackMenu__Func_216D378

	thumb_func_start TimeAttackMenu__Func_216D39C
TimeAttackMenu__Func_216D39C: // 0x0216D39C
	push {r3, lr}
	cmp r0, #0
	beq _0216D3A8
	cmp r0, #2
	beq _0216D3B0
	pop {r3, pc}
_0216D3A8:
	mov r0, #3
	bl TimeAttackMenu__Func_216C57C
	pop {r3, pc}
_0216D3B0:
	ldr r0, _0216D3BC // =TimeAttackMenu__Main_216E5B8
	mov r1, #0
	bl TimeAttackMenu__Func_216D224
	pop {r3, pc}
	nop
_0216D3BC: .word TimeAttackMenu__Main_216E5B8
	thumb_func_end TimeAttackMenu__Func_216D39C

	thumb_func_start TimeAttackMenu__Func_216D3C0
TimeAttackMenu__Func_216D3C0: // 0x0216D3C0
	push {r3, lr}
	cmp r0, #0
	beq _0216D3CC
	cmp r0, #2
	beq _0216D3D4
	pop {r3, pc}
_0216D3CC:
	mov r0, #4
	bl TimeAttackMenu__Func_216C57C
	pop {r3, pc}
_0216D3D4:
	ldr r0, _0216D3E0 // =TimeAttackMenu__Main_216E454
	mov r1, #0
	bl TimeAttackMenu__Func_216D224
	pop {r3, pc}
	nop
_0216D3E0: .word TimeAttackMenu__Main_216E454
	thumb_func_end TimeAttackMenu__Func_216D3C0

	thumb_func_start TimeAttackMenu__Func_216D3E4
TimeAttackMenu__Func_216D3E4: // 0x0216D3E4
	push {r3, lr}
	cmp r0, #0
	beq _0216D3F0
	cmp r0, #2
	beq _0216D3F8
	pop {r3, pc}
_0216D3F0:
	mov r0, #5
	bl TimeAttackMenu__Func_216C57C
	pop {r3, pc}
_0216D3F8:
	ldr r0, _0216D404 // =TimeAttackMenu__Main_216E248
	mov r1, #0
	bl TimeAttackMenu__Func_216D224
	pop {r3, pc}
	nop
_0216D404: .word TimeAttackMenu__Main_216E248
	thumb_func_end TimeAttackMenu__Func_216D3E4

	thumb_func_start TimeAttackMenu__Func_216D408
TimeAttackMenu__Func_216D408: // 0x0216D408
	push {r3, lr}
	cmp r0, #0
	beq _0216D418
	cmp r0, #2
	beq _0216D420
	cmp r0, #4
	beq _0216D428
	pop {r3, pc}
_0216D418:
	ldr r0, _0216D430 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	pop {r3, pc}
_0216D420:
	mov r0, #0
	bl PlaySysMenuNavSfx
	pop {r3, pc}
_0216D428:
	mov r0, #1
	bl TimeAttackMenu__Func_216C730
	pop {r3, pc}
	.align 2, 0
_0216D430: .word 0x0000FFFF
	thumb_func_end TimeAttackMenu__Func_216D408

	thumb_func_start TimeAttackMenu__Func_216D434
TimeAttackMenu__Func_216D434: // 0x0216D434
	push {r3, lr}
	cmp r0, #0
	beq _0216D444
	cmp r0, #2
	beq _0216D44C
	cmp r0, #4
	beq _0216D454
	pop {r3, pc}
_0216D444:
	ldr r0, _0216D468 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	pop {r3, pc}
_0216D44C:
	mov r0, #0
	bl PlaySysMenuNavSfx
	pop {r3, pc}
_0216D454:
	ldr r1, _0216D46C // =gameState
	mov r0, #1
	ldr r2, [r1, #0x10]
	lsl r0, r0, #0xc
	orr r0, r2
	str r0, [r1, #0x10]
	mov r0, #1
	bl TimeAttackMenu__Func_216C730
	pop {r3, pc}
	.align 2, 0
_0216D468: .word 0x0000FFFF
_0216D46C: .word gameState
	thumb_func_end TimeAttackMenu__Func_216D434

	thumb_func_start TimeAttackMenu__Func_216D470
TimeAttackMenu__Func_216D470: // 0x0216D470
	push {r3, lr}
	cmp r0, #0
	beq _0216D480
	cmp r0, #2
	beq _0216D488
	cmp r0, #4
	beq _0216D490
	pop {r3, pc}
_0216D480:
	ldr r0, _0216D49C // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	pop {r3, pc}
_0216D488:
	mov r0, #0
	bl PlaySysMenuNavSfx
	pop {r3, pc}
_0216D490:
	ldr r0, _0216D4A0 // =TimeAttackMenu__Singleton
	ldr r1, _0216D4A4 // =TimeAttackMenu__Main_InitCharacterSelect
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_0216D49C: .word 0x0000FFFF
_0216D4A0: .word TimeAttackMenu__Singleton
_0216D4A4: .word TimeAttackMenu__Main_InitCharacterSelect
	thumb_func_end TimeAttackMenu__Func_216D470

	thumb_func_start TimeAttackMenu__Func_216D4A8
TimeAttackMenu__Func_216D4A8: // 0x0216D4A8
	push {r3, lr}
	cmp r0, #0
	beq _0216D4B8
	cmp r0, #2
	beq _0216D4C0
	cmp r0, #4
	beq _0216D4C8
	pop {r3, pc}
_0216D4B8:
	ldr r0, _0216D4D4 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	pop {r3, pc}
_0216D4C0:
	mov r0, #0
	bl PlaySysMenuNavSfx
	pop {r3, pc}
_0216D4C8:
	ldr r0, _0216D4D8 // =TimeAttackMenu__Singleton
	ldr r1, _0216D4DC // =TimeAttackMenu__Main_216E180
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_0216D4D4: .word 0x0000FFFF
_0216D4D8: .word TimeAttackMenu__Singleton
_0216D4DC: .word TimeAttackMenu__Main_216E180
	thumb_func_end TimeAttackMenu__Func_216D4A8

	thumb_func_start TimeAttackMenu__Func_216D4E0
TimeAttackMenu__Func_216D4E0: // 0x0216D4E0
	push {r3, lr}
	cmp r0, #0
	beq _0216D4F0
	cmp r0, #2
	beq _0216D4F8
	cmp r0, #4
	beq _0216D500
	pop {r3, pc}
_0216D4F0:
	ldr r0, _0216D50C // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	pop {r3, pc}
_0216D4F8:
	mov r0, #0
	bl PlaySysMenuNavSfx
	pop {r3, pc}
_0216D500:
	ldr r0, _0216D510 // =TimeAttackMenu__Func_216D688
	mov r1, #0
	bl TimeAttackMenu__SetState
	pop {r3, pc}
	nop
_0216D50C: .word 0x0000FFFF
_0216D510: .word TimeAttackMenu__Func_216D688
	thumb_func_end TimeAttackMenu__Func_216D4E0

	thumb_func_start TimeAttackMenu__Func_216D514
TimeAttackMenu__Func_216D514: // 0x0216D514
	push {r3, lr}
	cmp r0, #0
	beq _0216D524
	cmp r0, #2
	beq _0216D52C
	cmp r0, #4
	beq _0216D534
	pop {r3, pc}
_0216D524:
	ldr r0, _0216D53C // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	pop {r3, pc}
_0216D52C:
	mov r0, #0
	bl PlaySysMenuNavSfx
	pop {r3, pc}
_0216D534:
	mov r0, #0
	bl TimeAttackMenu__Func_216C730
	pop {r3, pc}
	.align 2, 0
_0216D53C: .word 0x0000FFFF
	thumb_func_end TimeAttackMenu__Func_216D514

	thumb_func_start TimeAttackMenu__Func_216D540
TimeAttackMenu__Func_216D540: // 0x0216D540
	ldr r1, _0216D548 // =0x000007D4
	ldr r3, _0216D54C // =StageSelectMenu__Unknown__Func_2169D20
	ldr r1, [r0, r1]
	bx r3
	.align 2, 0
_0216D548: .word 0x000007D4
_0216D54C: .word StageSelectMenu__Unknown__Func_2169D20
	thumb_func_end TimeAttackMenu__Func_216D540

	thumb_func_start TimeAttackMenu__Func_216D550
TimeAttackMenu__Func_216D550: // 0x0216D550
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _0216D570 // =TimeAttackMenu__Singleton
	mov r4, r2
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x3f
	lsl r1, r1, #4
	cmp r5, #4
	bne _0216D56E
	ldr r0, [r0, r1]
	mov r1, r4
	bl SetTaskMainEvent
_0216D56E:
	pop {r3, r4, r5, pc}
	.align 2, 0
_0216D570: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Func_216D550

	thumb_func_start TimeAttackMenu__Func_216D574
TimeAttackMenu__Func_216D574: // 0x0216D574
	push {r3, lr}
	cmp r0, #0
	beq _0216D584
	cmp r0, #1
	beq _0216D584
	cmp r0, #2
	beq _0216D58C
	pop {r3, pc}
_0216D584:
	ldr r0, _0216D594 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	pop {r3, pc}
_0216D58C:
	mov r0, #6
	bl TimeAttackMenu__Func_216C57C
	pop {r3, pc}
	.align 2, 0
_0216D594: .word 0x0000FFFF
	thumb_func_end TimeAttackMenu__Func_216D574

	thumb_func_start TimeAttackMenu__Func_216D598
TimeAttackMenu__Func_216D598: // 0x0216D598
	bx lr
	.align 2, 0
	thumb_func_end TimeAttackMenu__Func_216D598

	thumb_func_start TimeAttackMenu__Func_216D59C
TimeAttackMenu__Func_216D59C: // 0x0216D59C
	ldr r3, _0216D5A0 // =SaveGame__BlazeUnlocked
	bx r3
	.align 2, 0
_0216D5A0: .word SaveGame__BlazeUnlocked
	thumb_func_end TimeAttackMenu__Func_216D59C

	thumb_func_start TimeAttackMenu__Func_216D5A4
TimeAttackMenu__Func_216D5A4: // 0x0216D5A4
	ldr r3, _0216D5AC // =TimeAttackMenu__Func_216C730
	mov r0, #0
	bx r3
	nop
_0216D5AC: .word TimeAttackMenu__Func_216C730
	thumb_func_end TimeAttackMenu__Func_216D5A4

	thumb_func_start TimeAttackMenu__Main
TimeAttackMenu__Main: // 0x0216D5B0
	push {r3, lr}
	ldr r0, _0216D5C8 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216D5CC // =0x000014F4
	mov r2, #4
	str r2, [r0, r1]
	ldr r0, _0216D5D0 // =TimeAttackMenu__Main_216D5D4
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_0216D5C8: .word TimeAttackMenu__Singleton
_0216D5CC: .word 0x000014F4
_0216D5D0: .word TimeAttackMenu__Main_216D5D4
	thumb_func_end TimeAttackMenu__Main

	thumb_func_start TimeAttackMenu__Main_216D5D4
TimeAttackMenu__Main_216D5D4: // 0x0216D5D4
	push {r3, lr}
	ldr r0, _0216D5F8 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216D5FC // =0x000014F4
	ldr r2, [r0, r1]
	sub r2, r2, #1
	str r2, [r0, r1]
	ldr r2, [r0, r1]
	cmp r2, #0
	bge _0216D5F4
	add r1, r1, #4
	ldr r0, [r0, r1]
	bl SetCurrentTaskMainEvent
_0216D5F4:
	pop {r3, pc}
	nop
_0216D5F8: .word TimeAttackMenu__Singleton
_0216D5FC: .word 0x000014F4
	thumb_func_end TimeAttackMenu__Main_216D5D4

	thumb_func_start TimeAttackMenu__Main_216D600
TimeAttackMenu__Main_216D600: // 0x0216D600
	push {r4, lr}
	ldr r0, _0216D650 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _0216D654 // =0x000014F4
	ldr r1, [r4, r0]
	sub r1, r1, #1
	str r1, [r4, r0]
	ldr r0, [r4, r0]
	cmp r0, #0
	bge _0216D64C
	ldr r0, _0216D658 // =0x0000FFFF
	bl TimeAttackMenu__Func_216D264
	ldr r0, _0216D65C // =TimeAttackMenu__Main_216D660
	bl SetCurrentTaskMainEvent
	mov r0, #0x15
	lsl r0, r0, #8
	ldr r2, [r4, r0]
	mov r0, #1
	tst r0, r2
	beq _0216D63C
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	pop {r4, pc}
_0216D63C:
	mov r1, #2
	mov r0, r2
	tst r0, r1
	beq _0216D64C
	mov r0, #5
	lsl r1, r1, #0xb
	bl CreateDrawFadeTask
_0216D64C:
	pop {r4, pc}
	nop
_0216D650: .word TimeAttackMenu__Singleton
_0216D654: .word 0x000014F4
_0216D658: .word 0x0000FFFF
_0216D65C: .word TimeAttackMenu__Main_216D660
	thumb_func_end TimeAttackMenu__Main_216D600

	thumb_func_start TimeAttackMenu__Main_216D660
TimeAttackMenu__Main_216D660: // 0x0216D660
	push {r4, lr}
	ldr r0, _0216D680 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl TimeAttackMenu__Func_216D280
	cmp r0, #0
	bne _0216D67C
	ldr r0, _0216D684 // =0x000014F8
	ldr r0, [r4, r0]
	bl SetCurrentTaskMainEvent
_0216D67C:
	pop {r4, pc}
	nop
_0216D680: .word TimeAttackMenu__Singleton
_0216D684: .word 0x000014F8
	thumb_func_end TimeAttackMenu__Main_216D660

	thumb_func_start TimeAttackMenu__Func_216D688
TimeAttackMenu__Func_216D688: // 0x0216D688
	push {r4, r5, r6, lr}
	sub sp, #0x20
	ldr r0, _0216D7B8 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0xfe
	lsl r0, r0, #2
	add r5, r4, r0
	mov r0, #0
	bl TimeAttackMenu__Func_216D264
	mov r0, r5
	bl StageSelectMenu__Unknown__Func_216A3C4
	mov r0, #0x8c
	mov r1, #0x30
	str r0, [sp]
	mov r0, r5
	mov r2, #0x38
	mov r3, r1
	bl StageSelectMenu__Unknown__Func_216A1B8
	ldr r1, _0216D7BC // =0x0000094C
	mov r0, #0x10
	ldr r2, [r5, r1]
	mov r3, #4
	bic r2, r0
	str r2, [r5, r1]
	mov r0, #6
	str r0, [sp]
	str r3, [sp, #4]
	sub r0, r3, #5
	str r0, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _0216D7C0 // =TimeAttackMenu__Func_216D378
	mov r2, #5
	str r0, [sp, #0x18]
	str r1, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	mov r0, r5
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r0, #0xc
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	sub r0, r0, #6
	str r0, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _0216D7C4 // =TimeAttackMenu__Func_216D39C
	mov r2, #0xb
	str r0, [sp, #0x18]
	str r1, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	mov r0, r5
	mov r3, #0xa
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r0, #9
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	sub r0, r0, #7
	str r0, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _0216D7C8 // =TimeAttackMenu__Func_216D3C0
	mov r2, #8
	str r0, [sp, #0x18]
	str r1, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	mov r0, r5
	mov r3, #7
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r0, #0xf
	str r0, [sp]
	mov r0, #7
	str r0, [sp, #4]
	sub r0, #8
	str r0, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _0216D7CC // =TimeAttackMenu__Func_216D3E4
	mov r2, #0xe
	str r0, [sp, #0x18]
	str r1, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	mov r0, r5
	mov r3, #0xd
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r6, r0
	mov r0, #3
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r4, #0x20]
	mov r0, r5
	mov r1, r6
	mov r3, #0
	bl StageSelectMenu__Unknown__Func_216A2D0
	mov r0, #0xa
	str r0, [sp]
	mov r0, #0xaa
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r2, [r4, #0x18]
	mov r0, r5
	mov r1, r6
	mov r3, #1
	bl StageSelectMenu__Unknown__Func_216A348
	bl GetCurrentTask
	mov r1, #0
	str r0, [sp]
	ldr r3, _0216D7D0 // =TimeAttackMenu__Func_216D2F4
	mov r0, r5
	mov r2, r1
	bl StageSelectMenu__Unknown__Func_2169B78
	ldr r0, _0216D7D4 // =TimeAttackMenu__Main_216D7D8
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r4, r5, r6, pc}
	nop
_0216D7B8: .word TimeAttackMenu__Singleton
_0216D7BC: .word 0x0000094C
_0216D7C0: .word TimeAttackMenu__Func_216D378
_0216D7C4: .word TimeAttackMenu__Func_216D39C
_0216D7C8: .word TimeAttackMenu__Func_216D3C0
_0216D7CC: .word TimeAttackMenu__Func_216D3E4
_0216D7D0: .word TimeAttackMenu__Func_216D2F4
_0216D7D4: .word TimeAttackMenu__Main_216D7D8
	thumb_func_end TimeAttackMenu__Func_216D688

	thumb_func_start TimeAttackMenu__Main_216D7D8
TimeAttackMenu__Main_216D7D8: // 0x0216D7D8
	ldr r0, _0216D7E0 // =TimeAttackMenu__Singleton
	ldr r3, _0216D7E4 // =GetTaskWork_
	ldr r0, [r0, #0]
	bx r3
	.align 2, 0
_0216D7E0: .word TimeAttackMenu__Singleton
_0216D7E4: .word GetTaskWork_
	thumb_func_end TimeAttackMenu__Main_216D7D8

	thumb_func_start TimeAttackMenu__Main_216D7E8
TimeAttackMenu__Main_216D7E8: // 0x0216D7E8
	push {r3, lr}
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _0216D806
	bl DestroyDrawFadeTask
	ldr r0, _0216D808 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl TimeAttackMenu__Destroy
	bl NextSysEvent
	bl DestroyCurrentTask
_0216D806:
	pop {r3, pc}
	.align 2, 0
_0216D808: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Main_216D7E8

	thumb_func_start TimeAttackMenu__Main_216D80C
TimeAttackMenu__Main_216D80C: // 0x0216D80C
	push {r3, lr}
	sub sp, #8
	bl MultibootManager__Func_2061638
	cmp r0, #0
	beq _0216D88A
	bl MultibootManager__CheckHasProfile
	cmp r0, #0
	bne _0216D850
	mov r0, #0x11
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #1
	str r2, [sp]
	mov r1, #0
	mov r3, #4
	str r1, [sp, #4]
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216D8C8 // =TimeAttackMenu__Main_216DAC4
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_0216D850:
	bl MultibootManager__CheckValidConsole
	cmp r0, #0
	bne _0216D8BC
	mov r0, #0x13
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #4
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216D8CC // =TimeAttackMenu__Main_216DB5C
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_0216D88A:
	mov r0, #0xf
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #4
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216D8D0 // =TimeAttackMenu__Main_216DBB4
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_0216D8BC:
	ldr r0, _0216D8D4 // =TimeAttackMenu__Main_216D8D8
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
	nop
_0216D8C8: .word TimeAttackMenu__Main_216DAC4
_0216D8CC: .word TimeAttackMenu__Main_216DB5C
_0216D8D0: .word TimeAttackMenu__Main_216DBB4
_0216D8D4: .word TimeAttackMenu__Main_216D8D8
	thumb_func_end TimeAttackMenu__Main_216D80C

	thumb_func_start TimeAttackMenu__Main_216D8D8
TimeAttackMenu__Main_216D8D8: // 0x0216D8D8
	push {r3, lr}
	sub sp, #8
	mov r0, #0x10
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #1
	str r2, [sp]
	mov r1, #0
	mov r3, #4
	str r1, [sp, #4]
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216D90C // =TimeAttackMenu__Main_216D910
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
	.align 2, 0
_0216D90C: .word TimeAttackMenu__Main_216D910
	thumb_func_end TimeAttackMenu__Main_216D8D8

	thumb_func_start TimeAttackMenu__Main_216D910
TimeAttackMenu__Main_216D910: // 0x0216D910
	push {r3, r4, lr}
	sub sp, #0xc
	ldr r0, _0216D994 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216D98E
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #0
	beq _0216D946
	cmp r0, #1
	beq _0216D982
	add sp, #0xc
	pop {r3, r4, pc}
_0216D946:
	mov r0, #1
	bl RenderCore_DisableSoftReset
	mov r0, #1
	bl RenderCore_SetNextFoldMode
	mov r1, #0
	str r1, [sp]
	mov r0, #0xf0
	str r0, [sp, #4]
	mov r0, #0xb0
	str r0, [sp, #8]
	mov r0, #1
	mov r2, #0xe
	mov r3, r1
	bl CreateConnectionStatusIcon
	bl MultibootManager__Func_2061654
	mov r0, #0x16
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216D998 // =0x0000150C
	mov r1, #0
	str r1, [r4, r0]
	ldr r0, _0216D99C // =TimeAttackMenu__Main_216D9A8
	bl SetCurrentTaskMainEvent
	add sp, #0xc
	pop {r3, r4, pc}
_0216D982:
	ldr r0, _0216D9A0 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216D9A4 // =TimeAttackMenu__Main_216DE20
	bl SetCurrentTaskMainEvent
_0216D98E:
	add sp, #0xc
	pop {r3, r4, pc}
	nop
_0216D994: .word TimeAttackMenu__Singleton
_0216D998: .word 0x0000150C
_0216D99C: .word TimeAttackMenu__Main_216D9A8
_0216D9A0: .word 0x0000FFFF
_0216D9A4: .word TimeAttackMenu__Main_216DE20
	thumb_func_end TimeAttackMenu__Main_216D910

	thumb_func_start TimeAttackMenu__Main_216D9A8
TimeAttackMenu__Main_216D9A8: // 0x0216D9A8
	push {r4, lr}
	sub sp, #8
	ldr r0, _0216DA54 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl MultibootManager__GetField8
	cmp r0, #0x11
	bgt _0216D9D8
	cmp r0, #0xf
	blt _0216D9D0
	beq _0216DA4E
	cmp r0, #0x10
	beq _0216DA4E
	cmp r0, #0x11
	beq _0216D9E0
	add sp, #8
	pop {r4, pc}
_0216D9D0:
	cmp r0, #0
	beq _0216DA3E
	add sp, #8
	pop {r4, pc}
_0216D9D8:
	cmp r0, #0x19
	beq _0216DA48
	add sp, #8
	pop {r4, pc}
_0216D9E0:
	bl MultibootManager__Func_2061918
	cmp r0, #0
	beq _0216DA0C
	ldr r0, _0216DA58 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216DA5C // =0x0000150C
	ldr r1, [r4, r0]
	cmp r1, #0
	beq _0216DA00
	ldr r0, _0216DA60 // =TimeAttackMenu__Main_216DD8C
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r4, pc}
_0216DA00:
	sub r0, #0x14
	ldr r0, [r4, r0]
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r4, pc}
_0216DA0C:
	mov r0, #0x17
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #4
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216DA64 // =TimeAttackMenu__Main_216DA70
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r4, pc}
_0216DA3E:
	ldr r0, _0216DA68 // =TimeAttackMenu__Main_216EE14
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r4, pc}
_0216DA48:
	ldr r0, _0216DA6C // =TimeAttackMenu__Main_FadeToCorruptSave
	bl SetCurrentTaskMainEvent
_0216DA4E:
	add sp, #8
	pop {r4, pc}
	nop
_0216DA54: .word TimeAttackMenu__Singleton
_0216DA58: .word 0x0000FFFF
_0216DA5C: .word 0x0000150C
_0216DA60: .word TimeAttackMenu__Main_216DD8C
_0216DA64: .word TimeAttackMenu__Main_216DA70
_0216DA68: .word TimeAttackMenu__Main_216EE14
_0216DA6C: .word TimeAttackMenu__Main_FadeToCorruptSave
	thumb_func_end TimeAttackMenu__Main_216D9A8

	thumb_func_start TimeAttackMenu__Main_216DA70
TimeAttackMenu__Main_216DA70: // 0x0216DA70
	push {r4, lr}
	ldr r0, _0216DAB4 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216DAB0
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _0216DAB0
	ldr r0, _0216DAB8 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216DABC // =0x000014FC
	ldr r1, [r4, r0]
	sub r0, r0, #4
	str r1, [r4, r0]
	ldr r0, _0216DAC0 // =TimeAttackMenu__Main_216DEB0
	bl SetCurrentTaskMainEvent
_0216DAB0:
	pop {r4, pc}
	nop
_0216DAB4: .word TimeAttackMenu__Singleton
_0216DAB8: .word 0x0000FFFF
_0216DABC: .word 0x000014FC
_0216DAC0: .word TimeAttackMenu__Main_216DEB0
	thumb_func_end TimeAttackMenu__Main_216DA70

	thumb_func_start TimeAttackMenu__Main_216DAC4
TimeAttackMenu__Main_216DAC4: // 0x0216DAC4
	push {r3, r4, lr}
	sub sp, #0xc
	ldr r0, _0216DB48 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216DB42
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #0
	beq _0216DAFA
	cmp r0, #1
	beq _0216DB36
	add sp, #0xc
	pop {r3, r4, pc}
_0216DAFA:
	mov r0, #1
	bl RenderCore_DisableSoftReset
	mov r0, #1
	bl RenderCore_SetNextFoldMode
	mov r1, #0
	str r1, [sp]
	mov r0, #0xf0
	str r0, [sp, #4]
	mov r0, #0xb0
	str r0, [sp, #8]
	mov r0, #1
	mov r2, #0xe
	mov r3, r1
	bl CreateConnectionStatusIcon
	bl MultibootManager__Func_2061654
	mov r0, #0x16
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216DB4C // =0x0000150C
	mov r1, #1
	str r1, [r4, r0]
	ldr r0, _0216DB50 // =TimeAttackMenu__Main_216D9A8
	bl SetCurrentTaskMainEvent
	add sp, #0xc
	pop {r3, r4, pc}
_0216DB36:
	ldr r0, _0216DB54 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216DB58 // =TimeAttackMenu__Main_216DE20
	bl SetCurrentTaskMainEvent
_0216DB42:
	add sp, #0xc
	pop {r3, r4, pc}
	nop
_0216DB48: .word TimeAttackMenu__Singleton
_0216DB4C: .word 0x0000150C
_0216DB50: .word TimeAttackMenu__Main_216D9A8
_0216DB54: .word 0x0000FFFF
_0216DB58: .word TimeAttackMenu__Main_216DE20
	thumb_func_end TimeAttackMenu__Main_216DAC4

	thumb_func_start TimeAttackMenu__Main_216DB5C
TimeAttackMenu__Main_216DB5C: // 0x0216DB5C
	push {r3, lr}
	sub sp, #8
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216DBAC
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _0216DBAC
	mov r0, #0x14
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #1
	str r2, [sp]
	mov r1, #0
	mov r3, #4
	str r1, [sp, #4]
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216DBB0 // =TimeAttackMenu__Main_216DBEC
	bl SetCurrentTaskMainEvent
_0216DBAC:
	add sp, #8
	pop {r3, pc}
	.align 2, 0
_0216DBB0: .word TimeAttackMenu__Main_216DBEC
	thumb_func_end TimeAttackMenu__Main_216DB5C

	thumb_func_start TimeAttackMenu__Main_216DBB4
TimeAttackMenu__Main_216DBB4: // 0x0216DBB4
	push {r3, lr}
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216DBE2
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _0216DBE2
	ldr r0, _0216DBE4 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216DBE8 // =TimeAttackMenu__Main_216D8D8
	bl SetCurrentTaskMainEvent
_0216DBE2:
	pop {r3, pc}
	.align 2, 0
_0216DBE4: .word 0x0000FFFF
_0216DBE8: .word TimeAttackMenu__Main_216D8D8
	thumb_func_end TimeAttackMenu__Main_216DBB4

	thumb_func_start TimeAttackMenu__Main_216DBEC
TimeAttackMenu__Main_216DBEC: // 0x0216DBEC
	push {r3, lr}
	sub sp, #8
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216DC56
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #0
	beq _0216DC18
	cmp r0, #1
	beq _0216DC4A
	add sp, #8
	pop {r3, pc}
_0216DC18:
	mov r0, #0x1b
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #4
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216DC5C // =TimeAttackMenu__Main_216DC68
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_0216DC4A:
	ldr r0, _0216DC60 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216DC64 // =TimeAttackMenu__Main_216DE20
	bl SetCurrentTaskMainEvent
_0216DC56:
	add sp, #8
	pop {r3, pc}
	nop
_0216DC5C: .word TimeAttackMenu__Main_216DC68
_0216DC60: .word 0x0000FFFF
_0216DC64: .word TimeAttackMenu__Main_216DE20
	thumb_func_end TimeAttackMenu__Main_216DBEC

	thumb_func_start TimeAttackMenu__Main_216DC68
TimeAttackMenu__Main_216DC68: // 0x0216DC68
	push {r3, lr}
	sub sp, #8
	ldr r0, _0216DCC4 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216DCC0
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _0216DCC0
	mov r0, #0x15
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #1
	str r2, [sp]
	mov r1, #0
	mov r3, #4
	str r1, [sp, #4]
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216DCC8 // =TimeAttackMenu__Main_216DCCC
	bl SetCurrentTaskMainEvent
_0216DCC0:
	add sp, #8
	pop {r3, pc}
	.align 2, 0
_0216DCC4: .word TimeAttackMenu__Singleton
_0216DCC8: .word TimeAttackMenu__Main_216DCCC
	thumb_func_end TimeAttackMenu__Main_216DC68

	thumb_func_start TimeAttackMenu__Main_216DCCC
TimeAttackMenu__Main_216DCCC: // 0x0216DCCC
	push {r3, r4, lr}
	sub sp, #0xc
	ldr r0, _0216DD78 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216DD72
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #0
	beq _0216DD02
	cmp r0, #1
	beq _0216DD44
	add sp, #0xc
	pop {r3, r4, pc}
_0216DD02:
	mov r0, #1
	bl RenderCore_DisableSoftReset
	mov r0, #1
	bl RenderCore_SetNextFoldMode
	mov r1, #0
	str r1, [sp]
	mov r0, #0xf0
	str r0, [sp, #4]
	mov r0, #0xb0
	str r0, [sp, #8]
	mov r0, #1
	mov r2, #0xe
	mov r3, r1
	bl CreateConnectionStatusIcon
	ldr r0, _0216DD7C // =saveGame
	bl SaveGame__DeleteOnlineProfile_KeepFriends
	bl MultibootManager__Func_2061654
	mov r0, #0x16
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216DD80 // =0x0000150C
	mov r1, #1
	str r1, [r4, r0]
	ldr r0, _0216DD84 // =TimeAttackMenu__Main_216D9A8
	bl SetCurrentTaskMainEvent
	add sp, #0xc
	pop {r3, r4, pc}
_0216DD44:
	mov r0, #0x13
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #4
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216DD88 // =TimeAttackMenu__Main_216DB5C
	bl SetCurrentTaskMainEvent
_0216DD72:
	add sp, #0xc
	pop {r3, r4, pc}
	nop
_0216DD78: .word TimeAttackMenu__Singleton
_0216DD7C: .word saveGame
_0216DD80: .word 0x0000150C
_0216DD84: .word TimeAttackMenu__Main_216D9A8
_0216DD88: .word TimeAttackMenu__Main_216DB5C
	thumb_func_end TimeAttackMenu__Main_216DCCC

	thumb_func_start TimeAttackMenu__Main_216DD8C
TimeAttackMenu__Main_216DD8C: // 0x0216DD8C
	push {r3, lr}
	sub sp, #8
	mov r0, #0x12
	bl TimeAttackMenu__Func_216C57C
	mov r0, #0xa
	bl TrySaveGameData
	cmp r0, #0
	beq _0216DDCC
	bl TimeAttackMenu__GetSpriteButton1
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #4
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216DDD8 // =TimeAttackMenu__Main_216DDE0
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_0216DDCC:
	ldr r0, _0216DDDC // =TimeAttackMenu__Main_216DE48
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
	nop
_0216DDD8: .word TimeAttackMenu__Main_216DDE0
_0216DDDC: .word TimeAttackMenu__Main_216DE48
	thumb_func_end TimeAttackMenu__Main_216DD8C

	thumb_func_start TimeAttackMenu__Main_216DDE0
TimeAttackMenu__Main_216DDE0: // 0x0216DDE0
	push {r4, lr}
	ldr r0, _0216DE18 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216DE14
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _0216DE14
	ldr r0, _0216DE1C // =0x000014F8
	ldr r0, [r4, r0]
	bl SetCurrentTaskMainEvent
_0216DE14:
	pop {r4, pc}
	nop
_0216DE18: .word TimeAttackMenu__Singleton
_0216DE1C: .word 0x000014F8
	thumb_func_end TimeAttackMenu__Main_216DDE0

	thumb_func_start TimeAttackMenu__Main_216DE20
TimeAttackMenu__Main_216DE20: // 0x0216DE20
	push {r4, lr}
	ldr r0, _0216DE40 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl TimeAttackMenu__Func_216C594
	cmp r0, #0
	bne _0216DE3C
	ldr r0, _0216DE44 // =0x000014FC
	ldr r0, [r4, r0]
	bl SetCurrentTaskMainEvent
_0216DE3C:
	pop {r4, pc}
	nop
_0216DE40: .word TimeAttackMenu__Singleton
_0216DE44: .word 0x000014FC
	thumb_func_end TimeAttackMenu__Main_216DE20

	thumb_func_start TimeAttackMenu__Main_216DE48
TimeAttackMenu__Main_216DE48: // 0x0216DE48
	push {r3, lr}
	bl MultibootManager__Func_206150C
	ldr r0, _0216DE58 // =TimeAttackMenu__Main_216DE5C
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_0216DE58: .word TimeAttackMenu__Main_216DE5C
	thumb_func_end TimeAttackMenu__Main_216DE48

	thumb_func_start TimeAttackMenu__Main_216DE5C
TimeAttackMenu__Main_216DE5C: // 0x0216DE5C
	push {r4, lr}
	ldr r0, _0216DEA8 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl MultibootManager__GetField8
	cmp r0, #0
	bgt _0216DE74
	beq _0216DE86
	pop {r4, pc}
_0216DE74:
	cmp r0, #0x19
	bgt _0216DEA6
	cmp r0, #0x15
	blt _0216DEA6
	beq _0216DEA6
	cmp r0, #0x16
	beq _0216DE86
	cmp r0, #0x19
	bne _0216DEA6
_0216DE86:
	add r4, #0x30
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2156790
	mov r0, #0
	bl RenderCore_DisableSoftReset
	mov r0, #0
	bl RenderCore_SetNextFoldMode
	bl DestroyConnectionStatusIcon
	ldr r0, _0216DEAC // =TimeAttackMenu__Main_FadeToCorruptSave
	bl SetCurrentTaskMainEvent
_0216DEA6:
	pop {r4, pc}
	.align 2, 0
_0216DEA8: .word TimeAttackMenu__Singleton
_0216DEAC: .word TimeAttackMenu__Main_FadeToCorruptSave
	thumb_func_end TimeAttackMenu__Main_216DE5C

	thumb_func_start TimeAttackMenu__Main_216DEB0
TimeAttackMenu__Main_216DEB0: // 0x0216DEB0
	push {r3, lr}
	mov r0, #0x19
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216DEC0 // =TimeAttackMenu__Main_216DEC4
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_0216DEC0: .word TimeAttackMenu__Main_216DEC4
	thumb_func_end TimeAttackMenu__Main_216DEB0

	thumb_func_start TimeAttackMenu__Main_216DEC4
TimeAttackMenu__Main_216DEC4: // 0x0216DEC4
	push {r3, lr}
	bl TimeAttackMenu__Func_216C5BC
	cmp r0, #0
	beq _0216DF02
	ldr r0, _0216DF04 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, #0x30
	mov r1, #1
	bl MainMenu__Func_2156790
	bl MultibootManager__GetField8
	cmp r0, #0
	beq _0216DEEA
	cmp r0, #0x19
	bne _0216DEF8
_0216DEEA:
	bl MultibootManager__Func_2060C9C
	bl MultibootManager__Func_2061C58
	bl MultibootManager__Create
	b _0216DEFC
_0216DEF8:
	bl MultibootManager__Func_206150C
_0216DEFC:
	ldr r0, _0216DF08 // =TimeAttackMenu__Main_216DF0C
	bl SetCurrentTaskMainEvent
_0216DF02:
	pop {r3, pc}
	.align 2, 0
_0216DF04: .word TimeAttackMenu__Singleton
_0216DF08: .word TimeAttackMenu__Main_216DF0C
	thumb_func_end TimeAttackMenu__Main_216DEC4

	thumb_func_start TimeAttackMenu__Main_216DF0C
TimeAttackMenu__Main_216DF0C: // 0x0216DF0C
	push {r4, lr}
	sub sp, #8
	ldr r0, _0216DFD0 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl MultibootManager__GetField8
	cmp r0, #0
	bgt _0216DF28
	beq _0216DF3E
	add sp, #8
	pop {r4, pc}
_0216DF28:
	cmp r0, #0x19
	bgt _0216DFCC
	cmp r0, #0x15
	blt _0216DFCC
	beq _0216DFCC
	cmp r0, #0x16
	beq _0216DF66
	cmp r0, #0x19
	beq _0216DF52
	add sp, #8
	pop {r4, pc}
_0216DF3E:
	add r4, #0x30
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2156790
	ldr r0, _0216DFD4 // =TimeAttackMenu__Main_216EE14
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r4, pc}
_0216DF52:
	add r4, #0x30
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2156790
	ldr r0, _0216DFD8 // =TimeAttackMenu__Main_FadeToCorruptSave
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r4, pc}
_0216DF66:
	ldr r0, _0216DFDC // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	add r4, #0x30
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2156790
	mov r0, #0
	bl RenderCore_DisableSoftReset
	mov r0, #0
	bl RenderCore_SetNextFoldMode
	bl DestroyConnectionStatusIcon
	bl SaveGame__RefreshFriendList
	mov r0, #0xb
	bl TrySaveGameData
	cmp r0, #0
	beq _0216DFC6
	mov r0, #0x1a
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #4
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216DFE0 // =TimeAttackMenu__Main_216DFE4
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r4, pc}
_0216DFC6:
	ldr r0, _0216DFD8 // =TimeAttackMenu__Main_FadeToCorruptSave
	bl SetCurrentTaskMainEvent
_0216DFCC:
	add sp, #8
	pop {r4, pc}
	.align 2, 0
_0216DFD0: .word TimeAttackMenu__Singleton
_0216DFD4: .word TimeAttackMenu__Main_216EE14
_0216DFD8: .word TimeAttackMenu__Main_FadeToCorruptSave
_0216DFDC: .word 0x0000FFFF
_0216DFE0: .word TimeAttackMenu__Main_216DFE4
	thumb_func_end TimeAttackMenu__Main_216DF0C

	thumb_func_start TimeAttackMenu__Main_216DFE4
TimeAttackMenu__Main_216DFE4: // 0x0216DFE4
	push {r3, lr}
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216E012
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _0216E012
	ldr r0, _0216E014 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216E018 // =TimeAttackMenu__Main_216E01C
	bl SetCurrentTaskMainEvent
_0216E012:
	pop {r3, pc}
	.align 2, 0
_0216E014: .word 0x0000FFFF
_0216E018: .word TimeAttackMenu__Main_216E01C
	thumb_func_end TimeAttackMenu__Main_216DFE4

	thumb_func_start TimeAttackMenu__Main_216E01C
TimeAttackMenu__Main_216E01C: // 0x0216E01C
	push {r3, lr}
	bl TimeAttackMenu__Func_216C594
	cmp r0, #0
	bne _0216E036
	ldr r0, _0216E038 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216E03C // =0x000014F8
	ldr r0, [r0, r1]
	bl SetCurrentTaskMainEvent
_0216E036:
	pop {r3, pc}
	.align 2, 0
_0216E038: .word TimeAttackMenu__Singleton
_0216E03C: .word 0x000014F8
	thumb_func_end TimeAttackMenu__Main_216E01C

	thumb_func_start TimeAttackMenu__Main_216E040
TimeAttackMenu__Main_216E040: // 0x0216E040
	push {r3, lr}
	ldr r0, _0216E070 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0xe5
	mov r2, #1
	lsl r1, r1, #4
	str r2, [r0, r1]
	bl TimeAttackMenu__Func_216D59C
	cmp r0, #0
	beq _0216E062
	ldr r0, _0216E074 // =TimeAttackMenu__Main_InitCharacterSelect
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_0216E062:
	ldr r0, _0216E078 // =gameState
	mov r1, #0
	str r1, [r0, #4]
	ldr r0, _0216E07C // =TimeAttackMenu__Main_216E180
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_0216E070: .word TimeAttackMenu__Singleton
_0216E074: .word TimeAttackMenu__Main_InitCharacterSelect
_0216E078: .word gameState
_0216E07C: .word TimeAttackMenu__Main_216E180
	thumb_func_end TimeAttackMenu__Main_216E040

	thumb_func_start TimeAttackMenu__Main_InitCharacterSelect
TimeAttackMenu__Main_InitCharacterSelect: // 0x0216E080
	push {r4, lr}
	ldr r0, _0216E0C8 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r2, _0216E0CC // =0x04001000
	mov r4, r0
	ldr r1, [r2, #0]
	ldr r0, _0216E0D0 // =0xFFFFE0FF
	and r1, r0
	lsr r0, r2, #0xf
	orr r0, r1
	str r0, [r2]
	bl GetSysEventList
	mov r1, #0xc
	ldrsh r0, [r0, r1]
	cmp r0, #7
	ldr r0, _0216E0D4 // =0x00000E24
	bne _0216E0B4
	ldr r0, [r4, r0]
	mov r1, #1
	mov r2, #0xfe
	bl CharacterSelectMenu__Create
	b _0216E0BE
_0216E0B4:
	ldr r0, [r4, r0]
	mov r1, #1
	mov r2, #0
	bl CharacterSelectMenu__Create
_0216E0BE:
	ldr r0, _0216E0D8 // =TimeAttackMenu__Main_216E0DC
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	nop
_0216E0C8: .word TimeAttackMenu__Singleton
_0216E0CC: .word 0x04001000
_0216E0D0: .word 0xFFFFE0FF
_0216E0D4: .word 0x00000E24
_0216E0D8: .word TimeAttackMenu__Main_216E0DC
	thumb_func_end TimeAttackMenu__Main_InitCharacterSelect

	thumb_func_start TimeAttackMenu__Main_216E0DC
TimeAttackMenu__Main_216E0DC: // 0x0216E0DC
	push {r4, lr}
	ldr r0, _0216E164 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl GetSysEventList
	mov r1, #0xc
	ldrsh r0, [r0, r1]
	cmp r0, #7
	ldr r0, _0216E168 // =0x00000E24
	bne _0216E130
	ldr r0, [r4, r0]
	bl CharacterSelectMenu__Func_215FC18
	cmp r0, #0
	beq _0216E160
	ldr r0, _0216E16C // =gameState
	ldr r0, [r0, #0x14]
	cmp r0, #3
	bne _0216E11E
	mov r0, #8
	bl RequestNewSysEventChange
	mov r0, #0
	mov r1, r0
	bl TimeAttackMenu__Func_216C610
	ldr r0, _0216E170 // =TimeAttackMenu__Main_216D7E8
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216E11E:
	cmp r0, #0
	bne _0216E160
	mov r0, #4
	bl SaveGame__SetProgressType
	mov r0, #1
	bl TimeAttackMenu__Func_216C730
	pop {r4, pc}
_0216E130:
	ldr r0, [r4, r0]
	bl CharacterSelectMenu__Func_215FC2C
	cmp r0, #1
	beq _0216E140
	cmp r0, #2
	beq _0216E148
	pop {r4, pc}
_0216E140:
	ldr r0, _0216E174 // =TimeAttackMenu__Main_216E180
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216E148:
	bl MultibootManager__GetField8
	cmp r0, #0xc
	bne _0216E158
	ldr r0, _0216E178 // =TimeAttackMenu__Main_216DEB0
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216E158:
	ldr r0, _0216E17C // =TimeAttackMenu__Func_216D688
	mov r1, #0
	bl TimeAttackMenu__SetState
_0216E160:
	pop {r4, pc}
	nop
_0216E164: .word TimeAttackMenu__Singleton
_0216E168: .word 0x00000E24
_0216E16C: .word gameState
_0216E170: .word TimeAttackMenu__Main_216D7E8
_0216E174: .word TimeAttackMenu__Main_216E180
_0216E178: .word TimeAttackMenu__Main_216DEB0
_0216E17C: .word TimeAttackMenu__Func_216D688
	thumb_func_end TimeAttackMenu__Main_216E0DC

	thumb_func_start TimeAttackMenu__Main_216E180
TimeAttackMenu__Main_216E180: // 0x0216E180
	push {r4, lr}
	ldr r0, _0216E1BC // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r2, _0216E1C0 // =0x04001000
	mov r4, r0
	ldr r1, [r2, #0]
	ldr r0, _0216E1C4 // =0xFFFFE0FF
	and r1, r0
	lsr r0, r2, #0xf
	orr r0, r1
	str r0, [r2]
	ldr r0, _0216E1C8 // =0x00000E28
	ldr r1, _0216E1CC // =TimeAttackMenu__Func_216D598
	ldr r0, [r4, r0]
	mov r2, #8
	bl StageSelectMenu__Func_215DA5C
	ldr r0, _0216E1C8 // =0x00000E28
	mov r1, #1
	ldr r0, [r4, r0]
	mov r2, #0xa6
	bl StageSelectMenu__Create
	ldr r0, _0216E1D0 // =TimeAttackMenu__Main_216E1D4
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	nop
_0216E1BC: .word TimeAttackMenu__Singleton
_0216E1C0: .word 0x04001000
_0216E1C4: .word 0xFFFFE0FF
_0216E1C8: .word 0x00000E28
_0216E1CC: .word TimeAttackMenu__Func_216D598
_0216E1D0: .word TimeAttackMenu__Main_216E1D4
	thumb_func_end TimeAttackMenu__Main_216E180

	thumb_func_start TimeAttackMenu__Main_216E1D4
TimeAttackMenu__Main_216E1D4: // 0x0216E1D4
	push {r4, lr}
	ldr r0, _0216E234 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _0216E238 // =0x00000E28
	ldr r0, [r4, r0]
	bl StageSelectMenu__Func_215DA54
	cmp r0, #1
	beq _0216E1F2
	cmp r0, #2
	beq _0216E200
	pop {r4, pc}
_0216E1F2:
	ldr r0, _0216E23C // =gameState
	mov r1, #2
	str r1, [r0, #0x14]
	mov r0, #1
	bl TimeAttackMenu__Func_216C730
	pop {r4, pc}
_0216E200:
	bl TimeAttackMenu__Func_216D59C
	cmp r0, #0
	beq _0216E210
	ldr r0, _0216E240 // =TimeAttackMenu__Main_InitCharacterSelect
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216E210:
	mov r0, #0xe5
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0216E220
	cmp r0, #1
	beq _0216E22A
	pop {r4, pc}
_0216E220:
	ldr r0, _0216E244 // =TimeAttackMenu__Func_216D688
	mov r1, #0
	bl TimeAttackMenu__SetState
	pop {r4, pc}
_0216E22A:
	ldr r0, _0216E244 // =TimeAttackMenu__Func_216D688
	mov r1, #0
	bl TimeAttackMenu__SetState
	pop {r4, pc}
	.align 2, 0
_0216E234: .word TimeAttackMenu__Singleton
_0216E238: .word 0x00000E28
_0216E23C: .word gameState
_0216E240: .word TimeAttackMenu__Main_InitCharacterSelect
_0216E244: .word TimeAttackMenu__Func_216D688
	thumb_func_end TimeAttackMenu__Main_216E1D4

	thumb_func_start TimeAttackMenu__Main_216E248
TimeAttackMenu__Main_216E248: // 0x0216E248
	push {r3, lr}
	sub sp, #8
	mov r0, #0x1c
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #1
	str r2, [sp]
	mov r1, #0
	mov r3, #4
	str r1, [sp, #4]
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216E27C // =TimeAttackMenu__Main_216E280
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
	.align 2, 0
_0216E27C: .word TimeAttackMenu__Main_216E280
	thumb_func_end TimeAttackMenu__Main_216E248

	thumb_func_start TimeAttackMenu__Main_216E280
TimeAttackMenu__Main_216E280: // 0x0216E280
	push {r3, lr}
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216E2C4
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #0
	beq _0216E2A8
	cmp r0, #1
	beq _0216E2B6
	pop {r3, pc}
_0216E2A8:
	ldr r0, _0216E2C8 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216E2CC // =TimeAttackMenu__Main_216E2D4
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_0216E2B6:
	ldr r0, _0216E2C8 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216E2D0 // =TimeAttackMenu__Func_216D688
	mov r1, #0
	bl TimeAttackMenu__SetState
_0216E2C4:
	pop {r3, pc}
	nop
_0216E2C8: .word 0x0000FFFF
_0216E2CC: .word TimeAttackMenu__Main_216E2D4
_0216E2D0: .word TimeAttackMenu__Func_216D688
	thumb_func_end TimeAttackMenu__Main_216E280

	thumb_func_start TimeAttackMenu__Main_216E2D4
TimeAttackMenu__Main_216E2D4: // 0x0216E2D4
	push {r3, lr}
	mov r0, #0
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216E2E4 // =TimeAttackMenu__Main_216E2E8
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_0216E2E4: .word TimeAttackMenu__Main_216E2E8
	thumb_func_end TimeAttackMenu__Main_216E2D4

	thumb_func_start TimeAttackMenu__Main_216E2E8
TimeAttackMenu__Main_216E2E8: // 0x0216E2E8
	push {r3, lr}
	bl TimeAttackMenu__Func_216C5BC
	cmp r0, #0
	beq _0216E30C
	ldr r0, _0216E310 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216E314 // =0x00001418
	mov r2, #0x18
	add r0, r0, r1
	mov r1, #9
	bl CreateSaveGameWorker
	ldr r0, _0216E318 // =TimeAttackMenu__Main_216E31C
	bl SetCurrentTaskMainEvent
_0216E30C:
	pop {r3, pc}
	nop
_0216E310: .word TimeAttackMenu__Singleton
_0216E314: .word 0x00001418
_0216E318: .word TimeAttackMenu__Main_216E31C
	thumb_func_end TimeAttackMenu__Main_216E2E8

	thumb_func_start TimeAttackMenu__Main_216E31C
TimeAttackMenu__Main_216E31C: // 0x0216E31C
	push {r4, lr}
	ldr r0, _0216E358 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _0216E35C // =0x00001418
	add r0, r4, r0
	bl AwaitSaveGameCompletion
	cmp r0, #0
	beq _0216E354
	ldr r0, _0216E35C // =0x00001418
	add r0, r4, r0
	bl GetSaveGameSuccess
	cmp r0, #0
	beq _0216E34E
	ldr r0, _0216E360 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216E364 // =TimeAttackMenu__Main_216E36C
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216E34E:
	ldr r0, _0216E368 // =TimeAttackMenu__Main_FadeToCorruptSave
	bl SetCurrentTaskMainEvent
_0216E354:
	pop {r4, pc}
	nop
_0216E358: .word TimeAttackMenu__Singleton
_0216E35C: .word 0x00001418
_0216E360: .word 0x0000FFFF
_0216E364: .word TimeAttackMenu__Main_216E36C
_0216E368: .word TimeAttackMenu__Main_FadeToCorruptSave
	thumb_func_end TimeAttackMenu__Main_216E31C

	thumb_func_start TimeAttackMenu__Main_216E36C
TimeAttackMenu__Main_216E36C: // 0x0216E36C
	push {r3, lr}
	sub sp, #8
	ldr r0, _0216E3D4 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	bl MultibootManager__Func_2061638
	cmp r0, #0
	beq _0216E3A0
	ldr r0, _0216E3D8 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	mov r0, #0xc
	bl FadeSysTrack
	ldr r0, _0216E3DC // =TimeAttackMenu__Main_216E42C
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
_0216E3A0:
	mov r0, #0xf
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #4
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216E3E0 // =TimeAttackMenu__Main_216E3E4
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
	nop
_0216E3D4: .word TimeAttackMenu__Singleton
_0216E3D8: .word 0x0000FFFF
_0216E3DC: .word TimeAttackMenu__Main_216E42C
_0216E3E0: .word TimeAttackMenu__Main_216E3E4
	thumb_func_end TimeAttackMenu__Main_216E36C

	thumb_func_start TimeAttackMenu__Main_216E3E4
TimeAttackMenu__Main_216E3E4: // 0x0216E3E4
	push {r3, lr}
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216E422
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _0216E422
	ldr r0, _0216E424 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	mov r0, #0xc
	bl FadeSysTrack
	ldr r0, _0216E428 // =TimeAttackMenu__Main_216E42C
	bl SetCurrentTaskMainEvent
_0216E422:
	pop {r3, pc}
	.align 2, 0
_0216E424: .word 0x0000FFFF
_0216E428: .word TimeAttackMenu__Main_216E42C
	thumb_func_end TimeAttackMenu__Main_216E3E4

	thumb_func_start TimeAttackMenu__Main_216E42C
TimeAttackMenu__Main_216E42C: // 0x0216E42C
	push {r3, lr}
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _0216E44C
	ldr r0, _0216E450 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl TimeAttackMenu__Destroy
	mov r0, #0x21
	bl RequestNewSysEventChange
	bl NextSysEvent
	bl DestroyCurrentTask
_0216E44C:
	pop {r3, pc}
	nop
_0216E450: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Main_216E42C

	thumb_func_start TimeAttackMenu__Main_216E454
TimeAttackMenu__Main_216E454: // 0x0216E454
	push {r4, lr}
	ldr r0, _0216E488 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r1, _0216E48C // =0x00000E1E
	mov r0, #1
	ldrh r2, [r4, r1]
	orr r0, r2
	strh r0, [r4, r1]
	add r1, #0xe
	add r0, r4, r1
	ldr r1, _0216E490 // =0x00001514
	ldr r1, [r4, r1]
	bl TimeAttackLeaderboardsMenu__Func_2175648
	ldr r0, _0216E494 // =0x00000E2C
	mov r1, #0
	add r0, r4, r0
	bl TimeAttackLeaderboardsMenu__Create
	ldr r0, _0216E498 // =TimeAttackMenu__Main_216E49C
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_0216E488: .word TimeAttackMenu__Singleton
_0216E48C: .word 0x00000E1E
_0216E490: .word 0x00001514
_0216E494: .word 0x00000E2C
_0216E498: .word TimeAttackMenu__Main_216E49C
	thumb_func_end TimeAttackMenu__Main_216E454

	thumb_func_start TimeAttackMenu__Main_216E49C
TimeAttackMenu__Main_216E49C: // 0x0216E49C
	push {r3, r4, r5, lr}
	ldr r0, _0216E4F0 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x3f
	lsl r0, r0, #4
	add r5, r4, r0
	ldr r0, _0216E4F4 // =0x00000E2C
	add r0, r4, r0
	bl TimeAttackLeaderboardsMenu__IsActive
	cmp r0, #0
	beq _0216E4EE
	ldr r1, _0216E4F8 // =0x00000A2E
	mov r0, #1
	ldrh r2, [r5, r1]
	bic r2, r0
	ldr r0, _0216E4F4 // =0x00000E2C
	strh r2, [r5, r1]
	add r0, r4, r0
	bl TimeAttackLeaderboardsMenu__Func_2175730
	ldr r1, _0216E4FC // =0x0000FFFF
	cmp r0, r1
	bne _0216E4DC
	ldr r0, _0216E500 // =TimeAttackMenu__Func_216D688
	mov r1, #0
	bl TimeAttackMenu__SetState
	pop {r3, r4, r5, pc}
_0216E4DC:
	ldr r0, _0216E4F4 // =0x00000E2C
	add r0, r4, r0
	bl TimeAttackLeaderboardsMenu__Func_2175730
	ldr r1, _0216E504 // =0x00001514
	str r0, [r4, r1]
	ldr r0, _0216E508 // =TimeAttackMenu__Main_216EB64
	bl SetCurrentTaskMainEvent
_0216E4EE:
	pop {r3, r4, r5, pc}
	.align 2, 0
_0216E4F0: .word TimeAttackMenu__Singleton
_0216E4F4: .word 0x00000E2C
_0216E4F8: .word 0x00000A2E
_0216E4FC: .word 0x0000FFFF
_0216E500: .word TimeAttackMenu__Func_216D688
_0216E504: .word 0x00001514
_0216E508: .word TimeAttackMenu__Main_216EB64
	thumb_func_end TimeAttackMenu__Main_216E49C

	thumb_func_start TimeAttackMenu__Main_216E50C
TimeAttackMenu__Main_216E50C: // 0x0216E50C
	push {r4, lr}
	ldr r0, _0216E540 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r1, _0216E544 // =0x00000E1E
	mov r0, #1
	ldrh r2, [r4, r1]
	orr r0, r2
	strh r0, [r4, r1]
	add r1, #0xe
	add r0, r4, r1
	ldr r1, _0216E548 // =0x00001514
	ldr r1, [r4, r1]
	bl TimeAttackLeaderboardsMenu__Func_2175648
	ldr r0, _0216E54C // =0x00000E2C
	mov r1, #1
	add r0, r4, r0
	bl TimeAttackLeaderboardsMenu__Create
	ldr r0, _0216E550 // =TimeAttackMenu__Main_216E554
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_0216E540: .word TimeAttackMenu__Singleton
_0216E544: .word 0x00000E1E
_0216E548: .word 0x00001514
_0216E54C: .word 0x00000E2C
_0216E550: .word TimeAttackMenu__Main_216E554
	thumb_func_end TimeAttackMenu__Main_216E50C

	thumb_func_start TimeAttackMenu__Main_216E554
TimeAttackMenu__Main_216E554: // 0x0216E554
	push {r3, r4, r5, lr}
	ldr r0, _0216E59C // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x3f
	lsl r0, r0, #4
	add r5, r4, r0
	ldr r0, _0216E5A0 // =0x00000E2C
	add r0, r4, r0
	bl TimeAttackLeaderboardsMenu__IsActive
	cmp r0, #0
	beq _0216E598
	ldr r1, _0216E5A4 // =0x00000A2E
	mov r0, #1
	ldrh r2, [r5, r1]
	bic r2, r0
	ldr r0, _0216E5A8 // =0x00001504
	strh r2, [r5, r1]
	ldr r1, [r4, r0]
	cmp r1, #0
	beq _0216E58C
	mov r1, #0
	str r1, [r4, r0]
	ldr r1, _0216E5AC // =TimeAttackMenu__Main_216E660
	b _0216E58E
_0216E58C:
	ldr r1, _0216E5B0 // =TimeAttackMenu__Main_216E454
_0216E58E:
	sub r0, #0xc
	str r1, [r4, r0]
	ldr r0, _0216E5B4 // =TimeAttackMenu__Main_216DEB0
	bl SetCurrentTaskMainEvent
_0216E598:
	pop {r3, r4, r5, pc}
	nop
_0216E59C: .word TimeAttackMenu__Singleton
_0216E5A0: .word 0x00000E2C
_0216E5A4: .word 0x00000A2E
_0216E5A8: .word 0x00001504
_0216E5AC: .word TimeAttackMenu__Main_216E660
_0216E5B0: .word TimeAttackMenu__Main_216E454
_0216E5B4: .word TimeAttackMenu__Main_216DEB0
	thumb_func_end TimeAttackMenu__Main_216E554

	thumb_func_start TimeAttackMenu__Main_216E5B8
TimeAttackMenu__Main_216E5B8: // 0x0216E5B8
	push {r3, lr}
	ldr r0, _0216E5E0 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r2, _0216E5E4 // =0x00000E1E
	mov r1, #1
	ldrh r3, [r0, r2]
	orr r1, r3
	strh r1, [r0, r2]
	add r2, #0x22
	add r0, r0, r2
	mov r1, #0
	bl TimeAttackRecordsMenu__Create
	ldr r0, _0216E5E8 // =TimeAttackMenu__Main_216E5EC
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_0216E5E0: .word TimeAttackMenu__Singleton
_0216E5E4: .word 0x00000E1E
_0216E5E8: .word TimeAttackMenu__Main_216E5EC
	thumb_func_end TimeAttackMenu__Main_216E5B8

	thumb_func_start TimeAttackMenu__Main_216E5EC
TimeAttackMenu__Main_216E5EC: // 0x0216E5EC
	push {r3, r4, r5, lr}
	ldr r0, _0216E648 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x3f
	lsl r0, r0, #4
	add r5, r4, r0
	mov r0, #0x39
	lsl r0, r0, #6
	add r0, r4, r0
	bl TimeAttackRecordsMenu__Func_2178A2C
	cmp r0, #0
	beq _0216E644
	ldr r1, _0216E64C // =0x00000A2E
	mov r0, #1
	ldrh r2, [r5, r1]
	bic r2, r0
	mov r0, #0x39
	lsl r0, r0, #6
	add r0, r4, r0
	strh r2, [r5, r1]
	bl TimeAttackRecordsMenu__Func_2178A3C
	ldr r1, _0216E650 // =0x0000FFFF
	cmp r0, r1
	bne _0216E630
	ldr r0, _0216E654 // =TimeAttackMenu__Func_216D688
	mov r1, #0
	bl TimeAttackMenu__SetState
	pop {r3, r4, r5, pc}
_0216E630:
	mov r0, #0x39
	lsl r0, r0, #6
	add r0, r4, r0
	bl TimeAttackRecordsMenu__Func_2178A3C
	ldr r1, _0216E658 // =0x00001514
	str r0, [r4, r1]
	ldr r0, _0216E65C // =TimeAttackMenu__Main_216E8A4
	bl SetCurrentTaskMainEvent
_0216E644:
	pop {r3, r4, r5, pc}
	nop
_0216E648: .word TimeAttackMenu__Singleton
_0216E64C: .word 0x00000A2E
_0216E650: .word 0x0000FFFF
_0216E654: .word TimeAttackMenu__Func_216D688
_0216E658: .word 0x00001514
_0216E65C: .word TimeAttackMenu__Main_216E8A4
	thumb_func_end TimeAttackMenu__Main_216E5EC

	thumb_func_start TimeAttackMenu__Main_216E660
TimeAttackMenu__Main_216E660: // 0x0216E660
	push {r3, r4, r5, lr}
	sub sp, #0x20
	ldr r0, _0216E81C // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0xfe
	lsl r0, r0, #2
	add r5, r4, r0
	ldr r0, _0216E820 // =gameState
	ldr r0, [r0, #0x14]
	cmp r0, #3
	beq _0216E69E
	mov r0, #5
	bl TrySaveGameData
	cmp r0, #0
	bne _0216E694
	bl DestroyDrawFadeTask
	ldr r0, _0216E824 // =TimeAttackMenu__Main_FadeToCorruptSave
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r3, r4, r5, pc}
_0216E694:
	ldr r1, _0216E820 // =gameState
	ldr r0, _0216E828 // =0xFFFFEFFF
	ldr r2, [r1, #0x10]
	and r0, r2
	str r0, [r1, #0x10]
_0216E69E:
	mov r0, r5
	bl StageSelectMenu__Unknown__Func_216A3C4
	ldr r0, _0216E820 // =gameState
	mov r2, #0x20
	ldr r0, [r0, #0x14]
	mov r1, #0x90
	cmp r0, #3
	bne _0216E6B4
	mov r2, #0x40
	mov r1, #0x70
_0216E6B4:
	str r1, [sp]
	mov r1, #0x30
	mov r0, r5
	mov r3, r1
	bl StageSelectMenu__Unknown__Func_216A1B8
	mov r0, #0x21
	str r0, [sp]
	mov r0, #4
	str r0, [sp, #4]
	sub r0, r0, #5
	str r0, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _0216E82C // =TimeAttackMenu__Func_216D408
	mov r2, #0x20
	str r0, [sp, #0x18]
	str r1, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	mov r0, r5
	mov r3, #0x1f
	bl StageSelectMenu__Unknown__Func_216A1DC
	ldr r0, _0216E820 // =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	beq _0216E788
	ldr r0, [r0, #0x60]
	cmp r0, #0
	beq _0216E72E
	ldr r1, _0216E830 // =gameState+0x00000040
	mov r0, #0x1a
	ldrsh r1, [r1, r0]
	sub r0, #0x1b
	cmp r1, r0
	beq _0216E72E
	mov r0, #0x1e
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	sub r0, r0, #6
	str r0, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _0216E834 // =TimeAttackMenu__Func_216D434
	mov r2, #0x1d
	str r0, [sp, #0x18]
	str r1, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	mov r0, r5
	mov r3, #0x1c
	bl StageSelectMenu__Unknown__Func_216A1DC
_0216E72E:
	bl TimeAttackMenu__Func_216D59C
	cmp r0, #0
	beq _0216E75E
	mov r0, #0x18
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	sub r0, r0, #7
	str r0, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r2, #0x17
	ldr r0, _0216E838 // =TimeAttackMenu__Func_216D470
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	str r1, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	mov r0, r5
	mov r3, #0x16
	bl StageSelectMenu__Unknown__Func_216A1DC
_0216E75E:
	mov r0, #0x1b
	str r0, [sp]
	mov r0, #7
	str r0, [sp, #4]
	sub r0, #8
	str r0, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	mov r0, #0xa1
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	ldr r0, _0216E83C // =TimeAttackMenu__Func_216D4A8
	mov r2, #0x1a
	str r0, [sp, #0x18]
	str r1, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	mov r0, r5
	mov r3, #0x19
	bl StageSelectMenu__Unknown__Func_216A1DC
_0216E788:
	ldr r1, _0216E820 // =gameState
	ldr r0, _0216E840 // =TimeAttackMenu__Func_216D4E0
	ldr r1, [r1, #0x14]
	cmp r1, #3
	bne _0216E794
	ldr r0, _0216E844 // =TimeAttackMenu__Func_216D514
_0216E794:
	mov r1, #0x24
	str r1, [sp]
	mov r1, #8
	str r1, [sp, #4]
	sub r1, #9
	str r1, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	mov r1, #0xa1
	str r1, [sp, #0x10]
	mov r1, #0x17
	str r1, [sp, #0x14]
	str r0, [sp, #0x18]
	str r2, [sp, #0x1c]
	ldr r1, [r4, #0x14]
	mov r0, r5
	mov r2, #0x23
	mov r3, #0x22
	bl StageSelectMenu__Unknown__Func_216A1DC
	mov r0, #0x91
	lsl r0, r0, #4
	add r4, r5, r0
	ldr r1, [r4, #0x3c]
	mov r0, #0x40
	orr r0, r1
	mov r1, #0
	str r0, [r4, #0x3c]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r4, #0x3c]
	mov r0, #0x10
	orr r0, r1
	str r0, [r4, #0x3c]
	add r4, #0x50
	ldrh r0, [r4, #0]
	add r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl ObjDraw__GetHWPaletteRow
	ldr r1, _0216E820 // =gameState
	ldr r1, [r1, #0x14]
	cmp r1, #3
	bne _0216E7F8
	mov r1, #0x35
	lsl r1, r1, #8
	b _0216E7FC
_0216E7F8:
	mov r1, #0x66
	lsl r1, r1, #6
_0216E7FC:
	strh r1, [r0, #0x14]
	mov r0, #0x83
	mov r1, #0
	lsl r0, r0, #4
	str r1, [r5, r0]
	ldr r3, _0216E848 // =TimeAttackMenu__Func_216D358
	mov r0, r5
	mov r2, r1
	str r1, [sp]
	bl StageSelectMenu__Unknown__Func_2169B78
	ldr r0, _0216E84C // =TimeAttackMenu__Main_216D7D8
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r3, r4, r5, pc}
	.align 2, 0
_0216E81C: .word TimeAttackMenu__Singleton
_0216E820: .word gameState
_0216E824: .word TimeAttackMenu__Main_FadeToCorruptSave
_0216E828: .word 0xFFFFEFFF
_0216E82C: .word TimeAttackMenu__Func_216D408
_0216E830: .word gameState+0x00000040
_0216E834: .word TimeAttackMenu__Func_216D434
_0216E838: .word TimeAttackMenu__Func_216D470
_0216E83C: .word TimeAttackMenu__Func_216D4A8
_0216E840: .word TimeAttackMenu__Func_216D4E0
_0216E844: .word TimeAttackMenu__Func_216D514
_0216E848: .word TimeAttackMenu__Func_216D358
_0216E84C: .word TimeAttackMenu__Main_216D7D8
	thumb_func_end TimeAttackMenu__Main_216E660

	thumb_func_start TimeAttackMenu__Main_216E850
TimeAttackMenu__Main_216E850: // 0x0216E850
	push {r4, lr}
	ldr r0, _0216E88C // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #5
	bl TrySaveGameData
	cmp r0, #0
	bne _0216E872
	bl DestroyDrawFadeTask
	ldr r0, _0216E890 // =TimeAttackMenu__Main_FadeToCorruptSave
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216E872:
	ldr r0, _0216E894 // =0x00001504
	mov r1, #1
	str r1, [r4, r0]
	ldr r0, _0216E898 // =gameState
	ldrh r0, [r0, #0x28]
	bl MenuHelpers__GetLeaderboardIDFromStageID
	ldr r1, _0216E89C // =0x00001514
	str r0, [r4, r1]
	ldr r0, _0216E8A0 // =TimeAttackMenu__Main_216E8A4
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_0216E88C: .word TimeAttackMenu__Singleton
_0216E890: .word TimeAttackMenu__Main_FadeToCorruptSave
_0216E894: .word 0x00001504
_0216E898: .word gameState
_0216E89C: .word 0x00001514
_0216E8A0: .word TimeAttackMenu__Main_216E8A4
	thumb_func_end TimeAttackMenu__Main_216E850

	thumb_func_start TimeAttackMenu__Main_216E8A4
TimeAttackMenu__Main_216E8A4: // 0x0216E8A4
	push {r3, lr}
	sub sp, #8
	ldr r0, _0216E8E0 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r0, #0xb
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #1
	str r2, [sp]
	mov r1, #0
	mov r3, #4
	str r1, [sp, #4]
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216E8E4 // =TimeAttackMenu__Main_216E8E8
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
	.align 2, 0
_0216E8E0: .word TimeAttackMenu__Singleton
_0216E8E4: .word TimeAttackMenu__Main_216E8E8
	thumb_func_end TimeAttackMenu__Main_216E8A4

	thumb_func_start TimeAttackMenu__Main_216E8E8
TimeAttackMenu__Main_216E8E8: // 0x0216E8E8
	push {r4, lr}
	ldr r0, _0216E94C // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216E948
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #0
	beq _0216E91A
	cmp r0, #1
	beq _0216E922
	pop {r4, pc}
_0216E91A:
	ldr r0, _0216E950 // =0x00001508
	mov r1, #1
	str r1, [r4, r0]
	b _0216E928
_0216E922:
	ldr r0, _0216E950 // =0x00001508
	mov r1, #0
	str r1, [r4, r0]
_0216E928:
	ldr r1, _0216E954 // =TimeAttackMenu__Main_216E968
	ldr r0, _0216E958 // =0x000014F8
	str r1, [r4, r0]
	mov r1, r0
	add r1, #0xc
	ldr r1, [r4, r1]
	cmp r1, #0
	beq _0216E93C
	ldr r1, _0216E95C // =TimeAttackMenu__Main_216E660
	b _0216E93E
_0216E93C:
	ldr r1, _0216E960 // =TimeAttackMenu__Main_216E5B8
_0216E93E:
	add r0, r0, #4
	str r1, [r4, r0]
	ldr r0, _0216E964 // =TimeAttackMenu__Main_216D80C
	bl SetCurrentTaskMainEvent
_0216E948:
	pop {r4, pc}
	nop
_0216E94C: .word TimeAttackMenu__Singleton
_0216E950: .word 0x00001508
_0216E954: .word TimeAttackMenu__Main_216E968
_0216E958: .word 0x000014F8
_0216E95C: .word TimeAttackMenu__Main_216E660
_0216E960: .word TimeAttackMenu__Main_216E5B8
_0216E964: .word TimeAttackMenu__Main_216D80C
	thumb_func_end TimeAttackMenu__Main_216E8E8

	thumb_func_start TimeAttackMenu__Main_216E968
TimeAttackMenu__Main_216E968: // 0x0216E968
	push {r4, lr}
	ldr r0, _0216E998 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	add r0, #0x30
	mov r1, #1
	bl MainMenu__Func_2156790
	mov r0, #0xc
	bl TimeAttackMenu__Func_216C57C
	ldr r2, _0216E99C // =0x00001514
	mov r1, #1
	ldr r0, [r4, r2]
	sub r2, #0xc
	ldr r2, [r4, r2]
	bl CreateLeaderboardWorker
	ldr r0, _0216E9A0 // =TimeAttackMenu__Main_216E9A4
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_0216E998: .word TimeAttackMenu__Singleton
_0216E99C: .word 0x00001514
_0216E9A0: .word TimeAttackMenu__Main_216E9A4
	thumb_func_end TimeAttackMenu__Main_216E968

	thumb_func_start TimeAttackMenu__Main_216E9A4
TimeAttackMenu__Main_216E9A4: // 0x0216E9A4
	push {r4, lr}
	ldr r0, _0216EA4C // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl MultibootManager__GetField8
	cmp r0, #0
	beq _0216E9BE
	cmp r0, #0x19
	beq _0216E9D4
	b _0216E9EA
_0216E9BE:
	add r4, #0x30
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2156790
	bl DestroyLeaderboardWorker
	ldr r0, _0216EA50 // =TimeAttackMenu__Main_216EE14
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216E9D4:
	add r4, #0x30
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2156790
	bl DestroyLeaderboardWorker
	ldr r0, _0216EA54 // =TimeAttackMenu__Main_FadeToCorruptSave
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216E9EA:
	bl GetLeaderboardWorkerStatus
	cmp r0, #3
	bhi _0216EA4A
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0216E9FE: // jump table
	.hword _0216EA24 - _0216E9FE - 2 // case 0
	.hword _0216EA08 - _0216E9FE - 2 // case 1
	.hword _0216EA06 - _0216E9FE - 2 // case 2
	.hword _0216EA3A - _0216E9FE - 2 // case 3
_0216EA06:
	pop {r4, pc}
_0216EA08:
	ldr r0, _0216EA58 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	add r4, #0x30
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2156790
	bl DestroyLeaderboardWorker
	ldr r0, _0216EA5C // =TimeAttackMenu__Main_216EDA0
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216EA24:
	add r4, #0x30
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2156790
	bl DestroyLeaderboardWorker
	ldr r0, _0216EA50 // =TimeAttackMenu__Main_216EE14
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216EA3A:
	bl DestroyLeaderboardWorker
	ldr r0, _0216EA58 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216EA60 // =TimeAttackMenu__Main_216EA64
	bl SetCurrentTaskMainEvent
_0216EA4A:
	pop {r4, pc}
	.align 2, 0
_0216EA4C: .word TimeAttackMenu__Singleton
_0216EA50: .word TimeAttackMenu__Main_216EE14
_0216EA54: .word TimeAttackMenu__Main_FadeToCorruptSave
_0216EA58: .word 0x0000FFFF
_0216EA5C: .word TimeAttackMenu__Main_216EDA0
_0216EA60: .word TimeAttackMenu__Main_216EA64
	thumb_func_end TimeAttackMenu__Main_216E9A4

	thumb_func_start TimeAttackMenu__Main_216EA64
TimeAttackMenu__Main_216EA64: // 0x0216EA64
	push {r3, lr}
	mov r0, #1
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216EA74 // =TimeAttackMenu__Main_216EA78
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_0216EA74: .word TimeAttackMenu__Main_216EA78
	thumb_func_end TimeAttackMenu__Main_216EA64

	thumb_func_start TimeAttackMenu__Main_216EA78
TimeAttackMenu__Main_216EA78: // 0x0216EA78
	push {r3, lr}
	bl TimeAttackMenu__Func_216C5BC
	cmp r0, #0
	beq _0216EA9C
	ldr r0, _0216EAA0 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216EAA4 // =0x00001418
	mov r2, #0x18
	add r0, r0, r1
	mov r1, #4
	bl CreateSaveGameWorker
	ldr r0, _0216EAA8 // =TimeAttackMenu__Main_216EAAC
	bl SetCurrentTaskMainEvent
_0216EA9C:
	pop {r3, pc}
	nop
_0216EAA0: .word TimeAttackMenu__Singleton
_0216EAA4: .word 0x00001418
_0216EAA8: .word TimeAttackMenu__Main_216EAAC
	thumb_func_end TimeAttackMenu__Main_216EA78

	thumb_func_start TimeAttackMenu__Main_216EAAC
TimeAttackMenu__Main_216EAAC: // 0x0216EAAC
	push {r4, lr}
	ldr r0, _0216EAE8 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _0216EAEC // =0x00001418
	add r0, r4, r0
	bl AwaitSaveGameCompletion
	cmp r0, #0
	beq _0216EAE4
	ldr r0, _0216EAEC // =0x00001418
	add r0, r4, r0
	bl GetSaveGameSuccess
	cmp r0, #0
	beq _0216EADE
	ldr r0, _0216EAF0 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216EAF4 // =TimeAttackMenu__Main_216EAFC
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216EADE:
	ldr r0, _0216EAF8 // =TimeAttackMenu__Main_216EB14
	bl SetCurrentTaskMainEvent
_0216EAE4:
	pop {r4, pc}
	nop
_0216EAE8: .word TimeAttackMenu__Singleton
_0216EAEC: .word 0x00001418
_0216EAF0: .word 0x0000FFFF
_0216EAF4: .word TimeAttackMenu__Main_216EAFC
_0216EAF8: .word TimeAttackMenu__Main_216EB14
	thumb_func_end TimeAttackMenu__Main_216EAAC

	thumb_func_start TimeAttackMenu__Main_216EAFC
TimeAttackMenu__Main_216EAFC: // 0x0216EAFC
	push {r3, lr}
	bl TimeAttackMenu__Func_216C594
	cmp r0, #0
	bne _0216EB0C
	ldr r0, _0216EB10 // =TimeAttackMenu__Main_216E50C
	bl SetCurrentTaskMainEvent
_0216EB0C:
	pop {r3, pc}
	nop
_0216EB10: .word TimeAttackMenu__Main_216E50C
	thumb_func_end TimeAttackMenu__Main_216EAFC

	thumb_func_start TimeAttackMenu__Main_216EB14
TimeAttackMenu__Main_216EB14: // 0x0216EB14
	push {r3, lr}
	bl MultibootManager__Func_206150C
	ldr r0, _0216EB24 // =TimeAttackMenu__Main_216EB28
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_0216EB24: .word TimeAttackMenu__Main_216EB28
	thumb_func_end TimeAttackMenu__Main_216EB14

	thumb_func_start TimeAttackMenu__Main_216EB28
TimeAttackMenu__Main_216EB28: // 0x0216EB28
	push {r3, lr}
	bl MultibootManager__GetField8
	cmp r0, #0
	bgt _0216EB36
	beq _0216EB48
	pop {r3, pc}
_0216EB36:
	cmp r0, #0x19
	bgt _0216EB5E
	cmp r0, #0x15
	blt _0216EB5E
	beq _0216EB5E
	cmp r0, #0x16
	beq _0216EB48
	cmp r0, #0x19
	bne _0216EB5E
_0216EB48:
	mov r0, #0
	bl RenderCore_DisableSoftReset
	mov r0, #0
	bl RenderCore_SetNextFoldMode
	bl DestroyConnectionStatusIcon
	ldr r0, _0216EB60 // =TimeAttackMenu__Main_FadeToCorruptSave
	bl SetCurrentTaskMainEvent
_0216EB5E:
	pop {r3, pc}
	.align 2, 0
_0216EB60: .word TimeAttackMenu__Main_FadeToCorruptSave
	thumb_func_end TimeAttackMenu__Main_216EB28

	thumb_func_start TimeAttackMenu__Main_216EB64
TimeAttackMenu__Main_216EB64: // 0x0216EB64
	push {r3, lr}
	ldr r0, _0216EB84 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r2, _0216EB88 // =TimeAttackMenu__Main_216EB98
	ldr r1, _0216EB8C // =0x000014F8
	str r2, [r0, r1]
	ldr r2, _0216EB90 // =TimeAttackMenu__Main_216E454
	add r1, r1, #4
	str r2, [r0, r1]
	ldr r0, _0216EB94 // =TimeAttackMenu__Main_216D80C
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_0216EB84: .word TimeAttackMenu__Singleton
_0216EB88: .word TimeAttackMenu__Main_216EB98
_0216EB8C: .word 0x000014F8
_0216EB90: .word TimeAttackMenu__Main_216E454
_0216EB94: .word TimeAttackMenu__Main_216D80C
	thumb_func_end TimeAttackMenu__Main_216EB64

	thumb_func_start TimeAttackMenu__Main_216EB98
TimeAttackMenu__Main_216EB98: // 0x0216EB98
	push {r4, lr}
	ldr r0, _0216EBC8 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	add r0, #0x30
	mov r1, #1
	bl MainMenu__Func_2156790
	mov r0, #0xc
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216EBCC // =0x00001514
	mov r1, #0
	ldr r0, [r4, r0]
	mov r2, r1
	bl CreateLeaderboardWorker
	ldr r0, _0216EBD0 // =TimeAttackMenu__Main_216EBD4
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	nop
_0216EBC8: .word TimeAttackMenu__Singleton
_0216EBCC: .word 0x00001514
_0216EBD0: .word TimeAttackMenu__Main_216EBD4
	thumb_func_end TimeAttackMenu__Main_216EB98

	thumb_func_start TimeAttackMenu__Main_216EBD4
TimeAttackMenu__Main_216EBD4: // 0x0216EBD4
	push {r4, lr}
	ldr r0, _0216EC88 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl MultibootManager__GetField8
	cmp r0, #0
	beq _0216EBEE
	cmp r0, #0x19
	beq _0216EC04
	b _0216EC1A
_0216EBEE:
	add r4, #0x30
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2156790
	bl DestroyLeaderboardWorker
	ldr r0, _0216EC8C // =TimeAttackMenu__Main_216EE14
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216EC04:
	add r4, #0x30
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2156790
	bl DestroyLeaderboardWorker
	ldr r0, _0216EC90 // =TimeAttackMenu__Main_FadeToCorruptSave
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216EC1A:
	bl GetLeaderboardWorkerStatus
	cmp r0, #3
	bhi _0216EC86
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0216EC2E: // jump table
	.hword _0216EC60 - _0216EC2E - 2 // case 0
	.hword _0216EC44 - _0216EC2E - 2 // case 1
	.hword _0216EC36 - _0216EC2E - 2 // case 2
	.hword _0216EC38 - _0216EC2E - 2 // case 3
_0216EC36:
	pop {r4, pc}
_0216EC38:
	add r4, #0x30
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2156790
	b _0216EC76
_0216EC44:
	ldr r0, _0216EC94 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	add r4, #0x30
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2156790
	bl DestroyLeaderboardWorker
	ldr r0, _0216EC98 // =TimeAttackMenu__Main_216EDA0
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216EC60:
	add r4, #0x30
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2156790
	bl DestroyLeaderboardWorker
	ldr r0, _0216EC8C // =TimeAttackMenu__Main_216EE14
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216EC76:
	bl DestroyLeaderboardWorker
	ldr r0, _0216EC94 // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216EC9C // =TimeAttackMenu__Main_216ECA0
	bl SetCurrentTaskMainEvent
_0216EC86:
	pop {r4, pc}
	.align 2, 0
_0216EC88: .word TimeAttackMenu__Singleton
_0216EC8C: .word TimeAttackMenu__Main_216EE14
_0216EC90: .word TimeAttackMenu__Main_FadeToCorruptSave
_0216EC94: .word 0x0000FFFF
_0216EC98: .word TimeAttackMenu__Main_216EDA0
_0216EC9C: .word TimeAttackMenu__Main_216ECA0
	thumb_func_end TimeAttackMenu__Main_216EBD4

	thumb_func_start TimeAttackMenu__Main_216ECA0
TimeAttackMenu__Main_216ECA0: // 0x0216ECA0
	push {r3, lr}
	mov r0, #1
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216ECB0 // =TimeAttackMenu__Main_216ECB4
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_0216ECB0: .word TimeAttackMenu__Main_216ECB4
	thumb_func_end TimeAttackMenu__Main_216ECA0

	thumb_func_start TimeAttackMenu__Main_216ECB4
TimeAttackMenu__Main_216ECB4: // 0x0216ECB4
	push {r3, lr}
	bl TimeAttackMenu__Func_216C5BC
	cmp r0, #0
	beq _0216ECD8
	ldr r0, _0216ECDC // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216ECE0 // =0x00001418
	mov r2, #0x18
	add r0, r0, r1
	mov r1, #4
	bl CreateSaveGameWorker
	ldr r0, _0216ECE4 // =TimeAttackMenu__Main_216ECE8
	bl SetCurrentTaskMainEvent
_0216ECD8:
	pop {r3, pc}
	nop
_0216ECDC: .word TimeAttackMenu__Singleton
_0216ECE0: .word 0x00001418
_0216ECE4: .word TimeAttackMenu__Main_216ECE8
	thumb_func_end TimeAttackMenu__Main_216ECB4

	thumb_func_start TimeAttackMenu__Main_216ECE8
TimeAttackMenu__Main_216ECE8: // 0x0216ECE8
	push {r4, lr}
	ldr r0, _0216ED24 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _0216ED28 // =0x00001418
	add r0, r4, r0
	bl AwaitSaveGameCompletion
	cmp r0, #0
	beq _0216ED20
	ldr r0, _0216ED28 // =0x00001418
	add r0, r4, r0
	bl GetSaveGameSuccess
	cmp r0, #0
	beq _0216ED1A
	ldr r0, _0216ED2C // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216ED30 // =TimeAttackMenu__Main_216ED38
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216ED1A:
	ldr r0, _0216ED34 // =TimeAttackMenu__Main_216ED50
	bl SetCurrentTaskMainEvent
_0216ED20:
	pop {r4, pc}
	nop
_0216ED24: .word TimeAttackMenu__Singleton
_0216ED28: .word 0x00001418
_0216ED2C: .word 0x0000FFFF
_0216ED30: .word TimeAttackMenu__Main_216ED38
_0216ED34: .word TimeAttackMenu__Main_216ED50
	thumb_func_end TimeAttackMenu__Main_216ECE8

	thumb_func_start TimeAttackMenu__Main_216ED38
TimeAttackMenu__Main_216ED38: // 0x0216ED38
	push {r3, lr}
	bl TimeAttackMenu__Func_216C594
	cmp r0, #0
	bne _0216ED48
	ldr r0, _0216ED4C // =TimeAttackMenu__Main_216E50C
	bl SetCurrentTaskMainEvent
_0216ED48:
	pop {r3, pc}
	nop
_0216ED4C: .word TimeAttackMenu__Main_216E50C
	thumb_func_end TimeAttackMenu__Main_216ED38

	thumb_func_start TimeAttackMenu__Main_216ED50
TimeAttackMenu__Main_216ED50: // 0x0216ED50
	push {r3, lr}
	bl MultibootManager__Func_206150C
	ldr r0, _0216ED60 // =TimeAttackMenu__Main_216ED64
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_0216ED60: .word TimeAttackMenu__Main_216ED64
	thumb_func_end TimeAttackMenu__Main_216ED50

	thumb_func_start TimeAttackMenu__Main_216ED64
TimeAttackMenu__Main_216ED64: // 0x0216ED64
	push {r3, lr}
	bl MultibootManager__GetField8
	cmp r0, #0
	bgt _0216ED72
	beq _0216ED84
	pop {r3, pc}
_0216ED72:
	cmp r0, #0x19
	bgt _0216ED9A
	cmp r0, #0x15
	blt _0216ED9A
	beq _0216ED9A
	cmp r0, #0x16
	beq _0216ED84
	cmp r0, #0x19
	bne _0216ED9A
_0216ED84:
	mov r0, #0
	bl RenderCore_DisableSoftReset
	mov r0, #0
	bl RenderCore_SetNextFoldMode
	bl DestroyConnectionStatusIcon
	ldr r0, _0216ED9C // =TimeAttackMenu__Main_FadeToCorruptSave
	bl SetCurrentTaskMainEvent
_0216ED9A:
	pop {r3, pc}
	.align 2, 0
_0216ED9C: .word TimeAttackMenu__Main_FadeToCorruptSave
	thumb_func_end TimeAttackMenu__Main_216ED64

	thumb_func_start TimeAttackMenu__Main_216EDA0
TimeAttackMenu__Main_216EDA0: // 0x0216EDA0
	push {r3, lr}
	sub sp, #8
	mov r0, #0xe
	bl TimeAttackMenu__Func_216C57C
	bl TimeAttackMenu__GetSpriteButton1
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #4
	bl SaveSpriteButton__Func_2064588
	bl TimeAttackMenu__GetSpriteButton1
	mov r2, #0x66
	mov r1, #0x23
	lsl r2, r2, #6
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0216EDD8 // =TimeAttackMenu__Main_216EDDC
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, pc}
	nop
_0216EDD8: .word TimeAttackMenu__Main_216EDDC
	thumb_func_end TimeAttackMenu__Main_216EDA0

	thumb_func_start TimeAttackMenu__Main_216EDDC
TimeAttackMenu__Main_216EDDC: // 0x0216EDDC
	push {r3, lr}
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__RunState
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216EE0A
	bl TimeAttackMenu__GetSpriteButton1
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _0216EE0A
	ldr r0, _0216EE0C // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216EE10 // =TimeAttackMenu__Main_216E554
	bl SetCurrentTaskMainEvent
_0216EE0A:
	pop {r3, pc}
	.align 2, 0
_0216EE0C: .word 0x0000FFFF
_0216EE10: .word TimeAttackMenu__Main_216E554
	thumb_func_end TimeAttackMenu__Main_216EDDC

	thumb_func_start TimeAttackMenu__Main_216EE14
TimeAttackMenu__Main_216EE14: // 0x0216EE14
	push {r3, lr}
	ldr r1, _0216EE44 // =renderCoreGFXControlA+0x00000040
	mov r0, #0x18
	ldrsh r2, [r1, r0]
	mov r1, r0
	sub r1, #0x28
	cmp r2, r1
	bne _0216EE2E
	ldr r1, _0216EE48 // =renderCoreGFXControlB+0x00000040
	ldrsh r1, [r1, r0]
	sub r0, #0x28
	cmp r1, r0
	beq _0216EE36
_0216EE2E:
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
_0216EE36:
	ldr r0, _0216EE4C // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216EE50 // =TimeAttackMenu__Main_216EE54
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_0216EE44: .word renderCoreGFXControlA+0x00000040
_0216EE48: .word renderCoreGFXControlB+0x00000040
_0216EE4C: .word 0x0000FFFF
_0216EE50: .word TimeAttackMenu__Main_216EE54
	thumb_func_end TimeAttackMenu__Main_216EE14

	thumb_func_start TimeAttackMenu__Main_216EE54
TimeAttackMenu__Main_216EE54: // 0x0216EE54
	push {r3, lr}
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _0216EE7C
	bl DestroyDrawFadeTask
	bl ReleaseGameState
	ldr r0, _0216EE80 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl TimeAttackMenu__Destroy
	mov r0, #0x1a
	bl RequestNewSysEventChange
	bl NextSysEvent
	bl DestroyCurrentTask
_0216EE7C:
	pop {r3, pc}
	nop
_0216EE80: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Main_216EE54

	thumb_func_start TimeAttackMenu__Main_FadeToCorruptSave
TimeAttackMenu__Main_FadeToCorruptSave: // 0x0216EE84
	push {r3, lr}
	ldr r1, _0216EEB4 // =renderCoreGFXControlA+0x00000040
	mov r0, #0x18
	ldrsh r2, [r1, r0]
	mov r1, r0
	sub r1, #0x28
	cmp r2, r1
	bne _0216EE9E
	ldr r1, _0216EEB8 // =renderCoreGFXControlB+0x00000040
	ldrsh r1, [r1, r0]
	sub r0, #0x28
	cmp r1, r0
	beq _0216EEA6
_0216EE9E:
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
_0216EEA6:
	ldr r0, _0216EEBC // =0x0000FFFF
	bl TimeAttackMenu__Func_216C57C
	ldr r0, _0216EEC0 // =TimeAttackMenu__Main_ShowCorruptSave
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_0216EEB4: .word renderCoreGFXControlA+0x00000040
_0216EEB8: .word renderCoreGFXControlB+0x00000040
_0216EEBC: .word 0x0000FFFF
_0216EEC0: .word TimeAttackMenu__Main_ShowCorruptSave
	thumb_func_end TimeAttackMenu__Main_FadeToCorruptSave

	thumb_func_start TimeAttackMenu__Main_ShowCorruptSave
TimeAttackMenu__Main_ShowCorruptSave: // 0x0216EEC4
	push {r3, lr}
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _0216EEEC
	bl DestroyDrawFadeTask
	bl ReleaseGameState
	ldr r0, _0216EEF0 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl TimeAttackMenu__Destroy
	mov r0, #0x20
	bl RequestNewSysEventChange
	bl NextSysEvent
	bl DestroyCurrentTask
_0216EEEC:
	pop {r3, pc}
	nop
_0216EEF0: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenu__Main_ShowCorruptSave

	thumb_func_start TimeAttackMenuBG__Main
TimeAttackMenuBG__Main: // 0x0216EEF4
	push {r3, lr}
	ldr r0, _0216EF08 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, #0x30
	bl MainMenu__HandleBackgroundControl
	pop {r3, pc}
	nop
_0216EF08: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMenuBG__Main

	thumb_func_start TimeAttackMessageWindow__Main1
TimeAttackMessageWindow__Main1: // 0x0216EF0C
	push {r3, r4, lr}
	sub sp, #4
	ldr r0, _0216EF54 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x69
	lsl r1, r1, #2
	add r4, r0, r1
	ldrh r2, [r4, #8]
	ldr r0, _0216EF58 // =0x0000FFFF
	cmp r2, r0
	beq _0216EF46
	add r1, #0x44
	mov r3, #0
	add r0, r4, r1
	mov r1, #1
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	mov r0, #0x7a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__StartAnimating
	ldr r0, _0216EF5C // =TimeAttackMessageWindow__Main_PrepareWindow
	bl SetCurrentTaskMainEvent
_0216EF46:
	add r4, #0x74
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	add sp, #4
	pop {r3, r4, pc}
	nop
_0216EF54: .word TimeAttackMenu__Singleton
_0216EF58: .word 0x0000FFFF
_0216EF5C: .word TimeAttackMessageWindow__Main_PrepareWindow
	thumb_func_end TimeAttackMessageWindow__Main1

	thumb_func_start TimeAttackMessageWindow__Main_PrepareWindow
TimeAttackMessageWindow__Main_PrepareWindow: // 0x0216EF60
	push {r3, r4, r5, lr}
	ldr r0, _0216EFA8 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x69
	mov r2, #1
	lsl r1, r1, #2
	add r4, r0, r1
	lsl r2, r2, #0x1a
	ldr r3, [r2, #0]
	mov r0, #0x1f
	lsl r0, r0, #8
	and r0, r3
	lsr r3, r0, #8
	ldr r5, [r2, #0]
	ldr r0, _0216EFAC // =0xFFFFE0FF
	add r1, #0x44
	and r0, r5
	mov r5, #2
	orr r3, r5
	lsl r3, r3, #8
	orr r0, r3
	str r0, [r2]
	add r0, r4, r1
	bl FontWindowAnimator__ProcessWindowAnim
	add r4, #0x74
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	ldr r0, _0216EFB0 // =TimeAttackMessageWindow__Main_WindowAnimate
	bl SetCurrentTaskMainEvent
	pop {r3, r4, r5, pc}
	nop
_0216EFA8: .word TimeAttackMenu__Singleton
_0216EFAC: .word 0xFFFFE0FF
_0216EFB0: .word TimeAttackMessageWindow__Main_WindowAnimate
	thumb_func_end TimeAttackMessageWindow__Main_PrepareWindow

	thumb_func_start TimeAttackMessageWindow__Main_WindowAnimate
TimeAttackMessageWindow__Main_WindowAnimate: // 0x0216EFB4
	push {r3, r4, lr}
	sub sp, #4
	ldr r0, _0216F084 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x69
	lsl r1, r1, #2
	add r4, r0, r1
	add r1, #0x44
	add r0, r4, r1
	bl FontWindowAnimator__ProcessWindowAnim
	mov r0, #0x7a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _0216F076
	mov r0, #0x7a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__SetWindowOpen
	ldrh r1, [r4, #8]
	ldr r0, _0216F088 // =0x0000FFFF
	cmp r1, r0
	beq _0216F054
	mov r0, #0x49
	lsl r0, r0, #2
	strh r1, [r4, #0xa]
	add r0, r4, r0
	mov r1, #0x40
	bl FontAnimator__EnableFlags
	mov r0, #0x49
	lsl r0, r0, #2
	ldrh r1, [r4, #0xa]
	add r0, r4, r0
	bl FontAnimator__SetMsgSequence
	mov r0, #0x49
	lsl r0, r0, #2
	ldr r1, _0216F08C // =TimeAttackMessageWindow__FontCallback
	add r0, r4, r0
	mov r2, r4
	bl FontAnimator__SetCallback
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	mov r1, r0
	lsl r2, r1, #4
	lsr r1, r2, #0x1f
	add r1, r2, r1
	asr r2, r1, #1
	mov r1, #0x48
	mov r0, #0x49
	sub r1, r1, r2
	lsl r0, r0, #2
	lsl r1, r1, #0x10
	add r0, r4, r0
	asr r1, r1, #0x10
	bl FontAnimator__AdvanceLine
	ldr r0, _0216F090 // =TimeAttackMessageWindow__Main_LoadSequence
	bl SetCurrentTaskMainEvent
	b _0216F076
_0216F054:
	mov r0, #0x7a
	lsl r0, r0, #2
	mov r3, #0
	add r0, r4, r0
	mov r1, #4
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	mov r0, #0x7a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__StartAnimating
	ldr r0, _0216F094 // =TimeAttackMessageWindow__Main_SequenceFinished
	bl SetCurrentTaskMainEvent
_0216F076:
	add r4, #0x74
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	add sp, #4
	pop {r3, r4, pc}
	nop
_0216F084: .word TimeAttackMenu__Singleton
_0216F088: .word 0x0000FFFF
_0216F08C: .word TimeAttackMessageWindow__FontCallback
_0216F090: .word TimeAttackMessageWindow__Main_LoadSequence
_0216F094: .word TimeAttackMessageWindow__Main_SequenceFinished
	thumb_func_end TimeAttackMessageWindow__Main_WindowAnimate

	thumb_func_start TimeAttackMessageWindow__Main_LoadSequence
TimeAttackMessageWindow__Main_LoadSequence: // 0x0216F098
	push {r3, r4, r5, lr}
	ldr r0, _0216F110 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x69
	lsl r1, r1, #2
	add r4, r0, r1
	sub r1, #0x80
	add r0, r4, r1
	mov r1, #0x20
	bl FontAnimator__LoadCharacters
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	beq _0216F104
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0x40
	bl FontAnimator__DisableFlags
	mov r5, r4
	add r5, #0x10
	ldr r0, [r4, #0xc]
	ldr r1, [r5, #0x3c]
	cmp r0, #0
	beq _0216F0F8
	mov r0, #1
	tst r0, r1
	beq _0216F0FE
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
	b _0216F0FE
_0216F0F8:
	mov r0, #1
	orr r0, r1
	str r0, [r5, #0x3c]
_0216F0FE:
	ldr r0, _0216F114 // =TimeAttackMessageWindow__Main_SetNextSequence
	bl SetCurrentTaskMainEvent
_0216F104:
	add r4, #0x74
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	pop {r3, r4, r5, pc}
	nop
_0216F110: .word TimeAttackMenu__Singleton
_0216F114: .word TimeAttackMessageWindow__Main_SetNextSequence
	thumb_func_end TimeAttackMessageWindow__Main_LoadSequence

	thumb_func_start TimeAttackMessageWindow__Main_SetNextSequence
TimeAttackMessageWindow__Main_SetNextSequence: // 0x0216F118
	push {r3, r4, r5, lr}
	ldr r0, _0216F1EC // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x69
	lsl r1, r1, #2
	add r4, r0, r1
	mov r5, r4
	add r5, #0x10
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldrh r1, [r4, #8]
	ldr r0, _0216F1F0 // =0x0000FFFF
	cmp r1, r0
	bne _0216F178
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__ClearPixels
	mov r0, #0x7a
	lsl r0, r0, #2
	mov r3, #0
	add r0, r4, r0
	mov r1, #4
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	mov r0, #0x7a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__StartAnimating
	mov r0, #0
	str r0, [r4, #0xc]
	ldr r1, [r5, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r5, #0x3c]
	ldr r0, _0216F1F4 // =TimeAttackMessageWindow__Main_SequenceFinished
	bl SetCurrentTaskMainEvent
	b _0216F1E2
_0216F178:
	ldrh r0, [r4, #0xa]
	cmp r0, r1
	beq _0216F1E2
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0x40
	bl FontAnimator__EnableFlags
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__ClearPixels
	ldrh r1, [r4, #8]
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r4, r0
	strh r1, [r4, #0xa]
	bl FontAnimator__SetMsgSequence
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	mov r1, r0
	lsl r2, r1, #4
	lsr r1, r2, #0x1f
	add r1, r2, r1
	asr r2, r1, #1
	mov r1, #0x48
	mov r0, #0x49
	sub r1, r1, r2
	lsl r0, r0, #2
	lsl r1, r1, #0x10
	add r0, r4, r0
	asr r1, r1, #0x10
	bl FontAnimator__AdvanceLine
	mov r0, #0
	str r0, [r4, #0xc]
	ldr r0, _0216F1F8 // =TimeAttackMessageWindow__Main_LoadSequence
	bl SetCurrentTaskMainEvent
_0216F1E2:
	add r4, #0x74
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	pop {r3, r4, r5, pc}
	.align 2, 0
_0216F1EC: .word TimeAttackMenu__Singleton
_0216F1F0: .word 0x0000FFFF
_0216F1F4: .word TimeAttackMessageWindow__Main_SequenceFinished
_0216F1F8: .word TimeAttackMessageWindow__Main_LoadSequence
	thumb_func_end TimeAttackMessageWindow__Main_SetNextSequence

	thumb_func_start TimeAttackMessageWindow__Main_SequenceFinished
TimeAttackMessageWindow__Main_SequenceFinished: // 0x0216F1FC
	push {r4, lr}
	ldr r0, _0216F25C // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x69
	lsl r1, r1, #2
	add r4, r0, r1
	add r1, #0x44
	add r0, r4, r1
	bl FontWindowAnimator__ProcessWindowAnim
	mov r0, #0x7a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _0216F250
	mov r0, #1
	lsl r0, r0, #0x1a
	mov r1, #0x1f
	ldr r2, [r0, #0]
	lsl r1, r1, #8
	and r1, r2
	lsr r3, r1, #8
	ldr r2, [r0, #0]
	ldr r1, _0216F260 // =0xFFFFE0FF
	and r2, r1
	mov r1, #2
	bic r3, r1
	lsl r1, r3, #8
	orr r1, r2
	str r1, [r0]
	mov r0, #0x7a
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindowAnimator__SetWindowOpen
	ldr r0, _0216F264 // =TimeAttackMessageWindow__Main1
	bl SetCurrentTaskMainEvent
_0216F250:
	add r4, #0x74
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	pop {r4, pc}
	nop
_0216F25C: .word TimeAttackMenu__Singleton
_0216F260: .word 0xFFFFE0FF
_0216F264: .word TimeAttackMessageWindow__Main1
	thumb_func_end TimeAttackMessageWindow__Main_SequenceFinished

	thumb_func_start TimeAttackMessageWindow__Main2
TimeAttackMessageWindow__Main2: // 0x0216F268
	push {r4, lr}
	ldr r0, _0216F294 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x69
	lsl r1, r1, #2
	add r4, r0, r1
	add r1, #0x44
	add r0, r4, r1
	bl FontWindowAnimator__Draw
	mov r0, #0x49
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontAnimator__Draw
	add r4, #0x10
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	pop {r4, pc}
	.align 2, 0
_0216F294: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackMessageWindow__Main2

	thumb_func_start TimeAttackMenuHeader__Main1
TimeAttackMenuHeader__Main1: // 0x0216F298
	push {r4, r5, lr}
	sub sp, #0x24
	ldr r0, _0216F31C // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x3f
	lsl r1, r1, #4
	add r4, r0, r1
	ldr r5, _0216F320 // =0x00000A2C
	ldr r0, _0216F324 // =0x0000FFFF
	ldrh r1, [r4, r5]
	cmp r1, r0
	beq _0216F318
	sub r5, #0x64
	add r0, r4, r5
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r2, _0216F328 // =0x04001000
	mov r0, #0x1f
	ldr r1, [r2, #0]
	lsl r0, r0, #8
	and r0, r1
	lsr r3, r0, #8
	ldr r1, [r2, #0]
	ldr r0, _0216F32C // =0xFFFFE0FF
	and r0, r1
	mov r1, #2
	orr r3, r1
	lsl r3, r3, #8
	orr r0, r3
	str r0, [r2]
	mov r0, #0
	str r0, [sp]
	mov r3, #0x10
	ldr r2, _0216F330 // =Task__Unknown204BE48__LerpValue
	str r3, [sp, #4]
	str r2, [sp, #8]
	lsl r2, r3, #8
	str r2, [sp, #0xc]
	ldr r2, _0216F334 // =TimeAttackMenu__Func_216D550
	str r2, [sp, #0x10]
	ldr r2, _0216F338 // =TimeAttackMenuHeader__Main_216F364
	str r2, [sp, #0x14]
	ldr r2, _0216F33C // =0x00002061
	str r0, [sp, #0x18]
	str r2, [sp, #0x1c]
	str r0, [sp, #0x20]
	add r0, r4, r5
	add r0, #0xa
	mov r2, #0xd0
	bl Task__Unknown204BE48__Create
	mov r1, #0xa3
	lsl r1, r1, #4
	str r0, [r4, r1]
	ldr r0, _0216F340 // =TimeAttackMenuHeader__Main_Animate
	bl SetCurrentTaskMainEvent
_0216F318:
	add sp, #0x24
	pop {r4, r5, pc}
	.align 2, 0
_0216F31C: .word TimeAttackMenu__Singleton
_0216F320: .word 0x00000A2C
_0216F324: .word 0x0000FFFF
_0216F328: .word 0x04001000
_0216F32C: .word 0xFFFFE0FF
_0216F330: .word Task__Unknown204BE48__LerpValue
_0216F334: .word TimeAttackMenu__Func_216D550
_0216F338: .word TimeAttackMenuHeader__Main_216F364
_0216F33C: .word 0x00002061
_0216F340: .word TimeAttackMenuHeader__Main_Animate
	thumb_func_end TimeAttackMenuHeader__Main1

	thumb_func_start TimeAttackMenuHeader__Main_Animate
TimeAttackMenuHeader__Main_Animate: // 0x0216F344
	push {r3, lr}
	ldr r0, _0216F35C // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216F360 // =0x00000DB8
	add r0, r0, r1
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	pop {r3, pc}
	.align 2, 0
_0216F35C: .word TimeAttackMenu__Singleton
_0216F360: .word 0x00000DB8
	thumb_func_end TimeAttackMenuHeader__Main_Animate

	thumb_func_start TimeAttackMenuHeader__Main_216F364
TimeAttackMenuHeader__Main_216F364: // 0x0216F364
	push {r4, r5, lr}
	sub sp, #0x24
	ldr r0, _0216F3E8 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x3f
	lsl r1, r1, #4
	add r4, r0, r1
	ldr r5, _0216F3EC // =0x00000A2C
	ldr r0, _0216F3F0 // =0x0000FFFF
	ldrh r1, [r4, r5]
	cmp r1, r0
	bne _0216F3C6
	sub r5, #0x64
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0
	str r0, [sp]
	mov r2, #0x10
	ldr r1, _0216F3F4 // =Task__Unknown204BE48__LerpValue
	str r2, [sp, #4]
	str r1, [sp, #8]
	ldr r1, _0216F3F8 // =0xFFFFF000
	mov r3, #0xd0
	str r1, [sp, #0xc]
	ldr r1, _0216F3FC // =TimeAttackMenu__Func_216D550
	str r1, [sp, #0x10]
	ldr r1, _0216F400 // =TimeAttackMenuHeader__Main1
	str r1, [sp, #0x14]
	ldr r1, _0216F404 // =0x00002061
	str r0, [sp, #0x18]
	str r1, [sp, #0x1c]
	str r0, [sp, #0x20]
	add r0, r4, r5
	add r0, #0xa
	mov r1, #2
	bl Task__Unknown204BE48__Create
	mov r1, #0xa3
	lsl r1, r1, #4
	str r0, [r4, r1]
	ldr r0, _0216F408 // =TimeAttackMenuHeader__Main_216F410
	bl SetCurrentTaskMainEvent
	b _0216F3D8
_0216F3C6:
	mov r0, r5
	sub r0, #0x58
	ldrh r0, [r4, r0]
	cmp r0, r1
	beq _0216F3D8
	sub r5, #0x64
	add r0, r4, r5
	bl AnimatorSprite__SetAnimation
_0216F3D8:
	ldr r0, _0216F40C // =0x000009C8
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add sp, #0x24
	pop {r4, r5, pc}
	.align 2, 0
_0216F3E8: .word TimeAttackMenu__Singleton
_0216F3EC: .word 0x00000A2C
_0216F3F0: .word 0x0000FFFF
_0216F3F4: .word Task__Unknown204BE48__LerpValue
_0216F3F8: .word 0xFFFFF000
_0216F3FC: .word TimeAttackMenu__Func_216D550
_0216F400: .word TimeAttackMenuHeader__Main1
_0216F404: .word 0x00002061
_0216F408: .word TimeAttackMenuHeader__Main_216F410
_0216F40C: .word 0x000009C8
	thumb_func_end TimeAttackMenuHeader__Main_216F364

	thumb_func_start TimeAttackMenuHeader__Main_216F410
TimeAttackMenuHeader__Main_216F410: // 0x0216F410
	push {r3, lr}
	ldr r0, _0216F428 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0216F42C // =0x00000DB8
	add r0, r0, r1
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	pop {r3, pc}
	.align 2, 0
_0216F428: .word TimeAttackMenu__Singleton
_0216F42C: .word 0x00000DB8
	thumb_func_end TimeAttackMenuHeader__Main_216F410

	thumb_func_start TimeAttackMenuHeader__Main2
TimeAttackMenuHeader__Main2: // 0x0216F430
	push {r3, r4, r5, lr}
	ldr r0, _0216F47C // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x3f
	lsl r1, r1, #4
	add r4, r0, r1
	mov r0, r4
	add r0, #8
	bl StageSelectMenu__Unknown__Process
	mov r0, r4
	add r0, #8
	bl StageSelectMenu__Unknown__Draw
	ldr r0, _0216F480 // =0x000009C8
	add r5, r4, r0
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r0, _0216F484 // =0x00000A2E
	ldrh r1, [r4, r0]
	mov r0, #1
	tst r0, r1
	bne _0216F478
	mov r0, #8
	ldrsh r0, [r5, r0]
	ldr r1, _0216F488 // =renderCoreGFXControlB
	sub r0, #0x22
	strh r0, [r1, #4]
	mov r0, #0xa
	ldrsh r2, [r5, r0]
	mov r0, #0x10
	sub r0, r0, r2
	strh r0, [r1, #6]
_0216F478:
	pop {r3, r4, r5, pc}
	nop
_0216F47C: .word TimeAttackMenu__Singleton
_0216F480: .word 0x000009C8
_0216F484: .word 0x00000A2E
_0216F488: .word renderCoreGFXControlB
	thumb_func_end TimeAttackMenuHeader__Main2

	thumb_func_start TimeAttackBackButton__Main1
TimeAttackBackButton__Main1: // 0x0216F48C
	push {r3, r4, r5, lr}
	ldr r0, _0216F4F8 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	add r4, #0xdc
	mov r0, r4
	mov r5, r4
	add r0, #0x14
	add r5, #0x64
	bl TouchField__Process
	ldr r0, [r4, #0xc]
	ldr r1, [r5, #0x3c]
	cmp r0, #0
	beq _0216F4C0
	mov r0, #1
	bic r1, r0
	str r1, [r5, #0x3c]
	ldrh r0, [r4, #8]
	cmp r0, #0x10
	bhs _0216F4D0
	add r0, r0, #1
	strh r0, [r4, #8]
	b _0216F4D0
_0216F4C0:
	mov r0, #1
	orr r0, r1
	str r0, [r5, #0x3c]
	ldrh r0, [r4, #8]
	cmp r0, #0
	beq _0216F4D0
	sub r0, r0, #1
	strh r0, [r4, #8]
_0216F4D0:
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
	.align 2, 0
_0216F4F8: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackBackButton__Main1

	thumb_func_start TimeAttackBackButton__Main2
TimeAttackBackButton__Main2: // 0x0216F4FC
	push {r3, lr}
	ldr r0, _0216F514 // =TimeAttackMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #5
	lsl r1, r1, #6
	add r0, r0, r1
	bl AnimatorSprite__DrawFrame
	pop {r3, pc}
	nop
_0216F514: .word TimeAttackMenu__Singleton
	thumb_func_end TimeAttackBackButton__Main2

	thumb_func_start TimeAttackRankList__Init
TimeAttackRankList__Init: // 0x0216F518
	push {r4, r5, r6, lr}
	mov r6, r0
	mov r2, #0x17
	mov r0, #0
	mov r1, r6
	lsl r2, r2, #6
	bl MIi_CpuClear16
	mov r0, #0x97
	mov r5, r6
	lsl r0, r0, #2
	add r5, #0x1c
	add r4, r6, r0
	cmp r5, r4
	beq _0216F542
_0216F536:
	mov r0, r5
	bl Unknown2056FDC__Init
	add r5, #0x48
	cmp r5, r4
	bne _0216F536
_0216F542:
	ldr r0, _0216F55C // =0x0000058E
	mov r1, #0x14
	strh r1, [r6, r0]
	mov r2, #0x2c
	add r1, r0, #2
	strh r2, [r6, r1]
	add r1, r0, #4
	mov r2, #0xec
	strh r2, [r6, r1]
	mov r1, #0x94
	add r0, r0, #6
	strh r1, [r6, r0]
	pop {r4, r5, r6, pc}
	.align 2, 0
_0216F55C: .word 0x0000058E
	thumb_func_end TimeAttackRankList__Init

	thumb_func_start TimeAttackRankList__Destroy
TimeAttackRankList__Destroy: // 0x0216F560
	push {r4, r5, r6, lr}
	mov r5, r0
	mov r0, #0x97
	mov r4, r5
	lsl r0, r0, #2
	add r4, #0x1c
	add r6, r5, r0
	cmp r4, r6
	beq _0216F57E
_0216F572:
	mov r0, r4
	bl Unknown2056FDC__Release
	add r4, #0x48
	cmp r4, r6
	bne _0216F572
_0216F57E:
	ldr r1, [r5, #0xc]
	mov r0, #1
	tst r0, r1
	beq _0216F600
	ldr r0, [r5, #0]
	cmp r0, #0
	beq _0216F596
	bl GetTaskWork_
	mov r1, #0
	str r1, [r0]
	str r1, [r5]
_0216F596:
	ldr r0, [r5, #4]
	cmp r0, #0
	beq _0216F5A6
	bl GetTaskWork_
	mov r1, #0
	str r1, [r0]
	str r1, [r5, #4]
_0216F5A6:
	ldr r0, _0216F604 // =0x00000598
	add r4, r5, r0
	add r0, #0x28
	add r6, r5, r0
	cmp r4, r6
	beq _0216F5C2
_0216F5B2:
	ldr r0, [r4, #0]
	cmp r0, #0
	beq _0216F5BC
	bl DestroyTask
_0216F5BC:
	add r4, r4, #4
	cmp r4, r6
	bne _0216F5B2
_0216F5C2:
	mov r0, #0x9a
	lsl r0, r0, #2
	add r4, r5, r0
	ldr r0, _0216F608 // =0x00000524
	add r6, r5, r0
	cmp r4, r6
	beq _0216F5DC
_0216F5D0:
	mov r0, r4
	bl AnimatorSprite__Release
	add r4, #0x64
	cmp r4, r6
	bne _0216F5D0
_0216F5DC:
	mov r0, #0x97
	lsl r0, r0, #2
	add r4, r5, r0
	add r0, r0, #4
	add r0, r5, r0
	cmp r4, r0
	beq _0216F5F8
	ldr r0, [r4, #0]
	cmp r0, #0
	beq _0216F5F8
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4]
_0216F5F8:
	ldr r1, [r5, #0xc]
	mov r0, #3
	bic r1, r0
	str r1, [r5, #0xc]
_0216F600:
	pop {r4, r5, r6, pc}
	nop
_0216F604: .word 0x00000598
_0216F608: .word 0x00000524
	thumb_func_end TimeAttackRankList__Destroy

	.data

aBbDmtaMenuBb_0_ovl03: // 0x0217EDAC
	.asciz "/bb/dmta_menu.bb"
	.align 4
	
aBbNlBb_4: // 0x0217EDC0
	.asciz "/bb/nl.bb"
	.align 4
	
aFntFontAllFnt_4_ovl03: // 0x0217EDCC
	.asciz "/fnt/font_all.fnt"
	.align 4