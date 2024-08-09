	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start ViEvtCmnMsg__Constructor
ViEvtCmnMsg__Constructor: // 0x0216B94C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, _0216B988 // =0x021739DC
	add r0, r4, #0x20
	str r1, [r4]
	bl FontAnimator__Init
	add r0, r4, #0xe4
	bl FontWindowAnimator__Init
	mov r1, #0
	str r1, [r4, #0x1ac]
	mov r0, r4
	str r1, [r4, #0x218]
	bl ViEvtCmnMsg__Func_216BC08
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B988: .word 0x021739DC
	arm_func_end ViEvtCmnMsg__Constructor

	arm_func_start ViEvtCmnMsg__VTableFunc_216B98C
ViEvtCmnMsg__VTableFunc_216B98C: // 0x0216B98C
	stmdb sp!, {r4, lr}
	ldr r1, _0216B9A8 // =0x021739DC
	mov r4, r0
	str r1, [r4]
	bl ViEvtCmnMsg__Func_216BC08
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B9A8: .word 0x021739DC
	arm_func_end ViEvtCmnMsg__VTableFunc_216B98C

	arm_func_start ViEvtCmnMsg__VTableFunc_216B9AC
ViEvtCmnMsg__VTableFunc_216B9AC: // 0x0216B9AC
	stmdb sp!, {r4, lr}
	ldr r1, _0216B9D0 // =0x021739DC
	mov r4, r0
	str r1, [r4]
	bl ViEvtCmnMsg__Func_216BC08
	mov r0, r4
	bl CPPHelpers__Free
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B9D0: .word 0x021739DC
	arm_func_end ViEvtCmnMsg__VTableFunc_216B9AC

	arm_func_start ViEvtCmnMsg__Func_216B9D4
ViEvtCmnMsg__Func_216B9D4: // 0x0216B9D4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x28
	mov r4, r0
	mov r5, r1
	bl ViEvtCmnMsg__Func_216BC08
	str r5, [r4, #0xc]
	bl HubControl__GetField54
	mov r3, #3
	mov r1, r0
	str r3, [sp]
	mov r0, #0x1a
	str r0, [sp, #4]
	mov r0, #6
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r3, #0x80
	str r3, [sp, #0x18]
	add r0, r4, #0x20
	mov r3, #2
	bl FontAnimator__LoadFont1
	add r0, r4, #0x20
	bl FontAnimator__ClearPixels
	bl HubControl__GetField54
	mov r3, #2
	mov r1, r0
	str r3, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r2, [sp, #8]
	mov r0, #0x20
	str r0, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #3
	str r0, [sp, #0x1c]
	mov r0, #0x3c0
	str r0, [sp, #0x20]
	add r0, r0, #0x3f
	str r0, [sp, #0x24]
	add r0, r4, #0xe4
	mov r3, r2
	bl FontWindowAnimator__Load1
	ldr r1, [r4, #0xc]
	add r0, r4, #0x20
	bl FontAnimator__LoadMPCFile
	add r0, r4, #0x20
	bl FontAnimator__ClearPixels
	add r0, r4, #0x20
	bl FontAnimator__Draw
	add r0, r4, #0x20
	bl FontAnimator__LoadPaletteFunc
	add r0, r4, #0x20
	bl FontAnimator__LoadMappingsFunc
	add r0, r4, #0xe4
	bl FontWindowAnimator__SetWindowClosed
	mov r0, #8
	str r0, [r4, #4]
	str r0, [r4, #8]
	bl HubControl__GetTKDMNameSprite
	str r0, [r4, #0x1b0]
	bl Sprite__GetSpriteSize1
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	str r0, [r4, #0x1ac]
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	ldr r1, [r4, #0x1ac]
	ldr r0, _0216BBF8 // =0x05000200
	str r1, [sp, #8]
	str r2, [sp, #0xc]
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	ldr r1, [r4, #0x1b0]
	mov r3, r2
	add r0, r4, #0x148
	bl AnimatorSprite__Init
	add r1, r4, #0x100
	mov r0, #8
	strh r0, [r1, #0x50]
	strh r0, [r1, #0x52]
	mov r0, #6
	strh r0, [r1, #0x98]
	bl HubControl__GetFileFrom_ViAct
	str r0, [r4, #0x21c]
	bl Sprite__GetSpriteSize1
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	str r0, [r4, #0x218]
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	ldr r1, [r4, #0x218]
	ldr r0, _0216BBF8 // =0x05000200
	str r1, [sp, #8]
	str r2, [sp, #0xc]
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	ldr r1, [r4, #0x21c]
	add r0, r4, #0x1b4
	mov r3, #4
	bl AnimatorSprite__Init
	mov r1, #0xe0
	add r0, r4, #0x100
	strh r1, [r0, #0xbc]
	mov r1, #0x30
	strh r1, [r0, #0xbe]
	mov r1, #4
	add r0, r4, #0x200
	strh r1, [r0, #4]
	mov r0, #0
	str r0, [r4, #0x220]
	str r0, [r4, #0x224]
	add r0, r4, #0x260
	bl TouchField__Init
	ldr r1, _0216BBFC // =ViEvtCmnTalk__Func_216DC84
	ldr r2, _0216BC00 // =TouchField__PointInRect
	stmia sp, {r1, r4}
	mov r1, #0
	add r0, r4, #0x228
	mov r3, r1
	bl TouchField__InitAreaShape
	ldr r2, _0216BC04 // =0x0000FFFF
	add r0, r4, #0x260
	add r1, r4, #0x228
	bl TouchField__AddArea
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216BBF8: .word 0x05000200
_0216BBFC: .word ViEvtCmnTalk__Func_216DC84
_0216BC00: .word TouchField__PointInRect
_0216BC04: .word 0x0000FFFF
	arm_func_end ViEvtCmnMsg__Func_216B9D4

	arm_func_start ViEvtCmnMsg__Func_216BC08
ViEvtCmnMsg__Func_216BC08: // 0x0216BC08
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x218]
	cmp r0, #0
	beq _0216BC2C
	add r0, r4, #0x1b4
	bl AnimatorSprite__Release
	mov r0, #0
	str r0, [r4, #0x218]
_0216BC2C:
	ldr r0, [r4, #0x1ac]
	cmp r0, #0
	beq _0216BC48
	add r0, r4, #0x148
	bl AnimatorSprite__Release
	mov r0, #0
	str r0, [r4, #0x1ac]
_0216BC48:
	add r0, r4, #0xe4
	bl FontWindowAnimator__Release
	add r0, r4, #0x20
	bl FontAnimator__Release
	mov r0, #8
	str r0, [r4, #4]
	str r0, [r4, #8]
	mov r1, #0
	ldr r0, _0216BCA4 // =0x0000FFFF
	str r1, [r4, #0xc]
	strh r0, [r4, #0x10]
	strh r0, [r4, #0x12]
	strh r0, [r4, #0x14]
	strh r0, [r4, #0x16]
	strh r0, [r4, #0x18]
	strh r1, [r4, #0x1a]
	mov r0, #1
	str r0, [r4, #0x1c]
	str r0, [r4, #0x278]
	str r1, [r4, #0x1b0]
	str r1, [r4, #0x21c]
	str r1, [r4, #0x27c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216BCA4: .word 0x0000FFFF
	arm_func_end ViEvtCmnMsg__Func_216BC08

	arm_func_start ViEvtCmnMsg__Func_216BCA8
ViEvtCmnMsg__Func_216BCA8: // 0x0216BCA8
	mov ip, #0
	str ip, [r0, #8]
	strh r1, [r0, #0x10]
	strh r2, [r0, #0x12]
	ldrh r2, [sp]
	strh r3, [r0, #0x14]
	ldr r1, [sp, #4]
	strh r2, [r0, #0x16]
	str r1, [r0, #0x1c]
	mov r1, #1
	str r1, [r0, #0x278]
	str ip, [r0, #0x280]
	bx lr
	arm_func_end ViEvtCmnMsg__Func_216BCA8

	arm_func_start ViEvtCmnMsg__Func_216BCDC
ViEvtCmnMsg__Func_216BCDC: // 0x0216BCDC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	ldr r0, [r4, #0xc]
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl MPC__GetUnknownCount
	cmp r7, r0
	blo _0216BD34
	mov r1, #5
	ldr r0, _0216BD6C // =0x0000FFFF
	str r1, [r4, #8]
	strh r0, [r4, #0x10]
	strh r0, [r4, #0x12]
	strh r0, [r4, #0x14]
	strh r0, [r4, #0x16]
	mov r0, #1
	str r0, [r4, #0x1c]
	str r0, [r4, #0x278]
	mov r0, #0
	str r0, [r4, #0x280]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0216BD34:
	mov r0, #2
	str r0, [r4, #8]
	strh r7, [r4, #0x10]
	strh r6, [r4, #0x12]
	ldrh r1, [sp, #0x18]
	strh r5, [r4, #0x14]
	ldr r0, [sp, #0x1c]
	strh r1, [r4, #0x16]
	str r0, [r4, #0x1c]
	mov r0, #1
	str r0, [r4, #0x278]
	mov r0, #0
	str r0, [r4, #0x280]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216BD6C: .word 0x0000FFFF
	arm_func_end ViEvtCmnMsg__Func_216BCDC

	arm_func_start ViEvtCmnMsg__Func_216BD70
ViEvtCmnMsg__Func_216BD70: // 0x0216BD70
	strh r1, [r0, #0x14]
	strh r2, [r0, #0x16]
	bx lr
	arm_func_end ViEvtCmnMsg__Func_216BD70

	arm_func_start ViEvtCmnMsg__Func_216BD7C
ViEvtCmnMsg__Func_216BD7C: // 0x0216BD7C
	ldrh r1, [r0, #0x14]
	ldr r0, _0216BD94 // =0x0000FFFF
	cmp r1, r0
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_0216BD94: .word 0x0000FFFF
	arm_func_end ViEvtCmnMsg__Func_216BD7C

	arm_func_start ViEvtCmnMsg__Func_216BD98
ViEvtCmnMsg__Func_216BD98: // 0x0216BD98
	str r1, [r0, #0x1c]
	bx lr
	arm_func_end ViEvtCmnMsg__Func_216BD98

	arm_func_start ViEvtCmnMsg__Func_216BDA0
ViEvtCmnMsg__Func_216BDA0: // 0x0216BDA0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r3, [r4, #0x278]
	ldr r2, [r4, #8]
	mov r1, #0
	str r2, [r4, #4]
	str r1, [r4, #0x278]
	ldr r1, [r4, #4]
	cmp r1, #6
	addls pc, pc, r1, lsl #2
	ldmia sp!, {r4, pc}
_0216BDCC: // jump table
	b _0216BDE8 // case 0
	b _0216BE10 // case 1
	b _0216BE38 // case 2
	b _0216BE60 // case 3
	ldmia sp!, {r4, pc} // case 4
	b _0216BE88 // case 5
	b _0216BEB0 // case 6
_0216BDE8:
	cmp r3, #0
	beq _0216BDF4
	bl ViEvtCmnMsg__Func_216BF2C
_0216BDF4:
	mov r0, r4
	bl ViEvtCmnMsg__Func_216BF3C
	str r0, [r4, #8]
	cmp r0, #0
	movne r0, #1
	strne r0, [r4, #0x278]
	ldmia sp!, {r4, pc}
_0216BE10:
	cmp r3, #0
	beq _0216BE1C
	bl ViEvtCmnMsg__Func_216BF58
_0216BE1C:
	mov r0, r4
	bl ViEvtCmnMsg__Func_216BFA0
	str r0, [r4, #8]
	cmp r0, #1
	movne r0, #1
	strne r0, [r4, #0x278]
	ldmia sp!, {r4, pc}
_0216BE38:
	cmp r3, #0
	beq _0216BE44
	bl ViEvtCmnMsg__Func_216BFE8
_0216BE44:
	mov r0, r4
	bl ViEvtCmnMsg__Func_216C044
	str r0, [r4, #8]
	cmp r0, #2
	movne r0, #1
	strne r0, [r4, #0x278]
	ldmia sp!, {r4, pc}
_0216BE60:
	cmp r3, #0
	beq _0216BE6C
	bl ViEvtCmnMsg__Func_216C2C4
_0216BE6C:
	mov r0, r4
	bl ViEvtCmnMsg__Func_216C2D4
	str r0, [r4, #8]
	cmp r0, #3
	movne r0, #1
	strne r0, [r4, #0x278]
	ldmia sp!, {r4, pc}
_0216BE88:
	cmp r3, #0
	beq _0216BE94
	bl ViEvtCmnMsg__Func_216C31C
_0216BE94:
	mov r0, r4
	bl ViEvtCmnMsg__Func_216C36C
	str r0, [r4, #8]
	cmp r0, #5
	movne r0, #1
	strne r0, [r4, #0x278]
	ldmia sp!, {r4, pc}
_0216BEB0:
	cmp r3, #0
	beq _0216BEBC
	bl ViEvtCmnMsg__Func_216C3B4
_0216BEBC:
	mov r0, r4
	bl ViEvtCmnMsg__Func_216C3B8
	str r0, [r4, #8]
	cmp r0, #6
	movne r0, #1
	strne r0, [r4, #0x278]
	ldmia sp!, {r4, pc}
	arm_func_end ViEvtCmnMsg__Func_216BDA0

	arm_func_start ViEvtCmnMsg__Func_216BED8
ViEvtCmnMsg__Func_216BED8: // 0x0216BED8
	ldr r1, [r0, #4]
	ldr r0, [r0, #8]
	cmp r1, r0
	movne r0, #0
	bxne lr
	cmp r1, #8
	cmpne r1, #3
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ViEvtCmnMsg__Func_216BED8

	arm_func_start ViEvtCmnMsg__Func_216BF00
ViEvtCmnMsg__Func_216BF00: // 0x0216BF00
	stmdb sp!, {r3, lr}
	ldr r2, [r0, #0x220]
	cmp r2, #1
	subls r2, r1, #2
	cmpls r2, #1
	ldmlsia sp!, {r3, pc}
	bl ViEvtCmnMsg__Func_216C448
	ldmia sp!, {r3, pc}
	arm_func_end ViEvtCmnMsg__Func_216BF00

	arm_func_start ViEvtCmnMsg__Func_216BF20
ViEvtCmnMsg__Func_216BF20: // 0x0216BF20
	mov r1, #1
	str r1, [r0, #0x224]
	bx lr
	arm_func_end ViEvtCmnMsg__Func_216BF20

	arm_func_start ViEvtCmnMsg__Func_216BF2C
ViEvtCmnMsg__Func_216BF2C: // 0x0216BF2C
	ldr ip, _0216BF38 // =ViEvtCmnMsg__Func_216C448
	mov r1, #0
	bx ip
	.align 2, 0
_0216BF38: .word ViEvtCmnMsg__Func_216C448
	arm_func_end ViEvtCmnMsg__Func_216BF2C

	arm_func_start ViEvtCmnMsg__Func_216BF3C
ViEvtCmnMsg__Func_216BF3C: // 0x0216BF3C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ViEvtCmnMsg__Func_216C4D4
	mov r0, r4
	bl ViEvtCmnMsg__Func_216C4F4
	mov r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end ViEvtCmnMsg__Func_216BF3C

	arm_func_start ViEvtCmnMsg__Func_216BF58
ViEvtCmnMsg__Func_216BF58: // 0x0216BF58
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r3, #0
	add r0, r4, #0xe4
	mov r1, #1
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xe4
	bl FontWindowAnimator__StartAnimating
	add r0, r4, #0xe4
	bl FontWindowAnimator__Draw
	mov r0, r4
	mov r1, #0
	bl ViEvtCmnMsg__Func_216C448
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end ViEvtCmnMsg__Func_216BF58

	arm_func_start ViEvtCmnMsg__Func_216BFA0
ViEvtCmnMsg__Func_216BFA0: // 0x0216BFA0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0xe4
	mov r4, #1
	bl FontWindowAnimator__ProcessWindowAnim
	mov r0, r5
	bl ViEvtCmnMsg__Func_216C4D4
	mov r0, r5
	bl ViEvtCmnMsg__Func_216C4F4
	add r0, r5, #0xe4
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _0216BFE0
	add r0, r5, #0xe4
	bl FontWindowAnimator__SetWindowOpen
	mov r4, #2
_0216BFE0:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViEvtCmnMsg__Func_216BFA0

	arm_func_start ViEvtCmnMsg__Func_216BFE8
ViEvtCmnMsg__Func_216BFE8: // 0x0216BFE8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r1, [r4, #0x12]
	ldrh r0, [r4, #0x18]
	cmp r1, r0
	beq _0216C01C
	ldr r0, _0216C040 // =0x0000FFFF
	cmp r1, r0
	beq _0216C014
	add r0, r4, #0x148
	bl AnimatorSprite__SetAnimation
_0216C014:
	ldrh r0, [r4, #0x12]
	strh r0, [r4, #0x18]
_0216C01C:
	ldrh r1, [r4, #0x10]
	add r0, r4, #0x20
	bl FontAnimator__SetMsgSequence
	mov r0, r4
	mov r1, #1
	bl ViEvtCmnMsg__Func_216C448
	mov r0, #0
	str r0, [r4, #0x27c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216C040: .word 0x0000FFFF
	arm_func_end ViEvtCmnMsg__Func_216BFE8

	arm_func_start ViEvtCmnMsg__Func_216C044
ViEvtCmnMsg__Func_216C044: // 0x0216C044
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	add r0, r7, #0x260
	mov r4, #0
	bl TouchField__Process
	mov r0, r7
	bl ViEvtCmnMsg__Func_216C3F4
	cmp r0, #0
	bne _0216C078
	mov r0, r7
	bl ViEvtCmnMsg__Func_216C510
	cmp r0, #0
	beq _0216C080
_0216C078:
	mov r6, #1
	b _0216C084
_0216C080:
	mov r6, r4
_0216C084:
	mov r0, r7
	bl ViEvtCmnMsg__Func_216C410
	mov r5, r0
	add r0, r7, #0x20
	bl FontAnimator__IsLastDialog
	cmp r0, #0
	beq _0216C1B8
	mov r0, r7
	bl ViEvtCmnMsg__Func_216BD7C
	cmp r0, #0
	beq _0216C140
	ldr r0, [r7, #0x1c]
	cmp r0, #0
	beq _0216C100
	cmp r6, #0
	bne _0216C0D8
	cmp r5, #0
	beq _0216C1FC
	ldr r0, [r7, #0x27c]
	cmp r0, #4
	blo _0216C1FC
_0216C0D8:
	add r0, r7, #0x20
	bl FontAnimator__ClearPixels
	add r0, r7, #0x20
	bl FontAnimator__Draw
	mov r0, r7
	bl ViEvtCmnMsg__Func_216C4D4
	mov r0, r7
	bl ViEvtCmnMsg__Func_216C4F4
	mov r0, #5
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0216C100:
	ldrh r1, [r7, #0x12]
	ldr r0, _0216C2C0 // =0x0000FFFF
	cmp r1, r0
	beq _0216C128
	mov r1, #0
	mov r2, r1
	add r0, r7, #0x148
	bl AnimatorSprite__ProcessAnimation
	add r0, r7, #0x148
	bl AnimatorSprite__DrawFrame
_0216C128:
	mov r0, r7
	bl ViEvtCmnMsg__Func_216C4D4
	mov r0, r7
	bl ViEvtCmnMsg__Func_216C4F4
	mov r0, #3
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0216C140:
	cmp r6, #0
	bne _0216C15C
	cmp r5, #0
	beq _0216C1FC
	ldr r0, [r7, #0x27c]
	cmp r0, #4
	blo _0216C1FC
_0216C15C:
	ldrh r2, [r7, #0x14]
	ldr r1, _0216C2C0 // =0x0000FFFF
	add r0, r7, #0x20
	strh r2, [r7, #0x10]
	ldrh r2, [r7, #0x16]
	strh r2, [r7, #0x12]
	strh r1, [r7, #0x14]
	strh r1, [r7, #0x16]
	ldrh r1, [r7, #0x10]
	bl FontAnimator__SetMsgSequence
	ldrh r1, [r7, #0x12]
	ldrh r0, [r7, #0x18]
	cmp r1, r0
	beq _0216C1B0
	ldr r0, _0216C2C0 // =0x0000FFFF
	cmp r1, r0
	beq _0216C1A8
	add r0, r7, #0x148
	bl AnimatorSprite__SetAnimation
_0216C1A8:
	ldrh r0, [r7, #0x12]
	strh r0, [r7, #0x18]
_0216C1B0:
	mov r4, #1
	b _0216C1FC
_0216C1B8:
	add r0, r7, #0x20
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	beq _0216C1FC
	cmp r6, #0
	bne _0216C1E4
	cmp r5, #0
	beq _0216C1FC
	ldr r0, [r7, #0x27c]
	cmp r0, #4
	blo _0216C1FC
_0216C1E4:
	add r0, r7, #0x20
	bl FontAnimator__AdvanceDialog
	mov r4, #1
	mov r0, r7
	mov r1, r4
	bl ViEvtCmnMsg__Func_216C448
_0216C1FC:
	add r0, r7, #0x20
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	beq _0216C23C
	ldr r0, [r7, #0x27c]
	add r0, r0, #1
	str r0, [r7, #0x27c]
	cmp r0, #1
	bls _0216C244
	ldr r0, [r7, #0x220]
	cmp r0, #1
	bhi _0216C244
	mov r0, r7
	mov r1, #2
	bl ViEvtCmnMsg__Func_216C448
	b _0216C244
_0216C23C:
	mov r0, #0
	str r0, [r7, #0x27c]
_0216C244:
	cmp r6, #0
	beq _0216C254
	cmp r4, #0
	beq _0216C25C
_0216C254:
	cmp r5, #0
	beq _0216C26C
_0216C25C:
	add r0, r7, #0x20
	mov r1, #0
	bl FontAnimator__LoadCharacters
	b _0216C278
_0216C26C:
	add r0, r7, #0x20
	mov r1, #1
	bl FontAnimator__LoadCharacters
_0216C278:
	ldrh r1, [r7, #0x12]
	ldr r0, _0216C2C0 // =0x0000FFFF
	cmp r1, r0
	beq _0216C2A0
	mov r1, #0
	mov r2, r1
	add r0, r7, #0x148
	bl AnimatorSprite__ProcessAnimation
	add r0, r7, #0x148
	bl AnimatorSprite__DrawFrame
_0216C2A0:
	add r0, r7, #0x20
	bl FontAnimator__Draw
	mov r0, r7
	bl ViEvtCmnMsg__Func_216C4D4
	mov r0, r7
	bl ViEvtCmnMsg__Func_216C4F4
	mov r0, #2
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216C2C0: .word 0x0000FFFF
	arm_func_end ViEvtCmnMsg__Func_216C044

	arm_func_start ViEvtCmnMsg__Func_216C2C4
ViEvtCmnMsg__Func_216C2C4: // 0x0216C2C4
	ldr ip, _0216C2D0 // =ViEvtCmnMsg__Func_216C448
	mov r1, #1
	bx ip
	.align 2, 0
_0216C2D0: .word ViEvtCmnMsg__Func_216C448
	arm_func_end ViEvtCmnMsg__Func_216C2C4

	arm_func_start ViEvtCmnMsg__Func_216C2D4
ViEvtCmnMsg__Func_216C2D4: // 0x0216C2D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ViEvtCmnMsg__Func_216C4D4
	mov r0, r4
	bl ViEvtCmnMsg__Func_216C4F4
	ldrh r1, [r4, #0x12]
	ldr r0, _0216C318 // =0x0000FFFF
	cmp r1, r0
	beq _0216C310
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x148
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x148
	bl AnimatorSprite__DrawFrame
_0216C310:
	mov r0, #3
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216C318: .word 0x0000FFFF
	arm_func_end ViEvtCmnMsg__Func_216C2D4

	arm_func_start ViEvtCmnMsg__Func_216C31C
ViEvtCmnMsg__Func_216C31C: // 0x0216C31C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r3, #0
	add r0, r4, #0xe4
	mov r1, #4
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xe4
	bl FontWindowAnimator__StartAnimating
	add r0, r4, #0x20
	bl FontAnimator__ClearPixels
	add r0, r4, #0x20
	bl FontAnimator__Draw
	mov r0, r4
	mov r1, #0
	bl ViEvtCmnMsg__Func_216C448
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end ViEvtCmnMsg__Func_216C31C

	arm_func_start ViEvtCmnMsg__Func_216C36C
ViEvtCmnMsg__Func_216C36C: // 0x0216C36C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0xe4
	mov r4, #5
	bl FontWindowAnimator__ProcessWindowAnim
	mov r0, r5
	bl ViEvtCmnMsg__Func_216C4D4
	mov r0, r5
	bl ViEvtCmnMsg__Func_216C4F4
	add r0, r5, #0xe4
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _0216C3AC
	add r0, r5, #0xe4
	bl FontWindowAnimator__SetWindowClosed
	mov r4, #6
_0216C3AC:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViEvtCmnMsg__Func_216C36C

	arm_func_start ViEvtCmnMsg__Func_216C3B4
ViEvtCmnMsg__Func_216C3B4: // 0x0216C3B4
	bx lr
	arm_func_end ViEvtCmnMsg__Func_216C3B4

	arm_func_start ViEvtCmnMsg__Func_216C3B8
ViEvtCmnMsg__Func_216C3B8: // 0x0216C3B8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xe4
	bl FontWindowAnimator__SetWindowOpen
	ldr r1, _0216C3F0 // =0x0000FFFF
	mov r0, #0
	strh r1, [r4, #0x10]
	strh r1, [r4, #0x12]
	strh r1, [r4, #0x14]
	strh r1, [r4, #0x16]
	strh r1, [r4, #0x18]
	str r0, [r4, #0x27c]
	mov r0, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216C3F0: .word 0x0000FFFF
	arm_func_end ViEvtCmnMsg__Func_216C3B8

	arm_func_start ViEvtCmnMsg__Func_216C3F4
ViEvtCmnMsg__Func_216C3F4: // 0x0216C3F4
	ldr r0, _0216C40C // =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0216C40C: .word padInput
	arm_func_end ViEvtCmnMsg__Func_216C3F4

	arm_func_start ViEvtCmnMsg__Func_216C410
ViEvtCmnMsg__Func_216C410: // 0x0216C410
	ldr r1, _0216C444 // =padInput
	ldrh r1, [r1]
	tst r1, #2
	beq _0216C434
	ldr r0, [r0, #0x280]
	cmp r0, #0
	beq _0216C43C
	mov r0, #1
	bx lr
_0216C434:
	mov r1, #1
	str r1, [r0, #0x280]
_0216C43C:
	mov r0, #0
	bx lr
	.align 2, 0
_0216C444: .word padInput
	arm_func_end ViEvtCmnMsg__Func_216C410

	arm_func_start ViEvtCmnMsg__Func_216C448
ViEvtCmnMsg__Func_216C448: // 0x0216C448
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0x220]
	mov r5, r1
	cmp r5, r0
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r5, #3
	mov r4, #1
	addls pc, pc, r5, lsl #2
	b _0216C4B0
_0216C470: // jump table
	b _0216C480 // case 0
	b _0216C488 // case 1
	b _0216C490 // case 2
	b _0216C4A0 // case 3
_0216C480:
	mov r1, #0
	b _0216C4B4
_0216C488:
	mov r1, #0
	b _0216C4B4
_0216C490:
	cmp r0, #3
	mov r1, #2
	moveq r4, #0
	b _0216C4B4
_0216C4A0:
	mov r1, r4
	cmp r0, #2
	moveq r4, #0
	b _0216C4B4
_0216C4B0:
	ldmia sp!, {r4, r5, r6, pc}
_0216C4B4:
	add r0, r6, #0x1b4
	bl AnimatorSprite__SetAnimation
	cmp r4, #0
	beq _0216C4CC
	add r0, r6, #0x228
	bl TouchField__ResetArea
_0216C4CC:
	str r5, [r6, #0x220]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ViEvtCmnMsg__Func_216C448

	arm_func_start ViEvtCmnMsg__Func_216C4D4
ViEvtCmnMsg__Func_216C4D4: // 0x0216C4D4
	ldr ip, _0216C4EC // =AnimatorSprite__ProcessAnimation
	mov r2, r0
	add r0, r2, #0x1b4
	ldr r1, _0216C4F0 // =ViEvtCmnTalk__Func_216DC14
	add r2, r2, #0x228
	bx ip
	.align 2, 0
_0216C4EC: .word AnimatorSprite__ProcessAnimation
_0216C4F0: .word ViEvtCmnTalk__Func_216DC14
	arm_func_end ViEvtCmnMsg__Func_216C4D4

	arm_func_start ViEvtCmnMsg__Func_216C4F4
ViEvtCmnMsg__Func_216C4F4: // 0x0216C4F4
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x220]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	add r0, r0, #0x1b4
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, pc}
	arm_func_end ViEvtCmnMsg__Func_216C4F4

	arm_func_start ViEvtCmnMsg__Func_216C510
ViEvtCmnMsg__Func_216C510: // 0x0216C510
	ldr r2, [r0, #0x224]
	mov r1, #0
	str r1, [r0, #0x224]
	mov r0, r2
	bx lr
	arm_func_end ViEvtCmnMsg__Func_216C510

	arm_func_start ViEvtCmnSelect__Constructor
ViEvtCmnSelect__Constructor: // 0x0216C524
	stmdb sp!, {r4, lr}
	ldr r1, _0216C574 // =0x021739CC
	mov r4, r0
	str r1, [r4]
	mov r1, #0
	add r0, r4, #0x34
	str r1, [r4, #0x10]
	bl FontAnimator__Init
	add r0, r4, #0xf8
	bl FontWindowAnimator__Init
	add r0, r4, #0x15c
	bl FontWindowMWControl__Init
	add r1, r4, #0x1b0
	mov r0, #0
	mov r2, #0x64
	bl MIi_CpuClear16
	mov r0, r4
	bl ViEvtCmnSelect__Func_216C70C
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216C574: .word 0x021739CC
	arm_func_end ViEvtCmnSelect__Constructor

	arm_func_start ViEvtCmnSelect__VTableFunc_216C578
ViEvtCmnSelect__VTableFunc_216C578: // 0x0216C578
	stmdb sp!, {r4, lr}
	ldr r1, _0216C594 // =0x021739CC
	mov r4, r0
	str r1, [r4]
	bl ViEvtCmnSelect__Func_216C70C
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216C594: .word 0x021739CC
	arm_func_end ViEvtCmnSelect__VTableFunc_216C578

	arm_func_start ViEvtCmnSelect__VTableFunc_216C598
ViEvtCmnSelect__VTableFunc_216C598: // 0x0216C598
	stmdb sp!, {r4, lr}
	ldr r1, _0216C5BC // =0x021739CC
	mov r4, r0
	str r1, [r4]
	bl ViEvtCmnSelect__Func_216C70C
	mov r0, r4
	bl CPPHelpers__Free
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216C5BC: .word 0x021739CC
	arm_func_end ViEvtCmnSelect__VTableFunc_216C598

	arm_func_start ViEvtCmnSelect__Func_216C5C0
ViEvtCmnSelect__Func_216C5C0: // 0x0216C5C0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	mov r5, r1
	bl ViEvtCmnSelect__Func_216C70C
	str r5, [r4, #0x10]
	bl HubControl__GetField54
	mov r2, #0xb
	mov r1, r0
	str r2, [sp]
	mov r0, #0x1e
	str r0, [sp, #4]
	mov r0, #8
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	mov r0, #3
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r0, #0x128
	str r0, [sp, #0x18]
	add r0, r4, #0x34
	mov r3, #1
	bl FontAnimator__LoadFont1
	add r0, r4, #0x34
	ldr r1, [r4, #0x10]
	bl FontAnimator__LoadMPCFile
	add r0, r4, #0x34
	bl FontAnimator__ClearPixels
	add r0, r4, #0x34
	bl FontAnimator__Draw
	add r0, r4, #0x34
	bl FontAnimator__LoadPaletteFunc
	add r0, r4, #0x34
	bl FontAnimator__LoadMappingsFunc
	bl HubControl__GetField54
	mov r1, r0
	mov r0, #8
	str r0, [sp]
	str r0, [sp, #4]
	mov r2, #0
	str r2, [sp, #8]
	mov r3, #1
	str r3, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r0, #5
	str r0, [sp, #0x14]
	add r0, r4, #0x15c
	bl FontWindowMWControl__Load
	mov r0, #0xb
	bl HubControl__GetFileFrom_ViAct
	mov r5, r0
	mov r1, #0
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r5
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r3, _0216C708 // =0x05000200
	add r0, r4, #0x1b0
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r3, #4
	bl AnimatorSprite__Init
	mov r1, #0
	mov r2, r1
	add r3, r4, #0x200
	mov ip, #7
	add r0, r4, #0x1b0
	strh ip, [r3]
	bl AnimatorSprite__ProcessAnimation
	mov r0, #8
	str r0, [r4, #4]
	str r0, [r4, #8]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216C708: .word 0x05000200
	arm_func_end ViEvtCmnSelect__Func_216C5C0

	arm_func_start ViEvtCmnSelect__Func_216C70C
ViEvtCmnSelect__Func_216C70C: // 0x0216C70C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x1b0
	bl AnimatorSprite__Release
	add r1, r4, #0x1b0
	mov r0, #0
	mov r2, #0x64
	bl MIi_CpuClear16
	add r0, r4, #0x15c
	bl FontWindowMWControl__Release
	add r0, r4, #0xf8
	bl FontWindowAnimator__Release
	add r0, r4, #0x34
	bl FontAnimator__Release
	mov r0, #8
	str r0, [r4, #4]
	str r0, [r4, #8]
	mov r1, #0
	ldr r0, _0216C798 // =0x0000FFFF
	str r1, [r4, #0x10]
	strh r0, [r4, #0x14]
	mov r0, #1
	str r0, [r4, #0x18]
	strh r1, [r4, #0x1c]
	strh r1, [r4, #0x1e]
	strh r1, [r4, #0x24]
	strh r1, [r4, #0x26]
	strh r1, [r4, #0x28]
	strh r1, [r4, #0x2a]
	strh r1, [r4, #0x2c]
	strh r1, [r4, #0x2e]
	strh r1, [r4, #0x30]
	strh r1, [r4, #0x32]
	str r1, [r4, #0xc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216C798: .word 0x0000FFFF
	arm_func_end ViEvtCmnSelect__Func_216C70C

	arm_func_start ViEvtCmnSelect__Func_216C79C
ViEvtCmnSelect__Func_216C79C: // 0x0216C79C
	mov r2, #0
	str r2, [r0, #8]
	strh r1, [r0, #0x14]
	mov r1, #1
	str r1, [r0, #0x18]
	bx lr
	arm_func_end ViEvtCmnSelect__Func_216C79C

	arm_func_start ViEvtCmnSelect__Func_216C7B4
ViEvtCmnSelect__Func_216C7B4: // 0x0216C7B4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r3, [r4, #0x18]
	ldr r2, [r4, #8]
	mov r1, #0
	str r2, [r4, #4]
	str r1, [r4, #0x18]
	ldr r1, [r4, #4]
	cmp r1, #6
	addls pc, pc, r1, lsl #2
	b _0216C910
_0216C7E0: // jump table
	b _0216C7FC // case 0
	b _0216C824 // case 1
	b _0216C84C // case 2
	b _0216C874 // case 3
	b _0216C89C // case 4
	b _0216C8C4 // case 5
	b _0216C8EC // case 6
_0216C7FC:
	cmp r3, #0
	beq _0216C808
	bl ViEvtCmnSelect__Func_216C948
_0216C808:
	mov r0, r4
	bl ViEvtCmnSelect__Func_216CAA4
	str r0, [r4, #8]
	cmp r0, #0
	movne r0, #1
	strne r0, [r4, #0x18]
	b _0216C910
_0216C824:
	cmp r3, #0
	beq _0216C830
	bl ViEvtCmnSelect__Func_216CAAC
_0216C830:
	mov r0, r4
	bl ViEvtCmnSelect__Func_216CAF0
	str r0, [r4, #8]
	cmp r0, #1
	movne r0, #1
	strne r0, [r4, #0x18]
	b _0216C910
_0216C84C:
	cmp r3, #0
	beq _0216C858
	bl ViEvtCmnSelect__Func_216CB28
_0216C858:
	mov r0, r4
	bl ViEvtCmnSelect__Func_216CB64
	str r0, [r4, #8]
	cmp r0, #2
	movne r0, #1
	strne r0, [r4, #0x18]
	b _0216C910
_0216C874:
	cmp r3, #0
	beq _0216C880
	bl ViEvtCmnSelect__Func_216CB88
_0216C880:
	mov r0, r4
	bl ViEvtCmnSelect__Func_216CBA0
	str r0, [r4, #8]
	cmp r0, #3
	movne r0, #1
	strne r0, [r4, #0x18]
	b _0216C910
_0216C89C:
	cmp r3, #0
	beq _0216C8A8
	bl ViEvtCmnSelect__Func_216CD5C
_0216C8A8:
	mov r0, r4
	bl ViEvtCmnSelect__Func_216CD60
	str r0, [r4, #8]
	cmp r0, #4
	movne r0, #1
	strne r0, [r4, #0x18]
	b _0216C910
_0216C8C4:
	cmp r3, #0
	beq _0216C8D0
	bl ViEvtCmnSelect__Func_216CDE8
_0216C8D0:
	mov r0, r4
	bl ViEvtCmnSelect__Func_216CE2C
	str r0, [r4, #8]
	cmp r0, #5
	movne r0, #1
	strne r0, [r4, #0x18]
	b _0216C910
_0216C8EC:
	cmp r3, #0
	beq _0216C8F8
	bl ViEvtCmnSelect__Func_216CE64
_0216C8F8:
	mov r0, r4
	bl ViEvtCmnSelect__Func_216CE68
	str r0, [r4, #8]
	cmp r0, #6
	movne r0, #1
	strne r0, [r4, #0x18]
_0216C910:
	ldr r0, [r4, #0x18]
	cmp r0, #0
	movne r0, #0
	ldreq r0, [r4, #0xc]
	addeq r0, r0, #1
	str r0, [r4, #0xc]
	ldmia sp!, {r4, pc}
	arm_func_end ViEvtCmnSelect__Func_216C7B4

	arm_func_start ViEvtCmnSelect__Func_216C92C
ViEvtCmnSelect__Func_216C92C: // 0x0216C92C
	ldr r0, [r0, #4]
	cmp r0, #8
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ViEvtCmnSelect__Func_216C92C

	arm_func_start ViEvtCmnSelect__Func_216C940
ViEvtCmnSelect__Func_216C940: // 0x0216C940
	ldrh r0, [r0, #0x1c]
	bx lr
	arm_func_end ViEvtCmnSelect__Func_216C940

	arm_func_start ViEvtCmnSelect__Func_216C948
ViEvtCmnSelect__Func_216C948: // 0x0216C948
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x28
	mov r7, r0
	mov r2, #0
	strh r2, [r7, #0x1c]
	ldrh r1, [r7, #0x14]
	ldr r0, [r7, #0x10]
	bl MPC__Func_20538B0
	strh r0, [r7, #0x1e]
	bl HubControl__GetField54
	bl FontWindow__GetFont
	ldrh r1, [r7, #0x1e]
	mov r6, #0
	mov r4, r0
	mov r5, r6
	cmp r1, #0
	ble _0216C9C4
	mov r8, r6
_0216C990:
	str r4, [sp]
	ldrh r1, [r7, #0x14]
	mov r3, r5, lsl #0x10
	ldr r0, [r7, #0x10]
	mov r2, r8
	mov r3, r3, lsr #0x10
	bl MessageController__MPC__Func_2054524
	cmp r0, r6
	movhi r6, r0
	ldrh r0, [r7, #0x1e]
	add r5, r5, #1
	cmp r5, r0
	blt _0216C990
_0216C9C4:
	add r0, r6, #0xf
	mov r0, r0, lsl #0xd
	mov r2, r0, lsr #0x10
	cmp r2, #0x1e
	movhi r2, #0x1e
	bhi _0216C9E8
	add r0, r2, #2
	cmp r0, #0xe
	movlo r2, #0xc
_0216C9E8:
	add r1, r2, #2
	rsb r0, r1, #0x20
	strh r0, [r7, #0x24]
	mov r0, #0xa
	strh r0, [r7, #0x26]
	strh r1, [r7, #0x28]
	ldrh r1, [r7, #0x1e]
	mov r0, #0xb
	mov r1, r1, lsl #1
	add r1, r1, #2
	strh r1, [r7, #0x2a]
	ldrh r1, [r7, #0x24]
	add r1, r1, #1
	strh r1, [r7, #0x2c]
	strh r0, [r7, #0x2e]
	strh r2, [r7, #0x30]
	ldrh r0, [r7, #0x1e]
	mov r0, r0, lsl #1
	strh r0, [r7, #0x32]
	bl HubControl__GetField54
	mov lr, #2
	str lr, [sp]
	ldrh r1, [r7, #0x24]
	mov r2, #0
	mov r5, #0x3c0
	str r1, [sp, #4]
	ldrh r3, [r7, #0x26]
	mov r1, r0
	mov r6, #3
	str r3, [sp, #8]
	ldrh r0, [r7, #0x28]
	mov r3, r2
	add r4, r5, #0x3f
	str r0, [sp, #0xc]
	ldrh ip, [r7, #0x2a]
	add r0, r7, #0xf8
	str ip, [sp, #0x10]
	str r2, [sp, #0x14]
	str lr, [sp, #0x18]
	str r6, [sp, #0x1c]
	str r5, [sp, #0x20]
	str r4, [sp, #0x24]
	bl FontWindowAnimator__Load1
	add r0, r7, #0xf8
	bl FontWindowAnimator__SetWindowClosed
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end ViEvtCmnSelect__Func_216C948

	arm_func_start ViEvtCmnSelect__Func_216CAA4
ViEvtCmnSelect__Func_216CAA4: // 0x0216CAA4
	mov r0, #1
	bx lr
	arm_func_end ViEvtCmnSelect__Func_216CAA4

	arm_func_start ViEvtCmnSelect__Func_216CAAC
ViEvtCmnSelect__Func_216CAAC: // 0x0216CAAC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r3, #0
	add r0, r4, #0xf8
	mov r1, #1
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xf8
	bl FontWindowAnimator__StartAnimating
	add r0, r4, #0xf8
	bl FontWindowAnimator__Draw
	mov r0, #4
	bl ovl05_21544AC
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end ViEvtCmnSelect__Func_216CAAC

	arm_func_start ViEvtCmnSelect__Func_216CAF0
ViEvtCmnSelect__Func_216CAF0: // 0x0216CAF0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0xf8
	mov r4, #1
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r5, #0xf8
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _0216CB20
	add r0, r5, #0xf8
	bl FontWindowAnimator__SetWindowOpen
	mov r4, #2
_0216CB20:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViEvtCmnSelect__Func_216CAF0

	arm_func_start ViEvtCmnSelect__Func_216CB28
ViEvtCmnSelect__Func_216CB28: // 0x0216CB28
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r1, [r4, #0x14]
	add r0, r4, #0x34
	bl FontAnimator__SetMsgSequence
	ldrh r2, [r4, #0x2c]
	add r0, r4, #0x34
	mov r1, #0
	sub r2, r2, #1
	mov r2, r2, lsl #3
	add r2, r2, #4
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	bl FontAnimator__InitStartPos
	ldmia sp!, {r4, pc}
	arm_func_end ViEvtCmnSelect__Func_216CB28

	arm_func_start ViEvtCmnSelect__Func_216CB64
ViEvtCmnSelect__Func_216CB64: // 0x0216CB64
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x34
	mov r1, #0
	bl FontAnimator__LoadCharacters
	add r0, r4, #0x34
	bl FontAnimator__Draw
	mov r0, #3
	ldmia sp!, {r4, pc}
	arm_func_end ViEvtCmnSelect__Func_216CB64

	arm_func_start ViEvtCmnSelect__Func_216CB88
ViEvtCmnSelect__Func_216CB88: // 0x0216CB88
	mov r2, #0
	ldr r1, _0216CB9C // =0x0000FFFF
	strh r2, [r0, #0x1c]
	strh r1, [r0, #0x20]
	bx lr
	.align 2, 0
_0216CB9C: .word 0x0000FFFF
	arm_func_end ViEvtCmnSelect__Func_216CB88

	arm_func_start ViEvtCmnSelect__Func_216CBA0
ViEvtCmnSelect__Func_216CBA0: // 0x0216CBA0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	mov r6, r0
	mov r4, #3
	mov r5, #0
	bl ViEvtCmnSelect__Func_216CEB4
	movs r7, r0
	bmi _0216CBE8
	add r0, r6, #0x15c
	bl FontWindowMWControl__ValidatePaletteAnim
	add r0, r6, #0x1b0
	mov r1, r5
	bl AnimatorSprite__SetAnimation
	mov r0, r4
	bl ovl05_21544AC
	ldr r0, _0216CD58 // =0x0000FFFF
	strh r7, [r6, #0x1c]
	strh r0, [r6, #0x20]
	b _0216CC4C
_0216CBE8:
	mov r0, r6
	mov r1, #1
	bl ViEvtCmnSelect__Func_216CF08
	cmp r0, #0
	blt _0216CC10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	strh r0, [r6, #0x1c]
	strh r0, [r6, #0x20]
	b _0216CC4C
_0216CC10:
	ldrh r7, [r6, #0x20]
	ldr r0, _0216CD58 // =0x0000FFFF
	cmp r7, r0
	beq _0216CC4C
	mov r0, r6
	mov r1, r5
	bl ViEvtCmnSelect__Func_216CF08
	mov r0, r0, lsl #0x10
	cmp r7, r0, lsr #16
	ldreqh r0, [r6, #0x1c]
	cmpeq r7, r0
	bne _0216CC4C
	mov r5, #1
	mov r0, r5
	bl ovl05_21544AC
_0216CC4C:
	mov r0, r6
	bl ViEvtCmnSelect__Func_216CE7C
	cmp r0, #0
	beq _0216CC6C
	mov r5, #1
	mov r0, r5
	bl ovl05_21544AC
	b _0216CCAC
_0216CC6C:
	mov r0, r6
	bl ViEvtCmnSelect__Func_216CE98
	cmp r0, #0
	beq _0216CCAC
	ldrh r1, [r6, #0x1e]
	ldrh r0, [r6, #0x1c]
	sub r1, r1, #1
	cmp r0, r1
	bne _0216CCA0
	mov r0, #2
	mov r5, #1
	bl ovl05_21544AC
	b _0216CCAC
_0216CCA0:
	mov r0, #3
	strh r1, [r6, #0x1c]
	bl ovl05_21544AC
_0216CCAC:
	add r0, r6, #0x15c
	bl FontWindowMWControl__Draw
	mov r1, #0
	mov r2, r1
	add r0, r6, #0x1b0
	bl AnimatorSprite__ProcessAnimation
	ldrh r0, [r6, #0x1c]
	ldrh ip, [r6, #0x2c]
	ldrh r2, [r6, #0x30]
	ldrh r3, [r6, #0x2e]
	mov r1, r0, lsl #4
	mov r0, ip, lsl #0x13
	add r1, r1, r3, lsl #3
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x13
	mov r7, r0, asr #0x10
	mov r8, r1, asr #0x10
	add r0, r6, #0x15c
	mov r1, #0
	mov sb, r2, lsr #0x10
	bl FontWindowMWControl__SetPaletteAnim
	add r0, r6, #0x15c
	mov r1, r7
	mov r2, r8
	bl FontWindowMWControl__SetPosition
	mov r1, sb
	add r0, r6, #0x15c
	mov r2, #0x10
	bl FontWindowMWControl__SetOffset
	add r0, r6, #0x15c
	bl FontWindowMWControl__CallWindowFunc2
	cmp r5, #0
	bne _0216CD48
	add r1, r6, #0x100
	strh r7, [r1, #0xb8]
	add r2, r8, #8
	add r0, r6, #0x1b0
	strh r2, [r1, #0xba]
	bl AnimatorSprite__DrawFrame
_0216CD48:
	cmp r5, #0
	movne r4, #4
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_0216CD58: .word 0x0000FFFF
	arm_func_end ViEvtCmnSelect__Func_216CBA0

	arm_func_start ViEvtCmnSelect__Func_216CD5C
ViEvtCmnSelect__Func_216CD5C: // 0x0216CD5C
	bx lr
	arm_func_end ViEvtCmnSelect__Func_216CD5C

	arm_func_start ViEvtCmnSelect__Func_216CD60
ViEvtCmnSelect__Func_216CD60: // 0x0216CD60
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	add r0, r4, #0x15c
	bl FontWindowMWControl__Draw
	ldrh r0, [r4, #0x1c]
	ldrh r2, [r4, #0x30]
	ldrh r3, [r4, #0x2e]
	mov r1, r0, lsl #4
	ldrh ip, [r4, #0x2c]
	add r1, r1, r3, lsl #3
	mov r1, r1, lsl #0x10
	mov r0, ip, lsl #0x13
	mov r2, r2, lsl #0x13
	mov r5, r0, asr #0x10
	mov r6, r1, asr #0x10
	add r0, r4, #0x15c
	mov r1, #1
	mov r7, r2, lsr #0x10
	bl FontWindowMWControl__SetPaletteAnim
	mov r1, r5
	mov r2, r6
	add r0, r4, #0x15c
	bl FontWindowMWControl__SetPosition
	mov r1, r7
	add r0, r4, #0x15c
	mov r2, #0x10
	bl FontWindowMWControl__SetOffset
	add r0, r4, #0x15c
	bl FontWindowMWControl__CallWindowFunc2
	ldr r0, [r4, #0xc]
	cmp r0, #0x10
	movhs r0, #5
	movlo r0, #4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ViEvtCmnSelect__Func_216CD60

	arm_func_start ViEvtCmnSelect__Func_216CDE8
ViEvtCmnSelect__Func_216CDE8: // 0x0216CDE8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r3, #0
	add r0, r4, #0xf8
	mov r1, #4
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xf8
	bl FontWindowAnimator__StartAnimating
	add r0, r4, #0x34
	bl FontAnimator__ClearPixels
	add r0, r4, #0x34
	bl FontAnimator__Draw
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end ViEvtCmnSelect__Func_216CDE8

	arm_func_start ViEvtCmnSelect__Func_216CE2C
ViEvtCmnSelect__Func_216CE2C: // 0x0216CE2C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0xf8
	mov r4, #5
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r5, #0xf8
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _0216CE5C
	add r0, r5, #0xf8
	bl FontWindowAnimator__SetWindowClosed
	mov r4, #6
_0216CE5C:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViEvtCmnSelect__Func_216CE2C

	arm_func_start ViEvtCmnSelect__Func_216CE64
ViEvtCmnSelect__Func_216CE64: // 0x0216CE64
	bx lr
	arm_func_end ViEvtCmnSelect__Func_216CE64

	arm_func_start ViEvtCmnSelect__Func_216CE68
ViEvtCmnSelect__Func_216CE68: // 0x0216CE68
	stmdb sp!, {r3, lr}
	add r0, r0, #0xf8
	bl FontWindowAnimator__SetWindowOpen
	mov r0, #8
	ldmia sp!, {r3, pc}
	arm_func_end ViEvtCmnSelect__Func_216CE68

	arm_func_start ViEvtCmnSelect__Func_216CE7C
ViEvtCmnSelect__Func_216CE7C: // 0x0216CE7C
	ldr r0, _0216CE94 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0216CE94: .word padInput
	arm_func_end ViEvtCmnSelect__Func_216CE7C

	arm_func_start ViEvtCmnSelect__Func_216CE98
ViEvtCmnSelect__Func_216CE98: // 0x0216CE98
	ldr r0, _0216CEB0 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #2
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0216CEB0: .word padInput
	arm_func_end ViEvtCmnSelect__Func_216CE98

	arm_func_start ViEvtCmnSelect__Func_216CEB4
ViEvtCmnSelect__Func_216CEB4: // 0x0216CEB4
	ldr r1, _0216CF04 // =padInput
	mvn r2, #0
	ldrh r3, [r1, #8]
	tst r3, #0x40
	beq _0216CEDC
	ldrh r1, [r0, #0x1c]
	cmp r1, #0
	subne r2, r1, #1
	ldreqh r1, [r0, #0x1e]
	subeq r2, r1, #1
_0216CEDC:
	tst r3, #0x80
	beq _0216CEFC
	ldrh r1, [r0, #0x1e]
	ldrh r2, [r0, #0x1c]
	sub r0, r1, #1
	cmp r2, r0
	addlt r2, r2, #1
	movge r2, #0
_0216CEFC:
	mov r0, r2
	bx lr
	.align 2, 0
_0216CF04: .word padInput
	arm_func_end ViEvtCmnSelect__Func_216CEB4

	arm_func_start ViEvtCmnSelect__Func_216CF08
ViEvtCmnSelect__Func_216CF08: // 0x0216CF08
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	cmp r1, #0
	mvn r4, #0
	beq _0216CF5C
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0216CF3C
	ldr r0, _0216D008 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	movne r0, #1
	bne _0216CF40
_0216CF3C:
	mov r0, #0
_0216CF40:
	cmp r0, #0
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, _0216D008 // =touchInput
	ldrh r6, [r0, #0x1c]
	ldrh r2, [r0, #0x1e]
	b _0216CF98
_0216CF5C:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0216CF7C
	ldr r0, _0216D008 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #8
	movne r0, #1
	bne _0216CF80
_0216CF7C:
	mov r0, #0
_0216CF80:
	cmp r0, #0
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, _0216D008 // =touchInput
	ldrh r6, [r0, #0x20]
	ldrh r2, [r0, #0x22]
_0216CF98:
	ldrh r3, [r5, #0x1e]
	mov r0, #0
	cmp r3, #0
	ble _0216D000
	ldrh lr, [r5, #0x2c]
	ldrh ip, [r5, #0x30]
	ldrh r1, [r5, #0x2e]
	mov r5, lr, lsl #0x13
	sub r5, r6, r5, lsr #16
	mov ip, ip, lsl #3
	mov r5, r5, lsl #0x10
	mov lr, r5, lsr #0x10
	mov ip, ip, lsl #0x10
_0216CFCC:
	cmp lr, ip, lsr #16
	mov r5, r1, lsl #0x13
	bhs _0216CFF0
	sub r5, r2, r5, lsr #16
	mov r5, r5, lsl #0x10
	mov r5, r5, lsr #0x10
	cmp r5, #0x10
	movlo r4, r0
	blo _0216D000
_0216CFF0:
	add r0, r0, #1
	cmp r0, r3
	add r1, r1, #2
	blt _0216CFCC
_0216D000:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216D008: .word touchInput
	arm_func_end ViEvtCmnSelect__Func_216CF08

	arm_func_start ViEvtCmnAnnounce__Constructor
ViEvtCmnAnnounce__Constructor: // 0x0216D00C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, _0216D03C // =0x021739FC
	add r0, r4, #0x24
	str r1, [r4]
	bl FontAnimator__Init
	add r0, r4, #0xe8
	bl FontWindowAnimator__Init
	mov r0, r4
	bl ViEvtCmnAnnounce__Func_216D194
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216D03C: .word 0x021739FC
	arm_func_end ViEvtCmnAnnounce__Constructor

	arm_func_start ViEvtCmnAnnounce__VTableFunc_216D040
ViEvtCmnAnnounce__VTableFunc_216D040: // 0x0216D040
	stmdb sp!, {r4, lr}
	ldr r1, _0216D05C // =0x021739FC
	mov r4, r0
	str r1, [r4]
	bl ViEvtCmnAnnounce__Func_216D194
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216D05C: .word 0x021739FC
	arm_func_end ViEvtCmnAnnounce__VTableFunc_216D040

	arm_func_start ViEvtCmnAnnounce__VTableFunc_216D060
ViEvtCmnAnnounce__VTableFunc_216D060: // 0x0216D060
	stmdb sp!, {r4, lr}
	ldr r1, _0216D084 // =0x021739FC
	mov r4, r0
	str r1, [r4]
	bl ViEvtCmnAnnounce__Func_216D194
	mov r0, r4
	bl CPPHelpers__Free
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216D084: .word 0x021739FC
	arm_func_end ViEvtCmnAnnounce__VTableFunc_216D060

	arm_func_start ViEvtCmnAnnounce__Func_216D088
ViEvtCmnAnnounce__Func_216D088: // 0x0216D088
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x28
	mov r4, r0
	mov r5, r1
	bl ViEvtCmnAnnounce__Func_216D194
	str r5, [r4, #0xc]
	bl HubControl__GetField54
	mov r2, #0xa
	mov r1, r0
	str r2, [sp]
	mov r0, #0x1c
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	mov r0, #3
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r0, #0x80
	str r0, [sp, #0x18]
	add r0, r4, #0x24
	mov r3, #2
	bl FontAnimator__LoadFont1
	add r0, r4, #0x24
	ldr r1, [r4, #0xc]
	bl FontAnimator__LoadMPCFile
	add r0, r4, #0x24
	bl FontAnimator__ClearPixels
	add r0, r4, #0x24
	bl FontAnimator__Draw
	add r0, r4, #0x24
	bl FontAnimator__LoadPaletteFunc
	add r0, r4, #0x24
	bl FontAnimator__LoadMappingsFunc
	bl HubControl__GetField54
	mov r1, r0
	mov r3, #2
	str r3, [sp]
	mov r0, #1
	str r0, [sp, #4]
	mov r0, #9
	str r0, [sp, #8]
	mov r0, #0x1e
	str r0, [sp, #0xc]
	mov r0, #6
	str r0, [sp, #0x10]
	mov r2, #0
	str r2, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #3
	str r0, [sp, #0x1c]
	mov r0, #0x3c0
	str r0, [sp, #0x20]
	add r0, r0, #0x3f
	str r0, [sp, #0x24]
	add r0, r4, #0xe8
	mov r3, r2
	bl FontWindowAnimator__Load1
	add r0, r4, #0xe8
	bl FontWindowAnimator__SetWindowClosed
	mov r0, #9
	str r0, [r4, #0x14c]
	mov r0, #0
	strh r0, [r4, #4]
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViEvtCmnAnnounce__Func_216D088

	arm_func_start ViEvtCmnAnnounce__Func_216D194
ViEvtCmnAnnounce__Func_216D194: // 0x0216D194
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xe8
	bl FontWindowAnimator__Release
	add r0, r4, #0x24
	bl FontAnimator__Release
	mov r1, #5
	strh r1, [r4, #4]
	ldr r0, _0216D1F0 // =0x0000FFFF
	strh r1, [r4, #6]
	strh r0, [r4, #0xa]
	mov r0, #0
	str r0, [r4, #0xc]
	strh r0, [r4, #0x10]
	strh r0, [r4, #0x12]
	strh r0, [r4, #0x14]
	strh r0, [r4, #0x16]
	strh r0, [r4, #0x18]
	strh r0, [r4, #0x1a]
	strh r0, [r4, #0x1c]
	strh r0, [r4, #0x1e]
	strh r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216D1F0: .word 0x0000FFFF
	arm_func_end ViEvtCmnAnnounce__Func_216D194

	arm_func_start ViEvtCmnAnnounce__Func_216D1F4
ViEvtCmnAnnounce__Func_216D1F4: // 0x0216D1F4
	strh r1, [r0, #0xa]
	str r2, [r0, #0x14c]
	mov r1, #1
	strh r1, [r0, #4]
	bx lr
	arm_func_end ViEvtCmnAnnounce__Func_216D1F4

	arm_func_start ViEvtCmnAnnounce__Func_216D208
ViEvtCmnAnnounce__Func_216D208: // 0x0216D208
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r1, [r4, #4]
	ldrh r0, [r4, #6]
	cmp r1, r0
	movne r2, #1
	moveq r2, #0
	cmp r2, #0
	strh r1, [r4, #6]
	movne r0, #0
	strneh r0, [r4, #8]
	ldrh r0, [r4, #4]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0216D2D8
_0216D244: // jump table
	b _0216D2D8 // case 0
	b _0216D25C // case 1
	b _0216D27C // case 2
	b _0216D29C // case 3
	b _0216D2BC // case 4
	b _0216D2D8 // case 5
_0216D25C:
	cmp r2, #0
	beq _0216D26C
	mov r0, r4
	bl ViEvtCmnAnnounce__Func_216D318
_0216D26C:
	mov r0, r4
	bl ViEvtCmnAnnounce__Func_216D38C
	strh r0, [r4, #4]
	b _0216D2D8
_0216D27C:
	cmp r2, #0
	beq _0216D28C
	mov r0, r4
	bl ViEvtCmnAnnounce__Func_216D3CC
_0216D28C:
	mov r0, r4
	bl ViEvtCmnAnnounce__Func_216D440
	strh r0, [r4, #4]
	b _0216D2D8
_0216D29C:
	cmp r2, #0
	beq _0216D2AC
	mov r0, r4
	bl ViEvtCmnAnnounce__Func_216D4E8
_0216D2AC:
	mov r0, r4
	bl ViEvtCmnAnnounce__Func_216D558
	strh r0, [r4, #4]
	b _0216D2D8
_0216D2BC:
	cmp r2, #0
	beq _0216D2CC
	mov r0, r4
	bl ViEvtCmnAnnounce__Func_216D598
_0216D2CC:
	mov r0, r4
	bl ViEvtCmnAnnounce__Func_216D5DC
	strh r0, [r4, #4]
_0216D2D8:
	ldrh r0, [r4, #8]
	add r0, r0, #1
	strh r0, [r4, #8]
	ldmia sp!, {r4, pc}
	arm_func_end ViEvtCmnAnnounce__Func_216D208

	arm_func_start ViEvtCmnAnnounce__Func_216D2E8
ViEvtCmnAnnounce__Func_216D2E8: // 0x0216D2E8
	ldrh r1, [r0, #4]
	ldrh r0, [r0, #6]
	cmp r1, r0
	movne r0, #0
	bxne lr
	cmp r1, #0
	moveq r0, #1
	bxeq lr
	cmp r1, #5
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ViEvtCmnAnnounce__Func_216D2E8

	arm_func_start ViEvtCmnAnnounce__Func_216D318
ViEvtCmnAnnounce__Func_216D318: // 0x0216D318
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r3, #0
	add r0, r4, #0xe8
	mov r1, #1
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xe8
	bl FontWindowAnimator__StartAnimating
	add r0, r4, #0xe8
	bl FontWindowAnimator__Func_20599B4
	mov r2, #0x4000000
	ldr r1, [r2]
	ldr r0, [r2]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	ldr r0, [r4, #0x14c]
	cmp r0, #8
	addge sp, sp, #4
	ldmgeia sp!, {r3, r4, pc}
	bl ovl05_21544AC
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end ViEvtCmnAnnounce__Func_216D318

	arm_func_start ViEvtCmnAnnounce__Func_216D38C
ViEvtCmnAnnounce__Func_216D38C: // 0x0216D38C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0xe8
	mov r4, #1
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r5, #0xe8
	bl FontWindowAnimator__Draw
	add r0, r5, #0xe8
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _0216D3C4
	add r0, r5, #0xe8
	bl FontWindowAnimator__SetWindowOpen
	mov r4, #2
_0216D3C4:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViEvtCmnAnnounce__Func_216D38C

	arm_func_start ViEvtCmnAnnounce__Func_216D3CC
ViEvtCmnAnnounce__Func_216D3CC: // 0x0216D3CC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r1, [r4, #0xa]
	add r0, r4, #0x24
	bl FontAnimator__SetMsgSequence
	ldrsh r2, [r4, #0x20]
	add r0, r4, #0x24
	mov r1, #1
	bl FontAnimator__InitStartPos
	add r0, r4, #0x24
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	mov r0, r0, lsl #4
	mov r0, r0, asr #1
	rsb r0, r0, #0x10
	mov r1, r0, lsl #0x10
	add r0, r4, #0x24
	mov r1, r1, asr #0x10
	bl FontAnimator__AdvanceLine
	mov r2, #0x4000000
	ldr r1, [r2]
	ldr r0, [r2]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #8
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	ldmia sp!, {r4, pc}
	arm_func_end ViEvtCmnAnnounce__Func_216D3CC

	arm_func_start ViEvtCmnAnnounce__Func_216D440
ViEvtCmnAnnounce__Func_216D440: // 0x0216D440
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r4, #0
	mov r1, r4
	add r0, r6, #0x24
	mov r5, #2
	bl FontAnimator__LoadCharacters
	add r0, r6, #0x24
	bl FontAnimator__Draw
	add r0, r6, #0xe8
	bl FontWindowAnimator__Draw
	add r0, r6, #0x24
	bl FontAnimator__IsLastDialog
	cmp r0, #0
	beq _0216D4D8
	ldrh r0, [r6, #8]
	cmp r0, #0x168
	movhs r4, #1
	cmp r0, #0x3c
	blo _0216D4D0
	ldr r0, _0216D4E0 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	bne _0216D4CC
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0216D4C0
	ldr r0, _0216D4E4 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	movne r0, #1
	bne _0216D4C4
_0216D4C0:
	mov r0, #0
_0216D4C4:
	cmp r0, #0
	beq _0216D4D0
_0216D4CC:
	mov r4, #1
_0216D4D0:
	cmp r4, #0
	movne r5, #3
_0216D4D8:
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216D4E0: .word padInput
_0216D4E4: .word touchInput
	arm_func_end ViEvtCmnAnnounce__Func_216D440

	arm_func_start ViEvtCmnAnnounce__Func_216D4E8
ViEvtCmnAnnounce__Func_216D4E8: // 0x0216D4E8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r3, #0
	add r0, r4, #0xe8
	mov r1, #4
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xe8
	bl FontWindowAnimator__StartAnimating
	add r0, r4, #0xe8
	bl FontWindowAnimator__Func_20599B4
	add r0, r4, #0x24
	bl FontAnimator__ClearPixels
	add r0, r4, #0x24
	bl FontAnimator__Draw
	mov r2, #0x4000000
	ldr r1, [r2]
	ldr r0, [r2]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #8
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end ViEvtCmnAnnounce__Func_216D4E8

	arm_func_start ViEvtCmnAnnounce__Func_216D558
ViEvtCmnAnnounce__Func_216D558: // 0x0216D558
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0xe8
	mov r4, #3
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r5, #0xe8
	bl FontWindowAnimator__Draw
	add r0, r5, #0xe8
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _0216D590
	add r0, r5, #0xe8
	bl FontWindowAnimator__SetWindowClosed
	mov r4, #4
_0216D590:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViEvtCmnAnnounce__Func_216D558

	arm_func_start ViEvtCmnAnnounce__Func_216D598
ViEvtCmnAnnounce__Func_216D598: // 0x0216D598
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xe8
	bl FontWindowAnimator__SetWindowOpen
	ldr r0, _0216D5D8 // =0x0000FFFF
	mov r2, #0x4000000
	strh r0, [r4, #0xa]
	ldr r1, [r2]
	ldr r0, [r2]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216D5D8: .word 0x0000FFFF
	arm_func_end ViEvtCmnAnnounce__Func_216D598

	arm_func_start ViEvtCmnAnnounce__Func_216D5DC
ViEvtCmnAnnounce__Func_216D5DC: // 0x0216D5DC
	mov r0, #0
	bx lr
	arm_func_end ViEvtCmnAnnounce__Func_216D5DC

	arm_func_start ViEvtCmnTalk__Constructor
ViEvtCmnTalk__Constructor: // 0x0216D5E4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, _0216D614 // =0x02173A0C
	add r0, r4, #0x20
	str r1, [r4]
	bl ViEvtCmnMsg__Constructor
	add r0, r4, #0x2a4
	bl ViEvtCmnSelect__Constructor
	mov r0, r4
	bl ViEvtCmnTalk__Func_216D72C
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216D614: .word 0x02173A0C
	arm_func_end ViEvtCmnTalk__Constructor

	arm_func_start ViEvtCmnTalk__VTableFunc_216D618
ViEvtCmnTalk__VTableFunc_216D618: // 0x0216D618
	stmdb sp!, {r4, lr}
	ldr r1, _0216D644 // =0x02173A0C
	mov r4, r0
	str r1, [r4]
	bl ViEvtCmnTalk__Func_216D72C
	add r0, r4, #0x2a4
	bl ViEvtCmnSelect__VTableFunc_216C578
	add r0, r4, #0x20
	bl ViEvtCmnMsg__VTableFunc_216B98C
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216D644: .word 0x02173A0C
	arm_func_end ViEvtCmnTalk__VTableFunc_216D618

	arm_func_start ViEvtCmnTalk__VTableFunc_216D648
ViEvtCmnTalk__VTableFunc_216D648: // 0x0216D648
	stmdb sp!, {r4, lr}
	ldr r1, _0216D67C // =0x02173A0C
	mov r4, r0
	str r1, [r4]
	bl ViEvtCmnTalk__Func_216D72C
	add r0, r4, #0x2a4
	bl ViEvtCmnSelect__VTableFunc_216C578
	add r0, r4, #0x20
	bl ViEvtCmnMsg__VTableFunc_216B98C
	mov r0, r4
	bl CPPHelpers__Free
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216D67C: .word 0x02173A0C
	arm_func_end ViEvtCmnTalk__VTableFunc_216D648

	arm_func_start ViEvtCmnTalk__Func_216D680
ViEvtCmnTalk__Func_216D680: // 0x0216D680
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl ViEvtCmnTalk__Func_216D72C
	mov r1, r7
	add r0, r4, #0x18
	str r7, [r4, #0x14]
	bl ovl05_2152B80
	ldr r0, _0216D728 // =0x0000FFFF
	cmp r5, r0
	beq _0216D6CC
	mov r1, r5
	add r0, r4, #0x18
	bl ovl05_2152BA4
	ldr r0, _0216D728 // =0x0000FFFF
	strh r6, [r4, #0xa]
	b _0216D6E0
_0216D6CC:
	mov r1, r6
	add r0, r4, #0x18
	bl ovl05_2152BA4
	ldr r0, _0216D728 // =0x0000FFFF
	strh r0, [r4, #0xa]
_0216D6E0:
	strh r0, [r4, #0xc]
	bl HubControl__GetFileFrom_ViMsg
	mov r5, r0
	add r0, r4, #0x18
	bl ovl05_2152B98
	mov r1, r0
	mov r0, r5
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x10]
	mov r1, r0
	add r0, r4, #0x20
	bl ViEvtCmnMsg__Func_216B9D4
	ldr r1, [r4, #0x10]
	add r0, r4, #0x2a4
	bl ViEvtCmnSelect__Func_216C5C0
	mov r0, #0
	strh r0, [r4, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216D728: .word 0x0000FFFF
	arm_func_end ViEvtCmnTalk__Func_216D680

	arm_func_start ViEvtCmnTalk__Func_216D72C
ViEvtCmnTalk__Func_216D72C: // 0x0216D72C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #5
	strh r0, [r4, #4]
	mov r0, #0x18
	strh r0, [r4, #6]
	mov r1, #0
	ldr r0, _0216D774 // =0x0000FFFF
	strh r1, [r4, #8]
	strh r0, [r4, #0xa]
	strh r0, [r4, #0xc]
	str r1, [r4, #0x10]
	add r0, r4, #0x20
	str r1, [r4, #0x14]
	bl ViEvtCmnMsg__Func_216BC08
	add r0, r4, #0x2a4
	bl ViEvtCmnSelect__Func_216C70C
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216D774: .word 0x0000FFFF
	arm_func_end ViEvtCmnTalk__Func_216D72C

	arm_func_start ViEvtCmnTalk__Func_216D778
ViEvtCmnTalk__Func_216D778: // 0x0216D778
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldrh r1, [r4, #0xa]
	ldr r0, _0216D7CC // =0x0000FFFF
	cmp r1, r0
	beq _0216D7BC
	ldr r1, [r4, #0x14]
	add r0, sp, #0
	bl ovl05_2152B80
	ldrh r1, [r4, #0xa]
	add r0, sp, #0
	bl ovl05_2152BA4
	add r0, sp, #0
	bl ovl05_2152BB8
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0216D7BC:
	add r0, r4, #0x18
	bl ovl05_2152BB8
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216D7CC: .word 0x0000FFFF
	arm_func_end ViEvtCmnTalk__Func_216D778

	arm_func_start ViEvtCmnTalk__Func_216D7D0
ViEvtCmnTalk__Func_216D7D0: // 0x0216D7D0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r2, [r5, #0xa]
	ldr r0, _0216D818 // =0x0000FFFF
	mov r4, r1
	cmp r2, r0
	add r0, r5, #0x18
	beq _0216D800
	mov r1, #0
	bl ovl05_2152C00
	strh r4, [r5, #0xc]
	b _0216D80C
_0216D800:
	bl ovl05_2152C00
	ldr r0, _0216D818 // =0x0000FFFF
	strh r0, [r5, #0xc]
_0216D80C:
	mov r0, #1
	strh r0, [r5, #4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216D818: .word 0x0000FFFF
	arm_func_end ViEvtCmnTalk__Func_216D7D0

	arm_func_start ViEvtCmnTalk__Func_216D81C
ViEvtCmnTalk__Func_216D81C: // 0x0216D81C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r1, [r4, #4]
	cmp r1, #5
	addls pc, pc, r1, lsl #2
	ldmia sp!, {r4, pc}
_0216D834: // jump table
	ldmia sp!, {r4, pc} // case 0
	b _0216D84C // case 1
	b _0216D858 // case 2
	b _0216D864 // case 3
	b _0216D870 // case 4
	b _0216D87C // case 5
_0216D84C:
	bl ViEvtCmnTalk__Func_216D8BC
	strh r0, [r4, #4]
	ldmia sp!, {r4, pc}
_0216D858:
	bl ViEvtCmnTalk__Func_216D944
	strh r0, [r4, #4]
	ldmia sp!, {r4, pc}
_0216D864:
	bl ViEvtCmnTalk__Func_216DA64
	strh r0, [r4, #4]
	ldmia sp!, {r4, pc}
_0216D870:
	bl ViEvtCmnTalk__Func_216DBC8
	strh r0, [r4, #4]
	ldmia sp!, {r4, pc}
_0216D87C:
	bl ViEvtCmnTalk__Func_216DC0C
	strh r0, [r4, #4]
	ldmia sp!, {r4, pc}
	arm_func_end ViEvtCmnTalk__Func_216D81C

	arm_func_start ViEvtCmnTalk__Func_216D888
ViEvtCmnTalk__Func_216D888: // 0x0216D888
	ldrh r0, [r0, #4]
	cmp r0, #5
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ViEvtCmnTalk__Func_216D888

	arm_func_start ViEvtCmnTalk__Func_216D89C
ViEvtCmnTalk__Func_216D89C: // 0x0216D89C
	ldrh r0, [r0, #6]
	bx lr
	arm_func_end ViEvtCmnTalk__Func_216D89C

	arm_func_start ViEvtCmnTalk__Func_216D8A4
ViEvtCmnTalk__Func_216D8A4: // 0x0216D8A4
	ldrh r0, [r0, #8]
	bx lr
	arm_func_end ViEvtCmnTalk__Func_216D8A4

	arm_func_start ViEvtCmnTalk__Func_216D8AC
ViEvtCmnTalk__Func_216D8AC: // 0x0216D8AC
	ldr ip, _0216D8B8 // =FontAnimator__SetCallback
	add r0, r0, #0x40
	bx ip
	.align 2, 0
_0216D8B8: .word FontAnimator__SetCallback
	arm_func_end ViEvtCmnTalk__Func_216D8AC

	arm_func_start ViEvtCmnTalk__Func_216D8BC
ViEvtCmnTalk__Func_216D8BC: // 0x0216D8BC
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	add r0, r5, #0x18
	bl ovl05_2152C74
	mov r4, r0
	add r0, r5, #0x18
	bl ovl05_2152C28
	cmp r0, #0
	ldreq r2, _0216D940 // =0x0000FFFF
	beq _0216D8F4
	add r0, r5, #0x18
	bl ovl05_2152C58
	mov r2, r0
_0216D8F4:
	ldr r3, _0216D940 // =0x0000FFFF
	mov r1, r4
	str r3, [sp]
	mov ip, #1
	add r0, r5, #0x20
	str ip, [sp, #4]
	bl ViEvtCmnMsg__Func_216BCA8
	mov r2, #0x4000000
	ldr r1, [r2]
	ldr r0, [r2]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #0xc
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	mov r0, #2
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216D940: .word 0x0000FFFF
	arm_func_end ViEvtCmnTalk__Func_216D8BC

	arm_func_start ViEvtCmnTalk__Func_216D944
ViEvtCmnTalk__Func_216D944: // 0x0216D944
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	add r0, r6, #0x20
	mov r4, #2
	bl ViEvtCmnMsg__Func_216BD7C
	cmp r0, #0
	beq _0216D9F8
	add r0, r6, #0x18
	bl ovl05_2152D8C
	cmp r0, #0
	bne _0216D9F8
	add r0, r6, #0x18
	bl ovl05_2152C90
	cmp r0, #0
	mov r1, #0
	beq _0216D990
	add r0, r6, #0x20
	bl ViEvtCmnMsg__Func_216BD98
	b _0216D9F8
_0216D990:
	add r0, r6, #0x18
	bl ovl05_2152CDC
	add r0, r6, #0x18
	bl ovl05_2152D8C
	cmp r0, #0
	add r0, r6, #0x20
	beq _0216D9B8
	mov r1, #1
	bl ViEvtCmnMsg__Func_216BD98
	b _0216D9F8
_0216D9B8:
	mov r1, #0
	bl ViEvtCmnMsg__Func_216BD98
	add r0, r6, #0x18
	bl ovl05_2152C74
	mov r5, r0
	add r0, r6, #0x18
	bl ovl05_2152C28
	cmp r0, #0
	ldreq r2, _0216DA60 // =0x0000FFFF
	beq _0216D9EC
	add r0, r6, #0x18
	bl ovl05_2152C58
	mov r2, r0
_0216D9EC:
	mov r1, r5
	add r0, r6, #0x20
	bl ViEvtCmnMsg__Func_216BD70
_0216D9F8:
	add r0, r6, #0x20
	bl ViEvtCmnMsg__Func_216BDA0
	add r0, r6, #0x2a4
	bl ViEvtCmnSelect__Func_216C7B4
	add r0, r6, #0x20
	bl ViEvtCmnMsg__Func_216BED8
	cmp r0, #0
	beq _0216DA58
	add r0, r6, #0x18
	bl ovl05_2152D8C
	cmp r0, #0
	movne r4, #4
	bne _0216DA58
	add r0, r6, #0x18
	bl ovl05_2152C90
	cmp r0, #0
	moveq r4, #4
	beq _0216DA58
	add r0, r6, #0x18
	bl ovl05_2152CC0
	mov r1, r0
	add r0, r6, #0x2a4
	bl ViEvtCmnSelect__Func_216C79C
	mov r4, #3
_0216DA58:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216DA60: .word 0x0000FFFF
	arm_func_end ViEvtCmnTalk__Func_216D944

	arm_func_start ViEvtCmnTalk__Func_216DA64
ViEvtCmnTalk__Func_216DA64: // 0x0216DA64
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x20
	mov r5, #3
	bl ViEvtCmnMsg__Func_216BDA0
	add r0, r4, #0x2a4
	bl ViEvtCmnSelect__Func_216C7B4
	add r0, r4, #0x2a4
	bl ViEvtCmnSelect__Func_216C92C
	cmp r0, #0
	beq _0216DBB8
	add r0, r4, #0x2a4
	bl ViEvtCmnSelect__Func_216C940
	mov r1, r0
	add r0, r4, #0x18
	bl ovl05_2152CDC
	add r0, r4, #0x18
	bl ovl05_2152D8C
	cmp r0, #0
	beq _0216DB6C
	ldrh r1, [r4, #0xa]
	ldr r0, _0216DBC4 // =0x0000FFFF
	cmp r1, r0
	beq _0216DB48
	add r0, r4, #0x18
	bl ovl05_2152D44
	cmp r0, #9
	bne _0216DB48
	ldrh r1, [r4, #0xa]
	add r0, r4, #0x18
	bl ovl05_2152BA4
	ldrh r1, [r4, #0xc]
	add r0, r4, #0x18
	bl ovl05_2152C00
	ldr r1, _0216DBC4 // =0x0000FFFF
	add r0, r4, #0x18
	strh r1, [r4, #0xa]
	strh r1, [r4, #0xc]
	bl ovl05_2152C74
	mov r5, r0
	add r0, r4, #0x18
	bl ovl05_2152C28
	cmp r0, #0
	ldreq r2, _0216DBC4 // =0x0000FFFF
	beq _0216DB28
	add r0, r4, #0x18
	bl ovl05_2152C58
	mov r2, r0
_0216DB28:
	ldr r3, _0216DBC4 // =0x0000FFFF
	mov r1, r5
	str r3, [sp]
	mov ip, #1
	add r0, r4, #0x20
	str ip, [sp, #4]
	bl ViEvtCmnMsg__Func_216BCDC
	b _0216DBB4
_0216DB48:
	ldr r1, _0216DBC4 // =0x0000FFFF
	add r0, r4, #0x20
	mov r2, r1
	mov r3, r1
	str r1, [sp]
	mov r4, #1
	str r4, [sp, #4]
	bl ViEvtCmnMsg__Func_216BCDC
	b _0216DBB4
_0216DB6C:
	add r0, r4, #0x18
	bl ovl05_2152C74
	mov r5, r0
	add r0, r4, #0x18
	bl ovl05_2152C28
	cmp r0, #0
	ldreq r2, _0216DBC4 // =0x0000FFFF
	beq _0216DB98
	add r0, r4, #0x18
	bl ovl05_2152C58
	mov r2, r0
_0216DB98:
	ldr r3, _0216DBC4 // =0x0000FFFF
	mov r1, r5
	str r3, [sp]
	mov ip, #1
	add r0, r4, #0x20
	str ip, [sp, #4]
	bl ViEvtCmnMsg__Func_216BCDC
_0216DBB4:
	mov r5, #2
_0216DBB8:
	mov r0, r5
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216DBC4: .word 0x0000FFFF
	arm_func_end ViEvtCmnTalk__Func_216DA64

	arm_func_start ViEvtCmnTalk__Func_216DBC8
ViEvtCmnTalk__Func_216DBC8: // 0x0216DBC8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x18
	bl ovl05_2152D1C
	cmp r0, #0
	moveq r0, #0x18
	streqh r0, [r4, #6]
	moveq r0, #0
	beq _0216DC00
	add r0, r4, #0x18
	bl ovl05_2152D44
	strh r0, [r4, #6]
	add r0, r4, #0x18
	bl ovl05_2152D68
_0216DC00:
	strh r0, [r4, #8]
	mov r0, #5
	ldmia sp!, {r4, pc}
	arm_func_end ViEvtCmnTalk__Func_216DBC8

	arm_func_start ViEvtCmnTalk__Func_216DC0C
ViEvtCmnTalk__Func_216DC0C: // 0x0216DC0C
	mov r0, #5
	bx lr
	arm_func_end ViEvtCmnTalk__Func_216DC0C

	arm_func_start ViEvtCmnTalk__Func_216DC14
ViEvtCmnTalk__Func_216DC14: // 0x0216DC14
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	ldrh r1, [r0]
	mov r4, r2
	cmp r1, #7
	addne sp, sp, #0x10
	ldmneia sp!, {r4, pc}
	add r1, sp, #0
	add r0, r0, #8
	mov r2, #8
	bl MIi_CpuCopy16
	ldrsh r3, [sp]
	ldrsh r2, [sp, #2]
	ldrsh r1, [sp, #4]
	add lr, r3, #0xe0
	add ip, r2, #0x30
	add r3, r1, #0xe0
	ldrsh r0, [sp, #6]
	add r1, sp, #0
	strh lr, [sp]
	add r2, r0, #0x30
	mov r0, r4
	strh ip, [sp, #2]
	strh r3, [sp, #4]
	strh r2, [sp, #6]
	bl TouchField__SetHitbox
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	arm_func_end ViEvtCmnTalk__Func_216DC14

	arm_func_start ViEvtCmnTalk__Func_216DC84
ViEvtCmnTalk__Func_216DC84: // 0x0216DC84
	stmdb sp!, {r3, lr}
	ldr r0, [r0]
	cmp r0, #0x400000
	bhi _0216DCA4
	bhs _0216DCCC
	cmp r0, #0x40000
	beq _0216DCC0
	ldmia sp!, {r3, pc}
_0216DCA4:
	cmp r0, #0x2000000
	bhi _0216DCB4
	beq _0216DCDC
	ldmia sp!, {r3, pc}
_0216DCB4:
	cmp r0, #0x8000000
	beq _0216DCF8
	ldmia sp!, {r3, pc}
_0216DCC0:
	mov r0, r2
	bl ViEvtCmnMsg__Func_216BF20
	ldmia sp!, {r3, pc}
_0216DCCC:
	mov r0, r2
	mov r1, #3
	bl ViEvtCmnMsg__Func_216BF00
	ldmia sp!, {r3, pc}
_0216DCDC:
	ldr r0, [r1, #0x14]
	tst r0, #0x800
	ldmneia sp!, {r3, pc}
	mov r0, r2
	mov r1, #3
	bl ViEvtCmnMsg__Func_216BF00
	ldmia sp!, {r3, pc}
_0216DCF8:
	ldr r0, [r1, #0x14]
	tst r0, #0x800
	ldmneia sp!, {r3, pc}
	mov r0, r2
	mov r1, #2
	bl ViEvtCmnMsg__Func_216BF00
	ldmia sp!, {r3, pc}
	arm_func_end ViEvtCmnTalk__Func_216DC84
