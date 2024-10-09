	.include "asm/macros.inc"
	.include "global.inc"

	.text

	thumb_func_start VSConnectionMenu__Unknown__Init
VSConnectionMenu__Unknown__Init: // 0x0216A838
	ldr r3, _0216A844 // =MIi_CpuClear16
	mov r1, r0
	mov r0, #0
	mov r2, #0x38
	bx r3
	nop
_0216A844: .word MIi_CpuClear16
	thumb_func_end VSConnectionMenu__Unknown__Init

	thumb_func_start VSConnectionMenu__Unknown__Release
VSConnectionMenu__Unknown__Release: // 0x0216A848
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x34]
	cmp r0, #0
	beq _0216A85A
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x34]
_0216A85A:
	pop {r4, pc}
	thumb_func_end VSConnectionMenu__Unknown__Release

	thumb_func_start VSConnectionMenu__Unknown__Setup
VSConnectionMenu__Unknown__Setup: // 0x0216A85C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	mov r5, r0
	ldr r0, [sp, #0x50]
	str r3, [sp, #0x20]
	str r0, [r5]
	add r1, sp, #0x28
	str r2, [sp, #0x1c]
	ldrh r2, [r1, #0x20]
	ldrh r0, [r1, #0x18]
	sub r0, r2, r0
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	ldrh r2, [r1, #0x24]
	ldrh r0, [r1, #0x1c]
	sub r0, r2, r0
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	mov r0, r4
	mul r0, r6
	lsl r7, r0, #5
	ldr r0, [r5, #0x34]
	cmp r0, #0
	beq _0216A890
	bl _FreeHEAP_USER
_0216A890:
	mov r0, r7
	bl _AllocHeadHEAP_USER
	str r0, [r5, #0x34]
	ldr r1, [r5, #0x34]
	mov r0, #0
	mov r2, r7
	bl MIi_CpuClearFast
	ldr r0, [sp, #0x1c]
	ldr r1, [sp, #0x20]
	bl BackgroundUnknown__Func_204CA00
	add r0, sp, #0x28
	ldrh r1, [r0, #0x18]
	mov r3, #0
	str r1, [sp]
	ldrh r1, [r0, #0x1c]
	str r1, [sp, #4]
	str r4, [sp, #8]
	str r6, [sp, #0xc]
	ldr r1, [r5, #0x34]
	str r1, [sp, #0x10]
	str r3, [sp, #0x14]
	ldrh r0, [r0, #0x14]
	ldr r1, [sp, #0x1c]
	lsl r0, r0, #5
	str r0, [sp, #0x18]
	ldr r2, [sp, #0x20]
	add r0, r5, #4
	bl Unknown2056570__Init
	add r1, sp, #0x28
	ldrh r1, [r1, #0x10]
	add r0, r5, #4
	bl Unknown2056570__Func_2056688
	add r0, r5, #4
	bl Unknown2056570__Func_205683C
	add r0, r5, #4
	bl Unknown2056570__Func_2056B8C
	add r3, sp, #0x28
	ldrh r3, [r3, #0x10]
	ldr r0, _0216A900 // =FontAnimator__Palettes+0x00000008
	mov r1, #4
	lsl r4, r3, #5
	ldr r3, _0216A904 // =0x05000402
	mov r2, #0
	add r3, r4, r3
	bl QueueUncompressedPalette
	add sp, #0x24
	pop {r4, r5, r6, r7, pc}
	nop
_0216A900: .word FontAnimator__Palettes+0x00000008
_0216A904: .word 0x05000402
	thumb_func_end VSConnectionMenu__Unknown__Setup

	thumb_func_start VSConnectionMenu__Unknown__Func_216A908
VSConnectionMenu__Unknown__Func_216A908: // 0x0216A908
	push {r0, r1, r2, r3}
	push {r4, lr}
	sub sp, #0x20
	str r2, [sp]
	mov r4, r0
	str r3, [sp, #4]
	add r0, sp, #0x28
	ldrh r2, [r0, #0x10]
	add r3, sp, #0x44
	str r2, [sp, #8]
	ldr r2, [sp, #0x3c]
	str r2, [sp, #0xc]
	ldrh r0, [r0, #0x18]
	mov r2, #0
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	ldr r0, [sp, #0x44]
	str r0, [sp, #0x18]
	mov r0, #3
	bic r3, r0
	add r0, r3, #4
	str r0, [sp, #0x1c]
	ldr r0, [r4, #0]
	add r3, r4, #4
	bl FontFile__Func_20534F8
	add sp, #0x20
	pop {r4}
	pop {r3}
	add sp, #0x10
	bx r3
	.align 2, 0
	thumb_func_end VSConnectionMenu__Unknown__Func_216A908

	thumb_func_start VSConnectionMenu__Unknown__Func_216A948
VSConnectionMenu__Unknown__Func_216A948: // 0x0216A948
	push {r4, lr}
	ldr r2, [r0, #8]
	cmp r2, #1
	beq _0216A95A
	mov r3, #1
	lsl r3, r3, #0x1a
	ldr r2, _0216A988 // =VSMenuBackground__UpdateMain
	ldr r4, [r3, #0]
	b _0216A960
_0216A95A:
	ldr r3, _0216A98C // =0x04001000
	ldr r2, _0216A990 // =VSMenuBackground__UpdateSub
	ldr r4, [r3, #0]
_0216A960:
	mov r3, #0x1f
	lsl r3, r3, #8
	and r3, r4
	lsr r3, r3, #8
	cmp r1, #0
	beq _0216A97A
	ldrh r0, [r0, #0x14]
	mov r1, #1
	lsl r1, r0
	mov r0, r3
	orr r0, r1
	blx r2
	pop {r4, pc}
_0216A97A:
	ldrh r0, [r0, #0x14]
	mov r1, #1
	lsl r1, r0
	mvn r0, r1
	and r0, r3
	blx r2
	pop {r4, pc}
	.align 2, 0
_0216A988: .word VSMenuBackground__UpdateMain
_0216A98C: .word 0x04001000
_0216A990: .word VSMenuBackground__UpdateSub
	thumb_func_end VSConnectionMenu__Unknown__Func_216A948
