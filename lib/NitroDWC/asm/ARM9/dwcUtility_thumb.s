	.include "asm/macros.inc"
	.include "global.inc"

	.bss

_0217C2E0:
	.space 0x2700

	.text

	thumb_func_start AOSS_FD_SET
AOSS_FD_SET: // 0x02152960
	str r0, [r1]
	mov r0, #1
	strh r0, [r1, #4]
	bx lr
	thumb_func_end AOSS_FD_SET

	thumb_func_start AOSS_FD_ZERO
AOSS_FD_ZERO: // 0x02152968
	mov r1, #0
	str r1, [r0]
	strh r1, [r0, #4]
	strh r1, [r0, #6]
	bx lr
	.align 2, 0
	thumb_func_end AOSS_FD_ZERO

	thumb_func_start AOSS_Rand
AOSS_Rand: // 0x02152974
	push {r4, lr}
	sub sp, #0x10
	ldr r0, _021529DC // =0x0217C2E8
	ldr r0, [r0]
	cmp r0, #0
	bne _021529B8
	mov r4, #0
	add r0, sp, #0
	mov r1, r4
	mov r2, #0xc
	bl ovl08_2152B44
	add r0, sp, #0
	blx RTC_GetTime
	cmp r0, #0
	bne _021529A6
	ldr r0, [sp]
	lsl r0, r0, #0xa
	add r1, r4, r0
	ldr r0, [sp, #4]
	lsl r0, r0, #3
	add r1, r1, r0
	ldr r0, [sp, #8]
	add r4, r1, r0
_021529A6:
	ldr r0, _021529E0 // =0x0217C300
	str r4, [r0]
	ldr r1, _021529E4 // =0x5D588B65
	str r1, [r0, #4]
	ldr r1, _021529E8 // =0x00269EC3
	str r1, [r0, #8]
	mov r1, #1
	ldr r0, _021529DC // =0x0217C2E8
	str r1, [r0]
_021529B8:
	ldr r0, _021529E0 // =0x0217C300
	ldr r3, [r0, #8]
	ldr r2, [r0, #4]
	ldr r1, [r0]
	mul r2, r1
	add r1, r3, r2
	str r1, [r0]
	lsr r1, r1, #0x10
	ldr r0, _021529EC // =0x00007FFF
	mul r1, r0
	lsr r0, r1, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	add sp, #0x10
	pop {r4}
	pop {r3}
	bx r3
	nop
_021529DC: .word 0x0217C2E8
_021529E0: .word 0x0217C300
_021529E4: .word 0x5D588B65
_021529E8: .word 0x00269EC3
_021529EC: .word 0x00007FFF
	thumb_func_end AOSS_Rand

	thumb_func_start ovl08_21529F0
ovl08_21529F0: // 0x021529F0
	mov r2, #0
	ldrsb r1, [r0, r2]
	cmp r1, #0
	beq _02152A00
_021529F8:
	add r2, r2, #1
	ldrsb r1, [r0, r2]
	cmp r1, #0
	bne _021529F8
_02152A00:
	mov r0, r2
	bx lr
	thumb_func_end ovl08_21529F0

	thumb_func_start ovl08_2152A04
ovl08_2152A04: // 0x02152A04
	asr r2, r0, #8
	mov r1, #0xff
	and r2, r1
	lsl r1, r0, #8
	ldr r0, _02152A18 // =0x0000FF00
	and r1, r0
	orr r2, r1
	lsl r0, r2, #0x10
	lsr r0, r0, #0x10
	bx lr
	.align 2, 0
_02152A18: .word 0x0000FF00
	thumb_func_end ovl08_2152A04

	thumb_func_start ovl08_2152A1C
ovl08_2152A1C: // 0x02152A1C
	push {r4}
	sub sp, #4
	lsl r1, r0, #0x18
	ldr r2, _02152A48 // =0xFF000000
	and r1, r2
	lsl r4, r0, #8
	ldr r2, _02152A4C // =0x00FF0000
	and r4, r2
	lsr r3, r0, #0x18
	mov r2, #0xff
	and r3, r2
	lsr r2, r0, #8
	ldr r0, _02152A50 // =0x0000FF00
	and r2, r0
	orr r3, r2
	orr r4, r3
	orr r1, r4
	mov r0, r1
	add sp, #4
	pop {r4}
	bx lr
	nop
_02152A48: .word 0xFF000000
_02152A4C: .word 0x00FF0000
_02152A50: .word 0x0000FF00
	thumb_func_end ovl08_2152A1C

	thumb_func_start ovl08_2152A54
ovl08_2152A54: // 0x02152A54
	asr r2, r0, #8
	mov r1, #0xff
	and r2, r1
	lsl r1, r0, #8
	ldr r0, _02152A68 // =0x0000FF00
	and r1, r0
	orr r2, r1
	lsl r0, r2, #0x10
	lsr r0, r0, #0x10
	bx lr
	.align 2, 0
_02152A68: .word 0x0000FF00
	thumb_func_end ovl08_2152A54

	thumb_func_start ovl08_2152A6C
ovl08_2152A6C: // 0x02152A6C
	push {r4}
	sub sp, #4
	lsl r1, r0, #0x18
	ldr r2, _02152A98 // =0xFF000000
	and r1, r2
	lsl r4, r0, #8
	ldr r2, _02152A9C // =0x00FF0000
	and r4, r2
	lsr r3, r0, #0x18
	mov r2, #0xff
	and r3, r2
	lsr r2, r0, #8
	ldr r0, _02152AA0 // =0x0000FF00
	and r2, r0
	orr r3, r2
	orr r4, r3
	orr r1, r4
	mov r0, r1
	thumb_func_end ovl08_2152A6C

	thumb_func_start ovl08_2152A90
ovl08_2152A90: // 0x02152A90
	add sp, #4
	pop {r4}
	bx lr
	nop
_02152A98: .word 0xFF000000
_02152A9C: .word 0x00FF0000
_02152AA0: .word 0x0000FF00
	thumb_func_end ovl08_2152A90

	thumb_func_start ovl08_2152AA4
ovl08_2152AA4: // 0x02152AA4
	ldr r3, _02152AA8 // =SOC_Close
	bx r3
	.align 2, 0
_02152AA8: .word SOC_Close
	thumb_func_end ovl08_2152AA4

	thumb_func_start ovl08_2152AAC
ovl08_2152AAC: // 0x02152AAC
	strb r2, [r1]
	ldr r3, _02152AB4 // =SOC_Bind
	bx r3
	nop
_02152AB4: .word SOC_Bind
	thumb_func_end ovl08_2152AAC

	thumb_func_start ovl08_2152AB8
ovl08_2152AB8: // 0x02152AB8
	ldr r3, _02152ABC // =SOC_Socket
	bx r3
	.align 2, 0
_02152ABC: .word SOC_Socket
	thumb_func_end ovl08_2152AB8

	thumb_func_start ovl08_2152AC0
ovl08_2152AC0: // 0x02152AC0
	bx lr
	.align 2, 0
	thumb_func_end ovl08_2152AC0

	thumb_func_start ovl08_2152AC4
ovl08_2152AC4: // 0x02152AC4
	push {r4, r5, lr}
	sub sp, #4
	ldr r5, [sp, #0x14]
	ldr r4, [sp, #0x10]
	strb r5, [r4]
	str r4, [sp]
	blx SOC_SendTo
	add sp, #4
	pop {r4, r5}
	pop {r3}
	bx r3
	thumb_func_end ovl08_2152AC4

	thumb_func_start ovl08_2152ADC
ovl08_2152ADC: // 0x02152ADC
	push {r4, r5, r6, lr}
	sub sp, #8
	ldr r5, [sp, #0x18]
	mov r4, #0
	ldr r2, [r1]
	ldr r0, [r1, #4]
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r5]
	ldr r1, _02152B24 // =0x01FF6210
	mul r0, r1
	mov r1, #0x40
	blx _s32_div_f
	asr r1, r0, #0x1f
	add r6, r4, r0
	adc r4, r1
	ldr r0, [r5, #4]
	ldr r1, _02152B24 // =0x01FF6210
	mul r0, r1
	mov r1, #0x40
	blx _s32_div_f
	asr r1, r0, #0x1f
	add r2, r6, r0
	adc r4, r1
	add r0, sp, #0
	mov r1, #1
	mov r3, r4
	blx SOC_Poll
	add sp, #8
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	nop
_02152B24: .word 0x01FF6210
	thumb_func_end ovl08_2152ADC

	thumb_func_start ovl08_2152B28
ovl08_2152B28: // 0x02152B28
	push {r4, r5, lr}
	sub sp, #4
	ldr r4, [sp, #0x14]
	ldr r5, [r4]
	ldr r4, [sp, #0x10]
	strb r5, [r4]
	str r4, [sp]
	blx sub_20BE9D8
	add sp, #4
	pop {r4, r5}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_2152B28

	thumb_func_start ovl08_2152B44
ovl08_2152B44: // 0x02152B44
	lsl r1, r1, #0x18
	lsr r1, r1, #0x18
	ldr r3, _02152B4C // =MI_CpuFill8
	bx r3
	.align 2, 0
_02152B4C: .word MI_CpuFill8
	thumb_func_end ovl08_2152B44

	thumb_func_start ovl08_2152B50
ovl08_2152B50: // 0x02152B50
	mov r3, r0
	mov r0, r1
	mov r1, r3
	ldr r3, _02152B5C // =MI_CpuCopy8
	bx r3
	nop
_02152B5C: .word MI_CpuCopy8
	thumb_func_end ovl08_2152B50

	thumb_func_start ovl08_2152B60
ovl08_2152B60: // 0x02152B60
	push {r4}
	sub sp, #4
	mov r4, #0
	b _02152B6C
_02152B68:
	add r0, r0, #1
	add r1, r1, #1
_02152B6C:
	mov r3, r2
	sub r2, r2, #1
	cmp r3, #0
	ble _02152B7E
	ldrb r4, [r0]
	ldrb r3, [r1]
	sub r4, r4, r3
	cmp r4, #0
	beq _02152B68
_02152B7E:
	mov r0, r4
	add sp, #4
	pop {r4}
	bx lr
	.align 2, 0
	thumb_func_end ovl08_2152B60

	thumb_func_start ovl08_2152B88
ovl08_2152B88: // 0x02152B88
	push {lr}
	sub sp, #4
	blx sub_20BE40C
	cmp r0, #0
	bge _02152B9E
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r3}
	bx r3
_02152B9E:
	bl ovl08_21552E4
	cmp r0, #0
	beq _02152BAA
	mov r0, #1
	b _02152BAC
_02152BAA:
	mov r0, #0
_02152BAC:
	neg r0, r0
	add sp, #4
	pop {r3}
	bx r3
	thumb_func_end ovl08_2152B88

	thumb_func_start ovl08_2152BB4
ovl08_2152BB4: // 0x02152BB4
	push {r4, r5, lr}
	sub sp, #4
	mov r5, r1
	mov r4, r2
	bl ovl08_2152A6C
	ldr r1, _02152C10 // =0x0217B050
	str r0, [r1, #0x10]
	mov r0, r5
	bl ovl08_2152A6C
	ldr r1, _02152C10 // =0x0217B050
	str r0, [r1, #0x14]
	mov r0, r4
	bl ovl08_2152A6C
	ldr r1, _02152C10 // =0x0217B050
	str r0, [r1, #0x18]
	mov r0, r1
	blx sub_20BE418
	cmp r0, #0
	bge _02152BEE
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5}
	pop {r3}
	bx r3
_02152BEE:
	ldr r5, _02152C14 // =0x0214587C
	ldr r0, [r5]
	cmp r0, #0
	bne _02152C04
	mov r4, #0x64
_02152BF8:
	mov r0, r4
	blx OS_Sleep
	ldr r0, [r5]
	cmp r0, #0
	beq _02152BF8
_02152C04:
	mov r0, #0
	add sp, #4
	pop {r4, r5}
	pop {r3}
	bx r3
	nop
_02152C10: .word 0x0217B050
_02152C14: .word 0x0214587C
	thumb_func_end ovl08_2152BB4

	thumb_func_start ovl08_2152C18
ovl08_2152C18: // 0x02152C18
	push {lr}
	sub sp, #4
	mov r0, r1
	ldr r1, _02152C2C // =0x0217D0B8
	ldr r1, [r1]
	blx r1
	add sp, #4
	pop {r3}
	bx r3
	nop
_02152C2C: .word 0x0217D0B8
	thumb_func_end ovl08_2152C18

	thumb_func_start ovl08_2152C30
ovl08_2152C30: // 0x02152C30
	push {lr}
	sub sp, #4
	cmp r1, #0
	ble _02152C46
	mov r0, r1
	ldr r1, _02152C50 // =0x0217D0AC
	ldr r1, [r1]
	blx r1
	add sp, #4
	pop {r3}
	bx r3
_02152C46:
	mov r0, #0
	add sp, #4
	pop {r3}
	bx r3
	nop
_02152C50: .word 0x0217D0AC
	thumb_func_end ovl08_2152C30

	thumb_func_start ovl08_2152C54
ovl08_2152C54: // 0x02152C54
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	mov r0, r6
	mov r1, #2
	blx _s32_div_f
	mov r7, r0
	mov r0, r4
	add r1, r5, r7
	mov r2, r7
	bl ovl08_2152B50
	add r0, r4, r7
	mov r1, r5
	mov r2, r7
	bl ovl08_2152B50
	mov r0, r5
	mov r1, r4
	mov r2, r6
	bl ovl08_2152B50
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_2152C54

	thumb_func_start sub_2152C90
sub_2152C90: // 0x02152C90
	push {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r1
	mov r0, r2
	mov r1, #2
	blx _s32_div_f
	mov r6, #0
	cmp r0, #0
	ble _02152CB4
_02152CA4:
	add r3, r0, r6
	ldrb r2, [r4, r3]
	ldrsb r1, [r5, r6]
	eor r2, r1
	strb r2, [r4, r3]
	add r6, r6, #1
	cmp r6, r0
	blt _02152CA4
_02152CB4:
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end sub_2152C90

	thumb_func_start ovl08_2152CBC
ovl08_2152CBC: // 0x02152CBC
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r6, r0
	mov r5, r1
	str r3, [sp]
	ldr r4, [sp, #0x18]
	mov r0, r2
	mov r1, #2
	blx _s32_div_f
	mov r7, r0
	mov r0, r6
	mov r1, r4
	blx _s32_div_f
	mov r2, r1
	mov r1, #0
	cmp r7, #0
	ble _02152CFE
	mov r6, r1
_02152CE4:
	strb r1, [r5, r1]
	ldrsb r0, [r5, r1]
	ldr r3, [sp]
	ldrsb r3, [r3, r2]
	add r2, r2, #1
	eor r0, r3
	strb r0, [r5, r1]
	cmp r2, r4
	blt _02152CF8
	mov r2, r6
_02152CF8:
	add r1, r1, #1
	cmp r1, r7
	blt _02152CE4
_02152CFE:
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_2152CBC

	thumb_func_start ovl08_2152D08
ovl08_2152D08: // 0x02152D08
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r7, r0
	mov r5, r1
	str r2, [sp, #4]
	str r3, [sp, #8]
	mov r0, r5
	mov r1, #2
	blx _s32_div_f
	bl ovl08_2154F38
	mov r6, r0
	cmp r6, #0
	bne _02152D32
	mov r0, #0
	mvn r0, r0
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02152D32:
	mov r0, r5
	bl ovl08_2154F38
	str r0, [sp, #0xc]
	cmp r0, #0
	bne _02152D50
	mov r0, r6
	bl ovl08_2154F24
	mov r0, #0
	mvn r0, r0
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02152D50:
	mov r4, #0
_02152D52:
	ldr r0, [sp, #8]
	str r0, [sp]
	mov r0, r4
	mov r1, r6
	mov r2, r5
	ldr r3, [sp, #4]
	bl ovl08_2152CBC
	mov r0, r6
	mov r1, r7
	mov r2, r5
	bl sub_2152C90
	mov r0, r7
	mov r1, r5
	ldr r2, [sp, #0xc]
	bl ovl08_2152C54
	add r4, r4, #1
	cmp r4, #2
	blt _02152D52
	mov r0, r6
	bl ovl08_2154F24
	ldr r0, [sp, #0xc]
	bl ovl08_2154F24
	mov r0, #0
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_2152D08

	thumb_func_start ovl08_2152D94
ovl08_2152D94: // 0x02152D94
	push {r4, r5, r6, r7}
	mov r6, #0
	mov r4, r6
	ldr r2, _02152DC8 // =0xEDB88320
	mov r3, #1
_02152D9E:
	mov r7, r6
	mov r5, r4
_02152DA2:
	mov r0, r7
	and r0, r3
	cmp r0, #0
	beq _02152DB0
	lsr r7, r7, #1
	eor r7, r2
	b _02152DB2
_02152DB0:
	lsr r7, r7, #1
_02152DB2:
	add r5, r5, #1
	cmp r5, #8
	blt _02152DA2
	stmia r1!, {r7}
	add r6, r6, #1
	ldr r0, _02152DCC // =0x00000100
	cmp r6, r0
	blt _02152D9E
	pop {r4, r5, r6, r7}
	bx lr
	nop
_02152DC8: .word 0xEDB88320
_02152DCC: .word 0x00000100
	thumb_func_end ovl08_2152D94

	thumb_func_start ovl08_2152DD0
ovl08_2152DD0: // 0x02152DD0
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	mov r7, r1
	mov r4, r2
	ldr r6, [sp, #0x18]
	cmp r3, #0
	bne _02152DE8
	mov r0, r3
	mov r1, r6
	bl ovl08_2152D94
_02152DE8:
	mov r1, #0
	cmp r4, #0
	ble _02152E06
	mov r2, #0xff
_02152DF0:
	lsr r0, r5, #8
	ldrb r3, [r7, r1]
	eor r5, r3
	and r5, r2
	lsl r3, r5, #2
	ldr r3, [r6, r3]
	mov r5, r0
	eor r5, r3
	add r1, r1, #1
	cmp r1, r4
	blt _02152DF0
_02152E06:
	mov r0, r5
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	thumb_func_end ovl08_2152DD0

	thumb_func_start ovl08_2152E10
ovl08_2152E10: // 0x02152E10
	push {r4, lr}
	sub sp, #8
	mov r4, r0
	mov r2, r1
	ldr r0, _02152E38 // =0x0217C60C
	str r0, [sp]
	mov r3, #0
	mvn r0, r3
	mov r1, r4
	bl ovl08_2152DD0
	mov r1, #0
	mvn r1, r1
	eor r0, r1
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	add sp, #8
	pop {r4}
	pop {r3}
	bx r3
	.align 2, 0
_02152E38: .word 0x0217C60C
	thumb_func_end ovl08_2152E10

	thumb_func_start ovl08_2152E3C
ovl08_2152E3C: // 0x02152E3C
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	ldr r4, [r5, #8]
	ldr r0, [r5, #0xc]
	str r0, [sp]
	ldr r0, [r5]
	add r0, r0, #1
	ldr r1, [sp]
	blx _u32_div_f
	lsl r0, r1, #0x18
	lsr r6, r0, #0x18
	ldrb r7, [r4, r6]
	ldr r0, [r5, #4]
	add r0, r7, r0
	ldr r1, [sp]
	blx _u32_div_f
	lsl r0, r1, #0x18
	lsr r1, r0, #0x18
	ldrb r0, [r4, r1]
	str r6, [r5]
	str r1, [r5, #4]
	strb r7, [r4, r1]
	strb r0, [r4, r6]
	add r0, r7, r0
	ldr r1, [r5, #0xc]
	blx _u32_div_f
	ldrb r0, [r4, r1]
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_2152E3C

	thumb_func_start ovl08_2152E84
ovl08_2152E84: // 0x02152E84
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	str r0, [sp]
	mov r5, r1
	mov r6, r2
	mov r7, r3
	mov r4, #0
	cmp r7, #0
	bls _02152EAC
_02152E96:
	ldr r0, [sp]
	bl ovl08_2152E3C
	lsl r0, r0, #0x18
	lsr r1, r0, #0x18
	ldrb r0, [r6, r4]
	eor r1, r0
	strb r1, [r5, r4]
	add r4, r4, #1
	cmp r4, r7
	blo _02152E96
_02152EAC:
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	thumb_func_end ovl08_2152E84

	thumb_func_start sub_2152EB4
sub_2152EB4: // 0x02152EB4
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	str r0, [sp]
	str r1, [sp, #4]
	str r2, [sp, #8]
	str r3, [sp, #0xc]
	ldr r5, [r0, #8]
	mov r0, #0
	ldr r1, [sp]
	str r0, [r1, #4]
	ldr r2, [r1, #4]
	str r2, [r1]
	lsl r2, r3, #0
	str r2, [r1, #0xc]
	lsl r1, r3, #0
	cmp r1, #0
	bls _02152EE0
_02152ED6:
	strb r0, [r5, r0]
	add r0, r0, #1
	ldr r1, [sp, #0xc]
	cmp r0, r1
	blo _02152ED6
_02152EE0:
	mov r1, #0
	mov r6, r1
	mov r4, r1
	ldr r0, [sp, #0xc]
	cmp r0, #0
	bls _02152F18
	str r1, [sp, #0x10]
_02152EEE:
	ldrb r7, [r5, r4]
	ldr r0, [sp, #4]
	ldrb r0, [r0, r6]
	add r0, r1, r0
	add r0, r7, r0
	ldr r1, [sp]
	ldr r1, [r1, #0xc]
	blx _u32_div_f
	ldrb r0, [r5, r1]
	strb r7, [r5, r1]
	strb r0, [r5, r4]
	add r6, r6, #1
	ldr r0, [sp, #8]
	cmp r6, r0
	blo _02152F10
	ldr r6, [sp, #0x10]
_02152F10:
	add r4, r4, #1
	ldr r0, [sp, #0xc]
	cmp r4, r0
	blo _02152EEE
_02152F18:
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	thumb_func_end sub_2152EB4

	thumb_func_start ovl08_2152F20
ovl08_2152F20: // 0x02152F20
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r7, r0
	mov r5, r1
	mov r4, r2
	mov r6, r3
	mov r0, r4
	bl ovl08_2154F38
	str r0, [sp, #8]
	cmp r0, #0
	bne _02152F4A
	mov r0, #2
	bl ovl08_2154278
	mov r0, #0
	mvn r0, r0
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02152F4A:
	ldr r0, _02152FAC // =0x0217C328
	ldr r1, [sp, #0x28]
	mov r2, #2
	bl ovl08_2152B50
	ldr r0, _02152FB0 // =0x0217C32A
	ldr r1, [sp, #0x2c]
	ldr r2, [sp, #0x30]
	bl ovl08_2152B50
	add r0, sp, #0
	ldr r1, _02152FAC // =0x0217C328
	ldr r2, [sp, #0x30]
	add r2, r2, #2
	mov r3, r4
	bl sub_2152EB4
	add r0, sp, #0
	mov r1, r5
	mov r2, r7
	mov r3, r4
	bl ovl08_2152E84
	mov r0, r5
	mov r1, r4
	bl ovl08_2152E10
	cmp r0, r6
	beq _02152F9C
	mov r0, #0x12
	bl ovl08_2154278
	ldr r0, [sp, #8]
	bl ovl08_2154F24
	mov r0, #0
	mvn r0, r0
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02152F9C:
	ldr r0, [sp, #8]
	bl ovl08_2154F24
	mov r0, #0
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02152FAC: .word 0x0217C328
_02152FB0: .word 0x0217C32A
	thumb_func_end ovl08_2152F20

	thumb_func_start ovl08_2152FB4
ovl08_2152FB4: // 0x02152FB4
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r6, r0
	mov r7, r1
	mov r5, r2
	mov r4, r3
	mov r1, r5
	bl ovl08_2152E10
	strb r0, [r4]
	mov r0, r5
	bl ovl08_2154F38
	str r0, [sp, #0xc]
	cmp r0, #0
	bne _02152FE0
	mov r0, #0
	mvn r0, r0
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02152FE0:
	bl AOSS_Rand
	add r1, sp, #0
	strh r0, [r1]
	ldr r0, [sp, #0x28]
	add r1, sp, #0
	mov r2, #2
	bl ovl08_2152B50
	ldr r0, _02153030 // =0x0217C328
	ldr r1, [sp, #0x28]
	mov r2, #2
	bl ovl08_2152B50
	ldr r0, _02153034 // =0x0217C32A
	ldr r1, [sp, #0x2c]
	ldr r2, [sp, #0x30]
	bl ovl08_2152B50
	add r0, sp, #4
	ldr r1, _02153030 // =0x0217C328
	ldr r2, [sp, #0x30]
	add r2, r2, #2
	mov r3, r5
	bl sub_2152EB4
	add r0, sp, #4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl ovl08_2152E84
	ldr r0, [sp, #0xc]
	bl ovl08_2154F24
	mov r0, #0
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02153030: .word 0x0217C328
_02153034: .word 0x0217C32A
	thumb_func_end ovl08_2152FB4

	thumb_func_start ovl08_2153038
ovl08_2153038: // 0x02153038
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r5, r0
	mov r6, r1
	mov r4, r2
	mov r7, r3
	add r0, sp, #8
	mov r1, #0
	mov r2, #8
	bl ovl08_2152B44
	mov r1, #2
	add r0, sp, #8
	strb r1, [r0, #1]
	ldr r0, _02153098 // =0x00005790
	bl ovl08_2152A54
	add r1, sp, #8
	strh r0, [r1, #2]
	ldr r0, _0215309C // =0x0217C30C
	ldr r0, [r0, #0x10]
	bl ovl08_2152A6C
	str r0, [sp, #0xc]
	cmp r4, #0xff
	beq _02153076
	ldr r1, _0215309C // =0x0217C30C
	mov r0, #0x18
	ldrsb r0, [r1, r0]
	cmp r0, #0
	bne _0215307C
_02153076:
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #0xc]
_0215307C:
	add r0, sp, #8
	str r0, [sp]
	mov r0, #8
	str r0, [sp, #4]
	mov r0, r7
	mov r1, r5
	mov r2, r6
	mov r3, #0
	bl ovl08_2152AC4
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02153098: .word 0x00005790
_0215309C: .word 0x0217C30C
	thumb_func_end ovl08_2153038

	thumb_func_start ovl08_21530A0
ovl08_21530A0: // 0x021530A0
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	mov r7, r3
	mov r0, #1
	bl ovl08_2152A54
	strh r0, [r5]
	mov r0, #0
	strh r0, [r5, #2]
	strh r0, [r5, #4]
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	bl ovl08_2152A54
	strh r0, [r5, #6]
	mov r0, #0
	strh r0, [r5, #8]
	lsl r0, r6, #0x10
	lsr r0, r0, #0x10
	bl ovl08_2152A54
	strh r0, [r5, #0xa]
	lsl r0, r7, #0x10
	lsr r0, r0, #0x10
	bl ovl08_2152A54
	strh r0, [r5, #0xc]
	add r1, sp, #8
	mov r0, #0x10
	ldrsb r0, [r1, r0]
	strb r0, [r5, #0xe]
	mov r0, #0x14
	ldrsb r0, [r1, r0]
	strb r0, [r5, #0xf]
	add r5, #0x10
	mov r0, r5
	ldr r1, [sp, #0x20]
	mov r2, #8
	bl ovl08_2152B50
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_21530A0

	thumb_func_start ovl08_2153100
ovl08_2153100: // 0x02153100
	push {r4, r5, lr}
	sub sp, #0xc
	mov r5, r1
	mov r4, r3
	cmp r0, #1
	bne _02153144
	mov r1, #1
	ldr r0, [sp, #0x18]
	strh r1, [r0]
	add r0, r5, #2
	str r0, [sp]
	ldr r0, _02153158 // =0x0217C2F8
	str r0, [sp, #4]
	mov r0, #8
	str r0, [sp, #8]
	mov r0, r2
	add r1, r5, #4
	mov r2, #0
	ldrsh r2, [r4, r2]
	ldr r3, [sp, #0x1c]
	bl ovl08_2152FB4
	ldrh r0, [r4]
	bl ovl08_2152A54
	strh r0, [r5]
	mov r0, #0
	ldrsh r0, [r4, r0]
	add r0, r0, #4
	strh r0, [r4]
	add sp, #0xc
	pop {r4, r5}
	pop {r3}
	bx r3
_02153144:
	mov r0, r5
	mov r1, r2
	mov r2, #0
	ldrsh r2, [r4, r2]
	bl ovl08_2152B50
	add sp, #0xc
	pop {r4, r5}
	pop {r3}
	bx r3
	.align 2, 0
_02153158: .word 0x0217C2F8
	thumb_func_end ovl08_2153100

	thumb_func_start ovl08_215315C
ovl08_215315C: // 0x0215315C
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	mov r6, #0
	ldr r1, _021531E4 // =0x0217C30C
	mov r0, #0x19
	ldrsb r0, [r1, r0]
	strb r0, [r5]
	mov r0, #1
	strb r0, [r5, #1]
	ldr r0, [r1, #4]
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	add r0, r5, #6
	ldr r1, [r1]
	mov r2, r4
	bl ovl08_2152B50
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	bl ovl08_2152A54
	strh r0, [r5, #2]
	add r0, r4, #6
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add r0, r0, #1
	mov r1, #2
	blx _s32_div_f
	lsl r0, r0, #0x11
	asr r7, r0, #0x10
	lsl r0, r7, #0x10
	lsr r0, r0, #0x10
	bl ovl08_2152A54
	strh r0, [r5, #4]
	add r0, r6, r7
	lsl r0, r0, #0x10
	asr r6, r0, #0x10
	add r4, r5, r7
	mov r0, #0x60
	strb r0, [r5, r7]
	mov r0, #0
	strb r0, [r4, #1]
	bl ovl08_2152A54
	strh r0, [r4, #4]
	mov r0, #0xe
	bl ovl08_2152A6C
	str r0, [sp]
	add r0, r4, #6
	add r1, sp, #0
	mov r2, #4
	bl ovl08_2152B50
	mov r0, #4
	bl ovl08_2152A54
	strh r0, [r4, #2]
	add r6, #0xa
	lsl r0, r6, #0x10
	asr r0, r0, #0x10
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_021531E4: .word 0x0217C30C
	thumb_func_end ovl08_215315C

	thumb_func_start ovl08_21531E8
ovl08_21531E8: // 0x021531E8
	push {r4, r5, r6, lr}
	sub sp, #0x18
	mov r5, r1
	mov r6, r2
	ldr r0, _02153248 // =0x0217C2F4
	ldr r4, [r0]
	mov r0, r4
	mov r1, #0
	ldr r2, _0215324C // =0x000005DC
	bl ovl08_2152B44
	add r0, sp, #0xc
	add r5, #0x10
	mov r1, r5
	mov r2, #8
	bl ovl08_2152B50
	ldr r0, _02153250 // =aMelco
	bl ovl08_21529F0
	mov r3, r0
	add r0, sp, #0xc
	mov r1, #8
	ldr r2, _02153250 // =aMelco
	bl ovl08_2152D08
	mov r2, #0
	str r2, [sp]
	mov r0, #0x11
	str r0, [sp, #4]
	add r0, sp, #0xc
	str r0, [sp, #8]
	mov r0, r4
	ldr r1, _02153254 // =0x00003000
	mov r3, r2
	bl ovl08_21530A0
	mov r0, r4
	mov r1, #0x18
	mov r2, #0
	mov r3, r6
	bl ovl08_2153038
	mov r0, #0
	add sp, #0x18
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	.align 2, 0
_02153248: .word 0x0217C2F4
_0215324C: .word 0x000005DC
_02153250: .word aMelco
_02153254: .word 0x00003000
	thumb_func_end ovl08_21531E8

	thumb_func_start ovl08_2153258
ovl08_2153258: // 0x02153258
	push {r4, r5, r6, lr}
	sub sp, #0x28
	mov r5, r1
	mov r6, r2
	mov r1, #0
	add r0, sp, #0xc
	strb r1, [r0]
	strh r1, [r0, #2]
	strh r1, [r0, #4]
	ldr r0, _02153334 // =0x0217C2F4
	ldr r4, [r0]
	add r0, sp, #0x1c
	mov r2, #8
	bl ovl08_2152B44
	mov r0, r4
	mov r1, #0
	ldr r2, _02153338 // =0x000005DC
	bl ovl08_2152B44
	mov r1, #2
	add r0, sp, #0xc
	strb r1, [r0, #0x10]
	mov r1, #0
	strb r1, [r0, #0x11]
	mov r0, #4
	bl ovl08_2152A54
	add r1, sp, #0xc
	strh r0, [r1, #0x12]
	ldr r0, _0215333C // =0x0217C30C
	ldr r0, [r0, #8]
	str r0, [sp, #0x20]
	bl ovl08_2152A6C
	str r0, [sp, #0x20]
	mov r1, #8
	add r0, sp, #0xc
	strh r1, [r0, #2]
	add r0, sp, #0x10
	str r0, [sp]
	add r0, sp, #0xc
	str r0, [sp, #4]
	ldr r0, _02153340 // =_0217C2E0
	ldr r0, [r0]
	mov r1, r4
	add r1, #0x18
	add r2, sp, #0x1c
	add r3, sp, #0xc
	add r3, #2
	bl ovl08_2153100
	add r0, sp, #0x10
	add r0, #2
	add r5, #8
	mov r1, r5
	mov r2, #8
	bl ovl08_2152B50
	add r0, sp, #0x10
	add r0, #2
	mov r1, #8
	ldr r2, _02153344 // =aMelco
	mov r3, #6
	bl ovl08_2152D08
	cmp r0, #0
	beq _021532F2
	mov r0, #2
	bl ovl08_2154278
	mov r0, #0
	mvn r0, r0
	add sp, #0x28
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_021532F2:
	add r3, sp, #0xc
	mov r0, #0
	ldrsb r0, [r3, r0]
	str r0, [sp]
	mov r0, #0x11
	str r0, [sp, #4]
	add r0, sp, #0x10
	add r0, #2
	str r0, [sp, #8]
	mov r0, r4
	ldr r1, _02153348 // =0x00002000
	mov r2, #2
	ldrsh r2, [r3, r2]
	mov r5, #4
	ldrsh r3, [r3, r5]
	bl ovl08_21530A0
	add r2, sp, #0xc
	mov r1, #2
	ldrsh r0, [r2, r1]
	add r0, #0x18
	strh r0, [r2, #2]
	mov r0, r4
	ldrsh r1, [r2, r1]
	mov r2, #0
	mov r3, r6
	bl ovl08_2153038
	mov r0, #0
	add sp, #0x28
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	.align 2, 0
_02153334: .word 0x0217C2F4
_02153338: .word 0x000005DC
_0215333C: .word 0x0217C30C
_02153340: .word _0217C2E0
_02153344: .word aMelco
_02153348: .word 0x00002000
	thumb_func_end ovl08_2153258

	thumb_func_start ovl08_215334C
ovl08_215334C: // 0x0215334C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	mov r7, r1
	str r2, [sp, #0xc]
	mov r1, #0
	add r0, sp, #0x10
	strb r1, [r0]
	strh r1, [r0, #2]
	strh r1, [r0, #4]
	ldr r0, _0215348C // =0x0217C2F4
	ldr r5, [r0]
	mov r0, r5
	ldr r2, _02153490 // =0x000005DC
	bl ovl08_2152B44
	ldr r0, _02153494 // =0x00000210
	bl ovl08_2154F38
	mov r4, r0
	cmp r4, #0
	bne _02153388
	mov r0, #2
	bl ovl08_2154278
	mov r0, #0
	mvn r0, r0
	add sp, #0x24
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153388:
	mov r1, #0
	ldr r2, _02153494 // =0x00000210
	bl ovl08_2152B44
	mov r6, r5
	add r6, #0x18
	ldr r0, _02153498 // =0x0217C2F8
	mov r1, r7
	mov r2, #8
	bl ovl08_2152B50
	add r0, sp, #0x14
	add r0, #2
	ldr r1, _02153498 // =0x0217C2F8
	mov r2, #8
	bl ovl08_2152B50
	add r0, r4, #4
	bl ovl08_215315C
	add r1, sp, #0x10
	strh r0, [r1, #2]
	mov r0, #2
	ldrsh r0, [r1, r0]
	cmp r0, #0
	bge _021533D8
	mov r0, #3
	bl ovl08_2154278
	cmp r4, #0
	beq _021533CC
	mov r0, r4
	bl ovl08_2154F24
_021533CC:
	mov r0, #0
	mvn r0, r0
	add sp, #0x24
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021533D8:
	mov r0, #0
	strb r0, [r4]
	ldrh r0, [r1, #2]
	bl ovl08_2152A54
	strh r0, [r4, #2]
	add r1, sp, #0x10
	mov r0, #2
	ldrsh r0, [r1, r0]
	add r0, r0, #4
	strh r0, [r1, #2]
	add r0, sp, #0x14
	str r0, [sp]
	add r0, sp, #0x10
	str r0, [sp, #4]
	mov r0, #0
	mov r1, r6
	mov r2, r4
	add r3, sp, #0x10
	add r3, #2
	bl ovl08_2153100
	add r1, sp, #0x10
	mov r0, #4
	ldrsh r2, [r1, r0]
	mov r0, #0x10
	orr r2, r0
	strh r2, [r1, #4]
	add r0, sp, #0x14
	add r0, #2
	mov r1, #8
	ldr r2, _0215349C // =aMelco
	mov r3, #6
	bl ovl08_2152D08
	cmp r0, #0
	beq _0215343E
	mov r0, #2
	bl ovl08_2154278
	cmp r4, #0
	beq _02153432
	mov r0, r4
	bl ovl08_2154F24
_02153432:
	mov r0, #0
	mvn r0, r0
	add sp, #0x24
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215343E:
	add r3, sp, #0x10
	mov r0, #0
	ldrsb r0, [r3, r0]
	str r0, [sp]
	mov r0, #0x11
	str r0, [sp, #4]
	add r0, sp, #0x14
	add r0, #2
	str r0, [sp, #8]
	mov r0, r5
	ldr r1, _021534A0 // =0x00001000
	mov r2, #2
	ldrsh r2, [r3, r2]
	mov r6, #4
	ldrsh r3, [r3, r6]
	bl ovl08_21530A0
	add r2, sp, #0x10
	mov r1, #2
	ldrsh r0, [r2, r1]
	add r0, #0x18
	strh r0, [r2, #2]
	mov r0, r5
	ldrsh r1, [r2, r1]
	mov r2, #0xff
	ldr r3, [sp, #0xc]
	bl ovl08_2153038
	cmp r4, #0
	beq _02153480
	mov r0, r4
	bl ovl08_2154F24
_02153480:
	mov r0, #0
	add sp, #0x24
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_0215348C: .word 0x0217C2F4
_02153490: .word 0x000005DC
_02153494: .word 0x00000210
_02153498: .word 0x0217C2F8
_0215349C: .word aMelco
_021534A0: .word 0x00001000
	thumb_func_end ovl08_215334C

	thumb_func_start ovl08_21534A4
ovl08_21534A4: // 0x021534A4
	push {r4, r5, r6, lr}
	mov r5, r1
	mov r4, r2
	mov r6, r3
	cmp r0, #0
	beq _021534BA
	cmp r0, #1
	beq _021534D0
	cmp r0, #2
	beq _021534E6
	b _021534FC
_021534BA:
	mov r0, #2
	bl ovl08_2153EF4
	mov r0, r5
	mov r1, r4
	mov r2, r6
	bl ovl08_215334C
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_021534D0:
	mov r0, #3
	bl ovl08_2153EF4
	mov r0, r5
	mov r1, r4
	mov r2, r6
	bl ovl08_2153258
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_021534E6:
	mov r0, #5
	bl ovl08_2153EF4
	mov r0, r5
	mov r1, r4
	mov r2, r6
	bl ovl08_21531E8
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_021534FC:
	mov r0, #0
	mvn r0, r0
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_21534A4

	thumb_func_start ovl08_2153508
ovl08_2153508: // 0x02153508
	mov r2, #0
	mov r1, #0x10
	and r0, r1
	cmp r0, #0
	beq _02153514
	mov r2, #1
_02153514:
	mov r0, r2
	bx lr
	thumb_func_end ovl08_2153508

	thumb_func_start ovl08_2153518
ovl08_2153518: // 0x02153518
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	str r0, [sp]
	mov r4, r1
	mov r6, r2
	str r3, [sp, #4]
	mov r5, #0
	cmp r6, #0
	bgt _02153536
	mov r0, #1
	mvn r0, r0
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153536:
	ldr r1, _02153624 // =0x0217B040
	add r7, r1, r0
_0215353A:
	mov r2, r4
	ldrb r1, [r4]
	ldrb r0, [r7]
	cmp r1, r0
	beq _02153560
	ldrh r0, [r4, #2]
	bl ovl08_2152A04
	add r0, r0, #4
	add r4, r4, r0
	sub r6, r6, r0
	cmp r6, #0
	bgt _0215353A
	mov r0, #3
	mvn r0, r0
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153560:
	add r4, r4, #4
	ldrh r0, [r2, #2]
	bl ovl08_2152A04
	mov r7, r0
	ldr r0, _02153628 // =0x00000350
	ldr r1, [sp]
	mul r1, r0
	ldr r0, [sp, #4]
	add r6, r0, r1
	ldr r0, [sp, #0x28]
	ldr r1, [sp]
	add r1, r1, #3
	lsl r1, r1, #7
	add r0, r0, r1
	str r0, [sp, #8]
	mov r0, #2
	mvn r0, r0
	str r0, [sp, #0xc]
_02153586:
	ldrb r0, [r4]
	cmp r0, #0xa
	bhi _021535FA
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #8]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add r0, pc
	bx r0
_0215359A: // jump table
	.hword _021535FA - _0215359A + 1 // case 0
	.hword _021535FA - _0215359A + 1 // case 1
	.hword _021535FA - _0215359A + 1 // case 2
	.hword _021535B0 - _0215359A + 1 // case 3
	.hword _021535C0 - _0215359A + 1 // case 4
	.hword _021535D0 - _0215359A + 1 // case 5
	.hword _021535E0 - _0215359A + 1 // case 6
	.hword _021535FA - _0215359A + 1 // case 7
	.hword _021535FA - _0215359A + 1 // case 8
	.hword _021535FA - _0215359A + 1 // case 9
	.hword _021535F0 - _0215359A + 1 // case 10
_021535B0:
	mov r0, r4
	mov r1, r6
	add r1, #8
	bl ovl08_2153750
	mov r1, #1
	orr r5, r1
	b _021535FC
_021535C0:
	mov r0, r4
	ldr r1, _0215362C // =0x00000138
	add r1, r6, r1
	bl ovl08_2153750
	mov r1, #2
	orr r5, r1
	b _021535FC
_021535D0:
	mov r0, r4
	ldr r1, _02153630 // =0x00000268
	add r1, r6, r1
	bl ovl08_2153680
	mov r1, #4
	orr r5, r1
	b _021535FC
_021535E0:
	mov r0, r4
	ldr r1, _02153634 // =0x000002D8
	add r1, r6, r1
	bl ovl08_2153680
	mov r1, #8
	orr r5, r1
	b _021535FC
_021535F0:
	mov r0, r4
	ldr r1, [sp, #8]
	bl ovl08_215363C
	b _021535FC
_021535FA:
	ldr r0, [sp, #0xc]
_021535FC:
	cmp r0, #0
	bne _0215361A
	ldrh r0, [r4, #2]
	bl ovl08_2152A04
	add r0, r0, #4
	add r4, r4, r0
	sub r7, r7, r0
	cmp r7, #0
	bgt _02153586
	ldr r0, _02153638 // =0x0217C30C
	ldr r1, [r0, #0xc]
	orr r1, r5
	str r1, [r0, #0xc]
	mov r0, #0
_0215361A:
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_02153624: .word 0x0217B040
_02153628: .word 0x00000350
_0215362C: .word 0x00000138
_02153630: .word 0x00000268
_02153634: .word 0x000002D8
_02153638: .word 0x0217C30C
	thumb_func_end ovl08_2153518

	thumb_func_start ovl08_215363C
ovl08_215363C: // 0x0215363C
	push {r4, r5, lr}
	sub sp, #4
	mov r5, r1
	add r4, r0, #6
	ldrh r0, [r4, #2]
	bl ovl08_2152A04
	mov r2, r0
	cmp r2, #0
	bgt _0215365C
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5}
	pop {r3}
	bx r3
_0215365C:
	ldrb r0, [r4]
	cmp r0, #0x70
	beq _0215366E
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5}
	pop {r3}
	bx r3
_0215366E:
	mov r0, r5
	add r1, r4, #6
	bl ovl08_2152B50
	mov r0, #0
	add sp, #4
	pop {r4, r5}
	pop {r3}
	bx r3
	thumb_func_end ovl08_215363C

	thumb_func_start ovl08_2153680
ovl08_2153680: // 0x02153680
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r7, r0
	mov r6, r1
	add r5, r7, #6
_0215368A:
	ldrh r0, [r5, #2]
	bl ovl08_2152A04
	mov r4, r0
	ldrb r0, [r5]
	cmp r0, #0x35
	bgt _021536A2
	cmp r0, #0x35
	bge _021536C2
	cmp r0, #0x30
	beq _021536B2
	b _021536D2
_021536A2:
	cmp r0, #0x40
	bgt _021536AC
	cmp r0, #0x40
	beq _021536B2
	b _021536D2
_021536AC:
	cmp r0, #0x45
	beq _021536C2
	b _021536D2
_021536B2:
	cmp r4, #0x40
	bls _021536D2
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021536C2:
	cmp r4, #0x21
	bls _021536D2
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021536D2:
	cmp r0, #0x35
	bgt _021536E0
	cmp r0, #0x35
	bge _02153700
	cmp r0, #0x30
	beq _021536F0
	b _02153728
_021536E0:
	cmp r0, #0x40
	bgt _021536EA
	cmp r0, #0x40
	beq _021536F0
	b _02153728
_021536EA:
	cmp r0, #0x45
	beq _02153700
	b _02153728
_021536F0:
	mov r0, r6
	add r0, #0x30
	add r1, r5, #6
	mov r2, r4
	bl ovl08_2152B50
	str r4, [r6, #4]
	b _02153734
_02153700:
	cmp r4, #0
	beq _0215371A
	sub r0, r4, #1
	add r0, r5, r0
	ldrb r0, [r0, #6]
	cmp r0, #0
	beq _0215371A
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215371A:
	mov r0, r6
	add r0, #8
	add r1, r5, #6
	mov r2, r4
	bl ovl08_2152B50
	b _02153734
_02153728:
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153734:
	ldrh r0, [r5, #4]
	cmp r0, #0
	beq _02153744
	bl ovl08_2152A04
	add r1, r7, #6
	add r5, r1, r0
	b _0215368A
_02153744:
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_2153680

	thumb_func_start ovl08_2153750
ovl08_2153750: // 0x02153750
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r7, r0
	mov r6, r1
	add r5, r7, #6
_0215375A:
	ldrh r0, [r5, #2]
	bl ovl08_2152A04
	mov r4, r0
	ldrb r0, [r5]
	cmp r0, #0x21
	bgt _02153798
	cmp r0, #0x21
	bge _021537BC
	cmp r0, #0x15
	bgt _02153792
	mov r1, r0
	sub r1, #0x10
	cmp r1, #0
	blt _021537DC
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #8]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add r1, pc
	bx r1
_02153786: // jump table
	.hword _021537AC - _02153786 + 1 // case 0
	.hword _021537AC - _02153786 + 1 // case 1
	.hword _021537AC - _02153786 + 1 // case 2
	.hword _021537AC - _02153786 + 1 // case 3
	.hword _021537DC - _02153786 + 1 // case 4
	.hword _021537CC - _02153786 + 1 // case 5
_02153792:
	cmp r0, #0x20
	beq _021537BC
	b _021537DC
_02153798:
	cmp r0, #0x23
	bgt _021537A6
	cmp r0, #0x23
	bge _021537BC
	cmp r0, #0x22
	beq _021537BC
	b _021537DC
_021537A6:
	cmp r0, #0x25
	beq _021537CC
	b _021537DC
_021537AC:
	cmp r4, #5
	bls _021537DC
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021537BC:
	cmp r4, #0xd
	bls _021537DC
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021537CC:
	cmp r4, #0x21
	bls _021537DC
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021537DC:
	cmp r0, #0x21
	bgt _02153810
	cmp r0, #0x21
	bge _02153834
	cmp r0, #0x15
	bgt _0215380A
	mov r1, r0
	sub r1, #0x10
	cmp r1, #0
	blt _0215388C
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #8]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add r1, pc
	bx r1
_021537FE: // jump table
	.hword _02153824 - _021537FE + 1 // case 0
	.hword _02153834 - _021537FE + 1 // case 1
	.hword _02153844 - _021537FE + 1 // case 2
	.hword _02153854 - _021537FE + 1 // case 3
	.hword _0215388C - _021537FE + 1 // case 4
	.hword _02153864 - _021537FE + 1 // case 5
_0215380A:
	cmp r0, #0x20
	beq _02153824
	b _0215388C
_02153810:
	cmp r0, #0x23
	bgt _0215381E
	cmp r0, #0x23
	bge _02153854
	cmp r0, #0x22
	beq _02153844
	b _0215388C
_0215381E:
	cmp r0, #0x25
	beq _02153864
	b _0215388C
_02153824:
	mov r0, r6
	add r0, #0x30
	add r1, r5, #6
	mov r2, r4
	bl ovl08_2152B50
	str r4, [r6, #4]
	b _02153898
_02153834:
	mov r0, r6
	add r0, #0x70
	add r1, r5, #6
	mov r2, r4
	bl ovl08_2152B50
	str r4, [r6, #4]
	b _02153898
_02153844:
	mov r0, r6
	add r0, #0xb0
	add r1, r5, #6
	mov r2, r4
	bl ovl08_2152B50
	str r4, [r6, #4]
	b _02153898
_02153854:
	mov r0, r6
	add r0, #0xf0
	add r1, r5, #6
	mov r2, r4
	bl ovl08_2152B50
	str r4, [r6, #4]
	b _02153898
_02153864:
	cmp r4, #0
	beq _0215387E
	sub r0, r4, #1
	add r0, r5, r0
	ldrb r0, [r0, #6]
	cmp r0, #0
	beq _0215387E
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215387E:
	mov r0, r6
	add r0, #8
	add r1, r5, #6
	mov r2, r4
	bl ovl08_2152B50
	b _02153898
_0215388C:
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153898:
	ldrh r0, [r5, #4]
	cmp r0, #0
	beq _021538A8
	bl ovl08_2152A04
	add r1, r7, #6
	add r5, r1, r0
	b _0215375A
_021538A8:
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_2153750

	thumb_func_start ovl08_21538B4
ovl08_21538B4: // 0x021538B4
	push {r4, r5}
	mov r5, #0
	sub r2, r1, #1
	add r3, r0, r2
	mov r4, r5
	cmp r1, #0
	ble _021538D0
_021538C2:
	lsl r2, r5, #8
	ldrb r0, [r3]
	sub r3, r3, #1
	add r5, r2, r0
	add r4, r4, #1
	cmp r4, r1
	blt _021538C2
_021538D0:
	mov r0, r5
	pop {r4, r5}
	bx lr
	.align 2, 0
	thumb_func_end ovl08_21538B4

	thumb_func_start ovl08_21538D8
ovl08_21538D8: // 0x021538D8
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r6, r0
	mov r5, r1
	mov r0, r5
	mov r1, #0
	ldr r2, _021539A4 // =0x00000104
	bl ovl08_2152B44
	mov r4, r6
	ldr r7, _021539A8 // =0x0217C30C
_021538EE:
	ldrh r0, [r4, #2]
	bl ovl08_2152A04
	mov r2, r0
	cmp r2, #0
	bgt _02153906
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153906:
	ldrb r0, [r4]
	cmp r0, #6
	bhi _02153980
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #8]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add r0, pc
	bx r0
_0215391A: // jump table
	.hword _02153928 - _0215391A + 1 // case 0
	.hword _02153932 - _0215391A + 1 // case 1
	.hword _0215393E - _0215391A + 1 // case 2
	.hword _0215394A - _0215391A + 1 // case 3
	.hword _0215394A - _0215391A + 1 // case 4
	.hword _02153960 - _0215391A + 1 // case 5
	.hword _02153970 - _0215391A + 1 // case 6
_02153928:
	mov r0, r5
	add r1, r4, #6
	bl ovl08_2152B50
	b _0215398C
_02153932:
	mov r0, r5
	add r0, #0x80
	add r1, r4, #6
	bl ovl08_2152B50
	b _0215398C
_0215393E:
	ldr r0, _021539AC // =0x00000100
	add r0, r5, r0
	add r1, r4, #6
	bl ovl08_2152B50
	b _0215398C
_0215394A:
	ldrb r0, [r4, #6]
	bl ovl08_2152A04
	cmp r0, #0
	bgt _0215398C
	mov r0, #1
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153960:
	add r0, r4, #6
	mov r1, r2
	bl ovl08_21538B4
	bl ovl08_2152A1C
	str r0, [r7, #0x10]
	b _0215398C
_02153970:
	add r0, r4, #6
	mov r1, r2
	bl ovl08_21538B4
	bl ovl08_2152A1C
	str r0, [r7, #0x14]
	b _0215398C
_02153980:
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215398C:
	ldrh r0, [r4, #4]
	cmp r0, #0
	beq _0215399A
	bl ovl08_2152A04
	add r4, r6, r0
	b _021538EE
_0215399A:
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_021539A4: .word 0x00000104
_021539A8: .word 0x0217C30C
_021539AC: .word 0x00000100
	thumb_func_end ovl08_21538D8

	thumb_func_start ovl08_21539B0
ovl08_21539B0: // 0x021539B0
	push {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, #0
	ldr r0, _02153A00 // =aMelco
	bl ovl08_21529F0
	mov r3, r0
	mov r0, r5
	mov r1, #8
	ldr r2, _02153A00 // =aMelco
	bl ovl08_2152D08
	mov r0, r6
	mov r1, r5
	mov r2, #6
	bl ovl08_2152B60
	cmp r0, #0
	beq _021539DE
	lsl r0, r4, #0
	mvn r4, r0
	b _021539F6
_021539DE:
	ldrh r0, [r6, #6]
	bl ovl08_2152A04
	mov r6, r0
	ldrh r0, [r5, #6]
	bl ovl08_2152A04
	add r1, r6, #1
	cmp r1, r0
	beq _021539F6
	mov r0, #1
	mvn r4, r0
_021539F6:
	mov r0, r4
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	nop
_02153A00: .word aMelco
	thumb_func_end ovl08_21539B0

	thumb_func_start ovl08_2153A04
ovl08_2153A04: // 0x02153A04
	push {r4, r5, r6, lr}
	mov r4, #0
	mov r5, r4
	mov r6, r4
	ldr r3, _02153A44 // =0x0217C2F8
_02153A0E:
	ldrb r2, [r3]
	cmp r2, #0
	beq _02153A18
	mov r5, #1
	b _02153A20
_02153A18:
	add r3, r3, #1
	add r6, r6, #1
	cmp r6, #6
	blt _02153A0E
_02153A20:
	cmp r5, #0
	beq _02153A34
	ldr r0, _02153A44 // =0x0217C2F8
	mov r2, #6
	bl ovl08_2152B60
	cmp r0, #0
	beq _02153A3C
	mov r4, #1
	b _02153A3C
_02153A34:
	ldr r1, _02153A48 // =0x00001000
	cmp r0, r1
	beq _02153A3C
	mov r4, #2
_02153A3C:
	mov r0, r4
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	.align 2, 0
_02153A44: .word 0x0217C2F8
_02153A48: .word 0x00001000
	thumb_func_end ovl08_2153A04

	thumb_func_start ovl08_2153A4C
ovl08_2153A4C: // 0x02153A4C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r5, r0
	mov r4, r5
	add r4, #0x18
	add r0, sp, #0xc
	mov r1, r5
	add r1, #0x10
	mov r2, #8
	bl ovl08_2152B50
	ldr r0, _02153B50 // =aMelco
	bl ovl08_21529F0
	mov r3, r0
	add r0, sp, #0xc
	mov r1, #8
	ldr r2, _02153B50 // =aMelco
	bl ovl08_2152D08
	mov r1, #0
	mvn r1, r1
	cmp r0, r1
	bne _02153A8E
	mov r0, #2
	bl ovl08_2154278
	mov r0, #0x63
	mvn r0, r0
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153A8E:
	ldrh r0, [r5, #6]
	bl ovl08_2152A04
	add r1, sp, #0xc
	bl ovl08_2153A04
	cmp r0, #0
	bne _02153B48
	ldrh r0, [r5, #6]
	bl ovl08_2152A04
	ldr r1, _02153B54 // =0x00001000
	cmp r0, r1
	bne _02153AB4
	ldr r0, _02153B58 // =0x0217C2F8
	add r1, sp, #0xc
	mov r2, #8
	bl ovl08_2152B50
_02153AB4:
	ldrh r0, [r5, #0xc]
	bl ovl08_2152A04
	mov r1, #0xf
	and r0, r1
	cmp r0, #0
	bne _02153ACC
	mov r0, #0
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153ACC:
	ldrh r0, [r4]
	bl ovl08_2152A04
	mov r6, r0
	bl ovl08_2154F38
	mov r7, r0
	cmp r7, #0
	bne _02153AEE
	mov r0, #2
	bl ovl08_2154278
	mov r0, #0x64
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153AEE:
	add r0, r4, #2
	str r0, [sp]
	ldr r0, _02153B58 // =0x0217C2F8
	str r0, [sp, #4]
	mov r0, #8
	str r0, [sp, #8]
	add r0, r4, #4
	mov r1, r7
	mov r2, r6
	ldrb r3, [r5, #0xe]
	bl ovl08_2152F20
	cmp r0, #0
	bge _02153B2C
	mov r0, r7
	bl ovl08_2154F24
	bl ovl08_215426C
	cmp r0, #2
	bne _02153B22
	mov r0, #0x64
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153B22:
	mov r0, #0xc8
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153B2C:
	mov r0, r4
	mov r1, r7
	mov r2, r6
	bl ovl08_2152B50
	lsl r0, r6, #0x10
	lsr r0, r0, #0x10
	bl ovl08_2152A54
	strh r0, [r5, #0xa]
	mov r0, r7
	bl ovl08_2154F24
	mov r0, #0
_02153B48:
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02153B50: .word aMelco
_02153B54: .word 0x00001000
_02153B58: .word 0x0217C2F8
	thumb_func_end ovl08_2153A4C

	thumb_func_start ovl08_2153B5C
ovl08_2153B5C: // 0x02153B5C
	push {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r2
	cmp r6, #2
	beq _02153B72
	ldr r1, [r5]
	add r1, r1, #1
	str r1, [r5]
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_02153B72:
	mov r4, r1
	add r4, #0x24
	add r3, #0x10
	mov r0, r3
	add r1, #0xc
	add r1, #0x10
	bl ovl08_21539B0
	cmp r0, #0
	bge _02153B94
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	mov r0, r6
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_02153B94:
	ldrb r0, [r4]
	cmp r0, #7
	beq _02153BA8
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	mov r0, r6
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_02153BA8:
	ldrh r0, [r4, #2]
	bl ovl08_2152A04
	cmp r0, #0
	bne _02153BC0
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	mov r0, r6
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_02153BC0:
	ldr r0, [r4, #4]
	bl ovl08_2152A1C
	cmp r0, #0
	bne _02153BD2
	mov r0, #0x64
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_02153BD2:
	ldr r0, [r4, #4]
	bl ovl08_2152A1C
	mov r1, #1
	mvn r1, r1
	cmp r0, r1
	bne _02153BF0
	mov r0, #0x14
	bl ovl08_2154278
	mov r0, #0
	mvn r0, r0
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_02153BF0:
	ldr r0, [r4, #4]
	bl ovl08_2152A1C
	mov r1, #2
	mvn r1, r1
	cmp r0, r1
	bne _02153C0E
	mov r0, #0x15
	bl ovl08_2154278
	mov r0, #0
	mvn r0, r0
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_02153C0E:
	mov r0, #0x18
	bl ovl08_2154278
	mov r0, #0
	mvn r0, r0
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_2153B5C

	thumb_func_start ovl08_2153C20
ovl08_2153C20: // 0x02153C20
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r6, r0
	mov r5, r2
	cmp r6, #1
	beq _02153C3A
	ldr r1, [r5]
	add r1, r1, #1
	str r1, [r5]
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153C3A:
	mov r7, r1
	add r7, #0xc
	mov r4, r1
	add r4, #0x24
	add r3, #8
	mov r0, r3
	mov r1, r7
	add r1, #0x10
	bl ovl08_21539B0
	cmp r0, #0
	bge _02153C62
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	mov r0, r6
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153C62:
	ldrh r0, [r4, #2]
	bl ovl08_2152A04
	cmp r0, #0
	bne _02153C7C
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	mov r0, r6
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153C7C:
	ldrb r0, [r4]
	cmp r0, #7
	bne _02153CC0
	ldr r0, [r4, #4]
	bl ovl08_2152A1C
	mov r1, #1
	mvn r1, r1
	cmp r0, r1
	bne _02153C98
	mov r0, #0x14
	bl ovl08_2154278
	b _02153CB4
_02153C98:
	ldr r0, [r4, #4]
	bl ovl08_2152A1C
	mov r1, #2
	mvn r1, r1
	cmp r0, r1
	bne _02153CAE
	mov r0, #0x15
	bl ovl08_2154278
	b _02153CB4
_02153CAE:
	mov r0, #0x18
	bl ovl08_2154278
_02153CB4:
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153CC0:
	ldr r0, _02153D18 // =0x0217CA0C
	mov r1, #0
	ldr r2, _02153D1C // =0x000006A0
	bl ovl08_2152B44
	ldrh r0, [r7, #0xa]
	bl ovl08_2152A04
	mov r2, r0
	ldr r0, _02153D20 // =0x0217C38C
	str r0, [sp]
	mov r0, #0
	mov r1, r4
	ldr r3, _02153D18 // =0x0217CA0C
	bl ovl08_2153518
	cmp r0, #0
	bge _02153CF4
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	mov r0, r6
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153CF4:
	ldr r0, _02153D24 // =0x0217C30C
	ldr r1, [r0, #0xc]
	ldr r0, [r0, #8]
	and r1, r0
	cmp r1, #0
	bne _02153D0A
	mov r0, r6
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153D0A:
	mov r0, #0
	str r0, [r5]
	mov r0, #2
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02153D18: .word 0x0217CA0C
_02153D1C: .word 0x000006A0
_02153D20: .word 0x0217C38C
_02153D24: .word 0x0217C30C
	thumb_func_end ovl08_2153C20

	thumb_func_start ovl08_2153D28
ovl08_2153D28: // 0x02153D28
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r6, r0
	mov r5, r2
	cmp r6, #0
	beq _02153D42
	ldr r1, [r5]
	add r1, r1, #1
	str r1, [r5]
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153D42:
	mov r7, r1
	add r7, #0xc
	mov r4, r1
	add r4, #0x24
	mov r0, r3
	mov r1, r7
	add r1, #0x10
	bl ovl08_21539B0
	cmp r0, #0
	bge _02153D68
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	mov r0, r6
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153D68:
	ldrh r0, [r4, #2]
	bl ovl08_2152A04
	cmp r0, #0
	bne _02153D82
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	mov r0, r6
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153D82:
	ldrb r0, [r4]
	cmp r0, #7
	bne _02153DC8
	add r5, r4, #4
	ldr r0, [r4, #4]
	bl ovl08_2152A1C
	mov r1, #1
	mvn r1, r1
	cmp r0, r1
	bne _02153DA0
	mov r0, #0x14
	bl ovl08_2154278
	b _02153DBC
_02153DA0:
	ldr r0, [r5]
	bl ovl08_2152A1C
	mov r1, #2
	mvn r1, r1
	cmp r0, r1
	bne _02153DB6
	mov r0, #0x15
	bl ovl08_2154278
	b _02153DBC
_02153DB6:
	mov r0, #0x18
	bl ovl08_2154278
_02153DBC:
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153DC8:
	cmp r0, #1
	beq _02153DDC
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	mov r0, r6
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153DDC:
	add r0, r4, #4
	ldr r1, _02153E30 // =0x0217C38C
	bl ovl08_21538D8
	cmp r0, #0
	bge _02153E12
	mov r1, #1
	mvn r1, r1
	cmp r0, r1
	bne _02153E02
	mov r0, #0x16
	bl ovl08_2154278
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153E02:
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	mov r0, r6
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153E12:
	ldrh r0, [r7, #0xc]
	bl ovl08_2152A04
	bl ovl08_2153508
	ldr r1, _02153E34 // =_0217C2E0
	str r0, [r1]
	mov r0, #0
	str r0, [r5]
	mov r0, #1
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_02153E30: .word 0x0217C38C
_02153E34: .word _0217C2E0
	thumb_func_end ovl08_2153D28

	thumb_func_start ovl08_2153E38
ovl08_2153E38: // 0x02153E38
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	str r3, [sp]
	mov r7, r6
	add r7, #0xc
	ldrh r0, [r6, #0xc]
	bl ovl08_2152A04
	cmp r0, #1
	bhs _02153E62
	ldr r0, [r4]
	add r0, r0, #1
	str r0, [r4]
	mov r0, r5
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153E62:
	ldrb r0, [r7, #0xf]
	cmp r0, #0x11
	beq _02153E78
	ldr r0, [r4]
	add r0, r0, #1
	str r0, [r4]
	mov r0, r5
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153E78:
	mov r0, r6
	add r0, #0xc
	bl ovl08_2153A4C
	cmp r0, #0
	ble _02153E94
	ldr r0, [r4]
	add r0, r0, #1
	str r0, [r4]
	mov r0, r5
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153E94:
	ldrh r0, [r7, #6]
	bl ovl08_2152A04
	ldr r1, _02153EE8 // =0x00001010
	cmp r0, r1
	beq _02153EAE
	ldr r1, _02153EEC // =0x00002010
	cmp r0, r1
	beq _02153EBE
	ldr r1, _02153EF0 // =0x00003010
	cmp r0, r1
	beq _02153ECE
	b _02153EDC
_02153EAE:
	mov r0, r5
	mov r1, r6
	mov r2, r4
	ldr r3, [sp]
	bl ovl08_2153D28
	mov r5, r0
	b _02153EDC
_02153EBE:
	mov r0, r5
	mov r1, r6
	mov r2, r4
	ldr r3, [sp]
	bl ovl08_2153C20
	mov r5, r0
	b _02153EDC
_02153ECE:
	mov r0, r5
	mov r1, r6
	mov r2, r4
	ldr r3, [sp]
	bl ovl08_2153B5C
	mov r5, r0
_02153EDC:
	mov r0, r5
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_02153EE8: .word 0x00001010
_02153EEC: .word 0x00002010
_02153EF0: .word 0x00003010
	thumb_func_end ovl08_2153E38

	thumb_func_start ovl08_2153EF4
ovl08_2153EF4: // 0x02153EF4
	push {lr}
	sub sp, #4
	mov r3, #0
	mvn r1, r3
	cmp r0, r1
	bne _02153F0C
	ldr r1, _02153F28 // =0x0217B04C
	str r0, [r1]
	mov r0, r3
	add sp, #4
	pop {r3}
	bx r3
_02153F0C:
	ldr r1, _02153F28 // =0x0217B04C
	ldr r2, [r1]
	cmp r2, r0
	beq _02153F20
	str r0, [r1]
	bl ovl08_2154F4C
	add sp, #4
	pop {r3}
	bx r3
_02153F20:
	mov r0, r3
	add sp, #4
	pop {r3}
	bx r3
	.align 2, 0
_02153F28: .word 0x0217B04C
	thumb_func_end ovl08_2153EF4

	thumb_func_start ovl08_2153F2C
ovl08_2153F2C: // 0x02153F2C
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r6, r0
	mov r5, r1
	mov r7, r2
	mov r4, #0
	cmp r6, #0
	ble _02153F5C
_02153F3C:
	mov r0, r5
	mov r1, r7
	mov r2, #6
	bl ovl08_2152B50
	bl AOSS_Rand
	strh r0, [r5, #6]
	ldrh r0, [r5, #6]
	bl ovl08_2152A54
	strh r0, [r5, #6]
	add r5, #8
	add r4, r4, #1
	cmp r4, r6
	blt _02153F3C
_02153F5C:
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	thumb_func_end ovl08_2153F2C

	thumb_func_start ovl08_2153F64
ovl08_2153F64: // 0x02153F64
	push {r4, lr}
	mov r4, r0
	ldr r0, _02153FA8 // =aEssidAoss
	bl ovl08_21529F0
	str r0, [r4]
	add r0, r4, #4
	ldr r1, _02153FA8 // =aEssidAoss
	ldr r2, [r4]
	bl ovl08_2152B50
	mov r0, #1
	str r0, [r4, #0x24]
	ldr r0, _02153FAC // =aMelco
	bl ovl08_21529F0
	str r0, [r4, #0x28]
	ldr r2, [r4, #0x28]
	cmp r2, #0xd
	bls _02153F96
	mov r0, #0
	mvn r0, r0
	pop {r4}
	pop {r3}
	bx r3
_02153F96:
	add r4, #0x2c
	mov r0, r4
	ldr r1, _02153FAC // =aMelco
	bl ovl08_2152B50
	mov r0, #0
	pop {r4}
	pop {r3}
	bx r3
	.align 2, 0
_02153FA8: .word aEssidAoss
_02153FAC: .word aMelco
	thumb_func_end ovl08_2153F64

	thumb_func_start ovl08_2153FB0
ovl08_2153FB0: // 0x02153FB0
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	mov r4, #0
	str r4, [sp, #4]
	ldr r0, [r5]
	str r0, [sp]
	cmp r0, #0
	bne _02153FCC
	mov r0, #5
	add sp, #0xc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02153FCC:
	cmp r0, #0x40
	bls _02153FD4
	mov r0, #0x40
	str r0, [sp]
_02153FD4:
	mov r7, #0
	ldr r0, [sp]
	cmp r0, #0
	ble _02154018
	mov r6, r5
	add r6, #8
_02153FE0:
	ldr r1, [r5, #0x54]
	mov r0, #1
	and r1, r0
	cmp r1, #0
	beq _0215400C
	ldr r0, _02154034 // =aEssidAoss
	bl ovl08_21529F0
	ldr r1, [r5, #4]
	cmp r1, r0
	bne _0215400C
	ldr r0, _02154034 // =aEssidAoss
	bl ovl08_21529F0
	mov r2, r0
	mov r0, r6
	ldr r1, _02154034 // =aEssidAoss
	bl ovl08_2152B60
	cmp r0, #0
	bne _0215400C
	add r4, r4, #1
_0215400C:
	add r5, #0x54
	add r6, #0x54
	add r7, r7, #1
	ldr r0, [sp]
	cmp r7, r0
	blt _02153FE0
_02154018:
	cmp r4, #1
	ble _02154020
	mov r0, #4
	str r0, [sp, #4]
_02154020:
	cmp r4, #0
	bne _02154028
	mov r0, #5
	str r0, [sp, #4]
_02154028:
	ldr r0, [sp, #4]
	add sp, #0xc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_02154034: .word aEssidAoss
	thumb_func_end ovl08_2153FB0

	thumb_func_start ovl08_2154038
ovl08_2154038: // 0x02154038
	mov r3, #0
	cmp r1, #0
	ble _02154056
_0215403E:
	ldrb r2, [r0]
	add r0, r0, #1
	cmp r2, #0x20
	blo _0215404A
	cmp r2, #0x7f
	bls _02154050
_0215404A:
	mov r0, #0
	mvn r0, r0
	bx lr
_02154050:
	add r3, r3, #1
	cmp r3, r1
	blt _0215403E
_02154056:
	mov r0, #0
	bx lr
	.align 2, 0
	thumb_func_end ovl08_2154038

	thumb_func_start ovl08_215405C
ovl08_215405C: // 0x0215405C
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r7, r0
	ldr r0, _02154248 // =0x00000117
	add r5, r7, r0
	ldr r4, _0215424C // =0x0217CA14
	ldr r6, _02154250 // =0x0217CB44
	ldr r0, _02154254 // =0x0217CC74
	str r0, [sp]
	ldr r0, _02154258 // =0x0217CCE4
	str r0, [sp, #4]
	cmp r5, #0
	bne _02154082
	mov r0, #0
	mvn r0, r0
	add sp, #0xc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154082:
	ldr r0, _0215425C // =0x0217C30C
	ldr r1, [r0, #8]
	ldr r0, [r0, #0xc]
	and r1, r0
	strh r1, [r7]
	mov r0, r5
	mov r1, #0
	ldr r2, _02154260 // =0x00000154
	bl ovl08_2152B44
	ldrh r1, [r7]
	mov r0, #1
	and r1, r0
	cmp r1, #0
	beq _02154102
	mov r0, r5
	mov r1, r4
	add r1, #0x30
	ldr r2, [r4, #4]
	bl ovl08_2152B50
	add r0, r5, #6
	mov r1, r4
	add r1, #0x70
	ldr r2, [r4, #4]
	bl ovl08_2152B50
	mov r0, r5
	add r0, #0xc
	mov r1, r4
	add r1, #0xb0
	ldr r2, [r4, #4]
	bl ovl08_2152B50
	mov r0, r5
	add r0, #0x12
	mov r1, r4
	add r1, #0xf0
	ldr r2, [r4, #4]
	bl ovl08_2152B50
	mov r0, r4
	add r0, #8
	bl ovl08_21529F0
	mov r1, r0
	mov r0, r4
	add r0, #8
	bl ovl08_2154038
	cmp r0, #0
	beq _021540EC
	b _02154232
_021540EC:
	mov r0, r4
	add r0, #8
	bl ovl08_21529F0
	mov r2, r0
	mov r0, r5
	add r0, #0x18
	add r4, #8
	mov r1, r4
	bl ovl08_2152B50
_02154102:
	ldrh r1, [r7]
	mov r0, #2
	and r1, r0
	cmp r1, #0
	beq _02154170
	mov r0, r5
	add r0, #0x39
	mov r1, r6
	add r1, #0x30
	ldr r2, [r6, #4]
	bl ovl08_2152B50
	mov r0, r5
	add r0, #0x47
	mov r1, r6
	add r1, #0x70
	ldr r2, [r6, #4]
	bl ovl08_2152B50
	mov r0, r5
	add r0, #0x55
	mov r1, r6
	add r1, #0xb0
	ldr r2, [r6, #4]
	bl ovl08_2152B50
	mov r0, r5
	add r0, #0x63
	mov r1, r6
	add r1, #0xf0
	ldr r2, [r6, #4]
	bl ovl08_2152B50
	mov r0, r6
	add r0, #8
	bl ovl08_21529F0
	mov r1, r0
	mov r0, r6
	add r0, #8
	bl ovl08_2154038
	cmp r0, #0
	bne _02154232
	mov r0, r6
	add r0, #8
	bl ovl08_21529F0
	mov r2, r0
	mov r0, r5
	add r0, #0x71
	add r6, #8
	mov r1, r6
	bl ovl08_2152B50
_02154170:
	ldrh r1, [r7]
	mov r0, #4
	and r1, r0
	cmp r1, #0
	beq _021541CA
	ldr r0, [sp]
	add r0, #0x30
	ldr r1, [sp]
	ldr r1, [r1, #4]
	sub r1, r1, #1
	bl ovl08_2154038
	cmp r0, #0
	bne _02154232
	mov r0, r5
	add r0, #0x92
	ldr r1, [sp]
	add r1, #0x30
	ldr r2, [sp]
	ldr r2, [r2, #4]
	bl ovl08_2152B50
	ldr r0, [sp]
	add r0, #8
	bl ovl08_21529F0
	mov r1, r0
	ldr r0, [sp]
	add r0, #8
	bl ovl08_2154038
	cmp r0, #0
	bne _02154232
	ldr r0, [sp]
	add r0, #8
	bl ovl08_21529F0
	mov r2, r0
	mov r0, r5
	add r0, #0xd2
	ldr r1, [sp]
	add r1, #8
	str r1, [sp]
	bl ovl08_2152B50
_021541CA:
	ldrh r1, [r7]
	mov r0, #8
	and r1, r0
	cmp r1, #0
	beq _02154224
	ldr r0, [sp, #4]
	add r0, #0x30
	ldr r1, [sp, #4]
	ldr r1, [r1, #4]
	sub r1, r1, #1
	bl ovl08_2154038
	cmp r0, #0
	bne _02154232
	mov r0, r5
	add r0, #0xf3
	ldr r1, [sp, #4]
	add r1, #0x30
	ldr r2, [sp, #4]
	ldr r2, [r2, #4]
	bl ovl08_2152B50
	ldr r0, [sp, #4]
	add r0, #8
	bl ovl08_21529F0
	mov r1, r0
	ldr r0, [sp, #4]
	add r0, #8
	bl ovl08_2154038
	cmp r0, #0
	bne _02154232
	ldr r0, [sp, #4]
	add r0, #8
	bl ovl08_21529F0
	mov r2, r0
	ldr r0, _02154264 // =0x00000133
	add r0, r5, r0
	ldr r1, [sp, #4]
	add r1, #8
	str r1, [sp, #4]
	bl ovl08_2152B50
_02154224:
	mov r0, #0
	ldr r1, _02154268 // =0x00000116
	strb r0, [r7, r1]
	add sp, #0xc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154232:
	mov r0, r5
	mov r1, #0
	ldr r2, _02154260 // =0x00000154
	bl ovl08_2152B44
	mov r0, #0
	mvn r0, r0
	add sp, #0xc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02154248: .word 0x00000117
_0215424C: .word 0x0217CA14
_02154250: .word 0x0217CB44
_02154254: .word 0x0217CC74
_02154258: .word 0x0217CCE4
_0215425C: .word 0x0217C30C
_02154260: .word 0x00000154
_02154264: .word 0x00000133
_02154268: .word 0x00000116
	thumb_func_end ovl08_215405C

	thumb_func_start ovl08_215426C
ovl08_215426C: // 0x0215426C
	ldr r0, _02154274 // =0x0217C2F0
	ldr r0, [r0]
	bx lr
	nop
_02154274: .word 0x0217C2F0
	thumb_func_end ovl08_215426C

	thumb_func_start ovl08_2154278
ovl08_2154278: // 0x02154278
	ldr r1, _02154280 // =0x0217C2F0
	str r0, [r1]
	bx lr
	nop
_02154280: .word 0x0217C2F0
	thumb_func_end ovl08_2154278

	thumb_func_start ovl08_2154284
ovl08_2154284: // 0x02154284
	push {r4, lr}
	mov r4, r0
	ldr r0, _021542C8 // =0x0217C2F8
	mov r1, #0
	mov r2, #8
	bl ovl08_2152B44
	mov r1, #1
	ldr r0, _021542CC // =0x0217C2F0
	str r1, [r0]
	ldr r0, _021542D0 // =0x0217C30C
	mov r1, #0
	mov r2, #0x1c
	bl ovl08_2152B44
	add r0, r4, #6
	ldr r1, _021542D0 // =0x0217C30C
	str r0, [r1]
	ldrh r0, [r4, #4]
	str r0, [r1, #4]
	ldrh r2, [r4]
	mov r0, #0xf
	and r2, r0
	str r2, [r1, #8]
	ldrb r0, [r4, #2]
	strb r0, [r1, #0x19]
	mov r2, #0
	str r2, [r1, #0xc]
	ldr r0, _021542D4 // =0xC0A80B01
	str r0, [r1, #0x10]
	strb r2, [r1, #0x18]
	pop {r4}
	pop {r3}
	bx r3
	.align 2, 0
_021542C8: .word 0x0217C2F8
_021542CC: .word 0x0217C2F0
_021542D0: .word 0x0217C30C
_021542D4: .word 0xC0A80B01
	thumb_func_end ovl08_2154284

	thumb_func_start ovl08_21542D8
ovl08_21542D8: // 0x021542D8
	push {lr}
	sub sp, #4
	ldr r0, _02154308 // =0x0217C2EC
	ldr r0, [r0]
	cmp r0, #0
	beq _021542EE
	bl ovl08_2154F24
	mov r1, #0
	ldr r0, _02154308 // =0x0217C2EC
	str r1, [r0]
_021542EE:
	ldr r0, _0215430C // =0x0217C2E4
	ldr r0, [r0]
	cmp r0, #0
	beq _02154300
	bl ovl08_2154F24
	mov r1, #0
	ldr r0, _0215430C // =0x0217C2E4
	str r1, [r0]
_02154300:
	add sp, #4
	pop {r3}
	bx r3
	nop
_02154308: .word 0x0217C2EC
_0215430C: .word 0x0217C2E4
	thumb_func_end ovl08_21542D8

	thumb_func_start ovl08_2154310
ovl08_2154310: // 0x02154310
	mov r3, r0
	and r3, r1
	mvn r2, r1
	bic r0, r1
	add r1, r0, #1
	mov r0, r3
	orr r0, r1
	mov r1, r3
	orr r1, r2
	cmp r0, r1
	blo _0215432C
	mov r1, #1
	mov r0, r3
	orr r0, r1
_0215432C:
	bx lr
	.align 2, 0
	thumb_func_end ovl08_2154310

	thumb_func_start ovl08_2154330
ovl08_2154330: // 0x02154330
	push {r4, r5, r6, r7, lr}
	sub sp, #0xcc
	str r0, [sp, #8]
	ldr r1, _021546C8 // =0x0217B048
	ldrh r2, [r1]
	add r0, sp, #0x30
	strh r2, [r0]
	ldrh r1, [r1, #2]
	strh r1, [r0, #2]
	add r1, sp, #0x34
	mov r0, #0
	str r0, [sp, #0x14]
	strh r0, [r1]
	strh r0, [r1, #2]
	mov r0, #1
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x14]
	str r0, [sp, #0x3c]
	str r0, [sp, #0x1c]
	add r0, sp, #0x64
	ldr r1, [sp, #0x14]
	mov r2, #0x18
	bl ovl08_2152B44
	ldr r1, _021546CC // =0x00000106
	ldr r0, [sp, #8]
	ldrsh r0, [r0, r1]
	add r1, sp, #0x30
	strh r0, [r1]
	mov r0, #0
	ldrsh r2, [r1, r0]
	mvn r0, r0
	cmp r2, r0
	bne _02154378
	mov r0, #0xa
	strh r0, [r1]
_02154378:
	ldr r1, _021546D0 // =0x0000010A
	ldr r0, [sp, #8]
	ldrsh r0, [r0, r1]
	add r1, sp, #0x30
	strh r0, [r1, #4]
	mov r0, #4
	ldrsh r2, [r1, r0]
	mov r0, #0
	mvn r0, r0
	cmp r2, r0
	bne _02154392
	mov r0, #0xa
	strh r0, [r1, #4]
_02154392:
	ldr r1, _021546D4 // =0x00000108
	ldr r0, [sp, #8]
	ldrsh r0, [r0, r1]
	add r1, sp, #0x30
	strh r0, [r1, #2]
	mov r0, #2
	ldrsh r2, [r1, r0]
	mov r0, #0
	mvn r0, r0
	cmp r2, r0
	bne _021543AC
	mov r0, #0x64
	strh r0, [r1, #2]
_021543AC:
	ldr r1, _021546D8 // =0x0000010C
	ldr r0, [sp, #8]
	ldrsh r0, [r0, r1]
	add r1, sp, #0x30
	strh r0, [r1, #6]
	mov r0, #6
	ldrsh r2, [r1, r0]
	mov r0, #0
	mvn r0, r0
	cmp r2, r0
	bne _021543C6
	mov r0, #0x64
	strh r0, [r1, #6]
_021543C6:
	ldr r1, _021546DC // =0x0000010E
	ldr r0, [sp, #8]
	ldrsh r0, [r0, r1]
	str r0, [sp, #0x10]
	mov r0, #0
	mvn r1, r0
	ldr r0, [sp, #0x10]
	cmp r0, r1
	bne _021543DC
	ldr r0, _021546E0 // =0x000007D0
	str r0, [sp, #0x10]
_021543DC:
	ldr r0, [sp, #8]
	bl ovl08_2154284
	ldr r0, _021546E4 // =0x0217C30C
	ldr r1, [r0, #8]
	mov r0, #1
	and r1, r0
	cmp r1, #1
	beq _0215440C
	mov r0, #0x13
	bl ovl08_2154278
	mov r2, #0xf
	ldr r1, _021546E8 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215440C:
	mov r4, #0
	mov r0, r4
	bl ovl08_2153EF4
	mov r1, #2
	add r0, sp, #0x30
	ldrsh r7, [r0, r1]
	lsl r6, r4, #0
	ldr r5, _021546EC // =0x0217C2E4
_0215441E:
	ldr r0, [r5]
	cmp r0, #0
	beq _0215442A
	bl ovl08_2154F24
	str r6, [r5]
_0215442A:
	mov r0, r5
	bl ovl08_2155154
	mvn r1, r6
	cmp r0, r1
	bne _0215444E
	mov r2, #0xf
	ldr r1, _021546E8 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215444E:
	ldr r0, [r5]
	bl ovl08_2153FB0
	cmp r0, #4
	bne _02154470
	mov r2, #2
	ldr r1, _021546E8 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154470:
	cmp r0, #0
	beq _021544A2
	add r0, sp, #0x30
	ldrsh r0, [r0, r6]
	cmp r4, r0
	blt _02154494
	mov r2, #1
	ldr r1, _021546E8 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154494:
	mov r0, r7
	bl ovl08_2154F68
	add r0, r4, #1
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	b _0215441E
_021544A2:
	mov r0, #1
	bl ovl08_2153EF4
	add r0, sp, #0x7c
	mov r1, #0
	mov r2, #0x3c
	bl ovl08_2152B44
	add r0, sp, #0x7c
	bl ovl08_2153F64
	cmp r0, #0
	beq _021544D4
	mov r2, #0xf
	ldr r1, _021546E8 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021544D4:
	mov r0, #0x58
	bl ovl08_2154F38
	ldr r1, _021546F0 // =0x0217C2EC
	str r0, [r1]
	cmp r0, #0
	bne _021544FA
	mov r2, #0xf
	ldr r1, _021546E8 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021544FA:
	mov r1, #0
	mov r2, #0x58
	bl ovl08_2152B44
	mov r4, #0
	add r0, sp, #0x30
	ldrsh r0, [r0, r4]
	cmp r0, #0
	ble _0215455E
	mov r6, r4
	mov r5, r4
_02154510:
	add r0, sp, #0x7c
	ldr r1, _021546F0 // =0x0217C2EC
	ldr r1, [r1]
	bl ovl08_2154F70
	mvn r1, r5
	cmp r0, r1
	bne _02154538
	mov r2, #0xf
	ldr r1, _021546E8 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154538:
	cmp r0, #0
	bne _0215454A
	cmp r0, #0
	bne _0215455E
	ldr r0, _021546F0 // =0x0217C2EC
	ldr r0, [r0]
	ldr r0, [r0]
	cmp r0, #1
	beq _0215455E
_0215454A:
	mov r0, r7
	bl ovl08_2154F68
	add r0, r4, #1
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	add r0, sp, #0x30
	ldrsh r0, [r0, r6]
	cmp r4, r0
	blt _02154510
_0215455E:
	add r1, sp, #0x30
	mov r0, #0
	ldrsh r0, [r1, r0]
	cmp r4, r0
	bne _02154580
	mov r2, #0xf
	ldr r1, _021546E8 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154580:
	ldr r0, _021546F4 // =0xC0A80B65
	mov r1, #0xff
	mvn r1, r1
	mov r2, r0
	bl ovl08_2152BB4
	cmp r0, #0
	beq _021545AE
	mov r0, #0xc
	bl ovl08_2154278
	mov r2, #0xf
	ldr r1, _021546E8 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021545AE:
	bl ovl08_21542D8
	mov r0, #3
	add r1, sp, #0x64
	ldr r3, _021546F8 // =0x00000110
	ldr r2, [sp, #8]
	add r2, r2, r3
	bl ovl08_2153F2C
	mov r0, #2
	mov r1, r0
	mov r2, #0
	bl ovl08_2152AB8
	ldr r1, _021546FC // =0x0217B044
	str r0, [r1]
	cmp r0, #0
	bge _021545EA
	mov r2, #0xf
	ldr r1, _021546E8 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021545EA:
	mov r1, #4
	str r1, [sp]
	ldr r1, _02154700 // =0x0000FFFF
	mov r2, #1
	add r3, sp, #0x38
	bl ovl08_2152AC0
	cmp r0, #0
	bge _0215461A
	mov r0, #0xb
	bl ovl08_2154278
	mov r2, #0xf
	ldr r1, _021546E8 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215461A:
	add r0, sp, #0x5c
	mov r1, #0
	mov r2, #8
	bl ovl08_2152B44
	mov r1, #2
	add r0, sp, #0x5c
	strb r1, [r0, #1]
	ldr r0, _021546F4 // =0xC0A80B65
	bl ovl08_2152A6C
	str r0, [sp, #0x60]
	ldr r0, _02154704 // =0x00005790
	bl ovl08_2152A54
	add r1, sp, #0x30
	strh r0, [r1, #0x2e]
	ldr r0, _021546FC // =0x0217B044
	ldr r0, [r0]
	add r1, sp, #0x5c
	mov r2, #8
	bl ovl08_2152AAC
	cmp r0, #0
	bge _02154664
	mov r2, #0xf
	ldr r1, _021546E8 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154664:
	mov r5, #0
	ldr r6, _021546EC // =0x0217C2E4
	mvn r0, r5
	str r0, [sp, #0x28]
_0215466C:
	ldr r0, _02154708 // =0x0217C2F4
	ldr r0, [r0]
	str r0, [sp, #0x20]
	add r0, sp, #0xb8
	mov r1, r5
	mov r2, #0x14
	bl ovl08_2152B44
	ldr r0, _021546F4 // =0xC0A80B65
	str r0, [sp, #0xc8]
	ldr r0, _0215470C // =0xC0A80B01
	str r0, [sp, #0xb8]
	ldr r0, [sp, #0x10]
	ldr r1, _02154710 // =0x000003E8
	blx _s32_div_f
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x10]
	ldr r1, _02154710 // =0x000003E8
	blx _s32_div_f
	str r1, [sp, #0xc]
	ldr r0, _02154710 // =0x000003E8
	mul r1, r0
	str r1, [sp, #0xc]
_0215469E:
	ldr r0, [sp, #0x14]
	cmp r0, #1
	beq _021546A6
	b _0215498E
_021546A6:
	ldr r1, _021546E4 // =0x0217C30C
	mov r0, #0x18
	ldrsb r0, [r1, r0]
	cmp r0, #1
	bne _021546B2
	b _0215498E
_021546B2:
	ldr r0, _021546FC // =0x0217B044
	ldr r0, [r0]
	mvn r1, r5
	cmp r0, r1
	beq _021546C0
	bl ovl08_2152AA4
_021546C0:
	ldr r1, [sp, #0x28]
	ldr r0, _021546FC // =0x0217B044
	b _02154714
	nop
_021546C8: .word 0x0217B048
_021546CC: .word 0x00000106
_021546D0: .word 0x0000010A
_021546D4: .word 0x00000108
_021546D8: .word 0x0000010C
_021546DC: .word 0x0000010E
_021546E0: .word 0x000007D0
_021546E4: .word 0x0217C30C
_021546E8: .word 0x00000116
_021546EC: .word 0x0217C2E4
_021546F0: .word 0x0217C2EC
_021546F4: .word 0xC0A80B65
_021546F8: .word 0x00000110
_021546FC: .word 0x0217B044
_02154700: .word 0x0000FFFF
_02154704: .word 0x00005790
_02154708: .word 0x0217C2F4
_0215470C: .word 0xC0A80B01
_02154710: .word 0x000003E8
_02154714:
	str r1, [r0]
	bl ovl08_2152B88
	cmp r0, #0
	beq _02154736
	mov r2, #0xf
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154736:
	mov r0, #0x58
	bl ovl08_2154F38
	str r0, [r6]
	cmp r0, #0
	bne _0215475A
	mov r2, #0xf
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215475A:
	ldr r0, [r6]
	cmp r0, #0
	beq _02154766
	bl ovl08_2154F24
	str r5, [r6]
_02154766:
	mov r0, r6
	bl ovl08_2155154
	str r0, [sp, #0x2c]
	mvn r1, r5
	cmp r0, r1
	bne _0215478C
	mov r2, #0xf
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215478C:
	ldr r0, [r6]
	bl ovl08_2153FB0
	cmp r0, #4
	bne _021547AE
	mov r2, #2
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021547AE:
	cmp r0, #0
	beq _021547E0
	add r0, sp, #0x30
	ldrsh r0, [r0, r5]
	cmp r4, r0
	blt _021547D2
	mov r2, #1
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021547D2:
	mov r0, r7
	bl ovl08_2154F68
	add r0, r4, #1
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	b _0215475A
_021547E0:
	mvn r1, r5
	ldr r0, [sp, #0x2c]
	cmp r0, r1
	bne _02154800
	mov r2, #0xf
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154800:
	mov r0, #0x58
	bl ovl08_2154F38
	ldr r1, _02154A9C // =0x0217C2EC
	str r0, [r1]
	cmp r0, #0
	bne _02154826
	mov r2, #0xf
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154826:
	mov r1, r5
	mov r2, #0x58
	bl ovl08_2152B44
	mov r4, r5
	add r0, sp, #0x30
	ldrsh r0, [r0, r5]
	cmp r0, #0
	ble _02154886
_02154838:
	add r0, sp, #0x7c
	ldr r1, _02154A9C // =0x0217C2EC
	ldr r1, [r1]
	bl ovl08_2154F70
	mvn r1, r5
	cmp r0, r1
	bne _02154860
	mov r2, #0xf
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154860:
	cmp r0, #0
	bne _02154872
	cmp r0, #0
	bne _02154886
	ldr r0, _02154A9C // =0x0217C2EC
	ldr r0, [r0]
	ldr r0, [r0]
	cmp r0, #1
	beq _02154886
_02154872:
	mov r0, r7
	bl ovl08_2154F68
	add r0, r4, #1
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	add r0, sp, #0x30
	ldrsh r0, [r0, r5]
	cmp r4, r0
	blt _02154838
_02154886:
	add r0, sp, #0x30
	ldrsh r0, [r0, r5]
	cmp r4, r0
	bne _021548A6
	mov r2, #0xf
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021548A6:
	ldr r0, _02154AA0 // =0x0217C30C
	ldr r0, [r0, #0x10]
	ldr r1, _02154AA0 // =0x0217C30C
	ldr r1, [r1, #0x14]
	bl ovl08_2154310
	str r0, [sp, #0x1c]
	ldr r1, _02154AA0 // =0x0217C30C
	ldr r1, [r1, #0x14]
	lsl r2, r0, #0
	bl ovl08_2152BB4
	cmp r0, #0
	beq _021548E0
	mov r0, #0xc
	bl ovl08_2154278
	mov r2, #0xf
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021548E0:
	mov r1, #1
	ldr r0, _02154AA0 // =0x0217C30C
	strb r1, [r0, #0x18]
	bl ovl08_21542D8
	mov r0, #2
	lsl r1, r0, #0
	mov r2, r5
	bl ovl08_2152AB8
	ldr r1, _02154AA4 // =0x0217B044
	str r0, [r1]
	cmp r0, #0
	bge _02154914
	mov r2, #0xf
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154914:
	mov r1, #4
	str r1, [sp]
	ldr r1, _02154AA8 // =0x0000FFFF
	mov r2, #1
	add r3, sp, #0x38
	bl ovl08_2152AC0
	cmp r0, #0
	bge _02154944
	mov r0, #0xb
	bl ovl08_2154278
	mov r2, #0xf
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154944:
	add r0, sp, #0x5c
	mov r1, r5
	mov r2, #8
	bl ovl08_2152B44
	mov r1, #2
	add r0, sp, #0x5c
	strb r1, [r0, #1]
	ldr r0, [sp, #0x1c]
	bl ovl08_2152A6C
	str r0, [sp, #0x60]
	ldr r0, _02154AAC // =0x00005790
	bl ovl08_2152A54
	add r1, sp, #0x30
	strh r0, [r1, #0x2e]
	ldr r0, _02154AA4 // =0x0217B044
	ldr r0, [r0]
	add r1, sp, #0x5c
	mov r2, #8
	bl ovl08_2152AAC
	cmp r0, #0
	bge _0215498E
	mov r2, #0xf
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215498E:
	ldr r0, [sp, #0x14]
	add r1, sp, #0xb8
	add r2, sp, #0x64
	ldr r3, _02154AA4 // =0x0217B044
	ldr r3, [r3]
	bl ovl08_21534A4
	mvn r1, r5
	cmp r0, r1
	bne _021549C4
	ldr r1, _02154AB0 // =0x00001000
	ldr r0, [sp, #0x14]
	add r0, r0, r1
	bl ovl08_2154278
	mov r2, #0xf
	ldr r1, _02154A98 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021549C4:
	ldr r0, [sp, #0x20]
	mov r1, r5
	ldr r2, _02154AB4 // =0x000005F8
	bl ovl08_2152B44
	add r0, sp, #0x4c
	bl AOSS_FD_ZERO
	ldr r0, _02154AA4 // =0x0217B044
	ldr r0, [r0]
	add r1, sp, #0x4c
	bl AOSS_FD_SET
	ldr r0, [sp, #0x24]
	str r0, [sp, #0x54]
	ldr r0, [sp, #0xc]
	str r0, [sp, #0x58]
	add r0, sp, #0x54
	str r0, [sp]
	ldr r0, _02154AA4 // =0x0217B044
	ldr r0, [r0]
	add r0, r0, #1
	add r1, sp, #0x4c
	mov r2, r5
	mov r3, r5
	bl ovl08_2152ADC
	cmp r0, #0
	bgt _02154A3E
	ldr r0, [sp, #0x3c]
	add r2, r0, #1
	str r2, [sp, #0x3c]
	add r1, sp, #0x30
	mov r0, #4
	ldrsh r0, [r1, r0]
	cmp r2, r0
	ble _02154A34
	ldr r0, [sp, #0x14]
	cmp r0, #0
	bne _02154A1C
	mov r0, #0xf
	bl ovl08_2154278
	b _02154A2E
_02154A1C:
	cmp r0, #1
	bne _02154A28
	mov r0, #0x10
	bl ovl08_2154278
	b _02154A2E
_02154A28:
	mov r0, #0x11
	bl ovl08_2154278
_02154A2E:
	mov r0, #0
	mvn r4, r0
	b _02154D4A
_02154A34:
	mov r0, #6
	ldrsh r0, [r1, r0]
	bl ovl08_2154F68
	b _0215469E
_02154A3E:
	mov r0, #8
	str r0, [sp, #0x48]
	add r0, sp, #0x40
	str r0, [sp]
	add r0, sp, #0x48
	str r0, [sp, #4]
	ldr r0, _02154AA4 // =0x0217B044
	ldr r0, [r0]
	ldr r1, [sp, #0x20]
	add r1, #0xc
	ldr r2, _02154AB8 // =0x000005DC
	mov r3, r5
	bl ovl08_2152B28
	mov r2, r0
	ldr r0, _02154AA4 // =0x0217B044
	ldr r1, [r0]
	ldr r0, [sp, #0x20]
	str r1, [r0]
	lsl r0, r2, #0x10
	lsr r0, r0, #0x10
	bl ovl08_2152A04
	ldr r1, [sp, #0x20]
	str r0, [r1, #4]
	ldr r0, _02154AA4 // =0x0217B044
	ldr r0, [r0]
	str r0, [sp]
	ldr r0, [sp, #0x14]
	add r2, sp, #0x3c
	add r3, sp, #0x64
	bl ovl08_2153E38
	str r0, [sp, #0x18]
	cmp r0, #0x64
	bne _02154A8A
	mov r4, #0
	b _02154D4A
_02154A8A:
	mvn r1, r5
	cmp r0, r1
	bne _02154ABC
	mov r0, #0
	mvn r4, r0
	b _02154D4A
	nop
_02154A98: .word 0x00000116
_02154A9C: .word 0x0217C2EC
_02154AA0: .word 0x0217C30C
_02154AA4: .word 0x0217B044
_02154AA8: .word 0x0000FFFF
_02154AAC: .word 0x00005790
_02154AB0: .word 0x00001000
_02154AB4: .word 0x000005F8
_02154AB8: .word 0x000005DC
_02154ABC:
	ldr r1, [sp, #0x14]
	cmp r1, r0
	bne _02154AC4
	b _02154D0C
_02154AC4:
	cmp r0, #2
	beq _02154ACA
	b _02154D06
_02154ACA:
	ldr r0, _02154E04 // =0x0217B044
	ldr r0, [r0]
	mvn r1, r5
	cmp r0, r1
	beq _02154AD8
	bl ovl08_2152AA4
_02154AD8:
	ldr r1, [sp, #0x28]
	ldr r0, _02154E04 // =0x0217B044
	str r1, [r0]
	bl ovl08_2152B88
	cmp r0, #0
	beq _02154AFE
	mov r2, #0xf
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154AFE:
	mov r4, r5
	mov r0, #4
	bl ovl08_2153EF4
_02154B06:
	ldr r0, [r6]
	cmp r0, #0
	beq _02154B12
	bl ovl08_2154F24
	str r5, [r6]
_02154B12:
	mov r0, r6
	bl ovl08_2155154
	mvn r1, r5
	cmp r0, r1
	bne _02154B36
	mov r2, #0xf
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154B36:
	ldr r0, [r6]
	bl ovl08_2153FB0
	cmp r0, #4
	bne _02154B58
	mov r2, #2
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154B58:
	cmp r0, #0
	beq _02154B8A
	add r0, sp, #0x30
	ldrsh r0, [r0, r5]
	cmp r4, r0
	blt _02154B7C
	mov r2, #1
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154B7C:
	mov r0, r7
	bl ovl08_2154F68
	add r0, r4, #1
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	b _02154B06
_02154B8A:
	mov r0, #0x58
	bl ovl08_2154F38
	ldr r1, _02154E0C // =0x0217C2EC
	str r0, [r1]
	cmp r0, #0
	bne _02154BB0
	mov r2, #0xf
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154BB0:
	mov r1, r5
	mov r2, #0x58
	bl ovl08_2152B44
	mov r4, r5
	add r0, sp, #0x30
	ldrsh r0, [r0, r5]
	cmp r0, #0
	ble _02154C10
_02154BC2:
	add r0, sp, #0x7c
	ldr r1, _02154E0C // =0x0217C2EC
	ldr r1, [r1]
	bl ovl08_2154F70
	mvn r1, r5
	cmp r0, r1
	bne _02154BEA
	mov r2, #0xf
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154BEA:
	cmp r0, #0
	bne _02154BFC
	cmp r0, #0
	bne _02154C10
	ldr r0, _02154E0C // =0x0217C2EC
	ldr r0, [r0]
	ldr r0, [r0]
	cmp r0, #1
	beq _02154C10
_02154BFC:
	mov r0, r7
	bl ovl08_2154F68
	add r0, r4, #1
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	add r0, sp, #0x30
	ldrsh r0, [r0, r5]
	cmp r4, r0
	blt _02154BC2
_02154C10:
	add r0, sp, #0x30
	ldrsh r0, [r0, r5]
	cmp r4, r0
	bne _02154C30
	mov r2, #0xf
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154C30:
	ldr r0, [sp, #0x1c]
	ldr r1, _02154E10 // =0x0217C30C
	ldr r1, [r1, #0x14]
	lsl r2, r0, #0
	bl ovl08_2152BB4
	cmp r0, #0
	beq _02154C5E
	mov r0, #0xc
	bl ovl08_2154278
	mov r2, #0xf
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154C5E:
	bl ovl08_21542D8
	mov r0, #2
	lsl r1, r0, #0
	mov r2, r5
	bl ovl08_2152AB8
	ldr r1, _02154E04 // =0x0217B044
	str r0, [r1]
	cmp r0, #0
	bge _02154C8C
	mov r2, #0xf
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154C8C:
	mov r1, #4
	str r1, [sp]
	ldr r1, _02154E14 // =0x0000FFFF
	mov r2, #1
	add r3, sp, #0x38
	bl ovl08_2152AC0
	cmp r0, #0
	bge _02154CBC
	mov r0, #0xb
	bl ovl08_2154278
	mov r2, #0xf
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154CBC:
	add r0, sp, #0x5c
	mov r1, r5
	mov r2, #8
	bl ovl08_2152B44
	mov r1, #2
	add r0, sp, #0x5c
	strb r1, [r0, #1]
	ldr r0, [sp, #0x1c]
	bl ovl08_2152A6C
	str r0, [sp, #0x60]
	ldr r0, _02154E18 // =0x00005790
	bl ovl08_2152A54
	add r1, sp, #0x30
	strh r0, [r1, #0x2e]
	ldr r0, _02154E04 // =0x0217B044
	ldr r0, [r0]
	add r1, sp, #0x5c
	mov r2, #8
	bl ovl08_2152AAC
	cmp r0, #0
	bge _02154D06
	mov r2, #0xf
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154D06:
	ldr r0, [sp, #0x18]
	str r0, [sp, #0x14]
	b _0215466C
_02154D0C:
	str r0, [sp, #0x14]
	ldr r2, [sp, #0x3c]
	add r1, sp, #0x30
	mov r0, #4
	ldrsh r0, [r1, r0]
	cmp r2, r0
	ble _02154D40
	ldr r0, [sp, #0x18]
	cmp r0, #0
	bne _02154D28
	mov r0, #0xf
	bl ovl08_2154278
	b _02154D3A
_02154D28:
	cmp r0, #1
	bne _02154D34
	mov r0, #0x10
	bl ovl08_2154278
	b _02154D3A
_02154D34:
	mov r0, #0x11
	bl ovl08_2154278
_02154D3A:
	mov r0, #0
	mvn r4, r0
	b _02154D4A
_02154D40:
	mov r0, #6
	ldrsh r0, [r1, r0]
	bl ovl08_2154F68
	b _0215466C
_02154D4A:
	ldr r0, _02154E04 // =0x0217B044
	ldr r0, [r0]
	mov r1, #0
	mvn r1, r1
	cmp r0, r1
	beq _02154D5A
	bl ovl08_2152AA4
_02154D5A:
	mov r0, #0
	mvn r1, r0
	ldr r0, _02154E04 // =0x0217B044
	str r1, [r0]
	bl ovl08_2152B88
	cmp r0, #0
	beq _02154D82
	mov r2, #0xf
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154D82:
	cmp r4, #0
	beq _02154DD8
	bl ovl08_215426C
	sub r0, #0xf
	cmp r0, #6
	bhi _02154DC0
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #8]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add r0, pc
	bx r0
_02154D9E: // jump table
	.hword _02154DAC - _02154D9E + 1 // case 0
	.hword _02154DB0 - _02154D9E + 1 // case 1
	.hword _02154DB4 - _02154D9E + 1 // case 2
	.hword _02154DC0 - _02154D9E + 1 // case 3
	.hword _02154DC0 - _02154D9E + 1 // case 4
	.hword _02154DB8 - _02154D9E + 1 // case 5
	.hword _02154DBC - _02154D9E + 1 // case 6
_02154DAC:
	mov r2, #3
	b _02154DC2
_02154DB0:
	mov r2, #4
	b _02154DC2
_02154DB4:
	mov r2, #5
	b _02154DC2
_02154DB8:
	mov r2, #7
	b _02154DC2
_02154DBC:
	mov r2, #8
	b _02154DC2
_02154DC0:
	mov r2, #0xf
_02154DC2:
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154DD8:
	ldr r0, [sp, #8]
	bl ovl08_215405C
	cmp r0, #0
	beq _02154DFA
	mov r2, #6
	ldr r1, _02154E08 // =0x00000116
	ldr r0, [sp, #8]
	strb r2, [r0, r1]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154DFA:
	mov r0, #0
	add sp, #0xcc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02154E04: .word 0x0217B044
_02154E08: .word 0x00000116
_02154E0C: .word 0x0217C2EC
_02154E10: .word 0x0217C30C
_02154E14: .word 0x0000FFFF
_02154E18: .word 0x00005790
	thumb_func_end ovl08_2154330

	thumb_func_start ovl08_2154E1C
ovl08_2154E1C: // 0x02154E1C
	push {r4, lr}
	mov r4, r0
	ldr r0, _02154EF4 // =0x00000106
	ldrsh r1, [r4, r0]
	cmp r1, #0
	beq _02154E6A
	mov r0, #0
	mvn r2, r0
	cmp r1, r2
	blt _02154E6A
	ldr r1, _02154EF8 // =0x00000108
	ldrsh r1, [r4, r1]
	cmp r1, r2
	blt _02154E6A
	ldr r1, _02154EFC // =0x0000010A
	ldrsh r1, [r4, r1]
	cmp r1, #0
	beq _02154E6A
	cmp r1, r2
	blt _02154E6A
	ldr r1, _02154F00 // =0x0000010C
	ldrsh r1, [r4, r1]
	cmp r1, r2
	blt _02154E6A
	ldr r1, _02154F04 // =0x0000010E
	ldrsh r1, [r4, r1]
	cmp r1, r2
	blt _02154E6A
	ldrh r2, [r4, #4]
	cmp r2, #0
	beq _02154E6A
	ldr r1, _02154F08 // =0x00000100
	cmp r2, r1
	bhi _02154E6A
	sub r1, r2, #1
	add r1, r4, r1
	ldrb r1, [r1, #6]
	cmp r1, #0
	beq _02154E6E
_02154E6A:
	mov r0, #0
	mvn r0, r0
_02154E6E:
	ldr r1, _02154F0C // =0x0217D0AC
	ldr r1, [r1]
	cmp r1, #0
	beq _02154E7E
	ldr r1, _02154F10 // =0x0217D0B8
	ldr r1, [r1]
	cmp r1, #0
	bne _02154E82
_02154E7E:
	mov r0, #0
	mvn r0, r0
_02154E82:
	mov r1, #0
	mvn r1, r1
	cmp r0, r1
	bne _02154E9E
	mov r1, #0xf
	ldr r0, _02154F14 // =0x00000116
	strb r1, [r4, r0]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	pop {r4}
	pop {r3}
	bx r3
_02154E9E:
	ldr r0, _02154F18 // =0x000005F8
	bl ovl08_2154F38
	ldr r1, _02154F1C // =0x0217C2F4
	str r0, [r1]
	cmp r0, #0
	bne _02154EC0
	mov r1, #0xf
	ldr r0, _02154F14 // =0x00000116
	strb r1, [r4, r0]
	bl ovl08_21542D8
	mov r0, #0
	mvn r0, r0
	pop {r4}
	pop {r3}
	bx r3
_02154EC0:
	mov r0, #0
	mvn r0, r0
	bl ovl08_2153EF4
	mov r0, r4
	bl ovl08_2154330
	mov r4, r0
	ldr r0, _02154F1C // =0x0217C2F4
	ldr r0, [r0]
	bl ovl08_2154F24
	bl ovl08_21542D8
	ldr r0, _02154F20 // =0x0217B044
	ldr r0, [r0]
	mov r1, #0
	mvn r1, r1
	cmp r0, r1
	beq _02154EEC
	bl ovl08_2152AA4
_02154EEC:
	mov r0, r4
	pop {r4}
	pop {r3}
	bx r3
	.align 2, 0
_02154EF4: .word 0x00000106
_02154EF8: .word 0x00000108
_02154EFC: .word 0x0000010A
_02154F00: .word 0x0000010C
_02154F04: .word 0x0000010E
_02154F08: .word 0x00000100
_02154F0C: .word 0x0217D0AC
_02154F10: .word 0x0217D0B8
_02154F14: .word 0x00000116
_02154F18: .word 0x000005F8
_02154F1C: .word 0x0217C2F4
_02154F20: .word 0x0217B044
	thumb_func_end ovl08_2154E1C

	thumb_func_start ovl08_2154F24
ovl08_2154F24: // 0x02154F24
	push {lr}
	sub sp, #4
	ldr r1, _02154F34 // =0x0217D0B8
	ldr r1, [r1]
	blx r1
	add sp, #4
	pop {r3}
	bx r3
	.align 2, 0
_02154F34: .word 0x0217D0B8
	thumb_func_end ovl08_2154F24

	thumb_func_start ovl08_2154F38
ovl08_2154F38: // 0x02154F38
	push {lr}
	sub sp, #4
	ldr r1, _02154F48 // =0x0217D0AC
	ldr r1, [r1]
	blx r1
	add sp, #4
	pop {r3}
	bx r3
	.align 2, 0
_02154F48: .word 0x0217D0AC
	thumb_func_end ovl08_2154F38

	thumb_func_start ovl08_2154F4C
ovl08_2154F4C: // 0x02154F4C
	push {lr}
	sub sp, #4
	ldr r1, _02154F64 // =0x0217D0B0
	ldr r1, [r1]
	cmp r1, #0
	beq _02154F5A
	blx r1
_02154F5A:
	mov r0, #0
	add sp, #4
	pop {r3}
	bx r3
	nop
_02154F64: .word 0x0217D0B0
	thumb_func_end ovl08_2154F4C

	thumb_func_start ovl08_2154F68
ovl08_2154F68: // 0x02154F68
	ldr r3, _02154F6C // =OS_Sleep
	bx r3
	.align 2, 0
_02154F6C: .word OS_Sleep
	thumb_func_end ovl08_2154F68

	thumb_func_start ovl08_2154F70
ovl08_2154F70: // 0x02154F70
	push {r4, r5, r6, r7, lr}
	sub sp, #0x4c
	str r0, [sp, #4]
	str r1, [sp, #8]
	mov r4, #1
	mov r0, #0
	str r0, [sp, #0x14]
	mvn r0, r0
	str r0, [sp, #0xc]
	ldr r0, [sp, #4]
	ldr r0, [r0, #0x24]
	cmp r0, #0
	bne _02154F8E
	ldr r6, _0215512C // =0x00080000
	b _02154F94
_02154F8E:
	cmp r0, #1
	bne _02154F94
	ldr r6, _02155130 // =0x000C0000
_02154F94:
	ldr r0, _02155134 // =0x0217D0EC
	mov r1, #0
	mov r2, #0x60
	blx MI_CpuFill8
	ldr r0, [sp, #4]
	ldr r0, [r0, #0x28]
	cmp r0, #5
	bne _02154FAE
	mov r1, #1
	ldr r0, _02155134 // =0x0217D0EC
	strb r1, [r0]
	b _02154FD2
_02154FAE:
	cmp r0, #0xd
	bne _02154FBA
	mov r1, #2
	ldr r0, _02155134 // =0x0217D0EC
	strb r1, [r0]
	b _02154FD2
_02154FBA:
	cmp r0, #0x10
	bne _02154FC6
	mov r1, #3
	ldr r0, _02155134 // =0x0217D0EC
	strb r1, [r0]
	b _02154FD2
_02154FC6:
	mov r0, #0
	mvn r0, r0
	add sp, #0x4c
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02154FD2:
	mov r1, #0
	ldr r0, _02155134 // =0x0217D0EC
	strb r1, [r0, #1]
	ldr r0, [sp, #4]
	add r0, #0x2c
	ldr r1, _02155138 // =0x0217D0EE
	ldr r2, [sp, #4]
	ldr r2, [r2, #0x28]
	blx MI_CpuCopy8
	blx WCM_ClearApList
	mov r0, #0
	ldr r1, [sp, #4]
	add r1, r1, #4
	ldr r2, [sp, #4]
	ldr r2, [r2]
	ldr r3, _0215513C // =0x0030BFFE
	bl ovl08_215586C
	cmp r0, #0
	bne _02155000
	b _0215510E
_02155000:
	mov r0, #0
	str r0, [sp, #0x10]
	add r0, sp, #0x1c
	blx OS_CreateAlarm
	mov r0, #0x12
	str r0, [sp]
	add r0, sp, #0x1c
	ldr r1, _02155140 // =0x003FEC42
	mov r2, #0
	ldr r3, _02155144 // =ovl08_21554CC
	blx OS_SetAlarm
	ldr r0, _02155148 // =0x00030000
	orr r6, r0
	ldr r7, _0215514C // =0x0217D160
	mov r5, #0
_02155022:
	ldr r0, _02155150 // =0x0217D0CC
	add r1, sp, #0x18
	mov r2, #1
	blx OS_ReceiveMessage
	ldr r0, [sp, #0x18]
	cmp r0, #0x13
	bhi _021550EE
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #8]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add r0, pc
	bx r0
_02155040: // jump table
	.hword _021550EE - _02155040 + 1 // case 0
	.hword _021550EE - _02155040 + 1 // case 1
	.hword _021550EE - _02155040 + 1 // case 2
	.hword _021550EE - _02155040 + 1 // case 3
	.hword _021550F0 - _02155040 + 1 // case 4
	.hword _02155072 - _02155040 + 1 // case 5
	.hword _021550EE - _02155040 + 1 // case 6
	.hword _021550EE - _02155040 + 1 // case 7
	.hword _021550F0 - _02155040 + 1 // case 8
	.hword _021550EE - _02155040 + 1 // case 9
	.hword _021550AE - _02155040 + 1 // case 10
	.hword _021550EE - _02155040 + 1 // case 11
	.hword _021550C8 - _02155040 + 1 // case 12
	.hword _021550CE - _02155040 + 1 // case 13
	.hword _021550EE - _02155040 + 1 // case 14
	.hword _021550EE - _02155040 + 1 // case 15
	.hword _021550EE - _02155040 + 1 // case 16
	.hword _021550EE - _02155040 + 1 // case 17
	.hword _02155068 - _02155040 + 1 // case 18
	.hword _021550F0 - _02155040 + 1 // case 19
_02155068:
	ldr r0, [sp, #0x14]
	cmp r0, #0
	bne _021550F0
	mov r4, r5
	b _021550F0
_02155072:
	ldr r0, [sp, #0x14]
	cmp r0, #0
	bne _021550F0
	add r0, sp, #0x1c
	blx OS_CancelAlarm
	mov r0, r7
	mov r1, #1
	bl ovl08_2155980
	cmp r0, #1
	beq _0215508E
	mov r4, r5
	b _021550F0
_0215508E:
	ldr r0, [sp, #4]
	mov r1, r7
	bl sub_2155504
	mov r0, r7
	ldr r1, _02155134 // =0x0217D0EC
	mov r2, r6
	bl ovl08_21556D0
	cmp r0, #0
	bne _021550A8
	mov r4, r5
	b _021550F0
_021550A8:
	mov r0, #1
	str r0, [sp, #0x14]
	b _021550F0
_021550AE:
	ldr r0, [sp, #4]
	mov r1, r7
	bl sub_2155504
	mov r0, r7
	ldr r1, _02155134 // =0x0217D0EC
	mov r2, r6
	bl ovl08_21556D0
	cmp r0, #0
	bne _021550F0
	mov r4, r5
	b _021550F0
_021550C8:
	str r5, [sp, #0xc]
	mov r4, r5
	b _021550F0
_021550CE:
	ldr r0, [sp, #0x10]
	add r0, r0, #1
	str r0, [sp, #0x10]
	cmp r0, #3
	bge _021550EA
	mov r0, r7
	ldr r1, _02155134 // =0x0217D0EC
	mov r2, r6
	bl ovl08_21556D0
	cmp r0, #0
	bne _021550F0
	mov r4, r5
	b _021550F0
_021550EA:
	mov r4, r5
	b _021550F0
_021550EE:
	mov r4, r5
_021550F0:
	cmp r4, #0
	bne _02155022
	add r0, sp, #0x1c
	blx OS_CancelAlarm
	ldr r5, _02155150 // =0x0217D0CC
	add r4, sp, #0x18
	mov r6, #0
_02155100:
	mov r0, r5
	mov r1, r4
	mov r2, r6
	blx OS_ReceiveMessage
	cmp r0, #1
	beq _02155100
_0215510E:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	bne _02155118
	mov r2, #1
	b _0215511A
_02155118:
	mov r2, #0
_0215511A:
	ldr r0, [sp, #8]
	ldr r1, _0215514C // =0x0217D160
	bl ovl08_21554F4
	ldr r0, [sp, #0xc]
	add sp, #0x4c
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_0215512C: .word 0x00080000
_02155130: .word 0x000C0000
_02155134: .word 0x0217D0EC
_02155138: .word 0x0217D0EE
_0215513C: .word 0x0030BFFE
_02155140: .word 0x003FEC42
_02155144: .word ovl08_21554CC
_02155148: .word 0x00030000
_0215514C: .word 0x0217D160
_02155150: .word 0x0217D0CC
	thumb_func_end ovl08_2154F70

	thumb_func_start ovl08_2155154
ovl08_2155154: // 0x02155154
	push {r4, r5, r6, r7, lr}
	sub sp, #0x44
	str r0, [sp, #4]
	mov r6, #0
	mvn r0, r6
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	mov r7, r6
	mov r5, r6
	ldr r0, _021552C8 // =0x0217D0AC
	ldr r1, [r0]
	cmp r1, #0
	beq _02155178
	ldr r0, _021552CC // =0x0217D0B8
	ldr r0, [r0]
	cmp r0, #0
	bne _02155184
_02155178:
	mov r0, #0
	mvn r0, r0
	add sp, #0x44
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02155184:
	ldr r0, _021552D0 // =0x00003000
	blx r1
	mov r4, r0
	cmp r4, #0
	bne _0215519A
	lsl r0, r6, #0
	mvn r0, r0
	add sp, #0x44
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215519A:
	str r4, [sp, #0x10]
	lsl r0, r6, #0
	mov r1, r0
	mov r2, r0
	ldr r3, _021552D4 // =0x0030BFFE
	bl ovl08_215586C
	cmp r0, #0
	bne _021551AE
	b _021552B4
_021551AE:
	add r0, sp, #0x18
	blx OS_CreateAlarm
	mov r0, #0x13
	str r0, [sp]
	add r0, sp, #0x18
	ldr r1, _021552D8 // =0x003FEC42
	lsl r2, r6, #0
	ldr r3, _021552DC // =ovl08_21554CC
	blx OS_SetAlarm
_021551C4:
	ldr r0, _021552E0 // =0x0217D0CC
	add r1, sp, #0x14
	mov r2, #1
	blx OS_ReceiveMessage
	ldr r0, [sp, #0x14]
	cmp r0, #0x13
	bhi _0215529A
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #8]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add r0, pc
	bx r0
_021551E2: // jump table
	.hword _0215529A - _021551E2 + 1 // case 0
	.hword _0215529A - _021551E2 + 1 // case 1
	.hword _0215529A - _021551E2 + 1 // case 2
	.hword _0215529A - _021551E2 + 1 // case 3
	.hword _02155250 - _021551E2 + 1 // case 4
	.hword _02155228 - _021551E2 + 1 // case 5
	.hword _0215529A - _021551E2 + 1 // case 6
	.hword _0215529A - _021551E2 + 1 // case 7
	.hword _02155250 - _021551E2 + 1 // case 8
	.hword _0215529A - _021551E2 + 1 // case 9
	.hword _0215524A - _021551E2 + 1 // case 10
	.hword _0215529A - _021551E2 + 1 // case 11
	.hword _0215529A - _021551E2 + 1 // case 12
	.hword _0215529A - _021551E2 + 1 // case 13
	.hword _0215529A - _021551E2 + 1 // case 14
	.hword _0215529A - _021551E2 + 1 // case 15
	.hword _0215529A - _021551E2 + 1 // case 16
	.hword _0215529A - _021551E2 + 1 // case 17
	.hword _02155250 - _021551E2 + 1 // case 18
	.hword _0215520A - _021551E2 + 1 // case 19
_0215520A:
	cmp r6, #0
	bne _02155250
	cmp r5, #0
	beq _0215521C
	mov r0, r4
	mov r1, #0x40
	bl ovl08_2155980
	mov r7, r0
_0215521C:
	bl ovl08_2155828
	cmp r0, #0
	beq _0215529A
	mov r6, #1
	b _02155250
_02155228:
	cmp r6, #0
	bne _02155250
	cmp r5, #8
	bge _02155234
	add r5, r5, #1
	b _02155250
_02155234:
	mov r0, r4
	mov r1, #0x40
	bl ovl08_2155980
	mov r7, r0
	bl ovl08_2155828
	cmp r0, #0
	beq _0215529A
	mov r6, #1
	b _02155250
_0215524A:
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #8]
_02155250:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	bne _021551C4
	cmp r7, #0
	beq _0215526E
	sub r0, r7, #1
	mov r1, #0x54
	mul r0, r1
	add r0, #0x58
	ldr r1, _021552C8 // =0x0217D0AC
	ldr r1, [r1]
	blx r1
	cmp r0, #0
	bne _0215527A
	b _0215529A
_0215526E:
	mov r0, #0x58
	ldr r1, _021552C8 // =0x0217D0AC
	ldr r1, [r1]
	blx r1
	cmp r0, #0
	beq _0215529A
_0215527A:
	ldr r1, [sp, #4]
	str r0, [r1]
	str r7, [r0]
	mov r6, #0
	cmp r7, #0
	ble _0215529A
	add r5, r0, #4
_02155288:
	mov r0, r4
	mov r1, r5
	bl sub_2155538
	add r4, #0xc0
	add r5, #0x54
	add r6, r6, #1
	cmp r6, r7
	blt _02155288
_0215529A:
	add r0, sp, #0x18
	blx OS_CancelAlarm
	ldr r5, _021552E0 // =0x0217D0CC
	add r4, sp, #0x14
	mov r6, #0
_021552A6:
	mov r0, r5
	mov r1, r4
	mov r2, r6
	blx OS_ReceiveMessage
	cmp r0, #1
	beq _021552A6
_021552B4:
	ldr r0, [sp, #0x10]
	ldr r1, _021552CC // =0x0217D0B8
	ldr r1, [r1]
	blx r1
	ldr r0, [sp, #8]
	add sp, #0x44
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_021552C8: .word 0x0217D0AC
_021552CC: .word 0x0217D0B8
_021552D0: .word 0x00003000
_021552D4: .word 0x0030BFFE
_021552D8: .word 0x003FEC42
_021552DC: .word ovl08_21554CC
_021552E0: .word 0x0217D0CC
	thumb_func_end ovl08_2155154

	thumb_func_start ovl08_21552E4
ovl08_21552E4: // 0x021552E4
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r0, #0
	mvn r4, r0
	bl ovl08_21557E8
	cmp r0, #0
	beq _02155310
	mov r5, #0
	ldr r6, _0215531C // =0x0217D0CC
	add r7, sp, #0
_021552FA:
	mov r0, r6
	mov r1, r7
	mov r2, #1
	blx OS_ReceiveMessage
	ldr r0, [sp]
	cmp r0, #0xe
	bne _0215530C
	mov r4, r5
_0215530C:
	cmp r5, #0
	bne _021552FA
_02155310:
	mov r0, r4
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_0215531C: .word 0x0217D0CC
	thumb_func_end ovl08_21552E4

	thumb_func_start ovl08_2155320
ovl08_2155320: // 0x02155320
	push {r4, r5, lr}
	sub sp, #4
	mov r4, #1
	mov r0, #0
	mvn r5, r0
	ldr r0, _021553CC // =0x0217D0B8
	ldr r0, [r0]
	cmp r0, #0
	bne _0215533C
	mov r0, r5
	add sp, #4
	pop {r4, r5}
	pop {r3}
	bx r3
_0215533C:
	bl ovl08_2155780
	cmp r0, #0
	bne _02155350
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5}
	pop {r3}
	bx r3
_02155350:
	ldr r0, _021553D0 // =0x0217D0CC
	add r1, sp, #0
	mov r2, #1
	blx OS_ReceiveMessage
	ldr r0, [sp]
	cmp r0, #0x14
	bhi _021553A8
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #8]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add r0, pc
	bx r0
_0215536E: // jump table
	.hword _021553A8 - _0215536E + 1 // case 0
	.hword _021553A8 - _0215536E + 1 // case 1
	.hword _021553A8 - _0215536E + 1 // case 2
	.hword _021553A8 - _0215536E + 1 // case 3
	.hword _021553AA - _0215536E + 1 // case 4
	.hword _021553AA - _0215536E + 1 // case 5
	.hword _021553A8 - _0215536E + 1 // case 6
	.hword _021553A8 - _0215536E + 1 // case 7
	.hword _021553A8 - _0215536E + 1 // case 8
	.hword _021553A8 - _0215536E + 1 // case 9
	.hword _021553A8 - _0215536E + 1 // case 10
	.hword _021553A8 - _0215536E + 1 // case 11
	.hword _021553A8 - _0215536E + 1 // case 12
	.hword _021553A8 - _0215536E + 1 // case 13
	.hword _021553A8 - _0215536E + 1 // case 14
	.hword _021553A8 - _0215536E + 1 // case 15
	.hword _021553A8 - _0215536E + 1 // case 16
	.hword _021553A8 - _0215536E + 1 // case 17
	.hword _021553A8 - _0215536E + 1 // case 18
	.hword _021553A8 - _0215536E + 1 // case 19
	.hword _02155398 - _0215536E + 1 // case 20
_02155398:
	mov r4, #0
	mov r5, r4
	ldr r0, _021553D4 // =0x0217D0B4
	ldr r0, [r0]
	ldr r1, _021553CC // =0x0217D0B8
	ldr r1, [r1]
	blx r1
	b _021553AA
_021553A8:
	mov r4, #0
_021553AA:
	cmp r4, #0
	bne _02155350
	blx OS_DisableInterrupts
	mov r2, #0
	ldr r1, _021553D8 // =0x0217D0AC
	str r2, [r1]
	ldr r1, _021553CC // =0x0217D0B8
	str r2, [r1]
	blx OS_RestoreInterrupts
	mov r0, r5
	add sp, #4
	pop {r4, r5}
	pop {r3}
	bx r3
	nop
_021553CC: .word 0x0217D0B8
_021553D0: .word 0x0217D0CC
_021553D4: .word 0x0217D0B4
_021553D8: .word 0x0217D0AC
	thumb_func_end ovl08_2155320

	thumb_func_start ovl08_21553DC
ovl08_21553DC: // 0x021553DC
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	mov r6, r1
	mov r4, #1
	ldr r0, _021554B0 // =0x0217D0CC
	ldr r1, _021554B4 // =0x0217D0BC
	mov r2, #4
	blx OS_InitMessageQueue
	cmp r5, #0
	beq _021553F8
	cmp r6, #0
	bne _02155404
_021553F8:
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02155404:
	blx OS_DisableInterrupts
	ldr r1, _021554B8 // =0x0217D0AC
	str r5, [r1]
	ldr r1, _021554BC // =0x0217D0B8
	str r6, [r1]
	blx OS_RestoreInterrupts
	ldr r0, _021554C0 // =0x00005890
	ldr r1, _021554B8 // =0x0217D0AC
	ldr r1, [r1]
	blx r1
	mov r1, r0
	ldr r0, _021554C4 // =0x0217D0B4
	str r1, [r0]
	cmp r1, #0
	bne _02155432
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02155432:
	ldr r0, _021554C8 // =ovl08_21554E0
	ldr r2, _021554C0 // =0x00005890
	bl ovl08_21555D8
	cmp r0, #0
	bne _02155440
	mov r4, #0
_02155440:
	cmp r4, #0
	beq _02155498
	ldr r5, _021554B0 // =0x0217D0CC
	add r6, sp, #0
	mov r7, #1
_0215544A:
	mov r0, r5
	mov r1, r6
	mov r2, r7
	blx OS_ReceiveMessage
	ldr r0, [sp]
	cmp r0, #0xf
	bhi _02155492
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #8]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add r0, pc
	bx r0
_02155468: // jump table
	.hword _02155492 - _02155468 + 1 // case 0
	.hword _02155492 - _02155468 + 1 // case 1
	.hword _02155492 - _02155468 + 1 // case 2
	.hword _02155492 - _02155468 + 1 // case 3
	.hword _02155494 - _02155468 + 1 // case 4
	.hword _02155494 - _02155468 + 1 // case 5
	.hword _02155488 - _02155468 + 1 // case 6
	.hword _02155492 - _02155468 + 1 // case 7
	.hword _02155492 - _02155468 + 1 // case 8
	.hword _02155492 - _02155468 + 1 // case 9
	.hword _02155492 - _02155468 + 1 // case 10
	.hword _02155492 - _02155468 + 1 // case 11
	.hword _02155492 - _02155468 + 1 // case 12
	.hword _02155492 - _02155468 + 1 // case 13
	.hword _02155492 - _02155468 + 1 // case 14
	.hword _02155492 - _02155468 + 1 // case 15
_02155488:
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02155492:
	mov r4, #0
_02155494:
	cmp r4, #0
	bne _0215544A
_02155498:
	ldr r0, _021554C4 // =0x0217D0B4
	ldr r0, [r0]
	ldr r1, _021554BC // =0x0217D0B8
	ldr r1, [r1]
	blx r1
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_021554B0: .word 0x0217D0CC
_021554B4: .word 0x0217D0BC
_021554B8: .word 0x0217D0AC
_021554BC: .word 0x0217D0B8
_021554C0: .word 0x00005890
_021554C4: .word 0x0217D0B4
_021554C8: .word ovl08_21554E0
	thumb_func_end ovl08_21553DC

	thumb_func_start ovl08_21554CC
ovl08_21554CC: // 0x021554CC
	mov r1, r0
	ldr r0, _021554D8 // =0x0217D0CC
	mov r2, #0
	ldr r3, _021554DC // =OS_SendMessage
	bx r3
	nop
_021554D8: .word 0x0217D0CC
_021554DC: .word OS_SendMessage
	thumb_func_end ovl08_21554CC

	thumb_func_start ovl08_21554E0
ovl08_21554E0: // 0x021554E0
	mov r1, r0
	ldr r0, _021554EC // =0x0217D0CC
	mov r2, #0
	ldr r3, _021554F0 // =OS_SendMessage
	bx r3
	nop
_021554EC: .word 0x0217D0CC
_021554F0: .word OS_SendMessage
	thumb_func_end ovl08_21554E0

	thumb_func_start ovl08_21554F4
ovl08_21554F4: // 0x021554F4
	mov r3, r0
	str r2, [r3]
	mov r0, r1
	add r1, r3, #4
	ldr r3, _02155500 // =sub_2155538
	bx r3
	.align 2, 0
_02155500: .word sub_2155538
	thumb_func_end ovl08_21554F4

	thumb_func_start sub_2155504
sub_2155504: // 0x02155504
	push {r4, r5, lr}
	sub sp, #4
	mov r5, r0
	mov r4, r1
	mov r1, #0
	add r0, sp, #0
	strh r1, [r0]
	ldrh r0, [r0]
	mov r1, r4
	add r1, #0xc
	mov r2, #0x20
	blx MIi_CpuClear16
	ldr r0, [r5]
	strh r0, [r4, #0xa]
	add r0, r5, #4
	mov r1, r4
	add r1, #0xc
	ldrh r2, [r4, #0xa]
	blx MI_CpuCopy8
	add sp, #4
	pop {r4, r5}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end sub_2155504

	thumb_func_start sub_2155538
sub_2155538: // 0x02155538
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	mov r4, r1
	ldrh r0, [r5, #0xa]
	str r0, [r4]
	mov r0, r5
	add r0, #0xc
	add r1, r4, #4
	mov r2, #0x20
	blx MIi_CpuCopy16
	ldrh r0, [r5, #0x36]
	str r0, [r4, #0x24]
	add r0, r5, #4
	mov r1, r4
	add r1, #0x30
	mov r2, #6
	blx MIi_CpuCopy16
	mov r2, #0
	mov r3, r2
	ldr r1, _021555D4 // =0x0217B0BC
_02155566:
	ldrh r6, [r5, #0x30]
	ldrh r0, [r1]
	and r6, r0
	cmp r6, #0
	beq _02155594
	add r0, r4, r2
	ldrb r7, [r1, #2]
	mov r6, r0
	add r6, #0x3c
	strb r7, [r6]
	ldrh r7, [r5, #0x2e]
	ldrh r6, [r1]
	and r7, r6
	cmp r7, #0
	beq _02155592
	mov r6, r0
	add r6, #0x3c
	ldrb r7, [r6]
	mov r6, #0x80
	orr r7, r6
	add r0, #0x3c
	strb r7, [r0]
_02155592:
	add r2, r2, #1
_02155594:
	add r1, r1, #4
	add r3, r3, #1
	cmp r3, #0xc
	blt _02155566
	str r2, [r4, #0x38]
	ldrh r0, [r5, #0x32]
	str r0, [r4, #0x4c]
	ldrh r1, [r5, #0x2c]
	mov r0, #3
	and r1, r0
	cmp r1, #1
	bne _021555B8
	mov r0, #1
	str r0, [r4, #0x50]
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021555B8:
	cmp r1, #2
	bne _021555C8
	mov r0, #2
	str r0, [r4, #0x50]
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021555C8:
	mov r0, #0
	str r0, [r4, #0x50]
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_021555D4: .word 0x0217B0BC
	thumb_func_end sub_2155538

	thumb_func_start ovl08_21555D8
ovl08_21555D8: // 0x021555D8
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r6, r0
	mov r5, r1
	mov r7, r2
	blx OS_DisableInterrupts
	mov r4, r0
	ldr r0, _021556AC // =0x0217D244
	str r5, [r0]
	mov r2, r5
	add r2, #0x53
	mov r0, #3
	bic r2, r0
	ldr r0, _021556B0 // =0x0217D228
	str r2, [r0]
	mov r1, r2
	add r1, #0x2f
	mov r3, #0x1f
	bic r1, r3
	ldr r3, _021556B4 // =0x0217D220
	str r1, [r3]
	ldr r3, _021556B8 // =0x0000231F
	add r1, r1, r3
	mov r3, #0x1f
	bic r1, r3
	ldr r3, _021556BC // =0x0217D240
	str r1, [r3]
	add r1, #0xdf
	mov r3, #0x1f
	bic r1, r3
	str r1, [r2, #4]
	ldr r1, [r0]
	add r3, r5, r7
	ldr r2, [r1, #4]
	sub r2, r3, r2
	str r2, [r1, #8]
	mov r2, #0
	ldr r1, [r0]
	str r2, [r1, #0xc]
	ldr r1, [r0]
	mov r0, #3
	str r0, [r1]
	ldr r0, _021556C0 // =0x0217D23C
	str r6, [r0]
	ldr r0, _021556C4 // =0x0217D238
	ldr r0, [r0]
	cmp r0, #0
	bne _0215565E
	ldr r0, _021556B4 // =0x0217D220
	ldr r0, [r0]
	ldr r1, _021556C8 // =0x00002300
	blx WCM_Init
	cmp r0, #0
	beq _02155658
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02155658:
	mov r1, #1
	ldr r0, _021556C4 // =0x0217D238
	str r1, [r0]
_0215565E:
	ldr r0, _021556C4 // =0x0217D238
	ldr r0, [r0]
	cmp r0, #1
	bne _0215569A
	ldr r0, _021556B0 // =0x0217D228
	ldr r0, [r0]
	ldr r1, _021556CC // =ovl08_2155A50
	blx WCM_StartupAsync
	cmp r0, #3
	beq _02155684
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02155684:
	mov r1, #4
	ldr r0, _021556C4 // =0x0217D238
	str r1, [r0]
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #1
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215569A:
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_021556AC: .word 0x0217D244
_021556B0: .word 0x0217D228
_021556B4: .word 0x0217D220
_021556B8: .word 0x0000231F
_021556BC: .word 0x0217D240
_021556C0: .word 0x0217D23C
_021556C4: .word 0x0217D238
_021556C8: .word 0x00002300
_021556CC: .word ovl08_2155A50
	thumb_func_end ovl08_21555D8

	thumb_func_start ovl08_21556D0
ovl08_21556D0: // 0x021556D0
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r7, r0
	mov r5, r1
	mov r6, r2
	blx OS_DisableInterrupts
	mov r4, r0
	ldr r0, _02155770 // =0x0217D22C
	str r6, [r0]
	cmp r5, #0
	beq _021556F6
	mov r0, r5
	ldr r1, _02155774 // =0x0217D244
	ldr r1, [r1]
	mov r2, #0x50
	blx MI_CpuCopy8
	b _02155702
_021556F6:
	ldr r0, _02155774 // =0x0217D244
	ldr r0, [r0]
	mov r1, #0
	mov r2, #0x50
	blx MI_CpuFill8
_02155702:
	mov r0, r7
	ldr r1, _02155778 // =0x0217D240
	ldr r1, [r1]
	mov r2, #0xc0
	blx MIi_CpuCopy32
	bl ovl08_21559CC
	cmp r0, #1
	bne _0215572C
	mov r1, #8
	ldr r0, _0215577C // =0x0217D238
	str r1, [r0]
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #1
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215572C:
	ldr r0, _0215577C // =0x0217D238
	ldr r0, [r0]
	cmp r0, #3
	bne _0215575E
	ldr r0, _02155778 // =0x0217D240
	ldr r0, [r0]
	ldr r1, _02155774 // =0x0217D244
	ldr r1, [r1]
	ldr r2, _02155770 // =0x0217D22C
	ldr r2, [r2]
	blx WCM_ConnectAsync
	cmp r0, #3
	bne _0215575E
	mov r1, #8
	ldr r0, _0215577C // =0x0217D238
	str r1, [r0]
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #1
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215575E:
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_02155770: .word 0x0217D22C
_02155774: .word 0x0217D244
_02155778: .word 0x0217D240
_0215577C: .word 0x0217D238
	thumb_func_end ovl08_21556D0

	thumb_func_start ovl08_2155780
ovl08_2155780: // 0x02155780
	push {r4, lr}
	blx OS_DisableInterrupts
	mov r4, r0
	ldr r0, _021557E4 // =0x0217D238
	ldr r0, [r0]
	cmp r0, #3
	bne _021557BA
	blx WCM_CleanupAsync
	cmp r0, #3
	beq _021557A6
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	pop {r4}
	pop {r3}
	bx r3
_021557A6:
	mov r1, #2
	ldr r0, _021557E4 // =0x0217D238
	str r1, [r0]
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #1
	pop {r4}
	pop {r3}
	bx r3
_021557BA:
	bl ovl08_21559CC
	cmp r0, #1
	bne _021557D6
	mov r1, #2
	ldr r0, _021557E4 // =0x0217D238
	str r1, [r0]
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #1
	pop {r4}
	pop {r3}
	bx r3
_021557D6:
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	pop {r4}
	pop {r3}
	bx r3
	.align 2, 0
_021557E4: .word 0x0217D238
	thumb_func_end ovl08_2155780

	thumb_func_start ovl08_21557E8
ovl08_21557E8: // 0x021557E8
	push {r4, lr}
	blx OS_DisableInterrupts
	mov r4, r0
	ldr r0, _02155824 // =0x0217D238
	ldr r0, [r0]
	cmp r0, #7
	bne _02155814
	blx WCM_DisconnectAsync
	cmp r0, #3
	bne _02155814
	mov r1, #4
	ldr r0, _02155824 // =0x0217D238
	str r1, [r0]
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #1
	pop {r4}
	pop {r3}
	bx r3
_02155814:
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	pop {r4}
	pop {r3}
	bx r3
	nop
_02155824: .word 0x0217D238
	thumb_func_end ovl08_21557E8

	thumb_func_start ovl08_2155828
ovl08_2155828: // 0x02155828
	push {r4, lr}
	blx OS_DisableInterrupts
	mov r4, r0
	ldr r0, _02155868 // =0x0217D238
	ldr r0, [r0]
	cmp r0, #5
	bne _0215585A
	mov r0, #0
	mov r1, r0
	mov r2, r0
	blx WCM_SearchAsync
	cmp r0, #3
	bne _0215585A
	mov r1, #4
	ldr r0, _02155868 // =0x0217D238
	str r1, [r0]
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #1
	pop {r4}
	pop {r3}
	bx r3
_0215585A:
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	pop {r4}
	pop {r3}
	bx r3
	.align 2, 0
_02155868: .word 0x0217D238
	thumb_func_end ovl08_2155828

	thumb_func_start ovl08_215586C
ovl08_215586C: // 0x0215586C
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	str r3, [sp]
	blx OS_DisableInterrupts
	mov r7, r0
	ldr r1, _02155960 // =0x0217D224
	ldr r0, [sp]
	str r0, [r1]
	cmp r5, #0
	beq _021558A2
	mov r2, #0
	ldr r1, _02155964 // =0x0217D248
_0215588C:
	ldrb r0, [r5]
	add r5, r5, #1
	strb r0, [r1]
	add r1, r1, #1
	add r2, r2, #1
	cmp r2, #6
	blt _0215588C
	ldr r1, _02155964 // =0x0217D248
	ldr r0, _02155968 // =0x0217D230
	str r1, [r0]
	b _021558B2
_021558A2:
	ldr r0, _02155964 // =0x0217D248
	mov r1, #0xff
	mov r2, #6
	blx MI_CpuFill8
	ldr r1, _0215596C // =0x0211279C
	ldr r0, _02155968 // =0x0217D230
	str r1, [r0]
_021558B2:
	cmp r4, #0
	beq _021558F0
	cmp r6, #0
	ble _021558F0
	cmp r6, #0x20
	bgt _021558F0
	mov r1, #0
	cmp r6, #0
	ble _021558D4
	ldr r2, _02155970 // =0x0217D250
_021558C6:
	ldrb r0, [r4]
	add r4, r4, #1
	strb r0, [r2]
	add r2, r2, #1
	add r1, r1, #1
	cmp r1, r6
	blt _021558C6
_021558D4:
	cmp r1, #0x20
	bge _021558E8
	ldr r0, _02155970 // =0x0217D250
	add r2, r0, r1
	mov r0, #0
_021558DE:
	strb r0, [r2]
	add r2, r2, #1
	add r1, r1, #1
	cmp r1, #0x20
	blt _021558DE
_021558E8:
	ldr r1, _02155970 // =0x0217D250
	ldr r0, _02155974 // =0x0217D234
	str r1, [r0]
	b _02155900
_021558F0:
	ldr r0, _02155970 // =0x0217D250
	mov r1, #0xff
	mov r2, #0x20
	blx MI_CpuFill8
	ldr r1, _02155978 // =0x021127A4
	ldr r0, _02155974 // =0x0217D234
	str r1, [r0]
_02155900:
	ldr r0, _0215597C // =0x0217D238
	ldr r0, [r0]
	cmp r0, #3
	bne _02155932
	ldr r0, _02155968 // =0x0217D230
	ldr r0, [r0]
	ldr r1, _02155974 // =0x0217D234
	ldr r1, [r1]
	ldr r2, _02155960 // =0x0217D224
	ldr r2, [r2]
	blx WCM_SearchAsync
	cmp r0, #3
	bne _02155950
	mov r1, #6
	ldr r0, _0215597C // =0x0217D238
	str r1, [r0]
	mov r0, r7
	blx OS_RestoreInterrupts
	mov r0, #1
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02155932:
	bl ovl08_21559CC
	cmp r0, #1
	bne _02155950
	mov r1, #6
	ldr r0, _0215597C // =0x0217D238
	str r1, [r0]
	mov r0, r7
	blx OS_RestoreInterrupts
	mov r0, #1
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02155950:
	mov r0, r7
	blx OS_RestoreInterrupts
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02155960: .word 0x0217D224
_02155964: .word 0x0217D248
_02155968: .word 0x0217D230
_0215596C: .word 0x0211279C
_02155970: .word 0x0217D250
_02155974: .word 0x0217D234
_02155978: .word 0x021127A4
_0215597C: .word 0x0217D238
	thumb_func_end ovl08_215586C

	thumb_func_start ovl08_2155980
ovl08_2155980: // 0x02155980
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	mov r7, r1
	mov r0, #1
	blx WCM_LockApList
	blx WCM_CountApList
	mov r6, r0
	cmp r6, #0
	ble _021559BA
	mov r4, #0
	cmp r6, #0
	ble _021559BA
_0215599E:
	cmp r4, r7
	bge _021559BA
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	blx WCM_PointApListLinkLevel
	mov r1, r5
	mov r2, #0xc0
	blx MIi_CpuCopy32
	add r4, r4, #1
	add r5, #0xc0
	cmp r4, r6
	blt _0215599E
_021559BA:
	mov r0, #0
	blx WCM_LockApList
	mov r0, r6
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_2155980

	thumb_func_start ovl08_21559CC
ovl08_21559CC: // 0x021559CC
	push {lr}
	sub sp, #4
	ldr r0, _02155A44 // =0x0217D238
	ldr r0, [r0]
	cmp r0, #8
	bhi _02155A34
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #8]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add r0, pc
	bx r0
_021559E6: // jump table
	.hword _02155A34 - _021559E6 + 1 // case 0
	.hword _02155A1E - _021559E6 + 1 // case 1
	.hword _02155A34 - _021559E6 + 1 // case 2
	.hword _02155A34 - _021559E6 + 1 // case 3
	.hword _02155A34 - _021559E6 + 1 // case 4
	.hword _021559F8 - _021559E6 + 1 // case 5
	.hword _02155A34 - _021559E6 + 1 // case 6
	.hword _02155A0E - _021559E6 + 1 // case 7
	.hword _02155A34 - _021559E6 + 1 // case 8
_021559F8:
	mov r0, #0
	mov r1, r0
	mov r2, r0
	blx WCM_SearchAsync
	cmp r0, #3
	beq _02155A3C
	mov r0, #0
	add sp, #4
	pop {r3}
	bx r3
_02155A0E:
	blx WCM_DisconnectAsync
	cmp r0, #3
	beq _02155A3C
	mov r0, #0
	add sp, #4
	pop {r3}
	bx r3
_02155A1E:
	ldr r0, _02155A48 // =0x0217D228
	ldr r0, [r0]
	ldr r1, _02155A4C // =ovl08_2155A50
	blx WCM_StartupAsync
	cmp r0, #3
	beq _02155A3C
	mov r0, #0
	add sp, #4
	pop {r3}
	bx r3
_02155A34:
	mov r0, #0
	add sp, #4
	pop {r3}
	bx r3
_02155A3C:
	mov r0, #1
	add sp, #4
	pop {r3}
	bx r3
	.align 2, 0
_02155A44: .word 0x0217D238
_02155A48: .word 0x0217D228
_02155A4C: .word ovl08_2155A50
	thumb_func_end ovl08_21559CC

	thumb_func_start ovl08_2155A50
ovl08_2155A50: // 0x02155A50
	push {lr}
	sub sp, #4
	cmp r0, #0
	bne _02155A5A
	b _02155DD4
_02155A5A:
	mov r1, #0
	ldrsh r2, [r0, r1]
	cmp r2, #7
	bls _02155A64
	b _02155DC6
_02155A64:
	add r2, r2, r2
	add r2, pc
	ldrh r2, [r2, #8]
	lsl r2, r2, #0x10
	asr r2, r2, #0x10
	add r2, pc
	bx r2
_02155A72: // jump table
	.hword _02155DC6 - _02155A72 + 1 // case 0
	.hword _02155A82 - _02155A72 + 1 // case 1
	.hword _02155D68 - _02155A72 + 1 // case 2
	.hword _02155B32 - _02155A72 + 1 // case 3
	.hword _02155BBA - _02155A72 + 1 // case 4
	.hword _02155B76 - _02155A72 + 1 // case 5
	.hword _02155C94 - _02155A72 + 1 // case 6
	.hword _02155DAC - _02155A72 + 1 // case 7
_02155A82:
	mov r2, #2
	ldrsh r0, [r0, r2]
	cmp r0, #0
	bne _02155B18
	ldr r0, _02155DDC // =0x0217D238
	ldr r2, [r0]
	cmp r2, #4
	bne _02155AAA
	mov r2, #3
	str r2, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	bne _02155AA0
	b _02155DD4
_02155AA0:
	mov r0, #6
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155AAA:
	cmp r2, #6
	bne _02155AE0
	ldr r0, _02155DE4 // =0x0217D230
	ldr r0, [r0]
	ldr r1, _02155DE8 // =0x0217D234
	ldr r1, [r1]
	ldr r2, _02155DEC // =0x0217D224
	ldr r2, [r2]
	blx WCM_SearchAsync
	cmp r0, #3
	bne _02155AC4
	b _02155DD4
_02155AC4:
	mov r1, #3
	ldr r0, _02155DDC // =0x0217D238
	str r1, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	bne _02155AD4
	b _02155DD4
_02155AD4:
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155AE0:
	cmp r2, #8
	beq _02155AE6
	b _02155DD4
_02155AE6:
	ldr r0, _02155DF0 // =0x0217D240
	ldr r0, [r0]
	ldr r1, _02155DF4 // =0x0217D244
	ldr r1, [r1]
	ldr r2, _02155DF8 // =0x0217D22C
	ldr r2, [r2]
	blx WCM_ConnectAsync
	cmp r0, #3
	bne _02155AFC
	b _02155DD4
_02155AFC:
	mov r1, #3
	ldr r0, _02155DDC // =0x0217D238
	str r1, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	bne _02155B0C
	b _02155DD4
_02155B0C:
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155B18:
	mov r3, #1
	ldr r0, _02155DDC // =0x0217D238
	str r3, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r3, [r0]
	cmp r3, #0
	bne _02155B28
	b _02155DD4
_02155B28:
	mov r0, r2
	blx r3
	add sp, #4
	pop {r3}
	bx r3
_02155B32:
	mov r2, #2
	ldrsh r0, [r0, r2]
	cmp r0, #0
	bne _02155B5C
	ldr r0, _02155DDC // =0x0217D238
	ldr r2, [r0]
	cmp r2, #6
	beq _02155B44
	b _02155DD4
_02155B44:
	mov r2, #5
	str r2, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	bne _02155B52
	b _02155DD4
_02155B52:
	mov r0, #8
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155B5C:
	mov r2, #3
	ldr r0, _02155DDC // =0x0217D238
	str r2, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	bne _02155B6C
	b _02155DD4
_02155B6C:
	mov r0, #9
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155B76:
	mov r2, #2
	ldrsh r0, [r0, r2]
	cmp r0, #0
	bne _02155BA0
	ldr r0, _02155DDC // =0x0217D238
	ldr r2, [r0]
	cmp r2, #8
	beq _02155B88
	b _02155DD4
_02155B88:
	mov r2, #7
	str r2, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	bne _02155B96
	b _02155DD4
_02155B96:
	mov r0, #0xc
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155BA0:
	mov r2, #3
	ldr r0, _02155DDC // =0x0217D238
	str r2, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	bne _02155BB0
	b _02155DD4
_02155BB0:
	mov r0, #0xd
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155BBA:
	mov r2, #2
	ldrsh r0, [r0, r2]
	cmp r0, #0
	bne _02155C7A
	ldr r0, _02155DDC // =0x0217D238
	ldr r2, [r0]
	cmp r2, #4
	bne _02155BE2
	mov r2, #3
	str r2, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	bne _02155BD8
	b _02155DD4
_02155BD8:
	mov r0, #0xa
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155BE2:
	cmp r2, #6
	bne _02155C18
	ldr r0, _02155DE4 // =0x0217D230
	ldr r0, [r0]
	ldr r1, _02155DE8 // =0x0217D234
	ldr r1, [r1]
	ldr r2, _02155DEC // =0x0217D224
	ldr r2, [r2]
	blx WCM_SearchAsync
	cmp r0, #3
	bne _02155BFC
	b _02155DD4
_02155BFC:
	mov r1, #3
	ldr r0, _02155DDC // =0x0217D238
	str r1, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	bne _02155C0C
	b _02155DD4
_02155C0C:
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155C18:
	cmp r2, #2
	bne _02155C42
	blx WCM_CleanupAsync
	cmp r0, #3
	bne _02155C26
	b _02155DD4
_02155C26:
	mov r1, #3
	ldr r0, _02155DDC // =0x0217D238
	str r1, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	bne _02155C36
	b _02155DD4
_02155C36:
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155C42:
	cmp r2, #8
	beq _02155C48
	b _02155DD4
_02155C48:
	ldr r0, _02155DF0 // =0x0217D240
	ldr r0, [r0]
	ldr r1, _02155DF4 // =0x0217D244
	ldr r1, [r1]
	ldr r2, _02155DF8 // =0x0217D22C
	ldr r2, [r2]
	blx WCM_ConnectAsync
	cmp r0, #3
	bne _02155C5E
	b _02155DD4
_02155C5E:
	mov r1, #3
	ldr r0, _02155DDC // =0x0217D238
	str r1, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	bne _02155C6E
	b _02155DD4
_02155C6E:
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155C7A:
	mov r2, #3
	ldr r0, _02155DDC // =0x0217D238
	str r2, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	bne _02155C8A
	b _02155DD4
_02155C8A:
	mov r0, #0xb
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155C94:
	mov r2, #2
	ldrsh r0, [r0, r2]
	cmp r0, #0
	bne _02155D50
	ldr r0, _02155DDC // =0x0217D238
	ldr r2, [r0]
	cmp r2, #4
	bne _02155CBC
	mov r2, #3
	str r2, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	bne _02155CB2
	b _02155DD4
_02155CB2:
	mov r0, #0xe
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155CBC:
	cmp r2, #6
	bne _02155CEE
	ldr r0, _02155DE4 // =0x0217D230
	ldr r0, [r0]
	ldr r1, _02155DE8 // =0x0217D234
	ldr r1, [r1]
	ldr r2, _02155DEC // =0x0217D224
	ldr r2, [r2]
	blx WCM_SearchAsync
	cmp r0, #3
	beq _02155DD4
	mov r1, #3
	ldr r0, _02155DDC // =0x0217D238
	str r1, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	beq _02155DD4
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155CEE:
	cmp r2, #2
	bne _02155D14
	blx WCM_CleanupAsync
	cmp r0, #3
	beq _02155DD4
	mov r1, #3
	ldr r0, _02155DDC // =0x0217D238
	str r1, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	beq _02155DD4
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155D14:
	cmp r2, #8
	bne _02155D46
	ldr r0, _02155DF0 // =0x0217D240
	ldr r0, [r0]
	ldr r1, _02155DF4 // =0x0217D244
	ldr r1, [r1]
	ldr r2, _02155DF8 // =0x0217D22C
	ldr r2, [r2]
	blx WCM_ConnectAsync
	cmp r0, #3
	beq _02155DD4
	mov r1, #3
	ldr r0, _02155DDC // =0x0217D238
	str r1, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	beq _02155DD4
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155D46:
	mov r1, #3
	str r1, [r0]
	add sp, #4
	pop {r3}
	bx r3
_02155D50:
	mov r2, #3
	ldr r0, _02155DDC // =0x0217D238
	str r2, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	beq _02155DD4
	mov r0, #0xf
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155D68:
	mov r2, #2
	ldrsh r0, [r0, r2]
	cmp r0, #0
	bne _02155D94
	ldr r0, _02155DDC // =0x0217D238
	ldr r0, [r0]
	cmp r0, #2
	bne _02155DD4
	blx WCM_Finish
	mov r1, #0
	ldr r0, _02155DDC // =0x0217D238
	str r1, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	beq _02155DD4
	mov r0, #0x14
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155D94:
	mov r3, #3
	ldr r0, _02155DDC // =0x0217D238
	str r3, [r0]
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r3, [r0]
	cmp r3, #0
	beq _02155DD4
	mov r0, r2
	blx r3
	add sp, #4
	pop {r3}
	bx r3
_02155DAC:
	ldr r0, _02155DDC // =0x0217D238
	ldr r0, [r0]
	cmp r0, #5
	bne _02155DD4
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	beq _02155DD4
	mov r0, #5
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02155DC6:
	ldr r0, _02155DE0 // =0x0217D23C
	ldr r2, [r0]
	cmp r2, #0
	beq _02155DD4
	mov r0, #1
	mov r1, #0
	blx r2
_02155DD4:
	add sp, #4
	pop {r3}
	bx r3
	nop
_02155DDC: .word 0x0217D238
_02155DE0: .word 0x0217D23C
_02155DE4: .word 0x0217D230
_02155DE8: .word 0x0217D234
_02155DEC: .word 0x0217D224
_02155DF0: .word 0x0217D240
_02155DF4: .word 0x0217D244
_02155DF8: .word 0x0217D22C
	thumb_func_end ovl08_2155A50

	thumb_func_start ovl08_2155DFC
ovl08_2155DFC: // 0x02155DFC
	push {lr}
	sub sp, #0xc
	add r0, sp, #0
	bl ovl08_2155E30
	add r0, sp, #0
	ldr r1, _02155E14 // =0x0217D2EC
	ldr r1, [r1]
	blx r1
	add sp, #0xc
	pop {r3}
	bx r3
	.align 2, 0
_02155E14: .word 0x0217D2EC
	thumb_func_end ovl08_2155DFC

	thumb_func_start ovl08_2155E18
ovl08_2155E18: // 0x02155E18
	push {lr}
	sub sp, #4
	ldr r1, _02155E2C // =0x0217D468
	mov r2, #0xe8
	blx memcpy
	mov r0, #1
	add sp, #4
	pop {r3}
	bx r3
	.align 2, 0
_02155E2C: .word 0x0217D468
	thumb_func_end ovl08_2155E18

	thumb_func_start ovl08_2155E30
ovl08_2155E30: // 0x02155E30
	push {r4, lr}
	mov r4, r0
	ldr r0, _02155E64 // =0x0217D2A8
	ldr r0, [r0]
	str r0, [r4]
	ldr r0, _02155E68 // =0x0217B0F8
	ldr r1, [r0]
	mov r0, #0
	mvn r0, r0
	cmp r1, r0
	bne _02155E4A
	str r0, [r4, #4]
	b _02155E56
_02155E4A:
	bl ovl08_2156114
	ldr r1, _02155E68 // =0x0217B0F8
	ldr r1, [r1]
	sub r0, r1, r0
	str r0, [r4, #4]
_02155E56:
	ldr r0, _02155E6C // =0x0217D2E8
	ldr r0, [r0]
	str r0, [r4, #8]
	mov r0, #1
	pop {r4}
	pop {r3}
	bx r3
	.align 2, 0
_02155E64: .word 0x0217D2A8
_02155E68: .word 0x0217B0F8
_02155E6C: .word 0x0217D2E8
	thumb_func_end ovl08_2155E30

	thumb_func_start ovl08_2155E70
ovl08_2155E70: // 0x02155E70
	push {r4, r5, r6, lr}
	ldr r0, _02155F08 // =0x0217D2D4
	ldr r0, [r0]
	cmp r0, #0
	beq _02155EE6
	ldr r4, _02155F0C // =0x0217D2A8
	ldr r6, [r4]
	mov r1, #1
	ldr r0, _02155F10 // =0x0217D280
	str r1, [r0]
	mov r5, #0x64
	b _02155E8E
_02155E88:
	mov r0, r5
	blx OS_Sleep
_02155E8E:
	ldr r0, [r4]
	cmp r0, #1
	blt _02155E98
	cmp r0, #5
	ble _02155E88
_02155E98:
	ldr r0, _02155F14 // =0x000001F4
	blx OS_Sleep
	ldr r0, _02155F18 // =0x0217D3A8
	blx OS_IsThreadTerminated
	cmp r0, #0
	bne _02155EC0
	ldr r4, _02155F18 // =0x0217D3A8
_02155EAA:
	mov r0, r4
	blx OS_WakeupThreadDirect
	mov r0, r4
	blx OS_JoinThread
	mov r0, r4
	blx OS_IsThreadTerminated
	cmp r0, #0
	beq _02155EAA
_02155EC0:
	ldr r0, _02155F1C // =0x0217D2A0
	ldr r0, [r0]
	cmp r0, #0
	beq _02155ED4
	ldr r1, _02155F20 // =0x0217D27C
	ldr r1, [r1]
	blx r1
	mov r1, #0
	ldr r0, _02155F1C // =0x0217D2A0
	str r1, [r0]
_02155ED4:
	mov r1, #0
	ldr r0, _02155F08 // =0x0217D2D4
	str r1, [r0]
	ldr r0, _02155F0C // =0x0217D2A8
	ldr r0, [r0]
	cmp r6, r0
	beq _02155EE6
	bl ovl08_2155DFC
_02155EE6:
	ldr r0, _02155F24 // =0x0217D2E4
	ldr r0, [r0]
	cmp r0, #0
	ble _02155EFE
	bl ovl08_2159178
	mov r2, #0
	ldr r1, _02155F24 // =0x0217D2E4
	str r2, [r1]
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_02155EFE:
	mov r0, #9
	mvn r0, r0
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	.align 2, 0
_02155F08: .word 0x0217D2D4
_02155F0C: .word 0x0217D2A8
_02155F10: .word 0x0217D280
_02155F14: .word 0x000001F4
_02155F18: .word 0x0217D3A8
_02155F1C: .word 0x0217D2A0
_02155F20: .word 0x0217D27C
_02155F24: .word 0x0217D2E4
	thumb_func_end ovl08_2155E70

	thumb_func_start ovl08_2155F28
ovl08_2155F28: // 0x02155F28
	push {r4, r5, lr}
	sub sp, #0xc
	mov r4, r0
	ldr r0, _0215601C // =0x0217D2A8
	ldr r0, [r0]
	cmp r0, #1
	blt _02155F46
	cmp r0, #5
	bgt _02155F46
	mov r0, #9
	mvn r0, r0
	add sp, #0xc
	pop {r4, r5}
	pop {r3}
	bx r3
_02155F46:
	ldr r0, _02156020 // =0x0217B0FC
	str r1, [r0]
	mov r5, #7
	ldr r0, _0215601C // =0x0217D2A8
	str r5, [r0]
	ldr r0, _02156024 // =0x0217D2EC
	str r2, [r0]
	ldr r0, _02156028 // =0x0217D274
	str r3, [r0]
	ldr r2, [sp, #0x18]
	ldr r0, _0215602C // =0x0217D27C
	str r2, [r0]
	ldr r2, [sp, #0x1c]
	ldr r0, _02156030 // =0x0217B0F4
	str r2, [r0]
	mov r0, r1
	bl ovl08_21591D8
	mov r2, #1
	ldr r1, _02156034 // =0x0217D2E4
	str r2, [r1]
	cmp r0, #0
	bge _02155F80
	ldr r1, _02156038 // =0x0217D2E8
	str r0, [r1]
	add sp, #0xc
	pop {r4, r5}
	pop {r3}
	bx r3
_02155F80:
	ldr r0, _02156030 // =0x0217B0F4
	ldr r0, [r0]
	ldr r1, _02156028 // =0x0217D274
	ldr r1, [r1]
	blx r1
	ldr r1, _0215603C // =0x0217D2A0
	str r0, [r1]
	cmp r0, #0
	bne _02155FA2
	mov r0, #0
	mvn r0, r0
	ldr r1, _02156038 // =0x0217D2E8
	str r0, [r1]
	add sp, #0xc
	pop {r4, r5}
	pop {r3}
	bx r3
_02155FA2:
	blx OS_IsThreadAvailable
	cmp r0, #1
	beq _02155FBA
	mov r0, #8
	mvn r0, r0
	ldr r1, _02156038 // =0x0217D2E8
	str r0, [r1]
	add sp, #0xc
	pop {r4, r5}
	pop {r3}
	bx r3
_02155FBA:
	ldr r0, _02156030 // =0x0217B0F4
	ldr r3, [r0]
	str r3, [sp]
	str r4, [sp, #4]
	ldr r0, _02156040 // =0x0217D3A8
	ldr r1, _02156044 // =ovl08_2157C9C
	mov r2, #0
	ldr r4, _0215603C // =0x0217D2A0
	ldr r5, [r4]
	mov r4, #7
	bic r3, r4
	add r3, r5, r3
	blx OS_CreateThread
	mov r1, #1
	ldr r0, _0215601C // =0x0217D2A8
	str r1, [r0]
	bl ovl08_2156114
	ldr r1, _02156048 // =0x0000EA60
	add r1, r0, r1
	ldr r0, _0215604C // =0x0217B0F8
	str r1, [r0]
	mov r0, #0
	ldr r1, _02156050 // =0x0217D280
	str r0, [r1]
	ldr r5, _02156054 // =0x0217D468
	mov r1, r0
	mov r2, r0
	mov r3, r0
_02155FF6:
	stmia r5!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	sub r4, r4, #1
	cmp r4, #0
	bne _02155FF6
	stmia r5!, {r0, r1}
	bl ovl08_2155DFC
	ldr r0, _02156040 // =0x0217D3A8
	blx OS_WakeupThreadDirect
	mov r0, #1
	ldr r1, _02156058 // =0x0217D2D4
	str r0, [r1]
	add sp, #0xc
	pop {r4, r5}
	pop {r3}
	bx r3
	nop
_0215601C: .word 0x0217D2A8
_02156020: .word 0x0217B0FC
_02156024: .word 0x0217D2EC
_02156028: .word 0x0217D274
_0215602C: .word 0x0217D27C
_02156030: .word 0x0217B0F4
_02156034: .word 0x0217D2E4
_02156038: .word 0x0217D2E8
_0215603C: .word 0x0217D2A0
_02156040: .word 0x0217D3A8
_02156044: .word ovl08_2157C9C
_02156048: .word 0x0000EA60
_0215604C: .word 0x0217B0F8
_02156050: .word 0x0217D280
_02156054: .word 0x0217D468
_02156058: .word 0x0217D2D4
	thumb_func_end ovl08_2155F28

	thumb_func_start ovl08_215605C
ovl08_215605C: // 0x0215605C
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	str r0, [sp]
	mov r6, r1
	lsl r5, r0, #0
	mov r4, #0
	mov r7, r4
_0215606A:
	mov r0, r5
	ldrsb r1, [r6, r7]
	add r6, r6, #1
	bl ovl08_2156098
	add r1, r5, r0
	mov r5, r1
	cmp r4, #5
	bge _02156082
	add r5, r1, #1
	mov r0, #0x3a
	strb r0, [r1]
_02156082:
	add r4, r4, #1
	cmp r4, #6
	blt _0215606A
	mov r0, #0
	strb r0, [r5]
	ldr r0, [sp]
	sub r0, r5, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	thumb_func_end ovl08_215605C

	thumb_func_start ovl08_2156098
ovl08_2156098: // 0x02156098
	push {r4, r5}
	mov r2, r0
	lsl r1, r1, #0x18
	lsr r4, r1, #0x18
	mov r1, #0xf0
	mov r3, r4
	and r3, r1
	asr r3, r3, #4
	mov r5, #0
	mov r1, #0xf
	and r4, r1
_021560AE:
	cmp r3, #9
	bgt _021560BA
	add r3, #0x30
	strb r3, [r2]
	add r2, r2, #1
	b _021560C0
_021560BA:
	add r3, #0x37
	strb r3, [r2]
	add r2, r2, #1
_021560C0:
	mov r3, r4
	add r5, r5, #1
	cmp r5, #2
	blt _021560AE
	mov r1, #0
	strb r1, [r2]
	sub r0, r2, r0
	pop {r4, r5}
	bx lr
	.align 2, 0
	thumb_func_end ovl08_2156098

	thumb_func_start ovl08_21560D4
ovl08_21560D4: // 0x021560D4
	push {lr}
	sub sp, #4
	ldr r1, _021560E4 // =0x0217D27C
	ldr r1, [r1]
	blx r1
	add sp, #4
	pop {r3}
	bx r3
	.align 2, 0
_021560E4: .word 0x0217D27C
	thumb_func_end ovl08_21560D4

	thumb_func_start ovl08_21560E8
ovl08_21560E8: // 0x021560E8
	push {r4, r5, lr}
	sub sp, #4
	mov r4, r0
	mul r4, r1
	mov r0, r4
	ldr r1, _02156110 // =0x0217D274
	ldr r1, [r1]
	blx r1
	mov r5, r0
	cmp r5, #0
	beq _02156106
	mov r1, #0
	mov r2, r4
	blx memset
_02156106:
	mov r0, r5
	add sp, #4
	pop {r4, r5}
	pop {r3}
	bx r3
	.align 2, 0
_02156110: .word 0x0217D274
	thumb_func_end ovl08_21560E8

	thumb_func_start ovl08_2156114
ovl08_2156114: // 0x02156114
	push {lr}
	sub sp, #4
	blx OS_GetTick
	lsr r2, r0, #0x1a
	lsl r1, r1, #6
	orr r1, r2
	lsl r0, r0, #6
	ldr r2, _02156134 // =0x000082EA
	mov r3, #0
	blx _ll_udiv
	add sp, #4
	pop {r3}
	bx r3
	nop
_02156134: .word 0x000082EA
	thumb_func_end ovl08_2156114

	thumb_func_start ovl08_2156138
ovl08_2156138: // 0x02156138
	push {r4, r5, r6, lr}
	sub sp, #0x58
	mov r5, r0
	mov r4, r1
	mov r6, r2
	add r0, sp, #0
	bl ovl08_2156B30
	add r0, sp, #0
	mov r1, r4
	mov r2, r6
	bl ovl08_2156AB0
	mov r0, r5
	add r1, sp, #0
	bl ovl08_2156A54
	add sp, #0x58
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_2156138

	thumb_func_start ovl08_2156164
ovl08_2156164: // 0x02156164
	mov r3, #0
	cmp r2, #0
	bls _02156178
	lsl r1, r1, #0x18
	asr r1, r1, #0x18
_0215616E:
	strb r1, [r0]
	add r0, r0, #1
	add r3, r3, #1
	cmp r3, r2
	blo _0215616E
_02156178:
	bx lr
	.align 2, 0
	thumb_func_end ovl08_2156164

	thumb_func_start ovl08_215617C
ovl08_215617C: // 0x0215617C
	push {r4}
	sub sp, #4
	mov r4, #0
	cmp r2, #0
	bls _02156190
_02156186:
	ldrb r3, [r1, r4]
	strb r3, [r0, r4]
	add r4, r4, #1
	cmp r4, r2
	blo _02156186
_02156190:
	add sp, #4
	pop {r4}
	bx lr
	.align 2, 0
	thumb_func_end ovl08_215617C

	thumb_func_start ovl08_2156198
ovl08_2156198: // 0x02156198
	push {r4, r5, r6, r7}
	mov r6, #0
	cmp r2, #0
	bls _021561C2
_021561A0:
	add r3, r6, #3
	ldrb r3, [r1, r3]
	lsl r5, r3, #0x18
	add r3, r6, #2
	ldrb r3, [r1, r3]
	lsl r4, r3, #0x10
	ldrb r3, [r1, r6]
	add r7, r6, #1
	ldrb r7, [r1, r7]
	lsl r7, r7, #8
	orr r3, r7
	orr r4, r3
	orr r5, r4
	stmia r0!, {r5}
	add r6, r6, #4
	cmp r6, r2
	blo _021561A0
_021561C2:
	pop {r4, r5, r6, r7}
	bx lr
	.align 2, 0
	thumb_func_end ovl08_2156198

	thumb_func_start ovl08_21561C8
ovl08_21561C8: // 0x021561C8
	push {r4, r5}
	mov r3, #0
	cmp r2, #0
	bls _021561F4
_021561D0:
	ldr r4, [r1]
	strb r4, [r0, r3]
	ldr r4, [r1]
	lsr r5, r4, #8
	add r4, r3, #1
	strb r5, [r0, r4]
	ldr r4, [r1]
	lsr r5, r4, #0x10
	add r4, r3, #2
	strb r5, [r0, r4]
	ldr r4, [r1]
	lsr r5, r4, #0x18
	add r4, r3, #3
	strb r5, [r0, r4]
	add r1, r1, #4
	add r3, r3, #4
	cmp r3, r2
	blo _021561D0
_021561F4:
	pop {r4, r5}
	bx lr
	thumb_func_end ovl08_21561C8

	thumb_func_start ovl08_21561F8
ovl08_21561F8: // 0x021561F8
	push {r4, r5, r6, r7, lr}
	sub sp, #0x84
	mov r5, r0
	ldr r0, [r5]
	str r0, [sp]
	ldr r4, [r5, #4]
	ldr r6, [r5, #8]
	ldr r7, [r5, #0xc]
	add r0, sp, #0x40
	mov r2, #0x40
	bl ovl08_2156198
	ldr r0, [sp, #0x40]
	str r0, [sp, #4]
	mov r1, r4
	and r1, r6
	mvn r0, r4
	and r0, r7
	orr r1, r0
	ldr r0, [sp, #4]
	add r1, r0, r1
	ldr r0, _02156610 // =0x28955B88
	sub r1, r1, r0
	ldr r0, [sp]
	add r0, r0, r1
	lsl r1, r0, #7
	lsr r0, r0, #0x19
	orr r1, r0
	add r0, r1, r4
	ldr r1, [sp, #0x44]
	str r1, [sp, #8]
	mov r1, r0
	and r1, r4
	mvn r2, r0
	and r2, r6
	orr r1, r2
	ldr r2, [sp, #8]
	add r2, r2, r1
	ldr r1, _02156614 // =0x173848AA
	sub r1, r2, r1
	add r1, r7, r1
	lsl r2, r1, #0xc
	lsr r1, r1, #0x14
	orr r2, r1
	add r3, r2, r0
	ldr r1, [sp, #0x48]
	str r1, [sp, #0xc]
	mov r1, r3
	and r1, r0
	mvn r2, r3
	and r2, r4
	orr r1, r2
	ldr r2, [sp, #0xc]
	add r2, r2, r1
	ldr r1, _02156618 // =0x242070DB
	add r1, r2, r1
	add r1, r6, r1
	lsl r2, r1, #0x11
	lsr r1, r1, #0xf
	orr r2, r1
	add r2, r2, r3
	ldr r1, [sp, #0x4c]
	str r1, [sp, #0x10]
	mov r1, r2
	and r1, r3
	mvn r6, r2
	and r6, r0
	orr r1, r6
	ldr r6, [sp, #0x10]
	add r6, r6, r1
	ldr r1, _0215661C // =0x3E423112
	sub r1, r6, r1
	add r1, r4, r1
	lsl r4, r1, #0x16
	lsr r1, r1, #0xa
	orr r4, r1
	add r1, r4, r2
	ldr r4, [sp, #0x50]
	str r4, [sp, #0x14]
	mov r4, r1
	and r4, r2
	mvn r6, r1
	and r6, r3
	orr r4, r6
	ldr r6, [sp, #0x14]
	add r6, r6, r4
	ldr r4, _02156620 // =0x0A83F051
	sub r4, r6, r4
	add r0, r0, r4
	lsl r4, r0, #7
	lsr r0, r0, #0x19
	orr r4, r0
	add r4, r4, r1
	ldr r0, [sp, #0x54]
	str r0, [sp, #0x18]
	mov r0, r4
	and r0, r1
	mvn r6, r4
	and r6, r2
	orr r0, r6
	ldr r6, [sp, #0x18]
	add r6, r6, r0
	ldr r0, _02156624 // =0x4787C62A
	add r0, r6, r0
	add r0, r3, r0
	lsl r3, r0, #0xc
	lsr r0, r0, #0x14
	orr r3, r0
	add r3, r3, r4
	ldr r0, [sp, #0x58]
	str r0, [sp, #0x1c]
	mov r0, r3
	and r0, r4
	mvn r6, r3
	and r6, r1
	orr r0, r6
	ldr r6, [sp, #0x1c]
	add r6, r6, r0
	ldr r0, _02156628 // =0x57CFB9ED
	sub r0, r6, r0
	add r0, r2, r0
	lsl r2, r0, #0x11
	lsr r0, r0, #0xf
	orr r2, r0
	add r0, r2, r3
	ldr r2, [sp, #0x5c]
	str r2, [sp, #0x20]
	mov r2, r0
	and r2, r3
	mvn r6, r0
	and r6, r4
	orr r2, r6
	ldr r6, [sp, #0x20]
	add r6, r6, r2
	ldr r2, _0215662C // =0x02B96AFF
	sub r2, r6, r2
	add r1, r1, r2
	lsl r2, r1, #0x16
	lsr r1, r1, #0xa
	orr r2, r1
	add r6, r2, r0
	ldr r1, [sp, #0x60]
	str r1, [sp, #0x24]
	mov r1, r6
	and r1, r0
	mvn r2, r6
	and r2, r3
	orr r1, r2
	ldr r2, [sp, #0x24]
	add r2, r2, r1
	ldr r1, _02156630 // =0x698098D8
	add r1, r2, r1
	add r1, r4, r1
	lsl r2, r1, #7
	lsr r1, r1, #0x19
	orr r2, r1
	add r2, r2, r6
	ldr r1, [sp, #0x64]
	str r1, [sp, #0x28]
	mov r1, r2
	and r1, r6
	mvn r4, r2
	and r4, r0
	orr r1, r4
	ldr r4, [sp, #0x28]
	add r4, r4, r1
	ldr r1, _02156634 // =0x74BB0851
	sub r1, r4, r1
	add r1, r3, r1
	lsl r3, r1, #0xc
	lsr r1, r1, #0x14
	orr r3, r1
	add r1, r3, r2
	ldr r3, [sp, #0x68]
	str r3, [sp, #0x2c]
	mov r3, r1
	and r3, r2
	mvn r4, r1
	and r4, r6
	orr r3, r4
	ldr r4, [sp, #0x2c]
	add r4, r4, r3
	ldr r3, _02156638 // =0x0000A44F
	sub r3, r4, r3
	add r0, r0, r3
	lsl r3, r0, #0x11
	lsr r0, r0, #0xf
	orr r3, r0
	add r4, r3, r1
	ldr r0, [sp, #0x6c]
	str r0, [sp, #0x30]
	mov r0, r4
	and r0, r1
	mvn r3, r4
	and r3, r2
	orr r0, r3
	ldr r3, [sp, #0x30]
	add r3, r3, r0
	ldr r0, _0215663C // =0x76A32842
	sub r0, r3, r0
	add r0, r6, r0
	lsl r3, r0, #0x16
	lsr r0, r0, #0xa
	orr r3, r0
	add r3, r3, r4
	ldr r0, [sp, #0x70]
	str r0, [sp, #0x34]
	mov r0, r3
	and r0, r4
	mvn r6, r3
	and r6, r1
	orr r0, r6
	ldr r6, [sp, #0x34]
	add r6, r6, r0
	ldr r0, _02156640 // =0x6B901122
	add r0, r6, r0
	add r0, r2, r0
	lsl r2, r0, #7
	lsr r0, r0, #0x19
	orr r2, r0
	add r0, r2, r3
	ldr r2, [sp, #0x74]
	str r2, [sp, #0x38]
	mov r2, r0
	and r2, r3
	mvn r6, r0
	and r6, r4
	orr r2, r6
	ldr r6, [sp, #0x38]
	add r6, r6, r2
	ldr r2, _02156644 // =0x02678E6D
	sub r2, r6, r2
	add r1, r1, r2
	lsl r2, r1, #0xc
	lsr r1, r1, #0x14
	orr r2, r1
	add r6, r2, r0
	mvn r2, r6
	ldr r7, [sp, #0x78]
	mov r1, r6
	and r1, r0
	and r2, r3
	orr r1, r2
	add r2, r7, r1
	ldr r1, _02156648 // =0x5986BC72
	sub r1, r2, r1
	add r1, r4, r1
	lsl r2, r1, #0x11
	lsr r1, r1, #0xf
	orr r2, r1
	add r2, r2, r6
	mvn r4, r2
	ldr r1, [sp, #0x7c]
	str r1, [sp, #0x3c]
	mov r1, r2
	and r1, r6
	and r4, r0
	orr r1, r4
	ldr r4, [sp, #0x3c]
	add r4, r4, r1
	ldr r1, _0215664C // =0x49B40821
	add r1, r4, r1
	add r1, r3, r1
	lsl r3, r1, #0x16
	lsr r1, r1, #0xa
	orr r3, r1
	add r1, r3, r2
	mov r3, r1
	and r3, r6
	mov r4, r2
	bic r4, r6
	orr r3, r4
	ldr r4, [sp, #8]
	add r4, r4, r3
	ldr r3, _02156650 // =0x09E1DA9E
	sub r3, r4, r3
	add r0, r0, r3
	lsl r3, r0, #5
	lsr r0, r0, #0x1b
	orr r3, r0
	add r4, r3, r1
	mov r0, r4
	and r0, r2
	mov r3, r1
	bic r3, r2
	orr r0, r3
	ldr r3, [sp, #0x1c]
	add r3, r3, r0
	ldr r0, _02156654 // =0x3FBF4CC0
	sub r0, r3, r0
	add r0, r6, r0
	lsl r3, r0, #9
	lsr r0, r0, #0x17
	orr r3, r0
	add r3, r3, r4
	mov r0, r3
	and r0, r1
	mov r6, r4
	bic r6, r1
	orr r0, r6
	ldr r6, [sp, #0x30]
	add r6, r6, r0
	ldr r0, _02156658 // =0x265E5A51
	add r0, r6, r0
	add r0, r2, r0
	lsl r2, r0, #0xe
	lsr r0, r0, #0x12
	orr r2, r0
	add r0, r2, r3
	mov r2, r0
	and r2, r4
	mov r6, r3
	bic r6, r4
	orr r2, r6
	ldr r6, [sp, #4]
	add r6, r6, r2
	ldr r2, _0215665C // =0x16493856
	sub r2, r6, r2
	add r1, r1, r2
	lsl r2, r1, #0x14
	lsr r1, r1, #0xc
	orr r2, r1
	add r6, r2, r0
	mov r1, r6
	and r1, r3
	mov r2, r0
	bic r2, r3
	orr r1, r2
	ldr r2, [sp, #0x18]
	add r2, r2, r1
	ldr r1, _02156660 // =0x29D0EFA3
	sub r1, r2, r1
	add r1, r4, r1
	lsl r2, r1, #5
	lsr r1, r1, #0x1b
	orr r2, r1
	add r2, r2, r6
	mov r1, r2
	and r1, r0
	mov r4, r6
	bic r4, r0
	orr r1, r4
	ldr r4, [sp, #0x2c]
	add r4, r4, r1
	ldr r1, _02156664 // =0x02441453
	add r1, r4, r1
	add r1, r3, r1
	lsl r3, r1, #9
	lsr r1, r1, #0x17
	orr r3, r1
	add r1, r3, r2
	mov r3, r1
	and r3, r6
	mov r4, r2
	bic r4, r6
	orr r3, r4
	ldr r4, [sp, #0x3c]
	add r4, r4, r3
	ldr r3, _02156668 // =0x275E197F
	sub r3, r4, r3
	add r0, r0, r3
	lsl r3, r0, #0xe
	lsr r0, r0, #0x12
	orr r3, r0
	add r4, r3, r1
	mov r0, r4
	and r0, r2
	mov r3, r1
	bic r3, r2
	orr r0, r3
	ldr r3, [sp, #0x14]
	add r3, r3, r0
	ldr r0, _0215666C // =0x182C0438
	sub r0, r3, r0
	add r0, r6, r0
	lsl r3, r0, #0x14
	lsr r0, r0, #0xc
	orr r3, r0
	add r3, r3, r4
	mov r0, r3
	and r0, r1
	mov r6, r4
	bic r6, r1
	orr r0, r6
	ldr r6, [sp, #0x28]
	add r6, r6, r0
	ldr r0, _02156670 // =0x21E1CDE6
	add r0, r6, r0
	add r0, r2, r0
	lsl r2, r0, #5
	lsr r0, r0, #0x1b
	orr r2, r0
	add r0, r2, r3
	mov r6, r0
	and r6, r4
	mov r2, r3
	bic r2, r4
	orr r6, r2
	add r6, r7, r6
	ldr r2, _02156674 // =0x3CC8F82A
	sub r2, r6, r2
	add r1, r1, r2
	lsl r2, r1, #9
	lsr r1, r1, #0x17
	orr r2, r1
	add r6, r2, r0
	mov r1, r6
	and r1, r3
	mov r2, r0
	bic r2, r3
	orr r1, r2
	ldr r2, [sp, #0x10]
	add r2, r2, r1
	ldr r1, _02156678 // =0x0B2AF279
	sub r1, r2, r1
	add r1, r4, r1
	lsl r2, r1, #0xe
	lsr r1, r1, #0x12
	orr r2, r1
	add r2, r2, r6
	mov r1, r2
	and r1, r0
	mov r4, r6
	bic r4, r0
	orr r1, r4
	ldr r4, [sp, #0x24]
	add r4, r4, r1
	ldr r1, _0215667C // =0x455A14ED
	add r1, r4, r1
	add r1, r3, r1
	lsl r3, r1, #0x14
	lsr r1, r1, #0xc
	orr r3, r1
	add r1, r3, r2
	mov r3, r1
	and r3, r6
	mov r4, r2
	bic r4, r6
	orr r3, r4
	ldr r4, [sp, #0x38]
	add r4, r4, r3
	ldr r3, _02156680 // =0x561C16FB
	sub r3, r4, r3
	add r0, r0, r3
	lsl r3, r0, #5
	lsr r0, r0, #0x1b
	orr r3, r0
	add r4, r3, r1
	mov r0, r4
	and r0, r2
	mov r3, r1
	bic r3, r2
	orr r0, r3
	ldr r3, [sp, #0xc]
	add r3, r3, r0
	ldr r0, _02156684 // =0x03105C08
	sub r0, r3, r0
	add r0, r6, r0
	lsl r3, r0, #9
	lsr r0, r0, #0x17
	orr r3, r0
	add r3, r3, r4
	mov r0, r3
	and r0, r1
	mov r6, r4
	bic r6, r1
	orr r0, r6
	ldr r6, [sp, #0x20]
	add r6, r6, r0
	ldr r0, _02156688 // =0x676F02D9
	add r0, r6, r0
	add r0, r2, r0
	lsl r2, r0, #0xe
	lsr r0, r0, #0x12
	orr r2, r0
	add r0, r2, r3
	mov r2, r0
	and r2, r4
	mov r6, r3
	bic r6, r4
	orr r2, r6
	ldr r6, [sp, #0x34]
	add r6, r6, r2
	ldr r2, _0215668C // =0x72D5B376
	sub r2, r6, r2
	add r1, r1, r2
	lsl r2, r1, #0x14
	lsr r1, r1, #0xc
	orr r2, r1
	add r6, r2, r0
	mov r2, r6
	eor r2, r0
	mov r1, r3
	eor r1, r2
	ldr r2, [sp, #0x18]
	add r2, r2, r1
	ldr r1, _02156690 // =0x0005C6BE
	sub r1, r2, r1
	add r1, r4, r1
	lsl r2, r1, #4
	lsr r1, r1, #0x1c
	orr r2, r1
	add r2, r2, r6
	mov r4, r2
	eor r4, r6
	mov r1, r0
	eor r1, r4
	ldr r4, [sp, #0x24]
	add r4, r4, r1
	ldr r1, _02156694 // =0x788E097F
	sub r1, r4, r1
	add r1, r3, r1
	lsl r3, r1, #0xb
	lsr r1, r1, #0x15
	orr r3, r1
	add r1, r3, r2
	mov r4, r1
	eor r4, r2
	mov r3, r6
	eor r3, r4
	ldr r4, [sp, #0x30]
	add r4, r4, r3
	ldr r3, _02156698 // =0x6D9D6122
	b _0215669C
	.align 2, 0
_02156610: .word 0x28955B88
_02156614: .word 0x173848AA
_02156618: .word 0x242070DB
_0215661C: .word 0x3E423112
_02156620: .word 0x0A83F051
_02156624: .word 0x4787C62A
_02156628: .word 0x57CFB9ED
_0215662C: .word 0x02B96AFF
_02156630: .word 0x698098D8
_02156634: .word 0x74BB0851
_02156638: .word 0x0000A44F
_0215663C: .word 0x76A32842
_02156640: .word 0x6B901122
_02156644: .word 0x02678E6D
_02156648: .word 0x5986BC72
_0215664C: .word 0x49B40821
_02156650: .word 0x09E1DA9E
_02156654: .word 0x3FBF4CC0
_02156658: .word 0x265E5A51
_0215665C: .word 0x16493856
_02156660: .word 0x29D0EFA3
_02156664: .word 0x02441453
_02156668: .word 0x275E197F
_0215666C: .word 0x182C0438
_02156670: .word 0x21E1CDE6
_02156674: .word 0x3CC8F82A
_02156678: .word 0x0B2AF279
_0215667C: .word 0x455A14ED
_02156680: .word 0x561C16FB
_02156684: .word 0x03105C08
_02156688: .word 0x676F02D9
_0215668C: .word 0x72D5B376
_02156690: .word 0x0005C6BE
_02156694: .word 0x788E097F
_02156698: .word 0x6D9D6122
_0215669C:
	add r3, r4, r3
	add r0, r0, r3
	lsl r3, r0, #0x10
	lsr r0, r0, #0x10
	orr r3, r0
	add r4, r3, r1
	mov r0, r4
	eor r0, r1
	mov r3, r2
	eor r3, r0
	add r3, r7, r3
	ldr r0, _021569E0 // =0x021AC7F4
	sub r0, r3, r0
	add r0, r6, r0
	lsl r3, r0, #0x17
	lsr r0, r0, #9
	orr r3, r0
	add r3, r3, r4
	mov r6, r3
	eor r6, r4
	mov r0, r1
	eor r0, r6
	ldr r6, [sp, #8]
	add r6, r6, r0
	ldr r0, _021569E4 // =0x5B4115BC
	sub r0, r6, r0
	add r0, r2, r0
	lsl r2, r0, #4
	lsr r0, r0, #0x1c
	orr r2, r0
	add r0, r2, r3
	mov r6, r0
	eor r6, r3
	mov r2, r4
	eor r2, r6
	ldr r6, [sp, #0x14]
	add r6, r6, r2
	ldr r2, _021569E8 // =0x4BDECFA9
	add r2, r6, r2
	add r1, r1, r2
	lsl r2, r1, #0xb
	lsr r1, r1, #0x15
	orr r2, r1
	add r6, r2, r0
	mov r2, r6
	eor r2, r0
	mov r1, r3
	eor r1, r2
	ldr r2, [sp, #0x20]
	add r2, r2, r1
	ldr r1, _021569EC // =0x0944B4A0
	sub r1, r2, r1
	add r1, r4, r1
	lsl r2, r1, #0x10
	lsr r1, r1, #0x10
	orr r2, r1
	add r2, r2, r6
	mov r4, r2
	eor r4, r6
	mov r1, r0
	eor r1, r4
	ldr r4, [sp, #0x2c]
	add r4, r4, r1
	ldr r1, _021569F0 // =0x41404390
	sub r1, r4, r1
	add r1, r3, r1
	lsl r3, r1, #0x17
	lsr r1, r1, #9
	orr r3, r1
	add r1, r3, r2
	mov r4, r1
	eor r4, r2
	mov r3, r6
	eor r3, r4
	ldr r4, [sp, #0x38]
	add r4, r4, r3
	ldr r3, _021569F4 // =0x289B7EC6
	add r3, r4, r3
	add r0, r0, r3
	lsl r3, r0, #4
	lsr r0, r0, #0x1c
	orr r3, r0
	add r4, r3, r1
	mov r3, r4
	eor r3, r1
	mov r0, r2
	eor r0, r3
	ldr r3, [sp, #4]
	add r3, r3, r0
	ldr r0, _021569F8 // =0x155ED806
	sub r0, r3, r0
	add r0, r6, r0
	lsl r3, r0, #0xb
	lsr r0, r0, #0x15
	orr r3, r0
	add r3, r3, r4
	mov r6, r3
	eor r6, r4
	mov r0, r1
	eor r0, r6
	ldr r6, [sp, #0x10]
	add r6, r6, r0
	ldr r0, _021569FC // =0x2B10CF7B
	sub r0, r6, r0
	add r0, r2, r0
	lsl r2, r0, #0x10
	lsr r0, r0, #0x10
	orr r2, r0
	add r0, r2, r3
	mov r6, r0
	eor r6, r3
	mov r2, r4
	eor r2, r6
	ldr r6, [sp, #0x1c]
	add r6, r6, r2
	ldr r2, _02156A00 // =0x04881D05
	add r2, r6, r2
	add r1, r1, r2
	lsl r2, r1, #0x17
	lsr r1, r1, #9
	orr r2, r1
	add r6, r2, r0
	mov r2, r6
	eor r2, r0
	mov r1, r3
	eor r1, r2
	ldr r2, [sp, #0x28]
	add r2, r2, r1
	ldr r1, _02156A04 // =0x262B2FC7
	sub r1, r2, r1
	add r1, r4, r1
	lsl r2, r1, #4
	lsr r1, r1, #0x1c
	orr r2, r1
	add r2, r2, r6
	mov r4, r2
	eor r4, r6
	mov r1, r0
	eor r1, r4
	ldr r4, [sp, #0x34]
	add r4, r4, r1
	ldr r1, _02156A08 // =0x1924661B
	sub r1, r4, r1
	add r1, r3, r1
	lsl r3, r1, #0xb
	lsr r1, r1, #0x15
	orr r3, r1
	add r1, r3, r2
	mov r4, r1
	eor r4, r2
	mov r3, r6
	eor r3, r4
	ldr r4, [sp, #0x3c]
	add r4, r4, r3
	ldr r3, _02156A0C // =0x1FA27CF8
	add r3, r4, r3
	add r0, r0, r3
	lsl r3, r0, #0x10
	lsr r0, r0, #0x10
	orr r3, r0
	add r4, r3, r1
	mov r3, r4
	eor r3, r1
	mov r0, r2
	eor r0, r3
	ldr r3, [sp, #0xc]
	add r3, r3, r0
	ldr r0, _02156A10 // =0x3B53A99B
	sub r0, r3, r0
	add r0, r6, r0
	lsl r3, r0, #0x17
	lsr r0, r0, #9
	orr r3, r0
	add r3, r3, r4
	mvn r6, r1
	mov r0, r3
	orr r0, r6
	mov r6, r4
	eor r6, r0
	ldr r0, [sp, #4]
	add r6, r0, r6
	ldr r0, _02156A14 // =0x0BD6DDBC
	sub r0, r6, r0
	add r0, r2, r0
	lsl r2, r0, #6
	lsr r0, r0, #0x1a
	orr r2, r0
	add r0, r2, r3
	mvn r6, r4
	mov r2, r0
	orr r2, r6
	mov r6, r3
	eor r6, r2
	ldr r2, [sp, #0x20]
	add r6, r2, r6
	ldr r2, _02156A18 // =0x432AFF97
	add r2, r6, r2
	add r1, r1, r2
	lsl r2, r1, #0xa
	lsr r1, r1, #0x16
	orr r2, r1
	add r1, r2, r0
	mvn r2, r3
	mov r6, r1
	orr r6, r2
	mov r2, r0
	eor r2, r6
	add r6, r7, r2
	ldr r2, _02156A1C // =0x546BDC59
	sub r2, r6, r2
	add r2, r4, r2
	lsl r4, r2, #0xf
	lsr r2, r2, #0x11
	orr r4, r2
	add r2, r4, r1
	mvn r6, r0
	mov r4, r2
	orr r4, r6
	mov r6, r1
	eor r6, r4
	ldr r4, [sp, #0x18]
	add r6, r4, r6
	ldr r4, _02156A20 // =0x036C5FC7
	sub r4, r6, r4
	add r3, r3, r4
	lsl r4, r3, #0x15
	lsr r3, r3, #0xb
	orr r4, r3
	add r4, r4, r2
	mvn r6, r1
	mov r3, r4
	orr r3, r6
	mov r6, r2
	eor r6, r3
	ldr r3, [sp, #0x34]
	add r6, r3, r6
	ldr r3, _02156A24 // =0x655B59C3
	add r3, r6, r3
	add r0, r0, r3
	lsl r3, r0, #6
	lsr r0, r0, #0x1a
	orr r3, r0
	add r3, r3, r4
	mvn r6, r2
	mov r0, r3
	orr r0, r6
	mov r6, r4
	eor r6, r0
	ldr r0, [sp, #0x10]
	add r6, r0, r6
	ldr r0, _02156A28 // =0x70F3336E
	sub r0, r6, r0
	add r0, r1, r0
	lsl r1, r0, #0xa
	lsr r0, r0, #0x16
	orr r1, r0
	add r0, r1, r3
	mvn r6, r4
	mov r1, r0
	orr r1, r6
	mov r6, r3
	eor r6, r1
	ldr r1, [sp, #0x2c]
	add r6, r1, r6
	ldr r1, _02156A2C // =0x00100B83
	sub r1, r6, r1
	add r1, r2, r1
	lsl r2, r1, #0xf
	lsr r1, r1, #0x11
	orr r2, r1
	add r6, r2, r0
	mvn r2, r3
	mov r1, r6
	orr r1, r2
	mov r2, r0
	eor r2, r1
	ldr r1, [sp, #8]
	add r2, r1, r2
	ldr r1, _02156A30 // =0x7A7BA22F
	sub r1, r2, r1
	add r1, r4, r1
	lsl r2, r1, #0x15
	lsr r1, r1, #0xb
	orr r2, r1
	add r2, r2, r6
	mvn r4, r0
	mov r1, r2
	orr r1, r4
	mov r4, r6
	eor r4, r1
	ldr r1, [sp, #0x24]
	add r4, r1, r4
	ldr r1, _02156A34 // =0x6FA87E4F
	add r1, r4, r1
	add r1, r3, r1
	lsl r3, r1, #6
	lsr r1, r1, #0x1a
	orr r3, r1
	add r1, r3, r2
	mvn r4, r6
	mov r3, r1
	orr r3, r4
	mov r4, r2
	eor r4, r3
	ldr r3, [sp, #0x3c]
	add r4, r3, r4
	ldr r3, _02156A38 // =0x01D31920
	sub r3, r4, r3
	add r0, r0, r3
	lsl r3, r0, #0xa
	lsr r0, r0, #0x16
	orr r3, r0
	add r4, r3, r1
	mvn r3, r2
	mov r0, r4
	orr r0, r3
	mov r3, r1
	eor r3, r0
	ldr r0, [sp, #0x1c]
	add r3, r0, r3
	ldr r0, _02156A3C // =0x5CFEBCEC
	sub r0, r3, r0
	add r0, r6, r0
	lsl r3, r0, #0xf
	lsr r0, r0, #0x11
	orr r3, r0
	add r3, r3, r4
	mvn r6, r1
	mov r0, r3
	orr r0, r6
	mov r6, r4
	eor r6, r0
	ldr r0, [sp, #0x38]
	add r6, r0, r6
	ldr r0, _02156A40 // =0x4E0811A1
	add r0, r6, r0
	add r0, r2, r0
	lsl r2, r0, #0x15
	lsr r0, r0, #0xb
	orr r2, r0
	add r0, r2, r3
	mvn r6, r4
	mov r2, r0
	orr r2, r6
	mov r6, r3
	eor r6, r2
	ldr r2, [sp, #0x14]
	add r6, r2, r6
	ldr r2, _02156A44 // =0x08AC817E
	sub r2, r6, r2
	add r1, r1, r2
	lsl r2, r1, #6
	lsr r1, r1, #0x1a
	orr r2, r1
	add r6, r2, r0
	mvn r2, r3
	mov r1, r6
	orr r1, r2
	mov r2, r0
	eor r2, r1
	ldr r1, [sp, #0x30]
	add r2, r1, r2
	ldr r1, _02156A48 // =0x42C50DCB
	sub r1, r2, r1
	add r1, r4, r1
	lsl r2, r1, #0xa
	lsr r1, r1, #0x16
	orr r2, r1
	add r2, r2, r6
	mvn r4, r0
	mov r1, r2
	orr r1, r4
	mov r4, r6
	eor r4, r1
	ldr r1, [sp, #0xc]
	add r4, r1, r4
	ldr r1, _02156A4C // =0x2AD7D2BB
	add r1, r4, r1
	add r1, r3, r1
	lsl r3, r1, #0xf
	lsr r1, r1, #0x11
	orr r3, r1
	add r1, r3, r2
	mvn r4, r6
	mov r3, r1
	orr r3, r4
	mov r4, r2
	eor r4, r3
	ldr r3, [sp, #0x28]
	add r4, r3, r4
	ldr r3, _02156A50 // =0x14792C6F
	sub r3, r4, r3
	add r0, r0, r3
	lsl r3, r0, #0x15
	lsr r0, r0, #0xb
	orr r3, r0
	add r0, r3, r1
	ldr r3, [r5]
	add r3, r3, r6
	str r3, [r5]
	ldr r3, [r5, #4]
	add r0, r3, r0
	str r0, [r5, #4]
	ldr r0, [r5, #8]
	add r0, r0, r1
	str r0, [r5, #8]
	ldr r0, [r5, #0xc]
	add r0, r0, r2
	str r0, [r5, #0xc]
	add r0, sp, #0x40
	mov r1, #0
	mov r2, #0x40
	bl ovl08_2156164
	add sp, #0x84
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_021569E0: .word 0x021AC7F4
_021569E4: .word 0x5B4115BC
_021569E8: .word 0x4BDECFA9
_021569EC: .word 0x0944B4A0
_021569F0: .word 0x41404390
_021569F4: .word 0x289B7EC6
_021569F8: .word 0x155ED806
_021569FC: .word 0x2B10CF7B
_02156A00: .word 0x04881D05
_02156A04: .word 0x262B2FC7
_02156A08: .word 0x1924661B
_02156A0C: .word 0x1FA27CF8
_02156A10: .word 0x3B53A99B
_02156A14: .word 0x0BD6DDBC
_02156A18: .word 0x432AFF97
_02156A1C: .word 0x546BDC59
_02156A20: .word 0x036C5FC7
_02156A24: .word 0x655B59C3
_02156A28: .word 0x70F3336E
_02156A2C: .word 0x00100B83
_02156A30: .word 0x7A7BA22F
_02156A34: .word 0x6FA87E4F
_02156A38: .word 0x01D31920
_02156A3C: .word 0x5CFEBCEC
_02156A40: .word 0x4E0811A1
_02156A44: .word 0x08AC817E
_02156A48: .word 0x42C50DCB
_02156A4C: .word 0x2AD7D2BB
_02156A50: .word 0x14792C6F
	thumb_func_end ovl08_21561F8

	thumb_func_start ovl08_2156A54
ovl08_2156A54: // 0x02156A54
	push {r4, r5, lr}
	sub sp, #0xc
	mov r5, r0
	mov r4, r1
	add r0, sp, #0
	add r1, #0x10
	mov r2, #8
	bl ovl08_21561C8
	ldr r0, [r4, #0x10]
	lsr r1, r0, #3
	mov r0, #0x3f
	and r1, r0
	cmp r1, #0x38
	bhs _02156A78
	mov r0, #0x38
	sub r2, r0, r1
	b _02156A7C
_02156A78:
	mov r0, #0x78
	sub r2, r0, r1
_02156A7C:
	mov r0, r4
	ldr r1, _02156AAC // =0x0217B11C
	bl ovl08_2156AB0
	mov r0, r4
	add r1, sp, #0
	mov r2, #8
	bl ovl08_2156AB0
	mov r0, r5
	mov r1, r4
	mov r2, #0x10
	bl ovl08_21561C8
	mov r0, r4
	mov r1, #0
	mov r2, #0x58
	bl ovl08_2156164
	add sp, #0xc
	pop {r4, r5}
	pop {r3}
	bx r3
	nop
_02156AAC: .word 0x0217B11C
	thumb_func_end ovl08_2156A54

	thumb_func_start ovl08_2156AB0
ovl08_2156AB0: // 0x02156AB0
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	mov r7, r1
	mov r6, r2
	ldr r3, [r5, #0x10]
	lsr r0, r3, #3
	mov r1, #0x3f
	and r0, r1
	lsl r2, r6, #3
	add r1, r3, r2
	str r1, [r5, #0x10]
	ldr r1, [r5, #0x10]
	cmp r1, r2
	bhs _02156AD4
	ldr r1, [r5, #0x14]
	add r1, r1, #1
	str r1, [r5, #0x14]
_02156AD4:
	ldr r2, [r5, #0x14]
	lsr r1, r6, #0x1d
	add r1, r2, r1
	str r1, [r5, #0x14]
	mov r1, #0x40
	sub r4, r1, r0
	cmp r6, r4
	blo _02156B1A
	mov r1, r5
	add r1, #0x18
	add r0, r1, r0
	mov r1, r7
	mov r2, r4
	bl ovl08_215617C
	mov r0, r5
	mov r1, r5
	add r1, #0x18
	bl ovl08_21561F8
	mov r0, r4
	add r0, #0x3f
	cmp r0, r6
	bhs _02156B16
_02156B04:
	mov r0, r5
	add r1, r7, r4
	bl ovl08_21561F8
	add r4, #0x40
	mov r0, r4
	add r0, #0x3f
	cmp r0, r6
	blo _02156B04
_02156B16:
	mov r0, #0
	b _02156B1C
_02156B1A:
	mov r4, #0
_02156B1C:
	add r5, #0x18
	add r0, r5, r0
	add r1, r7, r4
	sub r2, r6, r4
	bl ovl08_215617C
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	thumb_func_end ovl08_2156AB0

	thumb_func_start ovl08_2156B30
ovl08_2156B30: // 0x02156B30
	mov r1, #0
	str r1, [r0, #0x14]
	ldr r1, [r0, #0x14]
	str r1, [r0, #0x10]
	ldr r1, _02156B4C // =0x67452301
	str r1, [r0]
	ldr r1, _02156B50 // =0xEFCDAB89
	str r1, [r0, #4]
	ldr r1, _02156B54 // =0x98BADCFE
	str r1, [r0, #8]
	ldr r1, _02156B58 // =0x10325476
	str r1, [r0, #0xc]
	bx lr
	nop
_02156B4C: .word 0x67452301
_02156B50: .word 0xEFCDAB89
_02156B54: .word 0x98BADCFE
_02156B58: .word 0x10325476
	thumb_func_end ovl08_2156B30

	thumb_func_start ovl08_2156B5C
ovl08_2156B5C: // 0x02156B5C
	push {r4, r5, r6, r7}
	sub sp, #0x60
	mov r4, r1
	mov r1, r2
	str r3, [sp]
	ldr r2, [r0]
	str r2, [sp, #4]
	ldrb r5, [r1, #3]
	ldrb r2, [r1, #2]
	lsl r3, r2, #8
	ldrb r2, [r1]
	lsl r2, r2, #0x18
	ldrb r6, [r1, #1]
	lsl r6, r6, #0x10
	eor r2, r6
	eor r3, r2
	eor r5, r3
	ldr r2, [sp, #4]
	eor r2, r5
	str r2, [sp, #4]
	ldr r2, [r0, #4]
	str r2, [sp, #8]
	ldrb r5, [r1, #7]
	ldrb r2, [r1, #6]
	lsl r3, r2, #8
	ldrb r2, [r1, #4]
	lsl r2, r2, #0x18
	ldrb r6, [r1, #5]
	lsl r6, r6, #0x10
	eor r2, r6
	eor r3, r2
	eor r5, r3
	ldr r2, [sp, #8]
	eor r2, r5
	str r2, [sp, #8]
	ldr r2, [r0, #8]
	str r2, [sp, #0x2c]
	ldrb r5, [r1, #0xb]
	ldrb r2, [r1, #0xa]
	lsl r3, r2, #8
	ldrb r2, [r1, #8]
	lsl r2, r2, #0x18
	ldrb r6, [r1, #9]
	lsl r6, r6, #0x10
	eor r2, r6
	eor r3, r2
	eor r5, r3
	ldr r2, [sp, #0x2c]
	eor r2, r5
	str r2, [sp, #0x2c]
	ldr r6, [r0, #0xc]
	ldrb r5, [r1, #0xf]
	ldrb r2, [r1, #0xe]
	lsl r3, r2, #8
	ldrb r2, [r1, #0xc]
	lsl r2, r2, #0x18
	ldrb r1, [r1, #0xd]
	lsl r1, r1, #0x10
	eor r2, r1
	eor r3, r2
	eor r5, r3
	eor r6, r5
	asr r1, r4, #1
	str r1, [sp, #0xc]
	mov r2, #0xff
_02156BDE:
	ldr r1, [r0, #0x10]
	str r1, [sp, #0x10]
	ldr r1, [sp, #8]
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02156F64 // =0x02178128
	ldr r5, [r1, r3]
	ldr r1, [sp, #0x2c]
	lsr r1, r1, #8
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02156F68 // =0x02177D28
	ldr r4, [r1, r3]
	ldr r1, [sp, #4]
	lsr r1, r1, #0x18
	lsl r3, r1, #2
	ldr r1, _02156F6C // =0x02179D28
	ldr r7, [r1, r3]
	lsr r1, r6, #0x10
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02156F70 // =0x0217A128
	ldr r1, [r1, r3]
	eor r7, r1
	eor r4, r7
	eor r5, r4
	ldr r1, [sp, #0x10]
	eor r1, r5
	str r1, [sp, #0x10]
	ldr r1, [r0, #0x14]
	str r1, [sp, #0x14]
	ldr r1, [sp, #0x2c]
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02156F64 // =0x02178128
	ldr r5, [r1, r3]
	lsr r1, r6, #8
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02156F68 // =0x02177D28
	ldr r4, [r1, r3]
	ldr r1, [sp, #8]
	lsr r1, r1, #0x18
	lsl r3, r1, #2
	ldr r1, _02156F6C // =0x02179D28
	ldr r7, [r1, r3]
	ldr r1, [sp, #4]
	lsr r1, r1, #0x10
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02156F70 // =0x0217A128
	ldr r1, [r1, r3]
	eor r7, r1
	eor r4, r7
	eor r5, r4
	ldr r1, [sp, #0x14]
	eor r1, r5
	str r1, [sp, #0x14]
	ldr r5, [r0, #0x18]
	mov r1, r6
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02156F64 // =0x02178128
	ldr r4, [r1, r3]
	ldr r1, [sp, #4]
	lsr r1, r1, #8
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02156F68 // =0x02177D28
	ldr r1, [r1, r3]
	str r1, [sp, #0x18]
	ldr r1, [sp, #0x2c]
	lsr r1, r1, #0x18
	lsl r3, r1, #2
	ldr r1, _02156F6C // =0x02179D28
	ldr r7, [r1, r3]
	ldr r1, [sp, #8]
	lsr r1, r1, #0x10
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02156F70 // =0x0217A128
	ldr r1, [r1, r3]
	eor r7, r1
	ldr r1, [sp, #0x18]
	eor r1, r7
	str r1, [sp, #0x18]
	eor r4, r1
	eor r5, r4
	ldr r1, [r0, #0x1c]
	ldr r3, [sp, #4]
	and r3, r2
	str r3, [sp, #4]
	lsl r4, r3, #2
	ldr r3, _02156F64 // =0x02178128
	ldr r3, [r3, r4]
	str r3, [sp, #0x30]
	ldr r3, [sp, #8]
	lsr r3, r3, #8
	and r3, r2
	lsl r4, r3, #2
	ldr r3, _02156F68 // =0x02177D28
	ldr r7, [r3, r4]
	lsr r3, r6, #0x18
	lsl r4, r3, #2
	ldr r3, _02156F6C // =0x02179D28
	ldr r6, [r3, r4]
	ldr r3, [sp, #0x2c]
	lsr r3, r3, #0x10
	and r3, r2
	lsl r4, r3, #2
	ldr r3, _02156F70 // =0x0217A128
	ldr r3, [r3, r4]
	eor r6, r3
	eor r7, r6
	ldr r3, [sp, #0x30]
	eor r3, r7
	str r3, [sp, #0x30]
	eor r1, r3
	add r0, #0x20
	ldr r3, [sp, #0xc]
	sub r3, r3, #1
	str r3, [sp, #0xc]
	cmp r3, #0
	beq _02156DCA
	ldr r3, [r0]
	str r3, [sp, #4]
	ldr r3, [sp, #0x14]
	and r3, r2
	lsl r4, r3, #2
	ldr r3, _02156F64 // =0x02178128
	ldr r6, [r3, r4]
	lsr r3, r5, #8
	and r3, r2
	lsl r4, r3, #2
	ldr r3, _02156F68 // =0x02177D28
	ldr r3, [r3, r4]
	str r3, [sp, #0x34]
	ldr r3, [sp, #0x10]
	lsr r3, r3, #0x18
	lsl r4, r3, #2
	ldr r3, _02156F6C // =0x02179D28
	ldr r7, [r3, r4]
	lsr r3, r1, #0x10
	and r3, r2
	lsl r4, r3, #2
	ldr r3, _02156F70 // =0x0217A128
	ldr r3, [r3, r4]
	eor r7, r3
	ldr r3, [sp, #0x34]
	eor r3, r7
	str r3, [sp, #0x34]
	eor r6, r3
	ldr r3, [sp, #4]
	eor r3, r6
	str r3, [sp, #4]
	ldr r3, [r0, #4]
	str r3, [sp, #8]
	mov r3, r5
	and r3, r2
	lsl r4, r3, #2
	ldr r3, _02156F64 // =0x02178128
	ldr r6, [r3, r4]
	lsr r3, r1, #8
	and r3, r2
	lsl r4, r3, #2
	ldr r3, _02156F68 // =0x02177D28
	ldr r3, [r3, r4]
	str r3, [sp, #0x38]
	ldr r3, [sp, #0x14]
	lsr r3, r3, #0x18
	lsl r4, r3, #2
	ldr r3, _02156F6C // =0x02179D28
	ldr r7, [r3, r4]
	ldr r3, [sp, #0x10]
	lsr r3, r3, #0x10
	and r3, r2
	lsl r4, r3, #2
	ldr r3, _02156F70 // =0x0217A128
	ldr r3, [r3, r4]
	eor r7, r3
	ldr r3, [sp, #0x38]
	eor r3, r7
	str r3, [sp, #0x38]
	eor r6, r3
	ldr r3, [sp, #8]
	eor r3, r6
	str r3, [sp, #8]
	ldr r3, [r0, #8]
	str r3, [sp, #0x2c]
	mov r3, r1
	and r3, r2
	lsl r4, r3, #2
	ldr r3, _02156F64 // =0x02178128
	ldr r6, [r3, r4]
	ldr r3, [sp, #0x10]
	lsr r3, r3, #8
	and r3, r2
	lsl r4, r3, #2
	ldr r3, _02156F68 // =0x02177D28
	ldr r3, [r3, r4]
	str r3, [sp, #0x1c]
	lsr r3, r5, #0x18
	lsl r4, r3, #2
	ldr r3, _02156F6C // =0x02179D28
	ldr r7, [r3, r4]
	ldr r3, [sp, #0x14]
	lsr r3, r3, #0x10
	and r3, r2
	lsl r4, r3, #2
	ldr r3, _02156F70 // =0x0217A128
	ldr r3, [r3, r4]
	eor r7, r3
	ldr r3, [sp, #0x1c]
	eor r3, r7
	str r3, [sp, #0x1c]
	eor r6, r3
	ldr r3, [sp, #0x2c]
	eor r3, r6
	str r3, [sp, #0x2c]
	ldr r6, [r0, #0xc]
	ldr r3, [sp, #0x10]
	and r3, r2
	str r3, [sp, #0x10]
	lsl r4, r3, #2
	ldr r3, _02156F64 // =0x02178128
	ldr r7, [r3, r4]
	ldr r3, [sp, #0x14]
	lsr r3, r3, #8
	and r3, r2
	lsl r4, r3, #2
	ldr r3, _02156F68 // =0x02177D28
	ldr r3, [r3, r4]
	lsr r1, r1, #0x18
	lsl r4, r1, #2
	ldr r1, _02156F6C // =0x02179D28
	ldr r1, [r1, r4]
	lsr r4, r5, #0x10
	and r4, r2
	lsl r5, r4, #2
	ldr r4, _02156F70 // =0x0217A128
	ldr r4, [r4, r5]
	eor r1, r4
	eor r3, r1
	eor r7, r3
	eor r6, r7
	b _02156BDE
_02156DCA:
	ldr r3, [r0]
	ldr r4, [sp, #0x14]
	mov r2, #0xff
	and r4, r2
	lsl r4, r4, #2
	ldr r2, _02156F74 // =0x02178528
	ldr r6, [r2, r4]
	str r6, [sp, #0x20]
	mov r4, #0xff
	and r6, r4
	str r6, [sp, #0x20]
	lsr r6, r5, #8
	and r6, r4
	lsl r4, r6, #2
	ldr r7, [r2, r4]
	ldr r4, _02156F78 // =0x0000FF00
	and r7, r4
	ldr r4, [sp, #0x10]
	lsr r4, r4, #0x18
	lsl r4, r4, #2
	ldr r4, [r2, r4]
	str r4, [sp, #0x54]
	ldr r6, _02156F7C // =0xFF000000
	and r4, r6
	str r4, [sp, #0x54]
	lsr r4, r1, #0x10
	str r4, [sp, #0x40]
	mov r6, #0xff
	and r4, r6
	str r4, [sp, #0x40]
	lsl r4, r4, #2
	ldr r4, [r2, r4]
	str r4, [sp, #0x3c]
	ldr r4, _02156F80 // =0x00FF0000
	ldr r6, [sp, #0x3c]
	and r6, r4
	str r6, [sp, #0x3c]
	ldr r4, [sp, #0x54]
	eor r4, r6
	str r4, [sp, #0x54]
	eor r7, r4
	ldr r4, [sp, #0x20]
	eor r4, r7
	str r4, [sp, #0x20]
	eor r3, r4
	lsr r6, r3, #0x18
	ldr r4, [sp]
	strb r6, [r4]
	lsr r6, r3, #0x10
	strb r6, [r4, #1]
	lsr r6, r3, #8
	strb r6, [r4, #2]
	strb r3, [r4, #3]
	ldr r3, [r0, #4]
	mov r6, r5
	mov r4, #0xff
	and r6, r4
	lsl r4, r6, #2
	ldr r6, [r2, r4]
	str r6, [sp, #0x24]
	mov r4, #0xff
	and r6, r4
	str r6, [sp, #0x24]
	lsr r6, r1, #8
	and r6, r4
	lsl r4, r6, #2
	ldr r7, [r2, r4]
	ldr r4, _02156F78 // =0x0000FF00
	and r7, r4
	ldr r4, [sp, #0x14]
	lsr r4, r4, #0x18
	lsl r4, r4, #2
	ldr r4, [r2, r4]
	str r4, [sp, #0x58]
	ldr r6, _02156F7C // =0xFF000000
	and r4, r6
	str r4, [sp, #0x58]
	ldr r4, [sp, #0x10]
	lsr r4, r4, #0x10
	str r4, [sp, #0x48]
	mov r6, #0xff
	and r4, r6
	str r4, [sp, #0x48]
	lsl r4, r4, #2
	ldr r4, [r2, r4]
	str r4, [sp, #0x44]
	ldr r4, _02156F80 // =0x00FF0000
	ldr r6, [sp, #0x44]
	and r6, r4
	str r6, [sp, #0x44]
	ldr r4, [sp, #0x58]
	eor r4, r6
	str r4, [sp, #0x58]
	eor r7, r4
	ldr r4, [sp, #0x24]
	eor r4, r7
	str r4, [sp, #0x24]
	eor r3, r4
	lsr r6, r3, #0x18
	ldr r4, [sp]
	strb r6, [r4, #4]
	lsr r6, r3, #0x10
	strb r6, [r4, #5]
	lsr r6, r3, #8
	strb r6, [r4, #6]
	strb r3, [r4, #7]
	ldr r3, [r0, #8]
	mov r6, r1
	mov r4, #0xff
	and r6, r4
	lsl r4, r6, #2
	ldr r6, [r2, r4]
	str r6, [sp, #0x28]
	mov r4, #0xff
	and r6, r4
	str r6, [sp, #0x28]
	ldr r4, [sp, #0x10]
	lsr r6, r4, #8
	mov r4, #0xff
	and r6, r4
	lsl r4, r6, #2
	ldr r7, [r2, r4]
	ldr r4, _02156F78 // =0x0000FF00
	and r7, r4
	lsr r4, r5, #0x18
	lsl r4, r4, #2
	ldr r4, [r2, r4]
	str r4, [sp, #0x5c]
	ldr r6, _02156F7C // =0xFF000000
	and r4, r6
	str r4, [sp, #0x5c]
	ldr r4, [sp, #0x14]
	lsr r4, r4, #0x10
	str r4, [sp, #0x50]
	mov r6, #0xff
	and r4, r6
	str r4, [sp, #0x50]
	lsl r4, r4, #2
	ldr r4, [r2, r4]
	str r4, [sp, #0x4c]
	ldr r4, _02156F80 // =0x00FF0000
	ldr r6, [sp, #0x4c]
	and r6, r4
	str r6, [sp, #0x4c]
	ldr r4, [sp, #0x5c]
	eor r4, r6
	str r4, [sp, #0x5c]
	eor r7, r4
	ldr r4, [sp, #0x28]
	eor r4, r7
	str r4, [sp, #0x28]
	eor r3, r4
	lsr r6, r3, #0x18
	ldr r4, [sp]
	strb r6, [r4, #8]
	lsr r6, r3, #0x10
	strb r6, [r4, #9]
	lsr r6, r3, #8
	strb r6, [r4, #0xa]
	strb r3, [r4, #0xb]
	ldr r6, [r0, #0xc]
	ldr r3, [sp, #0x10]
	mov r0, #0xff
	and r3, r0
	str r3, [sp, #0x10]
	lsl r0, r3, #2
	ldr r4, [r2, r0]
	mov r0, #0xff
	and r4, r0
	ldr r0, [sp, #0x14]
	lsr r3, r0, #8
	mov r0, #0xff
	and r3, r0
	lsl r0, r3, #2
	ldr r3, [r2, r0]
	ldr r0, _02156F78 // =0x0000FF00
	and r3, r0
	lsr r0, r1, #0x18
	lsl r0, r0, #2
	ldr r0, [r2, r0]
	ldr r1, _02156F7C // =0xFF000000
	and r0, r1
	lsr r5, r5, #0x10
	mov r1, #0xff
	and r5, r1
	lsl r1, r5, #2
	ldr r2, [r2, r1]
	ldr r1, _02156F80 // =0x00FF0000
	and r2, r1
	eor r0, r2
	eor r3, r0
	eor r4, r3
	eor r6, r4
	lsr r1, r6, #0x18
	ldr r0, [sp]
	strb r1, [r0, #0xc]
	lsr r1, r6, #0x10
	strb r1, [r0, #0xd]
	lsr r1, r6, #8
	strb r1, [r0, #0xe]
	strb r6, [r0, #0xf]
	add sp, #0x60
	pop {r4, r5, r6, r7}
	bx lr
	nop
_02156F64: .word 0x02178128
_02156F68: .word 0x02177D28
_02156F6C: .word 0x02179D28
_02156F70: .word 0x0217A128
_02156F74: .word 0x02178528
_02156F78: .word 0x0000FF00
_02156F7C: .word 0xFF000000
_02156F80: .word 0x00FF0000
	thumb_func_end ovl08_2156B5C

	thumb_func_start ovl08_2156F84
ovl08_2156F84: // 0x02156F84
	push {r4, r5, r6, r7}
	sub sp, #0x60
	mov r4, r1
	mov r1, r2
	str r3, [sp]
	ldr r2, [r0]
	str r2, [sp, #4]
	ldrb r5, [r1, #3]
	ldrb r2, [r1, #2]
	lsl r3, r2, #8
	ldrb r2, [r1]
	lsl r2, r2, #0x18
	ldrb r6, [r1, #1]
	lsl r6, r6, #0x10
	eor r2, r6
	eor r3, r2
	eor r5, r3
	ldr r2, [sp, #4]
	eor r2, r5
	str r2, [sp, #4]
	ldr r2, [r0, #4]
	str r2, [sp, #8]
	ldrb r5, [r1, #7]
	ldrb r2, [r1, #6]
	lsl r3, r2, #8
	ldrb r2, [r1, #4]
	lsl r2, r2, #0x18
	ldrb r6, [r1, #5]
	lsl r6, r6, #0x10
	eor r2, r6
	eor r3, r2
	eor r5, r3
	ldr r2, [sp, #8]
	eor r2, r5
	str r2, [sp, #8]
	ldr r2, [r0, #8]
	str r2, [sp, #0x2c]
	ldrb r5, [r1, #0xb]
	ldrb r2, [r1, #0xa]
	lsl r3, r2, #8
	ldrb r2, [r1, #8]
	lsl r2, r2, #0x18
	ldrb r6, [r1, #9]
	lsl r6, r6, #0x10
	eor r2, r6
	eor r3, r2
	eor r5, r3
	ldr r2, [sp, #0x2c]
	eor r2, r5
	str r2, [sp, #0x2c]
	ldr r6, [r0, #0xc]
	ldrb r5, [r1, #0xf]
	ldrb r2, [r1, #0xe]
	lsl r3, r2, #8
	ldrb r2, [r1, #0xc]
	lsl r2, r2, #0x18
	ldrb r1, [r1, #0xd]
	lsl r1, r1, #0x10
	eor r2, r1
	eor r3, r2
	eor r5, r3
	eor r6, r5
	asr r1, r4, #1
	str r1, [sp, #0xc]
	mov r2, #0xff
_02157006:
	ldr r1, [r0, #0x10]
	str r1, [sp, #0x10]
	mov r1, r6
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02157384 // =0x02179528
	ldr r5, [r1, r3]
	ldr r1, [sp, #0x2c]
	lsr r1, r1, #8
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02157388 // =0x02179128
	ldr r4, [r1, r3]
	ldr r1, [sp, #4]
	lsr r1, r1, #0x18
	lsl r3, r1, #2
	ldr r1, _0215738C // =0x02178928
	ldr r7, [r1, r3]
	ldr r1, [sp, #8]
	lsr r1, r1, #0x10
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02157390 // =0x02178D28
	ldr r1, [r1, r3]
	eor r7, r1
	eor r4, r7
	eor r5, r4
	ldr r1, [sp, #0x10]
	eor r1, r5
	str r1, [sp, #0x10]
	ldr r1, [r0, #0x14]
	str r1, [sp, #0x14]
	ldr r1, [sp, #4]
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02157384 // =0x02179528
	ldr r5, [r1, r3]
	lsr r1, r6, #8
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02157388 // =0x02179128
	ldr r4, [r1, r3]
	ldr r1, [sp, #8]
	lsr r1, r1, #0x18
	lsl r3, r1, #2
	ldr r1, _0215738C // =0x02178928
	ldr r7, [r1, r3]
	ldr r1, [sp, #0x2c]
	lsr r1, r1, #0x10
	and r1, r2
	lsl r3, r1, #2
	ldr r1, _02157390 // =0x02178D28
	ldr r1, [r1, r3]
	eor r7, r1
	eor r4, r7
	eor r5, r4
	ldr r1, [sp, #0x14]
	eor r1, r5
	str r1, [sp, #0x14]
	ldr r3, [r0, #0x18]
	ldr r1, [sp, #8]
	and r1, r2
	lsl r4, r1, #2
	ldr r1, _02157384 // =0x02179528
	ldr r1, [r1, r4]
	ldr r4, [sp, #4]
	lsr r4, r4, #8
	and r4, r2
	lsl r5, r4, #2
	ldr r4, _02157388 // =0x02179128
	ldr r7, [r4, r5]
	ldr r4, [sp, #0x2c]
	lsr r4, r4, #0x18
	lsl r5, r4, #2
	ldr r4, _0215738C // =0x02178928
	ldr r4, [r4, r5]
	str r4, [sp, #0x18]
	lsr r4, r6, #0x10
	and r4, r2
	lsl r5, r4, #2
	ldr r4, _02157390 // =0x02178D28
	ldr r5, [r4, r5]
	ldr r4, [sp, #0x18]
	eor r4, r5
	str r4, [sp, #0x18]
	eor r7, r4
	eor r1, r7
	eor r3, r1
	ldr r1, [r0, #0x1c]
	ldr r4, [sp, #0x2c]
	and r4, r2
	str r4, [sp, #0x2c]
	lsl r5, r4, #2
	ldr r4, _02157384 // =0x02179528
	ldr r4, [r4, r5]
	str r4, [sp, #0x30]
	ldr r4, [sp, #8]
	lsr r4, r4, #8
	and r4, r2
	lsl r5, r4, #2
	ldr r4, _02157388 // =0x02179128
	ldr r7, [r4, r5]
	lsr r4, r6, #0x18
	lsl r5, r4, #2
	ldr r4, _0215738C // =0x02178928
	ldr r6, [r4, r5]
	ldr r4, [sp, #4]
	lsr r4, r4, #0x10
	and r4, r2
	lsl r5, r4, #2
	ldr r4, _02157390 // =0x02178D28
	ldr r4, [r4, r5]
	eor r6, r4
	eor r7, r6
	ldr r4, [sp, #0x30]
	eor r4, r7
	str r4, [sp, #0x30]
	eor r1, r4
	add r0, #0x20
	ldr r4, [sp, #0xc]
	sub r4, r4, #1
	str r4, [sp, #0xc]
	cmp r4, #0
	beq _021571EE
	ldr r4, [r0]
	str r4, [sp, #4]
	mov r4, r1
	and r4, r2
	lsl r5, r4, #2
	ldr r4, _02157384 // =0x02179528
	ldr r6, [r4, r5]
	lsr r4, r3, #8
	and r4, r2
	lsl r5, r4, #2
	ldr r4, _02157388 // =0x02179128
	ldr r4, [r4, r5]
	str r4, [sp, #0x34]
	ldr r4, [sp, #0x10]
	lsr r4, r4, #0x18
	lsl r5, r4, #2
	ldr r4, _0215738C // =0x02178928
	ldr r7, [r4, r5]
	ldr r4, [sp, #0x14]
	lsr r4, r4, #0x10
	and r4, r2
	lsl r5, r4, #2
	ldr r4, _02157390 // =0x02178D28
	ldr r4, [r4, r5]
	eor r7, r4
	ldr r4, [sp, #0x34]
	eor r4, r7
	str r4, [sp, #0x34]
	eor r6, r4
	ldr r4, [sp, #4]
	eor r4, r6
	str r4, [sp, #4]
	ldr r4, [r0, #4]
	str r4, [sp, #8]
	ldr r4, [sp, #0x10]
	and r4, r2
	lsl r5, r4, #2
	ldr r4, _02157384 // =0x02179528
	ldr r6, [r4, r5]
	lsr r4, r1, #8
	and r4, r2
	lsl r5, r4, #2
	ldr r4, _02157388 // =0x02179128
	ldr r4, [r4, r5]
	str r4, [sp, #0x38]
	ldr r4, [sp, #0x14]
	lsr r4, r4, #0x18
	lsl r5, r4, #2
	ldr r4, _0215738C // =0x02178928
	ldr r7, [r4, r5]
	lsr r4, r3, #0x10
	and r4, r2
	lsl r5, r4, #2
	ldr r4, _02157390 // =0x02178D28
	ldr r4, [r4, r5]
	eor r7, r4
	ldr r4, [sp, #0x38]
	eor r4, r7
	str r4, [sp, #0x38]
	eor r6, r4
	ldr r4, [sp, #8]
	eor r4, r6
	str r4, [sp, #8]
	ldr r4, [r0, #8]
	str r4, [sp, #0x2c]
	ldr r4, [sp, #0x14]
	and r4, r2
	lsl r5, r4, #2
	ldr r4, _02157384 // =0x02179528
	ldr r4, [r4, r5]
	ldr r5, [sp, #0x10]
	lsr r5, r5, #8
	and r5, r2
	lsl r6, r5, #2
	ldr r5, _02157388 // =0x02179128
	ldr r7, [r5, r6]
	lsr r5, r3, #0x18
	lsl r6, r5, #2
	ldr r5, _0215738C // =0x02178928
	ldr r5, [r5, r6]
	str r5, [sp, #0x1c]
	lsr r5, r1, #0x10
	and r5, r2
	lsl r6, r5, #2
	ldr r5, _02157390 // =0x02178D28
	ldr r6, [r5, r6]
	ldr r5, [sp, #0x1c]
	eor r5, r6
	str r5, [sp, #0x1c]
	eor r7, r5
	eor r4, r7
	ldr r5, [sp, #0x2c]
	eor r5, r4
	str r5, [sp, #0x2c]
	ldr r6, [r0, #0xc]
	and r3, r2
	lsl r4, r3, #2
	ldr r3, _02157384 // =0x02179528
	ldr r3, [r3, r4]
	ldr r4, [sp, #0x14]
	lsr r4, r4, #8
	and r4, r2
	lsl r5, r4, #2
	ldr r4, _02157388 // =0x02179128
	ldr r7, [r4, r5]
	lsr r1, r1, #0x18
	lsl r4, r1, #2
	ldr r1, _0215738C // =0x02178928
	ldr r5, [r1, r4]
	ldr r1, [sp, #0x10]
	lsr r1, r1, #0x10
	and r1, r2
	lsl r4, r1, #2
	ldr r1, _02157390 // =0x02178D28
	ldr r1, [r1, r4]
	eor r5, r1
	eor r7, r5
	eor r3, r7
	eor r6, r3
	b _02157006
_021571EE:
	ldr r4, [r0]
	mov r5, r1
	mov r2, #0xff
	and r5, r2
	lsl r5, r5, #2
	ldr r2, _02157394 // =0x02179928
	ldr r6, [r2, r5]
	str r6, [sp, #0x20]
	mov r5, #0xff
	and r6, r5
	str r6, [sp, #0x20]
	lsr r6, r3, #8
	and r6, r5
	lsl r5, r6, #2
	ldr r7, [r2, r5]
	ldr r5, _02157398 // =0x0000FF00
	and r7, r5
	ldr r5, [sp, #0x10]
	lsr r5, r5, #0x18
	lsl r5, r5, #2
	ldr r5, [r2, r5]
	str r5, [sp, #0x54]
	ldr r6, _0215739C // =0xFF000000
	and r5, r6
	str r5, [sp, #0x54]
	ldr r5, [sp, #0x14]
	lsr r5, r5, #0x10
	str r5, [sp, #0x40]
	mov r6, #0xff
	and r5, r6
	str r5, [sp, #0x40]
	lsl r5, r5, #2
	ldr r5, [r2, r5]
	str r5, [sp, #0x3c]
	ldr r5, _021573A0 // =0x00FF0000
	ldr r6, [sp, #0x3c]
	and r6, r5
	str r6, [sp, #0x3c]
	ldr r5, [sp, #0x54]
	eor r5, r6
	str r5, [sp, #0x54]
	eor r7, r5
	ldr r5, [sp, #0x20]
	eor r5, r7
	str r5, [sp, #0x20]
	eor r4, r5
	lsr r6, r4, #0x18
	ldr r5, [sp]
	strb r6, [r5]
	lsr r6, r4, #0x10
	strb r6, [r5, #1]
	lsr r6, r4, #8
	strb r6, [r5, #2]
	strb r4, [r5, #3]
	ldr r4, [r0, #4]
	ldr r6, [sp, #0x10]
	mov r5, #0xff
	and r6, r5
	lsl r5, r6, #2
	ldr r6, [r2, r5]
	str r6, [sp, #0x24]
	mov r5, #0xff
	and r6, r5
	str r6, [sp, #0x24]
	lsr r6, r1, #8
	and r6, r5
	lsl r5, r6, #2
	ldr r7, [r2, r5]
	ldr r5, _02157398 // =0x0000FF00
	and r7, r5
	ldr r5, [sp, #0x14]
	lsr r5, r5, #0x18
	lsl r5, r5, #2
	ldr r5, [r2, r5]
	str r5, [sp, #0x58]
	ldr r6, _0215739C // =0xFF000000
	and r5, r6
	str r5, [sp, #0x58]
	lsr r5, r3, #0x10
	str r5, [sp, #0x48]
	mov r6, #0xff
	and r5, r6
	str r5, [sp, #0x48]
	lsl r5, r5, #2
	ldr r5, [r2, r5]
	str r5, [sp, #0x44]
	ldr r5, _021573A0 // =0x00FF0000
	ldr r6, [sp, #0x44]
	and r6, r5
	str r6, [sp, #0x44]
	ldr r5, [sp, #0x58]
	eor r5, r6
	str r5, [sp, #0x58]
	eor r7, r5
	ldr r5, [sp, #0x24]
	eor r5, r7
	str r5, [sp, #0x24]
	eor r4, r5
	lsr r6, r4, #0x18
	ldr r5, [sp]
	strb r6, [r5, #4]
	lsr r6, r4, #0x10
	strb r6, [r5, #5]
	lsr r6, r4, #8
	strb r6, [r5, #6]
	strb r4, [r5, #7]
	ldr r4, [r0, #8]
	ldr r6, [sp, #0x14]
	mov r5, #0xff
	and r6, r5
	lsl r5, r6, #2
	ldr r6, [r2, r5]
	str r6, [sp, #0x28]
	mov r5, #0xff
	and r6, r5
	str r6, [sp, #0x28]
	ldr r5, [sp, #0x10]
	lsr r6, r5, #8
	mov r5, #0xff
	and r6, r5
	lsl r5, r6, #2
	ldr r7, [r2, r5]
	ldr r5, _02157398 // =0x0000FF00
	and r7, r5
	lsr r5, r3, #0x18
	lsl r5, r5, #2
	ldr r5, [r2, r5]
	str r5, [sp, #0x5c]
	ldr r6, _0215739C // =0xFF000000
	and r5, r6
	str r5, [sp, #0x5c]
	lsr r5, r1, #0x10
	str r5, [sp, #0x50]
	mov r6, #0xff
	and r5, r6
	str r5, [sp, #0x50]
	lsl r5, r5, #2
	ldr r5, [r2, r5]
	str r5, [sp, #0x4c]
	ldr r5, _021573A0 // =0x00FF0000
	ldr r6, [sp, #0x4c]
	and r6, r5
	str r6, [sp, #0x4c]
	ldr r5, [sp, #0x5c]
	eor r5, r6
	str r5, [sp, #0x5c]
	eor r7, r5
	ldr r5, [sp, #0x28]
	eor r5, r7
	str r5, [sp, #0x28]
	eor r4, r5
	lsr r6, r4, #0x18
	ldr r5, [sp]
	strb r6, [r5, #8]
	lsr r6, r4, #0x10
	strb r6, [r5, #9]
	lsr r6, r4, #8
	strb r6, [r5, #0xa]
	strb r4, [r5, #0xb]
	ldr r5, [r0, #0xc]
	mov r0, #0xff
	and r3, r0
	lsl r0, r3, #2
	ldr r4, [r2, r0]
	mov r0, #0xff
	and r4, r0
	ldr r0, [sp, #0x14]
	lsr r3, r0, #8
	mov r0, #0xff
	and r3, r0
	lsl r0, r3, #2
	ldr r3, [r2, r0]
	ldr r0, _02157398 // =0x0000FF00
	and r3, r0
	lsr r0, r1, #0x18
	lsl r0, r0, #2
	ldr r0, [r2, r0]
	ldr r1, _0215739C // =0xFF000000
	and r0, r1
	ldr r1, [sp, #0x10]
	lsr r6, r1, #0x10
	mov r1, #0xff
	and r6, r1
	lsl r1, r6, #2
	ldr r2, [r2, r1]
	ldr r1, _021573A0 // =0x00FF0000
	and r2, r1
	eor r0, r2
	eor r3, r0
	eor r4, r3
	eor r5, r4
	lsr r1, r5, #0x18
	ldr r0, [sp]
	strb r1, [r0, #0xc]
	lsr r1, r5, #0x10
	strb r1, [r0, #0xd]
	lsr r1, r5, #8
	strb r1, [r0, #0xe]
	strb r5, [r0, #0xf]
	add sp, #0x60
	pop {r4, r5, r6, r7}
	bx lr
	nop
_02157384: .word 0x02179528
_02157388: .word 0x02179128
_0215738C: .word 0x02178928
_02157390: .word 0x02178D28
_02157394: .word 0x02179928
_02157398: .word 0x0000FF00
_0215739C: .word 0xFF000000
_021573A0: .word 0x00FF0000
	thumb_func_end ovl08_2156F84

	thumb_func_start ovl08_21573A4
ovl08_21573A4: // 0x021573A4
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r4, r0
	bl ovl08_2157568
	str r0, [sp]
	mov r6, #0
	lsl r5, r0, #2
	cmp r5, #0
	ble _02157408
	str r4, [sp, #4]
	lsl r0, r5, #2
	add r3, r4, r0
_021573BE:
	ldr r0, [sp, #4]
	ldr r2, [r0]
	ldr r1, [r3]
	str r1, [r0]
	str r2, [r3]
	add r0, r6, #1
	lsl r2, r0, #2
	ldr r1, [r4, r2]
	add r0, r5, #1
	lsl r7, r0, #2
	ldr r0, [r4, r7]
	str r0, [r4, r2]
	str r1, [r4, r7]
	add r0, r6, #2
	lsl r2, r0, #2
	ldr r1, [r4, r2]
	add r0, r5, #2
	lsl r7, r0, #2
	ldr r0, [r4, r7]
	str r0, [r4, r2]
	str r1, [r4, r7]
	add r0, r6, #3
	lsl r2, r0, #2
	ldr r1, [r4, r2]
	add r0, r5, #3
	lsl r7, r0, #2
	ldr r0, [r4, r7]
	str r0, [r4, r2]
	str r1, [r4, r7]
	ldr r0, [sp, #4]
	add r0, #0x10
	str r0, [sp, #4]
	add r6, r6, #4
	sub r3, #0x10
	sub r5, r5, #4
	cmp r6, r5
	blt _021573BE
_02157408:
	mov r0, #1
	str r0, [sp, #8]
	ldr r0, [sp]
	cmp r0, #1
	bgt _02157414
	b _02157548
_02157414:
	ldr r2, _02157554 // =0x02179928
	mov r0, #0xff
_02157418:
	add r4, #0x10
	ldr r5, [r4]
	mov r1, r5
	and r1, r0
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	and r1, r0
	lsl r3, r1, #2
	ldr r1, _02157558 // =0x02178128
	ldr r3, [r1, r3]
	lsr r1, r5, #8
	and r1, r0
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	and r1, r0
	lsl r6, r1, #2
	ldr r1, _0215755C // =0x02177D28
	ldr r7, [r1, r6]
	lsr r1, r5, #0x18
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	and r1, r0
	lsl r6, r1, #2
	ldr r1, _02157560 // =0x02179D28
	ldr r1, [r1, r6]
	lsr r5, r5, #0x10
	and r5, r0
	lsl r5, r5, #2
	ldr r5, [r2, r5]
	and r5, r0
	lsl r6, r5, #2
	ldr r5, _02157564 // =0x0217A128
	ldr r5, [r5, r6]
	eor r1, r5
	eor r7, r1
	eor r3, r7
	str r3, [r4]
	ldr r5, [r4, #4]
	mov r1, r5
	and r1, r0
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	and r1, r0
	lsl r3, r1, #2
	ldr r1, _02157558 // =0x02178128
	ldr r3, [r1, r3]
	lsr r1, r5, #8
	and r1, r0
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	and r1, r0
	lsl r6, r1, #2
	ldr r1, _0215755C // =0x02177D28
	ldr r7, [r1, r6]
	lsr r1, r5, #0x18
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	and r1, r0
	lsl r6, r1, #2
	ldr r1, _02157560 // =0x02179D28
	ldr r1, [r1, r6]
	lsr r5, r5, #0x10
	and r5, r0
	lsl r5, r5, #2
	ldr r5, [r2, r5]
	and r5, r0
	lsl r6, r5, #2
	ldr r5, _02157564 // =0x0217A128
	ldr r5, [r5, r6]
	eor r1, r5
	eor r7, r1
	eor r3, r7
	str r3, [r4, #4]
	ldr r5, [r4, #8]
	mov r1, r5
	and r1, r0
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	and r1, r0
	lsl r3, r1, #2
	ldr r1, _02157558 // =0x02178128
	ldr r3, [r1, r3]
	lsr r1, r5, #8
	and r1, r0
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	and r1, r0
	lsl r6, r1, #2
	ldr r1, _0215755C // =0x02177D28
	ldr r7, [r1, r6]
	lsr r1, r5, #0x18
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	and r1, r0
	lsl r6, r1, #2
	ldr r1, _02157560 // =0x02179D28
	ldr r1, [r1, r6]
	lsr r5, r5, #0x10
	and r5, r0
	lsl r5, r5, #2
	ldr r5, [r2, r5]
	and r5, r0
	lsl r6, r5, #2
	ldr r5, _02157564 // =0x0217A128
	ldr r5, [r5, r6]
	eor r1, r5
	eor r7, r1
	eor r3, r7
	str r3, [r4, #8]
	ldr r5, [r4, #0xc]
	mov r1, r5
	and r1, r0
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	and r1, r0
	lsl r3, r1, #2
	ldr r1, _02157558 // =0x02178128
	ldr r3, [r1, r3]
	lsr r1, r5, #8
	and r1, r0
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	and r1, r0
	lsl r6, r1, #2
	ldr r1, _0215755C // =0x02177D28
	ldr r7, [r1, r6]
	lsr r1, r5, #0x18
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	and r1, r0
	lsl r6, r1, #2
	ldr r1, _02157560 // =0x02179D28
	ldr r1, [r1, r6]
	lsr r5, r5, #0x10
	and r5, r0
	lsl r5, r5, #2
	ldr r5, [r2, r5]
	and r5, r0
	lsl r6, r5, #2
	ldr r5, _02157564 // =0x0217A128
	ldr r5, [r5, r6]
	eor r1, r5
	eor r7, r1
	eor r3, r7
	str r3, [r4, #0xc]
	ldr r1, [sp, #8]
	add r3, r1, #1
	str r3, [sp, #8]
	ldr r1, [sp]
	cmp r3, r1
	bge _02157548
	b _02157418
_02157548:
	ldr r0, [sp]
	add sp, #0xc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_02157554: .word 0x02179928
_02157558: .word 0x02178128
_0215755C: .word 0x02177D28
_02157560: .word 0x02179D28
_02157564: .word 0x0217A128
	thumb_func_end ovl08_21573A4

	thumb_func_start ovl08_2157568
ovl08_2157568: // 0x02157568
	push {r4, r5, r6, r7}
	sub sp, #0x20
	mov r3, r1
	mov r1, r2
	mov r2, #0
	str r2, [sp]
	ldrb r5, [r3, #3]
	ldrb r2, [r3, #2]
	lsl r4, r2, #8
	ldrb r2, [r3]
	lsl r2, r2, #0x18
	ldrb r6, [r3, #1]
	lsl r6, r6, #0x10
	eor r2, r6
	eor r4, r2
	eor r5, r4
	str r5, [r0]
	ldrb r5, [r3, #7]
	ldrb r2, [r3, #6]
	lsl r4, r2, #8
	ldrb r2, [r3, #4]
	lsl r2, r2, #0x18
	ldrb r6, [r3, #5]
	lsl r6, r6, #0x10
	eor r2, r6
	eor r4, r2
	eor r5, r4
	str r5, [r0, #4]
	ldrb r5, [r3, #0xb]
	ldrb r2, [r3, #0xa]
	lsl r4, r2, #8
	ldrb r2, [r3, #8]
	lsl r2, r2, #0x18
	ldrb r6, [r3, #9]
	lsl r6, r6, #0x10
	eor r2, r6
	eor r4, r2
	eor r5, r4
	str r5, [r0, #8]
	ldrb r5, [r3, #0xf]
	ldrb r2, [r3, #0xe]
	lsl r4, r2, #8
	ldrb r2, [r3, #0xc]
	lsl r2, r2, #0x18
	ldrb r6, [r3, #0xd]
	lsl r6, r6, #0x10
	eor r2, r6
	eor r4, r2
	eor r5, r4
	str r5, [r0, #0xc]
	cmp r1, #0x80
	bne _02157654
	ldr r6, _02157838 // =_02177D00
_021575D2:
	ldr r5, [r0, #0xc]
	ldr r1, [r6]
	str r1, [sp, #0xc]
	lsr r1, r5, #0x18
	lsl r2, r1, #2
	ldr r1, _0215783C // =0x02179928
	ldr r4, [r1, r2]
	mov r1, #0xff
	and r4, r1
	mov r2, r5
	and r2, r1
	lsl r2, r2, #2
	ldr r1, _0215783C // =0x02179928
	ldr r7, [r1, r2]
	ldr r1, _02157840 // =0x0000FF00
	and r7, r1
	ldr r3, [r0]
	lsr r2, r5, #0x10
	mov r1, #0xff
	and r2, r1
	lsl r2, r2, #2
	ldr r1, _0215783C // =0x02179928
	ldr r2, [r1, r2]
	ldr r1, _02157844 // =0xFF000000
	and r2, r1
	eor r3, r2
	lsr r2, r5, #8
	mov r1, #0xff
	and r2, r1
	lsl r2, r2, #2
	ldr r1, _0215783C // =0x02179928
	ldr r2, [r1, r2]
	ldr r1, _02157848 // =0x00FF0000
	and r2, r1
	eor r3, r2
	eor r7, r3
	eor r4, r7
	ldr r1, [sp, #0xc]
	eor r1, r4
	str r1, [sp, #0xc]
	str r1, [r0, #0x10]
	ldr r2, [r0, #4]
	ldr r1, [r0, #0x10]
	eor r2, r1
	str r2, [r0, #0x14]
	ldr r2, [r0, #8]
	ldr r1, [r0, #0x14]
	eor r2, r1
	str r2, [r0, #0x18]
	ldr r2, [r0, #0xc]
	ldr r1, [r0, #0x18]
	eor r2, r1
	str r2, [r0, #0x1c]
	add r6, r6, #4
	ldr r1, [sp]
	add r1, r1, #1
	str r1, [sp]
	cmp r1, #0xa
	blt _02157650
	mov r0, #0xa
	add sp, #0x20
	pop {r4, r5, r6, r7}
	bx lr
_02157650:
	add r0, #0x10
	b _021575D2
_02157654:
	ldrb r5, [r3, #0x13]
	ldrb r2, [r3, #0x12]
	lsl r4, r2, #8
	ldrb r2, [r3, #0x10]
	lsl r2, r2, #0x18
	ldrb r6, [r3, #0x11]
	lsl r6, r6, #0x10
	eor r2, r6
	eor r4, r2
	eor r5, r4
	str r5, [r0, #0x10]
	ldrb r5, [r3, #0x17]
	ldrb r2, [r3, #0x16]
	lsl r4, r2, #8
	ldrb r2, [r3, #0x14]
	lsl r2, r2, #0x18
	ldrb r6, [r3, #0x15]
	lsl r6, r6, #0x10
	eor r2, r6
	eor r4, r2
	eor r5, r4
	str r5, [r0, #0x14]
	cmp r1, #0xc0
	bne _02157718
	ldr r6, _02157838 // =_02177D00
_02157686:
	ldr r5, [r0, #0x14]
	ldr r1, [r6]
	str r1, [sp, #0x10]
	lsr r1, r5, #0x18
	lsl r2, r1, #2
	ldr r1, _0215783C // =0x02179928
	ldr r4, [r1, r2]
	mov r1, #0xff
	and r4, r1
	mov r2, r5
	and r2, r1
	lsl r2, r2, #2
	ldr r1, _0215783C // =0x02179928
	ldr r7, [r1, r2]
	ldr r1, _02157840 // =0x0000FF00
	and r7, r1
	ldr r3, [r0]
	lsr r2, r5, #0x10
	mov r1, #0xff
	and r2, r1
	lsl r2, r2, #2
	ldr r1, _0215783C // =0x02179928
	ldr r2, [r1, r2]
	ldr r1, _02157844 // =0xFF000000
	and r2, r1
	eor r3, r2
	lsr r2, r5, #8
	mov r1, #0xff
	and r2, r1
	lsl r2, r2, #2
	ldr r1, _0215783C // =0x02179928
	ldr r2, [r1, r2]
	ldr r1, _02157848 // =0x00FF0000
	and r2, r1
	eor r3, r2
	eor r7, r3
	eor r4, r7
	ldr r1, [sp, #0x10]
	eor r1, r4
	str r1, [sp, #0x10]
	str r1, [r0, #0x18]
	ldr r2, [r0, #4]
	ldr r1, [r0, #0x18]
	eor r2, r1
	str r2, [r0, #0x1c]
	ldr r2, [r0, #8]
	ldr r1, [r0, #0x1c]
	eor r2, r1
	str r2, [r0, #0x20]
	ldr r2, [r0, #0xc]
	ldr r1, [r0, #0x20]
	eor r2, r1
	str r2, [r0, #0x24]
	add r6, r6, #4
	ldr r1, [sp]
	add r1, r1, #1
	str r1, [sp]
	cmp r1, #8
	blt _02157704
	mov r0, #0xc
	add sp, #0x20
	pop {r4, r5, r6, r7}
	bx lr
_02157704:
	ldr r2, [r0, #0x10]
	ldr r1, [r0, #0x24]
	eor r2, r1
	str r2, [r0, #0x28]
	ldr r2, [r0, #0x14]
	ldr r1, [r0, #0x28]
	eor r2, r1
	str r2, [r0, #0x2c]
	add r0, #0x18
	b _02157686
_02157718:
	ldrb r5, [r3, #0x1b]
	ldrb r2, [r3, #0x1a]
	lsl r4, r2, #8
	ldrb r2, [r3, #0x18]
	lsl r2, r2, #0x18
	ldrb r6, [r3, #0x19]
	lsl r6, r6, #0x10
	eor r2, r6
	eor r4, r2
	eor r5, r4
	str r5, [r0, #0x18]
	ldrb r5, [r3, #0x1f]
	ldrb r2, [r3, #0x1e]
	lsl r4, r2, #8
	ldrb r2, [r3, #0x1c]
	lsl r2, r2, #0x18
	ldrb r3, [r3, #0x1d]
	lsl r3, r3, #0x10
	eor r2, r3
	eor r4, r2
	eor r5, r4
	str r5, [r0, #0x1c]
	ldr r2, _0215784C // =0x00000100
	cmp r1, r2
	bne _02157830
	ldr r1, _02157838 // =_02177D00
	str r1, [sp, #4]
	ldr r7, _0215783C // =0x02179928
_02157750:
	ldr r6, [r0, #0x1c]
	ldr r1, [sp, #4]
	ldr r1, [r1]
	str r1, [sp, #8]
	lsr r1, r6, #0x18
	lsl r1, r1, #2
	ldr r5, [r7, r1]
	mov r1, #0xff
	and r5, r1
	mov r2, r6
	and r2, r1
	lsl r1, r2, #2
	ldr r4, [r7, r1]
	ldr r1, _02157840 // =0x0000FF00
	and r4, r1
	ldr r3, [r0]
	lsr r2, r6, #0x10
	mov r1, #0xff
	and r2, r1
	lsl r1, r2, #2
	ldr r1, [r7, r1]
	str r1, [sp, #0x14]
	ldr r2, _02157844 // =0xFF000000
	and r1, r2
	str r1, [sp, #0x14]
	eor r3, r1
	lsr r2, r6, #8
	mov r1, #0xff
	and r2, r1
	lsl r1, r2, #2
	ldr r2, [r7, r1]
	ldr r1, _02157848 // =0x00FF0000
	and r2, r1
	eor r3, r2
	eor r4, r3
	eor r5, r4
	ldr r1, [sp, #8]
	eor r1, r5
	str r1, [sp, #8]
	str r1, [r0, #0x20]
	ldr r2, [r0, #4]
	ldr r1, [r0, #0x20]
	eor r2, r1
	str r2, [r0, #0x24]
	ldr r2, [r0, #8]
	ldr r1, [r0, #0x24]
	eor r2, r1
	str r2, [r0, #0x28]
	ldr r2, [r0, #0xc]
	ldr r1, [r0, #0x28]
	eor r2, r1
	str r2, [r0, #0x2c]
	ldr r1, [sp, #4]
	add r1, r1, #4
	str r1, [sp, #4]
	ldr r1, [sp]
	add r1, r1, #1
	str r1, [sp]
	cmp r1, #7
	blt _021577D0
	mov r0, #0xe
	add sp, #0x20
	pop {r4, r5, r6, r7}
	bx lr
_021577D0:
	ldr r6, [r0, #0x2c]
	mov r2, r6
	mov r1, #0xff
	and r2, r1
	lsl r1, r2, #2
	ldr r5, [r7, r1]
	mov r1, #0xff
	and r5, r1
	lsr r2, r6, #8
	and r2, r1
	lsl r1, r2, #2
	ldr r4, [r7, r1]
	ldr r1, _02157840 // =0x0000FF00
	and r4, r1
	ldr r3, [r0, #0x10]
	lsr r1, r6, #0x18
	lsl r1, r1, #2
	ldr r1, [r7, r1]
	str r1, [sp, #0x18]
	ldr r2, _02157844 // =0xFF000000
	and r1, r2
	str r1, [sp, #0x18]
	eor r3, r1
	lsr r2, r6, #0x10
	mov r1, #0xff
	and r2, r1
	lsl r1, r2, #2
	ldr r2, [r7, r1]
	ldr r1, _02157848 // =0x00FF0000
	and r2, r1
	eor r3, r2
	eor r4, r3
	eor r5, r4
	str r5, [r0, #0x30]
	ldr r2, [r0, #0x14]
	ldr r1, [r0, #0x30]
	eor r2, r1
	str r2, [r0, #0x34]
	ldr r2, [r0, #0x18]
	ldr r1, [r0, #0x34]
	eor r2, r1
	str r2, [r0, #0x38]
	ldr r2, [r0, #0x1c]
	ldr r1, [r0, #0x38]
	eor r2, r1
	str r2, [r0, #0x3c]
	add r0, #0x20
	b _02157750
_02157830:
	ldr r0, [sp]
	add sp, #0x20
	pop {r4, r5, r6, r7}
	bx lr
	.align 2, 0
_02157838: .word _02177D00
_0215783C: .word 0x02179928
_02157840: .word 0x0000FF00
_02157844: .word 0xFF000000
_02157848: .word 0x00FF0000
_0215784C: .word 0x00000100
	thumb_func_end ovl08_2157568

	thumb_func_start ovl08_2157850
ovl08_2157850: // 0x02157850
	push {r4}
	sub sp, #4
	ldrb r4, [r0]
	ldrb r3, [r1]
	eor r4, r3
	strb r4, [r2]
	ldrb r4, [r0, #1]
	ldrb r3, [r1, #1]
	eor r4, r3
	strb r4, [r2, #1]
	ldrb r4, [r0, #2]
	ldrb r3, [r1, #2]
	eor r4, r3
	strb r4, [r2, #2]
	ldrb r4, [r0, #3]
	ldrb r3, [r1, #3]
	eor r4, r3
	strb r4, [r2, #3]
	ldrb r4, [r0, #4]
	ldrb r3, [r1, #4]
	eor r4, r3
	strb r4, [r2, #4]
	ldrb r4, [r0, #5]
	ldrb r3, [r1, #5]
	eor r4, r3
	strb r4, [r2, #5]
	ldrb r4, [r0, #6]
	ldrb r3, [r1, #6]
	eor r4, r3
	strb r4, [r2, #6]
	ldrb r3, [r0, #7]
	ldrb r0, [r1, #7]
	eor r3, r0
	strb r3, [r2, #7]
	add sp, #4
	pop {r4}
	bx lr
	.align 2, 0
	thumb_func_end ovl08_2157850

	thumb_func_start ovl08_215789C
ovl08_215789C: // 0x0215789C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x1b4
	str r0, [sp]
	mov r5, r1
	mov r4, r2
	mov r0, #1
	str r0, [sp, #0x1c]
	ldr r0, _02157A80 // =0xA6A6A6A6
	str r0, [sp, #0x58]
	str r0, [sp, #0x5c]
	mov r0, #7
	mov r1, r4
	and r1, r0
	cmp r1, #0
	bne _021578C4
	ldr r2, [sp, #0x1c8]
	mov r1, r2
	and r1, r0
	cmp r1, #0
	beq _021578CE
_021578C4:
	mov r0, #0
	add sp, #0x1b4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021578CE:
	sub r0, r4, #1
	lsr r0, r0, #3
	str r0, [sp, #0x14]
	cmp r0, #2
	bge _021578E2
	mov r0, #0
	add sp, #0x1b4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021578E2:
	add r0, sp, #0x70
	mov r1, r3
	lsl r2, r2, #3
	bl ovl08_21573A4
	str r0, [sp, #0x18]
	add r3, sp, #0x60
	mov r2, r5
	mov r1, #8
_021578F4:
	ldrb r0, [r2]
	add r2, r2, #1
	strb r0, [r3]
	add r3, r3, #1
	sub r1, r1, #1
	cmp r1, #0
	bne _021578F4
	ldr r0, [sp]
	add r5, #8
	mov r1, r5
	sub r2, r4, #1
	blx memcpy
	mov r0, #5
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	asr r0, r0, #0x1f
	str r0, [sp, #0x24]
_02157918:
	ldr r0, [sp, #0x14]
	str r0, [sp, #0xc]
	cmp r0, #0
	bgt _02157922
	b _02157A58
_02157922:
	ldr r1, [sp, #0x24]
	ldr r2, [sp, #0x10]
	asr r3, r2, #0x1f
	blx _ull_mul
	str r0, [sp, #0x28]
	str r1, [sp, #8]
_02157930:
	ldr r0, [sp, #0xc]
	asr r1, r0, #0x1f
	lsl r2, r0, #0
	ldr r0, [sp, #0x28]
	add r6, r2, r0
	ldr r0, [sp, #8]
	adc r1, r0
	mov r2, r1
	ldr r0, _02157A84 // =0xFF000000
	and r2, r0
	lsr r0, r2, #0x18
	str r0, [sp, #0x30]
	mov r2, r1
	ldr r0, _02157A88 // =0x00FF0000
	and r2, r0
	lsr r0, r2, #8
	str r0, [sp, #0x48]
	mov r2, r1
	ldr r0, _02157A8C // =0x0000FF00
	and r2, r0
	mov r3, r6
	mov r0, #0
	and r3, r0
	lsl r0, r2, #8
	lsr r5, r3, #0x18
	orr r5, r0
	lsr r0, r2, #0x18
	str r0, [sp, #0x34]
	mov r0, r1
	mov r2, #0xff
	and r0, r2
	mov r3, r6
	mov r2, #0
	and r3, r2
	lsl r2, r0, #0x18
	lsr r4, r3, #8
	orr r4, r2
	lsr r0, r0, #8
	str r0, [sp, #0x38]
	mov r3, r1
	mov r0, #0
	and r3, r0
	mov r0, r6
	ldr r2, _02157A84 // =0xFF000000
	and r0, r2
	lsr r2, r0, #0x18
	lsl r3, r3, #8
	orr r3, r2
	lsl r0, r0, #8
	str r0, [sp, #0x4c]
	mov r0, #0
	and r1, r0
	mov r0, r6
	ldr r2, _02157A88 // =0x00FF0000
	and r0, r2
	lsr r2, r0, #8
	str r2, [sp, #0x44]
	lsl r2, r1, #0x18
	ldr r1, [sp, #0x44]
	orr r2, r1
	lsl r7, r0, #0x18
	mov r1, r6
	str r1, [sp, #0x40]
	mov r0, #0xff
	and r1, r0
	str r1, [sp, #0x40]
	lsl r0, r1, #0x18
	str r0, [sp, #0x3c]
	ldr r0, _02157A8C // =0x0000FF00
	and r6, r0
	lsl r1, r6, #8
	ldr r0, [sp, #0x3c]
	orr r0, r1
	str r0, [sp, #0x3c]
	mov r0, #0
	lsl r1, r0, #0
	orr r0, r1
	ldr r1, [sp, #0x3c]
	orr r2, r1
	orr r7, r0
	orr r3, r2
	ldr r0, [sp, #0x4c]
	orr r0, r7
	str r0, [sp, #0x4c]
	ldr r0, [sp, #0x38]
	orr r0, r3
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x4c]
	orr r4, r0
	ldr r1, [sp, #0x34]
	ldr r0, [sp, #0x38]
	orr r1, r0
	str r1, [sp, #0x34]
	orr r5, r4
	mov r1, #0
	ldr r0, [sp, #0x34]
	orr r1, r0
	ldr r0, [sp, #0x48]
	orr r0, r5
	str r0, [sp, #0x48]
	mov r2, #0
	orr r2, r1
	ldr r1, [sp, #0x30]
	orr r1, r0
	str r1, [sp, #0x30]
	str r1, [sp, #0x50]
	str r2, [sp, #0x54]
	add r0, sp, #0x60
	add r1, sp, #0x50
	lsl r2, r0, #0
	bl ovl08_2157850
	ldr r0, [sp, #0xc]
	sub r0, r0, #1
	lsl r1, r0, #3
	ldr r0, [sp]
	add r4, r0, r1
	mov r3, r4
	add r2, sp, #0x68
	mov r1, #8
_02157A20:
	ldrb r0, [r3]
	add r3, r3, #1
	strb r0, [r2]
	add r2, r2, #1
	sub r1, r1, #1
	cmp r1, #0
	bne _02157A20
	add r0, sp, #0x70
	ldr r1, [sp, #0x18]
	add r2, sp, #0x60
	lsl r3, r2, #0
	bl ovl08_2156B5C
	add r2, sp, #0x68
	mov r1, #8
_02157A3E:
	ldrb r0, [r2]
	add r2, r2, #1
	strb r0, [r4]
	add r4, r4, #1
	sub r1, r1, #1
	cmp r1, #0
	bne _02157A3E
	ldr r0, [sp, #0xc]
	sub r0, r0, #1
	str r0, [sp, #0xc]
	cmp r0, #0
	ble _02157A58
	b _02157930
_02157A58:
	ldr r0, [sp, #0x10]
	sub r0, r0, #1
	str r0, [sp, #0x10]
	cmp r0, #0
	blt _02157A64
	b _02157918
_02157A64:
	add r0, sp, #0x58
	add r1, sp, #0x60
	mov r2, #8
	blx memcmp
	cmp r0, #0
	beq _02157A76
	mov r0, #0
	str r0, [sp, #0x1c]
_02157A76:
	ldr r0, [sp, #0x1c]
	add sp, #0x1b4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02157A80: .word 0xA6A6A6A6
_02157A84: .word 0xFF000000
_02157A88: .word 0x00FF0000
_02157A8C: .word 0x0000FF00
	thumb_func_end ovl08_215789C

	thumb_func_start ovl08_2157A90
ovl08_2157A90: // 0x02157A90
	push {r4, r5, r6, r7, lr}
	sub sp, #0x1d4
	str r0, [sp]
	mov r5, r1
	mov r4, r2
	ldr r0, _02157C8C // =0xA6A6A6A6
	str r0, [sp, #0x78]
	str r0, [sp, #0x7c]
	mov r0, #7
	mov r1, r4
	and r1, r0
	cmp r1, #0
	bne _02157AB4
	ldr r2, [sp, #0x1e8]
	mov r1, r2
	and r1, r0
	cmp r1, #0
	beq _02157ABE
_02157AB4:
	mov r0, #0
	add sp, #0x1d4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02157ABE:
	lsr r0, r4, #3
	str r0, [sp, #0x14]
	cmp r0, #2
	bge _02157AD0
	mov r0, #0
	add sp, #0x1d4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02157AD0:
	add r0, sp, #0x90
	mov r1, r3
	lsl r2, r2, #3
	bl ovl08_2157568
	str r0, [sp, #0x18]
	ldr r0, [sp]
	add r0, #8
	mov r1, r5
	mov r2, r4
	blx memcpy
	add r3, sp, #0x80
	add r2, sp, #0x78
	mov r1, #8
_02157AEE:
	ldrb r0, [r2]
	add r2, r2, #1
	strb r0, [r3]
	add r3, r3, #1
	sub r1, r1, #1
	cmp r1, #0
	bne _02157AEE
	mov r0, #0
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	asr r0, r0, #0x1f
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x10]
	str r0, [sp, #0x34]
	str r0, [sp, #0x38]
	str r0, [sp, #0x64]
	str r0, [sp, #0x60]
	str r0, [sp, #0x5c]
	str r0, [sp, #0x58]
	str r0, [sp, #0x48]
	str r0, [sp, #0x50]
_02157B18:
	mov r0, #1
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x14]
	cmp r0, #1
	bge _02157B24
	b _02157C5E
_02157B24:
	ldr r1, [sp, #0x20]
	ldr r2, [sp, #0x10]
	asr r3, r2, #0x1f
	blx _ull_mul
	str r0, [sp, #0x24]
	str r1, [sp, #8]
_02157B32:
	ldr r0, [sp, #0xc]
	lsl r1, r0, #3
	ldr r0, [sp]
	add r3, r0, r1
	str r3, [sp, #0x2c]
	add r2, sp, #0x88
	mov r1, #8
_02157B40:
	ldrb r0, [r3]
	add r3, r3, #1
	strb r0, [r2]
	add r2, r2, #1
	sub r1, r1, #1
	cmp r1, #0
	bne _02157B40
	add r0, sp, #0x90
	ldr r1, [sp, #0x18]
	add r2, sp, #0x80
	lsl r3, r2, #0
	bl ovl08_2156F84
	ldr r0, [sp, #0xc]
	asr r1, r0, #0x1f
	lsl r2, r0, #0
	ldr r0, [sp, #0x24]
	add r6, r2, r0
	ldr r0, [sp, #8]
	adc r1, r0
	mov r2, r1
	ldr r0, _02157C90 // =0xFF000000
	and r2, r0
	lsr r0, r2, #0x18
	str r0, [sp, #0x30]
	mov r2, r1
	ldr r0, _02157C94 // =0x00FF0000
	and r2, r0
	lsr r0, r2, #8
	str r0, [sp, #0x68]
	mov r2, r1
	ldr r0, _02157C98 // =0x0000FF00
	and r2, r0
	mov r3, r6
	ldr r0, [sp, #0x64]
	and r3, r0
	lsl r0, r2, #8
	lsr r5, r3, #0x18
	orr r5, r0
	lsr r0, r2, #0x18
	str r0, [sp, #0x3c]
	mov r0, r1
	mov r2, #0xff
	and r0, r2
	mov r3, r6
	ldr r2, [sp, #0x60]
	and r3, r2
	lsl r2, r0, #0x18
	lsr r4, r3, #8
	orr r4, r2
	lsr r0, r0, #8
	str r0, [sp, #0x40]
	mov r3, r1
	ldr r0, [sp, #0x5c]
	and r3, r0
	mov r0, r6
	ldr r2, _02157C90 // =0xFF000000
	and r0, r2
	lsr r2, r0, #0x18
	lsl r3, r3, #8
	orr r3, r2
	lsl r0, r0, #8
	str r0, [sp, #0x6c]
	ldr r0, [sp, #0x58]
	and r1, r0
	mov r0, r6
	ldr r2, _02157C94 // =0x00FF0000
	and r0, r2
	lsr r2, r0, #8
	str r2, [sp, #0x54]
	lsl r2, r1, #0x18
	ldr r1, [sp, #0x54]
	orr r2, r1
	lsl r7, r0, #0x18
	mov r1, r6
	str r1, [sp, #0x4c]
	mov r0, #0xff
	and r1, r0
	str r1, [sp, #0x4c]
	lsl r0, r1, #0x18
	str r0, [sp, #0x44]
	ldr r0, _02157C98 // =0x0000FF00
	and r6, r0
	lsl r1, r6, #8
	ldr r0, [sp, #0x44]
	orr r0, r1
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x48]
	ldr r1, [sp, #0x50]
	orr r0, r1
	ldr r1, [sp, #0x44]
	orr r2, r1
	orr r7, r0
	orr r3, r2
	ldr r0, [sp, #0x6c]
	orr r0, r7
	str r0, [sp, #0x6c]
	ldr r0, [sp, #0x40]
	orr r0, r3
	str r0, [sp, #0x40]
	ldr r0, [sp, #0x6c]
	orr r4, r0
	ldr r1, [sp, #0x3c]
	ldr r0, [sp, #0x40]
	orr r1, r0
	str r1, [sp, #0x3c]
	orr r5, r4
	ldr r1, [sp, #0x38]
	ldr r0, [sp, #0x3c]
	orr r1, r0
	ldr r0, [sp, #0x68]
	orr r0, r5
	str r0, [sp, #0x68]
	ldr r2, [sp, #0x34]
	orr r2, r1
	ldr r1, [sp, #0x30]
	orr r1, r0
	str r1, [sp, #0x30]
	str r1, [sp, #0x70]
	str r2, [sp, #0x74]
	add r0, sp, #0x80
	add r1, sp, #0x70
	lsl r2, r0, #0
	bl ovl08_2157850
	add r3, sp, #0x88
	mov r2, #8
_02157C3E:
	ldrb r1, [r3]
	add r3, r3, #1
	ldr r0, [sp, #0x2c]
	strb r1, [r0]
	add r0, r0, #1
	str r0, [sp, #0x2c]
	sub r2, r2, #1
	cmp r2, #0
	bne _02157C3E
	ldr r0, [sp, #0xc]
	add r1, r0, #1
	str r1, [sp, #0xc]
	ldr r0, [sp, #0x14]
	cmp r1, r0
	bgt _02157C5E
	b _02157B32
_02157C5E:
	ldr r0, [sp, #0x10]
	add r0, r0, #1
	str r0, [sp, #0x10]
	cmp r0, #6
	bge _02157C6A
	b _02157B18
_02157C6A:
	add r3, sp, #0x80
	mov r2, #8
_02157C6E:
	ldrb r1, [r3]
	add r3, r3, #1
	ldr r0, [sp]
	strb r1, [r0]
	add r0, r0, #1
	str r0, [sp]
	sub r2, r2, #1
	cmp r2, #0
	bne _02157C6E
	mov r0, #1
	add sp, #0x1d4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_02157C8C: .word 0xA6A6A6A6
_02157C90: .word 0xFF000000
_02157C94: .word 0x00FF0000
_02157C98: .word 0x0000FF00
	thumb_func_end ovl08_2157A90

	thumb_func_start ovl08_2157C9C
ovl08_2157C9C: // 0x02157C9C
	push {r4, lr}
	bl ovl08_2157CDC
	mov r4, r0
	ldr r0, _02157CD0 // =0x0217D2E8
	str r4, [r0]
	bl ovl08_2158FBC
	cmp r4, #1
	bne _02157CB8
	mov r1, #6
	ldr r0, _02157CD4 // =0x0217D2A8
	str r1, [r0]
	b _02157CBE
_02157CB8:
	mov r1, #7
	ldr r0, _02157CD4 // =0x0217D2A8
	str r1, [r0]
_02157CBE:
	mov r0, #0
	mvn r1, r0
	ldr r0, _02157CD8 // =0x0217B0F8
	str r1, [r0]
	bl ovl08_2155DFC
	pop {r4}
	pop {r3}
	bx r3
	.align 2, 0
_02157CD0: .word 0x0217D2E8
_02157CD4: .word 0x0217D2A8
_02157CD8: .word 0x0217B0F8
	thumb_func_end ovl08_2157C9C

	thumb_func_start ovl08_2157CDC
ovl08_2157CDC: // 0x02157CDC
	push {r4, r5, r6, r7, lr}
	sub sp, #0x64
	mov r4, #0
	mov r0, #4
	mvn r0, r0
	str r0, [sp, #4]
	str r4, [sp, #0x40]
	str r4, [sp, #8]
	str r4, [sp, #0xc]
	ldr r6, _02158064 // =0x0217D28C
	mov r0, #1
	str r0, [r6]
	str r4, [sp, #0x10]
	str r4, [sp, #0x18]
	str r4, [sp, #0x2c]
	str r4, [sp, #0x34]
	mvn r0, r0
	str r0, [sp, #0x14]
	str r4, [sp, #0x38]
	str r4, [sp, #0x24]
	mvn r0, r4
	str r0, [sp, #0x28]
	mov r0, #3
	mvn r0, r0
	str r0, [sp, #0x20]
	mov r0, #2
	mvn r0, r0
	str r0, [sp, #0x1c]
	str r4, [sp, #0x3c]
	b _021580C0
_02157D18:
	ldr r0, _02158068 // =0x000001F4
	blx OS_Sleep
	ldr r0, [r6]
	cmp r0, #0xa
	bls _02157D26
	b _021580C0
_02157D26:
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #8]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add r0, pc
	bx r0
_02157D34: // jump table
	.hword _021580C0 - _02157D34 + 1 // case 0
	.hword _02157D4A - _02157D34 + 1 // case 1
	.hword _02157D6A - _02157D34 + 1 // case 2
	.hword _02157D80 - _02157D34 + 1 // case 3
	.hword _02157DD0 - _02157D34 + 1 // case 4
	.hword _02157E3A - _02157D34 + 1 // case 5
	.hword _02157E5C - _02157D34 + 1 // case 6
	.hword _02157F04 - _02157D34 + 1 // case 7
	.hword _02157F62 - _02157D34 + 1 // case 8
	.hword _02157FE4 - _02157D34 + 1 // case 9
	.hword _0215803E - _02157D34 + 1 // case 10
_02157D4A:
	bl ovl08_2158AFC
	str r0, [sp, #4]
	cmp r0, #1
	beq _02157D5A
	mov r0, #1
	str r0, [sp, #0xc]
	b _021580C0
_02157D5A:
	mov r1, #3
	ldr r0, _0215806C // =0x0217D2A8
	str r1, [r0]
	bl ovl08_2155DFC
	mov r0, #2
	str r0, [r6]
	b _021580C0
_02157D6A:
	bl ovl08_2159024
	str r0, [sp, #4]
	cmp r0, #1
	beq _02157D7A
	mov r0, #1
	str r0, [sp, #0xc]
	b _021580C0
_02157D7A:
	mov r0, #3
	str r0, [r6]
	b _021580C0
_02157D80:
	mov r0, #2
	lsl r1, r0, #0
	ldr r2, [sp, #0x10]
	blx SOC_Socket
	mov r4, r0
	cmp r4, #0
	bge _02157D9A
	ldr r0, [sp, #0x14]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #0xc]
	b _021580C0
_02157D9A:
	ldr r2, [sp, #0x18]
	add r1, sp, #0x44
	str r2, [r1]
	str r2, [r1, #4]
	mov r2, #8
	add r1, sp, #0x44
	strb r2, [r1]
	mov r2, #2
	strb r2, [r1, #1]
	ldr r2, _02158070 // =0x000001E6
	strh r2, [r1, #2]
	ldr r1, [sp, #0x18]
	str r1, [sp, #0x48]
	add r1, sp, #0x44
	blx SOC_Bind
	str r0, [sp, #4]
	cmp r0, #0
	bge _02157DCA
	ldr r0, [sp, #0x14]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #0xc]
	b _021580C0
_02157DCA:
	mov r0, #4
	str r0, [r6]
	b _021580C0
_02157DD0:
	bl ovl08_2156114
	ldr r1, _02158074 // =0x0217B0F8
	ldr r1, [r1]
	cmp r0, r1
	blo _02157DEC
	mov r0, r4
	blx SOC_Close
	ldr r0, [sp, #0x1c]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #0xc]
	b _021580C0
_02157DEC:
	mov r1, #8
	add r0, sp, #0x44
	strb r1, [r0, #8]
	ldr r0, _02158078 // =0x0217D31C
	add r1, sp, #0x4c
	bl ovl08_2158528
	add r0, sp, #0x4c
	str r0, [sp]
	mov r0, r4
	ldr r1, _0215807C // =0x0217DFA4
	ldr r2, _02158080 // =0x00000800
	mov r3, #4
	blx sub_20BE9D8
	cmp r0, #0
	bgt _02157E10
	b _021580C0
_02157E10:
	ldr r0, _0215807C // =0x0217DFA4
	ldr r1, _02158084 // =0x0217D2C0
	bl ovl08_2158758
	cmp r0, #0
	bne _02157E1E
	b _021580C0
_02157E1E:
	bl ovl08_2156114
	ldr r1, _02158088 // =0x00007530
	add r1, r0, r1
	ldr r0, _02158074 // =0x0217B0F8
	str r1, [r0]
	mov r0, #5
	str r0, [r6]
	mov r1, #4
	ldr r0, _0215806C // =0x0217D2A8
	str r1, [r0]
	bl ovl08_2155DFC
	b _021580C0
_02157E3A:
	ldr r0, _0215807C // =0x0217DFA4
	bl ovl08_2158654
	mov r3, r0
	ldr r0, _0215808C // =0x0217D284
	str r3, [r0]
	mov r0, r4
	add r1, sp, #0x4c
	ldr r2, _0215807C // =0x0217DFA4
	bl ovl08_2158A8C
	bl ovl08_2156114
	str r0, [sp, #0x40]
	mov r0, #6
	str r0, [r6]
	b _021580C0
_02157E5C:
	bl ovl08_2156114
	ldr r1, _02158074 // =0x0217B0F8
	ldr r1, [r1]
	cmp r0, r1
	blo _02157E78
	mov r0, r4
	blx SOC_Close
	ldr r0, [sp, #0x20]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #0xc]
	b _021580C0
_02157E78:
	add r0, sp, #0x4c
	str r0, [sp]
	mov r0, r4
	ldr r1, _0215807C // =0x0217DFA4
	ldr r2, _02158080 // =0x00000800
	mov r3, #4
	blx sub_20BE9D8
	cmp r0, #0
	ble _02157EEE
	ldr r0, _0215807C // =0x0217DFA4
	mov r1, #3
	ldr r2, _02158090 // =0x0217D7A4
	ldr r3, _02158078 // =0x0217D31C
	bl ovl08_21586F8
	cmp r0, #0
	beq _02157EEE
	ldr r0, _02158090 // =0x0217D7A4
	add r1, sp, #0x54
	add r2, sp, #0x58
	bl ovl08_2158990
	mov r5, r0
	ldr r1, [sp, #0x54]
	ldr r0, _02158094 // =0x00000101
	cmp r1, r0
	beq _02157EB2
	b _021580C0
_02157EB2:
	bl ovl08_2156114
	str r0, [sp, #0x5c]
	ldr r2, _02158098 // =0x0217D344
	mov r1, #8
_02157EBC:
	ldrb r0, [r5]
	add r5, r5, #1
	strb r0, [r2]
	add r2, r2, #1
	sub r1, r1, #1
	cmp r1, #0
	bne _02157EBC
	ldr r0, _0215809C // =0x0217D34C
	add r1, sp, #0x5c
	mov r2, #4
	bl ovl08_2156138
	ldr r0, [sp, #0x24]
	str r0, [sp, #8]
	mov r0, #7
	str r0, [r6]
	mov r1, #5
	ldr r0, _0215806C // =0x0217D2A8
	str r1, [r0]
	ldr r1, [sp, #0x28]
	ldr r0, _02158074 // =0x0217B0F8
	str r1, [r0]
	bl ovl08_2155DFC
	b _021580C0
_02157EEE:
	bl ovl08_2156114
	ldr r2, _021580A0 // =0x000003E8
	ldr r1, [sp, #0x40]
	add r1, r1, r2
	cmp r0, r1
	bhs _02157EFE
	b _021580C0
_02157EFE:
	mov r0, #5
	str r0, [r6]
	b _021580C0
_02157F04:
	ldr r0, _02158090 // =0x0217D7A4
	ldr r1, _021580A4 // =0x00000102
	ldr r2, _0215809C // =0x0217D34C
	mov r3, #8
	bl ovl08_2158838
	ldr r1, _021580A8 // =0x0217D2A4
	str r0, [r1]
	ldr r0, _02158078 // =0x0217D31C
	str r0, [sp]
	ldr r0, _0215807C // =0x0217DFA4
	mov r1, #4
	ldr r2, _02158090 // =0x0217D7A4
	ldr r3, _021580A8 // =0x0217D2A4
	ldr r3, [r3]
	bl ovl08_21588CC
	mov r3, r0
	ldr r0, _0215808C // =0x0217D284
	str r3, [r0]
	mov r0, r4
	add r1, sp, #0x4c
	ldr r2, _0215807C // =0x0217DFA4
	bl ovl08_2158A8C
	bl ovl08_2156114
	str r0, [sp, #0x40]
	ldr r7, _021580AC // =0x0217D550
	ldr r0, [sp, #0x2c]
	lsl r1, r0, #0
	lsl r2, r0, #0
	lsl r3, r0, #0
	mov r5, #0x12
	str r5, [sp, #0x30]
_02157F4A:
	stmia r7!, {r0, r1, r2, r3}
	stmia r7!, {r0, r1, r2, r3}
	ldr r5, [sp, #0x30]
	sub r5, r5, #1
	str r5, [sp, #0x30]
	cmp r5, #0
	bne _02157F4A
	stmia r7!, {r0, r1, r2, r3}
	str r0, [r7]
	mov r0, #8
	str r0, [r6]
	b _021580C0
_02157F62:
	add r0, sp, #0x4c
	str r0, [sp]
	mov r0, r4
	ldr r1, _0215807C // =0x0217DFA4
	ldr r2, _02158080 // =0x00000800
	mov r3, #4
	blx sub_20BE9D8
	cmp r0, #0
	ble _02157FB6
	ldr r0, _0215807C // =0x0217DFA4
	mov r1, #5
	ldr r2, _02158090 // =0x0217D7A4
	ldr r3, _02158098 // =0x0217D344
	bl ovl08_21586F8
	ldr r1, _021580A8 // =0x0217D2A4
	str r0, [r1]
	cmp r0, #0
	beq _02157FB6
	ldr r0, _02158090 // =0x0217D7A4
	bl ovl08_215835C
	cmp r0, #0
	beq _02157FB6
	ldr r1, _021580B0 // =0x0217D650
	ldr r0, [sp, #0x3c]
	ldrsb r0, [r1, r0]
	cmp r0, #0
	beq _02157FA6
	mov r1, #1
	ldr r0, _021580B4 // =0x0217D270
	strb r1, [r0]
	b _02157FAC
_02157FA6:
	ldr r1, [sp, #0x34]
	ldr r0, _021580B4 // =0x0217D270
	strb r1, [r0]
_02157FAC:
	ldr r0, [sp, #0x38]
	str r0, [sp, #8]
	mov r0, #9
	str r0, [r6]
	b _021580C0
_02157FB6:
	bl ovl08_2156114
	ldr r2, _021580A0 // =0x000003E8
	ldr r1, [sp, #0x40]
	add r1, r1, r2
	cmp r0, r1
	blo _021580C0
	ldr r0, [sp, #8]
	add r0, r0, #1
	str r0, [sp, #8]
	cmp r0, #0xa
	blt _02157FDE
	mov r0, r4
	blx SOC_Close
	ldr r0, [sp, #0x14]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #0xc]
	b _021580C0
_02157FDE:
	mov r0, #7
	str r0, [r6]
	b _021580C0
_02157FE4:
	ldr r0, _02158090 // =0x0217D7A4
	ldr r1, _021580B8 // =0x00000301
	ldr r2, _021580B4 // =0x0217D270
	mov r3, #1
	bl ovl08_2158838
	ldr r1, _021580A8 // =0x0217D2A4
	str r0, [r1]
	ldr r0, _02158098 // =0x0217D344
	str r0, [sp]
	ldr r0, _0215807C // =0x0217DFA4
	mov r1, #6
	ldr r2, _02158090 // =0x0217D7A4
	ldr r3, _021580A8 // =0x0217D2A4
	ldr r3, [r3]
	bl ovl08_21588CC
	ldr r1, _0215808C // =0x0217D284
	str r0, [r1]
	bl ovl08_21593C4
	cmp r0, #7
	beq _02158024
	bl ovl08_2156114
	ldr r1, _021580A0 // =0x000003E8
	add r0, r0, r1
	str r0, [sp, #0x40]
	mov r0, #0xa
	str r0, [sp, #8]
	str r0, [r6]
	b _021580C0
_02158024:
	mov r0, r4
	add r1, sp, #0x4c
	ldr r2, _0215807C // =0x0217DFA4
	ldr r3, _0215808C // =0x0217D284
	ldr r3, [r3]
	bl ovl08_2158A8C
	bl ovl08_2156114
	str r0, [sp, #0x40]
	mov r0, #0xa
	str r0, [r6]
	b _021580C0
_0215803E:
	bl ovl08_2156114
	ldr r2, _021580A0 // =0x000003E8
	ldr r1, [sp, #0x40]
	add r1, r1, r2
	cmp r0, r1
	blo _021580C0
	ldr r0, [sp, #8]
	add r0, r0, #1
	str r0, [sp, #8]
	cmp r0, #0xa
	blt _021580BC
	mov r0, #1
	str r0, [sp, #0xc]
	bl ovl08_21580F8
	str r0, [sp, #4]
	b _021580C0
	nop
_02158064: .word 0x0217D28C
_02158068: .word 0x000001F4
_0215806C: .word 0x0217D2A8
_02158070: .word 0x000001E6
_02158074: .word 0x0217B0F8
_02158078: .word 0x0217D31C
_0215807C: .word 0x0217DFA4
_02158080: .word 0x00000800
_02158084: .word 0x0217D2C0
_02158088: .word 0x00007530
_0215808C: .word 0x0217D284
_02158090: .word 0x0217D7A4
_02158094: .word 0x00000101
_02158098: .word 0x0217D344
_0215809C: .word 0x0217D34C
_021580A0: .word 0x000003E8
_021580A4: .word 0x00000102
_021580A8: .word 0x0217D2A4
_021580AC: .word 0x0217D550
_021580B0: .word 0x0217D650
_021580B4: .word 0x0217D270
_021580B8: .word 0x00000301
_021580BC:
	mov r0, #9
	str r0, [r6]
_021580C0:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	bne _021580D0
	ldr r0, _021580F4 // =0x0217D280
	ldr r0, [r0]
	cmp r0, #0
	bne _021580D0
	b _02157D18
_021580D0:
	cmp r4, #0
	beq _021580DA
	mov r0, r4
	blx SOC_Close
_021580DA:
	ldr r0, _021580F4 // =0x0217D280
	ldr r0, [r0]
	cmp r0, #0
	beq _021580E8
	mov r0, #7
	mvn r0, r0
	str r0, [sp, #4]
_021580E8:
	ldr r0, [sp, #4]
	add sp, #0x64
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_021580F4: .word 0x0217D280
	thumb_func_end ovl08_2157CDC

	thumb_func_start ovl08_21580F8
ovl08_21580F8: // 0x021580F8
	push {r4, r5, r6, r7, lr}
	sub sp, #0x34
	mov r0, #1
	str r0, [sp]
	ldr r0, _02158274 // =0x0217D468
	ldr r1, _02158278 // =0x0217D650
	blx strcpy
	ldr r1, _02158278 // =0x0217D650
	ldr r0, [r1, #0x2c]
	cmp r0, #3
	bls _02158112
	b _02158264
_02158112:
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #8]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add r0, pc
	bx r0
_02158120: // jump table
	.hword _02158128 - _02158120 + 1 // case 0
	.hword _02158130 - _02158120 + 1 // case 1
	.hword _02158234 - _02158120 + 1 // case 2
	.hword _0215824C - _02158120 + 1 // case 3
_02158128:
	mov r1, #0
	ldr r0, _02158274 // =0x0217D468
	str r1, [r0, #0x20]
	b _0215826A
_02158130:
	ldr r0, [r1, #0x30]
	cmp r0, #0
	bne _0215813E
	mov r0, #6
	mvn r0, r0
	str r0, [sp]
	b _0215826A
_0215813E:
	ldr r6, _02158274 // =0x0217D468
	str r0, [r6, #0x24]
	mov r0, #0
	str r0, [sp, #4]
	add r5, sp, #0x10
	ldr r7, _0215827C // =0x0217D6B4
	ldr r4, _02158280 // =0x0217D490
	mov r0, #6
	mvn r0, r0
	str r0, [sp, #0xc]
	ldr r0, [sp, #4]
	str r0, [sp, #8]
_02158156:
	mov r0, r5
	mov r1, r7
	mov r2, #0x20
	blx memcpy
	ldr r1, [sp, #8]
	add r0, sp, #0x30
	strb r1, [r0]
	mov r0, r5
	blx strlen
	cmp r0, #0x10
	bhi _02158192
	cmp r0, #0xa
	blo _02158182
	cmp r0, #0xa
	beq _021581BC
	cmp r0, #0xd
	beq _021581CC
	cmp r0, #0x10
	beq _021581F6
	b _02158220
_02158182:
	cmp r0, #0
	bhi _0215818C
	cmp r0, #0
	beq _02158224
	b _02158220
_0215818C:
	cmp r0, #5
	beq _021581A2
	b _02158220
_02158192:
	cmp r0, #0x1a
	bhi _0215819C
	cmp r0, #0x1a
	beq _021581E6
	b _02158220
_0215819C:
	cmp r0, #0x20
	beq _02158210
	b _02158220
_021581A2:
	mov r0, #1
	str r0, [r6, #0x20]
	ldrb r0, [r5]
	strb r0, [r4]
	ldrb r0, [r5, #1]
	strb r0, [r4, #1]
	ldrb r0, [r5, #2]
	strb r0, [r4, #2]
	ldrb r0, [r5, #3]
	strb r0, [r4, #3]
	ldrb r0, [r5, #4]
	strb r0, [r4, #4]
	b _02158224
_021581BC:
	mov r0, #1
	str r0, [r6, #0x20]
	mov r0, r4
	mov r1, r5
	mov r2, #0xa
	bl ovl08_215828C
	b _02158224
_021581CC:
	mov r0, #2
	str r0, [r6, #0x20]
	mov r3, r5
	mov r2, r4
	mov r1, #0xd
_021581D6:
	ldrb r0, [r3]
	add r3, r3, #1
	strb r0, [r2]
	add r2, r2, #1
	sub r1, r1, #1
	cmp r1, #0
	bne _021581D6
	b _02158224
_021581E6:
	mov r0, #2
	str r0, [r6, #0x20]
	mov r0, r4
	mov r1, r5
	mov r2, #0x1a
	bl ovl08_215828C
	b _02158224
_021581F6:
	mov r0, #3
	str r0, [r6, #0x20]
	mov r3, r5
	mov r2, r4
	mov r1, #0x10
_02158200:
	ldrb r0, [r3]
	add r3, r3, #1
	strb r0, [r2]
	add r2, r2, #1
	sub r1, r1, #1
	cmp r1, #0
	bne _02158200
	b _02158224
_02158210:
	mov r0, #3
	str r0, [r6, #0x20]
	mov r0, r4
	mov r1, r5
	mov r2, #0x20
	bl ovl08_215828C
	b _02158224
_02158220:
	ldr r0, [sp, #0xc]
	str r0, [sp]
_02158224:
	add r7, #0x28
	add r4, #0x20
	ldr r0, [sp, #4]
	add r0, r0, #1
	str r0, [sp, #4]
	cmp r0, #4
	blt _02158156
	b _0215826A
_02158234:
	mov r1, #4
	ldr r0, _02158274 // =0x0217D468
	str r1, [r0, #0x20]
	ldr r4, _02158284 // =0x0217D510
	ldr r3, _02158288 // =0x0217D74C
	mov r2, #8
_02158240:
	ldmia r3!, {r0, r1}
	stmia r4!, {r0, r1}
	sub r2, r2, #1
	cmp r2, #0
	bne _02158240
	b _0215826A
_0215824C:
	mov r1, #5
	ldr r0, _02158274 // =0x0217D468
	str r1, [r0, #0x20]
	ldr r4, _02158284 // =0x0217D510
	ldr r3, _02158288 // =0x0217D74C
	mov r2, #8
_02158258:
	ldmia r3!, {r0, r1}
	stmia r4!, {r0, r1}
	sub r2, r2, #1
	cmp r2, #0
	bne _02158258
	b _0215826A
_02158264:
	mov r0, #6
	mvn r0, r0
	str r0, [sp]
_0215826A:
	ldr r0, [sp]
	add sp, #0x34
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02158274: .word 0x0217D468
_02158278: .word 0x0217D650
_0215827C: .word 0x0217D6B4
_02158280: .word 0x0217D490
_02158284: .word 0x0217D510
_02158288: .word 0x0217D74C
	thumb_func_end ovl08_21580F8

	thumb_func_start ovl08_215828C
ovl08_215828C: // 0x0215828C
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r6, r0
	mov r7, r1
	str r2, [sp]
	mov r4, #0
	mov r5, r4
	lsl r0, r2, #0
	cmp r0, #0
	ble _02158352
	str r4, [sp, #4]
_021582A2:
	ldrsb r0, [r7, r5]
	cmp r0, #0x63
	bgt _021582FE
	cmp r0, #0x63
	bge _02158318
	cmp r0, #0x61
	bgt _021582F8
	cmp r0, #0x61
	bge _02158318
	mov r1, r0
	sub r1, #0x30
	cmp r1, #0x16
	bhi _02158324
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #8]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add r1, pc
	bx r1
_021582CA: // jump table
	.hword _02158312 - _021582CA + 1 // case 0
	.hword _02158312 - _021582CA + 1 // case 1
	.hword _02158312 - _021582CA + 1 // case 2
	.hword _02158312 - _021582CA + 1 // case 3
	.hword _02158312 - _021582CA + 1 // case 4
	.hword _02158312 - _021582CA + 1 // case 5
	.hword _02158312 - _021582CA + 1 // case 6
	.hword _02158312 - _021582CA + 1 // case 7
	.hword _02158312 - _021582CA + 1 // case 8
	.hword _02158312 - _021582CA + 1 // case 9
	.hword _02158324 - _021582CA + 1 // case 10
	.hword _02158324 - _021582CA + 1 // case 11
	.hword _02158324 - _021582CA + 1 // case 12
	.hword _02158324 - _021582CA + 1 // case 13
	.hword _02158324 - _021582CA + 1 // case 14
	.hword _02158324 - _021582CA + 1 // case 15
	.hword _02158324 - _021582CA + 1 // case 16
	.hword _0215831E - _021582CA + 1 // case 17
	.hword _0215831E - _021582CA + 1 // case 18
	.hword _0215831E - _021582CA + 1 // case 19
	.hword _0215831E - _021582CA + 1 // case 20
	.hword _0215831E - _021582CA + 1 // case 21
	.hword _0215831E - _021582CA + 1 // case 22
_021582F8:
	cmp r0, #0x62
	beq _02158318
	b _02158324
_021582FE:
	cmp r0, #0x65
	bgt _0215830C
	cmp r0, #0x65
	bge _02158318
	cmp r0, #0x64
	beq _02158318
	b _02158324
_0215830C:
	cmp r0, #0x66
	beq _02158318
	b _02158324
_02158312:
	sub r0, #0x30
	add r4, r4, r0
	b _0215832E
_02158318:
	sub r0, #0x57
	add r4, r4, r0
	b _0215832E
_0215831E:
	sub r0, #0x37
	add r4, r4, r0
	b _0215832E
_02158324:
	mov r0, #0
	add sp, #0xc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215832E:
	mov r0, r5
	mov r1, #2
	blx _s32_div_f
	cmp r1, #0
	bne _0215833E
	lsl r4, r4, #4
	b _0215834A
_0215833E:
	mov r0, r5
	mov r1, #2
	blx _s32_div_f
	strb r4, [r6, r0]
	ldr r4, [sp, #4]
_0215834A:
	add r5, r5, #1
	ldr r0, [sp]
	cmp r5, r0
	blt _021582A2
_02158352:
	mov r0, #1
	add sp, #0xc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	thumb_func_end ovl08_215828C

	thumb_func_start ovl08_215835C
ovl08_215835C: // 0x0215835C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r1, r0
	add r1, #8
	str r1, [sp, #8]
	mov r2, #0
	str r2, [sp, #4]
	ldrh r2, [r0]
	asr r3, r2, #8
	mov r0, #0xff
	and r3, r0
	lsl r2, r2, #8
	ldr r0, _02158504 // =0x0000FF00
	and r2, r0
	orr r3, r2
	lsl r0, r3, #0x10
	lsr r0, r0, #0x10
	add r0, r1, r0
	str r0, [sp]
	add r0, sp, #8
	ldr r1, [sp]
	add r2, sp, #0xc
	add r3, sp, #0x10
	bl ovl08_21589C8
	mov r5, r0
	cmp r5, #0
	bne _02158396
	b _021584FA
_02158396:
	mov r7, #0
_02158398:
	ldr r0, [sp, #0xc]
	ldr r1, _02158508 // =0x00000201
	sub r1, r0, r1
	cmp r1, #9
	bls _021583A4
	b _021584E6
_021583A4:
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #8]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add r1, pc
	bx r1
_021583B2: // jump table
	.hword _021583C6 - _021583B2 + 1 // case 0
	.hword _021583E4 - _021583B2 + 1 // case 1
	.hword _021583FE - _021583B2 + 1 // case 2
	.hword _02158424 - _021583B2 + 1 // case 3
	.hword _0215844A - _021583B2 + 1 // case 4
	.hword _02158464 - _021583B2 + 1 // case 5
	.hword _02158464 - _021583B2 + 1 // case 6
	.hword _02158464 - _021583B2 + 1 // case 7
	.hword _02158464 - _021583B2 + 1 // case 8
	.hword _021584C4 - _021583B2 + 1 // case 9
_021583C6:
	ldr r2, _0215850C // =0x0217D650
	mov r0, r7
	mov r1, r7
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	ldr r0, _0215850C // =0x0217D650
	mov r1, r5
	ldr r2, [sp, #0x10]
	blx memcpy
	mov r0, #1
	str r0, [sp, #4]
	b _021584E6
_021583E4:
	ldrh r1, [r5]
	asr r2, r1, #8
	mov r0, #0xff
	and r2, r0
	lsl r1, r1, #8
	ldr r0, _02158504 // =0x0000FF00
	and r1, r0
	orr r2, r1
	lsl r0, r2, #0x10
	lsr r1, r0, #0x10
	ldr r0, _0215850C // =0x0217D650
	str r1, [r0, #0x2c]
	b _021584E6
_021583FE:
	ldrh r1, [r5]
	asr r2, r1, #8
	mov r0, #0xff
	and r2, r0
	lsl r1, r1, #8
	ldr r0, _02158504 // =0x0000FF00
	and r1, r0
	orr r2, r1
	lsl r0, r2, #0x10
	lsr r1, r0, #0x10
	mov r3, r7
	ldr r2, _02158510 // =0x0217D550
_02158416:
	ldr r0, _02158514 // =0x0000015C
	str r1, [r2, r0]
	add r2, #0x28
	add r3, r3, #1
	cmp r3, #4
	blt _02158416
	b _021584E6
_02158424:
	ldrh r1, [r5]
	asr r2, r1, #8
	mov r0, #0xff
	and r2, r0
	lsl r1, r1, #8
	ldr r0, _02158504 // =0x0000FF00
	and r1, r0
	orr r2, r1
	lsl r0, r2, #0x10
	lsr r2, r0, #0x10
	mov r1, r7
	ldr r3, _02158510 // =0x0217D550
_0215843C:
	ldr r0, _02158518 // =0x00000160
	str r2, [r3, r0]
	add r3, #0x28
	add r1, r1, #1
	cmp r1, #4
	blt _0215843C
	b _021584E6
_0215844A:
	ldrh r1, [r5]
	asr r2, r1, #8
	mov r0, #0xff
	and r2, r0
	lsl r1, r1, #8
	ldr r0, _02158504 // =0x0000FF00
	and r1, r0
	orr r2, r1
	lsl r0, r2, #0x10
	lsr r1, r0, #0x10
	ldr r0, _0215850C // =0x0217D650
	str r1, [r0, #0x30]
	b _021584E6
_02158464:
	ldr r1, _0215851C // =0x00000206
	sub r1, r0, r1
	mov r0, #0x28
	mul r1, r0
	ldr r0, _02158520 // =0x0217D6B4
	add r0, r0, r1
	mov r1, r7
	mov r2, #0x20
	blx memset
	ldr r0, _0215850C // =0x0217D650
	ldr r0, [r0, #0x5c]
	cmp r0, #1
	bne _021584AC
	ldr r1, [sp, #0xc]
	ldr r0, _0215851C // =0x00000206
	sub r1, r1, r0
	mov r0, #0x28
	mul r1, r0
	ldr r0, _02158520 // =0x0217D6B4
	add r4, r0, r1
	mov r6, r7
	ldr r0, [sp, #0x10]
	cmp r0, #0
	ble _021584E6
_02158496:
	mov r0, r4
	ldrsb r1, [r5, r7]
	add r5, r5, #1
	bl ovl08_2156098
	add r4, r4, r0
	add r6, r6, #1
	ldr r0, [sp, #0x10]
	cmp r6, r0
	blt _02158496
	b _021584E6
_021584AC:
	ldr r1, [sp, #0xc]
	ldr r0, _0215851C // =0x00000206
	sub r1, r1, r0
	mov r0, #0x28
	mul r1, r0
	ldr r0, _02158520 // =0x0217D6B4
	add r0, r0, r1
	mov r1, r5
	ldr r2, [sp, #0x10]
	blx memcpy
	b _021584E6
_021584C4:
	ldr r2, _02158524 // =0x0217D74C
	mov r0, r7
	mov r1, r7
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	ldr r0, _02158524 // =0x0217D74C
	mov r1, r5
	ldr r2, [sp, #0x10]
	blx memcpy
_021584E6:
	add r0, sp, #8
	ldr r1, [sp]
	add r2, sp, #0xc
	add r3, sp, #0x10
	bl ovl08_21589C8
	mov r5, r0
	cmp r5, #0
	beq _021584FA
	b _02158398
_021584FA:
	ldr r0, [sp, #4]
	add sp, #0x14
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02158504: .word 0x0000FF00
_02158508: .word 0x00000201
_0215850C: .word 0x0217D650
_02158510: .word 0x0217D550
_02158514: .word 0x0000015C
_02158518: .word 0x00000160
_0215851C: .word 0x00000206
_02158520: .word 0x0217D6B4
_02158524: .word 0x0217D74C
	thumb_func_end ovl08_215835C

	thumb_func_start ovl08_2158528
ovl08_2158528: // 0x02158528
	push {r4, lr}
	sub sp, #0x50
	mov r4, r0
	mov r2, r4
	add r2, #0xc
	ldr r1, _02158634 // =0x0217B1B4
	ldrb r0, [r1]
	strb r0, [r4, #0xc]
	ldrb r0, [r1, #1]
	strb r0, [r2, #1]
	ldrb r0, [r1, #2]
	strb r0, [r2, #2]
	ldrb r0, [r1, #3]
	strb r0, [r2, #3]
	add r1, sp, #0
	ldr r0, _02158638 // =0x0217D2FC
	ldrb r2, [r0]
	strb r2, [r1]
	ldrb r2, [r0, #1]
	strb r2, [r1, #1]
	ldrb r2, [r0, #2]
	strb r2, [r1, #2]
	ldrb r2, [r0, #3]
	strb r2, [r1, #3]
	ldrb r2, [r0, #4]
	strb r2, [r1, #4]
	ldrb r0, [r0, #5]
	strb r0, [r1, #5]
	add r1, sp, #0
	ldrb r2, [r1]
	mov r0, #0xfd
	and r2, r0
	strb r2, [r1]
	add r0, sp, #4
	add r0, #2
	bl ovl08_2158644
	ldr r0, _0215863C // =0x0217D2F4
	add r1, sp, #4
	add r1, #2
	ldrb r2, [r1]
	strb r2, [r0]
	ldrb r2, [r1, #1]
	strb r2, [r0, #1]
	ldrb r2, [r1, #2]
	strb r2, [r0, #2]
	ldrb r2, [r1, #3]
	strb r2, [r0, #3]
	ldrb r2, [r1, #4]
	strb r2, [r0, #4]
	ldrb r2, [r1, #5]
	strb r2, [r0, #5]
	add r0, sp, #0
	mov r2, #6
	blx memcmp
	cmp r0, #0
	bgt _021585D6
	add r1, sp, #4
	add r1, #2
	ldrb r0, [r1]
	strb r0, [r4]
	ldrb r0, [r1, #1]
	strb r0, [r4, #1]
	ldrb r0, [r1, #2]
	strb r0, [r4, #2]
	ldrb r0, [r1, #3]
	strb r0, [r4, #3]
	ldrb r0, [r1, #4]
	strb r0, [r4, #4]
	ldrb r0, [r1, #5]
	strb r0, [r4, #5]
	add r1, r4, #6
	add r0, sp, #0
	ldrb r2, [r0]
	strb r2, [r4, #6]
	ldrb r2, [r0, #1]
	strb r2, [r1, #1]
	ldrb r2, [r0, #2]
	strb r2, [r1, #2]
	ldrb r2, [r0, #3]
	strb r2, [r1, #3]
	ldrb r2, [r0, #4]
	strb r2, [r1, #4]
	ldrb r0, [r0, #5]
	strb r0, [r1, #5]
	b _0215860E
_021585D6:
	add r1, sp, #0
	ldrb r0, [r1]
	strb r0, [r4]
	ldrb r0, [r1, #1]
	strb r0, [r4, #1]
	ldrb r0, [r1, #2]
	strb r0, [r4, #2]
	ldrb r0, [r1, #3]
	strb r0, [r4, #3]
	ldrb r0, [r1, #4]
	strb r0, [r4, #4]
	ldrb r0, [r1, #5]
	strb r0, [r4, #5]
	add r1, r4, #6
	add r0, sp, #4
	add r0, #2
	ldrb r2, [r0]
	strb r2, [r4, #6]
	ldrb r2, [r0, #1]
	strb r2, [r1, #1]
	ldrb r2, [r0, #2]
	strb r2, [r1, #2]
	ldrb r2, [r0, #3]
	strb r2, [r1, #3]
	ldrb r2, [r0, #4]
	strb r2, [r1, #4]
	ldrb r0, [r0, #5]
	strb r0, [r1, #5]
_0215860E:
	ldr r0, _02158640 // =0x0217B0F0
	ldr r0, [r0]
	cmp r0, #0
	beq _02158628
	add r0, sp, #0xc
	add r1, sp, #4
	add r1, #2
	bl ovl08_215605C
	add r0, sp, #0x2c
	add r1, sp, #0
	bl ovl08_215605C
_02158628:
	mov r0, #1
	add sp, #0x50
	pop {r4}
	pop {r3}
	bx r3
	nop
_02158634: .word 0x0217B1B4
_02158638: .word 0x0217D2FC
_0215863C: .word 0x0217D2F4
_02158640: .word 0x0217B0F0
	thumb_func_end ovl08_2158528

	thumb_func_start ovl08_2158644
ovl08_2158644: // 0x02158644
	push {lr}
	sub sp, #4
	blx OS_GetMacAddress
	mov r0, #1
	add sp, #4
	pop {r3}
	bx r3
	thumb_func_end ovl08_2158644

	thumb_func_start ovl08_2158654
ovl08_2158654: // 0x02158654
	push {r4, lr}
	sub sp, #0x10
	mov r4, r0
	ldr r1, _021586E0 // =0x00000100
	add r0, sp, #4
	strh r1, [r0]
	ldr r3, _021586E4 // =0x0217B108
	add r2, sp, #4
	add r2, #2
	mov r1, #7
_02158668:
	ldrb r0, [r3]
	add r3, r3, #1
	strb r0, [r2]
	add r2, r2, #1
	sub r1, r1, #1
	cmp r1, #0
	bne _02158668
	ldr r0, _021586E8 // =0x0217B0EC
	ldr r0, [r0]
	mov r1, #1
	add r2, sp, #4
	mov r3, #2
	bl ovl08_2158864
	mov r1, #2
	add r2, sp, #4
	mov r3, r1
	bl ovl08_2158864
	ldr r1, _021586EC // =0x0217D2C0
	ldr r1, [r1]
	cmp r1, #0
	beq _021586A0
	mov r1, #5
	add r2, sp, #4
	mov r3, #2
	bl ovl08_2158864
_021586A0:
	mov r1, #3
	add r2, sp, #4
	add r2, #2
	mov r3, #7
	bl ovl08_2158864
	mov r3, r0
	ldr r1, _021586EC // =0x0217D2C0
	ldr r1, [r1]
	cmp r1, #0
	beq _021586C2
	mov r1, #4
	ldr r2, _021586F0 // =0x0217D2F4
	mov r3, #6
	bl ovl08_2158864
	mov r3, r0
_021586C2:
	mov r0, #0
	str r0, [sp]
	mov r0, r4
	mov r1, #2
	ldr r2, _021586F4 // =0x0217D7A4
	ldr r4, _021586E8 // =0x0217B0EC
	ldr r4, [r4]
	sub r3, r3, r4
	add r3, #8
	bl ovl08_21588CC
	add sp, #0x10
	pop {r4}
	pop {r3}
	bx r3
	.align 2, 0
_021586E0: .word 0x00000100
_021586E4: .word 0x0217B108
_021586E8: .word 0x0217B0EC
_021586EC: .word 0x0217D2C0
_021586F0: .word 0x0217D2F4
_021586F4: .word 0x0217D7A4
	thumb_func_end ovl08_2158654

	thumb_func_start ovl08_21586F8
ovl08_21586F8: // 0x021586F8
	push {r4, r5, r6, lr}
	sub sp, #0x10
	mov r5, r1
	mov r6, r2
	mov r4, r3
	add r1, sp, #4
	add r2, sp, #8
	bl ovl08_2158A1C
	mov r1, r0
	cmp r1, #0
	bne _0215871A
	mov r0, #0
	add sp, #0x10
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_0215871A:
	ldr r0, [sp, #4]
	cmp r0, r5
	beq _0215872A
	mov r0, #0
	add sp, #0x10
	pop {r4, r5, r6}
	pop {r3}
	bx r3
_0215872A:
	cmp r4, #0
	beq _02158744
	mov r0, #0x10
	str r0, [sp]
	mov r0, r6
	ldr r2, [sp, #8]
	mov r3, r4
	bl ovl08_215789C
	ldr r0, [sp, #8]
	sub r0, #8
	str r0, [sp, #8]
	b _0215874C
_02158744:
	mov r0, r6
	ldr r2, [sp, #8]
	blx memcpy
_0215874C:
	ldr r0, [sp, #8]
	add sp, #0x10
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_21586F8

	thumb_func_start ovl08_2158758
ovl08_2158758: // 0x02158758
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	str r1, [sp]
	add r1, sp, #0xc
	add r2, sp, #0x10
	bl ovl08_2158A1C
	str r0, [sp, #0x1c]
	mov r7, #0
	str r7, [sp, #4]
	str r7, [sp, #8]
	cmp r0, #0
	bne _0215877C
	mov r0, r7
	add sp, #0x24
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215877C:
	ldr r1, [sp, #0xc]
	cmp r1, #1
	beq _0215878C
	mov r0, r7
	add sp, #0x24
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215878C:
	ldr r1, [sp, #0x10]
	add r6, r0, r1
	add r0, #8
	str r0, [sp, #0x1c]
	add r0, sp, #0x1c
	mov r1, r6
	add r2, sp, #0x14
	add r3, sp, #0x18
	bl ovl08_21589C8
	cmp r0, #0
	beq _02158800
	mov r4, #0xff
	ldr r5, _02158834 // =0x0000FF00
_021587A8:
	ldr r1, [sp, #0x14]
	cmp r1, #1
	beq _021587B8
	cmp r1, #2
	beq _021587CA
	cmp r1, #5
	beq _021587DE
	b _021587F0
_021587B8:
	ldrh r0, [r0]
	asr r1, r0, #8
	and r1, r4
	lsl r0, r0, #8
	and r0, r5
	orr r1, r0
	lsl r0, r1, #0x10
	lsr r7, r0, #0x10
	b _021587F0
_021587CA:
	ldrh r0, [r0]
	asr r1, r0, #8
	and r1, r4
	lsl r0, r0, #8
	and r0, r5
	orr r1, r0
	lsl r0, r1, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #4]
	b _021587F0
_021587DE:
	ldrh r0, [r0]
	asr r1, r0, #8
	and r1, r4
	lsl r0, r0, #8
	and r0, r5
	orr r1, r0
	lsl r0, r1, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #8]
_021587F0:
	add r0, sp, #0x1c
	mov r1, r6
	add r2, sp, #0x14
	add r3, sp, #0x18
	bl ovl08_21589C8
	cmp r0, #0
	bne _021587A8
_02158800:
	cmp r7, #1
	bne _0215880A
	ldr r0, [sp, #4]
	cmp r0, #1
	beq _02158814
_0215880A:
	mov r0, #0
	add sp, #0x24
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02158814:
	ldr r0, [sp, #8]
	cmp r0, #1
	blt _02158822
	mov r1, #1
	ldr r0, [sp]
	str r1, [r0]
	b _02158828
_02158822:
	mov r1, #0
	ldr r0, [sp]
	str r1, [r0]
_02158828:
	mov r0, #1
	add sp, #0x24
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_02158834: .word 0x0000FF00
	thumb_func_end ovl08_2158758

	thumb_func_start ovl08_2158838
ovl08_2158838: // 0x02158838
	push {r4, lr}
	mov r4, r0
	mov r0, #0
	strb r0, [r4]
	strb r0, [r4, #1]
	strb r0, [r4, #2]
	strb r0, [r4, #3]
	strb r0, [r4, #4]
	strb r0, [r4, #5]
	strb r0, [r4, #6]
	strb r0, [r4, #7]
	mov r0, r4
	add r0, #8
	bl ovl08_2158864
	sub r0, r0, r4
	mov r1, r0
	sub r1, #8
	strh r1, [r4]
	pop {r4}
	pop {r3}
	bx r3
	thumb_func_end ovl08_2158838

	thumb_func_start ovl08_2158864
ovl08_2158864: // 0x02158864
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	mov r7, r2
	mov r4, r3
	mov r0, #0
	strb r0, [r5]
	strb r0, [r5, #1]
	strb r0, [r5, #2]
	strb r0, [r5, #3]
	lsl r0, r1, #0x10
	lsr r0, r0, #0x10
	asr r2, r0, #8
	mov r3, #0xff
	and r2, r3
	lsl r1, r0, #8
	ldr r0, _021588C8 // =0x0000FF00
	and r1, r0
	orr r2, r1
	strh r2, [r5]
	mov r2, r4
	add r2, #0xb
	mov r1, #7
	bic r2, r1
	sub r6, r2, #4
	lsl r1, r4, #0x10
	lsr r2, r1, #0x10
	asr r1, r2, #8
	and r1, r3
	lsl r2, r2, #8
	and r2, r0
	orr r1, r2
	strh r1, [r5, #2]
	add r5, r5, #4
	mov r0, r5
	mov r1, #0
	mov r2, r6
	blx memset
	mov r0, r5
	mov r1, r7
	mov r2, r4
	blx memcpy
	add r0, r5, r6
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_021588C8: .word 0x0000FF00
	thumb_func_end ovl08_2158864

	thumb_func_start ovl08_21588CC
ovl08_21588CC: // 0x021588CC
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r6, r0
	str r1, [sp, #4]
	mov r1, r2
	mov r7, r3
	mov r5, r6
	mov r4, #0
	strb r4, [r1]
	strb r4, [r1, #1]
	strb r4, [r1, #2]
	strb r4, [r1, #3]
	strb r4, [r1, #4]
	strb r4, [r1, #5]
	strb r4, [r1, #6]
	strb r4, [r1, #7]
	mov r0, r7
	sub r0, #8
	lsl r0, r0, #0x10
	lsr r3, r0, #0x10
	asr r2, r3, #8
	mov r0, #0xff
	and r2, r0
	lsl r3, r3, #8
	ldr r0, _0215898C // =0x0000FF00
	and r3, r0
	orr r2, r3
	strh r2, [r1]
	ldr r3, [sp, #0x20]
	cmp r3, #0
	beq _0215891A
	mov r0, #0x10
	str r0, [sp]
	add r0, r6, #6
	mov r2, r7
	bl ovl08_2157A90
	add r7, #8
	b _02158922
_0215891A:
	add r0, r6, #6
	mov r2, r7
	blx memcpy
_02158922:
	mov r0, #0
	strb r0, [r6]
	strb r0, [r6, #1]
	strb r0, [r6, #2]
	strb r0, [r6, #3]
	strb r0, [r6, #4]
	strb r0, [r6, #5]
	ldr r0, [sp, #4]
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	asr r3, r0, #8
	mov r1, #0xff
	and r3, r1
	lsl r0, r0, #8
	ldr r2, _0215898C // =0x0000FF00
	and r0, r2
	orr r3, r0
	strh r3, [r6]
	lsl r0, r7, #0x10
	lsr r0, r0, #0x10
	asr r3, r0, #8
	and r3, r1
	lsl r0, r0, #8
	and r0, r2
	orr r3, r0
	strh r3, [r6, #2]
	add r0, r5, #6
	add r5, r0, r7
	mov r1, r6
	cmp r6, r5
	bhs _0215896A
_02158960:
	ldrb r0, [r1]
	add r4, r4, r0
	add r1, r1, #1
	cmp r1, r5
	blo _02158960
_0215896A:
	lsl r0, r4, #0x10
	lsr r1, r0, #0x10
	asr r2, r1, #8
	mov r0, #0xff
	and r2, r0
	lsl r1, r1, #8
	ldr r0, _0215898C // =0x0000FF00
	and r1, r0
	orr r2, r1
	strh r2, [r5]
	add r0, r5, #2
	sub r0, r0, r6
	add sp, #0xc
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_0215898C: .word 0x0000FF00
	thumb_func_end ovl08_21588CC

	thumb_func_start ovl08_2158990
ovl08_2158990: // 0x02158990
	push {r4, r5, r6, lr}
	sub sp, #8
	mov r4, r1
	mov r3, r2
	mov r2, r0
	add r2, #8
	str r2, [sp]
	ldrh r6, [r0]
	add r0, sp, #0
	asr r1, r6, #8
	mov r5, #0xff
	and r1, r5
	lsl r6, r6, #8
	ldr r5, _021589C4 // =0x0000FF00
	and r6, r5
	orr r1, r6
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	add r1, r2, r1
	mov r2, r4
	bl ovl08_21589C8
	add sp, #8
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	.align 2, 0
_021589C4: .word 0x0000FF00
	thumb_func_end ovl08_2158990

	thumb_func_start ovl08_21589C8
ovl08_21589C8: // 0x021589C8
	push {r4, r5, r6, r7}
	mov r5, r0
	mov r4, r2
	mov r2, r3
	ldr r0, [r5]
	cmp r0, r1
	blo _021589DC
	mov r0, #0
	pop {r4, r5, r6, r7}
	bx lr
_021589DC:
	ldrh r1, [r0]
	asr r7, r1, #8
	mov r3, #0xff
	and r7, r3
	lsl r1, r1, #8
	ldr r6, _02158A18 // =0x0000FF00
	and r1, r6
	orr r7, r1
	lsl r1, r7, #0x10
	lsr r1, r1, #0x10
	str r1, [r4]
	ldrh r1, [r0, #2]
	asr r4, r1, #8
	and r4, r3
	lsl r1, r1, #8
	and r1, r6
	orr r4, r1
	lsl r1, r4, #0x10
	lsr r1, r1, #0x10
	str r1, [r2]
	add r0, r0, #4
	ldr r2, [r2]
	add r2, #0xb
	mov r1, #7
	bic r2, r1
	sub r1, r2, #4
	add r1, r0, r1
	str r1, [r5]
	pop {r4, r5, r6, r7}
	bx lr
	.align 2, 0
_02158A18: .word 0x0000FF00
	thumb_func_end ovl08_21589C8

	thumb_func_start ovl08_2158A1C
ovl08_2158A1C: // 0x02158A1C
	push {r4, r5, r6, r7}
	mov r3, #0
	ldrh r4, [r0]
	asr r7, r4, #8
	mov r5, #0xff
	and r7, r5
	lsl r4, r4, #8
	ldr r6, _02158A88 // =0x0000FF00
	and r4, r6
	orr r7, r4
	lsl r4, r7, #0x10
	lsr r4, r4, #0x10
	str r4, [r1]
	ldrh r1, [r0, #2]
	asr r4, r1, #8
	and r4, r5
	lsl r1, r1, #8
	and r1, r6
	orr r4, r1
	lsl r1, r4, #0x10
	lsr r1, r1, #0x10
	str r1, [r2]
	add r4, r0, #6
	ldr r1, [r2]
	add r4, r4, r1
	mov r2, r0
	cmp r0, r4
	bhs _02158A5E
_02158A54:
	ldrb r1, [r2]
	add r3, r3, r1
	add r2, r2, #1
	cmp r2, r4
	blo _02158A54
_02158A5E:
	ldrh r2, [r4]
	lsl r1, r3, #0x10
	lsr r4, r1, #0x10
	asr r3, r2, #8
	mov r1, #0xff
	and r3, r1
	lsl r2, r2, #8
	ldr r1, _02158A88 // =0x0000FF00
	and r2, r1
	orr r3, r2
	lsl r1, r3, #0x10
	lsr r1, r1, #0x10
	cmp r4, r1
	beq _02158A80
	mov r0, #0
	pop {r4, r5, r6, r7}
	bx lr
_02158A80:
	add r0, r0, #6
	pop {r4, r5, r6, r7}
	bx lr
	nop
_02158A88: .word 0x0000FF00
	thumb_func_end ovl08_2158A1C

	thumb_func_start ovl08_2158A8C
ovl08_2158A8C: // 0x02158A8C
	mov r1, r2
	mov r2, r3
	ldr r3, _02158A94 // =sub_2158A98
	bx r3
	.align 2, 0
_02158A94: .word sub_2158A98
	thumb_func_end ovl08_2158A8C

	thumb_func_start sub_2158A98
sub_2158A98: // 0x02158A98
	push {r4, r5, r6, lr}
	sub sp, #0x10
	mov r5, r0
	mov r6, r1
	mov r4, r2
	mov r0, #8
	add r1, sp, #4
	strb r0, [r1]
	mov r0, #2
	strb r0, [r1, #1]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #8]
	ldr r0, _02158AD8 // =0x000001E6
	strh r0, [r1, #2]
	blx sub_20BDDD0
	add r1, sp, #0xc
	blx sub_20BE2CC
	str r4, [sp]
	mov r0, r5
	add r1, sp, #4
	add r2, sp, #0xc
	mov r3, r6
	bl ovl08_2158ADC
	add sp, #0x10
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	nop
_02158AD8: .word 0x000001E6
	thumb_func_end sub_2158A98

	thumb_func_start ovl08_2158ADC
ovl08_2158ADC: // 0x02158ADC
	push {lr}
	sub sp, #4
	str r1, [sp]
	mov r1, r3
	ldr r2, [sp, #8]
	mov r3, #0
	blx SOC_SendTo
	cmp r0, #0
	bge _02158AF4
	mov r0, #3
	mvn r0, r0
_02158AF4:
	add sp, #4
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_2158ADC

	thumb_func_start ovl08_2158AFC
ovl08_2158AFC: // 0x02158AFC
	push {r4, r5, r6, r7, lr}
	sub sp, #0x9c
	mov r0, #0
	str r0, [sp, #0x18]
	mvn r4, r0
	str r0, [sp, #0x48]
	ldr r0, _02158DBC // =0x0217D2E0
	ldr r0, [r0]
	str r0, [sp, #0x10]
	mov r1, #0x30
	mul r0, r1
	str r0, [sp, #0x10]
	add r0, #0x34
	str r0, [sp, #0x10]
	mov r0, #1
	ldr r1, [sp, #0x10]
	bl ovl08_21560E8
	str r0, [sp, #0x14]
	cmp r0, #0
	bne _02158B28
	b _02158D9C
_02158B28:
	mov r0, #1
	ldr r1, [sp, #0x10]
	bl ovl08_21560E8
	str r0, [sp, #0x18]
	cmp r0, #0
	bne _02158B38
	b _02158D9C
_02158B38:
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #0x44]
	str r0, [sp, #0x3c]
	str r0, [sp, #0x38]
	add r6, sp, #0x6c
	str r0, [sp, #0x34]
	lsl r7, r0, #0
	str r0, [sp, #0x28]
	str r0, [sp, #0x2c]
	str r0, [sp, #0x30]
	str r0, [sp, #0x40]
	b _02158D64
_02158B52:
	bl ovl08_2156114
	ldr r1, _02158DC0 // =0x0217B0F8
	ldr r1, [r1]
	cmp r0, r1
	blo _02158B60
	b _02158D74
_02158B60:
	ldr r0, [sp, #0x28]
	lsl r1, r0, #0
	lsl r2, r0, #0
	ldr r3, _02158DC4 // =0x0030BFFE
	bl ovl08_2159620
	cmp r0, #0
	bne _02158B76
	mov r0, #1
	mvn r4, r0
	b _02158D9C
_02158B76:
	mov r0, r6
	blx OS_CreateAlarm
	mov r0, #0x13
	str r0, [sp]
	mov r0, r6
	ldr r1, _02158DC8 // =0x000FFB10
	ldr r2, [sp, #0x2c]
	ldr r3, _02158DCC // =ovl08_21592A0
	blx OS_SetAlarm
	mov r5, #1
	ldr r4, [sp, #0x30]
_02158B90:
	mov r0, #0xa
	blx OS_Sleep
	bl ovl08_2156114
	ldr r1, _02158DC0 // =0x0217B0F8
	ldr r1, [r1]
	cmp r0, r1
	bhs _02158C2C
	ldr r0, _02158DD0 // =0x0217D280
	ldr r0, [r0]
	cmp r0, #0
	bne _02158C2C
	bl ovl08_21592E8
	cmp r0, #0
	beq _02158C28
_02158BB2:
	cmp r0, #0x13
	bhi _02158C1E
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #8]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add r0, pc
	bx r0
_02158BC4: // jump table
	.hword _02158C1E - _02158BC4 + 1 // case 0
	.hword _02158C1E - _02158BC4 + 1 // case 1
	.hword _02158C1E - _02158BC4 + 1 // case 2
	.hword _02158C1E - _02158BC4 + 1 // case 3
	.hword _02158C20 - _02158BC4 + 1 // case 4
	.hword _02158BF0 - _02158BC4 + 1 // case 5
	.hword _02158C1E - _02158BC4 + 1 // case 6
	.hword _02158C1E - _02158BC4 + 1 // case 7
	.hword _02158C20 - _02158BC4 + 1 // case 8
	.hword _02158C1E - _02158BC4 + 1 // case 9
	.hword _02158C1A - _02158BC4 + 1 // case 10
	.hword _02158C1E - _02158BC4 + 1 // case 11
	.hword _02158C1E - _02158BC4 + 1 // case 12
	.hword _02158C1E - _02158BC4 + 1 // case 13
	.hword _02158C1E - _02158BC4 + 1 // case 14
	.hword _02158C1E - _02158BC4 + 1 // case 15
	.hword _02158C1E - _02158BC4 + 1 // case 16
	.hword _02158C1E - _02158BC4 + 1 // case 17
	.hword _02158C20 - _02158BC4 + 1 // case 18
	.hword _02158BEC - _02158BC4 + 1 // case 19
_02158BEC:
	mov r5, r7
	b _02158C20
_02158BF0:
	ldr r0, _02158DD4 // =0x0217D2CC
	ldr r0, [r0]
	ldr r1, _02158DBC // =0x0217D2E0
	ldr r1, [r1]
	bl ovl08_215972C
	cmp r0, r4
	ble _02158C20
	mov r4, r0
	mov r0, r6
	blx OS_CancelAlarm
	mov r0, #0x13
	str r0, [sp]
	mov r0, r6
	ldr r1, _02158DC8 // =0x000FFB10
	ldr r2, [sp, #0x34]
	ldr r3, _02158DCC // =ovl08_21592A0
	blx OS_SetAlarm
	b _02158C20
_02158C1A:
	ldr r5, [sp, #0x38]
	b _02158C20
_02158C1E:
	ldr r5, [sp, #0x3c]
_02158C20:
	bl ovl08_21592E8
	cmp r0, #0
	bne _02158BB2
_02158C28:
	cmp r5, #0
	bne _02158B90
_02158C2C:
	mov r0, r6
	blx OS_CancelAlarm
_02158C32:
	bl ovl08_21592E8
	cmp r0, #0
	bne _02158C32
	ldr r0, _02158DD0 // =0x0217D280
	ldr r0, [r0]
	cmp r0, #0
	beq _02158C44
	b _02158D74
_02158C44:
	ldr r0, [sp, #0x40]
	str r0, [sp, #0xc]
	ldr r0, _02158DBC // =0x0217D2E0
	ldr r0, [r0]
	cmp r4, r0
	blt _02158C56
	mov r0, #5
	mvn r4, r0
	b _02158D9C
_02158C56:
	ldr r0, [sp, #0x40]
	str r0, [sp, #8]
	ldr r0, _02158DD4 // =0x0217D2CC
	ldr r0, [r0]
	str r0, [sp, #0x1c]
	cmp r4, #0
	ble _02158CEE
	ldr r0, [sp, #0x14]
	str r0, [sp, #0x20]
	add r0, #8
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x14]
	str r0, [sp, #0x24]
	lsl r5, r0, #0
	add r5, #0x2c
_02158C74:
	ldr r0, [sp, #0x20]
	ldr r1, [sp, #0x1c]
	add r1, #0xc
	mov r2, #0x20
	blx memcpy
	ldr r0, [sp, #0x1c]
	ldrh r1, [r0, #0xa]
	ldr r0, [sp, #0x24]
	str r1, [r0, #4]
	ldr r0, [sp, #0x1c]
	ldrh r1, [r0, #0xa]
	ldr r0, [sp, #0x24]
	add r1, r0, r1
	ldr r0, [sp, #0x44]
	strb r0, [r1, #8]
	ldr r0, [sp, #0x1c]
	ldrh r1, [r0, #0x2c]
	mov r0, #0x10
	and r1, r0
	cmp r1, #0
	beq _02158CA4
	mov r1, #1
	b _02158CA6
_02158CA4:
	ldr r1, [sp, #0x44]
_02158CA6:
	ldr r0, [sp, #0x24]
	strh r1, [r0, #0x32]
	ldr r0, [sp, #0x1c]
	add r0, r0, #4
	ldr r1, [sp, #0x1c]
	ldrb r1, [r1, #4]
	strb r1, [r5]
	ldrb r1, [r0, #1]
	strb r1, [r5, #1]
	ldrb r1, [r0, #2]
	strb r1, [r5, #2]
	ldrb r1, [r0, #3]
	strb r1, [r5, #3]
	ldrb r1, [r0, #4]
	strb r1, [r5, #4]
	ldrb r0, [r0, #5]
	strb r0, [r5, #5]
	ldr r0, [sp, #0x20]
	add r0, #0x30
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x24]
	add r0, #0x30
	str r0, [sp, #0x24]
	add r5, #0x30
	ldr r0, [sp, #0xc]
	add r0, r0, #1
	str r0, [sp, #0xc]
	ldr r0, [sp, #8]
	add r0, r0, #1
	str r0, [sp, #8]
	ldr r0, [sp, #0x1c]
	add r0, #0xc0
	str r0, [sp, #0x1c]
	ldr r0, [sp, #8]
	cmp r0, r4
	blt _02158C74
_02158CEE:
	ldr r0, [sp, #0x14]
	str r4, [r0]
	ldr r0, _02158DD8 // =0x0217D2A8
	ldr r0, [r0]
	cmp r0, #1
	beq _02158D4A
	ldr r0, [sp, #0x14]
	ldr r1, [sp, #0x18]
	add r2, sp, #0x48
	bl ovl08_2158DE8
	cmp r0, #0
	beq _02158D4A
	ldr r3, [sp, #0x48]
	ldr r0, [sp, #0x14]
	add r2, r0, #4
	mov r0, #0x30
	mov r1, r3
	mul r1, r0
	add r4, r2, r1
	ldr r0, _02158DDC // =0x0217D288
	str r3, [r0]
	ldr r0, _02158DE0 // =0x0217D384
	add r1, r4, #4
	blx strcpy
	ldr r1, _02158DE4 // =0x0217D2FC
	mov r0, r4
	add r0, #0x28
	add r4, #0x28
	ldrb r2, [r4]
	strb r2, [r1]
	ldrb r2, [r0, #1]
	strb r2, [r1, #1]
	ldrb r2, [r0, #2]
	strb r2, [r1, #2]
	ldrb r2, [r0, #3]
	strb r2, [r1, #3]
	ldrb r2, [r0, #4]
	strb r2, [r1, #4]
	ldrb r0, [r0, #5]
	strb r0, [r1, #5]
	add r0, sp, #0x4c
	bl ovl08_215605C
	b _02158D74
_02158D4A:
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x14]
	ldr r2, [sp, #0x10]
	blx memcpy
	mov r1, #2
	ldr r0, _02158DD8 // =0x0217D2A8
	str r1, [r0]
	bl ovl08_2155DFC
	ldr r0, [sp, #4]
	add r0, r0, #1
	str r0, [sp, #4]
_02158D64:
	ldr r0, [sp, #4]
	cmp r0, #0x1e
	bge _02158D74
	ldr r0, _02158DD0 // =0x0217D280
	ldr r0, [r0]
	cmp r0, #0
	bne _02158D74
	b _02158B52
_02158D74:
	ldr r0, [sp, #4]
	cmp r0, #0x1e
	bge _02158D86
	bl ovl08_2156114
	ldr r1, _02158DC0 // =0x0217B0F8
	ldr r1, [r1]
	cmp r0, r1
	bls _02158D8C
_02158D86:
	mov r0, #2
	mvn r4, r0
	b _02158D9C
_02158D8C:
	ldr r0, _02158DD0 // =0x0217D280
	ldr r0, [r0]
	cmp r0, #0
	beq _02158D9A
	mov r0, #7
	mvn r4, r0
	b _02158D9C
_02158D9A:
	mov r4, #1
_02158D9C:
	ldr r0, [sp, #0x14]
	cmp r0, #0
	beq _02158DA6
	bl ovl08_21560D4
_02158DA6:
	ldr r0, [sp, #0x18]
	cmp r0, #0
	beq _02158DB0
	bl ovl08_21560D4
_02158DB0:
	mov r0, r4
	add sp, #0x9c
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_02158DBC: .word 0x0217D2E0
_02158DC0: .word 0x0217B0F8
_02158DC4: .word 0x0030BFFE
_02158DC8: .word 0x000FFB10
_02158DCC: .word ovl08_21592A0
_02158DD0: .word 0x0217D280
_02158DD4: .word 0x0217D2CC
_02158DD8: .word 0x0217D2A8
_02158DDC: .word 0x0217D288
_02158DE0: .word 0x0217D384
_02158DE4: .word 0x0217D2FC
	thumb_func_end ovl08_2158AFC

	thumb_func_start ovl08_2158DE8
ovl08_2158DE8: // 0x02158DE8
	push {r4, r5, r6, r7, lr}
	sub sp, #0x74
	str r0, [sp]
	str r1, [sp, #4]
	str r2, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r0, [sp]
	add r5, r0, #4
	lsl r0, r1, #0
	add r4, r0, #4
	ldr r0, [sp, #0xc]
	str r0, [sp, #0x20]
	ldr r0, [sp]
	ldr r0, [r0]
	cmp r0, #0
	bls _02158EB6
	ldr r0, [sp, #0xc]
	str r0, [sp, #0x28]
	str r0, [sp, #0x24]
_02158E12:
	add r2, sp, #0x30
	mov r1, #0x22
_02158E16:
	ldr r0, [sp, #0x24]
	strb r0, [r2]
	add r2, r2, #1
	sub r1, r1, #1
	cmp r1, #0
	bne _02158E16
	add r0, sp, #0x30
	add r1, r5, #4
	mov r2, #0x20
	blx memcpy
	ldr r2, [r5]
	ldr r1, [sp, #0x28]
	add r0, sp, #0x30
	strb r1, [r0, r2]
	lsl r7, r1, #0
	ldr r0, [sp, #4]
	ldr r0, [r0]
	str r0, [sp, #0x1c]
	cmp r0, #0
	bls _02158E9A
	ldr r6, [r5]
_02158E42:
	cmp r6, #0
	beq _02158E9A
	cmp r6, #0x20
	bhi _02158E9A
	cmp r6, #1
	bne _02158E58
	ldrb r0, [r5, #4]
	cmp r0, #0
	beq _02158E9A
	cmp r0, #0x20
	beq _02158E9A
_02158E58:
	add r0, sp, #0x30
	blx strlen
	mov r2, r0
	add r0, sp, #0x30
	add r1, r4, #4
	blx memcmp
	cmp r0, #0
	bne _02158E90
	mov r0, r5
	add r0, #0x28
	mov r1, r4
	add r1, #0x28
	mov r2, #4
	blx memcmp
	cmp r0, #0
	bne _02158E90
	ldrh r1, [r5, #0x2e]
	ldrh r0, [r4, #0x2e]
	cmp r1, r0
	beq _02158E90
	cmp r1, #0
	bne _02158E90
	mov r0, #1
	str r0, [sp, #0xc]
	b _02158E9A
_02158E90:
	add r4, #0x30
	add r7, r7, #1
	ldr r0, [sp, #0x1c]
	cmp r7, r0
	blo _02158E42
_02158E9A:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	bne _02158EB6
	add r5, #0x30
	ldr r0, [sp, #4]
	add r4, r0, #4
	ldr r0, [sp, #0x20]
	add r0, r0, #1
	str r0, [sp, #0x20]
	ldr r0, [sp]
	ldr r1, [r0]
	ldr r0, [sp, #0x20]
	cmp r0, r1
	blo _02158E12
_02158EB6:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	bne _02158F9E
	add r2, sp, #0x50
	add r2, #2
	mov r1, #0x22
	mov r0, #0
_02158EC4:
	strb r0, [r2]
	add r2, r2, #1
	sub r1, r1, #1
	cmp r1, #0
	bne _02158EC4
	mov r0, #0
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r0, [sp]
	add r5, r0, #4
	ldr r0, [sp, #4]
	add r4, r0, #4
	ldr r6, [sp, #0x14]
	ldr r0, [r0]
	cmp r0, #0
	bls _02158F24
	add r7, sp, #0x50
	add r7, #2
_02158EE8:
	mov r0, r7
	add r1, r4, #4
	mov r2, #0x20
	blx memcpy
	ldr r1, [r4]
	ldr r0, [sp, #0x14]
	strb r0, [r7, r1]
	ldr r0, _02158FB8 // =asc_217B100
	blx strlen
	mov r2, r0
	mov r0, r7
	ldr r1, _02158FB8 // =asc_217B100
	blx memcmp
	cmp r0, #0
	bne _02158F18
	ldrh r0, [r4, #0x2e]
	cmp r0, #0
	bne _02158F18
	mov r0, #1
	str r0, [sp, #0x18]
	b _02158F24
_02158F18:
	add r4, #0x30
	add r6, r6, #1
	ldr r0, [sp, #4]
	ldr r0, [r0]
	cmp r6, r0
	blo _02158EE8
_02158F24:
	mov r0, #0
	str r0, [sp, #0x20]
	ldr r0, [sp]
	ldr r0, [r0]
	cmp r0, #0
	bls _02158F8E
	ldr r7, _02158FB8 // =asc_217B100
	add r4, sp, #0x50
	add r4, #2
	ldr r0, [sp, #0x20]
	str r0, [sp, #0x2c]
_02158F3A:
	mov r0, r4
	add r1, r5, #4
	mov r2, #0x20
	blx memcpy
	ldr r1, [r5]
	ldr r0, [sp, #0x2c]
	strb r0, [r4, r1]
	mov r0, r4
	blx strlen
	mov r6, r0
	mov r0, r7
	blx strlen
	cmp r6, r0
	bne _02158F7C
	mov r0, r7
	blx strlen
	mov r2, r0
	mov r0, r4
	mov r1, r7
	blx memcmp
	cmp r0, #0
	bne _02158F7C
	ldrh r0, [r5, #0x2e]
	cmp r0, #0
	bne _02158F7C
	mov r0, #1
	str r0, [sp, #0x14]
	b _02158F8E
_02158F7C:
	add r5, #0x30
	ldr r0, [sp, #0x20]
	add r0, r0, #1
	str r0, [sp, #0x20]
	ldr r0, [sp]
	ldr r1, [r0]
	ldr r0, [sp, #0x20]
	cmp r0, r1
	blo _02158F3A
_02158F8E:
	ldr r0, [sp, #0x14]
	cmp r0, #0
	beq _02158F9E
	ldr r0, [sp, #0x18]
	cmp r0, #0
	bne _02158F9E
	mov r0, #1
	str r0, [sp, #0xc]
_02158F9E:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	beq _02158FAE
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #8]
	str r1, [r0]
	mov r0, #1
	str r0, [sp, #0x10]
_02158FAE:
	ldr r0, [sp, #0x10]
	add sp, #0x74
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02158FB8: .word asc_217B100
	thumb_func_end ovl08_2158DE8

	thumb_func_start ovl08_2158FBC
ovl08_2158FBC: // 0x02158FBC
	push {r4, r5, r6, lr}
	mov r5, #1
	ldr r0, _0215901C // =0x0217D290
	ldr r0, [r0]
	cmp r0, #0
	beq _02159006
	bl ovl08_21595E0
	cmp r0, #0
	beq _02159000
	mov r4, #0
	mov r6, #0xa
_02158FD4:
	mov r0, r6
	blx OS_Sleep
	bl ovl08_21592E8
	cmp r0, #0
	beq _02158FFC
_02158FE2:
	cmp r0, #4
	beq _02158FF4
	cmp r0, #5
	beq _02158FF4
	cmp r0, #0xe
	bne _02158FF2
	mov r5, r4
	b _02158FF4
_02158FF2:
	mov r5, r4
_02158FF4:
	bl ovl08_21592E8
	cmp r0, #0
	bne _02158FE2
_02158FFC:
	cmp r5, #0
	bne _02158FD4
_02159000:
	mov r1, #0
	ldr r0, _0215901C // =0x0217D290
	str r1, [r0]
_02159006:
	ldr r0, _02159020 // =0x0217D294
	ldr r1, [r0]
	cmp r1, #0
	beq _02159016
	mov r1, #0
	str r1, [r0]
	blx sub_20BE40C
_02159016:
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	.align 2, 0
_0215901C: .word 0x0217D290
_02159020: .word 0x0217D294
	thumb_func_end ovl08_2158FBC

	thumb_func_start ovl08_2159024
ovl08_2159024: // 0x02159024
	push {r4, r5, r6, r7, lr}
	sub sp, #0x34
	mov r5, #1
	mvn r6, r5
	ldr r0, _02159150 // =0x0217D2CC
	ldr r2, [r0]
	ldr r0, _02159154 // =0x0217D288
	ldr r1, [r0]
	mov r0, #0xc0
	mul r1, r0
	add r7, r2, r1
	cmp r7, #0
	bne _02159048
	mov r0, #0
	add sp, #0x34
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02159048:
	mov r0, r7
	mov r1, #0
	ldr r2, _02159158 // =0x00030000
	bl ovl08_21594C8
	cmp r0, #0
	bne _02159062
	lsl r0, r5, #0
	mvn r0, r0
	add sp, #0x34
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02159062:
	add r0, sp, #8
	blx OS_CreateAlarm
	mov r0, #0x12
	str r0, [sp]
	add r0, sp, #8
	ldr r1, _0215915C // =0x003FEC42
	mov r2, #0
	ldr r3, _02159160 // =ovl08_21592A0
	blx OS_SetAlarm
	mov r4, #0
	mov r0, #7
	mvn r0, r0
	str r0, [sp, #4]
_02159080:
	bl ovl08_2156114
	ldr r1, _02159164 // =0x0217B0F8
	ldr r1, [r1]
	cmp r0, r1
	blo _02159092
	mov r0, #2
	mvn r6, r0
	b _02159118
_02159092:
	ldr r0, _02159168 // =0x0217D280
	ldr r0, [r0]
	cmp r0, #0
	beq _021590A0
	mov r0, #7
	mvn r6, r0
	b _02159118
_021590A0:
	mov r0, #0xa
	blx OS_Sleep
	bl ovl08_21592E8
	cmp r0, #0
	beq _02159114
_021590AE:
	cmp r0, #0xc
	bgt _021590C8
	cmp r0, #0xc
	bge _021590DE
	cmp r0, #5
	bgt _0215910A
	cmp r0, #4
	blt _0215910A
	cmp r0, #4
	beq _0215910C
	cmp r0, #5
	beq _0215910C
	b _0215910A
_021590C8:
	cmp r0, #0x13
	bgt _0215910A
	cmp r0, #0xd
	blt _0215910A
	cmp r0, #0xd
	beq _021590E4
	cmp r0, #0x12
	beq _0215910C
	cmp r0, #0x13
	beq _0215910C
	b _0215910A
_021590DE:
	mov r5, r4
	mov r6, #1
	b _0215910C
_021590E4:
	ldr r0, _02159168 // =0x0217D280
	ldr r0, [r0]
	cmp r0, #0
	beq _021590F2
	mov r5, r4
	ldr r6, [sp, #4]
	b _0215910C
_021590F2:
	mov r0, r7
	mov r1, r4
	ldr r2, _02159158 // =0x00030000
	bl ovl08_21594C8
	cmp r0, #0
	bne _0215910C
	mov r0, r6
	add sp, #0x34
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215910A:
	mov r5, r4
_0215910C:
	bl ovl08_21592E8
	cmp r0, #0
	bne _021590AE
_02159114:
	cmp r5, #0
	bne _02159080
_02159118:
	add r0, sp, #8
	blx OS_CancelAlarm
_0215911E:
	bl ovl08_21592E8
	cmp r0, #0
	bne _0215911E
	cmp r6, #0
	ble _02159146
	mov r1, #1
	ldr r0, _0215916C // =0x0217D290
	str r1, [r0]
	ldr r0, _02159170 // =0x0217B15C
	blx sub_20BE418
	cmp r0, #0
	bge _02159140
	mov r0, #1
	mvn r6, r0
	b _02159146
_02159140:
	mov r1, #1
	ldr r0, _02159174 // =0x0217D294
	str r1, [r0]
_02159146:
	mov r0, r6
	add sp, #0x34
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02159150: .word 0x0217D2CC
_02159154: .word 0x0217D288
_02159158: .word 0x00030000
_0215915C: .word 0x003FEC42
_02159160: .word ovl08_21592A0
_02159164: .word 0x0217B0F8
_02159168: .word 0x0217D280
_0215916C: .word 0x0217D290
_02159170: .word 0x0217B15C
_02159174: .word 0x0217D294
	thumb_func_end ovl08_2159024

	thumb_func_start ovl08_2159178
ovl08_2159178: // 0x02159178
	push {r4, r5, r6, lr}
	mov r5, #1
	bl ovl08_2159578
	cmp r0, #0
	beq _021591B4
	mov r4, #0
	mov r6, #0xa
_02159188:
	mov r0, r6
	blx OS_Sleep
	bl ovl08_21592E8
	cmp r0, #0
	beq _021591B0
_02159196:
	cmp r0, #4
	beq _021591A8
	cmp r0, #5
	beq _021591A8
	cmp r0, #0x14
	bne _021591A6
	mov r5, r4
	b _021591A8
_021591A6:
	mov r5, r4
_021591A8:
	bl ovl08_21592E8
	cmp r0, #0
	bne _02159196
_021591B0:
	cmp r5, #0
	bne _02159188
_021591B4:
	ldr r0, _021591D0 // =0x0217D2C4
	ldr r0, [r0]
	cmp r0, #0
	beq _021591C8
	ldr r1, _021591D4 // =0x0217D27C
	ldr r1, [r1]
	blx r1
	mov r1, #0
	ldr r0, _021591D0 // =0x0217D2C4
	str r1, [r0]
_021591C8:
	mov r0, #1
	pop {r4, r5, r6}
	pop {r3}
	bx r3
	.align 2, 0
_021591D0: .word 0x0217D2C4
_021591D4: .word 0x0217D27C
	thumb_func_end ovl08_2159178

	thumb_func_start ovl08_21591D8
ovl08_21591D8: // 0x021591D8
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r6, r0
	mov r5, #1
	ldr r0, _02159280 // =0x0217D2E0
	str r6, [r0]
	bl ovl08_2159328
	mov r0, #0xd0
	mov r7, r6
	mul r7, r0
	ldr r0, _02159284 // =0x000024D0
	add r1, r7, r0
	mov r0, #0xc0
	mul r6, r0
	add r0, r1, r6
	ldr r1, _02159288 // =0x0217D274
	ldr r1, [r1]
	blx r1
	ldr r1, _0215928C // =0x0217D2C4
	str r0, [r1]
	cmp r0, #0
	bne _02159212
	mov r0, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02159212:
	mov r3, #0x1f
	add r1, r0, r3
	bic r1, r3
	ldr r0, _02159290 // =0x0217D2B0
	str r1, [r0]
	ldr r0, _02159294 // =0x00002490
	add r2, r7, r0
	add r0, r1, r2
	add r6, r0, r3
	bic r6, r3
	ldr r0, _02159298 // =0x0217D2CC
	str r6, [r0]
	ldr r0, _0215929C // =ovl08_21592AC
	bl ovl08_21593D0
	cmp r0, #0
	bne _02159240
	lsl r0, r5, #0
	mvn r0, r0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02159240:
	mov r0, #0xa
	blx OS_Sleep
	bl ovl08_21592E8
	cmp r0, #0
	beq _02159272
	mov r7, #0
	mov r1, #1
	mvn r6, r1
_02159254:
	cmp r0, #4
	beq _0215926A
	cmp r0, #5
	beq _0215926A
	cmp r0, #6
	bne _02159266
	mov r5, r7
	mov r4, #1
	b _0215926A
_02159266:
	mov r5, r7
	mov r4, r6
_0215926A:
	bl ovl08_21592E8
	cmp r0, #0
	bne _02159254
_02159272:
	cmp r5, #0
	bne _02159240
	mov r0, r4
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_02159280: .word 0x0217D2E0
_02159284: .word 0x000024D0
_02159288: .word 0x0217D274
_0215928C: .word 0x0217D2C4
_02159290: .word 0x0217D2B0
_02159294: .word 0x00002490
_02159298: .word 0x0217D2CC
_0215929C: .word ovl08_21592AC
	thumb_func_end ovl08_21591D8

	thumb_func_start ovl08_21592A0
ovl08_21592A0: // 0x021592A0
	mov r1, #0
	ldr r3, _021592A8 // =ovl08_21592AC
	bx r3
	nop
_021592A8: .word ovl08_21592AC
	thumb_func_end ovl08_21592A0

	thumb_func_start ovl08_21592AC
ovl08_21592AC: // 0x021592AC
	push {r4}
	sub sp, #4
	ldr r1, _021592DC // =0x0217D2DC
	ldr r2, [r1]
	ldr r1, _021592E0 // =0x0217D2D8
	ldr r3, [r1]
	add r4, r3, #1
	cmp r4, r2
	beq _021592D4
	add r2, r2, #3
	cmp r3, r2
	beq _021592D4
	lsl r3, r3, #2
	ldr r2, _021592E4 // =0x0217D30C
	str r0, [r2, r3]
	str r4, [r1]
	cmp r4, #4
	blt _021592D4
	mov r0, #0
	str r0, [r1]
_021592D4:
	add sp, #4
	pop {r4}
	bx lr
	nop
_021592DC: .word 0x0217D2DC
_021592E0: .word 0x0217D2D8
_021592E4: .word 0x0217D30C
	thumb_func_end ovl08_21592AC

	thumb_func_start ovl08_21592E8
ovl08_21592E8: // 0x021592E8
	push {r4, lr}
	blx OS_DisableInterrupts
	ldr r3, _0215931C // =0x0217D2DC
	ldr r1, [r3]
	ldr r2, _02159320 // =0x0217D2D8
	ldr r2, [r2]
	cmp r2, r1
	bne _021592FE
	mov r4, #0
	b _02159310
_021592FE:
	lsl r4, r1, #2
	ldr r2, _02159324 // =0x0217D30C
	ldr r4, [r2, r4]
	add r1, r1, #1
	str r1, [r3]
	cmp r1, #4
	blt _02159310
	mov r1, #0
	str r1, [r3]
_02159310:
	blx OS_RestoreInterrupts
	mov r0, r4
	pop {r4}
	pop {r3}
	bx r3
	.align 2, 0
_0215931C: .word 0x0217D2DC
_02159320: .word 0x0217D2D8
_02159324: .word 0x0217D30C
	thumb_func_end ovl08_21592E8

	thumb_func_start ovl08_2159328
ovl08_2159328: // 0x02159328
	push {lr}
	sub sp, #4
	blx OS_DisableInterrupts
	mov r3, #0
	ldr r1, _02159350 // =0x0217D2D8
	str r3, [r1]
	ldr r1, _02159354 // =0x0217D2DC
	str r3, [r1]
	ldr r2, _02159358 // =0x0217D30C
	mov r1, r3
_0215933E:
	stmia r2!, {r1}
	add r3, r3, #1
	cmp r3, #4
	blt _0215933E
	blx OS_RestoreInterrupts
	add sp, #4
	pop {r3}
	bx r3
	.align 2, 0
_02159350: .word 0x0217D2D8
_02159354: .word 0x0217D2DC
_02159358: .word 0x0217D30C
	thumb_func_end ovl08_2159328

	thumb_func_start ovl08_215935C
ovl08_215935C: // 0x0215935C
	push {r4, lr}
	mov r4, r1
	cmp r4, #0
	beq _0215937C
	cmp r2, #0
	ble _0215937C
	ldr r0, _02159384 // =0x0217D32C
	blx OS_LockMutex
	mov r0, r4
	ldr r1, _02159388 // =0x0217D27C
	ldr r1, [r1]
	blx r1
	ldr r0, _02159384 // =0x0217D32C
	blx OS_UnlockMutex
_0215937C:
	pop {r4}
	pop {r3}
	bx r3
	nop
_02159384: .word 0x0217D32C
_02159388: .word 0x0217D27C
	thumb_func_end ovl08_215935C

	thumb_func_start ovl08_215938C
ovl08_215938C: // 0x0215938C
	push {r4, lr}
	mov r4, r1
	cmp r4, #0
	ble _021593B2
	ldr r0, _021593BC // =0x0217D32C
	blx OS_LockMutex
	mov r0, r4
	ldr r1, _021593C0 // =0x0217D274
	ldr r1, [r1]
	blx r1
	mov r4, r0
	ldr r0, _021593BC // =0x0217D32C
	blx OS_UnlockMutex
	mov r0, r4
	pop {r4}
	pop {r3}
	bx r3
_021593B2:
	mov r0, #0
	pop {r4}
	pop {r3}
	bx r3
	nop
_021593BC: .word 0x0217D32C
_021593C0: .word 0x0217D274
	thumb_func_end ovl08_215938C

	thumb_func_start ovl08_21593C4
ovl08_21593C4: // 0x021593C4
	ldr r0, _021593CC // =0x0217D29C
	ldr r0, [r0]
	bx lr
	nop
_021593CC: .word 0x0217D29C
	thumb_func_end ovl08_21593C4

	thumb_func_start ovl08_21593D0
ovl08_21593D0: // 0x021593D0
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r6, r0
	mov r5, r1
	mov r7, r2
	blx OS_DisableInterrupts
	mov r4, r0
	ldr r0, _021594A4 // =0x0217D298
	str r5, [r0]
	mov r2, r5
	add r2, #0x63
	mov r0, #3
	bic r2, r0
	ldr r0, _021594A8 // =0x0217D278
	str r2, [r0]
	mov r1, r2
	add r1, #0x2f
	mov r3, #0x1f
	bic r1, r3
	ldr r3, _021594AC // =0x0217D2AC
	str r1, [r3]
	ldr r3, _021594B0 // =0x0000231F
	add r1, r1, r3
	mov r3, #0x1f
	bic r1, r3
	ldr r3, _021594B4 // =0x0217D2BC
	str r1, [r3]
	add r1, #0xdf
	mov r3, #0x1f
	bic r1, r3
	str r1, [r2, #4]
	ldr r1, [r0]
	add r3, r5, r7
	ldr r2, [r1, #4]
	sub r2, r3, r2
	str r2, [r1, #8]
	mov r2, #0
	ldr r1, [r0]
	str r2, [r1, #0xc]
	ldr r1, [r0]
	mov r0, #3
	str r0, [r1]
	ldr r0, _021594B8 // =0x0217D2F0
	str r6, [r0]
	ldr r0, _021594BC // =0x0217D29C
	ldr r0, [r0]
	cmp r0, #0
	bne _02159456
	ldr r0, _021594AC // =0x0217D2AC
	ldr r0, [r0]
	ldr r1, _021594C0 // =0x00002300
	blx WCM_Init
	cmp r0, #0
	beq _02159450
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02159450:
	mov r1, #1
	ldr r0, _021594BC // =0x0217D29C
	str r1, [r0]
_02159456:
	ldr r0, _021594BC // =0x0217D29C
	ldr r0, [r0]
	cmp r0, #1
	bne _02159492
	ldr r0, _021594A8 // =0x0217D278
	ldr r0, [r0]
	ldr r1, _021594C4 // =ovl08_21597FC
	blx WCM_StartupAsync
	cmp r0, #3
	beq _0215947C
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_0215947C:
	mov r1, #4
	ldr r0, _021594BC // =0x0217D29C
	str r1, [r0]
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #1
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02159492:
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_021594A4: .word 0x0217D298
_021594A8: .word 0x0217D278
_021594AC: .word 0x0217D2AC
_021594B0: .word 0x0000231F
_021594B4: .word 0x0217D2BC
_021594B8: .word 0x0217D2F0
_021594BC: .word 0x0217D29C
_021594C0: .word 0x00002300
_021594C4: .word ovl08_21597FC
	thumb_func_end ovl08_21593D0

	thumb_func_start ovl08_21594C8
ovl08_21594C8: // 0x021594C8
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r7, r0
	mov r5, r1
	mov r6, r2
	blx OS_DisableInterrupts
	mov r4, r0
	ldr r0, _02159568 // =0x0217D2C8
	str r6, [r0]
	cmp r5, #0
	beq _021594EE
	mov r0, r5
	ldr r1, _0215956C // =0x0217D298
	ldr r1, [r1]
	mov r2, #0x60
	blx MI_CpuCopy8
	b _021594FA
_021594EE:
	ldr r0, _0215956C // =0x0217D298
	ldr r0, [r0]
	mov r1, #0
	mov r2, #0x60
	blx MI_CpuFill8
_021594FA:
	mov r0, r7
	ldr r1, _02159570 // =0x0217D2BC
	ldr r1, [r1]
	mov r2, #0xc0
	blx MIi_CpuCopy32
	bl ovl08_2159778
	cmp r0, #1
	bne _02159524
	mov r1, #8
	ldr r0, _02159574 // =0x0217D29C
	str r1, [r0]
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #1
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02159524:
	ldr r0, _02159574 // =0x0217D29C
	ldr r0, [r0]
	cmp r0, #3
	bne _02159556
	ldr r0, _02159570 // =0x0217D2BC
	ldr r0, [r0]
	ldr r1, _0215956C // =0x0217D298
	ldr r1, [r1]
	ldr r2, _02159568 // =0x0217D2C8
	ldr r2, [r2]
	blx WCM_ConnectAsync
	cmp r0, #3
	bne _02159556
	mov r1, #8
	ldr r0, _02159574 // =0x0217D29C
	str r1, [r0]
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #1
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_02159556:
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	nop
_02159568: .word 0x0217D2C8
_0215956C: .word 0x0217D298
_02159570: .word 0x0217D2BC
_02159574: .word 0x0217D29C
	thumb_func_end ovl08_21594C8

	thumb_func_start ovl08_2159578
ovl08_2159578: // 0x02159578
	push {r4, lr}
	blx OS_DisableInterrupts
	mov r4, r0
	ldr r0, _021595DC // =0x0217D29C
	ldr r0, [r0]
	cmp r0, #3
	bne _021595B2
	blx WCM_CleanupAsync
	cmp r0, #3
	beq _0215959E
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	pop {r4}
	pop {r3}
	bx r3
_0215959E:
	mov r1, #2
	ldr r0, _021595DC // =0x0217D29C
	str r1, [r0]
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #1
	pop {r4}
	pop {r3}
	bx r3
_021595B2:
	bl ovl08_2159778
	cmp r0, #1
	bne _021595CE
	mov r1, #2
	ldr r0, _021595DC // =0x0217D29C
	str r1, [r0]
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #1
	pop {r4}
	pop {r3}
	bx r3
_021595CE:
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	pop {r4}
	pop {r3}
	bx r3
	.align 2, 0
_021595DC: .word 0x0217D29C
	thumb_func_end ovl08_2159578

	thumb_func_start ovl08_21595E0
ovl08_21595E0: // 0x021595E0
	push {r4, lr}
	blx OS_DisableInterrupts
	mov r4, r0
	ldr r0, _0215961C // =0x0217D29C
	ldr r0, [r0]
	cmp r0, #7
	bne _0215960C
	blx WCM_DisconnectAsync
	cmp r0, #3
	bne _0215960C
	mov r1, #4
	ldr r0, _0215961C // =0x0217D29C
	str r1, [r0]
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #1
	pop {r4}
	pop {r3}
	bx r3
_0215960C:
	mov r0, r4
	blx OS_RestoreInterrupts
	mov r0, #0
	pop {r4}
	pop {r3}
	bx r3
	nop
_0215961C: .word 0x0217D29C
	thumb_func_end ovl08_21595E0

	thumb_func_start ovl08_2159620
ovl08_2159620: // 0x02159620
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	str r3, [sp]
	blx OS_DisableInterrupts
	mov r7, r0
	ldr r1, _0215970C // =0x0217D2D0
	ldr r0, [sp]
	str r0, [r1]
	ldr r0, _02159710 // =0x0217D304
	ldr r1, _02159714 // =0x0217D2B4
	str r0, [r1]
	cmp r5, #0
	beq _02159654
	mov r2, #0
_02159644:
	ldrb r1, [r5]
	add r5, r5, #1
	strb r1, [r0]
	add r0, r0, #1
	add r2, r2, #1
	cmp r2, #6
	blt _02159644
	b _02159662
_02159654:
	mov r1, #0xff
	mov r2, #6
	blx MI_CpuFill8
	ldr r1, _02159718 // =0x0211279C
	ldr r0, _02159714 // =0x0217D2B4
	str r1, [r0]
_02159662:
	ldr r2, _0215971C // =0x0217D364
	ldr r0, _02159720 // =0x0217D2B8
	str r2, [r0]
	cmp r4, #0
	beq _0215969E
	cmp r6, #0
	ble _0215969E
	cmp r6, #0x20
	bge _0215969E
	mov r1, #0
	cmp r6, #0
	ble _02159688
_0215967A:
	ldrb r0, [r4]
	add r4, r4, #1
	strb r0, [r2]
	add r2, r2, #1
	add r1, r1, #1
	cmp r1, r6
	blt _0215967A
_02159688:
	cmp r1, #0x20
	bge _021596AE
	ldr r0, _0215971C // =0x0217D364
	add r2, r0, r1
	mov r0, #0
_02159692:
	strb r0, [r2]
	add r2, r2, #1
	add r1, r1, #1
	cmp r1, #0x20
	blt _02159692
	b _021596AE
_0215969E:
	ldr r0, _0215971C // =0x0217D364
	mov r1, #0xff
	mov r2, #0x20
	blx MI_CpuFill8
	ldr r1, _02159724 // =0x021127A4
	ldr r0, _02159720 // =0x0217D2B8
	str r1, [r0]
_021596AE:
	ldr r0, _02159728 // =0x0217D29C
	ldr r0, [r0]
	cmp r0, #3
	bne _021596DE
	ldr r0, _02159710 // =0x0217D304
	ldr r1, _02159720 // =0x0217D2B8
	ldr r1, [r1]
	ldr r2, _0215970C // =0x0217D2D0
	ldr r2, [r2]
	blx WCM_SearchAsync
	cmp r0, #3
	bne _021596FC
	mov r1, #6
	ldr r0, _02159728 // =0x0217D29C
	str r1, [r0]
	mov r0, r7
	blx OS_RestoreInterrupts
	mov r0, #1
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021596DE:
	bl ovl08_2159778
	cmp r0, #1
	bne _021596FC
	mov r1, #6
	ldr r0, _02159728 // =0x0217D29C
	str r1, [r0]
	mov r0, r7
	blx OS_RestoreInterrupts
	mov r0, #1
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
_021596FC:
	mov r0, r7
	blx OS_RestoreInterrupts
	mov r0, #0
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
_0215970C: .word 0x0217D2D0
_02159710: .word 0x0217D304
_02159714: .word 0x0217D2B4
_02159718: .word 0x0211279C
_0215971C: .word 0x0217D364
_02159720: .word 0x0217D2B8
_02159724: .word 0x021127A4
_02159728: .word 0x0217D29C
	thumb_func_end ovl08_2159620

	thumb_func_start ovl08_215972C
ovl08_215972C: // 0x0215972C
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	mov r5, r0
	mov r7, r1
	mov r0, #1
	blx WCM_LockApList
	blx WCM_CountApList
	mov r6, r0
	cmp r6, #0
	ble _02159766
	mov r4, #0
	cmp r6, #0
	ble _02159766
_0215974A:
	cmp r4, r7
	bge _02159766
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	blx WCM_PointApListLinkLevel
	mov r1, r5
	mov r2, #0xc0
	blx MIi_CpuCopy32
	add r4, r4, #1
	add r5, #0xc0
	cmp r4, r6
	blt _0215974A
_02159766:
	mov r0, #0
	blx WCM_LockApList
	mov r0, r6
	add sp, #4
	pop {r4, r5, r6, r7}
	pop {r3}
	bx r3
	.align 2, 0
	thumb_func_end ovl08_215972C

	thumb_func_start ovl08_2159778
ovl08_2159778: // 0x02159778
	push {lr}
	sub sp, #4
	ldr r0, _021597F0 // =0x0217D29C
	ldr r0, [r0]
	cmp r0, #8
	bhi _021597E0
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #8]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add r0, pc
	bx r0
_02159792: // jump table
	.hword _021597E0 - _02159792 + 1 // case 0
	.hword _021597CA - _02159792 + 1 // case 1
	.hword _021597E0 - _02159792 + 1 // case 2
	.hword _021597E0 - _02159792 + 1 // case 3
	.hword _021597E0 - _02159792 + 1 // case 4
	.hword _021597A4 - _02159792 + 1 // case 5
	.hword _021597E0 - _02159792 + 1 // case 6
	.hword _021597BA - _02159792 + 1 // case 7
	.hword _021597E0 - _02159792 + 1 // case 8
_021597A4:
	mov r0, #0
	mov r1, r0
	mov r2, r0
	blx WCM_SearchAsync
	cmp r0, #3
	beq _021597E8
	mov r0, #0
	add sp, #4
	pop {r3}
	bx r3
_021597BA:
	blx WCM_DisconnectAsync
	cmp r0, #3
	beq _021597E8
	mov r0, #0
	add sp, #4
	pop {r3}
	bx r3
_021597CA:
	ldr r0, _021597F4 // =0x0217D278
	ldr r0, [r0]
	ldr r1, _021597F8 // =ovl08_21597FC
	blx WCM_StartupAsync
	cmp r0, #3
	beq _021597E8
	mov r0, #0
	add sp, #4
	pop {r3}
	bx r3
_021597E0:
	mov r0, #0
	add sp, #4
	pop {r3}
	bx r3
_021597E8:
	mov r0, #1
	add sp, #4
	pop {r3}
	bx r3
	.align 2, 0
_021597F0: .word 0x0217D29C
_021597F4: .word 0x0217D278
_021597F8: .word ovl08_21597FC
	thumb_func_end ovl08_2159778

	thumb_func_start ovl08_21597FC
ovl08_21597FC: // 0x021597FC
	push {lr}
	sub sp, #4
	cmp r0, #0
	bne _02159806
	b _02159BDA
_02159806:
	mov r1, #0
	ldrsh r2, [r0, r1]
	cmp r2, #9
	bls _02159810
	b _02159BCC
_02159810:
	add r2, r2, r2
	add r2, pc
	ldrh r2, [r2, #8]
	lsl r2, r2, #0x10
	asr r2, r2, #0x10
	add r2, pc
	bx r2
_0215981E: // jump table
	.hword _02159BCC - _0215981E + 1 // case 0
	.hword _02159832 - _0215981E + 1 // case 1
	.hword _02159B24 - _0215981E + 1 // case 2
	.hword _021598E2 - _0215981E + 1 // case 3
	.hword _0215996A - _0215981E + 1 // case 4
	.hword _02159926 - _0215981E + 1 // case 5
	.hword _02159A44 - _0215981E + 1 // case 6
	.hword _02159B68 - _0215981E + 1 // case 7
	.hword _02159B82 - _0215981E + 1 // case 8
	.hword _02159B94 - _0215981E + 1 // case 9
_02159832:
	mov r2, #2
	ldrsh r0, [r0, r2]
	cmp r0, #0
	bne _021598C8
	ldr r0, _02159B9C // =0x0217D29C
	ldr r2, [r0]
	cmp r2, #4
	bne _0215985A
	mov r2, #3
	str r2, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _02159850
	b _02159BDA
_02159850:
	mov r0, #6
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_0215985A:
	cmp r2, #6
	bne _02159890
	ldr r0, _02159BA4 // =0x0217D2B4
	ldr r0, [r0]
	ldr r1, _02159BA8 // =0x0217D2B8
	ldr r1, [r1]
	ldr r2, _02159BAC // =0x0217D2D0
	ldr r2, [r2]
	blx WCM_SearchAsync
	cmp r0, #3
	bne _02159874
	b _02159BDA
_02159874:
	mov r1, #3
	ldr r0, _02159B9C // =0x0217D29C
	str r1, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _02159884
	b _02159BDA
_02159884:
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159890:
	cmp r2, #8
	beq _02159896
	b _02159BDA
_02159896:
	ldr r0, _02159BB0 // =0x0217D2BC
	ldr r0, [r0]
	ldr r1, _02159BB4 // =0x0217D298
	ldr r1, [r1]
	ldr r2, _02159BB8 // =0x0217D2C8
	ldr r2, [r2]
	blx WCM_ConnectAsync
	cmp r0, #3
	bne _021598AC
	b _02159BDA
_021598AC:
	mov r1, #3
	ldr r0, _02159B9C // =0x0217D29C
	str r1, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _021598BC
	b _02159BDA
_021598BC:
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_021598C8:
	mov r3, #1
	ldr r0, _02159B9C // =0x0217D29C
	str r3, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r3, [r0]
	cmp r3, #0
	bne _021598D8
	b _02159BDA
_021598D8:
	mov r0, r2
	blx r3
	add sp, #4
	pop {r3}
	bx r3
_021598E2:
	mov r2, #2
	ldrsh r0, [r0, r2]
	cmp r0, #0
	bne _0215990C
	ldr r0, _02159B9C // =0x0217D29C
	ldr r2, [r0]
	cmp r2, #6
	beq _021598F4
	b _02159BDA
_021598F4:
	mov r2, #5
	str r2, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _02159902
	b _02159BDA
_02159902:
	mov r0, #8
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_0215990C:
	mov r2, #3
	ldr r0, _02159B9C // =0x0217D29C
	str r2, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _0215991C
	b _02159BDA
_0215991C:
	mov r0, #9
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159926:
	mov r2, #2
	ldrsh r0, [r0, r2]
	cmp r0, #0
	bne _02159950
	ldr r0, _02159B9C // =0x0217D29C
	ldr r2, [r0]
	cmp r2, #8
	beq _02159938
	b _02159BDA
_02159938:
	mov r2, #7
	str r2, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _02159946
	b _02159BDA
_02159946:
	mov r0, #0xc
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159950:
	mov r2, #3
	ldr r0, _02159B9C // =0x0217D29C
	str r2, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _02159960
	b _02159BDA
_02159960:
	mov r0, #0xd
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_0215996A:
	mov r2, #2
	ldrsh r0, [r0, r2]
	cmp r0, #0
	bne _02159A2A
	ldr r0, _02159B9C // =0x0217D29C
	ldr r2, [r0]
	cmp r2, #4
	bne _02159992
	mov r2, #3
	str r2, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _02159988
	b _02159BDA
_02159988:
	mov r0, #0xa
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159992:
	cmp r2, #6
	bne _021599C8
	ldr r0, _02159BA4 // =0x0217D2B4
	ldr r0, [r0]
	ldr r1, _02159BA8 // =0x0217D2B8
	ldr r1, [r1]
	ldr r2, _02159BAC // =0x0217D2D0
	ldr r2, [r2]
	blx WCM_SearchAsync
	cmp r0, #3
	bne _021599AC
	b _02159BDA
_021599AC:
	mov r1, #3
	ldr r0, _02159B9C // =0x0217D29C
	str r1, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _021599BC
	b _02159BDA
_021599BC:
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_021599C8:
	cmp r2, #2
	bne _021599F2
	blx WCM_CleanupAsync
	cmp r0, #3
	bne _021599D6
	b _02159BDA
_021599D6:
	mov r1, #3
	ldr r0, _02159B9C // =0x0217D29C
	str r1, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _021599E6
	b _02159BDA
_021599E6:
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_021599F2:
	cmp r2, #8
	beq _021599F8
	b _02159BDA
_021599F8:
	ldr r0, _02159BB0 // =0x0217D2BC
	ldr r0, [r0]
	ldr r1, _02159BB4 // =0x0217D298
	ldr r1, [r1]
	ldr r2, _02159BB8 // =0x0217D2C8
	ldr r2, [r2]
	blx WCM_ConnectAsync
	cmp r0, #3
	bne _02159A0E
	b _02159BDA
_02159A0E:
	mov r1, #3
	ldr r0, _02159B9C // =0x0217D29C
	str r1, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _02159A1E
	b _02159BDA
_02159A1E:
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159A2A:
	mov r2, #3
	ldr r0, _02159B9C // =0x0217D29C
	str r2, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _02159A3A
	b _02159BDA
_02159A3A:
	mov r0, #0xb
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159A44:
	mov r2, #2
	ldrsh r0, [r0, r2]
	cmp r0, #0
	bne _02159B0C
	ldr r0, _02159B9C // =0x0217D29C
	ldr r2, [r0]
	cmp r2, #4
	bne _02159A6C
	mov r2, #3
	str r2, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _02159A62
	b _02159BDA
_02159A62:
	mov r0, #0xe
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159A6C:
	cmp r2, #6
	bne _02159AA2
	ldr r0, _02159BA4 // =0x0217D2B4
	ldr r0, [r0]
	ldr r1, _02159BA8 // =0x0217D2B8
	ldr r1, [r1]
	ldr r2, _02159BAC // =0x0217D2D0
	ldr r2, [r2]
	blx WCM_SearchAsync
	cmp r0, #3
	bne _02159A86
	b _02159BDA
_02159A86:
	mov r1, #3
	ldr r0, _02159B9C // =0x0217D29C
	str r1, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _02159A96
	b _02159BDA
_02159A96:
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159AA2:
	cmp r2, #2
	bne _02159ACC
	blx WCM_CleanupAsync
	cmp r0, #3
	bne _02159AB0
	b _02159BDA
_02159AB0:
	mov r1, #3
	ldr r0, _02159B9C // =0x0217D29C
	str r1, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	bne _02159AC0
	b _02159BDA
_02159AC0:
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159ACC:
	cmp r2, #8
	bne _02159AFE
	ldr r0, _02159BB0 // =0x0217D2BC
	ldr r0, [r0]
	ldr r1, _02159BB4 // =0x0217D298
	ldr r1, [r1]
	ldr r2, _02159BB8 // =0x0217D2C8
	ldr r2, [r2]
	blx WCM_ConnectAsync
	cmp r0, #3
	beq _02159BDA
	mov r1, #3
	ldr r0, _02159B9C // =0x0217D29C
	str r1, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	beq _02159BDA
	mov r0, #2
	mov r1, #0
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159AFE:
	cmp r2, #7
	bne _02159BDA
	mov r1, #3
	str r1, [r0]
	add sp, #4
	pop {r3}
	bx r3
_02159B0C:
	mov r2, #3
	ldr r0, _02159B9C // =0x0217D29C
	str r2, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	beq _02159BDA
	mov r0, #0xf
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159B24:
	mov r2, #2
	ldrsh r0, [r0, r2]
	cmp r0, #0
	bne _02159B50
	ldr r0, _02159B9C // =0x0217D29C
	ldr r0, [r0]
	cmp r0, #2
	bne _02159BDA
	blx WCM_Finish
	mov r1, #0
	ldr r0, _02159B9C // =0x0217D29C
	str r1, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	beq _02159BDA
	mov r0, #0x14
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159B50:
	mov r3, #3
	ldr r0, _02159B9C // =0x0217D29C
	str r3, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r3, [r0]
	cmp r3, #0
	beq _02159BDA
	mov r0, r2
	blx r3
	add sp, #4
	pop {r3}
	bx r3
_02159B68:
	ldr r0, _02159B9C // =0x0217D29C
	ldr r0, [r0]
	cmp r0, #5
	bne _02159BDA
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	beq _02159BDA
	mov r0, #5
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159B82:
	ldr r0, _02159BA0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	beq _02159BDA
	mov r0, #4
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159B94:
	ldr r0, _02159B9C // =0x0217D29C
	str r1, [r0]
	ldr r0, _02159BA0 // =0x0217D2F0
	b _02159BBC
	.align 2, 0
_02159B9C: .word 0x0217D29C
_02159BA0: .word 0x0217D2F0
_02159BA4: .word 0x0217D2B4
_02159BA8: .word 0x0217D2B8
_02159BAC: .word 0x0217D2D0
_02159BB0: .word 0x0217D2BC
_02159BB4: .word 0x0217D298
_02159BB8: .word 0x0217D2C8
_02159BBC:
	ldr r2, [r0]
	cmp r2, #0
	beq _02159BDA
	mov r0, #3
	blx r2
	add sp, #4
	pop {r3}
	bx r3
_02159BCC:
	ldr r0, _02159BE0 // =0x0217D2F0
	ldr r2, [r0]
	cmp r2, #0
	beq _02159BDA
	mov r0, #1
	mov r1, #0
	blx r2
_02159BDA:
	add sp, #4
	pop {r3}
	bx r3
	.align 2, 0
_02159BE0: .word 0x0217D2F0
	thumb_func_end ovl08_21597FC

	.rodata

_02177D00:
	.byte 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x08
	.byte 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x80
	.byte 0x00, 0x00, 0x00, 0x1B, 0x00, 0x00, 0x00, 0x36, 0xF4, 0x51, 0x50, 0xA7, 0x41, 0x7E, 0x53, 0x65
	.byte 0x17, 0x1A, 0xC3, 0xA4, 0x27, 0x3A, 0x96, 0x5E, 0xAB, 0x3B, 0xCB, 0x6B, 0x9D, 0x1F, 0xF1, 0x45
	.byte 0xFA, 0xAC, 0xAB, 0x58, 0xE3, 0x4B, 0x93, 0x03, 0x30, 0x20, 0x55, 0xFA, 0x76, 0xAD, 0xF6, 0x6D
	.byte 0xCC, 0x88, 0x91, 0x76, 0x02, 0xF5, 0x25, 0x4C, 0xE5, 0x4F, 0xFC, 0xD7, 0x2A, 0xC5, 0xD7, 0xCB
	.byte 0x35, 0x26, 0x80, 0x44, 0x62, 0xB5, 0x8F, 0xA3, 0xB1, 0xDE, 0x49, 0x5A, 0xBA, 0x25, 0x67, 0x1B
	.byte 0xEA, 0x45, 0x98, 0x0E, 0xFE, 0x5D, 0xE1, 0xC0, 0x2F, 0xC3, 0x02, 0x75, 0x4C, 0x81, 0x12, 0xF0
	.byte 0x46, 0x8D, 0xA3, 0x97, 0xD3, 0x6B, 0xC6, 0xF9, 0x8F, 0x03, 0xE7, 0x5F, 0x92, 0x15, 0x95, 0x9C
	.byte 0x6D, 0xBF, 0xEB, 0x7A, 0x52, 0x95, 0xDA, 0x59, 0xBE, 0xD4, 0x2D, 0x83, 0x74, 0x58, 0xD3, 0x21
	.byte 0xE0, 0x49, 0x29, 0x69, 0xC9, 0x8E, 0x44, 0xC8, 0xC2, 0x75, 0x6A, 0x89, 0x8E, 0xF4, 0x78, 0x79
	.byte 0x58, 0x99, 0x6B, 0x3E, 0xB9, 0x27, 0xDD, 0x71, 0xE1, 0xBE, 0xB6, 0x4F, 0x88, 0xF0, 0x17, 0xAD
	.byte 0x20, 0xC9, 0x66, 0xAC, 0xCE, 0x7D, 0xB4, 0x3A, 0xDF, 0x63, 0x18, 0x4A, 0x1A, 0xE5, 0x82, 0x31
	.byte 0x51, 0x97, 0x60, 0x33, 0x53, 0x62, 0x45, 0x7F, 0x64, 0xB1, 0xE0, 0x77, 0x6B, 0xBB, 0x84, 0xAE
	.byte 0x81, 0xFE, 0x1C, 0xA0, 0x08, 0xF9, 0x94, 0x2B, 0x48, 0x70, 0x58, 0x68, 0x45, 0x8F, 0x19, 0xFD
	.byte 0xDE, 0x94, 0x87, 0x6C, 0x7B, 0x52, 0xB7, 0xF8, 0x73, 0xAB, 0x23, 0xD3, 0x4B, 0x72, 0xE2, 0x02
	.byte 0x1F, 0xE3, 0x57, 0x8F, 0x55, 0x66, 0x2A, 0xAB, 0xEB, 0xB2, 0x07, 0x28, 0xB5, 0x2F, 0x03, 0xC2
	.byte 0xC5, 0x86, 0x9A, 0x7B, 0x37, 0xD3, 0xA5, 0x08, 0x28, 0x30, 0xF2, 0x87, 0xBF, 0x23, 0xB2, 0xA5
	.byte 0x03, 0x02, 0xBA, 0x6A, 0x16, 0xED, 0x5C, 0x82, 0xCF, 0x8A, 0x2B, 0x1C, 0x79, 0xA7, 0x92, 0xB4
	.byte 0x07, 0xF3, 0xF0, 0xF2, 0x69, 0x4E, 0xA1, 0xE2, 0xDA, 0x65, 0xCD, 0xF4, 0x05, 0x06, 0xD5, 0xBE
	.byte 0x34, 0xD1, 0x1F, 0x62, 0xA6, 0xC4, 0x8A, 0xFE, 0x2E, 0x34, 0x9D, 0x53, 0xF3, 0xA2, 0xA0, 0x55
	.byte 0x8A, 0x05, 0x32, 0xE1, 0xF6, 0xA4, 0x75, 0xEB, 0x83, 0x0B, 0x39, 0xEC, 0x60, 0x40, 0xAA, 0xEF
	.byte 0x71, 0x5E, 0x06, 0x9F, 0x6E, 0xBD, 0x51, 0x10, 0x21, 0x3E, 0xF9, 0x8A, 0xDD, 0x96, 0x3D, 0x06
	.byte 0x3E, 0xDD, 0xAE, 0x05, 0xE6, 0x4D, 0x46, 0xBD, 0x54, 0x91, 0xB5, 0x8D, 0xC4, 0x71, 0x05, 0x5D
	.byte 0x06, 0x04, 0x6F, 0xD4, 0x50, 0x60, 0xFF, 0x15, 0x98, 0x19, 0x24, 0xFB, 0xBD, 0xD6, 0x97, 0xE9
	.byte 0x40, 0x89, 0xCC, 0x43, 0xD9, 0x67, 0x77, 0x9E, 0xE8, 0xB0, 0xBD, 0x42, 0x89, 0x07, 0x88, 0x8B
	.byte 0x19, 0xE7, 0x38, 0x5B, 0xC8, 0x79, 0xDB, 0xEE, 0x7C, 0xA1, 0x47, 0x0A, 0x42, 0x7C, 0xE9, 0x0F
	.byte 0x84, 0xF8, 0xC9, 0x1E, 0x00, 0x00, 0x00, 0x00, 0x80, 0x09, 0x83, 0x86, 0x2B, 0x32, 0x48, 0xED
	.byte 0x11, 0x1E, 0xAC, 0x70, 0x5A, 0x6C, 0x4E, 0x72, 0x0E, 0xFD, 0xFB, 0xFF, 0x85, 0x0F, 0x56, 0x38
	.byte 0xAE, 0x3D, 0x1E, 0xD5, 0x2D, 0x36, 0x27, 0x39, 0x0F, 0x0A, 0x64, 0xD9, 0x5C, 0x68, 0x21, 0xA6
	.byte 0x5B, 0x9B, 0xD1, 0x54, 0x36, 0x24, 0x3A, 0x2E, 0x0A, 0x0C, 0xB1, 0x67, 0x57, 0x93, 0x0F, 0xE7
	.byte 0xEE, 0xB4, 0xD2, 0x96, 0x9B, 0x1B, 0x9E, 0x91, 0xC0, 0x80, 0x4F, 0xC5, 0xDC, 0x61, 0xA2, 0x20
	.byte 0x77, 0x5A, 0x69, 0x4B, 0x12, 0x1C, 0x16, 0x1A, 0x93, 0xE2, 0x0A, 0xBA, 0xA0, 0xC0, 0xE5, 0x2A
	.byte 0x22, 0x3C, 0x43, 0xE0, 0x1B, 0x12, 0x1D, 0x17, 0x09, 0x0E, 0x0B, 0x0D, 0x8B, 0xF2, 0xAD, 0xC7
	.byte 0xB6, 0x2D, 0xB9, 0xA8, 0x1E, 0x14, 0xC8, 0xA9, 0xF1, 0x57, 0x85, 0x19, 0x75, 0xAF, 0x4C, 0x07
	.byte 0x99, 0xEE, 0xBB, 0xDD, 0x7F, 0xA3, 0xFD, 0x60, 0x01, 0xF7, 0x9F, 0x26, 0x72, 0x5C, 0xBC, 0xF5
	.byte 0x66, 0x44, 0xC5, 0x3B, 0xFB, 0x5B, 0x34, 0x7E, 0x43, 0x8B, 0x76, 0x29, 0x23, 0xCB, 0xDC, 0xC6
	.byte 0xED, 0xB6, 0x68, 0xFC, 0xE4, 0xB8, 0x63, 0xF1, 0x31, 0xD7, 0xCA, 0xDC, 0x63, 0x42, 0x10, 0x85
	.byte 0x97, 0x13, 0x40, 0x22, 0xC6, 0x84, 0x20, 0x11, 0x4A, 0x85, 0x7D, 0x24, 0xBB, 0xD2, 0xF8, 0x3D
	.byte 0xF9, 0xAE, 0x11, 0x32, 0x29, 0xC7, 0x6D, 0xA1, 0x9E, 0x1D, 0x4B, 0x2F, 0xB2, 0xDC, 0xF3, 0x30
	.byte 0x86, 0x0D, 0xEC, 0x52, 0xC1, 0x77, 0xD0, 0xE3, 0xB3, 0x2B, 0x6C, 0x16, 0x70, 0xA9, 0x99, 0xB9
	.byte 0x94, 0x11, 0xFA, 0x48, 0xE9, 0x47, 0x22, 0x64, 0xFC, 0xA8, 0xC4, 0x8C, 0xF0, 0xA0, 0x1A, 0x3F
	.byte 0x7D, 0x56, 0xD8, 0x2C, 0x33, 0x22, 0xEF, 0x90, 0x49, 0x87, 0xC7, 0x4E, 0x38, 0xD9, 0xC1, 0xD1
	.byte 0xCA, 0x8C, 0xFE, 0xA2, 0xD4, 0x98, 0x36, 0x0B, 0xF5, 0xA6, 0xCF, 0x81, 0x7A, 0xA5, 0x28, 0xDE
	.byte 0xB7, 0xDA, 0x26, 0x8E, 0xAD, 0x3F, 0xA4, 0xBF, 0x3A, 0x2C, 0xE4, 0x9D, 0x78, 0x50, 0x0D, 0x92
	.byte 0x5F, 0x6A, 0x9B, 0xCC, 0x7E, 0x54, 0x62, 0x46, 0x8D, 0xF6, 0xC2, 0x13, 0xD8, 0x90, 0xE8, 0xB8
	.byte 0x39, 0x2E, 0x5E, 0xF7, 0xC3, 0x82, 0xF5, 0xAF, 0x5D, 0x9F, 0xBE, 0x80, 0xD0, 0x69, 0x7C, 0x93
	.byte 0xD5, 0x6F, 0xA9, 0x2D, 0x25, 0xCF, 0xB3, 0x12, 0xAC, 0xC8, 0x3B, 0x99, 0x18, 0x10, 0xA7, 0x7D
	.byte 0x9C, 0xE8, 0x6E, 0x63, 0x3B, 0xDB, 0x7B, 0xBB, 0x26, 0xCD, 0x09, 0x78, 0x59, 0x6E, 0xF4, 0x18
	.byte 0x9A, 0xEC, 0x01, 0xB7, 0x4F, 0x83, 0xA8, 0x9A, 0x95, 0xE6, 0x65, 0x6E, 0xFF, 0xAA, 0x7E, 0xE6
	.byte 0xBC, 0x21, 0x08, 0xCF, 0x15, 0xEF, 0xE6, 0xE8, 0xE7, 0xBA, 0xD9, 0x9B, 0x6F, 0x4A, 0xCE, 0x36
	.byte 0x9F, 0xEA, 0xD4, 0x09, 0xB0, 0x29, 0xD6, 0x7C, 0xA4, 0x31, 0xAF, 0xB2, 0x3F, 0x2A, 0x31, 0x23
	.byte 0xA5, 0xC6, 0x30, 0x94, 0xA2, 0x35, 0xC0, 0x66, 0x4E, 0x74, 0x37, 0xBC, 0x82, 0xFC, 0xA6, 0xCA
	.byte 0x90, 0xE0, 0xB0, 0xD0, 0xA7, 0x33, 0x15, 0xD8, 0x04, 0xF1, 0x4A, 0x98, 0xEC, 0x41, 0xF7, 0xDA
	.byte 0xCD, 0x7F, 0x0E, 0x50, 0x91, 0x17, 0x2F, 0xF6, 0x4D, 0x76, 0x8D, 0xD6, 0xEF, 0x43, 0x4D, 0xB0
	.byte 0xAA, 0xCC, 0x54, 0x4D, 0x96, 0xE4, 0xDF, 0x04, 0xD1, 0x9E, 0xE3, 0xB5, 0x6A, 0x4C, 0x1B, 0x88
	.byte 0x2C, 0xC1, 0xB8, 0x1F, 0x65, 0x46, 0x7F, 0x51, 0x5E, 0x9D, 0x04, 0xEA, 0x8C, 0x01, 0x5D, 0x35
	.byte 0x87, 0xFA, 0x73, 0x74, 0x0B, 0xFB, 0x2E, 0x41, 0x67, 0xB3, 0x5A, 0x1D, 0xDB, 0x92, 0x52, 0xD2
	.byte 0x10, 0xE9, 0x33, 0x56, 0xD6, 0x6D, 0x13, 0x47, 0xD7, 0x9A, 0x8C, 0x61, 0xA1, 0x37, 0x7A, 0x0C
	.byte 0xF8, 0x59, 0x8E, 0x14, 0x13, 0xEB, 0x89, 0x3C, 0xA9, 0xCE, 0xEE, 0x27, 0x61, 0xB7, 0x35, 0xC9
	.byte 0x1C, 0xE1, 0xED, 0xE5, 0x47, 0x7A, 0x3C, 0xB1, 0xD2, 0x9C, 0x59, 0xDF, 0xF2, 0x55, 0x3F, 0x73
	.byte 0x14, 0x18, 0x79, 0xCE, 0xC7, 0x73, 0xBF, 0x37, 0xF7, 0x53, 0xEA, 0xCD, 0xFD, 0x5F, 0x5B, 0xAA
	.byte 0x3D, 0xDF, 0x14, 0x6F, 0x44, 0x78, 0x86, 0xDB, 0xAF, 0xCA, 0x81, 0xF3, 0x68, 0xB9, 0x3E, 0xC4
	.byte 0x24, 0x38, 0x2C, 0x34, 0xA3, 0xC2, 0x5F, 0x40, 0x1D, 0x16, 0x72, 0xC3, 0xE2, 0xBC, 0x0C, 0x25
	.byte 0x3C, 0x28, 0x8B, 0x49, 0x0D, 0xFF, 0x41, 0x95, 0xA8, 0x39, 0x71, 0x01, 0x0C, 0x08, 0xDE, 0xB3
	.byte 0xB4, 0xD8, 0x9C, 0xE4, 0x56, 0x64, 0x90, 0xC1, 0xCB, 0x7B, 0x61, 0x84, 0x32, 0xD5, 0x70, 0xB6
	.byte 0x6C, 0x48, 0x74, 0x5C, 0xB8, 0xD0, 0x42, 0x57, 0x51, 0x50, 0xA7, 0xF4, 0x7E, 0x53, 0x65, 0x41
	.byte 0x1A, 0xC3, 0xA4, 0x17, 0x3A, 0x96, 0x5E, 0x27, 0x3B, 0xCB, 0x6B, 0xAB, 0x1F, 0xF1, 0x45, 0x9D
	.byte 0xAC, 0xAB, 0x58, 0xFA, 0x4B, 0x93, 0x03, 0xE3, 0x20, 0x55, 0xFA, 0x30, 0xAD, 0xF6, 0x6D, 0x76
	.byte 0x88, 0x91, 0x76, 0xCC, 0xF5, 0x25, 0x4C, 0x02, 0x4F, 0xFC, 0xD7, 0xE5, 0xC5, 0xD7, 0xCB, 0x2A
	.byte 0x26, 0x80, 0x44, 0x35, 0xB5, 0x8F, 0xA3, 0x62, 0xDE, 0x49, 0x5A, 0xB1, 0x25, 0x67, 0x1B, 0xBA
	.byte 0x45, 0x98, 0x0E, 0xEA, 0x5D, 0xE1, 0xC0, 0xFE, 0xC3, 0x02, 0x75, 0x2F, 0x81, 0x12, 0xF0, 0x4C
	.byte 0x8D, 0xA3, 0x97, 0x46, 0x6B, 0xC6, 0xF9, 0xD3, 0x03, 0xE7, 0x5F, 0x8F, 0x15, 0x95, 0x9C, 0x92
	.byte 0xBF, 0xEB, 0x7A, 0x6D, 0x95, 0xDA, 0x59, 0x52, 0xD4, 0x2D, 0x83, 0xBE, 0x58, 0xD3, 0x21, 0x74
	.byte 0x49, 0x29, 0x69, 0xE0, 0x8E, 0x44, 0xC8, 0xC9, 0x75, 0x6A, 0x89, 0xC2, 0xF4, 0x78, 0x79, 0x8E
	.byte 0x99, 0x6B, 0x3E, 0x58, 0x27, 0xDD, 0x71, 0xB9, 0xBE, 0xB6, 0x4F, 0xE1, 0xF0, 0x17, 0xAD, 0x88
	.byte 0xC9, 0x66, 0xAC, 0x20, 0x7D, 0xB4, 0x3A, 0xCE, 0x63, 0x18, 0x4A, 0xDF, 0xE5, 0x82, 0x31, 0x1A
	.byte 0x97, 0x60, 0x33, 0x51, 0x62, 0x45, 0x7F, 0x53, 0xB1, 0xE0, 0x77, 0x64, 0xBB, 0x84, 0xAE, 0x6B
	.byte 0xFE, 0x1C, 0xA0, 0x81, 0xF9, 0x94, 0x2B, 0x08, 0x70, 0x58, 0x68, 0x48, 0x8F, 0x19, 0xFD, 0x45
	.byte 0x94, 0x87, 0x6C, 0xDE, 0x52, 0xB7, 0xF8, 0x7B, 0xAB, 0x23, 0xD3, 0x73, 0x72, 0xE2, 0x02, 0x4B
	.byte 0xE3, 0x57, 0x8F, 0x1F, 0x66, 0x2A, 0xAB, 0x55, 0xB2, 0x07, 0x28, 0xEB, 0x2F, 0x03, 0xC2, 0xB5
	.byte 0x86, 0x9A, 0x7B, 0xC5, 0xD3, 0xA5, 0x08, 0x37, 0x30, 0xF2, 0x87, 0x28, 0x23, 0xB2, 0xA5, 0xBF
	.byte 0x02, 0xBA, 0x6A, 0x03, 0xED, 0x5C, 0x82, 0x16, 0x8A, 0x2B, 0x1C, 0xCF, 0xA7, 0x92, 0xB4, 0x79
	.byte 0xF3, 0xF0, 0xF2, 0x07, 0x4E, 0xA1, 0xE2, 0x69, 0x65, 0xCD, 0xF4, 0xDA, 0x06, 0xD5, 0xBE, 0x05
	.byte 0xD1, 0x1F, 0x62, 0x34, 0xC4, 0x8A, 0xFE, 0xA6, 0x34, 0x9D, 0x53, 0x2E, 0xA2, 0xA0, 0x55, 0xF3
	.byte 0x05, 0x32, 0xE1, 0x8A, 0xA4, 0x75, 0xEB, 0xF6, 0x0B, 0x39, 0xEC, 0x83, 0x40, 0xAA, 0xEF, 0x60
	.byte 0x5E, 0x06, 0x9F, 0x71, 0xBD, 0x51, 0x10, 0x6E, 0x3E, 0xF9, 0x8A, 0x21, 0x96, 0x3D, 0x06, 0xDD
	.byte 0xDD, 0xAE, 0x05, 0x3E, 0x4D, 0x46, 0xBD, 0xE6, 0x91, 0xB5, 0x8D, 0x54, 0x71, 0x05, 0x5D, 0xC4
	.byte 0x04, 0x6F, 0xD4, 0x06, 0x60, 0xFF, 0x15, 0x50, 0x19, 0x24, 0xFB, 0x98, 0xD6, 0x97, 0xE9, 0xBD
	.byte 0x89, 0xCC, 0x43, 0x40, 0x67, 0x77, 0x9E, 0xD9, 0xB0, 0xBD, 0x42, 0xE8, 0x07, 0x88, 0x8B, 0x89
	.byte 0xE7, 0x38, 0x5B, 0x19, 0x79, 0xDB, 0xEE, 0xC8, 0xA1, 0x47, 0x0A, 0x7C, 0x7C, 0xE9, 0x0F, 0x42
	.byte 0xF8, 0xC9, 0x1E, 0x84, 0x00, 0x00, 0x00, 0x00, 0x09, 0x83, 0x86, 0x80, 0x32, 0x48, 0xED, 0x2B
	.byte 0x1E, 0xAC, 0x70, 0x11, 0x6C, 0x4E, 0x72, 0x5A, 0xFD, 0xFB, 0xFF, 0x0E, 0x0F, 0x56, 0x38, 0x85
	.byte 0x3D, 0x1E, 0xD5, 0xAE, 0x36, 0x27, 0x39, 0x2D, 0x0A, 0x64, 0xD9, 0x0F, 0x68, 0x21, 0xA6, 0x5C
	.byte 0x9B, 0xD1, 0x54, 0x5B, 0x24, 0x3A, 0x2E, 0x36, 0x0C, 0xB1, 0x67, 0x0A, 0x93, 0x0F, 0xE7, 0x57
	.byte 0xB4, 0xD2, 0x96, 0xEE, 0x1B, 0x9E, 0x91, 0x9B, 0x80, 0x4F, 0xC5, 0xC0, 0x61, 0xA2, 0x20, 0xDC
	.byte 0x5A, 0x69, 0x4B, 0x77, 0x1C, 0x16, 0x1A, 0x12, 0xE2, 0x0A, 0xBA, 0x93, 0xC0, 0xE5, 0x2A, 0xA0
	.byte 0x3C, 0x43, 0xE0, 0x22, 0x12, 0x1D, 0x17, 0x1B, 0x0E, 0x0B, 0x0D, 0x09, 0xF2, 0xAD, 0xC7, 0x8B
	.byte 0x2D, 0xB9, 0xA8, 0xB6, 0x14, 0xC8, 0xA9, 0x1E, 0x57, 0x85, 0x19, 0xF1, 0xAF, 0x4C, 0x07, 0x75
	.byte 0xEE, 0xBB, 0xDD, 0x99, 0xA3, 0xFD, 0x60, 0x7F, 0xF7, 0x9F, 0x26, 0x01, 0x5C, 0xBC, 0xF5, 0x72
	.byte 0x44, 0xC5, 0x3B, 0x66, 0x5B, 0x34, 0x7E, 0xFB, 0x8B, 0x76, 0x29, 0x43, 0xCB, 0xDC, 0xC6, 0x23
	.byte 0xB6, 0x68, 0xFC, 0xED, 0xB8, 0x63, 0xF1, 0xE4, 0xD7, 0xCA, 0xDC, 0x31, 0x42, 0x10, 0x85, 0x63
	.byte 0x13, 0x40, 0x22, 0x97, 0x84, 0x20, 0x11, 0xC6, 0x85, 0x7D, 0x24, 0x4A, 0xD2, 0xF8, 0x3D, 0xBB
	.byte 0xAE, 0x11, 0x32, 0xF9, 0xC7, 0x6D, 0xA1, 0x29, 0x1D, 0x4B, 0x2F, 0x9E, 0xDC, 0xF3, 0x30, 0xB2
	.byte 0x0D, 0xEC, 0x52, 0x86, 0x77, 0xD0, 0xE3, 0xC1, 0x2B, 0x6C, 0x16, 0xB3, 0xA9, 0x99, 0xB9, 0x70
	.byte 0x11, 0xFA, 0x48, 0x94, 0x47, 0x22, 0x64, 0xE9, 0xA8, 0xC4, 0x8C, 0xFC, 0xA0, 0x1A, 0x3F, 0xF0
	.byte 0x56, 0xD8, 0x2C, 0x7D, 0x22, 0xEF, 0x90, 0x33, 0x87, 0xC7, 0x4E, 0x49, 0xD9, 0xC1, 0xD1, 0x38
	.byte 0x8C, 0xFE, 0xA2, 0xCA, 0x98, 0x36, 0x0B, 0xD4, 0xA6, 0xCF, 0x81, 0xF5, 0xA5, 0x28, 0xDE, 0x7A
	.byte 0xDA, 0x26, 0x8E, 0xB7, 0x3F, 0xA4, 0xBF, 0xAD, 0x2C, 0xE4, 0x9D, 0x3A, 0x50, 0x0D, 0x92, 0x78
	.byte 0x6A, 0x9B, 0xCC, 0x5F, 0x54, 0x62, 0x46, 0x7E, 0xF6, 0xC2, 0x13, 0x8D, 0x90, 0xE8, 0xB8, 0xD8
	.byte 0x2E, 0x5E, 0xF7, 0x39, 0x82, 0xF5, 0xAF, 0xC3, 0x9F, 0xBE, 0x80, 0x5D, 0x69, 0x7C, 0x93, 0xD0
	.byte 0x6F, 0xA9, 0x2D, 0xD5, 0xCF, 0xB3, 0x12, 0x25, 0xC8, 0x3B, 0x99, 0xAC, 0x10, 0xA7, 0x7D, 0x18
	.byte 0xE8, 0x6E, 0x63, 0x9C, 0xDB, 0x7B, 0xBB, 0x3B, 0xCD, 0x09, 0x78, 0x26, 0x6E, 0xF4, 0x18, 0x59
	.byte 0xEC, 0x01, 0xB7, 0x9A, 0x83, 0xA8, 0x9A, 0x4F, 0xE6, 0x65, 0x6E, 0x95, 0xAA, 0x7E, 0xE6, 0xFF
	.byte 0x21, 0x08, 0xCF, 0xBC, 0xEF, 0xE6, 0xE8, 0x15, 0xBA, 0xD9, 0x9B, 0xE7, 0x4A, 0xCE, 0x36, 0x6F
	.byte 0xEA, 0xD4, 0x09, 0x9F, 0x29, 0xD6, 0x7C, 0xB0, 0x31, 0xAF, 0xB2, 0xA4, 0x2A, 0x31, 0x23, 0x3F
	.byte 0xC6, 0x30, 0x94, 0xA5, 0x35, 0xC0, 0x66, 0xA2, 0x74, 0x37, 0xBC, 0x4E, 0xFC, 0xA6, 0xCA, 0x82
	.byte 0xE0, 0xB0, 0xD0, 0x90, 0x33, 0x15, 0xD8, 0xA7, 0xF1, 0x4A, 0x98, 0x04, 0x41, 0xF7, 0xDA, 0xEC
	.byte 0x7F, 0x0E, 0x50, 0xCD, 0x17, 0x2F, 0xF6, 0x91, 0x76, 0x8D, 0xD6, 0x4D, 0x43, 0x4D, 0xB0, 0xEF
	.byte 0xCC, 0x54, 0x4D, 0xAA, 0xE4, 0xDF, 0x04, 0x96, 0x9E, 0xE3, 0xB5, 0xD1, 0x4C, 0x1B, 0x88, 0x6A
	.byte 0xC1, 0xB8, 0x1F, 0x2C, 0x46, 0x7F, 0x51, 0x65, 0x9D, 0x04, 0xEA, 0x5E, 0x01, 0x5D, 0x35, 0x8C
	.byte 0xFA, 0x73, 0x74, 0x87, 0xFB, 0x2E, 0x41, 0x0B, 0xB3, 0x5A, 0x1D, 0x67, 0x92, 0x52, 0xD2, 0xDB
	.byte 0xE9, 0x33, 0x56, 0x10, 0x6D, 0x13, 0x47, 0xD6, 0x9A, 0x8C, 0x61, 0xD7, 0x37, 0x7A, 0x0C, 0xA1
	.byte 0x59, 0x8E, 0x14, 0xF8, 0xEB, 0x89, 0x3C, 0x13, 0xCE, 0xEE, 0x27, 0xA9, 0xB7, 0x35, 0xC9, 0x61
	.byte 0xE1, 0xED, 0xE5, 0x1C, 0x7A, 0x3C, 0xB1, 0x47, 0x9C, 0x59, 0xDF, 0xD2, 0x55, 0x3F, 0x73, 0xF2
	.byte 0x18, 0x79, 0xCE, 0x14, 0x73, 0xBF, 0x37, 0xC7, 0x53, 0xEA, 0xCD, 0xF7, 0x5F, 0x5B, 0xAA, 0xFD
	.byte 0xDF, 0x14, 0x6F, 0x3D, 0x78, 0x86, 0xDB, 0x44, 0xCA, 0x81, 0xF3, 0xAF, 0xB9, 0x3E, 0xC4, 0x68
	.byte 0x38, 0x2C, 0x34, 0x24, 0xC2, 0x5F, 0x40, 0xA3, 0x16, 0x72, 0xC3, 0x1D, 0xBC, 0x0C, 0x25, 0xE2
	.byte 0x28, 0x8B, 0x49, 0x3C, 0xFF, 0x41, 0x95, 0x0D, 0x39, 0x71, 0x01, 0xA8, 0x08, 0xDE, 0xB3, 0x0C
	.byte 0xD8, 0x9C, 0xE4, 0xB4, 0x64, 0x90, 0xC1, 0x56, 0x7B, 0x61, 0x84, 0xCB, 0xD5, 0x70, 0xB6, 0x32
	.byte 0x48, 0x74, 0x5C, 0x6C, 0xD0, 0x42, 0x57, 0xB8, 0x52, 0x52, 0x52, 0x52, 0x09, 0x09, 0x09, 0x09
	.byte 0x6A, 0x6A, 0x6A, 0x6A, 0xD5, 0xD5, 0xD5, 0xD5, 0x30, 0x30, 0x30, 0x30, 0x36, 0x36, 0x36, 0x36
	.byte 0xA5, 0xA5, 0xA5, 0xA5, 0x38, 0x38, 0x38, 0x38, 0xBF, 0xBF, 0xBF, 0xBF, 0x40, 0x40, 0x40, 0x40
	.byte 0xA3, 0xA3, 0xA3, 0xA3, 0x9E, 0x9E, 0x9E, 0x9E, 0x81, 0x81, 0x81, 0x81, 0xF3, 0xF3, 0xF3, 0xF3
	.byte 0xD7, 0xD7, 0xD7, 0xD7, 0xFB, 0xFB, 0xFB, 0xFB, 0x7C, 0x7C, 0x7C, 0x7C, 0xE3, 0xE3, 0xE3, 0xE3
	.byte 0x39, 0x39, 0x39, 0x39, 0x82, 0x82, 0x82, 0x82, 0x9B, 0x9B, 0x9B, 0x9B, 0x2F, 0x2F, 0x2F, 0x2F
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0x87, 0x87, 0x87, 0x87, 0x34, 0x34, 0x34, 0x34, 0x8E, 0x8E, 0x8E, 0x8E
	.byte 0x43, 0x43, 0x43, 0x43, 0x44, 0x44, 0x44, 0x44, 0xC4, 0xC4, 0xC4, 0xC4, 0xDE, 0xDE, 0xDE, 0xDE
	.byte 0xE9, 0xE9, 0xE9, 0xE9, 0xCB, 0xCB, 0xCB, 0xCB, 0x54, 0x54, 0x54, 0x54, 0x7B, 0x7B, 0x7B, 0x7B
	.byte 0x94, 0x94, 0x94, 0x94, 0x32, 0x32, 0x32, 0x32, 0xA6, 0xA6, 0xA6, 0xA6, 0xC2, 0xC2, 0xC2, 0xC2
	.byte 0x23, 0x23, 0x23, 0x23, 0x3D, 0x3D, 0x3D, 0x3D, 0xEE, 0xEE, 0xEE, 0xEE, 0x4C, 0x4C, 0x4C, 0x4C
	.byte 0x95, 0x95, 0x95, 0x95, 0x0B, 0x0B, 0x0B, 0x0B, 0x42, 0x42, 0x42, 0x42, 0xFA, 0xFA, 0xFA, 0xFA
	.byte 0xC3, 0xC3, 0xC3, 0xC3, 0x4E, 0x4E, 0x4E, 0x4E, 0x08, 0x08, 0x08, 0x08, 0x2E, 0x2E, 0x2E, 0x2E
	.byte 0xA1, 0xA1, 0xA1, 0xA1, 0x66, 0x66, 0x66, 0x66, 0x28, 0x28, 0x28, 0x28, 0xD9, 0xD9, 0xD9, 0xD9
	.byte 0x24, 0x24, 0x24, 0x24, 0xB2, 0xB2, 0xB2, 0xB2, 0x76, 0x76, 0x76, 0x76, 0x5B, 0x5B, 0x5B, 0x5B
	.byte 0xA2, 0xA2, 0xA2, 0xA2, 0x49, 0x49, 0x49, 0x49, 0x6D, 0x6D, 0x6D, 0x6D, 0x8B, 0x8B, 0x8B, 0x8B
	.byte 0xD1, 0xD1, 0xD1, 0xD1, 0x25, 0x25, 0x25, 0x25, 0x72, 0x72, 0x72, 0x72, 0xF8, 0xF8, 0xF8, 0xF8
	.byte 0xF6, 0xF6, 0xF6, 0xF6, 0x64, 0x64, 0x64, 0x64, 0x86, 0x86, 0x86, 0x86, 0x68, 0x68, 0x68, 0x68
	.byte 0x98, 0x98, 0x98, 0x98, 0x16, 0x16, 0x16, 0x16, 0xD4, 0xD4, 0xD4, 0xD4, 0xA4, 0xA4, 0xA4, 0xA4
	.byte 0x5C, 0x5C, 0x5C, 0x5C, 0xCC, 0xCC, 0xCC, 0xCC, 0x5D, 0x5D, 0x5D, 0x5D, 0x65, 0x65, 0x65, 0x65
	.byte 0xB6, 0xB6, 0xB6, 0xB6, 0x92, 0x92, 0x92, 0x92, 0x6C, 0x6C, 0x6C, 0x6C, 0x70, 0x70, 0x70, 0x70
	.byte 0x48, 0x48, 0x48, 0x48, 0x50, 0x50, 0x50, 0x50, 0xFD, 0xFD, 0xFD, 0xFD, 0xED, 0xED, 0xED, 0xED
	.byte 0xB9, 0xB9, 0xB9, 0xB9, 0xDA, 0xDA, 0xDA, 0xDA, 0x5E, 0x5E, 0x5E, 0x5E, 0x15, 0x15, 0x15, 0x15
	.byte 0x46, 0x46, 0x46, 0x46, 0x57, 0x57, 0x57, 0x57, 0xA7, 0xA7, 0xA7, 0xA7, 0x8D, 0x8D, 0x8D, 0x8D
	.byte 0x9D, 0x9D, 0x9D, 0x9D, 0x84, 0x84, 0x84, 0x84, 0x90, 0x90, 0x90, 0x90, 0xD8, 0xD8, 0xD8, 0xD8
	.byte 0xAB, 0xAB, 0xAB, 0xAB, 0x00, 0x00, 0x00, 0x00, 0x8C, 0x8C, 0x8C, 0x8C, 0xBC, 0xBC, 0xBC, 0xBC
	.byte 0xD3, 0xD3, 0xD3, 0xD3, 0x0A, 0x0A, 0x0A, 0x0A, 0xF7, 0xF7, 0xF7, 0xF7, 0xE4, 0xE4, 0xE4, 0xE4
	.byte 0x58, 0x58, 0x58, 0x58, 0x05, 0x05, 0x05, 0x05, 0xB8, 0xB8, 0xB8, 0xB8, 0xB3, 0xB3, 0xB3, 0xB3
	.byte 0x45, 0x45, 0x45, 0x45, 0x06, 0x06, 0x06, 0x06, 0xD0, 0xD0, 0xD0, 0xD0, 0x2C, 0x2C, 0x2C, 0x2C
	.byte 0x1E, 0x1E, 0x1E, 0x1E, 0x8F, 0x8F, 0x8F, 0x8F, 0xCA, 0xCA, 0xCA, 0xCA, 0x3F, 0x3F, 0x3F, 0x3F
	.byte 0x0F, 0x0F, 0x0F, 0x0F, 0x02, 0x02, 0x02, 0x02, 0xC1, 0xC1, 0xC1, 0xC1, 0xAF, 0xAF, 0xAF, 0xAF
	.byte 0xBD, 0xBD, 0xBD, 0xBD, 0x03, 0x03, 0x03, 0x03, 0x01, 0x01, 0x01, 0x01, 0x13, 0x13, 0x13, 0x13
	.byte 0x8A, 0x8A, 0x8A, 0x8A, 0x6B, 0x6B, 0x6B, 0x6B, 0x3A, 0x3A, 0x3A, 0x3A, 0x91, 0x91, 0x91, 0x91
	.byte 0x11, 0x11, 0x11, 0x11, 0x41, 0x41, 0x41, 0x41, 0x4F, 0x4F, 0x4F, 0x4F, 0x67, 0x67, 0x67, 0x67
	.byte 0xDC, 0xDC, 0xDC, 0xDC, 0xEA, 0xEA, 0xEA, 0xEA, 0x97, 0x97, 0x97, 0x97, 0xF2, 0xF2, 0xF2, 0xF2
	.byte 0xCF, 0xCF, 0xCF, 0xCF, 0xCE, 0xCE, 0xCE, 0xCE, 0xF0, 0xF0, 0xF0, 0xF0, 0xB4, 0xB4, 0xB4, 0xB4
	.byte 0xE6, 0xE6, 0xE6, 0xE6, 0x73, 0x73, 0x73, 0x73, 0x96, 0x96, 0x96, 0x96, 0xAC, 0xAC, 0xAC, 0xAC
	.byte 0x74, 0x74, 0x74, 0x74, 0x22, 0x22, 0x22, 0x22, 0xE7, 0xE7, 0xE7, 0xE7, 0xAD, 0xAD, 0xAD, 0xAD
	.byte 0x35, 0x35, 0x35, 0x35, 0x85, 0x85, 0x85, 0x85, 0xE2, 0xE2, 0xE2, 0xE2, 0xF9, 0xF9, 0xF9, 0xF9
	.byte 0x37, 0x37, 0x37, 0x37, 0xE8, 0xE8, 0xE8, 0xE8, 0x1C, 0x1C, 0x1C, 0x1C, 0x75, 0x75, 0x75, 0x75
	.byte 0xDF, 0xDF, 0xDF, 0xDF, 0x6E, 0x6E, 0x6E, 0x6E, 0x47, 0x47, 0x47, 0x47, 0xF1, 0xF1, 0xF1, 0xF1
	.byte 0x1A, 0x1A, 0x1A, 0x1A, 0x71, 0x71, 0x71, 0x71, 0x1D, 0x1D, 0x1D, 0x1D, 0x29, 0x29, 0x29, 0x29
	.byte 0xC5, 0xC5, 0xC5, 0xC5, 0x89, 0x89, 0x89, 0x89, 0x6F, 0x6F, 0x6F, 0x6F, 0xB7, 0xB7, 0xB7, 0xB7
	.byte 0x62, 0x62, 0x62, 0x62, 0x0E, 0x0E, 0x0E, 0x0E, 0xAA, 0xAA, 0xAA, 0xAA, 0x18, 0x18, 0x18, 0x18
	.byte 0xBE, 0xBE, 0xBE, 0xBE, 0x1B, 0x1B, 0x1B, 0x1B, 0xFC, 0xFC, 0xFC, 0xFC, 0x56, 0x56, 0x56, 0x56
	.byte 0x3E, 0x3E, 0x3E, 0x3E, 0x4B, 0x4B, 0x4B, 0x4B, 0xC6, 0xC6, 0xC6, 0xC6, 0xD2, 0xD2, 0xD2, 0xD2
	.byte 0x79, 0x79, 0x79, 0x79, 0x20, 0x20, 0x20, 0x20, 0x9A, 0x9A, 0x9A, 0x9A, 0xDB, 0xDB, 0xDB, 0xDB
	.byte 0xC0, 0xC0, 0xC0, 0xC0, 0xFE, 0xFE, 0xFE, 0xFE, 0x78, 0x78, 0x78, 0x78, 0xCD, 0xCD, 0xCD, 0xCD
	.byte 0x5A, 0x5A, 0x5A, 0x5A, 0xF4, 0xF4, 0xF4, 0xF4, 0x1F, 0x1F, 0x1F, 0x1F, 0xDD, 0xDD, 0xDD, 0xDD
	.byte 0xA8, 0xA8, 0xA8, 0xA8, 0x33, 0x33, 0x33, 0x33, 0x88, 0x88, 0x88, 0x88, 0x07, 0x07, 0x07, 0x07
	.byte 0xC7, 0xC7, 0xC7, 0xC7, 0x31, 0x31, 0x31, 0x31, 0xB1, 0xB1, 0xB1, 0xB1, 0x12, 0x12, 0x12, 0x12
	.byte 0x10, 0x10, 0x10, 0x10, 0x59, 0x59, 0x59, 0x59, 0x27, 0x27, 0x27, 0x27, 0x80, 0x80, 0x80, 0x80
	.byte 0xEC, 0xEC, 0xEC, 0xEC, 0x5F, 0x5F, 0x5F, 0x5F, 0x60, 0x60, 0x60, 0x60, 0x51, 0x51, 0x51, 0x51
	.byte 0x7F, 0x7F, 0x7F, 0x7F, 0xA9, 0xA9, 0xA9, 0xA9, 0x19, 0x19, 0x19, 0x19, 0xB5, 0xB5, 0xB5, 0xB5
	.byte 0x4A, 0x4A, 0x4A, 0x4A, 0x0D, 0x0D, 0x0D, 0x0D, 0x2D, 0x2D, 0x2D, 0x2D, 0xE5, 0xE5, 0xE5, 0xE5
	.byte 0x7A, 0x7A, 0x7A, 0x7A, 0x9F, 0x9F, 0x9F, 0x9F, 0x93, 0x93, 0x93, 0x93, 0xC9, 0xC9, 0xC9, 0xC9
	.byte 0x9C, 0x9C, 0x9C, 0x9C, 0xEF, 0xEF, 0xEF, 0xEF, 0xA0, 0xA0, 0xA0, 0xA0, 0xE0, 0xE0, 0xE0, 0xE0
	.byte 0x3B, 0x3B, 0x3B, 0x3B, 0x4D, 0x4D, 0x4D, 0x4D, 0xAE, 0xAE, 0xAE, 0xAE, 0x2A, 0x2A, 0x2A, 0x2A
	.byte 0xF5, 0xF5, 0xF5, 0xF5, 0xB0, 0xB0, 0xB0, 0xB0, 0xC8, 0xC8, 0xC8, 0xC8, 0xEB, 0xEB, 0xEB, 0xEB
	.byte 0xBB, 0xBB, 0xBB, 0xBB, 0x3C, 0x3C, 0x3C, 0x3C, 0x83, 0x83, 0x83, 0x83, 0x53, 0x53, 0x53, 0x53
	.byte 0x99, 0x99, 0x99, 0x99, 0x61, 0x61, 0x61, 0x61, 0x17, 0x17, 0x17, 0x17, 0x2B, 0x2B, 0x2B, 0x2B
	.byte 0x04, 0x04, 0x04, 0x04, 0x7E, 0x7E, 0x7E, 0x7E, 0xBA, 0xBA, 0xBA, 0xBA, 0x77, 0x77, 0x77, 0x77
	.byte 0xD6, 0xD6, 0xD6, 0xD6, 0x26, 0x26, 0x26, 0x26, 0xE1, 0xE1, 0xE1, 0xE1, 0x69, 0x69, 0x69, 0x69
	.byte 0x14, 0x14, 0x14, 0x14, 0x63, 0x63, 0x63, 0x63, 0x55, 0x55, 0x55, 0x55, 0x21, 0x21, 0x21, 0x21
	.byte 0x0C, 0x0C, 0x0C, 0x0C, 0x7D, 0x7D, 0x7D, 0x7D, 0xA5, 0x63, 0x63, 0xC6, 0x84, 0x7C, 0x7C, 0xF8
	.byte 0x99, 0x77, 0x77, 0xEE, 0x8D, 0x7B, 0x7B, 0xF6, 0x0D, 0xF2, 0xF2, 0xFF, 0xBD, 0x6B, 0x6B, 0xD6
	.byte 0xB1, 0x6F, 0x6F, 0xDE, 0x54, 0xC5, 0xC5, 0x91, 0x50, 0x30, 0x30, 0x60, 0x03, 0x01, 0x01, 0x02
	.byte 0xA9, 0x67, 0x67, 0xCE, 0x7D, 0x2B, 0x2B, 0x56, 0x19, 0xFE, 0xFE, 0xE7, 0x62, 0xD7, 0xD7, 0xB5
	.byte 0xE6, 0xAB, 0xAB, 0x4D, 0x9A, 0x76, 0x76, 0xEC, 0x45, 0xCA, 0xCA, 0x8F, 0x9D, 0x82, 0x82, 0x1F
	.byte 0x40, 0xC9, 0xC9, 0x89, 0x87, 0x7D, 0x7D, 0xFA, 0x15, 0xFA, 0xFA, 0xEF, 0xEB, 0x59, 0x59, 0xB2
	.byte 0xC9, 0x47, 0x47, 0x8E, 0x0B, 0xF0, 0xF0, 0xFB, 0xEC, 0xAD, 0xAD, 0x41, 0x67, 0xD4, 0xD4, 0xB3
	.byte 0xFD, 0xA2, 0xA2, 0x5F, 0xEA, 0xAF, 0xAF, 0x45, 0xBF, 0x9C, 0x9C, 0x23, 0xF7, 0xA4, 0xA4, 0x53
	.byte 0x96, 0x72, 0x72, 0xE4, 0x5B, 0xC0, 0xC0, 0x9B, 0xC2, 0xB7, 0xB7, 0x75, 0x1C, 0xFD, 0xFD, 0xE1
	.byte 0xAE, 0x93, 0x93, 0x3D, 0x6A, 0x26, 0x26, 0x4C, 0x5A, 0x36, 0x36, 0x6C, 0x41, 0x3F, 0x3F, 0x7E
	.byte 0x02, 0xF7, 0xF7, 0xF5, 0x4F, 0xCC, 0xCC, 0x83, 0x5C, 0x34, 0x34, 0x68, 0xF4, 0xA5, 0xA5, 0x51
	.byte 0x34, 0xE5, 0xE5, 0xD1, 0x08, 0xF1, 0xF1, 0xF9, 0x93, 0x71, 0x71, 0xE2, 0x73, 0xD8, 0xD8, 0xAB
	.byte 0x53, 0x31, 0x31, 0x62, 0x3F, 0x15, 0x15, 0x2A, 0x0C, 0x04, 0x04, 0x08, 0x52, 0xC7, 0xC7, 0x95
	.byte 0x65, 0x23, 0x23, 0x46, 0x5E, 0xC3, 0xC3, 0x9D, 0x28, 0x18, 0x18, 0x30, 0xA1, 0x96, 0x96, 0x37
	.byte 0x0F, 0x05, 0x05, 0x0A, 0xB5, 0x9A, 0x9A, 0x2F, 0x09, 0x07, 0x07, 0x0E, 0x36, 0x12, 0x12, 0x24
	.byte 0x9B, 0x80, 0x80, 0x1B, 0x3D, 0xE2, 0xE2, 0xDF, 0x26, 0xEB, 0xEB, 0xCD, 0x69, 0x27, 0x27, 0x4E
	.byte 0xCD, 0xB2, 0xB2, 0x7F, 0x9F, 0x75, 0x75, 0xEA, 0x1B, 0x09, 0x09, 0x12, 0x9E, 0x83, 0x83, 0x1D
	.byte 0x74, 0x2C, 0x2C, 0x58, 0x2E, 0x1A, 0x1A, 0x34, 0x2D, 0x1B, 0x1B, 0x36, 0xB2, 0x6E, 0x6E, 0xDC
	.byte 0xEE, 0x5A, 0x5A, 0xB4, 0xFB, 0xA0, 0xA0, 0x5B, 0xF6, 0x52, 0x52, 0xA4, 0x4D, 0x3B, 0x3B, 0x76
	.byte 0x61, 0xD6, 0xD6, 0xB7, 0xCE, 0xB3, 0xB3, 0x7D, 0x7B, 0x29, 0x29, 0x52, 0x3E, 0xE3, 0xE3, 0xDD
	.byte 0x71, 0x2F, 0x2F, 0x5E, 0x97, 0x84, 0x84, 0x13, 0xF5, 0x53, 0x53, 0xA6, 0x68, 0xD1, 0xD1, 0xB9
	.byte 0x00, 0x00, 0x00, 0x00, 0x2C, 0xED, 0xED, 0xC1, 0x60, 0x20, 0x20, 0x40, 0x1F, 0xFC, 0xFC, 0xE3
	.byte 0xC8, 0xB1, 0xB1, 0x79, 0xED, 0x5B, 0x5B, 0xB6, 0xBE, 0x6A, 0x6A, 0xD4, 0x46, 0xCB, 0xCB, 0x8D
	.byte 0xD9, 0xBE, 0xBE, 0x67, 0x4B, 0x39, 0x39, 0x72, 0xDE, 0x4A, 0x4A, 0x94, 0xD4, 0x4C, 0x4C, 0x98
	.byte 0xE8, 0x58, 0x58, 0xB0, 0x4A, 0xCF, 0xCF, 0x85, 0x6B, 0xD0, 0xD0, 0xBB, 0x2A, 0xEF, 0xEF, 0xC5
	.byte 0xE5, 0xAA, 0xAA, 0x4F, 0x16, 0xFB, 0xFB, 0xED, 0xC5, 0x43, 0x43, 0x86, 0xD7, 0x4D, 0x4D, 0x9A
	.byte 0x55, 0x33, 0x33, 0x66, 0x94, 0x85, 0x85, 0x11, 0xCF, 0x45, 0x45, 0x8A, 0x10, 0xF9, 0xF9, 0xE9
	.byte 0x06, 0x02, 0x02, 0x04, 0x81, 0x7F, 0x7F, 0xFE, 0xF0, 0x50, 0x50, 0xA0, 0x44, 0x3C, 0x3C, 0x78
	.byte 0xBA, 0x9F, 0x9F, 0x25, 0xE3, 0xA8, 0xA8, 0x4B, 0xF3, 0x51, 0x51, 0xA2, 0xFE, 0xA3, 0xA3, 0x5D
	.byte 0xC0, 0x40, 0x40, 0x80, 0x8A, 0x8F, 0x8F, 0x05, 0xAD, 0x92, 0x92, 0x3F, 0xBC, 0x9D, 0x9D, 0x21
	.byte 0x48, 0x38, 0x38, 0x70, 0x04, 0xF5, 0xF5, 0xF1, 0xDF, 0xBC, 0xBC, 0x63, 0xC1, 0xB6, 0xB6, 0x77
	.byte 0x75, 0xDA, 0xDA, 0xAF, 0x63, 0x21, 0x21, 0x42, 0x30, 0x10, 0x10, 0x20, 0x1A, 0xFF, 0xFF, 0xE5
	.byte 0x0E, 0xF3, 0xF3, 0xFD, 0x6D, 0xD2, 0xD2, 0xBF, 0x4C, 0xCD, 0xCD, 0x81, 0x14, 0x0C, 0x0C, 0x18
	.byte 0x35, 0x13, 0x13, 0x26, 0x2F, 0xEC, 0xEC, 0xC3, 0xE1, 0x5F, 0x5F, 0xBE, 0xA2, 0x97, 0x97, 0x35
	.byte 0xCC, 0x44, 0x44, 0x88, 0x39, 0x17, 0x17, 0x2E, 0x57, 0xC4, 0xC4, 0x93, 0xF2, 0xA7, 0xA7, 0x55
	.byte 0x82, 0x7E, 0x7E, 0xFC, 0x47, 0x3D, 0x3D, 0x7A, 0xAC, 0x64, 0x64, 0xC8, 0xE7, 0x5D, 0x5D, 0xBA
	.byte 0x2B, 0x19, 0x19, 0x32, 0x95, 0x73, 0x73, 0xE6, 0xA0, 0x60, 0x60, 0xC0, 0x98, 0x81, 0x81, 0x19
	.byte 0xD1, 0x4F, 0x4F, 0x9E, 0x7F, 0xDC, 0xDC, 0xA3, 0x66, 0x22, 0x22, 0x44, 0x7E, 0x2A, 0x2A, 0x54
	.byte 0xAB, 0x90, 0x90, 0x3B, 0x83, 0x88, 0x88, 0x0B, 0xCA, 0x46, 0x46, 0x8C, 0x29, 0xEE, 0xEE, 0xC7
	.byte 0xD3, 0xB8, 0xB8, 0x6B, 0x3C, 0x14, 0x14, 0x28, 0x79, 0xDE, 0xDE, 0xA7, 0xE2, 0x5E, 0x5E, 0xBC
	.byte 0x1D, 0x0B, 0x0B, 0x16, 0x76, 0xDB, 0xDB, 0xAD, 0x3B, 0xE0, 0xE0, 0xDB, 0x56, 0x32, 0x32, 0x64
	.byte 0x4E, 0x3A, 0x3A, 0x74, 0x1E, 0x0A, 0x0A, 0x14, 0xDB, 0x49, 0x49, 0x92, 0x0A, 0x06, 0x06, 0x0C
	.byte 0x6C, 0x24, 0x24, 0x48, 0xE4, 0x5C, 0x5C, 0xB8, 0x5D, 0xC2, 0xC2, 0x9F, 0x6E, 0xD3, 0xD3, 0xBD
	.byte 0xEF, 0xAC, 0xAC, 0x43, 0xA6, 0x62, 0x62, 0xC4, 0xA8, 0x91, 0x91, 0x39, 0xA4, 0x95, 0x95, 0x31
	.byte 0x37, 0xE4, 0xE4, 0xD3, 0x8B, 0x79, 0x79, 0xF2, 0x32, 0xE7, 0xE7, 0xD5, 0x43, 0xC8, 0xC8, 0x8B
	.byte 0x59, 0x37, 0x37, 0x6E, 0xB7, 0x6D, 0x6D, 0xDA, 0x8C, 0x8D, 0x8D, 0x01, 0x64, 0xD5, 0xD5, 0xB1
	.byte 0xD2, 0x4E, 0x4E, 0x9C, 0xE0, 0xA9, 0xA9, 0x49, 0xB4, 0x6C, 0x6C, 0xD8, 0xFA, 0x56, 0x56, 0xAC
	.byte 0x07, 0xF4, 0xF4, 0xF3, 0x25, 0xEA, 0xEA, 0xCF, 0xAF, 0x65, 0x65, 0xCA, 0x8E, 0x7A, 0x7A, 0xF4
	.byte 0xE9, 0xAE, 0xAE, 0x47, 0x18, 0x08, 0x08, 0x10, 0xD5, 0xBA, 0xBA, 0x6F, 0x88, 0x78, 0x78, 0xF0
	.byte 0x6F, 0x25, 0x25, 0x4A, 0x72, 0x2E, 0x2E, 0x5C, 0x24, 0x1C, 0x1C, 0x38, 0xF1, 0xA6, 0xA6, 0x57
	.byte 0xC7, 0xB4, 0xB4, 0x73, 0x51, 0xC6, 0xC6, 0x97, 0x23, 0xE8, 0xE8, 0xCB, 0x7C, 0xDD, 0xDD, 0xA1
	.byte 0x9C, 0x74, 0x74, 0xE8, 0x21, 0x1F, 0x1F, 0x3E, 0xDD, 0x4B, 0x4B, 0x96, 0xDC, 0xBD, 0xBD, 0x61
	.byte 0x86, 0x8B, 0x8B, 0x0D, 0x85, 0x8A, 0x8A, 0x0F, 0x90, 0x70, 0x70, 0xE0, 0x42, 0x3E, 0x3E, 0x7C
	.byte 0xC4, 0xB5, 0xB5, 0x71, 0xAA, 0x66, 0x66, 0xCC, 0xD8, 0x48, 0x48, 0x90, 0x05, 0x03, 0x03, 0x06
	.byte 0x01, 0xF6, 0xF6, 0xF7, 0x12, 0x0E, 0x0E, 0x1C, 0xA3, 0x61, 0x61, 0xC2, 0x5F, 0x35, 0x35, 0x6A
	.byte 0xF9, 0x57, 0x57, 0xAE, 0xD0, 0xB9, 0xB9, 0x69, 0x91, 0x86, 0x86, 0x17, 0x58, 0xC1, 0xC1, 0x99
	.byte 0x27, 0x1D, 0x1D, 0x3A, 0xB9, 0x9E, 0x9E, 0x27, 0x38, 0xE1, 0xE1, 0xD9, 0x13, 0xF8, 0xF8, 0xEB
	.byte 0xB3, 0x98, 0x98, 0x2B, 0x33, 0x11, 0x11, 0x22, 0xBB, 0x69, 0x69, 0xD2, 0x70, 0xD9, 0xD9, 0xA9
	.byte 0x89, 0x8E, 0x8E, 0x07, 0xA7, 0x94, 0x94, 0x33, 0xB6, 0x9B, 0x9B, 0x2D, 0x22, 0x1E, 0x1E, 0x3C
	.byte 0x92, 0x87, 0x87, 0x15, 0x20, 0xE9, 0xE9, 0xC9, 0x49, 0xCE, 0xCE, 0x87, 0xFF, 0x55, 0x55, 0xAA
	.byte 0x78, 0x28, 0x28, 0x50, 0x7A, 0xDF, 0xDF, 0xA5, 0x8F, 0x8C, 0x8C, 0x03, 0xF8, 0xA1, 0xA1, 0x59
	.byte 0x80, 0x89, 0x89, 0x09, 0x17, 0x0D, 0x0D, 0x1A, 0xDA, 0xBF, 0xBF, 0x65, 0x31, 0xE6, 0xE6, 0xD7
	.byte 0xC6, 0x42, 0x42, 0x84, 0xB8, 0x68, 0x68, 0xD0, 0xC3, 0x41, 0x41, 0x82, 0xB0, 0x99, 0x99, 0x29
	.byte 0x77, 0x2D, 0x2D, 0x5A, 0x11, 0x0F, 0x0F, 0x1E, 0xCB, 0xB0, 0xB0, 0x7B, 0xFC, 0x54, 0x54, 0xA8
	.byte 0xD6, 0xBB, 0xBB, 0x6D, 0x3A, 0x16, 0x16, 0x2C, 0x63, 0x63, 0xC6, 0xA5, 0x7C, 0x7C, 0xF8, 0x84
	.byte 0x77, 0x77, 0xEE, 0x99, 0x7B, 0x7B, 0xF6, 0x8D, 0xF2, 0xF2, 0xFF, 0x0D, 0x6B, 0x6B, 0xD6, 0xBD
	.byte 0x6F, 0x6F, 0xDE, 0xB1, 0xC5, 0xC5, 0x91, 0x54, 0x30, 0x30, 0x60, 0x50, 0x01, 0x01, 0x02, 0x03
	.byte 0x67, 0x67, 0xCE, 0xA9, 0x2B, 0x2B, 0x56, 0x7D, 0xFE, 0xFE, 0xE7, 0x19, 0xD7, 0xD7, 0xB5, 0x62
	.byte 0xAB, 0xAB, 0x4D, 0xE6, 0x76, 0x76, 0xEC, 0x9A, 0xCA, 0xCA, 0x8F, 0x45, 0x82, 0x82, 0x1F, 0x9D
	.byte 0xC9, 0xC9, 0x89, 0x40, 0x7D, 0x7D, 0xFA, 0x87, 0xFA, 0xFA, 0xEF, 0x15, 0x59, 0x59, 0xB2, 0xEB
	.byte 0x47, 0x47, 0x8E, 0xC9, 0xF0, 0xF0, 0xFB, 0x0B, 0xAD, 0xAD, 0x41, 0xEC, 0xD4, 0xD4, 0xB3, 0x67
	.byte 0xA2, 0xA2, 0x5F, 0xFD, 0xAF, 0xAF, 0x45, 0xEA, 0x9C, 0x9C, 0x23, 0xBF, 0xA4, 0xA4, 0x53, 0xF7
	.byte 0x72, 0x72, 0xE4, 0x96, 0xC0, 0xC0, 0x9B, 0x5B, 0xB7, 0xB7, 0x75, 0xC2, 0xFD, 0xFD, 0xE1, 0x1C
	.byte 0x93, 0x93, 0x3D, 0xAE, 0x26, 0x26, 0x4C, 0x6A, 0x36, 0x36, 0x6C, 0x5A, 0x3F, 0x3F, 0x7E, 0x41
	.byte 0xF7, 0xF7, 0xF5, 0x02, 0xCC, 0xCC, 0x83, 0x4F, 0x34, 0x34, 0x68, 0x5C, 0xA5, 0xA5, 0x51, 0xF4
	.byte 0xE5, 0xE5, 0xD1, 0x34, 0xF1, 0xF1, 0xF9, 0x08, 0x71, 0x71, 0xE2, 0x93, 0xD8, 0xD8, 0xAB, 0x73
	.byte 0x31, 0x31, 0x62, 0x53, 0x15, 0x15, 0x2A, 0x3F, 0x04, 0x04, 0x08, 0x0C, 0xC7, 0xC7, 0x95, 0x52
	.byte 0x23, 0x23, 0x46, 0x65, 0xC3, 0xC3, 0x9D, 0x5E, 0x18, 0x18, 0x30, 0x28, 0x96, 0x96, 0x37, 0xA1
	.byte 0x05, 0x05, 0x0A, 0x0F, 0x9A, 0x9A, 0x2F, 0xB5, 0x07, 0x07, 0x0E, 0x09, 0x12, 0x12, 0x24, 0x36
	.byte 0x80, 0x80, 0x1B, 0x9B, 0xE2, 0xE2, 0xDF, 0x3D, 0xEB, 0xEB, 0xCD, 0x26, 0x27, 0x27, 0x4E, 0x69
	.byte 0xB2, 0xB2, 0x7F, 0xCD, 0x75, 0x75, 0xEA, 0x9F, 0x09, 0x09, 0x12, 0x1B, 0x83, 0x83, 0x1D, 0x9E
	.byte 0x2C, 0x2C, 0x58, 0x74, 0x1A, 0x1A, 0x34, 0x2E, 0x1B, 0x1B, 0x36, 0x2D, 0x6E, 0x6E, 0xDC, 0xB2
	.byte 0x5A, 0x5A, 0xB4, 0xEE, 0xA0, 0xA0, 0x5B, 0xFB, 0x52, 0x52, 0xA4, 0xF6, 0x3B, 0x3B, 0x76, 0x4D
	.byte 0xD6, 0xD6, 0xB7, 0x61, 0xB3, 0xB3, 0x7D, 0xCE, 0x29, 0x29, 0x52, 0x7B, 0xE3, 0xE3, 0xDD, 0x3E
	.byte 0x2F, 0x2F, 0x5E, 0x71, 0x84, 0x84, 0x13, 0x97, 0x53, 0x53, 0xA6, 0xF5, 0xD1, 0xD1, 0xB9, 0x68
	.byte 0x00, 0x00, 0x00, 0x00, 0xED, 0xED, 0xC1, 0x2C, 0x20, 0x20, 0x40, 0x60, 0xFC, 0xFC, 0xE3, 0x1F
	.byte 0xB1, 0xB1, 0x79, 0xC8, 0x5B, 0x5B, 0xB6, 0xED, 0x6A, 0x6A, 0xD4, 0xBE, 0xCB, 0xCB, 0x8D, 0x46
	.byte 0xBE, 0xBE, 0x67, 0xD9, 0x39, 0x39, 0x72, 0x4B, 0x4A, 0x4A, 0x94, 0xDE, 0x4C, 0x4C, 0x98, 0xD4
	.byte 0x58, 0x58, 0xB0, 0xE8, 0xCF, 0xCF, 0x85, 0x4A, 0xD0, 0xD0, 0xBB, 0x6B, 0xEF, 0xEF, 0xC5, 0x2A
	.byte 0xAA, 0xAA, 0x4F, 0xE5, 0xFB, 0xFB, 0xED, 0x16, 0x43, 0x43, 0x86, 0xC5, 0x4D, 0x4D, 0x9A, 0xD7
	.byte 0x33, 0x33, 0x66, 0x55, 0x85, 0x85, 0x11, 0x94, 0x45, 0x45, 0x8A, 0xCF, 0xF9, 0xF9, 0xE9, 0x10
	.byte 0x02, 0x02, 0x04, 0x06, 0x7F, 0x7F, 0xFE, 0x81, 0x50, 0x50, 0xA0, 0xF0, 0x3C, 0x3C, 0x78, 0x44
	.byte 0x9F, 0x9F, 0x25, 0xBA, 0xA8, 0xA8, 0x4B, 0xE3, 0x51, 0x51, 0xA2, 0xF3, 0xA3, 0xA3, 0x5D, 0xFE
	.byte 0x40, 0x40, 0x80, 0xC0, 0x8F, 0x8F, 0x05, 0x8A, 0x92, 0x92, 0x3F, 0xAD, 0x9D, 0x9D, 0x21, 0xBC
	.byte 0x38, 0x38, 0x70, 0x48, 0xF5, 0xF5, 0xF1, 0x04, 0xBC, 0xBC, 0x63, 0xDF, 0xB6, 0xB6, 0x77, 0xC1
	.byte 0xDA, 0xDA, 0xAF, 0x75, 0x21, 0x21, 0x42, 0x63, 0x10, 0x10, 0x20, 0x30, 0xFF, 0xFF, 0xE5, 0x1A
	.byte 0xF3, 0xF3, 0xFD, 0x0E, 0xD2, 0xD2, 0xBF, 0x6D, 0xCD, 0xCD, 0x81, 0x4C, 0x0C, 0x0C, 0x18, 0x14
	.byte 0x13, 0x13, 0x26, 0x35, 0xEC, 0xEC, 0xC3, 0x2F, 0x5F, 0x5F, 0xBE, 0xE1, 0x97, 0x97, 0x35, 0xA2
	.byte 0x44, 0x44, 0x88, 0xCC, 0x17, 0x17, 0x2E, 0x39, 0xC4, 0xC4, 0x93, 0x57, 0xA7, 0xA7, 0x55, 0xF2
	.byte 0x7E, 0x7E, 0xFC, 0x82, 0x3D, 0x3D, 0x7A, 0x47, 0x64, 0x64, 0xC8, 0xAC, 0x5D, 0x5D, 0xBA, 0xE7
	.byte 0x19, 0x19, 0x32, 0x2B, 0x73, 0x73, 0xE6, 0x95, 0x60, 0x60, 0xC0, 0xA0, 0x81, 0x81, 0x19, 0x98
	.byte 0x4F, 0x4F, 0x9E, 0xD1, 0xDC, 0xDC, 0xA3, 0x7F, 0x22, 0x22, 0x44, 0x66, 0x2A, 0x2A, 0x54, 0x7E
	.byte 0x90, 0x90, 0x3B, 0xAB, 0x88, 0x88, 0x0B, 0x83, 0x46, 0x46, 0x8C, 0xCA, 0xEE, 0xEE, 0xC7, 0x29
	.byte 0xB8, 0xB8, 0x6B, 0xD3, 0x14, 0x14, 0x28, 0x3C, 0xDE, 0xDE, 0xA7, 0x79, 0x5E, 0x5E, 0xBC, 0xE2
	.byte 0x0B, 0x0B, 0x16, 0x1D, 0xDB, 0xDB, 0xAD, 0x76, 0xE0, 0xE0, 0xDB, 0x3B, 0x32, 0x32, 0x64, 0x56
	.byte 0x3A, 0x3A, 0x74, 0x4E, 0x0A, 0x0A, 0x14, 0x1E, 0x49, 0x49, 0x92, 0xDB, 0x06, 0x06, 0x0C, 0x0A
	.byte 0x24, 0x24, 0x48, 0x6C, 0x5C, 0x5C, 0xB8, 0xE4, 0xC2, 0xC2, 0x9F, 0x5D, 0xD3, 0xD3, 0xBD, 0x6E
	.byte 0xAC, 0xAC, 0x43, 0xEF, 0x62, 0x62, 0xC4, 0xA6, 0x91, 0x91, 0x39, 0xA8, 0x95, 0x95, 0x31, 0xA4
	.byte 0xE4, 0xE4, 0xD3, 0x37, 0x79, 0x79, 0xF2, 0x8B, 0xE7, 0xE7, 0xD5, 0x32, 0xC8, 0xC8, 0x8B, 0x43
	.byte 0x37, 0x37, 0x6E, 0x59, 0x6D, 0x6D, 0xDA, 0xB7, 0x8D, 0x8D, 0x01, 0x8C, 0xD5, 0xD5, 0xB1, 0x64
	.byte 0x4E, 0x4E, 0x9C, 0xD2, 0xA9, 0xA9, 0x49, 0xE0, 0x6C, 0x6C, 0xD8, 0xB4, 0x56, 0x56, 0xAC, 0xFA
	.byte 0xF4, 0xF4, 0xF3, 0x07, 0xEA, 0xEA, 0xCF, 0x25, 0x65, 0x65, 0xCA, 0xAF, 0x7A, 0x7A, 0xF4, 0x8E
	.byte 0xAE, 0xAE, 0x47, 0xE9, 0x08, 0x08, 0x10, 0x18, 0xBA, 0xBA, 0x6F, 0xD5, 0x78, 0x78, 0xF0, 0x88
	.byte 0x25, 0x25, 0x4A, 0x6F, 0x2E, 0x2E, 0x5C, 0x72, 0x1C, 0x1C, 0x38, 0x24, 0xA6, 0xA6, 0x57, 0xF1
	.byte 0xB4, 0xB4, 0x73, 0xC7, 0xC6, 0xC6, 0x97, 0x51, 0xE8, 0xE8, 0xCB, 0x23, 0xDD, 0xDD, 0xA1, 0x7C
	.byte 0x74, 0x74, 0xE8, 0x9C, 0x1F, 0x1F, 0x3E, 0x21, 0x4B, 0x4B, 0x96, 0xDD, 0xBD, 0xBD, 0x61, 0xDC
	.byte 0x8B, 0x8B, 0x0D, 0x86, 0x8A, 0x8A, 0x0F, 0x85, 0x70, 0x70, 0xE0, 0x90, 0x3E, 0x3E, 0x7C, 0x42
	.byte 0xB5, 0xB5, 0x71, 0xC4, 0x66, 0x66, 0xCC, 0xAA, 0x48, 0x48, 0x90, 0xD8, 0x03, 0x03, 0x06, 0x05
	.byte 0xF6, 0xF6, 0xF7, 0x01, 0x0E, 0x0E, 0x1C, 0x12, 0x61, 0x61, 0xC2, 0xA3, 0x35, 0x35, 0x6A, 0x5F
	.byte 0x57, 0x57, 0xAE, 0xF9, 0xB9, 0xB9, 0x69, 0xD0, 0x86, 0x86, 0x17, 0x91, 0xC1, 0xC1, 0x99, 0x58
	.byte 0x1D, 0x1D, 0x3A, 0x27, 0x9E, 0x9E, 0x27, 0xB9, 0xE1, 0xE1, 0xD9, 0x38, 0xF8, 0xF8, 0xEB, 0x13
	.byte 0x98, 0x98, 0x2B, 0xB3, 0x11, 0x11, 0x22, 0x33, 0x69, 0x69, 0xD2, 0xBB, 0xD9, 0xD9, 0xA9, 0x70
	.byte 0x8E, 0x8E, 0x07, 0x89, 0x94, 0x94, 0x33, 0xA7, 0x9B, 0x9B, 0x2D, 0xB6, 0x1E, 0x1E, 0x3C, 0x22
	.byte 0x87, 0x87, 0x15, 0x92, 0xE9, 0xE9, 0xC9, 0x20, 0xCE, 0xCE, 0x87, 0x49, 0x55, 0x55, 0xAA, 0xFF
	.byte 0x28, 0x28, 0x50, 0x78, 0xDF, 0xDF, 0xA5, 0x7A, 0x8C, 0x8C, 0x03, 0x8F, 0xA1, 0xA1, 0x59, 0xF8
	.byte 0x89, 0x89, 0x09, 0x80, 0x0D, 0x0D, 0x1A, 0x17, 0xBF, 0xBF, 0x65, 0xDA, 0xE6, 0xE6, 0xD7, 0x31
	.byte 0x42, 0x42, 0x84, 0xC6, 0x68, 0x68, 0xD0, 0xB8, 0x41, 0x41, 0x82, 0xC3, 0x99, 0x99, 0x29, 0xB0
	.byte 0x2D, 0x2D, 0x5A, 0x77, 0x0F, 0x0F, 0x1E, 0x11, 0xB0, 0xB0, 0x7B, 0xCB, 0x54, 0x54, 0xA8, 0xFC
	.byte 0xBB, 0xBB, 0x6D, 0xD6, 0x16, 0x16, 0x2C, 0x3A, 0x63, 0xC6, 0xA5, 0x63, 0x7C, 0xF8, 0x84, 0x7C
	.byte 0x77, 0xEE, 0x99, 0x77, 0x7B, 0xF6, 0x8D, 0x7B, 0xF2, 0xFF, 0x0D, 0xF2, 0x6B, 0xD6, 0xBD, 0x6B
	.byte 0x6F, 0xDE, 0xB1, 0x6F, 0xC5, 0x91, 0x54, 0xC5, 0x30, 0x60, 0x50, 0x30, 0x01, 0x02, 0x03, 0x01
	.byte 0x67, 0xCE, 0xA9, 0x67, 0x2B, 0x56, 0x7D, 0x2B, 0xFE, 0xE7, 0x19, 0xFE, 0xD7, 0xB5, 0x62, 0xD7
	.byte 0xAB, 0x4D, 0xE6, 0xAB, 0x76, 0xEC, 0x9A, 0x76, 0xCA, 0x8F, 0x45, 0xCA, 0x82, 0x1F, 0x9D, 0x82
	.byte 0xC9, 0x89, 0x40, 0xC9, 0x7D, 0xFA, 0x87, 0x7D, 0xFA, 0xEF, 0x15, 0xFA, 0x59, 0xB2, 0xEB, 0x59
	.byte 0x47, 0x8E, 0xC9, 0x47, 0xF0, 0xFB, 0x0B, 0xF0, 0xAD, 0x41, 0xEC, 0xAD, 0xD4, 0xB3, 0x67, 0xD4
	.byte 0xA2, 0x5F, 0xFD, 0xA2, 0xAF, 0x45, 0xEA, 0xAF, 0x9C, 0x23, 0xBF, 0x9C, 0xA4, 0x53, 0xF7, 0xA4
	.byte 0x72, 0xE4, 0x96, 0x72, 0xC0, 0x9B, 0x5B, 0xC0, 0xB7, 0x75, 0xC2, 0xB7, 0xFD, 0xE1, 0x1C, 0xFD
	.byte 0x93, 0x3D, 0xAE, 0x93, 0x26, 0x4C, 0x6A, 0x26, 0x36, 0x6C, 0x5A, 0x36, 0x3F, 0x7E, 0x41, 0x3F
	.byte 0xF7, 0xF5, 0x02, 0xF7, 0xCC, 0x83, 0x4F, 0xCC, 0x34, 0x68, 0x5C, 0x34, 0xA5, 0x51, 0xF4, 0xA5
	.byte 0xE5, 0xD1, 0x34, 0xE5, 0xF1, 0xF9, 0x08, 0xF1, 0x71, 0xE2, 0x93, 0x71, 0xD8, 0xAB, 0x73, 0xD8
	.byte 0x31, 0x62, 0x53, 0x31, 0x15, 0x2A, 0x3F, 0x15, 0x04, 0x08, 0x0C, 0x04, 0xC7, 0x95, 0x52, 0xC7
	.byte 0x23, 0x46, 0x65, 0x23, 0xC3, 0x9D, 0x5E, 0xC3, 0x18, 0x30, 0x28, 0x18, 0x96, 0x37, 0xA1, 0x96
	.byte 0x05, 0x0A, 0x0F, 0x05, 0x9A, 0x2F, 0xB5, 0x9A, 0x07, 0x0E, 0x09, 0x07, 0x12, 0x24, 0x36, 0x12
	.byte 0x80, 0x1B, 0x9B, 0x80, 0xE2, 0xDF, 0x3D, 0xE2, 0xEB, 0xCD, 0x26, 0xEB, 0x27, 0x4E, 0x69, 0x27
	.byte 0xB2, 0x7F, 0xCD, 0xB2, 0x75, 0xEA, 0x9F, 0x75, 0x09, 0x12, 0x1B, 0x09, 0x83, 0x1D, 0x9E, 0x83
	.byte 0x2C, 0x58, 0x74, 0x2C, 0x1A, 0x34, 0x2E, 0x1A, 0x1B, 0x36, 0x2D, 0x1B, 0x6E, 0xDC, 0xB2, 0x6E
	.byte 0x5A, 0xB4, 0xEE, 0x5A, 0xA0, 0x5B, 0xFB, 0xA0, 0x52, 0xA4, 0xF6, 0x52, 0x3B, 0x76, 0x4D, 0x3B
	.byte 0xD6, 0xB7, 0x61, 0xD6, 0xB3, 0x7D, 0xCE, 0xB3, 0x29, 0x52, 0x7B, 0x29, 0xE3, 0xDD, 0x3E, 0xE3
	.byte 0x2F, 0x5E, 0x71, 0x2F, 0x84, 0x13, 0x97, 0x84, 0x53, 0xA6, 0xF5, 0x53, 0xD1, 0xB9, 0x68, 0xD1
	.byte 0x00, 0x00, 0x00, 0x00, 0xED, 0xC1, 0x2C, 0xED, 0x20, 0x40, 0x60, 0x20, 0xFC, 0xE3, 0x1F, 0xFC
	.byte 0xB1, 0x79, 0xC8, 0xB1, 0x5B, 0xB6, 0xED, 0x5B, 0x6A, 0xD4, 0xBE, 0x6A, 0xCB, 0x8D, 0x46, 0xCB
	.byte 0xBE, 0x67, 0xD9, 0xBE, 0x39, 0x72, 0x4B, 0x39, 0x4A, 0x94, 0xDE, 0x4A, 0x4C, 0x98, 0xD4, 0x4C
	.byte 0x58, 0xB0, 0xE8, 0x58, 0xCF, 0x85, 0x4A, 0xCF, 0xD0, 0xBB, 0x6B, 0xD0, 0xEF, 0xC5, 0x2A, 0xEF
	.byte 0xAA, 0x4F, 0xE5, 0xAA, 0xFB, 0xED, 0x16, 0xFB, 0x43, 0x86, 0xC5, 0x43, 0x4D, 0x9A, 0xD7, 0x4D
	.byte 0x33, 0x66, 0x55, 0x33, 0x85, 0x11, 0x94, 0x85, 0x45, 0x8A, 0xCF, 0x45, 0xF9, 0xE9, 0x10, 0xF9
	.byte 0x02, 0x04, 0x06, 0x02, 0x7F, 0xFE, 0x81, 0x7F, 0x50, 0xA0, 0xF0, 0x50, 0x3C, 0x78, 0x44, 0x3C
	.byte 0x9F, 0x25, 0xBA, 0x9F, 0xA8, 0x4B, 0xE3, 0xA8, 0x51, 0xA2, 0xF3, 0x51, 0xA3, 0x5D, 0xFE, 0xA3
	.byte 0x40, 0x80, 0xC0, 0x40, 0x8F, 0x05, 0x8A, 0x8F, 0x92, 0x3F, 0xAD, 0x92, 0x9D, 0x21, 0xBC, 0x9D
	.byte 0x38, 0x70, 0x48, 0x38, 0xF5, 0xF1, 0x04, 0xF5, 0xBC, 0x63, 0xDF, 0xBC, 0xB6, 0x77, 0xC1, 0xB6
	.byte 0xDA, 0xAF, 0x75, 0xDA, 0x21, 0x42, 0x63, 0x21, 0x10, 0x20, 0x30, 0x10, 0xFF, 0xE5, 0x1A, 0xFF
	.byte 0xF3, 0xFD, 0x0E, 0xF3, 0xD2, 0xBF, 0x6D, 0xD2, 0xCD, 0x81, 0x4C, 0xCD, 0x0C, 0x18, 0x14, 0x0C
	.byte 0x13, 0x26, 0x35, 0x13, 0xEC, 0xC3, 0x2F, 0xEC, 0x5F, 0xBE, 0xE1, 0x5F, 0x97, 0x35, 0xA2, 0x97
	.byte 0x44, 0x88, 0xCC, 0x44, 0x17, 0x2E, 0x39, 0x17, 0xC4, 0x93, 0x57, 0xC4, 0xA7, 0x55, 0xF2, 0xA7
	.byte 0x7E, 0xFC, 0x82, 0x7E, 0x3D, 0x7A, 0x47, 0x3D, 0x64, 0xC8, 0xAC, 0x64, 0x5D, 0xBA, 0xE7, 0x5D
	.byte 0x19, 0x32, 0x2B, 0x19, 0x73, 0xE6, 0x95, 0x73, 0x60, 0xC0, 0xA0, 0x60, 0x81, 0x19, 0x98, 0x81
	.byte 0x4F, 0x9E, 0xD1, 0x4F, 0xDC, 0xA3, 0x7F, 0xDC, 0x22, 0x44, 0x66, 0x22, 0x2A, 0x54, 0x7E, 0x2A
	.byte 0x90, 0x3B, 0xAB, 0x90, 0x88, 0x0B, 0x83, 0x88, 0x46, 0x8C, 0xCA, 0x46, 0xEE, 0xC7, 0x29, 0xEE
	.byte 0xB8, 0x6B, 0xD3, 0xB8, 0x14, 0x28, 0x3C, 0x14, 0xDE, 0xA7, 0x79, 0xDE, 0x5E, 0xBC, 0xE2, 0x5E
	.byte 0x0B, 0x16, 0x1D, 0x0B, 0xDB, 0xAD, 0x76, 0xDB, 0xE0, 0xDB, 0x3B, 0xE0, 0x32, 0x64, 0x56, 0x32
	.byte 0x3A, 0x74, 0x4E, 0x3A, 0x0A, 0x14, 0x1E, 0x0A, 0x49, 0x92, 0xDB, 0x49, 0x06, 0x0C, 0x0A, 0x06
	.byte 0x24, 0x48, 0x6C, 0x24, 0x5C, 0xB8, 0xE4, 0x5C, 0xC2, 0x9F, 0x5D, 0xC2, 0xD3, 0xBD, 0x6E, 0xD3
	.byte 0xAC, 0x43, 0xEF, 0xAC, 0x62, 0xC4, 0xA6, 0x62, 0x91, 0x39, 0xA8, 0x91, 0x95, 0x31, 0xA4, 0x95
	.byte 0xE4, 0xD3, 0x37, 0xE4, 0x79, 0xF2, 0x8B, 0x79, 0xE7, 0xD5, 0x32, 0xE7, 0xC8, 0x8B, 0x43, 0xC8
	.byte 0x37, 0x6E, 0x59, 0x37, 0x6D, 0xDA, 0xB7, 0x6D, 0x8D, 0x01, 0x8C, 0x8D, 0xD5, 0xB1, 0x64, 0xD5
	.byte 0x4E, 0x9C, 0xD2, 0x4E, 0xA9, 0x49, 0xE0, 0xA9, 0x6C, 0xD8, 0xB4, 0x6C, 0x56, 0xAC, 0xFA, 0x56
	.byte 0xF4, 0xF3, 0x07, 0xF4, 0xEA, 0xCF, 0x25, 0xEA, 0x65, 0xCA, 0xAF, 0x65, 0x7A, 0xF4, 0x8E, 0x7A
	.byte 0xAE, 0x47, 0xE9, 0xAE, 0x08, 0x10, 0x18, 0x08, 0xBA, 0x6F, 0xD5, 0xBA, 0x78, 0xF0, 0x88, 0x78
	.byte 0x25, 0x4A, 0x6F, 0x25, 0x2E, 0x5C, 0x72, 0x2E, 0x1C, 0x38, 0x24, 0x1C, 0xA6, 0x57, 0xF1, 0xA6
	.byte 0xB4, 0x73, 0xC7, 0xB4, 0xC6, 0x97, 0x51, 0xC6, 0xE8, 0xCB, 0x23, 0xE8, 0xDD, 0xA1, 0x7C, 0xDD
	.byte 0x74, 0xE8, 0x9C, 0x74, 0x1F, 0x3E, 0x21, 0x1F, 0x4B, 0x96, 0xDD, 0x4B, 0xBD, 0x61, 0xDC, 0xBD
	.byte 0x8B, 0x0D, 0x86, 0x8B, 0x8A, 0x0F, 0x85, 0x8A, 0x70, 0xE0, 0x90, 0x70, 0x3E, 0x7C, 0x42, 0x3E
	.byte 0xB5, 0x71, 0xC4, 0xB5, 0x66, 0xCC, 0xAA, 0x66, 0x48, 0x90, 0xD8, 0x48, 0x03, 0x06, 0x05, 0x03
	.byte 0xF6, 0xF7, 0x01, 0xF6, 0x0E, 0x1C, 0x12, 0x0E, 0x61, 0xC2, 0xA3, 0x61, 0x35, 0x6A, 0x5F, 0x35
	.byte 0x57, 0xAE, 0xF9, 0x57, 0xB9, 0x69, 0xD0, 0xB9, 0x86, 0x17, 0x91, 0x86, 0xC1, 0x99, 0x58, 0xC1
	.byte 0x1D, 0x3A, 0x27, 0x1D, 0x9E, 0x27, 0xB9, 0x9E, 0xE1, 0xD9, 0x38, 0xE1, 0xF8, 0xEB, 0x13, 0xF8
	.byte 0x98, 0x2B, 0xB3, 0x98, 0x11, 0x22, 0x33, 0x11, 0x69, 0xD2, 0xBB, 0x69, 0xD9, 0xA9, 0x70, 0xD9
	.byte 0x8E, 0x07, 0x89, 0x8E, 0x94, 0x33, 0xA7, 0x94, 0x9B, 0x2D, 0xB6, 0x9B, 0x1E, 0x3C, 0x22, 0x1E
	.byte 0x87, 0x15, 0x92, 0x87, 0xE9, 0xC9, 0x20, 0xE9, 0xCE, 0x87, 0x49, 0xCE, 0x55, 0xAA, 0xFF, 0x55
	.byte 0x28, 0x50, 0x78, 0x28, 0xDF, 0xA5, 0x7A, 0xDF, 0x8C, 0x03, 0x8F, 0x8C, 0xA1, 0x59, 0xF8, 0xA1
	.byte 0x89, 0x09, 0x80, 0x89, 0x0D, 0x1A, 0x17, 0x0D, 0xBF, 0x65, 0xDA, 0xBF, 0xE6, 0xD7, 0x31, 0xE6
	.byte 0x42, 0x84, 0xC6, 0x42, 0x68, 0xD0, 0xB8, 0x68, 0x41, 0x82, 0xC3, 0x41, 0x99, 0x29, 0xB0, 0x99
	.byte 0x2D, 0x5A, 0x77, 0x2D, 0x0F, 0x1E, 0x11, 0x0F, 0xB0, 0x7B, 0xCB, 0xB0, 0x54, 0xA8, 0xFC, 0x54
	.byte 0xBB, 0x6D, 0xD6, 0xBB, 0x16, 0x2C, 0x3A, 0x16, 0xC6, 0xA5, 0x63, 0x63, 0xF8, 0x84, 0x7C, 0x7C
	.byte 0xEE, 0x99, 0x77, 0x77, 0xF6, 0x8D, 0x7B, 0x7B, 0xFF, 0x0D, 0xF2, 0xF2, 0xD6, 0xBD, 0x6B, 0x6B
	.byte 0xDE, 0xB1, 0x6F, 0x6F, 0x91, 0x54, 0xC5, 0xC5, 0x60, 0x50, 0x30, 0x30, 0x02, 0x03, 0x01, 0x01
	.byte 0xCE, 0xA9, 0x67, 0x67, 0x56, 0x7D, 0x2B, 0x2B, 0xE7, 0x19, 0xFE, 0xFE, 0xB5, 0x62, 0xD7, 0xD7
	.byte 0x4D, 0xE6, 0xAB, 0xAB, 0xEC, 0x9A, 0x76, 0x76, 0x8F, 0x45, 0xCA, 0xCA, 0x1F, 0x9D, 0x82, 0x82
	.byte 0x89, 0x40, 0xC9, 0xC9, 0xFA, 0x87, 0x7D, 0x7D, 0xEF, 0x15, 0xFA, 0xFA, 0xB2, 0xEB, 0x59, 0x59
	.byte 0x8E, 0xC9, 0x47, 0x47, 0xFB, 0x0B, 0xF0, 0xF0, 0x41, 0xEC, 0xAD, 0xAD, 0xB3, 0x67, 0xD4, 0xD4
	.byte 0x5F, 0xFD, 0xA2, 0xA2, 0x45, 0xEA, 0xAF, 0xAF, 0x23, 0xBF, 0x9C, 0x9C, 0x53, 0xF7, 0xA4, 0xA4
	.byte 0xE4, 0x96, 0x72, 0x72, 0x9B, 0x5B, 0xC0, 0xC0, 0x75, 0xC2, 0xB7, 0xB7, 0xE1, 0x1C, 0xFD, 0xFD
	.byte 0x3D, 0xAE, 0x93, 0x93, 0x4C, 0x6A, 0x26, 0x26, 0x6C, 0x5A, 0x36, 0x36, 0x7E, 0x41, 0x3F, 0x3F
	.byte 0xF5, 0x02, 0xF7, 0xF7, 0x83, 0x4F, 0xCC, 0xCC, 0x68, 0x5C, 0x34, 0x34, 0x51, 0xF4, 0xA5, 0xA5
	.byte 0xD1, 0x34, 0xE5, 0xE5, 0xF9, 0x08, 0xF1, 0xF1, 0xE2, 0x93, 0x71, 0x71, 0xAB, 0x73, 0xD8, 0xD8
	.byte 0x62, 0x53, 0x31, 0x31, 0x2A, 0x3F, 0x15, 0x15, 0x08, 0x0C, 0x04, 0x04, 0x95, 0x52, 0xC7, 0xC7
	.byte 0x46, 0x65, 0x23, 0x23, 0x9D, 0x5E, 0xC3, 0xC3, 0x30, 0x28, 0x18, 0x18, 0x37, 0xA1, 0x96, 0x96
	.byte 0x0A, 0x0F, 0x05, 0x05, 0x2F, 0xB5, 0x9A, 0x9A, 0x0E, 0x09, 0x07, 0x07, 0x24, 0x36, 0x12, 0x12
	.byte 0x1B, 0x9B, 0x80, 0x80, 0xDF, 0x3D, 0xE2, 0xE2, 0xCD, 0x26, 0xEB, 0xEB, 0x4E, 0x69, 0x27, 0x27
	.byte 0x7F, 0xCD, 0xB2, 0xB2, 0xEA, 0x9F, 0x75, 0x75, 0x12, 0x1B, 0x09, 0x09, 0x1D, 0x9E, 0x83, 0x83
	.byte 0x58, 0x74, 0x2C, 0x2C, 0x34, 0x2E, 0x1A, 0x1A, 0x36, 0x2D, 0x1B, 0x1B, 0xDC, 0xB2, 0x6E, 0x6E
	.byte 0xB4, 0xEE, 0x5A, 0x5A, 0x5B, 0xFB, 0xA0, 0xA0, 0xA4, 0xF6, 0x52, 0x52, 0x76, 0x4D, 0x3B, 0x3B
	.byte 0xB7, 0x61, 0xD6, 0xD6, 0x7D, 0xCE, 0xB3, 0xB3, 0x52, 0x7B, 0x29, 0x29, 0xDD, 0x3E, 0xE3, 0xE3
	.byte 0x5E, 0x71, 0x2F, 0x2F, 0x13, 0x97, 0x84, 0x84, 0xA6, 0xF5, 0x53, 0x53, 0xB9, 0x68, 0xD1, 0xD1
	.byte 0x00, 0x00, 0x00, 0x00, 0xC1, 0x2C, 0xED, 0xED, 0x40, 0x60, 0x20, 0x20, 0xE3, 0x1F, 0xFC, 0xFC
	.byte 0x79, 0xC8, 0xB1, 0xB1, 0xB6, 0xED, 0x5B, 0x5B, 0xD4, 0xBE, 0x6A, 0x6A, 0x8D, 0x46, 0xCB, 0xCB
	.byte 0x67, 0xD9, 0xBE, 0xBE, 0x72, 0x4B, 0x39, 0x39, 0x94, 0xDE, 0x4A, 0x4A, 0x98, 0xD4, 0x4C, 0x4C
	.byte 0xB0, 0xE8, 0x58, 0x58, 0x85, 0x4A, 0xCF, 0xCF, 0xBB, 0x6B, 0xD0, 0xD0, 0xC5, 0x2A, 0xEF, 0xEF
	.byte 0x4F, 0xE5, 0xAA, 0xAA, 0xED, 0x16, 0xFB, 0xFB, 0x86, 0xC5, 0x43, 0x43, 0x9A, 0xD7, 0x4D, 0x4D
	.byte 0x66, 0x55, 0x33, 0x33, 0x11, 0x94, 0x85, 0x85, 0x8A, 0xCF, 0x45, 0x45, 0xE9, 0x10, 0xF9, 0xF9
	.byte 0x04, 0x06, 0x02, 0x02, 0xFE, 0x81, 0x7F, 0x7F, 0xA0, 0xF0, 0x50, 0x50, 0x78, 0x44, 0x3C, 0x3C
	.byte 0x25, 0xBA, 0x9F, 0x9F, 0x4B, 0xE3, 0xA8, 0xA8, 0xA2, 0xF3, 0x51, 0x51, 0x5D, 0xFE, 0xA3, 0xA3
	.byte 0x80, 0xC0, 0x40, 0x40, 0x05, 0x8A, 0x8F, 0x8F, 0x3F, 0xAD, 0x92, 0x92, 0x21, 0xBC, 0x9D, 0x9D
	.byte 0x70, 0x48, 0x38, 0x38, 0xF1, 0x04, 0xF5, 0xF5, 0x63, 0xDF, 0xBC, 0xBC, 0x77, 0xC1, 0xB6, 0xB6
	.byte 0xAF, 0x75, 0xDA, 0xDA, 0x42, 0x63, 0x21, 0x21, 0x20, 0x30, 0x10, 0x10, 0xE5, 0x1A, 0xFF, 0xFF
	.byte 0xFD, 0x0E, 0xF3, 0xF3, 0xBF, 0x6D, 0xD2, 0xD2, 0x81, 0x4C, 0xCD, 0xCD, 0x18, 0x14, 0x0C, 0x0C
	.byte 0x26, 0x35, 0x13, 0x13, 0xC3, 0x2F, 0xEC, 0xEC, 0xBE, 0xE1, 0x5F, 0x5F, 0x35, 0xA2, 0x97, 0x97
	.byte 0x88, 0xCC, 0x44, 0x44, 0x2E, 0x39, 0x17, 0x17, 0x93, 0x57, 0xC4, 0xC4, 0x55, 0xF2, 0xA7, 0xA7
	.byte 0xFC, 0x82, 0x7E, 0x7E, 0x7A, 0x47, 0x3D, 0x3D, 0xC8, 0xAC, 0x64, 0x64, 0xBA, 0xE7, 0x5D, 0x5D
	.byte 0x32, 0x2B, 0x19, 0x19, 0xE6, 0x95, 0x73, 0x73, 0xC0, 0xA0, 0x60, 0x60, 0x19, 0x98, 0x81, 0x81
	.byte 0x9E, 0xD1, 0x4F, 0x4F, 0xA3, 0x7F, 0xDC, 0xDC, 0x44, 0x66, 0x22, 0x22, 0x54, 0x7E, 0x2A, 0x2A
	.byte 0x3B, 0xAB, 0x90, 0x90, 0x0B, 0x83, 0x88, 0x88, 0x8C, 0xCA, 0x46, 0x46, 0xC7, 0x29, 0xEE, 0xEE
	.byte 0x6B, 0xD3, 0xB8, 0xB8, 0x28, 0x3C, 0x14, 0x14, 0xA7, 0x79, 0xDE, 0xDE, 0xBC, 0xE2, 0x5E, 0x5E
	.byte 0x16, 0x1D, 0x0B, 0x0B, 0xAD, 0x76, 0xDB, 0xDB, 0xDB, 0x3B, 0xE0, 0xE0, 0x64, 0x56, 0x32, 0x32
	.byte 0x74, 0x4E, 0x3A, 0x3A, 0x14, 0x1E, 0x0A, 0x0A, 0x92, 0xDB, 0x49, 0x49, 0x0C, 0x0A, 0x06, 0x06
	.byte 0x48, 0x6C, 0x24, 0x24, 0xB8, 0xE4, 0x5C, 0x5C, 0x9F, 0x5D, 0xC2, 0xC2, 0xBD, 0x6E, 0xD3, 0xD3
	.byte 0x43, 0xEF, 0xAC, 0xAC, 0xC4, 0xA6, 0x62, 0x62, 0x39, 0xA8, 0x91, 0x91, 0x31, 0xA4, 0x95, 0x95
	.byte 0xD3, 0x37, 0xE4, 0xE4, 0xF2, 0x8B, 0x79, 0x79, 0xD5, 0x32, 0xE7, 0xE7, 0x8B, 0x43, 0xC8, 0xC8
	.byte 0x6E, 0x59, 0x37, 0x37, 0xDA, 0xB7, 0x6D, 0x6D, 0x01, 0x8C, 0x8D, 0x8D, 0xB1, 0x64, 0xD5, 0xD5
	.byte 0x9C, 0xD2, 0x4E, 0x4E, 0x49, 0xE0, 0xA9, 0xA9, 0xD8, 0xB4, 0x6C, 0x6C, 0xAC, 0xFA, 0x56, 0x56
	.byte 0xF3, 0x07, 0xF4, 0xF4, 0xCF, 0x25, 0xEA, 0xEA, 0xCA, 0xAF, 0x65, 0x65, 0xF4, 0x8E, 0x7A, 0x7A
	.byte 0x47, 0xE9, 0xAE, 0xAE, 0x10, 0x18, 0x08, 0x08, 0x6F, 0xD5, 0xBA, 0xBA, 0xF0, 0x88, 0x78, 0x78
	.byte 0x4A, 0x6F, 0x25, 0x25, 0x5C, 0x72, 0x2E, 0x2E, 0x38, 0x24, 0x1C, 0x1C, 0x57, 0xF1, 0xA6, 0xA6
	.byte 0x73, 0xC7, 0xB4, 0xB4, 0x97, 0x51, 0xC6, 0xC6, 0xCB, 0x23, 0xE8, 0xE8, 0xA1, 0x7C, 0xDD, 0xDD
	.byte 0xE8, 0x9C, 0x74, 0x74, 0x3E, 0x21, 0x1F, 0x1F, 0x96, 0xDD, 0x4B, 0x4B, 0x61, 0xDC, 0xBD, 0xBD
	.byte 0x0D, 0x86, 0x8B, 0x8B, 0x0F, 0x85, 0x8A, 0x8A, 0xE0, 0x90, 0x70, 0x70, 0x7C, 0x42, 0x3E, 0x3E
	.byte 0x71, 0xC4, 0xB5, 0xB5, 0xCC, 0xAA, 0x66, 0x66, 0x90, 0xD8, 0x48, 0x48, 0x06, 0x05, 0x03, 0x03
	.byte 0xF7, 0x01, 0xF6, 0xF6, 0x1C, 0x12, 0x0E, 0x0E, 0xC2, 0xA3, 0x61, 0x61, 0x6A, 0x5F, 0x35, 0x35
	.byte 0xAE, 0xF9, 0x57, 0x57, 0x69, 0xD0, 0xB9, 0xB9, 0x17, 0x91, 0x86, 0x86, 0x99, 0x58, 0xC1, 0xC1
	.byte 0x3A, 0x27, 0x1D, 0x1D, 0x27, 0xB9, 0x9E, 0x9E, 0xD9, 0x38, 0xE1, 0xE1, 0xEB, 0x13, 0xF8, 0xF8
	.byte 0x2B, 0xB3, 0x98, 0x98, 0x22, 0x33, 0x11, 0x11, 0xD2, 0xBB, 0x69, 0x69, 0xA9, 0x70, 0xD9, 0xD9
	.byte 0x07, 0x89, 0x8E, 0x8E, 0x33, 0xA7, 0x94, 0x94, 0x2D, 0xB6, 0x9B, 0x9B, 0x3C, 0x22, 0x1E, 0x1E
	.byte 0x15, 0x92, 0x87, 0x87, 0xC9, 0x20, 0xE9, 0xE9, 0x87, 0x49, 0xCE, 0xCE, 0xAA, 0xFF, 0x55, 0x55
	.byte 0x50, 0x78, 0x28, 0x28, 0xA5, 0x7A, 0xDF, 0xDF, 0x03, 0x8F, 0x8C, 0x8C, 0x59, 0xF8, 0xA1, 0xA1
	.byte 0x09, 0x80, 0x89, 0x89, 0x1A, 0x17, 0x0D, 0x0D, 0x65, 0xDA, 0xBF, 0xBF, 0xD7, 0x31, 0xE6, 0xE6
	.byte 0x84, 0xC6, 0x42, 0x42, 0xD0, 0xB8, 0x68, 0x68, 0x82, 0xC3, 0x41, 0x41, 0x29, 0xB0, 0x99, 0x99
	.byte 0x5A, 0x77, 0x2D, 0x2D, 0x1E, 0x11, 0x0F, 0x0F, 0x7B, 0xCB, 0xB0, 0xB0, 0xA8, 0xFC, 0x54, 0x54
	.byte 0x6D, 0xD6, 0xBB, 0xBB, 0x2C, 0x3A, 0x16, 0x16, 0x63, 0x63, 0x63, 0x63, 0x7C, 0x7C, 0x7C, 0x7C
	.byte 0x77, 0x77, 0x77, 0x77, 0x7B, 0x7B, 0x7B, 0x7B, 0xF2, 0xF2, 0xF2, 0xF2, 0x6B, 0x6B, 0x6B, 0x6B
	.byte 0x6F, 0x6F, 0x6F, 0x6F, 0xC5, 0xC5, 0xC5, 0xC5, 0x30, 0x30, 0x30, 0x30, 0x01, 0x01, 0x01, 0x01
	.byte 0x67, 0x67, 0x67, 0x67, 0x2B, 0x2B, 0x2B, 0x2B, 0xFE, 0xFE, 0xFE, 0xFE, 0xD7, 0xD7, 0xD7, 0xD7
	.byte 0xAB, 0xAB, 0xAB, 0xAB, 0x76, 0x76, 0x76, 0x76, 0xCA, 0xCA, 0xCA, 0xCA, 0x82, 0x82, 0x82, 0x82
	.byte 0xC9, 0xC9, 0xC9, 0xC9, 0x7D, 0x7D, 0x7D, 0x7D, 0xFA, 0xFA, 0xFA, 0xFA, 0x59, 0x59, 0x59, 0x59
	.byte 0x47, 0x47, 0x47, 0x47, 0xF0, 0xF0, 0xF0, 0xF0, 0xAD, 0xAD, 0xAD, 0xAD, 0xD4, 0xD4, 0xD4, 0xD4
	.byte 0xA2, 0xA2, 0xA2, 0xA2, 0xAF, 0xAF, 0xAF, 0xAF, 0x9C, 0x9C, 0x9C, 0x9C, 0xA4, 0xA4, 0xA4, 0xA4
	.byte 0x72, 0x72, 0x72, 0x72, 0xC0, 0xC0, 0xC0, 0xC0, 0xB7, 0xB7, 0xB7, 0xB7, 0xFD, 0xFD, 0xFD, 0xFD
	.byte 0x93, 0x93, 0x93, 0x93, 0x26, 0x26, 0x26, 0x26, 0x36, 0x36, 0x36, 0x36, 0x3F, 0x3F, 0x3F, 0x3F
	.byte 0xF7, 0xF7, 0xF7, 0xF7, 0xCC, 0xCC, 0xCC, 0xCC, 0x34, 0x34, 0x34, 0x34, 0xA5, 0xA5, 0xA5, 0xA5
	.byte 0xE5, 0xE5, 0xE5, 0xE5, 0xF1, 0xF1, 0xF1, 0xF1, 0x71, 0x71, 0x71, 0x71, 0xD8, 0xD8, 0xD8, 0xD8
	.byte 0x31, 0x31, 0x31, 0x31, 0x15, 0x15, 0x15, 0x15, 0x04, 0x04, 0x04, 0x04, 0xC7, 0xC7, 0xC7, 0xC7
	.byte 0x23, 0x23, 0x23, 0x23, 0xC3, 0xC3, 0xC3, 0xC3, 0x18, 0x18, 0x18, 0x18, 0x96, 0x96, 0x96, 0x96
	.byte 0x05, 0x05, 0x05, 0x05, 0x9A, 0x9A, 0x9A, 0x9A, 0x07, 0x07, 0x07, 0x07, 0x12, 0x12, 0x12, 0x12
	.byte 0x80, 0x80, 0x80, 0x80, 0xE2, 0xE2, 0xE2, 0xE2, 0xEB, 0xEB, 0xEB, 0xEB, 0x27, 0x27, 0x27, 0x27
	.byte 0xB2, 0xB2, 0xB2, 0xB2, 0x75, 0x75, 0x75, 0x75, 0x09, 0x09, 0x09, 0x09, 0x83, 0x83, 0x83, 0x83
	.byte 0x2C, 0x2C, 0x2C, 0x2C, 0x1A, 0x1A, 0x1A, 0x1A, 0x1B, 0x1B, 0x1B, 0x1B, 0x6E, 0x6E, 0x6E, 0x6E
	.byte 0x5A, 0x5A, 0x5A, 0x5A, 0xA0, 0xA0, 0xA0, 0xA0, 0x52, 0x52, 0x52, 0x52, 0x3B, 0x3B, 0x3B, 0x3B
	.byte 0xD6, 0xD6, 0xD6, 0xD6, 0xB3, 0xB3, 0xB3, 0xB3, 0x29, 0x29, 0x29, 0x29, 0xE3, 0xE3, 0xE3, 0xE3
	.byte 0x2F, 0x2F, 0x2F, 0x2F, 0x84, 0x84, 0x84, 0x84, 0x53, 0x53, 0x53, 0x53, 0xD1, 0xD1, 0xD1, 0xD1
	.byte 0x00, 0x00, 0x00, 0x00, 0xED, 0xED, 0xED, 0xED, 0x20, 0x20, 0x20, 0x20, 0xFC, 0xFC, 0xFC, 0xFC
	.byte 0xB1, 0xB1, 0xB1, 0xB1, 0x5B, 0x5B, 0x5B, 0x5B, 0x6A, 0x6A, 0x6A, 0x6A, 0xCB, 0xCB, 0xCB, 0xCB
	.byte 0xBE, 0xBE, 0xBE, 0xBE, 0x39, 0x39, 0x39, 0x39, 0x4A, 0x4A, 0x4A, 0x4A, 0x4C, 0x4C, 0x4C, 0x4C
	.byte 0x58, 0x58, 0x58, 0x58, 0xCF, 0xCF, 0xCF, 0xCF, 0xD0, 0xD0, 0xD0, 0xD0, 0xEF, 0xEF, 0xEF, 0xEF
	.byte 0xAA, 0xAA, 0xAA, 0xAA, 0xFB, 0xFB, 0xFB, 0xFB, 0x43, 0x43, 0x43, 0x43, 0x4D, 0x4D, 0x4D, 0x4D
	.byte 0x33, 0x33, 0x33, 0x33, 0x85, 0x85, 0x85, 0x85, 0x45, 0x45, 0x45, 0x45, 0xF9, 0xF9, 0xF9, 0xF9
	.byte 0x02, 0x02, 0x02, 0x02, 0x7F, 0x7F, 0x7F, 0x7F, 0x50, 0x50, 0x50, 0x50, 0x3C, 0x3C, 0x3C, 0x3C
	.byte 0x9F, 0x9F, 0x9F, 0x9F, 0xA8, 0xA8, 0xA8, 0xA8, 0x51, 0x51, 0x51, 0x51, 0xA3, 0xA3, 0xA3, 0xA3
	.byte 0x40, 0x40, 0x40, 0x40, 0x8F, 0x8F, 0x8F, 0x8F, 0x92, 0x92, 0x92, 0x92, 0x9D, 0x9D, 0x9D, 0x9D
	.byte 0x38, 0x38, 0x38, 0x38, 0xF5, 0xF5, 0xF5, 0xF5, 0xBC, 0xBC, 0xBC, 0xBC, 0xB6, 0xB6, 0xB6, 0xB6
	.byte 0xDA, 0xDA, 0xDA, 0xDA, 0x21, 0x21, 0x21, 0x21, 0x10, 0x10, 0x10, 0x10, 0xFF, 0xFF, 0xFF, 0xFF
	.byte 0xF3, 0xF3, 0xF3, 0xF3, 0xD2, 0xD2, 0xD2, 0xD2, 0xCD, 0xCD, 0xCD, 0xCD, 0x0C, 0x0C, 0x0C, 0x0C
	.byte 0x13, 0x13, 0x13, 0x13, 0xEC, 0xEC, 0xEC, 0xEC, 0x5F, 0x5F, 0x5F, 0x5F, 0x97, 0x97, 0x97, 0x97
	.byte 0x44, 0x44, 0x44, 0x44, 0x17, 0x17, 0x17, 0x17, 0xC4, 0xC4, 0xC4, 0xC4, 0xA7, 0xA7, 0xA7, 0xA7
	.byte 0x7E, 0x7E, 0x7E, 0x7E, 0x3D, 0x3D, 0x3D, 0x3D, 0x64, 0x64, 0x64, 0x64, 0x5D, 0x5D, 0x5D, 0x5D
	.byte 0x19, 0x19, 0x19, 0x19, 0x73, 0x73, 0x73, 0x73, 0x60, 0x60, 0x60, 0x60, 0x81, 0x81, 0x81, 0x81
	.byte 0x4F, 0x4F, 0x4F, 0x4F, 0xDC, 0xDC, 0xDC, 0xDC, 0x22, 0x22, 0x22, 0x22, 0x2A, 0x2A, 0x2A, 0x2A
	.byte 0x90, 0x90, 0x90, 0x90, 0x88, 0x88, 0x88, 0x88, 0x46, 0x46, 0x46, 0x46, 0xEE, 0xEE, 0xEE, 0xEE
	.byte 0xB8, 0xB8, 0xB8, 0xB8, 0x14, 0x14, 0x14, 0x14, 0xDE, 0xDE, 0xDE, 0xDE, 0x5E, 0x5E, 0x5E, 0x5E
	.byte 0x0B, 0x0B, 0x0B, 0x0B, 0xDB, 0xDB, 0xDB, 0xDB, 0xE0, 0xE0, 0xE0, 0xE0, 0x32, 0x32, 0x32, 0x32
	.byte 0x3A, 0x3A, 0x3A, 0x3A, 0x0A, 0x0A, 0x0A, 0x0A, 0x49, 0x49, 0x49, 0x49, 0x06, 0x06, 0x06, 0x06
	.byte 0x24, 0x24, 0x24, 0x24, 0x5C, 0x5C, 0x5C, 0x5C, 0xC2, 0xC2, 0xC2, 0xC2, 0xD3, 0xD3, 0xD3, 0xD3
	.byte 0xAC, 0xAC, 0xAC, 0xAC, 0x62, 0x62, 0x62, 0x62, 0x91, 0x91, 0x91, 0x91, 0x95, 0x95, 0x95, 0x95
	.byte 0xE4, 0xE4, 0xE4, 0xE4, 0x79, 0x79, 0x79, 0x79, 0xE7, 0xE7, 0xE7, 0xE7, 0xC8, 0xC8, 0xC8, 0xC8
	.byte 0x37, 0x37, 0x37, 0x37, 0x6D, 0x6D, 0x6D, 0x6D, 0x8D, 0x8D, 0x8D, 0x8D, 0xD5, 0xD5, 0xD5, 0xD5
	.byte 0x4E, 0x4E, 0x4E, 0x4E, 0xA9, 0xA9, 0xA9, 0xA9, 0x6C, 0x6C, 0x6C, 0x6C, 0x56, 0x56, 0x56, 0x56
	.byte 0xF4, 0xF4, 0xF4, 0xF4, 0xEA, 0xEA, 0xEA, 0xEA, 0x65, 0x65, 0x65, 0x65, 0x7A, 0x7A, 0x7A, 0x7A
	.byte 0xAE, 0xAE, 0xAE, 0xAE, 0x08, 0x08, 0x08, 0x08, 0xBA, 0xBA, 0xBA, 0xBA, 0x78, 0x78, 0x78, 0x78
	.byte 0x25, 0x25, 0x25, 0x25, 0x2E, 0x2E, 0x2E, 0x2E, 0x1C, 0x1C, 0x1C, 0x1C, 0xA6, 0xA6, 0xA6, 0xA6
	.byte 0xB4, 0xB4, 0xB4, 0xB4, 0xC6, 0xC6, 0xC6, 0xC6, 0xE8, 0xE8, 0xE8, 0xE8, 0xDD, 0xDD, 0xDD, 0xDD
	.byte 0x74, 0x74, 0x74, 0x74, 0x1F, 0x1F, 0x1F, 0x1F, 0x4B, 0x4B, 0x4B, 0x4B, 0xBD, 0xBD, 0xBD, 0xBD
	.byte 0x8B, 0x8B, 0x8B, 0x8B, 0x8A, 0x8A, 0x8A, 0x8A, 0x70, 0x70, 0x70, 0x70, 0x3E, 0x3E, 0x3E, 0x3E
	.byte 0xB5, 0xB5, 0xB5, 0xB5, 0x66, 0x66, 0x66, 0x66, 0x48, 0x48, 0x48, 0x48, 0x03, 0x03, 0x03, 0x03
	.byte 0xF6, 0xF6, 0xF6, 0xF6, 0x0E, 0x0E, 0x0E, 0x0E, 0x61, 0x61, 0x61, 0x61, 0x35, 0x35, 0x35, 0x35
	.byte 0x57, 0x57, 0x57, 0x57, 0xB9, 0xB9, 0xB9, 0xB9, 0x86, 0x86, 0x86, 0x86, 0xC1, 0xC1, 0xC1, 0xC1
	.byte 0x1D, 0x1D, 0x1D, 0x1D, 0x9E, 0x9E, 0x9E, 0x9E, 0xE1, 0xE1, 0xE1, 0xE1, 0xF8, 0xF8, 0xF8, 0xF8
	.byte 0x98, 0x98, 0x98, 0x98, 0x11, 0x11, 0x11, 0x11, 0x69, 0x69, 0x69, 0x69, 0xD9, 0xD9, 0xD9, 0xD9
	.byte 0x8E, 0x8E, 0x8E, 0x8E, 0x94, 0x94, 0x94, 0x94, 0x9B, 0x9B, 0x9B, 0x9B, 0x1E, 0x1E, 0x1E, 0x1E
	.byte 0x87, 0x87, 0x87, 0x87, 0xE9, 0xE9, 0xE9, 0xE9, 0xCE, 0xCE, 0xCE, 0xCE, 0x55, 0x55, 0x55, 0x55
	.byte 0x28, 0x28, 0x28, 0x28, 0xDF, 0xDF, 0xDF, 0xDF, 0x8C, 0x8C, 0x8C, 0x8C, 0xA1, 0xA1, 0xA1, 0xA1
	.byte 0x89, 0x89, 0x89, 0x89, 0x0D, 0x0D, 0x0D, 0x0D, 0xBF, 0xBF, 0xBF, 0xBF, 0xE6, 0xE6, 0xE6, 0xE6
	.byte 0x42, 0x42, 0x42, 0x42, 0x68, 0x68, 0x68, 0x68, 0x41, 0x41, 0x41, 0x41, 0x99, 0x99, 0x99, 0x99
	.byte 0x2D, 0x2D, 0x2D, 0x2D, 0x0F, 0x0F, 0x0F, 0x0F, 0xB0, 0xB0, 0xB0, 0xB0, 0x54, 0x54, 0x54, 0x54
	.byte 0xBB, 0xBB, 0xBB, 0xBB, 0x16, 0x16, 0x16, 0x16, 0x50, 0xA7, 0xF4, 0x51, 0x53, 0x65, 0x41, 0x7E
	.byte 0xC3, 0xA4, 0x17, 0x1A, 0x96, 0x5E, 0x27, 0x3A, 0xCB, 0x6B, 0xAB, 0x3B, 0xF1, 0x45, 0x9D, 0x1F
	.byte 0xAB, 0x58, 0xFA, 0xAC, 0x93, 0x03, 0xE3, 0x4B, 0x55, 0xFA, 0x30, 0x20, 0xF6, 0x6D, 0x76, 0xAD
	.byte 0x91, 0x76, 0xCC, 0x88, 0x25, 0x4C, 0x02, 0xF5, 0xFC, 0xD7, 0xE5, 0x4F, 0xD7, 0xCB, 0x2A, 0xC5
	.byte 0x80, 0x44, 0x35, 0x26, 0x8F, 0xA3, 0x62, 0xB5, 0x49, 0x5A, 0xB1, 0xDE, 0x67, 0x1B, 0xBA, 0x25
	.byte 0x98, 0x0E, 0xEA, 0x45, 0xE1, 0xC0, 0xFE, 0x5D, 0x02, 0x75, 0x2F, 0xC3, 0x12, 0xF0, 0x4C, 0x81
	.byte 0xA3, 0x97, 0x46, 0x8D, 0xC6, 0xF9, 0xD3, 0x6B, 0xE7, 0x5F, 0x8F, 0x03, 0x95, 0x9C, 0x92, 0x15
	.byte 0xEB, 0x7A, 0x6D, 0xBF, 0xDA, 0x59, 0x52, 0x95, 0x2D, 0x83, 0xBE, 0xD4, 0xD3, 0x21, 0x74, 0x58
	.byte 0x29, 0x69, 0xE0, 0x49, 0x44, 0xC8, 0xC9, 0x8E, 0x6A, 0x89, 0xC2, 0x75, 0x78, 0x79, 0x8E, 0xF4
	.byte 0x6B, 0x3E, 0x58, 0x99, 0xDD, 0x71, 0xB9, 0x27, 0xB6, 0x4F, 0xE1, 0xBE, 0x17, 0xAD, 0x88, 0xF0
	.byte 0x66, 0xAC, 0x20, 0xC9, 0xB4, 0x3A, 0xCE, 0x7D, 0x18, 0x4A, 0xDF, 0x63, 0x82, 0x31, 0x1A, 0xE5
	.byte 0x60, 0x33, 0x51, 0x97, 0x45, 0x7F, 0x53, 0x62, 0xE0, 0x77, 0x64, 0xB1, 0x84, 0xAE, 0x6B, 0xBB
	.byte 0x1C, 0xA0, 0x81, 0xFE, 0x94, 0x2B, 0x08, 0xF9, 0x58, 0x68, 0x48, 0x70, 0x19, 0xFD, 0x45, 0x8F
	.byte 0x87, 0x6C, 0xDE, 0x94, 0xB7, 0xF8, 0x7B, 0x52, 0x23, 0xD3, 0x73, 0xAB, 0xE2, 0x02, 0x4B, 0x72
	.byte 0x57, 0x8F, 0x1F, 0xE3, 0x2A, 0xAB, 0x55, 0x66, 0x07, 0x28, 0xEB, 0xB2, 0x03, 0xC2, 0xB5, 0x2F
	.byte 0x9A, 0x7B, 0xC5, 0x86, 0xA5, 0x08, 0x37, 0xD3, 0xF2, 0x87, 0x28, 0x30, 0xB2, 0xA5, 0xBF, 0x23
	.byte 0xBA, 0x6A, 0x03, 0x02, 0x5C, 0x82, 0x16, 0xED, 0x2B, 0x1C, 0xCF, 0x8A, 0x92, 0xB4, 0x79, 0xA7
	.byte 0xF0, 0xF2, 0x07, 0xF3, 0xA1, 0xE2, 0x69, 0x4E, 0xCD, 0xF4, 0xDA, 0x65, 0xD5, 0xBE, 0x05, 0x06
	.byte 0x1F, 0x62, 0x34, 0xD1, 0x8A, 0xFE, 0xA6, 0xC4, 0x9D, 0x53, 0x2E, 0x34, 0xA0, 0x55, 0xF3, 0xA2
	.byte 0x32, 0xE1, 0x8A, 0x05, 0x75, 0xEB, 0xF6, 0xA4, 0x39, 0xEC, 0x83, 0x0B, 0xAA, 0xEF, 0x60, 0x40
	.byte 0x06, 0x9F, 0x71, 0x5E, 0x51, 0x10, 0x6E, 0xBD, 0xF9, 0x8A, 0x21, 0x3E, 0x3D, 0x06, 0xDD, 0x96
	.byte 0xAE, 0x05, 0x3E, 0xDD, 0x46, 0xBD, 0xE6, 0x4D, 0xB5, 0x8D, 0x54, 0x91, 0x05, 0x5D, 0xC4, 0x71
	.byte 0x6F, 0xD4, 0x06, 0x04, 0xFF, 0x15, 0x50, 0x60, 0x24, 0xFB, 0x98, 0x19, 0x97, 0xE9, 0xBD, 0xD6
	.byte 0xCC, 0x43, 0x40, 0x89, 0x77, 0x9E, 0xD9, 0x67, 0xBD, 0x42, 0xE8, 0xB0, 0x88, 0x8B, 0x89, 0x07
	.byte 0x38, 0x5B, 0x19, 0xE7, 0xDB, 0xEE, 0xC8, 0x79, 0x47, 0x0A, 0x7C, 0xA1, 0xE9, 0x0F, 0x42, 0x7C
	.byte 0xC9, 0x1E, 0x84, 0xF8, 0x00, 0x00, 0x00, 0x00, 0x83, 0x86, 0x80, 0x09, 0x48, 0xED, 0x2B, 0x32
	.byte 0xAC, 0x70, 0x11, 0x1E, 0x4E, 0x72, 0x5A, 0x6C, 0xFB, 0xFF, 0x0E, 0xFD, 0x56, 0x38, 0x85, 0x0F
	.byte 0x1E, 0xD5, 0xAE, 0x3D, 0x27, 0x39, 0x2D, 0x36, 0x64, 0xD9, 0x0F, 0x0A, 0x21, 0xA6, 0x5C, 0x68
	.byte 0xD1, 0x54, 0x5B, 0x9B, 0x3A, 0x2E, 0x36, 0x24, 0xB1, 0x67, 0x0A, 0x0C, 0x0F, 0xE7, 0x57, 0x93
	.byte 0xD2, 0x96, 0xEE, 0xB4, 0x9E, 0x91, 0x9B, 0x1B, 0x4F, 0xC5, 0xC0, 0x80, 0xA2, 0x20, 0xDC, 0x61
	.byte 0x69, 0x4B, 0x77, 0x5A, 0x16, 0x1A, 0x12, 0x1C, 0x0A, 0xBA, 0x93, 0xE2, 0xE5, 0x2A, 0xA0, 0xC0
	.byte 0x43, 0xE0, 0x22, 0x3C, 0x1D, 0x17, 0x1B, 0x12, 0x0B, 0x0D, 0x09, 0x0E, 0xAD, 0xC7, 0x8B, 0xF2
	.byte 0xB9, 0xA8, 0xB6, 0x2D, 0xC8, 0xA9, 0x1E, 0x14, 0x85, 0x19, 0xF1, 0x57, 0x4C, 0x07, 0x75, 0xAF
	.byte 0xBB, 0xDD, 0x99, 0xEE, 0xFD, 0x60, 0x7F, 0xA3, 0x9F, 0x26, 0x01, 0xF7, 0xBC, 0xF5, 0x72, 0x5C
	.byte 0xC5, 0x3B, 0x66, 0x44, 0x34, 0x7E, 0xFB, 0x5B, 0x76, 0x29, 0x43, 0x8B, 0xDC, 0xC6, 0x23, 0xCB
	.byte 0x68, 0xFC, 0xED, 0xB6, 0x63, 0xF1, 0xE4, 0xB8, 0xCA, 0xDC, 0x31, 0xD7, 0x10, 0x85, 0x63, 0x42
	.byte 0x40, 0x22, 0x97, 0x13, 0x20, 0x11, 0xC6, 0x84, 0x7D, 0x24, 0x4A, 0x85, 0xF8, 0x3D, 0xBB, 0xD2
	.byte 0x11, 0x32, 0xF9, 0xAE, 0x6D, 0xA1, 0x29, 0xC7, 0x4B, 0x2F, 0x9E, 0x1D, 0xF3, 0x30, 0xB2, 0xDC
	.byte 0xEC, 0x52, 0x86, 0x0D, 0xD0, 0xE3, 0xC1, 0x77, 0x6C, 0x16, 0xB3, 0x2B, 0x99, 0xB9, 0x70, 0xA9
	.byte 0xFA, 0x48, 0x94, 0x11, 0x22, 0x64, 0xE9, 0x47, 0xC4, 0x8C, 0xFC, 0xA8, 0x1A, 0x3F, 0xF0, 0xA0
	.byte 0xD8, 0x2C, 0x7D, 0x56, 0xEF, 0x90, 0x33, 0x22, 0xC7, 0x4E, 0x49, 0x87, 0xC1, 0xD1, 0x38, 0xD9
	.byte 0xFE, 0xA2, 0xCA, 0x8C, 0x36, 0x0B, 0xD4, 0x98, 0xCF, 0x81, 0xF5, 0xA6, 0x28, 0xDE, 0x7A, 0xA5
	.byte 0x26, 0x8E, 0xB7, 0xDA, 0xA4, 0xBF, 0xAD, 0x3F, 0xE4, 0x9D, 0x3A, 0x2C, 0x0D, 0x92, 0x78, 0x50
	.byte 0x9B, 0xCC, 0x5F, 0x6A, 0x62, 0x46, 0x7E, 0x54, 0xC2, 0x13, 0x8D, 0xF6, 0xE8, 0xB8, 0xD8, 0x90
	.byte 0x5E, 0xF7, 0x39, 0x2E, 0xF5, 0xAF, 0xC3, 0x82, 0xBE, 0x80, 0x5D, 0x9F, 0x7C, 0x93, 0xD0, 0x69
	.byte 0xA9, 0x2D, 0xD5, 0x6F, 0xB3, 0x12, 0x25, 0xCF, 0x3B, 0x99, 0xAC, 0xC8, 0xA7, 0x7D, 0x18, 0x10
	.byte 0x6E, 0x63, 0x9C, 0xE8, 0x7B, 0xBB, 0x3B, 0xDB, 0x09, 0x78, 0x26, 0xCD, 0xF4, 0x18, 0x59, 0x6E
	.byte 0x01, 0xB7, 0x9A, 0xEC, 0xA8, 0x9A, 0x4F, 0x83, 0x65, 0x6E, 0x95, 0xE6, 0x7E, 0xE6, 0xFF, 0xAA
	.byte 0x08, 0xCF, 0xBC, 0x21, 0xE6, 0xE8, 0x15, 0xEF, 0xD9, 0x9B, 0xE7, 0xBA, 0xCE, 0x36, 0x6F, 0x4A
	.byte 0xD4, 0x09, 0x9F, 0xEA, 0xD6, 0x7C, 0xB0, 0x29, 0xAF, 0xB2, 0xA4, 0x31, 0x31, 0x23, 0x3F, 0x2A
	.byte 0x30, 0x94, 0xA5, 0xC6, 0xC0, 0x66, 0xA2, 0x35, 0x37, 0xBC, 0x4E, 0x74, 0xA6, 0xCA, 0x82, 0xFC
	.byte 0xB0, 0xD0, 0x90, 0xE0, 0x15, 0xD8, 0xA7, 0x33, 0x4A, 0x98, 0x04, 0xF1, 0xF7, 0xDA, 0xEC, 0x41
	.byte 0x0E, 0x50, 0xCD, 0x7F, 0x2F, 0xF6, 0x91, 0x17, 0x8D, 0xD6, 0x4D, 0x76, 0x4D, 0xB0, 0xEF, 0x43
	.byte 0x54, 0x4D, 0xAA, 0xCC, 0xDF, 0x04, 0x96, 0xE4, 0xE3, 0xB5, 0xD1, 0x9E, 0x1B, 0x88, 0x6A, 0x4C
	.byte 0xB8, 0x1F, 0x2C, 0xC1, 0x7F, 0x51, 0x65, 0x46, 0x04, 0xEA, 0x5E, 0x9D, 0x5D, 0x35, 0x8C, 0x01
	.byte 0x73, 0x74, 0x87, 0xFA, 0x2E, 0x41, 0x0B, 0xFB, 0x5A, 0x1D, 0x67, 0xB3, 0x52, 0xD2, 0xDB, 0x92
	.byte 0x33, 0x56, 0x10, 0xE9, 0x13, 0x47, 0xD6, 0x6D, 0x8C, 0x61, 0xD7, 0x9A, 0x7A, 0x0C, 0xA1, 0x37
	.byte 0x8E, 0x14, 0xF8, 0x59, 0x89, 0x3C, 0x13, 0xEB, 0xEE, 0x27, 0xA9, 0xCE, 0x35, 0xC9, 0x61, 0xB7
	.byte 0xED, 0xE5, 0x1C, 0xE1, 0x3C, 0xB1, 0x47, 0x7A, 0x59, 0xDF, 0xD2, 0x9C, 0x3F, 0x73, 0xF2, 0x55
	.byte 0x79, 0xCE, 0x14, 0x18, 0xBF, 0x37, 0xC7, 0x73, 0xEA, 0xCD, 0xF7, 0x53, 0x5B, 0xAA, 0xFD, 0x5F
	.byte 0x14, 0x6F, 0x3D, 0xDF, 0x86, 0xDB, 0x44, 0x78, 0x81, 0xF3, 0xAF, 0xCA, 0x3E, 0xC4, 0x68, 0xB9
	.byte 0x2C, 0x34, 0x24, 0x38, 0x5F, 0x40, 0xA3, 0xC2, 0x72, 0xC3, 0x1D, 0x16, 0x0C, 0x25, 0xE2, 0xBC
	.byte 0x8B, 0x49, 0x3C, 0x28, 0x41, 0x95, 0x0D, 0xFF, 0x71, 0x01, 0xA8, 0x39, 0xDE, 0xB3, 0x0C, 0x08
	.byte 0x9C, 0xE4, 0xB4, 0xD8, 0x90, 0xC1, 0x56, 0x64, 0x61, 0x84, 0xCB, 0x7B, 0x70, 0xB6, 0x32, 0xD5
	.byte 0x74, 0x5C, 0x6C, 0x48, 0x42, 0x57, 0xB8, 0xD0, 0xA7, 0xF4, 0x51, 0x50, 0x65, 0x41, 0x7E, 0x53
	.byte 0xA4, 0x17, 0x1A, 0xC3, 0x5E, 0x27, 0x3A, 0x96, 0x6B, 0xAB, 0x3B, 0xCB, 0x45, 0x9D, 0x1F, 0xF1
	.byte 0x58, 0xFA, 0xAC, 0xAB, 0x03, 0xE3, 0x4B, 0x93, 0xFA, 0x30, 0x20, 0x55, 0x6D, 0x76, 0xAD, 0xF6
	.byte 0x76, 0xCC, 0x88, 0x91, 0x4C, 0x02, 0xF5, 0x25, 0xD7, 0xE5, 0x4F, 0xFC, 0xCB, 0x2A, 0xC5, 0xD7
	.byte 0x44, 0x35, 0x26, 0x80, 0xA3, 0x62, 0xB5, 0x8F, 0x5A, 0xB1, 0xDE, 0x49, 0x1B, 0xBA, 0x25, 0x67
	.byte 0x0E, 0xEA, 0x45, 0x98, 0xC0, 0xFE, 0x5D, 0xE1, 0x75, 0x2F, 0xC3, 0x02, 0xF0, 0x4C, 0x81, 0x12
	.byte 0x97, 0x46, 0x8D, 0xA3, 0xF9, 0xD3, 0x6B, 0xC6, 0x5F, 0x8F, 0x03, 0xE7, 0x9C, 0x92, 0x15, 0x95
	.byte 0x7A, 0x6D, 0xBF, 0xEB, 0x59, 0x52, 0x95, 0xDA, 0x83, 0xBE, 0xD4, 0x2D, 0x21, 0x74, 0x58, 0xD3
	.byte 0x69, 0xE0, 0x49, 0x29, 0xC8, 0xC9, 0x8E, 0x44, 0x89, 0xC2, 0x75, 0x6A, 0x79, 0x8E, 0xF4, 0x78
	.byte 0x3E, 0x58, 0x99, 0x6B, 0x71, 0xB9, 0x27, 0xDD, 0x4F, 0xE1, 0xBE, 0xB6, 0xAD, 0x88, 0xF0, 0x17
	.byte 0xAC, 0x20, 0xC9, 0x66, 0x3A, 0xCE, 0x7D, 0xB4, 0x4A, 0xDF, 0x63, 0x18, 0x31, 0x1A, 0xE5, 0x82
	.byte 0x33, 0x51, 0x97, 0x60, 0x7F, 0x53, 0x62, 0x45, 0x77, 0x64, 0xB1, 0xE0, 0xAE, 0x6B, 0xBB, 0x84
	.byte 0xA0, 0x81, 0xFE, 0x1C, 0x2B, 0x08, 0xF9, 0x94, 0x68, 0x48, 0x70, 0x58, 0xFD, 0x45, 0x8F, 0x19
	.byte 0x6C, 0xDE, 0x94, 0x87, 0xF8, 0x7B, 0x52, 0xB7, 0xD3, 0x73, 0xAB, 0x23, 0x02, 0x4B, 0x72, 0xE2
	.byte 0x8F, 0x1F, 0xE3, 0x57, 0xAB, 0x55, 0x66, 0x2A, 0x28, 0xEB, 0xB2, 0x07, 0xC2, 0xB5, 0x2F, 0x03
	.byte 0x7B, 0xC5, 0x86, 0x9A, 0x08, 0x37, 0xD3, 0xA5, 0x87, 0x28, 0x30, 0xF2, 0xA5, 0xBF, 0x23, 0xB2
	.byte 0x6A, 0x03, 0x02, 0xBA, 0x82, 0x16, 0xED, 0x5C, 0x1C, 0xCF, 0x8A, 0x2B, 0xB4, 0x79, 0xA7, 0x92
	.byte 0xF2, 0x07, 0xF3, 0xF0, 0xE2, 0x69, 0x4E, 0xA1, 0xF4, 0xDA, 0x65, 0xCD, 0xBE, 0x05, 0x06, 0xD5
	.byte 0x62, 0x34, 0xD1, 0x1F, 0xFE, 0xA6, 0xC4, 0x8A, 0x53, 0x2E, 0x34, 0x9D, 0x55, 0xF3, 0xA2, 0xA0
	.byte 0xE1, 0x8A, 0x05, 0x32, 0xEB, 0xF6, 0xA4, 0x75, 0xEC, 0x83, 0x0B, 0x39, 0xEF, 0x60, 0x40, 0xAA
	.byte 0x9F, 0x71, 0x5E, 0x06, 0x10, 0x6E, 0xBD, 0x51, 0x8A, 0x21, 0x3E, 0xF9, 0x06, 0xDD, 0x96, 0x3D
	.byte 0x05, 0x3E, 0xDD, 0xAE, 0xBD, 0xE6, 0x4D, 0x46, 0x8D, 0x54, 0x91, 0xB5, 0x5D, 0xC4, 0x71, 0x05
	.byte 0xD4, 0x06, 0x04, 0x6F, 0x15, 0x50, 0x60, 0xFF, 0xFB, 0x98, 0x19, 0x24, 0xE9, 0xBD, 0xD6, 0x97
	.byte 0x43, 0x40, 0x89, 0xCC, 0x9E, 0xD9, 0x67, 0x77, 0x42, 0xE8, 0xB0, 0xBD, 0x8B, 0x89, 0x07, 0x88
	.byte 0x5B, 0x19, 0xE7, 0x38, 0xEE, 0xC8, 0x79, 0xDB, 0x0A, 0x7C, 0xA1, 0x47, 0x0F, 0x42, 0x7C, 0xE9
	.byte 0x1E, 0x84, 0xF8, 0xC9, 0x00, 0x00, 0x00, 0x00, 0x86, 0x80, 0x09, 0x83, 0xED, 0x2B, 0x32, 0x48
	.byte 0x70, 0x11, 0x1E, 0xAC, 0x72, 0x5A, 0x6C, 0x4E, 0xFF, 0x0E, 0xFD, 0xFB, 0x38, 0x85, 0x0F, 0x56
	.byte 0xD5, 0xAE, 0x3D, 0x1E, 0x39, 0x2D, 0x36, 0x27, 0xD9, 0x0F, 0x0A, 0x64, 0xA6, 0x5C, 0x68, 0x21
	.byte 0x54, 0x5B, 0x9B, 0xD1, 0x2E, 0x36, 0x24, 0x3A, 0x67, 0x0A, 0x0C, 0xB1, 0xE7, 0x57, 0x93, 0x0F
	.byte 0x96, 0xEE, 0xB4, 0xD2, 0x91, 0x9B, 0x1B, 0x9E, 0xC5, 0xC0, 0x80, 0x4F, 0x20, 0xDC, 0x61, 0xA2
	.byte 0x4B, 0x77, 0x5A, 0x69, 0x1A, 0x12, 0x1C, 0x16, 0xBA, 0x93, 0xE2, 0x0A, 0x2A, 0xA0, 0xC0, 0xE5
	.byte 0xE0, 0x22, 0x3C, 0x43, 0x17, 0x1B, 0x12, 0x1D, 0x0D, 0x09, 0x0E, 0x0B, 0xC7, 0x8B, 0xF2, 0xAD
	.byte 0xA8, 0xB6, 0x2D, 0xB9, 0xA9, 0x1E, 0x14, 0xC8, 0x19, 0xF1, 0x57, 0x85, 0x07, 0x75, 0xAF, 0x4C
	.byte 0xDD, 0x99, 0xEE, 0xBB, 0x60, 0x7F, 0xA3, 0xFD, 0x26, 0x01, 0xF7, 0x9F, 0xF5, 0x72, 0x5C, 0xBC
	.byte 0x3B, 0x66, 0x44, 0xC5, 0x7E, 0xFB, 0x5B, 0x34, 0x29, 0x43, 0x8B, 0x76, 0xC6, 0x23, 0xCB, 0xDC
	.byte 0xFC, 0xED, 0xB6, 0x68, 0xF1, 0xE4, 0xB8, 0x63, 0xDC, 0x31, 0xD7, 0xCA, 0x85, 0x63, 0x42, 0x10
	.byte 0x22, 0x97, 0x13, 0x40, 0x11, 0xC6, 0x84, 0x20, 0x24, 0x4A, 0x85, 0x7D, 0x3D, 0xBB, 0xD2, 0xF8
	.byte 0x32, 0xF9, 0xAE, 0x11, 0xA1, 0x29, 0xC7, 0x6D, 0x2F, 0x9E, 0x1D, 0x4B, 0x30, 0xB2, 0xDC, 0xF3
	.byte 0x52, 0x86, 0x0D, 0xEC, 0xE3, 0xC1, 0x77, 0xD0, 0x16, 0xB3, 0x2B, 0x6C, 0xB9, 0x70, 0xA9, 0x99
	.byte 0x48, 0x94, 0x11, 0xFA, 0x64, 0xE9, 0x47, 0x22, 0x8C, 0xFC, 0xA8, 0xC4, 0x3F, 0xF0, 0xA0, 0x1A
	.byte 0x2C, 0x7D, 0x56, 0xD8, 0x90, 0x33, 0x22, 0xEF, 0x4E, 0x49, 0x87, 0xC7, 0xD1, 0x38, 0xD9, 0xC1
	.byte 0xA2, 0xCA, 0x8C, 0xFE, 0x0B, 0xD4, 0x98, 0x36, 0x81, 0xF5, 0xA6, 0xCF, 0xDE, 0x7A, 0xA5, 0x28
	.byte 0x8E, 0xB7, 0xDA, 0x26, 0xBF, 0xAD, 0x3F, 0xA4, 0x9D, 0x3A, 0x2C, 0xE4, 0x92, 0x78, 0x50, 0x0D
	.byte 0xCC, 0x5F, 0x6A, 0x9B, 0x46, 0x7E, 0x54, 0x62, 0x13, 0x8D, 0xF6, 0xC2, 0xB8, 0xD8, 0x90, 0xE8
	.byte 0xF7, 0x39, 0x2E, 0x5E, 0xAF, 0xC3, 0x82, 0xF5, 0x80, 0x5D, 0x9F, 0xBE, 0x93, 0xD0, 0x69, 0x7C
	.byte 0x2D, 0xD5, 0x6F, 0xA9, 0x12, 0x25, 0xCF, 0xB3, 0x99, 0xAC, 0xC8, 0x3B, 0x7D, 0x18, 0x10, 0xA7
	.byte 0x63, 0x9C, 0xE8, 0x6E, 0xBB, 0x3B, 0xDB, 0x7B, 0x78, 0x26, 0xCD, 0x09, 0x18, 0x59, 0x6E, 0xF4
	.byte 0xB7, 0x9A, 0xEC, 0x01, 0x9A, 0x4F, 0x83, 0xA8, 0x6E, 0x95, 0xE6, 0x65, 0xE6, 0xFF, 0xAA, 0x7E
	.byte 0xCF, 0xBC, 0x21, 0x08, 0xE8, 0x15, 0xEF, 0xE6, 0x9B, 0xE7, 0xBA, 0xD9, 0x36, 0x6F, 0x4A, 0xCE
	.byte 0x09, 0x9F, 0xEA, 0xD4, 0x7C, 0xB0, 0x29, 0xD6, 0xB2, 0xA4, 0x31, 0xAF, 0x23, 0x3F, 0x2A, 0x31
	.byte 0x94, 0xA5, 0xC6, 0x30, 0x66, 0xA2, 0x35, 0xC0, 0xBC, 0x4E, 0x74, 0x37, 0xCA, 0x82, 0xFC, 0xA6
	.byte 0xD0, 0x90, 0xE0, 0xB0, 0xD8, 0xA7, 0x33, 0x15, 0x98, 0x04, 0xF1, 0x4A, 0xDA, 0xEC, 0x41, 0xF7
	.byte 0x50, 0xCD, 0x7F, 0x0E, 0xF6, 0x91, 0x17, 0x2F, 0xD6, 0x4D, 0x76, 0x8D, 0xB0, 0xEF, 0x43, 0x4D
	.byte 0x4D, 0xAA, 0xCC, 0x54, 0x04, 0x96, 0xE4, 0xDF, 0xB5, 0xD1, 0x9E, 0xE3, 0x88, 0x6A, 0x4C, 0x1B
	.byte 0x1F, 0x2C, 0xC1, 0xB8, 0x51, 0x65, 0x46, 0x7F, 0xEA, 0x5E, 0x9D, 0x04, 0x35, 0x8C, 0x01, 0x5D
	.byte 0x74, 0x87, 0xFA, 0x73, 0x41, 0x0B, 0xFB, 0x2E, 0x1D, 0x67, 0xB3, 0x5A, 0xD2, 0xDB, 0x92, 0x52
	.byte 0x56, 0x10, 0xE9, 0x33, 0x47, 0xD6, 0x6D, 0x13, 0x61, 0xD7, 0x9A, 0x8C, 0x0C, 0xA1, 0x37, 0x7A
	.byte 0x14, 0xF8, 0x59, 0x8E, 0x3C, 0x13, 0xEB, 0x89, 0x27, 0xA9, 0xCE, 0xEE, 0xC9, 0x61, 0xB7, 0x35
	.byte 0xE5, 0x1C, 0xE1, 0xED, 0xB1, 0x47, 0x7A, 0x3C, 0xDF, 0xD2, 0x9C, 0x59, 0x73, 0xF2, 0x55, 0x3F
	.byte 0xCE, 0x14, 0x18, 0x79, 0x37, 0xC7, 0x73, 0xBF, 0xCD, 0xF7, 0x53, 0xEA, 0xAA, 0xFD, 0x5F, 0x5B
	.byte 0x6F, 0x3D, 0xDF, 0x14, 0xDB, 0x44, 0x78, 0x86, 0xF3, 0xAF, 0xCA, 0x81, 0xC4, 0x68, 0xB9, 0x3E
	.byte 0x34, 0x24, 0x38, 0x2C, 0x40, 0xA3, 0xC2, 0x5F, 0xC3, 0x1D, 0x16, 0x72, 0x25, 0xE2, 0xBC, 0x0C
	.byte 0x49, 0x3C, 0x28, 0x8B, 0x95, 0x0D, 0xFF, 0x41, 0x01, 0xA8, 0x39, 0x71, 0xB3, 0x0C, 0x08, 0xDE
	.byte 0xE4, 0xB4, 0xD8, 0x9C, 0xC1, 0x56, 0x64, 0x90, 0x84, 0xCB, 0x7B, 0x61, 0xB6, 0x32, 0xD5, 0x70
	.byte 0x5C, 0x6C, 0x48, 0x74, 0x57, 0xB8, 0xD0, 0x42, 0x0E, 0x04, 0x05, 0x00, 0xE6, 0x00, 0x8B, 0x00
	.byte 0x00, 0x00, 0xA8, 0x00, 0x78, 0x00, 0x10, 0x00, 0x02, 0x01, 0x01, 0x02, 0x01, 0x01, 0x02, 0x00
	.byte 0x08, 0x00, 0xAC, 0x00, 0x84, 0x00, 0xAC, 0x00, 0x27, 0x1F, 0x25, 0x00, 0x27, 0x00, 0x23, 0x1D
	.byte 0x21, 0x00, 0x59, 0x00, 0x27, 0x21, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01
	.byte 0x01, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00, 0xD8, 0x00, 0x40, 0x00
	.byte 0x0D, 0x00, 0x3C, 0x00, 0xE6, 0x00, 0x5E, 0x00, 0x0D, 0x00, 0x28, 0x00, 0xE6, 0x00, 0x70, 0x00