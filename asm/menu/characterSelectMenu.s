	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public CharacterSelectMenu__Singleton
CharacterSelectMenu__Singleton: // 0x0217EFD0
	.space 0x04 // Task*

	.text

	thumb_func_start CharacterSelectMenu__LoadAssets
CharacterSelectMenu__LoadAssets: // 0x0215FB04
	push {r3, r4, lr}
	sub sp, #4
	mov r0, #0x1c
	blx _AllocHeadHEAP_SYSTEM
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x1c
	blx MIi_CpuClear16
	mov r2, #0
	ldr r0, _0215FB8C // =aBbDmcsLangBb
	str r2, [sp]
	mov r1, #6
	mov r3, #1
	blx ArchiveFile__Load
	str r0, [r4]
	mov r2, #0
	ldr r0, _0215FB90 // =aBbNlBb_2
	str r2, [sp]
	mov r1, #1
	mov r3, r2
	blx ArchiveFile__Load
	str r0, [r4, #4]
	mov r2, #0
	ldr r0, _0215FB90 // =aBbNlBb_2
	str r2, [sp]
	mov r1, #9
	mov r3, r2
	blx ArchiveFile__Load
	str r0, [r4, #8]
	blx RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	bhi _0215FB74
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215FB60: // jump table
	.hword _0215FB6C - _0215FB60 - 2 // case 0
	.hword _0215FB6C - _0215FB60 - 2 // case 1
	.hword _0215FB6C - _0215FB60 - 2 // case 2
	.hword _0215FB6C - _0215FB60 - 2 // case 3
	.hword _0215FB6C - _0215FB60 - 2 // case 4
	.hword _0215FB6C - _0215FB60 - 2 // case 5
_0215FB6C:
	blx RenderCore_GetLanguagePtr
	ldrb r1, [r0]
	b _0215FB76
_0215FB74:
	mov r1, #1
_0215FB76:
	mov r2, #0
	ldr r0, _0215FB8C // =aBbDmcsLangBb
	mov r3, r2
	str r2, [sp]
	blx ArchiveFile__Load
	str r0, [r4, #0xc]
	mov r0, r4
	add sp, #4
	pop {r3, r4, pc}
	nop
_0215FB8C: .word aBbDmcsLangBb
_0215FB90: .word aBbNlBb_2
	thumb_func_end CharacterSelectMenu__LoadAssets

	thumb_func_start CharacterSelectMenu__ReleaseAssets
CharacterSelectMenu__ReleaseAssets: // 0x0215FB94
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	mov r5, r7
	mov r0, #0x10
	beq _0215FBB0
	mov r4, r7
	mov r6, #0
	add r4, #0x10
_0215FBA4:
	ldr r0, [r5]
	blx _FreeHEAP_USER
	stmia r5!, {r6}
	cmp r5, r4
	bne _0215FBA4
_0215FBB0:
	mov r0, r7
	blx _FreeHEAP_SYSTEM
	pop {r3, r4, r5, r6, r7, pc}
	thumb_func_end CharacterSelectMenu__ReleaseAssets

	thumb_func_start CharacterSelectMenu__Create
CharacterSelectMenu__Create: // 0x0215FBB8
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	ldr r0, _0215FC04 // =0x00003002
	mov r7, r2
	str r0, [sp]
	mov r2, #0
	mov r6, r1
	ldr r0, _0215FC08 // =0x0000041C
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215FC0C // =CharacterSelectMenu__Main
	ldr r1, _0215FC10 // =CharacterSelectMenu__Destructor
	mov r3, r2
	blx TaskCreate_
	ldr r1, _0215FC14 // =CharacterSelectMenu__Singleton
	str r0, [r1]
	mov r0, #0
	str r0, [r5, #0x10]
	ldr r0, [r1]
	blx GetTaskWork_
	mov r4, r0
	ldr r2, _0215FC08 // =0x0000041C
	mov r0, #0
	mov r1, r4
	blx MIi_CpuClear16
	mov r0, #0xfd
	str r5, [r4]
	lsl r0, r0, #2
	str r6, [r4, r0]
	add r0, #0x20
	strh r7, [r4, r0]
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_0215FC04: .word 0x00003002
_0215FC08: .word 0x0000041C
_0215FC0C: .word CharacterSelectMenu__Main
_0215FC10: .word CharacterSelectMenu__Destructor
_0215FC14: .word CharacterSelectMenu__Singleton
	thumb_func_end CharacterSelectMenu__Create

	thumb_func_start CharacterSelectMenu__Func_215FC18
CharacterSelectMenu__Func_215FC18: // 0x0215FC18
	push {r3, lr}
	bl CharacterSelectMenu__Func_215FC2C
	cmp r0, #0
	beq _0215FC26
	mov r0, #1
	pop {r3, pc}
_0215FC26:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
	thumb_func_end CharacterSelectMenu__Func_215FC18

	thumb_func_start CharacterSelectMenu__Func_215FC2C
CharacterSelectMenu__Func_215FC2C: // 0x0215FC2C
	ldr r0, [r0, #0x10]
	bx lr
	thumb_func_end CharacterSelectMenu__Func_215FC2C

	thumb_func_start CharacterSelect__Func_215FC30
CharacterSelect__Func_215FC30: // 0x0215FC30
	str r1, [r0, #0x14]
	str r2, [r0, #0x18]
	bx lr
	.align 2, 0
	thumb_func_end CharacterSelect__Func_215FC30

	thumb_func_start CharacterSelectMenu__Destructor
CharacterSelectMenu__Destructor: // 0x0215FC38
	push {r4, r5, r6, lr}
	blx GetTaskWork_
	mov r6, r0
	add r0, #0x4c
	blx AnimatorSprite__Release
	mov r0, r6
	add r0, #0xb0
	blx AnimatorSprite__Release
	mov r0, #0x45
	lsl r0, r0, #2
	mov r4, #0
	add r5, r6, r0
_0215FC56:
	mov r0, r5
	blx AnimatorSprite__Release
	add r4, r4, #1
	add r5, #0x64
	cmp r4, #2
	blo _0215FC56
	mov r0, #0x77
	lsl r0, r0, #2
	mov r5, #0
	add r4, r6, r0
_0215FC6C:
	mov r0, r4
	add r0, #0x38
	blx AnimatorSprite__Release
	add r5, r5, #1
	add r4, #0x9c
	cmp r5, #2
	blo _0215FC6C
	mov r0, #0xd3
	lsl r0, r0, #2
	add r0, r6, r0
	blx AnimatorSprite__Release
	mov r0, #0x3b
	lsl r0, r0, #4
	mov r4, #0
	add r5, r6, r0
_0215FC8E:
	mov r0, r5
	blx ReleasePaletteAnimator
	add r4, r4, #1
	add r5, #0x20
	cmp r4, #2
	blo _0215FC8E
	ldr r0, _0215FCA4 // =CharacterSelectMenu__Singleton
	mov r1, #0
	str r1, [r0]
	pop {r4, r5, r6, pc}
	.align 2, 0
_0215FCA4: .word CharacterSelectMenu__Singleton
	thumb_func_end CharacterSelectMenu__Destructor

	thumb_func_start CharacterSelectMenu__Func_215FCA8
CharacterSelectMenu__Func_215FCA8: // 0x0215FCA8
	push {r3, r4, r5, lr}
	ldr r0, _0215FCF0 // =CharacterSelectMenu__Singleton
	mov r4, r1
	ldr r0, [r0]
	blx GetTaskWork_
	mov r1, r0
	add r1, #0xec
	ldr r3, [r1]
	mov r2, #1
	mov r1, r0
	bic r3, r2
	add r1, #0xec
	str r3, [r1]
	ldr r3, _0215FCF4 // =0x00000414
	mov r1, #0x80
	ldrh r5, [r0, r3]
	tst r1, r5
	bne _0215FCDA
	mov r1, r3
	sub r1, #0x8c
	ldr r1, [r0, r1]
	sub r3, #0x8c
	bic r1, r2
	str r1, [r0, r3]
_0215FCDA:
	ldr r2, _0215FCF8 // =0x00000555
	ldr r1, _0215FCFC // =0x00000418
	strh r2, [r0, r1]
	mov r0, #0
	bl CharacterSelectMenu__Func_21600D4
	ldr r1, _0215FD00 // =Task__OVL03Unknown2160760__Create
	mov r0, r4
	blx SetTaskMainEvent
	pop {r3, r4, r5, pc}
	.align 2, 0
_0215FCF0: .word CharacterSelectMenu__Singleton
_0215FCF4: .word 0x00000414
_0215FCF8: .word 0x00000555
_0215FCFC: .word 0x00000418
_0215FD00: .word Task__OVL03Unknown2160760__Create
	thumb_func_end CharacterSelectMenu__Func_215FCA8

	thumb_func_start CharacterSelectMenu__Func_215FD04
CharacterSelectMenu__Func_215FD04: // 0x0215FD04
	ldr r3, _0215FD0C // =SetTaskMainEvent
	mov r0, r1
	ldr r1, _0215FD10 // =CharacterSelectMenu__Func_21609F0
	bx r3
	.align 2, 0
_0215FD0C: .word SetTaskMainEvent
_0215FD10: .word CharacterSelectMenu__Func_21609F0
	thumb_func_end CharacterSelectMenu__Func_215FD04

	thumb_func_start CharacterSelectMenu__Func_215FD14
CharacterSelectMenu__Func_215FD14: // 0x0215FD14
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _0215FD8C // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	mov r2, #0x3f
	mov r4, r0
	lsl r2, r2, #4
	str r5, [r4, r2]
	cmp r5, #1
	beq _0215FD32
	cmp r5, #2
	beq _0215FD56
	pop {r3, r4, r5, pc}
_0215FD32:
	mov r0, #0
	add r2, #0x20
	str r0, [r4, r2]
	ldr r0, _0215FD90 // =CharacterSelectMenu__Func_21609B0
	blx SetCurrentTaskMainEvent
	mov r0, #0
	blx PlaySysMenuNavSfx
	ldr r2, [r4]
	ldr r3, [r2, #0x14]
	cmp r3, #0
	beq _0215FD8A
	mov r0, #0
	ldr r2, [r2, #0x18]
	mov r1, r0
	blx r3
	pop {r3, r4, r5, pc}
_0215FD56:
	add r0, #0xec
	ldr r1, [r0]
	mov r0, #1
	mov r3, r1
	mov r1, r4
	orr r3, r0
	add r1, #0xec
	str r3, [r1]
	mov r1, r2
	sub r1, #0x68
	ldr r1, [r4, r1]
	sub r2, #0x68
	orr r1, r0
	str r1, [r4, r2]
	blx PlaySysMenuNavSfx
	ldr r2, [r4]
	ldr r3, [r2, #0x14]
	cmp r3, #0
	beq _0215FD86
	ldr r2, [r2, #0x18]
	mov r0, #1
	mov r1, #0
	blx r3
_0215FD86:
	bl CharacterSelectMenu__Func_215FD94
_0215FD8A:
	pop {r3, r4, r5, pc}
	.align 2, 0
_0215FD8C: .word CharacterSelectMenu__Singleton
_0215FD90: .word CharacterSelectMenu__Func_21609B0
	thumb_func_end CharacterSelectMenu__Func_215FD14

	thumb_func_start CharacterSelectMenu__Func_215FD94
CharacterSelectMenu__Func_215FD94: // 0x0215FD94
	push {r3, r4, r5, lr}
	ldr r0, _0215FE7C // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	mov r5, r0
	mov r0, #0x3f
	lsl r0, r0, #4
	ldr r1, [r5, r0]
	mov r4, #0
	cmp r1, #1
	beq _0215FDB2
	cmp r1, #2
	beq _0215FE0A
	b _0215FE60
_0215FDB2:
	add r0, #0x24
	ldrh r1, [r5, r0]
	mov r0, #6
	tst r0, r1
	beq _0215FE60
	mov r0, #0x20
	tst r0, r1
	beq _0215FDC6
	mov r0, #5
	b _0215FDC8
_0215FDC6:
	mov r0, #4
_0215FDC8:
	lsl r0, r0, #0x10
	mov r1, #1
	lsr r0, r0, #0x10
	lsl r1, r1, #0xc
	blx CreateDrawFadeTask
	mov r4, r0
	ldr r0, _0215FE80 // =0x00000414
	ldrh r2, [r5, r0]
	mov r0, #2
	mov r3, r2
	and r3, r0
	beq _0215FDF0
	mov r0, #4
	mov r1, r2
	tst r1, r0
	bne _0215FDF0
	add r0, #0xfc
	strh r0, [r4, #8]
	b _0215FE60
_0215FDF0:
	cmp r3, #0
	bne _0215FE02
	mov r0, #4
	mov r1, r2
	tst r1, r0
	beq _0215FE02
	lsl r0, r0, #7
	strh r0, [r4, #8]
	b _0215FE60
_0215FE02:
	mov r0, #0xc
	blx FadeSysTrack
	b _0215FE60
_0215FE0A:
	add r0, #0x24
	ldrh r1, [r5, r0]
	mov r0, #0x18
	tst r0, r1
	beq _0215FE60
	mov r0, #0x40
	tst r0, r1
	beq _0215FE1E
	mov r0, #5
	b _0215FE20
_0215FE1E:
	mov r0, #4
_0215FE20:
	lsl r0, r0, #0x10
	mov r1, #1
	lsr r0, r0, #0x10
	lsl r1, r1, #0xc
	blx CreateDrawFadeTask
	mov r4, r0
	ldr r0, _0215FE80 // =0x00000414
	ldrh r2, [r5, r0]
	mov r0, #8
	mov r3, r2
	and r3, r0
	beq _0215FE48
	mov r0, #0x10
	mov r1, r2
	tst r1, r0
	bne _0215FE48
	add r0, #0xf0
	strh r0, [r4, #8]
	b _0215FE60
_0215FE48:
	cmp r3, #0
	bne _0215FE5A
	mov r0, #0x10
	mov r1, r2
	tst r1, r0
	beq _0215FE5A
	lsl r0, r0, #5
	strh r0, [r4, #8]
	b _0215FE60
_0215FE5A:
	mov r0, #0xc
	blx FadeSysTrack
_0215FE60:
	cmp r4, #0
	beq _0215FE6C
	ldr r0, _0215FE84 // =CharacterSelectMenu__Func_21609D4
	blx SetCurrentTaskMainEvent
	pop {r3, r4, r5, pc}
_0215FE6C:
	blx GetCurrentTask
	bl CharacterSelectMenu__Func_215FF44
	mov r0, #0
	blx SetCurrentTaskMainEvent
	pop {r3, r4, r5, pc}
	.align 2, 0
_0215FE7C: .word CharacterSelectMenu__Singleton
_0215FE80: .word 0x00000414
_0215FE84: .word CharacterSelectMenu__Func_21609D4
	thumb_func_end CharacterSelectMenu__Func_215FD94

	thumb_func_start Task__Unknown21606EC__Func_215FE88
Task__Unknown21606EC__Func_215FE88: // 0x0215FE88
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	str r0, [sp, #0x14]
	ldr r0, _0215FF34 // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	mov r3, #0
	mov r7, r0
	str r3, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	lsl r0, r0, #9
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	mov r0, #0xfd
	str r3, [sp, #0x10]
	lsl r0, r0, #2
	ldr r0, [r7, r0]
	lsl r1, r0, #2
	ldr r0, _0215FF38 // =VRAMSystem__GFXControl
	ldr r0, [r0, r1]
	mov r1, #2
	mov r2, r1
	add r0, #0xa
	sub r2, #0xc2
	bl Task__OVL03Unknown216016C__Create
	mov r1, #0
	str r1, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	lsl r0, r0, #9
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, r7
	str r1, [sp, #0x10]
	add r0, #0x56
	mov r1, #2
	mov r2, #0xe0
	mov r3, #0x20
	bl Task__OVL03Unknown216016C__Create
	mov r0, #0x77
	mov r4, #0
	lsl r0, r0, #2
	add r5, r7, r0
	mov r6, r4
_0215FEE8:
	str r6, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	lsl r0, r0, #9
	str r0, [sp, #8]
	mov r0, r5
	str r6, [sp, #0xc]
	add r0, #0x42
	mov r1, #2
	mov r2, #0xc0
	mov r3, r6
	str r6, [sp, #0x10]
	bl Task__OVL03Unknown216016C__Create
	add r4, r4, #1
	add r5, #0x9c
	cmp r4, #2
	blo _0215FEE8
	mov r0, #0
	str r0, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	lsl r0, r0, #9
	str r0, [sp, #8]
	ldr r0, _0215FF3C // =CharacterSelectMenu__Func_215FCA8
	mov r2, #0xb0
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x14]
	mov r1, #2
	str r0, [sp, #0x10]
	ldr r0, _0215FF40 // =0x00000356
	mov r3, r2
	add r0, r7, r0
	bl Task__OVL03Unknown216016C__Create
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215FF34: .word CharacterSelectMenu__Singleton
_0215FF38: .word VRAMSystem__GFXControl
_0215FF3C: .word CharacterSelectMenu__Func_215FCA8
_0215FF40: .word 0x00000356
	thumb_func_end Task__Unknown21606EC__Func_215FE88

	thumb_func_start CharacterSelectMenu__Func_215FF44
CharacterSelectMenu__Func_215FF44: // 0x0215FF44
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	str r0, [sp, #0x14]
	ldr r0, _02160004 // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	mov r1, #0
	mov r7, r0
	mov r2, #0xb0
	str r1, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	str r1, [sp, #8]
	ldr r0, _02160008 // =0x00000356
	str r1, [sp, #0xc]
	str r1, [sp, #0x10]
	add r0, r7, r0
	mov r1, #2
	mov r3, r2
	bl Task__OVL03Unknown216016C__Create
	mov r0, #0x77
	mov r4, #0
	lsl r0, r0, #2
	add r5, r7, r0
	mov r6, r4
_0215FF7A:
	mov r0, #4
	str r0, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	str r6, [sp, #8]
	mov r0, r5
	str r6, [sp, #0xc]
	add r0, #0x42
	mov r1, #2
	mov r2, r6
	mov r3, #0xc0
	str r6, [sp, #0x10]
	bl Task__OVL03Unknown216016C__Create
	add r4, r4, #1
	add r5, #0x9c
	cmp r4, #2
	blo _0215FF7A
	mov r1, #4
	str r1, [sp]
	mov r1, #0x10
	str r1, [sp, #4]
	mov r1, #0
	mov r0, r7
	str r1, [sp, #8]
	add r0, #0x4c
	str r1, [sp, #0xc]
	str r1, [sp, #0x10]
	add r0, #0xa
	mov r1, #2
	mov r2, #0x20
	mov r3, #0xe0
	bl Task__OVL03Unknown216016C__Create
	mov r0, #4
	str r0, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	mov r2, #0
	ldr r0, _0216000C // =CharacterSelectMenu__Func_215FD04
	str r2, [sp, #8]
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x14]
	str r0, [sp, #0x10]
	mov r0, #0xfd
	lsl r0, r0, #2
	ldr r0, [r7, r0]
	lsl r1, r0, #2
	ldr r0, _02160010 // =VRAMSystem__GFXControl
	ldr r0, [r0, r1]
	mov r1, #2
	mov r3, r1
	add r0, #0xa
	sub r3, #0xc2
	bl Task__OVL03Unknown216016C__Create
	mov r2, r7
	add r2, #0xb0
	ldr r1, [r2, #0x3c]
	mov r0, #1
	orr r1, r0
	str r1, [r2, #0x3c]
	mov r1, #0xe2
	lsl r1, r1, #2
	ldr r2, [r7, r1]
	orr r0, r2
	str r0, [r7, r1]
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02160004: .word CharacterSelectMenu__Singleton
_02160008: .word 0x00000356
_0216000C: .word CharacterSelectMenu__Func_215FD04
_02160010: .word VRAMSystem__GFXControl
	thumb_func_end CharacterSelectMenu__Func_215FF44

	thumb_func_start CharacterSelectMenu__TouchAreaFunc_2160014
CharacterSelectMenu__TouchAreaFunc_2160014: // 0x02160014
	push {r4, lr}
	mov r3, #1
	ldr r4, [r0]
	lsl r3, r3, #0x10
	ldr r2, [r1, #0x14]
	cmp r4, r3
	beq _02160030
	lsl r0, r3, #1
	cmp r4, r0
	beq _02160048
	lsl r0, r3, #8
	cmp r4, r0
	beq _0216005A
	pop {r4, pc}
_02160030:
	lsr r0, r3, #5
	tst r0, r2
	bne _02160078
	add r1, #0x38
	mov r0, r1
	mov r1, #1
	blx AnimatorSprite__SetAnimation
	mov r0, #2
	blx PlaySysMenuNavSfx
	pop {r4, pc}
_02160048:
	lsr r0, r3, #5
	tst r0, r2
	bne _02160078
	add r1, #0x38
	mov r0, r1
	mov r1, #0
	blx AnimatorSprite__SetAnimation
	pop {r4, pc}
_0216005A:
	mov r0, #0x20
	mov r3, r2
	tst r3, r0
	beq _02160078
	lsl r0, r0, #6
	tst r0, r2
	bne _02160078
	add r1, #0x38
	mov r0, r1
	mov r1, #1
	blx AnimatorSprite__SetAnimation
	mov r0, #2
	bl CharacterSelectMenu__Func_215FD14
_02160078:
	pop {r4, pc}
	.align 2, 0
	thumb_func_end CharacterSelectMenu__TouchAreaFunc_2160014

	thumb_func_start CharacterSelectMenu__TouchAreaFunc_216007C
CharacterSelectMenu__TouchAreaFunc_216007C: // 0x0216007C
	push {r4, lr}
	ldr r1, [r0]
	mov r0, #1
	lsl r0, r0, #0x12
	mov r4, r2
	cmp r1, r0
	beq _02160092
	lsl r0, r0, #4
	cmp r1, r0
	beq _021600A0
	pop {r4, pc}
_02160092:
	mov r0, #1
	bl CharacterSelectMenu__Func_215FD14
	mov r0, #1
	bl CharacterSelectMenu__Func_21600D4
	pop {r4, pc}
_021600A0:
	ldr r0, _021600C8 // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	ldr r2, _021600CC // =gameState
	ldr r1, [r2, #4]
	cmp r4, r1
	beq _021600C4
	ldr r1, _021600D0 // =0x00000416
	str r4, [r2, #4]
	mov r2, #0
	strh r2, [r0, r1]
	mov r0, r2
	bl CharacterSelectMenu__Func_21600D4
	mov r0, #2
	blx PlaySysMenuNavSfx
_021600C4:
	pop {r4, pc}
	nop
_021600C8: .word CharacterSelectMenu__Singleton
_021600CC: .word gameState
_021600D0: .word 0x00000416
	thumb_func_end CharacterSelectMenu__TouchAreaFunc_216007C

	thumb_func_start CharacterSelectMenu__Func_21600D4
CharacterSelectMenu__Func_21600D4: // 0x021600D4
	push {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, _02160164 // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	mov r5, r0
	ldr r0, _02160168 // =gameState
	ldr r0, [r0, #4]
	cmp r0, #1
	beq _02160126
	cmp r4, #0
	beq _021600F2
	mov r4, #2
	b _021600F4
_021600F2:
	mov r4, #1
_021600F4:
	mov r0, #0x45
	lsl r0, r0, #2
	add r0, r5, r0
	mov r1, r4
	blx AnimatorSprite__SetAnimation
	mov r0, #0x3b
	lsl r0, r0, #4
	add r0, r5, r0
	mov r1, r4
	blx SetPaletteAnimation
	mov r0, #0x5e
	lsl r0, r0, #2
	add r0, r5, r0
	mov r1, #3
	blx AnimatorSprite__SetAnimation
	mov r0, #0x3d
	lsl r0, r0, #4
	add r0, r5, r0
	mov r1, #0
	blx SetPaletteAnimation
	pop {r3, r4, r5, pc}
_02160126:
	cmp r4, #0
	beq _02160130
	mov r1, #5
	mov r4, #2
	b _02160134
_02160130:
	mov r1, #4
	mov r4, #1
_02160134:
	mov r0, #0x5e
	lsl r0, r0, #2
	add r0, r5, r0
	blx AnimatorSprite__SetAnimation
	mov r0, #0x3d
	lsl r0, r0, #4
	add r0, r5, r0
	mov r1, r4
	blx SetPaletteAnimation
	mov r0, #0x45
	lsl r0, r0, #2
	add r0, r5, r0
	mov r1, #0
	blx AnimatorSprite__SetAnimation
	mov r0, #0x3b
	lsl r0, r0, #4
	add r0, r5, r0
	mov r1, #0
	blx SetPaletteAnimation
	pop {r3, r4, r5, pc}
	.align 2, 0
_02160164: .word CharacterSelectMenu__Singleton
_02160168: .word gameState
	thumb_func_end CharacterSelectMenu__Func_21600D4

	thumb_func_start Task__OVL03Unknown216016C__Create
Task__OVL03Unknown216016C__Create: // 0x0216016C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r5, r0
	ldr r0, _021601C8 // =0x00003061
	str r3, [sp, #0xc]
	mov r7, r2
	str r0, [sp]
	mov r2, #0
	mov r6, r1
	str r2, [sp, #4]
	mov r0, #0x1c
	str r0, [sp, #8]
	ldr r0, _021601CC // =Task__OVL03Unknown216016C__Main
	ldr r1, _021601D0 // =Task__OVL03Unknown216016C__Destructor
	mov r3, r2
	blx TaskCreate_
	str r0, [sp, #0x10]
	blx GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x1c
	blx MIi_CpuClear16
	str r5, [r4]
	strh r6, [r4, #4]
	strh r7, [r4, #6]
	ldr r0, [sp, #0xc]
	strh r0, [r4, #8]
	add r0, sp, #0x18
	ldrh r1, [r0, #0x10]
	strh r1, [r4, #0xa]
	ldrh r1, [r0, #0x14]
	strh r1, [r4, #0xe]
	ldrh r0, [r0, #0x18]
	strh r0, [r4, #0x10]
	ldr r0, [sp, #0x34]
	str r0, [r4, #0x14]
	ldr r0, [sp, #0x38]
	str r0, [r4, #0x18]
	ldr r0, [sp, #0x10]
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	nop
_021601C8: .word 0x00003061
_021601CC: .word Task__OVL03Unknown216016C__Main
_021601D0: .word Task__OVL03Unknown216016C__Destructor
	thumb_func_end Task__OVL03Unknown216016C__Create

	thumb_func_start Task__OVL03Unknown216016C__Destructor
Task__OVL03Unknown216016C__Destructor: // 0x021601D4
	push {r3, lr}
	blx GetTaskWork_
	ldr r1, [r0]
	cmp r1, #0
	beq _021601FA
	mov r2, #4
	ldrsh r2, [r0, r2]
	cmp r2, #2
	bne _021601F0
	mov r2, #8
	ldrsh r2, [r0, r2]
	strh r2, [r1]
	b _021601FA
_021601F0:
	cmp r2, #4
	bne _021601FA
	mov r2, #8
	ldrsh r2, [r0, r2]
	str r2, [r1]
_021601FA:
	ldr r2, [r0, #0x14]
	cmp r2, #0
	beq _02160204
	ldr r1, [r0, #0x18]
	blx r2
_02160204:
	pop {r3, pc}
	.align 2, 0
	thumb_func_end Task__OVL03Unknown216016C__Destructor

	thumb_func_start Task__Unknown216016C__Func_2160208
Task__Unknown216016C__Func_2160208: // 0x02160208
	ldr r0, _0216021C // =padInput
	ldrh r1, [r0]
	mov r0, #3
	tst r0, r1
	beq _02160216
	mov r0, #1
	bx lr
_02160216:
	mov r0, #0
	bx lr
	nop
_0216021C: .word padInput
	thumb_func_end Task__Unknown216016C__Func_2160208

	thumb_func_start CharacterSelectMenu__Main
CharacterSelectMenu__Main: // 0x02160220
	push {r4, r5, r6, lr}
	ldr r0, _02160338 // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	mov r3, r0
	mov r0, #0xfd
	lsl r0, r0, #2
	ldr r0, [r3, r0]
	cmp r0, #1
	beq _02160288
	ldr r0, _0216033C // =0x0400000C
	mov r1, #0x43
	ldrh r2, [r0]
	mov r4, #0
	and r2, r1
	ldr r1, _02160340 // =0x00008604
	orr r2, r1
	strh r2, [r0]
	ldr r2, _02160344 // =renderCoreGFXControlA
	strh r4, [r2, #0xa]
	ldrh r4, [r2, #0xa]
	strh r4, [r2, #8]
	strh r4, [r2, #6]
	strh r4, [r2, #4]
	strh r4, [r2, #2]
	strh r4, [r2]
	sub r2, r0, #4
	ldrh r5, [r2]
	mov r4, #3
	bic r5, r4
	strh r5, [r2]
	sub r5, r0, #2
	ldrh r6, [r5]
	mov r2, #1
	bic r6, r4
	orr r2, r6
	strh r2, [r5]
	ldrh r5, [r0]
	mov r2, #2
	bic r5, r4
	mov r4, r5
	orr r4, r2
	strh r4, [r0]
	lsl r4, r1, #0x18
	ldr r1, [r4]
	ldr r0, _02160348 // =0xFFFFE0FF
	and r1, r0
	lsl r0, r2, #0xa
	orr r0, r1
	str r0, [r4]
	b _021602D8
_02160288:
	ldr r0, _0216034C // =0x0400100C
	mov r1, #0x43
	ldrh r2, [r0]
	and r2, r1
	ldr r1, _02160340 // =0x00008604
	orr r1, r2
	strh r1, [r0]
	ldr r1, _02160350 // =renderCoreGFXControlB
	mov r2, #0
	strh r2, [r1, #0xa]
	ldrh r2, [r1, #0xa]
	strh r2, [r1, #8]
	strh r2, [r1, #6]
	strh r2, [r1, #4]
	strh r2, [r1, #2]
	strh r2, [r1]
	sub r1, r0, #4
	ldrh r4, [r1]
	mov r2, #3
	bic r4, r2
	strh r4, [r1]
	sub r4, r0, #2
	ldrh r5, [r4]
	mov r1, #1
	bic r5, r2
	orr r1, r5
	strh r1, [r4]
	ldrh r4, [r0]
	mov r1, #2
	bic r4, r2
	mov r2, r4
	orr r2, r1
	strh r2, [r0]
	sub r0, #0xc
	ldr r4, [r0]
	ldr r2, _02160348 // =0xFFFFE0FF
	lsl r1, r1, #0xa
	and r2, r4
	orr r1, r2
	str r1, [r0]
_021602D8:
	mov r0, #0xfd
	lsl r0, r0, #2
	ldr r0, [r3, r0]
	cmp r0, #1
	beq _021602EA
	ldr r0, _02160344 // =renderCoreGFXControlA
	ldr r1, _02160350 // =renderCoreGFXControlB
	mov r2, #1
	b _021602F0
_021602EA:
	ldr r0, _02160350 // =renderCoreGFXControlB
	ldr r1, _02160344 // =renderCoreGFXControlA
	mov r2, #2
_021602F0:
	mov r4, #0x58
	ldrsh r4, [r1, r4]
	lsl r2, r2, #8
	cmp r4, #0
	beq _021602FC
	mov r2, #0
_021602FC:
	ldr r4, _02160354 // =0x00000414
	ldrh r4, [r3, r4]
	mov r3, #1
	tst r3, r4
	beq _02160326
	mov r3, #0x58
	ldrsh r3, [r0, r3]
	cmp r3, #0
	beq _02160326
	bge _02160314
	mov r0, #2
	b _02160316
_02160314:
	mov r0, #3
_02160316:
	orr r0, r2
	lsl r0, r0, #0x10
	mov r1, #1
	lsr r0, r0, #0x10
	lsl r1, r1, #0xc
	blx CreateDrawFadeTask
	b _02160330
_02160326:
	mov r2, #0
	add r0, #0x58
	strh r2, [r0]
	add r1, #0x58
	strh r2, [r1]
_02160330:
	ldr r0, _02160358 // =CharacterSelectMenu__Main_216035C
	blx SetCurrentTaskMainEvent
	pop {r4, r5, r6, pc}
	.align 2, 0
_02160338: .word CharacterSelectMenu__Singleton
_0216033C: .word 0x0400000C
_02160340: .word 0x00008604
_02160344: .word renderCoreGFXControlA
_02160348: .word 0xFFFFE0FF
_0216034C: .word 0x0400100C
_02160350: .word renderCoreGFXControlB
_02160354: .word 0x00000414
_02160358: .word CharacterSelectMenu__Main_216035C
	thumb_func_end CharacterSelectMenu__Main

	thumb_func_start CharacterSelectMenu__Main_216035C
CharacterSelectMenu__Main_216035C: // 0x0216035C
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x40
	ldr r0, _021606B4 // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	mov r4, r0
	ldr r0, [r4]
	mov r1, #0
	str r0, [sp, #0x24]
	mov r0, #0x41
	lsl r0, r0, #4
	str r1, [r4, r0]
	sub r0, #0x18
	add r0, r4, r0
	blx TouchField__Init
	ldr r0, _021606B8 // =0x00000404
	mov r3, #0
	str r3, [r4, r0]
	add r1, r0, #4
	strb r3, [r4, r1]
	add r0, r0, #6
	strb r3, [r4, r0]
	ldr r0, [sp, #0x24]
	add r1, sp, #0x3c
	ldr r0, [r0]
	mov r2, #1
	bl StageClear__LoadFiles
	mov r3, #0xfd
	lsl r3, r3, #2
	ldr r0, [r4, r3]
	ldr r2, _021606BC // =VRAMSystem__GFXControl
	lsl r0, r0, #2
	ldr r0, [r2, r0]
	mov r1, #0
	strh r1, [r0, #8]
	ldr r0, [r4, r3]
	ldr r1, _021606C0 // =0x0000FF40
	lsl r0, r0, #2
	ldr r0, [r2, r0]
	mov r2, #0x20
	strh r1, [r0, #0xa]
	mov r0, #2
	str r0, [sp]
	str r2, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	ldr r1, [sp, #0x3c]
	ldr r3, [r4, r3]
	add r0, r4, #4
	blx InitBackground
	add r0, r4, #4
	blx DrawBackground
	ldr r1, [r4, #4]
	mov r0, #0x20
	bic r1, r0
	mov r0, #7
	orr r0, r1
	str r0, [r4, #4]
	mov r0, #0xfd
	lsl r0, r0, #2
	ldr r5, [r4, r0]
	add r0, sp, #0x28
	add r0, #2
	str r0, [sp]
	mov r0, r5
	mov r1, #2
	add r2, sp, #0x2c
	add r3, sp, #0x28
	blx GetVRAMTileConfig
	ldr r1, _021606C4 // =VRAMSystem__VRAM_BG
	lsl r2, r5, #2
	ldr r1, [r1, r2]
	add r2, sp, #0x28
	ldrh r3, [r2]
	ldrh r2, [r2, #2]
	mov r0, #0
	lsl r3, r3, #0x10
	lsl r2, r2, #0xb
	add r2, r3, r2
	add r1, r1, r2
	mov r2, #2
	lsl r2, r2, #0xa
	add r1, r1, r2
	blx MIi_CpuClear32
	ldr r0, [sp, #0x24]
	mov r1, #0xfd
	ldr r0, [r0, #0xc]
	mov r5, r4
	str r0, [sp, #0x3c]
	lsl r1, r1, #2
	ldr r1, [r4, r1]
	mov r2, #6
	add r5, #0x4c
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0xfd
	lsl r1, r1, #2
	ldr r1, [r4, r1]
	mov r3, #1
	str r1, [sp]
	str r0, [sp, #4]
	str r3, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x3c]
	mov r0, r5
	mov r2, #6
	lsl r3, r3, #0xb
	blx SpriteUnknown__Func_204C90C
	mov r0, #0x80
	strh r0, [r5, #8]
	mov r0, #0xe0
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x24]
	mov r1, #0xfd
	ldr r0, [r0, #8]
	mov r5, r4
	str r0, [sp, #0x3c]
	lsl r1, r1, #2
	ldr r1, [r4, r1]
	mov r2, #1
	add r5, #0xb0
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0xfd
	lsl r1, r1, #2
	ldr r1, [r4, r1]
	ldr r3, _021606C8 // =0x00000805
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x3c]
	mov r0, r5
	mov r2, #1
	blx SpriteUnknown__Func_204C90C
	mov r1, #0
	mov r0, r5
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x24]
	mov r2, #0
	ldr r0, [r0]
	add r1, sp, #0x3c
	mov r3, r2
	bl StageClear__LoadFiles
	mov r0, #0x77
	lsl r0, r0, #2
	mov r6, #0
	add r7, r4, r0
_021604B0:
	add r0, r6, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x20]
	mov r0, #0xfd
	lsl r0, r0, #2
	mov r5, r7
	ldr r0, [r4, r0]
	add r5, #0x38
	cmp r0, #1
	beq _021604CC
	mov r0, #2
	str r0, [sp, #0x1c]
	b _021604D0
_021604CC:
	mov r0, #4
	str r0, [sp, #0x1c]
_021604D0:
	mov r1, #0xfd
	lsl r1, r1, #2
	ldr r0, [sp, #0x3c]
	ldr r1, [r4, r1]
	ldr r2, [sp, #0x20]
	blx SpriteUnknown__Func_204C3CC
	mov r1, r0
	mov r0, #0xfd
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	blx VRAMSystem__AllocSpriteVram
	mov r1, #0xfd
	lsl r1, r1, #2
	ldr r1, [r4, r1]
	mov r3, #2
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x1c]
	lsl r3, r3, #0xa
	str r0, [sp, #0xc]
	mov r0, r1
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r0, #0x1f
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x3c]
	ldr r2, [sp, #0x20]
	mov r0, r5
	blx AnimatorSprite__Init
	mov r0, r5
	add r0, #0x50
	strh r6, [r0]
	mov r0, #0
	strh r0, [r5, #8]
	mov r0, #0xc0
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	cmp r6, #1
	beq _02160534
	mov r1, #0x30
	b _02160536
_02160534:
	mov r1, #0x88
_02160536:
	add r0, sp, #0x28
	strh r1, [r0, #0x10]
	mov r1, #0x38
	strh r1, [r0, #0x12]
	mov r1, #0
	add r0, sp, #0x28
	strh r1, [r0, #8]
	strh r1, [r0, #0xa]
	mov r1, #0x48
	strh r1, [r0, #0xc]
	mov r1, #0x70
	strh r1, [r0, #0xe]
	ldr r0, _021606CC // =CharacterSelectMenu__TouchAreaFunc_216007C
	ldr r2, _021606D0 // =TouchField__PointInRect
	str r0, [sp]
	mov r0, r7
	add r1, sp, #0x38
	add r3, sp, #0x30
	str r6, [sp, #4]
	blx TouchField__InitAreaShape
	mov r0, #0xfe
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, r7
	mov r2, #0
	blx TouchField__AddArea
	add r6, r6, #1
	add r7, #0x9c
	cmp r6, #2
	blo _021604B0
	ldr r0, [sp, #0x24]
	mov r6, #0
	ldr r0, [r0, #0xc]
	str r0, [sp, #0x3c]
	mov r0, #0x45
	lsl r0, r0, #2
	add r5, r4, r0
_02160584:
	cmp r6, #0
	bne _0216058C
	mov r7, #0
	b _0216058E
_0216058C:
	mov r7, #3
_0216058E:
	mov r1, #0xfd
	lsl r1, r1, #2
	ldr r0, [sp, #0x3c]
	ldr r1, [r4, r1]
	mov r2, r7
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0xfd
	lsl r1, r1, #2
	ldr r1, [r4, r1]
	ldr r3, _021606D4 // =0x00000804
	str r1, [sp]
	str r0, [sp, #4]
	add r0, r6, #3
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x3c]
	mov r0, r5
	mov r2, r7
	blx SpriteUnknown__Func_204C90C
	mov r0, #0x80
	strh r0, [r5, #8]
	mov r0, #0xe0
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	add r5, #0x64
	cmp r6, #2
	blo _02160584
	ldr r0, [sp, #0x24]
	mov r1, #0xc5
	ldr r0, [r0, #4]
	lsl r1, r1, #2
	add r6, r4, r1
	str r0, [sp, #0x3c]
	add r1, #0xe0
	mov r5, r6
	ldr r1, [r4, r1]
	mov r2, #0
	add r5, #0x38
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0xfd
	lsl r1, r1, #2
	ldr r1, [r4, r1]
	mov r2, #0
	str r1, [sp]
	str r0, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	ldr r1, [sp, #0x3c]
	ldr r3, _021606D8 // =0x00000801
	mov r0, r5
	blx SpriteUnknown__Func_204C90C
	mov r0, #0x10
	strh r0, [r5, #8]
	mov r0, #0xb0
	strh r0, [r5, #0xa]
	ldr r0, _021606DC // =CharacterSelectMenu__TouchAreaFunc_2160014
	mov r2, #0
	str r0, [sp]
	mov r1, r6
	mov r0, r6
	add r1, #0x38
	mov r3, r2
	str r2, [sp, #4]
	blx TouchField__InitAreaSprite
	mov r0, #0xfe
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, r6
	mov r2, #0
	blx TouchField__AddArea
	mov r1, #0
	mov r0, r5
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	ldr r0, _021606E0 // =0x00000414
	ldrh r1, [r4, r0]
	mov r0, #0x80
	tst r1, r0
	beq _02160656
	ldr r1, [r6, #0x14]
	orr r0, r1
	str r0, [r6, #0x14]
_02160656:
	mov r0, #0x3b
	mov r6, #0
	lsl r0, r0, #4
	add r5, r4, r0
	mov r7, r6
_02160660:
	ldr r0, [sp, #0x24]
	add r1, sp, #0x3c
	ldr r0, [r0]
	add r2, r6, #2
	mov r3, #0
	bl StageClear__LoadFiles
	mov r0, #0xfd
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	cmp r0, #1
	beq _0216067C
	mov r0, #2
	b _0216067E
_0216067C:
	mov r0, #4
_0216067E:
	str r0, [sp]
	str r7, [sp, #4]
	ldr r1, [sp, #0x3c]
	mov r0, r5
	mov r2, #0
	mov r3, #2
	blx InitPaletteAnimator
	mov r0, r5
	blx AnimatePalette
	mov r0, #2
	lsl r0, r0, #8
	add r6, r6, #1
	add r5, #0x20
	add r7, r7, r0
	cmp r6, #2
	blo _02160660
	ldr r0, _021606E4 // =0x00000416
	mov r1, #0
	strh r1, [r4, r0]
	ldr r0, _021606E8 // =Task__OVL03Unknown21606EC__Create
	blx SetCurrentTaskMainEvent
	add sp, #0x40
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021606B4: .word CharacterSelectMenu__Singleton
_021606B8: .word 0x00000404
_021606BC: .word VRAMSystem__GFXControl
_021606C0: .word 0x0000FF40
_021606C4: .word VRAMSystem__VRAM_BG
_021606C8: .word 0x00000805
_021606CC: .word CharacterSelectMenu__TouchAreaFunc_216007C
_021606D0: .word TouchField__PointInRect
_021606D4: .word 0x00000804
_021606D8: .word 0x00000801
_021606DC: .word CharacterSelectMenu__TouchAreaFunc_2160014
_021606E0: .word 0x00000414
_021606E4: .word 0x00000416
_021606E8: .word Task__OVL03Unknown21606EC__Create
	thumb_func_end CharacterSelectMenu__Main_216035C

	thumb_func_start Task__OVL03Unknown21606EC__Create
Task__OVL03Unknown21606EC__Create: // 0x021606EC
	push {lr}
	sub sp, #0xc
	ldr r0, _0216074C // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	mov r1, #0xfd
	lsl r1, r1, #2
	ldr r0, [r0, r1]
	cmp r0, #1
	ldr r0, _02160750 // =0xFFFFE0FF
	beq _02160716
	mov r2, #1
	lsl r2, r2, #0x1a
	ldr r1, [r2]
	and r1, r0
	mov r0, #7
	lsl r0, r0, #0xa
	orr r0, r1
	str r0, [r2]
	b _02160724
_02160716:
	ldr r2, _02160754 // =0x04001000
	ldr r1, [r2]
	and r1, r0
	mov r0, #7
	lsl r0, r0, #0xa
	orr r0, r1
	str r0, [r2]
_02160724:
	ldr r0, _02160758 // =0x00003081
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0216075C // =Task__OVL03Unknown21606EC__Main
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	blx TaskCreate_
	blx GetCurrentTask
	bl Task__Unknown21606EC__Func_215FE88
	mov r0, #0
	blx SetCurrentTaskMainEvent
	add sp, #0xc
	pop {pc}
	nop
_0216074C: .word CharacterSelectMenu__Singleton
_02160750: .word 0xFFFFE0FF
_02160754: .word 0x04001000
_02160758: .word 0x00003081
_0216075C: .word Task__OVL03Unknown21606EC__Main
	thumb_func_end Task__OVL03Unknown21606EC__Create

	thumb_func_start Task__OVL03Unknown2160760__Create
Task__OVL03Unknown2160760__Create: // 0x02160760
	push {lr}
	sub sp, #0xc
	ldr r0, _021607A0 // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	ldr r2, [r0]
	ldr r3, [r2, #0x14]
	cmp r3, #0
	beq _0216077C
	ldr r2, [r2, #0x18]
	mov r0, #2
	mov r1, #0
	blx r3
_0216077C:
	ldr r0, _021607A4 // =0x00003041
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _021607A8 // =Task__OVL03Unknown2160760__Main
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	blx TaskCreate_
	ldr r0, _021607AC // =CharacterSelectMenu__Func_21607B0
	blx SetCurrentTaskMainEvent
	bl CharacterSelectMenu__Func_21607B0
	add sp, #0xc
	pop {pc}
	nop
_021607A0: .word CharacterSelectMenu__Singleton
_021607A4: .word 0x00003041
_021607A8: .word Task__OVL03Unknown2160760__Main
_021607AC: .word CharacterSelectMenu__Func_21607B0
	thumb_func_end Task__OVL03Unknown2160760__Create

	thumb_func_start CharacterSelectMenu__Func_21607B0
CharacterSelectMenu__Func_21607B0: // 0x021607B0
	push {r4, lr}
	ldr r0, _0216082C // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	mov r4, r0
	ldr r0, _02160830 // =touchInput
	mov r1, #1
	ldrh r0, [r0, #0x12]
	tst r0, r1
	bne _021607F0
	ldr r0, _02160834 // =padInput
	ldrh r2, [r0, #8]
	mov r0, #0x30
	tst r0, r2
	beq _021607F0
	ldr r2, _02160838 // =gameState
	ldr r0, [r2, #4]
	cmp r0, #1
	beq _021607DC
	str r1, [r2, #4]
	b _021607E0
_021607DC:
	mov r0, #0
	str r0, [r2, #4]
_021607E0:
	ldr r1, _0216083C // =0x00000416
	mov r0, #0
	strh r0, [r4, r1]
	bl CharacterSelectMenu__Func_21600D4
	mov r0, #2
	blx PlaySysMenuNavSfx
_021607F0:
	ldr r0, _02160834 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #1
	mov r2, r1
	tst r2, r0
	beq _02160808
	bl CharacterSelectMenu__Func_21600D4
	mov r0, #1
	bl CharacterSelectMenu__Func_215FD14
	pop {r4, pc}
_02160808:
	ldr r0, _02160840 // =0x00000414
	ldrh r2, [r4, r0]
	mov r0, #0x80
	tst r0, r2
	bne _0216081E
	mov r0, #2
	tst r1, r0
	beq _0216081E
	bl CharacterSelectMenu__Func_215FD14
	pop {r4, pc}
_0216081E:
	mov r0, #0xfe
	lsl r0, r0, #2
	add r0, r4, r0
	blx TouchField__Process
	pop {r4, pc}
	nop
_0216082C: .word CharacterSelectMenu__Singleton
_02160830: .word touchInput
_02160834: .word padInput
_02160838: .word gameState
_0216083C: .word 0x00000416
_02160840: .word 0x00000414
	thumb_func_end CharacterSelectMenu__Func_21607B0

	thumb_func_start Task__OVL03Unknown2160760__Main
Task__OVL03Unknown2160760__Main: // 0x02160844
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _021608DC // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	cmp r0, #0
	bne _02160854
	blx DestroyCurrentTask
	pop {r3, r4, r5, r6, r7, pc}
_02160854:
	blx GetTaskWork_
	mov r1, #0
	mov r7, r0
	add r0, #0x4c
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	mov r0, r7
	mov r1, #0
	add r0, #0xb0
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	mov r0, #0x77
	lsl r0, r0, #2
	add r4, r7, r0
	sub r0, #0xc8
	mov r6, #0
	add r5, r7, r0
_0216087C:
	mov r0, r4
	mov r1, #0
	add r0, #0x38
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	mov r1, #0
	mov r0, r5
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	add r4, #0x9c
	add r5, #0x64
	cmp r6, #2
	blo _0216087C
	mov r0, #0xd3
	lsl r0, r0, #2
	mov r1, #0
	add r0, r7, r0
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	mov r0, #0x3b
	lsl r0, r0, #4
	mov r5, #0
	add r4, r7, r0
_021608B2:
	mov r0, r4
	blx AnimatePalette
	add r5, r5, #1
	add r4, #0x20
	cmp r5, #2
	blo _021608B2
	ldr r1, _021608E0 // =0x00000416
	add r0, r1, #2
	ldrsh r2, [r7, r1]
	ldrsh r0, [r7, r0]
	add r0, r2, r0
	strh r0, [r7, r1]
	mov r0, #3
	ldrsh r2, [r7, r1]
	lsl r0, r0, #0xc
	cmp r2, r0
	ble _021608D8
	strh r0, [r7, r1]
_021608D8:
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021608DC: .word CharacterSelectMenu__Singleton
_021608E0: .word 0x00000416
	thumb_func_end Task__OVL03Unknown2160760__Main

	thumb_func_start Task__OVL03Unknown21606EC__Main
Task__OVL03Unknown21606EC__Main: // 0x021608E4
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	ldr r0, _021609A4 // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	cmp r0, #0
	bne _021608F8
	blx DestroyCurrentTask
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
_021608F8:
	blx GetTaskWork_
	str r0, [sp, #4]
	add r0, #0x4c
	blx AnimatorSprite__DrawFrame
	ldr r1, _021609A8 // =gameState
	ldr r0, [sp, #4]
	ldr r2, [r1, #4]
	mov r1, #0x58
	mul r1, r2
	add r0, #0xb0
	add r1, #0x30
	strh r1, [r0, #8]
	mov r1, #0xa1
	strh r1, [r0, #0xa]
	blx AnimatorSprite__DrawFrame
	mov r1, #0x77
	mov r6, #0
	ldr r0, [sp, #4]
	lsl r1, r1, #2
	add r0, r0, r1
	str r0, [sp]
	ldr r0, [sp, #4]
	sub r1, #0xc8
	add r4, r0, r1
	mov r7, r6
_02160930:
	ldr r5, [sp]
	add r5, #0x38
	mov r0, r5
	blx AnimatorSprite__DrawFrame
	ldr r0, _021609A8 // =gameState
	ldr r0, [r0, #4]
	cmp r6, r0
	bne _0216094E
	ldr r1, [sp, #4]
	ldr r0, _021609AC // =0x00000416
	ldrsh r0, [r1, r0]
	lsl r0, r0, #4
	lsr r0, r0, #0x10
	b _02160950
_0216094E:
	mov r0, #0
_02160950:
	mov r1, #8
	ldrsh r1, [r5, r1]
	sub r1, r1, r0
	add r1, #0x2c
	add r1, r1, r7
	strh r1, [r4, #8]
	mov r1, #0xa
	ldrsh r1, [r5, r1]
	sub r0, r1, r0
	add r0, #0x98
	strh r0, [r4, #0xa]
	mov r0, r4
	blx AnimatorSprite__DrawFrame
	ldr r0, [sp]
	add r6, r6, #1
	add r0, #0x9c
	str r0, [sp]
	add r4, #0x64
	add r7, #0x58
	cmp r6, #2
	blo _02160930
	mov r1, #0xd3
	ldr r0, [sp, #4]
	lsl r1, r1, #2
	add r0, r0, r1
	blx AnimatorSprite__DrawFrame
	mov r1, #0x3b
	ldr r0, [sp, #4]
	lsl r1, r1, #4
	mov r4, #0
	add r5, r0, r1
_02160992:
	mov r0, r5
	blx DrawAnimatedPalette
	add r4, r4, #1
	add r5, #0x20
	cmp r4, #2
	blo _02160992
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021609A4: .word CharacterSelectMenu__Singleton
_021609A8: .word gameState
_021609AC: .word 0x00000416
	thumb_func_end Task__OVL03Unknown21606EC__Main

	thumb_func_start CharacterSelectMenu__Func_21609B0
CharacterSelectMenu__Func_21609B0: // 0x021609B0
	push {r3, lr}
	ldr r0, _021609D0 // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	mov r1, #0x41
	lsl r1, r1, #4
	ldr r2, [r0, r1]
	cmp r2, #0x20
	ble _021609CA
	bl CharacterSelectMenu__Func_215FD94
	pop {r3, pc}
_021609CA:
	add r2, r2, #1
	str r2, [r0, r1]
	pop {r3, pc}
	.align 2, 0
_021609D0: .word CharacterSelectMenu__Singleton
	thumb_func_end CharacterSelectMenu__Func_21609B0

	thumb_func_start CharacterSelectMenu__Func_21609D4
CharacterSelectMenu__Func_21609D4: // 0x021609D4
	push {r3, lr}
	ldr r0, _021609E8 // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	ldr r0, _021609EC // =CharacterSelectMenu__Func_21609F0
	blx SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_021609E8: .word CharacterSelectMenu__Singleton
_021609EC: .word CharacterSelectMenu__Func_21609F0
	thumb_func_end CharacterSelectMenu__Func_21609D4

	thumb_func_start CharacterSelectMenu__Func_21609F0
CharacterSelectMenu__Func_21609F0: // 0x021609F0
	push {r3, lr}
	blx IsDrawFadeTaskFinished
	cmp r0, #0
	beq _02160A14
	ldr r0, _02160A18 // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	mov r1, #0x3f
	lsl r1, r1, #4
	ldr r1, [r0, r1]
	ldr r0, [r0]
	str r1, [r0, #0x10]
	blx DestroyDrawFadeTask
	blx DestroyCurrentTask
_02160A14:
	pop {r3, pc}
	nop
_02160A18: .word CharacterSelectMenu__Singleton
	thumb_func_end CharacterSelectMenu__Func_21609F0

	thumb_func_start Task__OVL03Unknown216016C__Main
Task__OVL03Unknown216016C__Main: // 0x02160A1C
	push {r3, r4, lr}
	sub sp, #4
	ldr r0, _02160A88 // =CharacterSelectMenu__Singleton
	ldr r0, [r0]
	cmp r0, #0
	bne _02160A30
	blx DestroyCurrentTask
	add sp, #4
	pop {r3, r4, pc}
_02160A30:
	blx GetCurrentTaskWork_
	mov r4, r0
	ldrh r3, [r4, #0xc]
	ldrh r2, [r4, #0xe]
	cmp r2, r3
	bhi _02160A46
	blx DestroyCurrentTask
	add sp, #4
	pop {r3, r4, pc}
_02160A46:
	mov r0, #0x10
	ldrsh r0, [r4, r0]
	mov r1, #8
	str r0, [sp]
	mov r0, #6
	ldrsh r0, [r4, r0]
	ldrsh r1, [r4, r1]
	blx Unknown2051334__Func_2051534
	mov r1, #4
	ldrsh r1, [r4, r1]
	cmp r1, #2
	bne _02160A66
	ldr r1, [r4]
	strh r0, [r1]
	b _02160A6E
_02160A66:
	cmp r1, #4
	bne _02160A6E
	ldr r1, [r4]
	str r0, [r1]
_02160A6E:
	ldrh r0, [r4, #0xa]
	cmp r0, #0
	beq _02160A7A
	sub r0, r0, #1
	strh r0, [r4, #0xa]
	b _02160A80
_02160A7A:
	ldrh r0, [r4, #0xc]
	add r0, r0, #1
	strh r0, [r4, #0xc]
_02160A80:
	bl Task__Unknown216016C__Func_2160208
	add sp, #4
	pop {r3, r4, pc}
	.align 2, 0
_02160A88: .word CharacterSelectMenu__Singleton
	thumb_func_end Task__OVL03Unknown216016C__Main

	.data
	
aBbDmcsLangBb: // 0x0217E99C
	.asciz "/bb/dmcs_lang.bb"
	.align 4
	
aBbNlBb_2: // 0x0217E9B0
	.asciz "/bb/nl.bb"
	.align 4
