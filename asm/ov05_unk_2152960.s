	.include "asm/macros.inc"
	.include "global.inc"

	.bss

DockHelpers__SndHandle: // 0x02173A40
	.space 0x04

	.text

	arm_func_start ovl05_2152960
ovl05_2152960: // 0x02152960
	ldr r1, _0215296C // =0x02171FE8
	add r0, r1, r0, lsl #6
	bx lr
	.align 2, 0
_0215296C: .word 0x02171FE8
	arm_func_end ovl05_2152960

	arm_func_start ovl05_2152970
ovl05_2152970: // 0x02152970
	ldr r2, _02152980 // =0x02171E0C
	mov r1, #0x44
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_02152980: .word 0x02171E0C
	arm_func_end ovl05_2152970

	arm_func_start ovl05_2152984
ovl05_2152984: // 0x02152984
	ldr r1, _02152990 // =0x02171914
	add r0, r1, r0, lsl #3
	bx lr
	.align 2, 0
_02152990: .word 0x02171914
	arm_func_end ovl05_2152984

	arm_func_start ovl05_2152994
ovl05_2152994: // 0x02152994
	ldr r2, _021529A4 // =0x02171A1C
	mov r1, #0x28
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_021529A4: .word 0x02171A1C
	arm_func_end ovl05_2152994

	arm_func_start ovl05_21529A8
ovl05_21529A8: // 0x021529A8
	ldr r2, _021529B8 // =0x02171CCC
	mov r1, #0x28
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_021529B8: .word 0x02171CCC
	arm_func_end ovl05_21529A8

	arm_func_start ovl05_21529BC
ovl05_21529BC: // 0x021529BC
	ldr r1, _021529C8 // =0x0217194C
	add r0, r1, r0, lsl #4
	bx lr
	.align 2, 0
_021529C8: .word 0x0217194C
	arm_func_end ovl05_21529BC

	arm_func_start ovl05_21529CC
ovl05_21529CC: // 0x021529CC
	ldr r0, _021529D4 // =0x02171838
	bx lr
	.align 2, 0
_021529D4: .word 0x02171838
	arm_func_end ovl05_21529CC

	arm_func_start ovl05_21529D8
ovl05_21529D8: // 0x021529D8
	ldr r1, _021529E4 // =0x021718B0
	add r0, r1, r0, lsl #4
	bx lr
	.align 2, 0
_021529E4: .word 0x021718B0
	arm_func_end ovl05_21529D8

	arm_func_start ovl05_21529E8
ovl05_21529E8: // 0x021529E8
	ldr r1, _021529F4 // =0x0217199C
	add r0, r1, r0, lsl #4
	bx lr
	.align 2, 0
_021529F4: .word 0x0217199C
	arm_func_end ovl05_21529E8

	arm_func_start ovl05_21529F8
ovl05_21529F8: // 0x021529F8
	ldr r2, _02152A08 // =0x02171AE4
	mov r1, #0x1c
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_02152A08: .word 0x02171AE4
	arm_func_end ovl05_21529F8

	arm_func_start ovl05_2152A0C
ovl05_2152A0C: // 0x02152A0C
	ldr r2, _02152A1C // =0x02171BC4
	mov r1, #0xc
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_02152A1C: .word 0x02171BC4
	arm_func_end ovl05_2152A0C

	arm_func_start ovl05_2152A20
ovl05_2152A20: // 0x02152A20
	ldr r1, _02152A2C // =0x02171882
	add r0, r1, r0, lsl #1
	bx lr
	.align 2, 0
_02152A2C: .word 0x02171882
	arm_func_end ovl05_2152A20

	arm_func_start ovl05_2152A30
ovl05_2152A30: // 0x02152A30
	ldr r1, _02152A3C // =0x02171848
	add r0, r1, r0, lsl #1
	bx lr
	.align 2, 0
_02152A3C: .word 0x02171848
	arm_func_end ovl05_2152A30

	arm_func_start ovl05_2152A40
ovl05_2152A40: // 0x02152A40
	ldr r1, _02152A4C // =0x02171864
	add r0, r1, r0, lsl #1
	bx lr
	.align 2, 0
_02152A4C: .word 0x02171864
	arm_func_end ovl05_2152A40

	arm_func_start ovl05_2152A50
ovl05_2152A50: // 0x02152A50
	ldr r1, _02152A5C // =0x021718E0
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152A5C: .word 0x021718E0
	arm_func_end ovl05_2152A50

	arm_func_start ovl05_2152A60
ovl05_2152A60: // 0x02152A60
	cmp r0, #6
	movls r0, #1
	movhi r0, #0
	bx lr
	arm_func_end ovl05_2152A60

	arm_func_start ovl05_2152A70
ovl05_2152A70: // 0x02152A70
	ldr r0, _02152A78 // =0x02171834
	bx lr
	.align 2, 0
_02152A78: .word 0x02171834
	arm_func_end ovl05_2152A70

	arm_func_start ovl05_2152A7C
ovl05_2152A7C: // 0x02152A7C
	ldr r0, _02152A84 // =0x02171834
	bx lr
	.align 2, 0
_02152A84: .word 0x02171834
	arm_func_end ovl05_2152A7C

	arm_func_start ovl05_2152A88
ovl05_2152A88: // 0x02152A88
	ldr r0, _02152A90 // =0x02171834
	bx lr
	.align 2, 0
_02152A90: .word 0x02171834
	arm_func_end ovl05_2152A88

	arm_func_start ovl05_2152A94
ovl05_2152A94: // 0x02152A94
	ldr r0, _02152A9C // =0x02171834
	bx lr
	.align 2, 0
_02152A9C: .word 0x02171834
	arm_func_end ovl05_2152A94

	arm_func_start ovl05_2152AA0
ovl05_2152AA0: // 0x02152AA0
	ldr r0, _02152AA8 // =0x02171834
	bx lr
	.align 2, 0
_02152AA8: .word 0x02171834
	arm_func_end ovl05_2152AA0

	arm_func_start ovl05_2152AAC
ovl05_2152AAC: // 0x02152AAC
	ldr r0, _02152AB4 // =0x02171834
	bx lr
	.align 2, 0
_02152AB4: .word 0x02171834
	arm_func_end ovl05_2152AAC

	arm_func_start ovl05_2152AB8
ovl05_2152AB8: // 0x02152AB8
	ldr r0, _02152AC0 // =0x02171834
	bx lr
	.align 2, 0
_02152AC0: .word 0x02171834
	arm_func_end ovl05_2152AB8

	arm_func_start ovl05_2152AC4
ovl05_2152AC4: // 0x02152AC4
	ldr r0, _02152ACC // =0x02171834
	bx lr
	.align 2, 0
_02152ACC: .word 0x02171834
	arm_func_end ovl05_2152AC4

	arm_func_start ovl05_2152AD0
ovl05_2152AD0: // 0x02152AD0
	ldr r0, _02152AD8 // =0x02171834
	bx lr
	.align 2, 0
_02152AD8: .word 0x02171834
	arm_func_end ovl05_2152AD0

	arm_func_start ovl05_2152ADC
ovl05_2152ADC: // 0x02152ADC
	ldr r0, _02152AE4 // =0x02171834
	bx lr
	.align 2, 0
_02152AE4: .word 0x02171834
	arm_func_end ovl05_2152ADC

	arm_func_start ovl05_2152AE8
ovl05_2152AE8: // 0x02152AE8
	ldr r0, _02152AF0 // =0x02171834
	bx lr
	.align 2, 0
_02152AF0: .word 0x02171834
	arm_func_end ovl05_2152AE8

	arm_func_start ovl05_2152AF4
ovl05_2152AF4: // 0x02152AF4
	ldr r0, _02152AFC // =0x0217182C
	bx lr
	.align 2, 0
_02152AFC: .word 0x0217182C
	arm_func_end ovl05_2152AF4

	arm_func_start ovl05_2152B00
ovl05_2152B00: // 0x02152B00
	ldr r0, _02152B08 // =0x02171830
	bx lr
	.align 2, 0
_02152B08: .word 0x02171830
	arm_func_end ovl05_2152B00

	arm_func_start ovl05_2152B0C
ovl05_2152B0C: // 0x02152B0C
	ldr r1, _02152B18 // =0x021722E0
	add r0, r1, r0, lsl #3
	bx lr
	.align 2, 0
_02152B18: .word 0x021722E0
	arm_func_end ovl05_2152B0C

	arm_func_start ovl05_2152B1C
ovl05_2152B1C: // 0x02152B1C
	ldr r1, _02152B28 // =0x02172218
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152B28: .word 0x02172218
	arm_func_end ovl05_2152B1C

	arm_func_start ovl05_2152B2C
ovl05_2152B2C: // 0x02152B2C
	ldr r0, _02152B34 // =0x021721EC
	bx lr
	.align 2, 0
_02152B34: .word 0x021721EC
	arm_func_end ovl05_2152B2C

	arm_func_start ovl05_2152B38
ovl05_2152B38: // 0x02152B38
	ldr r1, _02152B44 // =0x021721FC
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152B44: .word 0x021721FC
	arm_func_end ovl05_2152B38

	arm_func_start ovl05_2152B48
ovl05_2152B48: // 0x02152B48
	ldr r1, _02152B54 // =0x0217222C
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152B54: .word 0x0217222C
	arm_func_end ovl05_2152B48

	arm_func_start ovl05_2152B58
ovl05_2152B58: // 0x02152B58
	ldr r0, _02152B60 // =0x021721E8
	bx lr
	.align 2, 0
_02152B60: .word 0x021721E8
	arm_func_end ovl05_2152B58

	arm_func_start ovl05_2152B64
ovl05_2152B64: // 0x02152B64
	ldr r1, _02152B70 // =0x0217224C
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152B70: .word 0x0217224C
	arm_func_end ovl05_2152B64

	arm_func_start ovl05_2152B74
ovl05_2152B74: // 0x02152B74
	ldr r0, _02152B7C // =0x02172208
	bx lr
	.align 2, 0
_02152B7C: .word 0x02172208
	arm_func_end ovl05_2152B74

	arm_func_start ovl05_2152B80
ovl05_2152B80: // 0x02152B80
	ldr r2, _02152B94 // =0x0000FFFF
	str r1, [r0]
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	bx lr
	.align 2, 0
_02152B94: .word 0x0000FFFF
	arm_func_end ovl05_2152B80

	arm_func_start ovl05_2152B98
ovl05_2152B98: // 0x02152B98
	ldr r0, [r0]
	ldrh r0, [r0, #4]
	bx lr
	arm_func_end ovl05_2152B98

	arm_func_start ovl05_2152BA4
ovl05_2152BA4: // 0x02152BA4
	ldr r2, _02152BB4 // =0x0000FFFF
	strh r1, [r0, #4]
	strh r2, [r0, #6]
	bx lr
	.align 2, 0
_02152BB4: .word 0x0000FFFF
	arm_func_end ovl05_2152BA4

	arm_func_start ovl05_2152BB8
ovl05_2152BB8: // 0x02152BB8
	ldr r2, [r0]
	ldrh r0, [r0, #4]
	ldr r1, [r2, #0xc]
	mov r3, #0
	add r1, r2, r1
	add r2, r1, r0, lsl #3
	ldr r0, _02152BFC // =0x0000FFFF
_02152BD4:
	mov r1, r3, lsl #1
	ldrh r1, [r2, r1]
	cmp r1, r0
	beq _02152BF0
	add r3, r3, #1
	cmp r3, #4
	blt _02152BD4
_02152BF0:
	mov r0, r3, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
	.align 2, 0
_02152BFC: .word 0x0000FFFF
	arm_func_end ovl05_2152BB8

	arm_func_start ovl05_2152C00
ovl05_2152C00: // 0x02152C00
	stmdb sp!, {r3, lr}
	ldr lr, [r0]
	ldrh r3, [r0, #4]
	ldr ip, [lr, #0xc]
	mov r2, r1, lsl #1
	add r1, lr, ip
	add r1, r1, r3, lsl #3
	ldrh r1, [r2, r1]
	strh r1, [r0, #6]
	ldmia sp!, {r3, pc}
	arm_func_end ovl05_2152C00

	arm_func_start ovl05_2152C28
ovl05_2152C28: // 0x02152C28
	ldr ip, [r0]
	ldrh r1, [r0, #6]
	ldr r3, [ip, #0x10]
	ldr r0, _02152C54 // =0x0000FFFF
	mov r2, r1, lsl #4
	add r1, ip, r3
	ldrh r1, [r2, r1]
	cmp r1, r0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02152C54: .word 0x0000FFFF
	arm_func_end ovl05_2152C28

	arm_func_start ovl05_2152C58
ovl05_2152C58: // 0x02152C58
	ldr r3, [r0]
	ldrh r0, [r0, #6]
	ldr r2, [r3, #0x10]
	mov r1, r0, lsl #4
	add r0, r3, r2
	ldrh r0, [r1, r0]
	bx lr
	arm_func_end ovl05_2152C58

	arm_func_start ovl05_2152C74
ovl05_2152C74: // 0x02152C74
	ldr r2, [r0]
	ldrh r1, [r0, #6]
	ldr r0, [r2, #0x10]
	add r0, r2, r0
	add r0, r0, r1, lsl #4
	ldrh r0, [r0, #2]
	bx lr
	arm_func_end ovl05_2152C74

	arm_func_start ovl05_2152C90
ovl05_2152C90: // 0x02152C90
	ldr r3, [r0]
	ldrh r2, [r0, #6]
	ldr r1, [r3, #0x10]
	ldr r0, _02152CBC // =0x0000FFFF
	add r1, r3, r1
	add r1, r1, r2, lsl #4
	ldrh r1, [r1, #4]
	cmp r1, r0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02152CBC: .word 0x0000FFFF
	arm_func_end ovl05_2152C90

	arm_func_start ovl05_2152CC0
ovl05_2152CC0: // 0x02152CC0
	ldr r2, [r0]
	ldrh r1, [r0, #6]
	ldr r0, [r2, #0x10]
	add r0, r2, r0
	add r0, r0, r1, lsl #4
	ldrh r0, [r0, #4]
	bx lr
	arm_func_end ovl05_2152CC0

	arm_func_start ovl05_2152CDC
ovl05_2152CDC: // 0x02152CDC
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr ip, [r5]
	ldrh r2, [r5, #6]
	ldr r3, [ip, #0x10]
	mov r4, r1
	add r1, ip, r3
	add r1, r1, r2, lsl #4
	add r6, r1, #8
	bl ovl05_2152C90
	cmp r0, #0
	ldreqh r0, [r6]
	movne r0, r4, lsl #1
	ldrneh r0, [r6, r0]
	strh r0, [r5, #6]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl05_2152CDC

	arm_func_start ovl05_2152D1C
ovl05_2152D1C: // 0x02152D1C
	ldrh r1, [r0, #6]
	ldr r0, _02152D40 // =0x0000FFFF
	cmp r1, r0
	moveq r0, #0
	bxeq lr
	cmp r1, #0x8000
	movhs r0, #1
	movlo r0, #0
	bx lr
	.align 2, 0
_02152D40: .word 0x0000FFFF
	arm_func_end ovl05_2152D1C

	arm_func_start ovl05_2152D44
ovl05_2152D44: // 0x02152D44
	ldrh r1, [r0, #6]
	ldr r3, [r0]
	sub r0, r1, #0x8000
	ldr r2, [r3, #0x14]
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0xe
	add r0, r3, r2
	ldrh r0, [r1, r0]
	bx lr
	arm_func_end ovl05_2152D44

	arm_func_start ovl05_2152D68
ovl05_2152D68: // 0x02152D68
	ldr r2, [r0]
	ldrh r0, [r0, #6]
	ldr r1, [r2, #0x14]
	sub r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	add r1, r2, r1
	add r0, r1, r0, lsr #14
	ldrh r0, [r0, #2]
	bx lr
	arm_func_end ovl05_2152D68

	arm_func_start ovl05_2152D8C
ovl05_2152D8C: // 0x02152D8C
	ldrh r0, [r0, #6]
	cmp r0, #0x8000
	movhs r0, #1
	movlo r0, #0
	bx lr
	arm_func_end ovl05_2152D8C

	arm_func_start ovl05_2152DA0
ovl05_2152DA0: // 0x02152DA0
	stmdb sp!, {r4, lr}
	ldr r4, _02152DD0 // =0x02139530
	mov r0, #0
	mov r1, r4
	mov r2, #0x64
	bl MIi_CpuClear32
	mov r0, #0xff
	mov r1, #0
	strb r1, [r4]
	strb r0, [r4, #1]
	strb r0, [r4, #2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02152DD0: .word 0x02139530
	arm_func_end ovl05_2152DA0

	arm_func_start ovl05_2152DD4
ovl05_2152DD4: // 0x02152DD4
	ldr r1, _02152DE0 // =gameState
	strb r0, [r1, #0xdd]
	bx lr
	.align 2, 0
_02152DE0: .word gameState
	arm_func_end ovl05_2152DD4

	arm_func_start ovl05_2152DE4
ovl05_2152DE4: // 0x02152DE4
	ldr r0, _02152DF0 // =gameState
	ldrb r0, [r0, #0xdd]
	bx lr
	.align 2, 0
_02152DF0: .word gameState
	arm_func_end ovl05_2152DE4

	arm_func_start ovl05_2152DF4
ovl05_2152DF4: // 0x02152DF4
	ldr r1, _02152E00 // =gameState
	strb r0, [r1, #0xde]
	bx lr
	.align 2, 0
_02152E00: .word gameState
	arm_func_end ovl05_2152DF4

	arm_func_start ovl05_2152E04
ovl05_2152E04: // 0x02152E04
	ldr r0, _02152E10 // =gameState
	ldrb r0, [r0, #0xde]
	bx lr
	.align 2, 0
_02152E10: .word gameState
	arm_func_end ovl05_2152E04

	arm_func_start ovl05_2152E14
ovl05_2152E14: // 0x02152E14
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, _02152E68 // =0x02139534
	mov r6, r0
	mov r5, r1
	mov r4, r2
	add r1, r3, r6, lsl #4
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear32
	ldr r0, _02152E68 // =0x02139534
	ldr r2, _02152E6C // =0x02139542
	mov ip, r6, lsl #4
	ldrh r1, [r2, ip]
	add r6, r0, r6, lsl #4
	ldr r3, _02152E70 // =0x02139540
	orr r0, r1, #1
	strh r0, [r2, ip]
	ldmia r5, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	strh r4, [r3, ip]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02152E68: .word 0x02139534
_02152E6C: .word 0x02139542
_02152E70: .word 0x02139540
	arm_func_end ovl05_2152E14

	arm_func_start ovl05_2152E74
ovl05_2152E74: // 0x02152E74
	ldr r1, _02152E90 // =0x02139542
	mov r0, r0, lsl #4
	ldrh r0, [r1, r0]
	tst r0, #1
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02152E90: .word 0x02139542
	arm_func_end ovl05_2152E74

	arm_func_start ovl05_2152E94
ovl05_2152E94: // 0x02152E94
	ldr r1, _02152EA0 // =0x02139534
	add r0, r1, r0, lsl #4
	bx lr
	.align 2, 0
_02152EA0: .word 0x02139534
	arm_func_end ovl05_2152E94

	arm_func_start ovl05_2152EA4
ovl05_2152EA4: // 0x02152EA4
	ldr r1, _02152EB4 // =0x02139540
	mov r0, r0, lsl #4
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02152EB4: .word 0x02139540
	arm_func_end ovl05_2152EA4

	arm_func_start ovl05_2152EB8
ovl05_2152EB8: // 0x02152EB8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r2
	mov r2, #0x14
	mul r4, r0, r2
	ldr r0, _02152F10 // =0x02139544
	mov r7, r1
	add r5, r0, r4
	mov r1, r5
	mov r0, #0
	bl MIi_CpuClear32
	ldr r1, _02152F14 // =0x02139552
	ldr lr, _02152F18 // =0x02139550
	ldrh r0, [r1, r4]
	ldr r3, _02152F1C // =0x02139554
	mvn ip, #0
	orr r0, r0, #1
	strh r0, [r1, r4]
	ldmia r7, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	strh r6, [lr, r4]
	str ip, [r3, r4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02152F10: .word 0x02139544
_02152F14: .word 0x02139552
_02152F18: .word 0x02139550
_02152F1C: .word 0x02139554
	arm_func_end ovl05_2152EB8

	arm_func_start ovl05_2152F20
ovl05_2152F20: // 0x02152F20
	mov r1, #0x14
	mul r1, r0, r1
	ldr r0, _02152F40 // =0x02139552
	ldrh r0, [r0, r1]
	tst r0, #1
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02152F40: .word 0x02139552
	arm_func_end ovl05_2152F20

	arm_func_start ovl05_2152F44
ovl05_2152F44: // 0x02152F44
	ldr r2, _02152F54 // =0x02139544
	mov r1, #0x14
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_02152F54: .word 0x02139544
	arm_func_end ovl05_2152F44

	arm_func_start ovl05_2152F58
ovl05_2152F58: // 0x02152F58
	mov r1, #0x14
	mul r1, r0, r1
	ldr r0, _02152F6C // =0x02139550
	ldrh r0, [r0, r1]
	bx lr
	.align 2, 0
_02152F6C: .word 0x02139550
	arm_func_end ovl05_2152F58

	arm_func_start ovl05_2152F70
ovl05_2152F70: // 0x02152F70
	mov r1, #0x14
	mul r1, r0, r1
	ldr r0, _02152F84 // =0x02139554
	ldr r0, [r0, r1]
	bx lr
	.align 2, 0
_02152F84: .word 0x02139554
	arm_func_end ovl05_2152F70

	arm_func_start ovl05_2152F88
ovl05_2152F88: // 0x02152F88
	ldr r0, _02152F94 // =gameState
	ldrb r0, [r0, #0xdc]
	bx lr
	.align 2, 0
_02152F94: .word gameState
	arm_func_end ovl05_2152F88

	arm_func_start ovl05_2152F98
ovl05_2152F98: // 0x02152F98
	ldr ip, _02152FAC // =MIi_CpuClear32
	mov r1, r0
	mov r0, #0
	mov r2, #0x24
	bx ip
	.align 2, 0
_02152FAC: .word MIi_CpuClear32
	arm_func_end ovl05_2152F98

	arm_func_start ovl05_2152FB0
ovl05_2152FB0: // 0x02152FB0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r2
	mov r6, r0
	mov r5, r1
	mov r4, r3
	bl ovl05_2153064
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [r6]
	mov r2, #0
	str r2, [r6, #4]
	strh r2, [r6, #8]
	strh r2, [r6, #0xa]
	mov r0, #0x1000
	strh r0, [r6, #0xc]
	strh r0, [r6, #0xe]
	ldrh r1, [sp, #0x18]
	strh r4, [r6, #0x10]
	ldr r0, _02153060 // =0x0000FFFF
	strh r1, [r6, #0x12]
	strh r0, [r6, #0x14]
	str r2, [r6, #0x18]
	str r2, [r6, #0x1c]
	str r5, [r6, #0x20]
	mov r0, #0x800
	bl _AllocHeadHEAP_USER
	str r0, [r6, #0x18]
	mov r0, #0x20
	bl _AllocHeadHEAP_USER
	str r0, [r6, #0x1c]
	ldrh r1, [sp, #0x1c]
	ldr r0, [r6, #0x18]
	bl ovl05_2153388
	ldr r0, [r6]
	orr r0, r0, #0x10000
	str r0, [r6]
	ldr r0, [r6, #0x1c]
	ldr r1, [r6, #0x20]
	ldrsh r2, [r6, #0xe]
	bl ovl05_21534E4
	ldr r0, [r6]
	orr r0, r0, #0x20000
	str r0, [r6]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02153060: .word 0x0000FFFF
	arm_func_end ovl05_2152FB0

	arm_func_start ovl05_2153064
ovl05_2153064: // 0x02153064
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	beq _02153084
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x1c]
_02153084:
	ldr r0, [r4, #0x18]
	cmp r0, #0
	beq _0215309C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x18]
_0215309C:
	mov r0, r4
	bl ovl05_2152F98
	ldmia sp!, {r4, pc}
	arm_func_end ovl05_2153064

	arm_func_start ovl05_21530A8
ovl05_21530A8: // 0x021530A8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x34
	mov r7, r0
	ldr r0, [r7, #4]
	mov r1, #6
	mov r4, #0
	bl FX_DivS32
	mov r1, #6
	bl FX_ModS32
	ldr r1, _02153320 // =0x02172420
	mov r0, r0, lsl #1
	ldrh r5, [r1, r0]
	ldrh r0, [r7, #0x14]
	cmp r5, r0
	strneh r5, [r7, #0x14]
	ldrh r0, [r7, #0x12]
	movne r4, #1
	ldrh r1, [r7, #0x10]
	cmp r0, #2
	ldrne r0, _02153324 // =VRAMSystem__GFXControl
	ldrne r0, [r0, r1, lsl #2]
	addne r6, r0, #0x40
	bne _02153110
	ldr r0, _02153324 // =VRAMSystem__GFXControl
	ldr r0, [r0, r1, lsl #2]
	add r6, r0, #0x28
_02153110:
	ldrsh r1, [r7, #0xc]
	mov r0, r6
	mov r2, r1
	blx MTX_Scale22_
	mov r0, #0x20
	strh r0, [r6, #0x10]
	strh r0, [r6, #0x12]
	ldrsh r1, [r6, #0x10]
	ldrsh r0, [r7, #8]
	cmp r4, #0
	sub r0, r1, r0
	strh r0, [r6, #0x14]
	ldrsh r1, [r6, #0x12]
	ldrsh r0, [r7, #0xa]
	sub r0, r1, r0
	strh r0, [r6, #0x16]
	beq _021531DC
	ldr r0, [r7]
	tst r0, #1
	bne _021531DC
	ldrh r1, [r7, #0x12]
	ldrh r0, [r7, #0x10]
	add r2, sp, #0x22
	add r3, sp, #0x20
	and r1, r1, #0xff
	bl GetVRAMCharacterConfig
	ldrh r0, [sp, #0x20]
	ldrh r3, [r7, #0x10]
	ldr r2, _02153328 // =VRAMSystem__VRAM_BG
	ldrh r1, [sp, #0x22]
	mov r0, r0, lsl #0xe
	ldr r2, [r2, r3, lsl #2]
	add r1, r0, r1, lsl #16
	ldr r0, [r7, #0x20]
	add r4, r2, r1
	bl GetBackgroundPixels
	ldr r1, [r7]
	add r0, r0, #4
	tst r1, #8
	add r0, r0, r5, lsl #10
	add r3, r4, #0x40
	mov r1, #0x400
	mov r2, #0
	beq _021531C8
	bl LoadUncompressedPixels
	b _021531CC
_021531C8:
	bl QueueUncompressedPixels
_021531CC:
	mov r1, r4
	mov r0, #0
	mov r2, #0x40
	bl MIi_CpuClear32
_021531DC:
	ldr r0, [r7]
	tst r0, #0x10000
	beq _021532A4
	tst r0, #2
	bne _021532A4
	add r0, sp, #0x24
	str r0, [sp]
	ldrh r1, [r7, #0x12]
	ldrh r0, [r7, #0x10]
	add r2, sp, #0x30
	add r3, sp, #0x26
	and r1, r1, #0xff
	bl GetVRAMTileConfig
	ldr r0, [r7]
	mov r1, #0
	tst r0, #0x10
	mov r0, #1
	str r0, [sp]
	mov r3, #0x20
	beq _02153264
	ldr r0, [sp, #0x30]
	mov r2, r1
	str r0, [sp, #4]
	ldrh r0, [sp, #0x26]
	str r0, [sp, #8]
	ldrh r0, [sp, #0x24]
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	str r3, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r0, [r7, #0x18]
	bl Mappings__LoadUnknown
	b _02153298
_02153264:
	ldr r0, [sp, #0x30]
	mov r2, r1
	str r0, [sp, #4]
	ldrh r0, [sp, #0x26]
	str r0, [sp, #8]
	ldrh r0, [sp, #0x24]
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	str r3, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r0, [r7, #0x18]
	bl Mappings__ReadMappingsCompressed
_02153298:
	ldr r0, [r7]
	bic r0, r0, #0x10000
	str r0, [r7]
_021532A4:
	ldr r0, [r7]
	tst r0, #0x20000
	beq _0215330C
	tst r0, #4
	bne _0215330C
	ldrh r1, [r7, #0x12]
	ldrh r0, [r7, #0x10]
	add r2, sp, #0x2c
	add r3, sp, #0x28
	and r1, r1, #0xff
	bl GetVRAMPaletteConfig
	ldr r0, [r7]
	mov r1, #0x10
	tst r0, #0x20
	ldr r0, [r7, #0x1c]
	beq _021532F4
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x28]
	bl LoadUncompressedPalette
	b _02153300
_021532F4:
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x28]
	bl QueueUncompressedPalette
_02153300:
	ldr r0, [r7]
	bic r0, r0, #0x20000
	str r0, [r7]
_0215330C:
	ldr r0, [r7, #4]
	add r0, r0, #1
	str r0, [r7, #4]
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02153320: .word 0x02172420
_02153324: .word VRAMSystem__GFXControl
_02153328: .word VRAMSystem__VRAM_BG
	arm_func_end ovl05_21530A8

	arm_func_start ovl05_215332C
ovl05_215332C: // 0x0215332C
	strh r1, [r0, #8]
	strh r2, [r0, #0xa]
	bx lr
	arm_func_end ovl05_215332C

	arm_func_start ovl05_2153338
ovl05_2153338: // 0x02153338
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	bl FX_Inv
	strh r0, [r4, #0xc]
	ldmia sp!, {r4, pc}
	arm_func_end ovl05_2153338

	arm_func_start ovl05_2153350
ovl05_2153350: // 0x02153350
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrsh r0, [r4, #0xe]
	cmp r0, r1
	ldmeqia sp!, {r4, pc}
	strh r1, [r4, #0xe]
	ldrsh r2, [r4, #0xe]
	ldr r0, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	bl ovl05_21534E4
	ldr r0, [r4]
	orr r0, r0, #0x20000
	str r0, [r4]
	ldmia sp!, {r4, pc}
	arm_func_end ovl05_2153350

	arm_func_start ovl05_2153388
ovl05_2153388: // 0x02153388
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	mov r4, r0
	mov r5, r1
	mov r1, r4
	mov r0, #0
	mov r2, #0x800
	bl MIi_CpuClearFast
	mov r2, r5, lsl #0xc
	mov r5, #0
	orr r0, r2, #0x800
	orr r1, r2, #0xc00
	orr r3, r2, #0x400
	mov sb, r4
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r3, lsl #0x10
	mov sl, #1
	mov ip, r5
	mov lr, r5
_021533D8:
	mov r8, sl, lsl #0x10
	mov r7, sb
	mov r6, lr
	mov r8, r8, lsr #0x10
_021533E8:
	add fp, r8, #1
	mov fp, fp, lsl #0x10
	orr r8, r8, r2, lsr #16
	strh r8, [r7], #2
	mov r8, fp, lsr #0x10
	add r6, r6, #1
	cmp r6, #4
	blt _021533E8
	add r6, r5, #1
	mov r7, r6, lsl #0x12
	mov r8, ip
	add r6, sb, #8
	mov r7, r7, lsr #0x10
_0215341C:
	sub fp, r7, #1
	mov fp, fp, lsl #0x10
	orr r7, r7, r3, lsr #16
	strh r7, [r6], #2
	mov r7, fp, lsr #0x10
	add r8, r8, #1
	cmp r8, #4
	blt _0215341C
	add r5, r5, #1
	cmp r5, #4
	add sb, sb, #0x40
	add sl, sl, #4
	blt _021533D8
	mov r3, #0
	mov r7, r3
	mov r2, r3
_0215345C:
	rsb r5, r3, #3
	mov r5, r5, lsl #2
	add r6, r3, #4
	add r5, r5, #1
	add r8, r4, r6, lsl #6
	mov r5, r5, lsl #0x10
	mov sb, r8
	mov sl, r2
	mov r6, r5, lsr #0x10
_02153480:
	add r5, r6, #1
	orr r6, r6, r0, lsr #16
	mov r5, r5, lsl #0x10
	add sl, sl, #1
	cmp sl, #4
	strh r6, [sb], #2
	mov r6, r5, lsr #0x10
	blt _02153480
	rsb r5, r3, #4
	mov r5, r5, lsl #0x12
	mov sb, r7
	add r8, r8, #8
	mov r6, r5, lsr #0x10
_021534B4:
	sub r5, r6, #1
	orr r6, r6, r1, lsr #16
	mov r5, r5, lsl #0x10
	add sb, sb, #1
	cmp sb, #4
	strh r6, [r8], #2
	mov r6, r5, lsr #0x10
	blt _021534B4
	add r3, r3, #1
	cmp r3, #4
	blt _0215345C
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end ovl05_2153388

	arm_func_start ovl05_21534E4
ovl05_21534E4: // 0x021534E4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	mov sb, r0
	mov r0, r1
	mov r8, r2
	bl GetBackgroundPalette
	mov r7, #0
	add r6, r0, #4
	mov r5, r7
	mov r4, #0x1000
_02153508:
	mov r0, r7, lsl #1
	ldrh r0, [r6, r0]
	mov r1, r5
	mov r2, r4
	mov r0, r0, lsl #0x1b
	mov r3, r8
	mov r0, r0, lsr #0xf
	bl Unknown2051334__Func_20516B8
	mov r2, r0, asr #0xc
	orr r1, r2, r2, lsl #5
	mov r0, r7, lsl #1
	orr r1, r1, r2, lsl #10
	add r7, r7, #1
	strh r1, [sb, r0]
	cmp r7, #0x10
	blt _02153508
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	arm_func_end ovl05_21534E4

	arm_func_start ovl05_215354C
ovl05_215354C: // 0x0215354C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r8, r0
	mov r7, r2
	mov r6, r3
	str r1, [r8]
	add r1, sp, #8
	str r1, [sp]
	add r2, sp, #0xc
	add r3, sp, #0xa
	mov r0, r7
	and r1, r6, #0xff
	bl GetVRAMTileConfig
	ldrh r0, [sp, #8]
	ldr r2, _0215360C // =VRAMSystem__VRAM_BG
	ldrh r5, [sp, #0x28]
	mov r1, r0, lsl #0xb
	ldrh r3, [sp, #0xa]
	ldr r4, [r2, r7, lsl #2]
	mov r0, r5, lsl #0x1c
	add r1, r1, r3, lsl #16
	mov r0, r0, lsr #0x10
	mov r2, #0x800
	add r1, r4, r1
	bl MIi_CpuClear32
	and r1, r6, #0xff
	mov r0, r7
	add r2, sp, #6
	add r3, sp, #4
	bl GetVRAMCharacterConfig
	ldrh r1, [sp, #4]
	ldrh r3, [sp, #6]
	ldr r0, _02153610 // =0x11111111
	mov r1, r1, lsl #0xe
	add r1, r1, r3, lsl #16
	mov r2, #0x20
	add r1, r4, r1
	bl MIi_CpuClear32
	mov r0, r5, lsl #5
	add r0, r0, #2
	str r0, [r8, #4]
	ldr r0, [r8, #4]
	cmp r7, #0
	addne r0, r0, #0x400
	add r0, r0, #0x5000000
	str r0, [r8, #4]
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215360C: .word VRAMSystem__VRAM_BG
_02153610: .word 0x11111111
	arm_func_end ovl05_215354C

	arm_func_start ovl05_2153614
ovl05_2153614: // 0x02153614
	stmdb sp!, {r3, lr}
	strh r1, [r0, #8]
	ldr r1, [r0]
	tst r1, #1
	ldmneia sp!, {r3, pc}
	tst r1, #2
	ldr r3, [r0, #4]
	mov r1, #1
	add r0, r0, #8
	mov r2, #0
	beq _02153648
	bl LoadUncompressedPalette
	ldmia sp!, {r3, pc}
_02153648:
	bl QueueUncompressedPalette
	ldmia sp!, {r3, pc}
	arm_func_end ovl05_2153614

	arm_func_start ovl05_2153650
ovl05_2153650: // 0x02153650
	ldr r1, _02153660 // =0x021725E0
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02153660: .word 0x021725E0
	arm_func_end ovl05_2153650

	arm_func_start ovl05_2153664
ovl05_2153664: // 0x02153664
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl05_2153700
	ldr r1, _02153684 // =_021734E8
	mov r0, r0, lsl #1
	ldr r1, [r1, r4, lsl #2]
	ldrh r0, [r1, r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02153684: .word _021734E8
	arm_func_end ovl05_2153664

	arm_func_start ovl05_2153688
ovl05_2153688: // 0x02153688
	stmdb sp!, {r3, lr}
	ldr r1, _021536A8 // =_021733E0
	ldr r0, [r1, r0, lsl #2]
	cmp r0, #0
	ldreq r0, _021536AC // =0x0000FFFF
	ldmeqia sp!, {r3, pc}
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_021536A8: .word _021733E0
_021536AC: .word 0x0000FFFF
	arm_func_end ovl05_2153688

	arm_func_start ovl05_21536B0
ovl05_21536B0: // 0x021536B0
	stmdb sp!, {r3, lr}
	ldr r1, _021536D0 // =_02173438
	ldr r0, [r1, r0, lsl #2]
	cmp r0, #0
	ldreq r0, _021536D4 // =0x0000FFFF
	ldmeqia sp!, {r3, pc}
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_021536D0: .word _02173438
_021536D4: .word 0x0000FFFF
	arm_func_end ovl05_21536B0

	arm_func_start ovl05_21536D8
ovl05_21536D8: // 0x021536D8
	stmdb sp!, {r3, lr}
	ldr r1, _021536F8 // =_02173490
	ldr r0, [r1, r0, lsl #2]
	cmp r0, #0
	ldreq r0, _021536FC // =0x0000FFFF
	ldmeqia sp!, {r3, pc}
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_021536F8: .word _02173490
_021536FC: .word 0x0000FFFF
	arm_func_end ovl05_21536D8

	arm_func_start ovl05_2153700
ovl05_2153700: // 0x02153700
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	bl SaveGame__GetGameProgress
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	bl SaveGame__GetUnknownProgress1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	bl SaveGame__GetUnknownProgress2
	mov r0, r0, lsl #0x10
	cmp r4, #0x18
	mov r6, r0, lsr #0x10
	blo _02153744
	cmp r4, #0x18
	cmpeq r5, #1
	cmpeq r6, #1
	bne _02153750
_02153744:
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02153750:
	cmp r4, #0x18
	bne _021537AC
	cmp r7, #0x11
	cmpne r7, #0x13
	moveq r0, #0
	beq _02153784
	cmp r7, #0xf
	moveq r0, #1
	beq _02153784
	cmp r6, #4
	movlo r0, #1
	blo _02153784
	bl SaveGame__GetProgressFlags_0x1
_02153784:
	cmp r0, #0
	beq _0215379C
	add r0, r5, #0x17
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215379C:
	add r0, r6, #0x1a
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021537AC:
	add r0, r4, #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ovl05_2153700

	arm_func_start ovl05_21537BC
ovl05_21537BC: // 0x021537BC
	stmdb sp!, {r3, lr}
	bl SaveGame__GetGameProgress
	cmp r0, #0x10
	bgt _021537DC
	bge _021537FC
	cmp r0, #8
	beq _021537F4
	b _02153804
_021537DC:
	cmp r0, #0x19
	bgt _02153804
	cmp r0, #0x15
	blt _02153804
	cmpne r0, #0x19
	bne _02153804
_021537F4:
	mov r0, #0
	ldmia sp!, {r3, pc}
_021537FC:
	mov r0, #1
	ldmia sp!, {r3, pc}
_02153804:
	mov r0, #0
	mov r1, r0
	bl SaveGame__GetNextShipUpgrade
	cmp r0, #0
	movne r0, #0x23
	ldreq r0, _02153820 // =0x0000FFFF
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153820: .word 0x0000FFFF
	arm_func_end ovl05_21537BC

	arm_func_start ovl05_2153824
ovl05_2153824: // 0x02153824
	stmdb sp!, {r3, lr}
	bl ovl05_2153E18
	cmp r0, #0
	movne r0, #0
	ldreq r0, _0215383C // =0x0000FFFF
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215383C: .word 0x0000FFFF
	arm_func_end ovl05_2153824

	arm_func_start ovl05_2153840
ovl05_2153840: // 0x02153840
	mov r0, #0
	bx lr
	arm_func_end ovl05_2153840

	arm_func_start ovl05_2153848
ovl05_2153848: // 0x02153848
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, #0
	mov r5, r4
	bl SaveGame__CheckProgress29
	cmp r0, #0
	movne r4, #1
	mov r6, #0
_02153864:
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__Func_205D520
	cmp r0, #0
	beq _02153890
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetBoughtInfo
	cmp r0, #0
	moveq r5, #1
	beq _0215389C
_02153890:
	add r6, r6, #1
	cmp r6, #3
	blt _02153864
_0215389C:
	cmp r4, #0
	cmpne r5, #0
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
	cmp r4, #0
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	cmp r5, #0
	movne r0, #1
	ldreq r0, _021538C8 // =0x0000FFFF
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021538C8: .word 0x0000FFFF
	arm_func_end ovl05_2153848

	arm_func_start ovl05_21538CC
ovl05_21538CC: // 0x021538CC
	mov r0, #0
	bx lr
	arm_func_end ovl05_21538CC

	arm_func_start ovl05_21538D4
ovl05_21538D4: // 0x021538D4
	mov r0, #0
	bx lr
	arm_func_end ovl05_21538D4

	arm_func_start ovl05_21538DC
ovl05_21538DC: // 0x021538DC
	mov r0, #0
	bx lr
	arm_func_end ovl05_21538DC

	arm_func_start ovl05_21538E4
ovl05_21538E4: // 0x021538E4
	ldr r0, _021538EC // =0x0000FFFF
	bx lr
	.align 2, 0
_021538EC: .word 0x0000FFFF
	arm_func_end ovl05_21538E4

	arm_func_start ovl05_21538F0
ovl05_21538F0: // 0x021538F0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr ip, _02153944 // =0x02172524
	ldr r1, _02153948 // =0x0217248C
	ldr r2, _0215394C // =0x02172592
	ldr r3, _02153950 // =0x02172468
	mov r0, #6
	str ip, [sp]
	bl ovl05_2153B18
	mov r4, r0
	cmp r4, #0x17
	bne _02153938
	mov r0, #0x54
	bl ovl05_2153EEC
	cmp r0, #0
	addeq sp, sp, #4
	ldreq r0, _02153954 // =0x0000FFFF
	ldmeqia sp!, {r3, r4, pc}
_02153938:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02153944: .word 0x02172524
_02153948: .word 0x0217248C
_0215394C: .word 0x02172592
_02153950: .word 0x02172468
_02153954: .word 0x0000FFFF
	arm_func_end ovl05_21538F0

	arm_func_start ovl05_2153958
ovl05_2153958: // 0x02153958
	stmdb sp!, {r3, lr}
	ldr ip, _0215397C // =0x02172480
	ldr r1, _02153980 // =0x0217243E
	ldr r2, _02153984 // =0x021724D4
	ldr r3, _02153988 // =0x02172438
	mov r0, #3
	str ip, [sp]
	bl ovl05_2153B18
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215397C: .word 0x02172480
_02153980: .word 0x0217243E
_02153984: .word 0x021724D4
_02153988: .word 0x02172438
	arm_func_end ovl05_2153958

	arm_func_start ovl05_215398C
ovl05_215398C: // 0x0215398C
	stmdb sp!, {r3, lr}
	ldr ip, _021539B0 // =0x021724F8
	ldr r1, _021539B4 // =0x0217245E
	ldr r2, _021539B8 // =0x02172574
	ldr r3, _021539BC // =0x02172454
	mov r0, #5
	str ip, [sp]
	bl ovl05_2153B18
	ldmia sp!, {r3, pc}
	.align 2, 0
_021539B0: .word 0x021724F8
_021539B4: .word 0x0217245E
_021539B8: .word 0x02172574
_021539BC: .word 0x02172454
	arm_func_end ovl05_215398C

	arm_func_start ovl05_21539C0
ovl05_21539C0: // 0x021539C0
	stmdb sp!, {r3, lr}
	ldr ip, _021539E4 // =0x0217253C
	ldr r1, _021539E8 // =0x021724A6
	ldr r2, _021539EC // =0x021725B6
	ldr r3, _021539F0 // =0x02172498
	mov r0, #7
	str ip, [sp]
	bl ovl05_2153B18
	ldmia sp!, {r3, pc}
	.align 2, 0
_021539E4: .word 0x0217253C
_021539E8: .word 0x021724A6
_021539EC: .word 0x021725B6
_021539F0: .word 0x02172498
	arm_func_end ovl05_21539C0

	arm_func_start ovl05_21539F4
ovl05_21539F4: // 0x021539F4
	stmdb sp!, {r3, lr}
	ldr ip, _02153A18 // =0x02172474
	ldr r1, _02153A1C // =0x02172432
	ldr r2, _02153A20 // =0x021724E6
	ldr r3, _02153A24 // =0x0217242C
	mov r0, #3
	str ip, [sp]
	bl ovl05_2153B18
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153A18: .word 0x02172474
_02153A1C: .word 0x02172432
_02153A20: .word 0x021724E6
_02153A24: .word 0x0217242C
	arm_func_end ovl05_21539F4

	arm_func_start ovl05_2153A28
ovl05_2153A28: // 0x02153A28
	stmdb sp!, {r3, lr}
	ldr ip, _02153A4C // =0x021724B4
	ldr r1, _02153A50 // =0x0217244C
	ldr r2, _02153A54 // =0x0217250C
	ldr r3, _02153A58 // =0x02172444
	mov r0, #4
	str ip, [sp]
	bl ovl05_2153B18
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153A4C: .word 0x021724B4
_02153A50: .word 0x0217244C
_02153A54: .word 0x0217250C
_02153A58: .word 0x02172444
	arm_func_end ovl05_2153A28

	arm_func_start ovl05_2153A5C
ovl05_2153A5C: // 0x02153A5C
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, _02153AA8 // =0x02172A9E
	mov r5, #0
_02153A68:
	mov r0, r5, lsl #1
	ldrh r6, [r4, r0]
	mov r0, r6
	bl ovl05_2153EEC
	cmp r0, #0
	bne _02153A94
	mov r0, r6
	bl ovl05_2153EA4
	cmp r0, #0
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
_02153A94:
	add r5, r5, #1
	cmp r5, #0x39
	blt _02153A68
	ldr r0, _02153AAC // =0x0000FFFF
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02153AA8: .word 0x02172A9E
_02153AAC: .word 0x0000FFFF
	arm_func_end ovl05_2153A5C

	arm_func_start ovl05_2153AB0
ovl05_2153AB0: // 0x02153AB0
	mov r0, #0x39
	bx lr
	arm_func_end ovl05_2153AB0

	arm_func_start ovl05_2153AB8
ovl05_2153AB8: // 0x02153AB8
	ldr r1, _02153AC8 // =0x02172A9E
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02153AC8: .word 0x02172A9E
	arm_func_end ovl05_2153AB8

	arm_func_start ovl05_2153ACC
ovl05_2153ACC: // 0x02153ACC
	ldr r1, _02153ADC // =0x02172A2C
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02153ADC: .word 0x02172A2C
	arm_func_end ovl05_2153ACC

	arm_func_start ovl05_2153AE0
ovl05_2153AE0: // 0x02153AE0
	mov r0, #0xe
	bx lr
	arm_func_end ovl05_2153AE0

	arm_func_start ovl05_2153AE8
ovl05_2153AE8: // 0x02153AE8
	ldr r1, _02153AF8 // =0x02172558
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02153AF8: .word 0x02172558
	arm_func_end ovl05_2153AE8

	arm_func_start ovl05_2153AFC
ovl05_2153AFC: // 0x02153AFC
	mov r0, #7
	bx lr
	arm_func_end ovl05_2153AFC

	arm_func_start ovl05_2153B04
ovl05_2153B04: // 0x02153B04
	ldr r1, _02153B14 // =0x021724A6
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02153B14: .word 0x021724A6
	arm_func_end ovl05_2153B04

	arm_func_start ovl05_2153B18
ovl05_2153B18: // 0x02153B18
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	movs sb, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x20]
	mov r4, #0
	beq _02153B88
_02153B38:
	mov r0, r4, lsl #1
	ldrh r0, [r8, r0]
	bl ovl05_2153EEC
	cmp r0, #0
	bne _02153B74
	mov r0, r4, lsl #1
	ldrh r0, [r8, r0]
	bl ovl05_2153EA4
	cmp r0, #0
	beq _02153B74
	mov r0, r4, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrh r0, [r5, r0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
_02153B74:
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	cmp sb, r0, lsr #16
	mov r4, r0, lsr #0x10
	bhi _02153B38
_02153B88:
	cmp sb, #0
	mov r4, #0
	bls _02153BEC
_02153B94:
	mov r0, r4, lsl #1
	ldrh r0, [r8, r0]
	bl ovl05_2153DF8
	cmp r0, #0
	bne _02153BD8
	add r0, r4, r4, lsl #1
	add r0, r7, r0, lsl #1
	bl ovl05_2153D48
	cmp r0, #0
	beq _02153BD8
	mov r0, r4, lsl #1
	ldrh r0, [r6, r0]
	bl ovl05_2153D88
	cmp r0, #0
	movne r0, r4, lsl #2
	ldrneh r0, [r5, r0]
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
_02153BD8:
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	cmp sb, r0, lsr #16
	mov r4, r0, lsr #0x10
	bhi _02153B94
_02153BEC:
	ldr r0, _02153BF4 // =0x0000FFFF
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_02153BF4: .word 0x0000FFFF
	arm_func_end ovl05_2153B18

	arm_func_start ovl05_2153BF8
ovl05_2153BF8: // 0x02153BF8
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	ldr ip, _02153CE4 // =0x021724C4
	add r3, sp, #4
	mov r2, #4
_02153C0C:
	ldrh r1, [ip]
	ldrh r0, [ip, #2]
	add ip, ip, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _02153C0C
	bl SaveGame__GetGameProgress
	cmp r0, #8
	bgt _02153C48
	bge _02153C80
	cmp r0, #1
	beq _02153C68
	b _02153CA4
_02153C48:
	cmp r0, #0x19
	bgt _02153CA4
	cmp r0, #0x15
	blt _02153CA4
	beq _02153C8C
	cmp r0, #0x19
	beq _02153C98
	b _02153CA4
_02153C68:
	bl SaveGame__Func_205BF24
	cmp r0, #0
	movne r0, #2
	add sp, sp, #0x14
	moveq r0, #8
	ldmia sp!, {pc}
_02153C80:
	add sp, sp, #0x14
	mov r0, #3
	ldmia sp!, {pc}
_02153C8C:
	add sp, sp, #0x14
	mov r0, #4
	ldmia sp!, {pc}
_02153C98:
	add sp, sp, #0x14
	mov r0, #5
	ldmia sp!, {pc}
_02153CA4:
	add r0, sp, #2
	add r1, sp, #0
	bl SaveGame__GetNextShipUpgrade
	cmp r0, #0
	addeq sp, sp, #0x14
	ldreq r0, _02153CE8 // =0x0000FFFF
	ldmeqia sp!, {pc}
	ldrh r0, [sp]
	ldrh r3, [sp, #2]
	add r2, sp, #4
	sub r0, r0, #1
	mov r1, r0, lsl #1
	add r0, r2, r3, lsl #2
	ldrh r0, [r1, r0]
	add sp, sp, #0x14
	ldmia sp!, {pc}
	.align 2, 0
_02153CE4: .word 0x021724C4
_02153CE8: .word 0x0000FFFF
	arm_func_end ovl05_2153BF8

	arm_func_start ovl05_2153CEC
ovl05_2153CEC: // 0x02153CEC
	stmdb sp!, {r3, lr}
	bl SaveGame__GetGameProgress
	cmp r0, #0x1d
	moveq r0, #6
	ldrne r0, _02153D04 // =0x0000FFFF
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153D04: .word 0x0000FFFF
	arm_func_end ovl05_2153CEC

	arm_func_start ovl05_2153D08
ovl05_2153D08: // 0x02153D08
	stmdb sp!, {r3, lr}
	bl SaveGame__GetProgressFlags_0x10
	cmp r0, #0
	ldrne r0, _02153D28 // =0x0000FFFF
	ldmneia sp!, {r3, pc}
	bl SaveGame__SetProgressFlags_0x10
	mov r0, #1
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153D28: .word 0x0000FFFF
	arm_func_end ovl05_2153D08

	arm_func_start ovl05_2153D2C
ovl05_2153D2C: // 0x02153D2C
	stmdb sp!, {r3, lr}
	bl SaveGame__GetGameProgress
	cmp r0, #0x1d
	moveq r0, #3
	ldrne r0, _02153D44 // =0x0000FFFF
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153D44: .word 0x0000FFFF
	arm_func_end ovl05_2153D2C

	arm_func_start ovl05_2153D48
ovl05_2153D48: // 0x02153D48
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl SaveGame__GetGameProgress
	mov r5, r0
	bl SaveGame__GetUnknownProgress1
	mov r4, r0
	bl SaveGame__GetUnknownProgress2
	ldrh r1, [r6]
	cmp r5, r1
	ldrgeh r1, [r6, #2]
	cmpge r4, r1
	ldrgeh r1, [r6, #4]
	cmpge r0, r1
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl05_2153D48

	arm_func_start ovl05_2153D88
ovl05_2153D88: // 0x02153D88
	stmdb sp!, {r3, lr}
	ldr r2, _02153DB8 // =0x0000FFFF
	mov r1, r0
	cmp r1, r2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	ldr r0, _02153DBC // =0x02134474
	blx SaveGame__GetIslandProgress
	cmp r0, #2
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153DB8: .word 0x0000FFFF
_02153DBC: .word 0x02134474
	arm_func_end ovl05_2153D88

	arm_func_start ovl05_2153DC0
ovl05_2153DC0: // 0x02153DC0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl05_2153DF8
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #1
	bl SaveGame__SetMissionStatus
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #1
	bl SaveGame__SetMissionAttempted
	ldmia sp!, {r4, pc}
	arm_func_end ovl05_2153DC0

	arm_func_start ovl05_2153DF8
ovl05_2153DF8: // 0x02153DF8
	stmdb sp!, {r3, lr}
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetMissionStatus
	cmp r0, #1
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end ovl05_2153DF8

	arm_func_start ovl05_2153E18
ovl05_2153E18: // 0x02153E18
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, #0
	mov r4, r5
_02153E24:
	mov r0, r4
	bl ovl05_2153DF8
	cmp r0, #0
	add r4, r4, #1
	addne r5, r5, #1
	cmp r4, #0x64
	blt _02153E24
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl05_2153E18

	arm_func_start ovl05_2153E4C
ovl05_2153E4C: // 0x02153E4C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl05_2153EA4
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #2
	bl SaveGame__SetMissionStatus
	mov r4, #0
_02153E74:
	mov r0, r4
	bl ovl05_2153EA4
	cmp r0, #0
	beq _02153E90
	add r4, r4, #1
	cmp r4, #0x63
	blt _02153E74
_02153E90:
	cmp r4, #0x63
	ldmltia sp!, {r4, pc}
	mov r0, #0x63
	bl ovl05_2153DC0
	ldmia sp!, {r4, pc}
	arm_func_end ovl05_2153E4C

	arm_func_start ovl05_2153EA4
ovl05_2153EA4: // 0x02153EA4
	stmdb sp!, {r3, lr}
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetMissionStatus
	cmp r0, #2
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end ovl05_2153EA4

	arm_func_start ovl05_2153EC4
ovl05_2153EC4: // 0x02153EC4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl05_2153EEC
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #3
	bl SaveGame__SetMissionStatus
	ldmia sp!, {r4, pc}
	arm_func_end ovl05_2153EC4

	arm_func_start ovl05_2153EEC
ovl05_2153EEC: // 0x02153EEC
	stmdb sp!, {r3, lr}
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetMissionStatus
	cmp r0, #3
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end ovl05_2153EEC

	arm_func_start ovl05_2153F0C
ovl05_2153F0C: // 0x02153F0C
	ldr ip, _02153F20 // =SaveGame__SetMissionAttempted
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bx ip
	.align 2, 0
_02153F20: .word SaveGame__SetMissionAttempted
	arm_func_end ovl05_2153F0C

	arm_func_start ovl05_2153F24
ovl05_2153F24: // 0x02153F24
	ldr ip, _02153F34 // =SaveGame__GetMissionAttempted
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx ip
	.align 2, 0
_02153F34: .word SaveGame__GetMissionAttempted
	arm_func_end ovl05_2153F24

	arm_func_start ovl05_2153F38
ovl05_2153F38: // 0x02153F38
	stmdb sp!, {r4, lr}
	ldr r1, _0215400C // =gameState
	mov r4, r0
	str r4, [r1, #0x144]
	mov r0, #5
	strb r0, [r1, #0xdc]
	cmp r4, #0x5f
	bge _02153FF0
	ldr r0, _02154010 // =0x02172C3C
	mov r1, r4, lsl #1
	ldrh r0, [r0, r1]
	bl InitStageMission
	mov r0, r4
	bl ovl05_2154290
	cmp r0, #0
	beq _02153F90
	ldr r1, _0215400C // =gameState
	mov r2, #0
	mov r0, #8
	str r2, [r1, #4]
	bl RequestNewSysEventChange
	ldmia sp!, {r4, pc}
_02153F90:
	mov r0, r4
	bl ovl05_2154298
	cmp r0, #0
	beq _02153FB8
	ldr r1, _0215400C // =gameState
	mov r2, #1
	mov r0, #8
	str r2, [r1, #4]
	bl RequestNewSysEventChange
	ldmia sp!, {r4, pc}
_02153FB8:
	bl SaveGame__BlazeUnlocked
	cmp r0, #0
	mov r2, #0
	beq _02153FDC
	ldr r1, _0215400C // =gameState
	mov r0, #7
	str r2, [r1, #4]
	bl RequestNewSysEventChange
	ldmia sp!, {r4, pc}
_02153FDC:
	ldr r1, _0215400C // =gameState
	mov r0, #8
	str r2, [r1, #4]
	bl RequestNewSysEventChange
	ldmia sp!, {r4, pc}
_02153FF0:
	ldr r0, _02154010 // =0x02172C3C
	mov r1, r4, lsl #1
	ldrh r0, [r0, r1]
	bl MultibootManager__Func_2063C60
	mov r0, #0x1b
	bl RequestNewSysEventChange
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215400C: .word gameState
_02154010: .word 0x02172C3C
	arm_func_end ovl05_2153F38

	arm_func_start ovl05_2154014
ovl05_2154014: // 0x02154014
	ldr r0, _02154020 // =gameState
	ldr r0, [r0, #0x144]
	bx lr
	.align 2, 0
_02154020: .word gameState
	arm_func_end ovl05_2154014

	arm_func_start ovl05_2154024
ovl05_2154024: // 0x02154024
	ldr r1, _02154034 // =0x02172B74
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02154034: .word 0x02172B74
	arm_func_end ovl05_2154024

	arm_func_start ovl05_2154038
ovl05_2154038: // 0x02154038
	stmdb sp!, {r4, r5, r6, lr}
	bl ovl05_2153AB0
	mov r6, r0
	mov r5, #0
	cmp r6, #0
	ldmleia sp!, {r4, r5, r6, pc}
_02154050:
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ovl05_2153AB8
	mov r4, r0
	bl ovl05_2153EEC
	cmp r0, #0
	bne _02154084
	mov r0, r4
	bl ovl05_2153EA4
	cmp r0, #0
	beq _02154084
	mov r0, r4
	bl ovl05_2153EC4
_02154084:
	add r5, r5, #1
	cmp r5, r6
	blt _02154050
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl05_2154038

	arm_func_start ovl05_2154094
ovl05_2154094: // 0x02154094
	cmp r0, #0x31
	bgt _021540BC
	bge _02154140
	cmp r0, #9
	bgt _021540B0
	beq _02154130
	b _02154198
_021540B0:
	cmp r0, #0x27
	beq _02154138
	b _02154198
_021540BC:
	cmp r0, #0x3b
	bgt _021540CC
	beq _02154148
	b _02154198
_021540CC:
	sub r0, r0, #0x4f
	cmp r0, #0x14
	addls pc, pc, r0, lsl #2
	b _02154198
_021540DC: // jump table
	b _02154168 // case 0
	b _02154198 // case 1
	b _02154198 // case 2
	b _02154198 // case 3
	b _02154150 // case 4
	b _02154158 // case 5
	b _02154160 // case 6
	b _02154198 // case 7
	b _02154198 // case 8
	b _02154170 // case 9
	b _02154178 // case 10
	b _02154198 // case 11
	b _02154180 // case 12
	b _02154198 // case 13
	b _02154188 // case 14
	b _02154198 // case 15
	b _02154198 // case 16
	b _02154198 // case 17
	b _02154198 // case 18
	b _02154198 // case 19
	b _02154190 // case 20
_02154130:
	mov r0, #0x10
	bx lr
_02154138:
	mov r0, #2
	bx lr
_02154140:
	mov r0, #0x13
	bx lr
_02154148:
	mov r0, #0xd
	bx lr
_02154150:
	mov r0, #1
	bx lr
_02154158:
	mov r0, #0x14
	bx lr
_02154160:
	mov r0, #0x15
	bx lr
_02154168:
	mov r0, #0xa
	bx lr
_02154170:
	mov r0, #0x12
	bx lr
_02154178:
	mov r0, #0xb
	bx lr
_02154180:
	mov r0, #4
	bx lr
_02154188:
	mov r0, #0xc
	bx lr
_02154190:
	mov r0, #6
	bx lr
_02154198:
	mov r0, #0x17
	bx lr
	arm_func_end ovl05_2154094

	arm_func_start ovl05_21541A0
ovl05_21541A0: // 0x021541A0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	mov r4, #0
	bl SaveGame__GetGameProgress
	cmp r0, #0x24
	blt _02154280
	mov r8, r4
	bl ovl05_2153AB0
	cmp r0, #0
	ble _02154234
	ldr r7, _02154288 // =0x02134474
	ldr r5, _0215428C // =0x0000FFFF
	mov r6, #1
_021541D0:
	mov r0, r8, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ovl05_2153AB8
	mov r1, r8, lsl #0x10
	mov sb, r0
	mov r0, r1, lsr #0x10
	bl ovl05_2153ACC
	mov r1, r0
	cmp r1, r5
	beq _02154208
	mov r0, r7
	blx SaveGame__GetIslandProgress
	cmp r0, #2
	blt _02154224
_02154208:
	mov r0, sb
	bl ovl05_2153DF8
	cmp r0, #0
	bne _02154224
	mov r0, sb
	bl ovl05_2153DC0
	mov r4, r6
_02154224:
	add r8, r8, #1
	bl ovl05_2153AB0
	cmp r8, r0
	blt _021541D0
_02154234:
	mov r7, #0
	bl ovl05_2153AE0
	cmp r0, #0
	ble _02154280
	mov r5, #1
_02154248:
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ovl05_2153AE8
	mov r6, r0
	bl ovl05_2153DF8
	cmp r0, #0
	bne _02154270
	mov r0, r6
	bl ovl05_2153DC0
	mov r4, r5
_02154270:
	add r7, r7, #1
	bl ovl05_2153AE0
	cmp r7, r0
	blt _02154248
_02154280:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_02154288: .word 0x02134474
_0215428C: .word 0x0000FFFF
	arm_func_end ovl05_21541A0

	arm_func_start ovl05_2154290
ovl05_2154290: // 0x02154290
	mov r0, #0
	bx lr
	arm_func_end ovl05_2154290

	arm_func_start ovl05_2154298
ovl05_2154298: // 0x02154298
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	mov r5, #0
	bl ovl05_2153AFC
	cmp r0, #0
	ble _021542E0
	mov r0, r4, lsl #0x10
	mov r4, r0, lsr #0x10
_021542B8:
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ovl05_2153B04
	cmp r4, r0
	moveq r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	add r5, r5, #1
	bl ovl05_2153AFC
	cmp r5, r0
	blt _021542B8
_021542E0:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl05_2154298

	arm_func_start ovl05_21542E8
ovl05_21542E8: // 0x021542E8
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl ovl05_2153EA4
	cmp r0, #0
	ldrne r0, _0215434C // =0x0000FFFF
	ldmneia sp!, {r3, r4, r5, pc}
	mov r5, #0
	bl ovl05_2153AFC
	cmp r0, #0
	ble _02154344
	mov r0, r4, lsl #0x10
	mov r4, r0, lsr #0x10
_02154318:
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ovl05_2153B04
	cmp r4, r0
	moveq r0, r5, lsl #0x10
	moveq r0, r0, lsr #0x10
	ldmeqia sp!, {r3, r4, r5, pc}
	add r5, r5, #1
	bl ovl05_2153AFC
	cmp r5, r0
	blt _02154318
_02154344:
	ldr r0, _0215434C // =0x0000FFFF
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215434C: .word 0x0000FFFF
	arm_func_end ovl05_21542E8

	arm_func_start ovl05_2154350
ovl05_2154350: // 0x02154350
	ldr r1, _0215435C // =0x02172B10
	ldrb r0, [r1, r0]
	bx lr
	.align 2, 0
_0215435C: .word 0x02172B10
	arm_func_end ovl05_2154350

	arm_func_start DockHelpers__LoadVillageTrack
DockHelpers__LoadVillageTrack: // 0x02154360
	stmdb sp!, {r3, lr}
	bl LoadSysSoundVillage
	bl AllocSndHandle
	ldr r1, _02154378 // =DockHelpers__SndHandle
	str r0, [r1]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02154378: .word DockHelpers__SndHandle
	arm_func_end DockHelpers__LoadVillageTrack

	arm_func_start ovl05_215437C
ovl05_215437C: // 0x0215437C
	stmdb sp!, {r4, lr}
	ldr r1, _021543C0 // =DockHelpers__SndHandle
	mov r4, r0
	ldr r0, [r1]
	cmp r0, #0
	beq _021543B0
	bl ovl05_2154474
	ldr r0, _021543C0 // =DockHelpers__SndHandle
	ldr r0, [r0]
	bl FreeSndHandle
	ldr r0, _021543C0 // =DockHelpers__SndHandle
	mov r1, #0
	str r1, [r0]
_021543B0:
	cmp r4, #0
	ldmeqia sp!, {r4, pc}
	bl ReleaseSysSound
	ldmia sp!, {r4, pc}
	.align 2, 0
_021543C0: .word DockHelpers__SndHandle
	arm_func_end ovl05_215437C

	arm_func_start ovl05_21543C4
ovl05_21543C4: // 0x021543C4
	ldr ip, _021543D0 // =PlaySysVillageTrack
	mov r0, #0
	bx ip
	.align 2, 0
_021543D0: .word PlaySysVillageTrack
	arm_func_end ovl05_21543C4

	arm_func_start ovl05_21543D4
ovl05_21543D4: // 0x021543D4
	ldr ip, _021543DC // =SetSysTrackVolume
	bx ip
	.align 2, 0
_021543DC: .word SetSysTrackVolume
	arm_func_end ovl05_21543D4

	arm_func_start ovl05_21543E0
ovl05_21543E0: // 0x021543E0
	ldr ip, _021543E8 // =FadeSysTrack
	bx ip
	.align 2, 0
_021543E8: .word FadeSysTrack
	arm_func_end ovl05_21543E0

	arm_func_start ovl05_21543EC
ovl05_21543EC: // 0x021543EC
	stmdb sp!, {r3, lr}
	bl ovl05_2154474
	ldr r1, _02154428 // =audioManagerSndHeap
	mov r0, #0
	ldr r1, [r1]
	bl NNS_SndArcLoadSeq
	mov r2, #0
	sub r1, r2, #1
	ldr r0, _0215442C // =DockHelpers__SndHandle
	str r2, [sp]
	ldr r0, [r0]
	mov r2, r1
	mov r3, r1
	bl PlayTrack
	ldmia sp!, {r3, pc}
	.align 2, 0
_02154428: .word audioManagerSndHeap
_0215442C: .word DockHelpers__SndHandle
	arm_func_end ovl05_21543EC

	arm_func_start ovl05_2154430
ovl05_2154430: // 0x02154430
	stmdb sp!, {r3, lr}
	bl ovl05_2154474
	ldr r1, _0215446C // =audioManagerSndHeap
	mov r0, #1
	ldr r1, [r1]
	bl NNS_SndArcLoadSeq
	mov r2, #1
	sub r1, r2, #2
	ldr r0, _02154470 // =DockHelpers__SndHandle
	str r2, [sp]
	ldr r0, [r0]
	mov r2, r1
	mov r3, r1
	bl PlayTrack
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215446C: .word audioManagerSndHeap
_02154470: .word DockHelpers__SndHandle
	arm_func_end ovl05_2154430

	arm_func_start ovl05_2154474
ovl05_2154474: // 0x02154474
	stmdb sp!, {r3, lr}
	ldr r0, _021544A8 // =DockHelpers__SndHandle
	ldr r0, [r0]
	cmp r0, #0
	ldrne r1, [r0]
	cmpne r1, #0
	ldmeqia sp!, {r3, pc}
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	ldr r0, _021544A8 // =DockHelpers__SndHandle
	ldr r0, [r0]
	bl NNS_SndHandleReleaseSeq
	ldmia sp!, {r3, pc}
	.align 2, 0
_021544A8: .word DockHelpers__SndHandle
	arm_func_end ovl05_2154474

	arm_func_start ovl05_21544AC
ovl05_21544AC: // 0x021544AC
	ldr r1, _021544C0 // =0x02172D04
	mov r0, r0, lsl #1
	ldr ip, _021544C4 // =PlaySysSfx
	ldrh r0, [r1, r0]
	bx ip
	.align 2, 0
_021544C0: .word 0x02172D04
_021544C4: .word PlaySysSfx
	arm_func_end ovl05_21544AC

	.data

.public _021733E0
_021733E0: // 0x021733E0
	.word ovl05_21537BC, ovl05_2153824, 0, 0, ovl05_2153848, ovl05_2153840
	.word ovl05_2153848, 0, 0, ovl05_21537BC, ovl05_2153824, 0, ovl05_21538CC
	.word ovl05_2153848, 0, ovl05_21538DC, ovl05_2153848, 0, ovl05_2153848
	.word 0, 0, ovl05_21538D4

.public _02173438
_02173438: // 0x02173438
	.word ovl05_2153BF8, 0, 0, ovl05_2153CEC, 0, 0, 0, 0, 0, 0, 0
	.word ovl05_2153CEC, ovl05_2153D08, 0, 0, 0, 0, ovl05_2153D2C
	.word 0, ovl05_2153D2C, ovl05_2153CEC, 0

.public _02173490
_02173490: // 0x02173490
	.word 0, ovl05_21538E4, 0, ovl05_2153958, 0, ovl05_21538F0, 0
	.word 0, 0, 0, ovl05_21538E4, ovl05_2153958, ovl05_215398C, 0
	.word ovl05_21539C0, ovl05_2153A28, 0, ovl05_21539F4, 0, ovl05_21539F4
	.word ovl05_2153958, ovl05_2153A5C

// TODO: add labels for these so we're not using raw addresses
.public _021734E8
_021734E8: // 0x021734E8
	.word 0x021729CC
	.word 0x0217260C
	.word 0x0217266C
	.word 0x0217272C
	.word 0x0217278C
	.word 0x021726CC
	.word 0x0217278C
	.word 0
	.word 0
	.word 0x021729CC
	.word 0x0217260C
	.word 0x0217272C
	.word 0x021728AC
	.word 0x0217278C
	.word 0x021727EC
	.word 0x0217296C
	.word 0x0217278C
	.word 0x0217284C
	.word 0x0217278C
	.word 0x0217284C
	.word 0x0217272C
	.word 0x0217290C