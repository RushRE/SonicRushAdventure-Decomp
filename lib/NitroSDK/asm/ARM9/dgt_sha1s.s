	.include "asm/macros.inc"
	.include "global.inc"

	.text

// This function must've been made using asm, because this doesn't make sense for a C-compiled output..
_020ECEE0: .word 0x00FF00FF
_020ECEE4: .word 0x5A827999
_020ECEE8: .word 0x6ED9EBA1
_020ECEEC: .word 0x8F1BBCDC
_020ECEF0: .word 0xCA62C1D6

    arm_func_start DGTi_hash2_arm4_small
DGTi_hash2_arm4_small: // 0x020ECEF4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, ip, lr}
	ldmia r0, {r3, r9, r10, r11, ip}
	sub sp, sp, #0x84
	str r2, [sp, #0x80]
_020ECF04:
	ldr r8, _020ECEE4 // =0x5A827999
	ldr r7, _020ECEE0 // =0x00FF00FF
	mov r6, sp
	mov r5, #0
_020ECF14:
	ldr r4, [r1], #4
	add r2, r8, ip
	add r2, r2, r3, ror #27
	and lr, r4, r7
	and r4, r7, r4, ror #24
	orr r4, r4, lr, ror #8
	str r4, [r6, #0x40]
	str r4, [r6], #4
	add r2, r2, r4
	eor r4, r10, r11
	and r4, r4, r9
	eor r4, r4, r11
	add r2, r2, r4
	mov r9, r9, ror #2
	mov ip, r11
	mov r11, r10
	mov r10, r9
	mov r9, r3
	mov r3, r2
	add r5, r5, #4
	cmp r5, #0x40
	blt _020ECF14
	mov r7, #0
	mov r6, sp
_020ECF74:
	ldr r2, [r6]
	ldr r5, [r6, #8]
	ldr r4, [r6, #0x20]
	ldr lr, [r6, #0x34]
	eor r2, r2, r5
	eor r4, r4, lr
	eor r2, r2, r4
	mov r2, r2, ror #0x1f
	str r2, [r6, #0x40]
	str r2, [r6], #4
	add r2, r2, ip
	add r2, r2, r8
	add r2, r2, r3, ror #27
	eor r4, r10, r11
	and r4, r4, r9
	eor r4, r4, r11
	add r2, r2, r4
	mov r9, r9, ror #2
	mov ip, r11
	mov r11, r10
	mov r10, r9
	mov r9, r3
	mov r3, r2
	add r7, r7, #4
	cmp r7, #0x10
	blt _020ECF74
	ldr r8, _020ECEE8 // =0x6ED9EBA1
	mov r7, #0
_020ECFE4:
	ldr r2, [r6]
	ldr r4, [r6, #8]
	ldr lr, [r6, #0x20]
	ldr r5, [r6, #0x34]
	eor r2, r2, r4
	eor lr, lr, r5
	eor r2, r2, lr
	mov r2, r2, ror #0x1f
	str r2, [r6, #0x40]
	str r2, [r6], #4
	add r2, r2, ip
	add r2, r2, r8
	add r2, r2, r3, ror #27
	eor lr, r9, r10
	eor lr, lr, r11
	add r2, r2, lr
	mov r9, r9, ror #2
	mov ip, r11
	mov r11, r10
	mov r10, r9
	mov r9, r3
	mov r3, r2
	add r7, r7, #1
	cmp r7, #0xc
	moveq r6, sp
	cmp r7, #0x14
	blt _020ECFE4
	ldr r8, _020ECEEC // =0x8F1BBCDC
	mov r7, #0
_020ED058:
	ldr r2, [r6]
	ldr lr, [r6, #8]
	ldr r5, [r6, #0x20]
	ldr r4, [r6, #0x34]
	eor r2, r2, lr
	eor r5, r5, r4
	eor r2, r2, r5
	mov r2, r2, ror #0x1f
	str r2, [r6, #0x40]
	str r2, [r6], #4
	add r2, r2, ip
	add r2, r2, r8
	add r2, r2, r3, ror #27
	orr r5, r9, r10
	and r5, r5, r11
	and r4, r9, r10
	orr r5, r5, r4
	add r2, r2, r5
	mov r9, r9, ror #2
	mov ip, r11
	mov r11, r10
	mov r10, r9
	mov r9, r3
	mov r3, r2
	add r7, r7, #1
	cmp r7, #8
	moveq r6, sp
	cmp r7, #0x14
	blt _020ED058
	ldr r8, _020ECEF0 // =0xCA62C1D6
	mov r7, #0
_020ED0D4:
	ldr r2, [r6]
	ldr r5, [r6, #8]
	ldr r4, [r6, #0x20]
	ldr lr, [r6, #0x34]
	eor r2, r2, r5
	eor r4, r4, lr
	eor r2, r2, r4
	mov r2, r2, ror #0x1f
	str r2, [r6, #0x40]
	str r2, [r6], #4
	add r2, r2, ip
	add r2, r2, r8
	add r2, r2, r3, ror #27
	eor r4, r9, r10
	eor r4, r4, r11
	add r2, r2, r4
	mov r9, r9, ror #2
	mov ip, r11
	mov r11, r10
	mov r10, r9
	mov r9, r3
	mov r3, r2
	add r7, r7, #1
	cmp r7, #4
	moveq r6, sp
	cmp r7, #0x14
	blt _020ED0D4
	ldmia r0, {r2, r4, r6, r7, lr}
	add r3, r3, r2
	add r9, r9, r4
	add r10, r10, r6
	add r11, r11, r7
	add ip, ip, lr
	stmia r0, {r3, r9, r10, r11, ip}
	ldr lr, [sp, #0x80]
	subs lr, lr, #0x40
	str lr, [sp, #0x80]
	bgt _020ECF04
	add sp, sp, #0x84
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, ip, pc}
	arm_func_end DGTi_hash2_arm4_small