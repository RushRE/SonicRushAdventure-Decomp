	.include "asm/macros.inc"
	.include "global.inc"
    
.public _0211F964
.public _0211F968

	.text

    arm_func_start DGT_Hash2CalcHmac
DGT_Hash2CalcHmac: // 0x020EC8A4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xa0
	ldr lr, _020EC92C // _0211F968
	add ip, sp, #0x1c
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	mov r4, ip
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	add lr, sp, #0x38
	add ip, sp, #8
	str lr, [sp, #0x24]
	ldr lr, _020EC930 // =DGT_Hash2Reset
	str ip, [sp, #0x28]
	ldr ip, _020EC934 // =DGT_Hash2SetSource
	str lr, [sp, #0x2c]
	ldr lr, _020EC938 // =DGT_Hash2GetDigest
	str ip, [sp, #0x30]
	ldr ip, [sp, #0xb8]
	str lr, [sp, #0x34]
	str ip, [sp]
	mov r3, r5
	mov r0, r8
	mov r1, r7
	mov r2, r6
	str r4, [sp, #4]
	bl DGTi_Hash2CalcHmac
	add sp, sp, #0xa0
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020EC92C: .word _0211F968
_020EC930: .word DGT_Hash2Reset
_020EC934: .word DGT_Hash2SetSource
_020EC938: .word DGT_Hash2GetDigest
	arm_func_end DGT_Hash2CalcHmac

	arm_func_start DGT_Hash2GetDigest
DGT_Hash2GetDigest: // 0x020EC93C
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, [sp, #0x10]
	mov r6, r1
	ldr r3, [r0, #0x1c]
	add r5, r0, #0x20
	ands r1, r3, #3
	mov r0, r3, asr #2
	moveq r1, #0
	streq r1, [r5, r0, lsl #2]
	ldr r2, [sp, #0x10]
	mov r1, #0x80
	add r4, r2, #0x20
	strb r1, [r4, r3]
	add r3, r3, #1
	ands r1, r3, #3
	beq _020EC994
	mov r2, #0
_020EC984:
	strb r2, [r4, r3]
	add r3, r3, #1
	ands r1, r3, #3
	bne _020EC984
_020EC994:
	ldr r1, [sp, #0x10]
	add r0, r0, #1
	ldr r1, [r1, #0x1c]
	cmp r1, #0x38
	blt _020EC9E0
	cmp r0, #0x10
	bge _020EC9C4
	mov r1, #0
_020EC9B4:
	str r1, [r5, r0, lsl #2]
	add r0, r0, #1
	cmp r0, #0x10
	blt _020EC9B4
_020EC9C4:
	ldr r1, _020ECB34 // _0211F964
	ldr r0, [sp, #0x10]
	ldr r3, [r1]
	mov r1, r5
	mov r2, #0x40
	blx r3
	mov r0, #0
_020EC9E0:
	cmp r0, #0xe
	bge _020EC9FC
	mov r1, #0
_020EC9EC:
	str r1, [r5, r0, lsl #2]
	add r0, r0, #1
	cmp r0, #0xe
	blt _020EC9EC
_020EC9FC:
	ldr r0, [sp, #0x10]
	mov r1, r5
	ldr r2, [r0, #0x14]
	ldr r3, _020ECB34 // _0211F964
	strb r2, [r4, #0x3f]
	mov r0, r2, lsr #8
	strb r0, [r4, #0x3e]
	mov r0, r2, lsr #0x10
	strb r0, [r4, #0x3d]
	mov r0, r2, lsr #0x18
	strb r0, [r4, #0x3c]
	ldr r0, [sp, #0x10]
	mov r2, #0x40
	ldr r5, [r0, #0x18]
	strb r5, [r4, #0x3b]
	mov r0, r5, lsr #8
	strb r0, [r4, #0x3a]
	mov r0, r5, lsr #0x10
	strb r0, [r4, #0x39]
	mov r0, r5, lsr #0x18
	strb r0, [r4, #0x38]
	ldr r0, [sp, #0x10]
	ldr r3, [r3]
	blx r3
	ldr r0, [sp, #0x10]
	add r1, sp, #0x10
	ldr r3, [r0]
	mov r0, #0
	mov r2, r3, lsr #0x18
	strb r2, [r6]
	mov r2, r3, lsr #0x10
	strb r2, [r6, #1]
	mov r2, r3, lsr #8
	strb r2, [r6, #2]
	strb r3, [r6, #3]
	ldr r3, [sp, #0x10]
	mov r2, #4
	ldr r4, [r3, #4]
	mov r3, r4, lsr #0x18
	strb r3, [r6, #4]
	mov r3, r4, lsr #0x10
	strb r3, [r6, #5]
	mov r3, r4, lsr #8
	strb r3, [r6, #6]
	strb r4, [r6, #7]
	ldr r3, [sp, #0x10]
	ldr r4, [r3, #8]
	mov r3, r4, lsr #0x18
	strb r3, [r6, #8]
	mov r3, r4, lsr #0x10
	strb r3, [r6, #9]
	mov r3, r4, lsr #8
	strb r3, [r6, #0xa]
	strb r4, [r6, #0xb]
	ldr r3, [sp, #0x10]
	ldr r4, [r3, #0xc]
	mov r3, r4, lsr #0x18
	strb r3, [r6, #0xc]
	mov r3, r4, lsr #0x10
	strb r3, [r6, #0xd]
	mov r3, r4, lsr #8
	strb r3, [r6, #0xe]
	strb r4, [r6, #0xf]
	ldr r3, [sp, #0x10]
	ldr r4, [r3, #0x10]
	mov r3, r4, lsr #0x18
	strb r3, [r6, #0x10]
	mov r3, r4, lsr #0x10
	strb r3, [r6, #0x11]
	mov r3, r4, lsr #8
	strb r3, [r6, #0x12]
	strb r4, [r6, #0x13]
	ldr r3, [sp, #0x10]
	str r0, [r3, #0x1c]
	bl MIi_CpuClear32
	ldmia sp!, {r4, r5, r6, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_020ECB34: .word _0211F964
	arm_func_end DGT_Hash2GetDigest

	arm_func_start DGT_Hash2SetSource
DGT_Hash2SetSource: // 0x020ECB38
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	movs r6, r2
	mov r7, r1
	add r5, r8, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldr r0, [r8, #0x14]
	add r1, r0, r6, lsl #3
	cmp r1, r0
	ldrlo r0, [r8, #0x18]
	addlo r0, r0, #1
	strlo r0, [r8, #0x18]
	ldr r0, [r8, #0x18]
	add r0, r0, r6, lsr #29
	str r0, [r8, #0x18]
	str r1, [r8, #0x14]
	ldr r1, [r8, #0x1c]
	cmp r1, #0
	beq _020ECBF8
	add r0, r1, r6
	cmp r0, #0x40
	blo _020ECBD4
	rsb r4, r1, #0x40
	mov r0, r7
	mov r2, r4
	add r1, r5, r1
	bl MI_CpuCopy8
	ldr r1, _020ECC90 // _0211F964
	mov r0, r8
	ldr r3, [r1]
	mov r1, r5
	mov r2, #0x40
	sub r6, r6, r4
	add r7, r7, r4
	blx r3
	mov r0, #0
	str r0, [r8, #0x1c]
	b _020ECBF8
_020ECBD4:
	mov r0, r7
	mov r2, r6
	add r1, r5, r1
	bl MI_CpuCopy8
	ldr r0, [r8, #0x1c]
	add r0, r0, r6
	str r0, [r8, #0x1c]
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020ECBF8:
	cmp r6, #0x40
	blo _020ECC68
	bic r4, r6, #0x3f
	sub r6, r6, r4
	ands r0, r7, #3
	bne _020ECC30
	ldr r1, _020ECC90 // _0211F964
	mov r0, r8
	ldr r3, [r1]
	mov r1, r7
	mov r2, r4
	blx r3
	add r7, r7, r4
	b _020ECC68
_020ECC30:
	mov r0, r7
	mov r1, r5
	mov r2, #0x40
	bl MI_CpuCopy8
	ldr r1, _020ECC90 // _0211F964
	mov r0, r8
	ldr r3, [r1]
	mov r1, r5
	mov r2, #0x40
	add r7, r7, #0x40
	blx r3
	sub r4, r4, #0x40
	cmp r4, #0
	bgt _020ECC30
_020ECC68:
	str r6, [r8, #0x1c]
	cmp r6, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	mov r0, r7
	mov r1, r5
	mov r2, r6
	bl MI_CpuCopy8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020ECC90: .word _0211F964
	arm_func_end DGT_Hash2SetSource

	arm_func_start DGT_Hash2Reset
DGT_Hash2Reset: // 0x020ECC94
	ldr r1, _020ECCD0 // =0x67452301
	ldr r2, _020ECCD4 // =0xEFCDAB89
	str r1, [r0]
	ldr r1, _020ECCD8 // =0x98BADCFE
	str r2, [r0, #4]
	ldr r2, _020ECCDC // =0x10325476
	str r1, [r0, #8]
	ldr r1, _020ECCE0 // =0xC3D2E1F0
	str r2, [r0, #0xc]
	str r1, [r0, #0x10]
	mov r1, #0
	str r1, [r0, #0x14]
	str r1, [r0, #0x18]
	str r1, [r0, #0x1c]
	bx lr
	.align 2, 0
_020ECCD0: .word 0x67452301
_020ECCD4: .word 0xEFCDAB89
_020ECCD8: .word 0x98BADCFE
_020ECCDC: .word 0x10325476
_020ECCE0: .word 0xC3D2E1F0
	arm_func_end DGT_Hash2Reset

	arm_func_start DGTi_Hash2CalcHmac
DGTi_Hash2CalcHmac: // 0x020ECCE4
	stmdb sp!, {r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #0xc4
	ldr r5, [sp, #0xe0]
	ldr r4, [sp, #0xe4]
	movs sb, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	addeq sp, sp, #0xc4
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, lr}
	bxeq lr
	cmp r8, #0
	addeq sp, sp, #0xc4
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, lr}
	bxeq lr
	cmp r7, #0
	addeq sp, sp, #0xc4
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, lr}
	bxeq lr
	cmp r6, #0
	addeq sp, sp, #0xc4
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, lr}
	bxeq lr
	cmp r5, #0
	addeq sp, sp, #0xc4
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, lr}
	bxeq lr
	cmp r4, #0
	addeq sp, sp, #0xc4
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, lr}
	bxeq lr
	ldr r0, [r4, #4]
	cmp r5, r0
	ble _020ECDA4
	ldr r0, [r4, #8]
	ldr r1, [r4, #0x10]
	blx r1
	ldr r0, [r4, #8]
	ldr r3, [r4, #0x14]
	mov r1, r6
	mov r2, r5
	blx r3
	ldr r0, [r4, #8]
	ldr r2, [r4, #0x18]
	add r1, sp, #0
	blx r2
	ldr r5, [r4]
	add r6, sp, #0
_020ECDA4:
	cmp r5, #0
	mov r0, #0
	ble _020ECDCC
	add r2, sp, #0x40
_020ECDB4:
	ldrb r1, [r6, r0]
	add r0, r0, #1
	cmp r0, r5
	eor r1, r1, #0x36
	strb r1, [r2], #1
	blt _020ECDB4
_020ECDCC:
	ldr r1, [r4, #4]
	cmp r0, r1
	bge _020ECDF8
	add r1, sp, #0x40
	add r3, r1, r0
	mov r2, #0x36
_020ECDE4:
	strb r2, [r3], #1
	ldr r1, [r4, #4]
	add r0, r0, #1
	cmp r0, r1
	blt _020ECDE4
_020ECDF8:
	ldr r0, [r4, #8]
	ldr r1, [r4, #0x10]
	blx r1
	ldr r0, [r4, #8]
	ldr r2, [r4, #4]
	ldr r3, [r4, #0x14]
	add r1, sp, #0x40
	blx r3
	ldr r0, [r4, #8]
	ldr r3, [r4, #0x14]
	mov r1, r8
	mov r2, r7
	blx r3
	ldr r0, [r4, #8]
	ldr r1, [r4, #0xc]
	ldr r2, [r4, #0x18]
	blx r2
	cmp r5, #0
	mov r2, #0
	ble _020ECE64
	add r1, sp, #0x80
_020ECE4C:
	ldrb r0, [r6, r2]
	add r2, r2, #1
	cmp r2, r5
	eor r0, r0, #0x5c
	strb r0, [r1], #1
	blt _020ECE4C
_020ECE64:
	ldr r0, [r4, #4]
	cmp r2, r0
	bge _020ECE90
	add r0, sp, #0x80
	add r3, r0, r2
	mov r1, #0x5c
_020ECE7C:
	strb r1, [r3], #1
	ldr r0, [r4, #4]
	add r2, r2, #1
	cmp r2, r0
	blt _020ECE7C
_020ECE90:
	ldr r0, [r4, #8]
	ldr r1, [r4, #0x10]
	blx r1
	ldr r0, [r4, #8]
	ldr r2, [r4, #4]
	ldr r3, [r4, #0x14]
	add r1, sp, #0x80
	blx r3
	ldr r0, [r4, #8]
	ldr r1, [r4, #0xc]
	ldr r2, [r4]
	ldr r3, [r4, #0x14]
	blx r3
	ldr r0, [r4, #8]
	ldr r2, [r4, #0x18]
	mov r1, sb
	blx r2
	add sp, sp, #0xc4
	ldmia sp!, {r4, r5, r6, r7, r8, sb, lr}
	bx lr
	.align 2, 0
	arm_func_end DGTi_Hash2CalcHmac
    

_020ECEE0: .word 0x00FF00FF
_020ECEE4: .word 0x5A827999
_020ECEE8: .word 0x6ED9EBA1
_020ECEEC: .word 0x8F1BBCDC
_020ECEF0: .word 0xCA62C1D6

    arm_func_start DGTi_hash2_arm4_small
DGTi_hash2_arm4_small: // 0x020ECEF4
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr}
	ldmia r0, {r3, sb, sl, fp, ip}
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
	eor r4, sl, fp
	and r4, r4, sb
	eor r4, r4, fp
	add r2, r2, r4
	mov sb, sb, ror #2
	mov ip, fp
	mov fp, sl
	mov sl, sb
	mov sb, r3
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
	eor r4, sl, fp
	and r4, r4, sb
	eor r4, r4, fp
	add r2, r2, r4
	mov sb, sb, ror #2
	mov ip, fp
	mov fp, sl
	mov sl, sb
	mov sb, r3
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
	eor lr, sb, sl
	eor lr, lr, fp
	add r2, r2, lr
	mov sb, sb, ror #2
	mov ip, fp
	mov fp, sl
	mov sl, sb
	mov sb, r3
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
	orr r5, sb, sl
	and r5, r5, fp
	and r4, sb, sl
	orr r5, r5, r4
	add r2, r2, r5
	mov sb, sb, ror #2
	mov ip, fp
	mov fp, sl
	mov sl, sb
	mov sb, r3
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
	eor r4, sb, sl
	eor r4, r4, fp
	add r2, r2, r4
	mov sb, sb, ror #2
	mov ip, fp
	mov fp, sl
	mov sl, sb
	mov sb, r3
	mov r3, r2
	add r7, r7, #1
	cmp r7, #4
	moveq r6, sp
	cmp r7, #0x14
	blt _020ED0D4
	ldmia r0, {r2, r4, r6, r7, lr}
	add r3, r3, r2
	add sb, sb, r4
	add sl, sl, r6
	add fp, fp, r7
	add ip, ip, lr
	stmia r0, {r3, sb, sl, fp, ip}
	ldr lr, [sp, #0x80]
	subs lr, lr, #0x40
	str lr, [sp, #0x80]
	bgt _020ECF04
	add sp, sp, #0x84
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, pc}
	arm_func_end DGTi_hash2_arm4_small