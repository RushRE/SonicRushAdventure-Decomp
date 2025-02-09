	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start NpcUnknown__Func_216EDCC
NpcUnknown__Func_216EDCC: // 0x0216EDCC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x480
	bl MIi_CpuClear32
	add r0, r4, #0x54
	bl FontWindowAnimator__Init
	add r0, r4, #0xb8
	bl FontWindowMWControl__Init
	ldmia sp!, {r4, pc}
	arm_func_end NpcUnknown__Func_216EDCC

	arm_func_start NpcUnknown__Func_216EDF8
NpcUnknown__Func_216EDF8: // 0x0216EDF8
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	ldr r1, [r4, #8]
	mov r5, r0
	str r1, [r5, #4]
	ldrh r1, [r4, #0xc]
	ldr ip, _0216EE90 // =0x0000FFFF
	mov r0, r4
	strh r1, [r5, #8]
	ldrh r3, [r4, #0xe]
	add r1, r5, #0x18
	mov r2, #0x2c
	strh r3, [r5, #0xa]
	ldrh r3, [r4, #0xe]
	strh r3, [r5, #0xc]
	strh ip, [r5, #0xe]
	ldrh r3, [r4, #0x22]
	strh r3, [r5, #0x12]
	ldr r3, [r4, #0]
	str r3, [r5, #0x50]
	strh ip, [r5, #0x14]
	bl MIi_CpuCopy16
	mov r0, r5
	mov r1, r4
	bl NpcUnknown__Func_216F4B8
	mov r0, r5
	mov r1, r4
	bl NpcUnknown__Func_216EFE4
	mov r0, r5
	mov r1, r4
	bl NpcUnknown__Func_216F5F4
	mov r1, #0
	str r1, [r5, #0x44]
	str r1, [r5, #0x48]
	ldr r0, _0216EE94 // =NpcUnknown__Func_2170FF4
	str r1, [r5, #0x4c]
	str r0, [r5, #0x478]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216EE90: .word 0x0000FFFF
_0216EE94: .word NpcUnknown__Func_2170FF4
	arm_func_end NpcUnknown__Func_216EDF8

	arm_func_start NpcUnknown__Func_216EE98
NpcUnknown__Func_216EE98: // 0x0216EE98
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl NpcUnknown__Func_216F7DC
	mov r0, r4
	bl NpcUnknown__Func_216F6DC
	mov r0, r4
	bl NpcUnknown__Func_216F770
	mov r0, r4
	bl NpcUnknown__Func_216EDCC
	ldmia sp!, {r4, pc}
	arm_func_end NpcUnknown__Func_216EE98

	arm_func_start NpcUnknown__Func_216EEC0
NpcUnknown__Func_216EEC0: // 0x0216EEC0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	mov r4, r2
	bl NpcUnknown__Func_2170FF8
	ldr r2, _0216EF48 // =0x0000FFFF
	mov r0, r5
	mov r1, #0
	strh r2, [r5, #0xe]
	bl NpcUnknown__Func_21708D8
	mov r0, r5
	mov r1, #0
	bl NpcUnknown__Func_217092C
	mov r3, #0
	add r0, r5, #0x54
	mov r1, #1
	mov r2, #0xc
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r5, #0x54
	bl FontWindowAnimator__StartAnimating
	mov r0, #1
	str r0, [r5, #0x48]
	cmp r4, #0
	add r0, r5, #0x54
	beq _0216EF30
	bl FontWindowAnimator__Func_20599C4
	b _0216EF34
_0216EF30:
	bl FontWindowAnimator__Func_20599B4
_0216EF34:
	ldr r1, _0216EF4C // =NpcUnknown__Func_2170A10
	mov r0, #4
	str r1, [r5, #0x478]
	bl PlayHubSfx
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216EF48: .word 0x0000FFFF
_0216EF4C: .word NpcUnknown__Func_2170A10
	arm_func_end NpcUnknown__Func_216EEC0

	arm_func_start NpcUnknown__Func_216EF50
NpcUnknown__Func_216EF50: // 0x0216EF50
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x478]
	cmp r4, #0
	beq _0216EF68
	blx r4
_0216EF68:
	str r4, [r5, #0x47c]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end NpcUnknown__Func_216EF50

	arm_func_start NpcUnknown__Func_216EF70
NpcUnknown__Func_216EF70: // 0x0216EF70
	ldrh r0, [r0, #0xc]
	bx lr
	arm_func_end NpcUnknown__Func_216EF70

	arm_func_start NpcUnknown__Func_216EF78
NpcUnknown__Func_216EF78: // 0x0216EF78
	ldr r0, [r0, #0x44]
	bx lr
	arm_func_end NpcUnknown__Func_216EF78

	arm_func_start NpcUnknown__Func_216EF80
NpcUnknown__Func_216EF80: // 0x0216EF80
	ldr r0, [r0, #0x4c]
	bx lr
	arm_func_end NpcUnknown__Func_216EF80

	arm_func_start NpcUnknown__Func_216EF88
NpcUnknown__Func_216EF88: // 0x0216EF88
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl NpcUnknown__Func_216EFC0
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl NpcUnknown__Func_216EFDC
	ldr r1, _0216EFBC // =0x0000FFFF
	cmp r0, r1
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216EFBC: .word 0x0000FFFF
	arm_func_end NpcUnknown__Func_216EF88

	arm_func_start NpcUnknown__Func_216EFC0
NpcUnknown__Func_216EFC0: // 0x0216EFC0
	ldr r1, [r0, #0x478]
	ldr r0, _0216EFD8 // =NpcUnknown__Func_2170FF4
	cmp r1, r0
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_0216EFD8: .word NpcUnknown__Func_2170FF4
	arm_func_end NpcUnknown__Func_216EFC0

	arm_func_start NpcUnknown__Func_216EFDC
NpcUnknown__Func_216EFDC: // 0x0216EFDC
	ldrh r0, [r0, #0xe]
	bx lr
	arm_func_end NpcUnknown__Func_216EFDC

	arm_func_start NpcUnknown__Func_216EFE4
NpcUnknown__Func_216EFE4: // 0x0216EFE4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x28
	mov r9, r0
	mov r8, r1
	add r0, r9, #0x54
	bl FontWindowAnimator__Init
	bl _ZN10HubControl10GetField54Ev
	ldrh r3, [r8, #0x26]
	mov r2, #0
	mov r1, r0
	str r3, [sp]
	str r2, [sp, #4]
	str r2, [sp, #8]
	mov r0, #0x20
	str r0, [sp, #0xc]
	mov r0, #0x18
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r0, #2
	str r0, [sp, #0x18]
	mov r0, #3
	str r0, [sp, #0x1c]
	mov r0, #0x3c0
	str r0, [sp, #0x20]
	add r0, r0, #0x3f
	str r0, [sp, #0x24]
	add r0, r9, #0x54
	ldrh r3, [r8, #0x24]
	bl FontWindowAnimator__Load1
	add r0, r9, #0xb8
	bl FontWindowMWControl__Init
	bl _ZN10HubControl10GetField54Ev
	mov r1, r0
	mov r0, #0x19
	str r0, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	mov r2, #0
	str r2, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	mov r0, #0x1f
	str r0, [sp, #0x10]
	mov r0, #5
	str r0, [sp, #0x14]
	add r0, r9, #0xb8
	ldrh r3, [r8, #0x28]
	bl FontWindowMWControl__Load
	ldr r4, [r8, #0x10]
	ldrh r1, [r8, #0x20]
	mov r0, r4
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r4
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, _0216F4AC // =0x05000200
	mov r0, #1
	str r2, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r0, #0x1e
	str r0, [sp, #0x18]
	add r0, r9, #0x10c
	ldrh r2, [r8, #0x20]
	bl AnimatorSprite__Init
	mov r1, #8
	add r0, r9, #0x100
	strh r1, [r0, #0x14]
	strh r1, [r0, #0x16]
	mov r1, #0xc
	strh r1, [r0, #0x5c]
	ldr r4, [r8, #0x14]
	mov r1, #2
	mov r0, r4
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0216F4AC // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	mov r1, r4
	str r0, [sp, #0x14]
	mov r2, #0x1e
	add r0, r9, #0x170
	str r2, [sp, #0x18]
	mov r2, #2
	bl AnimatorSprite__Init
	mov r1, #0xe0
	add r0, r9, #0x100
	strh r1, [r0, #0x78]
	mov r1, #0x20
	strh r1, [r0, #0x7a]
	mov r1, #0xd
	strh r1, [r0, #0xc0]
	ldr r4, [r8, #0x14]
	mov r1, #5
	mov r0, r4
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r4
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, _0216F4AC // =0x05000200
	mov r0, #1
	str r2, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r0, #0x1e
	str r0, [sp, #0x18]
	add r0, r9, #0x1d4
	mov r2, #5
	bl AnimatorSprite__Init
	mov r1, #0xe0
	add r0, r9, #0x100
	strh r1, [r0, #0xdc]
	mov r1, #0x60
	strh r1, [r0, #0xde]
	mov r1, #0xe
	add r0, r9, #0x200
	strh r1, [r0, #0x24]
	ldr r4, [r8, #0x18]
	mov r0, r4
	bl Sprite__GetSpriteSize1
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r4
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r3, _0216F4AC // =0x05000200
	mov r0, #1
	str r3, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r0, #0x1e
	str r0, [sp, #0x18]
	add r0, r9, #0x238
	mov r3, r2
	bl AnimatorSprite__Init
	add r0, r9, #0x200
	mov r1, #0xec
	strh r1, [r0, #0x40]
	mov r1, #0xac
	strh r1, [r0, #0x42]
	mov r1, #0xf
	strh r1, [r0, #0x88]
	ldr r4, [r8, #0x1c]
	mov r1, #1
	mov r0, r4
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0216F4AC // =0x05000200
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r1, r4
	add r0, r9, #0x29c
	mov r2, #1
	str r3, [sp, #0x18]
	mov r3, #4
	bl AnimatorSprite__Init
	mov r1, #8
	add r0, r9, #0x200
	strh r1, [r0, #0x88]
	mov r0, #0x6400
	str r0, [r9, #0x378]
	ldr r0, _0216F4B0 // =0x06001000
	str r0, [r9, #0x374]
	ldr r0, [r9, #0x378]
	bl _AllocHeadHEAP_USER
	str r0, [r9, #0x37c]
	mov r0, #0x800
	bl _AllocHeadHEAP_USER
	str r0, [r9, #0x380]
	add r0, r9, #0x300
	bl MessageController__Init
	ldr r0, [r9, #0x50]
	bl FontWindow__GetFont
	mov r1, r0
	add r0, r9, #0x300
	bl MessageController__SetFont
	add r0, r9, #0x300
	ldr r1, [r8, #4]
	bl MessageController__LoadMPCFile
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	str r0, [sp, #8]
	add r0, r9, #0x300
	ldr r1, [r9, #0x37c]
	mov r2, #0x19
	mov r3, #0x20
	bl MessageController__Setup
	add r0, r9, #0x300
	ldr r1, _0216F4B4 // =NpcUnknown__Func_21705A0
	mov r2, r9
	bl MessageController__SetClearPixelCallback
	ldrh r0, [r9, #8]
	mov r0, r0, lsl #3
	bl _AllocHeadHEAP_SYSTEM
	str r0, [r9, #0x384]
	ldrh r0, [r9, #8]
	mov r7, #0
	mov r6, r7
	cmp r0, #0
	ble _0216F460
	mov r4, r7
	mov r5, r7
_0216F380:
	ldr r1, [r9, #0x384]
	mov r0, r6, lsl #2
	strb r5, [r1, r6, lsl #3]
	ldr r1, [r9, #4]
	ldrh r0, [r1, r0]
	tst r0, #1
	beq _0216F3AC
	ldr r1, [r9, #0x384]
	ldrb r0, [r1, r6, lsl #3]
	orr r0, r0, #1
	strb r0, [r1, r6, lsl #3]
_0216F3AC:
	ldr r1, [r9, #4]
	mov r0, r6, lsl #2
	ldrh r0, [r1, r0]
	tst r0, #2
	beq _0216F3D0
	ldr r1, [r9, #0x384]
	ldrb r0, [r1, r6, lsl #3]
	orr r0, r0, #2
	strb r0, [r1, r6, lsl #3]
_0216F3D0:
	ldr r1, [r9, #4]
	mov r0, r6, lsl #2
	ldrh r0, [r1, r0]
	tst r0, #4
	beq _0216F3F4
	ldr r1, [r9, #0x384]
	ldrb r0, [r1, r6, lsl #3]
	orr r0, r0, #4
	strb r0, [r1, r6, lsl #3]
_0216F3F4:
	ldr r1, [r9, #4]
	ldr r0, [r9, #0x384]
	add r1, r1, r6, lsl #2
	ldrh r1, [r1, #2]
	add r0, r0, r6, lsl #3
	mov r2, r4
	strh r1, [r0, #4]
	ldr r1, [r9, #0x384]
	ldr r0, [r8, #4]
	add r1, r1, r6, lsl #3
	ldrh r1, [r1, #4]
	bl MPC__GetDialogLineCount
	ldr r1, [r9, #0x384]
	add r1, r1, r6, lsl #3
	strb r0, [r1, #1]
	ldr r0, [r9, #0x384]
	add r0, r0, r6, lsl #3
	strh r7, [r0, #2]
	ldr r1, [r9, #0x384]
	ldrh r0, [r9, #8]
	add r1, r1, r6, lsl #3
	ldrb r1, [r1, #1]
	add r6, r6, #1
	cmp r6, r0
	add r0, r7, r1, lsl #4
	add r7, r0, #8
	blt _0216F380
_0216F460:
	sub r0, r7, #0x98
	str r0, [r9, #0x390]
	cmp r0, r7
	movhs r0, #0
	strhs r0, [r9, #0x390]
	ldrh r0, [r9, #0xa]
	ldr r1, [r9, #0x384]
	add r0, r1, r0, lsl #3
	ldrh r1, [r0, #2]
	str r1, [r9, #0x388]
	ldr r0, [r9, #0x390]
	cmp r1, r0
	strhi r0, [r9, #0x388]
	mov r0, r9
	bl NpcUnknown__Func_216F7E0
	mov r0, #0
	str r0, [r9, #0x398]
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0216F4AC: .word 0x05000200
_0216F4B0: .word 0x06001000
_0216F4B4: .word NpcUnknown__Func_21705A0
	arm_func_end NpcUnknown__Func_216EFE4

	arm_func_start NpcUnknown__Func_216F4B8
NpcUnknown__Func_216F4B8: // 0x0216F4B8
	stmdb sp!, {r4, lr}
	ldrh r1, [r1, #0x28]
	mov r4, r0
	ldr r0, _0216F5CC // =0x05000082
	cmp r1, #2
	moveq r1, #0x28c0
	ldrne r1, _0216F5D0 // =0x0000014B
	mov r2, #0x20
	strh r1, [r0]
	ldr r1, _0216F5D4 // =0x06008800
	mov r0, #0
	bl MIi_CpuClear32
	ldr r0, _0216F5D8 // =0x11111111
	ldr r1, _0216F5DC // =0x06008820
	mov r2, #0x20
	bl MIi_CpuClear32
	ldr r0, _0216F5E0 // =0x00004040
	ldr r1, _0216F5E4 // =0x06008000
	mov r2, #0x800
	bl MIi_CpuClear16
	mov r0, #0x800
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x39c]
	mov r0, #0x40
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x3a0]
	mov r0, #0x40
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x3a4]
	mov r0, #0x40
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x3a8]
	ldr r0, _0216F5E8 // =0x40404040
	ldr r1, [r4, #0x39c]
	mov r2, #0x800
	bl MIi_CpuClear32
	ldr r0, _0216F5E0 // =0x00004040
	ldr r1, [r4, #0x3a0]
	mov r2, #4
	bl MIi_CpuClear16
	ldr r1, [r4, #0x3a0]
	ldr r0, _0216F5EC // =0x00004041
	mov r2, #0x32
	add r1, r1, #4
	bl MIi_CpuClear16
	ldr r1, [r4, #0x3a0]
	ldr r0, _0216F5E0 // =0x00004040
	mov r2, #0xa
	add r1, r1, #0x36
	bl MIi_CpuClear16
	ldr r0, _0216F5E0 // =0x00004040
	ldr r1, [r4, #0x3a4]
	mov r2, #4
	bl MIi_CpuClear16
	ldr r1, [r4, #0x3a4]
	ldr r0, _0216F5F0 // =0x00004042
	mov r2, #0x32
	add r1, r1, #4
	bl MIi_CpuClear16
	ldr r1, [r4, #0x3a4]
	ldr r0, _0216F5E0 // =0x00004040
	mov r2, #0xa
	add r1, r1, #0x36
	bl MIi_CpuClear16
	ldr r1, [r4, #0x3a8]
	ldr r0, _0216F5E8 // =0x40404040
	mov r2, #0x40
	bl MIi_CpuClear32
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216F5CC: .word 0x05000082
_0216F5D0: .word 0x0000014B
_0216F5D4: .word 0x06008800
_0216F5D8: .word 0x11111111
_0216F5DC: .word 0x06008820
_0216F5E0: .word 0x00004040
_0216F5E4: .word 0x06008000
_0216F5E8: .word 0x40404040
_0216F5EC: .word 0x00004041
_0216F5F0: .word 0x00004042
	arm_func_end NpcUnknown__Func_216F4B8

	arm_func_start NpcUnknown__Func_216F5F4
NpcUnknown__Func_216F5F4: // 0x0216F5F4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	add r0, r4, #0x3ac
	bl TouchField__Init
	mov r1, #0
	str r1, [r4, #0x3b8]
	strb r1, [r4, #0x3bc]
	mov r0, #0x14
	strb r0, [r4, #0x3bf]
	mov r0, #1
	strb r0, [r4, #0x3c0]
	mov ip, #0xe0
	mov r3, #0x20
	mov r2, #0xf8
	mov r0, #0x5c
	strh r3, [sp, #0xa]
	strh r2, [sp, #0xc]
	strh r0, [sp, #0xe]
	strh ip, [sp, #8]
	str r1, [sp]
	ldr r2, _0216F6D8 // =TouchField__PointInRect
	add r3, sp, #8
	add r0, r4, #0x3c4
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	mov r1, #0
	str r1, [r4, #0x46c]
	mov r0, #0xe0
	mov r3, #0x60
	mov r2, #0xf8
	strh r0, [sp, #8]
	mov r0, #0x9c
	strh r3, [sp, #0xa]
	strh r2, [sp, #0xc]
	strh r0, [sp, #0xe]
	str r1, [sp]
	ldr r2, _0216F6D8 // =TouchField__PointInRect
	add r3, sp, #8
	add r0, r4, #0x3fc
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	mov r1, #0
	str r1, [r4, #0x470]
	add r0, r4, #0x34
	str r1, [sp]
	ldr r2, _0216F6D8 // =TouchField__PointInRect
	add r0, r0, #0x400
	mov r3, r1
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	mov r1, #0
	mov r0, r4
	str r1, [r4, #0x474]
	bl NpcUnknown__Func_21706C0
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216F6D8: .word TouchField__PointInRect
	arm_func_end NpcUnknown__Func_216F5F4

	arm_func_start NpcUnknown__Func_216F6DC
NpcUnknown__Func_216F6DC: // 0x0216F6DC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x384]
	cmp r0, #0
	beq _0216F6FC
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r4, #0x384]
_0216F6FC:
	ldr r0, [r4, #0x380]
	cmp r0, #0
	beq _0216F714
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x380]
_0216F714:
	ldr r0, [r4, #0x37c]
	cmp r0, #0
	beq _0216F72C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x37c]
_0216F72C:
	add r0, r4, #0x300
	bl MessageController__InitFunc
	add r0, r4, #0x29c
	bl AnimatorSprite__Release
	add r0, r4, #0x238
	bl AnimatorSprite__Release
	add r0, r4, #0x1d4
	bl AnimatorSprite__Release
	add r0, r4, #0x170
	bl AnimatorSprite__Release
	add r0, r4, #0x10c
	bl AnimatorSprite__Release
	add r0, r4, #0xb8
	bl FontWindowMWControl__Release
	add r0, r4, #0x54
	bl FontWindowAnimator__Release
	ldmia sp!, {r4, pc}
	arm_func_end NpcUnknown__Func_216F6DC

	arm_func_start NpcUnknown__Func_216F770
NpcUnknown__Func_216F770: // 0x0216F770
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x3a8]
	cmp r0, #0
	beq _0216F790
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x3a8]
_0216F790:
	ldr r0, [r4, #0x3a0]
	cmp r0, #0
	beq _0216F7A8
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x3a0]
_0216F7A8:
	ldr r0, [r4, #0x3a4]
	cmp r0, #0
	beq _0216F7C0
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x3a4]
_0216F7C0:
	ldr r0, [r4, #0x39c]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x39c]
	ldmia sp!, {r4, pc}
	arm_func_end NpcUnknown__Func_216F770

	arm_func_start NpcUnknown__Func_216F7DC
NpcUnknown__Func_216F7DC: // 0x0216F7DC
	bx lr
	arm_func_end NpcUnknown__Func_216F7DC

	arm_func_start NpcUnknown__Func_216F7E0
NpcUnknown__Func_216F7E0: // 0x0216F7E0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r9, #0
	ldr r6, _0216F8F4 // =0x000003FF
	mov r10, r0
	mov r7, r9
	mov r8, #0x80
	mov r11, #0xa
	mov r5, #4
	mov r4, r9
_0216F804:
	ldr r1, [r10, #0x380]
	mov r0, r6
	mov r2, r5
	add r1, r1, r9, lsl #1
	bl MIi_CpuClear16
	add r0, r9, #2
	mov r1, r0, lsl #0x10
	mov r0, r4
	mov r9, r1, lsr #0x10
_0216F828:
	add r1, r8, #1
	add r2, r9, #1
	add r0, r0, #1
	ldr ip, [r10, #0x380]
	mov r3, r9, lsl #1
	strh r8, [ip, r3]
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	cmp r0, #0x19
	mov r8, r1, lsr #0x10
	mov r9, r2, lsr #0x10
	blt _0216F828
	ldr r1, [r10, #0x380]
	mov r0, r6
	mov r2, r11
	add r1, r1, r9, lsl #1
	bl MIi_CpuClear16
	add r0, r9, #5
	mov r0, r0, lsl #0x10
	add r7, r7, #1
	cmp r7, #0x20
	mov r9, r0, lsr #0x10
	blt _0216F804
	ldr r1, [r10, #0x37c]
	ldr r2, [r10, #0x378]
	mov r0, #0
	bl MIi_CpuClearFast
	add r3, r10, #0x96
	ldr r1, [r10, #0x388]
	mov r0, r10
	add r2, r10, #0x394
	add r3, r3, #0x300
	bl NpcUnknown__Func_216FFD8
	add r4, r10, #0x300
	ldrh r5, [r4, #0x94]
	ldrh r0, [r4, #0x96]
	cmp r5, r0
	ldmhiia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216F8C0:
	mov r0, r10
	mov r1, r5
	bl NpcUnknown__Func_216F9AC
	mov r0, r10
	mov r1, r5
	bl NpcUnknown__Func_21705A4
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	ldrh r1, [r4, #0x96]
	mov r5, r0, lsr #0x10
	cmp r1, r0, lsr #16
	bhs _0216F8C0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216F8F4: .word 0x000003FF
	arm_func_end NpcUnknown__Func_216F7E0

	arm_func_start NpcUnknown__Func_216F8F8
NpcUnknown__Func_216F8F8: // 0x0216F8F8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	mov r0, r1
	mov r1, #0x100
	mov r4, r2
	bl FX_ModS32
	add r1, r0, r4
	cmp r1, #0x100
	bls _0216F984
	rsb r6, r0, #0x100
	mov r1, r6, lsl #0x10
	mov r2, #0xc8
	str r2, [sp]
	mov r1, r1, lsr #0x10
	str r1, [sp, #4]
	mov r1, r0, lsl #0x10
	mov r3, r1, lsr #0x10
	ldr r0, [r5, #0x37c]
	mov r1, #0x19
	mov r2, #0
	bl BackgroundUnknown__Func_204CBF4
	sub r0, r4, r6
	mov r0, r0, lsl #0x10
	mov r1, #0xc8
	str r1, [sp]
	mov r0, r0, lsr #0x10
	mov r2, #0
	str r0, [sp, #4]
	ldr r0, [r5, #0x37c]
	mov r3, r2
	mov r1, #0x19
	bl BackgroundUnknown__Func_204CBF4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
_0216F984:
	mov r1, #0xc8
	stmia sp, {r1, r4}
	mov r1, r0, lsl #0x10
	mov r3, r1, lsr #0x10
	ldr r0, [r5, #0x37c]
	mov r1, #0x19
	mov r2, #0
	bl BackgroundUnknown__Func_204CBF4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NpcUnknown__Func_216F8F8

	arm_func_start NpcUnknown__Func_216F9AC
NpcUnknown__Func_216F9AC: // 0x0216F9AC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r0, [r7, #0x384]
	mov r6, r1
	add r5, r0, r6, lsl #3
	ldrh r0, [r5, #2]
	mov r1, #0x100
	bl FX_ModS32
	ldrb r2, [r5, #1]
	mov r4, r0
	ldrh r1, [r5, #2]
	mov r0, r2, lsl #4
	add r0, r0, #8
	mov r2, r0, lsl #0x10
	mov r0, r7
	mov r2, r2, lsr #0x10
	bl NpcUnknown__Func_216F8F8
	mov r2, r4, lsl #0x10
	ldrh r3, [r5, #4]
	mov r0, r7
	mov r1, r6
	mov r2, r2, asr #0x10
	bl NpcUnknown__Func_216FA40
	ldrb r0, [r5, #1]
	mov r0, r0, lsl #4
	add r0, r0, #8
	add r0, r4, r0
	cmp r0, #0x100
	ldmleia sp!, {r3, r4, r5, r6, r7, pc}
	sub r0, r4, #0x100
	mov r2, r0, lsl #0x10
	ldrh r3, [r5, #4]
	mov r0, r7
	mov r1, r6
	mov r2, r2, asr #0x10
	bl NpcUnknown__Func_216FA40
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end NpcUnknown__Func_216F9AC

	arm_func_start NpcUnknown__Func_216FA40
NpcUnknown__Func_216FA40: // 0x0216FA40
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x28
	mov r10, r0
	ldr r4, [r10, #0x384]
	mov r9, r2
	str r1, [sp, #0x1c]
	ldrb r0, [r4, r1, lsl #3]
	tst r0, #4
	str r3, [sp, #0x20]
	movne r7, #0x2000
	bne _0216FA78
	tst r0, #1
	movne r7, #0
	moveq r7, #0x1000
_0216FA78:
	ldr r0, [sp, #0x1c]
	mov r3, #0
	add r0, r4, r0, lsl #3
	ldrb r1, [r0, #1]
	mov r0, r9, asr #2
	add r0, r9, r0, lsr #29
	mov r1, r1, lsl #1
	add r5, r1, #1
	mov r2, r0, asr #3
	mvn r0, #0
	cmp r5, #0
	str r0, [sp, #0x24]
	ble _0216FB40
	mov r8, r2, lsl #3
	mov r1, r3
	mov r0, r3
_0216FAB8:
	adds r6, r2, r3
	bmi _0216FB34
	cmp r6, #0x20
	bge _0216FB40
	ldr r4, [r10, #0x380]
	cmp r3, #0
	add r6, r4, r6, lsl #6
	ldr r11, _0216FD30 // =0x00000FFF
	bne _0216FB0C
	mov r4, r1
_0216FAE0:
	ldrh ip, [r6]
	add r4, r4, #1
	cmp r4, #0x20
	and ip, ip, r11
	strh ip, [r6]
	ldrh ip, [r6]
	orr ip, ip, #0x5000
	strh ip, [r6], #2
	blt _0216FAE0
	str r8, [sp, #0x24]
	b _0216FB34
_0216FB0C:
	mov r4, r0
_0216FB10:
	ldrh ip, [r6]
	add r4, r4, #1
	cmp r4, #0x20
	and ip, ip, r11
	strh ip, [r6]
	ldrh ip, [r6]
	orr ip, ip, r7
	strh ip, [r6], #2
	blt _0216FB10
_0216FB34:
	add r3, r3, #1
	cmp r3, r5
	blt _0216FAB8
_0216FB40:
	ldr r0, [sp, #0x24]
	cmp r0, #0
	blt _0216FC8C
	mov r0, #5
	bl _ZN10HubControl16GetFileFrom_ViBGEt
	bl GetBackgroundPixels
	ldr r1, [sp, #0x1c]
	ldrh r7, [r10, #0x12]
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r5, r0
	cmp r7, #0
	mov r11, r1, asr #0x10
	mov r6, #1
	mov r8, #0
	ble _0216FC1C
	ldr r0, [sp, #0x24]
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
_0216FB8C:
	mov r1, #0xa
	mul r1, r6, r1
	mov r0, r11
	bl FX_ModS32
	mov r1, r6
	bl FX_DivS32
	mov r0, r0, lsl #0x13
	mov r2, r0, lsr #0x10
	mov r0, #0xa
	mul r0, r6, r0
	mov r6, r0
	add r0, r8, #1
	mov r1, #8
	sub r0, r7, r0
	str r1, [sp]
	mov r0, r0, lsl #0x13
	str r1, [sp, #4]
	ldr r1, [r10, #0x37c]
	mov r0, r0, asr #0x10
	mov r0, r0, lsl #0x10
	str r1, [sp, #8]
	mov r1, r0, lsr #0x10
	mov r0, #0x19
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r4, [sp, #0x14]
	mov r0, #0
	str r0, [sp, #0x18]
	add r0, r5, #4
	mov r1, #0xd
	mov r3, #0
	bl BackgroundUnknown__CopyPixels
	ldrh r7, [r10, #0x12]
	add r8, r8, #1
	cmp r8, r7
	blt _0216FB8C
_0216FC1C:
	ldr r1, [r10, #0x384]
	ldr r0, [sp, #0x1c]
	ldrb r0, [r1, r0, lsl #3]
	tst r0, #2
	beq _0216FC8C
	mov r0, #0x18
	str r0, [sp]
	mov r0, #8
	str r0, [sp, #4]
	mov r0, r7, lsl #0x13
	ldr r2, [r10, #0x37c]
	mov r0, r0, asr #0x10
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x24]
	str r2, [sp, #8]
	mov r2, #0x19
	mov r0, r0, lsl #0x10
	str r2, [sp, #0xc]
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x10]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x14]
	mov r3, #0
	add r0, r5, #4
	mov r1, #0xd
	mov r2, #0x50
	str r3, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
_0216FC8C:
	add r0, r9, #8
	mov r0, r0, lsl #0x10
	mov r9, r0, asr #0x10
	add r0, r10, #0x300
	mov r1, #0
	bl MessageController__SetCallbackValue
	mov r1, r9
	add r0, r10, #0x300
	bl MessageController__AdvanceLine
	ldr r1, [sp, #0x20]
	add r0, r10, #0x300
	bl MessageController__SetSequence
	mov r1, #0
	mov r2, r1
	add r0, r10, #0x300
	bl MessageController__InitStartPos
	add r0, r10, #0x300
	bl MessageController__IsEndOfLine
	cmp r0, #0
	addne sp, sp, #0x28
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r5, #8
	mov r4, #0
_0216FCE8:
	mov r1, r5
	mov r2, r9
	add r0, r10, #0x300
	bl MessageController__SetPosition
	mov r1, r4
	add r0, r10, #0x300
	bl MessageController__Func_205416C
	add r0, r10, #0x300
	bl MessageController__AdvanceLineID
	add r0, r9, #0x10
	mov r1, r0, lsl #0x10
	add r0, r10, #0x300
	mov r9, r1, asr #0x10
	bl MessageController__IsEndOfLine
	cmp r0, #0
	beq _0216FCE8
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216FD30: .word 0x00000FFF
	arm_func_end NpcUnknown__Func_216FA40

	arm_func_start NpcUnknown__Func_216FD34
NpcUnknown__Func_216FD34: // 0x0216FD34
	mvn r3, #0
	cmp r2, r3
	ldreq r2, [r0, #0x388]
	ldr r0, [r0, #0x384]
	add r1, r0, r1, lsl #3
	ldrb r0, [r1, #1]
	ldrh r1, [r1, #2]
	mov r0, r0, lsl #4
	cmp r2, r1
	add r0, r0, #8
	bhi _0216FD80
	add r1, r1, r0
	add r0, r2, #0x98
	cmp r0, r1
	movhs r0, #0
	sublo r0, r1, r0
	movlo r0, r0, lsl #0x10
	movlo r0, r0, asr #0x10
	bx lr
_0216FD80:
	sub r0, r2, r1
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	bx lr
	arm_func_end NpcUnknown__Func_216FD34

	arm_func_start NpcUnknown__Func_216FD94
NpcUnknown__Func_216FD94: // 0x0216FD94
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r1, #0
	beq _0216FDE4
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0216FDC4
	ldr r0, _0216FE90 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	movne r0, #1
	bne _0216FDC8
_0216FDC4:
	mov r0, #0
_0216FDC8:
	cmp r0, #0
	ldreq r0, _0216FE94 // =0x0000FFFF
	ldmeqia sp!, {r4, pc}
	ldr r0, _0216FE90 // =touchInput
	ldrh r1, [r0, #0x1c]
	ldrh r2, [r0, #0x1e]
	b _0216FE20
_0216FDE4:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0216FE04
	ldr r0, _0216FE90 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #8
	movne r0, #1
	bne _0216FE08
_0216FE04:
	mov r0, #0
_0216FE08:
	cmp r0, #0
	ldreq r0, _0216FE94 // =0x0000FFFF
	ldmeqia sp!, {r4, pc}
	ldr r0, _0216FE90 // =touchInput
	ldrh r1, [r0, #0x20]
	ldrh r2, [r0, #0x22]
_0216FE20:
	sub r0, r1, #0x10
	sub r1, r2, #0x20
	cmp r0, #0xc8
	cmplo r1, #0x98
	bhs _0216FE88
	add r0, r4, #0x300
	ldrsh r3, [r0, #0x94]
	ldrsh ip, [r0, #0x96]
	ldr r0, [r4, #0x388]
	cmp r3, ip
	add r2, r1, r0
	bgt _0216FE88
	ldr r4, [r4, #0x384]
_0216FE54:
	add r1, r4, r3, lsl #3
	ldrb r0, [r1, #1]
	ldrh r1, [r1, #2]
	mov r0, r0, lsl #4
	sub r1, r2, r1
	add r0, r0, #8
	cmp r1, r0
	movlo r0, r3, lsl #0x10
	movlo r0, r0, lsr #0x10
	ldmloia sp!, {r4, pc}
	add r3, r3, #1
	cmp r3, ip
	ble _0216FE54
_0216FE88:
	ldr r0, _0216FE94 // =0x0000FFFF
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FE90: .word touchInput
_0216FE94: .word 0x0000FFFF
	arm_func_end NpcUnknown__Func_216FD94

	arm_func_start NpcUnknown__Func_216FE98
NpcUnknown__Func_216FE98: // 0x0216FE98
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	add r2, sp, #2
	add r3, sp, #0
	mov r7, r0
	mov r6, r1
	bl NpcUnknown__Func_216FFD8
	add r8, r7, #0x300
	ldrh r0, [r8, #0x94]
	ldrh r5, [sp, #2]
	mov r4, #0
	cmp r5, r0
	bhs _0216FF08
	cmp r5, r0
	mov r4, #1
	bhs _0216FF08
_0216FED8:
	mov r1, r5, lsl #0x10
	mov r0, r7
	mov r1, r1, lsr #0x10
	bl NpcUnknown__Func_216F9AC
	mov r1, r5, lsl #0x10
	mov r0, r7
	mov r1, r1, lsr #0x10
	bl NpcUnknown__Func_21705A4
	ldrh r0, [r8, #0x94]
	add r5, r5, #1
	cmp r5, r0
	blo _0216FED8
_0216FF08:
	add r0, r7, #0x300
	ldrh r1, [r0, #0x96]
	ldrh r0, [sp]
	cmp r0, r1
	bls _0216FF64
	add r5, r1, #1
	cmp r5, r0
	bhi _0216FF64
	cmp r5, r0
	mov r4, #1
	bhi _0216FF64
_0216FF34:
	mov r1, r5, lsl #0x10
	mov r0, r7
	mov r1, r1, lsr #0x10
	bl NpcUnknown__Func_216F9AC
	mov r1, r5, lsl #0x10
	mov r0, r7
	mov r1, r1, lsr #0x10
	bl NpcUnknown__Func_21705A4
	ldrh r0, [sp]
	add r5, r5, #1
	cmp r5, r0
	bls _0216FF34
_0216FF64:
	ldrh r1, [sp, #2]
	add r0, r7, #0x300
	cmp r4, #0
	strh r1, [r0, #0x94]
	ldrh r1, [sp]
	strh r1, [r0, #0x96]
	beq _0216FFB4
	ldr r0, [r7, #0x37c]
	ldr r1, [r7, #0x378]
	bl DC_StoreRange
	ldr r0, [r7, #0x37c]
	ldr r1, [r7, #0x378]
	ldr r3, [r7, #0x374]
	mov r2, #0
	bl QueueUncompressedPixels
	mov r0, r7
	mov r1, #1
	bl NpcUnknown__Func_217062C
	mov r0, r7
	bl NpcUnknown__Func_2170224
_0216FFB4:
	sub r0, r6, #0x20
	mov r0, r0, lsl #0x10
	ldr r1, _0216FFD4 // =renderCoreGFXControlA
	mov r0, r0, lsr #0x10
	strh r0, [r1, #0xe]
	strh r0, [r1, #6]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216FFD4: .word renderCoreGFXControlA
	arm_func_end NpcUnknown__Func_216FE98

	arm_func_start NpcUnknown__Func_216FFD8
NpcUnknown__Func_216FFD8: // 0x0216FFD8
	stmdb sp!, {r3, r4, r5, lr}
	ldrh r5, [r0, #8]
	mov lr, #0
	cmp r5, #0
	bls _02170028
	ldr r4, [r0, #0x384]
_0216FFF0:
	add ip, r4, lr, lsl #3
	ldrh ip, [ip, #2]
	cmp ip, r1
	blo _02170014
	cmp lr, #0
	streqh lr, [r2]
	subne ip, lr, #1
	strneh ip, [r2]
	b _02170028
_02170014:
	add ip, lr, #1
	mov ip, ip, lsl #0x10
	cmp r5, ip, lsr #16
	mov lr, ip, lsr #0x10
	bhi _0216FFF0
_02170028:
	ldrh r4, [r0, #8]
	cmp lr, r4
	bhs _02170060
	ldr r2, [r0, #0x384]
	add r1, r1, #0x98
_0217003C:
	add r0, r2, lr, lsl #3
	ldrh r0, [r0, #2]
	cmp r0, r1
	bhi _02170060
	add r0, lr, #1
	mov r0, r0, lsl #0x10
	cmp r4, r0, lsr #16
	mov lr, r0, lsr #0x10
	bhi _0217003C
_02170060:
	cmp lr, r4
	strloh lr, [r3]
	subhs r0, r4, #1
	strhsh r0, [r3]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end NpcUnknown__Func_216FFD8

	arm_func_start NpcUnknown__Func_2170074
NpcUnknown__Func_2170074: // 0x02170074
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x20
	mov r4, r0
	mov r7, r1
	ldr r0, [r4, #0x37c]
	ldr r1, [r4, #0x378]
	bl DC_StoreRange
	cmp r7, #0
	ldr r0, [r4, #0x37c]
	mov r2, #0
	ldr r1, [r4, #0x378]
	beq _021700B0
	ldr r3, [r4, #0x374]
	bl QueueUncompressedPixels
	b _021700B8
_021700B0:
	ldr r3, [r4, #0x374]
	bl LoadUncompressedPixels
_021700B8:
	ldr r0, [r4, #0x380]
	mov r1, #0x800
	bl DC_StoreRange
	mov r1, #0
	cmp r7, #0
	mov r3, #0x20
	str r1, [sp]
	beq _02170104
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	str r3, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r0, [r4, #0x380]
	mov r2, r1
	bl Mappings__ReadMappingsCompressed
	b _0217012C
_02170104:
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	str r3, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r0, [r4, #0x380]
	mov r2, r1
	bl Mappings__LoadUnknown
_0217012C:
	mov r0, #5
	bl _ZN10HubControl16GetFileFrom_ViBGEt
	ldrh r1, [r4, #0x40]
	mov r4, r0
	ldr r3, _02170200 // =0x05000002
	cmp r1, #2
	ldreq r5, _02170204 // =ovl05_021731DC
	ldreq r6, _02170208 // =ovl05_021731E2
	ldrne r5, _0217020C // =ovl05_021731E8
	ldrne r6, _02170210 // =ovl05_021731EE
	cmp r7, #0
	mov r1, #4
	beq _021701B0
	ldr r0, _02170214 // =FontAnimator__Palettes+0x00000008
	mov r2, #0
	bl QueueUncompressedPalette
	ldr r3, _02170218 // =0x05000022
	mov r0, r5
	mov r1, #3
	mov r2, #0
	bl QueueUncompressedPalette
	ldr r3, _0217021C // =0x05000042
	mov r0, r6
	mov r1, #3
	mov r2, #0
	bl QueueUncompressedPalette
	mov r0, r4
	bl GetBackgroundPalette
	ldr r2, _02170220 // =0x050000A0
	mov r1, #0
	bl QueueCompressedPalette
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021701B0:
	ldr r0, _02170214 // =FontAnimator__Palettes+0x00000008
	mov r2, #0
	bl LoadUncompressedPalette
	ldr r3, _02170218 // =0x05000022
	mov r0, r5
	mov r1, #3
	mov r2, #0
	bl LoadUncompressedPalette
	ldr r3, _0217021C // =0x05000042
	mov r0, r6
	mov r1, #3
	mov r2, #0
	bl LoadUncompressedPalette
	mov r0, r4
	bl GetBackgroundPalette
	ldr r2, _02170220 // =0x050000A0
	mov r1, #0
	bl LoadCompressedPalette
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02170200: .word 0x05000002
_02170204: .word ovl05_021731DC
_02170208: .word ovl05_021731E2
_0217020C: .word ovl05_021731E8
_02170210: .word ovl05_021731EE
_02170214: .word FontAnimator__Palettes+0x00000008
_02170218: .word 0x05000022
_0217021C: .word 0x05000042
_02170220: .word 0x050000A0
	arm_func_end NpcUnknown__Func_2170074

	arm_func_start NpcUnknown__Func_2170224
NpcUnknown__Func_2170224: // 0x02170224
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	mov r4, r0
	ldr r0, [r4, #0x380]
	mov r1, #0x800
	bl DC_StoreRange
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r3, #0x20
	str r3, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r0, [r4, #0x380]
	mov r2, r1
	bl Mappings__ReadMappingsCompressed
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}
	arm_func_end NpcUnknown__Func_2170224

	arm_func_start NpcUnknown__Func_2170278
NpcUnknown__Func_2170278: // 0x02170278
	stmdb sp!, {r3, lr}
	ldr r0, _021702B0 // =0x03FF03FF
	mov r1, #0x6000000
	mov r2, #0x1000
	bl MIi_CpuClear32
	ldr r1, _021702B4 // =0x06007FE0
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldr r0, _021702B8 // =renderCoreGFXControlA
	mov r1, #0
	strh r1, [r0, #0xc]
	strh r1, [r0, #0xe]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021702B0: .word 0x03FF03FF
_021702B4: .word 0x06007FE0
_021702B8: .word renderCoreGFXControlA
	arm_func_end NpcUnknown__Func_2170278

	arm_func_start NpcUnknown__Func_21702BC
NpcUnknown__Func_21702BC: // 0x021702BC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x10c
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x10c
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end NpcUnknown__Func_21702BC

	arm_func_start NpcUnknown__Func_21702E0
NpcUnknown__Func_21702E0: // 0x021702E0
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldrh r3, [r4, #0xa]
	ldrh r0, [r4, #8]
	cmp r3, r0
	ldmhsia sp!, {r4, r5, r6, pc}
	ldr r2, [r4, #0x384]
	ldr r0, [r4, #0x388]
	add r2, r2, r3, lsl #3
	ldrh r3, [r2, #2]
	ldrb r2, [r2, #1]
	cmp r1, #0
	sub r0, r3, r0
	add r0, r0, #0x28
	mov r0, r0, lsl #0x10
	mov r1, r2, lsl #0x14
	mov r5, r0, asr #0x10
	mov r6, r1, lsr #0x10
	add r0, r4, #0xb8
	beq _0217033C
	mov r1, #0
	bl FontWindowMWControl__SetPaletteAnim
	b _02170344
_0217033C:
	mov r1, #1
	bl FontWindowMWControl__SetPaletteAnim
_02170344:
	mov r2, r5
	add r0, r4, #0xb8
	mov r1, #0x10
	bl FontWindowMWControl__SetPosition
	mov r2, r6
	add r0, r4, #0xb8
	mov r1, #0xc8
	bl FontWindowMWControl__SetOffset
	add r0, r4, #0xb8
	bl FontWindowMWControl__Draw
	add r0, r4, #0xb8
	bl FontWindowMWControl__CallWindowFunc2
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NpcUnknown__Func_21702E0

	arm_func_start NpcUnknown__Func_2170378
NpcUnknown__Func_2170378: // 0x02170378
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r1, #0
	add r0, r4, #0xb8
	beq _02170398
	mov r1, #0
	bl FontWindowMWControl__SetPaletteAnim
	b _021703A0
_02170398:
	mov r1, #1
	bl FontWindowMWControl__SetPaletteAnim
_021703A0:
	add r0, r4, #0xb8
	bl FontWindowMWControl__ValidatePaletteAnim
	ldmia sp!, {r4, pc}
	arm_func_end NpcUnknown__Func_2170378

	arm_func_start NpcUnknown__Func_21703AC
NpcUnknown__Func_21703AC: // 0x021703AC
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r1, #0
	ldrneh r2, [r4, #0xc]
	ldrh r0, [r4, #8]
	ldreqh r2, [r4, #0xa]
	cmp r2, r0
	ldmhsia sp!, {r4, pc}
	ldr r1, [r4, #0x384]
	ldr r0, [r4, #0x388]
	add r1, r1, r2, lsl #3
	ldrh r2, [r1, #2]
	ldrb r1, [r1, #1]
	sub r0, r2, r0
	add r0, r0, #0x28
	mov r0, r0, lsl #0x10
	mov ip, r0, asr #0x10
	mov r0, r1, lsl #0x14
	cmp ip, #0x28
	mov lr, r0, lsr #0x10
	movlt ip, #0x28
	blt _02170418
	add r0, ip, lr
	cmp r0, #0xb8
	rsbgt r0, lr, #0xb8
	movgt r0, r0, lsl #0x10
	movgt ip, r0, asr #0x10
_02170418:
	mov r1, #0
	add r3, r4, #0x200
	mov r0, #0x10
	mov r2, r1
	strh r0, [r3, #0xa4]
	add ip, ip, lr, asr #1
	add r0, r4, #0x29c
	strh ip, [r3, #0xa6]
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x29c
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end NpcUnknown__Func_21703AC

	arm_func_start NpcUnknown__Func_2170448
NpcUnknown__Func_2170448: // 0x02170448
	ldr ip, _02170458 // =AnimatorSprite__SetAnimation
	add r0, r0, #0x29c
	mov r1, #1
	bx ip
	.align 2, 0
_02170458: .word AnimatorSprite__SetAnimation
	arm_func_end NpcUnknown__Func_2170448

	arm_func_start NpcUnknown__Func_217045C
NpcUnknown__Func_217045C: // 0x0217045C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #0xa]
	cmp r0, #0
	beq _02170490
	ldr r0, [r4, #0x3d8]
	tst r0, #0x800
	bne _02170488
	tst r0, #0x10
	movne r1, #3
	bne _02170494
_02170488:
	mov r1, #2
	b _02170494
_02170490:
	mov r1, #4
_02170494:
	add r0, r4, #0x100
	ldrh r0, [r0, #0x7c]
	cmp r0, r1
	beq _021704AC
	add r0, r4, #0x170
	bl AnimatorSprite__SetAnimation
_021704AC:
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x170
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x170
	bl AnimatorSprite__DrawFrame
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	sub r0, r0, #1
	cmp r1, r0
	bge _021704F8
	ldr r0, [r4, #0x410]
	tst r0, #0x800
	bne _021704F0
	tst r0, #0x10
	movne r1, #6
	bne _021704FC
_021704F0:
	mov r1, #5
	b _021704FC
_021704F8:
	mov r1, #7
_021704FC:
	add r0, r4, #0x100
	ldrh r0, [r0, #0xe0]
	cmp r0, r1
	beq _02170514
	add r0, r4, #0x1d4
	bl AnimatorSprite__SetAnimation
_02170514:
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x1d4
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x1d4
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end NpcUnknown__Func_217045C

	arm_func_start NpcUnknown__Func_2170530
NpcUnknown__Func_2170530: // 0x02170530
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r0, #2
	str r4, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x448]
	tst r0, #0x800
	bne _02170560
	tst r0, #0x10
	movne r1, #1
	bne _02170564
_02170560:
	mov r1, #0
_02170564:
	add r0, r4, #0x200
	ldrh r0, [r0, #0x44]
	cmp r0, r1
	beq _0217057C
	add r0, r4, #0x238
	bl AnimatorSprite__SetAnimation
_0217057C:
	ldr r1, _0217059C // =NpcUnknown__Func_2170860
	add r2, sp, #0
	add r0, r4, #0x238
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x238
	bl AnimatorSprite__DrawFrame
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217059C: .word NpcUnknown__Func_2170860
	arm_func_end NpcUnknown__Func_2170530

	arm_func_start NpcUnknown__Func_21705A0
NpcUnknown__Func_21705A0: // 0x021705A0
	bx lr
	arm_func_end NpcUnknown__Func_21705A0

	arm_func_start NpcUnknown__Func_21705A4
NpcUnknown__Func_21705A4: // 0x021705A4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r5, r0
	ldr r0, [r5, #0x384]
	add r4, r0, r1, lsl #3
	ldrh r0, [r4, #2]
	mov r1, #0x100
	bl FX_ModS32
	mov r0, r0, lsl #0xd
	mov r6, r0, lsr #0x10
	ldr r1, [r5, #0x39c]
	ldr r0, [r5, #0x3a8]
	add r1, r1, r6, lsl #6
	mov r2, #0x40
	bl MIi_CpuCopyFast
	ldrb r0, [r4, #1]
	add r1, r6, #1
	and r4, r1, #0x1f
	mov r0, r0, lsl #0x11
	mov r8, r0, lsr #0x10
	mov r7, #0
	cmp r8, #0
	ldmleia sp!, {r4, r5, r6, r7, r8, pc}
	mov r6, #0x40
_02170600:
	ldr r1, [r5, #0x39c]
	ldr r0, [r5, #0x3a0]
	mov r2, r6
	add r1, r1, r4, lsl #6
	bl MIi_CpuCopyFast
	add r0, r4, #1
	add r7, r7, #1
	and r4, r0, #0x1f
	cmp r7, r8
	blt _02170600
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end NpcUnknown__Func_21705A4

	arm_func_start NpcUnknown__Func_217062C
NpcUnknown__Func_217062C: // 0x0217062C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x20
	mov r5, r0
	ldr r0, [r5, #0x39c]
	mov r4, r1
	mov r1, #0x800
	bl DC_StoreRange
	mov r1, #0
	cmp r4, #0
	mov r0, #0x10
	str r1, [sp]
	mov r3, #0x20
	beq _02170690
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	str r3, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r0, [r5, #0x39c]
	mov r2, r1
	bl Mappings__ReadMappingsCompressed
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, pc}
_02170690:
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	str r3, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r0, [r5, #0x39c]
	mov r2, r1
	bl Mappings__LoadUnknown
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end NpcUnknown__Func_217062C

	arm_func_start NpcUnknown__Func_21706C0
NpcUnknown__Func_21706C0: // 0x021706C0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl NpcUnknown__Func_21706EC
	mov r0, r5
	mov r1, r4
	bl NpcUnknown__Func_2170740
	mov r0, r5
	mov r1, r4
	bl NpcUnknown__Func_2170794
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end NpcUnknown__Func_21706C0

	arm_func_start NpcUnknown__Func_21706EC
NpcUnknown__Func_21706EC: // 0x021706EC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x46c]
	mov r4, r1
	cmp r0, r4
	ldmeqia sp!, {r3, r4, r5, pc}
	cmp r4, #0
	beq _02170720
	ldr r2, _0217073C // =0x0000FFFF
	add r0, r5, #0x3ac
	add r1, r5, #0x3c4
	bl TouchField__AddArea
	b _02170734
_02170720:
	add r0, r5, #0x3ac
	add r1, r5, #0x3c4
	bl TouchField__RemoveArea
	add r0, r5, #0x3c4
	bl TouchField__ResetArea
_02170734:
	str r4, [r5, #0x46c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217073C: .word 0x0000FFFF
	arm_func_end NpcUnknown__Func_21706EC

	arm_func_start NpcUnknown__Func_2170740
NpcUnknown__Func_2170740: // 0x02170740
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x470]
	mov r4, r1
	cmp r0, r4
	ldmeqia sp!, {r3, r4, r5, pc}
	cmp r4, #0
	beq _02170774
	ldr r2, _02170790 // =0x0000FFFF
	add r0, r5, #0x3ac
	add r1, r5, #0x3fc
	bl TouchField__AddArea
	b _02170788
_02170774:
	add r0, r5, #0x3ac
	add r1, r5, #0x3fc
	bl TouchField__RemoveArea
	add r0, r5, #0x3fc
	bl TouchField__ResetArea
_02170788:
	str r4, [r5, #0x470]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02170790: .word 0x0000FFFF
	arm_func_end NpcUnknown__Func_2170740

	arm_func_start NpcUnknown__Func_2170794
NpcUnknown__Func_2170794: // 0x02170794
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x474]
	mov r4, r1
	cmp r0, r4
	ldmeqia sp!, {r3, r4, r5, pc}
	cmp r4, #0
	add r1, r5, #0x34
	beq _021707CC
	ldr r2, _021707EC // =0x0000FFFF
	add r0, r5, #0x3ac
	add r1, r1, #0x400
	bl TouchField__AddArea
	b _021707E4
_021707CC:
	add r0, r5, #0x3ac
	add r1, r1, #0x400
	bl TouchField__RemoveArea
	add r0, r5, #0x34
	add r0, r0, #0x400
	bl TouchField__ResetArea
_021707E4:
	str r4, [r5, #0x474]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021707EC: .word 0x0000FFFF
	arm_func_end NpcUnknown__Func_2170794

	arm_func_start NpcUnknown__Func_21707F0
NpcUnknown__Func_21707F0: // 0x021707F0
	ldr r0, [r0, #0x3d8]
	tst r0, #0x800
	bne _02170808
	tst r0, #0x200000
	movne r0, #1
	bxne lr
_02170808:
	mov r0, #0
	bx lr
	arm_func_end NpcUnknown__Func_21707F0

	arm_func_start NpcUnknown__Func_2170810
NpcUnknown__Func_2170810: // 0x02170810
	ldr r0, [r0, #0x410]
	tst r0, #0x800
	bne _02170828
	tst r0, #0x200000
	movne r0, #1
	bxne lr
_02170828:
	mov r0, #0
	bx lr
	arm_func_end NpcUnknown__Func_2170810

	arm_func_start NpcUnknown__Func_2170830
NpcUnknown__Func_2170830: // 0x02170830
	ldr r1, [r0, #0x474]
	cmp r1, #0
	moveq r0, #0
	bxeq lr
	ldr r0, [r0, #0x448]
	tst r0, #0x800
	movne r0, #0
	bxne lr
	tst r0, #0x40000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end NpcUnknown__Func_2170830

	arm_func_start NpcUnknown__Func_2170860
NpcUnknown__Func_2170860: // 0x02170860
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x10
	ldrh r3, [r0, #0]
	cmp r3, #7
	addne sp, sp, #0x10
	ldmneia sp!, {r3, pc}
	ldrsh lr, [r0, #8]
	ldrsh ip, [r1, #8]
	mov r3, #0x38
	add ip, lr, ip
	strh ip, [sp]
	ldrsh lr, [r0, #0xa]
	ldrsh ip, [r1, #0xa]
	add ip, lr, ip
	strh ip, [sp, #2]
	ldrsh lr, [r0, #0xc]
	ldrsh ip, [r1, #8]
	add ip, lr, ip
	strh ip, [sp, #4]
	ldrsh ip, [r1, #0xa]
	ldrsh r0, [r0, #0xe]
	add r1, sp, #0
	add r0, r0, ip
	strh r0, [sp, #6]
	ldmia r2, {r0, r2}
	add r0, r0, #0x3c4
	mla r0, r2, r3, r0
	bl TouchField__SetHitbox
	add sp, sp, #0x10
	ldmia sp!, {r3, pc}
	arm_func_end NpcUnknown__Func_2170860

	arm_func_start NpcUnknown__Func_21708D8
NpcUnknown__Func_21708D8: // 0x021708D8
	cmp r1, #0
	mov r2, #0x4000000
	beq _02170908
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
_02170908:
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
	arm_func_end NpcUnknown__Func_21708D8

	arm_func_start NpcUnknown__Func_217092C
NpcUnknown__Func_217092C: // 0x0217092C
	cmp r1, #0
	mov r2, #0x4000000
	beq _0217095C
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #0xa
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
_0217095C:
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #0xa
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
	arm_func_end NpcUnknown__Func_217092C

	arm_func_start NpcUnknown__Func_2170980
NpcUnknown__Func_2170980: // 0x02170980
	cmp r1, #0
	ldreq r0, _02170A0C // =renderCoreGFXControlA
	moveq r1, #0
	streq r1, [r0, #0x1c]
	bxeq lr
	ldr r0, _02170A0C // =renderCoreGFXControlA
	mov r1, #0xff
	strb r1, [r0, #0x10]
	mov r1, #0
	strb r1, [r0, #0x11]
	mov r1, #0xb8
	strb r1, [r0, #0x14]
	mov r1, #0x20
	strb r1, [r0, #0x15]
	ldrb r2, [r0, #0x18]
	mov r1, #1
	bic r2, r2, #1
	orr ip, r2, #1
	and r2, ip, #0xff
	orr r2, r2, #0x1e
	strb r2, [r0, #0x18]
	ldrb r2, [r0, #0x1a]
	bic r2, r2, #1
	orr ip, r2, #1
	and r2, ip, #0xff
	bic r3, r2, #2
	and r2, r3, #0xff
	orr r2, r2, #4
	bic r3, r2, #8
	strb r2, [r0, #0x1a]
	and r2, r3, #0xff
	orr r2, r2, #0x10
	strb r2, [r0, #0x1a]
	str r1, [r0, #0x1c]
	bx lr
	.align 2, 0
_02170A0C: .word renderCoreGFXControlA
	arm_func_end NpcUnknown__Func_2170980

	arm_func_start NpcUnknown__Func_2170A10
NpcUnknown__Func_2170A10: // 0x02170A10
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #1
	bl NpcUnknown__Func_21708D8
	add r0, r4, #0x54
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0x54
	bl FontWindowAnimator__Draw
	add r0, r4, #0x54
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x54
	bl FontWindowAnimator__SetWindowOpen
	mov r0, #0
	str r0, [r4, #0x48]
	mov r1, #1
	mov r0, r4
	str r1, [r4, #0x44]
	bl NpcUnknown__Func_2170980
	ldrh r1, [r4, #0x38]
	add r0, r4, #0x10c
	bl AnimatorSprite__SetAnimation
	add r0, r4, #0xb8
	bl FontWindowMWControl__ValidatePaletteAnim
	mov r0, r4
	bl NpcUnknown__Func_2170448
	add r0, r4, #0x170
	mov r1, #2
	bl AnimatorSprite__SetAnimation
	add r0, r4, #0x1d4
	mov r1, #5
	bl AnimatorSprite__SetAnimation
	add r0, r4, #0x238
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	mov r0, r4
	mov r1, #1
	bl NpcUnknown__Func_2170074
	mov r0, r4
	mov r1, #1
	bl NpcUnknown__Func_217062C
	ldr r1, [r4, #0x388]
	mov r0, r4
	bl NpcUnknown__Func_216FE98
	mov r0, r4
	mov r1, #1
	bl NpcUnknown__Func_217092C
	ldrh r0, [r4, #0xa]
	cmp r0, #0
	mov r0, r4
	beq _02170AEC
	mov r1, #1
	bl NpcUnknown__Func_21706EC
	b _02170AF4
_02170AEC:
	mov r1, #0
	bl NpcUnknown__Func_21706EC
_02170AF4:
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	sub r0, r0, #1
	cmp r1, r0
	mov r0, r4
	bge _02170B18
	mov r1, #1
	bl NpcUnknown__Func_2170740
	b _02170B20
_02170B18:
	mov r1, #0
	bl NpcUnknown__Func_2170740
_02170B20:
	mov r0, r4
	mov r1, #1
	bl NpcUnknown__Func_2170794
	ldr r0, _02170B38 // =NpcUnknown__Func_2170B3C
	str r0, [r4, #0x478]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170B38: .word NpcUnknown__Func_2170B3C
	arm_func_end NpcUnknown__Func_2170A10

	arm_func_start NpcUnknown__Func_2170B3C
NpcUnknown__Func_2170B3C: // 0x02170B3C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #4
	mov r6, #0
	mov r10, r0
	mov r7, r6
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02170B70
	ldr r0, _02170EB0 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	movne r9, #1
	bne _02170B74
_02170B70:
	mov r9, #0
_02170B74:
	mov r1, #0
	add r0, r10, #0x3ac
	str r1, [r10, #0x398]
	bl TouchField__Process
	mov r0, r10
	bl NpcUnknown__Func_21702BC
	mov r0, r10
	mov r1, #1
	bl NpcUnknown__Func_21702E0
	mov r0, r10
	mov r1, #0
	bl NpcUnknown__Func_21703AC
	mov r0, r10
	bl NpcUnknown__Func_217045C
	mov r0, r10
	bl NpcUnknown__Func_2170530
	mov r0, r10
	mov r1, #1
	ldrh r4, [r10, #0xa]
	bl NpcUnknown__Func_216FD94
	mov r5, r0
	mov r0, r10
	mov r1, #0
	bl NpcUnknown__Func_216FD94
	mov r8, r0
	ldr r0, _02170EB4 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	movne r6, #1
	bne _02170CEC
	tst r0, #2
	bne _02170C04
	mov r0, r10
	bl NpcUnknown__Func_2170830
	cmp r0, #0
	beq _02170C0C
_02170C04:
	mov r7, #1
	b _02170CEC
_02170C0C:
	cmp r9, #0
	bne _02170C24
	ldr r0, _02170EB4 // =padInput
	ldrh r0, [r0, #8]
	tst r0, #0x40
	bne _02170C34
_02170C24:
	mov r0, r10
	bl NpcUnknown__Func_21707F0
	cmp r0, #0
	beq _02170C54
_02170C34:
	cmp r4, #0
	beq _02170CEC
	sub r0, r4, #1
	ldr r1, _02170EB8 // =0x0000FFFF
	mov r0, r0, lsl #0x10
	strh r1, [r10, #0x14]
	mov r4, r0, lsr #0x10
	b _02170CEC
_02170C54:
	cmp r9, #0
	bne _02170C6C
	ldr r0, _02170EB4 // =padInput
	ldrh r0, [r0, #8]
	tst r0, #0x80
	bne _02170C7C
_02170C6C:
	mov r0, r10
	bl NpcUnknown__Func_2170810
	cmp r0, #0
	beq _02170CA4
_02170C7C:
	ldrh r0, [r10, #8]
	sub r0, r0, #1
	cmp r4, r0
	bge _02170CEC
	add r0, r4, #1
	ldr r1, _02170EB8 // =0x0000FFFF
	mov r0, r0, lsl #0x10
	strh r1, [r10, #0x14]
	mov r4, r0, lsr #0x10
	b _02170CEC
_02170CA4:
	ldrh r0, [r10, #8]
	cmp r5, r0
	movlo r4, r5
	strloh r5, [r10, #0x14]
	blo _02170CEC
	ldrh r0, [r10, #0x14]
	ldr r2, _02170EB8 // =0x0000FFFF
	cmp r0, r2
	beq _02170CEC
	cmp r0, r8
	cmpeq r0, r4
	bne _02170CEC
	mov r0, r10
	mov r1, r4
	sub r2, r2, #0x10000
	bl NpcUnknown__Func_216FD34
	cmp r0, #0
	moveq r6, #1
_02170CEC:
	cmp r6, #0
	beq _02170D08
	ldr r0, [r10, #0x384]
	ldrb r0, [r0, r4, lsl #3]
	tst r0, #1
	moveq r6, #0
	streq r6, [r10, #0x398]
_02170D08:
	cmp r6, #0
	beq _02170D5C
	strh r4, [r10, #0xa]
	strh r4, [r10, #0xc]
	ldrh r1, [r10, #0xa]
	ldr r2, _02170EB8 // =0x0000FFFF
	mov r0, r10
	strh r1, [r10, #0xe]
	mov r1, #0
	strh r2, [r10, #0x14]
	bl NpcUnknown__Func_21706C0
	mov r0, #1
	bl PlayHubSfx
	mov r1, #0
	mov r0, r10
	str r1, [r10]
	bl NpcUnknown__Func_2170378
	ldr r0, _02170EBC // =NpcUnknown__Func_2170EC8
	add sp, sp, #4
	str r0, [r10, #0x478]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
_02170D5C:
	cmp r7, #0
	beq _02170DD8
	ldr r2, _02170EB8 // =0x0000FFFF
	mov r0, r10
	strh r2, [r10, #0xe]
	mov r1, #0
	strh r2, [r10, #0x14]
	bl NpcUnknown__Func_217092C
	mov r0, r10
	mov r1, #0
	bl NpcUnknown__Func_2170980
	mov r3, #0
	add r0, r10, #0x54
	mov r1, #4
	mov r2, #0xc
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r10, #0x54
	bl FontWindowAnimator__StartAnimating
	mov r0, #1
	str r0, [r10, #0x48]
	mov r1, #0
	str r1, [r10, #0x44]
	str r0, [r10, #0x4c]
	mov r0, r10
	bl NpcUnknown__Func_21706C0
	mov r0, #2
	bl PlayHubSfx
	ldr r0, _02170EC0 // =NpcUnknown__Func_2170F6C
	str r0, [r10, #0x478]
	b _02170E54
_02170DD8:
	ldrh r0, [r10, #0xa]
	cmp r4, r0
	beq _02170E54
	mov r0, r10
	mov r1, #1
	bl NpcUnknown__Func_2170378
	mov r0, r10
	bl NpcUnknown__Func_2170448
	mov r0, #3
	bl PlayHubSfx
	mov r0, r10
	mov r1, r4
	mvn r2, #0
	bl NpcUnknown__Func_216FD34
	cmp r0, #0
	streqh r4, [r10, #0xa]
	streqh r4, [r10, #0xc]
	beq _02170E54
	strh r4, [r10, #0xc]
	mov r1, #0
	str r1, [r10]
	ldr r1, [r10, #0x388]
	add r1, r1, r0
	str r1, [r10, #0x38c]
	mov r0, r10
	str r1, [r10, #0x388]
	bl NpcUnknown__Func_216FE98
	ldrh r1, [r10, #0xc]
	ldr r0, _02170EC4 // =NpcUnknown__Func_2170B3C
	strh r1, [r10, #0xa]
	str r0, [r10, #0x478]
_02170E54:
	ldrh r0, [r10, #0xa]
	cmp r0, #0
	mov r0, r10
	beq _02170E70
	mov r1, #1
	bl NpcUnknown__Func_21706EC
	b _02170E78
_02170E70:
	mov r1, #0
	bl NpcUnknown__Func_21706EC
_02170E78:
	ldrh r0, [r10, #8]
	ldrh r1, [r10, #0xa]
	sub r0, r0, #1
	cmp r1, r0
	mov r0, r10
	bge _02170EA0
	mov r1, #1
	bl NpcUnknown__Func_2170740
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
_02170EA0:
	mov r1, #0
	bl NpcUnknown__Func_2170740
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02170EB0: .word touchInput
_02170EB4: .word padInput
_02170EB8: .word 0x0000FFFF
_02170EBC: .word NpcUnknown__Func_2170EC8
_02170EC0: .word NpcUnknown__Func_2170F6C
_02170EC4: .word NpcUnknown__Func_2170B3C
	arm_func_end NpcUnknown__Func_2170B3C

	arm_func_start NpcUnknown__Func_2170EC8
NpcUnknown__Func_2170EC8: // 0x02170EC8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	bl NpcUnknown__Func_21702BC
	mov r0, r4
	mov r1, #0
	bl NpcUnknown__Func_21702E0
	mov r0, r4
	bl NpcUnknown__Func_217045C
	mov r0, r4
	bl NpcUnknown__Func_2170530
	ldr r0, [r4, #0]
	add r0, r0, #1
	cmp r0, #0x10
	addlo sp, sp, #4
	str r0, [r4]
	ldmloia sp!, {r3, r4, pc}
	mov r0, r4
	mov r1, #0
	bl NpcUnknown__Func_217092C
	mov r0, r4
	mov r1, #0
	bl NpcUnknown__Func_2170980
	mov r3, #0
	add r0, r4, #0x54
	mov r1, #4
	mov r2, #0xc
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0x54
	bl FontWindowAnimator__StartAnimating
	mov r1, #1
	str r1, [r4, #0x48]
	mov r0, #0
	str r0, [r4, #0x44]
	ldr r0, _02170F68 // =NpcUnknown__Func_2170F6C
	str r1, [r4, #0x4c]
	str r0, [r4, #0x478]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02170F68: .word NpcUnknown__Func_2170F6C
	arm_func_end NpcUnknown__Func_2170EC8

	arm_func_start NpcUnknown__Func_2170F6C
NpcUnknown__Func_2170F6C: // 0x02170F6C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x54
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0x54
	bl FontWindowAnimator__Draw
	add r0, r4, #0x54
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x54
	bl FontWindowAnimator__SetWindowClosed
	mov r0, r4
	mov r1, #0
	bl NpcUnknown__Func_21708D8
	mov r0, r4
	bl NpcUnknown__Func_2170278
	ldr r0, _02170FBC // =NpcUnknown__Func_2170FC0
	str r0, [r4, #0x478]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170FBC: .word NpcUnknown__Func_2170FC0
	arm_func_end NpcUnknown__Func_2170F6C

	arm_func_start NpcUnknown__Func_2170FC0
NpcUnknown__Func_2170FC0: // 0x02170FC0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x54
	bl FontWindowAnimator__SetWindowOpen
	mov r0, #0
	str r0, [r4, #0x48]
	str r0, [r4, #0x44]
	str r0, [r4, #0x4c]
	bl NpcUnknown__Func_2170FF8
	ldr r0, _02170FF0 // =NpcUnknown__Func_2170FF4
	str r0, [r4, #0x478]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170FF0: .word NpcUnknown__Func_2170FF4
	arm_func_end NpcUnknown__Func_2170FC0

	arm_func_start NpcUnknown__Func_2170FF4
NpcUnknown__Func_2170FF4: // 0x02170FF4
	bx lr
	arm_func_end NpcUnknown__Func_2170FF4

	arm_func_start NpcUnknown__Func_2170FF8
NpcUnknown__Func_2170FF8: // 0x02170FF8
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x30
	ldr lr, _02171090 // =NpcUnknown__keyRepeatInitialTime
	add ip, sp, #0x18
	mov r3, #6
_0217100C:
	ldrh r2, [lr]
	ldrh r1, [lr, #2]
	add lr, lr, #4
	strh r2, [ip]
	strh r1, [ip, #2]
	add ip, ip, #4
	subs r3, r3, #1
	bne _0217100C
	ldr lr, _02171094 // =NpcUnknown__keyRepeatRepeatTime
	add ip, sp, #0
	mov r3, #6
_02171038:
	ldrh r2, [lr]
	ldrh r1, [lr, #2]
	add lr, lr, #4
	strh r2, [ip]
	strh r1, [ip, #2]
	add ip, ip, #4
	subs r3, r3, #1
	bne _02171038
	cmp r0, #0
	beq _02171078
	ldr r0, _02171098 // =padInput
	add r1, sp, #0x18
	add r2, sp, #0
	bl InitPadInput
	add sp, sp, #0x30
	ldmia sp!, {r3, pc}
_02171078:
	mov r1, #0
	ldr r0, _02171098 // =padInput
	mov r2, r1
	bl InitPadInput
	add sp, sp, #0x30
	ldmia sp!, {r3, pc}
	.align 2, 0
_02171090: .word NpcUnknown__keyRepeatInitialTime
_02171094: .word NpcUnknown__keyRepeatRepeatTime
_02171098: .word padInput
	arm_func_end NpcUnknown__Func_2170FF8
	
	.rodata

.public NpcUnknown__keyRepeatRepeatTime
NpcUnknown__keyRepeatRepeatTime: // 0x021731C4
	.hword 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1

.public ovl05_021731DC
ovl05_021731DC: // 0x021731DC
    .hword 0x662E, 0x4147, 0x1C60
	
.public ovl05_021731E2
ovl05_021731E2: // 0x021731E2
    .hword 0x37F, 0x278, 0x144 
	
.public ovl05_021731E8
ovl05_021731E8: // 0x021731E8
    .hword 0x178, 0x1EF, 0xC7 
	
.public ovl05_021731EE
ovl05_021731EE: // 0x021731EE
    .hword 0x178, 0x1EF, 0xC7
	
NpcUnknown__keyRepeatInitialTime: // 0x021731F4
	.hword 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20
