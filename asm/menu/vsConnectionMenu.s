	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public VSConnectionMenu__Singleton
VSConnectionMenu__Singleton: // 0x0217EFEC
	.space 0x04 // Task*

	.text

	thumb_func_start VSConnectionMenu__LoadAssets
VSConnectionMenu__LoadAssets: // 0x0216A994
	push {r3, r4, lr}
	sub sp, #4
	mov r0, #0x14
	bl _AllocHeadHEAP_SYSTEM
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x14
	bl MIi_CpuClear16
	mov r2, #0
	ldr r0, _0216AA1C // =aBbDmwfJoinBb
	str r2, [sp]
	mov r1, #6
	mov r3, #1
	bl ArchiveFile__Load
	str r0, [r4]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _0216A9E4
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0216A9D0: // jump table
	.hword _0216A9DC - _0216A9D0 - 2 // case 0
	.hword _0216A9DC - _0216A9D0 - 2 // case 1
	.hword _0216A9DC - _0216A9D0 - 2 // case 2
	.hword _0216A9DC - _0216A9D0 - 2 // case 3
	.hword _0216A9DC - _0216A9D0 - 2 // case 4
	.hword _0216A9DC - _0216A9D0 - 2 // case 5
_0216A9DC:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _0216A9E6
_0216A9E4:
	mov r1, #1
_0216A9E6:
	mov r2, #0
	ldr r0, _0216AA1C // =aBbDmwfJoinBb
	str r2, [sp]
	mov r3, #1
	bl ArchiveFile__Load
	str r0, [r4, #4]
	mov r2, #0
	ldr r0, _0216AA20 // =aNarcDmcmnAnten_0
	str r2, [sp]
	sub r1, r2, #1
	mov r3, #1
	bl ArchiveFile__Load
	str r0, [r4, #8]
	bl VSState__AllocAssets
	mov r0, #1
	mov r1, #0
	lsl r0, r0, #0x1e
	mov r2, #3
	mov r3, r1
	bl VSState__LoadAssets
	mov r0, r4
	add sp, #4
	pop {r3, r4, pc}
	.align 2, 0
_0216AA1C: .word aBbDmwfJoinBb
_0216AA20: .word aNarcDmcmnAnten_0
	thumb_func_end VSConnectionMenu__LoadAssets

	thumb_func_start VSConnectionMenu__ReleaseAssets
VSConnectionMenu__ReleaseAssets: // 0x0216AA24
	push {r4, r5, r6, lr}
	mov r6, r0
	bl VSState__ReleaseAssets
	mov r5, r6
	mov r0, #0xc
	beq _0216AA42
	mov r4, r6
	add r4, #0xc
_0216AA36:
	ldr r0, [r5, #0]
	bl _FreeHEAP_USER
	add r5, r5, #4
	cmp r5, r4
	bne _0216AA36
_0216AA42:
	mov r0, r6
	bl _FreeHEAP_SYSTEM
	pop {r4, r5, r6, pc}
	.align 2, 0
	thumb_func_end VSConnectionMenu__ReleaseAssets

	thumb_func_start VSConnectionMenu__Create
VSConnectionMenu__Create: // 0x0216AA4C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r6, r0
	mov r0, #5
	str r0, [r6, #0xc]
	mov r5, r1
	mov r0, #3
	strh r5, [r6, #0x10]
	tst r1, r0
	beq _0216AA64
	ldr r0, _0216ABE4 // =VSConnectionMenu__Main1
	b _0216AA70
_0216AA64:
	add r0, #0xfd
	tst r0, r5
	bne _0216AA6E
	ldr r0, _0216ABE4 // =VSConnectionMenu__Main1
	b _0216AA70
_0216AA6E:
	ldr r0, _0216ABE8 // =VSConnectionMenu__Main2
_0216AA70:
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	ldr r1, _0216ABEC // =0x00000818
	str r2, [sp, #4]
	str r1, [sp, #8]
	ldr r1, _0216ABF0 // =VSConnectionMenu__Destructor
	mov r3, r2
	bl TaskCreate_
	ldr r1, _0216ABF4 // =VSConnectionMenu__Singleton
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _0216ABEC // =0x00000818
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	str r6, [r4]
	mov r0, #0x81
	str r0, [sp]
	mov r0, #0
	ldr r1, _0216ABEC // =0x00000818
	str r0, [sp, #4]
	str r1, [sp, #8]
	mov r1, r0
	mov r2, r0
	mov r3, r0
	bl TaskCreate_
	str r0, [r4, #4]
	mov r0, r4
	add r0, #8
	bl VSConnectionMenu__Unknown__Init
	ldr r2, _0216ABF8 // =0x0400000C
	mov r0, #0x43
	ldrh r1, [r2, #0]
	and r1, r0
	ldr r0, _0216ABFC // =0x00000704
	orr r1, r0
	strh r1, [r2]
	add r0, #0x4c
	ldr r1, _0216AC00 // =renderCoreGFXControlA
	mov r2, #0
	strh r2, [r1, #6]
	ldrh r3, [r1, #6]
	add r6, r4, r0
	strh r3, [r1, #4]
	ldr r1, [r4, #0]
	ldr r7, [r1, #4]
	mov r1, #1
	mov r0, r7
	bl SpriteUnknown__Func_204C3CC
	mov r1, #1
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #5
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	ldr r3, _0216AC04 // =0x00000804
	mov r0, r6
	mov r1, r7
	mov r2, #0
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x80
	strh r0, [r6, #8]
	mov r0, #0x62
	strh r0, [r6, #0xa]
	ldr r0, [r4, #0]
	mov r1, #1
	ldr r6, [r0, #0]
	mov r2, #6
	mov r0, r6
	ldr r7, _0216AC08 // =0x000007B4
	bl SpriteUnknown__Func_204C3CC
	mov r1, #1
	str r1, [sp]
	str r0, [sp, #4]
	mov r2, #6
	mov r3, r7
	str r2, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	add r0, r4, r7
	mov r1, r6
	add r3, #0x50
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	add r0, r4, r7
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, _0216AC0C // =VSConnectionMenu__VSStateCallback
	mov r1, r4
	bl VSState__SetCallback
	bl VSMenu__GetFontWindow
	mov r1, #2
	mov r2, #0
	mov r3, #1
	bl VSState__Func_2163510
	mov r0, #1
	mov r1, r5
	tst r1, r0
	beq _0216AB80
	mov r0, #0
	bl VSState__InitSprites
	mov r0, #4
	tst r0, r5
	bne _0216AB76
	mov r0, #0
	b _0216AB78
_0216AB76:
	mov r0, #1
_0216AB78:
	bl MultibootManager__Func_20612D4
	mov r4, #0
	b _0216ABD4
_0216AB80:
	mov r1, #2
	mov r2, r5
	tst r2, r1
	beq _0216ABAC
	bl VSState__InitSprites
	mov r0, #4
	tst r0, r5
	bne _0216AB96
	mov r1, #0
	b _0216AB98
_0216AB96:
	mov r1, #1
_0216AB98:
	mov r0, #0x10
	tst r0, r5
	bne _0216ABA2
	mov r0, #1
	b _0216ABA4
_0216ABA2:
	mov r0, #0
_0216ABA4:
	bl MultibootManager__Func_20616C4
	mov r4, #0
	b _0216ABD4
_0216ABAC:
	add r1, #0xfe
	mov r0, r5
	tst r0, r1
	bne _0216ABCE
	mov r0, #0
	bl VSState__InitSprites
	mov r0, #4
	tst r0, r5
	bne _0216ABC4
	mov r0, #0
	b _0216ABC6
_0216ABC4:
	mov r0, #1
_0216ABC6:
	bl MultibootManager__Func_2060DE0
	mov r4, #0
	b _0216ABD4
_0216ABCE:
	bl MultibootManager__Func_2060F04
	mov r4, #1
_0216ABD4:
	bl SaveGame__GetOnlineScore
	mov r1, r0
	mov r0, r4
	bl VSState__SetPlayerInfo
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_0216ABE4: .word VSConnectionMenu__Main1
_0216ABE8: .word VSConnectionMenu__Main2
_0216ABEC: .word 0x00000818
_0216ABF0: .word VSConnectionMenu__Destructor
_0216ABF4: .word VSConnectionMenu__Singleton
_0216ABF8: .word 0x0400000C
_0216ABFC: .word 0x00000704
_0216AC00: .word renderCoreGFXControlA
_0216AC04: .word 0x00000804
_0216AC08: .word 0x000007B4
_0216AC0C: .word VSConnectionMenu__VSStateCallback
	thumb_func_end VSConnectionMenu__Create

	thumb_func_start VSConnectionMenu__Func_216AC10
VSConnectionMenu__Func_216AC10: // 0x0216AC10
	push {r3, lr}
	bl VSConnectionMenu__Func_216AC48
	cmp r0, #9
	bhi _0216AC3E
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0216AC26: // jump table
	.hword _0216AC3E - _0216AC26 - 2 // case 0
	.hword _0216AC3E - _0216AC26 - 2 // case 1
	.hword _0216AC3E - _0216AC26 - 2 // case 2
	.hword _0216AC3E - _0216AC26 - 2 // case 3
	.hword _0216AC3E - _0216AC26 - 2 // case 4
	.hword _0216AC3A - _0216AC26 - 2 // case 5
	.hword _0216AC3A - _0216AC26 - 2 // case 6
	.hword _0216AC3A - _0216AC26 - 2 // case 7
	.hword _0216AC3A - _0216AC26 - 2 // case 8
	.hword _0216AC3A - _0216AC26 - 2 // case 9
_0216AC3A:
	mov r0, #0
	pop {r3, pc}
_0216AC3E:
	mov r0, #1
	pop {r3, pc}
	.align 2, 0
	thumb_func_end VSConnectionMenu__Func_216AC10

	thumb_func_start VSConnectionMenu__Func_216AC44
VSConnectionMenu__Func_216AC44: // 0x0216AC44
	ldrh r0, [r0, #0x10]
	bx lr
	thumb_func_end VSConnectionMenu__Func_216AC44

	thumb_func_start VSConnectionMenu__Func_216AC48
VSConnectionMenu__Func_216AC48: // 0x0216AC48
	ldr r0, [r0, #0xc]
	bx lr
	thumb_func_end VSConnectionMenu__Func_216AC48

	thumb_func_start VSConnectionMenu__Destructor
VSConnectionMenu__Destructor: // 0x0216AC4C
	push {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x75
	lsl r0, r0, #4
	add r0, r4, r0
	bl AnimatorSprite__Release
	ldr r0, _0216AC70 // =0x000007B4
	add r0, r4, r0
	bl AnimatorSprite__Release
	ldr r0, _0216AC74 // =VSConnectionMenu__Singleton
	mov r1, #0
	str r1, [r0]
	pop {r4, pc}
	nop
_0216AC70: .word 0x000007B4
_0216AC74: .word VSConnectionMenu__Singleton
	thumb_func_end VSConnectionMenu__Destructor

	thumb_func_start VSConnectionMenu__VSStateCallback
VSConnectionMenu__VSStateCallback: // 0x0216AC78
	push {r4, lr}
	ldr r1, [r2, #0]
	cmp r0, #1
	ldrh r4, [r1, #0x10]
	bne _0216AD06
	mov r0, #2
	lsl r0, r0, #0xe
	tst r0, r4
	beq _0216AD06
	mov r0, #0
	mov r1, #2
	mov r2, r0
	bl VSState__Func_2163784
	mov r0, #1
	mov r1, r4
	tst r1, r0
	beq _0216ACB8
	mov r1, r0
	mov r2, #0
	bl VSState__Func_2163784
	ldr r0, _0216AD08 // =VSConnectionMenu__TouchCallback_3
	mov r1, r4
	bl VSMenu__SetTouchCallback
	ldr r0, _0216AD0C // =VSConnectionMenu__Singleton
	ldr r1, _0216AD10 // =VSConnectionMenu__Main_216BFD0
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r4, pc}
_0216ACB8:
	mov r1, #2
	mov r2, r4
	tst r2, r1
	beq _0216ACDC
	mov r1, r0
	mov r2, #0
	bl VSState__Func_2163784
	ldr r0, _0216AD08 // =VSConnectionMenu__TouchCallback_3
	mov r1, r4
	bl VSMenu__SetTouchCallback
	ldr r0, _0216AD0C // =VSConnectionMenu__Singleton
	ldr r1, _0216AD14 // =VSConnectionMenu__Main_216C3D4
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r4, pc}
_0216ACDC:
	mov r2, r1
	add r2, #0xfe
	tst r2, r4
	bne _0216AD00
	mov r1, r0
	mov r2, #0
	bl VSState__Func_2163784
	ldr r0, _0216AD08 // =VSConnectionMenu__TouchCallback_3
	mov r1, r4
	bl VSMenu__SetTouchCallback
	ldr r0, _0216AD0C // =VSConnectionMenu__Singleton
	ldr r1, _0216AD18 // =VSConnectionMenu__Main_216B144
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r4, pc}
_0216AD00:
	mov r2, #0
	bl VSState__Func_2163784
_0216AD06:
	pop {r4, pc}
	.align 2, 0
_0216AD08: .word VSConnectionMenu__TouchCallback_3
_0216AD0C: .word VSConnectionMenu__Singleton
_0216AD10: .word VSConnectionMenu__Main_216BFD0
_0216AD14: .word VSConnectionMenu__Main_216C3D4
_0216AD18: .word VSConnectionMenu__Main_216B144
	thumb_func_end VSConnectionMenu__VSStateCallback

	thumb_func_start VSConnectionMenu__Func_216AD1C
VSConnectionMenu__Func_216AD1C: // 0x0216AD1C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x34
	str r0, [sp, #0x24]
	ldr r0, _0216AEB4 // =VSConnectionMenu__Singleton
	ldr r0, [r0, #0]
	str r0, [sp, #0x28]
	bl GetTaskWork_
	str r0, [sp, #0x30]
	str r0, [sp, #0x2c]
	add r0, #0x40
	str r0, [sp, #0x2c]
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	ldr r0, [sp, #0x28]
	ldr r1, _0216AEB8 // =VSConnectionMenu__Main_216B014
	bl SetTaskMainEvent
	bl VSState__GetFlags
	bl VSState__Func_21630F0
	bl VSMenu__GetUnknownTouchField
	ldr r4, [sp, #0x2c]
	mov r5, #0
	mov r7, #0xde
	mov r6, #0x1e
_0216AD58:
	mov r0, #7
	sub r0, r0, r5
	lsl r0, r0, #0x11
	lsr r0, r0, #0x10
	str r0, [sp]
	mov r0, #0x12
	str r0, [sp, #4]
	ldr r0, _0216AEBC // =Task__Unknown204BE48__LerpValue
	mov r1, #2
	str r0, [sp, #8]
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [sp, #0xc]
	ldr r0, _0216AEC0 // =Task__Unknown204BE48__Func_204BF20
	mov r2, r6
	str r0, [sp, #0x10]
	mov r0, r4
	add r0, #0x60
	str r0, [sp, #0x14]
	mov r0, #0
	str r0, [sp, #0x18]
	mov r0, #0x61
	str r0, [sp, #0x1c]
	mov r0, #0
	str r0, [sp, #0x20]
	mov r0, r4
	add r0, #0x4c
	add r0, r0, #2
	mov r3, r7
	bl Task__Unknown204BE48__Create
	str r0, [r4, #0x60]
	add r5, r5, #1
	add r4, #0x64
	add r7, #0x10
	add r6, #0x10
	cmp r5, #8
	blt _0216AD58
	mov r1, #0x6e
	ldr r0, [sp, #0x2c]
	lsl r1, r1, #4
	ldr r2, [r0, r1]
	mov r0, #1
	orr r2, r0
	ldr r0, [sp, #0x2c]
	str r2, [r0, r1]
	ldr r0, _0216AEC4 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, [sp, #0x30]
	ldr r0, [r0, #0]
	ldrh r6, [r0, #0x10]
	mov r0, #3
	mov r1, r6
	tst r1, r0
	bne _0216AE4C
	add r0, #0xfd
	tst r0, r6
	beq _0216AE4C
	ldr r0, [sp, #0x30]
	mov r1, #0
	add r0, #8
	bl VSConnectionMenu__Unknown__Func_216A948
	ldr r2, [sp, #0x2c]
	mov r3, #0
	mov r0, #0x40
_0216ADDE:
	ldr r1, [r2, #0x3c]
	add r3, r3, #1
	orr r1, r0
	str r1, [r2, #0x3c]
	add r2, #0x64
	cmp r3, #8
	blt _0216ADDE
	mov r1, #0x32
	ldr r0, [sp, #0x2c]
	lsl r1, r1, #4
	add r4, r0, r1
	ldr r1, _0216AEC8 // =0x0000044C
	add r5, r0, r1
	cmp r4, r5
	beq _0216AE08
_0216ADFC:
	mov r0, r4
	bl AnimatorSprite__Release
	add r4, #0x64
	cmp r4, r5
	bne _0216ADFC
_0216AE08:
	ldr r1, _0216AEC8 // =0x0000044C
	ldr r0, [sp, #0x2c]
	add r4, r0, r1
	ldr r1, _0216AECC // =0x000006A4
	add r5, r0, r1
	cmp r4, r5
	beq _0216AE22
_0216AE16:
	mov r0, r4
	bl AnimatorSprite__Release
	add r4, #0x64
	cmp r4, r5
	bne _0216AE16
_0216AE22:
	ldr r1, _0216AECC // =0x000006A4
	ldr r0, [sp, #0x2c]
	add r0, r0, r1
	bl AnimatorSprite__Release
	mov r0, #0
	mov r1, r0
	bl VSState__SetCallback
	ldr r0, [sp, #0x28]
	ldr r1, _0216AED0 // =VSConnectionMenu__Main_216BE88
	bl SetTaskMainEvent
	ldr r0, [sp, #0x2c]
	ldr r2, [sp, #0x2c]
	ldr r0, [r0, #0x60]
	add r2, #0x60
	ldr r1, _0216AED4 // =VSConnectionMenu__Func_216AFE8
	str r2, [sp, #0x2c]
	bl Task__Unknown204BE48__Func_204BF04
_0216AE4C:
	ldr r0, [sp, #0x24]
	cmp r0, #3
	bhi _0216AEB0
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0216AE5E: // jump table
	.hword _0216AE66 - _0216AE5E - 2 // case 0
	.hword _0216AE86 - _0216AE5E - 2 // case 1
	.hword _0216AE9C - _0216AE5E - 2 // case 2
	.hword _0216AEA8 - _0216AE5E - 2 // case 3
_0216AE66:
	ldr r2, _0216AED8 // =gameState
	mov r1, #1
	mov r0, #4
	str r1, [r2, #0x14]
	tst r0, r6
	bne _0216AE78
	mov r0, #0
	str r0, [r2, #0x20]
	b _0216AE7A
_0216AE78:
	str r1, [r2, #0x20]
_0216AE7A:
	ldr r0, [sp, #0x30]
	mov r1, #6
	ldr r0, [r0, #0]
	add sp, #0x34
	str r1, [r0, #0xc]
	pop {r4, r5, r6, r7, pc}
_0216AE86:
	ldr r0, [sp, #0x30]
	mov r1, #7
	ldr r0, [r0, #0]
	str r1, [r0, #0xc]
	mov r0, #2
	tst r0, r6
	bne _0216AEB0
	bl MultibootManager__Func_206150C
	add sp, #0x34
	pop {r4, r5, r6, r7, pc}
_0216AE9C:
	ldr r0, [sp, #0x30]
	mov r1, #8
	ldr r0, [r0, #0]
	add sp, #0x34
	str r1, [r0, #0xc]
	pop {r4, r5, r6, r7, pc}
_0216AEA8:
	ldr r0, [sp, #0x30]
	mov r1, #9
	ldr r0, [r0, #0]
	str r1, [r0, #0xc]
_0216AEB0:
	add sp, #0x34
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_0216AEB4: .word VSConnectionMenu__Singleton
_0216AEB8: .word VSConnectionMenu__Main_216B014
_0216AEBC: .word Task__Unknown204BE48__LerpValue
_0216AEC0: .word Task__Unknown204BE48__Func_204BF20
_0216AEC4: .word 0x0000FFFF
_0216AEC8: .word 0x0000044C
_0216AECC: .word 0x000006A4
_0216AED0: .word VSConnectionMenu__Main_216BE88
_0216AED4: .word VSConnectionMenu__Func_216AFE8
_0216AED8: .word gameState
	thumb_func_end VSConnectionMenu__Func_216AD1C

	thumb_func_start VSConnectionMenu__TouchCallback_3
VSConnectionMenu__TouchCallback_3: // 0x0216AEDC
	push {r3, lr}
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xe
	tst r0, r1
	beq _0216AEFA
	mov r0, #1
	tst r0, r1
	bne _0216AEFA
	mov r0, #2
	tst r0, r1
	beq _0216AEFA
	bl MultibootManager__Func_2061808
_0216AEFA:
	mov r0, #1
	bl PlaySysMenuNavSfx
	mov r0, #1
	bl VSConnectionMenu__Func_216AD1C
	pop {r3, pc}
	thumb_func_end VSConnectionMenu__TouchCallback_3

	thumb_func_start VSConnectionMenu__TouchCallback_None
VSConnectionMenu__TouchCallback_None: // 0x0216AF08
	bx lr
	.align 2, 0
	thumb_func_end VSConnectionMenu__TouchCallback_None

	thumb_func_start VSConnectionMenu__TouchAreaCallback2
VSConnectionMenu__TouchAreaCallback2: // 0x0216AF0C
	push {r4, lr}
	mov r4, r2
	cmp r0, #3
	bne _0216AF24
	ldr r0, _0216AF28 // =VSConnectionMenu__TouchCallback_None
	mov r1, #0
	bl VSMenu__SetTouchCallback
	ldr r1, _0216AF2C // =VSConnectionMenu__Main_216B810
	mov r0, r4
	bl SetTaskMainEvent
_0216AF24:
	pop {r4, pc}
	nop
_0216AF28: .word VSConnectionMenu__TouchCallback_None
_0216AF2C: .word VSConnectionMenu__Main_216B810
	thumb_func_end VSConnectionMenu__TouchAreaCallback2

	thumb_func_start VSConnectionMenu__TouchAreaCallback1
VSConnectionMenu__TouchAreaCallback1: // 0x0216AF30
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r0, _0216AFDC // =VSConnectionMenu__Singleton
	mov r5, r2
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r6, r0
	mov r0, #1
	mov r4, r6
	ldr r1, [r7, #0]
	lsl r0, r0, #0x12
	add r4, #0x40
	cmp r1, r0
	beq _0216AF56
	lsl r0, r0, #4
	cmp r1, r0
	beq _0216AFAE
	pop {r3, r4, r5, r6, r7, pc}
_0216AF56:
	sub r0, r5, r4
	mov r1, #0x64
	bl _s32_div_f
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	mov r1, #0x64
	mul r1, r0
	add r1, r6, r1
	ldr r1, [r1, #0x40]
	cmp r1, #1
	bne _0216AFD8
	ldr r1, _0216AFE0 // =0x00000708
	ldrh r1, [r4, r1]
	cmp r1, r0
	bne _0216AFD8
	mov r0, #0
	bl PlaySysMenuNavSfx
	ldr r0, _0216AFE0 // =0x00000708
	ldrh r1, [r4, r0]
	mov r0, #0x64
	mul r0, r1
	add r0, r4, r0
	ldr r0, [r0, #8]
	cmp r0, #0
	bne _0216AF94
	mov r0, #0x11
	bl VSMenu__Func_21667F0
	b _0216AF9A
_0216AF94:
	mov r0, #0x12
	bl VSMenu__Func_21667F0
_0216AF9A:
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	ldr r0, _0216AFDC // =VSConnectionMenu__Singleton
	ldr r1, _0216AFE4 // =VSConnectionMenu__Main_216BBAC
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r3, r4, r5, r6, r7, pc}
_0216AFAE:
	sub r0, r5, r4
	mov r1, #0x64
	bl _s32_div_f
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	mov r0, #0x64
	mul r0, r5
	add r0, r6, r0
	ldr r0, [r0, #0x40]
	cmp r0, #1
	bne _0216AFD8
	ldr r0, _0216AFE0 // =0x00000708
	ldrh r0, [r4, r0]
	cmp r0, r5
	beq _0216AFD8
	mov r0, #2
	bl PlaySysMenuNavSfx
	ldr r0, _0216AFE0 // =0x00000708
	strh r5, [r4, r0]
_0216AFD8:
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0216AFDC: .word VSConnectionMenu__Singleton
_0216AFE0: .word 0x00000708
_0216AFE4: .word VSConnectionMenu__Main_216BBAC
	thumb_func_end VSConnectionMenu__TouchAreaCallback1

	thumb_func_start VSConnectionMenu__Func_216AFE8
VSConnectionMenu__Func_216AFE8: // 0x0216AFE8
	push {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r1
	mov r6, r2
	cmp r5, #5
	bne _0216AFFE
	ldr r0, _0216B00C // =VSConnectionMenu__Singleton
	ldr r1, _0216B010 // =VSConnectionMenu__Main_216B014
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
_0216AFFE:
	mov r0, r5
	mov r1, r4
	mov r2, r6
	bl Task__Unknown204BE48__Func_204BF20
	pop {r4, r5, r6, pc}
	nop
_0216B00C: .word VSConnectionMenu__Singleton
_0216B010: .word VSConnectionMenu__Main_216B014
	thumb_func_end VSConnectionMenu__Func_216AFE8

	thumb_func_start VSConnectionMenu__Main_216B014
VSConnectionMenu__Main_216B014: // 0x0216B014
	push {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	mov r6, r0
	bl VSState__NotLoaded
	cmp r0, #0
	beq _0216B0E0
	mov r4, r6
	mov r0, #0x32
	add r4, #0x40
	lsl r0, r0, #4
	beq _0216B044
	mov r7, #0
	add r5, r4, r0
_0216B032:
	ldr r0, [r4, #0x60]
	cmp r0, #0
	beq _0216B03E
	bl DestroyTask
	str r7, [r4, #0x60]
_0216B03E:
	add r4, #0x64
	cmp r4, r5
	bne _0216B032
_0216B044:
	mov r0, r6
	add r0, #8
	bl VSConnectionMenu__Unknown__Release
	ldr r0, [r6, #4]
	bl DestroyTask
	ldr r0, [r6, #0]
	ldr r1, [r0, #0xc]
	cmp r1, #9
	bhi _0216B0DA
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add pc, r1
_0216B066: // jump table
	.hword _0216B0DA - _0216B066 - 2 // case 0
	.hword _0216B0DA - _0216B066 - 2 // case 1
	.hword _0216B0DA - _0216B066 - 2 // case 2
	.hword _0216B0DA - _0216B066 - 2 // case 3
	.hword _0216B0DA - _0216B066 - 2 // case 4
	.hword _0216B0DA - _0216B066 - 2 // case 5
	.hword _0216B07A - _0216B066 - 2 // case 6
	.hword _0216B080 - _0216B066 - 2 // case 7
	.hword _0216B0D0 - _0216B066 - 2 // case 8
	.hword _0216B0D6 - _0216B066 - 2 // case 9
_0216B07A:
	mov r1, #1
	str r1, [r0, #0xc]
	b _0216B0DA
_0216B080:
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bgt _0216B08C
	beq _0216B0C0
	b _0216B0DA
_0216B08C:
	sub r0, #0x11
	cmp r0, #8
	bhi _0216B0DA
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0216B09E: // jump table
	.hword _0216B0B0 - _0216B09E - 2 // case 0
	.hword _0216B0B8 - _0216B09E - 2 // case 1
	.hword _0216B0DA - _0216B09E - 2 // case 2
	.hword _0216B0DA - _0216B09E - 2 // case 3
	.hword _0216B0B8 - _0216B09E - 2 // case 4
	.hword _0216B0B0 - _0216B09E - 2 // case 5
	.hword _0216B0DA - _0216B09E - 2 // case 6
	.hword _0216B0DA - _0216B09E - 2 // case 7
	.hword _0216B0C8 - _0216B09E - 2 // case 8
_0216B0B0:
	ldr r0, [r6, #0]
	mov r1, #2
	str r1, [r0, #0xc]
	b _0216B0DA
_0216B0B8:
	ldr r0, _0216B0EC // =VSConnectionMenu__Main_216B0F0
	bl SetCurrentTaskMainEvent
	pop {r3, r4, r5, r6, r7, pc}
_0216B0C0:
	ldr r0, [r6, #0]
	mov r1, #3
	str r1, [r0, #0xc]
	b _0216B0DA
_0216B0C8:
	ldr r0, [r6, #0]
	mov r1, #4
	str r1, [r0, #0xc]
	b _0216B0DA
_0216B0D0:
	mov r1, #3
	str r1, [r0, #0xc]
	b _0216B0DA
_0216B0D6:
	mov r1, #4
	str r1, [r0, #0xc]
_0216B0DA:
	bl DestroyCurrentTask
	pop {r3, r4, r5, r6, r7, pc}
_0216B0E0:
	bl VSState__ProcessAnimations
	bl VSState__Draw
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0216B0EC: .word VSConnectionMenu__Main_216B0F0
	thumb_func_end VSConnectionMenu__Main_216B014

	thumb_func_start VSConnectionMenu__Main_216B0F0
VSConnectionMenu__Main_216B0F0: // 0x0216B0F0
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bgt _0216B104
	beq _0216B124
	pop {r4, pc}
_0216B104:
	cmp r0, #0x19
	bgt _0216B132
	cmp r0, #0x15
	blt _0216B132
	beq _0216B132
	cmp r0, #0x16
	beq _0216B118
	cmp r0, #0x19
	beq _0216B12C
	pop {r4, pc}
_0216B118:
	ldr r0, [r4, #0]
	mov r1, #2
	str r1, [r0, #0xc]
	bl DestroyCurrentTask
	pop {r4, pc}
_0216B124:
	mov r0, #2
	bl VSConnectionMenu__Func_216AD1C
	pop {r4, pc}
_0216B12C:
	mov r0, #3
	bl VSConnectionMenu__Func_216AD1C
_0216B132:
	pop {r4, pc}
	thumb_func_end VSConnectionMenu__Main_216B0F0

	thumb_func_start VSConnectionMenu__Main1
VSConnectionMenu__Main1: // 0x0216B134
	push {r3, lr}
	bl GetCurrentTaskWork_
	bl VSState__ProcessAnimations
	bl VSState__Draw
	pop {r3, pc}
	thumb_func_end VSConnectionMenu__Main1

	thumb_func_start VSConnectionMenu__Main_216B144
VSConnectionMenu__Main_216B144: // 0x0216B144
	push {r4, lr}
	sub sp, #8
	bl GetCurrentTaskWork_
	bl VSState__ProcessAnimations
	bl VSState__Draw
	bl MultibootManager__Func_2060CC8
	cmp r0, #2
	bgt _0216B16C
	cmp r0, #0
	blt _0216B186
	beq _0216B172
	cmp r0, #1
	beq _0216B186
	cmp r0, #2
	beq _0216B194
	b _0216B186
_0216B16C:
	cmp r0, #0x19
	beq _0216B17C
	b _0216B186
_0216B172:
	mov r0, #2
	bl VSConnectionMenu__Func_216AD1C
	add sp, #8
	pop {r4, pc}
_0216B17C:
	mov r0, #3
	bl VSConnectionMenu__Func_216AD1C
	add sp, #8
	pop {r4, pc}
_0216B186:
	ldr r0, _0216B1F0 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	tst r0, r1
	bne _0216B1E0
	add sp, #8
	pop {r4, pc}
_0216B194:
	mov r0, #2
	bl PlaySysMenuNavSfx
	mov r0, #1
	mov r1, #2
	mov r2, #0
	bl VSState__Func_2163784
	bl MultibootManager__Func_2060D4C
	mov r4, r0
	bl MultibootManager__Func_2060D74
	mov r2, r0
	mov r0, #1
	mov r1, r4
	mov r3, #0
	bl VSState__SetPlayerInfoEx
	ldr r0, _0216B1F4 // =VSConnectionMenu__TouchCallback_None
	mov r1, #0
	bl VSMenu__SetTouchCallback
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #0xb
	bl SaveSpriteButton__Func_2064588
	ldr r0, _0216B1F8 // =VSConnectionMenu__Main_216B1FC
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r4, pc}
_0216B1E0:
	mov r0, #1
	bl PlaySysMenuNavSfx
	mov r0, #1
	bl VSConnectionMenu__Func_216AD1C
	add sp, #8
	pop {r4, pc}
	.align 2, 0
_0216B1F0: .word padInput
_0216B1F4: .word VSConnectionMenu__TouchCallback_None
_0216B1F8: .word VSConnectionMenu__Main_216B1FC
	thumb_func_end VSConnectionMenu__Main_216B144

	thumb_func_start VSConnectionMenu__Main_216B1FC
VSConnectionMenu__Main_216B1FC: // 0x0216B1FC
	push {r4, lr}
	bl GetCurrentTaskWork_
	ldr r0, [r0, #0]
	ldrh r4, [r0, #0x10]
	bl VSState__ProcessAnimations
	bl VSState__Draw
	bl MultibootManager__Func_2060CC8
	cmp r0, #2
	bgt _0216B224
	cmp r0, #0
	blt _0216B23A
	beq _0216B22A
	cmp r0, #1
	beq _0216B29E
	cmp r0, #2
	b _0216B23A
_0216B224:
	cmp r0, #0x19
	beq _0216B232
	b _0216B23A
_0216B22A:
	mov r0, #2
	bl VSConnectionMenu__Func_216AD1C
	pop {r4, pc}
_0216B232:
	mov r0, #3
	bl VSConnectionMenu__Func_216AD1C
	pop {r4, pc}
_0216B23A:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216B25A
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	beq _0216B292
_0216B25A:
	bl MultibootManager__Func_2061C20
	cmp r0, #0
	bne _0216B288
	ldr r0, _0216B2F0 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	tst r0, r1
	bne _0216B278
	bl VSMenu__GetUnknownTouchResponseFlags
	mov r1, #1
	lsl r1, r1, #0x12
	tst r0, r1
	beq _0216B27E
_0216B278:
	bl MultibootManager__Func_2060ECC
	b _0216B29E
_0216B27E:
	ldr r0, _0216B2F4 // =VSConnectionMenu__TouchCallback_None
	mov r1, #0
	bl VSMenu__SetTouchCallback
	pop {r4, pc}
_0216B288:
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	pop {r4, pc}
_0216B292:
	bl MultibootManager__Func_2060E78
	ldr r0, _0216B2F8 // =VSConnectionMenu__Main_216B304
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216B29E:
	mov r0, #1
	bl PlaySysMenuNavSfx
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064614
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	bne _0216B2CC
_0216B2B8:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216B2B8
_0216B2CC:
	mov r0, #1
	mov r1, r0
	mov r2, #0
	bl VSState__Func_2163784
	mov r1, #0
	mov r0, #1
	mov r2, r1
	bl VSState__SetPlayerInfo_
	ldr r0, _0216B2FC // =VSConnectionMenu__TouchCallback_3
	mov r1, r4
	bl VSMenu__SetTouchCallback
	ldr r0, _0216B300 // =VSConnectionMenu__Main_216B144
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_0216B2F0: .word padInput
_0216B2F4: .word VSConnectionMenu__TouchCallback_None
_0216B2F8: .word VSConnectionMenu__Main_216B304
_0216B2FC: .word VSConnectionMenu__TouchCallback_3
_0216B300: .word VSConnectionMenu__Main_216B144
	thumb_func_end VSConnectionMenu__Main_216B1FC

	thumb_func_start VSConnectionMenu__Main_216B304
VSConnectionMenu__Main_216B304: // 0x0216B304
	push {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0]
	ldrh r5, [r0, #0x10]
	bl VSState__ProcessAnimations
	bl VSState__Draw
	mov r6, #0x75
	lsl r6, r6, #4
	mov r1, #0
	add r0, r4, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, r6
	bl AnimatorSprite__DrawFrame
	mov r0, r6
	add r0, #0x64
	add r4, r4, r0
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x2c
	strh r0, [r4, #8]
	mov r0, #0x61
	strh r0, [r4, #0xa]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r0, #0xd4
	strh r0, [r4, #8]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	bl MultibootManager__Func_2060CC8
	cmp r0, #0xc
	bgt _0216B376
	bge _0216B3BE
	cmp r0, #3
	bhi _0216B38C
	add r1, r0, r0
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add pc, r1
_0216B36E: // jump table
	.hword _0216B37C - _0216B36E - 2 // case 0
	.hword _0216B3F2 - _0216B36E - 2 // case 1
	.hword _0216B3F2 - _0216B36E - 2 // case 2
	.hword _0216B38C - _0216B36E - 2 // case 3
_0216B376:
	cmp r0, #0x19
	beq _0216B384
	b _0216B38C
_0216B37C:
	mov r0, #2
	bl VSConnectionMenu__Func_216AD1C
	pop {r4, r5, r6, pc}
_0216B384:
	mov r0, #3
	bl VSConnectionMenu__Func_216AD1C
	pop {r4, r5, r6, pc}
_0216B38C:
	bl MultibootManager__Func_2061C20
	cmp r0, #0
	bne _0216B3B4
	ldr r0, _0216B420 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	tst r0, r1
	bne _0216B3F2
	bl VSMenu__GetUnknownTouchResponseFlags
	mov r1, #1
	lsl r1, r1, #0x12
	tst r0, r1
	bne _0216B3F2
	ldr r0, _0216B424 // =VSConnectionMenu__TouchCallback_None
	mov r1, #0
	bl VSMenu__SetTouchCallback
	pop {r4, r5, r6, pc}
_0216B3B4:
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	pop {r4, r5, r6, pc}
_0216B3BE:
	mov r0, #0
	mov r1, r0
	mov r2, r0
	bl VSState__Func_2163784
	mov r1, #0
	mov r0, #1
	mov r2, r1
	bl VSState__Func_2163784
	ldr r0, _0216B428 // =VSConnectionMenu__Main_216B434
	bl SetCurrentTaskMainEvent
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	mov r0, #0xc
	bl FadeSysTrack
	pop {r4, r5, r6, pc}
_0216B3F2:
	mov r0, #1
	bl PlaySysMenuNavSfx
	bl MultibootManager__Func_2060ECC
	mov r0, #1
	mov r1, r0
	mov r2, #0
	bl VSState__Func_2163784
	mov r1, #0
	mov r0, #1
	mov r2, r1
	bl VSState__SetPlayerInfo_
	ldr r0, _0216B42C // =VSConnectionMenu__TouchCallback_3
	mov r1, r5
	bl VSMenu__SetTouchCallback
	ldr r0, _0216B430 // =VSConnectionMenu__Main_216B144
	bl SetCurrentTaskMainEvent
	pop {r4, r5, r6, pc}
	.align 2, 0
_0216B420: .word padInput
_0216B424: .word VSConnectionMenu__TouchCallback_None
_0216B428: .word VSConnectionMenu__Main_216B434
_0216B42C: .word VSConnectionMenu__TouchCallback_3
_0216B430: .word VSConnectionMenu__Main_216B144
	thumb_func_end VSConnectionMenu__Main_216B304

	thumb_func_start VSConnectionMenu__Main_216B434
VSConnectionMenu__Main_216B434: // 0x0216B434
	push {r3, lr}
	bl GetCurrentTaskWork_
	bl VSState__ProcessAnimations
	bl VSState__Draw
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _0216B454
	bl DestroyDrawFadeTask
	mov r0, #0
	bl VSConnectionMenu__Func_216AD1C
_0216B454:
	pop {r3, pc}
	.align 2, 0
	thumb_func_end VSConnectionMenu__Main_216B434

	thumb_func_start VSConnectionMenu__Main2
VSConnectionMenu__Main2: // 0x0216B458
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x28
	bl GetCurrentTaskWork_
	mov r4, r0
	add r4, #0x40
	str r0, [sp, #0x1c]
	ldr r2, _0216B67C // =0x0000070C
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	ldr r1, _0216B680 // =0x0400100C
	mov r0, #0x43
	ldrh r2, [r1, #0]
	and r2, r0
	ldr r0, _0216B684 // =0x00000704
	orr r0, r2
	strh r0, [r1]
	ldr r0, _0216B688 // =renderCoreGFXControlB
	mov r2, #0
	strh r2, [r0, #6]
	ldrh r3, [r0, #6]
	sub r1, #0xc
	strh r3, [r0, #4]
	ldr r3, [r1, #0]
	mov r0, #0x1f
	lsl r0, r0, #8
	and r0, r3
	ldr r5, [r1, #0]
	ldr r3, _0216B68C // =0xFFFFE0FF
	lsr r0, r0, #8
	and r5, r3
	mov r3, #4
	bic r0, r3
	lsl r0, r0, #8
	orr r0, r5
	str r0, [r1]
	ldr r0, [sp, #0x1c]
	mov r5, #0x32
	ldr r0, [r0, #0]
	mov r1, #1
	ldr r0, [r0, #0]
	lsl r5, r5, #4
	str r0, [sp, #0x24]
	bl SpriteUnknown__Func_204C3CC
	mov r1, #1
	str r1, [sp]
	str r0, [sp, #4]
	str r1, [sp, #8]
	mov r0, #3
	str r0, [sp, #0xc]
	mov r0, #0x1f
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x24]
	ldr r3, _0216B690 // =0x00000804
	add r0, r4, r5
	mov r2, #0
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #1
	ldr r0, [sp, #0x24]
	mov r2, r1
	add r5, #0x64
	bl SpriteUnknown__Func_204C3CC
	mov r2, #1
	str r2, [sp]
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	mov r0, #3
	str r0, [sp, #0xc]
	mov r0, #0x1f
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x24]
	ldr r3, _0216B690 // =0x00000804
	add r0, r4, r5
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r5, #0xfa
	ldr r0, [sp, #0x24]
	mov r1, #1
	mov r2, #2
	lsl r5, r5, #2
	bl SpriteUnknown__Func_204C3CC
	mov r1, #1
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #3
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, #0x1f
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x24]
	ldr r3, _0216B690 // =0x00000804
	add r0, r4, r5
	mov r2, #2
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x24]
	mov r1, #1
	mov r2, #4
	add r5, #0x64
	bl SpriteUnknown__Func_204C3CC
	mov r1, #1
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #8
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #0x1e
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x24]
	ldr r3, _0216B694 // =0x00000805
	add r0, r4, r5
	mov r2, #4
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r5, #0x4b
	ldr r0, [sp, #0x24]
	mov r1, #1
	mov r2, #5
	lsl r5, r5, #4
	bl SpriteUnknown__Func_204C3CC
	mov r1, #1
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #9
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #0x1e
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x24]
	ldr r3, _0216B690 // =0x00000804
	add r0, r4, r5
	mov r2, #5
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, _0216B698 // =0x000006A4
	mov r1, #1
	add r5, r4, r0
	ldr r0, [sp, #0x24]
	mov r2, #3
	bl SpriteUnknown__Func_204C3CC
	mov r1, #1
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x24]
	ldr r3, _0216B690 // =0x00000804
	mov r0, r5
	mov r2, #3
	bl SpriteUnknown__Func_204C90C
	ldr r1, [r5, #0x3c]
	mov r0, #1
	orr r0, r1
	mov r1, #0
	str r0, [r5, #0x3c]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x1c]
	mov r2, #0
	ldr r0, [r0, #0]
	add r1, sp, #0x24
	ldr r0, [r0, #8]
	mov r3, r2
	bl StageClear__LoadFiles
	ldr r0, _0216B69C // =0x0000044C
	mov r5, #0
	add r0, r4, r0
	mov r6, r5
	str r0, [sp, #0x20]
_0216B604:
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r7, r0, #0x10
	mov r4, r6
	ldr r0, [sp, #0x24]
	mov r1, #1
	mov r2, r7
	add r4, #0xc8
	bl SpriteUnknown__Func_204C3CC
	mov r1, #1
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0xa
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #0x1e
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x20]
	ldr r1, [sp, #0x24]
	ldr r3, _0216B690 // =0x00000804
	add r0, r0, r4
	mov r2, r7
	bl SpriteUnknown__Func_204C90C
	ldr r0, [sp, #0x20]
	mov r1, #0
	add r0, r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r5, r5, #1
	add r6, #0x64
	cmp r5, #4
	blo _0216B604
	bl VSMenu__GetFontWindow
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	mov r3, #2
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	mov r4, #0x1e
	str r4, [sp, #0x10]
	mov r4, #0x17
	str r4, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r0, [sp, #0x1c]
	add r0, #8
	str r0, [sp, #0x1c]
	bl VSConnectionMenu__Unknown__Setup
	ldr r0, _0216B6A0 // =VSConnectionMenu__Main_216B6A4
	bl SetCurrentTaskMainEvent
	add sp, #0x28
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216B67C: .word 0x0000070C
_0216B680: .word 0x0400100C
_0216B684: .word 0x00000704
_0216B688: .word renderCoreGFXControlB
_0216B68C: .word 0xFFFFE0FF
_0216B690: .word 0x00000804
_0216B694: .word 0x00000805
_0216B698: .word 0x000006A4
_0216B69C: .word 0x0000044C
_0216B6A0: .word VSConnectionMenu__Main_216B6A4
	thumb_func_end VSConnectionMenu__Main2

	thumb_func_start VSConnectionMenu__Main_216B6A4
VSConnectionMenu__Main_216B6A4: // 0x0216B6A4
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x38
	bl GetCurrentTaskWork_
	ldr r1, _0216B7E4 // =ovl03_0217E09C
	str r0, [sp, #0x2c]
	str r0, [sp, #0x28]
	add r0, #0x40
	str r0, [sp, #0x28]
	ldrh r2, [r1, #0]
	add r0, sp, #0x30
	strh r2, [r0]
	ldrh r2, [r1, #2]
	strh r2, [r0, #2]
	ldrh r2, [r1, #4]
	ldrh r1, [r1, #6]
	strh r2, [r0, #4]
	strh r1, [r0, #6]
	bl VSState__ProcessAnimations
	bl VSState__Draw
	ldr r1, _0216B7E8 // =0x0000070A
	ldr r0, [sp, #0x28]
	mov r2, #0
	strh r2, [r0, r1]
	bl VSMenu__GetUnknownTouchField
	mov r7, r0
	mov r0, #0x32
	ldr r5, [sp, #0x28]
	lsl r0, r0, #4
	beq _0216B71C
	mov r1, r0
	mov r0, r5
	mov r4, #0
	add r6, r0, r1
_0216B6EE:
	strh r4, [r5, #4]
	mov r0, #2
	strh r0, [r5, #6]
	ldr r0, _0216B7EC // =VSConnectionMenu__TouchAreaCallback1
	str r4, [r5]
	str r0, [sp]
	mov r0, r5
	ldr r2, _0216B7F0 // =TouchField__PointInRect
	add r0, #0x28
	mov r1, r4
	add r3, sp, #0x30
	str r5, [sp, #4]
	bl TouchField__InitAreaShape
	mov r1, r5
	mov r0, r7
	add r1, #0x28
	mov r2, #0
	bl TouchField__AddArea
	add r5, #0x64
	cmp r5, r6
	bne _0216B6EE
_0216B71C:
	mov r0, #0
	ldr r4, [sp, #0x28]
	str r0, [sp, #0x24]
	mov r6, #0xde
	mov r5, r0
	mov r7, #0x1e
_0216B728:
	mov r1, r4
	mov r3, r4
	add r1, #0x4c
	mov r0, #0x18
	strh r0, [r1]
	add r3, #0x4c
	lsl r0, r5, #0x10
	strh r6, [r3, #2]
	lsr r0, r0, #0x10
	str r0, [sp]
	mov r0, #0x12
	str r0, [sp, #4]
	ldr r0, _0216B7F4 // =Task__Unknown204BE48__LerpValue
	mov r1, #2
	str r0, [sp, #8]
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, #0x61
	str r0, [sp, #0x1c]
	mov r0, #0
	str r0, [sp, #0x20]
	mov r2, r1
	ldrsh r2, [r3, r2]
	add r0, r3, #2
	mov r3, r7
	bl Task__Unknown204BE48__Create
	ldr r0, [sp, #0x24]
	add r4, #0x64
	add r0, r0, #1
	add r6, #0x10
	add r5, r5, #2
	add r7, #0x10
	str r0, [sp, #0x24]
	cmp r0, #7
	blt _0216B728
	mov r2, r0
	mov r1, #0x64
	mul r2, r1
	ldr r0, [sp, #0x28]
	mov r1, #0x18
	add r5, r0, r2
	add r0, r0, r2
	add r0, #0x4c
	strh r1, [r0]
	ldr r0, [sp, #0x24]
	add r5, #0x4c
	lsl r4, r0, #4
	mov r0, r4
	add r0, #0xde
	strh r0, [r5, #2]
	bl GetCurrentTask
	ldr r1, [sp, #0x24]
	add r4, #0x1e
	lsl r1, r1, #0x11
	lsr r1, r1, #0x10
	str r1, [sp]
	mov r1, #0x12
	str r1, [sp, #4]
	ldr r1, _0216B7F4 // =Task__Unknown204BE48__LerpValue
	mov r3, r4
	str r1, [sp, #8]
	mov r1, #1
	lsl r1, r1, #0xc
	str r1, [sp, #0xc]
	ldr r1, _0216B7F8 // =VSConnectionMenu__TouchAreaCallback2
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r1, #0
	str r1, [sp, #0x18]
	mov r0, #0x61
	str r0, [sp, #0x1c]
	str r1, [sp, #0x20]
	mov r1, #2
	ldrsh r2, [r5, r1]
	add r0, r5, #2
	bl Task__Unknown204BE48__Create
	ldr r0, _0216B7FC // =VSConnectionMenu__Main_216B804
	bl SetCurrentTaskMainEvent
	ldr r0, [sp, #0x2c]
	ldr r1, _0216B800 // =VSConnectionMenu__Main_216BEE8
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	add sp, #0x38
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216B7E4: .word ovl03_0217E09C
_0216B7E8: .word 0x0000070A
_0216B7EC: .word VSConnectionMenu__TouchAreaCallback1
_0216B7F0: .word TouchField__PointInRect
_0216B7F4: .word Task__Unknown204BE48__LerpValue
_0216B7F8: .word VSConnectionMenu__TouchAreaCallback2
_0216B7FC: .word VSConnectionMenu__Main_216B804
_0216B800: .word VSConnectionMenu__Main_216BEE8
	thumb_func_end VSConnectionMenu__Main_216B6A4

	thumb_func_start VSConnectionMenu__Main_216B804
VSConnectionMenu__Main_216B804: // 0x0216B804
	push {r3, lr}
	bl VSState__ProcessAnimations
	bl VSState__Draw
	pop {r3, pc}
	thumb_func_end VSConnectionMenu__Main_216B804

	thumb_func_start VSConnectionMenu__Main_216B810
VSConnectionMenu__Main_216B810: // 0x0216B810
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x28
	bl GetCurrentTaskWork_
	mov r5, r0
	str r0, [sp, #0x14]
	add r5, #0x40
	bl VSState__ProcessAnimations
	bl VSState__Draw
	ldr r0, _0216B9D0 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	tst r0, r1
	bne _0216B83C
	bl VSMenu__GetUnknownTouchResponseFlags
	mov r1, #1
	lsl r1, r1, #0x12
	tst r0, r1
	beq _0216B83E
_0216B83C:
	b _0216B98C
_0216B83E:
	bl MultibootManager__Func_2060FA0
	mov r0, #0x32
	mov r2, r5
	lsl r0, r0, #4
	beq _0216B856
	mov r1, #0
	add r0, r5, r0
_0216B84E:
	str r1, [r2]
	add r2, #0x64
	cmp r2, r0
	bne _0216B84E
_0216B856:
	bl MultibootManager__Func_206107C
	ldr r1, _0216B9D4 // =0x0000070A
	strh r0, [r5, r1]
	ldrh r2, [r5, r1]
	cmp r2, #0
	beq _0216B958
	sub r0, r1, #2
	ldrh r0, [r5, r0]
	cmp r0, r2
	blo _0216B872
	sub r2, r2, #1
	sub r0, r1, #2
	strh r2, [r5, r0]
_0216B872:
	mov r0, #0x6e
	lsl r0, r0, #4
	ldr r2, [r5, r0]
	mov r1, #1
	bic r2, r1
	str r2, [r5, r0]
	ldr r2, _0216B9D8 // =0x00000488
	ldr r0, [r5, r2]
	bic r0, r1
	str r0, [r5, r2]
	mov r0, r2
	add r0, #0x64
	ldr r0, [r5, r0]
	add r2, #0x64
	bic r0, r1
	str r0, [r5, r2]
	ldr r0, [sp, #0x14]
	add r0, #0xc
	bl Unknown2056570__Func_205683C
	ldr r0, _0216B9D4 // =0x0000070A
	mov r4, #0
	ldrh r0, [r5, r0]
	cmp r0, #0
	bls _0216B97A
	ldr r0, [sp, #0x14]
	str r0, [sp, #0x20]
	add r0, #8
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x14]
	str r0, [sp, #0x24]
	add r0, #0xc
	str r0, [sp, #0x24]
_0216B8B4:
	mov r0, #0x64
	mul r0, r4
	add r7, r5, r0
	str r0, [sp, #0x18]
	mov r6, r7
	mov r0, r4
	add r6, #0x10
	bl MultibootManager__Func_20610F8
	str r0, [sp, #0x1c]
	mov r0, r4
	bl MultibootManager__Func_20610BC
	ldr r2, [sp, #0x1c]
	mov r1, r6
	lsl r2, r2, #1
	bl MIi_CpuCopy16
	ldr r0, [sp, #0x1c]
	lsl r1, r0, #1
	mov r0, #0
	strh r0, [r6, r1]
	mov r0, r4
	bl MultibootManager__Func_2061194
	strh r0, [r7, #4]
	mov r0, r4
	bl MultibootManager__Func_206112C
	str r0, [r7, #8]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0216B9DC // =aD_8
	lsl r7, r4, #4
	add r7, #0xe
	str r0, [sp, #0xc]
	add r0, r4, #1
	str r0, [sp, #0x10]
	lsl r3, r7, #0x10
	ldr r0, [sp, #0x20]
	mov r1, #8
	mov r2, #0x18
	asr r3, r3, #0x10
	bl VSConnectionMenu__Unknown__Func_216A908
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0216B9E0 // =aS_12
	lsl r3, r7, #0x10
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x20]
	mov r1, #0
	mov r2, #0x28
	asr r3, r3, #0x10
	str r6, [sp, #0x10]
	bl VSConnectionMenu__Unknown__Func_216A908
	ldr r0, [sp, #0x18]
	mov r1, #1
	str r1, [r5, r0]
	ldr r0, [sp, #0x24]
	bl Unknown2056570__Func_2056A94
	ldr r0, [sp, #0x20]
	mov r1, #1
	bl VSConnectionMenu__Unknown__Func_216A948
	mov r0, #0xa
	bl VSMenu__SetNetworkMessageSequence
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	ldr r0, _0216B9D4 // =0x0000070A
	ldrh r0, [r5, r0]
	cmp r4, r0
	blo _0216B8B4
	b _0216B97A
_0216B958:
	ldr r0, [sp, #0x14]
	mov r1, #0
	add r0, #8
	bl VSConnectionMenu__Unknown__Func_216A948
	mov r1, #0x6e
	lsl r1, r1, #4
	ldr r2, [r5, r1]
	mov r0, #1
	orr r0, r2
	str r0, [r5, r1]
	mov r0, #0
	add r1, #0x28
	strh r0, [r5, r1]
	mov r0, #9
	bl VSMenu__SetNetworkMessageSequence
_0216B97A:
	ldr r1, _0216B9E4 // =0x0000074C
	ldr r0, [sp, #0x14]
	mov r2, #0
	str r2, [r0, r1]
	ldr r0, _0216B9E8 // =VSConnectionMenu__Main_216B9EC
	bl SetCurrentTaskMainEvent
	add sp, #0x28
	pop {r3, r4, r5, r6, r7, pc}
_0216B98C:
	mov r0, #1
	bl PlaySysMenuNavSfx
	ldr r2, _0216B9D8 // =0x00000488
	mov r1, #1
	ldr r0, [r5, r2]
	orr r0, r1
	str r0, [r5, r2]
	mov r0, r2
	add r0, #0x64
	ldr r0, [r5, r0]
	add r2, #0x64
	orr r0, r1
	str r0, [r5, r2]
	bl VSMenu__GetUnknownTouchField
	mov r6, r0
	mov r0, #0x32
	lsl r0, r0, #4
	beq _0216B9C6
	add r4, r5, r0
_0216B9B6:
	mov r1, r5
	mov r0, r6
	add r1, #0x28
	bl TouchField__RemoveArea
	add r5, #0x64
	cmp r5, r4
	bne _0216B9B6
_0216B9C6:
	mov r0, #1
	bl VSConnectionMenu__Func_216AD1C
	add sp, #0x28
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216B9D0: .word padInput
_0216B9D4: .word 0x0000070A
_0216B9D8: .word 0x00000488
_0216B9DC: .word aD_8
_0216B9E0: .word aS_12
_0216B9E4: .word 0x0000074C
_0216B9E8: .word VSConnectionMenu__Main_216B9EC
	thumb_func_end VSConnectionMenu__Main_216B810

	thumb_func_start VSConnectionMenu__Main_216B9EC
VSConnectionMenu__Main_216B9EC: // 0x0216B9EC
	push {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r5, r4
	add r5, #0x40
	bl VSState__ProcessAnimations
	bl VSState__Draw
	ldr r0, _0216BB84 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	tst r0, r1
	bne _0216BA16
	bl VSMenu__GetUnknownTouchResponseFlags
	mov r1, #1
	lsl r1, r1, #0x12
	tst r0, r1
	beq _0216BA18
_0216BA16:
	b _0216BB40
_0216BA18:
	ldr r0, _0216BB88 // =0x0000074C
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
	ldr r0, [r4, r0]
	cmp r0, #4
	blo _0216BA30
	bl MultibootManager__Func_2060FA0
	ldr r0, _0216BB88 // =0x0000074C
	mov r1, #0
	str r1, [r4, r0]
_0216BA30:
	ldr r0, _0216BB8C // =0x0000070A
	ldrh r6, [r5, r0]
	bl MultibootManager__Func_206107C
	cmp r6, r0
	beq _0216BA4A
	mov r0, #2
	bl PlaySysMenuNavSfx
	ldr r0, _0216BB90 // =VSConnectionMenu__Main_216B810
	bl SetCurrentTaskMainEvent
	pop {r3, r4, r5, r6, r7, pc}
_0216BA4A:
	mov r4, #0
	cmp r6, #0
	bls _0216BA72
	ldr r7, _0216BB8C // =0x0000070A
	mov r6, r5
_0216BA54:
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	bl MultibootManager__Func_206112C
	str r0, [r6, #8]
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	bl MultibootManager__Func_2061160
	str r0, [r6, #0xc]
	ldrh r0, [r5, r7]
	add r4, r4, #1
	add r6, #0x64
	cmp r4, r0
	blo _0216BA54
_0216BA72:
	bl MultibootManager__Func_206107C
	cmp r0, #0
	bne _0216BA7C
	b _0216BB80
_0216BA7C:
	ldr r0, _0216BB94 // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #1
	tst r0, r1
	bne _0216BAE6
	ldr r0, _0216BB84 // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x40
	tst r0, r1
	beq _0216BABA
	ldr r1, _0216BB98 // =0x00000708
	ldrh r0, [r5, r1]
	sub r0, r0, #1
	strh r0, [r5, r1]
	ldrh r2, [r5, r1]
	ldr r0, _0216BB9C // =0x0000FFFF
	cmp r2, r0
	bne _0216BAA8
	add r0, r1, #2
	ldrh r0, [r5, r0]
	sub r0, r0, #1
	strh r0, [r5, r1]
_0216BAA8:
	ldr r0, _0216BBA0 // =0x000006A4
	mov r1, #3
	add r0, r5, r0
	bl AnimatorSprite__SetAnimation
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0216BAE6
_0216BABA:
	mov r0, #0x80
	tst r0, r1
	beq _0216BAE6
	ldr r1, _0216BB98 // =0x00000708
	ldrh r0, [r5, r1]
	add r0, r0, #1
	strh r0, [r5, r1]
	add r0, r1, #2
	ldrh r2, [r5, r0]
	ldrh r0, [r5, r1]
	cmp r2, r0
	bhi _0216BAD6
	mov r0, #0
	strh r0, [r5, r1]
_0216BAD6:
	ldr r0, _0216BBA0 // =0x000006A4
	mov r1, #3
	add r0, r5, r0
	bl AnimatorSprite__SetAnimation
	mov r0, #2
	bl PlaySysMenuNavSfx
_0216BAE6:
	ldr r0, _0216BB84 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #1
	tst r0, r1
	beq _0216BAFE
	ldr r0, _0216BB98 // =0x00000708
	ldrh r1, [r5, r0]
	add r0, r0, #2
	ldrh r0, [r5, r0]
	cmp r1, r0
	blo _0216BB0C
	pop {r3, r4, r5, r6, r7, pc}
_0216BAFE:
	ldr r0, _0216BBA0 // =0x000006A4
	mov r1, #0
	add r0, r5, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	pop {r3, r4, r5, r6, r7, pc}
_0216BB0C:
	mov r0, #0
	bl PlaySysMenuNavSfx
	ldr r0, _0216BB98 // =0x00000708
	ldrh r1, [r5, r0]
	mov r0, #0x64
	mul r0, r1
	add r0, r5, r0
	ldr r0, [r0, #8]
	cmp r0, #0
	bne _0216BB2A
	mov r0, #0x11
	bl VSMenu__Func_21667F0
	b _0216BB30
_0216BB2A:
	mov r0, #0x12
	bl VSMenu__Func_21667F0
_0216BB30:
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	ldr r0, _0216BBA4 // =VSConnectionMenu__Main_216BBAC
	bl SetCurrentTaskMainEvent
	pop {r3, r4, r5, r6, r7, pc}
_0216BB40:
	mov r0, #1
	bl PlaySysMenuNavSfx
	ldr r2, _0216BBA8 // =0x00000488
	mov r1, #1
	ldr r0, [r5, r2]
	orr r0, r1
	str r0, [r5, r2]
	mov r0, r2
	add r0, #0x64
	ldr r0, [r5, r0]
	add r2, #0x64
	orr r0, r1
	str r0, [r5, r2]
	bl VSMenu__GetUnknownTouchField
	mov r6, r0
	mov r0, #0x32
	lsl r0, r0, #4
	beq _0216BB7A
	add r4, r5, r0
_0216BB6A:
	mov r1, r5
	mov r0, r6
	add r1, #0x28
	bl TouchField__RemoveArea
	add r5, #0x64
	cmp r5, r4
	bne _0216BB6A
_0216BB7A:
	mov r0, #1
	bl VSConnectionMenu__Func_216AD1C
_0216BB80:
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0216BB84: .word padInput
_0216BB88: .word 0x0000074C
_0216BB8C: .word 0x0000070A
_0216BB90: .word VSConnectionMenu__Main_216B810
_0216BB94: .word touchInput
_0216BB98: .word 0x00000708
_0216BB9C: .word 0x0000FFFF
_0216BBA0: .word 0x000006A4
_0216BBA4: .word VSConnectionMenu__Main_216BBAC
_0216BBA8: .word 0x00000488
	thumb_func_end VSConnectionMenu__Main_216B9EC

	thumb_func_start VSConnectionMenu__Main_216BBAC
VSConnectionMenu__Main_216BBAC: // 0x0216BBAC
	ldr r3, _0216BBB0 // =VSConnectionMenu__Main_216BBB4
	bx r3
	.align 2, 0
_0216BBB0: .word VSConnectionMenu__Main_216BBB4
	thumb_func_end VSConnectionMenu__Main_216BBAC

	thumb_func_start VSConnectionMenu__Main_216BBB4
VSConnectionMenu__Main_216BBB4: // 0x0216BBB4
	ldr r3, _0216BBB8 // =VSConnectionMenu__Main_216BBBC
	bx r3
	.align 2, 0
_0216BBB8: .word VSConnectionMenu__Main_216BBBC
	thumb_func_end VSConnectionMenu__Main_216BBB4

	thumb_func_start VSConnectionMenu__Main_216BBBC
VSConnectionMenu__Main_216BBBC: // 0x0216BBBC
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x30
	bl GetCurrentTaskWork_
	str r0, [sp, #0x2c]
	str r0, [sp, #0x28]
	add r0, #0x40
	str r0, [sp, #0x28]
	bl VSMenu__GetUnknownTouchField
	ldr r5, [sp, #0x28]
	str r0, [sp, #0x24]
	mov r4, #0
	mov r7, #0xde
	mov r6, #0x1e
_0216BBDA:
	mov r1, r5
	ldr r0, [sp, #0x24]
	add r1, #0x28
	bl TouchField__RemoveArea
	mov r0, #7
	sub r0, r0, r4
	lsl r0, r0, #0x11
	lsr r0, r0, #0x10
	str r0, [sp]
	mov r0, #0x12
	str r0, [sp, #4]
	ldr r0, _0216BC94 // =Task__Unknown204BE48__LerpValue
	mov r1, #2
	str r0, [sp, #8]
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [sp, #0xc]
	ldr r0, _0216BC98 // =Task__Unknown204BE48__Func_204BF20
	mov r2, r6
	str r0, [sp, #0x10]
	mov r0, r5
	add r0, #0x60
	str r0, [sp, #0x14]
	mov r0, #0
	str r0, [sp, #0x18]
	mov r0, #0x61
	str r0, [sp, #0x1c]
	mov r0, #0
	str r0, [sp, #0x20]
	mov r0, r5
	add r0, #0x4c
	add r0, r0, #2
	mov r3, r7
	bl Task__Unknown204BE48__Create
	str r0, [r5, #0x60]
	add r4, r4, #1
	add r5, #0x64
	add r7, #0x10
	add r6, #0x10
	cmp r4, #8
	blt _0216BBDA
	mov r1, #0x6e
	ldr r0, [sp, #0x28]
	lsl r1, r1, #4
	ldr r2, [r0, r1]
	mov r0, #1
	orr r2, r0
	ldr r0, [sp, #0x28]
	str r2, [r0, r1]
	ldr r0, _0216BC9C // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, [sp, #0x2c]
	mov r1, #0
	add r0, #8
	str r0, [sp, #0x2c]
	bl VSConnectionMenu__Unknown__Func_216A948
	mov r0, #0
	mov r1, r0
	bl VSState__SetCallback
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	mov r0, #0
	bl VSState__InitSprites
	ldr r1, _0216BCA0 // =0x00000708
	ldr r0, [sp, #0x28]
	ldrh r0, [r0, r1]
	bl MultibootManager__Func_20610BC
	mov r4, r0
	ldr r1, _0216BCA0 // =0x00000708
	ldr r0, [sp, #0x28]
	ldrh r0, [r0, r1]
	bl MultibootManager__Func_20610F8
	mov r2, r0
	mov r0, #0
	mov r1, r4
	mov r3, r0
	bl VSState__SetPlayerInfoEx
	ldr r0, _0216BCA4 // =VSConnectionMenu__Main_216BCA8
	bl SetCurrentTaskMainEvent
	add sp, #0x30
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216BC94: .word Task__Unknown204BE48__LerpValue
_0216BC98: .word Task__Unknown204BE48__Func_204BF20
_0216BC9C: .word 0x0000FFFF
_0216BCA0: .word 0x00000708
_0216BCA4: .word VSConnectionMenu__Main_216BCA8
	thumb_func_end VSConnectionMenu__Main_216BBBC

	thumb_func_start VSConnectionMenu__Main_216BCA8
VSConnectionMenu__Main_216BCA8: // 0x0216BCA8
	push {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r5, r4
	add r5, #0x40
	bl VSState__ProcessAnimations
	bl VSState__Draw
	ldr r0, [r5, #0x60]
	cmp r0, #0
	bne _0216BCE2
	ldr r0, _0216BCE4 // =0x00000708
	ldrh r0, [r5, r0]
	bl MultibootManager__Func_20611B0
	ldr r0, _0216BCE8 // =VSConnectionMenu__TouchCallback_None
	mov r1, #0
	bl VSMenu__SetTouchCallback
	ldr r0, _0216BCEC // =0x000007B4
	add r0, r4, r0
	ldrh r1, [r0, #0xc]
	bl AnimatorSprite__SetAnimation
	ldr r0, _0216BCF0 // =VSConnectionMenu__Main_216BCF4
	bl SetCurrentTaskMainEvent
_0216BCE2:
	pop {r3, r4, r5, pc}
	.align 2, 0
_0216BCE4: .word 0x00000708
_0216BCE8: .word VSConnectionMenu__TouchCallback_None
_0216BCEC: .word 0x000007B4
_0216BCF0: .word VSConnectionMenu__Main_216BCF4
	thumb_func_end VSConnectionMenu__Main_216BCA8

	thumb_func_start VSConnectionMenu__Main_216BCF4
VSConnectionMenu__Main_216BCF4: // 0x0216BCF4
	push {r3, r4, r5, lr}
	sub sp, #8
	bl GetCurrentTaskWork_
	mov r4, r0
	bl VSState__ProcessAnimations
	bl VSState__Draw
	mov r5, #0x75
	lsl r5, r5, #4
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, r5
	bl AnimatorSprite__DrawFrame
	mov r0, r5
	add r0, #0x64
	add r4, r4, r0
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x2c
	strh r0, [r4, #8]
	mov r0, #0x61
	strh r0, [r4, #0xa]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r0, #0xd4
	strh r0, [r4, #8]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	bl MultibootManager__Func_2060CC8
	cmp r0, #0xc
	bgt _0216BD5E
	bge _0216BDAE
	cmp r0, #5
	bgt _0216BD78
	cmp r0, #0
	blt _0216BD78
	beq _0216BD64
	cmp r0, #4
	beq _0216BE0E
	cmp r0, #5
	b _0216BD78
_0216BD5E:
	cmp r0, #0x19
	beq _0216BD6E
	b _0216BD78
_0216BD64:
	mov r0, #2
	bl VSConnectionMenu__Func_216AD1C
	add sp, #8
	pop {r3, r4, r5, pc}
_0216BD6E:
	mov r0, #3
	bl VSConnectionMenu__Func_216AD1C
	add sp, #8
	pop {r3, r4, r5, pc}
_0216BD78:
	bl MultibootManager__Func_2061C20
	cmp r0, #0
	bne _0216BDA2
	ldr r0, _0216BE50 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	tst r0, r1
	bne _0216BDE4
	bl VSMenu__GetUnknownTouchResponseFlags
	mov r1, #1
	lsl r1, r1, #0x12
	tst r0, r1
	bne _0216BDE4
	ldr r0, _0216BE54 // =VSConnectionMenu__TouchCallback_None
	mov r1, #0
	bl VSMenu__SetTouchCallback
	add sp, #8
	pop {r3, r4, r5, pc}
_0216BDA2:
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	add sp, #8
	pop {r3, r4, r5, pc}
_0216BDAE:
	mov r0, #0
	mov r1, r0
	mov r2, r0
	bl VSState__Func_2163784
	mov r1, #0
	mov r0, #1
	mov r2, r1
	bl VSState__Func_2163784
	ldr r0, _0216BE58 // =VSConnectionMenu__Main_216BE64
	bl SetCurrentTaskMainEvent
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	mov r0, #0xc
	bl FadeSysTrack
	add sp, #8
	pop {r3, r4, r5, pc}
_0216BDE4:
	mov r0, #1
	bl PlaySysMenuNavSfx
	bl MultibootManager__Func_2061298
	bl VSState__GetFlags
	bl VSState__Func_21630F0
	mov r0, #0xf
	bl VSMenu__Func_21667F0
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	ldr r0, _0216BE5C // =VSConnectionMenu__Main_216B6A4
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, r4, r5, pc}
_0216BE0E:
	mov r0, #0xd
	bl PlaySysSfx
	bl VSState__GetFlags
	bl VSState__Func_21630F0
	mov r0, #0xf
	bl VSMenu__Func_21667F0
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	mov r0, #0x43
	bl VSMenu__SetNetworkMessageSequence
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #0xb
	bl SaveSpriteButton__Func_2064588
	ldr r0, _0216BE60 // =VSConnectionMenu__Main_216BEA4
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, r4, r5, pc}
	nop
_0216BE50: .word padInput
_0216BE54: .word VSConnectionMenu__TouchCallback_None
_0216BE58: .word VSConnectionMenu__Main_216BE64
_0216BE5C: .word VSConnectionMenu__Main_216B6A4
_0216BE60: .word VSConnectionMenu__Main_216BEA4
	thumb_func_end VSConnectionMenu__Main_216BCF4

	thumb_func_start VSConnectionMenu__Main_216BE64
VSConnectionMenu__Main_216BE64: // 0x0216BE64
	push {r3, lr}
	bl GetCurrentTaskWork_
	bl VSState__ProcessAnimations
	bl VSState__Draw
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _0216BE84
	bl DestroyDrawFadeTask
	mov r0, #0
	bl VSConnectionMenu__Func_216AD1C
_0216BE84:
	pop {r3, pc}
	.align 2, 0
	thumb_func_end VSConnectionMenu__Main_216BE64

	thumb_func_start VSConnectionMenu__Main_216BE88
VSConnectionMenu__Main_216BE88: // 0x0216BE88
	push {r4, lr}
	ldr r0, _0216BEA0 // =VSConnectionMenu__Singleton
	ldr r4, [r0, #0]
	mov r0, r4
	bl GetTaskWork_
	mov r0, r4
	mov r1, #0
	bl SetTaskMainEvent
	pop {r4, pc}
	nop
_0216BEA0: .word VSConnectionMenu__Singleton
	thumb_func_end VSConnectionMenu__Main_216BE88

	thumb_func_start VSConnectionMenu__Main_216BEA4
VSConnectionMenu__Main_216BEA4: // 0x0216BEA4
	push {r3, lr}
	ldr r0, _0216BEDC // =VSConnectionMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216BEDA
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	bne _0216BEDA
	ldr r0, _0216BEE0 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, _0216BEE4 // =VSConnectionMenu__Main_216B6A4
	bl SetCurrentTaskMainEvent
_0216BEDA:
	pop {r3, pc}
	.align 2, 0
_0216BEDC: .word VSConnectionMenu__Singleton
_0216BEE0: .word 0x0000FFFF
_0216BEE4: .word VSConnectionMenu__Main_216B6A4
	thumb_func_end VSConnectionMenu__Main_216BEA4

	thumb_func_start VSConnectionMenu__Main_216BEE8
VSConnectionMenu__Main_216BEE8: // 0x0216BEE8
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _0216BFB4 // =VSConnectionMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x32
	add r4, #0x40
	lsl r0, r0, #4
	add r0, r4, r0
	mov r7, #0
	mov r5, r4
	str r0, [sp]
_0216BF02:
	ldr r1, [r5, #0]
	mov r6, r5
	mov r2, r1
	mov r0, #0x64
	mov r1, #0x4c
	mul r2, r0
	ldr r0, [sp]
	ldrsh r1, [r5, r1]
	add r0, r0, r2
	add r6, #0x4c
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r6, r1]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, _0216BFB8 // =0x0000070A
	ldrh r0, [r4, r0]
	cmp r7, r0
	bhs _0216BF88
	ldr r0, [r5, #8]
	cmp r0, #0
	bne _0216BF34
	ldr r0, _0216BFBC // =0x0000044C
	b _0216BF38
_0216BF34:
	mov r0, #0x4b
	lsl r0, r0, #4
_0216BF38:
	mov r1, #0
	ldrsh r1, [r6, r1]
	add r0, r4, r0
	add r1, #0xaa
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r6, r1]
	add r1, #8
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, [r5, #0xc]
	cmp r0, #1
	beq _0216BF6A
	cmp r0, #2
	beq _0216BF64
	cmp r0, #3
	bne _0216BF70
	mov r0, #0x19
	lsl r0, r0, #6
	add r0, r4, r0
	b _0216BF74
_0216BF64:
	ldr r0, _0216BFC0 // =0x000005DC
	add r0, r4, r0
	b _0216BF74
_0216BF6A:
	ldr r0, _0216BFC4 // =0x00000578
	add r0, r4, r0
	b _0216BF74
_0216BF70:
	ldr r0, _0216BFC8 // =0x00000514
	add r0, r4, r0
_0216BF74:
	mov r1, #0
	ldrsh r1, [r6, r1]
	add r1, #0xbe
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r6, r1]
	add r1, #8
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
_0216BF88:
	add r7, r7, #1
	add r5, #0x64
	cmp r7, #8
	blo _0216BF02
	ldr r1, _0216BFCC // =0x000006A4
	add r0, r4, r1
	add r1, #0x64
	ldrh r2, [r4, r1]
	mov r1, #0x64
	mul r1, r2
	add r2, r4, r1
	mov r1, #0x4c
	ldrsh r1, [r2, r1]
	mov r3, r2
	add r3, #0x4c
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r3, r1]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216BFB4: .word VSConnectionMenu__Singleton
_0216BFB8: .word 0x0000070A
_0216BFBC: .word 0x0000044C
_0216BFC0: .word 0x000005DC
_0216BFC4: .word 0x00000578
_0216BFC8: .word 0x00000514
_0216BFCC: .word 0x000006A4
	thumb_func_end VSConnectionMenu__Main_216BEE8

	thumb_func_start VSConnectionMenu__Main_216BFD0
VSConnectionMenu__Main_216BFD0: // 0x0216BFD0
	push {r4, lr}
	sub sp, #8
	bl GetCurrentTaskWork_
	bl VSState__ProcessAnimations
	bl VSState__Draw
	bl MultibootManager__Func_2060CC8
	cmp r0, #7
	bgt _0216BFFA
	cmp r0, #6
	blt _0216BFF4
	beq _0216C014
	cmp r0, #7
	beq _0216C022
	b _0216C014
_0216BFF4:
	cmp r0, #0
	beq _0216C000
	b _0216C014
_0216BFFA:
	cmp r0, #0x19
	beq _0216C00A
	b _0216C014
_0216C000:
	mov r0, #2
	bl VSConnectionMenu__Func_216AD1C
	add sp, #8
	pop {r4, pc}
_0216C00A:
	mov r0, #3
	bl VSConnectionMenu__Func_216AD1C
	add sp, #8
	pop {r4, pc}
_0216C014:
	ldr r0, _0216C080 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	tst r0, r1
	bne _0216C06E
	add sp, #8
	pop {r4, pc}
_0216C022:
	mov r0, #2
	bl PlaySysMenuNavSfx
	ldr r0, _0216C084 // =VSConnectionMenu__Main_216C08C
	bl SetCurrentTaskMainEvent
	mov r0, #1
	mov r1, #2
	mov r2, #0
	bl VSState__Func_2163784
	bl MultibootManager__Func_2060D4C
	mov r4, r0
	bl MultibootManager__Func_2060D74
	mov r2, r0
	mov r0, #1
	mov r1, r4
	mov r3, #0
	bl VSState__SetPlayerInfoEx
	ldr r0, _0216C088 // =VSConnectionMenu__TouchCallback_None
	mov r1, #0
	bl VSMenu__SetTouchCallback
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #0xb
	bl SaveSpriteButton__Func_2064588
	add sp, #8
	pop {r4, pc}
_0216C06E:
	mov r0, #1
	bl PlaySysMenuNavSfx
	mov r0, #1
	bl VSConnectionMenu__Func_216AD1C
	add sp, #8
	pop {r4, pc}
	nop
_0216C080: .word padInput
_0216C084: .word VSConnectionMenu__Main_216C08C
_0216C088: .word VSConnectionMenu__TouchCallback_None
	thumb_func_end VSConnectionMenu__Main_216BFD0

	thumb_func_start VSConnectionMenu__Main_216C08C
VSConnectionMenu__Main_216C08C: // 0x0216C08C
	push {r4, lr}
	bl GetCurrentTaskWork_
	ldr r0, [r0, #0]
	ldrh r4, [r0, #0x10]
	bl VSState__ProcessAnimations
	bl VSState__Draw
	bl MultibootManager__Func_2060CC8
	cmp r0, #7
	bgt _0216C0B6
	cmp r0, #6
	blt _0216C0B0
	beq _0216C11E
	cmp r0, #7
	b _0216C0CC
_0216C0B0:
	cmp r0, #0
	beq _0216C0BC
	b _0216C0CC
_0216C0B6:
	cmp r0, #0x19
	beq _0216C0C4
	b _0216C0CC
_0216C0BC:
	mov r0, #2
	bl VSConnectionMenu__Func_216AD1C
	pop {r4, pc}
_0216C0C4:
	mov r0, #3
	bl VSConnectionMenu__Func_216AD1C
	pop {r4, pc}
_0216C0CC:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216C0EC
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064660
	cmp r0, #2
	beq _0216C108
_0216C0EC:
	ldr r0, _0216C170 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	tst r0, r1
	bne _0216C102
	bl VSMenu__GetUnknownTouchResponseFlags
	mov r1, #1
	lsl r1, r1, #0x12
	tst r0, r1
	beq _0216C16E
_0216C102:
	bl MultibootManager__Func_20613BC
	b _0216C11E
_0216C108:
	bl MultibootManager__Func_2061360
	mov r0, #1
	mov r1, #3
	mov r2, #0
	bl VSState__Func_2163784
	ldr r0, _0216C174 // =VSConnectionMenu__Main_216C180
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0216C11E:
	mov r0, #1
	bl PlaySysMenuNavSfx
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__Func_2064614
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	bne _0216C14C
_0216C138:
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__RunState
	bl VSMenu__GetYesNoButton
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	beq _0216C138
_0216C14C:
	mov r0, #1
	mov r1, r0
	mov r2, #0
	bl VSState__Func_2163784
	mov r1, #0
	mov r0, #1
	mov r2, r1
	bl VSState__SetPlayerInfo_
	ldr r0, _0216C178 // =VSConnectionMenu__TouchCallback_3
	mov r1, r4
	bl VSMenu__SetTouchCallback
	ldr r0, _0216C17C // =VSConnectionMenu__Main_216BFD0
	bl SetCurrentTaskMainEvent
_0216C16E:
	pop {r4, pc}
	.align 2, 0
_0216C170: .word padInput
_0216C174: .word VSConnectionMenu__Main_216C180
_0216C178: .word VSConnectionMenu__TouchCallback_3
_0216C17C: .word VSConnectionMenu__Main_216BFD0
	thumb_func_end VSConnectionMenu__Main_216C08C

	thumb_func_start VSConnectionMenu__Main_216C180
VSConnectionMenu__Main_216C180: // 0x0216C180
	push {r3, r4, r5, lr}
	sub sp, #8
	bl GetCurrentTaskWork_
	mov r4, r0
	bl VSState__ProcessAnimations
	bl VSState__Draw
	mov r5, #0x75
	lsl r5, r5, #4
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, r5
	bl AnimatorSprite__DrawFrame
	mov r0, r5
	add r0, #0x64
	add r4, r4, r0
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x2c
	strh r0, [r4, #8]
	mov r0, #0x61
	strh r0, [r4, #0xa]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r0, #0xd4
	strh r0, [r4, #8]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	bl MultibootManager__Func_2060CC8
	cmp r0, #0xa
	bgt _0216C1FC
	cmp r0, #0
	blt _0216C216
	add r1, r0, r0
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add pc, r1
_0216C1E6: // jump table
	.hword _0216C202 - _0216C1E6 - 2 // case 0
	.hword _0216C216 - _0216C1E6 - 2 // case 1
	.hword _0216C216 - _0216C1E6 - 2 // case 2
	.hword _0216C216 - _0216C1E6 - 2 // case 3
	.hword _0216C216 - _0216C1E6 - 2 // case 4
	.hword _0216C216 - _0216C1E6 - 2 // case 5
	.hword _0216C24E - _0216C1E6 - 2 // case 6
	.hword _0216C24E - _0216C1E6 - 2 // case 7
	.hword _0216C216 - _0216C1E6 - 2 // case 8
	.hword _0216C232 - _0216C1E6 - 2 // case 9
	.hword _0216C232 - _0216C1E6 - 2 // case 10
_0216C1FC:
	cmp r0, #0x19
	beq _0216C20C
	b _0216C216
_0216C202:
	mov r0, #2
	bl VSConnectionMenu__Func_216AD1C
	add sp, #8
	pop {r3, r4, r5, pc}
_0216C20C:
	mov r0, #3
	bl VSConnectionMenu__Func_216AD1C
	add sp, #8
	pop {r3, r4, r5, pc}
_0216C216:
	ldr r0, _0216C27C // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	tst r0, r1
	bne _0216C22C
	bl VSMenu__GetUnknownTouchResponseFlags
	mov r1, #1
	lsl r1, r1, #0x12
	tst r0, r1
	beq _0216C278
_0216C22C:
	bl MultibootManager__Func_20613BC
	b _0216C24E
_0216C232:
	ldr r0, _0216C280 // =VSConnectionMenu__Main_216C288
	bl SetCurrentTaskMainEvent
	mov r0, #1
	mov r1, #4
	mov r2, #0
	bl VSState__Func_2163784
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	add sp, #8
	pop {r3, r4, r5, pc}
_0216C24E:
	mov r0, #1
	bl PlaySysMenuNavSfx
	ldr r0, _0216C284 // =VSConnectionMenu__Main_216C08C
	bl SetCurrentTaskMainEvent
	mov r0, #1
	mov r1, #2
	mov r2, #0
	bl VSState__Func_2163784
	bl VSMenu__GetYesNoButton
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r2, r1
	mov r3, #0xb
	bl SaveSpriteButton__Func_2064588
_0216C278:
	add sp, #8
	pop {r3, r4, r5, pc}
	.align 2, 0
_0216C27C: .word padInput
_0216C280: .word VSConnectionMenu__Main_216C288
_0216C284: .word VSConnectionMenu__Main_216C08C
	thumb_func_end VSConnectionMenu__Main_216C180

	thumb_func_start VSConnectionMenu__Main_216C288
VSConnectionMenu__Main_216C288: // 0x0216C288
	push {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl VSState__ProcessAnimations
	bl VSState__Draw
	mov r5, #0x75
	lsl r5, r5, #4
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, r5
	bl AnimatorSprite__DrawFrame
	mov r0, r5
	add r0, #0x64
	add r4, r4, r0
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x2c
	strh r0, [r4, #8]
	mov r0, #0x61
	strh r0, [r4, #0xa]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r0, #0xd4
	strh r0, [r4, #8]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	bl MultibootManager__Func_2060CC8
	cmp r0, #0xa
	bgt _0216C302
	cmp r0, #0
	blt _0216C35C
	add r1, r0, r0
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add pc, r1
_0216C2EC: // jump table
	.hword _0216C308 - _0216C2EC - 2 // case 0
	.hword _0216C316 - _0216C2EC - 2 // case 1
	.hword _0216C316 - _0216C2EC - 2 // case 2
	.hword _0216C316 - _0216C2EC - 2 // case 3
	.hword _0216C316 - _0216C2EC - 2 // case 4
	.hword _0216C316 - _0216C2EC - 2 // case 5
	.hword _0216C344 - _0216C2EC - 2 // case 6
	.hword _0216C344 - _0216C2EC - 2 // case 7
	.hword _0216C344 - _0216C2EC - 2 // case 8
	.hword _0216C316 - _0216C2EC - 2 // case 9
	.hword _0216C318 - _0216C2EC - 2 // case 10
_0216C302:
	cmp r0, #0x19
	beq _0216C310
	pop {r3, r4, r5, pc}
_0216C308:
	mov r0, #2
	bl VSConnectionMenu__Func_216AD1C
	pop {r3, r4, r5, pc}
_0216C310:
	mov r0, #3
	bl VSConnectionMenu__Func_216AD1C
_0216C316:
	pop {r3, r4, r5, pc}
_0216C318:
	ldr r0, _0216C360 // =VSConnectionMenu__Main_216C36C
	bl SetCurrentTaskMainEvent
	mov r0, #0
	mov r1, r0
	mov r2, r0
	bl VSState__Func_2163784
	mov r1, #0
	mov r0, #1
	mov r2, r1
	bl VSState__Func_2163784
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	mov r0, #0xc
	bl FadeSysTrack
	pop {r3, r4, r5, pc}
_0216C344:
	mov r0, #1
	mov r1, #3
	mov r2, #0
	bl VSState__Func_2163784
	ldr r0, _0216C364 // =VSConnectionMenu__TouchCallback_None
	mov r1, #0
	bl VSMenu__SetTouchCallback
	ldr r0, _0216C368 // =VSConnectionMenu__Main_216C180
	bl SetCurrentTaskMainEvent
_0216C35C:
	pop {r3, r4, r5, pc}
	nop
_0216C360: .word VSConnectionMenu__Main_216C36C
_0216C364: .word VSConnectionMenu__TouchCallback_None
_0216C368: .word VSConnectionMenu__Main_216C180
	thumb_func_end VSConnectionMenu__Main_216C288

	thumb_func_start VSConnectionMenu__Main_216C36C
VSConnectionMenu__Main_216C36C: // 0x0216C36C
	push {r3, lr}
	bl GetCurrentTaskWork_
	bl VSState__ProcessAnimations
	bl VSState__Draw
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _0216C390
	bl DestroyDrawFadeTask
	bl MultibootManager__Func_206150C
	ldr r0, _0216C394 // =VSConnectionMenu__Main_216C398
	bl SetCurrentTaskMainEvent
_0216C390:
	pop {r3, pc}
	nop
_0216C394: .word VSConnectionMenu__Main_216C398
	thumb_func_end VSConnectionMenu__Main_216C36C

	thumb_func_start VSConnectionMenu__Main_216C398
VSConnectionMenu__Main_216C398: // 0x0216C398
	push {r3, lr}
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bgt _0216C3A6
	beq _0216C3C2
	pop {r3, pc}
_0216C3A6:
	cmp r0, #0x19
	bgt _0216C3D0
	cmp r0, #0x15
	blt _0216C3D0
	beq _0216C3D0
	cmp r0, #0x16
	beq _0216C3BA
	cmp r0, #0x19
	beq _0216C3CA
	pop {r3, pc}
_0216C3BA:
	mov r0, #0
	bl VSConnectionMenu__Func_216AD1C
	pop {r3, pc}
_0216C3C2:
	mov r0, #2
	bl VSConnectionMenu__Func_216AD1C
	pop {r3, pc}
_0216C3CA:
	mov r0, #3
	bl VSConnectionMenu__Func_216AD1C
_0216C3D0:
	pop {r3, pc}
	.align 2, 0
	thumb_func_end VSConnectionMenu__Main_216C398

	thumb_func_start VSConnectionMenu__Main_216C3D4
VSConnectionMenu__Main_216C3D4: // 0x0216C3D4
	push {r3, lr}
	bl GetCurrentTaskWork_
	bl VSState__ProcessAnimations
	bl VSState__Draw
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bgt _0216C3EE
	beq _0216C410
	b _0216C420
_0216C3EE:
	sub r0, #0x12
	cmp r0, #7
	bhi _0216C420
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0216C400: // jump table
	.hword _0216C420 - _0216C400 - 2 // case 0
	.hword _0216C42C - _0216C400 - 2 // case 1
	.hword _0216C42C - _0216C400 - 2 // case 2
	.hword _0216C420 - _0216C400 - 2 // case 3
	.hword _0216C420 - _0216C400 - 2 // case 4
	.hword _0216C420 - _0216C400 - 2 // case 5
	.hword _0216C420 - _0216C400 - 2 // case 6
	.hword _0216C418 - _0216C400 - 2 // case 7
_0216C410:
	mov r0, #2
	bl VSConnectionMenu__Func_216AD1C
	pop {r3, pc}
_0216C418:
	mov r0, #3
	bl VSConnectionMenu__Func_216AD1C
	pop {r3, pc}
_0216C420:
	ldr r0, _0216C45C // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	tst r0, r1
	bne _0216C44A
	pop {r3, pc}
_0216C42C:
	mov r0, #2
	bl PlaySysMenuNavSfx
	ldr r0, _0216C460 // =VSConnectionMenu__Main_216C464
	bl SetCurrentTaskMainEvent
	mov r0, #1
	mov r1, r0
	bl VSState__Func_2163768
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	pop {r3, pc}
_0216C44A:
	mov r0, #1
	bl PlaySysMenuNavSfx
	bl MultibootManager__Func_2061808
	mov r0, #1
	bl VSConnectionMenu__Func_216AD1C
	pop {r3, pc}
	.align 2, 0
_0216C45C: .word padInput
_0216C460: .word VSConnectionMenu__Main_216C464
	thumb_func_end VSConnectionMenu__Main_216C3D4

	thumb_func_start VSConnectionMenu__Main_216C464
VSConnectionMenu__Main_216C464: // 0x0216C464
	push {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	bl VSState__ProcessAnimations
	bl VSState__Draw
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bgt _0216C47E
	beq _0216C492
	pop {r3, r4, r5, pc}
_0216C47E:
	cmp r0, #0x19
	bgt _0216C4D6
	cmp r0, #0x13
	blt _0216C4D6
	beq _0216C4D6
	cmp r0, #0x14
	beq _0216C4A2
	cmp r0, #0x19
	beq _0216C49A
	pop {r3, r4, r5, pc}
_0216C492:
	mov r0, #2
	bl VSConnectionMenu__Func_216AD1C
	pop {r3, r4, r5, pc}
_0216C49A:
	mov r0, #3
	bl VSConnectionMenu__Func_216AD1C
	pop {r3, r4, r5, pc}
_0216C4A2:
	ldr r0, _0216C4D8 // =VSConnectionMenu__Main_216C4DC
	bl SetCurrentTaskMainEvent
	bl MultibootManager__Func_2060D4C
	mov r5, r0
	bl MultibootManager__Func_2060D74
	mov r4, r0
	bl MultibootManager__Func_2060D9C
	mov r3, r0
	mov r0, #1
	mov r1, r5
	mov r2, r4
	bl VSState__SetPlayerInfoEx
	mov r0, #1
	mov r1, #0
	bl VSState__Func_2163768
	mov r0, #1
	mov r1, #2
	mov r2, #0
	bl VSState__Func_2163784
_0216C4D6:
	pop {r3, r4, r5, pc}
	.align 2, 0
_0216C4D8: .word VSConnectionMenu__Main_216C4DC
	thumb_func_end VSConnectionMenu__Main_216C464

	thumb_func_start VSConnectionMenu__Main_216C4DC
VSConnectionMenu__Main_216C4DC: // 0x0216C4DC
	push {r3, lr}
	bl GetCurrentTaskWork_
	bl VSState__ProcessAnimations
	bl VSState__Draw
	mov r0, #0
	mov r1, r0
	mov r2, r0
	bl VSState__Func_2163784
	mov r1, #0
	mov r0, #1
	mov r2, r1
	bl VSState__Func_2163784
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	mov r0, #0xc
	bl FadeSysTrack
	ldr r0, _0216C518 // =VSConnectionMenu__Main_216C51C
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_0216C518: .word VSConnectionMenu__Main_216C51C
	thumb_func_end VSConnectionMenu__Main_216C4DC

	thumb_func_start VSConnectionMenu__Main_216C51C
VSConnectionMenu__Main_216C51C: // 0x0216C51C
	push {r3, lr}
	bl GetCurrentTaskWork_
	bl VSState__ProcessAnimations
	bl VSState__Draw
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _0216C53C
	bl DestroyDrawFadeTask
	mov r0, #0
	bl VSConnectionMenu__Func_216AD1C
_0216C53C:
	pop {r3, pc}
	.align 2, 0
	thumb_func_end VSConnectionMenu__Main_216C51C

	.rodata

.public ovl03_0217E09C
ovl03_0217E09C: // 0x0217E09C
    .hword 0, 0, 192, 16

	.data
	
aBbDmwfJoinBb: // 0x0217ED68
	.asciz "/bb/dmwf_join.bb"
	.align 4
	
aNarcDmcmnAnten_0: // 0x0217ED7C
	.asciz "/narc/dmcmn_antenna_lz7.narc"
	.align 4

.public aD_8
aD_8: // 0x0217ED9C
	.byte 0x25, 0x00, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00 // L"%d"
	
.public aS_12
aS_12: // 0x0217EDA4
	.byte 0x25, 0x00, 0x73, 0x00, 0x00, 0x00, 0x00, 0x00 // L"%s"