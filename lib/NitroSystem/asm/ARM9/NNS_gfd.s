	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FreeTexVram_
FreeTexVram_: // 0x020CDB48
	mvn r0, #0
	bx lr
	arm_func_end FreeTexVram_

	arm_func_start AllocTexVram_
AllocTexVram_: // 0x020CDB50
	mov r0, #0
	bx lr
	arm_func_end AllocTexVram_

	arm_func_start FreePlttVram_
FreePlttVram_: // 0x020CDB58
	mvn r0, #0
	bx lr
	arm_func_end FreePlttVram_

	arm_func_start AllocPlttVram_
AllocPlttVram_: // 0x020CDB60
	mov r0, #0
	bx lr
	arm_func_end AllocPlttVram_

	arm_func_start sub_20CDB68
sub_20CDB68: // 0x020CDB68
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r2, [r0, #0xc]
	ldrh ip, [r0, #0xe]
	mov lr, #0
	add r0, r0, r2
	cmp ip, #0
	bls _020CDBB4
_020CDB88:
	ldr r2, [r0]
	cmp r2, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	add r2, lr, #1
	mov r2, r2, lsl #0x10
	ldr r3, [r0, #4]
	mov lr, r2, lsr #0x10
	cmp lr, ip
	add r0, r0, r3
	blo _020CDB88
_020CDBB4:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20CDB68

	arm_func_start sub_20CDBC0
sub_20CDBC0: // 0x020CDBC0
	stmdb sp!, {r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #0xc
	add r5, sp, #0
	mov r4, #0
	str r4, [r5]
	str r4, [r5, #4]
	mov r8, r2
	ldr r2, [sp, #0x28]
	mov r5, r0
	mov sb, r1
	mov r4, r3
	cmp r2, #0
	mov r7, #1
	beq _020CDC28
	add r6, sp, #0x28
_020CDBFC:
	mov r0, sb
	mov r1, r8
	mov r3, r6
	bl sub_20CDCCC
	ldr r1, [sp]
	ldr r2, [sp, #0x28]
	cmp r0, r1
	strgt r0, [sp]
	add r7, r7, #1
	cmp r2, #0
	bne _020CDBFC
_020CDC28:
	ldr r0, [sb]
	sub r2, r7, #1
	ldrsb r1, [r0, #1]
	ldr r0, [sp]
	add r1, r4, r1
	mul r1, r2, r1
	sub r1, r1, r4
	str r1, [sp, #4]
	str r0, [r5]
	str r1, [r5, #4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, pc}
	arm_func_end sub_20CDBC0

	arm_func_start sub_20CDC58
sub_20CDC58: // 0x020CDC58
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	str r2, [sp]
	add r3, sp, #4
	mov r2, #0
	str r2, [r3]
	mov r8, r0
	str r2, [r3, #4]
	ldr r7, [r8, #4]
	add r0, sp, #0
	mov r5, r1
	mov r4, #1
	blx r7
	cmp r0, #0
	beq _020CDCB0
	add r6, sp, #0
_020CDC98:
	cmp r0, #0xa
	mov r0, r6
	addeq r4, r4, #1
	blx r7
	cmp r0, #0
	bne _020CDC98
_020CDCB0:
	ldr r0, [r8]
	ldrsb r0, [r0, #1]
	add r0, r5, r0
	mul r0, r4, r0
	sub r0, r0, r5
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end sub_20CDC58

	arm_func_start sub_20CDCCC
sub_20CDCCC: // 0x020CDCCC
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #8
	mov r8, r0
	str r2, [sp]
	ldr r4, [r8, #4]
	add r0, sp, #0
	mov r7, r1
	mov r6, r3
	mov r5, #0
	blx r4
	movs r1, r0
	beq _020CDD5C
	ldr sb, _020CDD88 // =0x0000FFFF
	add sl, sp, #0
_020CDD04:
	cmp r1, #0xa
	beq _020CDD5C
	mov r0, r8
	bl sub_20CDE40
	mov r1, r0
	cmp r1, sb
	ldreq r0, [r8]
	ldreqh r1, [r0, #2]
	mov r0, r8
	bl sub_20CDD8C
	ldrh r1, [r8, #8]
	cmp r1, #0
	ldrnesb r1, [r0]
	ldrneb r0, [r0, #1]
	addne r0, r1, r0
	ldreqsb r0, [r0, #2]
	add r1, r7, r0
	mov r0, sl
	add r5, r5, r1
	blx r4
	movs r1, r0
	bne _020CDD04
_020CDD5C:
	cmp r6, #0
	beq _020CDD74
	cmp r1, #0xa
	ldreq r0, [sp]
	movne r0, #0
	str r0, [r6]
_020CDD74:
	cmp r5, #0
	subgt r5, r5, r7
	mov r0, r5
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	.align 2, 0
_020CDD88: .word 0x0000FFFF
	arm_func_end sub_20CDCCC

	arm_func_start sub_20CDD8C
sub_20CDD8C: // 0x020CDD8C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, [r0]
	ldr lr, [r3, #0xc]
	cmp lr, #0
	beq _020CDDDC
_020CDDA4:
	ldrh ip, [lr]
	cmp ip, r1
	bhi _020CDDD0
	ldrh r2, [lr, #2]
	cmp r1, r2
	ldrlsh r2, [r0, #0xa]
	addls r3, lr, #8
	subls r0, r1, ip
	mlals r0, r2, r0, r3
	addls sp, sp, #4
	ldmlsia sp!, {pc}
_020CDDD0:
	ldr lr, [lr, #4]
	cmp lr, #0
	bne _020CDDA4
_020CDDDC:
	add r0, r3, #4
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20CDD8C

	arm_func_start sub_20CDE40
sub_20CDE40: // 0x020CDDE8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0]
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _020CDE30
_020CDE00:
	ldrh r2, [r0]
	cmp r2, r1
	bhi _020CDE24
	ldrh r2, [r0, #2]
	cmp r1, r2
	bhi _020CDE24
	bl sub_20CDE80
	add sp, sp, #4
	ldmia sp!, {pc}
_020CDE24:
	ldr r0, [r0, #8]
	cmp r0, #0
	bne _020CDE00
_020CDE30:
	ldr r0, _020CDE3C // =0x0000FFFF
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020CDE3C: .word 0x0000FFFF
	arm_func_end sub_20CDE40

	arm_func_start sub_20CDDE8
sub_20CDDE8: // 0x020CDE40
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	mov r1, r4
	bl sub_20CF65C
	sub r0, r0, #1
	strh r0, [r4, #8]
	ldrh r0, [r4, #8]
	cmp r0, #0
	movne r1, #2
	moveq r1, #3
	ldr r0, _020CDE7C // =sub_20CF81C
	strh r1, [r4, #0xa]
	str r0, [r4, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020CDE7C: .word sub_20CF81C
	arm_func_end sub_20CDDE8

	arm_func_start sub_20CDE80
sub_20CDE80: // 0x020CDE80
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r3, [r0, #4]
	ldr r2, _020CDF50 // =0x0000FFFF
	cmp r3, #0
	beq _020CDEAC
	cmp r3, #1
	beq _020CDEC8
	cmp r3, #2
	beq _020CDEDC
	b _020CDF44
_020CDEAC:
	ldrh r2, [r0]
	ldrh r3, [r0, #0xc]
	sub r0, r1, r2
	add r0, r3, r0
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	b _020CDF44
_020CDEC8:
	ldrh r2, [r0]
	sub r1, r1, r2
	add r0, r0, r1, lsl #1
	ldrh r2, [r0, #0xc]
	b _020CDF44
_020CDEDC:
	ldrh r3, [r0, #0xc]
	add r0, r0, #0xc
	add r0, r0, #2
	sub r3, r3, #1
	add lr, r0, r3, lsl #2
	cmp r0, lr
	bhi _020CDF44
_020CDEF8:
	sub ip, lr, r0
	mov r3, ip, asr #1
	add r3, ip, r3, lsr #30
	mov r3, r3, asr #2
	add r3, r3, r3, lsr #31
	mov ip, r3, asr #1
	mov r3, ip, lsl #2
	ldrh r3, [r0, r3]
	add ip, r0, ip, lsl #2
	cmp r3, r1
	addlo r0, ip, #4
	blo _020CDF3C
	cmp r1, r3
	sublo lr, ip, #4
	blo _020CDF3C
	ldrh r2, [ip, #2]
	b _020CDF44
_020CDF3C:
	cmp r0, lr
	bls _020CDEF8
_020CDF44:
	mov r0, r2
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020CDF50: .word 0x0000FFFF
	arm_func_end sub_20CDE80

	arm_func_start sub_20CDF54
sub_20CDF54: // 0x020CDF54
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x3c
	mov r7, r0
	mov r0, r1
	cmp r0, #8
	ldr r0, [sp, #0x60]
	str r1, [sp, #0x10]
	str r0, [sp, #0x60]
	ldr r0, [sp, #0x6c]
	str r2, [sp, #0x14]
	str r0, [sp, #0x6c]
	ldrlt r0, [sp, #0x10]
	mov fp, r3
	ldr r6, [sp, #0x64]
	ldr r5, [sp, #0x68]
	movge r2, #3
	clzlt r0, r0
	rsblt r2, r0, #0x1f
	ldr r0, [sp, #0x14]
	cmp r0, #8
	ldrlt r0, [sp, #0x14]
	movge r1, #3
	clzlt r0, r0
	rsblt r1, r0, #0x1f
	ldr r0, _020CE274 // =_021127C4
	mvn r3, #0
	add r1, r0, r1, lsl #3
	add r0, r1, r2, lsl #1
	ldrb r4, [r1, r2, lsl #1]
	ldrb r1, [r0, #1]
	ldr r2, [sp, #0x14]
	cmp r6, #0
	str r1, [sp, #0x18]
	ldr r1, [sp, #0x10]
	and r1, r1, r3, lsl r4
	str r1, [sp, #0x1c]
	ldr r1, [sp, #0x18]
	and r1, r2, r3, lsl r1
	str r1, [sp, #0x20]
	moveq r1, #1
	streq r1, [sp, #0x24]
	movne r1, #2
	strne r1, [sp, #0x24]
	mov r1, #0
	str r1, [sp, #0x28]
	bl sub_20CF150
	ldr r1, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov sl, r1, asr r4
	ldr r1, [sp, #0x18]
	mov r1, r2, asr r1
	str r1, [sp, #0x2c]
	ldr r1, [sp, #0x24]
	mov r2, r1, lsl r4
	ldr r1, [sp, #0x18]
	mov r2, r2, lsl r1
	ldr r1, [sp, #0x6c]
	mov sb, r2, asr r1
	mov r1, #0
	str r1, [sp, #0x30]
	str r1, [sp, #0x34]
	b _020CE0EC
_020CE04C:
	ldr r2, [sp, #0x30]
	ldr r1, [sp, #0x18]
	ldr r8, [sp, #0x34]
	mov r2, r2, lsl r1
	ldr r1, [sp, #0x60]
	add lr, r1, r2, lsl #3
	b _020CE0D8
_020CE068:
	mov r1, r8, lsl r4
	add r2, fp, r1, lsl #3
	ldr r1, _020CE278 // =0x000001FF
	ldr r3, [r7]
	and ip, r2, r1
	ldr r1, _020CE27C // =0xFE00FF00
	and r2, lr, #0xff
	and r1, r3, r1
	orr r1, r1, r2
	orr r1, r1, ip, lsl #16
	str r1, [r7]
	ldr r3, [r7]
	ldr r1, _020CE280 // =0x3FFF3FFF
	mov r2, #0x400
	and r1, r3, r1
	orr r1, r1, r0
	str r1, [r7]
	rsb r1, r2, #0
	ldrh r2, [r7, #4]
	add r8, r8, #1
	and r1, r2, r1
	orr r1, r1, r5
	strh r1, [r7, #4]
	ldr r1, [r7]
	add r5, r5, sb
	bic r1, r1, #0x2000
	orr r1, r1, r6, lsl #13
	str r1, [r7], #8
_020CE0D8:
	cmp r8, sl
	blt _020CE068
	ldr r1, [sp, #0x30]
	add r1, r1, #1
	str r1, [sp, #0x30]
_020CE0EC:
	ldr r2, [sp, #0x30]
	ldr r1, [sp, #0x2c]
	cmp r2, r1
	blt _020CE04C
	ldr r0, [sp, #0x28]
	mla r0, sl, r1, r0
	str r0, [sp, #0x28]
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x10]
	cmp r1, r0
	bhs _020CE17C
	ldr r0, [sp, #0x60]
	ldr r1, [sp, #0x10]
	str r0, [sp]
	ldr r0, [sp, #0x1c]
	str r6, [sp, #4]
	sub r4, r1, r0
	ldr r1, [sp, #0x6c]
	str r5, [sp, #8]
	str r1, [sp, #0xc]
	ldr r1, [sp, #0x1c]
	ldr r2, [sp, #0x20]
	add r3, fp, r1, lsl #3
	mov r0, r7
	mov r1, r4
	bl sub_20CDF54
	ldr r1, [sp, #0x24]
	add r7, r7, r0, lsl #3
	mul r2, r1, r4
	ldr r1, [sp, #0x20]
	mul r2, r1, r2
	ldr r1, [sp, #0x6c]
	add r5, r5, r2, lsr r1
	ldr r1, [sp, #0x28]
	add r0, r1, r0
	str r0, [sp, #0x28]
_020CE17C:
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x14]
	cmp r1, r0
	bhs _020CE1F4
	ldr r1, [sp, #0x60]
	ldr r0, [sp, #0x20]
	mov r3, fp
	add r0, r1, r0, lsl #3
	str r0, [sp]
	str r6, [sp, #4]
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x20]
	str r5, [sp, #8]
	sub r4, r1, r0
	ldr r1, [sp, #0x6c]
	mov r0, r7
	str r1, [sp, #0xc]
	ldr r1, [sp, #0x1c]
	mov r2, r4
	bl sub_20CDF54
	ldr r2, [sp, #0x24]
	ldr r1, [sp, #0x1c]
	add r7, r7, r0, lsl #3
	mul r1, r2, r1
	mul r2, r4, r1
	ldr r1, [sp, #0x6c]
	add r5, r5, r2, lsr r1
	ldr r1, [sp, #0x28]
	add r0, r1, r0
	str r0, [sp, #0x28]
_020CE1F4:
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x10]
	cmp r1, r0
	bhs _020CE268
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x14]
	cmp r1, r0
	bhs _020CE268
	ldr r1, [sp, #0x60]
	ldr r0, [sp, #0x20]
	ldr r2, [sp, #0x10]
	add r0, r1, r0, lsl #3
	ldr r1, [sp, #0x1c]
	ldr r3, [sp, #0x14]
	str r0, [sp]
	sub r1, r2, r1
	ldr r2, [sp, #0x20]
	str r6, [sp, #4]
	sub r2, r3, r2
	ldr r3, [sp, #0x1c]
	ldr r4, [sp, #0x6c]
	str r5, [sp, #8]
	mov r0, r7
	add r3, fp, r3, lsl #3
	str r4, [sp, #0xc]
	bl sub_20CDF54
	ldr r1, [sp, #0x28]
	add r0, r1, r0
	str r0, [sp, #0x28]
_020CE268:
	ldr r0, [sp, #0x28]
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_020CE274: .word 0x021127C4
_020CE278: .word 0x000001FF
_020CE27C: .word 0xFE00FF00
_020CE280: .word 0x3FFF3FFF
	arm_func_end sub_20CDF54

	arm_func_start sub_20CE284
sub_20CE284: // 0x020CE284
	stmdb sp!, {r4, r5, r6, lr}
	mov r3, r0, lsr #3
	mov r6, r1, lsr #3
	mul ip, r3, r6
	and r2, r0, #4
	and lr, r0, #2
	and r0, r0, #1
	add r4, r0, lr, lsr #1
	mov r5, r2, lsr #2
	and r0, r1, #4
	add lr, ip, #0
	add ip, r5, r4, lsl #1
	mla ip, r6, ip, lr
	and lr, r1, #2
	and r1, r1, #1
	add lr, r1, lr, lsr #1
	mov r1, r0, lsr #2
	add r1, r1, lr, lsl #1
	mla ip, r3, r1, ip
	add r1, r4, r2, lsr #2
	add r0, lr, r0, lsr #2
	mla r0, r1, r0, ip
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20CE284

	arm_func_start sub_20CE2E0
sub_20CE2E0: // 0x020CE2E0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr ip, [sp, #0x1c]
	ldr r8, [sp, #0x18]
	mov ip, ip, lsl #0x1c
	mov r4, ip, lsr #0x10
	mov r6, #0
	cmp r2, #0
	ldmleia sp!, {r4, r5, r6, r7, r8, pc}
	mov lr, r3, lsl #1
	mov ip, r6
_020CE308:
	mov r5, r0
	mov r7, ip
	cmp r1, #0
	ble _020CE330
_020CE318:
	orr r3, r4, r8
	add r7, r7, #1
	cmp r7, r1
	add r8, r8, #1
	strh r3, [r5], #2
	blt _020CE318
_020CE330:
	add r6, r6, #1
	cmp r6, r2
	add r0, r0, lr
	blt _020CE308
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end sub_20CE2E0

	arm_func_start sub_20CE344
sub_20CE344: // 0x020CE344
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r5, [sp, #0x24]
	ldr lr, [sp, #0x20]
	cmp r5, #0x20
	ldr ip, [sp, #0x28]
	bgt _020CE384
	mla r4, r5, lr, r3
	ldr lr, [sp, #0x2c]
	str ip, [sp]
	mov r3, r5
	add r0, r0, r4, lsl #1
	str lr, [sp, #4]
	bl sub_20CE2E0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020CE384:
	ldr r4, [sp, #0x2c]
	add r7, lr, r2
	mov r2, r4, lsl #0x1c
	cmp lr, r7
	add r8, r3, r1
	mov r4, r2, lsr #0x10
	addge sp, sp, #8
	ldmgeia sp!, {r4, r5, r6, r7, r8, pc}
_020CE3A4:
	cmp lr, #0x20
	movlt r1, lr
	addge r1, lr, #0x20
	mov r6, r3
	cmp r3, r8
	add r5, r0, r1, lsl #6
	bge _020CE3E8
_020CE3C0:
	cmp r6, #0x20
	movlt r1, r6
	addge r1, r6, #0x3e0
	orr r2, r4, ip
	mov r1, r1, lsl #1
	add r6, r6, #1
	strh r2, [r5, r1]
	cmp r6, r8
	add ip, ip, #1
	blt _020CE3C0
_020CE3E8:
	add lr, lr, #1
	cmp lr, r7
	blt _020CE3A4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end sub_20CE344

	arm_func_start sub_20CE3FC
sub_20CE3FC: // 0x020CE3FC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x18
	cmp r2, #8
	movlt r4, r2
	movge ip, #3
	clzlt r4, r4
	rsblt ip, r4, #0x1f
	cmp r3, #8
	movlt r4, r3
	movge r6, #3
	clzlt r4, r4
	rsblt r6, r4, #0x1f
	ldr r4, _020CE47C // =_021127C4
	ldr r5, [sp, #0x28]
	add r4, r4, r6, lsl #3
	ldrb r6, [r4, ip, lsl #1]
	add ip, r4, ip, lsl #1
	ldr r4, _020CE480 // =sub_20CEA0C
	strb r6, [sp, #0x14]
	ldrb r6, [ip, #1]
	ldr lr, _020CE484 // =sub_20CE9B0
	ldr ip, _020CE488 // =sub_20CE5C4
	strb r6, [sp, #0x15]
	str r5, [sp]
	str r4, [sp, #4]
	str lr, [sp, #8]
	str ip, [sp, #0xc]
	ldr ip, [sp, #0x14]
	str ip, [sp, #0x10]
	bl sub_20CE58C
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020CE47C: .word 0x021127C4
_020CE480: .word sub_20CEA0C
_020CE484: .word sub_20CE9B0
_020CE488: .word sub_20CE5C4
	arm_func_end sub_20CE3FC

	arm_func_start sub_20CE48C
sub_20CE48C: // 0x020CE48C
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	ldr lr, [sp, #0x18]
	ldr ip, _020CE4C4 // =sub_20CEC14
	str lr, [sp]
	ldr lr, _020CE4C8 // =sub_20CE9B0
	str ip, [sp, #4]
	ldr ip, _020CE4CC // =sub_20CE7D8
	str lr, [sp, #8]
	str ip, [sp, #0xc]
	str r2, [sp, #0x10]
	bl sub_20CE58C
	add sp, sp, #0x14
	ldmia sp!, {pc}
	.align 2, 0
_020CE4C4: .word sub_20CEC14
_020CE4C8: .word sub_20CE9B0
_020CE4CC: .word sub_20CE7D8
	arm_func_end sub_20CE48C

	arm_func_start sub_20CE4D0
sub_20CE4D0: // 0x020CE4D0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r7, r1
	ldrh r1, [sp, #0x2c]
	mov r8, r0
	mov r0, r7
	mov r6, r2
	mov r5, r3
	bl sub_20CDE40
	ldr r1, _020CE588 // =0x0000FFFF
	mov r4, r0
	cmp r4, r1
	ldreq r0, [r7]
	ldreqh r4, [r0, #2]
	mov r0, r7
	mov r1, r4
	bl sub_20CDD8C
	str r0, [sp, #8]
	ldr r0, [r7]
	ldr r2, [sp, #0x28]
	ldr r0, [r0, #8]
	add r1, sp, #8
	ldrh r3, [r0, #2]
	add ip, r0, #8
	mov r0, r8
	mla r3, r4, r3, ip
	str r3, [sp, #0xc]
	str r2, [sp]
	str r1, [sp, #4]
	ldr r1, [sp, #8]
	ldr r4, [r8, #0x14]
	ldrsb r2, [r1]
	mov r1, r7
	mov r3, r5
	add r2, r6, r2
	blx r4
	ldrh r0, [r7, #8]
	cmp r0, #0
	ldrne r0, [sp, #8]
	ldrnesb r1, [r0]
	ldrneb r0, [r0, #1]
	addne r0, r1, r0
	ldreq r0, [sp, #8]
	ldreqsb r0, [r0, #2]
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020CE588: .word 0x0000FFFF
	arm_func_end sub_20CE4D0

	arm_func_start sub_20CE58C
sub_20CE58C: // 0x020CE58C
	str r2, [r0, #4]
	ldr r2, [sp]
	str r3, [r0, #8]
	strb r2, [r0, #0xc]
	ldr r2, [sp, #4]
	str r1, [r0]
	ldr r1, [sp, #8]
	str r2, [r0, #0x14]
	ldr r2, [sp, #0xc]
	str r1, [r0, #0x18]
	ldr r1, [sp, #0x10]
	str r2, [r0, #0x1c]
	str r1, [r0, #0x10]
	bx lr
	arm_func_end sub_20CE58C

	arm_func_start sub_20CE5C4
sub_20CE5C4: // 0x020CE5C4
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x54
	ldrb r4, [r0, #0xc]
	mov sl, r2
	str r1, [sp, #0xc]
	str r4, [sp, #0x44]
	ldr r1, [sp, #0x44]
	ldr r4, [sp, #0x78]
	cmp r1, #4
	add r1, sl, r4
	str r1, [sp, #0x1c]
	ldr r2, [sp, #0x7c]
	mov r1, r3
	add r1, r1, r2
	str r1, [sp, #0x20]
	ldrne r1, [sp, #0xc]
	str r3, [sp, #0x10]
	orrne r1, r1, r1, lsl #8
	orrne r1, r1, r1, lsl #16
	strne r1, [sp, #0xc]
	bne _020CE62C
	ldr r1, [sp, #0xc]
	orr r1, r1, r1, lsl #4
	orr r1, r1, r1, lsl #8
	orr r1, r1, r1, lsl #16
	str r1, [sp, #0xc]
_020CE62C:
	bic r1, sl, #7
	str r1, [sp, #0x30]
	ldr r1, [sp, #0x10]
	ldr r2, [r0, #0x10]
	bic r1, r1, #7
	str r1, [sp, #0x14]
	ldr r1, [sp, #0x44]
	str r2, [sp, #0x4c]
	mov r3, r1, lsl #6
	mov r2, r3, asr #2
	ldr r1, [sp, #0x20]
	add r3, r3, r2, lsr #29
	ldr r2, [sp, #0x1c]
	add r6, r1, #7
	add r2, r2, #7
	bic r5, r2, #7
	bic r2, r6, #7
	ldr r1, [sp, #0x30]
	str r2, [sp, #0x24]
	mov r2, r3, asr #3
	str r2, [sp, #0x48]
	mov r4, r1, asr #2
	ldr r2, [sp, #0x30]
	ldr r1, [sp, #0x14]
	add r2, r2, r4, lsr #29
	mov r2, r2, asr #3
	str r2, [sp, #0x2c]
	ldr r2, [sp, #0x14]
	mov r1, r1, asr #2
	add r1, r2, r1, lsr #29
	mov r6, r1, asr #3
	ldr r1, [sp, #0x24]
	cmp r2, r1
	ldr r1, [r0, #4]
	str r1, [sp, #0x40]
	ldr r1, [r0, #8]
	ldr r0, [r0]
	str r1, [sp, #0x3c]
	str r0, [sp, #0x28]
	ldrb r0, [sp, #0x4c]
	str r0, [sp, #0x38]
	ldrb r0, [sp, #0x4d]
	str r0, [sp, #0x34]
	addge sp, sp, #0x54
	ldmgeia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r4, #0
	mov fp, #8
_020CE6E8:
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x10]
	ldr r7, [sp, #0x2c]
	cmp r1, r0
	movlt r1, r0
	ldrlt r0, [sp, #0x14]
	sublt sb, r1, r0
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x14]
	movge sb, r4
	sub r0, r1, r0
	cmp r0, #8
	movgt r0, fp
	sub r0, r0, sb
	str r0, [sp, #0x18]
	ldr r0, [sp, #0x30]
	cmp r0, r5
	mov r8, r0
	bge _020CE7B4
_020CE734:
	ldr r0, [sp, #0x38]
	ldr r2, [sp, #0x40]
	str r0, [sp]
	ldr r0, [sp, #0x34]
	ldr r3, [sp, #0x3c]
	str r0, [sp, #4]
	mov r0, r7
	mov r1, r6
	bl sub_20CF16C
	ldr r2, [sp, #0x1c]
	cmp r8, sl
	sublt r1, sl, r8
	sub r2, r2, r8
	movge r1, r4
	cmp r2, #8
	movgt r2, fp
	sub r3, r2, r1
	ldr r2, [sp, #0x18]
	ldr ip, [sp, #0x48]
	str r2, [sp]
	ldr r2, [sp, #0xc]
	str r2, [sp, #4]
	ldr r2, [sp, #0x44]
	str r2, [sp, #8]
	ldr r2, [sp, #0x28]
	mla r0, ip, r0, r2
	mov r2, sb
	bl sub_20CF01C
	add r8, r8, #8
	add r7, r7, #1
	cmp r8, r5
	blt _020CE734
_020CE7B4:
	ldr r0, [sp, #0x14]
	add r6, r6, #1
	add r1, r0, #8
	ldr r0, [sp, #0x24]
	str r1, [sp, #0x14]
	cmp r1, r0
	blt _020CE6E8
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end sub_20CE5C4

	arm_func_start sub_20CE7D8
sub_20CE7D8: // 0x020CE7D8
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x3c
	ldrb r4, [r0, #0xc]
	mov sl, r2
	str r1, [sp, #0xc]
	str r4, [sp, #0x2c]
	ldr r1, [sp, #0x2c]
	ldr r4, [sp, #0x60]
	cmp r1, #4
	add r1, sl, r4
	str r1, [sp, #0x18]
	ldr r2, [sp, #0x64]
	mov r1, r3
	add r1, r1, r2
	str r1, [sp, #0x1c]
	ldrne r1, [sp, #0xc]
	str r3, [sp, #0x10]
	orrne r1, r1, r1, lsl #8
	orrne r1, r1, r1, lsl #16
	strne r1, [sp, #0xc]
	bne _020CE840
	ldr r1, [sp, #0xc]
	orr r1, r1, r1, lsl #4
	orr r1, r1, r1, lsl #8
	orr r1, r1, r1, lsl #16
	str r1, [sp, #0xc]
_020CE840:
	ldr r1, [sp, #0x10]
	bic r1, r1, #7
	mov r2, r1, asr #2
	str r1, [sp, #0x14]
	add r1, r1, r2, lsr #29
	ldr r2, [r0, #0x10]
	mov r3, r1, asr #3
	mul r1, r3, r2
	bic r3, sl, #7
	str r3, [sp, #0x28]
	ldr r3, [sp, #0x2c]
	mov r6, r3, lsl #6
	ldr r3, [sp, #0x28]
	mov r4, r6, asr #2
	mov r5, r3, asr #2
	add r5, r3, r5, lsr #29
	add r4, r6, r4, lsr #29
	mov r3, r4, asr #3
	str r3, [sp, #0x30]
	ldr r3, [sp, #0x1c]
	add r1, r1, r5, asr #3
	add r4, r3, #7
	ldr r3, [r0]
	ldr r0, [sp, #0x18]
	add r5, r0, #7
	ldr r0, [sp, #0x30]
	bic r7, r5, #7
	mla r1, r0, r1, r3
	bic r0, r4, #7
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x30]
	str r1, [sp, #0x24]
	mul r0, r2, r0
	str r0, [sp, #0x34]
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x20]
	cmp r1, r0
	addge sp, sp, #0x3c
	ldmgeia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r5, #0
	mov r4, #8
_020CE8E4:
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x10]
	ldr r6, [sp, #0x24]
	cmp r1, r0
	movlt r1, r0
	ldrlt r0, [sp, #0x14]
	sublt sb, r1, r0
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x14]
	movge sb, r5
	sub r0, r1, r0
	cmp r0, #8
	movgt r0, r4
	sub fp, r0, sb
	ldr r0, [sp, #0x28]
	cmp r0, r7
	mov r8, r0
	bge _020CE980
_020CE92C:
	ldr r0, [sp, #0x18]
	cmp r8, sl
	sublt r1, sl, r8
	sub r0, r0, r8
	movge r1, r5
	cmp r0, #8
	movgt r0, r4
	sub r3, r0, r1
	ldr r0, [sp, #0xc]
	str fp, [sp]
	str r0, [sp, #4]
	ldr r0, [sp, #0x2c]
	mov r2, sb
	str r0, [sp, #8]
	mov r0, r6
	bl sub_20CF01C
	ldr r0, [sp, #0x30]
	add r8, r8, #8
	add r6, r6, r0
	cmp r8, r7
	blt _020CE92C
_020CE980:
	ldr r1, [sp, #0x24]
	ldr r0, [sp, #0x34]
	add r0, r1, r0
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x14]
	add r1, r0, #8
	ldr r0, [sp, #0x20]
	str r1, [sp, #0x14]
	cmp r1, r0
	blt _020CE8E4
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end sub_20CE7D8

	arm_func_start sub_20CE9B0
sub_20CE9B0: // 0x020CE9B0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r3, r0
	ldrb r2, [r3, #0xc]
	ldr ip, [r3, #4]
	cmp r2, #4
	orreq r0, r1, r1, lsl #4
	orreq r0, r0, r0, lsl #8
	orreq r1, r0, r0, lsl #16
	orrne r0, r1, r1, lsl #8
	orrne r1, r0, r0, lsl #16
	ldr r0, [r3, #8]
	mov r2, r2, lsl #6
	mul lr, ip, r0
	mov r0, r2, asr #2
	add r0, r2, r0, lsr #29
	mov r2, r0, asr #3
	mov r0, r1
	mul r2, lr, r2
	ldr r1, [r3]
	bl MIi_CpuClearFast
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20CE9B0

	arm_func_start sub_20CEA0C
sub_20CEA0C: // 0x020CEA0C
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x4c
	ldr r7, [sp, #0x74]
	ldrb r5, [r0, #0xc]
	ldr r6, [r1]
	ldr r4, [r7]
	ldr sb, [r6, #8]
	mov r8, r5, lsl #6
	ldrb r4, [r4, #1]
	mov r5, r8, asr #2
	add r5, r8, r5, lsr #29
	ldrb sb, [sb, #1]
	ldr r8, [r0, #4]
	ldr r6, [r0, #8]
	str r2, [sp, #8]
	str r3, [sp, #0xc]
	cmp r4, #0
	mov r5, r5, asr #3
	addeq sp, sp, #0x4c
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	adds r3, r2, r4
	addmi sp, sp, #0x4c
	ldmmiia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r2, [sp, #0xc]
	adds r2, r2, sb
	addmi sp, sp, #0x4c
	ldmmiia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr sl, [sp, #8]
	add r3, r3, #7
	cmp sl, #0
	movle sl, #0
	strle sl, [sp, #0x10]
	movgt sl, sl, lsr #3
	strgt sl, [sp, #0x10]
	ldr sl, [sp, #0xc]
	add r2, r2, #7
	cmp sl, #0
	movle sl, #0
	mov fp, r2, lsr #3
	mov r3, r3, lsr #3
	movgt sl, sl, lsr #3
	cmp r3, r8
	movhs r3, r8
	cmp fp, r6
	ldr r2, [sp, #0x10]
	movhs fp, r6
	subs r8, r3, r2
	addmi sp, sp, #0x4c
	sub r3, fp, sl
	ldmmiia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	cmp r3, #0
	addlt sp, sp, #0x4c
	ldmltia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r2, [sp, #8]
	ldr r6, [r0]
	cmp r2, #0
	andge r2, r2, #7
	strge r2, [sp, #8]
	ldr r2, [sp, #0xc]
	ldr fp, [sp, #8]
	cmp r2, #0
	andge r2, r2, #7
	strge r2, [sp, #0xc]
	sub r8, fp, r8, lsl #3
	ldr fp, [sp, #0xc]
	ldr r2, [sp, #0x70]
	sub r3, fp, r3, lsl #3
	str r3, [sp, #0x14]
	ldr r3, [r7, #4]
	sub r2, r2, #1
	str r3, [sp, #0x28]
	str r2, [sp, #0x48]
	str sb, [sp, #0x38]
	str r4, [sp, #0x34]
	ldr r4, [r1]
	ldr r2, [sp, #0x14]
	mov r3, fp
	cmp r3, r2
	ldr r2, [r4, #8]
	ldrb r3, [r2, #6]
	str r3, [sp, #0x40]
	ldrb r2, [r0, #0xc]
	str r2, [sp, #0x44]
	ldr r1, [r1]
	ldr r1, [r1, #8]
	ldrb r1, [r1]
	mul r1, r3, r1
	str r1, [sp, #0x3c]
	ldr r1, [r0, #0x10]
	str r1, [sp, #0x20]
	ldr r1, [r0, #4]
	ldr r0, [r0, #8]
	ldrb fp, [sp, #0x20]
	ldrb r4, [sp, #0x21]
	str r1, [sp, #0x1c]
	str r0, [sp, #0x18]
	addle sp, sp, #0x4c
	ldmleia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_020CEB94:
	ldr r0, [sp, #0xc]
	ldr r7, [sp, #0x10]
	str r0, [sp, #0x30]
	ldr r0, [sp, #8]
	cmp r0, r8
	mov sb, r0
	ble _020CEBF0
_020CEBB0:
	ldr r2, [sp, #0x1c]
	str fp, [sp]
	ldr r3, [sp, #0x18]
	mov r0, r7
	mov r1, sl
	str r4, [sp, #4]
	bl sub_20CF16C
	mla r1, r0, r5, r6
	add r0, sp, #0x24
	str sb, [sp, #0x2c]
	str r1, [sp, #0x24]
	bl sub_20CEDB0
	sub sb, sb, #8
	add r7, r7, #1
	cmp sb, r8
	bgt _020CEBB0
_020CEBF0:
	ldr r0, [sp, #0xc]
	add sl, sl, #1
	sub r1, r0, #8
	ldr r0, [sp, #0x14]
	str r1, [sp, #0xc]
	cmp r1, r0
	bgt _020CEB94
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end sub_20CEA0C

	arm_func_start sub_20CEC14
sub_20CEC14: // 0x020CEC14
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x2c
	ldr r4, [sp, #0x54]
	ldrb r5, [r0, #0xc]
	str r4, [sp, #0x54]
	ldr r4, [r4]
	ldr r6, [r1]
	mov r7, r5, lsl #6
	ldrb r4, [r4, #1]
	mov r5, r7, asr #2
	add r5, r7, r5, lsr #29
	cmp r4, #0
	ldr r6, [r6, #8]
	mov sb, r3
	ldr r8, [r0, #4]
	ldr r7, [r0, #8]
	mov sl, r2
	mov r5, r5, asr #3
	addeq sp, sp, #0x2c
	ldr lr, [r0]
	ldrb r3, [r6, #1]
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	adds r6, sl, r4
	addmi sp, sp, #0x2c
	ldmmiia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	adds r2, sb, r3
	addmi sp, sp, #0x2c
	ldmmiia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	cmp sl, #0
	movle fp, #0
	add r6, r6, #7
	movgt fp, sl, lsr #3
	cmp sb, #0
	movle ip, #0
	add r2, r2, #7
	mov r6, r6, lsr #3
	movgt ip, sb, lsr #3
	cmp r6, r8
	movhs r6, r8
	mov r2, r2, lsr #3
	cmp r2, r7
	movhs r2, r7
	subs r7, r6, fp
	addmi sp, sp, #0x2c
	sub r2, r2, ip
	ldmmiia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	cmp r2, #0
	addlt sp, sp, #0x2c
	ldmltia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r6, [r0, #0x10]
	cmp sl, #0
	sub r8, r6, r7
	mul r8, r5, r8
	mla fp, r6, ip, fp
	andge sl, sl, #7
	str r8, [sp]
	ldr r8, [sp, #0x54]
	mla r6, r5, fp, lr
	ldr ip, [r8, #4]
	ldr fp, [sp, #0x50]
	cmp sb, #0
	sub r8, fp, #1
	andge sb, sb, #7
	sub fp, sb, r2, lsl #3
	str ip, [sp, #8]
	str r4, [sp, #0x14]
	str r8, [sp, #0x28]
	str r3, [sp, #0x18]
	ldr r3, [r1]
	cmp sb, fp
	ldr r2, [r3, #8]
	sub r7, sl, r7, lsl #3
	ldrb r2, [r2, #6]
	str r2, [sp, #0x20]
	ldrb r0, [r0, #0xc]
	str r0, [sp, #0x24]
	ldr r0, [r1]
	ldr r0, [r0, #8]
	ldrb r0, [r0]
	mul r0, r2, r0
	str r0, [sp, #0x1c]
	addle sp, sp, #0x2c
	ldmleia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	add r4, sp, #4
_020CED64:
	mov r8, sl
	str sb, [sp, #0x10]
	cmp sl, r7
	ble _020CED94
_020CED74:
	mov r0, r4
	str r6, [sp, #4]
	str r8, [sp, #0xc]
	bl sub_20CEDB0
	sub r8, r8, #8
	cmp r8, r7
	add r6, r6, r5
	bgt _020CED74
_020CED94:
	ldr r0, [sp]
	sub sb, sb, #8
	cmp sb, fp
	add r6, r6, r0
	bgt _020CED64
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end sub_20CEC14

	arm_func_start sub_20CEDB0
sub_20CEDB0: // 0x020CEDB0
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x34
	ldr r5, [r0, #8]
	ldr r4, [r0, #0xc]
	cmp r5, #0
	strge r5, [sp]
	movlt r1, #0
	strlt r1, [sp]
	ldr r1, [r0, #0x10]
	cmp r4, #0
	add sl, r5, r1
	ldr r1, [r0, #0x14]
	movge r2, r4
	movlt r2, #0
	cmp sl, #8
	add r3, r4, r1
	movge sl, #8
	cmp r3, #8
	movge r3, #8
	cmp r4, #0
	movgt r4, #0
	cmp r5, #0
	ldr r8, [r0, #0x20]
	movgt r5, #0
	rsb r1, r4, #0
	mul r7, sl, r8
	ldr r6, [r0, #0x1c]
	rsb r4, r5, #0
	mul sb, r6, r4
	ldr r4, [r0, #0x18]
	mov sl, r7
	str r4, [sp, #8]
	ldr r4, [sp]
	cmp r8, #4
	mul r5, r4, r8
	ldr r4, [sp, #8]
	str r5, [sp]
	mla fp, r1, r4, sb
	ldr r1, [r0, #4]
	str r1, [sp, #4]
	bne _020CEF28
	ldr r1, [r0]
	ldr r7, [r0, #0x24]
	add r0, r1, r2, lsl #2
	str r0, [sp, #0xc]
	add r0, r1, r3, lsl #2
	ldr r1, [sp, #0xc]
	str r0, [sp, #0x10]
	cmp r1, r0
	addhs sp, sp, #0x34
	ldmhsia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, #0
	add sb, sp, #0x24
	mov r4, #0xf
	str r0, [sp, #0x1c]
_020CEE8C:
	ldr r0, [sp, #0xc]
	mov r1, fp, lsr #0x1f
	ldr r5, [r0]
	ldr r0, [sp, #4]
	rsb r2, r1, fp, lsl #29
	add r0, r0, fp, lsr #3
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x1c]
	add r1, r1, r2, ror #29
	strb r0, [sp, #0x28]
	strb r0, [sp, #0x29]
	mov r0, sb
	bl sub_20CF7B4
	ldr r8, [sp]
	mov r0, r8
	cmp r0, sl
	bhs _020CEEFC
_020CEED0:
	mov r0, sb
	mov r1, r6
	bl sub_20CF7B4
	cmp r0, #0
	mvnne r1, r4, lsl r8
	addne r0, r7, r0
	andne r1, r5, r1
	orrne r5, r1, r0, lsl r8
	add r8, r8, #4
	cmp r8, sl
	blo _020CEED0
_020CEEFC:
	ldr r0, [sp, #0xc]
	add r1, r0, #4
	str r5, [r0]
	ldr r0, [sp, #0x10]
	str r1, [sp, #0xc]
	cmp r1, r0
	ldr r0, [sp, #8]
	add fp, fp, r0
	blo _020CEE8C
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_020CEF28:
	ldr r1, [r0]
	ldr sb, [r0, #0x24]
	add r0, r1, r2, lsl #3
	str r0, [sp, #0x14]
	add r0, r1, r3, lsl #3
	ldr r1, [sp, #0x14]
	str r0, [sp, #0x18]
	cmp r1, r0
	addhs sp, sp, #0x34
	ldmhsia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, #0
	mov r4, #0xff
	str r0, [sp, #0x20]
_020CEF5C:
	mov r1, fp, lsr #0x1f
	rsb r0, r1, fp, lsl #29
	add r1, r1, r0, ror #29
	ldr r0, [sp, #0x14]
	ldr r8, [r0]
	ldr r7, [r0, #4]
	ldr r0, [sp, #4]
	add r0, r0, fp, lsr #3
	str r0, [sp, #0x2c]
	ldr r0, [sp, #0x20]
	strb r0, [sp, #0x30]
	strb r0, [sp, #0x31]
	add r0, sp, #0x2c
	bl sub_20CF7B4
	ldr r0, [sp]
	cmp r0, sl
	mov r5, r0
	bhs _020CEFEC
_020CEFA4:
	add r0, sp, #0x2c
	mov r1, r6
	bl sub_20CF7B4
	cmp r0, #0
	beq _020CEFE0
	cmp r5, #0x20
	mvnlo r1, r4, lsl r5
	addlo r0, sb, r0
	andlo r1, r8, r1
	orrlo r8, r1, r0, lsl r5
	subhs r2, r5, #0x20
	mvnhs r1, r4, lsl r2
	addhs r0, sb, r0
	andhs r1, r7, r1
	orrhs r7, r1, r0, lsl r2
_020CEFE0:
	add r5, r5, #8
	cmp r5, sl
	blo _020CEFA4
_020CEFEC:
	ldr r0, [sp, #0x14]
	str r8, [r0]
	add r1, r0, #8
	str r7, [r0, #4]
	ldr r0, [sp, #0x18]
	str r1, [sp, #0x14]
	cmp r1, r0
	ldr r0, [sp, #8]
	add fp, fp, r0
	blo _020CEF5C
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end sub_20CEDB0

	arm_func_start sub_20CF01C
sub_20CF01C: // 0x020CF01C
	stmdb sp!, {r4, r5, r6, lr}
	mov lr, r0
	cmp r3, #8
	ldr r0, [sp, #0x14]
	bne _020CF050
	ldr r4, [sp, #0x10]
	cmp r4, #8
	bne _020CF050
	ldr r2, [sp, #0x18]
	mov r1, lr
	mov r2, r2, lsl #3
	bl MIi_CpuClearFast
	ldmia sp!, {r4, r5, r6, pc}
_020CF050:
	ldr r4, [sp, #0x18]
	cmp r4, #4
	bne _020CF0B0
	mov r5, r1, lsl #2
	add r4, r5, r3, lsl #2
	mvn r3, #0
	rsb r4, r4, #0x20
	mov r3, r3, lsr r5
	add r1, r4, r1, lsl #2
	mov r3, r3, lsl r1
	ldr r1, [sp, #0x10]
	add r5, lr, r2, lsl #2
	add r2, r5, r1, lsl #2
	and r6, r0, r3, lsr r4
	cmp r5, r2
	mvn r1, r3, lsr r4
	ldmhsia sp!, {r4, r5, r6, pc}
_020CF094:
	ldr r0, [r5]
	and r0, r0, r1
	orr r0, r6, r0
	str r0, [r5], #4
	cmp r5, r2
	blo _020CF094
	ldmia sp!, {r4, r5, r6, pc}
_020CF0B0:
	mov ip, r1, lsl #3
	add r1, ip, r3, lsl #3
	rsb r1, r1, #0x40
	mvn r3, #0
	cmp r1, #0x20
	mov r5, r3, lsr ip
	subhs r4, r1, #0x20
	addhs r3, ip, r4
	movhs r3, r5, lsl r3
	movhs r3, r3, lsr r4
	movlo r3, r5, lsl ip
	mvn r4, #0
	add r5, lr, r2, lsl #3
	cmp ip, #0x20
	mov r4, r4, lsl r1
	subhs ip, ip, #0x20
	addhs r1, ip, r1
	movhs r1, r4, lsr r1
	movhs r6, r1, lsl ip
	movlo r6, r4, lsr r1
	ldr r1, [sp, #0x10]
	and lr, r0, r3
	add r4, r5, r1, lsl #3
	cmp r5, r4
	and ip, r0, r6
	mvn r2, r3
	mvn r1, r6
	ldmhsia sp!, {r4, r5, r6, pc}
_020CF120:
	ldr r0, [r5]
	and r0, r0, r2
	orr r0, lr, r0
	str r0, [r5]
	ldr r0, [r5, #4]
	and r0, r0, r1
	orr r0, ip, r0
	str r0, [r5, #4]
	add r5, r5, #8
	cmp r5, r4
	blo _020CF120
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20CF01C

	arm_func_start sub_20CF150
sub_20CF150: // 0x020CF150
	ldrb r3, [r0, #1]
	ldr r2, _020CF168 // =_021127E4
	ldrb r1, [r0]
	add r0, r2, r3, lsl #4
	ldr r0, [r0, r1, lsl #2]
	bx lr
	.align 2, 0
_020CF168: .word 0x021127E4
	arm_func_end sub_20CF150

	arm_func_start sub_20CF16C
sub_20CF16C: // 0x020CF16C
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #4
	ldr fp, _020CF268 // =_021127C4
	mov sb, #0
	mov sl, #3
	mvn r7, #0
_020CF184:
	ldr r4, [sp, #0x2c]
	ldr r6, [sp, #0x28]
	and ip, r3, r7, lsl r4
	cmp ip, r1
	mov r8, r7, lsl r6
	mov r5, r7, lsl r4
	and lr, r2, r7, lsl r6
	bhi _020CF1D4
	mla sb, r2, ip, sb
	cmp lr, r0
	movhi r2, lr
	subhi r1, r1, ip
	subhi r3, r3, ip
	bhi _020CF21C
	sub r3, r3, ip
	mla sb, lr, r3, sb
	sub r0, r0, lr
	sub r1, r1, ip
	sub r2, r2, lr
	b _020CF21C
_020CF1D4:
	cmp lr, r0
	mlals sb, lr, ip, sb
	mvn r3, r5
	movls r3, ip
	subls r0, r0, lr
	subls r2, r2, lr
	bls _020CF21C
	and r2, r1, r5
	mla r5, lr, r2, sb
	and r2, r0, r8
	and r1, r1, r3
	add r2, r5, r2, lsl r4
	mvn r3, r8
	add r1, r2, r1, lsl r6
	and r0, r0, r3
	add sp, sp, #4
	add r0, r1, r0
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_020CF21C:
	cmp r2, #8
	movlt r4, r2
	movge r5, sl
	clzlt r4, r4
	rsblt r5, r4, #0x1f
	cmp r3, #8
	movge r4, sl
	movlt r4, r3
	clzlt r4, r4
	rsblt r4, r4, #0x1f
	add r4, fp, r4, lsl #3
	add r6, r4, r5, lsl #1
	ldrb r5, [r4, r5, lsl #1]
	ldrb r4, [r6, #1]
	str r5, [sp, #0x28]
	str r4, [sp, #0x2c]
	b _020CF184
	arm_func_end sub_20CF16C

	arm_func_start sub_20CF260
sub_20CF260: // 0x020CF260
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_020CF268: .word 0x021127C4
	arm_func_end sub_20CF260

	arm_func_start sub_20CF26C
sub_20CF26C: // 0x020CF26C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr ip, [sp, #0x28]
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	ands r0, ip, #0x100
	beq _020CF2B0
	ldr r0, [r7, #4]
	ldr r1, [r7, #0xc]
	ldr r2, [sp, #0x2c]
	bl sub_20CDC58
	ldr r1, [sp, #0x20]
	sub r0, r1, r0
	add r5, r5, r0
	b _020CF2E8
_020CF2B0:
	ands r0, ip, #0x80
	beq _020CF2E8
	ldr r0, [r7, #4]
	ldr r1, [r7, #0xc]
	ldr r2, [sp, #0x2c]
	bl sub_20CDC58
	ldr r2, [sp, #0x20]
	add r1, r0, #1
	add r0, r2, #1
	add r0, r0, r0, lsr #31
	mov r2, r0, asr #1
	add r0, r1, r1, lsr #31
	sub r0, r2, r0, asr #1
	add r5, r5, r0
_020CF2E8:
	ldr r1, [sp, #0x24]
	ldr r0, [sp, #0x28]
	str r1, [sp]
	ldr ip, [sp, #0x2c]
	str r0, [sp, #4]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	str ip, [sp, #8]
	bl sub_20CF3C8
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end sub_20CF26C

	arm_func_start sub_20CF31C
sub_20CF31C: // 0x020CF31C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x18
	ldr r4, [sp, #0x34]
	mov r8, r0
	str r4, [sp]
	mov r7, r1
	mov r6, r2
	mov r5, r3
	ldr r4, [sp, #0x30]
	ldr r1, [r8, #4]
	ldr r2, [r8, #8]
	ldr r3, [r8, #0xc]
	add r0, sp, #0xc
	bl sub_20CDBC0
	ands r0, r4, #0x10
	ldrne r0, [sp, #0xc]
	addne r0, r0, #1
	addne r0, r0, r0, lsr #31
	subne r7, r7, r0, asr #1
	bne _020CF378
	ands r0, r4, #0x20
	ldrne r0, [sp, #0xc]
	subne r7, r7, r0
_020CF378:
	ands r0, r4, #2
	ldrne r0, [sp, #0x10]
	addne r0, r0, #1
	addne r0, r0, r0, lsr #31
	subne r6, r6, r0, asr #1
	bne _020CF39C
	ands r0, r4, #4
	ldrne r0, [sp, #0x10]
	subne r6, r6, r0
_020CF39C:
	str r5, [sp]
	ldr r0, [sp, #0x34]
	str r4, [sp, #4]
	str r0, [sp, #8]
	ldr r3, [sp, #0xc]
	mov r0, r8
	mov r1, r7
	mov r2, r6
	bl sub_20CF3C8
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end sub_20CF31C

	arm_func_start sub_20CF3C8
sub_20CF3C8: // 0x020CF3C8
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x14
	mov sl, r0
	ldr r4, [sl, #4]
	ldr r0, [sp, #0x40]
	ldr r4, [r4]
	ldr r5, [sl, #0xc]
	ldrsb r4, [r4, #1]
	cmp r0, #0
	mov sb, r1
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x38]
	mov r8, r2
	str r0, [sp, #0x38]
	mov r7, r3
	add r6, r5, r4
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	add r0, r7, #1
	ldr r1, [sp, #0x3c]
	add r0, r0, r0, lsr #31
	mov r0, r0, asr #1
	and r5, r1, #0x800
	and fp, r1, #0x400
	str r0, [sp, #8]
	mov r4, #0
_020CF430:
	mov r1, sb
	cmp r5, #0
	beq _020CF45C
	ldr r0, [sl, #4]
	ldr r1, [sl, #8]
	ldr r2, [sp, #0xc]
	mov r3, r4
	bl sub_20CDCCC
	sub r0, r7, r0
	add r1, sb, r0
	b _020CF48C
_020CF45C:
	cmp fp, #0
	beq _020CF48C
	ldr r0, [sl, #4]
	ldr r1, [sl, #8]
	ldr r2, [sp, #0xc]
	mov r3, r4
	bl sub_20CDCCC
	add r0, r0, #1
	add r1, r0, r0, lsr #31
	ldr r0, [sp, #8]
	sub r0, r0, r1, asr #1
	add r1, sb, r0
_020CF48C:
	ldr r2, [sp, #0xc]
	add r3, sp, #0xc
	str r2, [sp]
	str r3, [sp, #4]
	ldr r3, [sp, #0x38]
	mov r0, sl
	mov r2, r8
	bl sub_20CF4C4
	ldr r0, [sp, #0xc]
	add r8, r8, r6
	cmp r0, #0
	bne _020CF430
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end sub_20CF3C8

	arm_func_start sub_20CF4C4
sub_20CF4C4: // 0x020CF4C4
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0xc
	mov sl, r0
	ldr r6, [sl, #8]
	ldr r5, [sl, #4]
	ldr r4, [sp, #0x30]
	add r0, sp, #8
	str r4, [sp, #8]
	ldr r4, [r5, #4]
	mov sb, r1
	mov r8, r2
	mov r7, r3
	blx r4
	cmp r0, #0
	beq _020CF540
	add fp, sp, #8
_020CF504:
	cmp r0, #0xa
	beq _020CF540
	str r7, [sp]
	str r0, [sp, #4]
	ldr r0, [sl]
	mov r1, r5
	mov r2, sb
	mov r3, r8
	bl sub_20CE4D0
	add r1, sb, r0
	mov r0, fp
	add sb, r1, r6
	blx r4
	cmp r0, #0
	bne _020CF504
_020CF540:
	ldr r1, [sp, #0x34]
	cmp r1, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	cmp r0, #0xa
	ldreq r1, [sp, #8]
	ldr r0, [sp, #0x34]
	movne r1, #0
	str r1, [r0]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end sub_20CF4C4

	arm_func_start sub_20CF56C
sub_20CF56C: // 0x020CF56C
	stmdb sp!, {r4, r5, r6, lr}
	ldrh r2, [r0, #0xc]
	ldrh r3, [r0, #0xe]
	mov r1, #0
	add r2, r0, r2
	cmp r3, #0
	ldmleia sp!, {r4, r5, r6, pc}
	ldr r3, _020CF64C // =0x46494E46
	ldr ip, _020CF650 // =0x43574448
	ldr r4, _020CF654 // =0x434D4150
	ldr lr, _020CF658 // =0x43474C50
_020CF598:
	ldr r5, [r2]
	cmp r5, r4
	bhi _020CF5B4
	cmp r5, r4
	bhs _020CF61C
	cmp r5, lr
	b _020CF630
_020CF5B4:
	cmp r5, ip
	bhi _020CF5C8
	cmp r5, ip
	beq _020CF604
	b _020CF630
_020CF5C8:
	cmp r5, r3
	bne _020CF630
	add r6, r2, #8
	ldr r5, [r6, #8]
	add r5, r5, r0
	str r5, [r6, #8]
	ldr r5, [r6, #0xc]
	cmp r5, #0
	addne r5, r5, r0
	strne r5, [r6, #0xc]
	ldr r5, [r6, #0x10]
	cmp r5, #0
	addne r5, r5, r0
	strne r5, [r6, #0x10]
	b _020CF630
_020CF604:
	add r6, r2, #8
	ldr r5, [r6, #4]
	cmp r5, #0
	addne r5, r5, r0
	strne r5, [r6, #4]
	b _020CF630
_020CF61C:
	add r6, r2, #8
	ldr r5, [r6, #8]
	cmp r5, #0
	addne r5, r5, r0
	strne r5, [r6, #8]
_020CF630:
	ldrh r5, [r0, #0xe]
	ldr r6, [r2, #4]
	add r1, r1, #1
	cmp r1, r5
	add r2, r2, r6
	blt _020CF598
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020CF64C: .word 0x46494E46
_020CF650: .word 0x43574448
_020CF654: .word 0x434D4150
_020CF658: .word 0x43474C50
	arm_func_end sub_20CF56C

	arm_func_start sub_20CF65C
sub_20CF65C: // 0x020CF65C
	stmdb sp!, {r4, r5, r6, lr}
	movs r6, r0
	mov r5, r1
	beq _020CF6CC
	cmp r6, #0
	beq _020CF688
	ldr r1, [r6]
	ldr r0, _020CF7AC // =0x4E465452
	cmp r1, r0
	moveq r0, #1
	beq _020CF68C
_020CF688:
	mov r0, #0
_020CF68C:
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	beq _020CF6D0
	cmp r6, #0
	beq _020CF6B8
	ldrh r0, [r6, #6]
	cmp r0, #0x100
	movhs r0, #1
	bhs _020CF6BC
_020CF6B8:
	mov r0, #0
_020CF6BC:
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	b _020CF6D0
_020CF6CC:
	mov r0, #0
_020CF6D0:
	cmp r0, #0
	movne r4, #0
	bne _020CF758
	cmp r6, #0
	beq _020CF744
	cmp r6, #0
	beq _020CF700
	ldr r1, [r6]
	ldr r0, _020CF7AC // =0x4E465452
	cmp r1, r0
	moveq r0, #1
	beq _020CF704
_020CF700:
	mov r0, #0
_020CF704:
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	beq _020CF748
	cmp r6, #0
	beq _020CF730
	ldrh r0, [r6, #6]
	cmp r0, #1
	movhs r0, #1
	bhs _020CF734
_020CF730:
	mov r0, #0
_020CF734:
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	b _020CF748
_020CF744:
	mov r0, #0
_020CF748:
	cmp r0, #0
	movne r4, #1
	bne _020CF758
	bl OS_Terminate
_020CF758:
	mov r0, r6
	bl sub_20CF56C
	ldr r1, _020CF7B0 // =0x46494E46
	mov r0, r6
	bl sub_20CDB68
	cmp r0, #0
	moveq r0, #0
	streq r0, [r5]
	ldmeqia sp!, {r4, r5, r6, pc}
	add r0, r0, #8
	str r0, [r5]
	cmp r4, #0
	beq _020CF7A4
	ldr r2, [r5]
	mov r1, #0
	ldrsb r0, [r2, #6]
	strb r0, [r2, #7]
	ldr r0, [r5]
	strb r1, [r0, #6]
_020CF7A4:
	add r0, r4, #1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020CF7AC: .word 0x4E465452
_020CF7B0: .word 0x46494E46
	arm_func_end sub_20CF65C

	arm_func_start sub_20CF7B4
sub_20CF7B4: // 0x020CF7B4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldrsb r2, [r0, #4]
	ldrb ip, [r0, #5]
	mov r4, r1
	cmp r2, r4
	subge r1, r2, r4
	movge r5, ip, lsr r1
	strgeb r1, [r0, #4]
	bge _020CF808
	ldr r3, [r0]
	sub r1, r4, r2
	add r2, r3, #1
	str r2, [r0]
	ldrb r2, [r3]
	mov r5, ip, lsl r1
	strb r2, [r0, #5]
	mov r2, #8
	strb r2, [r0, #4]
	bl sub_20CF7B4
	orr r5, r0, r5
_020CF808:
	rsb r0, r4, #8
	mov r1, #0xff
	and r0, r5, r1, asr r0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20CF7B4

	arm_func_start sub_20CF81C
sub_20CF81C: // 0x020CF81C
	ldr r1, [r0]
	ldrh r2, [r1], #2
	str r1, [r0]
	mov r0, r2
	bx lr
	arm_func_end sub_20CF81C