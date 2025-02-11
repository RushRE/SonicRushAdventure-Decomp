	.include "asm/macros.inc"
	.include "global.inc"

	.public gameState

	.text

	arm_func_start SaveSpriteButton__LoadAssets
SaveSpriteButton__LoadAssets: // 0x02064480
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #4
	str r0, [r4, #4]
	str r0, [r4, #8]
	add r1, r4, #0x94
	mov r0, #0
	mov r2, #0xc8
	bl MIi_CpuClear16
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _020644DC
_020644B8: // jump table
	b _020644D0 // case 0
	b _020644D0 // case 1
	b _020644D0 // case 2
	b _020644D0 // case 3
	b _020644D0 // case 4
	b _020644D0 // case 5
_020644D0:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _020644E0
_020644DC:
	mov r0, #1
_020644E0:
	mov r1, r0, lsl #0x10
	ldr r0, _0206452C // =aBbDmwfYesBb
	mov r1, r1, lsr #0x10
	mov r2, #0
	bl ReadFileFromBundle
	str r0, [r4, #0x234]
	ldr r0, _02064530 // =aBbNlBb_0
	mov r1, #9
	mov r2, #0
	bl ReadFileFromBundle
	str r0, [r4, #0x238]
	ldr r0, _0206452C // =aBbDmwfYesBb
	mov r1, #6
	mov r2, #0
	bl ReadFileFromBundle
	str r0, [r4, #0x23c]
	mov r0, #0
	str r0, [r4, #0x240]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206452C: .word aBbDmwfYesBb
_02064530: .word aBbNlBb_0
	arm_func_end SaveSpriteButton__LoadAssets

	arm_func_start SaveSpriteButton__Release
SaveSpriteButton__Release: // 0x02064534
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x23c]
	cmp r0, #0
	beq _02064554
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x23c]
_02064554:
	ldr r0, [r4, #0x238]
	cmp r0, #0
	beq _0206456C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x238]
_0206456C:
	ldr r0, [r4, #0x234]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x234]
	ldmia sp!, {r4, pc}
	arm_func_end SaveSpriteButton__Release

	arm_func_start SaveSpriteButton__Func_2064588
SaveSpriteButton__Func_2064588: // 0x02064588
	mov ip, #0
	strh ip, [r0]
	strh ip, [r0, #2]
	str r1, [r0, #4]
	str r2, [r0, #0x224]
	add r1, r0, #0x200
	strh ip, [r1, #0x28]
	strh ip, [r1, #0x2a]
	ldrb r2, [sp]
	strh r3, [r1, #0x2c]
	ldrb r3, [sp, #4]
	strb r2, [r0, #0x22e]
	mov r2, #4
	strb r3, [r0, #0x22f]
	strh ip, [r1, #0x30]
	ldr r1, _020645D4 // =SaveSpriteButton__State_InitButtons
	str r2, [r0, #8]
	str r1, [r0, #0x240]
	bx lr
	.align 2, 0
_020645D4: .word SaveSpriteButton__State_InitButtons
	arm_func_end SaveSpriteButton__Func_2064588

	arm_func_start SaveSpriteButton__Func_20645D8
SaveSpriteButton__Func_20645D8: // 0x020645D8
	add r0, r0, #0x200
	strh r1, [r0, #0x28]
	strh r2, [r0, #0x2a]
	bx lr
	arm_func_end SaveSpriteButton__Func_20645D8

	arm_func_start SaveSpriteButton__RunState
SaveSpriteButton__RunState: // 0x020645E8
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x240]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	blx r1
	ldmia sp!, {r3, pc}
	arm_func_end SaveSpriteButton__RunState

	arm_func_start SaveSpriteButton__CheckInvalidState
SaveSpriteButton__CheckInvalidState: // 0x02064600
	ldr r0, [r0, #0x240]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end SaveSpriteButton__CheckInvalidState

	arm_func_start SaveSpriteButton__Func_2064614
SaveSpriteButton__Func_2064614: // 0x02064614
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #4
	str r1, [r0, #8]
	ldr r1, [r0, #4]
	cmp r1, #0
	beq _02064640
	cmp r1, #1
	beq _0206464C
	cmp r1, #2
	bxne lr
_02064640:
	ldr r1, _02064658 // =SaveSpriteButton__State_2064EB8
	str r1, [r0, #0x240]
	bx lr
_0206464C:
	ldr r1, _0206465C // =SaveSpriteButton__State_206505C
	str r1, [r0, #0x240]
	bx lr
	.align 2, 0
_02064658: .word SaveSpriteButton__State_2064EB8
_0206465C: .word SaveSpriteButton__State_206505C
	arm_func_end SaveSpriteButton__Func_2064614

	arm_func_start SaveSpriteButton__Func_2064660
SaveSpriteButton__Func_2064660: // 0x02064660
	ldr r0, [r0, #8]
	bx lr
	arm_func_end SaveSpriteButton__Func_2064660

	arm_func_start SaveSpriteButton__State_InitButtons
SaveSpriteButton__State_InitButtons: // 0x02064668
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x1c
	mov r6, r0
	ldr r0, [r6, #0x224]
	cmp r0, #0
	bne _02064694
	mov r0, #0x4000000
	ldr r1, [r0, #0]
	ldr r0, _020649C8 // =0x00300010
	ldr r5, _020649CC // =0x05000200
	b _020646A4
_02064694:
	ldr r1, _020649D0 // =0x04001000
	ldr r0, _020649C8 // =0x00300010
	ldr r1, [r1, #0]
	ldr r5, _020649D4 // =0x05000600
_020646A4:
	and r2, r1, r0
	ldr r1, _020649D8 // =0x00100010
	cmp r2, r1
	bgt _020646C4
	bge _020646F0
	cmp r2, #0x10
	beq _020646E8
	b _02064700
_020646C4:
	add r0, r1, #0x100000
	cmp r2, r0
	bgt _020646D8
	beq _020646F8
	b _02064700
_020646D8:
	add r0, r1, #0x200000
	cmp r2, r0
	beq _020646F8
	b _02064700
_020646E8:
	ldr r4, _020649DC // =Sprite__GetSpriteSize1
	b _02064704
_020646F0:
	ldr r4, _020649E0 // =Sprite__GetSpriteSize2
	b _02064704
_020646F8:
	ldr r4, _020649E4 // =Sprite__GetSpriteSize3
	b _02064704
_02064700:
	ldr r4, _020649DC // =Sprite__GetSpriteSize1
_02064704:
	add r0, r6, #0xc
	bl TouchField__Init
	mov r0, #0
	str r0, [r6, #0x18]
	ldr r0, [r6, #4]
	cmp r0, #0
	cmpne r0, #2
	ldr r0, [r6, #0x234]
	bne _02064838
	blx r4
	mov r1, r0
	ldr r0, [r6, #0x224]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r6, #0x224]
	mov r3, #0
	stmia sp, {r1, r3}
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	str r5, [sp, #0x10]
	ldrb r1, [r6, #0x22e]
	add r0, r6, #0x94
	mov r2, #3
	str r1, [sp, #0x14]
	ldrb r1, [r6, #0x22f]
	str r1, [sp, #0x18]
	ldr r1, [r6, #0x234]
	bl AnimatorSprite__Init
	add r0, r6, #0x200
	ldrh r0, [r0, #0x2c]
	strh r0, [r6, #0xe4]
	ldr r0, [r6, #0x234]
	blx r4
	mov r1, r0
	ldr r0, [r6, #0x224]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r6, #0x224]
	mov r3, #0
	stmia sp, {r1, r3}
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	str r5, [sp, #0x10]
	ldrb r1, [r6, #0x22e]
	add r0, r6, #0xf8
	mov r2, #6
	str r1, [sp, #0x14]
	ldrb r1, [r6, #0x22f]
	str r1, [sp, #0x18]
	ldr r1, [r6, #0x234]
	bl AnimatorSprite__Init
	add r0, r6, #0x200
	ldrh r1, [r0, #0x2c]
	mov r2, #0
	add r0, r6, #0x100
	add r1, r1, #1
	strh r1, [r0, #0x48]
	str r2, [sp]
	add r0, r6, #0x24
	add r1, r6, #0x94
	mov r3, r2
	str r2, [sp, #4]
	bl TouchField__InitAreaSprite
	mov r2, #0
	str r2, [sp]
	add r0, r6, #0x5c
	add r1, r6, #0xf8
	mov r3, r2
	str r2, [sp, #4]
	bl TouchField__InitAreaSprite
	ldr r2, _020649E8 // =0x0000FFFF
	add r0, r6, #0xc
	add r1, r6, #0x24
	bl TouchField__AddArea
	ldr r2, _020649E8 // =0x0000FFFF
	add r0, r6, #0xc
	add r1, r6, #0x5c
	bl TouchField__AddArea
	b _020648B8
_02064838:
	blx r4
	mov r1, r0
	ldr r0, [r6, #0x224]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r6, #0x224]
	mov r3, #0
	stmia sp, {r1, r3}
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	str r5, [sp, #0x10]
	ldrb r1, [r6, #0x22e]
	add r0, r6, #0x94
	mov r2, #9
	str r1, [sp, #0x14]
	ldrb r1, [r6, #0x22f]
	str r1, [sp, #0x18]
	ldr r1, [r6, #0x234]
	bl AnimatorSprite__Init
	add r0, r6, #0x200
	ldrh r1, [r0, #0x2c]
	mov r2, #0
	add r0, r6, #0x24
	strh r1, [r6, #0xe4]
	str r2, [sp]
	add r1, r6, #0x94
	mov r3, r2
	str r2, [sp, #4]
	bl TouchField__InitAreaSprite
	ldr r2, _020649E8 // =0x0000FFFF
	add r0, r6, #0xc
	add r1, r6, #0x24
	bl TouchField__AddArea
_020648B8:
	ldr r0, [r6, #0x238]
	blx r4
	mov r1, r0
	ldr r0, [r6, #0x224]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r6, #0x224]
	mov r3, #0
	stmia sp, {r1, r3}
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	str r5, [sp, #0x10]
	ldrb r1, [r6, #0x22e]
	add r0, r6, #0x15c
	mov r2, #1
	str r1, [sp, #0x14]
	ldrb r1, [r6, #0x22f]
	str r1, [sp, #0x18]
	ldr r1, [r6, #0x238]
	bl AnimatorSprite__Init
	ldr r1, [r6, #0x198]
	add r0, r6, #0x200
	orr r1, r1, #4
	str r1, [r6, #0x198]
	ldrh r1, [r0, #0x2c]
	add r0, r6, #0x100
	add r1, r1, #2
	strh r1, [r0, #0xac]
	ldr r0, [r6, #0x23c]
	blx r4
	mov r1, r0
	ldr r0, [r6, #0x224]
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	ldr r1, [r6, #0x224]
	mov r3, r2
	stmia sp, {r1, r2}
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	str r5, [sp, #0x10]
	ldrb r1, [r6, #0x22e]
	add r0, r6, #0x1c0
	str r1, [sp, #0x14]
	ldrb r1, [r6, #0x22f]
	str r1, [sp, #0x18]
	ldr r1, [r6, #0x23c]
	bl AnimatorSprite__Init
	add r0, r6, #0x200
	ldrh r2, [r0, #0x2c]
	mov r1, #0
	add r2, r2, #3
	strh r2, [r0, #0x10]
	strh r1, [r6, #2]
	ldr r0, [r6, #4]
	cmp r0, #0
	beq _020649A8
	cmp r0, #1
	beq _020649B8
	cmp r0, #2
	addne sp, sp, #0x1c
	ldmneia sp!, {r3, r4, r5, r6, pc}
_020649A8:
	ldr r0, _020649EC // =SaveSpriteButton__State_InitRects
	add sp, sp, #0x1c
	str r0, [r6, #0x240]
	ldmia sp!, {r3, r4, r5, r6, pc}
_020649B8:
	ldr r0, _020649F0 // =SaveSpriteButton__State_2064ED0
	str r0, [r6, #0x240]
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_020649C8: .word 0x00300010
_020649CC: .word 0x05000200
_020649D0: .word 0x04001000
_020649D4: .word 0x05000600
_020649D8: .word 0x00100010
_020649DC: .word Sprite__GetSpriteSize1
_020649E0: .word Sprite__GetSpriteSize2
_020649E4: .word Sprite__GetSpriteSize3
_020649E8: .word 0x0000FFFF
_020649EC: .word SaveSpriteButton__State_InitRects
_020649F0: .word SaveSpriteButton__State_2064ED0
	arm_func_end SaveSpriteButton__State_InitButtons

	arm_func_start SaveSpriteButton__State_InitRects
SaveSpriteButton__State_InitRects: // 0x020649F4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r1, [r4, #2]
	add r0, r4, #0x24
	add r1, r1, #1
	strh r1, [r4, #2]
	bl TouchField__ResetArea
	add r0, r4, #0x5c
	bl TouchField__ResetArea
	mov r0, #1
	strh r0, [r4]
	mov r1, #0
	ldr r0, _02064A34 // =SaveSpriteButton__State_Selecting
	strh r1, [r4, #2]
	str r0, [r4, #0x240]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02064A34: .word SaveSpriteButton__State_Selecting
	arm_func_end SaveSpriteButton__State_InitRects

	arm_func_start SaveSpriteButton__State_Selecting
SaveSpriteButton__State_Selecting: // 0x02064A38
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	add r1, r5, #0x200
	ldrsh r3, [r1, #0x28]
	add r2, r5, #0x100
	add r0, r5, #0xc
	add r3, r3, #0x54
	strh r3, [r5, #0x9c]
	ldrsh r3, [r1, #0x2a]
	mov r4, #0
	add r3, r3, #0x60
	strh r3, [r5, #0x9e]
	ldrsh r3, [r1, #0x28]
	add r3, r3, #0xac
	strh r3, [r2]
	ldrsh r1, [r1, #0x2a]
	add r1, r1, #0x60
	strh r1, [r2, #2]
	bl TouchField__Process
	ldr r0, _02064D00 // =padInput
	ldrh r2, [r0, #4]
	tst r2, #1
	beq _02064AB8
	ldrh r0, [r5, #0]
	cmp r0, #0
	moveq r0, r4
	movne r0, #1
	str r0, [r5, #8]
	mov r0, #0
	mov r4, #1
	bl PlaySysMenuNavSfx
	b _02064BBC
_02064AB8:
	tst r2, #2
	beq _02064AD8
	mov r4, #1
	strh r4, [r5]
	mov r0, #0
	str r4, [r5, #8]
	bl PlaySysMenuNavSfx
	b _02064BBC
_02064AD8:
	ldr r1, [r5, #0x38]
	tst r1, #0x40000
	beq _02064AF8
	mov r0, r4
	str r0, [r5, #8]
	mov r4, #1
	bl PlaySysMenuNavSfx
	b _02064BBC
_02064AF8:
	ldr r0, [r5, #0x70]
	tst r0, #0x40000
	beq _02064B18
	mov r4, #1
	mov r0, #0
	str r4, [r5, #8]
	bl PlaySysMenuNavSfx
	b _02064BBC
_02064B18:
	tst r2, #0x10
	bne _02064B28
	tst r0, #0x400000
	beq _02064B6C
_02064B28:
	ldrh r0, [r5, #0]
	cmp r0, #1
	beq _02064BBC
	add r0, r5, #0x15c
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	add r0, r5, #0x1c0
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	mov r0, #1
	strh r0, [r5]
	ldr r0, [r5, #0x70]
	tst r0, #0x400000
	bne _02064BBC
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _02064BBC
_02064B6C:
	tst r2, #0x20
	bne _02064B7C
	tst r1, #0x400000
	beq _02064BBC
_02064B7C:
	ldrh r0, [r5, #0]
	cmp r0, #0
	beq _02064BBC
	add r0, r5, #0x15c
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	add r0, r5, #0x1c0
	mov r1, #2
	bl AnimatorSprite__SetAnimation
	mov r0, #0
	strh r0, [r5]
	ldr r0, [r5, #0x38]
	tst r0, #0x400000
	bne _02064BBC
	mov r0, #2
	bl PlaySysMenuNavSfx
_02064BBC:
	cmp r4, #0
	bne _02064C0C
	ldrh r2, [r5, #0]
	mov r3, #0x64
	mov r1, #0
	mla r0, r2, r3, r5
	ldrsh r0, [r0, #0x9c]
	add ip, r5, #0x100
	mov r2, r1
	sub r0, r0, #0x18
	strh r0, [ip, #0x64]
	ldrh lr, [r5]
	add r0, r5, #0x15c
	mla r3, lr, r3, r5
	ldrsh r3, [r3, #0x9e]
	sub r3, r3, #2
	strh r3, [ip, #0x66]
	bl AnimatorSprite__ProcessAnimation
	add r0, r5, #0x15c
	bl AnimatorSprite__DrawFrame
_02064C0C:
	ldr r0, [r5, #4]
	cmp r0, #2
	bne _02064C44
	ldrsh r0, [r5, #0x9c]
	add r3, r5, #0x100
	mov r1, #0
	strh r0, [r3, #0xc8]
	ldrsh ip, [r5, #0x9e]
	mov r2, r1
	add r0, r5, #0x1c0
	strh ip, [r3, #0xca]
	bl AnimatorSprite__ProcessAnimation
	add r0, r5, #0x1c0
	bl AnimatorSprite__DrawFrame
_02064C44:
	ldrh r0, [r5, #0]
	cmp r0, #0
	ldr r0, [r5, #4]
	bne _02064C68
	cmp r0, #0
	moveq r6, #5
	movne r6, #2
	mov r7, #6
	b _02064C78
_02064C68:
	cmp r0, #0
	moveq r6, #3
	movne r6, #0
	mov r7, #8
_02064C78:
	mov r0, r5
	bl SaveSpriteButton__Func_20650E0
	ldrh r0, [r5, #0xa0]
	cmp r0, r6
	beq _02064C98
	mov r1, r6
	add r0, r5, #0x94
	bl AnimatorSprite__SetAnimation
_02064C98:
	add r0, r5, #0x100
	ldrh r0, [r0, #4]
	cmp r0, r7
	beq _02064CB4
	mov r1, r7
	add r0, r5, #0xf8
	bl AnimatorSprite__SetAnimation
_02064CB4:
	mov r1, #0
	mov r2, r1
	add r0, r5, #0x94
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	mov r2, r1
	add r0, r5, #0xf8
	bl AnimatorSprite__ProcessAnimation
	add r0, r5, #0x94
	bl AnimatorSprite__DrawFrame
	add r0, r5, #0xf8
	bl AnimatorSprite__DrawFrame
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, #0
	ldr r0, _02064D04 // =SaveSpriteButton__State_MadeSelection
	strh r1, [r5, #2]
	str r0, [r5, #0x240]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02064D00: .word padInput
_02064D04: .word SaveSpriteButton__State_MadeSelection
	arm_func_end SaveSpriteButton__State_Selecting

	arm_func_start SaveSpriteButton__State_MadeSelection
SaveSpriteButton__State_MadeSelection: // 0x02064D08
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	add r0, r6, #0x200
	ldrsh r2, [r0, #0x28]
	add r1, r6, #0x100
	add r2, r2, #0x54
	strh r2, [r6, #0x9c]
	ldrsh r2, [r0, #0x2a]
	add r2, r2, #0x60
	strh r2, [r6, #0x9e]
	ldrsh r2, [r0, #0x28]
	add r2, r2, #0xac
	strh r2, [r1]
	ldrsh r0, [r0, #0x2a]
	add r0, r0, #0x60
	strh r0, [r1, #2]
	ldr r0, [r6, #4]
	cmp r0, #2
	bne _02064DBC
	ldr r0, [r6, #8]
	cmp r0, #0
	ldrh r0, [r1, #0xcc]
	bne _02064D7C
	cmp r0, #1
	beq _02064D90
	add r0, r6, #0x1c0
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	b _02064D90
_02064D7C:
	cmp r0, #0
	beq _02064D90
	add r0, r6, #0x1c0
	mov r1, #0
	bl AnimatorSprite__SetAnimation
_02064D90:
	ldrsh r0, [r6, #0x9c]
	add r3, r6, #0x100
	mov r1, #0
	strh r0, [r3, #0xc8]
	ldrsh r4, [r6, #0x9e]
	mov r2, r1
	add r0, r6, #0x1c0
	strh r4, [r3, #0xca]
	bl AnimatorSprite__ProcessAnimation
	add r0, r6, #0x1c0
	bl AnimatorSprite__DrawFrame
_02064DBC:
	ldr r0, [r6, #8]
	cmp r0, #0
	ldr r0, [r6, #4]
	bne _02064DF4
	cmp r0, #0
	ldr r0, [r6, #0xd0]
	moveq r4, #4
	orr r0, r0, #4
	str r0, [r6, #0xd0]
	ldr r0, [r6, #0x134]
	movne r4, #1
	mov r5, #6
	bic r0, r0, #4
	b _02064E18
_02064DF4:
	cmp r0, #0
	ldr r0, [r6, #0xd0]
	moveq r4, #3
	bic r0, r0, #4
	str r0, [r6, #0xd0]
	ldr r0, [r6, #0x134]
	movne r4, #0
	mov r5, #7
	orr r0, r0, #4
_02064E18:
	str r0, [r6, #0x134]
	mov r0, r6
	bl SaveSpriteButton__Func_20650E0
	ldrh r0, [r6, #0xa0]
	cmp r0, r4
	beq _02064E3C
	mov r1, r4
	add r0, r6, #0x94
	bl AnimatorSprite__SetAnimation
_02064E3C:
	add r0, r6, #0x100
	ldrh r0, [r0, #4]
	cmp r0, r5
	beq _02064E58
	mov r1, r5
	add r0, r6, #0xf8
	bl AnimatorSprite__SetAnimation
_02064E58:
	mov r1, #0
	mov r2, r1
	add r0, r6, #0x94
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	mov r2, r1
	add r0, r6, #0xf8
	bl AnimatorSprite__ProcessAnimation
	add r0, r6, #0x94
	bl AnimatorSprite__DrawFrame
	add r0, r6, #0xf8
	bl AnimatorSprite__DrawFrame
	ldrh r0, [r6, #2]
	add r0, r0, #1
	strh r0, [r6, #2]
	ldrh r0, [r6, #2]
	cmp r0, #0x20
	ldmloia sp!, {r4, r5, r6, pc}
	mov r1, #0
	ldr r0, _02064EB4 // =SaveSpriteButton__State_2064EB8
	strh r1, [r6, #2]
	str r0, [r6, #0x240]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02064EB4: .word SaveSpriteButton__State_2064EB8
	arm_func_end SaveSpriteButton__State_MadeSelection

	arm_func_start SaveSpriteButton__State_2064EB8
SaveSpriteButton__State_2064EB8: // 0x02064EB8
	mov r2, #0
	ldr r1, _02064ECC // =SaveSpriteButton__State_Release
	strh r2, [r0, #2]
	str r1, [r0, #0x240]
	bx lr
	.align 2, 0
_02064ECC: .word SaveSpriteButton__State_Release
	arm_func_end SaveSpriteButton__State_2064EB8

	arm_func_start SaveSpriteButton__State_2064ED0
SaveSpriteButton__State_2064ED0: // 0x02064ED0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r1, [r4, #2]
	add r0, r4, #0x24
	add r1, r1, #1
	strh r1, [r4, #2]
	bl TouchField__ResetArea
	mov r1, #0
	strh r1, [r4]
	ldr r0, _02064F04 // =SaveSpriteButton__State_2064F08
	strh r1, [r4, #2]
	str r0, [r4, #0x240]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02064F04: .word SaveSpriteButton__State_2064F08
	arm_func_end SaveSpriteButton__State_2064ED0

	arm_func_start SaveSpriteButton__State_2064F08
SaveSpriteButton__State_2064F08: // 0x02064F08
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0xc
	mov r4, #0
	bl TouchField__Process
	ldr r0, _02064FBC // =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	bne _02064F38
	ldr r0, [r5, #0x38]
	tst r0, #0x40000
	beq _02064F4C
_02064F38:
	mov r1, #2
	mov r0, #0
	str r1, [r5, #8]
	mov r4, #1
	bl PlaySysMenuNavSfx
_02064F4C:
	ldrh r0, [r5, #0xa0]
	cmp r0, #9
	beq _02064F64
	add r0, r5, #0x94
	mov r1, #9
	bl AnimatorSprite__SetAnimation
_02064F64:
	mov r0, r5
	bl SaveSpriteButton__Func_20650E0
	add r0, r5, #0x200
	ldrsh r3, [r0, #0x28]
	mov r1, #0
	mov r2, r1
	add r3, r3, #0x80
	strh r3, [r5, #0x9c]
	ldrsh r3, [r0, #0x2a]
	add r0, r5, #0x94
	add r3, r3, #0x60
	strh r3, [r5, #0x9e]
	bl AnimatorSprite__ProcessAnimation
	add r0, r5, #0x94
	bl AnimatorSprite__DrawFrame
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r1, #0
	ldr r0, _02064FC0 // =SaveSpriteButton__State_2064FC4
	strh r1, [r5, #2]
	str r0, [r5, #0x240]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02064FBC: .word padInput
_02064FC0: .word SaveSpriteButton__State_2064FC4
	arm_func_end SaveSpriteButton__State_2064F08

	arm_func_start SaveSpriteButton__State_2064FC4
SaveSpriteButton__State_2064FC4: // 0x02064FC4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #0xa0]
	cmp r0, #0xa
	beq _02064FE4
	add r0, r4, #0x94
	mov r1, #0xa
	bl AnimatorSprite__SetAnimation
_02064FE4:
	mov r0, r4
	bl SaveSpriteButton__Func_20650E0
	ldr r1, [r4, #0xd0]
	add r0, r4, #0x200
	orr r1, r1, #4
	str r1, [r4, #0xd0]
	ldrsh r3, [r0, #0x28]
	mov r1, #0
	mov r2, r1
	add r3, r3, #0x80
	strh r3, [r4, #0x9c]
	ldrsh r3, [r0, #0x2a]
	add r0, r4, #0x94
	add r3, r3, #0x60
	strh r3, [r4, #0x9e]
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x94
	bl AnimatorSprite__DrawFrame
	ldrh r0, [r4, #2]
	add r0, r0, #1
	strh r0, [r4, #2]
	ldrh r0, [r4, #2]
	cmp r0, #0x20
	ldmloia sp!, {r4, pc}
	mov r1, #0
	ldr r0, _02065058 // =SaveSpriteButton__State_2064EB8
	strh r1, [r4, #2]
	str r0, [r4, #0x240]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02065058: .word SaveSpriteButton__State_2064EB8
	arm_func_end SaveSpriteButton__State_2064FC4

	arm_func_start SaveSpriteButton__State_206505C
SaveSpriteButton__State_206505C: // 0x0206505C
	mov r2, #0
	ldr r1, _02065070 // =SaveSpriteButton__State_Release
	strh r2, [r0, #2]
	str r1, [r0, #0x240]
	bx lr
	.align 2, 0
_02065070: .word SaveSpriteButton__State_Release
	arm_func_end SaveSpriteButton__State_206505C

	arm_func_start SaveSpriteButton__State_Release
SaveSpriteButton__State_Release: // 0x02065074
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x94
	bl AnimatorSprite__Release
	add r0, r4, #0xf8
	bl AnimatorSprite__Release
	add r0, r4, #0x15c
	bl AnimatorSprite__Release
	add r0, r4, #0x1c0
	bl AnimatorSprite__Release
	mov r0, #0
	add r1, r4, #0x94
	mov r2, #0xc8
	bl MIi_CpuClear16
	mov r0, #0
	add r1, r4, #0x15c
	mov r2, #0x64
	bl MIi_CpuClear16
	mov r0, #0
	add r1, r4, #0x1c0
	mov r2, #0x64
	bl MIi_CpuClear16
	mov r0, #0
	strh r0, [r4]
	strh r0, [r4, #2]
	str r0, [r4, #0x240]
	ldmia sp!, {r4, pc}
	arm_func_end SaveSpriteButton__State_Release

	arm_func_start SaveSpriteButton__Func_20650E0
SaveSpriteButton__Func_20650E0: // 0x020650E0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r0
	add r0, r6, #0x200
	ldrh r0, [r0, #0x30]
	mov r5, #2
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r6, #4]
	mov r4, #0
	cmp r0, #1
	moveq r5, #1
	cmp r5, #0
	ldmlsia sp!, {r4, r5, r6, r7, r8, pc}
	add r7, r6, #0x200
	mov r8, #0x64
_0206511C:
	mla r0, r4, r8, r6
	ldrh r0, [r0, #0xe4]
	ldr r1, [r6, #0x224]
	cmp r1, #1
	addeq r0, r0, #0x10
	moveq r0, r0, lsl #0x10
	moveq r0, r0, lsr #0x10
	bl ObjDraw__GetHWPaletteRow
	ldrh r2, [r7, #0x30]
	add r1, r4, #1
	mov r1, r1, lsl #0x10
	strh r2, [r0, #0x1e]
	cmp r5, r1, lsr #16
	mov r4, r1, lsr #0x10
	bhi _0206511C
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end SaveSpriteButton__Func_20650E0

	arm_func_start SaveSpriteButton__Func_206515C
SaveSpriteButton__Func_206515C: // 0x0206515C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x380
	bl MIi_CpuClear32
	mov r0, r4
	bl SaveSpriteButton__LoadAssets
	add r0, r4, #0x244
	bl FontAnimator__Init
	add r0, r4, #0x308
	bl FontWindowAnimator__Init
	mov r0, r4
	mov r1, #0
	bl SaveSpriteButton__SetState2
	mov r0, #0
	str r0, [r4, #0x37c]
	ldmia sp!, {r4, pc}
	arm_func_end SaveSpriteButton__Func_206515C

	arm_func_start SaveSpriteButton__Func_20651A4
SaveSpriteButton__Func_20651A4: // 0x020651A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0x37c]
	bl SaveSpriteButton__SetState2
	add r0, r4, #0x308
	bl FontWindowAnimator__Release
	add r0, r4, #0x244
	bl FontAnimator__Release
	mov r0, r4
	bl SaveSpriteButton__Release
	ldmia sp!, {r4, pc}
	arm_func_end SaveSpriteButton__Func_20651A4

	arm_func_start SaveSpriteButton__Func_20651D4
SaveSpriteButton__Func_20651D4: // 0x020651D4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x24
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	str r7, [r8, #0x374]
	bl SaveSpriteButton__Func_20656E8
	cmp r0, #0
	movne r0, #8
	moveq r0, #0xc
	mov r1, #6
	mov r0, r0, lsl #0x10
	str r1, [sp]
	mov r1, #0x18
	str r1, [sp, #4]
	mov r0, r0, lsr #0x10
	str r0, [sp, #8]
	ldrb r1, [sp, #0x40]
	str r6, [sp, #0xc]
	ldrb r0, [sp, #0x44]
	str r1, [sp, #0x10]
	ldr r1, [sp, #0x48]
	str r0, [sp, #0x14]
	and r4, r5, #0xff
	add r0, r8, #0x244
	mov r2, #0
	mov r3, #4
	str r4, [sp, #0x18]
	bl FontAnimator__LoadFont2
	ldr r1, [sp, #0x4c]
	add r0, r8, #0x244
	bl FontAnimator__LoadMPCFile
	add r0, r8, #0x244
	mov r1, #1
	bl FontAnimator__SetCallbackType
	add r0, r8, #0x244
	bl FontAnimator__LoadPaletteFunc2
	ldrh r1, [sp, #0x50]
	add r0, r8, #0x244
	bl FontAnimator__SetMsgSequence
	add r0, r8, #0x244
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	mov r0, r8
	bl SaveSpriteButton__Func_20656E8
	cmp r0, #0
	movne r4, #0x20
	add r0, r8, #0x244
	mov r1, #0
	moveq r4, #0x30
	bl FontAnimator__GetDialogLineCount
	mov r9, r0
	ldr r0, [sp, #0x48]
	bl FontFile__GetPixelHeight
	mul r0, r9, r0
	add r0, r0, r0, lsr #31
	sub r0, r4, r0, asr #1
	mov r1, r0, lsl #0x10
	add r0, r8, #0x244
	mov r1, r1, asr #0x10
	bl FontAnimator__AdvanceLine
	ldrh r2, [sp, #0x58]
	mov r1, #3
	mov r0, #5
	str r2, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, #0x1a
	str r0, [sp, #0xc]
	mov r0, #0xe
	str r0, [sp, #0x10]
	add r0, r5, #1
	ldrb r2, [sp, #0x40]
	str r6, [sp, #0x14]
	ldrb r1, [sp, #0x44]
	str r2, [sp, #0x18]
	mov r2, #0
	str r1, [sp, #0x1c]
	and r0, r0, #0xff
	str r0, [sp, #0x20]
	ldr r1, [sp, #0x48]
	add r0, r8, #0x308
	mov r3, r2
	bl FontWindowAnimator__Load2
	ldr r1, _020653A4 // =SaveSpriteButton__State2_20654B4
	mov r0, r8
	bl SaveSpriteButton__SetState2
	mov r0, r8
	bl SaveSpriteButton__Func_20656E8
	cmp r0, #0
	beq _02065388
	ldrb r1, [sp, #0x40]
	add r0, r5, #2
	mov r3, r0, lsl #0x10
	str r1, [sp]
	ldrb r4, [sp, #0x44]
	mov r0, r8
	mov r1, r7
	mov r2, r6
	mov r3, r3, lsr #0x10
	str r4, [sp, #4]
	bl SaveSpriteButton__Func_2064588
	ldrh r0, [sp, #0x58]
	cmp r0, #2
	ldreq r1, _020653A8 // =0x00000847
	addeq r0, r8, #0x200
	streqh r1, [r0, #0x30]
_02065388:
	add r0, r8, #0x300
	ldrsh r1, [r0, #0x70]
	ldrsh r2, [r0, #0x72]
	mov r0, r8
	bl SaveSpriteButton__Func_20653AC
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020653A4: .word SaveSpriteButton__State2_20654B4
_020653A8: .word 0x00000847
	arm_func_end SaveSpriteButton__Func_20651D4

	arm_func_start SaveSpriteButton__Func_20653AC
SaveSpriteButton__Func_20653AC: // 0x020653AC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	add r3, r6, #0x300
	mov r4, r2
	strh r5, [r3, #0x70]
	add r0, r6, #0x244
	strh r4, [r3, #0x72]
	bl FontAnimator__SetSpriteStartPos
	mov r1, r5
	mov r2, r4
	add r0, r6, #0x308
	bl FontWindowAnimator__Func_2059B88
	mov r0, r6
	bl SaveSpriteButton__Func_20656E8
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	add r0, r4, #0x20
	mov r1, r5, lsl #0x10
	mov r2, r0, lsl #0x10
	mov r0, r6
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	bl SaveSpriteButton__Func_20645D8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SaveSpriteButton__Func_20653AC

	arm_func_start SaveSpriteButton__RunState2
SaveSpriteButton__RunState2: // 0x02065410
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x36c]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	blx r1
	ldmia sp!, {r3, pc}
	arm_func_end SaveSpriteButton__RunState2

	arm_func_start SaveSpriteButton__CheckState2Thing
SaveSpriteButton__CheckState2Thing: // 0x02065428
	ldr r1, [r0, #0x36c]
	ldr r0, _02065450 // =SaveSpriteButton__State2_20655C4
	cmp r0, r1
	moveq r0, #1
	bxeq lr
	ldr r0, _02065454 // =SaveSpriteButton__State2_2065604
	cmp r0, r1
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_02065450: .word SaveSpriteButton__State2_20655C4
_02065454: .word SaveSpriteButton__State2_2065604
	arm_func_end SaveSpriteButton__CheckState2Thing

	arm_func_start SaveSpriteButton__CheckInvalidState2
SaveSpriteButton__CheckInvalidState2: // 0x02065458
	ldr r0, [r0, #0x36c]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end SaveSpriteButton__CheckInvalidState2

	arm_func_start SaveSpriteButton__Func_206546C
SaveSpriteButton__Func_206546C: // 0x0206546C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SaveSpriteButton__Func_20656E8
	cmp r0, #0
	beq _02065488
	mov r0, r4
	bl SaveSpriteButton__Func_2064614
_02065488:
	ldr r0, [r4, #0x37c]
	orr r0, r0, #1
	str r0, [r4, #0x37c]
	ldmia sp!, {r4, pc}
	arm_func_end SaveSpriteButton__Func_206546C

	arm_func_start SaveSpriteButton__Func_2065498
SaveSpriteButton__Func_2065498: // 0x02065498
	ldr ip, _020654A0 // =SaveSpriteButton__Func_2064660
	bx ip
	.align 2, 0
_020654A0: .word SaveSpriteButton__Func_2064660
	arm_func_end SaveSpriteButton__Func_2065498

	arm_func_start SaveSpriteButton__SetState2
SaveSpriteButton__SetState2: // 0x020654A4
	str r1, [r0, #0x36c]
	mov r1, #0
	str r1, [r0, #0x378]
	bx lr
	arm_func_end SaveSpriteButton__SetState2

	arm_func_start SaveSpriteButton__State2_20654B4
SaveSpriteButton__State2_20654B4: // 0x020654B4
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r3, #0
	add r0, r4, #0x308
	mov r1, #1
	mov r2, #0xa
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0x308
	bl FontWindowAnimator__StartAnimating
	ldr r1, _020654F4 // =SaveSpriteButton__State2_20654F8
	mov r0, r4
	bl SaveSpriteButton__SetState2
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_020654F4: .word SaveSpriteButton__State2_20654F8
	arm_func_end SaveSpriteButton__State2_20654B4

	arm_func_start SaveSpriteButton__State2_20654F8
SaveSpriteButton__State2_20654F8: // 0x020654F8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x308
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0x244
	mov r1, #4
	bl FontAnimator__LoadCharacters
	add r0, r4, #0x308
	bl FontWindowAnimator__Draw
	add r0, r4, #0x308
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x244
	bl FontAnimator__IsLastDialog
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl SaveSpriteButton__Func_20656D4
	cmp r0, #0
	beq _0206555C
	ldr r1, _0206556C // =SaveSpriteButton__State2_2065640
	mov r0, r4
	bl SaveSpriteButton__SetState2
	ldmia sp!, {r4, pc}
_0206555C:
	ldr r1, _02065570 // =SaveSpriteButton__State2_2065574
	mov r0, r4
	bl SaveSpriteButton__SetState2
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206556C: .word SaveSpriteButton__State2_2065640
_02065570: .word SaveSpriteButton__State2_2065574
	arm_func_end SaveSpriteButton__State2_20654F8

	arm_func_start SaveSpriteButton__State2_2065574
SaveSpriteButton__State2_2065574: // 0x02065574
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x244
	bl FontAnimator__Draw
	add r0, r4, #0x308
	bl FontWindowAnimator__Draw
	mov r0, r4
	bl SaveSpriteButton__Func_20656E8
	cmp r0, #0
	beq _020655AC
	ldr r1, _020655BC // =SaveSpriteButton__State2_20655C4
	mov r0, r4
	bl SaveSpriteButton__SetState2
	ldmia sp!, {r4, pc}
_020655AC:
	ldr r1, _020655C0 // =SaveSpriteButton__State2_2065604
	mov r0, r4
	bl SaveSpriteButton__SetState2
	ldmia sp!, {r4, pc}
	.align 2, 0
_020655BC: .word SaveSpriteButton__State2_20655C4
_020655C0: .word SaveSpriteButton__State2_2065604
	arm_func_end SaveSpriteButton__State2_2065574

	arm_func_start SaveSpriteButton__State2_20655C4
SaveSpriteButton__State2_20655C4: // 0x020655C4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SaveSpriteButton__RunState
	add r0, r4, #0x244
	bl FontAnimator__Draw
	add r0, r4, #0x308
	bl FontWindowAnimator__Draw
	mov r0, r4
	bl SaveSpriteButton__CheckInvalidState
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _02065600 // =SaveSpriteButton__State2_2065640
	mov r0, r4
	bl SaveSpriteButton__SetState2
	ldmia sp!, {r4, pc}
	.align 2, 0
_02065600: .word SaveSpriteButton__State2_2065640
	arm_func_end SaveSpriteButton__State2_20655C4

	arm_func_start SaveSpriteButton__State2_2065604
SaveSpriteButton__State2_2065604: // 0x02065604
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x244
	bl FontAnimator__Draw
	add r0, r4, #0x308
	bl FontWindowAnimator__Draw
	mov r0, r4
	bl SaveSpriteButton__Func_20656D4
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _0206563C // =SaveSpriteButton__State2_2065640
	mov r0, r4
	bl SaveSpriteButton__SetState2
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206563C: .word SaveSpriteButton__State2_2065640
	arm_func_end SaveSpriteButton__State2_2065604

	arm_func_start SaveSpriteButton__State2_2065640
SaveSpriteButton__State2_2065640: // 0x02065640
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	add r0, r4, #0x244
	bl FontAnimator__Draw
	add r0, r4, #0x308
	bl FontWindowAnimator__Draw
	add r0, r4, #0x244
	bl FontAnimator__ClearPixels
	mov r3, #0
	str r3, [sp]
	add r0, r4, #0x308
	mov r1, #4
	mov r2, #0xa
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0x308
	bl FontWindowAnimator__StartAnimating
	mov r0, r4
	ldr r1, _02065698 // =SaveSpriteButton__State2_206569C
	bl SaveSpriteButton__SetState2
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02065698: .word SaveSpriteButton__State2_206569C
	arm_func_end SaveSpriteButton__State2_2065640

	arm_func_start SaveSpriteButton__State2_206569C
SaveSpriteButton__State2_206569C: // 0x0206569C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x308
	bl FontWindowAnimator__Draw
	add r0, r4, #0x308
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0x308
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0
	bl SaveSpriteButton__SetState2
	ldmia sp!, {r4, pc}
	arm_func_end SaveSpriteButton__State2_206569C

	arm_func_start SaveSpriteButton__Func_20656D4
SaveSpriteButton__Func_20656D4: // 0x020656D4
	ldr r0, [r0, #0x37c]
	tst r0, #1
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end SaveSpriteButton__Func_20656D4

	arm_func_start SaveSpriteButton__Func_20656E8
SaveSpriteButton__Func_20656E8: // 0x020656E8
	ldr r0, [r0, #0x374]
	cmp r0, #3
	bne _020656FC
	mov r0, #0
	bx lr
_020656FC:
	mov r0, #1
	bx lr
	arm_func_end SaveSpriteButton__Func_20656E8

	.data
	
aBbDmwfYesBb: // 0x02119EB4
	.asciz "bb/dmwf_yes.bb"
	.align 4

aBbNlBb_0: // 0x02119EC4
	.asciz "bb/nl.bb"
	.align 4