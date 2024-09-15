	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start sub_37F8538
sub_37F8538: // 0x037F8538
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	ldr r8, _037F85EC // =0x0380FFF4
	ldr r9, [r8]
	mov r7, #0
	strh r7, [r9, #0x10]
	strh r7, [r9, #0x14]
	add r6, sp, #0
	ldr r5, _037F85F0 // =0x01000010
	add r4, r9, #0x10
	ldr r10, _037F85F4 // =0x0000FFFF
_037F8564:
	ldr r0, [r8]
	ldr r0, [r0, #0x308]
	mov r1, r6
	mov r2, r7
	bl OS_ReceiveMessage
	cmp r0, #0
	beq _037F8588
	mov r0, r6
	bl sub_37F8774
_037F8588:
	mov r0, r5
	bl OS_DisableIrqMask
	ldrh r1, [r9, #0x10]
	strh r1, [r9, #0x12]
	ldrh r1, [r9, #0x12]
	mov r1, r1, lsl #1
	ldrh r1, [r9, r1]
	cmp r1, r10
	bne _037F85C0
	ldrh r1, [r4]
	add r1, r1, #1
	strh r1, [r4]
	bl OS_EnableIrqMask
	b _037F8564
_037F85C0:
	bl OS_EnableIrqMask
	ldrh r0, [r9, #0x12]
	bl sub_37F86B8
	strh r0, [r9, #0x14]
	ldrh r0, [r9, #0x14]
	add r0, r9, r0, lsl #3
	ldr r0, [r0, #0xc0]
	mov lr, pc
	bx r0
	arm_func_end sub_37F8538

	arm_func_start sub_37F85E4
sub_37F85E4: // 0x037F85E4
	strh r10, [r9, #0x14]
	b _037F8564
	.align 2, 0
_037F85EC: .word 0x0380FFF4
_037F85F0: .word 0x01000010
_037F85F4: .word 0x0000FFFF
	arm_func_end sub_37F85E4

	arm_func_start sub_37F85F8
sub_37F85F8: // 0x037F85F8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	ldr r0, _037F86AC // =0x0380FFF4
	ldr r5, [r0]
	add r4, r5, #0xbc
	ldr r0, _037F86B0 // =0x01000010
	bl OS_DisableIrqMask
	mov ip, r6, lsl #3
	add r2, r4, r6, lsl #3
	ldrh r1, [r2, #2]
	cmp r1, #0
	bne _037F8670
	mov r1, #1
	strh r1, [r2, #2]
	ldr r3, _037F86B4 // =0x0000FFFF
	strh r3, [r4, ip]
	mov r2, r7, lsl #1
	add r1, r5, r7, lsl #1
	ldrh r1, [r1, #8]
	cmp r1, r3
	streqh r6, [r5, r2]
	addne r1, r5, r1, lsl #3
	strneh r6, [r1, #0xbc]
	add r1, r5, r7, lsl #1
	strh r6, [r1, #8]
	ldrh r1, [r5, #0x10]
	cmp r7, r1
	strlth r7, [r5, #0x10]
_037F8670:
	bl OS_EnableIrqMask
	cmp r7, #3
	beq _037F86A0
	ldrh r0, [r5, #0x12]
	cmp r0, #3
	bne _037F86A0
	ldr r0, _037F86AC // =0x0380FFF4
	ldr r0, [r0]
	ldr r0, [r0, #0x308]
	mov r1, #0
	mov r2, r1
	bl OS_SendMessage
_037F86A0:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037F86AC: .word 0x0380FFF4
_037F86B0: .word 0x01000010
_037F86B4: .word 0x0000FFFF
	arm_func_end sub_37F85F8

	arm_func_start sub_37F86B8
sub_37F86B8: // 0x037F86B8
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r0, _037F8724 // =0x0380FFF4
	ldr r5, [r0]
	ldr r0, _037F8728 // =0x01000010
	bl OS_DisableIrqMask
	mov r6, r4, lsl #1
	ldrh r4, [r5, r6]
	ldr r2, _037F872C // =0x0000FFFF
	cmp r4, r2
	beq _037F8714
	add lr, r5, #0xbc
	mov ip, #0
	mov r3, r4, lsl #3
	add r1, lr, r4, lsl #3
	strh ip, [r1, #2]
	ldrh r1, [lr, r3]
	cmp r1, r2
	streqh r2, [r5, r6]
	addeq r1, r5, r6
	streqh r2, [r1, #8]
	strneh r1, [r5, r6]
	strneh r2, [lr, r3]
_037F8714:
	bl OS_EnableIrqMask
	mov r0, r4
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_037F8724: .word 0x0380FFF4
_037F8728: .word 0x01000010
_037F872C: .word 0x0000FFFF
	arm_func_end sub_37F86B8

	arm_func_start sub_37F8730
sub_37F8730: // 0x037F8730
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _037F8770 // =0x0380FFF4
	ldr r0, [r0]
	ldr r0, [r0, #0x308]
	add r1, sp, #0
	mov r2, #1
	bl OS_ReceiveMessage
	add r0, sp, #0
	bl sub_37F8774
	mov r0, #3
	mov r1, #0xc
	bl sub_37F85F8
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037F8770: .word 0x0380FFF4
	arm_func_end sub_37F8730

	arm_func_start sub_37F8774
sub_37F8774: // 0x037F8774
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, [r0]
	cmp r1, #0
	beq _037F87A4
	ldr r0, _037F87B0 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x200
	bl sub_37F87B4
	mov r0, #2
	mov r1, #0xb
	bl sub_37F85F8
_037F87A4:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037F87B0: .word 0x0380FFF4
	arm_func_end sub_37F8774

	arm_func_start sub_37F87B4
sub_37F87B4: // 0x037F87B4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	ldrh r1, [r5, #8]
	cmp r1, #0
	mvneq r1, #0
	streq r1, [r4]
	streq r4, [r5]
	ldrne r1, [r5, #4]
	strne r1, [r4]
	strne r4, [r1, #4]
	mvn r1, #0
	str r1, [r4, #4]
	ldrh r1, [r5, #0xa]
	strh r1, [r4, #8]
	ldr r1, _037F8828 // =0x0000BF1D
	strh r1, [r4, #0xa]
	str r4, [r5, #4]
	ldrh r1, [r5, #8]
	add r1, r1, #1
	strh r1, [r5, #8]
	bl OS_EnableIrqMask
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037F8828: .word 0x0000BF1D
	arm_func_end sub_37F87B4

	arm_func_start sub_37F882C
sub_37F882C: // 0x037F882C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	ldrh r1, [r4, #0xa]
	ldr r0, _037F890C // =0x0000BF1D
	cmp r1, r0
	movne r0, #1
	bne _037F8900
	ldrh r1, [r4, #8]
	ldrh r0, [r5, #0xa]
	cmp r1, r0
	movne r0, #2
	bne _037F8900
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	ldrh r1, [r5, #8]
	sub r1, r1, #1
	strh r1, [r5, #8]
	ldrh r1, [r5, #8]
	cmp r1, #0
	mvneq r1, #0
	streq r1, [r5]
	streq r1, [r5, #4]
	beq _037F88F0
	ldr r1, [r5]
	cmp r4, r1
	bne _037F88B4
	ldr r1, [r4, #4]
	str r1, [r5]
	mvn r2, #0
	ldr r1, [r5]
	str r2, [r1]
	b _037F88F0
_037F88B4:
	ldr r1, [r5, #4]
	cmp r4, r1
	bne _037F88D8
	ldr r1, [r4]
	str r1, [r5, #4]
	mvn r2, #0
	ldr r1, [r5, #4]
	str r2, [r1, #4]
	b _037F88F0
_037F88D8:
	ldr r2, [r4]
	ldr r1, [r4, #4]
	str r2, [r1]
	ldr r2, [r4, #4]
	ldr r1, [r4]
	str r2, [r1, #4]
_037F88F0:
	mov r1, #0
	strh r1, [r4, #8]
	bl OS_EnableIrqMask
	mov r0, #0
_037F8900:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037F890C: .word 0x0000BF1D
	arm_func_end sub_37F882C

	arm_func_start sub_37F8910
sub_37F8910: // 0x037F8910
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, _037F89B0 // =0x0380FFF4
	ldr r0, [r0]
	add r3, r0, #0x17c
	cmp r1, #0
	moveq r0, #0
	beq _037F89A4
	add r2, r1, #0xc
	ldr r0, [r3]
	cmp r0, #0
	beq _037F8950
	cmp r0, #1
	beq _037F8964
	b _037F8978
_037F8950:
	ldr r0, [r3, #4]
	ldr r1, [r3, #8]
	bl OS_AllocFromHeap
	mov r4, r0
	b _037F8978
_037F8964:
	mov r0, r2
	ldr r1, [r3, #4]
	mov lr, pc
	bx r1
	arm_func_end sub_37F8910

	arm_func_start sub_37F8974
sub_37F8974: // 0x037F8974
	mov r4, r0
_037F8978:
	cmp r4, #0
	moveq r0, #0
	beq _037F89A4
	ldr r0, _037F89B4 // =0x0000BF1D
	strh r0, [r4, #0xa]
	mov r0, #0
	strh r0, [r4, #8]
	mov r0, r5
	mov r1, r4
	bl sub_37F8AB0
	mov r0, r4
_037F89A4:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037F89B0: .word 0x0380FFF4
_037F89B4: .word 0x0000BF1D
	arm_func_end sub_37F8974

	arm_func_start sub_37F89B8
sub_37F89B8: // 0x037F89B8
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r1
	ldr r2, _037F8A34 // =0x0380FFF4
	ldr r2, [r2]
	add r6, r2, #0x17c
	ldrh r3, [r4, #0xa]
	ldr r2, _037F8A38 // =0x0000BF1D
	cmp r3, r2
	movne r0, #1
	bne _037F8A2C
	bl sub_37F882C
	movs r5, r0
	bne _037F8A28
	ldr r0, [r6]
	cmp r0, #0
	beq _037F8A04
	cmp r0, #1
	beq _037F8A18
	b _037F8A28
_037F8A04:
	ldr r0, [r6, #4]
	ldr r1, [r6, #8]
	mov r2, r4
	bl OS_FreeToHeap
	b _037F8A28
_037F8A18:
	mov r0, r4
	ldr r1, [r6, #8]
	mov lr, pc
	bx r1
_037F8A28:
	mov r0, r5
_037F8A2C:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_037F8A34: .word 0x0380FFF4
_037F8A38: .word 0x0000BF1D
	arm_func_end sub_37F89B8

	arm_func_start sub_37F8A3C
sub_37F8A3C: // 0x037F8A3C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r7, r1
	mov r6, r2
	ldrh r1, [r6, #0xa]
	ldr r0, _037F8AAC // =0x0000BF1D
	cmp r1, r0
	movne r0, #1
	bne _037F8AA0
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r4, r0
	mov r0, r5
	mov r1, r6
	bl sub_37F882C
	movs r5, r0
	bne _037F8A94
	mov r0, r7
	mov r1, r6
	bl sub_37F8AB0
	mov r5, r0
_037F8A94:
	mov r0, r4
	bl OS_EnableIrqMask
	mov r0, r5
_037F8AA0:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037F8AAC: .word 0x0000BF1D
	arm_func_end sub_37F8A3C

	arm_func_start sub_37F8AB0
sub_37F8AB0: // 0x037F8AB0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	ldrh r1, [r4, #0xa]
	ldr r0, _037F8B40 // =0x0000BF1D
	cmp r1, r0
	movne r0, #1
	bne _037F8B34
	ldrh r0, [r4, #8]
	cmp r0, #0
	movne r0, #2
	bne _037F8B34
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	ldrh r1, [r5, #8]
	cmp r1, #0
	mvneq r1, #0
	streq r1, [r4]
	streq r4, [r5]
	ldrne r1, [r5, #4]
	strne r1, [r4]
	strne r4, [r1, #4]
	mvn r1, #0
	str r1, [r4, #4]
	ldrh r1, [r5, #0xa]
	strh r1, [r4, #8]
	str r4, [r5, #4]
	ldrh r1, [r5, #8]
	add r1, r1, #1
	strh r1, [r5, #8]
	bl OS_EnableIrqMask
	mov r0, #0
_037F8B34:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037F8B40: .word 0x0000BF1D
	arm_func_end sub_37F8AB0

	arm_func_start sub_37F8B44
sub_37F8B44: // 0x037F8B44
	ldr r0, [r0, #4]
	bx lr
	arm_func_end sub_37F8B44

	arm_func_start sub_37F8B4C
sub_37F8B4C: // 0x037F8B4C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r1, _037F8E40 // =0x0380FFF4
	ldr r3, [r1]
	ldr r0, _037F8E44 // =0x00000424
	add r6, r3, r0
	mov r2, #0
	mov r4, r2
	ldrh r0, [r6, #4]
	cmp r0, #0
	bne _037F8E34
	ldr r0, [r3, #0x200]
	str r0, [r6]
	ldr r0, [r6]
	mvn r3, #0
	cmp r0, r3
	beq _037F8E34
	ldrh r3, [r0, #0xe]
	add r3, r0, r3, lsl #1
	add r5, r3, #0x10
	ldr r1, [r1]
	add lr, r1, #0x300
	ldrh r1, [lr, #0x3e]
	cmp r1, #0
	movne r0, #1
	strneh r0, [r5, #2]
	movne r0, #6
	strneh r0, [r5, #4]
	bne _037F8DEC
	ldrh r3, [r0, #0xc]
	ldrh r1, [r5]
	cmp r3, r1
	movne r0, #0xd
	strneh r0, [r5, #4]
	bne _037F8DEC
	and r1, r3, #0xff00
	cmp r1, #0x100
	bgt _037F8BF8
	cmp r1, #0x100
	bge _037F8C50
	cmp r1, #0
	beq _037F8C18
	b _037F8D4C
_037F8BF8:
	cmp r1, #0x200
	bgt _037F8C0C
	cmp r1, #0x200
	beq _037F8C78
	b _037F8D4C
_037F8C0C:
	cmp r1, #0x300
	beq _037F8D30
	b _037F8D4C
_037F8C18:
	mov r4, #1
	ldr ip, _037F8E48 // =0x027F8224
	and r1, r3, #0xff
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r7, #0xb
	ldrh r1, [r6, #4]
	ands r1, r1, #1
	movne r2, #2
	bne _037F8D54
	ldrh r1, [lr, #0x4c]
	cmp r1, #0x20
	movlo r2, r4
	b _037F8D54
_037F8C50:
	mov r4, #2
	ldr ip, _037F8E4C // =0x027F819C
	and r1, r3, #0xff
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r7, #5
	ldrh r1, [lr, #0x4c]
	cmp r1, #0x40
	movne r2, #1
	b _037F8D54
_037F8C78:
	and r1, r3, #0xff
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	cmp r3, #0x40
	bhs _037F8CA8
	ldrh r1, [lr, #0x4c]
	cmp r1, #0x10
	movlo r2, #1
	mov r4, #4
	ldr ip, _037F8E50 // =0x027F838C
	mov r7, #0x17
	b _037F8D54
_037F8CA8:
	cmp r3, #0x80
	bhs _037F8CD8
	ldrh r1, [lr, #0x4c]
	cmp r1, #0x40
	movne r2, #1
	mov r4, #8
	ldr ip, _037F8E54 // =0x027F81F4
	sub r1, r3, #0x40
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r7, #6
	b _037F8D54
_037F8CD8:
	cmp r3, #0xc0
	bhs _037F8D08
	ldrh r1, [lr, #0x4c]
	cmp r1, #0x10
	movlo r2, #1
	mov r4, #0x10
	ldr ip, _037F8E58 // =0x027F82D4
	sub r1, r3, #0x80
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r7, #0x17
	b _037F8D54
_037F8D08:
	ldrh r1, [lr, #0x4c]
	cmp r1, #0x10
	movlo r2, #1
	mov r4, #0x20
	ldr ip, _037F8E5C // =0x027F81C4
	sub r1, r3, #0xc0
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r7, #6
	b _037F8D54
_037F8D30:
	mov r4, #0x40
	ldr ip, _037F8E60 // =0x027F827C
	and r1, r3, #0xff
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r7, #0xb
	b _037F8D54
_037F8D4C:
	mov r3, #1
	mov r7, #0
_037F8D54:
	cmp r3, r7
	movhi r2, #3
	bhi _037F8D8C
	ldrh lr, [r0, #0xe]
	mov r7, r3, lsl #3
	ldrh r1, [ip, r7]
	cmp lr, r1
	blo _037F8D88
	ldrh lr, [r5, #2]
	add r1, ip, r7
	ldrh r1, [r1, #2]
	cmp lr, r1
	bhs _037F8D8C
_037F8D88:
	mov r2, #4
_037F8D8C:
	cmp r2, #0
	movne r0, #1
	strneh r0, [r5, #2]
	strneh r2, [r5, #4]
	bne _037F8DEC
	ldrh r1, [r6, #4]
	orr r1, r1, r4
	strh r1, [r6, #4]
	mov r1, r5
	add r2, ip, r3, lsl #3
	ldr r2, [r2, #4]
	mov lr, pc
	bx r2
	arm_func_end sub_37F8B4C

	arm_func_start sub_37F8DC0
sub_37F8DC0: // 0x037F8DC0
	strh r0, [r5, #4]
	ldrh r0, [r5, #4]
	cmp r0, #0x80
	beq _037F8E34
	cmp r0, #0x81
	bne _037F8DEC
	ldrh r1, [r6, #4]
	mvn r0, r4
	and r0, r1, r0
	strh r0, [r6, #4]
	b _037F8E10
_037F8DEC:
	ldrh r1, [r6, #4]
	mvn r0, r4
	and r0, r1, r0
	strh r0, [r6, #4]
	ldr r0, _037F8E40 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x200
	ldr r1, [r6]
	bl sub_37F8E64
_037F8E10:
	ldr r0, _037F8E40 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x200
	ldrh r0, [r0, #8]
	cmp r0, #0
	beq _037F8E34
	mov r0, #2
	mov r1, #0xb
	bl sub_37F85F8
_037F8E34:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037F8E40: .word 0x0380FFF4
_037F8E44: .word 0x00000424
_037F8E48: .word 0x027F8224
_037F8E4C: .word 0x027F819C
_037F8E50: .word 0x027F838C
_037F8E54: .word 0x027F81F4
_037F8E58: .word 0x027F82D4
_037F8E5C: .word 0x027F81C4
_037F8E60: .word 0x027F827C
	arm_func_end sub_37F8DC0

	arm_func_start sub_37F8E64
sub_37F8E64: // 0x037F8E64
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	ldr r2, _037F8EF0 // =0x0380FFF4
	ldr r3, [r2]
	add r2, r3, #0x100
	ldrh r2, [r2, #0xfc]
	cmp r2, #0
	beq _037F8EA8
	add r1, r3, #0x1f4
	mov r2, r4
	bl sub_37F8A3C
	mov r0, #2
	mov r1, #0x13
	bl sub_37F85F8
	b _037F8EE4
_037F8EA8:
	ldr r0, [r3, #0x304]
	mov r2, #0
	bl OS_SendMessage
	cmp r0, #0
	beq _037F8ECC
	mov r0, r5
	mov r1, r4
	bl sub_37F882C
	b _037F8EE4
_037F8ECC:
	mov r0, r5
	ldr r1, _037F8EF0 // =0x0380FFF4
	ldr r1, [r1]
	add r1, r1, #0x1f4
	mov r2, r4
	bl sub_37F8A3C
_037F8EE4:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037F8EF0: .word 0x0380FFF4
	arm_func_end sub_37F8E64

	arm_func_start sub_37F8EF4
sub_37F8EF4: // 0x037F8EF4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r0, _037F9308 // =0x0380FFF4
	ldr r0, [r0]
	add r7, r0, #0x344
	add r4, r0, #0x31c
	bl sub_37F93A0
	ldr r2, _037F930C // =0x04808044
	ldrh r1, [r2]
	ldrh r0, [r2]
	add r0, r1, r0, lsl #8
	ldrh r1, [r2]
	bl sub_27E9470
	mov r0, #1
	strh r0, [r7, #0x7c]
	ldrh r0, [r4, #0x1e]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	ldreqh r0, [r7, #0x7c]
	orreq r0, r0, #0x20
	streqh r0, [r7, #0x7c]
	ldrh r0, [r4, #0x18]
	cmp r0, #0
	ldrneh r0, [r7, #0x7c]
	orrne r0, r0, #0x10
	strneh r0, [r7, #0x7c]
	mov r2, #0
	strh r2, [r7, #0x12]
	mov r1, #0x8000
	ldr r0, _037F9310 // =0x04808032
	strh r1, [r0]
	ldr r1, _037F9314 // =0x0000FFFF
	ldr r0, _037F9318 // =0x04808134
	strh r1, [r0]
	ldr r0, _037F931C // =0x0480802A
	strh r2, [r0]
	ldr r0, _037F9320 // =0x04808028
	strh r2, [r0]
	mov r1, #0xf
	ldr r0, _037F9324 // =0x04808038
	strh r1, [r0]
	bl sub_27EBDC4
	bl sub_27F576C
	bl sub_37FB30C
	bl sub_37FB6B8
	mov r1, #0x8000
	ldr r0, _037F9328 // =0x04808030
	strh r1, [r0]
	ldr r1, _037F9314 // =0x0000FFFF
	ldr r0, _037F932C // =0x04808010
	strh r1, [r0]
	ldr r1, _037F9330 // =0x00001FFF
	ldr r0, _037F9334 // =0x048081AE
	strh r1, [r0]
	ldr r0, _037F9308 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #8
	movne r1, #0x400
	ldrne r0, _037F9338 // =0x048081AA
	strneh r1, [r0]
	moveq r1, #0
	ldreq r0, _037F9338 // =0x048081AA
	streqh r1, [r0]
	mov r5, #0
	ldr r0, _037F933C // =0x04808008
	strh r5, [r0]
	ldr r3, _037F9340 // =0x0480800A
	strh r5, [r3]
	ldrh r1, [r7, #0xc]
	cmp r1, #4
	addls pc, pc, r1, lsl #2
	b _037F92CC
_037F9020: // jump table
	b _037F9034 // case 0
	b _037F9078 // case 1
	b _037F919C // case 2
	b _037F9230 // case 3
	b _037F92A8 // case 4
_037F9034:
	mov r2, #0x3f
	ldr r1, _037F9344 // =0x04808012
	strh r2, [r1]
	ldr r2, _037F9314 // =0x0000FFFF
	ldr r1, _037F9348 // =0x048080D0
	strh r2, [r1]
	mov r2, #8
	ldr r1, _037F934C // =0x048080E0
	strh r2, [r1]
	strh r5, [r0]
	strh r5, [r3]
	ldr r0, _037F9350 // =0x048080E8
	strh r5, [r0]
	mov r1, #1
	ldr r0, _037F9354 // =0x04808004
	strh r1, [r0]
	b _037F92CC
_037F9078:
	ldr r2, _037F9358 // =0x0000703F
	ldr r1, _037F9344 // =0x04808012
	strh r2, [r1]
	ldr r2, _037F9330 // =0x00001FFF
	ldr r1, _037F9334 // =0x048081AE
	strh r2, [r1]
	ldr r2, _037F935C // =0x00000301
	ldr r1, _037F9348 // =0x048080D0
	strh r2, [r1]
	mov r2, #0xd
	ldr r1, _037F934C // =0x048080E0
	strh r2, [r1]
	mov r1, #0xe000
	strh r1, [r0]
	mov r1, #1
	ldr r0, _037F9354 // =0x04808004
	strh r1, [r0]
	add r6, sp, #0
	ldr r0, _037F9360 // =0x048080F8
	ldrh r0, [r0]
	strh r0, [r6]
	ldr r0, _037F9364 // =0x048080FA
	ldrh r0, [r0]
	strh r0, [r6, #2]
	ldr r0, _037F9368 // =0x048080FC
	ldrh r0, [r0]
	strh r0, [r6, #4]
	ldr r0, _037F936C // =0x048080FE
	ldrh r0, [r0]
	strh r0, [r6, #6]
	ldrh r0, [r7, #0x6e]
	mov r4, r0, lsl #0xa
	ldr r0, [sp]
	ldr r1, [sp, #4]
	mov r2, r4
	mov r3, r5
	bl _ll_udiv
	str r0, [sp]
	str r1, [sp, #4]
	mov r2, #1
	adds ip, r0, r2
	adc r3, r1, #0
	str ip, [sp]
	str r3, [sp, #4]
	umull r1, r0, ip, r4
	mla r0, ip, r5, r0
	mla r0, r3, r4, r0
	str r1, [sp]
	str r0, [sp, #4]
	ldrh r1, [r6, #6]
	ldr r0, _037F9370 // =0x048080F6
	strh r1, [r0]
	ldrh r1, [r6, #4]
	ldr r0, _037F9374 // =0x048080F4
	strh r1, [r0]
	ldrh r1, [r6, #2]
	ldr r0, _037F9378 // =0x048080F2
	strh r1, [r0]
	ldrh r0, [r6]
	orr r1, r0, #1
	ldr r0, _037F937C // =0x048080F0
	strh r1, [r0]
	ldr r0, _037F9350 // =0x048080E8
	strh r2, [r0]
	ldr r0, _037F9380 // =0x048080EA
	strh r2, [r0]
	mov r0, #0x40
	bl sub_37F9458
	bl sub_27F15C0
	mov r1, #2
	ldr r0, _037F9384 // =0x048080AE
	strh r1, [r0]
	b _037F92CC
_037F919C:
	ldr r0, _037F9388 // =0x0000E0BF
	ldr r1, _037F9344 // =0x04808012
	strh r0, [r1]
	ldr r0, _037F9308 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #0x20
	beq _037F91DC
	ldrh r0, [r1]
	orr r0, r0, #0x40
	strh r0, [r1]
	ldr r1, _037F9338 // =0x048081AA
	ldrh r0, [r1]
	orr r0, r0, #0x68
	strh r0, [r1]
_037F91DC:
	ldrh r0, [r7, #0x64]
	ands r0, r0, #1
	ldrne r1, _037F938C // =0x00000581
	ldrne r0, _037F9348 // =0x048080D0
	strneh r1, [r0]
	ldreq r1, _037F9390 // =0x00000181
	ldreq r0, _037F9348 // =0x048080D0
	streqh r1, [r0]
	mov r1, #0xb
	ldr r0, _037F934C // =0x048080E0
	strh r1, [r0]
	mov r1, #1
	ldr r0, _037F9354 // =0x04808004
	strh r1, [r0]
	ldr r0, _037F9350 // =0x048080E8
	strh r1, [r0]
	ldr r0, _037F9380 // =0x048080EA
	strh r1, [r0]
	mov r0, #0x20
	bl sub_37F9458
	b _037F92CC
_037F9230:
	ldr r1, _037F9314 // =0x0000FFFF
	ldr r0, _037F932C // =0x04808010
	strh r1, [r0]
	ldr r1, _037F9394 // =0x0000C03F
	ldr r0, _037F9344 // =0x04808012
	strh r1, [r0]
	ldrh r0, [r7, #0x64]
	ands r0, r0, #1
	ldrne r1, _037F9398 // =0x00000401
	ldrne r0, _037F9348 // =0x048080D0
	strneh r1, [r0]
	moveq r1, #1
	ldreq r0, _037F9348 // =0x048080D0
	streqh r1, [r0]
	mov r1, #0xb
	ldr r0, _037F934C // =0x048080E0
	strh r1, [r0]
	mov r1, #1
	ldr r0, _037F9354 // =0x04808004
	strh r1, [r0]
	ldr r0, _037F9350 // =0x048080E8
	strh r1, [r0]
	ldr r0, _037F9380 // =0x048080EA
	strh r1, [r0]
	mov r1, #0
	ldr r0, _037F939C // =0x04808048
	strh r1, [r0]
	mov r0, #0x20
	bl sub_37F9458
	b _037F92CC
_037F92A8:
	ldr r0, _037F9344 // =0x04808012
	strh r5, [r0]
	ldr r0, _037F9334 // =0x048081AE
	strh r5, [r0]
	mov r1, #1
	ldr r0, _037F9354 // =0x04808004
	strh r1, [r0]
	mov r0, #0x20
	bl sub_37F9458
_037F92CC:
	mov r1, #0
	ldr r0, _037F939C // =0x04808048
	strh r1, [r0]
	bl sub_27EA3F0
	mov r0, #2
	ldr r1, _037F9384 // =0x048080AE
	strh r0, [r1]
	ldrh r1, [r7, #0xe]
	cmp r1, #1
	bne _037F92F8
	bl sub_27EA5C8
_037F92F8:
	bl sub_37FB82C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037F9308: .word 0x0380FFF4
_037F930C: .word 0x04808044
_037F9310: .word 0x04808032
_037F9314: .word 0x0000FFFF
_037F9318: .word 0x04808134
_037F931C: .word 0x0480802A
_037F9320: .word 0x04808028
_037F9324: .word 0x04808038
_037F9328: .word 0x04808030
_037F932C: .word 0x04808010
_037F9330: .word 0x00001FFF
_037F9334: .word 0x048081AE
_037F9338: .word 0x048081AA
_037F933C: .word 0x04808008
_037F9340: .word 0x0480800A
_037F9344: .word 0x04808012
_037F9348: .word 0x048080D0
_037F934C: .word 0x048080E0
_037F9350: .word 0x048080E8
_037F9354: .word 0x04808004
_037F9358: .word 0x0000703F
_037F935C: .word 0x00000301
_037F9360: .word 0x048080F8
_037F9364: .word 0x048080FA
_037F9368: .word 0x048080FC
_037F936C: .word 0x048080FE
_037F9370: .word 0x048080F6
_037F9374: .word 0x048080F4
_037F9378: .word 0x048080F2
_037F937C: .word 0x048080F0
_037F9380: .word 0x048080EA
_037F9384: .word 0x048080AE
_037F9388: .word 0x0000E0BF
_037F938C: .word 0x00000581
_037F9390: .word 0x00000181
_037F9394: .word 0x0000C03F
_037F9398: .word 0x00000401
_037F939C: .word 0x04808048
	arm_func_end sub_37F8EF4

	arm_func_start sub_37F93A0
sub_37F93A0: // 0x037F93A0
	stmdb sp!, {r4, lr}
	ldr r0, _037F9430 // =0x0380FFF4
	ldr r0, [r0]
	add r4, r0, #0x344
	bl sub_27E97C8
	bl sub_27E961C
	mov r0, #0x20
	bl sub_37F9458
	mov r1, #0
	strh r1, [r4, #0xa4]
	strh r1, [r4, #0x12]
	ldr r0, _037F9434 // =0x04808012
	strh r1, [r0]
	ldr r0, _037F9438 // =0x04808004
	strh r1, [r0]
	ldr r0, _037F943C // =0x048080EA
	strh r1, [r0]
	ldr r0, _037F9440 // =0x048080E8
	strh r1, [r0]
	ldr r0, _037F9444 // =0x04808008
	strh r1, [r0]
	ldr r0, _037F9448 // =0x0480800A
	strh r1, [r0]
	ldrh r0, [r4, #0xc]
	cmp r0, #1
	bne _037F940C
	bl sub_27F1598
_037F940C:
	ldr r1, _037F944C // =0x0000FFFF
	ldr r0, _037F9450 // =0x048080AC
	strh r1, [r0]
	ldr r0, _037F9454 // =0x048080B4
	strh r1, [r0]
	bl sub_27F17D4
	bl sub_27E8E64
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037F9430: .word 0x0380FFF4
_037F9434: .word 0x04808012
_037F9438: .word 0x04808004
_037F943C: .word 0x048080EA
_037F9440: .word 0x048080E8
_037F9444: .word 0x04808008
_037F9448: .word 0x0480800A
_037F944C: .word 0x0000FFFF
_037F9450: .word 0x048080AC
_037F9454: .word 0x048080B4
	arm_func_end sub_37F93A0

	arm_func_start sub_37F9458
sub_37F9458: // 0x037F9458
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, _037F94EC // =0x0380FFF4
	ldr r0, [r0]
	add r4, r0, #0x344
	ldrh r0, [r4, #8]
	cmp r0, r5
	beq _037F94E0
	cmp r0, #0x40
	bne _037F9488
	bl sub_27E961C
_037F9488:
	cmp r5, #0
	beq _037F94A4
	cmp r5, #0x10
	beq _037F94AC
	cmp r5, #0x40
	beq _037F94C0
	b _037F94DC
_037F94A4:
	bl sub_27EA540
	b _037F94DC
_037F94AC:
	mov r0, #0
	bl sub_27EA5B4
	bl sub_37F93A0
	bl sub_27EA4AC
	b _037F94DC
_037F94C0:
	ldrh r0, [r4, #0xc]
	cmp r0, #2
	bne _037F94D0
	bl sub_27EA3C0
_037F94D0:
	mov r0, #0x64
	ldr r1, _037F94F0 // =sub_27E9748
	bl sub_27E97EC
_037F94DC:
	strh r5, [r4, #8]
_037F94E0:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037F94EC: .word 0x0380FFF4
_037F94F0: .word sub_27E9748
	arm_func_end sub_37F9458

	arm_func_start sub_37F94F4
sub_37F94F4: // 0x037F94F4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, #1
	ldr r5, _037F95CC // =0x04808010
	ldr r4, _037F95D0 // =0x04808012
_037F9508:
	ldrh r1, [r5]
	ldrh r0, [r4]
	ands r6, r1, r0
	beq _037F95B0
	ands r0, r6, #0x80
	beq _037F9524
	bl sub_37FA554
_037F9524:
	ands r0, r6, #0x40
	beq _037F9530
	bl sub_37FA68C
_037F9530:
	ands r0, r6, #0x8000
	beq _037F953C
	bl sub_37F95D8
_037F953C:
	ands r0, r6, #0x4000
	beq _037F9548
	bl sub_37F9664
_037F9548:
	ands r0, r6, #0x2000
	beq _037F9554
	bl sub_37F9960
_037F9554:
	ands r0, r6, #0x800
	beq _037F9560
	bl sub_27EBCDC
_037F9560:
	ands r0, r6, #8
	beq _037F956C
	bl sub_37F9A18
_037F956C:
	ands r0, r6, #4
	beq _037F9578
	bl sub_37F9B44
_037F9578:
	ands r0, r6, #1
	beq _037F9584
	bl sub_37F9FB4
_037F9584:
	ands r0, r6, #0x30
	beq _037F9590
	bl sub_37F99DC
_037F9590:
	ands r0, r6, #2
	beq _037F959C
	bl sub_37F9D08
_037F959C:
	ands r0, r6, #0x1000
	beq _037F9508
	mov r0, r7
	bl sub_37FA444
	b _037F9508
_037F95B0:
	ldr r1, _037F95D4 // =0x0380FFF8
	ldr r0, [r1]
	orr r0, r0, #0x1000000
	str r0, [r1]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037F95CC: .word 0x04808010
_037F95D0: .word 0x04808012
_037F95D4: .word 0x0380FFF8
	arm_func_end sub_37F94F4

	arm_func_start sub_37F95D8
sub_37F95D8: // 0x037F95D8
	stmdb sp!, {r4, lr}
	ldr r0, _037F965C // =0x0380FFF4
	ldr r0, [r0]
	add r4, r0, #0x344
	mov r1, #0x8000
	ldr r0, _037F9660 // =0x04808010
	strh r1, [r0]
	ldrh r0, [r4, #8]
	cmp r0, #0x40
	bne _037F964C
	ldrh r0, [r4, #0x7e]
	cmp r0, #0
	beq _037F964C
	ldrh r1, [r4, #0x72]
	ldrh r0, [r4, #0x70]
	cmp r1, r0
	bne _037F964C
	ldrh r0, [r4, #0x80]
	add r0, r0, #1
	strh r0, [r4, #0x80]
	ldrh r1, [r4, #0x80]
	ldrh r0, [r4, #0x7e]
	cmp r1, r0
	bls _037F964C
	mov r0, #0
	strh r0, [r4, #0x80]
	mov r0, #1
	mov r1, #0xd
	bl sub_37F85F8
_037F964C:
	mov r0, #1
	strh r0, [r4, #0x10]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037F965C: .word 0x0380FFF4
_037F9660: .word 0x04808010
	arm_func_end sub_37F95D8

	arm_func_start sub_37F9664
sub_37F9664: // 0x037F9664
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r0, _037F9934 // =0x0380FFF4
	ldr r1, [r0]
	add r10, r1, #0x344
	add r4, r1, #0x31c
	ldr r0, _037F9938 // =0x0000042C
	add r9, r1, r0
	mov r1, #0x4000
	ldr r0, _037F993C // =0x04808010
	strh r1, [r0]
	ldrh r0, [r10, #0xc]
	cmp r0, #1
	beq _037F96B0
	cmp r0, #2
	beq _037F976C
	cmp r0, #3
	beq _037F97B0
	b _037F9928
_037F96B0:
	ldr r0, [r9, #0x80]
	add r1, r0, #0x24
	ldrh r0, [r10, #0x96]
	add r0, r1, r0
	add r6, r0, #8
	ldr r0, _037F9940 // =0x0380FFF0
	ldrh r5, [r0]
	mov r0, r6
	and r1, r5, #0xff
	bl sub_27E94C4
	add r0, r6, #1
	mov r1, r5, lsr #8
	and r1, r1, #0xff
	bl sub_27E94C4
	ldrh r0, [r10, #0xe]
	cmp r0, #1
	bne _037F970C
	ldrh r2, [r4, #0x20]
	ldr r1, _037F9944 // =0x04808134
	ldrh r0, [r1]
	add r0, r2, r0
	add r0, r0, #1
	strh r0, [r1]
_037F970C:
	ldr r0, _037F9934 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x500
	ldrh r1, [r0, #0x2e]
	mvn r2, r1
	ldrh r1, [r0, #0x32]
	orr r1, r2, r1
	strh r1, [r0, #0x30]
	ldr r0, _037F9948 // =0x048080B6
	ldrh r1, [r0]
	ands r0, r1, #0x18
	bne _037F9748
	and r0, r1, #6
	cmp r0, #2
	bne _037F975C
_037F9748:
	ldr r0, [r9, #0x8c]
	bic r0, r0, #2
	str r0, [r9, #0x8c]
	bl sub_37FA900
	b _037F9928
_037F975C:
	ldr r0, [r9, #0x8c]
	orr r0, r0, #2
	str r0, [r9, #0x8c]
	b _037F9928
_037F976C:
	ldrh r0, [r10, #0x12]
	cmp r0, #0
	ldreq r1, _037F994C // =0x0000FFFF
	ldreq r0, _037F9944 // =0x04808134
	streqh r1, [r0]
	beq _037F979C
	ldrh r2, [r4, #0x20]
	ldr r1, _037F9944 // =0x04808134
	ldrh r0, [r1]
	add r0, r2, r0
	add r0, r0, #1
	strh r0, [r1]
_037F979C:
	ldrh r0, [r10, #0x1a]
	cmp r0, #2
	bne _037F97B0
	mov r0, #2
	bl sub_27EA5C8
_037F97B0:
	ldrh r0, [r10, #8]
	cmp r0, #0x40
	movne r1, #1
	bne _037F9800
	mov r1, #0
	ldrh r0, [r10, #0x72]
	cmp r0, #1
	moveq r1, #1
	ldrh r0, [r10, #0x14]
	cmp r0, #0
	beq _037F9800
	ldrh r0, [r10, #0x76]
	cmp r0, #1
	beq _037F97FC
	cmp r0, #0
	bne _037F9800
	ldrh r0, [r10, #0x74]
	cmp r0, #1
	bne _037F9800
_037F97FC:
	mov r1, #1
_037F9800:
	cmp r1, #0
	ldrne r1, _037F9950 // =0x04808038
	ldrneh r0, [r1]
	orrne r0, r0, #1
	strneh r0, [r1]
	ldreq r1, _037F9950 // =0x04808038
	ldreqh r0, [r1]
	biceq r0, r0, #1
	streqh r0, [r1]
	ldr r0, _037F9954 // =0x04808118
	ldrh r0, [r0]
	cmp r0, #0xa
	movhi r1, #0
	ldrhi r0, _037F9958 // =0x04808048
	strhih r1, [r0]
	ldrh r0, [r10, #0x72]
	sub r0, r0, #1
	strh r0, [r10, #0x72]
	ldrh r0, [r10, #0x72]
	cmp r0, #0
	ldreqh r0, [r10, #0x70]
	streqh r0, [r10, #0x72]
	ldrh r1, [r10, #0x76]
	sub r0, r1, #1
	strh r0, [r10, #0x76]
	cmp r1, #0
	ldreqh r0, [r10, #0x74]
	subeq r0, r0, #1
	streqh r0, [r10, #0x76]
	mov r8, #0
	mov r6, #2
	mov r11, r8
	mov r5, #0xe
	mov r4, #0x14
_037F9888:
	mul r0, r8, r4
	add r7, r9, r0
	ldrh r0, [r9, r0]
	cmp r0, #0
	beq _037F9910
	ldr r2, [r7, #0xc]
	ldrh r0, [r2, #8]
	cmp r0, #0
	bne _037F9910
	ldr r1, [r10, #0xa8]
	ldrh r0, [r2, #4]
	sub r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	ldrh r0, [r10, #0x8c]
	cmp r1, r0
	bls _037F98E0
	ldr r2, [r7, #8]
	ldrh r2, [r2, #0xc]
	mov r2, r2, lsl #0x1c
	movs r2, r2, lsr #0x1e
	bne _037F98E8
_037F98E0:
	cmp r1, r0, lsl #3
	bls _037F9910
_037F98E8:
	mov r0, r8
	bl sub_27F1A78
	ldr r0, [r7, #8]
	strh r6, [r0]
	mov r0, r11
	mov r1, r5
	bl sub_37F85F8
	ldrh r0, [r9, #0xae]
	add r0, r0, #1
	strh r0, [r9, #0xae]
_037F9910:
	add r8, r8, #1
	cmp r8, #2
	blo _037F9888
	mov r1, #0xd
	ldr r0, _037F995C // =0x048080AE
	strh r1, [r0]
_037F9928:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_037F9934: .word 0x0380FFF4
_037F9938: .word 0x0000042C
_037F993C: .word 0x04808010
_037F9940: .word 0x0380FFF0
_037F9944: .word 0x04808134
_037F9948: .word 0x048080B6
_037F994C: .word 0x0000FFFF
_037F9950: .word 0x04808038
_037F9954: .word 0x04808118
_037F9958: .word 0x04808048
_037F995C: .word 0x048080AE
	arm_func_end sub_37F9664

	arm_func_start sub_37F9960
sub_37F9960: // 0x037F9960
	ldr r0, _037F99CC // =0x0380FFF4
	ldr r0, [r0]
	add r2, r0, #0x344
	mov r1, #0x2000
	ldr r0, _037F99D0 // =0x04808010
	strh r1, [r0]
	mov r1, #0xd
	ldr r0, _037F99D4 // =0x048080AC
	strh r1, [r0]
	ldrh r0, [r2, #0x1a]
	cmp r0, #1
	moveq r0, #2
	streqh r0, [r2, #0x1a]
	bxeq lr
	cmp r0, #2
	moveq r0, #0
	streqh r0, [r2, #0x1a]
	bxeq lr
	ldrh r0, [r2, #0xc]
	cmp r0, #2
	bxne lr
	ldrh r0, [r2, #8]
	cmp r0, #0x40
	movne r1, #0
	ldrne r0, _037F99D8 // =0x04808048
	strneh r1, [r0]
	bx lr
	.align 2, 0
_037F99CC: .word 0x0380FFF4
_037F99D0: .word 0x04808010
_037F99D4: .word 0x048080AC
_037F99D8: .word 0x04808048
	arm_func_end sub_37F9960

	arm_func_start sub_37F99DC
sub_37F99DC: // 0x037F99DC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_27E9EFC
	ldr r1, _037F9A0C // =0x0000FFFF
	ldr r0, _037F9A10 // =0x048081AC
	strh r1, [r0]
	mov r1, #0x30
	ldr r0, _037F9A14 // =0x04808010
	strh r1, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037F9A0C: .word 0x0000FFFF
_037F9A10: .word 0x048081AC
_037F9A14: .word 0x04808010
	arm_func_end sub_37F99DC

	arm_func_start sub_37F9A18
sub_37F9A18: // 0x037F9A18
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r1, #8
	ldr r0, _037F9B2C // =0x04808010
	strh r1, [r0]
	ldr r0, _037F9B30 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x3a]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _037F9A64
	ldr r0, _037F9B34 // =0x0480819C
	ldrh r0, [r0]
	ands r0, r0, #1
	ldreq r1, _037F9B38 // =0x04808290
	ldreqh r0, [r1]
	eoreq r0, r0, #1
	streqh r0, [r1]
_037F9A64:
	ldr r0, _037F9B30 // =0x0380FFF4
	ldr r1, [r0]
	add r0, r1, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #8
	beq _037F9B20
	add r3, r1, #0x344
	ldr r0, _037F9B3C // =0x0000042C
	add r1, r1, r0
	mov r2, #0
	mov r5, r2
	ldr r4, _037F9B40 // =0x04808032
	mov lr, #0x8000
	add ip, r3, #0xba
	mov r3, #0x14
_037F9AA0:
	mul r0, r2, r3
	add r6, r1, r0
	ldrh r0, [r1, r0]
	cmp r0, #0
	beq _037F9B14
	ldr r0, [r6, #8]
	ldrh r6, [r0, #0xc]
	ands r6, r6, #0x4000
	beq _037F9B14
	ldrh r6, [r0, #4]
	ands r6, r6, #0xff
	beq _037F9B14
	add r7, r0, #0xc
	ldrh r6, [r0, #0xa]
	add r6, r7, r6
	sub r6, r6, #7
	bic r7, r6, #1
	ldrh r6, [r7]
	cmp r6, #0
	bne _037F9B14
	ldrh r6, [r7, #2]
	cmp r6, #0
	bne _037F9B14
	strh r5, [r0, #4]
	strh r5, [r4]
	strh lr, [r4]
	ldrh r0, [ip]
	add r0, r0, #1
	strh r0, [ip]
_037F9B14:
	add r2, r2, #1
	cmp r2, #3
	blo _037F9AA0
_037F9B20:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037F9B2C: .word 0x04808010
_037F9B30: .word 0x0380FFF4
_037F9B34: .word 0x0480819C
_037F9B38: .word 0x04808290
_037F9B3C: .word 0x0000042C
_037F9B40: .word 0x04808032
	arm_func_end sub_37F9A18

	arm_func_start sub_37F9B44
sub_37F9B44: // 0x037F9B44
	stmdb sp!, {r4, lr}
	ldr r4, _037F9CCC // =0x0380FFF4
	ldr r1, [r4]
	ldr r0, _037F9CD0 // =0x000004DC
	add r2, r1, r0
	ldr r0, _037F9CD4 // =0x0000042C
	add r1, r1, r0
	mov r3, #4
	ldr r0, _037F9CD8 // =0x04808010
	strh r3, [r0]
	ldr r0, _037F9CDC // =0x048081A8
	ldrh r0, [r0]
	ldr r3, [r4]
	add r3, r3, #0x600
	ldrh r3, [r3, #0x90]
	ands r3, r3, #8
	beq _037F9C44
	ands r3, r0, #0x400
	beq _037F9C44
	ldr r3, _037F9CE0 // =0x048080B0
	ldrh r4, [r3]
	ands r3, r4, #1
	beq _037F9BAC
	ldrh r3, [r1]
	cmp r3, #0
	bne _037F9C00
_037F9BAC:
	ands r3, r4, #4
	beq _037F9BC0
	ldrh r3, [r1, #0x14]
	cmp r3, #0
	bne _037F9C00
_037F9BC0:
	ands r3, r4, #8
	beq _037F9BD4
	ldrh r1, [r1, #0x28]
	cmp r1, #0
	bne _037F9C00
_037F9BD4:
	ldr r1, _037F9CE4 // =0x0480819C
	ldrh r1, [r1]
	ands r1, r1, #1
	bne _037F9C00
	mov r4, #0
	ldr r3, _037F9CE8 // =0x04808032
	strh r4, [r3]
	mov r1, #0x8000
	strh r1, [r3]
	strh r4, [r2, #2]
	b _037F9C44
_037F9C00:
	ldrh r3, [r2, #2]
	add r1, r3, #1
	strh r1, [r2, #2]
	cmp r3, #0xc
	bls _037F9C44
	mov r1, #0
	strh r1, [r2, #2]
	ldr r2, _037F9CE8 // =0x04808032
	strh r1, [r2]
	mov r1, #0x8000
	strh r1, [r2]
	ldr r1, _037F9CCC // =0x0380FFF4
	ldr r1, [r1]
	add r1, r1, #0x300
	ldrh r2, [r1, #0xfe]
	add r2, r2, #1
	strh r2, [r1, #0xfe]
_037F9C44:
	ldr r1, _037F9CCC // =0x0380FFF4
	ldr r1, [r1]
	add r1, r1, #0x600
	ldrh r1, [r1, #0x90]
	ands r1, r1, #1
	beq _037F9CC4
	ands r0, r0, #0x60
	beq _037F9CC4
	ldr r0, _037F9CEC // =0x04808054
	ldrh r4, [r0]
	ldr r0, _037F9CF0 // =0x04808052
	ldrh r0, [r0]
	sub r0, r0, #0x4000
	mov r1, #2
	bl _s32_div_f
	cmp r4, r0
	bge _037F9CA4
	ldr r0, _037F9CF4 // =0x04808050
	ldrh r0, [r0]
	sub r0, r0, #0x4000
	mov r1, #2
	bl _s32_div_f
	cmp r4, r0
	bge _037F9CC0
_037F9CA4:
	ldr r0, _037F9CF8 // =0x0480805A
	ldrh r1, [r0]
	ldr r0, _037F9CFC // =0x04808056
	strh r1, [r0]
	ldr r1, _037F9D00 // =0x00008001
	ldr r0, _037F9D04 // =0x04808030
	strh r1, [r0]
_037F9CC0:
	bl sub_27E9184
_037F9CC4:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037F9CCC: .word 0x0380FFF4
_037F9CD0: .word 0x000004DC
_037F9CD4: .word 0x0000042C
_037F9CD8: .word 0x04808010
_037F9CDC: .word 0x048081A8
_037F9CE0: .word 0x048080B0
_037F9CE4: .word 0x0480819C
_037F9CE8: .word 0x04808032
_037F9CEC: .word 0x04808054
_037F9CF0: .word 0x04808052
_037F9CF4: .word 0x04808050
_037F9CF8: .word 0x0480805A
_037F9CFC: .word 0x04808056
_037F9D00: .word 0x00008001
_037F9D04: .word 0x04808030
	arm_func_end sub_37F9B44

	arm_func_start sub_37F9D08
sub_37F9D08: // 0x037F9D08
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r2, _037F9F74 // =0x0380FFF4
	ldr r1, [r2]
	ldr r0, _037F9F78 // =0x0000042C
	add r5, r1, r0
	mov r0, #2
	ldr r1, _037F9F7C // =0x04808010
	strh r0, [r1]
	ldr r1, [r2]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x4c]
	cmp r1, #0x12
	bne _037F9D48
	bl sub_27EF500
	b _037F9F68
_037F9D48:
	ldr r1, _037F9F80 // =0x048080B8
	ldrh r1, [r1]
	and r4, r1, #0xf00
	cmp r4, #0x300
	beq _037F9D70
	cmp r4, #0x800
	beq _037F9DA4
	cmp r4, #0xb00
	beq _037F9DE4
	b _037F9EE8
_037F9D70:
	ldr r0, [r5, #0x8c]
	ands r0, r0, #2
	beq _037F9D80
	bl sub_37FA900
_037F9D80:
	ldr r0, _037F9F74 // =0x0380FFF4
	ldr r1, [r0]
	ldr r0, [r1, #0x558]
	add r0, r0, #1
	str r0, [r1, #0x558]
	mov r0, #0
	mov r1, #8
	bl sub_37F85F8
	b _037F9EE8
_037F9DA4:
	ldrh r2, [r5, #0x9e]
	ldr r1, [r5, #0x44]
	ldrh r1, [r1, #4]
	and r1, r1, #0xff
	mov r1, r1, lsl #0x10
	cmp r2, r1, lsr #16
	ldrls r1, _037F9F84 // =0x048080AC
	strlsh r0, [r1]
	ldrlsh r0, [r5, #0xa8]
	addls r0, r0, #1
	strlsh r0, [r5, #0xa8]
	ldr r1, [r5, #0x90]
	ldrh r0, [r1, #0x18]
	add r0, r0, #1
	strh r0, [r1, #0x18]
	b _037F9EE8
_037F9DE4:
	ldr r2, _037F9F88 // =0x0000FFFF
	ldr r0, _037F9F8C // =0x04805F70
	strh r2, [r0]
	ldr r0, _037F9F90 // =0x04805F72
	strh r2, [r0]
	ldr r0, _037F9F94 // =0x0480824C
	strh r2, [r0]
	ldr r0, _037F9F98 // =0x0480824E
	strh r2, [r0]
	ldrh r0, [r5, #0x3c]
	cmp r0, #0
	beq _037F9E40
	ldr r1, [r5, #0x44]
	ldrh r0, [r1, #0x22]
	cmp r0, r2
	bne _037F9E40
	ldrh r0, [r1, #4]
	cmp r0, #0
	movne r0, #0
	strneh r0, [r1, #4]
	ldrneh r1, [r5, #0x98]
	ldrne r0, [r5, #0x44]
	strneh r1, [r0, #2]
_037F9E40:
	ldrh r2, [r5, #0x98]
	ldr r0, [r5, #0x44]
	ldrh r1, [r0, #2]
	ldr r0, [r5, #0x90]
	add r0, r0, #0x1a
	cmp r1, #1
	bls _037F9E94
	ldr r3, _037F9F74 // =0x0380FFF4
	ldr r3, [r3]
	add r3, r3, #0x300
	ldrh r3, [r3, #0x3a]
	mov r3, r3, lsl #0x1b
	movs r3, r3, lsr #0x1f
	beq _037F9E94
	ldr r3, _037F9F9C // =0x0480819C
	ldrh r3, [r3]
	ands r3, r3, #1
	ldreq ip, _037F9FA0 // =0x04808290
	ldreqh r3, [ip]
	eoreq r3, r3, #1
	streqh r3, [ip]
_037F9E94:
	ldr r3, _037F9F74 // =0x0380FFF4
	ldr r3, [r3]
	add r3, r3, #0x600
	ldrh r3, [r3, #0x90]
	ands r3, r3, #0x40
	beq _037F9EE8
	b _037F9EE0
_037F9EB0:
	mov r1, r1, lsl #0xf
	mov r1, r1, lsr #0x10
	ands r3, r1, #1
	ldrneh r3, [r0, #6]
	addne r3, r3, #1
	strneh r3, [r0, #6]
	mov r2, r2, lsl #0xf
	mov r2, r2, lsr #0x10
	ands r3, r2, #1
	ldrne r3, [r5, #0x90]
	ldrneh r3, [r3, #0x16]
	addne r0, r0, r3
_037F9EE0:
	cmp r1, #1
	bhi _037F9EB0
_037F9EE8:
	cmp r4, #0x800
	beq _037F9F5C
	ldr r0, _037F9FA4 // =0x048080B0
	ldrh r0, [r0]
	ands r0, r0, #2
	bne _037F9F5C
	ldrh r0, [r5, #0x3c]
	cmp r0, #0
	beq _037F9F50
	mov r0, #2
	ldr r1, _037F9FA8 // =0x048080B4
	strh r0, [r1]
	mov r2, #0
	ldr r1, _037F9FAC // =0x04808048
	strh r2, [r1]
	ldr r1, _037F9F7C // =0x04808010
	ldrh r1, [r1]
	ands r1, r1, #0x1000
	ldrneh r0, [r5, #0xac]
	addne r0, r0, #1
	strneh r0, [r5, #0xac]
	bne _037F9F44
	bl sub_37FA444
_037F9F44:
	ldrh r0, [r5, #0xaa]
	add r0, r0, #1
	strh r0, [r5, #0xaa]
_037F9F50:
	mov r1, #2
	ldr r0, _037F9FB0 // =0x048080AE
	strh r1, [r0]
_037F9F5C:
	mov r0, #0
	mov r1, #0xe
	bl sub_37F85F8
_037F9F68:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037F9F74: .word 0x0380FFF4
_037F9F78: .word 0x0000042C
_037F9F7C: .word 0x04808010
_037F9F80: .word 0x048080B8
_037F9F84: .word 0x048080AC
_037F9F88: .word 0x0000FFFF
_037F9F8C: .word 0x04805F70
_037F9F90: .word 0x04805F72
_037F9F94: .word 0x0480824C
_037F9F98: .word 0x0480824E
_037F9F9C: .word 0x0480819C
_037F9FA0: .word 0x04808290
_037F9FA4: .word 0x048080B0
_037F9FA8: .word 0x048080B4
_037F9FAC: .word 0x04808048
_037F9FB0: .word 0x048080AE
	arm_func_end sub_37F9D08

	arm_func_start sub_37F9FB4
sub_37F9FB4: // 0x037F9FB4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	ldr r0, _037FA3F0 // =0x0380FFF4
	ldr r1, [r0]
	add r10, r1, #0x344
	ldr r0, _037FA3F4 // =0x000004DC
	add r9, r1, r0
	add r0, r1, #0x600
	ldrh r2, [r0, #0x90]
	mov r1, #1
	ldr r0, _037FA3F8 // =0x04808010
	strh r1, [r0]
	ldrh r0, [r10, #0xc]
	cmp r0, #0
	ldreq r0, _037FA3FC // =0x04808054
	ldreqh r1, [r0]
	ldreq r0, _037FA400 // =0x0480805A
	streqh r1, [r0]
	and r5, r2, #1
	mov r0, #0x3e8
	str r0, [sp, #0x14]
	mov r0, #0
	str r0, [sp, #0x18]
_037FA010:
	ldrh r7, [r9, #4]
	ldr r0, _037FA3FC // =0x04808054
	ldrh r6, [r0]
	cmp r7, r6
	beq _037FA38C
	ldr r0, _037FA404 // =0x048080F8
	ldrh r4, [r0]
	ldr r0, _037FA408 // =0x048080FA
	ldrh r3, [r0]
	ldr r0, _037FA404 // =0x048080F8
	ldrh r2, [r0]
	ldr r0, _037FA408 // =0x048080FA
	ldrh r1, [r0]
	cmp r4, r2
	movhi r0, r2, lsr #4
	orrhi r11, r0, r1, lsl #12
	movls r0, r4, lsr #4
	orrls r11, r0, r3, lsl #12
	ldr r0, _037FA40C // =0x000008C6
	cmp r7, r0
	blo _037FA074
	ldr r0, _037FA410 // =0x000008EF
	cmp r7, r0
	bhi _037FA074
	bl sub_27E9EFC
_037FA074:
	mov r0, r7, lsl #1
	str r0, [sp, #8]
	ldr r0, _037FA414 // =0x04804000
	add r8, r0, r7, lsl #1
	add r0, r8, #2
	bl sub_37FAA40
	mov r4, r0
	add r0, r4, #2
	bl sub_37FAA40
	str r0, [sp, #0xc]
	add r0, r0, #4
	bl sub_37FAA40
	str r0, [sp, #0x10]
	add r0, r8, #0xe
	bl sub_37FAA40
	str r0, [sp, #4]
	ldr r0, [sp, #8]
	add r0, r0, #0x4800000
	add r0, r0, #0x4000
	ldrh r2, [r0]
	ldrh r1, [r4]
	mov r1, r1, lsl #1
	and r1, r1, #0x400
	orr r1, r2, r1
	strh r1, [r0]
	ldr r0, [sp, #0xc]
	strh r11, [r0]
	ldr r0, [sp, #0x10]
	ldrh r2, [r0]
	add r0, r2, r7, lsl #1
	add r0, r0, #0xf
	mov r0, r0, lsr #2
	mov r7, r0, lsl #1
	cmp r7, #0xfb0
	ldrhsh r0, [r10, #0x9a]
	subhs r7, r7, r0, lsr #1
	ldr r0, _037FA418 // =0x0000092C
	cmp r2, r0
	bls _037FA12C
	ldr r0, _037FA41C // =0x0000FFFF
	strh r0, [r8]
	mov r7, r6
	ldrh r0, [r10, #0xb4]
	add r0, r0, #1
	strh r0, [r10, #0xb4]
	b _037FA1C4
_037FA12C:
	cmp r5, #0
	beq _037FA1C4
	cmp r7, r6
	beq _037FA1C4
	mov r1, r7, lsl #1
	ldr r0, _037FA414 // =0x04804000
	add r0, r0, r7, lsl #1
	add r1, r1, #0x4800000
	add r1, r1, #0x4000
	ldrh r1, [r1]
	ldr r3, _037FA420 // =0x04805F5A
	cmp r0, r3
	ldrloh r0, [r0, #6]
	andlo r0, r0, #0xff
	movlo r0, r0, lsl #0x10
	movlo r3, r0, lsr #0x10
	ldrhsh r3, [r10, #0x9a]
	subhs r0, r0, r3
	ldrhsh r3, [r0, #6]
	ands r0, r1, #0x7c00
	bne _037FA19C
	cmp r3, #0xa
	beq _037FA190
	cmp r3, #0x14
	bne _037FA19C
_037FA190:
	ldr r0, _037FA424 // =0x00000FFF
	cmp r2, r0
	bls _037FA1C4
_037FA19C:
	ldrh r0, [r10, #0xb4]
	add r0, r0, #1
	strh r0, [r10, #0xb4]
	ldr r0, _037FA41C // =0x0000FFFF
	strh r0, [r8]
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	strh r0, [r9, #4]
	strh r0, [r4]
	b _037FA38C
_037FA1C4:
	ldrh r0, [r8]
	and r0, r0, #0xf
	cmp r0, #0xc
	bne _037FA320
	add r0, r8, #0xc
	bl sub_37FAA40
	ldrh r11, [r0]
	add r0, r8, #0x22
	bl sub_37FAA40
	ldrh r6, [r0]
	ldrh r0, [r9]
	cmp r0, r6
	bne _037FA220
	ands r0, r11, #0x800
	beq _037FA220
	ldr r0, _037FA3F0 // =0x0380FFF4
	ldr r1, [r0]
	ldr r0, [r1, #0x57c]
	add r0, r0, #1
	str r0, [r1, #0x57c]
	ldr r0, _037FA41C // =0x0000FFFF
	strh r0, [r8]
	b _037FA2F8
_037FA220:
	ldr r0, _037FA3F0 // =0x0380FFF4
	ldr r0, [r0]
	add r1, r0, #0x300
	ldrh r2, [r1, #0x3a]
	mov r2, r2, lsl #0x18
	movs r2, r2, lsr #0x1f
	bne _037FA2F8
	ldrh r1, [r1, #0x4c]
	cmp r1, #0x40
	bne _037FA2F8
	ldr r1, _037FA428 // =0x04808028
	ldrh r1, [r1]
	cmp r1, #0
	beq _037FA2D0
	ldr r1, _037FA42C // =0x04808098
	ldrh r1, [r1]
	ands r1, r1, #0x8000
	beq _037FA2D0
	add r0, r0, #0x660
	bl OS_CancelAlarm
	ldr r0, [sp, #4]
	ldrh r2, [r0]
	mov r1, #0
	ldr r0, _037FA430 // =0x000082EA
	umull r8, r3, r2, r0
	mla r3, r2, r1, r3
	mla r3, r1, r0, r3
	mov r1, r3, lsr #6
	mov r0, r8, lsr #6
	orr r0, r0, r3, lsl #26
	ldr r2, [sp, #0x14]
	ldr r3, [sp, #0x18]
	bl _ll_udiv
	mov r3, r0
	mov r2, r1
	ldr r0, [sp, #0x18]
	str r0, [sp]
	ldr r0, _037FA3F0 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x660
	mov r1, r3
	ldr r3, _037FA434 // =sub_27EA1D8
	bl OS_SetAlarm
	b _037FA2F8
_037FA2D0:
	ldr r6, _037FA41C // =0x0000FFFF
	mov r1, r6
	ldr r0, _037FA438 // =0x04805F7E
	strh r1, [r0]
	ldr r0, _037FA43C // =0x0480824C
	strh r1, [r0]
	ldr r0, _037FA440 // =0x0480824E
	strh r1, [r0]
	mov r0, r6
	strh r0, [r8]
_037FA2F8:
	strh r6, [r9]
	bl sub_37FAA68
	cmp r0, #0
	bne _037FA378
	ldr r0, _037FA3F0 // =0x0380FFF4
	ldr r1, [r0]
	ldr r0, [r1, #0x5a8]
	add r0, r0, #1
	str r0, [r1, #0x5a8]
	b _037FA378
_037FA320:
	cmp r0, #0xd
	bne _037FA378
	ldr r0, _037FA3F0 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x300
	ldrh r1, [r0, #0x3a]
	mov r1, r1, lsl #0x18
	movs r1, r1, lsr #0x1f
	bne _037FA378
	ldrh r0, [r0, #0x4c]
	cmp r0, #0x40
	bne _037FA378
	ldr r0, _037FA428 // =0x04808028
	ldrh r0, [r0]
	cmp r0, #0
	beq _037FA370
	ldr r0, _037FA42C // =0x04808098
	ldrh r0, [r0]
	ands r0, r0, #0x8000
	bne _037FA378
_037FA370:
	ldr r0, _037FA41C // =0x0000FFFF
	strh r0, [r8]
_037FA378:
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	strh r0, [r9, #4]
	strh r0, [r4]
	b _037FA010
_037FA38C:
	cmp r5, #0
	beq _037FA3C0
	ldr r0, _037FA3FC // =0x04808054
	ldrh r4, [r0]
	bl sub_37FAA68
	cmp r0, #0
	beq _037FA3C0
	ldr r0, _037FA3FC // =0x04808054
	ldrh r0, [r0]
	cmp r4, r0
	bne _037FA3C0
	mov r0, #0x20
	bl sub_27E9140
_037FA3C0:
	ldr r0, _037FA400 // =0x0480805A
	ldrh r1, [r0]
	ldr r0, _037FA3FC // =0x04808054
	ldrh r0, [r0]
	cmp r1, r0
	beq _037FA3E4
	mov r0, #0
	mov r1, #0xf
	bl sub_37F85F8
_037FA3E4:
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_037FA3F0: .word 0x0380FFF4
_037FA3F4: .word 0x000004DC
_037FA3F8: .word 0x04808010
_037FA3FC: .word 0x04808054
_037FA400: .word 0x0480805A
_037FA404: .word 0x048080F8
_037FA408: .word 0x048080FA
_037FA40C: .word 0x000008C6
_037FA410: .word 0x000008EF
_037FA414: .word 0x04804000
_037FA418: .word 0x0000092C
_037FA41C: .word 0x0000FFFF
_037FA420: .word 0x04805F5A
_037FA424: .word 0x00000FFF
_037FA428: .word 0x04808028
_037FA42C: .word 0x04808098
_037FA430: .word 0x000082EA
_037FA434: .word sub_27EA1D8
_037FA438: .word 0x04805F7E
_037FA43C: .word 0x0480824C
_037FA440: .word 0x0480824E
	arm_func_end sub_37F9FB4

	arm_func_start sub_37FA444
sub_37FA444: // 0x037FA444
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr ip, _037FA53C // =0x0380FFF4
	ldr r2, [ip]
	ldr r1, _037FA540 // =0x0000042C
	add r1, r2, r1
	mov r3, #0x1000
	ldr r2, _037FA544 // =0x04808010
	strh r3, [r2]
	ldrh r2, [r1, #0x3c]
	cmp r2, #0
	beq _037FA530
	ldr r2, [ip]
	add r2, r2, #0x600
	ldrh r2, [r2, #0x90]
	ands r2, r2, #0x10
	beq _037FA524
	cmp r0, #0
	beq _037FA524
	ldr r0, _037FA548 // =0x048080B6
	ldrh r2, [r0]
	ldr r0, _037FA54C // =0x04808214
	ldrh r0, [r0]
	cmp r0, #3
	beq _037FA4B0
	cmp r0, #5
	bne _037FA524
_037FA4B0:
	cmp r2, #0
	bne _037FA524
	ldr r2, [r1, #0x44]
	ldrh r1, [r2, #2]
	mov r3, #0
	b _037FA4D8
_037FA4C8:
	and r0, r1, #1
	add r3, r3, r0
	mov r0, r1, lsl #0xf
	mov r1, r0, lsr #0x10
_037FA4D8:
	cmp r1, #0
	bne _037FA4C8
	ldrh r1, [r2, #0xa]
	ldrh r0, [r2, #0x24]
	add r0, r0, #0xa
	mul r0, r3, r0
	add r0, r0, #0xc0
	add r0, r0, r1, lsl #2
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r1, _037FA550 // =sub_37FA9D4
	bl sub_27E9640
	ldr r0, _037FA53C // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x400
	ldrh r1, [r0]
	add r1, r1, #1
	strh r1, [r0]
	b _037FA530
_037FA524:
	mov r0, #0
	mov r1, #0x10
	bl sub_37F85F8
_037FA530:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FA53C: .word 0x0380FFF4
_037FA540: .word 0x0000042C
_037FA544: .word 0x04808010
_037FA548: .word 0x048080B6
_037FA54C: .word 0x04808214
_037FA550: .word sub_37FA9D4
	arm_func_end sub_37FA444

	arm_func_start sub_37FA554
sub_37FA554: // 0x037FA554
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, _037FA664 // =0x0380FFF4
	ldr r1, [r3]
	ldr r0, _037FA668 // =0x0000042C
	add r0, r1, r0
	mov r2, #0x80
	ldr r1, _037FA66C // =0x04808010
	strh r2, [r1]
	ldr r1, [r3]
	add r1, r1, #0x600
	ldrh r1, [r1, #0x90]
	ands r1, r1, #0x20
	beq _037FA5F8
	ldr r1, _037FA670 // =0x04808214
	ldrh r1, [r1]
	and r1, r1, #0xff
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	ldr r1, _037FA674 // =0x04808268
	ldrh r3, [r1]
	cmp r2, #3
	blo _037FA5F8
	cmp r2, #5
	bhi _037FA5F8
	ldr r2, [r0, #0x58]
	ldr r1, _037FA678 // =0x00000FFF
	and r2, r1, r2, lsr #1
	cmp r3, r2
	blo _037FA5F8
	ldr r0, [r0, #0x30]
	and r0, r1, r0, lsr #1
	cmp r3, r0
	bhi _037FA5F8
	ldr r1, _037FA67C // =0x04808244
	ldrh r0, [r1]
	orr r0, r0, #0x80
	strh r0, [r1]
	ldrh r0, [r1]
	bic r0, r0, #0x80
	strh r0, [r1]
_037FA5F8:
	ldr r0, _037FA680 // =0x04808000
	ldrh r0, [r0]
	cmp r0, #0x1440
	beq _037FA658
	ldr r0, _037FA684 // =0x0480819C
	ldrh r0, [r0]
	and r0, r0, #0x42
	cmp r0, #0x42
	bne _037FA658
	ldr r1, _037FA688 // =0x048082B8
	ldrh r2, [r1]
	cmp r2, #0
	beq _037FA658
	mov r3, #0
	b _037FA64C
_037FA634:
	cmp r3, #0x3e8
	add r3, r3, #1
	bls _037FA64C
	mov r0, #0x40
	bl sub_27E9140
	b _037FA658
_037FA64C:
	ldrh r0, [r1]
	cmp r2, r0
	beq _037FA634
_037FA658:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FA664: .word 0x0380FFF4
_037FA668: .word 0x0000042C
_037FA66C: .word 0x04808010
_037FA670: .word 0x04808214
_037FA674: .word 0x04808268
_037FA678: .word 0x00000FFF
_037FA67C: .word 0x04808244
_037FA680: .word 0x04808000
_037FA684: .word 0x0480819C
_037FA688: .word 0x048082B8
	arm_func_end sub_37FA554

	arm_func_start sub_37FA68C
sub_37FA68C: // 0x037FA68C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r2, _037FA8BC // =0x0380FFF4
	ldr r1, [r2]
	add r5, r1, #0x344
	ldr r0, _037FA8C0 // =0x0000042C
	add r4, r1, r0
	mov r1, #0x40
	ldr r0, _037FA8C4 // =0x04808010
	strh r1, [r0]
	ldr r0, [r2]
	add r0, r0, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #0x20
	beq _037FA8B4
	ldrh r1, [r4, #0xa4]
	ldr r0, _037FA8C8 // =0x0000FFFF
	cmp r1, r0
	bne _037FA8B4
	ldr r0, _037FA8CC // =0x0480819C
	ldrh r0, [r0]
	and r0, r0, #3
	cmp r0, #3
	bne _037FA8B4
	ldr r0, _037FA8D0 // =0x04808268
	ldrh r2, [r0]
	ldr r0, _037FA8D4 // =0x04808050
	ldrh r1, [r0]
	ldr r0, _037FA8D8 // =0x00000FFF
	and r0, r0, r1, lsr #1
	cmp r2, r0
	blt _037FA8B4
	ldr r0, _037FA8DC // =0x04808054
	ldrh r6, [r0]
	ldr r0, _037FA8E0 // =0x04804000
	add r0, r0, r6, lsl #1
	add r0, r0, #8
	bl sub_37FAA40
	add r0, r0, #4
	bl sub_37FAA40
	ldrh r2, [r0]
	ldr r1, _037FA8E4 // =0x0000E7FF
	and r1, r2, r1
	cmp r1, #0x228
	bne _037FA8B4
	add r0, r0, #2
	bl sub_37FAA40
	ldr r2, _037FA8E8 // =0x048080F8
	ldrh r1, [r2]
	sub r7, r1, #0x10000
	ldr r1, _037FA8D0 // =0x04808268
_037FA754:
	ldrh r3, [r1]
	sub r3, r3, r6
	mov r3, r3, lsl #0x10
	mov r8, r3, lsr #0x10
	ands r3, r8, #0x8000
	ldrneh r3, [r5, #0x9a]
	addne r3, r8, r3, lsr #1
	movne r3, r3, lsl #0x10
	movne r8, r3, lsr #0x10
	cmp r8, #0xe
	bhi _037FA79C
	ldrh r3, [r2]
	sub r3, r3, r7
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #0x40
	bls _037FA754
	b _037FA8B4
_037FA79C:
	add r0, r0, #8
	mov r8, #0
	b _037FA7CC
_037FA7A8:
	bl sub_37FAA40
	mov r1, r0
	add r0, r1, #2
	ldrh r2, [r1]
	add r1, r5, r8, lsl #1
	ldrh r1, [r1, #0x64]
	cmp r2, r1
	bne _037FA8B4
	add r8, r8, #1
_037FA7CC:
	cmp r8, #3
	blo _037FA7A8
	add r0, r0, #0xa
	bl sub_37FAA40
	ldr r3, _037FA8E8 // =0x048080F8
	ldr r1, _037FA8D0 // =0x04808268
_037FA7E4:
	ldrh r2, [r1]
	sub r2, r2, r6
	mov r2, r2, lsl #0x10
	mov r8, r2, lsr #0x10
	ands r2, r8, #0x8000
	ldrneh r2, [r5, #0x9a]
	addne r2, r8, r2, lsr #1
	movne r2, r2, lsl #0x10
	movne r8, r2, lsr #0x10
	cmp r8, #0x14
	bhi _037FA82C
	ldrh r2, [r3]
	sub r2, r2, r7
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	cmp r2, #0x70
	bls _037FA7E4
	b _037FA8B4
_037FA82C:
	ldrh r2, [r0]
	mov r1, #1
	ldr r0, _037FA8EC // =0x04808028
	ldrh r0, [r0]
	mov r0, r1, lsl r0
	ands r0, r2, r0
	bne _037FA8B4
	ldr r0, _037FA8F0 // =0x04808098
	ldrh r0, [r0]
	strh r0, [r4, #0xa4]
	mov r1, #0x40
	ldr r0, _037FA8F4 // =0x048080B4
	strh r1, [r0]
	ldrh r0, [r5, #0xbe]
	add r0, r0, #1
	strh r0, [r5, #0xbe]
	ldr r1, _037FA8CC // =0x0480819C
_037FA870:
	ldrh r0, [r1]
	and r0, r0, #3
	cmp r0, #3
	beq _037FA870
	ldr r1, _037FA8F8 // =0x04808244
	ldrh r0, [r1]
	orr r0, r0, #0x40
	strh r0, [r1]
	ldrh r0, [r1]
	bic r0, r0, #0x40
	strh r0, [r1]
	mov r0, #8
	ldr r1, _037FA8FC // =0x04808228
	strh r0, [r1]
	mov r0, #0
	strh r0, [r1]
	bl sub_27EBC70
_037FA8B4:
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_037FA8BC: .word 0x0380FFF4
_037FA8C0: .word 0x0000042C
_037FA8C4: .word 0x04808010
_037FA8C8: .word 0x0000FFFF
_037FA8CC: .word 0x0480819C
_037FA8D0: .word 0x04808268
_037FA8D4: .word 0x04808050
_037FA8D8: .word 0x00000FFF
_037FA8DC: .word 0x04808054
_037FA8E0: .word 0x04804000
_037FA8E4: .word 0x0000E7FF
_037FA8E8: .word 0x048080F8
_037FA8EC: .word 0x04808028
_037FA8F0: .word 0x04808098
_037FA8F4: .word 0x048080B4
_037FA8F8: .word 0x04808244
_037FA8FC: .word 0x04808228
	arm_func_end sub_37FA68C

	arm_func_start sub_37FA900
sub_37FA900: // 0x037FA900
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _037FA9CC // =0x0380FFF4
	ldr r1, [r0]
	ldr r0, _037FA9D0 // =0x0000042C
	add r5, r1, r0
	mov r4, #0
	mov r0, #2
	bl sub_27F1A78
	mov r0, #1
	bl sub_27F1A78
	mov r0, r4
	bl sub_27F1A78
	ldrh r0, [r5, #0x28]
	cmp r0, #0
	beq _037FA958
	ldr r0, [r5, #0x30]
	ldrh r0, [r0]
	cmp r0, #0
	movne r4, #1
	moveq r0, r4
	streqh r0, [r5, #0x28]
_037FA958:
	ldrh r0, [r5, #0x14]
	cmp r0, #0
	beq _037FA97C
	ldr r0, [r5, #0x1c]
	ldrh r0, [r0]
	cmp r0, #0
	movne r4, #1
	moveq r0, #0
	streqh r0, [r5, #0x14]
_037FA97C:
	ldrh r0, [r5]
	cmp r0, #0
	beq _037FA9A0
	ldr r0, [r5, #8]
	ldrh r0, [r0]
	cmp r0, #0
	movne r4, #1
	moveq r0, #0
	streqh r0, [r5]
_037FA9A0:
	cmp r4, #0
	beq _037FA9B4
	mov r0, #0
	mov r1, #0xe
	bl sub_37F85F8
_037FA9B4:
	mov r0, #0
	mov r1, #0x14
	bl sub_37F85F8
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FA9CC: .word 0x0380FFF4
_037FA9D0: .word 0x0000042C
	arm_func_end sub_37FA900

	arm_func_start sub_37FA9D4
sub_37FA9D4: // 0x037FA9D4
	stmdb sp!, {r4, lr}
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r4, r0
	ldr r2, _037FAA38 // =0x04808210
	ldrh r3, [r2]
	mov r1, #0x1000
	ldr r0, _037FAA3C // =0x04808244
	strh r1, [r0]
	mov r1, #0x64
	b _037FAA10
_037FAA00:
	ldrh r0, [r2]
	cmp r3, r0
	bne _037FAA18
	sub r1, r1, #1
_037FAA10:
	cmp r1, #0
	bne _037FAA00
_037FAA18:
	mov r0, #0
	ldr r1, _037FAA3C // =0x04808244
	strh r0, [r1]
	bl sub_37FA444
	mov r0, r4
	bl OS_EnableIrqMask
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FAA38: .word 0x04808210
_037FAA3C: .word 0x04808244
	arm_func_end sub_37FA9D4

	arm_func_start sub_37FAA40
sub_37FAA40: // 0x037FAA40
	ldr r1, _037FAA60 // =0x04805F60
	cmp r0, r1
	ldrhs r1, _037FAA64 // =0x0380FFF4
	ldrhs r1, [r1]
	addhs r1, r1, #0x300
	ldrhsh r1, [r1, #0xde]
	subhs r0, r0, r1
	bx lr
	.align 2, 0
_037FAA60: .word 0x04805F60
_037FAA64: .word 0x0380FFF4
	arm_func_end sub_37FAA40

	arm_func_start sub_37FAA68
sub_37FAA68: // 0x037FAA68
	stmdb sp!, {r4, lr}
	ldr r0, _037FAAAC // =0x0380FFF4
	ldr r1, [r0]
	ldr r0, _037FAAB0 // =0x0000042C
	add r4, r1, r0
	add r0, r4, #0x50
	bl sub_27EBC08
	cmp r0, #0
	movne r0, #1
	bne _037FAAA4
	add r0, r4, #0x64
	bl sub_27EBC08
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
_037FAAA4:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FAAAC: .word 0x0380FFF4
_037FAAB0: .word 0x0000042C
	arm_func_end sub_37FAA68

	arm_func_start sub_37FAAB4
sub_37FAAB4: // 0x037FAAB4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _037FAB04 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0xe8]
	cmp r0, #0
	beq _037FAAD8
	bl sub_27F1120
_037FAAD8:
	ldr r0, _037FAB04 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x3a]
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	beq _037FAAF8
	bl sub_27ECC48
_037FAAF8:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FAB04: .word 0x0380FFF4
	arm_func_end sub_37FAAB4

	arm_func_start sub_37FAB08
sub_37FAB08: // 0x037FAB08
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r0, _037FAD00 // =0x0380FFF4
	ldr r1, [r0]
	add r10, r1, #0x344
	ldr r0, _037FAD04 // =0x0000042C
	add r9, r1, r0
	mov r8, #2
	mov r7, #0
	mov r6, #0x8000
	mov r11, #3
	str r8, [sp]
	mov r5, r8
	mov r4, #1
_037FAB40:
	mov r0, #0x14
	mla r2, r8, r0, r9
	mov r3, r8, lsl #2
	ldr r0, _037FAD08 // =0x048080A0
	add r1, r0, r8, lsl #2
	add r0, r3, #0x4800000
	add r0, r0, #0x8000
	ldrh r0, [r0, #0xa0]
	ands r0, r0, #0x8000
	bne _037FACEC
	ldrh r0, [r2]
	cmp r0, #0
	beq _037FACEC
	ldr r3, [r2, #0xc]
	cmp r3, #0
	beq _037FACCC
	ldr r0, [r2, #8]
	ldrh r0, [r0]
	strh r0, [r3, #8]
	ldr r0, [r2, #8]
	ldrh r3, [r0, #0xc]
	ldr r0, [r2, #0xc]
	strh r3, [r0, #0x14]
	ldr r3, [r2, #8]
	ldrh r0, [r3, #0xc]
	ands r0, r0, #0x4000
	beq _037FAC98
	ldr r0, _037FAD00 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #8
	beq _037FAC7C
	add ip, r3, #0xc
	ldrh r0, [r3, #0xa]
	add r0, ip, r0
	sub r0, r0, #7
	bic ip, r0, #1
	ldrh r0, [ip]
	cmp r0, #0
	bne _037FAC7C
	ldrh r0, [ip, #2]
	cmp r0, #0
	bne _037FAC7C
	ldr r3, [r10, #0xa8]
	ldr r0, [r2, #0xc]
	ldrh r0, [r0, #4]
	sub r0, r3, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r3, _037FAD0C // =0x04808032
	strh r7, [r3]
	strh r6, [r3]
	ldrh r3, [r10, #0xba]
	add r3, r3, #1
	strh r3, [r10, #0xba]
	ldrh r3, [r10, #0x8c]
	cmp r0, r3
	bls _037FAC64
	ldr r0, [r2, #0xc]
	strh r5, [r0, #8]
	ldrh r0, [r2, #4]
	add r0, r0, #1
	strh r0, [r2, #4]
	ldrh r0, [r9, #0xae]
	add r0, r0, #1
	strh r0, [r9, #0xae]
	ldr r0, [r2, #0xc]
	mov r1, r4
	ldr r2, [r2, #0x10]
	mov lr, pc
	bx r2
	arm_func_end sub_37FAB08

	arm_func_start sub_37FAC60
sub_37FAC60: // 0x037FAC60
	b _037FACEC
_037FAC64:
	ldr r0, [r2, #0xc]
	strh r7, [r0, #0xc]
	ldrh r0, [r1]
	orr r0, r0, #0x8000
	strh r0, [r1]
	b _037FACEC
_037FAC7C:
	ldr r1, [r2, #0xc]
	ldrh r0, [r1, #0xc]
	ldrh r3, [r3, #4]
	and r3, r3, #0xff
	add r0, r0, r3
	strh r0, [r1, #0xc]
	b _037FACA8
_037FAC98:
	ldrh r0, [r3, #4]
	and r1, r0, #0xff
	ldr r0, [r2, #0xc]
	strh r1, [r0, #0xc]
_037FACA8:
	ldrh r0, [r2, #4]
	add r0, r0, #1
	strh r0, [r2, #4]
	ldr r0, [r2, #0xc]
	ldr r1, [sp]
	ldr r2, [r2, #0x10]
	mov lr, pc
	bx r2
	arm_func_end sub_37FAC60

	arm_func_start sub_37FACC8
sub_37FACC8: // 0x037FACC8
	b _037FACEC
_037FACCC:
	ldrh r0, [r2, #4]
	add r0, r0, #1
	strh r0, [r2, #4]
	ldr r0, [r2, #8]
	mov r1, r11
	ldr r2, [r2, #0x10]
	mov lr, pc
	bx r2
_037FACEC:
	subs r8, r8, #1
	bpl _037FAB40
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_037FAD00: .word 0x0380FFF4
_037FAD04: .word 0x0000042C
_037FAD08: .word 0x048080A0
_037FAD0C: .word 0x04808032
	arm_func_end sub_37FACC8

	arm_func_start sub_37FAD10
sub_37FAD10: // 0x037FAD10
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	ldr r10, _037FB0C0 // =0x0380FFF4
	ldr r1, [r10]
	ldr r0, _037FB0C4 // =0x000004DC
	add r7, r1, r0
	add r6, r1, #0x17c
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #0xc]
	mov r8, #1
	str r0, [sp, #0x28]
	mov r0, #7
	str r0, [sp, #0x24]
	ldr r0, [sp]
	str r0, [sp, #0x20]
	str r0, [sp, #0x18]
	mov r11, #2
	mov r0, #6
	str r0, [sp, #0x1c]
	ldr r0, [sp]
	str r0, [sp, #0x10]
	mov r0, #9
	str r0, [sp, #0x14]
	ldr r0, [sp]
	str r0, [sp, #0x2c]
	mov r0, #8
	str r0, [sp, #8]
	mov r0, #0x10
	str r0, [sp, #4]
_037FAD88:
	ldr r0, _037FB0C8 // =0x0480805A
	ldrh r5, [r0]
	ldrh r0, [r7, #4]
	cmp r5, r0
	beq _037FB0B4
	ldr r0, _037FB0CC // =0x000008C6
	cmp r5, r0
	blo _037FADAC
	bl sub_27E9EFC
_037FADAC:
	mov r4, r5, lsl #1
	ldr r0, _037FB0D0 // =0x04804000
	add r5, r0, r5, lsl #1
	add r0, r5, #2
	bl sub_37FAA40
	ldrh r9, [r0]
	add r0, r4, #0x4800000
	add r0, r0, #0x4000
	ldrh r1, [r0]
	ldr r0, _037FB0D4 // =0x0000FFFF
	cmp r1, r0
	ldreq r0, _037FB0C8 // =0x0480805A
	streqh r9, [r0]
	beq _037FB0A4
	add r0, r5, #8
	bl sub_37FAA40
	ldrh r1, [r0]
	mov r0, r5
	bl sub_37FB298
	movs r4, r0
	ldr r0, _037FB0C8 // =0x0480805A
	strh r9, [r0]
	bne _037FAE30
	ldrh r0, [r5]
	and r0, r0, #0xf
	cmp r0, #0xc
	bne _037FAE24
	ldr r0, [sp, #4]
	bl sub_27E9140
	b _037FB0A4
_037FAE24:
	ldr r0, [sp, #8]
	bl sub_27E9140
	b _037FB0A4
_037FAE30:
	ldr r0, [r10]
	add r0, r0, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #8
	beq _037FAE54
	ldrh r0, [r4, #0x14]
	ands r0, r0, #0x4000
	ldrne r0, [sp, #0xc]
	strneh r0, [r7, #2]
_037FAE54:
	ldrh r1, [r4, #8]
	mov r9, r8
	ands r0, r1, #0x200
	beq _037FAEAC
	ldrh r0, [r4, #0x14]
	mov r0, r0, lsl #0x15
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _037FAE88
	ldrh r0, [r4, #0x2a]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1c
	beq _037FB04C
_037FAE88:
	ldr r9, [sp, #0x10]
	add r0, r6, #0xc
	add r1, r6, #0x6c
	sub r2, r4, #0x10
	bl sub_37F8A3C
	mov r0, r11
	ldr r1, [sp, #0x14]
	bl sub_37F85F8
	b _037FB04C
_037FAEAC:
	and r0, r1, #0xf
	cmp r0, #0xf
	addls pc, pc, r0, lsl #2
	b _037FB04C
_037FAEBC: // jump table
	b _037FAF48 // case 0
	b _037FAF30 // case 1
	b _037FB04C // case 2
	b _037FB04C // case 3
	b _037FB04C // case 4
	b _037FAF78 // case 5
	b _037FB04C // case 6
	b _037FB04C // case 7
	b _037FAEFC // case 8
	b _037FB04C // case 9
	b _037FB04C // case 10
	b _037FB04C // case 11
	b _037FAFD0 // case 12
	b _037FB01C // case 13
	b _037FAFB0 // case 14
	b _037FAFB0 // case 15
_037FAEFC:
	ldrh r0, [r4, #0x14]
	and r0, r0, #0xf
	cmp r0, #8
	bne _037FB04C
	ldr r9, [sp, #0x18]
	add r0, r6, #0xc
	add r1, r6, #0x48
	sub r2, r4, #0x10
	bl sub_37F8A3C
	mov r0, r11
	ldr r1, [sp, #0x1c]
	bl sub_37F85F8
	b _037FB04C
_037FAF30:
	ldrh r0, [r4, #0x14]
	cmp r0, #0x80
	bne _037FB04C
	mov r0, r4
	bl sub_27F4910
	b _037FB04C
_037FAF48:
	ldrh r0, [r4, #0x14]
	ands r0, r0, #0xf
	bne _037FB04C
	ldr r9, [sp, #0x20]
	add r0, r6, #0xc
	add r1, r6, #0x60
	sub r2, r4, #0x10
	bl sub_37F8A3C
	mov r0, r8
	ldr r1, [sp, #0x24]
	bl sub_37F85F8
	b _037FB04C
_037FAF78:
	ldrh r1, [r4, #0x14]
	ldr r0, _037FB0D8 // =0x0000E7FF
	and r0, r1, r0
	cmp r0, #0xa4
	bne _037FB04C
	ldr r9, [sp, #0x28]
	add r0, r6, #0xc
	add r1, r6, #0x60
	sub r2, r4, #0x10
	bl sub_37F8A3C
	mov r0, r8
	ldr r1, [sp, #0x24]
	bl sub_37F85F8
	b _037FB04C
_037FAFB0:
	ldrh r1, [r4, #0x14]
	ldr r0, _037FB0DC // =0x0000E7BF
	and r0, r1, r0
	cmp r0, #0x118
	bne _037FB04C
	mov r0, r4
	bl sub_27F50B4
	b _037FB04C
_037FAFD0:
	ldrh r1, [r4, #0x14]
	ldr r0, _037FB0D8 // =0x0000E7FF
	and r0, r1, r0
	cmp r0, #0x228
	bne _037FB04C
	ldr r0, [r10]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x54]
	cmp r0, #0
	ldreq r0, _037FB0E0 // =0x0480803C
	streqh r8, [r0]
	ldr r1, [r10]
	ldr r0, [r1, #0x5ac]
	add r0, r0, #1
	str r0, [r1, #0x5ac]
	mov r0, r4
	bl sub_27F5278
	mov r9, r0
	b _037FB04C
_037FB01C:
	ldrh r1, [r4, #0x14]
	ldr r0, _037FB0D8 // =0x0000E7FF
	and r0, r1, r0
	cmp r0, #0x218
	bne _037FB04C
	ldr r1, [r10]
	ldr r0, [r1, #0x5b0]
	add r0, r0, #1
	str r0, [r1, #0x5b0]
	mov r0, r4
	bl sub_27F4FD0
	mov r9, r0
_037FB04C:
	cmp r9, #0
	beq _037FB060
	add r0, r6, #0xc
	sub r1, r4, #0x10
	bl sub_37F89B8
_037FB060:
	ldr r0, [r10]
	add r0, r0, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #1
	beq _037FB0A4
	ldr r1, [sp, #0x2c]
_037FB078:
	ldr r0, _037FB0E4 // =0x04805F60
	cmp r5, r0
	ldrhs r0, [r10]
	addhs r0, r0, #0x300
	ldrhsh r0, [r0, #0xde]
	subhs r5, r5, r0
	ldr r0, _037FB0D4 // =0x0000FFFF
	strh r0, [r5], #2
	add r1, r1, #1
	cmp r1, #7
	blo _037FB078
_037FB0A4:
	ldr r0, [sp]
	add r0, r0, #1
	str r0, [sp]
	b _037FAD88
_037FB0B4:
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_037FB0C0: .word 0x0380FFF4
_037FB0C4: .word 0x000004DC
_037FB0C8: .word 0x0480805A
_037FB0CC: .word 0x000008C6
_037FB0D0: .word 0x04804000
_037FB0D4: .word 0x0000FFFF
_037FB0D8: .word 0x0000E7FF
_037FB0DC: .word 0x0000E7BF
_037FB0E0: .word 0x0480803C
_037FB0E4: .word 0x04805F60
	arm_func_end sub_37FAD10

	arm_func_start sub_37FB0E8
sub_37FB0E8: // 0x037FB0E8
	stmdb sp!, {r4, lr}
	ldr r0, _037FB1CC // =0x0380FFF4
	ldr r1, [r0]
	ldr r0, _037FB1D0 // =0x0000042C
	add r4, r1, r0
	ldrh r0, [r4, #0x3c]
	cmp r0, #0
	beq _037FB1C4
	ldr r0, [r4, #0x90]
	ldrh r1, [r0, #0x10]
	ldr r0, [r4, #0x44]
	ldrh r0, [r0, #2]
	cmp r1, r0
	beq _037FB124
	bl sub_37FAD10
_037FB124:
	ldr r0, [r4, #0x44]
	ldrh r0, [r0, #4]
	ands r2, r0, #0xff
	ldreq r0, _037FB1CC // =0x0380FFF4
	ldreq r1, [r0]
	ldreq r0, [r1, #0x5a0]
	addeq r0, r0, #1
	streq r0, [r1, #0x5a0]
	beq _037FB15C
	ldr r0, _037FB1CC // =0x0380FFF4
	ldr r1, [r0]
	ldr r0, [r1, #0x5a0]
	add r0, r0, r2
	str r0, [r1, #0x5a0]
_037FB15C:
	ldrh r0, [r4, #0x40]
	add r0, r0, #1
	strh r0, [r4, #0x40]
	ldr r2, [r4, #0x90]
	ldrh r1, [r2, #0x10]
	ldr r0, [r4, #0x44]
	ldrh r0, [r0, #2]
	eor r0, r1, r0
	strh r0, [r2, #0x12]
	ldr r0, [r4, #0x90]
	ldrh r0, [r0, #0x10]
	strh r0, [r4, #0xa0]
	mov r0, #0
	strh r0, [r4, #0x3c]
	ldr r0, _037FB1CC // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0xea]
	cmp r0, #0
	beq _037FB1B0
	bl sub_27EA3F0
_037FB1B0:
	ldr r0, _037FB1CC // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x188
	ldr r1, [r4, #0x90]
	bl sub_37F8E64
_037FB1C4:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FB1CC: .word 0x0380FFF4
_037FB1D0: .word 0x0000042C
	arm_func_end sub_37FB0E8

	arm_func_start sub_37FB1D4
sub_37FB1D4: // 0x037FB1D4
	stmdb sp!, {r4, lr}
	ldr r0, _037FB28C // =0x0380FFF4
	ldr r1, [r0]
	add r4, r1, #0x17c
	ldr r0, _037FB290 // =0x04808088
	ldrh r0, [r0]
	cmp r0, #0
	bne _037FB218
	ldrh r0, [r4, #0x38]
	cmp r0, #0
	beq _037FB218
	mov r1, #8
	ldr r0, _037FB294 // =0x048080AE
	strh r1, [r0]
	mov r0, #2
	bl sub_27F2728
	b _037FB284
_037FB218:
	add r0, r1, #0x500
	ldrh r1, [r0, #0x2e]
	ldrh r0, [r0, #0x32]
	mvn r0, r0
	ands r0, r1, r0
	bne _037FB250
	mov r1, #8
	ldr r0, _037FB294 // =0x048080AE
	strh r1, [r0]
	ldrh r0, [r4, #0x38]
	cmp r0, #0
	beq _037FB250
	mov r0, #2
	bl sub_27F2728
_037FB250:
	mov r1, #5
	ldr r0, _037FB294 // =0x048080AE
	strh r1, [r0]
	ldrh r0, [r4, #0x2c]
	cmp r0, #0
	beq _037FB270
	mov r0, #1
	bl sub_27F2728
_037FB270:
	ldrh r0, [r4, #0x20]
	cmp r0, #0
	beq _037FB284
	mov r0, #0
	bl sub_27F2728
_037FB284:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FB28C: .word 0x0380FFF4
_037FB290: .word 0x04808088
_037FB294: .word 0x048080AE
	arm_func_end sub_37FB1D4

	arm_func_start sub_37FB298
sub_37FB298: // 0x037FB298
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _037FB308 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x188
	add r1, r5, #0x22
	bl sub_37F8910
	cmp r0, #0
	moveq r0, #0
	beq _037FB300
	add r4, r0, #0x10
	add r0, r4, #8
	mov r1, r6
	add r2, r5, #0xc
	bl sub_27E9598
	sub r0, r5, #0x18
	strh r0, [r4, #6]
	ldrh r0, [r4, #0xe]
	and r1, r0, #0xff
	ldrh r0, [r4, #0x12]
	and r0, r0, #0xff
	mov r0, r0, lsl #0x10
	orr r0, r1, r0, lsr #8
	strh r0, [r4, #0xe]
	mov r0, r4
_037FB300:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_037FB308: .word 0x0380FFF4
	arm_func_end sub_37FB298

	arm_func_start sub_37FB30C
sub_37FB30C: // 0x037FB30C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r0, _037FB600 // =0x0380FFF4
	ldr r7, [r0]
	ldr r0, _037FB604 // =0x0000042C
	add r6, r7, r0
	add r5, r7, #0x344
	add r4, r7, #0x31c
	mov r0, #0
	mov r1, r6
	mov r2, #0xb0
	bl MIi_CpuClear32
	mov r1, #0
	add r0, r7, #0x400
	strh r1, [r0, #0x2c]
	str r1, [r6, #0xc]
	strh r1, [r6, #0x14]
	str r1, [r6, #0x20]
	strh r1, [r6, #0x28]
	str r1, [r6, #0x34]
	ldr r0, _037FB608 // =0x0000FFFF
	strh r0, [r6, #0xa2]
	strh r0, [r6, #0xa4]
	ldrh r0, [r5, #0xc]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _037FB5E0
_037FB378: // jump table
	b _037FB388 // case 0
	b _037FB408 // case 1
	b _037FB4B4 // case 2
	b _037FB564 // case 3
_037FB388:
	ldr r0, _037FB60C // =0x04804170
	str r0, [r6, #8]
	ldr r0, _037FB610 // =0x04804028
	str r0, [r6, #0x1c]
	ldr r0, _037FB614 // =0x04804000
	str r0, [r6, #0x30]
	ldr r0, _037FB618 // =sub_27F2424
	str r0, [r6, #0x10]
	ldr r0, _037FB61C // =sub_27F1F08
	str r0, [r6, #0x24]
	ldr r0, _037FB620 // =sub_27F1E94
	str r0, [r6, #0x38]
	ldr r2, _037FB624 // =0x0000B6B8
	ldr r0, _037FB628 // =0x04804024
	strh r2, [r0]
	ldr r1, _037FB62C // =0x00001D46
	ldr r0, _037FB630 // =0x04804026
	strh r1, [r0]
	ldr r0, _037FB634 // =0x0480416C
	strh r2, [r0]
	ldr r0, _037FB638 // =0x0480416E
	strh r1, [r0]
	ldr r0, _037FB63C // =0x04804790
	strh r2, [r0]
	ldr r0, _037FB640 // =0x04804792
	strh r1, [r0]
	mov r0, #8
	strh r0, [r5, #0x8a]
	mov r1, #1
	ldr r0, _037FB644 // =0x048080AE
	strh r1, [r0]
	b _037FB5E0
_037FB408:
	ldr r0, _037FB648 // =0x04804AA0
	str r0, [r6, #8]
	ldr r0, _037FB64C // =0x04804958
	str r0, [r6, #0x1c]
	ldr r0, _037FB650 // =0x04804334
	str r0, [r6, #0x30]
	ldr r0, _037FB618 // =sub_27F2424
	str r0, [r6, #0x10]
	ldr r0, _037FB61C // =sub_27F1F08
	str r0, [r6, #0x24]
	ldr r0, _037FB654 // =sub_27F1D74
	str r0, [r6, #0x38]
	ldr r2, _037FB658 // =0x04804238
	str r2, [r6, #0x80]
	ldr r0, _037FB614 // =0x04804000
	str r0, [r6, #0x44]
	ldr r1, _037FB624 // =0x0000B6B8
	ldr r0, _037FB65C // =0x04804234
	strh r1, [r0]
	ldr r0, _037FB62C // =0x00001D46
	ldr r3, _037FB660 // =0x04804236
	strh r0, [r3]
	ldr r3, _037FB664 // =0x04804330
	strh r1, [r3]
	ldr r3, _037FB668 // =0x04804332
	strh r0, [r3]
	ldr r3, _037FB66C // =0x04804954
	strh r1, [r3]
	ldr r3, _037FB670 // =0x04804956
	strh r0, [r3]
	ldr r3, _037FB674 // =0x04804A9C
	strh r1, [r3]
	ldr r3, _037FB678 // =0x04804A9E
	strh r0, [r3]
	ldr r3, _037FB67C // =0x048050C0
	strh r1, [r3]
	ldr r1, _037FB680 // =0x048050C2
	strh r0, [r1]
	mov r0, #0x208
	strh r0, [r5, #0x8a]
	str r2, [r6, #0x80]
	bl sub_27F122C
	b _037FB5E0
_037FB4B4:
	ldr r0, _037FB684 // =0x048045D8
	str r0, [r6, #8]
	ldr r0, _037FB688 // =0x04804490
	str r0, [r6, #0x1c]
	ldr r0, _037FB68C // =0x04804468
	str r0, [r6, #0x30]
	ldr r0, _037FB618 // =sub_27F2424
	str r0, [r6, #0x10]
	ldr r0, _037FB61C // =sub_27F1F08
	str r0, [r6, #0x24]
	ldr r0, _037FB620 // =sub_27F1E94
	str r0, [r6, #0x38]
	ldr r0, _037FB614 // =0x04804000
	str r0, [r6, #0x58]
	ldr r0, _037FB65C // =0x04804234
	str r0, [r6, #0x6c]
	ldr r2, _037FB624 // =0x0000B6B8
	ldr r0, _037FB690 // =0x04804230
	strh r2, [r0]
	ldr r1, _037FB62C // =0x00001D46
	ldr r0, _037FB694 // =0x04804232
	strh r1, [r0]
	ldr r0, _037FB698 // =0x04804464
	strh r2, [r0]
	ldr r0, _037FB69C // =0x04804466
	strh r1, [r0]
	ldr r0, _037FB6A0 // =0x0480448C
	strh r2, [r0]
	ldr r0, _037FB6A4 // =0x0480448E
	strh r1, [r0]
	ldr r0, _037FB6A8 // =0x048045D4
	strh r2, [r0]
	ldr r0, _037FB6AC // =0x048045D6
	strh r1, [r0]
	ldr r0, _037FB6B0 // =0x04804BF8
	strh r2, [r0]
	ldr r0, _037FB6B4 // =0x04804BFA
	strh r1, [r0]
	mov r0, #0x108
	strh r0, [r5, #0x8a]
	mov r1, #0xd
	ldr r0, _037FB644 // =0x048080AE
	strh r1, [r0]
	b _037FB5E0
_037FB564:
	ldr r0, _037FB60C // =0x04804170
	str r0, [r6, #8]
	ldr r0, _037FB610 // =0x04804028
	str r0, [r6, #0x1c]
	ldr r0, _037FB614 // =0x04804000
	str r0, [r6, #0x30]
	ldr r0, _037FB618 // =sub_27F2424
	str r0, [r6, #0x10]
	ldr r0, _037FB61C // =sub_27F1F08
	str r0, [r6, #0x24]
	ldr r0, _037FB620 // =sub_27F1E94
	str r0, [r6, #0x38]
	ldr r2, _037FB624 // =0x0000B6B8
	ldr r0, _037FB628 // =0x04804024
	strh r2, [r0]
	ldr r1, _037FB62C // =0x00001D46
	ldr r0, _037FB630 // =0x04804026
	strh r1, [r0]
	ldr r0, _037FB634 // =0x0480416C
	strh r2, [r0]
	ldr r0, _037FB638 // =0x0480416E
	strh r1, [r0]
	ldr r0, _037FB63C // =0x04804790
	strh r2, [r0]
	ldr r0, _037FB640 // =0x04804792
	strh r1, [r0]
	mov r0, #0x108
	strh r0, [r5, #0x8a]
	mov r1, #0xd
	ldr r0, _037FB644 // =0x048080AE
	strh r1, [r0]
_037FB5E0:
	ldrh r0, [r4, #0x18]
	cmp r0, #0
	ldrneh r0, [r5, #0x8a]
	orrne r0, r0, #0x4000
	strneh r0, [r5, #0x8a]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037FB600: .word 0x0380FFF4
_037FB604: .word 0x0000042C
_037FB608: .word 0x0000FFFF
_037FB60C: .word 0x04804170
_037FB610: .word 0x04804028
_037FB614: .word 0x04804000
_037FB618: .word sub_27F2424
_037FB61C: .word sub_27F1F08
_037FB620: .word sub_27F1E94
_037FB624: .word 0x0000B6B8
_037FB628: .word 0x04804024
_037FB62C: .word 0x00001D46
_037FB630: .word 0x04804026
_037FB634: .word 0x0480416C
_037FB638: .word 0x0480416E
_037FB63C: .word 0x04804790
_037FB640: .word 0x04804792
_037FB644: .word 0x048080AE
_037FB648: .word 0x04804AA0
_037FB64C: .word 0x04804958
_037FB650: .word 0x04804334
_037FB654: .word sub_27F1D74
_037FB658: .word 0x04804238
_037FB65C: .word 0x04804234
_037FB660: .word 0x04804236
_037FB664: .word 0x04804330
_037FB668: .word 0x04804332
_037FB66C: .word 0x04804954
_037FB670: .word 0x04804956
_037FB674: .word 0x04804A9C
_037FB678: .word 0x04804A9E
_037FB67C: .word 0x048050C0
_037FB680: .word 0x048050C2
_037FB684: .word 0x048045D8
_037FB688: .word 0x04804490
_037FB68C: .word 0x04804468
_037FB690: .word 0x04804230
_037FB694: .word 0x04804232
_037FB698: .word 0x04804464
_037FB69C: .word 0x04804466
_037FB6A0: .word 0x0480448C
_037FB6A4: .word 0x0480448E
_037FB6A8: .word 0x048045D4
_037FB6AC: .word 0x048045D6
_037FB6B0: .word 0x04804BF8
_037FB6B4: .word 0x04804BFA
	arm_func_end sub_37FB30C

	arm_func_start sub_37FB6B8
sub_37FB6B8: // 0x037FB6B8
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, _037FB7D0 // =0x0380FFF4
	ldr r1, [r0]
	add r6, r1, #0x344
	ldr r0, _037FB7D4 // =0x000004DC
	add r5, r1, r0
	mov r0, #0
	mov r1, r5
	mov r2, #0x50
	bl MIi_CpuClear32
	mov r1, #0x8000
	ldr r0, _037FB7D8 // =0x04808030
	strh r1, [r0]
	ldr r0, _037FB7D0 // =0x0380FFF4
	ldr r0, [r0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x50]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _037FB734
_037FB708: // jump table
	b _037FB718 // case 0
	b _037FB720 // case 1
	b _037FB728 // case 2
	b _037FB730 // case 3
_037FB718:
	ldr r4, _037FB7DC // =0x00000794
	b _037FB734
_037FB720:
	ldr r4, _037FB7E0 // =0x000010C4
	b _037FB734
_037FB728:
	ldr r4, _037FB7E4 // =0x00000BFC
	b _037FB734
_037FB730:
	ldr r4, _037FB7DC // =0x00000794
_037FB734:
	ldr r0, _037FB7E8 // =0x04804000
	add r1, r4, r0
	ldr r0, _037FB7EC // =0x04808050
	strh r1, [r0]
	mov r0, r4, lsl #0xf
	mov r2, r0, lsr #0x10
	ldr r0, _037FB7F0 // =0x04808056
	strh r2, [r0]
	ldr r1, _037FB7F4 // =0x00005F60
	ldr r0, _037FB7F8 // =0x04808052
	strh r1, [r0]
	ldr r0, _037FB7FC // =0x0480805A
	strh r2, [r0]
	strh r2, [r5, #4]
	ldr r0, _037FB800 // =0x0000FFFF
	strh r0, [r5]
	ldr r1, _037FB804 // =0x00001F60
	sub r1, r1, r4
	strh r1, [r6, #0x9a]
	ldr r2, _037FB808 // =0x00005F5E
	ldr r1, _037FB80C // =0x04808062
	strh r2, [r1]
	ldr r2, _037FB810 // =0x00008001
	ldr r1, _037FB7D8 // =0x04808030
	strh r2, [r1]
	ldr r1, _037FB814 // =0x0480824C
	strh r0, [r1]
	ldr r1, _037FB818 // =0x0480824E
	strh r0, [r1]
	ldr r1, _037FB81C // =0x04805F70
	strh r0, [r1]
	ldr r1, _037FB820 // =0x04805F72
	strh r0, [r1]
	ldr r1, _037FB824 // =0x04805F7E
	strh r0, [r1]
	ldr r1, _037FB828 // =0x04805F76
	strh r0, [r1]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_037FB7D0: .word 0x0380FFF4
_037FB7D4: .word 0x000004DC
_037FB7D8: .word 0x04808030
_037FB7DC: .word 0x00000794
_037FB7E0: .word 0x000010C4
_037FB7E4: .word 0x00000BFC
_037FB7E8: .word 0x04804000
_037FB7EC: .word 0x04808050
_037FB7F0: .word 0x04808056
_037FB7F4: .word 0x00005F60
_037FB7F8: .word 0x04808052
_037FB7FC: .word 0x0480805A
_037FB800: .word 0x0000FFFF
_037FB804: .word 0x00001F60
_037FB808: .word 0x00005F5E
_037FB80C: .word 0x04808062
_037FB810: .word 0x00008001
_037FB814: .word 0x0480824C
_037FB818: .word 0x0480824E
_037FB81C: .word 0x04805F70
_037FB820: .word 0x04805F72
_037FB824: .word 0x04805F7E
_037FB828: .word 0x04805F76
	arm_func_end sub_37FB6B8

	arm_func_start sub_37FB82C
sub_37FB82C: // 0x037FB82C
	mov r2, #0xfa0
	ldr r1, _037FB854 // =0x0480819C
	b _037FB848
_037FB838:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bxne lr
	sub r2, r2, #1
_037FB848:
	cmp r2, #0
	bne _037FB838
	bx lr
	.align 2, 0
_037FB854: .word 0x0480819C
	arm_func_end sub_37FB82C

	arm_func_start sub_37FB858
sub_37FB858: // 0x037FB858
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r1, #1
	str r1, [sp, #4]
	mov r3, #0
	ldr r1, _037FB8D8 // =0x000082EA
	umull ip, r2, r0, r1
	mla r2, r0, r3, r2
	mla r2, r3, r1, r2
	mov r1, r2, lsr #6
	mov r0, ip, lsr #6
	orr r0, r0, r2, lsl #26
	mov r2, #0x3e8
	bl _ll_udiv
	mov r3, r0
	mov r2, r1
	add r0, sp, #4
	str r0, [sp]
	ldr r0, _037FB8DC // =0x0380FFF4
	ldr r1, [r0]
	ldr r0, _037FB8E0 // =0x00000634
	add r0, r1, r0
	mov r1, r3
	mov r3, r4
	bl OS_SetAlarm
_037FB8C0:
	ldr r0, [sp, #4]
	cmp r0, #0
	bne _037FB8C0
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FB8D8: .word 0x000082EA
_037FB8DC: .word 0x0380FFF4
_037FB8E0: .word 0x00000634
	arm_func_end sub_37FB858

	arm_func_start sub_37FB8E4
sub_37FB8E4: // 0x037FB8E4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, #1
	ldr r1, _037FB95C // =0x04808028
	ldr r2, _037FB960 // =0x04808214
	ldr lr, _037FB964 // =0x04000208
	mov ip, #0
	ldr r3, _037FB968 // =0x0480819C
	b _037FB948
_037FB908:
	ldrh r5, [lr]
	strh ip, [lr]
	ldrh r0, [r3]
	and r0, r0, #3
	cmp r0, #3
	beq _037FB940
	ldrh r0, [r2]
	cmp r0, #5
	beq _037FB940
	cmp r0, #7
	beq _037FB940
	cmp r0, #8
	strneh ip, [r1]
	movne r4, ip
_037FB940:
	ldrh r0, [lr]
	strh r5, [lr]
_037FB948:
	cmp r4, #0
	bne _037FB908
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FB95C: .word 0x04808028
_037FB960: .word 0x04808214
_037FB964: .word 0x04000208
_037FB968: .word 0x0480819C
	arm_func_end sub_37FB8E4

	arm_func_start sub_37FB96C
sub_37FB96C: // 0x037FB96C
	mov r2, #0
	ldr r1, _037FB99C // =0x0480815E
	b _037FB98C
_037FB978:
	ldrh r0, [r1]
	ands r0, r0, #1
	moveq r0, #0
	bxeq lr
	add r2, r2, #1
_037FB98C:
	cmp r2, #0x2800
	blo _037FB978
	mov r0, #1
	bx lr
	.align 2, 0
_037FB99C: .word 0x0480815E
	arm_func_end sub_37FB96C

	arm_func_start sub_37FB9A0
sub_37FB9A0: // 0x037FB9A0
	mov r2, #0
	ldr r1, _037FB9D0 // =0x04808180
	b _037FB9C0
_037FB9AC:
	ldrh r0, [r1]
	ands r0, r0, #1
	moveq r0, #0
	bxeq lr
	add r2, r2, #1
_037FB9C0:
	cmp r2, #0x2800
	blo _037FB9AC
	mov r0, #1
	bx lr
	.align 2, 0
_037FB9D0: .word 0x04808180
	arm_func_end sub_37FB9A0