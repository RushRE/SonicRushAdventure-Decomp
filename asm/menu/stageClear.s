	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public StageClear__Singleton
StageClear__Singleton: // 0x0217EFC4
	.space 0x04 // Task*

	.text

	thumb_func_start StageClear__Create
StageClear__Create: // 0x02156B8C
	push {lr}
	sub sp, #0xc
	mov r0, #0
	bl RenderCore_StopDMA
	mov r0, #1
	bl RenderCore_StopDMA
	bl StageClear__Func_2156E34
	mov r0, #1
	str r0, [sp]
	mov r2, #0
	mov r0, #0xb3
	str r2, [sp, #4]
	lsl r0, r0, #6
	str r0, [sp, #8]
	ldr r0, _02156BC4 // =StageClear__Main
	ldr r1, _02156BC8 // =StageClear__Destructor
	mov r3, r2
	bl TaskCreate_
	ldr r1, _02156BCC // =StageClear__Singleton
	str r0, [r1]
	bl StageClear__InitComponents
	add sp, #0xc
	pop {pc}
	.align 2, 0
_02156BC4: .word StageClear__Main
_02156BC8: .word StageClear__Destructor
_02156BCC: .word StageClear__Singleton
	thumb_func_end StageClear__Create

	thumb_func_start StageClear__Destructor
StageClear__Destructor: // 0x02156BD0
	ldr r0, _02156BD8 // =StageClear__Singleton
	mov r1, #0
	str r1, [r0]
	bx lr
	.align 2, 0
_02156BD8: .word StageClear__Singleton
	thumb_func_end StageClear__Destructor

	thumb_func_start StageClear__InitComponents
StageClear__InitComponents: // 0x02156BDC
	push {r3, r4, r5, lr}
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0xb3
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #6
	ldr r5, _02156DA0 // =gameState
	bl MIi_CpuClear16
	ldr r1, _02156DA4 // =renderCoreGFXControlA+0x00000040
	mov r0, #0x18
	ldrsh r0, [r1, r0]
	cmp r0, #0
	beq _02156C12
	bge _02156C02
	mov r0, #2
	b _02156C04
_02156C02:
	mov r0, #3
_02156C04:
	lsl r0, r0, #0x10
	mov r1, #1
	lsr r0, r0, #0x10
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	b _02156C1A
_02156C12:
	mov r0, #2
	lsl r1, r0, #0xb
	bl CreateDrawFadeTask
_02156C1A:
	ldrh r1, [r5, #0x28]
	ldr r0, _02156DA8 // =0x0217DB58
	ldrb r0, [r0, r1]
	cmp r0, #5
	bhi _02156D0E
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02156C30: // jump table
	.hword _02156C3C - _02156C30 - 2 // case 0
	.hword _02156C3C - _02156C30 - 2 // case 1
	.hword _02156C7A - _02156C30 - 2 // case 2
	.hword _02156CB8 - _02156C30 - 2 // case 3
	.hword _02156CF6 - _02156C30 - 2 // case 4
	.hword _02156C3C - _02156C30 - 2 // case 5
_02156C3C:
	ldr r0, [r4, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _02156C60
	mov r0, #3
	str r0, [r4]
	ldr r0, _02156DAC // =0x00002CBC
	mov r1, #7
	str r1, [r4, r0]
	mov r0, #0x10
	bl LoadSysSound
	mov r0, #9
	mov r1, #1
	bl PlaySysTrack
	b _02156D0E
_02156C60:
	mov r0, #0
	str r0, [r4]
	ldr r0, _02156DAC // =0x00002CBC
	mov r1, #3
	str r1, [r4, r0]
	mov r0, #0xc
	bl LoadSysSound
	mov r0, #8
	mov r1, #1
	bl PlaySysTrack
	b _02156D0E
_02156C7A:
	ldr r0, [r4, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _02156C9E
	mov r0, #4
	str r0, [r4]
	ldr r0, _02156DAC // =0x00002CBC
	mov r1, #8
	str r1, [r4, r0]
	mov r0, #0x11
	bl LoadSysSound
	mov r0, #0xb
	mov r1, #1
	bl PlaySysTrack
	b _02156D0E
_02156C9E:
	mov r0, #1
	str r0, [r4]
	ldr r0, _02156DAC // =0x00002CBC
	mov r1, #4
	str r1, [r4, r0]
	mov r0, #0xd
	bl LoadSysSound
	mov r0, #0xa
	mov r1, #1
	bl PlaySysTrack
	b _02156D0E
_02156CB8:
	ldr r0, [r4, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _02156CDC
	mov r0, #4
	str r0, [r4]
	ldr r0, _02156DAC // =0x00002CBC
	mov r1, #8
	str r1, [r4, r0]
	mov r0, #0x11
	bl LoadSysSound
	mov r0, #0xb
	mov r1, #1
	bl PlaySysTrack
	b _02156D0E
_02156CDC:
	mov r0, #1
	str r0, [r4]
	ldr r0, _02156DAC // =0x00002CBC
	mov r1, #5
	str r1, [r4, r0]
	mov r0, #0xe
	bl LoadSysSound
	mov r0, #0xc
	mov r1, #1
	bl PlaySysTrack
	b _02156D0E
_02156CF6:
	mov r0, #2
	str r0, [r4]
	ldr r0, _02156DAC // =0x00002CBC
	mov r1, #3
	str r1, [r4, r0]
	mov r0, #0xc
	bl LoadSysSound
	mov r0, #8
	mov r1, #1
	bl PlaySysTrack
_02156D0E:
	ldr r0, [r4, #0]
	bl StageClear__IsMissionMode
	cmp r0, #0
	beq _02156D1C
	mov r0, #2
	str r0, [r4]
_02156D1C:
	ldr r0, [r5, #4]
	str r0, [r4, #8]
	mov r0, r4
	bl StageClear__LoadAssets
	mov r0, r4
	bl StageClearBackground__Init
	mov r0, r4
	bl StageClearPlayer__Create
	mov r0, r4
	bl StageClearHeader__Create
	ldr r0, [r4, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _02156D4E
	mov r0, r4
	bl StageClearTimeAttackRankList__Create
	mov r0, r4
	bl Task__Unknown2158C6C__LoadAssets
_02156D4E:
	ldr r0, [r4, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	bne _02156D74
	ldr r0, [r4, #0]
	cmp r0, #2
	beq _02156D6C
	mov r0, r4
	bl StageClearStageScoreTally__Create
	mov r0, r4
	bl StageClearStageRank__Create
	b _02156D80
_02156D6C:
	mov r0, r4
	bl StageClearMissionClearText__Create
	b _02156D80
_02156D74:
	mov r0, r4
	bl StageClearTAScoreTally__Create
	mov r0, r4
	bl StageClearTARank__Create
_02156D80:
	ldr r0, [r4, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	bne _02156D9A
	ldr r0, [r4, #0]
	bl StageClear__IsMissionMode
	cmp r0, #0
	bne _02156D9A
	mov r0, r4
	bl StageClearMaterialReward__Create
_02156D9A:
	bl ResetTouchInput
	pop {r3, r4, r5, pc}
	.align 2, 0
_02156DA0: .word gameState
_02156DA4: .word renderCoreGFXControlA+0x00000040
_02156DA8: .word 0x0217DB58
_02156DAC: .word 0x00002CBC
	thumb_func_end StageClear__InitComponents

	thumb_func_start StageClear__Destroy
StageClear__Destroy: // 0x02156DB0
	push {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl ReleaseTouchInput
	ldr r0, [r4, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _02156DD2
	mov r0, r4
	bl StageClearTimeAttackRankList__Destroy
	mov r0, r4
	bl Task__Unknown2158C6C__ReleaseAssets
_02156DD2:
	ldr r0, [r4, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	bne _02156DE2
	mov r0, r4
	bl StageClearMaterialReward__Destroy
_02156DE2:
	ldr r0, [r4, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	bne _02156E08
	ldr r0, [r4, #0]
	cmp r0, #2
	beq _02156E00
	mov r0, r4
	bl StageClearStageRank__Destroy
	mov r0, r4
	bl StageClearStageScoreTally__Destroy
	b _02156E14
_02156E00:
	mov r0, r4
	bl StageClearMissionClearText__Destroy
	b _02156E14
_02156E08:
	mov r0, r4
	bl StageClearTARank__Destroy
	mov r0, r4
	bl StageClearTAScoreTally__Destroy
_02156E14:
	mov r0, r4
	bl StageClearHeader__Destroy
	mov r0, r4
	bl StageClearPlayer__Destroy
	mov r0, r4
	bl StageClearBackground__Destroy
	mov r0, r4
	bl StageClear__ReleaseAssets
	bl ReleaseSysSound
	pop {r4, pc}
	.align 2, 0
	thumb_func_end StageClear__Destroy

	thumb_func_start StageClear__Func_2156E34
StageClear__Func_2156E34: // 0x02156E34
	mov r2, #1
	ldr r0, _02156E5C // =renderCurrentDisplay
	mov r1, #0
	str r1, [r0]
	lsl r2, r2, #0x1a
	ldr r1, [r2, #0]
	ldr r0, _02156E60 // =0xFFFFE0FF
	mov r3, r1
	mov r1, #0x13
	and r3, r0
	lsl r1, r1, #8
	orr r3, r1
	str r3, [r2]
	ldr r3, _02156E64 // =0x04001000
	ldr r2, [r3, #0]
	and r0, r2
	orr r0, r1
	str r0, [r3]
	bx lr
	nop
_02156E5C: .word renderCurrentDisplay
_02156E60: .word 0xFFFFE0FF
_02156E64: .word 0x04001000
	thumb_func_end StageClear__Func_2156E34

	thumb_func_start StageClear__StartFadeOut
StageClear__StartFadeOut: // 0x02156E68
	push {r4, r5, r6, lr}
	mov r4, r0
	ldr r0, _02156F9C // =StageClear__Singleton
	ldr r6, _02156FA0 // =gameState
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, r0
	mov r0, #8
	str r0, [r5, #4]
	ldr r0, [r5, #0]
	bl StageClear__IsMissionMode
	cmp r0, #0
	beq _02156E9C
	ldr r0, _02156FA4 // =gameState+0x000000C0
	mov r1, #5
	strb r1, [r0, #0x1c]
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	mov r0, #0x1c
	bl RequestNewSysEventChange
	b _02156F8A
_02156E9C:
	ldr r0, [r5, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _02156EDC
	cmp r4, #1
	beq _02156EB0
	cmp r4, #2
	beq _02156EBA
	b _02156EC4
_02156EB0:
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	b _02156ED2
_02156EBA:
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	b _02156ED2
_02156EC4:
	ldr r0, _02156FA4 // =gameState+0x000000C0
	mov r1, #1
	strb r1, [r0, #0x1c]
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
_02156ED2:
	lsl r0, r4, #0x10
	asr r0, r0, #0x10
	bl RequestSysEventChange
	b _02156F8A
_02156EDC:
	ldrh r1, [r6, #0x28]
	ldr r0, _02156FA8 // =0x0217DB58
	ldrb r0, [r0, r1]
	cmp r0, #5
	bhi _02156F84
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02156EF2: // jump table
	.hword _02156EFE - _02156EF2 - 2 // case 0
	.hword _02156F16 - _02156EF2 - 2 // case 1
	.hword _02156F2C - _02156EF2 - 2 // case 2
	.hword _02156F42 - _02156EF2 - 2 // case 3
	.hword _02156F6E - _02156EF2 - 2 // case 4
	.hword _02156F58 - _02156EF2 - 2 // case 5
_02156EFE:
	mov r0, #5
	bl SaveGame__SetProgressType
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	mov r0, #0x28
	bl RequestNewSysEventChange
	b _02156F8A
_02156F16:
	mov r0, #5
	bl SaveGame__SetProgressType
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	mov r0, #0x28
	bl RequestNewSysEventChange
	b _02156F8A
_02156F2C:
	mov r0, #5
	bl SaveGame__SetProgressType
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	mov r0, #0x28
	bl RequestNewSysEventChange
	b _02156F8A
_02156F42:
	mov r0, #5
	bl SaveGame__SetProgressType
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	mov r0, #0x28
	bl RequestNewSysEventChange
	b _02156F8A
_02156F58:
	mov r0, #5
	bl SaveGame__SetProgressType
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	mov r0, #0x28
	bl RequestNewSysEventChange
	b _02156F8A
_02156F6E:
	mov r0, #0
	bl SaveGame__SetProgressType
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	mov r0, #0x28
	bl RequestNewSysEventChange
	b _02156F8A
_02156F84:
	mov r0, #0x28
	bl RequestNewSysEventChange
_02156F8A:
	mov r0, #0xc
	bl FadeSysTrack
	ldr r0, _02156F9C // =StageClear__Singleton
	ldr r1, _02156FAC // =StageClear__Main_2159608
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	pop {r4, r5, r6, pc}
	.align 2, 0
_02156F9C: .word StageClear__Singleton
_02156FA0: .word gameState
_02156FA4: .word gameState+0x000000C0
_02156FA8: .word 0x0217DB58
_02156FAC: .word StageClear__Main_2159608
	thumb_func_end StageClear__StartFadeOut

	thumb_func_start StageClear__LoadAssets
StageClear__LoadAssets: // 0x02156FB0
	push {r4, r5, r6, lr}
	sub sp, #0x10
	mov r4, r0
	ldr r0, _021570FC // =gameArchiveCommon
	mov r5, r4
	add r5, #0xc
	ldr r0, [r0, #0]
	mov r3, r5
	str r0, [r5, #0xc]
	ldr r0, [r4, #8]
	ldr r2, _02157100 // =aCldmCldmFixBac
	lsl r1, r0, #3
	ldr r0, _02157104 // =playerWork
	add r3, #0x14
	ldr r0, [r0, r1]
	mov r1, r5
	str r0, [r4, #0xc]
	ldr r0, _02157108 // =animationWork
	add r1, #0x10
	ldr r0, [r0, #0]
	str r0, [r5, #4]
	ldr r0, _0215710C // =aCldmCldmBaseBb
	str r0, [sp]
	mov r0, r5
	add r0, #8
	str r0, [sp, #4]
	ldr r0, _02157110 // =aCldmCldmBsd
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	ldr r0, [r5, #0xc]
	bl StageClear__LoadFiles
	ldr r0, [r4, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _0215709A
	mov r2, #0
	mov r6, r4
	ldr r0, _02157114 // =aNarcCldmTimeLz
	sub r1, r2, #1
	mov r3, #1
	add r6, #0x24
	str r2, [sp]
	bl ArchiveFile__Load
	mov r2, #0
	str r0, [r4, #0x24]
	add r1, r6, #4
	mov r3, r2
	bl StageClear__LoadFiles
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _02157044
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02157030: // jump table
	.hword _0215703C - _02157030 - 2 // case 0
	.hword _0215703C - _02157030 - 2 // case 1
	.hword _0215703C - _02157030 - 2 // case 2
	.hword _0215703C - _02157030 - 2 // case 3
	.hword _0215703C - _02157030 - 2 // case 4
	.hword _0215703C - _02157030 - 2 // case 5
_0215703C:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _02157046
_02157044:
	mov r1, #1
_02157046:
	mov r2, #0
	ldr r0, _02157118 // =aBbCldmLangBb
	str r2, [sp]
	mov r3, r2
	bl ArchiveFile__Load
	str r0, [r6, #8]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _0215707E
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215706A: // jump table
	.hword _02157076 - _0215706A - 2 // case 0
	.hword _02157076 - _0215706A - 2 // case 1
	.hword _02157076 - _0215706A - 2 // case 2
	.hword _02157076 - _0215706A - 2 // case 3
	.hword _02157076 - _0215706A - 2 // case 4
	.hword _02157076 - _0215706A - 2 // case 5
_02157076:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _02157080
_0215707E:
	mov r1, #1
_02157080:
	mov r2, #0
	ldr r0, _0215711C // =aBbDmtaMenuBb_ovl03
	str r2, [sp]
	mov r3, #1
	bl ArchiveFile__Load
	str r0, [r6, #0xc]
	add r6, #0x10
	mov r1, r6
	mov r2, #1
	mov r3, #0
	bl StageClear__LoadFiles
_0215709A:
	ldr r0, [r4, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	bne _021570DA
	mov r2, #0
	mov r6, r4
	ldr r0, _02157120 // =aNarcCldmMtralL
	str r2, [sp]
	sub r1, r2, #1
	mov r3, #1
	add r6, #0x38
	bl ArchiveFile__Load
	str r0, [r4, #0x38]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	mov r3, r6
	ldr r0, [r4, #0x38]
	add r1, r6, #4
	mov r2, #1
	add r3, #8
	bl StageClear__LoadFiles
	add r6, #0xc
	ldr r0, [r5, #0xc]
	ldr r2, _02157124 // =aAcEffGoalJewel_0
	mov r1, r6
	mov r3, #0
	bl StageClear__LoadFiles
_021570DA:
	mov r2, #0
	mov r5, r4
	ldr r0, _02157128 // =aNarcCldmMissio
	sub r1, r2, #1
	mov r3, #1
	add r5, #0x48
	str r2, [sp]
	bl ArchiveFile__Load
	mov r2, #0
	add r1, r5, #4
	mov r3, r2
	str r0, [r4, #0x48]
	bl StageClear__LoadFiles
	add sp, #0x10
	pop {r4, r5, r6, pc}
	.align 2, 0
_021570FC: .word gameArchiveCommon
_02157100: .word aCldmCldmFixBac
_02157104: .word playerWork
_02157108: .word animationWork
_0215710C: .word aCldmCldmBaseBb
_02157110: .word aCldmCldmBsd
_02157114: .word aNarcCldmTimeLz
_02157118: .word aBbCldmLangBb
_0215711C: .word aBbDmtaMenuBb_ovl03
_02157120: .word aNarcCldmMtralL
_02157124: .word aAcEffGoalJewel_0
_02157128: .word aNarcCldmMissio
	thumb_func_end StageClear__LoadAssets

	thumb_func_start StageClear__LoadFiles
StageClear__LoadFiles: // 0x0215712C
	push {r0, r1, r2, r3}
	push {r3, lr}
	add r2, sp, #8
	mov r1, #3
	bic r2, r1
	ldr r0, [sp, #8]
	add r1, r2, #4
	bl ArchiveFile__LoadFiles
	pop {r3}
	pop {r3}
	add sp, #0x10
	bx r3
	.align 2, 0
	thumb_func_end StageClear__LoadFiles

	thumb_func_start StageClear__ReleaseAssets
StageClear__ReleaseAssets: // 0x02157148
	push {r4, r5, r6, lr}
	mov r5, r0
	ldr r0, [r5, #0x48]
	mov r6, r5
	add r6, #0xc
	cmp r0, #0
	beq _0215715A
	bl _FreeHEAP_USER
_0215715A:
	ldr r0, [r5, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _0215717E
	ldr r0, [r5, #0x24]
	mov r4, r5
	add r4, #0x24
	cmp r0, #0
	beq _0215717E
	bl _FreeHEAP_USER
	ldr r0, [r4, #8]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xc]
	bl _FreeHEAP_USER
_0215717E:
	ldr r0, [r5, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	bne _02157192
	ldr r0, [r5, #0x38]
	cmp r0, #0
	beq _02157192
	bl _FreeHEAP_USER
_02157192:
	mov r0, #0
	mov r1, r6
	mov r2, #0x44
	bl MIi_CpuClear16
	pop {r4, r5, r6, pc}
	.align 2, 0
	thumb_func_end StageClear__ReleaseAssets

	thumb_func_start StageClearPlayer__Create
StageClearPlayer__Create: // 0x021571A0
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r4, r0
	ldr r7, [r0, #0xc]
	ldr r6, [r0, #0x10]
	ldr r5, [r0, #0x14]
	ldr r0, [r0, #8]
	add r4, #0x50
	cmp r0, #0
	beq _021571BA
	cmp r0, #1
	beq _021571E0
	b _02157234
_021571BA:
	mov r0, r4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	mov r0, r4
	mov r1, r7
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	mov r0, r4
	mov r2, r6
	mov r3, #0x31
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
	b _02157234
_021571E0:
	mov r0, r4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	mov r0, r4
	mov r1, r7
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	mov r0, r4
	mov r2, r6
	mov r3, #0x4d
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
	mov r0, #0x51
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0
	bl AnimatorMDL__Init
	mov r0, #0x51
	lsl r0, r0, #2
	mov r3, #0
	add r0, r4, r0
	mov r1, r7
	mov r2, #2
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r0, #0x51
	lsl r0, r0, #2
	mov r1, #0
	add r0, r4, r0
	mov r2, r6
	mov r3, #0x71
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
_02157234:
	ldr r1, _02157290 // =0x001FFFF8
	mov r0, r5
	bl LoadDrawState
	mov r0, #0xa2
	lsl r0, r0, #2
	add r4, r4, r0
	mov r0, r5
	mov r1, r4
	bl GetDrawStateCameraView
	mov r0, r5
	mov r1, r4
	bl GetDrawStateCameraProjection
	mov r0, #0xa
	lsl r0, r0, #8
	str r0, [r4, #0x14]
	mov r0, #6
	lsl r0, r0, #8
	str r0, [r4, #0x18]
	mov r0, r4
	bl Camera3D__LoadState
	mov r1, #0
	mov r0, #0x41
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02157294 // =StageClearPlayer__Main1
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	mov r1, #0
	mov r0, #0x81
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02157298 // =StageClearPlayer__Main2
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02157290: .word 0x001FFFF8
_02157294: .word StageClearPlayer__Main1
_02157298: .word StageClearPlayer__Main2
	thumb_func_end StageClearPlayer__Create

	thumb_func_start StageClearPlayer__Destroy
StageClearPlayer__Destroy: // 0x0215729C
	push {r4, lr}
	mov r4, r0
	ldr r0, [r0, #8]
	add r4, #0x50
	cmp r0, #0
	beq _021572AE
	cmp r0, #1
	beq _021572B6
	pop {r4, pc}
_021572AE:
	mov r0, r4
	bl AnimatorMDL__Release
	pop {r4, pc}
_021572B6:
	mov r0, r4
	bl AnimatorMDL__Release
	mov r0, #0x51
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorMDL__Release
	pop {r4, pc}
	thumb_func_end StageClearPlayer__Destroy

	thumb_func_start StageClearPlayer__Func_21572C8
StageClearPlayer__Func_21572C8: // 0x021572C8
	push {r4, lr}
	mov r4, r0
	ldr r0, [r0, #8]
	add r4, #0x50
	cmp r0, #0
	beq _021572DA
	cmp r0, #1
	beq _021572E6
	pop {r4, pc}
_021572DA:
	mov r1, #0x4b
	mov r0, r4
	lsl r1, r1, #0xe
	bl StageClearPlayer__Func_2157300
	pop {r4, pc}
_021572E6:
	mov r1, #0x4b
	mov r0, r4
	lsl r1, r1, #0xe
	bl StageClearPlayer__Func_2157300
	mov r0, #0x51
	lsl r0, r0, #2
	mov r1, #0x4b
	add r0, r4, r0
	lsl r1, r1, #0xe
	bl StageClearPlayer__Func_2157300
	pop {r4, pc}
	thumb_func_end StageClearPlayer__Func_21572C8

	thumb_func_start StageClearPlayer__Func_2157300
StageClearPlayer__Func_2157300: // 0x02157300
	mov r3, r0
	add r3, #0xe4
	add r0, #0xf8
	cmp r3, r0
	beq _02157318
_0215730A:
	ldr r2, [r3, #0]
	cmp r2, #0
	beq _02157312
	str r1, [r2]
_02157312:
	add r3, r3, #4
	cmp r3, r0
	bne _0215730A
_02157318:
	bx lr
	.align 2, 0
	thumb_func_end StageClearPlayer__Func_2157300

	thumb_func_start StageClearHeader__Create
StageClearHeader__Create: // 0x0215731C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x2c
	mov r5, r0
	mov r0, #0xca
	lsl r0, r0, #2
	ldr r6, [r5, #0x1c]
	add r4, r5, r0
	mov r0, r6
	mov r1, #0xc
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r7, r0
	mov r0, r6
	mov r1, #0xc
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r7, [sp, #8]
	ldr r1, _021574D8 // =0x05000200
	str r3, [sp, #0xc]
	str r1, [sp, #0x10]
	str r3, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r0, _021574DC // =0x05000600
	str r3, [sp, #0x1c]
	str r0, [sp, #0x20]
	str r3, [sp, #0x24]
	mov r0, #0x10
	str r0, [sp, #0x28]
	mov r0, r4
	mov r1, r6
	mov r2, #0xc
	bl AnimatorSpriteDS__Init
	mov r0, r4
	mov r1, #1
	add r0, #0x90
	strh r1, [r0]
	mov r0, r4
	add r0, #0x92
	strh r1, [r0]
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
	ldr r0, [r5, #8]
	mov r7, #0x42
	lsl r1, r0, #1
	ldr r0, _021574E0 // =0x0217D21C
	lsl r7, r7, #2
	ldrh r5, [r0, r1]
	mov r0, r6
	mov r1, r5
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021574D8 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r0, #0xf
	str r0, [sp, #0x18]
	add r0, r4, r7
	mov r1, r6
	mov r2, r5
	bl AnimatorSprite__Init
	add r0, r4, r7
	mov r1, #1
	add r0, #0x50
	strh r1, [r0]
	mov r1, #0
	add r0, r4, r7
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #8
	str r0, [sp]
	add r0, #0xf8
	str r0, [sp, #4]
	mov r0, #0
	str r0, [sp, #8]
	ldr r0, _021574E4 // =StageClearHeader__MoverCallback
	mov r1, #2
	str r0, [sp, #0xc]
	mov r0, r7
	add r0, #0x70
	add r0, r4, r0
	str r0, [sp, #0x10]
	add r0, r4, r7
	add r0, #0xa
	mov r2, #0xce
	mov r3, #0xaa
	bl StageClearMover__Create
	mov r1, r7
	add r1, #0x70
	str r0, [r4, r1]
	ldr r0, _021574E8 // =gameState
	mov r5, r4
	ldrh r1, [r0, #0x28]
	ldr r0, _021574EC // =0x0217DB58
	add r5, #0xa4
	ldrb r0, [r0, r1]
	cmp r0, #3
	beq _02157420
	cmp r0, #4
	beq _0215741C
	cmp r0, #5
	bne _02157424
_0215741C:
	mov r7, #0x13
	b _0215743C
_02157420:
	mov r7, #0x12
	b _0215743C
_02157424:
	ldr r0, _021574E8 // =gameState
	ldrh r0, [r0, #0x28]
	lsl r1, r0, #1
	ldr r0, _021574F0 // =0x0217D2B8
	ldrh r1, [r0, r1]
	mov r0, #0xf
	and r0, r1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	add r0, #0xf
	lsl r0, r0, #0x10
	lsr r7, r0, #0x10
_0215743C:
	mov r0, r6
	mov r1, r7
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r1, #1
	str r1, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021574D8 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r0, #0xf
	str r0, [sp, #0x18]
	mov r0, r5
	mov r1, r6
	mov r2, r7
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #1
	add r0, #0x50
	strh r1, [r0]
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #8
	str r0, [sp]
	add r0, #0xf8
	str r0, [sp, #4]
	mov r0, #0
	str r0, [sp, #8]
	ldr r0, _021574E4 // =StageClearHeader__MoverCallback
	mov r1, #2
	str r0, [sp, #0xc]
	mov r0, #0x5d
	lsl r0, r0, #2
	add r0, r4, r0
	mov r2, r1
	add r5, #0xa
	str r0, [sp, #0x10]
	mov r0, r5
	sub r2, #0x10
	mov r3, #0x16
	bl StageClearMover__Create
	mov r1, #0x5d
	lsl r1, r1, #2
	str r0, [r4, r1]
	mov r1, #0
	mov r0, #0x42
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _021574F4 // =StageClearHeader__Main1
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	mov r1, #0
	mov r0, #0x82
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _021574F8 // =StageClearHeader__Main2
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	add sp, #0x2c
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_021574D8: .word 0x05000200
_021574DC: .word 0x05000600
_021574E0: .word 0x0217D21C
_021574E4: .word StageClearHeader__MoverCallback
_021574E8: .word gameState
_021574EC: .word 0x0217DB58
_021574F0: .word 0x0217D2B8
_021574F4: .word StageClearHeader__Main1
_021574F8: .word StageClearHeader__Main2
	thumb_func_end StageClearHeader__Create

	thumb_func_start StageClearHeader__Destroy
StageClearHeader__Destroy: // 0x021574FC
	push {r4, lr}
	mov r1, #0xca
	lsl r1, r1, #2
	add r4, r0, r1
	mov r0, r4
	bl AnimatorSpriteDS__Release
	mov r0, #0x42
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__Release
	add r4, #0xa4
	mov r0, r4
	bl AnimatorSprite__Release
	pop {r4, pc}
	.align 2, 0
	thumb_func_end StageClearHeader__Destroy

	thumb_func_start StageClearStageScoreTally__Create
StageClearStageScoreTally__Create: // 0x02157520
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x30
	str r0, [sp, #0x1c]
	ldr r1, [sp, #0x1c]
	ldr r0, _0215789C // =0x000006B8
	ldr r6, [r1, #0x1c]
	add r4, r1, r0
	mov r1, r0
	mov r2, #1
	add r1, #0x24
	str r2, [r4, r1]
	ldr r1, [sp, #0x1c]
	ldr r7, _021578A0 // =gameState
	ldr r1, [r1, #0]
	ldr r5, _021578A4 // =playerGameStatus
	cmp r1, #0
	beq _0215754C
	cmp r1, #1
	beq _02157592
	cmp r1, #2
	beq _021575C8
	b _0215760C
_0215754C:
	ldrh r0, [r7, #0x28]
	ldr r1, [r5, #0x1c]
	bl StageClear__GetRingBonus
	mov r1, #0x1b
	lsl r1, r1, #6
	str r0, [r4, r1]
	ldrh r0, [r7, #0x28]
	ldr r1, [r5, #0x10]
	bl StageClear__GetTrickBonus
	ldr r1, _021578A8 // =0x000006C4
	str r0, [r4, r1]
	ldrh r0, [r7, #0x28]
	ldr r1, [r5, #0xc]
	bl StageClear__GetTimeBonus
	ldr r1, _021578AC // =0x000006C8
	mov r2, #0
	str r0, [r4, r1]
	add r0, r1, #4
	str r2, [r4, r0]
	ldr r3, [r4, r0]
	mov r0, r1
	sub r0, #8
	sub r5, r1, #4
	ldr r2, [r4, r1]
	ldr r0, [r4, r0]
	ldr r5, [r4, r5]
	add r1, #8
	add r0, r0, r5
	add r0, r2, r0
	add r0, r3, r0
	str r0, [r4, r1]
	b _0215760C
_02157592:
	mov r1, r0
	mov r2, #0
	add r1, #0xc
	str r2, [r4, r1]
	add r0, #0x14
	str r2, [r4, r0]
	ldrh r0, [r7, #0x28]
	ldr r1, [r5, #0x1c]
	bl StageClear__GetRingBonus
	mov r1, #0x1b
	lsl r1, r1, #6
	str r0, [r4, r1]
	ldrh r0, [r7, #0x28]
	ldr r1, [r5, #0xc]
	bl StageClear__GetTimeBonus
	ldr r1, _021578AC // =0x000006C8
	str r0, [r4, r1]
	mov r0, r1
	sub r0, #8
	ldr r2, [r4, r0]
	ldr r0, [r4, r1]
	add r1, #8
	add r0, r2, r0
	str r0, [r4, r1]
	b _0215760C
_021575C8:
	ldrh r0, [r7, #0x28]
	ldr r1, [r5, #0x1c]
	bl StageClear__GetRingBonus
	mov r1, #0x1b
	lsl r1, r1, #6
	str r0, [r4, r1]
	ldrh r0, [r7, #0x28]
	ldr r1, [r5, #0x10]
	bl StageClear__GetTrickBonus
	ldr r1, _021578A8 // =0x000006C4
	str r0, [r4, r1]
	ldrh r0, [r7, #0x28]
	ldr r1, [r5, #0xc]
	bl StageClear__GetTimeBonus
	ldr r1, _021578AC // =0x000006C8
	mov r2, #0
	str r0, [r4, r1]
	add r0, r1, #4
	str r2, [r4, r0]
	ldr r3, [r4, r0]
	mov r0, r1
	sub r0, #8
	sub r5, r1, #4
	ldr r2, [r4, r1]
	ldr r0, [r4, r0]
	ldr r5, [r4, r5]
	add r1, #8
	add r0, r0, r5
	add r0, r2, r0
	add r0, r3, r0
	str r0, [r4, r1]
_0215760C:
	mov r5, r4
	mov r7, #0
	add r5, #8
_02157612:
	mov r0, r7
	add r0, #0x17
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x2c]
	ldr r1, [sp, #0x2c]
	mov r0, r6
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
	ldr r0, _021578B0 // =0x05000200
	mov r1, r6
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0xe
	str r0, [sp, #0x18]
	ldr r2, [sp, #0x2c]
	mov r0, r5
	mov r3, #0
	bl AnimatorSprite__Init
	mov r1, r5
	add r1, #0x50
	mov r0, #3
	strh r0, [r1]
	sub r0, #0xa3
	strh r0, [r5, #8]
	mov r0, #0
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r7, r7, #1
	add r5, #0x64
	cmp r7, #4
	blo _02157612
	mov r5, #0x66
	mov r0, r6
	mov r1, #0x1b
	lsl r5, r5, #2
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021578B0 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0xe
	str r0, [sp, #0x18]
	add r0, r4, r5
	mov r1, r6
	mov r2, #0x1b
	bl AnimatorSprite__Init
	add r0, r4, r5
	mov r1, #3
	add r0, #0x50
	strh r1, [r0]
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0xb1
	lsl r0, r0, #2
	mov r7, #0
	add r5, r4, r0
_021576C0:
	lsl r0, r7, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x20]
	ldr r1, [sp, #0x20]
	mov r0, r6
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
	ldr r0, _021578B0 // =0x05000200
	mov r1, r6
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0xf
	str r0, [sp, #0x18]
	ldr r2, [sp, #0x20]
	mov r0, r5
	mov r3, #0
	bl AnimatorSprite__Init
	mov r1, r5
	add r1, #0x50
	mov r0, #0
	strh r0, [r1]
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r7, r7, #1
	add r5, #0x64
	cmp r7, #0xa
	blo _021576C0
	mov r5, #0x7f
	mov r0, r6
	mov r1, #0xa
	lsl r5, r5, #2
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021578B0 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0x10
	str r0, [sp, #0x18]
	add r0, r4, r5
	mov r1, r6
	mov r2, #0xa
	bl AnimatorSprite__Init
	add r0, r4, r5
	mov r1, #1
	add r0, #0x50
	strh r1, [r0]
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	mov r1, #0xb
	add r5, #0x64
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021578B0 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0x10
	str r0, [sp, #0x18]
	add r0, r4, r5
	mov r1, r6
	mov r2, #0xb
	bl AnimatorSprite__Init
	add r0, r4, r5
	mov r1, #1
	add r0, #0x50
	strh r1, [r0]
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0]
	cmp r0, #1
	bne _021577DA
	mov r0, r4
	mov r2, #0
	add r0, #8
	mov r1, #0x10
	mov r3, #0xa
	mov r5, #1
_021577B2:
	cmp r2, #1
	beq _021577BA
	cmp r2, #3
	bne _021577C2
_021577BA:
	ldr r6, [r0, #0x3c]
	orr r6, r5
	str r6, [r0, #0x3c]
	b _021577C8
_021577C2:
	ldrsh r6, [r0, r3]
	add r6, r6, r1
	strh r6, [r0, #0xa]
_021577C8:
	add r2, r2, #1
	add r0, #0x64
	sub r1, r1, #6
	cmp r2, #4
	blo _021577B2
	ldr r0, _021578B4 // =0x000001A2
	ldrsh r1, [r4, r0]
	sub r1, #8
	strh r1, [r4, r0]
_021577DA:
	bl AllocSndHandle
	str r0, [r4, #4]
	mov r0, #0
	mvn r0, r0
	strh r0, [r4]
	mov r0, #0x43
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	ldr r0, _021578B8 // =StageClearStageScoreTally__Main1
	ldr r1, _021578BC // =StageClearStageScoreTally__Destructor
	mov r3, r2
	str r2, [sp, #8]
	bl TaskCreate_
	mov r1, #0
	mov r0, #0x83
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _021578C0 // =StageClearStageScoreTally__Main2
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	ldr r0, _021578C4 // =0x000006AC
	mov r5, r4
	add r0, r4, r0
	mov r6, #0
	add r5, #8
	str r0, [sp, #0x28]
	mov r7, #0x10
	str r4, [sp, #0x24]
_0215781E:
	cmp r6, #3
	beq _02157856
	ldr r1, [r5, #0x3c]
	mov r0, #1
	tst r0, r1
	bne _02157856
	lsl r0, r7, #0x10
	lsr r0, r0, #0x10
	str r0, [sp]
	mov r0, #0x80
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	ldr r0, _021578C8 // =StageClearStageScoreTally__MoverCallback_Bonus
	mov r1, #2
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x28]
	mov r2, r1
	str r0, [sp, #0x10]
	mov r0, r5
	add r0, #8
	sub r2, #0xa2
	mov r3, #0
	bl StageClearMover__Create
	ldr r2, [sp, #0x24]
	ldr r1, _021578C4 // =0x000006AC
	str r0, [r2, r1]
_02157856:
	ldr r0, [sp, #0x28]
	add r6, r6, #1
	add r0, r0, #4
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x24]
	add r5, #0x64
	add r0, r0, #4
	add r7, #8
	str r0, [sp, #0x24]
	cmp r6, #4
	blo _0215781E
	mov r0, #0x30
	str r0, [sp]
	mov r0, #0x80
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	ldr r0, _021578CC // =StageClearStageScoreTally__MoverCallback_Total
	mov r1, #2
	str r0, [sp, #0xc]
	ldr r0, _021578D0 // =0x000006BC
	mov r2, r1
	add r0, r4, r0
	str r0, [sp, #0x10]
	mov r0, #0x1a
	lsl r0, r0, #4
	add r0, r4, r0
	sub r2, #0xa2
	mov r3, #0
	bl StageClearMover__Create
	ldr r1, _021578D0 // =0x000006BC
	str r0, [r4, r1]
	add sp, #0x30
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215789C: .word 0x000006B8
_021578A0: .word gameState
_021578A4: .word playerGameStatus
_021578A8: .word 0x000006C4
_021578AC: .word 0x000006C8
_021578B0: .word 0x05000200
_021578B4: .word 0x000001A2
_021578B8: .word StageClearStageScoreTally__Main1
_021578BC: .word StageClearStageScoreTally__Destructor
_021578C0: .word StageClearStageScoreTally__Main2
_021578C4: .word 0x000006AC
_021578C8: .word StageClearStageScoreTally__MoverCallback_Bonus
_021578CC: .word StageClearStageScoreTally__MoverCallback_Total
_021578D0: .word 0x000006BC
	thumb_func_end StageClearStageScoreTally__Create

	thumb_func_start StageClearStageScoreTally__Destroy
StageClearStageScoreTally__Destroy: // 0x021578D4
	push {r4, r5, r6, lr}
	ldr r1, _02157948 // =0x000006B8
	add r6, r0, r1
	ldr r0, [r6, #4]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	ldr r0, [r6, #4]
	bl FreeSndHandle
	mov r0, #0x66
	mov r5, r6
	lsl r0, r0, #2
	add r5, #8
	add r4, r6, r0
	cmp r5, r4
	beq _02157902
_021578F6:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _021578F6
_02157902:
	mov r0, #0x66
	lsl r0, r0, #2
	add r0, r6, r0
	bl AnimatorSprite__Release
	mov r0, #0xb1
	lsl r0, r0, #2
	add r5, r6, r0
	ldr r0, _0215794C // =0x000006AC
	add r4, r6, r0
	cmp r5, r4
	beq _02157926
_0215791A:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _0215791A
_02157926:
	mov r0, #0x7f
	lsl r0, r0, #2
	add r0, r6, r0
	bl AnimatorSprite__Release
	mov r0, #0x26
	lsl r0, r0, #4
	add r0, r6, r0
	bl AnimatorSprite__Release
	ldr r1, _02157950 // =playerGameStatus
	ldr r0, _02157954 // =saveGame+0x00000028
	ldr r1, [r1, #0x1c]
	bl SaveGame__GiveRings
	pop {r4, r5, r6, pc}
	nop
_02157948: .word 0x000006B8
_0215794C: .word 0x000006AC
_02157950: .word playerGameStatus
_02157954: .word saveGame+0x00000028
	thumb_func_end StageClearStageScoreTally__Destroy

	thumb_func_start StageClearStageScoreTally__Func_2157958
StageClearStageScoreTally__Func_2157958: // 0x02157958
	push {r3, r4, r5, r6, r7, lr}
	ldr r1, _02157998 // =0x000006B8
	add r4, r0, r1
	mov r0, r1
	sub r0, #0xc
	add r1, #8
	add r5, r4, r0
	add r6, r4, r1
	cmp r5, r6
	beq _02157986
	mov r7, #0
_0215796E:
	ldr r0, [r5, #0]
	cmp r0, #0
	beq _02157978
	bl DestroyTask
_02157978:
	ldr r0, [r4, #4]
	mov r1, r7
	bl NNS_SndPlayerStopSeq
	add r5, r5, #4
	cmp r5, r6
	bne _0215796E
_02157986:
	ldr r0, _0215799C // =0x000006D8
	mov r1, #6
	strh r1, [r4, r0]
	mov r1, #0
	add r0, r0, #4
	str r1, [r4, r0]
	bl DestroyCurrentTask
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02157998: .word 0x000006B8
_0215799C: .word 0x000006D8
	thumb_func_end StageClearStageScoreTally__Func_2157958

	thumb_func_start StageClearStageScoreTally__Destructor
StageClearStageScoreTally__Destructor: // 0x021579A0
	push {r3, lr}
	ldr r0, _021579BC // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _021579B8
	bl GetTaskWork_
	mov r1, #3
	str r1, [r0, #4]
	ldr r1, _021579C0 // =0x00002CB8
	mov r2, #0
	strh r2, [r0, r1]
_021579B8:
	pop {r3, pc}
	nop
_021579BC: .word StageClear__Singleton
_021579C0: .word 0x00002CB8
	thumb_func_end StageClearStageScoreTally__Destructor

	thumb_func_start StageClearTAScoreTally__Create
StageClearTAScoreTally__Create: // 0x021579C4
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x28
	ldr r2, _02157C40 // =0x000006B8
	ldr r1, [r0, #0x1c]
	add r7, r0, r2
	ldr r4, [r0, #0x28]
	ldr r0, _02157C44 // =playerGameStatus
	str r1, [sp, #0x24]
	ldr r1, [r0, #0xc]
	mov r0, r2
	sub r0, #0x6c
	str r1, [r7, r0]
	mov r1, #0
	sub r2, #0x68
	mov r0, r4
	str r1, [r7, r2]
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02157C48 // =0x05000200
	str r2, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0xe
	str r0, [sp, #0x18]
	add r0, r7, #4
	mov r1, r4
	mov r3, r2
	bl AnimatorSprite__Init
	add r0, r7, #4
	mov r1, #3
	add r0, #0x50
	strh r1, [r0]
	sub r1, #0xa3
	strh r1, [r7, #0xc]
	mov r1, #0
	add r0, r7, #4
	mov r2, r1
	strh r1, [r7, #0xe]
	bl AnimatorSprite__ProcessAnimation
	mov r5, r7
	mov r0, r4
	mov r1, #1
	add r5, #0x68
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02157C48 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r2, #1
	str r2, [sp, #0x14]
	mov r0, #0xe
	str r0, [sp, #0x18]
	mov r0, r5
	mov r1, r4
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #3
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0x10
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x65
	lsl r0, r0, #2
	mov r6, #0
	add r5, r7, r0
_02157A78:
	add r0, r6, #7
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
	ldr r0, _02157C48 // =0x05000200
	mov r1, r4
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0xf
	str r0, [sp, #0x18]
	ldr r2, [sp, #0x20]
	mov r0, r5
	mov r3, #0
	bl AnimatorSprite__Init
	mov r1, r5
	add r1, #0x50
	mov r0, #0
	strh r0, [r1]
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	add r5, #0x64
	cmp r6, #0xa
	blo _02157A78
	ldr r0, _02157C4C // =0x0000057C
	mov r6, #0
	add r5, r7, r0
_02157AD4:
	mov r0, r6
	add r0, #0x11
	lsl r0, r0, #0x10
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
	ldr r0, _02157C48 // =0x05000200
	mov r1, r4
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0xf
	str r0, [sp, #0x18]
	ldr r2, [sp, #0x1c]
	mov r0, r5
	mov r3, #0
	bl AnimatorSprite__Init
	mov r1, r5
	add r1, #0x50
	mov r0, #0
	strh r0, [r1]
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	add r5, #0x64
	cmp r6, #2
	blo _02157AD4
	ldr r0, [sp, #0x24]
	mov r4, r7
	mov r1, #0xa
	add r4, #0xcc
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02157C48 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0x10
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x24]
	mov r0, r4
	mov r2, #0xa
	bl AnimatorSprite__Init
	mov r0, r4
	mov r1, #1
	add r0, #0x50
	strh r1, [r0]
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r4, #0x13
	ldr r0, [sp, #0x24]
	mov r1, #0xb
	lsl r4, r4, #4
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02157C48 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0x10
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x24]
	add r0, r7, r4
	mov r2, #0xb
	bl AnimatorSprite__Init
	add r0, r7, r4
	mov r1, #1
	add r0, #0x50
	strh r1, [r0]
	mov r1, #0
	add r0, r7, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0
	mvn r0, r0
	strh r0, [r7]
	mov r0, #0x43
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	ldr r0, _02157C50 // =StageClearStageScoreTally__Main3
	ldr r1, _02157C54 // =StageClearStageScoreTally__Destructor
	mov r3, r2
	str r2, [sp, #8]
	bl TaskCreate_
	mov r0, #0x83
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02157C58 // =StageClearStageScoreTally__Main4
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	mov r0, #0x40
	str r0, [sp]
	mov r0, #0x80
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	ldr r0, _02157C5C // =StageClearStageScoreTally__MoverCallback_Bonus
	mov r1, #2
	str r0, [sp, #0xc]
	ldr r0, _02157C60 // =0x00000644
	mov r2, r1
	add r0, r7, r0
	str r0, [sp, #0x10]
	mov r0, r7
	add r0, #0xc
	sub r2, #0xa2
	mov r3, #0
	bl StageClearMover__Create
	ldr r1, _02157C60 // =0x00000644
	mov r3, #0
	str r0, [r7, r1]
	mov r0, #0xc0
	str r0, [sp]
	mov r0, #0x80
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	ldr r0, _02157C64 // =StageClearStageScoreTally__MoverCallback_Total
	str r0, [sp, #0xc]
	add r0, r1, #4
	add r0, r7, r0
	mov r1, #2
	str r0, [sp, #0x10]
	mov r0, r7
	mov r2, r1
	add r0, #0x70
	sub r2, #0xa2
	bl StageClearMover__Create
	ldr r1, _02157C68 // =0x00000648
	str r0, [r7, r1]
	add sp, #0x28
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02157C40: .word 0x000006B8
_02157C44: .word playerGameStatus
_02157C48: .word 0x05000200
_02157C4C: .word 0x0000057C
_02157C50: .word StageClearStageScoreTally__Main3
_02157C54: .word StageClearStageScoreTally__Destructor
_02157C58: .word StageClearStageScoreTally__Main4
_02157C5C: .word StageClearStageScoreTally__MoverCallback_Bonus
_02157C60: .word 0x00000644
_02157C64: .word StageClearStageScoreTally__MoverCallback_Total
_02157C68: .word 0x00000648
	thumb_func_end StageClearTAScoreTally__Create

	thumb_func_start StageClearTAScoreTally__Destroy
StageClearTAScoreTally__Destroy: // 0x02157C6C
	push {r4, r5, r6, lr}
	ldr r1, _02157CD0 // =0x000006B8
	add r6, r0, r1
	mov r1, r6
	add r0, r6, #4
	add r1, #0x68
	cmp r0, r1
	beq _02157C80
	bl AnimatorSprite__Release
_02157C80:
	mov r0, r6
	add r0, #0x68
	bl AnimatorSprite__Release
	mov r0, #0x65
	lsl r0, r0, #2
	add r5, r6, r0
	ldr r0, _02157CD4 // =0x0000057C
	add r4, r6, r0
	cmp r5, r4
	beq _02157CA2
_02157C96:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _02157C96
_02157CA2:
	ldr r0, _02157CD4 // =0x0000057C
	add r5, r6, r0
	add r0, #0xc8
	add r4, r6, r0
	cmp r5, r4
	beq _02157CBA
_02157CAE:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _02157CAE
_02157CBA:
	mov r0, r6
	add r0, #0xcc
	bl AnimatorSprite__Release
	mov r0, #0x13
	lsl r0, r0, #4
	add r0, r6, r0
	bl AnimatorSprite__Release
	pop {r4, r5, r6, pc}
	nop
_02157CD0: .word 0x000006B8
_02157CD4: .word 0x0000057C
	thumb_func_end StageClearTAScoreTally__Destroy

	thumb_func_start StageClearStageScoreTally__Func_2157CD8
StageClearStageScoreTally__Func_2157CD8: // 0x02157CD8
	push {r3, r4, r5, lr}
	ldr r1, _02157D00 // =0x000006B8
	add r2, r0, r1
	mov r0, r1
	sub r0, #0x74
	sub r1, #0x6c
	add r4, r2, r0
	add r5, r2, r1
	cmp r4, r5
	beq _02157CFC
_02157CEC:
	ldr r0, [r4, #0]
	cmp r0, #0
	beq _02157CF6
	bl DestroyTask
_02157CF6:
	add r4, r4, #4
	cmp r4, r5
	bne _02157CEC
_02157CFC:
	pop {r3, r4, r5, pc}
	nop
_02157D00: .word 0x000006B8
	thumb_func_end StageClearStageScoreTally__Func_2157CD8

	thumb_func_start StageClearStageScoreTally__MoverCallback_Total
StageClearStageScoreTally__MoverCallback_Total: // 0x02157D04
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	mov r6, r0
	ldr r0, _02157D58 // =StageClear__Singleton
	mov r7, r1
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _02157D52
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _02157D58 // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _02157D5C // =0x000006B8
	add r5, r0, r1
	ldr r0, [r4, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	bne _02157D46
	ldr r0, _02157D60 // =0x00002CBC
	mov r1, #1
	ldr r0, [r4, r0]
	str r0, [sp]
	str r1, [sp, #4]
	sub r1, r1, #2
	ldr r0, [r5, #4]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02157D46:
	mov r0, #0
	strh r0, [r5]
	mov r0, r6
	mov r1, r7
	bl StageClearStageScoreTally__MoverCallback_Bonus
_02157D52:
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02157D58: .word StageClear__Singleton
_02157D5C: .word 0x000006B8
_02157D60: .word 0x00002CBC
	thumb_func_end StageClearStageScoreTally__MoverCallback_Total

	thumb_func_start StageClearStageRank__Create
StageClearStageRank__Create: // 0x02157D64
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x20
	ldr r1, _02157E98 // =0x00000D98
	str r0, [sp, #0x1c]
	add r4, r0, r1
	ldr r7, [r0, #0x1c]
	bl StageClear__GetRankAnim
	sub r0, #0x1c
	cmp r0, #3
	bhi _02157DA4
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02157D86: // jump table
	.hword _02157D8E - _02157D86 - 2 // case 0
	.hword _02157D94 - _02157D86 - 2 // case 1
	.hword _02157D9A - _02157D86 - 2 // case 2
	.hword _02157DA0 - _02157D86 - 2 // case 3
_02157D8E:
	mov r5, #0x1c
	mov r6, #0
	b _02157DA4
_02157D94:
	mov r5, #0x1d
	mov r6, #1
	b _02157DA4
_02157D9A:
	mov r5, #0x1e
	mov r6, #2
	b _02157DA4
_02157DA0:
	mov r5, #0x1f
	mov r6, #3
_02157DA4:
	ldr r0, _02157E9C // =gameState
	ldr r2, _02157EA0 // =0x00000D88
	ldrh r0, [r0, #0x28]
	lsl r1, r0, #1
	ldr r0, _02157EA4 // =0x0217D2B8
	ldrh r0, [r0, r1]
	ldr r1, [sp, #0x1c]
	asr r0, r0, #8
	lsl r0, r0, #0x18
	ldr r1, [r1, r2]
	lsr r0, r0, #0x18
	mov r2, r6
	bl SaveGame__UpdateStageRecord
	mov r0, r4
	mov r1, #0x78
	add r0, #0xc8
	strh r1, [r0]
	mov r0, r4
	mov r1, #0x7b
	add r0, #0xca
	strh r1, [r0]
	mov r0, r7
	mov r1, r5
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02157EA8 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #8
	str r0, [sp, #0x18]
	mov r0, r4
	mov r1, r7
	mov r2, r5
	bl AnimatorSprite__Init
	mov r1, r4
	mov r0, #4
	add r1, #0x50
	strh r0, [r1]
	mov r1, #0xc8
	ldrsh r1, [r4, r1]
	lsl r0, r0, #7
	strh r1, [r4, #8]
	mov r1, #0xca
	ldrsh r1, [r4, r1]
	strh r1, [r4, #0xa]
	ldr r1, [r4, #0x3c]
	orr r0, r1
	mov r1, #0
	str r0, [r4, #0x3c]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r5, r4
	mov r0, r7
	mov r1, #0xd
	add r5, #0x64
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02157EA8 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0x10
	str r0, [sp, #0x18]
	mov r0, r5
	mov r1, r7
	mov r2, #0xd
	bl AnimatorSprite__Init
	mov r1, r5
	mov r0, #2
	add r1, #0x50
	strh r0, [r1]
	mov r1, #0xc8
	ldrsh r1, [r4, r1]
	strh r1, [r5, #8]
	mov r1, #0xca
	ldrsh r1, [r4, r1]
	lsl r0, r0, #8
	strh r1, [r5, #0xa]
	ldr r1, [r5, #0x3c]
	orr r0, r1
	mov r1, #0
	str r0, [r5, #0x3c]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x44
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	ldr r0, _02157EAC // =StageClearStageRank__Main
	ldr r1, _02157EB0 // =StageClearStageRank__Destructor
	mov r3, r2
	str r2, [sp, #8]
	bl TaskCreate_
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02157E98: .word 0x00000D98
_02157E9C: .word gameState
_02157EA0: .word 0x00000D88
_02157EA4: .word 0x0217D2B8
_02157EA8: .word 0x05000200
_02157EAC: .word StageClearStageRank__Main
_02157EB0: .word StageClearStageRank__Destructor
	thumb_func_end StageClearStageRank__Create

	thumb_func_start StageClearStageRank__Destroy
StageClearStageRank__Destroy: // 0x02157EB4
	push {r3, r4, r5, lr}
	ldr r4, _02157ECC // =0x00000D98
	mov r5, r0
	add r0, r5, r4
	bl AnimatorSprite__Release
	add r0, r5, r4
	add r0, #0x64
	bl AnimatorSprite__Release
	pop {r3, r4, r5, pc}
	nop
_02157ECC: .word 0x00000D98
	thumb_func_end StageClearStageRank__Destroy

	thumb_func_start StageClearTARank__Create
StageClearTARank__Create: // 0x02157ED0
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x28
	mov r6, r0
	ldr r0, _021580F0 // =0x00000D98
	add r4, r6, r0
	ldr r0, [r6, #0x1c]
	mov r1, r4
	str r0, [sp, #0x24]
	ldr r0, [r6, #0x28]
	add r1, #0xe8
	str r0, [sp, #0x20]
	ldr r0, [r6, #0x2c]
	str r0, [sp, #0x1c]
	ldr r0, _021580F4 // =playerGameStatus
	ldr r7, [r0, #0xc]
	mov r0, #0
	str r0, [r1]
	ldr r1, _021580F8 // =gameState
	ldr r2, [r1, #0x10]
	mov r1, #1
	lsl r1, r1, #0xc
	tst r1, r2
	beq _02157F32
	mov r1, r4
	add r1, #0xe4
	strh r0, [r1]
	mov r5, #1
_02157F06:
	bl StageClear__GetTimeAttackStageID
	ldr r1, [r6, #8]
	mov r2, r0
	lsl r1, r1, #0x18
	ldr r0, _021580FC // =saveGame+0x00000898
	lsr r1, r1, #0x18
	mov r3, r5
	bl SaveGame__GetTimeAttackRecord
	cmp r7, r0
	bne _02157F26
	mov r0, r4
	add r0, #0xe4
	strh r5, [r0]
	b _02157F84
_02157F26:
	add r0, r5, #1
	lsl r0, r0, #0x18
	lsr r5, r0, #0x18
	cmp r5, #5
	bls _02157F06
	b _02157F84
_02157F32:
	bl StageClear__GetTimeAttackStageID
	ldr r1, [r6, #8]
	mov r2, r0
	lsl r1, r1, #0x18
	lsl r3, r7, #0x10
	ldr r0, _021580FC // =saveGame+0x00000898
	lsr r1, r1, #0x18
	lsr r3, r3, #0x10
	bl SaveGame__AddTimeAttackRecord
	mov r1, r4
	add r1, #0xe4
	strh r0, [r1]
	mov r0, r4
	add r0, #0xe4
	ldrh r0, [r0, #0]
	cmp r0, #1
	bne _02157F84
	ldr r5, _021580F4 // =playerGameStatus
	bl StageClear__Func_2158CD8
	mov r1, r0
	cmp r1, #0xe
	beq _02157F84
	ldr r0, _021580FC // =saveGame+0x00000898
	ldr r2, [r5, #0x10]
	ldr r3, [r5, #0x1c]
	bl SaveGame__AddTimeAttackUnknown
	bl StageClear__GetTimeAttackStageID
	bl SaveGame__Block4__GetLastUsedCharacter
	ldr r1, [r6, #8]
	cmp r1, r0
	bne _02157F84
	mov r0, r4
	mov r1, #1
	add r0, #0xe8
	str r1, [r0]
_02157F84:
	mov r0, r4
	mov r1, #0x78
	add r0, #0xc8
	strh r1, [r0]
	mov r0, r4
	mov r1, #0x7b
	add r0, #0xca
	strh r1, [r0]
	mov r0, r4
	add r0, #0xe4
	ldrh r0, [r0, #0]
	cmp r0, #0
	bne _02157FA2
	mov r5, #2
	b _02157FA8
_02157FA2:
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
_02157FA8:
	ldr r0, [sp, #0x20]
	mov r1, r5
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, _02158100 // =0x05000200
	mov r3, #8
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r3, [sp, #0x18]
	ldr r1, [sp, #0x20]
	mov r0, r4
	mov r2, r5
	lsl r3, r3, #6
	bl AnimatorSprite__Init
	mov r0, r4
	mov r1, #4
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0xc8
	ldrsh r0, [r4, r0]
	mov r1, #0
	mov r2, r1
	strh r0, [r4, #8]
	mov r0, #0xca
	ldrsh r0, [r4, r0]
	strh r0, [r4, #0xa]
	mov r0, r4
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	add r0, #0xe4
	ldrh r0, [r0, #0]
	cmp r0, #0
	bne _0215800A
	ldr r1, [r4, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r4, #0x3c]
_0215800A:
	mov r0, r4
	add r0, #0xe4
	ldrh r0, [r0, #0]
	mov r5, r4
	add r5, #0xec
	cmp r0, #0
	beq _0215801E
	cmp r0, #5
	beq _02158022
	b _02158026
_0215801E:
	mov r6, #4
	b _0215802C
_02158022:
	mov r6, #3
	b _0215802C
_02158026:
	sub r0, r0, #1
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
_0215802C:
	ldr r0, [sp, #0x1c]
	mov r1, r6
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, _02158100 // =0x05000200
	mov r3, #1
	str r0, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r0, #7
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x1c]
	mov r0, r5
	mov r2, r6
	lsl r3, r3, #9
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #4
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0xc8
	ldrsh r0, [r4, r0]
	mov r1, #0
	mov r2, r1
	strh r0, [r5, #8]
	mov r0, #0xca
	ldrsh r0, [r4, r0]
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__ProcessAnimation
	mov r5, r4
	ldr r0, [sp, #0x24]
	mov r1, #0xd
	add r5, #0x64
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02158100 // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0x10
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x24]
	mov r0, r5
	mov r2, #0xd
	bl AnimatorSprite__Init
	mov r0, r5
	mov r1, #2
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0xc8
	ldrsh r0, [r4, r0]
	mov r1, #0
	mov r2, r1
	strh r0, [r5, #8]
	mov r0, #0xca
	ldrsh r0, [r4, r0]
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__ProcessAnimation
	bl AllocSndHandle
	mov r1, #0x15
	lsl r1, r1, #4
	str r0, [r4, r1]
	mov r0, #0x44
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	ldr r0, _02158104 // =StageClearStageRank__Main
	ldr r1, _02158108 // =StageClearStageRank__Destructor
	mov r3, r2
	str r2, [sp, #8]
	bl TaskCreate_
	add sp, #0x28
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021580F0: .word 0x00000D98
_021580F4: .word playerGameStatus
_021580F8: .word gameState
_021580FC: .word saveGame+0x00000898
_02158100: .word 0x05000200
_02158104: .word StageClearStageRank__Main
_02158108: .word StageClearStageRank__Destructor
	thumb_func_end StageClearTARank__Create

	thumb_func_start StageClearTARank__Destroy
StageClearTARank__Destroy: // 0x0215810C
	push {r4, lr}
	ldr r1, _02158138 // =0x00000D98
	add r4, r0, r1
	mov r0, #0x15
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0x15
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	bl FreeSndHandle
	mov r0, r4
	bl AnimatorSprite__Release
	add r4, #0x64
	mov r0, r4
	bl AnimatorSprite__Release
	pop {r4, pc}
	.align 2, 0
_02158138: .word 0x00000D98
	thumb_func_end StageClearTARank__Destroy

	thumb_func_start StageClearStageRank__Destructor
StageClearStageRank__Destructor: // 0x0215813C
	push {r3, lr}
	ldr r0, _0215816C // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _02158168
	bl GetTaskWork_
	ldr r1, [r0, #0]
	cmp r1, #0
	beq _02158158
	cmp r1, #1
	beq _02158158
	cmp r1, #2
	b _0215815E
_02158158:
	mov r1, #5
	str r1, [r0, #4]
	b _02158162
_0215815E:
	mov r1, #7
	str r1, [r0, #4]
_02158162:
	ldr r1, _02158170 // =0x00002CB8
	mov r2, #0
	strh r2, [r0, r1]
_02158168:
	pop {r3, pc}
	nop
_0215816C: .word StageClear__Singleton
_02158170: .word 0x00002CB8
	thumb_func_end StageClearStageRank__Destructor

	thumb_func_start StageClear__PlayRankVoiceClip
StageClear__PlayRankVoiceClip: // 0x02158174
	push {r4, lr}
	sub sp, #8
	mov r4, r0
	ldr r0, [r4, #0]
	ldr r2, _021582F4 // =0x00020001
	lsl r1, r0, #0x10
	ldr r0, [r4, #8]
	orr r0, r1
	cmp r0, r2
	bgt _021581B4
	bge _0215827E
	lsl r1, r2, #0x10
	cmp r0, r1
	bgt _021581A2
	bge _021581EE
	cmp r0, #1
	bgt _021581A0
	cmp r0, #0
	blt _021581A0
	beq _021581D6
	cmp r0, #1
	beq _0215824E
_021581A0:
	b _021582C4
_021581A2:
	ldr r1, _021582F8 // =0x00010001
	cmp r0, r1
	bgt _021581AC
	beq _02158266
	b _021582C4
_021581AC:
	lsl r1, r1, #0x11
	cmp r0, r1
	beq _02158206
	b _021582C4
_021581B4:
	ldr r2, _021582FC // =0x00030001
	cmp r0, r2
	bgt _021581C4
	bge _02158296
	sub r1, r2, #1
	cmp r0, r1
	beq _0215821E
	b _021582C4
_021581C4:
	lsl r1, r2, #0x12
	cmp r0, r1
	bgt _021581CE
	beq _02158236
	b _021582C4
_021581CE:
	ldr r1, _02158300 // =0x00040001
	cmp r0, r1
	beq _021582AE
	b _021582C4
_021581D6:
	ldr r0, _02158304 // =0x00002CBC
	ldr r0, [r4, r0]
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _021582C4
_021581EE:
	ldr r0, _02158304 // =0x00002CBC
	ldr r0, [r4, r0]
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _021582C4
_02158206:
	ldr r0, _02158304 // =0x00002CBC
	ldr r0, [r4, r0]
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _021582C4
_0215821E:
	ldr r0, _02158304 // =0x00002CBC
	ldr r0, [r4, r0]
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _021582C4
_02158236:
	ldr r0, _02158304 // =0x00002CBC
	ldr r0, [r4, r0]
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _021582C4
_0215824E:
	ldr r0, _02158304 // =0x00002CBC
	ldr r0, [r4, r0]
	str r0, [sp]
	mov r0, #7
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _021582C4
_02158266:
	ldr r0, _02158304 // =0x00002CBC
	ldr r0, [r4, r0]
	str r0, [sp]
	mov r0, #7
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _021582C4
_0215827E:
	ldr r0, _02158304 // =0x00002CBC
	ldr r0, [r4, r0]
	str r0, [sp]
	mov r0, #7
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _021582C4
_02158296:
	ldr r0, _02158304 // =0x00002CBC
	ldr r0, [r4, r0]
	str r0, [sp]
	mov r0, #7
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _021582C4
_021582AE:
	ldr r0, _02158304 // =0x00002CBC
	ldr r0, [r4, r0]
	str r0, [sp]
	mov r0, #7
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_021582C4:
	ldr r0, _02158308 // =0x00000E7C
	ldrh r0, [r4, r0]
	cmp r0, #1
	bne _021582EE
	ldr r0, [r4, #0]
	cmp r0, #3
	beq _021582DA
	cmp r0, #4
	beq _021582E6
	add sp, #8
	pop {r4, pc}
_021582DA:
	mov r0, #0xe
	mov r1, #1
	bl PlaySysTrack
	add sp, #8
	pop {r4, pc}
_021582E6:
	mov r0, #0xf
	mov r1, #1
	bl PlaySysTrack
_021582EE:
	add sp, #8
	pop {r4, pc}
	nop
_021582F4: .word 0x00020001
_021582F8: .word 0x00010001
_021582FC: .word 0x00030001
_02158300: .word 0x00040001
_02158304: .word 0x00002CBC
_02158308: .word 0x00000E7C
	thumb_func_end StageClear__PlayRankVoiceClip

	thumb_func_start StageClear__PlayRankGetSfx
StageClear__PlayRankGetSfx: // 0x0215830C
	push {r3, lr}
	sub sp, #8
	ldr r1, [r0, #0]
	cmp r1, #4
	bhi _0215835C
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add pc, r1
_02158322: // jump table
	.hword _0215832C - _02158322 - 2 // case 0
	.hword _0215832C - _02158322 - 2 // case 1
	.hword _0215832C - _02158322 - 2 // case 2
	.hword _02158346 - _02158322 - 2 // case 3
	.hword _02158346 - _02158322 - 2 // case 4
_0215832C:
	ldr r1, _02158360 // =0x00002CBC
	ldr r0, [r0, r1]
	str r0, [sp]
	mov r0, #3
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, #8
	pop {r3, pc}
_02158346:
	ldr r1, _02158360 // =0x00002CBC
	ldr r0, [r0, r1]
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_0215835C:
	add sp, #8
	pop {r3, pc}
	.align 2, 0
_02158360: .word 0x00002CBC
	thumb_func_end StageClear__PlayRankGetSfx

	thumb_func_start StageClear__GetRankAnim
StageClear__GetRankAnim: // 0x02158364
	push {r3, lr}
	ldr r0, _021583BC // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _021583C0 // =0x00000D88
	ldr r1, [r0, r1]
	ldr r0, [r0, #0]
	cmp r0, #1
	bne _0215839A
	ldr r0, _021583C4 // =0x0000C350
	cmp r1, r0
	blo _02158382
	mov r0, #0x1c
	pop {r3, pc}
_02158382:
	ldr r0, _021583C8 // =0x00009C40
	cmp r1, r0
	blo _0215838C
	mov r0, #0x1d
	pop {r3, pc}
_0215838C:
	lsr r0, r0, #1
	cmp r1, r0
	blo _02158396
	mov r0, #0x1e
	pop {r3, pc}
_02158396:
	mov r0, #0x1f
	pop {r3, pc}
_0215839A:
	ldr r2, _021583CC // =0x000186A0
	cmp r1, r2
	blo _021583A4
	mov r0, #0x1c
	pop {r3, pc}
_021583A4:
	ldr r0, _021583D0 // =0x00013880
	cmp r1, r0
	blo _021583AE
	mov r0, #0x1d
	pop {r3, pc}
_021583AE:
	lsr r0, r2, #1
	cmp r1, r0
	blo _021583B8
	mov r0, #0x1e
	pop {r3, pc}
_021583B8:
	mov r0, #0x1f
	pop {r3, pc}
	.align 2, 0
_021583BC: .word StageClear__Singleton
_021583C0: .word 0x00000D88
_021583C4: .word 0x0000C350
_021583C8: .word 0x00009C40
_021583CC: .word 0x000186A0
_021583D0: .word 0x00013880
	thumb_func_end StageClear__GetRankAnim

	thumb_func_start StageClearBackground__Init
StageClearBackground__Init: // 0x021583D4
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	ldr r1, _02158540 // =0x0400000A
	ldr r5, _02158544 // =0x0400100C
	str r0, [sp, #0xc]
	ldr r6, [r0, #0x20]
	ldrh r0, [r1, #0]
	mov r7, #0x43
	sub r4, r5, #4
	mov r2, r0
	ldr r0, _02158548 // =0x00002F08
	and r2, r7
	orr r0, r2
	strh r0, [r1]
	ldrh r0, [r5, #0]
	mov r1, #3
	bic r0, r1
	strh r0, [r5]
	ldrh r2, [r4, #0]
	mov r0, #1
	bic r2, r1
	orr r0, r2
	strh r0, [r4]
	sub r2, r5, #2
	ldrh r3, [r2, #0]
	mov r0, #2
	bic r3, r1
	orr r0, r3
	strh r0, [r2]
	ldrh r0, [r5, #2]
	bic r0, r1
	mov r1, #3
	orr r0, r1
	strh r0, [r5, #2]
	ldrh r0, [r4, #0]
	mov r1, r0
	ldr r0, _0215854C // =0x00002E08
	and r1, r7
	orr r0, r1
	strh r0, [r4]
	ldrh r0, [r2, #0]
	mov r1, r0
	ldr r0, _02158548 // =0x00002F08
	and r1, r7
	orr r0, r1
	strh r0, [r2]
	ldr r2, _02158550 // =renderCoreGFXControlB
	mov r0, #0
	strh r0, [r2, #4]
	ldrh r3, [r2, #4]
	ldr r1, _02158554 // =renderCoreGFXControlA
	strh r3, [r2, #2]
	strh r3, [r1, #6]
	strh r3, [r1, #4]
	strh r3, [r2]
	mov r1, #4
	strh r1, [r2, #6]
	ldr r3, [sp, #0xc]
	ldr r2, _02158558 // =0x000004A4
	mov r1, r0
	add r5, r3, r2
	mov r2, #0xbf
_02158450:
	mov r3, r5
	sub r4, r2, r1
	add r3, #0x94
	add r0, r0, #1
	strh r4, [r3]
	add r1, r1, #2
	add r5, r5, #2
	cmp r0, #0xc0
	blo _02158450
	mov r0, #0
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	ldr r1, [sp, #0xc]
	ldr r0, _02158558 // =0x000004A4
	mov r2, #0x21
	add r0, r1, r0
	mov r1, r6
	mov r3, #1
	bl InitBackgroundDS
	ldr r1, [sp, #0xc]
	ldr r0, _02158558 // =0x000004A4
	add r0, r1, r0
	bl DrawBackgroundDS
	ldr r1, [sp, #0xc]
	ldr r0, _02158558 // =0x000004A4
	ldr r2, [r1, r0]
	mov r0, #6
	bic r2, r0
	ldr r0, _02158558 // =0x000004A4
	str r2, [r1, r0]
	mov r0, r1
	ldr r0, [r0, #8]
	cmp r0, #1
	beq _021584B8
	mov r7, #0
	mov r4, r7
	add r5, sp, #0x10
_021584A4:
	mov r0, r6
	bl GetBackgroundPalette
	add r0, r4, r0
	add r7, r7, #1
	add r4, #0x20
	stmia r5!, {r0}
	cmp r7, #2
	blo _021584A4
	b _021584D0
_021584B8:
	mov r5, #0
	add r4, sp, #0x10
_021584BC:
	mov r0, r6
	bl GetBackgroundPalette
	add r1, r5, #2
	lsl r1, r1, #5
	add r0, r1, r0
	add r5, r5, #1
	stmia r4!, {r0}
	cmp r5, #2
	blo _021584BC
_021584D0:
	mov r2, #5
	ldr r0, [sp, #0x10]
	mov r1, #0
	lsl r2, r2, #0x18
	bl QueueCompressedPalette
	mov r6, #0
	ldr r4, _0215855C // =0x05000400
	add r5, sp, #0x10
	mov r7, r6
_021584E4:
	ldr r0, [r5, #0]
	mov r1, r7
	mov r2, r4
	bl QueueCompressedPalette
	add r6, r6, #1
	add r4, #0x20
	add r5, r5, #4
	cmp r6, #2
	blo _021584E4
	mov r0, #6
	ldr r2, _02158560 // =0x06207000
	lsl r0, r0, #8
	add r3, r2, r0
	ldr r4, _02158564 // =0x06207800
	cmp r3, r2
	beq _02158518
	mov r0, #1
	lsl r0, r0, #0xc
_0215850A:
	ldrh r1, [r2, #0]
	add r2, r2, #2
	add r1, r1, r0
	strh r1, [r4]
	add r4, r4, #2
	cmp r2, r3
	bne _0215850A
_02158518:
	ldr r0, _02158568 // =0x06207DC0
	mov r2, #0x40
	mov r1, r0
	add r1, #0x40
	bl MIi_CpuCopy32
	mov r0, #2
	str r0, [sp]
	ldr r2, [sp, #0xc]
	ldr r1, _02158558 // =0x000004A4
	ldr r3, _0215856C // =0x04000016
	add r1, r2, r1
	add r1, #0x94
	mov r0, #0
	mov r2, r1
	bl RenderCore_PrepareDMA
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02158540: .word 0x0400000A
_02158544: .word 0x0400100C
_02158548: .word 0x00002F08
_0215854C: .word 0x00002E08
_02158550: .word renderCoreGFXControlB
_02158554: .word renderCoreGFXControlA
_02158558: .word 0x000004A4
_0215855C: .word 0x05000400
_02158560: .word 0x06207000
_02158564: .word 0x06207800
_02158568: .word 0x06207DC0
_0215856C: .word 0x04000016
	thumb_func_end StageClearBackground__Init

	thumb_func_start StageClearBackground__Destroy
StageClearBackground__Destroy: // 0x02158570
	ldr r3, _02158578 // =RenderCore_StopDMA
	mov r0, #0
	bx r3
	nop
_02158578: .word RenderCore_StopDMA
	thumb_func_end StageClearBackground__Destroy

	thumb_func_start StageClearMaterialReward__Create
StageClearMaterialReward__Create: // 0x0215857C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x3c
	ldr r1, _021587EC // =0x00000EEC
	str r0, [sp, #0x2c]
	add r0, r0, r1
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x2c]
	mov r1, #0x3a
	ldr r7, [r0, #0x3c]
	ldr r0, [r0, #0x40]
	str r0, [sp, #0x34]
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r4, r0
	ldr r0, [sp, #0x34]
	mov r1, #0x3a
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r1, #4
	str r1, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r4, [sp, #8]
	ldr r1, _021587F0 // =0x05000200
	str r3, [sp, #0xc]
	str r1, [sp, #0x10]
	str r3, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r0, _021587F4 // =0x05000600
	str r3, [sp, #0x1c]
	str r0, [sp, #0x20]
	mov r0, #1
	str r0, [sp, #0x24]
	mov r0, #0xc
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x38]
	ldr r1, [sp, #0x34]
	mov r2, #0x3a
	bl AnimatorSpriteDS__Init
	ldr r0, [sp, #0x38]
	mov r1, #5
	add r0, #0x90
	strh r1, [r0]
	ldr r0, [sp, #0x38]
	mov r1, #2
	add r0, #0x92
	strh r1, [r0]
	mov r1, #0
	ldr r0, [sp, #0x38]
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
	mov r1, #0x97
	ldr r0, [sp, #0x38]
	lsl r1, r1, #2
	mov r5, #0
	add r4, r0, r1
_02158600:
	lsl r0, r5, #0x10
	lsr r6, r0, #0x10
	ldr r0, [sp, #0x34]
	mov r1, r6
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r1, #1
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, _021587F4 // =0x05000600
	mov r3, #0xa1
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, r5
	add r0, #0x1a
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x34]
	mov r0, r4
	mov r2, r6
	lsl r3, r3, #4
	bl AnimatorSprite__Init
	mov r0, #2
	mov r1, #0
	str r0, [r4, #0x58]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r5, r5, #1
	add r4, #0x6c
	cmp r5, #3
	blo _02158600
	ldr r4, [sp, #0x38]
	mov r5, #0
	add r4, #0xa4
_0215865E:
	mov r0, r5
	bl StageClear__GetMaterialAnim
	mov r6, r0
	mov r0, r7
	bl Sprite__GetSpriteSize2
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r1, #1
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, _021587F4 // =0x05000600
	mov r1, r7
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #4
	str r0, [sp, #0x18]
	mov r0, r4
	mov r2, r6
	mov r3, #0
	bl AnimatorSprite__Init
	mov r0, r4
	add r1, r5, #4
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0
	strh r0, [r4, #8]
	mov r0, #0x13
	lsl r0, r0, #4
	strh r0, [r4, #0xa]
	ldr r1, [r4, #0x3c]
	mov r0, #1
	orr r0, r1
	mov r1, #0
	str r0, [r4, #0x3c]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r5, r5, #1
	add r4, #0x64
	cmp r5, #2
	blo _0215865E
	ldr r0, [sp, #0x34]
	mov r1, #1
	mov r2, #0xd
	mov r3, #0x15
	bl SpriteUnknown__Func_204C7A4
	str r0, [sp, #0x30]
	mov r1, #0x5b
	ldr r0, [sp, #0x38]
	lsl r1, r1, #2
	mov r7, #0
	add r4, r0, r1
	mov r6, #0x88
_021586E0:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _0215870A
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_021586F6: // jump table
	.hword _02158702 - _021586F6 - 2 // case 0
	.hword _02158702 - _021586F6 - 2 // case 1
	.hword _02158702 - _021586F6 - 2 // case 2
	.hword _02158702 - _021586F6 - 2 // case 3
	.hword _02158702 - _021586F6 - 2 // case 4
	.hword _02158702 - _021586F6 - 2 // case 5
_02158702:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _0215870C
_0215870A:
	mov r0, #1
_0215870C:
	cmp r0, #5
	bhi _02158740
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215871C: // jump table
	.hword _02158728 - _0215871C - 2 // case 0
	.hword _0215872C - _0215871C - 2 // case 1
	.hword _02158730 - _0215871C - 2 // case 2
	.hword _02158734 - _0215871C - 2 // case 3
	.hword _02158738 - _0215871C - 2 // case 4
	.hword _0215873C - _0215871C - 2 // case 5
_02158728:
	mov r5, #4
	b _02158742
_0215872C:
	mov r5, #0xd
	b _02158742
_02158730:
	mov r5, #0x16
	b _02158742
_02158734:
	mov r5, #0x1f
	b _02158742
_02158738:
	mov r5, #0x28
	b _02158742
_0215873C:
	mov r5, #0x31
	b _02158742
_02158740:
	mov r5, #0xd
_02158742:
	mov r0, r7
	bl StageClear__GetMaterialAnim
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	add r0, r5, r0
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	ldr r1, [sp, #0x30]
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r1, #1
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, _021587F4 // =0x05000600
	mov r2, r5
	str r0, [sp, #0x10]
	mov r0, r1
	str r0, [sp, #0x14]
	mov r0, #4
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x34]
	mov r0, r4
	mov r3, #0
	bl AnimatorSprite__Init
	mov r1, r4
	add r1, #0x50
	mov r0, #6
	strh r0, [r1]
	ldr r1, [r4, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r4, #0x3c]
	mov r0, #0
	strh r0, [r4, #8]
	mov r1, #0
	mov r0, r4
	mov r2, r1
	strh r6, [r4, #0xa]
	bl AnimatorSprite__ProcessAnimation
	add r7, r7, #1
	add r4, #0x64
	add r6, #0x18
	cmp r7, #2
	blo _021586E0
	mov r1, #0x3f
	ldr r0, [sp, #0x38]
	lsl r1, r1, #4
	add r0, r0, r1
	ldr r1, [sp, #0x2c]
	ldr r1, [r1, #0x44]
	bl StageClear__Func_2158FAC
	mov r1, #0x3f
	ldr r0, [sp, #0x38]
	lsl r1, r1, #4
	add r0, r0, r1
	bl StageClear__Func_215908C
	mov r1, #0
	mov r0, #0x45
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _021587F8 // =StageClearMaterialRewardFX__Create
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	ldr r0, _021587FC // =renderCoreGFXControlB
	mov r1, #4
	str r1, [r0, #0x1c]
	mov r1, #0x13
	strb r1, [r0, #0x1a]
	mov r1, #0x12
	strb r1, [r0, #0x1b]
	add sp, #0x3c
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_021587EC: .word 0x00000EEC
_021587F0: .word 0x05000200
_021587F4: .word 0x05000600
_021587F8: .word StageClearMaterialRewardFX__Create
_021587FC: .word renderCoreGFXControlB
	thumb_func_end StageClearMaterialReward__Create

	thumb_func_start StageClearMaterialReward__Destroy
StageClearMaterialReward__Destroy: // 0x02158800
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	ldr r1, _021588CC // =0x00000EEC
	mov r2, #8
	add r7, r0, r1
	mov r0, #0
	add r1, sp, #0
	bl MIi_CpuClear32
	mov r0, #0xe9
	lsl r0, r0, #2
	ldrh r1, [r7, r0]
	mov r4, #0
	cmp r1, #0
	bls _0215883E
	mov r5, r4
	add r6, sp, #0
_02158822:
	mov r0, r5
	bl _u32_div_f
	lsl r1, r0, #2
	ldr r0, [r6, r1]
	add r4, r4, #1
	add r0, r0, #1
	str r0, [r6, r1]
	mov r0, #0xe9
	lsl r0, r0, #2
	ldrh r1, [r7, r0]
	add r5, r5, #2
	cmp r4, r1
	blo _02158822
_0215883E:
	mov r6, #0
	add r4, sp, #0
	mov r5, r7
_02158844:
	mov r0, r5
	add r0, #0xb0
	ldr r1, [r4, #0]
	ldrh r0, [r0, #0]
	lsl r1, r1, #0x18
	lsr r1, r1, #0x18
	bl StageClear__GiveMaterial
	add r6, r6, #1
	add r4, r4, #4
	add r5, #0x64
	cmp r6, #2
	blo _02158844
	mov r0, r7
	bl AnimatorSpriteDS__Release
	mov r0, #0x97
	lsl r0, r0, #2
	add r5, r7, r0
	mov r0, #0x3a
	lsl r0, r0, #4
	add r4, r7, r0
	cmp r5, r4
	beq _02158880
_02158874:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x6c
	cmp r5, r4
	bne _02158874
_02158880:
	mov r0, #0x5b
	mov r5, r7
	lsl r0, r0, #2
	add r5, #0xa4
	add r4, r7, r0
	cmp r5, r4
	beq _0215889A
_0215888E:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _0215888E
_0215889A:
	mov r0, #0x5b
	lsl r0, r0, #2
	add r5, r7, r0
	add r0, #0xc8
	add r4, r7, r0
	cmp r5, r4
	beq _021588B4
_021588A8:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _021588A8
_021588B4:
	mov r0, #0x3f
	lsl r0, r0, #4
	add r0, r7, r0
	bl StageClear__Func_2159068
	ldr r0, _021588D0 // =renderCoreGFXControlB
	mov r1, #0
	str r1, [r0, #0x1c]
	strb r1, [r0, #0x1a]
	strb r1, [r0, #0x1b]
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021588CC: .word 0x00000EEC
_021588D0: .word renderCoreGFXControlB
	thumb_func_end StageClearMaterialReward__Destroy

	thumb_func_start StageClear__MaterialRewardFX__Func_21588D4
StageClear__MaterialRewardFX__Func_21588D4: // 0x021588D4
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	mov r5, r0
	ldr r0, _02158958 // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215895C // =0x00000EEC
	add r4, r0, r1
	mov r1, #1
	mov r0, #3
	lsl r1, r1, #0xa
	bl CreateDrawFadeTask
	ldr r1, [r4, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r4, #0x3c]
	mov r0, #0x3f
	lsl r0, r0, #4
	add r0, r4, r0
	bl StageClear__Func_21590C0
	ldr r0, _02158960 // =0x00002CBC
	ldr r0, [r5, r0]
	str r0, [sp]
	mov r0, #4
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	bl Task__OVL03Unknown215896C__Create
	mov r7, #0x92
	lsl r7, r7, #2
	mov r2, r7
	mov r5, r7
	mov r0, #0
	mov r1, r4
	sub r2, #0x14
	add r3, r7, #2
	sub r5, #0x12
_02158930:
	ldrsh r6, [r1, r7]
	add r0, r0, #1
	strh r6, [r1, r2]
	ldrsh r6, [r1, r3]
	strh r6, [r1, r5]
	add r1, r1, #4
	cmp r0, #5
	blo _02158930
	mov r0, r4
	bl StageClear__Func_2158A48
	ldr r0, _02158964 // =0x0000126C
	mov r1, #0
	strh r1, [r4, r0]
	ldr r0, _02158968 // =StageClear__MaterialRewardFX__Main_215A1C8
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02158958: .word StageClear__Singleton
_0215895C: .word 0x00000EEC
_02158960: .word 0x00002CBC
_02158964: .word 0x0000126C
_02158968: .word StageClear__MaterialRewardFX__Main_215A1C8
	thumb_func_end StageClear__MaterialRewardFX__Func_21588D4

	thumb_func_start Task__OVL03Unknown215896C__Create
Task__OVL03Unknown215896C__Create: // 0x0215896C
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x10
	str r0, [sp, #0xc]
	bl StageClear__MaterialRewardFX__Func_2158A8C
	mov r2, #0xe9
	mov r7, #0
	ldr r1, [sp, #0xc]
	lsl r2, r2, #2
	strh r0, [r1, r2]
	ldr r0, [sp, #0xc]
	add r1, r2, #6
	add r4, r0, r1
	mov r6, r0
	mov r5, r7
_0215898A:
	mov r0, #0x92
	lsl r0, r0, #2
	ldrsh r0, [r6, r0]
	mov r1, #5
	strh r0, [r4]
	ldr r0, _02158A3C // =0x0000024A
	ldrsh r0, [r6, r0]
	strh r0, [r4, #2]
	mov r0, #0
	strh r0, [r4, #4]
	mov r0, #4
	sub r0, r0, r7
	lsl r0, r0, #0xf
	bl _u32_div_f
	strh r0, [r4, #6]
	mov r0, #1
	strh r5, [r4, #8]
	lsl r0, r0, #8
	strh r0, [r4, #0xa]
	strb r5, [r4, #0xc]
	mov r0, #0x10
	strb r0, [r4, #0xd]
	add r7, r7, #1
	add r4, #0xe
	add r6, r6, #4
	cmp r7, #5
	blo _0215898A
	ldr r1, [sp, #0xc]
	ldr r0, _02158A40 // =0x000003A6
_021589C6:
	strh r5, [r1, r0]
	add r5, r5, #1
	add r1, r1, #2
	cmp r5, #2
	blo _021589C6
	ldr r2, [sp, #0xc]
	mov r3, #0
	add r2, #0xa4
	mov r0, #1
_021589D8:
	ldr r1, [r2, #0x3c]
	add r3, r3, #1
	bic r1, r0
	str r1, [r2, #0x3c]
	add r2, #0x64
	cmp r3, #2
	blo _021589D8
	mov r1, #0x5b
	ldr r0, [sp, #0xc]
	lsl r1, r1, #2
	add r2, r0, r1
	mov r3, #0
	mov r0, #1
_021589F2:
	ldr r1, [r2, #0x3c]
	add r3, r3, #1
	bic r1, r0
	str r1, [r2, #0x3c]
	add r2, #0x64
	cmp r3, #2
	blo _021589F2
	mov r2, #0x5e
	lsl r2, r2, #2
	ldr r0, [sp, #0xc]
	mov r1, r2
	add r1, #0x64
	ldrh r3, [r0, r2]
	ldrh r0, [r0, r1]
	cmp r3, r0
	bne _02158A24
	mov r1, r2
	ldr r0, [sp, #0xc]
	add r1, #0x30
	ldr r1, [r0, r1]
	mov r0, #1
	orr r1, r0
	ldr r0, [sp, #0xc]
	add r2, #0x30
	str r1, [r0, r2]
_02158A24:
	mov r0, #0x50
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02158A44 // =Task__OVL03Unknown215896C__Main
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	add sp, #0x10
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02158A3C: .word 0x0000024A
_02158A40: .word 0x000003A6
_02158A44: .word Task__OVL03Unknown215896C__Main
	thumb_func_end Task__OVL03Unknown215896C__Create

	thumb_func_start StageClear__Func_2158A48
StageClear__Func_2158A48: // 0x02158A48
	push {r4, r5}
	mov r1, #0x97
	lsl r1, r1, #2
	mov r3, #0
	add r4, r0, r1
	mov r1, #2
	mov r5, r3
	mov r2, #0x8f
	lsl r1, r1, #0xa
_02158A5A:
	str r5, [r4, #0x64]
	str r2, [r4, #0x68]
	add r3, r3, #1
	add r4, #0x6c
	sub r5, r5, r1
	cmp r3, #3
	blo _02158A5A
	mov r1, #0x3a
	mov r2, #1
	lsl r1, r1, #4
	str r2, [r0, r1]
	pop {r4, r5}
	bx lr
	thumb_func_end StageClear__Func_2158A48

	thumb_func_start StageClear__GetMaterialAnim
StageClear__GetMaterialAnim: // 0x02158A74
	ldr r1, _02158A84 // =gameState
	ldrh r2, [r1, #0x28]
	lsl r1, r2, #1
	add r2, r2, r1
	ldr r1, _02158A88 // =0x0217D315
	add r1, r1, r2
	ldrb r0, [r0, r1]
	bx lr
	.align 2, 0
_02158A84: .word gameState
_02158A88: .word 0x0217D315
	thumb_func_end StageClear__GetMaterialAnim

	thumb_func_start StageClear__MaterialRewardFX__Func_2158A8C
StageClear__MaterialRewardFX__Func_2158A8C: // 0x02158A8C
	push {r3, lr}
	ldr r0, _02158AE0 // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, _02158AE4 // =gameState
	ldrh r1, [r0, #0x28]
	lsl r0, r1, #1
	add r1, r1, r0
	ldr r0, _02158AE8 // =0x0217D314
	ldrb r0, [r0, r1]
	cmp r0, #0
	beq _02158AAC
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	pop {r3, pc}
_02158AAC:
	bl StageClear__GetRankAnim
	sub r0, #0x1c
	cmp r0, #3
	bhi _02158ADA
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02158AC2: // jump table
	.hword _02158ACA - _02158AC2 - 2 // case 0
	.hword _02158ACE - _02158AC2 - 2 // case 1
	.hword _02158AD2 - _02158AC2 - 2 // case 2
	.hword _02158AD6 - _02158AC2 - 2 // case 3
_02158ACA:
	mov r0, #4
	pop {r3, pc}
_02158ACE:
	mov r0, #3
	pop {r3, pc}
_02158AD2:
	mov r0, #2
	pop {r3, pc}
_02158AD6:
	mov r0, #1
	pop {r3, pc}
_02158ADA:
	mov r0, #1
	pop {r3, pc}
	nop
_02158AE0: .word StageClear__Singleton
_02158AE4: .word gameState
_02158AE8: .word 0x0217D314
	thumb_func_end StageClear__MaterialRewardFX__Func_2158A8C

	thumb_func_start StageClear__GiveMaterial
StageClear__GiveMaterial: // 0x02158AEC
	mov r2, r1
	cmp r0, #8
	bhi _02158B34
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02158AFE: // jump table
	.hword _02158B10 - _02158AFE - 2 // case 0
	.hword _02158B14 - _02158AFE - 2 // case 1
	.hword _02158B18 - _02158AFE - 2 // case 2
	.hword _02158B1C - _02158AFE - 2 // case 3
	.hword _02158B20 - _02158AFE - 2 // case 4
	.hword _02158B24 - _02158AFE - 2 // case 5
	.hword _02158B28 - _02158AFE - 2 // case 6
	.hword _02158B2C - _02158AFE - 2 // case 7
	.hword _02158B30 - _02158AFE - 2 // case 8
_02158B10:
	mov r1, #0
	b _02158B36
_02158B14:
	mov r1, #1
	b _02158B36
_02158B18:
	mov r1, #2
	b _02158B36
_02158B1C:
	mov r1, #3
	b _02158B36
_02158B20:
	mov r1, #4
	b _02158B36
_02158B24:
	mov r1, #5
	b _02158B36
_02158B28:
	mov r1, #6
	b _02158B36
_02158B2C:
	mov r1, #7
	b _02158B36
_02158B30:
	mov r1, #8
	b _02158B36
_02158B34:
	mov r1, #0
_02158B36:
	ldr r3, _02158B3C // =SaveGame__GiveMaterial
	ldr r0, _02158B40 // =saveGame+0x00000028
	bx r3
	.align 2, 0
_02158B3C: .word SaveGame__GiveMaterial
_02158B40: .word saveGame+0x00000028
	thumb_func_end StageClear__GiveMaterial

	thumb_func_start StageClearTimeAttackRankList__Create
StageClearTimeAttackRankList__Create: // 0x02158B44
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x10
	ldr r1, _02158BE4 // =0x0000215C
	ldr r6, [r0, #8]
	add r4, r0, r1
	str r4, [sp, #0xc]
	mov r1, #0x65
	ldr r0, [sp, #0xc]
	mov r2, #0
	lsl r1, r1, #4
	strh r2, [r0, r1]
	add r0, r0, #4
	add r4, #0x90
	bl FontFile__Init
	ldr r0, [sp, #0xc]
	ldr r1, _02158BE8 // =aFntFontIplFnt_0
	add r0, r0, #4
	mov r2, #0
	bl FontFile__InitFromPath
	mov r0, r4
	bl TimeAttackRankList__Init
	lsl r0, r6, #0x18
	mov r5, #0
	lsr r7, r0, #0x18
_02158B7A:
	bl StageClear__GetTimeAttackStageID
	add r3, r5, #1
	mov r2, r0
	lsl r3, r3, #0x18
	ldr r0, _02158BEC // =saveGame+0x00000898
	mov r1, r7
	lsr r3, r3, #0x18
	bl SaveGame__GetTimeAttackRecord
	lsl r1, r5, #0x10
	mov r2, r0
	mov r0, r4
	lsr r1, r1, #0x10
	mov r3, r6
	bl TimeAttackRankList__SetRecord
	add r5, r5, #1
	cmp r5, #5
	blo _02158B7A
	mov r0, #0x59
	mov r1, #0x40
	lsl r0, r0, #4
	strh r1, [r4, r0]
	mov r1, #0xa0
	add r0, r0, #4
	strh r1, [r4, r0]
	mov r0, #8
	str r0, [sp]
	ldr r0, [sp, #0xc]
	mov r1, #0
	add r0, r0, #4
	str r0, [sp, #4]
	mov r0, r4
	mov r2, #1
	mov r3, r1
	bl TimeAttackRankList__Create
	mov r1, #0
	mov r0, #0x48
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02158BF0 // =StageClearTimeAttackRankList__Main
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	ldr r1, [sp, #0xc]
	str r0, [r1]
	add sp, #0x10
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02158BE4: .word 0x0000215C
_02158BE8: .word aFntFontIplFnt_0
_02158BEC: .word saveGame+0x00000898
_02158BF0: .word StageClearTimeAttackRankList__Main
	thumb_func_end StageClearTimeAttackRankList__Create

	thumb_func_start StageClearTimeAttackRankList__Destroy
StageClearTimeAttackRankList__Destroy: // 0x02158BF4
	push {r4, lr}
	ldr r1, _02158C0C // =0x0000215C
	add r4, r0, r1
	mov r0, r4
	add r0, #0x90
	bl TimeAttackRankList__Destroy
	add r0, r4, #4
	bl FontFile__Release
	pop {r4, pc}
	nop
_02158C0C: .word 0x0000215C
	thumb_func_end StageClearTimeAttackRankList__Destroy

	thumb_func_start Task__Unknown2158C6C__LoadAssets
Task__Unknown2158C6C__LoadAssets: // 0x02158C10
	push {r4, lr}
	ldr r1, _02158C38 // =0x000027B0
	add r4, r0, r1
	mov r0, #0xe1
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindow__Init
	mov r0, #0xe1
	lsl r0, r0, #2
	mov r2, #1
	ldr r1, _02158C3C // =aFntFontAllFnt_2_ovl03
	add r0, r4, r0
	mov r3, r2
	bl FontWindow__LoadFromFile
	add r0, r4, #4
	bl SaveSpriteButton__Func_206515C
	pop {r4, pc}
	.align 2, 0
_02158C38: .word 0x000027B0
_02158C3C: .word aFntFontAllFnt_2_ovl03
	thumb_func_end Task__Unknown2158C6C__LoadAssets

	thumb_func_start Task__Unknown2158C6C__ReleaseAssets
Task__Unknown2158C6C__ReleaseAssets: // 0x02158C40
	push {r4, lr}
	ldr r1, _02158C68 // =0x000027B0
	add r4, r0, r1
	ldr r0, [r4, #0]
	cmp r0, #0
	beq _02158C56
	bl GetTaskWork_
	mov r1, #0
	str r1, [r0, #4]
	str r1, [r4]
_02158C56:
	add r0, r4, #4
	bl SaveSpriteButton__Func_20651A4
	mov r0, #0xe1
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontWindow__Release
	pop {r4, pc}
	.align 2, 0
_02158C68: .word 0x000027B0
	thumb_func_end Task__Unknown2158C6C__ReleaseAssets

	thumb_func_start Task__OVL03Unknown2158C6C__Create
Task__OVL03Unknown2158C6C__Create: // 0x02158C6C
	push {r4, r5, lr}
	sub sp, #0xc
	mov r5, r0
	ldr r0, _02158CB4 // =0x000027B0
	mov r1, #0
	add r4, r5, r0
	mov r0, #0x44
	str r0, [sp]
	str r1, [sp, #4]
	mov r0, #0x10
	str r0, [sp, #8]
	ldr r0, _02158CB8 // =Task__OVL03Unknown2158C6C__Main
	mov r2, r1
	mov r3, r1
	bl TaskCreate_
	ldr r1, _02158CB4 // =0x000027B0
	str r0, [r5, r1]
	ldr r0, [r5, r1]
	bl GetTaskWork_
	mov r1, #0x1e
	str r1, [r0]
	add r1, r4, #4
	str r1, [r0, #4]
	mov r1, #0xe1
	lsl r1, r1, #2
	add r1, r4, r1
	str r1, [r0, #8]
	mov r1, #0x3a
	lsl r1, r1, #6
	ldr r1, [r5, r1]
	str r1, [r0, #0xc]
	add sp, #0xc
	pop {r4, r5, pc}
	nop
_02158CB4: .word 0x000027B0
_02158CB8: .word Task__OVL03Unknown2158C6C__Main
	thumb_func_end Task__OVL03Unknown2158C6C__Create

	thumb_func_start StageClear__GetTimeAttackStageID
StageClear__GetTimeAttackStageID: // 0x02158CBC
	ldr r0, _02158CD0 // =gameState
	ldrh r0, [r0, #0x28]
	lsl r1, r0, #1
	ldr r0, _02158CD4 // =0x0217D2B8
	ldrh r0, [r0, r1]
	asr r0, r0, #8
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	bx lr
	nop
_02158CD0: .word gameState
_02158CD4: .word 0x0217D2B8
	thumb_func_end StageClear__GetTimeAttackStageID

	thumb_func_start StageClear__Func_2158CD8
StageClear__Func_2158CD8: // 0x02158CD8
	ldr r0, _02158CE0 // =gameState
	ldr r3, _02158CE4 // =MenuHelpers__Func_217CEBC
	ldrh r0, [r0, #0x28]
	bx r3
	.align 2, 0
_02158CE0: .word gameState
_02158CE4: .word MenuHelpers__Func_217CEBC
	thumb_func_end StageClear__Func_2158CD8

	thumb_func_start StageClear__Func_2158CE8
StageClear__Func_2158CE8: // 0x02158CE8
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
	bls _02158D4E
_02158D10:
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
	bne _02158D48
	cmp r4, #0
	beq _02158D4E
_02158D48:
	add r6, r6, #1
	cmp r6, r7
	blo _02158D10
_02158D4E:
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
	thumb_func_end StageClear__Func_2158CE8

	thumb_func_start StageClear__Func_2158D54
StageClear__Func_2158D54: // 0x02158D54
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	ldr r6, [sp, #0x30]
	str r0, [sp]
	mov r0, #7
	mov r4, r2
	mul r0, r6
	add r0, r4, r0
	lsl r0, r0, #0x10
	add r2, sp, #0x10
	str r1, [sp, #4]
	mov r7, r3
	ldr r5, [sp, #0x34]
	asr r4, r0, #0x10
	mov r0, r5
	add r1, sp, #0x14
	add r2, #2
	add r3, sp, #0x10
	bl AkUtilFrameToTime
	add r0, sp, #0x10
	ldrh r5, [r0, #0]
	mov r0, #0
	str r0, [sp, #0xc]
_02158D84:
	mov r0, r5
	mov r1, #0xa
	bl _u32_div_f
	mov r2, r1
	mov r0, #0x64
	mul r2, r0
	ldr r0, [sp]
	sub r1, r4, r6
	lsl r1, r1, #0x10
	add r0, r0, r2
	asr r4, r1, #0x10
	strh r4, [r0, #8]
	strh r7, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, r5
	mov r1, #0xa
	bl _u32_div_f
	mov r5, r0
	ldr r0, [sp, #0xc]
	add r0, r0, #1
	str r0, [sp, #0xc]
	cmp r0, #2
	blo _02158D84
	ldr r0, [sp, #4]
	sub r1, r4, r6
	lsl r1, r1, #0x10
	add r0, #0x64
	asr r4, r1, #0x10
	strh r4, [r0, #8]
	strh r7, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	add r0, sp, #0x10
	ldrh r5, [r0, #2]
	mov r0, #0
	str r0, [sp, #8]
_02158DD2:
	mov r0, r5
	mov r1, #0xa
	bl _u32_div_f
	mov r2, r1
	mov r0, #0x64
	mul r2, r0
	ldr r0, [sp]
	sub r1, r4, r6
	lsl r1, r1, #0x10
	add r0, r0, r2
	asr r4, r1, #0x10
	strh r4, [r0, #8]
	strh r7, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, r5
	mov r1, #0xa
	bl _u32_div_f
	mov r5, r0
	ldr r0, [sp, #8]
	add r0, r0, #1
	str r0, [sp, #8]
	cmp r0, #2
	blo _02158DD2
	sub r0, r4, r6
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	ldr r0, [sp, #4]
	strh r4, [r0, #8]
	strh r7, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	add r0, sp, #0x10
	ldrh r0, [r0, #4]
	mov r1, #0xa
	bl _u32_div_f
	mov r2, r1
	mov r0, #0x64
	mul r2, r0
	ldr r0, [sp]
	sub r1, r4, r6
	add r0, r0, r2
	strh r1, [r0, #8]
	strh r7, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	thumb_func_end StageClear__Func_2158D54

	thumb_func_start StageClearMover__Create
StageClearMover__Create: // 0x02158E38
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r5, r0
	mov r7, r2
	str r3, [sp, #0xc]
	mov r0, #0x61
	str r0, [sp]
	mov r2, #0
	mov r6, r1
	str r2, [sp, #4]
	mov r0, #0x1c
	str r0, [sp, #8]
	ldr r0, _02158E94 // =StageClearMover__Main
	ldr r1, _02158E98 // =StageClearMover__Destructor
	mov r3, r2
	bl TaskCreate_
	str r0, [sp, #0x10]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x1c
	bl MIi_CpuClear16
	str r5, [r4]
	strh r6, [r4, #4]
	strh r7, [r4, #6]
	ldr r0, [sp, #0xc]
	add r1, sp, #0x18
	strh r0, [r4, #8]
	ldrh r0, [r1, #0x10]
	strh r0, [r4, #0xa]
	mov r0, #0x14
	ldrsh r0, [r1, r0]
	strh r0, [r4, #0xe]
	ldrh r0, [r1, #0x18]
	strh r0, [r4, #0x10]
	ldr r0, [sp, #0x34]
	str r0, [r4, #0x14]
	ldr r0, [sp, #0x38]
	str r0, [r4, #0x18]
	ldr r0, [sp, #0x10]
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02158E94: .word StageClearMover__Main
_02158E98: .word StageClearMover__Destructor
	thumb_func_end StageClearMover__Create

	thumb_func_start StageClearMover__Destructor
StageClearMover__Destructor: // 0x02158E9C
	push {r3, lr}
	bl GetTaskWork_
	ldr r1, [r0, #0]
	cmp r1, #0
	beq _02158EC2
	mov r2, #4
	ldrsh r2, [r0, r2]
	cmp r2, #2
	bne _02158EB8
	mov r2, #8
	ldrsh r2, [r0, r2]
	strh r2, [r1]
	b _02158EC2
_02158EB8:
	cmp r2, #4
	bne _02158EC2
	mov r2, #8
	ldrsh r2, [r0, r2]
	str r2, [r1]
_02158EC2:
	ldr r2, [r0, #0x14]
	cmp r2, #0
	beq _02158ECC
	ldr r1, [r0, #0x18]
	blx r2
_02158ECC:
	pop {r3, pc}
	.align 2, 0
	thumb_func_end StageClearMover__Destructor

	thumb_func_start StageClearHeader__MoverCallback
StageClearHeader__MoverCallback: // 0x02158ED0
	cmp r1, #0
	beq _02158ED8
	mov r0, #0
	str r0, [r1]
_02158ED8:
	bx lr
	.align 2, 0
	thumb_func_end StageClearHeader__MoverCallback

	thumb_func_start StageClearStageScoreTally__MoverCallback_Bonus
StageClearStageScoreTally__MoverCallback_Bonus: // 0x02158EDC
	push {r4, lr}
	sub sp, #8
	ldr r0, _02158F0C // =StageClear__Singleton
	mov r4, r1
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _02158F10 // =0x00002CBC
	ldr r0, [r0, r1]
	str r0, [sp]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
	cmp r4, #0
	beq _02158F06
	mov r0, #0
	str r0, [r4]
_02158F06:
	add sp, #8
	pop {r4, pc}
	nop
_02158F0C: .word StageClear__Singleton
_02158F10: .word 0x00002CBC
	thumb_func_end StageClearStageScoreTally__MoverCallback_Bonus

	thumb_func_start StageClear__Func_2158F14
StageClear__Func_2158F14: // 0x02158F14
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x10
	mov r6, r0
	mov r7, r1
	add r1, r6, r7
	lsr r0, r1, #0x1f
	add r0, r1, r0
	asr r4, r0, #1
	mov r0, #2
	lsl r0, r0, #0xa
	mov r5, r3
	cmp r2, r0
	bge _02158F64
	lsl r0, r2, #0x11
	asr r0, r0, #0x10
	str r0, [sp]
	asr r0, r0, #0x1f
	str r0, [sp, #4]
_02158F38:
	sub r0, r4, r6
	ldr r2, [sp]
	ldr r3, [sp, #4]
	asr r1, r0, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _02158FA8 // =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	mov r0, r5
	add r4, r6, r1
	sub r5, r5, #1
	cmp r0, #0
	bne _02158F38
	add sp, #0x10
	mov r0, r4
	pop {r3, r4, r5, r6, r7, pc}
_02158F64:
	ble _02158FA2
	lsl r1, r2, #1
	lsl r0, r0, #1
	sub r0, r1, r0
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	str r0, [sp, #8]
	asr r0, r0, #0x1f
	str r0, [sp, #0xc]
_02158F76:
	sub r0, r7, r4
	ldr r2, [sp, #8]
	ldr r3, [sp, #0xc]
	asr r1, r0, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _02158FA8 // =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	mov r0, r5
	add r4, r4, r1
	sub r5, r5, #1
	cmp r0, #0
	bne _02158F76
	add sp, #0x10
	mov r0, r4
	pop {r3, r4, r5, r6, r7, pc}
_02158FA2:
	mov r0, r4
	add sp, #0x10
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02158FA8: .word 0x00000000
	thumb_func_end StageClear__Func_2158F14

	thumb_func_start StageClear__Func_2158FAC
StageClear__Func_2158FAC: // 0x02158FAC
	push {r4, r5, r6, r7, lr}
	sub sp, #0x34
	str r0, [sp, #0x2c]
	mov r5, r1
	mov r6, #0
	mov r4, r0
_02158FB8:
	mov r0, r6
	mov r1, #0xa
	bl _u32_div_f
	lsl r0, r1, #0x10
	lsr r7, r0, #0x10
	mov r0, r5
	mov r1, r7
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	str r0, [sp, #0x30]
	mov r0, r5
	mov r1, r7
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r1, #2
	lsl r1, r1, #0xa
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	ldr r1, [sp, #0x30]
	mov r2, r7
	str r1, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	ldr r1, _0215905C // =0x05000200
	mov r3, #0
	str r1, [sp, #0x10]
	mov r1, #0
	str r1, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r1
	str r0, [sp, #0x1c]
	ldr r0, _02159060 // =0x05000600
	mov r1, r5
	str r0, [sp, #0x20]
	mov r0, #1
	str r0, [sp, #0x24]
	mov r0, #0xc
	str r0, [sp, #0x28]
	mov r0, r4
	bl AnimatorSpriteDS__Init
	mov r1, r4
	add r1, #0x90
	mov r0, #6
	strh r0, [r1]
	mov r1, r4
	add r1, #0x92
	mov r0, #3
	strh r0, [r1]
	ldr r0, _02159064 // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0]
	cmp r0, #2
	bne _02159044
	ldr r1, [r4, #0x64]
	mov r0, #1
	orr r0, r1
	str r0, [r4, #0x64]
_02159044:
	add r6, r6, #1
	add r4, #0xb8
	cmp r6, #0x14
	blo _02158FB8
	mov r1, #0xe6
	ldr r0, [sp, #0x2c]
	mov r2, #0
	lsl r1, r1, #4
	str r2, [r0, r1]
	add sp, #0x34
	pop {r4, r5, r6, r7, pc}
	nop
_0215905C: .word 0x05000200
_02159060: .word 0x05000600
_02159064: .word StageClear__Singleton
	thumb_func_end StageClear__Func_2158FAC

	thumb_func_start StageClear__Func_2159068
StageClear__Func_2159068: // 0x02159068
	push {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #0xe6
	mov r5, r6
	lsl r0, r0, #4
	beq _02159082
	add r4, r6, r0
_02159076:
	mov r0, r5
	bl AnimatorSpriteDS__Release
	add r5, #0xb8
	cmp r5, r4
	bne _02159076
_02159082:
	mov r0, #0xe6
	mov r1, #0
	lsl r0, r0, #4
	str r1, [r6, r0]
	pop {r4, r5, r6, pc}
	thumb_func_end StageClear__Func_2159068

	thumb_func_start StageClear__Func_215908C
StageClear__Func_215908C: // 0x0215908C
	push {r3, r4}
	mov r2, #0
	mov r4, r0
	mov r3, r2
_02159094:
	mov r1, r4
	add r2, r2, #1
	add r1, #0xb4
	strb r2, [r1]
	mov r1, r4
	add r1, #0xb5
	add r4, #0xb8
	strb r3, [r1]
	cmp r2, #0x14
	blo _02159094
	ldr r2, _021590BC // =0x00000E74
	str r3, [r0, r2]
	add r1, r2, #4
	str r3, [r0, r1]
	mov r1, #1
	sub r2, #0x14
	str r1, [r0, r2]
	pop {r3, r4}
	bx lr
	nop
_021590BC: .word 0x00000E74
	thumb_func_end StageClear__Func_215908C

	thumb_func_start StageClear__Func_21590C0
StageClear__Func_21590C0: // 0x021590C0
	mov r1, #0xe6
	mov r2, #0
	lsl r1, r1, #4
	str r2, [r0, r1]
	bx lr
	.align 2, 0
	thumb_func_end StageClear__Func_21590C0

	thumb_func_start StageClear__Func_21590CC
StageClear__Func_21590CC: // 0x021590CC
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	mov r5, r0
	mov r0, #0xe6
	mov r4, r5
	lsl r0, r0, #4
	bne _021590DC
	b _0215925E
_021590DC:
	add r0, r5, r0
	str r0, [sp, #4]
_021590E0:
	mov r0, #1
	ldr r1, [r4, #0x3c]
	lsl r0, r0, #0x1e
	tst r0, r1
	beq _02159124
	mov r0, r4
	add r0, #0xb5
	ldrb r0, [r0, #0]
	cmp r0, #0
	bne _0215910E
	ldrh r1, [r4, #0xc]
	mov r0, r4
	bl AnimatorSpriteDS__SetAnimation
	mov r1, r4
	add r1, #0xb4
	mov r0, #1
	strb r0, [r1]
	mov r1, r4
	add r1, #0xb5
	mov r0, #0
	strb r0, [r1]
	b _02159124
_0215910E:
	ldrh r1, [r4, #0xc]
	mov r0, r4
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r4
	add r0, #0xb5
	ldrb r0, [r0, #0]
	sub r1, r0, #1
	mov r0, r4
	add r0, #0xb5
	strb r1, [r0]
_02159124:
	mov r0, r4
	add r0, #0xb4
	ldrb r0, [r0, #0]
	cmp r0, #0
	bne _02159186
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
	mov r0, r4
	add r0, #0xa4
	ldr r1, [r0, #0]
	mov r0, r4
	add r0, #0xac
	ldr r0, [r0, #0]
	add r1, r1, r0
	mov r0, r4
	add r0, #0xa4
	str r1, [r0]
	mov r0, r4
	add r0, #0xa8
	ldr r1, [r0, #0]
	mov r0, r4
	add r0, #0xb0
	ldr r0, [r0, #0]
	add r1, r1, r0
	mov r0, r4
	add r0, #0xa8
	str r1, [r0]
	mov r0, r4
	add r0, #0xac
	ldr r1, [r0, #0]
	ldr r0, _02159264 // =0x00000E74
	ldr r0, [r5, r0]
	add r1, r1, r0
	mov r0, r4
	add r0, #0xac
	str r1, [r0]
	mov r0, r4
	add r0, #0xb0
	ldr r1, [r0, #0]
	ldr r0, _02159268 // =0x00000E78
	ldr r0, [r5, r0]
	add r1, r1, r0
	mov r0, r4
	add r0, #0xb0
	str r1, [r0]
	b _02159254
_02159186:
	mov r0, #0xe6
	lsl r0, r0, #4
	ldr r0, [r5, r0]
	cmp r0, #0
	beq _02159254
	mov r0, r4
	add r0, #0xb4
	ldrb r0, [r0, #0]
	sub r1, r0, #1
	mov r0, r4
	add r0, #0xb4
	strb r1, [r0]
	mov r0, r4
	add r0, #0xb4
	ldrb r0, [r0, #0]
	cmp r0, #0
	bne _02159254
	ldr r0, _0215926C // =_mt_math_rand
	ldr r1, [r0, #0]
	ldr r0, _02159270 // =0x00196225
	mov r2, r1
	mul r2, r0
	ldr r0, _02159274 // =0x3C6EF35F
	add r0, r2, r0
	lsr r1, r0, #0x10
	lsl r1, r1, #0x10
	lsr r7, r1, #0x10
	ldr r1, _02159270 // =0x00196225
	mul r1, r0
	ldr r0, _02159274 // =0x3C6EF35F
	add r1, r1, r0
	ldr r0, _0215926C // =_mt_math_rand
	str r1, [r0]
	lsr r0, r1, #0x10
	lsl r0, r0, #0x10
	mov r1, #0xe
	lsr r0, r0, #0x10
	lsl r1, r1, #0xa
	bl _s32_div_f
	mov r0, #2
	lsl r0, r0, #0xa
	add r6, r1, r0
	ldr r0, _02159278 // =0x00000E64
	mov r2, r6
	ldr r1, [r5, r0]
	mov r0, r4
	add r0, #0xa4
	str r1, [r0]
	ldr r0, _0215927C // =0x00000E68
	ldr r1, [r5, r0]
	mov r0, r4
	add r0, #0xa8
	str r1, [r0]
	lsl r0, r7, #0x10
	lsr r0, r0, #0x10
	asr r0, r0, #4
	asr r7, r6, #0x1f
	ldr r1, _02159280 // =FX_SinCosTable_
	lsl r0, r0, #2
	add r1, r1, r0
	str r1, [sp]
	ldr r1, _02159280 // =FX_SinCosTable_
	mov r3, r7
	ldrsh r0, [r1, r0]
	asr r1, r0, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r0, r0, r2
	ldr r2, _02159284 // =0x00000000
	adc r1, r2
	lsr r2, r0, #0xc
	lsl r1, r1, #0x14
	mov r0, r4
	orr r2, r1
	add r0, #0xac
	str r2, [r0]
	ldr r1, [sp]
	mov r0, #2
	ldrsh r0, [r1, r0]
	mov r2, r6
	mov r3, r7
	asr r1, r0, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _02159284 // =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	mov r0, r4
	add r0, #0xb0
	str r1, [r0]
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
_02159254:
	ldr r0, [sp, #4]
	add r4, #0xb8
	cmp r4, r0
	beq _0215925E
	b _021590E0
_0215925E:
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02159264: .word 0x00000E74
_02159268: .word 0x00000E78
_0215926C: .word _mt_math_rand
_02159270: .word 0x00196225
_02159274: .word 0x3C6EF35F
_02159278: .word 0x00000E64
_0215927C: .word 0x00000E68
_02159280: .word FX_SinCosTable_
_02159284: .word 0x00000000
	thumb_func_end StageClear__Func_21590CC

	thumb_func_start StageClear__Func_2159288
StageClear__Func_2159288: // 0x02159288
	push {r4, r5, r6, lr}
	mov r5, r0
	mov r0, #0xe6
	lsl r0, r0, #4
	beq _021592E8
	mov r6, #0x11
	add r4, r5, r0
	lsl r6, r6, #4
_02159298:
	mov r0, r5
	add r0, #0xb4
	ldrb r0, [r0, #0]
	cmp r0, #0
	bne _021592E2
	mov r0, r5
	add r0, #0xa4
	ldr r0, [r0, #0]
	asr r1, r0, #0xc
	mov r0, r5
	add r0, #0x68
	strh r1, [r0]
	mov r0, r5
	add r0, #0xa8
	ldr r0, [r0, #0]
	asr r0, r0, #0xc
	sub r1, r0, r6
	mov r0, r5
	add r0, #0x6a
	strh r1, [r0]
	mov r0, r5
	add r0, #0xa4
	ldr r0, [r0, #0]
	asr r1, r0, #0xc
	mov r0, r5
	add r0, #0x6c
	strh r1, [r0]
	mov r0, r5
	add r0, #0xa8
	ldr r0, [r0, #0]
	asr r1, r0, #0xc
	mov r0, r5
	add r0, #0x6e
	strh r1, [r0]
	mov r0, r5
	bl AnimatorSpriteDS__DrawFrame
_021592E2:
	add r5, #0xb8
	cmp r5, r4
	bne _02159298
_021592E8:
	pop {r4, r5, r6, pc}
	.align 2, 0
	thumb_func_end StageClear__Func_2159288

	thumb_func_start StageClear__GetTrickBonus
StageClear__GetTrickBonus: // 0x021592EC
	push {r3, r4}
	mov r2, #0x12
	ldr r3, _02159318 // =0x0217D81C
	mul r2, r0
	mov r4, #0
	add r2, r3, r2
_021592F8:
	ldrh r0, [r2, #0]
	cmp r1, r0
	bhs _02159308
	ldr r0, _0215931C // =0x0217D248
	lsl r1, r4, #2
	ldr r0, [r0, r1]
	pop {r3, r4}
	bx lr
_02159308:
	add r4, r4, #1
	add r2, r2, #2
	cmp r4, #9
	blo _021592F8
	ldr r0, _02159320 // =0x00004E20
	pop {r3, r4}
	bx lr
	nop
_02159318: .word 0x0217D81C
_0215931C: .word 0x0217D248
_02159320: .word 0x00004E20
	thumb_func_end StageClear__GetTrickBonus

	thumb_func_start StageClear__GetTimeBonus
StageClear__GetTimeBonus: // 0x02159324
	push {r4, r5, r6, r7}
	mov r7, r0
	mov r6, r1
	ldr r1, _021593C0 // =0x0217D53C
	lsl r0, r7, #4
	add r5, r1, r0
	ldr r0, _021593C4 // =gameState
	ldr r1, [r0, #0x10]
	mov r0, #2
	lsl r0, r0, #8
	tst r0, r1
	beq _02159342
	mov r0, #0
	pop {r4, r5, r6, r7}
	bx lr
_02159342:
	ldr r0, _021593C8 // =0x0217DB58
	mov r4, #0
	ldrb r1, [r0, r7]
	mov r0, #0x3c
_0215934A:
	ldrh r2, [r5, #0]
	mov r3, r2
	mul r3, r0
	cmp r3, r6
	bhi _02159384
	cmp r1, #5
	bhi _02159384
	add r2, r1, r1
	add r2, pc
	ldrh r2, [r2, #6]
	lsl r2, r2, #0x10
	asr r2, r2, #0x10
	add pc, r2
_02159364: // jump table
	.hword _02159370 - _02159364 - 2 // case 0
	.hword _02159370 - _02159364 - 2 // case 1
	.hword _0215937A - _02159364 - 2 // case 2
	.hword _0215937A - _02159364 - 2 // case 3
	.hword _02159370 - _02159364 - 2 // case 4
	.hword _02159370 - _02159364 - 2 // case 5
_02159370:
	ldr r0, _021593CC // =0x0217D270
	lsl r1, r4, #2
	ldr r0, [r0, r1]
	pop {r4, r5, r6, r7}
	bx lr
_0215937A:
	ldr r0, _021593D0 // =0x0217D294
	lsl r1, r4, #2
	ldr r0, [r0, r1]
	pop {r4, r5, r6, r7}
	bx lr
_02159384:
	add r4, r4, #1
	add r5, r5, #2
	cmp r4, #8
	blo _0215934A
	ldr r0, _021593C8 // =0x0217DB58
	ldrb r0, [r0, r7]
	cmp r0, #5
	bhi _021593B8
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_021593A0: // jump table
	.hword _021593AC - _021593A0 - 2 // case 0
	.hword _021593AC - _021593A0 - 2 // case 1
	.hword _021593B2 - _021593A0 - 2 // case 2
	.hword _021593B2 - _021593A0 - 2 // case 3
	.hword _021593AC - _021593A0 - 2 // case 4
	.hword _021593AC - _021593A0 - 2 // case 5
_021593AC:
	ldr r0, _021593D4 // =0x00014C08
	pop {r4, r5, r6, r7}
	bx lr
_021593B2:
	ldr r0, _021593D8 // =0x0000AFC8
	pop {r4, r5, r6, r7}
	bx lr
_021593B8:
	mov r0, #0
	pop {r4, r5, r6, r7}
	bx lr
	nop
_021593C0: .word 0x0217D53C
_021593C4: .word gameState
_021593C8: .word 0x0217DB58
_021593CC: .word 0x0217D270
_021593D0: .word 0x0217D294
_021593D4: .word 0x00014C08
_021593D8: .word 0x0000AFC8
	thumb_func_end StageClear__GetTimeBonus

	thumb_func_start StageClear__GetRingBonus
StageClear__GetRingBonus: // 0x021593DC
	lsl r2, r0, #3
	ldr r3, _02159400 // =0x0217D39E
	add r0, r0, r2
	add r2, r3, r0
	mov r3, #0
_021593E6:
	ldrb r0, [r2, r3]
	cmp r1, r0
	bhs _021593F4
	ldr r0, _02159404 // =0x0217D220
	lsl r1, r3, #2
	ldr r0, [r0, r1]
	bx lr
_021593F4:
	add r3, r3, #1
	cmp r3, #9
	blo _021593E6
	ldr r0, _02159408 // =0x00001388
	bx lr
	nop
_02159400: .word 0x0217D39E
_02159404: .word 0x0217D220
_02159408: .word 0x00001388
	thumb_func_end StageClear__GetRingBonus

	thumb_func_start StageClear__IsTimeAttack
StageClear__IsTimeAttack: // 0x0215940C
	ldr r0, _0215941C // =gameState
	ldr r0, [r0, #0x14]
	cmp r0, #2
	bne _02159418
	mov r0, #1
	bx lr
_02159418:
	mov r0, #0
	bx lr
	.align 2, 0
_0215941C: .word gameState
	thumb_func_end StageClear__IsTimeAttack

	thumb_func_start StageClearMissionClearText__Create
StageClearMissionClearText__Create: // 0x02159420
	push {r3, r4, r5, r6, lr}
	sub sp, #0x14
	ldr r1, _021594E0 // =0x00002BE4
	ldr r4, [r0, #0x4c]
	add r5, r0, r1
	mov r1, #0
	str r1, [r5]
	ldr r0, [r0, #0]
	bl StageClear__IsMissionMode
	cmp r0, #0
	beq _0215943C
	mov r6, #0
	b _0215943E
_0215943C:
	mov r6, #2
_0215943E:
	mov r0, r4
	mov r1, #0
	mov r2, r6
	bl SpriteUnknown__Func_204C3CC
	mov r3, #0
	str r3, [sp]
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	mov r0, #4
	str r0, [sp, #0x10]
	add r0, r5, #4
	mov r1, r4
	mov r2, r6
	bl SpriteUnknown__Func_204C90C
	mov r0, #0xa7
	mvn r0, r0
	strh r0, [r5, #0xc]
	mov r0, #0x28
	mov r1, #0
	strh r0, [r5, #0xe]
	add r0, r5, #4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	mov r1, #0
	mov r2, #1
	add r5, #0x68
	bl SpriteUnknown__Func_204C3CC
	mov r3, #0
	str r3, [sp]
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	mov r2, #1
	str r2, [sp, #0xc]
	mov r0, #4
	str r0, [sp, #0x10]
	mov r0, r5
	mov r1, r4
	bl SpriteUnknown__Func_204C90C
	mov r0, #0xa7
	mvn r0, r0
	strh r0, [r5, #8]
	mov r0, #0x40
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x47
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	ldr r0, _021594E4 // =StageClearMissionClearText__Main1
	ldr r1, _021594E8 // =StageClearMissionClearText__Destructor
	mov r3, r2
	str r2, [sp, #8]
	bl TaskCreate_
	mov r1, #0
	mov r0, #0x86
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _021594EC // =StageClearMissionClearText__Main2
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	add sp, #0x14
	pop {r3, r4, r5, r6, pc}
	nop
_021594E0: .word 0x00002BE4
_021594E4: .word StageClearMissionClearText__Main1
_021594E8: .word StageClearMissionClearText__Destructor
_021594EC: .word StageClearMissionClearText__Main2
	thumb_func_end StageClearMissionClearText__Create

	thumb_func_start StageClearMissionClearText__Destroy
StageClearMissionClearText__Destroy: // 0x021594F0
	push {r4, lr}
	ldr r1, _02159508 // =0x00002BE4
	add r4, r0, r1
	add r0, r4, #4
	bl AnimatorSprite__Release
	add r4, #0x68
	mov r0, r4
	bl AnimatorSprite__Release
	pop {r4, pc}
	nop
_02159508: .word 0x00002BE4
	thumb_func_end StageClearMissionClearText__Destroy

	thumb_func_start StageClearMissionClearText__Func_215950C
StageClearMissionClearText__Func_215950C: // 0x0215950C
	push {r4, lr}
	ldr r1, _02159548 // =0x00002BE4
	add r4, r0, r1
	mov r0, r4
	add r0, #0xcc
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _02159528
	bl DestroyTask
	mov r0, r4
	mov r1, #0
	add r0, #0xcc
	str r1, [r0]
_02159528:
	mov r0, r4
	add r0, #0xd0
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _0215953E
	bl DestroyTask
	mov r0, r4
	mov r1, #0
	add r0, #0xd0
	str r1, [r0]
_0215953E:
	mov r0, #0x58
	strh r0, [r4, #0xc]
	add r4, #0x70
	strh r0, [r4]
	pop {r4, pc}
	.align 2, 0
_02159548: .word 0x00002BE4
	thumb_func_end StageClearMissionClearText__Func_215950C

	thumb_func_start StageClearMissionClearText__Destructor
StageClearMissionClearText__Destructor: // 0x0215954C
	bx lr
	.align 2, 0
	thumb_func_end StageClearMissionClearText__Destructor

	thumb_func_start StageClear__IsMissionMode
StageClear__IsMissionMode: // 0x02159550
	ldr r0, _02159560 // =gameState
	ldr r0, [r0, #0x14]
	cmp r0, #3
	bne _0215955C
	mov r0, #1
	bx lr
_0215955C:
	mov r0, #0
	bx lr
	.align 2, 0
_02159560: .word gameState
	thumb_func_end StageClear__IsMissionMode

	thumb_func_start StageClear__Main
StageClear__Main: // 0x02159564
	push {r4, lr}
	ldr r0, _021595F8 // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _021595FC // =0x00002CB8
	ldrh r1, [r4, r0]
	add r1, r1, #1
	strh r1, [r4, r0]
	ldr r1, [r4, #4]
	cmp r1, #8
	bhi _021595F6
	add r2, r1, r1
	add r2, pc
	ldrh r2, [r2, #6]
	lsl r2, r2, #0x10
	asr r2, r2, #0x10
	add pc, r2
_0215958A: // jump table
	.hword _0215959C - _0215958A - 2 // case 0
	.hword _021595B6 - _0215958A - 2 // case 1
	.hword _021595F2 - _0215958A - 2 // case 2
	.hword _021595B6 - _0215958A - 2 // case 3
	.hword _021595F2 - _0215958A - 2 // case 4
	.hword _021595B6 - _0215958A - 2 // case 5
	.hword _021595F2 - _0215958A - 2 // case 6
	.hword _021595CA - _0215958A - 2 // case 7
	.hword _021595F6 - _0215958A - 2 // case 8
_0215959C:
	ldrh r2, [r4, r0]
	cmp r2, #0xa
	blo _021595AA
	add r1, r1, #1
	str r1, [r4, #4]
	mov r1, #0
	strh r1, [r4, r0]
_021595AA:
	ldr r0, [r4, #0]
	cmp r0, #2
	bne _021595F6
	mov r0, #5
	str r0, [r4, #4]
	pop {r4, pc}
_021595B6:
	ldr r2, _02159600 // =padInput
	ldrh r3, [r2, #4]
	ldr r2, _02159604 // =0x00000C03
	tst r2, r3
	beq _021595F6
	add r1, r1, #1
	str r1, [r4, #4]
	mov r1, #0
	strh r1, [r4, r0]
	pop {r4, pc}
_021595CA:
	ldr r0, [r4, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	bne _021595E6
	ldr r0, _02159600 // =padInput
	ldrh r1, [r0, #4]
	ldr r0, _02159604 // =0x00000C03
	tst r0, r1
	beq _021595F6
	mov r0, #0
	bl StageClear__StartFadeOut
	pop {r4, pc}
_021595E6:
	mov r0, r4
	bl Task__OVL03Unknown2158C6C__Create
	mov r0, #8
	str r0, [r4, #4]
	pop {r4, pc}
_021595F2:
	add r0, r1, #1
	str r0, [r4, #4]
_021595F6:
	pop {r4, pc}
	.align 2, 0
_021595F8: .word StageClear__Singleton
_021595FC: .word 0x00002CB8
_02159600: .word padInput
_02159604: .word 0x00000C03
	thumb_func_end StageClear__Main

	thumb_func_start StageClear__Main_2159608
StageClear__Main_2159608: // 0x02159608
	push {r4, lr}
	ldr r0, _0215963C // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _02159640 // =0x00002CB8
	ldrh r2, [r0, r1]
	add r2, r2, #1
	strh r2, [r0, r1]
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _0215963A
	bl GetCurrentTask
	mov r4, r0
	bl DestroyDrawFadeTask
	bl NextSysEvent
	mov r0, r4
	bl StageClear__Destroy
	bl DestroyCurrentTask
_0215963A:
	pop {r4, pc}
	.align 2, 0
_0215963C: .word StageClear__Singleton
_02159640: .word 0x00002CB8
	thumb_func_end StageClear__Main_2159608

	thumb_func_start StageClearPlayer__Main1
StageClearPlayer__Main1: // 0x02159644
	push {r4, r5, r6, lr}
	ldr r0, _021596C0 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02159654
	bl DestroyCurrentTask
	pop {r4, r5, r6, pc}
_02159654:
	bl GetTaskWork_
	mov r5, r0
	ldr r0, _021596C0 // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r1, [r5, #4]
	add r4, #0x50
	cmp r1, #1
	bne _02159674
	ldr r0, _021596C4 // =0x00002CB8
	ldrh r0, [r5, r0]
	cmp r0, #0x6a
	bhs _02159678
_02159674:
	cmp r1, #1
	ble _021596B2
_02159678:
	ldr r0, [r5, #8]
	cmp r0, #0
	beq _02159684
	cmp r0, #1
	beq _0215968E
	b _021596A0
_02159684:
	mov r0, r4
	mov r6, r4
	bl AnimatorMDL__ProcessAnimation
	b _021596A0
_0215968E:
	mov r0, r4
	bl AnimatorMDL__ProcessAnimation
	mov r0, #0x51
	lsl r0, r0, #2
	add r6, r4, r0
	mov r0, r6
	bl AnimatorMDL__ProcessAnimation
_021596A0:
	mov r0, #0x43
	lsl r0, r0, #2
	ldrh r1, [r6, r0]
	mov r0, #2
	lsl r0, r0, #0xe
	tst r0, r1
	beq _021596B2
	bl DestroyCurrentTask
_021596B2:
	ldr r0, [r5, #4]
	cmp r0, #2
	bne _021596BE
	mov r0, r5
	bl StageClearPlayer__Func_21572C8
_021596BE:
	pop {r4, r5, r6, pc}
	.align 2, 0
_021596C0: .word StageClear__Singleton
_021596C4: .word 0x00002CB8
	thumb_func_end StageClearPlayer__Main1

	thumb_func_start StageClearPlayer__Main2
StageClearPlayer__Main2: // 0x021596C8
	push {r3, r4, r5, lr}
	ldr r0, _02159710 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _021596D8
	bl DestroyCurrentTask
	pop {r3, r4, r5, pc}
_021596D8:
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _02159710 // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, r0
	ldr r0, [r4, #8]
	add r5, #0x50
	cmp r0, #0
	beq _021596F6
	cmp r0, #1
	beq _021596FE
	pop {r3, r4, r5, pc}
_021596F6:
	mov r0, r5
	bl AnimatorMDL__Draw
	pop {r3, r4, r5, pc}
_021596FE:
	mov r0, r5
	bl AnimatorMDL__Draw
	mov r0, #0x51
	lsl r0, r0, #2
	add r0, r5, r0
	bl AnimatorMDL__Draw
	pop {r3, r4, r5, pc}
	.align 2, 0
_02159710: .word StageClear__Singleton
	thumb_func_end StageClearPlayer__Main2

	thumb_func_start StageClearHeader__Main1
StageClearHeader__Main1: // 0x02159714
	push {r4, lr}
	ldr r0, _021597BC // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02159724
	bl DestroyCurrentTask
	pop {r4, pc}
_02159724:
	bl GetTaskWork_
	mov r1, #0xca
	lsl r1, r1, #2
	add r4, r0, r1
	ldr r0, [r0, #4]
	cmp r0, #2
	bne _02159760
	mov r0, #0x5d
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0215974A
	bl DestroyTask
	mov r0, #0x5d
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r4, r0]
_0215974A:
	mov r0, #0x5e
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _02159760
	bl DestroyTask
	mov r0, #0x5e
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r4, r0]
_02159760:
	mov r1, #0x5b
	lsl r1, r1, #2
	mov r0, #6
	ldr r2, [r4, r1]
	lsl r0, r0, #0xa
	add r0, r2, r0
	str r0, [r4, r1]
	mov r0, #1
	ldr r2, [r4, r1]
	lsl r0, r0, #0x14
	cmp r2, r0
	ble _02159782
	sub r0, r2, r0
	str r0, [r4, r1]
	mov r2, #1
	add r0, r1, #4
	str r2, [r4, r0]
_02159782:
	mov r1, #0x5b
	lsl r1, r1, #2
	mov r2, #1
	ldr r0, [r4, r1]
	lsl r2, r2, #0x14
	sub r0, r2, r0
	asr r3, r0, #0xc
	mov r0, r4
	add r0, #0x68
	strh r3, [r0]
	ldr r0, [r4, r1]
	sub r0, r0, r2
	asr r3, r0, #0xc
	mov r0, r4
	add r0, #0x6c
	strh r3, [r0]
	ldr r0, [r4, r1]
	sub r0, r2, r0
	asr r3, r0, #0xc
	mov r0, r1
	sub r0, #0x5c
	strh r3, [r4, r0]
	ldr r0, [r4, r1]
	add r4, #0xac
	sub r0, r0, r2
	asr r0, r0, #0xc
	strh r0, [r4]
	pop {r4, pc}
	nop
_021597BC: .word StageClear__Singleton
	thumb_func_end StageClearHeader__Main1

	thumb_func_start StageClearHeader__Main2
StageClearHeader__Main2: // 0x021597C0
	push {r4, lr}
	ldr r0, _02159864 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _021597D0
	bl DestroyCurrentTask
	pop {r4, pc}
_021597D0:
	bl GetTaskWork_
	mov r1, #0xca
	lsl r1, r1, #2
	add r4, r0, r1
	mov r1, #0xae
	ldrsh r2, [r4, r1]
	mov r0, r4
	add r0, #0x6e
	strh r2, [r0]
	add r1, #0x64
	mov r0, r4
	ldrsh r1, [r4, r1]
	add r0, #0x6a
	strh r1, [r0]
	mov r0, r4
	bl AnimatorSpriteDS__DrawFrame
	mov r0, #0x68
	ldrsh r1, [r4, r0]
	add r0, #0x98
	sub r1, r1, r0
	mov r0, r4
	add r0, #0x68
	strh r1, [r0]
	mov r0, #0x6c
	ldrsh r1, [r4, r0]
	add r0, #0x94
	sub r1, r1, r0
	mov r0, r4
	add r0, #0x6c
	strh r1, [r0]
	mov r0, r4
	bl AnimatorSpriteDS__DrawFrame
	mov r0, #0x42
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	add r0, #0xa4
	bl AnimatorSprite__DrawFrame
	mov r1, #0x17
	lsl r1, r1, #4
	ldr r0, [r4, r1]
	cmp r0, #0
	beq _02159862
	mov r0, r1
	sub r0, #0x60
	ldrsh r2, [r4, r0]
	mov r0, r1
	sub r0, #0x70
	sub r2, r2, r0
	mov r0, r1
	sub r0, #0x60
	sub r1, #0x68
	strh r2, [r4, r0]
	add r0, r4, r1
	bl AnimatorSprite__DrawFrame
	mov r0, #0xac
	ldrsh r1, [r4, r0]
	add r0, #0x54
	sub r1, r1, r0
	mov r0, r4
	add r0, #0xac
	add r4, #0xa4
	strh r1, [r0]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_02159862:
	pop {r4, pc}
	.align 2, 0
_02159864: .word StageClear__Singleton
	thumb_func_end StageClearHeader__Main2

	thumb_func_start StageClearStageScoreTally__Main1
StageClearStageScoreTally__Main1: // 0x02159868
	push {r3, r4, r5, lr}
	sub sp, #8
	ldr r0, _02159908 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215987C
	bl DestroyCurrentTask
	add sp, #8
	pop {r3, r4, r5, pc}
_0215987C:
	bl GetTaskWork_
	ldr r1, _0215990C // =0x000006B8
	mov r5, r0
	add r4, r5, r1
	ldr r1, [r5, #4]
	cmp r1, #2
	bne _02159894
	bl StageClearStageScoreTally__Func_2157958
	add sp, #8
	pop {r3, r4, r5, pc}
_02159894:
	bl RenderCore_GetDMARenderCount
	mov r1, #1
	tst r0, r1
	bne _021598AC
	bl Task__Unknown204BE48__Rand
	ldr r1, _02159910 // =0x000F4240
	bl _u32_div_f
	ldr r0, _02159914 // =0x000006D4
	str r1, [r4, r0]
_021598AC:
	mov r2, #0
	ldrsh r0, [r4, r2]
	sub r1, r2, #1
	cmp r0, r1
	beq _02159902
	cmp r0, #0x30
	ble _021598F6
	sub r0, #0x30
	mov r1, #0x14
	bl _s32_div_f
	ldr r1, _02159918 // =0x000006D8
	strh r0, [r4, r1]
	ldrh r0, [r4, r1]
	cmp r0, #6
	blo _021598FA
	mov r0, #0
	add r1, r1, #4
	str r0, [r4, r1]
	ldr r1, _0215991C // =0x00002CBC
	ldr r1, [r5, r1]
	str r1, [sp]
	mov r1, #2
	str r1, [sp, #4]
	sub r1, r1, #3
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #4]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	bl DestroyCurrentTask
	add sp, #8
	pop {r3, r4, r5, pc}
_021598F6:
	ldr r0, _02159918 // =0x000006D8
	strh r2, [r4, r0]
_021598FA:
	mov r0, #0
	ldrsh r0, [r4, r0]
	add r0, r0, #1
	strh r0, [r4]
_02159902:
	add sp, #8
	pop {r3, r4, r5, pc}
	nop
_02159908: .word StageClear__Singleton
_0215990C: .word 0x000006B8
_02159910: .word 0x000F4240
_02159914: .word 0x000006D4
_02159918: .word 0x000006D8
_0215991C: .word 0x00002CBC
	thumb_func_end StageClearStageScoreTally__Main1

	thumb_func_start StageClearStageScoreTally__Main2
StageClearStageScoreTally__Main2: // 0x02159920
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	ldr r0, _02159A54 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02159934
	bl DestroyCurrentTask
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
_02159934:
	bl GetTaskWork_
	ldr r1, _02159A58 // =0x000006B8
	mov r6, #0
	add r0, r0, r1
	mov r1, #0x7f
	mov r5, r0
	lsl r1, r1, #2
	str r0, [sp, #0x10]
	add r5, #8
	str r6, [sp, #0xc]
	mov r7, r0
	add r4, r0, r1
_0215994E:
	cmp r6, #3
	beq _021599AC
	ldr r1, [r5, #0x3c]
	mov r0, #1
	tst r0, r1
	bne _021599AC
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	mov r0, #8
	ldrsh r0, [r5, r0]
	add r0, #8
	strh r0, [r4, #8]
	mov r0, #0xa
	ldrsh r1, [r5, r0]
	ldr r0, [sp, #0xc]
	add r1, #8
	add r0, r1, r0
	strh r0, [r4, #0xa]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r0, #5
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, #0x1b
	lsl r0, r0, #6
	ldr r0, [r7, r0]
	ldr r1, [sp, #0x10]
	str r0, [sp, #8]
	mov r0, #0xb1
	lsl r0, r0, #2
	add r0, r1, r0
	mov r1, #8
	mov r2, #0xa
	ldrsh r1, [r4, r1]
	ldrsh r2, [r4, r2]
	mov r3, #8
	add r1, #0x58
	sub r2, r2, #1
	lsl r1, r1, #0x10
	lsl r2, r2, #0x10
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	bl StageClear__Func_2158CE8
_021599AC:
	ldr r0, [sp, #0xc]
	add r6, r6, #1
	add r0, #0x14
	add r5, #0x64
	add r7, r7, #4
	str r0, [sp, #0xc]
	cmp r6, #4
	blo _0215994E
	ldr r1, _02159A5C // =0x000006D8
	ldr r0, [sp, #0x10]
	mov r4, #1
	ldrh r1, [r0, r1]
	mov r2, #0
	cmp r1, #0
	bls _021599D4
	mov r0, #0xa
_021599CC:
	add r2, r2, #1
	mul r4, r0
	cmp r2, r1
	blo _021599CC
_021599D4:
	mov r1, #0x6d
	ldr r0, [sp, #0x10]
	lsl r1, r1, #4
	ldr r0, [r0, r1]
	mov r1, r4
	bl _u32_div_f
	mov r5, r1
	ldr r1, _02159A60 // =0x000006D4
	ldr r0, [sp, #0x10]
	ldr r0, [r0, r1]
	mov r1, r4
	bl _u32_div_f
	mul r0, r4
	add r6, r5, r0
	mov r1, #0x66
	ldr r0, [sp, #0x10]
	lsl r1, r1, #2
	add r4, r0, r1
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r1, #0x26
	ldr r0, [sp, #0x10]
	lsl r1, r1, #4
	add r5, r0, r1
	mov r0, #8
	ldrsh r0, [r4, r0]
	add r0, #8
	strh r0, [r5, #8]
	mov r0, #0xa
	ldrsh r0, [r4, r0]
	add r0, #0x58
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	mov r0, #6
	str r0, [sp]
	ldr r1, _02159A64 // =0x000006DC
	ldr r0, [sp, #0x10]
	mov r3, #8
	ldr r0, [r0, r1]
	mov r1, #0xb1
	str r0, [sp, #4]
	ldr r0, [sp, #0x10]
	lsl r1, r1, #2
	str r6, [sp, #8]
	mov r2, #0xa
	add r0, r0, r1
	ldrsh r1, [r5, r3]
	ldrsh r2, [r5, r2]
	add r1, #0x50
	sub r2, r2, #1
	lsl r1, r1, #0x10
	lsl r2, r2, #0x10
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	bl StageClear__Func_2158CE8
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	nop
_02159A54: .word StageClear__Singleton
_02159A58: .word 0x000006B8
_02159A5C: .word 0x000006D8
_02159A60: .word 0x000006D4
_02159A64: .word 0x000006DC
	thumb_func_end StageClearStageScoreTally__Main2

	thumb_func_start StageClearStageScoreTally__Main3
StageClearStageScoreTally__Main3: // 0x02159A68
	push {r3, lr}
	ldr r0, _02159A9C // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02159A78
	bl DestroyCurrentTask
	pop {r3, pc}
_02159A78:
	bl GetTaskWork_
	ldr r1, _02159AA0 // =0x000006B8
	add r2, r0, r1
	ldr r1, [r0, #4]
	cmp r1, #2
	bne _02159A8C
	bl StageClearStageScoreTally__Func_2157CD8
	pop {r3, pc}
_02159A8C:
	mov r0, #0
	ldrsh r1, [r2, r0]
	sub r0, r0, #1
	cmp r1, r0
	beq _02159A9A
	bl DestroyCurrentTask
_02159A9A:
	pop {r3, pc}
	.align 2, 0
_02159A9C: .word StageClear__Singleton
_02159AA0: .word 0x000006B8
	thumb_func_end StageClearStageScoreTally__Main3

	thumb_func_start StageClearStageScoreTally__Main4
StageClearStageScoreTally__Main4: // 0x02159AA4
	push {r4, r5, r6, lr}
	sub sp, #8
	ldr r0, _02159B38 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02159AB8
	bl DestroyCurrentTask
	add sp, #8
	pop {r4, r5, r6, pc}
_02159AB8:
	bl GetTaskWork_
	ldr r1, _02159B3C // =0x000006B8
	add r4, r0, r1
	add r6, r4, #4
	mov r5, r4
	mov r0, r6
	add r5, #0xcc
	bl AnimatorSprite__DrawFrame
	mov r0, #8
	ldrsh r0, [r6, r0]
	add r0, #8
	strh r0, [r5, #8]
	mov r0, #0xa
	ldrsh r0, [r6, r0]
	add r0, #0x1c
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	mov r0, #0xc
	ldr r1, _02159B40 // =0x0000064C
	str r0, [sp]
	ldr r0, [r4, r1]
	sub r1, #0xd0
	str r0, [sp, #4]
	mov r2, #8
	mov r3, #0xa
	ldrsh r2, [r5, r2]
	ldrsh r3, [r5, r3]
	mov r0, #0x65
	add r2, #0x3a
	add r3, #0x18
	lsl r0, r0, #2
	lsl r2, r2, #0x10
	lsl r3, r3, #0x10
	add r0, r4, r0
	add r1, r4, r1
	asr r2, r2, #0x10
	asr r3, r3, #0x10
	bl StageClear__Func_2158D54
	mov r5, r4
	add r5, #0x68
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	mov r1, #8
	ldrsh r1, [r5, r1]
	mov r0, #0x13
	lsl r0, r0, #4
	add r0, r4, r0
	add r1, #8
	strh r1, [r0, #8]
	mov r1, #0xa
	ldrsh r1, [r5, r1]
	add r1, #0x44
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	add sp, #8
	pop {r4, r5, r6, pc}
	nop
_02159B38: .word StageClear__Singleton
_02159B3C: .word 0x000006B8
_02159B40: .word 0x0000064C
	thumb_func_end StageClearStageScoreTally__Main4

	thumb_func_start StageClearStageRank__Main
StageClearStageRank__Main: // 0x02159B44
	push {r4, r5, lr}
	sub sp, #0xc
	ldr r0, _02159BF4 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02159B58
	bl DestroyCurrentTask
	add sp, #0xc
	pop {r4, r5, pc}
_02159B58:
	bl GetTaskWork_
	mov r5, r0
	ldr r0, [r5, #4]
	ldr r4, _02159BF8 // =0x00000D98
	cmp r0, #4
	bne _02159B94
	mov r0, #0x84
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02159BFC // =StageClear__RankDisplay__Main_Idle
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	add r1, r5, r4
	add r1, #0xe0
	str r0, [r1]
	mov r0, r5
	bl StageClear__PlayRankVoiceClip
	mov r0, r5
	bl StageClear__PlayRankGetSfx
	bl DestroyCurrentTask
	add sp, #0xc
	pop {r4, r5, pc}
_02159B94:
	cmp r0, #3
	bne _02159BF0
	ldr r0, _02159C00 // =0x00002CB8
	ldrh r0, [r5, r0]
	cmp r0, #0x1e
	blo _02159BF0
	add r0, r5, r4
	mov r1, #0
	add r0, #0xdc
	str r1, [r0]
	mov r0, #0x84
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02159C04 // =StageClear__RankDisplay__Main_Appear
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	add r1, r5, r4
	add r1, #0xe0
	str r0, [r1]
	ldr r0, _02159C08 // =StageClearStageRank__Main_Invisible
	bl SetCurrentTaskMainEvent
	add r0, r5, r4
	mov r1, #0
	add r0, #0xcc
	str r1, [r0]
	ldr r0, [r5, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _02159BF0
	ldr r0, _02159C0C // =0x00002CBC
	mov r1, #2
	ldr r0, [r5, r0]
	str r0, [sp]
	str r1, [sp, #4]
	sub r1, r1, #3
	ldr r0, _02159C10 // =0x00000EE8
	mov r2, r1
	ldr r0, [r5, r0]
	mov r3, r1
	bl PlaySfxEx
_02159BF0:
	add sp, #0xc
	pop {r4, r5, pc}
	.align 2, 0
_02159BF4: .word StageClear__Singleton
_02159BF8: .word 0x00000D98
_02159BFC: .word StageClear__RankDisplay__Main_Idle
_02159C00: .word 0x00002CB8
_02159C04: .word StageClear__RankDisplay__Main_Appear
_02159C08: .word StageClearStageRank__Main_Invisible
_02159C0C: .word 0x00002CBC
_02159C10: .word 0x00000EE8
	thumb_func_end StageClearStageRank__Main

	thumb_func_start StageClearStageRank__Main_Invisible
StageClearStageRank__Main_Invisible: // 0x02159C14
	push {r4, r5, r6, lr}
	ldr r0, _02159CD0 // =StageClear__Singleton
	mov r6, #0x1e
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02159C26
	bl DestroyCurrentTask
	pop {r4, r5, r6, pc}
_02159C26:
	bl GetTaskWork_
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r4, _02159CD4 // =0x00000D98
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _02159C3A
	mov r6, #0x96
_02159C3A:
	ldr r0, [r5, #4]
	cmp r0, #4
	bne _02159C72
	add r0, r5, r4
	add r0, #0xe0
	ldr r0, [r0, #0]
	ldr r1, _02159CD8 // =StageClear__RankDisplay__Main_Idle
	bl SetTaskMainEvent
	mov r0, r5
	bl StageClear__PlayRankVoiceClip
	mov r0, r5
	bl StageClear__PlayRankGetSfx
	ldr r0, [r5, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _02159C6C
	ldr r0, _02159CDC // =0x00000EE8
	mov r1, #0
	ldr r0, [r5, r0]
	bl NNS_SndPlayerStopSeq
_02159C6C:
	bl DestroyCurrentTask
	b _02159CBE
_02159C72:
	add r0, r5, r4
	add r0, #0xcc
	ldr r0, [r0, #0]
	cmp r6, r0
	bhi _02159CBE
	ldr r0, _02159CD0 // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r0, r5
	bl StageClear__PlayRankVoiceClip
	ldr r0, [r5, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _02159C9E
	ldr r0, _02159CDC // =0x00000EE8
	mov r1, #0
	ldr r0, [r5, r0]
	bl NNS_SndPlayerStopSeq
_02159C9E:
	mov r1, #6
	add r0, r5, r4
	lsl r1, r1, #0xa
	add r0, #0xd0
	str r1, [r0]
	add r0, r5, r4
	mov r1, #1
	add r0, #0xdc
	str r1, [r0]
	add r0, r5, r4
	mov r1, #0
	add r0, #0xcc
	str r1, [r0]
	ldr r0, _02159CE0 // =StageClear__Rank__Main_Appearing
	bl SetCurrentTaskMainEvent
_02159CBE:
	add r0, r5, r4
	add r0, #0xcc
	ldr r0, [r0, #0]
	add r1, r0, #1
	add r0, r5, r4
	add r0, #0xcc
	str r1, [r0]
	pop {r4, r5, r6, pc}
	nop
_02159CD0: .word StageClear__Singleton
_02159CD4: .word 0x00000D98
_02159CD8: .word StageClear__RankDisplay__Main_Idle
_02159CDC: .word 0x00000EE8
_02159CE0: .word StageClear__Rank__Main_Appearing
	thumb_func_end StageClearStageRank__Main_Invisible

	thumb_func_start StageClear__Rank__Main_Appearing
StageClear__Rank__Main_Appearing: // 0x02159CE4
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _02159DB8 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02159CF4
	bl DestroyCurrentTask
	pop {r3, r4, r5, r6, r7, pc}
_02159CF4:
	bl GetTaskWork_
	mov r5, r0
	ldr r0, _02159DBC // =0x00000D98
	mov r1, #2
	add r0, r5, r0
	add r0, #0xcc
	ldr r0, [r0, #0]
	lsl r1, r1, #0x10
	lsl r0, r0, #0xc
	bl FX_Div
	lsl r0, r0, #0x10
	asr r6, r0, #0x10
	mov r0, #1
	mov r4, #3
	lsl r0, r0, #0xc
	asr r7, r6, #0x1f
_02159D18:
	mov r1, #6
	lsl r1, r1, #0xa
	sub r0, r0, r1
	asr r1, r0, #0x1f
	mov r2, r6
	mov r3, r7
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r0, r0, r2
	ldr r2, _02159DC0 // =0x00000000
	adc r1, r2
	lsr r2, r0, #0xc
	lsl r1, r1, #0x14
	mov r0, #6
	orr r2, r1
	lsl r0, r0, #0xa
	mov r1, r4
	add r0, r2, r0
	sub r4, r4, #1
	cmp r1, #0
	bne _02159D18
	ldr r1, _02159DBC // =0x00000D98
	add r1, r5, r1
	add r1, #0xd0
	str r0, [r1]
	ldr r0, [r5, #4]
	cmp r0, #4
	bne _02159D6C
	ldr r0, _02159DBC // =0x00000D98
	ldr r1, _02159DC4 // =StageClear__RankDisplay__Main_Idle
	add r0, r5, r0
	add r0, #0xe0
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	mov r0, r5
	bl StageClear__PlayRankGetSfx
	bl DestroyCurrentTask
_02159D6C:
	ldr r0, _02159DBC // =0x00000D98
	add r0, r5, r0
	add r0, #0xcc
	ldr r0, [r0, #0]
	cmp r0, #0x20
	blo _02159DA2
	mov r0, r5
	bl StageClear__PlayRankGetSfx
	ldr r0, _02159DBC // =0x00000D98
	ldr r1, _02159DC4 // =StageClear__RankDisplay__Main_Idle
	add r0, r5, r0
	add r0, #0xe0
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	mov r0, #6
	bl ShakeScreen
	ldr r0, _02159DBC // =0x00000D98
	mov r1, #0
	add r0, r5, r0
	add r0, #0xcc
	str r1, [r0]
	ldr r0, _02159DC8 // =StageClear__Rank__Main_RankGet
	bl SetCurrentTaskMainEvent
_02159DA2:
	ldr r0, _02159DBC // =0x00000D98
	add r0, r5, r0
	add r0, #0xcc
	ldr r0, [r0, #0]
	add r1, r0, #1
	ldr r0, _02159DBC // =0x00000D98
	add r0, r5, r0
	add r0, #0xcc
	str r1, [r0]
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02159DB8: .word StageClear__Singleton
_02159DBC: .word 0x00000D98
_02159DC0: .word 0x00000000
_02159DC4: .word StageClear__RankDisplay__Main_Idle
_02159DC8: .word StageClear__Rank__Main_RankGet
	thumb_func_end StageClear__Rank__Main_Appearing

	thumb_func_start StageClear__Rank__Main_RankGet
StageClear__Rank__Main_RankGet: // 0x02159DCC
	push {r4, r5, r6, lr}
	ldr r0, _02159E58 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02159DDC
	bl DestroyCurrentTask
	pop {r4, r5, r6, pc}
_02159DDC:
	bl GetTaskWork_
	mov r6, r0
	ldr r0, _02159E5C // =0x00000D98
	add r4, r6, r0
	mov r5, r4
	add r5, #0x64
	bl GetScreenShakeOffsetX
	mov r1, #0xc8
	ldrsh r1, [r4, r1]
	asr r0, r0, #0xc
	add r0, r1, r0
	strh r0, [r5, #8]
	bl GetScreenShakeOffsetY
	mov r1, #0xca
	ldrsh r1, [r4, r1]
	asr r0, r0, #0xc
	add r0, r1, r0
	strh r0, [r5, #0xa]
	bl GetScreenShakeOffsetX
	mov r1, #0xc8
	ldrsh r1, [r4, r1]
	asr r0, r0, #0xc
	sub r0, r1, r0
	strh r0, [r4, #8]
	bl GetScreenShakeOffsetY
	mov r1, #0xca
	ldrsh r1, [r4, r1]
	asr r0, r0, #0xc
	sub r0, r1, r0
	strh r0, [r4, #0xa]
	ldr r0, [r6, #4]
	cmp r0, #4
	bne _02159E38
	mov r0, r4
	add r0, #0xe0
	ldr r0, [r0, #0]
	ldr r1, _02159E60 // =StageClear__RankDisplay__Main_Idle
	bl SetTaskMainEvent
	bl DestroyCurrentTask
_02159E38:
	mov r0, #0x11
	bl ShakeScreen
	cmp r0, #0
	bne _02159E48
	bl DestroyCurrentTask
	pop {r4, r5, r6, pc}
_02159E48:
	mov r0, r4
	add r0, #0xcc
	ldr r0, [r0, #0]
	add r4, #0xcc
	add r0, r0, #1
	str r0, [r4]
	pop {r4, r5, r6, pc}
	nop
_02159E58: .word StageClear__Singleton
_02159E5C: .word 0x00000D98
_02159E60: .word StageClear__RankDisplay__Main_Idle
	thumb_func_end StageClear__Rank__Main_RankGet

	thumb_func_start StageClear__RankDisplay__Main_Appear
StageClear__RankDisplay__Main_Appear: // 0x02159E64
	push {r3, r4, r5, lr}
	ldr r0, _02159EBC // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02159E74
	bl DestroyCurrentTask
	pop {r3, r4, r5, pc}
_02159E74:
	bl GetTaskWork_
	ldr r4, _02159EC0 // =0x00000D98
	mov r5, r0
	add r0, r5, r4
	add r0, #0x64
	bl AnimatorSprite__DrawFrame
	add r0, r5, r4
	add r0, #0xdc
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _02159EBA
	add r0, r5, r4
	add r0, #0xd0
	ldr r1, [r0, #0]
	add r0, r5, r4
	mov r2, r1
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	ldr r0, [r5, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _02159EBA
	add r0, r5, r4
	add r0, #0xd0
	ldr r1, [r0, #0]
	add r0, r5, r4
	add r0, #0xec
	mov r2, r1
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
_02159EBA:
	pop {r3, r4, r5, pc}
	.align 2, 0
_02159EBC: .word StageClear__Singleton
_02159EC0: .word 0x00000D98
	thumb_func_end StageClear__RankDisplay__Main_Appear

	thumb_func_start StageClear__RankDisplay__Main_Idle
StageClear__RankDisplay__Main_Idle: // 0x02159EC4
	push {r3, r4, r5, lr}
	ldr r0, _02159F00 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02159ED4
	bl DestroyCurrentTask
	pop {r3, r4, r5, pc}
_02159ED4:
	bl GetTaskWork_
	ldr r4, _02159F04 // =0x00000D98
	mov r5, r0
	add r0, r5, r4
	add r0, #0x64
	bl AnimatorSprite__DrawFrame
	add r0, r5, r4
	bl AnimatorSprite__DrawFrame
	ldr r0, [r5, #0]
	bl StageClear__IsTimeAttack
	cmp r0, #0
	beq _02159EFC
	add r0, r5, r4
	add r0, #0xec
	bl AnimatorSprite__DrawFrame
_02159EFC:
	pop {r3, r4, r5, pc}
	nop
_02159F00: .word StageClear__Singleton
_02159F04: .word 0x00000D98
	thumb_func_end StageClear__RankDisplay__Main_Idle

	thumb_func_start StageClearMaterialRewardFX__Create
StageClearMaterialRewardFX__Create: // 0x02159F08
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x10
	ldr r0, _02159FF8 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02159F1C
	bl DestroyCurrentTask
	add sp, #0x10
	pop {r3, r4, r5, r6, r7, pc}
_02159F1C:
	bl GetTaskWork_
	ldr r1, _02159FFC // =0x00000EEC
	str r0, [sp, #0xc]
	add r4, r0, r1
	bl StageClear__MaterialRewardFX__Func_2158A8C
	mov r1, #0xe9
	lsl r1, r1, #2
	strh r0, [r4, r1]
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #4]
	cmp r0, #6
	bne _02159F56
	ldr r0, [sp, #0xc]
	bl StageClear__MaterialRewardFX__Func_21588D4
	mov r1, #0
	mov r0, #0x85
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215A000 // =StageClearMaterialRewardFX__Main1
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	add sp, #0x10
	pop {r3, r4, r5, r6, r7, pc}
_02159F56:
	cmp r0, #5
	bne _02159FF2
	mov r3, #0
	mov r5, r4
	mov r6, r3
	mov r7, #0x78
_02159F62:
	mov r0, #0x8d
	lsl r0, r0, #2
	mov r1, r0
	strh r7, [r5, r0]
	sub r1, #0xa9
	add r0, r0, #2
	strh r1, [r5, r0]
	mov r0, #0xe9
	lsl r0, r0, #2
	ldrh r0, [r4, r0]
	mov r1, #0xc0
	lsr r2, r6, #2
	sub r0, r0, #1
	mul r1, r0
	asr r0, r1, #1
	lsr r0, r0, #0x1e
	add r0, r1, r0
	asr r1, r0, #2
	lsr r0, r1, #0x1f
	add r0, r1, r0
	add r2, #0x80
	asr r0, r0, #1
	sub r1, r2, r0
	mov r0, #0x92
	lsl r0, r0, #2
	strh r1, [r5, r0]
	mov r1, #0x60
	add r0, r0, #2
	strh r1, [r5, r0]
	add r3, r3, #1
	add r5, r5, #4
	add r6, #0xc0
	cmp r3, #5
	blo _02159F62
	ldr r0, _0215A004 // =0x0000126C
	mov r1, #0
	strh r1, [r4, r0]
	ldr r0, _0215A008 // =StageClear__MaterialRewardFX__Main_215A014
	bl SetCurrentTaskMainEvent
	mov r1, #0
	mov r0, #0x46
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215A00C // =StageClearMaterialRewardFX__Main2
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	mov r1, #0
	mov r0, #0x85
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215A000 // =StageClearMaterialRewardFX__Main1
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	ldr r1, _0215A010 // =0x00002CBC
	ldr r0, [sp, #0xc]
	ldr r0, [r0, r1]
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02159FF2:
	add sp, #0x10
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02159FF8: .word StageClear__Singleton
_02159FFC: .word 0x00000EEC
_0215A000: .word StageClearMaterialRewardFX__Main1
_0215A004: .word 0x0000126C
_0215A008: .word StageClear__MaterialRewardFX__Main_215A014
_0215A00C: .word StageClearMaterialRewardFX__Main2
_0215A010: .word 0x00002CBC
	thumb_func_end StageClearMaterialRewardFX__Create

	thumb_func_start StageClear__MaterialRewardFX__Main_215A014
StageClear__MaterialRewardFX__Main_215A014: // 0x0215A014
	push {r3, lr}
	ldr r0, _0215A060 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A024
	bl DestroyCurrentTask
	pop {r3, pc}
_0215A024:
	bl GetTaskWork_
	ldr r1, _0215A064 // =0x00000EEC
	ldr r2, [r0, #4]
	add r1, r0, r1
	cmp r2, #6
	bne _0215A038
	bl StageClear__MaterialRewardFX__Func_21588D4
	pop {r3, pc}
_0215A038:
	ldr r0, _0215A068 // =0x0000126C
	ldrh r2, [r1, r0]
	add r2, r2, #1
	strh r2, [r1, r0]
	ldrh r2, [r1, r0]
	cmp r2, #0x40
	blo _0215A052
	mov r2, #0
	strh r2, [r1, r0]
	ldr r0, _0215A06C // =StageClear__MaterialRewardFX__Main_215A070
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_0215A052:
	mov r0, r1
	mov r1, #0
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
	pop {r3, pc}
	nop
_0215A060: .word StageClear__Singleton
_0215A064: .word 0x00000EEC
_0215A068: .word 0x0000126C
_0215A06C: .word StageClear__MaterialRewardFX__Main_215A070
	thumb_func_end StageClear__MaterialRewardFX__Main_215A014

	thumb_func_start StageClear__MaterialRewardFX__Main_215A070
StageClear__MaterialRewardFX__Main_215A070: // 0x0215A070
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _0215A148 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A080
	bl DestroyCurrentTask
	pop {r3, r4, r5, r6, r7, pc}
_0215A080:
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _0215A148 // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215A14C // =0x00000EEC
	add r7, r0, r1
	ldr r0, [r4, #4]
	cmp r0, #6
	bne _0215A0A0
	mov r0, r4
	bl StageClear__MaterialRewardFX__Func_21588D4
	pop {r3, r4, r5, r6, r7, pc}
_0215A0A0:
	ldr r0, _0215A150 // =0x0000126C
	ldrh r0, [r7, r0]
	cmp r0, #0x50
	blo _0215A0D8
	mov r6, #0x92
	lsl r6, r6, #2
	mov r2, r6
	mov r4, r6
	mov r0, #0
	mov r1, r7
	sub r2, #0x14
	add r3, r6, #2
	sub r4, #0x12
_0215A0BA:
	ldrsh r5, [r1, r6]
	add r0, r0, #1
	strh r5, [r1, r2]
	ldrsh r5, [r1, r3]
	strh r5, [r1, r4]
	add r1, r1, #4
	cmp r0, #5
	blo _0215A0BA
	ldr r0, _0215A150 // =0x0000126C
	mov r1, #0
	strh r1, [r7, r0]
	ldr r0, _0215A154 // =StageClear__MaterialRewardFX__Main_215A15C
	bl SetCurrentTaskMainEvent
	pop {r3, r4, r5, r6, r7, pc}
_0215A0D8:
	mov r1, #0
	mov r0, r7
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
	mov r5, #0
	mov r4, r7
_0215A0E6:
	ldr r0, _0215A150 // =0x0000126C
	ldrh r1, [r7, r0]
	mov r0, #0xa
	mul r0, r5
	sub r0, r1, r0
	bpl _0215A0F6
	mov r0, #0
	b _0215A0FC
_0215A0F6:
	cmp r0, #0x28
	ble _0215A0FC
	mov r0, #0x28
_0215A0FC:
	lsl r0, r0, #0xc
	mov r1, #0x28
	bl _s32_div_f
	mov r6, r0
	mov r1, #0x92
	lsl r1, r1, #2
	lsl r2, r6, #0x10
	ldrsh r1, [r4, r1]
	mov r0, #0x78
	asr r2, r2, #0x10
	mov r3, #3
	bl StageClear__Func_2158F14
	mov r1, #0x8d
	lsl r1, r1, #2
	strh r0, [r4, r1]
	mov r0, r1
	add r1, #0x16
	lsl r2, r6, #0x10
	ldrsh r1, [r4, r1]
	sub r0, #0xa9
	asr r2, r2, #0x10
	mov r3, #3
	bl StageClear__Func_2158F14
	ldr r1, _0215A158 // =0x00000236
	add r5, r5, #1
	strh r0, [r4, r1]
	add r4, r4, #4
	cmp r5, #5
	blo _0215A0E6
	ldr r0, _0215A150 // =0x0000126C
	ldrh r1, [r7, r0]
	add r1, r1, #1
	strh r1, [r7, r0]
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215A148: .word StageClear__Singleton
_0215A14C: .word 0x00000EEC
_0215A150: .word 0x0000126C
_0215A154: .word StageClear__MaterialRewardFX__Main_215A15C
_0215A158: .word 0x00000236
	thumb_func_end StageClear__MaterialRewardFX__Main_215A070

	thumb_func_start StageClear__MaterialRewardFX__Main_215A15C
StageClear__MaterialRewardFX__Main_215A15C: // 0x0215A15C
	push {r3, r4, r5, lr}
	ldr r0, _0215A1BC // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A16C
	bl DestroyCurrentTask
	pop {r3, r4, r5, pc}
_0215A16C:
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _0215A1BC // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215A1C0 // =0x00000EEC
	add r5, r0, r1
	ldr r0, [r4, #4]
	cmp r0, #6
	bne _0215A18C
	mov r0, r4
	bl StageClear__MaterialRewardFX__Func_21588D4
	pop {r3, r4, r5, pc}
_0215A18C:
	ldr r0, _0215A1C4 // =0x0000126C
	ldrh r0, [r5, r0]
	cmp r0, #0x28
	blo _0215A1A8
	ldr r0, _0215A1BC // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #7
	str r1, [r0, #4]
	mov r0, r4
	bl StageClear__MaterialRewardFX__Func_21588D4
	pop {r3, r4, r5, pc}
_0215A1A8:
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
	ldr r0, _0215A1C4 // =0x0000126C
	ldrh r1, [r5, r0]
	add r1, r1, #1
	strh r1, [r5, r0]
	pop {r3, r4, r5, pc}
	.align 2, 0
_0215A1BC: .word StageClear__Singleton
_0215A1C0: .word 0x00000EEC
_0215A1C4: .word 0x0000126C
	thumb_func_end StageClear__MaterialRewardFX__Main_215A15C

	thumb_func_start StageClear__MaterialRewardFX__Main_215A1C8
StageClear__MaterialRewardFX__Main_215A1C8: // 0x0215A1C8
	push {r3, lr}
	ldr r0, _0215A1FC // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A1D8
	bl DestroyCurrentTask
	pop {r3, pc}
_0215A1D8:
	bl GetTaskWork_
	ldr r1, _0215A200 // =0x00000EEC
	add r3, r0, r1
	mov r0, #0x3a
	lsl r0, r0, #4
	ldr r2, [r3, r0]
	ldr r0, _0215A204 // =0x0000126C
	ldrh r1, [r3, r0]
	cmp r2, r1
	bhi _0215A1F6
	ldr r0, _0215A208 // =StageClear__MaterialRewardFX__Main_215A20C
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
_0215A1F6:
	add r1, r1, #1
	strh r1, [r3, r0]
	pop {r3, pc}
	.align 2, 0
_0215A1FC: .word StageClear__Singleton
_0215A200: .word 0x00000EEC
_0215A204: .word 0x0000126C
_0215A208: .word StageClear__MaterialRewardFX__Main_215A20C
	thumb_func_end StageClear__MaterialRewardFX__Main_215A1C8

	thumb_func_start StageClear__MaterialRewardFX__Main_215A20C
StageClear__MaterialRewardFX__Main_215A20C: // 0x0215A20C
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _0215A298 // =StageClear__Singleton
	mov r7, #0
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A21E
	bl DestroyCurrentTask
	pop {r3, r4, r5, r6, r7, pc}
_0215A21E:
	bl GetTaskWork_
	ldr r1, _0215A29C // =0x00000EEC
	add r0, r0, r1
	mov r1, #0x97
	lsl r1, r1, #2
	add r4, r0, r1
	mov r1, #0x3a
	lsl r1, r1, #4
	add r6, r0, r1
	str r0, [sp]
	cmp r4, r6
	beq _0215A270
_0215A238:
	ldr r5, [r4, #0x64]
	mov r0, r5
	bl _dflt
	mov r2, r0
	mov r3, r1
	ldr r0, _0215A2A0 // =0x66666666
	ldr r1, _0215A2A4 // =0x40C66666
	bl _dleq
	bhs _0215A256
	mov r0, #0
	str r0, [r4, #0x64]
	str r0, [r4, #0x68]
	b _0215A26A
_0215A256:
	cmp r5, #0
	bne _0215A260
	ldr r0, [r4, #0x68]
	cmp r0, #0
	beq _0215A26A
_0215A260:
	ldr r1, [r4, #0x64]
	ldr r0, [r4, #0x68]
	mov r7, #1
	add r0, r1, r0
	str r0, [r4, #0x64]
_0215A26A:
	add r4, #0x6c
	cmp r4, r6
	bne _0215A238
_0215A270:
	cmp r7, #0
	bne _0215A296
	mov r1, #0xb2
	ldr r0, [sp]
	lsl r1, r1, #2
	add r2, r0, r1
	mov r3, #0
	str r3, [r2, #0x64]
	mov r0, #0x7a
	str r0, [r2, #0x68]
	ldr r0, [sp]
	mov r2, #0x40
	add r1, #0xd8
	str r2, [r0, r1]
	ldr r1, _0215A2A8 // =0x0000126C
	strh r3, [r0, r1]
	ldr r0, _0215A2AC // =StageClear__MaterialRewardFX__Main_215A1C8
	bl SetCurrentTaskMainEvent
_0215A296:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215A298: .word StageClear__Singleton
_0215A29C: .word 0x00000EEC
_0215A2A0: .word 0x66666666
_0215A2A4: .word 0x40C66666
_0215A2A8: .word 0x0000126C
_0215A2AC: .word StageClear__MaterialRewardFX__Main_215A1C8
	thumb_func_end StageClear__MaterialRewardFX__Main_215A20C

	thumb_func_start Task__OVL03Unknown215896C__Main
Task__OVL03Unknown215896C__Main: // 0x0215A2B0
	push {r3, lr}
	ldr r0, _0215A2F4 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A2C0
	bl DestroyCurrentTask
	pop {r3, pc}
_0215A2C0:
	bl GetTaskWork_
	ldr r1, _0215A2F8 // =0x00000EEC
	add r2, r0, r1
	ldr r1, _0215A2FC // =0x000003AA
	add r0, r2, r1
	sub r1, r1, #6
	ldrh r2, [r2, r1]
	mov r1, #0xe
	mul r1, r2
	add r3, r0, r1
	cmp r0, r3
	beq _0215A2F0
_0215A2DA:
	ldrh r2, [r0, #4]
	ldrh r1, [r0, #8]
	add r1, r2, r1
	strh r1, [r0, #4]
	ldrh r2, [r0, #6]
	ldrh r1, [r0, #0xa]
	add r1, r2, r1
	strh r1, [r0, #6]
	add r0, #0xe
	cmp r0, r3
	bne _0215A2DA
_0215A2F0:
	pop {r3, pc}
	nop
_0215A2F4: .word StageClear__Singleton
_0215A2F8: .word 0x00000EEC
_0215A2FC: .word 0x000003AA
	thumb_func_end Task__OVL03Unknown215896C__Main

	thumb_func_start StageClearMaterialRewardFX__Main2
StageClearMaterialRewardFX__Main2: // 0x0215A300
	push {r4, lr}
	ldr r0, _0215A34C // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A310
	bl DestroyCurrentTask
	pop {r4, pc}
_0215A310:
	bl GetTaskWork_
	ldr r1, _0215A350 // =0x00000EEC
	add r4, r0, r1
	bl RenderCore_GetDMARenderCount
	mov r1, #0xe9
	lsl r1, r1, #2
	ldrh r1, [r4, r1]
	bl _u32_div_f
	lsl r0, r1, #2
	add r2, r4, r0
	mov r0, #0x8d
	lsl r0, r0, #2
	ldrsh r1, [r2, r0]
	add r0, r0, #2
	lsl r3, r1, #0xc
	ldr r1, _0215A354 // =0x00001254
	str r3, [r4, r1]
	ldrsh r0, [r2, r0]
	lsl r2, r0, #0xc
	add r0, r1, #4
	str r2, [r4, r0]
	mov r0, #0x3f
	lsl r0, r0, #4
	add r0, r4, r0
	bl StageClear__Func_21590CC
	pop {r4, pc}
	.align 2, 0
_0215A34C: .word StageClear__Singleton
_0215A350: .word 0x00000EEC
_0215A354: .word 0x00001254
	thumb_func_end StageClearMaterialRewardFX__Main2

	thumb_func_start StageClearMaterialRewardFX__Main1
StageClearMaterialRewardFX__Main1: // 0x0215A358
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x20
	ldr r0, _0215A564 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A36C
	bl DestroyCurrentTask
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
_0215A36C:
	bl GetTaskWork_
	ldr r1, _0215A568 // =0x00000EEC
	str r0, [sp, #4]
	add r6, r0, r1
	mov r0, #0xe9
	lsl r0, r0, #2
	ldrh r0, [r6, r0]
	mov r7, #0
	cmp r0, #0
	bls _0215A41C
	mov r0, #0x8d
	lsl r0, r0, #2
	add r5, r6, r0
	mov r0, #1
	str r0, [sp, #0x10]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #1
	mov r4, r6
	str r0, [sp, #0x18]
	mov r0, #2
	add r4, #0x64
	str r0, [sp, #0x14]
_0215A39C:
	mov r0, #2
	ldrsh r0, [r5, r0]
	cmp r0, #0xe8
	bgt _0215A3C6
	mov r0, #0
	ldrsh r1, [r5, r0]
	mov r0, r6
	add r0, #0x6c
	strh r1, [r0]
	mov r0, #2
	ldrsh r1, [r5, r0]
	mov r0, r6
	add r0, #0x6e
	strh r1, [r0]
	ldr r1, [r4, #0]
	mov r0, #1
	orr r1, r0
	ldr r0, [sp, #0xc]
	bic r1, r0
	str r1, [r4]
	b _0215A3EC
_0215A3C6:
	mov r0, #0
	ldrsh r1, [r5, r0]
	mov r0, r6
	add r0, #0x68
	strh r1, [r0]
	mov r0, #2
	ldrsh r1, [r5, r0]
	mov r0, #0x11
	lsl r0, r0, #4
	sub r1, r1, r0
	mov r0, r6
	add r0, #0x6a
	strh r1, [r0]
	ldr r1, [r4, #0]
	ldr r0, [sp, #0x10]
	bic r1, r0
	mov r0, #2
	orr r0, r1
	str r0, [r4]
_0215A3EC:
	ldr r0, [sp, #4]
	ldr r0, [r0, #0]
	cmp r0, #2
	bne _0215A3FC
	ldr r1, [r4, #0]
	mov r0, #1
	orr r0, r1
	str r0, [r4]
_0215A3FC:
	mov r0, r6
	bl AnimatorSpriteDS__DrawFrame
	ldr r1, [r4, #0]
	ldr r0, [sp, #0x18]
	add r7, r7, #1
	bic r1, r0
	ldr r0, [sp, #0x14]
	add r5, r5, #4
	bic r1, r0
	mov r0, #0xe9
	str r1, [r4]
	lsl r0, r0, #2
	ldrh r0, [r6, r0]
	cmp r7, r0
	blo _0215A39C
_0215A41C:
	mov r0, #0
	str r0, [sp]
	mov r0, #0x97
	lsl r0, r0, #2
	add r5, r6, r0
	mov r7, r6
_0215A428:
	mov r0, #0x80
	strh r0, [r5, #8]
	mov r0, #0x60
	strh r0, [r5, #0xa]
	mov r0, #0xb
	lsl r0, r0, #6
	ldr r4, [r7, r0]
	cmp r4, #0
	ble _0215A4BE
	mov r0, #1
	lsl r0, r0, #0xc
	cmp r4, r0
	ldr r1, [r5, #0x3c]
	ble _0215A44A
	lsr r0, r0, #3
	orr r0, r1
	b _0215A44E
_0215A44A:
	ldr r0, _0215A56C // =0xFFFFFDFF
	and r0, r1
_0215A44E:
	str r0, [r5, #0x3c]
	mov r0, r5
	mov r1, r4
	mov r2, r4
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	mov r3, #1
	mov r0, r5
	mov r1, r4
	mov r2, r4
	lsl r3, r3, #0xe
	bl AnimatorSprite__DrawFrameRotoZoom
	mov r3, #2
	mov r0, r5
	mov r1, r4
	mov r2, r4
	lsl r3, r3, #0xe
	bl AnimatorSprite__DrawFrameRotoZoom
	mov r3, #3
	mov r0, r5
	mov r1, r4
	mov r2, r4
	lsl r3, r3, #0xe
	bl AnimatorSprite__DrawFrameRotoZoom
	mov r0, r5
	add r0, #0x57
	ldrb r0, [r0, #0]
	mov r3, #6
	mov r2, r4
	add r1, r0, #3
	mov r0, r5
	add r0, #0x57
	strb r1, [r0]
	mov r0, r5
	mov r1, r4
	lsl r3, r3, #0xc
	bl AnimatorSprite__DrawFrameRotoZoom
	mov r3, #0xe
	mov r0, r5
	mov r1, r4
	mov r2, r4
	lsl r3, r3, #0xc
	bl AnimatorSprite__DrawFrameRotoZoom
	mov r0, r5
	add r0, #0x57
	ldrb r0, [r0, #0]
	sub r1, r0, #3
	mov r0, r5
	add r0, #0x57
	strb r1, [r0]
_0215A4BE:
	ldr r0, [sp]
	add r5, #0x6c
	add r0, r0, #1
	add r7, #0x6c
	str r0, [sp]
	cmp r0, #3
	blo _0215A428
	ldr r0, _0215A570 // =0x000003AA
	mov r7, #0
	add r4, r6, r0
	sub r0, r0, #6
	ldrh r1, [r6, r0]
	mov r0, #0xe
	mul r0, r1
	add r0, r4, r0
	str r0, [sp, #0x1c]
	cmp r4, r0
	beq _0215A53C
	mov r0, r6
	str r0, [sp, #8]
	add r0, #0xa4
	str r0, [sp, #8]
_0215A4EA:
	mov r1, #0xe9
	lsl r1, r1, #2
	ldrh r1, [r6, r1]
	lsl r0, r7, #1
	add r7, r7, #1
	bl _u32_div_f
	mov r1, #0x64
	mul r1, r0
	ldr r0, [sp, #8]
	ldrb r3, [r4, #0xc]
	add r0, r0, r1
	mov r1, #0
	ldrsh r5, [r4, r1]
	ldrh r1, [r4, #4]
	asr r1, r1, #4
	lsl r2, r1, #2
	ldr r1, _0215A574 // =FX_SinCosTable_
	ldrsh r1, [r1, r2]
	mul r1, r3
	asr r1, r1, #0xc
	add r1, r5, r1
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r5, [r4, r1]
	ldrh r1, [r4, #6]
	ldrb r3, [r4, #0xd]
	asr r1, r1, #4
	lsl r2, r1, #2
	ldr r1, _0215A574 // =FX_SinCosTable_
	ldrsh r1, [r1, r2]
	mul r1, r3
	asr r1, r1, #0xc
	add r1, r5, r1
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, [sp, #0x1c]
	add r4, #0xe
	cmp r4, r0
	bne _0215A4EA
_0215A53C:
	mov r0, #0x5b
	lsl r0, r0, #2
	add r4, r6, r0
	add r0, #0xc8
	add r5, r6, r0
	cmp r4, r5
	beq _0215A556
_0215A54A:
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	add r4, #0x64
	cmp r4, r5
	bne _0215A54A
_0215A556:
	mov r0, #0x3f
	lsl r0, r0, #4
	add r0, r6, r0
	bl StageClear__Func_2159288
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215A564: .word StageClear__Singleton
_0215A568: .word 0x00000EEC
_0215A56C: .word 0xFFFFFDFF
_0215A570: .word 0x000003AA
_0215A574: .word FX_SinCosTable_
	thumb_func_end StageClearMaterialRewardFX__Main1

	thumb_func_start StageClearTimeAttackRankList__Main
StageClearTimeAttackRankList__Main: // 0x0215A578
	push {r4, lr}
	ldr r0, _0215A5B8 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A588
	bl DestroyCurrentTask
	pop {r4, pc}
_0215A588:
	bl GetTaskWork_
	ldr r1, _0215A5BC // =0x0000215C
	add r4, r0, r1
	mov r0, #0x65
	lsl r0, r0, #4
	ldrh r1, [r4, r0]
	add r1, r1, #1
	strh r1, [r4, r0]
	ldrh r0, [r4, r0]
	cmp r0, #8
	bls _0215A5B6
	mov r0, r4
	add r0, #0x90
	bl TimeAttackRankList__Func_216F9C0
	mov r0, #0x65
	mov r1, #0
	lsl r0, r0, #4
	strh r1, [r4, r0]
	ldr r0, _0215A5C0 // =StageClearTimeAttackRankList__Main_215A5C4
	bl SetCurrentTaskMainEvent
_0215A5B6:
	pop {r4, pc}
	.align 2, 0
_0215A5B8: .word StageClear__Singleton
_0215A5BC: .word 0x0000215C
_0215A5C0: .word StageClearTimeAttackRankList__Main_215A5C4
	thumb_func_end StageClearTimeAttackRankList__Main

	thumb_func_start StageClearTimeAttackRankList__Main_215A5C4
StageClearTimeAttackRankList__Main_215A5C4: // 0x0215A5C4
	push {r3, lr}
	ldr r0, _0215A608 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A5D4
	bl DestroyCurrentTask
	pop {r3, pc}
_0215A5D4:
	bl GetTaskWork_
	ldr r1, _0215A60C // =0x0000215C
	add r0, r0, r1
	ldr r1, _0215A610 // =padInput
	ldrh r2, [r1, #4]
	ldr r1, _0215A614 // =0x00000C03
	tst r1, r2
	bne _0215A5F6
	mov r1, #0x65
	lsl r1, r1, #4
	ldrh r2, [r0, r1]
	add r2, r2, #1
	strh r2, [r0, r1]
	ldrh r1, [r0, r1]
	cmp r1, #0xd7
	bls _0215A604
_0215A5F6:
	mov r1, #0x65
	mov r2, #0
	lsl r1, r1, #4
	strh r2, [r0, r1]
	ldr r0, _0215A618 // =StageClearTimeAttackRankList__Main_215A61C
	bl SetCurrentTaskMainEvent
_0215A604:
	pop {r3, pc}
	nop
_0215A608: .word StageClear__Singleton
_0215A60C: .word 0x0000215C
_0215A610: .word padInput
_0215A614: .word 0x00000C03
_0215A618: .word StageClearTimeAttackRankList__Main_215A61C
	thumb_func_end StageClearTimeAttackRankList__Main_215A5C4

	thumb_func_start StageClearTimeAttackRankList__Main_215A61C
StageClearTimeAttackRankList__Main_215A61C: // 0x0215A61C
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _0215A6A4 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A62C
	bl DestroyCurrentTask
	pop {r3, r4, r5, r6, r7, pc}
_0215A62C:
	bl GetTaskWork_
	ldr r1, _0215A6A8 // =0x0000215C
	add r1, r0, r1
	str r1, [sp]
	ldr r1, _0215A6AC // =padInput
	ldrh r2, [r1, #4]
	ldr r1, _0215A6B0 // =0x00000C03
	tst r1, r2
	bne _0215A654
	mov r2, #0x65
	ldr r1, [sp]
	lsl r2, r2, #4
	ldrh r1, [r1, r2]
	add r3, r1, #1
	ldr r1, [sp]
	strh r3, [r1, r2]
	ldrh r1, [r1, r2]
	cmp r1, #0xb5
	bls _0215A6A0
_0215A654:
	ldr r1, _0215A6B4 // =0x00000E7C
	ldr r4, [sp]
	ldrh r2, [r0, r1]
	ldr r1, _0215A6B8 // =0x00000564
	add r4, #0x90
	strh r2, [r4, r1]
	ldr r6, [r0, #8]
	mov r5, #0
	lsl r0, r6, #0x18
	lsr r7, r0, #0x18
_0215A668:
	bl StageClear__GetTimeAttackStageID
	add r3, r5, #1
	mov r2, r0
	lsl r3, r3, #0x18
	ldr r0, _0215A6BC // =saveGame+0x00000898
	mov r1, r7
	lsr r3, r3, #0x18
	bl SaveGame__GetTimeAttackRecord
	lsl r1, r5, #0x10
	mov r2, r0
	mov r0, r4
	lsr r1, r1, #0x10
	mov r3, r6
	bl TimeAttackRankList__SetRecord
	add r5, r5, #1
	cmp r5, #5
	blo _0215A668
	ldr r0, [sp]
	ldr r1, [sp]
	add r0, #0x90
	add r1, r1, #4
	bl TimeAttackRankList__InitRecords
	bl DestroyCurrentTask
_0215A6A0:
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215A6A4: .word StageClear__Singleton
_0215A6A8: .word 0x0000215C
_0215A6AC: .word padInput
_0215A6B0: .word 0x00000C03
_0215A6B4: .word 0x00000E7C
_0215A6B8: .word 0x00000564
_0215A6BC: .word saveGame+0x00000898
	thumb_func_end StageClearTimeAttackRankList__Main_215A61C

	thumb_func_start Task__OVL03Unknown2158C6C__Main
Task__OVL03Unknown2158C6C__Main: // 0x0215A6C0
	push {r3, r4, lr}
	sub sp, #0x1c
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #4]
	cmp r0, #0
	bne _0215A6D8
	bl DestroyCurrentTask
	add sp, #0x1c
	pop {r3, r4, pc}
_0215A6D8:
	ldr r0, [r4, #0xc]
	cmp r0, #0
	bne _0215A6E8
	ldr r0, _0215A740 // =Task__Unknown2158C6C__Main_215A748
	bl SetCurrentTaskMainEvent
	add sp, #0x1c
	pop {r3, r4, pc}
_0215A6E8:
	ldr r0, [r4, #0]
	sub r0, r0, #1
	str r0, [r4]
	bne _0215A73C
	ldr r0, _0215A744 // =StageClear__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	ldr r1, [r4, #8]
	mov r3, #7
	str r1, [sp, #8]
	ldr r0, [r0, #0x34]
	mov r1, #2
	str r0, [sp, #0xc]
	mov r0, #9
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r0, [r4, #4]
	bl SaveSpriteButton__Func_20651D4
	mov r1, #0
	mov r2, r1
	ldr r0, [r4, #4]
	sub r2, #0x10
	bl SaveSpriteButton__Func_20653AC
	ldr r0, [r4, #4]
	bl SaveSpriteButton__RunState2
	ldr r0, [r4, #8]
	bl FontWindow__PrepareSwapBuffer
	mov r0, #5
	bl PlaySysSfx
	ldr r0, _0215A740 // =Task__Unknown2158C6C__Main_215A748
	bl SetCurrentTaskMainEvent
_0215A73C:
	add sp, #0x1c
	pop {r3, r4, pc}
	.align 2, 0
_0215A740: .word Task__Unknown2158C6C__Main_215A748
_0215A744: .word StageClear__Singleton
	thumb_func_end Task__OVL03Unknown2158C6C__Main

	thumb_func_start Task__Unknown2158C6C__Main_215A748
Task__Unknown2158C6C__Main_215A748: // 0x0215A748
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #4]
	cmp r0, #0
	bne _0215A75C
	bl DestroyCurrentTask
	pop {r4, pc}
_0215A75C:
	ldr r1, [r4, #0xc]
	cmp r1, #0
	bne _0215A774
	ldr r0, _0215A7A8 // =padInput
	ldrh r1, [r0, #4]
	ldr r0, _0215A7AC // =0x00000C03
	tst r0, r1
	beq _0215A7A6
	mov r0, #1
	bl StageClear__StartFadeOut
	pop {r4, pc}
_0215A774:
	bl SaveSpriteButton__RunState2
	ldr r0, [r4, #8]
	bl FontWindow__PrepareSwapBuffer
	ldr r0, [r4, #4]
	bl SaveSpriteButton__CheckInvalidState2
	cmp r0, #0
	beq _0215A7A6
	ldr r0, [r4, #4]
	bl SaveSpriteButton__Func_2065498
	cmp r0, #0
	beq _0215A798
	cmp r0, #1
	beq _0215A7A0
	pop {r4, pc}
_0215A798:
	mov r0, #2
	bl StageClear__StartFadeOut
	pop {r4, pc}
_0215A7A0:
	mov r0, #1
	bl StageClear__StartFadeOut
_0215A7A6:
	pop {r4, pc}
	.align 2, 0
_0215A7A8: .word padInput
_0215A7AC: .word 0x00000C03
	thumb_func_end Task__Unknown2158C6C__Main_215A748

	thumb_func_start StageClearMissionClearText__Main1
StageClearMissionClearText__Main1: // 0x0215A7B0
	push {r4, r5, lr}
	sub sp, #0x14
	ldr r0, _0215A83C // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A7C4
	bl DestroyCurrentTask
	add sp, #0x14
	pop {r4, r5, pc}
_0215A7C4:
	bl GetTaskWork_
	ldr r4, _0215A840 // =0x00002BE4
	mov r5, r0
	ldr r0, [r5, r4]
	cmp r0, #0
	beq _0215A830
	mov r0, #0x20
	str r0, [sp]
	mov r0, #0x80
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	ldr r0, _0215A844 // =StageClearHeader__MoverCallback
	mov r1, #2
	str r0, [sp, #0xc]
	add r0, r5, r4
	add r0, #0xcc
	str r0, [sp, #0x10]
	add r0, r5, r4
	mov r2, r1
	add r0, #0xc
	sub r2, #0xaa
	mov r3, #0x58
	bl StageClearMover__Create
	add r1, r5, r4
	add r1, #0xcc
	str r0, [r1]
	mov r0, #0x38
	str r0, [sp]
	mov r0, #0x80
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	ldr r0, _0215A844 // =StageClearHeader__MoverCallback
	mov r1, #2
	str r0, [sp, #0xc]
	add r0, r5, r4
	add r0, #0xd0
	str r0, [sp, #0x10]
	add r0, r5, r4
	mov r2, r1
	add r0, #0x70
	sub r2, #0xaa
	mov r3, #0x58
	bl StageClearMover__Create
	add r1, r5, r4
	add r1, #0xd0
	str r0, [r1]
	ldr r0, _0215A848 // =StageClearMissionClearText__Main_215A84C
	bl SetCurrentTaskMainEvent
_0215A830:
	ldr r0, [r5, r4]
	add r0, r0, #1
	str r0, [r5, r4]
	add sp, #0x14
	pop {r4, r5, pc}
	nop
_0215A83C: .word StageClear__Singleton
_0215A840: .word 0x00002BE4
_0215A844: .word StageClearHeader__MoverCallback
_0215A848: .word StageClearMissionClearText__Main_215A84C
	thumb_func_end StageClearMissionClearText__Main1

	thumb_func_start StageClearMissionClearText__Main_215A84C
StageClearMissionClearText__Main_215A84C: // 0x0215A84C
	push {r3, lr}
	ldr r0, _0215A884 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A85C
	bl DestroyCurrentTask
	pop {r3, pc}
_0215A85C:
	bl GetTaskWork_
	ldr r1, _0215A888 // =0x00002CB4
	ldr r1, [r0, r1]
	cmp r1, #0
	bne _0215A872
	mov r1, #7
	str r1, [r0, #4]
	bl DestroyCurrentTask
	pop {r3, pc}
_0215A872:
	ldr r1, [r0, #4]
	cmp r1, #6
	bne _0215A880
	bl StageClearMissionClearText__Func_215950C
	bl DestroyCurrentTask
_0215A880:
	pop {r3, pc}
	nop
_0215A884: .word StageClear__Singleton
_0215A888: .word 0x00002CB4
	thumb_func_end StageClearMissionClearText__Main_215A84C

	thumb_func_start StageClearMissionClearText__Main2
StageClearMissionClearText__Main2: // 0x0215A88C
	push {r4, lr}
	ldr r0, _0215A8B4 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A89C
	bl DestroyCurrentTask
	pop {r4, pc}
_0215A89C:
	bl GetTaskWork_
	ldr r1, _0215A8B8 // =0x00002BE4
	add r4, r0, r1
	add r0, r4, #4
	bl AnimatorSprite__DrawFrame
	add r4, #0x68
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	pop {r4, pc}
	.align 2, 0
_0215A8B4: .word StageClear__Singleton
_0215A8B8: .word 0x00002BE4
	thumb_func_end StageClearMissionClearText__Main2

	thumb_func_start StageClearMover__Main
StageClearMover__Main: // 0x0215A8BC
	push {r4, r5, r6, lr}
	sub sp, #8
	ldr r0, _0215A984 // =StageClear__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215A8D0
	bl DestroyCurrentTask
	add sp, #8
	pop {r4, r5, r6, pc}
_0215A8D0:
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #0xc
	ldrsh r0, [r4, r0]
	mov r1, #1
	lsl r1, r1, #0xc
	str r0, [sp]
	cmp r0, r1
	blt _0215A8EC
	bl DestroyCurrentTask
	add sp, #8
	pop {r4, r5, r6, pc}
_0215A8EC:
	ldrh r6, [r4, #0x10]
	cmp r6, #0
	beq _0215A928
	mov r1, #6
	mov r0, #8
	ldrsh r5, [r4, r1]
	ldr r1, [sp]
	ldrsh r0, [r4, r0]
	asr r1, r1, #0x1f
	str r1, [sp, #4]
_0215A900:
	sub r0, r0, r5
	ldr r2, [sp]
	ldr r3, [sp, #4]
	asr r1, r0, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _0215A988 // =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	add r0, r5, r1
	mov r1, r6
	sub r6, r6, #1
	cmp r1, #0
	bne _0215A900
	b _0215A94E
_0215A928:
	mov r0, #6
	ldrsh r5, [r4, r0]
	mov r0, #8
	ldrsh r0, [r4, r0]
	ldr r2, [sp]
	sub r0, r0, r5
	asr r1, r0, #0x1f
	asr r3, r2, #0x1f
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	add r0, r5, r1
_0215A94E:
	mov r1, #4
	ldrsh r1, [r4, r1]
	cmp r1, #2
	bne _0215A95C
	ldr r1, [r4, #0]
	strh r0, [r1]
	b _0215A964
_0215A95C:
	cmp r1, #4
	bne _0215A964
	ldr r1, [r4, #0]
	str r0, [r1]
_0215A964:
	ldrh r0, [r4, #0xa]
	cmp r0, #0
	beq _0215A972
	sub r0, r0, #1
	add sp, #8
	strh r0, [r4, #0xa]
	pop {r4, r5, r6, pc}
_0215A972:
	mov r0, #0xc
	ldrsh r1, [r4, r0]
	mov r0, #0xe
	ldrsh r0, [r4, r0]
	add r0, r1, r0
	strh r0, [r4, #0xc]
	add sp, #8
	pop {r4, r5, r6, pc}
	nop
_0215A984: .word StageClear__Singleton
_0215A988: .word 0x00000000
	thumb_func_end StageClearMover__Main
	
	.data

aCldmCldmFixBac: // 0x0217E5F0
	.asciz "/cldm/cldm_fix.bac"
	.align 4
	
aCldmCldmBaseBb: // 0x0217E604
	.asciz "/cldm/cldm_base.bbg"
	.align 4
	
aCldmCldmBsd: // 0x0217E618
	.asciz "/cldm/cldm.bsd"
	.align 4
	
aNarcCldmTimeLz: // 0x0217E628
	.asciz "/narc/cldm_time_lz7.narc"
	.align 4
	
aBbCldmLangBb: // 0x0217E644
	.asciz "/bb/cldm_lang.bb"
	.align 4
	
aBbDmtaMenuBb_ovl03: // 0x0217E658
	.asciz "/bb/dmta_menu.bb"
	.align 4
	
aNarcCldmMtralL: // 0x0217E66C
	.asciz "/narc/cldm_mtral_lz7.narc"
	.align 4
	
aAcEffGoalJewel_0: // 0x0217E688
	.asciz "/ac_eff_goal_jewel.bac"
	.align 4
	
aNarcCldmMissio: // 0x0217E6A0
	.asciz "/narc/cldm_mission_lz7.narc"
	.align 4
	
aFntFontIplFnt_0: // 0x0217E6BC
	.asciz "/fnt/font_ipl.fnt"
	.align 4
	
aFntFontAllFnt_2_ovl03: // 0x0217E6D0
	.asciz "/fnt/font_all.fnt"
	.align 4
