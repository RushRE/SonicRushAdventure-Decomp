	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public VSStageSelect__sVars
VSStageSelect__sVars: // 0x0217EFD4
	.space 0x04 // VSStageSelect*

	.text

	thumb_func_start VSStageSelectMenu__Alloc
VSStageSelectMenu__Alloc: // 0x02160A8C
	push {r3, lr}
	ldr r0, _02160AA0 // =0x00000658
	bl _AllocHeadHEAP_SYSTEM
	ldr r1, _02160AA4 // =VSStageSelect__sVars
	str r0, [r1]
	bl VSStageSelectMenu__Init
	pop {r3, pc}
	nop
_02160AA0: .word 0x00000658
_02160AA4: .word VSStageSelect__sVars
	thumb_func_end VSStageSelectMenu__Alloc

	thumb_func_start VSStageSelectMenu__Release
VSStageSelectMenu__Release: // 0x02160AA8
	push {r3, lr}
	ldr r0, _02160AC4 // =VSStageSelect__sVars
	ldr r0, [r0]
	bl VSStageSelectMenu__Free
	ldr r0, _02160AC4 // =VSStageSelect__sVars
	ldr r0, [r0]
	bl _FreeHEAP_SYSTEM
	ldr r0, _02160AC4 // =VSStageSelect__sVars
	mov r1, #0
	str r1, [r0]
	pop {r3, pc}
	nop
_02160AC4: .word VSStageSelect__sVars
	thumb_func_end VSStageSelectMenu__Release

	thumb_func_start VSStageSelectMenu__Create
VSStageSelectMenu__Create: // 0x02160AC8
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r6, r0
	ldr r0, _02160C04 // =VSStageSelect__sVars
	ldr r5, [r0]
	mov r4, r5
	ldr r0, [r5, #0x18]
	add r4, #0x20
	cmp r0, #0
	beq _02160AE4
	mov r0, #4
	add sp, #0xc
	str r0, [r4]
	pop {r4, r5, r6, r7, pc}
_02160AE4:
	mov r0, #1
	mov r7, r6
	and r7, r0
	bne _02160B04
	bl VSLobbyMenu__Func_2163DF4
	cmp r0, #0
	beq _02160B04
	mov r0, #0xb
	mov r1, #0
	bl VSLobbyMenu__Func_2163CE0
	mov r0, #2
	add sp, #0xc
	str r0, [r4]
	pop {r4, r5, r6, r7, pc}
_02160B04:
	cmp r7, #0
	beq _02160B10
	mov r0, r5
	add r0, #0x20
	bl VSStageSelectMenu__Unknown__Func_2160D04
_02160B10:
	ldr r0, _02160C08 // =0x00003041
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02160C0C // =VSStageSelectMenu__Main1
	str r1, [sp, #8]
	mov r2, r1
	mov r3, r1
	bl TaskCreate_
	mov r1, #0
	str r0, [r5]
	ldr r0, _02160C10 // =0x00003002
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02160C14 // =VSStageSelectMenu__Main2
	str r1, [sp, #8]
	mov r3, r1
	bl TaskCreate_
	mov r1, #0
	str r0, [r5, #4]
	ldr r0, _02160C18 // =0x00003081
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02160C1C // =VSStageSelectMenu__Main3
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	str r0, [r5, #8]
	ldr r1, _02160C20 // =VSStageSelectMenu__State_Init
	mov r0, r5
	bl VSStageSelectMenu__SetState
	mov r0, #1
	str r0, [r4]
	str r6, [r4, #0x10]
	mov r0, #0
	strh r0, [r4, #0xc]
	strb r0, [r4, #4]
	strb r0, [r4, #5]
	bl VSLobbyMenu__Func_2163DAC
	mov r5, r0
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	beq _02160BA0
	mov r0, #0xa
	strb r0, [r4, #6]
	mov r0, #3
	strb r0, [r4, #7]
	ldr r2, _02160C24 // =0x0217DD64
	mov r1, #0
	mov r0, #1
_02160B84:
	mov r3, r0
	lsl r3, r1
	tst r3, r5
	beq _02160B96
	ldrb r3, [r2]
	add r6, r4, r3
	ldrb r3, [r6, #0x14]
	add r3, r3, #1
	strb r3, [r6, #0x14]
_02160B96:
	add r1, r1, #1
	add r2, r2, #1
	cmp r1, #0x11
	blo _02160B84
	b _02160BC8
_02160BA0:
	mov r0, #4
	strb r0, [r4, #6]
	mov r0, #2
	strb r0, [r4, #7]
	ldr r1, _02160C28 // =0x0217DD54
	mov r2, #0
	mov r0, #1
_02160BAE:
	mov r3, r0
	lsl r3, r2
	tst r3, r5
	beq _02160BC0
	ldrb r3, [r1]
	add r6, r4, r3
	ldrb r3, [r6, #0x14]
	add r3, r3, #1
	strb r3, [r6, #0x14]
_02160BC0:
	add r2, r2, #1
	add r1, r1, #1
	cmp r2, #4
	blo _02160BAE
_02160BC8:
	ldrb r0, [r4, #4]
	add r0, r4, r0
	ldrb r0, [r0, #0x14]
	strb r0, [r4, #8]
	ldrb r0, [r4, #4]
	add r1, r4, r0
	ldrb r1, [r1, #0x14]
	cmp r1, #0
	bne _02160BF8
	mov r2, #0
_02160BDC:
	ldrb r1, [r4, #6]
	sub r1, r1, #1
	cmp r0, r1
	bge _02160BEC
	ldrb r0, [r4, #4]
	add r0, r0, #1
	strb r0, [r4, #4]
	b _02160BEE
_02160BEC:
	strb r2, [r4, #4]
_02160BEE:
	ldrb r0, [r4, #4]
	add r1, r4, r0
	ldrb r1, [r1, #0x14]
	cmp r1, #0
	beq _02160BDC
_02160BF8:
	add r0, r4, r0
	ldrb r0, [r0, #0x14]
	strb r0, [r4, #8]
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_02160C04: .word VSStageSelect__sVars
_02160C08: .word 0x00003041
_02160C0C: .word VSStageSelectMenu__Main1
_02160C10: .word 0x00003002
_02160C14: .word VSStageSelectMenu__Main2
_02160C18: .word 0x00003081
_02160C1C: .word VSStageSelectMenu__Main3
_02160C20: .word VSStageSelectMenu__State_Init
_02160C24: .word 0x0217DD64
_02160C28: .word 0x0217DD54
	thumb_func_end VSStageSelectMenu__Create

	thumb_func_start VSStageSelectMenu__Func_2160C2C
VSStageSelectMenu__Func_2160C2C: // 0x02160C2C
	ldr r0, _02160C38 // =VSStageSelect__sVars
	mov r1, #1
	ldr r0, [r0]
	str r1, [r0, #0x18]
	bx lr
	nop
_02160C38: .word VSStageSelect__sVars
	thumb_func_end VSStageSelectMenu__Func_2160C2C

	thumb_func_start VSStageSelectMenu__Func_2160C3C
VSStageSelectMenu__Func_2160C3C: // 0x02160C3C
	ldr r0, _02160C50 // =VSStageSelect__sVars
	ldr r0, [r0]
	ldr r0, [r0, #0x20]
	cmp r0, #1
	bne _02160C4A
	mov r0, #0
	bx lr
_02160C4A:
	mov r0, #1
	bx lr
	nop
_02160C50: .word VSStageSelect__sVars
	thumb_func_end VSStageSelectMenu__Func_2160C3C

	thumb_func_start VSStageSelectMenu__Func_2160C54
VSStageSelectMenu__Func_2160C54: // 0x02160C54
	ldr r0, _02160C5C // =VSStageSelect__sVars
	ldr r0, [r0]
	ldr r0, [r0, #0x20]
	bx lr
	.align 2, 0
_02160C5C: .word VSStageSelect__sVars
	thumb_func_end VSStageSelectMenu__Func_2160C54

	thumb_func_start VSStageSelectMenu__Func_2160C60
VSStageSelectMenu__Func_2160C60: // 0x02160C60
	push {r3, lr}
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _02160C72
	bl ReleaseStageCommonArchives
	bl FlushStageArea
_02160C72:
	pop {r3, pc}
	thumb_func_end VSStageSelectMenu__Func_2160C60

	thumb_func_start VSStageSelectMenu__SetState
VSStageSelectMenu__SetState: // 0x02160C74
	str r1, [r0, #0xc]
	mov r1, #0
	str r1, [r0, #0x10]
	bx lr
	thumb_func_end VSStageSelectMenu__SetState

	thumb_func_start VSStageSelectMenu__Init
VSStageSelectMenu__Init: // 0x02160C7C
	push {r4, lr}
	mov r4, r0
	ldr r2, _02160CA4 // =0x00000658
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r0, r4
	add r0, #0x20
	bl VSStageSelectMenu__Unknown__Init
	mov r0, r4
	add r0, #0x40
	bl VSStageSelectMenu__LoadAssets
	bl AllocSndHandle
	ldr r1, _02160CA8 // =0x00000654
	str r0, [r4, r1]
	pop {r4, pc}
	.align 2, 0
_02160CA4: .word 0x00000658
_02160CA8: .word 0x00000654
	thumb_func_end VSStageSelectMenu__Init

	thumb_func_start VSStageSelectMenu__Free
VSStageSelectMenu__Free: // 0x02160CAC
	push {r4, lr}
	mov r4, r0
	ldr r0, _02160CE0 // =0x00000654
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _02160CC2
	bl FreeSndHandle
	ldr r0, _02160CE0 // =0x00000654
	mov r1, #0
	str r1, [r4, r0]
_02160CC2:
	mov r0, r4
	add r0, #0x40
	bl VSStageSelectMenu__ReleaseAssets
	mov r0, r4
	add r0, #0x20
	bl VSStageSelectMenu__Unknown__Release
	ldr r2, _02160CE4 // =0x00000658
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	pop {r4, pc}
	nop
_02160CE0: .word 0x00000654
_02160CE4: .word 0x00000658
	thumb_func_end VSStageSelectMenu__Free

	thumb_func_start VSStageSelectMenu__Unknown__Init
VSStageSelectMenu__Unknown__Init: // 0x02160CE8
	mov r1, #0
	str r1, [r0]
	strb r1, [r0, #4]
	strb r1, [r0, #5]
	strh r1, [r0, #0xc]
	mov r1, #2
	lsl r1, r1, #0xa
	strh r1, [r0, #0xe]
	bx lr
	.align 2, 0
	thumb_func_end VSStageSelectMenu__Unknown__Init

	thumb_func_start VSStageSelectMenu__Unknown__Release
VSStageSelectMenu__Unknown__Release: // 0x02160CFC
	mov r1, #2
	str r1, [r0]
	bx lr
	.align 2, 0
	thumb_func_end VSStageSelectMenu__Unknown__Release

	thumb_func_start VSStageSelectMenu__Unknown__Func_2160D04
VSStageSelectMenu__Unknown__Func_2160D04: // 0x02160D04
	mov r1, #0
	strh r1, [r0, #0xc]
	strh r1, [r0, #0xe]
	bx lr
	thumb_func_end VSStageSelectMenu__Unknown__Func_2160D04

	thumb_func_start VSStageSelectMenu__LoadAssets
VSStageSelectMenu__LoadAssets: // 0x02160D0C
	push {r4, lr}
	sub sp, #0x10
	mov r3, #0
	mov r4, r0
	sub r1, r3, #1
	ldr r0, _02160D78 // =aNarcDmasVsNarc_0
	str r3, [sp]
	mov r2, r1
	bl ArchiveFile__Load
	str r0, [r4]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	bhi _02160D4C
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02160D38: // jump table
	.hword _02160D44 - _02160D38 - 2 // case 0
	.hword _02160D44 - _02160D38 - 2 // case 1
	.hword _02160D44 - _02160D38 - 2 // case 2
	.hword _02160D44 - _02160D38 - 2 // case 3
	.hword _02160D44 - _02160D38 - 2 // case 4
	.hword _02160D44 - _02160D38 - 2 // case 5
_02160D44:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	b _02160D4E
_02160D4C:
	mov r0, #1
_02160D4E:
	lsl r1, r0, #2
	ldr r0, _02160D7C // =0x0217EA34
	ldr r2, _02160D80 // =aDmasVsBac_0
	ldr r0, [r0, r1]
	add r1, r4, #4
	str r0, [sp]
	mov r0, r4
	add r0, #0xc
	str r0, [sp, #4]
	ldr r0, _02160D84 // =aDmasVsArrowBac
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	ldr r0, [r4]
	add r4, #8
	mov r3, r4
	bl StageClear__LoadFiles
	add sp, #0x10
	pop {r4, pc}
	nop
_02160D78: .word aNarcDmasVsNarc_0
_02160D7C: .word 0x0217EA34
_02160D80: .word aDmasVsBac_0
_02160D84: .word aDmasVsArrowBac
	thumb_func_end VSStageSelectMenu__LoadAssets

	thumb_func_start VSStageSelectMenu__ReleaseAssets
VSStageSelectMenu__ReleaseAssets: // 0x02160D88
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4]
	bl _FreeHEAP_USER
	mov r0, #0
	mov r1, r4
	mov r2, #0x10
	bl MIi_CpuClear32
	pop {r4, pc}
	.align 2, 0
	thumb_func_end VSStageSelectMenu__ReleaseAssets

	thumb_func_start VSStageSelectMenu__InitSprites1
VSStageSelectMenu__InitSprites1: // 0x02160DA0
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x30
	str r1, [sp, #0x18]
	mov r1, #0x40
	str r0, [sp, #0x14]
	mov r4, r0
	lsl r0, r1, #5
	orr r0, r1
	ldr r5, _02160FD8 // =0x0217DDEE
	mov r6, #0
	str r0, [sp, #0x28]
_02160DB6:
	mov r0, #2
	lsl r0, r0, #0xa
	ldrh r7, [r5, #2]
	str r0, [sp, #0x20]
	cmp r6, #8
	bhi _02160E3C
	add r0, r6, r6
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02160DCE: // jump table
	.hword _02160DF2 - _02160DCE - 2 // case 0
	.hword _02160E3C - _02160DCE - 2 // case 1
	.hword _02160E08 - _02160DCE - 2 // case 2
	.hword _02160E08 - _02160DCE - 2 // case 3
	.hword _02160E3C - _02160DCE - 2 // case 4
	.hword _02160E38 - _02160DCE - 2 // case 5
	.hword _02160E3C - _02160DCE - 2 // case 6
	.hword _02160E3C - _02160DCE - 2 // case 7
	.hword _02160DE0 - _02160DCE - 2 // case 8
_02160DE0:
	mov r0, #1
	bl VSLobbyMenu__Func_2163BDC
	mov r1, #1
	mov r2, r7
	str r0, [sp, #0x24]
	bl SpriteUnknown__Func_204C3CC
	b _02160E4E
_02160DF2:
	ldrh r0, [r5]
	mov r2, #0xe
	mov r3, #0x14
	lsl r1, r0, #2
	ldr r0, [sp, #0x18]
	ldr r0, [r0, r1]
	mov r1, #1
	str r0, [sp, #0x24]
	bl SpriteUnknown__Func_204C7A4
	b _02160E4E
_02160E08:
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	ldrh r0, [r5]
	beq _02160E24
	lsl r1, r0, #2
	ldr r0, [sp, #0x18]
	mov r2, r7
	ldr r0, [r0, r1]
	mov r1, #1
	str r0, [sp, #0x24]
	bl SpriteUnknown__Func_204C3CC
	b _02160E4E
_02160E24:
	lsl r1, r0, #2
	ldr r0, [sp, #0x18]
	mov r7, #0xb
	ldr r0, [r0, r1]
	mov r1, #1
	mov r2, r7
	str r0, [sp, #0x24]
	bl SpriteUnknown__Func_204C3CC
	b _02160E4E
_02160E38:
	ldr r0, [sp, #0x28]
	str r0, [sp, #0x20]
_02160E3C:
	ldrh r0, [r5]
	mov r2, r7
	lsl r1, r0, #2
	ldr r0, [sp, #0x18]
	ldr r0, [r0, r1]
	mov r1, #1
	str r0, [sp, #0x24]
	bl SpriteUnknown__Func_204C3CC
_02160E4E:
	mov r1, #1
	str r1, [sp]
	str r0, [sp, #4]
	ldrb r0, [r5, #8]
	ldr r1, [sp, #0x24]
	ldr r3, [sp, #0x20]
	str r0, [sp, #8]
	ldrb r0, [r5, #9]
	mov r2, r7
	str r0, [sp, #0xc]
	ldrb r0, [r5, #0xa]
	str r0, [sp, #0x10]
	mov r0, r4
	bl SpriteUnknown__Func_204C90C
	mov r0, #4
	ldrsh r0, [r5, r0]
	mov r1, #0
	mov r2, r1
	strh r0, [r4, #8]
	mov r0, #6
	ldrsh r0, [r5, r0]
	strh r0, [r4, #0xa]
	mov r0, r4
	bl AnimatorSprite__ProcessAnimation
	cmp r6, #0xb
	bhi _02160F00
	add r0, r6, r6
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02160E92: // jump table
	.hword _02160F08 - _02160E92 - 2 // case 0
	.hword _02160F00 - _02160E92 - 2 // case 1
	.hword _02160EAA - _02160E92 - 2 // case 2
	.hword _02160EC4 - _02160E92 - 2 // case 3
	.hword _02160EC4 - _02160E92 - 2 // case 4
	.hword _02160EE2 - _02160E92 - 2 // case 5
	.hword _02160F00 - _02160E92 - 2 // case 6
	.hword _02160EC4 - _02160E92 - 2 // case 7
	.hword _02160EC4 - _02160E92 - 2 // case 8
	.hword _02160ECE - _02160E92 - 2 // case 9
	.hword _02160ED8 - _02160E92 - 2 // case 10
	.hword _02160ED8 - _02160E92 - 2 // case 11
_02160EAA:
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	ldr r1, [r4, #0x3c]
	beq _02160EBC
	mov r0, #4
	orr r0, r1
	str r0, [r4, #0x3c]
	b _02160F08
_02160EBC:
	mov r0, #0xc
	orr r0, r1
	str r0, [r4, #0x3c]
	b _02160F08
_02160EC4:
	ldr r1, [r4, #0x3c]
	mov r0, #0xc
	orr r0, r1
	str r0, [r4, #0x3c]
	b _02160F08
_02160ECE:
	ldr r1, [r4, #0x3c]
	mov r0, #0xd
	orr r0, r1
	str r0, [r4, #0x3c]
	b _02160F08
_02160ED8:
	ldr r1, [r4, #0x3c]
	mov r0, #5
	orr r0, r1
	str r0, [r4, #0x3c]
	b _02160F08
_02160EE2:
	ldr r1, [r4, #0x3c]
	mov r0, #0x18
	orr r0, r1
	str r0, [r4, #0x3c]
	mov r0, r4
	add r0, #0x50
	ldrh r0, [r0]
	add r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl ObjDraw__GetHWPaletteRow
	ldr r1, _02160FDC // =0x000024A0
	strh r1, [r0, #0x10]
	b _02160F08
_02160F00:
	ldr r1, [r4, #0x3c]
	mov r0, #8
	orr r0, r1
	str r0, [r4, #0x3c]
_02160F08:
	add r6, r6, #1
	add r5, #0xc
	add r4, #0x64
	cmp r6, #0xc
	bhs _02160F14
	b _02160DB6
_02160F14:
	ldr r0, [sp, #0x14]
	mov r1, #2
	add r0, #0xc8
	bl AnimatorSprite__SetAnimation
	mov r0, #0
	bl VSStageSelectMenu__Func_2162210
	mov r1, r0
	ldr r0, [sp, #0x14]
	bl AnimatorSprite__SetAnimation
	bl VSLobbyMenu__GetTouchField
	str r0, [sp, #0x1c]
	mov r1, #0x4b
	ldr r0, [sp, #0x14]
	lsl r1, r1, #4
	ldr r5, _02160FE0 // =0x0217DDBC
	mov r6, #0
	add r4, r0, r1
	add r7, sp, #0x2c
_02160F40:
	ldrh r2, [r5]
	mov r0, #0x64
	mov r1, r2
	mul r1, r0
	cmp r6, #0
	beq _02160F50
	cmp r6, #1
	bne _02160F82
_02160F50:
	cmp r6, #0
	bne _02160F58
	mov r0, #0x1e
	b _02160F5A
_02160F58:
	mov r0, #0xe2
_02160F5A:
	strh r0, [r7]
	ldrh r1, [r5]
	mov r0, #0xc
	add r3, r5, #2
	mov r2, r1
	mul r2, r0
	ldr r0, _02160FD8 // =0x0217DDEE
	add r1, r0, r2
	mov r0, #6
	ldrsh r0, [r1, r0]
	ldr r2, _02160FE4 // =TouchField__PointInRect
	add r1, sp, #0x2c
	strh r0, [r7, #2]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	mov r0, r4
	bl TouchField__InitAreaShape
	b _02160F9E
_02160F82:
	mov r0, #0
	ldr r2, [sp, #0x14]
	str r0, [sp]
	str r0, [sp, #4]
	add r1, r2, r1
	mov r0, r4
	mov r2, #0
	mov r3, #3
	bl TouchField__InitAreaSprite
	mov r0, r4
	add r1, r5, #2
	bl TouchField__SetAreaHitbox
_02160F9E:
	ldr r0, [sp, #0x1c]
	mov r1, r4
	mov r2, #0
	bl TouchField__AddArea
	ldr r1, [r4, #0x14]
	mov r0, #0x80
	orr r0, r1
	str r0, [r4, #0x14]
	add r6, r6, #1
	add r4, #0x38
	add r5, #0xa
	cmp r6, #5
	blo _02160F40
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	bne _02160FD2
	mov r1, #0x4b
	ldr r0, [sp, #0x14]
	lsl r1, r1, #2
	add r2, r0, r1
	ldr r1, [r2, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r2, #0x3c]
_02160FD2:
	add sp, #0x30
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02160FD8: .word 0x0217DDEE
_02160FDC: .word 0x000024A0
_02160FE0: .word 0x0217DDBC
_02160FE4: .word TouchField__PointInRect
	thumb_func_end VSStageSelectMenu__InitSprites1

	thumb_func_start VSStageSelectMenu__ReleaseSprites
VSStageSelectMenu__ReleaseSprites: // 0x02160FE8
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	bl VSLobbyMenu__GetTouchField
	mov r7, r0
	mov r0, #0x4b
	lsl r0, r0, #4
	add r4, r5, r0
	ldr r0, _02161024 // =0x000005C8
	add r6, r5, r0
	cmp r4, r6
	beq _0216100E
_02161000:
	mov r0, r7
	mov r1, r4
	bl TouchField__RemoveArea
	add r4, #0x38
	cmp r4, r6
	bne _02161000
_0216100E:
	mov r0, #0x4b
	lsl r0, r0, #4
	beq _02161022
	add r4, r5, r0
_02161016:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _02161016
_02161022:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02161024: .word 0x000005C8
	thumb_func_end VSStageSelectMenu__ReleaseSprites

	thumb_func_start VSStageSelectMenu__InitSprites2
VSStageSelectMenu__InitSprites2: // 0x02161028
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r4, _021610B4 // =0x0217DD8C
	mov r6, #0
	mov r5, r7
_02161032:
	mov r0, #0
	ldrsh r0, [r4, r0]
	strh r0, [r5, #8]
	mov r0, #2
	ldrsh r0, [r4, r0]
	strh r0, [r5, #0xa]
	ldr r1, [r5, #0x3c]
	mov r0, #1
	orr r0, r1
	mov r1, #0
	str r0, [r5, #0x3c]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	add r4, r4, #4
	add r5, #0x64
	cmp r6, #0xc
	blo _02161032
	mov r0, r7
	add r0, #0xc8
	mov r1, #2
	bl AnimatorSprite__SetAnimation
	mov r0, #0x4b
	lsl r0, r0, #2
	add r0, r7, r0
	mov r1, #5
	bl AnimatorSprite__SetAnimation
	mov r0, #0
	bl VSStageSelectMenu__Func_2162210
	mov r1, r0
	mov r0, r7
	bl AnimatorSprite__SetAnimation
	mov r2, r7
	ldr r1, [r7, #0x3c]
	mov r0, #1
	bic r1, r0
	add r2, #0x64
	str r1, [r7, #0x3c]
	ldr r1, [r2, #0x3c]
	bic r1, r0
	str r1, [r2, #0x3c]
	mov r2, r7
	add r2, #0xc8
	ldr r1, [r2, #0x3c]
	bic r1, r0
	str r1, [r2, #0x3c]
	mov r1, #0x7d
	lsl r1, r1, #2
	add r3, r7, r1
	ldr r2, [r3, #0x3c]
	add r1, #0xc8
	bic r2, r0
	str r2, [r3, #0x3c]
	add r2, r7, r1
	ldr r1, [r2, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r2, #0x3c]
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021610B4: .word 0x0217DD8C
	thumb_func_end VSStageSelectMenu__InitSprites2

	thumb_func_start VSStageSelectMenu__InitFonts
VSStageSelectMenu__InitFonts: // 0x021610B8
	push {r3, r4, r5, lr}
	sub sp, #0x20
	mov r5, r0
	mov r0, #0
	bl VSLobbyMenu__Func_2163BDC
	mov r4, r0
	mov r0, r5
	bl FontAniHeader__Func_2054CF8
	mov r0, #3
	str r0, [sp]
	mov r0, #4
	str r0, [sp, #4]
	mov r0, #0x1a
	str r0, [sp, #8]
	mov r0, #0xe
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
	bl FontWindowAnimator__Unknown__Load2
	mov r0, #1
	lsl r0, r0, #0xc
	strh r0, [r5, #0x38]
	add sp, #0x20
	pop {r3, r4, r5, pc}
	thumb_func_end VSStageSelectMenu__InitFonts

	thumb_func_start VSStageSelectMenu__ReleaseFonts
VSStageSelectMenu__ReleaseFonts: // 0x02161100
	ldr r3, _02161104 // =FontAniHeader__Unknown__Release
	bx r3
	.align 2, 0
_02161104: .word FontAniHeader__Unknown__Release
	thumb_func_end VSStageSelectMenu__ReleaseFonts

	thumb_func_start VSStageSelectMenu__Func_2161108
VSStageSelectMenu__Func_2161108: // 0x02161108
	push {r4, r5, r6, lr}
	mov r5, r0
	add r0, #0x20
	mov r1, #0xe
	ldrsh r4, [r0, r1]
	mov r1, #0xc
	ldrsh r3, [r0, r1]
	mov r1, #2
	lsl r1, r1, #0xc
	sub r2, r1, r4
	add r5, #0x50
	cmp r3, r2
	bge _02161126
	add r1, r3, r4
	b _02161126
_02161126:
	strh r1, [r0, #0xc]
	mov r0, #0x4b
	lsl r0, r0, #4
	beq _02161142
	mov r6, #0
	add r4, r5, r0
_02161132:
	mov r0, r5
	mov r1, r6
	mov r2, r6
	bl AnimatorSprite__ProcessAnimation
	add r5, #0x64
	cmp r5, r4
	bne _02161132
_02161142:
	pop {r4, r5, r6, pc}
	thumb_func_end VSStageSelectMenu__Func_2161108

	thumb_func_start VSStageSelectMenu__Func_2161144
VSStageSelectMenu__Func_2161144: // 0x02161144
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r5, r0
	str r0, [sp, #4]
	str r0, [sp, #0x10]
	add r0, #0x20
	str r0, [sp, #0x10]
	ldr r1, _02161350 // =0x00000618
	ldr r0, [sp, #4]
	add r5, #0x50
	add r0, r0, r1
	str r0, [sp, #0xc]
	ldr r0, [sp, #4]
	ldr r1, [r0, #0x30]
	mov r0, #1
	tst r0, r1
	bne _02161170
	ldr r0, _02161354 // =0x0217DE06
	ldr r7, _02161358 // =0x0217DE16
	add r6, r0, #4
	ldr r4, _0216135C // =0x0217DE22
	b _02161176
_02161170:
	ldr r6, _02161360 // =0x0217DD94
	ldr r7, _02161364 // =0x0217DD98
	ldr r4, _02161368 // =0x0217DD9C
_02161176:
	mov r1, #0
	ldrsh r1, [r6, r1]
	mov r0, r5
	add r0, #0xc8
	mov r3, #2
	strh r1, [r0, #8]
	ldrsh r1, [r6, r3]
	mov r2, #0x4b
	lsl r2, r2, #2
	strh r1, [r0, #0xa]
	mov r1, #0
	add r0, r5, r2
	ldrsh r1, [r7, r1]
	add r2, #0x64
	strh r1, [r0, #8]
	ldrsh r1, [r7, r3]
	strh r1, [r0, #0xa]
	mov r1, #0
	ldrsh r1, [r4, r1]
	add r0, r5, r2
	strh r1, [r0, #8]
	ldrsh r1, [r4, r3]
	strh r1, [r0, #0xa]
	ldr r0, [sp, #0x10]
	mov r1, #0xc
	ldrsh r0, [r0, r1]
	asr r0, r0, #0xc
	str r0, [sp, #8]
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	beq _02161264
	ldr r0, [sp, #0x10]
	ldrb r0, [r0, #5]
	cmp r0, #0
	beq _021611C8
	cmp r0, #1
	beq _021611F4
	cmp r0, #2
	beq _02161222
	b _021612DE
_021611C8:
	mov r1, #0x96
	lsl r1, r1, #2
	add r3, r5, r1
	ldr r2, [r3, #0x3c]
	mov r0, #1
	orr r0, r2
	sub r1, #0x64
	str r0, [r3, #0x3c]
	add r0, r5, r1
	ldr r2, [r0, #0x3c]
	mov r1, #1
	bic r2, r1
	str r2, [r0, #0x3c]
	mov r1, #0
	ldrsh r1, [r6, r1]
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r6, r1]
	strh r1, [r0, #0xa]
	mov r0, r5
	add r0, #0xc8
	b _0216124E
_021611F4:
	mov r1, #0x96
	lsl r1, r1, #2
	add r3, r5, r1
	ldr r2, [r3, #0x3c]
	mov r0, #1
	orr r0, r2
	str r0, [r3, #0x3c]
	mov r0, r1
	sub r0, #0x64
	add r0, r5, r0
	ldr r3, [r0, #0x3c]
	mov r2, #1
	bic r3, r2
	str r3, [r0, #0x3c]
	mov r2, #0
	ldrsh r2, [r7, r2]
	strh r2, [r0, #8]
	mov r2, #2
	ldrsh r2, [r7, r2]
	strh r2, [r0, #0xa]
	lsr r0, r1, #1
	add r0, r5, r0
	b _0216124E
_02161222:
	mov r0, #0x7d
	lsl r0, r0, #2
	add r3, r5, r0
	ldr r2, [r3, #0x3c]
	mov r1, #1
	orr r1, r2
	str r1, [r3, #0x3c]
	mov r1, r0
	add r1, #0x64
	add r1, r5, r1
	ldr r3, [r1, #0x3c]
	mov r2, #1
	bic r3, r2
	str r3, [r1, #0x3c]
	mov r2, #0
	ldrsh r2, [r4, r2]
	sub r0, #0x64
	add r0, r5, r0
	strh r2, [r1, #8]
	mov r2, #2
	ldrsh r2, [r4, r2]
	strh r2, [r1, #0xa]
_0216124E:
	mov r1, #8
	ldrsh r2, [r0, r1]
	ldr r1, [sp, #8]
	sub r1, r2, r1
	strh r1, [r0, #8]
	mov r1, #0xa
	ldrsh r2, [r0, r1]
	ldr r1, [sp, #8]
	sub r1, r2, r1
	strh r1, [r0, #0xa]
	b _021612DE
_02161264:
	ldr r0, [sp, #0x10]
	ldrb r0, [r0, #5]
	cmp r0, #0
	beq _02161272
	cmp r0, #1
	beq _0216129E
	b _021612DE
_02161272:
	mov r1, #0x96
	lsl r1, r1, #2
	add r3, r5, r1
	ldr r2, [r3, #0x3c]
	mov r0, #1
	orr r0, r2
	sub r1, #0x64
	str r0, [r3, #0x3c]
	add r0, r5, r1
	ldr r2, [r0, #0x3c]
	mov r1, #1
	bic r2, r1
	str r2, [r0, #0x3c]
	mov r1, #0
	ldrsh r1, [r6, r1]
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r6, r1]
	strh r1, [r0, #0xa]
	mov r0, r5
	add r0, #0xc8
	b _021612CA
_0216129E:
	mov r0, #0x7d
	lsl r0, r0, #2
	add r3, r5, r0
	ldr r2, [r3, #0x3c]
	mov r1, #1
	orr r1, r2
	str r1, [r3, #0x3c]
	mov r1, r0
	add r1, #0x64
	add r1, r5, r1
	ldr r3, [r1, #0x3c]
	mov r2, #1
	bic r3, r2
	str r3, [r1, #0x3c]
	mov r2, #0
	ldrsh r2, [r4, r2]
	sub r0, #0x64
	add r0, r5, r0
	strh r2, [r1, #8]
	mov r2, #2
	ldrsh r2, [r4, r2]
	strh r2, [r1, #0xa]
_021612CA:
	mov r1, #8
	ldrsh r2, [r0, r1]
	ldr r1, [sp, #8]
	sub r1, r2, r1
	strh r1, [r0, #8]
	mov r1, #0xa
	ldrsh r2, [r0, r1]
	ldr r1, [sp, #8]
	sub r1, r2, r1
	strh r1, [r0, #0xa]
_021612DE:
	ldr r0, [sp, #4]
	ldrh r1, [r0, #0x14]
	mov r0, #4
	tst r0, r1
	beq _02161320
	mov r0, #0xaf
	lsl r0, r0, #2
	add r4, r5, r0
	mov r0, #0x1e
	strh r0, [r4, #8]
	ldr r1, [r4, #0x3c]
	mov r0, #0x80
	bic r1, r0
	str r1, [r4, #0x3c]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldr r1, [r4, #0x3c]
	mov r0, #0x80
	orr r0, r1
	str r0, [r4, #0x3c]
	mov r0, #0xe2
	strh r0, [r4, #8]
	mov r0, #0x4b
	lsl r0, r0, #4
	beq _02161320
	add r4, r5, r0
_02161314:
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	add r5, #0x64
	cmp r5, r4
	bne _02161314
_02161320:
	ldr r0, [sp, #4]
	ldrh r1, [r0, #0x14]
	mov r0, #2
	tst r0, r1
	beq _0216134A
	ldr r0, [sp, #0xc]
	mov r3, #0x38
	ldrsh r1, [r0, r3]
	cmp r1, #0
	ble _0216134A
	mov r2, #0x3a
	ldrsh r2, [r0, r2]
	cmp r2, #0
	ble _0216134A
	str r3, [sp]
	mov r3, #0x68
	bl FontWindowAnimator__Unknown__Func_205509C
	ldr r0, [sp, #0xc]
	bl FontWindowAnimator__Unknown__Func_2054F64
_0216134A:
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	nop
_02161350: .word 0x00000618
_02161354: .word 0x0217DE06
_02161358: .word 0x0217DE16
_0216135C: .word 0x0217DE22
_02161360: .word 0x0217DD94
_02161364: .word 0x0217DD98
_02161368: .word 0x0217DD9C
	thumb_func_end VSStageSelectMenu__Func_2161144

	thumb_func_start VSStageSelectMenu__State_Init
VSStageSelectMenu__State_Init: // 0x0216136C
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r4, r5
	add r4, #0x50
	mov r1, r5
	mov r6, r5
	mov r0, r4
	add r1, #0x40
	add r6, #0x20
	bl VSStageSelectMenu__InitSprites1
	ldr r1, [r5, #0x30]
	mov r0, #1
	tst r0, r1
	beq _02161392
	mov r0, r5
	add r0, #0x50
	bl VSStageSelectMenu__InitSprites2
_02161392:
	ldr r0, _021614D8 // =0x00000618
	mov r1, r5
	add r0, r5, r0
	add r1, #0x40
	bl VSStageSelectMenu__InitFonts
	ldr r1, [r5, #0x30]
	mov r0, #1
	tst r0, r1
	bne _021613AE
	mov r0, #6
	mov r1, #0
	bl VSLobbyMenu__Func_2163CE0
_021613AE:
	ldr r1, [r6, #0x10]
	mov r0, #1
	tst r0, r1
	beq _021613BC
	mov r0, #2
	tst r0, r1
	beq _02161448
_021613BC:
	ldrb r0, [r6, #4]
	bl VSStageSelectMenu__Func_2162210
	mov r1, r0
	mov r0, r4
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r7, r4
	add r7, #0xc8
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	beq _021613FE
	ldrb r0, [r6, #4]
	bl VSStageSelectMenu__Func_2162244
	cmp r0, #0
	beq _021613F4
	mov r0, r7
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	b _02161406
_021613F4:
	mov r0, r7
	mov r1, #8
	bl AnimatorSprite__SetAnimation
	b _02161406
_021613FE:
	mov r0, r7
	mov r1, #0xb
	bl AnimatorSprite__SetAnimation
_02161406:
	mov r7, r4
	add r7, #0xc8
	ldrh r1, [r7, #0xc]
	mov r0, r7
	add r1, r1, #2
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r7
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	beq _021614C4
	mov r0, #0x4b
	lsl r0, r0, #2
	add r0, r4, r0
	ldrb r1, [r6, #8]
	ldr r2, [r0, #0x3c]
	cmp r1, #2
	bhs _02161440
	mov r1, #1
	orr r1, r2
	str r1, [r0, #0x3c]
	b _021614C4
_02161440:
	mov r1, #1
	bic r2, r1
	str r2, [r0, #0x3c]
	b _021614C4
_02161448:
	bl VSLobbyMenu__Func_2163D20
	mov r6, r0
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	beq _0216146E
	ldr r0, _021614DC // =0x0217DD64
	ldrb r7, [r0, r6]
	mov r0, r7
	bl VSStageSelectMenu__Func_2162244
	cmp r0, #0
	beq _0216146A
	ldr r0, _021614E0 // =0x0217DD78
	ldrb r6, [r0, r6]
	b _02161476
_0216146A:
	mov r6, #8
	b _02161476
_0216146E:
	ldr r0, _021614E4 // =0x0217DD54
	ldrb r7, [r0, r6]
	ldr r0, _021614E8 // =0x0217DD4C
	ldrb r6, [r0, r6]
_02161476:
	lsl r0, r7, #0x18
	lsr r0, r0, #0x18
	bl VSStageSelectMenu__Func_2162210
	mov r1, r0
	mov r0, r4
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r7, r4
	add r1, r6, #2
	add r7, #0xc8
	lsl r1, r1, #0x10
	mov r0, r7
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r7
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r2, r4
	add r2, #0xc8
	ldr r1, [r2, #0x3c]
	mov r0, #1
	bic r1, r0
	mov r0, #0x4b
	lsl r0, r0, #2
	str r1, [r2, #0x3c]
	add r2, r4, r0
	ldr r1, [r2, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r2, #0x3c]
_021614C4:
	ldrh r1, [r5, #0x14]
	mov r0, #2
	orr r0, r1
	strh r0, [r5, #0x14]
	ldr r1, _021614EC // =VSStageSelectMenu__State_21614F0
	mov r0, r5
	bl VSStageSelectMenu__SetState
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021614D8: .word 0x00000618
_021614DC: .word 0x0217DD64
_021614E0: .word 0x0217DD78
_021614E4: .word 0x0217DD54
_021614E8: .word 0x0217DD4C
_021614EC: .word VSStageSelectMenu__State_21614F0
	thumb_func_end VSStageSelectMenu__State_Init

	thumb_func_start VSStageSelectMenu__State_21614F0
VSStageSelectMenu__State_21614F0: // 0x021614F0
	push {r3, r4, r5, lr}
	sub sp, #8
	mov r4, r0
	ldr r1, _02161578 // =0x00000618
	ldr r0, [r4, #0x10]
	add r5, r4, r1
	cmp r0, #0xc
	bls _0216156A
	mov r2, r4
	mov r0, #0x4b
	add r2, #0x50
	lsl r0, r0, #4
	sub r1, #0x50
	add r0, r2, r0
	add r3, r2, r1
	cmp r0, r3
	beq _02161520
	mov r1, #0x80
_02161514:
	ldr r2, [r0, #0x14]
	bic r2, r1
	str r2, [r0, #0x14]
	add r0, #0x38
	cmp r0, r3
	bne _02161514
_02161520:
	mov r0, #1
	lsl r0, r0, #0xc
	strh r0, [r5, #0x3a]
	ldrh r1, [r4, #0x14]
	mov r0, #7
	orr r0, r1
	strh r0, [r4, #0x14]
	ldr r1, [r4, #0x30]
	mov r0, #1
	tst r0, r1
	bne _02161542
	ldr r1, _0216157C // =VSStageSelectMenu__State_2161588
	mov r0, r4
	bl VSStageSelectMenu__SetState
	add sp, #8
	pop {r3, r4, r5, pc}
_02161542:
	mov r0, #2
	tst r0, r1
	beq _0216155E
	mov r0, #0x25
	str r0, [sp]
	mov r1, #5
	str r1, [sp, #4]
	sub r1, r1, #6
	ldr r0, _02161580 // =0x00000654
	mov r2, r1
	ldr r0, [r4, r0]
	mov r3, r1
	bl PlaySfxEx
_0216155E:
	ldr r1, _02161584 // =VSStageSelectMenu__State_2161C54
	mov r0, r4
	bl VSStageSelectMenu__SetState
	add sp, #8
	pop {r3, r4, r5, pc}
_0216156A:
	lsl r0, r0, #0xc
	mov r1, #0xc
	bl _u32_div_f
	strh r0, [r5, #0x3a]
	add sp, #8
	pop {r3, r4, r5, pc}
	.align 2, 0
_02161578: .word 0x00000618
_0216157C: .word VSStageSelectMenu__State_2161588
_02161580: .word 0x00000654
_02161584: .word VSStageSelectMenu__State_2161C54
	thumb_func_end VSStageSelectMenu__State_21614F0

	thumb_func_start VSStageSelectMenu__State_2161588
VSStageSelectMenu__State_2161588: // 0x02161588
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r1, #0
	mov r6, r0
	mov r5, r6
	mov r4, r6
	str r1, [sp, #0x10]
	str r1, [sp, #0xc]
	mov r7, r1
	str r1, [sp, #8]
	ldr r1, [r6, #0x18]
	add r5, #0x50
	add r4, #0x20
	cmp r1, #0
	beq _021615B8
	ldrh r2, [r6, #0x14]
	mov r1, #4
	bic r2, r1
	ldr r1, _02161888 // =VSStageSelectMenu__State_2161B28
	strh r2, [r6, #0x14]
	bl VSStageSelectMenu__SetState
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
_021615B8:
	bl VSLobbyMenu__Func_2163DF4
	cmp r0, #0
	beq _021615DA
	ldrb r0, [r4, #7]
	sub r0, r0, #1
	strb r0, [r4, #5]
	ldrh r1, [r6, #0x14]
	mov r0, #4
	bic r1, r0
	strh r1, [r6, #0x14]
	ldr r1, _02161888 // =VSStageSelectMenu__State_2161B28
	mov r0, r6
	bl VSStageSelectMenu__SetState
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
_021615DA:
	ldr r0, _0216188C // =touchInput
	mov r3, #1
	ldrh r0, [r0, #0x12]
	tst r0, r3
	beq _0216163E
	ldr r0, _02161890 // =0x000004C4
	lsl r1, r3, #0x15
	ldr r2, [r5, r0]
	tst r1, r2
	beq _0216160E
_021615EE:
	ldrb r0, [r4, #4]
	cmp r0, #0
	beq _021615F6
	b _021615F8
_021615F6:
	ldrb r0, [r4, #6]
_021615F8:
	sub r0, r0, #1
	strb r0, [r4, #4]
	ldrb r0, [r4, #4]
	add r0, r4, r0
	ldrb r0, [r0, #0x14]
	cmp r0, #0
	beq _021615EE
	strb r0, [r4, #8]
	mov r0, #1
	str r0, [sp, #0x10]
	b _02161694
_0216160E:
	add r0, #0x38
	ldr r1, [r5, r0]
	lsl r0, r3, #0x15
	tst r0, r1
	beq _02161694
	mov r0, r7
_0216161A:
	ldrb r2, [r4, #6]
	ldrb r1, [r4, #4]
	sub r2, r2, #1
	cmp r1, r2
	bge _0216162A
	add r1, r1, #1
	strb r1, [r4, #4]
	b _0216162C
_0216162A:
	strb r0, [r4, #4]
_0216162C:
	ldrb r1, [r4, #4]
	add r1, r4, r1
	ldrb r1, [r1, #0x14]
	cmp r1, #0
	beq _0216161A
	mov r0, #1
	strb r1, [r4, #8]
	str r0, [sp, #0x10]
	b _02161694
_0216163E:
	ldr r0, _02161894 // =padInput
	mov r1, #0x30
	ldrh r0, [r0, #8]
	tst r1, r0
	beq _02161694
	mov r1, #0x20
	tst r1, r0
	beq _0216166A
_0216164E:
	ldrb r0, [r4, #4]
	cmp r0, #0
	beq _02161656
	b _02161658
_02161656:
	ldrb r0, [r4, #6]
_02161658:
	sub r0, r0, #1
	strb r0, [r4, #4]
	ldrb r0, [r4, #4]
	add r0, r4, r0
	ldrb r0, [r0, #0x14]
	cmp r0, #0
	beq _0216164E
	strb r0, [r4, #8]
	b _02161690
_0216166A:
	mov r1, #0x10
	tst r0, r1
	beq _02161690
	mov r0, r7
_02161672:
	ldrb r2, [r4, #6]
	ldrb r1, [r4, #4]
	sub r2, r2, #1
	cmp r1, r2
	bge _02161682
	add r1, r1, #1
	strb r1, [r4, #4]
	b _02161684
_02161682:
	strb r0, [r4, #4]
_02161684:
	ldrb r1, [r4, #4]
	add r1, r4, r1
	ldrb r1, [r1, #0x14]
	cmp r1, #0
	beq _02161672
	strb r1, [r4, #8]
_02161690:
	mov r0, #1
	str r0, [sp, #0x10]
_02161694:
	ldr r0, [sp, #0x10]
	cmp r0, #0
	beq _0216172A
	ldrb r0, [r4, #4]
	bl VSStageSelectMenu__Func_2162210
	mov r1, r0
	mov r0, r5
	bl AnimatorSprite__SetAnimation
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	beq _02161726
	mov r0, #0x4b
	lsl r0, r0, #2
	add r0, r5, r0
	ldrb r1, [r4, #8]
	ldr r2, [r0, #0x3c]
	cmp r1, #2
	bhs _021616DA
	mov r1, #1
	orr r2, r1
	str r2, [r0, #0x3c]
	ldrb r2, [r4, #5]
	cmp r2, #1
	bne _021616E0
	mov r2, #0
	str r1, [sp, #0xc]
	ldr r1, _02161898 // =0x0217DE0C
	strb r2, [r4, #5]
	ldrh r1, [r1, #8]
	bl AnimatorSprite__SetAnimation
	b _021616E0
_021616DA:
	mov r1, #1
	bic r2, r1
	str r2, [r0, #0x3c]
_021616E0:
	mov r0, r5
	str r0, [sp]
	add r0, #0xc8
	str r0, [sp]
	ldrb r0, [r4, #4]
	bl VSStageSelectMenu__Func_2162244
	cmp r0, #0
	beq _021616FC
	ldr r0, [sp]
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	b _02161704
_021616FC:
	ldr r0, [sp]
	mov r1, #8
	bl AnimatorSprite__SetAnimation
_02161704:
	ldrb r0, [r4, #5]
	cmp r0, #0
	beq _02161716
	ldr r0, [sp]
	mov r1, r0
	ldrh r1, [r1, #0xc]
	bl AnimatorSprite__SetAnimation
	b _02161726
_02161716:
	ldr r0, [sp]
	mov r1, r0
	ldrh r1, [r1, #0xc]
	add r1, r1, #2
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
_02161726:
	mov r0, #1
	str r0, [sp, #8]
_0216172A:
	ldr r0, _02161894 // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0xc0
	tst r0, r1
	bne _0216175A
	ldr r0, [sp, #0xc]
	cmp r0, #0
	bne _0216175A
	ldr r1, _0216189C // =0x00000534
	mov r2, #1
	ldr r0, [r5, r1]
	lsl r2, r2, #0x16
	tst r0, r2
	bne _0216175A
	mov r0, r1
	add r0, #0x38
	ldr r0, [r5, r0]
	tst r0, r2
	bne _0216175A
	add r1, #0x70
	ldr r0, [r5, r1]
	tst r0, r2
	bne _0216175A
	b _021619CC
_0216175A:
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	ldrb r0, [r4, #5]
	beq _021617BA
	cmp r0, #0
	beq _02161772
	cmp r0, #1
	beq _0216179A
	cmp r0, #2
	beq _021617AA
	b _021617E0
_02161772:
	mov r0, r5
	str r0, [sp, #4]
	add r0, #0xc8
	str r0, [sp, #4]
	ldrb r0, [r4, #4]
	bl VSStageSelectMenu__Func_2162244
	cmp r0, #0
	beq OpeningSonicNameSprite__LetterPositions
	ldr r1, _021618A0 // =0x0217DE06
	ldr r0, [sp, #4]
	ldrh r1, [r1, #2]
	bl AnimatorSprite__SetAnimation
	b _021617E0
OpeningSonicNameSprite__LetterPositions:
	ldr r0, [sp, #4]
	mov r1, #8
	bl AnimatorSprite__SetAnimation
	b _021617E0
_0216179A:
	ldr r1, _02161898 // =0x0217DE0C
	mov r0, #0x4b
	ldrh r1, [r1, #8]
	lsl r0, r0, #2
	add r0, r5, r0
	bl AnimatorSprite__SetAnimation
	b _021617E0
_021617AA:
	ldr r1, _02161898 // =0x0217DE0C
	mov r0, #0x19
	ldrh r1, [r1, #0x14]
	lsl r0, r0, #4
	add r0, r5, r0
	bl AnimatorSprite__SetAnimation
	b _021617E0
_021617BA:
	cmp r0, #0
	beq _021617C4
	cmp r0, #1
	beq _021617D2
	b _021617E0
_021617C4:
	ldr r1, _021618A4 // =0x0217DDCC
	mov r0, r5
	ldrh r1, [r1, #0x3c]
	add r0, #0xc8
	bl AnimatorSprite__SetAnimation
	b _021617E0
_021617D2:
	ldr r1, _02161898 // =0x0217DE0C
	mov r0, #0x19
	ldrh r1, [r1, #0x14]
	lsl r0, r0, #4
	add r0, r5, r0
	bl AnimatorSprite__SetAnimation
_021617E0:
	ldr r1, _0216189C // =0x00000534
	mov r2, #1
	ldr r0, [r5, r1]
	lsl r2, r2, #0x16
	tst r0, r2
	beq _021617F4
	mov r0, #0
	strb r0, [r4, #5]
	mov r7, #1
	b _021618AE
_021617F4:
	mov r0, r1
	add r0, #0x38
	ldr r0, [r5, r0]
	tst r0, r2
	beq _02161812
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	beq _0216180A
	mov r0, #1
	b _0216180C
_0216180A:
	mov r0, #0
_0216180C:
	strb r0, [r4, #5]
	mov r7, #1
	b _021618AE
_02161812:
	add r1, #0x70
	ldr r0, [r5, r1]
	tst r0, r2
	beq _02161824
	ldrb r0, [r4, #7]
	mov r7, #1
	sub r0, r0, #1
	strb r0, [r4, #5]
	b _021618AE
_02161824:
	ldr r0, _0216188C // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #1
	tst r0, r1
	bne _021618AE
	ldr r0, _02161894 // =padInput
	mov r1, #0x40
	ldrh r0, [r0, #8]
	tst r1, r0
	beq _0216185E
	ldrb r0, [r4, #7]
	ldrb r1, [r4, #5]
	sub r0, r0, #1
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	cmp r1, r0
	bne _0216184E
	ldrb r0, [r4, #8]
	sub r0, r0, #1
	strb r0, [r4, #5]
	b _0216185A
_0216184E:
	cmp r1, #0
	beq _02161858
	sub r0, r1, #1
	strb r0, [r4, #5]
	b _0216185A
_02161858:
	strb r0, [r4, #5]
_0216185A:
	mov r7, #1
	b _021618AE
_0216185E:
	mov r1, #0x80
	tst r0, r1
	beq _021618AE
	ldrb r1, [r4, #8]
	ldrb r0, [r4, #5]
	sub r1, r1, #1
	lsl r1, r1, #0x18
	lsr r1, r1, #0x18
	cmp r0, r1
	bne _0216187A
	ldrb r0, [r4, #7]
	sub r0, r0, #1
	strb r0, [r4, #5]
	b _021618AC
_0216187A:
	ldrb r1, [r4, #7]
	sub r1, r1, #1
	cmp r0, r1
	bge _021618A8
	add r0, r0, #1
	strb r0, [r4, #5]
	b _021618AC
	.align 2, 0
_02161888: .word VSStageSelectMenu__State_2161B28
_0216188C: .word touchInput
_02161890: .word 0x000004C4
_02161894: .word padInput
_02161898: .word 0x0217DE0C
_0216189C: .word 0x00000534
_021618A0: .word 0x0217DE06
_021618A4: .word 0x0217DDCC
_021618A8:
	mov r0, #0
	strb r0, [r4, #5]
_021618AC:
	mov r7, #1
_021618AE:
	cmp r7, #0
	beq _021618BA
	mov r0, #0
	strh r0, [r4, #0xc]
	mov r0, #1
	str r0, [sp, #8]
_021618BA:
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	ldrb r0, [r4, #5]
	beq _0216196E
	cmp r0, #0
	beq _021618D2
	cmp r0, #1
	beq _02161916
	cmp r0, #2
	beq _02161942
	b _021619CC
_021618D2:
	ldrb r0, [r4, #4]
	mov r7, r5
	add r7, #0xc8
	bl VSStageSelectMenu__Func_2162244
	cmp r0, #0
	beq _021618F2
	ldr r1, _02161ACC // =0x0217DE06
	mov r0, r7
	ldrh r1, [r1, #2]
	add r1, r1, #2
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	b _021618FA
_021618F2:
	mov r0, r7
	mov r1, #0xa
	bl AnimatorSprite__SetAnimation
_021618FA:
	ldr r1, _02161ACC // =0x0217DE06
	mov r2, #4
	ldrsh r1, [r1, r2]
	mov r0, #0x32
	lsl r0, r0, #4
	add r0, r5, r0
	add r1, r1, #6
	strh r1, [r0, #8]
	ldr r1, _02161ACC // =0x0217DE06
	mov r2, #6
	ldrsh r1, [r1, r2]
	add r1, #0xa
	strh r1, [r0, #0xa]
	b _021619CC
_02161916:
	ldr r7, _02161AD0 // =0x0217DE12
	mov r0, #0x4b
	ldrh r1, [r7, #2]
	lsl r0, r0, #2
	add r0, r5, r0
	add r1, r1, #2
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #4
	ldrsh r1, [r7, r1]
	mov r0, #0x32
	lsl r0, r0, #4
	add r0, r5, r0
	add r1, r1, #6
	strh r1, [r0, #8]
	mov r1, #6
	ldrsh r1, [r7, r1]
	add r1, #0xa
	strh r1, [r0, #0xa]
	b _021619CC
_02161942:
	ldr r7, _02161AD4 // =0x0217DE1E
	mov r0, #0x19
	ldrh r1, [r7, #2]
	lsl r0, r0, #4
	add r0, r5, r0
	add r1, r1, #2
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #4
	ldrsh r1, [r7, r1]
	mov r0, #0x32
	lsl r0, r0, #4
	add r0, r5, r0
	add r1, r1, #6
	strh r1, [r0, #8]
	mov r1, #6
	ldrsh r1, [r7, r1]
	add r1, #0xa
	strh r1, [r0, #0xa]
	b _021619CC
_0216196E:
	cmp r0, #0
	beq _02161978
	cmp r0, #1
	beq _021619A2
	b _021619CC
_02161978:
	ldr r7, _02161ACC // =0x0217DE06
	mov r0, r5
	ldrh r1, [r7, #2]
	add r0, #0xc8
	add r1, r1, #2
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #4
	ldrsh r1, [r7, r1]
	mov r0, #0x32
	lsl r0, r0, #4
	add r0, r5, r0
	add r1, r1, #6
	strh r1, [r0, #8]
	mov r1, #6
	ldrsh r1, [r7, r1]
	add r1, #0xa
	strh r1, [r0, #0xa]
	b _021619CC
_021619A2:
	ldr r7, _02161AD4 // =0x0217DE1E
	mov r0, #0x19
	ldrh r1, [r7, #2]
	lsl r0, r0, #4
	add r0, r5, r0
	add r1, r1, #2
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #4
	ldrsh r1, [r7, r1]
	mov r0, #0x32
	lsl r0, r0, #4
	add r0, r5, r0
	add r1, r1, #6
	strh r1, [r0, #8]
	mov r1, #6
	ldrsh r1, [r7, r1]
	add r1, #0xa
	strh r1, [r0, #0xa]
_021619CC:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _021619D8
	mov r0, #2
	bl PlaySysMenuNavSfx
_021619D8:
	ldr r0, _02161AD8 // =padInput
	ldrh r1, [r0, #4]
	ldr r0, _02161ADC // =0x00000C09
	tst r0, r1
	bne _02161A00
	ldr r1, _02161AE0 // =0x00000534
	mov r2, #1
	ldr r0, [r5, r1]
	lsl r2, r2, #0x12
	tst r0, r2
	bne _02161A00
	mov r0, r1
	add r0, #0x38
	ldr r0, [r5, r0]
	tst r0, r2
	bne _02161A00
	add r1, #0x70
	ldr r0, [r5, r1]
	tst r0, r2
	beq _02161AC8
_02161A00:
	mov r0, #0x4b
	lsl r0, r0, #4
	add r1, r5, r0
	ldr r0, _02161AE4 // =0x000005C8
	add r0, r5, r0
	cmp r1, r0
	beq _02161A1C
	mov r2, #0x80
_02161A10:
	ldr r3, [r1, #0x14]
	orr r3, r2
	str r3, [r1, #0x14]
	add r1, #0x38
	cmp r1, r0
	bne _02161A10
_02161A1C:
	ldr r1, _02161AE8 // =VSStageSelectMenu__State_2161AF4
	mov r0, r6
	bl VSStageSelectMenu__SetState
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	ldrb r0, [r4, #5]
	beq _02161A90
	cmp r0, #0
	beq _02161A3C
	cmp r0, #1
	beq _02161A64
	cmp r0, #2
	beq _02161A7A
	b _02161AC2
_02161A3C:
	ldrb r0, [r4, #4]
	ldr r6, _02161ACC // =0x0217DE06
	add r5, #0xc8
	bl VSStageSelectMenu__Func_2162244
	cmp r0, #0
	beq _02161A5A
	ldrh r1, [r6, #2]
	mov r0, r5
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	b _02161AC2
_02161A5A:
	mov r0, r5
	mov r1, #9
	bl AnimatorSprite__SetAnimation
	b _02161AC2
_02161A64:
	ldr r1, _02161AEC // =0x0217DE0C
	mov r0, #0x4b
	ldrh r1, [r1, #8]
	lsl r0, r0, #2
	add r0, r5, r0
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	b _02161AC2
_02161A7A:
	ldr r1, _02161AEC // =0x0217DE0C
	mov r0, #0x19
	ldrh r1, [r1, #0x14]
	lsl r0, r0, #4
	add r0, r5, r0
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	b _02161AC2
_02161A90:
	cmp r0, #0
	beq _02161A9A
	cmp r0, #1
	beq _02161AAE
	b _02161AC2
_02161A9A:
	ldr r1, _02161AF0 // =0x0217DDCC
	add r5, #0xc8
	ldrh r1, [r1, #0x3c]
	mov r0, r5
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	b _02161AC2
_02161AAE:
	ldr r1, _02161AEC // =0x0217DE0C
	mov r0, #0x19
	ldrh r1, [r1, #0x14]
	lsl r0, r0, #4
	add r0, r5, r0
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
_02161AC2:
	mov r0, #0
	bl PlaySysMenuNavSfx
_02161AC8:
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02161ACC: .word 0x0217DE06
_02161AD0: .word 0x0217DE12
_02161AD4: .word 0x0217DE1E
_02161AD8: .word padInput
_02161ADC: .word 0x00000C09
_02161AE0: .word 0x00000534
_02161AE4: .word 0x000005C8
_02161AE8: .word VSStageSelectMenu__State_2161AF4
_02161AEC: .word 0x0217DE0C
_02161AF0: .word 0x0217DDCC
	thumb_func_end VSStageSelectMenu__State_2161588

	thumb_func_start VSStageSelectMenu__State_2161AF4
VSStageSelectMenu__State_2161AF4: // 0x02161AF4
	push {r3, lr}
	ldr r1, [r0, #0x18]
	cmp r1, #0
	beq _02161B0C
	ldrh r2, [r0, #0x14]
	mov r1, #4
	bic r2, r1
	ldr r1, _02161B24 // =VSStageSelectMenu__State_2161B28
	strh r2, [r0, #0x14]
	bl VSStageSelectMenu__SetState
	pop {r3, pc}
_02161B0C:
	ldr r1, [r0, #0x10]
	cmp r1, #0x20
	bls _02161B20
	ldrh r2, [r0, #0x14]
	mov r1, #4
	bic r2, r1
	ldr r1, _02161B24 // =VSStageSelectMenu__State_2161B28
	strh r2, [r0, #0x14]
	bl VSStageSelectMenu__SetState
_02161B20:
	pop {r3, pc}
	nop
_02161B24: .word VSStageSelectMenu__State_2161B28
	thumb_func_end VSStageSelectMenu__State_2161AF4

	thumb_func_start VSStageSelectMenu__State_2161B28
VSStageSelectMenu__State_2161B28: // 0x02161B28
	push {r4, lr}
	ldr r1, _02161B58 // =0x00000618
	ldr r2, [r0, #0x10]
	add r4, r0, r1
	cmp r2, #0xc
	bls _02161B48
	mov r1, #0
	strh r1, [r4, #0x3a]
	ldrh r2, [r0, #0x14]
	mov r1, #7
	bic r2, r1
	ldr r1, _02161B5C // =VSStageSelectMenu__State_2161B60
	strh r2, [r0, #0x14]
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
_02161B48:
	mov r1, #0xc
	sub r0, r1, r2
	lsl r0, r0, #0xc
	bl _u32_div_f
	strh r0, [r4, #0x3a]
	pop {r4, pc}
	nop
_02161B58: .word 0x00000618
_02161B5C: .word VSStageSelectMenu__State_2161B60
	thumb_func_end VSStageSelectMenu__State_2161B28

	thumb_func_start VSStageSelectMenu__State_2161B60
VSStageSelectMenu__State_2161B60: // 0x02161B60
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldrh r1, [r7, #0x14]
	mov r4, r7
	mov r0, #7
	bic r1, r0
	add r4, #0x20
	strh r1, [r7, #0x14]
	ldr r1, [r4, #0x10]
	mov r0, #1
	tst r0, r1
	beq _02161B82
	mov r0, #2
	mov r1, #0
	bl VSLobbyMenu__Func_2163CE0
	b _02161BF8
_02161B82:
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	beq _02161BDA
	ldrb r1, [r4, #4]
	ldrb r0, [r4, #5]
	cmp r1, #7
	blo _02161BB2
	cmp r0, #0
	beq _02161BA0
	cmp r0, #1
	beq _02161BA0
	cmp r0, #2
	beq _02161BA8
	b _02161BF8
_02161BA0:
	mov r0, #0xc
	bl VSLobbyMenu__Func_2163CE0
	b _02161BF8
_02161BA8:
	mov r0, #0xb
	mov r1, #0
	bl VSLobbyMenu__Func_2163CE0
	b _02161BF8
_02161BB2:
	cmp r0, #0
	beq _02161BC0
	cmp r0, #1
	beq _02161BC8
	cmp r0, #2
	beq _02161BD0
	b _02161BF8
_02161BC0:
	mov r0, #9
	bl VSLobbyMenu__Func_2163CE0
	b _02161BF8
_02161BC8:
	mov r0, #0xa
	bl VSLobbyMenu__Func_2163CE0
	b _02161BF8
_02161BD0:
	mov r0, #0xb
	mov r1, #0
	bl VSLobbyMenu__Func_2163CE0
	b _02161BF8
_02161BDA:
	ldrb r0, [r4, #5]
	cmp r0, #0
	beq _02161BE6
	cmp r0, #1
	beq _02161BF0
	b _02161BF8
_02161BE6:
	ldrb r1, [r4, #4]
	mov r0, #7
	bl VSLobbyMenu__Func_2163CE0
	b _02161BF8
_02161BF0:
	mov r0, #0xb
	mov r1, #0
	bl VSLobbyMenu__Func_2163CE0
_02161BF8:
	ldr r0, _02161C50 // =0x00000618
	add r0, r7, r0
	bl VSStageSelectMenu__ReleaseFonts
	mov r0, r7
	add r0, #0x50
	bl VSStageSelectMenu__ReleaseSprites
	mov r5, r7
	mov r0, #0xc
	beq _02161C20
	mov r6, r7
	add r6, #0xc
_02161C12:
	ldr r0, [r5]
	bl DestroyTask
	mov r0, #0
	stmia r5!, {r0}
	cmp r5, r6
	bne _02161C12
_02161C20:
	ldr r0, [r7, #0x18]
	cmp r0, #0
	bne _02161C2C
	mov r0, #2
	str r0, [r4]
	pop {r3, r4, r5, r6, r7, pc}
_02161C2C:
	ldr r1, [r4, #0x10]
	mov r0, #1
	tst r0, r1
	beq _02161C4A
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _02161C4A
	ldr r0, [r7, #0x1c]
	cmp r0, #0
	beq _02161C4A
	bl ReleaseStageCommonArchives
	bl FlushStageArea
_02161C4A:
	mov r0, #4
	str r0, [r4]
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02161C50: .word 0x00000618
	thumb_func_end VSStageSelectMenu__State_2161B60

	thumb_func_start VSStageSelectMenu__State_2161C54
VSStageSelectMenu__State_2161C54: // 0x02161C54
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	ldr r0, [r5, #0x18]
	mov r4, r5
	add r4, #0x50
	cmp r0, #0
	ldr r1, [r5, #0x30]
	beq _02161C86
	mov r0, #2
	tst r0, r1
	beq _02161C74
	ldr r0, _02161D94 // =0x00000654
	mov r1, #0
	ldr r0, [r5, r0]
	bl NNS_SndPlayerStopSeq
_02161C74:
	ldrh r1, [r5, #0x14]
	mov r0, #4
	bic r1, r0
	strh r1, [r5, #0x14]
	ldr r1, _02161D98 // =VSStageSelectMenu__State_2161B28
	mov r0, r5
	bl VSStageSelectMenu__SetState
	pop {r3, r4, r5, r6, r7, pc}
_02161C86:
	mov r0, #2
	tst r0, r1
	bne _02161C94
	bl VSLobbyMenu__Func_2163D20
	mov r6, r0
	b _02161CA8
_02161C94:
	ldr r0, [r5, #0x10]
	cmp r0, #0x78
	bls _02161CA2
	bl VSLobbyMenu__Func_2163D20
	mov r6, r0
	b _02161CA8
_02161CA2:
	bl VSLobbyMenu__Func_2163D34
	mov r6, r0
_02161CA8:
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	beq _02161CB8
	ldr r0, _02161D9C // =0x0217DD64
	ldrb r7, [r0, r6]
	ldr r0, _02161DA0 // =0x0217DD78
	b _02161CBE
_02161CB8:
	ldr r0, _02161DA4 // =0x0217DD54
	ldrb r7, [r0, r6]
	ldr r0, _02161DA8 // =0x0217DD4C
_02161CBE:
	ldrb r6, [r0, r6]
	lsl r0, r7, #0x18
	lsr r0, r0, #0x18
	bl VSStageSelectMenu__Func_2162210
	mov r1, r0
	mov r0, r4
	bl AnimatorSprite__SetAnimation
	cmp r6, #0
	bne _02161D1E
	mov r0, #0x4b
	lsl r0, r0, #2
	add r2, r4, r0
	ldr r1, [r2, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r2, #0x3c]
	add r4, #0xc8
	ldr r1, [r4, #0x3c]
	mov r0, #1
	bic r1, r0
	str r1, [r4, #0x3c]
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	beq _02161D38
	lsl r0, r7, #0x18
	lsr r0, r0, #0x18
	bl VSStageSelectMenu__Func_2162244
	cmp r0, #0
	beq _02161D04
	mov r1, #2
	b _02161D06
_02161D04:
	mov r1, #0xa
_02161D06:
	ldrh r0, [r4, #0xc]
	cmp r0, r1
	beq _02161D38
	mov r0, r4
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	b _02161D38
_02161D1E:
	mov r2, r4
	add r2, #0xc8
	ldr r1, [r2, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r2, #0x3c]
	mov r0, #0x4b
	lsl r0, r0, #2
	add r2, r4, r0
	ldr r1, [r2, #0x3c]
	mov r0, #1
	bic r1, r0
	str r1, [r2, #0x3c]
_02161D38:
	ldr r1, [r5, #0x30]
	mov r0, #2
	tst r0, r1
	bne _02161D62
	mov r0, #6
	bl PlaySysSfx
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _02161D58
	ldr r1, _02161DAC // =VSStageSelectMenu__State_2161DE8
	mov r0, r5
	bl VSStageSelectMenu__SetState
	pop {r3, r4, r5, r6, r7, pc}
_02161D58:
	ldr r1, _02161DB0 // =VSStageSelectMenu__State_2161DB4
	mov r0, r5
	bl VSStageSelectMenu__SetState
	pop {r3, r4, r5, r6, r7, pc}
_02161D62:
	ldr r0, [r5, #0x10]
	cmp r0, #0x78
	bls _02161D92
	ldr r0, _02161D94 // =0x00000654
	mov r1, #0
	ldr r0, [r5, r0]
	bl NNS_SndPlayerStopSeq
	mov r0, #6
	bl PlaySysSfx
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _02161D8A
	ldr r1, _02161DAC // =VSStageSelectMenu__State_2161DE8
	mov r0, r5
	bl VSStageSelectMenu__SetState
	pop {r3, r4, r5, r6, r7, pc}
_02161D8A:
	ldr r1, _02161DB0 // =VSStageSelectMenu__State_2161DB4
	mov r0, r5
	bl VSStageSelectMenu__SetState
_02161D92:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02161D94: .word 0x00000654
_02161D98: .word VSStageSelectMenu__State_2161B28
_02161D9C: .word 0x0217DD64
_02161DA0: .word 0x0217DD78
_02161DA4: .word 0x0217DD54
_02161DA8: .word 0x0217DD4C
_02161DAC: .word VSStageSelectMenu__State_2161DE8
_02161DB0: .word VSStageSelectMenu__State_2161DB4
	thumb_func_end VSStageSelectMenu__State_2161C54

	thumb_func_start VSStageSelectMenu__State_2161DB4
VSStageSelectMenu__State_2161DB4: // 0x02161DB4
	push {r3, lr}
	ldr r1, [r0, #0x18]
	cmp r1, #0
	beq _02161DCC
	ldrh r2, [r0, #0x14]
	mov r1, #4
	bic r2, r1
	ldr r1, _02161DE4 // =VSStageSelectMenu__State_2161B28
	strh r2, [r0, #0x14]
	bl VSStageSelectMenu__SetState
	pop {r3, pc}
_02161DCC:
	ldr r1, [r0, #0x10]
	cmp r1, #0x78
	bls _02161DE0
	ldrh r2, [r0, #0x14]
	mov r1, #4
	bic r2, r1
	ldr r1, _02161DE4 // =VSStageSelectMenu__State_2161B28
	strh r2, [r0, #0x14]
	bl VSStageSelectMenu__SetState
_02161DE0:
	pop {r3, pc}
	nop
_02161DE4: .word VSStageSelectMenu__State_2161B28
	thumb_func_end VSStageSelectMenu__State_2161DB4

	thumb_func_start VSStageSelectMenu__State_2161DE8
VSStageSelectMenu__State_2161DE8: // 0x02161DE8
	push {r3, r4, r5, r6, r7, lr}
	mov r1, r0
	ldr r1, [r1, #0x18]
	mov r4, r0
	add r4, #0x50
	str r0, [sp]
	cmp r1, #0
	beq _02161E0C
	mov r1, r0
	ldrh r2, [r1, #0x14]
	mov r1, #4
	bic r2, r1
	mov r1, r0
	strh r2, [r1, #0x14]
	ldr r1, _02161E5C // =VSStageSelectMenu__State_2161B28
	bl VSStageSelectMenu__SetState
	pop {r3, r4, r5, r6, r7, pc}
_02161E0C:
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	beq _02161E5A
	bl MultibootManager__Func_2060D0C
	mov r0, #2
	mov r1, #0
	bl VSLobbyMenu__Func_2163CE0
	mov r0, #0xe1
	lsl r0, r0, #2
	ldr r5, _02161E60 // =0x0217DE5A
	mov r6, #9
	add r4, r4, r0
	mov r7, #1
_02161E2C:
	ldrh r1, [r5, #2]
	mov r0, r4
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x3c]
	mov r1, #0
	bic r0, r7
	str r0, [r4, #0x3c]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	add r4, #0x64
	add r5, #0xc
	cmp r6, #0xc
	blo _02161E2C
	bl MultibootManager__Func_206193C
	ldr r0, [sp]
	ldr r1, _02161E64 // =VSStageSelectMenu__State_2161E68
	bl VSStageSelectMenu__SetState
_02161E5A:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02161E5C: .word VSStageSelectMenu__State_2161B28
_02161E60: .word 0x0217DE5A
_02161E64: .word VSStageSelectMenu__State_2161E68
	thumb_func_end VSStageSelectMenu__State_2161DE8

	thumb_func_start VSStageSelectMenu__State_2161E68
VSStageSelectMenu__State_2161E68: // 0x02161E68
	push {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x18]
	cmp r1, #0
	beq _02161E82
	ldrh r2, [r4, #0x14]
	mov r1, #4
	bic r2, r1
	ldr r1, _02161EA0 // =VSStageSelectMenu__State_2161B28
	strh r2, [r4, #0x14]
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
_02161E82:
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	beq _02161E9E
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	beq _02161E9E
	bl MultibootManager__Func_206193C
	ldr r1, _02161EA4 // =VSStageSelectMenu__State_2161EA8
	mov r0, r4
	bl VSStageSelectMenu__SetState
_02161E9E:
	pop {r4, pc}
	.align 2, 0
_02161EA0: .word VSStageSelectMenu__State_2161B28
_02161EA4: .word VSStageSelectMenu__State_2161EA8
	thumb_func_end VSStageSelectMenu__State_2161E68

	thumb_func_start VSStageSelectMenu__State_2161EA8
VSStageSelectMenu__State_2161EA8: // 0x02161EA8
	push {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x18]
	cmp r1, #0
	beq _02161EC2
	ldrh r2, [r4, #0x14]
	mov r1, #4
	bic r2, r1
	ldr r1, _02161EDC // =VSStageSelectMenu__State_2161B28
	strh r2, [r4, #0x14]
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
_02161EC2:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	beq _02161ED8
	mov r0, #3
	bl VSLobbyMenu__RemoveFlag
	ldr r1, _02161EE0 // =VSStageSelectMenu__State_2161EE4
	mov r0, r4
	bl VSStageSelectMenu__SetState
_02161ED8:
	pop {r4, pc}
	nop
_02161EDC: .word VSStageSelectMenu__State_2161B28
_02161EE0: .word VSStageSelectMenu__State_2161EE4
	thumb_func_end VSStageSelectMenu__State_2161EA8

	thumb_func_start VSStageSelectMenu__State_2161EE4
VSStageSelectMenu__State_2161EE4: // 0x02161EE4
	push {r4, lr}
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	bgt _02161EF4
	beq _02161F28
	b _02161F3E
_02161EF4:
	sub r0, #0xc
	cmp r0, #0xa
	bhi _02161F3E
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02161F06: // jump table
	.hword _02161F1C - _02161F06 - 2 // case 0
	.hword _02161F26 - _02161F06 - 2 // case 1
	.hword _02161F3E - _02161F06 - 2 // case 2
	.hword _02161F3E - _02161F06 - 2 // case 3
	.hword _02161F3E - _02161F06 - 2 // case 4
	.hword _02161F3E - _02161F06 - 2 // case 5
	.hword _02161F3E - _02161F06 - 2 // case 6
	.hword _02161F3E - _02161F06 - 2 // case 7
	.hword _02161F3E - _02161F06 - 2 // case 8
	.hword _02161F20 - _02161F06 - 2 // case 9
	.hword _02161F22 - _02161F06 - 2 // case 10
_02161F1C:
	bl MultibootManager__Func_206150C
_02161F20:
	pop {r4, pc}
_02161F22:
	bl MultibootManager__Func_206147C
_02161F26:
	pop {r4, pc}
_02161F28:
	mov r0, #1
	str r0, [r4, #0x18]
	ldrh r1, [r4, #0x14]
	mov r0, #4
	bic r1, r0
	strh r1, [r4, #0x14]
	ldr r1, _02161F70 // =VSStageSelectMenu__State_2161B28
	mov r0, r4
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
_02161F3E:
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	beq _02161F4E
	mov r0, #1
	bl InitGameDataLoadContext
	b _02161F54
_02161F4E:
	mov r0, #0
	bl InitGameDataLoadContext
_02161F54:
	bl VSLobbyMenu__Func_2163D90
	cmp r0, #0
	beq _02161F66
	ldr r1, _02161F74 // =VSStageSelectMenu__State_2161F7C
	mov r0, r4
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
_02161F66:
	ldr r1, _02161F78 // =VSStageSelectMenu__State_216207C
	mov r0, r4
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
	.align 2, 0
_02161F70: .word VSStageSelectMenu__State_2161B28
_02161F74: .word VSStageSelectMenu__State_2161F7C
_02161F78: .word VSStageSelectMenu__State_216207C
	thumb_func_end VSStageSelectMenu__State_2161EE4

	thumb_func_start VSStageSelectMenu__State_2161F7C
VSStageSelectMenu__State_2161F7C: // 0x02161F7C
	push {r4, lr}
	mov r4, r0
	bl LoadStageCommonAssets
	cmp r0, #0
	beq _02161FCA
	cmp r0, #1
	beq _02161F92
	cmp r0, #2
	beq _02161FB2
	pop {r4, pc}
_02161F92:
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	beq _02161FA2
	mov r0, #1
	bl InitGameDataLoadContext
	b _02161FA8
_02161FA2:
	mov r0, #0
	bl InitGameDataLoadContext
_02161FA8:
	ldr r1, _02161FCC // =VSStageSelectMenu__State_2161FD4
	mov r0, r4
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
_02161FB2:
	mov r0, #1
	str r0, [r4, #0x18]
	bl ReleaseStageCommonArchives
	ldrh r1, [r4, #0x14]
	mov r0, #4
	bic r1, r0
	strh r1, [r4, #0x14]
	ldr r1, _02161FD0 // =VSStageSelectMenu__State_2161B28
	mov r0, r4
	bl VSStageSelectMenu__SetState
_02161FCA:
	pop {r4, pc}
	.align 2, 0
_02161FCC: .word VSStageSelectMenu__State_2161FD4
_02161FD0: .word VSStageSelectMenu__State_2161B28
	thumb_func_end VSStageSelectMenu__State_2161F7C

	thumb_func_start VSStageSelectMenu__State_2161FD4
VSStageSelectMenu__State_2161FD4: // 0x02161FD4
	push {r4, lr}
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0xe
	bgt _02161FE8
	bge _02161FF6
	cmp r0, #0
	beq _02161FFC
	b _02162016
_02161FE8:
	cmp r0, #0x16
	bgt _02162016
	cmp r0, #0x15
	blt _02162016
	beq _0216201E
	cmp r0, #0x16
	b _02162016
_02161FF6:
	bl MultibootManager__Func_206150C
	pop {r4, pc}
_02161FFC:
	mov r0, #1
	str r0, [r4, #0x18]
	bl ReleaseStageCommonArchives
	ldrh r1, [r4, #0x14]
	mov r0, #4
	bic r1, r0
	strh r1, [r4, #0x14]
	ldr r1, _02162020 // =VSStageSelectMenu__State_2161B28
	mov r0, r4
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
_02162016:
	ldr r1, _02162024 // =VSStageSelectMenu__State_2162028
	mov r0, r4
	bl VSStageSelectMenu__SetState
_0216201E:
	pop {r4, pc}
	.align 2, 0
_02162020: .word VSStageSelectMenu__State_2161B28
_02162024: .word VSStageSelectMenu__State_2162028
	thumb_func_end VSStageSelectMenu__State_2161FD4

	thumb_func_start VSStageSelectMenu__State_2162028
VSStageSelectMenu__State_2162028: // 0x02162028
	push {r4, lr}
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0xe
	bgt _02162044
	cmp r0, #0xd
	blt _0216203E
	beq _02162070
	cmp r0, #0xe
	b _02162068
_0216203E:
	cmp r0, #0
	beq _0216204E
	b _02162068
_02162044:
	cmp r0, #0x16
	bne _02162068
	bl MultibootManager__Func_206147C
	pop {r4, pc}
_0216204E:
	mov r0, #1
	str r0, [r4, #0x18]
	bl ReleaseStageCommonArchives
	ldrh r1, [r4, #0x14]
	mov r0, #4
	bic r1, r0
	strh r1, [r4, #0x14]
	ldr r1, _02162074 // =VSStageSelectMenu__State_2161B28
	mov r0, r4
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
_02162068:
	ldr r1, _02162078 // =VSStageSelectMenu__State_216207C
	mov r0, r4
	bl VSStageSelectMenu__SetState
_02162070:
	pop {r4, pc}
	nop
_02162074: .word VSStageSelectMenu__State_2161B28
_02162078: .word VSStageSelectMenu__State_216207C
	thumb_func_end VSStageSelectMenu__State_2162028

	thumb_func_start VSStageSelectMenu__State_216207C
VSStageSelectMenu__State_216207C: // 0x0216207C
	push {r4, lr}
	mov r4, r0
	mov r0, #0x20
	bl VSLobbyMenu__FadeSysTrack
	bl LoadStageAssets
	cmp r0, #0
	beq _021620C0
	cmp r0, #1
	beq _02162098
	cmp r0, #2
	beq _021620A2
	b _021620C0
_02162098:
	ldr r1, _021620CC // =VSStageSelectMenu__State_21620D4
	mov r0, r4
	bl VSStageSelectMenu__SetState
	b _021620C0
_021620A2:
	mov r0, #1
	str r0, [r4, #0x18]
	bl ReleaseStageCommonArchives
	bl FlushStageArea
	ldrh r1, [r4, #0x14]
	mov r0, #4
	bic r1, r0
	strh r1, [r4, #0x14]
	ldr r1, _021620D0 // =VSStageSelectMenu__State_2161B28
	mov r0, r4
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
_021620C0:
	ldr r1, _021620CC // =VSStageSelectMenu__State_21620D4
	mov r0, r4
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
	nop
_021620CC: .word VSStageSelectMenu__State_21620D4
_021620D0: .word VSStageSelectMenu__State_2161B28
	thumb_func_end VSStageSelectMenu__State_216207C

	thumb_func_start VSStageSelectMenu__State_21620D4
VSStageSelectMenu__State_21620D4: // 0x021620D4
	push {r4, lr}
	mov r4, r0
	bl LoadStageAssets
	cmp r0, #0
	beq _02162112
	cmp r0, #1
	beq _021620EA
	cmp r0, #2
	beq _021620F4
	b _02162112
_021620EA:
	ldr r1, _02162138 // =VSStageSelectMenu__State_2162144
	mov r0, r4
	bl VSStageSelectMenu__SetState
	b _02162112
_021620F4:
	mov r0, #1
	str r0, [r4, #0x18]
	bl ReleaseStageCommonArchives
	bl FlushStageArea
	ldrh r1, [r4, #0x14]
	mov r0, #4
	bic r1, r0
	strh r1, [r4, #0x14]
	ldr r1, _0216213C // =VSStageSelectMenu__State_2161B28
	mov r0, r4
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
_02162112:
	ldr r0, [r4, #0x10]
	cmp r0, #0x20
	bls _02162136
	ldr r0, _02162140 // =0x00000654
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0216212A
	bl FreeSndHandle
	ldr r0, _02162140 // =0x00000654
	mov r1, #0
	str r1, [r4, r0]
_0216212A:
	bl VSLobbyMenu__Func_2163E18
	ldr r1, _02162138 // =VSStageSelectMenu__State_2162144
	mov r0, r4
	bl VSStageSelectMenu__SetState
_02162136:
	pop {r4, pc}
	.align 2, 0
_02162138: .word VSStageSelectMenu__State_2162144
_0216213C: .word VSStageSelectMenu__State_2161B28
_02162140: .word 0x00000654
	thumb_func_end VSStageSelectMenu__State_21620D4

	thumb_func_start VSStageSelectMenu__State_2162144
VSStageSelectMenu__State_2162144: // 0x02162144
	push {r4, lr}
	mov r4, r0
	bl LoadStageAssets
	cmp r0, #0
	beq _02162180
	cmp r0, #1
	beq _0216215A
	cmp r0, #2
	beq _02162164
	pop {r4, pc}
_0216215A:
	ldr r1, _02162184 // =VSStageSelectMenu__State_216218C
	mov r0, r4
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
_02162164:
	mov r0, #1
	str r0, [r4, #0x18]
	bl ReleaseStageCommonArchives
	bl FlushStageArea
	ldrh r1, [r4, #0x14]
	mov r0, #4
	bic r1, r0
	strh r1, [r4, #0x14]
	ldr r1, _02162188 // =VSStageSelectMenu__State_2161B28
	mov r0, r4
	bl VSStageSelectMenu__SetState
_02162180:
	pop {r4, pc}
	nop
_02162184: .word VSStageSelectMenu__State_216218C
_02162188: .word VSStageSelectMenu__State_2161B28
	thumb_func_end VSStageSelectMenu__State_2162144

	thumb_func_start VSStageSelectMenu__State_216218C
VSStageSelectMenu__State_216218C: // 0x0216218C
	push {r4, lr}
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0xe
	bgt _021621AE
	cmp r0, #0xb
	blt _021621A8
	beq _02162208
	cmp r0, #0xc
	beq _021621E6
	cmp r0, #0xe
	beq _021621BC
	b _021621E6
_021621A8:
	cmp r0, #0
	beq _021621C8
	b _021621E6
_021621AE:
	cmp r0, #0x15
	bgt _021621B6
	beq _02162208
	b _021621E6
_021621B6:
	cmp r0, #0x16
	beq _021621C2
	b _021621E6
_021621BC:
	bl MultibootManager__Func_206150C
	pop {r4, pc}
_021621C2:
	bl MultibootManager__Func_20613E4
	pop {r4, pc}
_021621C8:
	mov r0, #1
	str r0, [r4, #0x18]
	bl ReleaseStageCommonArchives
	bl FlushStageArea
	ldrh r1, [r4, #0x14]
	mov r0, #4
	bic r1, r0
	strh r1, [r4, #0x14]
	ldr r1, _0216220C // =VSStageSelectMenu__State_2161B28
	mov r0, r4
	bl VSStageSelectMenu__SetState
	pop {r4, pc}
_021621E6:
	mov r0, #1
	str r0, [r4, #0x1c]
	mov r0, #2
	mov r1, #0
	bl VSLobbyMenu__Func_2163CE0
	mov r0, #3
	bl VSLobbyMenu__SetFlag
	ldrh r1, [r4, #0x14]
	mov r0, #4
	bic r1, r0
	strh r1, [r4, #0x14]
	ldr r1, _0216220C // =VSStageSelectMenu__State_2161B28
	mov r0, r4
	bl VSStageSelectMenu__SetState
_02162208:
	pop {r4, pc}
	nop
_0216220C: .word VSStageSelectMenu__State_2161B28
	thumb_func_end VSStageSelectMenu__State_216218C

	thumb_func_start VSStageSelectMenu__Func_2162210
VSStageSelectMenu__Func_2162210: // 0x02162210
	push {r4, lr}
	mov r4, r0
	bl VSStageSelectMenu__IsRace
	cmp r0, #0
	beq _02162222
	ldr r0, _02162228 // =0x0217DD58
	ldrb r0, [r0, r4]
	pop {r4, pc}
_02162222:
	ldr r0, _0216222C // =0x0217DD50
	ldrb r0, [r0, r4]
	pop {r4, pc}
	.align 2, 0
_02162228: .word 0x0217DD58
_0216222C: .word 0x0217DD50
	thumb_func_end VSStageSelectMenu__Func_2162210

	thumb_func_start VSStageSelectMenu__IsRace
VSStageSelectMenu__IsRace: // 0x02162230
	ldr r0, _02162240 // =gameState
	ldr r0, [r0, #0x20]
	cmp r0, #0
	bne _0216223C
	mov r0, #1
	bx lr
_0216223C:
	mov r0, #0
	bx lr
	.align 2, 0
_02162240: .word gameState
	thumb_func_end VSStageSelectMenu__IsRace

	thumb_func_start VSStageSelectMenu__Func_2162244
VSStageSelectMenu__Func_2162244: // 0x02162244
	cmp r0, #7
	bhs _0216224C
	mov r0, #1
	bx lr
_0216224C:
	mov r0, #0
	bx lr
	thumb_func_end VSStageSelectMenu__Func_2162244

	thumb_func_start VSStageSelectMenu__Main1
VSStageSelectMenu__Main1: // 0x02162250
	push {r3, lr}
	ldr r0, _02162260 // =VSStageSelect__sVars
	ldr r0, [r0]
	ldr r1, [r0, #0xc]
	cmp r1, #0
	beq _0216225E
	blx r1
_0216225E:
	pop {r3, pc}
	.align 2, 0
_02162260: .word VSStageSelect__sVars
	thumb_func_end VSStageSelectMenu__Main1

	thumb_func_start VSStageSelectMenu__Main2
VSStageSelectMenu__Main2: // 0x02162264
	push {r3, lr}
	ldr r0, _02162280 // =VSStageSelect__sVars
	ldr r0, [r0]
	ldr r1, [r0, #0x10]
	add r1, r1, #1
	str r1, [r0, #0x10]
	ldrh r2, [r0, #0x14]
	mov r1, #1
	tst r1, r2
	beq _0216227C
	bl VSStageSelectMenu__Func_2161108
_0216227C:
	pop {r3, pc}
	nop
_02162280: .word VSStageSelect__sVars
	thumb_func_end VSStageSelectMenu__Main2

	thumb_func_start VSStageSelectMenu__Main3
VSStageSelectMenu__Main3: // 0x02162284
	push {r3, lr}
	ldr r0, _02162298 // =VSStageSelect__sVars
	mov r1, #6
	ldr r0, [r0]
	ldrh r2, [r0, #0x14]
	tst r1, r2
	beq _02162296
	bl VSStageSelectMenu__Func_2161144
_02162296:
	pop {r3, pc}
	.align 2, 0
_02162298: .word VSStageSelect__sVars
	thumb_func_end VSStageSelectMenu__Main3
	
	.data

aDmasVsDeuBac_0: // 0x0217E9BC
	.asciz "/dmas_vs_deu.bac"
	.align 4
	
aDmasVsItaBac_0: // 0x0217E9D0
	.asciz "/dmas_vs_ita.bac"
	.align 4
	
aDmasVsSpaBac_0: // 0x0217E9E4
	.asciz "/dmas_vs_spa.bac"
	.align 4
	
aDmasVsJpnBac_0: // 0x0217E9F8
	.asciz "/dmas_vs_jpn.bac"
	.align 4
	
aDmasVsEngBac_0: // 0x0217EA0C
	.asciz "/dmas_vs_eng.bac"
	.align 4
	
aDmasVsFraBac_0: // 0x0217EA20
	.asciz "/dmas_vs_fra.bac"
	.align 4
	
_0217EA34: // 0x0217EA34
	.word aDmasVsJpnBac_0		// "/dmas_vs_jpn.bac"
	.word aDmasVsEngBac_0		// "/dmas_vs_eng.bac"
	.word aDmasVsFraBac_0		// "/dmas_vs_fra.bac"
	.word aDmasVsDeuBac_0		// "/dmas_vs_deu.bac"
	.word aDmasVsItaBac_0		// "/dmas_vs_ita.bac"
	.word aDmasVsSpaBac_0		// "/dmas_vs_spa.bac"

aNarcDmasVsNarc_0: // 0x0217EA4C
	.asciz "/narc/dmas_vs.narc"
	.align 4
	
aDmasVsBac_0: // 0x0217EA60
	.asciz "/dmas_vs.bac"
	.align 4
	
aDmasVsArrowBac: // 0x0217EA70
	.asciz "/dmas_vs_arrow.bac"
	.align 4
