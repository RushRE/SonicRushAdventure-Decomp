	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__GFXControl

	.bss

.public NameMenu__sVars
NameMenu__sVars: // 0x02163094
    .space 0x04

	.text

	thumb_func_start NameMenu__LoadAssets
NameMenu__LoadAssets: // 0x0215ED58
	push {r3, lr}
	ldr r0, _0215ED98 // =0x00000EFC
	bl _AllocHeadHEAP_SYSTEM
	mov r1, r0
	ldr r0, _0215ED9C // =NameMenu__sVars
	ldr r2, _0215ED98 // =0x00000EFC
	str r1, [r0]
	mov r0, #0
	bl MIi_CpuClear32
	ldr r0, _0215ED9C // =NameMenu__sVars
	mov r1, #0
	ldr r2, [r0, #0]
	str r1, [r2, #0xc]
	ldr r2, [r0, #0]
	mov r0, #0xe3
	lsl r0, r0, #4
	add r0, r2, r0
	bl InitThreadWorker
	ldr r0, _0215EDA0 // =_02162E14
	mov r1, #0
	ldr r0, [r0, #0]
	bl BundleFileUnknown__LoadFile
	ldr r1, _0215ED9C // =NameMenu__sVars
	ldr r2, [r1, #0]
	mov r1, #0xdf
	lsl r1, r1, #4
	str r0, [r2, r1]
	pop {r3, pc}
	.align 2, 0
_0215ED98: .word 0x00000EFC
_0215ED9C: .word NameMenu__sVars
_0215EDA0: .word _02162E14
	thumb_func_end NameMenu__LoadAssets

	thumb_func_start NameMenu__Create
NameMenu__Create: // 0x0215EDA4
	push {r4, r5, lr}
	sub sp, #0xc
	ldr r3, _0215EE50 // =NameMenu__sVars
	mov r4, r1
	ldr r1, [r3, #0]
	mov r5, #1
	str r5, [r1, #0xc]
	ldr r1, [r3, #0]
	mov r5, #4
	str r0, [r1, #4]
	ldr r0, [r3, #0]
	ldr r1, _0215EE54 // =0x00000DF4
	str r2, [r0, r1]
	ldr r2, [r3, #0]
	mov r0, #0
	str r0, [r2, #0x10]
	ldr r2, [r3, #0]
	sub r1, #0xd8
	str r0, [r2, #0x14]
	ldr r2, [r3, #0]
	str r5, [r2, #0x38]
	ldr r2, [r3, #0]
	str r0, [r2, #0x34]
	ldr r2, [r3, #0]
	str r0, [r2, #0x18]
	ldr r2, [r3, #0]
	add r1, r2, r1
	mov r2, #0x14
	bl MIi_CpuClear32
	ldr r1, _0215EE50 // =NameMenu__sVars
	mov r0, #0
	ldr r1, [r1, #0]
	mov r2, #0xc
	add r1, #0x3c
	bl MIi_CpuClear32
	ldr r1, _0215EE50 // =NameMenu__sVars
	mov r2, #8
	ldr r0, [r1, #0]
	cmp r4, #0
	str r2, [r0, #8]
	beq _0215EE08
	ldr r1, [r1, #0]
	mov r0, r4
	add r1, #0x1c
	mov r2, #0x10
	bl MIi_CpuCopy16
	b _0215EE14
_0215EE08:
	ldr r1, [r1, #0]
	mov r0, #0x20
	add r1, #0x1c
	mov r2, #0x10
	bl MIi_CpuClear16
_0215EE14:
	ldr r0, _0215EE50 // =NameMenu__sVars
	ldr r0, [r0, #0]
	bl NameMenu__SetupDisplay
	ldr r0, _0215EE50 // =NameMenu__sVars
	ldr r0, [r0, #0]
	bl NameMenu__InitFontWindow
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	ldr r0, _0215EE58 // =NameMenu__Main_Loading
	ldr r1, _0215EE5C // =NameMenu__Destructor
	mov r3, r2
	str r2, [sp, #8]
	bl TaskCreate_
	ldr r2, _0215EE50 // =NameMenu__sVars
	ldr r1, _0215EE60 // =0x00000E2C
	ldr r3, [r2, #0]
	str r0, [r3, r1]
	add r0, r1, #4
	ldr r2, [r2, #0]
	ldr r1, _0215EE64 // =NameMenu__ThreadFunc
	add r0, r2, r0
	mov r3, #0x18
	bl CreateThreadWorker
	add sp, #0xc
	pop {r4, r5, pc}
	.align 2, 0
_0215EE50: .word NameMenu__sVars
_0215EE54: .word 0x00000DF4
_0215EE58: .word NameMenu__Main_Loading
_0215EE5C: .word NameMenu__Destructor
_0215EE60: .word 0x00000E2C
_0215EE64: .word NameMenu__ThreadFunc
	thumb_func_end NameMenu__Create

	thumb_func_start NameMenu__IsFinished
NameMenu__IsFinished: // 0x0215EE68
	ldr r0, _0215EE7C // =NameMenu__sVars
	ldr r0, [r0, #0]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _0215EE76
	mov r0, #1
	bx lr
_0215EE76:
	mov r0, #0
	bx lr
	nop
_0215EE7C: .word NameMenu__sVars
	thumb_func_end NameMenu__IsFinished

	thumb_func_start NameMenu__ShouldApplyName
NameMenu__ShouldApplyName: // 0x0215EE80
	ldr r0, _0215EE88 // =NameMenu__sVars
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x10]
	bx lr
	.align 2, 0
_0215EE88: .word NameMenu__sVars
	thumb_func_end NameMenu__ShouldApplyName

	thumb_func_start NameMenu__GetName
NameMenu__GetName: // 0x0215EE8C
	ldr r0, _0215EE94 // =NameMenu__sVars
	ldr r0, [r0, #0]
	add r0, #0x1c
	bx lr
	.align 2, 0
_0215EE94: .word NameMenu__sVars
	thumb_func_end NameMenu__GetName

	thumb_func_start NameMenu__ReleaseAssets
NameMenu__ReleaseAssets: // 0x0215EE98
	push {r3, lr}
	ldr r0, _0215EED8 // =NameMenu__sVars
	ldr r1, [r0, #0]
	mov r0, #0xdf
	lsl r0, r0, #4
	ldr r0, [r1, r0]
	cmp r0, #0
	beq _0215EEB8
	bl _FreeHEAP_USER
	ldr r0, _0215EED8 // =NameMenu__sVars
	mov r2, #0
	ldr r1, [r0, #0]
	mov r0, #0xdf
	lsl r0, r0, #4
	str r2, [r1, r0]
_0215EEB8:
	ldr r0, _0215EED8 // =NameMenu__sVars
	ldr r1, [r0, #0]
	mov r0, #0xe3
	lsl r0, r0, #4
	add r0, r1, r0
	bl ReleaseThreadWorker
	ldr r0, _0215EED8 // =NameMenu__sVars
	ldr r0, [r0, #0]
	bl _FreeHEAP_SYSTEM
	ldr r0, _0215EED8 // =NameMenu__sVars
	mov r1, #0
	str r1, [r0]
	pop {r3, pc}
	nop
_0215EED8: .word NameMenu__sVars
	thumb_func_end NameMenu__ReleaseAssets

	thumb_func_start NameMenu__Init
NameMenu__Init: // 0x0215EEDC
	push {r3, r4, r5, r6, r7, lr}
	mov r1, #0x62
	mov r2, #1
	mov r6, r0
	mov r0, #0
	lsl r1, r1, #0x14
	lsl r2, r2, #0x10
	bl MIi_CpuClearFast
	mov r4, #0
	mov r5, r6
	mov r7, r4
_0215EEF4:
	ldrh r0, [r5, #0x1c]
	cmp r0, #0
	bne _0215EF10
	mov r2, r6
	add r2, #0x1c
	lsl r1, r4, #1
	add r1, r2, r1
	mov r2, #8
	sub r2, r2, r4
	mov r0, #0
	lsl r2, r2, #1
	bl MIi_CpuClear16
	b _0215EF26
_0215EF10:
	bl GetFontCharacterFromUTF
	strh r0, [r5, #0x1c]
	ldrh r0, [r5, #0x1c]
	cmp r0, #0xb6
	bne _0215EF1E
	strh r7, [r5, #0x1c]
_0215EF1E:
	add r4, r4, #1
	add r5, r5, #2
	cmp r4, #8
	blt _0215EEF4
_0215EF26:
	mov r0, r6
	add r0, #0x1c
	mov r1, #8
	bl NameMenu__GetNameLength
	str r0, [r6, #0x2c]
	mov r0, #1
	strh r0, [r6, #0x30]
	mov r0, #0
	strh r0, [r6, #0x32]
	mov r0, r6
	bl NameMenu__InitAnimators
	mov r0, r6
	bl NameMenu__InitBackgrounds
	mov r0, r6
	bl NameMenu__InitUnknown2056570
	mov r0, r6
	bl NameMenu__InitTouchField
	mov r0, r6
	bl NameMenu__InitName
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
	thumb_func_end NameMenu__Init

	thumb_func_start NameMenu__SetupDisplay
NameMenu__SetupDisplay: // 0x0215EF5C
	push {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	mov r1, #0xf
	mov r2, #1
	ldr r0, _0215F064 // =0x0213D300
	mvn r1, r1
	strh r1, [r0, #0x18]
	ldr r0, _0215F068 // =0x0213D2A4
	lsl r2, r2, #0x1a
	strh r1, [r0, #0x18]
	ldr r1, [r2, #0]
	ldr r0, _0215F06C // =0xFFFFE0FF
	and r1, r0
	str r1, [r2]
	ldr r2, _0215F070 // =0x04001000
	ldr r1, [r2, #0]
	and r0, r1
	str r0, [r2]
	ldr r1, _0215F074 // =renderCurrentDisplay
	mov r0, #1
	str r0, [r1]
	mov r1, #0
	mov r2, r1
	bl GX_SetGraphicsMode
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r0, _0215F078 // =0x04000008
	mov r2, #0x43
	ldrh r1, [r0, #0]
	mov r3, r1
	and r3, r2
	mov r1, #4
	orr r1, r3
	strh r1, [r0]
	ldrh r1, [r0, #2]
	mov r3, r1
	mov r1, #0x81
	and r3, r2
	lsl r1, r1, #2
	orr r3, r1
	strh r3, [r0, #2]
	ldrh r3, [r0, #6]
	mov r5, r3
	ldr r3, _0215F07C // =0x0000060C
	and r5, r2
	orr r5, r3
	strh r5, [r0, #6]
	ldr r0, _0215F080 // =0x0400100A
	ldrh r5, [r0, #0]
	and r5, r2
	orr r5, r1
	strh r5, [r0]
	ldrh r5, [r0, #2]
	lsl r1, r1, #1
	and r5, r2
	orr r1, r5
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	and r1, r2
	orr r1, r3
	strh r1, [r0, #4]
	ldr r1, _0215F084 // =renderCoreGFXControlA
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	ldr r1, _0215F088 // =renderCoreGFXControlB
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	ldr r6, _0215F078 // =0x04000008
	mov r2, #3
	ldrh r0, [r6, #0]
	mov r1, #1
	mov r3, #2
	bic r0, r2
	strh r0, [r6]
	ldrh r0, [r6, #2]
	bic r0, r2
	orr r0, r1
	strh r0, [r6, #2]
	ldrh r0, [r6, #4]
	bic r0, r2
	orr r0, r3
	strh r0, [r6, #4]
	ldrh r5, [r6, #6]
	mov r0, #3
	ldr r7, _0215F06C // =0xFFFFE0FF
	bic r5, r2
	orr r0, r5
	strh r0, [r6, #6]
	sub r6, #8
	ldr r0, [r6, #0]
	mov r5, r0
	mov r0, #0xb
	and r5, r7
	lsl r0, r0, #8
	orr r0, r5
	str r0, [r6]
	ldr r0, _0215F08C // =0x04001008
	ldrh r5, [r0, #0]
	bic r5, r2
	strh r5, [r0]
	ldrh r5, [r0, #2]
	bic r5, r2
	orr r1, r5
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	bic r1, r2
	orr r1, r3
	strh r1, [r0, #4]
	ldrh r3, [r0, #6]
	mov r1, #3
	bic r3, r2
	orr r1, r3
	strh r1, [r0, #6]
	sub r0, #8
	ldr r1, [r0, #0]
	mov r2, r1
	mov r1, #0x1e
	and r2, r7
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r0]
	mov r0, r4
	mov r1, #0x10
	bl NameMenu__SetupBlending
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215F064: .word 0x0213D300
_0215F068: .word 0x0213D2A4
_0215F06C: .word 0xFFFFE0FF
_0215F070: .word 0x04001000
_0215F074: .word renderCurrentDisplay
_0215F078: .word 0x04000008
_0215F07C: .word 0x0000060C
_0215F080: .word 0x0400100A
_0215F084: .word renderCoreGFXControlA
_0215F088: .word renderCoreGFXControlB
_0215F08C: .word 0x04001008
	thumb_func_end NameMenu__SetupDisplay

	thumb_func_start NameMenu__InitAnimators
NameMenu__InitAnimators: // 0x0215F090
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x48
	mov r1, #0xdf
	lsl r1, r1, #4
	str r0, [sp, #0x18]
	ldr r0, [r0, r1]
	mov r1, #0
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x30]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _0215F0CE
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215F0BA: // jump table
	.hword _0215F0C6 - _0215F0BA - 2 // case 0
	.hword _0215F0C6 - _0215F0BA - 2 // case 1
	.hword _0215F0C6 - _0215F0BA - 2 // case 2
	.hword _0215F0C6 - _0215F0BA - 2 // case 3
	.hword _0215F0C6 - _0215F0BA - 2 // case 4
	.hword _0215F0C6 - _0215F0BA - 2 // case 5
_0215F0C6:
	bl RenderCore_GetLanguagePtr
	ldrb r2, [r0, #0]
	b _0215F0D0
_0215F0CE:
	mov r2, #1
_0215F0D0:
	mov r1, #0xdf
	ldr r0, [sp, #0x18]
	lsl r1, r1, #4
	ldr r0, [r0, r1]
	add r1, r2, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x2c]
	ldr r0, _0215F388 // =0x04001000
	ldr r1, _0215F38C // =0x00300010
	ldr r0, [r0, #0]
	mov r2, r0
	ldr r0, _0215F390 // =0x00100010
	and r2, r1
	cmp r2, r0
	bgt _0215F0FC
	bge _0215F110
	cmp r2, #0x10
	beq _0215F10C
	b _0215F11A
_0215F0FC:
	ldr r0, _0215F394 // =0x00200010
	cmp r2, r0
	bgt _0215F106
	beq _0215F114
	b _0215F11A
_0215F106:
	cmp r2, r1
	beq _0215F118
	b _0215F11A
_0215F10C:
	ldr r7, _0215F398 // =Sprite__GetSpriteSize1FromAnim
	b _0215F11A
_0215F110:
	ldr r7, _0215F39C // =Sprite__GetSpriteSize2FromAnim
	b _0215F11A
_0215F114:
	ldr r7, _0215F3A0 // =Sprite__GetSpriteSize3FromAnim
	b _0215F11A
_0215F118:
	ldr r7, _0215F3A4 // =Sprite__GetSpriteSize4FromAnim
_0215F11A:
	mov r0, #0
	str r0, [sp, #0x28]
	mov r1, #0xa3
	ldr r0, [sp, #0x18]
	lsl r1, r1, #2
	ldr r4, _0215F3A8 // =_02161A7C
	ldr r5, [sp, #0x28]
	add r6, r0, r1
_0215F12A:
	mov r0, #0
	str r0, [sp]
	lsl r0, r5, #0x10
	str r7, [sp, #4]
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	ldrh r0, [r4, #0]
	ldr r1, [sp, #0x30]
	mov r2, #1
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #8
	str r0, [sp, #0x14]
	mov r0, r6
	mov r3, #0
	bl NameMenu__InitAnimator
	ldr r0, [sp, #0x28]
	add r6, #0x64
	add r0, r0, #1
	add r4, r4, #2
	add r5, r5, #2
	str r0, [sp, #0x28]
	cmp r0, #4
	blt _0215F12A
	mov r1, #0xa3
	ldr r0, [sp, #0x18]
	lsl r1, r1, #2
	mov r4, #0
	add r0, r0, r1
	ldr r6, _0215F3A8 // =_02161A7C
	str r4, [sp, #0x1c]
	mov r5, #8
	str r0, [sp, #0x34]
_0215F170:
	mov r0, #0
	str r0, [sp]
	lsl r0, r5, #0x10
	str r7, [sp, #4]
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	ldrh r0, [r6, #8]
	mov r2, #1
	mov r3, #0
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #8
	str r0, [sp, #0x14]
	mov r0, #0x19
	lsl r0, r0, #4
	add r1, r4, r0
	ldr r0, [sp, #0x34]
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	ldr r0, [sp, #0x1c]
	add r4, #0x64
	add r0, r0, #1
	add r6, r6, #2
	add r5, r5, #3
	str r0, [sp, #0x1c]
	cmp r0, #3
	blt _0215F170
	mov r1, #0xa3
	ldr r0, [sp, #0x18]
	lsl r1, r1, #2
	mov r4, #0
	add r0, r0, r1
	ldr r6, _0215F3A8 // =_02161A7C
	str r4, [sp, #0x20]
	mov r5, #0x11
	str r0, [sp, #0x38]
_0215F1BE:
	mov r0, #1
	str r0, [sp]
	lsl r0, r5, #0x10
	str r7, [sp, #4]
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	ldrh r0, [r6, #0xe]
	mov r2, #1
	mov r3, #0
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #8
	str r0, [sp, #0x14]
	mov r0, #0xaf
	lsl r0, r0, #2
	add r1, r4, r0
	ldr r0, [sp, #0x38]
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	ldr r0, [sp, #0x20]
	add r4, #0x64
	add r0, r0, #1
	add r6, r6, #2
	add r5, r5, #2
	str r0, [sp, #0x20]
	cmp r0, #5
	blt _0215F1BE
	mov r1, #0xa3
	ldr r0, [sp, #0x18]
	lsl r1, r1, #2
	mov r6, #0
	add r0, r0, r1
	ldr r5, _0215F3A8 // =_02161A7C
	mov r4, r6
	str r0, [sp, #0x3c]
_0215F20A:
	mov r0, #0
	str r0, [sp]
	str r7, [sp, #4]
	mov r0, #0x1b
	str r0, [sp, #8]
	ldrh r0, [r5, #0x18]
	mov r2, #1
	mov r3, #0
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #4
	str r0, [sp, #0x14]
	mov r0, #0x4b
	lsl r0, r0, #4
	add r1, r4, r0
	ldr r0, [sp, #0x3c]
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	add r6, r6, #1
	add r4, #0x64
	add r5, r5, #2
	cmp r6, #5
	blt _0215F20A
	mov r1, #0xa3
	ldr r0, [sp, #0x18]
	lsl r1, r1, #2
	mov r6, #0
	add r0, r0, r1
	ldr r5, _0215F3A8 // =_02161A7C
	mov r4, r6
	str r0, [sp, #0x40]
_0215F24E:
	mov r0, #0
	str r0, [sp]
	mov r0, r6
	add r0, #0x1c
	lsl r0, r0, #0x10
	str r7, [sp, #4]
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	ldrh r0, [r5, #0x22]
	mov r2, #1
	mov r3, #0
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #0xc
	str r0, [sp, #0x14]
	ldr r0, _0215F3AC // =0x000006A4
	add r1, r4, r0
	ldr r0, [sp, #0x40]
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	add r6, r6, #1
	add r4, #0x64
	add r5, r5, #2
	cmp r6, #2
	blt _0215F24E
	mov r2, #0
	str r2, [sp]
	str r7, [sp, #4]
	mov r0, #0x1e
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #3
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r2, #1
	ldr r1, _0215F3B0 // =0x000009F8
	ldr r0, [sp, #0x18]
	mov r3, r2
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	mov r2, #0
	str r2, [sp]
	str r7, [sp, #4]
	mov r0, #0x1f
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r0, #4
	str r0, [sp, #0x14]
	mov r2, #1
	ldr r1, _0215F3B4 // =0x00000A5C
	ldr r0, [sp, #0x18]
	mov r3, r2
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	mov r3, #0
	str r3, [sp]
	mov r1, #0x2b
	str r7, [sp, #4]
	mov r0, #0x20
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #3
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x18]
	lsl r1, r1, #6
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	mov r2, #1
	str r3, [sp, #0x14]
	bl NameMenu__InitAnimator
	mov r3, #0
	str r3, [sp]
	str r7, [sp, #4]
	mov r0, #0x21
	str r0, [sp, #8]
	mov r0, #3
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #4
	str r0, [sp, #0x14]
	ldr r1, _0215F3B8 // =0x00000B24
	ldr r0, [sp, #0x18]
	mov r2, #1
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	mov r4, #0
	mov r1, #0xa3
	ldr r0, [sp, #0x18]
	lsl r1, r1, #2
	add r0, r0, r1
	ldr r6, _0215F3A8 // =_02161A7C
	str r4, [sp, #0x24]
	mov r5, r4
	str r0, [sp, #0x44]
_0215F326:
	mov r0, #0
	str r0, [sp]
	lsl r0, r5, #0x10
	str r7, [sp, #4]
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	ldrh r0, [r6, #0x2e]
	mov r2, #1
	mov r3, #0
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #2
	str r0, [sp, #0x14]
	ldr r0, _0215F3BC // =0x000008FC
	add r1, r4, r0
	ldr r0, [sp, #0x44]
	add r0, r0, r1
	ldr r1, [sp, #0x2c]
	bl NameMenu__InitAnimator
	ldr r0, [sp, #0x24]
	add r4, #0x64
	add r0, r0, #1
	add r6, r6, #2
	add r5, r5, #3
	str r0, [sp, #0x24]
	cmp r0, #3
	blt _0215F326
	mov r1, #0
	str r1, [sp]
	str r7, [sp, #4]
	mov r0, #0x38
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r2, #1
	ldr r1, _0215F3C0 // =0x00000CB4
	ldr r0, [sp, #0x18]
	mov r3, r2
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	add sp, #0x48
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215F388: .word 0x04001000
_0215F38C: .word 0x00300010
_0215F390: .word 0x00100010
_0215F394: .word 0x00200010
_0215F398: .word Sprite__GetSpriteSize1FromAnim
_0215F39C: .word Sprite__GetSpriteSize2FromAnim
_0215F3A0: .word Sprite__GetSpriteSize3FromAnim
_0215F3A4: .word Sprite__GetSpriteSize4FromAnim
_0215F3A8: .word _02161A7C
_0215F3AC: .word 0x000006A4
_0215F3B0: .word 0x000009F8
_0215F3B4: .word 0x00000A5C
_0215F3B8: .word 0x00000B24
_0215F3BC: .word 0x000008FC
_0215F3C0: .word 0x00000CB4
	thumb_func_end NameMenu__InitAnimators

	thumb_func_start NameMenu__InitBackgrounds
NameMenu__InitBackgrounds: // 0x0215F3C4
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r6, r0
	mov r0, #0xdf
	lsl r0, r0, #4
	ldr r0, [r6, r0]
	mov r1, #7
	bl FileUnknown__GetAOUFile
	mov r1, r0
	mov r0, #3
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	mov r0, r6
	add r0, #0x4c
	mov r2, #0
	mov r3, #1
	bl InitBackground
	mov r4, #0
	mov r7, r6
	mov r5, r4
	add r7, #0x4c
_0215F3F8:
	mov r0, #0xdf
	mov r1, r4
	lsl r0, r0, #4
	add r1, #9
	lsl r1, r1, #0x10
	ldr r0, [r6, r0]
	lsr r1, r1, #0x10
	bl FileUnknown__GetAOUFile
	mov r1, r0
	mov r0, #2
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	mov r0, r5
	add r0, #0x48
	add r0, r7, r0
	mov r2, #0
	mov r3, #1
	bl InitBackground
	add r4, r4, #1
	add r5, #0x48
	cmp r4, #7
	blt _0215F3F8
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
	thumb_func_end NameMenu__InitBackgrounds

	thumb_func_start NameMenu__InitUnknown2056570
NameMenu__InitUnknown2056570: // 0x0215F434
	push {r3, r4, r5, r6, lr}
	sub sp, #0x1c
	mov r6, r0
	mov r0, #0x1b
	lsl r0, r0, #6
	bl _AllocHeadHEAP_USER
	ldr r1, _0215F4AC // =0x00000E28
	mov r2, #0x1b
	str r0, [r6, r1]
	ldr r1, [r6, r1]
	mov r0, #0
	lsl r2, r2, #6
	bl MIi_CpuClear32
	mov r0, #8
	str r0, [sp]
	mov r1, #1
	str r1, [sp, #4]
	mov r0, #0x12
	str r0, [sp, #8]
	mov r0, #3
	str r0, [sp, #0xc]
	ldr r0, _0215F4AC // =0x00000E28
	mov r3, #0
	ldr r2, [r6, r0]
	sub r0, #0x30
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r2, #0x20
	str r2, [sp, #0x18]
	add r0, r6, r0
	mov r2, r1
	bl Unknown2056570__Init
	ldr r0, _0215F4B0 // =0x00000DF8
	mov r1, #1
	add r0, r6, r0
	bl Unknown2056570__Func_2056688
	ldr r0, _0215F4B4 // =0x02110460
	ldr r1, _0215F4B8 // =0x05000422
	mov r2, #8
	bl MIi_CpuCopy16
	mov r4, #0
	mov r5, r6
_0215F492:
	ldrh r2, [r5, #0x1c]
	lsl r1, r4, #0x10
	mov r0, r6
	lsr r1, r1, #0x10
	bl NameMenu__Func_21600A8
	add r4, r4, #1
	add r5, r5, #2
	cmp r4, #8
	blt _0215F492
	add sp, #0x1c
	pop {r3, r4, r5, r6, pc}
	nop
_0215F4AC: .word 0x00000E28
_0215F4B0: .word 0x00000DF8
_0215F4B4: .word 0x02110460
_0215F4B8: .word 0x05000422
	thumb_func_end NameMenu__InitUnknown2056570

	thumb_func_start NameMenu__InitTouchField
NameMenu__InitTouchField: // 0x0215F4BC
	push {r4, r5, r6, r7, lr}
	sub sp, #0x1c
	mov r6, r0
	ldr r0, _0215F524 // =0x00000DD8
	add r0, r6, r0
	bl TouchField__Init
	ldr r1, _0215F528 // =0x00000DE4
	mov r4, #0
	str r4, [r6, r1]
	add r0, r1, #4
	strb r4, [r6, r0]
	add r7, sp, #8
	sub r1, #0xb4
	strh r4, [r7, #4]
	mov r0, #4
	strh r0, [r7, #6]
	mov r0, #0x44
	strh r0, [r7, #8]
	mov r0, #0x18
	strh r0, [r7, #0xa]
	mov r0, #0x14
	strh r0, [r7]
	mov r0, #0xa0
	strh r0, [r7, #2]
	add r5, r6, r1
_0215F4F0:
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r2, _0215F52C // =TouchField__PointInRect
	mov r0, r5
	add r1, sp, #8
	add r3, sp, #0xc
	bl TouchField__InitAreaShape
	ldr r0, _0215F524 // =0x00000DD8
	ldr r2, _0215F530 // =0x0000FFFF
	add r0, r6, r0
	mov r1, r5
	bl TouchField__AddArea
	mov r0, #0
	ldrsh r0, [r7, r0]
	add r4, r4, #1
	add r5, #0x38
	add r0, #0x48
	strh r0, [r7]
	cmp r4, #3
	blt _0215F4F0
	add sp, #0x1c
	pop {r4, r5, r6, r7, pc}
	nop
_0215F524: .word 0x00000DD8
_0215F528: .word 0x00000DE4
_0215F52C: .word TouchField__PointInRect
_0215F530: .word 0x0000FFFF
	thumb_func_end NameMenu__InitTouchField

	thumb_func_start NameMenu__ThreadFunc
NameMenu__ThreadFunc: // 0x0215F534
	ldr r3, _0215F538 // =NameMenu__Init
	bx r3
	.align 2, 0
_0215F538: .word NameMenu__Init
	thumb_func_end NameMenu__ThreadFunc

	thumb_func_start NameMenu__InitAnimator
NameMenu__InitAnimator: // 0x0215F53C
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x20
	mov r6, r0
	str r1, [sp, #0x1c]
	mov r5, r2
	mov r4, #0
	cmp r3, #0
	beq _0215F550
	mov r0, #4
	orr r4, r0
_0215F550:
	ldr r0, [sp, #0x38]
	cmp r0, #0
	beq _0215F55C
	mov r0, #2
	lsl r0, r0, #8
	orr r4, r0
_0215F55C:
	cmp r5, #0
	bne _0215F564
	ldr r7, _0215F5AC // =0x05000200
	b _0215F566
_0215F564:
	ldr r7, _0215F5B0 // =0x05000600
_0215F566:
	add r1, sp, #0x28
	ldrh r1, [r1, #0x18]
	ldr r0, [sp, #0x1c]
	ldr r2, [sp, #0x3c]
	blx r2
	mov r1, r0
	mov r0, r5
	bl VRAMSystem__AllocSpriteVram
	str r5, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	add r0, sp, #0x48
	ldrb r0, [r0, #0]
	str r7, [sp, #0x10]
	add r2, sp, #0x28
	str r0, [sp, #0x14]
	add r0, sp, #0x4c
	ldrb r0, [r0, #0]
	ldr r1, [sp, #0x1c]
	mov r3, r4
	str r0, [sp, #0x18]
	ldrh r2, [r2, #0x18]
	mov r0, r6
	bl AnimatorSprite__Init
	add r0, sp, #0x28
	ldrh r0, [r0, #0x1c]
	add r6, #0x50
	strh r0, [r6]
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215F5AC: .word 0x05000200
_0215F5B0: .word 0x05000600
	thumb_func_end NameMenu__InitAnimator

	thumb_func_start NameMenu__InitFontWindow
NameMenu__InitFontWindow: // 0x0215F5B4
	push {r3, r4, r5, lr}
	sub sp, #0x198
	mov r4, r0
	mov r0, #0xdf
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	mov r1, #8
	bl FileUnknown__GetAOUFile
	mov r1, r0
	mov r0, #3
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0x150
	mov r2, #0x38
	mov r3, #0
	bl InitBackground
	add r0, sp, #0x150
	bl DrawBackground
	add r0, sp, #0xec
	bl FontWindowAnimator__Init
	mov r0, #2
	str r0, [sp]
	mov r0, #3
	str r0, [sp, #4]
	mov r0, #7
	str r0, [sp, #8]
	mov r0, #0x1a
	str r0, [sp, #0xc]
	mov r0, #8
	str r0, [sp, #0x10]
	mov r3, #0
	str r3, [sp, #0x14]
	mov r0, #1
	str r0, [sp, #0x18]
	str r0, [sp, #0x1c]
	str r0, [sp, #0x20]
	ldr r1, _0215F6F8 // =0x00000DF4
	str r3, [sp, #0x24]
	ldr r1, [r4, r1]
	add r0, sp, #0xec
	mov r2, #0x38
	bl FontWindowAnimator__Load1
	add r0, sp, #0xec
	bl FontWindowAnimator__Func_20599C4
	add r0, sp, #0xec
	bl FontWindowAnimator__Draw
	add r0, sp, #0xec
	bl FontWindowAnimator__Release
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _0215F654
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215F640: // jump table
	.hword _0215F64C - _0215F640 - 2 // case 0
	.hword _0215F64C - _0215F640 - 2 // case 1
	.hword _0215F64C - _0215F640 - 2 // case 2
	.hword _0215F64C - _0215F640 - 2 // case 3
	.hword _0215F64C - _0215F640 - 2 // case 4
	.hword _0215F64C - _0215F640 - 2 // case 5
_0215F64C:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _0215F656
_0215F654:
	mov r1, #1
_0215F656:
	mov r0, #0xdf
	lsl r0, r0, #4
	add r1, #0x10
	lsl r1, r1, #0x10
	ldr r0, [r4, r0]
	lsr r1, r1, #0x10
	bl FileUnknown__GetAOUFile
	mov r5, r0
	add r0, sp, #0x28
	bl FontAnimator__Init
	mov r0, #8
	str r0, [sp]
	mov r0, #0x18
	str r0, [sp, #4]
	mov r1, #6
	str r1, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	add r1, #0xfa
	str r1, [sp, #0x18]
	ldr r1, _0215F6F8 // =0x00000DF4
	add r0, sp, #0x28
	ldr r1, [r4, r1]
	mov r2, #0x38
	mov r3, #4
	bl FontAnimator__LoadFont1
	add r0, sp, #0x28
	bl FontAnimator__LoadMappingsFunc
	add r0, sp, #0x28
	bl FontAnimator__LoadPaletteFunc
	add r0, sp, #0x28
	mov r1, r5
	bl FontAnimator__LoadMPCFile
	add r0, sp, #0x28
	mov r1, #4
	bl FontAnimator__SetMsgSequence
	add r0, sp, #0x28
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	add r0, sp, #0x28
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	cmp r0, #1
	beq _0215F6CC
	cmp r0, #2
	beq _0215F6D6
	b _0215F6DE
_0215F6CC:
	add r0, sp, #0x28
	mov r1, #0x10
	bl FontAnimator__AdvanceLine
	b _0215F6DE
_0215F6D6:
	add r0, sp, #0x28
	mov r1, #8
	bl FontAnimator__AdvanceLine
_0215F6DE:
	add r0, sp, #0x28
	mov r1, #0
	bl FontAnimator__LoadCharacters
	add r0, sp, #0x28
	bl FontAnimator__Draw
	add r0, sp, #0x28
	bl FontAnimator__Release
	add sp, #0x198
	pop {r3, r4, r5, pc}
	nop
_0215F6F8: .word 0x00000DF4
	thumb_func_end NameMenu__InitFontWindow

	thumb_func_start NameMenu__Release
NameMenu__Release: // 0x0215F6FC
	push {r3, r4, r5, lr}
	mov r5, r0
	bl NameMenu__ReleaseTouchField
	mov r0, r5
	bl NameMenu__ReleaseUnknown2056570
	mov r0, r5
	bl NameMenu__ReleaseBackgrounds
	mov r0, r5
	bl NameMenu__ReleaseAnimators
	mov r0, r5
	bl NameMenu__ResetDisplay
	mov r4, #0
_0215F71E:
	ldrh r0, [r5, #0x1c]
	bl NameMenu__GetCharacterFromIndex
	strh r0, [r5, #0x1c]
	add r4, r4, #1
	add r5, r5, #2
	cmp r4, #8
	blt _0215F71E
	pop {r3, r4, r5, pc}
	thumb_func_end NameMenu__Release

	thumb_func_start NameMenu__ResetDisplay
NameMenu__ResetDisplay: // 0x0215F730
	ldr r3, _0215F738 // =NameMenu__SetupBlending
	mov r1, #0x10
	bx r3
	nop
_0215F738: .word NameMenu__SetupBlending
	thumb_func_end NameMenu__ResetDisplay

	thumb_func_start NameMenu__ReleaseAnimators
NameMenu__ReleaseAnimators: // 0x0215F73C
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r0, _0215F820 // =0x00000CB4
	add r0, r7, r0
	bl AnimatorSprite__Release
	mov r0, #0xa3
	lsl r0, r0, #2
	mov r4, #2
	mov r5, #0xc8
	add r6, r7, r0
_0215F752:
	ldr r0, _0215F824 // =0x000008FC
	add r0, r5, r0
	add r0, r6, r0
	bl AnimatorSprite__Release
	sub r5, #0x64
	sub r4, r4, #1
	bpl _0215F752
	ldr r0, _0215F828 // =0x00000B24
	add r0, r7, r0
	bl AnimatorSprite__Release
	mov r0, #0x2b
	lsl r0, r0, #6
	add r0, r7, r0
	bl AnimatorSprite__Release
	ldr r0, _0215F82C // =0x00000A5C
	add r0, r7, r0
	bl AnimatorSprite__Release
	ldr r0, _0215F830 // =0x000009F8
	add r0, r7, r0
	bl AnimatorSprite__Release
	mov r0, #0xa3
	lsl r0, r0, #2
	mov r5, #1
	mov r4, #0x64
	add r6, r7, r0
_0215F78E:
	ldr r0, _0215F834 // =0x000006A4
	add r0, r4, r0
	add r0, r6, r0
	bl AnimatorSprite__Release
	sub r4, #0x64
	sub r5, r5, #1
	bpl _0215F78E
	mov r4, #0x19
	lsl r4, r4, #4
	mov r0, r4
	add r0, #0xfc
	mov r5, #4
	add r6, r7, r0
_0215F7AA:
	mov r0, #0x4b
	lsl r0, r0, #4
	add r0, r4, r0
	add r0, r6, r0
	bl AnimatorSprite__Release
	sub r4, #0x64
	sub r5, r5, #1
	bpl _0215F7AA
	mov r4, #0x19
	lsl r4, r4, #4
	mov r0, r4
	add r0, #0xfc
	mov r5, #4
	add r6, r7, r0
_0215F7C8:
	mov r0, #0xaf
	lsl r0, r0, #2
	add r0, r4, r0
	add r0, r6, r0
	bl AnimatorSprite__Release
	sub r4, #0x64
	sub r5, r5, #1
	bpl _0215F7C8
	mov r0, #0xa3
	lsl r0, r0, #2
	mov r5, #2
	mov r4, #0xc8
	add r6, r7, r0
_0215F7E4:
	mov r0, #0x19
	lsl r0, r0, #4
	add r0, r4, r0
	add r0, r6, r0
	bl AnimatorSprite__Release
	sub r4, #0x64
	sub r5, r5, #1
	bpl _0215F7E4
	mov r0, #0xa3
	lsl r0, r0, #2
	add r1, r7, r0
	mov r0, #0x4b
	lsl r0, r0, #2
	mov r5, #3
	add r4, r1, r0
_0215F804:
	mov r0, r4
	bl AnimatorSprite__Release
	sub r4, #0x64
	sub r5, r5, #1
	bpl _0215F804
	mov r1, #0xa3
	lsl r1, r1, #2
	ldr r2, _0215F838 // =0x00000A8C
	mov r0, #0
	add r1, r7, r1
	bl MIi_CpuClear32
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215F820: .word 0x00000CB4
_0215F824: .word 0x000008FC
_0215F828: .word 0x00000B24
_0215F82C: .word 0x00000A5C
_0215F830: .word 0x000009F8
_0215F834: .word 0x000006A4
_0215F838: .word 0x00000A8C
	thumb_func_end NameMenu__ReleaseAnimators

	thumb_func_start NameMenu__ReleaseBackgrounds
NameMenu__ReleaseBackgrounds: // 0x0215F83C
	bx lr
	.align 2, 0
	thumb_func_end NameMenu__ReleaseBackgrounds

	thumb_func_start NameMenu__ReleaseUnknown2056570
NameMenu__ReleaseUnknown2056570: // 0x0215F840
	push {r4, lr}
	mov r4, r0
	ldr r0, _0215F860 // =0x00000DF8
	add r0, r4, r0
	bl Unknown2056570__Func_2056670
	ldr r0, _0215F864 // =0x00000E28
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0215F85E
	bl _FreeHEAP_USER
	ldr r0, _0215F864 // =0x00000E28
	mov r1, #0
	str r1, [r4, r0]
_0215F85E:
	pop {r4, pc}
	.align 2, 0
_0215F860: .word 0x00000DF8
_0215F864: .word 0x00000E28
	thumb_func_end NameMenu__ReleaseUnknown2056570

	thumb_func_start NameMenu__ReleaseTouchField
NameMenu__ReleaseTouchField: // 0x0215F868
	mov r1, #0xd3
	mov r2, r0
	lsl r1, r1, #4
	add r1, r2, r1
	ldr r3, _0215F878 // =MIi_CpuClear16
	mov r0, #0
	mov r2, #0xa8
	bx r3
	.align 2, 0
_0215F878: .word MIi_CpuClear16
	thumb_func_end NameMenu__ReleaseTouchField

	thumb_func_start NameMenu__Main_Loading
NameMenu__Main_Loading: // 0x0215F87C
	push {r4, r5, r6, lr}
	ldr r0, _0215F8CC // =NameMenu__sVars
	ldr r1, [r0, #0]
	mov r0, #0xe3
	lsl r0, r0, #4
	add r0, r1, r0
	bl IsThreadWorkerFinished
	cmp r0, #0
	beq _0215F8CA
	ldr r0, _0215F8CC // =NameMenu__sVars
	ldr r0, [r0, #0]
	add r0, #0x4c
	bl DrawBackground
	ldr r0, _0215F8CC // =NameMenu__sVars
	mov r1, #2
	ldr r0, [r0, #0]
	bl NameMenu__SetTextPage
	mov r5, #0
	ldr r4, _0215F8CC // =NameMenu__sVars
	mov r6, r5
_0215F8AA:
	ldr r0, [r4, #0]
	mov r1, r5
	mov r2, r6
	bl NameMenu__SetUnknown
	add r5, r5, #1
	cmp r5, #5
	blt _0215F8AA
	ldr r0, _0215F8CC // =NameMenu__sVars
	ldr r2, _0215F8D0 // =NameMenu__State_FadeIn
	ldr r1, [r0, #0]
	ldr r0, _0215F8D4 // =0x00000D18
	str r2, [r1, r0]
	ldr r0, _0215F8D8 // =NameMenu__Main_Active
	bl SetCurrentTaskMainEvent
_0215F8CA:
	pop {r4, r5, r6, pc}
	.align 2, 0
_0215F8CC: .word NameMenu__sVars
_0215F8D0: .word NameMenu__State_FadeIn
_0215F8D4: .word 0x00000D18
_0215F8D8: .word NameMenu__Main_Active
	thumb_func_end NameMenu__Main_Loading

	thumb_func_start NameMenu__Main_Active
NameMenu__Main_Active: // 0x0215F8DC
	push {r3, lr}
	ldr r0, _0215F90C // =NameMenu__sVars
	ldr r2, [r0, #0]
	ldr r0, _0215F910 // =0x00000D18
	ldr r1, [r2, r0]
	cmp r1, #0
	beq _0215F8FE
	add r0, #0xc0
	add r0, r2, r0
	bl TouchField__Process
	ldr r0, _0215F90C // =NameMenu__sVars
	ldr r1, _0215F910 // =0x00000D18
	ldr r0, [r0, #0]
	ldr r1, [r0, r1]
	blx r1
	pop {r3, pc}
_0215F8FE:
	bl DestroyCurrentTask
	ldr r0, _0215F90C // =NameMenu__sVars
	mov r1, #0
	ldr r0, [r0, #0]
	str r1, [r0, #0xc]
	pop {r3, pc}
	.align 2, 0
_0215F90C: .word NameMenu__sVars
_0215F910: .word 0x00000D18
	thumb_func_end NameMenu__Main_Active

	thumb_func_start NameMenu__Destructor
NameMenu__Destructor: // 0x0215F914
	ldr r0, _0215F91C // =NameMenu__sVars
	ldr r3, _0215F920 // =NameMenu__Release
	ldr r0, [r0, #0]
	bx r3
	.align 2, 0
_0215F91C: .word NameMenu__sVars
_0215F920: .word NameMenu__Release
	thumb_func_end NameMenu__Destructor

	thumb_func_start NameMenu__State_FadeIn
NameMenu__State_FadeIn: // 0x0215F924
	push {r4, lr}
	ldr r1, _0215F974 // =0x0213D300
	mov r4, r0
	mov r0, #0x18
	ldrsh r0, [r1, r0]
	cmp r0, #0
	bge _0215F938
	add r0, r0, #1
	strh r0, [r1, #0x18]
	b _0215F93E
_0215F938:
	ble _0215F93E
	sub r0, r0, #1
	strh r0, [r1, #0x18]
_0215F93E:
	ldr r1, _0215F974 // =0x0213D300
	mov r0, #0x18
	ldrsh r1, [r1, r0]
	ldr r0, _0215F978 // =0x0213D2A4
	strh r1, [r0, #0x18]
	mov r0, r4
	bl NameMenu__DrawMenuInitial
	cmp r0, #0
	beq _0215F972
	ldr r0, _0215F97C // =VRAMSystem__GFXControl
	ldr r1, [r0, #4]
	mov r0, #0x58
	ldrsh r0, [r1, r0]
	cmp r0, #0
	bne _0215F972
	ldr r0, _0215F980 // =0x000005AC
	mov r1, #0x14
	add r0, r4, r0
	bl AnimatorSprite__SetAnimation
	mov r0, #1
	str r0, [r4, #0x14]
	ldr r1, _0215F984 // =NameMenu__State_Active
	ldr r0, _0215F988 // =0x00000D18
	str r1, [r4, r0]
_0215F972:
	pop {r4, pc}
	.align 2, 0
_0215F974: .word 0x0213D300
_0215F978: .word 0x0213D2A4
_0215F97C: .word VRAMSystem__GFXControl
_0215F980: .word 0x000005AC
_0215F984: .word NameMenu__State_Active
_0215F988: .word 0x00000D18
	thumb_func_end NameMenu__State_FadeIn

	thumb_func_start NameMenu__State_Active
NameMenu__State_Active: // 0x0215F98C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r4, r0
	ldr r0, _0215FC68 // =0x0000FFFF
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #8]
	str r0, [sp, #4]
	str r0, [sp]
	ldr r0, [r4, #0x3c]
	cmp r0, #2
	beq _0215F9BA
	ldr r0, _0215FC6C // =0x00000D44
	ldr r1, [r4, r0]
	mov r0, #1
	lsl r0, r0, #0x12
	tst r0, r1
	beq _0215F9BA
	mov r0, #1
	str r0, [sp, #4]
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215F9BA:
	ldr r0, [r4, #0x40]
	cmp r0, #2
	beq _0215F9DA
	ldr r0, _0215FC70 // =0x00000D7C
	ldr r1, [r4, r0]
	mov r0, #1
	lsl r0, r0, #0x12
	tst r0, r1
	beq _0215F9DA
	mov r0, r4
	bl NameMenu__DeleteCharacter
	mov r0, #1
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215F9DA:
	ldr r0, [r4, #0x44]
	cmp r0, #2
	beq _0215F9F8
	ldr r0, _0215FC74 // =0x00000DB4
	ldr r1, [r4, r0]
	mov r0, #1
	lsl r0, r0, #0x12
	tst r0, r1
	beq _0215F9F8
	mov r0, #1
	str r0, [sp]
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215F9F8:
	add r1, sp, #0x10
	mov r0, r4
	add r1, #2
	add r2, sp, #0x10
	bl NameMenu__GetCursorPositionFromTouch
	cmp r0, #0
	beq _0215FA34
	ldr r2, [r4, #8]
	add r1, sp, #0x10
	lsl r3, r2, #2
	ldr r2, _0215FC78 // =_02161A60
	ldrh r0, [r1, #2]
	ldrh r1, [r1, #0]
	ldr r2, [r2, r3]
	blx r2
	str r0, [sp, #0xc]
	ldr r1, _0215FC68 // =0x0000FFFF
	ldr r0, [sp, #0xc]
	cmp r0, r1
	beq _0215FA46
	add r2, sp, #0x10
	ldrh r1, [r2, #2]
	ldrh r2, [r2, #0]
	mov r0, r4
	bl NameMenu__SetCharacterSelection
	mov r0, #1
	str r0, [sp, #8]
	b _0215FA46
_0215FA34:
	mov r0, r4
	bl NameMenu__GetMenuSelectionFromTouch
	mov r1, r0
	cmp r1, #3
	bge _0215FA46
	mov r0, r4
	bl NameMenu__SetMenuSelection
_0215FA46:
	ldr r5, [r4, #0x38]
	cmp r5, #3
	bge _0215FA4E
	b _0215FB86
_0215FA4E:
	ldrh r0, [r4, #0x30]
	add r5, sp, #0x10
	strh r0, [r5, #2]
	ldrh r0, [r4, #0x32]
	strh r0, [r5]
	ldr r0, _0215FC7C // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x20
	tst r0, r1
	beq _0215FA8C
	ldr r7, _0215FC78 // =_02161A60
	mov r6, #0xb
_0215FA66:
	ldrh r0, [r5, #2]
	cmp r0, #0
	bne _0215FA70
	strh r6, [r5, #2]
	b _0215FA74
_0215FA70:
	sub r0, r0, #1
	strh r0, [r5, #2]
_0215FA74:
	ldr r2, [r4, #8]
	ldrh r0, [r5, #2]
	lsl r2, r2, #2
	ldrh r1, [r5, #0]
	ldr r2, [r7, r2]
	blx r2
	ldr r1, _0215FC68 // =0x0000FFFF
	cmp r0, r1
	beq _0215FA66
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FA8C:
	ldr r0, _0215FC7C // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x10
	tst r0, r1
	beq _0215FAC2
	ldr r7, _0215FC78 // =_02161A60
	mov r6, #0
	add r5, sp, #0x10
_0215FA9C:
	ldrh r0, [r5, #2]
	cmp r0, #0xb
	bne _0215FAA6
	strh r6, [r5, #2]
	b _0215FAAA
_0215FAA6:
	add r0, r0, #1
	strh r0, [r5, #2]
_0215FAAA:
	ldr r2, [r4, #8]
	ldrh r0, [r5, #2]
	lsl r2, r2, #2
	ldrh r1, [r5, #0]
	ldr r2, [r7, r2]
	blx r2
	ldr r1, _0215FC68 // =0x0000FFFF
	cmp r0, r1
	beq _0215FA9C
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FAC2:
	ldr r0, _0215FC7C // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x40
	tst r0, r1
	beq _0215FAFA
	ldr r6, _0215FC78 // =_02161A60
	ldr r7, _0215FC68 // =0x0000FFFF
	add r5, sp, #0x10
_0215FAD2:
	ldrh r0, [r5, #0]
	cmp r0, #0
	bne _0215FAE0
	mov r1, #5
	add r0, sp, #0x10
	strh r1, [r0]
	b _0215FAF4
_0215FAE0:
	sub r0, r0, #1
	strh r0, [r5]
	ldr r2, [r4, #8]
	ldrh r0, [r5, #2]
	lsl r2, r2, #2
	ldrh r1, [r5, #0]
	ldr r2, [r6, r2]
	blx r2
	cmp r0, r7
	beq _0215FAD2
_0215FAF4:
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FAFA:
	ldr r0, _0215FC7C // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x80
	tst r0, r1
	beq _0215FB2A
	ldr r6, _0215FC78 // =_02161A60
	ldr r7, _0215FC68 // =0x0000FFFF
	add r5, sp, #0x10
_0215FB0A:
	ldrh r0, [r5, #0]
	add r0, r0, #1
	strh r0, [r5]
	ldrh r1, [r5, #0]
	cmp r1, #5
	bhs _0215FB24
	ldr r2, [r4, #8]
	ldrh r0, [r5, #2]
	lsl r2, r2, #2
	ldr r2, [r6, r2]
	blx r2
	cmp r0, r7
	beq _0215FB0A
_0215FB24:
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FB2A:
	add r0, sp, #0x10
	ldrh r2, [r0, #0]
	cmp r2, #5
	bhs _0215FB4A
	ldrh r1, [r0, #2]
	ldrh r0, [r4, #0x30]
	cmp r1, r0
	bne _0215FB42
	ldrh r0, [r4, #0x32]
	cmp r2, r0
	bne _0215FB42
	b _0215FCB0
_0215FB42:
	mov r0, r4
	bl NameMenu__SetCharacterSelection
	b _0215FCB0
_0215FB4A:
	ldrh r0, [r0, #2]
	cmp r0, #4
	bhs _0215FB54
	mov r1, #0
	b _0215FB5E
_0215FB54:
	cmp r0, #8
	bhs _0215FB5C
	mov r1, #1
	b _0215FB5E
_0215FB5C:
	mov r1, #2
_0215FB5E:
	lsl r0, r1, #2
	add r0, r4, r0
	ldr r0, [r0, #0x3c]
	cmp r0, #2
	bne _0215FB7E
	mov r2, #0
_0215FB6A:
	cmp r1, #2
	bne _0215FB72
	mov r1, r2
	b _0215FB74
_0215FB72:
	add r1, r1, #1
_0215FB74:
	lsl r0, r1, #2
	add r0, r4, r0
	ldr r0, [r0, #0x3c]
	cmp r0, #2
	beq _0215FB6A
_0215FB7E:
	mov r0, r4
	bl NameMenu__SetMenuSelection
	b _0215FCB0
_0215FB86:
	ldr r0, _0215FC7C // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x20
	tst r0, r1
	beq _0215FBB4
	mov r1, #2
_0215FB92:
	cmp r5, #0
	bne _0215FB9A
	mov r5, r1
	b _0215FB9C
_0215FB9A:
	sub r5, r5, #1
_0215FB9C:
	lsl r0, r5, #2
	add r0, r4, r0
	ldr r0, [r0, #0x3c]
	cmp r0, #2
	beq _0215FB92
	mov r0, r4
	mov r1, r5
	bl NameMenu__SetMenuSelection
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FBB4:
	ldr r0, _0215FC7C // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x10
	tst r0, r1
	beq _0215FBE2
	mov r1, #0
_0215FBC0:
	cmp r5, #2
	bne _0215FBC8
	mov r5, r1
	b _0215FBCA
_0215FBC8:
	add r5, r5, #1
_0215FBCA:
	lsl r0, r5, #2
	add r0, r4, r0
	ldr r0, [r0, #0x3c]
	cmp r0, #2
	beq _0215FBC0
	mov r0, r4
	mov r1, r5
	bl NameMenu__SetMenuSelection
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FBE2:
	ldr r0, _0215FC7C // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x40
	tst r0, r1
	beq _0215FC3C
	lsl r0, r5, #2
	add r1, r0, #1
	add r0, sp, #0x10
	strh r1, [r0, #2]
	mov r1, #4
	strh r1, [r0]
	ldr r2, [r4, #8]
	ldrh r0, [r0, #2]
	lsl r3, r2, #2
	ldr r2, _0215FC78 // =_02161A60
	ldr r2, [r2, r3]
	blx r2
	ldr r1, _0215FC68 // =0x0000FFFF
	cmp r0, r1
	bne _0215FC2A
	ldr r7, _0215FC78 // =_02161A60
	add r6, sp, #0x10
_0215FC0E:
	ldrh r0, [r6, #0]
	cmp r0, #0
	beq _0215FC2A
	sub r0, r0, #1
	strh r0, [r6]
	ldr r2, [r4, #8]
	ldrh r0, [r6, #2]
	lsl r2, r2, #2
	ldrh r1, [r6, #0]
	ldr r2, [r7, r2]
	blx r2
	ldr r1, _0215FC68 // =0x0000FFFF
	cmp r0, r1
	beq _0215FC0E
_0215FC2A:
	add r2, sp, #0x10
	ldrh r1, [r2, #2]
	ldrh r2, [r2, #0]
	mov r0, r4
	bl NameMenu__SetCharacterSelection
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FC3C:
	ldr r0, _0215FC7C // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x80
	tst r0, r1
	beq _0215FCB0
	lsl r0, r5, #2
	add r1, r0, #1
	add r0, sp, #0x10
	strh r1, [r0, #2]
	mov r1, #0
	strh r1, [r0]
	ldr r2, [r4, #8]
	ldrh r0, [r0, #2]
	lsl r3, r2, #2
	ldr r2, _0215FC78 // =_02161A60
	ldr r2, [r2, r3]
	blx r2
	ldr r1, _0215FC68 // =0x0000FFFF
	cmp r0, r1
	bne _0215FC9E
	ldr r6, _0215FC78 // =_02161A60
	b _0215FC80
	.align 2, 0
_0215FC68: .word 0x0000FFFF
_0215FC6C: .word 0x00000D44
_0215FC70: .word 0x00000D7C
_0215FC74: .word 0x00000DB4
_0215FC78: .word _02161A60
_0215FC7C: .word padInput
_0215FC80:
	add r5, sp, #0x10
	mov r7, r1
_0215FC84:
	ldrh r0, [r5, #0]
	add r0, r0, #1
	strh r0, [r5]
	ldrh r1, [r5, #0]
	cmp r1, #5
	bhs _0215FC9E
	ldr r2, [r4, #8]
	ldrh r0, [r5, #2]
	lsl r2, r2, #2
	ldr r2, [r6, r2]
	blx r2
	cmp r0, r7
	beq _0215FC84
_0215FC9E:
	add r2, sp, #0x10
	ldrh r1, [r2, #2]
	ldrh r2, [r2, #0]
	mov r0, r4
	bl NameMenu__SetCharacterSelection
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FCB0:
	mov r0, r4
	bl NameMenu__CheckPageChange
	mov r1, r0
	cmp r1, #5
	bge _0215FCC8
	mov r0, r4
	bl NameMenu__UpdateTextPage
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FCC8:
	ldr r0, [r4, #0x38]
	cmp r0, #3
	blt _0215FCDE
	ldr r2, [r4, #8]
	ldrh r0, [r4, #0x30]
	lsl r3, r2, #2
	ldr r2, _0215FEF0 // =_02161A60
	ldrh r1, [r4, #0x32]
	ldr r2, [r2, r3]
	blx r2
	b _0215FCE0
_0215FCDE:
	ldr r0, _0215FEF4 // =0x0000FFFF
_0215FCE0:
	ldr r2, _0215FEF8 // =padInput
	mov r5, #1
	ldrh r3, [r2, #8]
	mov r1, r3
	tst r1, r5
	beq _0215FD3A
	ldr r1, _0215FEF4 // =0x0000FFFF
	cmp r0, r1
	bhs _0215FCF6
	str r0, [sp, #0xc]
	b _0215FD70
_0215FCF6:
	ldr r0, [r4, #0x38]
	cmp r0, #0
	beq _0215FD06
	cmp r0, #1
	beq _0215FD16
	cmp r0, #2
	beq _0215FD2A
	b _0215FD70
_0215FD06:
	ldrh r0, [r2, #4]
	tst r0, r5
	beq _0215FD70
	mov r0, #0
	str r5, [sp, #4]
	bl PlaySysMenuNavSfx
	b _0215FD70
_0215FD16:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ble _0215FD70
	mov r0, r4
	bl NameMenu__DeleteCharacter
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FD70
_0215FD2A:
	ldrh r0, [r2, #4]
	tst r0, r5
	beq _0215FD70
	mov r0, #0
	str r5, [sp]
	bl PlaySysMenuNavSfx
	b _0215FD70
_0215FD3A:
	mov r1, #2
	mov r0, r3
	tst r0, r1
	beq _0215FD56
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ble _0215FD70
	mov r0, r4
	bl NameMenu__DeleteCharacter
	mov r0, r5
	bl PlaySysMenuNavSfx
	b _0215FD70
_0215FD56:
	ldrh r2, [r2, #4]
	mov r0, #8
	tst r0, r2
	beq _0215FD70
	ldr r0, [r4, #0x44]
	cmp r0, #2
	beq _0215FD70
	mov r0, r4
	bl NameMenu__SetMenuSelection
	mov r0, #0
	bl PlaySysMenuNavSfx
_0215FD70:
	mov r1, #0x62
	ldr r0, [sp, #0xc]
	lsl r1, r1, #2
	cmp r0, r1
	bhs _0215FD8E
	ldr r1, [sp, #0xc]
	mov r0, r4
	bl NameMenu__SetCharacter
	mov r0, #0x10
	str r0, [r4, #0x34]
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FD8E:
	ldr r1, _0215FEFC // =0x0000FFF8
	sub r0, r0, r1
	cmp r0, #6
	bls _0215FD98
	b _0215FEA0
_0215FD98:
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215FDA4: // jump table
	.hword _0215FE1E - _0215FDA4 - 2 // case 0
	.hword _0215FDFA - _0215FDA4 - 2 // case 1
	.hword _0215FE82 - _0215FDA4 - 2 // case 2
	.hword _0215FE62 - _0215FDA4 - 2 // case 3
	.hword _0215FE42 - _0215FDA4 - 2 // case 4
	.hword _0215FDD6 - _0215FDA4 - 2 // case 5
	.hword _0215FDB2 - _0215FDA4 - 2 // case 6
_0215FDB2:
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _0215FDC8
	mov r0, r4
	mov r1, #0
	bl NameMenu__SetTextPage
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FDC8:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FDD6:
	ldr r0, [r4, #8]
	cmp r0, #1
	beq _0215FDEC
	mov r0, r4
	mov r1, #1
	bl NameMenu__SetTextPage
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FDEC:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FDFA:
	ldr r0, [r4, #8]
	cmp r0, #2
	beq _0215FE10
	mov r0, r4
	mov r1, #2
	bl NameMenu__SetTextPage
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE10:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE1E:
	ldr r0, [r4, #8]
	cmp r0, #3
	beq _0215FE34
	mov r0, r4
	mov r1, #3
	bl NameMenu__SetTextPage
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE34:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE42:
	mov r0, r4
	bl NameMenu__Func_215FFE8
	cmp r0, #0
	beq _0215FE54
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE54:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE62:
	mov r0, r4
	bl NameMenu__Func_2160028
	cmp r0, #0
	beq _0215FE74
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE74:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE82:
	mov r0, r4
	bl NameMenu__Func_2160068
	cmp r0, #0
	beq _0215FE94
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE94:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FEA0:
	ldr r0, _0215FF00 // =NameMenu__sVars
	ldr r0, [r0, #0]
	bl NameMenu__DrawMenu
	ldr r0, [sp]
	cmp r0, #0
	beq _0215FECC
	mov r0, #1
	str r0, [r4, #0x10]
	mov r0, #0
	mov r1, r4
	str r0, [r4, #0x14]
	mov r0, #2
	add r1, #0x3c
	mov r2, #0xc
	bl MIi_CpuClear32
	ldr r1, _0215FF04 // =NameMenu__State_FadeOut
	ldr r0, _0215FF08 // =0x00000D18
	add sp, #0x14
	str r1, [r4, r0]
	pop {r4, r5, r6, r7, pc}
_0215FECC:
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _0215FEEA
	mov r0, #0
	str r0, [r4, #0x10]
	mov r1, r4
	str r0, [r4, #0x14]
	mov r0, #2
	add r1, #0x3c
	mov r2, #0xc
	bl MIi_CpuClear32
	ldr r1, _0215FF04 // =NameMenu__State_FadeOut
	ldr r0, _0215FF08 // =0x00000D18
	str r1, [r4, r0]
_0215FEEA:
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	nop
_0215FEF0: .word _02161A60
_0215FEF4: .word 0x0000FFFF
_0215FEF8: .word padInput
_0215FEFC: .word 0x0000FFF8
_0215FF00: .word NameMenu__sVars
_0215FF04: .word NameMenu__State_FadeOut
_0215FF08: .word 0x00000D18
	thumb_func_end NameMenu__State_Active

	thumb_func_start NameMenu__State_FadeOut
NameMenu__State_FadeOut: // 0x0215FF0C
	push {r4, lr}
	ldr r2, _0215FF64 // =VRAMSystem__GFXControl
	mov r1, #0
	ldr r3, [r2, #4]
	mov r2, #0x58
	ldrsh r4, [r3, r2]
	ldr r2, [r0, #4]
	mov r3, #1
	tst r2, r3
	beq _0215FF30
	add r2, r4, #1
	lsl r2, r2, #0x10
	asr r4, r2, #0x10
	cmp r4, #0x10
	blt _0215FF44
	mov r4, #0x10
	mov r1, r3
	b _0215FF44
_0215FF30:
	sub r2, r4, #1
	lsl r2, r2, #0x10
	asr r4, r2, #0x10
	mov r2, r3
	sub r2, #0x11
	cmp r4, r2
	bgt _0215FF44
	mov r4, r3
	sub r4, #0x11
	mov r1, r3
_0215FF44:
	ldr r2, _0215FF68 // =0x0213D2A4
	cmp r1, #0
	strh r4, [r2, #0x18]
	ldr r2, _0215FF6C // =0x0213D300
	strh r4, [r2, #0x18]
	beq _0215FF58
	ldr r1, _0215FF70 // =0x00000D18
	mov r2, #0
	str r2, [r0, r1]
	pop {r4, pc}
_0215FF58:
	ldr r0, _0215FF74 // =NameMenu__sVars
	ldr r0, [r0, #0]
	bl NameMenu__DrawMenu
	pop {r4, pc}
	nop
_0215FF64: .word VRAMSystem__GFXControl
_0215FF68: .word 0x0213D2A4
_0215FF6C: .word 0x0213D300
_0215FF70: .word 0x00000D18
_0215FF74: .word NameMenu__sVars
	thumb_func_end NameMenu__State_FadeOut

	thumb_func_start NameMenu__SetCharacter
NameMenu__SetCharacter: // 0x0215FF78
	push {r4, lr}
	mov r4, r0
	mov r2, r1
	ldr r1, [r4, #0x2c]
	cmp r1, #8
	blt _0215FF88
	mov r1, #7
	b _0215FF8C
_0215FF88:
	add r0, r1, #1
	str r0, [r4, #0x2c]
_0215FF8C:
	lsl r0, r1, #1
	add r0, r4, r0
	lsl r1, r1, #0x10
	strh r2, [r0, #0x1c]
	mov r0, r4
	lsr r1, r1, #0x10
	bl NameMenu__Func_21600A8
	mov r0, r4
	bl NameMenu__InitName
	ldr r0, _0215FFB0 // =0x000009F8
	mov r1, #0x1e
	add r0, r4, r0
	bl AnimatorSprite__SetAnimation
	pop {r4, pc}
	nop
_0215FFB0: .word 0x000009F8
	thumb_func_end NameMenu__SetCharacter

	thumb_func_start NameMenu__DeleteCharacter
NameMenu__DeleteCharacter: // 0x0215FFB4
	push {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x2c]
	cmp r1, #0
	beq _0215FFE2
	sub r3, r1, #1
	lsl r1, r3, #1
	str r3, [r4, #0x2c]
	mov r2, #0
	add r1, r4, r1
	strh r2, [r1, #0x1c]
	lsl r1, r3, #0x10
	lsr r1, r1, #0x10
	bl NameMenu__Func_21600A8
	mov r0, r4
	bl NameMenu__InitName
	ldr r0, _0215FFE4 // =0x000009F8
	mov r1, #0x1e
	add r0, r4, r0
	bl AnimatorSprite__SetAnimation
_0215FFE2:
	pop {r4, pc}
	.align 2, 0
_0215FFE4: .word 0x000009F8
	thumb_func_end NameMenu__DeleteCharacter

	thumb_func_start NameMenu__Func_215FFE8
NameMenu__Func_215FFE8: // 0x0215FFE8
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r0, [r7, #0x2c]
	cmp r0, #0
	bne _0215FFF6
	mov r0, #0
	pop {r3, r4, r5, r6, r7, pc}
_0215FFF6:
	sub r0, r0, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	mov r4, r7
	add r4, #0x1c
	lsl r6, r5, #1
	ldrh r0, [r4, r6]
	bl NameMenu__Func_2160DDC
	mov r2, r0
	ldr r0, _02160024 // =0x0000FFFF
	cmp r2, r0
	bne _02160014
	mov r0, #0
	pop {r3, r4, r5, r6, r7, pc}
_02160014:
	mov r0, r7
	mov r1, r5
	strh r2, [r4, r6]
	bl NameMenu__Func_21600A8
	mov r0, #1
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02160024: .word 0x0000FFFF
	thumb_func_end NameMenu__Func_215FFE8

	thumb_func_start NameMenu__Func_2160028
NameMenu__Func_2160028: // 0x02160028
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r0, [r7, #0x2c]
	cmp r0, #0
	bne _02160036
	mov r0, #0
	pop {r3, r4, r5, r6, r7, pc}
_02160036:
	sub r0, r0, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	mov r4, r7
	add r4, #0x1c
	lsl r6, r5, #1
	ldrh r0, [r4, r6]
	bl NameMenu__Func_2160DF8
	mov r2, r0
	ldr r0, _02160064 // =0x0000FFFF
	cmp r2, r0
	bne _02160054
	mov r0, #0
	pop {r3, r4, r5, r6, r7, pc}
_02160054:
	mov r0, r7
	mov r1, r5
	strh r2, [r4, r6]
	bl NameMenu__Func_21600A8
	mov r0, #1
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02160064: .word 0x0000FFFF
	thumb_func_end NameMenu__Func_2160028

	thumb_func_start NameMenu__Func_2160068
NameMenu__Func_2160068: // 0x02160068
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r0, [r7, #0x2c]
	cmp r0, #0
	bne _02160076
	mov r0, #0
	pop {r3, r4, r5, r6, r7, pc}
_02160076:
	sub r0, r0, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	mov r4, r7
	add r4, #0x1c
	lsl r6, r5, #1
	ldrh r0, [r4, r6]
	bl NameMenu__Func_2160E14
	mov r2, r0
	ldr r0, _021600A4 // =0x0000FFFF
	cmp r2, r0
	bne _02160094
	mov r0, #0
	pop {r3, r4, r5, r6, r7, pc}
_02160094:
	mov r0, r7
	mov r1, r5
	strh r2, [r4, r6]
	bl NameMenu__Func_21600A8
	mov r0, #1
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021600A4: .word 0x0000FFFF
	thumb_func_end NameMenu__Func_2160068

	thumb_func_start NameMenu__Func_21600A8
NameMenu__Func_21600A8: // 0x021600A8
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x20
	mov r5, r0
	ldr r0, _0216013C // =0x00000DF4
	mov r7, r2
	ldr r0, [r5, r0]
	mov r4, r1
	bl FontWindow__GetFont
	mov r1, r7
	str r0, [sp, #0x1c]
	bl FontFile__GetCharXAdvance
	lsl r0, r4, #0x14
	lsr r6, r0, #0x10
	ldr r0, [sp, #0x1c]
	mov r1, #0
	bl FontFile__GetPixels
	mov r1, #0x10
	str r1, [sp]
	str r1, [sp, #4]
	ldr r1, _02160140 // =0x00000E28
	mov r2, #0
	ldr r1, [r5, r1]
	mov r3, r2
	str r1, [sp, #8]
	mov r1, #0x12
	str r1, [sp, #0xc]
	str r6, [sp, #0x10]
	mov r1, #4
	str r1, [sp, #0x14]
	mov r1, #2
	str r2, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	cmp r7, #0
	beq _0216011C
	mov r0, #0x12
	str r0, [sp]
	mov r0, #3
	str r0, [sp, #4]
	lsl r0, r6, #0x10
	asr r0, r0, #0x10
	str r0, [sp, #8]
	mov r0, #4
	str r0, [sp, #0xc]
	mov r2, #0
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r0, #1
	str r0, [sp, #0x18]
	ldr r3, _02160140 // =0x00000E28
	ldr r0, [sp, #0x1c]
	ldr r3, [r5, r3]
	mov r1, r7
	bl FontFile__Func_2052B7C
_0216011C:
	add r3, r4, #1
	mov r0, #2
	lsl r3, r3, #1
	str r0, [sp]
	ldr r0, _02160144 // =0x00000DF8
	sub r3, r3, #1
	lsl r1, r4, #0x11
	lsl r3, r3, #0x10
	add r0, r5, r0
	lsr r1, r1, #0x10
	mov r2, #0
	lsr r3, r3, #0x10
	bl Unknown2056570__Func_2056958
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216013C: .word 0x00000DF4
_02160140: .word 0x00000E28
_02160144: .word 0x00000DF8
	thumb_func_end NameMenu__Func_21600A8

	thumb_func_start NameMenu__DrawCharacterCursor
NameMenu__DrawCharacterCursor: // 0x02160148
	push {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, _0216019C // =0x00000DF8
	add r0, r4, r0
	bl Unknown2056570__Func_2056A58
	ldr r0, _0216019C // =0x00000DF8
	add r0, r4, r0
	bl Unknown2056570__Func_2056A94
	ldr r5, _021601A0 // =0x00000B24
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, r5
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0x14]
	cmp r0, #0
	beq _0216019A
	ldr r1, [r4, #0x2c]
	cmp r1, #8
	blt _0216017C
	mov r1, #7
_0216017C:
	ldr r0, _021601A4 // =0x000009F8
	add r4, r4, r0
	lsl r0, r1, #4
	add r0, #0x40
	strh r0, [r4, #8]
	mov r0, #0xc
	mov r1, #0
	strh r0, [r4, #0xa]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_0216019A:
	pop {r3, r4, r5, pc}
	.align 2, 0
_0216019C: .word 0x00000DF8
_021601A0: .word 0x00000B24
_021601A4: .word 0x000009F8
	thumb_func_end NameMenu__DrawCharacterCursor

	thumb_func_start NameMenu__InitName
NameMenu__InitName: // 0x021601A8
	push {r4, lr}
	ldr r1, [r0, #0x2c]
	cmp r1, #0
	ble _021601B4
	mov r1, #0
	b _021601B6
_021601B4:
	mov r1, #2
_021601B6:
	mov r2, #0
	str r1, [r0, #0x40]
	mov r3, r2
	mov r4, r0
_021601BE:
	ldrh r1, [r4, #0x1c]
	cmp r1, #0
	beq _021601CC
	cmp r1, #0xb6
	beq _021601CC
	mov r2, #1
	b _021601D4
_021601CC:
	add r3, r3, #1
	add r4, r4, #2
	cmp r3, #8
	blt _021601BE
_021601D4:
	cmp r2, #0
	beq _021601E4
	ldr r1, [r0, #0x2c]
	cmp r1, #0
	ble _021601E4
	mov r1, #0
	str r1, [r0, #0x44]
	b _021601E8
_021601E4:
	mov r1, #2
	str r1, [r0, #0x44]
_021601E8:
	ldr r2, [r0, #0x38]
	lsl r1, r2, #2
	add r3, r0, r1
	ldr r1, [r3, #0x3c]
	cmp r1, #2
	blo _021601FE
_021601F4:
	sub r3, r3, #4
	ldr r1, [r3, #0x3c]
	sub r2, r2, #1
	cmp r1, #2
	bhs _021601F4
_021601FE:
	ldr r1, [r0, #0x38]
	cmp r1, r2
	beq _02160210
	ldr r1, _02160214 // =0x00000CB4
	str r2, [r0, #0x38]
	add r0, r0, r1
	mov r1, #0x38
	bl AnimatorSprite__SetAnimation
_02160210:
	pop {r4, pc}
	nop
_02160214: .word 0x00000CB4
	thumb_func_end NameMenu__InitName

	thumb_func_start NameMenu__Func_2160218
NameMenu__Func_2160218: // 0x02160218
	push {r4, r5, r6, lr}
	mov r5, r1
	cmp r5, #0x20
	blo _02160224
	mov r0, #0
	pop {r4, r5, r6, pc}
_02160224:
	mov r1, #0xb6
	ldr r0, _02160264 // =0x01C71000
	lsl r1, r1, #0xe
	mov r2, #0x20
	mov r3, r5
	bl Unknown2051334__Func_20516B8
	mov r6, r0
	mov r0, r5
	mov r1, #8
	bl FX_DivS32
	mov r4, r0
	lsl r0, r4, #3
	sub r3, r5, r0
	cmp r3, #4
	blt _0216024A
	mov r0, #8
	sub r3, r0, r3
_0216024A:
	mov r0, #0
	mov r1, r6
	mov r2, #4
	bl Unknown2051334__Func_20516B8
	asr r1, r0, #0xc
	mov r0, #1
	tst r0, r4
	beq _0216025E
	neg r1, r1
_0216025E:
	lsl r0, r1, #0x10
	lsr r0, r0, #0x10
	pop {r4, r5, r6, pc}
	.align 2, 0
_02160264: .word 0x01C71000
	thumb_func_end NameMenu__Func_2160218

	thumb_func_start NameMenu__UpdateTextPage
NameMenu__UpdateTextPage: // 0x02160268
	push {r3, lr}
	ldr r2, [r0, #8]
	cmp r2, #7
	bge _02160278
	lsl r3, r2, #2
	ldr r2, _0216028C // =_02161A28
	ldr r2, [r2, r3]
	b _0216027A
_02160278:
	mov r2, #6
_0216027A:
	cmp r2, r1
	beq _02160288
	lsl r2, r1, #2
	ldr r1, _02160290 // =_021619E4
	ldr r1, [r1, r2]
	bl NameMenu__SetTextPage
_02160288:
	pop {r3, pc}
	nop
_0216028C: .word _02161A28
_02160290: .word _021619E4
	thumb_func_end NameMenu__UpdateTextPage

	thumb_func_start NameMenu__SetTextPage
NameMenu__SetTextPage: // 0x02160294
	push {r4, r5, r6, lr}
	mov r5, r0
	ldr r0, [r5, #8]
	mov r6, r1
	cmp r0, r6
	beq _02160356
	cmp r0, #7
	bge _021602AC
	lsl r1, r0, #2
	ldr r0, _02160358 // =_02161A28
	ldr r1, [r0, r1]
	b _021602AE
_021602AC:
	mov r1, #6
_021602AE:
	cmp r6, #7
	bge _021602BA
	ldr r0, _02160358 // =_02161A28
	lsl r2, r6, #2
	ldr r4, [r0, r2]
	b _021602BC
_021602BA:
	mov r4, #6
_021602BC:
	cmp r1, r4
	beq _0216030E
	cmp r1, #5
	bge _021602DE
	mov r0, #0xa3
	add r3, r1, #7
	lsl r1, r1, #1
	lsl r0, r0, #2
	mov r2, #0x64
	add r1, #0x11
	lsl r1, r1, #0x10
	add r0, r5, r0
	mul r2, r3
	add r0, r0, r2
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
_021602DE:
	ldr r2, _0216035C // =0x00000D1C
	lsl r0, r4, #2
	add r1, r5, r2
	mov r3, #1
	str r3, [r1, r0]
	sub r2, r2, #4
	ldr r2, [r5, r2]
	cmp r2, #0
	bne _0216030E
	mov r2, #0
	str r2, [r1, r0]
	mov r0, #0xa3
	lsl r0, r0, #2
	add r2, r5, r0
	add r1, r4, #7
	mov r0, #0x64
	mul r0, r1
	lsl r1, r4, #1
	add r1, #0x11
	lsl r1, r1, #0x10
	add r0, r2, r0
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
_0216030E:
	ldr r0, _02160360 // =_02161A44
	lsl r1, r6, #2
	ldr r2, [r0, r1]
	cmp r2, #0
	beq _0216031E
	mov r0, r5
	mov r1, #1
	blx r2
_0216031E:
	str r6, [r5, #8]
	ldr r0, [r5, #0x38]
	cmp r0, #3
	blt _02160344
	ldr r2, [r5, #8]
	ldrh r0, [r5, #0x30]
	lsl r3, r2, #2
	ldr r2, _02160364 // =_02161A60
	ldrh r1, [r5, #0x32]
	ldr r2, [r2, r3]
	blx r2
	ldr r1, _02160368 // =0x0000FFFF
	cmp r0, r1
	bne _02160344
	mov r0, r5
	mov r1, #1
	mov r2, #0
	bl NameMenu__SetCharacterSelection
_02160344:
	ldr r0, [r5, #8]
	mov r2, r5
	add r1, r0, #1
	mov r0, #0x48
	add r2, #0x4c
	mul r0, r1
	add r0, r2, r0
	bl DrawBackground
_02160356:
	pop {r4, r5, r6, pc}
	.align 2, 0
_02160358: .word _02161A28
_0216035C: .word 0x00000D1C
_02160360: .word _02161A44
_02160364: .word _02161A60
_02160368: .word 0x0000FFFF
	thumb_func_end NameMenu__SetTextPage

	thumb_func_start NameMenu__SetCharacterSelection
NameMenu__SetCharacterSelection: // 0x0216036C
	strh r1, [r0, #0x30]
	strh r2, [r0, #0x32]
	mov r1, #4
	str r1, [r0, #0x38]
	mov r1, #0
	str r1, [r0, #0x34]
	ldr r1, _02160384 // =0x00000A5C
	ldr r3, _02160388 // =AnimatorSprite__SetAnimation
	add r0, r0, r1
	mov r1, #0x1f
	bx r3
	nop
_02160384: .word 0x00000A5C
_02160388: .word AnimatorSprite__SetAnimation
	thumb_func_end NameMenu__SetCharacterSelection

	thumb_func_start NameMenu__SetMenuSelection
NameMenu__SetMenuSelection: // 0x0216038C
	str r1, [r0, #0x38]
	ldr r1, _02160398 // =0x00000CB4
	ldr r3, _0216039C // =AnimatorSprite__SetAnimation
	add r0, r0, r1
	mov r1, #0x38
	bx r3
	.align 2, 0
_02160398: .word 0x00000CB4
_0216039C: .word AnimatorSprite__SetAnimation
	thumb_func_end NameMenu__SetMenuSelection

	thumb_func_start NameMenu__ChangePageVariant_JPN_Hiragana
NameMenu__ChangePageVariant_JPN_Hiragana: // 0x021603A0
	push {r4, lr}
	mov r4, r0
	cmp r1, #0
	beq _021603C0
	mov r0, #0xa3
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	mov r0, #0x2f
	lsl r0, r0, #4
	add r0, r4, r0
	mov r1, #2
	bl AnimatorSprite__SetAnimation
_021603C0:
	pop {r4, pc}
	.align 2, 0
	thumb_func_end NameMenu__ChangePageVariant_JPN_Hiragana

	thumb_func_start NameMenu__ChangePageVariant_JPN_Katakana
NameMenu__ChangePageVariant_JPN_Katakana: // 0x021603C4
	push {r4, lr}
	mov r4, r0
	cmp r1, #0
	beq _021603E4
	mov r0, #0xa3
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	mov r0, #0x2f
	lsl r0, r0, #4
	add r0, r4, r0
	mov r1, #3
	bl AnimatorSprite__SetAnimation
_021603E4:
	pop {r4, pc}
	.align 2, 0
	thumb_func_end NameMenu__ChangePageVariant_JPN_Katakana

	thumb_func_start NameMenu__ChangePageVariant_ENG_Lower
NameMenu__ChangePageVariant_ENG_Lower: // 0x021603E8
	push {r4, lr}
	mov r4, r0
	cmp r1, #0
	beq _02160408
	mov r0, #0xd5
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #5
	bl AnimatorSprite__SetAnimation
	mov r0, #0xee
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #6
	bl AnimatorSprite__SetAnimation
_02160408:
	pop {r4, pc}
	.align 2, 0
	thumb_func_end NameMenu__ChangePageVariant_ENG_Lower

	thumb_func_start NameMenu__ChangePageVariant_ENG_Upper
NameMenu__ChangePageVariant_ENG_Upper: // 0x0216040C
	push {r4, lr}
	mov r4, r0
	cmp r1, #0
	beq _0216042C
	mov r0, #0xd5
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #4
	bl AnimatorSprite__SetAnimation
	mov r0, #0xee
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #7
	bl AnimatorSprite__SetAnimation
_0216042C:
	pop {r4, pc}
	.align 2, 0
	thumb_func_end NameMenu__ChangePageVariant_ENG_Upper

	thumb_func_start NameMenu__SetUnknown
NameMenu__SetUnknown: // 0x02160430
	push {r3, r4, r5, lr}
	mov r3, #0xa3
	lsl r3, r3, #2
	add r1, #0xc
	add r4, r0, r3
	mov r0, #0x64
	mov r5, r1
	mul r5, r0
	cmp r2, #0
	beq _0216044E
	add r0, r4, r5
	mov r1, #0x1b
	bl AnimatorSprite__SetAnimation
	pop {r3, r4, r5, pc}
_0216044E:
	add r0, r4, r5
	mov r1, #0x1b
	bl AnimatorSprite__SetAnimation
	mov r1, #1
	mov r2, #0
	add r0, r4, r5
	lsl r1, r1, #0x10
	mov r3, r2
	bl AnimatorSprite__AnimateManual
	pop {r3, r4, r5, pc}
	.align 2, 0
	thumb_func_end NameMenu__SetUnknown

	thumb_func_start NameMenu__DrawMenuInitial
NameMenu__DrawMenuInitial: // 0x02160468
	push {r4, r5, r6, lr}
	mov r5, r0
	ldr r1, [r5, #8]
	mov r6, #0
	lsl r2, r1, #2
	ldr r1, _021604B8 // =_02161A0C
	mov r4, r6
	ldr r1, [r1, r2]
	cmp r1, #0
	beq _0216047E
	blx r1
_0216047E:
	mov r0, r5
	bl NameMenu__DrawCharacterCursor
	ldr r1, [r5, #0x18]
	mov r0, r5
	bl NameMenu__DrawPageSelectionsInitial
	cmp r0, #0
	beq _02160492
	mov r6, #1
_02160492:
	ldr r1, [r5, #0x18]
	mov r0, r5
	bl NameMenu__DrawMenuOptionsInitial
	cmp r0, #0
	beq _021604A0
	mov r4, #1
_021604A0:
	ldr r0, [r5, #0x18]
	add r0, r0, #1
	str r0, [r5, #0x18]
	cmp r6, #0
	beq _021604B2
	cmp r4, #0
	beq _021604B2
	mov r0, #1
	pop {r4, r5, r6, pc}
_021604B2:
	mov r0, #0
	pop {r4, r5, r6, pc}
	nop
_021604B8: .word _02161A0C
	thumb_func_end NameMenu__DrawMenuInitial

	thumb_func_start NameMenu__DrawPageSelectionsInitial
NameMenu__DrawPageSelectionsInitial: // 0x021604BC
	push {r4, r5, r6, r7, lr}
	sub sp, #0x2c
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, r1
	str r1, [sp, #8]
	cmp r0, #0x2d
	bhs _021604D2
	mov r0, #0
	str r0, [sp, #0x14]
_021604D2:
	mov r0, #0
	str r0, [sp, #0x18]
	mov r1, #0xa3
	str r0, [sp, #0x1c]
	str r0, [sp, #0x10]
	ldr r0, _02160690 // =_021619F8
	ldr r7, [sp, #4]
	str r0, [sp, #0xc]
	lsl r1, r1, #2
	mov r0, r7
	add r0, r0, r1
	str r0, [sp, #0x20]
_021604EA:
	ldr r1, [sp, #8]
	ldr r0, [sp, #0x18]
	sub r5, r1, r0
	add r0, r0, #7
	str r0, [sp, #0x18]
	mov r0, #0xaf
	ldr r1, [sp, #0x10]
	lsl r0, r0, #2
	add r1, r1, r0
	ldr r0, [sp, #0x20]
	add r4, r0, r1
	mov r0, #0x4b
	ldr r1, [sp, #0x10]
	lsl r0, r0, #4
	add r1, r1, r0
	ldr r0, [sp, #0x20]
	add r6, r0, r1
	ldr r1, [sp, #0xc]
	mov r0, #0
	ldrsh r0, [r1, r0]
	strh r0, [r6, #8]
	mov r0, #8
	ldrsh r0, [r6, r0]
	strh r0, [r4, #8]
	mov r0, #2
	ldrsh r0, [r1, r0]
	strh r0, [r6, #0xa]
	mov r0, #0xa
	ldrsh r0, [r6, r0]
	cmp r5, #0x30
	strh r0, [r4, #0xa]
	blt _0216054C
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	b _02160606
_0216054C:
	cmp r5, #0
	bge _0216056A
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #1
	lsl r1, r1, #0xa
	mov r0, r4
	mov r2, r1
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	b _02160606
_0216056A:
	cmp r5, #0x10
	bhs _0216059C
	mov r0, #1
	lsl r0, r0, #0xc
	mov r1, #1
	str r0, [sp]
	lsr r0, r0, #2
	lsl r1, r1, #0xc
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	mov r1, #0
	str r0, [sp, #0x24]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [sp, #0x24]
	mov r0, r4
	mov r2, r1
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	b _021605E4
_0216059C:
	blo _021605E4
	mov r1, r5
	ldr r0, _02160694 // =0x00000D1C
	sub r1, #0x10
	str r1, [r7, r0]
	ldr r1, _02160694 // =0x00000D1C
	ldr r0, [sp, #4]
	ldr r1, [r7, r1]
	bl NameMenu__Func_2160218
	mov r1, #0
	str r0, [sp, #0x28]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r3, [sp, #0x28]
	mov r1, #1
	lsl r1, r1, #0xc
	lsl r3, r3, #0x10
	mov r0, r4
	mov r2, r1
	lsr r3, r3, #0x10
	bl AnimatorSprite__DrawFrameRotoZoom
	ldr r0, _02160694 // =0x00000D1C
	ldr r0, [r7, r0]
	add r1, r0, #1
	ldr r0, _02160694 // =0x00000D1C
	str r1, [r7, r0]
	ldr r0, [r7, r0]
	cmp r0, #0x20
	blo _021605E4
	ldr r0, _02160694 // =0x00000D1C
	mov r1, #0
	str r1, [r7, r0]
_021605E4:
	cmp r5, #8
	bne _021605F2
	ldr r0, [sp, #4]
	ldr r1, [sp, #0x1c]
	mov r2, #1
	bl NameMenu__SetUnknown
_021605F2:
	cmp r5, #8
	blo _02160606
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	bl AnimatorSprite__DrawFrame
_02160606:
	ldr r0, [sp, #0x10]
	add r7, r7, #4
	add r0, #0x64
	str r0, [sp, #0x10]
	ldr r0, [sp, #0xc]
	add r0, r0, #4
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x1c]
	add r0, r0, #1
	str r0, [sp, #0x1c]
	cmp r0, #5
	bge _02160620
	b _021604EA
_02160620:
	ldr r0, [sp, #8]
	cmp r0, #0x15
	blo _02160686
	mov r1, #0x93
	ldr r0, [sp, #4]
	lsl r1, r1, #4
	add r4, r0, r1
	add r1, #0x64
	add r5, r0, r1
	mov r0, #0x28
	strh r0, [r4, #0xa]
	strh r0, [r5, #0xa]
	ldr r0, [sp, #8]
	sub r0, #0x15
	str r0, [sp, #8]
	cmp r0, #0x10
	blo _02160646
	mov r0, #0
	b _0216065C
_02160646:
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [sp]
	ldr r3, [sp, #8]
	mov r0, #0x20
	mov r1, #0
	mov r2, #0x10
	bl Unknown2051334__Func_2051534
	mov r1, #0
	str r1, [sp, #0x14]
_0216065C:
	neg r1, r0
	strh r1, [r4, #8]
	add r0, #0xf0
	mov r1, #0
	strh r0, [r5, #8]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	b _0216068A
_02160686:
	mov r0, #0
	str r0, [sp, #0x14]
_0216068A:
	ldr r0, [sp, #0x14]
	add sp, #0x2c
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02160690: .word _021619F8
_02160694: .word 0x00000D1C
	thumb_func_end NameMenu__DrawPageSelectionsInitial

	thumb_func_start NameMenu__DrawMenuOptionsInitial
NameMenu__DrawMenuOptionsInitial: // 0x02160698
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp, #0xc]
	str r1, [sp, #8]
	mov r7, r1
	mov r1, #0xa3
	lsl r1, r1, #2
	add r0, r0, r1
	mov r5, #0x1c
	mov r6, #0x14
	str r0, [sp, #0x10]
_021606B2:
	ldr r0, [sp, #4]
	cmp r5, r0
	bhi _02160704
	ldr r1, [sp, #8]
	ldr r0, _02160730 // =0x000008FC
	add r1, r1, r0
	ldr r0, [sp, #0x10]
	add r4, r0, r1
	ldr r0, [sp, #4]
	strh r6, [r4, #8]
	sub r3, r0, r5
	cmp r3, #8
	blo _021606D0
	mov r0, #0xa0
	b _021606E2
_021606D0:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x40
	mov r1, #0
	mov r2, #8
	bl Unknown2051334__Func_2051534
	add r0, #0xa0
_021606E2:
	strh r0, [r4, #0xa]
	ldrh r0, [r4, #0xc]
	cmp r0, #0
	beq _021606F4
	lsl r1, r7, #0x10
	mov r0, r4
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
_021606F4:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_02160704:
	add r6, #0x48
	lsl r0, r6, #0x10
	asr r6, r0, #0x10
	ldr r0, [sp, #8]
	add r5, r5, #4
	add r0, #0x64
	str r0, [sp, #8]
	ldr r0, [sp, #0xc]
	add r7, r7, #3
	add r0, r0, #1
	str r0, [sp, #0xc]
	cmp r0, #3
	blt _021606B2
	ldr r0, [sp, #4]
	cmp r0, #0x30
	blo _0216072A
	add sp, #0x14
	mov r0, #1
	pop {r4, r5, r6, r7, pc}
_0216072A:
	mov r0, #0
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02160730: .word 0x000008FC
	thumb_func_end NameMenu__DrawMenuOptionsInitial

	thumb_func_start NameMenu__DrawMenu
NameMenu__DrawMenu: // 0x02160734
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r5, r0
	ldr r1, [r5, #8]
	lsl r2, r1, #2
	ldr r1, _021607F4 // =_02161A0C
	ldr r1, [r1, r2]
	cmp r1, #0
	beq _02160748
	blx r1
_02160748:
	mov r0, r5
	bl NameMenu__DrawPageSelections
	mov r0, r5
	bl NameMenu__DrawCharacterCursor
	mov r0, r5
	bl NameMenu__DrawMenuOptions
	ldr r0, [r5, #0x14]
	cmp r0, #0
	beq _021607E6
	ldr r0, [r5, #0x38]
	cmp r0, #3
	blt _021607E6
	ldr r0, _021607F8 // =0x00000A5C
	mov r1, #0
	add r6, r5, r0
	ldrh r0, [r5, #0x30]
	mov r2, r1
	lsl r0, r0, #4
	add r0, #0x20
	strh r0, [r6, #8]
	ldrh r0, [r5, #0x32]
	lsl r0, r0, #4
	add r0, #0x48
	strh r0, [r6, #0xa]
	mov r0, r6
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	ldr r0, [r5, #0x34]
	cmp r0, #0
	beq _021607E6
	mov r0, #0x2b
	lsl r0, r0, #6
	add r4, r5, r0
	mov r0, #8
	ldrsh r0, [r6, r0]
	strh r0, [r4, #8]
	mov r0, #0xa
	ldrsh r0, [r6, r0]
	strh r0, [r4, #0xa]
	ldr r0, [r5, #0x34]
	cmp r0, #0x10
	bne _021607B6
	mov r0, #0
	str r0, [r4, #0x58]
	mov r0, r5
	mov r1, #0x10
	bl NameMenu__SetupBlending
	b _021607D6
_021607B6:
	mov r0, #1
	str r0, [r4, #0x58]
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x10
	ldr r3, [r5, #0x34]
	mov r1, #0
	mov r2, r0
	sub r3, r0, r3
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	mov r0, r5
	bl NameMenu__SetupBlending
_021607D6:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_021607E6:
	ldr r0, [r5, #0x34]
	cmp r0, #0
	beq _021607F0
	sub r0, r0, #1
	str r0, [r5, #0x34]
_021607F0:
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	.align 2, 0
_021607F4: .word _02161A0C
_021607F8: .word 0x00000A5C
	thumb_func_end NameMenu__DrawMenu

	thumb_func_start NameMenu__DrawPageVariants_JPN
NameMenu__DrawPageVariants_JPN: // 0x021607FC
	push {r4, r5, r6, lr}
	mov r5, #0xa3
	mov r1, #0
	mov r4, r0
	lsl r5, r5, #2
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, r5
	bl AnimatorSprite__DrawFrame
	add r5, #0x64
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, r5
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ble _02160834
	lsl r0, r0, #1
	add r0, r4, r0
	ldrh r6, [r0, #0x1a]
	b _02160836
_02160834:
	mov r6, #0
_02160836:
	ldr r0, _021608D0 // =0x0000041C
	add r5, r4, r0
	mov r0, r6
	bl NameMenu__Func_2160DDC
	ldr r1, _021608D4 // =0x0000FFFF
	cmp r0, r1
	beq _0216084A
	mov r1, #8
	b _0216084C
_0216084A:
	mov r1, #0xa
_0216084C:
	ldrh r0, [r5, #0xc]
	cmp r1, r0
	beq _02160858
	mov r0, r5
	bl AnimatorSprite__SetAnimation
_02160858:
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	mov r0, #0x12
	lsl r0, r0, #6
	add r5, r4, r0
	mov r0, r6
	bl NameMenu__Func_2160DF8
	ldr r1, _021608D4 // =0x0000FFFF
	cmp r0, r1
	beq _0216087E
	mov r1, #0xb
	b _02160880
_0216087E:
	mov r1, #0xd
_02160880:
	ldrh r0, [r5, #0xc]
	cmp r1, r0
	beq _0216088C
	mov r0, r5
	bl AnimatorSprite__SetAnimation
_0216088C:
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r0, _021608D8 // =0x000004E4
	add r4, r4, r0
	mov r0, r6
	bl NameMenu__Func_2160E14
	ldr r1, _021608D4 // =0x0000FFFF
	cmp r0, r1
	beq _021608B0
	mov r1, #0xe
	b _021608B2
_021608B0:
	mov r1, #0x10
_021608B2:
	ldrh r0, [r4, #0xc]
	cmp r1, r0
	beq _021608BE
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_021608BE:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	pop {r4, r5, r6, pc}
	.align 2, 0
_021608D0: .word 0x0000041C
_021608D4: .word 0x0000FFFF
_021608D8: .word 0x000004E4
	thumb_func_end NameMenu__DrawPageVariants_JPN

	thumb_func_start NameMenu__DrawPageVariants_ENG
NameMenu__DrawPageVariants_ENG: // 0x021608DC
	push {r3, r4, r5, lr}
	mov r5, #0xd5
	mov r1, #0
	mov r4, r0
	lsl r5, r5, #2
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, r5
	bl AnimatorSprite__DrawFrame
	add r5, #0x64
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, r5
	bl AnimatorSprite__DrawFrame
	pop {r3, r4, r5, pc}
	thumb_func_end NameMenu__DrawPageVariants_ENG

	thumb_func_start NameMenu__DrawPageSelections
NameMenu__DrawPageSelections: // 0x02160908
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	str r0, [sp]
	mov r0, #0
	mov r1, #0xa3
	ldr r5, [sp]
	str r0, [sp, #0xc]
	str r0, [sp, #8]
	mov r0, #0x12
	str r0, [sp, #4]
	lsl r1, r1, #2
	mov r0, r5
	add r0, r0, r1
	ldr r7, _02160A28 // =_021619F8
	str r0, [sp, #0x10]
_02160926:
	mov r0, #0xaf
	ldr r1, [sp, #8]
	lsl r0, r0, #2
	add r1, r1, r0
	ldr r0, [sp, #0x10]
	add r4, r0, r1
	mov r0, #0x4b
	ldr r1, [sp, #8]
	lsl r0, r0, #4
	add r1, r1, r0
	ldr r0, [sp, #0x10]
	add r6, r0, r1
	mov r0, #0
	ldrsh r0, [r7, r0]
	mov r1, #0
	mov r2, r1
	strh r0, [r4, #8]
	mov r0, #2
	ldrsh r0, [r7, r0]
	strh r0, [r4, #0xa]
	mov r0, #8
	ldrsh r0, [r4, r0]
	strh r0, [r6, #8]
	mov r0, #0xa
	ldrsh r0, [r4, r0]
	strh r0, [r6, #0xa]
	mov r0, r6
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	ldr r0, _02160A2C // =0x00000D1C
	ldr r0, [r5, r0]
	cmp r0, #0
	bne _02160980
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	b _021609CC
_02160980:
	sub r6, r0, #1
	bne _02160990
	ldr r1, [sp, #4]
	mov r0, r4
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
_02160990:
	ldr r0, [sp]
	mov r1, r6
	bl NameMenu__Func_2160218
	mov r1, #0
	mov r6, r0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #1
	lsl r1, r1, #0xc
	lsl r3, r6, #0x10
	mov r0, r4
	mov r2, r1
	lsr r3, r3, #0x10
	bl AnimatorSprite__DrawFrameRotoZoom
	ldr r0, _02160A2C // =0x00000D1C
	ldr r0, [r5, r0]
	cmp r0, #0x20
	ldr r0, _02160A2C // =0x00000D1C
	bhs _021609C8
	ldr r0, [r5, r0]
	add r1, r0, #1
	ldr r0, _02160A2C // =0x00000D1C
	str r1, [r5, r0]
	b _021609CC
_021609C8:
	mov r1, #0
	str r1, [r5, r0]
_021609CC:
	ldr r0, [sp, #8]
	add r7, r7, #4
	add r0, #0x64
	str r0, [sp, #8]
	ldr r0, [sp, #4]
	add r5, r5, #4
	add r0, r0, #2
	str r0, [sp, #4]
	ldr r0, [sp, #0xc]
	add r0, r0, #1
	str r0, [sp, #0xc]
	cmp r0, #5
	blt _02160926
	mov r1, #0x93
	ldr r0, [sp]
	lsl r1, r1, #4
	add r4, r0, r1
	mov r1, #0
	strh r1, [r4, #8]
	mov r0, #0x28
	strh r0, [r4, #0xa]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldr r1, _02160A30 // =0x00000994
	ldr r0, [sp]
	add r4, r0, r1
	mov r0, #0xf0
	strh r0, [r4, #8]
	mov r0, #0x28
	mov r1, #0
	strh r0, [r4, #0xa]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	nop
_02160A28: .word _021619F8
_02160A2C: .word 0x00000D1C
_02160A30: .word 0x00000994
	thumb_func_end NameMenu__DrawPageSelections

	thumb_func_start NameMenu__DrawMenuOptions
NameMenu__DrawMenuOptions: // 0x02160A34
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	str r0, [sp]
	mov r0, #0
	mov r1, #0xd3
	str r0, [sp, #0x10]
	str r0, [sp, #0xc]
	ldr r0, [sp]
	lsl r1, r1, #4
	add r7, r0, r1
	str r0, [sp, #8]
	ldr r0, [sp, #0x10]
	sub r1, #0x7c
	str r0, [sp, #4]
	ldr r0, [sp]
	mov r6, #0x14
	add r5, r0, r1
	mov r1, #0xa3
	lsl r1, r1, #2
	add r0, r0, r1
	str r0, [sp, #0x14]
_02160A5E:
	ldr r1, [sp, #0xc]
	ldr r0, _02160B08 // =0x000008FC
	add r1, r1, r0
	ldr r0, [sp, #0x14]
	add r4, r0, r1
	ldr r0, [r7, #0x14]
	mov r1, #0xa0
	strh r6, [r4, #8]
	strh r1, [r4, #0xa]
	ldr r1, [sp, #8]
	ldr r1, [r1, #0x3c]
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	cmp r1, #2
	beq _02160A90
	mov r1, #2
	lsl r1, r1, #0xa
	tst r1, r0
	bne _02160A8E
	mov r1, #0x10
	tst r0, r1
	beq _02160A8E
	mov r1, #1
	b _02160A90
_02160A8E:
	mov r1, #0
_02160A90:
	ldr r0, [sp, #4]
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	add r0, r1, r0
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	ldrh r0, [r4, #0xc]
	cmp r1, r0
	beq _02160AA8
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_02160AA8:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldr r0, [sp]
	ldr r1, [r0, #0x38]
	ldr r0, [sp, #0x10]
	cmp r0, r1
	bne _02160ADE
	mov r0, #8
	ldrsh r0, [r4, r0]
	mov r1, #0
	mov r2, r1
	strh r0, [r5, #8]
	mov r0, #0xa
	ldrsh r0, [r4, r0]
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	bl AnimatorSprite__DrawFrame
_02160ADE:
	add r6, #0x48
	lsl r0, r6, #0x10
	asr r6, r0, #0x10
	ldr r0, [sp, #0xc]
	add r7, #0x38
	add r0, #0x64
	str r0, [sp, #0xc]
	ldr r0, [sp, #8]
	add r0, r0, #4
	str r0, [sp, #8]
	ldr r0, [sp, #4]
	add r0, r0, #3
	str r0, [sp, #4]
	ldr r0, [sp, #0x10]
	add r0, r0, #1
	str r0, [sp, #0x10]
	cmp r0, #3
	blt _02160A5E
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02160B08: .word 0x000008FC
	thumb_func_end NameMenu__DrawMenuOptions

	thumb_func_start NameMenu__CheckPageChange
NameMenu__CheckPageChange: // 0x02160B0C
	push {r4, r5, r6, lr}
	ldr r1, [r0, #8]
	mov r3, #1
	lsl r2, r1, #2
	ldr r1, _02160BB8 // =_02161A28
	ldr r6, _02160BBC // =padInput
	ldr r4, [r1, r2]
	ldrh r1, [r6, #0]
	lsl r3, r3, #8
	mov r5, r4
	mov r2, r1
	and r2, r3
	beq _02160B4A
	ldrh r1, [r6, #4]
	tst r1, r3
	beq _02160B30
	mov r1, #0
	str r1, [r0, #0x48]
_02160B30:
	ldr r2, [r0, #0x48]
	mov r1, #0xf
	tst r1, r2
	bne _02160B42
	cmp r5, #4
	blt _02160B40
	mov r5, #0
	b _02160B42
_02160B40:
	add r5, r5, #1
_02160B42:
	ldr r1, [r0, #0x48]
	add r1, r1, #1
	str r1, [r0, #0x48]
	b _02160B78
_02160B4A:
	cmp r2, #0
	bne _02160B78
	lsl r2, r3, #1
	tst r1, r2
	beq _02160B78
	ldrh r2, [r6, #4]
	lsl r1, r3, #1
	tst r1, r2
	beq _02160B60
	mov r1, #0
	str r1, [r0, #0x48]
_02160B60:
	ldr r2, [r0, #0x48]
	mov r1, #0xf
	tst r1, r2
	bne _02160B72
	cmp r5, #0
	bne _02160B70
	mov r5, #4
	b _02160B72
_02160B70:
	sub r5, r5, #1
_02160B72:
	ldr r1, [r0, #0x48]
	add r1, r1, #1
	str r1, [r0, #0x48]
_02160B78:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02160BAE
	ldr r1, _02160BC0 // =touchInput
	mov r0, #4
	ldrh r2, [r1, #0x12]
	tst r0, r2
	beq _02160BAE
	ldrh r6, [r1, #0x1c]
	ldrh r1, [r1, #0x1e]
	mov r2, #0x11
	mov r3, #0
	sub r1, #0x20
_02160B94:
	sub r0, r6, r2
	cmp r0, #0x2d
	bhs _02160BA2
	cmp r1, #0x20
	bhs _02160BA2
	mov r5, r3
	b _02160BAE
_02160BA2:
	add r2, #0x2d
	lsl r0, r2, #0x10
	add r3, r3, #1
	lsr r2, r0, #0x10
	cmp r3, #5
	blt _02160B94
_02160BAE:
	cmp r5, r4
	bne _02160BB4
	mov r5, #6
_02160BB4:
	mov r0, r5
	pop {r4, r5, r6, pc}
	.align 2, 0
_02160BB8: .word _02161A28
_02160BBC: .word padInput
_02160BC0: .word touchInput
	thumb_func_end NameMenu__CheckPageChange

	thumb_func_start NameMenu__GetCursorPositionFromTouch
NameMenu__GetCursorPositionFromTouch: // 0x02160BC4
	push {r3, r4, r5, lr}
	mov r5, r1
	mov r4, r2
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02160BE0
	ldr r0, _02160C38 // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #4
	tst r0, r1
	beq _02160BE0
	mov r0, #1
	b _02160BE2
_02160BE0:
	mov r0, #0
_02160BE2:
	cmp r0, #0
	bne _02160BEA
	mov r0, #0
	pop {r3, r4, r5, pc}
_02160BEA:
	ldr r0, _02160C38 // =touchInput
	ldrh r2, [r0, #0x1c]
	ldrh r0, [r0, #0x1e]
	cmp r0, #0x48
	bhs _02160BF8
	mov r0, #0
	pop {r3, r4, r5, pc}
_02160BF8:
	sub r0, #0x48
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	cmp r1, #0x50
	blo _02160C06
	mov r0, #0
	pop {r3, r4, r5, pc}
_02160C06:
	cmp r2, #0x20
	bhs _02160C1E
	cmp r2, #0x10
	blo _02160C1A
	mov r0, #0
	strh r0, [r5]
	lsr r0, r1, #4
	strh r0, [r4]
	mov r0, #1
	pop {r3, r4, r5, pc}
_02160C1A:
	mov r0, #0
	pop {r3, r4, r5, pc}
_02160C1E:
	sub r2, #0x20
	lsl r0, r2, #0x10
	lsr r0, r0, #0x10
	cmp r0, #0xc0
	blo _02160C2C
	mov r0, #0
	pop {r3, r4, r5, pc}
_02160C2C:
	lsr r0, r0, #4
	strh r0, [r5]
	lsr r0, r1, #4
	strh r0, [r4]
	mov r0, #1
	pop {r3, r4, r5, pc}
	.align 2, 0
_02160C38: .word touchInput
	thumb_func_end NameMenu__GetCursorPositionFromTouch

	thumb_func_start NameMenu__GetMenuSelectionFromTouch
NameMenu__GetMenuSelectionFromTouch: // 0x02160C3C
	push {r3, r4, r5, lr}
	mov r4, r0
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02160C56
	ldr r0, _02160C94 // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #4
	tst r0, r1
	beq _02160C56
	mov r0, #1
	b _02160C58
_02160C56:
	mov r0, #0
_02160C58:
	cmp r0, #0
	bne _02160C60
	mov r0, #4
	pop {r3, r4, r5, pc}
_02160C60:
	ldr r1, _02160C94 // =touchInput
	mov r2, #0x14
	ldrh r3, [r1, #0x1c]
	ldrh r1, [r1, #0x1e]
	mov r0, #0
	sub r1, #0xa4
_02160C6C:
	ldr r5, [r4, #0x3c]
	cmp r5, #2
	beq _02160C80
	lsl r5, r2, #0x10
	lsr r5, r5, #0x10
	sub r5, r3, r5
	cmp r5, #0x44
	bhs _02160C80
	cmp r1, #0x14
	blo _02160C90
_02160C80:
	add r2, #0x48
	lsl r2, r2, #0x10
	add r0, r0, #1
	lsr r2, r2, #0x10
	add r4, r4, #4
	cmp r0, #3
	blt _02160C6C
	mov r0, #4
_02160C90:
	pop {r3, r4, r5, pc}
	nop
_02160C94: .word touchInput
	thumb_func_end NameMenu__GetMenuSelectionFromTouch

	thumb_func_start NameMenu__SetupBlending
NameMenu__SetupBlending: // 0x02160C98
	push {r3, r4}
	ldr r0, _02160CF0 // =VRAMSystem__GFXControl
	ldr r2, [r0, #4]
	add r2, #0x20
	cmp r1, #0x10
	blo _02160CAE
	mov r0, #0
	strh r0, [r2]
	strh r0, [r2, #2]
	pop {r3, r4}
	bx lr
_02160CAE:
	mov r0, #0
	strh r0, [r2]
	ldrh r4, [r2, #0]
	mov r3, #1
	lsl r3, r3, #0xa
	orr r4, r3
	strh r4, [r2]
	ldrh r4, [r2, #0]
	lsl r3, r3, #1
	orr r3, r4
	strh r3, [r2]
	strh r0, [r2, #2]
	ldrh r3, [r2, #2]
	mov r0, #0x1f
	bic r3, r0
	mov r0, #0x1f
	and r0, r1
	orr r0, r3
	strh r0, [r2, #2]
	ldrh r3, [r2, #2]
	ldr r0, _02160CF4 // =0xFFFFE0FF
	and r0, r3
	mov r3, #0x10
	sub r1, r3, r1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	lsl r1, r1, #0x1b
	lsr r1, r1, #0x13
	orr r0, r1
	strh r0, [r2, #2]
	pop {r3, r4}
	bx lr
	nop
_02160CF0: .word VRAMSystem__GFXControl
_02160CF4: .word 0xFFFFE0FF
	thumb_func_end NameMenu__SetupBlending

	thumb_func_start NameMenu__GetCharacter_JPN_Hiragana
NameMenu__GetCharacter_JPN_Hiragana: // 0x02160CF8
	mov r3, r1
	mov r2, #0x18
	mul r3, r2
	ldr r2, _02160D08 // =_02161B24
	lsl r1, r0, #1
	add r0, r2, r3
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02160D08: .word _02161B24
	thumb_func_end NameMenu__GetCharacter_JPN_Hiragana

	thumb_func_start NameMenu__GetCharacter_JPN_Katakana
NameMenu__GetCharacter_JPN_Katakana: // 0x02160D0C
	mov r3, r1
	mov r2, #0x18
	mul r3, r2
	ldr r2, _02160D1C // =_02161B9C
	lsl r1, r0, #1
	add r0, r2, r3
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02160D1C: .word _02161B9C
	thumb_func_end NameMenu__GetCharacter_JPN_Katakana

	thumb_func_start NameMenu__GetCharacter_ENG_Lower
NameMenu__GetCharacter_ENG_Lower: // 0x02160D20
	mov r3, r1
	mov r2, #0x18
	mul r3, r2
	ldr r2, _02160D30 // =_02161C14
	lsl r1, r0, #1
	add r0, r2, r3
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02160D30: .word _02161C14
	thumb_func_end NameMenu__GetCharacter_ENG_Lower

	thumb_func_start NameMenu__GetCharacter_ENG_Upper
NameMenu__GetCharacter_ENG_Upper: // 0x02160D34
	mov r3, r1
	mov r2, #0x18
	mul r3, r2
	ldr r2, _02160D44 // =_02161C8C
	lsl r1, r0, #1
	add r0, r2, r3
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02160D44: .word _02161C8C
	thumb_func_end NameMenu__GetCharacter_ENG_Upper

	thumb_func_start NameMenu__GetCharacter_Latin
NameMenu__GetCharacter_Latin: // 0x02160D48
	mov r3, r1
	mov r2, #0x18
	mul r3, r2
	ldr r2, _02160D58 // =_02161D04
	lsl r1, r0, #1
	add r0, r2, r3
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02160D58: .word _02161D04
	thumb_func_end NameMenu__GetCharacter_Latin

	thumb_func_start NameMenu__GetCharacter_Symbols
NameMenu__GetCharacter_Symbols: // 0x02160D5C
	mov r3, r1
	mov r2, #0x18
	mul r3, r2
	ldr r2, _02160D6C // =_02161D7C
	lsl r1, r0, #1
	add r0, r2, r3
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02160D6C: .word _02161D7C
	thumb_func_end NameMenu__GetCharacter_Symbols

	thumb_func_start NameMenu__GetCharacter_Icons
NameMenu__GetCharacter_Icons: // 0x02160D70
	mov r3, r1
	mov r2, #0x18
	mul r3, r2
	ldr r2, _02160D80 // =_02161DF4
	lsl r1, r0, #1
	add r0, r2, r3
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02160D80: .word _02161DF4
	thumb_func_end NameMenu__GetCharacter_Icons

	thumb_func_start NameMenu__GetCharacterFromIndex
NameMenu__GetCharacterFromIndex: // 0x02160D84
	push {r3, r4, r5, r6}
	ldr r5, _02160DD0 // =_02161E6C
	mov r1, #0
	mov r2, #0x38
	mov r3, #1
_02160D8E:
	add r4, r1, r2
	asr r6, r4, #1
	and r4, r3
	add r6, r6, r4
	lsl r4, r6, #2
	ldr r4, [r5, r4]
	cmp r4, r0
	bgt _02160DA2
	mov r1, r6
	b _02160DA4
_02160DA2:
	sub r2, r6, #1
_02160DA4:
	cmp r1, r2
	blt _02160D8E
	ldr r2, _02160DD0 // =_02161E6C
	lsl r3, r1, #2
	ldr r2, [r2, r3]
	sub r2, r0, r2
	ldr r0, _02160DD4 // =_02161F50
	ldr r0, [r0, r3]
	cmp r2, r0
	blt _02160DBE
	mov r0, #0x20
	pop {r3, r4, r5, r6}
	bx lr
_02160DBE:
	ldr r0, _02160DD8 // =_02161AB2
	lsl r1, r1, #1
	ldrh r0, [r0, r1]
	add r0, r2, r0
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	pop {r3, r4, r5, r6}
	bx lr
	nop
_02160DD0: .word _02161E6C
_02160DD4: .word _02161F50
_02160DD8: .word _02161AB2
	thumb_func_end NameMenu__GetCharacterFromIndex

	thumb_func_start NameMenu__Func_2160DDC
NameMenu__Func_2160DDC: // 0x02160DDC
	mov r1, #0x62
	lsl r1, r1, #2
	cmp r0, r1
	blo _02160DE8
	ldr r0, _02160DF0 // =0x0000FFFF
	bx lr
_02160DE8:
	lsl r1, r0, #1
	ldr r0, _02160DF4 // =_02162034
	ldrh r0, [r0, r1]
	bx lr
	.align 2, 0
_02160DF0: .word 0x0000FFFF
_02160DF4: .word _02162034
	thumb_func_end NameMenu__Func_2160DDC

	thumb_func_start NameMenu__Func_2160DF8
NameMenu__Func_2160DF8: // 0x02160DF8
	mov r1, #0x62
	lsl r1, r1, #2
	cmp r0, r1
	blo _02160E04
	ldr r0, _02160E0C // =0x0000FFFF
	bx lr
_02160E04:
	lsl r1, r0, #1
	ldr r0, _02160E10 // =_02162344
	ldrh r0, [r0, r1]
	bx lr
	.align 2, 0
_02160E0C: .word 0x0000FFFF
_02160E10: .word _02162344
	thumb_func_end NameMenu__Func_2160DF8

	thumb_func_start NameMenu__Func_2160E14
NameMenu__Func_2160E14: // 0x02160E14
	mov r1, #0x62
	lsl r1, r1, #2
	cmp r0, r1
	blo _02160E20
	ldr r0, _02160E28 // =0x0000FFFF
	bx lr
_02160E20:
	lsl r1, r0, #1
	ldr r0, _02160E2C // =_02162654
	ldrh r0, [r0, r1]
	bx lr
	.align 2, 0
_02160E28: .word 0x0000FFFF
_02160E2C: .word _02162654
	thumb_func_end NameMenu__Func_2160E14

	thumb_func_start NameMenu__GetNameLength
NameMenu__GetNameLength: // 0x02160E30
	push {r3, r4}
	sub r4, r1, #1
	mov r3, r4
	cmp r4, #0
	blt _02160E4A
	lsl r2, r4, #1
	add r2, r0, r2
_02160E3E:
	ldrh r0, [r2, #0]
	cmp r0, #0
	bne _02160E4A
	sub r2, r2, #2
	sub r3, r3, #1
	bpl _02160E3E
_02160E4A:
	sub r0, r4, r3
	sub r0, r1, r0
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	pop {r3, r4}
	bx lr
	.align 2, 0
	thumb_func_end NameMenu__GetNameLength

	.rodata

_021619E4: // 0x021619E4
    .word 0, 2, 4, 5, 6
	
_021619F8: // 0x021619F8
	.hword 0x27, 0x2C
	.hword 0x55, 0x2D
	.hword 0x82, 0x2B
	.hword 0xAF, 0x2E
	.hword 0xDB, 0x2B
	
_02161A0C: // 0x02161A0C
    .word NameMenu__DrawPageVariants_JPN, NameMenu__DrawPageVariants_JPN
	.word NameMenu__DrawPageVariants_ENG, NameMenu__DrawPageVariants_ENG
	.word 0, 0, 0

_02161A28: // 0x02161A28
    .word 0, 0, 1, 1, 2, 3, 4
	
_02161A44: // 0x02161A44
    .word NameMenu__ChangePageVariant_JPN_Hiragana, NameMenu__ChangePageVariant_JPN_Katakana
	.word NameMenu__ChangePageVariant_ENG_Lower, NameMenu__ChangePageVariant_ENG_Upper
	.word 0, 0, 0

_02161A60: // 0x02161A60
    .word NameMenu__GetCharacter_JPN_Hiragana, NameMenu__GetCharacter_JPN_Katakana
	.word NameMenu__GetCharacter_ENG_Lower, NameMenu__GetCharacter_ENG_Upper
	.word NameMenu__GetCharacter_Latin, NameMenu__GetCharacter_Symbols
	.word NameMenu__GetCharacter_Icons

_02161A7C: // 0x02161A7C
    .hword 0, 0, 0, 0
	
_02161A84: // 0x02161A84
    .hword 0, 0, 0, 1, 1, 1, 1, 1
	
_02161A9E: // 0x02161A9E
	.hword 2, 2, 2, 2, 2
	
_02161A94: // 0x02161A94
	.hword 2, 2, 2, 2, 2, 3
	
_02161AAA: // 0x02161AAA
	.hword 4, 5, 6, 2
	
_02161AB2: // 0x02161AB2
	.hword 0x20, 0x7D, 0xA1, 0xA9, 0xAE, 0xB0, 0xBF, 0xC4, 0xC7
	.hword 0xD1, 0xD6, 0xD9, 0xDF, 0xE4, 0xE7, 0xF1, 0xF6, 0xF9
	.hword 0x152, 0x2C6, 0x2DC, 0x201C, 0x2022, 0x2026, 0x2033
	.hword 0x203B, 0x20AC, 0x2122, 0x2190, 0x221E, 0x2234, 0x25A0
	.hword 0x25B2, 0x25BC, 0x25C6, 0x25CB, 0x25CE, 0x2605, 0x266A
	.hword 0x266D, 0x3000, 0x300C, 0x3012, 0x3041, 0x3092, 0x30A1
	.hword 0x30F2, 0x30FC, 0xE000, 0xE015, 0xE028, 0xFF01, 0xFF0F
	.hword 0xFF1F, 0xFF3C, 0xFF3E, 0xFF5B

_02161B24: // 0x02161B24
    .word 0xBDFFFE, 0xD000C6, 0xE500DA, 0xF900EA, 0x10400FF
	.word 0x161010A, 0xBFFFFD, 0xD200C8, 0xE600DC, 0xFA00ED
	.word 0x1050101, 0x10B, 0xC1FFFC, 0xD400CA, 0xE700DF, 0xFB00F0
	.word 0x1060103, 0x10C, 0xC3FFFB, 0xD600CC, 0xE800E1, 0xFC00F3
	.word 0x107017F, 0xB7, 0xC5FFFA, 0xD800CE, 0xE900E3, 0xFD00F6
	.word 0x1080181, 0xB8

_02161B9C: // 0x02161B9C
    .word 0x10EFFFE, 0x1210117, 0x136012B, 0x14A013B, 0x1550150
	.word 0x161015B, 0x110FFFD, 0x1230119, 0x137012D, 0x14B013E
	.word 0x1560152, 0x15C, 0x112FFFC, 0x125011B, 0x1380130
	.word 0x14C0141, 0x1570154, 0x15D, 0x114FFFB, 0x127011D
	.word 0x1390132, 0x14D0144, 0x158017F, 0xB7, 0x116FFFA, 0x129011F
	.word 0x13A0134, 0x14E0147, 0x1590181, 0xB8

_02161C14: // 0x02161C14
    .word 0x11FFF9, 0x130012, 0x150014, 0x170016, 0x190018, 0x10
	.word 0x41FFF8, 0x430042, 0x450044, 0x470046, 0x490048, 0x4B004A
	.word 0x4CFFFF, 0x4E004D, 0x50004F, 0x520051, 0x540053, 0x560055
	.word 0x57FFFF, 0x590058, 0xC005A, 0xF000E, 0x40001A, 0x3D003B
	.word 0xDFFFF, 0x1D, 0, 0, 0, 0

_02161C8C: // 0x02161C8C
    .word 0x1FFF9, 0x30020, 0x50004, 0x6003E, 0x8000A, 9, 0x21FFF8
	.word 0x230022, 0x250024, 0x270026, 0x290028, 0x2B002A, 0x2CFFFF
	.word 0x2E002D, 0x30002F, 0x320031, 0x340033, 0x360035, 0x37FFFF
	.word 0x390038, 0x1C003A, 0x1F001E, 0x5D001B, 0x5C005B, 0x3FFFFF
	.word 0xB, 0, 0, 0, 0

_02161D04: // 0x02161D04
    .word 0x7EFFFF, 0x80007F, 0x830081, 0x850084, 0x870086, 0x890088
	.word 0x8AFFFF, 0x8D008C, 0x8F008E, 0x910096, 0x930092, 0x820094
	.word 0x8BFFFF, 0x66007D, 0x680067, 0x6B0069, 0x6D006C, 0x6F006E
	.word 0x70FFFF, 0x720071, 0x750074, 0x770076, 0x790095, 0x7B007A
	.word 0x7CFFFF, 0x73006A, 0x65005E, 0x5F009F, 0x60, 0

_02161D7C: // 0x02161D7C
    .word 0x1FFFF, 0x6001F, 0x70002, 0x1A0187, 0x20001B, 0x3F005D
	.word 0xBFFFF, 0xA000D, 0x78000F, 0x1D0090, 0xA200A1, 0xA400A3
	.word 0xB9FFFF, 0x9900BA, 0x8009A, 0x1C0009, 0x5B001E, 0x9B005C
	.word 0x5FFFF, 0xBB009E, 0xB50003, 0x6400B4, 0x9F0004, 0x3C0060
	.word 0x183FFFF, 0x1850063, 0x1820180, 0xA600A5, 0xA0009C
	.word 0x620061

_02161DF4: // 0x02161DF4
    .word 0x16AFFFF, 0x16C016B, 0x16E016D, 0x170016F, 0x1740171
	.word 0x1690175, 0x162FFFF, 0x1640163, 0x1660165, 0x1680167
	.word 0x1770176, 0x1790178, 0x172FFFF, 0xB0173, 0xB3000D
	.word 0xAE00AF, 0xAA00A8, 0xB000AC, 0x17AFFFF, 0x17C017B
	.word 0xB2017D, 0xAD00B1, 0xA900A7, 0x17E00AB, 0xFFFF, 0
	.word 0, 0

_02161E64: // 0x02161E64
    .word 0, 0
	
_02161E6C: // 0x02161E6C
    .word 0
	.word 0x5C, 0x5E, 0x61, 0x62, 0x63, 0x65, 0x69, 0x6A, 0x73
	.word 0x77, 0x79, 0x7D, 0x81, 0x82, 0x8B, 0x8F, 0x91, 0x95
	.word 0x97, 0x98, 0x99, 0x9B, 0x9C, 0x9D, 0x9E, 0x9F, 0xA0
	.word 0xA1, 0xA5, 0xA6, 0xA7, 0xA9, 0xAB, 0xAD, 0xAF, 0xB0
	.word 0xB2, 0xB4, 0xB5, 0xB6, 0xB9, 0xBB, 0xBC, 0x10B, 0x10D
	.word 0x15C, 0x161, 0x162, 0x176, 0x17E, 0x17F, 0x180, 0x181
	.word 0x182, 0x183, 0x184

_02161F50: // 0x02161F50
    .word 0x5C, 2, 3, 1, 1, 2, 4, 1, 9, 4, 2, 4, 4, 1, 9, 4
	.word 2, 4, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 4, 1, 1, 2, 2
	.word 2, 2, 1, 2, 2, 1, 1, 3, 2, 1, 0x4F, 2, 0x4F, 5, 1
	.word 0x14, 8, 1, 1, 1, 1, 1, 1, 4
	
_02162034: // 0x02162034
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	
_0216219C: // 0x0216219C
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xC7, 0xC6, 0xC9, 0xC8
	.hword 0xCB, 0xCA, 0xCD, 0xCC, 0xCF, 0xCE, 0xD1, 0xD0, 0xD3
	.hword 0xD2, 0xD5, 0xD4, 0xD7, 0xD6, 0xD9, 0xD8, 0xDB, 0xDA
	.hword 0xDD, 0xDC, 0xE0, 0xE0, 0xDF, 0xE2, 0xE1, 0xE4, 0xE3
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xEB, 0xEA
	.hword 0xEB, 0xEE, 0xED, 0xEE, 0xF1, 0xF0, 0xF1, 0xF4, 0xF3
	.hword 0xF4, 0xF7, 0xF6, 0xF7, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0x15E
	.hword 0x15E, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0x118, 0x117
	.hword 0x11A, 0x119, 0x11C, 0x11B, 0x11E, 0x11D, 0x120, 0x11F
	.hword 0x122, 0x121, 0x124, 0x123, 0x126, 0x125, 0x128, 0x127
	.hword 0x12A, 0x129, 0x12C, 0x12B, 0x12E, 0x12D, 0x131, 0x131
	.hword 0x130, 0x133, 0x132, 0x135, 0x134, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0x13C, 0x13B, 0x13C, 0x13F
	.hword 0x13E, 0x13F, 0x142, 0x141, 0x142, 0x145, 0x144, 0x145
	.hword 0x148, 0x147, 0x148, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0x112, 0x118, 0x11E, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	
_02162344: // 0x02162344
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xEC, 0xEC, 0xEA, 0xEF, 0xEF
	.hword 0xED, 0xF2, 0xF2, 0xF0, 0xF5, 0xF5, 0xF3, 0xF8, 0xF8
	.hword 0xF6, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0x13D, 0x13D, 0x13B
	.hword 0x140, 0x140, 0x13E, 0x143, 0x143, 0x141, 0x146, 0x146
	.hword 0x144, 0x149, 0x149, 0x147, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF
	
_02162654: // 0x02162654
    .hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0x41, 0x42
	.hword 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B
	.hword 0x4C, 0x4D, 0x4E, 0x4F, 0x50, 0x51, 0x52, 0x53, 0x54
	.hword 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0x21, 0x22, 0x23, 0x24
	.hword 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D
	.hword 0x2E, 0x2F, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36
	.hword 0x37, 0x38, 0x39, 0x3A, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xBD, 0xBC, 0xBF, 0xBE, 0xC1, 0xC0
	.hword 0xC3, 0xC2, 0xC5, 0xC4, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xDF
	.hword 0xDE, 0xDE, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFF, 0xFE, 0x101, 0x100, 0x103
	.hword 0x102, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0x10A
	.hword 0x109, 0xFFFF, 0xFFFF, 0x10E, 0x10D, 0x110, 0x10F
	.hword 0x112, 0x111, 0x114, 0x113, 0x116, 0x115, 0x15F, 0x15F
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0x160, 0x160, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0x130, 0x12F, 0x12F, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0x150, 0x14F
	.hword 0x152, 0x151, 0x154, 0x153, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0x15B, 0x15A, 0xFFFF, 0xFFFF, 0x111
	.hword 0x117, 0x11D, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF

	.data

_02162E14:
	.word aNarcDmniLz7Nar_ovl04_0

aNarcDmniLz7Nar_ovl04_0: // 0x02162E18
	.asciz "narc/dmni_lz7.narc"
	.align 4