	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start ViShadow__Constructor
ViShadow__Constructor: // 0x02167D70
	ldr r2, _02167D9C // =0x02173908
	mov r1, #0
	str r2, [r0]
	str r1, [r0, #4]
	str r1, [r0, #8]
	str r1, [r0, #0xc]
	mov r1, #0x6000
	str r1, [r0, #0x10]
	mov r1, #0xf
	strh r1, [r0, #0x14]
	bx lr
	.align 2, 0
_02167D9C: .word 0x02173908
	arm_func_end ViShadow__Constructor

	arm_func_start ViShadow__VTableFunc_2167DA0
ViShadow__VTableFunc_2167DA0: // 0x02167DA0
	stmdb sp!, {r4, lr}
	ldr r1, _02167DBC // =0x02173908
	mov r4, r0
	str r1, [r4]
	bl ViShadow__Func_2167E9C
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167DBC: .word 0x02173908
	arm_func_end ViShadow__VTableFunc_2167DA0

	arm_func_start ViShadow__VTableFunc_2167DC0
ViShadow__VTableFunc_2167DC0: // 0x02167DC0
	stmdb sp!, {r4, lr}
	ldr r1, _02167DE4 // =0x02173908
	mov r4, r0
	str r1, [r4]
	bl ViShadow__Func_2167E9C
	mov r0, r4
	bl CPPHelpers__Free
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167DE4: .word 0x02173908
	arm_func_end ViShadow__VTableFunc_2167DC0

	arm_func_start ViShadow__LoadAssets
ViShadow__LoadAssets: // 0x02167DE8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r0
	bl ViShadow__Func_2167E9C
	ldr r0, _02167E98 // =aNarcViShadowLz
	mvn r1, #0
	bl BundleFileUnknown__LoadFile
	str r0, [r4, #4]
	mov r1, #0
	bl FileUnknown__GetAOUFileSize
	mov r8, r0
	ldr r0, [r4, #4]
	mov r1, #1
	bl FileUnknown__GetAOUFileSize
	mov r7, r0
	ldr r0, [r4, #4]
	mov r1, #0
	bl FileUnknown__GetAOUFile
	mov r6, r0
	ldr r0, [r4, #4]
	mov r1, #1
	bl FileUnknown__GetAOUFile
	mov r5, r0
	mov r0, r8
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r7, r7, lsr #1
	str r0, [r4, #8]
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	str r0, [r4, #0xc]
	ldr r3, [r4, #8]
	mov r1, r8
	mov r0, r6
	mov r2, #1
	bl QueueUncompressedPixels
	mov r1, r7, lsl #0x10
	ldr r3, [r4, #0xc]
	mov r0, r5
	mov r1, r1, lsr #0x10
	mov r2, #5
	bl QueueUncompressedPalette
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02167E98: .word aNarcViShadowLz
	arm_func_end ViShadow__LoadAssets

	arm_func_start ViShadow__Func_2167E9C
ViShadow__Func_2167E9C: // 0x02167E9C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02167EBC
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #4]
_02167EBC:
	ldr r0, [r4, #8]
	tst r0, #0x80000000
	beq _02167ED4
	bl VRAMSystem__FreeTexture
	mov r0, #0
	str r0, [r4, #8]
_02167ED4:
	ldr r0, [r4, #0xc]
	tst r0, #0x80000000
	beq _02167EEC
	bl VRAMSystem__FreePalette
	mov r0, #0
	str r0, [r4, #0xc]
_02167EEC:
	mov r0, #0x6000
	str r0, [r4, #0x10]
	mov r0, #0xf
	strh r0, [r4, #0x14]
	ldmia sp!, {r4, pc}
	arm_func_end ViShadow__Func_2167E9C

	arm_func_start ViShadow__Func_2167F00
ViShadow__Func_2167F00: // 0x02167F00
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x7c
	mov r4, r1
	mov r5, r0
	mov r3, #2
	add r1, sp, #0x18
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #0x18]
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r2, r1
	mov r0, #0x11
	bl NNS_G3dGeBufferOP_N
	ldr r1, [r5, #0x10]
	mov r0, #0x1000
	str r0, [sp, #0x20]
	str r1, [sp, #0x1c]
	ldr r1, [r5, #0x10]
	add r0, sp, #0x1c
	str r1, [sp, #0x24]
	bl NNS_G3dGlbSetBaseScale
	add r0, sp, #0x28
	bl MTX_Identity33_
	ldr r1, _0216809C // =0x021472FC
	add r0, sp, #0x28
	bl MI_Copy36B
	ldr r1, _021680A0 // =NNS_G3dGlb
	add r0, sp, #0x1c
	ldr r2, [r1, #0xfc]
	bic r2, r2, #0xa4
	str r2, [r1, #0xfc]
	ldr r2, [r4, #0]
	ldr r1, [r5, #0x10]
	sub r1, r2, r1, asr #1
	str r1, [sp, #0x1c]
	ldr r1, [r4, #4]
	add r1, r1, #0x400
	str r1, [sp, #0x20]
	ldr r2, [r4, #8]
	ldr r1, [r5, #0x10]
	sub r1, r2, r1, asr #1
	str r1, [sp, #0x24]
	bl NNS_G3dGlbSetBaseTrans
	bl NNS_G3dGlbFlushVP
	ldrh r2, [r5, #0x14]
	mov r0, #0x29
	add r1, sp, #0x14
	mov r2, r2, lsl #0x10
	orr r2, r2, #0xc0
	str r2, [sp, #0x14]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldr r2, [r5, #8]
	ldr r0, _021680A4 // =0x0007FFFF
	ldr r1, _021680A8 // =0x69B00000
	and r0, r2, r0
	orr r0, r1, r0, lsr #3
	str r0, [sp, #0x10]
	mov r0, #0x2a
	add r1, sp, #0x10
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldr r2, [r5, #0xc]
	ldr r1, _021680AC // =0x0001FFFF
	mov r0, #0x2b
	and r1, r2, r1
	mov r1, r1, lsr #3
	str r1, [sp, #0xc]
	add r1, sp, #0xc
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #3
	str r0, [sp, #8]
	mov r0, #0x10
	add r1, sp, #8
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, sp, #0x4c
	bl MTX_Identity43_
	mov r3, #0x40000
	add r1, sp, #0x4c
	mov r0, #0x17
	mov r2, #0xc
	str r3, [sp, #0x4c]
	str r3, [sp, #0x5c]
	bl NNS_G3dGeBufferOP_N
	ldr r3, _021680B0 // =0x00007FFF
	add r1, sp, #4
	mov r0, #0x20
	mov r2, #1
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	ldr r0, _021680B4 // =0x02173158
	mov r1, #0x38
	bl NNS_G3dGeSendDL
	mov r2, #1
	add r1, sp, #0
	mov r0, #0x12
	str r2, [sp]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x7c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216809C: .word 0x021472FC
_021680A0: .word NNS_G3dGlb
_021680A4: .word 0x0007FFFF
_021680A8: .word 0x69B00000
_021680AC: .word 0x0001FFFF
_021680B0: .word 0x00007FFF
_021680B4: .word 0x02173158
	arm_func_end ViShadow__Func_2167F00

	arm_func_start ViShadow__Func_21680B8
ViShadow__Func_21680B8: // 0x021680B8
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r5, r1
	mov r6, r0
	cmp r5, #4
	addls pc, pc, r5, lsl #2
	b _0216810C
_021680D4: // jump table
	b _021680E8 // case 0
	b _021680F8 // case 1
	b _02168100 // case 2
	b _02168108 // case 3
	b _021680F0 // case 4
_021680E8:
	mov r0, #1
	b _0216810C
_021680F0:
	mov r0, #0x10
	b _0216810C
_021680F8:
	mov r0, #2
	b _0216810C
_02168100:
	mov r0, #4
	b _0216810C
_02168108:
	mov r0, #8
_0216810C:
	ldr r1, [sp, #0x18]
	mov lr, #0
	cmp r1, #0
	mov ip, #1
	beq _0216814C
_02168120:
	tst r0, ip, lsl lr
	beq _0216813C
	add r1, r6, lr, lsl #1
	add r1, r1, #0x100
	ldrh r4, [r1, #0xc]
	orr r4, r4, #2
	strh r4, [r1, #0xc]
_0216813C:
	add lr, lr, #1
	cmp lr, #5
	blo _02168120
	b _02168174
_0216814C:
	tst r0, ip, lsl lr
	beq _02168168
	add r1, r6, lr, lsl #1
	add r1, r1, #0x100
	ldrh r4, [r1, #0xc]
	bic r4, r4, #2
	strh r4, [r1, #0xc]
_02168168:
	add lr, lr, #1
	cmp lr, #5
	blo _0216814C
_02168174:
	ldr r1, [sp, #0x1c]
	mov lr, #0
	cmp r1, #0
	mov ip, #1
	beq _021681B4
_02168188:
	tst r0, ip, lsl lr
	beq _021681A4
	add r1, r6, lr, lsl #1
	add r1, r1, #0x100
	ldrh r4, [r1, #0xc]
	orr r4, r4, #4
	strh r4, [r1, #0xc]
_021681A4:
	add lr, lr, #1
	cmp lr, #5
	blo _02168188
	b _021681DC
_021681B4:
	tst r0, ip, lsl lr
	beq _021681D0
	add r1, r6, lr, lsl #1
	add r1, r1, #0x100
	ldrh r4, [r1, #0xc]
	bic r4, r4, #4
	strh r4, [r1, #0xc]
_021681D0:
	add lr, lr, #1
	cmp lr, #5
	blo _021681B4
_021681DC:
	add r0, r6, r5, lsl #2
	ldr r0, [r0, #0xe4]
	mov r4, #0
	cmp r0, #0
	ldrne r4, [r0, #0]
	ldr ip, [sp, #0x24]
	mov r0, r6
	mov r1, r5
	str ip, [sp]
	bl AnimatorMDL__SetAnimation
	ldr r0, [sp, #0x20]
	cmp r0, #0
	addne r0, r6, r5, lsl #2
	ldrne r1, [r0, #0xe4]
	cmpne r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r1, #8]
	ldrh r0, [r0, #4]
	cmp r4, r0, lsl #12
	movgt r4, #0
	str r4, [r1]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end ViShadow__Func_21680B8
