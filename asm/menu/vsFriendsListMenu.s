	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start VSFriendListMenu__LoadAssets
VSFriendListMenu__LoadAssets: // 0x0217130C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _02171334 // =aNarcDmwfFlLz7N
	mov r1, #0
	bl ArchiveFileUnknown__LoadFile
	str r0, [r4]
	mov r0, #0
	str r0, [r4, #4]
	str r0, [r4, #8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02171334: .word aNarcDmwfFlLz7N
	arm_func_end VSFriendListMenu__LoadAssets

	arm_func_start VSFriendListMenu__ReleaseAssets
VSFriendListMenu__ReleaseAssets: // 0x02171338
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4]
	ldmia sp!, {r4, pc}
	arm_func_end VSFriendListMenu__ReleaseAssets

	arm_func_start VSFriendListMenu__Create
VSFriendListMenu__Create: // 0x0217135C
	ldr ip, _02171364 // =VSFriendListMenu__Func_2171384
	bx ip
	.align 2, 0
_02171364: .word VSFriendListMenu__Func_2171384
	arm_func_end VSFriendListMenu__Create

	arm_func_start VSFriendListMenu__Func_2171368
VSFriendListMenu__Func_2171368: // 0x02171368
	ldr r0, [r0, #4]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end VSFriendListMenu__Func_2171368

	arm_func_start VSFriendListMenu__Func_217137C
VSFriendListMenu__Func_217137C: // 0x0217137C
	ldr r0, [r0, #8]
	bx lr
	arm_func_end VSFriendListMenu__Func_217137C

	arm_func_start VSFriendListMenu__Func_2171384
VSFriendListMenu__Func_2171384: // 0x02171384
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r1, #0x10
	mov r2, #0
	str r1, [sp]
	ldr r4, _02171458 // =0x00000698
	mov r5, r0
	ldr r0, _0217145C // =VSFriendListMenu__Main
	ldr r1, _02171460 // =VSFriendListMenu__Destructor
	stmib sp, {r2, r4}
	mov r3, r2
	bl TaskCreate_
	str r0, [r5, #4]
	mov r0, #0x15
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, [r5, #4]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02171458 // =0x00000698
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	mov r0, #0
	str r0, [r4, #4]
	str r5, [r4]
	str r0, [r5, #8]
	bl SaveGame__RefreshFriendList
	ldr r1, [r4, #0]
	str r0, [r1, #8]
	bl VSMenu__GetFontWindow
	str r0, [r4, #0x30]
	bl VSMenu__GetYesNoButton
	str r0, [r4, #0x34]
	mov r0, #0
	strh r0, [r4, #8]
	strh r0, [r4, #0xa]
	str r0, [r4, #0xc]
	ldr r1, _02171464 // =0x0000FFFF
	add r0, r4, #0x100
	strh r1, [r0, #0x48]
	strh r1, [r0, #0x4a]
	mov r0, r4
	bl VSFriendListMenu__SetupDisplay
	mov r0, r4
	bl VSFriendListMenu__LoadSprites
	mov r0, r4
	bl VSFriendListMenu__InitSprites
	mov r0, r4
	bl VSFriendListMenu__InitTouchField
	mov r0, r4
	bl VSFriendListMenu__InitUnknown
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02171458: .word 0x00000698
_0217145C: .word VSFriendListMenu__Main
_02171460: .word VSFriendListMenu__Destructor
_02171464: .word 0x0000FFFF
	arm_func_end VSFriendListMenu__Func_2171384

	arm_func_start VSFriendListMenu__SetupDisplay
VSFriendListMenu__SetupDisplay: // 0x02171468
	stmdb sp!, {r3, lr}
	ldr ip, _021714E4 // =0x04001000
	mov r1, #0
	ldr r3, [ip]
	ldr r2, [ip]
	and r3, r3, #0x1f00
	mov lr, r3, lsr #8
	bic r3, r2, #0x1f00
	orr r2, lr, #0x10
	orr r2, r3, r2, lsl #8
	str r2, [ip]
	bl VSFriendListMenu__Func_2171FB0
	ldr ip, _021714E8 // =0x0400100C
	ldr r1, _021714EC // =0x0620A000
	ldrh r3, [ip]
	mov r0, #0
	mov r2, #0x20
	and r3, r3, #0x43
	orr r3, r3, #0x204
	orr r3, r3, #0x400
	strh r3, [ip]
	bl MIi_CpuClearFast
	ldr r1, _021714F0 // =0x06203000
	mov r0, #0x300
	mov r2, #0x800
	bl MIi_CpuClear16
	ldr r0, _021714F4 // =renderCoreGFXControlB
	mov r1, #0
	strh r1, [r0, #8]
	strh r1, [r0, #0xa]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021714E4: .word 0x04001000
_021714E8: .word 0x0400100C
_021714EC: .word 0x0620A000
_021714F0: .word 0x06203000
_021714F4: .word renderCoreGFXControlB
	arm_func_end VSFriendListMenu__SetupDisplay

	arm_func_start VSFriendListMenu__LoadSprites
VSFriendListMenu__LoadSprites: // 0x021714F8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	mov r1, #0
	ldr r0, [r0, #0]
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x690]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0217154C
_02171528: // jump table
	b _02171540 // case 0
	b _02171540 // case 1
	b _02171540 // case 2
	b _02171540 // case 3
	b _02171540 // case 4
	b _02171540 // case 5
_02171540:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _02171550
_0217154C:
	mov r0, #1
_02171550:
	ldr r2, [r4, #0]
	add r0, r0, #1
	mov r1, r0, lsl #0x10
	ldr r0, [r2, #0]
	mov r1, r1, lsr #0x10
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x694]
	ldmia sp!, {r4, pc}
	arm_func_end VSFriendListMenu__LoadSprites

	arm_func_start VSFriendListMenu__InitSprites
VSFriendListMenu__InitSprites: // 0x02171570
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #4
	mov r8, r0
	ldr r5, _021715F8 // =ovl03_0217E140
	ldr r4, _021715FC // =ovl03_0217E11C
	ldr r10, _02171600 // =0x0217E152
	ldr r9, _02171604 // =0x0217E12E
	add r7, r8, #0x14c
	mov r6, #0
_02171594:
	mov r3, r6, lsl #1
	ldrh r1, [r5, r3]
	ldrh r0, [r4, r3]
	ldrh r2, [r10, r3]
	str r1, [sp]
	add r0, r8, r0, lsl #2
	ldrh r3, [r9, r3]
	ldr r1, [r0, #0x690]
	mov r0, r7
	bl VSFriendListMenu__Func_21727A0
	add r6, r6, #1
	cmp r6, #9
	add r7, r7, #0x64
	blt _02171594
	ldr r0, [r8, #0x1ec]
	orr r0, r0, #4
	str r0, [r8, #0x1ec]
	ldr r0, [r8, #0x444]
	orr r0, r0, #4
	str r0, [r8, #0x444]
	ldrb r0, [r8, #0x206]
	sub r0, r0, #1
	strb r0, [r8, #0x206]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_021715F8: .word ovl03_0217E140
_021715FC: .word ovl03_0217E11C
_02171600: .word 0x0217E152
_02171604: .word 0x0217E12E
	arm_func_end VSFriendListMenu__InitSprites

	arm_func_start VSFriendListMenu__InitTouchField
VSFriendListMenu__InitTouchField: // 0x02171608
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r0
	add r0, r10, #0x38
	bl TouchField__Init
	mov r7, #0
	ldr r8, _02171694 // =ovl03_0217E184
	ldr r5, _02171698 // =TouchField__PointInRect
	ldr r4, _0217169C // =0x0000FFFF
	str r7, [r10, #0x44]
	add r9, r10, #0x4d0
	mov r6, r7
	mov r11, r7
_0217163C:
	str r6, [sp]
	mov r0, r9
	mov r1, r6
	mov r2, r5
	mov r3, r8
	str r6, [sp, #4]
	bl TouchField__InitAreaShape
	mov r1, r9
	mov r2, r4
	add r0, r10, #0x38
	bl TouchField__AddArea
	mov r0, r10
	mov r1, r7
	mov r2, r11
	bl VSFriendListMenu__Func_2172610
	add r8, r8, #8
	add r9, r9, #0x38
	add r7, r7, #1
	cmp r7, #8
	blt _0217163C
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02171694: .word ovl03_0217E184
_02171698: .word TouchField__PointInRect
_0217169C: .word 0x0000FFFF
	arm_func_end VSFriendListMenu__InitTouchField

	arm_func_start VSFriendListMenu__InitUnknown
VSFriendListMenu__InitUnknown: // 0x021716A0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r10, r0
	ldr r0, [r10, #0x30]
	bl FontWindow__GetFont
	str r0, [r10, #0x50]
	mov r0, #0x1e00
	bl _AllocHeadHEAP_USER
	str r0, [r10, #0x54]
	mov r1, r0
	mov r0, #0
	mov r2, #0x1e00
	bl MIi_CpuClearFast
	mov r7, #0
	add r9, r10, #0x58
	mov r8, #5
	mov r6, #4
	mov r11, #0x18
	mov r5, #2
	mov r4, r7
_021716F0:
	mov r0, r8, lsl #0x10
	str r6, [sp]
	mov r0, r0, lsr #0x10
	stmib sp, {r0, r11}
	mov r0, #0x600
	mul r2, r7, r0
	str r5, [sp, #0xc]
	ldr r1, [r10, #0x54]
	mov r0, r9
	add r1, r1, r2
	str r1, [sp, #0x10]
	str r4, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r1, #1
	mov r2, r5
	mov r3, r4
	bl Unknown2056570__Init
	mov r0, r9
	mov r1, #0
	bl Unknown2056570__Func_2056688
	add r7, r7, #1
	cmp r7, #5
	add r8, r8, #3
	add r9, r9, #0x30
	blt _021716F0
	ldr r0, _0217177C // =FontAnimator__Palettes+0x00000008
	ldr r1, _02171780 // =0x05000402
	mov r2, #8
	bl MIi_CpuCopy16
	ldr r0, _02171784 // =FontAnimator__Palettes
	ldr r1, _02171788 // =0x0500040A
	mov r2, #8
	bl MIi_CpuCopy16
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0217177C: .word FontAnimator__Palettes+0x00000008
_02171780: .word 0x05000402
_02171784: .word FontAnimator__Palettes
_02171788: .word 0x0500040A
	arm_func_end VSFriendListMenu__InitUnknown

	arm_func_start VSFriendListMenu__Func_217178C
VSFriendListMenu__Func_217178C: // 0x0217178C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl VSFriendListMenu__Func_2171828
	mov r0, r4
	bl VSFriendListMenu__Func_2171824
	mov r0, r4
	bl VSFriendListMenu__Func_21717E4
	mov r0, r4
	bl VSFriendListMenu__Func_21717CC
	mov r0, r4
	bl VSFriendListMenu__Func_21717C8
	ldr r0, [r4, #0]
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r4, pc}
	arm_func_end VSFriendListMenu__Func_217178C

	arm_func_start VSFriendListMenu__Func_21717C8
VSFriendListMenu__Func_21717C8: // 0x021717C8
	bx lr
	arm_func_end VSFriendListMenu__Func_21717C8

	arm_func_start VSFriendListMenu__Func_21717CC
VSFriendListMenu__Func_21717CC: // 0x021717CC
	ldr ip, _021717E0 // =MIi_CpuClear32
	add r1, r0, #0x690
	mov r0, #0
	mov r2, #8
	bx ip
	.align 2, 0
_021717E0: .word MIi_CpuClear32
	arm_func_end VSFriendListMenu__Func_21717CC

	arm_func_start VSFriendListMenu__Func_21717E4
VSFriendListMenu__Func_21717E4: // 0x021717E4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, #0
	add r7, r0, #0x14c
	mov r5, r6
	mov r4, #0x64
_021717F8:
	mov r0, r7
	bl AnimatorSprite__Release
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl MIi_CpuClear16
	add r6, r6, #1
	cmp r6, #9
	add r7, r7, #0x64
	blt _021717F8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end VSFriendListMenu__Func_21717E4

	arm_func_start VSFriendListMenu__Func_2171824
VSFriendListMenu__Func_2171824: // 0x02171824
	bx lr
	arm_func_end VSFriendListMenu__Func_2171824

	arm_func_start VSFriendListMenu__Func_2171828
VSFriendListMenu__Func_2171828: // 0x02171828
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	add r5, r6, #0x58
	mov r4, #0
_02171838:
	mov r0, r5
	bl Unknown2056570__Func_2056670
	add r4, r4, #1
	cmp r4, #5
	add r5, r5, #0x30
	blt _02171838
	ldr r0, [r6, #0x54]
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r6, #0x54]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end VSFriendListMenu__Func_2171828

	arm_func_start VSFriendListMenu__Main_217186C
VSFriendListMenu__Main_217186C: // 0x0217186C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetCurrentTaskWork_
	mov r5, #0
	mov r4, r0
	add r0, r4, #0x38
	mov r6, r5
	mov r7, r5
	bl TouchField__Process
	ldr r0, _02171BDC // =padInput
	ldrh r0, [r0, #8]
	tst r0, #0x40
	beq _021718C8
	ldrh r0, [r4, #0xa]
	cmp r0, #0
	subne r0, r0, #1
	moveq r0, #4
	strh r0, [r4, #0xa]
	mov r0, r4
	bl VSFriendListMenu__Func_2171F04
	mov r0, #2
	mov r5, #1
	bl PlaySysMenuNavSfx
	b _02171950
_021718C8:
	tst r0, #0x80
	beq _021718FC
	ldrh r0, [r4, #0xa]
	cmp r0, #4
	addlo r0, r0, #1
	movhs r0, r5
	strh r0, [r4, #0xa]
	mov r0, r4
	bl VSFriendListMenu__Func_2171F04
	mov r0, #2
	mov r5, #1
	bl PlaySysMenuNavSfx
	b _02171950
_021718FC:
	mov r8, r5
_02171900:
	mov r0, r4
	mov r1, r8
	bl VSFriendListMenu__Func_2172734
	cmp r0, #0
	beq _02171944
	ldrh r2, [r4, #0xa]
	mov r0, r8, lsl #0x10
	mov r1, r0, lsr #0x10
	cmp r2, r0, lsr #16
	beq _02171950
	mov r0, r4
	strh r1, [r4, #0xa]
	bl VSFriendListMenu__Func_2171F04
	mov r0, #2
	mov r5, #1
	bl PlaySysMenuNavSfx
	b _02171950
_02171944:
	add r8, r8, #1
	cmp r8, #5
	blt _02171900
_02171950:
	cmp r5, #0
	bne _0217199C
	ldr r0, _02171BDC // =padInput
	ldrh r0, [r0, #8]
	tst r0, #0x20
	bne _0217197C
	mov r0, r4
	mov r1, #5
	bl VSFriendListMenu__Func_2172734
	cmp r0, #0
	beq _0217199C
_0217197C:
	ldrh r0, [r4, #8]
	cmp r0, #0
	beq _0217199C
	sub r1, r0, #1
	mov r0, #2
	strh r1, [r4, #8]
	mov r5, #1
	bl PlaySysMenuNavSfx
_0217199C:
	cmp r5, #0
	bne _021719E8
	ldr r0, _02171BDC // =padInput
	ldrh r0, [r0, #8]
	tst r0, #0x10
	bne _021719C8
	mov r0, r4
	mov r1, #6
	bl VSFriendListMenu__Func_2172734
	cmp r0, #0
	beq _021719E8
_021719C8:
	ldrh r0, [r4, #8]
	cmp r0, #5
	bhs _021719E8
	add r1, r0, #1
	mov r0, #2
	strh r1, [r4, #8]
	mov r5, #1
	bl PlaySysMenuNavSfx
_021719E8:
	cmp r5, #0
	bne _02171A20
	ldr r0, _02171BDC // =padInput
	ldrh r0, [r0, #4]
	tst r0, #2
	bne _02171A10
	mov r0, r4
	bl VSFriendListMenu__Func_21725F4
	cmp r0, #0
	beq _02171A20
_02171A10:
	mov r7, #1
	mov r0, r7
	mov r5, r7
	bl PlaySysMenuNavSfx
_02171A20:
	cmp r5, #0
	bne _02171A7C
	ldr r0, _02171BDC // =padInput
	ldrh r0, [r0, #4]
	tst r0, #8
	bne _02171A4C
	mov r0, r4
	mov r1, #7
	bl VSFriendListMenu__Func_2172784
	cmp r0, #0
	beq _02171A7C
_02171A4C:
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	add r0, r0, r0, lsl #2
	add r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl VSFriendListMenu__Func_2172824
	cmp r0, #0
	beq _02171A7C
	mov r0, #0
	mov r6, #1
	bl PlaySysMenuNavSfx
_02171A7C:
	mov r0, r4
	bl VSFriendListMenu__Func_2171EEC
	mov r8, #0
	mov r5, r8
_02171A8C:
	mov r1, r8, lsl #0x10
	mov r0, r4
	mov r2, r5
	mov r3, r5
	mov r1, r1, lsr #0x10
	bl VSFriendListMenu__Func_2171F18
	add r8, r8, #1
	cmp r8, #5
	blt _02171A8C
	mov r0, r4
	mov r1, #1
	bl VSFriendListMenu__Func_2171FB0
	mov r0, r4
	bl VSFriendListMenu__Func_2172278
	ldrh r1, [r4, #0xa]
	mov r0, r4
	bl VSFriendListMenu__Func_2171F74
	mov r0, r4
	mov r1, #7
	bl VSFriendListMenu__Func_217275C
	mov r1, r0
	mov r0, r4
	bl VSFriendListMenu__Func_2172558
	mov r0, r4
	mov r1, #0
	mov r2, r1
	bl VSFriendListMenu__Func_21725A0
	mov r0, r4
	ldrh r1, [r4, #8]
	bl VSFriendListMenu__Func_2172444
	mov r0, r4
	mov r1, #0
	mov r2, r1
	bl VSFriendListMenu__Func_21724C8
	mov r0, r4
	bl VSFriendListMenu__Func_21723C8
	ldrh r0, [r4, #8]
	cmp r0, #0
	beq _02171B38
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl VSFriendListMenu__Func_21723E4
_02171B38:
	ldrh r0, [r4, #8]
	cmp r0, #5
	bhs _02171B54
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl VSFriendListMenu__Func_2172414
_02171B54:
	mov r0, r4
	mov r1, #1
	bl VSFriendListMenu__Func_21726B4
	cmp r7, #0
	cmpeq r6, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r4
	mov r1, #0
	str r6, [r4, #0xc]
	bl VSFriendListMenu__Func_2172684
	mov r0, r4
	mov r1, #0
	bl VSFriendListMenu__Func_21726B4
	mov r0, r4
	mov r1, #7
	mov r2, #0
	bl VSFriendListMenu__Func_2172610
	mov r0, r4
	mov r1, #0
	bl VSFriendListMenu__Func_21725C4
	mov r0, r4
	mov r1, #0
	bl VSFriendListMenu__Func_2171FB0
	ldr r0, _02171BE0 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	cmp r6, #0
	bne _02171BC8
	ldr r0, _02171BE0 // =0x0000FFFF
	bl VSMenu__Func_21667F0
_02171BC8:
	ldr r0, _02171BE4 // =VSFriendListMenu__Main_2171DB4
	mov r1, #0
	str r1, [r4, #4]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02171BDC: .word padInput
_02171BE0: .word 0x0000FFFF
_02171BE4: .word VSFriendListMenu__Main_2171DB4
	arm_func_end VSFriendListMenu__Main_217186C

	arm_func_start VSFriendListMenu__Main_2171BE8
VSFriendListMenu__Main_2171BE8: // 0x02171BE8
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x34]
	mov r5, #0
	bl SaveSpriteButton__RunState
	ldr r0, [r4, #0x34]
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	ldr r0, [r4, #0x34]
	beq _02171C5C
	bl SaveSpriteButton__Func_2064660
	cmp r0, #0
	bne _02171C54
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	add r0, r0, r0, lsl #2
	add r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl VSFriendListMenu__Func_217294C
	mov r2, #1
	ldr r0, [r4, #0]
	rsb r1, r2, #0x10000
	str r2, [r0, #8]
	add r0, r4, #0x100
	strh r1, [r0, #0x4a]
_02171C54:
	mov r5, #1
	b _02171C70
_02171C5C:
	bl SaveSpriteButton__Func_2064660
	cmp r0, #4
	beq _02171C70
	ldr r0, _02171C9C // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
_02171C70:
	cmp r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl VSFriendListMenu__Func_2172278
	mov r0, #0x15
	bl VSMenu__SetNetworkMessageSequence
	mov r1, #0
	ldr r0, _02171CA0 // =VSFriendListMenu__Main
	str r1, [r4, #4]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02171C9C: .word 0x0000FFFF
_02171CA0: .word VSFriendListMenu__Main
	arm_func_end VSFriendListMenu__Main_2171BE8

	arm_func_start VSFriendListMenu__Main
VSFriendListMenu__Main: // 0x02171CA4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetCurrentTaskWork_
	mov r8, r0
	bl VSFriendListMenu__Func_2171EEC
	mov r9, #0
	mov r10, r9
	mov r7, #0x2000
	mov r6, #0xc0
	mov r5, r9
	mov r4, #0xc
	mov r11, r9
_02171CD0:
	ldr r0, [r8, #4]
	sub r3, r0, r10
	cmp r3, #0
	ble _02171D34
	cmp r3, #0xc
	bge _02171D1C
	mov r0, r6
	mov r1, r5
	mov r2, r4
	str r7, [sp]
	bl Unknown2051334__Func_2051534
	mov r0, r0, lsl #0x10
	mov r1, r9, lsl #0x10
	mov r3, r0, asr #0x10
	mov r0, r8
	mov r1, r1, lsr #0x10
	mov r2, r11
	bl VSFriendListMenu__Func_2171F18
	b _02171D34
_02171D1C:
	mov r1, r9, lsl #0x10
	mov r2, #0
	mov r0, r8
	mov r3, r2
	mov r1, r1, lsr #0x10
	bl VSFriendListMenu__Func_2171F18
_02171D34:
	add r9, r9, #1
	cmp r9, #5
	add r10, r10, #3
	blt _02171CD0
	mov r0, r8
	bl VSFriendListMenu__Func_2172278
	ldr r0, [r8, #4]
	cmp r0, #0x18
	addlo r0, r0, #1
	strlo r0, [r8, #4]
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r8
	mov r1, #1
	bl VSFriendListMenu__Func_2172684
	mov r0, r8
	mov r1, #1
	bl VSFriendListMenu__Func_21726B4
	mov r0, r8
	mov r1, #7
	mov r2, #1
	bl VSFriendListMenu__Func_2172610
	mov r0, r8
	mov r1, #1
	bl VSFriendListMenu__Func_21725C4
	mov r0, r8
	bl VSFriendListMenu__Func_2171F04
	mov r1, #0
	ldr r0, _02171DB0 // =VSFriendListMenu__Main_217186C
	str r1, [r8, #4]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02171DB0: .word VSFriendListMenu__Main_217186C
	arm_func_end VSFriendListMenu__Main

	arm_func_start VSFriendListMenu__Main_2171DB4
VSFriendListMenu__Main_2171DB4: // 0x02171DB4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	mov r9, r0
	bl VSFriendListMenu__Func_2171EEC
	mov r10, #0
	mov r7, r10
	mov r6, #0xc0
	mov r5, #0xc
	mov r4, r10
	mov r8, r10
_02171DE0:
	rsb r0, r10, #4
	ldr r1, [r9, #4]
	add r0, r0, r0, lsl #1
	sub r3, r1, r0
	cmp r3, #0
	bgt _02171E14
	mov r1, r10, lsl #0x10
	mov r0, r9
	mov r2, r8
	mov r3, r8
	mov r1, r1, lsr #0x10
	bl VSFriendListMenu__Func_2171F18
	b _02171E4C
_02171E14:
	cmp r3, #0xc
	bge _02171E4C
	mov r0, r7
	mov r1, r6
	mov r2, r5
	str r7, [sp]
	bl Unknown2051334__Func_2051534
	mov r2, r0, lsl #0x10
	mov r1, r10, lsl #0x10
	mov r3, r2, asr #0x10
	mov r0, r9
	mov r1, r1, lsr #0x10
	mov r2, r4
	bl VSFriendListMenu__Func_2171F18
_02171E4C:
	add r10, r10, #1
	cmp r10, #5
	blt _02171DE0
	ldr r0, [r9, #4]
	cmp r0, #0x18
	blo _02171EC8
	ldr r0, [r9, #0xc]
	mov r1, #0
	cmp r0, #0
	beq _02171EB4
	mov r0, #0x16
	str r1, [r9, #0xc]
	bl VSMenu__SetNetworkMessageSequence
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r0, [r9, #0x34]
	mov r2, #1
	mov r3, #7
	bl SaveSpriteButton__Func_2064588
	mov r1, #0
	ldr r0, _02171ED8 // =VSFriendListMenu__Main_2171BE8
	str r1, [r9, #4]
	bl SetCurrentTaskMainEvent
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02171EB4:
	mov r0, r9
	bl VSFriendListMenu__Func_21725C4
	bl DestroyCurrentTask
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02171EC8:
	add r0, r0, #1
	str r0, [r9, #4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02171ED8: .word VSFriendListMenu__Main_2171BE8
	arm_func_end VSFriendListMenu__Main_2171DB4

	arm_func_start VSFriendListMenu__Destructor
VSFriendListMenu__Destructor: // 0x02171EDC
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl VSFriendListMenu__Func_217178C
	ldmia sp!, {r3, pc}
	arm_func_end VSFriendListMenu__Destructor

	arm_func_start VSFriendListMenu__Func_2171EEC
VSFriendListMenu__Func_2171EEC: // 0x02171EEC
	ldr ip, _02171F00 // =AnimatorSprite__ProcessAnimation
	mov r1, #0
	mov r2, r1
	add r0, r0, #0x14c
	bx ip
	.align 2, 0
_02171F00: .word AnimatorSprite__ProcessAnimation
	arm_func_end VSFriendListMenu__Func_2171EEC

	arm_func_start VSFriendListMenu__Func_2171F04
VSFriendListMenu__Func_2171F04: // 0x02171F04
	ldr ip, _02171F14 // =AnimatorSprite__SetAnimation
	add r0, r0, #0x1b0
	ldrh r1, [r0, #0xc]
	bx ip
	.align 2, 0
_02171F14: .word AnimatorSprite__SetAnimation
	arm_func_end VSFriendListMenu__Func_2171F04

	arm_func_start VSFriendListMenu__Func_2171F18
VSFriendListMenu__Func_2171F18: // 0x02171F18
	stmdb sp!, {r3, lr}
	mov ip, #0x18
	mul lr, r1, ip
	add lr, lr, #0x20
	add r0, r0, #0x14c
	add r2, r2, #0x18
	strh r2, [r0, #8]
	add r2, r3, lr
	strh r2, [r0, #0xa]
	rsb r1, r1, #5
	strb r1, [r0, #0x57]
	ldrsh r3, [r0, #8]
	cmp r3, #0x100
	ldrltsh r2, [r0, #0xa]
	cmplt r2, #0xc0
	ldmgeia sp!, {r3, pc}
	sub r1, ip, #0xe8
	cmp r3, r1
	subgt r1, ip, #0x30
	cmpgt r2, r1
	ldmleia sp!, {r3, pc}
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, pc}
	arm_func_end VSFriendListMenu__Func_2171F18

	arm_func_start VSFriendListMenu__Func_2171F74
VSFriendListMenu__Func_2171F74: // 0x02171F74
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r1
	add r4, r0, #0x1b0
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r2, #0x18
	mul r1, r5, r2
	mov r0, r4
	strh r2, [r4, #8]
	add r1, r1, #0x20
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end VSFriendListMenu__Func_2171F74

	arm_func_start VSFriendListMenu__Func_2171FB0
VSFriendListMenu__Func_2171FB0: // 0x02171FB0
	cmp r1, #0
	ldr r2, _02172004 // =0x04001000
	beq _02171FE0
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
_02171FE0:
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
	.align 2, 0
_02172004: .word 0x04001000
	arm_func_end VSFriendListMenu__Func_2171FB0

	arm_func_start VSFriendListMenu__Func_2172008
VSFriendListMenu__Func_2172008: // 0x02172008
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x48
	mov r10, r0
	mov r4, r2
	mov r5, r1
	mov r0, r4
	add r1, r10, #0x10
	bl VSFriendListMenu__Func_2172830
	mov r1, #0
	mov r0, #2
	stmia sp, {r0, r1}
	mov r0, #0x30
	str r1, [sp, #8]
	mul r8, r5, r0
	str r1, [sp, #0xc]
	str r1, [sp, #0x10]
	add r7, r10, #0x58
	ldr r0, _02172274 // =_0217EE90
	str r1, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r10, #0x10
	str r0, [sp, #0x1c]
	ldr r0, [r10, #0x50]
	mov r2, r1
	add r3, r7, r8
	bl FontFile__Func_20530D8
	mov r0, r4
	add r1, sp, #0x24
	add r2, sp, #0x22
	add r3, sp, #0x20
	bl VSFriendListMenu__Func_21728EC
	mov r0, #0x30
	bl GetFontCharacterFromUTF
	mov r4, r0, lsl #0x10
	mov r0, #0x2f
	bl GetFontCharacterFromUTF
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	mov r0, #0x2d
	bl GetFontCharacterFromUTF
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	ldrh r0, [sp, #0x24]
	cmp r0, #0
	ldreqh r1, [sp, #0x22]
	cmpeq r1, #0
	ldreqh r1, [sp, #0x20]
	cmpeq r1, #0
	bne _021720F4
	strh r2, [sp, #0x38]
	ldrh r0, [sp, #0x38]
	strh r0, [sp, #0x36]
	strh r0, [sp, #0x32]
	strh r0, [sp, #0x30]
	strh r0, [sp, #0x2c]
	strh r0, [sp, #0x2a]
	strh r0, [sp, #0x28]
	strh r0, [sp, #0x26]
	b _021721FC
_021720F4:
	mov r1, #0x3e8
	bl FX_DivS32
	strh r0, [sp, #0x26]
	ldrh r1, [sp, #0x26]
	mov r0, #0x3e8
	ldrh r2, [sp, #0x24]
	mul r0, r1, r0
	sub r0, r2, r0
	add r2, r1, r4, lsr #16
	strh r0, [sp, #0x24]
	ldrh r0, [sp, #0x24]
	mov r1, #0x64
	strh r2, [sp, #0x26]
	bl FX_DivS32
	strh r0, [sp, #0x28]
	ldrh r1, [sp, #0x28]
	mov r0, #0x64
	ldrh r2, [sp, #0x24]
	mul r0, r1, r0
	sub r0, r2, r0
	add r2, r1, r4, lsr #16
	strh r0, [sp, #0x24]
	ldrh r0, [sp, #0x24]
	mov r1, #0xa
	strh r2, [sp, #0x28]
	bl FX_DivS32
	strh r0, [sp, #0x2a]
	ldrh r2, [sp, #0x2a]
	mov r1, #0xa
	ldrh r3, [sp, #0x24]
	mul r0, r2, r1
	sub r0, r3, r0
	strh r0, [sp, #0x24]
	add r2, r2, r4, lsr #16
	ldrh r0, [sp, #0x24]
	strh r2, [sp, #0x2a]
	add r2, r0, r4, lsr #16
	ldrh r0, [sp, #0x22]
	strh r2, [sp, #0x2c]
	bl FX_DivS32
	strh r0, [sp, #0x30]
	ldrh r0, [sp, #0x30]
	mov r1, #0xa
	ldrh r3, [sp, #0x22]
	mul r2, r0, r1
	sub r2, r3, r2
	strh r2, [sp, #0x22]
	add r0, r0, r4, lsr #16
	ldrh r2, [sp, #0x22]
	strh r0, [sp, #0x30]
	ldrh r0, [sp, #0x20]
	add r2, r2, r4, lsr #16
	strh r2, [sp, #0x32]
	bl FX_DivS32
	strh r0, [sp, #0x36]
	ldrh r1, [sp, #0x36]
	mov r0, #0xa
	ldrh r2, [sp, #0x20]
	mul r0, r1, r0
	sub r0, r2, r0
	strh r0, [sp, #0x20]
	ldrh r0, [sp, #0x20]
	add r1, r1, r4, lsr #16
	strh r1, [sp, #0x36]
	add r0, r0, r4, lsr #16
	strh r0, [sp, #0x38]
_021721FC:
	strh r5, [sp, #0x34]
	ldrh r1, [sp, #0x34]
	mov r9, #0
	mov r0, #0x70
	strh r1, [sp, #0x2e]
	mov r11, #8
	mov r6, r9
	mov r5, r9
	add r4, sp, #0x26
_02172220:
	stmia sp, {r0, r5}
	cmp r9, #4
	cmpne r9, #7
	moveq r2, r6
	movne r2, r11
	cmp r2, #0
	movne r1, #1
	str r5, [sp, #8]
	moveq r1, #0
	str r5, [sp, #0xc]
	mov r0, r9, lsl #1
	str r1, [sp, #0x10]
	ldrh r1, [r4, r0]
	ldr r0, [r10, #0x50]
	add r3, r7, r8
	bl FontFile__Func_2052DD0
	add r9, r9, #1
	cmp r9, #0xa
	blt _02172220
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02172274: .word _0217EE90
	arm_func_end VSFriendListMenu__Func_2172008

	arm_func_start VSFriendListMenu__Func_2172278
VSFriendListMenu__Func_2172278: // 0x02172278
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	add r0, r4, #0x100
	ldrh r2, [r0, #0x4a]
	ldrh r1, [r4, #8]
	cmp r2, r1
	beq _021722A4
	mov r1, #0
	strh r1, [r0, #0x48]
	ldrh r1, [r4, #8]
	strh r1, [r0, #0x4a]
_021722A4:
	add r0, r4, #0x100
	ldrh r1, [r0, #0x48]
	cmp r1, #0
	bne _02172324
	add r6, r4, #0x58
	mov r5, #0
_021722BC:
	mov r0, r6
	bl Unknown2056570__Func_205683C
	add r5, r5, #1
	cmp r5, #5
	add r6, r6, #0x30
	blt _021722BC
	add r0, r4, #0x100
	ldrh r2, [r0, #0x4a]
	mov r0, r4
	mov r1, #0
	add r2, r2, r2, lsl #2
	mov r2, r2, lsl #0x10
	mov r5, r2, lsr #0x10
	mov r2, r5
	bl VSFriendListMenu__Func_2172008
	add r0, r5, #1
	mov r1, r0, lsl #0x10
	mov r2, r1, lsr #0x10
	mov r0, r4
	mov r1, #1
	bl VSFriendListMenu__Func_2172008
	add r0, r4, #0x100
	ldrh r1, [r0, #0x48]
	add r1, r1, #1
	strh r1, [r0, #0x48]
	ldmia sp!, {r4, r5, r6, pc}
_02172324:
	cmp r1, #1
	ldmneia sp!, {r4, r5, r6, pc}
	ldrh r0, [r0, #0x4a]
	mov r1, #2
	add ip, r1, #1
	add r0, r0, r0, lsl #2
	add r0, r0, #2
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	add r0, r2, #1
	mov r3, r0, lsl #0x10
	mov ip, ip, lsl #0x10
	mov r0, r4
	mov r6, r3, lsr #0x10
	mov r5, ip, lsr #0x10
	bl VSFriendListMenu__Func_2172008
	mov r0, r4
	mov r1, r5
	mov r2, r6
	bl VSFriendListMenu__Func_2172008
	add r1, r5, #1
	add r0, r6, #1
	mov r2, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
	bl VSFriendListMenu__Func_2172008
	add r5, r4, #0x58
	mov r6, #0
_0217239C:
	mov r0, r5
	bl Unknown2056570__Func_2056B8C
	add r6, r6, #1
	cmp r6, #5
	add r5, r5, #0x30
	blt _0217239C
	add r0, r4, #0x100
	ldrh r1, [r0, #0x48]
	add r1, r1, #1
	strh r1, [r0, #0x48]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end VSFriendListMenu__Func_2172278

	arm_func_start VSFriendListMenu__Func_21723C8
VSFriendListMenu__Func_21723C8: // 0x021723C8
	ldr ip, _021723E0 // =AnimatorSprite__ProcessAnimation
	add r0, r0, #8
	mov r1, #0
	mov r2, r1
	add r0, r0, #0x400
	bx ip
	.align 2, 0
_021723E0: .word AnimatorSprite__ProcessAnimation
	arm_func_end VSFriendListMenu__Func_21723C8

	arm_func_start VSFriendListMenu__Func_21723E4
VSFriendListMenu__Func_21723E4: // 0x021723E4
	add r0, r0, #8
	add r0, r0, #0x400
	ldr r3, [r0, #0x3c]
	add r1, r1, #0x16
	bic r3, r3, #0x80
	str r3, [r0, #0x3c]
	strh r1, [r0, #8]
	add r1, r2, #0x60
	ldr ip, _02172410 // =AnimatorSprite__DrawFrame
	strh r1, [r0, #0xa]
	bx ip
	.align 2, 0
_02172410: .word AnimatorSprite__DrawFrame
	arm_func_end VSFriendListMenu__Func_21723E4

	arm_func_start VSFriendListMenu__Func_2172414
VSFriendListMenu__Func_2172414: // 0x02172414
	add r0, r0, #8
	add r0, r0, #0x400
	ldr r3, [r0, #0x3c]
	add r1, r1, #0xea
	orr r3, r3, #0x80
	str r3, [r0, #0x3c]
	strh r1, [r0, #8]
	add r1, r2, #0x60
	ldr ip, _02172440 // =AnimatorSprite__DrawFrame
	strh r1, [r0, #0xa]
	bx ip
	.align 2, 0
_02172440: .word AnimatorSprite__DrawFrame
	arm_func_end VSFriendListMenu__Func_2172414

	arm_func_start VSFriendListMenu__Func_2172444
VSFriendListMenu__Func_2172444: // 0x02172444
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r1, #0
	mov r2, r1
	add r0, r6, #0x214
	add r4, r6, #0x278
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	mov r2, r1
	add r0, r6, #0x2dc
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	mov r2, r1
	add r0, r6, #0x340
	bl AnimatorSprite__ProcessAnimation
	add r0, r6, #0x3a4
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r5, #0x1b
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	ldrh r2, [r4, #0xc]
	cmp r2, r0, lsr #16
	beq _021724B4
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_021724B4:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end VSFriendListMenu__Func_2172444

	arm_func_start VSFriendListMenu__Func_21724C8
VSFriendListMenu__Func_21724C8: // 0x021724C8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	add r3, r0, #0x214
	add lr, r1, #0xc8
	add r4, r2, #0x19
	mov ip, r4, lsl #0x10
	strh lr, [r3, #8]
	add r2, r2, #0x18
	strh r2, [r3, #0xa]
	add r4, r0, #0x278
	add r2, r1, #0xd3
	strh r2, [r4, #8]
	mov ip, ip, asr #0x10
	strh ip, [r4, #0xa]
	add r5, r0, #0x2dc
	add r2, r1, #0xdc
	strh r2, [r5, #8]
	strh ip, [r5, #0xa]
	add r6, r0, #0x340
	add r2, r1, #0xd8
	strh r2, [r6, #8]
	add r7, r0, #0x3a4
	strh ip, [r6, #0xa]
	add r0, r1, #0xcb
	strh r0, [r7, #8]
	mov r0, r3
	strh ip, [r7, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	mov r0, r7
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end VSFriendListMenu__Func_21724C8

	arm_func_start VSFriendListMenu__Func_2172558
VSFriendListMenu__Func_2172558: // 0x02172558
	stmdb sp!, {r4, lr}
	add r0, r0, #0x6c
	add r4, r0, #0x400
	cmp r1, #0
	movne r0, #1
	moveq r0, #0
	mov r0, r0, lsl #0x10
	ldrh r2, [r4, #0xc]
	mov r1, r0, lsr #0x10
	cmp r2, r0, lsr #16
	beq _0217258C
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_0217258C:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldmia sp!, {r4, pc}
	arm_func_end VSFriendListMenu__Func_2172558

	arm_func_start VSFriendListMenu__Func_21725A0
VSFriendListMenu__Func_21725A0: // 0x021725A0
	add r0, r0, #0x6c
	add r0, r0, #0x400
	add r1, r1, #0x78
	strh r1, [r0, #8]
	add r1, r2, #0xa0
	ldr ip, _021725C0 // =AnimatorSprite__DrawFrame
	strh r1, [r0, #0xa]
	bx ip
	.align 2, 0
_021725C0: .word AnimatorSprite__DrawFrame
	arm_func_end VSFriendListMenu__Func_21725A0

	arm_func_start VSFriendListMenu__Func_21725C4
VSFriendListMenu__Func_21725C4: // 0x021725C4
	stmdb sp!, {r3, lr}
	cmp r1, #0
	beq _021725E0
	ldr r0, _021725F0 // =VSFriendListMenu__Func_217260C
	mov r1, #0
	bl VSMenu__SetTouchCallback
	ldmia sp!, {r3, pc}
_021725E0:
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	ldmia sp!, {r3, pc}
	.align 2, 0
_021725F0: .word VSFriendListMenu__Func_217260C
	arm_func_end VSFriendListMenu__Func_21725C4

	arm_func_start VSFriendListMenu__Func_21725F4
VSFriendListMenu__Func_21725F4: // 0x021725F4
	stmdb sp!, {r3, lr}
	bl VSMenu__GetUnknownTouchResponseFlags
	tst r0, #0x40000
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end VSFriendListMenu__Func_21725F4

	arm_func_start VSFriendListMenu__Func_217260C
VSFriendListMenu__Func_217260C: // 0x0217260C
	bx lr
	arm_func_end VSFriendListMenu__Func_217260C

	arm_func_start VSFriendListMenu__Func_2172610
VSFriendListMenu__Func_2172610: // 0x02172610
	stmdb sp!, {r3, r4, r5, lr}
	cmp r2, #0
	mov r2, #0x38
	beq _02172650
	mul r3, r1, r2
	add r1, r0, #0xe4
	add r2, r1, #0x400
	ldr r1, [r2, r3]
	tst r1, #0x40
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r0, #0x4d0
	bic r1, r1, #0x40
	add r0, r0, r3
	str r1, [r2, r3]
	bl TouchField__ResetArea
	ldmia sp!, {r3, r4, r5, pc}
_02172650:
	mul r5, r1, r2
	add r1, r0, #0xe4
	add r4, r1, #0x400
	ldr r1, [r4, r5]
	tst r1, #0x40
	ldmneia sp!, {r3, r4, r5, pc}
	add r0, r0, #0x4d0
	add r0, r0, r5
	bl TouchField__ResetArea
	ldr r0, [r4, r5]
	orr r0, r0, #0x40
	str r0, [r4, r5]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end VSFriendListMenu__Func_2172610

	arm_func_start VSFriendListMenu__Func_2172684
VSFriendListMenu__Func_2172684: // 0x02172684
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, #0
_02172694:
	mov r0, r6
	mov r1, r4
	mov r2, r5
	bl VSFriendListMenu__Func_2172610
	add r4, r4, #1
	cmp r4, #5
	blt _02172694
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end VSFriendListMenu__Func_2172684

	arm_func_start VSFriendListMenu__Func_21726B4
VSFriendListMenu__Func_21726B4: // 0x021726B4
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r1, #0
	beq _02172714
	ldrh r1, [r4, #8]
	cmp r1, #0
	mov r1, #5
	beq _021726E0
	mov r2, #1
	bl VSFriendListMenu__Func_2172610
	b _021726E8
_021726E0:
	mov r2, #0
	bl VSFriendListMenu__Func_2172610
_021726E8:
	ldrh r0, [r4, #8]
	mov r1, #6
	cmp r0, #5
	mov r0, r4
	bhs _02172708
	mov r2, #1
	bl VSFriendListMenu__Func_2172610
	ldmia sp!, {r4, pc}
_02172708:
	mov r2, #0
	bl VSFriendListMenu__Func_2172610
	ldmia sp!, {r4, pc}
_02172714:
	mov r1, #5
	mov r2, #0
	bl VSFriendListMenu__Func_2172610
	mov r0, r4
	mov r1, #6
	mov r2, #0
	bl VSFriendListMenu__Func_2172610
	ldmia sp!, {r4, pc}
	arm_func_end VSFriendListMenu__Func_21726B4

	arm_func_start VSFriendListMenu__Func_2172734
VSFriendListMenu__Func_2172734: // 0x02172734
	mov r2, #0x38
	mla r0, r1, r2, r0
	ldr r0, [r0, #0x4e4]
	tst r0, #0x800
	bne _02172754
	tst r0, #0x10000
	movne r0, #1
	bxne lr
_02172754:
	mov r0, #0
	bx lr
	arm_func_end VSFriendListMenu__Func_2172734

	arm_func_start VSFriendListMenu__Func_217275C
VSFriendListMenu__Func_217275C: // 0x0217275C
	mov r2, #0x38
	mla r0, r1, r2, r0
	ldr r0, [r0, #0x4e4]
	tst r0, #0x800
	bne _0217277C
	tst r0, #0x10
	movne r0, #1
	bxne lr
_0217277C:
	mov r0, #0
	bx lr
	arm_func_end VSFriendListMenu__Func_217275C

	arm_func_start VSFriendListMenu__Func_2172784
VSFriendListMenu__Func_2172784: // 0x02172784
	mov r2, #0x38
	mla r0, r1, r2, r0
	ldr r0, [r0, #0x4e4]
	tst r0, #0x40000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end VSFriendListMenu__Func_2172784

	arm_func_start VSFriendListMenu__Func_21727A0
VSFriendListMenu__Func_21727A0: // 0x021727A0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x1c
	mov r7, r1
	mov r6, r2
	mov r4, r0
	mov r0, r7
	mov r1, r6
	mov r5, r3
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r1, r7
	mov r2, r6
	mov r3, #1
	str r3, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr ip, _02172820 // =0x05000600
	mov r0, #3
	str ip, [sp, #0x10]
	str r0, [sp, #0x14]
	ldrh ip, [sp, #0x30]
	mov r0, r4
	and ip, ip, #0xff
	str ip, [sp, #0x18]
	bl AnimatorSprite__Init
	strh r5, [r4, #0x50]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02172820: .word 0x05000600
	arm_func_end VSFriendListMenu__Func_21727A0

	arm_func_start VSFriendListMenu__Func_2172824
VSFriendListMenu__Func_2172824: // 0x02172824
	ldr ip, _0217282C // =SaveGame__IsValidFriend
	bx ip
	.align 2, 0
_0217282C: .word SaveGame__IsValidFriend
	arm_func_end VSFriendListMenu__Func_2172824

	arm_func_start VSFriendListMenu__Func_2172830
VSFriendListMenu__Func_2172830: // 0x02172830
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r5, r0
	mov r4, r1
	bl VSFriendListMenu__Func_2172824
	cmp r0, #0
	bne _02172864
	ldr r0, _021728E8 // =asc_217E164
	mov r1, r4
	mov r2, #0x20
	bl MIi_CpuCopy16
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
_02172864:
	mov r0, r5
	bl SaveGame__IsFriendNameAString
	cmp r0, #0
	mov r0, r5
	beq _02172898
	bl SaveGame__GetFriendName
	mov r1, r4
	mov r2, #0x10
	bl MIi_CpuCopy16
	mov r0, #0
	add sp, sp, #0x10
	strh r0, [r4, #0x10]
	ldmia sp!, {r3, r4, r5, pc}
_02172898:
	bl SaveGame__GetFriendKeyFromName
	mov r3, r0
	mov r2, r1
	add r0, sp, #0
	mov r1, r3
	bl DWC_Acc_FriendKeyToNumericKey
	add r3, sp, #0
	mov r2, #0
_021728B8:
	ldrsb r1, [r3], #1
	mov r0, r2, lsl #1
	add r2, r2, #1
	strh r1, [r4, r0]
	cmp r2, #0xc
	blt _021728B8
	add r1, r4, #0x18
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear16
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021728E8: .word asc_217E164
	arm_func_end VSFriendListMenu__Func_2172830

	arm_func_start VSFriendListMenu__Func_21728EC
VSFriendListMenu__Func_21728EC: // 0x021728EC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl VSFriendListMenu__Func_2172824
	cmp r0, #0
	bne _02172920
	mov r0, #0
	strh r0, [r4]
	strh r0, [r5]
	strh r0, [r6]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02172920:
	mov r0, r7
	bl SaveGame__GetFriendAddedYear
	add r1, r0, #0x7d0
	mov r0, r7
	strh r1, [r6]
	bl SaveGame__GetFriendAddedMonth
	strh r0, [r5]
	mov r0, r7
	bl SaveGame__GetFriendAddedDay
	strh r0, [r4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end VSFriendListMenu__Func_21728EC

	arm_func_start VSFriendListMenu__Func_217294C
VSFriendListMenu__Func_217294C: // 0x0217294C
	ldr ip, _02172954 // =SaveGame__DeleteFriend
	bx ip
	.align 2, 0
_02172954: .word SaveGame__DeleteFriend
	arm_func_end VSFriendListMenu__Func_217294C
	
	.data

aNarcDmwfFlLz7N: // 0x0217EE78
	.asciz "narc/dmwf_fl_lz7.narc"
	.align 4
	
_0217EE90: // 0x0217EE90
	.byte 0x25, 0x00, 0x73, 0x00, 0x00, 0x00, 0x00, 0x00
	.align 4
