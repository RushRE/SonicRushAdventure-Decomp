	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start sub_20CC00C
sub_20CC00C: // 0x020CC00C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20CB194
	add r1, r0, #0x2000
	cmp r4, #0
	ldr r0, [r1, #0x270]
	ldmeqia sp!, {r4, lr}
	bxeq lr
	cmp r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r1, [r1, #0x274]
	cmp r1, #0xc
	ldmlsia sp!, {r4, lr}
	bxls lr
	ldr r3, [r0, #4]
	cmp r3, #0
	beq _020CC09C
_020CC054:
	cmp r3, r4
	bne _020CC090
	ldr r2, [r3, #8]
	cmp r2, #0
	ldrne r1, [r3, #0xc]
	strne r1, [r2, #0xc]
	ldreq r1, [r3, #0xc]
	streq r1, [r0, #4]
	ldr r2, [r3, #0xc]
	cmp r2, #0
	ldrne r1, [r3, #8]
	strne r1, [r2, #8]
	ldreq r1, [r3, #8]
	streq r1, [r0, #8]
	b _020CC09C
_020CC090:
	ldr r3, [r3, #0xc]
	cmp r3, #0
	bne _020CC054
_020CC09C:
	mov r1, #0
	str r1, [r4, #0xc]
	ldr r1, [r0, #8]
	str r1, [r4, #8]
	str r4, [r0, #8]
	ldr r1, [r4, #8]
	cmp r1, #0
	strne r4, [r1, #0xc]
	streq r4, [r0, #4]
	cmp r3, #0
	ldreq r1, [r0]
	streq r1, [r4, #4]
	ldreq r1, [r0]
	addeq r1, r1, #1
	streq r1, [r0]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20CC00C

	arm_func_start sub_20CC0E0
sub_20CC0E0: // 0x020CC0E0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20CB194
	add r1, r0, #0x2000
	ldr r2, [r1, #0x270]
	mov r0, #0
	cmp r2, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r1, [r1, #0x274]
	cmp r1, #0xc
	ldmlsia sp!, {r4, lr}
	bxls lr
	ldr r0, [r2, #4]
	cmp r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
_020CC124:
	ldr r1, [r0, #4]
	cmp r1, r4
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _020CC124
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20CC0E0

	arm_func_start sub_20CC148
sub_20CC148: // 0x020CC148
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl sub_20CB194
	add r0, r0, #0x2000
	cmp r5, #0
	mov r4, #0
	ldr r1, [r0, #0x270]
	addeq sp, sp, #4
	moveq r0, r4
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	cmp r1, #0
	beq _020CC1BC
	ldr r0, [r0, #0x274]
	cmp r0, #0xc
	bls _020CC1BC
	ldr r4, [r1, #4]
	cmp r4, #0
	beq _020CC1BC
_020CC198:
	add r0, r4, #0x10
	mov r1, r5
	add r0, r0, #4
	bl sub_20CCBD4
	cmp r0, #0
	bne _020CC1BC
	ldr r4, [r4, #0xc]
	cmp r4, #0
	bne _020CC198
_020CC1BC:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20CC148

	arm_func_start sub_20CC1CC
sub_20CC1CC: // 0x020CC1CC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20CB194
	add r0, r0, #0x2000
	ldr r1, [r0, #0x270]
	cmp r1, #0
	beq _020CC200
	ldr r0, [r0, #0x274]
	cmp r0, #0xc
	addhi sp, sp, #4
	ldrhi r0, [r1, #4]
	ldmhiia sp!, {lr}
	bxhi lr
_020CC200:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20CC1CC

	arm_func_start sub_20CC210
sub_20CC210: // 0x020CC210
	stmdb sp!, {r4, lr}
	bl sub_20CB194
	add r2, r0, #0x2000
	ldr r1, [r2, #0x270]
	mov r0, #0
	cmp r1, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r3, [r2, #0x274]
	cmp r3, #0xc
	ldmlsia sp!, {r4, lr}
	bxls lr
	ldr r2, _020CC2F0 // =0x4EC4EC4F
	sub r3, r3, #0xc
	umull r2, r4, r3, r2
	movs r4, r4, lsr #6
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r2, [r1]
	cmp r4, r2
	ldmlsia sp!, {r4, lr}
	bxls lr
	mov lr, r0
	cmp r4, #0
	bls _020CC29C
	add ip, r1, #0xc
	mov r2, #0xd0
_020CC27C:
	mul r0, lr, r2
	ldrb r3, [ip, r0]
	add r0, ip, r0
	cmp r3, #0
	beq _020CC29C
	add lr, lr, #1
	cmp lr, r4
	blo _020CC27C
_020CC29C:
	cmp lr, r4
	ldmhsia sp!, {r4, lr}
	bxhs lr
	mov r2, #1
	strb r2, [r0]
	ldr r3, [r1]
	mov r2, #0
	str r3, [r0, #4]
	str r2, [r0, #0xc]
	ldr r2, [r1, #8]
	str r2, [r0, #8]
	str r0, [r1, #8]
	ldr r2, [r0, #8]
	cmp r2, #0
	strne r0, [r2, #0xc]
	streq r0, [r1, #4]
	ldr r2, [r1]
	add r2, r2, #1
	str r2, [r1]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CC2F0: .word 0x4EC4EC4F
	arm_func_end sub_20CC210

	arm_func_start sub_20CC2F4
sub_20CC2F4: // 0x020CC2F4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl sub_20CB194
	movs r7, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	add r0, r7, #0x2000
	ldrb r0, [r0, #0x26a]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	ldrh r0, [r5, #0x3c]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	add r0, r5, #4
	bl sub_20CC148
	movs r6, r0
	bne _020CC35C
	bl sub_20CC210
	mov r6, r0
_020CC35C:
	cmp r6, #0
	bne _020CC37C
	add r0, r7, #0x2000
	ldr r0, [r0, #0x278]
	cmp r0, #1
	bne _020CC37C
	bl sub_20CC1CC
	mov r6, r0
_020CC37C:
	cmp r6, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r0, r5
	add r1, r6, #0x10
	mov r2, #0xc0
	strh r4, [r6, #2]
	bl MIi_CpuCopyFast
	mov r0, r6
	bl sub_20CC00C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20CC2F4

	arm_func_start sub_20CC3B4
sub_20CC3B4: // 0x020CC3B4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	bl OS_DisableInterrupts
	mov r5, r0
	bl sub_20CB194
	cmp r0, #0
	bne _020CC3EC
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CC3EC:
	mov r0, r4
	bl sub_20CC0E0
	movs r4, r0
	bne _020CC414
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CC414:
	mov r0, r5
	bl OS_RestoreInterrupts
	add r0, r4, #0x10
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20CC3B4

	arm_func_start sub_20CC42C
sub_20CC42C: // 0x020CC42C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	mov r4, r0
	bl sub_20CB194
	cmp r0, #0
	bne _020CC464
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CC464:
	cmp r5, #0
	beq _020CC490
	add r1, r0, #0x2000
	ldrb r1, [r1, #0x26a]
	add r0, r0, #0x2000
	cmp r1, #0
	movne r5, #1
	mov r1, #1
	moveq r5, #0
	strb r1, [r0, #0x26a]
	b _020CC4B0
_020CC490:
	add r1, r0, #0x2000
	ldrb r1, [r1, #0x26a]
	add r0, r0, #0x2000
	cmp r1, #0
	movne r5, #1
	mov r1, #0
	moveq r5, #0
	strb r1, [r0, #0x26a]
_020CC4B0:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20CC42C

	arm_func_start sub_20CC4C8
sub_20CC4C8: // 0x020CC4C8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	mov r5, r0
	bl sub_20CB194
	cmp r0, #0
	mov r4, #0
	bne _020CC500
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, r4
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CC500:
	add r0, r0, #0x2000
	ldr r1, [r0, #0x270]
	cmp r1, #0
	beq _020CC51C
	ldr r0, [r0, #0x274]
	cmp r0, #0xc
	ldrhi r4, [r1]
_020CC51C:
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20CC4C8

	arm_func_start sub_20CC534
sub_20CC534: // 0x020CC534
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	mov r4, r0
	bl sub_20CB194
	cmp r0, #0
	bne _020CC55C
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
_020CC55C:
	add r1, r0, #0x2000
	ldr r0, [r1, #0x270]
	cmp r0, #0
	beq _020CC580
	ldr r2, [r1, #0x274]
	cmp r2, #0
	ble _020CC580
	mov r1, #0
	bl MI_CpuFill8
_020CC580:
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20CC534
