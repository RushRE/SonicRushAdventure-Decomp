	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start MATH_CountPopulation
MATH_CountPopulation: // 0x020FCAE8
	ldr r1, _020FCB20 // =0x55555555
	ldr r2, _020FCB24 // =0x33333333
	and r1, r1, r0, lsr #1
	sub r0, r0, r1
	and r1, r0, r2
	and r0, r2, r0, lsr #2
	add r1, r1, r0
	ldr r0, _020FCB28 // =0x0F0F0F0F
	add r1, r1, r1, lsr #4
	and r0, r1, r0
	add r0, r0, r0, lsr #8
	add r0, r0, r0, lsr #16
	and r0, r0, #0xff
	bx lr
	.align 2, 0
_020FCB20: .word 0x55555555
_020FCB24: .word 0x33333333
_020FCB28: .word 0x0F0F0F0F
	arm_func_end MATH_CountPopulation

	arm_func_start MATH_CalcCRC8
MATH_CalcCRC8: // 0x020FCB2C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x68
	mov r6, r0
	add r0, sp, #0
	mov r5, r1
	mov r4, r2
	bl DGT_Hash2Reset
	add r0, sp, #0
	mov r1, r5
	mov r2, r4
	bl DGT_Hash2SetSource
	add r0, sp, #0
	mov r1, r6
	bl DGT_Hash2GetDigest
	add sp, sp, #0x68
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end MATH_CalcCRC8

	arm_func_start MATH_CRC32Update
MATH_CRC32Update: // 0x020FCB70
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, r1
	mvn ip, #0
	mov r3, r2
	add r1, sp, #0
	mov r2, lr
	str ip, [sp]
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp]
	mvn r0, r0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end MATH_CRC32Update

	arm_func_start MATH_CRC16Update
MATH_CRC16Update: // 0x020FCBA8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, r1
	mov ip, #0
	mov r3, r2
	add r1, sp, #0
	mov r2, lr
	strh ip, [sp]
	bl MATHi_CRC16UpdateRev
	ldrh r0, [sp]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end MATH_CRC16Update

	arm_func_start MATH_CRC8Update
MATH_CRC8Update: // 0x020FCBDC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, r1
	mov ip, #0
	mov r3, r2
	add r1, sp, #0
	mov r2, lr
	strb ip, [sp]
	bl MATHi_CRC8UpdateRev
	ldrb r0, [sp]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end MATH_CRC8Update

	arm_func_start MATHi_CRC32UpdateRev
MATHi_CRC32UpdateRev: // 0x020FCC10
	stmdb sp!, {r4, lr}
	cmp r3, #0
	ldr r4, [r1]
	mov lr, #0
	bls _020FCC48
_020FCC24:
	ldrb ip, [r2]
	add lr, lr, #1
	cmp lr, r3
	eor ip, r4, ip
	and ip, ip, #0xff
	ldr ip, [r0, ip, lsl #2]
	add r2, r2, #1
	eor r4, ip, r4, lsr #8
	blo _020FCC24
_020FCC48:
	str r4, [r1]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end MATHi_CRC32UpdateRev

	arm_func_start MATHi_CRC32InitTableRev
MATHi_CRC32InitTableRev: // 0x020FCC54
	stmdb sp!, {r4, lr}
	mov lr, #0
	mov r3, lr
_020FCC60:
	mov r4, lr
	mov ip, r3
_020FCC68:
	ands r2, r4, #1
	eorne r4, r1, r4, lsr #1
	add ip, ip, #1
	moveq r4, r4, lsr #1
	cmp ip, #8
	blo _020FCC68
	str r4, [r0, lr, lsl #2]
	add lr, lr, #1
	cmp lr, #0x100
	blo _020FCC60
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end MATHi_CRC32InitTableRev

	arm_func_start MATHi_CRC16UpdateRev
MATHi_CRC16UpdateRev: // 0x020FCC98
	stmdb sp!, {r4, lr}
	cmp r3, #0
	ldrh r4, [r1]
	mov lr, #0
	bls _020FCCD4
_020FCCAC:
	ldrb ip, [r2]
	add lr, lr, #1
	cmp lr, r3
	eor ip, r4, ip
	and ip, ip, #0xff
	mov ip, ip, lsl #1
	ldrh ip, [r0, ip]
	add r2, r2, #1
	eor r4, ip, r4, lsr #8
	blo _020FCCAC
_020FCCD4:
	strh r4, [r1]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end MATHi_CRC16UpdateRev

	arm_func_start MATHi_CRC16InitTableRev
MATHi_CRC16InitTableRev: // 0x020FCCE0
	stmdb sp!, {r4, lr}
	mov lr, #0
	mov r3, lr
_020FCCEC:
	mov r4, lr
	mov ip, r3
_020FCCF4:
	ands r2, r4, #1
	eorne r4, r1, r4, lsr #1
	add ip, ip, #1
	moveq r4, r4, lsr #1
	cmp ip, #8
	blo _020FCCF4
	mov r2, lr, lsl #1
	add lr, lr, #1
	strh r4, [r0, r2]
	cmp lr, #0x100
	blo _020FCCEC
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end MATHi_CRC16InitTableRev

	arm_func_start MATHi_CRC8UpdateRev
MATHi_CRC8UpdateRev: // 0x020FCD28
	stmdb sp!, {r4, lr}
	cmp r3, #0
	ldrb r4, [r1]
	mov lr, #0
	bls _020FCD5C
_020FCD3C:
	ldrb ip, [r2]
	add lr, lr, #1
	cmp lr, r3
	eor ip, r4, ip
	and ip, ip, #0xff
	add r2, r2, #1
	ldrb r4, [r0, ip]
	blo _020FCD3C
_020FCD5C:
	strb r4, [r1]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end MATHi_CRC8UpdateRev

	arm_func_start MATHi_CRC8InitTable
MATHi_CRC8InitTable: // 0x020FCD68
	stmdb sp!, {r4, lr}
	mov lr, #0
	mov r3, lr
_020FCD74:
	mov r4, lr
	mov ip, r3
_020FCD7C:
	ands r2, r4, #0x80
	eorne r4, r1, r4, lsl #1
	add ip, ip, #1
	moveq r4, r4, lsl #1
	cmp ip, #8
	blo _020FCD7C
	strb r4, [r0, lr]
	add lr, lr, #1
	cmp lr, #0x100
	blo _020FCD74
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end MATHi_CRC8InitTable