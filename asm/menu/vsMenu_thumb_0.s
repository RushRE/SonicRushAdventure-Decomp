	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

.public VSMenu__Singleton
VSMenu__Singleton: // 0x0217EFE8
	.space 0x04 // Task*

	.text

	thumb_func_start VSMenu__Create
VSMenu__Create: // 0x021667B4
	push {lr}
	sub sp, #0xc
	ldr r0, _021667DC // =0x00002001
	mov r2, #0
	str r0, [sp]
	ldr r0, _021667E0 // =0x0000195C
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021667E4 // =VSMenu__Main
	ldr r1, _021667E8 // =VSMenu__Destructor
	mov r3, r2
	bl TaskCreate_
	ldr r1, _021667EC // =VSMenu__Singleton
	str r0, [r1]
	bl VSMenu__LoadAssets
	add sp, #0xc
	pop {pc}
	nop
_021667DC: .word 0x00002001
_021667E0: .word 0x0000195C
_021667E4: .word VSMenu__Main
_021667E8: .word VSMenu__Destructor
_021667EC: .word VSMenu__Singleton
	thumb_func_end VSMenu__Create

	thumb_func_start VSMenu__Func_21667F0
VSMenu__Func_21667F0: // 0x021667F0
	push {r4, lr}
	mov r4, r0
	ldr r0, _02166800 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	strh r4, [r0, #0x38]
	pop {r4, pc}
	.align 2, 0
_02166800: .word VSMenu__Singleton
	thumb_func_end VSMenu__Func_21667F0

	thumb_func_start VSMenu__SetNetworkMessageSequence
VSMenu__SetNetworkMessageSequence: // 0x02166804
	push {r4, lr}
	mov r4, r0
	ldr r0, _02166818 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x96
	lsl r1, r1, #2
	strh r4, [r0, r1]
	pop {r4, pc}
	.align 2, 0
_02166818: .word VSMenu__Singleton
	thumb_func_end VSMenu__SetNetworkMessageSequence

	thumb_func_start VSMenu__CheckNetworkMessageMain
VSMenu__CheckNetworkMessageMain: // 0x0216681C
	push {r3, lr}
	ldr r0, _0216683C // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x93
	lsl r1, r1, #2
	ldr r0, [r0, r1]
	ldr r2, _02166840 // =VSMenuNetworkMessage__Main_21698F4
	ldr r0, [r0, #8]
	cmp r2, r0
	bne _02166838
	mov r0, #1
	pop {r3, pc}
_02166838:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
_0216683C: .word VSMenu__Singleton
_02166840: .word VSMenuNetworkMessage__Main_21698F4
	thumb_func_end VSMenu__CheckNetworkMessageMain

	thumb_func_start VSMenu__GetFontWindow
VSMenu__GetFontWindow: // 0x02166844
	push {r3, lr}
	ldr r0, _02166858 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0xb1
	lsl r1, r1, #2
	add r0, r0, r1
	pop {r3, pc}
	nop
_02166858: .word VSMenu__Singleton
	thumb_func_end VSMenu__GetFontWindow

	thumb_func_start VSMenu__Func_216685C
VSMenu__Func_216685C: // 0x0216685C
	push {r4, lr}
	mov r4, r0
	ldr r0, _02166870 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x17
	lsl r1, r1, #4
	str r4, [r0, r1]
	pop {r4, pc}
	.align 2, 0
_02166870: .word VSMenu__Singleton
	thumb_func_end VSMenu__Func_216685C

	thumb_func_start VSMenu__Func_2166874
VSMenu__Func_2166874: // 0x02166874
	push {r4, lr}
	mov r4, r0
	ldr r0, _02166888 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x92
	lsl r1, r1, #2
	str r4, [r0, r1]
	pop {r4, pc}
	.align 2, 0
_02166888: .word VSMenu__Singleton
	thumb_func_end VSMenu__Func_2166874

	thumb_func_start VSMenu__GetUnknownTouchField
VSMenu__GetUnknownTouchField: // 0x0216688C
	push {r3, lr}
	ldr r0, _021668A0 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x62
	lsl r1, r1, #2
	add r0, r0, r1
	pop {r3, pc}
	nop
_021668A0: .word VSMenu__Singleton
	thumb_func_end VSMenu__GetUnknownTouchField

	thumb_func_start VSMenu__SetTouchCallback
VSMenu__SetTouchCallback: // 0x021668A4
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _021668D4 // =VSMenu__Singleton
	mov r4, r1
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x5d
	lsl r1, r1, #2
	add r2, r0, r1
	str r5, [r2, #0xc]
	str r4, [r2, #0x10]
	cmp r5, #0
	ldr r1, [r2, #0x40]
	beq _021668CA
	mov r0, #0x80
	bic r1, r0
	str r1, [r2, #0x40]
	pop {r3, r4, r5, pc}
_021668CA:
	mov r0, #0x80
	orr r0, r1
	str r0, [r2, #0x40]
	pop {r3, r4, r5, pc}
	nop
_021668D4: .word VSMenu__Singleton
	thumb_func_end VSMenu__SetTouchCallback

	thumb_func_start VSMenu__GetUnknownTouchResponseFlags
VSMenu__GetUnknownTouchResponseFlags: // 0x021668D8
	push {r3, lr}
	ldr r0, _021668EC // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x6d
	lsl r1, r1, #2
	ldr r0, [r0, r1]
	pop {r3, pc}
	nop
_021668EC: .word VSMenu__Singleton
	thumb_func_end VSMenu__GetUnknownTouchResponseFlags

	thumb_func_start VSMenu__GetYesNoButton
VSMenu__GetYesNoButton: // 0x021668F0
	push {r3, lr}
	ldr r0, _02166900 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _02166904 // =0x000014E4
	add r0, r0, r1
	pop {r3, pc}
	.align 2, 0
_02166900: .word VSMenu__Singleton
_02166904: .word 0x000014E4
	thumb_func_end VSMenu__GetYesNoButton

	thumb_func_start VSMenu__Destructor
VSMenu__Destructor: // 0x02166908
	ldr r0, _02166910 // =VSMenu__Singleton
	mov r1, #0
	str r1, [r0]
	bx lr
	.align 2, 0
_02166910: .word VSMenu__Singleton
	thumb_func_end VSMenu__Destructor

	thumb_func_start VSMenu__ChangeEvent
VSMenu__ChangeEvent: // 0x02166914
	push {r4, lr}
	mov r4, r0
	ldr r0, _02166960 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	cmp r4, #0
	beq _02166932
	cmp r4, #1
	beq _0216694A
	pop {r4, pc}
_02166932:
	ldr r0, _02166964 // =gameState+0x000000C0
	mov r1, #1
	strb r1, [r0, #0x1c]
	mov r0, #0
	bl RequestSysEventChange
	bl MultibootManager__Func_2060C9C
	ldr r0, _02166968 // =VSMenu__Main_GotoHubMenu
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216694A:
	ldr r1, _02166964 // =gameState+0x000000C0
	mov r0, #1
	strb r0, [r1, #0x1c]
	bl RequestSysEventChange
	ldr r0, _0216696C // =VSMenu__Main_GotoVSMenu
	bl SetCurrentTaskMainEvent
	bl ReleaseSysSound
	pop {r4, pc}
	.align 2, 0
_02166960: .word VSMenu__Singleton
_02166964: .word gameState+0x000000C0
_02166968: .word VSMenu__Main_GotoHubMenu
_0216696C: .word VSMenu__Main_GotoVSMenu
	thumb_func_end VSMenu__ChangeEvent

	thumb_func_start VSMenu__LoadAssets
VSMenu__LoadAssets: // 0x02166970
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02166B10 // =0x0000195C
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r0, #0
	bl VRAMSystem__Init
	mov r1, #0
	mov r0, #1
	mov r2, r1
	bl GX_SetGraphicsMode
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r0, _02166B14 // =renderCurrentDisplay
	mov r2, #1
	str r2, [r0]
	ldr r0, _02166B18 // =0x04000008
	mov r6, #3
	ldrh r1, [r0, #0]
	mov r3, #2
	mov r7, #3
	bic r1, r6
	strh r1, [r0]
	ldrh r1, [r0, #2]
	bic r1, r6
	orr r1, r2
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	bic r1, r6
	orr r1, r3
	strh r1, [r0, #4]
	ldrh r1, [r0, #6]
	bic r1, r6
	orr r1, r7
	strh r1, [r0, #6]
	ldr r1, _02166B1C // =0x04001008
	ldrh r0, [r1, #0]
	bic r0, r6
	strh r0, [r1]
	ldrh r0, [r1, #2]
	bic r0, r6
	orr r0, r2
	strh r0, [r1, #2]
	ldrh r0, [r1, #4]
	ldr r2, _02166B20 // =renderCoreGFXControlA+0x00000040
	bic r0, r6
	orr r0, r3
	strh r0, [r1, #4]
	ldrh r0, [r1, #6]
	bic r0, r6
	orr r0, r7
	strh r0, [r1, #6]
	mov r0, #0x18
	ldrsh r0, [r2, r0]
	cmp r0, #0
	beq _02166A04
	blt _021669F6
	mov r3, r7
_021669F6:
	lsl r0, r3, #0x10
	mov r1, #1
	lsr r0, r0, #0x10
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	b _02166A0C
_02166A04:
	mov r0, #0x42
	lsr r1, r1, #0xe
	bl CreateDrawFadeTask
_02166A0C:
	bl MultibootManager__GetField8
	cmp r0, #0x18
	bne _02166A18
	bl MultibootManager__Create
_02166A18:
	bl VSMenu__LoadMenuAssets
	bl VSMenuHeader__Create
	bl VSMenuBackButton__Create
	ldr r0, _02166B24 // =0x80000003
	bl VSMenuBackground__Create
	bl LoadConnectionStatusIconAssets
	ldr r0, _02166B28 // =0x000014E4
	add r0, r4, r0
	bl SaveSpriteButton__Func_206515C
	bl VSConnectionMenu__LoadAssets
	ldr r1, _02166B2C // =0x00000918
	str r0, [r4, r1]
	bl VSMenuNetworkMessage__Func_216718C
	mov r0, #1
	bl VSMenuNetworkMessage__Create
	bl VSMenu__Func_2167464
	ldr r0, _02166B30 // =0x00001294
	add r0, r4, r0
	bl VSFriendListMenu__LoadAssets
	ldr r0, _02166B34 // =0x00001864
	add r0, r4, r0
	bl VSRegisterFriendCodeMenu__Init
	ldr r0, _02166B38 // =0x0000186C
	add r0, r4, r0
	bl VSViewFriendCodeMenu__LoadAssets
	ldr r0, _02166B3C // =0x00001874
	add r0, r4, r0
	bl VSRecordsMenu__LoadAssets
	bl LoadSysSoundVillage
	mov r0, #0
	bl PlaySysVillageTrack
	bl ResetTouchInput
	bl MultibootManager__GetField8
	cmp r0, #0
	beq _02166AB0
	cmp r0, #0x11
	beq _02166A8C
	cmp r0, #0x19
	beq _02166ABC
	b _02166AC8
_02166A8C:
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
	b _02166AC8
_02166AB0:
	ldr r1, _02166B40 // =VSMenu__Main_21692B8
	mov r0, r5
	bl SetTaskMainEvent
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_02166ABC:
	ldr r1, _02166B44 // =VSMenu__Main_2169324
	mov r0, r5
	bl SetTaskMainEvent
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_02166AC8:
	bl GetSysEventList
	mov r1, #0xe
	ldrsh r0, [r0, r1]
	cmp r0, #0x10
	beq _02166AE4
	cmp r0, #0x21
	bne _02166AFA
	ldr r1, _02166B48 // =VSMenu__Main_216770C
	mov r0, r5
	bl SetTaskMainEvent
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_02166AE4:
	ldr r0, _02166B4C // =gameState+0x00000080
	ldr r1, [r0, #0x58]
	mov r0, #1
	tst r0, r1
	beq _02166AFA
	ldr r1, _02166B50 // =VSMenu__Main_2168F8C
	mov r0, r5
	bl SetTaskMainEvent
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_02166AFA:
	bl MultibootManager__GetField8
	cmp r0, #0x11
	bne _02166B0A
	ldr r1, _02166B54 // =VSMenu__Main_21686EC
	mov r0, r5
	bl SetTaskMainEvent
_02166B0A:
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_02166B10: .word 0x0000195C
_02166B14: .word renderCurrentDisplay
_02166B18: .word 0x04000008
_02166B1C: .word 0x04001008
_02166B20: .word renderCoreGFXControlA+0x00000040
_02166B24: .word 0x80000003
_02166B28: .word 0x000014E4
_02166B2C: .word 0x00000918
_02166B30: .word 0x00001294
_02166B34: .word 0x00001864
_02166B38: .word 0x0000186C
_02166B3C: .word 0x00001874
_02166B40: .word VSMenu__Main_21692B8
_02166B44: .word VSMenu__Main_2169324
_02166B48: .word VSMenu__Main_216770C
_02166B4C: .word gameState+0x00000080
_02166B50: .word VSMenu__Main_2168F8C
_02166B54: .word VSMenu__Main_21686EC
	thumb_func_end VSMenu__LoadAssets

	thumb_func_start VSMenu__Destroy
VSMenu__Destroy: // 0x02166B58
	push {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl ReleaseTouchInput
	ldr r0, _02166BB8 // =0x00001874
	add r0, r4, r0
	bl VSRecordsMenu__ReleaseAssets
	ldr r0, _02166BBC // =0x0000186C
	add r0, r4, r0
	bl VSViewFriendCodeMenu__ReleaseAssets
	ldr r0, _02166BC0 // =0x00001864
	add r0, r4, r0
	bl VSRegisterFriendCodeMenu__Release
	ldr r0, _02166BC4 // =0x00001294
	add r0, r4, r0
	bl VSFriendListMenu__ReleaseAssets
	bl VSMenu__Func_21674C8
	bl VSMenuNetworkMessage__Func_2167214
	ldr r0, _02166BC8 // =0x00000918
	ldr r0, [r4, r0]
	bl VSConnectionMenu__ReleaseAssets
	ldr r0, _02166BC8 // =0x00000918
	mov r1, #0
	str r1, [r4, r0]
	ldr r0, _02166BCC // =0x000014E4
	add r0, r4, r0
	bl SaveSpriteButton__Func_20651A4
	bl ReleaseConnectionStatusIconAssets
	bl VSMenuBackground__Destroy
	bl VSMenuBackButton__Destroy
	bl VSMenuHeader__Destroy
	bl VSMenu__ReleaseMenuAssets
	pop {r4, pc}
	.align 2, 0
_02166BB8: .word 0x00001874
_02166BBC: .word 0x0000186C
_02166BC0: .word 0x00001864
_02166BC4: .word 0x00001294
_02166BC8: .word 0x00000918
_02166BCC: .word 0x000014E4
	thumb_func_end VSMenu__Destroy

	thumb_func_start VSMenu__LoadMenuAssets
VSMenu__LoadMenuAssets: // 0x02166BD0
	push {r4, lr}
	sub sp, #8
	ldr r0, _02166CB0 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0
	ldr r0, _02166CB4 // =aBbDmwfLangBb_0
	mov r1, #6
	mov r3, #1
	str r2, [sp]
	bl ArchiveFile__Load
	add r1, r4, #4
	mov r2, #0
	str r0, [r4, #4]
	add r1, #0x28
	mov r3, r2
	bl StageClear__LoadFiles
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _02166C24
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02166C10: // jump table
	.hword _02166C1C - _02166C10 - 2 // case 0
	.hword _02166C1C - _02166C10 - 2 // case 1
	.hword _02166C1C - _02166C10 - 2 // case 2
	.hword _02166C1C - _02166C10 - 2 // case 3
	.hword _02166C1C - _02166C10 - 2 // case 4
	.hword _02166C1C - _02166C10 - 2 // case 5
_02166C1C:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _02166C26
_02166C24:
	mov r1, #1
_02166C26:
	mov r2, #0
	ldr r0, _02166CB4 // =aBbDmwfLangBb_0
	str r2, [sp]
	mov r3, #1
	bl ArchiveFile__Load
	str r0, [r4, #8]
	mov r0, #1
	add r1, r4, #4
	add r3, r4, #4
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	ldr r0, [r4, #8]
	add r1, #0x10
	add r3, #8
	bl StageClear__LoadFiles
	mov r2, #0
	ldr r0, _02166CB8 // =aBbDmwfCmnBb
	str r2, [sp]
	mov r1, #2
	mov r3, r2
	bl ArchiveFile__Load
	str r0, [r4, #0x10]
	mov r2, #0
	ldr r0, _02166CBC // =aBbNlBb_3
	str r2, [sp]
	mov r1, #0xb
	mov r3, r2
	bl ArchiveFile__Load
	str r0, [r4, #0x18]
	mov r2, #0
	ldr r0, _02166CBC // =aBbNlBb_3
	str r2, [sp]
	mov r1, #9
	mov r3, r2
	bl ArchiveFile__Load
	str r0, [r4, #0x1c]
	mov r2, #0
	ldr r0, _02166CBC // =aBbNlBb_3
	str r2, [sp]
	mov r1, #0xd
	mov r3, r2
	bl ArchiveFile__Load
	str r0, [r4, #0x20]
	mov r2, #0
	ldr r0, _02166CBC // =aBbNlBb_3
	str r2, [sp]
	mov r1, #0xc
	mov r3, r2
	bl ArchiveFile__Load
	str r0, [r4, #0x24]
	mov r2, #0
	ldr r0, _02166CBC // =aBbNlBb_3
	mov r1, #1
	mov r3, r2
	str r2, [sp]
	bl ArchiveFile__Load
	str r0, [r4, #0x28]
	add sp, #8
	pop {r4, pc}
	nop
_02166CB0: .word VSMenu__Singleton
_02166CB4: .word aBbDmwfLangBb_0
_02166CB8: .word aBbDmwfCmnBb
_02166CBC: .word aBbNlBb_3
	thumb_func_end VSMenu__LoadMenuAssets

	thumb_func_start VSMenu__ReleaseMenuAssets
VSMenu__ReleaseMenuAssets: // 0x02166CC0
	push {r4, lr}
	ldr r0, _02166D00 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #4]
	bl _FreeHEAP_USER
	ldr r0, [r4, #8]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x10]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x24]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x20]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x1c]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x18]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x28]
	bl _FreeHEAP_USER
	pop {r4, pc}
	nop
_02166D00: .word VSMenu__Singleton
	thumb_func_end VSMenu__ReleaseMenuAssets

	thumb_func_start VSMenuHeader__Create
VSMenuHeader__Create: // 0x02166D04
	push {r3, r4, r5, r6, lr}
	sub sp, #0x14
	ldr r0, _02166DDC // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r5, r4
	add r5, #0x30
	mov r1, #0
	mov r6, r5
	ldr r0, [r4, #0x10]
	mov r2, r1
	add r6, #0x14
	bl SpriteUnknown__Func_204C3CC
	mov r2, #0
	str r2, [sp]
	str r0, [sp, #4]
	mov r0, #0xd
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	ldr r1, [r4, #0x10]
	ldr r3, _02166DE0 // =0x00000804
	mov r0, r6
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	strh r1, [r6, #8]
	strh r1, [r6, #0xa]
	mov r6, r5
	ldr r0, [r4, #0x10]
	mov r2, #1
	add r6, #0x78
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0xe
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #2
	str r0, [sp, #0x10]
	ldr r1, [r4, #0x10]
	ldr r3, _02166DE0 // =0x00000804
	mov r0, r6
	mov r2, #1
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	strh r1, [r6, #8]
	strh r1, [r6, #0xa]
	mov r6, r5
	ldr r0, [r4, #0x14]
	add r6, #0xdc
	bl SpriteUnknown__GetSpriteSize
	mov r2, #0
	str r2, [sp]
	str r0, [sp, #4]
	mov r0, #0xf
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	mov r0, #1
	str r0, [sp, #0x10]
	ldr r1, [r4, #0x14]
	ldr r3, _02166DE0 // =0x00000804
	mov r0, r6
	bl SpriteUnknown__Func_204C90C
	mov r0, #0x18
	strh r0, [r6, #8]
	ldr r0, _02166DE4 // =0x0000FFFF
	mov r1, #0
	strh r0, [r5, #8]
	strh r1, [r5, #0xa]
	strh r1, [r5, #0xc]
	mov r0, #5
	str r1, [r5, #0x10]
	mov r2, #1
	lsl r0, r0, #6
	str r2, [r5, r0]
	ldr r0, _02166DE8 // =0x00002042
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02166DEC // =VSMenuHeader__Main1
	str r1, [sp, #8]
	mov r3, r1
	bl TaskCreate_
	mov r1, #0
	str r0, [r5]
	ldr r0, _02166DF0 // =0x00002082
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02166DF4 // =VSMenuHeader__Main2
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r5, #4]
	add sp, #0x14
	pop {r3, r4, r5, r6, pc}
	nop
_02166DDC: .word VSMenu__Singleton
_02166DE0: .word 0x00000804
_02166DE4: .word 0x0000FFFF
_02166DE8: .word 0x00002042
_02166DEC: .word VSMenuHeader__Main1
_02166DF0: .word 0x00002082
_02166DF4: .word VSMenuHeader__Main2
	thumb_func_end VSMenuHeader__Create

	thumb_func_start VSMenuHeader__Destroy
VSMenuHeader__Destroy: // 0x02166DF8
	push {r4, lr}
	ldr r0, _02166E34 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r0, #0x30]
	add r4, #0x30
	cmp r0, #0
	beq _02166E10
	bl DestroyTask
_02166E10:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02166E1A
	bl DestroyTask
_02166E1A:
	mov r0, r4
	add r0, #0x14
	bl AnimatorSprite__Release
	mov r0, r4
	add r0, #0x78
	bl AnimatorSprite__Release
	add r4, #0xdc
	mov r0, r4
	bl AnimatorSprite__Release
	pop {r4, pc}
	.align 2, 0
_02166E34: .word VSMenu__Singleton
	thumb_func_end VSMenuHeader__Destroy

	thumb_func_start VSMenuBackButton__Create
VSMenuBackButton__Create: // 0x02166E38
	push {r3, r4, r5, r6, lr}
	sub sp, #0x14
	ldr r0, _02166EF8 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r6, r0
	mov r0, #0x5d
	lsl r0, r0, #2
	add r4, r6, r0
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
	ldr r0, [r6, #0x28]
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
	ldr r1, [r6, #0x28]
	ldr r3, _02166EFC // =0x00000804
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
	ldr r0, _02166F00 // =VSMenuBackButton__TouchCallback
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
	ldr r0, _02166F04 // =0x00002043
	str r1, [r4, #0x10]
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02166F08 // =VSMenuBackButton__Main1
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	mov r1, #0x5d
	lsl r1, r1, #2
	str r0, [r6, r1]
	mov r1, #0
	ldr r0, _02166F0C // =0x00002083
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02166F10 // =VSMenuBackButton__Main2
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r4, #4]
	add sp, #0x14
	pop {r3, r4, r5, r6, pc}
	.align 2, 0
_02166EF8: .word VSMenu__Singleton
_02166EFC: .word 0x00000804
_02166F00: .word VSMenuBackButton__TouchCallback
_02166F04: .word 0x00002043
_02166F08: .word VSMenuBackButton__Main1
_02166F0C: .word 0x00002083
_02166F10: .word VSMenuBackButton__Main2
	thumb_func_end VSMenuBackButton__Create

	thumb_func_start VSMenuBackButton__Destroy
VSMenuBackButton__Destroy: // 0x02166F14
	push {r4, lr}
	ldr r0, _02166F44 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x5d
	lsl r1, r1, #2
	add r4, r0, r1
	ldr r0, [r4, #0]
	cmp r0, #0
	beq _02166F2E
	bl DestroyTask
_02166F2E:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02166F38
	bl DestroyTask
_02166F38:
	add r4, #0x64
	mov r0, r4
	bl AnimatorSprite__Release
	pop {r4, pc}
	nop
_02166F44: .word VSMenu__Singleton
	thumb_func_end VSMenuBackButton__Destroy

	thumb_func_start VSMenuBackground__Create
VSMenuBackground__Create: // 0x02166F48
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x58
	mov r5, r0
	ldr r0, _02167100 // =VSMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x8f
	lsl r1, r1, #2
	add r4, r0, r1
	mov r0, #3
	tst r0, r5
	bne _02166F64
	b _021670D0
_02166F64:
	mov r1, #0
	ldr r0, _02167104 // =aBbDmwfCmnBb
	mov r2, r1
	mov r3, r1
	str r1, [sp]
	bl ArchiveFile__Load
	mov r6, r0
	mov r0, #1
	mov r7, r5
	and r7, r0
	beq _02166FBA
	ldr r2, _02167108 // =0x04000008
	mov r0, #0x43
	ldrh r1, [r2, #0]
	mov r3, #0
	and r1, r0
	add r0, #0xd5
	orr r0, r1
	strh r0, [r2]
	str r3, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0x10
	mov r1, r6
	mov r2, #0x38
	bl InitBackground
	add r0, sp, #0x10
	bl DrawBackground
	ldr r0, _0216710C // =renderCoreGFXControlA
	mov r1, #0
	strh r1, [r0, #2]
	ldrh r1, [r0, #2]
	strh r1, [r0]
	ldr r1, _02167108 // =0x04000008
	mov r0, #3
	ldrh r2, [r1, #0]
	bic r2, r0
	strh r2, [r1]
_02166FBA:
	mov r0, #2
	and r0, r5
	str r0, [sp, #0xc]
	beq _02167006
	ldr r2, _02167110 // =0x04001008
	mov r0, #0x43
	ldrh r1, [r2, #0]
	mov r3, #1
	and r1, r0
	add r0, #0xd9
	orr r0, r1
	strh r0, [r2]
	mov r0, #0
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0x10
	mov r1, r6
	mov r2, #0x38
	bl InitBackground
	mov r0, #0xc0
	str r0, [sp, #0x1c]
	add r0, sp, #0x10
	bl DrawBackground
	ldr r0, _02167114 // =renderCoreGFXControlB
	mov r1, #0
	strh r1, [r0, #2]
	ldrh r1, [r0, #2]
	strh r1, [r0]
	ldr r1, _02167110 // =0x04001008
	mov r0, #3
	ldrh r2, [r1, #0]
	bic r2, r0
	strh r2, [r1]
_02167006:
	mov r0, r6
	bl _FreeHEAP_USER
	mov r2, #0
	ldr r0, _02167104 // =aBbDmwfCmnBb
	mov r1, #1
	mov r3, r2
	str r2, [sp]
	bl ArchiveFile__Load
	mov r6, r0
	cmp r7, #0
	beq _02167072
	ldr r2, _02167118 // =0x0400000E
	mov r0, #0x43
	ldrh r1, [r2, #0]
	mov r3, #0
	and r1, r0
	lsr r0, r2, #0x11
	orr r0, r1
	strh r0, [r2]
	mov r0, #3
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	str r0, [sp, #8]
	add r0, sp, #0x10
	mov r1, r6
	mov r2, #0x38
	bl InitBackground
	add r0, sp, #0x10
	bl DrawBackground
	ldr r0, _0216710C // =renderCoreGFXControlA
	mov r1, #0
	strh r1, [r0, #0xe]
	ldrh r1, [r0, #0xe]
	strh r1, [r0, #0xc]
	ldr r0, _02167118 // =0x0400000E
	mov r1, #3
	ldrh r2, [r0, #0]
	bic r2, r1
	mov r1, #3
	orr r1, r2
	strh r1, [r0]
	sub r0, #0xe
	ldr r2, [r0, #0]
	ldr r1, _0216711C // =0xFFFFE0FF
	and r2, r1
	mov r1, #0x19
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r0]
_02167072:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	beq _021670CA
	ldr r2, _02167120 // =0x0400100E
	mov r0, #0x43
	ldrh r1, [r2, #0]
	mov r3, #1
	and r1, r0
	lsr r0, r2, #0x11
	orr r0, r1
	strh r0, [r2]
	mov r0, #3
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	str r0, [sp, #8]
	add r0, sp, #0x10
	mov r1, r6
	mov r2, #0x38
	bl InitBackground
	add r0, sp, #0x10
	bl DrawBackground
	ldr r0, _02167114 // =renderCoreGFXControlB
	mov r1, #0
	strh r1, [r0, #0xe]
	ldrh r1, [r0, #0xe]
	strh r1, [r0, #0xc]
	ldr r0, _02167120 // =0x0400100E
	mov r1, #3
	ldrh r2, [r0, #0]
	bic r2, r1
	mov r1, #3
	orr r1, r2
	strh r1, [r0]
	sub r0, #0xe
	ldr r2, [r0, #0]
	ldr r1, _0216711C // =0xFFFFE0FF
	and r2, r1
	mov r1, #0x19
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r0]
_021670CA:
	mov r0, r6
	bl _FreeHEAP_USER
_021670D0:
	mov r0, #2
	lsl r0, r0, #0x1e
	tst r0, r5
	beq _021670FA
	mov r1, #0
	strh r1, [r4, #8]
	mov r0, #3
	str r0, [r4, #0xc]
	ldr r0, _02167124 // =0x00002046
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02167128 // =VSMenuBackground__Main1
	str r1, [sp, #8]
	mov r3, r1
	bl TaskCreate_
	str r0, [r4]
	ldr r0, _0216712C // =VSMenuBackground__VBlankCallback
	bl RenderCore_SetVBlankCallback
_021670FA:
	add sp, #0x58
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02167100: .word VSMenu__Singleton
_02167104: .word aBbDmwfCmnBb
_02167108: .word 0x04000008
_0216710C: .word renderCoreGFXControlA
_02167110: .word 0x04001008
_02167114: .word renderCoreGFXControlB
_02167118: .word 0x0400000E
_0216711C: .word 0xFFFFE0FF
_02167120: .word 0x0400100E
_02167124: .word 0x00002046
_02167128: .word VSMenuBackground__Main1
_0216712C: .word VSMenuBackground__VBlankCallback
	thumb_func_end VSMenuBackground__Create

	.data
	
aBbDmwfLangBb_0: // 0x0217ED24
	.asciz "/bb/dmwf_lang.bb"
	.align 4
	
aBbDmwfCmnBb: // 0x0217ED38
	.asciz "/bb/dmwf_cmn.bb"
	.align 4
	
aBbNlBb_3: // 0x0217ED48
	.asciz "/bb/nl.bb"
	.align 4
	
aFntFontAllFnt_3_ovl03: // 0x0217ED54
	.asciz "/fnt/font_all.fnt"
	.align 4