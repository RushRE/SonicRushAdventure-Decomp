	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start VikingCupMenu__LoadAssets
VikingCupMenu__LoadAssets: // 0x0217A9E0
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	ldr r2, _0217AA18 // =0x0000FFFF
	str r1, [r4]
	ldr r0, _0217AA1C // =aNarcDmMenuSaLz
	strh r2, [r4, #4]
	bl ArchiveFileUnknown__LoadFile
	str r0, [r4, #8]
	ldr r0, _0217AA20 // =aFntFontIplFnt_3
	mov r1, #0
	bl FSRequestFileSync
	str r0, [r4, #0xc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217AA18: .word 0x0000FFFF
_0217AA1C: .word aNarcDmMenuSaLz
_0217AA20: .word aFntFontIplFnt_3
	arm_func_end VikingCupMenu__LoadAssets

	arm_func_start VikingCupMenu__ReleaseAssets
VikingCupMenu__ReleaseAssets: // 0x0217AA24
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _0217AA44
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0xc]
_0217AA44:
	ldr r0, [r4, #8]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #8]
	ldmia sp!, {r4, pc}
	arm_func_end VikingCupMenu__ReleaseAssets

	arm_func_start VikingCupStageSelectMenu__Create
VikingCupStageSelectMenu__Create: // 0x0217AA60
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r1, #0x10
	mov r2, #0
	str r1, [sp]
	ldr r4, _0217ABDC // =0x00000838
	mov r5, r0
	ldr r0, _0217ABE0 // =VikingCupStageSelectMenu__Main
	ldr r1, _0217ABE4 // =VikingCupStageSelectMenu__Destructor
	stmib sp, {r2, r4}
	mov r3, r2
	bl TaskCreate_
	str r0, [r5]
	bl GetTaskWork_
	mov r6, r0
	str r5, [r6]
	ldr r0, _0217ABE8 // =0x0000FFFF
	mov r7, #0
	strh r0, [r6, #8]
	strh r0, [r6, #0xa]
	add r0, r6, #0x24
	strh r7, [r6, #0xc]
	add r8, r6, #0x800
	strh r7, [r8, #0x20]
	strh r7, [r8, #0x22]
	strh r7, [r8, #0x26]
	ldr r5, _0217ABEC // =0x0213461C
	strh r7, [r8, #0x24]
	add r4, r0, #0x800
_0217AAD4:
	mov r0, r5
	and r1, r7, #0xff
	bl SaveGame__HasChaosEmerald
	cmp r0, #0
	beq _0217AB04
	ldrh r0, [r8, #0x24]
	add r0, r6, r0, lsl #1
	add r0, r0, #0x800
	strh r7, [r0, #0x28]
	ldrh r0, [r4, #0]
	add r0, r0, #1
	strh r0, [r4]
_0217AB04:
	add r7, r7, #1
	cmp r7, #7
	blt _0217AAD4
	mov r0, r6
	bl VikingCupStageSelectMenu__Func_217AC10
	mov r4, #0
	strh r4, [r6, #0xe]
_0217AB20:
	mov r0, r4
	bl VikingCupStageSelectMenu__CheckShipUnlocked
	cmp r0, #0
	beq _0217AB48
	ldrh r0, [r6, #0xe]
	add r4, r4, #1
	cmp r4, #4
	add r0, r0, #1
	strh r0, [r6, #0xe]
	blt _0217AB20
_0217AB48:
	bl VikingCupStageSelectMenu__Func_217C8B0
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	cmp r1, #8
	blo _0217ABB8
	add r0, r6, #0x800
	ldrh r3, [r0, #0x24]
	mov r4, #0
	cmp r3, #0
	ble _0217ABAC
	sub r2, r1, #8
_0217AB74:
	add r0, r6, r4, lsl #1
	add r0, r0, #0x800
	ldrh r0, [r0, #0x28]
	cmp r2, r0
	bne _0217ABA0
	add r2, r4, #1
	add r0, r6, #0x800
	strh r2, [r0, #0x20]
	mov r2, #1
	strh r2, [r0, #0x26]
	b _0217ABAC
_0217ABA0:
	add r4, r4, #1
	cmp r4, r3
	blt _0217AB74
_0217ABAC:
	add r0, r6, #0x800
	ldrh r2, [r0, #0x20]
	strh r2, [r0, #0x22]
_0217ABB8:
	mov r0, r6
	bl VikingCupStageSelectMenu__Func_217B7F0
	mov r1, #0
	ldr r0, _0217ABF0 // =VikingCupStageSelectMenu__State_217B230
	str r1, [r6, #4]
	str r0, [r6, #0x81c]
	bl ResetTouchInput
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0217ABDC: .word 0x00000838
_0217ABE0: .word VikingCupStageSelectMenu__Main
_0217ABE4: .word VikingCupStageSelectMenu__Destructor
_0217ABE8: .word 0x0000FFFF
_0217ABEC: .word 0x0213461C
_0217ABF0: .word VikingCupStageSelectMenu__State_217B230
	arm_func_end VikingCupStageSelectMenu__Create

	arm_func_start VikingCupStageSelectMenu__OptionsFinished
VikingCupStageSelectMenu__OptionsFinished: // 0x0217ABF4
	ldr r0, [r0, #0]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end VikingCupStageSelectMenu__OptionsFinished

	arm_func_start VikingCupStageSelectMenu__Func_217AC08
VikingCupStageSelectMenu__Func_217AC08: // 0x0217AC08
	ldrh r0, [r0, #4]
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217AC08

	arm_func_start VikingCupStageSelectMenu__Func_217AC10
VikingCupStageSelectMenu__Func_217AC10: // 0x0217AC10
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl VikingCupStageSelectMenu__SetupDisplay
	mov r0, r4
	bl VikingCupStageSelectMenu__Func_217AE50
	mov r0, r4
	bl VikingCupStageSelectMenu__Func_217AF78
	mov r0, r4
	bl VikingCupStageSelectMenu__Func_217B048
	mov r0, r4
	bl VikingCupStageSelectMenu__Func_217C394
	ldmia sp!, {r4, pc}
	arm_func_end VikingCupStageSelectMenu__Func_217AC10

	arm_func_start VikingCupStageSelectMenu__SetupDisplay
VikingCupStageSelectMenu__SetupDisplay: // 0x0217AC40
	stmdb sp!, {r3, lr}
	mov r1, #0
	ldr r3, _0217AE10 // =renderCurrentDisplay
	mov r0, #1
	mov r2, r1
	str r0, [r3]
	bl GX_SetGraphicsMode
	ldr lr, _0217AE14 // =0x0400000A
	ldr r0, _0217AE18 // =0x0000090C
	ldrh r2, [lr]
	sub r3, r0, #0x104
	ldr r1, _0217AE1C // =0x06004000
	and r0, r2, #0x43
	orr r0, r0, #0x10c
	orr r0, r0, #0x800
	strh r0, [lr]
	ldrh ip, [lr, #2]
	mov r0, #0
	mov r2, #0x800
	and ip, ip, #0x43
	orr r3, ip, r3
	strh r3, [lr, #2]
	bl MIi_CpuClearFast
	ldr r1, _0217AE20 // =0x06004800
	mov r0, #0
	mov r2, #0x800
	bl MIi_CpuClearFast
	ldr r1, _0217AE24 // =0x06008000
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldr r1, _0217AE28 // =0x0600C000
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	mov r0, #0
	ldr r1, _0217AE2C // =renderCoreGFXControlA
	mov r2, #0xc
	bl MIi_CpuClear16
	ldr r2, _0217AE30 // =0x04000008
	mov r0, #0
	ldrh r1, [r2, #0]
	bic r1, r1, #3
	strh r1, [r2]
	ldrh r1, [r2, #2]
	bic r1, r1, #3
	orr r1, r1, #1
	strh r1, [r2, #2]
	ldrh r1, [r2, #4]
	bic r1, r1, #3
	orr r1, r1, #2
	strh r1, [r2, #4]
	ldrh r1, [r2, #6]
	bic r1, r1, #3
	orr r1, r1, #3
	strh r1, [r2, #6]
	bl GXS_SetGraphicsMode
	ldr r2, _0217AE34 // =0x0400100A
	arm_func_end VikingCupStageSelectMenu__SetupDisplay
_0217AD28:
	.byte 0xE8, 0x00, 0x9F, 0xE5

	arm_func_start VikingCupStageSelectMenu__Func_217AD2C
VikingCupStageSelectMenu__Func_217AD2C: // 0x0217AD2C
	ldrh r1, [r2, #0]
	sub r0, r0, #0x104
	and r1, r1, #0x43
	orr r1, r1, #0x10c
	orr r1, r1, #0x800
	strh r1, [r2]
	ldrh r1, [r2, #2]
	and r1, r1, #0x43
	orr r0, r1, r0
	strh r0, [r2, #2]
	ldr r1, _0217AE38 // =0x06204000
	mov r0, #0
	mov r2, #0x800
	bl MIi_CpuClearFast
	ldr r1, _0217AE3C // =0x06204800
	mov r0, #0
	mov r2, #0x800
	bl MIi_CpuClearFast
	ldr r1, _0217AE40 // =0x06208000
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldr r1, _0217AE44 // =0x0620C000
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldr r1, _0217AE48 // =renderCoreGFXControlB
	mov r0, #0
	mov r2, #0xc
	bl MIi_CpuClear16
	ldr r3, _0217AE4C // =0x04001008
	mov r2, #0x4000000
	ldrh r0, [r3, #0]
	add r1, r2, #0x1000
	bic r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r3, #2]
	bic r0, r0, #3
	orr r0, r0, #1
	strh r0, [r3, #2]
	ldrh r0, [r3, #4]
	bic r0, r0, #3
	orr r0, r0, #2
	strh r0, [r3, #4]
	ldrh r0, [r3, #6]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3, #6]
	ldr r0, [r2, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1e00
	str r0, [r2]
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1e00
	str r0, [r1]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0217AE10: .word renderCurrentDisplay
_0217AE14: .word 0x0400000A
_0217AE18: .word 0x0000090C
_0217AE1C: .word 0x06004000
_0217AE20: .word 0x06004800
_0217AE24: .word 0x06008000
_0217AE28: .word 0x0600C000
_0217AE2C: .word renderCoreGFXControlA
_0217AE30: .word 0x04000008
_0217AE34: .word 0x0400100A
_0217AE38: .word 0x06204000
_0217AE3C: .word 0x06204800
_0217AE40: .word 0x06208000
_0217AE44: .word 0x0620C000
_0217AE48: .word renderCoreGFXControlB
_0217AE4C: .word 0x04001008
	arm_func_end VikingCupStageSelectMenu__Func_217AD2C

	arm_func_start VikingCupStageSelectMenu__Func_217AE50
VikingCupStageSelectMenu__Func_217AE50: // 0x0217AE50
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	mov r4, r0
	ldr r0, [r4, #0]
	mov r1, #0
	ldr r0, [r0, #8]
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x1c]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0217AEA8
_0217AE84: // jump table
	b _0217AE9C // case 0
	b _0217AE9C // case 1
	b _0217AE9C // case 2
	b _0217AE9C // case 3
	b _0217AE9C // case 4
	b _0217AE9C // case 5
_0217AE9C:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _0217AEAC
_0217AEA8:
	mov r0, #1
_0217AEAC:
	ldr r2, [r4, #0]
	add r0, r0, #1
	mov r1, r0, lsl #0x10
	ldr r0, [r2, #8]
	arm_func_end VikingCupStageSelectMenu__Func_217AE50

	arm_func_start VikingCupStageSelectMenu__Func_217AEBC
VikingCupStageSelectMenu__Func_217AEBC: // 0x0217AEBC
	mov r1, r1, lsr #0x10
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x20]
	ldr r0, _0217AF70 // =0x05000600
	ldr r10, _0217AF74 // =0x0217E340
	mov r8, #0
	add r9, r4, #0x1c
	sub r5, r0, #0x400
	add r11, sp, #0x1c
	mov r4, r8
_0217AEE4:
	ldrb r0, [r10, #0]
	cmp r8, #2
	ldrb r1, [r10, #1]
	movlt r6, #0
	movlt r7, r5
	ldr r0, [r11, r0, lsl #2]
	movge r6, #1
	ldrge r7, _0217AF70 // =0x05000600
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, r6
	bl VRAMSystem__AllocSpriteVram
	str r6, [sp]
	str r4, [sp, #4]
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r7, [sp, #0x10]
	mov r0, #2
	str r0, [sp, #0x14]
	str r4, [sp, #0x18]
	ldrb r1, [r10, #0]
	ldrb r2, [r10, #1]
	mov r0, r9
	ldr r1, [r11, r1, lsl #2]
	mov r3, r4
	bl AnimatorSprite__Init
	ldrb r0, [r10, #2]
	add r8, r8, #1
	add r10, r10, #4
	strh r0, [r9, #0x50]
	cmp r8, #0xc
	add r9, r9, #0x64
	blt _0217AEE4
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0217AF70: .word 0x05000600
_0217AF74: .word 0x0217E340
	arm_func_end VikingCupStageSelectMenu__Func_217AEBC

	arm_func_start VikingCupStageSelectMenu__Func_217AF78
VikingCupStageSelectMenu__Func_217AF78: // 0x0217AF78
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x54
	mov r4, r0
	ldr r0, [r4, #0]
	mov r1, #7
	ldr r0, [r0, #8]
	bl FileUnknown__GetAOUFile
	mov r3, #2
	mov r1, r0
	mov r2, #0
	str r3, [sp]
	mov ip, #0x20
	str ip, [sp, #4]
	mov ip, #0x18
	add r0, sp, #0xc
	mov r3, r2
	str ip, [sp, #8]
	bl InitBackground
	add r0, sp, #0xc
	bl DrawBackground
	ldr r0, [r4, #0]
	mov r1, #8
	ldr r0, [r0, #8]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	mov r0, #2
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0xc
	mov r2, #0
	mov r3, #1
	bl InitBackground
	add r0, sp, #0xc
	bl DrawBackground
	ldr r0, [r4, #0]
	mov r1, #9
	ldr r0, [r0, #8]
	bl FileUnknown__GetAOUFile
	add r2, r4, #0x26c
	mov r1, r0
	add r0, r2, #0x400
	mov r2, #0
	str r2, [sp]
	mov r3, #0x5000000
	str r3, [sp, #4]
	mov r3, r2
	bl InitPaletteAnimator
	add sp, sp, #0x54
	ldmia sp!, {r3, r4, pc}
	arm_func_end VikingCupStageSelectMenu__Func_217AF78

	arm_func_start VikingCupStageSelectMenu__Func_217B048
VikingCupStageSelectMenu__Func_217B048: // 0x0217B048
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r10, r0
	add r0, r10, #0x28c
	add r0, r0, #0x400
	bl FontFile__Init
	ldr r1, [r10, #0]
	add r0, r10, #0x28c
	ldr r1, [r1, #0xc]
	add r0, r0, #0x400
	bl FontFile__InitFromHeader
	add r0, r10, #0x318
	add r9, r0, #0x400
	mov r7, #0x20
	mov r8, #0xd
	mov r6, #0
	mov r5, #8
	mov r4, #0x10
	mov r11, #2
_0217B094:
	mov r0, #0x400
	bl _AllocHeadHEAP_USER
	add r1, r10, r6, lsl #2
	str r0, [r1, #0x808]
	stmia sp, {r5, r8}
	str r4, [sp, #8]
	str r11, [sp, #0xc]
	ldr r1, [r1, #0x808]
	mov r0, r9
	str r1, [sp, #0x10]
	mov r1, #0
	str r1, [sp, #0x14]
	mov r2, #1
	mov r3, r1
	str r7, [sp, #0x18]
	bl Unknown2056570__Init
	mov r0, r9
	mov r1, #4
	bl Unknown2056570__Func_2056688
	add r0, r8, #2
	mov r0, r0, lsl #0x10
	add r6, r6, #1
	add r7, r7, #0x400
	mov r8, r0, lsr #0x10
	add r9, r9, #0x30
	cmp r6, #5
	blt _0217B094
	ldr r0, _0217B11C // =0x02110460
	ldr r3, _0217B120 // =0x05000082
	mov r1, #4
	mov r2, #0
	bl QueueUncompressedPalette
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0217B11C: .word 0x02110460
_0217B120: .word 0x05000082
	arm_func_end VikingCupStageSelectMenu__Func_217B048

	arm_func_start VikingCupStageSelectMenu__Func_217B124
VikingCupStageSelectMenu__Func_217B124: // 0x0217B124
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl VikingCupStageSelectMenu__Func_217B18C
	mov r0, r4
	bl VikingCupStageSelectMenu__Func_217B178
	mov r0, r4
	bl VikingCupStageSelectMenu__Func_217B150
	mov r0, r4
	bl VikingCupStageSelectMenu__Func_217B14C
	ldmia sp!, {r4, pc}
	arm_func_end VikingCupStageSelectMenu__Func_217B124

	arm_func_start VikingCupStageSelectMenu__Func_217B14C
VikingCupStageSelectMenu__Func_217B14C: // 0x0217B14C
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217B14C

	arm_func_start VikingCupStageSelectMenu__Func_217B150
VikingCupStageSelectMenu__Func_217B150: // 0x0217B150
	stmdb sp!, {r3, r4, r5, lr}
	add r5, r0, #0x1c
	mov r4, #0
_0217B15C:
	mov r0, r5
	bl AnimatorSprite__Release
	add r4, r4, #1
	cmp r4, #0xc
	add r5, r5, #0x64
	blt _0217B15C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end VikingCupStageSelectMenu__Func_217B150

	arm_func_start VikingCupStageSelectMenu__Func_217B178
VikingCupStageSelectMenu__Func_217B178: // 0x0217B178
	ldr ip, _0217B188 // =ReleasePaletteAnimator
	add r0, r0, #0x26c
	add r0, r0, #0x400
	bx ip
	.align 2, 0
_0217B188: .word ReleasePaletteAnimator
	arm_func_end VikingCupStageSelectMenu__Func_217B178

	arm_func_start VikingCupStageSelectMenu__Func_217B18C
VikingCupStageSelectMenu__Func_217B18C: // 0x0217B18C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	add r0, r6, #0x318
	add r5, r0, #0x400
	mov r4, #0
_0217B1A0:
	mov r0, r5
	bl Unknown2056570__Func_2056670
	add r0, r6, r4, lsl #2
	ldr r0, [r0, #0x808]
	bl _FreeHEAP_USER
	add r4, r4, #1
	cmp r4, #5
	add r5, r5, #0x30
	blt _0217B1A0
	add r0, r6, #0x28c
	add r0, r0, #0x400
	bl FontFile__Release
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end VikingCupStageSelectMenu__Func_217B18C

	arm_func_start VikingCupStageSelectMenu__Main
VikingCupStageSelectMenu__Main: // 0x0217B1D4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x81c]
	cmp r0, #0
	beq _0217B208
	add r0, r4, #0xcc
	add r0, r0, #0x400
	bl TouchField__Process
	ldr r1, [r4, #0x81c]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
_0217B208:
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}
	arm_func_end VikingCupStageSelectMenu__Main

	arm_func_start VikingCupStageSelectMenu__Destructor
VikingCupStageSelectMenu__Destructor: // 0x0217B210
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl VikingCupStageSelectMenu__Func_217B124
	ldr r0, [r4, #0]
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}
	arm_func_end VikingCupStageSelectMenu__Destructor

	arm_func_start VikingCupStageSelectMenu__State_217B230
VikingCupStageSelectMenu__State_217B230: // 0x0217B230
	stmdb sp!, {r4, lr}
	ldr r1, _0217B2C0 // =renderCoreGFXControlA
	mov r4, r0
	ldrsh r0, [r1, #0x58]
	cmp r0, #0
	subgt r0, r0, #1
	strgth r0, [r1, #0x58]
	bgt _0217B258
	addlt r0, r0, #1
	strlth r0, [r1, #0x58]
_0217B258:
	ldr r0, _0217B2C0 // =renderCoreGFXControlA
	ldr r1, _0217B2C4 // =renderCoreGFXControlB
	ldrsh r2, [r0, #0x58]
	mov r0, r4
	strh r2, [r1, #0x58]
	bl VikingCupStageSelectMenu__Func_217B8B0
	mov r0, r4
	bl VikingCupStageSelectMenu__Func_217B8C0
	ldr r0, _0217B2C0 // =renderCoreGFXControlA
	ldrsh r0, [r0, #0x58]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	mov r1, #1
	bl VikingCupStageSelectMenu__Func_217C2CC
	mov r0, r4
	mov r1, #1
	bl VikingCupStageSelectMenu__Func_217C044
	mov r0, r4
	mov r1, #1
	bl VikingCupStageSelectMenu__Func_217BC68
	mov r1, #0
	ldr r0, _0217B2C8 // =VikingCupStageSelectMenu__State_217B364
	str r1, [r4, #4]
	str r0, [r4, #0x81c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217B2C0: .word renderCoreGFXControlA
_0217B2C4: .word renderCoreGFXControlB
_0217B2C8: .word VikingCupStageSelectMenu__State_217B364
	arm_func_end VikingCupStageSelectMenu__State_217B230

	arm_func_start VikingCupStageSelectMenu__State_217B2CC
VikingCupStageSelectMenu__State_217B2CC: // 0x0217B2CC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0]
	ldr r0, _0217B358 // =0x0000FFFF
	ldrh r1, [r1, #4]
	cmp r1, r0
	bne _0217B304
	ldr r1, _0217B35C // =renderCoreGFXControlA
	mvn r0, #0xf
	ldrsh r2, [r1, #0x58]
	cmp r2, r0
	subgt r0, r2, #1
	strgth r0, [r1, #0x58]
	b _0217B318
_0217B304:
	ldr r0, _0217B35C // =renderCoreGFXControlA
	ldrsh r1, [r0, #0x58]
	cmp r1, #0x10
	addlt r1, r1, #1
	strlth r1, [r0, #0x58]
_0217B318:
	ldr r0, _0217B35C // =renderCoreGFXControlA
	ldr r1, _0217B360 // =renderCoreGFXControlB
	ldrsh r2, [r0, #0x58]
	mov r0, r4
	strh r2, [r1, #0x58]
	bl VikingCupStageSelectMenu__Func_217B8B0
	mov r0, r4
	bl VikingCupStageSelectMenu__Func_217B8C0
	ldr r0, _0217B35C // =renderCoreGFXControlA
	ldrsh r0, [r0, #0x58]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x10
	movge r0, #0
	strge r0, [r4, #0x81c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217B358: .word 0x0000FFFF
_0217B35C: .word renderCoreGFXControlA
_0217B360: .word renderCoreGFXControlB
	arm_func_end VikingCupStageSelectMenu__State_217B2CC

	arm_func_start VikingCupStageSelectMenu__State_217B364
VikingCupStageSelectMenu__State_217B364: // 0x0217B364
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r10, r0
	add r0, r10, #0x800
	ldrh r0, [r0, #0x20]
	ldrh r9, [r10, #8]
	mov r6, #0
	ldrh r5, [r10, #0xa]
	mov r7, r6
	mov r8, r6
	cmp r0, #0
	add r4, r5, r9, lsl #1
	beq _0217B3E8
	cmp r5, #0
	bne _0217B3C4
	cmp r0, #1
	bls _0217B3C4
	sub r0, r0, #2
	add r0, r10, r0, lsl #1
	add r0, r0, #0x800
	ldrh r0, [r0, #0x28]
	add r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	b _0217B3E8
_0217B3C4:
	cmp r5, #1
	bne _0217B3E8
	sub r0, r0, #1
	add r0, r10, r0, lsl #1
	add r0, r0, #0x800
	ldrh r0, [r0, #0x28]
	add r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
_0217B3E8:
	ldr r0, _0217B7A0 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #2
	bne _0217B408
	mov r0, r10
	bl VikingCupStageSelectMenu__Func_217C68C
	cmp r0, #0
	beq _0217B410
_0217B408:
	mov r6, #1
	b _0217B658
_0217B410:
	ldr r0, _0217B7A0 // =padInput
	ldrh r0, [r0, #8]
	tst r0, #0x40
	bne _0217B454
	mov r0, r10
	mov r1, #0
	bl VikingCupStageSelectMenu__Func_217C6A0
	cmp r0, #0
	bne _0217B454
	mov r0, r10
	bl VikingCupStageSelectMenu__Func_217C26C
	cmp r0, #0
	beq _0217B4A8
	mov r0, r10
	bl VikingCupStageSelectMenu__Func_217C708
	cmp r0, #0
	beq _0217B4A8
_0217B454:
	cmp r9, #0
	bne _0217B498
	add r0, r10, #0x800
	mov r1, #0
	strh r1, [r0, #0x26]
	cmp r5, #0
	bne _0217B498
	mov r0, r10
	bl VikingCupStageSelectMenu__Func_217C6A0
	cmp r0, #0
	bne _0217B498
	add r0, r10, #0x800
	ldrh r1, [r0, #0x20]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x20]
	movne r7, #1
_0217B498:
	cmp r5, #0
	movne r5, #0
	movne r7, #1
	b _0217B658
_0217B4A8:
	ldr r0, _0217B7A0 // =padInput
	ldrh r0, [r0, #8]
	tst r0, #0x80
	bne _0217B4EC
	mov r0, r10
	mov r1, #1
	bl VikingCupStageSelectMenu__Func_217C6A0
	cmp r0, #0
	bne _0217B4EC
	mov r0, r10
	bl VikingCupStageSelectMenu__Func_217C294
	cmp r0, #0
	beq _0217B544
	mov r0, r10
	bl VikingCupStageSelectMenu__Func_217C744
	cmp r0, #0
	beq _0217B544
_0217B4EC:
	cmp r9, #0
	bne _0217B534
	add r0, r10, #0x800
	mov r1, #1
	strh r1, [r0, #0x26]
	cmp r5, #1
	bne _0217B534
	mov r0, r10
	bl VikingCupStageSelectMenu__Func_217C6A0
	cmp r0, #0
	bne _0217B534
	add r0, r10, #0x800
	ldrh r2, [r0, #0x20]
	ldrh r1, [r0, #0x24]
	cmp r2, r1
	addlo r1, r2, #1
	strloh r1, [r0, #0x20]
	movlo r7, #1
_0217B534:
	cmp r5, #1
	movne r5, #1
	movne r7, r5
	b _0217B658
_0217B544:
	ldr r0, _0217B7A0 // =padInput
	ldrh r0, [r0, #8]
	tst r0, #0x20
	bne _0217B56C
	tst r0, #0x200
	bne _0217B56C
	mov r0, r10
	bl VikingCupStageSelectMenu__Func_217C6E0
	cmp r0, #0
	beq _0217B5AC
_0217B56C:
	cmp r9, #0
	subne r0, r9, #1
	ldreqh r0, [r10, #0xe]
	mov r7, #1
	subeq r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #0
	beq _0217B658
	add r0, r10, #0x800
	mov r1, #0
	strh r1, [r0, #0x20]
	strh r1, [r0, #0x22]
	ldrh r1, [r10, #0xa]
	strh r1, [r0, #0x26]
	b _0217B658
_0217B5AC:
	ldr r0, _0217B7A0 // =padInput
	ldrh r0, [r0, #8]
	tst r0, #0x10
	bne _0217B5D4
	tst r0, #0x100
	bne _0217B5D4
	mov r0, r10
	bl VikingCupStageSelectMenu__Func_217C6F4
	cmp r0, #0
	beq _0217B61C
_0217B5D4:
	ldrh r0, [r10, #0xe]
	sub r0, r0, #1
	cmp r9, r0
	movge r9, #0
	bge _0217B5F4
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
_0217B5F4:
	cmp r9, #0
	mov r7, #1
	beq _0217B658
	add r0, r10, #0x800
	mov r1, #0
	strh r1, [r0, #0x20]
	strh r1, [r0, #0x22]
	ldrh r1, [r10, #0xa]
	strh r1, [r0, #0x26]
	b _0217B658
_0217B61C:
	ldr r0, _0217B7A0 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	bne _0217B654
	mov r0, r10
	mov r1, #0
	bl VikingCupStageSelectMenu__Func_217C6C0
	cmp r0, #0
	bne _0217B654
	mov r0, r10
	mov r1, #1
	bl VikingCupStageSelectMenu__Func_217C6C0
	cmp r0, #0
	beq _0217B658
_0217B654:
	mov r8, #1
_0217B658:
	cmp r7, #0
	beq _0217B6D8
	add r0, r10, #0x800
	ldrh r0, [r0, #0x20]
	add r1, r5, r9, lsl #1
	cmp r0, #0
	beq _0217B6C8
	cmp r5, #0
	bne _0217B6A4
	cmp r0, #1
	bls _0217B6A4
	sub r0, r0, #2
	add r0, r10, r0, lsl #1
	add r0, r0, #0x800
	ldrh r0, [r0, #0x28]
	add r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	b _0217B6C8
_0217B6A4:
	cmp r5, #1
	bne _0217B6C8
	sub r0, r0, #1
	add r0, r10, r0, lsl #1
	add r0, r0, #0x800
	ldrh r0, [r0, #0x28]
	add r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
_0217B6C8:
	mov r0, r10
	bl VikingCupStageSelectMenu__Func_217B7F0
	mov r0, #2
	bl PlaySysMenuNavSfx
_0217B6D8:
	mov r0, r10
	bl VikingCupStageSelectMenu__Func_217B8B0
	mov r0, r10
	bl VikingCupStageSelectMenu__Func_217B8C0
	cmp r6, #0
	beq _0217B73C
	ldr r2, [r10, #0]
	ldr r3, _0217B7A4 // =0x0000FFFF
	mov r0, r10
	mov r1, #0
	strh r3, [r2, #4]
	bl VikingCupStageSelectMenu__Func_217C2CC
	mov r0, r10
	mov r1, #0
	bl VikingCupStageSelectMenu__Func_217C044
	mov r0, r10
	mov r1, #0
	bl VikingCupStageSelectMenu__Func_217BC68
	mov r0, #0
	str r0, [r10, #4]
	ldr r1, _0217B7A8 // =VikingCupStageSelectMenu__State_217B2CC
	mov r0, #1
	str r1, [r10, #0x81c]
	bl PlaySysMenuNavSfx
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0217B73C:
	cmp r8, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	cmp r5, #0
	addeq r0, r10, #0x800
	ldreqh r0, [r0, #0x20]
	ldr r2, [r10, #0]
	mov r1, #0
	cmpeq r0, #1
	moveq r4, #1
	add r3, r4, #9
	mov r0, r10
	strh r3, [r2, #4]
	bl VikingCupStageSelectMenu__Func_217C2CC
	mov r0, r10
	mov r1, #0
	bl VikingCupStageSelectMenu__Func_217C044
	mov r0, r10
	mov r1, #0
	bl VikingCupStageSelectMenu__Func_217BC68
	mov r0, #0
	ldr r1, _0217B7AC // =VikingCupStageSelectMenu__State_217B7B0
	str r0, [r10, #4]
	str r1, [r10, #0x81c]
	bl PlaySysMenuNavSfx
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0217B7A0: .word padInput
_0217B7A4: .word 0x0000FFFF
_0217B7A8: .word VikingCupStageSelectMenu__State_217B2CC
_0217B7AC: .word VikingCupStageSelectMenu__State_217B7B0
	arm_func_end VikingCupStageSelectMenu__State_217B364

	arm_func_start VikingCupStageSelectMenu__State_217B7B0
VikingCupStageSelectMenu__State_217B7B0: // 0x0217B7B0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl VikingCupStageSelectMenu__Func_217B8B0
	mov r0, r4
	bl VikingCupStageSelectMenu__Func_217B8C0
	ldr r0, [r4, #4]
	cmp r0, #0x20
	addlo r0, r0, #1
	strlo r0, [r4, #4]
	ldmloia sp!, {r4, pc}
	mov r1, #0
	ldr r0, _0217B7EC // =VikingCupStageSelectMenu__State_217B2CC
	str r1, [r4, #4]
	str r0, [r4, #0x81c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217B7EC: .word VikingCupStageSelectMenu__State_217B2CC
	arm_func_end VikingCupStageSelectMenu__State_217B7B0

	arm_func_start VikingCupStageSelectMenu__Func_217B7F0
VikingCupStageSelectMenu__Func_217B7F0: // 0x0217B7F0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	cmp r1, #8
	and r2, r1, #1
	addge r0, r5, #0x800
	mov r3, r1, lsl #0xf
	mov r4, r3, lsr #0x10
	ldrgeh r2, [r0, #0x26]
	movge r4, #0
	cmp r2, #0
	addeq r0, r5, #0x800
	ldreqh r0, [r0, #0x20]
	cmpeq r0, #1
	ldrh r0, [r5, #8]
	moveq r1, #1
	cmp r4, r0
	ldreqh ip, [r5, #0xa]
	cmpeq r2, ip
	bne _0217B854
	add r0, r5, #0x800
	ldrh r3, [r0, #0x22]
	ldrh r0, [r0, #0x20]
	cmp r3, r0
	cmpeq r2, ip
	ldmeqia sp!, {r3, r4, r5, pc}
_0217B854:
	ldrh r0, [r5, #0xa]
	cmp r2, r0
	movne r0, #0
	strneh r0, [r5, #0xc]
	strh r4, [r5, #8]
	strh r2, [r5, #0xa]
	add r2, r5, #0x800
	ldrh r3, [r2, #0x20]
	mov r0, r5
	strh r3, [r2, #0x22]
	bl VikingCupStageSelectMenu__Func_217BA04
	add r0, r5, #0x26c
	mov r1, r4, lsl #0x10
	add r0, r0, #0x400
	mov r1, r1, lsr #0x10
	bl SetPaletteAnimation
	add r0, r5, #0x26c
	add r0, r0, #0x400
	bl AnimatePalette
	add r0, r5, #0x26c
	add r0, r0, #0x400
	bl DrawAnimatedPalette
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end VikingCupStageSelectMenu__Func_217B7F0

	arm_func_start VikingCupStageSelectMenu__Func_217B8B0
VikingCupStageSelectMenu__Func_217B8B0: // 0x0217B8B0
	ldrh r1, [r0, #0xc]
	add r1, r1, #1
	strh r1, [r0, #0xc]
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217B8B0

	arm_func_start VikingCupStageSelectMenu__Func_217B8C0
VikingCupStageSelectMenu__Func_217B8C0: // 0x0217B8C0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #1
	str r1, [sp]
	mov r1, #0
	mov r4, r0
	str r1, [sp, #4]
	ldrh r1, [r4, #8]
	add r0, r4, #0x1c
	mov r2, #0x80
	add r1, r1, #2
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r3, #0x28
	bl VikingCupStageSelectMenu__Func_217BBF4
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0217B934
_0217B910: // jump table
	b _0217B928 // case 0
	b _0217B928 // case 1
	b _0217B928 // case 2
	b _0217B928 // case 3
	b _0217B928 // case 4
	b _0217B928 // case 5
_0217B928:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _0217B938
_0217B934:
	mov r0, #1
_0217B938:
	cmp r0, #0
	bne _0217B964
	mov r0, #1
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	ldrh r1, [r4, #8]
	add r0, r4, #0x80
	mov r2, #0x80
	mov r3, #0x54
	bl VikingCupStageSelectMenu__Func_217BBF4
_0217B964:
	ldrh r0, [r4, #8]
	mov r1, #1
	mov r2, #0
	add r0, r0, #0x33
	mov r0, r0, lsl #0x10
	str r1, [sp]
	mov r3, r2
	mov r1, r0, lsr #0x10
	add r0, r4, #0xe4
	str r2, [sp, #4]
	bl VikingCupStageSelectMenu__Func_217BBF4
	mov r0, #1
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	ldrh r1, [r4, #8]
	add r0, r4, #0x148
	mov r2, #0x28
	add r1, r1, #0x37
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r3, #8
	bl VikingCupStageSelectMenu__Func_217BBF4
	mov r1, #1
	str r1, [sp]
	mov ip, #0
	add r0, r4, #0x1ac
	rsb r1, r1, #0x10000
	mov r2, #0x20
	mov r3, #4
	str ip, [sp, #4]
	bl VikingCupStageSelectMenu__Func_217BBF4
	mov r0, r4
	bl VikingCupStageSelectMenu__Func_217C148
	mov r0, r4
	bl VikingCupStageSelectMenu__Func_217BCF0
	mov r0, r4
	bl VikingCupStageSelectMenu__Func_217C324
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end VikingCupStageSelectMenu__Func_217B8C0

	arm_func_start VikingCupStageSelectMenu__Func_217BA04
VikingCupStageSelectMenu__Func_217BA04: // 0x0217BA04
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	add r2, r0, #0x318
	mov r8, #0
	ldr r11, _0217BBE0 // =0x05F5E0FF
	mov r10, r1
	add r9, r2, #0x400
	add r5, r0, #0x28c
	mov r6, r8
	mvn r4, #0
_0217BA2C:
	mov r0, r9
	bl Unknown2056570__Func_205683C
	mov r1, r8, lsl #0x10
	mov r0, r10
	mov r1, r1, lsr #0x10
	bl VikingCupStageSelectMenu__GetRecord
	mov r7, r0
	cmp r7, r4
	mov r0, r10
	bne _0217BAE0
	bl VikingCupStageSelectMenu__Func_217C8E0
	cmp r0, #0
	mov r0, #0x40
	str r0, [sp]
	mov r1, #0
	mov r0, #0
	beq _0217BAA8
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, #8
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	ldr r0, _0217BBE4 // =asc_217EF70
	mov r2, r1
	str r0, [sp, #0x18]
	add r0, r5, #0x400
	mov r3, r9
	bl FontFile__Func_2053010
	b _0217BBC0
_0217BAA8:
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, #8
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	ldr r0, _0217BBE8 // =asc_217EF78
	mov r2, r1
	str r0, [sp, #0x18]
	add r0, r5, #0x400
	mov r3, r9
	bl FontFile__Func_2053010
	b _0217BBC0
_0217BAE0:
	bl VikingCupStageSelectMenu__Func_217C8E0
	cmp r0, #0
	beq _0217BB70
	mov r1, r7
	add r0, sp, #0x30
	bl MultibootManager__Func_2063CF4
	ldr r1, [sp, #0x30]
	mov r2, #0x40
	stmia sp, {r2, r6}
	str r6, [sp, #8]
	str r6, [sp, #0xc]
	mov r2, #8
	str r2, [sp, #0x10]
	ldr r2, _0217BBEC // =aDDDDD
	str r6, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r2, r1, lsr #0x10
	and r2, r2, #0xf
	str r2, [sp, #0x1c]
	mov r2, r1, lsr #0xc
	and r2, r2, #0xf
	str r2, [sp, #0x20]
	mov r2, r1, lsr #8
	and r2, r2, #0xf
	str r2, [sp, #0x24]
	mov r2, r1, lsr #4
	and r2, r2, #0xf
	str r2, [sp, #0x28]
	and r1, r1, #0xf
	str r1, [sp, #0x2c]
	add r0, r5, #0x400
	mov r1, r6
	mov r2, r6
	mov r3, r9
	bl FontFile__Func_2053010
	b _0217BBC0
_0217BB70:
	mov r0, #0x40
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, #8
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	ldr r0, _0217BBF0 // =0x0217EF94
	mov r1, #0
	cmp r7, r11
	str r0, [sp, #0x18]
	movhi r7, r11
	add r0, r5, #0x400
	mov r2, r1
	mov r3, r9
	str r7, [sp, #0x1c]
	bl FontFile__Func_2053010
_0217BBC0:
	mov r0, r9
	bl Unknown2056570__Func_2056B8C
	add r9, r9, #0x30
	add r8, r8, #1
	cmp r8, #5
	blt _0217BA2C
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0217BBE0: .word 0x05F5E0FF
_0217BBE4: .word asc_217EF70
_0217BBE8: .word asc_217EF78
_0217BBEC: .word aDDDDD
_0217BBF0: .word 0x0217EF94
	arm_func_end VikingCupStageSelectMenu__Func_217BA04

	arm_func_start VikingCupStageSelectMenu__Func_217BBF4
VikingCupStageSelectMenu__Func_217BBF4: // 0x0217BBF4
	stmdb sp!, {r4, r5, r6, lr}
	ldr ip, _0217BC64 // =0x0000FFFF
	mov r6, r0
	mov r5, r2
	cmp r1, ip
	ldrneh r2, [r6, #0xc]
	mov r4, r3
	cmpne r2, r1
	beq _0217BC1C
	bl AnimatorSprite__SetAnimation
_0217BC1C:
	ldr r0, [sp, #0x10]
	cmp r0, #0
	beq _0217BC38
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
_0217BC38:
	ldr r0, [sp, #0x14]
	cmp r0, #0
	ldr r0, [r6, #0x3c]
	orrne r0, r0, #0x80
	biceq r0, r0, #0x80
	str r0, [r6, #0x3c]
	strh r5, [r6, #8]
	mov r0, r6
	strh r4, [r6, #0xa]
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0217BC64: .word 0x0000FFFF
	arm_func_end VikingCupStageSelectMenu__Func_217BBF4

	arm_func_start VikingCupStageSelectMenu__Func_217BC68
VikingCupStageSelectMenu__Func_217BC68: // 0x0217BC68
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x10]
	cmp r0, r1
	ldmeqia sp!, {r4, pc}
	str r1, [r4, #0x10]
	cmp r1, #0
	beq _0217BCBC
	ldr r1, [r4, #0x5a0]
	add r0, r4, #0x18c
	bic r1, r1, #0x40
	str r1, [r4, #0x5a0]
	ldr r1, [r4, #0x5d8]
	add r0, r0, #0x400
	bic r1, r1, #0x40
	str r1, [r4, #0x5d8]
	bl TouchField__ResetArea
	add r0, r4, #0x1c4
	add r0, r0, #0x400
	bl TouchField__ResetArea
	ldmia sp!, {r4, pc}
_0217BCBC:
	add r0, r4, #0x18c
	add r0, r0, #0x400
	bl TouchField__ResetArea
	add r0, r4, #0x1c4
	add r0, r0, #0x400
	bl TouchField__ResetArea
	ldr r0, [r4, #0x5a0]
	orr r0, r0, #0x40
	str r0, [r4, #0x5a0]
	ldr r0, [r4, #0x5d8]
	orr r0, r0, #0x40
	str r0, [r4, #0x5d8]
	ldmia sp!, {r4, pc}
	arm_func_end VikingCupStageSelectMenu__Func_217BC68

	arm_func_start VikingCupStageSelectMenu__Func_217BCF0
VikingCupStageSelectMenu__Func_217BCF0: // 0x0217BCF0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r10, r0
	ldrh r0, [r10, #0xc]
	cmp r0, #3
	movlo r11, #0
	blo _0217BD14
	cmp r0, #6
	movlo r11, #1
	movhs r11, #2
_0217BD14:
	ldr r0, [r10, #0x10]
	add r4, r10, #0x274
	cmp r0, #0
	add r5, r10, #0x2d8
	add r6, r10, #0x33c
	add r7, r10, #0x3a0
	beq _0217BD4C
	ldrh r0, [r10, #0xa]
	cmp r0, #0
	moveq r8, #0x22
	moveq r9, #0x23
	movne r8, #0x20
	movne r9, #0x25
	b _0217BD9C
_0217BD4C:
	ldr r2, [r10, #0x81c]
	ldr r0, _0217C038 // =VikingCupStageSelectMenu__State_217B230
	cmp r2, r0
	beq _0217BD94
	ldr r1, [r10, #0]
	ldr r0, _0217C03C // =0x0000FFFF
	ldrh r1, [r1, #4]
	cmp r1, r0
	ldreq r0, _0217C040 // =VikingCupStageSelectMenu__State_217B2CC
	cmpeq r2, r0
	beq _0217BD94
	ldrh r0, [r10, #0xa]
	cmp r0, #0
	moveq r8, #0x21
	moveq r9, #0x23
	movne r8, #0x20
	movne r9, #0x24
	b _0217BD9C
_0217BD94:
	mov r8, #0x20
	mov r9, #0x23
_0217BD9C:
	add r0, r10, #0x800
	ldrh r0, [r0, #0x20]
	cmp r0, #1
	bls _0217BDD4
	sub r1, r0, #2
	add r1, r10, r1, lsl #1
	add r1, r1, #0x800
	ldrh r1, [r1, #0x28]
	add r1, r1, r1, lsl #1
	add r1, r1, #0x1b
	add r1, r8, r1
	mov r1, r1, lsl #0x10
	mov r8, r1, lsr #0x10
	b _0217BDE4
_0217BDD4:
	cmp r0, #0
	addne r1, r8, #3
	movne r1, r1, lsl #0x10
	movne r8, r1, lsr #0x10
_0217BDE4:
	cmp r0, #0
	beq _0217BE14
	sub r0, r0, #1
	add r0, r10, r0, lsl #1
	add r0, r0, #0x800
	ldrh r0, [r0, #0x28]
	sub r0, r0, #1
	add r0, r0, r0, lsl #1
	add r0, r0, #0x1b
	add r0, r9, r0
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
_0217BE14:
	ldrh r0, [r4, #0xc]
	cmp r0, r8
	beq _0217BE2C
	mov r0, r4
	mov r1, r8
	bl AnimatorSprite__SetAnimation
_0217BE2C:
	ldrh r0, [r5, #0xc]
	cmp r0, r9
	beq _0217BE44
	mov r0, r5
	mov r1, r9
	bl AnimatorSprite__SetAnimation
_0217BE44:
	add r0, r10, #0x800
	ldrh r0, [r0, #0x20]
	cmp r0, #1
	bls _0217BE7C
	sub r1, r0, #2
	add r1, r10, r1, lsl #1
	add r1, r1, #0x800
	ldrh r1, [r1, #0x28]
	add r1, r1, r1, lsl #1
	add r1, r1, #0x1b
	sub r1, r8, r1
	mov r1, r1, lsl #0x10
	mov r8, r1, lsr #0x10
	b _0217BE8C
_0217BE7C:
	cmp r0, #0
	subne r1, r8, #3
	movne r1, r1, lsl #0x10
	movne r8, r1, lsr #0x10
_0217BE8C:
	cmp r0, #0
	beq _0217BEBC
	sub r0, r0, #1
	add r0, r10, r0, lsl #1
	add r0, r0, #0x800
	ldrh r0, [r0, #0x28]
	sub r0, r0, #1
	add r0, r0, r0, lsl #1
	add r0, r0, #0x1b
	sub r0, r9, r0
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
_0217BEBC:
	ldr r0, [r4, #0x3c]
	cmp r8, #0x21
	orreq r0, r0, #4
	bicne r0, r0, #4
	str r0, [r4, #0x3c]
	ldr r0, [r5, #0x3c]
	cmp r9, #0x24
	orreq r0, r0, #4
	bicne r0, r0, #4
	str r0, [r5, #0x3c]
	ldrh r0, [r10, #0xc]
	cmp r0, #0
	bne _0217BEFC
	mov r0, r7
	mov r1, #0xd
	bl AnimatorSprite__SetAnimation
_0217BEFC:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r7, #0x3c]
	mov r0, r7
	orr r1, r1, #4
	str r1, [r7, #0x3c]
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	cmp r8, #0x20
	beq _0217BF84
	rsb r0, r11, #0x94
	strh r0, [r4, #8]
	rsb r0, r11, #0x48
	strh r0, [r4, #0xa]
	mov r0, #0x94
	strh r0, [r6, #8]
	mov r1, #0x48
	mov r0, r6
	strh r1, [r6, #0xa]
	mov r1, #2
	strb r1, [r6, #0x57]
	bl AnimatorSprite__DrawFrame
	b _0217BF94
_0217BF84:
	mov r0, #0x94
	strh r0, [r4, #8]
	mov r0, #0x48
	strh r0, [r4, #0xa]
_0217BF94:
	mov r1, #1
	mov r0, r4
	strb r1, [r4, #0x57]
	bl AnimatorSprite__DrawFrame
	cmp r9, #0x23
	beq _0217BFE0
	rsb r0, r11, #0x94
	strh r0, [r5, #8]
	rsb r0, r11, #0x68
	strh r0, [r5, #0xa]
	mov r0, #0x94
	strh r0, [r6, #8]
	mov r1, #0x68
	mov r0, r6
	strh r1, [r6, #0xa]
	mov r1, #2
	strb r1, [r6, #0x57]
	bl AnimatorSprite__DrawFrame
	b _0217BFF0
_0217BFE0:
	mov r0, #0x94
	strh r0, [r5, #8]
	mov r0, #0x68
	strh r0, [r5, #0xa]
_0217BFF0:
	mov r1, #1
	mov r0, r5
	strb r1, [r5, #0x57]
	bl AnimatorSprite__DrawFrame
	ldr r0, [r10, #0x10]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [r10, #0xa]
	cmp r0, #0
	mov r0, #0x94
	streqh r0, [r7, #8]
	moveq r0, #0x54
	strneh r0, [r7, #8]
	movne r0, #0x74
	strh r0, [r7, #0xa]
	mov r0, r7
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0217C038: .word VikingCupStageSelectMenu__State_217B230
_0217C03C: .word 0x0000FFFF
_0217C040: .word VikingCupStageSelectMenu__State_217B2CC
	arm_func_end VikingCupStageSelectMenu__Func_217BCF0

	arm_func_start VikingCupStageSelectMenu__Func_217C044
VikingCupStageSelectMenu__Func_217C044: // 0x0217C044
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x18]
	cmp r0, r1
	ldmeqia sp!, {r4, pc}
	str r1, [r4, #0x18]
	cmp r1, #0
	beq _0217C0E4
	ldr r1, [r4, #0x4f8]
	add r0, r4, #0xe4
	bic r1, r1, #0x40
	str r1, [r4, #0x4f8]
	ldr r1, [r4, #0x530]
	add r0, r0, #0x400
	bic r1, r1, #0x40
	str r1, [r4, #0x530]
	bl TouchField__ResetArea
	add r0, r4, #0x11c
	add r0, r0, #0x400
	bl TouchField__ResetArea
	add r0, r4, #0x210
	mov r1, #0xc
	bl AnimatorSprite__SetAnimation
	ldr r1, [r4, #0x610]
	add r0, r4, #0x1fc
	bic r1, r1, #0x40
	str r1, [r4, #0x610]
	ldr r1, [r4, #0x648]
	add r0, r0, #0x400
	bic r1, r1, #0x40
	str r1, [r4, #0x648]
	bl TouchField__ResetArea
	add r0, r4, #0x234
	add r0, r0, #0x400
	bl TouchField__ResetArea
	add r0, r4, #0x68
	add r0, r0, #0x400
	mov r1, #0x51
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, pc}
_0217C0E4:
	add r0, r4, #0xe4
	add r0, r0, #0x400
	bl TouchField__ResetArea
	add r0, r4, #0x11c
	add r0, r0, #0x400
	bl TouchField__ResetArea
	ldr r1, [r4, #0x4f8]
	add r0, r4, #0x1fc
	orr r1, r1, #0x40
	str r1, [r4, #0x4f8]
	ldr r1, [r4, #0x530]
	add r0, r0, #0x400
	orr r1, r1, #0x40
	str r1, [r4, #0x530]
	bl TouchField__ResetArea
	add r0, r4, #0x234
	add r0, r0, #0x400
	bl TouchField__ResetArea
	ldr r0, [r4, #0x610]
	orr r0, r0, #0x40
	str r0, [r4, #0x610]
	ldr r0, [r4, #0x648]
	orr r0, r0, #0x40
	str r0, [r4, #0x648]
	ldmia sp!, {r4, pc}
	arm_func_end VikingCupStageSelectMenu__Func_217C044

	arm_func_start VikingCupStageSelectMenu__Func_217C148
VikingCupStageSelectMenu__Func_217C148: // 0x0217C148
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x18]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x24c]
	mov r2, #8
	orr r0, r0, #4
	str r0, [r4, #0x24c]
	mov r1, #1
	str r1, [sp]
	mov r5, #0
	mov r3, r2
	add r0, r4, #0x210
	rsb r1, r1, #0x10000
	str r5, [sp, #4]
	bl VikingCupStageSelectMenu__Func_217BBF4
	mov r0, r5
	mov r1, #1
	stmia sp, {r0, r1}
	add r0, r4, #0x210
	rsb r1, r1, #0x10000
	mov r2, #0xf8
	mov r3, #8
	bl VikingCupStageSelectMenu__Func_217BBF4
	ldrh r0, [r4, #8]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	add r5, r4, #0x68
	ldr r1, [r5, #0x43c]
	add r0, r4, #0x800
	orr r1, r1, #4
	str r1, [r5, #0x43c]
	ldrh r0, [r0, #0x20]
	mov r2, #1
	cmp r0, #0
	beq _0217C20C
	str r2, [sp]
	mov ip, #0
	add r0, r5, #0x400
	rsb r1, r2, #0x10000
	mov r2, #0xac
	mov r3, #0x40
	str ip, [sp, #4]
	bl VikingCupStageSelectMenu__Func_217BBF4
	mov r2, #0
_0217C20C:
	add r0, r4, #0x800
	ldrh r1, [r0, #0x24]
	cmp r1, #0
	ldrneh r0, [r0, #0x20]
	cmpne r0, r1
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r5, #0x43c]
	mov r0, #0
	eor r1, r1, #0x100
	str r1, [r5, #0x43c]
	str r2, [sp]
	ldr r1, _0217C268 // =0x0000FFFF
	str r0, [sp, #4]
	add r0, r5, #0x400
	mov r2, #0xac
	mov r3, #0x88
	bl VikingCupStageSelectMenu__Func_217BBF4
	ldr r0, [r5, #0x43c]
	eor r0, r0, #0x100
	str r0, [r5, #0x43c]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217C268: .word 0x0000FFFF
	arm_func_end VikingCupStageSelectMenu__Func_217C148

	arm_func_start VikingCupStageSelectMenu__Func_217C26C
VikingCupStageSelectMenu__Func_217C26C: // 0x0217C26C
	ldrh r1, [r0, #8]
	cmp r1, #0
	movne r0, #0
	bxne lr
	add r0, r0, #0x800
	ldrh r0, [r0, #0x20]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217C26C

	arm_func_start VikingCupStageSelectMenu__Func_217C294
VikingCupStageSelectMenu__Func_217C294: // 0x0217C294
	ldrh r1, [r0, #8]
	cmp r1, #0
	movne r0, #0
	bxne lr
	add r0, r0, #0x800
	ldrh r1, [r0, #0x24]
	cmp r1, #0
	moveq r0, #0
	bxeq lr
	ldrh r0, [r0, #0x20]
	cmp r0, r1
	movlo r0, #1
	movhs r0, #0
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217C294

	arm_func_start VikingCupStageSelectMenu__Func_217C2CC
VikingCupStageSelectMenu__Func_217C2CC: // 0x0217C2CC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x14]
	cmp r0, r1
	ldmeqia sp!, {r4, pc}
	str r1, [r4, #0x14]
	cmp r1, #0
	beq _0217C308
	ldr r1, [r4, #0x568]
	add r0, r4, #0x154
	bic r1, r1, #0x40
	add r0, r0, #0x400
	str r1, [r4, #0x568]
	bl TouchField__ResetArea
	ldmia sp!, {r4, pc}
_0217C308:
	add r0, r4, #0x154
	add r0, r0, #0x400
	bl TouchField__ResetArea
	ldr r0, [r4, #0x568]
	orr r0, r0, #0x40
	str r0, [r4, #0x568]
	ldmia sp!, {r4, pc}
	arm_func_end VikingCupStageSelectMenu__Func_217C2CC

	arm_func_start VikingCupStageSelectMenu__Func_217C324
VikingCupStageSelectMenu__Func_217C324: // 0x0217C324
	stmdb sp!, {r4, lr}
	ldr r1, [r0, #0x14]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	add r1, r0, #4
	add r4, r1, #0x400
	bl VikingCupStageSelectMenu__Func_217C66C
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	mov r0, r0, lsl #0x10
	ldrh r2, [r4, #0xc]
	mov r1, r0, lsr #0x10
	cmp r2, r0, lsr #16
	beq _0217C368
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_0217C368:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0x10
	mov r0, r4
	strh r1, [r4, #8]
	mov r1, #0xb0
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end VikingCupStageSelectMenu__Func_217C324

	arm_func_start VikingCupStageSelectMenu__Func_217C394
VikingCupStageSelectMenu__Func_217C394: // 0x0217C394
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x18
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0x10]
	add r0, r4, #0xcc
	str r1, [r4, #0x14]
	add r0, r0, #0x400
	str r1, [r4, #0x18]
	bl TouchField__Init
	mov r3, #8
	mov r1, #0
	str r1, [r4, #0x4d8]
	add r2, r3, #0x18
	mov r0, r2
	strh r2, [sp, #0xc]
	add r5, r4, #0xe4
	strh r0, [sp, #0xe]
	strh r3, [sp, #8]
	strh r3, [sp, #0xa]
	str r1, [sp]
	ldr r2, _0217C664 // =TouchField__PointInRect
	add r3, sp, #8
	add r0, r5, #0x400
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	add r0, r4, #0xcc
	ldr r2, _0217C668 // =0x0000FFFF
	add r0, r0, #0x400
	add r1, r5, #0x400
	bl TouchField__AddArea
	ldr r1, [r5, #0x414]
	mov r0, #0xe0
	orr r1, r1, #0x40
	str r1, [r5, #0x414]
	strh r0, [sp, #8]
	add r0, r0, #0x18
	strh r0, [sp, #0xc]
	mov r0, #8
	strh r0, [sp, #0xa]
	add r0, r0, #0x18
	strh r0, [sp, #0xe]
	add r5, r4, #0x11c
	mov r1, #0
	str r1, [sp]
	ldr r2, _0217C664 // =TouchField__PointInRect
	add r0, r5, #0x400
	add r3, sp, #8
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	add r0, r4, #0xcc
	ldr r2, _0217C668 // =0x0000FFFF
	add r0, r0, #0x400
	add r1, r5, #0x400
	bl TouchField__AddArea
	ldr r1, [r5, #0x414]
	mov r0, #4
	orr r1, r1, #0x40
	str r1, [r5, #0x414]
	strh r0, [sp, #8]
	add r0, r0, #0x18
	strh r0, [sp, #0xc]
	mov r0, #0xa4
	strh r0, [sp, #0xa]
	add r0, r0, #0x18
	strh r0, [sp, #0xe]
	add r5, r4, #0x154
	mov r1, #0
	str r1, [sp]
	ldr r2, _0217C664 // =TouchField__PointInRect
	add r0, r5, #0x400
	add r3, sp, #8
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	add r0, r4, #0xcc
	ldr r2, _0217C668 // =0x0000FFFF
	add r0, r0, #0x400
	add r1, r5, #0x400
	bl TouchField__AddArea
	ldr r0, [r5, #0x414]
	mov r3, #0x94
	orr r0, r0, #0x40
	str r0, [r5, #0x414]
	mov r2, #0x48
	add r1, r3, #0x30
	add r0, r2, #0x18
	strh r3, [sp, #8]
	strh r2, [sp, #0xa]
	strh r1, [sp, #0xc]
	add r5, r4, #0x18c
	strh r0, [sp, #0xe]
	mov r1, #0
	str r1, [sp]
	ldr r2, _0217C664 // =TouchField__PointInRect
	add r3, sp, #8
	add r0, r5, #0x400
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	add r0, r4, #0xcc
	ldr r2, _0217C668 // =0x0000FFFF
	add r0, r0, #0x400
	add r1, r5, #0x400
	bl TouchField__AddArea
	ldr r1, [r5, #0x414]
	mov r0, #0x94
	orr r1, r1, #0x40
	str r1, [r5, #0x414]
	strh r0, [sp, #8]
	add r0, r0, #0x30
	strh r0, [sp, #0xc]
	mov r0, #0x68
	strh r0, [sp, #0xa]
	add r0, r0, #0x18
	strh r0, [sp, #0xe]
	add r5, r4, #0x1c4
	mov r1, #0
	str r1, [sp]
	ldr r2, _0217C664 // =TouchField__PointInRect
	add r0, r5, #0x400
	add r3, sp, #8
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	add r0, r4, #0xcc
	ldr r2, _0217C668 // =0x0000FFFF
	add r0, r0, #0x400
	add r1, r5, #0x400
	bl TouchField__AddArea
	ldr r1, [r5, #0x414]
	mov r0, #0xa0
	orr r1, r1, #0x40
	str r1, [r5, #0x414]
	strh r0, [sp, #8]
	add r0, r0, #0x18
	strh r0, [sp, #0xc]
	mov r0, #0x28
	strh r0, [sp, #0xa]
	add r0, r0, #0x18
	strh r0, [sp, #0xe]
	add r5, r4, #0x1fc
	mov r1, #0
	str r1, [sp]
	ldr r2, _0217C664 // =TouchField__PointInRect
	add r0, r5, #0x400
	add r3, sp, #8
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	add r0, r4, #0xcc
	ldr r2, _0217C668 // =0x0000FFFF
	add r0, r0, #0x400
	add r1, r5, #0x400
	bl TouchField__AddArea
	ldr r0, [r5, #0x414]
	mov r3, #0xa0
	orr r0, r0, #0x40
	str r0, [r5, #0x414]
	mov r2, #0x88
	add r1, r3, #0x18
	add r0, r2, #0x18
	strh r3, [sp, #8]
	strh r2, [sp, #0xa]
	strh r1, [sp, #0xc]
	add r5, r4, #0x234
	strh r0, [sp, #0xe]
	mov r1, #0
	str r1, [sp]
	ldr r2, _0217C664 // =TouchField__PointInRect
	add r3, sp, #8
	add r0, r5, #0x400
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	add r0, r4, #0xcc
	ldr r2, _0217C668 // =0x0000FFFF
	add r0, r0, #0x400
	add r1, r5, #0x400
	bl TouchField__AddArea
	ldr r0, [r5, #0x414]
	orr r0, r0, #0x40
	str r0, [r5, #0x414]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217C664: .word TouchField__PointInRect
_0217C668: .word 0x0000FFFF
	arm_func_end VikingCupStageSelectMenu__Func_217C394

	arm_func_start VikingCupStageSelectMenu__Func_217C66C
VikingCupStageSelectMenu__Func_217C66C: // 0x0217C66C
	ldr r0, [r0, #0x568]
	tst r0, #0x800
	bne _0217C684
	tst r0, #0x10
	movne r0, #1
	bxne lr
_0217C684:
	mov r0, #0
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217C66C

	arm_func_start VikingCupStageSelectMenu__Func_217C68C
VikingCupStageSelectMenu__Func_217C68C: // 0x0217C68C
	ldr r0, [r0, #0x568]
	tst r0, #0x40000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217C68C

	arm_func_start VikingCupStageSelectMenu__Func_217C6A0
VikingCupStageSelectMenu__Func_217C6A0: // 0x0217C6A0
	add r2, r1, #3
	mov r1, #0x38
	mla r0, r2, r1, r0
	ldr r0, [r0, #0x4f8]
	tst r0, #0x400000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217C6A0

	arm_func_start VikingCupStageSelectMenu__Func_217C6C0
VikingCupStageSelectMenu__Func_217C6C0: // 0x0217C6C0
	add r2, r1, #3
	mov r1, #0x38
	mla r0, r2, r1, r0
	ldr r0, [r0, #0x4f8]
	tst r0, #0x40000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217C6C0

	arm_func_start VikingCupStageSelectMenu__Func_217C6E0
VikingCupStageSelectMenu__Func_217C6E0: // 0x0217C6E0
	ldr r0, [r0, #0x4f8]
	tst r0, #0x400000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217C6E0

	arm_func_start VikingCupStageSelectMenu__Func_217C6F4
VikingCupStageSelectMenu__Func_217C6F4: // 0x0217C6F4
	ldr r0, [r0, #0x530]
	tst r0, #0x400000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217C6F4

	arm_func_start VikingCupStageSelectMenu__Func_217C708
VikingCupStageSelectMenu__Func_217C708: // 0x0217C708
	add r1, r0, #0x800
	ldrh r2, [r1, #0x24]
	add r1, r0, #0x1fc
	cmp r2, #0
	moveq r0, #0
	bxeq lr
	ldrh r0, [r0, #8]
	cmp r0, #0
	movne r0, #0
	bxne lr
	ldr r0, [r1, #0x414]
	tst r0, #0x200000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217C708

	arm_func_start VikingCupStageSelectMenu__Func_217C744
VikingCupStageSelectMenu__Func_217C744: // 0x0217C744
	add r1, r0, #0x800
	ldrh r2, [r1, #0x24]
	add r1, r0, #0x234
	cmp r2, #0
	moveq r0, #0
	bxeq lr
	ldrh r0, [r0, #8]
	cmp r0, #0
	movne r0, #0
	bxne lr
	ldr r0, [r1, #0x414]
	tst r0, #0x200000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217C744

	arm_func_start VikingCupStageSelectMenu__CheckShipUnlocked
VikingCupStageSelectMenu__CheckShipUnlocked: // 0x0217C780
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SaveGame__GetBlock1GameProgress
	cmp r4, #3
	addls pc, pc, r4, lsl #2
	b _0217C7E4
_0217C798: // jump table
	b _0217C7A8 // case 0
	b _0217C7B8 // case 1
	b _0217C7C8 // case 2
	b _0217C7D8 // case 3
_0217C7A8:
	cmp r0, #2
	blt _0217C7E4
	mov r0, #1
	ldmia sp!, {r4, pc}
_0217C7B8:
	cmp r0, #9
	blt _0217C7E4
	mov r0, #1
	ldmia sp!, {r4, pc}
_0217C7C8:
	cmp r0, #0x16
	blt _0217C7E4
	mov r0, #1
	ldmia sp!, {r4, pc}
_0217C7D8:
	cmp r0, #0x1a
	movge r0, #1
	ldmgeia sp!, {r4, pc}
_0217C7E4:
	mov r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end VikingCupStageSelectMenu__CheckShipUnlocked

	arm_func_start VikingCupStageSelectMenu__GetRecord
VikingCupStageSelectMenu__GetRecord: // 0x0217C7EC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x3c
	ldr r4, _0217C8AC // =0x0217E370
	add lr, sp, #0
	mov r5, #0
	mov ip, #0xf
_0217C804:
	ldrh r3, [r4, #0]
	ldrh r2, [r4, #2]
	add r4, r4, #4
	strh r3, [lr]
	strh r2, [lr, #2]
	add lr, lr, #4
	subs ip, ip, #1
	bne _0217C804
	add r2, sp, #0
	mov r3, r0, lsl #2
	ldrh r0, [r2, r3]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0217C898
_0217C83C: // jump table
	b _0217C84C // case 0
	b _0217C860 // case 1
	b _0217C874 // case 2
	b _0217C888 // case 3
_0217C84C:
	add r0, sp, #2
	ldrh r0, [r0, r3]
	bl SaveGame__GetVikingCupJetskiRecord
	mov r5, r0
	b _0217C898
_0217C860:
	add r0, sp, #2
	ldrh r0, [r0, r3]
	bl SaveGame__GetVikingCupSailboatRecord
	mov r5, r0
	b _0217C898
_0217C874:
	add r0, sp, #2
	ldrh r0, [r0, r3]
	bl SaveGame__GetVikingCupHovercraftRecord
	mov r5, r0
	b _0217C898
_0217C888:
	add r0, sp, #2
	ldrh r0, [r0, r3]
	bl SaveGame__GetVikingCupSubmarineRecord
	mov r5, r0
_0217C898:
	cmp r5, #0
	mvneq r5, #0
	mov r0, r5
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0217C8AC: .word 0x0217E370
	arm_func_end VikingCupStageSelectMenu__GetRecord

	arm_func_start VikingCupStageSelectMenu__Func_217C8B0
VikingCupStageSelectMenu__Func_217C8B0: // 0x0217C8B0
	ldr r0, _0217C8DC // =gameState
	ldr r0, [r0, #0xc4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #9
	movlo r0, #0
	bxlo lr
	cmp r0, #0x17
	movhi r0, #0
	subls r0, r0, #9
	bx lr
	.align 2, 0
_0217C8DC: .word gameState
	arm_func_end VikingCupStageSelectMenu__Func_217C8B0

	arm_func_start VikingCupStageSelectMenu__Func_217C8E0
VikingCupStageSelectMenu__Func_217C8E0: // 0x0217C8E0
	cmp r0, #2
	blt _0217C8F4
	cmp r0, #7
	movle r0, #0
	bxle lr
_0217C8F4:
	mov r0, #1
	bx lr
	arm_func_end VikingCupStageSelectMenu__Func_217C8E0

	arm_func_start VikingCupMenu__Create
VikingCupMenu__Create: // 0x0217C8FC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r0, #0x40
	mov r1, #0
	str r0, [sp]
	ldr r0, _0217C974 // =VikingCupMenu__Main
	mov r2, r1
	mov r3, r1
	str r1, [sp, #4]
	mov r4, #0xbc
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	bl VikingCupMenu__SetupDisplay
	mov r1, #3
	mov r2, r1
	add r0, r4, #0x10
	mov r3, #0
	bl MainMenu__LoadMenuBG
	bl LoadSysSoundVillage
	mov r0, #0
	bl PlaySysVillageTrack
	mov r0, r4
	bl VikingCupMenu__LoadAssets
	mov r0, r4
	mov r1, #0
	bl VikingCupStageSelectMenu__Create
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0217C974: .word VikingCupMenu__Main
	arm_func_end VikingCupMenu__Create

	arm_func_start VikingCupMenu__SetupDisplay
VikingCupMenu__SetupDisplay: // 0x0217C978
	stmdb sp!, {r3, r4, r5, lr}
	mov r0, #0
	bl VRAMSystem__Init
	mov r1, #0
	mov r2, r1
	mov r0, #1
	bl GX_SetGraphicsMode
	ldr r3, _0217CAA8 // =0x0400000E
	mov ip, #0x4000000
	ldrh r0, [r3, #0]
	sub r2, r3, #6
	sub r5, r3, #4
	and r0, r0, #0x43
	orr r0, r0, #0x18
	orr r0, r0, #0x4000
	strh r0, [r3]
	ldrh r0, [r2, #0]
	sub r4, r3, #2
	ldr r1, _0217CAAC // =renderCoreGFXControlA
	bic r0, r0, #3
	strh r0, [r2]
	ldrh lr, [r5]
	mov r0, #0
	mov r2, #0x10
	bic lr, lr, #3
	orr lr, lr, #1
	strh lr, [r5]
	ldrh lr, [r4]
	bic lr, lr, #3
	orr lr, lr, #2
	strh lr, [r4]
	ldrh lr, [r3]
	bic lr, lr, #3
	orr lr, lr, #3
	strh lr, [r3]
	ldr r3, [ip]
	bic r3, r3, #0x1f00
	orr r3, r3, #0x800
	str r3, [ip]
	bl MIi_CpuClear16
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r0, _0217CAB0 // =0x0400100E
	ldrh r1, [r0, #0]
	sub lr, r0, #6
	sub ip, r0, #4
	and r1, r1, #0x43
	orr r1, r1, #0x18
	orr r1, r1, #0x4000
	strh r1, [r0]
	ldrh r2, [lr]
	sub r3, r0, #2
	sub r1, r0, #0xe
	bic r2, r2, #3
	strh r2, [lr]
	ldrh r2, [ip]
	bic r2, r2, #3
	orr r2, r2, #1
	strh r2, [ip]
	ldrh r2, [r3, #0]
	bic r2, r2, #3
	orr r2, r2, #2
	strh r2, [r3]
	ldrh r2, [r0, #0]
	bic r2, r2, #3
	orr r2, r2, #3
	strh r2, [r0]
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x800
	str r0, [r1]
	ldr r1, _0217CAB4 // =renderCoreGFXControlB
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217CAA8: .word 0x0400000E
_0217CAAC: .word renderCoreGFXControlA
_0217CAB0: .word 0x0400100E
_0217CAB4: .word renderCoreGFXControlB
	arm_func_end VikingCupMenu__SetupDisplay

	arm_func_start VikingCupMenu__Main
VikingCupMenu__Main: // 0x0217CAB8
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	bl VikingCupStageSelectMenu__OptionsFinished
	cmp r0, #0
	beq _0217CB30
	mov r0, r5
	bl VikingCupStageSelectMenu__Func_217AC08
	mov r4, r0
	mov r0, r5
	bl VikingCupMenu__ReleaseAssets
	add r0, r5, #0x10
	bl MainMenu__Func_21567BC
	bl DestroyCurrentTask
	ldr r0, _0217CB3C // =0x0000FFFF
	cmp r4, r0
	beq _0217CB14
	bl ReleaseSysSound
	mov r0, r4
	bl MultibootManager__Func_2063C60
	mov r0, #1
	bl RequestSysEventChange
	b _0217CB28
_0217CB14:
	ldr r1, _0217CB40 // =gameState
	mov r2, #1
	mov r0, #0
	strb r2, [r1, #0xdc]
	bl RequestSysEventChange
_0217CB28:
	bl NextSysEvent
	ldmia sp!, {r3, r4, r5, pc}
_0217CB30:
	add r0, r5, #0x10
	bl MainMenu__HandleBackgroundControl
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217CB3C: .word 0x0000FFFF
_0217CB40: .word gameState
	arm_func_end VikingCupMenu__Main

	.data
	
aNarcDmMenuSaLz: // 0x0217EF40
	.asciz "narc/dm_menu_sa_lz7.narc"
	.align 4
	
aFntFontIplFnt_3: // 0x0217EF5C
	.asciz "fnt/font_ipl.fnt"
	.align 4
	
asc_217EF70: // 0x0217EF70
	.asciz "-'--\"--"
	.align 4
	
asc_217EF78: // 0x0217EF78
	.asciz "--------"
	.align 4

aDDDDD: // 0x0217EF84
	.asciz "%d'%d%d\"%d%d"
_0217EF91:
	.byte 0x00, 0x00, 0x00, 0x25, 0x38, 0x64, 0x00