	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public VSStageClear__Singleton
VSStageClear__Singleton: // 0x0217EFC8
	.space 0x04 // Task*

	.text

	thumb_func_start VSStageClear__Create
VSStageClear__Create: // 0x0215A98C
	push {lr}
	sub sp, #0xc
	mov r0, #0
	bl RenderCore_StopDMA
	mov r0, #1
	bl RenderCore_StopDMA
	bl MultibootManager__Create
	ldr r0, _0215A9CC // =0x00002001
	mov r2, #0
	str r0, [sp]
	ldr r0, _0215A9D0 // =0x000018CC
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215A9D4 // =VSStageClear__Main
	ldr r1, _0215A9D8 // =VSStageClear__Destructor
	mov r3, r2
	bl TaskCreate_
	ldr r1, _0215A9DC // =VSStageClear__Singleton
	str r0, [r1]
	bl GetTaskWork_
	mov r1, r0
	ldr r2, _0215A9D0 // =0x000018CC
	mov r0, #0
	bl MIi_CpuClear16
	add sp, #0xc
	pop {pc}
	.align 2, 0
_0215A9CC: .word 0x00002001
_0215A9D0: .word 0x000018CC
_0215A9D4: .word VSStageClear__Main
_0215A9D8: .word VSStageClear__Destructor
_0215A9DC: .word VSStageClear__Singleton
	thumb_func_end VSStageClear__Create

	thumb_func_start VSStageClear__Destructor
VSStageClear__Destructor: // 0x0215A9E0
	ldr r0, _0215A9E8 // =VSStageClear__Singleton
	mov r1, #0
	str r1, [r0]
	bx lr
	.align 2, 0
_0215A9E8: .word VSStageClear__Singleton
	thumb_func_end VSStageClear__Destructor

	thumb_func_start VSStageClear__Func_215A9EC
VSStageClear__Func_215A9EC: // 0x0215A9EC
	push {r3, r4, lr}
	sub sp, #0xc
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _0215AAF8 // =0x000018CC
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r0, r4
	bl VSStageClear__LoadAssets
	mov r0, r4
	bl VSStageClear__Func_215ADDC
	ldr r0, _0215AAFC // =0x0000183C
	add r0, r4, r0
	bl FontFile__Init
	ldr r0, _0215AAFC // =0x0000183C
	ldr r1, _0215AB00 // =aFntFontIplFnt_1
	add r0, r4, r0
	mov r2, #0
	bl FontFile__InitFromPath
	mov r0, r4
	bl VSStageClearModeHeader__Create
	mov r0, r4
	bl VSStageClearPlayers__Create
	mov r0, r4
	bl VSStageClearResults__Create
	mov r0, r4
	bl VSStageClearScoreDisplay__Create
	mov r0, r4
	bl VSStageClearPlayerNames__Create
	mov r0, r4
	bl VSStageClearButtons__Create
	mov r0, r4
	bl VSStageClearTimer__Create
	bl LoadConnectionStatusIconAssets
	mov r1, #1
	mov r0, #0
	str r0, [sp]
	mov r0, #0xe4
	str r0, [sp, #4]
	mov r0, #0xa6
	str r0, [sp, #8]
	mov r0, #2
	mov r2, r1
	mov r3, r1
	bl CreateConnectionStatusIcon
	mov r0, #1
	bl StartSamplingTouchInput
	mov r0, #0
	bl LoadSysSound
	ldr r0, _0215AB04 // =renderCoreGFXControlA+0x00000020
	mov r1, #0
	strh r1, [r0]
	strh r1, [r0, #4]
	strh r1, [r0, #2]
	ldrh r2, [r0, #0]
	mov r1, #0xc0
	bic r2, r1
	mov r1, #0x40
	orr r1, r2
	strh r1, [r0]
	ldrh r2, [r0, #0]
	mov r1, #1
	bic r2, r1
	mov r1, #1
	orr r1, r2
	strh r1, [r0]
	ldrh r2, [r0, #0]
	mov r1, #2
	orr r1, r2
	strh r1, [r0]
	ldrh r2, [r0, #0]
	mov r1, #4
	orr r1, r2
	strh r1, [r0]
	ldrh r2, [r0, #0]
	mov r1, #8
	orr r1, r2
	strh r1, [r0]
	ldrh r1, [r0, #0]
	mov r2, #0x20
	orr r1, r2
	strh r1, [r0]
	ldrh r3, [r0, #0]
	mov r1, r2
	add r1, #0xe0
	orr r1, r3
	strh r1, [r0]
	ldrh r3, [r0, #0]
	lsl r1, r2, #4
	orr r1, r3
	strh r1, [r0]
	ldrh r3, [r0, #0]
	lsl r1, r2, #5
	orr r1, r3
	strh r1, [r0]
	ldrh r3, [r0, #0]
	lsl r1, r2, #6
	orr r1, r3
	strh r1, [r0]
	ldrh r3, [r0, #0]
	lsl r1, r2, #7
	orr r1, r3
	strh r1, [r0]
	ldrh r3, [r0, #0]
	lsl r1, r2, #8
	orr r1, r3
	strh r1, [r0]
	ldrh r2, [r0, #2]
	mov r1, #0x1f
	bic r2, r1
	mov r1, #0x10
	orr r1, r2
	strh r1, [r0, #2]
	add sp, #0xc
	pop {r3, r4, pc}
	nop
_0215AAF8: .word 0x000018CC
_0215AAFC: .word 0x0000183C
_0215AB00: .word aFntFontIplFnt_1
_0215AB04: .word renderCoreGFXControlA+0x00000020
	thumb_func_end VSStageClear__Func_215A9EC

	thumb_func_start VSStageClear__Func_215AB08
VSStageClear__Func_215AB08: // 0x0215AB08
	push {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	ldr r1, _0215AB84 // =renderCoreGFXControlA+0x00000020
	mov r0, #0
	strh r0, [r1]
	strh r0, [r1, #2]
	strh r0, [r1, #4]
	bl ReleaseSysSound
	bl StopSamplingTouchInput
	bl ReleaseConnectionStatusIconAssets
	mov r0, r4
	bl VSStageClearTimer__Destroy
	mov r0, r4
	bl VSStageClearButtons__Destroy
	mov r0, r4
	bl VSStageClearPlayerNames__Destroy
	mov r0, r4
	bl VSStageClearScoreDisplay__Destroy
	mov r0, r4
	bl VSStageClearResults__Destroy
	mov r0, r4
	bl VSStageClearPlayers__Destroy
	mov r0, r4
	bl VSStageClearModeHeader__Destroy
	ldr r0, _0215AB88 // =0x0000183C
	add r0, r4, r0
	bl FontFile__Release
	ldr r0, _0215AB8C // =0x000018C8
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0215AB74
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _0215AB70
	bl ReleaseStageCommonAssets
	bl ReleaseStageCommonArchives
_0215AB70:
	bl MultibootManager__Func_2060C9C
_0215AB74:
	mov r0, r4
	bl VSStageClear__Func_215AEB0
	mov r0, r4
	bl VSStageClear__Func_215ADB8
	pop {r4, pc}
	nop
_0215AB84: .word renderCoreGFXControlA+0x00000020
_0215AB88: .word 0x0000183C
_0215AB8C: .word 0x000018C8
	thumb_func_end VSStageClear__Func_215AB08

	thumb_func_start VSStageClear__Func_215AB90
VSStageClear__Func_215AB90: // 0x0215AB90
	ldr r0, _0215AB98 // =renderCurrentDisplay
	mov r1, #0
	str r1, [r0]
	bx lr
	.align 2, 0
_0215AB98: .word renderCurrentDisplay
	thumb_func_end VSStageClear__Func_215AB90

	thumb_func_start VSStageClear__Func_215AB9C
VSStageClear__Func_215AB9C: // 0x0215AB9C
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _0215ABFC // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	lsl r0, r5, #0x10
	asr r0, r0, #0x10
	bl RequestSysEventChange
	cmp r5, #0
	beq _0215ABC0
	cmp r5, #1
	beq _0215ABCC
	cmp r5, #2
	beq _0215ABDE
	b _0215ABF0
_0215ABC0:
	ldr r0, _0215ABFC // =VSStageClear__Singleton
	ldr r1, _0215AC00 // =VSStageClear__Main_215C924
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r3, r4, r5, pc}
_0215ABCC:
	ldr r0, _0215AC04 // =0x000018C8
	mov r1, #1
	str r1, [r4, r0]
	ldr r0, _0215ABFC // =VSStageClear__Singleton
	ldr r1, _0215AC08 // =VSStageClear__Main_215C8C0
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r3, r4, r5, pc}
_0215ABDE:
	ldr r0, _0215AC04 // =0x000018C8
	mov r1, #1
	str r1, [r4, r0]
	ldr r0, _0215ABFC // =VSStageClear__Singleton
	ldr r1, _0215AC0C // =VSStageClear__Main_215CB80
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r3, r4, r5, pc}
_0215ABF0:
	ldr r0, _0215ABFC // =VSStageClear__Singleton
	ldr r1, _0215AC00 // =VSStageClear__Main_215C924
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r3, r4, r5, pc}
	.align 2, 0
_0215ABFC: .word VSStageClear__Singleton
_0215AC00: .word VSStageClear__Main_215C924
_0215AC04: .word 0x000018C8
_0215AC08: .word VSStageClear__Main_215C8C0
_0215AC0C: .word VSStageClear__Main_215CB80
	thumb_func_end VSStageClear__Func_215AB9C

	thumb_func_start VSStageClear__LoadAssets
VSStageClear__LoadAssets: // 0x0215AC10
	push {r4, lr}
	sub sp, #0x28
	mov r4, r0
	ldr r0, _0215AD78 // =playerWork
	mov r2, #0
	ldr r1, [r0, #0]
	mov r3, r2
	str r1, [r4]
	ldr r0, [r0, #8]
	sub r1, r2, #1
	str r0, [r4, #4]
	ldr r0, _0215AD7C // =animationWork
	ldr r0, [r0, #0]
	str r0, [r4, #8]
	ldr r0, _0215AD80 // =aNarcCldmVsNarc
	str r2, [sp]
	bl ArchiveFile__Load
	str r0, [r4, #0x4c]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _0215AC60
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215AC4C: // jump table
	.hword _0215AC58 - _0215AC4C - 2 // case 0
	.hword _0215AC58 - _0215AC4C - 2 // case 1
	.hword _0215AC58 - _0215AC4C - 2 // case 2
	.hword _0215AC58 - _0215AC4C - 2 // case 3
	.hword _0215AC58 - _0215AC4C - 2 // case 4
	.hword _0215AC58 - _0215AC4C - 2 // case 5
_0215AC58:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _0215AC62
_0215AC60:
	mov r1, #1
_0215AC62:
	ldr r0, _0215AD84 // =aCldmVsBac
	mov r3, r4
	str r0, [sp]
	mov r0, r4
	add r0, #0x30
	str r0, [sp, #4]
	ldr r0, _0215AD88 // =aCldmVsCmnBac
	lsl r1, r1, #2
	str r0, [sp, #8]
	mov r0, r4
	add r0, #0x34
	str r0, [sp, #0xc]
	ldr r0, _0215AD8C // =0x0217E84C
	ldr r2, _0215AD90 // =aCldmVsNsbca
	ldr r0, [r0, r1]
	mov r1, r4
	str r0, [sp, #0x10]
	mov r0, r4
	add r0, #0x3c
	str r0, [sp, #0x14]
	ldr r0, _0215AD94 // =aCldmVsBsd
	add r1, #0x38
	str r0, [sp, #0x18]
	mov r0, #0
	str r0, [sp, #0x1c]
	ldr r0, [r4, #0x4c]
	add r3, #0x2c
	bl StageClear__LoadFiles
	mov r2, #0
	ldr r0, _0215AD98 // =aNarcDmvsCmnNar
	str r2, [sp]
	sub r1, r2, #1
	mov r3, r2
	bl ArchiveFile__Load
	str r0, [r4, #0x18]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _0215ACD6
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215ACC2: // jump table
	.hword _0215ACCE - _0215ACC2 - 2 // case 0
	.hword _0215ACCE - _0215ACC2 - 2 // case 1
	.hword _0215ACCE - _0215ACC2 - 2 // case 2
	.hword _0215ACCE - _0215ACC2 - 2 // case 3
	.hword _0215ACCE - _0215ACC2 - 2 // case 4
	.hword _0215ACCE - _0215ACC2 - 2 // case 5
_0215ACCE:
	bl RenderCore_GetLanguagePtr
	ldrb r2, [r0, #0]
	b _0215ACD8
_0215ACD6:
	mov r2, #1
_0215ACD8:
	mov r0, #0
	mov r1, r4
	str r0, [sp]
	add r1, #0x1c
	str r1, [sp, #4]
	ldr r1, _0215AD9C // =aDmvsTitleBac
	mov r3, r4
	str r1, [sp, #8]
	mov r1, r4
	add r1, #0x20
	str r1, [sp, #0xc]
	ldr r1, _0215ADA0 // =0x0217E864
	lsl r2, r2, #2
	ldr r1, [r1, r2]
	mov r2, #1
	str r1, [sp, #0x10]
	mov r1, r4
	add r1, #0x24
	str r1, [sp, #0x14]
	ldr r1, _0215ADA4 // =aDmvsCursorBac
	add r3, #0x14
	str r1, [sp, #0x18]
	mov r1, r4
	add r1, #0x28
	str r1, [sp, #0x1c]
	ldr r1, _0215ADA8 // =aDmvsTimeBac
	str r1, [sp, #0x20]
	str r0, [sp, #0x24]
	mov r1, r4
	ldr r0, [r4, #0x18]
	add r1, #0x10
	bl StageClear__LoadFiles
	mov r2, #0
	ldr r0, _0215ADAC // =aNarcDmasVsNarc
	str r2, [sp]
	sub r1, r2, #1
	mov r3, r2
	bl ArchiveFile__Load
	str r0, [r4, #0x40]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _0215AD54
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215AD40: // jump table
	.hword _0215AD4C - _0215AD40 - 2 // case 0
	.hword _0215AD4C - _0215AD40 - 2 // case 1
	.hword _0215AD4C - _0215AD40 - 2 // case 2
	.hword _0215AD4C - _0215AD40 - 2 // case 3
	.hword _0215AD4C - _0215AD40 - 2 // case 4
	.hword _0215AD4C - _0215AD40 - 2 // case 5
_0215AD4C:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _0215AD56
_0215AD54:
	mov r0, #1
_0215AD56:
	lsl r1, r0, #2
	ldr r0, _0215ADB0 // =0x0217E87C
	ldr r2, _0215ADB4 // =aDmasVsBac
	ldr r0, [r0, r1]
	mov r1, r4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	ldr r0, [r4, #0x40]
	add r4, #0x48
	add r1, #0x44
	mov r3, r4
	bl StageClear__LoadFiles
	add sp, #0x28
	pop {r4, pc}
	nop
_0215AD78: .word playerWork
_0215AD7C: .word animationWork
_0215AD80: .word aNarcCldmVsNarc
_0215AD84: .word aCldmVsBac
_0215AD88: .word aCldmVsCmnBac
_0215AD8C: .word 0x0217E84C
_0215AD90: .word aCldmVsNsbca
_0215AD94: .word aCldmVsBsd
_0215AD98: .word aNarcDmvsCmnNar
_0215AD9C: .word aDmvsTitleBac
_0215ADA0: .word 0x0217E864
_0215ADA4: .word aDmvsCursorBac
_0215ADA8: .word aDmvsTimeBac
_0215ADAC: .word aNarcDmasVsNarc
_0215ADB0: .word 0x0217E87C
_0215ADB4: .word aDmasVsBac
	thumb_func_end VSStageClear__LoadAssets

	thumb_func_start VSStageClear__Func_215ADB8
VSStageClear__Func_215ADB8: // 0x0215ADB8
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x4c]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x18]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x40]
	bl _FreeHEAP_USER
	mov r0, #0
	mov r1, r4
	mov r2, #0x50
	bl MIi_CpuClear16
	pop {r4, pc}
	.align 2, 0
	thumb_func_end VSStageClear__Func_215ADB8

	thumb_func_start VSStageClear__Func_215ADDC
VSStageClear__Func_215ADDC: // 0x0215ADDC
	push {r3, r4}
	ldr r1, _0215AEA0 // =gameState
	add r0, #0x50
	ldr r3, [r1, #0x20]
	ldr r2, _0215AEA4 // =playerGameStatus
	cmp r3, #1
	bne _0215AE1C
	mov r3, #1
	str r3, [r0]
	mov r3, #0x98
	ldrsh r4, [r2, r3]
	cmp r4, #0
	bge _0215ADFA
	mov r4, #0
	b _0215AE02
_0215ADFA:
	ldr r3, _0215AEA8 // =0x000003E7
	cmp r4, r3
	ble _0215AE02
	mov r4, r3
_0215AE02:
	str r4, [r0, #0xc]
	mov r3, #0x9c
	ldrsh r3, [r2, r3]
	cmp r3, #0
	bge _0215AE10
	mov r3, #0
	b _0215AE18
_0215AE10:
	ldr r2, _0215AEA8 // =0x000003E7
	cmp r3, r2
	ble _0215AE18
	mov r3, r2
_0215AE18:
	str r3, [r0, #0x10]
	b _0215AE3E
_0215AE1C:
	mov r3, #0
	str r3, [r0]
	mov r3, r2
	add r3, #0x98
	ldr r4, [r3, #0]
	ldr r3, _0215AEAC // =0x00008C9F
	cmp r4, r3
	bls _0215AE2E
	mov r4, r3
_0215AE2E:
	str r4, [r0, #0xc]
	add r2, #0x9c
	ldr r3, [r2, #0]
	ldr r2, _0215AEAC // =0x00008C9F
	cmp r3, r2
	bls _0215AE3C
	mov r3, r2
_0215AE3C:
	str r3, [r0, #0x10]
_0215AE3E:
	ldr r1, [r1, #0x1c]
	cmp r1, #1
	bne _0215AE4A
	mov r1, #1
	str r1, [r0, #4]
	b _0215AE58
_0215AE4A:
	cmp r1, #2
	bne _0215AE54
	mov r1, #0
	str r1, [r0, #4]
	b _0215AE58
_0215AE54:
	mov r1, #2
	str r1, [r0, #4]
_0215AE58:
	ldr r2, [r0, #4]
	cmp r2, #2
	bne _0215AE66
	mov r1, #2
	str r1, [r0, #8]
	pop {r3, r4}
	bx lr
_0215AE66:
	ldr r1, _0215AEA0 // =gameState
	ldr r1, [r1, #4]
	cmp r1, #0
	beq _0215AE76
	cmp r1, #1
	beq _0215AE8A
	pop {r3, r4}
	bx lr
_0215AE76:
	cmp r2, #1
	bne _0215AE82
	mov r1, #1
	str r1, [r0, #8]
	pop {r3, r4}
	bx lr
_0215AE82:
	mov r1, #0
	str r1, [r0, #8]
	pop {r3, r4}
	bx lr
_0215AE8A:
	cmp r2, #1
	bne _0215AE96
	mov r1, #0
	str r1, [r0, #8]
	pop {r3, r4}
	bx lr
_0215AE96:
	mov r1, #1
	str r1, [r0, #8]
	pop {r3, r4}
	bx lr
	nop
_0215AEA0: .word gameState
_0215AEA4: .word playerGameStatus
_0215AEA8: .word 0x000003E7
_0215AEAC: .word 0x00008C9F
	thumb_func_end VSStageClear__Func_215ADDC

	thumb_func_start VSStageClear__Func_215AEB0
VSStageClear__Func_215AEB0: // 0x0215AEB0
	bx lr
	.align 2, 0
	thumb_func_end VSStageClear__Func_215AEB0

	thumb_func_start VSStageClearModeHeader__Create
VSStageClearModeHeader__Create: // 0x0215AEB4
	push {r4, r5, r6, r7, lr}
	sub sp, #0x64
	mov r4, r0
	mov r0, #1
	mov r6, r4
	mov r1, #3
	mov r2, r0
	add r6, #0x64
	bl GX_SetGraphicsMode
	mov r0, #3
	bl GXS_SetGraphicsMode
	ldr r5, _0215B1D8 // =0x0400000A
	mov r0, #0x43
	ldrh r1, [r5, #0]
	ldr r2, _0215B1DC // =0x00000E04
	sub r3, r5, #2
	and r1, r0
	ldr r0, _0215B1E0 // =0x00002F0C
	orr r0, r1
	strh r0, [r5]
	ldrh r1, [r5, #2]
	mov r0, #0x43
	and r0, r1
	orr r0, r2
	strh r0, [r5, #2]
	ldr r1, _0215B1E4 // =renderCoreGFXControlA
	mov r0, #0
	strh r0, [r1, #0xa]
	ldrh r0, [r1, #0xa]
	strh r0, [r1, #8]
	strh r0, [r1, #6]
	strh r0, [r1, #4]
	strh r0, [r1, #2]
	strh r0, [r1]
	ldrh r0, [r5, #0]
	mov r1, #3
	bic r0, r1
	strh r0, [r5]
	ldrh r7, [r3, #0]
	mov r0, #1
	bic r7, r1
	orr r0, r7
	strh r0, [r3]
	ldrh r3, [r5, #2]
	mov r0, #2
	bic r3, r1
	orr r0, r3
	strh r0, [r5, #2]
	ldrh r3, [r5, #4]
	mov r0, #3
	bic r3, r1
	orr r0, r3
	strh r0, [r5, #4]
	lsl r0, r2, #0x18
	ldr r5, [r0, #0]
	ldr r3, _0215B1E8 // =0xFFFFE0FF
	sub r2, #0xfc
	and r5, r3
	mov r3, #0x17
	lsl r3, r3, #8
	orr r3, r5
	str r3, [r0]
	ldr r0, _0215B1EC // =0x04001008
	mov r3, #0x43
	ldrh r5, [r0, #0]
	and r5, r3
	ldr r3, _0215B1E0 // =0x00002F0C
	orr r3, r5
	strh r3, [r0]
	ldrh r5, [r0, #2]
	mov r3, #0x43
	and r5, r3
	ldr r3, _0215B1F0 // =0x00002E04
	orr r3, r5
	strh r3, [r0, #2]
	ldrh r5, [r0, #4]
	mov r3, #0x43
	and r3, r5
	orr r2, r3
	strh r2, [r0, #4]
	ldr r3, _0215B1F4 // =renderCoreGFXControlB
	mov r2, #0
	strh r2, [r3, #0xa]
	ldrh r2, [r3, #0xa]
	strh r2, [r3, #8]
	strh r2, [r3, #6]
	strh r2, [r3, #4]
	ldrh r2, [r3, #4]
	strh r2, [r3, #2]
	strh r2, [r3]
	ldrh r2, [r0, #0]
	bic r2, r1
	strh r2, [r0]
	ldrh r3, [r0, #4]
	mov r2, #1
	bic r3, r1
	orr r2, r3
	strh r2, [r0, #4]
	ldrh r3, [r0, #2]
	mov r2, #2
	bic r3, r1
	orr r2, r3
	strh r2, [r0, #2]
	ldrh r2, [r0, #6]
	mov r3, #1
	bic r2, r1
	mov r1, #3
	orr r1, r2
	strh r1, [r0, #6]
	sub r0, #8
	ldr r2, [r0, #0]
	ldr r1, _0215B1E8 // =0xFFFFE0FF
	and r2, r1
	mov r1, #0x17
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r0]
	ldr r5, [r4, #0x14]
	mov r0, #0
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0x1c
	mov r1, r5
	mov r2, #0x38
	bl InitBackground
	add r0, sp, #0x1c
	bl DrawBackground
	mov r0, #1
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0x1c
	mov r1, r5
	mov r2, #0x38
	mov r3, #0
	bl InitBackground
	mov r0, #0xc0
	str r0, [sp, #0x28]
	add r0, sp, #0x1c
	bl DrawBackground
	ldr r5, [r4, #0x10]
	mov r3, #1
	str r3, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	str r0, [sp, #8]
	add r0, sp, #0x1c
	mov r1, r5
	mov r2, #0x38
	bl InitBackground
	add r0, sp, #0x1c
	bl DrawBackground
	mov r0, #2
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	str r0, [sp, #8]
	add r0, sp, #0x1c
	mov r1, r5
	mov r2, #0x38
	mov r3, #0
	bl InitBackground
	add r0, sp, #0x1c
	bl DrawBackground
	ldr r7, [r4, #0x1c]
	mov r1, #1
	mov r5, r6
	mov r0, r7
	mov r2, r1
	add r5, #8
	bl SpriteUnknown__Func_204C3CC
	mov r2, #1
	str r2, [sp]
	str r0, [sp, #4]
	mov r0, #0xf
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, r5
	mov r1, r7
	lsl r3, r2, #0xb
	str r2, [sp, #0x10]
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r5, #0x3c]
	mov r0, #8
	orr r0, r1
	str r0, [r5, #0x3c]
	mov r5, r6
	mov r0, r7
	mov r1, #1
	mov r2, #0
	add r5, #0x6c
	bl SpriteUnknown__Func_204C3CC
	mov r1, #1
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0xe
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	mov r3, #2
	str r3, [sp, #0x10]
	mov r0, r5
	mov r1, r7
	lsl r3, r3, #0xa
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r5, #0x3c]
	mov r0, #8
	orr r0, r1
	str r0, [r5, #0x3c]
	mov r5, r6
	ldr r7, [r4, #0x20]
	add r5, #0xd0
	bl VSStageClear__IsRace
	cmp r0, #0
	bne _0215B0A4
	mov r0, #1
	b _0215B0A6
_0215B0A4:
	mov r0, #0
_0215B0A6:
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x18]
	ldr r2, [sp, #0x18]
	mov r0, r7
	mov r1, #1
	bl SpriteUnknown__Func_204C3CC
	mov r3, #1
	str r3, [sp]
	str r0, [sp, #4]
	mov r0, #0xd
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r2, [sp, #0x18]
	mov r0, r5
	mov r1, r7
	lsl r3, r3, #0xb
	bl SpriteUnknown__Func_204C90C
	mov r0, #0x18
	strh r0, [r5, #8]
	mov r0, #6
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r5, #0x3c]
	mov r0, #8
	orr r0, r1
	str r0, [r5, #0x3c]
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	beq _0215B0FA
	mov r7, #0
	mov r5, #1
	b _0215B0FE
_0215B0FA:
	mov r7, #1
	mov r5, #0
_0215B0FE:
	bl MultibootManager__Func_2060CF0
	cmp r0, #0
	beq _0215B110
	cmp r0, #1
	beq _0215B110
	cmp r0, #2
	beq _0215B156
	b _0215B1A0
_0215B110:
	mov r0, #6
	str r0, [sp, #0x14]
	bl VSState__AllocAssets
	mov r0, #6
	mov r1, #1
	mov r2, #2
	mov r3, #0
	bl VSState__LoadAssets
	ldr r0, _0215B1F8 // =0x0000183C
	mov r1, #2
	add r0, r4, r0
	mov r2, #0
	mov r3, #1
	bl VSState__Func_2163510
	lsl r0, r7, #0x18
	lsr r0, r0, #0x18
	mov r1, #0
	bl VSState__SetPlayerInfo
	bl MultibootManager__Func_2060D4C
	mov r4, r0
	bl MultibootManager__Func_2060D74
	mov r2, r0
	lsl r0, r5, #0x18
	lsr r0, r0, #0x18
	mov r1, r4
	mov r3, #0
	bl VSState__SetPlayerInfoEx
	b _0215B1A0
_0215B156:
	mov r0, #7
	str r0, [sp, #0x14]
	bl VSState__AllocAssets
	mov r0, #7
	mov r1, #1
	mov r2, #2
	mov r3, #0
	bl VSState__LoadAssets
	ldr r0, _0215B1F8 // =0x0000183C
	mov r1, #2
	add r0, r4, r0
	mov r2, #0
	mov r3, #1
	bl VSState__Func_2163510
	bl SaveGame__GetOnlineScore
	mov r1, r0
	mov r0, #0
	bl VSState__SetPlayerInfo
	bl MultibootManager__Func_2060D4C
	mov r4, r0
	bl MultibootManager__Func_2060D74
	mov r5, r0
	bl MultibootManager__Func_2060D9C
	mov r3, r0
	mov r0, #1
	mov r1, r4
	mov r2, r5
	bl VSState__SetPlayerInfoEx
_0215B1A0:
	ldr r0, [sp, #0x14]
	bl VSState__InitSprites
	mov r1, #0
	ldr r0, _0215B1FC // =0x00002042
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215B200 // =VSStageClearModeHeader__Main1
	str r1, [sp, #8]
	mov r3, r1
	bl TaskCreate_
	mov r1, #0
	str r0, [r6]
	ldr r0, _0215B204 // =0x00002082
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215B208 // =VSStageClearModeHeader__Main2
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r6, #4]
	add sp, #0x64
	pop {r4, r5, r6, r7, pc}
	nop
_0215B1D8: .word 0x0400000A
_0215B1DC: .word 0x00000E04
_0215B1E0: .word 0x00002F0C
_0215B1E4: .word renderCoreGFXControlA
_0215B1E8: .word 0xFFFFE0FF
_0215B1EC: .word 0x04001008
_0215B1F0: .word 0x00002E04
_0215B1F4: .word renderCoreGFXControlB
_0215B1F8: .word 0x0000183C
_0215B1FC: .word 0x00002042
_0215B200: .word VSStageClearModeHeader__Main1
_0215B204: .word 0x00002082
_0215B208: .word VSStageClearModeHeader__Main2
	thumb_func_end VSStageClearModeHeader__Create

	thumb_func_start VSStageClearModeHeader__Destroy
VSStageClearModeHeader__Destroy: // 0x0215B20C
	push {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r5
	add r4, #0x64
	bl VSState__ReleaseAssets
	mov r0, r4
	add r0, #8
	bl AnimatorSprite__Release
	mov r0, r4
	add r0, #0x6c
	bl AnimatorSprite__Release
	mov r0, r4
	add r0, #0xd0
	bl AnimatorSprite__Release
	ldr r0, [r5, #0x64]
	cmp r0, #0
	beq _0215B23A
	bl DestroyTask
_0215B23A:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0215B244
	bl DestroyTask
_0215B244:
	mov r0, #1
	mov r1, #5
	mov r2, r0
	bl GX_SetGraphicsMode
	mov r0, #5
	bl GXS_SetGraphicsMode
	pop {r3, r4, r5, pc}
	.align 2, 0
	thumb_func_end VSStageClearModeHeader__Destroy

	thumb_func_start VSStageClearPlayers__Create
VSStageClearPlayers__Create: // 0x0215B258
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x38
	mov r1, #0x67
	lsl r1, r1, #2
	str r0, [sp, #0x1c]
	add r4, r0, r1
	ldr r0, [r0, #0]
	str r0, [sp, #0x34]
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #4]
	str r0, [sp, #0x30]
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0x38]
	str r0, [sp, #0x2c]
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0x3c]
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0x58]
	cmp r0, #0
	beq _0215B298
	cmp r0, #1
	beq _0215B28C
	cmp r0, #2
	beq _0215B2A4
	b _0215B2AE
_0215B28C:
	mov r0, #3
	str r0, [sp, #0x24]
	mov r0, #5
	mov r7, #0
	str r0, [sp, #0x20]
	b _0215B2AE
_0215B298:
	mov r0, #2
	str r0, [sp, #0x24]
	mov r0, #4
	mov r7, #1
	str r0, [sp, #0x20]
	b _0215B2AE
_0215B2A4:
	mov r0, #3
	str r0, [sp, #0x24]
	mov r0, #5
	mov r7, #1
	str r0, [sp, #0x20]
_0215B2AE:
	mov r6, r4
	add r6, #8
	mov r0, r6
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r1, [sp, #0x34]
	mov r0, r6
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	ldr r2, [sp, #0x2c]
	mov r0, r6
	mov r3, r7
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
	ldr r0, _0215B578 // =0x00000CCC
	mov r1, #0
	str r0, [r6, #0x20]
	str r0, [r6, #0x1c]
	str r0, [r6, #0x18]
	mov r0, #0x53
	lsl r0, r0, #2
	add r6, r4, r0
	mov r0, r6
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r1, [sp, #0x30]
	mov r0, r6
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x24]
	mov r0, r6
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
	ldr r0, _0215B578 // =0x00000CCC
	mov r1, #0
	str r0, [r6, #0x20]
	str r0, [r6, #0x1c]
	str r0, [r6, #0x18]
	mov r0, #0x29
	lsl r0, r0, #4
	add r6, r4, r0
	mov r0, r6
	bl AnimatorMDL__Init
	mov r3, #0
	ldr r1, [sp, #0x30]
	mov r0, r6
	mov r2, #2
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x20]
	mov r0, r6
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
	ldr r0, _0215B578 // =0x00000CCC
	ldr r1, _0215B57C // =0x001FFFFF
	str r0, [r6, #0x20]
	str r0, [r6, #0x1c]
	str r0, [r6, #0x18]
	ldr r0, [sp, #0x28]
	bl LoadDrawState
	ldr r0, [sp, #0x1c]
	mov r1, #0x18
	ldr r7, [r0, #0x2c]
	mov r0, #0xf5
	lsl r0, r0, #2
	add r6, r4, r0
	mov r0, r7
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215B580 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #2
	str r0, [sp, #0x14]
	mov r0, #0x1e
	str r0, [sp, #0x18]
	mov r0, r6
	mov r1, r7
	mov r2, #0x18
	bl AnimatorSprite__Init
	mov r0, r6
	mov r1, #1
	add r0, #0x50
	strh r1, [r0]
	str r1, [r6, #0x58]
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, _0215B584 // =0x00000438
	mov r1, #0x19
	add r6, r4, r0
	mov r0, r7
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215B580 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #2
	str r0, [sp, #0x14]
	mov r0, #0x1e
	str r0, [sp, #0x18]
	mov r0, r6
	mov r1, r7
	mov r2, #0x19
	bl AnimatorSprite__Init
	mov r0, r6
	mov r1, #2
	add r0, #0x50
	strh r1, [r0]
	mov r0, #1
	mov r1, #0
	str r0, [r6, #0x58]
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, _0215B588 // =gameState
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _0215B3F0
	cmp r0, #1
	beq _0215B40C
	b _0215B426
_0215B3F0:
	bl MultibootManager__Func_2060CF0
	cmp r0, #2
	bne _0215B3FC
	mov r5, #0
	b _0215B426
_0215B3FC:
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	beq _0215B408
	mov r5, #0
	b _0215B426
_0215B408:
	mov r5, #1
	b _0215B426
_0215B40C:
	bl MultibootManager__Func_2060CF0
	cmp r0, #2
	bne _0215B418
	mov r5, #1
	b _0215B426
_0215B418:
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	beq _0215B424
	mov r5, #1
	b _0215B426
_0215B424:
	mov r5, #0
_0215B426:
	cmp r5, #0
	beq _0215B430
	cmp r5, #1
	beq _0215B4BC
	b _0215B546
_0215B430:
	mov r0, r4
	add r0, #8
	mov r1, #0
	str r1, [r0, #0x48]
	mov r1, #0xe
	lsl r1, r1, #0xa
	str r1, [r0, #0x4c]
	ldr r1, _0215B58C // =0xFFFFACCD
	ldr r3, _0215B590 // =FX_SinCosTable_+0x000001C0
	str r1, [r0, #0x50]
	mov r1, #4
	mov r2, #6
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, #0x24
	bl MTX_RotY33_
	mov r0, #0x53
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0
	str r1, [r0, #0x48]
	mov r1, #0xe
	lsl r1, r1, #0xa
	str r1, [r0, #0x4c]
	ldr r1, _0215B594 // =0x00005333
	ldr r3, _0215B598 // =FX_SinCosTable_+0x00003E00
	str r1, [r0, #0x50]
	mov r1, #0x38
	mov r2, #0x3a
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, #0x24
	bl MTX_RotY33_
	mov r1, #0x29
	lsl r1, r1, #4
	add r2, r4, r1
	mov r0, #0
	str r0, [r2, #0x48]
	mov r0, #0xe
	lsl r0, r0, #0xa
	str r0, [r2, #0x4c]
	ldr r0, _0215B594 // =0x00005333
	add r1, #0x24
	str r0, [r2, #0x50]
	mov r0, #0x17
	lsl r0, r0, #4
	add r0, r4, r0
	add r1, r4, r1
	mov r2, #0x24
	bl RenderCore_CPUCopy
	mov r0, #0xf5
	lsl r0, r0, #2
	add r2, r4, r0
	mov r1, #8
	strh r1, [r2, #8]
	mov r1, #0x70
	add r0, #0x64
	strh r1, [r2, #0xa]
	add r2, r4, r0
	mov r0, #0xf8
	strh r0, [r2, #8]
	strh r1, [r2, #0xa]
	ldr r1, [r2, #0x3c]
	mov r0, #0x80
	orr r0, r1
	str r0, [r2, #0x3c]
	b _0215B546
_0215B4BC:
	mov r0, r4
	add r0, #8
	mov r1, #0
	str r1, [r0, #0x48]
	mov r1, #0xe
	lsl r1, r1, #0xa
	str r1, [r0, #0x4c]
	ldr r1, _0215B594 // =0x00005333
	ldr r3, _0215B598 // =FX_SinCosTable_+0x00003E00
	str r1, [r0, #0x50]
	mov r1, #0x38
	mov r2, #0x3a
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, #0x24
	bl MTX_RotY33_
	mov r0, #0x53
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0
	str r1, [r0, #0x48]
	mov r1, #0xe
	lsl r1, r1, #0xa
	str r1, [r0, #0x4c]
	ldr r1, _0215B58C // =0xFFFFACCD
	ldr r3, _0215B590 // =FX_SinCosTable_+0x000001C0
	str r1, [r0, #0x50]
	mov r1, #4
	mov r2, #6
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, #0x24
	bl MTX_RotY33_
	mov r1, #0x29
	lsl r1, r1, #4
	add r2, r4, r1
	mov r0, #0
	str r0, [r2, #0x48]
	mov r0, #0xe
	lsl r0, r0, #0xa
	str r0, [r2, #0x4c]
	ldr r0, _0215B58C // =0xFFFFACCD
	add r1, #0x24
	str r0, [r2, #0x50]
	mov r0, #0x17
	lsl r0, r0, #4
	add r0, r4, r0
	add r1, r4, r1
	mov r2, #0x24
	bl RenderCore_CPUCopy
	mov r3, #0xf5
	lsl r3, r3, #2
	add r1, r4, r3
	mov r0, #0xf8
	strh r0, [r1, #8]
	mov r0, #0x70
	strh r0, [r1, #0xa]
	ldr r5, [r1, #0x3c]
	mov r2, #0x80
	orr r2, r5
	str r2, [r1, #0x3c]
	add r3, #0x64
	add r2, r4, r3
	mov r1, #8
	strh r1, [r2, #8]
	strh r0, [r2, #0xa]
_0215B546:
	ldr r0, _0215B59C // =0x00002043
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215B5A0 // =VSStageClearPlayers__Main1
	str r1, [sp, #8]
	mov r2, r1
	mov r3, r1
	bl TaskCreate_
	mov r1, #0
	str r0, [r4]
	ldr r0, _0215B5A4 // =0x00002083
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215B5A8 // =VSStageClearPlayers__Main2
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r4, #4]
	add sp, #0x38
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215B578: .word 0x00000CCC
_0215B57C: .word 0x001FFFFF
_0215B580: .word 0x05000200
_0215B584: .word 0x00000438
_0215B588: .word gameState
_0215B58C: .word 0xFFFFACCD
_0215B590: .word FX_SinCosTable_+0x000001C0
_0215B594: .word 0x00005333
_0215B598: .word FX_SinCosTable_+0x00003E00
_0215B59C: .word 0x00002043
_0215B5A0: .word VSStageClearPlayers__Main1
_0215B5A4: .word 0x00002083
_0215B5A8: .word VSStageClearPlayers__Main2
	thumb_func_end VSStageClearPlayers__Create

	thumb_func_start VSStageClearPlayers__Destroy
VSStageClearPlayers__Destroy: // 0x0215B5AC
	push {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0x67
	lsl r0, r0, #2
	add r4, r5, r0
	mov r0, r4
	add r0, #8
	bl AnimatorMDL__Release
	mov r0, #0x53
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorMDL__Release
	mov r0, #0x29
	lsl r0, r0, #4
	add r0, r4, r0
	bl AnimatorMDL__Release
	mov r0, #0xf5
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__Release
	ldr r0, _0215B600 // =0x00000438
	add r0, r4, r0
	bl AnimatorSprite__Release
	mov r0, #0x67
	lsl r0, r0, #2
	ldr r0, [r5, r0]
	cmp r0, #0
	beq _0215B5F2
	bl DestroyTask
_0215B5F2:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0215B5FC
	bl DestroyTask
_0215B5FC:
	pop {r3, r4, r5, pc}
	nop
_0215B600: .word 0x00000438
	thumb_func_end VSStageClearPlayers__Destroy

	thumb_func_start VSStageClearResults__Create
VSStageClearResults__Create: // 0x0215B604
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	mov r5, r0
	ldr r1, _0215B7E8 // =0x0000063C
	add r5, #0x50
	str r0, [sp, #0x1c]
	add r4, r0, r1
	ldr r0, [r5, #4]
	cmp r0, #2
	bne _0215B61E
	mov r6, #8
	mov r7, r6
	b _0215B660
_0215B61E:
	bl MultibootManager__Func_2060CF0
	cmp r0, #2
	bne _0215B638
	ldr r0, [r5, #4]
	cmp r0, #1
	bne _0215B632
	mov r6, #6
	mov r7, #7
	b _0215B660
_0215B632:
	mov r6, #7
	mov r7, #6
	b _0215B660
_0215B638:
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	ldr r0, [r5, #4]
	beq _0215B652
	cmp r0, #1
	bne _0215B64C
	mov r6, #6
	mov r7, #7
	b _0215B660
_0215B64C:
	mov r6, #7
	mov r7, #6
	b _0215B660
_0215B652:
	cmp r0, #1
	bne _0215B65C
	mov r6, #7
	mov r7, #6
	b _0215B660
_0215B65C:
	mov r6, #6
	mov r7, #7
_0215B660:
	ldr r0, [sp, #0x1c]
	mov r5, r4
	ldr r0, [r0, #0x34]
	mov r1, r6
	str r0, [sp, #0x20]
	add r5, #8
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, _0215B7EC // =0x05000200
	mov r3, #0x10
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r3, [sp, #0x18]
	ldr r1, [sp, #0x20]
	mov r0, r5
	mov r2, r6
	lsl r3, r3, #5
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #3
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0x44
	strh r0, [r5, #8]
	mov r0, #0x88
	strh r0, [r5, #0xa]
	mov r0, #1
	mov r1, #0
	str r0, [r5, #0x58]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r5, r4
	ldr r0, [sp, #0x20]
	mov r1, r7
	add r5, #0x6c
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, _0215B7EC // =0x05000200
	mov r3, #0x10
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r3, [sp, #0x18]
	ldr r1, [sp, #0x20]
	mov r0, r5
	mov r2, r7
	lsl r3, r3, #5
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #0xe
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0xbc
	strh r0, [r5, #8]
	mov r0, #0x88
	strh r0, [r5, #0xa]
	mov r0, #1
	mov r1, #0
	str r0, [r5, #0x58]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x1c]
	mov r5, r4
	ldr r6, [r0, #0x30]
	mov r1, #0
	mov r0, r6
	add r5, #0xd0
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215B7EC // =0x05000200
	str r2, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #2
	str r0, [sp, #0x14]
	mov r0, #0x10
	str r0, [sp, #0x18]
	mov r0, r5
	mov r1, r6
	mov r3, r2
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #4
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0x80
	strh r0, [r5, #8]
	mov r0, #0x50
	strh r0, [r5, #0xa]
	mov r0, #1
	mov r1, #0
	str r0, [r5, #0x58]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x1c]
	mov r1, #2
	ldr r6, [r0, #0x30]
	mov r0, #0x4d
	lsl r0, r0, #2
	add r5, r4, r0
	mov r0, r6
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215B7EC // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r2, #2
	str r2, [sp, #0x14]
	mov r0, #0x14
	str r0, [sp, #0x18]
	mov r0, r5
	mov r1, r6
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #5
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0x80
	strh r0, [r5, #8]
	mov r0, #0x50
	strh r0, [r5, #0xa]
	mov r0, #1
	mov r1, #0
	str r0, [r5, #0x58]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	ldr r0, _0215B7F0 // =0x00002044
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215B7F4 // =VSStageClearResults__Main1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r4]
	ldr r0, _0215B7F8 // =0x00002084
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215B7FC // =VSStageClearResults__Main2
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r4, #4]
	add sp, #0x24
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_0215B7E8: .word 0x0000063C
_0215B7EC: .word 0x05000200
_0215B7F0: .word 0x00002044
_0215B7F4: .word VSStageClearResults__Main1
_0215B7F8: .word 0x00002084
_0215B7FC: .word VSStageClearResults__Main2
	thumb_func_end VSStageClearResults__Create

	thumb_func_start VSStageClearResults__Destroy
VSStageClearResults__Destroy: // 0x0215B800
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _0215B844 // =0x0000063C
	add r4, r5, r0
	mov r0, r4
	add r0, #8
	bl AnimatorSprite__Release
	mov r0, r4
	add r0, #0x6c
	bl AnimatorSprite__Release
	mov r0, r4
	add r0, #0xd0
	bl AnimatorSprite__Release
	mov r0, #0x4d
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__Release
	ldr r0, _0215B844 // =0x0000063C
	ldr r0, [r5, r0]
	cmp r0, #0
	beq _0215B836
	bl DestroyTask
_0215B836:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0215B840
	bl DestroyTask
_0215B840:
	pop {r3, r4, r5, pc}
	nop
_0215B844: .word 0x0000063C
	thumb_func_end VSStageClearResults__Destroy

	thumb_func_start VSStageClearScoreDisplay__Create
VSStageClearScoreDisplay__Create: // 0x0215B848
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x30
	mov r4, r0
	ldr r0, _0215BB6C // =0x000007E4
	mov r5, r4
	add r0, r4, r0
	add r5, #0x50
	str r0, [sp, #0x2c]
	bl MultibootManager__Func_2060CF0
	cmp r0, #2
	bne _0215B86C
	ldr r1, [r5, #0xc]
	ldr r0, [sp, #0x2c]
	str r1, [r0, #0x10]
	ldr r1, [r5, #0x10]
	str r1, [r0, #0x14]
	b _0215B88A
_0215B86C:
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	beq _0215B880
	ldr r1, [r5, #0xc]
	ldr r0, [sp, #0x2c]
	str r1, [r0, #0x10]
	ldr r1, [r5, #0x10]
	str r1, [r0, #0x14]
	b _0215B88A
_0215B880:
	ldr r1, [r5, #0x10]
	ldr r0, [sp, #0x2c]
	str r1, [r0, #0x10]
	ldr r1, [r5, #0xc]
	str r1, [r0, #0x14]
_0215B88A:
	bl VSStageClear__IsRace
	cmp r0, #0
	beq _0215B8B2
	mov r0, #0x65
	lsl r0, r0, #4
	ldrh r1, [r4, r0]
	cmp r1, #7
	bne _0215B8A4
	ldr r0, [sp, #0x2c]
	mov r1, #0
	str r1, [r0, #0x10]
	b _0215B8B2
_0215B8A4:
	add r0, #0x64
	ldrh r0, [r4, r0]
	cmp r0, #7
	bne _0215B8B2
	ldr r0, [sp, #0x2c]
	mov r1, #0
	str r1, [r0, #0x14]
_0215B8B2:
	mov r1, #0xb7
	ldr r0, [sp, #0x2c]
	mvn r1, r1
	strh r1, [r0, #8]
	mov r2, #0x9c
	mov r1, #0x6e
	mov r6, r0
	strh r2, [r0, #0xa]
	lsl r1, r1, #2
	strh r1, [r0, #0xc]
	strh r2, [r0, #0xe]
	ldr r0, [r5, #0]
	add r6, #0x20
	ldr r4, [r4, #0x2c]
	cmp r0, #0
	beq _0215B8D8
	cmp r0, #1
	beq _0215B8DE
	b _0215B8E2
_0215B8D8:
	mov r0, #0x1c
	str r0, [sp, #0x28]
	b _0215B8E2
_0215B8DE:
	mov r0, #0x1b
	str r0, [sp, #0x28]
_0215B8E2:
	ldr r1, [sp, #0x28]
	mov r0, r4
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215BB70 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0x10
	str r0, [sp, #0x18]
	ldr r2, [sp, #0x28]
	mov r0, r6
	mov r1, r4
	bl AnimatorSprite__Init
	mov r0, r6
	mov r1, #6
	add r0, #0x50
	strh r1, [r0]
	mov r0, #1
	mov r1, #0
	str r0, [r6, #0x58]
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r5, [sp, #0x2c]
	mov r0, r4
	mov r1, #0xa
	add r5, #0x84
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215BB70 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0x1e
	str r0, [sp, #0x18]
	mov r0, r5
	mov r1, r4
	mov r2, #0xa
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #7
	add r0, #0x50
	strh r1, [r0]
	mov r0, #1
	mov r1, #0
	str r0, [r5, #0x58]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r5, [sp, #0x2c]
	ldr r1, _0215BB74 // =0x000005FC
	ldr r0, [sp, #0x2c]
	mov r7, #0
	add r5, #0xe8
	add r6, r0, r1
_0215B97E:
	lsl r0, r7, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x28]
	ldr r1, [sp, #0x28]
	mov r0, r4
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, _0215BB70 // =0x05000200
	mov r1, r4
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0xc
	str r0, [sp, #0x18]
	ldr r2, [sp, #0x28]
	mov r0, r5
	mov r3, #0
	bl AnimatorSprite__Init
	mov r1, r5
	add r1, #0x50
	mov r0, #8
	strh r0, [r1]
	mov r0, #1
	mov r1, #0
	str r0, [r5, #0x58]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	lsl r0, r7, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x1c]
	ldr r1, [sp, #0x1c]
	mov r0, r4
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, _0215BB70 // =0x05000200
	mov r1, r4
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0xc
	str r0, [sp, #0x18]
	ldr r2, [sp, #0x1c]
	mov r0, r6
	mov r3, #0
	bl AnimatorSprite__Init
	mov r1, r6
	add r1, #0x50
	mov r0, #0xf
	strh r0, [r1]
	mov r0, #1
	mov r1, #0
	str r0, [r6, #0x58]
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r7, r7, #1
	add r5, #0x64
	add r6, #0x64
	cmp r7, #0xa
	blo _0215B97E
	mov r1, #0x4d
	ldr r0, [sp, #0x2c]
	lsl r1, r1, #4
	add r6, r0, r1
	ldr r1, _0215BB78 // =0x000009E4
	mov r7, #0
	add r5, r0, r1
_0215BA36:
	mov r0, r7
	add r0, #0x14
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x20]
	ldr r1, [sp, #0x20]
	mov r0, r4
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, _0215BB70 // =0x05000200
	mov r1, r4
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0xa
	str r0, [sp, #0x18]
	ldr r2, [sp, #0x20]
	mov r0, r6
	mov r3, #0
	bl AnimatorSprite__Init
	mov r1, r6
	add r1, #0x50
	mov r0, #8
	strh r0, [r1]
	mov r0, #1
	mov r1, #0
	str r0, [r6, #0x58]
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r7
	add r0, #0x14
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x24]
	ldr r1, [sp, #0x24]
	mov r0, r4
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, _0215BB70 // =0x05000200
	mov r1, r4
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0xa
	str r0, [sp, #0x18]
	ldr r2, [sp, #0x24]
	mov r0, r5
	mov r3, #0
	bl AnimatorSprite__Init
	mov r1, r5
	add r1, #0x50
	mov r0, #0xf
	strh r0, [r1]
	mov r0, #1
	mov r1, #0
	str r0, [r5, #0x58]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r7, r7, #1
	add r6, #0x64
	add r5, #0x64
	cmp r7, #3
	blo _0215BA36
	mov r1, #0xb1
	ldr r0, [sp, #0x2c]
	lsl r1, r1, #4
	add r5, r0, r1
	mov r0, r4
	mov r1, #0x17
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, _0215BB70 // =0x05000200
	mov r1, r4
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0xa
	str r0, [sp, #0x18]
	mov r0, r5
	mov r2, #0x17
	mov r3, #4
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #0xf
	add r0, #0x50
	strh r1, [r0]
	mov r0, #1
	mov r1, #0
	str r0, [r5, #0x58]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	ldr r0, _0215BB7C // =0x00002045
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215BB80 // =VSStageClearScoreDisplay__Main1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	mov r1, #0
	ldr r0, _0215BB84 // =0x00002085
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215BB88 // =VSStageClearScoreDisplay__Main2
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	ldr r1, [sp, #0x2c]
	str r0, [r1, #4]
	add sp, #0x30
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215BB6C: .word 0x000007E4
_0215BB70: .word 0x05000200
_0215BB74: .word 0x000005FC
_0215BB78: .word 0x000009E4
_0215BB7C: .word 0x00002045
_0215BB80: .word VSStageClearScoreDisplay__Main1
_0215BB84: .word 0x00002085
_0215BB88: .word VSStageClearScoreDisplay__Main2
	thumb_func_end VSStageClearScoreDisplay__Create

	thumb_func_start VSStageClearScoreDisplay__Destroy
VSStageClearScoreDisplay__Destroy: // 0x0215BB8C
	push {r4, r5, r6, lr}
	ldr r1, _0215BC28 // =0x000007E4
	add r6, r0, r1
	mov r0, r6
	add r0, #0x20
	bl AnimatorSprite__Release
	mov r0, r6
	add r0, #0x84
	bl AnimatorSprite__Release
	mov r0, #0x4d
	mov r5, r6
	lsl r0, r0, #4
	add r5, #0xe8
	add r4, r6, r0
	cmp r5, r4
	beq _0215BBBC
_0215BBB0:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _0215BBB0
_0215BBBC:
	ldr r0, _0215BC2C // =0x000005FC
	add r5, r6, r0
	ldr r0, _0215BC30 // =0x000009E4
	add r4, r6, r0
	cmp r5, r4
	beq _0215BBD4
_0215BBC8:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _0215BBC8
_0215BBD4:
	mov r0, #0x4d
	lsl r0, r0, #4
	add r5, r6, r0
	ldr r0, _0215BC2C // =0x000005FC
	add r4, r6, r0
	cmp r5, r4
	beq _0215BBEE
_0215BBE2:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _0215BBE2
_0215BBEE:
	ldr r0, _0215BC30 // =0x000009E4
	add r5, r6, r0
	mov r0, #0xb1
	lsl r0, r0, #4
	add r4, r6, r0
	cmp r5, r4
	beq _0215BC08
_0215BBFC:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _0215BBFC
_0215BC08:
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r6, r0
	bl AnimatorSprite__Release
	ldr r0, [r6, #0]
	cmp r0, #0
	beq _0215BC1C
	bl DestroyTask
_0215BC1C:
	ldr r0, [r6, #4]
	cmp r0, #0
	beq _0215BC26
	bl DestroyTask
_0215BC26:
	pop {r4, r5, r6, pc}
	.align 2, 0
_0215BC28: .word 0x000007E4
_0215BC2C: .word 0x000005FC
_0215BC30: .word 0x000009E4
	thumb_func_end VSStageClearScoreDisplay__Destroy

	thumb_func_start VSStageClearPlayerNames__Create
VSStageClearPlayerNames__Create: // 0x0215BC34
	push {r4, r5, r6, lr}
	sub sp, #0x20
	mov r5, r0
	ldr r0, _0215BDF4 // =0x0000135C
	add r4, r5, r0
	ldr r0, _0215BDF8 // =saveGame
	bl SaveGame__GetPlayerNameLength
	mov r1, r4
	lsl r6, r0, #0x10
	mov r0, #0
	add r1, #0x6c
	mov r2, #0x12
	bl MIi_CpuClear16
	mov r1, r4
	ldr r0, _0215BDF8 // =saveGame
	add r1, #0x6c
	lsr r2, r6, #0xf
	bl MIi_CpuCopy16
	bl MultibootManager__Func_2060D74
	mov r1, r4
	mov r6, r0
	mov r0, #0
	add r1, #0x7e
	mov r2, #0x12
	bl MIi_CpuClear16
	bl MultibootManager__Func_2060D4C
	mov r1, r4
	add r1, #0x7e
	lsl r2, r6, #1
	bl MIi_CpuCopy16
	mov r0, r4
	mov r1, #0
	add r0, #0x90
	str r1, [r0]
	mov r0, r4
	add r0, #0x94
	str r1, [r0]
	mov r0, #0x2a
	lsl r0, r0, #6
	bl _AllocHeadHEAP_USER
	mov r1, r4
	add r1, #0xc8
	str r0, [r1]
	mov r1, r4
	add r1, #0xc8
	mov r2, #0x2a
	ldr r1, [r1, #0]
	mov r0, #0
	lsl r2, r2, #6
	bl MIi_CpuClearFast
	mov r0, #2
	str r0, [sp]
	str r0, [sp, #4]
	mov r1, #0x1c
	str r1, [sp, #8]
	mov r1, #3
	str r1, [sp, #0xc]
	mov r1, r4
	add r1, #0xc8
	ldr r1, [r1, #0]
	lsl r0, r0, #0xc
	str r1, [sp, #0x10]
	mov r1, #0
	str r1, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r4
	add r0, #0x98
	mov r2, #1
	mov r3, r1
	bl Unknown2056570__Init
	mov r0, r4
	add r0, #0x98
	mov r1, #0
	bl Unknown2056570__Func_2056688
	ldr r0, _0215BDFC // =FontAnimator__Palettes+0x00000008
	ldr r3, _0215BE00 // =0x05000002
	mov r1, #4
	mov r2, #0
	bl QueueUncompressedPalette
	bl MultibootManager__Func_2060CF0
	cmp r0, #2
	bne _0215BCF8
	mov r2, #0
	mov r6, #1
	b _0215BD0A
_0215BCF8:
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	beq _0215BD06
	mov r2, #0
	mov r6, #1
	b _0215BD0A
_0215BD06:
	mov r2, #1
	mov r6, #0
_0215BD0A:
	mov r0, #0x34
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	mov r1, #0
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #8
	str r0, [sp, #0x10]
	mov r3, #0x12
	mul r3, r2
	ldr r0, _0215BE04 // =0x0217E968
	str r1, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r4
	add r0, #0x6c
	add r0, r0, r3
	str r0, [sp, #0x1c]
	ldr r0, _0215BE08 // =0x0000183C
	mov r3, r4
	add r0, r5, r0
	mov r2, r1
	add r3, #0x98
	bl FontFile__Func_20530D8
	mov r0, #0xa8
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	mov r1, #0
	str r1, [sp, #8]
	mov r2, r4
	mov r3, r4
	str r1, [sp, #0xc]
	mov r0, #8
	str r0, [sp, #0x10]
	ldr r0, _0215BE04 // =0x0217E968
	str r1, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, #0x12
	add r2, #0x6c
	mul r0, r6
	add r0, r2, r0
	str r0, [sp, #0x1c]
	ldr r0, _0215BE08 // =0x0000183C
	mov r2, r1
	add r0, r5, r0
	add r3, #0x98
	bl FontFile__Func_20530D8
	mov r0, r4
	add r0, #0x98
	bl Unknown2056570__Func_2056B8C
	ldr r6, [r5, #0x2c]
	mov r5, r4
	mov r0, r6
	mov r1, #0x1a
	add r5, #8
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215BE0C // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0x1c
	str r0, [sp, #0x18]
	mov r0, r5
	mov r1, r6
	mov r2, #0x1a
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #9
	add r0, #0x50
	strh r1, [r0]
	mov r0, #1
	mov r1, #0
	str r0, [r5, #0x58]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, _0215BE10 // =0x00002046
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215BE14 // =VSStageClearPlayerNames__Main1
	str r1, [sp, #8]
	mov r2, r1
	mov r3, r1
	bl TaskCreate_
	mov r1, #0
	str r0, [r4]
	ldr r0, _0215BE18 // =0x00002086
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215BE1C // =VSStageClearPlayerNames__Main2
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r4, #4]
	add sp, #0x20
	pop {r4, r5, r6, pc}
	nop
_0215BDF4: .word 0x0000135C
_0215BDF8: .word saveGame
_0215BDFC: .word FontAnimator__Palettes+0x00000008
_0215BE00: .word 0x05000002
_0215BE04: .word 0x0217E968
_0215BE08: .word 0x0000183C
_0215BE0C: .word 0x05000200
_0215BE10: .word 0x00002046
_0215BE14: .word VSStageClearPlayerNames__Main1
_0215BE18: .word 0x00002086
_0215BE1C: .word VSStageClearPlayerNames__Main2
	thumb_func_end VSStageClearPlayerNames__Create

	thumb_func_start VSStageClearPlayerNames__Destroy
VSStageClearPlayerNames__Destroy: // 0x0215BE20
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _0215BE64 // =0x0000135C
	add r4, r5, r0
	mov r0, r4
	add r0, #0x98
	bl Unknown2056570__Func_2056670
	mov r0, r4
	add r0, #0xc8
	ldr r0, [r0, #0]
	bl _FreeHEAP_USER
	mov r0, r4
	mov r1, #0
	add r0, #0xc8
	str r1, [r0]
	mov r0, r4
	add r0, #8
	bl AnimatorSprite__Release
	ldr r0, _0215BE64 // =0x0000135C
	ldr r0, [r5, r0]
	cmp r0, #0
	beq _0215BE56
	bl DestroyTask
_0215BE56:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0215BE60
	bl DestroyTask
_0215BE60:
	pop {r3, r4, r5, pc}
	nop
_0215BE64: .word 0x0000135C
	thumb_func_end VSStageClearPlayerNames__Destroy

	thumb_func_start VSStageClearButtons__Create
VSStageClearButtons__Create: // 0x0215BE68
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	mov r4, r0
	ldr r0, _0215C0CC // =0x00001428
	ldr r6, [r4, #0x34]
	add r7, r4, r0
	mov r5, r7
	mov r0, r6
	mov r1, #1
	add r5, #8
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, _0215C0D0 // =0x05000200
	mov r2, #1
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r0, #4
	str r0, [sp, #0x18]
	ldr r3, _0215C0D4 // =0x00000804
	mov r0, r5
	mov r1, r6
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #0xa
	add r0, #0x50
	strh r1, [r0]
	ldr r1, [r5, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r5, #0x3c]
	mov r0, #0x30
	strh r0, [r5, #8]
	mov r0, #0xc0
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r6, [r4, #0x34]
	mov r5, r7
	mov r0, r6
	mov r1, #3
	add r5, #0x6c
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, _0215C0D0 // =0x05000200
	ldr r3, _0215C0D4 // =0x00000804
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #4
	str r0, [sp, #0x18]
	mov r0, r5
	mov r1, r6
	mov r2, #3
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #0xb
	add r0, #0x50
	strh r1, [r0]
	ldr r1, [r5, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r5, #0x3c]
	mov r0, #0x30
	strh r0, [r5, #8]
	mov r0, #0xe2
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r6, [r4, #0x24]
	mov r5, r7
	mov r0, r6
	mov r1, #0
	add r5, #0xd0
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215C0D0 // =0x05000200
	str r2, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #2
	str r0, [sp, #0x18]
	ldr r3, _0215C0D4 // =0x00000804
	mov r0, r5
	mov r1, r6
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #0xc
	add r0, #0x50
	strh r1, [r0]
	ldr r1, [r5, #0x3c]
	mov r0, #1
	orr r0, r1
	mov r1, #0
	str r0, [r5, #0x3c]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x4d
	lsl r0, r0, #2
	ldr r6, [r4, #0x2c]
	add r5, r7, r0
	mov r0, r6
	mov r1, #0x1e
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215C0D0 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #8
	str r0, [sp, #0x18]
	mov r0, r5
	mov r1, r6
	mov r2, #0x1e
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #0xd
	add r0, #0x50
	strh r1, [r0]
	ldr r1, [r5, #0x3c]
	mov r0, #1
	orr r0, r1
	mov r1, #0
	str r0, [r5, #0x3c]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x66
	lsl r0, r0, #2
	ldr r6, [r4, #0x48]
	add r5, r7, r0
	mov r0, r6
	mov r1, #4
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, _0215C0D0 // =0x05000200
	ldr r3, _0215C0D4 // =0x00000804
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r5
	mov r1, r6
	mov r2, #4
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #0xc
	add r0, #0x50
	strh r1, [r0]
	ldr r1, [r5, #0x3c]
	mov r0, #3
	orr r0, r1
	str r0, [r5, #0x3c]
	mov r0, #0x80
	strh r0, [r5, #8]
	mov r0, #0x60
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x7f
	lsl r0, r0, #2
	ldr r6, [r4, #0x44]
	add r5, r7, r0
	mov r0, r6
	mov r1, #0x1b
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215C0D0 // =0x05000200
	str r1, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r3, _0215C0D4 // =0x00000804
	mov r0, r5
	mov r1, r6
	mov r2, #0x1b
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #0xd
	add r0, #0x50
	strh r1, [r0]
	ldr r1, [r5, #0x3c]
	mov r0, #3
	orr r0, r1
	mov r1, #0
	str r0, [r5, #0x3c]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r6, [r4, #0x3c]
	mov r4, #0
	mov r5, r7
_0215C078:
	mov r0, r6
	add r1, sp, #0x1c
	mov r2, r4
	bl GetDrawStateLight
	add r0, sp, #0x1c
	ldrh r1, [r0, #6]
	mov r0, #0x26
	lsl r0, r0, #4
	strh r1, [r5, r0]
	add r4, r4, #1
	add r5, r5, #2
	cmp r4, #4
	blt _0215C078
	mov r1, #5
	add r0, #8
	str r1, [r7, r0]
	mov r1, #0
	ldr r0, _0215C0D8 // =0x00002048
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215C0DC // =VSStageClearButtons__Main1
	str r1, [sp, #8]
	mov r3, r1
	bl TaskCreate_
	mov r1, #0
	str r0, [r7]
	ldr r0, _0215C0E0 // =0x00002088
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215C0E4 // =VSStageClearButtons__Main2
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r7, #4]
	add sp, #0x24
	pop {r4, r5, r6, r7, pc}
	nop
_0215C0CC: .word 0x00001428
_0215C0D0: .word 0x05000200
_0215C0D4: .word 0x00000804
_0215C0D8: .word 0x00002048
_0215C0DC: .word VSStageClearButtons__Main1
_0215C0E0: .word 0x00002088
_0215C0E4: .word VSStageClearButtons__Main2
	thumb_func_end VSStageClearButtons__Create

	thumb_func_start VSStageClearButtons__Destroy
VSStageClearButtons__Destroy: // 0x0215C0E8
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _0215C140 // =0x00001428
	add r4, r5, r0
	mov r0, r4
	add r0, #8
	bl AnimatorSprite__Release
	mov r0, r4
	add r0, #0x6c
	bl AnimatorSprite__Release
	mov r0, r4
	add r0, #0xd0
	bl AnimatorSprite__Release
	mov r0, #0x4d
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__Release
	mov r0, #0x66
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__Release
	mov r0, #0x7f
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__Release
	ldr r0, _0215C140 // =0x00001428
	ldr r0, [r5, r0]
	cmp r0, #0
	beq _0215C132
	bl DestroyTask
_0215C132:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0215C13C
	bl DestroyTask
_0215C13C:
	pop {r3, r4, r5, pc}
	nop
_0215C140: .word 0x00001428
	thumb_func_end VSStageClearButtons__Destroy

	thumb_func_start VSStageClearTimer__Create
VSStageClearTimer__Create: // 0x0215C144
	push {r4, r5, r6, r7, lr}
	sub sp, #0x1c
	mov r6, r0
	ldr r0, _0215C2BC // =0x0000169C
	ldr r7, [r6, #0x28]
	add r4, r6, r0
	mov r5, r4
	mov r0, r7
	mov r1, #0xc
	add r5, #0x6c
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215C2C0 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, r5
	mov r1, r7
	mov r2, #0xc
	str r3, [sp, #0x18]
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #0
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0x74
	strh r0, [r5, #8]
	mov r0, #0x2b
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r7, [r6, #0x28]
	mov r5, r4
	mov r0, r7
	mov r1, #0xb
	add r5, #8
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215C2C0 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r5
	mov r1, r7
	mov r2, #0xb
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #0
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0x70
	strh r0, [r5, #8]
	mov r0, #0x2a
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r7, [r6, #0x28]
	mov r5, r4
	mov r0, r7
	mov r1, #0
	add r5, #0xd0
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215C2C0 // =0x05000200
	str r2, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, r5
	mov r1, r7
	mov r3, r2
	str r2, [sp, #0x18]
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #0
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0x88
	strh r0, [r5, #8]
	mov r0, #0x2b
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x4d
	lsl r0, r0, #2
	ldr r6, [r6, #0x28]
	add r5, r4, r0
	mov r0, r6
	mov r1, #0
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215C2C0 // =0x05000200
	str r2, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, r5
	mov r1, r6
	mov r3, r2
	str r2, [sp, #0x18]
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #0
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0x82
	strh r0, [r5, #8]
	mov r0, #0x2b
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	mov r0, #0x66
	mvn r1, r1
	lsl r0, r0, #2
	str r1, [r4, r0]
	mov r1, #0
	ldr r0, _0215C2C4 // =0x00002047
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215C2C8 // =VSStageClearTimer__Main1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r4]
	ldr r0, _0215C2CC // =0x00002087
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215C2D0 // =VSStageClearTimer__Main2
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r4, #4]
	add sp, #0x1c
	pop {r4, r5, r6, r7, pc}
	nop
_0215C2BC: .word 0x0000169C
_0215C2C0: .word 0x05000200
_0215C2C4: .word 0x00002047
_0215C2C8: .word VSStageClearTimer__Main1
_0215C2CC: .word 0x00002087
_0215C2D0: .word VSStageClearTimer__Main2
	thumb_func_end VSStageClearTimer__Create

	thumb_func_start VSStageClearTimer__Destroy
VSStageClearTimer__Destroy: // 0x0215C2D4
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _0215C318 // =0x0000169C
	add r4, r5, r0
	mov r0, r4
	add r0, #0x6c
	bl AnimatorSprite__Release
	mov r0, r4
	add r0, #8
	bl AnimatorSprite__Release
	mov r0, r4
	add r0, #0xd0
	bl AnimatorSprite__Release
	mov r0, #0x4d
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__Release
	ldr r0, _0215C318 // =0x0000169C
	ldr r0, [r5, r0]
	cmp r0, #0
	beq _0215C30A
	bl DestroyTask
_0215C30A:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0215C314
	bl DestroyTask
_0215C314:
	pop {r3, r4, r5, pc}
	nop
_0215C318: .word 0x0000169C
	thumb_func_end VSStageClearTimer__Destroy

	thumb_func_start VSStageClear__Func_215C31C
VSStageClear__Func_215C31C: // 0x0215C31C
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	str r0, [sp]
	ldr r0, [sp, #0x24]
	str r2, [sp, #4]
	str r0, [sp, #0x24]
	str r3, [sp, #8]
	add r0, sp, #0x10
	ldrh r7, [r0, #0x10]
	ldr r0, [sp, #8]
	mov r5, r1
	mov r1, r0
	mul r1, r7
	add r0, r5, r1
	lsl r0, r0, #0x10
	ldr r4, [sp, #0x28]
	asr r5, r0, #0x10
	mov r6, #0
	cmp r7, #0
	bls _0215C382
_0215C344:
	mov r0, r4
	mov r1, #0xa
	bl _u32_div_f
	mov r2, r1
	ldr r1, [sp, #8]
	mov r0, #0x64
	mul r2, r0
	ldr r0, [sp]
	sub r1, r5, r1
	lsl r1, r1, #0x10
	add r0, r0, r2
	asr r5, r1, #0x10
	strh r5, [r0, #8]
	ldr r1, [sp, #4]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	mov r1, #0xa
	bl _u32_div_f
	mov r4, r0
	ldr r0, [sp, #0x24]
	cmp r0, #0
	bne _0215C37C
	cmp r4, #0
	beq _0215C382
_0215C37C:
	add r6, r6, #1
	cmp r6, r7
	blo _0215C344
_0215C382:
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
	thumb_func_end VSStageClear__Func_215C31C

	thumb_func_start VSStageClear__Func_215C388
VSStageClear__Func_215C388: // 0x0215C388
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x28
	ldr r4, [sp, #0x40]
	str r0, [sp]
	mov r0, #7
	mov r5, r2
	mul r0, r4
	add r0, r5, r0
	lsl r0, r0, #0x10
	ldr r7, [sp, #0x44]
	str r1, [sp, #4]
	mov r6, r3
	asr r5, r0, #0x10
	cmp r7, #0
	beq _0215C470
	add r2, sp, #0x20
	mov r0, r7
	add r1, sp, #0x24
	add r2, #2
	add r3, sp, #0x20
	bl AkUtilFrameToTime
	add r0, sp, #0x20
	ldrh r7, [r0, #0]
	mov r0, #0
	str r0, [sp, #0x1c]
_0215C3BC:
	mov r0, r7
	mov r1, #0xa
	bl _u32_div_f
	mov r2, r1
	mov r0, #0x64
	mul r2, r0
	ldr r0, [sp]
	sub r1, r5, r4
	lsl r1, r1, #0x10
	add r0, r0, r2
	asr r5, r1, #0x10
	strh r5, [r0, #8]
	strh r6, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, r7
	mov r1, #0xa
	bl _u32_div_f
	mov r7, r0
	ldr r0, [sp, #0x1c]
	add r0, r0, #1
	str r0, [sp, #0x1c]
	cmp r0, #2
	blo _0215C3BC
	ldr r0, [sp, #4]
	sub r1, r5, r4
	lsl r1, r1, #0x10
	add r0, #0x64
	asr r5, r1, #0x10
	strh r5, [r0, #8]
	strh r6, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	add r0, sp, #0x20
	ldrh r7, [r0, #2]
	mov r0, #0
	str r0, [sp, #0x10]
_0215C40A:
	mov r0, r7
	mov r1, #0xa
	bl _u32_div_f
	mov r2, r1
	mov r0, #0x64
	mul r2, r0
	ldr r0, [sp]
	sub r1, r5, r4
	lsl r1, r1, #0x10
	add r0, r0, r2
	asr r5, r1, #0x10
	strh r5, [r0, #8]
	strh r6, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, r7
	mov r1, #0xa
	bl _u32_div_f
	mov r7, r0
	ldr r0, [sp, #0x10]
	add r0, r0, #1
	str r0, [sp, #0x10]
	cmp r0, #2
	blo _0215C40A
	sub r0, r5, r4
	lsl r0, r0, #0x10
	asr r5, r0, #0x10
	ldr r0, [sp, #4]
	strh r5, [r0, #8]
	strh r6, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	add r0, sp, #0x20
	ldrh r0, [r0, #4]
	mov r1, #0xa
	bl _u32_div_f
	mov r2, r1
	mov r0, #0x64
	mul r2, r0
	ldr r0, [sp]
	sub r1, r5, r4
	add r0, r0, r2
	strh r1, [r0, #8]
	strh r6, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	add sp, #0x28
	pop {r3, r4, r5, r6, r7, pc}
_0215C470:
	mov r0, #0
	str r0, [sp, #0x14]
	mov r0, r1
	str r0, [sp, #8]
	add r0, #0xc8
	str r0, [sp, #8]
_0215C47C:
	sub r0, r5, r4
	lsl r0, r0, #0x10
	asr r5, r0, #0x10
	ldr r0, [sp, #8]
	strh r5, [r0, #8]
	strh r6, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, [sp, #0x14]
	add r0, r0, #1
	str r0, [sp, #0x14]
	cmp r0, #2
	blo _0215C47C
	ldr r0, [sp, #4]
	sub r1, r5, r4
	lsl r1, r1, #0x10
	add r0, #0x64
	asr r5, r1, #0x10
	strh r5, [r0, #8]
	strh r6, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, #0
	str r0, [sp, #0x18]
	ldr r0, [sp, #4]
	str r0, [sp, #0xc]
	add r0, #0xc8
	str r0, [sp, #0xc]
_0215C4B4:
	sub r0, r5, r4
	lsl r0, r0, #0x10
	asr r5, r0, #0x10
	ldr r0, [sp, #0xc]
	strh r5, [r0, #8]
	strh r6, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, r7
	mov r1, #0xa
	bl _u32_div_f
	mov r7, r0
	ldr r0, [sp, #0x18]
	add r0, r0, #1
	str r0, [sp, #0x18]
	cmp r0, #2
	blo _0215C4B4
	sub r0, r5, r4
	lsl r0, r0, #0x10
	asr r5, r0, #0x10
	ldr r0, [sp, #4]
	strh r5, [r0, #8]
	strh r6, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, [sp, #4]
	sub r1, r5, r4
	add r0, #0xc8
	strh r1, [r0, #8]
	str r0, [sp, #4]
	strh r6, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	add sp, #0x28
	pop {r3, r4, r5, r6, r7, pc}
	thumb_func_end VSStageClear__Func_215C388

	thumb_func_start VSStageClear__HasRunOutOfTime
VSStageClear__HasRunOutOfTime: // 0x0215C4FC
	ldr r1, _0215C50C // =0x00001834
	ldr r0, [r0, r1]
	cmp r0, #0
	bne _0215C508
	mov r0, #1
	bx lr
_0215C508:
	mov r0, #0
	bx lr
	.align 2, 0
_0215C50C: .word 0x00001834
	thumb_func_end VSStageClear__HasRunOutOfTime

	thumb_func_start VSStageClearButtons__Func_215C510
VSStageClearButtons__Func_215C510: // 0x0215C510
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x28
	mov r5, r1
	mov r4, r2
	cmp r0, #5
	bhi _0215C5CA
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215C528: // jump table
	.hword _0215C5CA - _0215C528 - 2 // case 0
	.hword _0215C534 - _0215C528 - 2 // case 1
	.hword _0215C5CA - _0215C528 - 2 // case 2
	.hword _0215C5CA - _0215C528 - 2 // case 3
	.hword _0215C5CA - _0215C528 - 2 // case 4
	.hword _0215C5CA - _0215C528 - 2 // case 5
_0215C534:
	mov r6, #0
	mov r7, #0x1c
_0215C538:
	mov r0, #0x26
	lsl r0, r0, #4
	ldrh r0, [r4, r0]
	mov r1, #0x1f
	mov r3, r0
	and r3, r1
	mov r1, #0x26
	str r3, [sp, #4]
	lsl r1, r1, #4
	ldrh r2, [r4, r1]
	mov r1, #0x3e
	lsl r1, r1, #4
	and r1, r2
	asr r2, r1, #5
	mov r1, #0x26
	str r2, [sp, #8]
	lsl r1, r1, #4
	ldrh r3, [r4, r1]
	mov r1, #0x1f
	lsl r1, r1, #0xa
	and r1, r3
	lsl r3, r0, #0x1b
	lsr r0, r3, #0x18
	asr r3, r0, #4
	lsr r3, r3, #0x1b
	add r3, r0, r3
	asr r0, r3, #5
	str r0, [sp, #0x10]
	lsl r0, r2, #3
	asr r2, r0, #4
	lsr r2, r2, #0x1b
	asr r1, r1, #0xa
	add r2, r0, r2
	str r1, [sp, #0xc]
	asr r0, r2, #5
	lsl r1, r1, #3
	str r0, [sp, #0x14]
	asr r0, r1, #4
	lsr r0, r0, #0x1b
	add r0, r1, r0
	asr r0, r0, #5
	str r0, [sp, #0x18]
	ldrh r0, [r5, #0x10]
	ldrh r1, [r5, #0x12]
	lsl r0, r0, #0xc
	bl _s32_div_f
	mov r3, r0
	ldrsh r0, [r5, r7]
	lsl r3, r3, #0x10
	add r1, sp, #4
	str r0, [sp]
	add r0, sp, #0x1c
	add r2, sp, #0x10
	asr r3, r3, #0x10
	bl Task__Unknown204BE48__LerpVec3
	ldr r1, [sp, #0x24]
	ldr r3, [sp, #0x20]
	lsl r2, r1, #0xa
	ldr r1, [sp, #0x1c]
	lsl r3, r3, #5
	orr r1, r3
	orr r1, r2
	lsl r1, r1, #0x10
	mov r0, r6
	lsr r1, r1, #0x10
	bl NNS_G3dGlbLightColor
	add r6, r6, #1
	add r4, r4, #2
	cmp r6, #4
	blt _0215C538
_0215C5CA:
	add sp, #0x28
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
	thumb_func_end VSStageClearButtons__Func_215C510

	thumb_func_start VSStageClear__SaveResults
VSStageClear__SaveResults: // 0x0215C5D0
	push {r3, r4, r5, r6, r7, lr}
	ldr r7, _0215C650 // =gameState
	mov r4, #0
	ldr r0, [r7, #0x1c]
	mov r6, #1
	cmp r0, #1
	beq _0215C5E8
	cmp r0, #2
	beq _0215C5EC
	cmp r0, #3
	beq _0215C5F0
	b _0215C5F4
_0215C5E8:
	mov r5, r4
	b _0215C5F6
_0215C5EC:
	mov r5, r6
	b _0215C5F6
_0215C5F0:
	mov r5, #2
	b _0215C5F6
_0215C5F4:
	mov r5, #2
_0215C5F6:
	bl MultibootManager__Func_2060CF0
	cmp r0, #0
	beq _0215C608
	cmp r0, #1
	beq _0215C636
	cmp r0, #2
	beq _0215C616
	b _0215C636
_0215C608:
	ldr r0, [r7, #0x20]
	cmp r0, #0
	bne _0215C612
	ldr r4, _0215C654 // =SaveGame__AddWirelessRaceRecord
	b _0215C636
_0215C612:
	ldr r4, _0215C658 // =SaveGame__AddWirelessRingBattleRecord
	b _0215C636
_0215C616:
	ldr r0, [r7, #0x20]
	cmp r0, #0
	bne _0215C620
	ldr r4, _0215C65C // =SaveGame__AddNetworkRaceRecord
	b _0215C622
_0215C620:
	ldr r4, _0215C660 // =SaveGame__AddNetworkRingBattleRecord
_0215C622:
	bl MultibootManager__Func_2060D34
	cmp r0, #0
	beq _0215C636
	bl MultibootManager__Func_2060D9C
	mov r1, r0
	mov r0, r5
	bl SaveGame__UpdateOnlineScore
_0215C636:
	cmp r4, #0
	beq _0215C64C
	mov r0, r5
	blx r4
	mov r0, #0
	bl SaveGame__Func_206047C
	mov r0, #8
	bl TrySaveGameData
	mov r6, r0
_0215C64C:
	mov r0, r6
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215C650: .word gameState
_0215C654: .word SaveGame__AddWirelessRaceRecord
_0215C658: .word SaveGame__AddWirelessRingBattleRecord
_0215C65C: .word SaveGame__AddNetworkRaceRecord
_0215C660: .word SaveGame__AddNetworkRingBattleRecord
	thumb_func_end VSStageClear__SaveResults

	thumb_func_start VSStageClear__IsRace
VSStageClear__IsRace: // 0x0215C664
	ldr r0, _0215C674 // =gameState
	ldr r0, [r0, #0x20]
	cmp r0, #0
	bne _0215C670
	mov r0, #1
	bx lr
_0215C670:
	mov r0, #0
	bx lr
	.align 2, 0
_0215C674: .word gameState
	thumb_func_end VSStageClear__IsRace

	thumb_func_start VSStageClear__Main
VSStageClear__Main: // 0x0215C678
	push {r3, lr}
	bl MultibootManager__Func_2060CC8
	cmp r0, #0xc
	bgt _0215C68A
	bge _0215C6E6
	cmp r0, #0
	beq _0215C6C2
	pop {r3, pc}
_0215C68A:
	cmp r0, #0x14
	bgt _0215C69A
	cmp r0, #0x11
	blt _0215C6F0
	beq _0215C6A0
	cmp r0, #0x14
	beq _0215C6E6
	pop {r3, pc}
_0215C69A:
	cmp r0, #0x18
	beq _0215C6E6
	pop {r3, pc}
_0215C6A0:
	mov r0, #2
	bl RequestSysEventChange
	bl NextSysEvent
	ldr r0, _0215C6F4 // =gameState+0x00000100
	mov r1, #1
	str r1, [r0, #0x64]
	mov r1, #0
	str r1, [r0, #0x60]
	bl MultibootManager__Func_206150C
	bl MultibootManager__Func_2060C9C
	bl DestroyCurrentTask
	pop {r3, pc}
_0215C6C2:
	mov r0, #2
	bl RequestSysEventChange
	bl NextSysEvent
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _0215C6DC
	bl ReleaseStageCommonAssets
	bl ReleaseStageCommonArchives
_0215C6DC:
	bl MultibootManager__Func_2060C9C
	bl DestroyCurrentTask
	pop {r3, pc}
_0215C6E6:
	bl VSStageClear__Func_215AB90
	ldr r0, _0215C6F8 // =VSStageClear__Main_215C6FC
	bl SetCurrentTaskMainEvent
_0215C6F0:
	pop {r3, pc}
	nop
_0215C6F4: .word gameState+0x00000100
_0215C6F8: .word VSStageClear__Main_215C6FC
	thumb_func_end VSStageClear__Main

	thumb_func_start VSStageClear__Main_215C6FC
VSStageClear__Main_215C6FC: // 0x0215C6FC
	push {r3, lr}
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	beq _0215C70A
	cmp r0, #0x18
	b _0215C72E
_0215C70A:
	mov r0, #2
	bl RequestSysEventChange
	bl NextSysEvent
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _0215C724
	bl ReleaseStageCommonAssets
	bl ReleaseStageCommonArchives
_0215C724:
	bl MultibootManager__Func_2060C9C
	bl DestroyCurrentTask
	pop {r3, pc}
_0215C72E:
	bl VSStageClear__SaveResults
	cmp r0, #0
	bne _0215C75A
	mov r0, #3
	bl RequestSysEventChange
	bl NextSysEvent
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _0215C750
	bl ReleaseStageCommonAssets
	bl ReleaseStageCommonArchives
_0215C750:
	bl MultibootManager__Func_2060C9C
	bl DestroyCurrentTask
	pop {r3, pc}
_0215C75A:
	bl MultibootManager__Func_2060CF0
	cmp r0, #0
	beq _0215C76C
	cmp r0, #1
	beq _0215C76C
	cmp r0, #2
	beq _0215C778
	pop {r3, pc}
_0215C76C:
	bl MultibootManager__Func_206193C
	ldr r0, _0215C784 // =VSStageClear__Main_215C7C4
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_0215C778:
	bl MultibootManager__Func_20618A8
	ldr r0, _0215C788 // =VSStageClear__Main_215C78C
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_0215C784: .word VSStageClear__Main_215C7C4
_0215C788: .word VSStageClear__Main_215C78C
	thumb_func_end VSStageClear__Main_215C6FC

	thumb_func_start VSStageClear__Main_215C78C
VSStageClear__Main_215C78C: // 0x0215C78C
	push {r3, lr}
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	beq _0215C7A0
	cmp r0, #0x13
	beq _0215C7BE
	cmp r0, #0x14
	beq _0215C7B4
	pop {r3, pc}
_0215C7A0:
	mov r0, #2
	bl RequestSysEventChange
	bl NextSysEvent
	bl MultibootManager__Func_2060C9C
	bl DestroyCurrentTask
	pop {r3, pc}
_0215C7B4:
	bl MultibootManager__Func_206193C
	ldr r0, _0215C7C0 // =VSStageClear__Main_215C7C4
	bl SetCurrentTaskMainEvent
_0215C7BE:
	pop {r3, pc}
	.align 2, 0
_0215C7C0: .word VSStageClear__Main_215C7C4
	thumb_func_end VSStageClear__Main_215C78C

	thumb_func_start VSStageClear__Main_215C7C4
VSStageClear__Main_215C7C4: // 0x0215C7C4
	push {r3, lr}
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bne _0215C7F2
	mov r0, #2
	bl RequestSysEventChange
	bl NextSysEvent
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _0215C7E8
	bl ReleaseStageCommonAssets
	bl ReleaseStageCommonArchives
_0215C7E8:
	bl MultibootManager__Func_2060C9C
	bl DestroyCurrentTask
	pop {r3, pc}
_0215C7F2:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	beq _0215C80C
	bl GetCurrentTask
	bl VSStageClear__Func_215A9EC
	bl MultibootManager__Func_206193C
	ldr r0, _0215C810 // =VSStageClear__Main_215C814
	bl SetCurrentTaskMainEvent
_0215C80C:
	pop {r3, pc}
	nop
_0215C810: .word VSStageClear__Main_215C814
	thumb_func_end VSStageClear__Main_215C7C4

	thumb_func_start VSStageClear__Main_215C814
VSStageClear__Main_215C814: // 0x0215C814
	push {r3, lr}
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bne _0215C826
	mov r0, #2
	bl VSStageClear__Func_215AB9C
	pop {r3, pc}
_0215C826:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	beq _0215C85A
	ldr r1, _0215C85C // =renderCoreGFXControlA+0x00000040
	mov r0, #0x18
	ldrsh r0, [r1, r0]
	cmp r0, #0
	beq _0215C84C
	bge _0215C83E
	mov r0, #2
	b _0215C840
_0215C83E:
	mov r0, #3
_0215C840:
	lsl r0, r0, #0x10
	mov r1, #1
	lsr r0, r0, #0x10
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
_0215C84C:
	mov r0, #0x2a
	mov r1, #0
	bl PlaySysTrack
	ldr r0, _0215C860 // =VSStageClear__Main_215C864
	bl SetCurrentTaskMainEvent
_0215C85A:
	pop {r3, pc}
	.align 2, 0
_0215C85C: .word renderCoreGFXControlA+0x00000040
_0215C860: .word VSStageClear__Main_215C864
	thumb_func_end VSStageClear__Main_215C814

	thumb_func_start VSStageClear__Main_215C864
VSStageClear__Main_215C864: // 0x0215C864
	push {r4, lr}
	sub sp, #0x10
	ldr r0, _0215C8B8 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bne _0215C882
	mov r0, #2
	bl VSStageClear__Func_215AB9C
	add sp, #0x10
	pop {r4, pc}
_0215C882:
	bl MultibootManager__Func_2061BD4
	mov r4, r0
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	beq _0215C8A2
	mov r0, r4
	add r1, sp, #0
	mov r2, #0x10
	bl MI_CpuCopy8
	add r0, sp, #0
	mov r1, #0x10
	bl MultibootManager__Func_2061A98
_0215C8A2:
	ldrh r1, [r4, #0xe]
	mov r0, #5
	lsl r0, r0, #6
	tst r0, r1
	beq _0215C8B2
	ldr r0, _0215C8BC // =VSStageClear__Main_215C984
	bl SetCurrentTaskMainEvent
_0215C8B2:
	add sp, #0x10
	pop {r4, pc}
	nop
_0215C8B8: .word VSStageClear__Singleton
_0215C8BC: .word VSStageClear__Main_215C984
	thumb_func_end VSStageClear__Main_215C864

	thumb_func_start VSStageClear__Main_215C8C0
VSStageClear__Main_215C8C0: // 0x0215C8C0
	push {r3, lr}
	sub sp, #0x10
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bne _0215C8D6
	mov r0, #2
	bl VSStageClear__Func_215AB9C
	add sp, #0x10
	pop {r3, pc}
_0215C8D6:
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	beq _0215C916
	bl MultibootManager__Func_2061BD4
	add r1, sp, #0
	mov r2, #0x10
	bl MI_CpuCopy8
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	add r1, sp, #0
	beq _0215C8FA
	ldrh r2, [r1, #0xe]
	mov r0, #0x40
	b _0215C900
_0215C8FA:
	ldrh r2, [r1, #0xe]
	mov r0, #1
	lsl r0, r0, #8
_0215C900:
	orr r0, r2
	strh r0, [r1, #0xe]
	add r0, sp, #0
	mov r1, #0x10
	bl MultibootManager__Func_2061A98
	ldr r0, _0215C91C // =VSStageClear__Singleton
	ldr r1, _0215C920 // =VSStageClear__Main_215C984
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
_0215C916:
	add sp, #0x10
	pop {r3, pc}
	nop
_0215C91C: .word VSStageClear__Singleton
_0215C920: .word VSStageClear__Main_215C984
	thumb_func_end VSStageClear__Main_215C8C0

	thumb_func_start VSStageClear__Main_215C924
VSStageClear__Main_215C924: // 0x0215C924
	push {r3, lr}
	sub sp, #0x10
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bne _0215C93A
	mov r0, #2
	bl VSStageClear__Func_215AB9C
	add sp, #0x10
	pop {r3, pc}
_0215C93A:
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	beq _0215C978
	bl MultibootManager__Func_2061BD4
	add r1, sp, #0
	mov r2, #0x10
	bl MI_CpuCopy8
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	add r1, sp, #0
	beq _0215C95E
	ldrh r2, [r1, #0xe]
	mov r0, #0x20
	b _0215C962
_0215C95E:
	ldrh r2, [r1, #0xe]
	mov r0, #0x80
_0215C962:
	orr r0, r2
	strh r0, [r1, #0xe]
	add r0, sp, #0
	mov r1, #0x10
	bl MultibootManager__Func_2061A98
	ldr r0, _0215C97C // =VSStageClear__Singleton
	ldr r1, _0215C980 // =VSStageClear__Main_215C984
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
_0215C978:
	add sp, #0x10
	pop {r3, pc}
	.align 2, 0
_0215C97C: .word VSStageClear__Singleton
_0215C980: .word VSStageClear__Main_215C984
	thumb_func_end VSStageClear__Main_215C924

	thumb_func_start VSStageClear__Main_215C984
VSStageClear__Main_215C984: // 0x0215C984
	push {r4, lr}
	sub sp, #0x10
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bne _0215C99A
	mov r0, #2
	bl VSStageClear__Func_215AB9C
	add sp, #0x10
	pop {r4, pc}
_0215C99A:
	bl MultibootManager__Func_2061BD4
	mov r4, r0
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	beq _0215C9BA
	mov r0, r4
	add r1, sp, #0
	mov r2, #0x10
	bl MI_CpuCopy8
	add r0, sp, #0
	mov r1, #0x10
	bl MultibootManager__Func_2061A98
_0215C9BA:
	ldrh r1, [r4, #0xe]
	mov r0, #5
	lsl r0, r0, #6
	tst r0, r1
	bne _0215C9D0
	mov r0, #0x20
	tst r0, r1
	beq _0215CA02
	mov r0, #0x80
	tst r0, r1
	beq _0215CA02
_0215C9D0:
	ldr r0, _0215CA08 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215CA0C // =0x0000169C
	add r2, r0, r1
	mov r1, #0
	mov r0, #0x66
	mvn r1, r1
	lsl r0, r0, #2
	str r1, [r2, r0]
	bl MultibootManager__Func_2060CF0
	cmp r0, #2
	bne _0215C9F4
	mov r0, #0
	bl MultibootManager__Func_2061888
_0215C9F4:
	bl MultibootManager__Func_206193C
	ldr r0, _0215CA08 // =VSStageClear__Singleton
	ldr r1, _0215CA10 // =VSStageClear__Main_215CA14
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
_0215CA02:
	add sp, #0x10
	pop {r4, pc}
	nop
_0215CA08: .word VSStageClear__Singleton
_0215CA0C: .word 0x0000169C
_0215CA10: .word VSStageClear__Main_215CA14
	thumb_func_end VSStageClear__Main_215C984

	thumb_func_start VSStageClear__Main_215CA14
VSStageClear__Main_215CA14: // 0x0215CA14
	push {r4, r5, r6, lr}
	sub sp, #0x10
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bne _0215CA2A
	mov r0, #2
	bl VSStageClear__Func_215AB9C
	add sp, #0x10
	pop {r4, r5, r6, pc}
_0215CA2A:
	bl MultibootManager__Func_2061BD4
	mov r4, r0
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	beq _0215CA4A
	mov r0, r4
	add r1, sp, #0
	mov r2, #0x10
	bl MI_CpuCopy8
	add r0, sp, #0
	mov r1, #0x10
	bl MultibootManager__Func_2061A98
_0215CA4A:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	beq _0215CAE8
	ldrh r1, [r4, #0xe]
	mov r0, #5
	lsl r0, r0, #6
	tst r0, r1
	beq _0215CAD4
	ldr r5, _0215CAEC // =gameState
	mov r6, #0
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	ldrh r1, [r4, #0xe]
	beq _0215CA7C
	mov r0, #0x40
	mov r2, r1
	tst r2, r0
	bne _0215CA8C
	add r0, #0xc0
	tst r0, r1
	beq _0215CA8C
	mov r6, #1
	b _0215CA8C
_0215CA7C:
	mov r0, #0x40
	mov r2, r1
	tst r2, r0
	beq _0215CA8C
	add r0, #0xc0
	tst r0, r1
	bne _0215CA8C
	mov r6, #1
_0215CA8C:
	cmp r6, #0
	beq _0215CAA0
	mov r0, r5
	add r0, #0xd8
	ldr r1, [r0, #0]
	mov r0, #1
	orr r0, r1
	add r5, #0xd8
	str r0, [r5]
	b _0215CAAE
_0215CAA0:
	mov r0, r5
	add r0, #0xd8
	ldr r1, [r0, #0]
	mov r0, #1
	bic r1, r0
	add r5, #0xd8
	str r1, [r5]
_0215CAAE:
	mov r0, #1
	bl RequestSysEventChange
	bl MultibootManager__Func_2060CF0
	cmp r0, #2
	bne _0215CAC2
	bl MultibootManager__Func_2061824
	b _0215CAC6
_0215CAC2:
	bl MultibootManager__Func_206150C
_0215CAC6:
	ldr r0, _0215CAF0 // =VSStageClear__Singleton
	ldr r1, _0215CAF4 // =VSStageClear__Main_215CAFC
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	add sp, #0x10
	pop {r4, r5, r6, pc}
_0215CAD4:
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	ldr r0, _0215CAF0 // =VSStageClear__Singleton
	ldr r1, _0215CAF8 // =VSStageClear__Main_215CB54
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
_0215CAE8:
	add sp, #0x10
	pop {r4, r5, r6, pc}
	.align 2, 0
_0215CAEC: .word gameState
_0215CAF0: .word VSStageClear__Singleton
_0215CAF4: .word VSStageClear__Main_215CAFC
_0215CAF8: .word VSStageClear__Main_215CB54
	thumb_func_end VSStageClear__Main_215CA14

	thumb_func_start VSStageClear__Main_215CAFC
VSStageClear__Main_215CAFC: // 0x0215CAFC
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	beq _0215CB16
	cmp r0, #0x11
	beq _0215CB1E
	cmp r0, #0x16
	beq _0215CB1E
	pop {r4, pc}
_0215CB16:
	mov r0, #2
	bl VSStageClear__Func_215AB9C
	pop {r4, pc}
_0215CB1E:
	bl MultibootManager__Func_2060C9C
	ldr r1, _0215CB48 // =0x000018C8
	mov r0, #0
	str r0, [r4, r1]
	bl RenderCore_DisableSoftReset
	mov r0, #0
	bl RenderCore_SetNextFoldMode
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	ldr r0, _0215CB4C // =VSStageClear__Singleton
	ldr r1, _0215CB50 // =VSStageClear__Main_215CB54
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_0215CB48: .word 0x000018C8
_0215CB4C: .word VSStageClear__Singleton
_0215CB50: .word VSStageClear__Main_215CB54
	thumb_func_end VSStageClear__Main_215CAFC

	thumb_func_start VSStageClear__Main_215CB54
VSStageClear__Main_215CB54: // 0x0215CB54
	push {r3, lr}
	ldr r0, _0215CB7C // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _0215CB7A
	bl DestroyDrawFadeTask
	ldr r0, _0215CB7C // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl VSStageClear__Func_215AB08
	bl NextSysEvent
	bl DestroyCurrentTask
_0215CB7A:
	pop {r3, pc}
	.align 2, 0
_0215CB7C: .word VSStageClear__Singleton
	thumb_func_end VSStageClear__Main_215CB54

	thumb_func_start VSStageClear__Main_215CB80
VSStageClear__Main_215CB80: // 0x0215CB80
	push {r3, lr}
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	ldr r0, _0215CB98 // =VSStageClear__Singleton
	ldr r1, _0215CB9C // =VSStageClear__Main_215CB54
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r3, pc}
	.align 2, 0
_0215CB98: .word VSStageClear__Singleton
_0215CB9C: .word VSStageClear__Main_215CB54
	thumb_func_end VSStageClear__Main_215CB80

	thumb_func_start VSStageClearModeHeader__Main1
VSStageClearModeHeader__Main1: // 0x0215CBA0
	push {r4, lr}
	ldr r0, _0215CC10 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0x4d
	add r4, #0x64
	lsl r1, r1, #2
	ldr r2, [r4, r1]
	ldr r0, _0215CC14 // =0x00000555
	add r0, r2, r0
	str r0, [r4, r1]
	ldr r0, [r4, r1]
	lsl r0, r0, #4
	lsr r0, r0, #0x10
	beq _0215CBE6
	ldr r2, _0215CC18 // =renderCoreGFXControlA
	ldrh r3, [r2, #8]
	add r3, r3, r0
	strh r3, [r2, #8]
	ldrh r3, [r2, #0xa]
	add r3, r3, r0
	strh r3, [r2, #0xa]
	ldr r2, _0215CC1C // =renderCoreGFXControlB
	ldrh r3, [r2, #4]
	add r3, r3, r0
	strh r3, [r2, #4]
	ldrh r3, [r2, #6]
	add r0, r3, r0
	strh r0, [r2, #6]
	ldr r2, [r4, r1]
	ldr r0, _0215CC20 // =0x00000FFF
	and r0, r2
	str r0, [r4, r1]
_0215CBE6:
	mov r0, r4
	mov r1, #0
	add r0, #8
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	mov r1, #0
	add r0, #0x6c
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r4, #0xd0
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	bl VSState__ProcessAnimations
	pop {r4, pc}
	.align 2, 0
_0215CC10: .word VSStageClear__Singleton
_0215CC14: .word 0x00000555
_0215CC18: .word renderCoreGFXControlA
_0215CC1C: .word renderCoreGFXControlB
_0215CC20: .word 0x00000FFF
	thumb_func_end VSStageClearModeHeader__Main1

	thumb_func_start VSStageClearModeHeader__Main2
VSStageClearModeHeader__Main2: // 0x0215CC24
	push {r4, lr}
	ldr r0, _0215CC50 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	add r4, #0x64
	mov r0, r4
	add r0, #8
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	add r0, #0x6c
	bl AnimatorSprite__DrawFrame
	add r4, #0xd0
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	bl VSState__Draw
	pop {r4, pc}
	.align 2, 0
_0215CC50: .word VSStageClear__Singleton
	thumb_func_end VSStageClearModeHeader__Main2

	thumb_func_start VSStageClearPlayers__Main1
VSStageClearPlayers__Main1: // 0x0215CC54
	push {r4, lr}
	ldr r0, _0215CC90 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x67
	lsl r1, r1, #2
	add r4, r0, r1
	ldr r1, _0215CC94 // =0x0000049C
	ldr r3, [r4, r1]
	add r2, r3, #1
	str r2, [r4, r1]
	cmp r3, #0xa0
	blt _0215CC8E
	ldr r0, [r0, #0x58]
	cmp r0, #1
	bne _0215CC7E
	mov r0, #8
	bl PlaySysSfx
	b _0215CC88
_0215CC7E:
	cmp r0, #0
	bne _0215CC88
	mov r0, #9
	bl PlaySysSfx
_0215CC88:
	ldr r0, _0215CC98 // =VSStageClearPlayers__Main_215CC9C
	bl SetCurrentTaskMainEvent
_0215CC8E:
	pop {r4, pc}
	.align 2, 0
_0215CC90: .word VSStageClear__Singleton
_0215CC94: .word 0x0000049C
_0215CC98: .word VSStageClearPlayers__Main_215CC9C
	thumb_func_end VSStageClearPlayers__Main1

	thumb_func_start VSStageClearPlayers__Main_215CC9C
VSStageClearPlayers__Main_215CC9C: // 0x0215CC9C
	push {r4, lr}
	ldr r0, _0215CCCC // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x67
	lsl r1, r1, #2
	add r4, r0, r1
	mov r0, r4
	add r0, #8
	bl AnimatorMDL__ProcessAnimation
	mov r0, #0x53
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorMDL__ProcessAnimation
	mov r0, #0x29
	lsl r0, r0, #4
	add r0, r4, r0
	bl AnimatorMDL__ProcessAnimation
	pop {r4, pc}
	nop
_0215CCCC: .word VSStageClear__Singleton
	thumb_func_end VSStageClearPlayers__Main_215CC9C

	thumb_func_start VSStageClearPlayers__Main2
VSStageClearPlayers__Main2: // 0x0215CCD0
	push {r4, lr}
	ldr r0, _0215CD10 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x67
	lsl r1, r1, #2
	add r4, r0, r1
	mov r0, r4
	add r0, #8
	bl AnimatorMDL__Draw
	mov r0, #0x53
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorMDL__Draw
	mov r0, #0x29
	lsl r0, r0, #4
	add r0, r4, r0
	bl AnimatorMDL__Draw
	mov r0, #0xf5
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__DrawFrame
	ldr r0, _0215CD14 // =0x00000438
	add r0, r4, r0
	bl AnimatorSprite__DrawFrame
	pop {r4, pc}
	.align 2, 0
_0215CD10: .word VSStageClear__Singleton
_0215CD14: .word 0x00000438
	thumb_func_end VSStageClearPlayers__Main2

	thumb_func_start VSStageClearResults__Main1
VSStageClearResults__Main1: // 0x0215CD18
	push {r4, lr}
	ldr r0, _0215CD5C // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215CD60 // =0x0000063C
	add r4, r0, r1
	mov r0, r4
	mov r1, #0
	add r0, #0xd0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x4d
	lsl r0, r0, #2
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x69
	lsl r0, r0, #2
	ldr r2, [r4, r0]
	add r1, r2, #1
	str r1, [r4, r0]
	cmp r2, #0x78
	blt _0215CD58
	mov r1, #0
	str r1, [r4, r0]
	ldr r0, _0215CD64 // =VSStageClearResults__Main_215CD68
	bl SetCurrentTaskMainEvent
_0215CD58:
	pop {r4, pc}
	nop
_0215CD5C: .word VSStageClear__Singleton
_0215CD60: .word 0x0000063C
_0215CD64: .word VSStageClearResults__Main_215CD68
	thumb_func_end VSStageClearResults__Main1

	thumb_func_start VSStageClearResults__Main_215CD68
VSStageClearResults__Main_215CD68: // 0x0215CD68
	push {r4, lr}
	ldr r0, _0215CDE8 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215CDEC // =0x0000063C
	add r4, r0, r1
	mov r0, r4
	mov r1, #0
	add r0, #0xd0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x4d
	lsl r0, r0, #2
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r2, #0x69
	lsl r2, r2, #2
	ldr r2, [r4, r2]
	mov r0, #2
	lsl r3, r2, #0xc
	asr r2, r3, #3
	lsr r2, r2, #0x1c
	add r2, r3, r2
	lsl r0, r0, #0xc
	lsl r2, r2, #0xc
	ldr r3, _0215CDF0 // =0xFFFFE000
	lsr r1, r0, #1
	asr r2, r2, #0x10
	bl Task__Unknown204BE48__LerpValue
	mov r1, #0x66
	lsl r1, r1, #2
	str r0, [r4, r1]
	mov r0, r1
	add r0, #0xc
	ldr r2, [r4, r0]
	mov r0, r1
	add r0, #0xc
	ldr r0, [r4, r0]
	add r1, #0xc
	add r0, r0, #1
	str r0, [r4, r1]
	cmp r2, #0x10
	blt _0215CDE4
	mov r0, #7
	bl ShakeScreen
	mov r0, #7
	bl PlaySysSfx
	mov r0, #0x69
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r4, r0]
	ldr r0, _0215CDF4 // =VSStageClearResults__Main_215CDF8
	bl SetCurrentTaskMainEvent
_0215CDE4:
	pop {r4, pc}
	nop
_0215CDE8: .word VSStageClear__Singleton
_0215CDEC: .word 0x0000063C
_0215CDF0: .word 0xFFFFE000
_0215CDF4: .word VSStageClearResults__Main_215CDF8
	thumb_func_end VSStageClearResults__Main_215CD68

	thumb_func_start VSStageClearResults__Main_215CDF8
VSStageClearResults__Main_215CDF8: // 0x0215CDF8
	push {r3, r4, r5, lr}
	ldr r0, _0215CE70 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215CE74 // =0x0000063C
	add r4, r0, r1
	mov r0, r4
	mov r1, #0
	add r0, #0xd0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x4d
	lsl r0, r0, #2
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r5, r4
	add r5, #8
	bl GetScreenShakeOffsetX
	asr r0, r0, #0xc
	add r0, #0x44
	strh r0, [r5, #8]
	bl GetScreenShakeOffsetY
	asr r0, r0, #0xc
	add r0, #0x88
	strh r0, [r5, #0xa]
	mov r5, r4
	add r5, #0x6c
	bl GetScreenShakeOffsetY
	asr r0, r0, #0xc
	add r0, #0xbc
	strh r0, [r5, #8]
	bl GetScreenShakeOffsetX
	asr r0, r0, #0xc
	add r0, #0x88
	strh r0, [r5, #0xa]
	mov r0, #0x69
	lsl r0, r0, #2
	ldr r2, [r4, r0]
	add r1, r2, #1
	str r1, [r4, r0]
	cmp r2, #0x64
	blt _0215CE6C
	mov r0, #0
	bl ShakeScreen
	mov r0, #0
	str r0, [r4]
	bl DestroyCurrentTask
_0215CE6C:
	pop {r3, r4, r5, pc}
	nop
_0215CE70: .word VSStageClear__Singleton
_0215CE74: .word 0x0000063C
	thumb_func_end VSStageClearResults__Main_215CDF8

	thumb_func_start VSStageClearResults__Main2
VSStageClearResults__Main2: // 0x0215CE78
	push {r4, lr}
	ldr r0, _0215CEDC // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215CEE0 // =0x0000063C
	add r4, r0, r1
	mov r0, #0x66
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	cmp r1, #0
	ble _0215CEC8
	mov r0, #1
	lsl r0, r0, #0xc
	cmp r1, r0
	bne _0215CEAA
	mov r0, r4
	add r0, #8
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	add r0, #0x6c
	bl AnimatorSprite__DrawFrame
	b _0215CEC8
_0215CEAA:
	mov r0, r4
	add r0, #8
	mov r2, r1
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	mov r0, #0x66
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	mov r0, r4
	add r0, #0x6c
	mov r2, r1
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
_0215CEC8:
	mov r0, r4
	add r0, #0xd0
	bl AnimatorSprite__DrawFrame
	mov r0, #0x4d
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__DrawFrame
	pop {r4, pc}
	.align 2, 0
_0215CEDC: .word VSStageClear__Singleton
_0215CEE0: .word 0x0000063C
	thumb_func_end VSStageClearResults__Main2

	thumb_func_start VSStageClearScoreDisplay__Main1
VSStageClearScoreDisplay__Main1: // 0x0215CEE4
	push {r3, lr}
	ldr r0, _0215CF0C // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215CF10 // =0x000007E4
	add r3, r0, r1
	ldr r0, _0215CF14 // =0x00000B74
	ldr r2, [r3, r0]
	add r1, r2, #1
	str r1, [r3, r0]
	cmp r2, #8
	blt _0215CF08
	mov r1, #0
	str r1, [r3, r0]
	ldr r0, _0215CF18 // =VSStageClearScoreDisplay__Main_215CF1C
	bl SetCurrentTaskMainEvent
_0215CF08:
	pop {r3, pc}
	nop
_0215CF0C: .word VSStageClear__Singleton
_0215CF10: .word 0x000007E4
_0215CF14: .word 0x00000B74
_0215CF18: .word VSStageClearScoreDisplay__Main_215CF1C
	thumb_func_end VSStageClearScoreDisplay__Main1

	thumb_func_start VSStageClearScoreDisplay__Main_215CF1C
VSStageClearScoreDisplay__Main_215CF1C: // 0x0215CF1C
	push {r4, lr}
	ldr r0, _0215CF88 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215CF8C // =0x000007E4
	ldr r2, _0215CF90 // =0x00000B74
	add r4, r0, r1
	ldr r2, [r4, r2]
	mov r0, #0xb7
	lsl r3, r2, #0xc
	asr r2, r3, #4
	lsr r2, r2, #0x1b
	add r2, r3, r2
	lsl r2, r2, #0xb
	ldr r3, _0215CF94 // =0xFFFFF000
	mvn r0, r0
	mov r1, #0x10
	asr r2, r2, #0x10
	bl Task__Unknown204BE48__LerpValue
	strh r0, [r4, #8]
	ldr r2, _0215CF90 // =0x00000B74
	mov r0, #0x6e
	ldr r2, [r4, r2]
	lsl r0, r0, #2
	lsl r3, r2, #0xc
	asr r2, r3, #4
	lsr r2, r2, #0x1b
	add r2, r3, r2
	lsl r2, r2, #0xb
	ldr r3, _0215CF94 // =0xFFFFF000
	mov r1, #0xf0
	asr r2, r2, #0x10
	bl Task__Unknown204BE48__LerpValue
	strh r0, [r4, #0xc]
	ldr r0, _0215CF90 // =0x00000B74
	ldr r2, [r4, r0]
	add r1, r2, #1
	str r1, [r4, r0]
	cmp r2, #0x20
	blt _0215CF84
	mov r0, #4
	bl PlaySysSfx
	ldr r0, _0215CF90 // =0x00000B74
	mov r1, #0
	str r1, [r4, r0]
	ldr r0, _0215CF98 // =VSStageClearScoreDisplay__Main_215CF9C
	bl SetCurrentTaskMainEvent
_0215CF84:
	pop {r4, pc}
	nop
_0215CF88: .word VSStageClear__Singleton
_0215CF8C: .word 0x000007E4
_0215CF90: .word 0x00000B74
_0215CF94: .word 0xFFFFF000
_0215CF98: .word VSStageClearScoreDisplay__Main_215CF9C
	thumb_func_end VSStageClearScoreDisplay__Main_215CF1C

	thumb_func_start VSStageClearScoreDisplay__Main_215CF9C
VSStageClearScoreDisplay__Main_215CF9C: // 0x0215CF9C
	push {r4, lr}
	ldr r0, _0215CFE0 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215CFE4 // =0x000007E4
	ldr r2, _0215CFE8 // =0x00000B74
	add r1, r0, r1
	ldr r4, [r1, r2]
	add r3, r4, #1
	str r3, [r1, r2]
	cmp r4, #0x58
	blt _0215CFDE
	mov r3, #0
	str r3, [r1, r2]
	mov r2, #0x65
	lsl r2, r2, #4
	ldrh r2, [r0, r2]
	cmp r2, #6
	bne _0215CFC6
	mov r3, #1
_0215CFC6:
	ldr r2, _0215CFEC // =0x000006B4
	str r3, [r1, #0x18]
	ldrh r0, [r0, r2]
	cmp r0, #6
	bne _0215CFD4
	mov r0, #1
	b _0215CFD6
_0215CFD4:
	mov r0, #0
_0215CFD6:
	str r0, [r1, #0x1c]
	ldr r0, _0215CFF0 // =VSStageClearScoreDisplay__Main_215CFF4
	bl SetCurrentTaskMainEvent
_0215CFDE:
	pop {r4, pc}
	.align 2, 0
_0215CFE0: .word VSStageClear__Singleton
_0215CFE4: .word 0x000007E4
_0215CFE8: .word 0x00000B74
_0215CFEC: .word 0x000006B4
_0215CFF0: .word VSStageClearScoreDisplay__Main_215CFF4
	thumb_func_end VSStageClearScoreDisplay__Main_215CF9C

	thumb_func_start VSStageClearScoreDisplay__Main_215CFF4
VSStageClearScoreDisplay__Main_215CFF4: // 0x0215CFF4
	push {r3, lr}
	ldr r0, _0215D00C // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215D010 // =0x000012F4
	add r0, r0, r1
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	pop {r3, pc}
	.align 2, 0
_0215D00C: .word VSStageClear__Singleton
_0215D010: .word 0x000012F4
	thumb_func_end VSStageClearScoreDisplay__Main_215CFF4

	thumb_func_start VSStageClearScoreDisplay__Main2
VSStageClearScoreDisplay__Main2: // 0x0215D014
	push {r3, r4, r5, r6, lr}
	sub sp, #0xc
	ldr r0, _0215D188 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215D18C // =0x000007E4
	add r4, r0, r1
	ldrh r0, [r4, #0x2c]
	cmp r0, #0x1b
	bne _0215D02E
	mov r6, #1
	b _0215D030
_0215D02E:
	mov r6, #0
_0215D030:
	mov r0, r4
	add r0, #0x84
	ldr r2, [r0, #0x3c]
	mov r1, #0x80
	bic r2, r1
	str r2, [r0, #0x3c]
	mov r1, #8
	ldrsh r1, [r4, r1]
	mov r5, r4
	add r5, #8
	sub r1, #0x1b
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r5, r1]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r1, #8
	mov r0, r4
	ldrsh r1, [r4, r1]
	add r0, #0x20
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r5, r1]
	sub r1, r1, #4
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	cmp r6, #0
	ldr r0, [r4, #0x18]
	beq _0215D0A2
	cmp r0, #0
	beq _0215D078
	ldr r0, _0215D190 // =0x000005FC
	add r0, r4, r0
	b _0215D07C
_0215D078:
	mov r0, r4
	add r0, #0xe8
_0215D07C:
	mov r1, #3
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	ldr r1, [r4, #0x10]
	mov r3, #8
	str r1, [sp, #8]
	ldrsh r1, [r5, r2]
	mov r2, #2
	ldrsh r2, [r5, r2]
	add r1, #0x40
	lsl r1, r1, #0x10
	sub r2, r2, #1
	lsl r2, r2, #0x10
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	bl VSStageClear__Func_215C31C
	b _0215D0D8
_0215D0A2:
	cmp r0, #0
	beq _0215D0AE
	ldr r0, _0215D190 // =0x000005FC
	ldr r1, _0215D194 // =0x000009E4
	add r0, r4, r0
	b _0215D0B6
_0215D0AE:
	mov r0, r4
	mov r1, #0x4d
	add r0, #0xe8
	lsl r1, r1, #4
_0215D0B6:
	mov r2, #8
	str r2, [sp]
	ldr r2, [r4, #0x10]
	mov r3, #2
	str r2, [sp, #4]
	mov r2, #0
	ldrsh r2, [r5, r2]
	ldrsh r3, [r5, r3]
	add r1, r4, r1
	add r2, #0x30
	sub r3, r3, #1
	lsl r2, r2, #0x10
	lsl r3, r3, #0x10
	asr r2, r2, #0x10
	asr r3, r3, #0x10
	bl VSStageClear__Func_215C388
_0215D0D8:
	mov r0, r4
	add r0, #0x84
	ldr r2, [r0, #0x3c]
	mov r1, #0x80
	orr r1, r2
	str r1, [r0, #0x3c]
	mov r1, #0xc
	ldrsh r1, [r4, r1]
	mov r5, r4
	add r5, #0xc
	add r1, #0x1b
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r5, r1]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r1, #0xc
	ldrsh r1, [r4, r1]
	mov r0, r4
	add r0, #0x20
	sub r1, #0x6c
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r5, r1]
	sub r1, r1, #4
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	cmp r6, #0
	ldr r0, [r4, #0x1c]
	beq _0215D14E
	cmp r0, #0
	beq _0215D122
	ldr r0, _0215D190 // =0x000005FC
	add r0, r4, r0
	b _0215D126
_0215D122:
	mov r0, r4
	add r0, #0xe8
_0215D126:
	mov r1, #3
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	ldr r1, [r4, #0x14]
	mov r3, #8
	str r1, [sp, #8]
	ldrsh r1, [r5, r2]
	mov r2, #2
	ldrsh r2, [r5, r2]
	sub r1, #0x2c
	lsl r1, r1, #0x10
	sub r2, r2, #1
	lsl r2, r2, #0x10
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	bl VSStageClear__Func_215C31C
	add sp, #0xc
	pop {r3, r4, r5, r6, pc}
_0215D14E:
	cmp r0, #0
	beq _0215D15A
	ldr r0, _0215D190 // =0x000005FC
	ldr r1, _0215D194 // =0x000009E4
	add r0, r4, r0
	b _0215D162
_0215D15A:
	mov r0, r4
	mov r1, #0x4d
	add r0, #0xe8
	lsl r1, r1, #4
_0215D162:
	mov r2, #8
	str r2, [sp]
	ldr r2, [r4, #0x14]
	mov r3, #2
	str r2, [sp, #4]
	mov r2, #0
	ldrsh r2, [r5, r2]
	ldrsh r3, [r5, r3]
	add r1, r4, r1
	sub r2, #0x3c
	sub r3, r3, #1
	lsl r2, r2, #0x10
	lsl r3, r3, #0x10
	asr r2, r2, #0x10
	asr r3, r3, #0x10
	bl VSStageClear__Func_215C388
	add sp, #0xc
	pop {r3, r4, r5, r6, pc}
	.align 2, 0
_0215D188: .word VSStageClear__Singleton
_0215D18C: .word 0x000007E4
_0215D190: .word 0x000005FC
_0215D194: .word 0x000009E4
	thumb_func_end VSStageClearScoreDisplay__Main2

	thumb_func_start VSStageClearPlayerNames__Main1
VSStageClearPlayerNames__Main1: // 0x0215D198
	bx lr
	.align 2, 0
	thumb_func_end VSStageClearPlayerNames__Main1

	thumb_func_start VSStageClearPlayerNames__Main2
VSStageClearPlayerNames__Main2: // 0x0215D19C
	push {r4, lr}
	ldr r0, _0215D1DC // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215D1E0 // =0x00001364
	add r4, r0, r1
	mov r0, #0
	strh r0, [r4, #8]
	mov r0, #0x10
	strh r0, [r4, #0xa]
	ldr r1, [r4, #0x3c]
	mov r0, #0x80
	bic r1, r0
	mov r0, r4
	str r1, [r4, #0x3c]
	bl AnimatorSprite__DrawFrame
	mov r0, #1
	lsl r0, r0, #8
	strh r0, [r4, #8]
	mov r0, #0x10
	strh r0, [r4, #0xa]
	ldr r1, [r4, #0x3c]
	mov r0, #0x80
	orr r0, r1
	str r0, [r4, #0x3c]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	pop {r4, pc}
	nop
_0215D1DC: .word VSStageClear__Singleton
_0215D1E0: .word 0x00001364
	thumb_func_end VSStageClearPlayerNames__Main2

	thumb_func_start VSStageClearButtons__Main1
VSStageClearButtons__Main1: // 0x0215D1E4
	push {r3, r4, lr}
	sub sp, #0x24
	ldr r0, _0215D2C8 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215D2CC // =0x00001428
	add r4, r0, r1
	mov r0, #0x27
	lsl r0, r0, #4
	ldr r2, [r4, r0]
	add r1, r2, #1
	str r1, [r4, r0]
	cmp r2, #0xfa
	blt _0215D2C4
	mov r1, #0
	str r1, [sp]
	mov r2, #0x10
	ldr r0, _0215D2D0 // =Task__Unknown204BE48__LerpValue
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	ldr r0, _0215D2D4 // =0x00002050
	str r1, [sp, #0x18]
	str r0, [sp, #0x1c]
	str r1, [sp, #0x20]
	ldr r0, _0215D2D8 // =renderCoreGFXControlA+0x00000022
	mov r1, #2
	mov r3, #0xc
	bl Task__Unknown204BE48__Create
	mov r0, #0
	str r0, [sp]
	mov r1, #0x10
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r1, _0215D2DC // =VSStageClearButtons__Func_215C510
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r4, [sp, #0x14]
	ldr r1, _0215D2D4 // =0x00002050
	str r0, [sp, #0x18]
	str r1, [sp, #0x1c]
	mov r1, r0
	mov r2, r0
	mov r3, r0
	str r0, [sp, #0x20]
	bl Task__Unknown204BE48__Create
	mov r2, #0
	str r2, [sp]
	mov r1, #0x10
	ldr r0, _0215D2D0 // =Task__Unknown204BE48__LerpValue
	str r1, [sp, #4]
	str r0, [sp, #8]
	lsl r0, r1, #9
	str r0, [sp, #0xc]
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	ldr r0, _0215D2D4 // =0x00002050
	str r2, [sp, #0x18]
	str r0, [sp, #0x1c]
	mov r0, r4
	str r2, [sp, #0x20]
	add r0, #0x12
	mov r1, #2
	mov r2, #0xc0
	mov r3, #0x40
	bl Task__Unknown204BE48__Create
	mov r0, #8
	str r0, [sp]
	mov r1, #0x10
	ldr r0, _0215D2D0 // =Task__Unknown204BE48__LerpValue
	str r1, [sp, #4]
	str r0, [sp, #8]
	lsl r0, r1, #9
	str r0, [sp, #0xc]
	mov r1, #0
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	ldr r0, _0215D2D4 // =0x00002050
	str r1, [sp, #0x18]
	str r0, [sp, #0x1c]
	mov r0, r4
	str r1, [sp, #0x20]
	add r0, #0x76
	mov r1, #2
	mov r2, #0xe2
	mov r3, #0x62
	bl Task__Unknown204BE48__Create
	ldr r0, [r4, #0x44]
	mov r1, #1
	bic r0, r1
	str r0, [r4, #0x44]
	mov r0, r4
	add r0, #0xa8
	ldr r2, [r0, #0]
	mov r0, r4
	bic r2, r1
	add r0, #0xa8
	str r2, [r0]
	mov r0, #0x27
	mov r1, #0
	lsl r0, r0, #4
	str r1, [r4, r0]
	ldr r0, _0215D2E0 // =VSStageClearButtons__Main_215D2E4
	bl SetCurrentTaskMainEvent
_0215D2C4:
	add sp, #0x24
	pop {r3, r4, pc}
	.align 2, 0
_0215D2C8: .word VSStageClear__Singleton
_0215D2CC: .word 0x00001428
_0215D2D0: .word Task__Unknown204BE48__LerpValue
_0215D2D4: .word 0x00002050
_0215D2D8: .word renderCoreGFXControlA+0x00000022
_0215D2DC: .word VSStageClearButtons__Func_215C510
_0215D2E0: .word VSStageClearButtons__Main_215D2E4
	thumb_func_end VSStageClearButtons__Main1

	thumb_func_start VSStageClearButtons__Main_215D2E4
VSStageClearButtons__Main_215D2E4: // 0x0215D2E4
	push {r3, r4, r5, lr}
	ldr r0, _0215D32C // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215D330 // =0x00001428
	mov r5, #0x27
	add r1, r0, r1
	lsl r5, r5, #4
	ldr r2, [r1, r5]
	add r0, r2, #1
	str r0, [r1, r5]
	cmp r2, #0x18
	blt _0215D328
	mov r2, r5
	mov r4, #0x43
	mov r0, #0
	sub r2, #8
	lsl r4, r4, #2
	str r0, [r1, r2]
	ldr r2, [r1, r4]
	mov r3, #1
	bic r2, r3
	str r2, [r1, r4]
	mov r2, r4
	add r2, #0x64
	ldr r2, [r1, r2]
	add r4, #0x64
	bic r2, r3
	str r2, [r1, r4]
	str r0, [r1, r5]
	ldr r0, _0215D334 // =VSStageClearButtons__Main_215D338
	bl SetCurrentTaskMainEvent
_0215D328:
	pop {r3, r4, r5, pc}
	nop
_0215D32C: .word VSStageClear__Singleton
_0215D330: .word 0x00001428
_0215D334: .word VSStageClearButtons__Main_215D338
	thumb_func_end VSStageClearButtons__Main_215D2E4

	thumb_func_start VSStageClearButtons__Main_215D338
VSStageClearButtons__Main_215D338: // 0x0215D338
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _0215D578 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r7, r0
	ldr r0, _0215D57C // =0x00001428
	add r4, r7, r0
	bl MultibootManager__Func_2061BD4
	ldrh r1, [r0, #0xe]
	mov r0, #5
	mov r6, #0
	lsl r0, r0, #6
	mov r5, r6
	tst r0, r1
	beq _0215D38A
	mov r2, r4
	add r2, #0xd0
	ldr r1, [r2, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r2, #0x3c]
	mov r0, r4
	add r0, #8
	mov r1, r6
	bl AnimatorSprite__SetAnimation
	mov r0, r4
	add r0, #0x6c
	mov r1, #3
	bl AnimatorSprite__SetAnimation
	mov r0, #0x27
	mov r1, r6
	lsl r0, r0, #4
	str r1, [r4, r0]
	ldr r0, _0215D580 // =VSStageClearButtons__Main_215D594
	bl SetCurrentTaskMainEvent
	pop {r3, r4, r5, r6, r7, pc}
_0215D38A:
	mov r1, #0x9b
	lsl r1, r1, #2
	mov r2, #3
	ldr r3, [r4, r1]
	lsl r2, r2, #0xc
	cmp r3, r2
	bge _0215D3A6
	ldr r0, _0215D584 // =0x00000555
	add r0, r3, r0
	str r0, [r4, r1]
	ldr r0, [r4, r1]
	cmp r0, r2
	ble _0215D3A6
	str r2, [r4, r1]
_0215D3A6:
	ldr r0, _0215D588 // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #1
	tst r0, r1
	bne _0215D3DC
	ldr r0, _0215D58C // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x40
	tst r0, r1
	bne _0215D3C0
	mov r0, #0x80
	tst r0, r1
	beq _0215D3DC
_0215D3C0:
	mov r0, #0x9a
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	cmp r1, #0
	beq _0215D3D0
	cmp r1, #1
	beq _0215D3D6
	b _0215D3DA
_0215D3D0:
	mov r1, #1
	str r1, [r4, r0]
	b _0215D3DA
_0215D3D6:
	mov r1, #0
	str r1, [r4, r0]
_0215D3DA:
	mov r6, #1
_0215D3DC:
	ldr r0, _0215D58C // =padInput
	ldrh r1, [r0, #4]
	ldr r0, _0215D590 // =0x00000C01
	tst r0, r1
	beq _0215D3F4
	mov r0, #0x9a
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	bl VSStageClear__Func_215AB9C
	mov r5, #1
	b _0215D4BE
_0215D3F4:
	ldr r0, _0215D588 // =touchInput
	mov r2, #4
	ldrh r1, [r0, #0x12]
	tst r2, r1
	beq _0215D44A
	ldrh r1, [r0, #0x14]
	cmp r1, #0x30
	blo _0215D424
	cmp r1, #0xd0
	bhi _0215D424
	ldrh r0, [r0, #0x16]
	cmp r0, #0x40
	blo _0215D424
	cmp r0, #0x58
	bhi _0215D424
	mov r0, #0x9a
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	cmp r1, #0
	beq _0215D4BE
	mov r1, #0
	str r1, [r4, r0]
	mov r6, #1
	b _0215D4BE
_0215D424:
	ldr r0, _0215D588 // =touchInput
	ldrh r1, [r0, #0x14]
	cmp r1, #0x30
	blo _0215D4BE
	cmp r1, #0xd0
	bhi _0215D4BE
	ldrh r0, [r0, #0x16]
	cmp r0, #0x62
	blo _0215D4BE
	cmp r0, #0x7a
	bhi _0215D4BE
	mov r0, #0x9a
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	cmp r1, #1
	beq _0215D4BE
	mov r6, #1
	str r6, [r4, r0]
	b _0215D4BE
_0215D44A:
	mov r2, #8
	tst r1, r2
	beq _0215D49E
	ldrh r1, [r0, #0x20]
	cmp r1, #0x30
	blo _0215D476
	cmp r1, #0xd0
	bhi _0215D476
	ldrh r0, [r0, #0x16]
	cmp r0, #0x40
	blo _0215D476
	cmp r0, #0x58
	bhi _0215D476
	mov r0, #0x9a
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	cmp r0, #0
	bne _0215D4BE
	bl VSStageClear__Func_215AB9C
	mov r5, #1
	b _0215D4BE
_0215D476:
	ldr r0, _0215D588 // =touchInput
	ldrh r1, [r0, #0x20]
	cmp r1, #0x30
	blo _0215D4BE
	cmp r1, #0xd0
	bhi _0215D4BE
	ldrh r0, [r0, #0x16]
	cmp r0, #0x62
	blo _0215D4BE
	cmp r0, #0x7a
	bhi _0215D4BE
	mov r0, #0x9a
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	cmp r0, #1
	bne _0215D4BE
	bl VSStageClear__Func_215AB9C
	mov r5, #1
	b _0215D4BE
_0215D49E:
	mov r0, r7
	bl VSStageClear__HasRunOutOfTime
	cmp r0, #0
	beq _0215D4BE
	mov r0, #1
	bl VSStageClear__Func_215AB9C
	mov r0, #0x9a
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	mov r5, #1
	cmp r1, #1
	beq _0215D4BE
	str r5, [r4, r0]
	mov r6, r5
_0215D4BE:
	cmp r6, #0
	beq _0215D506
	mov r0, #0x9b
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r4, r0]
	sub r0, r0, #4
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0215D4D8
	cmp r0, #1
	beq _0215D4EE
	b _0215D500
_0215D4D8:
	mov r0, r4
	add r0, #8
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	mov r0, r4
	add r0, #0x6c
	mov r1, #3
	bl AnimatorSprite__SetAnimation
	b _0215D500
_0215D4EE:
	mov r0, r4
	add r0, #8
	bl AnimatorSprite__SetAnimation
	mov r0, r4
	add r0, #0x6c
	mov r1, #4
	bl AnimatorSprite__SetAnimation
_0215D500:
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215D506:
	cmp r5, #0
	beq _0215D550
	mov r0, #0x9a
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0215D51A
	cmp r0, #1
	beq _0215D526
	b _0215D530
_0215D51A:
	mov r0, r4
	add r0, #8
	mov r1, #2
	bl AnimatorSprite__SetAnimation
	b _0215D530
_0215D526:
	mov r0, r4
	add r0, #0x6c
	mov r1, #5
	bl AnimatorSprite__SetAnimation
_0215D530:
	mov r0, #0x27
	mov r1, #0
	lsl r0, r0, #4
	str r1, [r4, r0]
	ldr r0, _0215D580 // =VSStageClearButtons__Main_215D594
	bl SetCurrentTaskMainEvent
	mov r2, r4
	add r2, #0xd0
	ldr r1, [r2, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r2, #0x3c]
	mov r0, #0
	bl PlaySysMenuNavSfx
_0215D550:
	mov r0, r4
	mov r1, #0
	add r0, #8
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	mov r1, #0
	add r0, #0x6c
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r4, #0xd0
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215D578: .word VSStageClear__Singleton
_0215D57C: .word 0x00001428
_0215D580: .word VSStageClearButtons__Main_215D594
_0215D584: .word 0x00000555
_0215D588: .word touchInput
_0215D58C: .word padInput
_0215D590: .word 0x00000C01
	thumb_func_end VSStageClearButtons__Main_215D338

	thumb_func_start VSStageClearButtons__Main_215D594
VSStageClearButtons__Main_215D594: // 0x0215D594
	push {r4, lr}
	ldr r0, _0215D64C // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215D650 // =0x00001428
	add r4, r0, r1
	mov r1, #0x9a
	lsl r1, r1, #2
	ldr r0, [r4, r1]
	cmp r0, #0
	bne _0215D626
	mov r0, r1
	add r0, #8
	ldr r3, [r4, r0]
	mov r0, r1
	add r0, #8
	ldr r0, [r4, r0]
	add r2, r0, #1
	mov r0, r1
	add r0, #8
	str r2, [r4, r0]
	cmp r3, #0x3c
	ble _0215D626
	mov r3, r4
	add r3, #8
	ldr r2, [r3, #0x3c]
	mov r0, #3
	orr r2, r0
	str r2, [r3, #0x3c]
	mov r3, r4
	add r3, #0x6c
	ldr r2, [r3, #0x3c]
	sub r1, #0xd0
	orr r2, r0
	str r2, [r3, #0x3c]
	mov r3, r4
	add r3, #0xd0
	ldr r2, [r3, #0x3c]
	orr r0, r2
	str r0, [r3, #0x3c]
	add r0, r4, r1
	ldr r2, [r0, #0x3c]
	mov r1, #3
	bic r2, r1
	mov r1, #0
	str r2, [r0, #0x3c]
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x7f
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r2, [r0, #0x3c]
	mov r1, #3
	bic r2, r1
	mov r1, #0
	str r2, [r0, #0x3c]
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x27
	mov r1, #0
	lsl r0, r0, #4
	str r1, [r4, r0]
	ldr r0, [r4, #4]
	ldr r1, _0215D654 // =VSStageClearButtons__Main_Draw_215D77C
	bl SetTaskMainEvent
	ldr r0, _0215D658 // =VSStageClearButtons__Main_215D65C
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_0215D626:
	mov r0, r4
	mov r1, #0
	add r0, #8
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	mov r1, #0
	add r0, #0x6c
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r4, #0xd0
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	pop {r4, pc}
	.align 2, 0
_0215D64C: .word VSStageClear__Singleton
_0215D650: .word 0x00001428
_0215D654: .word VSStageClearButtons__Main_Draw_215D77C
_0215D658: .word VSStageClearButtons__Main_215D65C
	thumb_func_end VSStageClearButtons__Main_215D594

	thumb_func_start VSStageClearButtons__Main_215D65C
VSStageClearButtons__Main_215D65C: // 0x0215D65C
	push {r4, lr}
	ldr r0, _0215D688 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215D68C // =0x00001428
	add r4, r0, r1
	mov r0, #0x66
	lsl r0, r0, #2
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x7f
	lsl r0, r0, #2
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	pop {r4, pc}
	.align 2, 0
_0215D688: .word VSStageClear__Singleton
_0215D68C: .word 0x00001428
	thumb_func_end VSStageClearButtons__Main_215D65C

	thumb_func_start VSStageClearButtons__Main2
VSStageClearButtons__Main2: // 0x0215D690
	push {r4, lr}
	ldr r0, _0215D774 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215D778 // =0x00001428
	mov r2, #0x9a
	add r4, r0, r1
	lsl r2, r2, #2
	ldr r0, [r4, r2]
	cmp r0, #0
	beq _0215D6B2
	cmp r0, #1
	beq _0215D706
	cmp r0, #5
	beq _0215D75A
	pop {r4, pc}
_0215D6B2:
	add r1, r2, #4
	ldr r1, [r4, r1]
	mov r0, r4
	asr r3, r1, #0xc
	mov r1, #0x30
	add r0, #8
	sub r1, r1, r3
	strh r1, [r0, #8]
	add r1, r2, #4
	ldr r1, [r4, r1]
	asr r2, r1, #0xc
	mov r1, #0x40
	sub r1, r1, r2
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	add r0, #0x6c
	mov r1, #0x30
	strh r1, [r0, #8]
	mov r1, #0x62
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	add r0, #0xd0
	mov r1, #0x38
	strh r1, [r0, #8]
	mov r1, #0x48
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, #0x4d
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0x30
	strh r1, [r0, #8]
	mov r1, #0x40
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	pop {r4, pc}
_0215D706:
	mov r0, r4
	add r0, #8
	mov r1, #0x30
	strh r1, [r0, #8]
	mov r1, #0x40
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r2, #0x9b
	lsl r2, r2, #2
	ldr r1, [r4, r2]
	mov r0, r4
	asr r3, r1, #0xc
	mov r1, #0x30
	add r0, #0x6c
	sub r1, r1, r3
	strh r1, [r0, #8]
	ldr r1, [r4, r2]
	asr r2, r1, #0xc
	mov r1, #0x62
	sub r1, r1, r2
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	add r0, #0xd0
	mov r1, #0x38
	strh r1, [r0, #8]
	mov r1, #0x6a
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, #0x4d
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0x30
	strh r1, [r0, #8]
	mov r1, #0x62
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	pop {r4, pc}
_0215D75A:
	mov r0, r4
	add r0, #8
	mov r1, #0x30
	strh r1, [r0, #8]
	bl AnimatorSprite__DrawFrame
	add r4, #0x6c
	mov r0, #0x30
	strh r0, [r4, #8]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	pop {r4, pc}
	.align 2, 0
_0215D774: .word VSStageClear__Singleton
_0215D778: .word 0x00001428
	thumb_func_end VSStageClearButtons__Main2

	thumb_func_start VSStageClearButtons__Main_Draw_215D77C
VSStageClearButtons__Main_Draw_215D77C: // 0x0215D77C
	push {r4, lr}
	ldr r0, _0215D7B8 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215D7BC // =0x00001428
	add r4, r0, r1
	mov r0, #0x66
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__DrawFrame
	mov r0, #0x7f
	lsl r0, r0, #2
	add r4, r4, r0
	mov r0, #0xd4
	strh r0, [r4, #8]
	mov r0, #0x5f
	strh r0, [r4, #0xa]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r0, #0x2c
	strh r0, [r4, #8]
	mov r0, #0x5f
	strh r0, [r4, #0xa]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	pop {r4, pc}
	.align 2, 0
_0215D7B8: .word VSStageClear__Singleton
_0215D7BC: .word 0x00001428
	thumb_func_end VSStageClearButtons__Main_Draw_215D77C

	thumb_func_start VSStageClearTimer__Main1
VSStageClearTimer__Main1: // 0x0215D7C0
	push {r4, r5, r6, lr}
	ldr r0, _0215D85C // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215D860 // =0x0000169C
	add r4, r0, r1
	mov r0, #0x67
	lsl r0, r0, #2
	ldr r2, [r4, r0]
	add r1, r2, #1
	str r1, [r4, r0]
	cmp r2, #0
	blt _0215D85A
	mov r1, #0
	str r1, [r4, r0]
	mov r1, #0x4b
	lsl r1, r1, #4
	sub r0, r0, #4
	str r1, [r4, r0]
	ldr r0, _0215D864 // =VSStageClearTimer__Main_215D868
	bl SetCurrentTaskMainEvent
	mov r0, #0x66
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	mov r1, #0x3c
	bl _s32_div_f
	mov r6, r0
	mov r0, r4
	mov r1, #0
	add r0, #0x6c
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	mov r1, #0
	add r0, #8
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r5, r4
	mov r0, r6
	mov r1, #0xa
	add r5, #0xd0
	bl _u32_div_f
	lsl r1, r1, #0x10
	mov r0, r5
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r5, #0x4d
	mov r0, r6
	mov r1, #0xa
	lsl r5, r5, #2
	bl _u32_div_f
	mov r1, #0xa
	bl _u32_div_f
	lsl r1, r1, #0x10
	add r0, r4, r5
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
_0215D85A:
	pop {r4, r5, r6, pc}
	.align 2, 0
_0215D85C: .word VSStageClear__Singleton
_0215D860: .word 0x0000169C
_0215D864: .word VSStageClearTimer__Main_215D868
	thumb_func_end VSStageClearTimer__Main1

	thumb_func_start VSStageClearTimer__Main_215D868
VSStageClearTimer__Main_215D868: // 0x0215D868
	push {r4, r5, r6, lr}
	ldr r0, _0215D8F8 // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215D8FC // =0x0000169C
	add r4, r0, r1
	mov r0, #0x66
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	cmp r1, #0
	ble _0215D884
	sub r1, r1, #1
	str r1, [r4, r0]
_0215D884:
	mov r0, #0x66
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	cmp r0, #0
	blt _0215D8F4
	mov r1, #0x3c
	bl _s32_div_f
	mov r6, r0
	mov r0, r4
	mov r1, #0
	add r0, #0x6c
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	mov r1, #0
	add r0, #8
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r5, r4
	mov r0, r6
	mov r1, #0xa
	add r5, #0xd0
	bl _u32_div_f
	lsl r1, r1, #0x10
	mov r0, r5
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r5, #0x4d
	mov r0, r6
	mov r1, #0xa
	lsl r5, r5, #2
	bl _u32_div_f
	mov r1, #0xa
	bl _u32_div_f
	lsl r1, r1, #0x10
	add r0, r4, r5
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
_0215D8F4:
	pop {r4, r5, r6, pc}
	nop
_0215D8F8: .word VSStageClear__Singleton
_0215D8FC: .word 0x0000169C
	thumb_func_end VSStageClearTimer__Main_215D868

	thumb_func_start VSStageClearTimer__Main2
VSStageClearTimer__Main2: // 0x0215D900
	push {r4, lr}
	ldr r0, _0215D93C // =VSStageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215D940 // =0x0000169C
	add r4, r0, r1
	mov r0, #0x66
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	cmp r0, #0
	blt _0215D93A
	mov r0, r4
	add r0, #0x6c
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	add r0, #8
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	add r0, #0xd0
	bl AnimatorSprite__DrawFrame
	mov r0, #0x4d
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__DrawFrame
_0215D93A:
	pop {r4, pc}
	.align 2, 0
_0215D93C: .word VSStageClear__Singleton
_0215D940: .word 0x0000169C
	thumb_func_end VSStageClearTimer__Main2

	.data
	
aDmasVsJpnBac: // 0x0217E6E4
	.asciz "/dmas_vs_jpn.bac"
	.align 4
	
aCldmVsSpaBac: // 0x0217E6F8
	.asciz "/cldm_vs_spa.bac"
	.align 4
	
aCldmVsFraBac: // 0x0217E70C
	.asciz "/cldm_vs_fra.bac"
	.align 4
	
aCldmVsItaBac: // 0x0217E720
	.asciz "/cldm_vs_ita.bac"
	.align 4
	
aDmasVsItaBac: // 0x0217E734
	.asciz "/dmas_vs_ita.bac"
	.align 4
	
aDmasVsDeuBac: // 0x0217E748
	.asciz "/dmas_vs_deu.bac"
	.align 4
	
aDmasVsSpaBac: // 0x0217E75C
	.asciz "/dmas_vs_spa.bac"
	.align 4
	
aDmasVsFraBac: // 0x0217E770
	.asciz "/dmas_vs_fra.bac"
	.align 4
	
aCldmVsEngBac: // 0x0217E784
	.asciz "/cldm_vs_eng.bac"
	.align 4
	
aDmasVsEngBac: // 0x0217E798
	.asciz "/dmas_vs_eng.bac"
	.align 4
	
aCldmVsJpnBac: // 0x0217E7AC
	.asciz "/cldm_vs_jpn.bac"
	.align 4
	
aCldmVsDeuBac: // 0x0217E7C0
	.asciz "/cldm_vs_deu.bac"
	.align 4
	
aDmvsTitleJpnBa: // 0x0217E7D4
	.asciz "/dmvs_title_jpn.bac"
	.align 4
	
aDmvsTitleEngBa: // 0x0217E7E8
	.asciz "/dmvs_title_eng.bac"
	.align 4
	
aDmvsTitleFraBa: // 0x0217E7FC
	.asciz "/dmvs_title_fra.bac"
	.align 4
	
aDmvsTitleDeuBa: // 0x0217E810
	.asciz "/dmvs_title_deu.bac"
	.align 4
	
aDmvsTitleItaBa: // 0x0217E824
	.asciz "/dmvs_title_ita.bac"
	.align 4
	
aDmvsTitleSpaBa: // 0x0217E838
	.asciz "/dmvs_title_spa.bac"
	.align 4
	
_0217E84C: // 0x0217E84C
	.word aCldmVsJpnBac 	// "/cldm_vs_jpn.bac"
	.word aCldmVsEngBac 	// "/cldm_vs_eng.bac"
	.word aCldmVsFraBac 	// "/cldm_vs_fra.bac"
	.word aCldmVsDeuBac 	// "/cldm_vs_deu.bac"
	.word aCldmVsItaBac 	// "/cldm_vs_ita.bac"
	.word aCldmVsSpaBac 	// "/cldm_vs_spa.bac"

_0217E864: // 0x0217E864
	.word aDmvsTitleJpnBa	// "/dmvs_title_jpn.bac"
	.word aDmvsTitleEngBa	// "/dmvs_title_eng.bac"
	.word aDmvsTitleFraBa	// "/dmvs_title_fra.bac"
	.word aDmvsTitleDeuBa	// "/dmvs_title_deu.bac"
	.word aDmvsTitleItaBa	// "/dmvs_title_ita.bac"
	.word aDmvsTitleSpaBa	// "/dmvs_title_spa.bac"

_0217E87C: // 0x0217E87C
	.word aDmasVsJpnBac		// "/dmas_vs_jpn.bac"
	.word aDmasVsEngBac		// "/dmas_vs_eng.bac"
	.word aDmasVsFraBac		// "/dmas_vs_fra.bac"
	.word aDmasVsDeuBac		// "/dmas_vs_deu.bac"
	.word aDmasVsItaBac		// "/dmas_vs_ita.bac"
	.word aDmasVsSpaBac		// "/dmas_vs_spa.bac"

aFntFontIplFnt_1: // 0x0217E894
	.asciz "/fnt/font_ipl.fnt"
	.align 4
	
aNarcCldmVsNarc: // 0x0217E8A8
	.asciz "/narc/cldm_vs.narc"
	.align 4
	
aCldmVsNsbca: // 0x0217E8BC
	.asciz "/cldm_vs.nsbca"
	.align 4
	
aCldmVsBac: // 0x0217E8CC
	.asciz "/cldm_vs.bac"
	.align 4
	
aCldmVsCmnBac: // 0x0217E8DC
	.asciz "/cldm_vs_cmn.bac"
	.align 4
	
aCldmVsBsd: // 0x0217E8F0
	.asciz "/cldm_vs.bsd"
	.align 4
	
aNarcDmvsCmnNar: // 0x0217E900
	.asciz "/narc/dmvs_cmn.narc"
	.align 4
	
aDmvsTitleBac: // 0x0217E914
	.asciz "/dmvs_title.bac"
	.align 4
	
aDmvsCursorBac: // 0x0217E924
	.asciz "dmvs_cursor.bac"
	.align 4
	
aDmvsTimeBac: // 0x0217E934
	.asciz "dmvs_time.bac"
	.align 4
	
aNarcDmasVsNarc: // 0x0217E944
	.asciz "/narc/dmas_vs.narc"
	.align 4
	
aDmasVsBac: // 0x0217E958
	.asciz "/dmas_vs.bac"
	.align 4
	
_0217E968:
	.byte 0x25, 0x00, 0x73, 0x00, 0x00, 0x00, 0x00, 0x00
	.align 4
