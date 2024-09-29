	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start sub_20C423C
sub_20C423C: // 0x020C423C
	ldr ip, _020C4250 // =MI_CpuFill8
	ldr r0, _020C4254 // =0x0214707C
	mov r1, #0
	mov r2, #0x170
	bx ip
	.align 2, 0
_020C4250: .word MI_CpuFill8
_020C4254: .word 0x0214707C
	arm_func_end sub_20C423C

	arm_func_start sub_20C4258
sub_20C4258: // 0x020C4258
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r4, _020C433C // =0x0214707C
	mov r6, #0
	mov r2, r6
	ldr r1, _020C4340 // =0x000003BD
_020C4274:
	ldrb r3, [r4, #0x5a]
	cmp r3, #0
	beq _020C4290
	ldr r3, [r4, #0x50]
	sub r3, r5, r3
	cmp r3, r1
	strgtb r2, [r4, #0x5a]
_020C4290:
	add r6, r6, #1
	cmp r6, #4
	add r4, r4, #0x5c
	blt _020C4274
	bl OS_RestoreInterrupts
	ldr r0, _020C4344 // =OSi_ThreadInfo
	ldr r4, [r0, #8]
	cmp r4, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	mov r6, #0
_020C42BC:
	ldr r1, [r4, #0xa4]
	cmp r1, #0
	beq _020C4328
	ldr r0, [r1]
	cmp r0, #0
	beq _020C4328
	ldrb r0, [r1, #9]
	cmp r0, #0
	beq _020C4328
	ldrb r0, [r1, #8]
	cmp r0, #4
	bne _020C4328
	ldr r0, [r1, #0xc]
	ldrb r0, [r0, #0x455]
	cmp r0, #8
	bhs _020C4328
	ldr r0, [r1, #0x10]
	sub r0, r5, r0
	cmp r0, #0xef
	ble _020C4328
	ldr r0, [r1, #4]
	cmp r0, #2
	bne _020C4328
	strb r6, [r1, #8]
	str r6, [r1, #4]
	ldr r0, [r1]
	bl OS_WakeupThreadDirect
_020C4328:
	ldr r4, [r4, #0x68]
	cmp r4, #0
	bne _020C42BC
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C433C: .word 0x0214707C
_020C4340: .word 0x000003BD
_020C4344: .word OSi_ThreadInfo
	arm_func_end sub_20C4258

	arm_func_start sub_20C4348
sub_20C4348: // 0x020C4348
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _020C4374 // =_version_UBIQUITOUS_SSL
	bl OSi_ReferSymbol
	ldr r0, _020C4378 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	ldr r0, [r0, #0xa4]
	cmp r0, #0
	strneb r4, [r0, #9]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C4374: .word _version_UBIQUITOUS_SSL
_020C4378: .word OSi_ThreadInfo
	arm_func_end sub_20C4348

	arm_func_start sub_20C437C
sub_20C437C: // 0x020C437C
	stmdb sp!, {r4, lr}
	ldr r4, [r0, #0xc]
	mov r0, #0
	strb r0, [r4, #0x455]
	ldr r0, [r4, #0x824]
	cmp r0, #0
	beq _020C43A4
	ldr r1, _020C43B4 // =0x0214586C
	ldr r1, [r1]
	blx r1
_020C43A4:
	mov r0, #0
	str r0, [r4, #0x824]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C43B4: .word 0x0214586C
	arm_func_end sub_20C437C

	arm_func_start sub_20C43B8
sub_20C43B8: // 0x020C43B8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	mov r5, r0
	ldr r4, [r5, #0xc]
	ldrb r0, [r4, #0x455]
	cmp r0, #8
	bne _020C4428
	mov ip, #0
	mov r6, #0x15
	mov lr, #3
	mov r3, #2
	mov r2, #1
	add r1, sp, #4
	mov r0, r4
	strb r6, [sp, #4]
	strb lr, [sp, #5]
	strb ip, [sp, #6]
	strb ip, [sp, #7]
	strb r3, [sp, #8]
	strb r2, [sp, #9]
	strb ip, [sp, #0xa]
	bl sub_20C5A50
	mov r2, #0
	mov r1, r0
	add r0, sp, #4
	mov r3, r2
	str r5, [sp]
	bl sub_20C0230
_020C4428:
	mov r0, #0
	strb r0, [r4, #0x455]
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C43B8

	arm_func_start sub_20C443C
sub_20C443C: // 0x020C443C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	ldr r4, [sp, #0x48]
	mov r9, r1
	mov r1, r4
	mov r10, r0
	mov r0, #0
	ldr r1, [r1, #0xc]
	str r0, [sp, #8]
	str r0, [sp, #0x1c]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, #0x17
	str r0, [sp, #0xc]
	mov r0, #3
	str r4, [sp, #0x48]
	str r1, [sp, #4]
	mov r8, r2
	add r6, r9, r3
	str r0, [sp, #0x10]
_020C448C:
	ldr r0, _020C4588 // =0x00000B4F
	ldr r1, _020C458C // =0x02145840
	cmp r6, r0
	movgt r5, r0
	movle r5, r6
	ldr r1, [r1]
	add r0, r5, #0x19
	blx r1
	movs r7, r0
	beq _020C4578
	cmp r9, r5
	movhs r4, r5
	movlo r4, r9
	mov r0, r10
	add r1, r7, #5
	mov r2, r4
	sub r11, r5, r4
	bl MI_CpuCopy8
	add r1, r7, #5
	mov r0, r8
	add r1, r1, r4
	mov r2, r11
	add r10, r10, r4
	sub r9, r9, r4
	bl MI_CpuCopy8
	ldr r0, [sp, #0xc]
	mov r1, r7
	strb r0, [r7]
	ldr r0, [sp, #0x10]
	add r8, r8, r11
	strb r0, [r7, #1]
	ldr r0, [sp, #0x14]
	strb r0, [r7, #2]
	mov r0, r5, asr #8
	strb r0, [r7, #3]
	ldr r0, [sp, #4]
	strb r5, [r7, #4]
	bl sub_20C5A50
	ldr r1, [sp, #0x48]
	ldr r2, [sp, #0x18]
	mov r4, r0
	str r1, [sp]
	mov r0, r7
	mov r1, r4
	mov r3, r2
	bl sub_20C0230
	cmp r0, r4
	ldr r1, _020C4590 // =0x0214586C
	mov r0, r7
	ldr r1, [r1]
	ldrlo r5, [sp, #0x1c]
	blx r1
	ldr r0, [sp, #8]
	subs r6, r6, r5
	add r0, r0, r5
	str r0, [sp, #8]
	beq _020C4578
	cmp r5, #0
	bne _020C448C
_020C4578:
	ldr r0, [sp, #8]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C4588: .word 0x00000B4F
_020C458C: .word 0x02145840
_020C4590: .word 0x0214586C
	arm_func_end sub_20C443C

	arm_func_start sub_20C4594
sub_20C4594: // 0x020C4594
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r4, [r5, #0xc]
	ldr r0, [r4, #0x824]
	cmp r0, #0
	beq _020C45BC
	ldrb r0, [r4, #0x456]
	cmp r0, #0
	bne _020C45C4
_020C45BC:
	mov r0, r5
	bl sub_20C4630
_020C45C4:
	ldr r1, [r4, #0x824]
	cmp r1, #0
	beq _020C45F0
	ldrb r0, [r4, #0x456]
	cmp r0, #0
	ldrne r1, [r4, #0x828]
	ldrne r0, [r4, #0x82c]
	addne sp, sp, #4
	subne r0, r1, r0
	ldmneia sp!, {r4, r5, lr}
	bxne lr
_020C45F0:
	cmp r1, #0
	bne _020C4620
	ldrb r0, [r5, #8]
	cmp r0, #4
	bne _020C4610
	ldrb r0, [r4, #0x455]
	cmp r0, #9
	bne _020C4620
_020C4610:
	add sp, sp, #4
	mvn r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020C4620:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20C4594

	arm_func_start sub_20C4630
sub_20C4630: // 0x020C4630
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r4, [r5, #0xc]
	ldr r0, [r4, #0x824]
	cmp r0, #0
	bne _020C46E0
	ldr r0, [r5, #0x44]
	cmp r0, #5
	addlo sp, sp, #8
	ldmloia sp!, {r4, r5, r6, lr}
	bxlo lr
	add r0, sp, #0
	mov r1, r5
	bl sub_20C071C
	ldrb r2, [r0, #3]
	ldrb r0, [r0, #4]
	ldr r1, _020C478C // =0x00004805
	add r0, r0, r2, lsl #8
	add r0, r0, #5
	str r0, [sp]
	cmp r0, r1
	movhi r0, #9
	addhi sp, sp, #8
	strhib r0, [r4, #0x455]
	ldmhiia sp!, {r4, r5, r6, lr}
	bxhi lr
	ldr r1, _020C4790 // =0x02145840
	ldr r1, [r1]
	blx r1
	str r0, [r4, #0x824]
	ldr r0, [r4, #0x824]
	cmp r0, #0
	moveq r0, #9
	addeq sp, sp, #8
	streqb r0, [r4, #0x455]
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r1, [sp]
	mov r0, #0
	str r1, [r4, #0x828]
	str r0, [r4, #0x82c]
	strb r0, [r4, #0x456]
	b _020C46F4
_020C46E0:
	ldr r0, [r5, #0x44]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
_020C46F4:
	add r0, sp, #0
	mov r1, r5
	bl sub_20C071C
	ldr r3, [r4, #0x828]
	ldr r2, [r4, #0x82c]
	ldr r1, [sp]
	sub r2, r3, r2
	cmp r1, r2
	strhs r2, [sp]
	movhs r6, #1
	ldr r3, [r4, #0x824]
	ldr r1, [r4, #0x82c]
	ldr r2, [sp]
	add r1, r3, r1
	movlo r6, #0
	bl MI_CpuCopy8
	ldr r0, [sp]
	mov r1, r5
	bl sub_20C05DC
	cmp r6, #0
	beq _020C4770
	ldr r1, [r4, #0x824]
	mov r0, r4
	bl sub_20C5744
	ldrb r0, [r4, #0x456]
	add sp, sp, #8
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0x824]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C4770:
	ldr r1, [r4, #0x82c]
	ldr r0, [sp]
	add r0, r1, r0
	str r0, [r4, #0x82c]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C478C: .word 0x00004805
_020C4790: .word 0x02145840
	arm_func_end sub_20C4630

	arm_func_start sub_20C4794
sub_20C4794: // 0x020C4794
	stmdb sp!, {r4, lr}
	ldr r4, [r1, #0xc]
	ldr r2, [r4, #0x828]
	ldr r1, [r4, #0x82c]
	sub r2, r2, r1
	cmp r0, r2
	blo _020C47D8
	ldr r0, [r4, #0x824]
	cmp r0, #0
	beq _020C47C8
	ldr r1, _020C47E8 // =0x0214586C
	ldr r1, [r1]
	blx r1
_020C47C8:
	mov r0, #0
	str r0, [r4, #0x824]
	ldmia sp!, {r4, lr}
	bx lr
_020C47D8:
	add r0, r1, r0
	str r0, [r4, #0x82c]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C47E8: .word 0x0214586C
	arm_func_end sub_20C4794

	arm_func_start sub_20C47EC
sub_20C47EC: // 0x020C47EC
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	ldr r4, [r5, #0xc]
	mov r6, r0
	ldr ip, [r4, #0x824]
	cmp ip, #0
	beq _020C4874
	ldrb r0, [r4, #0x456]
	cmp r0, #0
	bne _020C4874
	ldr r3, [r4, #0x82c]
	ldr r1, [r4, #0x828]
	mov r2, r5
	add r0, ip, r3
	sub r1, r1, r3
	bl sub_20C59D0
	cmp r0, #0
	beq _020C4858
	ldr r1, _020C48CC // =0x0214586C
	ldr r0, [r4, #0x824]
	ldr r1, [r1]
	blx r1
	mov r0, #0
	str r0, [r4, #0x824]
	str r0, [r6]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C4858:
	ldr r1, [r4, #0x824]
	mov r0, r4
	bl sub_20C5744
	ldrb r0, [r4, #0x456]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0x824]
_020C4874:
	ldr r0, [r4, #0x824]
	cmp r0, #0
	bne _020C48A8
_020C4880:
	mov r0, r5
	bl sub_20C5584
	cmp r0, #9
	moveq r0, #0
	streq r0, [r6]
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r0, [r4, #0x824]
	cmp r0, #0
	beq _020C4880
_020C48A8:
	ldr r1, [r4, #0x828]
	ldr r0, [r4, #0x82c]
	sub r0, r1, r0
	str r0, [r6]
	ldr r1, [r4, #0x824]
	ldr r0, [r4, #0x82c]
	add r0, r1, r0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C48CC: .word 0x0214586C
	arm_func_end sub_20C47EC

	arm_func_start sub_20C48D0
sub_20C48D0: // 0x020C48D0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldrb r1, [r5, #8]
	ldr r4, [r5, #0xc]
	cmp r1, #4
	beq _020C4904
	bl sub_20C09EC
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {r4, r5, lr}
	bxne lr
_020C4904:
	mov r1, #0
	strb r1, [r4, #0x455]
	str r1, [r4, #0x1d4]
	add r0, r4, #0x2ec
	strb r1, [r4, #0x454]
	bl sub_20C8228
	add r0, r4, #0x3a4
	bl sub_20C7BE8
	mov r0, r5
	bl sub_20C4938
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20C48D0

	arm_func_start sub_20C4938
sub_20C4938: // 0x020C4938
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r4, [r5, #0xc]
	bl sub_20C4E40
_020C494C:
	mov r0, r5
	bl sub_20C5584
	cmp r0, #9
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	cmp r0, #4
	beq _020C497C
	ldrb r0, [r4, #0x31]
	cmp r0, #0
	beq _020C494C
_020C497C:
	ldrb r0, [r4, #0x31]
	cmp r0, #0
	beq _020C49B8
	mov r0, r4
	bl sub_20C61B8
	mov r0, r5
	bl sub_20C4B50
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	mov r0, r5
	bl sub_20C4FF0
	b _020C4A10
_020C49B8:
	mov r0, r5
	bl sub_20C4B88
	mov r0, r4
	bl sub_20C63C0
	ldrb r0, [r4, #0x30]
	cmp r0, #0
	beq _020C49E4
	ldrh r2, [r5, #0x18]
	ldr r1, [r5, #0x1c]
	mov r0, r4
	bl sub_20C7864
_020C49E4:
	mov r0, r4
	bl sub_20C61B8
	mov r0, r5
	bl sub_20C4FF0
	mov r0, r5
	bl sub_20C4B50
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {r4, r5, lr}
	bxne lr
_020C4A10:
	mov r0, #8
	strb r0, [r4, #0x455]
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20C4938

	arm_func_start sub_20C4A28
sub_20C4A28: // 0x020C4A28
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	ldr r8, [r9, #0xc]
	add r5, r8, #0x2ec
	add r4, r8, #0x3a4
	mov r7, #0
	mov r6, #1
_020C4A48:
	mov r0, r9
	bl sub_20C0B20
	strb r7, [r8, #0x455]
	str r7, [r8, #0x1d4]
	mov r0, r5
	strb r6, [r8, #0x454]
	bl sub_20C8228
	mov r0, r4
	bl sub_20C7BE8
	mov r0, r9
	bl sub_20C4AB4
	cmp r0, #0
	moveq r0, #8
	addeq sp, sp, #4
	streqb r0, [r8, #0x455]
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	mov r0, r9
	bl sub_20C08E0
	ldrh r0, [r9, #0x1a]
	strh r0, [r9, #0x18]
	ldr r0, [r9, #0x20]
	str r0, [r9, #0x1c]
	b _020C4A48
	arm_func_end sub_20C4A28

	arm_func_start sub_20C4AA8
sub_20C4AA8: // 0x020C4AA8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end sub_20C4AA8

	arm_func_start sub_20C4AB4
sub_20C4AB4: // 0x020C4AB4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20C5584
	cmp r0, #1
	movne r0, #1
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r0, r4
	bl sub_20C5150
	cmp r0, #0
	beq _020C4B0C
	ldr r0, [r4, #0xc]
	bl sub_20C61B8
	mov r0, r4
	bl sub_20C4FF0
	mov r0, r4
	bl sub_20C4B50
	cmp r0, #0
	beq _020C4B44
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020C4B0C:
	mov r0, r4
	bl sub_20C5584
	cmp r0, #5
	movne r0, #1
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r0, r4
	bl sub_20C4B50
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r0, r4
	bl sub_20C4FF0
_020C4B44:
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C4AB4

	arm_func_start sub_20C4B50
sub_20C4B50: // 0x020C4B50
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20C5584
	cmp r0, #7
	movne r0, #1
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r0, r4
	bl sub_20C5584
	cmp r0, #6
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C4B50

	arm_func_start sub_20C4B88
sub_20C4B88: // 0x020C4B88
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r11, r0
	ldr r10, [r11, #0xc]
	mov r0, #3
	strb r0, [r10]
	mov r0, #0
	strb r0, [r10, #1]
	add r0, r10, #2
	mov r1, #0x2e
	bl sub_20C543C
	ldr r4, [r10, #0x594]
	ldr r0, _020C4E30 // =0x02145840
	mov r1, r4, lsl #1
	ldr r2, [r0]
	add r1, r1, r1, lsr #31
	mov r0, r4
	mov r6, r1, asr #1
	blx r2
	movs r5, r0
	moveq r0, #9
	addeq sp, sp, #0xc
	streqb r0, [r10, #0x455]
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	mov r0, #0
	strb r0, [r5]
	mov r2, #2
	add r0, r5, #2
	sub r1, r4, #0x33
	strb r2, [r5, #1]
	bl sub_20C543C
	add r1, r5, r4
	mov r0, r10
	sub r3, r4, #0x31
	mov r7, #0
	sub r1, r1, #0x30
	mov r2, #0x30
	strb r7, [r5, r3]
	bl MI_CpuCopy8
	ldr r1, _020C4E30 // =0x02145840
	mov r0, r6, lsl #3
	ldr r1, [r1]
	blx r1
	movs r9, r0
	bne _020C4C64
	ldr r1, _020C4E34 // =0x0214586C
	mov r0, r5
	ldr r1, [r1]
	blx r1
	mov r0, #9
	add sp, sp, #0xc
	strb r0, [r10, #0x455]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020C4C64:
	add r0, r9, r6, lsl #1
	add r8, r0, r6, lsl #1
	mov r1, r5
	mov r2, r4
	mov r3, r6
	str r0, [sp, #4]
	add r7, r8, r6, lsl #1
	bl sub_20C8BAC
	ldr r1, _020C4E38 // =0x00000598
	ldr r2, [r10, #0x5a0]
	mov r0, r8
	add r1, r10, r1
	mov r3, r6
	bl sub_20C8BAC
	ldr r1, _020C4E3C // =0x00000494
	mov r0, r7
	mov r2, r4
	add r1, r10, r1
	mov r3, r6
	bl sub_20C8BAC
	bl sub_20C7748
	mov r3, r6
	mov r6, r0
	ldr r1, [sp, #4]
	mov r2, r8
	mov r0, r9
	str r7, [sp]
	bl sub_20C90D8
	mov r0, r6
	bl sub_20C7710
	ldr r1, _020C4E30 // =0x02145840
	add r0, r4, #0x49
	ldr r1, [r1]
	blx r1
	movs r6, r0
	bne _020C4D28
	ldr r1, _020C4E34 // =0x0214586C
	mov r0, r5
	ldr r1, [r1]
	blx r1
	ldr r1, _020C4E34 // =0x0214586C
	mov r0, r9
	ldr r1, [r1]
	blx r1
	mov r0, #9
	add sp, sp, #0xc
	strb r0, [r10, #0x455]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020C4D28:
	mov r0, #0x16
	strb r0, [r6]
	mov r1, #3
	add r0, r4, #4
	strb r1, [r6, #1]
	mov r1, #0
	strb r1, [r6, #2]
	mov r1, r0, asr #8
	strb r1, [r6, #3]
	add r2, r6, #9
	strb r0, [r6, #4]
	mov r0, #0x10
	strb r0, [r6, #5]
	mov r0, r4, asr #0x10
	strb r0, [r6, #6]
	mov r0, r4, asr #8
	strb r0, [r6, #7]
	mov r0, r2
	strb r4, [r6, #8]
	ands r1, r4, #1
	beq _020C4D94
	add r0, r4, r4, lsr #31
	mov r0, r0, asr #1
	mov r0, r0, lsl #1
	ldrh r1, [r9, r0]
	add r0, r2, #1
	strb r1, [r2]
_020C4D94:
	add r1, r4, r4, lsr #31
	mov r1, r1, asr #1
	subs r7, r1, #1
	bmi _020C4DCC
_020C4DA4:
	mov r3, r7, lsl #1
	ldrh r1, [r9, r3]
	add r2, r0, #1
	subs r7, r7, #1
	mov r1, r1, asr #8
	strb r1, [r0]
	ldrh r1, [r9, r3]
	add r0, r0, #2
	strb r1, [r2]
	bpl _020C4DA4
_020C4DCC:
	mov r2, #0
	mov r0, r6
	mov r3, r2
	add r1, r4, #9
	str r11, [sp]
	bl sub_20C0230
	mov r0, r10
	add r1, r6, #5
	add r2, r4, #4
	bl sub_20C59A0
	ldr r1, _020C4E34 // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	ldr r1, _020C4E34 // =0x0214586C
	mov r0, r9
	ldr r1, [r1]
	blx r1
	ldr r1, _020C4E34 // =0x0214586C
	mov r0, r5
	ldr r1, [r1]
	blx r1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C4E30: .word 0x02145840
_020C4E34: .word 0x0214586C
_020C4E38: .word 0x00000598
_020C4E3C: .word 0x00000494
	arm_func_end sub_20C4B88

	arm_func_start sub_20C4E40
sub_20C4E40: // 0x020C4E40
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r1, _020C4FE4 // =0x02145840
	mov r8, r0
	ldr r1, [r1]
	mov r0, #0x98
	ldr r7, [r8, #0xc]
	blx r1
	movs r6, r0
	moveq r0, #9
	addeq sp, sp, #8
	streqb r0, [r7, #0x455]
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	mov r0, #3
	strb r0, [r6, #9]
	add r5, r6, #9
	mov r0, #0
	strb r0, [r5, #1]
	bl sub_20C77B8
	mov r1, r0, lsr #0x18
	strb r1, [r7, #0x34]
	mov r1, r0, lsr #0x10
	strb r1, [r7, #0x35]
	mov r1, r0, lsr #8
	strb r1, [r7, #0x36]
	strb r0, [r7, #0x37]
	add r0, r7, #0x38
	mov r1, #0x1c
	bl sub_20C543C
	add r0, r7, #0x34
	add r1, r5, #2
	mov r2, #0x20
	bl MI_CpuCopy8
	ldrh r2, [r8, #0x18]
	ldr r1, [r8, #0x1c]
	mov r0, r7
	bl sub_20C7964
	ldrb r0, [r7, #0x30]
	cmp r0, #0
	moveq r0, #0
	streqb r0, [r5, #0x22]
	addeq r5, r5, #0x23
	beq _020C4F08
	mov r2, #0x20
	add r0, r7, #0x74
	add r1, r5, #0x23
	strb r2, [r5, #0x22]
	bl MI_CpuCopy8
	add r5, r5, #0x43
_020C4F08:
	mov r4, #0
	strb r4, [r5]
	mov r0, #4
	strb r0, [r5, #1]
	ldr r2, _020C4FE8 // =0x0211F1E0
	add r5, r5, #2
_020C4F20:
	mov r3, r4, lsl #1
	ldrh r0, [r2, r3]
	add r4, r4, #1
	add r1, r5, #1
	mov r0, r0, asr #8
	strb r0, [r5]
	ldrh r0, [r2, r3]
	cmp r4, #2
	add r5, r5, #2
	strb r0, [r1]
	blo _020C4F20
	mov r3, #1
	mov r2, #0
	strb r3, [r5]
	add r0, r5, #2
	sub r0, r0, r6
	sub r4, r0, #5
	strb r2, [r5, #1]
	sub r1, r4, #4
	mov r0, #0x16
	strb r0, [r6]
	mov r0, #3
	strb r0, [r6, #1]
	strb r2, [r6, #2]
	mov r0, r4, asr #8
	strb r0, [r6, #3]
	strb r4, [r6, #4]
	strb r3, [r6, #5]
	mov r0, r1, asr #0x10
	strb r0, [r6, #6]
	mov r0, r1, asr #8
	strb r0, [r6, #7]
	strb r1, [r6, #8]
	mov r0, r6
	mov r3, r2
	add r1, r4, #5
	str r8, [sp]
	bl sub_20C0230
	mov r0, r7
	mov r2, r4
	add r1, r6, #5
	bl sub_20C59A0
	ldr r1, _020C4FEC // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C4FE4: .word 0x02145840
_020C4FE8: .word 0x0211F1E0
_020C4FEC: .word 0x0214586C
	arm_func_end sub_20C4E40

	arm_func_start sub_20C4FF0
sub_20C4FF0: // 0x020C4FF0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r1, _020C5148 // =0x02145840
	mov r6, r0
	ldr r1, [r1]
	mov r0, #0x83
	ldr r5, [r6, #0xc]
	blx r1
	movs r4, r0
	moveq r0, #9
	addeq sp, sp, #8
	streqb r0, [r5, #0x455]
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	mov r0, #0x14
	strb r0, [r4]
	mov r0, #3
	strb r0, [r4, #1]
	mov r1, #0
	strb r1, [r4, #2]
	strb r1, [r4, #3]
	mov r3, #1
	strb r3, [r4, #4]
	add r0, r5, #0x1cc
	mov r2, #8
	strb r3, [r4, #5]
	bl MI_CpuFill8
	mov r0, #0x16
	strb r0, [r4, #6]
	mov r0, #3
	strb r0, [r4, #7]
	mov r1, #0
	strb r1, [r4, #8]
	strb r1, [r4, #9]
	mov r0, #0x28
	strb r0, [r4, #0xa]
	mov r0, #0x14
	strb r0, [r4, #0xb]
	strb r1, [r4, #0xc]
	strb r1, [r4, #0xd]
	mov r3, #0x24
	add r0, r5, #0x3a4
	add r1, r5, #0x3fc
	mov r2, #0x58
	strb r3, [r4, #0xe]
	bl MI_CpuCopy8
	mov r0, r5
	add r1, r4, #0xf
	mov r2, #0
	bl sub_20C6090
	add r0, r5, #0x3fc
	add r1, r5, #0x3a4
	mov r2, #0x58
	bl MI_CpuCopy8
	add r0, r5, #0x2ec
	add r1, r5, #0x348
	mov r2, #0x5c
	bl MI_CpuCopy8
	mov r0, r5
	add r1, r4, #0x1f
	mov r2, #0
	bl sub_20C5FA8
	add r0, r5, #0x348
	add r1, r5, #0x2ec
	mov r2, #0x5c
	bl MI_CpuCopy8
	mov r0, r5
	add r1, r4, #0xb
	mov r2, #0x28
	bl sub_20C59A0
	mov r0, r5
	add r1, r4, #6
	bl sub_20C5A50
	mov r2, #0
	add r1, r0, #6
	mov r0, r4
	mov r3, r2
	str r6, [sp]
	bl sub_20C0230
	ldr r1, _020C514C // =0x0214586C
	mov r0, r4
	ldr r1, [r1]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C5148: .word 0x02145840
_020C514C: .word 0x0214586C
	arm_func_end sub_20C4FF0

	arm_func_start sub_20C5150
sub_20C5150: // 0x020C5150
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	ldr r7, [r9, #0xc]
	ldr r4, [r7, #0x820]
	cmp r4, #0
	ldrne r8, [r4]
	moveq r8, #0
	bl sub_20C77B8
	mov r1, r0, lsr #0x18
	strb r1, [r7, #0x54]
	mov r1, r0, lsr #0x10
	strb r1, [r7, #0x55]
	mov r1, r0, lsr #8
	strb r1, [r7, #0x56]
	strb r0, [r7, #0x57]
	add r0, r7, #0x58
	mov r1, #0x1c
	bl sub_20C543C
	ldr r1, _020C53BC // =0x02145840
	add r0, r8, #0x9d
	ldr r1, [r1]
	blx r1
	movs r6, r0
	moveq r0, #9
	streqb r0, [r7, #0x455]
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	mov r0, #2
	add r5, r6, #5
	strb r0, [r6, #5]
	mov r3, #0
	strb r3, [r5, #1]
	strb r3, [r5, #2]
	mov r0, #0x46
	strb r0, [r5, #3]
	mov r0, #3
	strb r0, [r5, #4]
	add r0, r7, #0x54
	add r1, r5, #6
	mov r2, #0x20
	strb r3, [r5, #5]
	bl MI_CpuCopy8
	mov r2, #0x20
	strb r2, [r5, #0x26]
	ldrb r0, [r7, #0x30]
	cmp r0, #0
	beq _020C5234
	add r0, r7, #0x74
	add r1, r5, #0x27
	bl MI_CpuCopy8
	mov r0, #1
	strb r0, [r7, #0x31]
	add r5, r5, #0x47
	b _020C5294
_020C5234:
	add r0, r5, #0x27
	mov r1, #0x1c
	bl sub_20C543C
	ldr r0, _020C53C0 // =0x02147064
	add r2, r5, #0x46
	ldr r3, [r0]
	add r1, r7, #0x74
	mov r0, r3, lsr #0x18
	strb r0, [r5, #0x43]
	mov r0, r3, lsr #0x10
	strb r0, [r5, #0x44]
	mov r0, r3, lsr #8
	strb r0, [r5, #0x45]
	add r5, r5, #0x47
	sub r0, r5, #0x20
	strb r3, [r2]
	mov r2, #0x20
	bl MI_CpuCopy8
	ldr r0, _020C53C0 // =0x02147064
	mov r1, #0
	ldr r2, [r0]
	add r2, r2, #1
	str r2, [r0]
	strb r1, [r7, #0x31]
_020C5294:
	ldrh r2, [r7, #0x32]
	mov r0, #0
	mov r2, r2, asr #8
	strb r2, [r5]
	ldrh r2, [r7, #0x32]
	strb r2, [r5, #1]
	strb r0, [r5, #2]
	ldrb r0, [r7, #0x31]
	add r5, r5, #3
	cmp r0, #0
	bne _020C5348
	cmp r8, #0
	beq _020C532C
	mov r0, #0xb
	add r2, r8, #6
	strb r0, [r5]
	mov r0, r2, asr #0x10
	strb r0, [r5, #1]
	mov r0, r2, asr #8
	strb r0, [r5, #2]
	add r1, r8, #3
	strb r2, [r5, #3]
	mov r0, r1, asr #0x10
	strb r0, [r5, #4]
	mov r0, r1, asr #8
	strb r0, [r5, #5]
	strb r1, [r5, #6]
	mov r0, r8, asr #0x10
	strb r0, [r5, #7]
	mov r0, r8, asr #8
	strb r0, [r5, #8]
	strb r8, [r5, #9]
	add r5, r5, #0xa
	ldr r0, [r4, #4]
	mov r1, r5
	mov r2, r8
	bl MI_CpuCopy8
	add r5, r5, r8
_020C532C:
	mov r0, #0xe
	strb r0, [r5]
	mov r1, #0
	strb r1, [r5, #1]
	strb r1, [r5, #2]
	strb r1, [r5, #3]
	add r5, r5, #4
_020C5348:
	mov r0, #0x16
	sub r1, r5, r6
	sub r4, r1, #5
	strb r0, [r6]
	mov r0, #3
	strb r0, [r6, #1]
	mov r0, #0
	strb r0, [r6, #2]
	mov r0, r4, asr #8
	strb r0, [r6, #3]
	mov r0, r7
	mov r2, r4
	add r1, r6, #5
	strb r4, [r6, #4]
	bl sub_20C59A0
	mov r2, #0
	mov r0, r6
	mov r3, r2
	add r1, r4, #5
	str r9, [sp]
	bl sub_20C0230
	ldr r1, _020C53C4 // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	ldrb r0, [r7, #0x31]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020C53BC: .word 0x02145840
_020C53C0: .word 0x02147064
_020C53C4: .word 0x0214586C
	arm_func_end sub_20C5150

	arm_func_start sub_20C53C8
sub_20C53C8: // 0x020C53C8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x60
	mov r6, r0
	add r0, sp, #0
	mov r5, r1
	bl sub_20C8228
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r1, _020C5434 // =0x02147068
	add r0, sp, #0
	mov r2, #0x14
	bl sub_20C8168
	mov r1, r6
	mov r2, r5
	add r0, sp, #0
	bl sub_20C8168
	ldr r1, _020C5434 // =0x02147068
	add r0, sp, #0
	bl sub_20C80F4
	mov r0, r4
	bl OS_RestoreInterrupts
	ldr r0, _020C5438 // =0x02147060
	mov r1, #1
	strb r1, [r0]
	add sp, sp, #0x60
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C5434: .word 0x02147068
_020C5438: .word 0x02147060
	arm_func_end sub_20C53C8

	arm_func_start sub_20C543C
sub_20C543C: // 0x020C543C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x7c
	ldr r2, _020C5574 // =0x02147060
	mov r10, r0
	ldrb r0, [r2]
	mov r9, r1
	cmp r0, #0
	bne _020C54A4
	ldr r2, _020C5578 // =0x0214589C
	add r0, sp, #4
	ldr r4, [r2, #8]
	ldr r3, [r2]
	ldr r1, [r2, #4]
	umull r6, r5, r4, r3
	mla r5, r4, r1, r5
	ldr r1, [r2, #0xc]
	ldr r4, [r2, #0x10]
	mla r5, r1, r3, r5
	adds r4, r4, r6
	ldr r3, [r2, #0x14]
	mov r1, #4
	adc r3, r3, r5
	str r4, [r2]
	str r3, [r2, #4]
	str r3, [sp, #4]
	bl sub_20C53C8
_020C54A4:
	cmp r9, #0
	mov r7, #0
	addle sp, sp, #0x7c
	mov r1, #0x14
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxle lr
	add r6, sp, #0x1c
	mov r11, r1
	str r7, [sp]
	mov r5, #1
	mov r4, #0x13
_020C54D0:
	cmp r1, #0x14
	bne _020C5548
	mov r0, r6
	bl sub_20C8228
	bl OS_DisableInterrupts
	mov r8, r0
	ldr r1, _020C557C // =0x02147068
	mov r0, r6
	mov r2, r11
	bl sub_20C8168
	mov r0, r6
	add r1, sp, #8
	bl sub_20C80B8
	ldr r2, _020C5580 // =0x0214707B
	mov ip, r5
	mov lr, r4
	add r3, sp, #0x1b
_020C5514:
	ldrb r1, [r2]
	ldrb r0, [r3], #-1
	subs lr, lr, #1
	add r0, r1, r0
	add r0, ip, r0
	strb r0, [r2]
	mov ip, r0, lsr #8
	sub r2, r2, #1
	bpl _020C5514
	str r0, [sp, #4]
	mov r0, r8
	bl OS_RestoreInterrupts
	ldr r1, [sp]
_020C5548:
	add r0, sp, #8
	ldrb r0, [r0, r1]
	add r1, r1, #1
	cmp r0, #0
	strneb r0, [r10, r7]
	addne r7, r7, #1
	cmp r7, r9
	blt _020C54D0
	add sp, sp, #0x7c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C5574: .word 0x02147060
_020C5578: .word 0x0214589C
_020C557C: .word 0x02147068
_020C5580: .word 0x0214707B
	arm_func_end sub_20C543C

	arm_func_start sub_20C5584
sub_20C5584: // 0x020C5584
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r4, [r5, #0xc]
	add r6, sp, #0
_020C5598:
	mov r0, r6
	mov r1, r5
	bl sub_20C071C
	ldr r1, [sp]
	cmp r1, #0
	moveq r0, #9
	addeq sp, sp, #8
	streqb r0, [r4, #0x455]
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	cmp r1, #5
	blo _020C5598
	ldrb r1, [r0]
	cmp r1, #0x80
	bne _020C5690
	ldrb r1, [r4, #0x454]
	cmp r1, #0
	beq _020C5684
	ldrb r1, [r4, #0x455]
	cmp r1, #0
	bne _020C5684
	ldrb r2, [r0, #1]
	mov r1, r5
	mov r0, #2
	str r2, [sp]
	bl sub_20C05DC
	ldr r1, _020C5738 // =0x02145840
	ldr r0, [sp]
	ldr r1, [r1]
	blx r1
	movs r6, r0
	moveq r0, #9
	addeq sp, sp, #8
	streqb r0, [r4, #0x455]
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r1, [sp]
	mov r2, r5
	bl sub_20C59D0
	cmp r0, #0
	bne _020C5658
	ldrb r0, [r6]
	cmp r0, #1
	bne _020C5658
	mov r0, r4
	add r1, r6, #1
	bl sub_20C67D0
	b _020C5660
_020C5658:
	mov r0, #9
	strb r0, [r4, #0x455]
_020C5660:
	ldr r2, [sp]
	mov r0, r4
	mov r1, r6
	bl sub_20C59A0
	ldr r1, _020C573C // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	b _020C5728
_020C5684:
	mov r0, #9
	strb r0, [r4, #0x455]
	b _020C5728
_020C5690:
	ldrb r2, [r0, #3]
	ldrb r0, [r0, #4]
	ldr r1, _020C5740 // =0x00004805
	add r0, r0, r2, lsl #8
	add r0, r0, #5
	str r0, [sp]
	cmp r0, r1
	movhi r0, #9
	addhi sp, sp, #8
	strhib r0, [r4, #0x455]
	ldmhiia sp!, {r4, r5, r6, lr}
	bxhi lr
	ldr r1, _020C5738 // =0x02145840
	ldr r1, [r1]
	blx r1
	movs r6, r0
	moveq r0, #9
	addeq sp, sp, #8
	streqb r0, [r4, #0x455]
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r1, [sp]
	mov r2, r5
	bl sub_20C59D0
	cmp r0, #0
	beq _020C571C
	ldr r1, _020C573C // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	mov r0, #9
	add sp, sp, #8
	strb r0, [r4, #0x455]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C571C:
	mov r0, r4
	mov r1, r6
	bl sub_20C5744
_020C5728:
	ldrb r0, [r4, #0x455]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C5738: .word 0x02145840
_020C573C: .word 0x0214586C
_020C5740: .word 0x00004805
	arm_func_end sub_20C5584

	arm_func_start sub_20C5744
sub_20C5744: // 0x020C5744
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldrb r0, [r8, #0x455]
	mov r7, r1
	cmp r0, #9
	bne _020C5774
	ldr r1, _020C599C // =0x0214586C
	mov r0, r7
	ldr r1, [r1]
	blx r1
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020C5774:
	ldrb r2, [r7, #3]
	ldrb r1, [r7, #4]
	add r0, r0, #0xf9
	and r0, r0, #0xff
	add r1, r1, r2, lsl #8
	cmp r0, #1
	add r5, r1, #5
	ldrb r4, [r7]
	bhi _020C57A0
	cmp r4, #0x15
	bne _020C57B0
_020C57A0:
	cmp r4, #0x15
	bne _020C57C0
	cmp r5, #7
	bls _020C57C0
_020C57B0:
	mov r0, r8
	mov r1, r7
	bl sub_20C5C64
	mov r5, r0
_020C57C0:
	sub r0, r4, #0x14
	cmp r0, #3
	add r6, r7, #5
	sub r5, r5, #5
	addls pc, pc, r0, lsl #2
	b _020C597C
_020C57D8: // jump table
	b _020C57E8 // case 0
	b _020C5818 // case 1
	b _020C582C // case 2
	b _020C5958 // case 3
_020C57E8:
	ldr r0, [r8, #0x1d4]
	cmp r0, #0
	moveq r0, #9
	streqb r0, [r8, #0x455]
	beq _020C5984
	add r0, r8, #0x2e4
	mov r1, #0
	mov r2, #8
	bl MI_CpuFill8
	mov r0, #7
	strb r0, [r8, #0x455]
	b _020C5984
_020C5818:
	ldrb r0, [r6]
	cmp r0, #2
	moveq r0, #9
	streqb r0, [r8, #0x455]
	b _020C5984
_020C582C:
	ldrb r1, [r6, #1]
	ldrb r0, [r6, #2]
	ldrb r3, [r6]
	ldrb r2, [r6, #3]
	mov r1, r1, lsl #0x10
	add r0, r1, r0, lsl #8
	cmp r3, #0xb
	add r4, r2, r0
	add r6, r6, #4
	bgt _020C5880
	cmp r3, #0xb
	bge _020C58F4
	cmp r3, #2
	bgt _020C5920
	cmp r3, #1
	blt _020C5920
	cmp r3, #1
	beq _020C58AC
	cmp r3, #2
	beq _020C58E4
	b _020C5920
_020C5880:
	cmp r3, #0x14
	bgt _020C5920
	cmp r3, #0xe
	blt _020C5920
	cmp r3, #0xe
	beq _020C5904
	cmp r3, #0x10
	beq _020C58D4
	cmp r3, #0x14
	beq _020C5910
	b _020C5920
_020C58AC:
	ldrb r0, [r8, #0x454]
	cmp r0, #0
	beq _020C5928
	ldrb r0, [r8, #0x455]
	cmp r0, #0
	bne _020C5928
	mov r0, r8
	mov r1, r6
	bl sub_20C672C
	b _020C5928
_020C58D4:
	mov r0, r8
	mov r1, r6
	bl sub_20C6178
	b _020C5928
_020C58E4:
	mov r0, r8
	mov r1, r6
	bl sub_20C6970
	b _020C5928
_020C58F4:
	mov r0, r8
	mov r1, r6
	bl sub_20C6A38
	b _020C5928
_020C5904:
	mov r0, #4
	strb r0, [r8, #0x455]
	b _020C5928
_020C5910:
	mov r0, r8
	mov r1, r6
	bl sub_20C5EE0
	b _020C5928
_020C5920:
	mov r0, #9
	strb r0, [r8, #0x455]
_020C5928:
	mov r0, r8
	sub r1, r6, #4
	add r2, r4, #4
	bl sub_20C59A0
	add r0, r4, #4
	add r6, r6, r4
	subs r5, r5, r0
	beq _020C5984
	ldrb r0, [r8, #0x455]
	cmp r0, #9
	bne _020C582C
	b _020C5984
_020C5958:
	str r7, [r8, #0x824]
	mov r0, #5
	str r0, [r8, #0x82c]
	add r0, r5, #5
	str r0, [r8, #0x828]
	mov r0, #1
	strb r0, [r8, #0x456]
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020C597C:
	mov r0, #9
	strb r0, [r8, #0x455]
_020C5984:
	ldr r1, _020C599C // =0x0214586C
	mov r0, r7
	ldr r1, [r1]
	blx r1
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C599C: .word 0x0214586C
	arm_func_end sub_20C5744

	arm_func_start sub_20C59A0
sub_20C59A0: // 0x020C59A0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	add r0, r6, #0x2ec
	bl sub_20C8168
	mov r1, r5
	mov r2, r4
	add r0, r6, #0x3a4
	bl sub_20C7B28
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C59A0

	arm_func_start sub_20C59D0
sub_20C59D0: // 0x020C59D0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	add r4, sp, #0
_020C59E8:
	mov r0, r4
	mov r1, r5
	bl sub_20C071C
	ldr r1, [sp]
	cmp r1, #0
	addeq sp, sp, #4
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	cmp r1, r6
	strhi r6, [sp]
	ldr r2, [sp]
	mov r1, r7
	bl MI_CpuCopy8
	ldr r0, [sp]
	mov r1, r5
	bl sub_20C05DC
	ldr r0, [sp]
	sub r6, r6, r0
	cmp r6, #0
	add r7, r7, r0
	bgt _020C59E8
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C59D0

	arm_func_start sub_20C5A50
sub_20C5A50: // 0x020C5A50
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x30
	mov r5, r1
	mov r6, r0
	ldrh r0, [r6, #0x32]
	ldrb r3, [r5, #3]
	ldrb r2, [r5, #4]
	add r1, r5, #5
	cmp r0, #4
	add r4, r2, r3, lsl #8
	add r8, r1, r4
	beq _020C5A8C
	cmp r0, #5
	beq _020C5B60
	b _020C5C30
_020C5A8C:
	add r7, r6, #0x3fc
	mov r0, r7
	bl sub_20C7BE8
	ldr r1, [r6, #0xbc]
	mov r0, r7
	mov r2, #0x10
	bl sub_20C7B28
	add r0, sp, #0
	mov r1, #0x36
	mov r2, #0x30
	bl MI_CpuFill8
	mov r0, r7
	add r1, sp, #0
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r7
	add r1, r6, #0x1cc
	mov r2, #8
	bl sub_20C7B28
	mov r0, r7
	mov r1, r5
	mov r2, #1
	bl sub_20C7B28
	mov r0, r7
	add r1, r5, #3
	add r2, r4, #2
	bl sub_20C7B28
	mov r0, r7
	mov r1, r8
	bl sub_20C7AB4
	mov r0, r7
	bl sub_20C7BE8
	ldr r1, [r6, #0xbc]
	mov r0, r7
	mov r2, #0x10
	bl sub_20C7B28
	add r0, sp, #0
	mov r1, #0x5c
	mov r2, #0x30
	bl MI_CpuFill8
	mov r0, r7
	add r1, sp, #0
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r7
	mov r1, r8
	mov r2, #0x10
	bl sub_20C7B28
	mov r0, r7
	mov r1, r8
	bl sub_20C7AB4
	add r4, r4, #0x10
	b _020C5C30
_020C5B60:
	add r7, r6, #0x348
	mov r0, r7
	bl sub_20C8228
	ldr r1, [r6, #0xbc]
	mov r0, r7
	mov r2, #0x14
	bl sub_20C8168
	add r0, sp, #0
	mov r1, #0x36
	mov r2, #0x28
	bl MI_CpuFill8
	mov r0, r7
	add r1, sp, #0
	mov r2, #0x28
	bl sub_20C8168
	mov r0, r7
	add r1, r6, #0x1cc
	mov r2, #8
	bl sub_20C8168
	mov r0, r7
	mov r1, r5
	mov r2, #1
	bl sub_20C8168
	mov r0, r7
	add r1, r5, #3
	add r2, r4, #2
	bl sub_20C8168
	mov r0, r7
	mov r1, r8
	bl sub_20C80F4
	mov r0, r7
	bl sub_20C8228
	ldr r1, [r6, #0xbc]
	mov r0, r7
	mov r2, #0x14
	bl sub_20C8168
	add r0, sp, #0
	mov r1, #0x5c
	mov r2, #0x28
	bl MI_CpuFill8
	mov r0, r7
	add r1, sp, #0
	mov r2, #0x28
	bl sub_20C8168
	mov r0, r7
	mov r1, r8
	mov r2, #0x14
	bl sub_20C8168
	mov r0, r7
	mov r1, r8
	bl sub_20C80F4
	add r4, r4, #0x14
_020C5C30:
	mov r0, r4, asr #8
	strb r0, [r5, #3]
	mov r2, r4
	add r0, r6, #0xc8
	add r1, r5, #5
	strb r4, [r5, #4]
	bl sub_20C8A28
	add r0, r6, #0x1d4
	bl sub_20C5EBC
	add r0, r4, #5
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20C5A50

	arm_func_start sub_20C5C64
sub_20C5C64: // 0x020C5C64
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x44
	mov r6, r1
	ldrb r3, [r6, #3]
	ldrb r2, [r6, #4]
	mov r7, r0
	add r1, r6, #5
	add r2, r2, r3, lsl #8
	bl sub_20C5EA0
	ldrh r1, [r7, #0x32]
	mov r5, r0
	cmp r1, #4
	beq _020C5CA4
	cmp r1, #5
	beq _020C5D88
	b _020C5E68
_020C5CA4:
	sub r5, r5, #0x10
	mov r0, r5, asr #8
	strb r0, [r6, #3]
	add r4, r7, #0x3fc
	mov r0, r4
	strb r5, [r6, #4]
	bl sub_20C7BE8
	ldr r1, [r7, #0x1d4]
	mov r0, r4
	mov r2, #0x10
	bl sub_20C7B28
	add r0, sp, #0x14
	mov r1, #0x36
	mov r2, #0x30
	bl MI_CpuFill8
	mov r0, r4
	add r1, sp, #0x14
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r4
	add r1, r7, #0x2e4
	mov r2, #8
	bl sub_20C7B28
	mov r0, r4
	mov r1, r6
	mov r2, #1
	bl sub_20C7B28
	mov r0, r4
	add r1, r6, #3
	add r2, r5, #2
	bl sub_20C7B28
	mov r0, r4
	add r1, sp, #0
	bl sub_20C7AB4
	mov r0, r4
	bl sub_20C7BE8
	ldr r1, [r7, #0x1d4]
	mov r0, r4
	mov r2, #0x10
	bl sub_20C7B28
	add r0, sp, #0x14
	mov r1, #0x5c
	mov r2, #0x30
	bl MI_CpuFill8
	mov r0, r4
	add r1, sp, #0x14
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r4
	add r1, sp, #0
	mov r2, #0x10
	bl sub_20C7B28
	mov r0, r4
	add r1, sp, #0
	bl sub_20C7AB4
	mov r4, #0x10
	b _020C5E68
_020C5D88:
	sub r5, r5, #0x14
	mov r0, r5, asr #8
	strb r0, [r6, #3]
	add r4, r7, #0x348
	mov r0, r4
	strb r5, [r6, #4]
	bl sub_20C8228
	ldr r1, [r7, #0x1d4]
	mov r0, r4
	mov r2, #0x14
	bl sub_20C8168
	add r0, sp, #0x14
	mov r1, #0x36
	mov r2, #0x28
	bl MI_CpuFill8
	mov r0, r4
	add r1, sp, #0x14
	mov r2, #0x28
	bl sub_20C8168
	mov r0, r4
	add r1, r7, #0x2e4
	mov r2, #8
	bl sub_20C8168
	mov r0, r4
	mov r1, r6
	mov r2, #1
	bl sub_20C8168
	mov r0, r4
	add r1, r6, #3
	add r2, r5, #2
	bl sub_20C8168
	mov r0, r4
	add r1, sp, #0
	bl sub_20C80F4
	mov r0, r4
	bl sub_20C8228
	ldr r1, [r7, #0x1d4]
	mov r0, r4
	mov r2, #0x14
	bl sub_20C8168
	add r0, sp, #0x14
	mov r1, #0x5c
	mov r2, #0x28
	bl MI_CpuFill8
	mov r0, r4
	add r1, sp, #0x14
	mov r2, #0x28
	bl sub_20C8168
	mov r0, r4
	add r1, sp, #0
	mov r2, #0x14
	bl sub_20C8168
	mov r0, r4
	add r1, sp, #0
	bl sub_20C80F4
	mov r4, #0x14
_020C5E68:
	add r0, r6, #5
	add r1, sp, #0
	mov r2, r4
	add r0, r0, r5
	bl memcmp
	cmp r0, #0
	movne r0, #9
	strneb r0, [r7, #0x455]
	add r0, r7, #0x2ec
	bl sub_20C5EBC
	add r0, r5, #5
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C5C64

	arm_func_start sub_20C5EA0
sub_20C5EA0: // 0x020C5EA0
	stmdb sp!, {r4, lr}
	add r0, r0, #0x1e0
	mov r4, r2
	bl sub_20C8A28
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C5EA0

	arm_func_start sub_20C5EBC
sub_20C5EBC: // 0x020C5EBC
	mov r2, #8
_020C5EC0:
	ldrb r1, [r0, #-1]!
	add r1, r1, #1
	ands r1, r1, #0xff
	strb r1, [r0]
	bxne lr
	subs r2, r2, #1
	bne _020C5EC0
	bx lr
	arm_func_end sub_20C5EBC

	arm_func_start sub_20C5EE0
sub_20C5EE0: // 0x020C5EE0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r5, r0
	mov r4, r1
	add r0, r5, #0x3a4
	add r1, r5, #0x3fc
	mov r2, #0x58
	bl MI_CpuCopy8
	add r1, sp, #0
	mov r0, r5
	mov r2, #1
	bl sub_20C6090
	add r0, r5, #0x3fc
	add r1, r5, #0x3a4
	mov r2, #0x58
	bl MI_CpuCopy8
	add r1, sp, #0
	mov r0, r4
	mov r2, #0x10
	bl memcmp
	cmp r0, #0
	movne r0, #9
	addne sp, sp, #0x14
	strneb r0, [r5, #0x455]
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	add r0, r5, #0x2ec
	add r1, r5, #0x348
	mov r2, #0x5c
	bl MI_CpuCopy8
	add r1, sp, #0
	mov r0, r5
	mov r2, #1
	bl sub_20C5FA8
	add r0, r5, #0x348
	add r1, r5, #0x2ec
	mov r2, #0x5c
	bl MI_CpuCopy8
	add r1, sp, #0
	add r0, r4, #0x10
	mov r2, #0x14
	bl memcmp
	cmp r0, #0
	movne r0, #9
	strneb r0, [r5, #0x455]
	moveq r0, #6
	streqb r0, [r5, #0x455]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20C5EE0

	arm_func_start sub_20C5FA8
sub_20C5FA8: // 0x020C5FA8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x28
	mov r6, r0
	ldrb r0, [r6, #0x454]
	mov r5, r1
	add r4, r6, #0x2ec
	eors r0, r0, r2
	beq _020C5FDC
	ldr r1, _020C6088 // =aSrvr
	mov r0, r4
	mov r2, #4
	bl sub_20C8168
	b _020C5FEC
_020C5FDC:
	ldr r1, _020C608C // =aClnt
	mov r0, r4
	mov r2, #4
	bl sub_20C8168
_020C5FEC:
	mov r0, r4
	mov r1, r6
	mov r2, #0x30
	bl sub_20C8168
	add r0, sp, #0
	mov r1, #0x36
	mov r2, #0x28
	bl MI_CpuFill8
	add r1, sp, #0
	mov r0, r4
	mov r2, #0x28
	bl sub_20C8168
	mov r0, r4
	mov r1, r5
	bl sub_20C80F4
	mov r0, r4
	bl sub_20C8228
	mov r1, r6
	mov r0, r4
	mov r2, #0x30
	bl sub_20C8168
	add r0, sp, #0
	mov r1, #0x5c
	mov r2, #0x28
	bl MI_CpuFill8
	mov r0, r4
	add r1, sp, #0
	mov r2, #0x28
	bl sub_20C8168
	mov r0, r4
	mov r1, r5
	mov r2, #0x14
	bl sub_20C8168
	mov r0, r4
	mov r1, r5
	bl sub_20C80F4
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C6088: .word aSrvr
_020C608C: .word aClnt
	arm_func_end sub_20C5FA8

	arm_func_start sub_20C6090
sub_20C6090: // 0x020C6090
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x30
	mov r6, r0
	ldrb r0, [r6, #0x454]
	mov r5, r1
	add r4, r6, #0x3a4
	eors r0, r0, r2
	beq _020C60C4
	ldr r1, _020C6170 // =aSrvr
	mov r0, r4
	mov r2, #4
	bl sub_20C7B28
	b _020C60D4
_020C60C4:
	ldr r1, _020C6174 // =aClnt
	mov r0, r4
	mov r2, #4
	bl sub_20C7B28
_020C60D4:
	mov r0, r4
	mov r1, r6
	mov r2, #0x30
	bl sub_20C7B28
	add r0, sp, #0
	mov r1, #0x36
	mov r2, #0x30
	bl MI_CpuFill8
	add r1, sp, #0
	mov r0, r4
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r4
	mov r1, r5
	bl sub_20C7AB4
	mov r0, r4
	bl sub_20C7BE8
	mov r1, r6
	mov r0, r4
	mov r2, #0x30
	bl sub_20C7B28
	add r0, sp, #0
	mov r1, #0x5c
	mov r2, #0x30
	bl MI_CpuFill8
	mov r0, r4
	add r1, sp, #0
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r4
	mov r1, r5
	mov r2, #0x10
	bl sub_20C7B28
	mov r0, r4
	mov r1, r5
	bl sub_20C7AB4
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C6170: .word aSrvr
_020C6174: .word aClnt
	arm_func_end sub_20C6090

	arm_func_start sub_20C6178
sub_20C6178: // 0x020C6178
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x81c]
	bl sub_20C64CC
	mov r0, r4
	bl sub_20C63C0
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl sub_20C7864
	mov r0, r4
	bl sub_20C61B8
	mov r0, #5
	strb r0, [r4, #0x455]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C6178

	arm_func_start sub_20C61B8
sub_20C61B8: // 0x020C61B8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	mov r10, r0
	ldrh r0, [r10, #0x32]
	cmp r0, #4
	beq _020C61EC
	cmp r0, #5
	moveq r0, #0x14
	streq r0, [sp]
	moveq r0, #0x10
	streq r0, [sp, #4]
	moveq r2, #0
	b _020C61FC
_020C61EC:
	mov r0, #0x10
	str r0, [sp]
	str r0, [sp, #4]
	mov r2, #0
_020C61FC:
	ldr r1, [sp]
	ldr r0, [sp, #4]
	mov r9, #0
	add r0, r1, r0
	add r0, r2, r0
	mov r0, r0, lsl #1
	str r0, [sp, #8]
	cmp r0, #0
	ble _020C6314
	mov r0, #0x20
	str r0, [sp, #0x10]
	mov r0, #0x14
	mov r6, r9
	add r5, sp, #0x18
	str r9, [sp, #0xc]
	mov r4, #1
	mov r11, #0x30
	str r0, [sp, #0x14]
_020C6244:
	add r7, r10, #0x348
	mov r0, r7
	bl sub_20C8228
	add r0, r9, #0x41
	strb r0, [sp, #0x18]
	add r0, r9, #1
	ldr r8, [sp, #0xc]
	cmp r0, #0
	ble _020C6288
_020C6268:
	mov r0, r7
	mov r1, r5
	mov r2, r4
	bl sub_20C8168
	add r8, r8, #1
	add r0, r9, #1
	cmp r8, r0
	blt _020C6268
_020C6288:
	mov r0, r7
	mov r1, r10
	mov r2, r11
	bl sub_20C8168
	ldr r2, [sp, #0x10]
	mov r0, r7
	add r1, r10, #0x54
	bl sub_20C8168
	ldr r2, [sp, #0x10]
	mov r0, r7
	add r1, r10, #0x34
	bl sub_20C8168
	mov r0, r7
	add r1, sp, #0x19
	bl sub_20C80F4
	add r7, r10, #0x3fc
	mov r0, r7
	bl sub_20C7BE8
	mov r0, r7
	mov r1, r10
	mov r2, r11
	bl sub_20C7B28
	ldr r2, [sp, #0x14]
	mov r0, r7
	add r1, sp, #0x19
	bl sub_20C7B28
	add r1, r10, #0x74
	mov r0, r7
	add r1, r1, r6
	bl sub_20C7AB4
	ldr r0, [sp, #8]
	add r6, r6, #0x10
	cmp r6, r0
	add r9, r9, #1
	blt _020C6244
_020C6314:
	ldrb r0, [r10, #0x454]
	cmp r0, #0
	beq _020C635C
	add r1, r10, #0x74
	str r1, [r10, #0x1d4]
	ldr r0, [sp]
	ldr r2, [r10, #0x1d4]
	add r1, r1, r0
	add r0, r2, r0, lsl #1
	str r0, [r10, #0x1d8]
	str r1, [r10, #0xbc]
	ldr r1, [r10, #0xbc]
	ldr r0, [sp]
	add r1, r1, r0
	ldr r0, [sp, #4]
	add r0, r1, r0
	str r0, [r10, #0xc0]
	b _020C6394
_020C635C:
	add r1, r10, #0x74
	str r1, [r10, #0xbc]
	ldr r0, [sp]
	ldr r2, [r10, #0xbc]
	add r1, r1, r0
	add r0, r2, r0, lsl #1
	str r0, [r10, #0xc0]
	str r1, [r10, #0x1d4]
	ldr r1, [r10, #0x1d4]
	ldr r0, [sp]
	add r1, r1, r0
	ldr r0, [sp, #4]
	add r0, r1, r0
	str r0, [r10, #0x1d8]
_020C6394:
	ldr r1, [r10, #0x1d8]
	add r0, r10, #0x1e0
	mov r2, #0x10
	bl sub_20C8A98
	ldr r1, [r10, #0xc0]
	add r0, r10, #0xc8
	mov r2, #0x10
	bl sub_20C8A98
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	arm_func_end sub_20C61B8

	arm_func_start sub_20C63C0
sub_20C63C0: // 0x020C63C0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x30
	mov r4, r0
	ldr r1, _020C6418 // =aA
	add r0, sp, #0
	mov r2, r4
	bl sub_20C6424
	ldr r1, _020C641C // =aBb
	add r0, sp, #0x10
	mov r2, r4
	bl sub_20C6424
	ldr r1, _020C6420 // =aCcc
	add r0, sp, #0x20
	mov r2, r4
	bl sub_20C6424
	add r0, sp, #0
	mov r1, r4
	mov r2, #0x30
	bl MI_CpuCopy8
	add sp, sp, #0x30
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C6418: .word aA
_020C641C: .word aBb
_020C6420: .word aCcc
	arm_func_end sub_20C63C0

	arm_func_start sub_20C6424
sub_20C6424: // 0x020C6424
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r5, r2
	add r4, r5, #0x348
	mov r7, r0
	mov r6, r1
	mov r0, r4
	bl sub_20C8228
	mov r0, r6
	bl strlen
	mov r2, r0
	mov r1, r6
	mov r0, r4
	bl sub_20C8168
	mov r0, r4
	mov r1, r5
	mov r2, #0x30
	bl sub_20C8168
	mov r0, r4
	add r1, r5, #0x34
	mov r2, #0x40
	bl sub_20C8168
	mov r0, r4
	add r1, sp, #0
	bl sub_20C80F4
	add r4, r5, #0x3fc
	mov r0, r4
	bl sub_20C7BE8
	mov r1, r5
	mov r0, r4
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r4
	add r1, sp, #0
	mov r2, #0x14
	bl sub_20C7B28
	mov r0, r4
	mov r1, r7
	bl sub_20C7AB4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C6424

	arm_func_start sub_20C64CC
sub_20C64CC: // 0x020C64CC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	movs r10, r2
	str r0, [sp, #8]
	mov r11, r1
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldr r0, [r10]
	cmp r0, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	mov r0, r0, lsl #1
	add r0, r0, r0, lsr #31
	mov r0, r0, asr #1
	add r9, r0, #1
	mov r0, #0x14
	mul r0, r9, r0
	ldr r1, _020C6724 // =0x02145840
	ldr r1, [r1]
	blx r1
	movs r8, r0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	add r7, r8, r9, lsl #1
	add r6, r7, r9, lsl #1
	add r1, r6, r9, lsl #1
	str r1, [sp, #0xc]
	add r1, r1, r9, lsl #1
	add r5, r1, r9, lsl #1
	str r1, [sp, #0x10]
	ldr r2, [r10]
	add r4, r5, r9, lsl #1
	mov r1, r11
	mov r3, r9
	add r11, r4, r9, lsl #1
	bl sub_20C8BAC
	ldr r1, [r10, #0x1c]
	ldr r2, [r10, #0x18]
	mov r0, r7
	mov r3, r9
	bl sub_20C8BAC
	ldr r1, [r10, #0xc]
	ldr r2, [r10, #8]
	mov r0, r5
	mov r3, r9
	bl sub_20C8BAC
	bl sub_20C7748
	str r0, [sp, #0x14]
	ldr r0, [sp, #0xc]
	str r5, [sp]
	mov r1, r8
	mov r2, r7
	mov r3, r9
	bl sub_20C8C0C
	ldr r1, [r10, #0x24]
	ldr r2, [r10, #0x20]
	mov r0, r7
	mov r3, r9
	bl sub_20C8BAC
	ldr r1, [r10, #0x14]
	ldr r2, [r10, #0x10]
	mov r0, r5
	mov r3, r9
	bl sub_20C8BAC
	ldr r0, [sp, #0x10]
	mov r1, r8
	mov r2, r7
	mov r3, r9
	str r5, [sp]
	bl sub_20C8C0C
	ldr r0, [sp, #0x14]
	bl sub_20C7710
	ldr r1, [sp, #0xc]
	ldr r2, [sp, #0x10]
	mov r0, r8
	mov r3, r9
	bl sub_20C9818
	ldr r1, [r10, #0x2c]
	ldr r2, [r10, #0x28]
	mov r0, r7
	mov r3, r9
	bl sub_20C8BAC
	mov r0, r6
	mov r1, r8
	mov r2, r7
	mov r3, r9
	bl sub_20C9664
	ldr r1, [r10, #0x14]
	ldr r2, [r10, #0x10]
	mov r0, r7
	mov r3, r9
	bl sub_20C8BAC
	mov r0, r8
	mov r1, r6
	mov r2, r7
	mov r3, r9
	bl sub_20C9664
	ldr r2, [sp, #0x10]
	mov r0, r6
	mov r1, r8
	mov r3, r9
	bl sub_20C998C
	ldr r1, [r10, #4]
	ldr r2, [r10]
	mov r0, r7
	mov r3, r9
	bl sub_20C8BAC
	mov r0, r6
	mov r1, r9
	bl sub_20C9A38
	cmp r0, #0
	bge _020C66D8
	mov r0, r6
	mov r1, r9
	bl sub_20C98D0
	str r9, [sp]
	mov r1, r6
	mov r2, r7
	mov r3, r4
	mov r0, #0
	str r11, [sp, #4]
	bl sub_20C929C
	mov r0, r4
	mov r1, r7
	mov r2, r4
	mov r3, r9
	bl sub_20C9818
	b _020C66F4
_020C66D8:
	str r9, [sp]
	mov r1, r6
	mov r2, r7
	mov r3, r4
	mov r0, #0
	str r11, [sp, #4]
	bl sub_20C929C
_020C66F4:
	ldr r0, [sp, #8]
	mov r1, r4
	mov r3, r9
	mov r2, #0x30
	bl sub_20C8B64
	ldr r1, _020C6728 // =0x0214586C
	mov r0, r8
	ldr r1, [r1]
	blx r1
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C6724: .word 0x02145840
_020C6728: .word 0x0214586C
	arm_func_end sub_20C64CC

	arm_func_start sub_20C672C
sub_20C672C: // 0x020C672C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	mov r4, r0
	ldrb r0, [r6]
	ldrb r1, [r6, #1]
	bl sub_20C68A8
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	add r0, r6, #2
	add r1, r4, #0x34
	mov r2, #0x20
	bl MI_CpuCopy8
	ldrb r5, [r6, #0x22]
	add r6, r6, #0x23
	cmp r5, #0x20
	movne r0, #0
	strneb r0, [r4, #0x30]
	bne _020C6790
	mov r0, r6
	add r1, r4, #0x74
	mov r2, #0x20
	bl MI_CpuCopy8
	mov r0, r4
	bl sub_20C7A0C
_020C6790:
	add r0, r6, r5
	ldrb r1, [r0, #1]
	ldrb r3, [r6, r5]
	add r0, r0, #2
	mov r2, #2
	add r1, r1, r3, lsl #8
	add r1, r1, r1, lsr #31
	mov r1, r1, asr #1
	bl sub_20C68B8
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	strh r0, [r4, #0x32]
	movne r0, #1
	strneb r0, [r4, #0x455]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C672C

	arm_func_start sub_20C67D0
sub_20C67D0: // 0x020C67D0
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r6, r0
	ldrb r0, [r5]
	ldrb r1, [r5, #1]
	bl sub_20C68A8
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldrb r2, [r5, #2]
	ldrb r1, [r5, #3]
	ldr r3, _020C68A4 // =0x55555556
	add r0, r5, #8
	add r4, r1, r2, lsl #8
	smull r2, r1, r3, r4
	add r1, r1, r4, lsr #31
	mov r2, #3
	bl sub_20C68B8
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	strh r0, [r6, #0x32]
	ldrb ip, [r5, #4]
	ldrb r0, [r5, #5]
	ldrb r3, [r5, #6]
	ldrb r2, [r5, #7]
	mov r1, #0
	add ip, r0, ip, lsl #8
	add r0, r4, #8
	add r4, r2, r3, lsl #8
	add r0, r0, ip
	strb r1, [r6, #0x30]
	cmp r4, #0x20
	add r5, r5, r0
	blt _020C6874
	mov r0, r5
	add r1, r6, #0x34
	mov r2, #0x20
	bl MI_CpuCopy8
	b _020C6894
_020C6874:
	add r0, r6, #0x34
	rsb r2, r4, #0x20
	bl MI_CpuFill8
	add r1, r6, #0x54
	mov r0, r5
	mov r2, r4
	sub r1, r1, r4
	bl MI_CpuCopy8
_020C6894:
	mov r0, #1
	strb r0, [r6, #0x455]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C68A4: .word 0x55555556
	arm_func_end sub_20C67D0

	arm_func_start sub_20C68A8
sub_20C68A8: // 0x020C68A8
	cmp r0, #3
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end sub_20C68A8

	arm_func_start sub_20C68B8
sub_20C68B8: // 0x020C68B8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, #0
	ldr r4, _020C6918 // =0x0211F1E0
_020C68D0:
	mov r0, r5, lsl #1
	ldrh r3, [r4, r0]
	mov r0, r8
	mov r1, r7
	mov r2, r6
	bl sub_20C691C
	cmp r0, #0
	ldrne r0, _020C6918 // =0x0211F1E0
	movne r1, r5, lsl #1
	ldrneh r0, [r0, r1]
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	add r5, r5, #1
	cmp r5, #2
	blo _020C68D0
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C6918: .word 0x0211F1E0
	arm_func_end sub_20C68B8

	arm_func_start sub_20C691C
sub_20C691C: // 0x020C691C
	stmdb sp!, {r4, lr}
	cmp r1, #0
	mov r4, #0
	ble _020C6964
_020C692C:
	ldrb lr, [r0]
	ldrb ip, [r0, #1]
	cmp r2, #3
	add lr, ip, lr, lsl #8
	ldreqb ip, [r0, #2]
	addeq lr, ip, lr, lsl #8
	cmp lr, r3
	moveq r0, #1
	ldmeqia sp!, {r4, lr}
	bxeq lr
	add r4, r4, #1
	cmp r4, r1
	add r0, r0, r2
	blt _020C692C
_020C6964:
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C691C

	arm_func_start sub_20C6970
sub_20C6970: // 0x020C6970
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	mov r5, r1
	add r0, r5, #2
	add r1, r6, #0x54
	mov r2, #0x20
	bl MI_CpuCopy8
	add r0, r5, #0x22
	ldrb r7, [r6, #0x30]
	add r5, r5, #0x23
	ldrb r4, [r0]
	cmp r7, #0
	beq _020C69D0
	cmp r4, #0x20
	bne _020C69D0
	mov r1, r5
	add r0, r6, #0x74
	mov r2, #0x20
	bl memcmp
	cmp r0, #0
	moveq r0, #1
	streqb r0, [r6, #0x31]
	beq _020C6A10
_020C69D0:
	cmp r7, #0
	beq _020C69E0
	mov r0, r6
	bl sub_20C77F4
_020C69E0:
	cmp r4, #0
	moveq r0, #0
	streqb r0, [r6, #0x30]
	beq _020C6A08
	mov r0, r5
	add r1, r6, #0x74
	mov r2, #0x20
	bl MI_CpuCopy8
	mov r0, #1
	strb r0, [r6, #0x30]
_020C6A08:
	mov r0, #0
	strb r0, [r6, #0x31]
_020C6A10:
	add r0, r5, r4
	ldrb r2, [r5, r4]
	ldrb r1, [r0, #1]
	mov r0, #2
	add r1, r1, r2, lsl #8
	strh r1, [r6, #0x32]
	strb r0, [r6, #0x455]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C6970

	arm_func_start sub_20C6A38
sub_20C6A38: // 0x020C6A38
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	ldr r1, [sp, #0x4c]
	mov r10, r0
	ldrb r4, [r1, #2]
	ldrb r3, [r1]
	ldrb r2, [r1, #1]
	add r0, r1, #3
	mvn r1, #0
	str r0, [sp, #0x4c]
	add r2, r2, r3, lsl #8
	add r0, sp, #0x14
	str r1, [r10, #0x45c]
	add r7, r4, r2, lsl #8
	bl RTC_GetDate
	mov r8, #0
	ldr r0, [sp, #0x14]
	ldr r2, [sp, #0x1c]
	add r1, r0, #0x7d0
	ldr r0, [sp, #0x18]
	mov r1, r1, lsl #0x10
	add r0, r1, r0, lsl #8
	add r0, r2, r0
	str r0, [r10, #0x80c]
	strb r8, [r10, #0x6b0]
	str r8, [r10, #0x5a0]
	ldr r0, [r10, #0x5a0]
	mov r6, r8
	str r0, [r10, #0x594]
	add r0, r10, #0x7b0
	str r0, [sp, #4]
	mov r0, #1
	str r8, [sp, #8]
	mov r4, r8
	mov r11, #2
	str r0, [sp, #0xc]
	mvn r5, #0
_020C6AD0:
	ldr r1, [sp, #0x4c]
	mov r0, r10
	ldrb r2, [r1, #2]
	ldrb ip, [r1]
	ldrb r3, [r1, #1]
	add r9, r1, #3
	add r1, sp, #0x4c
	str r9, [sp, #0x4c]
	str r5, [r10, #0x458]
	strb r4, [r10, #0x5ad]
	strb r4, [r10, #0x5ac]
	strb r4, [r10, #0x5af]
	strb r4, [r10, #0x6b0]
	strb r4, [r10, #0x5b0]
	strb r4, [r10, #0x7b0]
	add r3, r3, ip, lsl #8
	ldr r9, [sp, #0x4c]
	add r3, r2, r3, lsl #8
	add r2, r3, #3
	str r9, [r10, #0x804]
	str r3, [r10, #0x808]
	sub r7, r7, r2
	mov r2, r4
	mov r3, r4
	str r8, [sp]
	bl sub_20C6FF4
	cmp r0, #0
	bne _020C6B58
	ldr r0, [r10, #0x594]
	cmp r0, #0x33
	blo _020C6B58
	ldr r0, [r10, #0x5a0]
	cmp r0, #0
	bne _020C6B70
_020C6B58:
	mov r0, #9
	add sp, sp, #0x24
	strb r0, [r10, #0x455]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_020C6B70:
	mov r0, r10
	bl sub_20C6D18
	mov r8, r0
	cmp r6, #0
	bne _020C6BA0
	ldr r0, [r10, #0x800]
	cmp r0, #0
	beq _020C6BA0
	ldr r1, [sp, #4]
	bl sub_20C6C74
	cmp r0, #0
	orrne r8, r8, #0x4000
_020C6BA0:
	and r9, r8, #0xff
	cmp r9, #1
	bne _020C6C10
	cmp r7, #0
	beq _020C6C10
	ldr r1, [sp, #0x4c]
	ldr r2, [sp, #8]
	add r1, r1, #3
	str r1, [sp, #0x10]
	ldr r1, [sp, #8]
	mov r0, r10
	strb r1, [r10, #0x5ad]
	add r1, sp, #0x10
	mov r3, r2
	str r11, [sp]
	bl sub_20C6FF4
	cmp r0, #0
	movne r0, #9
	addne sp, sp, #0x24
	strneb r0, [r10, #0x455]
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addne sp, sp, #0x10
	bxne lr
	mov r0, r10
	add r1, r10, #0x480
	bl sub_20C6E18
	bic r1, r8, #0xff
	orr r8, r1, r0
_020C6C10:
	ldr r3, [r10, #0x810]
	cmp r3, #0
	beq _020C6C30
	mov r0, r8
	mov r1, r10
	mov r2, r6
	blx r3
	mov r8, r0
_020C6C30:
	cmp r9, #0
	add r6, r6, #1
	beq _020C6C50
	cmp r8, #0
	bne _020C6C50
	cmp r7, #0
	ldrne r8, [sp, #0xc]
	bne _020C6AD0
_020C6C50:
	cmp r8, #0
	moveq r0, #3
	streqb r0, [r10, #0x455]
	movne r0, #9
	strneb r0, [r10, #0x455]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20C6A38

	arm_func_start sub_20C6C74
sub_20C6C74: // 0x020C6C74
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	b _020C6C94
_020C6C84:
	cmp r1, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
_020C6C94:
	ldrsb r0, [r5], #1
	ldrsb r1, [r6], #1
	cmp r1, r0
	beq _020C6C84
	cmp r0, #0x2a
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	sub r6, r6, #1
	mov r0, r6
	bl sub_20C6CF0
	mov r4, r0
	mov r0, r5
	bl sub_20C6CF0
	cmp r0, r4
	movgt r0, #1
	ldmgtia sp!, {r4, r5, r6, lr}
	bxgt lr
	sub r0, r4, r0
	add r6, r6, r0
	b _020C6C94
	arm_func_end sub_20C6C74

	arm_func_start sub_20C6CE8
sub_20C6CE8: // 0x020C6CE8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C6CE8

	arm_func_start sub_20C6CF0
sub_20C6CF0: // 0x020C6CF0
	mov r2, r0
	b _020C6CFC
_020C6CF8:
	add r0, r0, #1
_020C6CFC:
	ldrsb r1, [r0]
	cmp r1, #0x2e
	beq _020C6D10
	cmp r1, #0
	bne _020C6CF8
_020C6D10:
	sub r0, r0, r2
	bx lr
	arm_func_end sub_20C6CF0

	arm_func_start sub_20C6D18
sub_20C6D18: // 0x020C6D18
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldrb r0, [r5, #0x5af]
	ldr r1, [r5, #0x45c]
	cmp r0, #0
	movne r4, #0
	moveq r4, #0x8000
	mvn r0, #0
	cmp r1, r0
	orreq r0, r4, #4
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r0, [r5, #0x458]
	cmp r0, #3
	beq _020C6D60
	cmp r0, #4
	beq _020C6D9C
	b _020C6DD8
_020C6D60:
	add r6, r5, #0x3fc
	mov r0, r6
	bl sub_20C7BE8
	ldr r1, [r5, #0x460]
	ldr r2, [r5, #0x464]
	mov r0, r6
	sub r2, r2, r1
	bl sub_20C7B28
	ldr r1, _020C6E14 // =0x00000468
	mov r0, r6
	add r1, r5, r1
	bl sub_20C7AB4
	mov r0, #0x10
	str r0, [r5, #0x47c]
	b _020C6DE4
_020C6D9C:
	add r6, r5, #0x348
	mov r0, r6
	bl sub_20C8228
	ldr r1, [r5, #0x460]
	ldr r2, [r5, #0x464]
	mov r0, r6
	sub r2, r2, r1
	bl sub_20C8168
	ldr r1, _020C6E14 // =0x00000468
	mov r0, r6
	add r1, r5, r1
	bl sub_20C80F4
	mov r0, #0x14
	str r0, [r5, #0x47c]
	b _020C6DE4
_020C6DD8:
	orr r0, r4, #3
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C6DE4:
	mov r0, r5
	add r1, r5, #0x5b0
	bl sub_20C7684
	movs r1, r0
	orreq r0, r4, #1
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	mov r0, r5
	bl sub_20C6E18
	orr r0, r4, r0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C6E14: .word 0x00000468
	arm_func_end sub_20C6D18

	arm_func_start sub_20C6E18
sub_20C6E18: // 0x020C6E18
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	mov r8, r0
	ldr r0, [r8, #0x5a4]
	mov r7, r1
	cmp r0, #0
	beq _020C6E70
	ldr r0, [r8, #0x5a8]
	cmp r0, #0
	beq _020C6E70
	ldr r0, [r7, #0x10]
	cmp r0, #0
	beq _020C6E70
	ldr r0, [r7, #0xc]
	cmp r0, #0
	beq _020C6E70
	ldr r0, [r7, #8]
	cmp r0, #0
	beq _020C6E70
	ldr r0, [r7, #4]
	cmp r0, #0
	bne _020C6E80
_020C6E70:
	add sp, sp, #8
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
_020C6E80:
	mov r0, r0, lsl #1
	ldr r1, _020C6FE8 // =0x02145840
	add r0, r0, r0, lsr #31
	mov r4, r0, asr #1
	ldr r1, [r1]
	mov r0, r4, lsl #3
	blx r1
	movs r6, r0
	addeq sp, sp, #8
	moveq r0, #2
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bxeq lr
	add r5, r6, r4, lsl #1
	add r10, r5, r4, lsl #1
	ldr r1, [r8, #0x5a4]
	ldr r2, [r8, #0x5a8]
	mov r0, r5
	mov r3, r4
	add r9, r10, r4, lsl #1
	bl sub_20C8BAC
	ldr r1, [r7, #0x10]
	ldr r2, [r7, #0xc]
	mov r0, r10
	mov r3, r4
	bl sub_20C8BAC
	mov r0, r9
	ldr r1, [r7, #8]
	ldr r2, [r7, #4]
	mov r3, r4
	bl sub_20C8BAC
	bl sub_20C7748
	str r9, [sp]
	mov r2, r10
	mov r9, r0
	mov r0, r6
	mov r1, r5
	mov r3, r4
	bl sub_20C90D8
	mov r0, r9
	bl sub_20C7710
	mov r0, r5
	mov r1, r6
	ldr r2, [r7, #4]
	mov r3, r4
	bl sub_20C8B64
	ldrb r0, [r6, r4, lsl #1]
	mov r4, #0
	cmp r0, #0
	bne _020C6F50
	ldrb r0, [r5, #1]
	cmp r0, #1
	beq _020C6F58
_020C6F50:
	mov r4, #2
	b _020C6FC8
_020C6F58:
	ldr r3, [r7, #4]
	mov r2, #2
	cmp r3, #2
	ble _020C6F80
_020C6F68:
	ldrb r0, [r5, r2]
	cmp r0, #0xff
	bne _020C6F80
	add r2, r2, #1
	cmp r2, r3
	blt _020C6F68
_020C6F80:
	add r1, r2, #1
	cmp r1, r3
	bge _020C6FC4
	ldrb r0, [r5, r2]
	cmp r0, #0
	bne _020C6FC4
	ldrb r0, [r5, r1]
	cmp r0, #0x30
	bne _020C6FC4
	ldr r0, _020C6FEC // =0x00000468
	ldr r2, [r8, #0x47c]
	add r1, r5, r3
	add r0, r8, r0
	sub r1, r1, r2
	bl memcmp
	cmp r0, #0
	beq _020C6FC8
_020C6FC4:
	mov r4, #2
_020C6FC8:
	ldr r1, _020C6FF0 // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_020C6FE8: .word 0x02145840
_020C6FEC: .word 0x00000468
_020C6FF0: .word 0x0214586C
	arm_func_end sub_20C6E18

	arm_func_start sub_20C6FF4
sub_20C6FF4: // 0x020C6FF4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	str r1, [sp, #4]
	ldr r1, [r1]
	mov r9, r0
	str r1, [sp, #8]
	add r0, r1, #1
	str r0, [sp, #8]
	add r0, sp, #8
	mov r5, r2
	mov r4, r3
	ldr r8, [sp, #0x30]
	ldrb r6, [r1]
	bl sub_20C7634
	movs r7, r0
	bmi _020C703C
	cmp r7, #0x7d0
	ble _020C704C
_020C703C:
	add sp, sp, #0xc
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020C704C:
	and r1, r6, #0x1f
	cmp r1, #0x18
	addls pc, pc, r1, lsl #2
	b _020C748C
_020C705C: // jump table
	b _020C748C // case 0
	b _020C748C // case 1
	b _020C70C0 // case 2
	b _020C71B8 // case 3
	b _020C748C // case 4
	b _020C748C // case 5
	b _020C7238 // case 6
	b _020C748C // case 7
	b _020C748C // case 8
	b _020C748C // case 9
	b _020C748C // case 10
	b _020C748C // case 11
	b _020C72D0 // case 12
	b _020C748C // case 13
	b _020C748C // case 14
	b _020C748C // case 15
	b _020C73A4 // case 16
	b _020C7434 // case 17
	b _020C748C // case 18
	b _020C72D0 // case 19
	b _020C72D0 // case 20
	b _020C748C // case 21
	b _020C72D0 // case 22
	b _020C7350 // case 23
	b _020C7350 // case 24
_020C70C0:
	ldrb r0, [r9, #0x5ad]
	cmp r0, #0
	beq _020C71A8
	cmp r4, #0
	bne _020C713C
	ldr r0, [sp, #8]
	ldrb r1, [r0]
	cmp r1, #0
	bne _020C7100
_020C70E4:
	ldr r1, [sp, #8]
	sub r7, r7, #1
	add r0, r1, #1
	str r0, [sp, #8]
	ldrb r1, [r1, #1]
	cmp r1, #0
	beq _020C70E4
_020C7100:
	cmp r8, #0
	beq _020C711C
	cmp r8, #2
	streq r7, [r9, #0x484]
	ldreq r0, [sp, #8]
	streq r0, [r9, #0x488]
	b _020C71A8
_020C711C:
	cmp r7, #0x100
	bgt _020C71A8
	ldr r1, _020C7514 // =0x00000494
	mov r2, r7
	add r1, r9, r1
	bl MI_CpuCopy8
	str r7, [r9, #0x594]
	b _020C71A8
_020C713C:
	cmp r4, #1
	bne _020C71A8
	ldr r0, [sp, #8]
	ldrb r1, [r0]
	cmp r1, #0
	bne _020C7170
_020C7154:
	ldr r1, [sp, #8]
	sub r7, r7, #1
	add r0, r1, #1
	str r0, [sp, #8]
	ldrb r1, [r1, #1]
	cmp r1, #0
	beq _020C7154
_020C7170:
	cmp r8, #0
	beq _020C718C
	cmp r8, #2
	streq r7, [r9, #0x48c]
	ldreq r0, [sp, #8]
	streq r0, [r9, #0x490]
	b _020C71A8
_020C718C:
	cmp r7, #8
	bgt _020C71A8
	ldr r1, _020C7518 // =0x00000598
	mov r2, r7
	add r1, r9, r1
	bl MI_CpuCopy8
	str r7, [r9, #0x5a0]
_020C71A8:
	ldr r0, [sp, #8]
	add r0, r0, r7
	str r0, [sp, #8]
	b _020C74F8
_020C71B8:
	cmp r5, #1
	bne _020C71D8
	cmp r8, #2
	ldrne r1, [sp, #8]
	subne r0, r7, #1
	addne r1, r1, #1
	strne r1, [r9, #0x5a4]
	strne r0, [r9, #0x5a8]
_020C71D8:
	ldrb r0, [r9, #0x5ad]
	cmp r0, #0
	beq _020C7228
	ldr r0, [sp, #8]
	add r1, sp, #8
	add r0, r0, #1
	str r0, [sp, #8]
	mov r0, r9
	mov r2, r5
	mov r3, #0
	str r8, [sp]
	bl sub_20C6FF4
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	mov r0, #0
	strb r0, [r9, #0x5ad]
	b _020C74F8
_020C7228:
	ldr r0, [sp, #8]
	add r0, r0, r7
	str r0, [sp, #8]
	b _020C74F8
_020C7238:
	ldr r5, [sp, #8]
	mov r6, #0
	ldr r10, _020C751C // =0x0211F21C
_020C7244:
	ldr r4, [r10, r6, lsl #2]
	mov r0, r4
	bl strlen
	mov r2, r0
	mov r0, r5
	mov r1, r4
	bl memcmp
	cmp r0, #0
	bne _020C72B4
	cmp r6, #5
	addls pc, pc, r6, lsl #2
	b _020C72C0
_020C7274: // jump table
	b _020C72C0 // case 0
	b _020C728C // case 1
	b _020C728C // case 2
	b _020C729C // case 3
	b _020C729C // case 4
	b _020C72A8 // case 5
_020C728C:
	cmp r8, #0
	streq r6, [r9, #0x45c]
	strb r6, [r9, #0x5ad]
	b _020C72C0
_020C729C:
	cmp r8, #2
	strne r6, [r9, #0x458]
	b _020C72C0
_020C72A8:
	cmp r8, #2
	strneb r6, [r9, #0x5ae]
	b _020C72C0
_020C72B4:
	add r6, r6, #1
	cmp r6, #6
	blt _020C7244
_020C72C0:
	ldr r0, [sp, #8]
	add r0, r0, r7
	str r0, [sp, #8]
	b _020C74F8
_020C72D0:
	cmp r8, #2
	beq _020C7338
	ldrb r0, [r9, #0x5ac]
	cmp r0, #0
	beq _020C7328
	ldr r1, [sp, #8]
	mov r2, r7
	add r0, r9, #0x6b0
	bl sub_20C75B0
	ldrb r0, [r9, #0x5ae]
	cmp r0, #5
	bne _020C7338
	cmp r7, #0x4f
	bgt _020C7338
	ldr r0, [sp, #8]
	mov r2, r7
	add r1, r9, #0x7b0
	bl MI_CpuCopy8
	add r0, r9, r7
	mov r1, #0
	strb r1, [r0, #0x7b0]
	b _020C7338
_020C7328:
	ldr r1, [sp, #8]
	mov r2, r7
	add r0, r9, #0x5b0
	bl sub_20C75B0
_020C7338:
	mov r0, #0
	strb r0, [r9, #0x5ae]
	ldr r0, [sp, #8]
	add r0, r0, r7
	str r0, [sp, #8]
	b _020C74F8
_020C7350:
	cmp r8, #2
	beq _020C738C
	ldr r0, [sp, #8]
	bl sub_20C7520
	cmp r4, #0
	bne _020C737C
	ldr r1, [r9, #0x80c]
	cmp r1, r0
	movhs r0, #1
	strhsb r0, [r9, #0x5af]
	b _020C738C
_020C737C:
	ldr r1, [r9, #0x80c]
	cmp r1, r0
	movhi r0, #0
	strhib r0, [r9, #0x5af]
_020C738C:
	ldr r1, [sp, #8]
	mov r0, #1
	add r1, r1, r7
	str r1, [sp, #8]
	strb r0, [r9, #0x5ac]
	b _020C74F8
_020C73A4:
	cmp r5, #0
	bne _020C73C0
	cmp r4, #0
	bne _020C73C0
	cmp r8, #2
	ldrne r0, [sp, #8]
	strne r0, [r9, #0x460]
_020C73C0:
	ldr r0, [sp, #8]
	mov r10, #0
	add r7, r0, r7
	cmp r0, r7
	bhs _020C7418
	add r11, sp, #8
	add r6, r5, #1
_020C73DC:
	mov r0, r9
	mov r1, r11
	mov r2, r6
	mov r3, r10
	str r8, [sp]
	bl sub_20C6FF4
	cmp r0, #0
	add r10, r10, #1
	addne sp, sp, #0xc
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	ldr r0, [sp, #8]
	cmp r0, r7
	blo _020C73DC
_020C7418:
	cmp r5, #1
	bne _020C74F8
	cmp r4, #0
	bne _020C74F8
	cmp r8, #2
	strne r0, [r9, #0x464]
	b _020C74F8
_020C7434:
	ldr r0, [sp, #8]
	add r6, r0, r7
	cmp r0, r6
	bhs _020C74F8
	add r7, r5, #1
	add r4, sp, #8
	mov r5, #0
_020C7450:
	mov r0, r9
	mov r1, r4
	mov r2, r7
	mov r3, r5
	str r8, [sp]
	bl sub_20C6FF4
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	ldr r0, [sp, #8]
	cmp r0, r6
	blo _020C7450
	b _020C74F8
_020C748C:
	cmp r6, #0xa0
	bne _020C74EC
	ldr r0, [sp, #8]
	add r6, r0, r7
	cmp r0, r6
	bhs _020C74F8
	add r7, r5, #1
	add r4, sp, #8
	mov r5, #0
_020C74B0:
	mov r0, r9
	mov r1, r4
	mov r2, r7
	mov r3, r5
	str r8, [sp]
	bl sub_20C6FF4
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	ldr r0, [sp, #8]
	cmp r0, r6
	blo _020C74B0
	b _020C74F8
_020C74EC:
	ldr r0, [sp, #8]
	add r0, r0, r7
	str r0, [sp, #8]
_020C74F8:
	ldr r2, [sp, #8]
	ldr r1, [sp, #4]
	mov r0, #0
	str r2, [r1]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C7514: .word 0x00000494
_020C7518: .word 0x00000598
_020C751C: .word 0x0211F21C
	arm_func_end sub_20C6FF4

	arm_func_start sub_20C7520
sub_20C7520: // 0x020C7520
	stmdb sp!, {r4, lr}
	ldrb ip, [r0, #1]
	ldrb r3, [r0]
	mov r2, #0xa
	cmp r1, #0x17
	mla r1, r3, r2, ip
	sub lr, r1, #0x210
	add r0, r0, #2
	bne _020C7558
	cmp lr, #0x32
	ldrhs r1, _020C75AC // =0x0000076C
	addlo r4, lr, #0x7d0
	addhs r4, lr, r1
	b _020C7574
_020C7558:
	ldrb ip, [r0, #1]
	ldrb r3, [r0]
	mov r1, #0x64
	add r0, r0, #2
	mla r2, r3, r2, ip
	sub r2, r2, #0x210
	mla r4, lr, r1, r2
_020C7574:
	ldrb ip, [r0, #1]
	ldrb r3, [r0]
	mov r1, #0xa
	ldrb r2, [r0, #3]
	ldrb r0, [r0, #2]
	mla ip, r3, r1, ip
	mla r1, r0, r1, r2
	mov r2, r4, lsl #0x10
	sub r0, ip, #0x210
	add r2, r2, r0, lsl #8
	sub r0, r1, #0x210
	add r0, r2, r0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C75AC: .word 0x0000076C
	arm_func_end sub_20C7520

	arm_func_start sub_20C75B0
sub_20C75B0: // 0x020C75B0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrsb r3, [r0]
	mov lr, r0
	cmp r3, #0
	beq _020C7608
_020C75C8:
	ldrsb r3, [r0, #1]!
	cmp r3, #0
	bne _020C75C8
	sub r3, r0, lr
	cmp r3, #0xff
	addge sp, sp, #4
	ldmgeia sp!, {lr}
	bxge lr
	mov r3, #0x2c
	strb r3, [r0]
	mov r3, #0x20
	strb r3, [r0, #1]
	add r0, r0, #2
	b _020C7608
_020C7600:
	ldrsb r3, [r1], #1
	strb r3, [r0], #1
_020C7608:
	cmp r2, #0
	sub r2, r2, #1
	beq _020C7620
	sub r3, r0, lr
	cmp r3, #0xff
	blt _020C7600
_020C7620:
	mov r1, #0
	strb r1, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20C75B0

	arm_func_start sub_20C7634
sub_20C7634: // 0x020C7634
	ldr r1, [r0]
	ldrb r3, [r1]
	add ip, r1, #1
	ands r1, r3, #0x80
	beq _020C7678
	ands r1, r3, #0x7f
	sub r2, r1, #1
	mov r3, #0
	beq _020C7678
_020C7658:
	ands r1, r3, #0xff000000
	mvnne r0, #0
	bxne lr
	ldrb r1, [ip], #1
	cmp r2, #0
	sub r2, r2, #1
	add r3, r1, r3, lsl #8
	bne _020C7658
_020C7678:
	str ip, [r0]
	mov r0, r3
	bx lr
	arm_func_end sub_20C7634

	arm_func_start sub_20C7684
sub_20C7684: // 0x020C7684
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r4, [r0, #0x818]
	mov r7, r1
	cmp r4, #0
	mov r6, #0
	ble _020C76D4
	ldr r5, [r0, #0x814]
_020C76A4:
	ldr r0, [r5, r6, lsl #2]
	mov r1, r7
	ldr r0, [r0]
	bl strcmp
	cmp r0, #0
	addeq sp, sp, #4
	ldreq r0, [r5, r6, lsl #2]
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	add r6, r6, #1
	cmp r6, r4
	blt _020C76A4
_020C76D4:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C7684

	arm_func_start sub_20C76E4
sub_20C76E4: // 0x020C76E4
	ldr r2, _020C770C // =OSi_ThreadInfo
	ldr r2, [r2, #4]
	ldr r2, [r2, #0xa4]
	cmp r2, #0
	bxeq lr
	ldr r2, [r2, #0xc]
	cmp r2, #0
	strne r0, [r2, #0x814]
	strne r1, [r2, #0x818]
	bx lr
	.align 2, 0
_020C770C: .word OSi_ThreadInfo
	arm_func_end sub_20C76E4

	arm_func_start sub_20C7710
sub_20C7710: // 0x020C7710
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, r0
	cmp r1, #0x20
	addhs sp, sp, #4
	ldmhsia sp!, {lr}
	bxhs lr
	ldr r0, _020C7744 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	bl OS_SetThreadPriority
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C7744: .word OSi_ThreadInfo
	arm_func_end sub_20C7710

	arm_func_start sub_20C7748
sub_20C7748: // 0x020C7748
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _020C77A0 // =0x0211F1E8
	ldr r0, [r0]
	cmp r0, #0x20
	addhs sp, sp, #4
	mvnhs r0, #0
	ldmhsia sp!, {r4, r5, lr}
	bxhs lr
	ldr r0, _020C77A4 // =OSi_ThreadInfo
	ldr r5, [r0, #4]
	mov r0, r5
	bl OS_GetThreadPriority
	ldr r1, _020C77A0 // =0x0211F1E8
	mov r4, r0
	ldr r1, [r1]
	mov r0, r5
	bl OS_SetThreadPriority
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020C77A0: .word 0x0211F1E8
_020C77A4: .word OSi_ThreadInfo
	arm_func_end sub_20C7748

	arm_func_start CPS_SetSslLowThreadPriority
CPS_SetSslLowThreadPriority: // 0x020C77A8
	ldr r1, _020C77B4 // =0x0211F1E8
	str r0, [r1]
	bx lr
	.align 2, 0
_020C77B4: .word 0x0211F1E8
	arm_func_end CPS_SetSslLowThreadPriority

	arm_func_start sub_20C77B8
sub_20C77B8: // 0x020C77B8
	stmdb sp!, {lr}
	sub sp, sp, #0x1c
	add r0, sp, #0
	bl RTC_GetDate
	add r0, sp, #0x10
	bl RTC_GetTime
	add r0, sp, #0
	add r1, sp, #0x10
	bl RTC_ConvertDateTimeToSecond
	ldr r1, _020C77F0 // =0x386D4380
	add r0, r0, r1
	add sp, sp, #0x1c
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C77F0: .word 0x386D4380
	arm_func_end sub_20C77B8

	arm_func_start sub_20C77F4
sub_20C77F4: // 0x020C77F4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r6, _020C7860 // =0x0214707C
	mov r7, r0
	mov r8, #0
	add r5, r4, #0x74
	mov r4, #0x20
_020C7814:
	ldrb r0, [r6, #0x5a]
	cmp r0, #0
	beq _020C7840
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl memcmp
	cmp r0, #0
	moveq r0, #0
	streqb r0, [r6, #0x5a]
	beq _020C7850
_020C7840:
	add r8, r8, #1
	cmp r8, #4
	add r6, r6, #0x5c
	blt _020C7814
_020C7850:
	mov r0, r7
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C7860: .word 0x0214707C
	arm_func_end sub_20C77F4

	arm_func_start sub_20C7864
sub_20C7864: // 0x020C7864
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	mov r8, r1
	mov r7, r2
	bl OS_DisableInterrupts
	mov r5, r0
	bl OS_GetTick
	ldr r6, _020C7960 // =0x0214707C
	mov r4, r0, lsr #0x10
	mov r3, #0
	mov ip, r3
	mov r2, r6
	orr r4, r4, r1, lsl #16
	mvn r0, #0
_020C78A0:
	ldrb r1, [r2, #0x5a]
	cmp r1, #0
	beq _020C78D8
	cmp r8, #0
	beq _020C78D8
	ldr lr, [r2, #0x54]
	cmp r8, lr
	bne _020C78D8
	cmp r7, #0
	beq _020C78D8
	ldrh lr, [r2, #0x58]
	cmp r7, lr
	moveq r6, r2
	beq _020C7918
_020C78D8:
	mvn lr, #0
	cmp r3, lr
	beq _020C7908
	cmp r1, #0
	moveq r3, r0
	moveq r6, r2
	beq _020C7908
	ldr r1, [r2, #0x50]
	sub r1, r4, r1
	cmp r1, r3
	movhi r3, r1
	movhi r6, r2
_020C7908:
	add ip, ip, #1
	cmp ip, #4
	add r2, r2, #0x5c
	blt _020C78A0
_020C7918:
	mov r1, r6
	add r0, r9, #0x74
	mov r2, #0x20
	bl MI_CpuCopy8
	mov r0, r9
	add r1, r6, #0x20
	mov r2, #0x30
	bl MI_CpuCopy8
	str r4, [r6, #0x50]
	mov r0, #1
	strb r0, [r6, #0x5a]
	str r8, [r6, #0x54]
	mov r0, r5
	strh r7, [r6, #0x58]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020C7960: .word 0x0214707C
	arm_func_end sub_20C7864

	arm_func_start sub_20C7964
sub_20C7964: // 0x020C7964
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	bl OS_DisableInterrupts
	mov r1, #0
	ldr r4, _020C7A08 // =0x0214707C
	mov r5, r0
	strb r1, [r8, #0x30]
_020C7988:
	ldrb r0, [r4, #0x5a]
	cmp r0, #0
	beq _020C79E8
	ldr r0, [r4, #0x54]
	cmp r0, r7
	bne _020C79E8
	ldrh r0, [r4, #0x58]
	cmp r0, r6
	bne _020C79E8
	mov r0, r4
	add r1, r8, #0x74
	mov r2, #0x20
	bl MI_CpuCopy8
	mov r1, r8
	add r0, r4, #0x20
	mov r2, #0x30
	bl MI_CpuCopy8
	bl OS_GetTick
	mov r0, r0, lsr #0x10
	orr r0, r0, r1, lsl #16
	str r0, [r4, #0x50]
	mov r0, #1
	strb r0, [r8, #0x30]
	b _020C79F8
_020C79E8:
	add r1, r1, #1
	cmp r1, #4
	add r4, r4, #0x5c
	blt _020C7988
_020C79F8:
	mov r0, r5
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C7A08: .word 0x0214707C
	arm_func_end sub_20C7964

	arm_func_start sub_20C7A0C
sub_20C7A0C: // 0x020C7A0C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r7, r0
	bl OS_DisableInterrupts
	mov r6, #0
	ldr r4, _020C7AB0 // =0x0214707C
	mov r5, r0
	strb r6, [r7, #0x30]
	add r9, r7, #0x74
	mov r8, #0x20
_020C7A34:
	ldrb r0, [r4, #0x5a]
	cmp r0, #0
	beq _020C7A8C
	ldr r0, [r4, #0x54]
	cmp r0, #0
	bne _020C7A8C
	ldrh r0, [r4, #0x58]
	cmp r0, #0
	bne _020C7A8C
	mov r0, r4
	mov r1, r9
	mov r2, r8
	bl memcmp
	cmp r0, #0
	bne _020C7A8C
	mov r1, r7
	add r0, r4, #0x20
	mov r2, #0x30
	bl MI_CpuCopy8
	mov r0, #1
	strb r0, [r7, #0x30]
	b _020C7A9C
_020C7A8C:
	add r6, r6, #1
	cmp r6, #4
	add r4, r4, #0x5c
	blt _020C7A34
_020C7A9C:
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020C7AB0: .word 0x0214707C
	arm_func_end sub_20C7A0C

	arm_func_start sub_20C7AB4
sub_20C7AB4: // 0x020C7AB4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	mov r0, r4
	add r1, r5, #0x10
	mov r2, #8
	bl sub_20C80A0
	ldr r0, [r5, #0x10]
	ldr r1, _020C7B24 // =_0211F290
	mov r0, r0, lsr #3
	and r0, r0, #0x3f
	cmp r0, #0x38
	rsblt r2, r0, #0x38
	rsbge r2, r0, #0x78
	mov r0, r5
	bl sub_20C7B28
	mov r0, r5
	mov r1, r4
	mov r2, #8
	bl sub_20C7B28
	mov r0, r4
	mov r1, r5
	mov r2, #0x10
	bl sub_20C80A0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020C7B24: .word _0211F290
	arm_func_end sub_20C7AB4

	arm_func_start sub_20C7B28
sub_20C7B28: // 0x020C7B28
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldr r3, [r8, #0x10]
	mov r6, r2
	add r0, r3, r6, lsl #3
	str r0, [r8, #0x10]
	ldr r0, [r8, #0x10]
	mov r2, r3, lsr #3
	cmp r0, r6, lsl #3
	ldrlo r0, [r8, #0x14]
	and r4, r2, #0x3f
	addlo r0, r0, #1
	strlo r0, [r8, #0x14]
	ldr r0, [r8, #0x14]
	rsb r5, r4, #0x40
	add r0, r0, r6, lsr #29
	mov r7, r1
	str r0, [r8, #0x14]
	cmp r6, r5
	blo _020C7BC8
	add r1, r8, #0x18
	mov r0, r7
	mov r2, r5
	add r1, r1, r4
	bl MI_CpuCopy8
	mov r0, r8
	add r1, r8, #0x18
	mov r4, #0
	bl sub_20C7C34
	add r0, r5, #0x3f
	cmp r0, r6
	bhs _020C7BCC
_020C7BA8:
	mov r0, r8
	add r1, r7, r5
	bl sub_20C7C34
	add r5, r5, #0x40
	add r0, r5, #0x3f
	cmp r0, r6
	blo _020C7BA8
	b _020C7BCC
_020C7BC8:
	mov r5, #0
_020C7BCC:
	add r1, r8, #0x18
	add r0, r7, r5
	add r1, r1, r4
	sub r2, r6, r5
	bl MI_CpuCopy8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20C7B28

	arm_func_start sub_20C7BE8
sub_20C7BE8: // 0x020C7BE8
	stmdb sp!, {r4, lr}
	mov r1, #0
	mov r2, #0x58
	mov r4, r0
	bl MI_CpuFill8
	ldr r1, _020C7C24 // =0x67452301
	ldr r0, _020C7C28 // =0xEFCDAB89
	str r1, [r4]
	ldr r1, _020C7C2C // =0x98BADCFE
	str r0, [r4, #4]
	ldr r0, _020C7C30 // =0x10325476
	str r1, [r4, #8]
	str r0, [r4, #0xc]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C7C24: .word 0x67452301
_020C7C28: .word 0xEFCDAB89
_020C7C2C: .word 0x98BADCFE
_020C7C30: .word 0x10325476
	arm_func_end sub_20C7BE8

	arm_func_start sub_20C7C34
sub_20C7C34: // 0x020C7C34
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x44
	str r0, [sp]
	ldr r3, [sp]
	add r0, sp, #4
	mov r2, #0x40
	ldr r7, [r3]
	ldr r6, [r3, #4]
	ldr r5, [r3, #8]
	ldr r4, [r3, #0xc]
	bl sub_20C8088
	ldr r2, _020C8080 // =byte_211F250
	mov r3, #0
	ldr r1, _020C8084 // =_0211F2D0
	mov r11, r3
	add r0, sp, #4
	mov r10, r2
_020C7C78:
	ldrb r9, [r2]
	add r8, r3, #1
	eor ip, r5, r4
	and ip, r6, ip
	eor ip, r4, ip
	ldr r9, [r0, r9, lsl #2]
	ldr lr, [r1, r3, lsl #2]
	add r9, ip, r9
	add r9, lr, r9
	add r9, r7, r9
	mov r7, r9, lsl #7
	orr r7, r7, r9, lsr #25
	ldrb r9, [r10, r8]
	add r7, r6, r7
	ldr r8, [r1, r8, lsl #2]
	ldr r9, [r0, r9, lsl #2]
	eor ip, r6, r5
	and ip, r7, ip
	eor ip, r5, ip
	add r9, ip, r9
	add r9, r8, r9
	add r8, r3, #2
	add r9, r4, r9
	mov r4, r9, lsl #0xc
	orr r4, r4, r9, lsr #20
	add r4, r7, r4
	ldr r9, [r1, r8, lsl #2]
	ldrb ip, [r10, r8]
	eor r8, r7, r6
	and r8, r4, r8
	eor r8, r6, r8
	ldr lr, [r0, ip, lsl #2]
	add ip, r3, #3
	add r8, r8, lr
	add r8, r9, r8
	add r8, r5, r8
	mov r5, r8, lsl #0x11
	orr r5, r5, r8, lsr #15
	add r5, r4, r5
	ldr r9, [r1, ip, lsl #2]
	ldrb ip, [r10, ip]
	eor r8, r4, r7
	and r8, r5, r8
	eor r8, r7, r8
	ldr ip, [r0, ip, lsl #2]
	add r2, r2, #4
	add r8, r8, ip
	add r8, r9, r8
	add r8, r6, r8
	mov r6, r8, lsl #0x16
	orr r6, r6, r8, lsr #10
	add r6, r5, r6
	add r3, r3, #4
	add r11, r11, #1
	cmp r11, #4
	blt _020C7C78
	add r8, r10, r3
	mov r2, #0
	ldr r1, _020C8084 // =_0211F2D0
	add r0, sp, #4
	ldr lr, _020C8080 // =byte_211F250
_020C7D6C:
	ldrb r10, [r8]
	add r9, r3, #1
	eor r11, r6, r5
	and r11, r4, r11
	eor r11, r5, r11
	ldr r10, [r0, r10, lsl #2]
	ldr ip, [r1, r3, lsl #2]
	add r10, r11, r10
	add r10, ip, r10
	add r10, r7, r10
	mov r7, r10, lsl #5
	orr r7, r7, r10, lsr #27
	ldrb r10, [lr, r9]
	add r7, r6, r7
	ldr r9, [r1, r9, lsl #2]
	ldr r10, [r0, r10, lsl #2]
	eor r11, r7, r6
	and r11, r5, r11
	eor r11, r6, r11
	add r10, r11, r10
	add r10, r9, r10
	add r9, r3, #2
	add r10, r4, r10
	mov r4, r10, lsl #9
	orr r4, r4, r10, lsr #23
	add r4, r7, r4
	ldr ip, [r1, r9, lsl #2]
	ldrb r9, [lr, r9]
	eor r10, r4, r7
	and r10, r6, r10
	eor r11, r7, r10
	ldr r10, [r0, r9, lsl #2]
	add r9, r3, #3
	add r10, r11, r10
	add r10, ip, r10
	add r10, r5, r10
	mov r5, r10, lsl #0xe
	orr r5, r5, r10, lsr #18
	add r5, r4, r5
	ldr r10, [r1, r9, lsl #2]
	ldrb r11, [lr, r9]
	eor r9, r5, r4
	and r9, r7, r9
	eor r9, r4, r9
	ldr r11, [r0, r11, lsl #2]
	add r8, r8, #4
	add r9, r9, r11
	add r9, r10, r9
	add r9, r6, r9
	mov r6, r9, lsl #0x14
	orr r6, r6, r9, lsr #12
	add r6, r5, r6
	add r3, r3, #4
	add r2, r2, #1
	cmp r2, #4
	blt _020C7D6C
	add r8, lr, r3
	mov lr, #0
	ldr r2, _020C8084 // =_0211F2D0
	add r0, sp, #4
_020C7E5C:
	ldrb r1, [r8]
	eor ip, r6, r5
	add lr, lr, #1
	ldr r11, [r0, r1, lsl #2]
	eor ip, r4, ip
	ldr r1, [r2, r3, lsl #2]
	add r11, ip, r11
	add r1, r1, r11
	add r7, r7, r1
	mov r1, r7, lsl #4
	orr r1, r1, r7, lsr #28
	add r7, r6, r1
	add r10, r3, #1
	ldr r1, _020C8080 // =byte_211F250
	ldr ip, [r2, r10, lsl #2]
	ldrb r1, [r1, r10]
	eor r10, r7, r6
	eor r11, r5, r10
	ldr r10, [r0, r1, lsl #2]
	add r9, r3, #2
	add r10, r11, r10
	add r10, ip, r10
	add r4, r4, r10
	ldr r10, _020C8080 // =byte_211F250
	ldr r1, [r2, r9, lsl #2]
	ldrb r9, [r10, r9]
	mov r10, r4, lsl #0xb
	orr r4, r10, r4, lsr #21
	add r4, r7, r4
	eor r10, r4, r7
	ldr r9, [r0, r9, lsl #2]
	eor r10, r6, r10
	add r9, r10, r9
	add r1, r1, r9
	add r5, r5, r1
	add r10, r3, #3
	ldr r9, _020C8080 // =byte_211F250
	mov r1, r5, lsl #0x10
	ldrb r9, [r9, r10]
	orr r1, r1, r5, lsr #16
	add r5, r4, r1
	ldr r1, [r2, r10, lsl #2]
	eor r10, r5, r4
	ldr r9, [r0, r9, lsl #2]
	eor r10, r7, r10
	add r9, r10, r9
	add r1, r1, r9
	add r6, r6, r1
	mov r1, r6, lsl #0x17
	orr r1, r1, r6, lsr #9
	add r8, r8, #4
	add r6, r5, r1
	add r3, r3, #4
	cmp lr, #4
	blt _020C7E5C
	ldr r0, _020C8080 // =byte_211F250
	ldr r1, _020C8084 // =_0211F2D0
	add r8, r0, r3
	ldr lr, _020C8080 // =byte_211F250
	mov r2, #0
	add r0, sp, #4
_020C7F50:
	ldrb r10, [r8]
	add r9, r3, #1
	mvn r11, r4
	orr r11, r6, r11
	eor r11, r5, r11
	ldr r10, [r0, r10, lsl #2]
	ldr ip, [r1, r3, lsl #2]
	add r10, r11, r10
	add r10, ip, r10
	add r10, r7, r10
	mov r7, r10, lsl #6
	orr r7, r7, r10, lsr #26
	ldrb r10, [lr, r9]
	add r7, r6, r7
	ldr r9, [r1, r9, lsl #2]
	ldr r10, [r0, r10, lsl #2]
	mvn r11, r5
	orr r11, r7, r11
	eor r11, r6, r11
	add r10, r11, r10
	add r10, r9, r10
	add r9, r3, #2
	add r10, r4, r10
	mov r4, r10, lsl #0xa
	orr r4, r4, r10, lsr #22
	add r4, r7, r4
	ldr ip, [r1, r9, lsl #2]
	ldrb r9, [lr, r9]
	mvn r10, r6
	orr r10, r4, r10
	eor r11, r7, r10
	ldr r10, [r0, r9, lsl #2]
	add r9, r3, #3
	add r10, r11, r10
	add r10, ip, r10
	add r10, r5, r10
	mov r5, r10, lsl #0xf
	orr r5, r5, r10, lsr #17
	add r5, r4, r5
	ldr r10, [r1, r9, lsl #2]
	ldrb r11, [lr, r9]
	mvn r9, r7
	orr r9, r5, r9
	eor r9, r4, r9
	ldr r11, [r0, r11, lsl #2]
	add r8, r8, #4
	add r9, r9, r11
	add r9, r10, r9
	add r9, r6, r9
	mov r6, r9, lsl #0x15
	orr r6, r6, r9, lsr #11
	add r6, r5, r6
	add r3, r3, #4
	add r2, r2, #1
	cmp r2, #4
	blt _020C7F50
	ldr r0, [sp]
	ldr r0, [r0]
	add r1, r0, r7
	ldr r0, [sp]
	str r1, [r0]
	ldr r0, [r0, #4]
	add r1, r0, r6
	ldr r0, [sp]
	str r1, [r0, #4]
	ldr r0, [r0, #8]
	add r1, r0, r5
	ldr r0, [sp]
	str r1, [r0, #8]
	ldr r0, [r0, #0xc]
	add r1, r0, r4
	ldr r0, [sp]
	str r1, [r0, #0xc]
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C8080: .word byte_211F250
_020C8084: .word _0211F2D0
	arm_func_end sub_20C7C34

	arm_func_start sub_20C8088
sub_20C8088: // 0x020C8088
	ldr ip, _020C809C // =MI_CpuCopy8
	mov r3, r0
	mov r0, r1
	mov r1, r3
	bx ip
	.align 2, 0
_020C809C: .word MI_CpuCopy8
	arm_func_end sub_20C8088

	arm_func_start sub_20C80A0
sub_20C80A0: // 0x020C80A0
	ldr ip, _020C80B4 // =MI_CpuCopy8
	mov r3, r0
	mov r0, r1
	mov r1, r3
	bx ip
	.align 2, 0
_020C80B4: .word MI_CpuCopy8
	arm_func_end sub_20C80A0

	arm_func_start sub_20C80B8
sub_20C80B8: // 0x020C80B8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	ldr r1, _020C80F0 // =0x0211F3D1
	mov r5, r0
	mov r2, #0x2c
	bl sub_20C8168
	mov r0, r4
	mov r1, r5
	mov r2, #0x14
	bl sub_20C898C
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020C80F0: .word 0x0211F3D1
	arm_func_end sub_20C80B8

	arm_func_start sub_20C80F4
sub_20C80F4: // 0x020C80F4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	mov r0, r4
	add r1, r5, #0x14
	mov r2, #8
	bl sub_20C898C
	ldr r0, [r5, #0x18]
	ldr r1, _020C8164 // =_0211F3D0
	mov r0, r0, lsr #3
	and r0, r0, #0x3f
	cmp r0, #0x38
	rsblt r2, r0, #0x38
	rsbge r2, r0, #0x78
	mov r0, r5
	bl sub_20C8168
	mov r0, r5
	mov r1, r4
	mov r2, #8
	bl sub_20C8168
	mov r0, r4
	mov r1, r5
	mov r2, #0x14
	bl sub_20C898C
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020C8164: .word _0211F3D0
	arm_func_end sub_20C80F4

	arm_func_start sub_20C8168
sub_20C8168: // 0x020C8168
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldr r3, [r8, #0x18]
	mov r6, r2
	add r0, r3, r6, lsl #3
	str r0, [r8, #0x18]
	ldr r0, [r8, #0x18]
	mov r2, r3, lsr #3
	cmp r0, r6, lsl #3
	ldrlo r0, [r8, #0x14]
	and r4, r2, #0x3f
	addlo r0, r0, #1
	strlo r0, [r8, #0x14]
	ldr r0, [r8, #0x14]
	rsb r5, r4, #0x40
	add r0, r0, r6, lsr #29
	mov r7, r1
	str r0, [r8, #0x14]
	cmp r6, r5
	blo _020C8208
	add r1, r8, #0x1c
	mov r0, r7
	mov r2, r5
	add r1, r1, r4
	bl MI_CpuCopy8
	mov r0, r8
	add r1, r8, #0x1c
	mov r4, #0
	bl sub_20C8280
	add r0, r5, #0x3f
	cmp r0, r6
	bhs _020C820C
_020C81E8:
	mov r0, r8
	add r1, r7, r5
	bl sub_20C8280
	add r5, r5, #0x40
	add r0, r5, #0x3f
	cmp r0, r6
	blo _020C81E8
	b _020C820C
_020C8208:
	mov r5, #0
_020C820C:
	add r1, r8, #0x1c
	add r0, r7, r5
	add r1, r1, r4
	sub r2, r6, r5
	bl MI_CpuCopy8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20C8168

	arm_func_start sub_20C8228
sub_20C8228: // 0x020C8228
	stmdb sp!, {r4, lr}
	mov r1, #0
	mov r2, #0x5c
	mov r4, r0
	bl MI_CpuFill8
	ldr r0, _020C826C // =0x67452301
	ldr r1, _020C8270 // =0xEFCDAB89
	str r0, [r4]
	ldr r0, _020C8274 // =0x98BADCFE
	str r1, [r4, #4]
	ldr r1, _020C8278 // =0x10325476
	str r0, [r4, #8]
	ldr r0, _020C827C // =0xC3D2E1F0
	str r1, [r4, #0xc]
	str r0, [r4, #0x10]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C826C: .word 0x67452301
_020C8270: .word 0xEFCDAB89
_020C8274: .word 0x98BADCFE
_020C8278: .word 0x10325476
_020C827C: .word 0xC3D2E1F0
	arm_func_end sub_20C8228

	arm_func_start sub_20C8280
sub_20C8280: // 0x020C8280
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x54
	str r0, [sp]
	ldr r3, [sp]
	add r0, sp, #0x10
	mov r2, #0x40
	ldr r6, [r3]
	ldr r7, [r3, #4]
	ldr r8, [r3, #8]
	ldr r5, [r3, #0xc]
	ldr r4, [r3, #0x10]
	bl sub_20C8928
	mov r2, #0
	ldr r3, _020C8918 // =0x5A827999
	mov r0, r2
	add r1, sp, #0x10
_020C82C0:
	eor r9, r8, r5
	mov r10, r6, lsl #5
	and r9, r7, r9
	orr r10, r10, r6, lsr #27
	eor r9, r5, r9
	mov r11, r7, lsl #0x1e
	orr r7, r11, r7, lsr #2
	eor r11, r7, r8
	add r9, r10, r9
	ldr ip, [r1, r2, lsl #2]
	and r10, r6, r11
	add r9, ip, r9
	add r9, r9, r3
	add r4, r4, r9
	add r9, r2, #1
	ldr r9, [r1, r9, lsl #2]
	eor r10, r8, r10
	mov r11, r4, lsl #5
	orr r11, r11, r4, lsr #27
	add r10, r11, r10
	add r10, r9, r10
	mov r9, r6, lsl #0x1e
	add r10, r10, r3
	add r5, r5, r10
	orr r6, r9, r6, lsr #2
	add r9, r2, #2
	ldr r10, [r1, r9, lsl #2]
	mov r9, r5, lsl #5
	orr r9, r9, r5, lsr #27
	eor r11, r6, r7
	and r11, r4, r11
	eor r11, r7, r11
	add r9, r9, r11
	add r9, r10, r9
	add r9, r9, r3
	add r8, r8, r9
	mov r9, r4, lsl #0x1e
	orr r4, r9, r4, lsr #2
	add r9, r2, #3
	ldr r10, [r1, r9, lsl #2]
	mov r9, r8, lsl #5
	orr r9, r9, r8, lsr #27
	eor r11, r4, r6
	and r11, r5, r11
	eor r11, r6, r11
	add r9, r9, r11
	add r9, r10, r9
	add r9, r9, r3
	add r7, r7, r9
	mov r9, r5, lsl #0x1e
	orr r5, r9, r5, lsr #2
	add r9, r2, #4
	ldr r10, [r1, r9, lsl #2]
	mov r9, r7, lsl #5
	orr r9, r9, r7, lsr #27
	eor r11, r5, r4
	and r11, r8, r11
	eor r11, r4, r11
	add r9, r9, r11
	add r9, r10, r9
	add r9, r9, r3
	add r6, r6, r9
	mov r9, r8, lsl #0x1e
	orr r8, r9, r8, lsr #2
	add r2, r2, #5
	add r0, r0, #1
	cmp r0, #3
	blt _020C82C0
	eor r0, r8, r5
	mov r2, r6, lsl #5
	and r0, r7, r0
	orr r3, r2, r6, lsr #27
	eor r0, r5, r0
	add r3, r3, r0
	ldr r9, [sp, #0x4c]
	ldr r0, _020C8918 // =0x5A827999
	add r3, r9, r3
	add r3, r3, r0
	mov r2, r7, lsl #0x1e
	orr r9, r2, r7, lsr #2
	mov r0, #0
	add r4, r4, r3
	bl sub_20C89E4
	eor r1, r9, r8
	mov r3, r4, lsl #5
	and r1, r6, r1
	mov r2, r6, lsl #0x1e
	orr r3, r3, r4, lsr #27
	eor r1, r8, r1
	add r1, r3, r1
	add r3, r1, r0
	ldr r0, _020C8918 // =0x5A827999
	add r1, sp, #0x10
	add r3, r3, r0
	orr r10, r2, r6, lsr #2
	mov r0, #1
	add r5, r5, r3
	bl sub_20C89E4
	eor r1, r10, r9
	mov r2, r5, lsl #5
	and r1, r4, r1
	orr r2, r2, r5, lsr #27
	eor r1, r9, r1
	add r1, r2, r1
	add r2, r1, r0
	ldr r0, _020C8918 // =0x5A827999
	mov r1, r4, lsl #0x1e
	add r0, r2, r0
	orr r6, r1, r4, lsr #2
	add r8, r8, r0
	add r1, sp, #0x10
	mov r0, #2
	bl sub_20C89E4
	mov r1, r8, lsl #5
	orr r2, r1, r8, lsr #27
	eor r1, r6, r10
	and r1, r5, r1
	eor r1, r10, r1
	add r1, r2, r1
	add r2, r1, r0
	ldr r0, _020C8918 // =0x5A827999
	mov r1, r5, lsl #0x1e
	add r0, r2, r0
	orr r7, r1, r5, lsr #2
	add r9, r9, r0
	mov r0, #3
	add r1, sp, #0x10
	bl sub_20C89E4
	mov r1, r9, lsl #5
	orr r2, r1, r9, lsr #27
	eor r1, r7, r6
	and r1, r8, r1
	eor r1, r6, r1
	add r1, r2, r1
	add r2, r1, r0
	ldr r0, _020C8918 // =0x5A827999
	mov r1, r8, lsl #0x1e
	add r0, r2, r0
	add r10, r10, r0
	mov r0, #0
	ldr r4, _020C891C // =0x6ED9EBA1
	orr r8, r1, r8, lsr #2
	mov r5, #4
	str r0, [sp, #0xc]
	add r11, sp, #0x10
_020C8504:
	mov r0, r5
	mov r1, r11
	bl sub_20C89E4
	mov r2, r10, lsl #5
	eor r1, r9, r8
	orr r2, r2, r10, lsr #27
	eor r1, r7, r1
	add r1, r2, r1
	add r0, r1, r0
	add r1, r0, r4
	mov r0, r9, lsl #0x1e
	add r6, r6, r1
	orr r9, r0, r9, lsr #2
	add r0, r5, #1
	mov r1, r11
	bl sub_20C89E4
	mov r1, r6, lsl #5
	orr r2, r1, r6, lsr #27
	eor r1, r10, r9
	eor r1, r8, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r7, r7, r0
	mov r0, r10, lsl #0x1e
	orr r10, r0, r10, lsr #2
	add r0, r5, #2
	and r5, r0, #0xf
	mov r0, r5
	mov r1, r11
	bl sub_20C89E4
	mov r1, r7, lsl #5
	orr r2, r1, r7, lsr #27
	eor r1, r6, r10
	eor r1, r9, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r8, r8, r0
	mov r0, r6, lsl #0x1e
	orr r6, r0, r6, lsr #2
	add r0, r5, #1
	mov r1, r11
	bl sub_20C89E4
	mov r1, r8, lsl #5
	orr r2, r1, r8, lsr #27
	eor r1, r7, r6
	eor r1, r10, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r9, r9, r0
	mov r0, r7, lsl #0x1e
	orr r7, r0, r7, lsr #2
	add r0, r5, #2
	mov r1, r11
	bl sub_20C89E4
	mov r1, r9, lsl #5
	orr r2, r1, r9, lsr #27
	eor r1, r8, r7
	eor r1, r6, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r10, r10, r0
	mov r0, r8, lsl #0x1e
	orr r8, r0, r8, lsr #2
	ldr r0, [sp, #0xc]
	add r5, r5, #3
	add r0, r0, #1
	str r0, [sp, #0xc]
	cmp r0, #4
	blt _020C8504
	mov r0, #0
	ldr r4, _020C8920 // =0x8F1BBCDC
	str r0, [sp, #8]
	add r11, sp, #0x10
_020C8638:
	mov r0, r5
	mov r1, r11
	bl sub_20C89E4
	orr r2, r8, r7
	mov r1, r10, lsl #5
	and r3, r9, r2
	and r2, r8, r7
	orr r1, r1, r10, lsr #27
	orr r2, r3, r2
	add r1, r1, r2
	add r1, r1, r0
	mov r0, r9, lsl #0x1e
	add r1, r1, r4
	add r6, r6, r1
	orr r9, r0, r9, lsr #2
	add r0, r5, #1
	mov r1, r11
	bl sub_20C89E4
	orr r2, r9, r8
	mov r1, r6, lsl #5
	and r3, r10, r2
	and r2, r9, r8
	orr r1, r1, r6, lsr #27
	orr r2, r3, r2
	add r1, r1, r2
	add r0, r1, r0
	add r0, r0, r4
	add r7, r7, r0
	mov r0, r10, lsl #0x1e
	orr r10, r0, r10, lsr #2
	add r0, r5, #2
	mov r1, r11
	bl sub_20C89E4
	orr r2, r10, r9
	mov r1, r7, lsl #5
	and r3, r6, r2
	and r2, r10, r9
	orr r1, r1, r7, lsr #27
	orr r2, r3, r2
	add r1, r1, r2
	add r0, r1, r0
	add r0, r0, r4
	add r8, r8, r0
	mov r0, r6, lsl #0x1e
	orr r6, r0, r6, lsr #2
	add r0, r5, #3
	and r5, r0, #0xf
	mov r0, r5
	mov r1, r11
	bl sub_20C89E4
	orr r2, r6, r10
	mov r1, r8, lsl #5
	and r3, r7, r2
	and r2, r6, r10
	orr r1, r1, r8, lsr #27
	orr r2, r3, r2
	add r1, r1, r2
	add r0, r1, r0
	add r0, r0, r4
	add r9, r9, r0
	mov r0, r7, lsl #0x1e
	orr r7, r0, r7, lsr #2
	add r0, r5, #1
	mov r1, r11
	bl sub_20C89E4
	orr r2, r7, r6
	mov r1, r9, lsl #5
	and r3, r8, r2
	and r2, r7, r6
	orr r1, r1, r9, lsr #27
	orr r2, r3, r2
	add r1, r1, r2
	add r0, r1, r0
	add r0, r0, r4
	add r10, r10, r0
	mov r0, r8, lsl #0x1e
	orr r8, r0, r8, lsr #2
	ldr r0, [sp, #8]
	add r5, r5, #2
	add r0, r0, #1
	str r0, [sp, #8]
	cmp r0, #4
	blt _020C8638
	mov r0, #0
	ldr r4, _020C8924 // =0xCA62C1D6
	str r0, [sp, #4]
	add r11, sp, #0x10
_020C8794:
	mov r0, r5
	mov r1, r11
	bl sub_20C89E4
	mov r2, r10, lsl #5
	eor r1, r9, r8
	orr r2, r2, r10, lsr #27
	eor r1, r7, r1
	add r1, r2, r1
	add r0, r1, r0
	add r1, r0, r4
	mov r0, r9, lsl #0x1e
	add r6, r6, r1
	orr r9, r0, r9, lsr #2
	add r0, r5, #1
	mov r1, r11
	bl sub_20C89E4
	mov r1, r6, lsl #5
	orr r2, r1, r6, lsr #27
	eor r1, r10, r9
	eor r1, r8, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r7, r7, r0
	mov r0, r10, lsl #0x1e
	orr r10, r0, r10, lsr #2
	add r0, r5, #2
	mov r1, r11
	bl sub_20C89E4
	mov r1, r7, lsl #5
	orr r2, r1, r7, lsr #27
	eor r1, r6, r10
	eor r1, r9, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r8, r8, r0
	mov r0, r6, lsl #0x1e
	orr r6, r0, r6, lsr #2
	add r0, r5, #3
	mov r1, r11
	bl sub_20C89E4
	mov r1, r8, lsl #5
	orr r2, r1, r8, lsr #27
	eor r1, r7, r6
	eor r1, r10, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r9, r9, r0
	mov r0, r7, lsl #0x1e
	orr r7, r0, r7, lsr #2
	add r0, r5, #4
	and r5, r0, #0xf
	mov r0, r5
	mov r1, r11
	bl sub_20C89E4
	mov r1, r9, lsl #5
	orr r2, r1, r9, lsr #27
	eor r1, r8, r7
	eor r1, r6, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r10, r10, r0
	mov r0, r8, lsl #0x1e
	orr r8, r0, r8, lsr #2
	ldr r0, [sp, #4]
	add r5, r5, #1
	add r0, r0, #1
	str r0, [sp, #4]
	cmp r0, #4
	blt _020C8794
	ldr r0, [sp]
	ldr r0, [r0]
	add r1, r0, r10
	ldr r0, [sp]
	str r1, [r0]
	ldr r0, [r0, #4]
	add r1, r0, r9
	ldr r0, [sp]
	str r1, [r0, #4]
	ldr r0, [r0, #8]
	add r1, r0, r8
	ldr r0, [sp]
	str r1, [r0, #8]
	ldr r0, [r0, #0xc]
	add r1, r0, r7
	ldr r0, [sp]
	str r1, [r0, #0xc]
	ldr r0, [r0, #0x10]
	add r1, r0, r6
	ldr r0, [sp]
	str r1, [r0, #0x10]
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C8918: .word 0x5A827999
_020C891C: .word 0x6ED9EBA1
_020C8920: .word 0x8F1BBCDC
_020C8924: .word 0xCA62C1D6
	arm_func_end sub_20C8280

	arm_func_start sub_20C8928
sub_20C8928: // 0x020C8928
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	cmp r2, #0
	addls sp, sp, #4
	mov r3, #0
	ldmlsia sp!, {r4, r5, lr}
	bxls lr
_020C8944:
	add ip, r3, #1
	ldrb lr, [r1, r3]
	add r4, r3, #2
	add r5, r3, #3
	ldrb ip, [r1, ip]
	mov lr, lr, lsl #0x18
	add r3, r3, #4
	ldrb r4, [r1, r4]
	orr ip, lr, ip, lsl #16
	ldrb lr, [r1, r5]
	orr r4, ip, r4, lsl #8
	cmp r3, r2
	orr r4, lr, r4
	str r4, [r0], #4
	blo _020C8944
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20C8928

	arm_func_start sub_20C898C
sub_20C898C: // 0x020C898C
	stmdb sp!, {lr}
	sub sp, sp, #4
	movs ip, r2, lsr #2
	mov lr, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
_020C89A8:
	ldr r3, [r1], #4
	add lr, lr, #1
	mov r2, r3, lsr #0x18
	strb r2, [r0]
	mov r2, r3, lsr #0x10
	strb r2, [r0, #1]
	mov r2, r3, lsr #8
	strb r2, [r0, #2]
	strb r3, [r0, #3]
	cmp lr, ip
	add r0, r0, #4
	blo _020C89A8
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20C898C

	arm_func_start sub_20C89E4
sub_20C89E4: // 0x020C89E4
	add r2, r0, #0xd
	add ip, r0, #2
	and r3, r2, #0xf
	eor r2, r0, #8
	and ip, ip, #0xf
	ldr r3, [r1, r3, lsl #2]
	ldr r2, [r1, r2, lsl #2]
	ldr ip, [r1, ip, lsl #2]
	eor r2, r3, r2
	ldr r3, [r1, r0, lsl #2]
	eor r2, ip, r2
	eor r3, r3, r2
	mov r2, r3, lsl #1
	orr r2, r2, r3, lsr #31
	str r2, [r1, r0, lsl #2]
	ldr r0, [r1, r0, lsl #2]
	bx lr
	arm_func_end sub_20C89E4

	arm_func_start sub_20C8A28
sub_20C8A28: // 0x020C8A28
	stmdb sp!, {r4, r5, r6, lr}
	cmp r2, #0
	add r3, r0, #2
	ldrb lr, [r0]
	ldrb ip, [r0, #1]
	mov r4, #0
	ble _020C8A88
_020C8A44:
	add r5, lr, #1
	and lr, r5, #0xff
	ldrb r6, [r3, lr]
	add r5, ip, r6
	and ip, r5, #0xff
	ldrb r5, [r3, ip]
	strb r5, [r3, lr]
	add r5, r6, r5
	strb r6, [r3, ip]
	and r5, r5, #0xff
	ldrb r6, [r1, r4]
	ldrb r5, [r3, r5]
	eor r5, r6, r5
	strb r5, [r1, r4]
	add r4, r4, #1
	cmp r4, r2
	blt _020C8A44
_020C8A88:
	strb lr, [r0]
	strb ip, [r0, #1]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C8A28

	arm_func_start sub_20C8A98
sub_20C8A98: // 0x020C8A98
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r3, #0
	strb r3, [r0]
	strb r3, [r0, #1]
	add r7, r0, #2
_020C8AB0:
	strb r3, [r7, r3]
	add r3, r3, #1
	cmp r3, #0x100
	blt _020C8AB0
	mov r5, #0
	mov r6, r5
	mov r4, r5
	mov r0, r5
_020C8AD0:
	ldrb lr, [r7, r4]
	ldrb ip, [r1, r5]
	add r3, r5, #1
	and r5, r3, #0xff
	add r3, lr, ip
	add r3, r6, r3
	and r6, r3, #0xff
	ldrb r3, [r7, r6]
	cmp r5, r2
	movge r5, r0
	strb r3, [r7, r4]
	add r4, r4, #1
	strb lr, [r7, r6]
	cmp r4, #0x100
	blt _020C8AD0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C8A98

	arm_func_start sub_20C8B18
sub_20C8B18: // 0x020C8B18
	ldrh r1, [r0]
	mov r0, #0
	bx lr
	arm_func_end sub_20C8B18

	arm_func_start sub_20C8B24
sub_20C8B24: // 0x020C8B24
	ldrh r1, [r0]
	ldrh r0, [r0, #-2]
	mov r0, r0, lsl #0x10
	bx lr
	arm_func_end sub_20C8B24

	arm_func_start sub_20C8B34
sub_20C8B34: // 0x020C8B34
	ldrh r1, [r0]
	ldrh r2, [r0, #-2]
	ldrh r3, [r0, #-4]
	orr r0, r3, r2, lsl #16
	bx lr
	arm_func_end sub_20C8B34

	arm_func_start sub_20C8B48
sub_20C8B48: // 0x020C8B48
	ldrh r2, [r0]
	ldrh r3, [r0, #-2]
	orr r1, r3, r2, lsl #16
	ldrh r2, [r0, #-4]
	ldrh r3, [r0, #-6]
	orr r0, r3, r2, lsl #16
	bx lr
	arm_func_end sub_20C8B48

	arm_func_start sub_20C8B64
sub_20C8B64: // 0x020C8B64
	sub r3, r2, #1
	cmp r2, #1
	add r0, r0, r3
	ble _020C8B9C
_020C8B74:
	ldrh r3, [r1]
	sub r2, r2, #2
	sub ip, r0, #1
	strb r3, [r0]
	ldrh r3, [r1], #2
	cmp r2, #1
	sub r0, r0, #2
	mov r3, r3, asr #8
	strb r3, [ip]
	bgt _020C8B74
_020C8B9C:
	cmp r2, #0
	ldrgth r1, [r1]
	strgtb r1, [r0]
	bx lr
	arm_func_end sub_20C8B64

	arm_func_start sub_20C8BAC
sub_20C8BAC: // 0x020C8BAC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	mov r5, r2
	mov r2, r3, lsl #1
	mov r1, #0
	mov r4, r0
	bl MI_CpuFill8
	sub r0, r5, #1
	cmp r5, #1
	add r6, r6, r0
	ble _020C8BF8
_020C8BD8:
	ldrb r1, [r6]
	ldrb r0, [r6, #-1]
	sub r5, r5, #2
	cmp r5, #1
	add r0, r1, r0, lsl #8
	strh r0, [r4], #2
	sub r6, r6, #2
	bgt _020C8BD8
_020C8BF8:
	cmp r5, #0
	ldrgtb r0, [r6]
	strgth r0, [r4]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C8BAC

	arm_func_start sub_20C8C0C
sub_20C8C0C: // 0x020C8C0C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	mov r10, r3
	mov r3, #0x16
	mul r4, r10, r3
	ldr r3, _020C8E3C // =0x02145840
	mov r11, r0
	ldr r3, [r3]
	mov r0, r4
	ldr r9, [sp, #0x58]
	str r1, [sp, #0x14]
	str r2, [sp, #0x18]
	blx r3
	str r0, [sp, #0x1c]
	cmp r0, #0
	addeq sp, sp, #0x34
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	mov r2, r4
	mov r1, #0
	bl MI_CpuFill8
	ldr r0, [sp, #0x1c]
	mov r1, r10
	add r6, r0, r10, lsl #1
	add r0, r6, r10, lsl #1
	add r5, r0, r10, lsl #1
	add r4, r5, r10, lsl #1
	str r0, [sp, #0x20]
	add r0, r4, r10, lsl #1
	str r0, [sp, #0x24]
	add r7, r0, r10, lsl #1
	mov r0, r9
	bl sub_20C9A7C
	mov r8, r0
	ldr r0, [sp, #0x1c]
	mov r2, #1
	mov r1, r8, lsl #1
	strh r2, [r0, r1]
	ldr r0, [sp, #0x20]
	ldr r1, [sp, #0x1c]
	str r0, [sp]
	mov r0, r6
	mov r2, r9
	mov r3, r10
	bl sub_20C8F88
	ldr r1, [sp, #0x1c]
	mov r0, r5
	mov r2, r6
	mov r3, r10
	bl sub_20C9664
	mov r0, r6
	mov r1, r5
	mov r2, #1
	mov r3, r10
	bl sub_20C97A4
	str r10, [sp]
	mov r0, r6
	mov r1, r6
	mov r2, r9
	mov r3, #0
	str r7, [sp, #4]
	bl sub_20C929C
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x20]
	ldr r2, [sp, #0x1c]
	mov r3, r10
	bl sub_20C9664
	ldr r1, [sp, #0x20]
	str r10, [sp]
	mov r0, #0
	mov r2, r9
	mov r3, r1
	str r7, [sp, #4]
	bl sub_20C929C
	str r10, [sp]
	ldr r1, [sp, #0x1c]
	mov r0, #0
	mov r2, r9
	mov r3, r11
	str r7, [sp, #4]
	bl sub_20C929C
	movs r0, r8, lsl #4
	mov r7, #0
	str r0, [sp, #0x28]
	beq _020C8DF8
	mov r0, #1
	str r0, [sp, #0x2c]
	mov r0, #0x8000
	str r0, [sp, #0x30]
_020C8D70:
	str r8, [sp]
	str r9, [sp, #4]
	str r6, [sp, #8]
	str r5, [sp, #0xc]
	ldr r1, [sp, #0x24]
	ldr r2, [sp, #0x2c]
	mov r0, r11
	mov r3, r10
	str r4, [sp, #0x10]
	bl sub_20C8E44
	ldr r0, [sp, #0x30]
	and r1, r7, #0xf
	mov r0, r0, lsr r1
	sub r1, r8, r7, asr #4
	sub r1, r1, #1
	mov r2, r1, lsl #1
	ldr r1, [sp, #0x18]
	ldrh r1, [r1, r2]
	ands r0, r0, r1
	beq _020C8DE8
	str r8, [sp]
	str r9, [sp, #4]
	str r6, [sp, #8]
	str r5, [sp, #0xc]
	ldr r1, [sp, #0x24]
	ldr r2, [sp, #0x20]
	mov r0, r11
	mov r3, r10
	str r4, [sp, #0x10]
	bl sub_20C8E44
_020C8DE8:
	ldr r0, [sp, #0x28]
	add r7, r7, #1
	cmp r7, r0
	blo _020C8D70
_020C8DF8:
	str r8, [sp]
	str r9, [sp, #4]
	str r6, [sp, #8]
	str r5, [sp, #0xc]
	ldr r1, [sp, #0x24]
	mov r0, r11
	mov r3, r10
	mov r2, #0
	str r4, [sp, #0x10]
	bl sub_20C8E44
	ldr r1, _020C8E40 // =0x0214586C
	ldr r0, [sp, #0x1c]
	ldr r1, [r1]
	blx r1
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C8E3C: .word 0x02145840
_020C8E40: .word 0x0214586C
	arm_func_end sub_20C8C0C

	arm_func_start sub_20C8E44
sub_20C8E44: // 0x020C8E44
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r5, r3
	mov r7, r5, lsl #1
	mov r8, r2
	mov r2, r7
	mov r6, r0
	mov r9, r1
	ldr r4, [sp, #0x20]
	bl MI_CpuCopy8
	cmp r8, #1
	bne _020C8E88
	mov r0, r6
	mov r1, r9
	mov r2, r5
	bl sub_20C9494
	b _020C8EA4
_020C8E88:
	cmp r8, #0
	beq _020C8EA4
	mov r0, r6
	mov r1, r9
	mov r2, r8
	mov r3, r5
	bl sub_20C9664
_020C8EA4:
	ldr r0, [sp, #0x2c]
	ldr r2, [sp, #0x28]
	mov r1, r6
	mov r3, r4
	bl sub_20C9664
	sub r1, r5, r4
	ldr r0, [sp, #0x2c]
	mov r8, r1, lsl #1
	mov r2, r8
	add r0, r0, r4, lsl #1
	mov r1, #0
	bl MI_CpuFill8
	ldr r0, [sp, #0x30]
	ldr r1, [sp, #0x2c]
	ldr r2, [sp, #0x24]
	mov r3, r5
	bl sub_20C9664
	mov r0, r6
	mov r1, r6
	ldr r2, [sp, #0x30]
	mov r3, r5
	bl sub_20C998C
	mov r2, r8
	mov r0, r6
	add r1, r6, r4, lsl #1
	bl memmove
	add r0, r6, r5, lsl #1
	sub r0, r0, r4, lsl #1
	mov r2, r4, lsl #1
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r6
	ldr r1, [sp, #0x24]
	mov r2, r5
	bl sub_20C9768
	cmp r0, #0
	beq _020C8F4C
	cmp r0, #1
	beq _020C8F68
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020C8F4C:
	mov r0, r6
	mov r2, r7
	mov r1, #0
	bl MI_CpuFill8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020C8F68:
	ldr r2, [sp, #0x24]
	mov r0, r6
	mov r1, r6
	mov r3, r5
	bl sub_20C9818
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end sub_20C8E44

	arm_func_start sub_20C8F88
sub_20C8F88: // 0x020C8F88
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	ldr r9, [sp, #0x38]
	mov r10, r3
	add r11, r9, r10, lsl #1
	add r8, r11, r10, lsl #1
	add r7, r8, r10, lsl #1
	add r6, r7, r10, lsl #1
	add r5, r6, r10, lsl #1
	str r0, [sp, #8]
	mov r0, r1
	add r1, r5, r10, lsl #1
	str r1, [sp, #0x10]
	mov r4, r10, lsl #1
	str r2, [sp, #0xc]
	mov r1, r9
	mov r2, r4
	bl MI_CpuCopy8
	ldr r0, [sp, #0xc]
	mov r1, r8
	mov r2, r4
	bl MI_CpuCopy8
	mov r0, #1
	strh r0, [r8, r4]
	mov r0, r9
	mov r1, r10
	bl sub_20C9A38
	cmp r0, #0
	ble _020C9098
_020C8FFC:
	ldr r3, [sp, #0x10]
	str r10, [sp]
	str r3, [sp, #4]
	mov r0, r11
	mov r1, r8
	mov r2, r9
	mov r3, r5
	bl sub_20C929C
	mov r0, r9
	mov r1, r8
	mov r2, r4
	bl MI_CpuCopy8
	mov r0, r5
	mov r1, r9
	mov r2, r4
	bl MI_CpuCopy8
	mov r0, r5
	mov r1, r11
	mov r2, r7
	mov r3, r10
	bl sub_20C9664
	mov r0, r5
	mov r1, r6
	mov r2, r5
	mov r3, r10
	bl sub_20C9818
	mov r0, r7
	mov r1, r6
	mov r2, r4
	bl MI_CpuCopy8
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl MI_CpuCopy8
	mov r0, r9
	mov r1, r10
	bl sub_20C9A38
	cmp r0, #0
	bgt _020C8FFC
_020C9098:
	ldr r2, [sp, #0xc]
	mov r0, r6
	mov r1, r6
	mov r3, r10
	bl sub_20C998C
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #8]
	ldr r4, [sp, #0x10]
	str r10, [sp]
	mov r1, r6
	mov r0, #0
	str r4, [sp, #4]
	bl sub_20C929C
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	arm_func_end sub_20C8F88

	arm_func_start sub_20C90D8
sub_20C90D8: // 0x020C90D8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	ldr r4, _020C9294 // =0x02145840
	mov r8, r3
	ldr r3, [r4]
	mov r10, r0
	mov r0, r8, lsl #3
	ldr r7, [sp, #0x40]
	str r1, [sp, #8]
	mov r9, r2
	blx r3
	movs r6, r0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	sub r1, r8, #1
	add r0, r10, #2
	mov r2, r1, lsl #1
	mov r1, #0
	add r11, r6, r8, lsl #1
	bl MI_CpuFill8
	mov r2, #1
	mov r0, r9
	mov r1, r8
	strh r2, [r10]
	bl sub_20C9A7C
	sub r0, r8, r0
	mov r5, r0, lsl #4
	mov r4, r8, lsl #4
	cmp r5, r4
	bhs _020C919C
	mov r0, #0x8000
_020C9158:
	sub r1, r8, r5, asr #4
	sub r1, r1, #1
	mov r1, r1, lsl #1
	and r2, r5, #0xf
	ldrh r1, [r9, r1]
	mov r2, r0, lsr r2
	ands r1, r2, r1
	beq _020C9190
	ldr r0, [sp, #8]
	mov r1, r10
	mov r2, r8, lsl #1
	bl MI_CpuCopy8
	add r5, r5, #1
	b _020C919C
_020C9190:
	add r5, r5, #1
	cmp r5, r4
	blo _020C9158
_020C919C:
	cmp r5, r4
	bhs _020C9278
	mov r0, r8, lsl #1
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #0x8000
	str r0, [sp, #0x14]
_020C91BC:
	mov r0, r6
	mov r1, r10
	mov r2, r8
	bl sub_20C9494
	ldr r2, [sp, #0xc]
	mov r0, r6
	mov r1, r10
	bl MI_CpuCopy8
	cmp r7, #0
	beq _020C9200
	ldr r0, [sp, #0x10]
	str r8, [sp]
	mov r1, r10
	mov r2, r7
	mov r3, r10
	str r11, [sp, #4]
	bl sub_20C929C
_020C9200:
	sub r0, r8, r5, asr #4
	sub r0, r0, #1
	mov r1, r0, lsl #1
	ldr r0, [sp, #0x14]
	and r2, r5, #0xf
	mov r2, r0, lsr r2
	ldrh r0, [r9, r1]
	ands r0, r2, r0
	beq _020C926C
	ldr r2, [sp, #8]
	mov r0, r6
	mov r1, r10
	mov r3, r8
	bl sub_20C9664
	ldr r2, [sp, #0xc]
	mov r0, r6
	mov r1, r10
	bl MI_CpuCopy8
	cmp r7, #0
	beq _020C926C
	ldr r0, [sp, #0x10]
	str r8, [sp]
	mov r1, r10
	mov r2, r7
	mov r3, r10
	str r11, [sp, #4]
	bl sub_20C929C
_020C926C:
	add r5, r5, #1
	cmp r5, r4
	blo _020C91BC
_020C9278:
	ldr r1, _020C9298 // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C9294: .word 0x02145840
_020C9298: .word 0x0214586C
	arm_func_end sub_20C90D8

	arm_func_start sub_20C929C
sub_20C929C: // 0x020C929C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	ldr r9, [sp, #0x48]
	ldr r6, [sp, #0x4c]
	str r1, [sp, #4]
	add r5, r6, r9, lsl #1
	str r0, [sp]
	mov r10, r2
	mov r0, r5
	mov r2, r9, lsl #2
	mov r1, #0
	str r3, [sp, #8]
	add r4, r5, r9, lsl #1
	bl MI_CpuFill8
	ldr r0, [sp, #4]
	mov r1, r9
	bl sub_20C9A7C
	mov r11, r0
	mov r0, r10
	mov r1, r9
	bl sub_20C9A7C
	mov r7, r0
	cmp r11, #0
	ble _020C9444
	cmp r7, #0
	ble _020C9444
	sub r0, r9, r11
	add r0, r7, r0
	sub r8, r0, #1
	cmp r8, r9
	blt _020C932C
	ldr r0, [sp, #4]
	mov r1, r4
	mov r2, r9, lsl #1
	bl MI_CpuCopy8
	b _020C9444
_020C932C:
	ldr r0, [sp, #4]
	add r1, r5, r8, lsl #1
	mov r2, r11, lsl #1
	bl MI_CpuCopy8
	cmp r7, #2
	ble _020C9360
	add r0, r10, r7, lsl #1
	sub r0, r0, #2
	mov r7, r7, lsl #1
	bl sub_20C8B34
	str r0, [sp, #0x14]
	str r1, [sp, #0x10]
	b _020C939C
_020C9360:
	cmp r7, #1
	ble _020C9384
	add r0, r10, r7, lsl #1
	sub r0, r0, #2
	mov r7, r7, lsl #1
	bl sub_20C8B24
	str r0, [sp, #0x14]
	str r1, [sp, #0x10]
	b _020C939C
_020C9384:
	add r0, r10, r7, lsl #1
	sub r0, r0, #2
	mov r7, r7, lsl #1
	bl sub_20C8B18
	str r0, [sp, #0x14]
	str r1, [sp, #0x10]
_020C939C:
	cmp r8, r9
	bge _020C9444
	mov r0, r9, lsl #1
	sub r0, r0, #1
	mov r11, r0, lsl #1
	add r0, r4, r7
	str r0, [sp, #0x1c]
_020C93B8:
	mov r1, r5
	add r0, r5, #2
	mov r2, r11
	bl memmove
	ldr r0, [sp, #0x1c]
	bl sub_20C8B48
	ldr r2, [sp, #0x14]
	ldr r3, [sp, #0x10]
	bl _ll_udiv
	mov r7, r0
	ldr r0, _020C9490 // =0x0000FFFF
	cmp r7, r0
	movhi r7, r0
_020C93EC:
	mov r2, r7, lsl #0x10
	mov r0, r6
	mov r1, r10
	mov r2, r2, lsr #0x10
	mov r3, r9
	bl sub_20C95E0
	mov r0, r4
	mov r1, r6
	mov r2, r9
	bl sub_20C9768
	cmp r0, #0
	sublt r7, r7, #1
	blt _020C93EC
	mov r0, r4
	mov r1, r4
	mov r2, r6
	mov r3, r9
	bl sub_20C9818
	strh r7, [r5]
	add r8, r8, #1
	cmp r8, r9
	blt _020C93B8
_020C9444:
	ldr r0, [sp]
	cmp r0, #0
	beq _020C9460
	ldr r1, [sp]
	mov r0, r5
	mov r2, r9, lsl #1
	bl MI_CpuCopy8
_020C9460:
	ldr r0, [sp, #8]
	cmp r0, #0
	addeq sp, sp, #0x24
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldr r1, [sp, #8]
	mov r0, r4
	mov r2, r9, lsl #1
	bl MI_CpuCopy8
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C9490: .word 0x0000FFFF
	arm_func_end sub_20C929C

	arm_func_start sub_20C9494
sub_20C9494: // 0x020C9494
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r9, r1
	mov r8, r2
	mov r10, r0
	mov r0, r9
	mov r1, r8
	bl sub_20C9A7C
	mov r11, r0
	mov r0, r11, lsl #1
	cmp r0, r8
	bge _020C94D8
	sub r1, r8, r0
	add r0, r10, r0, lsl #1
	mov r2, r1, lsl #1
	mov r1, #0
	bl MI_CpuFill8
_020C94D8:
	cmp r11, #0
	mov r1, #0
	ble _020C9530
	mov r0, r1
	sub r4, r8, #1
_020C94EC:
	cmp r0, r8
	bge _020C9530
	mov r2, r1, lsl #1
	ldrh r5, [r9, r2]
	mov r2, r0, lsl #1
	cmp r0, r4
	mul r3, r5, r5
	strh r3, [r10, r2]
	beq _020C9530
	add r2, r0, #1
	add r1, r1, #1
	mov r3, r3, lsr #0x10
	mov r2, r2, lsl #1
	strh r3, [r10, r2]
	cmp r1, r11
	add r0, r0, #2
	blt _020C94EC
_020C9530:
	cmp r11, #0
	mov r6, #0
	addle sp, sp, #4
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxle lr
_020C9544:
	add r7, r6, #1
	b _020C95B0
_020C954C:
	mov r1, r7, lsl #1
	mov r0, r6, lsl #1
	ldrh r1, [r9, r1]
	ldrh r0, [r9, r0]
	mul r4, r1, r0
	ldr r0, _020C95DC // =0x7FFF8000
	cmp r4, r0
	bhi _020C9584
	mov r0, r10
	mov r2, r5
	mov r3, r8
	mov r1, r4, lsl #1
	bl sub_20C9720
	b _020C95AC
_020C9584:
	mov r0, r10
	mov r1, r4
	mov r2, r5
	mov r3, r8
	bl sub_20C9720
	mov r0, r10
	mov r1, r4
	mov r2, r5
	mov r3, r8
	bl sub_20C9720
_020C95AC:
	add r7, r7, #1
_020C95B0:
	cmp r7, r11
	bge _020C95C4
	add r5, r6, r7
	cmp r5, r8
	blt _020C954C
_020C95C4:
	add r6, r6, #1
	cmp r6, r11
	blt _020C9544
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C95DC: .word 0x7FFF8000
	arm_func_end sub_20C9494

	arm_func_start sub_20C95E0
sub_20C95E0: // 0x020C95E0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r1
	mov r4, r3
	mov r7, r0
	mov r0, r6
	mov r1, r4
	mov r5, r2
	bl sub_20C9A7C
	mov r3, #0
	mov ip, r3
	cmp r0, #0
	ble _020C9634
_020C9614:
	mov r2, ip, lsl #1
	ldrh r1, [r6, r2]
	add ip, ip, #1
	cmp ip, r0
	mla r1, r5, r1, r3
	strh r1, [r7, r2]
	mov r3, r1, lsr #0x10
	blt _020C9614
_020C9634:
	cmp ip, r4
	movlt r0, ip, lsl #1
	addlt ip, ip, #1
	sub r1, r4, ip
	strlth r3, [r7, r0]
	mov r2, r1, lsl #1
	add r0, r7, ip, lsl #1
	mov r1, #0
	bl MI_CpuFill8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C95E0

	arm_func_start sub_20C9664
sub_20C9664: // 0x020C9664
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r8, r3
	mov r10, r1
	mov r9, r2
	mov r2, r8, lsl #1
	mov r1, #0
	mov r11, r0
	bl MI_CpuFill8
	mov r0, r10
	mov r1, r8
	bl sub_20C9A7C
	mov r5, r0
	mov r0, r9
	mov r1, r8
	bl sub_20C9A7C
	str r0, [sp]
	cmp r0, #0
	mov r7, #0
	addle sp, sp, #0xc
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxle lr
	str r7, [sp, #4]
_020C96C0:
	ldr r6, [sp, #4]
	sub r4, r8, r7
	b _020C96F4
_020C96CC:
	mov r1, r6, lsl #1
	mov r0, r7, lsl #1
	ldrh r2, [r10, r1]
	ldrh r1, [r9, r0]
	mov r0, r11
	mov r3, r8
	mul r1, r2, r1
	add r2, r7, r6
	bl sub_20C9720
	add r6, r6, #1
_020C96F4:
	cmp r6, r5
	bge _020C9704
	cmp r6, r4
	blt _020C96CC
_020C9704:
	ldr r0, [sp]
	add r7, r7, #1
	cmp r7, r0
	blt _020C96C0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	arm_func_end sub_20C9664

	arm_func_start sub_20C9720
sub_20C9720: // 0x020C9720
	stmdb sp!, {lr}
	sub sp, sp, #4
	b _020C9744
_020C972C:
	mov lr, r2, lsl #1
	ldrh ip, [r0, lr]
	add r2, r2, #1
	add r1, r1, ip
	strh r1, [r0, lr]
	mov r1, r1, lsr #0x10
_020C9744:
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	cmp r2, r3
	blt _020C972C
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20C9720

	arm_func_start sub_20C9768
sub_20C9768: // 0x020C9768
	subs ip, r2, #1
	bmi _020C979C
_020C9770:
	mov r2, ip, lsl #1
	ldrh r3, [r1, r2]
	ldrh r2, [r0, r2]
	cmp r2, r3
	movhi r0, #1
	bxhi lr
	cmp r2, r3
	mvnlo r0, #0
	bxlo lr
	subs ip, ip, #1
	bpl _020C9770
_020C979C:
	mov r0, #0
	bx lr
	arm_func_end sub_20C9768

	arm_func_start sub_20C97A4
sub_20C97A4: // 0x020C97A4
	stmdb sp!, {r4, lr}
	cmp r3, #0
	mov r4, #0
	ble _020C97DC
_020C97B4:
	mov lr, r4, lsl #1
	ldrh ip, [r1, lr]
	sub ip, ip, r2
	mov r2, ip, lsr #0x10
	strh ip, [r0, lr]
	ands r2, r2, #1
	beq _020C97DC
	add r4, r4, #1
	cmp r4, r3
	blt _020C97B4
_020C97DC:
	cmp r0, r1
	ldmeqia sp!, {r4, lr}
	bxeq lr
	add r4, r4, #1
	cmp r4, r3
	ldmgeia sp!, {r4, lr}
	bxge lr
_020C97F8:
	mov ip, r4, lsl #1
	ldrh r2, [r1, ip]
	add r4, r4, #1
	cmp r4, r3
	strh r2, [r0, ip]
	blt _020C97F8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C97A4

	arm_func_start sub_20C9818
sub_20C9818: // 0x020C9818
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r1
	mov r5, r3
	mov r8, r0
	mov r6, r2
	mov r0, r7
	mov r1, r5
	bl sub_20C9A7C
	mov r4, r0
	mov r0, r6
	mov r1, r5
	bl sub_20C9A7C
	cmp r4, r0
	movlt r4, r0
	mov r3, #0
	cmp r4, r5
	addne r4, r4, #1
	mov ip, r3
	b _020C9884
_020C9864:
	mov r2, ip, lsl #1
	ldrh r1, [r7, r2]
	ldrh r0, [r6, r2]
	add ip, ip, #1
	sub r0, r1, r0
	add r0, r3, r0
	strh r0, [r8, r2]
	mov r3, r0, asr #0x10
_020C9884:
	cmp ip, r4
	blt _020C9864
	cmp ip, r5
	bge _020C989C
	cmp r3, #0
	bne _020C9864
_020C989C:
	cmp r8, r7
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	cmp r8, r6
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	sub r1, r5, ip
	add r0, r8, ip, lsl #1
	mov r2, r1, lsl #1
	mov r1, #0
	bl MI_CpuFill8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20C9818

	arm_func_start sub_20C98D0
sub_20C98D0: // 0x020C98D0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r3, r1
	cmp r3, #0
	mov ip, #0
	ble _020C9904
_020C98E8:
	mov r2, ip, lsl #1
	ldrh r1, [r0, r2]
	add ip, ip, #1
	cmp ip, r3
	mvn r1, r1
	strh r1, [r0, r2]
	blt _020C98E8
_020C9904:
	mov r1, r0
	mov r2, #1
	bl sub_20C991C
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20C98D0

	arm_func_start sub_20C991C
sub_20C991C: // 0x020C991C
	stmdb sp!, {r4, lr}
	cmp r3, #0
	mov r4, #0
	ble _020C9950
_020C992C:
	mov lr, r4, lsl #1
	ldrh ip, [r1, lr]
	add r2, r2, ip
	strh r2, [r0, lr]
	movs r2, r2, lsr #0x10
	beq _020C9950
	add r4, r4, #1
	cmp r4, r3
	blt _020C992C
_020C9950:
	cmp r0, r1
	ldmeqia sp!, {r4, lr}
	bxeq lr
	add r4, r4, #1
	cmp r4, r3
	ldmgeia sp!, {r4, lr}
	bxge lr
_020C996C:
	mov ip, r4, lsl #1
	ldrh r2, [r1, ip]
	add r4, r4, #1
	cmp r4, r3
	strh r2, [r0, ip]
	blt _020C996C
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C991C

	arm_func_start sub_20C998C
sub_20C998C: // 0x020C998C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r1
	mov r5, r3
	mov r8, r0
	mov r6, r2
	mov r0, r7
	mov r1, r5
	bl sub_20C9A7C
	mov r4, r0
	mov r0, r6
	mov r1, r5
	bl sub_20C9A7C
	cmp r4, r0
	movlt r4, r0
	cmp r4, r5
	addne r4, r4, #1
	mov r3, #0
	mov ip, r3
	cmp r4, #0
	ble _020C9A04
_020C99DC:
	mov r2, ip, lsl #1
	ldrh r1, [r7, r2]
	ldrh r0, [r6, r2]
	add ip, ip, #1
	cmp ip, r4
	add r0, r1, r0
	add r0, r3, r0
	strh r0, [r8, r2]
	mov r3, r0, lsr #0x10
	blt _020C99DC
_020C9A04:
	cmp r8, r7
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	cmp r8, r6
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	sub r1, r5, ip
	add r0, r8, ip, lsl #1
	mov r2, r1, lsl #1
	mov r1, #0
	bl MI_CpuFill8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20C998C

	arm_func_start sub_20C9A38
sub_20C9A38: // 0x020C9A38
	stmdb sp!, {lr}
	sub sp, sp, #4
	sub r2, r1, #1
	mov r2, r2, lsl #1
	ldrh r2, [r0, r2]
	ands r2, r2, #0x8000
	addne sp, sp, #4
	mvnne r0, #0
	ldmneia sp!, {lr}
	bxne lr
	bl sub_20C9A7C
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20C9A38

	arm_func_start sub_20C9A7C
sub_20C9A7C: // 0x020C9A7C
	b _020C9A84
_020C9A80:
	sub r1, r1, #1
_020C9A84:
	cmp r1, #0
	beq _020C9AA0
	sub r2, r1, #1
	mov r2, r2, lsl #1
	ldrh r2, [r0, r2]
	cmp r2, #0
	beq _020C9A80
_020C9AA0:
	mov r0, r1
	bx lr
	arm_func_end sub_20C9A7C
