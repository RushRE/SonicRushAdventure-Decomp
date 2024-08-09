	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CreditsNotification__Create
CreditsNotification__Create: // 0x021567C4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x1c
	mov r7, r0
	mov r6, r1
	mov r0, #0
	mov r1, #1
	bl ovl05_2154520
	mov r0, #0x3000
	mov r2, #0
	str r0, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #0x250
	ldr r0, _021568A8 // =CreditsNotification__Main
	ldr r1, _021568AC // =CreditsNotification__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r5, r0
	mov r0, #0
	mov r1, r5
	mov r2, r4
	bl MIi_CpuClear16
	str r7, [r5]
	str r6, [r5, #4]
	ldr r0, [r7, #4]
	mov r1, #1
	bl FileUnknown__GetAOUFile
	mov r4, r0
	bl Sprite__GetSpriteSize2
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r3, _021568B0 // =0x05000200
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r1, r4
	add r0, r5, #0x1ec
	mov r3, #4
	str r2, [sp, #0x18]
	bl AnimatorSprite__Init
	mov r1, #0
	add r0, r5, #0x200
	strh r1, [r0, #0x3c]
	add r0, r5, #0x100
	mov r1, #0xe0
	strh r1, [r0, #0xf4]
	mov r1, #0x60
	strh r1, [r0, #0xf6]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021568A8: .word CreditsNotification__Main
_021568AC: .word CreditsNotification__Destructor
_021568B0: .word 0x05000200
	arm_func_end CreditsNotification__Create

	arm_func_start CreditsNotification__Destructor
CreditsNotification__Destructor: // 0x021568B4
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	add r0, r0, #0x1ec
	bl AnimatorSprite__Release
	ldmia sp!, {r3, pc}
	arm_func_end CreditsNotification__Destructor

	arm_func_start CreditsNotification__Main
CreditsNotification__Main: // 0x021568C8
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	ldr r1, _021568F8 // =renderCoreGFXControlA
	mov r2, #0
	mov r4, r0
	strh r2, [r1, #0x58]
	bl CreditsNotification__Func_2156A58
	mov r0, r4
	bl CreditsNotification__Func_2156C24
	ldr r0, _021568FC // =CreditsNotification__Main_2156900
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_021568F8: .word renderCoreGFXControlA
_021568FC: .word CreditsNotification__Main_2156900
	arm_func_end CreditsNotification__Main

	arm_func_start CreditsNotification__Main_2156900
CreditsNotification__Main_2156900: // 0x02156900
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl CreditsNotification__Func_2156C5C
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl CreditsNotification__Func_2156CD8
	mov r1, #0x168
	ldr r0, _0215693C // =CreditsNotification__Main_2156940
	str r1, [r4, #8]
	mov r1, #0x3c
	str r1, [r4, #0xc]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215693C: .word CreditsNotification__Main_2156940
	arm_func_end CreditsNotification__Main_2156900

	arm_func_start CreditsNotification__Main_2156940
CreditsNotification__Main_2156940: // 0x02156940
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0xc]
	ldr r1, [r4, #0x10]
	cmp r0, #0
	beq _0215696C
	sub r0, r0, #1
	str r0, [r4, #0xc]
	mov r1, #0
	b _021569B8
_0215696C:
	cmp r1, #0
	moveq r1, #1
	beq _021569B8
	ldr r0, _021569E0 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	beq _02156994
	mov r0, #0
	bl PlaySysMenuNavSfx
	mov r1, #2
_02156994:
	ldr r0, _021569E0 // =padInput
	ldrh r0, [r0, #6]
	tst r0, #1
	beq _021569B8
	ldr r0, [r4, #0x10]
	cmp r0, #2
	moveq r0, #0
	streq r0, [r4, #8]
	moveq r1, #1
_021569B8:
	mov r0, r4
	bl CreditsNotification__Func_2156D2C
	ldr r0, [r4, #8]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #8]
	ldmneia sp!, {r4, pc}
	ldr r0, _021569E4 // =CreditsNotification__Main_21569E8
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_021569E0: .word padInput
_021569E4: .word CreditsNotification__Main_21569E8
	arm_func_end CreditsNotification__Main_2156940

	arm_func_start CreditsNotification__Main_21569E8
CreditsNotification__Main_21569E8: // 0x021569E8
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	bl CreditsNotification__Func_2156CE8
	ldr r0, _02156A00 // =CreditsNotification__Main_2156A04
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156A00: .word CreditsNotification__Main_2156A04
	arm_func_end CreditsNotification__Main_21569E8

	arm_func_start CreditsNotification__Main_2156A04
CreditsNotification__Main_2156A04: // 0x02156A04
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	bl CreditsNotification__Func_2156C94
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, _02156A24 // =CreditsNotification__Main_2156A28
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156A24: .word CreditsNotification__Main_2156A28
	arm_func_end CreditsNotification__Main_2156A04

	arm_func_start CreditsNotification__Main_2156A28
CreditsNotification__Main_2156A28: // 0x02156A28
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl CreditsNotification__Func_2156CD8
	mov r0, r4
	bl CreditsNotification__Func_2156C00
	ldr r1, [r4]
	ldr r0, [r1, #0x14]
	orr r0, r0, #0x40
	str r0, [r1, #0x14]
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}
	arm_func_end CreditsNotification__Main_2156A28

	arm_func_start CreditsNotification__Func_2156A58
CreditsNotification__Func_2156A58: // 0x02156A58
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x28
	mov r4, r0
	add r0, r4, #0x14
	bl FontWindow__Init
	ldr r1, [r4]
	add r0, r4, #0x14
	ldr r1, [r1, #8]
	mov r2, #1
	bl FontWindow__LoadFromMemory
	add r0, r4, #0xc4
	bl FontWindowAnimator__Init
	mov r3, #2
	str r3, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r1, #8
	str r1, [sp, #8]
	mov r0, #0x20
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #1
	str r0, [sp, #0x1c]
	str r0, [sp, #0x20]
	add r0, r4, #0xc4
	add r1, r4, #0x14
	mov r3, r2
	str r2, [sp, #0x24]
	bl FontWindowAnimator__Load1
	add r0, r4, #0x128
	bl FontAnimator__Init
	mov r0, #0xa
	str r0, [sp]
	mov r0, #0x1b
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	mov r0, #3
	str r0, [sp, #0x10]
	mov r3, #2
	str r3, [sp, #0x14]
	mov r0, #1
	str r0, [sp, #0x18]
	add r0, r4, #0x128
	add r1, r4, #0x14
	bl FontAnimator__LoadFont1
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02156B58
_02156B34: // jump table
	b _02156B4C // case 0
	b _02156B4C // case 1
	b _02156B4C // case 2
	b _02156B4C // case 3
	b _02156B4C // case 4
	b _02156B4C // case 5
_02156B4C:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	b _02156B5C
_02156B58:
	mov r0, #1
_02156B5C:
	ldr r2, [r4]
	add r0, r0, #0x13
	mov r1, r0, lsl #0x10
	ldr r0, [r2]
	mov r1, r1, lsr #0x10
	bl FileUnknown__GetAOUFile
	mov r1, r0
	add r0, r4, #0x128
	bl FontAnimator__LoadMPCFile
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02156BA0
	cmp r0, #1
	beq _02156BB0
	cmp r0, #2
	beq _02156BC0
	b _02156BCC
_02156BA0:
	add r0, r4, #0x128
	mov r1, #0
	bl FontAnimator__SetMsgSequence
	b _02156BCC
_02156BB0:
	add r0, r4, #0x128
	mov r1, #1
	bl FontAnimator__SetMsgSequence
	b _02156BCC
_02156BC0:
	add r0, r4, #0x128
	mov r1, #2
	bl FontAnimator__SetMsgSequence
_02156BCC:
	add r0, r4, #0x128
	mov r1, #0
	bl FontAnimator__SetDialog
	add r0, r4, #0x128
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	add r0, r4, #0x128
	bl FontAnimator__LoadMappingsFunc
	add r0, r4, #0x128
	bl FontAnimator__LoadPaletteFunc
	add sp, sp, #0x28
	ldmia sp!, {r4, pc}
	arm_func_end CreditsNotification__Func_2156A58

	arm_func_start CreditsNotification__Func_2156C00
CreditsNotification__Func_2156C00: // 0x02156C00
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x128
	bl FontAnimator__Release
	add r0, r4, #0xc4
	bl FontWindowAnimator__Release
	add r0, r4, #0x14
	bl FontWindow__Release
	ldmia sp!, {r4, pc}
	arm_func_end CreditsNotification__Func_2156C00

	arm_func_start CreditsNotification__Func_2156C24
CreditsNotification__Func_2156C24: // 0x02156C24
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov ip, #0
	add r0, r4, #0xc4
	mov r1, #1
	mov r2, #0xf
	mov r3, #0xa
	str ip, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xc4
	bl FontWindowAnimator__StartAnimating
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end CreditsNotification__Func_2156C24

	arm_func_start CreditsNotification__Func_2156C5C
CreditsNotification__Func_2156C5C: // 0x02156C5C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xc4
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0xc4
	bl FontWindowAnimator__Draw
	add r0, r4, #0x14
	bl FontWindow__PrepareSwapBuffer
	add r0, r4, #0xc4
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end CreditsNotification__Func_2156C5C

	arm_func_start CreditsNotification__Func_2156C94
CreditsNotification__Func_2156C94: // 0x02156C94
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xc4
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0xc4
	bl FontWindowAnimator__Draw
	add r0, r4, #0x14
	bl FontWindow__PrepareSwapBuffer
	add r0, r4, #0xc4
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0xc4
	bl FontWindowAnimator__SetWindowClosed
	mov r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end CreditsNotification__Func_2156C94

	arm_func_start CreditsNotification__Func_2156CD8
CreditsNotification__Func_2156CD8: // 0x02156CD8
	ldr ip, _02156CE4 // =FontWindowAnimator__SetWindowOpen
	add r0, r0, #0xc4
	bx ip
	.align 2, 0
_02156CE4: .word FontWindowAnimator__SetWindowOpen
	arm_func_end CreditsNotification__Func_2156CD8

	arm_func_start CreditsNotification__Func_2156CE8
CreditsNotification__Func_2156CE8: // 0x02156CE8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	add r0, r4, #0x128
	bl FontAnimator__ClearPixels
	add r0, r4, #0x128
	bl FontAnimator__Draw
	mov r3, #0
	add r0, r4, #0xc4
	mov r1, #4
	mov r2, #0xf
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xc4
	bl FontWindowAnimator__StartAnimating
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end CreditsNotification__Func_2156CE8

	arm_func_start CreditsNotification__Func_2156D2C
CreditsNotification__Func_2156D2C: // 0x02156D2C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0xc4
	mov r4, r1
	bl FontWindowAnimator__Draw
	add r0, r5, #0x128
	mov r1, #0
	bl FontAnimator__LoadCharacters
	add r0, r5, #0x128
	bl FontAnimator__Draw
	add r0, r5, #0x14
	bl FontWindow__PrepareSwapBuffer
	ldr r0, [r5, #0x10]
	cmp r4, r0
	beq _02156DB4
	str r4, [r5, #0x10]
	cmp r4, #0
	beq _02156D88
	cmp r4, #1
	beq _02156D98
	cmp r4, #2
	beq _02156DA8
	b _02156DB4
_02156D88:
	add r0, r5, #0x1ec
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	b _02156DB4
_02156D98:
	add r0, r5, #0x1ec
	mov r1, #2
	bl AnimatorSprite__SetAnimation
	b _02156DB4
_02156DA8:
	add r0, r5, #0x1ec
	mov r1, #1
	bl AnimatorSprite__SetAnimation
_02156DB4:
	mov r1, #0
	mov r2, r1
	add r0, r5, #0x1ec
	bl AnimatorSprite__ProcessAnimation
	add r0, r5, #0x1ec
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end CreditsNotification__Func_2156D2C