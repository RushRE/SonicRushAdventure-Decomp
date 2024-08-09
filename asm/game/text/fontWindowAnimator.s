	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FontWindowAnimator__Init
FontWindowAnimator__Init: // 0x02059784
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl FontAnimatorCore__Init
	mov r1, #0
	add r0, r4, #0xc
	str r1, [r4, #8]
	bl FontAniHeader__Func_2054CF8
	mov r0, #3
	str r0, [r4, #0x44]
	mov r0, #7
	str r0, [r4, #0x54]
	ldmia sp!, {r4, pc}
	arm_func_end FontWindowAnimator__Init

	arm_func_start FontWindowAnimator__Load1
FontWindowAnimator__Load1: // 0x020597B4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x24
	mov r5, r0
	mov r7, r1
	mov r4, r2
	mov r6, r3
	bl FontWindowAnimator__Release
	mov r0, r5
	mov r1, r7
	bl FontAnimatorCore__LoadFont
	str r4, [r5, #8]
	mov r0, r7
	ldrb r4, [sp, #0x50]
	mov r1, r6
	ldrh r2, [sp, #0x38]
	bl FontWindow__GetFileFromArchive
	mov r1, r6
	mov r2, r0
	ldrsh ip, [sp, #0x3c]
	ldrsh r3, [sp, #0x40]
	ldrh r0, [sp, #0x44]
	str ip, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldrh ip, [sp, #0x48]
	ldr r3, [sp, #0x4c]
	ldrb r0, [sp, #0x54]
	str ip, [sp, #0xc]
	str r3, [sp, #0x10]
	str r4, [sp, #0x14]
	str r0, [sp, #0x18]
	ldrh ip, [sp, #0x58]
	ldrh r3, [sp, #0x5c]
	add r0, r5, #0xc
	str ip, [sp, #0x1c]
	str r3, [sp, #0x20]
	mov r3, #0
	bl FontAniHeader__Unknown__Func_2054D24
	mov r0, r5
	bl FontWindowAnimator__UpdateUnknownFlags
	mov r0, #0
	str r0, [r5, #0x44]
	ldr r0, [sp, #0x4c]
	str r0, [r5, #0x48]
	strh r4, [r5, #0x4c]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end FontWindowAnimator__Load1

	arm_func_start FontWindowAnimator__Load2
FontWindowAnimator__Load2: // 0x02059870
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x20
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl FontWindowAnimator__Release
	mov r0, r4
	mov r1, r7
	bl FontAnimatorCore__LoadFont
	str r6, [r4, #8]
	mov r0, r7
	mov r1, r5
	ldrh r2, [sp, #0x38]
	bl FontWindow__GetFileFromArchive
	mov r1, r5
	mov r2, r0
	ldrsh ip, [sp, #0x3c]
	ldrsh r3, [sp, #0x40]
	ldrh r0, [sp, #0x44]
	str ip, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldrh ip, [sp, #0x48]
	ldr r3, [sp, #0x4c]
	ldrb r0, [sp, #0x50]
	str ip, [sp, #0xc]
	str r3, [sp, #0x10]
	str r0, [sp, #0x14]
	ldrb ip, [sp, #0x54]
	ldrb r3, [sp, #0x58]
	add r0, r4, #0xc
	str ip, [sp, #0x18]
	str r3, [sp, #0x1c]
	mov r3, #0
	bl FontWindowAnimator__Unknown__Load2
	mov r0, r4
	bl FontWindowAnimator__UpdateUnknownFlags
	mov r0, #1
	str r0, [r4, #0x44]
	ldr r1, [sp, #0x4c]
	mov r0, #0x1000
	str r1, [r4, #0x48]
	strh r0, [r4, #0x4c]
	strh r0, [r4, #0x4e]
	mov r0, #0
	strh r0, [r4, #0x50]
	strh r0, [r4, #0x52]
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end FontWindowAnimator__Load2

	arm_func_start FontWindowAnimator__Release
FontWindowAnimator__Release: // 0x02059938
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x44]
	cmp r0, #0
	beq _02059958
	cmp r0, #1
	beq _02059964
	b _0205996C
_02059958:
	add r0, r4, #0xc
	bl FontAniHeader__Unknown__Release
	b _0205996C
_02059964:
	add r0, r4, #0xc
	bl FontAniHeader__Unknown__Release
_0205996C:
	mov r0, r4
	bl FontAnimatorCore__Release
	mov r0, r4
	bl FontWindowAnimator__Init
	ldmia sp!, {r4, pc}
	arm_func_end FontWindowAnimator__Release

	arm_func_start FontWindowAnimator__EnableFlags
FontWindowAnimator__EnableFlags: // 0x02059980
	ldr r2, [r0, #8]
	ldr ip, _02059994 // =FontWindowAnimator__UpdateUnknownFlags
	orr r1, r2, r1
	str r1, [r0, #8]
	bx ip
	.align 2, 0
_02059994: .word FontWindowAnimator__UpdateUnknownFlags
	arm_func_end FontWindowAnimator__EnableFlags

	arm_func_start FontWindowAnimator__DisableFlags
FontWindowAnimator__DisableFlags: // 0x02059998
	ldr r2, [r0, #8]
	mvn r1, r1
	and r1, r2, r1
	ldr ip, _020599B0 // =FontWindowAnimator__UpdateUnknownFlags
	str r1, [r0, #8]
	bx ip
	.align 2, 0
_020599B0: .word FontWindowAnimator__UpdateUnknownFlags
	arm_func_end FontWindowAnimator__DisableFlags

	arm_func_start FontWindowAnimator__Func_20599B4
FontWindowAnimator__Func_20599B4: // 0x020599B4
	ldr ip, _020599C0 // =FontWindowAnimator__Unknown__Func_2054F40
	add r0, r0, #0xc
	bx ip
	.align 2, 0
_020599C0: .word FontWindowAnimator__Unknown__Func_2054F40
	arm_func_end FontWindowAnimator__Func_20599B4

	arm_func_start FontWindowAnimator__Func_20599C4
FontWindowAnimator__Func_20599C4: // 0x020599C4
	ldr r1, [r0, #0x20]
	ldr ip, _020599E4 // =FontWindowAnimator__Unknown__Func_2054F40
	cmp r1, #0
	mov r1, #0
	streqh r1, [r0, #0x2e]
	strneh r1, [r0, #0x30]
	add r0, r0, #0xc
	bx ip
	.align 2, 0
_020599E4: .word FontWindowAnimator__Unknown__Func_2054F40
	arm_func_end FontWindowAnimator__Func_20599C4

	arm_func_start FontWindowAnimator__Draw
FontWindowAnimator__Draw: // 0x020599E8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #8]
	tst r0, #0x40
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x44]
	cmp r0, #0
	beq _02059A34
	cmp r0, #1
	bne _02059A34
	ldrsh r1, [r4, #0x52]
	add r0, r4, #0xc
	str r1, [sp]
	ldrsh r1, [r4, #0x4c]
	ldrsh r2, [r4, #0x4e]
	ldrsh r3, [r4, #0x50]
	bl FontWindowAnimator__Unknown__Func_205509C
_02059A34:
	add r0, r4, #0xc
	bl FontWindowAnimator__Unknown__Func_2054F64
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end FontWindowAnimator__Draw

	arm_func_start FontWindowAnimator__InitAnimation
FontWindowAnimator__InitAnimation: // 0x02059A44
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl FontWindowAnimator__SetWindowOpen
	str r7, [r4, #0x54]
	mov r0, #0
	str r0, [r4, #0x58]
	strh r6, [r4, #0x5c]
	strh r5, [r4, #0x5e]
	ldrh r1, [sp, #0x18]
	strh r0, [r4, #0x60]
	ldr r0, _02059A9C // =_021199C0
	strh r1, [r4, #0x62]
	ldr r2, [r4, #0x44]
	ldr r1, [r4, #0x54]
	ldr r2, [r0, r2, lsl #2]
	mov r0, r4
	ldr r1, [r2, r1, lsl #2]
	blx r1
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02059A9C: .word _021199C0
	arm_func_end FontWindowAnimator__InitAnimation

	arm_func_start FontWindowAnimator__StartAnimating
FontWindowAnimator__StartAnimating: // 0x02059AA0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	moveq r0, #1
	streq r0, [r4, #0x58]
	ldmia sp!, {r4, pc}
	arm_func_end FontWindowAnimator__StartAnimating

	arm_func_start FontWindowAnimator__ProcessWindowAnim
FontWindowAnimator__ProcessWindowAnim: // 0x02059ABC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r3, [r4, #0x44]
	ldr r2, _02059B14 // =_021199B8
	ldr r1, [r4, #0x54]
	ldr r2, [r2, r3, lsl #2]
	ldr r1, [r2, r1, lsl #2]
	blx r1
	mov r0, r4
	bl FontWindowAnimator__IsTimerPaused
	cmp r0, #0
	ldreqh r0, [r4, #0x60]
	addeq r0, r0, #1
	streqh r0, [r4, #0x60]
	ldrh r1, [r4, #0x5e]
	ldrh r0, [r4, #0x5c]
	ldrh r2, [r4, #0x60]
	add r0, r1, r0
	cmp r2, r0
	movgt r0, #0
	strgt r0, [r4, #0x58]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02059B14: .word _021199B8
	arm_func_end FontWindowAnimator__ProcessWindowAnim

	arm_func_start FontWindowAnimator__SetWindowOpen
FontWindowAnimator__SetWindowOpen: // 0x02059B18
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x54]
	cmp r0, #6
	ldmgeia sp!, {r4, pc}
	ldr r0, [r4, #4]
	bl FontWindow__Func_20582AC
	bl FontDMAControl__Func_2051C90
	mov r0, #7
	str r0, [r4, #0x54]
	ldmia sp!, {r4, pc}
	arm_func_end FontWindowAnimator__SetWindowOpen

	arm_func_start FontWindowAnimator__IsTimerPaused
FontWindowAnimator__IsTimerPaused: // 0x02059B44
	ldr r0, [r0, #0x58]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end FontWindowAnimator__IsTimerPaused

	arm_func_start FontWindowAnimator__IsFinishedAnimating
FontWindowAnimator__IsFinishedAnimating: // 0x02059B58
	ldrh r2, [r0, #0x5c]
	ldrh r1, [r0, #0x5e]
	ldrh r3, [r0, #0x60]
	add r0, r2, r1
	cmp r3, r0
	movgt r0, #1
	movle r0, #0
	bx lr
	arm_func_end FontWindowAnimator__IsFinishedAnimating

	arm_func_start FontWindowAnimator__SetWindowClosed
FontWindowAnimator__SetWindowClosed: // 0x02059B78
	ldr ip, _02059B84 // =FontWindowAnimator__Unknown__Func_2054FAC
	add r0, r0, #0xc
	bx ip
	.align 2, 0
_02059B84: .word FontWindowAnimator__Unknown__Func_2054FAC
	arm_func_end FontWindowAnimator__SetWindowClosed

	arm_func_start FontWindowAnimator__Func_2059B88
FontWindowAnimator__Func_2059B88: // 0x02059B88
	ldr ip, _02059B94 // =FontWindowAnimator__Unknown__Func_2055090
	add r0, r0, #0xc
	bx ip
	.align 2, 0
_02059B94: .word FontWindowAnimator__Unknown__Func_2055090
	arm_func_end FontWindowAnimator__Func_2059B88

	arm_func_start FontWindowAnimator__UpdateUnknownFlags
FontWindowAnimator__UpdateUnknownFlags: // 0x02059B98
	ldr r2, [r0, #8]
	mov r1, #0
	tst r2, #1
	orrne r1, r1, #1
	tst r2, #2
	orrne r1, r1, #2
	tst r2, #4
	orrne r1, r1, #4
	tst r2, #8
	orrne r1, r1, #8
	tst r2, #0x10
	orrne r1, r1, #0x10
	tst r2, #0x20
	orrne r1, r1, #0x20
	str r1, [r0, #0xc]
	bx lr
	arm_func_end FontWindowAnimator__UpdateUnknownFlags

	arm_func_start FontWindowAnimator__Func_2059BD8
FontWindowAnimator__Func_2059BD8: // 0x02059BD8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	ldr r0, [r5, #4]
	bl FontWindow__Func_20582AC
	ldrh r2, [r5, #0x4c]
	ldr r1, [r5, #0x48]
	mov r4, r0
	and r2, r2, #0xff
	bl FontDMAControl__Func_2051BE8
	ldr r1, [r5, #4]
	mov r0, r4
	ldrh r1, [r1, #0x94]
	and r1, r1, #0xff
	bl FontDMAControl__Func_2051BF4
	ldrsh r3, [r5, #0x12]
	ldrh r2, [r5, #0x16]
	mov r1, #0
	mov r0, r3, lsl #0x13
	add r2, r3, r2
	mov r2, r2, lsl #3
	sub r2, r2, #1
	mov r6, r0, asr #0x10
	mov r0, r2, lsl #0x10
	cmp r6, #0
	mov r7, r0, asr #0x10
	ble _02059C54
	mov r0, r4
	mov r3, r1
	and r2, r6, #0xff
	bl FontDMAControl__Func_2051D60
	mov r1, r6
_02059C54:
	cmp r7, r1
	ble _02059C74
	ldrsh r3, [r5, #0x62]
	mov r0, r4
	and r1, r1, #0xff
	and r2, r7, #0xff
	bl FontDMAControl__Func_2051EB4
	mov r1, r7
_02059C74:
	cmp r1, #0xbf
	ldmgeia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r4
	and r1, r1, #0xff
	mov r2, #0xbf
	mov r3, #0
	bl FontDMAControl__Func_2051D60
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end FontWindowAnimator__Func_2059BD8

	arm_func_start FontWindowAnimator__Func_2059C94
FontWindowAnimator__Func_2059C94: // 0x02059C94
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #4]
	bl FontWindow__Func_20582AC
	ldrh r2, [r5, #0x4c]
	ldr r1, [r5, #0x48]
	mov r4, r0
	and r2, r2, #0xff
	bl FontDMAControl__Func_2051BE8
	ldr r1, [r5, #4]
	mov r0, r4
	ldrh r1, [r1, #0x94]
	and r1, r1, #0xff
	bl FontDMAControl__Func_2051BF4
	mov r1, #0
	mov r0, r4
	mov r2, #0xbf
	mov r3, r1
	bl FontDMAControl__Func_2051D60
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end FontWindowAnimator__Func_2059C94

	arm_func_start FontWindowAnimator__Func_2059CE4
FontWindowAnimator__Func_2059CE4: // 0x02059CE4
	mov r1, #0x1000
	strh r1, [r0, #0x4c]
	mov r1, #0
	strh r1, [r0, #0x4e]
	strh r1, [r0, #0x50]
	strh r1, [r0, #0x52]
	bx lr
	arm_func_end FontWindowAnimator__Func_2059CE4

	arm_func_start FontWindowAnimator__Func_2059D00
FontWindowAnimator__Func_2059D00: // 0x02059D00
	mov r1, #0x1000
	strh r1, [r0, #0x4c]
	mov r1, #0
	strh r1, [r0, #0x4e]
	strh r1, [r0, #0x50]
	ldrh r1, [r0, #0x16]
	mov r1, r1, lsl #2
	strh r1, [r0, #0x52]
	bx lr
	arm_func_end FontWindowAnimator__Func_2059D00

	arm_func_start FontWindowAnimator__Func_2059D24
FontWindowAnimator__Func_2059D24: // 0x02059D24
	mov r1, #0x1000
	strh r1, [r0, #0x4c]
	mov r1, #0
	strh r1, [r0, #0x4e]
	strh r1, [r0, #0x50]
	ldrh r1, [r0, #0x16]
	mov r1, r1, lsl #3
	strh r1, [r0, #0x52]
	bx lr
	arm_func_end FontWindowAnimator__Func_2059D24

	arm_func_start FontWindowAnimator__Func_2059D48
FontWindowAnimator__Func_2059D48: // 0x02059D48
	mov r1, #0x1000
	strh r1, [r0, #0x4c]
	strh r1, [r0, #0x4e]
	mov r1, #0
	strh r1, [r0, #0x50]
	strh r1, [r0, #0x52]
	bx lr
	arm_func_end FontWindowAnimator__Func_2059D48

	arm_func_start FontWindowAnimator__Func_2059D64
FontWindowAnimator__Func_2059D64: // 0x02059D64
	mov r1, #0x1000
	strh r1, [r0, #0x4c]
	strh r1, [r0, #0x4e]
	mov r1, #0
	strh r1, [r0, #0x50]
	ldrh r1, [r0, #0x16]
	mov r1, r1, lsl #2
	strh r1, [r0, #0x52]
	bx lr
	arm_func_end FontWindowAnimator__Func_2059D64

	arm_func_start FontWindowAnimator__Func_2059D88
FontWindowAnimator__Func_2059D88: // 0x02059D88
	mov r1, #0x1000
	strh r1, [r0, #0x4c]
	strh r1, [r0, #0x4e]
	mov r1, #0
	strh r1, [r0, #0x50]
	ldrh r1, [r0, #0x16]
	mov r1, r1, lsl #3
	strh r1, [r0, #0x52]
	bx lr
	arm_func_end FontWindowAnimator__Func_2059D88

	arm_func_start FontWindowAnimator__Func_2059DAC
FontWindowAnimator__Func_2059DAC: // 0x02059DAC
	ldrh r3, [r0, #0x60]
	ldrh r1, [r0, #0x5e]
	ldrh r2, [r0, #0x5c]
	ldr ip, _02059DD4 // =FontWindowAnimator__Func_2059EC0
	subs r1, r3, r1
	movmi r1, #0
	cmp r1, r2
	movgt r1, r2
	mov r3, #0
	bx ip
	.align 2, 0
_02059DD4: .word FontWindowAnimator__Func_2059EC0
	arm_func_end FontWindowAnimator__Func_2059DAC

	arm_func_start FontWindowAnimator__Func_2059DD8
FontWindowAnimator__Func_2059DD8: // 0x02059DD8
	ldrh r3, [r0, #0x60]
	ldrh r1, [r0, #0x5e]
	ldrh r2, [r0, #0x5c]
	ldr ip, _02059E00 // =FontWindowAnimator__Func_2059FE0
	subs r1, r3, r1
	movmi r1, #0
	cmp r1, r2
	movgt r1, r2
	mov r3, #0
	bx ip
	.align 2, 0
_02059E00: .word FontWindowAnimator__Func_2059FE0
	arm_func_end FontWindowAnimator__Func_2059DD8

	arm_func_start FontWindowAnimator__Func_2059E04
FontWindowAnimator__Func_2059E04: // 0x02059E04
	ldrh r3, [r0, #0x60]
	ldrh r1, [r0, #0x5e]
	ldrh r2, [r0, #0x5c]
	ldr ip, _02059E2C // =FontWindowAnimator__Func_205A180
	subs r1, r3, r1
	movmi r1, #0
	cmp r1, r2
	movgt r1, r2
	mov r3, #0
	bx ip
	.align 2, 0
_02059E2C: .word FontWindowAnimator__Func_205A180
	arm_func_end FontWindowAnimator__Func_2059E04

	arm_func_start FontWindowAnimator__Func_2059E30
FontWindowAnimator__Func_2059E30: // 0x02059E30
	ldrh r3, [r0, #0x60]
	ldrh r1, [r0, #0x5e]
	ldrh r2, [r0, #0x5c]
	ldr ip, _02059E5C // =FontWindowAnimator__Func_2059EC0
	subs r1, r3, r1
	movmi r1, #0
	cmp r1, r2
	movgt r1, r2
	sub r1, r2, r1
	mov r3, #0
	bx ip
	.align 2, 0
_02059E5C: .word FontWindowAnimator__Func_2059EC0
	arm_func_end FontWindowAnimator__Func_2059E30

	arm_func_start FontWindowAnimator__Func_2059E60
FontWindowAnimator__Func_2059E60: // 0x02059E60
	ldrh r3, [r0, #0x60]
	ldrh r1, [r0, #0x5e]
	ldrh r2, [r0, #0x5c]
	ldr ip, _02059E8C // =FontWindowAnimator__Func_2059FE0
	subs r1, r3, r1
	movmi r1, #0
	cmp r1, r2
	movgt r1, r2
	sub r1, r2, r1
	mov r3, #0
	bx ip
	.align 2, 0
_02059E8C: .word FontWindowAnimator__Func_2059FE0
	arm_func_end FontWindowAnimator__Func_2059E60

	arm_func_start FontWindowAnimator__Func_2059E90
FontWindowAnimator__Func_2059E90: // 0x02059E90
	ldrh r3, [r0, #0x60]
	ldrh r1, [r0, #0x5e]
	ldrh r2, [r0, #0x5c]
	ldr ip, _02059EBC // =FontWindowAnimator__Func_205A180
	subs r1, r3, r1
	movmi r1, #0
	cmp r1, r2
	movgt r1, r2
	sub r1, r2, r1
	mov r3, #0
	bx ip
	.align 2, 0
_02059EBC: .word FontWindowAnimator__Func_205A180
	arm_func_end FontWindowAnimator__Func_2059E90

	arm_func_start FontWindowAnimator__Func_2059EC0
FontWindowAnimator__Func_2059EC0: // 0x02059EC0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	mov sl, r0
	ldr r0, [sl, #4]
	mov r4, r1
	mov r6, r2
	mov sb, r3
	bl FontWindow__Func_20582AC
	ldrh r2, [sl, #0x16]
	mov r5, r0
	mov r1, r6
	mov r0, r2, lsl #3
	sub fp, r0, #1
	mul r0, fp, r4
	mov r0, r0, lsl #0xc
	bl FX_DivS32
	ldrh r1, [sl, #0x16]
	ldrsh r2, [sl, #0x12]
	mov r4, r0
	mov r0, r1, lsl #3
	mov r6, r2, lsl #3
	sub r0, r0, #1
	cmp r6, #0
	add r7, r6, r4, asr #12
	add r8, r0, r2, lsl #3
	mov r1, #0
	ble _02059F3C
	mov r0, r5
	mov r3, r1
	and r2, r6, #0xff
	bl FontDMAControl__Func_2051D60
	mov r1, r6
_02059F3C:
	cmp r7, r1
	ble _02059FA0
	cmp sb, #0
	beq _02059F58
	cmp sb, #1
	beq _02059F80
	b _02059F9C
_02059F58:
	mov r0, r8, lsl #0x10
	mov r3, r6, lsl #0x10
	mov r4, r0, asr #0x10
	mov r0, r5
	and r1, r1, #0xff
	and r2, r7, #0xff
	mov r3, r3, asr #0x10
	str r4, [sp]
	bl FontDMAControl__Func_2051DF0
	b _02059F9C
_02059F80:
	sub r0, fp, r4, asr #12
	mov r3, r0, lsl #0x10
	mov r0, r5
	and r1, r1, #0xff
	and r2, r7, #0xff
	mov r3, r3, lsr #0x10
	bl FontDMAControl__Func_2051D60
_02059F9C:
	mov r1, r7
_02059FA0:
	cmp r8, r1
	ble _02059FC0
	ldrsh r3, [sl, #0x62]
	mov r0, r5
	and r1, r1, #0xff
	and r2, r8, #0xff
	bl FontDMAControl__Func_2051EB4
	mov r1, r8
_02059FC0:
	cmp r1, #0xbf
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, r5
	and r1, r1, #0xff
	mov r2, #0xbf
	mov r3, #0
	bl FontDMAControl__Func_2051D60
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end FontWindowAnimator__Func_2059EC0

	arm_func_start FontWindowAnimator__Func_2059FE0
FontWindowAnimator__Func_2059FE0: // 0x02059FE0
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0xc
	mov sl, r0
	ldr r0, [sl, #4]
	mov r6, r1
	mov r5, r2
	str r3, [sp, #4]
	bl FontWindow__Func_20582AC
	ldrh r2, [sl, #0x16]
	mov r4, r0
	mov r1, r5
	mov r0, r2, lsl #3
	sub r0, r0, #1
	mul r2, r0, r6
	str r0, [sp, #8]
	mov r0, r2, lsl #0xc
	bl FX_DivS32
	ldrsh r2, [sl, #0x12]
	mov r3, r0, asr #0xc
	ldrh r1, [sl, #0x16]
	mov r5, r2, lsl #3
	cmp r5, #0
	add r7, r5, r1, lsl #2
	mov r0, r1, lsl #3
	sub r0, r0, #1
	add sb, r0, r2, lsl #3
	mov fp, r3, asr #1
	sub r6, r7, r3, asr #1
	add r8, r7, r3, asr #1
	mov r1, #0
	ble _0205A070
	mov r0, r4
	mov r3, r1
	and r2, r5, #0xff
	bl FontDMAControl__Func_2051D60
	mov r1, r5
_0205A070:
	cmp r6, r1
	ble _0205A090
	ldrsh r3, [sl, #0x62]
	mov r0, r4
	and r1, r1, #0xff
	and r2, r6, #0xff
	bl FontDMAControl__Func_2051EB4
	mov r1, r6
_0205A090:
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _0205A0A8
	cmp r0, #1
	beq _0205A0DC
	b _0205A138
_0205A0A8:
	cmp r8, r1
	ble _0205A138
	mov r0, sb, lsl #0x10
	mov r3, r5, lsl #0x10
	mov r5, r0, asr #0x10
	mov r0, r4
	and r1, r1, #0xff
	and r2, r8, #0xff
	mov r3, r3, asr #0x10
	str r5, [sp]
	bl FontDMAControl__Func_2051DF0
	mov r1, r8
	b _0205A138
_0205A0DC:
	cmp r7, r1
	ble _0205A10C
	ldr r0, [sp, #8]
	and r1, r1, #0xff
	rsb r0, fp, r0, asr #1
	rsb r0, r0, #0
	mov r3, r0, lsl #0x10
	mov r0, r4
	and r2, r7, #0xff
	mov r3, r3, lsr #0x10
	bl FontDMAControl__Func_2051D60
	mov r1, r7
_0205A10C:
	cmp r8, r1
	ble _0205A138
	ldr r0, [sp, #8]
	and r1, r1, #0xff
	rsb r0, fp, r0, asr #1
	mov r3, r0, lsl #0x10
	mov r0, r4
	and r2, r8, #0xff
	mov r3, r3, lsr #0x10
	bl FontDMAControl__Func_2051D60
	mov r1, r8
_0205A138:
	cmp sb, r1
	ble _0205A158
	ldrsh r3, [sl, #0x62]
	mov r0, r4
	and r1, r1, #0xff
	and r2, sb, #0xff
	bl FontDMAControl__Func_2051EB4
	mov r1, sb
_0205A158:
	cmp r1, #0xbf
	addge sp, sp, #0xc
	ldmgeia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, r4
	and r1, r1, #0xff
	mov r2, #0xbf
	mov r3, #0
	bl FontDMAControl__Func_2051D60
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end FontWindowAnimator__Func_2059FE0

	arm_func_start FontWindowAnimator__Func_205A180
FontWindowAnimator__Func_205A180: // 0x0205A180
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	mov sl, r0
	ldr r0, [sl, #4]
	mov r4, r1
	mov r6, r2
	mov sb, r3
	bl FontWindow__Func_20582AC
	ldrh r2, [sl, #0x16]
	mov r5, r0
	mov r1, r6
	mov r0, r2, lsl #3
	sub fp, r0, #1
	mul r0, fp, r4
	mov r0, r0, lsl #0xc
	bl FX_DivS32
	ldrh r1, [sl, #0x16]
	ldrsh r2, [sl, #0x12]
	mov r4, r0
	mov r0, r1, lsl #3
	sub r0, r0, #1
	mov r6, r2, lsl #3
	add r8, r0, r2, lsl #3
	cmp r6, #0
	sub r7, r8, r4, asr #12
	mov r1, #0
	ble _0205A1FC
	mov r0, r5
	mov r3, r1
	and r2, r6, #0xff
	bl FontDMAControl__Func_2051D60
	mov r1, r6
_0205A1FC:
	cmp r7, r1
	ble _0205A21C
	ldrsh r3, [sl, #0x62]
	mov r0, r5
	and r1, r1, #0xff
	and r2, r7, #0xff
	bl FontDMAControl__Func_2051EB4
	mov r1, r7
_0205A21C:
	cmp r8, r1
	ble _0205A284
	cmp sb, #0
	beq _0205A238
	cmp sb, #1
	beq _0205A260
	b _0205A280
_0205A238:
	mov r0, r8, lsl #0x10
	mov r3, r6, lsl #0x10
	mov r4, r0, asr #0x10
	mov r0, r5
	and r1, r1, #0xff
	and r2, r8, #0xff
	mov r3, r3, asr #0x10
	str r4, [sp]
	bl FontDMAControl__Func_2051DF0
	b _0205A280
_0205A260:
	sub r0, fp, r4, asr #12
	rsb r0, r0, #0
	mov r3, r0, lsl #0x10
	mov r0, r5
	and r1, r1, #0xff
	and r2, r8, #0xff
	mov r3, r3, lsr #0x10
	bl FontDMAControl__Func_2051D60
_0205A280:
	mov r1, r8
_0205A284:
	cmp r1, #0xbf
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, r5
	and r1, r1, #0xff
	mov r2, #0xbf
	mov r3, #0
	bl FontDMAControl__Func_2051D60
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end FontWindowAnimator__Func_205A180

	arm_func_start FontWindowAnimator__Func_205A2A4
FontWindowAnimator__Func_205A2A4: // 0x0205A2A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r2, [r4, #0x60]
	ldrh r0, [r4, #0x5e]
	ldrh r1, [r4, #0x5c]
	subs r0, r2, r0
	movmi r0, #0
	cmp r0, r1
	movgt r0, r1
	bl FX_Div
	strh r0, [r4, #0x4e]
	ldmia sp!, {r4, pc}
	arm_func_end FontWindowAnimator__Func_205A2A4

	arm_func_start FontWindowAnimator__Func_205A2D4
FontWindowAnimator__Func_205A2D4: // 0x0205A2D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r2, [r4, #0x60]
	ldrh r0, [r4, #0x5e]
	ldrh r1, [r4, #0x5c]
	subs r0, r2, r0
	movmi r0, #0
	cmp r0, r1
	movgt r0, r1
	sub r0, r1, r0
	bl FX_Div
	strh r0, [r4, #0x4e]
	ldmia sp!, {r4, pc}
	arm_func_end FontWindowAnimator__Func_205A2D4

	.data

_021199B8: // 0x021199B8
	.word _021104E8, _021104A0
	
_021199C0: // 0x021199C0
	.word _021104D0, _021104B8

    .rodata

_021104A0: // 0x021104A0
    .word FontWindowAnimator__Func_205A2A4
	.word FontWindowAnimator__Func_205A2A4
	.word FontWindowAnimator__Func_205A2A4
	.word FontWindowAnimator__Func_205A2D4
	.word FontWindowAnimator__Func_205A2D4
	.word FontWindowAnimator__Func_205A2D4

_021104B8: // 0x021104B8
    .word FontWindowAnimator__Func_2059CE4
	.word FontWindowAnimator__Func_2059D00
	.word FontWindowAnimator__Func_2059D24
	.word FontWindowAnimator__Func_2059D48
	.word FontWindowAnimator__Func_2059D64
	.word FontWindowAnimator__Func_2059D88

_021104D0: // 0x021104D0
    .word FontWindowAnimator__Func_2059BD8
	.word FontWindowAnimator__Func_2059BD8
	.word FontWindowAnimator__Func_2059BD8
	.word FontWindowAnimator__Func_2059C94
	.word FontWindowAnimator__Func_2059C94
	.word FontWindowAnimator__Func_2059C94

_021104E8: // 0x021104E8
    .word FontWindowAnimator__Func_2059DAC
	.word FontWindowAnimator__Func_2059DD8
	.word FontWindowAnimator__Func_2059E04
	.word FontWindowAnimator__Func_2059E30
	.word FontWindowAnimator__Func_2059E60
	.word FontWindowAnimator__Func_2059E90
