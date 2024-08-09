	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start _ll_udiv
_ll_udiv: // 0x03807810
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr}
	mov r4, #0
	b _03807824
	arm_func_end _ll_udiv

	arm_func_start _ull_mod
_ull_mod: // 0x0380781C
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr}
	mov r4, #1
_03807824:
	orrs r5, r3, r2
	bne _03807834
	ldmia sp!, {r4, r5, r6, r7, fp, ip, lr}
	bx lr
_03807834:
	orrs r5, r1, r3
	bne _038078DC
	mov r1, r2
	bl _u32_div_not_0_f
	cmp r4, #0
	movne r0, r1
	mov r1, #0
	ldmia sp!, {r4, r5, r6, r7, fp, ip, lr}
	bx lr
	arm_func_end _ull_mod

	arm_func_start _ll_mod
_ll_mod: // 0x03807858
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr}
	mov r4, r1
	orr r4, r4, #1
	b _03807878
	arm_func_end _ll_mod

	arm_func_start _ll_sdiv
_ll_sdiv: // 0x03807868
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr}
	eor r4, r1, r3
	mov r4, r4, asr #1
	mov r4, r4, lsl #1
_03807878:
	orrs r5, r3, r2
	bne _03807888
	ldmia sp!, {r4, r5, r6, r7, fp, ip, lr}
	bx lr
_03807888:
	mov r5, r0, lsr #0x1f
	add r5, r5, r1
	mov r6, r2, lsr #0x1f
	add r6, r6, r3
	orrs r6, r5, r6
	bne _038078BC
	mov r1, r2
	bl _s32_div_f
	ands r4, r4, #1
	movne r0, r1
	mov r1, r0, asr #0x1f
	ldmia sp!, {r4, r5, r6, r7, fp, ip, lr}
	bx lr
_038078BC:
	cmp r1, #0
	bge _038078CC
	rsbs r0, r0, #0
	rsc r1, r1, #0
_038078CC:
	cmp r3, #0
	bge _038078DC
	rsbs r2, r2, #0
	rsc r3, r3, #0
_038078DC:
	orrs r5, r1, r0
	beq _03807A00
	mov r5, #0
	mov r6, #1
	cmp r3, #0
	bmi _03807908
_038078F4:
	add r5, r5, #1
	adds r2, r2, r2
	adcs r3, r3, r3
	bpl _038078F4
	add r6, r6, r5
_03807908:
	cmp r1, #0
	blt _03807928
_03807910:
	cmp r6, #1
	beq _03807928
	sub r6, r6, #1
	adds r0, r0, r0
	adcs r1, r1, r1
	bpl _03807910
_03807928:
	mov r7, #0
	mov ip, #0
	mov fp, #0
	b _03807950
_03807938:
	orr ip, ip, #1
	subs r6, r6, #1
	beq _038079A8
	adds r0, r0, r0
	adcs r1, r1, r1
	adcs r7, r7, r7
_03807950:
	subs r0, r0, r2
	sbcs r1, r1, r3
	sbcs r7, r7, #0
	adds ip, ip, ip
	adc fp, fp, fp
	cmp r7, #0
	bge _03807938
_0380796C:
	subs r6, r6, #1
	beq _038079A0
	adds r0, r0, r0
	adcs r1, r1, r1
	adc r7, r7, r7
	adds r0, r0, r2
	adcs r1, r1, r3
	adc r7, r7, #0
	adds ip, ip, ip
	adc fp, fp, fp
	cmp r7, #0
	bge _03807938
	b _0380796C
_038079A0:
	adds r0, r0, r2
	adc r1, r1, r3
_038079A8:
	ands r7, r4, #1
	moveq r0, ip
	moveq r1, fp
	beq _038079E0
	subs r7, r5, #0x20
	movge r0, r1, lsr r7
	bge _03807A04
	rsb r7, r5, #0x20
	mov r0, r0, lsr r5
	orr r0, r0, r1, lsl r7
	mov r1, r1, lsr r5
	b _038079E0
_038079D8: // 0x038079D8
	mov r0, r1, lsr r7
	mov r1, #0
_038079E0:
	cmp r4, #0
	blt _038079F0
	ldmia sp!, {r4, r5, r6, r7, fp, ip, lr}
	bx lr
_038079F0:
	rsbs r0, r0, #0
	rsc r1, r1, #0
	ldmia sp!, {r4, r5, r6, r7, fp, ip, lr}
	bx lr
_03807A00:
	mov r0, #0
_03807A04:
	mov r1, #0
	cmp r4, #0
	blt _038079F0
	ldmia sp!, {r4, r5, r6, r7, fp, ip, lr}
	bx lr
	arm_func_end _ll_sdiv

	arm_func_start _s32_div_f
_s32_div_f: // 0x03807A18
	eor ip, r0, r1
	and ip, ip, #0x80000000
	cmp r0, #0
	rsblt r0, r0, #0
	addlt ip, ip, #1
	cmp r1, #0
	rsblt r1, r1, #0
	beq _03807C10
	cmp r0, r1
	movlo r1, r0
	movlo r0, #0
	blo _03807C10
	mov r2, #0x1c
	mov r3, r0, lsr #4
	cmp r1, r3, lsr #12
	suble r2, r2, #0x10
	movle r3, r3, lsr #0x10
	cmp r1, r3, lsr #4
	suble r2, r2, #8
	movle r3, r3, lsr #8
	cmp r1, r3
	suble r2, r2, #4
	movle r3, r3, lsr #4
	mov r0, r0, lsl r2
	rsb r1, r1, #0
	adds r0, r0, r0
	add r2, r2, r2, lsl #1
	add pc, pc, r2, lsl #2
	mov r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	mov r1, r3
_03807C10:
	ands r3, ip, #0x80000000
	rsbne r0, r0, #0
	ands r3, ip, #1
	rsbne r1, r1, #0
	bx lr
	arm_func_end _s32_div_f

	arm_func_start _u32_div_f
_u32_div_f: // 0x03807C24
	cmp r1, #0
	bxeq lr
	arm_func_end _u32_div_f

	arm_func_start _u32_div_not_0_f
_u32_div_not_0_f: // 0x03807C2C
	cmp r0, r1
	movlo r1, r0
	movlo r0, #0
	bxlo lr
	mov r2, #0x1c
	mov r3, r0, lsr #4
	cmp r1, r3, lsr #12
	suble r2, r2, #0x10
	movle r3, r3, lsr #0x10
	cmp r1, r3, lsr #4
	suble r2, r2, #8
	movle r3, r3, lsr #8
	cmp r1, r3
	suble r2, r2, #4
	movle r3, r3, lsr #4
	mov r0, r0, lsl r2
	rsb r1, r1, #0
	adds r0, r0, r0
	add r2, r2, r2, lsl #1
	add pc, pc, r2, lsl #2
	mov r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	mov r1, r3
	bx lr
	arm_func_end _u32_div_not_0_f

.public SinTable
SinTable: // 0x03807E08
	.byte 0x00, 0x06, 0x0C, 0x13, 0x19, 0x1F, 0x25, 0x2B
	.byte 0x31, 0x36, 0x3C, 0x41, 0x47, 0x4C, 0x51, 0x55, 0x5A, 0x5E, 0x62, 0x66, 0x6A, 0x6D, 0x70, 0x73
	.byte 0x75, 0x78, 0x7A, 0x7B, 0x7D, 0x7E, 0x7E, 0x7F, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x80, 0x2E, 0xFD
	.byte 0x2F, 0xFD, 0x75, 0xFD, 0xA7, 0xFD, 0xCE, 0xFD, 0xEE, 0xFD, 0x09, 0xFE, 0x20, 0xFE, 0x34, 0xFE
	.byte 0x46, 0xFE, 0x57, 0xFE, 0x66, 0xFE, 0x74, 0xFE, 0x81, 0xFE, 0x8D, 0xFE, 0x98, 0xFE, 0xA3, 0xFE
	.byte 0xAD, 0xFE, 0xB6, 0xFE, 0xBF, 0xFE, 0xC7, 0xFE, 0xCF, 0xFE, 0xD7, 0xFE, 0xDF, 0xFE, 0xE6, 0xFE
	.byte 0xEC, 0xFE, 0xF3, 0xFE, 0xF9, 0xFE, 0xFF, 0xFE

_03807E68: // 0x03807E68
	.byte 0x05, 0xFF, 0x0B, 0xFF, 0x11, 0xFF, 0x16, 0xFF
	.byte 0x1B, 0xFF, 0x20, 0xFF, 0x25, 0xFF, 0x2A, 0xFF, 0x2E, 0xFF, 0x33, 0xFF, 0x37, 0xFF, 0x3C, 0xFF
	.byte 0x40, 0xFF, 0x44, 0xFF, 0x48, 0xFF, 0x4C, 0xFF, 0x50, 0xFF, 0x53, 0xFF, 0x57, 0xFF, 0x5B, 0xFF
	.byte 0x5E, 0xFF, 0x62, 0xFF, 0x65, 0xFF, 0x68, 0xFF, 0x6B, 0xFF, 0x6F, 0xFF, 0x72, 0xFF, 0x75, 0xFF
	.byte 0x78, 0xFF, 0x7B, 0xFF, 0x7E, 0xFF, 0x81, 0xFF, 0x83, 0xFF, 0x86, 0xFF, 0x89, 0xFF, 0x8C, 0xFF
	.byte 0x8E, 0xFF, 0x91, 0xFF, 0x93, 0xFF, 0x96, 0xFF, 0x99, 0xFF, 0x9B, 0xFF, 0x9D, 0xFF, 0xA0, 0xFF
	.byte 0xA2, 0xFF, 0xA5, 0xFF, 0xA7, 0xFF, 0xA9, 0xFF, 0xAB, 0xFF, 0xAE, 0xFF, 0xB0, 0xFF, 0xB2, 0xFF
	.byte 0xB4, 0xFF, 0xB6, 0xFF, 0xB8, 0xFF, 0xBA, 0xFF, 0xBC, 0xFF, 0xBE, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF
	.byte 0xC4, 0xFF, 0xC6, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF, 0xCC, 0xFF, 0xCE, 0xFF, 0xCF, 0xFF, 0xD1, 0xFF
	.byte 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD8, 0xFF, 0xDA, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDF, 0xFF
	.byte 0xE1, 0xFF, 0xE2, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF, 0xE7, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEC, 0xFF
	.byte 0xED, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF2, 0xFF, 0xF3, 0xFF, 0xF5, 0xFF, 0xF6, 0xFF, 0xF8, 0xFF
	.byte 0xF9, 0xFF, 0xFA, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF, 0xFF, 0xFF, 0x00, 0x00

.public _03807F2C
_03807F2C: // 0x03807F2C
	.byte 0x00, 0x01, 0x02, 0x04
	.byte 0x04, 0x05, 0x06, 0x07, 0x02, 0x00, 0x03, 0x01, 0x08, 0x09, 0x0A, 0x0B, 0x0E, 0x0C, 0x0F, 0x0D
	.byte 0x00, 0x01, 0x05, 0x0E, 0x1A, 0x26, 0x33, 0x3F, 0x49, 0x54, 0x5C, 0x64, 0x6D, 0x74, 0x7B, 0x7F
	.byte 0x84, 0x89, 0x8F, 0x00, 0xC7, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00
	.byte 0x40, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00
	
_03807F68: // 0x03807F68
	.byte 0x00, 0x00, 0x00, 0x01, 0x18, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x08, 0x00, 0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x14, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x04, 0x00, 0x12, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00
	.byte 0x10, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00
	.byte 0x00, 0x01, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00
	.byte 0x00, 0x04, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00
	.byte 0x00, 0x10, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x00
	.byte 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x10, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x40, 0x00, 0x16, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x02, 0x00, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x17, 0x00, 0x00, 0x00

	arm_func_start sub_3808010
sub_3808010: // 0x03808010
	mov ip, #0x4000000
	str ip, [ip, #0x208]
	ldr r1, _03808078 // =0x0380FFFC
	mov r0, #0
	str r0, [r1]
	ldr r1, _0380807C // =0x04000180
	mov r0, #0x100
	strh r0, [r1]
_03808030:
	ldrh r0, [r1]
	and r0, r0, #0xf
	cmp r0, #1
	bne _03808030
	ldr r1, _0380807C // =0x04000180
	mov r0, #0
	strh r0, [r1]
_0380804C:
	ldrh r0, [r1]
	cmp r0, #1
	beq _0380804C
	ldr r3, _03808080 // =0x027FFE00
	ldr ip, [r3, #0x34]
	mov lr, ip
	mov r0, #0
	mov r1, #0
	mov r2, #0
	mov r3, #0
	bx ip
	.align 2, 0
_03808078: .word 0x0380FFFC
_0380807C: .word 0x04000180
_03808080: .word 0x027FFE00
	arm_func_end sub_3808010

	arm_func_start OSi_DoResetSystem
OSi_DoResetSystem: // 0x03808084
	mov r1, #0
	ldr r0, _03808098 // =0x04000208
	strh r1, [r0]
	ldr ip, _0380809C // =sub_3808010
	bx ip
	.align 2, 0
_03808098: .word 0x04000208
_0380809C: .word sub_3808010
	arm_func_end OSi_DoResetSystem

	arm_func_start WMSP_GetAllowedChannel
WMSP_GetAllowedChannel: // 0x038080A0
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #4
	ldr r1, _038081C8 // =0x00001FFF
	and r0, r0, r1
	mov r0, r0, lsl #0x10
	movs r6, r0, lsr #0x10
	moveq r0, #0
	beq _038081BC
	mov sb, #0
	mov r0, #1
	b _038080DC
_038080CC:
	mov r1, r0, lsl sb
	ands r1, r6, r1
	bne _038080E4
	add sb, sb, #1
_038080DC:
	cmp sb, #0x10
	blt _038080CC
_038080E4:
	mov sl, #0xf
	mov r0, #1
	b _03808100
_038080F0:
	mov r1, r0, lsl sl
	ands r1, r6, r1
	bne _03808108
	sub sl, sl, #1
_03808100:
	cmp sl, #0
	bne _038080F0
_03808108:
	sub r5, sl, sb
	cmp r5, #5
	movlt r0, #1
	movlt r0, r0, lsl sb
	movlt r0, r0, lsl #0x10
	movlt r0, r0, lsr #0x10
	blt _038081BC
	add r0, sl, sb
	mov r1, #2
	bl _s32_div_f
	mov r8, r0
	mov r7, #0
	mov fp, #2
	mov r4, #1
	b _0380816C
_03808144:
	mov r0, r7
	mov r1, fp
	bl _s32_div_f
	mov r0, r1, lsl #1
	sub r0, r0, #1
	mla r8, r7, r0, r8
	mov r0, r4, lsl r8
	ands r0, r6, r0
	bne _03808174
	add r7, r7, #1
_0380816C:
	cmp r7, r5
	blt _03808144
_03808174:
	sub r0, sl, r8
	cmp r0, #5
	blt _0380818C
	sub r0, r8, sb
	cmp r0, #5
	bge _038081A4
_0380818C:
	mov r0, #1
	mov r1, r0, lsl sb
	orr r0, r1, r0, lsl sl
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	b _038081BC
_038081A4:
	mov r1, #1
	mov r0, r1, lsl sl
	orr r0, r0, r1, lsl r8
	orr r0, r0, r1, lsl sb
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
_038081BC:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	bx lr
	.align 2, 0
_038081C8: .word 0x00001FFF
	arm_func_end WMSP_GetAllowedChannel

	arm_func_start WMSP_GetBuffer4Callback2Wm9
WMSP_GetBuffer4Callback2Wm9: // 0x038081CC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _0380821C // =0x027F997C
	bl OS_LockMutex
	mov r5, #0x100
	ldr r4, _03808220 // =0x027FFF96
	b _038081F0
_038081E8:
	mov r0, r5
	bl SVC_WaitByLoop_ARM
_038081F0:
	ldrh r0, [r4]
	ands r1, r0, #1
	bne _038081E8
	orr r0, r0, #1
	strh r0, [r4]
	ldr r0, _03808224 // =0x027F9454
	ldr r0, [r0, #0x54c]
	ldr r0, [r0, #8]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_0380821C: .word 0x027F997C
_03808220: .word 0x027FFF96
_03808224: .word 0x027F9454
	arm_func_end WMSP_GetBuffer4Callback2Wm9

	arm_func_start WMSP_ReturnResult2Wm9
WMSP_ReturnResult2Wm9: // 0x03808228
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, #0x100
	mov r5, #0xa
	mov r4, #0
	b _0380824C
_03808244:
	mov r0, r6
	bl SVC_WaitByLoop_ARM
_0380824C:
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	blt _03808244
	ldr r0, _03808278 // =0x027F997C
	bl OS_UnlockMutex
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_03808278: .word 0x027F997C
	arm_func_end WMSP_ReturnResult2Wm9