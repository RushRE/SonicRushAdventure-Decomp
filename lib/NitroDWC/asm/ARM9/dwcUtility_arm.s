	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start ovl08_2159BE4
ovl08_2159BE4: // 0x02159BE4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _02159CC4 // =0x0217E7A4
	mov r1, #0x28
	ldr r0, [r0]
	ldrb r0, [r0, #9]
	add r0, r0, #1
	bl FX_ModS32
	ldr r2, _02159CC4 // =0x0217E7A4
	mov r1, #5
	ldr r3, [r2]
	strb r0, [r3, #9]
	ldr r0, [r2]
	ldrb r0, [r0, #9]
	bl FX_DivS32
	ldr r2, _02159CC4 // =0x0217E7A4
	add r1, r0, #0x47
	ldr r2, [r2]
	mov r0, #0
	ldr r2, [r2, #4]
	bl ovl08_217559C
	ldr r3, _02159CC4 // =0x0217E7A4
	ldr lr, _02159CC8 // =0x0217A528
	ldr r0, [r3]
	ldr r2, _02159CCC // =0x0217A52C
	ldr r5, [r0, #4]
	ldr r1, _02159CD0 // =0xFE00FF00
	ldrh r4, [r5, #4]
	ldr r0, _02159CD4 // =0x000001FF
	bic r4, r4, #0xc00
	orr r4, r4, #0x400
	strh r4, [r5, #4]
	ldr r4, [r3]
	ldrb r5, [r4, #8]
	ldr ip, [r4, #4]
	ldr r4, [ip]
	ldrb lr, [lr, r5]
	bic r4, r4, #0xc00
	str r4, [ip]
	ldrh r4, [ip, #4]
	bic r4, r4, #0xf000
	orr r4, r4, lr, lsl #12
	strh r4, [ip, #4]
	ldr r4, [r3]
	ldrh r3, [r2, #2]
	ldr r4, [r4, #4]
	ldrh lr, [r2]
	ldr ip, [r4]
	and r2, r3, #0xff
	and r1, ip, r1
	and r3, lr, r0
	orr r0, r1, r2
	orr r0, r0, r3, lsl #16
	str r0, [r4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02159CC4: .word 0x0217E7A4
_02159CC8: .word 0x0217A528
_02159CCC: .word 0x0217A52C
_02159CD0: .word 0xFE00FF00
_02159CD4: .word 0x000001FF
	arm_func_end ovl08_2159BE4

	arm_func_start ovl08_2159CD8
ovl08_2159CD8: // 0x02159CD8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _02159D14 // =0x0217E7A4
	mov r0, #1
	ldr r1, [r1]
	ldr r1, [r1]
	bl ovl08_2177864
	ldr r0, _02159D14 // =0x0217E7A4
	ldr r0, [r0]
	ldr r0, [r0, #4]
	bl ovl08_21770F8
	ldr r0, _02159D14 // =0x0217E7A4
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02159D14: .word 0x0217E7A4
	arm_func_end ovl08_2159CD8

	arm_func_start ovl08_2159D18
ovl08_2159D18: // 0x02159D18
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r0, #0xc
	mov r1, #4
	bl ovl08_2176764
	ldr r2, _02159DF8 // =0x0217E7A4
	mov r1, #0x47
	str r0, [r2]
	strb r4, [r0, #8]
	mov r0, #0
	bl ovl08_2175570
	ldr r7, _02159DF8 // =0x0217E7A4
	ldr r8, _02159DFC // =0x0217A528
	ldr r1, [r7]
	ldr r6, _02159E00 // =0x0217A52C
	str r0, [r1, #4]
	ldr r0, [r7]
	ldr lr, _02159E04 // =0x000001FF
	ldr r3, [r0, #4]
	ldr r5, _02159E08 // =0xFE00FF00
	ldrh r2, [r3, #4]
	mov r0, #1
	ldr r1, _02159E0C // =ovl08_2159BE4
	bic r2, r2, #0xc00
	orr r2, r2, #0x400
	strh r2, [r3, #4]
	ldr r3, [r7]
	mov r2, #0
	ldr ip, [r3, #4]
	mov r3, #0x78
	ldr r9, [ip]
	bic r9, r9, #0xc00
	str r9, [ip]
	ldrb r4, [r8, r4]
	ldrh r8, [ip, #4]
	bic r8, r8, #0xf000
	orr r4, r8, r4, lsl #12
	strh r4, [ip, #4]
	ldr r4, [r7]
	ldrh r7, [r6]
	ldr ip, [r4, #4]
	ldrh r4, [r6, #2]
	and r7, r7, lr
	ldr r6, [ip]
	and r4, r4, #0xff
	and r5, r6, r5
	orr r4, r5, r4
	orr r4, r4, r7, lsl #16
	str r4, [ip]
	bl ovl08_2177924
	ldr r1, _02159DF8 // =0x0217E7A4
	ldr r1, [r1]
	str r0, [r1]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02159DF8: .word 0x0217E7A4
_02159DFC: .word 0x0217A528
_02159E00: .word 0x0217A52C
_02159E04: .word 0x000001FF
_02159E08: .word 0xFE00FF00
_02159E0C: .word ovl08_2159BE4
	arm_func_end ovl08_2159D18

	arm_func_start ovl08_2159E10
ovl08_2159E10: // 0x02159E10
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r4, _02159F0C // =0x0217E7A8
	str r0, [sp]
	ldr r1, [r4]
	ldrh r0, [r1, #0x14]
	add r0, r0, #1
	strh r0, [r1, #0x14]
	ldr r1, [r4]
	ldrh r0, [r1, #0x14]
	cmp r0, #0x10
	addlo sp, sp, #4
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r1, [r1, #0x17]
	ldr r0, _02159F10 // =0x0217A538
	mov r9, #0
	ldrb r10, [r0, r1]
	cmp r10, #0
	ble _02159EBC
	mov r7, r9
	mov r11, r9
	mvn r6, #0
	mov r5, #1
_02159E6C:
	ldr r0, [r4]
	ldr r2, _02159F14 // =0x0217A548
	ldrb r3, [r0, #0x17]
	ldr r0, [r0, r9, lsl #2]
	mov r1, r7
	add r2, r2, r3, lsl #1
	ldrb r8, [r9, r2]
	bl ovl08_21751F8
	mov r2, r0
	mov r1, r8
	mov r0, r11
	bl ovl08_217559C
	ldr r0, [r4]
	mov r1, r6
	ldr r0, [r0, r9, lsl #2]
	mov r2, r5
	bl ovl08_2174F30
	add r9, r9, #1
	cmp r9, r10
	blt _02159E6C
_02159EBC:
	ldr r0, _02159F18 // =0x0217A530
	ldrh r0, [r0, #2]
	bl ovl08_215A25C
	ldr r1, _02159F0C // =0x0217E7A8
	mov r0, #0
	ldr r2, [r1]
	mvn r3, #0
	strh r0, [r2, #0x14]
	ldr r2, [r1]
	strb r3, [r2, #0x16]
	ldr r2, [r1]
	ldr r1, [r2, #0x10]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp]
	str r0, [r2, #0x10]
	bl ovl08_2177870
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02159F0C: .word 0x0217E7A8
_02159F10: .word 0x0217A538
_02159F14: .word 0x0217A548
_02159F18: .word 0x0217A530
	arm_func_end ovl08_2159E10

	arm_func_start ovl08_2159F1C
ovl08_2159F1C: // 0x02159F1C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r1, r0
	mov r0, #0
	bl ovl08_2177870
	ldr r0, _02159F94 // =0x0217E7A8
	ldr r0, [r0]
	ldr r1, [r0, #0x10]
	cmp r1, #0
	beq _02159F4C
	mov r0, #0
	bl ovl08_2177870
_02159F4C:
	ldr r4, _02159F94 // =0x0217E7A8
	mov r5, #0
_02159F54:
	ldr r0, [r4]
	ldr r0, [r0, r5, lsl #2]
	cmp r0, #0
	beq _02159F68
	bl ovl08_2175204
_02159F68:
	add r5, r5, #1
	cmp r5, #2
	blt _02159F54
	ldr r0, _02159F94 // =0x0217E7A8
	ldr r0, [r0]
	ldr r0, [r0, #8]
	bl ovl08_2175204
	ldr r0, _02159F94 // =0x0217E7A8
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02159F94: .word 0x0217E7A8
	arm_func_end ovl08_2159F1C

	arm_func_start ovl08_2159F98
ovl08_2159F98: // 0x02159F98
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _02159FF4 // =0x0217E7A8
	mov r4, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0, #8]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r0, [sp, #4]
	add r0, r0, #4
	str r0, [sp, #4]
	bl ovl08_215A25C
	ldr r0, [sp, #4]
	cmp r0, #0xc0
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	ldr r1, _02159FF8 // =ovl08_2159F1C
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02159FF4: .word 0x0217E7A8
_02159FF8: .word ovl08_2159F1C
	arm_func_end ovl08_2159F98

	arm_func_start ovl08_2159FFC
ovl08_2159FFC: // 0x02159FFC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	ldr r8, _0215A16C // =0x0217E7A8
	ldr r1, _0215A170 // =0x0217A538
	ldr r3, [r8]
	ldrb r2, [r3, #0x17]
	ldrb r0, [r3, #0x18]
	ldrb r7, [r1, r2]
	cmp r0, #0
	bne _0215A154
	ldrsb r1, [r3, #0x16]
	mvn r0, #0
	cmp r1, r0
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	cmp r7, #0
	mov r6, #0
	ble _0215A154
	ldr r5, _0215A174 // =0x0217A540
	ldr r4, _0215A178 // =0x0217A558
	ldr r10, _0215A17C // =0x0217A534
	add r9, sp, #0
_0215A054:
	ldr r0, [r8]
	mov r1, r10
	ldrb r0, [r0, #0x17]
	mov r2, r9
	add r0, r4, r0, lsl #1
	ldrb r0, [r6, r0]
	add r0, r5, r0, lsl #2
	bl ovl08_21762F8
	mov r0, r9
	bl ovl08_2176A38
	cmp r0, #0
	beq _0215A148
	ldr r0, _0215A16C // =0x0217E7A8
	ldr r3, [r0]
	ldr r0, [r3, #0x10]
	cmp r0, #0
	bne _0215A154
	ldrb r2, [r3, #0x17]
	ldr r1, _0215A180 // =0x0217A548
	ldr r0, [r3, r6, lsl #2]
	add r1, r1, r2, lsl #1
	ldrb r2, [r6, r1]
	mov r1, #0
	add r4, r2, #1
	bl ovl08_21751F8
	mov r2, r0
	mov r1, r4
	mov r0, #0
	bl ovl08_217559C
	ldr r0, _0215A16C // =0x0217E7A8
	ldr r1, _0215A178 // =0x0217A558
	ldr r0, [r0]
	ldr r2, _0215A174 // =0x0217A540
	ldrb r4, [r0, #0x17]
	ldr r3, _0215A184 // =0x0217A542
	ldr r0, [r0, r6, lsl #2]
	add r1, r1, r4, lsl #1
	ldrb r4, [r6, r1]
	mvn r1, #0
	mov r4, r4, lsl #2
	ldrh r2, [r2, r4]
	ldrh r3, [r3, r4]
	bl ovl08_2174FA4
	ldr r0, _0215A16C // =0x0217E7A8
	mvn r1, #0
	ldr r0, [r0]
	mov r2, #1
	ldr r0, [r0, r6, lsl #2]
	bl ovl08_2174F30
	mov r0, #0
	ldr r1, _0215A188 // =ovl08_2159E10
	mov r2, r0
	mov r3, #0x6e
	bl ovl08_2177924
	ldr r1, _0215A16C // =0x0217E7A8
	add sp, sp, #8
	ldr r2, [r1]
	str r0, [r2, #0x10]
	ldr r0, [r1]
	strb r6, [r0, #0x16]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0215A148:
	add r6, r6, #1
	cmp r6, r7
	blt _0215A054
_0215A154:
	ldr r0, _0215A16C // =0x0217E7A8
	mvn r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x16]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0215A16C: .word 0x0217E7A8
_0215A170: .word 0x0217A538
_0215A174: .word 0x0217A540
_0215A178: .word 0x0217A558
_0215A17C: .word 0x0217A534
_0215A180: .word 0x0217A548
_0215A184: .word 0x0217A542
_0215A188: .word ovl08_2159E10
	arm_func_end ovl08_2159FFC

	arm_func_start ovl08_215A18C
ovl08_215A18C: // 0x0215A18C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0215A1E0 // =0x0217E7A8
	mvn r3, #0
	ldr r2, [r1]
	strb r3, [r2, #0x16]
	ldr r3, [r1]
	ldrh r2, [r3, #0x14]
	add r2, r2, #1
	strh r2, [r3, #0x14]
	ldr r3, [r1]
	ldrh r1, [r3, #0x14]
	cmp r1, #4
	addlo sp, sp, #4
	ldmloia sp!, {pc}
	ldr r1, _0215A1E4 // =ovl08_2159FFC
	mov r2, #0
	strh r2, [r3, #0x14]
	bl ovl08_2177890
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215A1E0: .word 0x0217E7A8
_0215A1E4: .word ovl08_2159FFC
	arm_func_end ovl08_215A18C

	arm_func_start ovl08_215A1E8
ovl08_215A1E8: // 0x0215A1E8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215A250 // =0x0217E7A8
	mov r4, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0, #8]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r0, [sp, #4]
	sub r0, r0, #4
	str r0, [sp, #4]
	bl ovl08_215A25C
	ldr r0, _0215A254 // =0x0217A530
	ldr r1, [sp, #4]
	ldrh r0, [r0, #2]
	cmp r1, r0
	addgt sp, sp, #8
	ldmgtia sp!, {r4, pc}
	bl ovl08_215A25C
	ldr r1, _0215A258 // =ovl08_215A18C
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215A250: .word 0x0217E7A8
_0215A254: .word 0x0217A530
_0215A258: .word ovl08_215A18C
	arm_func_end ovl08_215A1E8

	arm_func_start ovl08_215A25C
ovl08_215A25C: // 0x0215A25C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r2, _0215A2F4 // =0x0217E7A8
	ldr r3, _0215A2F8 // =0x0217A538
	ldr r6, [r2]
	ldr r2, _0215A2FC // =0x0217A540
	ldrb r4, [r6, #0x17]
	ldrh r2, [r2, #2]
	ldr r1, _0215A300 // =0x0217A530
	ldrb r8, [r3, r4]
	mov r3, r0
	add r5, r3, r2
	ldrh r4, [r1, #2]
	ldrh r2, [r1]
	ldr r0, [r6, #8]
	mvn r1, #0
	sub r7, r5, r4
	bl ovl08_2174FA4
	mov r6, #0
	cmp r8, #0
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r9, _0215A2F4 // =0x0217E7A8
	ldr r4, _0215A304 // =0x0217A558
	ldr r10, _0215A2FC // =0x0217A540
	mvn r5, #0
_0215A2BC:
	ldr r0, [r9]
	mov r1, r5
	ldrb r2, [r0, #0x17]
	ldr r0, [r0, r6, lsl #2]
	mov r3, r7
	add r2, r4, r2, lsl #1
	ldrb r2, [r6, r2]
	mov r2, r2, lsl #2
	ldrh r2, [r10, r2]
	bl ovl08_2174FA4
	add r6, r6, #1
	cmp r6, r8
	blt _0215A2BC
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0215A2F4: .word 0x0217E7A8
_0215A2F8: .word 0x0217A538
_0215A2FC: .word 0x0217A540
_0215A300: .word 0x0217A530
_0215A304: .word 0x0217A558
	arm_func_end ovl08_215A25C

	arm_func_start ovl08_215A308
ovl08_215A308: // 0x0215A308
	ldr r0, _0215A31C // =0x0217E7A8
	mov r1, #1
	ldr r0, [r0]
	strb r1, [r0, #0x18]
	bx lr
	.align 2, 0
_0215A31C: .word 0x0217E7A8
	arm_func_end ovl08_215A308

	arm_func_start ovl08_215A320
ovl08_215A320: // 0x0215A320
	ldr r0, _0215A334 // =0x0217E7A8
	mov r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x18]
	bx lr
	.align 2, 0
_0215A334: .word 0x0217E7A8
	arm_func_end ovl08_215A320

	arm_func_start ovl08_215A338
ovl08_215A338: // 0x0215A338
	ldr r0, _0215A360 // =0x0217E7A8
	ldr r0, [r0]
	cmp r0, #0
	moveq r0, #1
	bxeq lr
	ldrb r0, [r0, #0x19]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_0215A360: .word 0x0217E7A8
	arm_func_end ovl08_215A338

	arm_func_start ovl08_215A364
ovl08_215A364: // 0x0215A364
	ldr r1, _0215A374 // =0x0217E7A8
	ldr r1, [r1]
	strb r0, [r1, #0x16]
	bx lr
	.align 2, 0
_0215A374: .word 0x0217E7A8
	arm_func_end ovl08_215A364

	arm_func_start ovl08_215A378
ovl08_215A378: // 0x0215A378
	ldr r2, _0215A394 // =0x0217E7A8
	mvn r1, #0
	ldr r3, [r2]
	ldrsb r2, [r3, #0x16]
	cmp r2, r1
	streqb r0, [r3, #0x16]
	bx lr
	.align 2, 0
_0215A394: .word 0x0217E7A8
	arm_func_end ovl08_215A378

	arm_func_start ovl08_215A398
ovl08_215A398: // 0x0215A398
	ldr r0, _0215A3A8 // =0x0217E7A8
	ldr r0, [r0]
	ldrsb r0, [r0, #0x16]
	bx lr
	.align 2, 0
_0215A3A8: .word 0x0217E7A8
	arm_func_end ovl08_215A398

	arm_func_start ovl08_215A3AC
ovl08_215A3AC: // 0x0215A3AC
	ldr r0, _0215A3D0 // =0x0217E7A8
	mov r3, #1
	ldr r2, [r0]
	ldr ip, _0215A3D4 // =ovl08_2177890
	strb r3, [r2, #0x19]
	ldr r0, [r0]
	ldr r1, _0215A3D8 // =ovl08_2159F98
	ldr r0, [r0, #0xc]
	bx ip
	.align 2, 0
_0215A3D0: .word 0x0217E7A8
_0215A3D4: .word ovl08_2177890
_0215A3D8: .word ovl08_2159F98
	arm_func_end ovl08_215A3AC

	arm_func_start ovl08_215A3DC
ovl08_215A3DC: // 0x0215A3DC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r2, _0215A4C8 // =0x0217A538
	mov r4, r0
	mov r0, #0x1c
	mov r1, #4
	ldrb r8, [r2, r4]
	bl ovl08_2176764
	ldr r9, _0215A4CC // =0x0217E7A8
	mvn r1, #1
	str r0, [r9]
	strb r1, [r0, #0x16]
	ldr r0, [r9]
	cmp r8, #0
	strb r4, [r0, #0x17]
	mov r7, #0
	ble _0215A46C
	ldr r0, _0215A4D0 // =0x0217A548
	add r6, r0, r4, lsl #1
	mov r5, r7
	mov r4, #1
	mvn r10, #0
_0215A430:
	ldrb r1, [r6]
	mov r0, r5
	mov r2, r4
	bl ovl08_2175528
	ldr r2, [r9]
	mov r1, r10
	str r0, [r2, r7, lsl #2]
	ldr r0, [r9]
	mov r2, r4
	ldr r0, [r0, r7, lsl #2]
	bl ovl08_2174F30
	add r7, r7, #1
	cmp r7, r8
	add r6, r6, #1
	blt _0215A430
_0215A46C:
	mov r1, #1
	mov r2, r1
	mov r0, #0
	bl ovl08_2175528
	ldr r3, _0215A4CC // =0x0217E7A8
	mvn r1, #0
	ldr r4, [r3]
	mov r2, #1
	str r0, [r4, #8]
	ldr r0, [r3]
	ldr r0, [r0, #8]
	bl ovl08_2174F30
	mov r0, #0xc0
	bl ovl08_215A25C
	mov r0, #0
	ldr r1, _0215A4D4 // =ovl08_215A1E8
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _0215A4CC // =0x0217E7A8
	ldr r1, [r1]
	str r0, [r1, #0xc]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0215A4C8: .word 0x0217A538
_0215A4CC: .word 0x0217E7A8
_0215A4D0: .word 0x0217A548
_0215A4D4: .word ovl08_215A1E8
	arm_func_end ovl08_215A3DC

	arm_func_start ovl08_215A4D8
ovl08_215A4D8: // 0x0215A4D8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0215A518 // =0x0217E7AC
	ldrb r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	mov r0, #1
	bl ovl08_2175D6C
	ldr r0, _0215A518 // =0x0217E7AC
	mov r1, #0
	strb r1, [r0]
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215A518: .word 0x0217E7AC
	arm_func_end ovl08_215A4D8

	arm_func_start ovl08_215A51C
ovl08_215A51C: // 0x0215A51C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	ldr r3, _0215A5DC // =0x0217E7AC
	mov r7, r0
	ldrb r0, [r3]
	mov r6, r1
	mov r5, r2
	cmp r0, #0
	addne sp, sp, #0x14
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0215A5E0 // =aCharJtnullNscL
	ldr r1, _0215A5E4 // =GXS_LoadBG0Scr
	bl ovl08_215A7F8
	ldr r3, _0215A5E8 // =0x01920000
	ldr r2, _0215A5EC // =0x04001010
	mov r0, #1
	mov r1, #0
	str r3, [r2]
	bl ovl08_2175F00
	ldr r1, _0215A5F0 // =0x0217E83C
	mov r4, r0
	ldr r0, [r1]
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl ovl08_215EC18
	mov r5, r0
	bl ovl08_215A60C
	ldr r3, _0215A5F4 // =0x0217A568
	mov r1, #2
	ldrh r2, [r3, #6]
	str r2, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r5, [sp, #0xc]
	mov r0, r4
	ldrh r1, [r3]
	ldrh r2, [r3, #2]
	ldrh r3, [r3, #4]
	bl ovl08_2175C00
	mov r0, r4
	bl ovl08_2175B20
	mov r0, #1
	ldr r1, _0215A5DC // =0x0217E7AC
	strb r0, [r1]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215A5DC: .word 0x0217E7AC
_0215A5E0: .word aCharJtnullNscL
_0215A5E4: .word GXS_LoadBG0Scr
_0215A5E8: .word 0x01920000
_0215A5EC: .word 0x04001010
_0215A5F0: .word 0x0217E83C
_0215A5F4: .word 0x0217A568
	arm_func_end ovl08_215A51C

	arm_func_start ovl08_215A5F8
ovl08_215A5F8: // 0x0215A5F8
	ldr r0, _0215A608 // =0x0217E7AC
	mov r1, #0
	strb r1, [r0]
	bx lr
	.align 2, 0
_0215A608: .word 0x0217E7AC
	arm_func_end ovl08_215A5F8

	arm_func_start ovl08_215A60C
ovl08_215A60C: // 0x0215A60C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215E600
	ldr r1, _0215A628 // =_0217A588
	ldr r0, [r1, r0, lsl #2]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215A628: .word _0217A588
	arm_func_end ovl08_215A60C

	arm_func_start ovl08_215A62C
ovl08_215A62C: // 0x0215A62C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r5, r0
	mov r0, #0
	mov r6, r1
	mov r1, r0
	bl ovl08_2175F00
	ldr r1, _0215A6E0 // =0x0217E83C
	mov r4, r0
	ldr r0, [r1]
	mov r1, r6
	bl ovl08_215EC54
	mov r6, r0
	bl ovl08_215A60C
	ldr r3, _0215A6E4 // =0x0217A570
	mov r1, #2
	ldrh r2, [r3, #6]
	str r2, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r6, [sp, #0xc]
	ldrh r1, [r3]
	ldrh r2, [r3, #2]
	ldrh r3, [r3, #4]
	mov r0, r4
	bl ovl08_2175C00
	bl ovl08_215E600
	mov r6, r0
	bl ovl08_215E600
	ldr r1, _0215A6E8 // =0x00000209
	mov r3, r0, lsl #2
	str r1, [sp]
	ldr r1, _0215A6EC // =0x0217A5A4
	ldr r2, _0215A6F0 // =0x0217A5A6
	str r5, [sp, #4]
	mov ip, r6, lsl #2
	ldrh r2, [r2, r3]
	ldrh r1, [r1, ip]
	mov r0, r4
	mov r3, #2
	bl ovl08_2175D44
	mov r0, r4
	bl ovl08_2175B20
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215A6E0: .word 0x0217E83C
_0215A6E4: .word 0x0217A570
_0215A6E8: .word 0x00000209
_0215A6EC: .word 0x0217A5A4
_0215A6F0: .word 0x0217A5A6
	arm_func_end ovl08_215A62C

	arm_func_start ovl08_215A6F4
ovl08_215A6F4: // 0x0215A6F4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r4, r0
	mov r0, #0
	mov r1, r0
	bl ovl08_2175F00
	ldr r1, _0215A768 // =0x0217E83C
	mov r5, r0
	ldr r0, [r1]
	mov r1, r4
	bl ovl08_215EC54
	mov r4, r0
	bl ovl08_215A60C
	ldr r3, _0215A76C // =0x0217A578
	mov r1, #2
	ldrh r2, [r3, #6]
	str r2, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	mov r0, r5
	ldrh r1, [r3]
	ldrh r2, [r3, #2]
	ldrh r3, [r3, #4]
	bl ovl08_2175C00
	mov r0, r5
	bl ovl08_2175B20
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215A768: .word 0x0217E83C
_0215A76C: .word 0x0217A578
	arm_func_end ovl08_215A6F4

	arm_func_start ovl08_215A770
ovl08_215A770: // 0x0215A770
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r1, sp, #0
	mov r0, #0
	bl ovl08_215E64C
	ldr r0, [sp]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl08_215A3DC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl08_215A770

	arm_func_start ovl08_215A7A8
ovl08_215A7A8: // 0x0215A7A8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, sp, #0
	mov r1, #0
	bl ovl08_215E64C
	ldr r0, [sp]
	cmp r0, #1
	bne _0215A7DC
	mov r0, r4
	bl ovl08_21704A8
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215A7DC:
	cmp r0, #2
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl08_216FF08
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl08_215A7A8

	arm_func_start ovl08_215A7F8
ovl08_215A7F8: // 0x0215A7F8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r1
	bl ovl08_215A840
	add r1, sp, #0
	mov r2, #4
	bl ovl08_2174AF4
	ldr r1, [sp]
	mov r4, r0
	bl DC_FlushRange
	ldr r2, [sp]
	mov r0, r4
	mov r1, #0
	blx r5
	mov r0, r4
	bl ovl08_2174AB8
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end ovl08_215A7F8

	arm_func_start ovl08_215A840
ovl08_215A840: // 0x0215A840
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _0215A898 // =0x0217E7B0
	mov r1, r4
	mov r2, #0x3f
	bl strncpy
	ldrb r0, [r4, #5]
	cmp r0, #0x78
	ldreq r0, _0215A898 // =0x0217E7B0
	ldmeqia sp!, {r4, pc}
	bl ovl08_215E600
	ldrb r1, [r4, #5]
	cmp r1, #0x79
	bne _0215A884
	cmp r0, #0
	ldrne r0, _0215A898 // =0x0217E7B0
	ldmneia sp!, {r4, pc}
_0215A884:
	ldr r1, _0215A89C // =aJefgisk
	ldrb r1, [r1, r0]
	ldr r0, _0215A898 // =0x0217E7B0
	strb r1, [r0, #5]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215A898: .word 0x0217E7B0
_0215A89C: .word aJefgisk
	arm_func_end ovl08_215A840

	arm_func_start ovl08_215A8A0
ovl08_215A8A0: // 0x0215A8A0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, #0
	ldr r4, _0215A8DC // =0x0217E7F0
	mov r5, r6
_0215A8B0:
	ldr r0, [r4]
	ldr r0, [r0, r6, lsl #2]
	cmp r0, #0
	beq _0215A8CC
	bl ovl08_2175204
	ldr r0, [r4]
	str r5, [r0, r6, lsl #2]
_0215A8CC:
	add r6, r6, #1
	cmp r6, #4
	blt _0215A8B0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215A8DC: .word 0x0217E7F0
	arm_func_end ovl08_215A8A0

	arm_func_start ovl08_215A8E0
ovl08_215A8E0: // 0x0215A8E0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r0
	mov r11, r1
	str r2, [sp]
	str r3, [sp, #4]
	mov r9, #6
	bl ovl08_215A8A0
	mov r8, #0
	ldr r4, _0215A9C8 // =0x0217E7F0
	mov r7, r8
	mov r6, #1
	mvn r5, #0
_0215A914:
	mov r0, r7
	mov r1, r9
	mov r2, r6
	bl ovl08_2175528
	ldr r2, [r4]
	mov r1, r5
	str r0, [r2, r8, lsl #2]
	ldr r0, [r4]
	mov r2, r6
	ldr r0, [r0, r8, lsl #2]
	bl ovl08_2174F30
	add r8, r8, #1
	cmp r8, #4
	add r9, r9, #1
	blt _0215A914
	ldr r0, _0215A9C8 // =0x0217E7F0
	ldr r3, [sp]
	ldr r0, [r0]
	mov r2, r10
	ldr r0, [r0]
	mvn r1, #0
	bl ovl08_2174FA4
	ldr r0, _0215A9C8 // =0x0217E7F0
	ldr r3, [sp]
	ldr r0, [r0]
	mov r2, r11
	ldr r0, [r0, #4]
	mvn r1, #0
	bl ovl08_2174FA4
	ldr r0, _0215A9C8 // =0x0217E7F0
	ldr r3, [sp, #4]
	ldr r0, [r0]
	mov r2, r10
	ldr r0, [r0, #8]
	mvn r1, #0
	bl ovl08_2174FA4
	ldr r0, _0215A9C8 // =0x0217E7F0
	ldr r3, [sp, #4]
	ldr r0, [r0]
	mov r2, r11
	ldr r0, [r0, #0xc]
	mvn r1, #0
	bl ovl08_2174FA4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215A9C8: .word 0x0217E7F0
	arm_func_end ovl08_215A8E0

	arm_func_start ovl08_215A9CC
ovl08_215A9CC: // 0x0215A9CC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r11, r1
	str r2, [sp]
	mov r10, r3
	bl ovl08_215A8A0
	ldr r0, _0215AA80 // =0x0217A5C0
	mov r9, #0
	add r8, r0, r4, lsl #1
	ldr r4, _0215AA84 // =0x0217E7F0
	mov r7, r9
	mov r6, #1
	mvn r5, #0
_0215AA04:
	ldrb r1, [r8]
	mov r0, r7
	mov r2, r6
	bl ovl08_2175528
	ldr r2, [r4]
	mov r1, r5
	str r0, [r2, r9, lsl #2]
	ldr r0, [r4]
	mov r2, r6
	ldr r0, [r0, r9, lsl #2]
	bl ovl08_2174F30
	add r9, r9, #1
	cmp r9, #2
	add r8, r8, #1
	blt _0215AA04
	ldr r0, _0215AA84 // =0x0217E7F0
	mov r2, r11
	ldr r0, [r0]
	mov r3, r10
	ldr r0, [r0]
	mvn r1, #0
	bl ovl08_2174FA4
	ldr r0, _0215AA84 // =0x0217E7F0
	ldr r2, [sp]
	ldr r0, [r0]
	mov r3, r10
	ldr r0, [r0, #4]
	mvn r1, #0
	bl ovl08_2174FA4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215AA80: .word 0x0217A5C0
_0215AA84: .word 0x0217E7F0
	arm_func_end ovl08_215A9CC

	arm_func_start ovl08_215AA88
ovl08_215AA88: // 0x0215AA88
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A8A0
	ldr r0, _0215AAA4 // =0x0217E7F0
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215AAA4: .word 0x0217E7F0
	arm_func_end ovl08_215AA88

	arm_func_start ovl08_215AAA8
ovl08_215AAA8: // 0x0215AAA8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0x10
	mov r1, #4
	bl ovl08_2176764
	ldr r1, _0215AACC // =0x0217E7F0
	str r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215AACC: .word 0x0217E7F0
	arm_func_end ovl08_215AAA8

	arm_func_start ovl08_215AAD0
ovl08_215AAD0: // 0x0215AAD0
	stmdb sp!, {r4, lr}
	ldr r1, _0215AB0C // =0x0217E7F4
	mov r4, r0
	ldr r0, [r1]
	mov r1, #0xc0
	bl DC_FlushRange
	ldr r0, _0215AB0C // =0x0217E7F4
	mov r1, #0
	ldr r0, [r0]
	mov r2, #0xc0
	bl GX_LoadBG1Scr
	mov r1, r4
	mov r0, #1
	bl ovl08_2177870
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215AB0C: .word 0x0217E7F4
	arm_func_end ovl08_215AAD0

	arm_func_start ovl08_215AB10
ovl08_215AB10: // 0x0215AB10
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216F84C
	ldrb r0, [r0, #0xf4]
	add r0, r0, #2
	bl ovl08_215AB50
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_215AB10

	arm_func_start ovl08_215AB30
ovl08_215AB30: // 0x0215AB30
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216F84C
	ldrb r0, [r0, #0xf4]
	add r0, r0, #5
	bl ovl08_215AB50
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_215AB30

	arm_func_start ovl08_215AB50
ovl08_215AB50: // 0x0215AB50
	stmdb sp!, {r4, lr}
	ldr r1, _0215ABA0 // =_0217B3A0
	ldr r0, [r1, r0, lsl #2]
	bl ovl08_215A840
	mov r1, #0
	mov r2, #4
	bl ovl08_2174AF4
	ldr r1, _0215ABA4 // =0x0217E7F4
	mov r4, r0
	ldr r1, [r1]
	mov r2, #0xc0
	bl MIi_CpuCopyFast
	mov r0, r4
	bl ovl08_2174AB8
	mov r0, #1
	ldr r1, _0215ABA8 // =ovl08_215AAD0
	mov r2, #0
	mov r3, #0x78
	bl ovl08_2177924
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215ABA0: .word _0217B3A0
_0215ABA4: .word 0x0217E7F4
_0215ABA8: .word ovl08_215AAD0
	arm_func_end ovl08_215AB50

	arm_func_start ovl08_215ABAC
ovl08_215ABAC: // 0x0215ABAC
	ldr ip, _0215ABB8 // =ovl08_2176714
	ldr r0, _0215ABBC // =0x0217E7F4
	bx ip
	.align 2, 0
_0215ABB8: .word ovl08_2176714
_0215ABBC: .word 0x0217E7F4
	arm_func_end ovl08_215ABAC

	arm_func_start ovl08_215ABC0
ovl08_215ABC0: // 0x0215ABC0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0xc0
	mov r1, #4
	bl ovl08_2176788
	ldr r2, _0215AC34 // =0x0217E7F4
	ldr r1, _0215AC38 // =GX_LoadBG1Char
	str r0, [r2]
	ldr r0, _0215AC3C // =aCharJbbghlNcgL
	bl ovl08_215A7F8
	bl ovl08_215E5E8
	cmp r0, #0
	beq _0215AC04
	cmp r0, #1
	beq _0215AC1C
	add sp, sp, #4
	ldmia sp!, {pc}
_0215AC04:
	ldr r0, _0215AC40 // =_0217B3A0
	ldr r1, _0215AC44 // =GX_LoadBG1Scr
	ldr r0, [r0]
	bl ovl08_215A7F8
	add sp, sp, #4
	ldmia sp!, {pc}
_0215AC1C:
	ldr r0, _0215AC40 // =_0217B3A0
	ldr r1, _0215AC44 // =GX_LoadBG1Scr
	ldr r0, [r0, #4]
	bl ovl08_215A7F8
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215AC34: .word 0x0217E7F4
_0215AC38: .word GX_LoadBG1Char
_0215AC3C: .word aCharJbbghlNcgL
_0215AC40: .word _0217B3A0
_0215AC44: .word GX_LoadBG1Scr
	arm_func_end ovl08_215ABC0

	arm_func_start ovl08_215AC48
ovl08_215AC48: // 0x0215AC48
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _0215AD00 // =0x04000208
	mov r4, #0
	ldrh r5, [r0]
	strh r4, [r0]
	bl WM_GetAllowedChannel
	cmp r0, #0x8000
	beq _0215AC74
	bl sub_20F20C0
	mov r4, r0
_0215AC74:
	ldr r2, _0215AD00 // =0x04000208
	ldr r1, _0215AD04 // =0x0217E7F8
	ldrh r0, [r2]
	ldr r3, _0215AD08 // =0x0217A5CC
	mov r0, #0
	strh r5, [r2]
	ldr r2, [r1]
	ldrsb r1, [r2, #8]
	ldr r2, [r2]
	add r1, r3, r1, lsl #2
	ldrb r1, [r4, r1]
	bl ovl08_217559C
	ldr r0, _0215AD0C // =0x0217A5C8
	ldr r2, _0215AD04 // =0x0217E7F8
	ldrh r3, [r0, #2]
	ldr r1, [r2]
	ldrh ip, [r0]
	ldr lr, [r1]
	ldr r0, _0215AD10 // =0x000001FF
	ldr r4, [lr]
	ldr r1, _0215AD14 // =0xFE00FF00
	and r3, r3, #0xff
	and r1, r4, r1
	and r4, ip, r0
	orr r0, r1, r3
	orr r0, r0, r4, lsl #16
	str r0, [lr]
	ldr r0, [r2]
	ldr r1, [r0]
	ldrh r0, [r1, #4]
	bic r0, r0, #0xc00
	orr r0, r0, #0x800
	strh r0, [r1, #4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215AD00: .word 0x04000208
_0215AD04: .word 0x0217E7F8
_0215AD08: .word 0x0217A5CC
_0215AD0C: .word 0x0217A5C8
_0215AD10: .word 0x000001FF
_0215AD14: .word 0xFE00FF00
	arm_func_end ovl08_215AC48

	arm_func_start ovl08_215AD18
ovl08_215AD18: // 0x0215AD18
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0215AD60 // =0x0217E7F8
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r1, [r0, #4]
	mov r0, #0
	bl ovl08_2177864
	ldr r0, _0215AD60 // =0x0217E7F8
	ldr r0, [r0]
	ldr r0, [r0]
	bl ovl08_21770F8
	ldr r0, _0215AD60 // =0x0217E7F8
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215AD60: .word 0x0217E7F8
	arm_func_end ovl08_215AD18

	arm_func_start ovl08_215AD64
ovl08_215AD64: // 0x0215AD64
	stmdb sp!, {r4, lr}
	ldr r1, _0215AE24 // =0x0217E7F8
	mov r4, r0
	ldr r0, [r1]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, #0xc
	mov r1, #4
	bl ovl08_2176788
	ldr r1, _0215AE24 // =0x0217E7F8
	ldr r2, _0215AE28 // =0x0217A5CC
	str r0, [r1]
	strb r4, [r0, #8]
	ldrb r1, [r2, r4, lsl #2]
	mov r0, #0
	bl ovl08_2175570
	ldr r3, _0215AE24 // =0x0217E7F8
	ldr r2, _0215AE2C // =0x0217A5C8
	ldr r4, [r3]
	ldr r1, _0215AE30 // =0xFE00FF00
	str r0, [r4]
	ldr r4, [r3]
	ldrh r0, [r2, #2]
	ldr r4, [r4]
	ldrh lr, [r2]
	ldr ip, [r4]
	and r2, r0, #0xff
	and r1, ip, r1
	ldr r0, _0215AE34 // =0x000001FF
	orr r1, r1, r2
	and r0, lr, r0
	orr r0, r1, r0, lsl #16
	str r0, [r4]
	ldr r1, [r3]
	mov r0, #0
	ldr lr, [r1]
	ldr r1, _0215AE38 // =ovl08_215AC48
	ldrh ip, [lr, #4]
	mov r2, r0
	mov r3, #0x78
	bic ip, ip, #0xc00
	orr ip, ip, #0x800
	strh ip, [lr, #4]
	bl ovl08_2177924
	ldr r1, _0215AE24 // =0x0217E7F8
	ldr r1, [r1]
	str r0, [r1, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215AE24: .word 0x0217E7F8
_0215AE28: .word 0x0217A5CC
_0215AE2C: .word 0x0217A5C8
_0215AE30: .word 0xFE00FF00
_0215AE34: .word 0x000001FF
_0215AE38: .word ovl08_215AC48
	arm_func_end ovl08_215AD64

	arm_func_start ovl08_215AE3C
ovl08_215AE3C: // 0x0215AE3C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r1, r0
	mov r0, #0
	bl ovl08_2177870
	mov r7, #0
	ldr r8, _0215AF18 // =0x0217E7FC
	mov r5, r7
_0215AE58:
	mov r6, r5
	mov r4, r7, lsl #4
_0215AE60:
	ldr r0, [r8]
	add r0, r4, r0
	ldr r0, [r0, r6, lsl #2]
	bl ovl08_2176088
	cmp r7, #0
	bne _0215AE88
	ldr r0, [r8]
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x104]
	bl ovl08_2175204
_0215AE88:
	add r6, r6, #1
	cmp r6, #4
	blt _0215AE60
	add r7, r7, #1
	cmp r7, #3
	blt _0215AE58
	ldr r4, _0215AF18 // =0x0217E7FC
	mov r5, #0
_0215AEA8:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0xfc]
	bl ovl08_2175204
	add r5, r5, #1
	cmp r5, #2
	blt _0215AEA8
	ldr r4, _0215AF18 // =0x0217E7FC
	mov r5, #0
_0215AECC:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0xec]
	bl ovl08_21770F8
	add r5, r5, #1
	cmp r5, #4
	blt _0215AECC
	ldr r4, _0215AF18 // =0x0217E7FC
	mov r5, #0
_0215AEF0:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x30]
	bl ovl08_21770F8
	add r5, r5, #1
	cmp r5, #0x2f
	blt _0215AEF0
	ldr r0, _0215AF18 // =0x0217E7FC
	bl ovl08_2176714
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215AF18: .word 0x0217E7FC
	arm_func_end ovl08_215AE3C

	arm_func_start ovl08_215AF1C
ovl08_215AF1C: // 0x0215AF1C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215AF8C // =0x0217E7FC
	ldr r2, _0215AF90 // =0x01FF0000
	ldr ip, [r1]
	mov r4, r0
	ldr r3, [ip, #0x30]
	mov r1, #0
	ldr r0, [r3]
	and r0, r0, r2
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [r3]
	and r0, r0, #0xff
	str r0, [sp, #4]
	add r2, r0, #0xc
	str r2, [sp, #4]
	ldrb r0, [ip, #0x11d]
	bl ovl08_215B860
	ldr r0, [sp, #4]
	cmp r0, #0xc0
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	ldr r1, _0215AF94 // =ovl08_215AE3C
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215AF8C: .word 0x0217E7FC
_0215AF90: .word 0x01FF0000
_0215AF94: .word ovl08_215AE3C
	arm_func_end ovl08_215AF1C

	arm_func_start ovl08_215AF98
ovl08_215AF98: // 0x0215AF98
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215B008 // =0x0217E7FC
	ldr r2, _0215B00C // =0x01FF0000
	ldr ip, [r1]
	mov r4, r0
	ldr r3, [ip, #0x60]
	mov r1, #1
	ldr r0, [r3]
	and r0, r0, r2
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [r3]
	and r0, r0, #0xff
	str r0, [sp, #4]
	add r2, r0, #0xc
	str r2, [sp, #4]
	ldrb r0, [ip, #0x11d]
	bl ovl08_215B860
	ldr r0, [sp, #4]
	cmp r0, #0xc0
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	ldr r1, _0215B010 // =ovl08_215AF1C
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B008: .word 0x0217E7FC
_0215B00C: .word 0x01FF0000
_0215B010: .word ovl08_215AF1C
	arm_func_end ovl08_215AF98

	arm_func_start ovl08_215B014
ovl08_215B014: // 0x0215B014
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215B084 // =0x0217E7FC
	ldr r2, _0215B088 // =0x01FF0000
	ldr ip, [r1]
	mov r4, r0
	ldr r3, [ip, #0x90]
	mov r1, #2
	ldr r0, [r3]
	and r0, r0, r2
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [r3]
	and r0, r0, #0xff
	str r0, [sp, #4]
	add r2, r0, #0xc
	str r2, [sp, #4]
	ldrb r0, [ip, #0x11d]
	bl ovl08_215B860
	ldr r0, [sp, #4]
	cmp r0, #0xc0
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	ldr r1, _0215B08C // =ovl08_215AF98
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B084: .word 0x0217E7FC
_0215B088: .word 0x01FF0000
_0215B08C: .word ovl08_215AF98
	arm_func_end ovl08_215B014

	arm_func_start ovl08_215B090
ovl08_215B090: // 0x0215B090
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215B100 // =0x0217E7FC
	ldr r2, _0215B104 // =0x01FF0000
	ldr ip, [r1]
	mov r4, r0
	ldr r3, [ip, #0xc0]
	mov r1, #3
	ldr r0, [r3]
	and r0, r0, r2
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [r3]
	and r0, r0, #0xff
	str r0, [sp, #4]
	add r2, r0, #0xc
	str r2, [sp, #4]
	ldrb r0, [ip, #0x11d]
	bl ovl08_215B860
	ldr r0, [sp, #4]
	cmp r0, #0xc0
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	ldr r1, _0215B108 // =ovl08_215B014
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B100: .word 0x0217E7FC
_0215B104: .word 0x01FF0000
_0215B108: .word ovl08_215B014
	arm_func_end ovl08_215B090

	arm_func_start ovl08_215B10C
ovl08_215B10C: // 0x0215B10C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215B18C // =0x0217E7FC
	mov r4, r0
	ldr r0, [r1]
	mov r1, #0
	ldr r0, [r0, #0xfc]
	bl ovl08_21751F8
	ldr r3, [r0]
	ldr r1, _0215B190 // =0x01FF0000
	ldr r2, _0215B18C // =0x0217E7FC
	and r1, r3, r1
	mov r1, r1, lsr #0x10
	str r1, [sp]
	ldr r1, [r0]
	ldr r0, [r2]
	and r1, r1, #0xff
	str r1, [sp, #4]
	add r2, r1, #0xc
	str r2, [sp, #4]
	ldrb r0, [r0, #0x11d]
	mov r1, #4
	bl ovl08_215B860
	ldr r0, [sp, #4]
	cmp r0, #0xc0
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	ldr r1, _0215B194 // =ovl08_215B090
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B18C: .word 0x0217E7FC
_0215B190: .word 0x01FF0000
_0215B194: .word ovl08_215B090
	arm_func_end ovl08_215B10C

	arm_func_start ovl08_215B198
ovl08_215B198: // 0x0215B198
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _0215B614 // =0x0217E7FC
	ldr r3, _0215B618 // =0x0217A7CC
	ldr ip, [r2]
	add r1, ip, #0x100
	ldrsb lr, [r1, #0x21]
	add r1, r3, lr, lsl #2
	ldrsb r1, [r0, r1]
	strb r1, [ip, #0x121]
	ldr r1, [r2]
	add r2, r1, #0x100
	ldrsb r2, [r2, #0x21]
	cmp r2, #0x2e
	bne _0215B1E0
	cmp r0, #3
	streqb lr, [r1, #0x120]
	beq _0215B600
_0215B1E0:
	cmp r2, #0x33
	bne _0215B200
	cmp r0, #1
	beq _0215B1F8
	cmp r0, #3
	bne _0215B200
_0215B1F8:
	strb lr, [r1, #0x120]
	b _0215B600
_0215B200:
	cmp r2, #0x34
	bne _0215B224
	cmp r0, #1
	beq _0215B218
	cmp r0, #3
	bne _0215B224
_0215B218:
	cmp lr, #0x2e
	strneb lr, [r1, #0x120]
	b _0215B600
_0215B224:
	mvn r0, #0
	cmp r2, r0
	bne _0215B260
	add r0, r1, #0x100
	ldrsb r0, [r0, #0x20]
	cmp r0, #0x23
	beq _0215B248
	cmp r0, #0x32
	bne _0215B254
_0215B248:
	mov r0, #0x23
	strb r0, [r1, #0x121]
	b _0215B600
_0215B254:
	mov r0, #0x22
	strb r0, [r1, #0x121]
	b _0215B600
_0215B260:
	mvn r0, #1
	cmp r2, r0
	bne _0215B328
	add r0, r1, #0x100
	ldrsb r0, [r0, #0x20]
	cmp r0, #0x26
	bgt _0215B2BC
	cmp r0, #0x26
	bge _0215B2F8
	cmp r0, #5
	bgt _0215B2B0
	cmp r0, #0
	addge pc, pc, r0, lsl #2
	b _0215B31C
_0215B298: // jump table
	b _0215B2E0 // case 0
	b _0215B2EC // case 1
	b _0215B31C // case 2
	b _0215B2F8 // case 3
	b _0215B304 // case 4
	b _0215B310 // case 5
_0215B2B0:
	cmp r0, #0x24
	beq _0215B2EC
	b _0215B31C
_0215B2BC:
	cmp r0, #0x28
	bgt _0215B2D8
	cmp r0, #0x28
	bge _0215B310
	cmp r0, #0x27
	beq _0215B304
	b _0215B31C
_0215B2D8:
	cmp r0, #0x31
	bne _0215B31C
_0215B2E0:
	mov r0, #0x31
	strb r0, [r1, #0x121]
	b _0215B600
_0215B2EC:
	mov r0, #0x24
	strb r0, [r1, #0x121]
	b _0215B600
_0215B2F8:
	mov r0, #0x26
	strb r0, [r1, #0x121]
	b _0215B600
_0215B304:
	mov r0, #0x27
	strb r0, [r1, #0x121]
	b _0215B600
_0215B310:
	mov r0, #0x28
	strb r0, [r1, #0x121]
	b _0215B600
_0215B31C:
	mov r0, #0x25
	strb r0, [r1, #0x121]
	b _0215B600
_0215B328:
	mvn r0, #2
	cmp r2, r0
	bne _0215B42C
	add r0, r1, #0x100
	ldrsb r0, [r0, #0x20]
	cmp r0, #0x23
	bgt _0215B39C
	cmp r0, #0x23
	bge _0215B414
	cmp r0, #0xb
	bgt _0215B390
	cmp r0, #0
	addge pc, pc, r0, lsl #2
	b _0215B420
_0215B360: // jump table
	b _0215B420 // case 0
	b _0215B420 // case 1
	b _0215B420 // case 2
	b _0215B420 // case 3
	b _0215B420 // case 4
	b _0215B420 // case 5
	b _0215B3E4 // case 6
	b _0215B3F0 // case 7
	b _0215B420 // case 8
	b _0215B3FC // case 9
	b _0215B408 // case 10
	b _0215B414 // case 11
_0215B390:
	cmp r0, #0x22
	beq _0215B414
	b _0215B420
_0215B39C:
	cmp r0, #0x2a
	bgt _0215B3B8
	cmp r0, #0x2a
	bge _0215B3F0
	cmp r0, #0x29
	beq _0215B3E4
	b _0215B420
_0215B3B8:
	cmp r0, #0x32
	bgt _0215B420
	cmp r0, #0x2c
	blt _0215B420
	cmp r0, #0x2c
	beq _0215B3FC
	cmp r0, #0x2d
	beq _0215B408
	cmp r0, #0x32
	beq _0215B414
	b _0215B420
_0215B3E4:
	mov r0, #0x29
	strb r0, [r1, #0x121]
	b _0215B600
_0215B3F0:
	mov r0, #0x2a
	strb r0, [r1, #0x121]
	b _0215B600
_0215B3FC:
	mov r0, #0x2c
	strb r0, [r1, #0x121]
	b _0215B600
_0215B408:
	mov r0, #0x2d
	strb r0, [r1, #0x121]
	b _0215B600
_0215B414:
	mov r0, #0x2e
	strb r0, [r1, #0x121]
	b _0215B600
_0215B420:
	mov r0, #0x2b
	strb r0, [r1, #0x121]
	b _0215B600
_0215B42C:
	mvn r0, #3
	cmp r2, r0
	bne _0215B4F4
	add r0, r1, #0x100
	ldrsb r0, [r0, #0x20]
	cmp r0, #0x26
	bgt _0215B488
	cmp r0, #0x26
	bge _0215B4C4
	cmp r0, #5
	bgt _0215B47C
	cmp r0, #0
	addge pc, pc, r0, lsl #2
	b _0215B4E8
_0215B464: // jump table
	b _0215B4AC // case 0
	b _0215B4B8 // case 1
	b _0215B4E8 // case 2
	b _0215B4C4 // case 3
	b _0215B4D0 // case 4
	b _0215B4DC // case 5
_0215B47C:
	cmp r0, #0x24
	beq _0215B4B8
	b _0215B4E8
_0215B488:
	cmp r0, #0x28
	bgt _0215B4A4
	cmp r0, #0x28
	bge _0215B4DC
	cmp r0, #0x27
	beq _0215B4D0
	b _0215B4E8
_0215B4A4:
	cmp r0, #0x31
	bne _0215B4E8
_0215B4AC:
	mov r0, #0
	strb r0, [r1, #0x121]
	b _0215B600
_0215B4B8:
	mov r0, #1
	strb r0, [r1, #0x121]
	b _0215B600
_0215B4C4:
	mov r0, #3
	strb r0, [r1, #0x121]
	b _0215B600
_0215B4D0:
	mov r0, #4
	strb r0, [r1, #0x121]
	b _0215B600
_0215B4DC:
	mov r0, #5
	strb r0, [r1, #0x121]
	b _0215B600
_0215B4E8:
	mov r0, #2
	strb r0, [r1, #0x121]
	b _0215B600
_0215B4F4:
	mvn r0, #4
	cmp r2, r0
	bne _0215B600
	add r0, r1, #0x100
	ldrsb r0, [r0, #0x20]
	cmp r0, #0x23
	bgt _0215B568
	cmp r0, #0x23
	bge _0215B5EC
	cmp r0, #0xb
	bgt _0215B55C
	cmp r0, #0
	addge pc, pc, r0, lsl #2
	b _0215B5F8
_0215B52C: // jump table
	b _0215B5F8 // case 0
	b _0215B5F8 // case 1
	b _0215B5F8 // case 2
	b _0215B5F8 // case 3
	b _0215B5F8 // case 4
	b _0215B5F8 // case 5
	b _0215B5B0 // case 6
	b _0215B5BC // case 7
	b _0215B5F8 // case 8
	b _0215B5C8 // case 9
	b _0215B5D4 // case 10
	b _0215B5E0 // case 11
_0215B55C:
	cmp r0, #0x22
	beq _0215B5E0
	b _0215B5F8
_0215B568:
	cmp r0, #0x2a
	bgt _0215B584
	cmp r0, #0x2a
	bge _0215B5BC
	cmp r0, #0x29
	beq _0215B5B0
	b _0215B5F8
_0215B584:
	cmp r0, #0x32
	bgt _0215B5F8
	cmp r0, #0x2c
	blt _0215B5F8
	cmp r0, #0x2c
	beq _0215B5C8
	cmp r0, #0x2d
	beq _0215B5D4
	cmp r0, #0x32
	beq _0215B5EC
	b _0215B5F8
_0215B5B0:
	mov r0, #6
	strb r0, [r1, #0x121]
	b _0215B600
_0215B5BC:
	mov r0, #7
	strb r0, [r1, #0x121]
	b _0215B600
_0215B5C8:
	mov r0, #9
	strb r0, [r1, #0x121]
	b _0215B600
_0215B5D4:
	mov r0, #0xa
	strb r0, [r1, #0x121]
	b _0215B600
_0215B5E0:
	mov r0, #0xb
	strb r0, [r1, #0x121]
	b _0215B600
_0215B5EC:
	mov r0, #0x32
	strb r0, [r1, #0x121]
	b _0215B600
_0215B5F8:
	mov r0, #8
	strb r0, [r1, #0x121]
_0215B600:
	bl ovl08_215B61C
	mov r0, #8
	bl ovl08_216F934
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215B614: .word 0x0217E7FC
_0215B618: .word 0x0217A7CC
	arm_func_end ovl08_215B198

	arm_func_start ovl08_215B61C
ovl08_215B61C: // 0x0215B61C
	stmdb sp!, {r4, lr}
	ldr r0, _0215B6EC // =0x0217E7FC
	ldr r1, [r0]
	add r0, r1, #0x100
	ldrsb r0, [r0, #0x21]
	sub r0, r0, #0x2f
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0215B680
_0215B640: // jump table
	b _0215B658 // case 0
	b _0215B660 // case 1
	b _0215B668 // case 2
	b _0215B670 // case 3
	b _0215B678 // case 4
	b _0215B678 // case 5
_0215B658:
	mov r4, #0x42
	b _0215B684
_0215B660:
	mov r4, #0x41
	b _0215B684
_0215B668:
	mov r4, #0x43
	b _0215B684
_0215B670:
	mov r4, #0x41
	b _0215B684
_0215B678:
	mov r4, #0x45
	b _0215B684
_0215B680:
	mov r4, #0x40
_0215B684:
	ldr r0, [r1, #0x114]
	mov r1, #0
	bl ovl08_21751F8
	mov r2, r0
	mov r1, r4
	mov r0, #0
	bl ovl08_217559C
	ldr r0, _0215B6EC // =0x0217E7FC
	mvn r1, #0
	ldr r0, [r0]
	mov r2, #2
	ldr r0, [r0, #0x114]
	bl ovl08_2174F30
	ldr r0, _0215B6EC // =0x0217E7FC
	ldr r2, _0215B6F0 // =0x0217A6F8
	ldr r3, [r0]
	mvn r1, #0
	add r0, r3, #0x100
	ldrsb ip, [r0, #0x21]
	ldr r0, [r3, #0x114]
	ldr r3, _0215B6F4 // =0x0217A6FA
	mov ip, ip, lsl #2
	ldrh r2, [r2, ip]
	ldrh r3, [r3, ip]
	bl ovl08_2174FA4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B6EC: .word 0x0217E7FC
_0215B6F0: .word 0x0217A6F8
_0215B6F4: .word 0x0217A6FA
	arm_func_end ovl08_215B61C

	arm_func_start ovl08_215B6F8
ovl08_215B6F8: // 0x0215B6F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	addlt sp, sp, #4
	ldmltia sp!, {pc}
	cmp r0, #0x2f
	bge _0215B750
	ldr r2, _0215B7C8 // =0x0217E7FC
	ldr r3, _0215B7CC // =0x0217A5D4
	ldr r2, [r2]
	add sp, sp, #4
	add r0, r2, r0, lsl #2
	ldr ip, [r0, #0x30]
	ldr r0, [ip]
	bic r0, r0, #0xc00
	str r0, [ip]
	ldrh r2, [ip, #4]
	ldrb r0, [r3, r1]
	bic r1, r2, #0xf000
	orr r0, r1, r0, lsl #12
	strh r0, [ip, #4]
	ldmia sp!, {pc}
_0215B750:
	sub r3, r0, #0x2f
	cmp r3, #4
	bge _0215B798
	ldr r0, _0215B7C8 // =0x0217E7FC
	ldr r2, _0215B7CC // =0x0217A5D4
	ldr r0, [r0]
	add sp, sp, #4
	add r0, r0, r3, lsl #2
	ldr ip, [r0, #0xec]
	ldr r0, [ip]
	bic r0, r0, #0xc00
	str r0, [ip]
	ldrh r3, [ip, #4]
	ldrb r0, [r2, r1]
	bic r1, r3, #0xf000
	orr r0, r1, r0, lsl #12
	strh r0, [ip, #4]
	ldmia sp!, {pc}
_0215B798:
	ldr r2, _0215B7C8 // =0x0217E7FC
	ldr r3, _0215B7D0 // =0x0217A5D8
	ldr r2, [r2]
	sub r0, r0, #0x33
	add r0, r2, r0, lsl #2
	ldrb r3, [r3, r1]
	ldr r0, [r0, #0xfc]
	mvn r1, #0
	mov r2, #0
	bl ovl08_21750B0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215B7C8: .word 0x0217E7FC
_0215B7CC: .word 0x0217A5D4
_0215B7D0: .word 0x0217A5D8
	arm_func_end ovl08_215B6F8

	arm_func_start ovl08_215B7D4
ovl08_215B7D4: // 0x0215B7D4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	ldr r1, _0215B858 // =0x0217E7FC
	mov r6, #0
	ldr r1, [r1]
	mov r8, r0
	mov r5, r6
	mov r7, r6
	mov r4, r6
	strb r8, [r1, #0x11d]
	ldr r9, _0215B85C // =0x0217A63C
_0215B800:
	add r0, r9, r4, lsl #2
	ldrh r2, [r0, #2]
	mov r0, r8
	mov r1, r7
	bl ovl08_215B860
	add r7, r7, #1
	cmp r7, #4
	add r4, r4, #0xc
	blt _0215B800
	cmp r8, #2
	moveq r6, #1
	beq _0215B838
	cmp r8, #1
	moveq r5, #1
_0215B838:
	mov r1, r6
	mov r0, #0x2f
	bl ovl08_215B6F8
	mov r1, r5
	mov r0, #0x30
	bl ovl08_215B6F8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0215B858: .word 0x0217E7FC
_0215B85C: .word 0x0217A63C
	arm_func_end ovl08_215B7D4

	arm_func_start ovl08_215B860
ovl08_215B860: // 0x0215B860
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	ldr r4, _0215BAE4 // =0x0217A5FC
	ldr lr, _0215BAE8 // =0x0217A604
	ldrb r5, [r4, #4]
	ldrb r9, [r4]
	ldrb r8, [r4, #1]
	strb r5, [sp, #0xc]
	mov r5, r1
	mov r1, #0xc
	mul r1, r5, r1
	ldrb r7, [r4, #2]
	ldrb r6, [r4, #3]
	strb r9, [sp, #8]
	str r1, [sp, #4]
	ldrb ip, [lr]
	ldrb r10, [lr, #1]
	ldrb r4, [lr, #2]
	ldrb r11, [lr, #3]
	ldrb r9, [lr, #4]
	ldr r3, _0215BAEC // =0x0217A5F4
	strb r8, [sp, #9]
	strb r7, [sp, #0xa]
	strb r6, [sp, #0xb]
	add r1, sp, #8
	ldrb lr, [r3]
	ldrb r8, [r3, #1]
	ldrb r7, [r3, #2]
	ldrb r6, [r3, #3]
	ldrb r3, [r3, #4]
	ldrb r1, [r1, r5]
	strb r10, [sp, #0xe]
	strb r4, [sp, #0xf]
	strb r9, [sp, #0x11]
	strb ip, [sp, #0xd]
	mov r4, r2
	ldr r10, [sp, #4]
	strb r11, [sp, #0x10]
	strb lr, [sp, #0x12]
	strb r8, [sp, #0x13]
	strb r7, [sp, #0x14]
	strb r6, [sp, #0x15]
	strb r3, [sp, #0x16]
	cmp r1, #0
	mov r9, #0
	ble _0215B990
	add r1, sp, #8
	ldr r2, _0215BAF0 // =0x0217E7FC
	ldr r3, _0215BAF4 // =0x0217A63C
	ldr r11, _0215BAF8 // =0xFE00FF00
	and r8, r4, #0xff
	add r7, r1, r5
_0215B930:
	ldr r1, [r2]
	mov r6, r10, lsl #2
	add r1, r1, r10, lsl #2
	ldr lr, [r1, #0x30]
	ldr r1, _0215BAFC // =0xC1FFFCFF
	ldr ip, [lr]
	add r9, r9, #1
	and r1, ip, r1
	str r1, [lr]
	ldr r1, [r2]
	ldrh ip, [r3, r6]
	add r1, r1, r10, lsl #2
	ldr r6, [r1, #0x30]
	ldr r1, _0215BB00 // =0x000001FF
	add r10, r10, #1
	and r1, ip, r1
	ldr ip, [r6]
	and ip, ip, r11
	orr ip, ip, r8
	orr r1, ip, r1, lsl #16
	str r1, [r6]
	ldrb r1, [r7]
	cmp r9, r1
	blt _0215B930
_0215B990:
	cmp r5, #4
	bge _0215B9D0
	ldr r1, _0215BAF0 // =0x0217E7FC
	mov r2, #2
	ldr r6, [r1]
	ldr r1, [sp, #4]
	str r2, [sp]
	add r0, r6, r0, lsl #4
	ldr r3, _0215BAF4 // =0x0217A63C
	mov r1, r1, lsl #2
	add r2, r6, r5, lsl #2
	ldrh r1, [r3, r1]
	ldr r3, [r2, #0x104]
	ldr r0, [r0, r5, lsl #2]
	mov r2, r4
	bl ovl08_2175B50
_0215B9D0:
	add r0, r5, #3
	mov r1, #4
	bl FX_ModS32
	add r8, sp, #0xd
	ldrb r1, [r8, r5]
	mov r2, #0
	cmp r1, #0
	ble _0215BA64
	ldr r3, _0215BB04 // =0x0217A61C
	mov r1, r0, lsl #2
	ldrh r3, [r3, r1]
	ldr r0, _0215BB00 // =0x000001FF
	and r7, r4, #0xff
	and r0, r3, r0
	mov r6, r0, lsl #0x10
	add r3, r8, r5
	ldr r10, _0215BAF0 // =0x0217E7FC
	ldr r8, _0215BAFC // =0xC1FFFCFF
	ldr r9, _0215BAF8 // =0xFE00FF00
_0215BA1C:
	ldr r0, [r10]
	add r2, r2, #1
	add r0, r1, r0
	ldr r11, [r0, #0xec]
	ldr r0, [r11]
	and r0, r0, r8
	str r0, [r11]
	ldr r0, [r10]
	add r0, r1, r0
	ldr r0, [r0, #0xec]
	ldr r11, [r0]
	and r11, r11, r9
	orr r11, r11, r7
	orr r11, r6, r11
	str r11, [r0]
	ldrb r0, [r3]
	cmp r2, r0
	blt _0215BA1C
_0215BA64:
	add r1, sp, #0x12
	ldrb r0, [r1, r5]
	mov r8, #0
	cmp r0, #0
	addle sp, sp, #0x1c
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r9, r1, r5
	ldr r10, _0215BAF0 // =0x0217E7FC
	ldr r5, _0215BB08 // =0x0217A614
	mov r6, r8
	mvn r7, #0
_0215BA90:
	ldr r0, [r10]
	mov r1, r7
	add r0, r0, r8, lsl #2
	ldr r0, [r0, #0xfc]
	mov r2, r6
	mov r3, r6
	bl ovl08_2175138
	ldr r0, [r10]
	mov r1, r8, lsl #2
	add r0, r0, r8, lsl #2
	ldrh r2, [r5, r1]
	ldr r0, [r0, #0xfc]
	mov r1, r7
	mov r3, r4
	bl ovl08_2174FA4
	ldrb r0, [r9]
	add r8, r8, #1
	cmp r8, r0
	blt _0215BA90
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215BAE4: .word 0x0217A5FC
_0215BAE8: .word 0x0217A604
_0215BAEC: .word 0x0217A5F4
_0215BAF0: .word 0x0217E7FC
_0215BAF4: .word 0x0217A63C
_0215BAF8: .word 0xFE00FF00
_0215BAFC: .word 0xC1FFFCFF
_0215BB00: .word 0x000001FF
_0215BB04: .word 0x0217A61C
_0215BB08: .word 0x0217A614
	arm_func_end ovl08_215B860

	arm_func_start ovl08_215BB0C
ovl08_215BB0C: // 0x0215BB0C
	stmdb sp!, {r4, lr}
	mov r0, #0x20
	bl ovl08_2176B34
	cmp r0, #0
	beq _0215BB28
	mov r0, #0
	bl ovl08_215B198
_0215BB28:
	mov r0, #0x40
	bl ovl08_2176B34
	cmp r0, #0
	beq _0215BB40
	mov r0, #1
	bl ovl08_215B198
_0215BB40:
	mov r0, #0x10
	bl ovl08_2176B34
	cmp r0, #0
	beq _0215BB58
	mov r0, #2
	bl ovl08_215B198
_0215BB58:
	mov r0, #0x80
	bl ovl08_2176B34
	cmp r0, #0
	beq _0215BB70
	mov r0, #3
	bl ovl08_215B198
_0215BB70:
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	beq _0215BC88
	ldr r2, _0215BD28 // =0x0217E7FC
	ldr r0, [r2]
	add r1, r0, #0x100
	ldrsb r4, [r1, #0x21]
	cmp r4, #0x2f
	bge _0215BBE0
	ldrb r1, [r0, #0x124]
	cmp r1, #0
	bne _0215BBB0
	mov r0, #9
	bl ovl08_216F934
	ldmia sp!, {r4, pc}
_0215BBB0:
	ldrb r3, [r0, #0x11d]
	ldr r1, _0215BD2C // =0x0217B404
	ldr r1, [r1, r3, lsl #2]
	ldrb r1, [r1, r4]
	strb r1, [r0, #0x11c]
	ldr r0, [r2]
	ldrb r0, [r0, #0x11d]
	cmp r0, #1
	ldmneia sp!, {r4, pc}
	mov r0, #0
	bl ovl08_215B7D4
	ldmia sp!, {r4, pc}
_0215BBE0:
	sub r1, r4, #0x2f
	cmp r1, #4
	bge _0215BC78
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _0215BC48
_0215BBF8: // jump table
	b _0215BC08 // case 0
	b _0215BC10 // case 1
	b _0215BC18 // case 2
	b _0215BC30 // case 3
_0215BC08:
	bl ovl08_215BFC8
	ldmia sp!, {r4, pc}
_0215BC10:
	bl ovl08_215BF90
	ldmia sp!, {r4, pc}
_0215BC18:
	ldrb r1, [r0, #0x124]
	cmp r1, #0
	bne _0215BC48
	mov r0, #9
	bl ovl08_216F934
	ldmia sp!, {r4, pc}
_0215BC30:
	ldrb r1, [r0, #0x123]
	cmp r1, #0
	bne _0215BC48
	mov r0, #9
	bl ovl08_216F934
	ldmia sp!, {r4, pc}
_0215BC48:
	ldrb r0, [r0, #0x11d]
	cmp r0, #1
	bne _0215BC5C
	mov r0, #0
	bl ovl08_215B7D4
_0215BC5C:
	ldr r1, _0215BD30 // =0x0217A60C
	sub r2, r4, #0x2f
	ldr r0, _0215BD28 // =0x0217E7FC
	ldrb r1, [r1, r2]
	ldr r0, [r0]
	strb r1, [r0, #0x11c]
	ldmia sp!, {r4, pc}
_0215BC78:
	ldr r1, _0215BD34 // =0x0217A5E0
	sub r2, r4, #0x33
	ldrb r1, [r1, r2]
	strb r1, [r0, #0x11c]
_0215BC88:
	mov r0, #2
	bl ovl08_2176B34
	cmp r0, #0
	beq _0215BCE0
	ldr r0, _0215BD28 // =0x0217E7FC
	ldr r1, [r0]
	ldrb r0, [r1, #0x123]
	cmp r0, #0
	bne _0215BCD4
	ldrb r0, [r1, #0x125]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _0215BD28 // =0x0217E7FC
	mov r1, #1
	ldr r0, [r0]
	strb r1, [r0, #0x125]
	ldmia sp!, {r4, pc}
_0215BCD4:
	mov r0, #0x80
	strb r0, [r1, #0x11c]
	b _0215BCFC
_0215BCE0:
	mov r0, #2
	bl ovl08_2176B10
	cmp r0, #0
	ldrne r0, _0215BD28 // =0x0217E7FC
	movne r1, #0
	ldrne r0, [r0]
	strneb r1, [r0, #0x125]
_0215BCFC:
	mov r0, #0x400
	bl ovl08_2176B58
	cmp r0, #0
	beq _0215BD10
	bl ovl08_215BFC8
_0215BD10:
	mov r0, #0x800
	bl ovl08_2176B58
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl ovl08_215BF90
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BD28: .word 0x0217E7FC
_0215BD2C: .word 0x0217B404
_0215BD30: .word 0x0217A60C
_0215BD34: .word 0x0217A5E0
	arm_func_end ovl08_215BB0C

	arm_func_start ovl08_215BD38
ovl08_215BD38: // 0x0215BD38
	stmdb sp!, {r4, lr}
	ldr r1, _0215BD88 // =0x0217E7FC
	mov r4, r0
	ldr r1, [r1]
	add r1, r1, #0x100
	ldrsb r1, [r1, #0x1f]
	cmp r4, r1
	ldmeqia sp!, {r4, pc}
	mov r1, #1
	bl ovl08_215B6F8
	ldr r0, _0215BD88 // =0x0217E7FC
	mov r1, #0
	ldr r0, [r0]
	add r0, r0, #0x100
	ldrsb r0, [r0, #0x1f]
	bl ovl08_215B6F8
	ldr r0, _0215BD88 // =0x0217E7FC
	ldr r0, [r0]
	strb r4, [r0, #0x11f]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BD88: .word 0x0217E7FC
	arm_func_end ovl08_215BD38

	arm_func_start ovl08_215BD8C
ovl08_215BD8C: // 0x0215BD8C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r0, _0215BF70 // =0x0217B024
	bl ovl08_2176AA4
	cmp r0, #0
	beq _0215BF50
	ldr r7, _0215BF74 // =0x0217A63C
	mov r4, #0
	ldr r6, _0215BF78 // =0x0217A5F0
	add r5, sp, #0
_0215BDB4:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl ovl08_21762F8
	mov r0, r5
	bl ovl08_2176AA4
	cmp r0, #0
	beq _0215BDF8
	ldr r0, _0215BF7C // =0x0217E7FC
	ldr r0, [r0]
	add r0, r0, #0x100
	ldrsb r0, [r0, #0x1e]
	cmp r0, r4
	bne _0215BF50
	mov r0, r4
	bl ovl08_215BD38
	b _0215BF58
_0215BDF8:
	add r4, r4, #1
	cmp r4, #0x2f
	add r7, r7, #4
	blt _0215BDB4
	ldr r7, _0215BF80 // =0x0217A634
	ldr r6, _0215BF84 // =0x0217A624
	mov r5, #2
	add r4, sp, #0
_0215BE18:
	mov r0, r6
	mov r1, r7
	mov r2, r4
	bl ovl08_21762F8
	mov r0, r4
	bl ovl08_2176AA4
	cmp r0, #0
	beq _0215BED8
	ldr r1, _0215BF7C // =0x0217E7FC
	add r0, r5, #0x2f
	ldr r1, [r1]
	add r1, r1, #0x100
	ldrsb r1, [r1, #0x1e]
	cmp r1, r0
	bne _0215BF50
	bl ovl08_215BD38
	cmp r5, #3
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0215BF7C // =0x0217E7FC
	ldr r2, [r0]
	ldrb r1, [r2, #0x122]
	add r1, r1, #1
	strb r1, [r2, #0x122]
	ldr r2, [r0]
	ldrb r1, [r2, #0x122]
	cmp r1, #0x28
	addlo sp, sp, #0xc
	ldmloia sp!, {r4, r5, r6, r7, pc}
	ldrb r1, [r2, #0x123]
	cmp r1, #0
	bne _0215BEB8
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _0215BF7C // =0x0217E7FC
	mvn r1, #0
	ldr r0, [r0]
	add sp, sp, #0xc
	strb r1, [r0, #0x11e]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215BEB8:
	mov r1, #0x80
	strb r1, [r2, #0x11c]
	ldr r1, [r0]
	add sp, sp, #0xc
	ldrb r0, [r1, #0x122]
	sub r0, r0, #7
	strb r0, [r1, #0x122]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215BED8:
	add r5, r5, #1
	cmp r5, #4
	add r7, r7, #4
	add r6, r6, #4
	blt _0215BE18
	ldr r7, _0215BF88 // =0x0217A614
	mov r6, #0
	ldr r5, _0215BF8C // =0x0217A5EC
	add r4, sp, #0
_0215BEFC:
	mov r0, r7
	mov r1, r5
	mov r2, r4
	bl ovl08_21762F8
	mov r0, r4
	bl ovl08_2176AA4
	cmp r0, #0
	beq _0215BF40
	ldr r1, _0215BF7C // =0x0217E7FC
	add r0, r6, #0x33
	ldr r1, [r1]
	add r1, r1, #0x100
	ldrsb r1, [r1, #0x1e]
	cmp r1, r0
	bne _0215BF50
	bl ovl08_215BD38
	b _0215BF58
_0215BF40:
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #4
	blt _0215BEFC
_0215BF50:
	mvn r0, #0
	bl ovl08_215BD38
_0215BF58:
	ldr r0, _0215BF7C // =0x0217E7FC
	mov r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x122]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215BF70: .word 0x0217B024
_0215BF74: .word 0x0217A63C
_0215BF78: .word 0x0217A5F0
_0215BF7C: .word 0x0217E7FC
_0215BF80: .word 0x0217A634
_0215BF84: .word 0x0217A624
_0215BF88: .word 0x0217A614
_0215BF8C: .word 0x0217A5EC
	arm_func_end ovl08_215BD8C

	arm_func_start ovl08_215BF90
ovl08_215BF90: // 0x0215BF90
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0215BFC4 // =0x0217E7FC
	ldr r0, [r0]
	ldrb r0, [r0, #0x11d]
	cmp r0, #1
	movne r0, #1
	moveq r0, #0
	bl ovl08_215B7D4
	mov r0, #1
	bl ovl08_216F934
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215BFC4: .word 0x0217E7FC
	arm_func_end ovl08_215BF90

	arm_func_start ovl08_215BFC8
ovl08_215BFC8: // 0x0215BFC8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0215BFFC // =0x0217E7FC
	ldr r0, [r0]
	ldrb r0, [r0, #0x11d]
	cmp r0, #2
	moveq r0, #0
	movne r0, #2
	bl ovl08_215B7D4
	mov r0, #1
	bl ovl08_216F934
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215BFFC: .word 0x0217E7FC
	arm_func_end ovl08_215BFC8

	arm_func_start ovl08_215C000
ovl08_215C000: // 0x0215C000
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r1, _0215C2AC // =0x0217E7FC
	ldr r0, _0215C2B0 // =0x0217B024
	ldr r1, [r1]
	mov r2, #0
	strb r2, [r1, #0x11c]
	bl ovl08_2176960
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r7, _0215C2B4 // =0x0217A63C
	mov r4, #0
	ldr r6, _0215C2B8 // =0x0217A5F0
	add r5, sp, #0
_0215C03C:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl ovl08_21762F8
	mov r0, r5
	bl ovl08_2176960
	cmp r0, #0
	beq _0215C0BC
	ldr r1, _0215C2AC // =0x0217E7FC
	ldr r3, [r1]
	add r0, r3, #0x100
	ldrsb r0, [r0, #0x1e]
	cmp r0, r4
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldrb r2, [r3, #0x11d]
	ldr r0, _0215C2BC // =0x0217B404
	ldr r0, [r0, r2, lsl #2]
	ldrb r0, [r0, r4]
	strb r0, [r3, #0x11c]
	ldr r0, [r1]
	ldrb r0, [r0, #0x11d]
	cmp r0, #1
	bne _0215C0A4
	mov r0, #0
	bl ovl08_215B7D4
_0215C0A4:
	ldr r0, _0215C2AC // =0x0217E7FC
	ldr r0, [r0]
	strb r4, [r0, #0x121]
	bl ovl08_215B61C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215C0BC:
	add r4, r4, #1
	cmp r4, #0x2f
	add r7, r7, #4
	blt _0215C03C
	ldr r7, _0215C2C0 // =0x0217A634
	ldr r6, _0215C2C4 // =0x0217A624
	mov r4, #2
	add r5, sp, #0
_0215C0DC:
	mov r0, r6
	mov r1, r7
	mov r2, r5
	bl ovl08_21762F8
	mov r0, r5
	bl ovl08_2176960
	cmp r0, #0
	beq _0215C15C
	ldr r1, _0215C2AC // =0x0217E7FC
	add r2, r4, #0x2f
	ldr r3, [r1]
	add r0, r3, #0x100
	ldrsb r0, [r0, #0x1e]
	cmp r0, r2
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0215C2C8 // =0x0217A60C
	ldrb r0, [r0, r4]
	strb r0, [r3, #0x11c]
	ldr r0, [r1]
	ldrb r0, [r0, #0x11d]
	cmp r0, #1
	bne _0215C140
	mov r0, #0
	bl ovl08_215B7D4
_0215C140:
	ldr r0, _0215C2AC // =0x0217E7FC
	add r1, r4, #0x2f
	ldr r0, [r0]
	strb r1, [r0, #0x121]
	bl ovl08_215B61C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215C15C:
	add r4, r4, #1
	cmp r4, #4
	add r7, r7, #4
	add r6, r6, #4
	blt _0215C0DC
	ldr r7, _0215C2CC // =0x0217A614
	mov r4, #0
	ldr r6, _0215C2D0 // =0x0217A5EC
	add r5, sp, #0
_0215C180:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl ovl08_21762F8
	mov r0, r5
	bl ovl08_2176960
	cmp r0, #0
	beq _0215C1E0
	ldr r1, _0215C2AC // =0x0217E7FC
	add r2, r4, #0x33
	ldr r3, [r1]
	add r0, r3, #0x100
	ldrsb r0, [r0, #0x1e]
	cmp r0, r2
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0215C2D4 // =0x0217A5E0
	ldrb r0, [r0, r4]
	strb r0, [r3, #0x11c]
	ldr r0, [r1]
	strb r2, [r0, #0x121]
	bl ovl08_215B61C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215C1E0:
	add r4, r4, #1
	cmp r4, #2
	add r7, r7, #4
	blt _0215C180
	ldr r0, _0215C2D8 // =0x0217A61C
	ldr r1, _0215C2DC // =0x0217A62C
	add r2, sp, #0
	bl ovl08_21762F8
	add r0, sp, #0
	bl ovl08_2176960
	cmp r0, #0
	beq _0215C24C
	ldr r0, _0215C2AC // =0x0217E7FC
	ldr r0, [r0]
	add r0, r0, #0x100
	ldrsb r0, [r0, #0x1e]
	cmp r0, #0x2f
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	bl ovl08_215BFC8
	ldr r0, _0215C2AC // =0x0217E7FC
	mov r1, #0x2f
	ldr r0, [r0]
	strb r1, [r0, #0x121]
	bl ovl08_215B61C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215C24C:
	ldr r0, _0215C2E0 // =0x0217A620
	ldr r1, _0215C2E4 // =0x0217A630
	add r2, sp, #0
	bl ovl08_21762F8
	add r0, sp, #0
	bl ovl08_2176960
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0215C2AC // =0x0217E7FC
	ldr r0, [r0]
	add r0, r0, #0x100
	ldrsb r0, [r0, #0x1e]
	cmp r0, #0x30
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	bl ovl08_215BF90
	ldr r0, _0215C2AC // =0x0217E7FC
	mov r1, #0x30
	ldr r0, [r0]
	strb r1, [r0, #0x121]
	bl ovl08_215B61C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215C2AC: .word 0x0217E7FC
_0215C2B0: .word 0x0217B024
_0215C2B4: .word 0x0217A63C
_0215C2B8: .word 0x0217A5F0
_0215C2BC: .word 0x0217B404
_0215C2C0: .word 0x0217A634
_0215C2C4: .word 0x0217A624
_0215C2C8: .word 0x0217A60C
_0215C2CC: .word 0x0217A614
_0215C2D0: .word 0x0217A5EC
_0215C2D4: .word 0x0217A5E0
_0215C2D8: .word 0x0217A61C
_0215C2DC: .word 0x0217A62C
_0215C2E0: .word 0x0217A620
_0215C2E4: .word 0x0217A630
	arm_func_end ovl08_215C000

	arm_func_start ovl08_215C2E8
ovl08_215C2E8: // 0x0215C2E8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r0, _0215C4AC // =0x0217B024
	bl ovl08_2176A38
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0215C4B0 // =0x0217E7FC
	mvn r1, #0
	ldr r0, [r0]
	ldr r7, _0215C4B4 // =0x0217A63C
	strb r1, [r0, #0x11e]
	mov r4, #0
	ldr r6, _0215C4B8 // =0x0217A5F0
	add r5, sp, #0
_0215C324:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl ovl08_21762F8
	mov r0, r5
	bl ovl08_2176A38
	cmp r0, #0
	beq _0215C384
	ldr r0, _0215C4B0 // =0x0217E7FC
	ldr r0, [r0]
	ldrb r0, [r0, #0x124]
	cmp r0, #0
	bne _0215C368
	mov r0, #9
	bl ovl08_216F934
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215C368:
	mov r0, #0
	bl ovl08_216F934
	ldr r0, _0215C4B0 // =0x0217E7FC
	add sp, sp, #0xc
	ldr r0, [r0]
	strb r4, [r0, #0x11e]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215C384:
	add r4, r4, #1
	cmp r4, #0x2f
	add r7, r7, #4
	blt _0215C324
	ldr r7, _0215C4BC // =0x0217A62C
	ldr r6, _0215C4C0 // =0x0217A61C
	mov r4, #0
	add r5, sp, #0
_0215C3A4:
	mov r0, r6
	mov r1, r7
	mov r2, r5
	bl ovl08_21762F8
	mov r0, r5
	bl ovl08_2176A38
	cmp r0, #0
	beq _0215C430
	cmp r4, #3
	bne _0215C3E0
	ldr r0, _0215C4B0 // =0x0217E7FC
	ldr r0, [r0]
	ldrb r0, [r0, #0x123]
	cmp r0, #0
	beq _0215C3FC
_0215C3E0:
	cmp r4, #2
	bne _0215C40C
	ldr r0, _0215C4B0 // =0x0217E7FC
	ldr r0, [r0]
	ldrb r0, [r0, #0x124]
	cmp r0, #0
	bne _0215C40C
_0215C3FC:
	mov r0, #9
	bl ovl08_216F934
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215C40C:
	ldr r0, _0215C4C4 // =0x0217B41C
	ldr r0, [r0, r4, lsl #2]
	bl ovl08_216F934
	ldr r0, _0215C4B0 // =0x0217E7FC
	add r1, r4, #0x2f
	ldr r0, [r0]
	add sp, sp, #0xc
	strb r1, [r0, #0x11e]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215C430:
	add r4, r4, #1
	cmp r4, #4
	add r7, r7, #4
	add r6, r6, #4
	blt _0215C3A4
	ldr r7, _0215C4C8 // =0x0217A614
	mov r6, #0
	ldr r5, _0215C4CC // =0x0217A5EC
	add r4, sp, #0
_0215C454:
	mov r0, r7
	mov r1, r5
	mov r2, r4
	bl ovl08_21762F8
	mov r0, r4
	bl ovl08_2176A38
	cmp r0, #0
	beq _0215C494
	mov r0, #0
	bl ovl08_216F934
	ldr r0, _0215C4B0 // =0x0217E7FC
	add r1, r6, #0x33
	ldr r0, [r0]
	add sp, sp, #0xc
	strb r1, [r0, #0x11e]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215C494:
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #4
	blt _0215C454
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215C4AC: .word 0x0217B024
_0215C4B0: .word 0x0217E7FC
_0215C4B4: .word 0x0217A63C
_0215C4B8: .word 0x0217A5F0
_0215C4BC: .word 0x0217A62C
_0215C4C0: .word 0x0217A61C
_0215C4C4: .word 0x0217B41C
_0215C4C8: .word 0x0217A614
_0215C4CC: .word 0x0217A5EC
	arm_func_end ovl08_215C2E8

	arm_func_start ovl08_215C4D0
ovl08_215C4D0: // 0x0215C4D0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215C2E8
	bl ovl08_215C000
	bl ovl08_215BD8C
	bl ovl08_215BB0C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_215C4D0

	arm_func_start ovl08_215C4F0
ovl08_215C4F0: // 0x0215C4F0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215C580 // =0x0217E7FC
	mov r4, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0, #0xfc]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r0, _0215C584 // =0x0217A614
	ldr r2, [sp, #4]
	ldrh r1, [r0, #2]
	sub r2, r2, #0xc
	str r2, [sp, #4]
	cmp r2, r1
	ble _0215C550
	ldr r0, _0215C580 // =0x0217E7FC
	mov r1, #4
	ldr r0, [r0]
	ldrb r0, [r0, #0x11d]
	bl ovl08_215B860
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215C550:
	ldr r0, _0215C580 // =0x0217E7FC
	mov r2, r1
	ldr r0, [r0]
	mov r1, #4
	ldrb r0, [r0, #0x11d]
	bl ovl08_215B860
	bl ovl08_215B61C
	ldr r1, _0215C588 // =ovl08_215C4D0
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C580: .word 0x0217E7FC
_0215C584: .word 0x0217A614
_0215C588: .word ovl08_215C4D0
	arm_func_end ovl08_215C4F0

	arm_func_start ovl08_215C58C
ovl08_215C58C: // 0x0215C58C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215C62C // =0x0217E7FC
	ldr r2, _0215C630 // =0x0217A63C
	ldr lr, [r1]
	ldr r1, _0215C634 // =0x01FF0000
	ldr ip, [lr, #0xc0]
	ldrh r3, [r2, #0x92]
	ldr r2, [ip]
	mov r4, r0
	and r0, r2, r1
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [ip]
	and r0, r0, #0xff
	sub r2, r0, #0xc
	str r0, [sp, #4]
	str r2, [sp, #4]
	cmp r2, r3
	ble _0215C5F0
	ldrb r0, [lr, #0x11d]
	mov r1, #3
	bl ovl08_215B860
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215C5F0:
	ldrb r0, [lr, #0x11d]
	mov r2, r3
	mov r1, #3
	bl ovl08_215B860
	ldr r0, _0215C62C // =0x0217E7FC
	mov r1, #4
	ldr r0, [r0]
	mov r2, #0xc0
	ldrb r0, [r0, #0x11d]
	bl ovl08_215B860
	ldr r1, _0215C638 // =ovl08_215C4F0
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C62C: .word 0x0217E7FC
_0215C630: .word 0x0217A63C
_0215C634: .word 0x01FF0000
_0215C638: .word ovl08_215C4F0
	arm_func_end ovl08_215C58C

	arm_func_start ovl08_215C63C
ovl08_215C63C: // 0x0215C63C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215C6DC // =0x0217E7FC
	ldr r2, _0215C6E0 // =0x0217A63C
	ldr lr, [r1]
	ldr r1, _0215C6E4 // =0x01FF0000
	ldr ip, [lr, #0x90]
	ldrh r3, [r2, #0x62]
	ldr r2, [ip]
	mov r4, r0
	and r0, r2, r1
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [ip]
	and r0, r0, #0xff
	sub r2, r0, #0xc
	str r0, [sp, #4]
	str r2, [sp, #4]
	cmp r2, r3
	ble _0215C6A0
	ldrb r0, [lr, #0x11d]
	mov r1, #2
	bl ovl08_215B860
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215C6A0:
	ldrb r0, [lr, #0x11d]
	mov r2, r3
	mov r1, #2
	bl ovl08_215B860
	ldr r0, _0215C6DC // =0x0217E7FC
	mov r1, #3
	ldr r0, [r0]
	mov r2, #0xc0
	ldrb r0, [r0, #0x11d]
	bl ovl08_215B860
	ldr r1, _0215C6E8 // =ovl08_215C58C
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C6DC: .word 0x0217E7FC
_0215C6E0: .word 0x0217A63C
_0215C6E4: .word 0x01FF0000
_0215C6E8: .word ovl08_215C58C
	arm_func_end ovl08_215C63C

	arm_func_start ovl08_215C6EC
ovl08_215C6EC: // 0x0215C6EC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215C78C // =0x0217E7FC
	ldr r2, _0215C790 // =0x0217A63C
	ldr lr, [r1]
	ldr r1, _0215C794 // =0x01FF0000
	ldr ip, [lr, #0x60]
	ldrh r3, [r2, #0x32]
	ldr r2, [ip]
	mov r4, r0
	and r0, r2, r1
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [ip]
	and r0, r0, #0xff
	sub r2, r0, #0xc
	str r0, [sp, #4]
	str r2, [sp, #4]
	cmp r2, r3
	ble _0215C750
	ldrb r0, [lr, #0x11d]
	mov r1, #1
	bl ovl08_215B860
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215C750:
	ldrb r0, [lr, #0x11d]
	mov r2, r3
	mov r1, #1
	bl ovl08_215B860
	ldr r0, _0215C78C // =0x0217E7FC
	mov r1, #2
	ldr r0, [r0]
	mov r2, #0xc0
	ldrb r0, [r0, #0x11d]
	bl ovl08_215B860
	ldr r1, _0215C798 // =ovl08_215C63C
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C78C: .word 0x0217E7FC
_0215C790: .word 0x0217A63C
_0215C794: .word 0x01FF0000
_0215C798: .word ovl08_215C63C
	arm_func_end ovl08_215C6EC

	arm_func_start ovl08_215C79C
ovl08_215C79C: // 0x0215C79C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215C83C // =0x0217E7FC
	ldr r2, _0215C840 // =0x0217A63C
	ldr lr, [r1]
	ldr r1, _0215C844 // =0x01FF0000
	ldr ip, [lr, #0x30]
	ldrh r3, [r2, #2]
	ldr r2, [ip]
	mov r4, r0
	and r0, r2, r1
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [ip]
	and r0, r0, #0xff
	sub r2, r0, #0xc
	str r0, [sp, #4]
	str r2, [sp, #4]
	cmp r2, r3
	ble _0215C800
	ldrb r0, [lr, #0x11d]
	mov r1, #0
	bl ovl08_215B860
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215C800:
	ldrb r0, [lr, #0x11d]
	mov r2, r3
	mov r1, #0
	bl ovl08_215B860
	ldr r0, _0215C83C // =0x0217E7FC
	mov r1, #1
	ldr r0, [r0]
	mov r2, #0xc0
	ldrb r0, [r0, #0x11d]
	bl ovl08_215B860
	ldr r1, _0215C848 // =ovl08_215C6EC
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C83C: .word 0x0217E7FC
_0215C840: .word 0x0217A63C
_0215C844: .word 0x01FF0000
_0215C848: .word ovl08_215C6EC
	arm_func_end ovl08_215C79C

	arm_func_start ovl08_215C84C
ovl08_215C84C: // 0x0215C84C
	ldr r0, _0215C864 // =0x0217E7FC
	ldr r0, [r0]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0215C864: .word 0x0217E7FC
	arm_func_end ovl08_215C84C

	arm_func_start ovl08_215C868
ovl08_215C868: // 0x0215C868
	ldr r1, _0215C878 // =0x0217E7FC
	ldr r1, [r1]
	strb r0, [r1, #0x124]
	bx lr
	.align 2, 0
_0215C878: .word 0x0217E7FC
	arm_func_end ovl08_215C868

	arm_func_start ovl08_215C87C
ovl08_215C87C: // 0x0215C87C
	ldr r1, _0215C88C // =0x0217E7FC
	ldr r1, [r1]
	strb r0, [r1, #0x123]
	bx lr
	.align 2, 0
_0215C88C: .word 0x0217E7FC
	arm_func_end ovl08_215C87C

	arm_func_start ovl08_215C890
ovl08_215C890: // 0x0215C890
	ldr r0, _0215C8A0 // =0x0217E7FC
	ldr r0, [r0]
	ldrb r0, [r0, #0x11c]
	bx lr
	.align 2, 0
_0215C8A0: .word 0x0217E7FC
	arm_func_end ovl08_215C890

	arm_func_start ovl08_215C8A4
ovl08_215C8A4: // 0x0215C8A4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0215C8D8 // =0x0217E7FC
	ldr r0, [r0]
	ldr r0, [r0, #0x114]
	bl ovl08_2175204
	ldr r0, _0215C8D8 // =0x0217E7FC
	ldr r1, _0215C8DC // =ovl08_215B10C
	ldr r0, [r0]
	ldr r0, [r0, #0x118]
	bl ovl08_2177890
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215C8D8: .word 0x0217E7FC
_0215C8DC: .word ovl08_215B10C
	arm_func_end ovl08_215C8A4

	arm_func_start ovl08_215C8E0
ovl08_215C8E0: // 0x0215C8E0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x44
	add r2, sp, #0x34
	mov r1, #0
	strh r1, [r2]
	strh r1, [r2, #2]
	strh r1, [r2, #4]
	strh r1, [r2, #6]
	ldr r0, _0215CC70 // =0x0217A5F0
	mov r1, #4
	ldrh r3, [r0]
	ldrh r2, [r0, #2]
	mov r0, #0x128
	strh r3, [sp, #0x38]
	strh r2, [sp, #0x3a]
	bl ovl08_2176764
	ldr r8, _0215CC74 // =0x0217E7FC
	mov r6, #0
	mov r1, #0xff
	str r0, [r8]
	strb r1, [r0, #0x11c]
	ldr r0, [r8]
	mov r1, #1
	strb r6, [r0, #0x121]
	ldr r0, [r8]
	ldr r7, _0215CC78 // =0xC1FFFCFF
	strb r1, [r0, #0x123]
	ldr r0, [r8]
	mov r5, r6
	strb r1, [r0, #0x124]
	mov r4, #0x34
_0215C95C:
	mov r0, r5
	mov r1, r4
	bl ovl08_2175570
	ldr r1, [r8]
	add r1, r1, r6, lsl #2
	str r0, [r1, #0x30]
	ldr r0, [r8]
	add r0, r0, r6, lsl #2
	ldr r1, [r0, #0x30]
	ldr r0, [r1]
	and r0, r0, r7
	orr r0, r0, #0x200
	str r0, [r1]
	ldr r0, [r8]
	add r0, r0, r6, lsl #2
	ldr r1, [r0, #0x30]
	add r6, r6, #1
	ldrh r0, [r1, #4]
	cmp r6, #0x2f
	bic r0, r0, #0xc00
	orr r0, r0, #0xc00
	strh r0, [r1, #4]
	blt _0215C95C
	ldr r6, _0215CC7C // =0x0217A5E4
	mov r5, #0
	ldr r8, _0215CC74 // =0x0217E7FC
	mov r4, r5
	ldr r7, _0215CC78 // =0xC1FFFCFF
_0215C9CC:
	ldrb r1, [r6]
	mov r0, r4
	bl ovl08_2175570
	ldr r1, [r8]
	add r6, r6, #1
	add r1, r1, r5, lsl #2
	str r0, [r1, #0xec]
	ldr r0, [r8]
	add r0, r0, r5, lsl #2
	ldr r1, [r0, #0xec]
	ldr r0, [r1]
	and r0, r0, r7
	orr r0, r0, #0x200
	str r0, [r1]
	ldr r0, [r8]
	add r0, r0, r5, lsl #2
	ldr r1, [r0, #0xec]
	add r5, r5, #1
	ldrh r0, [r1, #4]
	cmp r5, #4
	bic r0, r0, #0xc00
	orr r0, r0, #0xc00
	strh r0, [r1, #4]
	blt _0215C9CC
	ldr r10, _0215CC80 // =0x0217A5DC
	mov r9, #0
	ldr r4, _0215CC74 // =0x0217E7FC
	mov r11, r9
	str r9, [sp, #0x1c]
	mov r8, #1
	mvn r7, #0
	mov r6, #0x200
	mov r5, #3
_0215CA50:
	ldrb r1, [r10]
	mov r0, r11
	mov r2, r8
	bl ovl08_2175528
	ldr r2, [r4]
	ldr r3, [sp, #0x1c]
	add r2, r2, r9, lsl #2
	str r0, [r2, #0xfc]
	ldr r0, [r4]
	mov r1, r7
	add r0, r0, r9, lsl #2
	ldr r0, [r0, #0xfc]
	mov r2, r6
	bl ovl08_2175138
	ldr r0, [r4]
	mov r1, r7
	add r0, r0, r9, lsl #2
	ldr r0, [r0, #0xfc]
	mov r2, r5
	bl ovl08_2174F30
	add r9, r9, #1
	add r10, r10, #1
	cmp r9, #2
	blt _0215CA50
	ldr r1, _0215CC84 // =0x0217A5E8
	mov r7, #0
	ldrh r0, [r1, #2]
	ldr r11, _0215CC88 // =0x0217B410
	ldr r4, _0215CC74 // =0x0217E7FC
	str r0, [sp, #0x10]
	ldrh r0, [r1]
	strh r7, [sp, #0x42]
	str r7, [sp, #0x2c]
	str r0, [sp, #0x14]
	mov r0, #1
	str r7, [sp, #0x24]
	str r7, [sp, #0x28]
	str r7, [sp, #0x20]
	mov r6, #2
	mov r5, #0x480
	str r0, [sp, #0x30]
_0215CAF4:
	ldr r9, [sp, #0x20]
	mov r0, r9
	str r0, [sp, #0x18]
_0215CB00:
	add r0, sp, #0x3c
	str r0, [sp]
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x14]
	ldr r2, [sp, #0x10]
	str r0, [sp, #4]
	mov r3, r0
	bl ovl08_21760B4
	ldr r1, [r4]
	ldr r10, [sp, #0x18]
	add r1, r1, r7, lsl #4
	str r0, [r1, r9, lsl #2]
	ldr r0, [sp, #0x28]
	strh r0, [sp, #0x34]
	mov r8, r0
_0215CB3C:
	ldr r1, [r11, r7, lsl #2]
	mov r0, r10, lsl #1
	ldrh r2, [r1, r0]
	ldrh r1, [sp, #0x3a]
	mov r0, r7, lsl #4
	strh r2, [sp, #0x40]
	str r1, [sp]
	str r6, [sp, #4]
	add r2, r0, r9, lsl #2
	str r5, [sp, #8]
	add r0, sp, #0x40
	str r0, [sp, #0xc]
	ldr r0, [r4]
	ldrh r1, [sp, #0x34]
	ldr r0, [r0, r2]
	ldrh r2, [sp, #0x36]
	ldrh r3, [sp, #0x38]
	bl ovl08_2175C00
	ldrh r0, [sp, #0x34]
	add r8, r8, #1
	cmp r8, #0xc
	add r0, r0, #0x12
	add r10, r10, #1
	strh r0, [sp, #0x34]
	blt _0215CB3C
	cmp r7, #0
	bne _0215CBC4
	ldr r0, [sp, #0x2c]
	ldr r1, [sp, #0x3c]
	ldr r2, [sp, #0x30]
	bl ovl08_2175290
	ldr r1, [r4]
	add r1, r1, r9, lsl #2
	str r0, [r1, #0x104]
_0215CBC4:
	ldr r0, [sp, #0x18]
	add r9, r9, #1
	add r0, r0, #0xc
	str r0, [sp, #0x18]
	cmp r9, #4
	blt _0215CB00
	add r7, r7, #1
	cmp r7, #3
	blt _0215CAF4
	mov r0, #0
	mov r1, #0x40
	mov r2, #1
	bl ovl08_2175528
	ldr r3, _0215CC74 // =0x0217E7FC
	mvn r1, #0
	ldr r4, [r3]
	mov r2, #0x200
	str r0, [r4, #0x114]
	ldr r0, [r3]
	mov r3, #0
	ldr r0, [r0, #0x114]
	bl ovl08_2175138
	ldr r0, _0215CC74 // =0x0217E7FC
	mvn r1, #0
	ldr r0, [r0]
	mov r2, #2
	ldr r0, [r0, #0x114]
	bl ovl08_2174F30
	mov r0, #0
	ldr r1, _0215CC8C // =ovl08_215C79C
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r3, _0215CC74 // =0x0217E7FC
	mov r1, #0
	ldr r4, [r3]
	mov r2, #0xc0
	str r0, [r4, #0x118]
	ldr r0, [r3]
	ldrb r0, [r0, #0x11d]
	bl ovl08_215B860
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215CC70: .word 0x0217A5F0
_0215CC74: .word 0x0217E7FC
_0215CC78: .word 0xC1FFFCFF
_0215CC7C: .word 0x0217A5E4
_0215CC80: .word 0x0217A5DC
_0215CC84: .word 0x0217A5E8
_0215CC88: .word 0x0217B410
_0215CC8C: .word ovl08_215C79C
	arm_func_end ovl08_215C8E0

	arm_func_start ovl08_215CC90
ovl08_215CC90: // 0x0215CC90
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r1, r0
	mov r0, #0
	bl ovl08_2177870
	mov r5, #0
	ldr r4, _0215CD50 // =0x0217E800
_0215CCAC:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x48]
	bl ovl08_2175204
	ldr r0, [r4]
	ldr r0, [r0, r5, lsl #2]
	bl ovl08_2176088
	add r5, r5, #1
	cmp r5, #4
	blt _0215CCAC
	ldr r4, _0215CD50 // =0x0217E800
	mov r5, #0
_0215CCDC:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x40]
	bl ovl08_2175204
	add r5, r5, #1
	cmp r5, #2
	blt _0215CCDC
	ldr r4, _0215CD50 // =0x0217E800
	mov r5, #0
_0215CD00:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x38]
	bl ovl08_21770F8
	add r5, r5, #1
	cmp r5, #2
	blt _0215CD00
	ldr r4, _0215CD50 // =0x0217E800
	mov r5, #0
_0215CD24:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x10]
	bl ovl08_21770F8
	add r5, r5, #1
	cmp r5, #0xa
	blt _0215CD24
	ldr r0, _0215CD50 // =0x0217E800
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215CD50: .word 0x0217E800
	arm_func_end ovl08_215CC90

	arm_func_start ovl08_215CD54
ovl08_215CD54: // 0x0215CD54
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215CDC0 // =0x0217E800
	mov r4, r0
	ldr r0, [r1]
	ldr r1, _0215CDC4 // =0x01FF0000
	ldr r3, [r0, #0x10]
	mov r0, #0
	ldr r2, [r3]
	and r1, r2, r1
	mov r1, r1, lsr #0x10
	str r1, [sp]
	ldr r1, [r3]
	and r1, r1, #0xff
	str r1, [sp, #4]
	add r1, r1, #0xc
	str r1, [sp, #4]
	bl ovl08_215D1F0
	ldr r0, [sp, #4]
	cmp r0, #0xc0
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	ldr r1, _0215CDC8 // =ovl08_215CC90
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CDC0: .word 0x0217E800
_0215CDC4: .word 0x01FF0000
_0215CDC8: .word ovl08_215CC90
	arm_func_end ovl08_215CD54

	arm_func_start ovl08_215CDCC
ovl08_215CDCC: // 0x0215CDCC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215CE38 // =0x0217E800
	mov r4, r0
	ldr r0, [r1]
	ldr r1, _0215CE3C // =0x01FF0000
	ldr r3, [r0, #0x1c]
	mov r0, #1
	ldr r2, [r3]
	and r1, r2, r1
	mov r1, r1, lsr #0x10
	str r1, [sp]
	ldr r1, [r3]
	and r1, r1, #0xff
	str r1, [sp, #4]
	add r1, r1, #0xc
	str r1, [sp, #4]
	bl ovl08_215D1F0
	ldr r0, [sp, #4]
	cmp r0, #0xc0
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	ldr r1, _0215CE40 // =ovl08_215CD54
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CE38: .word 0x0217E800
_0215CE3C: .word 0x01FF0000
_0215CE40: .word ovl08_215CD54
	arm_func_end ovl08_215CDCC

	arm_func_start ovl08_215CE44
ovl08_215CE44: // 0x0215CE44
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215CEB0 // =0x0217E800
	mov r4, r0
	ldr r0, [r1]
	ldr r1, _0215CEB4 // =0x01FF0000
	ldr r3, [r0, #0x28]
	mov r0, #2
	ldr r2, [r3]
	and r1, r2, r1
	mov r1, r1, lsr #0x10
	str r1, [sp]
	ldr r1, [r3]
	and r1, r1, #0xff
	str r1, [sp, #4]
	add r1, r1, #0xc
	str r1, [sp, #4]
	bl ovl08_215D1F0
	ldr r0, [sp, #4]
	cmp r0, #0xc0
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	ldr r1, _0215CEB8 // =ovl08_215CDCC
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CEB0: .word 0x0217E800
_0215CEB4: .word 0x01FF0000
_0215CEB8: .word ovl08_215CDCC
	arm_func_end ovl08_215CE44

	arm_func_start ovl08_215CEBC
ovl08_215CEBC: // 0x0215CEBC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215CF28 // =0x0217E800
	mov r4, r0
	ldr r0, [r1]
	ldr r1, _0215CF2C // =0x01FF0000
	ldr r3, [r0, #0x34]
	mov r0, #3
	ldr r2, [r3]
	and r1, r2, r1
	mov r1, r1, lsr #0x10
	str r1, [sp]
	ldr r1, [r3]
	and r1, r1, #0xff
	str r1, [sp, #4]
	add r1, r1, #0xc
	str r1, [sp, #4]
	bl ovl08_215D1F0
	ldr r0, [sp, #4]
	cmp r0, #0xc0
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	ldr r1, _0215CF30 // =ovl08_215CE44
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CF28: .word 0x0217E800
_0215CF2C: .word 0x01FF0000
_0215CF30: .word ovl08_215CE44
	arm_func_end ovl08_215CEBC

	arm_func_start ovl08_215CF34
ovl08_215CF34: // 0x0215CF34
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215CFA8 // =0x0217E800
	mov r4, r0
	ldr r0, [r1]
	mov r1, #0
	ldr r0, [r0, #0x40]
	bl ovl08_21751F8
	ldr r2, [r0]
	ldr r1, _0215CFAC // =0x01FF0000
	and r1, r2, r1
	mov r1, r1, lsr #0x10
	str r1, [sp]
	ldr r1, [r0]
	mov r0, #4
	and r1, r1, #0xff
	str r1, [sp, #4]
	add r1, r1, #0xc
	str r1, [sp, #4]
	bl ovl08_215D1F0
	ldr r0, [sp, #4]
	cmp r0, #0xc0
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	ldr r1, _0215CFB0 // =ovl08_215CEBC
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CFA8: .word 0x0217E800
_0215CFAC: .word 0x01FF0000
_0215CFB0: .word ovl08_215CEBC
	arm_func_end ovl08_215CF34

	arm_func_start ovl08_215CFB4
ovl08_215CFB4: // 0x0215CFB4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0215D080 // =0x0217E800
	ldr r2, _0215D084 // =0x0217A980
	ldr r3, [r1]
	ldrsb ip, [r3, #0x63]
	add r2, r2, ip, lsl #2
	ldrsb r2, [r0, r2]
	strb r2, [r3, #0x63]
	ldr r1, [r1]
	ldrsb r2, [r1, #0x63]
	cmp r2, #0xd
	bne _0215D000
	cmp r0, #1
	beq _0215CFF8
	cmp r0, #3
	bne _0215D000
_0215CFF8:
	strb ip, [r1, #0x64]
	b _0215D06C
_0215D000:
	mvn r0, #0
	cmp r2, r0
	bne _0215D038
	ldrsb r0, [r1, #0x64]
	cmp r0, #1
	beq _0215D020
	cmp r0, #0xa
	bne _0215D02C
_0215D020:
	mov r0, #0xa
	strb r0, [r1, #0x63]
	b _0215D06C
_0215D02C:
	mov r0, #0xb
	strb r0, [r1, #0x63]
	b _0215D06C
_0215D038:
	mvn r0, #1
	cmp r2, r0
	bne _0215D06C
	ldrsb r0, [r1, #0x64]
	cmp r0, #1
	beq _0215D058
	cmp r0, #0xa
	bne _0215D064
_0215D058:
	mov r0, #1
	strb r0, [r1, #0x63]
	b _0215D06C
_0215D064:
	mov r0, #2
	strb r0, [r1, #0x63]
_0215D06C:
	bl ovl08_215D088
	mov r0, #8
	bl ovl08_216F934
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215D080: .word 0x0217E800
_0215D084: .word 0x0217A980
	arm_func_end ovl08_215CFB4

	arm_func_start ovl08_215D088
ovl08_215D088: // 0x0215D088
	stmdb sp!, {r4, lr}
	ldr r0, _0215D108 // =0x0217E800
	ldr r1, [r0]
	ldrsb r0, [r1, #0x63]
	cmp r0, #0xb
	movle r4, #0x44
	ldr r0, [r1, #0x58]
	movgt r4, #0x45
	mov r1, #0
	bl ovl08_21751F8
	mov r2, r0
	mov r1, r4
	mov r0, #0
	bl ovl08_217559C
	ldr r0, _0215D108 // =0x0217E800
	mvn r1, #0
	ldr r0, [r0]
	mov r2, #2
	ldr r0, [r0, #0x58]
	bl ovl08_2174F30
	ldr r0, _0215D108 // =0x0217E800
	ldr r2, _0215D10C // =0x0217A948
	ldr r0, [r0]
	ldr r3, _0215D110 // =0x0217A94A
	ldrsb ip, [r0, #0x63]
	ldr r0, [r0, #0x58]
	mvn r1, #0
	mov ip, ip, lsl #2
	ldrh r2, [r2, ip]
	ldrh r3, [r3, ip]
	bl ovl08_2174FA4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D108: .word 0x0217E800
_0215D10C: .word 0x0217A948
_0215D110: .word 0x0217A94A
	arm_func_end ovl08_215D088

	arm_func_start ovl08_215D114
ovl08_215D114: // 0x0215D114
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	addlt sp, sp, #4
	ldmltia sp!, {pc}
	cmp r0, #0xa
	bge _0215D16C
	ldr r2, _0215D1E4 // =0x0217E800
	ldr r3, _0215D1E8 // =0x0217A8AC
	ldr r2, [r2]
	add sp, sp, #4
	add r0, r2, r0, lsl #2
	ldr ip, [r0, #0x10]
	ldr r0, [ip]
	bic r0, r0, #0xc00
	str r0, [ip]
	ldrh r2, [ip, #4]
	ldrb r0, [r3, r1]
	bic r1, r2, #0xf000
	orr r0, r1, r0, lsl #12
	strh r0, [ip, #4]
	ldmia sp!, {pc}
_0215D16C:
	sub r3, r0, #0xa
	cmp r3, #2
	bge _0215D1B4
	ldr r0, _0215D1E4 // =0x0217E800
	ldr r2, _0215D1E8 // =0x0217A8AC
	ldr r0, [r0]
	add sp, sp, #4
	add r0, r0, r3, lsl #2
	ldr ip, [r0, #0x38]
	ldr r0, [ip]
	bic r0, r0, #0xc00
	str r0, [ip]
	ldrh r3, [ip, #4]
	ldrb r0, [r2, r1]
	bic r1, r3, #0xf000
	orr r0, r1, r0, lsl #12
	strh r0, [ip, #4]
	ldmia sp!, {pc}
_0215D1B4:
	ldr r2, _0215D1E4 // =0x0217E800
	ldr r3, _0215D1EC // =0x0217A8A0
	ldr r2, [r2]
	sub r0, r0, #0xc
	add r0, r2, r0, lsl #2
	ldrb r3, [r3, r1]
	ldr r0, [r0, #0x40]
	mvn r1, #0
	mov r2, #0
	bl ovl08_21750B0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215D1E4: .word 0x0217E800
_0215D1E8: .word 0x0217A8AC
_0215D1EC: .word 0x0217A8A0
	arm_func_end ovl08_215D114

	arm_func_start ovl08_215D1F0
ovl08_215D1F0: // 0x0215D1F0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	ldr r3, _0215D45C // =0x0217A8D0
	ldr r9, _0215D460 // =0x0217A8D8
	ldrb r5, [r3, #3]
	ldrb r8, [r3]
	ldrb r7, [r3, #1]
	strb r5, [sp, #0xb]
	mov r5, r0
	mov r0, #3
	mul r0, r5, r0
	ldrb r6, [r3, #2]
	ldrb ip, [r3, #4]
	ldr r2, _0215D464 // =0x0217A8C8
	strb r8, [sp, #8]
	strb r7, [sp, #9]
	strb r6, [sp, #0xa]
	strb ip, [sp, #0xc]
	ldrb r4, [r9]
	ldrb r3, [r9, #1]
	ldrb r11, [r9, #2]
	ldrb r10, [r9, #3]
	ldrb r9, [r9, #4]
	ldrb lr, [r2]
	ldrb r8, [r2, #1]
	ldrb r7, [r2, #2]
	ldrb r6, [r2, #3]
	ldrb r2, [r2, #4]
	strb r4, [sp, #0xd]
	add ip, sp, #8
	str r0, [sp, #4]
	ldrb r0, [ip, r5]
	strb r3, [sp, #0xe]
	strb r2, [sp, #0x16]
	mov r4, r1
	ldr r3, [sp, #4]
	strb r11, [sp, #0xf]
	strb r10, [sp, #0x10]
	strb r9, [sp, #0x11]
	strb lr, [sp, #0x12]
	strb r8, [sp, #0x13]
	strb r7, [sp, #0x14]
	strb r6, [sp, #0x15]
	cmp r0, #0
	mov r2, #0
	ble _0215D31C
	and r1, r4, #0xff
	add r0, ip, r5
	ldr r6, _0215D468 // =0x0217E800
	ldr r7, _0215D46C // =0x0217A920
	ldr r11, _0215D470 // =0xC1FFFCFF
	ldr ip, _0215D474 // =0x000001FF
	ldr lr, _0215D478 // =0xFE00FF00
_0215D2C4:
	ldr r8, [r6]
	mov r9, r3, lsl #2
	add r8, r8, r3, lsl #2
	ldr r8, [r8, #0x10]
	add r2, r2, #1
	ldr r10, [r8]
	and r10, r10, r11
	str r10, [r8]
	ldrh r8, [r7, r9]
	ldr r9, [r6]
	add r9, r9, r3, lsl #2
	ldr r9, [r9, #0x10]
	and r8, r8, ip
	ldr r10, [r9]
	add r3, r3, #1
	and r10, r10, lr
	orr r10, r10, r1
	orr r8, r10, r8, lsl #16
	str r8, [r9]
	ldrb r8, [r0]
	cmp r2, r8
	blt _0215D2C4
_0215D31C:
	cmp r5, #4
	bge _0215D358
	ldr r0, _0215D468 // =0x0217E800
	mov r2, #2
	ldr r3, [r0]
	ldr r0, [sp, #4]
	str r2, [sp]
	ldr r1, _0215D46C // =0x0217A920
	mov r0, r0, lsl #2
	ldrh r1, [r1, r0]
	add r2, r3, r5, lsl #2
	ldr r0, [r3, r5, lsl #2]
	ldr r3, [r2, #0x48]
	mov r2, r4
	bl ovl08_2175B50
_0215D358:
	add r3, sp, #0xd
	ldrb r1, [r3, r5]
	mov r0, #0
	cmp r1, #0
	ble _0215D3DC
	and r2, r4, #0xff
	add r1, r3, r5
	ldr r8, _0215D468 // =0x0217E800
	ldr r9, _0215D47C // =0x0217A8E8
	ldr r3, _0215D470 // =0xC1FFFCFF
	ldr r6, _0215D474 // =0x000001FF
	ldr r7, _0215D478 // =0xFE00FF00
_0215D388:
	ldr r10, [r8]
	mov r11, r0, lsl #2
	add r10, r10, r0, lsl #2
	ldr r10, [r10, #0x38]
	ldr ip, [r10]
	and ip, ip, r3
	str ip, [r10]
	ldr ip, [r8]
	ldrh r10, [r9, r11]
	add r11, ip, r0, lsl #2
	ldr r11, [r11, #0x38]
	and r10, r10, r6
	ldr ip, [r11]
	add r0, r0, #1
	and ip, ip, r7
	orr ip, ip, r2
	orr r10, ip, r10, lsl #16
	str r10, [r11]
	ldrb r10, [r1]
	cmp r0, r10
	blt _0215D388
_0215D3DC:
	add r1, sp, #0x12
	ldrb r0, [r1, r5]
	mov r8, #0
	cmp r0, #0
	addle sp, sp, #0x1c
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r9, r1, r5
	ldr r10, _0215D468 // =0x0217E800
	ldr r5, _0215D480 // =0x0217A8F0
	mov r6, r8
	mvn r7, #0
_0215D408:
	ldr r0, [r10]
	mov r1, r7
	add r0, r0, r8, lsl #2
	ldr r0, [r0, #0x40]
	mov r2, r6
	mov r3, r6
	bl ovl08_2175138
	ldr r0, [r10]
	mov r1, r8, lsl #2
	add r0, r0, r8, lsl #2
	ldrh r2, [r5, r1]
	ldr r0, [r0, #0x40]
	mov r1, r7
	mov r3, r4
	bl ovl08_2174FA4
	ldrb r0, [r9]
	add r8, r8, #1
	cmp r8, r0
	blt _0215D408
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215D45C: .word 0x0217A8D0
_0215D460: .word 0x0217A8D8
_0215D464: .word 0x0217A8C8
_0215D468: .word 0x0217E800
_0215D46C: .word 0x0217A920
_0215D470: .word 0xC1FFFCFF
_0215D474: .word 0x000001FF
_0215D478: .word 0xFE00FF00
_0215D47C: .word 0x0217A8E8
_0215D480: .word 0x0217A8F0
	arm_func_end ovl08_215D1F0

	arm_func_start ovl08_215D484
ovl08_215D484: // 0x0215D484
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0x20
	bl ovl08_2176B34
	cmp r0, #0
	beq _0215D4A4
	mov r0, #0
	bl ovl08_215CFB4
_0215D4A4:
	mov r0, #0x40
	bl ovl08_2176B34
	cmp r0, #0
	beq _0215D4BC
	mov r0, #1
	bl ovl08_215CFB4
_0215D4BC:
	mov r0, #0x10
	bl ovl08_2176B34
	cmp r0, #0
	beq _0215D4D4
	mov r0, #2
	bl ovl08_215CFB4
_0215D4D4:
	mov r0, #0x80
	bl ovl08_2176B34
	cmp r0, #0
	beq _0215D4EC
	mov r0, #3
	bl ovl08_215CFB4
_0215D4EC:
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	beq _0215D5AC
	ldr r0, _0215D634 // =0x0217E800
	ldr r0, [r0]
	ldrsb r2, [r0, #0x63]
	cmp r2, #0xa
	bge _0215D53C
	ldrb r1, [r0, #0x67]
	cmp r1, #0
	ldrne r1, _0215D638 // =a7894561230
	addne sp, sp, #4
	ldrneb r1, [r1, r2]
	strneb r1, [r0, #0x60]
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_216F934
	add sp, sp, #4
	ldmia sp!, {pc}
_0215D53C:
	sub r1, r2, #0xa
	cmp r1, #2
	bge _0215D59C
	cmp r1, #0
	bne _0215D55C
	ldrb r1, [r0, #0x66]
	cmp r1, #0
	beq _0215D574
_0215D55C:
	sub r1, r2, #0xa
	cmp r1, #1
	bne _0215D584
	ldrb r1, [r0, #0x68]
	cmp r1, #0
	bne _0215D584
_0215D574:
	mov r0, #9
	bl ovl08_216F934
	add sp, sp, #4
	ldmia sp!, {pc}
_0215D584:
	ldr r1, _0215D63C // =0x0217A8B4
	sub r2, r2, #0xa
	ldrb r1, [r1, r2]
	add sp, sp, #4
	strb r1, [r0, #0x60]
	ldmia sp!, {pc}
_0215D59C:
	ldr r1, _0215D640 // =0x0217A8B0
	sub r2, r2, #0xc
	ldrb r1, [r1, r2]
	strb r1, [r0, #0x60]
_0215D5AC:
	mov r0, #2
	bl ovl08_2176B34
	cmp r0, #0
	beq _0215D610
	ldr r0, _0215D634 // =0x0217E800
	ldr r1, [r0]
	ldrb r0, [r1, #0x66]
	cmp r0, #0
	bne _0215D600
	ldrb r0, [r1, #0x69]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _0215D634 // =0x0217E800
	mov r1, #1
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x69]
	ldmia sp!, {pc}
_0215D600:
	mov r0, #0x10
	strb r0, [r1, #0x60]
	add sp, sp, #4
	ldmia sp!, {pc}
_0215D610:
	mov r0, #2
	bl ovl08_2176B10
	cmp r0, #0
	ldrne r0, _0215D634 // =0x0217E800
	movne r1, #0
	ldrne r0, [r0]
	strneb r1, [r0, #0x69]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215D634: .word 0x0217E800
_0215D638: .word a7894561230
_0215D63C: .word 0x0217A8B4
_0215D640: .word 0x0217A8B0
	arm_func_end ovl08_215D484

	arm_func_start ovl08_215D644
ovl08_215D644: // 0x0215D644
	stmdb sp!, {r4, lr}
	ldr r1, _0215D68C // =0x0217E800
	mov r4, r0
	ldr r1, [r1]
	ldrsb r1, [r1, #0x62]
	cmp r4, r1
	ldmeqia sp!, {r4, pc}
	mov r1, #1
	bl ovl08_215D114
	ldr r0, _0215D68C // =0x0217E800
	mov r1, #0
	ldr r0, [r0]
	ldrsb r0, [r0, #0x62]
	bl ovl08_215D114
	ldr r0, _0215D68C // =0x0217E800
	ldr r0, [r0]
	strb r4, [r0, #0x62]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D68C: .word 0x0217E800
	arm_func_end ovl08_215D644

	arm_func_start ovl08_215D690
ovl08_215D690: // 0x0215D690
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r0, _0215D860 // =0x0217B024
	bl ovl08_2176AA4
	cmp r0, #0
	beq _0215D840
	ldr r6, _0215D864 // =0x0217A920
	mov r7, #0
	ldr r5, _0215D868 // =0x0217A8B8
	add r4, sp, #0
_0215D6B8:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl ovl08_21762F8
	mov r0, r4
	bl ovl08_2176AA4
	cmp r0, #0
	beq _0215D6F8
	ldr r0, _0215D86C // =0x0217E800
	ldr r0, [r0]
	ldrsb r0, [r0, #0x61]
	cmp r0, r7
	bne _0215D840
	mov r0, r7
	bl ovl08_215D644
	b _0215D848
_0215D6F8:
	add r7, r7, #1
	cmp r7, #0xa
	add r6, r6, #4
	blt _0215D6B8
	ldr r7, _0215D870 // =0x0217A8E8
	mov r6, #0
	ldr r5, _0215D874 // =0x0217A8C0
	add r4, sp, #0
_0215D718:
	mov r0, r7
	mov r1, r5
	mov r2, r4
	bl ovl08_21762F8
	mov r0, r4
	bl ovl08_2176AA4
	cmp r0, #0
	beq _0215D7D0
	ldr r1, _0215D86C // =0x0217E800
	add r0, r6, #0xa
	ldr r1, [r1]
	ldrsb r1, [r1, #0x61]
	cmp r1, r0
	bne _0215D840
	bl ovl08_215D644
	cmp r6, #0
	bne _0215D848
	ldr r0, _0215D86C // =0x0217E800
	ldr r2, [r0]
	ldrb r1, [r2, #0x65]
	add r1, r1, #1
	strb r1, [r2, #0x65]
	ldr r2, [r0]
	ldrb r1, [r2, #0x65]
	cmp r1, #0x28
	addlo sp, sp, #0xc
	ldmloia sp!, {r4, r5, r6, r7, pc}
	ldrb r1, [r2, #0x66]
	cmp r1, #0
	bne _0215D7B0
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _0215D86C // =0x0217E800
	mvn r1, #0
	ldr r0, [r0]
	add sp, sp, #0xc
	strb r1, [r0, #0x61]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215D7B0:
	mov r1, #0x10
	strb r1, [r2, #0x60]
	ldr r1, [r0]
	add sp, sp, #0xc
	ldrb r0, [r1, #0x65]
	sub r0, r0, #7
	strb r0, [r1, #0x65]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215D7D0:
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #4
	blt _0215D718
	ldr r7, _0215D878 // =0x0217A8F0
	mov r6, #0
	ldr r5, _0215D87C // =0x0217A8C4
	add r4, sp, #0
_0215D7F0:
	mov r0, r7
	mov r1, r5
	mov r2, r4
	bl ovl08_21762F8
	mov r0, r4
	bl ovl08_2176AA4
	cmp r0, #0
	beq _0215D830
	ldr r1, _0215D86C // =0x0217E800
	add r0, r6, #0xc
	ldr r1, [r1]
	ldrsb r1, [r1, #0x61]
	cmp r1, r0
	bne _0215D840
	bl ovl08_215D644
	b _0215D848
_0215D830:
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #4
	blt _0215D7F0
_0215D840:
	mvn r0, #0
	bl ovl08_215D644
_0215D848:
	ldr r0, _0215D86C // =0x0217E800
	mov r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x65]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215D860: .word 0x0217B024
_0215D864: .word 0x0217A920
_0215D868: .word 0x0217A8B8
_0215D86C: .word 0x0217E800
_0215D870: .word 0x0217A8E8
_0215D874: .word 0x0217A8C0
_0215D878: .word 0x0217A8F0
_0215D87C: .word 0x0217A8C4
	arm_func_end ovl08_215D690

	arm_func_start ovl08_215D880
ovl08_215D880: // 0x0215D880
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r1, _0215DA24 // =0x0217E800
	ldr r0, _0215DA28 // =0x0217B024
	ldr r1, [r1]
	mov r2, #0
	strb r2, [r1, #0x60]
	bl ovl08_2176960
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r7, _0215DA2C // =0x0217A920
	mov r4, #0
	ldr r6, _0215DA30 // =0x0217A8B8
	add r5, sp, #0
_0215D8BC:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl ovl08_21762F8
	mov r0, r5
	bl ovl08_2176960
	cmp r0, #0
	beq _0215D914
	ldr r0, _0215DA24 // =0x0217E800
	ldr r2, [r0]
	ldrsb r1, [r2, #0x61]
	cmp r1, r4
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r1, _0215DA34 // =a7894561230
	ldrb r1, [r1, r4]
	strb r1, [r2, #0x60]
	ldr r0, [r0]
	strb r4, [r0, #0x63]
	bl ovl08_215D088
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215D914:
	add r4, r4, #1
	cmp r4, #0xa
	add r7, r7, #4
	blt _0215D8BC
	ldr r7, _0215DA38 // =0x0217A8E8
	mov r4, #0
	ldr r6, _0215DA3C // =0x0217A8C0
	add r5, sp, #0
_0215D934:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl ovl08_21762F8
	mov r0, r5
	bl ovl08_2176960
	cmp r0, #0
	beq _0215D990
	ldr r0, _0215DA24 // =0x0217E800
	add r2, r4, #0xa
	ldr r3, [r0]
	ldrsb r1, [r3, #0x61]
	cmp r1, r2
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r1, _0215DA40 // =0x0217A8B4
	ldrb r1, [r1, r4]
	strb r1, [r3, #0x60]
	ldr r0, [r0]
	strb r2, [r0, #0x63]
	bl ovl08_215D088
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215D990:
	add r4, r4, #1
	cmp r4, #2
	add r7, r7, #4
	blt _0215D934
	ldr r7, _0215DA44 // =0x0217A8F0
	mov r4, #0
	ldr r6, _0215DA48 // =0x0217A8C4
	add r5, sp, #0
_0215D9B0:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl ovl08_21762F8
	mov r0, r5
	bl ovl08_2176960
	cmp r0, #0
	beq _0215DA0C
	ldr r0, _0215DA24 // =0x0217E800
	add r2, r4, #0xc
	ldr r3, [r0]
	ldrsb r1, [r3, #0x61]
	cmp r1, r2
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r1, _0215DA4C // =0x0217A8B0
	ldrb r1, [r1, r4]
	strb r1, [r3, #0x60]
	ldr r0, [r0]
	strb r2, [r0, #0x63]
	bl ovl08_215D088
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215DA0C:
	add r4, r4, #1
	cmp r4, #2
	add r7, r7, #4
	blt _0215D9B0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215DA24: .word 0x0217E800
_0215DA28: .word 0x0217B024
_0215DA2C: .word 0x0217A920
_0215DA30: .word 0x0217A8B8
_0215DA34: .word a7894561230
_0215DA38: .word 0x0217A8E8
_0215DA3C: .word 0x0217A8C0
_0215DA40: .word 0x0217A8B4
_0215DA44: .word 0x0217A8F0
_0215DA48: .word 0x0217A8C4
_0215DA4C: .word 0x0217A8B0
	arm_func_end ovl08_215D880

	arm_func_start ovl08_215DA50
ovl08_215DA50: // 0x0215DA50
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r0, _0215DC0C // =0x0217B024
	bl ovl08_2176A38
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0215DC10 // =0x0217E800
	mvn r1, #0
	ldr r0, [r0]
	ldr r7, _0215DC14 // =0x0217A920
	strb r1, [r0, #0x61]
	mov r4, #0
	ldr r6, _0215DC18 // =0x0217A8B8
	add r5, sp, #0
_0215DA8C:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl ovl08_21762F8
	mov r0, r5
	bl ovl08_2176A38
	cmp r0, #0
	beq _0215DAEC
	ldr r0, _0215DC10 // =0x0217E800
	ldr r0, [r0]
	ldrb r0, [r0, #0x67]
	cmp r0, #0
	bne _0215DAD0
	mov r0, #9
	bl ovl08_216F934
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215DAD0:
	mov r0, #0
	bl ovl08_216F934
	ldr r0, _0215DC10 // =0x0217E800
	add sp, sp, #0xc
	ldr r0, [r0]
	strb r4, [r0, #0x61]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215DAEC:
	add r4, r4, #1
	cmp r4, #0xa
	add r7, r7, #4
	blt _0215DA8C
	ldr r7, _0215DC1C // =0x0217A8E8
	mov r4, #0
	ldr r6, _0215DC20 // =0x0217A8C0
	add r5, sp, #0
_0215DB0C:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl ovl08_21762F8
	mov r0, r5
	bl ovl08_2176A38
	cmp r0, #0
	beq _0215DB94
	cmp r4, #0
	bne _0215DB48
	ldr r0, _0215DC10 // =0x0217E800
	ldr r0, [r0]
	ldrb r0, [r0, #0x66]
	cmp r0, #0
	beq _0215DB64
_0215DB48:
	cmp r4, #1
	bne _0215DB74
	ldr r0, _0215DC10 // =0x0217E800
	ldr r0, [r0]
	ldrb r0, [r0, #0x68]
	cmp r0, #0
	bne _0215DB74
_0215DB64:
	mov r0, #9
	bl ovl08_216F934
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215DB74:
	mov r0, #0
	bl ovl08_216F934
	ldr r0, _0215DC10 // =0x0217E800
	add r1, r4, #0xa
	ldr r0, [r0]
	add sp, sp, #0xc
	strb r1, [r0, #0x61]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215DB94:
	add r4, r4, #1
	cmp r4, #2
	add r7, r7, #4
	blt _0215DB0C
	ldr r7, _0215DC24 // =0x0217A8F0
	mov r6, #0
	ldr r5, _0215DC28 // =0x0217A8C4
	add r4, sp, #0
_0215DBB4:
	mov r0, r7
	mov r1, r5
	mov r2, r4
	bl ovl08_21762F8
	mov r0, r4
	bl ovl08_2176A38
	cmp r0, #0
	beq _0215DBF4
	mov r0, #0
	bl ovl08_216F934
	ldr r0, _0215DC10 // =0x0217E800
	add r1, r6, #0xc
	ldr r0, [r0]
	add sp, sp, #0xc
	strb r1, [r0, #0x61]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0215DBF4:
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #4
	blt _0215DBB4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215DC0C: .word 0x0217B024
_0215DC10: .word 0x0217E800
_0215DC14: .word 0x0217A920
_0215DC18: .word 0x0217A8B8
_0215DC1C: .word 0x0217A8E8
_0215DC20: .word 0x0217A8C0
_0215DC24: .word 0x0217A8F0
_0215DC28: .word 0x0217A8C4
	arm_func_end ovl08_215DA50

	arm_func_start ovl08_215DC2C
ovl08_215DC2C: // 0x0215DC2C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215DA50
	bl ovl08_215D880
	bl ovl08_215D690
	bl ovl08_215D484
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_215DC2C

	arm_func_start ovl08_215DC4C
ovl08_215DC4C: // 0x0215DC4C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215DCC4 // =0x0217E800
	mov r4, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0, #0x40]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r0, _0215DCC8 // =0x0217A8F0
	ldr r1, [sp, #4]
	ldrh r0, [r0, #2]
	sub r1, r1, #0xc
	str r1, [sp, #4]
	cmp r1, r0
	ble _0215DCA0
	mov r0, #4
	bl ovl08_215D1F0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215DCA0:
	mov r1, r0
	mov r0, #4
	bl ovl08_215D1F0
	bl ovl08_215D088
	ldr r1, _0215DCCC // =ovl08_215DC2C
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DCC4: .word 0x0217E800
_0215DCC8: .word 0x0217A8F0
_0215DCCC: .word ovl08_215DC2C
	arm_func_end ovl08_215DC4C

	arm_func_start ovl08_215DCD0
ovl08_215DCD0: // 0x0215DCD0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215DD5C // =0x0217E800
	ldr r2, _0215DD60 // =0x0217A920
	ldr r3, [r1]
	ldr r1, _0215DD64 // =0x01FF0000
	ldr ip, [r3, #0x34]
	ldrh r2, [r2, #0x26]
	ldr r3, [ip]
	mov r4, r0
	and r0, r3, r1
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [ip]
	and r0, r0, #0xff
	sub r1, r0, #0xc
	str r0, [sp, #4]
	str r1, [sp, #4]
	cmp r1, r2
	ble _0215DD30
	mov r0, #3
	bl ovl08_215D1F0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215DD30:
	mov r1, r2
	mov r0, #3
	bl ovl08_215D1F0
	mov r0, #4
	mov r1, #0xc0
	bl ovl08_215D1F0
	ldr r1, _0215DD68 // =ovl08_215DC4C
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DD5C: .word 0x0217E800
_0215DD60: .word 0x0217A920
_0215DD64: .word 0x01FF0000
_0215DD68: .word ovl08_215DC4C
	arm_func_end ovl08_215DCD0

	arm_func_start ovl08_215DD6C
ovl08_215DD6C: // 0x0215DD6C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215DDF8 // =0x0217E800
	ldr r2, _0215DDFC // =0x0217A920
	ldr r3, [r1]
	ldr r1, _0215DE00 // =0x01FF0000
	ldr ip, [r3, #0x28]
	ldrh r2, [r2, #0x1a]
	ldr r3, [ip]
	mov r4, r0
	and r0, r3, r1
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [ip]
	and r0, r0, #0xff
	sub r1, r0, #0xc
	str r0, [sp, #4]
	str r1, [sp, #4]
	cmp r1, r2
	ble _0215DDCC
	mov r0, #2
	bl ovl08_215D1F0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215DDCC:
	mov r1, r2
	mov r0, #2
	bl ovl08_215D1F0
	mov r0, #3
	mov r1, #0xc0
	bl ovl08_215D1F0
	ldr r1, _0215DE04 // =ovl08_215DCD0
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DDF8: .word 0x0217E800
_0215DDFC: .word 0x0217A920
_0215DE00: .word 0x01FF0000
_0215DE04: .word ovl08_215DCD0
	arm_func_end ovl08_215DD6C

	arm_func_start ovl08_215DE08
ovl08_215DE08: // 0x0215DE08
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215DE94 // =0x0217E800
	ldr r2, _0215DE98 // =0x0217A920
	ldr r3, [r1]
	ldr r1, _0215DE9C // =0x01FF0000
	ldr ip, [r3, #0x1c]
	ldrh r2, [r2, #0xe]
	ldr r3, [ip]
	mov r4, r0
	and r0, r3, r1
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [ip]
	and r0, r0, #0xff
	sub r1, r0, #0xc
	str r0, [sp, #4]
	str r1, [sp, #4]
	cmp r1, r2
	ble _0215DE68
	mov r0, #1
	bl ovl08_215D1F0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215DE68:
	mov r1, r2
	mov r0, #1
	bl ovl08_215D1F0
	mov r0, #2
	mov r1, #0xc0
	bl ovl08_215D1F0
	ldr r1, _0215DEA0 // =ovl08_215DD6C
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DE94: .word 0x0217E800
_0215DE98: .word 0x0217A920
_0215DE9C: .word 0x01FF0000
_0215DEA0: .word ovl08_215DD6C
	arm_func_end ovl08_215DE08

	arm_func_start ovl08_215DEA4
ovl08_215DEA4: // 0x0215DEA4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0215DF30 // =0x0217E800
	ldr r2, _0215DF34 // =0x0217A920
	ldr r3, [r1]
	ldr r1, _0215DF38 // =0x01FF0000
	ldr ip, [r3, #0x10]
	ldrh r2, [r2, #2]
	ldr r3, [ip]
	mov r4, r0
	and r0, r3, r1
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [ip]
	and r0, r0, #0xff
	sub r1, r0, #0xc
	str r0, [sp, #4]
	str r1, [sp, #4]
	cmp r1, r2
	ble _0215DF04
	mov r0, #0
	bl ovl08_215D1F0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215DF04:
	mov r1, r2
	mov r0, #0
	bl ovl08_215D1F0
	mov r0, #1
	mov r1, #0xc0
	bl ovl08_215D1F0
	ldr r1, _0215DF3C // =ovl08_215DE08
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DF30: .word 0x0217E800
_0215DF34: .word 0x0217A920
_0215DF38: .word 0x01FF0000
_0215DF3C: .word ovl08_215DE08
	arm_func_end ovl08_215DEA4

	arm_func_start ovl08_215DF40
ovl08_215DF40: // 0x0215DF40
	ldr r0, _0215DF58 // =0x0217E800
	ldr r0, [r0]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0215DF58: .word 0x0217E800
	arm_func_end ovl08_215DF40

	arm_func_start ovl08_215DF5C
ovl08_215DF5C: // 0x0215DF5C
	ldr r1, _0215DF6C // =0x0217E800
	ldr r1, [r1]
	strb r0, [r1, #0x68]
	bx lr
	.align 2, 0
_0215DF6C: .word 0x0217E800
	arm_func_end ovl08_215DF5C

	arm_func_start ovl08_215DF70
ovl08_215DF70: // 0x0215DF70
	ldr r1, _0215DF80 // =0x0217E800
	ldr r1, [r1]
	strb r0, [r1, #0x67]
	bx lr
	.align 2, 0
_0215DF80: .word 0x0217E800
	arm_func_end ovl08_215DF70

	arm_func_start ovl08_215DF84
ovl08_215DF84: // 0x0215DF84
	ldr r1, _0215DF94 // =0x0217E800
	ldr r1, [r1]
	strb r0, [r1, #0x66]
	bx lr
	.align 2, 0
_0215DF94: .word 0x0217E800
	arm_func_end ovl08_215DF84

	arm_func_start ovl08_215DF98
ovl08_215DF98: // 0x0215DF98
	ldr r0, _0215DFA8 // =0x0217E800
	ldr r0, [r0]
	ldrb r0, [r0, #0x60]
	bx lr
	.align 2, 0
_0215DFA8: .word 0x0217E800
	arm_func_end ovl08_215DF98

	arm_func_start ovl08_215DFAC
ovl08_215DFAC: // 0x0215DFAC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0215DFE0 // =0x0217E800
	ldr r0, [r0]
	ldr r0, [r0, #0x58]
	bl ovl08_2175204
	ldr r0, _0215DFE0 // =0x0217E800
	ldr r1, _0215DFE4 // =ovl08_215CF34
	ldr r0, [r0]
	ldr r0, [r0, #0x5c]
	bl ovl08_2177890
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215DFE0: .word 0x0217E800
_0215DFE4: .word ovl08_215CF34
	arm_func_end ovl08_215DFAC

	arm_func_start ovl08_215DFE8
ovl08_215DFE8: // 0x0215DFE8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x3c
	ldr r1, _0215E350 // =0x0217A8E0
	ldr r0, _0215E354 // =0x0217A8B8
	ldrh r2, [r1, #4]
	ldrh r4, [r1, #6]
	ldrh r6, [r1]
	ldrh r5, [r1, #2]
	ldrh r3, [r0]
	strh r2, [sp, #0x30]
	ldrh r2, [r0, #2]
	strh r4, [sp, #0x32]
	mov r0, #0x6c
	mov r1, #4
	strh r6, [sp, #0x2c]
	strh r5, [sp, #0x2e]
	strh r3, [sp, #0x30]
	strh r2, [sp, #0x32]
	bl ovl08_2176764
	ldr r8, _0215E358 // =0x0217E800
	mov r1, #0x1f
	str r0, [r8]
	strb r1, [r0, #0x60]
	ldr r0, [r8]
	mov r6, #0
	strb r6, [r0, #0x63]
	ldr r0, [r8]
	mov r1, #1
	strb r1, [r0, #0x66]
	ldr r0, [r8]
	strb r1, [r0, #0x67]
	ldr r0, [r8]
	strb r1, [r0, #0x68]
	mov r5, r6
	mov r4, #0x36
	ldr r7, _0215E35C // =0xC1FFFCFF
_0215E078:
	mov r0, r5
	mov r1, r4
	bl ovl08_2175570
	ldr r1, [r8]
	add r1, r1, r6, lsl #2
	str r0, [r1, #0x10]
	ldr r0, [r8]
	add r0, r0, r6, lsl #2
	ldr r1, [r0, #0x10]
	ldr r0, [r1]
	and r0, r0, r7
	orr r0, r0, #0x200
	str r0, [r1]
	ldr r0, [r8]
	add r0, r0, r6, lsl #2
	ldr r1, [r0, #0x10]
	add r6, r6, #1
	ldrh r0, [r1, #4]
	cmp r6, #0xa
	bic r0, r0, #0xc00
	orr r0, r0, #0xc00
	strh r0, [r1, #4]
	blt _0215E078
	ldr r6, _0215E360 // =0x0217A8A4
	mov r5, #0
	ldr r8, _0215E358 // =0x0217E800
	mov r4, r5
	ldr r7, _0215E35C // =0xC1FFFCFF
_0215E0E8:
	ldrb r1, [r6]
	mov r0, r4
	bl ovl08_2175570
	ldr r1, [r8]
	add r6, r6, #1
	add r1, r1, r5, lsl #2
	str r0, [r1, #0x38]
	ldr r0, [r8]
	add r0, r0, r5, lsl #2
	ldr r1, [r0, #0x38]
	ldr r0, [r1]
	and r0, r0, r7
	orr r0, r0, #0x200
	str r0, [r1]
	ldr r0, [r8]
	add r0, r0, r5, lsl #2
	ldr r1, [r0, #0x38]
	add r5, r5, #1
	ldrh r0, [r1, #4]
	cmp r5, #2
	bic r0, r0, #0xc00
	orr r0, r0, #0xc00
	strh r0, [r1, #4]
	blt _0215E0E8
	ldr r10, _0215E364 // =0x0217A8A8
	mov r9, #0
	ldr r4, _0215E358 // =0x0217E800
	mov r11, r9
	str r9, [sp, #0x1c]
	mov r8, #1
	mvn r7, #0
	mov r6, #0x200
	mov r5, #3
_0215E16C:
	ldrb r1, [r10]
	mov r0, r11
	mov r2, r8
	bl ovl08_2175528
	ldr r2, [r4]
	ldr r3, [sp, #0x1c]
	add r2, r2, r9, lsl #2
	str r0, [r2, #0x40]
	ldr r0, [r4]
	mov r1, r7
	add r0, r0, r9, lsl #2
	ldr r0, [r0, #0x40]
	mov r2, r6
	bl ovl08_2175138
	ldr r0, [r4]
	mov r1, r7
	add r0, r0, r9, lsl #2
	ldr r0, [r0, #0x40]
	mov r2, r5
	bl ovl08_2174F30
	add r9, r9, #1
	add r10, r10, #1
	cmp r9, #2
	blt _0215E16C
	ldr r1, _0215E368 // =0x0217A8BC
	mov r8, #0
	ldrh r0, [r1, #2]
	ldr r7, _0215E36C // =0x0217A904
	ldr r4, _0215E358 // =0x0217E800
	str r0, [sp, #0x14]
	ldrh r0, [r1]
	str r8, [sp, #0x10]
	strh r8, [sp, #0x3a]
	str r0, [sp, #0x18]
	add r11, sp, #0x38
	str r8, [sp, #0x28]
	str r8, [sp, #0x20]
	str r8, [sp, #0x24]
	mov r6, #2
	mov r5, #0x480
_0215E20C:
	add r0, sp, #0x34
	str r0, [sp]
	ldr r0, [sp, #0x20]
	ldr r2, [sp, #0x14]
	mov r1, r0
	str r1, [sp, #4]
	ldr r1, [sp, #0x18]
	mov r3, r0
	bl ovl08_21760B4
	ldr r1, [r4]
	ldr r10, [sp, #0x10]
	str r0, [r1, r8, lsl #2]
	ldr r0, [sp, #0x24]
	strh r0, [sp, #0x2c]
	mov r9, r0
_0215E248:
	mov r0, r10, lsl #1
	ldrh r1, [r7, r0]
	ldrh r0, [sp, #0x32]
	strh r1, [sp, #0x38]
	str r0, [sp]
	str r6, [sp, #4]
	str r5, [sp, #8]
	str r11, [sp, #0xc]
	ldr r0, [r4]
	ldrh r1, [sp, #0x2c]
	ldr r0, [r0, r8, lsl #2]
	ldrh r2, [sp, #0x2e]
	ldrh r3, [sp, #0x30]
	bl ovl08_2175C00
	add r9, r9, #1
	cmp r9, #3
	add r10, r10, #1
	ldrh r0, [sp, #0x2c]
	add r0, r0, #0x20
	strh r0, [sp, #0x2c]
	blt _0215E248
	ldr r0, [sp, #0x28]
	ldr r1, [sp, #0x34]
	mov r2, r0
	bl ovl08_2175290
	ldr r1, [sp, #0x10]
	ldr r2, [r4]
	add r1, r1, #3
	str r1, [sp, #0x10]
	add r1, r2, r8, lsl #2
	add r8, r8, #1
	str r0, [r1, #0x48]
	cmp r8, #4
	blt _0215E20C
	mov r0, #0
	mov r1, #0x44
	mov r2, #1
	bl ovl08_2175528
	ldr r3, _0215E358 // =0x0217E800
	mvn r1, #0
	ldr r4, [r3]
	mov r2, #0x200
	str r0, [r4, #0x58]
	ldr r0, [r3]
	mov r3, #0
	ldr r0, [r0, #0x58]
	bl ovl08_2175138
	ldr r0, _0215E358 // =0x0217E800
	mvn r1, #0
	ldr r0, [r0]
	mov r2, #2
	ldr r0, [r0, #0x58]
	bl ovl08_2174F30
	mov r0, #0
	ldr r1, _0215E370 // =ovl08_215DEA4
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r2, _0215E358 // =0x0217E800
	mov r1, #0xc0
	ldr r2, [r2]
	str r0, [r2, #0x5c]
	mov r0, #0
	bl ovl08_215D1F0
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215E350: .word 0x0217A8E0
_0215E354: .word 0x0217A8B8
_0215E358: .word 0x0217E800
_0215E35C: .word 0xC1FFFCFF
_0215E360: .word 0x0217A8A4
_0215E364: .word 0x0217A8A8
_0215E368: .word 0x0217A8BC
_0215E36C: .word 0x0217A904
_0215E370: .word ovl08_215DEA4
	arm_func_end ovl08_215DFE8

	arm_func_start ovl08_215E374
ovl08_215E374: // 0x0215E374
	ldr ip, _0215E37C // =ovl08_21766CC
	bx ip
	.align 2, 0
_0215E37C: .word ovl08_21766CC
	arm_func_end ovl08_215E374

	arm_func_start ovl08_215E380
ovl08_215E380: // 0x0215E380
	ldr ip, _0215E38C // =ovl08_2176788
	mov r1, #0x20
	bx ip
	.align 2, 0
_0215E38C: .word ovl08_2176788
	arm_func_end ovl08_215E380

	arm_func_start ovl08_215E390
ovl08_215E390: // 0x0215E390
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0215E3F8 // =0x0217E808
	ldr r0, [r0]
	blx ovl08_2154E1C
	cmp r0, #0
	ldreq r1, _0215E3FC // =0x0217E804
	moveq r0, #1
	streqb r0, [r1]
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _0215E3F8 // =0x0217E808
	ldr r0, [r0]
	ldrb r0, [r0, #0x116]
	cmp r0, #1
	beq _0215E3E0
	add r0, r0, #0xfd
	and r0, r0, #0xff
	cmp r0, #2
	bhi _0215E3EC
_0215E3E0:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_0215E3EC:
	mov r0, #2
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215E3F8: .word 0x0217E808
_0215E3FC: .word 0x0217E804
	arm_func_end ovl08_215E390

	arm_func_start ovl08_215E400
ovl08_215E400: // 0x0215E400
	stmdb sp!, {r4, lr}
	mov r4, r0
	blx ovl08_2155320
	cmp r4, #0
	beq _0215E444
	ldr r0, _0215E450 // =0x0217E808
	ldr r1, [r0]
	ldrb r0, [r1, #0x116]
	cmp r0, #0
	bne _0215E444
	ldr r0, _0215E454 // =0x0217E804
	ldrb r0, [r0]
	cmp r0, #1
	bne _0215E444
	ldr r0, _0215E458 // =0x00000117
	add r0, r1, r0
	bl ovl08_216EFF4
_0215E444:
	ldr r0, _0215E450 // =0x0217E808
	bl ovl08_2176714
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E450: .word 0x0217E808
_0215E454: .word 0x0217E804
_0215E458: .word 0x00000117
	arm_func_end ovl08_215E400

	arm_func_start ovl08_215E45C
ovl08_215E45C: // 0x0215E45C
	stmdb sp!, {lr}
	sub sp, sp, #0x104
	mov r0, #0x26c
	mov r1, #4
	bl ovl08_2176764
	ldr r1, _0215E558 // =0x0217E808
	ldr r3, _0215E55C // =0x0217E804
	str r0, [r1]
	mov r0, #0
	add r1, sp, #0
	mov r2, #0x104
	strb r0, [r3]
	bl MIi_CpuClear16
	mov r3, #0x50
	mov r2, #0xc
	ldr r0, _0215E560 // =aNintendoDs_0
	add r1, sp, #4
	strb r3, [sp]
	strh r2, [sp, #2]
	bl MI_CpuCopy8
	ldr r0, _0215E558 // =0x0217E808
	mov r2, #3
	ldr r1, [r0]
	add ip, sp, #0
	strh r2, [r1]
	ldr lr, [r0]
	mov r2, #0x41
	add r3, lr, #2
_0215E4CC:
	ldrh r1, [ip], #2
	ldrh r0, [ip], #2
	subs r2, r2, #1
	strh r1, [r3], #2
	strh r0, [r3], #2
	bne _0215E4CC
	ldr r1, _0215E558 // =0x0217E808
	add r0, lr, #0x100
	mov r3, #1
	strh r3, [r0, #6]
	ldr r0, [r1]
	mvn r2, #0
	add r0, r0, #0x100
	strh r2, [r0, #8]
	ldr r0, [r1]
	add r0, r0, #0x100
	strh r3, [r0, #0xa]
	ldr r0, [r1]
	add r0, r0, #0x100
	strh r2, [r0, #0xc]
	ldr r0, [r1]
	add r0, r0, #0x100
	strh r2, [r0, #0xe]
	ldr r0, [r1]
	add r0, r0, #0x110
	bl OS_GetMacAddress
	ldr r0, _0215E564 // =ovl08_215E380
	ldr r1, _0215E568 // =ovl08_215E374
	blx ovl08_21553DC
	cmp r0, #0
	addeq sp, sp, #0x104
	ldmeqia sp!, {pc}
	bl OS_Terminate
	add sp, sp, #0x104
	ldmia sp!, {pc}
	.align 2, 0
_0215E558: .word 0x0217E808
_0215E55C: .word 0x0217E804
_0215E560: .word aNintendoDs_0
_0215E564: .word ovl08_215E380
_0215E568: .word ovl08_215E374
	arm_func_end ovl08_215E45C

	arm_func_start ovl08_215E56C
ovl08_215E56C: // 0x0215E56C
	ldr r0, _0215E5AC // =0x0217E80C
	ldrb r1, [r0]
	cmp r1, #6
	moveq r0, #0x38
	bxeq lr
	cmp r1, #1
	bne _0215E5A0
	ldr r0, _0215E5B0 // =0x0217E818
	ldr r0, [r0]
	mov r0, r0, lsr #4
	ands r0, r0, #2
	moveq r0, #0x37
	bxeq lr
_0215E5A0:
	add r0, r1, #0x31
	and r0, r0, #0xff
	bx lr
	.align 2, 0
_0215E5AC: .word 0x0217E80C
_0215E5B0: .word 0x0217E818
	arm_func_end ovl08_215E56C

	arm_func_start ovl08_215E5B4
ovl08_215E5B4: // 0x0215E5B4
	ldr r0, _0215E5C4 // =0x0217E810
	mov r1, #1
	strb r1, [r0]
	bx lr
	.align 2, 0
_0215E5C4: .word 0x0217E810
	arm_func_end ovl08_215E5B4

	arm_func_start ovl08_215E5C8
ovl08_215E5C8: // 0x0215E5C8
	ldr r1, _0215E5E4 // =0x0217E818
	ldr r1, [r1]
	mov r1, r1, lsr #4
	ands r0, r1, r0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0215E5E4: .word 0x0217E818
	arm_func_end ovl08_215E5C8

	arm_func_start ovl08_215E5E8
ovl08_215E5E8: // 0x0215E5E8
	ldr r0, _0215E5FC // =0x0217E818
	ldr r0, [r0]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	bx lr
	.align 2, 0
_0215E5FC: .word 0x0217E818
	arm_func_end ovl08_215E5E8

	arm_func_start ovl08_215E600
ovl08_215E600: // 0x0215E600
	ldr r0, _0215E60C // =0x0217E80C
	ldrb r0, [r0]
	bx lr
	.align 2, 0
_0215E60C: .word 0x0217E80C
	arm_func_end ovl08_215E600

	arm_func_start ovl08_215E610
ovl08_215E610: // 0x0215E610
	cmp r0, #0
	ldrne r2, _0215E634 // =0x0217E820
	ldrne r2, [r2, #8]
	strne r2, [r0]
	cmp r1, #0
	ldrne r0, _0215E634 // =0x0217E820
	ldrne r0, [r0, #0xc]
	strne r0, [r1]
	bx lr
	.align 2, 0
_0215E634: .word 0x0217E820
	arm_func_end ovl08_215E610

	arm_func_start ovl08_215E638
ovl08_215E638: // 0x0215E638
	ldr r2, _0215E648 // =0x0217E820
	str r0, [r2, #8]
	str r1, [r2, #0xc]
	bx lr
	.align 2, 0
_0215E648: .word 0x0217E820
	arm_func_end ovl08_215E638

	arm_func_start ovl08_215E64C
ovl08_215E64C: // 0x0215E64C
	cmp r0, #0
	ldrne r2, _0215E670 // =0x0217E820
	ldrne r2, [r2]
	strne r2, [r0]
	cmp r1, #0
	ldrne r0, _0215E670 // =0x0217E820
	ldrne r0, [r0, #4]
	strne r0, [r1]
	bx lr
	.align 2, 0
_0215E670: .word 0x0217E820
	arm_func_end ovl08_215E64C

	arm_func_start ovl08_215E674
ovl08_215E674: // 0x0215E674
	ldr r2, _0215E684 // =0x0217E820
	str r0, [r2]
	str r1, [r2, #4]
	bx lr
	.align 2, 0
_0215E684: .word 0x0217E820
	arm_func_end ovl08_215E674

	arm_func_start DWCi_ChangeScene
DWCi_ChangeScene: // 0x0215E688
	ldr r1, _0215E694 // =0x0217E81C
	str r0, [r1]
	bx lr
	.align 2, 0
_0215E694: .word 0x0217E81C
	arm_func_end DWCi_ChangeScene

	arm_func_start DWCUtility_procEnd
DWCUtility_procEnd: // 0x0215E698
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl GX_DispOff
	ldr r1, _0215E6EC // =0x04001000
	ldr r0, [r1]
	bic r0, r0, #0x10000
	str r0, [r1]
	bl ovl08_2177530
	bl ovl08_2176E44
	bl ovl08_2176F24
	bl ovl08_216F958
	bl ovl08_2175404
	bl ovl08_2177164
	bl ovl08_2176190
	bl ovl08_2175ABC
	bl ovl08_2174CBC
	bl ovl08_2177A08
	bl ovl08_21767D4
	bl ovl08_2177608
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215E6EC: .word 0x04001000
	arm_func_end DWCUtility_procEnd

	arm_func_start DWCUtility_initGraph
DWCUtility_initGraph: // 0x0215E6F0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r0, #0
	bl GX_VBlankIntr
	mov r0, #1
	bl GX_SetBankForBG
	mov r0, #2
	bl GX_SetBankForOBJ
	mov r1, #0
	mov r2, r1
	mov r0, #1
	bl GX_SetGraphicsMode
	mov r3, #0x4000000
	ldr r1, [r3]
	ldr r0, _0215E9A8 // =0x0400006C
	bic r1, r1, #0x1f00
	str r1, [r3]
	ldr r2, [r3]
	mov r1, #0
	bic r2, r2, #0xe000
	str r2, [r3]
	bl GXx_SetMasterBrightness_
	mov r3, #0x4000000
	ldr r2, [r3]
	ldr r0, _0215E9AC // =0xFFCFFFEF
	ldr r1, _0215E9B0 // =0x00200010
	and r0, r2, r0
	orr r0, r0, r1
	str r0, [r3]
	ldr r3, _0215E9B4 // =0x04000008
	ldr r2, _0215E9B8 // =0x0400000A
	ldrh r0, [r3]
	ldr r1, _0215E9BC // =0x0400000C
	ldr r5, _0215E9C0 // =0x0400000E
	bic r0, r0, #0x40
	strh r0, [r3]
	ldrh r0, [r2]
	mov ip, #0
	ldr r4, _0215E9C4 // =0x04000010
	bic r0, r0, #0x40
	strh r0, [r2]
	ldrh r0, [r1]
	ldr r3, _0215E9C8 // =0x04000014
	ldr r2, _0215E9CC // =0x04000018
	bic r0, r0, #0x40
	strh r0, [r1]
	ldrh lr, [r5]
	ldr r1, _0215E9D0 // =0x0400001C
	ldr r0, _0215E9D4 // =0x04000050
	bic lr, lr, #0x40
	strh lr, [r5]
	str ip, [r4]
	str ip, [r3]
	str ip, [r2]
	str ip, [r1]
	mov r1, #0x3f
	mov r2, #0x10
	bl G2x_SetBlendBrightness_
	mov r0, #0x80
	bl GX_SetBankForSubBG
	mov r0, #0x100
	bl GX_SetBankForSubOBJ
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r1, _0215E9D8 // =0x04001000
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	str r0, [r1]
	ldr r0, [r1]
	bic r0, r0, #0xe000
	str r0, [r1]
	ldr r0, _0215E9DC // =0x0400106C
	mov r1, #0
	bl GXx_SetMasterBrightness_
	ldr r3, _0215E9D8 // =0x04001000
	ldr r0, _0215E9AC // =0xFFCFFFEF
	ldr r1, [r3]
	ldr r2, _0215E9E0 // =0x04001008
	and r0, r1, r0
	orr r0, r0, #0x10
	str r0, [r3]
	ldrh r0, [r2]
	ldr r1, _0215E9E4 // =0x0400100A
	ldr r3, _0215E9E8 // =0x0400100C
	bic r0, r0, #0x40
	strh r0, [r2]
	ldrh r0, [r1]
	ldr r4, _0215E9EC // =0x0400100E
	ldr r2, _0215E9F0 // =0x04001010
	bic r0, r0, #0x40
	strh r0, [r1]
	ldrh r0, [r3]
	mov ip, #0
	ldr r1, _0215E9F4 // =0x04001014
	bic r0, r0, #0x40
	strh r0, [r3]
	ldrh lr, [r4]
	ldr r0, _0215E9F8 // =0x04001018
	ldr r3, _0215E9FC // =0x0400101C
	bic lr, lr, #0x40
	strh lr, [r4]
	str ip, [r2]
	str ip, [r1]
	str ip, [r0]
	ldr r0, _0215EA00 // =0x04001050
	mov r1, #0x3f
	mov r2, #0x10
	str ip, [r3]
	bl G2x_SetBlendBrightness_
	ldr r3, _0215E9B4 // =0x04000008
	ldr r2, _0215E9B8 // =0x0400000A
	ldrh r1, [r3]
	ldr r0, _0215EA04 // =0x00000D08
	ldr lr, _0215E9BC // =0x0400000C
	and r1, r1, #0x43
	orr r1, r1, #0xc00
	strh r1, [r3]
	ldrh r1, [r2]
	mov ip, r5
	ldr r3, _0215E9E0 // =0x04001008
	and r1, r1, #0x43
	orr r0, r1, r0
	strh r0, [r2]
	ldrh r0, [lr]
	ldr r2, _0215E9E4 // =0x0400100A
	ldr r1, _0215E9E8 // =0x0400100C
	and r0, r0, #0x43
	orr r0, r0, #0xe10
	strh r0, [lr]
	ldrh r0, [ip]
	and r0, r0, #0x43
	orr r0, r0, #0xf10
	strh r0, [ip]
	ldrh r0, [r3]
	and r0, r0, #0x43
	orr r0, r0, #0xc00
	strh r0, [r3]
	ldrh r0, [r2]
	and r0, r0, #0x43
	orr r0, r0, #0xd00
	strh r0, [r2]
	ldrh r0, [r1]
	and r0, r0, #0x43
	orr r0, r0, #0xe00
	strh r0, [r1]
	mov r3, r4
	ldrh r0, [r3]
	mov r2, #0x4000000
	ldr r1, _0215EA08 // =0x04000304
	and r0, r0, #0x43
	orr r0, r0, #0xf00
	strh r0, [r3]
	ldr r0, [r2]
	bic r0, r0, #0x38000000
	str r0, [r2]
	ldr r0, [r2]
	bic r0, r0, #0x7000000
	str r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #0x8000
	strh r0, [r1]
	bl ovl08_21761E0
	bl ovl08_21771E4
	bl ovl08_2177444
	bl ovl08_2175454
	bl GX_DispOn
	ldr r2, _0215E9D8 // =0x04001000
	mov r0, #1
	ldr r1, [r2]
	orr r1, r1, #0x10000
	str r1, [r2]
	bl GX_VBlankIntr
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215E9A8: .word 0x0400006C
_0215E9AC: .word 0xFFCFFFEF
_0215E9B0: .word 0x00200010
_0215E9B4: .word 0x04000008
_0215E9B8: .word 0x0400000A
_0215E9BC: .word 0x0400000C
_0215E9C0: .word 0x0400000E
_0215E9C4: .word 0x04000010
_0215E9C8: .word 0x04000014
_0215E9CC: .word 0x04000018
_0215E9D0: .word 0x0400001C
_0215E9D4: .word 0x04000050
_0215E9D8: .word 0x04001000
_0215E9DC: .word 0x0400106C
_0215E9E0: .word 0x04001008
_0215E9E4: .word 0x0400100A
_0215E9E8: .word 0x0400100C
_0215E9EC: .word 0x0400100E
_0215E9F0: .word 0x04001010
_0215E9F4: .word 0x04001014
_0215E9F8: .word 0x04001018
_0215E9FC: .word 0x0400101C
_0215EA00: .word 0x04001050
_0215EA04: .word 0x00000D08
_0215EA08: .word 0x04000304
	arm_func_end DWCUtility_initGraph

	arm_func_start DWCUtility_initGame
DWCUtility_initGame: // 0x0215EA0C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _0215EAD0 // =0x04000208
	mov r0, #0
	ldrh r1, [r2]
	strh r0, [r2]
	bl GX_DispOff
	ldr r1, _0215EAD4 // =0x04001000
	ldr r0, [r1]
	bic r0, r0, #0x10000
	str r0, [r1]
	bl OS_IsTickAvailable
	cmp r0, #0
	bne _0215EA48
	bl OS_Terminate
_0215EA48:
	bl OS_IsAlarmAvailable
	cmp r0, #0
	bne _0215EA58
	bl OS_Terminate
_0215EA58:
	mov r0, #0
	bl GX_VBlankIntr
	bl FX_Init
	mvn r0, #0
	bl FS_Init
	bl TP_Init
	bl RTC_Init
	bl GX_DispOff
	ldr r1, _0215EAD4 // =0x04001000
	ldr r0, [r1]
	bic r0, r0, #0x10000
	str r0, [r1]
	bl ovl08_2177744
	ldr r0, _0215EAD8 // =0x0217E814
	ldr r0, [r0]
	bl ovl08_2176800
	bl ovl08_2176F6C
	bl ovl08_2177A54
	bl ovl08_2174D48
	bl ovl08_2176E78
	bl ovl08_2175AD0
	mov r0, #0x700
	mov r1, #0x20
	bl ovl08_2176788
	str r0, [sp]
	bl DWC_BM_Init
	add r0, sp, #0
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215EAD0: .word 0x04000208
_0215EAD4: .word 0x04001000
_0215EAD8: .word 0x0217E814
	arm_func_end DWCUtility_initGame

	arm_func_start DWCUtility_checkParam
DWCUtility_checkParam: // 0x0215EADC
	ldr r3, _0215EB78 // =0x0217E80C
	ldr r2, _0215EB7C // =0x0217E818
	strb r0, [r3]
	str r1, [r2]
	cmp r0, #0
	blt _0215EAFC
	cmp r0, #6
	ble _0215EB04
_0215EAFC:
	mov r0, #0
	bx lr
_0215EB04:
	cmp r0, #1
	bne _0215EB1C
	mov r1, r1, lsr #4
	bics r1, r1, #2
	movne r0, #0
	bxne lr
_0215EB1C:
	ldr r1, _0215EB7C // =0x0217E818
	ldr r1, [r1]
	mov r2, r1, lsl #0x1c
	mov r2, r2, lsr #0x1c
	cmp r2, #1
	movhi r0, #0
	bxhi lr
	cmp r0, #0
	beq _0215EB50
	mov r1, r1, lsr #4
	ands r1, r1, #1
	movne r0, #0
	bxne lr
_0215EB50:
	cmp r0, #0
	bne _0215EB70
	ldr r0, _0215EB7C // =0x0217E818
	ldr r0, [r0]
	mov r0, r0, lsr #4
	ands r0, r0, #1
	moveq r0, #0
	bxeq lr
_0215EB70:
	mov r0, #1
	bx lr
	.align 2, 0
_0215EB78: .word 0x0217E80C
_0215EB7C: .word 0x0217E818
	arm_func_end DWCUtility_checkParam

	arm_func_start DWC_StartUtility
DWC_StartUtility: // 0x0215EB80
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, _0215EC08 // =0x0217E814
	str r0, [r3]
	mov r0, r1
	mov r1, r2
	bl DWCUtility_checkParam
	cmp r0, #0
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, _0215EC0C // =0x0217E810
	mov r1, #0
	strb r1, [r0]
	bl DWCUtility_initGame
	bl DWCUtility_initGraph
	bl DWCi_SNDlInit
	ldr r0, _0215EC10 // =DWCi_SceneInit
	bl DWCi_ChangeScene
	ldr r5, _0215EC14 // =0x0217E81C
	ldr r4, _0215EC0C // =0x0217E810
	mov r6, #0
_0215EBD0:
	bl DWCi_IPTlRead
	ldr r0, [r5]
	blx r0
	mov r0, r6
	bl DWCi_TSKlAct
	bl DWCi_IPTlCheckFold
	bl DWCi_SetLedWireless
	bl OS_WaitVBlankIntr
	ldrb r0, [r4]
	cmp r0, #0
	beq _0215EBD0
	bl DWCUtility_procEnd
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215EC08: .word 0x0217E814
_0215EC0C: .word 0x0217E810
_0215EC10: .word DWCi_SceneInit
_0215EC14: .word 0x0217E81C
	arm_func_end DWC_StartUtility

	arm_func_start ovl08_215EC18
ovl08_215EC18: // 0x0215EC18
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr ip, _0215EC50 // =0x0000FFFF
	ldr lr, [r0]
	and r1, r1, ip
	ldr ip, [r0, #4]
	ldr r0, [lr, r1, lsl #2]
	cmp r2, #0
	add r0, ip, r0
	addge r3, r3, #0x30
	movge r1, r2, lsl #1
	strgeh r3, [r0, r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215EC50: .word 0x0000FFFF
	arm_func_end ovl08_215EC18

	arm_func_start ovl08_215EC54
ovl08_215EC54: // 0x0215EC54
	ldr r2, _0215EC70 // =0x0000FFFF
	ldr r3, [r0]
	and r1, r1, r2
	ldr r2, [r0, #4]
	ldr r0, [r3, r1, lsl #2]
	add r0, r2, r0
	bx lr
	.align 2, 0
_0215EC70: .word 0x0000FFFF
	arm_func_end ovl08_215EC54

	arm_func_start ovl08_215EC74
ovl08_215EC74: // 0x0215EC74
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #8]
	bl ovl08_2174AB8
	ldr r0, _0215EC9C // =0x0217E830
	mov r1, r4
	ldr r0, [r0]
	ldr r0, [r0, #0x60]
	bl ovl08_21756E0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215EC9C: .word 0x0217E830
	arm_func_end ovl08_215EC74

	arm_func_start ovl08_215ECA0
ovl08_215ECA0: // 0x0215ECA0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _0215ED00 // =0x0217E830
	mov r5, r0
	ldr r0, [r1]
	ldr r0, [r0, #0x60]
	bl ovl08_2175688
	mov r4, r0
	add r1, sp, #0
	mov r0, r5
	mov r2, #4
	bl ovl08_2174AF4
	str r0, [r4, #8]
	ldr r1, [r4, #8]
	mov r0, r4
	add r2, r1, #0x20
	add r1, r2, #0x10
	str r1, [r4]
	ldr r1, [r2, #4]
	add r1, r2, r1
	add r1, r1, #8
	str r1, [r4, #4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215ED00: .word 0x0217E830
	arm_func_end ovl08_215ECA0

	arm_func_start ovl08_215ED04
ovl08_215ED04: // 0x0215ED04
	ldr ip, _0215ED10 // =ovl08_2176714
	ldr r0, _0215ED14 // =0x0217E830
	bx ip
	.align 2, 0
_0215ED10: .word ovl08_2176714
_0215ED14: .word 0x0217E830
	arm_func_end ovl08_215ED04

	arm_func_start ovl08_215ED18
ovl08_215ED18: // 0x0215ED18
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0x64
	mov r1, #4
	bl ovl08_2176788
	mov r1, r0
	ldr r3, _0215ED58 // =0x0217E830
	mov r0, #8
	mov r2, #0xc
	str r1, [r3]
	bl ovl08_2175764
	ldr r1, _0215ED58 // =0x0217E830
	ldr r1, [r1]
	str r0, [r1, #0x60]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215ED58: .word 0x0217E830
	arm_func_end ovl08_215ED18

	arm_func_start ovl08_215ED5C
ovl08_215ED5C: // 0x0215ED5C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl ovl08_21742FC
	ldr r0, _0215F000 // =0x0217E834
	ldr r0, [r0]
	add r0, r0, #0x1e000
	ldrb r1, [r0, #0x2a0]
	cmp r1, #0
	beq _0215EDB0
	ldrb r1, [r0, #0x2a1]
	cmp r1, #0
	bne _0215EDB0
	ldr r1, [r0, #0x298]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215EDB0:
	add r0, sp, #0
	add r1, sp, #1
	bl ovl08_21742B4
	ldrb r0, [sp]
	cmp r0, #0x1a
	bgt _0215EE48
	cmp r0, #0x1a
	bge _0215EF5C
	cmp r0, #0x14
	bgt _0215EE38
	cmp r0, #0
	addge pc, pc, r0, lsl #2
	b _0215EFF8
_0215EDE4: // jump table
	b _0215EFF8 // case 0
	b _0215EFF8 // case 1
	b _0215EFF8 // case 2
	b _0215EFF8 // case 3
	b _0215EFF8 // case 4
	b _0215EE70 // case 5
	b _0215EFF8 // case 6
	b _0215EFF8 // case 7
	b _0215EFF8 // case 8
	b _0215EFF8 // case 9
	b _0215EFF8 // case 10
	b _0215EFF8 // case 11
	b _0215EFA0 // case 12
	b _0215EED4 // case 13
	b _0215EFF8 // case 14
	b _0215EFF8 // case 15
	b _0215EFF8 // case 16
	b _0215EFF8 // case 17
	b _0215EFF8 // case 18
	b _0215EFF8 // case 19
	b _0215EF18 // case 20
_0215EE38:
	cmp r0, #0x17
	beq _0215EF18
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215EE48:
	cmp r0, #0x1d
	bgt _0215EE60
	cmp r0, #0x1d
	beq _0215EF5C
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215EE60:
	cmp r0, #0x22
	beq _0215EFE4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215EE70:
	ldrb r0, [sp, #1]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r1, _0215F000 // =0x0217E834
	ldr r0, _0215F004 // =0x0001E280
	ldr r1, [r1]
	add r4, r1, r0
	bl ovl08_21742A4
	mov r1, r4
	mov r2, #0x16
	bl MIi_CpuCopy16
	ldr r0, _0215F000 // =0x0217E834
	ldr r0, [r0]
	add r0, r0, #0x1e000
	ldr r1, [r0, #0x298]
	cmp r1, #0
	moveq r1, #1
	streqb r1, [r0, #0x2a0]
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215EED4:
	ldrb r0, [sp, #1]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, _0215F000 // =0x0217E834
	ldr r0, [r0]
	add r0, r0, #0x1e000
	ldr r1, [r0, #0x298]
	cmp r1, #0
	moveq r1, #1
	streqb r1, [r0, #0x2a0]
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #1
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215EF18:
	ldrb r0, [sp, #1]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, _0215F000 // =0x0217E834
	ldr r0, [r0]
	add r0, r0, #0x1e000
	ldr r1, [r0, #0x298]
	cmp r1, #0
	moveq r1, #1
	streqb r1, [r0, #0x2a0]
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #3
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215EF5C:
	ldrb r0, [sp, #1]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, _0215F000 // =0x0217E834
	ldr r0, [r0]
	add r0, r0, #0x1e000
	ldr r1, [r0, #0x298]
	cmp r1, #0
	moveq r1, #1
	streqb r1, [r0, #0x2a0]
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #4
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215EFA0:
	ldrb r0, [sp, #1]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, _0215F000 // =0x0217E834
	ldr r0, [r0]
	add r0, r0, #0x1e000
	ldr r1, [r0, #0x298]
	cmp r1, #0
	moveq r1, #1
	streqb r1, [r0, #0x2a0]
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #2
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215EFE4:
	mov r1, r4
	mov r0, #0
	bl ovl08_2177870
	ldr r0, _0215F000 // =0x0217E834
	bl ovl08_2176714
_0215EFF8:
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215F000: .word 0x0217E834
_0215F004: .word 0x0001E280
	arm_func_end ovl08_215ED5C

	arm_func_start ovl08_215F008
ovl08_215F008: // 0x0215F008
	ldr r1, _0215F01C // =0x0217E834
	ldr r0, _0215F020 // =0x0001E280
	ldr r1, [r1]
	add r0, r1, r0
	bx lr
	.align 2, 0
_0215F01C: .word 0x0217E834
_0215F020: .word 0x0001E280
	arm_func_end ovl08_215F008

	arm_func_start ovl08_215F024
ovl08_215F024: // 0x0215F024
	ldr ip, _0215F02C // =ovl08_2174718
	bx ip
	.align 2, 0
_0215F02C: .word ovl08_2174718
	arm_func_end ovl08_215F024

	arm_func_start ovl08_215F030
ovl08_215F030: // 0x0215F030
	ldr r1, _0215F044 // =0x0217E834
	ldr r1, [r1]
	add r1, r1, #0x1e000
	str r0, [r1, #0x298]
	bx lr
	.align 2, 0
_0215F044: .word 0x0217E834
	arm_func_end ovl08_215F030

	arm_func_start ovl08_215F048
ovl08_215F048: // 0x0215F048
	ldr r0, _0215F060 // =0x0217E834
	ldr r0, [r0]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_0215F060: .word 0x0217E834
	arm_func_end ovl08_215F048

	arm_func_start ovl08_215F064
ovl08_215F064: // 0x0215F064
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl08_2174840
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _0215F09C // =0x0217E834
	mov r1, r4
	ldr r0, [r0]
	mov r3, #1
	add r2, r0, #0x1e000
	mov r0, #0
	strb r3, [r2, #0x2a1]
	bl ovl08_2177870
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215F09C: .word 0x0217E834
	arm_func_end ovl08_215F064

	arm_func_start ovl08_215F0A0
ovl08_215F0A0: // 0x0215F0A0
	ldr ip, _0215F0B8 // =ovl08_2177924
	mov r0, #0
	ldr r1, _0215F0BC // =ovl08_215F064
	mov r2, r0
	mov r3, #0x78
	bx ip
	.align 2, 0
_0215F0B8: .word ovl08_2177924
_0215F0BC: .word ovl08_215F064
	arm_func_end ovl08_215F0A0

	arm_func_start ovl08_215F0C0
ovl08_215F0C0: // 0x0215F0C0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	mov r4, r0
	ldr r0, _0215F198 // =0x0001E2A4
	mov r1, #0x20
	bl ovl08_2176788
	ldr r2, _0215F19C // =0x0217E834
	add r1, r0, #0x1e000
	str r0, [r2]
	str r4, [r1, #0x298]
	ldr r0, [r2]
	mov r4, #0
	add r0, r0, #0x1e000
	strb r4, [r0, #0x2a0]
	ldr r0, [r2]
	ldr lr, _0215F1A0 // =0x0217B62C
	add r0, r0, #0x1e000
	strb r4, [r0, #0x2a1]
	add ip, sp, #0
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r0, _0215F1A4 // =0x0217E83C
	mov r1, r4
	ldr r0, [r0]
	bl ovl08_215EC54
	ldr r1, _0215F1A4 // =0x0217E83C
	str r0, [sp, #4]
	ldr r0, [r1]
	mov r1, #1
	bl ovl08_215EC54
	str r0, [sp, #8]
	bl ovl08_215E56C
	strb r0, [sp, #0x18]
	ldr r0, _0215F19C // =0x0217E834
	add r1, sp, #0
	ldr r0, [r0]
	bl ovl08_2174958
	bl ovl08_2174758
	cmp r0, #0
	bne _0215F16C
	bl OS_Terminate
_0215F16C:
	mov r0, #0
	ldr r1, _0215F1A8 // =ovl08_215ED5C
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _0215F19C // =0x0217E834
	ldr r1, [r1]
	add r1, r1, #0x1e000
	str r0, [r1, #0x29c]
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215F198: .word 0x0001E2A4
_0215F19C: .word 0x0217E834
_0215F1A0: .word 0x0217B62C
_0215F1A4: .word 0x0217E83C
_0215F1A8: .word ovl08_215ED5C
	arm_func_end ovl08_215F0C0

	arm_func_start ovl08_215F1AC
ovl08_215F1AC: // 0x0215F1AC
	ldr ip, _0215F1B4 // =ovl08_21766CC
	bx ip
	.align 2, 0
_0215F1B4: .word ovl08_21766CC
	arm_func_end ovl08_215F1AC

	arm_func_start ovl08_215F1B8
ovl08_215F1B8: // 0x0215F1B8
	ldr ip, _0215F1C4 // =ovl08_2176788
	mov r1, #0x20
	bx ip
	.align 2, 0
_0215F1C4: .word ovl08_2176788
	arm_func_end ovl08_215F1B8

	arm_func_start ovl08_215F1C8
ovl08_215F1C8: // 0x0215F1C8
	ldr r3, _0215F1DC // =0x0217E838
	ldmia r0, {r0, r1, r2}
	ldr r3, [r3]
	stmia r3, {r0, r1, r2}
	bx lr
	.align 2, 0
_0215F1DC: .word 0x0217E838
	arm_func_end ovl08_215F1C8

	arm_func_start ovl08_215F1E0
ovl08_215F1E0: // 0x0215F1E0
	stmdb sp!, {lr}
	sub sp, sp, #0xec
	add r0, sp, #0
	blx ovl08_2155E18
	cmp r0, #1
	beq _0215F1FC
	bl OS_Terminate
_0215F1FC:
	add r0, sp, #0
	bl ovl08_216F10C
	add sp, sp, #0xec
	ldmia sp!, {pc}
	arm_func_end ovl08_215F1E0

	arm_func_start ovl08_215F20C
ovl08_215F20C: // 0x0215F20C
	stmdb sp!, {lr}
	sub sp, sp, #0xec
	ldr r1, _0215F2C4 // =0x0217E838
	ldr r1, [r1]
	ldr r1, [r1]
	cmp r1, #7
	addls pc, pc, r1, lsl #2
	b _0215F2BC
_0215F22C: // jump table
	b _0215F24C // case 0
	b _0215F24C // case 1
	b _0215F258 // case 2
	b _0215F24C // case 3
	b _0215F264 // case 4
	b _0215F24C // case 5
	b _0215F270 // case 6
	b _0215F2B8 // case 7
_0215F24C:
	add sp, sp, #0xec
	mov r0, #0
	ldmia sp!, {pc}
_0215F258:
	add sp, sp, #0xec
	mov r0, #1
	ldmia sp!, {pc}
_0215F264:
	add sp, sp, #0xec
	mov r0, #2
	ldmia sp!, {pc}
_0215F270:
	add r0, sp, #0
	blx ovl08_2155E18
	cmp r0, #1
	beq _0215F284
	bl OS_Terminate
_0215F284:
	ldr r0, [sp, #0x20]
	cmp r0, #0
	blt _0215F2AC
	cmp r0, #3
	bgt _0215F2AC
	ldr r0, [sp, #0x24]
	cmp r0, #1
	addeq sp, sp, #0xec
	moveq r0, #3
	ldmeqia sp!, {pc}
_0215F2AC:
	add sp, sp, #0xec
	mov r0, #5
	ldmia sp!, {pc}
_0215F2B8:
	mov r0, #4
_0215F2BC:
	add sp, sp, #0xec
	ldmia sp!, {pc}
	.align 2, 0
_0215F2C4: .word 0x0217E838
	arm_func_end ovl08_215F20C

	arm_func_start ovl08_215F2C8
ovl08_215F2C8: // 0x0215F2C8
	stmdb sp!, {lr}
	sub sp, sp, #4
	blx ovl08_2155E70
	cmp r0, #1
	beq _0215F2E0
	bl OS_Terminate
_0215F2E0:
	ldr r0, _0215F2F0 // =0x0217E838
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215F2F0: .word 0x0217E838
	arm_func_end ovl08_215F2C8

	arm_func_start ovl08_215F2F4
ovl08_215F2F4: // 0x0215F2F4
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov r0, #0xc
	mvn r1, #3
	bl ovl08_2176764
	ldr r1, _0215F350 // =0x0217E838
	ldr ip, _0215F354 // =ovl08_215F1AC
	str r0, [r1]
	ldr r2, _0215F358 // =ovl08_215F1C8
	ldr r3, _0215F35C // =ovl08_215F1B8
	str ip, [sp]
	mov ip, #0x800
	mov r0, #0xf
	mov r1, #0x40
	str ip, [sp, #4]
	blx ovl08_2155F28
	cmp r0, #1
	beq _0215F340
	bl OS_Terminate
_0215F340:
	mov r0, #0xa
	bl OS_Sleep
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0215F350: .word 0x0217E838
_0215F354: .word ovl08_215F1AC
_0215F358: .word ovl08_215F1C8
_0215F35C: .word ovl08_215F1B8
	arm_func_end ovl08_215F2F4

	arm_func_start ovl08_215F360
ovl08_215F360: // 0x0215F360
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	mov r1, r0
	bl ovl08_2177800
	mov r0, #1
	mov r1, #0
	bl ovl08_2177800
	mov r0, #1
	bl ovl08_2175630
	mov r0, #0
	bl ovl08_2175630
	bl ovl08_215ABAC
	bl ovl08_215AA88
	ldr r0, _0215F3E0 // =0x0217E83C
	ldr r0, [r0]
	bl ovl08_215EC74
	bl ovl08_215ED04
	bl ovl08_216F860
	bl ovl08_215E5B4
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215F3E0: .word 0x0217E83C
	arm_func_end ovl08_215F360

	arm_func_start ovl08_215F3E4
ovl08_215F3E4: // 0x0215F3E4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #3
	mov r1, #1
	mov r2, #0x3f
	mov r3, #0x14
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x3f
	mov r3, #0x14
	bl ovl08_21759B8
	ldr r0, _0215F424 // =ovl08_215F360
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215F424: .word ovl08_215F360
	arm_func_end ovl08_215F3E4

	arm_func_start ovl08_215F428
ovl08_215F428: // 0x0215F428
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215E5E8
	cmp r0, #0
	beq _0215F474
	cmp r0, #1
	beq _0215F490
	add sp, sp, #4
	ldmia sp!, {pc}
_0215F474:
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0215F4AC // =ovl08_215FC9C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0215F490:
	mov r0, #1
	mov r1, r0
	bl ovl08_215E674
	ldr r0, _0215F4B0 // =ovl08_216BDFC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215F4AC: .word ovl08_215FC9C
_0215F4B0: .word ovl08_216BDFC
	arm_func_end ovl08_215F428

	arm_func_start ovl08_215F4B4
ovl08_215F4B4: // 0x0215F4B4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r2, r0
	mov r1, #1
	mov r3, #0x14
	bl ovl08_21759B8
	mov r0, #2
	mov r2, r0
	mov r1, #0
	mov r3, #0x14
	bl ovl08_21759B8
	ldr r0, _0215F4F4 // =ovl08_215F428
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215F4F4: .word ovl08_215F428
	arm_func_end ovl08_215F4B4

	arm_func_start DWCi_SceneInit
DWCi_SceneInit: // 0x0215F4F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216F874
	bl ovl08_215ED18
	bl ovl08_215AAA8
	bl ovl08_215ABC0
	bl ovl08_215A5F8
	bl ovl08_215E600
	cmp r0, #1
	bne _0215F544
	mov r0, #2
	bl ovl08_215E5C8
	cmp r0, #0
	beq _0215F544
	ldr r0, _0215F678 // =aMsgUsaBmgL
	bl ovl08_215ECA0
	ldr r1, _0215F67C // =0x0217E83C
	str r0, [r1]
	b _0215F55C
_0215F544:
	bl ovl08_215E600
	ldr r1, _0215F680 // =0x0217B6B8
	ldr r0, [r1, r0, lsl #2]
	bl ovl08_215ECA0
	ldr r1, _0215F67C // =0x0217E83C
	str r0, [r1]
_0215F55C:
	ldr r0, _0215F684 // =aCharJtmainNceL
	bl ovl08_215A840
	mov r1, r0
	mov r0, #1
	bl ovl08_2175658
	ldr r0, _0215F688 // =aCharJbmainNceL
	bl ovl08_215A840
	mov r1, r0
	mov r0, #0
	bl ovl08_2175658
	ldr r0, _0215F68C // =aCharJtbgmainNc
	ldr r1, _0215F690 // =GXS_LoadBG1Char
	bl ovl08_215A7F8
	ldr r0, _0215F694 // =aCharJtbgmainNc_0
	ldr r1, _0215F698 // =GXS_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _0215F69C // =aCharJtobjmainN
	ldr r1, _0215F6A0 // =GXS_LoadOBJ
	bl ovl08_215A7F8
	ldr r0, _0215F6A4 // =aCharXtobjmainN
	ldr r1, _0215F6A8 // =GXS_LoadOBJPltt
	bl ovl08_215A7F8
	ldr r0, _0215F6AC // =aCharJbbgstep1N
	ldr r1, _0215F6B0 // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r0, _0215F6B4 // =aCharJbbgstep1N_0
	ldr r1, _0215F6B8 // =GX_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _0215F6BC // =aCharJbobjmainN
	ldr r1, _0215F6C0 // =GX_LoadOBJ
	bl ovl08_215A7F8
	ldr r0, _0215F6C4 // =aCharYbobjmainN
	ldr r1, _0215F6C8 // =GX_LoadOBJPltt
	bl ovl08_215A7F8
	bl ovl08_215E5E8
	cmp r0, #0
	beq _0215F5FC
	cmp r0, #1
	beq _0215F60C
	b _0215F618
_0215F5FC:
	ldr r0, _0215F6CC // =aCharJttopNscL
	ldr r1, _0215F6D0 // =GXS_LoadBG1Scr
	bl ovl08_215A7F8
	b _0215F618
_0215F60C:
	ldr r0, _0215F6D4 // =aCharJtstep1Nsc
	ldr r1, _0215F6D0 // =GXS_LoadBG1Scr
	bl ovl08_215A7F8
_0215F618:
	ldr ip, _0215F6D8 // =0x0400100A
	ldr r3, _0215F6DC // =0x0400000A
	ldrh r2, [ip]
	mov r0, #1
	mov r1, #2
	bic r2, r2, #3
	orr r2, r2, #3
	strh r2, [ip]
	ldrh r2, [r3]
	bic r2, r2, #3
	orr r2, r2, #3
	strh r2, [r3]
	ldrh r2, [r3]
	bic r2, r2, #3
	orr r2, r2, #3
	strh r2, [r3]
	bl ovl08_2176678
	mov r0, #0
	mov r1, #2
	bl ovl08_2176678
	ldr r0, _0215F6E0 // =ovl08_215F4B4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215F678: .word aMsgUsaBmgL
_0215F67C: .word 0x0217E83C
_0215F680: .word 0x0217B6B8
_0215F684: .word aCharJtmainNceL
_0215F688: .word aCharJbmainNceL
_0215F68C: .word aCharJtbgmainNc
_0215F690: .word GXS_LoadBG1Char
_0215F694: .word aCharJtbgmainNc_0
_0215F698: .word GXS_LoadBGPltt
_0215F69C: .word aCharJtobjmainN
_0215F6A0: .word GXS_LoadOBJ
_0215F6A4: .word aCharXtobjmainN
_0215F6A8: .word GXS_LoadOBJPltt
_0215F6AC: .word aCharJbbgstep1N
_0215F6B0: .word GX_LoadBG2Char
_0215F6B4: .word aCharJbbgstep1N_0
_0215F6B8: .word GX_LoadBGPltt
_0215F6BC: .word aCharJbobjmainN
_0215F6C0: .word GX_LoadOBJ
_0215F6C4: .word aCharYbobjmainN
_0215F6C8: .word GX_LoadOBJPltt
_0215F6CC: .word aCharJttopNscL
_0215F6D0: .word GXS_LoadBG1Scr
_0215F6D4: .word aCharJtstep1Nsc
_0215F6D8: .word 0x0400100A
_0215F6DC: .word 0x0400000A
_0215F6E0: .word ovl08_215F4B4
	arm_func_end DWCi_SceneInit

	arm_func_start ovl08_215F6E4
ovl08_215F6E4: // 0x0215F6E4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0215F728 // =_0217A9C4
	ldr r0, _0215F72C // =0x0217E840
	ldrb r3, [r1]
	ldrb r2, [r1, #1]
	ldrb r1, [r0]
	add ip, sp, #0
	ldr r0, _0215F730 // =0x0217E844
	strb r3, [sp]
	strb r2, [sp, #1]
	ldrb r1, [ip, r1]
	ldr r0, [r0]
	mov r2, r1
	bl ovl08_216DEC4
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215F728: .word _0217A9C4
_0215F72C: .word 0x0217E840
_0215F730: .word 0x0217E844
	arm_func_end ovl08_215F6E4

	arm_func_start ovl08_215F734
ovl08_215F734: // 0x0215F734
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	cmp r0, #3
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r1, _0215F7A4 // =0x0217E840
	mov r0, #8
	ldrb r2, [r1]
	eor r2, r2, #1
	strb r2, [r1]
	bl ovl08_216F934
	ldr r0, _0215F7A4 // =0x0217E840
	ldr ip, _0215F7A8 // =0x0217A9D8
	ldrb r0, [r0]
	ldr r1, _0215F7AC // =0x0217A9DC
	ldr r2, _0215F7B0 // =0x0217A9DA
	mov lr, r0, lsl #3
	ldr r3, _0215F7B4 // =0x0217A9DE
	ldrh r0, [ip, lr]
	ldrh r1, [r1, lr]
	ldrh r2, [r2, lr]
	ldrh r3, [r3, lr]
	bl ovl08_215A8E0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215F7A4: .word 0x0217E840
_0215F7A8: .word 0x0217A9D8
_0215F7AC: .word 0x0217A9DC
_0215F7B0: .word 0x0217A9DA
_0215F7B4: .word 0x0217A9DE
	arm_func_end ovl08_215F734

	arm_func_start ovl08_215F7B8
ovl08_215F7B8: // 0x0215F7B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A8A0
	bl ovl08_215A4D8
	ldr r0, _0215F86C // =0x0217E844
	ldr r0, [r0]
	bl ovl08_2174AB8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x14
	bl ovl08_217661C
	ldr r0, _0215F870 // =0x0217E840
	ldrb r0, [r0]
	cmp r0, #0
	beq _0215F834
	cmp r0, #1
	beq _0215F850
	add sp, sp, #4
	ldmia sp!, {pc}
_0215F834:
	mov r0, #1
	mov r1, #0
	bl ovl08_215E674
	ldr r0, _0215F874 // =ovl08_216BDFC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0215F850:
	mov r0, #0
	mov r1, r0
	bl ovl08_215E674
	ldr r0, _0215F878 // =ovl08_2161090
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215F86C: .word 0x0217E844
_0215F870: .word 0x0217E840
_0215F874: .word ovl08_216BDFC
_0215F878: .word ovl08_2161090
	arm_func_end ovl08_215F7B8

	arm_func_start ovl08_215F87C
ovl08_215F87C: // 0x0215F87C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x16
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0215F8D0 // =ovl08_215F7B8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215F8D0: .word ovl08_215F7B8
	arm_func_end ovl08_215F87C

	arm_func_start ovl08_215F8D4
ovl08_215F8D4: // 0x0215F8D4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _0215F8F8 // =ovl08_215F87C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215F8F8: .word ovl08_215F87C
	arm_func_end ovl08_215F8D4

	arm_func_start ovl08_215F8FC
ovl08_215F8FC: // 0x0215F8FC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	beq _0215F920
	cmp r0, #1
	beq _0215F938
	add sp, sp, #4
	ldmia sp!, {pc}
_0215F920:
	mov r0, #7
	bl ovl08_216F934
	ldr r0, _0215F954 // =ovl08_215F3E4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0215F938:
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_215F6E4
	ldr r0, _0215F958 // =ovl08_215F8D4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215F954: .word ovl08_215F3E4
_0215F958: .word ovl08_215F8D4
	arm_func_end ovl08_215F8FC

	arm_func_start ovl08_215F95C
ovl08_215F95C: // 0x0215F95C
	bx lr
	arm_func_end ovl08_215F95C

	arm_func_start ovl08_215F960
ovl08_215F960: // 0x0215F960
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r4, _0215FA98 // =0x0217A9C8
	mov r5, #0
_0215F970:
	mov r0, r4
	bl ovl08_2176A38
	cmp r0, #0
	beq _0215F9C4
	mov r0, #1
	bl ovl08_215A378
	ldr r0, _0215FA9C // =0x0217E840
	ldr ip, _0215FAA0 // =0x0217A9D8
	strb r5, [r0]
	ldrb r0, [r0]
	ldr r1, _0215FAA4 // =0x0217A9DC
	ldr r2, _0215FAA8 // =0x0217A9DA
	mov lr, r0, lsl #3
	ldr r3, _0215FAAC // =0x0217A9DE
	ldrh r0, [ip, lr]
	ldrh r1, [r1, lr]
	ldrh r2, [r2, lr]
	ldrh r3, [r3, lr]
	bl ovl08_215A8E0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0215F9C4:
	add r5, r5, #1
	cmp r5, #2
	add r4, r4, #8
	blo _0215F970
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	beq _0215F9F4
	mov r0, #1
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0215F9F4:
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	beq _0215FA14
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0215FA14:
	mov r0, #0x40
	bl ovl08_2176B34
	cmp r0, #0
	beq _0215FA34
	mov r0, #1
	bl ovl08_215F734
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0215FA34:
	mov r0, #0x80
	bl ovl08_2176B34
	cmp r0, #0
	beq _0215FA54
	mov r0, #3
	bl ovl08_215F734
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0215FA54:
	mov r0, #0x20
	bl ovl08_2176B34
	cmp r0, #0
	beq _0215FA74
	mov r0, #0
	bl ovl08_215F734
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0215FA74:
	mov r0, #0x10
	bl ovl08_2176B34
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	mov r0, #2
	bl ovl08_215F734
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215FA98: .word 0x0217A9C8
_0215FA9C: .word 0x0217E840
_0215FAA0: .word 0x0217A9D8
_0215FAA4: .word 0x0217A9DC
_0215FAA8: .word 0x0217A9DA
_0215FAAC: .word 0x0217A9DE
	arm_func_end ovl08_215F960

	arm_func_start ovl08_215FAB0
ovl08_215FAB0: // 0x0215FAB0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215F960
	bl ovl08_215F95C
	bl ovl08_215F8FC
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_215FAB0

	arm_func_start ovl08_215FACC
ovl08_215FACC: // 0x0215FACC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _0215FAFC // =ovl08_215FAB0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215FAFC: .word ovl08_215FAB0
	arm_func_end ovl08_215FACC

	arm_func_start ovl08_215FB00
ovl08_215FB00: // 0x0215FB00
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_215A770
	ldr r0, _0215FB48 // =ovl08_215FACC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215FB48: .word ovl08_215FACC
	arm_func_end ovl08_215FB00

	arm_func_start ovl08_215FB4C
ovl08_215FB4C: // 0x0215FB4C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x14
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x14
	bl ovl08_2176678
	ldr r0, _0215FBA4 // =ovl08_215FB00
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215FBA4: .word ovl08_215FB00
	arm_func_end ovl08_215FB4C

	arm_func_start ovl08_215FBA8
ovl08_215FBA8: // 0x0215FBA8
	stmdb sp!, {lr}
	sub sp, sp, #0x1c
	ldr ip, _0215FC6C // =aCharYbbgstep11
	add r3, sp, #0
	mov r2, #0xb
_0215FBBC:
	ldrb r1, [ip], #1
	ldrb r0, [ip], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _0215FBBC
	ldr r0, _0215FC70 // =aCharJbbgstep1N_1
	ldr r1, _0215FC74 // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r0, _0215FC78 // =aCharJbbgstep1N_2
	ldr r1, _0215FC7C // =GX_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _0215FC80 // =aCharJb2menuNsc
	ldr r1, _0215FC84 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	add r0, sp, #0
	bl ovl08_215A840
	mov r1, #0
	mov r2, #4
	bl ovl08_2174AF4
	ldr r1, _0215FC88 // =0x0217E844
	ldr ip, _0215FC8C // =0x04001008
	str r0, [r1]
	ldrh r0, [ip]
	ldr r3, _0215FC90 // =0x0400100A
	ldr r2, _0215FC94 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	ldr r1, _0215FC98 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #0x1c
	ldmia sp!, {pc}
	.align 2, 0
_0215FC6C: .word aCharYbbgstep11
_0215FC70: .word aCharJbbgstep1N_1
_0215FC74: .word GX_LoadBG2Char
_0215FC78: .word aCharJbbgstep1N_2
_0215FC7C: .word GX_LoadBGPltt
_0215FC80: .word aCharJb2menuNsc
_0215FC84: .word GX_LoadBG2Scr
_0215FC88: .word 0x0217E844
_0215FC8C: .word 0x04001008
_0215FC90: .word 0x0400100A
_0215FC94: .word 0x0400000A
_0215FC98: .word 0x0400000C
	arm_func_end ovl08_215FBA8

	arm_func_start ovl08_215FC9C
ovl08_215FC9C: // 0x0215FC9C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215FBA8
	mov r0, #0
	bl ovl08_215AB50
	mov r0, #0x2e
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	mov r0, #4
	bl ovl08_216FA6C
	ldr r0, _0215FD08 // =0x0217E840
	ldr r3, _0215FD0C // =0x0217A9D8
	ldrb r0, [r0]
	ldr r1, _0215FD10 // =0x0217A9DC
	ldr r2, _0215FD14 // =0x0217A9DA
	mov ip, r0, lsl #3
	ldrh r0, [r3, ip]
	ldrh r1, [r1, ip]
	ldrh r2, [r2, ip]
	ldr r3, _0215FD18 // =0x0217A9DE
	ldrh r3, [r3, ip]
	bl ovl08_215A8E0
	ldr r0, _0215FD1C // =ovl08_215FB4C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215FD08: .word 0x0217E840
_0215FD0C: .word 0x0217A9D8
_0215FD10: .word 0x0217A9DC
_0215FD14: .word 0x0217A9DA
_0215FD18: .word 0x0217A9DE
_0215FD1C: .word ovl08_215FB4C
	arm_func_end ovl08_215FC9C

	arm_func_start ovl08_215FD20
ovl08_215FD20: // 0x0215FD20
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0215FD48 // =ovl08_215FEF0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215FD48: .word ovl08_215FEF0
	arm_func_end ovl08_215FD20

	arm_func_start ovl08_215FD4C
ovl08_215FD4C: // 0x0215FD4C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	cmp r0, #0
	beq _0215FD84
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0xe
	bl ovl08_216F934
	ldr r0, _0215FDA0 // =0x0217E848
	mov r1, #1
	strb r1, [r0]
	b _0215FD8C
_0215FD84:
	mov r0, #7
	bl ovl08_216F934
_0215FD8C:
	bl ovl08_2171598
	ldr r0, _0215FDA4 // =ovl08_215FD20
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215FDA0: .word 0x0217E848
_0215FDA4: .word ovl08_215FD20
	arm_func_end ovl08_215FD4C

	arm_func_start ovl08_215FDA8
ovl08_215FDA8: // 0x0215FDA8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0215FE74 // =0x0217E848
	ldrb r0, [r0]
	cmp r0, #0
	bne _0215FDE8
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
_0215FDE8:
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_2175D6C
	ldr r0, _0215FE74 // =0x0217E848
	ldrb r0, [r0]
	cmp r0, #0
	bne _0215FE20
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
_0215FE20:
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	ldr r0, _0215FE74 // =0x0217E848
	ldrb r0, [r0]
	cmp r0, #0
	bne _0215FE58
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0215FE78 // =ovl08_2161090
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0215FE58:
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0215FE7C // =ovl08_2160444
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215FE74: .word 0x0217E848
_0215FE78: .word ovl08_2161090
_0215FE7C: .word ovl08_2160444
	arm_func_end ovl08_215FDA8

	arm_func_start ovl08_215FE80
ovl08_215FE80: // 0x0215FE80
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A3AC
	ldr r0, _0215FEE8 // =0x0217E848
	ldrb r0, [r0]
	cmp r0, #0
	bne _0215FEC4
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
_0215FEC4:
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0215FEEC // =ovl08_215FDA8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215FEE8: .word 0x0217E848
_0215FEEC: .word ovl08_215FDA8
	arm_func_end ovl08_215FE80

	arm_func_start ovl08_215FEF0
ovl08_215FEF0: // 0x0215FEF0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _0215FF14 // =ovl08_215FE80
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215FF14: .word ovl08_215FE80
	arm_func_end ovl08_215FEF0

	arm_func_start ovl08_215FF18
ovl08_215FF18: // 0x0215FF18
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	beq _0215FF3C
	cmp r0, #1
	beq _0215FF54
	add sp, sp, #4
	ldmia sp!, {pc}
_0215FF3C:
	mov r0, #7
	bl ovl08_216F934
	ldr r0, _0215FF88 // =ovl08_215FEF0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0215FF54:
	mov r0, #6
	bl ovl08_216F934
	mov r1, #0
	mov r0, #0x18
	mov r2, #1
	mvn r3, #0
	str r1, [sp]
	bl ovl08_21715E4
	bl ovl08_215A308
	ldr r0, _0215FF8C // =ovl08_215FD4C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0215FF88: .word ovl08_215FEF0
_0215FF8C: .word ovl08_215FD4C
	arm_func_end ovl08_215FF18

	arm_func_start ovl08_215FF90
ovl08_215FF90: // 0x0215FF90
	bx lr
	arm_func_end ovl08_215FF90

	arm_func_start ovl08_215FF94
ovl08_215FF94: // 0x0215FF94
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	beq _0215FFB4
	mov r0, #1
	bl ovl08_215A378
_0215FFB4:
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_215FF94

	arm_func_start ovl08_215FFD8
ovl08_215FFD8: // 0x0215FFD8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215FF94
	bl ovl08_215FF90
	bl ovl08_215FF18
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_215FFD8

	arm_func_start ovl08_215FFF4
ovl08_215FFF4: // 0x0215FFF4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _02160024 // =ovl08_215FFD8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160024: .word ovl08_215FFD8
	arm_func_end ovl08_215FFF4

	arm_func_start ovl08_2160028
ovl08_2160028: // 0x02160028
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #3
	bl ovl08_215A770
	ldr r0, _02160070 // =ovl08_215FFF4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160070: .word ovl08_215FFF4
	arm_func_end ovl08_2160028

	arm_func_start ovl08_2160074
ovl08_2160074: // 0x02160074
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _021600CC // =ovl08_2160028
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021600CC: .word ovl08_2160028
	arm_func_end ovl08_2160074

	arm_func_start ovl08_21600D0
ovl08_21600D0: // 0x021600D0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02160150 // =aCharYb5multiNs
	ldr r1, _02160154 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _02160158 // =0x04001008
	ldr ip, _0216015C // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _02160160 // =0x04000008
	ldr r2, _02160164 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _02160168 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160150: .word aCharYb5multiNs
_02160154: .word GX_LoadBG2Scr
_02160158: .word 0x04001008
_0216015C: .word 0x0400100A
_02160160: .word 0x04000008
_02160164: .word 0x0400000A
_02160168: .word 0x0400000C
	arm_func_end ovl08_21600D0

	arm_func_start ovl08_216016C
ovl08_216016C: // 0x0216016C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021601B4 // =0x0217E848
	mov r1, #0
	strb r1, [r0]
	bl ovl08_21600D0
	mov r0, #0x12
	bl ovl08_215AB50
	mov r0, #0x3b
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	mov r0, #0x17
	bl ovl08_215A6F4
	ldr r0, _021601B8 // =ovl08_2160074
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021601B4: .word 0x0217E848
_021601B8: .word ovl08_2160074
	arm_func_end ovl08_216016C

	arm_func_start ovl08_21601BC
ovl08_21601BC: // 0x021601BC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0x1000000
	bl OS_SpinWait
	bl PM_ForceToPowerOff
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_21601BC

	arm_func_start ovl08_2160200
ovl08_2160200: // 0x02160200
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #3
	mov r1, #1
	mov r2, #0x3f
	mov r3, #0x40
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x3f
	mov r3, #0x40
	bl ovl08_21759B8
	ldr r0, _02160254 // =ovl08_21601BC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160254: .word ovl08_21601BC
	arm_func_end ovl08_2160200

	arm_func_start ovl08_2160258
ovl08_2160258: // 0x02160258
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _0216027C // =ovl08_2160200
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216027C: .word ovl08_2160200
	arm_func_end ovl08_2160258

	arm_func_start ovl08_2160280
ovl08_2160280: // 0x02160280
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	ldr r0, _021602B0 // =ovl08_2160258
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021602B0: .word ovl08_2160258
	arm_func_end ovl08_2160280

	arm_func_start ovl08_21602B4
ovl08_21602B4: // 0x021602B4
	bx lr
	arm_func_end ovl08_21602B4

	arm_func_start ovl08_21602B8
ovl08_21602B8: // 0x021602B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_21602B8

	arm_func_start ovl08_21602E4
ovl08_21602E4: // 0x021602E4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21602B8
	bl ovl08_21602B4
	bl ovl08_2160280
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_21602E4

	arm_func_start ovl08_2160300
ovl08_2160300: // 0x02160300
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _02160330 // =ovl08_21602E4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160330: .word ovl08_21602E4
	arm_func_end ovl08_2160300

	arm_func_start ovl08_2160334
ovl08_2160334: // 0x02160334
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #5
	bl ovl08_215A770
	ldr r0, _02160368 // =ovl08_2160300
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160368: .word ovl08_2160300
	arm_func_end ovl08_2160334

	arm_func_start ovl08_216036C
ovl08_216036C: // 0x0216036C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _021603A4 // =ovl08_2160334
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021603A4: .word ovl08_2160334
	arm_func_end ovl08_216036C

	arm_func_start ovl08_21603A8
ovl08_21603A8: // 0x021603A8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02160428 // =aCharYb5multiNs_0
	ldr r1, _0216042C // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _02160430 // =0x04001008
	ldr ip, _02160434 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _02160438 // =0x04000008
	ldr r2, _0216043C // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _02160440 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160428: .word aCharYb5multiNs_0
_0216042C: .word GX_LoadBG2Scr
_02160430: .word 0x04001008
_02160434: .word 0x0400100A
_02160438: .word 0x04000008
_0216043C: .word 0x0400000A
_02160440: .word 0x0400000C
	arm_func_end ovl08_21603A8

	arm_func_start ovl08_2160444
ovl08_2160444: // 0x02160444
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21603A8
	mov r0, #0x19
	bl ovl08_215A6F4
	bl ovl08_216EEF0
	ldr r0, _0216046C // =ovl08_216036C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216046C: .word ovl08_216036C
	arm_func_end ovl08_2160444

	arm_func_start ovl08_2160470
ovl08_2160470: // 0x02160470
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_2175D6C
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _021604F0 // =ovl08_2161090
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021604F0: .word ovl08_2161090
	arm_func_end ovl08_2160470

	arm_func_start ovl08_21604F4
ovl08_21604F4: // 0x021604F4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A3AC
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216054C // =ovl08_2160470
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216054C: .word ovl08_2160470
	arm_func_end ovl08_21604F4

	arm_func_start ovl08_2160550
ovl08_2160550: // 0x02160550
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _02160574 // =ovl08_21604F4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160574: .word ovl08_21604F4
	arm_func_end ovl08_2160550

	arm_func_start ovl08_2160578
ovl08_2160578: // 0x02160578
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #7
	bl ovl08_216F934
	ldr r0, _021605A8 // =ovl08_2160550
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021605A8: .word ovl08_2160550
	arm_func_end ovl08_2160578

	arm_func_start ovl08_21605AC
ovl08_21605AC: // 0x021605AC
	bx lr
	arm_func_end ovl08_21605AC

	arm_func_start ovl08_21605B0
ovl08_21605B0: // 0x021605B0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_21605B0

	arm_func_start ovl08_21605DC
ovl08_21605DC: // 0x021605DC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21605B0
	bl ovl08_21605AC
	bl ovl08_2160578
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_21605DC

	arm_func_start ovl08_21605F8
ovl08_21605F8: // 0x021605F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _02160628 // =ovl08_21605DC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160628: .word ovl08_21605DC
	arm_func_end ovl08_21605F8

	arm_func_start ovl08_216062C
ovl08_216062C: // 0x0216062C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #2
	bl ovl08_215A770
	ldr r0, _02160674 // =ovl08_21605F8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160674: .word ovl08_21605F8
	arm_func_end ovl08_216062C

	arm_func_start ovl08_2160678
ovl08_2160678: // 0x02160678
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _021606D0 // =ovl08_216062C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021606D0: .word ovl08_216062C
	arm_func_end ovl08_2160678

	arm_func_start ovl08_21606D4
ovl08_21606D4: // 0x021606D4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x6c
	mov r0, #0
	mov r1, r0
	bl ovl08_2175F00
	mov r11, r0
	add r0, sp, #0x14
	bl OS_GetMacAddress
	ldrb r1, [sp, #0x15]
	ldr r2, _021608A0 // =_0217B858
	add r0, sp, #0x40
	str r1, [sp]
	ldrb r3, [sp, #0x16]
	mov r1, #0x14
	str r3, [sp, #4]
	ldrb r3, [sp, #0x17]
	str r3, [sp, #8]
	ldrb r3, [sp, #0x18]
	str r3, [sp, #0xc]
	ldrb r3, [sp, #0x19]
	str r3, [sp, #0x10]
	ldrb r3, [sp, #0x14]
	bl swprintf
	ldr r3, _021608A4 // =0x0217AA00
	mov r2, #2
	ldrh r4, [r3, #6]
	mov r1, #0x480
	add r0, sp, #0x40
	str r4, [sp]
	str r2, [sp, #4]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	ldrh r1, [r3]
	ldrh r2, [r3, #2]
	ldrh r3, [r3, #4]
	mov r0, r11
	bl ovl08_2175C00
	add r0, sp, #0x1c
	bl sub_208E050
	ldr r9, [sp, #0x1c]
	ldr r10, [sp, #0x20]
	mov r3, #0
	cmp r10, r3
	cmpeq r9, r3
	beq _02160848
	mov r0, r9
	mov r1, r10
	mov r2, #0xa
	bl _ull_mod
	mov r1, #0x3e8
	umull r4, r1, r0, r1
	mov r0, r9
	mov r1, r10
	mov r3, #0
	mov r2, #0xa
	str r4, [sp, #0x3c]
	bl _ll_udiv
	mov r9, r0
	mov r10, r1
	mov r8, #0
	ldr r7, _021608A8 // =0x00002710
	add r5, sp, #0x30
	mov r6, r8
	mov r4, r8
_021607D4:
	mov r0, r9
	mov r1, r10
	mov r2, r7
	mov r3, r6
	bl _ull_mod
	rsb r1, r8, #2
	str r0, [r5, r1, lsl #2]
	mov r0, r9
	mov r1, r10
	mov r2, r7
	mov r3, r4
	bl _ll_udiv
	mov r9, r0
	mov r10, r1
	add r8, r8, #1
	cmp r8, #3
	blt _021607D4
	ldr r1, [sp, #0x34]
	ldr r2, _021608AC // =0x0217B894
	str r1, [sp]
	ldr r1, [sp, #0x38]
	add r0, sp, #0x40
	str r1, [sp, #4]
	ldr r3, [sp, #0x3c]
	mov r1, #0x14
	str r3, [sp, #8]
	ldr r3, [sp, #0x30]
	bl swprintf
	b _02160858
_02160848:
	ldr r2, _021608B0 // =0x0217B8BC
	add r0, sp, #0x40
	mov r1, #0x14
	bl swprintf
_02160858:
	ldr r0, _021608B4 // =0x0217AA08
	mov r3, #2
	ldrh r4, [r0, #6]
	mov r2, #0x480
	add r1, sp, #0x40
	str r4, [sp]
	str r3, [sp, #4]
	str r2, [sp, #8]
	str r1, [sp, #0xc]
	ldrh r1, [r0]
	ldrh r2, [r0, #2]
	ldrh r3, [r0, #4]
	mov r0, r11
	bl ovl08_2175C00
	mov r0, r11
	bl ovl08_2175B20
	add sp, sp, #0x6c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021608A0: .word _0217B858
_021608A4: .word 0x0217AA00
_021608A8: .word 0x00002710
_021608AC: .word 0x0217B894
_021608B0: .word 0x0217B8BC
_021608B4: .word 0x0217AA08
	arm_func_end ovl08_21606D4

	arm_func_start ovl08_21608B8
ovl08_21608B8: // 0x021608B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02160938 // =aCharJb5infoNsc
	ldr r1, _0216093C // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _02160940 // =0x04001008
	ldr ip, _02160944 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _02160948 // =0x04000008
	ldr r2, _0216094C // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _02160950 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160938: .word aCharJb5infoNsc
_0216093C: .word GX_LoadBG2Scr
_02160940: .word 0x04001008
_02160944: .word 0x0400100A
_02160948: .word 0x04000008
_0216094C: .word 0x0400000A
_02160950: .word 0x0400000C
	arm_func_end ovl08_21608B8

	arm_func_start ovl08_2160954
ovl08_2160954: // 0x02160954
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21608B8
	mov r0, #0x11
	bl ovl08_215AB50
	mov r0, #0x3a
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	bl ovl08_21606D4
	ldr r0, _0216098C // =ovl08_2160678
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216098C: .word ovl08_2160678
	arm_func_end ovl08_2160954

	arm_func_start ovl08_2160990
ovl08_2160990: // 0x02160990
	ldr r1, _021609B4 // =0x0217E84C
	ldr r0, _021609B8 // =0x0217E854
	ldrb r2, [r1]
	ldr r1, _021609BC // =0x0217AA10
	ldr ip, _021609C0 // =ovl08_216DEC4
	ldrb r1, [r1, r2]
	ldr r0, [r0]
	mov r2, r1
	bx ip
	.align 2, 0
_021609B4: .word 0x0217E84C
_021609B8: .word 0x0217E854
_021609BC: .word 0x0217AA10
_021609C0: .word ovl08_216DEC4
	arm_func_end ovl08_2160990

	arm_func_start ovl08_21609C4
ovl08_21609C4: // 0x021609C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #1
	bne _021609F4
	ldr r0, _02160A50 // =0x0217E84C
	mov r1, #3
	ldrb r0, [r0]
	add r0, r0, #2
	bl FX_ModS32
	ldr r1, _02160A50 // =0x0217E84C
	strb r0, [r1]
	b _02160A10
_021609F4:
	ldr r0, _02160A50 // =0x0217E84C
	mov r1, #3
	ldrb r0, [r0]
	add r0, r0, #1
	bl FX_ModS32
	ldr r1, _02160A50 // =0x0217E84C
	strb r0, [r1]
_02160A10:
	mov r0, #8
	bl ovl08_216F934
	ldr r0, _02160A50 // =0x0217E84C
	ldr ip, _02160A54 // =0x0217AA60
	ldrb r0, [r0]
	ldr r1, _02160A58 // =0x0217AA64
	ldr r2, _02160A5C // =0x0217AA62
	mov lr, r0, lsl #3
	ldr r3, _02160A60 // =0x0217AA66
	ldrh r0, [ip, lr]
	ldrh r1, [r1, lr]
	ldrh r2, [r2, lr]
	ldrh r3, [r3, lr]
	bl ovl08_215A8E0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160A50: .word 0x0217E84C
_02160A54: .word 0x0217AA60
_02160A58: .word 0x0217AA64
_02160A5C: .word 0x0217AA62
_02160A60: .word 0x0217AA66
	arm_func_end ovl08_21609C4

	arm_func_start ovl08_2160A64
ovl08_2160A64: // 0x02160A64
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _02160B84 // =0x0217E858
	ldr r0, [r0]
	bl ovl08_21770F8
	bl ovl08_215A8A0
	bl ovl08_215A4D8
	ldr r0, _02160B88 // =0x0217E854
	ldr r0, [r0]
	bl ovl08_2174AB8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x14
	bl ovl08_217661C
	ldr r0, _02160B8C // =0x0217E850
	ldrb r0, [r0]
	cmp r0, #0
	bne _02160B08
	mov r0, #0
	mov r1, r0
	bl ovl08_215E674
	ldr r0, _02160B90 // =ovl08_215FC9C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02160B08:
	ldr r0, _02160B94 // =0x0217E84C
	ldrb r0, [r0]
	cmp r0, #0
	beq _02160B30
	cmp r0, #1
	beq _02160B4C
	cmp r0, #2
	beq _02160B68
	add sp, sp, #4
	ldmia sp!, {pc}
_02160B30:
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02160B98 // =ovl08_2160954
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02160B4C:
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02160B9C // =ovl08_216016C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02160B68:
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02160BA0 // =ovl08_2161D38
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160B84: .word 0x0217E858
_02160B88: .word 0x0217E854
_02160B8C: .word 0x0217E850
_02160B90: .word ovl08_215FC9C
_02160B94: .word 0x0217E84C
_02160B98: .word ovl08_2160954
_02160B9C: .word ovl08_216016C
_02160BA0: .word ovl08_2161D38
	arm_func_end ovl08_2160A64

	arm_func_start ovl08_2160BA4
ovl08_2160BA4: // 0x02160BA4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02160C0C // =0x0217E850
	ldrb r0, [r0]
	cmp r0, #0
	beq _02160BD4
	bl ovl08_215A3AC
_02160BD4:
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x14
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _02160C10 // =ovl08_2160A64
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160C0C: .word 0x0217E850
_02160C10: .word ovl08_2160A64
	arm_func_end ovl08_2160BA4

	arm_func_start ovl08_2160C14
ovl08_2160C14: // 0x02160C14
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _02160C38 // =ovl08_2160BA4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160C38: .word ovl08_2160BA4
	arm_func_end ovl08_2160C14

	arm_func_start ovl08_2160C3C
ovl08_2160C3C: // 0x02160C3C
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	bl ovl08_215A398
	cmp r0, #0
	beq _02160C60
	cmp r0, #1
	beq _02160C6C
	add sp, sp, #0x14
	ldmia sp!, {pc}
_02160C60:
	mov r0, #7
	bl ovl08_216F934
	b _02160CCC
_02160C6C:
	add r0, sp, #0
	bl sub_208E050
	ldr r0, _02160CDC // =0x0217E84C
	ldrb r0, [r0]
	cmp r0, #0
	beq _02160CB4
	ldr r2, [sp]
	ldr r1, [sp, #4]
	mov r0, #0
	cmp r1, r0
	cmpeq r2, r0
	bne _02160CB4
	mov r0, #9
	bl ovl08_216F934
	mvn r0, #0
	bl ovl08_215A364
	add sp, sp, #0x14
	ldmia sp!, {pc}
_02160CB4:
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_2160990
	ldr r0, _02160CE0 // =0x0217E850
	mov r1, #1
	strb r1, [r0]
_02160CCC:
	ldr r0, _02160CE4 // =ovl08_2160C14
	bl DWCi_ChangeScene
	add sp, sp, #0x14
	ldmia sp!, {pc}
	.align 2, 0
_02160CDC: .word 0x0217E84C
_02160CE0: .word 0x0217E850
_02160CE4: .word ovl08_2160C14
	arm_func_end ovl08_2160C3C

	arm_func_start ovl08_2160CE8
ovl08_2160CE8: // 0x02160CE8
	bx lr
	arm_func_end ovl08_2160CE8

	arm_func_start ovl08_2160CEC
ovl08_2160CEC: // 0x02160CEC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r4, _02160DE4 // =0x0217AA48
	mov r5, #0
_02160CFC:
	mov r0, r4
	bl ovl08_2176A38
	cmp r0, #0
	beq _02160D50
	mov r0, #1
	bl ovl08_215A378
	ldr r0, _02160DE8 // =0x0217E84C
	ldr ip, _02160DEC // =0x0217AA60
	strb r5, [r0]
	ldrb r0, [r0]
	ldr r1, _02160DF0 // =0x0217AA64
	ldr r2, _02160DF4 // =0x0217AA62
	mov lr, r0, lsl #3
	ldr r3, _02160DF8 // =0x0217AA66
	ldrh r0, [ip, lr]
	ldrh r1, [r1, lr]
	ldrh r2, [r2, lr]
	ldrh r3, [r3, lr]
	bl ovl08_215A8E0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02160D50:
	add r5, r5, #1
	cmp r5, #3
	add r4, r4, #8
	blo _02160CFC
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	beq _02160D80
	mov r0, #1
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02160D80:
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	beq _02160DA0
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02160DA0:
	mov r0, #0x40
	bl ovl08_2176B34
	cmp r0, #0
	beq _02160DC0
	mov r0, #1
	bl ovl08_21609C4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02160DC0:
	mov r0, #0x80
	bl ovl08_2176B34
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	mov r0, #3
	bl ovl08_21609C4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02160DE4: .word 0x0217AA48
_02160DE8: .word 0x0217E84C
_02160DEC: .word 0x0217AA60
_02160DF0: .word 0x0217AA64
_02160DF4: .word 0x0217AA62
_02160DF8: .word 0x0217AA66
	arm_func_end ovl08_2160CEC

	arm_func_start ovl08_2160DFC
ovl08_2160DFC: // 0x02160DFC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2160CEC
	bl ovl08_2160CE8
	bl ovl08_2160C3C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2160DFC

	arm_func_start ovl08_2160E18
ovl08_2160E18: // 0x02160E18
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _02160E48 // =ovl08_2160DFC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160E48: .word ovl08_2160DFC
	arm_func_end ovl08_2160E18

	arm_func_start ovl08_2160E4C
ovl08_2160E4C: // 0x02160E4C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_215A770
	ldr r0, _02160E94 // =ovl08_2160E18
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160E94: .word ovl08_2160E18
	arm_func_end ovl08_2160E4C

	arm_func_start ovl08_2160E98
ovl08_2160E98: // 0x02160E98
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x14
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x14
	bl ovl08_2176678
	ldr r0, _02160EF0 // =ovl08_2160E4C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02160EF0: .word ovl08_2160E4C
	arm_func_end ovl08_2160E98

	arm_func_start ovl08_2160EF4
ovl08_2160EF4: // 0x02160EF4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x48
	ldr r4, _02161064 // =aCharYbbgoption
	add r3, sp, #0
	mov r2, #0xb
_02160F08:
	ldrb r1, [r4], #1
	ldrb r0, [r4], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _02160F08
	ldr r4, _02161068 // =aCharYbbgoption_0
	add r3, sp, #0x16
	mov r2, #0xb
_02160F2C:
	ldrb r1, [r4], #1
	ldrb r0, [r4], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _02160F2C
	ldrb r2, [r4]
	ldr r0, _0216106C // =aCharJbbgoption
	ldr r1, _02161070 // =GX_LoadBG2Char
	strb r2, [r3]
	bl ovl08_215A7F8
	ldr r0, _02161074 // =aCharJb5optmenu
	ldr r1, _02161078 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	add r0, sp, #0x16
	bl ovl08_215A840
	mov r1, #0
	mov r2, #4
	bl ovl08_2174AF4
	ldr r1, _0216107C // =0x0217E854
	str r0, [r1]
	add r0, sp, #0
	bl ovl08_215A840
	mov r1, #0
	mov r2, #4
	bl ovl08_2174AF4
	mov r5, r0
	add r0, sp, #0x30
	bl sub_208E050
	ldr r1, [sp, #0x30]
	ldr r0, [sp, #0x34]
	mov r6, #0
	cmp r0, r6
	cmpeq r1, r6
	bne _02160FE8
	add r8, r5, #0xc0
	add r7, r5, #0x40
	mov r4, #0x20
_02160FC4:
	mov r0, r8
	mov r1, r7
	mov r2, r4
	bl MI_CpuCopy8
	add r6, r6, #1
	cmp r6, #2
	add r8, r8, #0x20
	add r7, r7, #0x20
	blt _02160FC4
_02160FE8:
	mov r0, r5
	mov r1, #0x200
	bl DC_FlushRange
	mov r0, r5
	mov r1, #0
	mov r2, #0x200
	bl GX_LoadBGPltt
	mov r0, r5
	bl ovl08_2174AB8
	ldr ip, _02161080 // =0x04001008
	ldr r3, _02161084 // =0x0400100A
	ldrh r0, [ip]
	ldr r2, _02161088 // =0x0400000A
	ldr r1, _0216108C // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #0x48
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02161064: .word aCharYbbgoption
_02161068: .word aCharYbbgoption_0
_0216106C: .word aCharJbbgoption
_02161070: .word GX_LoadBG2Char
_02161074: .word aCharJb5optmenu
_02161078: .word GX_LoadBG2Scr
_0216107C: .word 0x0217E854
_02161080: .word 0x04001008
_02161084: .word 0x0400100A
_02161088: .word 0x0400000A
_0216108C: .word 0x0400000C
	arm_func_end ovl08_2160EF4

	arm_func_start ovl08_2161090
ovl08_2161090: // 0x02161090
	stmdb sp!, {r4, lr}
	ldr r0, _02161158 // =0x0217E850
	mov r1, #0
	strb r1, [r0]
	bl ovl08_2160EF4
	mov r0, #0x10
	bl ovl08_215AB50
	mov r0, #3
	bl ovl08_216FA6C
	mov r0, #0x39
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	mov r0, #0
	mov r1, #0x5b
	bl ovl08_2175570
	ldr r3, _0216115C // =0x0217E858
	ldr r1, _02161160 // =0x0217AA14
	str r0, [r3]
	ldrh ip, [r1]
	ldrh r2, [r1, #2]
	ldr r1, _02161164 // =0x000001FF
	ldr lr, [r0]
	and r4, ip, r1
	and ip, r2, #0xff
	ldr r1, _02161168 // =0xFE00FF00
	ldr r2, _0216116C // =0x0217E84C
	and r1, lr, r1
	orr r1, r1, ip
	orr r1, r1, r4, lsl #16
	str r1, [r0]
	ldr lr, [r3]
	ldr r0, _02161170 // =0x0217AA60
	ldrh r3, [lr, #4]
	ldr r1, _02161174 // =0x0217AA64
	ldr ip, _02161178 // =0x0217AA62
	bic r3, r3, #0xc00
	orr r3, r3, #0xc00
	strh r3, [lr, #4]
	ldrb r2, [r2]
	ldr r3, _0216117C // =0x0217AA66
	mov lr, r2, lsl #3
	ldrh r0, [r0, lr]
	ldrh r1, [r1, lr]
	ldrh r2, [ip, lr]
	ldrh r3, [r3, lr]
	bl ovl08_215A8E0
	ldr r0, _02161180 // =ovl08_2160E98
	bl DWCi_ChangeScene
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161158: .word 0x0217E850
_0216115C: .word 0x0217E858
_02161160: .word 0x0217AA14
_02161164: .word 0x000001FF
_02161168: .word 0xFE00FF00
_0216116C: .word 0x0217E84C
_02161170: .word 0x0217AA60
_02161174: .word 0x0217AA64
_02161178: .word 0x0217AA62
_0216117C: .word 0x0217AA66
_02161180: .word ovl08_2160E98
	arm_func_end ovl08_2161090

	arm_func_start ovl08_2161184
ovl08_2161184: // 0x02161184
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #2
	bne _021611B4
	bl ovl08_216EEF0
	ldr r0, _0216120C // =0x0217E85C
	mov r1, #1
	strb r1, [r0]
	bl ovl08_216F8D0
	mov r0, #0x10
	bl ovl08_216F934
	b _021611F0
_021611B4:
	cmp r0, #3
	bne _021611D8
	ldr r0, _0216120C // =0x0217E85C
	mov r1, #2
	strb r1, [r0]
	bl ovl08_216F8D0
	mov r0, #0x12
	bl ovl08_216F934
	b _021611F0
_021611D8:
	ldr r0, _0216120C // =0x0217E85C
	mov r1, #0
	strb r1, [r0]
	bl ovl08_216F8D0
	mov r0, #0x12
	bl ovl08_216F934
_021611F0:
	mov r0, #0
	bl ovl08_215F030
	bl ovl08_215F0A0
	ldr r0, _02161210 // =ovl08_21612C0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216120C: .word 0x0217E85C
_02161210: .word ovl08_21612C0
	arm_func_end ovl08_2161184

	arm_func_start ovl08_2161214
ovl08_2161214: // 0x02161214
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215F048
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215AD18
	bl ovl08_2159CD8
	mov r0, #0
	bl ovl08_2175D6C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _021612B0 // =0x0217E85C
	ldrb r0, [r0]
	cmp r0, #0
	bne _02161288
	ldr r0, _021612B4 // =ovl08_2162398
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02161288:
	cmp r0, #2
	bne _021612A0
	ldr r0, _021612B8 // =ovl08_2161F9C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_021612A0:
	ldr r0, _021612BC // =ovl08_21616CC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021612B0: .word 0x0217E85C
_021612B4: .word ovl08_2162398
_021612B8: .word ovl08_2161F9C
_021612BC: .word ovl08_21616CC
	arm_func_end ovl08_2161214

	arm_func_start ovl08_21612C0
ovl08_21612C0: // 0x021612C0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _021612EC // =ovl08_2161214
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021612EC: .word ovl08_2161214
	arm_func_end ovl08_21612C0

	arm_func_start ovl08_21612F0
ovl08_21612F0: // 0x021612F0
	bx lr
	arm_func_end ovl08_21612F0

	arm_func_start ovl08_21612F4
ovl08_21612F4: // 0x021612F4
	bx lr
	arm_func_end ovl08_21612F4

	arm_func_start ovl08_21612F8
ovl08_21612F8: // 0x021612F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21612F4
	bl ovl08_21612F0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_21612F8

	arm_func_start ovl08_2161310
ovl08_2161310: // 0x02161310
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02161344 // =ovl08_2161184
	bl ovl08_215F030
	ldr r0, _02161348 // =ovl08_21612F8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161344: .word ovl08_2161184
_02161348: .word ovl08_21612F8
	arm_func_end ovl08_2161310

	arm_func_start ovl08_216134C
ovl08_216134C: // 0x0216134C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _02161384 // =ovl08_2161310
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161384: .word ovl08_2161310
	arm_func_end ovl08_216134C

	arm_func_start ovl08_2161388
ovl08_2161388: // 0x02161388
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02161408 // =aCharYb5multiNs_4
	ldr r1, _0216140C // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _02161410 // =0x04001008
	ldr ip, _02161414 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _02161418 // =0x04000008
	ldr r2, _0216141C // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _02161420 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161408: .word aCharYb5multiNs_4
_0216140C: .word GX_LoadBG2Scr
_02161410: .word 0x04001008
_02161414: .word 0x0400100A
_02161418: .word 0x04000008
_0216141C: .word 0x0400000A
_02161420: .word 0x0400000C
	arm_func_end ovl08_2161388

	arm_func_start ovl08_2161424
ovl08_2161424: // 0x02161424
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2161388
	mov r0, #0x1e
	bl ovl08_215A6F4
	mov r0, #0
	bl ovl08_2159D18
	mov r0, #1
	bl ovl08_215AD64
	mov r0, #0xb
	bl ovl08_216F934
	ldr r0, _02161460 // =ovl08_216134C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161460: .word ovl08_216134C
	arm_func_end ovl08_2161424

	arm_func_start ovl08_2161464
ovl08_2161464: // 0x02161464
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0x1000000
	bl OS_SpinWait
	bl PM_ForceToPowerOff
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2161464

	arm_func_start ovl08_21614A8
ovl08_21614A8: // 0x021614A8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #3
	mov r1, #1
	mov r2, #0x3f
	mov r3, #0x40
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x3f
	mov r3, #0x40
	bl ovl08_21759B8
	ldr r0, _021614FC // =ovl08_2161464
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021614FC: .word ovl08_2161464
	arm_func_end ovl08_21614A8

	arm_func_start ovl08_2161500
ovl08_2161500: // 0x02161500
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _02161524 // =ovl08_21614A8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161524: .word ovl08_21614A8
	arm_func_end ovl08_2161500

	arm_func_start ovl08_2161528
ovl08_2161528: // 0x02161528
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	ldr r0, _02161558 // =ovl08_2161500
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161558: .word ovl08_2161500
	arm_func_end ovl08_2161528

	arm_func_start ovl08_216155C
ovl08_216155C: // 0x0216155C
	bx lr
	arm_func_end ovl08_216155C

	arm_func_start ovl08_2161560
ovl08_2161560: // 0x02161560
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2161560

	arm_func_start ovl08_216158C
ovl08_216158C: // 0x0216158C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2161560
	bl ovl08_216155C
	bl ovl08_2161528
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216158C

	arm_func_start ovl08_21615A8
ovl08_21615A8: // 0x021615A8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _021615D8 // =ovl08_216158C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021615D8: .word ovl08_216158C
	arm_func_end ovl08_21615A8

	arm_func_start ovl08_21615DC
ovl08_21615DC: // 0x021615DC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #5
	bl ovl08_215A770
	ldr r0, _02161610 // =ovl08_21615A8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161610: .word ovl08_21615A8
	arm_func_end ovl08_21615DC

	arm_func_start ovl08_2161614
ovl08_2161614: // 0x02161614
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _0216164C // =ovl08_21615DC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216164C: .word ovl08_21615DC
	arm_func_end ovl08_2161614

	arm_func_start ovl08_2161650
ovl08_2161650: // 0x02161650
	ldr r1, _021616B8 // =0x04001008
	ldr ip, _021616BC // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _021616C0 // =0x04000008
	ldr r2, _021616C4 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _021616C8 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	bx lr
	.align 2, 0
_021616B8: .word 0x04001008
_021616BC: .word 0x0400100A
_021616C0: .word 0x04000008
_021616C4: .word 0x0400000A
_021616C8: .word 0x0400000C
	arm_func_end ovl08_2161650

	arm_func_start ovl08_21616CC
ovl08_21616CC: // 0x021616CC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2161650
	mov r0, #0x1f
	bl ovl08_215A6F4
	ldr r0, _021616F0 // =ovl08_2161614
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021616F0: .word ovl08_2161614
	arm_func_end ovl08_21616CC

	arm_func_start ovl08_21616F4
ovl08_21616F4: // 0x021616F4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_2175D6C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02161750 // =ovl08_2162C8C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161750: .word ovl08_2162C8C
	arm_func_end ovl08_21616F4

	arm_func_start ovl08_2161754
ovl08_2161754: // 0x02161754
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A3AC
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _02161798 // =ovl08_21616F4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161798: .word ovl08_21616F4
	arm_func_end ovl08_2161754

	arm_func_start ovl08_216179C
ovl08_216179C: // 0x0216179C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _021617C0 // =ovl08_2161754
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021617C0: .word ovl08_2161754
	arm_func_end ovl08_216179C

	arm_func_start ovl08_21617C4
ovl08_21617C4: // 0x021617C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	ldr r0, _021617F4 // =ovl08_216179C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021617F4: .word ovl08_216179C
	arm_func_end ovl08_21617C4

	arm_func_start ovl08_21617F8
ovl08_21617F8: // 0x021617F8
	bx lr
	arm_func_end ovl08_21617F8

	arm_func_start ovl08_21617FC
ovl08_21617FC: // 0x021617FC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_21617FC

	arm_func_start ovl08_2161828
ovl08_2161828: // 0x02161828
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21617FC
	bl ovl08_21617F8
	bl ovl08_21617C4
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2161828

	arm_func_start ovl08_2161844
ovl08_2161844: // 0x02161844
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _02161874 // =ovl08_2161828
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161874: .word ovl08_2161828
	arm_func_end ovl08_2161844

	arm_func_start ovl08_2161878
ovl08_2161878: // 0x02161878
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #4
	bl ovl08_215A770
	ldr r0, _021618C0 // =ovl08_2161844
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021618C0: .word ovl08_2161844
	arm_func_end ovl08_2161878

	arm_func_start ovl08_21618C4
ovl08_21618C4: // 0x021618C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _021618FC // =ovl08_2161878
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021618FC: .word ovl08_2161878
	arm_func_end ovl08_21618C4

	arm_func_start ovl08_2161900
ovl08_2161900: // 0x02161900
	ldr r1, _02161968 // =0x04001008
	ldr ip, _0216196C // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _02161970 // =0x04000008
	ldr r2, _02161974 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _02161978 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	bx lr
	.align 2, 0
_02161968: .word 0x04001008
_0216196C: .word 0x0400100A
_02161970: .word 0x04000008
_02161974: .word 0x0400000A
_02161978: .word 0x0400000C
	arm_func_end ovl08_2161900

	arm_func_start ovl08_216197C
ovl08_216197C: // 0x0216197C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2161900
	mov r0, #0x1a
	bl ovl08_215A6F4
	ldr r0, _021619A0 // =ovl08_21618C4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021619A0: .word ovl08_21618C4
	arm_func_end ovl08_216197C

	arm_func_start ovl08_21619A4
ovl08_21619A4: // 0x021619A4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02161A70 // =0x0217E860
	ldrb r0, [r0]
	cmp r0, #0
	bne _021619E4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
_021619E4:
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_2175D6C
	ldr r0, _02161A70 // =0x0217E860
	ldrb r0, [r0]
	cmp r0, #0
	bne _02161A1C
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
_02161A1C:
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	ldr r0, _02161A70 // =0x0217E860
	ldrb r0, [r0]
	cmp r0, #0
	bne _02161A54
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02161A74 // =ovl08_2161090
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02161A54:
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02161A78 // =ovl08_216197C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161A70: .word 0x0217E860
_02161A74: .word ovl08_2161090
_02161A78: .word ovl08_216197C
	arm_func_end ovl08_21619A4

	arm_func_start ovl08_2161A7C
ovl08_2161A7C: // 0x02161A7C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A3AC
	ldr r0, _02161AE4 // =0x0217E860
	ldrb r0, [r0]
	cmp r0, #0
	bne _02161AC0
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
_02161AC0:
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _02161AE8 // =ovl08_21619A4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161AE4: .word 0x0217E860
_02161AE8: .word ovl08_21619A4
	arm_func_end ovl08_2161A7C

	arm_func_start ovl08_2161AEC
ovl08_2161AEC: // 0x02161AEC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _02161B10 // =ovl08_2161A7C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161B10: .word ovl08_2161A7C
	arm_func_end ovl08_2161AEC

	arm_func_start ovl08_2161B14
ovl08_2161B14: // 0x02161B14
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	beq _02161B38
	cmp r0, #1
	beq _02161B44
	add sp, sp, #4
	ldmia sp!, {pc}
_02161B38:
	mov r0, #7
	bl ovl08_216F934
	b _02161B58
_02161B44:
	mov r0, #6
	bl ovl08_216F934
	ldr r0, _02161B68 // =0x0217E860
	mov r1, #1
	strb r1, [r0]
_02161B58:
	ldr r0, _02161B6C // =ovl08_2161AEC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161B68: .word 0x0217E860
_02161B6C: .word ovl08_2161AEC
	arm_func_end ovl08_2161B14

	arm_func_start ovl08_2161B70
ovl08_2161B70: // 0x02161B70
	bx lr
	arm_func_end ovl08_2161B70

	arm_func_start ovl08_2161B74
ovl08_2161B74: // 0x02161B74
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	beq _02161B94
	mov r0, #1
	bl ovl08_215A378
_02161B94:
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2161B74

	arm_func_start ovl08_2161BB8
ovl08_2161BB8: // 0x02161BB8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2161B74
	bl ovl08_2161B70
	bl ovl08_2161B14
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2161BB8

	arm_func_start ovl08_2161BD4
ovl08_2161BD4: // 0x02161BD4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _02161C04 // =ovl08_2161BB8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161C04: .word ovl08_2161BB8
	arm_func_end ovl08_2161BD4

	arm_func_start ovl08_2161C08
ovl08_2161C08: // 0x02161C08
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #3
	bl ovl08_215A770
	ldr r0, _02161C3C // =ovl08_2161BD4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161C3C: .word ovl08_2161BD4
	arm_func_end ovl08_2161C08

	arm_func_start ovl08_2161C40
ovl08_2161C40: // 0x02161C40
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _02161C98 // =ovl08_2161C08
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161C98: .word ovl08_2161C08
	arm_func_end ovl08_2161C40

	arm_func_start ovl08_2161C9C
ovl08_2161C9C: // 0x02161C9C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02161D1C // =aCharYb5multiNs_1
	ldr r1, _02161D20 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _02161D24 // =0x04001008
	ldr ip, _02161D28 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _02161D2C // =0x04000008
	ldr r2, _02161D30 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _02161D34 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161D1C: .word aCharYb5multiNs_1
_02161D20: .word GX_LoadBG2Scr
_02161D24: .word 0x04001008
_02161D28: .word 0x0400100A
_02161D2C: .word 0x04000008
_02161D30: .word 0x0400000A
_02161D34: .word 0x0400000C
	arm_func_end ovl08_2161C9C

	arm_func_start ovl08_2161D38
ovl08_2161D38: // 0x02161D38
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02161D80 // =0x0217E860
	mov r1, #0
	strb r1, [r0]
	bl ovl08_2161C9C
	mov r0, #0x13
	bl ovl08_215AB50
	mov r0, #0x3c
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	mov r0, #0x1b
	bl ovl08_215A6F4
	ldr r0, _02161D84 // =ovl08_2161C40
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161D80: .word 0x0217E860
_02161D84: .word ovl08_2161C40
	arm_func_end ovl08_2161D38

	arm_func_start ovl08_2161D88
ovl08_2161D88: // 0x02161D88
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02161DC0 // =0x0217E864
	ldrb r1, [r0]
	add r1, r1, #1
	strb r1, [r0]
	ldrb r0, [r0]
	cmp r0, #0x78
	addlo sp, sp, #4
	ldmloia sp!, {pc}
	ldr r0, _02161DC4 // =ovl08_2161E3C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161DC0: .word 0x0217E864
_02161DC4: .word ovl08_2161E3C
	arm_func_end ovl08_2161D88

	arm_func_start ovl08_2161DC8
ovl08_2161DC8: // 0x02161DC8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175D6C
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02161E38 // =ovl08_2161090
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161E38: .word ovl08_2161090
	arm_func_end ovl08_2161DC8

	arm_func_start ovl08_2161E3C
ovl08_2161E3C: // 0x02161E3C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _02161E7C // =ovl08_2161DC8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161E7C: .word ovl08_2161DC8
	arm_func_end ovl08_2161E3C

	arm_func_start ovl08_2161E80
ovl08_2161E80: // 0x02161E80
	bx lr
	arm_func_end ovl08_2161E80

	arm_func_start ovl08_2161E84
ovl08_2161E84: // 0x02161E84
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2161D88
	bl ovl08_2161E80
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2161E84

	arm_func_start ovl08_2161E9C
ovl08_2161E9C: // 0x02161E9C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215F048
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _02161ED8 // =ovl08_2161E84
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161ED8: .word ovl08_2161E84
	arm_func_end ovl08_2161E9C

	arm_func_start ovl08_2161EDC
ovl08_2161EDC: // 0x02161EDC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _02161F14 // =ovl08_2161E9C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161F14: .word ovl08_2161E9C
	arm_func_end ovl08_2161EDC

	arm_func_start ovl08_2161F18
ovl08_2161F18: // 0x02161F18
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02161F84 // =aCharYb5multiNs_5
	ldr r1, _02161F88 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr ip, _02161F8C // =0x04001008
	ldr r3, _02161F90 // =0x0400100A
	ldrh r0, [ip]
	ldr r2, _02161F94 // =0x0400000A
	ldr r1, _02161F98 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161F84: .word aCharYb5multiNs_5
_02161F88: .word GX_LoadBG2Scr
_02161F8C: .word 0x04001008
_02161F90: .word 0x0400100A
_02161F94: .word 0x0400000A
_02161F98: .word 0x0400000C
	arm_func_end ovl08_2161F18

	arm_func_start ovl08_2161F9C
ovl08_2161F9C: // 0x02161F9C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02161FCC // =0x0217E864
	mov r1, #0
	strb r1, [r0]
	bl ovl08_2161F18
	mov r0, #0x21
	bl ovl08_215A6F4
	ldr r0, _02161FD0 // =ovl08_2161EDC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02161FCC: .word 0x0217E864
_02161FD0: .word ovl08_2161EDC
	arm_func_end ovl08_2161F9C

	arm_func_start ovl08_2161FD4
ovl08_2161FD4: // 0x02161FD4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_2175D6C
	ldr r0, _02162090 // =0x0217E86C
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216203C
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
_0216203C:
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	ldr r0, _02162090 // =0x0217E86C
	ldrb r0, [r0]
	cmp r0, #0
	bne _02162074
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02162094 // =ovl08_2161090
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02162074:
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02162098 // =ovl08_2162C8C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162090: .word 0x0217E86C
_02162094: .word ovl08_2161090
_02162098: .word ovl08_2162C8C
	arm_func_end ovl08_2161FD4

	arm_func_start ovl08_216209C
ovl08_216209C: // 0x0216209C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A3AC
	ldr r0, _02162104 // =0x0217E86C
	ldrb r0, [r0]
	cmp r0, #0
	bne _021620E0
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
_021620E0:
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _02162108 // =ovl08_2161FD4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162104: .word 0x0217E86C
_02162108: .word ovl08_2161FD4
	arm_func_end ovl08_216209C

	arm_func_start ovl08_216210C
ovl08_216210C: // 0x0216210C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _02162130 // =ovl08_216209C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162130: .word ovl08_216209C
	arm_func_end ovl08_216210C

	arm_func_start ovl08_2162134
ovl08_2162134: // 0x02162134
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	beq _0216216C
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r1, _02162190 // =0x0217E86C
	mov r2, #1
	mov r0, #6
	strb r2, [r1]
	bl ovl08_216F934
	b _02162180
_0216216C:
	ldr r1, _02162190 // =0x0217E86C
	mov r2, #0
	mov r0, #7
	strb r2, [r1]
	bl ovl08_216F934
_02162180:
	ldr r0, _02162194 // =ovl08_216210C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162190: .word 0x0217E86C
_02162194: .word ovl08_216210C
	arm_func_end ovl08_2162134

	arm_func_start ovl08_2162198
ovl08_2162198: // 0x02162198
	bx lr
	arm_func_end ovl08_2162198

	arm_func_start ovl08_216219C
ovl08_216219C: // 0x0216219C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	beq _021621BC
	mov r0, #1
	bl ovl08_215A378
_021621BC:
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216219C

	arm_func_start ovl08_21621E0
ovl08_21621E0: // 0x021621E0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216219C
	bl ovl08_2162198
	bl ovl08_2162134
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_21621E0

	arm_func_start ovl08_21621FC
ovl08_21621FC: // 0x021621FC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215F048
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _0216223C // =ovl08_21621E0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216223C: .word ovl08_21621E0
	arm_func_end ovl08_21621FC

	arm_func_start ovl08_2162240
ovl08_2162240: // 0x02162240
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #3
	bl ovl08_215A770
	ldr r0, _02162288 // =ovl08_21621FC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162288: .word ovl08_21621FC
	arm_func_end ovl08_2162240

	arm_func_start ovl08_216228C
ovl08_216228C: // 0x0216228C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _021622F4 // =0x0217E868
	ldrb r0, [r0]
	cmp r0, #0
	beq _021622E4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
_021622E4:
	ldr r0, _021622F8 // =ovl08_2162240
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021622F4: .word 0x0217E868
_021622F8: .word ovl08_2162240
	arm_func_end ovl08_216228C

	arm_func_start ovl08_21622FC
ovl08_21622FC: // 0x021622FC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216237C // =aCharYb5multiNs_3
	ldr r1, _02162380 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _02162384 // =0x04001008
	ldr ip, _02162388 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _0216238C // =0x04000008
	ldr r2, _02162390 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _02162394 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216237C: .word aCharYb5multiNs_3
_02162380: .word GX_LoadBG2Scr
_02162384: .word 0x04001008
_02162388: .word 0x0400100A
_0216238C: .word 0x04000008
_02162390: .word 0x0400000A
_02162394: .word 0x0400000C
	arm_func_end ovl08_21622FC

	arm_func_start ovl08_2162398
ovl08_2162398: // 0x02162398
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21622FC
	mov r0, #0x20
	bl ovl08_215A6F4
	mov r0, #0x3c
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	ldr r1, _021623D4 // =0x0217E868
	strb r0, [r1]
	ldr r0, _021623D8 // =ovl08_216228C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021623D4: .word 0x0217E868
_021623D8: .word ovl08_216228C
	arm_func_end ovl08_2162398

	arm_func_start ovl08_21623DC
ovl08_21623DC: // 0x021623DC
	ldr r0, _021623EC // =0x0217E870
	mov r1, #1
	strb r1, [r0]
	bx lr
	.align 2, 0
_021623EC: .word 0x0217E870
	arm_func_end ovl08_21623DC

	arm_func_start ovl08_21623F0
ovl08_21623F0: // 0x021623F0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021624C4 // =0x0217E870
	ldrb r0, [r0]
	cmp r0, #0
	bne _02162418
	ldr r0, _021624C8 // =0x0217E874
	ldrb r0, [r0]
	cmp r0, #0
	bne _02162428
_02162418:
	bl ovl08_215F048
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
_02162428:
	mov r0, #0
	bl ovl08_2175D6C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	ldr r0, _021624C8 // =0x0217E874
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216245C
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
_0216245C:
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _021624C4 // =0x0217E870
	ldrb r0, [r0]
	cmp r0, #0
	beq _02162488
	ldr r0, _021624CC // =ovl08_2162398
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02162488:
	ldr r0, _021624C8 // =0x0217E874
	ldrb r0, [r0]
	cmp r0, #0
	bne _021624B4
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	ldr r0, _021624D0 // =ovl08_2161090
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_021624B4:
	ldr r0, _021624D4 // =ovl08_2161424
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021624C4: .word 0x0217E870
_021624C8: .word 0x0217E874
_021624CC: .word ovl08_2162398
_021624D0: .word ovl08_2161090
_021624D4: .word ovl08_2161424
	arm_func_end ovl08_21623F0

	arm_func_start ovl08_21624D8
ovl08_21624D8: // 0x021624D8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02162544 // =0x0217E870
	ldrb r0, [r0]
	cmp r0, #0
	bne _02162530
	ldr r0, _02162548 // =0x0217E874
	ldrb r0, [r0]
	cmp r0, #1
	bne _02162530
	bl ovl08_215F024
	b _02162534
_02162530:
	bl ovl08_215F0A0
_02162534:
	ldr r0, _0216254C // =ovl08_21623F0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162544: .word 0x0217E870
_02162548: .word 0x0217E874
_0216254C: .word ovl08_21623F0
	arm_func_end ovl08_21624D8

	arm_func_start ovl08_2162550
ovl08_2162550: // 0x02162550
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _021625B0 // =0x0217E874
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216258C
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
_0216258C:
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _021625B4 // =ovl08_21624D8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021625B0: .word 0x0217E874
_021625B4: .word ovl08_21624D8
	arm_func_end ovl08_2162550

	arm_func_start ovl08_21625B8
ovl08_21625B8: // 0x021625B8
	bx lr
	arm_func_end ovl08_21625B8

	arm_func_start ovl08_21625BC
ovl08_21625BC: // 0x021625BC
	bx lr
	arm_func_end ovl08_21625BC

	arm_func_start ovl08_21625C0
ovl08_21625C0: // 0x021625C0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21625BC
	bl ovl08_21625B8
	bl ovl08_2171584
	cmp r0, #0
	beq _021625EC
	cmp r0, #1
	beq _02162604
	add sp, sp, #4
	ldmia sp!, {pc}
_021625EC:
	ldr r1, _02162634 // =0x0217E874
	mov r2, #0
	mov r0, #7
	strb r2, [r1]
	bl ovl08_216F934
	b _02162618
_02162604:
	ldr r1, _02162634 // =0x0217E874
	mov r2, #1
	mov r0, #0xe
	strb r2, [r1]
	bl ovl08_216F934
_02162618:
	mov r0, #0
	bl ovl08_215F030
	bl ovl08_2171598
	ldr r0, _02162638 // =ovl08_2162550
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162634: .word 0x0217E874
_02162638: .word ovl08_2162550
	arm_func_end ovl08_21625C0

	arm_func_start ovl08_216263C
ovl08_216263C: // 0x0216263C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _02162668 // =ovl08_21625C0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162668: .word ovl08_21625C0
	arm_func_end ovl08_216263C

	arm_func_start ovl08_216266C
ovl08_216266C: // 0x0216266C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02162698 // =ovl08_216263C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162698: .word ovl08_216263C
	arm_func_end ovl08_216266C

	arm_func_start ovl08_216269C
ovl08_216269C: // 0x0216269C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _021626D4 // =ovl08_216266C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021626D4: .word ovl08_216266C
	arm_func_end ovl08_216269C

	arm_func_start ovl08_21626D8
ovl08_21626D8: // 0x021626D8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02162758 // =aCharJb5moveNsc
	ldr r1, _0216275C // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _02162760 // =0x04001008
	ldr ip, _02162764 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _02162768 // =0x04000008
	ldr r2, _0216276C // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _02162770 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162758: .word aCharJb5moveNsc
_0216275C: .word GX_LoadBG2Scr
_02162760: .word 0x04001008
_02162764: .word 0x0400100A
_02162768: .word 0x04000008
_0216276C: .word 0x0400000A
_02162770: .word 0x0400000C
	arm_func_end ovl08_21626D8

	arm_func_start ovl08_2162774
ovl08_2162774: // 0x02162774
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x2c
	bl ovl08_215F008
	mov r5, r0
	mov r0, #0
	mov r1, r0
	bl ovl08_2175F00
	ldr r2, _02162848 // =0x0217E874
	mov r3, #0
	ldr r1, _0216284C // =0x0217E870
	mov r4, r0
	strb r3, [r2]
	strb r3, [r1]
	bl ovl08_21626D8
	mov r0, #0
	add r1, sp, #0x10
	mov r2, #0x16
	bl MIi_CpuClear16
	ldrb r2, [r5, #1]
	add r0, r5, #2
	add r1, sp, #0x10
	mov r2, r2, lsl #1
	bl MIi_CpuCopy16
	ldr r0, _02162850 // =0x0217AA78
	mov lr, #2
	ldrh r2, [r0, #2]
	ldrh r5, [r0, #6]
	ldrh r1, [r0]
	mov ip, #0x480
	sub r5, r5, r2
	str r5, [sp]
	str lr, [sp, #4]
	add r3, sp, #0x10
	str ip, [sp, #8]
	str r3, [sp, #0xc]
	ldrh r3, [r0, #4]
	mov r0, r4
	sub r3, r3, r1
	bl ovl08_2175C00
	mov r0, r4
	bl ovl08_2175B20
	ldr r0, _02162854 // =ovl08_21623DC
	bl ovl08_215F030
	mov r2, #0
	mov r0, #0x1d
	mov r1, #4
	mvn r3, #0
	str r2, [sp]
	bl ovl08_21715E4
	ldr r0, _02162858 // =ovl08_216269C
	bl DWCi_ChangeScene
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02162848: .word 0x0217E874
_0216284C: .word 0x0217E870
_02162850: .word 0x0217AA78
_02162854: .word ovl08_21623DC
_02162858: .word ovl08_216269C
	arm_func_end ovl08_2162774

	arm_func_start ovl08_216285C
ovl08_216285C: // 0x0216285C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl08_216F8D0
	cmp r4, #0
	bne _02162888
	ldr r1, _021628B0 // =0x0217E878
	mov r2, #1
	mov r0, #0x10
	strb r2, [r1]
	bl ovl08_216F934
	b _0216289C
_02162888:
	ldr r1, _021628B0 // =0x0217E878
	mov r2, #2
	mov r0, #0x12
	strb r2, [r1]
	bl ovl08_216F934
_0216289C:
	mov r0, #0
	bl ovl08_215F030
	ldr r0, _021628B4 // =ovl08_2162A6C
	bl DWCi_ChangeScene
	ldmia sp!, {r4, pc}
	.align 2, 0
_021628B0: .word 0x0217E878
_021628B4: .word ovl08_2162A6C
	arm_func_end ovl08_216285C

	arm_func_start ovl08_21628B8
ovl08_21628B8: // 0x021628B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _021629CC // =0x0217E878
	ldrb r0, [r0]
	cmp r0, #0
	bne _021628F8
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
_021628F8:
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _021629CC // =0x0217E878
	ldrb r0, [r0]
	cmp r0, #0
	bne _02162928
	bl ovl08_215F048
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
_02162928:
	bl ovl08_2159CD8
	mov r0, #0
	bl ovl08_2175D6C
	ldr r0, _021629CC // =0x0217E878
	ldrb r0, [r0]
	cmp r0, #0
	bne _02162954
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
_02162954:
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	ldr r0, _021629CC // =0x0217E878
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216298C
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _021629D0 // =ovl08_2161090
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216298C:
	cmp r0, #2
	bne _021629B0
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _021629D4 // =ovl08_2162398
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_021629B0:
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _021629D8 // =ovl08_2162774
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021629CC: .word 0x0217E878
_021629D0: .word ovl08_2161090
_021629D4: .word ovl08_2162398
_021629D8: .word ovl08_2162774
	arm_func_end ovl08_21628B8

	arm_func_start ovl08_21629DC
ovl08_21629DC: // 0x021629DC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02162A64 // =0x0217E878
	ldrb r0, [r0]
	cmp r0, #0
	bne _02162A18
	bl ovl08_215F048
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
_02162A18:
	bl ovl08_215A3AC
	ldr r0, _02162A64 // =0x0217E878
	ldrb r0, [r0]
	cmp r0, #0
	bne _02162A40
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
_02162A40:
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _02162A68 // =ovl08_21628B8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162A64: .word 0x0217E878
_02162A68: .word ovl08_21628B8
	arm_func_end ovl08_21629DC

	arm_func_start ovl08_2162A6C
ovl08_2162A6C: // 0x02162A6C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02162AA4 // =0x0217E878
	ldrb r0, [r0]
	cmp r0, #0
	bne _02162A88
	bl ovl08_215F0A0
_02162A88:
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _02162AA8 // =ovl08_21629DC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162AA4: .word 0x0217E878
_02162AA8: .word ovl08_21629DC
	arm_func_end ovl08_2162A6C

	arm_func_start ovl08_2162AAC
ovl08_2162AAC: // 0x02162AAC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_216F8D0
	mov r0, #7
	bl ovl08_216F934
	ldr r0, _02162AE0 // =ovl08_2162A6C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162AE0: .word ovl08_2162A6C
	arm_func_end ovl08_2162AAC

	arm_func_start ovl08_2162AE4
ovl08_2162AE4: // 0x02162AE4
	bx lr
	arm_func_end ovl08_2162AE4

	arm_func_start ovl08_2162AE8
ovl08_2162AE8: // 0x02162AE8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	beq _02162B10
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
_02162B10:
	bl ovl08_2162CE0
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2162AE8

	arm_func_start ovl08_2162B30
ovl08_2162B30: // 0x02162B30
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2162AE8
	bl ovl08_2162AE4
	bl ovl08_2162AAC
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2162B30

	arm_func_start ovl08_2162B4C
ovl08_2162B4C: // 0x02162B4C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _02162B78 // =ovl08_2162B30
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162B78: .word ovl08_2162B30
	arm_func_end ovl08_2162B4C

	arm_func_start ovl08_2162B7C
ovl08_2162B7C: // 0x02162B7C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #1
	bl ovl08_215A770
	ldr r0, _02162BB0 // =ovl08_2162B4C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162BB0: .word ovl08_2162B4C
	arm_func_end ovl08_2162B7C

	arm_func_start ovl08_2162BB4
ovl08_2162BB4: // 0x02162BB4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _02162BEC // =ovl08_2162B7C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162BEC: .word ovl08_2162B7C
	arm_func_end ovl08_2162BB4

	arm_func_start ovl08_2162BF0
ovl08_2162BF0: // 0x02162BF0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02162C70 // =aCharYb5multiNs_2
	ldr r1, _02162C74 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _02162C78 // =0x04001008
	ldr ip, _02162C7C // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _02162C80 // =0x04000008
	ldr r2, _02162C84 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _02162C88 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162C70: .word aCharYb5multiNs_2
_02162C74: .word GX_LoadBG2Scr
_02162C78: .word 0x04001008
_02162C7C: .word 0x0400100A
_02162C80: .word 0x04000008
_02162C84: .word 0x0400000A
_02162C88: .word 0x0400000C
	arm_func_end ovl08_2162BF0

	arm_func_start ovl08_2162C8C
ovl08_2162C8C: // 0x02162C8C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02162CD4 // =ovl08_216285C
	bl ovl08_215F0C0
	ldr r0, _02162CD8 // =0x0217E878
	mov r1, #0
	strb r1, [r0]
	bl ovl08_2162BF0
	mov r0, #0x1c
	bl ovl08_215A6F4
	mov r0, #0
	bl ovl08_2159D18
	mov r0, #0xb
	bl ovl08_216F934
	ldr r0, _02162CDC // =ovl08_2162BB4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162CD4: .word ovl08_216285C
_02162CD8: .word 0x0217E878
_02162CDC: .word ovl08_2162BB4
	arm_func_end ovl08_2162C8C

	arm_func_start ovl08_2162CE0
ovl08_2162CE0: // 0x02162CE0
	ldr r0, _02162CFC // =0x027FFFA8
	ldrh r0, [r0]
	and r0, r0, #0x8000
	movs r0, r0, asr #0xf
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02162CFC: .word 0x027FFFA8
	arm_func_end ovl08_2162CE0

	arm_func_start ovl08_2162D00
ovl08_2162D00: // 0x02162D00
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216F8D0
	mov r0, #7
	bl ovl08_216F934
	ldr r1, _02162D30 // =0x0217E87C
	mov r2, #0
	ldr r0, _02162D34 // =ovl08_2162F7C
	strb r2, [r1]
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162D30: .word 0x0217E87C
_02162D34: .word ovl08_2162F7C
	arm_func_end ovl08_2162D00

	arm_func_start ovl08_2162D38
ovl08_2162D38: // 0x02162D38
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2163020
	bl ovl08_216301C
	bl ovl08_2162FC0
	ldr r1, _02162D84 // =0x0217E880
	ldr r0, _02162D88 // =0x00000438
	ldrh r2, [r1]
	add r2, r2, #1
	strh r2, [r1]
	ldrh r1, [r1]
	cmp r1, r0
	addlo sp, sp, #4
	ldmloia sp!, {pc}
	bl ovl08_216F8D0
	ldr r0, _02162D8C // =ovl08_2162F7C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162D84: .word 0x0217E880
_02162D88: .word 0x00000438
_02162D8C: .word ovl08_2162F7C
	arm_func_end ovl08_2162D38

	arm_func_start ovl08_2162D90
ovl08_2162D90: // 0x02162D90
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02162DB8 // =ovl08_2162F7C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162DB8: .word ovl08_2162F7C
	arm_func_end ovl08_2162D90

	arm_func_start ovl08_2162DBC
ovl08_2162DBC: // 0x02162DBC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_2171598
	ldr r0, _02162DF0 // =ovl08_2162D90
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162DF0: .word ovl08_2162D90
	arm_func_end ovl08_2162DBC

	arm_func_start ovl08_2162DF4
ovl08_2162DF4: // 0x02162DF4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_IPTlRead
	mov r0, #0
	bl DWCi_TSKlAct
	bl ovl08_2163020
	bl ovl08_2162FC0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2162DF4

	arm_func_start ovl08_2162E18
ovl08_2162E18: // 0x02162E18
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02162F00 // =0x0217E87C
	ldrb r0, [r0]
	cmp r0, #0
	bne _02162E58
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
_02162E58:
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _02162F00 // =0x0217E87C
	ldrb r0, [r0]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	bl ovl08_215E400
	bl ovl08_2159CD8
	mov r0, #0
	bl ovl08_2175D6C
	ldr r0, _02162F00 // =0x0217E87C
	ldrb r0, [r0]
	cmp r0, #0
	bne _02162EAC
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
_02162EAC:
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	ldr r0, _02162F00 // =0x0217E87C
	ldrb r0, [r0]
	cmp r0, #0
	bne _02162EE4
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02162F04 // =ovl08_216C5AC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02162EE4:
	mov r0, #0
	mov r1, r0
	bl ovl08_215E674
	ldr r0, _02162F08 // =ovl08_21635B8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162F00: .word 0x0217E87C
_02162F04: .word ovl08_216C5AC
_02162F08: .word ovl08_21635B8
	arm_func_end ovl08_2162E18

	arm_func_start ovl08_2162F0C
ovl08_2162F0C: // 0x02162F0C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A3AC
	ldr r0, _02162F74 // =0x0217E87C
	ldrb r0, [r0]
	cmp r0, #0
	bne _02162F50
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
_02162F50:
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _02162F78 // =ovl08_2162E18
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162F74: .word 0x0217E87C
_02162F78: .word ovl08_2162E18
	arm_func_end ovl08_2162F0C

	arm_func_start ovl08_2162F7C
ovl08_2162F7C: // 0x02162F7C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	ldr r0, _02162FB8 // =0x0217E884
	ldr r1, [r0]
	cmp r1, #0
	beq _02162FA0
	mov r0, #1
	bl ovl08_2177864
_02162FA0:
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _02162FBC // =ovl08_2162F0C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02162FB8: .word 0x0217E884
_02162FBC: .word ovl08_2162F0C
	arm_func_end ovl08_2162F7C

	arm_func_start ovl08_2162FC0
ovl08_2162FC0: // 0x02162FC0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02163014 // =0x0217E884
	ldr r1, [r0]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #1
	bl ovl08_2177870
	ldr r0, _02163014 // =0x0217E884
	mov r1, #0
	str r1, [r0]
	bl ovl08_215A308
	ldr r0, _02163018 // =ovl08_2162D00
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02163014: .word 0x0217E884
_02163018: .word ovl08_2162D00
	arm_func_end ovl08_2162FC0

	arm_func_start ovl08_216301C
ovl08_216301C: // 0x0216301C
	bx lr
	arm_func_end ovl08_216301C

	arm_func_start ovl08_2163020
ovl08_2163020: // 0x02163020
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	beq _02163048
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
_02163048:
	bl ovl08_2163388
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2163020

	arm_func_start ovl08_2163068
ovl08_2163068: // 0x02163068
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2163020
	bl ovl08_216301C
	bl ovl08_2162FC0
	bl ovl08_215E390
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	cmp r0, #1
	beq _021630A4
	cmp r0, #2
	beq _021630E4
	add sp, sp, #4
	ldmia sp!, {pc}
_021630A4:
	ldr r0, _02163150 // =0x0217E884
	ldr r1, [r0]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r2, _02163154 // =0x0217E87C
	mov r0, #1
	strb r0, [r2]
	bl ovl08_2177864
	ldr r1, _02163150 // =0x0217E884
	mov r2, #0
	ldr r0, _02163158 // =ovl08_2162D38
	str r2, [r1]
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_021630E4:
	ldr r0, _02163150 // =0x0217E884
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_216F8D0
	mov r1, #1
	mov ip, #0
	mov r2, r1
	mov r0, #0xc
	mvn r3, #0
	str ip, [sp]
	bl ovl08_21715E4
	mov r0, #9
	bl ovl08_216F934
	bl ovl08_215A308
	ldr r1, _02163150 // =0x0217E884
	mov r0, #1
	ldr r1, [r1]
	bl ovl08_2177864
	ldr r1, _02163150 // =0x0217E884
	mov r2, #0
	ldr r0, _0216315C // =ovl08_2162DBC
	str r2, [r1]
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02163150: .word 0x0217E884
_02163154: .word 0x0217E87C
_02163158: .word ovl08_2162D38
_0216315C: .word ovl08_2162DBC
	arm_func_end ovl08_2163068

	arm_func_start ovl08_2163160
ovl08_2163160: // 0x02163160
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r1, _021631A8 // =ovl08_2162DF4
	mov r0, #1
	mov r2, #0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _021631AC // =0x0217E884
	str r0, [r1]
	ldr r0, _021631B0 // =ovl08_2163068
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021631A8: .word ovl08_2162DF4
_021631AC: .word 0x0217E884
_021631B0: .word ovl08_2163068
	arm_func_end ovl08_2163160

	arm_func_start ovl08_21631B4
ovl08_21631B4: // 0x021631B4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #1
	bl ovl08_215A770
	ldr r0, _021631FC // =ovl08_2163160
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021631FC: .word ovl08_2163160
	arm_func_end ovl08_21631B4

	arm_func_start ovl08_2163200
ovl08_2163200: // 0x02163200
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _02163258 // =ovl08_21631B4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02163258: .word ovl08_21631B4
	arm_func_end ovl08_2163200

	arm_func_start ovl08_216325C
ovl08_216325C: // 0x0216325C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021632F4 // =aCharJbbgstep3N_3
	ldr r1, _021632F8 // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r0, _021632FC // =aCharYbbgstep3N_3
	ldr r1, _02163300 // =GX_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _02163304 // =aCharXb4multiNs_0
	ldr r1, _02163308 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _0216330C // =0x04001008
	ldr ip, _02163310 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _02163314 // =0x04000008
	ldr r2, _02163318 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _0216331C // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021632F4: .word aCharJbbgstep3N_3
_021632F8: .word GX_LoadBG2Char
_021632FC: .word aCharYbbgstep3N_3
_02163300: .word GX_LoadBGPltt
_02163304: .word aCharXb4multiNs_0
_02163308: .word GX_LoadBG2Scr
_0216330C: .word 0x04001008
_02163310: .word 0x0400100A
_02163314: .word 0x04000008
_02163318: .word 0x0400000A
_0216331C: .word 0x0400000C
	arm_func_end ovl08_216325C

	arm_func_start ovl08_2163320
ovl08_2163320: // 0x02163320
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02163380 // =0x0217E880
	mov r1, #0
	strh r1, [r0]
	bl ovl08_216325C
	bl ovl08_215AB30
	mov r0, #0x36
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	mov r0, #2
	bl ovl08_215A7A8
	mov r0, #0x22
	bl ovl08_215A6F4
	mov r0, #0
	bl ovl08_2159D18
	bl ovl08_215E45C
	mov r0, #0xb
	bl ovl08_216F934
	ldr r0, _02163384 // =ovl08_2163200
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02163380: .word 0x0217E880
_02163384: .word ovl08_2163200
	arm_func_end ovl08_2163320

	arm_func_start ovl08_2163388
ovl08_2163388: // 0x02163388
	ldr r0, _021633A4 // =0x027FFFA8
	ldrh r0, [r0]
	and r0, r0, #0x8000
	movs r0, r0, asr #0xf
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_021633A4: .word 0x027FFFA8
	arm_func_end ovl08_2163388

	arm_func_start ovl08_21633A8
ovl08_21633A8: // 0x021633A8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021633E0 // =0x0217E888
	ldrb r1, [r0]
	add r1, r1, #1
	strb r1, [r0]
	ldrb r0, [r0]
	cmp r0, #0x78
	addlo sp, sp, #4
	ldmloia sp!, {pc}
	ldr r0, _021633E4 // =ovl08_2163468
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021633E0: .word 0x0217E888
_021633E4: .word ovl08_2163468
	arm_func_end ovl08_21633A8

	arm_func_start ovl08_21633E8
ovl08_21633E8: // 0x021633E8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175D6C
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	mov r0, #0
	mov r1, r0
	bl ovl08_215E674
	mov r0, #0
	mov r1, #1
	bl ovl08_215E638
	ldr r0, _02163464 // =ovl08_216D064
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02163464: .word ovl08_216D064
	arm_func_end ovl08_21633E8

	arm_func_start ovl08_2163468
ovl08_2163468: // 0x02163468
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _021634A8 // =ovl08_21633E8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021634A8: .word ovl08_21633E8
	arm_func_end ovl08_2163468

	arm_func_start ovl08_21634AC
ovl08_21634AC: // 0x021634AC
	bx lr
	arm_func_end ovl08_21634AC

	arm_func_start ovl08_21634B0
ovl08_21634B0: // 0x021634B0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21633A8
	bl ovl08_21634AC
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_21634B0

	arm_func_start ovl08_21634C8
ovl08_21634C8: // 0x021634C8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _021634F4 // =ovl08_21634B0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021634F4: .word ovl08_21634B0
	arm_func_end ovl08_21634C8

	arm_func_start ovl08_21634F8
ovl08_21634F8: // 0x021634F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _02163530 // =ovl08_21634C8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02163530: .word ovl08_21634C8
	arm_func_end ovl08_21634F8

	arm_func_start ovl08_2163534
ovl08_2163534: // 0x02163534
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021635A0 // =aCharXb4multiNs_8
	ldr r1, _021635A4 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr ip, _021635A8 // =0x04001008
	ldr r3, _021635AC // =0x0400100A
	ldrh r0, [ip]
	ldr r2, _021635B0 // =0x0400000A
	ldr r1, _021635B4 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021635A0: .word aCharXb4multiNs_8
_021635A4: .word GX_LoadBG2Scr
_021635A8: .word 0x04001008
_021635AC: .word 0x0400100A
_021635B0: .word 0x0400000A
_021635B4: .word 0x0400000C
	arm_func_end ovl08_2163534

	arm_func_start ovl08_21635B8
ovl08_21635B8: // 0x021635B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021635F4 // =0x0217E888
	mov r1, #0
	strb r1, [r0]
	bl ovl08_2163534
	bl ovl08_215AB30
	mov r0, #0x23
	bl ovl08_215A6F4
	mov r0, #0x10
	bl ovl08_216F934
	ldr r0, _021635F8 // =ovl08_21634F8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021635F4: .word 0x0217E888
_021635F8: .word ovl08_21634F8
	arm_func_end ovl08_21635B8

	arm_func_start ovl08_21635FC
ovl08_21635FC: // 0x021635FC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A320
	bl ovl08_216E614
	ldr r0, _0216362C // =ovl08_2164838
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216362C: .word ovl08_2164838
	arm_func_end ovl08_21635FC

	arm_func_start ovl08_2163630
ovl08_2163630: // 0x02163630
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_2171598
	ldr r0, _02163664 // =ovl08_21635FC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02163664: .word ovl08_21635FC
	arm_func_end ovl08_2163630

	arm_func_start ovl08_2163668
ovl08_2163668: // 0x02163668
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0216369C // =0x0217AA80
	ldr r0, _021636A0 // =0x0217E894
	ldrb r1, [r1]
	ldr r0, [r0]
	strb r1, [sp]
	ldrb r1, [sp]
	ldr r0, [r0, #8]
	mov r2, r1
	bl ovl08_216DEC4
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216369C: .word 0x0217AA80
_021636A0: .word 0x0217E894
	arm_func_end ovl08_2163668

	arm_func_start ovl08_21636A4
ovl08_21636A4: // 0x021636A4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _02163734 // =0x0217E894
	ldr r0, _02163738 // =0x0217E890
	ldr r2, [r1]
	ldrh r1, [r0]
	ldrh r0, [r2, #0x40]
	cmp r1, r0
	beq _021636D4
	ldrb r0, [r2, #0x51]
	cmp r0, #4
	bhi _02163704
_021636D4:
	ldrb r0, [r2, #0x59]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _02163734 // =0x0217E894
	mov r1, #1
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x59]
	ldmia sp!, {pc}
_02163704:
	mov r0, #0x13
	bl ovl08_216F934
	mov r0, #0
	ldr r1, _0216373C // =ovl08_21639FC
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _02163734 // =0x0217E894
	ldr r1, [r1]
	str r0, [r1, #0x38]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02163734: .word 0x0217E894
_02163738: .word 0x0217E890
_0216373C: .word ovl08_21639FC
	arm_func_end ovl08_21636A4

	arm_func_start ovl08_2163740
ovl08_2163740: // 0x02163740
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021637C0 // =0x0217E890
	ldrh r0, [r0]
	cmp r0, #0
	bne _02163790
	ldr r0, _021637C4 // =0x0217E894
	ldr r0, [r0]
	ldrb r0, [r0, #0x59]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _021637C4 // =0x0217E894
	mov r1, #1
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x59]
	ldmia sp!, {pc}
_02163790:
	mov r0, #0x13
	bl ovl08_216F934
	mov r0, #0
	ldr r1, _021637C8 // =ovl08_2163A9C
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _021637C4 // =0x0217E894
	ldr r1, [r1]
	str r0, [r1, #0x38]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021637C0: .word 0x0217E890
_021637C4: .word 0x0217E894
_021637C8: .word ovl08_2163A9C
	arm_func_end ovl08_2163740

	arm_func_start ovl08_21637CC
ovl08_21637CC: // 0x021637CC
	stmdb sp!, {r4, lr}
	ldr r1, _02163920 // =0x0217E88C
	mov r4, #1
	ldrb r2, [r1]
	cmp r2, #4
	addls pc, pc, r2, lsl #2
	b _021638D8
_021637E8: // jump table
	b _021637FC // case 0
	b _02163868 // case 1
	b _02163868 // case 2
	b _02163898 // case 3
	b _021638B0 // case 4
_021637FC:
	cmp r0, #1
	bne _02163848
	ldr r0, _02163924 // =0x0217E890
	ldrh r0, [r0]
	cmp r0, #0
	moveq r0, #4
	streqb r0, [r1]
	beq _021638D8
	mov r0, #0x13
	bl ovl08_216F934
	mov r0, #0
	ldr r1, _02163928 // =ovl08_2163A9C
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _0216392C // =0x0217E894
	ldr r1, [r1]
	str r0, [r1, #0x38]
	ldmia sp!, {r4, pc}
_02163848:
	ldr r0, _0216392C // =0x0217E894
	ldr r0, [r0]
	ldrb r0, [r0, #0x51]
	cmp r0, #1
	addhi r0, r2, #1
	strhib r0, [r1]
	movls r4, #0
	b _021638D8
_02163868:
	cmp r0, #1
	subeq r0, r2, #1
	streqb r0, [r1]
	beq _021638D8
	ldr r0, _0216392C // =0x0217E894
	add r2, r2, #1
	ldr r0, [r0]
	ldrb r0, [r0, #0x51]
	cmp r0, r2
	strgtb r2, [r1]
	movle r4, #0
	b _021638D8
_02163898:
	cmp r0, #1
	subeq r0, r2, #1
	streqb r0, [r1]
	beq _021638D8
	bl ovl08_21636A4
	ldmia sp!, {r4, pc}
_021638B0:
	cmp r0, #1
	moveq r4, #0
	beq _021638D8
	ldr r0, _02163924 // =0x0217E890
	mov r2, #0
	strh r2, [r0]
	strb r2, [r1]
	bl ovl08_2163E3C
	mov r0, #0
	bl ovl08_216E62C
_021638D8:
	cmp r4, #0
	bne _02163910
	ldr r0, _0216392C // =0x0217E894
	ldr r0, [r0]
	ldrb r0, [r0, #0x59]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _0216392C // =0x0217E894
	mov r1, #1
	ldr r0, [r0]
	strb r1, [r0, #0x59]
	ldmia sp!, {r4, pc}
_02163910:
	mov r0, #8
	bl ovl08_216F934
	bl ovl08_2163930
	ldmia sp!, {r4, pc}
	.align 2, 0
_02163920: .word 0x0217E88C
_02163924: .word 0x0217E890
_02163928: .word ovl08_2163A9C
_0216392C: .word 0x0217E894
	arm_func_end ovl08_21637CC

	arm_func_start ovl08_2163930
ovl08_2163930: // 0x02163930
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02163974 // =0x0217E88C
	ldr r1, _02163978 // =0x0217AAE8
	ldrb r2, [r0]
	ldr r3, _0216397C // =0x0217AAEA
	mov ip, r2, lsl #3
	cmp r2, #4
	ldr r2, _02163980 // =0x0217AAEC
	movlo r0, #2
	ldrh r1, [r1, ip]
	ldrh r2, [r2, ip]
	ldrh r3, [r3, ip]
	movhs r0, #3
	bl ovl08_215A9CC
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02163974: .word 0x0217E88C
_02163978: .word 0x0217AAE8
_0216397C: .word 0x0217AAEA
_02163980: .word 0x0217AAEC
	arm_func_end ovl08_2163930

	arm_func_start ovl08_2163984
ovl08_2163984: // 0x02163984
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021639E8 // =0x0217E894
	ldr r0, [r0]
	ldrb r0, [r0, #0x56]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _021639EC // =0x0217E890
	mov r1, #0x1c
	ldrh r0, [r0]
	bl FX_ModS32
	ldr r1, _021639F0 // =0x01FF0000
	sub r2, r0, #0x32
	ldr r0, _021639F4 // =0x04000010
	and r2, r1, r2, lsl #16
	ldr r1, _021639F8 // =0x04000018
	str r2, [r0]
	ldr r0, _021639E8 // =0x0217E894
	str r2, [r1]
	ldr r0, [r0]
	mov r1, #0
	strb r1, [r0, #0x56]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021639E8: .word 0x0217E894
_021639EC: .word 0x0217E890
_021639F0: .word 0x01FF0000
_021639F4: .word 0x04000010
_021639F8: .word 0x04000018
	arm_func_end ovl08_2163984

	arm_func_start ovl08_21639FC
ovl08_21639FC: // 0x021639FC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl08_216E5FC
	bl ovl08_215A8A0
	ldr r0, _02163A94 // =0x0217E890
	mov r1, #0x1c
	ldrh r2, [r0]
	add r2, r2, #4
	strh r2, [r0]
	ldrh r0, [r0]
	bl FX_ModS32
	cmp r0, #4
	blt _02163A38
	bl ovl08_2163B78
	ldmia sp!, {r4, pc}
_02163A38:
	ldr r1, _02163A94 // =0x0217E890
	ldrh r2, [r1]
	sub r0, r2, r0
	strh r0, [r1]
	bl ovl08_2163E3C
	ldr r1, _02163A98 // =0x0217E894
	ldr r0, _02163A94 // =0x0217E890
	ldr r1, [r1]
	ldrh r2, [r0]
	ldrb r0, [r1, #0x53]
	ldrh r1, [r1, #0x40]
	mul r0, r2, r0
	bl FX_DivS32
	bl ovl08_216E62C
	bl ovl08_216E614
	bl ovl08_2163930
	ldr r0, _02163A98 // =0x0217E894
	mov r1, r4
	ldr r2, [r0]
	mov r0, #0
	str r0, [r2, #0x38]
	bl ovl08_2177870
	ldmia sp!, {r4, pc}
	.align 2, 0
_02163A94: .word 0x0217E890
_02163A98: .word 0x0217E894
	arm_func_end ovl08_21639FC

	arm_func_start ovl08_2163A9C
ovl08_2163A9C: // 0x02163A9C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	bl ovl08_216E5FC
	bl ovl08_215A8A0
	ldr r0, _02163B70 // =0x0217E890
	ldrh r1, [r0]
	cmp r1, #4
	subhi r1, r1, #4
	strhih r1, [r0]
	movls r1, #0
	strlsh r1, [r0]
	ldr r0, _02163B70 // =0x0217E890
	mov r1, #0x1c
	ldrh r0, [r0]
	bl FX_ModS32
	mov r5, r0
	cmp r5, #0x18
	bne _02163AF4
	bl ovl08_2163E3C
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02163AF4:
	cmp r5, #0x18
	ble _02163B14
	ldr r0, _02163B70 // =0x0217E890
	rsb r1, r5, #0x1c
	ldrh r2, [r0]
	mov r5, #0
	add r1, r2, r1
	strh r1, [r0]
_02163B14:
	bl ovl08_2163B78
	cmp r5, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	ldr r1, _02163B74 // =0x0217E894
	ldr r0, _02163B70 // =0x0217E890
	ldr r1, [r1]
	ldrh r2, [r0]
	ldrb r0, [r1, #0x53]
	ldrh r1, [r1, #0x40]
	mul r0, r2, r0
	bl FX_DivS32
	bl ovl08_216E62C
	bl ovl08_216E614
	bl ovl08_2163930
	ldr r0, _02163B74 // =0x0217E894
	mov r1, r4
	ldr r2, [r0]
	mov r0, #0
	str r0, [r2, #0x38]
	bl ovl08_2177870
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02163B70: .word 0x0217E890
_02163B74: .word 0x0217E894
	arm_func_end ovl08_2163A9C

	arm_func_start ovl08_2163B78
ovl08_2163B78: // 0x02163B78
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, _02163C2C // =0x0217E890
	mov r1, #0x1c
	ldrh r0, [r0]
	bl FX_ModS32
	ldr r1, _02163C30 // =0x0217E894
	rsb r2, r0, #0x36
	ldr r0, [r1]
	ldrb r1, [r0, #0x51]
	mov r0, #0
	cmp r1, #5
	movgt r1, #5
	cmp r1, #0
	ble _02163C18
	ldr ip, _02163C30 // =0x0217E894
	ldr r3, _02163C34 // =0xFE00FF00
_02163BB8:
	ldr r5, [ip]
	sub r4, r2, #2
	add r5, r5, r0, lsl #2
	ldr r6, [r5, #0x10]
	add lr, r2, #1
	ldr r5, [r6]
	and r4, r4, #0xff
	and r5, r5, r3
	orr r4, r5, r4
	orr r4, r4, #0xb30000
	str r4, [r6]
	ldr r4, [ip]
	and lr, lr, #0xff
	add r4, r4, r0, lsl #2
	ldr r5, [r4, #0x24]
	add r0, r0, #1
	ldr r4, [r5]
	cmp r0, r1
	and r4, r4, r3
	orr r4, r4, lr
	orr r4, r4, #0xd20000
	str r4, [r5]
	add r2, r2, #0x1c
	blt _02163BB8
_02163C18:
	ldr r0, _02163C30 // =0x0217E894
	mov r1, #1
	ldr r0, [r0]
	strb r1, [r0, #0x56]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02163C2C: .word 0x0217E890
_02163C30: .word 0x0217E894
_02163C34: .word 0xFE00FF00
	arm_func_end ovl08_2163B78

	arm_func_start ovl08_2163C38
ovl08_2163C38: // 0x02163C38
	stmdb sp!, {r4, lr}
	ldr r3, _02163CC0 // =0x0217E894
	ldr lr, [r3]
	ldrb r2, [lr, #0x51]
	cmp r0, r2
	ldmgeia sp!, {r4, pc}
	mov r2, #0x2a
	mul r2, r0, r2
	ldr r0, [lr]
	add r4, lr, r1, lsl #2
	add r0, r0, r2
	ldrb ip, [r0, #0x28]
	ldr r4, [r4, #0x10]
	mov r0, #0x400
	add ip, lr, ip, lsl #1
	ldrh lr, [r4, #4]
	rsb r0, r0, #0
	ldrh ip, [ip, #0x42]
	and lr, lr, r0
	orr ip, lr, ip
	strh ip, [r4, #4]
	ldr lr, [r3]
	ldr r3, [lr]
	add ip, lr, r1, lsl #2
	add r1, r3, r2
	ldrh r1, [r1, #0x26]
	ldr r3, [ip, #0x24]
	add r1, lr, r1, lsl #1
	ldrh r2, [r3, #4]
	ldrh r1, [r1, #0x48]
	and r0, r2, r0
	orr r0, r0, r1
	strh r0, [r3, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02163CC0: .word 0x0217E894
	arm_func_end ovl08_2163C38

	arm_func_start ovl08_2163CC4
ovl08_2163CC4: // 0x02163CC4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x34
	mov r7, r0
	mov r0, #0x2a
	ldr r2, _02163E38 // =0x0217E894
	mul r4, r7, r0
	ldr r0, [r2]
	mov r6, r1
	ldr r0, [r0]
	mov r1, #0x20
	add r0, r0, r4
	bl ovl08_2177504
	ldr r2, _02163E38 // =0x0217E894
	mov r1, #0x1c
	mul r5, r6, r1
	ldr r2, [r2]
	mov r6, r0
	ldrb r1, [r2, #0x51]
	cmp r7, r1
	addge sp, sp, #0x34
	ldmgeia sp!, {r4, r5, r6, r7, pc}
	add r0, sp, #0xc
	cmp r6, #0x10
	mov r1, #0
	mov r2, #0x22
	addle r5, r5, #6
	bl MI_CpuFill8
	cmp r6, #0x10
	movle ip, r6
	movgt ip, #0x10
	cmp ip, #0
	mov r7, #0
	ble _02163D74
	ldr r0, _02163E38 // =0x0217E894
	ldr r3, [r0]
	add r0, sp, #0xc
_02163D54:
	ldr r2, [r3]
	mov r1, r7, lsl #1
	add r2, r4, r2
	ldrb r2, [r7, r2]
	add r7, r7, #1
	cmp r7, ip
	strh r2, [r0, r1]
	blt _02163D54
_02163D74:
	mov r1, #0xa
	add r0, sp, #0xc
	arm_func_end ovl08_2163CC4

	arm_func_start ovl08_2163D7C
ovl08_2163D7C: // 0x02163D7C
	str r1, [sp]
	str r0, [sp, #4]
	mov r2, #1
	str r2, [sp, #8]
	ldr r0, _02163E38 // =0x0217E894
	mov r2, r5
	ldr r0, [r0]
	mov r3, #2
	ldr r0, [r0, #0xc]
	bl ovl08_2175C38
	cmp r6, #0x10
	addle sp, sp, #0x34
	ldmleia sp!, {r4, r5, r6, r7, pc}
	add r0, sp, #0xc
	mov r1, #0
	mov r2, #0x22
	bl MI_CpuFill8
	sub r6, r6, #0x10
	cmp r6, #0
	mov r3, #0
	ble _02163E00
	ldr r0, _02163E38 // =0x0217E894
	ldr r7, [r0]
	add r0, sp, #0xc
_02163DDC:
	ldr r1, [r7]
	add r2, r3, #0x10
	add r1, r4, r1
	ldrb r2, [r2, r1]
	mov r1, r3, lsl #1
	add r3, r3, #1
	strh r2, [r0, r1]
	cmp r3, r6
	blt _02163DDC
_02163E00:
	mov r1, #0xa
	add r0, sp, #0xc
	str r1, [sp]
	str r0, [sp, #4]
	mov r2, #1
	str r2, [sp, #8]
	ldr r0, _02163E38 // =0x0217E894
	add r2, r5, #0xc
	ldr r0, [r0]
	mov r3, #2
	ldr r0, [r0, #0xc]
	bl ovl08_2175C38
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02163E38: .word 0x0217E894
	arm_func_end ovl08_2163D7C

	arm_func_start ovl08_2163E3C
ovl08_2163E3C: // 0x02163E3C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r0, _02163EE8 // =0x0217E890
	mov r1, #0x1c
	ldrh r0, [r0]
	bl FX_DivS32
	ldr r1, _02163EEC // =0x0217E894
	mov r7, r0
	ldr r0, [r1]
	mov r1, #0
	ldrb r6, [r0, #0x51]
	ldr r0, [r0, #0xc]
	bl ovl08_2175BE8
	cmp r6, #5
	movgt r6, #5
	mov r5, r7
	cmp r6, #0
	mov r4, #0
	ble _02163EA4
_02163E88:
	mov r0, r5
	mov r1, r4
	bl ovl08_2163CC4
	add r4, r4, #1
	cmp r4, r6
	add r5, r5, #1
	blt _02163E88
_02163EA4:
	cmp r6, #0
	mov r4, #0
	ble _02163ECC
_02163EB0:
	mov r0, r7
	mov r1, r4
	bl ovl08_2163C38
	add r4, r4, #1
	cmp r4, r6
	add r7, r7, #1
	blt _02163EB0
_02163ECC:
	ldr r0, _02163EEC // =0x0217E894
	ldr r0, [r0]
	ldr r0, [r0, #0xc]
	bl ovl08_2175B20
	bl ovl08_2163B78
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02163EE8: .word 0x0217E890
_02163EEC: .word 0x0217E894
	arm_func_end ovl08_2163E3C

	arm_func_start ovl08_2163EF0
ovl08_2163EF0: // 0x02163EF0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, _021640F4 // =0x0217E894
	mov r0, #1
	ldr r1, [r1]
	ldr r1, [r1, #0x3c]
	bl ovl08_2177864
	mov r5, #0
	ldr r4, _021640F4 // =0x0217E894
_02163F4C:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _02163F64
	bl ovl08_21770F8
_02163F64:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x24]
	cmp r0, #0
	beq _02163F7C
	bl ovl08_21770F8
_02163F7C:
	add r5, r5, #1
	cmp r5, #5
	blt _02163F4C
	ldr r0, _021640F4 // =0x0217E894
	ldr r0, [r0]
	ldr r0, [r0, #0xc]
	bl sub_2175D98
	bl ovl08_216E660
	bl ovl08_215A8A0
	bl ovl08_215A4D8
	bl ovl08_216DFD0
	ldr r0, _021640F4 // =0x0217E894
	ldr r0, [r0]
	ldr r0, [r0, #4]
	bl ovl08_2174AB8
	ldr r0, _021640F4 // =0x0217E894
	ldr r0, [r0]
	ldr r0, [r0, #8]
	bl ovl08_2174AB8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x1d
	bl ovl08_217661C
	mov r2, #0
	ldr r1, _021640F8 // =0x04000010
	ldr r0, _021640FC // =0x04000018
	str r2, [r1]
	str r2, [r0]
	ldr r0, _021640F4 // =0x0217E894
	ldr r2, [r0]
	ldrb r0, [r2, #0x54]
	cmp r0, #0
	bne _02164030
	bl ovl08_216EC58
	bl ovl08_216F84C
	ldrb r0, [r0, #0xf4]
	bl ovl08_216F30C
	mov r0, #2
	mov r1, #0
	bl ovl08_215E674
	ldr r0, _02164100 // =ovl08_216C5AC
	bl DWCi_ChangeScene
	b _021640E4
_02164030:
	ldr r0, _02164104 // =0x0217E88C
	ldrb r0, [r0]
	cmp r0, #4
	bne _0216405C
	bl ovl08_216EC58
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02164108 // =ovl08_216AF88
	bl DWCi_ChangeScene
	b _021640E4
_0216405C:
	ldrb r1, [r2, #0x52]
	ldr r2, [r2]
	mov r0, #0x2a
	mla r0, r1, r0, r2
	bl ovl08_216F7EC
	mov r0, #0
	mov r1, r0
	bl ovl08_215E674
	ldr r1, _021640F4 // =0x0217E894
	mov r0, #0x2a
	ldr r2, [r1]
	ldrb r1, [r2, #0x52]
	ldr r2, [r2]
	mla r0, r1, r0, r2
	ldrb r0, [r0, #0x28]
	cmp r0, #0
	beq _021640C4
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	mov r0, #1
	mov r1, r0
	bl ovl08_215E638
	ldr r0, _0216410C // =ovl08_2165878
	bl DWCi_ChangeScene
	b _021640E4
_021640C4:
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	mov r0, #0
	mov r1, #1
	bl ovl08_215E638
	ldr r0, _02164110 // =ovl08_216D064
	bl DWCi_ChangeScene
_021640E4:
	ldr r0, _021640F4 // =0x0217E894
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_021640F4: .word 0x0217E894
_021640F8: .word 0x04000010
_021640FC: .word 0x04000018
_02164100: .word ovl08_216C5AC
_02164104: .word 0x0217E88C
_02164108: .word ovl08_216AF88
_0216410C: .word ovl08_2165878
_02164110: .word ovl08_216D064
	arm_func_end ovl08_2163EF0

	arm_func_start ovl08_2164114
ovl08_2164114: // 0x02164114
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02164188 // =0x0217E894
	ldr r0, [r0]
	ldrb r0, [r0, #0x54]
	cmp r0, #0
	beq _0216414C
	bl ovl08_215A3AC
	b _02164150
_0216414C:
	bl ovl08_215A308
_02164150:
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x1d
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216418C // =ovl08_2163EF0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02164188: .word 0x0217E894
_0216418C: .word ovl08_2163EF0
	arm_func_end ovl08_2164114

	arm_func_start ovl08_2164190
ovl08_2164190: // 0x02164190
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _021641B4 // =ovl08_2164114
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021641B4: .word ovl08_2164114
	arm_func_end ovl08_2164190

	arm_func_start ovl08_21641B8
ovl08_21641B8: // 0x021641B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021642E0 // =0x0217E894
	ldr r1, [r0]
	ldr r0, [r1, #0x38]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldrb r0, [r1, #0x57]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A398
	cmp r0, #0
	beq _02164204
	cmp r0, #1
	beq _02164210
	add sp, sp, #4
	ldmia sp!, {pc}
_02164204:
	mov r0, #7
	bl ovl08_216F934
	b _021642D0
_02164210:
	ldr r0, _021642E4 // =0x0217E88C
	ldrb r0, [r0]
	cmp r0, #4
	bne _02164240
	ldr r0, _021642E0 // =0x0217E894
	mov r2, #1
	ldr r1, [r0]
	mov r0, #6
	strb r2, [r1, #0x54]
	bl ovl08_216F934
	bl ovl08_2163668
	b _021642D0
_02164240:
	ldr r0, _021642E8 // =0x0217E890
	mov r1, #0x1c
	ldrh r0, [r0]
	bl FX_DivS32
	ldr r1, _021642E4 // =0x0217E88C
	ldr r2, _021642E0 // =0x0217E894
	ldrb lr, [r1]
	ldr ip, [r2]
	mov r1, #0x2a
	ldr r3, [ip]
	add lr, lr, r0
	mla r0, lr, r1, r3
	ldrb r0, [r0, #0x28]
	cmp r0, #2
	bne _021642B8
	mov r0, #9
	bl ovl08_216F934
	bl ovl08_216E5FC
	bl ovl08_215A308
	mov r1, #1
	mov r0, #0
	str r0, [sp]
	mov r2, r1
	mov r0, #0xe
	mvn r3, #0
	bl ovl08_21715E4
	ldr r0, _021642EC // =ovl08_2163630
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_021642B8:
	mov r0, #1
	strb r0, [ip, #0x54]
	ldr r1, [r2]
	mov r0, #6
	strb lr, [r1, #0x52]
	bl ovl08_216F934
_021642D0:
	ldr r0, _021642F0 // =ovl08_2164190
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021642E0: .word 0x0217E894
_021642E4: .word 0x0217E88C
_021642E8: .word 0x0217E890
_021642EC: .word ovl08_2163630
_021642F0: .word ovl08_2164190
	arm_func_end ovl08_21641B8

	arm_func_start ovl08_21642F4
ovl08_21642F4: // 0x021642F4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021645A4 // =0x0217E894
	ldr r1, [r0]
	ldr r0, [r1, #0x38]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldrb r0, [r1, #0x55]
	cmp r0, #0
	subne r0, r0, #1
	strneb r0, [r1, #0x55]
	bl ovl08_216E638
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _0216459C
_02164334: // jump table
	b _0216459C // case 0
	b _02164354 // case 1
	b _02164370 // case 2
	b _021643CC // case 3
	b _0216448C // case 4
	b _0216458C // case 5
	b _02164504 // case 6
	b _0216458C // case 7
_02164354:
	ldr r0, _021645A4 // =0x0217E894
	mov r1, #1
	ldr r0, [r0]
	strb r1, [r0, #0x57]
	bl ovl08_215A308
	add sp, sp, #4
	ldmia sp!, {pc}
_02164370:
	ldr r0, _021645A4 // =0x0217E894
	ldr r0, [r0]
	ldrb r0, [r0, #0x55]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A8A0
	bl ovl08_216E64C
	ldr r1, _021645A4 // =0x0217E894
	ldr r1, [r1]
	ldrh r2, [r1, #0x40]
	ldrb r1, [r1, #0x53]
	mul r0, r2, r0
	bl FX_DivS32
	ldr r1, _021645A8 // =0x0217E890
	strh r0, [r1]
	bl ovl08_2163E3C
	ldr r0, _021645A4 // =0x0217E894
	mov r1, #4
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x55]
	ldmia sp!, {pc}
_021643CC:
	ldr r0, _021645A4 // =0x0217E894
	mov r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x57]
	bl ovl08_215A320
	bl ovl08_216E64C
	ldr r1, _021645A4 // =0x0217E894
	ldr r1, [r1]
	ldrh r2, [r1, #0x40]
	ldrb r1, [r1, #0x53]
	mul r0, r2, r0
	bl FX_DivS32
	ldr r1, _021645A8 // =0x0217E890
	strh r0, [r1]
	mov r0, #0x13
	bl ovl08_216F934
	bl ovl08_2163E3C
	ldr r0, _021645A8 // =0x0217E890
	mov r1, #0x1c
	ldrh r0, [r0]
	bl FX_ModS32
	cmp r0, #0
	bne _02164434
	bl ovl08_2163930
	add sp, sp, #4
	ldmia sp!, {pc}
_02164434:
	cmp r0, #0xe
	bge _02164464
	mov r0, #0
	ldr r1, _021645AC // =ovl08_2163A9C
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _021645A4 // =0x0217E894
	add sp, sp, #4
	ldr r1, [r1]
	str r0, [r1, #0x38]
	ldmia sp!, {pc}
_02164464:
	mov r0, #0
	ldr r1, _021645B0 // =ovl08_21639FC
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _021645A4 // =0x0217E894
	add sp, sp, #4
	ldr r1, [r1]
	str r0, [r1, #0x38]
	ldmia sp!, {pc}
_0216448C:
	ldr r0, _021645A8 // =0x0217E890
	ldrh r0, [r0]
	cmp r0, #0
	bne _021644D4
	ldr r0, _021645A4 // =0x0217E894
	ldr r0, [r0]
	ldrb r0, [r0, #0x58]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _021645A4 // =0x0217E894
	mov r1, #1
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x58]
	ldmia sp!, {pc}
_021644D4:
	mov r0, #0x13
	bl ovl08_216F934
	mov r0, #0
	ldr r1, _021645AC // =ovl08_2163A9C
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _021645A4 // =0x0217E894
	add sp, sp, #4
	ldr r1, [r1]
	str r0, [r1, #0x38]
	ldmia sp!, {pc}
_02164504:
	ldr r0, _021645A4 // =0x0217E894
	ldr r2, [r0]
	ldrb r0, [r2, #0x51]
	cmp r0, #4
	bls _0216452C
	ldr r0, _021645A8 // =0x0217E890
	ldrh r1, [r2, #0x40]
	ldrh r0, [r0]
	cmp r0, r1
	bne _0216455C
_0216452C:
	ldrb r0, [r2, #0x58]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _021645A4 // =0x0217E894
	mov r1, #1
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x58]
	ldmia sp!, {pc}
_0216455C:
	mov r0, #0x13
	bl ovl08_216F934
	mov r0, #0
	ldr r1, _021645B0 // =ovl08_21639FC
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _021645A4 // =0x0217E894
	add sp, sp, #4
	ldr r1, [r1]
	str r0, [r1, #0x38]
	ldmia sp!, {pc}
_0216458C:
	ldr r0, _021645A4 // =0x0217E894
	mov r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x58]
_0216459C:
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021645A4: .word 0x0217E894
_021645A8: .word 0x0217E890
_021645AC: .word ovl08_2163A9C
_021645B0: .word ovl08_21639FC
	arm_func_end ovl08_21642F4

	arm_func_start ovl08_21645B4
ovl08_21645B4: // 0x021645B4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _02164828 // =0x0217E894
	ldr r1, [r0]
	ldr r0, [r1, #0x38]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	ldrb r0, [r1, #0x57]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	ldr r0, _0216482C // =0x0217B024
	bl ovl08_2176A38
	cmp r0, #0
	beq _0216465C
	ldr r0, _02164828 // =0x0217E894
	mvn r1, #0
	ldr r0, [r0]
	ldr r4, _02164830 // =0x0217AAC0
	strb r1, [r0, #0x50]
	mov r5, #0
_0216460C:
	mov r0, r4
	bl ovl08_2176A38
	cmp r0, #0
	beq _0216464C
	cmp r5, #4
	ldrlt r0, _02164828 // =0x0217E894
	ldrlt r0, [r0]
	strltb r5, [r0, #0x50]
	blt _0216465C
	mov r0, #1
	bl ovl08_215A378
	ldr r0, _02164834 // =0x0217E88C
	strb r5, [r0]
	bl ovl08_2163930
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0216464C:
	add r5, r5, #1
	cmp r5, #5
	add r4, r4, #8
	blo _0216460C
_0216465C:
	ldr r0, _0216482C // =0x0217B024
	bl ovl08_2176960
	cmp r0, #0
	beq _021646DC
	ldr r5, _02164830 // =0x0217AAC0
	mov r4, #0
_02164674:
	mov r0, r5
	bl ovl08_2176960
	cmp r0, #0
	beq _021646CC
	ldr r0, _02164828 // =0x0217E894
	ldr r1, [r0]
	ldrsb r0, [r1, #0x50]
	cmp r0, r4
	bne _021646DC
	ldrb r0, [r1, #0x51]
	cmp r4, r0
	blt _021646B0
	mov r0, #9
	bl ovl08_216F934
	b _021646DC
_021646B0:
	mov r0, #1
	bl ovl08_215A378
	ldr r0, _02164834 // =0x0217E88C
	strb r4, [r0]
	bl ovl08_2163930
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_021646CC:
	add r4, r4, #1
	cmp r4, #4
	add r5, r5, #8
	blt _02164674
_021646DC:
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	beq _02164700
	mov r0, #1
	bl ovl08_215A378
	bl ovl08_216E5FC
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02164700:
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	beq _02164720
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02164720:
	mov r0, #0x200
	bl ovl08_2176B34
	cmp r0, #0
	beq _0216473C
	bl ovl08_21636A4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0216473C:
	mov r0, #0x200
	bl ovl08_2176B10
	cmp r0, #0
	ldrne r0, _02164828 // =0x0217E894
	movne r1, #0
	ldrne r0, [r0]
	addne sp, sp, #4
	strneb r1, [r0, #0x59]
	ldmneia sp!, {r4, r5, pc}
	mov r0, #0x100
	bl ovl08_2176B34
	cmp r0, #0
	beq _0216477C
	bl ovl08_2163740
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0216477C:
	mov r0, #0x100
	bl ovl08_2176B10
	cmp r0, #0
	ldrne r0, _02164828 // =0x0217E894
	movne r1, #0
	ldrne r0, [r0]
	addne sp, sp, #4
	strneb r1, [r0, #0x59]
	ldmneia sp!, {r4, r5, pc}
	mov r0, #0x40
	bl ovl08_2176B34
	cmp r0, #0
	beq _021647C0
	mov r0, #1
	bl ovl08_21637CC
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_021647C0:
	mov r0, #0x40
	bl ovl08_2176B10
	cmp r0, #0
	ldrne r0, _02164828 // =0x0217E894
	movne r1, #0
	ldrne r0, [r0]
	addne sp, sp, #4
	strneb r1, [r0, #0x59]
	ldmneia sp!, {r4, r5, pc}
	mov r0, #0x80
	bl ovl08_2176B34
	cmp r0, #0
	beq _02164804
	mov r0, #3
	bl ovl08_21637CC
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02164804:
	mov r0, #0x80
	bl ovl08_2176B10
	cmp r0, #0
	ldrne r0, _02164828 // =0x0217E894
	movne r1, #0
	ldrne r0, [r0]
	strneb r1, [r0, #0x59]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02164828: .word 0x0217E894
_0216482C: .word 0x0217B024
_02164830: .word 0x0217AAC0
_02164834: .word 0x0217E88C
	arm_func_end ovl08_21645B4

	arm_func_start ovl08_2164838
ovl08_2164838: // 0x02164838
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21645B4
	bl ovl08_21642F4
	bl ovl08_21641B8
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2164838

	arm_func_start ovl08_2164854
ovl08_2164854: // 0x02164854
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _02164884 // =ovl08_2164838
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02164884: .word ovl08_2164838
	arm_func_end ovl08_2164854

	arm_func_start ovl08_2164888
ovl08_2164888: // 0x02164888
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_215A770
	ldr r0, _021648D0 // =ovl08_2164854
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021648D0: .word ovl08_2164854
	arm_func_end ovl08_2164888

	arm_func_start ovl08_21648D4
ovl08_21648D4: // 0x021648D4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x1d
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x1d
	bl ovl08_2176678
	ldr r0, _0216492C // =ovl08_2164888
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216492C: .word ovl08_2164888
	arm_func_end ovl08_21648D4

	arm_func_start ovl08_2164930
ovl08_2164930: // 0x02164930
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r0, _02164AA4 // =0x0217E894
	mov r9, #0
	ldr r0, [r0]
	ldrb r4, [r0, #0x51]
	cmp r4, #5
	movgt r4, #5
	cmp r4, #0
	ble _021649AC
	ldr r1, _02164AA8 // =0x0217AA84
	ldr r0, _02164AAC // =0x0217AA88
	ldrb r8, [r1]
	ldrb r7, [r0]
	ldr r10, _02164AA4 // =0x0217E894
	mov r6, r9
	mov r5, r9
_02164970:
	mov r0, r6
	mov r1, r8
	bl ovl08_2175570
	ldr r2, [r10]
	mov r1, r7
	add r2, r2, r9, lsl #2
	str r0, [r2, #0x10]
	mov r0, r5
	bl ovl08_2175570
	ldr r1, [r10]
	add r1, r1, r9, lsl #2
	add r9, r9, #1
	str r0, [r1, #0x24]
	cmp r9, r4
	blt _02164970
_021649AC:
	ldr r7, _02164AA8 // =0x0217AA84
	mov r6, #0
	ldr r9, _02164AA4 // =0x0217E894
	mov r5, r6
	ldr r8, _02164AB0 // =0x000003FF
_021649C0:
	ldr r0, [r9]
	ldrb r1, [r7]
	ldr r2, [r0, #0x10]
	mov r0, r5
	bl ovl08_217559C
	ldr r0, [r9]
	add r7, r7, #1
	ldr r1, [r0, #0x10]
	add r0, r0, r6, lsl #1
	ldrh r1, [r1, #4]
	add r6, r6, #1
	cmp r6, #3
	and r1, r1, r8
	strh r1, [r0, #0x42]
	blo _021649C0
	ldr r7, _02164AAC // =0x0217AA88
	mov r6, #0
	ldr r9, _02164AA4 // =0x0217E894
	mov r5, r6
	ldr r8, _02164AB0 // =0x000003FF
_02164A10:
	ldr r0, [r9]
	ldrb r1, [r7]
	ldr r2, [r0, #0x24]
	mov r0, r5
	bl ovl08_217559C
	ldr r0, [r9]
	add r7, r7, #1
	ldr r1, [r0, #0x24]
	add r0, r0, r6, lsl #1
	ldrh r1, [r1, #4]
	add r6, r6, #1
	cmp r6, #4
	and r1, r1, r8
	strh r1, [r0, #0x48]
	blo _02164A10
	cmp r4, #0
	mov r0, #0
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r1, _02164AA4 // =0x0217E894
_02164A5C:
	ldr r2, [r1]
	add r2, r2, r0, lsl #2
	ldr r3, [r2, #0x10]
	ldrh r2, [r3, #4]
	bic r2, r2, #0xc00
	orr r2, r2, #0xc00
	strh r2, [r3, #4]
	ldr r2, [r1]
	add r2, r2, r0, lsl #2
	ldr r3, [r2, #0x24]
	add r0, r0, #1
	ldrh r2, [r3, #4]
	cmp r0, r4
	bic r2, r2, #0xc00
	orr r2, r2, #0xc00
	strh r2, [r3, #4]
	blt _02164A5C
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02164AA4: .word 0x0217E894
_02164AA8: .word 0x0217AA84
_02164AAC: .word 0x0217AA88
_02164AB0: .word 0x000003FF
	arm_func_end ovl08_2164930

	arm_func_start ovl08_2164AB4
ovl08_2164AB4: // 0x02164AB4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r2, _02164B58 // =0x0217E894
	mov r1, #0x1c
	ldr ip, [r2]
	mov r0, #0
	ldrb r3, [ip, #0x51]
	sub r3, r3, #4
	mul r1, r3, r1
	strh r1, [ip, #0x40]
	ldr r2, [r2]
	ldrb r1, [r2, #0x51]
	cmp r1, #4
	movls r4, r0
	strlsb r0, [r2, #0x53]
	bls _02164B10
	cmp r1, #8
	movls r1, #0x1f
	strlsb r1, [r2, #0x53]
	movls r4, #1
	movhi r1, #0x37
	strhib r1, [r2, #0x53]
	movhi r4, #2
_02164B10:
	cmp r4, #0
	beq _02164B38
	ldr r1, _02164B58 // =0x0217E894
	ldr r0, _02164B5C // =0x0217E890
	ldr r1, [r1]
	ldrh r2, [r0]
	ldrb r0, [r1, #0x53]
	ldrh r1, [r1, #0x40]
	mul r0, r2, r0
	bl FX_DivS32
_02164B38:
	str r0, [sp]
	mov r0, r4
	mov r1, #0x55
	mov r2, #0xec
	mov r3, #0x3f
	bl ovl08_216E6A0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164B58: .word 0x0217E894
_02164B5C: .word 0x0217E890
	arm_func_end ovl08_2164AB4

	arm_func_start ovl08_2164B60
ovl08_2164B60: // 0x02164B60
	stmdb sp!, {lr}
	sub sp, sp, #0x34
	ldr r3, _02164C94 // =aCharXb4aplistb
	add lr, sp, #0
	mov r2, #0xc
_02164B74:
	ldrb r1, [r3], #1
	ldrb r0, [r3], #1
	subs r2, r2, #1
	strb r1, [lr], #1
	strb r0, [lr], #1
	bne _02164B74
	ldrb r0, [r3]
	ldr ip, _02164C98 // =aCharYbbgstep31
	add r3, sp, #0x19
	strb r0, [lr]
	mov r2, #0xb
_02164BA0:
	ldrb r1, [ip], #1
	ldrb r0, [ip], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _02164BA0
	ldr r0, _02164C9C // =aCharJb4aplistN
	ldr r1, _02164CA0 // =GX_LoadBG3Scr
	bl ovl08_215A7F8
	add r0, sp, #0
	bl ovl08_215A840
	mov r1, #0
	mov r2, #4
	bl ovl08_2174AF4
	ldr r1, _02164CA4 // =0x0217E894
	ldr r2, [r1]
	str r0, [r2, #4]
	ldr r0, [r1]
	ldr r0, [r0, #4]
	bl ovl08_216E000
	bl ovl08_216DFB8
	add r0, sp, #0x19
	bl ovl08_215A840
	mov r1, #0
	mov r2, #4
	bl ovl08_2174AF4
	ldr r1, _02164CA4 // =0x0217E894
	ldr r2, _02164CA8 // =0x04001008
	ldr r1, [r1]
	ldr lr, _02164CAC // =0x0400100A
	str r0, [r1, #8]
	ldrh r0, [r2]
	ldr ip, _02164CB0 // =0x04000008
	ldr r3, _02164CB4 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [lr]
	ldr r2, _02164CB8 // =0x0400000C
	ldr r1, _02164CBC // =0x0400000E
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [lr]
	ldrh r0, [ip]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #2
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #2
	strh r0, [r1]
	add sp, sp, #0x34
	ldmia sp!, {pc}
	.align 2, 0
_02164C94: .word aCharXb4aplistb
_02164C98: .word aCharYbbgstep31
_02164C9C: .word aCharJb4aplistN
_02164CA0: .word GX_LoadBG3Scr
_02164CA4: .word 0x0217E894
_02164CA8: .word 0x04001008
_02164CAC: .word 0x0400100A
_02164CB0: .word 0x04000008
_02164CB4: .word 0x0400000A
_02164CB8: .word 0x0400000C
_02164CBC: .word 0x0400000E
	arm_func_end ovl08_2164B60

	arm_func_start ovl08_2164CC0
ovl08_2164CC0: // 0x02164CC0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0x5c
	mov r1, #4
	bl ovl08_2176764
	ldr r2, _02164D94 // =0x0217E894
	mov r1, #0
	str r0, [r2]
	add r0, sp, #0
	bl ovl08_215E610
	ldr r0, [sp]
	cmp r0, #0
	ldreq r0, _02164D98 // =0x0217E890
	moveq r2, #0
	streqh r2, [r0]
	ldr r0, _02164D94 // =0x0217E894
	ldreq r1, _02164D9C // =0x0217E88C
	ldr r0, [r0]
	streqb r2, [r1]
	bl ovl08_216EA24
	ldr r1, _02164D94 // =0x0217E894
	ldr r1, [r1]
	strb r0, [r1, #0x51]
	bl ovl08_2164B60
	bl ovl08_215AB30
	mov r0, #0x34
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	mov r0, #2
	bl ovl08_215A7A8
	bl ovl08_2164AB4
	bl ovl08_2164930
	mov r0, #0
	mov r1, r0
	bl ovl08_2175F00
	ldr r2, _02164D94 // =0x0217E894
	ldr r1, _02164DA0 // =ovl08_2163984
	ldr r3, [r2]
	mov r2, #0
	str r0, [r3, #0xc]
	mov r0, #1
	mov r3, #0x6e
	bl ovl08_2177924
	ldr r1, _02164D94 // =0x0217E894
	ldr r1, [r1]
	str r0, [r1, #0x3c]
	bl ovl08_2163E3C
	bl ovl08_2163930
	ldr r0, _02164DA4 // =ovl08_21648D4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02164D94: .word 0x0217E894
_02164D98: .word 0x0217E890
_02164D9C: .word 0x0217E88C
_02164DA0: .word ovl08_2163984
_02164DA4: .word ovl08_21648D4
	arm_func_end ovl08_2164CC0

	arm_func_start ovl08_2164DA8
ovl08_2164DA8: // 0x02164DA8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02164DEC // =0x0217E898
	ldr r1, _02164DF0 // =0xC1FFFCFF
	ldr r2, [r0]
	ldr r0, _02164DF4 // =ovl08_21656B8
	ldr r3, [r2, #4]
	ldr r2, [r3]
	and r1, r2, r1
	str r1, [r3]
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02164DEC: .word 0x0217E898
_02164DF0: .word 0xC1FFFCFF
_02164DF4: .word ovl08_21656B8
	arm_func_end ovl08_2164DA8

	arm_func_start ovl08_2164DF8
ovl08_2164DF8: // 0x02164DF8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_2171598
	ldr r0, _02164E2C // =ovl08_2164DA8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02164E2C: .word ovl08_2164DA8
	arm_func_end ovl08_2164DF8

	arm_func_start ovl08_2164E30
ovl08_2164E30: // 0x02164E30
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	add r0, sp, #0
	add r1, sp, #4
	bl ovl08_215E610
	ldr r0, [sp, #4]
	cmp r0, #1
	bne _02164E60
	mov r0, #0x35
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
_02164E60:
	add r0, sp, #0
	add r1, sp, #4
	bl ovl08_215E610
	ldr r0, [sp]
	cmp r0, #0
	bne _02164E98
	ldr r0, _02164FC8 // =0x0217E898
	add sp, sp, #0xc
	ldr r0, [r0]
	ldrb r0, [r0, #8]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {pc}
_02164E98:
	ldr r0, [sp, #4]
	cmp r0, #1
	bne _02164EC0
	ldr r0, _02164FC8 // =0x0217E898
	ldr r0, [r0]
	ldrb r0, [r0, #8]
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {pc}
_02164EC0:
	ldr r0, _02164FC8 // =0x0217E898
	mov r1, #0x20
	ldr r0, [r0]
	add r0, r0, #8
	bl ovl08_2177504
	cmp r0, #0x10
	bgt _02164F20
	cmp r0, #0xa
	blt _02164F00
	cmp r0, #0xa
	beq _02164F4C
	cmp r0, #0xd
	beq _02164F40
	cmp r0, #0x10
	beq _02164F40
	b _02164FBC
_02164F00:
	cmp r0, #0
	bgt _02164F14
	cmp r0, #0
	beq _02164F40
	b _02164FBC
_02164F14:
	cmp r0, #5
	beq _02164F40
	b _02164FBC
_02164F20:
	cmp r0, #0x1a
	bgt _02164F34
	cmp r0, #0x1a
	beq _02164F4C
	b _02164FBC
_02164F34:
	cmp r0, #0x20
	beq _02164F4C
	b _02164FBC
_02164F40:
	add sp, sp, #0xc
	mov r0, #1
	ldmia sp!, {pc}
_02164F4C:
	cmp r0, #0
	mov r3, #0
	ble _02164FB0
	ldr r1, _02164FC8 // =0x0217E898
	ldr r1, [r1]
_02164F60:
	ldrb r2, [r1, #8]
	cmp r2, #0x30
	blo _02164F74
	cmp r2, #0x39
	bls _02164FA0
_02164F74:
	cmp r2, #0x41
	blo _02164F84
	cmp r2, #0x46
	bls _02164FA0
_02164F84:
	cmp r2, #0x61
	blo _02164F94
	cmp r2, #0x66
	bls _02164FA0
_02164F94:
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {pc}
_02164FA0:
	add r3, r3, #1
	cmp r3, r0
	add r1, r1, #1
	blt _02164F60
_02164FB0:
	add sp, sp, #0xc
	mov r0, #1
	ldmia sp!, {pc}
_02164FBC:
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_02164FC8: .word 0x0217E898
	arm_func_end ovl08_2164E30

	arm_func_start ovl08_2164FCC
ovl08_2164FCC: // 0x02164FCC
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r0, _02165068 // =0x0217AB24
	ldr r1, [r0]
	ldr r0, [r0, #4]
	str r1, [sp]
	str r0, [sp, #4]
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {pc}
	ldr r0, _0216506C // =0x0217E898
	ldr r1, [r0]
	ldrb r0, [r1, #0x2a]
	cmp r0, #0
	bne _02165030
	ldr r3, [r1, #4]
	ldr r1, _02165070 // =0xC1FFFCFF
	ldr r2, [r3]
	ldr r0, _02165074 // =ovl08_21656B8
	and r1, r2, r1
	str r1, [r3]
	bl DWCi_ChangeScene
	add sp, sp, #0xc
	ldmia sp!, {pc}
_02165030:
	add r0, sp, #8
	mov r1, #0
	bl ovl08_215E610
	ldr r0, _0216506C // =0x0217E898
	ldr r2, [sp, #8]
	add r1, sp, #0
	ldr r0, [r0]
	ldr r1, [r1, r2, lsl #2]
	add r0, r0, #8
	blx r1
	ldr r0, _02165078 // =ovl08_2165270
	bl DWCi_ChangeScene
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_02165068: .word 0x0217AB24
_0216506C: .word 0x0217E898
_02165070: .word 0xC1FFFCFF
_02165074: .word ovl08_21656B8
_02165078: .word ovl08_2165270
	arm_func_end ovl08_2164FCC

	arm_func_start ovl08_216507C
ovl08_216507C: // 0x0216507C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	ldr r1, _021650DC // =0x0217E898
	ldr r2, [r1]
	strb r0, [r2, #0x2a]
	ldr r0, [r1]
	ldrb r0, [r0, #0x2a]
	cmp r0, #0
	beq _021650B4
	cmp r0, #1
	beq _021650C0
	add sp, sp, #4
	ldmia sp!, {pc}
_021650B4:
	mov r0, #7
	bl ovl08_216F934
	b _021650C8
_021650C0:
	mov r0, #0xe
	bl ovl08_216F934
_021650C8:
	bl ovl08_2171598
	ldr r0, _021650E0 // =ovl08_2164FCC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021650DC: .word 0x0217E898
_021650E0: .word ovl08_2164FCC
	arm_func_end ovl08_216507C

	arm_func_start ovl08_21650E4
ovl08_21650E4: // 0x021650E4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216514C // =0x0217E898
	ldr r1, [r0]
	ldrb r0, [r1, #0x29]
	ldr lr, [r1, #4]
	ldr r1, _02165150 // =0x0217AB2C
	cmp r0, #0x20
	and r3, r0, #0xf
	mov r2, r0, asr #4
	movhs r3, #0xf
	ldrb ip, [r1, r3]
	ldr r0, _02165154 // =0x0217AB14
	movhs r2, #1
	ldrb r2, [r0, r2]
	ldr r3, [lr]
	ldr r1, _02165158 // =0xFE00FF00
	ldr r0, _0216515C // =0x000001FF
	and r1, r3, r1
	and r2, r2, #0xff
	and r3, ip, r0
	orr r0, r1, r2
	orr r0, r0, r3, lsl #16
	str r0, [lr]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216514C: .word 0x0217E898
_02165150: .word 0x0217AB2C
_02165154: .word 0x0217AB14
_02165158: .word 0xFE00FF00
_0216515C: .word 0x000001FF
	arm_func_end ovl08_21650E4

	arm_func_start ovl08_2165160
ovl08_2165160: // 0x02165160
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	add r0, sp, #0x10
	mov r1, #0
	strh r1, [r0]
	strh r1, [r0, #2]
	strh r1, [r0, #4]
	strh r1, [r0, #6]
	ldr r2, _0216525C // =0x0217AB14
	ldr r0, _02165260 // =0x0217AB18
	ldrb r4, [r2]
	ldrh r3, [r0]
	ldrh r2, [r0, #2]
	ldr r0, _02165264 // =0x0217E898
	strh r4, [sp, #0x12]
	ldr r0, [r0]
	strh r3, [sp, #0x14]
	strh r2, [sp, #0x16]
	ldr r0, [r0]
	bl ovl08_2175BE8
	mov r9, #0
	ldr r0, _0216525C // =0x0217AB14
	ldr r6, _02165268 // =0x0000E01D
	ldrb r8, [r0, #1]
	ldr r11, _0216526C // =0x0217AB2C
	mov r10, r9
	strh r9, [sp, #0x1a]
	mov r7, r9
	mov r5, #2
	mov r4, #0x480
_021651D8:
	ldr r0, _02165264 // =0x0217E898
	cmp r9, #0x10
	ldr r0, [r0]
	moveq r10, r7
	streqh r8, [sp, #0x12]
	add r1, r0, r9
	ldrb r1, [r1, #8]
	ldrb r2, [r11, r10]
	cmp r1, #0x20
	streqh r6, [sp, #0x18]
	strneh r1, [sp, #0x18]
	ldrh r1, [sp, #0x16]
	strh r2, [sp, #0x10]
	str r1, [sp]
	str r5, [sp, #4]
	str r4, [sp, #8]
	add r1, sp, #0x18
	str r1, [sp, #0xc]
	ldrh r1, [sp, #0x10]
	ldrh r2, [sp, #0x12]
	ldrh r3, [sp, #0x14]
	ldr r0, [r0]
	bl ovl08_2175C00
	add r9, r9, #1
	cmp r9, #0x20
	add r10, r10, #1
	blt _021651D8
	ldr r0, _02165264 // =0x0217E898
	ldr r0, [r0]
	ldr r0, [r0]
	bl ovl08_2175B20
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216525C: .word 0x0217AB14
_02165260: .word 0x0217AB18
_02165264: .word 0x0217E898
_02165268: .word 0x0000E01D
_0216526C: .word 0x0217AB2C
	arm_func_end ovl08_2165160

	arm_func_start ovl08_2165270
ovl08_2165270: // 0x02165270
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	bl ovl08_215A4D8
	ldr r0, _0216535C // =0x0217E898
	ldr r0, [r0]
	ldr r0, [r0, #4]
	bl ovl08_21770F8
	mov r0, #0
	bl ovl08_2175D6C
	ldr r0, _02165360 // =aCharYbobjmainN_2
	ldr r1, _02165364 // =GX_LoadOBJPltt
	bl ovl08_215A7F8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	add r0, sp, #0
	add r1, sp, #4
	bl ovl08_215E610
	ldr r0, [sp, #4]
	cmp r0, #0
	bne _021652F4
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r1, [sp]
	mov r0, #0
	bl ovl08_215E638
	ldr r0, _02165368 // =ovl08_2169434
	bl DWCi_ChangeScene
	b _0216534C
_021652F4:
	ldr r0, _0216535C // =0x0217E898
	ldr r0, [r0]
	ldrb r0, [r0, #0x2a]
	cmp r0, #0
	bne _0216532C
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	mov r0, #1
	mov r1, #0
	bl ovl08_215E638
	ldr r0, _0216536C // =ovl08_2164CC0
	bl DWCi_ChangeScene
	b _0216534C
_0216532C:
	mov r0, #0
	mov r1, r0
	bl ovl08_215E674
	mov r0, #0
	mov r1, #1
	bl ovl08_215E638
	ldr r0, _02165370 // =ovl08_216D064
	bl DWCi_ChangeScene
_0216534C:
	ldr r0, _0216535C // =0x0217E898
	bl ovl08_2176714
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0216535C: .word 0x0217E898
_02165360: .word aCharYbobjmainN_2
_02165364: .word GX_LoadOBJPltt
_02165368: .word ovl08_2169434
_0216536C: .word ovl08_2164CC0
_02165370: .word ovl08_216D064
	arm_func_end ovl08_2165270

	arm_func_start ovl08_2165374
ovl08_2165374: // 0x02165374
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	ldr r0, _02165438 // =0x0217AB1C
	ldr r1, [r0]
	ldr r0, [r0, #4]
	str r1, [sp, #4]
	str r0, [sp, #8]
	bl ovl08_215C84C
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {pc}
	ldr r0, _0216543C // =0x0217E898
	ldr r0, [r0]
	ldrb r0, [r0, #0x2a]
	cmp r0, #0
	bne _021653C4
	ldr r0, _02165440 // =ovl08_2165270
	bl DWCi_ChangeScene
	add sp, sp, #0x14
	ldmia sp!, {pc}
_021653C4:
	cmp r0, #2
	bne _021653F8
	mov ip, #0
	mov r0, #6
	mov r1, #3
	mov r2, #1
	mvn r3, #0
	str ip, [sp]
	bl ovl08_21715E4
	ldr r0, _02165444 // =ovl08_2164DF8
	bl DWCi_ChangeScene
	add sp, sp, #0x14
	ldmia sp!, {pc}
_021653F8:
	add r1, sp, #0xc
	mov r0, #0
	bl ovl08_215E610
	mov r0, #0
	str r0, [sp]
	ldr r2, [sp, #0xc]
	add r0, sp, #4
	ldr r0, [r0, r2, lsl #2]
	mov r1, #2
	mov r2, #1
	mvn r3, #0
	bl ovl08_21715E4
	ldr r0, _02165448 // =ovl08_216507C
	bl DWCi_ChangeScene
	add sp, sp, #0x14
	ldmia sp!, {pc}
	.align 2, 0
_02165438: .word 0x0217AB1C
_0216543C: .word 0x0217E898
_02165440: .word ovl08_2165270
_02165444: .word ovl08_2164DF8
_02165448: .word ovl08_216507C
	arm_func_end ovl08_2165374

	arm_func_start ovl08_216544C
ovl08_216544C: // 0x0216544C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215C8A4
	mov r0, #0x15
	bl ovl08_216F934
	ldr r0, _02165484 // =ovl08_2165374
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02165484: .word ovl08_2165374
	arm_func_end ovl08_216544C

	arm_func_start ovl08_2165488
ovl08_2165488: // 0x02165488
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _021654A8 // =ovl08_216544C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021654A8: .word ovl08_216544C
	arm_func_end ovl08_2165488

	arm_func_start ovl08_21654AC
ovl08_21654AC: // 0x021654AC
	bx lr
	arm_func_end ovl08_21654AC

	arm_func_start ovl08_21654B0
ovl08_21654B0: // 0x021654B0
	stmdb sp!, {r4, lr}
	bl ovl08_215C890
	mov r4, r0
	cmp r4, #0x83
	bgt _021654F4
	cmp r4, #0x80
	blt _021654E8
	cmp r4, #0x80
	beq _02165500
	cmp r4, #0x82
	beq _02165564
	cmp r4, #0x83
	beq _02165588
	b _021655F4
_021654E8:
	cmp r4, #0
	beq _02165658
	b _021655F4
_021654F4:
	ldr r0, _02165664 // =0x0000E01D
	cmp r4, r0
	b _021655F4
_02165500:
	ldr r0, _02165668 // =0x0217E898
	ldr r0, [r0]
	ldrb r0, [r0, #0x29]
	cmp r0, #0
	beq _02165658
	mov r0, #3
	bl ovl08_216F934
	ldr r1, _02165668 // =0x0217E898
	mov r0, #0
	ldr r3, [r1]
	ldrb r2, [r3, #0x29]
	sub r2, r2, #1
	strb r2, [r3, #0x29]
	ldr r3, [r1]
	ldrb r2, [r3, #0x29]
	add r2, r3, r2
	strb r0, [r2, #8]
	ldr r1, [r1]
	ldrb r1, [r1, #0x29]
	cmp r1, #0
	bne _02165558
	bl ovl08_215C87C
_02165558:
	mov r0, #1
	bl ovl08_215C868
	b _02165658
_02165564:
	mov r0, #7
	bl ovl08_216F934
	ldr r1, _02165668 // =0x0217E898
	ldr r0, _0216566C // =ovl08_2165488
	ldr r1, [r1]
	mov r2, #0
	strb r2, [r1, #0x2a]
	bl DWCi_ChangeScene
	ldmia sp!, {r4, pc}
_02165588:
	bl ovl08_2164E30
	cmp r0, #0
	beq _021655B0
	mov r0, #6
	bl ovl08_216F934
	ldr r0, _02165668 // =0x0217E898
	mov r1, #1
	ldr r0, [r0]
	strb r1, [r0, #0x2a]
	b _021655C8
_021655B0:
	ldr r0, _02165668 // =0x0217E898
	mov r2, #2
	ldr r1, [r0]
	mov r0, #9
	strb r2, [r1, #0x2a]
	bl ovl08_216F934
_021655C8:
	ldr r0, _02165668 // =0x0217E898
	ldr r1, _02165670 // =0xC1FFFCFF
	ldr r2, [r0]
	ldr r0, _0216566C // =ovl08_2165488
	ldr r3, [r2, #4]
	ldr r2, [r3]
	and r1, r2, r1
	orr r1, r1, #0x200
	str r1, [r3]
	bl DWCi_ChangeScene
	ldmia sp!, {r4, pc}
_021655F4:
	ldr r0, _02165668 // =0x0217E898
	ldr r0, [r0]
	ldrb r0, [r0, #0x29]
	cmp r0, #0x20
	beq _02165658
	mov r0, #1
	bl ovl08_216F934
	ldr r1, _02165668 // =0x0217E898
	mov r0, #1
	ldr r3, [r1]
	ldrb r2, [r3, #0x29]
	add r2, r3, r2
	strb r4, [r2, #8]
	ldr r2, [r1]
	ldrb r1, [r2, #0x29]
	add r1, r1, #1
	strb r1, [r2, #0x29]
	bl ovl08_215C87C
	ldr r0, _02165668 // =0x0217E898
	ldr r0, [r0]
	ldrb r0, [r0, #0x29]
	cmp r0, #0x20
	bne _02165658
	mov r0, #0
	bl ovl08_215C868
_02165658:
	bl ovl08_2165160
	bl ovl08_21650E4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165664: .word 0x0000E01D
_02165668: .word 0x0217E898
_0216566C: .word ovl08_2165488
_02165670: .word 0xC1FFFCFF
	arm_func_end ovl08_21654B0

	arm_func_start ovl08_2165674
ovl08_2165674: // 0x02165674
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21654B0
	bl ovl08_21654AC
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2165674

	arm_func_start ovl08_216568C
ovl08_216568C: // 0x0216568C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215C890
	cmp r0, #0xff
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _021656B4 // =ovl08_2165674
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021656B4: .word ovl08_2165674
	arm_func_end ovl08_216568C

	arm_func_start ovl08_21656B8
ovl08_21656B8: // 0x021656B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215C8E0
	mov r0, #0x14
	bl ovl08_216F934
	ldr r0, _0216573C // =0x0217E898
	ldr r0, [r0]
	ldrb r0, [r0, #0x29]
	cmp r0, #0
	bne _02165710
	mov r0, #0
	bl ovl08_215C87C
_02165710:
	ldr r0, _0216573C // =0x0217E898
	ldr r0, [r0]
	ldrb r0, [r0, #0x29]
	cmp r0, #0x20
	bne _0216572C
	mov r0, #0
	bl ovl08_215C868
_0216572C:
	ldr r0, _02165740 // =ovl08_216568C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216573C: .word 0x0217E898
_02165740: .word ovl08_216568C
	arm_func_end ovl08_21656B8

	arm_func_start ovl08_2165744
ovl08_2165744: // 0x02165744
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _0216579C // =ovl08_21656B8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216579C: .word ovl08_21656B8
	arm_func_end ovl08_2165744

	arm_func_start ovl08_21657A0
ovl08_21657A0: // 0x021657A0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02165844 // =aCharYbobjkbNcl_0
	ldr r1, _02165848 // =GX_LoadOBJPltt
	bl ovl08_215A7F8
	ldr r0, _0216584C // =aCharJbbgstep3N
	ldr r1, _02165850 // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r0, _02165854 // =aCharYbbgstep3N
	ldr r1, _02165858 // =GX_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _0216585C // =aCharXb4editNsc
	ldr r1, _02165860 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _02165864 // =0x04001008
	ldr ip, _02165868 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _0216586C // =0x04000008
	ldr r2, _02165870 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _02165874 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #2
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02165844: .word aCharYbobjkbNcl_0
_02165848: .word GX_LoadOBJPltt
_0216584C: .word aCharJbbgstep3N
_02165850: .word GX_LoadBG2Char
_02165854: .word aCharYbbgstep3N
_02165858: .word GX_LoadBGPltt
_0216585C: .word aCharXb4editNsc
_02165860: .word GX_LoadBG2Scr
_02165864: .word 0x04001008
_02165868: .word 0x0400100A
_0216586C: .word 0x04000008
_02165870: .word 0x0400000A
_02165874: .word 0x0400000C
	arm_func_end ovl08_21657A0

	arm_func_start ovl08_2165878
ovl08_2165878: // 0x02165878
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r1, _021659A0 // =0x0217AB10
	mov r0, #0x2c
	ldrb r3, [r1]
	ldrb r2, [r1, #1]
	mov r1, #4
	strb r3, [sp]
	strb r2, [sp, #1]
	bl ovl08_2176764
	ldr r2, _021659A4 // =0x0217E898
	add r1, sp, #8
	str r0, [r2]
	add r0, sp, #4
	bl ovl08_215E610
	ldr r0, [sp, #4]
	cmp r0, #0
	bne _021658F0
	ldr r0, _021659A4 // =0x0217E898
	ldr r0, [r0]
	add r0, r0, #8
	bl ovl08_216F578
	ldr r0, _021659A4 // =0x0217E898
	mov r1, #0x20
	ldr r0, [r0]
	add r0, r0, #8
	bl ovl08_2177504
	ldr r1, _021659A4 // =0x0217E898
	ldr r1, [r1]
	strb r0, [r1, #0x29]
_021658F0:
	bl ovl08_21657A0
	ldr r0, [sp, #4]
	add r0, r0, #9
	bl ovl08_215AB50
	ldr r0, [sp, #8]
	cmp r0, #1
	bne _02165920
	mov r0, #0x35
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	b _02165938
_02165920:
	ldr r2, [sp, #4]
	add r0, sp, #0
	ldrb r0, [r0, r2]
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
_02165938:
	mov r0, #2
	bl ovl08_215A7A8
	mov r0, #0
	mov r1, r0
	bl ovl08_2175F00
	ldr r2, _021659A4 // =0x0217E898
	mov r1, #0x3e
	ldr r2, [r2]
	str r0, [r2]
	mov r0, #0
	bl ovl08_2175570
	ldr r1, _021659A4 // =0x0217E898
	ldr r2, [r1]
	str r0, [r2, #4]
	ldr r0, [r1]
	ldr r1, [r0, #4]
	ldrh r0, [r1, #4]
	bic r0, r0, #0xc00
	orr r0, r0, #0xc00
	strh r0, [r1, #4]
	bl ovl08_21650E4
	bl ovl08_2165160
	ldr r0, _021659A8 // =ovl08_2165744
	bl DWCi_ChangeScene
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_021659A0: .word 0x0217AB10
_021659A4: .word 0x0217E898
_021659A8: .word ovl08_2165744
	arm_func_end ovl08_2165878

	arm_func_start ovl08_21659AC
ovl08_21659AC: // 0x021659AC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _021659F0 // =0x0217E89C
	ldr r1, _021659F4 // =0xC1FFFCFF
	ldr r2, [r0]
	ldr r0, _021659F8 // =ovl08_2166460
	ldr r3, [r2, #4]
	ldr r2, [r3]
	and r1, r2, r1
	str r1, [r3]
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021659F0: .word 0x0217E89C
_021659F4: .word 0xC1FFFCFF
_021659F8: .word ovl08_2166460
	arm_func_end ovl08_21659AC

	arm_func_start ovl08_21659FC
ovl08_21659FC: // 0x021659FC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_2171598
	ldr r0, _02165A30 // =ovl08_21659AC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02165A30: .word ovl08_21659AC
	arm_func_end ovl08_21659FC

	arm_func_start ovl08_2165A34
ovl08_2165A34: // 0x02165A34
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	ldr r1, _02165B90 // =0x0217AB3C
	ldr r0, _02165B94 // =0x0217E89C
	ldrb lr, [r1]
	ldrb ip, [r1, #1]
	ldrb r4, [r1, #2]
	ldrb r3, [r1, #3]
	mov r2, #0
	strb lr, [sp]
	ldr r0, [r0]
	strb r4, [sp, #2]
	add r5, sp, #0
	mov r1, r2
	strb ip, [sp, #1]
	strb r3, [sp, #3]
	mov lr, r2
	add r4, r0, #8
_02165A7C:
	ldrb r3, [r4, r1]
	add r8, r4, r1
	cmp r3, #0x20
	beq _02165AC4
	mov r7, lr
	mov r6, r5
_02165A94:
	ldrb ip, [r8, r7]
	ldrb r3, [r6]
	cmp ip, r3
	addhi sp, sp, #0x10
	movhi r0, #0
	ldmhiia sp!, {r4, r5, r6, r7, r8, pc}
	cmp ip, r3
	blo _02165AC4
	add r7, r7, #1
	cmp r7, #3
	add r6, r6, #1
	blt _02165A94
_02165AC4:
	add r2, r2, #1
	cmp r2, #4
	add r1, r1, #3
	blt _02165A7C
	add r1, sp, #8
	add r0, r0, #8
	bl ovl08_216ECF0
	add r0, sp, #4
	mov r1, #0
	bl ovl08_215E610
	ldr r0, [sp, #4]
	cmp r0, #1
	bne _02165B74
	mov ip, #0
	add r6, sp, #8
	mov r5, ip
	mov r3, ip
	mov r2, #1
_02165B0C:
	mov r4, r3
_02165B10:
	cmp ip, #0
	beq _02165B38
	rsb r0, r4, #7
	ldrb r1, [r6]
	mov r0, r2, lsl r0
	ands r0, r1, r0
	beq _02165B4C
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02165B38:
	rsb r0, r4, #7
	ldrb r1, [r6]
	mov r0, r2, lsl r0
	ands r0, r1, r0
	moveq ip, r2
_02165B4C:
	add r4, r4, #1
	cmp r4, #8
	blt _02165B10
	add r5, r5, #1
	cmp r5, #4
	add r6, r6, #1
	blt _02165B0C
	add sp, sp, #0x10
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02165B74:
	add r0, sp, #8
	bl sub_208DC68
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02165B90: .word 0x0217AB3C
_02165B94: .word 0x0217E89C
	arm_func_end ovl08_2165A34

	arm_func_start ovl08_2165B98
ovl08_2165B98: // 0x02165B98
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, #0
	mov r4, r6
	ldr r0, _02165C20 // =0x0217E89C
	mov ip, r6
	mov r1, #0x20
	mov r2, #0x30
_02165BB8:
	ldr r3, [r0]
	mov r5, ip
	add r3, r3, #8
	add r7, r3, r4
_02165BC8:
	ldrb r3, [r7, r5]
	add lr, r7, r5
	cmp r3, #0x30
	beq _02165BE8
	cmp r3, #0x20
	beq _02165BE8
	cmp r3, #0
	bne _02165C04
_02165BE8:
	cmp r5, #2
	moveq r3, r2
	movne r3, r1
	add r5, r5, #1
	strb r3, [lr]
	cmp r5, #3
	blt _02165BC8
_02165C04:
	add r6, r6, #1
	cmp r6, #4
	add r4, r4, #3
	blt _02165BB8
	bl ovl08_2165DA0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02165C20: .word 0x0217E89C
	arm_func_end ovl08_2165B98

	arm_func_start ovl08_2165C24
ovl08_2165C24: // 0x02165C24
	stmdb sp!, {lr}
	sub sp, sp, #0x1c
	ldr lr, _02165CC4 // =0x0217AB74
	add ip, sp, #4
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r0, [lr]
	str r0, [ip]
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #0x1c
	ldmneia sp!, {pc}
	ldr r0, _02165CC8 // =0x0217E89C
	ldr r1, [r0]
	ldrb r0, [r1, #0x15]
	cmp r0, #0
	bne _02165C8C
	ldr r3, [r1, #4]
	ldr r1, _02165CCC // =0xC1FFFCFF
	ldr r2, [r3]
	ldr r0, _02165CD0 // =ovl08_2166460
	and r1, r2, r1
	str r1, [r3]
	bl DWCi_ChangeScene
	add sp, sp, #0x1c
	ldmia sp!, {pc}
_02165C8C:
	add r0, sp, #0
	mov r1, #0
	bl ovl08_215E610
	ldr r0, _02165CC8 // =0x0217E89C
	ldr r2, [sp]
	add r1, sp, #4
	ldr r0, [r0]
	ldr r1, [r1, r2, lsl #2]
	add r0, r0, #8
	blx r1
	ldr r0, _02165CD4 // =ovl08_2165E84
	bl DWCi_ChangeScene
	add sp, sp, #0x1c
	ldmia sp!, {pc}
	.align 2, 0
_02165CC4: .word 0x0217AB74
_02165CC8: .word 0x0217E89C
_02165CCC: .word 0xC1FFFCFF
_02165CD0: .word ovl08_2166460
_02165CD4: .word ovl08_2165E84
	arm_func_end ovl08_2165C24

	arm_func_start ovl08_2165CD8
ovl08_2165CD8: // 0x02165CD8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	ldr r1, _02165D38 // =0x0217E89C
	ldr r2, [r1]
	strb r0, [r2, #0x15]
	ldr r0, [r1]
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	beq _02165D10
	cmp r0, #1
	beq _02165D1C
	add sp, sp, #4
	ldmia sp!, {pc}
_02165D10:
	mov r0, #7
	bl ovl08_216F934
	b _02165D24
_02165D1C:
	mov r0, #0xe
	bl ovl08_216F934
_02165D24:
	bl ovl08_2171598
	ldr r0, _02165D3C // =ovl08_2165C24
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02165D38: .word 0x0217E89C
_02165D3C: .word ovl08_2165C24
	arm_func_end ovl08_2165CD8

	arm_func_start ovl08_2165D40
ovl08_2165D40: // 0x02165D40
	ldr r0, _02165D90 // =0x0217E89C
	ldr r2, [r0]
	mov r0, #3
	ldrb r3, [r2, #0x14]
	ldr ip, [r2, #4]
	cmp r3, #3
	movgt r3, #3
	mul r1, r3, r0
	ldr r0, _02165D94 // =0x0217AB54
	add r1, r1, #2
	ldrb r3, [r0, r1]
	ldr r0, _02165D98 // =0x000001FF
	ldr r2, [ip]
	ldr r1, _02165D9C // =0xFE00FF00
	and r3, r3, r0
	and r0, r2, r1
	orr r0, r0, #0x28
	orr r0, r0, r3, lsl #16
	str r0, [ip]
	bx lr
	.align 2, 0
_02165D90: .word 0x0217E89C
_02165D94: .word 0x0217AB54
_02165D98: .word 0x000001FF
_02165D9C: .word 0xFE00FF00
	arm_func_end ovl08_2165D40

	arm_func_start ovl08_2165DA0
ovl08_2165DA0: // 0x02165DA0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x1c
	ldr r0, _02165E74 // =0x0217AB4C
	ldr r1, _02165E78 // =0x0217AB40
	ldrh r4, [r0, #4]
	ldrh r3, [r0, #6]
	ldrh r6, [r0]
	ldrh r5, [r0, #2]
	ldr r0, _02165E7C // =0x0217E89C
	ldrh r2, [r1]
	strh r4, [sp, #0x14]
	ldrh r1, [r1, #2]
	strh r3, [sp, #0x16]
	ldr r0, [r0]
	strh r6, [sp, #0x10]
	strh r5, [sp, #0x12]
	strh r2, [sp, #0x14]
	strh r1, [sp, #0x16]
	ldr r0, [r0]
	mov r1, #0
	bl ovl08_2175BE8
	mov r5, #0
	ldr r4, _02165E80 // =0x0217AB54
	strh r5, [sp, #0x1a]
	ldr r6, _02165E7C // =0x0217E89C
	add r7, sp, #0x18
	mov r9, #2
	mov r8, #0x480
_02165E10:
	ldr ip, [r6]
	ldrh r0, [sp, #0x16]
	add r1, ip, r5
	ldrb r1, [r1, #8]
	strh r1, [sp, #0x18]
	ldrb r1, [r4]
	strh r1, [sp, #0x10]
	str r0, [sp]
	str r9, [sp, #4]
	str r8, [sp, #8]
	str r7, [sp, #0xc]
	ldrh r2, [sp, #0x12]
	ldrh r3, [sp, #0x14]
	ldr r0, [ip]
	bl ovl08_2175C00
	add r5, r5, #1
	cmp r5, #0xc
	add r4, r4, #1
	blt _02165E10
	ldr r0, _02165E7C // =0x0217E89C
	ldr r0, [r0]
	ldr r0, [r0]
	bl ovl08_2175B20
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02165E74: .word 0x0217AB4C
_02165E78: .word 0x0217AB40
_02165E7C: .word 0x0217E89C
_02165E80: .word 0x0217AB54
	arm_func_end ovl08_2165DA0

	arm_func_start ovl08_2165E84
ovl08_2165E84: // 0x02165E84
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A4D8
	ldr r0, _02165F1C // =0x0217E89C
	ldr r0, [r0]
	ldr r0, [r0, #4]
	bl ovl08_21770F8
	mov r0, #0
	bl ovl08_2175D6C
	ldr r0, _02165F20 // =aCharYbobjmainN_3
	ldr r1, _02165F24 // =GX_LoadOBJPltt
	bl ovl08_215A7F8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	add r0, sp, #0
	mov r1, #0
	bl ovl08_215E610
	ldr r0, [sp]
	mov r1, #1
	cmp r0, #3
	addge r0, r0, #1
	strge r0, [sp]
	mov r0, #2
	bl ovl08_215E674
	ldr r1, [sp]
	mov r0, #0
	add r1, r1, #3
	bl ovl08_215E638
	ldr r0, _02165F28 // =ovl08_2169434
	bl DWCi_ChangeScene
	ldr r0, _02165F1C // =0x0217E89C
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02165F1C: .word 0x0217E89C
_02165F20: .word aCharYbobjmainN_3
_02165F24: .word GX_LoadOBJPltt
_02165F28: .word ovl08_2169434
	arm_func_end ovl08_2165E84

	arm_func_start ovl08_2165F2C
ovl08_2165F2C: // 0x02165F2C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215DF40
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02165FC8 // =0x0217E89C
	ldr r0, [r0]
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _02165F68
	ldr r0, _02165FCC // =ovl08_2165E84
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02165F68:
	cmp r0, #2
	bne _02165F9C
	mov ip, #0
	mov r0, #6
	mov r1, #3
	mov r2, #1
	mvn r3, #0
	str ip, [sp]
	bl ovl08_21715E4
	ldr r0, _02165FD0 // =ovl08_21659FC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02165F9C:
	mov ip, #0
	mov r0, #0x47
	mov r1, #2
	mov r2, #1
	mvn r3, #0
	str ip, [sp]
	bl ovl08_21715E4
	ldr r0, _02165FD4 // =ovl08_2165CD8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02165FC8: .word 0x0217E89C
_02165FCC: .word ovl08_2165E84
_02165FD0: .word ovl08_21659FC
_02165FD4: .word ovl08_2165CD8
	arm_func_end ovl08_2165F2C

	arm_func_start ovl08_2165FD8
ovl08_2165FD8: // 0x02165FD8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215DFAC
	mov r0, #0x15
	bl ovl08_216F934
	ldr r0, _02166010 // =ovl08_2165F2C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02166010: .word ovl08_2165F2C
	arm_func_end ovl08_2165FD8

	arm_func_start ovl08_2166014
ovl08_2166014: // 0x02166014
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _02166034 // =ovl08_2165FD8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02166034: .word ovl08_2165FD8
	arm_func_end ovl08_2166014

	arm_func_start ovl08_2166038
ovl08_2166038: // 0x02166038
	bx lr
	arm_func_end ovl08_2166038

	arm_func_start ovl08_216603C
ovl08_216603C: // 0x0216603C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r2, _021660D4 // =0x0217E89C
	mov r1, #3
	ldr r2, [r2]
	mov r4, r0
	ldrb r0, [r2, #0x14]
	add r3, r2, #8
	mul r2, r0, r1
	ldrb r1, [r3, r2]
	add r0, r3, r2
	cmp r1, #0
	beq _02166080
	cmp r1, #0x20
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, pc}
_02166080:
	add r1, sp, #0
	mov r2, #3
	bl MI_CpuCopy8
	mov r3, #0
	add r2, sp, #0
	strb r3, [sp, #3]
	mov r0, #0x20
_0216609C:
	ldrb r1, [r2]
	cmp r1, #0
	bne _021660B8
	add r3, r3, #1
	cmp r3, #3
	strb r0, [r2], #1
	blt _0216609C
_021660B8:
	add r0, sp, #0
	bl atoi
	cmp r0, r4
	movge r0, #1
	movlt r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021660D4: .word 0x0217E89C
	arm_func_end ovl08_216603C

	arm_func_start ovl08_21660D8
ovl08_21660D8: // 0x021660D8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl ovl08_215DF98
	mov r4, r0
	cmp r4, #0
	bgt _02166100
	cmp r4, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	b _021662DC
_02166100:
	sub r0, r4, #0x10
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _021662DC
_02166110: // jump table
	b _02166128 // case 0
	b _021661D8 // case 1
	b _02166230 // case 2
	b _02166258 // case 3
	add sp, sp, #4 // case 4
	ldmia sp!, {r4, r5, pc} // case 5
_02166128:
	ldr r0, _02166410 // =0x0217E89C
	ldr r1, [r0]
	ldrb r0, [r1, #0x14]
	cmp r0, #0
	bne _02166148
	ldrb r0, [r1, #0xa]
	cmp r0, #0
	beq _02166400
_02166148:
	mov r0, #3
	bl ovl08_216F934
	ldr r1, _02166410 // =0x0217E89C
	mov r0, #3
	ldr r2, [r1]
	ldrb r1, [r2, #0x14]
	mul r0, r1, r0
	add r0, r0, #2
	add r0, r2, r0
	ldrb r0, [r0, #8]
	cmp r0, #0
	subeq r0, r1, #1
	streqb r0, [r2, #0x14]
	ldr r0, _02166410 // =0x0217E89C
	mov r2, #3
	ldr r0, [r0]
	mov r1, #0
	ldrb r3, [r0, #0x14]
	add r0, r0, #8
	mla r0, r3, r2, r0
	bl MI_CpuFill8
	ldr r0, _02166410 // =0x0217E89C
	ldr r1, [r0]
	ldrb r0, [r1, #0x14]
	cmp r0, #0
	bne _021661C4
	ldrb r0, [r1, #0xa]
	cmp r0, #0
	bne _021661C4
	mov r0, #0
	bl ovl08_215DF84
_021661C4:
	mov r0, #1
	bl ovl08_215DF70
	mov r0, #0
	bl ovl08_215DF5C
	b _02166400
_021661D8:
	ldr r0, _02166410 // =0x0217E89C
	ldr r2, [r0]
	ldrb r1, [r2, #0x14]
	cmp r1, #3
	bhs _02166400
	mov r0, #3
	mul r0, r1, r0
	add r0, r0, #2
	add r0, r2, r0
	ldrb r0, [r0, #8]
	cmp r0, #0
	beq _02166400
	mov r0, #1
	bl ovl08_216F934
	ldr r1, _02166410 // =0x0217E89C
	mov r0, #0
	ldr r2, [r1]
	ldrb r1, [r2, #0x14]
	add r1, r1, #1
	strb r1, [r2, #0x14]
	bl ovl08_215DF5C
	b _02166400
_02166230:
	ldr r0, _02166410 // =0x0217E89C
	mov r2, #0
	ldr r1, [r0]
	mov r0, #7
	strb r2, [r1, #0x15]
	bl ovl08_216F934
	ldr r0, _02166414 // =ovl08_2166014
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02166258:
	bl ovl08_2165A34
	cmp r0, #0
	beq _02166280
	mov r0, #6
	bl ovl08_216F934
	ldr r0, _02166410 // =0x0217E89C
	mov r1, #1
	ldr r0, [r0]
	strb r1, [r0, #0x15]
	b _02166298
_02166280:
	ldr r0, _02166410 // =0x0217E89C
	mov r2, #2
	ldr r1, [r0]
	mov r0, #9
	strb r2, [r1, #0x15]
	bl ovl08_216F934
_02166298:
	ldr r1, _02166410 // =0x0217E89C
	mov r3, #3
	ldr r2, [r1]
	ldr r0, _02166418 // =0xC1FFFCFF
	strb r3, [r2, #0x14]
	ldr r1, [r1]
	ldr r2, [r1, #4]
	ldr r1, [r2]
	and r0, r1, r0
	orr r0, r0, #0x200
	str r0, [r2]
	bl ovl08_2165D40
	bl ovl08_2165B98
	ldr r0, _02166414 // =ovl08_2166014
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_021662DC:
	ldr r0, _02166410 // =0x0217E89C
	ldr r0, [r0]
	ldrb r0, [r0, #0x14]
	cmp r0, #3
	bne _02166300
	mov r0, #0x1a
	bl ovl08_216603C
	cmp r0, #0
	bne _02166400
_02166300:
	mov r0, #1
	bl ovl08_216F934
	ldr r1, _02166410 // =0x0217E89C
	mov r0, #3
	ldr r3, [r1]
	ldrb r2, [r3, #0x14]
	add r5, r3, #8
	mul lr, r2, r0
	add r0, lr, #2
	ldrb r3, [r5, r0]
	add ip, r5, r0
	cmp r3, #0
	streqb r4, [ip]
	beq _021663A4
	add r2, lr, #1
	ldrb r0, [r5, r2]
	add r2, r5, r2
	cmp r0, #0
	bne _02166380
	strb r3, [r2]
	mov r0, #0x1a
	strb r4, [ip]
	bl ovl08_216603C
	cmp r0, #0
	beq _021663A4
	ldr r0, _02166410 // =0x0217E89C
	ldr r1, [r0]
	ldrb r0, [r1, #0x14]
	cmp r0, #3
	addlo r0, r0, #1
	strlob r0, [r1, #0x14]
	b _021663A4
_02166380:
	strb r0, [r5, lr]
	ldrb r0, [ip]
	strb r0, [r2]
	strb r4, [ip]
	ldr r1, [r1]
	ldrb r0, [r1, #0x14]
	cmp r0, #3
	addlo r0, r0, #1
	strlob r0, [r1, #0x14]
_021663A4:
	mov r0, #1
	bl ovl08_215DF84
	ldr r0, _02166410 // =0x0217E89C
	ldr r0, [r0]
	ldrb r0, [r0, #0x14]
	cmp r0, #3
	bhs _021663CC
	mov r0, #1
	bl ovl08_215DF5C
	b _021663D4
_021663CC:
	mov r0, #0
	bl ovl08_215DF5C
_021663D4:
	ldr r0, _02166410 // =0x0217E89C
	ldr r0, [r0]
	ldrb r0, [r0, #0x14]
	cmp r0, #3
	bne _02166400
	mov r0, #0x1a
	bl ovl08_216603C
	cmp r0, #0
	beq _02166400
	mov r0, #0
	bl ovl08_215DF70
_02166400:
	bl ovl08_2165DA0
	bl ovl08_2165D40
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02166410: .word 0x0217E89C
_02166414: .word ovl08_2166014
_02166418: .word 0xC1FFFCFF
	arm_func_end ovl08_21660D8

	arm_func_start ovl08_216641C
ovl08_216641C: // 0x0216641C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21660D8
	bl ovl08_2166038
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216641C

	arm_func_start ovl08_2166434
ovl08_2166434: // 0x02166434
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215DF98
	cmp r0, #0x1f
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _0216645C // =ovl08_216641C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216645C: .word ovl08_216641C
	arm_func_end ovl08_2166434

	arm_func_start ovl08_2166460
ovl08_2166460: // 0x02166460
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215DFE8
	mov r0, #0x14
	bl ovl08_216F934
	ldr r0, _021664F4 // =0x0217E89C
	ldr r0, [r0]
	ldrb r0, [r0, #0x14]
	cmp r0, #0
	bne _021664C4
	mov r0, #0
	bl ovl08_215DF84
	mov r0, #0
	bl ovl08_215DF5C
	b _021664E4
_021664C4:
	mov r0, #0x1a
	bl ovl08_216603C
	cmp r0, #0
	beq _021664DC
	mov r0, #0
	bl ovl08_215DF70
_021664DC:
	mov r0, #0
	bl ovl08_215DF5C
_021664E4:
	ldr r0, _021664F8 // =ovl08_2166434
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021664F4: .word 0x0217E89C
_021664F8: .word ovl08_2166434
	arm_func_end ovl08_2166460

	arm_func_start ovl08_21664FC
ovl08_21664FC: // 0x021664FC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _02166554 // =ovl08_2166460
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02166554: .word ovl08_2166460
	arm_func_end ovl08_21664FC

	arm_func_start ovl08_2166558
ovl08_2166558: // 0x02166558
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021665FC // =aCharYbobjkbNcl_1
	ldr r1, _02166600 // =GX_LoadOBJPltt
	bl ovl08_215A7F8
	ldr r0, _02166604 // =aCharJbbgstep3N_0
	ldr r1, _02166608 // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r0, _0216660C // =aCharYbbgstep3N_0
	ldr r1, _02166610 // =GX_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _02166614 // =aCharXb4editadd
	ldr r1, _02166618 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _0216661C // =0x04001008
	ldr ip, _02166620 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _02166624 // =0x04000008
	ldr r2, _02166628 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _0216662C // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #2
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021665FC: .word aCharYbobjkbNcl_1
_02166600: .word GX_LoadOBJPltt
_02166604: .word aCharJbbgstep3N_0
_02166608: .word GX_LoadBG2Char
_0216660C: .word aCharYbbgstep3N_0
_02166610: .word GX_LoadBGPltt
_02166614: .word aCharXb4editadd
_02166618: .word GX_LoadBG2Scr
_0216661C: .word 0x04001008
_02166620: .word 0x0400100A
_02166624: .word 0x04000008
_02166628: .word 0x0400000A
_0216662C: .word 0x0400000C
	arm_func_end ovl08_2166558

	arm_func_start ovl08_2166630
ovl08_2166630: // 0x02166630
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x24
	ldr r7, _02166790 // =0x0217AB60
	ldr ip, _02166794 // =aAbc
	ldmia r7!, {r0, r1, r2, r3}
	add r6, sp, #0xc
	stmia r6!, {r0, r1, r2, r3}
	ldrb r5, [ip]
	ldrb r4, [ip, #1]
	ldrb lr, [ip, #2]
	ldrb r3, [ip, #3]
	ldrb r2, [ip, #4]
	ldr ip, [r7]
	mov r0, #0x18
	mov r1, #4
	str ip, [r6]
	strb r5, [sp]
	strb r4, [sp, #1]
	strb lr, [sp, #2]
	strb r3, [sp, #3]
	strb r2, [sp, #4]
	bl ovl08_2176764
	ldr r2, _02166798 // =0x0217E89C
	mov r1, #0
	str r0, [r2]
	add r0, sp, #8
	bl ovl08_215E610
	ldr r0, _02166798 // =0x0217E89C
	ldr r2, [sp, #8]
	add r1, sp, #0xc
	ldr r0, [r0]
	ldr r1, [r1, r2, lsl #2]
	add r0, r0, #8
	blx r1
	ldr r0, _02166798 // =0x0217E89C
	ldr r1, _0216679C // =0x0217BAF4
	ldr r4, [r0]
	mov r2, #3
	add r0, r4, #8
	bl memcmp
	cmp r0, #0
	movne r0, #3
	strneb r0, [r4, #0x14]
	bne _02166700
	add r0, r4, #8
	mov r1, #0
	mov r2, #0xc
	bl MI_CpuFill8
	ldr r0, _02166798 // =0x0217E89C
	mov r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x14]
_02166700:
	bl ovl08_2166558
	ldr r0, [sp, #8]
	add r0, r0, #0xb
	bl ovl08_215AB50
	ldr r2, [sp, #8]
	add r0, sp, #0
	ldrb r0, [r0, r2]
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	mov r0, #2
	bl ovl08_215A7A8
	mov r0, #0
	mov r1, r0
	bl ovl08_2175F00
	ldr r2, _02166798 // =0x0217E89C
	mov r1, #0x3f
	ldr r2, [r2]
	str r0, [r2]
	mov r0, #0
	bl ovl08_2175570
	ldr r1, _02166798 // =0x0217E89C
	ldr r2, [r1]
	str r0, [r2, #4]
	ldr r0, [r1]
	ldr r1, [r0, #4]
	ldrh r0, [r1, #4]
	bic r0, r0, #0xc00
	orr r0, r0, #0xc00
	strh r0, [r1, #4]
	bl ovl08_2165D40
	bl ovl08_2165DA0
	ldr r0, _021667A0 // =ovl08_21664FC
	bl DWCi_ChangeScene
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02166790: .word 0x0217AB60
_02166794: .word aAbc
_02166798: .word 0x0217E89C
_0216679C: .word 0x0217BAF4
_021667A0: .word ovl08_21664FC
	arm_func_end ovl08_2166630

	arm_func_start ovl08_21667A4
ovl08_21667A4: // 0x021667A4
	ldr r1, _021667B0 // =0x0217E8A0
	str r0, [r1]
	bx lr
	.align 2, 0
_021667B0: .word 0x0217E8A0
	arm_func_end ovl08_21667A4

	arm_func_start ovl08_21667B4
ovl08_21667B4: // 0x021667B4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_2175D6C
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	add r1, sp, #0
	mov r0, #0
	bl ovl08_215E610
	ldr r0, [sp]
	cmp r0, #0
	beq _0216684C
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216687C // =ovl08_216BDFC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216684C:
	mov r0, #2
	mov r1, #0
	bl ovl08_215E674
	mov r0, #0
	mov r1, r0
	bl ovl08_215E638
	mov r0, #0
	bl ovl08_2166EDC
	ldr r0, _02166880 // =ovl08_2169434
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216687C: .word ovl08_216BDFC
_02166880: .word ovl08_2169434
	arm_func_end ovl08_21667B4

	arm_func_start ovl08_2166884
ovl08_2166884: // 0x02166884
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A3AC
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _021668DC // =ovl08_21667B4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021668DC: .word ovl08_21667B4
	arm_func_end ovl08_2166884

	arm_func_start ovl08_21668E0
ovl08_21668E0: // 0x021668E0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _02166904 // =ovl08_2166884
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02166904: .word ovl08_2166884
	arm_func_end ovl08_21668E0

	arm_func_start ovl08_2166908
ovl08_2166908: // 0x02166908
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	ldr r0, _02166938 // =ovl08_21668E0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02166938: .word ovl08_21668E0
	arm_func_end ovl08_2166908

	arm_func_start ovl08_216693C
ovl08_216693C: // 0x0216693C
	bx lr
	arm_func_end ovl08_216693C

	arm_func_start ovl08_2166940
ovl08_2166940: // 0x02166940
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2166940

	arm_func_start ovl08_216696C
ovl08_216696C: // 0x0216696C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2166940
	bl ovl08_216693C
	bl ovl08_2166908
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216696C

	arm_func_start ovl08_2166988
ovl08_2166988: // 0x02166988
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _021669B8 // =ovl08_216696C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021669B8: .word ovl08_216696C
	arm_func_end ovl08_2166988

	arm_func_start ovl08_21669BC
ovl08_21669BC: // 0x021669BC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #4
	bl ovl08_215A770
	ldr r0, _02166A04 // =ovl08_2166988
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02166A04: .word ovl08_2166988
	arm_func_end ovl08_21669BC

	arm_func_start ovl08_2166A08
ovl08_2166A08: // 0x02166A08
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _02166A40 // =ovl08_21669BC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02166A40: .word ovl08_21669BC
	arm_func_end ovl08_2166A08

	arm_func_start ovl08_2166A44
ovl08_2166A44: // 0x02166A44
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x28
	add r1, sp, #0x10
	mov r0, #0
	bl ovl08_215E610
	ldr r0, _02166D78 // =0x0217E8A0
	ldr r1, _02166D7C // =0xFFFFB17D
	ldr r0, [r0]
	cmp r0, r1
	movge r4, #0
	bge _02166CA0
	ldr r1, _02166D80 // =0xFFFFB17C
	cmp r0, r1
	movge r4, #2
	bge _02166CA0
	ldr r1, _02166D84 // =0xFFFFB17B
	cmp r0, r1
	movge r4, #0x13
	bge _02166CA0
	ldr r1, _02166D88 // =0xFFFFB175
	cmp r0, r1
	movge r4, #2
	bge _02166CA0
	ldr r1, _02166D8C // =0xFFFFB174
	cmp r0, r1
	movge r4, #0x12
	bge _02166CA0
	ldr r1, _02166D90 // =0xFFFFB173
	cmp r0, r1
	movge r4, #2
	bge _02166CA0
	ldr r1, _02166D94 // =0xFFFFB172
	cmp r0, r1
	movge r4, #3
	bge _02166CA0
	ldr r1, _02166D98 // =0xFFFFADF9
	cmp r0, r1
	movge r4, #2
	bge _02166CA0
	ldr r1, _02166D9C // =0xFFFFA629
	cmp r0, r1
	movge r4, #0
	bge _02166CA0
	ldr r1, _02166DA0 // =0xFFFFA241
	cmp r0, r1
	movge r4, #0x13
	bge _02166CA0
	ldr r1, _02166DA4 // =0xFFFF3CB1
	cmp r0, r1
	movge r4, #0
	bge _02166CA0
	ldr r1, _02166DA8 // =0xFFFF3CAE
	cmp r0, r1
	movge r4, #7
	bge _02166CA0
	ldr r1, _02166DAC // =0xFFFF3CAD
	cmp r0, r1
	movge r4, #5
	bge _02166CA0
	ldr r1, _02166DB0 // =0xFFFF3C4E
	cmp r0, r1
	movge r4, #0
	bge _02166CA0
	ldr r1, _02166DB4 // =0xFFFF3C4D
	cmp r0, r1
	blt _02166B60
	ldr r0, [sp, #0x10]
	cmp r0, #2
	moveq r4, #5
	movne r4, #7
	b _02166CA0
_02166B60:
	ldr r1, _02166DB8 // =0xFFFF3866
	cmp r0, r1
	movge r4, #0
	bge _02166CA0
	ldr r1, _02166DBC // =0xFFFF3865
	cmp r0, r1
	blt _02166B90
	ldr r0, [sp, #0x10]
	cmp r0, #2
	moveq r4, #5
	movne r4, #8
	b _02166CA0
_02166B90:
	ldr r1, _02166DC0 // =0xFFFF3862
	cmp r0, r1
	movge r4, #9
	bge _02166CA0
	ldr r1, _02166DC4 // =0xFFFF3861
	cmp r0, r1
	movge r4, #5
	bge _02166CA0
	ldr r1, _02166DC8 // =0xFFFF3801
	cmp r0, r1
	movge r4, #0
	bge _02166CA0
	ldr r1, _02166DCC // =0xFFFF379D
	cmp r0, r1
	movge r4, #0x14
	bge _02166CA0
	ldr r1, _02166DD0 // =0xFFFF379A
	cmp r0, r1
	movge r4, #0x15
	bge _02166CA0
	ldr r1, _02166DD4 // =0xFFFF3799
	cmp r0, r1
	movge r4, #4
	bge _02166CA0
	ldr r1, _02166DD8 // =0xFFFF34E1
	cmp r0, r1
	movge r4, #0
	bge _02166CA0
	ldr r1, _02166DDC // =0xFFFF34DE
	cmp r0, r1
	movge r4, #0xa
	bge _02166CA0
	ldr r1, _02166DE0 // =0xFFFF34DD
	cmp r0, r1
	movge r4, #0x16
	bge _02166CA0
	ldr r1, _02166DE4 // =0xFFFF347D
	cmp r0, r1
	movge r4, #0
	bge _02166CA0
	ldr r1, _02166DE8 // =0xFFFF3479
	cmp r0, r1
	movge r4, #0xb
	bge _02166CA0
	ldr r1, _02166DEC // =0xFFFF3419
	cmp r0, r1
	movge r4, #0
	bge _02166CA0
	ldr r1, _02166DF0 // =0xFFFF3415
	cmp r0, r1
	movge r4, #0xb
	bge _02166CA0
	ldr r1, _02166DF4 // =0xFFFF33B5
	cmp r0, r1
	movge r4, #0
	bge _02166CA0
	ldr r1, _02166DF8 // =0xFFFF3351
	cmp r0, r1
	movge r4, #2
	bge _02166CA0
	ldr r1, _02166DFC // =0xFFFF30F9
	cmp r0, r1
	movge r4, #0
	bge _02166CA0
	ldr r1, _02166E00 // =0xFFFF2FCD
	cmp r0, r1
	movge r4, #2
	movlt r4, #0
_02166CA0:
	bl ovl08_215E600
	mov r2, r0
	ldr r1, _02166E04 // =0x0217AB88
	mov r0, #0
	ldrb r1, [r1, r2]
	bl ovl08_2175F00
	ldr r1, _02166E08 // =0x0217E83C
	mov r5, r0
	ldr r0, [r1]
	mov r1, r4
	bl ovl08_215EC54
	ldr r1, _02166D78 // =0x0217E8A0
	mov r4, r0
	ldr r1, [r1]
	ldr r2, _02166E0C // =0x0217BAF8
	rsb r3, r1, #0
	add r0, sp, #0x14
	mov r1, #8
	bl swprintf
	bl ovl08_215E600
	mov r1, r0, lsl #2
	ldr r0, _02166E10 // =0x0217AB9A
	ldrh r6, [r0, r1]
	bl ovl08_215E600
	mov r1, r0, lsl #2
	ldr r0, _02166E14 // =0x0217AB98
	mov ip, #0xa
	ldrh r1, [r0, r1]
	add r3, sp, #0x14
	mov r0, #0
	str ip, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	mov r2, r6
	mov r0, r5
	mov r3, #2
	bl ovl08_2175C38
	bl ovl08_215A60C
	ldr r3, _02166E18 // =0x0217AB90
	mov r1, #2
	ldrh r2, [r3, #6]
	str r2, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	ldrh r1, [r3]
	ldrh r2, [r3, #2]
	ldrh r3, [r3, #4]
	mov r0, r5
	bl ovl08_2175C00
	mov r0, r5
	bl ovl08_2175B20
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02166D78: .word 0x0217E8A0
_02166D7C: .word 0xFFFFB17D
_02166D80: .word 0xFFFFB17C
_02166D84: .word 0xFFFFB17B
_02166D88: .word 0xFFFFB175
_02166D8C: .word 0xFFFFB174
_02166D90: .word 0xFFFFB173
_02166D94: .word 0xFFFFB172
_02166D98: .word 0xFFFFADF9
_02166D9C: .word 0xFFFFA629
_02166DA0: .word 0xFFFFA241
_02166DA4: .word 0xFFFF3CB1
_02166DA8: .word 0xFFFF3CAE
_02166DAC: .word 0xFFFF3CAD
_02166DB0: .word 0xFFFF3C4E
_02166DB4: .word 0xFFFF3C4D
_02166DB8: .word 0xFFFF3866
_02166DBC: .word 0xFFFF3865
_02166DC0: .word 0xFFFF3862
_02166DC4: .word 0xFFFF3861
_02166DC8: .word 0xFFFF3801
_02166DCC: .word 0xFFFF379D
_02166DD0: .word 0xFFFF379A
_02166DD4: .word 0xFFFF3799
_02166DD8: .word 0xFFFF34E1
_02166DDC: .word 0xFFFF34DE
_02166DE0: .word 0xFFFF34DD
_02166DE4: .word 0xFFFF347D
_02166DE8: .word 0xFFFF3479
_02166DEC: .word 0xFFFF3419
_02166DF0: .word 0xFFFF3415
_02166DF4: .word 0xFFFF33B5
_02166DF8: .word 0xFFFF3351
_02166DFC: .word 0xFFFF30F9
_02166E00: .word 0xFFFF2FCD
_02166E04: .word 0x0217AB88
_02166E08: .word 0x0217E83C
_02166E0C: .word 0x0217BAF8
_02166E10: .word 0x0217AB9A
_02166E14: .word 0x0217AB98
_02166E18: .word 0x0217AB90
	arm_func_end ovl08_2166A44

	arm_func_start ovl08_2166E1C
ovl08_2166E1C: // 0x02166E1C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02166E9C // =aCharJb4errorNs
	ldr r1, _02166EA0 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _02166EA4 // =0x04001008
	ldr ip, _02166EA8 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _02166EAC // =0x04000008
	ldr r2, _02166EB0 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _02166EB4 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02166E9C: .word aCharJb4errorNs
_02166EA0: .word GX_LoadBG2Scr
_02166EA4: .word 0x04001008
_02166EA8: .word 0x0400100A
_02166EAC: .word 0x04000008
_02166EB0: .word 0x0400000A
_02166EB4: .word 0x0400000C
	arm_func_end ovl08_2166E1C

	arm_func_start ovl08_2166EB8
ovl08_2166EB8: // 0x02166EB8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2166E1C
	bl ovl08_2166A44
	ldr r0, _02166ED8 // =ovl08_2166A08
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02166ED8: .word ovl08_2166A08
	arm_func_end ovl08_2166EB8

	arm_func_start ovl08_2166EDC
ovl08_2166EDC: // 0x02166EDC
	ldr r1, _02166EE8 // =0x0217E8A8
	strb r0, [r1]
	bx lr
	.align 2, 0
_02166EE8: .word 0x0217E8A8
	arm_func_end ovl08_2166EDC

	arm_func_start ovl08_2166EEC
ovl08_2166EEC: // 0x02166EEC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02166F14 // =ovl08_216910C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02166F14: .word ovl08_216910C
	arm_func_end ovl08_2166EEC

	arm_func_start ovl08_2166F18
ovl08_2166F18: // 0x02166F18
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_2171598
	ldr r0, _02166F5C // =0x0217E8B4
	ldr r0, [r0]
	ldr r0, [r0, #0xc]
	bl ovl08_216DE68
	ldr r0, _02166F60 // =ovl08_2166EEC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02166F5C: .word 0x0217E8B4
_02166F60: .word ovl08_2166EEC
	arm_func_end ovl08_2166F18

	arm_func_start ovl08_2166F64
ovl08_2166F64: // 0x02166F64
	stmdb sp!, {r4, lr}
	bl ovl08_216F84C
	mov r4, r0
	ldrb r0, [r4, #0x40]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldrb r0, [r4, #0xf6]
	cmp r0, #0
	bne _02166FB0
	add r0, r4, #0xc8
	bl sub_208DC68
	cmp r0, #0
	bne _02166FB0
	add r0, r4, #0xcc
	bl sub_208DC68
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
_02166FB0:
	ldrb r0, [r4, #0xf5]
	cmp r0, #0
	bne _02166FFC
	add r0, r4, #0xc0
	bl sub_208DC68
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0xc4
	bl sub_208DC68
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0xc0
	add r1, r4, #0xf0
	bl sub_208DC94
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
_02166FFC:
	mov r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end ovl08_2166F64

	arm_func_start ovl08_2167004
ovl08_2167004: // 0x02167004
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _021670B8 // =0x0217ABB8
	ldr r0, _021670BC // =0x0217E8A4
	ldrb ip, [r1]
	ldrb r3, [r1, #1]
	ldrb r2, [r1, #2]
	ldrb r1, [r1, #3]
	strb ip, [sp]
	ldrb lr, [r0]
	add r4, sp, #0
	strb r3, [sp, #1]
	strb r2, [sp, #2]
	strb r1, [sp, #3]
	mov ip, #0
_02167040:
	ldrb r0, [r4]
	cmp lr, r0
	bne _021670A0
	ldr r0, _021670C0 // =0x0217E8B4
	mov r3, #0x14
	ldr r2, [r0]
	ands r1, ip, #1
	add r1, r2, ip
	strb r3, [r1, #4]
	beq _02167084
	ldr r1, [r0]
	sub r0, ip, #1
	add r0, r1, r0
	mov r1, #0
	strb r1, [r0, #4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02167084:
	ldr r1, [r0]
	add r0, ip, #1
	add r0, r1, r0
	mov r1, #0
	strb r1, [r0, #4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_021670A0:
	add ip, ip, #1
	cmp ip, #4
	add r4, r4, #1
	blt _02167040
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021670B8: .word 0x0217ABB8
_021670BC: .word 0x0217E8A4
_021670C0: .word 0x0217E8B4
	arm_func_end ovl08_2167004

	arm_func_start ovl08_21670C4
ovl08_21670C4: // 0x021670C4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r5, _0216711C // =0x0217E8B4
	mov r4, #0
_021670D4:
	ldr r0, [r5]
	add r1, r0, r4
	ldrb r0, [r1, #4]
	cmp r0, #0
	beq _02167108
	sub r0, r0, #1
	strb r0, [r1, #4]
	ldr r0, [r5]
	add r0, r0, r4
	ldrb r0, [r0, #4]
	cmp r0, #0
	bne _02167108
	bl ovl08_2168474
_02167108:
	add r4, r4, #1
	cmp r4, #4
	blt _021670D4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216711C: .word 0x0217E8B4
	arm_func_end ovl08_21670C4

	arm_func_start ovl08_2167120
ovl08_2167120: // 0x02167120
	ldr r1, _0216714C // =0x0217E8A4
	ldr r0, _02167150 // =0x0217E8B4
	ldrb r2, [r1]
	ldr r0, [r0]
	ldr r1, _02167154 // =0x0217ABB4
	sub r2, r2, #0xb
	ldrb r1, [r1, r2]
	ldr ip, _02167158 // =ovl08_216DEC4
	ldr r0, [r0, #0x10]
	mov r2, r1
	bx ip
	.align 2, 0
_0216714C: .word 0x0217E8A4
_02167150: .word 0x0217E8B4
_02167154: .word 0x0217ABB4
_02167158: .word ovl08_216DEC4
	arm_func_end ovl08_2167120

	arm_func_start ovl08_216715C
ovl08_216715C: // 0x0216715C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl ovl08_216F84C
	ldr r1, _02167488 // =0x0217E8A4
	mov r4, #0
	ldrb r2, [r1]
	cmp r2, #8
	bne _021671A4
	ldrb r0, [r0, #0xf5]
	cmp r0, #0
	bne _021671A4
	cmp r5, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	cmp r5, #2
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
_021671A4:
	cmp r2, #0
	bgt _021671B8
	cmp r2, #0
	beq _021671D8
	b _02167360
_021671B8:
	sub r0, r2, #0xa
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02167360
_021671C8: // jump table
	b _02167208 // case 0
	b _02167244 // case 1
	b _021672BC // case 2
	b _021672BC // case 3
_021671D8:
	cmp r5, #1
	ldreq r0, _02167488 // =0x0217E8A4
	moveq r1, #0xb
	streqb r1, [r0]
	beq _0216745C
	cmp r5, #3
	ldreq r0, _0216748C // =0x0217E8AC
	movne r4, #2
	ldreqb r1, [r0]
	addeq r1, r1, #1
	streqb r1, [r0]
	b _0216745C
_02167208:
	cmp r5, #1
	ldreq r0, _0216748C // =0x0217E8AC
	ldreqb r1, [r0]
	subeq r1, r1, #1
	streqb r1, [r0]
	beq _0216745C
	cmp r5, #3
	movne r4, #2
	bne _0216745C
	ldr r1, _02167490 // =0x0217E8B4
	ldr r0, _02167488 // =0x0217E8A4
	ldr r1, [r1]
	ldrb r1, [r1, #0x42]
	strb r1, [r0]
	b _0216745C
_02167244:
	cmp r5, #1
	bne _02167284
	ldr r0, _02167490 // =0x0217E8B4
	ldr r0, [r0]
	ldrb r0, [r0, #0x47]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _02167490 // =0x0217E8B4
	mov r1, #1
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x47]
	ldmia sp!, {r4, r5, pc}
_02167284:
	cmp r5, #3
	movne r4, #2
	bne _0216745C
	ldr r2, _02167488 // =0x0217E8A4
	mov r3, #0
	ldr r1, _0216748C // =0x0217E8AC
	ldr r0, _02167494 // =0x0217E8B0
	strb r3, [r2]
	strb r3, [r1]
	strh r3, [r0]
	bl ovl08_2168474
	mov r0, #0
	bl ovl08_216E62C
	b _0216745C
_021672BC:
	ldr r0, _02167490 // =0x0217E8B4
	cmp r5, #1
	ldr r1, [r0]
	strb r2, [r1, #0x42]
	bne _02167304
	ldr r2, _02167488 // =0x0217E8A4
	mov ip, #0xa
	ldr r1, _0216748C // =0x0217E8AC
	mov r5, #3
	ldr r0, _02167494 // =0x0217E8B0
	mov r3, #0x91
	strb ip, [r2]
	strb r5, [r1]
	strh r3, [r0]
	bl ovl08_2168474
	mov r0, #0x37
	bl ovl08_216E62C
	b _0216745C
_02167304:
	cmp r5, #3
	bne _02167340
	ldr r0, [r0]
	ldrb r0, [r0, #0x47]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _02167490 // =0x0217E8B4
	mov r1, #1
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x47]
	ldmia sp!, {r4, r5, pc}
_02167340:
	cmp r2, #0xc
	ldreq r0, _02167488 // =0x0217E8A4
	moveq r1, #0xd
	streqb r1, [r0]
	ldrne r0, _02167488 // =0x0217E8A4
	movne r1, #0xc
	strneb r1, [r0]
	b _0216745C
_02167360:
	cmp r5, #1
	bne _021673B0
	ldr r0, _0216748C // =0x0217E8AC
	ldrb r1, [r0]
	cmp r1, #0
	subne r1, r1, #1
	strneb r1, [r0]
	bne _0216745C
	mov r0, #0x13
	bl ovl08_216F934
	mov r0, #0
	ldr r1, _02167498 // =ovl08_21677D0
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _02167490 // =0x0217E8B4
	add sp, sp, #4
	ldr r1, [r1]
	str r0, [r1, #0x38]
	ldmia sp!, {r4, r5, pc}
_021673B0:
	cmp r5, #3
	bne _02167400
	ldr r0, _0216748C // =0x0217E8AC
	ldrb r1, [r0]
	cmp r1, #3
	addlo r1, r1, #1
	strlob r1, [r0]
	blo _0216745C
	mov r0, #0x13
	bl ovl08_216F934
	mov r0, #0
	ldr r1, _0216749C // =ovl08_2167724
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _02167490 // =0x0217E8B4
	add sp, sp, #4
	ldr r1, [r1]
	str r0, [r1, #0x38]
	ldmia sp!, {r4, r5, pc}
_02167400:
	cmp r2, #2
	ldreq r0, _02167488 // =0x0217E8A4
	moveq r1, #3
	mov r4, #2
	streqb r1, [r0]
	beq _02167450
	cmp r2, #3
	ldreq r0, _02167488 // =0x0217E8A4
	streqb r4, [r0]
	beq _02167450
	cmp r2, #7
	ldreq r0, _02167488 // =0x0217E8A4
	moveq r1, #8
	streqb r1, [r0]
	beq _02167450
	cmp r2, #8
	bne _0216745C
	ldr r0, _02167488 // =0x0217E8A4
	mov r1, #7
	strb r1, [r0]
_02167450:
	mov r0, #8
	bl ovl08_216F934
	bl ovl08_21675A8
_0216745C:
	cmp r4, #2
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	mov r0, #8
	bl ovl08_216F934
	cmp r4, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	bl ovl08_21674DC
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02167488: .word 0x0217E8A4
_0216748C: .word 0x0217E8AC
_02167490: .word 0x0217E8B4
_02167494: .word 0x0217E8B0
_02167498: .word ovl08_21677D0
_0216749C: .word ovl08_2167724
	arm_func_end ovl08_216715C

	arm_func_start ovl08_21674A0
ovl08_21674A0: // 0x021674A0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _021674D0 // =0x0217E8A4
	ldr r2, _021674D4 // =0x0217ABF4
	strb r0, [r1]
	ldrb r0, [r2, r0]
	bl ovl08_21678DC
	ldr r1, _021674D8 // =0x0217E8AC
	strb r0, [r1]
	bl ovl08_21675A8
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021674D0: .word 0x0217E8A4
_021674D4: .word 0x0217ABF4
_021674D8: .word 0x0217E8AC
	arm_func_end ovl08_21674A0

	arm_func_start ovl08_21674DC
ovl08_21674DC: // 0x021674DC
	stmdb sp!, {r4, lr}
	ldr r0, _02167598 // =0x0217E8A4
	ldrb r0, [r0]
	add r0, r0, #0xf5
	and r0, r0, #0xff
	cmp r0, #2
	bhi _02167500
	bl ovl08_21675A8
	ldmia sp!, {r4, pc}
_02167500:
	bl ovl08_216F84C
	ldr r1, _0216759C // =0x0217E8B0
	mov r4, r0
	ldrh r0, [r1]
	mov r1, #0x1d
	bl FX_DivS32
	ldr r1, _021675A0 // =0x0217E8AC
	ldrb r1, [r1]
	add r2, r1, r0
	cmp r2, #2
	beq _02167538
	cmp r2, #6
	beq _0216755C
	b _02167580
_02167538:
	ldrb r0, [r4, #0xf5]
	cmp r0, #0
	ldrne r0, _02167598 // =0x0217E8A4
	movne r1, #2
	strneb r1, [r0]
	ldreq r0, _02167598 // =0x0217E8A4
	moveq r1, #3
	streqb r1, [r0]
	b _02167590
_0216755C:
	ldrb r0, [r4, #0xf6]
	cmp r0, #0
	ldrne r0, _02167598 // =0x0217E8A4
	movne r1, #7
	strneb r1, [r0]
	ldreq r0, _02167598 // =0x0217E8A4
	moveq r1, #8
	streqb r1, [r0]
	b _02167590
_02167580:
	ldr r1, _021675A4 // =0x0217ABDC
	ldr r0, _02167598 // =0x0217E8A4
	ldrb r1, [r1, r2]
	strb r1, [r0]
_02167590:
	bl ovl08_21675A8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167598: .word 0x0217E8A4
_0216759C: .word 0x0217E8B0
_021675A0: .word 0x0217E8AC
_021675A4: .word 0x0217ABDC
	arm_func_end ovl08_21674DC

	arm_func_start ovl08_21675A8
ovl08_21675A8: // 0x021675A8
	stmdb sp!, {lr}
	sub sp, sp, #0x1c
	ldr ip, _02167678 // =0x0217AC00
	add r3, sp, #8
	mov r2, #7
_021675BC:
	ldrb r1, [ip], #1
	ldrb r0, [ip], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _021675BC
	ldr r0, _0216767C // =0x0217E8A4
	add r1, sp, #8
	ldrb r0, [r0]
	ldrb r2, [r1, r0]
	cmp r2, #3
	blt _02167618
	mov r3, r2, lsl #3
	ldr r1, _02167680 // =0x0217AC94
	ldr r2, _02167684 // =0x0217AC98
	ldr r0, _02167688 // =0x0217AC96
	ldrh r1, [r1, r3]
	ldrh r2, [r2, r3]
	ldrh r3, [r0, r3]
	mov r0, #3
	bl ovl08_215A9CC
	add sp, sp, #0x1c
	ldmia sp!, {pc}
_02167618:
	ldr r0, _02167680 // =0x0217AC94
	mov r1, r2, lsl #3
	add lr, r0, r2, lsl #3
	ldrh ip, [r0, r1]
	ldrh r1, [lr, #2]
	ldr r0, _0216768C // =0x0217E8AC
	ldrh r3, [lr, #4]
	strh r1, [sp, #2]
	ldrh r2, [sp, #2]
	ldrb r1, [r0]
	mov r0, #0x1d
	strh ip, [sp]
	mla r0, r1, r0, r2
	strh r3, [sp, #4]
	strh r0, [sp, #2]
	ldrh ip, [lr, #6]
	ldrh r1, [sp]
	ldrh r2, [sp, #4]
	ldrh r3, [sp, #2]
	mov r0, #1
	strh ip, [sp, #6]
	bl ovl08_215A9CC
	add sp, sp, #0x1c
	ldmia sp!, {pc}
	.align 2, 0
_02167678: .word 0x0217AC00
_0216767C: .word 0x0217E8A4
_02167680: .word 0x0217AC94
_02167684: .word 0x0217AC98
_02167688: .word 0x0217AC96
_0216768C: .word 0x0217E8AC
	arm_func_end ovl08_21675A8

	arm_func_start ovl08_2167690
ovl08_2167690: // 0x02167690
	stmdb sp!, {r4, lr}
	ldr r0, _0216770C // =0x0217E8B4
	ldr r0, [r0]
	ldrb r0, [r0, #0x44]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _02167710 // =0x0217E8B0
	mov r1, #0x1d
	ldrh r0, [r0]
	bl FX_DivS32
	ldr r1, _02167710 // =0x0217E8B0
	mov r4, r0
	ldrh r0, [r1]
	mov r1, #0x1d
	bl FX_ModS32
	ldr r1, _02167714 // =0x01FF0000
	sub ip, r0, #0x33
	ldr r2, _02167718 // =0x04000010
	and r3, r1, ip, lsl #16
	ldr r0, _0216771C // =0x0217ABE8
	str r3, [r2]
	ldrb r3, [r0, r4]
	ldr r2, _02167720 // =0x04000018
	ldr r0, _0216770C // =0x0217E8B4
	add r3, ip, r3
	and r1, r1, r3, lsl #16
	str r1, [r2]
	ldr r0, [r0]
	mov r1, #0
	strb r1, [r0, #0x44]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216770C: .word 0x0217E8B4
_02167710: .word 0x0217E8B0
_02167714: .word 0x01FF0000
_02167718: .word 0x04000010
_0216771C: .word 0x0217ABE8
_02167720: .word 0x04000018
	arm_func_end ovl08_2167690

	arm_func_start ovl08_2167724
ovl08_2167724: // 0x02167724
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl08_216E5FC
	bl ovl08_215A8A0
	ldr r0, _021677C4 // =0x0217E8B0
	mov r1, #0x1d
	ldrh r2, [r0]
	add r2, r2, #6
	strh r2, [r0]
	ldrh r0, [r0]
	bl FX_ModS32
	cmp r0, #6
	blt _02167760
	bl ovl08_2167BB0
	ldmia sp!, {r4, pc}
_02167760:
	ldr r1, _021677C4 // =0x0217E8B0
	ldrh r2, [r1]
	sub r0, r2, r0
	strh r0, [r1]
	bl ovl08_2168474
	ldr r1, _021677C4 // =0x0217E8B0
	mov r0, #0x37
	ldrh r1, [r1]
	ldr r2, _021677C8 // =0xE1FC780F
	mul r3, r1, r0
	smull r1, r0, r2, r3
	add r0, r3, r0
	mov r0, r0, asr #7
	mov r1, r3, lsr #0x1f
	add r0, r1, r0
	bl ovl08_216E62C
	bl ovl08_216E614
	bl ovl08_21674DC
	ldr r0, _021677CC // =0x0217E8B4
	mov r1, r4
	ldr r2, [r0]
	mov r0, #0
	str r0, [r2, #0x38]
	bl ovl08_2177870
	ldmia sp!, {r4, pc}
	.align 2, 0
_021677C4: .word 0x0217E8B0
_021677C8: .word 0xE1FC780F
_021677CC: .word 0x0217E8B4
	arm_func_end ovl08_2167724

	arm_func_start ovl08_21677D0
ovl08_21677D0: // 0x021677D0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	bl ovl08_216E5FC
	bl ovl08_215A8A0
	ldr r0, _021678AC // =0x0217E8B0
	ldrh r1, [r0]
	cmp r1, #6
	subhi r1, r1, #6
	strhih r1, [r0]
	movls r1, #0
	strlsh r1, [r0]
	ldr r0, _021678AC // =0x0217E8B0
	mov r1, #0x1d
	ldrh r0, [r0]
	bl FX_ModS32
	mov r5, r0
	cmp r5, #0x17
	bne _02167828
	bl ovl08_2168474
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02167828:
	cmp r5, #0x17
	ble _02167848
	ldr r0, _021678AC // =0x0217E8B0
	rsb r1, r5, #0x1d
	ldrh r2, [r0]
	mov r5, #0
	add r1, r2, r1
	strh r1, [r0]
_02167848:
	bl ovl08_2167BB0
	cmp r5, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	ldr r1, _021678AC // =0x0217E8B0
	mov r0, #0x37
	ldrh r1, [r1]
	ldr r2, _021678B0 // =0xE1FC780F
	mul r3, r1, r0
	smull r1, r0, r2, r3
	add r0, r3, r0
	mov r0, r0, asr #7
	mov r1, r3, lsr #0x1f
	add r0, r1, r0
	bl ovl08_216E62C
	bl ovl08_216E614
	bl ovl08_21674DC
	ldr r0, _021678B4 // =0x0217E8B4
	mov r1, r4
	ldr r2, [r0]
	mov r0, #0
	str r0, [r2, #0x38]
	bl ovl08_2177870
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_021678AC: .word 0x0217E8B0
_021678B0: .word 0xE1FC780F
_021678B4: .word 0x0217E8B4
	arm_func_end ovl08_21677D0

	arm_func_start ovl08_21678B8
ovl08_21678B8: // 0x021678B8
	stmdb sp!, {r4, lr}
	ldr r1, _021678D8 // =0x0217E8B0
	mov r4, r0
	ldrh r0, [r1]
	mov r1, #0x1d
	bl FX_DivS32
	add r0, r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021678D8: .word 0x0217E8B0
	arm_func_end ovl08_21678B8

	arm_func_start ovl08_21678DC
ovl08_21678DC: // 0x021678DC
	stmdb sp!, {r4, lr}
	ldr r1, _0216791C // =0x0217E8B0
	mov r4, r0
	ldrh r0, [r1]
	mov r1, #0x1d
	bl FX_DivS32
	mov r1, #0
_021678F8:
	cmp r0, r4
	moveq r0, r1
	ldmeqia sp!, {r4, pc}
	add r1, r1, #1
	cmp r1, #4
	add r0, r0, #1
	blt _021678F8
	mvn r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216791C: .word 0x0217E8B0
	arm_func_end ovl08_21678DC

	arm_func_start ovl08_2167920
ovl08_2167920: // 0x02167920
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r0, _02167B94 // =0x0217B024
	bl ovl08_2176A38
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0xe
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, _02167B98 // =0x0217E8B0
	mov r1, #0x1d
	ldrh r0, [r0]
	bl FX_DivS32
	ldr r1, _02167B9C // =0x0217ABC4
	add r4, sp, #0
	ldrh ip, [r1]
	ldrh r3, [r1, #2]
	ldrh r2, [r1, #4]
	ldrh r1, [r1, #6]
	mov r5, r0
	strh ip, [sp]
	strh r3, [sp, #2]
	strh r2, [sp, #4]
	strh r1, [sp, #6]
	mov r6, #0
_02167980:
	cmp r5, #2
	beq _021679AC
	cmp r5, #6
	beq _021679AC
	mov r0, r4
	bl ovl08_2176918
	cmp r0, #0
	ldrne r0, _02167BA0 // =0x0217ABDC
	addne sp, sp, #8
	ldrneb r0, [r0, r5]
	ldmneia sp!, {r4, r5, r6, pc}
_021679AC:
	ldrh r0, [sp, #2]
	add r6, r6, #1
	cmp r6, #4
	add r0, r0, #0x1d
	strh r0, [sp, #2]
	add r5, r5, #1
	blt _02167980
	ldr r0, _02167B98 // =0x0217E8B0
	mov r1, #0x1d
	ldrh r0, [r0]
	bl FX_DivS32
	mov r3, #0
_021679DC:
	cmp r0, #2
	bne _02167A80
	ldr r1, _02167BA4 // =0x0217ABD4
	mov r0, #0x1d
	ldrh r2, [r1, #2]
	mul r4, r3, r0
	strh r2, [sp, #2]
	ldrh r5, [r1]
	ldrh r3, [r1, #4]
	ldrh r2, [r1, #6]
	ldrh r0, [sp, #2]
	strh r5, [sp]
	strh r3, [sp, #4]
	add r1, r0, r4
	add r0, sp, #0
	strh r2, [sp, #6]
	strh r1, [sp, #2]
	bl ovl08_2176918
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, _02167BA8 // =0x0217ABCC
	add r0, sp, #0
	ldrh r2, [r1, #2]
	ldrh ip, [r1]
	ldrh r5, [r1, #4]
	strh r2, [sp, #2]
	ldrh r3, [r1, #6]
	ldrh r2, [sp, #2]
	strh ip, [sp]
	strh r5, [sp, #4]
	add r1, r2, r4
	strh r3, [sp, #6]
	strh r1, [sp, #2]
	bl ovl08_2176918
	cmp r0, #0
	beq _02167A90
	add sp, sp, #8
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_02167A80:
	add r3, r3, #1
	cmp r3, #4
	add r0, r0, #1
	blt _021679DC
_02167A90:
	ldr r0, _02167B98 // =0x0217E8B0
	mov r1, #0x1d
	ldrh r0, [r0]
	bl FX_DivS32
	mov r3, #0
_02167AA4:
	cmp r0, #6
	bne _02167B48
	ldr r1, _02167BA4 // =0x0217ABD4
	mov r0, #0x1d
	ldrh r2, [r1, #2]
	mul r4, r3, r0
	strh r2, [sp, #2]
	ldrh r5, [r1]
	ldrh r3, [r1, #4]
	ldrh r2, [r1, #6]
	ldrh r0, [sp, #2]
	strh r5, [sp]
	strh r3, [sp, #4]
	add r1, r0, r4
	add r0, sp, #0
	strh r2, [sp, #6]
	strh r1, [sp, #2]
	bl ovl08_2176918
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #7
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, _02167BA8 // =0x0217ABCC
	add r0, sp, #0
	ldrh r2, [r1, #2]
	ldrh ip, [r1]
	ldrh r5, [r1, #4]
	strh r2, [sp, #2]
	ldrh r3, [r1, #6]
	ldrh r2, [sp, #2]
	strh ip, [sp]
	strh r5, [sp, #4]
	add r1, r2, r4
	strh r3, [sp, #6]
	strh r1, [sp, #2]
	bl ovl08_2176918
	cmp r0, #0
	beq _02167B58
	add sp, sp, #8
	mov r0, #8
	ldmia sp!, {r4, r5, r6, pc}
_02167B48:
	add r3, r3, #1
	cmp r3, #4
	add r0, r0, #1
	blt _02167AA4
_02167B58:
	ldr r5, _02167BAC // =0x0217AC7C
	mov r4, #0
_02167B60:
	mov r0, r5
	bl ovl08_2176A38
	cmp r0, #0
	addne sp, sp, #8
	addne r0, r4, #0xb
	ldmneia sp!, {r4, r5, r6, pc}
	add r4, r4, #1
	cmp r4, #3
	add r5, r5, #8
	blt _02167B60
	mov r0, #0xe
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02167B94: .word 0x0217B024
_02167B98: .word 0x0217E8B0
_02167B9C: .word 0x0217ABC4
_02167BA0: .word 0x0217ABDC
_02167BA4: .word 0x0217ABD4
_02167BA8: .word 0x0217ABCC
_02167BAC: .word 0x0217AC7C
	arm_func_end ovl08_2167920

	arm_func_start ovl08_2167BB0
ovl08_2167BB0: // 0x02167BB0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	ldr r0, _02167DD4 // =0x0217E8B0
	mov r1, #0x1d
	ldrh r0, [r0]
	bl FX_DivS32
	ldr r1, _02167DD4 // =0x0217E8B0
	mov r4, r0
	ldrh r0, [r1]
	mov r1, #0x1d
	bl FX_ModS32
	ldr r1, _02167DD8 // =0x0217E8B4
	rsb ip, r0, #0x34
	ldr r1, [r1]
	ldr r0, [r1, #0x34]
	cmp r0, #0
	beq _02167C34
	cmp r4, #0
	moveq r0, #0x26
	streq r0, [sp]
	movne r0, #0x100
	strne r0, [sp]
	ldr r5, [r1, #0x34]
	ldr r1, _02167DDC // =0xFE00FF00
	ldr r2, [r5]
	ldr r3, [sp]
	ldr r0, _02167DE0 // =0x000001FF
	and r2, r2, r1
	and r1, ip, #0xff
	and r3, r3, r0
	orr r0, r2, r1
	orr r0, r0, r3, lsl #16
	str r0, [r5]
_02167C34:
	mov r3, ip
	mov r2, #0
	ldr r7, _02167DD8 // =0x0217E8B4
	ldr lr, _02167DE4 // =0x01FF0000
	ldr r5, _02167DE0 // =0x000001FF
	ldr r6, _02167DDC // =0xFE00FF00
_02167C4C:
	ldr r0, [r7]
	and r8, r3, #0xff
	add r1, r0, r2, lsl #2
	ldr r0, [r1, #0x18]
	add r2, r2, #1
	ldr r9, [r0]
	cmp r2, #5
	and r10, r9, lr
	mov r9, r10, lsr #0x10
	str r9, [sp]
	ldr r9, [r0]
	and r0, r5, r10, lsr #16
	and r9, r9, #0xff
	str r9, [sp, #4]
	ldr r1, [r1, #0x18]
	add r3, r3, #0x1d
	ldr r9, [r1]
	and r9, r9, r6
	orr r8, r9, r8
	orr r0, r8, r0, lsl #16
	str r0, [r1]
	blt _02167C4C
	cmp r4, #2
	bgt _02167D0C
	ldr r6, [r7]
	ldr r0, _02167DE4 // =0x01FF0000
	ldr r5, [r6, #0x2c]
	rsb r2, r4, #2
	ldr r3, [r5]
	mov r1, #0x1d
	and r0, r3, r0
	mov r3, r0, lsr #0x10
	str r3, [sp]
	ldr r5, [r5]
	mla r3, r2, r1, ip
	and r1, r5, #0xff
	str r1, [sp, #4]
	ldr r6, [r6, #0x2c]
	ldr r1, _02167DE0 // =0x000001FF
	ldr r5, [r6]
	ldr r2, _02167DDC // =0xFE00FF00
	and r3, r3, #0xff
	and r2, r5, r2
	and r1, r1, r0, lsr #16
	orr r0, r2, r3
	orr r0, r0, r1, lsl #16
	str r0, [r6]
	b _02167D28
_02167D0C:
	ldr r1, [r7]
	ldr r0, _02167DDC // =0xFE00FF00
	ldr r2, [r1, #0x2c]
	ldr r1, [r2]
	and r0, r1, r0
	orr r0, r0, #0x1000000
	str r0, [r2]
_02167D28:
	cmp r4, #2
	blt _02167D9C
	cmp r4, #6
	bgt _02167D9C
	ldr r0, _02167DD8 // =0x0217E8B4
	ldr r1, _02167DE4 // =0x01FF0000
	ldr r0, [r0]
	rsb r3, r4, #6
	ldr r6, [r0, #0x30]
	mov r2, #0x1d
	ldr r4, [r6]
	mla r2, r3, r2, ip
	and r5, r4, r1
	mov r1, r5, lsr #0x10
	str r1, [sp]
	ldr r3, [r6]
	ldr r1, _02167DDC // =0xFE00FF00
	and r3, r3, #0xff
	str r3, [sp, #4]
	ldr r4, [r0, #0x30]
	ldr r0, _02167DE0 // =0x000001FF
	ldr r3, [r4]
	and r2, r2, #0xff
	and r1, r3, r1
	and r3, r0, r5, lsr #16
	orr r0, r1, r2
	orr r0, r0, r3, lsl #16
	str r0, [r4]
	b _02167DBC
_02167D9C:
	ldr r1, _02167DD8 // =0x0217E8B4
	ldr r0, _02167DDC // =0xFE00FF00
	ldr r1, [r1]
	ldr r2, [r1, #0x30]
	ldr r1, [r2]
	and r0, r1, r0
	orr r0, r0, #0x1000000
	str r0, [r2]
_02167DBC:
	ldr r0, _02167DD8 // =0x0217E8B4
	mov r1, #1
	ldr r0, [r0]
	strb r1, [r0, #0x44]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02167DD4: .word 0x0217E8B0
_02167DD8: .word 0x0217E8B4
_02167DDC: .word 0xFE00FF00
_02167DE0: .word 0x000001FF
_02167DE4: .word 0x01FF0000
	arm_func_end ovl08_2167BB0

	arm_func_start ovl08_2167DE8
ovl08_2167DE8: // 0x02167DE8
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x30
	mov ip, r0
	ldrb r2, [ip, #1]
	mov r4, r1
	add r0, sp, #0xc
	str r2, [sp]
	ldrb r3, [ip, #2]
	ldr r2, _02167E68 // =_0217BB14
	mov r1, #0x10
	str r3, [sp, #4]
	ldrb r3, [ip, #3]
	str r3, [sp, #8]
	ldrb r3, [ip]
	bl swprintf
	mov r2, #7
	mov r0, #0x1d
	mul r1, r4, r0
	str r2, [sp]
	add r0, sp, #0xc
	str r0, [sp, #4]
	mov r2, #1
	str r2, [sp, #8]
	ldr r0, _02167E6C // =0x0217E8B4
	add r2, r1, #8
	ldr r0, [r0]
	mov r1, #0x5f
	ldr r0, [r0, #0x14]
	mov r3, #2
	bl ovl08_2175C38
	add sp, sp, #0x30
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167E68: .word _0217BB14
_02167E6C: .word 0x0217E8B4
	arm_func_end ovl08_2167DE8

	arm_func_start ovl08_2167E70
ovl08_2167E70: // 0x02167E70
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x30
	mov r6, r0
	mov r4, r1
	add r0, sp, #0xc
	mov r1, #0
	mov r2, #0x22
	bl MI_CpuFill8
	mov r0, r6
	mov r1, #0x20
	bl ovl08_2177504
	mov r5, r0
	cmp r5, #0x10
	movle lr, r5
	movgt lr, #0x10
	cmp lr, #0
	mov ip, #0
	ble _02167EE4
	ldr r2, _02167FC4 // =0x0000E01D
	add r1, sp, #0xc
_02167EC0:
	ldrb r3, [r6, ip]
	cmp r3, #0x20
	moveq r0, ip, lsl #1
	streqh r2, [r1, r0]
	movne r0, ip, lsl #1
	add ip, ip, #1
	strneh r3, [r1, r0]
	cmp ip, lr
	blt _02167EC0
_02167EE4:
	mov r0, #0x1d
	mul r0, r4, r0
	mov r1, #8
	add r4, r0, #2
	str r1, [sp]
	add r0, sp, #0xc
	str r0, [sp, #4]
	mov r1, #1
	str r1, [sp, #8]
	ldr r0, _02167FC8 // =0x0217E8B4
	cmp r5, #0x10
	ldr r0, [r0]
	addle r4, r4, #5
	ldr r0, [r0, #0x14]
	mov r2, r4
	mov r1, #0x48
	mov r3, #2
	bl ovl08_2175C38
	cmp r5, #0x10
	addle sp, sp, #0x30
	ldmleia sp!, {r4, r5, r6, pc}
	add r0, sp, #0xc
	mov r1, #0
	mov r2, #0x22
	bl MI_CpuFill8
	sub ip, r5, #0x10
	cmp ip, #0
	mov r5, #0
	ble _02167F88
	ldr r2, _02167FC4 // =0x0000E01D
	add r1, sp, #0xc
_02167F60:
	add r0, r5, #0x10
	ldrb r3, [r6, r0]
	cmp r3, #0x20
	moveq r0, r5, lsl #1
	streqh r2, [r1, r0]
	movne r0, r5, lsl #1
	add r5, r5, #1
	strneh r3, [r1, r0]
	cmp r5, ip
	blt _02167F60
_02167F88:
	mov r1, #8
	str r1, [sp]
	add r0, sp, #0xc
	str r0, [sp, #4]
	mov r1, #1
	str r1, [sp, #8]
	ldr r0, _02167FC8 // =0x0217E8B4
	add r2, r4, #0xc
	ldr r0, [r0]
	mov r1, #0x48
	ldr r0, [r0, #0x14]
	mov r3, #2
	bl ovl08_2175C38
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02167FC4: .word 0x0000E01D
_02167FC8: .word 0x0217E8B4
	arm_func_end ovl08_2167E70

	arm_func_start ovl08_2167FCC
ovl08_2167FCC: // 0x02167FCC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	ldr r5, _021680D4 // =0x0217ABC4
	ldr r4, _021680D8 // =0x0217ABD4
	ldr r3, _021680DC // =0x0217ABCC
	ldrh ip, [r4]
	ldrh r4, [r3]
	ldr r3, _021680E0 // =0x0217E8B4
	ldrh lr, [r5]
	ldr r3, [r3]
	mov r6, r0
	add r3, r3, #0x18
	sub r0, r6, #1
	mov r5, r1
	strh lr, [sp]
	strh ip, [sp, #2]
	strh ip, [sp, #4]
	strh r4, [sp, #6]
	strh r4, [sp, #8]
	cmp r0, #1
	add r4, r3, r2, lsl #2
	bhi _02168048
	mov r0, r2
	bl ovl08_21678B8
	cmp r0, #2
	ldreq r0, _021680E0 // =0x0217E8B4
	ldreq r0, [r0]
	addeq r4, r0, #0x2c
	ldrne r0, _021680E0 // =0x0217E8B4
	ldrne r0, [r0]
	addne r4, r0, #0x30
_02168048:
	ldr r1, _021680E4 // =0x0217AC10
	mov r0, #3
	mla r0, r6, r0, r1
	ldrb r1, [r5, r0]
	cmp r1, #0
	beq _021680B4
	ldr r2, [r4]
	mov r0, #0
	bl ovl08_217559C
	ldr r5, [r4]
	add r0, sp, #0
	mov r1, r6, lsl #1
	ldrh r3, [r0, r1]
	ldr r0, _021680E8 // =0x000001FF
	ldr r2, [r5]
	ldr r1, _021680EC // =0xFE00FF00
	and r3, r3, r0
	and r0, r2, r1
	orr r0, r0, r3, lsl #16
	str r0, [r5]
	ldr r1, [r4]
	add sp, sp, #0x10
	ldrh r0, [r1, #4]
	bic r0, r0, #0xc00
	orr r0, r0, #0xc00
	strh r0, [r1, #4]
	ldmia sp!, {r4, r5, r6, pc}
_021680B4:
	ldr r2, [r4]
	ldr r0, _021680EC // =0xFE00FF00
	ldr r1, [r2]
	and r0, r1, r0
	orr r0, r0, #0x1000000
	str r0, [r2]
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021680D4: .word 0x0217ABC4
_021680D8: .word 0x0217ABD4
_021680DC: .word 0x0217ABCC
_021680E0: .word 0x0217E8B4
_021680E4: .word 0x0217AC10
_021680E8: .word 0x000001FF
_021680EC: .word 0xFE00FF00
	arm_func_end ovl08_2167FCC

	arm_func_start ovl08_21680F0
ovl08_21680F0: // 0x021680F0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl08_216F84C
	cmp r4, #0xa
	mov r1, #1
	addls pc, pc, r4, lsl #2
	b _0216817C
_0216810C: // jump table
	b _02168148 // case 0
	b _02168148 // case 1
	b _0216817C // case 2
	b _0216817C // case 3
	b _02168160 // case 4
	b _02168160 // case 5
	b _02168160 // case 6
	b _02168138 // case 7
	b _0216817C // case 8
	b _02168170 // case 9
	b _02168170 // case 10
_02168138:
	ldrb r0, [r0, #0xf5]
	cmp r0, #0
	moveq r1, #0
	b _0216817C
_02168148:
	ldrb r0, [r0, #0xe7]
	add r0, r0, #0xff
	and r0, r0, #0xff
	cmp r0, #1
	movls r1, #0
	b _0216817C
_02168160:
	ldrb r0, [r0, #0xf5]
	cmp r0, #0
	movne r1, #0
	b _0216817C
_02168170:
	ldrb r0, [r0, #0xf6]
	cmp r0, #0
	movne r1, #0
_0216817C:
	mov r0, r1
	ldmia sp!, {r4, pc}
	arm_func_end ovl08_21680F0

	arm_func_start ovl08_2168184
ovl08_2168184: // 0x02168184
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r6, r1
	bl ovl08_216F84C
	cmp r4, #8
	addls pc, pc, r4, lsl #2
	b _021682B8
_021681A0: // jump table
	b _021681C4 // case 0
	b _021681C4 // case 1
	b _021681E0 // case 2
	b _0216822C // case 3
	b _0216822C // case 4
	b _0216822C // case 5
	b _02168244 // case 6
	b _021682A0 // case 7
	b _021682A0 // case 8
_021681C4:
	mov r5, #0
	mov r0, r5
	mov r4, r5
	bl ovl08_21680F0
	cmp r0, #0
	moveq r4, #2
	b _021682C0
_021681E0:
	ldr r2, _021682D4 // =0x0217E8B4
	ldrb r0, [r0, #0xf5]
	ldr r3, [r2]
	mov r1, #0
	ldrb r2, [r3, #4]
	cmp r0, #0
	movne r5, #1
	movne r0, #4
	moveq r5, #2
	moveq r0, #3
	cmp r2, #0
	mov r4, r1
	ldrb r2, [r3, #5]
	movne r4, #1
	cmp r2, #0
	movne r1, #1
	mov r2, r6
	bl ovl08_2167FCC
	b _021682C0
_0216822C:
	ldrb r0, [r0, #0xf5]
	mov r5, #0
	cmp r0, #0
	movne r4, #2
	moveq r4, r5
	b _021682C0
_02168244:
	ldrb r2, [r0, #0xf6]
	mov r1, #0
	mov r4, r1
	cmp r2, #0
	movne r5, #1
	movne r0, #4
	bne _02168274
	ldrb r0, [r0, #0xf5]
	mov r5, #2
	cmp r0, #0
	moveq r4, #2
	mov r0, #3
_02168274:
	ldr r2, _021682D4 // =0x0217E8B4
	ldr r3, [r2]
	ldrb r2, [r3, #6]
	cmp r2, #0
	ldrb r2, [r3, #7]
	movne r4, #1
	cmp r2, #0
	movne r1, #1
	mov r2, r6
	bl ovl08_2167FCC
	b _021682C0
_021682A0:
	ldrb r0, [r0, #0xf6]
	mov r5, #0
	cmp r0, #0
	movne r4, #2
	moveq r4, r5
	b _021682C0
_021682B8:
	mov r5, #0
	mov r4, #2
_021682C0:
	mov r0, r5
	mov r1, r4
	mov r2, r6
	bl ovl08_2167FCC
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021682D4: .word 0x0217E8B4
	arm_func_end ovl08_2168184

	arm_func_start ovl08_21682D8
ovl08_21682D8: // 0x021682D8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x28
	mov r6, r0
	mov r5, r1
	bl ovl08_216F84C
	cmp r6, #8
	addls pc, pc, r6, lsl #2
	b _0216846C
_021682F8: // jump table
	b _0216831C // case 0
	b _02168330 // case 1
	b _0216846C // case 2
	b _021683C0 // case 3
	b _021683E4 // case 4
	b _02168408 // case 5
	b _0216846C // case 6
	b _0216842C // case 7
	b _02168450 // case 8
_0216831C:
	mov r1, r5
	add r0, r0, #0x40
	bl ovl08_2167E70
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, pc}
_02168330:
	ldrb r1, [r0, #0xe6]
	mov r1, r1, lsl #0x1e
	mov r1, r1, lsr #0x1e
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _02168374
_02168348: // jump table
	b _02168358 // case 0
	b _02168360 // case 1
	b _02168368 // case 2
	b _02168370 // case 3
_02168358:
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, pc}
_02168360:
	mov r4, #0xa
	b _02168374
_02168368:
	mov r4, #0x1a
	b _02168374
_02168370:
	mov r4, #0x20
_02168374:
	ldrb r0, [r0, #0xe6]
	mov r1, #0
	mov r2, #0x21
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1a
	cmp r0, #1
	addeq r0, r4, r4, lsr #31
	moveq r4, r0, asr #1
	add r0, sp, #0
	bl MI_CpuFill8
	add r0, sp, #0
	mov r2, r4
	mov r1, #0x2a
	bl memset
	add r0, sp, #0
	mov r1, r5
	bl ovl08_2167E70
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, pc}
_021683C0:
	ldrb r1, [r0, #0xf5]
	cmp r1, #0
	addne sp, sp, #0x28
	ldmneia sp!, {r4, r5, r6, pc}
	mov r1, r5
	add r0, r0, #0xc0
	bl ovl08_2167DE8
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, pc}
_021683E4:
	ldrb r1, [r0, #0xf5]
	cmp r1, #0
	addne sp, sp, #0x28
	ldmneia sp!, {r4, r5, r6, pc}
	mov r1, r5
	add r0, r0, #0xf0
	bl ovl08_2167DE8
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, pc}
_02168408:
	ldrb r1, [r0, #0xf5]
	cmp r1, #0
	addne sp, sp, #0x28
	ldmneia sp!, {r4, r5, r6, pc}
	mov r1, r5
	add r0, r0, #0xc4
	bl ovl08_2167DE8
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, pc}
_0216842C:
	ldrb r1, [r0, #0xf6]
	cmp r1, #0
	addne sp, sp, #0x28
	ldmneia sp!, {r4, r5, r6, pc}
	mov r1, r5
	add r0, r0, #0xc8
	bl ovl08_2167DE8
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, pc}
_02168450:
	ldrb r1, [r0, #0xf6]
	cmp r1, #0
	addne sp, sp, #0x28
	ldmneia sp!, {r4, r5, r6, pc}
	mov r1, r5
	add r0, r0, #0xcc
	bl ovl08_2167DE8
_0216846C:
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl08_21682D8

	arm_func_start ovl08_2168474
ovl08_2168474: // 0x02168474
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, _0216852C // =0x0217E8B0
	mov r1, #0x1d
	ldrh r0, [r0]
	bl FX_DivS32
	ldr r1, _02168530 // =0x0217E8B4
	mov r4, r0
	ldr r0, [r1]
	mov r1, #0
	ldr r0, [r0, #0x14]
	bl ovl08_2175BE8
	mov r6, r4
	mov r5, #0
_021684A8:
	mov r0, r6
	mov r1, r5
	bl ovl08_21682D8
	add r5, r5, #1
	cmp r5, #5
	add r6, r6, #1
	blt _021684A8
	ldr r0, _02168530 // =0x0217E8B4
	ldr r1, _02168534 // =0x0217AC20
	mov r2, r4, lsl #1
	ldr r3, [r0]
	ldrh r0, [r1, r2]
	ldr r2, [r3, #8]
	mov r1, #0
	add r0, r2, r0, lsl #1
	mov r2, #0x1e
	mov r3, #0x13
	bl ovl08_216DF60
	mov r5, #0
_021684F4:
	mov r0, r4
	mov r1, r5
	bl ovl08_2168184
	add r5, r5, #1
	cmp r5, #5
	add r4, r4, #1
	blt _021684F4
	bl ovl08_216DFB8
	ldr r0, _02168530 // =0x0217E8B4
	ldr r0, [r0]
	ldr r0, [r0, #0x14]
	bl ovl08_2175B20
	bl ovl08_2167BB0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216852C: .word 0x0217E8B0
_02168530: .word 0x0217E8B4
_02168534: .word 0x0217AC20
	arm_func_end ovl08_2168474

	arm_func_start ovl08_2168538
ovl08_2168538: // 0x02168538
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	ldr r1, _02168818 // =0x0217E8B4
	mov r0, #0
	ldr r1, [r1]
	ldr r1, [r1]
	bl ovl08_2177864
	ldr r1, _02168818 // =0x0217E8B4
	mov r0, #1
	ldr r1, [r1]
	ldr r1, [r1, #0x3c]
	bl ovl08_2177864
	mov r5, #0
	ldr r4, _02168818 // =0x0217E8B4
_02168598:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x18]
	bl ovl08_21770F8
	add r5, r5, #1
	cmp r5, #7
	blt _02168598
	ldr r0, _02168818 // =0x0217E8B4
	ldr r0, [r0]
	ldr r0, [r0, #0x34]
	cmp r0, #0
	beq _021685CC
	bl ovl08_21770F8
_021685CC:
	bl ovl08_216E660
	mov r0, #0
	bl ovl08_2175D6C
	bl ovl08_215A8A0
	ldr r0, _02168818 // =0x0217E8B4
	ldr r0, [r0]
	ldrb r0, [r0, #0x40]
	cmp r0, #0xc
	beq _021685F4
	bl ovl08_215A4D8
_021685F4:
	bl ovl08_216DFD0
	ldr r0, _02168818 // =0x0217E8B4
	ldr r0, [r0]
	ldr r0, [r0, #8]
	bl ovl08_2174AB8
	mov r5, #0
	ldr r4, _02168818 // =0x0217E8B4
_02168610:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0xc]
	bl ovl08_2174AB8
	add r5, r5, #1
	cmp r5, #2
	blt _02168610
	ldr r0, _0216881C // =aCharYbobjmainN_1
	ldr r1, _02168820 // =GX_LoadOBJPltt
	bl ovl08_215A7F8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x1d
	bl ovl08_217661C
	ldr r2, _02168824 // =0x04000010
	mov r1, #0
	ldr r0, _02168828 // =0x04000018
	str r1, [r2]
	str r1, [r0]
	ldr r3, _0216882C // =0x0400000C
	ldr r0, _02168818 // =0x0217E8B4
	ldrh r2, [r3]
	and r2, r2, #0x43
	orr r2, r2, #0xe10
	strh r2, [r3]
	ldr r0, [r0]
	ldrb r0, [r0, #0x40]
	cmp r0, #0xd
	addls pc, pc, r0, lsl #2
	b _02168808
_02168690: // jump table
	b _021686C8 // case 0
	b _021686C8 // case 1
	b _02168808 // case 2
	b _02168808 // case 3
	b _021686E4 // case 4
	b _021686E4 // case 5
	b _021686E4 // case 6
	b _02168808 // case 7
	b _02168808 // case 8
	b _021686E4 // case 9
	b _021686E4 // case 10
	b _02168714 // case 11
	b _021687AC // case 12
	b _021687C0 // case 13
_021686C8:
	bl ovl08_215E638
	mov r0, #2
	mov r1, #0
	bl ovl08_215E674
	ldr r0, _02168830 // =ovl08_2165878
	bl DWCi_ChangeScene
	b _02168808
_021686E4:
	sub r4, r0, #4
	cmp r0, #9
	subhs r4, r4, #2
	mov r0, #2
	mov r1, #0
	bl ovl08_215E674
	mov r0, r4
	mov r1, #0
	bl ovl08_215E638
	ldr r0, _02168834 // =ovl08_2166630
	bl DWCi_ChangeScene
	b _02168808
_02168714:
	bl ovl08_216F84C
	mov r4, r0
	add r0, r4, #0xf0
	bl sub_208DD68
	strb r0, [r4, #0xd0]
	ldrb r0, [r4, #0xf5]
	cmp r0, #0
	beq _0216876C
	add r0, r4, #0xc0
	mov r1, #0
	mov r2, #4
	bl MI_CpuFill8
	add r0, r4, #0xc4
	mov r1, #0
	mov r2, #4
	bl MI_CpuFill8
	add r0, r4, #0xf0
	mov r1, #0
	mov r2, #4
	bl MI_CpuFill8
	mov r0, #0
	strb r0, [r4, #0xd0]
_0216876C:
	ldrb r0, [r4, #0xf6]
	cmp r0, #0
	beq _02168788
	add r0, r4, #0xc8
	mov r1, #0
	mov r2, #8
	bl MI_CpuFill8
_02168788:
	mov r0, #2
	mov r1, #0
	bl ovl08_215E674
	mov r0, #0
	mov r1, r0
	bl ovl08_215E638
	ldr r0, _02168838 // =ovl08_216CAB0
	bl DWCi_ChangeScene
	b _02168808
_021687AC:
	mov r0, r1
	bl ovl08_215E674
	ldr r0, _0216883C // =ovl08_2169898
	bl DWCi_ChangeScene
	b _02168808
_021687C0:
	ldr r0, _02168840 // =0x0217E8A8
	ldrb r0, [r0]
	cmp r0, #0
	bne _021687E8
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02168844 // =ovl08_216BDFC
	bl DWCi_ChangeScene
	b _02168808
_021687E8:
	bl ovl08_216F84C
	ldrb r0, [r0, #0xf4]
	bl ovl08_216F30C
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02168848 // =ovl08_216C5AC
	bl DWCi_ChangeScene
_02168808:
	ldr r0, _02168818 // =0x0217E8B4
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02168818: .word 0x0217E8B4
_0216881C: .word aCharYbobjmainN_1
_02168820: .word GX_LoadOBJPltt
_02168824: .word 0x04000010
_02168828: .word 0x04000018
_0216882C: .word 0x0400000C
_02168830: .word ovl08_2165878
_02168834: .word ovl08_2166630
_02168838: .word ovl08_216CAB0
_0216883C: .word ovl08_2169898
_02168840: .word 0x0217E8A8
_02168844: .word ovl08_216BDFC
_02168848: .word ovl08_216C5AC
	arm_func_end ovl08_2168538

	arm_func_start ovl08_216884C
ovl08_216884C: // 0x0216884C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x1d
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _021688A0 // =ovl08_2168538
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021688A0: .word ovl08_2168538
	arm_func_end ovl08_216884C

	arm_func_start ovl08_21688A4
ovl08_21688A4: // 0x021688A4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216E5FC
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _021688C8 // =ovl08_216884C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021688C8: .word ovl08_216884C
	arm_func_end ovl08_21688A4

	arm_func_start ovl08_21688CC
ovl08_21688CC: // 0x021688CC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02168B6C // =0x0217E8B4
	ldr r1, [r0]
	ldr r0, [r1, #0x38]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldrb r0, [r1, #0x41]
	cmp r0, #0
	subne r0, r0, #1
	strneb r0, [r1, #0x41]
	bl ovl08_216E638
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _02168B64
_0216890C: // jump table
	b _02168B64 // case 0
	b _0216892C // case 1
	b _02168944 // case 2
	b _021689A4 // case 3
	b _02168A64 // case 4
	b _02168B54 // case 5
	b _02168ADC // case 6
	b _02168B54 // case 7
_0216892C:
	ldr r0, _02168B6C // =0x0217E8B4
	mov r1, #1
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x45]
	ldmia sp!, {pc}
_02168944:
	ldr r0, _02168B6C // =0x0217E8B4
	ldr r0, [r0]
	ldrb r0, [r0, #0x41]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A8A0
	bl ovl08_216E64C
	mov r1, #0x91
	mul r1, r0, r1
	ldr r2, _02168B70 // =0x094F2095
	mov r0, r1, lsr #0x1f
	smull r1, r3, r2, r1
	mov r3, r3, asr #1
	ldr r1, _02168B74 // =0x0217E8B0
	add r3, r0, r3
	strh r3, [r1]
	bl ovl08_2168474
	ldr r0, _02168B6C // =0x0217E8B4
	mov r1, #4
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x41]
	ldmia sp!, {pc}
_021689A4:
	ldr r0, _02168B6C // =0x0217E8B4
	mov r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x45]
	bl ovl08_216E64C
	mov r1, #0x91
	mul r1, r0, r1
	ldr r2, _02168B70 // =0x094F2095
	mov r0, r1, lsr #0x1f
	smull r1, r3, r2, r1
	mov r3, r3, asr #1
	ldr r1, _02168B74 // =0x0217E8B0
	add r3, r0, r3
	mov r0, #0x13
	strh r3, [r1]
	bl ovl08_216F934
	bl ovl08_2168474
	ldr r0, _02168B74 // =0x0217E8B0
	mov r1, #0x1d
	ldrh r0, [r0]
	bl FX_ModS32
	cmp r0, #0
	bne _02168A0C
	bl ovl08_21674DC
	add sp, sp, #4
	ldmia sp!, {pc}
_02168A0C:
	cmp r0, #0x10
	bge _02168A3C
	mov r0, #0
	ldr r1, _02168B78 // =ovl08_21677D0
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _02168B6C // =0x0217E8B4
	add sp, sp, #4
	ldr r1, [r1]
	str r0, [r1, #0x38]
	ldmia sp!, {pc}
_02168A3C:
	mov r0, #0
	ldr r1, _02168B7C // =ovl08_2167724
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _02168B6C // =0x0217E8B4
	add sp, sp, #4
	ldr r1, [r1]
	str r0, [r1, #0x38]
	ldmia sp!, {pc}
_02168A64:
	ldr r0, _02168B74 // =0x0217E8B0
	ldrh r0, [r0]
	cmp r0, #0
	bne _02168AAC
	ldr r0, _02168B6C // =0x0217E8B4
	ldr r0, [r0]
	ldrb r0, [r0, #0x46]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _02168B6C // =0x0217E8B4
	mov r1, #1
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x46]
	ldmia sp!, {pc}
_02168AAC:
	mov r0, #0x13
	bl ovl08_216F934
	mov r0, #0
	ldr r1, _02168B78 // =ovl08_21677D0
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _02168B6C // =0x0217E8B4
	add sp, sp, #4
	ldr r1, [r1]
	str r0, [r1, #0x38]
	ldmia sp!, {pc}
_02168ADC:
	ldr r0, _02168B74 // =0x0217E8B0
	ldrh r0, [r0]
	cmp r0, #0x91
	bne _02168B24
	ldr r0, _02168B6C // =0x0217E8B4
	ldr r0, [r0]
	ldrb r0, [r0, #0x46]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _02168B6C // =0x0217E8B4
	mov r1, #1
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x46]
	ldmia sp!, {pc}
_02168B24:
	mov r0, #0x13
	bl ovl08_216F934
	mov r0, #0
	ldr r1, _02168B7C // =ovl08_2167724
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _02168B6C // =0x0217E8B4
	add sp, sp, #4
	ldr r1, [r1]
	str r0, [r1, #0x38]
	ldmia sp!, {pc}
_02168B54:
	ldr r0, _02168B6C // =0x0217E8B4
	mov r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x46]
_02168B64:
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02168B6C: .word 0x0217E8B4
_02168B70: .word 0x094F2095
_02168B74: .word 0x0217E8B0
_02168B78: .word ovl08_21677D0
_02168B7C: .word ovl08_2167724
	arm_func_end ovl08_21688CC

	arm_func_start ovl08_2168B80
ovl08_2168B80: // 0x02168B80
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl08_216F84C
	ldrb r0, [r0, #0xf6]
	cmp r0, r4
	ldmeqia sp!, {r4, pc}
	ldr r1, _02168BB4 // =0x0217E8B4
	mov r0, r4
	ldr r1, [r1]
	strb r4, [r1, #0x43]
	bl ovl08_216F824
	bl ovl08_2168474
	ldmia sp!, {r4, pc}
	.align 2, 0
_02168BB4: .word 0x0217E8B4
	arm_func_end ovl08_2168B80

	arm_func_start ovl08_2168BB8
ovl08_2168BB8: // 0x02168BB8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	bl ovl08_216F84C
	ldrb r1, [r0, #0xf5]
	cmp r1, r4
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	cmp r4, #0
	beq _02168BFC
	ldr r0, _02168C2C // =0x0217E8B4
	ldr r0, [r0]
	ldrb r0, [r0, #0x43]
	cmp r0, #0
	movne r5, #1
	moveq r5, #0
	b _02168C10
_02168BFC:
	ldr r1, _02168C2C // =0x0217E8B4
	ldrb r2, [r0, #0xf6]
	ldr r0, [r1]
	mov r5, #0
	strb r2, [r0, #0x43]
_02168C10:
	mov r0, r4
	bl ovl08_216F838
	mov r0, r5
	bl ovl08_216F824
	bl ovl08_2168474
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02168C2C: .word 0x0217E8B4
	arm_func_end ovl08_2168BB8

	arm_func_start ovl08_2168C30
ovl08_2168C30: // 0x02168C30
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl ovl08_21680F0
	cmp r0, #0
	bne _02168C58
	mov r0, #9
	bl ovl08_216F934
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02168C58:
	cmp r4, #8
	addls pc, pc, r4, lsl #2
	b _02168CD0
_02168C64: // jump table
	b _02168CD0 // case 0
	b _02168CD0 // case 1
	b _02168C88 // case 2
	b _02168C88 // case 3
	b _02168CD0 // case 4
	b _02168CD0 // case 5
	b _02168CD0 // case 6
	b _02168CAC // case 7
	b _02168CAC // case 8
_02168C88:
	mov r0, #6
	bl ovl08_216F934
	sub r0, r4, #2
	eors r0, r0, #1
	movne r0, #1
	moveq r0, #0
	bl ovl08_2168BB8
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02168CAC:
	mov r0, #6
	bl ovl08_216F934
	sub r0, r4, #7
	eors r0, r0, #1
	movne r0, #1
	moveq r0, #0
	bl ovl08_2168B80
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02168CD0:
	ldr r0, _02168DA0 // =0x0217E8B4
	sub r1, r4, #0xb
	ldr r0, [r0]
	cmp r1, #1
	strb r4, [r0, #0x40]
	bhi _02168D4C
	bl ovl08_2167120
	bl ovl08_2166F64
	cmp r0, #0
	bne _02168D2C
	mov r0, #9
	bl ovl08_216F934
	mov r1, #1
	mov ip, #0
	mov r2, r1
	mov r0, #6
	mvn r3, #0
	str ip, [sp]
	bl ovl08_21715E4
	ldr r0, _02168DA4 // =ovl08_2166F18
	bl DWCi_ChangeScene
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02168D2C:
	cmp r4, #0xb
	bne _02168D40
	mov r0, #6
	bl ovl08_216F934
	b _02168D8C
_02168D40:
	mov r0, #0xe
	bl ovl08_216F934
	b _02168D8C
_02168D4C:
	cmp r4, #0xd
	bne _02168D64
	bl ovl08_2167120
	mov r0, #7
	bl ovl08_216F934
	b _02168D8C
_02168D64:
	mov r0, #6
	bl ovl08_216F934
	ldr r0, _02168DA8 // =0x0217ABF4
	ldrb r0, [r0, r4]
	bl ovl08_21678DC
	mov r2, r0
	mov r0, #0
	mov r1, #1
	bl ovl08_2167FCC
	bl ovl08_2167BB0
_02168D8C:
	bl ovl08_216E5FC
	ldr r0, _02168DAC // =ovl08_21688A4
	bl DWCi_ChangeScene
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02168DA0: .word 0x0217E8B4
_02168DA4: .word ovl08_2166F18
_02168DA8: .word 0x0217ABF4
_02168DAC: .word ovl08_21688A4
	arm_func_end ovl08_2168C30

	arm_func_start ovl08_2168DB0
ovl08_2168DB0: // 0x02168DB0
	stmdb sp!, {r4, lr}
	bl ovl08_216F84C
	bl ovl08_2167920
	mov r4, r0
	cmp r4, #0xe
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	bl ovl08_21680F0
	cmp r0, #0
	bne _02168DE8
	mov r0, #9
	bl ovl08_216F934
	mov r0, #1
	ldmia sp!, {r4, pc}
_02168DE8:
	mov r0, r4
	bl ovl08_21674A0
	cmp r4, #8
	addls pc, pc, r4, lsl #2
	b _02168E24
_02168DFC: // jump table
	b _02168E24 // case 0
	b _02168E24 // case 1
	b _02168E20 // case 2
	b _02168E20 // case 3
	b _02168E24 // case 4
	b _02168E24 // case 5
	b _02168E24 // case 6
	b _02168E20 // case 7
	b _02168E20 // case 8
_02168E20:
	bl ovl08_2167004
_02168E24:
	mov r0, r4
	bl ovl08_2168C30
	mov r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end ovl08_2168DB0

	arm_func_start ovl08_2168E34
ovl08_2168E34: // 0x02168E34
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021690F4 // =0x0217E8B4
	ldr r1, [r0]
	ldr r0, [r1, #0x38]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldrb r0, [r1, #0x45]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_2168DB0
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	beq _02168E98
	ldr r0, _021690F8 // =0x0217E8A4
	ldrb r0, [r0]
	bl ovl08_2168C30
	add sp, sp, #4
	ldmia sp!, {pc}
_02168E98:
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	beq _02168ED0
	mov r0, #7
	bl ovl08_216F934
	ldr r1, _021690F4 // =0x0217E8B4
	ldr r0, _021690FC // =ovl08_21688A4
	ldr r1, [r1]
	mov r2, #0xd
	strb r2, [r1, #0x40]
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02168ED0:
	mov r0, #0x200
	bl ovl08_2176B34
	cmp r0, #0
	beq _02168F58
	ldr r0, _02169100 // =0x0217E8B0
	ldrh r0, [r0]
	cmp r0, #0x91
	bne _02168F28
	ldr r0, _021690F4 // =0x0217E8B4
	ldr r0, [r0]
	ldrb r0, [r0, #0x47]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _021690F4 // =0x0217E8B4
	mov r1, #1
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x47]
	ldmia sp!, {pc}
_02168F28:
	mov r0, #0x13
	bl ovl08_216F934
	mov r0, #0
	ldr r1, _02169104 // =ovl08_2167724
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _021690F4 // =0x0217E8B4
	add sp, sp, #4
	ldr r1, [r1]
	str r0, [r1, #0x38]
	ldmia sp!, {pc}
_02168F58:
	mov r0, #0x200
	bl ovl08_2176B10
	cmp r0, #0
	ldrne r0, _021690F4 // =0x0217E8B4
	movne r1, #0
	ldrne r0, [r0]
	addne sp, sp, #4
	strneb r1, [r0, #0x47]
	ldmneia sp!, {pc}
	mov r0, #0x100
	bl ovl08_2176B34
	cmp r0, #0
	beq _02169004
	ldr r0, _02169100 // =0x0217E8B0
	ldrh r0, [r0]
	cmp r0, #0
	bne _02168FD4
	ldr r0, _021690F4 // =0x0217E8B4
	ldr r0, [r0]
	ldrb r0, [r0, #0x47]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _021690F4 // =0x0217E8B4
	mov r1, #1
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x47]
	ldmia sp!, {pc}
_02168FD4:
	mov r0, #0x13
	bl ovl08_216F934
	mov r0, #0
	ldr r1, _02169108 // =ovl08_21677D0
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _021690F4 // =0x0217E8B4
	add sp, sp, #4
	ldr r1, [r1]
	str r0, [r1, #0x38]
	ldmia sp!, {pc}
_02169004:
	mov r0, #0x100
	bl ovl08_2176B10
	cmp r0, #0
	ldrne r0, _021690F4 // =0x0217E8B4
	movne r1, #0
	ldrne r0, [r0]
	addne sp, sp, #4
	strneb r1, [r0, #0x47]
	ldmneia sp!, {pc}
	mov r0, #0x40
	bl ovl08_2176B34
	cmp r0, #0
	beq _02169048
	mov r0, #1
	bl ovl08_216715C
	add sp, sp, #4
	ldmia sp!, {pc}
_02169048:
	mov r0, #0x40
	bl ovl08_2176B10
	cmp r0, #0
	ldrne r0, _021690F4 // =0x0217E8B4
	movne r1, #0
	ldrne r0, [r0]
	addne sp, sp, #4
	strneb r1, [r0, #0x47]
	ldmneia sp!, {pc}
	mov r0, #0x80
	bl ovl08_2176B34
	cmp r0, #0
	beq _0216908C
	mov r0, #3
	bl ovl08_216715C
	add sp, sp, #4
	ldmia sp!, {pc}
_0216908C:
	mov r0, #0x80
	bl ovl08_2176B10
	cmp r0, #0
	ldrne r0, _021690F4 // =0x0217E8B4
	movne r1, #0
	ldrne r0, [r0]
	addne sp, sp, #4
	strneb r1, [r0, #0x47]
	ldmneia sp!, {pc}
	mov r0, #0x20
	bl ovl08_2176B34
	cmp r0, #0
	beq _021690D0
	mov r0, #0
	bl ovl08_216715C
	add sp, sp, #4
	ldmia sp!, {pc}
_021690D0:
	mov r0, #0x10
	bl ovl08_2176B34
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #2
	bl ovl08_216715C
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021690F4: .word 0x0217E8B4
_021690F8: .word 0x0217E8A4
_021690FC: .word ovl08_21688A4
_02169100: .word 0x0217E8B0
_02169104: .word ovl08_2167724
_02169108: .word ovl08_21677D0
	arm_func_end ovl08_2168E34

	arm_func_start ovl08_216910C
ovl08_216910C: // 0x0216910C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2168E34
	bl ovl08_21688CC
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216910C

	arm_func_start ovl08_2169124
ovl08_2169124: // 0x02169124
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02169164 // =ovl08_216910C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169164: .word ovl08_216910C
	arm_func_end ovl08_2169124

	arm_func_start ovl08_2169168
ovl08_2169168: // 0x02169168
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x1d
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x1d
	bl ovl08_2176678
	arm_func_end ovl08_2169168

	arm_func_start ovl08_21691B0
ovl08_21691B0: // 0x021691B0
	ldr r0, _021691C0 // =ovl08_2169124
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021691C0: .word ovl08_2169124
	arm_func_end ovl08_21691B0

	arm_func_start ovl08_21691C4
ovl08_21691C4: // 0x021691C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216F84C
	add r1, sp, #0
	mov r0, #0
	bl ovl08_215E610
	ldr r0, [sp]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r2, _02169210 // =0x0217E8B0
	mov r3, #0
	ldr r1, _02169214 // =0x0217E8A4
	arm_func_end ovl08_21691C4

	arm_func_start ovl08_21691F8
ovl08_21691F8: // 0x021691F8
	ldr r0, _02169218 // =0x0217E8AC
	strh r3, [r2]
	strb r3, [r1]
	strb r3, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169210: .word 0x0217E8B0
_02169214: .word 0x0217E8A4
_02169218: .word 0x0217E8AC
	arm_func_end ovl08_21691F8

	arm_func_start ovl08_216921C
ovl08_216921C: // 0x0216921C
	stmdb sp!, {lr}
	sub sp, sp, #0x44
	ldr r3, _021693E4 // =aCharJb3listbac
	add ip, sp, #0
	mov r2, #0xb
_02169230:
	ldrb r1, [r3], #1
	ldrb r0, [r3], #1
	subs r2, r2, #1
	strb r1, [ip], #1
	strb r0, [ip], #1
	arm_func_end ovl08_216921C

	arm_func_start ovl08_2169244
ovl08_2169244: // 0x02169244
	bne _02169230
	ldrb r0, [r3]
	ldr r3, _021693E8 // =aCharYbbgstep2N
	add lr, sp, #0x17
	strb r0, [ip]
	mov r2, #0xa
_0216925C:
	ldrb r1, [r3], #1
	ldrb r0, [r3], #1
	subs r2, r2, #1
	strb r1, [lr], #1
	strb r0, [lr], #1
	bne _0216925C
	ldrb r0, [r3]
	ldr ip, _021693EC // =aCharYbbgstep21
	add r3, sp, #0x2c
	strb r0, [lr]
	mov r2, #0xb
_02169288:
	ldrb r1, [ip], #1
	ldrb r0, [ip], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _02169288
	ldr ip, _021693F0 // =0x0400000C
	ldr r2, _021693F4 // =0x00000E18
	ldrh r3, [ip]
	ldr r0, _021693F8 // =aCharYbobjkbNcl
	ldr r1, _021693FC // =GX_LoadOBJPltt
	and r3, r3, #0x43
	orr r2, r3, r2
	strh r2, [ip]
	bl ovl08_215A7F8
	ldr r0, _02169400 // =aCharJbbgstep2N
	ldr r1, _02169404 // =GX_LoadBG3Char
	bl ovl08_215A7F8
	ldr r0, _02169408 // =aCharJbbgstep21
	ldr r1, _0216940C // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r1, _02169410 // =GX_LoadBGPltt
	add r0, sp, #0x17
	bl ovl08_215A7F8
	ldr r0, _02169414 // =aCharJb3listNsc
	ldr r1, _02169418 // =GX_LoadBG3Scr
	bl ovl08_215A7F8
	add r0, sp, #0
	bl ovl08_215A840
	mov r1, #0
	mov r2, #4
	bl ovl08_2174AF4
	ldr r1, _0216941C // =0x0217E8B4
	ldr r2, [r1]
	str r0, [r2, #8]
	ldr r0, [r1]
	ldr r0, [r0, #8]
	bl ovl08_216E000
	bl ovl08_216DFB8
	add r0, sp, #0x17
	bl ovl08_215A840
	mov r1, #0
	mov r2, #4
	bl ovl08_2174AF4
	ldr r1, _0216941C // =0x0217E8B4
	ldr r1, [r1]
	str r0, [r1, #0xc]
	add r0, sp, #0x2c
	bl ovl08_215A840
	mov r1, #0
	mov r2, #4
	bl ovl08_2174AF4
	ldr r1, _0216941C // =0x0217E8B4
	ldr r2, _02169420 // =0x04001008
	ldr r3, [r1]
	ldr r1, _02169424 // =0x0400100A
	str r0, [r3, #0x10]
	ldrh r0, [r2]
	ldr ip, _02169428 // =0x04000008
	ldr r3, _0216942C // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	ldr r2, _021693F0 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _02169430 // =0x0400000E
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #2
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #2
	strh r0, [r1]
	add sp, sp, #0x44
	ldmia sp!, {pc}
	.align 2, 0
_021693E4: .word aCharJb3listbac
_021693E8: .word aCharYbbgstep2N
_021693EC: .word aCharYbbgstep21
_021693F0: .word 0x0400000C
_021693F4: .word 0x00000E18
_021693F8: .word aCharYbobjkbNcl
_021693FC: .word GX_LoadOBJPltt
_02169400: .word aCharJbbgstep2N
_02169404: .word GX_LoadBG3Char
_02169408: .word aCharJbbgstep21
_0216940C: .word GX_LoadBG2Char
_02169410: .word GX_LoadBGPltt
_02169414: .word aCharJb3listNsc
_02169418: .word GX_LoadBG3Scr
_0216941C: .word 0x0217E8B4
_02169420: .word 0x04001008
_02169424: .word 0x0400100A
_02169428: .word 0x04000008
_0216942C: .word 0x0400000A
_02169430: .word 0x0400000E
	arm_func_end ovl08_2169244

	arm_func_start ovl08_2169434
ovl08_2169434: // 0x02169434
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	bl ovl08_216F84C
	mov r5, r0
	mov r0, #0x48
	mov r1, #4
	bl ovl08_2176764
	ldr r1, _02169620 // =0x0217E8B4
	mov r2, #0xc
	str r0, [r1]
	ldrb r3, [r5, #0xf6]
	strb r3, [r0, #0x43]
	ldr r0, [r1]
	strb r2, [r0, #0x42]
	bl ovl08_21691C4
	bl ovl08_216921C
	ldr r0, _02169624 // =0x0217E8A8
	ldrb r0, [r0]
	cmp r0, #0
	bne _021694A4
	bl ovl08_215E600
	ldr r1, _02169628 // =0x0217ABBC
	ldrb r2, [r5, #0xf4]
	ldrsb r1, [r1, r0]
	mov r0, #0x30
	add r2, r2, #1
	bl ovl08_215A51C
	b _021694B4
_021694A4:
	mov r0, #0x45
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
_021694B4:
	mov r0, #1
	bl ovl08_215A7A8
	bl ovl08_215AB10
	ldr r0, _0216962C // =0x0217E8B0
	mov r1, #0x37
	ldrh r3, [r0]
	ldr r2, _02169630 // =0xE1FC780F
	mov r0, #2
	mul r4, r3, r1
	smull r1, r3, r2, r4
	add r3, r4, r3
	mov r3, r3, asr #7
	mov r1, r4, lsr #0x1f
	add r3, r1, r3
	str r3, [sp]
	mov r1, #0x55
	mov r2, #0xf1
	mov r3, #0x41
	bl ovl08_216E6A0
	mov r0, #0
	mov r1, #1
	bl ovl08_2175F00
	ldr r6, _02169620 // =0x0217E8B4
	mov r4, #0
	ldr r2, [r6]
	ldr r1, _02169634 // =0x0217AC10
	str r0, [r2, #0x14]
	ldrb r8, [r1, #1]
	mov r7, r4
_02169528:
	mov r0, r7
	mov r1, r8
	bl ovl08_2175570
	ldr r1, [r6]
	add r1, r1, r4, lsl #2
	add r4, r4, #1
	str r0, [r1, #0x18]
	cmp r4, #7
	blt _02169528
	ldrb r0, [r5, #0xe7]
	cmp r0, #1
	beq _02169564
	cmp r0, #2
	beq _02169598
	b _021695C8
_02169564:
	mov r0, #0
	mov r1, #0x50
	bl ovl08_2175570
	ldr r1, _02169620 // =0x0217E8B4
	ldr r2, [r1]
	str r0, [r2, #0x34]
	ldr r0, [r1]
	ldr r1, [r0, #0x34]
	ldrh r0, [r1, #4]
	bic r0, r0, #0xc00
	orr r0, r0, #0xc00
	strh r0, [r1, #4]
	b _021695C8
_02169598:
	mov r0, #0
	mov r1, #0x51
	bl ovl08_2175570
	ldr r1, _02169620 // =0x0217E8B4
	ldr r2, [r1]
	str r0, [r2, #0x34]
	ldr r0, [r1]
	ldr r1, [r0, #0x34]
	ldrh r0, [r1, #4]
	bic r0, r0, #0xc00
	orr r0, r0, #0xc00
	strh r0, [r1, #4]
_021695C8:
	ldr r1, _02169638 // =ovl08_2167690
	mov r0, #1
	mov r2, #0
	mov r3, #0x6e
	bl ovl08_2177924
	ldr r2, _02169620 // =0x0217E8B4
	ldr r1, _0216963C // =ovl08_21670C4
	ldr r2, [r2]
	mov r3, #0x78
	str r0, [r2, #0x3c]
	mov r0, #0
	mov r2, r0
	bl ovl08_2177924
	ldr r1, _02169620 // =0x0217E8B4
	ldr r1, [r1]
	str r0, [r1]
	bl ovl08_2168474
	bl ovl08_21675A8
	ldr r0, _02169640 // =ovl08_2169168
	bl DWCi_ChangeScene
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02169620: .word 0x0217E8B4
_02169624: .word 0x0217E8A8
_02169628: .word 0x0217ABBC
_0216962C: .word 0x0217E8B0
_02169630: .word 0xE1FC780F
_02169634: .word 0x0217AC10
_02169638: .word ovl08_2167690
_0216963C: .word ovl08_21670C4
_02169640: .word ovl08_2169168
	arm_func_end ovl08_2169434

	arm_func_start ovl08_2169644
ovl08_2169644: // 0x02169644
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x14
	bl ovl08_217661C
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _021696AC // =ovl08_216BDFC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021696AC: .word ovl08_216BDFC
	arm_func_end ovl08_2169644

	arm_func_start ovl08_21696B0
ovl08_21696B0: // 0x021696B0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x14
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _021696F0 // =ovl08_2169644
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021696F0: .word ovl08_2169644
	arm_func_end ovl08_21696B0

	arm_func_start ovl08_21696F4
ovl08_21696F4: // 0x021696F4
	bx lr
	arm_func_end ovl08_21696F4

	arm_func_start ovl08_21696F8
ovl08_21696F8: // 0x021696F8
	bx lr
	arm_func_end ovl08_21696F8

	arm_func_start ovl08_21696FC
ovl08_21696FC: // 0x021696FC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21696F8
	bl ovl08_21696F4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216972C // =ovl08_21696B0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216972C: .word ovl08_21696B0
	arm_func_end ovl08_21696FC

	arm_func_start ovl08_2169730
ovl08_2169730: // 0x02169730
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov ip, #0
	mov r0, #0x44
	mov r1, #5
	mov r2, #1
	mvn r3, #0
	str ip, [sp]
	bl ovl08_21715E4
	ldr r0, _0216978C // =ovl08_21696FC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216978C: .word ovl08_21696FC
	arm_func_end ovl08_2169730

	arm_func_start ovl08_2169790
ovl08_2169790: // 0x02169790
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x14
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x14
	bl ovl08_2176678
	ldr r0, _021697E8 // =ovl08_2169730
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021697E8: .word ovl08_2169730
	arm_func_end ovl08_2169790

	arm_func_start ovl08_21697EC
ovl08_21697EC: // 0x021697EC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02169870 // =aCharJbbgstep3N_1
	ldr r1, _02169874 // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r0, _02169878 // =aCharYbbgstep3N_1
	ldr r1, _0216987C // =GX_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _02169880 // =aCharXb4noneNsc
	ldr r1, _02169884 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr ip, _02169888 // =0x04001008
	ldr r3, _0216988C // =0x0400100A
	ldrh r0, [ip]
	ldr r2, _02169890 // =0x0400000A
	ldr r1, _02169894 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169870: .word aCharJbbgstep3N_1
_02169874: .word GX_LoadBG2Char
_02169878: .word aCharYbbgstep3N_1
_0216987C: .word GX_LoadBGPltt
_02169880: .word aCharXb4noneNsc
_02169884: .word GX_LoadBG2Scr
_02169888: .word 0x04001008
_0216988C: .word 0x0400100A
_02169890: .word 0x0400000A
_02169894: .word 0x0400000C
	arm_func_end ovl08_21697EC

	arm_func_start ovl08_2169898
ovl08_2169898: // 0x02169898
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21697EC
	bl ovl08_215AB30
	bl ovl08_216F224
	ldr r0, _021698BC // =ovl08_2169790
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021698BC: .word ovl08_2169790
	arm_func_end ovl08_2169898

	arm_func_start ovl08_21698C0
ovl08_21698C0: // 0x021698C0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _021698E8 // =ovl08_2169B18
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021698E8: .word ovl08_2169B18
	arm_func_end ovl08_21698C0

	arm_func_start ovl08_21698EC
ovl08_21698EC: // 0x021698EC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_2171598
	ldr r0, _02169920 // =ovl08_21698C0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169920: .word ovl08_21698C0
	arm_func_end ovl08_21698EC

	arm_func_start ovl08_2169924
ovl08_2169924: // 0x02169924
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215F20C
	cmp r0, #2
	beq _02169948
	cmp r0, #4
	beq _02169964
	add sp, sp, #4
	ldmia sp!, {pc}
_02169948:
	ldr r1, _021699AC // =0x0217E8B8
	mov r2, #1
	ldr r0, _021699B0 // =ovl08_2169B18
	strb r2, [r1]
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02169964:
	ldr r0, _021699AC // =0x0217E8B8
	mov r1, #0
	strb r1, [r0]
	bl ovl08_216F8D0
	mov r0, #9
	bl ovl08_216F934
	mov r1, #1
	mov ip, #0
	mov r2, r1
	mov r0, #0xd
	mvn r3, #0
	str ip, [sp]
	bl ovl08_21715E4
	bl ovl08_215A308
	ldr r0, _021699B4 // =ovl08_21698EC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021699AC: .word 0x0217E8B8
_021699B0: .word ovl08_2169B18
_021699B4: .word ovl08_21698EC
	arm_func_end ovl08_2169924

	arm_func_start ovl08_21699B8
ovl08_21699B8: // 0x021699B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02169A8C // =0x0217E8B8
	ldrb r0, [r0]
	cmp r0, #0
	bne _021699F8
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
_021699F8:
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_2159CD8
	mov r0, #0
	bl ovl08_2175D6C
	ldr r0, _02169A8C // =0x0217E8B8
	ldrb r0, [r0]
	cmp r0, #0
	bne _02169A34
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
_02169A34:
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	ldr r0, _02169A8C // =0x0217E8B8
	ldrb r0, [r0]
	cmp r0, #0
	bne _02169A70
	bl ovl08_215F2C8
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02169A90 // =ovl08_216C5AC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02169A70:
	mov r0, #0
	mov r1, r0
	bl ovl08_215E674
	ldr r0, _02169A94 // =ovl08_216A240
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169A8C: .word 0x0217E8B8
_02169A90: .word ovl08_216C5AC
_02169A94: .word ovl08_216A240
	arm_func_end ovl08_21699B8

	arm_func_start ovl08_2169A98
ovl08_2169A98: // 0x02169A98
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02169B10 // =0x0217E8B8
	ldrb r0, [r0]
	cmp r0, #0
	bne _02169AC8
	bl ovl08_215A3AC
_02169AC8:
	ldr r0, _02169B10 // =0x0217E8B8
	ldrb r0, [r0]
	cmp r0, #0
	bne _02169AEC
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
_02169AEC:
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _02169B14 // =ovl08_21699B8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169B10: .word 0x0217E8B8
_02169B14: .word ovl08_21699B8
	arm_func_end ovl08_2169A98

	arm_func_start ovl08_2169B18
ovl08_2169B18: // 0x02169B18
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _02169B3C // =ovl08_2169A98
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169B3C: .word ovl08_2169A98
	arm_func_end ovl08_2169B18

	arm_func_start ovl08_2169B40
ovl08_2169B40: // 0x02169B40
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_216F8D0
	mov r0, #7
	bl ovl08_216F934
	ldr r0, _02169B74 // =ovl08_2169B18
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169B74: .word ovl08_2169B18
	arm_func_end ovl08_2169B40

	arm_func_start ovl08_2169B78
ovl08_2169B78: // 0x02169B78
	bx lr
	arm_func_end ovl08_2169B78

	arm_func_start ovl08_2169B7C
ovl08_2169B7C: // 0x02169B7C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	beq _02169BA4
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
_02169BA4:
	bl ovl08_2169D74
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2169B7C

	arm_func_start ovl08_2169BC4
ovl08_2169BC4: // 0x02169BC4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0xa
	bl OS_Sleep
	bl ovl08_2169924
	bl ovl08_2169B7C
	bl ovl08_2169B78
	bl ovl08_2169B40
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2169BC4

	arm_func_start ovl08_2169BEC
ovl08_2169BEC: // 0x02169BEC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _02169C1C // =ovl08_2169BC4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169C1C: .word ovl08_2169BC4
	arm_func_end ovl08_2169BEC

	arm_func_start ovl08_2169C20
ovl08_2169C20: // 0x02169C20
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #1
	bl ovl08_215A770
	ldr r0, _02169C54 // =ovl08_2169BEC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169C54: .word ovl08_2169BEC
	arm_func_end ovl08_2169C20

	arm_func_start ovl08_2169C58
ovl08_2169C58: // 0x02169C58
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _02169C90 // =ovl08_2169C20
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169C90: .word ovl08_2169C20
	arm_func_end ovl08_2169C58

	arm_func_start ovl08_2169C94
ovl08_2169C94: // 0x02169C94
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02169D14 // =aCharXb4multiNs_2
	ldr r1, _02169D18 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _02169D1C // =0x04001008
	ldr ip, _02169D20 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _02169D24 // =0x04000008
	ldr r2, _02169D28 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _02169D2C // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169D14: .word aCharXb4multiNs_2
_02169D18: .word GX_LoadBG2Scr
_02169D1C: .word 0x04001008
_02169D20: .word 0x0400100A
_02169D24: .word 0x04000008
_02169D28: .word 0x0400000A
_02169D2C: .word 0x0400000C
	arm_func_end ovl08_2169C94

	arm_func_start ovl08_2169D30
ovl08_2169D30: // 0x02169D30
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02169D6C // =0x0217E8B8
	mov r1, #0
	strb r1, [r0]
	bl ovl08_2169C94
	bl ovl08_215AB30
	mov r0, #0x25
	bl ovl08_215A6F4
	mov r0, #1
	bl ovl08_2159D18
	ldr r0, _02169D70 // =ovl08_2169C58
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169D6C: .word 0x0217E8B8
_02169D70: .word ovl08_2169C58
	arm_func_end ovl08_2169D30

	arm_func_start ovl08_2169D74
ovl08_2169D74: // 0x02169D74
	ldr r0, _02169D90 // =0x027FFFA8
	ldrh r0, [r0]
	and r0, r0, #0x8000
	movs r0, r0, asr #0xf
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02169D90: .word 0x027FFFA8
	arm_func_end ovl08_2169D74

	arm_func_start ovl08_2169D94
ovl08_2169D94: // 0x02169D94
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02169DBC // =ovl08_216A028
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169DBC: .word ovl08_216A028
	arm_func_end ovl08_2169D94

	arm_func_start ovl08_2169DC0
ovl08_2169DC0: // 0x02169DC0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_2171598
	ldr r0, _02169DF4 // =ovl08_2169D94
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169DF4: .word ovl08_2169D94
	arm_func_end ovl08_2169DC0

	arm_func_start ovl08_2169DF8
ovl08_2169DF8: // 0x02169DF8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215F20C
	cmp r0, #3
	beq _02169E24
	cmp r0, #4
	beq _02169E48
	cmp r0, #5
	beq _02169E90
	add sp, sp, #4
	ldmia sp!, {pc}
_02169E24:
	ldr r0, _02169ED8 // =0x0217E8BC
	mov r1, #1
	strb r1, [r0]
	bl ovl08_216F8D0
	bl ovl08_215F1E0
	ldr r0, _02169EDC // =ovl08_216A028
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02169E48:
	ldr r0, _02169ED8 // =0x0217E8BC
	mov r1, #0
	strb r1, [r0]
	bl ovl08_216F8D0
	mov r0, #9
	bl ovl08_216F934
	mov r1, #1
	mov ip, #0
	mov r2, r1
	mov r0, #0xd
	mvn r3, #0
	str ip, [sp]
	bl ovl08_21715E4
	bl ovl08_215A308
	ldr r0, _02169EE0 // =ovl08_2169DC0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02169E90:
	ldr r0, _02169ED8 // =0x0217E8BC
	mov r1, #0
	strb r1, [r0]
	bl ovl08_216F8D0
	mov r0, #0x12
	bl ovl08_216F934
	mov r1, #1
	mov ip, #0
	mov r2, r1
	mov r0, #0xe
	mvn r3, #0
	str ip, [sp]
	bl ovl08_21715E4
	bl ovl08_215A308
	ldr r0, _02169EE0 // =ovl08_2169DC0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169ED8: .word 0x0217E8BC
_02169EDC: .word ovl08_216A028
_02169EE0: .word ovl08_2169DC0
	arm_func_end ovl08_2169DF8

	arm_func_start ovl08_2169EE4
ovl08_2169EE4: // 0x02169EE4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02169FAC // =0x0217E8BC
	ldrb r0, [r0]
	cmp r0, #0
	bne _02169F24
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
_02169F24:
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_2159CD8
	mov r0, #0
	bl ovl08_2175D6C
	ldr r0, _02169FAC // =0x0217E8BC
	ldrb r0, [r0]
	cmp r0, #0
	bne _02169F60
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
_02169F60:
	bl ovl08_215F2C8
	ldr r0, _02169FAC // =0x0217E8BC
	ldrb r0, [r0]
	arm_func_end ovl08_2169EE4

	arm_func_start ovl08_2169F6C
ovl08_2169F6C: // 0x02169F6C
	cmp r0, #0
	bne _02169F90
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _02169FB0 // =ovl08_216C5AC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_02169F90:
	mov r0, #0
	mov r1, r0
	bl ovl08_215E674
	ldr r0, _02169FB4 // =ovl08_216A4CC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02169FAC: .word 0x0217E8BC
_02169FB0: .word ovl08_216C5AC
_02169FB4: .word ovl08_216A4CC
	arm_func_end ovl08_2169F6C

	arm_func_start ovl08_2169FB8
ovl08_2169FB8: // 0x02169FB8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A3AC
	ldr r0, _0216A020 // =0x0217E8BC
	ldrb r0, [r0]
	cmp r0, #0
	bne _02169FFC
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
_02169FFC:
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216A024 // =ovl08_2169EE4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A020: .word 0x0217E8BC
_0216A024: .word ovl08_2169EE4
	arm_func_end ovl08_2169FB8

	arm_func_start ovl08_216A028
ovl08_216A028: // 0x0216A028
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _0216A04C // =ovl08_2169FB8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A04C: .word ovl08_2169FB8
	arm_func_end ovl08_216A028

	arm_func_start ovl08_216A050
ovl08_216A050: // 0x0216A050
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_216F8D0
	mov r0, #7
	bl ovl08_216F934
	ldr r0, _0216A084 // =ovl08_216A028
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A084: .word ovl08_216A028
	arm_func_end ovl08_216A050

	arm_func_start ovl08_216A088
ovl08_216A088: // 0x0216A088
	bx lr
	arm_func_end ovl08_216A088

	arm_func_start ovl08_216A08C
ovl08_216A08C: // 0x0216A08C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	beq _0216A0B4
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
_0216A0B4:
	bl ovl08_216A284
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216A08C

	arm_func_start ovl08_216A0D4
ovl08_216A0D4: // 0x0216A0D4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0xa
	bl OS_Sleep
	bl ovl08_2169DF8
	bl ovl08_216A08C
	bl ovl08_216A088
	bl ovl08_216A050
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216A0D4

	arm_func_start ovl08_216A0FC
ovl08_216A0FC: // 0x0216A0FC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _0216A12C // =ovl08_216A0D4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A12C: .word ovl08_216A0D4
	arm_func_end ovl08_216A0FC

	arm_func_start ovl08_216A130
ovl08_216A130: // 0x0216A130
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #1
	bl ovl08_215A770
	ldr r0, _0216A164 // =ovl08_216A0FC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A164: .word ovl08_216A0FC
	arm_func_end ovl08_216A130

	arm_func_start ovl08_216A168
ovl08_216A168: // 0x0216A168
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _0216A1A0 // =ovl08_216A130
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A1A0: .word ovl08_216A130
	arm_func_end ovl08_216A168

	arm_func_start ovl08_216A1A4
ovl08_216A1A4: // 0x0216A1A4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216A224 // =aCharXb4multiNs_3
	ldr r1, _0216A228 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _0216A22C // =0x04001008
	ldr ip, _0216A230 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _0216A234 // =0x04000008
	ldr r2, _0216A238 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _0216A23C // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A224: .word aCharXb4multiNs_3
_0216A228: .word GX_LoadBG2Scr
_0216A22C: .word 0x04001008
_0216A230: .word 0x0400100A
_0216A234: .word 0x04000008
_0216A238: .word 0x0400000A
_0216A23C: .word 0x0400000C
	arm_func_end ovl08_216A1A4

	arm_func_start ovl08_216A240
ovl08_216A240: // 0x0216A240
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216A27C // =0x0217E8BC
	mov r1, #0
	strb r1, [r0]
	bl ovl08_216A1A4
	bl ovl08_215AB30
	mov r0, #0x2a
	bl ovl08_215A6F4
	mov r0, #2
	bl ovl08_2159D18
	ldr r0, _0216A280 // =ovl08_216A168
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A27C: .word 0x0217E8BC
_0216A280: .word ovl08_216A168
	arm_func_end ovl08_216A240

	arm_func_start ovl08_216A284
ovl08_216A284: // 0x0216A284
	ldr r0, _0216A2A0 // =0x027FFFA8
	ldrh r0, [r0]
	and r0, r0, #0x8000
	movs r0, r0, asr #0xf
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0216A2A0: .word 0x027FFFA8
	arm_func_end ovl08_216A284

	arm_func_start ovl08_216A2A4
ovl08_216A2A4: // 0x0216A2A4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216A2DC // =0x0217E8C0
	ldrb r1, [r0]
	add r1, r1, #1
	strb r1, [r0]
	ldrb r0, [r0]
	cmp r0, #0x78
	addlo sp, sp, #4
	ldmloia sp!, {pc}
	ldr r0, _0216A2E0 // =ovl08_216A364
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A2DC: .word 0x0217E8C0
_0216A2E0: .word ovl08_216A364
	arm_func_end ovl08_216A2A4

	arm_func_start ovl08_216A2E4
ovl08_216A2E4: // 0x0216A2E4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175D6C
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	mov r0, #0
	mov r1, r0
	bl ovl08_215E674
	mov r0, #0
	mov r1, #1
	bl ovl08_215E638
	ldr r0, _0216A360 // =ovl08_216D064
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A360: .word ovl08_216D064
	arm_func_end ovl08_216A2E4

	arm_func_start ovl08_216A364
ovl08_216A364: // 0x0216A364
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216A3A4 // =ovl08_216A2E4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A3A4: .word ovl08_216A2E4
	arm_func_end ovl08_216A364

	arm_func_start ovl08_216A3A8
ovl08_216A3A8: // 0x0216A3A8
	bx lr
	arm_func_end ovl08_216A3A8

	arm_func_start ovl08_216A3AC
ovl08_216A3AC: // 0x0216A3AC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216A2A4
	bl ovl08_216A3A8
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216A3AC

	arm_func_start ovl08_216A3C4
ovl08_216A3C4: // 0x0216A3C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216A3F0 // =ovl08_216A3AC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A3F0: .word ovl08_216A3AC
	arm_func_end ovl08_216A3C4

	arm_func_start ovl08_216A3F4
ovl08_216A3F4: // 0x0216A3F4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _0216A42C // =ovl08_216A3C4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A42C: .word ovl08_216A3C4
	arm_func_end ovl08_216A3F4

	arm_func_start ovl08_216A430
ovl08_216A430: // 0x0216A430
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216A4B0 // =aCharXb4multiNs_4
	ldr r1, _0216A4B4 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _0216A4B8 // =0x04001008
	ldr ip, _0216A4BC // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _0216A4C0 // =0x04000008
	ldr r2, _0216A4C4 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _0216A4C8 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A4B0: .word aCharXb4multiNs_4
_0216A4B4: .word GX_LoadBG2Scr
_0216A4B8: .word 0x04001008
_0216A4BC: .word 0x0400100A
_0216A4C0: .word 0x04000008
_0216A4C4: .word 0x0400000A
_0216A4C8: .word 0x0400000C
	arm_func_end ovl08_216A430

	arm_func_start ovl08_216A4CC
ovl08_216A4CC: // 0x0216A4CC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216A508 // =0x0217E8C0
	mov r1, #0
	strb r1, [r0]
	bl ovl08_216A430
	bl ovl08_215AB30
	mov r0, #0x26
	bl ovl08_215A6F4
	mov r0, #0x10
	bl ovl08_216F934
	ldr r0, _0216A50C // =ovl08_216A3F4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A508: .word 0x0217E8C0
_0216A50C: .word ovl08_216A3F4
	arm_func_end ovl08_216A4CC

	arm_func_start ovl08_216A510
ovl08_216A510: // 0x0216A510
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216A538 // =ovl08_216A768
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A538: .word ovl08_216A768
	arm_func_end ovl08_216A510

	arm_func_start ovl08_216A53C
ovl08_216A53C: // 0x0216A53C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_2171598
	ldr r0, _0216A570 // =ovl08_216A510
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A570: .word ovl08_216A510
	arm_func_end ovl08_216A53C

	arm_func_start ovl08_216A574
ovl08_216A574: // 0x0216A574
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215F20C
	cmp r0, #1
	beq _0216A598
	cmp r0, #4
	beq _0216A5B4
	add sp, sp, #4
	ldmia sp!, {pc}
_0216A598:
	ldr r1, _0216A5FC // =0x0217E8C4
	mov r2, #1
	ldr r0, _0216A600 // =ovl08_216A768
	strb r2, [r1]
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216A5B4:
	ldr r0, _0216A5FC // =0x0217E8C4
	mov r1, #0
	strb r1, [r0]
	bl ovl08_216F8D0
	mov r0, #9
	bl ovl08_216F934
	mov r1, #1
	mov ip, #0
	mov r2, r1
	mov r0, #0xd
	mvn r3, #0
	str ip, [sp]
	bl ovl08_21715E4
	bl ovl08_215A308
	ldr r0, _0216A604 // =ovl08_216A53C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A5FC: .word 0x0217E8C4
_0216A600: .word ovl08_216A768
_0216A604: .word ovl08_216A53C
	arm_func_end ovl08_216A574

	arm_func_start ovl08_216A608
ovl08_216A608: // 0x0216A608
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216A6DC // =0x0217E8C4
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216A648
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
_0216A648:
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_2159CD8
	mov r0, #0
	bl ovl08_2175D6C
	ldr r0, _0216A6DC // =0x0217E8C4
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216A684
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
_0216A684:
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	ldr r0, _0216A6DC // =0x0217E8C4
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216A6C0
	bl ovl08_215F2C8
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216A6E0 // =ovl08_216C5AC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216A6C0:
	mov r0, #0
	mov r1, r0
	bl ovl08_215E674
	ldr r0, _0216A6E4 // =ovl08_2169D30
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A6DC: .word 0x0217E8C4
_0216A6E0: .word ovl08_216C5AC
_0216A6E4: .word ovl08_2169D30
	arm_func_end ovl08_216A608

	arm_func_start ovl08_216A6E8
ovl08_216A6E8: // 0x0216A6E8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216A760 // =0x0217E8C4
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216A718
	bl ovl08_215A3AC
_0216A718:
	ldr r0, _0216A760 // =0x0217E8C4
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216A73C
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
_0216A73C:
	mov r0, #3
	mov r1, #0
	mov r2, #0x14
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216A764 // =ovl08_216A608
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A760: .word 0x0217E8C4
_0216A764: .word ovl08_216A608
	arm_func_end ovl08_216A6E8

	arm_func_start ovl08_216A768
ovl08_216A768: // 0x0216A768
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _0216A78C // =ovl08_216A6E8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A78C: .word ovl08_216A6E8
	arm_func_end ovl08_216A768

	arm_func_start ovl08_216A790
ovl08_216A790: // 0x0216A790
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_216F8D0
	mov r0, #7
	bl ovl08_216F934
	ldr r0, _0216A7C4 // =ovl08_216A768
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A7C4: .word ovl08_216A768
	arm_func_end ovl08_216A790

	arm_func_start ovl08_216A7C8
ovl08_216A7C8: // 0x0216A7C8
	bx lr
	arm_func_end ovl08_216A7C8

	arm_func_start ovl08_216A7CC
ovl08_216A7CC: // 0x0216A7CC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	beq _0216A7F4
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
_0216A7F4:
	bl ovl08_216AA44
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216A7CC

	arm_func_start ovl08_216A814
ovl08_216A814: // 0x0216A814
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0xa
	bl OS_Sleep
	bl ovl08_216A574
	bl ovl08_216A7CC
	bl ovl08_216A7C8
	bl ovl08_216A790
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216A814

	arm_func_start ovl08_216A83C
ovl08_216A83C: // 0x0216A83C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _0216A86C // =ovl08_216A814
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A86C: .word ovl08_216A814
	arm_func_end ovl08_216A83C

	arm_func_start ovl08_216A870
ovl08_216A870: // 0x0216A870
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215F2F4
	mov r0, #1
	bl ovl08_215A770
	ldr r0, _0216A8BC // =ovl08_216A83C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A8BC: .word ovl08_216A83C
	arm_func_end ovl08_216A870

	arm_func_start ovl08_216A8C0
ovl08_216A8C0: // 0x0216A8C0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _0216A918 // =ovl08_216A870
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A918: .word ovl08_216A870
	arm_func_end ovl08_216A8C0

	arm_func_start ovl08_216A91C
ovl08_216A91C: // 0x0216A91C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216A9B4 // =aCharJbbgstep3N_4
	ldr r1, _0216A9B8 // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r0, _0216A9BC // =aCharYbbgstep3N_4
	ldr r1, _0216A9C0 // =GX_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _0216A9C4 // =aCharXb4multiNs_1
	ldr r1, _0216A9C8 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _0216A9CC // =0x04001008
	ldr ip, _0216A9D0 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _0216A9D4 // =0x04000008
	ldr r2, _0216A9D8 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _0216A9DC // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216A9B4: .word aCharJbbgstep3N_4
_0216A9B8: .word GX_LoadBG2Char
_0216A9BC: .word aCharYbbgstep3N_4
_0216A9C0: .word GX_LoadBGPltt
_0216A9C4: .word aCharXb4multiNs_1
_0216A9C8: .word GX_LoadBG2Scr
_0216A9CC: .word 0x04001008
_0216A9D0: .word 0x0400100A
_0216A9D4: .word 0x04000008
_0216A9D8: .word 0x0400000A
_0216A9DC: .word 0x0400000C
	arm_func_end ovl08_216A91C

	arm_func_start ovl08_216A9E0
ovl08_216A9E0: // 0x0216A9E0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216AA3C // =0x0217E8C4
	mov r1, #0
	strb r1, [r0]
	bl ovl08_216A91C
	bl ovl08_215AB30
	mov r0, #0x37
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	mov r0, #2
	bl ovl08_215A7A8
	mov r0, #0x24
	bl ovl08_215A6F4
	mov r0, #0
	bl ovl08_2159D18
	mov r0, #0xb
	bl ovl08_216F934
	ldr r0, _0216AA40 // =ovl08_216A8C0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216AA3C: .word 0x0217E8C4
_0216AA40: .word ovl08_216A8C0
	arm_func_end ovl08_216A9E0

	arm_func_start ovl08_216AA44
ovl08_216AA44: // 0x0216AA44
	ldr r0, _0216AA60 // =0x027FFFA8
	ldrh r0, [r0]
	and r0, r0, #0x8000
	movs r0, r0, asr #0xf
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0216AA60: .word 0x027FFFA8
	arm_func_end ovl08_216AA44

	arm_func_start ovl08_216AA64
ovl08_216AA64: // 0x0216AA64
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216AA8C // =ovl08_216AC08
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216AA8C: .word ovl08_216AC08
	arm_func_end ovl08_216AA64

	arm_func_start ovl08_216AA90
ovl08_216AA90: // 0x0216AA90
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_2171598
	ldr r0, _0216AAC4 // =ovl08_216AA64
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216AAC4: .word ovl08_216AA64
	arm_func_end ovl08_216AA90

	arm_func_start ovl08_216AAC8
ovl08_216AAC8: // 0x0216AAC8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
_0216AB08:
	bl ovl08_216EA84
	cmp r0, #0
	beq _0216AB08
	bl ovl08_2159CD8
	mov r0, #0
	bl ovl08_2175D6C
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	ldr r0, _0216ABA0 // =0x0217E8C8
	ldrb r0, [r0]
	cmp r0, #1
	beq _0216AB78
	bl ovl08_216EC58
	bl ovl08_216F84C
	ldrb r0, [r0, #0xf4]
	bl ovl08_216F30C
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216ABA4 // =ovl08_216C5AC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216AB78:
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	mov r0, #0
	mov r1, r0
	bl ovl08_215E638
	ldr r0, _0216ABA8 // =ovl08_2164CC0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216ABA0: .word 0x0217E8C8
_0216ABA4: .word ovl08_216C5AC
_0216ABA8: .word ovl08_2164CC0
	arm_func_end ovl08_216AAC8

	arm_func_start ovl08_216ABAC
ovl08_216ABAC: // 0x0216ABAC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A3AC
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216AC04 // =ovl08_216AAC8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216AC04: .word ovl08_216AAC8
	arm_func_end ovl08_216ABAC

	arm_func_start ovl08_216AC08
ovl08_216AC08: // 0x0216AC08
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _0216AC2C // =ovl08_216ABAC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216AC2C: .word ovl08_216ABAC
	arm_func_end ovl08_216AC08

	arm_func_start ovl08_216AC30
ovl08_216AC30: // 0x0216AC30
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_216F8D0
	mov r0, #7
	bl ovl08_216F934
	ldr r0, _0216AC64 // =ovl08_216AC08
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216AC64: .word ovl08_216AC08
	arm_func_end ovl08_216AC30

	arm_func_start ovl08_216AC68
ovl08_216AC68: // 0x0216AC68
	bx lr
	arm_func_end ovl08_216AC68

	arm_func_start ovl08_216AC6C
ovl08_216AC6C: // 0x0216AC6C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_216F8D0
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216AC6C

	arm_func_start ovl08_216AC9C
ovl08_216AC9C: // 0x0216AC9C
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r0, _0216ADB8 // =0x0217E8CC
	ldrh r1, [r0]
	add r1, r1, #1
	strh r1, [r0]
	ldrh r0, [r0]
	cmp r0, #0x12c
	addlo sp, sp, #0xc
	ldmloia sp!, {pc}
	bl ovl08_216F8D0
	add r0, sp, #4
	bl ovl08_216EA24
	cmp r0, #0
	bne _0216AD1C
	ldr r0, _0216ADBC // =0x0217E8C8
	mov r3, #2
	strb r3, [r0]
	mov r1, #1
	mov ip, #0
	mov r2, r1
	mov r0, #0xf
	mvn r3, #0
	str ip, [sp]
	bl ovl08_21715E4
	mov r0, #0x12
	bl ovl08_216F934
	bl ovl08_215A308
	ldr r0, _0216ADC0 // =ovl08_216AA90
	bl DWCi_ChangeScene
	add sp, sp, #0xc
	ldmia sp!, {pc}
_0216AD1C:
	cmp r0, #0
	mov r3, #0
	ble _0216AD48
	ldr r2, [sp, #4]
_0216AD2C:
	ldrb r1, [r2, #0x28]
	cmp r1, #2
	bne _0216AD48
	add r3, r3, #1
	cmp r3, r0
	add r2, r2, #0x2a
	blt _0216AD2C
_0216AD48:
	cmp r3, r0
	bne _0216AD94
	ldr r0, _0216ADBC // =0x0217E8C8
	mov r3, #3
	strb r3, [r0]
	mov r1, #1
	mov ip, #0
	mov r2, r1
	mov r0, #0xe
	mvn r3, #0
	str ip, [sp]
	bl ovl08_21715E4
	mov r0, #0x12
	bl ovl08_216F934
	bl ovl08_215A308
	ldr r0, _0216ADC0 // =ovl08_216AA90
	bl DWCi_ChangeScene
	add sp, sp, #0xc
	ldmia sp!, {pc}
_0216AD94:
	ldr r1, _0216ADBC // =0x0217E8C8
	mov r2, #1
	mov r0, #0xf
	strb r2, [r1]
	bl ovl08_216F934
	ldr r0, _0216ADC4 // =ovl08_216AC08
	bl DWCi_ChangeScene
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0216ADB8: .word 0x0217E8CC
_0216ADBC: .word 0x0217E8C8
_0216ADC0: .word ovl08_216AA90
_0216ADC4: .word ovl08_216AC08
	arm_func_end ovl08_216AC9C

	arm_func_start ovl08_216ADC8
ovl08_216ADC8: // 0x0216ADC8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216AC6C
	bl ovl08_216AC68
	bl ovl08_216AC30
	bl ovl08_216AC9C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216ADC8

	arm_func_start ovl08_216ADE8
ovl08_216ADE8: // 0x0216ADE8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _0216AE18 // =ovl08_216ADC8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216AE18: .word ovl08_216ADC8
	arm_func_end ovl08_216ADE8

	arm_func_start ovl08_216AE1C
ovl08_216AE1C: // 0x0216AE1C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #1
	bl ovl08_215A770
	ldr r0, _0216AE64 // =ovl08_216ADE8
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216AE64: .word ovl08_216ADE8
	arm_func_end ovl08_216AE1C

	arm_func_start ovl08_216AE68
ovl08_216AE68: // 0x0216AE68
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _0216AEC0 // =ovl08_216AE1C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216AEC0: .word ovl08_216AE1C
	arm_func_end ovl08_216AE68

	arm_func_start ovl08_216AEC4
ovl08_216AEC4: // 0x0216AEC4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216AF5C // =aCharJbbgstep3N_2
	ldr r1, _0216AF60 // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r0, _0216AF64 // =aCharYbbgstep3N_2
	ldr r1, _0216AF68 // =GX_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _0216AF6C // =aCharXb4multiNs
	ldr r1, _0216AF70 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _0216AF74 // =0x04001008
	ldr ip, _0216AF78 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _0216AF7C // =0x04000008
	ldr r2, _0216AF80 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _0216AF84 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216AF5C: .word aCharJbbgstep3N_2
_0216AF60: .word GX_LoadBG2Char
_0216AF64: .word aCharYbbgstep3N_2
_0216AF68: .word GX_LoadBGPltt
_0216AF6C: .word aCharXb4multiNs
_0216AF70: .word GX_LoadBG2Scr
_0216AF74: .word 0x04001008
_0216AF78: .word 0x0400100A
_0216AF7C: .word 0x04000008
_0216AF80: .word 0x0400000A
_0216AF84: .word 0x0400000C
	arm_func_end ovl08_216AEC4

	arm_func_start ovl08_216AF88
ovl08_216AF88: // 0x0216AF88
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0216AFF4 // =0x0217E8CC
	mov r2, #0
	ldr r0, _0216AFF8 // =0x0217E8C8
	strh r2, [r1]
	strb r2, [r0]
	bl ovl08_216AEC4
	mov r0, #0x33
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	bl ovl08_215AB30
	mov r0, #2
	bl ovl08_215A7A8
	mov r0, #0x33
	bl ovl08_215A6F4
	mov r0, #0
	bl ovl08_2159D18
	bl ovl08_216EC94
	bl ovl08_216EB74
	mov r0, #0xa
	bl ovl08_216F934
	ldr r0, _0216AFFC // =ovl08_216AE68
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216AFF4: .word 0x0217E8CC
_0216AFF8: .word 0x0217E8C8
_0216AFFC: .word ovl08_216AE68
	arm_func_end ovl08_216AF88

	arm_func_start ovl08_216B000
ovl08_216B000: // 0x0216B000
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r2, _0216B0D4 // =0x0217ACC8
	ldr r1, _0216B0D8 // =0x0217ACCC
	ldrb r7, [r2]
	ldrb r6, [r2, #1]
	ldrb r5, [r2, #2]
	ldrb r4, [r2, #3]
	ldrb lr, [r1]
	ldrb ip, [r1, #1]
	ldrb r3, [r1, #2]
	ldrb r2, [r1, #3]
	ldr r0, _0216B0DC // =0x0217E8D0
	strb r7, [sp]
	ldrb r1, [r0]
	strb r2, [sp, #7]
	strb r6, [sp, #1]
	strb r5, [sp, #2]
	strb r4, [sp, #3]
	strb lr, [sp, #4]
	strb ip, [sp, #5]
	strb r3, [sp, #6]
	cmp r1, #3
	add r2, sp, #0
	addhi sp, sp, #0xc
	ldmhiia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0216B0E0 // =0x0217E8D4
	ldrb r1, [r2, r1]
	ldr r0, [r0]
	ldr r0, [r0]
	mov r2, r1
	bl ovl08_216DEC4
	ldr r0, _0216B0DC // =0x0217E8D0
	ldrb r0, [r0]
	cmp r0, #3
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl ovl08_216F3F4
	ldr r1, _0216B0DC // =0x0217E8D0
	ldr r2, _0216B0E0 // =0x0217E8D4
	ldrb r3, [r1]
	ldr r2, [r2]
	cmp r0, #2
	movgt r0, #3
	add r1, sp, #4
	add r2, r2, r3, lsl #2
	ldrb r3, [r1, r0]
	ldr r0, [r2, #4]
	mvn r1, #0
	mov r2, #0
	bl ovl08_21750B0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216B0D4: .word 0x0217ACC8
_0216B0D8: .word 0x0217ACCC
_0216B0DC: .word 0x0217E8D0
_0216B0E0: .word 0x0217E8D4
	arm_func_end ovl08_216B000

	arm_func_start ovl08_216B0E4
ovl08_216B0E4: // 0x0216B0E4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _0216B110 // =ovl08_216BAC0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216B110: .word ovl08_216BAC0
	arm_func_end ovl08_216B0E4

	arm_func_start ovl08_216B114
ovl08_216B114: // 0x0216B114
	stmdb sp!, {r4, lr}
	ldr r0, _0216B274 // =0x0217E8D0
	ldrb r0, [r0]
	sub r4, r0, #4
	bl ovl08_2171584
	cmp r0, #0
	beq _0216B1E8
	cmp r0, #1
	ldmneia sp!, {r4, pc}
	mov r0, #0xe
	bl ovl08_216F934
	mov r0, r4
	bl ovl08_216EFA0
	ldr r0, _0216B278 // =0x0217E8D4
	mov r1, #0
	ldr r0, [r0]
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #4]
	bl ovl08_21751F8
	ldr r1, _0216B27C // =0x0217ACC4
	mov r2, r0
	ldrb r1, [r1, #3]
	mov r0, #0
	bl ovl08_217559C
	ldr r0, _0216B278 // =0x0217E8D4
	mov ip, r4, lsl #2
	ldr r0, [r0]
	mvn r1, #0
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #4]
	ldr r2, _0216B280 // =0x0217ACF0
	ldr r3, _0216B284 // =0x0217ACF2
	ldrh r2, [r2, ip]
	ldrh r3, [r3, ip]
	bl ovl08_2174FA4
	ldr r0, _0216B278 // =0x0217E8D4
	mvn r1, #0
	ldr r0, [r0]
	mov r2, #3
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #4]
	bl ovl08_2174F30
	ldr r0, _0216B278 // =0x0217E8D4
	ldr r0, [r0]
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #0x10]
	bl ovl08_2175204
	mov r1, #0
	ldr r0, _0216B278 // =0x0217E8D4
	ldr r0, [r0]
	add r0, r0, r4, lsl #2
	str r1, [r0, #0x10]
	b _0216B264
_0216B1E8:
	mov r0, #7
	bl ovl08_216F934
	ldr r0, _0216B278 // =0x0217E8D4
	mov r1, #0
	ldr r0, [r0]
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #0x10]
	bl ovl08_21751F8
	mov r2, r0
	mov r0, #0
	mov r1, #0x11
	bl ovl08_217559C
	ldr r0, _0216B278 // =0x0217E8D4
	add r1, r4, #3
	ldr r0, [r0]
	mov ip, r1, lsl #2
	ldr r2, _0216B280 // =0x0217ACF0
	ldr r3, _0216B284 // =0x0217ACF2
	add r0, r0, r4, lsl #2
	ldrh r2, [r2, ip]
	ldrh r3, [r3, ip]
	ldr r0, [r0, #0x10]
	mvn r1, #0
	bl ovl08_2174FA4
	ldr r0, _0216B278 // =0x0217E8D4
	mvn r1, #0
	ldr r0, [r0]
	mov r2, #3
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #0x10]
	bl ovl08_2174F30
_0216B264:
	bl ovl08_2171598
	ldr r0, _0216B288 // =ovl08_216B0E4
	bl DWCi_ChangeScene
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B274: .word 0x0217E8D0
_0216B278: .word 0x0217E8D4
_0216B27C: .word 0x0217ACC4
_0216B280: .word 0x0217ACF0
_0216B284: .word 0x0217ACF2
_0216B288: .word ovl08_216B0E4
	arm_func_end ovl08_216B114

	arm_func_start ovl08_216B28C
ovl08_216B28C: // 0x0216B28C
	stmdb sp!, {r4, lr}
	ldr r1, _0216B314 // =0x0217E8D0
	ldr r0, _0216B318 // =0x0217E8D4
	ldrb r2, [r1]
	ldr r0, [r0]
	mov r1, #0
	sub r4, r2, #4
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #0x10]
	bl ovl08_21751F8
	mov r2, r0
	mov r0, #0
	mov r1, #0x32
	bl ovl08_217559C
	ldr r0, _0216B318 // =0x0217E8D4
	add r3, r4, #3
	ldr r2, [r0]
	ldr r1, _0216B31C // =0x0217ACF0
	mov r3, r3, lsl #2
	ldr r0, _0216B320 // =0x0217ACF2
	add ip, r2, r4, lsl #2
	ldrh r2, [r1, r3]
	ldrh r3, [r0, r3]
	ldr r0, [ip, #0x10]
	mvn r1, #0
	bl ovl08_2174FA4
	ldr r0, _0216B318 // =0x0217E8D4
	mvn r1, #0
	ldr r0, [r0]
	mov r2, #3
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #0x10]
	bl ovl08_2174F30
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B314: .word 0x0217E8D0
_0216B318: .word 0x0217E8D4
_0216B31C: .word 0x0217ACF0
_0216B320: .word 0x0217ACF2
	arm_func_end ovl08_216B28C

	arm_func_start ovl08_216B324
ovl08_216B324: // 0x0216B324
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, _0216B53C // =0x0217E8D0
	mov r1, #1
	ldrb r2, [r3]
	cmp r2, #6
	addls pc, pc, r2, lsl #2
	b _0216B51C
_0216B344: // jump table
	b _0216B360 // case 0
	b _0216B3A4 // case 1
	b _0216B3E8 // case 2
	b _0216B42C // case 3
	b _0216B458 // case 4
	b _0216B49C // case 5
	b _0216B4DC // case 6
_0216B360:
	ldr r2, _0216B540 // =0x0217E8D4
	cmp r0, #0
	ldr r2, [r2]
	mov ip, #0
	strb ip, [r2, #0x1c]
	moveq r0, #2
	streqb r0, [r3]
	beq _0216B51C
	cmp r0, #2
	streqb r1, [r3]
	beq _0216B51C
	cmp r0, #1
	moveq r0, #3
	streqb r0, [r3]
	movne r0, #4
	strneb r0, [r3]
	b _0216B51C
_0216B3A4:
	ldr r2, _0216B540 // =0x0217E8D4
	cmp r0, #0
	ldr r2, [r2]
	moveq r0, #0
	strb r1, [r2, #0x1c]
	streqb r0, [r3]
	beq _0216B51C
	cmp r0, #2
	moveq r0, #2
	streqb r0, [r3]
	beq _0216B51C
	cmp r0, #1
	moveq r0, #3
	streqb r0, [r3]
	movne r0, #5
	strneb r0, [r3]
	b _0216B51C
_0216B3E8:
	ldr r2, _0216B540 // =0x0217E8D4
	mov ip, #2
	ldr r2, [r2]
	cmp r0, #0
	strb ip, [r2, #0x1c]
	streqb r1, [r3]
	beq _0216B51C
	cmp r0, #2
	moveq r0, #0
	streqb r0, [r3]
	beq _0216B51C
	cmp r0, #1
	moveq r0, #3
	streqb r0, [r3]
	movne r0, #6
	strneb r0, [r3]
	b _0216B51C
_0216B42C:
	ldr r2, _0216B540 // =0x0217E8D4
	cmp r0, #1
	ldr r2, [r2]
	ldrb ip, [r2, #0x1c]
	add r2, ip, #4
	streqb r2, [r3]
	beq _0216B51C
	cmp r0, #3
	streqb ip, [r3]
	movne r1, #0
	b _0216B51C
_0216B458:
	ldr r2, _0216B540 // =0x0217E8D4
	cmp r0, #0
	ldr r2, [r2]
	mov ip, #0
	strb ip, [r2, #0x1c]
	moveq r0, #6
	streqb r0, [r3]
	beq _0216B51C
	cmp r0, #2
	moveq r0, #5
	streqb r0, [r3]
	beq _0216B51C
	cmp r0, #1
	streqb ip, [r3]
	movne r0, #3
	strneb r0, [r3]
	b _0216B51C
_0216B49C:
	ldr r2, _0216B540 // =0x0217E8D4
	cmp r0, #0
	ldr r2, [r2]
	moveq r0, #4
	strb r1, [r2, #0x1c]
	streqb r0, [r3]
	beq _0216B51C
	cmp r0, #2
	moveq r0, #6
	streqb r0, [r3]
	beq _0216B51C
	cmp r0, #1
	streqb r1, [r3]
	movne r0, #3
	strneb r0, [r3]
	b _0216B51C
_0216B4DC:
	ldr r2, _0216B540 // =0x0217E8D4
	cmp r0, #0
	ldr r2, [r2]
	mov ip, #2
	strb ip, [r2, #0x1c]
	moveq r0, #5
	streqb r0, [r3]
	beq _0216B51C
	cmp r0, #2
	moveq r0, #4
	streqb r0, [r3]
	beq _0216B51C
	cmp r0, #1
	streqb ip, [r3]
	movne r0, #3
	strneb r0, [r3]
_0216B51C:
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #8
	bl ovl08_216F934
	bl ovl08_216B544
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216B53C: .word 0x0217E8D0
_0216B540: .word 0x0217E8D4
	arm_func_end ovl08_216B324

	arm_func_start ovl08_216B544
ovl08_216B544: // 0x0216B544
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216B5B8 // =0x0217E8D0
	ldrb r2, [r0]
	cmp r2, #4
	bhs _0216B58C
	mov ip, r2, lsl #3
	ldr r0, _0216B5BC // =0x0217AD40
	ldr r1, _0216B5C0 // =0x0217AD44
	ldr r2, _0216B5C4 // =0x0217AD42
	ldr r3, _0216B5C8 // =0x0217AD46
	ldrh r0, [r0, ip]
	ldrh r1, [r1, ip]
	ldrh r2, [r2, ip]
	ldrh r3, [r3, ip]
	bl ovl08_215A8E0
	add sp, sp, #4
	ldmia sp!, {pc}
_0216B58C:
	ldr r1, _0216B5BC // =0x0217AD40
	mov r3, r2, lsl #3
	ldr r2, _0216B5C0 // =0x0217AD44
	ldr r0, _0216B5C4 // =0x0217AD42
	ldrh r1, [r1, r3]
	ldrh r2, [r2, r3]
	ldrh r3, [r0, r3]
	mov r0, #0
	bl ovl08_215A9CC
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216B5B8: .word 0x0217E8D0
_0216B5BC: .word 0x0217AD40
_0216B5C0: .word 0x0217AD44
_0216B5C4: .word 0x0217AD42
_0216B5C8: .word 0x0217AD46
	arm_func_end ovl08_216B544

	arm_func_start ovl08_216B5CC
ovl08_216B5CC: // 0x0216B5CC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	bl ovl08_216FABC
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r4, _0216B76C // =0x0217E8D4
	mov r5, #0
_0216B624:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _0216B63C
	bl ovl08_2175204
_0216B63C:
	add r5, r5, #1
	cmp r5, #3
	blo _0216B624
	ldr r4, _0216B76C // =0x0217E8D4
	mov r5, #0
_0216B650:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0216B668
	bl ovl08_2175204
_0216B668:
	add r5, r5, #1
	cmp r5, #3
	blo _0216B650
	bl ovl08_215A8A0
	bl ovl08_215A4D8
	ldr r0, _0216B76C // =0x0217E8D4
	ldr r0, [r0]
	ldr r0, [r0]
	bl ovl08_2174AB8
	ldr r0, _0216B770 // =aCharYbobjmainN_0
	ldr r1, _0216B774 // =GX_LoadOBJPltt
	bl ovl08_215A7F8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x14
	bl ovl08_217661C
	ldr r0, _0216B76C // =0x0217E8D4
	ldr r0, [r0]
	ldrb r0, [r0, #0x1d]
	cmp r0, #2
	bne _0216B6DC
	mov r0, #0
	mov r1, r0
	bl ovl08_215E674
	ldr r0, _0216B778 // =ovl08_215FC9C
	bl DWCi_ChangeScene
	b _0216B75C
_0216B6DC:
	ldr r0, _0216B77C // =0x0217E8D0
	ldrb r0, [r0]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0216B75C
_0216B6F0: // jump table
	b _0216B700 // case 0
	b _0216B700 // case 1
	b _0216B700 // case 2
	b _0216B748 // case 3
_0216B700:
	mov r0, #2
	mov r1, #0
	bl ovl08_215E674
	bl ovl08_216F84C
	ldrb r0, [r0, #0xe7]
	cmp r0, #0xff
	bne _0216B728
	ldr r0, _0216B780 // =ovl08_216C5AC
	bl DWCi_ChangeScene
	b _0216B75C
_0216B728:
	mov r0, #0
	mov r1, r0
	bl ovl08_215E638
	mov r0, #0
	bl ovl08_2166EDC
	ldr r0, _0216B784 // =ovl08_2169434
	bl DWCi_ChangeScene
	b _0216B75C
_0216B748:
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216B788 // =ovl08_216D704
	bl DWCi_ChangeScene
_0216B75C:
	ldr r0, _0216B76C // =0x0217E8D4
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216B76C: .word 0x0217E8D4
_0216B770: .word aCharYbobjmainN_0
_0216B774: .word GX_LoadOBJPltt
_0216B778: .word ovl08_215FC9C
_0216B77C: .word 0x0217E8D0
_0216B780: .word ovl08_216C5AC
_0216B784: .word ovl08_2169434
_0216B788: .word ovl08_216D704
	arm_func_end ovl08_216B5CC

	arm_func_start ovl08_216B78C
ovl08_216B78C: // 0x0216B78C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216B818 // =0x0217E8D4
	ldr r0, [r0]
	ldrb r0, [r0, #0x1d]
	cmp r0, #1
	bne _0216B7E0
	ldr r0, _0216B81C // =0x0217E8D0
	ldrb r0, [r0]
	cmp r0, #3
	beq _0216B7DC
	bl ovl08_216F84C
	ldrb r0, [r0, #0xe7]
	cmp r0, #0xff
	beq _0216B7E0
_0216B7DC:
	bl ovl08_215A3AC
_0216B7E0:
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x14
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216B820 // =ovl08_216B5CC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216B818: .word 0x0217E8D4
_0216B81C: .word 0x0217E8D0
_0216B820: .word ovl08_216B5CC
	arm_func_end ovl08_216B78C

	arm_func_start ovl08_216B824
ovl08_216B824: // 0x0216B824
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216B860 // =0x0217E8D4
	ldr r0, [r0]
	ldrb r0, [r0, #0x1d]
	cmp r0, #2
	bne _0216B844
	bl ovl08_216FFF0
_0216B844:
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _0216B864 // =ovl08_216B78C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216B860: .word 0x0217E8D4
_0216B864: .word ovl08_216B78C
	arm_func_end ovl08_216B824

	arm_func_start ovl08_216B868
ovl08_216B868: // 0x0216B868
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl ovl08_215A398
	cmp r0, #0
	beq _0216B88C
	cmp r0, #1
	beq _0216B8D4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0216B88C:
	bl ovl08_215E5E8
	cmp r0, #0
	beq _0216B8A4
	cmp r0, #1
	beq _0216B8C0
	b _0216B97C
_0216B8A4:
	mov r0, #7
	bl ovl08_216F934
	ldr r0, _0216B98C // =0x0217E8D4
	mov r1, #2
	ldr r0, [r0]
	strb r1, [r0, #0x1d]
	b _0216B97C
_0216B8C0:
	bl ovl08_215A308
	ldr r0, _0216B990 // =ovl08_215F3E4
	bl DWCi_ChangeScene
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0216B8D4:
	ldr r0, _0216B98C // =0x0217E8D4
	mov r2, #1
	ldr r1, [r0]
	ldr r0, _0216B994 // =0x0217E8D0
	strb r2, [r1, #0x1d]
	ldrb r0, [r0]
	cmp r0, #4
	blo _0216B964
	sub r4, r0, #4
	mov r0, r4
	bl ovl08_216F3F4
	cmp r0, #0xff
	bne _0216B920
	mov r0, #9
	bl ovl08_216F934
	mvn r0, #0
	bl ovl08_215A364
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0216B920:
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_215E600
	add r2, r4, #1
	str r2, [sp]
	ldr r1, _0216B998 // =0x0217ACD0
	mov r2, #1
	ldrsb r3, [r1, r0]
	mov r0, #0x46
	mov r1, #0
	bl ovl08_21715E4
	bl ovl08_216B28C
	bl ovl08_215A308
	ldr r0, _0216B99C // =ovl08_216B114
	bl DWCi_ChangeScene
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0216B964:
	cmp r0, #2
	bhi _0216B970
	bl ovl08_216F30C
_0216B970:
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_216B000
_0216B97C:
	ldr r0, _0216B9A0 // =ovl08_216B824
	bl DWCi_ChangeScene
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B98C: .word 0x0217E8D4
_0216B990: .word ovl08_215F3E4
_0216B994: .word 0x0217E8D0
_0216B998: .word 0x0217ACD0
_0216B99C: .word ovl08_216B114
_0216B9A0: .word ovl08_216B824
	arm_func_end ovl08_216B868

	arm_func_start ovl08_216B9A4
ovl08_216B9A4: // 0x0216B9A4
	bx lr
	arm_func_end ovl08_216B9A4

	arm_func_start ovl08_216B9A8
ovl08_216B9A8: // 0x0216B9A8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r4, _0216BAB8 // =0x0217AD08
	mov r5, #0
_0216B9B8:
	mov r0, r4
	bl ovl08_2176A38
	cmp r0, #0
	beq _0216B9E4
	mov r0, #1
	bl ovl08_215A378
	ldr r0, _0216BABC // =0x0217E8D0
	strb r5, [r0]
	bl ovl08_216B544
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0216B9E4:
	add r5, r5, #1
	cmp r5, #7
	add r4, r4, #8
	blo _0216B9B8
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	beq _0216BA14
	mov r0, #1
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0216BA14:
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	beq _0216BA34
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0216BA34:
	mov r0, #0x40
	bl ovl08_2176B34
	cmp r0, #0
	beq _0216BA54
	mov r0, #1
	bl ovl08_216B324
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0216BA54:
	mov r0, #0x80
	bl ovl08_2176B34
	cmp r0, #0
	beq _0216BA74
	mov r0, #3
	bl ovl08_216B324
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0216BA74:
	mov r0, #0x20
	bl ovl08_2176B34
	cmp r0, #0
	beq _0216BA94
	mov r0, #0
	bl ovl08_216B324
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0216BA94:
	mov r0, #0x10
	bl ovl08_2176B34
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	mov r0, #2
	bl ovl08_216B324
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216BAB8: .word 0x0217AD08
_0216BABC: .word 0x0217E8D0
	arm_func_end ovl08_216B9A8

	arm_func_start ovl08_216BAC0
ovl08_216BAC0: // 0x0216BAC0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216B9A8
	bl ovl08_216B9A4
	bl ovl08_216B868
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216BAC0

	arm_func_start ovl08_216BADC
ovl08_216BADC: // 0x0216BADC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_216FEE8
	cmp r0, #1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _0216BB1C // =ovl08_216BAC0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216BB1C: .word ovl08_216BAC0
	arm_func_end ovl08_216BADC

	arm_func_start ovl08_216BB20
ovl08_216BB20: // 0x0216BB20
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_215A770
	ldr r0, _0216BB68 // =ovl08_216BADC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216BB68: .word ovl08_216BADC
	arm_func_end ovl08_216BB20

	arm_func_start ovl08_216BB6C
ovl08_216BB6C: // 0x0216BB6C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x14
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x14
	bl ovl08_2176678
	ldr r0, _0216BBC4 // =ovl08_216BB20
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216BBC4: .word ovl08_216BB20
	arm_func_end ovl08_216BB6C

	arm_func_start ovl08_216BBC8
ovl08_216BBC8: // 0x0216BBC8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r9, #0
	ldr r4, _0216BCD8 // =0x0217E8D4
	ldr r5, _0216BCDC // =0x0217ACF0
	str r9, [sp]
	str r9, [sp, #4]
	mov r11, #0x11
	mov r7, #1
	mvn r6, #0
	mov r8, #3
_0216BBF4:
	mov r0, r9
	bl ovl08_216F3F4
	mov r10, r0
	cmp r10, #0xff
	moveq r10, r8
	beq _0216BC68
	ldr r0, [sp]
	mov r1, r11
	mov r2, r7
	bl ovl08_2175528
	ldr r1, [r4]
	add r3, r9, #3
	add r1, r1, r9, lsl #2
	str r0, [r1, #0x10]
	mov r2, r3, lsl #2
	ldr r0, [r4]
	add r3, r5, r3, lsl #2
	add r0, r0, r9, lsl #2
	ldrh r2, [r5, r2]
	ldrh r3, [r3, #2]
	ldr r0, [r0, #0x10]
	mov r1, r6
	bl ovl08_2174FA4
	ldr r0, [r4]
	mov r1, r6
	add r0, r0, r9, lsl #2
	ldr r0, [r0, #0x10]
	mov r2, r8
	bl ovl08_2174F30
_0216BC68:
	ldr r0, _0216BCE0 // =0x0217ACC4
	mov r2, r7
	ldrb r1, [r0, r10]
	ldr r0, [sp, #4]
	bl ovl08_2175528
	ldr r1, [r4]
	mov r2, r9, lsl #2
	add r1, r1, r9, lsl #2
	str r0, [r1, #4]
	ldr r0, [r4]
	add r3, r5, r9, lsl #2
	add r0, r0, r9, lsl #2
	ldrh r2, [r5, r2]
	ldrh r3, [r3, #2]
	ldr r0, [r0, #4]
	mov r1, r6
	bl ovl08_2174FA4
	ldr r0, [r4]
	mov r1, r6
	add r0, r0, r9, lsl #2
	ldr r0, [r0, #4]
	mov r2, r8
	bl ovl08_2174F30
	add r9, r9, #1
	cmp r9, #3
	blt _0216BBF4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216BCD8: .word 0x0217E8D4
_0216BCDC: .word 0x0217ACF0
_0216BCE0: .word 0x0217ACC4
	arm_func_end ovl08_216BBC8

	arm_func_start ovl08_216BCE4
ovl08_216BCE4: // 0x0216BCE4
	stmdb sp!, {lr}
	sub sp, sp, #0x1c
	ldr ip, _0216BDC4 // =aCharYbbgstep11_0
	add r3, sp, #0
	mov r2, #0xb
_0216BCF8:
	ldrb r1, [ip], #1
	ldrb r0, [ip], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _0216BCF8
	ldr r0, _0216BDC8 // =aCharYbobjwayNc
	ldr r1, _0216BDCC // =GX_LoadOBJPltt
	bl ovl08_215A7F8
	ldr r0, _0216BDD0 // =aCharJbbgstep1N_3
	ldr r1, _0216BDD4 // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r0, _0216BDD8 // =aCharJbbgstep1N_4
	ldr r1, _0216BDDC // =GX_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _0216BDE0 // =aCharJb2apNscL
	ldr r1, _0216BDE4 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	add r0, sp, #0
	bl ovl08_215A840
	mov r1, #0
	mov r2, #4
	bl ovl08_2174AF4
	ldr r2, _0216BDE8 // =0x0217E8D4
	mov r1, #0x10
	ldr r2, [r2]
	str r0, [r2]
	mov r0, #1
	bl ovl08_2176678
	ldr ip, _0216BDEC // =0x04001008
	ldr r3, _0216BDF0 // =0x0400100A
	ldrh r0, [ip]
	ldr r2, _0216BDF4 // =0x0400000A
	ldr r1, _0216BDF8 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #0x1c
	ldmia sp!, {pc}
	.align 2, 0
_0216BDC4: .word aCharYbbgstep11_0
_0216BDC8: .word aCharYbobjwayNc
_0216BDCC: .word GX_LoadOBJPltt
_0216BDD0: .word aCharJbbgstep1N_3
_0216BDD4: .word GX_LoadBG2Char
_0216BDD8: .word aCharJbbgstep1N_4
_0216BDDC: .word GX_LoadBGPltt
_0216BDE0: .word aCharJb2apNscL
_0216BDE4: .word GX_LoadBG2Scr
_0216BDE8: .word 0x0217E8D4
_0216BDEC: .word 0x04001008
_0216BDF0: .word 0x0400100A
_0216BDF4: .word 0x0400000A
_0216BDF8: .word 0x0400000C
	arm_func_end ovl08_216BCE4

	arm_func_start ovl08_216BDFC
ovl08_216BDFC: // 0x0216BDFC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0x20
	mov r1, #4
	bl ovl08_2176764
	ldr r1, _0216BE5C // =0x0217E8D4
	mov r2, #0
	str r0, [r1]
	strb r2, [r0, #0x1d]
	bl ovl08_216BCE4
	mov r0, #1
	bl ovl08_215AB50
	mov r0, #0x2f
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	mov r0, #0
	bl ovl08_215A7A8
	bl ovl08_216BBC8
	bl ovl08_216B544
	ldr r0, _0216BE60 // =ovl08_216BB6C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216BE5C: .word 0x0217E8D4
_0216BE60: .word ovl08_216BB6C
	arm_func_end ovl08_216BDFC

	arm_func_start ovl08_216BE64
ovl08_216BE64: // 0x0216BE64
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r0, _0216BEB8 // =0x0217AD78
	ldr r1, _0216BEBC // =0x0217E8DC
	ldrb lr, [r0]
	ldrb ip, [r0, #1]
	ldrb r3, [r0, #2]
	ldrb r2, [r0, #3]
	ldr r0, _0216BEC0 // =0x0217E8E4
	ldrsb r1, [r1]
	add r4, sp, #0
	strb lr, [sp]
	strb ip, [sp, #1]
	strb r3, [sp, #2]
	strb r2, [sp, #3]
	ldrb r1, [r4, r1]
	ldr r0, [r0]
	mov r2, r1
	bl ovl08_216DEC4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216BEB8: .word 0x0217AD78
_0216BEBC: .word 0x0217E8DC
_0216BEC0: .word 0x0217E8E4
	arm_func_end ovl08_216BE64

	arm_func_start ovl08_216BEC4
ovl08_216BEC4: // 0x0216BEC4
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _0216BFA0 // =0x0217E8DC
	mov r5, r0
	mov r0, #1
	ldrsb r4, [r1]
	bl ovl08_215E5C8
	ldr r2, _0216BFA4 // =0x0217AD9C
	mvn r1, #0
	add r0, r2, r0, lsl #4
	add r0, r0, r4, lsl #2
	ldrsb r2, [r5, r0]
	cmp r2, r1
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r2, #0
	ldreq r0, _0216BFA8 // =0x0217E8D8
	streqb r4, [r0]
	mvn r0, #1
	cmp r2, r0
	ldreq r1, _0216BFA8 // =0x0217E8D8
	ldreq r0, _0216BFA0 // =0x0217E8DC
	ldreqsb r1, [r1]
	streqb r1, [r0]
	ldrne r0, _0216BFA0 // =0x0217E8DC
	strneb r2, [r0]
	mov r0, #8
	bl ovl08_216F934
	mov r0, #1
	bl ovl08_215E5C8
	mov r6, r0
	mov r0, #1
	bl ovl08_215E5C8
	mov r5, r0
	mov r0, #1
	bl ovl08_215E5C8
	mov r4, r0
	mov r0, #1
	bl ovl08_215E5C8
	mov r3, r0
	ldr r0, _0216BFA0 // =0x0217E8DC
	ldr r1, _0216BFAC // =0x0217ADFC
	ldrsb lr, [r0]
	ldr r0, _0216BFB0 // =0x0217ADFE
	add ip, r1, r6, lsl #5
	ldr r1, _0216BFB4 // =0x0217AE00
	add r2, r0, r4, lsl #5
	ldr r4, _0216BFB8 // =0x0217AE02
	add r1, r1, r5, lsl #5
	mov r5, lr, lsl #3
	add r3, r4, r3, lsl #5
	ldrh r0, [r5, ip]
	ldrh r1, [r5, r1]
	ldrh r2, [r5, r2]
	ldrh r3, [r5, r3]
	bl ovl08_215A8E0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216BFA0: .word 0x0217E8DC
_0216BFA4: .word 0x0217AD9C
_0216BFA8: .word 0x0217E8D8
_0216BFAC: .word 0x0217ADFC
_0216BFB0: .word 0x0217ADFE
_0216BFB4: .word 0x0217AE00
_0216BFB8: .word 0x0217AE02
	arm_func_end ovl08_216BEC4

	arm_func_start ovl08_216BFBC
ovl08_216BFBC: // 0x0216BFBC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A8A0
	bl ovl08_215A4D8
	ldr r0, _0216C0FC // =0x0217E8E4
	ldr r0, [r0]
	bl ovl08_2174AB8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x14
	bl ovl08_217661C
	ldr r0, _0216C100 // =0x0217E8E0
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216C054
	mov r0, #2
	mov r1, #0
	bl ovl08_215E674
	ldr r0, _0216C104 // =ovl08_216BDFC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216C054:
	ldr r0, _0216C108 // =0x0217E8DC
	ldrsb r0, [r0]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0216C0F4
_0216C068: // jump table
	b _0216C078 // case 0
	b _0216C094 // case 1
	b _0216C0B0 // case 2
	b _0216C0CC // case 3
_0216C078:
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216C10C // =ovl08_216AF88
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216C094:
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216C110 // =ovl08_2163320
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216C0B0:
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216C114 // =ovl08_216A9E0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216C0CC:
	mov r0, #2
	mov r1, #0
	bl ovl08_215E674
	mov r0, #0
	mov r1, r0
	bl ovl08_215E638
	mov r0, #1
	bl ovl08_2166EDC
	ldr r0, _0216C118 // =ovl08_2169434
	bl DWCi_ChangeScene
_0216C0F4:
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216C0FC: .word 0x0217E8E4
_0216C100: .word 0x0217E8E0
_0216C104: .word ovl08_216BDFC
_0216C108: .word 0x0217E8DC
_0216C10C: .word ovl08_216AF88
_0216C110: .word ovl08_2163320
_0216C114: .word ovl08_216A9E0
_0216C118: .word ovl08_2169434
	arm_func_end ovl08_216BFBC

	arm_func_start ovl08_216C11C
ovl08_216C11C: // 0x0216C11C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216C184 // =0x0217E8E0
	ldrb r0, [r0]
	cmp r0, #0
	beq _0216C14C
	bl ovl08_215A3AC
_0216C14C:
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x14
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216C188 // =ovl08_216BFBC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216C184: .word 0x0217E8E0
_0216C188: .word ovl08_216BFBC
	arm_func_end ovl08_216C11C

	arm_func_start ovl08_216C18C
ovl08_216C18C: // 0x0216C18C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _0216C1B0 // =ovl08_216C11C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216C1B0: .word ovl08_216C11C
	arm_func_end ovl08_216C18C

	arm_func_start ovl08_216C1B4
ovl08_216C1B4: // 0x0216C1B4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	beq _0216C1D8
	cmp r0, #1
	beq _0216C1E4
	add sp, sp, #4
	ldmia sp!, {pc}
_0216C1D8:
	mov r0, #7
	bl ovl08_216F934
	b _0216C1FC
_0216C1E4:
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_216BE64
	ldr r0, _0216C20C // =0x0217E8E0
	mov r1, #1
	strb r1, [r0]
_0216C1FC:
	ldr r0, _0216C210 // =ovl08_216C18C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216C20C: .word 0x0217E8E0
_0216C210: .word ovl08_216C18C
	arm_func_end ovl08_216C1B4

	arm_func_start ovl08_216C214
ovl08_216C214: // 0x0216C214
	bx lr
	arm_func_end ovl08_216C214

	arm_func_start ovl08_216C218
ovl08_216C218: // 0x0216C218
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, #0
	mov r6, r7
	ldr r4, _0216C3A8 // =0x0217ADBC
	mov r5, #1
_0216C230:
	mov r0, r5
	bl ovl08_215E5C8
	add r0, r4, r0, lsl #5
	add r0, r0, r6
	bl ovl08_2176A38
	cmp r0, #0
	beq _0216C2D4
	mov r0, #1
	bl ovl08_215A378
	ldr r1, _0216C3AC // =0x0217E8DC
	mov r0, #1
	strb r7, [r1]
	bl ovl08_215E5C8
	mov r6, r0
	mov r0, #1
	bl ovl08_215E5C8
	mov r5, r0
	mov r0, #1
	bl ovl08_215E5C8
	mov r4, r0
	mov r0, #1
	bl ovl08_215E5C8
	mov r3, r0
	ldr r0, _0216C3AC // =0x0217E8DC
	ldr r1, _0216C3B0 // =0x0217ADFC
	ldrsb lr, [r0]
	ldr r0, _0216C3B4 // =0x0217ADFE
	add ip, r1, r6, lsl #5
	ldr r1, _0216C3B8 // =0x0217AE00
	add r2, r0, r4, lsl #5
	ldr r4, _0216C3BC // =0x0217AE02
	add r1, r1, r5, lsl #5
	mov r5, lr, lsl #3
	add r3, r4, r3, lsl #5
	ldrh r0, [r5, ip]
	ldrh r1, [r5, r1]
	ldrh r2, [r5, r2]
	ldrh r3, [r5, r3]
	bl ovl08_215A8E0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216C2D4:
	add r7, r7, #1
	cmp r7, #4
	add r6, r6, #8
	blo _0216C230
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	beq _0216C304
	mov r0, #1
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216C304:
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	beq _0216C324
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216C324:
	mov r0, #0x40
	bl ovl08_2176B34
	cmp r0, #0
	beq _0216C344
	mov r0, #1
	bl ovl08_216BEC4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216C344:
	mov r0, #0x80
	bl ovl08_2176B34
	cmp r0, #0
	beq _0216C364
	mov r0, #3
	bl ovl08_216BEC4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216C364:
	mov r0, #0x20
	bl ovl08_2176B34
	cmp r0, #0
	beq _0216C384
	mov r0, #0
	bl ovl08_216BEC4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216C384:
	mov r0, #0x10
	bl ovl08_2176B34
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, #2
	bl ovl08_216BEC4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216C3A8: .word 0x0217ADBC
_0216C3AC: .word 0x0217E8DC
_0216C3B0: .word 0x0217ADFC
_0216C3B4: .word 0x0217ADFE
_0216C3B8: .word 0x0217AE00
_0216C3BC: .word 0x0217AE02
	arm_func_end ovl08_216C218

	arm_func_start ovl08_216C3C0
ovl08_216C3C0: // 0x0216C3C0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216C218
	bl ovl08_216C214
	bl ovl08_216C1B4
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216C3C0

	arm_func_start ovl08_216C3DC
ovl08_216C3DC: // 0x0216C3DC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _0216C40C // =ovl08_216C3C0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216C40C: .word ovl08_216C3C0
	arm_func_end ovl08_216C3DC

	arm_func_start ovl08_216C410
ovl08_216C410: // 0x0216C410
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_215A770
	ldr r0, _0216C458 // =ovl08_216C3DC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216C458: .word ovl08_216C3DC
	arm_func_end ovl08_216C410

	arm_func_start ovl08_216C45C
ovl08_216C45C: // 0x0216C45C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x14
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x14
	bl ovl08_2176678
	ldr r0, _0216C4B4 // =ovl08_216C410
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216C4B4: .word ovl08_216C410
	arm_func_end ovl08_216C45C

	arm_func_start ovl08_216C4B8
ovl08_216C4B8: // 0x0216C4B8
	stmdb sp!, {lr}
	sub sp, sp, #0x1c
	ldr ip, _0216C57C // =aCharYbbgstep21_0
	add r3, sp, #0
	mov r2, #0xb
_0216C4CC:
	ldrb r1, [ip], #1
	ldrb r0, [ip], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _0216C4CC
	ldr r0, _0216C580 // =aCharJbbgstep2N_0
	ldr r1, _0216C584 // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r0, _0216C588 // =aCharYbbgstep2N_0
	ldr r1, _0216C58C // =GX_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _0216C590 // =aCharJb3wayNscL
	ldr r1, _0216C594 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	add r0, sp, #0
	bl ovl08_215A840
	mov r1, #0
	mov r2, #4
	bl ovl08_2174AF4
	ldr r1, _0216C598 // =0x0217E8E4
	ldr ip, _0216C59C // =0x04001008
	str r0, [r1]
	ldrh r0, [ip]
	ldr r3, _0216C5A0 // =0x0400100A
	ldr r2, _0216C5A4 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	ldr r1, _0216C5A8 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #0x1c
	ldmia sp!, {pc}
	.align 2, 0
_0216C57C: .word aCharYbbgstep21_0
_0216C580: .word aCharJbbgstep2N_0
_0216C584: .word GX_LoadBG2Char
_0216C588: .word aCharYbbgstep2N_0
_0216C58C: .word GX_LoadBGPltt
_0216C590: .word aCharJb3wayNscL
_0216C594: .word GX_LoadBG2Scr
_0216C598: .word 0x0217E8E4
_0216C59C: .word 0x04001008
_0216C5A0: .word 0x0400100A
_0216C5A4: .word 0x0400000A
_0216C5A8: .word 0x0400000C
	arm_func_end ovl08_216C4B8

	arm_func_start ovl08_216C5AC
ovl08_216C5AC: // 0x0216C5AC
	stmdb sp!, {r4, r5, r6, lr}
	bl ovl08_216F84C
	ldr r1, _0216C6B8 // =0x0217E8D8
	ldr r2, _0216C6BC // =0x0217E8E0
	ldrsb r3, [r1]
	mov r5, #0
	mov r4, r0
	cmp r3, #0
	moveq r0, #1
	strb r5, [r2]
	streqb r0, [r1]
	bl ovl08_215E600
	cmp r0, #0
	beq _0216C60C
	ldr r0, _0216C6C0 // =0x0217E8DC
	ldrsb r1, [r0]
	cmp r1, #2
	moveq r1, #0
	streqb r1, [r0]
	ldr r0, _0216C6B8 // =0x0217E8D8
	ldrsb r1, [r0]
	cmp r1, #2
	moveq r1, #1
	streqb r1, [r0]
_0216C60C:
	bl ovl08_216C4B8
	bl ovl08_215AB30
	bl ovl08_215E600
	mov r5, r0
	ldrb r1, [r4, #0xf4]
	mov r0, #0x32
	ldr r3, _0216C6C4 // =0x0217AD7C
	add r2, r1, #1
	ldrsb r1, [r3, r5]
	bl ovl08_215A51C
	mov r0, #1
	bl ovl08_215A7A8
	mov r0, #1
	bl ovl08_215E5C8
	mov r6, r0
	mov r0, #1
	bl ovl08_215E5C8
	mov r5, r0
	mov r0, #1
	bl ovl08_215E5C8
	mov r4, r0
	mov r0, #1
	bl ovl08_215E5C8
	mov r3, r0
	ldr r1, _0216C6C8 // =0x0217ADFC
	ldr r0, _0216C6C0 // =0x0217E8DC
	add ip, r1, r6, lsl #5
	ldrsb lr, [r0]
	ldr r1, _0216C6CC // =0x0217AE00
	ldr r0, _0216C6D0 // =0x0217ADFE
	add r1, r1, r5, lsl #5
	add r2, r0, r4, lsl #5
	mov r5, lr, lsl #3
	ldrh r0, [r5, ip]
	ldrh r1, [r5, r1]
	ldrh r2, [r5, r2]
	ldr r4, _0216C6D4 // =0x0217AE02
	add r3, r4, r3, lsl #5
	ldrh r3, [r5, r3]
	bl ovl08_215A8E0
	ldr r0, _0216C6D8 // =ovl08_216C45C
	bl DWCi_ChangeScene
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216C6B8: .word 0x0217E8D8
_0216C6BC: .word 0x0217E8E0
_0216C6C0: .word 0x0217E8DC
_0216C6C4: .word 0x0217AD7C
_0216C6C8: .word 0x0217ADFC
_0216C6CC: .word 0x0217AE00
_0216C6D0: .word 0x0217ADFE
_0216C6D4: .word 0x0217AE02
_0216C6D8: .word ovl08_216C45C
	arm_func_end ovl08_216C5AC

	arm_func_start ovl08_216C6DC
ovl08_216C6DC: // 0x0216C6DC
	ldr ip, _0216C6E8 // =ovl08_21766CC
	mov r0, r1
	bx ip
	.align 2, 0
_0216C6E8: .word ovl08_21766CC
	arm_func_end ovl08_216C6DC

	arm_func_start ovl08_216C6EC
ovl08_216C6EC: // 0x0216C6EC
	ldr ip, _0216C6FC // =ovl08_2176788
	mov r0, r1
	mov r1, #0x20
	bx ip
	.align 2, 0
_0216C6FC: .word ovl08_2176788
	arm_func_end ovl08_216C6EC

	arm_func_start ovl08_216C700
ovl08_216C700: // 0x0216C700
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl sub_2086670
	movs r4, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	bl ovl08_215AD18
	bl ovl08_216F8D0
	cmp r4, #0
	ble _0216C744
	ldr r1, _0216C770 // =0x0217E8E8
	mov r2, #1
	mov r0, #0x11
	strb r2, [r1]
	bl ovl08_216F934
	b _0216C754
_0216C744:
	bl sub_20865D8
	bl ovl08_21667A4
	mov r0, #0x12
	bl ovl08_216F934
_0216C754:
	ldr r0, _0216C774 // =ovl08_216C844
	bl DWCi_ChangeScene
	mov r1, r5
	mov r0, #0
	bl ovl08_2177870
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216C770: .word 0x0217E8E8
_0216C774: .word ovl08_216C844
	arm_func_end ovl08_216C700

	arm_func_start ovl08_216C778
ovl08_216C778: // 0x0216C778
	stmdb sp!, {r4, lr}
	bl ovl08_216EFE4
	mov r4, r0
	bl sub_2086544
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl sub_208D4AC
	add r1, r4, #0xf0
	mov r2, #0xe
	bl MI_CpuCopy8
	bl sub_208D4AC
	add r1, r4, #0x1f0
	mov r2, #0xe
	bl MI_CpuCopy8
	bl ovl08_2159CD8
	mov r0, #0
	bl ovl08_2175D6C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	ldr r0, _0216C808 // =0x0217E8E8
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216C7F0
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216C80C // =ovl08_2166EB8
	bl DWCi_ChangeScene
	ldmia sp!, {r4, pc}
_0216C7F0:
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216C810 // =ovl08_216CDEC
	bl DWCi_ChangeScene
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216C808: .word 0x0217E8E8
_0216C80C: .word ovl08_2166EB8
_0216C810: .word ovl08_216CDEC
	arm_func_end ovl08_216C778

	arm_func_start ovl08_216C814
ovl08_216C814: // 0x0216C814
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216C840 // =ovl08_216C778
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216C840: .word ovl08_216C778
	arm_func_end ovl08_216C814

	arm_func_start ovl08_216C844
ovl08_216C844: // 0x0216C844
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216C870 // =ovl08_216C814
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216C870: .word ovl08_216C814
	arm_func_end ovl08_216C844

	arm_func_start sub_216C874
sub_216C874: // 0x0216C874
	bx lr
	arm_func_end sub_216C874

	arm_func_start ovl08_216C878
ovl08_216C878: // 0x0216C878
	bx lr
	arm_func_end ovl08_216C878

	arm_func_start ovl08_216C87C
ovl08_216C87C: // 0x0216C87C
	bx lr
	arm_func_end ovl08_216C87C

	arm_func_start ovl08_216C880
ovl08_216C880: // 0x0216C880
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216C87C
	bl ovl08_216C878
	bl sub_216C874
	arm_func_end ovl08_216C880

	arm_func_start ovl08_216C894
ovl08_216C894: // 0x0216C894
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216C894

	arm_func_start ovl08_216C89C
ovl08_216C89C: // 0x0216C89C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216C8DC // =ovl08_216C880
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216C8DC: .word ovl08_216C880
	arm_func_end ovl08_216C89C

	arm_func_start ovl08_216C8E0
ovl08_216C8E0: // 0x0216C8E0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	add r1, sp, #0
	mov r0, #0
	bl ovl08_215E610
	ldr r0, [sp]
	cmp r0, #0
	bne _0216C940
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
_0216C940:
	ldr r0, _0216C950 // =ovl08_216C89C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216C950: .word ovl08_216C89C
	arm_func_end ovl08_216C8E0

	arm_func_start ovl08_216C954
ovl08_216C954: // 0x0216C954
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	bl ovl08_216F84C
	mov r4, r0
	ldr r0, _0216C9E4 // =0x0217AE3C
	add r1, sp, #4
	mov r2, #0xc
	bl MIi_CpuCopy32
	add r1, sp, #0
	mov r0, #0
	bl ovl08_215E610
	ldr r0, [sp]
	cmp r0, #2
	moveq r0, #4
	streqb r0, [sp, #0xe]
	ldrneb r0, [r4, #0xf4]
	addne r0, r0, #1
	strneb r0, [sp, #0xe]
	add r0, sp, #4
	bl sub_2086750
	cmp r0, #0
	bne _0216C9B0
	bl OS_Terminate
_0216C9B0:
	ldr r0, [sp]
	cmp r0, #0
	bne _0216C9C8
	ldrb r0, [r4, #0xf4]
	mov r1, r4
	bl sub_2086510
_0216C9C8:
	mov r0, #0
	ldr r1, _0216C9E8 // =ovl08_216C700
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216C9E4: .word 0x0217AE3C
_0216C9E8: .word ovl08_216C700
	arm_func_end ovl08_216C954

	arm_func_start ovl08_216C9EC
ovl08_216C9EC: // 0x0216C9EC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216CA84 // =aCharJbbgstep3N_5
	ldr r1, _0216CA88 // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r0, _0216CA8C // =aCharYbbgstep3N_5
	ldr r1, _0216CA90 // =GX_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _0216CA94 // =aCharXb4multiNs_5
	ldr r1, _0216CA98 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _0216CA9C // =0x04001008
	ldr ip, _0216CAA0 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _0216CAA4 // =0x04000008
	ldr r2, _0216CAA8 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _0216CAAC // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216CA84: .word aCharJbbgstep3N_5
_0216CA88: .word GX_LoadBG2Char
_0216CA8C: .word aCharYbbgstep3N_5
_0216CA90: .word GX_LoadBGPltt
_0216CA94: .word aCharXb4multiNs_5
_0216CA98: .word GX_LoadBG2Scr
_0216CA9C: .word 0x04001008
_0216CAA0: .word 0x0400100A
_0216CAA4: .word 0x04000008
_0216CAA8: .word 0x0400000A
_0216CAAC: .word 0x0400000C
	arm_func_end ovl08_216C9EC

	arm_func_start ovl08_216CAB0
ovl08_216CAB0: // 0x0216CAB0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216CB3C // =0x0217E8E8
	mov r1, #0
	strb r1, [r0]
	bl ovl08_216C9EC
	add r1, sp, #0
	mov r0, #0
	bl ovl08_215E610
	ldr r0, [sp]
	cmp r0, #0
	bne _0216CAF0
	mov r0, #0x31
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
_0216CAF0:
	mov r0, #2
	bl ovl08_215A7A8
	ldr r0, [sp]
	cmp r0, #0
	bne _0216CB08
	bl ovl08_215AB30
_0216CB08:
	mov r0, #0x2c
	bl ovl08_215A6F4
	mov r0, #0
	bl ovl08_2159D18
	bl ovl08_216C954
	mov r0, #0
	bl ovl08_215AD64
	mov r0, #0xc
	bl ovl08_216F934
	ldr r0, _0216CB40 // =ovl08_216C8E0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216CB3C: .word 0x0217E8E8
_0216CB40: .word ovl08_216C8E0
	arm_func_end ovl08_216CAB0

	arm_func_start ovl08_216CB44
ovl08_216CB44: // 0x0216CB44
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216CBB8 // =0x0217E8EC
	ldrb r1, [r0]
	add r1, r1, #1
	strb r1, [r0]
	ldrb r0, [r0]
	cmp r0, #0xb4
	addlo sp, sp, #4
	ldmloia sp!, {pc}
	add r1, sp, #0
	mov r0, #0
	bl ovl08_215E610
	bl ovl08_215E5E8
	cmp r0, #0
	beq _0216CBA8
	cmp r0, #1
	bne _0216CBA8
	ldr r0, [sp]
	cmp r0, #0
	beq _0216CBA8
	ldr r0, _0216CBBC // =ovl08_215F3E4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216CBA8:
	ldr r0, _0216CBC0 // =ovl08_216CC80
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216CBB8: .word 0x0217E8EC
_0216CBBC: .word ovl08_215F3E4
_0216CBC0: .word ovl08_216CC80
	arm_func_end ovl08_216CB44

	arm_func_start ovl08_216CBC4
ovl08_216CBC4: // 0x0216CBC4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_216FABC
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_2175D6C
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	add r1, sp, #0
	mov r0, #0
	bl ovl08_215E610
	ldr r0, [sp]
	cmp r0, #0
	bne _0216CC68
	mov r0, #0
	mov r1, r0
	bl ovl08_215E638
	ldr r0, _0216CC78 // =ovl08_2169434
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216CC68:
	ldr r0, _0216CC7C // =ovl08_215FC9C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216CC78: .word ovl08_2169434
_0216CC7C: .word ovl08_215FC9C
	arm_func_end ovl08_216CBC4

	arm_func_start ovl08_216CC80
ovl08_216CC80: // 0x0216CC80
	stmdb sp!, {lr}
	sub sp, sp, #4
	add r1, sp, #0
	mov r0, #0
	bl ovl08_215E610
	ldr r0, [sp]
	cmp r0, #0
	beq _0216CCA4
	bl ovl08_216FFF0
_0216CCA4:
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216CCDC // =ovl08_216CBC4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216CCDC: .word ovl08_216CBC4
	arm_func_end ovl08_216CC80

	arm_func_start ovl08_216CCE0
ovl08_216CCE0: // 0x0216CCE0
	bx lr
	arm_func_end ovl08_216CCE0

	arm_func_start ovl08_216CCE4
ovl08_216CCE4: // 0x0216CCE4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216CB44
	bl ovl08_216CCE0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216CCE4

	arm_func_start ovl08_216CCFC
ovl08_216CCFC: // 0x0216CCFC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216CD28 // =ovl08_216CCE4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216CD28: .word ovl08_216CCE4
	arm_func_end ovl08_216CCFC

	arm_func_start ovl08_216CD2C
ovl08_216CD2C: // 0x0216CD2C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _0216CD64 // =ovl08_216CCFC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216CD64: .word ovl08_216CCFC
	arm_func_end ovl08_216CD2C

	arm_func_start ovl08_216CD68
ovl08_216CD68: // 0x0216CD68
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216CDD4 // =aCharXb4multiNs_6
	ldr r1, _0216CDD8 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr ip, _0216CDDC // =0x04001008
	ldr r3, _0216CDE0 // =0x0400100A
	ldrh r0, [ip]
	ldr r2, _0216CDE4 // =0x0400000A
	ldr r1, _0216CDE8 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216CDD4: .word aCharXb4multiNs_6
_0216CDD8: .word GX_LoadBG2Scr
_0216CDDC: .word 0x04001008
_0216CDE0: .word 0x0400100A
_0216CDE4: .word 0x0400000A
_0216CDE8: .word 0x0400000C
	arm_func_end ovl08_216CD68

	arm_func_start ovl08_216CDEC
ovl08_216CDEC: // 0x0216CDEC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216CE1C // =0x0217E8EC
	mov r1, #0
	strb r1, [r0]
	bl ovl08_216CD68
	mov r0, #0x2d
	bl ovl08_215A6F4
	ldr r0, _0216CE20 // =ovl08_216CD2C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216CE1C: .word 0x0217E8EC
_0216CE20: .word ovl08_216CD2C
	arm_func_end ovl08_216CDEC

	arm_func_start ovl08_216CE24
ovl08_216CE24: // 0x0216CE24
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	mov r1, #0x14
	bl ovl08_217661C
	mov r0, #0
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216CE68 // =ovl08_216CAB0
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216CE68: .word ovl08_216CAB0
	arm_func_end ovl08_216CE24

	arm_func_start ovl08_216CE6C
ovl08_216CE6C: // 0x0216CE6C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #3
	mov r1, #0
	mov r2, #0x14
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216CEA8 // =ovl08_216CE24
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216CEA8: .word ovl08_216CE24
	arm_func_end ovl08_216CE6C

	arm_func_start ovl08_216CEAC
ovl08_216CEAC: // 0x0216CEAC
	bx lr
	arm_func_end ovl08_216CEAC

	arm_func_start ovl08_216CEB0
ovl08_216CEB0: // 0x0216CEB0
	bx lr
	arm_func_end ovl08_216CEB0

	arm_func_start ovl08_216CEB4
ovl08_216CEB4: // 0x0216CEB4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216CEB0
	bl ovl08_216CEAC
	bl ovl08_2171584
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_2171598
	mov r0, #6
	bl ovl08_216F934
	ldr r0, _0216CEF8 // =ovl08_216CE6C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216CEF8: .word ovl08_216CE6C
	arm_func_end ovl08_216CEB4

	arm_func_start ovl08_216CEFC
ovl08_216CEFC: // 0x0216CEFC
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	ldr r0, _0216CF7C // =0x0217AE48
	add r3, sp, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {pc}
	add r1, sp, #4
	mov r0, #0
	bl ovl08_215E610
	mov r0, #0
	str r0, [sp]
	mov r1, #1
	ldr r3, [sp, #4]
	add r0, sp, #8
	ldr r0, [r0, r3, lsl #2]
	mov r2, r1
	mvn r3, #0
	bl ovl08_21715E4
	ldr r0, _0216CF80 // =ovl08_216CEB4
	bl DWCi_ChangeScene
	add sp, sp, #0x14
	ldmia sp!, {pc}
	.align 2, 0
_0216CF7C: .word 0x0217AE48
_0216CF80: .word ovl08_216CEB4
	arm_func_end ovl08_216CEFC

	arm_func_start ovl08_216CF84
ovl08_216CF84: // 0x0216CF84
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x14
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x14
	bl ovl08_2176678
	ldr r0, _0216CFDC // =ovl08_216CEFC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216CFDC: .word ovl08_216CEFC
	arm_func_end ovl08_216CF84

	arm_func_start ovl08_216CFE0
ovl08_216CFE0: // 0x0216CFE0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216D04C // =aCharXb4noneNsc_0
	ldr r1, _0216D050 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr ip, _0216D054 // =0x04001008
	ldr r3, _0216D058 // =0x0400100A
	ldrh r0, [ip]
	ldr r2, _0216D05C // =0x0400000A
	ldr r1, _0216D060 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D04C: .word aCharXb4noneNsc_0
_0216D050: .word GX_LoadBG2Scr
_0216D054: .word 0x04001008
_0216D058: .word 0x0400100A
_0216D05C: .word 0x0400000A
_0216D060: .word 0x0400000C
	arm_func_end ovl08_216CFE0

	arm_func_start ovl08_216D064
ovl08_216D064: // 0x0216D064
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216EC58
	add r1, sp, #0
	mov r0, #0
	bl ovl08_215E610
	bl ovl08_216CFE0
	mov r0, #0x31
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	ldr r0, [sp]
	cmp r0, #2
	beq _0216D0A0
	bl ovl08_215AB30
_0216D0A0:
	ldr r0, [sp]
	cmp r0, #1
	bne _0216D0B0
	bl ovl08_216F224
_0216D0B0:
	ldr r0, _0216D0C0 // =ovl08_216CF84
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D0C0: .word ovl08_216CF84
	arm_func_end ovl08_216D064

	arm_func_start ovl08_216D0C4
ovl08_216D0C4: // 0x0216D0C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216D0FC // =0x0217E8F0
	ldrb r1, [r0]
	add r1, r1, #1
	strb r1, [r0]
	ldrb r0, [r0]
	cmp r0, #0x78
	addlo sp, sp, #4
	ldmloia sp!, {pc}
	ldr r0, _0216D100 // =ovl08_216D184
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D0FC: .word 0x0217E8F0
_0216D100: .word ovl08_216D184
	arm_func_end ovl08_216D0C4

	arm_func_start ovl08_216D104
ovl08_216D104: // 0x0216D104
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175D6C
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	mov r0, #0
	mov r1, r0
	bl ovl08_215E674
	mov r0, #0
	mov r1, #2
	bl ovl08_215E638
	ldr r0, _0216D180 // =ovl08_216D064
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D180: .word ovl08_216D064
	arm_func_end ovl08_216D104

	arm_func_start ovl08_216D184
ovl08_216D184: // 0x0216D184
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216D1C4 // =ovl08_216D104
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D1C4: .word ovl08_216D104
	arm_func_end ovl08_216D184

	arm_func_start ovl08_216D1C8
ovl08_216D1C8: // 0x0216D1C8
	bx lr
	arm_func_end ovl08_216D1C8

	arm_func_start ovl08_216D1CC
ovl08_216D1CC: // 0x0216D1CC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216D0C4
	bl ovl08_216D1C8
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216D1CC

	arm_func_start ovl08_216D1E4
ovl08_216D1E4: // 0x0216D1E4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216D210 // =ovl08_216D1CC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D210: .word ovl08_216D1CC
	arm_func_end ovl08_216D1E4

	arm_func_start ovl08_216D214
ovl08_216D214: // 0x0216D214
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _0216D24C // =ovl08_216D1E4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D24C: .word ovl08_216D1E4
	arm_func_end ovl08_216D214

	arm_func_start ovl08_216D250
ovl08_216D250: // 0x0216D250
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216D2D0 // =aCharXb4multiNs_7
	ldr r1, _0216D2D4 // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _0216D2D8 // =0x04001008
	ldr ip, _0216D2DC // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _0216D2E0 // =0x04000008
	ldr r2, _0216D2E4 // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _0216D2E8 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D2D0: .word aCharXb4multiNs_7
_0216D2D4: .word GX_LoadBG2Scr
_0216D2D8: .word 0x04001008
_0216D2DC: .word 0x0400100A
_0216D2E0: .word 0x04000008
_0216D2E4: .word 0x0400000A
_0216D2E8: .word 0x0400000C
	arm_func_end ovl08_216D250

	arm_func_start ovl08_216D2EC
ovl08_216D2EC: // 0x0216D2EC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216D32C // =0x0217E8F0
	mov r1, #0
	strb r1, [r0]
	bl ovl08_216D250
	mov r0, #8
	bl ovl08_215AB50
	mov r0, #0x29
	bl ovl08_215A6F4
	mov r0, #0x10
	bl ovl08_216F934
	ldr r0, _0216D330 // =ovl08_216D214
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D32C: .word 0x0217E8F0
_0216D330: .word ovl08_216D214
	arm_func_end ovl08_216D2EC

	arm_func_start ovl08_216D334
ovl08_216D334: // 0x0216D334
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216D400 // =0x0217E8F4
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216D374
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
_0216D374:
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_2175D6C
	ldr r0, _0216D400 // =0x0217E8F4
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216D3AC
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
_0216D3AC:
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	ldr r0, _0216D400 // =0x0217E8F4
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216D3E4
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216D404 // =ovl08_216BDFC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216D3E4:
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216D408 // =ovl08_216DD84
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D400: .word 0x0217E8F4
_0216D404: .word ovl08_216BDFC
_0216D408: .word ovl08_216DD84
	arm_func_end ovl08_216D334

	arm_func_start ovl08_216D40C
ovl08_216D40C: // 0x0216D40C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A3AC
	ldr r0, _0216D474 // =0x0217E8F4
	ldrb r0, [r0]
	cmp r0, #0
	bne _0216D450
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
_0216D450:
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216D478 // =ovl08_216D334
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D474: .word 0x0217E8F4
_0216D478: .word ovl08_216D334
	arm_func_end ovl08_216D40C

	arm_func_start ovl08_216D47C
ovl08_216D47C: // 0x0216D47C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _0216D4A0 // =ovl08_216D40C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D4A0: .word ovl08_216D40C
	arm_func_end ovl08_216D47C

	arm_func_start ovl08_216D4A4
ovl08_216D4A4: // 0x0216D4A4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	cmp r0, #0
	beq _0216D4C8
	cmp r0, #1
	beq _0216D4D4
	add sp, sp, #4
	ldmia sp!, {pc}
_0216D4C8:
	mov r0, #7
	bl ovl08_216F934
	b _0216D4E8
_0216D4D4:
	mov r0, #6
	bl ovl08_216F934
	ldr r0, _0216D4F8 // =0x0217E8F4
	mov r1, #1
	strb r1, [r0]
_0216D4E8:
	ldr r0, _0216D4FC // =ovl08_216D47C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D4F8: .word 0x0217E8F4
_0216D4FC: .word ovl08_216D47C
	arm_func_end ovl08_216D4A4

	arm_func_start ovl08_216D500
ovl08_216D500: // 0x0216D500
	bx lr
	arm_func_end ovl08_216D500

	arm_func_start ovl08_216D504
ovl08_216D504: // 0x0216D504
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	beq _0216D524
	mov r0, #1
	bl ovl08_215A378
_0216D524:
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216D504

	arm_func_start ovl08_216D548
ovl08_216D548: // 0x0216D548
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216D504
	bl ovl08_216D500
	bl ovl08_216D4A4
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216D548

	arm_func_start ovl08_216D564
ovl08_216D564: // 0x0216D564
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _0216D594 // =ovl08_216D548
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D594: .word ovl08_216D548
	arm_func_end ovl08_216D564

	arm_func_start ovl08_216D598
ovl08_216D598: // 0x0216D598
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_215A770
	ldr r0, _0216D5E0 // =ovl08_216D564
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D5E0: .word ovl08_216D564
	arm_func_end ovl08_216D598

	arm_func_start ovl08_216D5E4
ovl08_216D5E4: // 0x0216D5E4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #1
	mov r2, r1
	mov r0, #2
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #1
	mov r1, r0
	bl ovl08_2176678
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _0216D63C // =ovl08_216D598
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D63C: .word ovl08_216D598
	arm_func_end ovl08_216D5E4

	arm_func_start ovl08_216D640
ovl08_216D640: // 0x0216D640
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216D6D8 // =aCharJbbgstep2N_1
	ldr r1, _0216D6DC // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r0, _0216D6E0 // =aCharYbbgstep2N_1
	ldr r1, _0216D6E4 // =GX_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _0216D6E8 // =aCharXb3multiNs
	ldr r1, _0216D6EC // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _0216D6F0 // =0x04001008
	ldr ip, _0216D6F4 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _0216D6F8 // =0x04000008
	ldr r2, _0216D6FC // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _0216D700 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D6D8: .word aCharJbbgstep2N_1
_0216D6DC: .word GX_LoadBG2Char
_0216D6E0: .word aCharYbbgstep2N_1
_0216D6E4: .word GX_LoadBGPltt
_0216D6E8: .word aCharXb3multiNs
_0216D6EC: .word GX_LoadBG2Scr
_0216D6F0: .word 0x04001008
_0216D6F4: .word 0x0400100A
_0216D6F8: .word 0x04000008
_0216D6FC: .word 0x0400000A
_0216D700: .word 0x0400000C
	arm_func_end ovl08_216D640

	arm_func_start ovl08_216D704
ovl08_216D704: // 0x0216D704
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216D754 // =0x0217E8F4
	mov r1, #0
	strb r1, [r0]
	bl ovl08_216D640
	mov r0, #8
	bl ovl08_215AB50
	mov r0, #0x38
	mvn r1, #0
	mov r2, #0
	bl ovl08_215A51C
	mov r0, #1
	bl ovl08_215A7A8
	mov r0, #0x27
	bl ovl08_215A6F4
	ldr r0, _0216D758 // =ovl08_216D5E4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D754: .word 0x0217E8F4
_0216D758: .word ovl08_216D5E4
	arm_func_end ovl08_216D704

	arm_func_start ovl08_216D75C
ovl08_216D75C: // 0x0216D75C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216D7C4 // =0x0217E8F8
	ldrb r0, [r0]
	cmp r0, #1
	bne _0216D794
	ldr r0, _0216D7C8 // =ovl08_216DB2C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216D794:
	mov r0, #0xb
	bl ovl08_216F934
	bl ovl08_215A320
	ldr r1, _0216D7C4 // =0x0217E8F8
	mov r2, #0
	ldr r0, _0216D7CC // =ovl08_216D8A0
	strb r2, [r1]
	bl ovl08_2170A8C
	ldr r0, _0216D7D0 // =ovl08_216DBFC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D7C4: .word 0x0217E8F8
_0216D7C8: .word ovl08_216DB2C
_0216D7CC: .word ovl08_216D8A0
_0216D7D0: .word ovl08_216DBFC
	arm_func_end ovl08_216D75C

	arm_func_start ovl08_216D7D4
ovl08_216D7D4: // 0x0216D7D4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	cmp r0, #0
	beq _0216D80C
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r1, _0216D834 // =0x0217E8F8
	mov r2, #3
	mov r0, #6
	strb r2, [r1]
	bl ovl08_216F934
	b _0216D820
_0216D80C:
	ldr r1, _0216D834 // =0x0217E8F8
	mov r2, #1
	mov r0, #7
	strb r2, [r1]
	bl ovl08_216F934
_0216D820:
	bl ovl08_2171598
	ldr r0, _0216D838 // =ovl08_216D75C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D834: .word 0x0217E8F8
_0216D838: .word ovl08_216D75C
	arm_func_end ovl08_216D7D4

	arm_func_start ovl08_216D83C
ovl08_216D83C: // 0x0216D83C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171568
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216D864 // =ovl08_216DB2C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D864: .word ovl08_216DB2C
	arm_func_end ovl08_216D83C

	arm_func_start ovl08_216D868
ovl08_216D868: // 0x0216D868
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171584
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #6
	bl ovl08_216F934
	bl ovl08_2171598
	ldr r0, _0216D89C // =ovl08_216D83C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D89C: .word ovl08_216D83C
	arm_func_end ovl08_216D868

	arm_func_start ovl08_216D8A0
ovl08_216D8A0: // 0x0216D8A0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0216D994 // =0x0217E8F8
	ldrb r2, [r1]
	cmp r2, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0216D98C
_0216D8C8: // jump table
	b _0216D8D8 // case 0
	b _0216D91C // case 1
	b _0216D938 // case 2
	b _0216D970 // case 3
_0216D8D8:
	mov r0, #3
	strb r0, [r1]
	bl ovl08_216F8D0
	mov r0, #0x12
	bl ovl08_216F934
	mov r1, #1
	mov ip, #0
	mov r2, r1
	mov r0, #0x10
	mvn r3, #0
	str ip, [sp]
	bl ovl08_21715E4
	bl ovl08_215A308
	ldr r0, _0216D998 // =ovl08_216D868
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216D91C:
	mov r0, #1
	strb r0, [r1]
	bl ovl08_216F8D0
	ldr r0, _0216D99C // =ovl08_216DB2C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216D938:
	bl ovl08_216F8D0
	mov r0, #0
	bl ovl08_2170A8C
	mov r1, #0
	mov r0, #0x11
	mov r2, #1
	mvn r3, #0
	str r1, [sp]
	bl ovl08_21715E4
	bl ovl08_215A308
	ldr r0, _0216D9A0 // =ovl08_216D7D4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216D970:
	mov r0, #2
	strb r0, [r1]
	bl ovl08_216F8D0
	mov r0, #9
	bl ovl08_216F934
	ldr r0, _0216D99C // =ovl08_216DB2C
	bl DWCi_ChangeScene
_0216D98C:
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216D994: .word 0x0217E8F8
_0216D998: .word ovl08_216D868
_0216D99C: .word ovl08_216DB2C
_0216D9A0: .word ovl08_216D7D4
	arm_func_end ovl08_216D8A0

	arm_func_start ovl08_216D9A4
ovl08_216D9A4: // 0x0216D9A4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216DAA4 // =0x0217E8F8
	ldrb r0, [r0]
	cmp r0, #2
	bne _0216D9E4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
_0216D9E4:
	bl ovl08_215A338
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_2170AA4
	bl ovl08_2159CD8
	mov r0, #0
	bl ovl08_2175D6C
	ldr r0, _0216DAA4 // =0x0217E8F8
	ldrb r0, [r0]
	add r0, r0, #0xfe
	and r0, r0, #0xff
	cmp r0, #1
	bhi _0216DA2C
	bl ovl08_215A4D8
	mov r0, #1
	mov r1, r0
	bl ovl08_217661C
_0216DA2C:
	mov r0, #0
	mov r1, #0x15
	bl ovl08_217661C
	ldr r0, _0216DAA4 // =0x0217E8F8
	ldrb r0, [r0]
	cmp r0, #2
	bne _0216DA64
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216DAA8 // =ovl08_216BDFC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216DA64:
	cmp r0, #3
	bne _0216DA88
	mov r0, #2
	mov r1, #1
	bl ovl08_215E674
	ldr r0, _0216DAAC // =ovl08_216D704
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
_0216DA88:
	mov r0, #0
	mov r1, r0
	bl ovl08_215E674
	ldr r0, _0216DAB0 // =ovl08_216D2EC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216DAA4: .word 0x0217E8F8
_0216DAA8: .word ovl08_216BDFC
_0216DAAC: .word ovl08_216D704
_0216DAB0: .word ovl08_216D2EC
	arm_func_end ovl08_216D9A4

	arm_func_start ovl08_216DAB4
ovl08_216DAB4: // 0x0216DAB4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A3AC
	ldr r0, _0216DB24 // =0x0217E8F8
	ldrb r0, [r0]
	add r0, r0, #0xfe
	and r0, r0, #0xff
	cmp r0, #1
	bhi _0216DB00
	mov r1, #1
	mov r2, r1
	mov r0, #3
	mov r3, #8
	bl ovl08_21759B8
_0216DB00:
	mov r0, #3
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	ldr r0, _0216DB28 // =ovl08_216D9A4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216DB24: .word 0x0217E8F8
_0216DB28: .word ovl08_216D9A4
	arm_func_end ovl08_216DAB4

	arm_func_start ovl08_216DB2C
ovl08_216DB2C: // 0x0216DB2C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A308
	mov r0, #8
	bl ovl08_217581C
	ldr r0, _0216DB50 // =ovl08_216DAB4
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216DB50: .word ovl08_216DAB4
	arm_func_end ovl08_216DB2C

	arm_func_start ovl08_216DB54
ovl08_216DB54: // 0x0216DB54
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216DBA8 // =0x0217E8F8
	ldrb r0, [r0]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_215A398
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216DBA8 // =0x0217E8F8
	mov r1, #2
	strb r1, [r0]
	bl ovl08_216F8D0
	mov r0, #7
	bl ovl08_216F934
	ldr r0, _0216DBAC // =ovl08_216DB2C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216DBA8: .word 0x0217E8F8
_0216DBAC: .word ovl08_216DB2C
	arm_func_end ovl08_216DB54

	arm_func_start ovl08_216DBB0
ovl08_216DBB0: // 0x0216DBB0
	bx lr
	arm_func_end ovl08_216DBB0

	arm_func_start ovl08_216DBB4
ovl08_216DBB4: // 0x0216DBB4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	beq _0216DBDC
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
_0216DBDC:
	bl ovl08_216DE18
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl ovl08_215A378
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216DBB4

	arm_func_start ovl08_216DBFC
ovl08_216DBFC: // 0x0216DBFC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_216DBB4
	bl ovl08_216DBB0
	bl ovl08_216DB54
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_216DBFC

	arm_func_start ovl08_216DC18
ovl08_216DC18: // 0x0216DC18
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_215A398
	mvn r1, #1
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ovl08_215A320
	ldr r0, _0216DC48 // =ovl08_216DBFC
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216DC48: .word ovl08_216DBFC
	arm_func_end ovl08_216DC18

	arm_func_start ovl08_216DC4C
ovl08_216DC4C: // 0x0216DC4C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl ovl08_2175A98
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #2
	bl ovl08_215A770
	ldr r0, _0216DC80 // =ovl08_216DC18
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216DC80: .word ovl08_216DC18
	arm_func_end ovl08_216DC4C

	arm_func_start ovl08_216DC84
ovl08_216DC84: // 0x0216DC84
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	mov r1, #0
	mov r2, #0x15
	mov r3, #8
	bl ovl08_21759B8
	mov r0, #0
	mov r1, #0x15
	bl ovl08_2176678
	ldr r0, _0216DCBC // =ovl08_216DC4C
	bl DWCi_ChangeScene
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216DCBC: .word ovl08_216DC4C
	arm_func_end ovl08_216DC84

	arm_func_start ovl08_216DCC0
ovl08_216DCC0: // 0x0216DCC0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216DD58 // =aCharJbbgstep3N_6
	ldr r1, _0216DD5C // =GX_LoadBG2Char
	bl ovl08_215A7F8
	ldr r0, _0216DD60 // =aCharYbbgstep3N_6
	ldr r1, _0216DD64 // =GX_LoadBGPltt
	bl ovl08_215A7F8
	ldr r0, _0216DD68 // =aCharJb4usbNscL
	ldr r1, _0216DD6C // =GX_LoadBG2Scr
	bl ovl08_215A7F8
	ldr r1, _0216DD70 // =0x04001008
	ldr ip, _0216DD74 // =0x0400100A
	ldrh r0, [r1]
	ldr r3, _0216DD78 // =0x04000008
	ldr r2, _0216DD7C // =0x0400000A
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [ip]
	ldr r1, _0216DD80 // =0x0400000C
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r3]
	ldrh r0, [r2]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r1]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216DD58: .word aCharJbbgstep3N_6
_0216DD5C: .word GX_LoadBG2Char
_0216DD60: .word aCharYbbgstep3N_6
_0216DD64: .word GX_LoadBGPltt
_0216DD68: .word aCharJb4usbNscL
_0216DD6C: .word GX_LoadBG2Scr
_0216DD70: .word 0x04001008
_0216DD74: .word 0x0400100A
_0216DD78: .word 0x04000008
_0216DD7C: .word 0x0400000A
_0216DD80: .word 0x0400000C
	arm_func_end ovl08_216DCC0

	arm_func_start ovl08_216DD84
ovl08_216DD84: // 0x0216DD84
	stmdb sp!, {lr}
	sub sp, sp, #0x6c
	ldr r0, _0216DE0C // =0x0217E8F8
	mov r1, #0
	strb r1, [r0]
	bl ovl08_216DCC0
	mov r0, #8
	bl ovl08_215AB50
	mov r0, #2
	bl ovl08_215A7A8
	add r0, sp, #0x16
	bl OS_GetOwnerInfo
	add r1, sp, #0
	mov r0, #0
	mov r2, #0x16
	bl MIi_CpuClear16
	ldrh r2, [sp, #0x2e]
	add r0, sp, #0x1a
	add r1, sp, #0
	mov r2, r2, lsl #1
	bl MIi_CpuCopy16
	add r0, sp, #0
	mov r1, #0x28
	bl ovl08_215A62C
	mov r0, #0
	bl ovl08_2159D18
	ldr r0, _0216DE10 // =ovl08_216D8A0
	bl ovl08_2170BDC
	mov r0, #0xb
	bl ovl08_216F934
	ldr r0, _0216DE14 // =ovl08_216DC84
	bl DWCi_ChangeScene
	add sp, sp, #0x6c
	ldmia sp!, {pc}
	.align 2, 0
_0216DE0C: .word 0x0217E8F8
_0216DE10: .word ovl08_216D8A0
_0216DE14: .word ovl08_216DC84
	arm_func_end ovl08_216DD84

	arm_func_start ovl08_216DE18
ovl08_216DE18: // 0x0216DE18
	ldr r0, _0216DE34 // =0x027FFFA8
	ldrh r0, [r0]
	and r0, r0, #0x8000
	movs r0, r0, asr #0xf
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0216DE34: .word 0x027FFFA8
	arm_func_end ovl08_216DE18

	arm_func_start ovl08_216DE38
ovl08_216DE38: // 0x0216DE38
	stmdb sp!, {r4, lr}
	ldr r1, _0216DE64 // =0x0217E900
	mov r4, r0
	ldr r0, [r1]
	mov r1, #0x5000000
	mov r2, #0x200
	bl MIi_CpuCopy16
	mov r1, r4
	mov r0, #1
	bl ovl08_2177870
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216DE64: .word 0x0217E900
	arm_func_end ovl08_216DE38

	arm_func_start ovl08_216DE68
ovl08_216DE68: // 0x0216DE68
	ldr r2, _0216DE88 // =0x0217E900
	ldr ip, _0216DE8C // =ovl08_2177924
	str r0, [r2]
	ldr r1, _0216DE90 // =ovl08_216DE38
	mov r0, #1
	mov r2, #0
	mov r3, #0x78
	bx ip
	.align 2, 0
_0216DE88: .word 0x0217E900
_0216DE8C: .word ovl08_2177924
_0216DE90: .word ovl08_216DE38
	arm_func_end ovl08_216DE68

	arm_func_start ovl08_216DE94
ovl08_216DE94: // 0x0216DE94
	stmdb sp!, {r4, lr}
	ldr r1, _0216DEC0 // =0x0217E900
	mov r4, r0
	ldr r0, [r1]
	ldr r1, [r1, #4]
	mov r2, #0x20
	bl MIi_CpuCopy16
	mov r1, r4
	mov r0, #1
	bl ovl08_2177870
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216DEC0: .word 0x0217E900
	arm_func_end ovl08_216DE94

	arm_func_start ovl08_216DEC4
ovl08_216DEC4: // 0x0216DEC4
	stmdb sp!, {r4, lr}
	add r4, r0, r1, lsl #5
	mov r0, r2, lsl #5
	ldr ip, _0216DEF8 // =0x0217E900
	add lr, r0, #0x5000000
	ldr r1, _0216DEFC // =ovl08_216DE94
	mov r0, #1
	mov r2, #0
	mov r3, #0x78
	str r4, [ip]
	str lr, [ip, #4]
	bl ovl08_2177924
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216DEF8: .word 0x0217E900
_0216DEFC: .word ovl08_216DE94
	arm_func_end ovl08_216DEC4

	arm_func_start ovl08_216DF00
ovl08_216DF00: // 0x0216DF00
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216DF5C // =0x0217E8FC
	ldr r1, [r0]
	ldrb r0, [r1, #0x604]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	add r0, r1, #4
	mov r1, #0x600
	bl DC_FlushRange
	ldr r0, _0216DF5C // =0x0217E8FC
	mov r1, #0
	ldr r0, [r0]
	mov r2, #0x600
	add r0, r0, #4
	bl GX_LoadBG2Scr
	ldr r0, _0216DF5C // =0x0217E8FC
	mov r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x604]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216DF5C: .word 0x0217E8FC
	arm_func_end ovl08_216DF00

	arm_func_start ovl08_216DF60
ovl08_216DF60: // 0x0216DF60
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr ip, _0216DFB4 // =0x0217E8FC
	mov r7, r3
	ldr r3, [ip]
	mov r8, r0
	add r0, r3, #4
	add r6, r0, r1, lsl #1
	mov r5, #0
	cmp r7, #0
	ldmleia sp!, {r4, r5, r6, r7, r8, pc}
	mov r4, r2, lsl #1
_0216DF8C:
	mov r0, r8
	mov r1, r6
	mov r2, r4
	bl MIi_CpuCopy16
	add r5, r5, #1
	cmp r5, r7
	add r8, r8, #0x40
	add r6, r6, #0x40
	blt _0216DF8C
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216DFB4: .word 0x0217E8FC
	arm_func_end ovl08_216DF60

	arm_func_start ovl08_216DFB8
ovl08_216DFB8: // 0x0216DFB8
	ldr r0, _0216DFCC // =0x0217E8FC
	mov r1, #1
	ldr r0, [r0]
	strb r1, [r0, #0x604]
	bx lr
	.align 2, 0
_0216DFCC: .word 0x0217E8FC
	arm_func_end ovl08_216DFB8

	arm_func_start ovl08_216DFD0
ovl08_216DFD0: // 0x0216DFD0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0216DFFC // =0x0217E8FC
	mov r0, #1
	ldr r1, [r1]
	ldr r1, [r1]
	bl ovl08_2177864
	ldr r0, _0216DFFC // =0x0217E8FC
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216DFFC: .word 0x0217E8FC
	arm_func_end ovl08_216DFD0

	arm_func_start ovl08_216E000
ovl08_216E000: // 0x0216E000
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _0216E054 // =0x00000608
	mov r1, #4
	bl ovl08_2176764
	mov ip, r0
	ldr r3, _0216E058 // =0x0217E8FC
	mov r0, r4
	add r1, ip, #4
	mov r2, #0x600
	str ip, [r3]
	bl MIi_CpuCopyFast
	ldr r1, _0216E05C // =ovl08_216DF00
	mov r0, #1
	mov r2, #0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _0216E058 // =0x0217E8FC
	ldr r1, [r1]
	str r0, [r1]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E054: .word 0x00000608
_0216E058: .word 0x0217E8FC
_0216E05C: .word ovl08_216DF00
	arm_func_end ovl08_216E000

	arm_func_start ovl08_216E060
ovl08_216E060: // 0x0216E060
	stmdb sp!, {r4, lr}
	ldr r1, _0216E098 // =0x0217E908
	mov r4, r0
	ldr r0, [r1]
	mvn r1, #0
	ldrh r3, [r0, #0x12]
	ldrh r2, [r0, #0x10]
	ldr r0, [r0]
	add r3, r4, r3
	bl ovl08_2174FA4
	ldr r0, _0216E098 // =0x0217E908
	ldr r0, [r0]
	strb r4, [r0, #0x1a]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E098: .word 0x0217E908
	arm_func_end ovl08_216E060

	arm_func_start ovl08_216E09C
ovl08_216E09C: // 0x0216E09C
	ldr r2, _0216E174 // =0x0217E908
	cmp r0, #4
	ldr r3, [r2]
	ldrh r3, [r3, #0x10]
	strh r3, [r1]
	ldrh r3, [r1]
	add r3, r3, #0xc
	strh r3, [r1, #4]
	addls pc, pc, r0, lsl #2
	bx lr
_0216E0C4: // jump table
	bx lr // case 0
	b _0216E0D8 // case 1
	b _0216E10C // case 2
	b _0216E12C // case 3
	b _0216E150 // case 4
_0216E0D8:
	ldr r3, [r2]
	ldr r0, _0216E178 // =0x0217AE58
	ldrh ip, [r3, #0x12]
	ldrb r3, [r3, #0x1a]
	add r3, ip, r3
	strh r3, [r1, #2]
	ldr r2, [r2]
	ldrh r3, [r1, #2]
	ldrb r2, [r2, #0x1b]
	ldrb r0, [r0, r2]
	add r0, r3, r0
	strh r0, [r1, #6]
	bx lr
_0216E10C:
	ldr r0, [r2]
	ldrh r0, [r0, #0x12]
	sub r0, r0, #0xd
	strh r0, [r1, #2]
	ldr r0, [r2]
	ldrh r0, [r0, #0x12]
	strh r0, [r1, #6]
	bx lr
_0216E12C:
	ldr r0, [r2]
	ldrh r2, [r0, #0x12]
	ldrb r0, [r0, #0x19]
	add r0, r2, r0
	strh r0, [r1, #2]
	ldrh r0, [r1, #2]
	add r0, r0, #0xd
	strh r0, [r1, #6]
	bx lr
_0216E150:
	ldr r0, [r2]
	ldrh r0, [r0, #0x12]
	strh r0, [r1, #2]
	ldr r0, [r2]
	ldrh r2, [r1, #2]
	ldrb r0, [r0, #0x19]
	add r0, r2, r0
	strh r0, [r1, #6]
	bx lr
	.align 2, 0
_0216E174: .word 0x0217E908
_0216E178: .word 0x0217AE58
	arm_func_end ovl08_216E09C

	arm_func_start ovl08_216E17C
ovl08_216E17C: // 0x0216E17C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, #2
	add r4, sp, #0
_0216E18C:
	mov r0, r5
	mov r1, r4
	bl ovl08_216E09C
	mov r0, r4
	bl ovl08_2176AA4
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, r5
	ldmneia sp!, {r4, r5, pc}
	add r5, r5, #1
	cmp r5, #3
	ble _0216E18C
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end ovl08_216E17C

	arm_func_start ovl08_216E1C8
ovl08_216E1C8: // 0x0216E1C8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	add r1, sp, #0
	mov r0, #1
	bl ovl08_216E09C
	add r0, sp, #0
	bl ovl08_21769CC
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, #1
	ldmneia sp!, {r4, r5, pc}
	mov r5, #2
	add r4, sp, #0
_0216E1FC:
	mov r0, r5
	mov r1, r4
	bl ovl08_216E09C
	mov r0, r4
	bl ovl08_21769CC
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, r5
	ldmneia sp!, {r4, r5, pc}
	add r5, r5, #1
	cmp r5, #3
	ble _0216E1FC
	add r1, sp, #0
	mov r0, #4
	bl ovl08_216E09C
	add r0, sp, #0
	bl ovl08_2176A38
	cmp r0, #0
	movne r0, #4
	moveq r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end ovl08_216E1C8

	arm_func_start ovl08_216E254
ovl08_216E254: // 0x0216E254
	stmdb sp!, {lr}
	sub sp, sp, #4
	add r0, sp, #0
	bl ovl08_21768D0
	ldr r0, _0216E2C0 // =0x0217E908
	ldr r2, _0216E2C4 // =0x0217AE58
	ldr ip, [r0]
	ldrh r1, [sp, #2]
	ldrb r3, [ip, #0x1b]
	ldrh r0, [ip, #0x12]
	ldrb r2, [r2, r3]
	sub r1, r1, r0
	mov r0, r2, lsr #1
	subs r0, r1, r0
	movmi r0, #0
	bmi _0216E2A4
	ldrb r1, [ip, #0x19]
	sub r1, r1, r2
	cmp r0, r1
	movge r0, r1
_0216E2A4:
	bl ovl08_216E060
	ldr r0, _0216E2C0 // =0x0217E908
	mov r1, #3
	ldr r0, [r0]
	strb r1, [r0, #0x1d]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216E2C0: .word 0x0217E908
_0216E2C4: .word 0x0217AE58
	arm_func_end ovl08_216E254

	arm_func_start ovl08_216E2C8
ovl08_216E2C8: // 0x0216E2C8
	ldr r1, _0216E2F0 // =0x0217E908
	cmp r0, #2
	ldr r1, [r1]
	strb r0, [r1, #0x1c]
	ldr r0, _0216E2F0 // =0x0217E908
	moveq r1, #4
	ldr r0, [r0]
	movne r1, #6
	strb r1, [r0, #0x1d]
	bx lr
	.align 2, 0
_0216E2F0: .word 0x0217E908
	arm_func_end ovl08_216E2C8

	arm_func_start ovl08_216E2F4
ovl08_216E2F4: // 0x0216E2F4
	stmdb sp!, {r4, lr}
	ldr r1, _0216E368 // =0x0217E908
	ldr r1, [r1]
	ldrb r1, [r1, #0x1a]
	subs r4, r1, r0
	rsbmi r4, r4, #0
	cmp r4, #2
	movlt r0, #0
	blt _0216E330
	cmp r4, #6
	movge r0, #0x7f
	bge _0216E330
	rsb r1, r4, #6
	mov r0, #0x7f
	bl FX_DivS32
_0216E330:
	bl ovl08_216F914
	cmp r4, #2
	mvnlt r1, #0xff
	blt _0216E35C
	cmp r4, #6
	movge r1, #0x100
	bge _0216E35C
	rsb r1, r4, #6
	mov r0, #0x200
	bl FX_DivS32
	sub r1, r0, #0x100
_0216E35C:
	ldr r0, _0216E36C // =0x0000FFFF
	bl ovl08_216F8F0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E368: .word 0x0217E908
_0216E36C: .word 0x0000FFFF
	arm_func_end ovl08_216E2F4

	arm_func_start ovl08_216E370
ovl08_216E370: // 0x0216E370
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r0, _0216E434 // =0x0217B024
	bl ovl08_2176AA4
	cmp r0, #0
	beq _0216E40C
	add r0, sp, #0
	bl ovl08_21768D0
	ldr r0, _0216E438 // =0x0217E908
	ldrh r1, [sp]
	ldr r3, [r0]
	ldrh r0, [r3, #0x10]
	sub r0, r0, #0x1e
	cmp r1, r0
	blt _0216E40C
	ldrh r1, [sp, #2]
	ldrh r0, [r3, #0x16]
	ldrb r2, [r3, #0x18]
	sub r0, r1, r0
	adds r4, r2, r0
	movmi r4, #0
	bmi _0216E3E4
	ldrb r1, [r3, #0x1b]
	ldr r0, _0216E43C // =0x0217AE58
	ldrb r2, [r3, #0x19]
	ldrb r0, [r0, r1]
	sub r0, r2, r0
	cmp r4, r0
	movge r4, r0
_0216E3E4:
	mov r0, r4
	bl ovl08_216E2F4
	mov r0, r4
	bl ovl08_216E060
	ldr r0, _0216E438 // =0x0217E908
	mov r1, #2
	ldr r0, [r0]
	add sp, sp, #8
	strb r1, [r0, #0x1d]
	ldmia sp!, {r4, pc}
_0216E40C:
	bl ovl08_216F8D0
	ldr r0, _0216E438 // =0x0217E908
	mov r3, #0
	ldr r2, [r0]
	mov r1, #3
	strb r3, [r2, #0x1c]
	ldr r0, [r0]
	strb r1, [r0, #0x1d]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E434: .word 0x0217B024
_0216E438: .word 0x0217E908
_0216E43C: .word 0x0217AE58
	arm_func_end ovl08_216E370

	arm_func_start ovl08_216E440
ovl08_216E440: // 0x0216E440
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216E5F8 // =0x0217E908
	mov r2, #0
	ldr r1, [r0]
	strb r2, [r1, #0x1d]
	ldr r1, [r0]
	ldrb r0, [r1, #0x1c]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0216E5F0
_0216E46C: // jump table
	b _0216E47C // case 0
	b _0216E544 // case 1
	b _0216E550 // case 2
	b _0216E5A4 // case 3
_0216E47C:
	ldrb r0, [r1, #0x1e]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_216E1C8
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _0216E5F0
_0216E49C: // jump table
	b _0216E5F0 // case 0
	b _0216E4B0 // case 1
	b _0216E518 // case 2
	b _0216E528 // case 3
	b _0216E538 // case 4
_0216E4B0:
	ldr r0, _0216E5F8 // =0x0217E908
	ldr r0, [r0]
	ldrb r0, [r0, #0x1b]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0x16
	bl ovl08_216F934
	mov r0, #0
	bl ovl08_216F914
	ldr r0, _0216E5F8 // =0x0217E908
	mov r2, #1
	ldr r1, [r0]
	strb r2, [r1, #0x1d]
	ldr r0, [r0]
	add r0, r0, #0x14
	bl ovl08_21768D0
	ldr r0, _0216E5F8 // =0x0217E908
	mov r1, #1
	ldr r3, [r0]
	add sp, sp, #4
	ldrb r2, [r3, #0x1a]
	strb r2, [r3, #0x18]
	ldr r0, [r0]
	strb r1, [r0, #0x1c]
	ldmia sp!, {pc}
_0216E518:
	mov r0, #2
	bl ovl08_216E2C8
	add sp, sp, #4
	ldmia sp!, {pc}
_0216E528:
	mov r0, #3
	bl ovl08_216E2C8
	add sp, sp, #4
	ldmia sp!, {pc}
_0216E538:
	bl ovl08_216E254
	add sp, sp, #4
	ldmia sp!, {pc}
_0216E544:
	bl ovl08_216E370
	add sp, sp, #4
	ldmia sp!, {pc}
_0216E550:
	mov r0, #2
	bl ovl08_216E17C
	cmp r0, #2
	beq _0216E584
	ldr r0, _0216E5F8 // =0x0217E908
	mov r3, #5
	ldr r2, [r0]
	mov r1, #0
	strb r3, [r2, #0x1d]
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x1c]
	ldmia sp!, {pc}
_0216E584:
	bl ovl08_216E1C8
	cmp r0, #2
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #2
	bl ovl08_216E2C8
	add sp, sp, #4
	ldmia sp!, {pc}
_0216E5A4:
	mov r0, #3
	bl ovl08_216E17C
	cmp r0, #3
	beq _0216E5D8
	ldr r0, _0216E5F8 // =0x0217E908
	mov r3, #7
	ldr r2, [r0]
	mov r1, #0
	strb r3, [r2, #0x1d]
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0x1c]
	ldmia sp!, {pc}
_0216E5D8:
	bl ovl08_216E1C8
	cmp r0, #3
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #3
	bl ovl08_216E2C8
_0216E5F0:
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216E5F8: .word 0x0217E908
	arm_func_end ovl08_216E440

	arm_func_start ovl08_216E5FC
ovl08_216E5FC: // 0x0216E5FC
	ldr r0, _0216E610 // =0x0217E908
	mov r1, #1
	ldr r0, [r0]
	strb r1, [r0, #0x1e]
	bx lr
	.align 2, 0
_0216E610: .word 0x0217E908
	arm_func_end ovl08_216E5FC

	arm_func_start ovl08_216E614
ovl08_216E614: // 0x0216E614
	ldr r0, _0216E628 // =0x0217E908
	mov r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x1e]
	bx lr
	.align 2, 0
_0216E628: .word 0x0217E908
	arm_func_end ovl08_216E614

	arm_func_start ovl08_216E62C
ovl08_216E62C: // 0x0216E62C
	ldr ip, _0216E634 // =ovl08_216E060
	bx ip
	.align 2, 0
_0216E634: .word ovl08_216E060
	arm_func_end ovl08_216E62C

	arm_func_start ovl08_216E638
ovl08_216E638: // 0x0216E638
	ldr r0, _0216E648 // =0x0217E908
	ldr r0, [r0]
	ldrb r0, [r0, #0x1d]
	bx lr
	.align 2, 0
_0216E648: .word 0x0217E908
	arm_func_end ovl08_216E638

	arm_func_start ovl08_216E64C
ovl08_216E64C: // 0x0216E64C
	ldr r0, _0216E65C // =0x0217E908
	ldr r0, [r0]
	ldrb r0, [r0, #0x1a]
	bx lr
	.align 2, 0
_0216E65C: .word 0x0217E908
	arm_func_end ovl08_216E64C

	arm_func_start ovl08_216E660
ovl08_216E660: // 0x0216E660
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0216E69C // =0x0217E908
	mov r0, #0
	ldr r1, [r1]
	ldr r1, [r1, #0xc]
	bl ovl08_2177864
	ldr r0, _0216E69C // =0x0217E908
	ldr r0, [r0]
	ldr r0, [r0]
	bl ovl08_2175204
	ldr r0, _0216E69C // =0x0217E908
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216E69C: .word 0x0217E908
	arm_func_end ovl08_216E660

	arm_func_start ovl08_216E6A0
ovl08_216E6A0: // 0x0216E6A0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	mov r7, r1
	mov r0, #0x20
	mov r1, #4
	mov r5, r2
	mov r4, r3
	bl ovl08_2176764
	ldr r2, _0216E774 // =0x0217E908
	ldr ip, [sp, #0x18]
	str r0, [r2]
	strb r6, [r0, #0x1b]
	ldr r1, [r2]
	mov r0, r5
	strb r7, [r1, #0x19]
	ldr r3, [r2]
	mov r1, r4
	strb ip, [r3, #0x1a]
	ldr r2, [r2]
	add r2, r2, #0x10
	bl ovl08_2176344
	ldr r1, _0216E778 // =0x0217AE54
	mov r0, #0
	ldrb r1, [r1, r6]
	mov r2, #1
	bl ovl08_2175528
	mov r2, r5
	ldr r5, _0216E774 // =0x0217E908
	ldr r3, [sp, #0x18]
	ldr r6, [r5]
	mvn r1, #0
	str r0, [r6]
	ldr r0, [r5]
	add r3, r4, r3
	ldr r0, [r0]
	bl ovl08_2174FA4
	mov r0, r5
	ldr r0, [r0]
	mvn r1, #0
	ldr r0, [r0]
	mov r2, #1
	bl ovl08_2174F30
	mov r0, #0
	ldr r1, _0216E77C // =ovl08_216E440
	mov r2, r0
	mov r3, #0x80
	bl ovl08_2177924
	mov r1, r5
	ldr r1, [r1]
	str r0, [r1, #0xc]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216E774: .word 0x0217E908
_0216E778: .word 0x0217AE54
_0216E77C: .word ovl08_216E440
	arm_func_end ovl08_216E6A0

	arm_func_start ovl08_216E780
ovl08_216E780: // 0x0216E780
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xac
	ldr r1, _0216E994 // =0x0217E90C
	str r0, [sp]
	ldr r2, [r1]
	mov r1, #0x400
	add r0, r2, #0xf00
	add r2, r2, #0x1300
	str r2, [sp, #4]
	bl DC_InvalidateRange
	ldr r0, [sp]
	ldrh r1, [r0, #0xe]
	mov r0, #0
	str r0, [sp, #8]
	cmp r1, #0
	addle sp, sp, #0xac
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	str r0, [sp, #0x20]
	str r0, [sp, #0x18]
	mov r0, #0x20
	str r0, [sp, #0x14]
	mov r0, #2
	str r0, [sp, #0x24]
	mov r0, #1
	ldr r11, _0216E998 // =0x0217AE60
	add r5, sp, #0x28
	mov r6, #6
	mov r4, #4
	str r0, [sp, #0x1c]
_0216E7FC:
	ldr r1, [sp]
	ldr r0, [sp, #8]
	add r0, r1, r0, lsl #2
	ldr r10, [r0, #0x10]
	ldrb r0, [r10, #0xc]
	cmp r0, #0
	beq _0216E96C
	ldrh r0, [r10, #0x3c]
	cmp r0, #0
	bne _0216E96C
	ldr r9, [sp, #0xc]
	ldr r8, [sp, #4]
	add r7, r10, #4
_0216E830:
	mov r0, r7
	add r1, r8, #0x20
	mov r2, r6
	bl memcmp
	cmp r0, #0
	beq _0216E858
	add r8, r8, #0x2a
	add r9, r9, #1
	cmp r9, #0x14
	blt _0216E830
_0216E858:
	cmp r9, #0x14
	bne _0216E89C
	ldr r9, [sp, #0x10]
	ldr r7, [sp, #4]
_0216E868:
	add r0, r7, #0x20
	mov r1, r11
	mov r2, r6
	bl memcmp
	cmp r0, #0
	beq _0216E890
	add r7, r7, #0x2a
	add r9, r9, #1
	cmp r9, #0x14
	blt _0216E868
_0216E890:
	cmp r9, #0x14
	addeq sp, sp, #0xac
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216E89C:
	ldr r0, [sp, #4]
	mov r1, #0x2a
	mla r7, r9, r1, r0
	add r0, r10, #4
	add r1, r7, #0x20
	mov r2, r6
	bl MI_CpuCopy8
	ldr r2, [sp, #0x14]
	add r0, r10, #0xc
	mov r1, r7
	bl MI_CpuCopy8
	ldr r1, [sp]
	ldr r0, [sp, #8]
	add r0, r1, r0, lsl #1
	ldrh r0, [r0, #0x50]
	strh r0, [r7, #0x26]
	ldrh r0, [r10, #0x2c]
	ands r0, r0, #0x10
	ldreq r0, [sp, #0x18]
	streqb r0, [r7, #0x28]
	beq _0216E96C
	ldr r0, [sp, #0x1c]
	mov r1, r10
	strb r0, [r7, #0x28]
	mov r0, r5
	bl sub_20F1E0C
	ldrb r8, [sp, #0x28]
	ldr r9, [sp, #0x20]
	cmp r8, #0
	ble _0216E96C
_0216E914:
	add r1, r5, r9, lsl #3
	ldrb r0, [r1, #4]
	cmp r0, #0x30
	ldreq r0, [sp, #0x24]
	streqb r0, [r7, #0x28]
	beq _0216E96C
	cmp r0, #0xdd
	bne _0216E960
	ldrb r0, [r1, #5]
	cmp r0, #4
	blo _0216E960
	ldr r0, [r1, #8]
	ldr r1, _0216E99C // =0x0217AE5C
	mov r2, r4
	bl memcmp
	cmp r0, #0
	ldreq r0, [sp, #0x24]
	streqb r0, [r7, #0x28]
	beq _0216E96C
_0216E960:
	add r9, r9, #1
	cmp r9, r8
	blt _0216E914
_0216E96C:
	ldr r0, [sp, #8]
	add r0, r0, #1
	str r0, [sp, #8]
	ldr r0, [sp]
	ldrh r1, [r0, #0xe]
	ldr r0, [sp, #8]
	cmp r0, r1
	blt _0216E7FC
	add sp, sp, #0xac
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216E994: .word 0x0217E90C
_0216E998: .word 0x0217AE60
_0216E99C: .word 0x0217AE5C
	arm_func_end ovl08_216E780

	arm_func_start ovl08_216E9A0
ovl08_216E9A0: // 0x0216E9A0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r1, [r0, #2]
	cmp r1, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r1, _0216EA20 // =0x0217E90C
	ldr r1, [r1]
	add r1, r1, #0x1000
	ldrb r1, [r1, #0xe4c]
	cmp r1, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldrh r1, [r0]
	cmp r1, #0x26
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldrh r1, [r0, #8]
	cmp r1, #4
	beq _0216EA08
	cmp r1, #5
	bne _0216EA14
	bl ovl08_216E780
	bl ovl08_216EB34
	add sp, sp, #4
	ldmia sp!, {pc}
_0216EA08:
	bl ovl08_216EB34
	add sp, sp, #4
	ldmia sp!, {pc}
_0216EA14:
	bl OS_Terminate
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216EA20: .word 0x0217E90C
	arm_func_end ovl08_216E9A0

	arm_func_start ovl08_216EA24
ovl08_216EA24: // 0x0216EA24
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r1, _0216EA7C // =0x0217E90C
	mov r4, #0
	ldr r1, [r1]
	mov r8, r4
	add r1, r1, #0x1300
	str r1, [r0]
	ldr r7, [r0]
	ldr r6, _0216EA80 // =0x0217AE60
	mov r5, #6
_0216EA4C:
	mov r1, r6
	mov r2, r5
	add r0, r7, #0x20
	bl memcmp
	cmp r0, #0
	add r8, r8, #1
	addne r4, r4, #1
	cmp r8, #0x14
	add r7, r7, #0x2a
	blt _0216EA4C
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216EA7C: .word 0x0217E90C
_0216EA80: .word 0x0217AE60
	arm_func_end ovl08_216EA24

	arm_func_start ovl08_216EA84
ovl08_216EA84: // 0x0216EA84
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _0216EB28 // =0x0217E90C
	mov r3, #1
	ldr r0, [r2]
	ldr r1, _0216EB2C // =0x0000168C
	add r0, r0, #0x1000
	strb r3, [r0, #0xe4c]
	ldr r0, [r2]
	add r0, r0, r1
	bl WM_ReadStatus
	ldr r0, _0216EB28 // =0x0217E90C
	ldr r0, [r0]
	add r0, r0, #0x1600
	ldrh r0, [r0, #0x8c]
	cmp r0, #2
	beq _0216EB0C
	ldr r0, _0216EB30 // =ovl08_216E9A0
	bl WM_Reset
	cmp r0, #2
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
_0216EAE0:
	ldr r1, _0216EB28 // =0x0217E90C
	ldr r0, _0216EB2C // =0x0000168C
	ldr r1, [r1]
	add r0, r1, r0
	bl WM_ReadStatus
	ldr r0, _0216EB28 // =0x0217E90C
	ldr r0, [r0]
	add r0, r0, #0x1600
	ldrh r0, [r0, #0x8c]
	cmp r0, #2
	bne _0216EAE0
_0216EB0C:
	ldr r0, _0216EB30 // =ovl08_216E9A0
	bl WM_End
	cmp r0, #2
	movne r0, #0
	moveq r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216EB28: .word 0x0217E90C
_0216EB2C: .word 0x0000168C
_0216EB30: .word ovl08_216E9A0
	arm_func_end ovl08_216EA84

	arm_func_start ovl08_216EB34
ovl08_216EB34: // 0x0216EB34
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216EB68 // =0x0217E90C
	ldr r1, _0216EB6C // =0x00001648
	ldr r2, [r0]
	ldr r0, _0216EB70 // =ovl08_216E9A0
	add r1, r2, r1
	bl sub_20F27B8
	cmp r0, #2
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216EB68: .word 0x0217E90C
_0216EB6C: .word 0x00001648
_0216EB70: .word ovl08_216E9A0
	arm_func_end ovl08_216EB34

	arm_func_start ovl08_216EB74
ovl08_216EB74: // 0x0216EB74
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _0216EC44 // =0x0217E90C
	mov r0, #0
	ldr r1, [r1]
	mov r2, #0x348
	add r1, r1, #0x1300
	bl MIi_CpuClear16
	ldr r0, _0216EC44 // =0x0217E90C
	ldr r1, _0216EC48 // =ovl08_216E9A0
	ldr r0, [r0]
	mov r2, #3
	bl WM_Initialize
	cmp r0, #2
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, pc}
_0216EBB8:
	ldr r1, _0216EC44 // =0x0217E90C
	ldr r0, _0216EC4C // =0x0000168C
	ldr r1, [r1]
	add r0, r1, r0
	bl WM_ReadStatus
	ldr r0, _0216EC44 // =0x0217E90C
	ldr r5, [r0]
	add r0, r5, #0x1600
	ldrh r0, [r0, #0x8c]
	cmp r0, #2
	bne _0216EBB8
	ldr r0, _0216EC50 // =0x00001648
	ldr r4, _0216EC54 // =0x0217AE68
	add lr, r5, r0
	mov ip, #4
_0216EBF4:
	ldmia r4!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	subs ip, ip, #1
	bne _0216EBF4
	ldr r0, [r4]
	add r1, r5, #0xf00
	str r0, [lr]
	add r0, r5, #0x1000
	str r1, [r0, #0x648]
	bl WM_GetDispersionScanPeriod
	ldr r1, _0216EC44 // =0x0217E90C
	ldr r1, [r1]
	add r1, r1, #0x1600
	strh r0, [r1, #0x50]
	bl ovl08_216EB34
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216EC44: .word 0x0217E90C
_0216EC48: .word ovl08_216E9A0
_0216EC4C: .word 0x0000168C
_0216EC50: .word 0x00001648
_0216EC54: .word 0x0217AE68
	arm_func_end ovl08_216EB74

	arm_func_start ovl08_216EC58
ovl08_216EC58: // 0x0216EC58
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216EC90 // =0x0217E90C
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
_0216EC74:
	bl WM_GetAllowedChannel
	cmp r0, #0x8000
	bne _0216EC74
	ldr r0, _0216EC90 // =0x0217E90C
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216EC90: .word 0x0217E90C
	arm_func_end ovl08_216EC58

	arm_func_start ovl08_216EC94
ovl08_216EC94: // 0x0216EC94
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216ECCC // =0x0217E90C
	ldr r0, [r0]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _0216ECD0 // =0x00001E60
	mov r1, #0x20
	bl ovl08_2176764
	ldr r1, _0216ECCC // =0x0217E90C
	str r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216ECCC: .word 0x0217E90C
_0216ECD0: .word 0x00001E60
	arm_func_end ovl08_216EC94

	arm_func_start ovl08_216ECD4
ovl08_216ECD4: // 0x0216ECD4
	cmp r0, #0x39
	subls r0, r0, #0x30
	bxls lr
	cmp r0, #0x46
	subls r0, r0, #0x37
	subhi r0, r0, #0x57
	bx lr
	arm_func_end ovl08_216ECD4

	arm_func_start ovl08_216ECF0
ovl08_216ECF0: // 0x0216ECF0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r9, r1
	add r0, sp, #0
	mov r1, #0
	mov r2, #4
	bl MI_CpuFill8
	mov r8, #0
	mov r7, r8
	add r6, sp, #0
	mov r11, r8
	mov r4, #0x20
	mov r5, #3
_0216ED28:
	mov r1, r6
	mov r2, r5
	add r0, r10, r7
	bl MI_CpuCopy8
	mov r2, r11
	mov r1, r6
_0216ED40:
	ldrb r0, [r1]
	cmp r0, #0
	bne _0216ED5C
	add r2, r2, #1
	cmp r2, #3
	strb r4, [r1], #1
	blt _0216ED40
_0216ED5C:
	mov r0, r6
	bl atoi
	strb r0, [r9, r8]
	add r8, r8, #1
	cmp r8, #4
	add r7, r7, #3
	blt _0216ED28
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end ovl08_216ECF0

	arm_func_start ovl08_216ED80
ovl08_216ED80: // 0x0216ED80
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x14
	ldr r1, _0216EEE8 // =0x0217E910
	mov r7, r0
	ldr r0, [r1]
	mov r4, #0
	add r2, r0, r7, lsl #8
	ldrb r6, [r2, #0xe7]
	mov r3, #1
	add r0, sp, #4
	mov r1, r4
	mov r2, #0x10
	mov r5, r3, lsl r7
	bl MI_CpuFill8
	add r0, sp, #4
	mov r2, #1
	str r2, [r0, r7, lsl #2]
	cmp r7, #2
	bgt _0216EE60
	ldr r0, _0216EEE8 // =0x0217E910
	ldr r0, [r0]
	ldrb r1, [r0, #0xef]
	ands r1, r1, r5
	movne r4, r2
	cmp r6, #0xff
	bne _0216EE24
	cmp r4, #0
	beq _0216EE24
	ldrb r2, [r0, #0xef]
	mvn r3, r5
	ldr r1, _0216EEE8 // =0x0217E910
	and r2, r2, r3
	strb r2, [r0, #0xef]
	ldr r2, [r1]
	mov r0, #1
	ldrb r1, [r2, #0x1ef]
	and r1, r1, r3
	strb r1, [r2, #0x1ef]
	str r0, [sp, #8]
	str r0, [sp, #4]
	b _0216EE60
_0216EE24:
	cmp r6, #0xff
	beq _0216EE60
	cmp r4, #0
	bne _0216EE60
	ldrb r3, [r0, #0xef]
	ldr r1, _0216EEE8 // =0x0217E910
	mov r2, #1
	orr r3, r3, r5
	strb r3, [r0, #0xef]
	ldr r1, [r1]
	ldrb r0, [r1, #0x1ef]
	orr r0, r0, r5
	strb r0, [r1, #0x1ef]
	str r2, [sp, #8]
	str r2, [sp, #4]
_0216EE60:
	mov r7, #0
	mov r6, r7
	ldr r9, _0216EEE8 // =0x0217E910
	add r5, sp, #4
	mov r4, #0xfe
	ldr r8, _0216EEEC // =0x000004F8
_0216EE78:
	ldr r0, [r5, r7, lsl #2]
	cmp r0, #0
	beq _0216EEA4
	ldr r1, [r9]
	mov r2, r4
	add r0, r1, r8
	add r1, r1, r6
	bl MATH_CalcCRC16
	ldr r1, [r9]
	add r1, r1, r7, lsl #8
	strh r0, [r1, #0xfe]
_0216EEA4:
	add r7, r7, #1
	cmp r7, #4
	add r6, r6, #0x100
	blt _0216EE78
	mov r0, #0x100
	mov r1, #0x20
	bl ovl08_2176788
	mov r2, r0
	ldr r0, _0216EEE8 // =0x0217E910
	add r1, sp, #4
	ldr r0, [r0]
	str r2, [sp]
	bl sub_208DE64
	add r0, sp, #0
	bl ovl08_2176714
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0216EEE8: .word 0x0217E910
_0216EEEC: .word 0x000004F8
	arm_func_end ovl08_216ED80

	arm_func_start ovl08_216EEF0
ovl08_216EEF0: // 0x0216EEF0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x18
	ldr r1, _0216EF9C // =0x0217E910
	mov r0, #0
	ldr r1, [r1]
	mov r2, #0x400
	bl MIi_CpuClear16
	mov r3, #0
	ldr r0, _0216EF9C // =0x0217E910
	mov r2, #0xff
_0216EF18:
	ldr r1, [r0]
	add r1, r1, r3, lsl #8
	add r3, r3, #1
	strb r2, [r1, #0xe7]
	cmp r3, #3
	blt _0216EF18
	add r0, sp, #0
	bl sub_208E92C
	add r0, sp, #0
	bl sub_208D4B8
	mov r6, #0
	ldr r4, _0216EF9C // =0x0217E910
	mov r8, r0
	mov r7, r6
	mov r5, #0xe
_0216EF54:
	ldr r1, [r4]
	mov r0, r8
	add r1, r1, r7
	mov r2, r5
	add r1, r1, #0xf0
	bl MI_CpuCopy8
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #0x100
	blt _0216EF54
	mov r4, #0
_0216EF80:
	mov r0, r4
	bl ovl08_216ED80
	add r4, r4, #1
	cmp r4, #4
	blt _0216EF80
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216EF9C: .word 0x0217E910
	arm_func_end ovl08_216EEF0

	arm_func_start ovl08_216EFA0
ovl08_216EFA0: // 0x0216EFA0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _0216EFE0 // =0x0217E910
	mov r5, r0
	ldr r0, [r1]
	mov r1, #0
	add r4, r0, r5, lsl #8
	mov r0, r4
	mov r2, #0xef
	bl MI_CpuFill8
	mov r1, #0xff
	mov r0, r5
	strb r1, [r4, #0xe7]
	bl ovl08_216ED80
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216EFE0: .word 0x0217E910
	arm_func_end ovl08_216EFA0

	arm_func_start ovl08_216EFE4
ovl08_216EFE4: // 0x0216EFE4
	ldr r0, _0216EFF0 // =0x0217E910
	ldr r0, [r0]
	bx lr
	.align 2, 0
_0216EFF0: .word 0x0217E910
	arm_func_end ovl08_216EFE4

	arm_func_start ovl08_216EFF4
ovl08_216EFF4: // 0x0216EFF4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _0216F108 // =0x0217E910
	mov r5, r0
	ldr r0, [r1]
	mov r1, #0
	add r4, r0, #0x400
	mov r0, r4
	mov r2, #0xef
	bl MI_CpuFill8
	mov r0, r5
	add r1, r4, #0xd1
	mov r2, #5
	bl MI_CpuCopy8
	add r0, r5, #6
	add r1, r4, #0xd6
	mov r2, #5
	bl MI_CpuCopy8
	add r0, r5, #0xc
	add r1, r4, #0xdb
	mov r2, #5
	bl MI_CpuCopy8
	add r0, r5, #0x12
	add r1, r4, #0xe0
	mov r2, #5
	bl MI_CpuCopy8
	add r0, r5, #0x18
	add r1, r4, #0x60
	mov r2, #0x20
	bl MI_CpuCopy8
	add r0, r5, #0x39
	add r1, r4, #0x80
	mov r2, #0xd
	bl MI_CpuCopy8
	add r0, r5, #0x47
	add r1, r4, #0x90
	mov r2, #0xd
	bl MI_CpuCopy8
	add r0, r5, #0x55
	add r1, r4, #0xa0
	mov r2, #0xd
	bl MI_CpuCopy8
	add r0, r5, #0x63
	add r1, r4, #0xb0
	mov r2, #0xd
	bl MI_CpuCopy8
	add r0, r5, #0x71
	add r1, r4, #0x40
	mov r2, #0x20
	bl MI_CpuCopy8
	ldrb r1, [r4, #0xe6]
	mov r3, #1
	add r0, r4, #0xf0
	bic r1, r1, #3
	orr r1, r1, #2
	strb r1, [r4, #0xe6]
	ldrb ip, [r4, #0xe6]
	mov r1, #0
	mov r2, #4
	bic ip, ip, #0xfc
	strb ip, [r4, #0xe6]
	strb r3, [r4, #0xe7]
	bl MI_CpuFill8
	mov r0, #1
	strb r0, [r4, #0xf5]
	strb r0, [r4, #0xf6]
	bl ovl08_216F224
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216F108: .word 0x0217E910
	arm_func_end ovl08_216EFF4

	arm_func_start ovl08_216F10C
ovl08_216F10C: // 0x0216F10C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r1, _0216F220 // =0x0217E910
	mov r6, r0
	ldr r0, [r1]
	mov r1, #0
	add r5, r0, #0x400
	mov r0, r5
	mov r2, #0xef
	bl MI_CpuFill8
	mov r0, r6
	add r1, r5, #0x40
	mov r2, #0x20
	bl MI_CpuCopy8
	ldr r0, [r6, #0x20]
	cmp r0, #1
	beq _0216F160
	cmp r0, #2
	beq _0216F178
	cmp r0, #3
	beq _0216F190
	b _0216F1A8
_0216F160:
	ldrb r0, [r5, #0xe6]
	mov r4, #5
	bic r0, r0, #3
	orr r0, r0, #1
	strb r0, [r5, #0xe6]
	b _0216F1B8
_0216F178:
	ldrb r0, [r5, #0xe6]
	mov r4, #0xd
	bic r0, r0, #3
	orr r0, r0, #2
	strb r0, [r5, #0xe6]
	b _0216F1B8
_0216F190:
	ldrb r0, [r5, #0xe6]
	mov r4, #0x10
	bic r0, r0, #3
	orr r0, r0, #3
	strb r0, [r5, #0xe6]
	b _0216F1B8
_0216F1A8:
	ldrb r0, [r5, #0xe6]
	mov r4, #0
	bic r0, r0, #3
	strb r0, [r5, #0xe6]
_0216F1B8:
	ldrb r0, [r5, #0xe6]
	add r7, r5, #0x80
	add r6, r6, #0x28
	bic r0, r0, #0xfc
	strb r0, [r5, #0xe6]
	mov r8, #0
_0216F1D0:
	mov r0, r6
	mov r1, r7
	mov r2, r4
	bl MI_CpuCopy8
	add r8, r8, #1
	cmp r8, #4
	add r7, r7, #0x10
	add r6, r6, #0x20
	blt _0216F1D0
	mov r3, #2
	add r0, r5, #0xf0
	mov r1, #0
	mov r2, #4
	strb r3, [r5, #0xe7]
	bl MI_CpuFill8
	mov r0, #1
	strb r0, [r5, #0xf5]
	strb r0, [r5, #0xf6]
	bl ovl08_216F224
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216F220: .word 0x0217E910
	arm_func_end ovl08_216F10C

	arm_func_start ovl08_216F224
ovl08_216F224: // 0x0216F224
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _0216F308 // =0x0217E910
	mov r2, #0x78
	ldr r1, [r0]
	add r5, r1, #0x400
	ldrb r0, [r5, #0xf4]
	mov ip, r5
	add r4, r1, r0, lsl #8
	mov r3, r4
_0216F24C:
	ldrb r1, [ip], #1
	ldrb r0, [ip], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _0216F24C
	ldrb r0, [r5, #0xf5]
	cmp r0, #0
	beq _0216F29C
	add r0, r4, #0xc0
	mov r1, #0
	mov r2, #4
	bl MI_CpuFill8
	add r0, r4, #0xc4
	mov r1, #0
	mov r2, #4
	bl MI_CpuFill8
	mov r0, #0
	strb r0, [r4, #0xd0]
	b _0216F2C8
_0216F29C:
	add r0, r5, #0xc0
	add r1, r4, #0xc0
	mov r2, #4
	bl MI_CpuCopy8
	add r0, r5, #0xc4
	add r1, r4, #0xc4
	mov r2, #4
	bl MI_CpuCopy8
	add r0, r5, #0xf0
	bl sub_208DD68
	strb r0, [r4, #0xd0]
_0216F2C8:
	ldrb r0, [r5, #0xf6]
	cmp r0, #0
	beq _0216F2E8
	add r0, r4, #0xc8
	mov r1, #0
	mov r2, #8
	bl MI_CpuFill8
	b _0216F2F8
_0216F2E8:
	add r0, r5, #0xc8
	add r1, r4, #0xc8
	mov r2, #8
	bl MI_CpuCopy8
_0216F2F8:
	ldrb r0, [r5, #0xf4]
	bl ovl08_216ED80
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216F308: .word 0x0217E910
	arm_func_end ovl08_216F224

	arm_func_start ovl08_216F30C
ovl08_216F30C: // 0x0216F30C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _0216F3EC // =0x0217E910
	mov r3, #0x78
	ldr r5, [r1]
	add r4, r5, r0, lsl #8
	mov lr, r4
	add ip, r5, #0x400
_0216F32C:
	ldrb r2, [lr], #1
	ldrb r1, [lr], #1
	subs r3, r3, #1
	strb r2, [ip], #1
	strb r1, [ip], #1
	bne _0216F32C
	ldr r1, _0216F3F0 // =0x0217AEAC
	strb r0, [r5, #0x4f4]
	add r0, r4, #0xc0
	mov r2, #4
	bl memcmp
	cmp r0, #0
	ldrne r0, _0216F3EC // =0x0217E910
	movne r1, #0
	ldrne r0, [r0]
	mov r2, #4
	strneb r1, [r0, #0x4f5]
	ldreq r0, _0216F3EC // =0x0217E910
	moveq r1, #1
	ldreq r0, [r0]
	streqb r1, [r0, #0x4f5]
	ldr r1, _0216F3F0 // =0x0217AEAC
	add r0, r4, #0xc8
	bl memcmp
	cmp r0, #0
	bne _0216F3AC
	ldr r1, _0216F3F0 // =0x0217AEAC
	add r0, r4, #0xcc
	mov r2, #4
	bl memcmp
	cmp r0, #0
	beq _0216F3C0
_0216F3AC:
	ldr r0, _0216F3EC // =0x0217E910
	mov r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x4f6]
	b _0216F3D0
_0216F3C0:
	ldr r0, _0216F3EC // =0x0217E910
	mov r1, #1
	ldr r0, [r0]
	strb r1, [r0, #0x4f6]
_0216F3D0:
	ldr r1, _0216F3EC // =0x0217E910
	ldrb r0, [r4, #0xd0]
	ldr r1, [r1]
	add r1, r1, #0x4f0
	bl sub_208DD38
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216F3EC: .word 0x0217E910
_0216F3F0: .word 0x0217AEAC
	arm_func_end ovl08_216F30C

	arm_func_start ovl08_216F3F4
ovl08_216F3F4: // 0x0216F3F4
	ldr r1, _0216F408 // =0x0217E910
	ldr r1, [r1]
	add r0, r1, r0, lsl #8
	ldrb r0, [r0, #0xe7]
	bx lr
	.align 2, 0
_0216F408: .word 0x0217E910
	arm_func_end ovl08_216F3F4

	arm_func_start ovl08_216F40C
ovl08_216F40C: // 0x0216F40C
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r1, _0216F44C // =0x0217E910
	ldr r2, _0216F450 // =0x000004CC
	ldr r3, [r1]
	ldr r1, _0216F454 // =a3d3d3d3d_0
	add ip, r3, r2
	ldrb r2, [ip, #2]
	str r2, [sp]
	ldrb r2, [ip, #3]
	str r2, [sp, #4]
	ldrb r2, [r3, #0x4cc]
	ldrb r3, [ip, #1]
	bl OS_SPrintf
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0216F44C: .word 0x0217E910
_0216F450: .word 0x000004CC
_0216F454: .word a3d3d3d3d_0
	arm_func_end ovl08_216F40C

	arm_func_start ovl08_216F458
ovl08_216F458: // 0x0216F458
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r1, _0216F498 // =0x0217E910
	ldr r2, _0216F49C // =0x000004C8
	ldr r3, [r1]
	ldr r1, _0216F4A0 // =a3d3d3d3d_0
	add ip, r3, r2
	ldrb r2, [ip, #2]
	str r2, [sp]
	ldrb r2, [ip, #3]
	str r2, [sp, #4]
	ldrb r2, [r3, #0x4c8]
	ldrb r3, [ip, #1]
	bl OS_SPrintf
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0216F498: .word 0x0217E910
_0216F49C: .word 0x000004C8
_0216F4A0: .word a3d3d3d3d_0
	arm_func_end ovl08_216F458

	arm_func_start ovl08_216F4A4
ovl08_216F4A4: // 0x0216F4A4
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r1, _0216F4E4 // =0x0217E910
	ldr r2, _0216F4E8 // =0x000004C4
	ldr r3, [r1]
	ldr r1, _0216F4EC // =a3d3d3d3d_0
	add ip, r3, r2
	ldrb r2, [ip, #2]
	str r2, [sp]
	ldrb r2, [ip, #3]
	str r2, [sp, #4]
	ldrb r2, [r3, #0x4c4]
	ldrb r3, [ip, #1]
	bl OS_SPrintf
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0216F4E4: .word 0x0217E910
_0216F4E8: .word 0x000004C4
_0216F4EC: .word a3d3d3d3d_0
	arm_func_end ovl08_216F4A4

	arm_func_start ovl08_216F4F0
ovl08_216F4F0: // 0x0216F4F0
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r2, _0216F52C // =0x0217E910
	ldr r1, _0216F530 // =a3d3d3d3d_0
	ldr r3, [r2]
	add ip, r3, #0x4f0
	ldrb r2, [ip, #2]
	str r2, [sp]
	ldrb r2, [ip, #3]
	str r2, [sp, #4]
	ldrb r2, [r3, #0x4f0]
	ldrb r3, [ip, #1]
	bl OS_SPrintf
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0216F52C: .word 0x0217E910
_0216F530: .word a3d3d3d3d_0
	arm_func_end ovl08_216F4F0

	arm_func_start ovl08_216F534
ovl08_216F534: // 0x0216F534
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r2, _0216F570 // =0x0217E910
	ldr r1, _0216F574 // =a3d3d3d3d_0
	ldr r3, [r2]
	add ip, r3, #0x4c0
	ldrb r2, [ip, #2]
	str r2, [sp]
	ldrb r2, [ip, #3]
	str r2, [sp, #4]
	ldrb r2, [r3, #0x4c0]
	ldrb r3, [ip, #1]
	bl OS_SPrintf
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0216F570: .word 0x0217E910
_0216F574: .word a3d3d3d3d_0
	arm_func_end ovl08_216F534

	arm_func_start ovl08_216F578
ovl08_216F578: // 0x0216F578
	ldr r2, _0216F594 // =0x0217E910
	mov r1, r0
	ldr r0, [r2]
	ldr ip, _0216F598 // =MI_CpuCopy8
	mov r2, #0x20
	add r0, r0, #0x440
	bx ip
	.align 2, 0
_0216F594: .word 0x0217E910
_0216F598: .word MI_CpuCopy8
	arm_func_end ovl08_216F578

	arm_func_start ovl08_216F59C
ovl08_216F59C: // 0x0216F59C
	ldr r2, _0216F5B4 // =0x0217E910
	ldr r1, _0216F5B8 // =0x000004CC
	ldr r2, [r2]
	ldr ip, _0216F5BC // =ovl08_216ECF0
	add r1, r2, r1
	bx ip
	.align 2, 0
_0216F5B4: .word 0x0217E910
_0216F5B8: .word 0x000004CC
_0216F5BC: .word ovl08_216ECF0
	arm_func_end ovl08_216F59C

	arm_func_start ovl08_216F5C0
ovl08_216F5C0: // 0x0216F5C0
	ldr r2, _0216F5D8 // =0x0217E910
	ldr r1, _0216F5DC // =0x000004C8
	ldr r2, [r2]
	ldr ip, _0216F5E0 // =ovl08_216ECF0
	add r1, r2, r1
	bx ip
	.align 2, 0
_0216F5D8: .word 0x0217E910
_0216F5DC: .word 0x000004C8
_0216F5E0: .word ovl08_216ECF0
	arm_func_end ovl08_216F5C0

	arm_func_start ovl08_216F5E4
ovl08_216F5E4: // 0x0216F5E4
	ldr r2, _0216F5FC // =0x0217E910
	ldr r1, _0216F600 // =0x000004C4
	ldr r2, [r2]
	ldr ip, _0216F604 // =ovl08_216ECF0
	add r1, r2, r1
	bx ip
	.align 2, 0
_0216F5FC: .word 0x0217E910
_0216F600: .word 0x000004C4
_0216F604: .word ovl08_216ECF0
	arm_func_end ovl08_216F5E4

	arm_func_start ovl08_216F608
ovl08_216F608: // 0x0216F608
	ldr r1, _0216F61C // =0x0217E910
	ldr ip, _0216F620 // =ovl08_216ECF0
	ldr r1, [r1]
	add r1, r1, #0x4f0
	bx ip
	.align 2, 0
_0216F61C: .word 0x0217E910
_0216F620: .word ovl08_216ECF0
	arm_func_end ovl08_216F608

	arm_func_start ovl08_216F624
ovl08_216F624: // 0x0216F624
	ldr r1, _0216F638 // =0x0217E910
	ldr ip, _0216F63C // =ovl08_216ECF0
	ldr r1, [r1]
	add r1, r1, #0x4c0
	bx ip
	.align 2, 0
_0216F638: .word 0x0217E910
_0216F63C: .word ovl08_216ECF0
	arm_func_end ovl08_216F624

	arm_func_start ovl08_216F640
ovl08_216F640: // 0x0216F640
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r1, _0216F7E8 // =0x0217E910
	mov r6, r0
	ldr r0, [r1]
	mov r1, #0
	add r0, r0, #0x480
	mov r2, #0x10
	bl MI_CpuFill8
	mov r0, r6
	mov r1, #0x20
	bl ovl08_2177504
	mov r4, r0
	cmp r4, #0xa
	bgt _0216F68C
	cmp r4, #0xa
	bge _0216F6A8
	cmp r4, #0
	beq _0216F6A8
	b _0216F704
_0216F68C:
	cmp r4, #0x1a
	bgt _0216F6A0
	cmp r4, #0x1a
	beq _0216F6A8
	b _0216F704
_0216F6A0:
	cmp r4, #0x20
	bne _0216F704
_0216F6A8:
	ldr r0, _0216F7E8 // =0x0217E910
	cmp r4, #0
	ldr r2, [r0]
	mov r5, #0
	ldrb r1, [r2, #0x4e6]
	bic r1, r1, #0xfc
	strb r1, [r2, #0x4e6]
	ldr r0, [r0]
	add r8, r0, #0x480
	ble _0216F730
_0216F6D0:
	ldrb r0, [r6, r5]
	bl ovl08_216ECD4
	add r1, r5, #1
	mov r7, r0
	ldrb r0, [r6, r1]
	bl ovl08_216ECD4
	add r0, r0, r7, lsl #4
	add r5, r5, #2
	strb r0, [r8]
	cmp r5, r4
	add r8, r8, #1
	blt _0216F6D0
	b _0216F730
_0216F704:
	ldr r1, _0216F7E8 // =0x0217E910
	mov r0, r6
	ldr r5, [r1]
	mov r2, #0x10
	ldrb r3, [r5, #0x4e6]
	bic r3, r3, #0xfc
	orr r3, r3, #4
	strb r3, [r5, #0x4e6]
	ldr r1, [r1]
	add r1, r1, #0x480
	bl MI_CpuCopy8
_0216F730:
	cmp r4, #5
	bgt _0216F74C
	cmp r4, #5
	bge _0216F794
	cmp r4, #0
	beq _0216F77C
	b _0216F7CC
_0216F74C:
	cmp r4, #0xd
	bgt _0216F770
	cmp r4, #0xa
	blt _0216F7CC
	cmp r4, #0xa
	beq _0216F794
	cmp r4, #0xd
	beq _0216F7B0
	b _0216F7CC
_0216F770:
	cmp r4, #0x1a
	beq _0216F7B0
	b _0216F7CC
_0216F77C:
	ldr r0, _0216F7E8 // =0x0217E910
	ldr r1, [r0]
	ldrb r0, [r1, #0x4e6]
	bic r0, r0, #3
	strb r0, [r1, #0x4e6]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0216F794:
	ldr r0, _0216F7E8 // =0x0217E910
	ldr r1, [r0]
	ldrb r0, [r1, #0x4e6]
	bic r0, r0, #3
	orr r0, r0, #1
	strb r0, [r1, #0x4e6]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0216F7B0:
	ldr r0, _0216F7E8 // =0x0217E910
	ldr r1, [r0]
	ldrb r0, [r1, #0x4e6]
	bic r0, r0, #3
	orr r0, r0, #2
	strb r0, [r1, #0x4e6]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0216F7CC:
	ldr r0, _0216F7E8 // =0x0217E910
	ldr r1, [r0]
	ldrb r0, [r1, #0x4e6]
	bic r0, r0, #3
	orr r0, r0, #3
	strb r0, [r1, #0x4e6]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216F7E8: .word 0x0217E910
	arm_func_end ovl08_216F640

	arm_func_start ovl08_216F7EC
ovl08_216F7EC: // 0x0216F7EC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0216F820 // =0x0217E910
	mov r2, #0x20
	ldr r1, [r1]
	add r1, r1, #0x440
	bl MI_CpuCopy8
	ldr r0, _0216F820 // =0x0217E910
	mov r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x4e7]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216F820: .word 0x0217E910
	arm_func_end ovl08_216F7EC

	arm_func_start ovl08_216F824
ovl08_216F824: // 0x0216F824
	ldr r1, _0216F834 // =0x0217E910
	ldr r1, [r1]
	strb r0, [r1, #0x4f6]
	bx lr
	.align 2, 0
_0216F834: .word 0x0217E910
	arm_func_end ovl08_216F824

	arm_func_start ovl08_216F838
ovl08_216F838: // 0x0216F838
	ldr r1, _0216F848 // =0x0217E910
	ldr r1, [r1]
	strb r0, [r1, #0x4f5]
	bx lr
	.align 2, 0
_0216F848: .word 0x0217E910
	arm_func_end ovl08_216F838

	arm_func_start ovl08_216F84C
ovl08_216F84C: // 0x0216F84C
	ldr r0, _0216F85C // =0x0217E910
	ldr r0, [r0]
	add r0, r0, #0x400
	bx lr
	.align 2, 0
_0216F85C: .word 0x0217E910
	arm_func_end ovl08_216F84C

	arm_func_start ovl08_216F860
ovl08_216F860: // 0x0216F860
	ldr ip, _0216F86C // =ovl08_2176714
	ldr r0, _0216F870 // =0x0217E910
	bx ip
	.align 2, 0
_0216F86C: .word ovl08_2176714
_0216F870: .word 0x0217E910
	arm_func_end ovl08_216F860

	arm_func_start ovl08_216F874
ovl08_216F874: // 0x0216F874
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0216F8B4 // =0x000006F8
	mov r1, #0x20
	bl ovl08_2176788
	ldr r1, _0216F8B8 // =0x0217E910
	ldr r2, _0216F8BC // =0x000004F8
	str r0, [r1]
	ldr r1, _0216F8C0 // =0x0000A001
	add r0, r0, r2
	bl MATHi_CRC16InitTableRev
	ldr r0, _0216F8B8 // =0x0217E910
	ldr r0, [r0]
	bl sub_208DEF0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216F8B4: .word 0x000006F8
_0216F8B8: .word 0x0217E910
_0216F8BC: .word 0x000004F8
_0216F8C0: .word 0x0000A001
	arm_func_end ovl08_216F874

	arm_func_start ovl08_216F8C4
ovl08_216F8C4: // 0x0216F8C4
	ldr ip, _0216F8CC // =NNS_SndMain
	bx ip
	.align 2, 0
_0216F8CC: .word NNS_SndMain
	arm_func_end ovl08_216F8C4

	arm_func_start ovl08_216F8D0
ovl08_216F8D0: // 0x0216F8D0
	ldr r0, _0216F8E8 // =0x0217E914
	ldr ip, _0216F8EC // =NNS_SndPlayerStopSeq
	ldr r0, [r0]
	mov r1, #0
	add r0, r0, #0x90
	bx ip
	.align 2, 0
_0216F8E8: .word 0x0217E914
_0216F8EC: .word NNS_SndPlayerStopSeq
	arm_func_end ovl08_216F8D0

	arm_func_start ovl08_216F8F0
ovl08_216F8F0: // 0x0216F8F0
	ldr r2, _0216F90C // =0x0217E914
	ldr ip, _0216F910 // =NNS_SndPlayerSetTrackPitch
	ldr r3, [r2]
	mov r2, r1
	mov r1, r0
	add r0, r3, #0x90
	bx ip
	.align 2, 0
_0216F90C: .word 0x0217E914
_0216F910: .word NNS_SndPlayerSetTrackPitch
	arm_func_end ovl08_216F8F0

	arm_func_start ovl08_216F914
ovl08_216F914: // 0x0216F914
	ldr r2, _0216F92C // =0x0217E914
	mov r1, r0
	ldr r0, [r2]
	ldr ip, _0216F930 // =NNS_SndPlayerSetVolume
	add r0, r0, #0x90
	bx ip
	.align 2, 0
_0216F92C: .word 0x0217E914
_0216F930: .word NNS_SndPlayerSetVolume
	arm_func_end ovl08_216F914

	arm_func_start ovl08_216F934
ovl08_216F934: // 0x0216F934
	ldr r1, _0216F950 // =0x0217E914
	mov r2, r0
	ldr r0, [r1]
	ldr ip, _0216F954 // =NNS_SndArcPlayerStartSeqArc
	mov r1, #0
	add r0, r0, #0x90
	bx ip
	.align 2, 0
_0216F950: .word 0x0217E914
_0216F954: .word NNS_SndArcPlayerStartSeqArc
	arm_func_end ovl08_216F934

	arm_func_start ovl08_216F958
ovl08_216F958: // 0x0216F958
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0216F984 // =0x0217E914
	mov r0, #0
	ldr r1, [r1]
	ldr r1, [r1, #0x98]
	bl ovl08_2177870
	ldr r0, _0216F984 // =0x0217E914
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216F984: .word 0x0217E914
	arm_func_end ovl08_216F958

	arm_func_start DWCi_SNDlInit
DWCi_SNDlInit: // 0x0216F988
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0x9c
	mov r1, #4
	bl ovl08_2176788
	ldr r2, _0216FA14 // =0x0217E914
	add r1, sp, #0
	str r0, [r2]
	ldr r0, _0216FA18 // =aSoundSoundData
	mov r2, #0x20
	bl ovl08_2174AF4
	ldr r1, _0216FA14 // =0x0217E914
	ldr r1, [r1]
	str r0, [r1, #0x94]
	bl NNS_SndInit
	ldr r0, _0216FA14 // =0x0217E914
	ldr r0, [r0]
	ldr r1, [r0, #0x94]
	bl NNS_SndArcInitOnMemory
	mov r0, #0
	bl NNS_SndArcPlayerSetup
	ldr r0, _0216FA14 // =0x0217E914
	ldr r0, [r0]
	add r0, r0, #0x90
	bl NNS_SndHandleInit
	mov r0, #0
	ldr r1, _0216FA1C // =ovl08_216F8C4
	mov r2, r0
	mov r3, #0xc8
	bl ovl08_2177924
	ldr r1, _0216FA14 // =0x0217E914
	ldr r1, [r1]
	str r0, [r1, #0x98]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216FA14: .word 0x0217E914
_0216FA18: .word aSoundSoundData
_0216FA1C: .word ovl08_216F8C4
	arm_func_end DWCi_SNDlInit

	arm_func_start ovl08_216FA20
ovl08_216FA20: // 0x0216FA20
	stmdb sp!, {r4, lr}
	ldr r1, _0216FA68 // =0x0217E918
	mov r4, r0
	ldr r0, [r1]
	mov r1, #0x600
	bl DC_FlushRange
	ldr r0, _0216FA68 // =0x0217E918
	mov r1, #0
	ldr r0, [r0]
	mov r2, #0x600
	bl GXS_LoadBG1Scr
	ldr r0, _0216FA68 // =0x0217E918
	ldr r0, [r0]
	bl ovl08_2174AB8
	mov r1, r4
	mov r0, #1
	bl ovl08_2177870
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FA68: .word 0x0217E918
	arm_func_end ovl08_216FA20

	arm_func_start ovl08_216FA6C
ovl08_216FA6C: // 0x0216FA6C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0216FAB0 // =_0217BEF4
	ldr r0, [r1, r0, lsl #2]
	bl ovl08_215A840
	mov r1, #0
	mov r2, #4
	bl ovl08_2174AF4
	ldr r2, _0216FAB4 // =0x0217E918
	ldr r1, _0216FAB8 // =ovl08_216FA20
	str r0, [r2]
	mov r0, #1
	mov r2, #0
	mov r3, #0x78
	bl ovl08_2177924
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0216FAB0: .word _0217BEF4
_0216FAB4: .word 0x0217E918
_0216FAB8: .word ovl08_216FA20
	arm_func_end ovl08_216FA6C

	arm_func_start ovl08_216FABC
ovl08_216FABC: // 0x0216FABC
	ldr r0, _0216FAE4 // =0x0217E91C
	ldr r0, [r0]
	cmp r0, #0
	moveq r0, #1
	bxeq lr
	ldrb r0, [r0, #0x18]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_0216FAE4: .word 0x0217E91C
	arm_func_end ovl08_216FABC

	arm_func_start ovl08_216FAE8
ovl08_216FAE8: // 0x0216FAE8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r1, _0216FBB0 // =0x0217E91C
	mov r5, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r0, [sp]
	ldr r6, _0216FBB0 // =0x0217E91C
	sub r0, r0, #8
	ldr r7, _0216FBB4 // =0x0217AED0
	mov r4, #0
	str r0, [sp]
	mvn r8, #0
_0216FB2C:
	add r0, r7, r4, lsl #2
	ldr r1, [r6]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r4, lsl #2]
	ldr r2, [sp]
	mov r1, r8
	bl ovl08_2174FA4
	add r4, r4, #1
	cmp r4, #5
	blt _0216FB2C
	ldr r1, [sp]
	ldr r0, _0216FBB8 // =0x000001D6
	cmp r1, r0
	addgt sp, sp, #8
	ldmgtia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r1, #0x100
	addlt sp, sp, #8
	ldmltia sp!, {r4, r5, r6, r7, r8, pc}
	mov r1, r5
	mov r0, #0
	bl ovl08_2177870
	mov r5, #0
	ldr r4, _0216FBB0 // =0x0217E91C
_0216FB88:
	ldr r0, [r4]
	ldr r0, [r0, r5, lsl #2]
	bl ovl08_2175204
	add r5, r5, #1
	cmp r5, #5
	blt _0216FB88
	ldr r0, _0216FBB0 // =0x0217E91C
	bl ovl08_2176714
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216FBB0: .word 0x0217E91C
_0216FBB4: .word 0x0217AED0
_0216FBB8: .word 0x000001D6
	arm_func_end ovl08_216FAE8

	arm_func_start ovl08_216FBBC
ovl08_216FBBC: // 0x0216FBBC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r1, _0216FC88 // =0x0217E91C
	mov r5, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0, #4]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r4, _0216FC8C // =0x0217AED0
	ldr r1, [sp]
	ldrh r0, [r4]
	sub r1, r1, #8
	str r1, [sp]
	cmp r1, r0
	ble _0216FC3C
	ldr r5, _0216FC88 // =0x0217E91C
	mov r7, #1
	mvn r6, #0
_0216FC0C:
	add r0, r4, r7, lsl #2
	ldr r1, [r5]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r7, lsl #2]
	ldr r2, [sp]
	mov r1, r6
	bl ovl08_2174FA4
	add r7, r7, #1
	cmp r7, #5
	blt _0216FC0C
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0216FC3C:
	str r0, [sp]
	mov r8, #1
	ldr r6, _0216FC88 // =0x0217E91C
	mvn r7, #0
_0216FC4C:
	add r0, r4, r8, lsl #2
	ldr r1, [r6]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r8, lsl #2]
	ldr r2, [sp]
	mov r1, r7
	bl ovl08_2174FA4
	add r8, r8, #1
	cmp r8, #5
	blt _0216FC4C
	ldr r1, _0216FC90 // =ovl08_216FAE8
	mov r0, r5
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216FC88: .word 0x0217E91C
_0216FC8C: .word 0x0217AED0
_0216FC90: .word ovl08_216FAE8
	arm_func_end ovl08_216FBBC

	arm_func_start ovl08_216FC94
ovl08_216FC94: // 0x0216FC94
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r1, _0216FD60 // =0x0217E91C
	mov r5, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0, #8]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r4, _0216FD64 // =0x0217AED0
	ldr r1, [sp]
	ldrh r0, [r4, #4]
	sub r1, r1, #8
	str r1, [sp]
	cmp r1, r0
	ble _0216FD14
	ldr r5, _0216FD60 // =0x0217E91C
	mov r7, #2
	mvn r6, #0
_0216FCE4:
	add r0, r4, r7, lsl #2
	ldr r1, [r5]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r7, lsl #2]
	ldr r2, [sp]
	mov r1, r6
	bl ovl08_2174FA4
	add r7, r7, #1
	cmp r7, #5
	blt _0216FCE4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0216FD14:
	str r0, [sp]
	mov r8, #2
	ldr r6, _0216FD60 // =0x0217E91C
	mvn r7, #0
_0216FD24:
	add r0, r4, r8, lsl #2
	ldr r1, [r6]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r8, lsl #2]
	ldr r2, [sp]
	mov r1, r7
	bl ovl08_2174FA4
	add r8, r8, #1
	cmp r8, #5
	blt _0216FD24
	ldr r1, _0216FD68 // =ovl08_216FBBC
	mov r0, r5
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216FD60: .word 0x0217E91C
_0216FD64: .word 0x0217AED0
_0216FD68: .word ovl08_216FBBC
	arm_func_end ovl08_216FC94

	arm_func_start ovl08_216FD6C
ovl08_216FD6C: // 0x0216FD6C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r1, _0216FE38 // =0x0217E91C
	mov r5, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0, #0xc]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r4, _0216FE3C // =0x0217AED0
	ldr r1, [sp]
	ldrh r0, [r4, #8]
	sub r1, r1, #8
	str r1, [sp]
	cmp r1, r0
	ble _0216FDEC
	ldr r5, _0216FE38 // =0x0217E91C
	mov r7, #3
	mvn r6, #0
_0216FDBC:
	add r0, r4, r7, lsl #2
	ldr r1, [r5]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r7, lsl #2]
	ldr r2, [sp]
	mov r1, r6
	bl ovl08_2174FA4
	add r7, r7, #1
	cmp r7, #5
	blt _0216FDBC
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0216FDEC:
	str r0, [sp]
	mov r8, #3
	ldr r6, _0216FE38 // =0x0217E91C
	mvn r7, #0
_0216FDFC:
	add r0, r4, r8, lsl #2
	ldr r1, [r6]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r8, lsl #2]
	ldr r2, [sp]
	mov r1, r7
	bl ovl08_2174FA4
	add r8, r8, #1
	cmp r8, #5
	blt _0216FDFC
	ldr r1, _0216FE40 // =ovl08_216FC94
	mov r0, r5
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216FE38: .word 0x0217E91C
_0216FE3C: .word 0x0217AED0
_0216FE40: .word ovl08_216FC94
	arm_func_end ovl08_216FD6C

	arm_func_start ovl08_216FE44
ovl08_216FE44: // 0x0216FE44
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0216FEDC // =0x0217E91C
	mov r4, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0, #0x10]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r1, _0216FEE0 // =0x0217AED0
	ldr r0, [sp]
	ldrh ip, [r1, #0xc]
	sub r2, r0, #8
	str r2, [sp]
	cmp r2, ip
	ble _0216FEA8
	ldr r0, _0216FEDC // =0x0217E91C
	ldrh r3, [r1, #0x12]
	ldr r0, [r0]
	mvn r1, #0
	ldr r0, [r0, #0x10]
	bl ovl08_2174FA4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0216FEA8:
	ldr r0, _0216FEDC // =0x0217E91C
	str ip, [sp]
	ldr r0, [r0]
	ldrh r3, [r1, #0x12]
	ldr r0, [r0, #0x10]
	mov r2, ip
	mvn r1, #0
	bl ovl08_2174FA4
	ldr r1, _0216FEE4 // =ovl08_216FD6C
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FEDC: .word 0x0217E91C
_0216FEE0: .word 0x0217AED0
_0216FEE4: .word ovl08_216FD6C
	arm_func_end ovl08_216FE44

	arm_func_start ovl08_216FEE8
ovl08_216FEE8: // 0x0216FEE8
	ldr r0, _0216FF04 // =0x0217E91C
	ldr r0, [r0]
	ldr r0, [r0, #0x14]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0216FF04: .word 0x0217E91C
	arm_func_end ovl08_216FEE8

	arm_func_start ovl08_216FF08
ovl08_216FF08: // 0x0216FF08
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r1, #5
	mul r2, r0, r1
	mov r10, #0
	str r0, [sp]
	ldr r1, _0216FFE0 // =0x0217AEB0
	ldr r0, _0216FFE4 // =0x0217AEC0
	ldr r4, _0216FFE8 // =0x0217E91C
	add r9, r1, r2
	add r8, r0, r2
	mov r7, r10
	mov r11, r10
	str r10, [sp, #4]
	mov r6, #1
	mvn r5, #0
_0216FF48:
	ldr r0, [r4]
	mov r1, r7
	ldr r0, [r0, r10, lsl #2]
	bl ovl08_21751F8
	mov r2, r0
	ldrb r1, [r9]
	mov r0, r6
	bl ovl08_217559C
	ldr r0, [r4]
	mov r1, r5
	ldr r0, [r0, r10, lsl #2]
	mov r2, r11
	bl ovl08_2174F30
	ldr r3, _0216FFEC // =0x0217AED0
	ldr r0, [r4]
	add r3, r3, r10, lsl #2
	ldr r1, _0216FFEC // =0x0217AED0
	mov r2, r10, lsl #2
	ldrh r2, [r1, r2]
	ldrh r3, [r3, #2]
	ldr r0, [r0, r10, lsl #2]
	mov r1, r5
	bl ovl08_2174FA4
	ldr r0, [r4]
	ldrb r3, [r8]
	ldr r0, [r0, r10, lsl #2]
	ldr r2, [sp, #4]
	mov r1, r5
	bl ovl08_21750B0
	add r10, r10, #2
	add r9, r9, #2
	add r8, r8, #2
	cmp r10, #5
	blt _0216FF48
	ldr r0, [sp]
	bl ovl08_216FA6C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216FFE0: .word 0x0217AEB0
_0216FFE4: .word 0x0217AEC0
_0216FFE8: .word 0x0217E91C
_0216FFEC: .word 0x0217AED0
	arm_func_end ovl08_216FF08

	arm_func_start ovl08_216FFF0
ovl08_216FFF0: // 0x0216FFF0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _02170030 // =0x0217E91C
	mov r0, #0
	ldr ip, [r1]
	mov lr, #1
	ldr r1, _02170034 // =ovl08_216FE44
	mov r2, r0
	mov r3, #0x78
	strb lr, [ip, #0x18]
	bl ovl08_2177924
	ldr r1, _02170030 // =0x0217E91C
	ldr r1, [r1]
	str r0, [r1, #0x14]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02170030: .word 0x0217E91C
_02170034: .word ovl08_216FE44
	arm_func_end ovl08_216FFF0

	arm_func_start ovl08_2170038
ovl08_2170038: // 0x02170038
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, r0
	mov r0, #0
	bl ovl08_2177870
	ldr r0, _02170064 // =0x0217E91C
	mov r1, #0
	ldr r0, [r0]
	str r1, [r0, #0x14]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02170064: .word 0x0217E91C
	arm_func_end ovl08_2170038

	arm_func_start ovl08_2170068
ovl08_2170068: // 0x02170068
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0217010C // =0x0217E91C
	mov r4, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0, #0x10]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r1, _02170110 // =0x0217AED0
	ldr r0, [sp]
	ldrh ip, [r1, #0x10]
	add r2, r0, #8
	str r2, [sp]
	cmp r2, ip
	blt _021700B4
	cmp r2, #0x100
	ble _021700D8
_021700B4:
	ldr r1, _0217010C // =0x0217E91C
	ldr r0, _02170110 // =0x0217AED0
	ldr r1, [r1]
	ldrh r3, [r0, #0x12]
	ldr r0, [r1, #0x10]
	mvn r1, #0
	bl ovl08_2174FA4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_021700D8:
	ldr r0, _0217010C // =0x0217E91C
	str ip, [sp]
	ldr r0, [r0]
	ldrh r3, [r1, #0x12]
	ldr r0, [r0, #0x10]
	mov r2, ip
	mvn r1, #0
	bl ovl08_2174FA4
	ldr r1, _02170114 // =ovl08_2170038
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217010C: .word 0x0217E91C
_02170110: .word 0x0217AED0
_02170114: .word ovl08_2170038
	arm_func_end ovl08_2170068

	arm_func_start ovl08_2170118
ovl08_2170118: // 0x02170118
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r1, _021701F0 // =0x0217E91C
	mov r4, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0, #0xc]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r6, _021701F4 // =0x0217AED0
	ldr r1, [sp]
	ldrh r0, [r6, #0xc]
	add r1, r1, #8
	str r1, [sp]
	cmp r1, r0
	blt _02170164
	cmp r1, #0x100
	ble _021701A4
_02170164:
	ldr r4, _021701F0 // =0x0217E91C
	ldr r5, _021701F4 // =0x0217AED0
	mov r7, #3
	mvn r6, #0
_02170174:
	add r0, r5, r7, lsl #2
	ldr r1, [r4]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r7, lsl #2]
	ldr r2, [sp]
	mov r1, r6
	bl ovl08_2174FA4
	add r7, r7, #1
	cmp r7, #5
	blt _02170174
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_021701A4:
	str r0, [sp]
	mov r8, #3
	ldr r5, _021701F0 // =0x0217E91C
	mvn r7, #0
_021701B4:
	add r0, r6, r8, lsl #2
	ldr r1, [r5]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r8, lsl #2]
	ldr r2, [sp]
	mov r1, r7
	bl ovl08_2174FA4
	add r8, r8, #1
	cmp r8, #5
	blt _021701B4
	ldr r1, _021701F8 // =ovl08_2170068
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021701F0: .word 0x0217E91C
_021701F4: .word 0x0217AED0
_021701F8: .word ovl08_2170068
	arm_func_end ovl08_2170118

	arm_func_start ovl08_21701FC
ovl08_21701FC: // 0x021701FC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r1, _021702D4 // =0x0217E91C
	mov r4, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0, #8]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r6, _021702D8 // =0x0217AED0
	ldr r1, [sp]
	ldrh r0, [r6, #8]
	add r1, r1, #8
	str r1, [sp]
	cmp r1, r0
	blt _02170248
	cmp r1, #0x100
	ble _02170288
_02170248:
	ldr r4, _021702D4 // =0x0217E91C
	ldr r5, _021702D8 // =0x0217AED0
	mov r7, #2
	mvn r6, #0
_02170258:
	add r0, r5, r7, lsl #2
	ldr r1, [r4]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r7, lsl #2]
	ldr r2, [sp]
	mov r1, r6
	bl ovl08_2174FA4
	add r7, r7, #1
	cmp r7, #5
	blt _02170258
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02170288:
	str r0, [sp]
	mov r8, #2
	ldr r5, _021702D4 // =0x0217E91C
	mvn r7, #0
_02170298:
	add r0, r6, r8, lsl #2
	ldr r1, [r5]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r8, lsl #2]
	ldr r2, [sp]
	mov r1, r7
	bl ovl08_2174FA4
	add r8, r8, #1
	cmp r8, #5
	blt _02170298
	ldr r1, _021702DC // =ovl08_2170118
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021702D4: .word 0x0217E91C
_021702D8: .word 0x0217AED0
_021702DC: .word ovl08_2170118
	arm_func_end ovl08_21701FC

	arm_func_start ovl08_21702E0
ovl08_21702E0: // 0x021702E0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r1, _021703B8 // =0x0217E91C
	mov r4, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0, #4]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r6, _021703BC // =0x0217AED0
	ldr r1, [sp]
	ldrh r0, [r6, #4]
	add r1, r1, #8
	str r1, [sp]
	cmp r1, r0
	blt _0217032C
	cmp r1, #0x100
	ble _0217036C
_0217032C:
	ldr r4, _021703B8 // =0x0217E91C
	ldr r5, _021703BC // =0x0217AED0
	mov r7, #1
	mvn r6, #0
_0217033C:
	add r0, r5, r7, lsl #2
	ldr r1, [r4]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r7, lsl #2]
	ldr r2, [sp]
	mov r1, r6
	bl ovl08_2174FA4
	add r7, r7, #1
	cmp r7, #5
	blt _0217033C
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0217036C:
	str r0, [sp]
	mov r8, #1
	ldr r5, _021703B8 // =0x0217E91C
	mvn r7, #0
_0217037C:
	add r0, r6, r8, lsl #2
	ldr r1, [r5]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r8, lsl #2]
	ldr r2, [sp]
	mov r1, r7
	bl ovl08_2174FA4
	add r8, r8, #1
	cmp r8, #5
	blt _0217037C
	ldr r1, _021703C0 // =ovl08_21701FC
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021703B8: .word 0x0217E91C
_021703BC: .word 0x0217AED0
_021703C0: .word ovl08_21701FC
	arm_func_end ovl08_21702E0

	arm_func_start ovl08_21703C4
ovl08_21703C4: // 0x021703C4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r1, _0217049C // =0x0217E91C
	mov r4, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r6, _021704A0 // =0x0217AED0
	ldr r1, [sp]
	ldrh r0, [r6]
	add r1, r1, #8
	str r1, [sp]
	cmp r1, r0
	blt _02170410
	cmp r1, #0x100
	ble _02170450
_02170410:
	ldr r4, _0217049C // =0x0217E91C
	ldr r5, _021704A0 // =0x0217AED0
	mov r7, #0
	mvn r6, #0
_02170420:
	add r0, r5, r7, lsl #2
	ldr r1, [r4]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r7, lsl #2]
	ldr r2, [sp]
	mov r1, r6
	bl ovl08_2174FA4
	add r7, r7, #1
	cmp r7, #5
	blt _02170420
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02170450:
	str r0, [sp]
	mov r8, #0
	ldr r5, _0217049C // =0x0217E91C
	mvn r7, #0
_02170460:
	add r0, r6, r8, lsl #2
	ldr r1, [r5]
	ldrh r3, [r0, #2]
	ldr r0, [r1, r8, lsl #2]
	ldr r2, [sp]
	mov r1, r7
	bl ovl08_2174FA4
	add r8, r8, #1
	cmp r8, #5
	blt _02170460
	ldr r1, _021704A4 // =ovl08_21702E0
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0217049C: .word 0x0217E91C
_021704A0: .word 0x0217AED0
_021704A4: .word ovl08_21702E0
	arm_func_end ovl08_21703C4

	arm_func_start ovl08_21704A8
ovl08_21704A8: // 0x021704A8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	str r0, [sp]
	mov r0, #0x1c
	mov r1, #4
	bl ovl08_2176764
	ldr r1, [sp]
	mov r2, #5
	mul r3, r1, r2
	mov r10, #0
	ldr r4, _021705AC // =0x0217E91C
	ldr r2, _021705B0 // =0x0217AEB0
	ldr r1, _021705B4 // =0x0217AEC0
	str r0, [r4]
	add r9, r2, r3
	add r8, r1, r3
	mov r11, r10
	str r10, [sp, #4]
	mov r7, #1
	mvn r6, #0
	mvn r5, #0x29
_021704FC:
	ldrb r1, [r9]
	mov r0, r7
	mov r2, r7
	bl ovl08_2175528
	ldr r2, [r4]
	mov r1, r6
	str r0, [r2, r10, lsl #2]
	ldr r0, [r4]
	mov r2, r11
	ldr r0, [r0, r10, lsl #2]
	bl ovl08_2174F30
	ldr r3, _021705B8 // =0x0217AED0
	ldr r0, [r4]
	add r3, r3, r10, lsl #2
	ldrh r3, [r3, #2]
	ldr r0, [r0, r10, lsl #2]
	mov r1, r6
	mov r2, r5
	bl ovl08_2174FA4
	ldr r0, [r4]
	ldrb r3, [r8]
	ldr r0, [r0, r10, lsl #2]
	ldr r2, [sp, #4]
	mov r1, r6
	bl ovl08_21750B0
	add r10, r10, #1
	add r9, r9, #1
	add r8, r8, #1
	cmp r10, #5
	blt _021704FC
	mov r0, #0
	ldr r1, _021705BC // =ovl08_21703C4
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _021705AC // =0x0217E91C
	ldr r1, [r1]
	str r0, [r1, #0x14]
	ldr r0, [sp]
	bl ovl08_216FA6C
	mov r0, #0xd
	bl ovl08_216F934
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021705AC: .word 0x0217E91C
_021705B0: .word 0x0217AEB0
_021705B4: .word 0x0217AEC0
_021705B8: .word 0x0217AED0
_021705BC: .word ovl08_21703C4
	arm_func_end ovl08_21704A8

	arm_func_start ovl08_21705C0
ovl08_21705C0: // 0x021705C0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	str r0, [sp]
	bl OS_GetTick
	ldr r2, _02170700 // =0x0217E920
	ldr r3, _02170704 // =0x0017F898
	ldr r11, [r2]
	mov r8, #0
	add r2, r11, #0x1000
	ldr r4, [r2, #0xb78]
	ldr r2, [r2, #0xb7c]
	adds r3, r4, r3
	adc r2, r2, #0
	cmp r1, r2
	cmpeq r0, r3
	addlo sp, sp, #4
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r9, r8
	mov r10, r8
	mov r6, r11
	add r7, r11, #0x1300
	mov r4, #1
	mov r5, #6
_0217061C:
	ldr r1, _02170708 // =0x0217AEE4
	mov r0, r7
	mov r2, r5
	bl memcmp
	cmp r0, #0
	beq _02170648
	add r0, r6, #0x1000
	ldrb r0, [r0, #0x306]
	cmp r0, #0
	movne r9, r4
	moveq r8, r4
_02170648:
	add r10, r10, #1
	cmp r10, #0x10
	add r7, r7, #7
	add r6, r6, #7
	blt _0217061C
	cmp r9, #0
	beq _02170688
	cmp r8, #0
	beq _02170688
	add r0, r11, #0x1000
	ldr r1, [r0, #0x370]
	cmp r1, #0
	beq _021706CC
	mov r0, #2
	blx r1
	b _021706CC
_02170688:
	cmp r9, #0
	beq _021706AC
	add r0, r11, #0x1000
	ldr r1, [r0, #0x370]
	cmp r1, #0
	beq _021706CC
	mov r0, #1
	blx r1
	b _021706CC
_021706AC:
	cmp r8, #0
	bne _021706CC
	add r0, r11, #0x1000
	ldr r1, [r0, #0x370]
	cmp r1, #0
	beq _021706CC
	mov r0, #0
	blx r1
_021706CC:
	ldr r3, _02170700 // =0x0217E920
	mov r0, #0
	ldr r2, [r3]
	ldr r1, [sp]
	add r2, r2, #0x1000
	str r0, [r2, #0xb80]
	ldr r2, [r3]
	mov r3, #1
	add r2, r2, #0x1000
	strb r3, [r2, #0xb86]
	bl ovl08_2177870
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02170700: .word 0x0217E920
_02170704: .word 0x0017F898
_02170708: .word 0x0217AEE4
	arm_func_end ovl08_21705C0

	arm_func_start ovl08_217070C
ovl08_217070C: // 0x0217070C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r1, _0217083C // =0x0217E920
	mov r4, r0
	ldr r2, [r1]
	add r1, r2, #0x1000
	ldrb r0, [r1, #0xb85]
	cmp r0, #0
	beq _0217074C
	ldr r1, [r1, #0x370]
	cmp r1, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	blx r1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0217074C:
	add r0, r2, #0xf00
	mov r1, #0x400
	bl DC_InvalidateRange
	ldrh r11, [r4, #0xe]
	mov r10, #0
	cmp r11, #0
	addle sp, sp, #0xc
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, _0217083C // =0x0217E920
	ldr r7, [r0]
	str r10, [sp, #4]
	mov r5, #6
	mov r0, #8
	str r0, [sp]
_02170784:
	add r0, r4, r10, lsl #2
	ldr r6, [r0, #0x10]
	ldr r1, _02170840 // =aNwcusbap_1
	ldr r2, [sp]
	add r0, r6, #0xc
	bl memcmp
	cmp r0, #0
	bne _02170828
	ldrb r0, [r6, #0x15]
	ands r0, r0, #1
	beq _02170828
	ldr r9, [sp, #4]
	add r8, r7, #0x1300
	add r6, r6, #4
_021707BC:
	mov r0, r6
	mov r1, r8
	mov r2, r5
	bl memcmp
	cmp r0, #0
	bne _02170818
	mov r0, #7
	mla r0, r9, r0, r7
	add r0, r0, #0x1000
	ldrb r0, [r0, #0x306]
	cmp r0, #0
	bne _02170828
	add r0, r7, #0x1000
	ldr r1, [r0, #0x370]
	cmp r1, #0
	moveq r1, #1
	streqb r1, [r0, #0xb85]
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #1
	blx r1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02170818:
	add r9, r9, #1
	cmp r9, #0x10
	add r8, r8, #7
	blt _021707BC
_02170828:
	add r10, r10, #1
	cmp r10, r11
	blt _02170784
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0217083C: .word 0x0217E920
_02170840: .word aNwcusbap_1
	arm_func_end ovl08_217070C

	arm_func_start ovl08_2170844
ovl08_2170844: // 0x02170844
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	str r0, [sp]
	ldrh r0, [r0, #0xe]
	mov r11, #0
	cmp r0, #0
	addle sp, sp, #0x1c
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0xc0
	str r0, [sp, #4]
	mov r0, #8
	ldr r4, _021709D4 // =0x0217AEE4
	str r11, [sp, #0x18]
	str r11, [sp, #0xc]
	str r11, [sp, #0x10]
	mov r5, #6
	str r0, [sp, #8]
_02170890:
	ldr r0, [sp]
	ldr r1, [sp, #4]
	add r0, r0, r11, lsl #2
	ldr r10, [r0, #0x10]
	mov r0, r10
	bl DC_InvalidateRange
	ldr r1, _021709D8 // =aNwcusbap_1
	ldr r2, [sp, #8]
	add r0, r10, #0xc
	bl memcmp
	cmp r0, #0
	bne _021709B8
	ldr r0, _021709DC // =0x0217E920
	ldr r9, [sp, #0xc]
	ldr r7, [r0]
	add r6, r10, #4
	add r8, r7, #0x1300
_021708D4:
	mov r0, r6
	mov r1, r8
	mov r2, r5
	bl memcmp
	cmp r0, #0
	bne _02170934
	mov r0, #7
	mla r0, r9, r0, r7
	add r0, r0, #0x1000
	ldrb r0, [r0, #0x306]
	cmp r0, #0
	bne _021709B8
	ldrb r0, [r10, #0x15]
	ands r0, r0, #1
	beq _021709B8
	add r0, r7, #0x1000
	ldr r1, [r0, #0x370]
	cmp r1, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #1
	blx r1
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02170934:
	add r8, r8, #7
	add r9, r9, #1
	cmp r9, #0x10
	blt _021708D4
	ldr r6, [sp, #0x10]
	add r8, r7, #0x1300
_0217094C:
	mov r0, r8
	mov r1, r4
	mov r2, r5
	bl memcmp
	cmp r0, #0
	bne _021709A8
	mov r0, #7
	add r1, r7, #0x1300
	mul r7, r6, r0
	add r1, r1, r7
	add r0, r10, #4
	mov r2, r5
	bl MI_CpuCopy8
	ldrb r0, [r10, #0x15]
	ands r0, r0, #1
	ldr r0, _021709DC // =0x0217E920
	ldrne r1, [sp, #0x14]
	ldr r0, [r0]
	ldreq r1, [sp, #0x18]
	add r0, r0, r7
	add r0, r0, #0x1000
	strb r1, [r0, #0x306]
	b _021709B8
_021709A8:
	add r8, r8, #7
	add r6, r6, #1
	cmp r6, #0x10
	blt _0217094C
_021709B8:
	ldr r0, [sp]
	add r11, r11, #1
	ldrh r0, [r0, #0xe]
	cmp r11, r0
	blt _02170890
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021709D4: .word 0x0217AEE4
_021709D8: .word aNwcusbap_1
_021709DC: .word 0x0217E920
	arm_func_end ovl08_2170844

	arm_func_start ovl08_21709E0
ovl08_21709E0: // 0x021709E0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r1, [r0, #2]
	cmp r1, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r1, _02170A88 // =0x0217E920
	ldr r1, [r1]
	add r1, r1, #0x1000
	ldrb r2, [r1, #0xb84]
	cmp r2, #0
	beq _02170A28
	ldrh r0, [r0]
	add sp, sp, #4
	cmp r0, #2
	moveq r0, #2
	streqb r0, [r1, #0xb84]
	ldmia sp!, {pc}
_02170A28:
	ldrh r2, [r0]
	cmp r2, #0x26
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldrh r2, [r0, #8]
	cmp r2, #4
	beq _02170A70
	cmp r2, #5
	bne _02170A7C
	ldrb r1, [r1, #0xb86]
	cmp r1, #0
	beq _02170A60
	bl ovl08_217070C
	b _02170A64
_02170A60:
	bl ovl08_2170844
_02170A64:
	bl ovl08_2170B9C
	add sp, sp, #4
	ldmia sp!, {pc}
_02170A70:
	bl ovl08_2170B9C
	add sp, sp, #4
	ldmia sp!, {pc}
_02170A7C:
	bl OS_Terminate
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02170A88: .word 0x0217E920
	arm_func_end ovl08_21709E0

	arm_func_start ovl08_2170A8C
ovl08_2170A8C: // 0x02170A8C
	ldr r1, _02170AA0 // =0x0217E920
	ldr r1, [r1]
	add r1, r1, #0x1000
	str r0, [r1, #0x370]
	bx lr
	.align 2, 0
_02170AA0: .word 0x0217E920
	arm_func_end ovl08_2170A8C

	arm_func_start ovl08_2170AA4
ovl08_2170AA4: // 0x02170AA4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _02170B90 // =0x0217E920
	mov r3, #1
	ldr r0, [r2]
	ldr r1, _02170B94 // =0x000013B8
	add r0, r0, #0x1000
	strb r3, [r0, #0xb84]
	ldr r0, [r2]
	add r0, r0, r1
	bl WM_ReadStatus
	ldr r0, _02170B90 // =0x0217E920
	ldr r0, [r0]
	add r0, r0, #0x1300
	ldrh r0, [r0, #0xb8]
	cmp r0, #2
	beq _02170B2C
	ldr r0, _02170B98 // =ovl08_21709E0
	bl WM_Reset
	cmp r0, #2
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
_02170B00:
	ldr r1, _02170B90 // =0x0217E920
	ldr r0, _02170B94 // =0x000013B8
	ldr r1, [r1]
	add r0, r1, r0
	bl WM_ReadStatus
	ldr r0, _02170B90 // =0x0217E920
	ldr r0, [r0]
	add r0, r0, #0x1300
	ldrh r0, [r0, #0xb8]
	cmp r0, #2
	bne _02170B00
_02170B2C:
	ldr r0, _02170B98 // =ovl08_21709E0
	bl WM_End
	cmp r0, #2
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
	ldr r0, _02170B90 // =0x0217E920
	ldr r0, [r0]
	add r0, r0, #0x1000
	ldr r1, [r0, #0xb80]
	cmp r1, #0
	beq _02170B64
	mov r0, #0
	bl ovl08_2177864
_02170B64:
	ldr r0, _02170B90 // =0x0217E920
	ldr r0, [r0]
	add r0, r0, #0x1000
_02170B70:
	ldrb r1, [r0, #0xb84]
	cmp r1, #2
	bne _02170B70
	ldr r0, _02170B90 // =0x0217E920
	bl ovl08_2176714
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02170B90: .word 0x0217E920
_02170B94: .word 0x000013B8
_02170B98: .word ovl08_21709E0
	arm_func_end ovl08_2170AA4

	arm_func_start ovl08_2170B9C
ovl08_2170B9C: // 0x02170B9C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02170BD0 // =0x0217E920
	ldr r1, _02170BD4 // =0x00001374
	ldr r2, [r0]
	ldr r0, _02170BD8 // =ovl08_21709E0
	add r1, r2, r1
	bl sub_20F27B8
	cmp r0, #2
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02170BD0: .word 0x0217E920
_02170BD4: .word 0x00001374
_02170BD8: .word ovl08_21709E0
	arm_func_end ovl08_2170B9C

	arm_func_start ovl08_2170BDC
ovl08_2170BDC: // 0x02170BDC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x54
	mov r4, r0
	ldr r0, _02170D44 // =0x00001BA0
	mov r1, #0x20
	bl ovl08_2176764
	ldr r2, _02170D48 // =0x0217E920
	add r1, r0, #0x1000
	str r0, [r2]
	str r4, [r1, #0x370]
	ldr r4, [r2]
	bl OS_GetTick
	add r2, r4, #0x1000
	str r0, [r2, #0xb78]
	str r1, [r2, #0xb7c]
	ldr r1, _02170D4C // =ovl08_21709E0
	mov r0, r4
	mov r2, #3
	bl WM_Initialize
	cmp r0, #2
	bne _02170D30
	ldr r5, _02170D48 // =0x0217E920
	ldr r4, _02170D50 // =0x000013B8
_02170C38:
	ldr r0, [r5]
	add r0, r0, r4
	bl WM_ReadStatus
	ldr ip, [r5]
	add r0, ip, #0x1300
	ldrh r0, [r0, #0xb8]
	cmp r0, #2
	bne _02170C38
	ldr r0, _02170D54 // =0x00001374
	ldr lr, _02170D58 // =0x0217AEF8
	add r5, ip, r0
	mov r4, #4
_02170C68:
	ldmia lr!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	subs r4, r4, #1
	bne _02170C68
	ldr r0, [lr]
	add r1, ip, #0xf00
	str r0, [r5]
	add r0, ip, #0x1000
	str r1, [r0, #0x374]
	bl WM_GetDispersionScanPeriod
	ldr r1, _02170D48 // =0x0217E920
	ldr r1, [r1]
	add r1, r1, #0x1300
	strh r0, [r1, #0x7c]
	add r0, sp, #0
	bl OS_GetOwnerInfo
	ldr r0, _02170D48 // =0x0217E920
	ldr r1, _02170D5C // =0x00001388
	ldr r2, [r0]
	ldr r0, _02170D60 // =aNwcusbap_1
	add r1, r2, r1
	mov r2, #8
	bl MI_CpuCopy8
	ldr r2, _02170D48 // =0x0217E920
	mov r3, #1
	ldr r0, [r2]
	ldr r1, _02170D64 // =0x00001394
	add r0, r0, #0x1000
	strb r3, [r0, #0x391]
	ldr r2, [r2]
	ldrh r3, [sp, #0x18]
	add r1, r2, r1
	add r0, sp, #4
	mov r2, r3, lsl #1
	bl MI_CpuCopy8
	bl ovl08_2170B9C
	cmp r0, #0
	beq _02170D30
	mov r0, #0
	ldr r1, _02170D68 // =ovl08_21705C0
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _02170D48 // =0x0217E920
	add sp, sp, #0x54
	ldr r1, [r1]
	add r1, r1, #0x1000
	str r0, [r1, #0xb80]
	mov r0, #1
	ldmia sp!, {r4, r5, pc}
_02170D30:
	ldr r0, _02170D48 // =0x0217E920
	bl ovl08_2176714
	mov r0, #0
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02170D44: .word 0x00001BA0
_02170D48: .word 0x0217E920
_02170D4C: .word ovl08_21709E0
_02170D50: .word 0x000013B8
_02170D54: .word 0x00001374
_02170D58: .word 0x0217AEF8
_02170D5C: .word 0x00001388
_02170D60: .word aNwcusbap_1
_02170D64: .word 0x00001394
_02170D68: .word ovl08_21705C0
	arm_func_end ovl08_2170BDC

	arm_func_start ovl08_2170D6C
ovl08_2170D6C: // 0x02170D6C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r3, #0x4000000
	ldr r2, [r3]
	ldr r1, _02170E18 // =0x0217E924
	bic r2, r2, #0xe000
	str r2, [r3]
	ldr r1, [r1]
	mov r6, r0
	ldr r0, [r1]
	bl ovl08_2175204
	ldr r0, _02170E18 // =0x0217E924
	ldr r0, [r0]
	ldr r0, [r0, #4]
	bl ovl08_2175204
	ldr r7, _02170E18 // =0x0217E924
	ldr r4, _02170E1C // =0x0217AF48
	ldr r1, [r7]
	mov r5, #0
	ldrb r0, [r1, #0x1c]
	ldrb r0, [r4, r0]
	cmp r0, #0
	ble _02170DF4
_02170DC8:
	add r0, r1, r5, lsl #2
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _02170DDC
	bl ovl08_2175204
_02170DDC:
	ldr r1, [r7]
	add r5, r5, #1
	ldrb r0, [r1, #0x1c]
	ldrb r0, [r4, r0]
	cmp r5, r0
	blt _02170DC8
_02170DF4:
	ldr r0, [r1, #0x10]
	bl ovl08_2176088
	mov r1, r6
	mov r0, #1
	bl ovl08_2177870
	ldr r0, _02170E18 // =0x0217E924
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02170E18: .word 0x0217E924
_02170E1C: .word 0x0217AF48
	arm_func_end ovl08_2170D6C

	arm_func_start ovl08_2170E20
ovl08_2170E20: // 0x02170E20
	stmdb sp!, {r4, lr}
	ldr r1, _02170E70 // =0x0217E924
	mov r4, r0
	ldr r3, [r1]
	ldr r0, _02170E74 // =0x04000050
	ldrsb r2, [r3, #0x1a]
	add r2, r2, #1
	strb r2, [r3, #0x1a]
	ldr r1, [r1]
	ldrsb r1, [r1, #0x1a]
	bl G2x_ChangeBlendBrightness_
	ldr r0, _02170E70 // =0x0217E924
	ldr r0, [r0]
	ldrsb r0, [r0, #0x1a]
	cmp r0, #0
	ldmltia sp!, {r4, pc}
	ldr r1, _02170E78 // =ovl08_2170D6C
	mov r0, r4
	bl ovl08_2177890
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170E70: .word 0x0217E924
_02170E74: .word 0x04000050
_02170E78: .word ovl08_2170D6C
	arm_func_end ovl08_2170E20

	arm_func_start ovl08_2170E7C
ovl08_2170E7C: // 0x02170E7C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _02170F00 // =0x0217E924
	mov r4, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r0, [sp, #4]
	add r0, r0, #0xc
	str r0, [sp, #4]
	bl ovl08_21710A0
	ldr r0, [sp, #4]
	cmp r0, #0xc0
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	ldr r0, _02170F00 // =0x0217E924
	ldr r0, [r0]
	ldrb r0, [r0, #0x1e]
	cmp r0, #0
	beq _02170EEC
	ldr r1, _02170F04 // =ovl08_2170E20
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02170EEC:
	ldr r1, _02170F08 // =ovl08_2170D6C
	mov r0, r4
	bl ovl08_2177890
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170F00: .word 0x0217E924
_02170F04: .word ovl08_2170E20
_02170F08: .word ovl08_2170D6C
	arm_func_end ovl08_2170E7C

	arm_func_start ovl08_2170F0C
ovl08_2170F0C: // 0x02170F0C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _02170F4C // =0x0217E924
	ldr r3, [r1]
	ldrb r2, [r3, #0x1d]
	add r2, r2, #1
	strb r2, [r3, #0x1d]
	ldr r1, [r1]
	ldrb r1, [r1, #0x1d]
	cmp r1, #8
	addlo sp, sp, #4
	ldmloia sp!, {pc}
	ldr r1, _02170F50 // =ovl08_2170E7C
	bl ovl08_2177890
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02170F4C: .word 0x0217E924
_02170F50: .word ovl08_2170E7C
	arm_func_end ovl08_2170F0C

	arm_func_start ovl08_2170F54
ovl08_2170F54: // 0x02170F54
	stmdb sp!, {r4, lr}
	ldr r1, _02171000 // =0x0217E924
	mov r4, r0
	ldr r0, [r1]
	mov r1, #0
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #8]
	bl ovl08_21751F8
	ldr r1, _02171000 // =0x0217E924
	mov r2, r0
	ldr r0, [r1]
	ldr r1, _02171004 // =0x0217AF78
	ldrb r3, [r0, #0x1c]
	mov r0, #0
	add r1, r1, r3, lsl #1
	ldrb r1, [r4, r1]
	add r1, r1, #1
	bl ovl08_217559C
	ldr r0, _02171000 // =0x0217E924
	ldr r2, _02171008 // =0x0217AF60
	ldr r0, [r0]
	ldr r1, _0217100C // =0x0217AFE0
	ldrb lr, [r0, #0x1c]
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #8]
	add r2, r2, lr, lsl #1
	ldrb r3, [r4, r2]
	add r2, r1, lr, lsl #3
	mvn r1, #0
	mov ip, r3, lsl #2
	ldrh r2, [ip, r2]
	ldr r3, _02171010 // =0x0217AFE2
	add r3, r3, lr, lsl #3
	ldrh r3, [ip, r3]
	bl ovl08_2174FA4
	ldr r0, _02171000 // =0x0217E924
	mvn r1, #0
	ldr r0, [r0]
	mov r2, #0
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #8]
	bl ovl08_2174F30
	ldmia sp!, {r4, pc}
	.align 2, 0
_02171000: .word 0x0217E924
_02171004: .word 0x0217AF78
_02171008: .word 0x0217AF60
_0217100C: .word 0x0217AFE0
_02171010: .word 0x0217AFE2
	arm_func_end ovl08_2170F54

	arm_func_start ovl08_2171014
ovl08_2171014: // 0x02171014
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r0
	mov r9, r1
	bl ovl08_21751F0
	mov r8, r0
	cmp r8, #0
	mov r7, #0
	addle sp, sp, #0xc
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r11, sp, #0
	mov r6, r7
	mov r4, r7
	mov r5, #0x200
_0217104C:
	mov r0, r10
	mov r1, r7
	mov r2, r11
	add r3, sp, #4
	bl ovl08_2174EF8
	ldr r0, [sp, #4]
	cmp r0, r9
	blt _02171078
	cmp r0, #0xc0
	movlt r2, r6
	blt _0217107C
_02171078:
	mov r2, r5
_0217107C:
	mov r0, r10
	mov r1, r7
	mov r3, r4
	bl ovl08_2175138
	add r7, r7, #1
	cmp r7, r8
	blt _0217104C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end ovl08_2171014

	arm_func_start ovl08_21710A0
ovl08_21710A0: // 0x021710A0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r1, _02171234 // =0x0217E924
	mov r10, r0
	ldr r0, [r1]
	ldr r1, _02171238 // =0x0217AFB0
	ldrb r2, [r0, #0x1c]
	ldr r0, [r0]
	mov r3, r10
	mov r2, r2, lsl #2
	ldrh r2, [r1, r2]
	mvn r1, #0
	bl ovl08_2174FA4
	ldr r1, _02171234 // =0x0217E924
	ldr r0, _0217123C // =0x0217AF3C
	ldr r5, [r1]
	ldr r2, _02171238 // =0x0217AFB0
	ldrb r3, [r5, #0x1c]
	ldrh r1, [r0, #2]
	ldrh r4, [r0]
	mov r0, r3, lsl #2
	ldrh r2, [r2, r0]
	ldr r0, [r5, #4]
	add r3, r10, r1
	add r2, r4, r2
	mvn r1, #0
	bl ovl08_2174FA4
	ldr r0, _02171234 // =0x0217E924
	mov r1, r10
	ldr r0, [r0]
	ldr r0, [r0]
	bl ovl08_2171014
	ldr r0, _02171234 // =0x0217E924
	mov r1, r10
	ldr r0, [r0]
	ldr r0, [r0, #4]
	bl ovl08_2171014
	ldr r4, _02171234 // =0x0217E924
	ldr r8, _02171240 // =0x0217AF48
	ldr r0, [r4]
	mov r9, #0
	ldrb r0, [r0, #0x1c]
	ldrb r1, [r8, r0]
	cmp r1, #0
	ble _021711D0
	ldr r7, _02171244 // =0x0217AF60
	ldr r5, _02171248 // =0x0217AFE0
	ldr r11, _02171238 // =0x0217AFB0
	mvn r6, #0
_02171164:
	add r1, r7, r0, lsl #1
	ldrb ip, [r9, r1]
	add r2, r5, r0, lsl #3
	add r3, r11, r0, lsl #2
	add r0, r2, ip, lsl #2
	ldr r1, [r4]
	mov ip, ip, lsl #2
	ldrh r2, [ip, r2]
	ldrh r0, [r0, #2]
	add r1, r1, r9, lsl #2
	ldrh r3, [r3, #2]
	add ip, r10, r0
	ldr r0, [r1, #8]
	mov r1, r6
	sub r3, ip, r3
	bl ovl08_2174FA4
	ldr r0, [r4]
	mov r1, r10
	add r0, r0, r9, lsl #2
	ldr r0, [r0, #8]
	bl ovl08_2171014
	ldr r0, [r4]
	add r9, r9, #1
	ldrb r0, [r0, #0x1c]
	ldrb r1, [r8, r0]
	cmp r9, r1
	blt _02171164
_021711D0:
	and r1, r10, #0xff
	cmp r1, #0xc0
	movge r3, #0
	movge r1, r3
	ldrlt r2, _0217124C // =0x0217AFCA
	movlt r3, r0, lsl #2
	ldrlth r2, [r2, r3]
	mov r5, r0, lsl #2
	add r4, sp, #4
	addlt r3, r1, r2
	ldr r2, _02171238 // =0x0217AFB0
	cmp r3, #0xc0
	ldrh r0, [r2, r5]
	ldr r2, _02171250 // =0x0217AFC8
	movgt r3, #0xc0
	str r4, [sp]
	ldrh r2, [r2, r5]
	add r2, r0, r2
	bl ovl08_217632C
	mov r0, #0
	mov r2, r4
	mov r1, r0
	bl ovl08_21764BC
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02171234: .word 0x0217E924
_02171238: .word 0x0217AFB0
_0217123C: .word 0x0217AF3C
_02171240: .word 0x0217AF48
_02171244: .word 0x0217AF60
_02171248: .word 0x0217AFE0
_0217124C: .word 0x0217AFCA
_02171250: .word 0x0217AFC8
	arm_func_end ovl08_21710A0

	arm_func_start ovl08_2171254
ovl08_2171254: // 0x02171254
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _021712C4 // =0x0217E924
	mvn ip, #0
	ldr r3, [r2]
	mov r1, r0
	strb ip, [r3, #0x1b]
	ldr r3, [r2]
	ldrh r0, [r3, #0x18]
	add r0, r0, #1
	strh r0, [r3, #0x18]
	ldr r0, [r2]
	ldrh r0, [r0, #0x18]
	cmp r0, #0x78
	addlo sp, sp, #4
	ldmloia sp!, {pc}
	mov r0, #0
	bl ovl08_2177870
	ldr r1, _021712C8 // =ovl08_2170F0C
	mov r0, #1
	mov r2, #0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _021712C4 // =0x0217E924
	ldr r1, [r1]
	str r0, [r1, #0x14]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021712C4: .word 0x0217E924
_021712C8: .word ovl08_2170F0C
	arm_func_end ovl08_2171254

	arm_func_start ovl08_21712CC
ovl08_21712CC: // 0x021712CC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	ldr r5, _02171408 // =0x0217E924
	ldr r10, _0217140C // =0x0217AF48
	ldr r0, [r5]
	mov r4, #0
	ldrb r1, [r0, #0x1c]
	ldrb r0, [r10, r1]
	cmp r0, #0
	ble _02171354
	ldr r9, _02171410 // =0x0217AFE0
	ldr r8, _02171414 // =0x0217AF60
	ldr r7, _02171418 // =0x0217AF84
	add r6, sp, #0
_02171304:
	add r0, r8, r1, lsl #1
	ldrb r0, [r4, r0]
	add r3, r9, r1, lsl #3
	mov r2, r6
	add r0, r3, r0, lsl #2
	add r1, r7, r1, lsl #2
	bl ovl08_21762F8
	mov r0, r6
	bl ovl08_2176A38
	cmp r0, #0
	ldrne r0, _02171408 // =0x0217E924
	ldrne r0, [r0]
	strneb r4, [r0, #0x1b]
	bne _02171354
	ldr r0, [r5]
	add r4, r4, #1
	ldrb r1, [r0, #0x1c]
	ldrb r0, [r10, r1]
	cmp r4, r0
	blt _02171304
_02171354:
	mov r0, #1
	bl ovl08_2176B58
	cmp r0, #0
	beq _02171380
	ldr r0, _02171408 // =0x0217E924
	ldr r1, _0217141C // =0x0217AF6C
	ldr r2, [r0]
	ldrb r0, [r2, #0x1c]
	mov r0, r0, lsl #1
	ldrsb r0, [r1, r0]
	strb r0, [r2, #0x1b]
_02171380:
	mov r0, #2
	bl ovl08_2176B58
	cmp r0, #0
	beq _021713AC
	ldr r0, _02171408 // =0x0217E924
	ldr r1, _02171420 // =0x0217AF6D
	ldr r2, [r0]
	ldrb r0, [r2, #0x1c]
	mov r0, r0, lsl #1
	ldrsb r0, [r1, r0]
	strb r0, [r2, #0x1b]
_021713AC:
	ldr r0, _02171408 // =0x0217E924
	ldr r2, _0217140C // =0x0217AF48
	ldr r4, [r0]
	mov r0, #0
	ldrb r1, [r4, #0x1c]
	ldrb r1, [r2, r1]
	cmp r1, #0
	ble _021713F8
	ldrsb r3, [r4, #0x1b]
_021713D0:
	cmp r0, r3
	bne _021713E4
	bl ovl08_2170F54
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_021713E4:
	ldrb r1, [r4, #0x1c]
	add r0, r0, #1
	ldrb r1, [r2, r1]
	cmp r0, r1
	blt _021713D0
_021713F8:
	mvn r0, #0
	strb r0, [r4, #0x1b]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02171408: .word 0x0217E924
_0217140C: .word 0x0217AF48
_02171410: .word 0x0217AFE0
_02171414: .word 0x0217AF60
_02171418: .word 0x0217AF84
_0217141C: .word 0x0217AF6C
_02171420: .word 0x0217AF6D
	arm_func_end ovl08_21712CC

	arm_func_start ovl08_2171424
ovl08_2171424: // 0x02171424
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _021714F8 // =0x0217E924
	mov r4, r0
	ldr r0, [r1]
	add r2, sp, #0
	ldr r0, [r0]
	add r3, sp, #4
	mov r1, #0
	bl ovl08_2174EF8
	ldr r0, [sp, #4]
	ldr r1, _021714F8 // =0x0217E924
	sub r0, r0, #0xc
	ldr r1, [r1]
	str r0, [sp, #4]
	ldrb r2, [r1, #0x1c]
	ldr r1, _021714FC // =0x0217AFB2
	mov r2, r2, lsl #2
	ldrh r1, [r1, r2]
	cmp r0, r1
	ble _02171484
	bl ovl08_21710A0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02171484:
	mov r0, r1
	bl ovl08_21710A0
	ldr r0, _021714F8 // =0x0217E924
	ldr r0, [r0]
	ldrb r0, [r0, #0x1c]
	cmp r0, #5
	bne _021714C4
	mov r0, #0
	ldr r1, _02171500 // =ovl08_2171254
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _021714F8 // =0x0217E924
	ldr r1, [r1]
	str r0, [r1, #0x14]
	b _021714E4
_021714C4:
	mov r0, #0
	ldr r1, _02171504 // =ovl08_21712CC
	mov r2, r0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _021714F8 // =0x0217E924
	ldr r1, [r1]
	str r0, [r1, #0x14]
_021714E4:
	mov r1, r4
	mov r0, #1
	bl ovl08_2177870
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021714F8: .word 0x0217E924
_021714FC: .word 0x0217AFB2
_02171500: .word ovl08_2171254
_02171504: .word ovl08_21712CC
	arm_func_end ovl08_2171424

	arm_func_start ovl08_2171508
ovl08_2171508: // 0x02171508
	stmdb sp!, {r4, lr}
	ldr r1, _0217155C // =0x0217E924
	mov r4, r0
	ldr r3, [r1]
	ldr r0, _02171560 // =0x04000050
	ldrsb r2, [r3, #0x1a]
	sub r2, r2, #1
	strb r2, [r3, #0x1a]
	ldr r1, [r1]
	ldrsb r1, [r1, #0x1a]
	bl G2x_ChangeBlendBrightness_
	ldr r1, _0217155C // =0x0217E924
	mvn r0, #0xb
	ldr r1, [r1]
	ldrsb r1, [r1, #0x1a]
	cmp r1, r0
	ldmgtia sp!, {r4, pc}
	ldr r1, _02171564 // =ovl08_2171424
	mov r0, r4
	bl ovl08_2177890
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217155C: .word 0x0217E924
_02171560: .word 0x04000050
_02171564: .word ovl08_2171424
	arm_func_end ovl08_2171508

	arm_func_start ovl08_2171568
ovl08_2171568: // 0x02171568
	ldr r0, _02171580 // =0x0217E924
	ldr r0, [r0]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02171580: .word 0x0217E924
	arm_func_end ovl08_2171568

	arm_func_start ovl08_2171584
ovl08_2171584: // 0x02171584
	ldr r0, _02171594 // =0x0217E924
	ldr r0, [r0]
	ldrsb r0, [r0, #0x1b]
	bx lr
	.align 2, 0
_02171594: .word 0x0217E924
	arm_func_end ovl08_2171584

	arm_func_start ovl08_2171598
ovl08_2171598: // 0x02171598
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _021715DC // =0x0217E924
	mov r0, #0
	ldr r1, [r1]
	ldr r1, [r1, #0x14]
	bl ovl08_2177870
	ldr r1, _021715E0 // =ovl08_2170F0C
	mov r0, #1
	mov r2, #0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _021715DC // =0x0217E924
	ldr r1, [r1]
	str r0, [r1, #0x14]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021715DC: .word 0x0217E924
_021715E0: .word ovl08_2170F0C
	arm_func_end ovl08_2171598

	arm_func_start ovl08_21715E4
ovl08_21715E4: // 0x021715E4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	ldr r5, _0217190C // =0x0217AF50
	ldr r4, _02171910 // =0x0217E83C
	ldrb r10, [r5]
	ldrb r9, [r5, #1]
	ldrb r8, [r5, #2]
	ldrb r7, [r5, #3]
	ldrb r6, [r5, #4]
	ldrb r5, [r5, #5]
	mov r11, r0
	str r2, [sp, #0x14]
	mov r2, r3
	str r1, [sp, #0x10]
	ldr r0, [r4]
	ldr r3, [sp, #0x50]
	mov r1, r11
	strb r10, [sp, #0x20]
	strb r9, [sp, #0x21]
	strb r8, [sp, #0x22]
	strb r7, [sp, #0x23]
	strb r6, [sp, #0x24]
	strb r5, [sp, #0x25]
	bl ovl08_215EC18
	str r0, [sp, #0x18]
	mov r0, #0x20
	mov r1, #4
	bl ovl08_2176764
	ldr r2, _02171914 // =0x0217E924
	ldr r1, [sp, #0x10]
	str r0, [r2]
	strb r1, [r0, #0x1c]
	ldr r1, [r2]
	mvn r3, #1
	strb r3, [r1, #0x1b]
	ldr r3, [r2]
	ldr r2, [sp, #0x14]
	ldr r0, _02171918 // =0x04000050
	strb r2, [r3, #0x1e]
	mov r1, #0x1f
	mov r2, #0
	bl G2x_SetBlendBrightness_
	mov r0, #0
	ldr r3, _0217191C // =0x0217AF40
	ldr r1, [sp, #0x10]
	mov r2, r0
	ldrb r1, [r3, r1]
	bl ovl08_2175528
	ldr r3, _02171914 // =0x0217E924
	mvn r1, #0
	ldr r4, [r3]
	mov r2, #0x100
	str r0, [r4]
	ldr r0, [r3]
	mov r3, #0
	ldr r0, [r0]
	bl ovl08_2174FA4
	ldr r0, _02171914 // =0x0217E924
	mvn r1, #0
	ldr r0, [r0]
	mov r2, #0
	ldr r0, [r0]
	bl ovl08_2174F30
	ldr r2, _02171920 // =0x0217AF48
	ldr r0, [sp, #0x10]
	mov r10, #0
	ldrb r0, [r2, r0]
	cmp r0, #0
	ble _02171784
	ldr r0, [sp, #0x10]
	ldr r1, _02171924 // =0x0217AF78
	ldr r4, _02171914 // =0x0217E924
	add r8, r2, r0
	add r9, r1, r0, lsl #1
	str r10, [sp, #0x1c]
	mov r5, r10
	mov r11, r10
	mvn r7, #0
	mov r6, #0x100
_02171720:
	ldr r0, [sp, #0x1c]
	ldrb r1, [r9]
	mov r2, r0
	bl ovl08_2175528
	ldr r2, [r4]
	mov r1, r7
	add r2, r2, r10, lsl #2
	str r0, [r2, #8]
	ldr r0, [r4]
	mov r2, r6
	add r0, r0, r10, lsl #2
	ldr r0, [r0, #8]
	mov r3, r5
	bl ovl08_2174FA4
	ldr r0, [r4]
	mov r1, r7
	add r0, r0, r10, lsl #2
	ldr r0, [r0, #8]
	mov r2, r11
	bl ovl08_2174F30
	ldrb r0, [r8]
	add r10, r10, #1
	add r9, r9, #1
	cmp r10, r0
	blt _02171720
_02171784:
	add r1, sp, #0x28
	str r1, [sp]
	mov r0, #0
	mov r1, #0x20
	mov r2, #0xc
	mov r3, #1
	str r0, [sp, #4]
	bl ovl08_21760B4
	ldr r1, _02171914 // =0x0217E924
	ldr r1, [r1]
	str r0, [r1, #0x10]
	mov r0, #0
	ldr r1, [sp, #0x28]
	mov r2, r0
	bl ovl08_2175290
	ldr r1, _02171914 // =0x0217E924
	ldr r1, [r1]
	str r0, [r1, #4]
	bl ovl08_215A60C
	ldr r1, [sp, #0x10]
	mov r3, #2
	mov r5, r1, lsl #2
	ldr r1, _02171928 // =0x0217AF9A
	ldr r2, _02171914 // =0x0217E924
	ldrh r4, [r1, r5]
	mov r1, #0
	str r4, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x18]
	ldr r3, _0217192C // =0x0217AF98
	str r0, [sp, #0xc]
	ldr r0, [r2]
	ldrh r3, [r3, r5]
	ldr r0, [r0, #0x10]
	mov r2, r1
	bl ovl08_2175C00
	ldr r0, _02171914 // =0x0217E924
	mov r2, #0
	ldr r3, [r0]
	mov r1, #0x100
	str r2, [sp]
	ldr r0, [r3, #0x10]
	ldr r3, [r3, #4]
	bl ovl08_2175B50
	mov r0, #0
	mov r1, r0
	mov r2, #0x1f
	mov r3, r0
	bl ovl08_2176350
	ldr r3, _02171914 // =0x0217E924
	add r4, sp, #0x20
	ldr r3, [r3]
	mov r0, #0
	ldrb r3, [r3, #0x1c]
	mov r1, #1
	mov r2, #0x1f
	ldrb r3, [r4, r3]
	bl ovl08_2176350
	mov r0, #0
	mov r1, #3
	mov r2, #0x1f
	mov r3, #1
	bl ovl08_2176350
	ldr r2, _02171930 // =0x0217AF58
	mov r0, #0
	mov r1, #1
	bl ovl08_21764BC
	mov r0, #0xc0
	bl ovl08_21710A0
	mov r2, #0x4000000
	ldr r0, [sp, #0x14]
	ldr r1, [r2]
	cmp r0, #0
	bic r0, r1, #0xe000
	orr r0, r0, #0x6000
	str r0, [r2]
	beq _021718E4
	ldr r1, _02171934 // =ovl08_2171508
	mov r0, #1
	mov r2, #0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _02171914 // =0x0217E924
	add sp, sp, #0x2c
	ldr r1, [r1]
	str r0, [r1, #0x14]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_021718E4:
	ldr r1, _02171938 // =ovl08_2171424
	mov r0, #1
	mov r2, #0
	mov r3, #0x78
	bl ovl08_2177924
	ldr r1, _02171914 // =0x0217E924
	ldr r1, [r1]
	str r0, [r1, #0x14]
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0217190C: .word 0x0217AF50
_02171910: .word 0x0217E83C
_02171914: .word 0x0217E924
_02171918: .word 0x04000050
_0217191C: .word 0x0217AF40
_02171920: .word 0x0217AF48
_02171924: .word 0x0217AF78
_02171928: .word 0x0217AF9A
_0217192C: .word 0x0217AF98
_02171930: .word 0x0217AF58
_02171934: .word ovl08_2171508
_02171938: .word ovl08_2171424
	arm_func_end ovl08_21715E4

	arm_func_start ovl08_217193C
ovl08_217193C: // 0x0217193C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r1, _021719F8 // =0x0217E928
	mov r5, #1
	ldr lr, [r1]
	ldrh r4, [lr, #2]
	mov ip, r5
	add r1, lr, #0x24
	mov r6, #0x1e
_0217195C:
	mov r2, ip, lsl r5
	ands r2, r4, r2
	beq _021719DC
	sub r2, r5, #1
	mul r3, r2, r6
	ldrb r8, [r0]
	ldrb r7, [r1, r3]
	add r2, r1, r3
	cmp r8, r7
	bne _021719DC
	ldrb r8, [r0, #1]
	ldrb r7, [r2, #1]
	cmp r8, r7
	bne _021719DC
	ldrb r8, [r0, #2]
	ldrb r7, [r2, #2]
	cmp r8, r7
	bne _021719DC
	ldrb r8, [r0, #3]
	ldrb r7, [r2, #3]
	cmp r8, r7
	bne _021719DC
	ldrb r8, [r0, #4]
	ldrb r7, [r2, #4]
	cmp r8, r7
	bne _021719DC
	ldrb r7, [r0, #5]
	ldrb r2, [r2, #5]
	cmp r7, r2
	addeq r0, lr, r3
	ldreqh r0, [r0, #0x2a]
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
_021719DC:
	add r2, r5, #1
	mov r2, r2, lsl #0x10
	mov r5, r2, lsr #0x10
	cmp r5, #2
	blo _0217195C
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021719F8: .word 0x0217E928
	arm_func_end ovl08_217193C

	arm_func_start ovl08_21719FC
ovl08_21719FC: // 0x021719FC
	ldr r1, _02171A2C // =0x0217E928
	mov r2, #1
	ldr r3, [r1]
	mov r1, r2, lsl r0
	ldrh r2, [r3, #2]
	ands r1, r2, r1
	subne r1, r0, #1
	addne r2, r3, #0xe
	movne r0, #0x1e
	mlane r0, r1, r0, r2
	moveq r0, #0
	bx lr
	.align 2, 0
_02171A2C: .word 0x0217E928
	arm_func_end ovl08_21719FC

	arm_func_start ovl08_2171A30
ovl08_2171A30: // 0x02171A30
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, _02171AF8 // =0x0217E928
	mov r2, #1
	ldr r3, [r1]
	mov r1, r2, lsl r4
	mov r1, r1, lsl #0x10
	ldrh r2, [r3, #2]
	mov r4, r1, lsr #0x10
	mov r5, r0
	ands r1, r2, r4
	bne _02171A78
	bl OS_RestoreInterrupts
	add sp, sp, #0x14
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_02171A78:
	add r1, sp, #0
	mov r0, r3
	mov r2, #0xe
	bl MI_CpuCopy8
	mov r0, r5
	bl OS_RestoreInterrupts
	ldrh r0, [sp, #4]
	ands r0, r0, r4
	addne sp, sp, #0x14
	movne r0, #2
	ldmneia sp!, {r4, r5, pc}
	ldrh r0, [sp, #6]
	ands r0, r0, r4
	addne sp, sp, #0x14
	movne r0, #3
	ldmneia sp!, {r4, r5, pc}
	ldrh r0, [sp, #8]
	ands r0, r0, r4
	addne sp, sp, #0x14
	movne r0, #4
	ldmneia sp!, {r4, r5, pc}
	ldrh r0, [sp, #0xa]
	ands r0, r0, r4
	addne sp, sp, #0x14
	movne r0, #5
	ldmneia sp!, {r4, r5, pc}
	ldrh r0, [sp, #0xc]
	ands r0, r0, r4
	movne r0, #6
	moveq r0, #1
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02171AF8: .word 0x0217E928
	arm_func_end ovl08_2171A30

	arm_func_start ovl08_2171AFC
ovl08_2171AFC: // 0x02171AFC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r2, _02171B50 // =0x0217E928
	ldr r1, _02171B54 // =0x0217E92C
	ldr r2, [r2]
	add r5, r2, #2
	add r4, r2, #4
	add lr, r2, #6
	add ip, r2, #8
	add r3, r2, #0xa
	add r2, r2, #0xc
	str r5, [r1]
	str r4, [r1, #4]
	str lr, [r1, #8]
	str ip, [r1, #0xc]
	str r3, [r1, #0x10]
	str r2, [r1, #0x14]
	ldr r0, [r1, r0, lsl #2]
	ldrh r0, [r0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02171B50: .word 0x0217E928
_02171B54: .word 0x0217E92C
	arm_func_end ovl08_2171AFC

	arm_func_start ovl08_2171B58
ovl08_2171B58: // 0x02171B58
	ldr r0, _02171B68 // =0x0217E928
	ldr r0, [r0]
	ldrh r0, [r0]
	bx lr
	.align 2, 0
_02171B68: .word 0x0217E928
	arm_func_end ovl08_2171B58

	arm_func_start ovl08_2171B6C
ovl08_2171B6C: // 0x02171B6C
	ldr r1, _02171B7C // =0x0217E928
	ldr r1, [r1]
	strh r0, [r1]
	bx lr
	.align 2, 0
_02171B7C: .word 0x0217E928
	arm_func_end ovl08_2171B6C

	arm_func_start ovl08_2171B80
ovl08_2171B80: // 0x02171B80
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r2
	cmp r1, #0xe
	addls pc, pc, r1, lsl #2
	b _02171EA4
_02171B98: // jump table
	b _02171EA4 // case 0
	ldmia sp!, {r4, r5, r6, pc} // case 1
	b _02171BD4 // case 2
	b _02171C5C // case 3
	ldmia sp!, {r4, r5, r6, pc} // case 4
	ldmia sp!, {r4, r5, r6, pc} // case 5
	ldmia sp!, {r4, r5, r6, pc} // case 6
	b _02171D98 // case 7
	ldmia sp!, {r4, r5, r6, pc} // case 8
	b _02171DC8 // case 9
	b _02171CE8 // case 10
	ldmia sp!, {r4, r5, r6, pc} // case 11
	b _02171DFC // case 12
	b _02171E58 // case 13
	b _02171D54 // case 14
_02171BD4:
	bl ovl08_2171B58
	cmp r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, _02171EAC // =0x0217E928
	ldr r6, [r0]
	bl OS_DisableInterrupts
	ldrh r2, [r6, #2]
	mov r1, #1
	orr r1, r2, r1, lsl r5
	strh r1, [r6, #2]
	bl OS_RestoreInterrupts
	ldr r1, _02171EAC // =0x0217E928
	sub r3, r5, #1
	mov r0, #0x1e
	mul r0, r3, r0
	ldr r2, [r1]
	add r3, r2, #0x24
	ldrb r2, [r4, #0xa]
	add ip, r3, r0
	strb r2, [r3, r0]
	ldrb r2, [r4, #0xb]
	strb r2, [ip, #1]
	ldrb r2, [r4, #0xc]
	strb r2, [ip, #2]
	ldrb r2, [r4, #0xd]
	strb r2, [ip, #3]
	ldrb r2, [r4, #0xe]
	strb r2, [ip, #4]
	ldrb r2, [r4, #0xf]
	strb r2, [ip, #5]
	ldr r1, [r1]
	add r0, r1, r0
	strh r5, [r0, #0x2a]
	ldmia sp!, {r4, r5, r6, pc}
_02171C5C:
	bl ovl08_2171A30
	cmp r0, #6
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, #1
	mvn r0, r0, lsl r5
	mov r4, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r1, _02171EAC // =0x0217E928
	ldr r3, [r1]
	ldrh r2, [r3, #2]
	and r2, r2, r4, lsr #16
	strh r2, [r3, #2]
	ldr r3, [r1]
	ldrh r2, [r3, #4]
	and r2, r2, r4, lsr #16
	strh r2, [r3, #4]
	ldr r3, [r1]
	ldrh r2, [r3, #6]
	and r2, r2, r4, lsr #16
	strh r2, [r3, #6]
	ldr r3, [r1]
	ldrh r2, [r3, #8]
	and r2, r2, r4, lsr #16
	strh r2, [r3, #8]
	ldr r3, [r1]
	ldrh r2, [r3, #0xa]
	and r2, r2, r4, lsr #16
	strh r2, [r3, #0xa]
	ldr r2, [r1]
	ldrh r1, [r2, #0xc]
	and r1, r1, r4, lsr #16
	strh r1, [r2, #0xc]
	bl OS_RestoreInterrupts
	bl ovl08_2171EB0
	ldmia sp!, {r4, r5, r6, pc}
_02171CE8:
	bl ovl08_2171B58
	cmp r0, #2
	beq _02171D00
	mov r0, r5
	bl ovl08_2172254
	ldmia sp!, {r4, r5, r6, pc}
_02171D00:
	ldr r0, _02171EAC // =0x0217E928
	mov r1, #1
	ldr r3, [r0]
	mov r0, r5
	ldrh r2, [r3, #4]
	orr r1, r2, r1, lsl r5
	strh r1, [r3, #4]
	bl ovl08_2172338
	mov r0, r5
	bl MB_CommGetChildUser
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, _02171EAC // =0x0217E928
	sub r2, r5, #1
	ldr r3, [r1]
	mov r1, #0x1e
	add r3, r3, #0xe
	mla r1, r2, r1, r3
	mov r2, #0x16
	bl MI_CpuCopy8
	ldmia sp!, {r4, r5, r6, pc}
_02171D54:
	ldr r0, _02171EAC // =0x0217E928
	mov r4, #1
	ldr r3, [r0]
	mvn r1, r4, lsl r5
	ldrh r2, [r3, #4]
	and r1, r2, r1
	strh r1, [r3, #4]
	ldr r1, [r0]
	ldrh r0, [r1, #6]
	orr r0, r0, r4, lsl r5
	strh r0, [r1, #6]
	bl ovl08_2171B58
	cmp r0, #3
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r5
	bl ovl08_2172170
	ldmia sp!, {r4, r5, r6, pc}
_02171D98:
	ldr r0, _02171EAC // =0x0217E928
	mov r4, #1
	ldr r3, [r0]
	mvn r1, r4, lsl r5
	ldrh r2, [r3, #8]
	and r1, r2, r1
	strh r1, [r3, #8]
	ldr r1, [r0]
	ldrh r0, [r1, #0xa]
	orr r0, r0, r4, lsl r5
	strh r0, [r1, #0xa]
	ldmia sp!, {r4, r5, r6, pc}
_02171DC8:
	ldr r0, _02171EAC // =0x0217E928
	mov r4, #1
	ldr r3, [r0]
	mvn r1, r4, lsl r5
	ldrh r2, [r3, #0xa]
	and r1, r2, r1
	strh r1, [r3, #0xa]
	ldr r1, [r0]
	ldrh r0, [r1, #0xc]
	orr r0, r0, r4, lsl r5
	strh r0, [r1, #0xc]
	bl ovl08_2171EB0
	ldmia sp!, {r4, r5, r6, pc}
_02171DFC:
	bl ovl08_2171B58
	cmp r0, #4
	bne _02171E14
	mov r0, #5
	bl ovl08_2171B6C
	b _02171E1C
_02171E14:
	mov r0, #0
	bl ovl08_2171B6C
_02171E1C:
	ldr r0, _02171EAC // =0x0217E928
	ldr r0, [r0]
	add r0, r0, #0x1b000
	ldr r1, [r0, #0x144]
	cmp r1, #0
	movne r1, #0
	strne r1, [r0, #0x144]
	ldr r0, _02171EAC // =0x0217E928
	ldr r0, [r0]
	add r0, r0, #0x1b000
	ldr r1, [r0, #0x140]
	cmp r1, #0
	movne r1, #0
	strne r1, [r0, #0x140]
	ldmia sp!, {r4, r5, r6, pc}
_02171E58:
	ldrh r0, [r4]
	cmp r0, #8
	bgt _02171E90
	cmp r0, #8
	ldmgeia sp!, {r4, r5, r6, pc}
	cmp r0, #2
	ldmgtia sp!, {r4, r5, r6, pc}
	cmp r0, #1
	ldmltia sp!, {r4, r5, r6, pc}
	cmp r0, #1
	beq _02171E98
	cmp r0, #2
	beq _02171E98
	ldmia sp!, {r4, r5, r6, pc}
_02171E90:
	cmp r0, #9
	ldmneia sp!, {r4, r5, r6, pc}
_02171E98:
	mov r0, #7
	bl ovl08_2171B6C
	ldmia sp!, {r4, r5, r6, pc}
_02171EA4:
	bl OS_Terminate
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02171EAC: .word 0x0217E928
	arm_func_end ovl08_2171B80

	arm_func_start ovl08_2171EB0
ovl08_2171EB0: // 0x02171EB0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02171EF0 // =0x0217E928
	ldr r2, [r0]
	ldrh r0, [r2]
	cmp r0, #4
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldrh r1, [r2, #2]
	ldrh r0, [r2, #0xc]
	cmp r1, r0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl MB_EndToIdle
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02171EF0: .word 0x0217E928
	arm_func_end ovl08_2171EB0

	arm_func_start ovl08_2171EF4
ovl08_2171EF4: // 0x02171EF4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #6
	bl ovl08_2171B6C
	bl MB_EndToIdle
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2171EF4

	arm_func_start ovl08_2171F10
ovl08_2171F10: // 0x02171F10
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, #0
	mov r9, #1
	ldr r4, _02172014 // =0x0217E928
	mov r6, r9
	mov r5, #3
_02171F2C:
	ldr r0, [r4]
	mov r7, r6, lsl r9
	ldrh r0, [r0, #0xa]
	ands r0, r0, r7
	beq _02171FD8
	mov r0, r9
	mov r1, r5
	bl MB_CommResponseRequest
	cmp r0, #0
	orrne r0, r8, r7
	movne r0, r0, lsl #0x10
	movne r8, r0, lsr #0x10
	bne _02171FD8
	mvn r0, r7
	mov r7, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r2, [r4]
	ldrh r1, [r2, #2]
	and r1, r1, r7, lsr #16
	strh r1, [r2, #2]
	ldr r2, [r4]
	ldrh r1, [r2, #4]
	and r1, r1, r7, lsr #16
	strh r1, [r2, #4]
	ldr r2, [r4]
	ldrh r1, [r2, #6]
	and r1, r1, r7, lsr #16
	strh r1, [r2, #6]
	ldr r2, [r4]
	ldrh r1, [r2, #8]
	and r1, r1, r7, lsr #16
	strh r1, [r2, #8]
	ldr r2, [r4]
	ldrh r1, [r2, #0xa]
	and r1, r1, r7, lsr #16
	strh r1, [r2, #0xa]
	ldr r2, [r4]
	ldrh r1, [r2, #0xc]
	and r1, r1, r7, lsr #16
	strh r1, [r2, #0xc]
	bl OS_RestoreInterrupts
	mov r0, r9
	bl MB_DisconnectChild
_02171FD8:
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #0x10
	blo _02171F2C
	cmp r8, #0
	bne _02172004
	mov r0, #7
	bl ovl08_2171B6C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_02172004:
	mov r0, #4
	bl ovl08_2171B6C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02172014: .word 0x0217E928
	arm_func_end ovl08_2171F10

	arm_func_start ovl08_2172018
ovl08_2172018: // 0x02172018
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, _02172080 // =0x0217E928
	ldr r0, [r4]
	ldrh r0, [r0, #2]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r6, #1
	mov r5, r6
_0217203C:
	ldr r1, [r4]
	mov r0, r5, lsl r6
	ldrh r1, [r1, #2]
	ands r0, r1, r0
	beq _02172064
	mov r0, r6
	bl MB_CommIsBootable
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
_02172064:
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0x10
	blo _0217203C
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02172080: .word 0x0217E928
	arm_func_end ovl08_2172018

	arm_func_start ovl08_2172084
ovl08_2172084: // 0x02172084
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r0, #3
	bl ovl08_2171B6C
	mov r5, #1
	ldr r7, _0217216C // =0x0217E928
	mov r4, r5
_021720A0:
	ldr r1, [r7]
	mov r2, r4, lsl r5
	ldrh r0, [r1, #2]
	ands r0, r0, r2
	beq _02172150
	ldrh r0, [r1, #4]
	ands r0, r0, r2
	bne _02172150
	ldrh r0, [r1, #6]
	ands r0, r0, r2
	bne _02172148
	mvn r0, r2
	mov r6, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r2, [r7]
	ldrh r1, [r2, #2]
	and r1, r1, r6, lsr #16
	strh r1, [r2, #2]
	ldr r2, [r7]
	ldrh r1, [r2, #4]
	and r1, r1, r6, lsr #16
	strh r1, [r2, #4]
	ldr r2, [r7]
	ldrh r1, [r2, #6]
	and r1, r1, r6, lsr #16
	strh r1, [r2, #6]
	ldr r2, [r7]
	ldrh r1, [r2, #8]
	and r1, r1, r6, lsr #16
	strh r1, [r2, #8]
	ldr r2, [r7]
	ldrh r1, [r2, #0xa]
	and r1, r1, r6, lsr #16
	strh r1, [r2, #0xa]
	ldr r2, [r7]
	ldrh r1, [r2, #0xc]
	and r1, r1, r6, lsr #16
	strh r1, [r2, #0xc]
	bl OS_RestoreInterrupts
	mov r0, r5
	bl MB_DisconnectChild
	b _02172150
_02172148:
	mov r0, r5
	bl ovl08_2172170
_02172150:
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #0x10
	blo _021720A0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0217216C: .word 0x0217E928
	arm_func_end ovl08_2172084

	arm_func_start ovl08_2172170
ovl08_2172170: // 0x02172170
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r1, #2
	mov r4, r0
	bl MB_CommResponseRequest
	cmp r0, #0
	bne _02172214
	mov r0, #1
	mvn r0, r0, lsl r4
	mov r5, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r1, _02172250 // =0x0217E928
	ldr r3, [r1]
	ldrh r2, [r3, #2]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #2]
	ldr r3, [r1]
	ldrh r2, [r3, #4]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #4]
	ldr r3, [r1]
	ldrh r2, [r3, #6]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #6]
	ldr r3, [r1]
	ldrh r2, [r3, #8]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #8]
	ldr r3, [r1]
	ldrh r2, [r3, #0xa]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #0xa]
	ldr r2, [r1]
	ldrh r1, [r2, #0xc]
	and r1, r1, r5, lsr #16
	strh r1, [r2, #0xc]
	bl OS_RestoreInterrupts
	mov r0, r4
	bl MB_DisconnectChild
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02172214:
	bl OS_DisableInterrupts
	ldr r1, _02172250 // =0x0217E928
	mov ip, #1
	ldr r5, [r1]
	mvn r2, ip, lsl r4
	ldrh r3, [r5, #6]
	and r2, r3, r2
	strh r2, [r5, #6]
	ldr r2, [r1]
	ldrh r1, [r2, #8]
	orr r1, r1, ip, lsl r4
	strh r1, [r2, #8]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02172250: .word 0x0217E928
	arm_func_end ovl08_2172170

	arm_func_start ovl08_2172254
ovl08_2172254: // 0x02172254
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r1, #0
	mov r4, r0
	bl MB_CommResponseRequest
	cmp r0, #0
	bne _021722F8
	mov r0, #1
	mvn r0, r0, lsl r4
	mov r5, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r1, _02172334 // =0x0217E928
	ldr r3, [r1]
	ldrh r2, [r3, #2]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #2]
	ldr r3, [r1]
	ldrh r2, [r3, #4]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #4]
	ldr r3, [r1]
	ldrh r2, [r3, #6]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #6]
	ldr r3, [r1]
	ldrh r2, [r3, #8]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #8]
	ldr r3, [r1]
	ldrh r2, [r3, #0xa]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #0xa]
	ldr r2, [r1]
	ldrh r1, [r2, #0xc]
	and r1, r1, r5, lsr #16
	strh r1, [r2, #0xc]
	bl OS_RestoreInterrupts
	mov r0, r4
	bl MB_DisconnectChild
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_021722F8:
	bl OS_DisableInterrupts
	ldr r1, _02172334 // =0x0217E928
	mov r2, #1
	ldr r3, [r1]
	mvn r4, r2, lsl r4
	ldrh r2, [r3, #4]
	and r2, r2, r4
	strh r2, [r3, #4]
	ldr r2, [r1]
	ldrh r1, [r2, #2]
	and r1, r1, r4
	strh r1, [r2, #2]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02172334: .word 0x0217E928
	arm_func_end ovl08_2172254

	arm_func_start ovl08_2172338
ovl08_2172338: // 0x02172338
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r1, #1
	mov r4, r0
	bl MB_CommResponseRequest
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	mov r0, #1
	mvn r0, r0, lsl r4
	mov r5, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r1, _021723E0 // =0x0217E928
	ldr r3, [r1]
	ldrh r2, [r3, #2]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #2]
	ldr r3, [r1]
	ldrh r2, [r3, #4]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #4]
	ldr r3, [r1]
	ldrh r2, [r3, #6]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #6]
	ldr r3, [r1]
	ldrh r2, [r3, #8]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #8]
	ldr r3, [r1]
	ldrh r2, [r3, #0xa]
	and r2, r2, r5, lsr #16
	strh r2, [r3, #0xa]
	ldr r2, [r1]
	ldrh r1, [r2, #0xc]
	and r1, r1, r5, lsr #16
	strh r1, [r2, #0xc]
	bl OS_RestoreInterrupts
	mov r0, r4
	bl MB_DisconnectChild
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_021723E0: .word 0x0217E928
	arm_func_end ovl08_2172338

	arm_func_start ovl08_21723E4
ovl08_21723E4: // 0x021723E4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x48
	mov r6, r0
	ldr r0, [r6]
	mov r4, #0
	cmp r0, #0
	moveq r5, r4
	beq _0217242C
	add r0, sp, #0
	bl FS_InitFile
	ldr r1, [r6]
	add r0, sp, #0
	bl FS_OpenFile
	cmp r0, #0
	addeq sp, sp, #0x48
	moveq r0, r4
	ldmeqia sp!, {r4, r5, r6, pc}
	add r5, sp, #0
_0217242C:
	mov r0, r5
	bl MB_GetSegmentLength
	cmp r0, #0
	beq _02172498
	ldr r1, _021724B4 // =0x0217E928
	ldr r0, [r1]
	add r2, r0, #0x2c
	add r0, r0, #0x1b000
	str r2, [r0, #0x144]
	ldr r0, [r1]
	add r0, r0, #0x1b000
	ldr r1, [r0, #0x144]
	cmp r1, #0
	beq _02172498
	mov r0, r5
	mov r2, #0x10000
	bl MB_ReadSegment
	cmp r0, #0
	beq _02172498
	ldr r1, _021724B4 // =0x0217E928
	mov r0, r6
	ldr r1, [r1]
	add r1, r1, #0x1b000
	ldr r1, [r1, #0x144]
	bl MB_UnregisterFile
	cmp r0, #0
	movne r4, #1
_02172498:
	add r0, sp, #0
	cmp r5, r0
	bne _021724A8
	bl FS_CloseFile
_021724A8:
	mov r0, r4
	add sp, sp, #0x48
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021724B4: .word 0x0217E928
	arm_func_end ovl08_21723E4

	arm_func_start ovl08_21724B8
ovl08_21724B8: // 0x021724B8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	mov r0, #2
	bl ovl08_2171B6C
	mov r0, r4
	bl MB_StartParentFromIdle
	cmp r0, #0
	beq _021724F0
	mov r0, #7
	bl ovl08_2171B6C
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_021724F0:
	mov r0, r5
	bl ovl08_21723E4
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	bl OS_Terminate
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end ovl08_21724B8

	arm_func_start ovl08_2172510
ovl08_2172510: // 0x02172510
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x7c
	mov r5, r0
	add r0, sp, #0x28
	mov r4, r1
	bl OS_GetOwnerInfo
	ldrb r2, [sp, #4]
	ldrb r1, [sp, #0x29]
	ldrh r3, [sp, #0x40]
	bic r2, r2, #0xf
	and r1, r1, #0xf
	orr r2, r2, r1
	strb r2, [sp, #4]
	add r0, sp, #0x2c
	add r1, sp, #6
	mov r2, r3, lsl #1
	strb r3, [sp, #5]
	bl MI_CpuCopy8
	ldrb r0, [sp, #4]
	add ip, sp, #0x1a
	mov r1, #0
	bic r0, r0, #0xf0
	strb r0, [sp, #4]
	strh r1, [ip]
	strh r1, [ip, #2]
	strh r1, [ip, #4]
	strh r1, [ip, #6]
	strh r1, [ip, #8]
	strh r1, [ip, #0xa]
	ldr r0, _02172620 // =0x0217E928
	strh r1, [ip, #0xc]
	ldr lr, [r0]
	mov r2, #3
	mov r3, lr
_02172598:
	ldrh r1, [ip], #2
	ldrh r0, [ip], #2
	subs r2, r2, #1
	strh r1, [r3], #2
	strh r0, [r3], #2
	bne _02172598
	ldrh r2, [ip]
	ldr r0, _02172624 // =0x00010040
	add r1, lr, #0x1b000
	strh r2, [r3]
	add r0, lr, r0
	str r0, [r1, #0x140]
	mov r1, #2
	str r1, [sp]
	ldr r0, _02172620 // =0x0217E928
	add r1, sp, #4
	ldr r0, [r0]
	mov r2, r5
	add r0, r0, #0x1b000
	ldr r0, [r0, #0x140]
	mov r3, r4
	bl MB_Init
	cmp r0, #0
	beq _021725FC
	bl OS_Terminate
_021725FC:
	mov r0, #0x100
	mov r1, #1
	bl MB_SetParentCommParam
	ldr r0, _02172628 // =ovl08_2171B80
	bl MB_CommSetParentStateCallback
	mov r0, #1
	bl ovl08_2171B6C
	add sp, sp, #0x7c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02172620: .word 0x0217E928
_02172624: .word 0x00010040
_02172628: .word ovl08_2171B80
	arm_func_end ovl08_2172510

	arm_func_start ovl08_217262C
ovl08_217262C: // 0x0217262C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _02172670 // =0x0217E928
	ldr r1, _02172674 // =0x0001B160
	str r0, [r2]
	add r0, r0, r1
	bl ovl08_2173A38
	ldr r1, _02172670 // =0x0217E928
	mov r2, #0
	ldr r0, [r1]
	add r0, r0, #0x1b000
	str r2, [r0, #0x140]
	ldr r0, [r1]
	add r0, r0, #0x1b000
	str r2, [r0, #0x144]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02172670: .word 0x0217E928
_02172674: .word 0x0001B160
	arm_func_end ovl08_217262C

	arm_func_start ovl08_2172678
ovl08_2172678: // 0x02172678
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021726CC // =0x0217E948
	ldr r0, [r0]
	ldr r0, [r0, #0x40]
	cmp r0, #1
	beq _02172698
	bl OS_Terminate
_02172698:
	mov r0, #3
	bl ovl08_21739B0
	ldr r0, _021726D0 // =ovl08_2173068
	bl WM_End
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	mov r0, #9
	bl ovl08_21739B0
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021726CC: .word 0x0217E948
_021726D0: .word ovl08_2173068
	arm_func_end ovl08_2172678

	arm_func_start ovl08_21726D4
ovl08_21726D4: // 0x021726D4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02172814 // =0x0217E948
	ldr r0, [r0]
	ldr r2, [r0, #0x40]
	cmp r2, #1
	bne _02172718
	ldr r0, _02172818 // =0x0217E944
	ldr r2, [r0]
	cmp r2, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r1, _0217281C // =aAlreadyDwciMov
	mov r0, #0x8000000
	blx r2
	add sp, sp, #4
	ldmia sp!, {pc}
_02172718:
	ldr r0, _02172818 // =0x0217E944
	ldr r3, [r0]
	cmp r3, #0
	beq _02172734
	ldr r1, _02172820 // =aDwciMovWhFinal
	mov r0, #0x8000000
	blx r3
_02172734:
	ldr r0, _02172814 // =0x0217E948
	ldr r0, [r0]
	ldr r0, [r0, #0x40]
	cmp r0, #6
	beq _0217276C
	cmp r0, #5
	beq _0217276C
	cmp r0, #4
	beq _0217276C
	mov r0, #3
	bl ovl08_21739B0
	bl ovl08_2172824
	add sp, sp, #4
	ldmia sp!, {pc}
_0217276C:
	mov r0, #3
	bl ovl08_21739B0
	ldr r0, _02172814 // =0x0217E948
	ldr r0, [r0]
	ldr r0, [r0, #0x44]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0217280C
_0217278C: // jump table
	b _021727F8 // case 0
	b _021727C0 // case 1
	b _021727DC // case 2
	b _021727A4 // case 3
	b _021727F8 // case 4
	b _021727C0 // case 5
_021727A4:
	bl ovl08_2173200
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_2172824
	add sp, sp, #4
	ldmia sp!, {pc}
_021727C0:
	bl ovl08_21731C4
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_2172824
	add sp, sp, #4
	ldmia sp!, {pc}
_021727DC:
	bl ovl08_2173364
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_2172824
	add sp, sp, #4
	ldmia sp!, {pc}
_021727F8:
	bl ovl08_2173328
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_2172824
_0217280C:
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02172814: .word 0x0217E948
_02172818: .word 0x0217E944
_0217281C: .word aAlreadyDwciMov
_02172820: .word aDwciMovWhFinal
	arm_func_end ovl08_21726D4

	arm_func_start ovl08_2172824
ovl08_2172824: // 0x02172824
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_21730D0
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #0xa
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2172824

	arm_func_start ovl08_217284C
ovl08_217284C: // 0x0217284C
	stmdb sp!, {r4, lr}
	ldr r1, _021728E8 // =0x0217E948
	ldr r2, _021728EC // =0x000013E0
	ldr r3, [r1]
	mov r1, r0
	add r0, r3, r2
	add r2, r3, #0x1c00
	bl WM_StepDataSharing
	mov r4, r0
	cmp r4, #7
	bne _0217289C
	ldr r0, _021728F0 // =0x0217E944
	ldr r2, [r0]
	cmp r2, #0
	beq _02172894
	ldr r1, _021728F4 // =aDwciMovWhStepd
	mov r0, #0x8000000
	blx r2
_02172894:
	mov r0, #0
	ldmia sp!, {r4, pc}
_0217289C:
	cmp r4, #5
	bne _021728D0
	ldr r0, _021728F0 // =0x0217E944
	ldr r2, [r0]
	cmp r2, #0
	beq _021728C0
	ldr r1, _021728F8 // =aDwciMovWhStepd_0
	mov r0, #0x8000000
	blx r2
_021728C0:
	mov r0, r4
	bl ovl08_2173990
	mov r0, #0
	ldmia sp!, {r4, pc}
_021728D0:
	cmp r4, #0
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	bl ovl08_2173990
	mov r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_021728E8: .word 0x0217E948
_021728EC: .word 0x000013E0
_021728F0: .word 0x0217E944
_021728F4: .word aDwciMovWhStepd
_021728F8: .word aDwciMovWhStepd_0
	arm_func_end ovl08_217284C

	arm_func_start ovl08_21728FC
ovl08_21728FC: // 0x021728FC
	ldr r2, _0217291C // =0x0217E948
	ldr r1, _02172920 // =0x000013E0
	ldr r3, [r2]
	ldr ip, _02172924 // =WM_GetSharedDataAddress
	mov r2, r0
	add r0, r3, r1
	add r1, r3, #0x1c00
	bx ip
	.align 2, 0
_0217291C: .word 0x0217E948
_02172920: .word 0x000013E0
_02172924: .word WM_GetSharedDataAddress
	arm_func_end ovl08_21728FC

	arm_func_start ovl08_2172928
ovl08_2172928: // 0x02172928
	ldr r1, _02172938 // =0x0217E948
	ldr r1, [r1]
	str r0, [r1, #0x4c]
	bx lr
	.align 2, 0
_02172938: .word 0x0217E948
	arm_func_end ovl08_2172928

	arm_func_start ovl08_217293C
ovl08_217293C: // 0x0217293C
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, _02172AB4 // =0x0217E948
	mov r6, r0
	ldr r0, [r3]
	mov r5, r1
	ldr r0, [r0, #0x40]
	mov r4, r2
	cmp r0, #1
	beq _02172964
	bl OS_Terminate
_02172964:
	ldr r2, _02172AB4 // =0x0217E948
	mov r1, #0x180
	ldr r0, [r2]
	mov r3, #0xe0
	add r0, r0, #0x1000
	str r1, [r0, #0x2a4]
	ldr r0, [r2]
	ldr r1, _02172AB8 // =0x0217E944
	add r0, r0, #0x1000
	str r3, [r0, #0x2a0]
	ldr r3, [r1]
	cmp r3, #0
	beq _021729B0
	ldr r0, [r2]
	ldr r1, _02172ABC // =aRecvBufferSize_0
	add r0, r0, #0x1000
	ldr r2, [r0, #0x2a4]
	mov r0, #0x8000000
	blx r3
_021729B0:
	ldr r0, _02172AB8 // =0x0217E944
	ldr r3, [r0]
	cmp r3, #0
	beq _021729DC
	ldr r0, _02172AB4 // =0x0217E948
	ldr r1, _02172AC0 // =aSendBufferSize_0
	ldr r2, [r0]
	mov r0, #0x8000000
	add r2, r2, #0x1000
	ldr r2, [r2, #0x2a0]
	blx r3
_021729DC:
	ldr r1, _02172AB4 // =0x0217E948
	mov r0, #3
	ldr r1, [r1]
	str r6, [r1, #0x44]
	bl ovl08_21739B0
	ldr r0, _02172AB4 // =0x0217E948
	ldr r1, [r0]
	strh r5, [r1, #0xc]
	ldr r0, [r0]
	strh r4, [r0, #0x32]
	bl WM_GetDispersionBeaconPeriod
	ldr r1, _02172AB4 // =0x0217E948
	mov r2, #0xd0
	ldr r3, [r1]
	mov r4, #0x44
	strh r0, [r3, #0x18]
	ldr r0, [r1]
	mov r3, #2
	strh r2, [r0, #0x34]
	ldr r0, [r1]
	mov r2, #0
	strh r4, [r0, #0x36]
	ldr r0, [r1]
	mov r4, #1
	strh r3, [r0, #0x10]
	ldr r0, [r1]
	cmp r6, #2
	strh r2, [r0, #0x16]
	ldr r0, [r1]
	strh r2, [r0, #0x12]
	ldr r0, [r1]
	strh r4, [r0, #0xe]
	ldr r0, _02172AB4 // =0x0217E948
	movne r4, r2
	ldr r0, [r0]
	cmp r6, #0
	strh r4, [r0, #0x14]
	beq _02172A84
	cmp r6, #2
	beq _02172A84
	cmp r6, #4
	bne _02172A8C
_02172A84:
	bl ovl08_2173940
	ldmia sp!, {r4, r5, r6, pc}
_02172A8C:
	ldr r0, _02172AB8 // =0x0217E944
	ldr r3, [r0]
	cmp r3, #0
	beq _02172AAC
	ldr r1, _02172AC4 // =aUnknownConnect_1
	mov r2, r6
	mov r0, #0x8000000
	blx r3
_02172AAC:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02172AB4: .word 0x0217E948
_02172AB8: .word 0x0217E944
_02172ABC: .word aRecvBufferSize_0
_02172AC0: .word aSendBufferSize_0
_02172AC4: .word aUnknownConnect_1
	arm_func_end ovl08_217293C

	arm_func_start ovl08_2172AC8
ovl08_2172AC8: // 0x02172AC8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _02172AF0
	bl ovl08_2173990
	mov r0, #0xa
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
_02172AF0:
	ldr r0, _02172B24 // =ovl08_2172B80
	bl WM_SetIndCallback
	cmp r0, #0
	beq _02172B14
	bl ovl08_2173990
	mov r0, #0xa
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
_02172B14:
	mov r0, #1
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02172B24: .word ovl08_2172B80
	arm_func_end ovl08_2172AC8

	arm_func_start ovl08_2172B28
ovl08_2172B28: // 0x02172B28
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #3
	bl ovl08_21739B0
	ldr r0, _02172B78 // =0x0217E948
	ldr r1, _02172B7C // =ovl08_2172AC8
	ldr r0, [r0]
	mov r2, #2
	add r0, r0, #0x80
	bl WM_Initialize
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	bl ovl08_2173990
	mov r0, #0xa
	bl ovl08_21739B0
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02172B78: .word 0x0217E948
_02172B7C: .word ovl08_2172AC8
	arm_func_end ovl08_2172B28

	arm_func_start ovl08_2172B80
ovl08_2172B80: // 0x02172B80
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #8
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_21739B0
	bl OS_Terminate
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2172B80

	arm_func_start ovl08_2172BAC
ovl08_2172BAC: // 0x02172BAC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _02172C28 // =0x0217E948
	mov r0, #0
	ldr r1, [r2]
	mov r3, #1
	add r1, r1, #0x1000
	str r0, [r1, #0x2a4]
	ldr r1, [r2]
	add r1, r1, #0x1000
	str r0, [r1, #0x2a0]
	ldr r1, [r2]
	str r0, [r1, #0x48]
	ldr r1, [r2]
	strh r0, [r1, #0x50]
	ldr r1, [r2]
	strh r3, [r1, #0x52]
	ldr r1, [r2]
	str r0, [r1, #0x54]
	ldr r1, [r2]
	str r0, [r1]
	ldr r1, [r2]
	strh r0, [r1, #4]
	ldr r1, [r2]
	str r0, [r1, #0x4c]
	bl ovl08_2172B28
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02172C28: .word 0x0217E948
	arm_func_end ovl08_2172BAC

	arm_func_start ovl08_2172C2C
ovl08_2172C2C: // 0x02172C2C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, #0
	mov r2, r4
	mov r5, r4
	mov r3, #1
_02172C44:
	mov r1, r3, lsl r5
	ands r1, r0, r1
	beq _02172C68
	add r1, r5, #1
	add r2, r2, #1
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r4, r1, asr #0x10
	mov r2, r2, lsr #0x10
_02172C68:
	add r1, r5, #1
	mov r1, r1, lsl #0x10
	mov r5, r1, asr #0x10
	cmp r5, #0x10
	blt _02172C44
	cmp r2, #1
	addls sp, sp, #4
	movls r0, r4
	ldmlsia sp!, {r4, r5, pc}
	ldr lr, _02172D18 // =0x0217E948
	ldr r3, _02172D1C // =0x00010DCD
	ldr r5, [lr]
	ldr ip, _02172D20 // =0x00003039
	ldr r4, [r5, #0x58]
	mov r1, #0
	mla r3, r4, r3, ip
	str r3, [r5, #0x58]
	ldr r3, [lr]
	ldr r3, [r3, #0x58]
	and r3, r3, #0xff
	mul r3, r2, r3
	mov r2, r3, lsl #8
	mov r3, r2, lsr #0x10
_02172CC4:
	ands r2, r0, #1
	beq _02172CF0
	cmp r3, #0
	addeq r0, r1, #1
	moveq r0, r0, lsl #0x10
	addeq sp, sp, #4
	moveq r0, r0, asr #0x10
	ldmeqia sp!, {r4, r5, pc}
	sub r2, r3, #1
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
_02172CF0:
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r0, r0, lsl #0xf
	mov r1, r1, asr #0x10
	cmp r1, #0x10
	mov r0, r0, lsr #0x10
	blt _02172CC4
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02172D18: .word 0x0217E948
_02172D1C: .word 0x00010DCD
_02172D20: .word 0x00003039
	arm_func_end ovl08_2172C2C

	arm_func_start ovl08_2172D24
ovl08_2172D24: // 0x02172D24
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02172DA0 // =0x0217E948
	ldr r0, [r0]
	ldr r0, [r0, #0x40]
	cmp r0, #7
	beq _02172D44
	bl OS_Terminate
_02172D44:
	mov r0, #1
	bl ovl08_21739B0
	ldr r0, _02172DA0 // =0x0217E948
	ldr r0, [r0]
	ldrh r0, [r0, #0x60]
	bl ovl08_2172C2C
	ldr r2, _02172DA0 // =0x0217E948
	ldr r1, _02172DA4 // =0x0217E944
	ldr r3, [r2]
	strh r0, [r3, #0x5c]
	ldr r3, [r1]
	cmp r3, #0
	beq _02172D8C
	ldr r0, [r2]
	ldr r1, _02172DA8 // =aDecidedChannel_0
	ldrh r2, [r0, #0x5c]
	mov r0, #0x8000000
	blx r3
_02172D8C:
	ldr r0, _02172DA0 // =0x0217E948
	ldr r0, [r0]
	ldrh r0, [r0, #0x5c]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02172DA0: .word 0x0217E948
_02172DA4: .word 0x0217E944
_02172DA8: .word aDecidedChannel_0
	arm_func_end ovl08_2172D24

	arm_func_start ovl08_2172DAC
ovl08_2172DAC: // 0x02172DAC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r3, r1
	mov ip, #0x1e
	mov r1, #3
	mov r2, #0x11
	str ip, [sp]
	bl WM_MeasureChannel
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2172DAC

	arm_func_start ovl08_2172DD4
ovl08_2172DD4: // 0x02172DD4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _02172DF8
	bl ovl08_2173990
	mov r0, #9
	bl ovl08_21739B0
	ldmia sp!, {r4, pc}
_02172DF8:
	ldr r0, _02172EA4 // =0x0217E944
	ldr ip, [r0]
	cmp ip, #0
	beq _02172E1C
	ldrh r2, [r4, #8]
	ldrh r3, [r4, #0xa]
	ldr r1, _02172EA8 // =aChannelDBratio_0
	mov r0, #0x8000000
	blx ip
_02172E1C:
	ldr r0, _02172EAC // =0x0217E948
	ldrh r2, [r4, #0xa]
	ldr r3, [r0]
	ldrh ip, [r4, #8]
	ldrh r1, [r3, #0x5e]
	cmp r1, r2
	bls _02172E54
	strh r2, [r3, #0x5e]
	sub r1, ip, #1
	mov r2, #1
	mov r1, r2, lsl r1
	ldr r0, [r0]
	strh r1, [r0, #0x60]
	b _02172E6C
_02172E54:
	cmp r1, r2
	ldreqh r2, [r3, #0x60]
	subeq r0, ip, #1
	moveq r1, #1
	orreq r0, r2, r1, lsl r0
	streqh r0, [r3, #0x60]
_02172E6C:
	add r0, ip, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ovl08_2172EB0
	cmp r0, #0x18
	bne _02172E90
	mov r0, #7
	bl ovl08_21739B0
	ldmia sp!, {r4, pc}
_02172E90:
	cmp r0, #2
	ldmeqia sp!, {r4, pc}
	mov r0, #9
	bl ovl08_21739B0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172EA4: .word 0x0217E944
_02172EA8: .word aChannelDBratio_0
_02172EAC: .word 0x0217E948
	arm_func_end ovl08_2172DD4

	arm_func_start ovl08_2172EB0
ovl08_2172EB0: // 0x02172EB0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WM_GetAllowedChannel
	cmp r0, #0x8000
	bne _02172EDC
	mov r0, #3
	bl ovl08_2173990
	mov r0, #9
	bl ovl08_21739B0
	mov r0, #3
	ldmia sp!, {r4, pc}
_02172EDC:
	cmp r0, #0
	bne _02172EFC
	mov r0, #0x16
	bl ovl08_2173990
	mov r0, #9
	bl ovl08_21739B0
	mov r0, #0x18
	ldmia sp!, {r4, pc}
_02172EFC:
	sub r1, r4, #1
	mov r2, #1
	mov r1, r2, lsl r1
	ands r1, r1, r0
	bne _02172F38
_02172F10:
	add r1, r4, #1
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
	cmp r4, #0x10
	movhi r0, #0x18
	ldmhiia sp!, {r4, pc}
	sub r1, r4, #1
	mov r1, r2, lsl r1
	ands r1, r1, r0
	beq _02172F10
_02172F38:
	ldr r0, _02172F50 // =ovl08_2172DD4
	mov r1, r4
	bl ovl08_2172DAC
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172F50: .word ovl08_2172DD4
	arm_func_end ovl08_2172EB0

	arm_func_start ovl08_2172F54
ovl08_2172F54: // 0x02172F54
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	add r0, sp, #0
	bl OS_GetMacAddress
	ldr r1, _0217301C // =0x027FFC3C
	ldrh r0, [sp]
	ldr r3, [r1]
	ldrh r1, [sp, #2]
	add r0, r0, r3
	ldr r2, _02173020 // =0x0217E948
	add r1, r1, r0
	ldrh r3, [sp, #4]
	ldr r0, [r2]
	mov ip, #0
	add r1, r3, r1
	str r1, [r0, #0x58]
	ldr lr, [r2]
	ldr r0, _02173024 // =0x00010DCD
	ldr r3, [lr, #0x58]
	ldr r1, _02173028 // =0x00003039
	mla r0, r3, r0, r1
	str r0, [lr, #0x58]
	ldr r0, [r2]
	mov r3, #0x65
	strh ip, [r0, #0x5c]
	ldr r1, [r2]
	mov r0, #3
	strh r3, [r1, #0x5e]
	bl ovl08_21739B0
	mov r0, #1
	bl ovl08_2172EB0
	cmp r0, #0x18
	bne _02172FF4
	mov r0, #0x18
	bl ovl08_2173990
	mov r0, #9
	bl ovl08_21739B0
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {pc}
_02172FF4:
	cmp r0, #2
	addeq sp, sp, #0xc
	moveq r0, #1
	ldmeqia sp!, {pc}
	bl ovl08_2173990
	mov r0, #9
	bl ovl08_21739B0
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0217301C: .word 0x027FFC3C
_02173020: .word 0x0217E948
_02173024: .word 0x00010DCD
_02173028: .word 0x00003039
	arm_func_end ovl08_2172F54

	arm_func_start ovl08_217302C
ovl08_217302C: // 0x0217302C
	ldr r0, _0217303C // =0x0217E948
	ldr r0, [r0]
	ldr r0, [r0, #0x40]
	bx lr
	.align 2, 0
_0217303C: .word 0x0217E948
	arm_func_end ovl08_217302C

	arm_func_start ovl08_2173040
ovl08_2173040: // 0x02173040
	ldr r0, _02173050 // =0x0217E948
	ldr r0, [r0]
	ldrh r0, [r0, #0x52]
	bx lr
	.align 2, 0
_02173050: .word 0x0217E948
	arm_func_end ovl08_2173040

	arm_func_start ovl08_2173054
ovl08_2173054: // 0x02173054
	ldr r1, _02173064 // =0x0217E948
	ldr r1, [r1]
	str r0, [r1, #8]
	bx lr
	.align 2, 0
_02173064: .word 0x0217E948
	arm_func_end ovl08_2173054

	arm_func_start ovl08_2173068
ovl08_2173068: // 0x02173068
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0217308C
	mov r0, #0xa
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
_0217308C:
	mov r0, #0
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2173068

	arm_func_start ovl08_217309C
ovl08_217309C: // 0x0217309C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _021730C4
	mov r0, #9
	bl ovl08_21739B0
	ldrh r0, [r4, #2]
	bl ovl08_2173990
	ldmia sp!, {r4, pc}
_021730C4:
	mov r0, #1
	bl ovl08_21739B0
	ldmia sp!, {r4, pc}
	arm_func_end ovl08_217309C

	arm_func_start ovl08_21730D0
ovl08_21730D0: // 0x021730D0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #3
	bl ovl08_21739B0
	ldr r0, _02173108 // =ovl08_217309C
	bl WM_Reset
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	bl ovl08_2173990
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02173108: .word ovl08_217309C
	arm_func_end ovl08_21730D0

	arm_func_start ovl08_217310C
ovl08_217310C: // 0x0217310C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0217312C
	bl ovl08_2173990
	add sp, sp, #4
	ldmia sp!, {pc}
_0217312C:
	mov r0, #1
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_217310C

	arm_func_start ovl08_217313C
ovl08_217313C: // 0x0217313C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #3
	bl ovl08_21739B0
	ldr r0, _0217317C // =ovl08_217310C
	mov r1, #0
	bl WM_Disconnect
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	bl ovl08_2173990
	bl ovl08_2172824
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0217317C: .word ovl08_217310C
	arm_func_end ovl08_217313C

	arm_func_start ovl08_2173180
ovl08_2173180: // 0x02173180
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _021731A4
	bl ovl08_2173990
	bl ovl08_21726D4
	add sp, sp, #4
	ldmia sp!, {pc}
_021731A4:
	bl ovl08_217313C
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2173180

	arm_func_start ovl08_21731C4
ovl08_21731C4: // 0x021731C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #3
	bl ovl08_21739B0
	ldr r0, _021731FC // =ovl08_2173180
	bl WM_EndMP
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	bl ovl08_2173990
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021731FC: .word ovl08_2173180
	arm_func_end ovl08_21731C4

	arm_func_start ovl08_2173200
ovl08_2173200: // 0x02173200
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0217325C // =0x0217E948
	ldr r0, [r0]
	ldr r0, [r0, #0x40]
	cmp r0, #6
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
	mov r0, #3
	bl ovl08_21739B0
	ldr r0, _0217325C // =0x0217E948
	ldr r0, [r0]
	add r0, r0, #0x1e00
	bl WM_EndKeySharing
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	bl ovl08_2173990
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0217325C: .word 0x0217E948
	arm_func_end ovl08_2173200

	arm_func_start ovl08_2173260
ovl08_2173260: // 0x02173260
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _02173280
	bl ovl08_2173990
	add sp, sp, #4
	ldmia sp!, {pc}
_02173280:
	mov r0, #1
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2173260

	arm_func_start ovl08_2173290
ovl08_2173290: // 0x02173290
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021732C0 // =ovl08_2173260
	bl WM_EndParent
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	bl ovl08_2173990
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021732C0: .word ovl08_2173260
	arm_func_end ovl08_2173290

	arm_func_start ovl08_21732C4
ovl08_21732C4: // 0x021732C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _021732E8
	bl ovl08_2173990
	bl ovl08_2172824
	add sp, sp, #4
	ldmia sp!, {pc}
_021732E8:
	bl ovl08_2173290
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02173320 // =0x0217E944
	ldr r2, [r0]
	cmp r2, #0
	beq _02173314
	ldr r1, _02173324 // =aDwciMovWhState
	mov r0, #0x8000000
	blx r2
_02173314:
	bl ovl08_2172824
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02173320: .word 0x0217E944
_02173324: .word aDwciMovWhState
	arm_func_end ovl08_21732C4

	arm_func_start ovl08_2173328
ovl08_2173328: // 0x02173328
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #3
	bl ovl08_21739B0
	ldr r0, _02173360 // =ovl08_21732C4
	bl WM_EndMP
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	bl ovl08_2173990
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02173360: .word ovl08_21732C4
	arm_func_end ovl08_2173328

	arm_func_start ovl08_2173364
ovl08_2173364: // 0x02173364
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0217339C // =0x0217E948
	ldr r0, [r0]
	add r0, r0, #0x1e00
	bl WM_EndKeySharing
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	bl ovl08_2173990
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0217339C: .word 0x0217E948
	arm_func_end ovl08_2173364

	arm_func_start ovl08_21733A0
ovl08_21733A0: // 0x021733A0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #6
	bl ovl08_21739B0
	ldr r0, _021733E4 // =0x0217E948
	mov r1, #0xd
	ldr r0, [r0]
	add r0, r0, #0x1e00
	bl WM_StartKeySharing
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	bl ovl08_2173990
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021733E4: .word 0x0217E948
	arm_func_end ovl08_21733A0

	arm_func_start ovl08_21733E8
ovl08_21733E8: // 0x021733E8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r1, [r0, #2]
	cmp r1, #0
	beq _02173414
	mov r0, r1
	bl ovl08_2173990
	mov r0, #9
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
_02173414:
	ldrh r2, [r0, #4]
	sub r0, r2, #0xa
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02173508
_02173428: // jump table
	b _02173438 // case 0
	b _02173528 // case 1
	b _02173508 // case 2
	b _02173508 // case 3
_02173438:
	ldr r0, _02173530 // =0x0217E948
	ldr r1, [r0]
	ldr r0, [r1, #0x44]
	cmp r0, #2
	bne _021734A4
	ldr r0, [r1, #0x40]
	cmp r0, #4
	bne _02173494
	bl ovl08_21733A0
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02173534 // =0x0217E944
	ldr r2, [r0]
	cmp r2, #0
	beq _02173484
	ldr r1, _02173538 // =aDwciMovWhState_0
	mov r0, #0x8000000
	blx r2
_02173484:
	mov r0, #9
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
_02173494:
	cmp r0, #6
	bne _021734F8
	add sp, sp, #4
	ldmia sp!, {pc}
_021734A4:
	cmp r0, #4
	bne _021734F8
	ldr r0, _0217353C // =0x000013E0
	mov ip, #1
	add r0, r1, r0
	mov r1, #0xd
	mov r2, #7
	mov r3, #0x44
	str ip, [sp]
	bl WM_StartDataSharing
	cmp r0, #0
	beq _021734E8
	bl ovl08_2173990
	mov r0, #9
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
_021734E8:
	mov r0, #5
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
_021734F8:
	mov r0, #4
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
_02173508:
	ldr r0, _02173534 // =0x0217E944
	ldr r3, [r0]
	cmp r3, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r1, _02173540 // =aUnknownIndicat_0
	mov r0, #0x8000000
	blx r3
_02173528:
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02173530: .word 0x0217E948
_02173534: .word 0x0217E944
_02173538: .word aDwciMovWhState_0
_0217353C: .word 0x000013E0
_02173540: .word aUnknownIndicat_0
	arm_func_end ovl08_21733E8

	arm_func_start ovl08_2173544
ovl08_2173544: // 0x02173544
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r0, _021735D8 // =0x0217E948
	ldr r0, [r0]
	ldr r0, [r0, #0x40]
	sub r0, r0, #4
	cmp r0, #2
	addls sp, sp, #0xc
	movls r0, #1
	ldmlsia sp!, {pc}
	mov r0, #4
	bl ovl08_21739B0
	ldr r0, _021735D8 // =0x0217E948
	mov ip, #1
	ldr lr, [r0]
	ldr r2, _021735DC // =0x00001060
	add r3, lr, #0x1000
	ldr r1, [r3, #0x2a0]
	ldr r0, _021735E0 // =ovl08_21733E8
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp]
	str ip, [sp, #4]
	ldr r3, [r3, #0x2a4]
	add r1, lr, r2
	mov r2, r3, lsl #0x10
	mov r2, r2, lsr #0x10
	add r3, lr, #0xf80
	bl WM_StartMP
	cmp r0, #2
	addeq sp, sp, #0xc
	moveq r0, #1
	ldmeqia sp!, {pc}
	bl ovl08_2173990
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_021735D8: .word 0x0217E948
_021735DC: .word 0x00001060
_021735E0: .word ovl08_21733E8
	arm_func_end ovl08_2173544

	arm_func_start ovl08_21735E4
ovl08_21735E4: // 0x021735E4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldrh r2, [r5, #0x10]
	mov r1, #1
	ldrh r0, [r5, #2]
	mov r1, r1, lsl r2
	mov r1, r1, lsl #0x10
	cmp r0, #0
	mov r4, r1, lsr #0x10
	beq _02173624
	bl ovl08_2173990
	mov r0, #9
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02173624:
	ldrh ip, [r5, #8]
	cmp ip, #7
	bgt _02173660
	cmp ip, #7
	bge _0217366C
	cmp ip, #2
	bgt _02173750
	cmp ip, #0
	blt _02173750
	cmp ip, #0
	beq _02173730
	cmp ip, #2
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	b _02173750
_02173660:
	cmp ip, #9
	beq _021736F4
	b _02173750
_0217366C:
	ldr r0, _0217377C // =0x0217E944
	ldr r3, [r0]
	cmp r3, #0
	beq _02173688
	ldr r1, _02173780 // =aStartparentNew_0
	mov r0, #0x8000000
	blx r3
_02173688:
	ldr r0, _02173784 // =0x0217E948
	ldr r0, [r0]
	ldr r1, [r0, #0x4c]
	cmp r1, #0
	beq _021736D8
	mov r0, r5
	blx r1
	cmp r0, #0
	bne _021736D8
	ldrh r1, [r5, #0x10]
	mov r0, #0
	bl WM_Disconnect
	cmp r0, #2
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	bl ovl08_2173990
	mov r0, #9
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_021736D8:
	ldr r0, _02173784 // =0x0217E948
	add sp, sp, #4
	ldr r1, [r0]
	ldrh r0, [r1, #0x52]
	orr r0, r0, r4
	strh r0, [r1, #0x52]
	ldmia sp!, {r4, r5, pc}
_021736F4:
	ldr r0, _0217377C // =0x0217E944
	ldr r3, [r0]
	cmp r3, #0
	beq _02173710
	ldr r1, _02173788 // =aStartparentChi_1
	mov r0, #0x8000000
	blx r3
_02173710:
	ldr r0, _02173784 // =0x0217E948
	mvn r1, r4
	ldr r2, [r0]
	add sp, sp, #4
	ldrh r0, [r2, #0x52]
	and r0, r0, r1
	strh r0, [r2, #0x52]
	ldmia sp!, {r4, r5, pc}
_02173730:
	bl ovl08_2173544
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	mov r0, #9
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02173750:
	ldr r0, _0217377C // =0x0217E944
	ldr r3, [r0]
	cmp r3, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, _0217378C // =aUnknownIndicat_0
	mov r2, ip
	mov r0, #0x8000000
	blx r3
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0217377C: .word 0x0217E944
_02173780: .word aStartparentNew_0
_02173784: .word 0x0217E948
_02173788: .word aStartparentChi_1
_0217378C: .word aUnknownIndicat_0
	arm_func_end ovl08_21735E4

	arm_func_start ovl08_2173790
ovl08_2173790: // 0x02173790
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021737FC // =0x0217E948
	ldr r0, [r0]
	ldr r0, [r0, #0x40]
	sub r0, r0, #4
	cmp r0, #2
	addls sp, sp, #4
	movls r0, #1
	ldmlsia sp!, {pc}
	ldr r0, _02173800 // =ovl08_21735E4
	bl WM_StartParent
	cmp r0, #2
	beq _021737D8
	bl ovl08_2173990
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_021737D8:
	ldr r1, _021737FC // =0x0217E948
	mov r3, #0
	ldr r2, [r1]
	mov r0, #1
	strh r3, [r2, #0x50]
	ldr r1, [r1]
	strh r0, [r1, #0x52]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021737FC: .word 0x0217E948
_02173800: .word ovl08_21735E4
	arm_func_end ovl08_2173790

	arm_func_start ovl08_2173804
ovl08_2173804: // 0x02173804
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0217382C
	bl ovl08_2173990
	mov r0, #9
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
_0217382C:
	bl ovl08_2173790
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2173804

	arm_func_start ovl08_217384C
ovl08_217384C: // 0x0217384C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #3
	bl ovl08_21739B0
	ldr r0, _021738B4 // =0x0217E948
	ldr r1, [r0]
	add r0, r1, #0x1000
	ldr r2, [r0, #0x3ac]
	add r0, r1, #0x13c0
	blx r2
	ldr r2, _021738B4 // =0x0217E948
	mov r1, r0
	ldr r2, [r2]
	ldr r0, _021738B8 // =ovl08_2173804
	add r2, r2, #0x13c0
	bl WM_SetWEPKey
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	bl ovl08_2173990
	mov r0, #9
	bl ovl08_21739B0
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021738B4: .word 0x0217E948
_021738B8: .word ovl08_2173804
	arm_func_end ovl08_217384C

	arm_func_start ovl08_21738BC
ovl08_21738BC: // 0x021738BC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _021738E4
	bl ovl08_2173990
	mov r0, #9
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
_021738E4:
	ldr r0, _0217393C // =0x0217E948
	ldr r0, [r0]
	add r0, r0, #0x1000
	ldr r0, [r0, #0x3ac]
	cmp r0, #0
	beq _0217391C
	bl ovl08_217384C
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
_0217391C:
	bl ovl08_2173790
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #9
	bl ovl08_21739B0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0217393C: .word 0x0217E948
	arm_func_end ovl08_21738BC

	arm_func_start ovl08_2173940
ovl08_2173940: // 0x02173940
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #3
	bl ovl08_21739B0
	ldr r1, _02173988 // =0x0217E948
	ldr r0, _0217398C // =ovl08_21738BC
	ldr r1, [r1]
	bl WM_SetParentParameter
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	bl ovl08_2173990
	mov r0, #9
	bl ovl08_21739B0
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02173988: .word 0x0217E948
_0217398C: .word ovl08_21738BC
	arm_func_end ovl08_2173940

	arm_func_start ovl08_2173990
ovl08_2173990: // 0x02173990
	ldr r1, _021739AC // =0x0217E948
	ldr r2, [r1]
	ldr r1, [r2, #0x40]
	sub r1, r1, #9
	cmp r1, #1
	strhi r0, [r2, #0x54]
	bx lr
	.align 2, 0
_021739AC: .word 0x0217E948
	arm_func_end ovl08_2173990

	arm_func_start ovl08_21739B0
ovl08_21739B0: // 0x021739B0
	stmdb sp!, {r4, lr}
	ldr r1, _02173A24 // =0x0217E944
	mov r4, r0
	ldr ip, [r1]
	cmp ip, #0
	beq _021739E8
	ldr r0, _02173A28 // =0x0217E948
	ldr r2, _02173A2C // =_0217C044
	ldr r0, [r0]
	ldr r1, _02173A30 // =aS_10
	ldr r3, [r0, #0x40]
	mov r0, #0x8000000
	ldr r2, [r2, r3, lsl #2]
	blx ip
_021739E8:
	ldr r1, _02173A28 // =0x0217E948
	ldr r0, _02173A24 // =0x0217E944
	ldr r2, [r1]
	str r4, [r2, #0x40]
	ldr r3, [r0]
	cmp r3, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r1]
	ldr r0, _02173A2C // =_0217C044
	ldr r2, [r1, #0x40]
	ldr r1, _02173A34 // =0x0217C26C
	ldr r2, [r0, r2, lsl #2]
	mov r0, #0x8000000
	blx r3
	ldmia sp!, {r4, pc}
	.align 2, 0
_02173A24: .word 0x0217E944
_02173A28: .word 0x0217E948
_02173A2C: .word _0217C044
_02173A30: .word aS_10
_02173A34: .word 0x0217C26C
	arm_func_end ovl08_21739B0

	arm_func_start ovl08_2173A38
ovl08_2173A38: // 0x02173A38
	ldr r1, _02173A70 // =0x0217E948
	mov r2, #0
	str r0, [r1]
	str r2, [r0, #0x40]
	ldr r0, [r1]
	add r0, r0, #0x1000
	str r2, [r0, #0x3a8]
	ldr r0, [r1]
	add r0, r0, #0x1000
	str r2, [r0, #0x3ac]
	ldr r0, [r1]
	add r0, r0, #0x1000
	str r2, [r0, #0x3b0]
	bx lr
	.align 2, 0
_02173A70: .word 0x0217E948
	arm_func_end ovl08_2173A38

	arm_func_start ovl08_2173A74
ovl08_2173A74: // 0x02173A74
	ldr r0, _02173A88 // =0x0217E94C
	ldr r0, [r0]
	add r0, r0, #0x100
	ldrh r0, [r0, #0x44]
	bx lr
	.align 2, 0
_02173A88: .word 0x0217E94C
	arm_func_end ovl08_2173A74

	arm_func_start ovl08_2173A8C
ovl08_2173A8C: // 0x02173A8C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov ip, #0
	ldr r4, _02173B78 // =0x0217E94C
	mov r5, ip
	mov r2, ip
	mov r0, #1
	mov r1, #0xbc
	mov lr, #0x44
_02173AB0:
	ldr r3, [r4]
	add r6, r3, ip, lsl #2
	ldr r6, [r6, #0x208]
	cmp r6, #0
	beq _02173B64
	add r6, r3, #0x100
	mla r7, ip, lr, r6
	cmp ip, #1
	bne _02173B64
	ldrb r6, [r3, #0xa93]
	cmp r6, #1
	bne _02173B34
	ldrh r6, [r7]
	cmp r6, #0x10
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r6, [r3, #0xa94]
	add r6, r6, #1
	str r6, [r3, #0xa94]
	ldr r6, [r4]
	ldr r3, [r6, #0xa94]
	ands r3, r3, #1
	bne _02173B64
	add r3, r6, #0x200
	ldrh r6, [r3]
	add r6, r6, #1
	strh r6, [r3]
	ldr r3, [r4]
	add r3, r3, #0x200
	ldrh r6, [r3]
	cmp r6, #0x24
	strhsh r2, [r3]
	b _02173B64
_02173B34:
	add r3, r3, #0x200
	strh r1, [r3, #2]
	ldrh r3, [r7]
	cmp r3, #0xbd
	bne _02173B64
	ldr r3, [r4]
	strb r0, [r3, #0xa93]
	ldr r3, [r4]
	add r3, r3, #0x200
	strh r5, [r3]
	ldr r3, [r4]
	str r5, [r3, #0xa94]
_02173B64:
	add ip, ip, #1
	cmp ip, #0x10
	blt _02173AB0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02173B78: .word 0x0217E94C
	arm_func_end ovl08_2173A8C

	arm_func_start ovl08_2173B7C
ovl08_2173B7C: // 0x02173B7C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r3, _02173CD4 // =0x0217E94C
	ldr r5, [r3]
	ldrb r4, [r5, #0xa93]
	cmp r4, #1
	bne _02173BC4
	ldr r4, [r5, #0xab0]
	strh r0, [r4]
	ldr r4, [r3]
	mov r0, r2
	ldr r4, [r4, #0xab0]
	mov r2, #0x40
	strh r1, [r4, #2]
	ldr r1, [r3]
	ldr r1, [r1, #0xab0]
	add r1, r1, #4
	bl MI_CpuCopy8
	b _02173BF0
_02173BC4:
	ldr r0, [r5, #0x204]
	mov r1, #0xbc
	add r0, r0, #1
	str r0, [r5, #0x204]
	ldr r0, [r3]
	ldr r0, [r0, #0xab0]
	strh r1, [r0]
	ldr r0, [r3]
	ldrb r1, [r0, #0xa92]
	ldr r0, [r0, #0xab0]
	strb r1, [r0, #4]
_02173BF0:
	bl ovl08_217302C
	cmp r0, #5
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, _02173CD4 // =0x0217E94C
	ldr r0, [r0]
	bl ovl08_217284C
	cmp r0, #0
	bne _02173C28
	ldr r0, _02173CD4 // =0x0217E94C
	ldr r1, [r0]
	ldr r0, [r1, #0x204]
	add r0, r0, #4
	str r0, [r1, #0x204]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02173C28:
	ldr r0, _02173CD4 // =0x0217E94C
	ldr r1, [r0]
	ldrb r0, [r1, #0xa93]
	cmp r0, #0
	ldreq r0, [r1, #0x204]
	addeq r0, r0, #1
	streq r0, [r1, #0x204]
	beq _02173C6C
	mov r0, #0
	str r0, [r1, #0x204]
	bl ovl08_2173040
	cmp r0, #3
	ldrne r0, _02173CD4 // =0x0217E94C
	movne r1, #0x1b
	ldrne r0, [r0]
	strneb r1, [r0, #0xa90]
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
_02173C6C:
	mov r7, #0
	ldr r8, _02173CD4 // =0x0217E94C
	mov r4, r7
	mov r6, #0x44
	mov r5, #1
_02173C80:
	mov r0, r7
	bl ovl08_21728FC
	cmp r0, #0
	ldreq r0, [r8]
	addeq r0, r0, r7, lsl #2
	streq r4, [r0, #0x208]
	beq _02173CBC
	ldr r1, [r8]
	mov r2, r6
	add r1, r1, #0x100
	mla r1, r7, r6, r1
	bl MI_CpuCopy8
	ldr r0, [r8]
	add r0, r0, r7, lsl #2
	str r5, [r0, #0x208]
_02173CBC:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #2
	blo _02173C80
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02173CD4: .word 0x0217E94C
	arm_func_end ovl08_2173B7C

	arm_func_start ovl08_2173CD8
ovl08_2173CD8: // 0x02173CD8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02173D20 // =0x0217E94C
	mov r1, #0
	ldr r0, [r0]
	mov r2, #0x100
	add r0, r0, #0x100
	bl MI_CpuFill8
	ldr r0, _02173D20 // =0x0217E94C
	mov r1, #0
	ldr r0, [r0]
	mov r2, #0x100
	bl MI_CpuFill8
	ldr r0, _02173D20 // =0x0217E94C
	ldr r0, [r0]
	str r0, [r0, #0xab0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02173D20: .word 0x0217E94C
	arm_func_end ovl08_2173CD8

	arm_func_start ovl08_2173D24
ovl08_2173D24: // 0x02173D24
	stmdb sp!, {r4, lr}
	add r0, r0, #0xa
	bl ovl08_217193C
	movs r4, r0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	bl ovl08_21719FC
	ldr r1, _02173D5C // =0x0217E94C
	sub r2, r4, #1
	ldr r1, [r1]
	add r1, r1, r2, lsl #2
	str r0, [r1, #0xaa0]
	mov r0, #1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02173D5C: .word 0x0217E94C
	arm_func_end ovl08_2173D24

	arm_func_start ovl08_2173D60
ovl08_2173D60: // 0x02173D60
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_217302C
	cmp r0, #1
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
	bl ovl08_2172678
	ldr r1, _02173D98 // =0x0217E94C
	mov r0, #1
	ldr r1, [r1]
	strb r0, [r1, #0xa90]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02173D98: .word 0x0217E94C
	arm_func_end ovl08_2173D60

	arm_func_start ovl08_2173D9C
ovl08_2173D9C: // 0x02173D9C
	ldr r0, _02173DB0 // =0x0217E94C
	mov r1, #0xc
	ldr r0, [r0]
	strb r1, [r0, #0xa90]
	bx lr
	.align 2, 0
_02173DB0: .word 0x0217E94C
	arm_func_end ovl08_2173D9C

	arm_func_start ovl08_2173DB4
ovl08_2173DB4: // 0x02173DB4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_217302C
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b _02173F94
_02173DCC: // jump table
	b _02173F94 // case 0
	b _02173DE8 // case 1
	b _02173F94 // case 2
	b _02173F94 // case 3
	b _02173E18 // case 4
	b _02173E18 // case 5
	b _02173E18 // case 6
_02173DE8:
	ldr r1, _02173F9C // =0x0217E94C
	mov r0, #4
	ldr r1, [r1]
	add r1, r1, #0x600
	ldrh r3, [r1, #0x48]
	ldrh r2, [r1, #0x4a]
	add r1, r3, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl ovl08_217293C
	add sp, sp, #4
	ldmia sp!, {pc}
_02173E18:
	ldr r1, _02173F9C // =0x0217E94C
	mov r0, #0
	ldr r2, [r1]
	add r1, r2, #0x200
	ldrh r1, [r1]
	ldr ip, [r2, #0xaa4]
	mov r3, r1, lsr #0x1f
	rsb r2, r3, r1, lsl #28
	add r2, r3, r2, ror #28
	add r2, ip, r2, lsl #6
	bl ovl08_2173B7C
	bl ovl08_2173A8C
	ldr r0, _02173F9C // =0x0217E94C
	ldr r1, [r0]
	ldrb r0, [r1, #0xa90]
	cmp r0, #0x1b
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, [r1, #0x204]
	cmp r0, #0x1e0
	movhi r0, #0x1b
	strhib r0, [r1, #0xa90]
	addhi sp, sp, #4
	ldmhiia sp!, {pc}
	bl ovl08_2173A74
	cmp r0, #0x10
	beq _02173E90
	bl ovl08_2173A74
	cmp r0, #0x20
	bne _02173EAC
_02173E90:
	bl ovl08_2173A74
	ldr r0, _02173F9C // =0x0217E94C
	mov r1, #0xa
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_02173EAC:
	bl ovl08_2173A74
	cmp r0, #0x40
	ldreq r0, _02173F9C // =0x0217E94C
	moveq r1, #0xb
	ldreq r0, [r0]
	addeq sp, sp, #4
	streqb r1, [r0, #0xa90]
	ldmeqia sp!, {pc}
	bl ovl08_2173A74
	cmp r0, #0xff
	ldreq r0, _02173F9C // =0x0217E94C
	moveq r1, #0x1b
	ldreq r0, [r0]
	addeq sp, sp, #4
	streqb r1, [r0, #0xa90]
	ldmeqia sp!, {pc}
	bl ovl08_2173A74
	cmp r0, #0x50
	ldreq r0, _02173F9C // =0x0217E94C
	moveq r1, #0x15
	ldreq r0, [r0]
	addeq sp, sp, #4
	streqb r1, [r0, #0xa90]
	ldmeqia sp!, {pc}
	bl ovl08_2173A74
	cmp r0, #0x60
	ldreq r0, _02173F9C // =0x0217E94C
	moveq r1, #0x18
	ldreq r0, [r0]
	addeq sp, sp, #4
	streqb r1, [r0, #0xa90]
	ldmeqia sp!, {pc}
	bl ovl08_2173A74
	cmp r0, #0x70
	ldreq r0, _02173F9C // =0x0217E94C
	moveq r1, #0x1b
	ldreq r0, [r0]
	addeq sp, sp, #4
	streqb r1, [r0, #0xa90]
	ldmeqia sp!, {pc}
	bl ovl08_2173A74
	cmp r0, #0
	ldreq r0, _02173F9C // =0x0217E94C
	moveq r1, #8
	ldreq r0, [r0]
	addeq sp, sp, #4
	streqb r1, [r0, #0xa90]
	ldmeqia sp!, {pc}
	bl ovl08_2173A74
	cmp r0, #0xbd
	ldreq r0, _02173F9C // =0x0217E94C
	moveq r1, #9
	ldreq r0, [r0]
	streqb r1, [r0, #0xa90]
	ldrne r0, _02173F9C // =0x0217E94C
	movne r1, #0x1f
	ldrne r0, [r0]
	strneb r1, [r0, #0xa90]
_02173F94:
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02173F9C: .word 0x0217E94C
	arm_func_end ovl08_2173DB4

	arm_func_start ovl08_2173FA0
ovl08_2173FA0: // 0x02173FA0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2173CD8
	ldr r0, _02173FCC // =ovl08_2173D24
	bl ovl08_2172928
	ldr r0, _02173FD0 // =0x0217E94C
	mov r1, #8
	ldr r0, [r0]
	strb r1, [r0, #0xa90]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02173FCC: .word ovl08_2173D24
_02173FD0: .word 0x0217E94C
	arm_func_end ovl08_2173FA0

	arm_func_start ovl08_2173FD4
ovl08_2173FD4: // 0x02173FD4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2171B58
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _021741B0
_02173FEC: // jump table
	b _02174158 // case 0
	b _0217400C // case 1
	b _02174030 // case 2
	b _021740C8 // case 3
	b _021741B0 // case 4
	b _02174124 // case 5
	b _021741B0 // case 6
	b _0217413C // case 7
_0217400C:
	ldr r1, _021741B8 // =0x0217E94C
	ldr r0, _021741BC // =0x00000AB4
	ldr r2, [r1]
	add r1, r2, #0x600
	ldrh r1, [r1, #0x4a]
	add r0, r2, r0
	bl ovl08_21724B8
	add sp, sp, #4
	ldmia sp!, {pc}
_02174030:
	mov r0, #2
	bl ovl08_2171AFC
	cmp r0, #0
	ldrne r0, _021741B8 // =0x0217E94C
	movne r1, #5
	ldrne r0, [r0]
	addne sp, sp, #4
	strneb r1, [r0, #0xa90]
	ldmneia sp!, {pc}
	mov r0, #3
	bl ovl08_2171AFC
	cmp r0, #0
	bne _02174074
	mov r0, #4
	bl ovl08_2171AFC
	cmp r0, #0
	beq _0217408C
_02174074:
	ldr r0, _021741B8 // =0x0217E94C
	mov r1, #6
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_0217408C:
	ldr r0, _021741B8 // =0x0217E94C
	ldr r0, [r0]
	ldrb r0, [r0, #0xa90]
	cmp r0, #5
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #2
	bl ovl08_2171AFC
	cmp r0, #0
	ldreq r0, _021741B8 // =0x0217E94C
	moveq r1, #0xd
	ldreq r0, [r0]
	add sp, sp, #4
	streqb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_021740C8:
	bl ovl08_2172018
	cmp r0, #0
	beq _021740E0
	bl ovl08_2171F10
	add sp, sp, #4
	ldmia sp!, {pc}
_021740E0:
	ldr r0, _021741B8 // =0x0217E94C
	ldr r0, [r0]
	ldrb r0, [r0, #0xa90]
	add r0, r0, #0xfa
	and r0, r0, #0xff
	cmp r0, #1
	addhi sp, sp, #4
	ldmhiia sp!, {pc}
	mov r0, #3
	bl ovl08_2171AFC
	cmp r0, #0
	ldreq r0, _021741B8 // =0x0217E94C
	moveq r1, #0x12
	ldreq r0, [r0]
	add sp, sp, #4
	streqb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_02174124:
	ldr r0, _021741B8 // =0x0217E94C
	mov r1, #7
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_0217413C:
	bl ovl08_2171EF4
	ldr r0, _021741B8 // =0x0217E94C
	mov r1, #1
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_02174158:
	bl ovl08_217302C
	cmp r0, #0
	beq _02174188
	cmp r0, #1
	beq _0217417C
	cmp r0, #3
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	b _021741A0
_0217417C:
	bl ovl08_2172678
	add sp, sp, #4
	ldmia sp!, {pc}
_02174188:
	ldr r0, _021741B8 // =0x0217E94C
	mov r1, #0x1f
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_021741A0:
	ldr r0, _021741B8 // =0x0217E94C
	mov r1, #0x1f
	ldr r0, [r0]
	strb r1, [r0, #0xa90]
_021741B0:
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021741B8: .word 0x0217E94C
_021741BC: .word 0x00000AB4
	arm_func_end ovl08_2173FD4

	arm_func_start ovl08_21741C0
ovl08_21741C0: // 0x021741C0
	ldr r0, _021741DC // =0x0217E94C
	ldr ip, _021741E0 // =ovl08_2172510
	ldr r2, [r0]
	add r0, r2, #0x600
	ldrh r1, [r0, #0x48]
	ldr r0, [r2, #0xac8]
	bx ip
	.align 2, 0
_021741DC: .word 0x0217E94C
_021741E0: .word ovl08_2172510
	arm_func_end ovl08_21741C0

	arm_func_start ovl08_21741E4
ovl08_21741E4: // 0x021741E4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_217302C
	cmp r0, #9
	addls pc, pc, r0, lsl #2
	b _02174294
_021741FC: // jump table
	b _02174264 // case 0
	b _02174224 // case 1
	b _02174294 // case 2
	b _02174298 // case 3
	b _02174294 // case 4
	b _02174294 // case 5
	b _02174294 // case 6
	b _02174230 // case 7
	b _02174294 // case 8
	b _02174288 // case 9
_02174224:
	bl ovl08_2172F54
	add sp, sp, #4
	ldmia sp!, {pc}
_02174230:
	bl ovl08_2172D24
	ldr r2, _021742A0 // =0x0217E94C
	mov ip, #0
	ldr r1, [r2]
	mov r3, #3
	add r1, r1, #0x600
	strh r0, [r1, #0x4a]
	ldr r0, [r2]
	add sp, sp, #4
	str ip, [r0, #0xa98]
	ldr r0, [r2]
	strb r3, [r0, #0xa90]
	ldmia sp!, {pc}
_02174264:
	ldr r0, _021742A0 // =0x0217E94C
	mov r3, #0
	ldr r2, [r0]
	mov r1, #3
	str r3, [r2, #0xa98]
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_02174288:
	bl ovl08_2172824
	add sp, sp, #4
	ldmia sp!, {pc}
_02174294:
	bl OS_Terminate
_02174298:
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021742A0: .word 0x0217E94C
	arm_func_end ovl08_21741E4

	arm_func_start ovl08_21742A4
ovl08_21742A4: // 0x021742A4
	ldr ip, _021742B0 // =MB_CommGetChildUser
	mov r0, #1
	bx ip
	.align 2, 0
_021742B0: .word MB_CommGetChildUser
	arm_func_end ovl08_21742A4

	arm_func_start ovl08_21742B4
ovl08_21742B4: // 0x021742B4
	ldr r2, _021742F8 // =0x0217E94C
	ldr r3, [r2]
	ldrb r3, [r3, #0xa90]
	strb r3, [r0]
	ldr r0, [r2]
	ldrb r2, [r0, #0xa90]
	ldrb r0, [r0, #0xa91]
	cmp r2, r0
	movne r0, #1
	strneb r0, [r1]
	moveq r0, #0
	streqb r0, [r1]
	ldr r0, _021742F8 // =0x0217E94C
	ldr r1, [r0]
	ldrb r0, [r1, #0xa90]
	strb r0, [r1, #0xa91]
	bx lr
	.align 2, 0
_021742F8: .word 0x0217E94C
	arm_func_end ovl08_21742B4

	arm_func_start ovl08_21742FC
ovl08_21742FC: // 0x021742FC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0217470C // =0x0217E94C
	ldr r0, [r1]
	ldrb r2, [r0, #0xa90]
	cmp r2, #0x22
	addls pc, pc, r2, lsl #2
	b _02174704
_0217431C: // jump table
	b _02174704 // case 0
	b _021743A8 // case 1
	b _021743F0 // case 2
	b _021743FC // case 3
	b _02174418 // case 4
	b _02174430 // case 5
	b _02174430 // case 6
	b _0217443C // case 7
	b _02174448 // case 8
	b _02174448 // case 9
	b _02174448 // case 10
	b _02174454 // case 11
	b _02174704 // case 12
	b _02174704 // case 13
	b _02174704 // case 14
	b _02174704 // case 15
	b _02174460 // case 16
	b _0217447C // case 17
	b _021744A0 // case 18
	b _021744C8 // case 19
	b _02174704 // case 20
	b _0217450C // case 21
	b _02174534 // case 22
	b _02174704 // case 23
	b _02174578 // case 24
	b _021745A0 // case 25
	b _02174704 // case 26
	b _021745E4 // case 27
	b _0217460C // case 28
	b _02174704 // case 29
	b _02174700 // case 30
	b _02174704 // case 31
	b _02174694 // case 32
	b _021746BC // case 33
	b _02174704 // case 34
_021743A8:
	ldrb r2, [r0, #0xaac]
	cmp r2, #1
	bne _021743C8
	mov r1, #0
	strb r1, [r0, #0xaac]
	bl ovl08_2174758
	add sp, sp, #4
	ldmia sp!, {pc}
_021743C8:
	cmp r2, #2
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r2, #0
	strb r2, [r0, #0xaac]
	ldr r0, [r1]
	mov r1, #0x22
	strb r1, [r0, #0xa90]
	add sp, sp, #4
	ldmia sp!, {pc}
_021743F0:
	bl ovl08_21741E4
	add sp, sp, #4
	ldmia sp!, {pc}
_021743FC:
	bl ovl08_21741C0
	ldr r0, _0217470C // =0x0217E94C
	mov r1, #4
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_02174418:
	ldr r1, [r0, #0xa98]
	add r1, r1, #1
	str r1, [r0, #0xa98]
	bl ovl08_2173FD4
	add sp, sp, #4
	ldmia sp!, {pc}
_02174430:
	bl ovl08_2173FD4
	add sp, sp, #4
	ldmia sp!, {pc}
_0217443C:
	bl ovl08_2173FA0
	add sp, sp, #4
	ldmia sp!, {pc}
_02174448:
	bl ovl08_2173DB4
	add sp, sp, #4
	ldmia sp!, {pc}
_02174454:
	bl ovl08_2173D9C
	add sp, sp, #4
	ldmia sp!, {pc}
_02174460:
	mov r2, #0
	str r2, [r0, #0xa9c]
	ldr r0, [r1]
	mov r1, #0x11
	strb r1, [r0, #0xa90]
	add sp, sp, #4
	ldmia sp!, {pc}
_0217447C:
	ldr r2, [r0, #0xa9c]
	add r1, r2, #1
	cmp r2, #0x1e
	str r1, [r0, #0xa9c]
	addls sp, sp, #4
	ldmlsia sp!, {pc}
	bl ovl08_2173D60
	add sp, sp, #4
	ldmia sp!, {pc}
_021744A0:
	bl MB_EndToIdle
	ldr r0, _0217470C // =0x0217E94C
	mov r3, #0
	ldr r2, [r0]
	mov r1, #0x16
	str r3, [r2, #0xa9c]
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_021744C8:
	ldr r2, [r0, #0xa9c]
	add r1, r2, #1
	cmp r2, #0x1e
	str r1, [r0, #0xa9c]
	addls sp, sp, #4
	ldmlsia sp!, {pc}
	bl ovl08_217302C
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_2172678
	ldr r0, _0217470C // =0x0217E94C
	mov r1, #0x14
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_0217450C:
	bl ovl08_21726D4
	ldr r0, _0217470C // =0x0217E94C
	mov r3, #0
	ldr r2, [r0]
	mov r1, #0x16
	str r3, [r2, #0xa9c]
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_02174534:
	ldr r2, [r0, #0xa9c]
	add r1, r2, #1
	cmp r2, #0x1e
	str r1, [r0, #0xa9c]
	addls sp, sp, #4
	ldmlsia sp!, {pc}
	bl ovl08_217302C
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_2172678
	ldr r0, _0217470C // =0x0217E94C
	mov r1, #0x17
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_02174578:
	bl ovl08_21726D4
	ldr r0, _0217470C // =0x0217E94C
	mov r3, #0
	ldr r2, [r0]
	mov r1, #0x19
	str r3, [r2, #0xa9c]
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_021745A0:
	ldr r2, [r0, #0xa9c]
	add r1, r2, #1
	cmp r2, #0x1e
	str r1, [r0, #0xa9c]
	addls sp, sp, #4
	ldmlsia sp!, {pc}
	bl ovl08_217302C
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_2172678
	ldr r0, _0217470C // =0x0217E94C
	mov r1, #0x1a
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_021745E4:
	bl ovl08_21726D4
	ldr r0, _0217470C // =0x0217E94C
	mov r3, #0
	ldr r2, [r0]
	mov r1, #0x1c
	str r3, [r2, #0xa9c]
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_0217460C:
	ldr r2, [r0, #0xa9c]
	add r1, r2, #1
	cmp r2, #0x1e
	str r1, [r0, #0xa9c]
	addls sp, sp, #4
	ldmlsia sp!, {pc}
	bl ovl08_217302C
	cmp r0, #1
	bne _0217464C
	bl ovl08_2172678
	ldr r0, _0217470C // =0x0217E94C
	mov r1, #0x1d
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_0217464C:
	ldr r1, _0217470C // =0x0217E94C
	ldr r0, _02174710 // =0x88888889
	ldr r1, [r1]
	ldr r2, _02174714 // =0x0000001E
	ldr r3, [r1, #0xa9c]
	umull r0, r1, r3, r0
	mov r1, r1, lsr #4
	umull r0, r1, r2, r1
	sub r1, r3, r0
	cmp r1, #1
	addne sp, sp, #4
	ldmneia sp!, {pc}
	cmp r3, #0x37
	addls sp, sp, #4
	ldmlsia sp!, {pc}
	bl ovl08_21726D4
	add sp, sp, #4
	ldmia sp!, {pc}
_02174694:
	bl ovl08_21726D4
	ldr r0, _0217470C // =0x0217E94C
	mov r3, #0
	ldr r2, [r0]
	mov r1, #0x21
	str r3, [r2, #0xa9c]
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_021746BC:
	ldr r2, [r0, #0xa9c]
	add r1, r2, #1
	cmp r2, #0x1e
	str r1, [r0, #0xa9c]
	addls sp, sp, #4
	ldmlsia sp!, {pc}
	bl ovl08_217302C
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl ovl08_2172678
	ldr r0, _0217470C // =0x0217E94C
	mov r1, #0x22
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xa90]
	ldmia sp!, {pc}
_02174700:
	bl ovl08_21726D4
_02174704:
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0217470C: .word 0x0217E94C
_02174710: .word 0x88888889
_02174714: .word 0x0000001E
	arm_func_end ovl08_21742FC

	arm_func_start ovl08_2174718
ovl08_2174718: // 0x02174718
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02174754 // =0x0217E94C
	ldr r1, [r0]
	ldrb r0, [r1, #0xa90]
	cmp r0, #5
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
	mov r0, #6
	strb r0, [r1, #0xa90]
	bl ovl08_2172084
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02174754: .word 0x0217E94C
	arm_func_end ovl08_2174718

	arm_func_start ovl08_2174758
ovl08_2174758: // 0x02174758
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021747B4 // =0x0217E94C
	ldr r0, [r0]
	ldrb r0, [r0, #0xa90]
	cmp r0, #1
	beq _02174784
	cmp r0, #0x1a
	beq _02174784
	cmp r0, #0x1d
	bne _021747A8
_02174784:
	bl ovl08_21747B8
	bl ovl08_2172BAC
	ldr r0, _021747B4 // =0x0217E94C
	mov r2, #2
	ldr r1, [r0]
	add sp, sp, #4
	strb r2, [r1, #0xa90]
	mov r0, #1
	ldmia sp!, {pc}
_021747A8:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021747B4: .word 0x0217E94C
	arm_func_end ovl08_2174758

	arm_func_start ovl08_21747B8
ovl08_21747B8: // 0x021747B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0217483C // =0x0217E94C
	ldr r0, [r0]
	ldr r0, [r0, #0xac8]
	bl ovl08_2173054
	ldr r0, _0217483C // =0x0217E94C
	mov r1, #1
	ldr r0, [r0]
	strb r1, [r0, #0xa90]
	bl WM_GetNextTgid
	ldr r3, _0217483C // =0x0217E94C
	mov r2, #0x40
	ldr r1, [r3]
	add r1, r1, #0x600
	strh r0, [r1, #0x48]
	ldr r1, [r3]
	ldr r0, [r1, #0xaa4]
	add r1, r1, #0xa50
	bl MI_CpuCopy8
	ldr r0, _0217483C // =0x0217E94C
	mov r2, #0
	ldr r1, [r0]
	strb r2, [r1, #0xa93]
	ldr r1, [r0]
	str r2, [r1, #0x204]
	ldr r0, [r0]
	add r0, r0, #0x600
	ldrh r1, [r0, #0x48]
	add r1, r1, #1
	strh r1, [r0, #0x48]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0217483C: .word 0x0217E94C
	arm_func_end ovl08_21747B8

	arm_func_start ovl08_2174840
ovl08_2174840: // 0x02174840
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02174954 // =0x0217E94C
	ldr r2, [r0]
	ldrb r1, [r2, #0xa90]
	cmp r1, #1
	beq _0217487C
	cmp r1, #0x14
	beq _0217487C
	cmp r1, #0x17
	beq _0217487C
	cmp r1, #0x1a
	beq _0217487C
	cmp r1, #0x1d
	bne _021748A0
_0217487C:
	mov r1, #0x22
	strb r1, [r2, #0xa90]
	ldr r0, _02174954 // =0x0217E94C
	mov r1, #0
	ldr r0, [r0]
	add sp, sp, #4
	strb r1, [r0, #0xaac]
	mov r0, #1
	ldmia sp!, {pc}
_021748A0:
	cmp r1, #4
	beq _021748C0
	cmp r1, #5
	beq _021748C0
	cmp r1, #6
	beq _021748C0
	cmp r1, #0xd
	bne _02174908
_021748C0:
	cmp r1, #4
	bne _021748DC
	ldr r0, [r2, #0xa98]
	cmp r0, #6
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {pc}
_021748DC:
	bl MB_EndToIdle
	ldr r0, _02174954 // =0x0217E94C
	mov r3, #0x10
	ldr r1, [r0]
	mov r2, #2
	strb r3, [r1, #0xa90]
	ldr r1, [r0]
	add sp, sp, #4
	strb r2, [r1, #0xaac]
	mov r0, #1
	ldmia sp!, {pc}
_02174908:
	add r0, r1, #0xf7
	and r0, r0, #0xff
	cmp r0, #1
	movls r0, #0x20
	strlsb r0, [r2, #0xa90]
	addls sp, sp, #4
	movls r0, #1
	ldmlsia sp!, {pc}
	cmp r1, #0xc
	moveq r0, #0x22
	streqb r0, [r2, #0xa90]
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	cmp r1, #2
	moveq r0, #0
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02174954: .word 0x0217E94C
	arm_func_end ovl08_2174840

	arm_func_start ovl08_2174958
ovl08_2174958: // 0x02174958
	stmdb sp!, {r4, lr}
	ldr r2, _02174A44 // =0x0217E94C
	mov r4, r1
	str r0, [r2]
	add r0, r0, #0xb00
	bl ovl08_217262C
	ldr r1, _02174A44 // =0x0217E94C
	mov r3, #0
	ldr r0, [r1]
	mov r2, #1
	add r0, r0, #0x600
	strh r3, [r0, #0x48]
	ldr r0, [r1]
	add r0, r0, #0x600
	strh r3, [r0, #0x4a]
	ldr r0, [r1]
	strb r2, [r0, #0xa90]
	ldr r0, [r1]
	strb r2, [r0, #0xa91]
	ldr r0, [r1]
	str r3, [r0, #0xa9c]
	bl ovl08_2173CD8
	ldr r0, _02174A44 // =0x0217E94C
	ldr r3, [r4]
	ldr r2, [r0]
	mov r1, #2
	str r3, [r2, #0xab4]
	ldr r3, [r4, #4]
	ldr r2, [r0]
	str r3, [r2, #0xab8]
	ldr r3, [r4, #8]
	ldr r2, [r0]
	str r3, [r2, #0xabc]
	ldr r3, [r4, #0xc]
	ldr r2, [r0]
	str r3, [r2, #0xac0]
	ldr r3, [r4, #0x10]
	ldr r2, [r0]
	str r3, [r2, #0xac4]
	ldr r3, [r4, #0x14]
	ldr r2, [r0]
	str r3, [r2, #0xac8]
	ldrb r3, [r4, #0x18]
	ldr r2, [r0]
	strb r3, [r2, #0xa92]
	ldr r0, [r0]
	strb r1, [r0, #0xacc]
	bl OS_GetTick
	ldr r1, _02174A44 // =0x0217E94C
	ldr r0, _02174A48 // =0x0000064C
	ldr r1, [r1]
	add r0, r1, r0
	bl sub_208DEF0
	bl OS_GetTick
	bl ovl08_216EFE4
	ldr r1, _02174A44 // =0x0217E94C
	ldr r1, [r1]
	str r0, [r1, #0xaa4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02174A44: .word 0x0217E94C
_02174A48: .word 0x0000064C
	arm_func_end ovl08_2174958

	arm_func_start ovl08_2174A4C
ovl08_2174A4C: // 0x02174A4C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r1
	mov r7, r0
	mov r5, r2
	bl strlen
	mov r4, r0
	mov r0, r6
	bl strlen
	cmp r4, r5
	blt _02174A80
	cmp r0, r5
	bge _02174A8C
_02174A80:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_02174A8C:
	sub r1, r0, r5
	sub r3, r4, r5
	mov r2, r5
	add r0, r7, r3
	add r1, r6, r1
	bl memcmp
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end ovl08_2174A4C

	arm_func_start ovl08_2174AB8
ovl08_2174AB8: // 0x02174AB8
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {lr}
	sub sp, sp, #4
	add r0, sp, #8
	bl ovl08_2176714
	ldr r0, _02174AF0 // =0x0217E950
	ldr r1, [sp, #8]
	ldr r0, [r0]
	ldr r0, [r0, #0x84]
	bl ovl08_21756E0
	add sp, sp, #4
	ldmia sp!, {lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02174AF0: .word 0x0217E950
	arm_func_end ovl08_2174AB8

	arm_func_start ovl08_2174AF4
ovl08_2174AF4: // 0x02174AF4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x4c
	ldr r3, _02174BE0 // =0x0217E950
	mov r6, r0
	ldr r0, [r3]
	mov r5, r1
	ldr r0, [r0, #0x84]
	mov r4, r2
	bl ovl08_2175688
	add r0, sp, #4
	bl FS_InitFile
	add r0, sp, #4
	mov r1, r6
	bl FS_OpenFile
	cmp r0, #0
	bne _02174B38
	bl OS_Terminate
_02174B38:
	ldr r1, [sp, #0x2c]
	ldr r0, [sp, #0x28]
	mov r2, #2
	sub r7, r1, r0
	cmp r5, #0
	ldr r1, _02174BE4 // =0x0217C270
	mov r0, r6
	strne r7, [r5]
	bl ovl08_2174A4C
	cmp r0, #0
	mvnne r6, #3
	moveq r6, r4
	mov r0, r7
	mov r1, r6
	bl ovl08_2176788
	mov r1, r0
	add r0, sp, #4
	mov r2, r7
	str r1, [sp]
	bl FS_ReadFile
	add r0, sp, #4
	bl FS_CloseFile
	cmp r6, #0
	ldrgt r0, [sp]
	addgt sp, sp, #0x4c
	ldmgtia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [sp]
	cmp r5, #0
	ldr r0, [r0]
	mov r1, r4
	mov r0, r0, lsr #8
	strne r0, [r5]
	bl ovl08_2176788
	mov r4, r0
	ldr r0, [sp]
	mov r1, r4
	bl MI_UncompressLZ8
	add r0, sp, #0
	bl ovl08_2176714
	mov r0, r4
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02174BE0: .word 0x0217E950
_02174BE4: .word 0x0217C270
	arm_func_end ovl08_2174AF4

	arm_func_start ovl08_2174BE8
ovl08_2174BE8: // 0x02174BE8
	mov r0, #1
	bx lr
	arm_func_end ovl08_2174BE8

	arm_func_start ovl08_2174BF0
ovl08_2174BF0: // 0x02174BF0
	ldr ip, _02174BFC // =FS_NotifyArchiveAsyncEnd
	mov r1, #0
	bx ip
	.align 2, 0
_02174BFC: .word FS_NotifyArchiveAsyncEnd
	arm_func_end ovl08_2174BF0

	arm_func_start ovl08_2174C00
ovl08_2174C00: // 0x02174C00
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr ip, _02174C40 // =ovl08_2174BF0
	str ip, [sp]
	str r0, [sp, #4]
	mov ip, #1
	str ip, [sp, #8]
	ldr r0, [r0, #0x28]
	mov ip, r1
	add r1, r2, r0
	mov r2, ip
	mvn r0, #0
	bl CARDi_ReadRom
	mov r0, #6
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_02174C40: .word ovl08_2174BF0
	arm_func_end ovl08_2174C00

	arm_func_start ovl08_2174C44
ovl08_2174C44: // 0x02174C44
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #1
	beq _02174CA0
	cmp r1, #9
	beq _02174C68
	cmp r1, #0xa
	beq _02174C84
	b _02174CAC
_02174C68:
	ldr r0, _02174CB8 // =0x0217E950
	ldr r0, [r0]
	ldrh r0, [r0, #0xe4]
	bl CARD_LockRom
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_02174C84:
	ldr r0, _02174CB8 // =0x0217E950
	ldr r0, [r0]
	ldrh r0, [r0, #0xe4]
	bl CARD_UnlockRom
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_02174CA0:
	add sp, sp, #4
	mov r0, #4
	ldmia sp!, {pc}
_02174CAC:
	mov r0, #8
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02174CB8: .word 0x0217E950
	arm_func_end ovl08_2174C44

	arm_func_start ovl08_2174CBC
ovl08_2174CBC: // 0x02174CBC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02174D40 // =aRom_0
	bl FS_ChangeDir
	ldr r0, _02174D44 // =0x0217E950
	ldr r0, [r0]
	add r0, r0, #0x88
	bl FS_UnloadArchiveTables
	ldr r0, _02174D44 // =0x0217E950
	ldr r0, [r0]
	add r0, r0, #0x88
	bl FS_UnloadArchive
	ldr r0, _02174D44 // =0x0217E950
	ldr r0, [r0]
	add r0, r0, #0x88
	bl FS_ReleaseArchiveName
	ldr r0, _02174D44 // =0x0217E950
	ldr r0, [r0]
	ldrh r0, [r0, #0xe4]
	bl OS_ReleaseLockID
	ldr r0, _02174D44 // =0x0217E950
	mov r2, #0
	ldr r1, [r0]
	strh r2, [r1, #0xe4]
	ldr r0, [r0]
	bl ovl08_2176714
	ldr r0, _02174D44 // =0x0217E950
	mov r2, #0
	ldr r1, [r0]
	str r2, [r1]
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02174D40: .word aRom_0
_02174D44: .word 0x0217E950
	arm_func_end ovl08_2174CBC

	arm_func_start ovl08_2174D48
ovl08_2174D48: // 0x02174D48
	stmdb sp!, {r4, lr}
	sub sp, sp, #0xe8
	mov r0, #0xe8
	mov r1, #4
	bl ovl08_2176764
	ldr r1, _02174ED8 // =0x0217E950
	str r0, [r1]
	add r0, sp, #0x20
	bl FS_InitFile
	ldr r1, _02174EDC // =aRomDwcUtilityB
	add r0, sp, #0x20
	bl FS_OpenFile
	cmp r0, #0
	bne _02174D84
	bl OS_Terminate
_02174D84:
	bl OS_GetLockID
	ldr r2, _02174ED8 // =0x0217E950
	add r1, sp, #0x10
	ldr r3, [r2]
	mov r2, #8
	strh r0, [r3, #0xe4]
	add r0, sp, #0x20
	ldr r4, [sp, #0x44]
	bl FS_ReadFile
	add r0, sp, #0x20
	add r1, sp, #0x18
	mov r2, #8
	bl FS_ReadFile
	add r0, sp, #0x20
	bl FS_CloseFile
	ldr r0, _02174ED8 // =0x0217E950
	ldr r0, [r0]
	add r0, r0, #0x88
	bl FS_InitArchive
	ldr r0, _02174ED8 // =0x0217E950
	ldr r1, _02174EE0 // =0x0217B008
	ldr r0, [r0]
	mov r2, #3
	add r0, r0, #0x88
	bl FS_RegisterArchiveName
	cmp r0, #0
	bne _02174DF4
	bl OS_Terminate
_02174DF4:
	ldr r0, _02174ED8 // =0x0217E950
	ldr r1, _02174EE4 // =ovl08_2174C44
	ldr r0, [r0]
	ldr r2, _02174EE8 // =0x00000602
	add r0, r0, #0x88
	bl FS_SetArchiveProc
	ldr r0, [sp, #0x10]
	ldr r1, _02174EEC // =ovl08_2174C00
	str r0, [sp]
	ldr r2, [sp, #0x14]
	ldr r0, _02174EF0 // =ovl08_2174BE8
	str r2, [sp, #4]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	ldr r0, _02174ED8 // =0x0217E950
	ldr r2, [sp, #0x18]
	ldr r0, [r0]
	ldr r3, [sp, #0x1c]
	mov r1, r4
	add r0, r0, #0x88
	bl FS_LoadArchive
	cmp r0, #0
	bne _02174E54
	bl OS_Terminate
_02174E54:
	ldr r0, _02174ED8 // =0x0217E950
	mov r1, #0
	ldr r0, [r0]
	mov r2, r1
	add r0, r0, #0x88
	bl FS_LoadArchiveTables
	mov r1, #4
	mov r4, r0
	bl ovl08_2176788
	ldr r1, _02174ED8 // =0x0217E950
	mov r2, r4
	ldr r3, [r1]
	str r0, [r3]
	ldr r0, [r1]
	ldr r1, [r0], #0x88
	bl FS_LoadArchiveTables
	ldr r1, _02174ED8 // =0x0217E950
	mov r0, #0x20
	ldr r1, [r1]
	mov r2, #4
	add r1, r1, #4
	bl ovl08_2175764
	ldr r2, _02174ED8 // =0x0217E950
	ldr r1, _02174EF4 // =0x0217C294
	ldr r3, [r2]
	ldr r2, _02174EE0 // =0x0217B008
	str r0, [r3, #0x84]
	add r0, sp, #0x68
	bl OS_SPrintf
	add r0, sp, #0x68
	bl FS_ChangeDir
	add sp, sp, #0xe8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02174ED8: .word 0x0217E950
_02174EDC: .word aRomDwcUtilityB
_02174EE0: .word 0x0217B008
_02174EE4: .word ovl08_2174C44
_02174EE8: .word 0x00000602
_02174EEC: .word ovl08_2174C00
_02174EF0: .word ovl08_2174BE8
_02174EF4: .word 0x0217C294
	arm_func_end ovl08_2174D48

	arm_func_start ovl08_2174EF8
ovl08_2174EF8: // 0x02174EF8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr lr, [r0, #8]
	ldr r0, _02174F2C // =0x01FF0000
	ldr ip, [lr, r1, lsl #3]
	and r0, ip, r0
	mov r0, r0, lsr #0x10
	str r0, [r2]
	ldr r0, [lr, r1, lsl #3]
	and r0, r0, #0xff
	str r0, [r3]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02174F2C: .word 0x01FF0000
	arm_func_end ovl08_2174EF8

	arm_func_start ovl08_2174F30
ovl08_2174F30: // 0x02174F30
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #0
	ldr lr, [r0, #8]
	blt _02174F60
	add r1, lr, r1, lsl #3
	ldrh r0, [r1, #4]
	add sp, sp, #4
	bic r0, r0, #0xc00
	orr r0, r0, r2, lsl #10
	strh r0, [r1, #4]
	ldmia sp!, {pc}
_02174F60:
	ldrb r1, [r0, #0xc]
	mov ip, #0
	cmp r1, #0
	addle sp, sp, #4
	ldmleia sp!, {pc}
	mov r3, r2, lsl #0xa
_02174F78:
	add r2, lr, ip, lsl #3
	ldrh r1, [r2, #4]
	add ip, ip, #1
	bic r1, r1, #0xc00
	orr r1, r1, r3
	strh r1, [r2, #4]
	ldrb r1, [r0, #0xc]
	cmp ip, r1
	blt _02174F78
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2174F30

	arm_func_start ovl08_2174FA4
ovl08_2174FA4: // 0x02174FA4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	cmp r1, #0
	ldr ip, [r0, #8]
	blt _02174FE4
	ldr r5, [ip, r1, lsl #3]
	ldr r4, _021750A4 // =0xFE00FF00
	ldr r0, _021750A8 // =0x000001FF
	and r4, r5, r4
	and r3, r3, #0xff
	and r2, r2, r0
	orr r0, r4, r3
	orr r0, r0, r2, lsl #16
	str r0, [ip, r1, lsl #3]
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02174FE4:
	ldr r1, [ip]
	ldr lr, _021750AC // =0x01FF0000
	ldr r4, _021750A8 // =0x000001FF
	and r1, r1, lr
	mov r1, r1, lsr #0x10
	str r1, [sp]
	ldr r1, [ip]
	ldr r5, _021750A4 // =0xFE00FF00
	and r1, r1, #0xff
	str r1, [sp, #4]
	ldr r6, [ip]
	and r1, r3, #0xff
	and r6, r6, r5
	and r7, r2, r4
	orr r1, r6, r1
	orr r1, r1, r7, lsl #16
	str r1, [ip]
	ldrb r1, [r0, #0xc]
	ldr r7, [sp]
	ldr r6, [sp, #4]
	cmp r1, #1
	sub r1, r3, r6
	addle sp, sp, #0x10
	sub r2, r2, r7
	mov r3, #1
	ldmleia sp!, {r4, r5, r6, r7, r8, pc}
_0217504C:
	ldr r6, [ip, r3, lsl #3]
	and r7, r6, lr
	mov r6, r7, lsr #0x10
	str r6, [sp, #8]
	ldr r6, [ip, r3, lsl #3]
	add r8, r2, r7, lsr #16
	and r6, r6, #0xff
	str r6, [sp, #0xc]
	ldr r7, [ip, r3, lsl #3]
	add r6, r6, r1
	and r7, r7, r5
	and r6, r6, #0xff
	and r8, r8, r4
	orr r6, r7, r6
	orr r6, r6, r8, lsl #16
	str r6, [ip, r3, lsl #3]
	ldrb r6, [r0, #0xc]
	add r3, r3, #1
	cmp r3, r6
	blt _0217504C
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021750A4: .word 0xFE00FF00
_021750A8: .word 0x000001FF
_021750AC: .word 0x01FF0000
	arm_func_end ovl08_2174FA4

	arm_func_start ovl08_21750B0
ovl08_21750B0: // 0x021750B0
	stmdb sp!, {r4, lr}
	cmp r1, #0
	ldr ip, [r0, #8]
	blt _021750E8
	ldr r0, [ip, r1, lsl #3]
	add lr, ip, r1, lsl #3
	bic r0, r0, #0xc00
	orr r0, r0, r2, lsl #10
	str r0, [ip, r1, lsl #3]
	ldrh r0, [lr, #4]
	bic r0, r0, #0xf000
	orr r0, r0, r3, lsl #12
	strh r0, [lr, #4]
	ldmia sp!, {r4, pc}
_021750E8:
	ldrb lr, [r0, #0xc]
	mov r1, #0
	cmp lr, #0
	ldmleia sp!, {r4, pc}
	mov r4, r2, lsl #0xa
	mov lr, r3, lsl #0xc
_02175100:
	ldr r2, [ip, r1, lsl #3]
	add r3, ip, r1, lsl #3
	bic r2, r2, #0xc00
	orr r2, r2, r4
	str r2, [ip, r1, lsl #3]
	ldrh r2, [r3, #4]
	add r1, r1, #1
	bic r2, r2, #0xf000
	orr r2, r2, lr
	strh r2, [r3, #4]
	ldrb r2, [r0, #0xc]
	cmp r1, r2
	blt _02175100
	ldmia sp!, {r4, pc}
	arm_func_end ovl08_21750B0

	arm_func_start ovl08_2175138
ovl08_2175138: // 0x02175138
	stmdb sp!, {r4, lr}
	cmp r1, #0
	ldr ip, [r0, #8]
	blt _0217518C
	cmp r2, #0x100
	beq _02175170
	cmp r2, #0x300
	beq _02175170
	ldr r3, [ip, r1, lsl #3]
	ldr r0, _021751EC // =0xC1FFFCFF
	and r0, r3, r0
	orr r0, r0, r2
	str r0, [ip, r1, lsl #3]
	ldmia sp!, {r4, pc}
_02175170:
	ldr lr, [ip, r1, lsl #3]
	ldr r0, _021751EC // =0xC1FFFCFF
	and r0, lr, r0
	orr r0, r0, r2
	orr r0, r0, r3, lsl #25
	str r0, [ip, r1, lsl #3]
	ldmia sp!, {r4, pc}
_0217518C:
	ldrb lr, [r0, #0xc]
	mov r1, #0
	cmp lr, #0
	ldmleia sp!, {r4, pc}
	mov r4, r3, lsl #0x19
	ldr r3, _021751EC // =0xC1FFFCFF
_021751A4:
	cmp r2, #0x100
	beq _021751C4
	cmp r2, #0x300
	ldrne lr, [ip, r1, lsl #3]
	andne lr, lr, r3
	orrne lr, lr, r2
	strne lr, [ip, r1, lsl #3]
	bne _021751D8
_021751C4:
	ldr lr, [ip, r1, lsl #3]
	and lr, lr, r3
	orr lr, lr, r2
	orr lr, r4, lr
	str lr, [ip, r1, lsl #3]
_021751D8:
	ldrb lr, [r0, #0xc]
	add r1, r1, #1
	cmp r1, lr
	blt _021751A4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021751EC: .word 0xC1FFFCFF
	arm_func_end ovl08_2175138

	arm_func_start ovl08_21751F0
ovl08_21751F0: // 0x021751F0
	ldrb r0, [r0, #0xc]
	bx lr
	arm_func_end ovl08_21751F0

	arm_func_start ovl08_21751F8
ovl08_21751F8: // 0x021751F8
	ldr r0, [r0, #8]
	add r0, r0, r1, lsl #3
	bx lr
	arm_func_end ovl08_21751F8

	arm_func_start ovl08_2175204
ovl08_2175204: // 0x02175204
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldrb r0, [r5, #0xc]
	mov r4, #0
	mov r2, r4
	cmp r0, #0
	ldr r3, [r5, #8]
	ble _02175250
	ldr r0, _02175288 // =0xC1FFFCFF
_0217522C:
	ldr r1, [r3]
	add r2, r2, #1
	and r1, r1, r0
	orr r1, r1, #0x200
	str r1, [r3]
	ldrb r1, [r5, #0xc]
	add r3, r3, #8
	cmp r2, r1
	blt _0217522C
_02175250:
	mov r0, r5
	bl ovl08_2177048
	ldr r0, _0217528C // =0x0217E954
	ldr r1, [r0]
	add r0, r1, #0x228
	cmp r5, r0
	movhs r4, #1
	mov r0, #0x228
	mla r0, r4, r0, r1
	ldr r0, [r0, #0x224]
	mov r1, r5
	bl ovl08_21756E0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02175288: .word 0xC1FFFCFF
_0217528C: .word 0x0217E954
	arm_func_end ovl08_2175204

	arm_func_start ovl08_2175290
ovl08_2175290: // 0x02175290
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	mov r0, #0x228
	mul r7, r9, r0
	ldr r0, _02175400 // =0x0217E954
	mov r5, r1
	ldr r0, [r0]
	mov r6, r2
	add r0, r0, r7
	ldr r0, [r0, #0x224]
	bl ovl08_2175688
	mov r4, r0
	mov r0, #1
	bl OS_DisableIrqMask
	mov r8, r0
	cmp r6, #0
	beq _02175360
	ldr r1, _02175400 // =0x0217E954
	mov r0, #0x228
	ldr r2, [r1]
	mla r0, r9, r0, r2
	add r6, r0, #0x200
	add r0, r0, #0x210
	cmp r6, r0
	beq _02175340
	mov r1, r5, lsl #3
	add r0, r2, r7
	add r2, r0, #0x210
_02175304:
	ldrb r9, [r6, #0xc]
	ldr r0, [r6, #4]
	ldr ip, [r6, #8]
	ldr r3, [r0, #8]
	add ip, ip, r9, lsl #3
	add r9, ip, r1
	cmp r9, r3
	bhi _02175334
	mov r1, r4
	str ip, [r4, #8]
	bl ovl08_217700C
	b _02175340
_02175334:
	mov r6, r0
	cmp r0, r2
	bne _02175304
_02175340:
	ldr r0, _02175400 // =0x0217E954
	ldr r0, [r0]
	add r0, r0, r7
	add r0, r0, #0x210
	cmp r6, r0
	bne _021753E8
	bl OS_Terminate
	b _021753E8
_02175360:
	ldr r1, _02175400 // =0x0217E954
	mov r0, #0x228
	ldr r1, [r1]
	mla r0, r9, r0, r1
	add r6, r0, #0x210
	add r0, r0, #0x200
	cmp r6, r0
	beq _021753CC
	mov r0, r5, lsl #3
	add r1, r1, r7
	add r1, r1, #0x200
_0217538C:
	ldr ip, [r6]
	ldr r9, [r6, #8]
	ldrb r2, [ip, #0xc]
	ldr r3, [ip, #8]
	sub r9, r9, r0
	add r2, r3, r2, lsl #3
	cmp r9, r2
	blo _021753C0
	mov r0, r6
	mov r1, r4
	str r9, [r4, #8]
	bl ovl08_217700C
	b _021753CC
_021753C0:
	mov r6, ip
	cmp ip, r1
	bne _0217538C
_021753CC:
	ldr r0, _02175400 // =0x0217E954
	ldr r0, [r0]
	add r0, r0, r7
	add r0, r0, #0x200
	cmp r6, r0
	bne _021753E8
	bl OS_Terminate
_021753E8:
	mov r0, r8
	bl OS_EnableIrqMask
	mov r0, r4
	strb r5, [r4, #0xc]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02175400: .word 0x0217E954
	arm_func_end ovl08_2175290

	arm_func_start ovl08_2175404
ovl08_2175404: // 0x02175404
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, #0
	mov r5, r6
	ldr r4, _02175450 // =0x0217E954
_02175414:
	ldr r0, [r4]
	add r0, r0, r5
	ldr r0, [r0, #0x220]
	bl ovl08_2177088
	ldr r0, [r4]
	add r0, r0, r5
	ldr r0, [r0, #0x224]
	bl ovl08_2175740
	add r6, r6, #1
	cmp r6, #2
	add r5, r5, #0x228
	blt _02175414
	ldr r0, _02175450 // =0x0217E954
	bl ovl08_2176714
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02175450: .word 0x0217E954
	arm_func_end ovl08_2175404

	arm_func_start ovl08_2175454
ovl08_2175454: // 0x02175454
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r0, #0x450
	mov r1, #4
	bl ovl08_2176764
	ldr r10, _02175524 // =0x0217E954
	mov r9, #0
	mov r8, r9
	str r0, [r10]
	mov r7, #0x20
	mov r6, #0x10
	mov r5, #0x40
	mov r4, #0x7f
_02175484:
	ldr r1, [r10]
	mov r0, r7
	mov r2, r6
	add r1, r1, r8
	bl ovl08_2175764
	ldr r1, [r10]
	add r1, r1, r8
	str r0, [r1, #0x224]
	bl ovl08_21770AC
	ldr r2, [r10]
	mov r1, r5
	add r2, r2, r8
	str r0, [r2, #0x220]
	mov r0, r9
	bl ovl08_21770E0
	ldr r2, [r10]
	mov r1, r4
	add r2, r2, r8
	str r0, [r2, #0x208]
	mov r0, r9
	bl ovl08_21770E0
	add r1, r0, #8
	ldr r0, [r10]
	add r0, r0, r8
	str r1, [r0, #0x218]
	ldr r0, [r10]
	add r1, r0, r8
	ldr r0, [r1, #0x220]
	add r1, r1, #0x200
	bl ovl08_2176FEC
	ldr r0, [r10]
	add r1, r0, r8
	ldr r0, [r1, #0x220]
	add r1, r1, #0x210
	bl ovl08_2176FFC
	add r8, r8, #0x228
	add r9, r9, #1
	cmp r9, #2
	blt _02175484
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02175524: .word 0x0217E954
	arm_func_end ovl08_2175454

	arm_func_start ovl08_2175528
ovl08_2175528: // 0x02175528
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, _0217556C // =0x0217E958
	mov r6, r0
	mov r5, r1
	ldr r3, [r3, r6, lsl #2]
	mov r1, r5, lsl #3
	ldrh r1, [r3, r1]
	bl ovl08_2175290
	mov r1, #0
	mov r4, r0
	bl ovl08_21751F8
	mov r2, r0
	mov r0, r6
	mov r1, r5
	bl ovl08_217559C
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0217556C: .word 0x0217E958
	arm_func_end ovl08_2175528

	arm_func_start ovl08_2175570
ovl08_2175570: // 0x02175570
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl ovl08_2177144
	mov r4, r0
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl ovl08_217559C
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl08_2175570

	arm_func_start ovl08_217559C
ovl08_217559C: // 0x0217559C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	ldr r3, _0217562C // =0x0217E958
	mov r5, r2
	ldr r6, [r3, r0, lsl #2]
	mov r2, r1, lsl #3
	add r0, r6, r1, lsl #3
	ldr r3, [r0, #4]
	ldrh r4, [r6, r2]
	add r1, sp, #0
	mov r0, #0
	mov r2, #8
	add r10, r6, r3
	bl MIi_CpuClear32
	cmp r4, #0
	mov r9, #0
	addle sp, sp, #8
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r8, sp, #0
	mov r7, #6
	mov r6, #8
_021755F0:
	mov r0, r10
	mov r1, r8
	mov r2, r7
	bl MIi_CpuCopy16
	mov r0, r8
	mov r1, r5
	mov r2, r6
	bl MIi_CpuCopy32
	add r9, r9, #1
	cmp r9, r4
	add r10, r10, #6
	add r5, r5, #8
	blt _021755F0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0217562C: .word 0x0217E958
	arm_func_end ovl08_217559C

	arm_func_start ovl08_2175630
ovl08_2175630: // 0x02175630
	stmdb sp!, {r4, lr}
	ldr r1, _02175654 // =0x0217E958
	mov r4, r0
	ldr r0, [r1, r4, lsl #2]
	bl ovl08_2174AB8
	ldr r0, _02175654 // =0x0217E958
	mov r1, #0
	str r1, [r0, r4, lsl #2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02175654: .word 0x0217E958
	arm_func_end ovl08_2175630

	arm_func_start ovl08_2175658
ovl08_2175658: // 0x02175658
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r0, r1
	add r1, sp, #0
	mov r2, #4
	bl ovl08_2174AF4
	ldr r1, _02175684 // =0x0217E958
	str r0, [r1, r4, lsl #2]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02175684: .word 0x0217E958
	arm_func_end ovl08_2175658

	arm_func_start ovl08_2175688
ovl08_2175688: // 0x02175688
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #1
	mov r5, #0
	bl OS_DisableIrqMask
	ldrb r2, [r6, #3]
	ldrb r1, [r6, #2]
	mov r4, r0
	cmp r1, r2
	beq _021756D0
	ldrh r1, [r6]
	add r0, r2, r1
	sub r0, r0, #1
	bl FX_ModS32
	strb r0, [r6, #3]
	ldrb r0, [r6, #3]
	add r0, r6, r0, lsl #2
	ldr r5, [r0, #4]
_021756D0:
	mov r0, r4
	bl OS_EnableIrqMask
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl08_2175688

	arm_func_start ovl08_21756E0
ovl08_21756E0: // 0x021756E0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, #1
	mov r4, r1
	bl OS_DisableIrqMask
	ldrb r2, [r5, #3]
	mov r7, r0
	ldrh r1, [r5]
	add r0, r2, #1
	bl FX_ModS32
	ldrb r1, [r5, #2]
	mov r6, r0
	cmp r6, r1
	bne _02175720
	bl OS_Terminate
_02175720:
	ldrb r1, [r5, #3]
	mov r0, r7
	add r1, r5, r1, lsl #2
	str r4, [r1, #4]
	strb r6, [r5, #3]
	bl OS_EnableIrqMask
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end ovl08_21756E0

	arm_func_start ovl08_2175740
ovl08_2175740: // 0x02175740
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {lr}
	sub sp, sp, #4
	add r0, sp, #8
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end ovl08_2175740

	arm_func_start ovl08_2175764
ovl08_2175764: // 0x02175764
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl ovl08_21757A4
	cmp r6, #0
	mov r2, #0
	ble _0217579C
_02175784:
	add r1, r0, r2, lsl #2
	add r2, r2, #1
	str r5, [r1, #4]
	cmp r2, r6
	add r5, r5, r4
	blt _02175784
_0217579C:
	strb r6, [r0, #3]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl08_2175764

	arm_func_start ovl08_21757A4
ovl08_21757A4: // 0x021757A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #1
	mov r0, r0, lsl #2
	add r0, r0, #8
	mov r1, #4
	bl ovl08_2176788
	add r1, r4, #1
	strh r1, [r0]
	mov r1, #0
	strb r1, [r0, #2]
	strb r1, [r0, #3]
	ldmia sp!, {r4, pc}
	arm_func_end ovl08_21757A4

	arm_func_start ovl08_21757D8
ovl08_21757D8: // 0x021757D8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrsh r2, [r1, #4]
	add r2, r2, #1
	strh r2, [r1, #4]
	ldrsh r3, [r1, #4]
	ldrh r2, [r1, #6]
	cmp r3, r2
	addlt sp, sp, #4
	ldmltia sp!, {pc}
	mov r2, #0
	strb r2, [r1, #9]
	mov r1, r0
	mov r0, #1
	bl ovl08_2177870
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_21757D8

	arm_func_start ovl08_217581C
ovl08_217581C: // 0x0217581C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _02175878 // =0x0217E960
	mov r5, r0
	ldr r4, [r1]
	ldrb r0, [r4, #9]
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, pc}
	ldr r1, _0217587C // =ovl08_21757D8
	mov r2, r4
	mov r0, #1
	mov r3, #0xc8
	bl ovl08_2177924
	str r0, [r4]
	mov r0, #0
	strh r0, [r4, #4]
	strh r5, [r4, #6]
	mov r0, #1
	strb r0, [r4, #9]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02175878: .word 0x0217E960
_0217587C: .word ovl08_21757D8
	arm_func_end ovl08_217581C

	arm_func_start ovl08_2175880
ovl08_2175880: // 0x02175880
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r3, _021759A4 // =0x0217B010
	ldr r2, _021759A8 // =0x0217B00C
	ldrb r8, [r3]
	ldrb r7, [r3, #1]
	ldrb r6, [r3, #2]
	ldrb lr, [r3, #3]
	ldrb ip, [r2]
	ldrb r5, [r2, #1]
	ldrb r3, [r2, #2]
	ldrb r2, [r2, #3]
	strb r5, [sp, #5]
	mov r4, r1
	strb r8, [sp]
	strb r7, [sp, #1]
	strb r6, [sp, #2]
	strb lr, [sp, #3]
	strb ip, [sp, #4]
	strb r3, [sp, #6]
	strb r2, [sp, #7]
	ldrsh r1, [r4, #4]
	mov r5, r0
	add r0, r1, #1
	strh r0, [r4, #4]
	ldrsh r0, [r4, #4]
	ldrh r1, [r4, #6]
	mov r0, r0, lsl #4
	bl FX_DivS32
	ldrb r3, [r4, #8]
	add r2, sp, #0
	mov r1, r0
	ldrb r2, [r2, r3]
	ands r0, r2, #1
	rsbne r1, r1, #0x10
	ands r0, r2, #0x10
	ldr r0, _021759AC // =0x0217E960
	rsbne r1, r1, #0
	ldr r0, [r0]
	cmp r4, r0
	bne _02175930
	ldr r0, _021759B0 // =0x04001050
	bl G2x_ChangeBlendBrightness_
	b _02175938
_02175930:
	ldr r0, _021759B4 // =0x04000050
	bl G2x_ChangeBlendBrightness_
_02175938:
	ldrsh r1, [r4, #4]
	ldrh r0, [r4, #6]
	cmp r1, r0
	addlt sp, sp, #8
	ldmltia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, _021759AC // =0x0217E960
	ldr r0, [r0]
	cmp r4, r0
	bne _02175974
	ldrb r2, [r4, #8]
	add r1, sp, #4
	ldr r0, _021759B0 // =0x04001050
	ldrsb r1, [r1, r2]
	bl G2x_ChangeBlendBrightness_
	b _02175988
_02175974:
	ldrb r2, [r4, #8]
	add r1, sp, #4
	ldr r0, _021759B4 // =0x04000050
	ldrsb r1, [r1, r2]
	bl G2x_ChangeBlendBrightness_
_02175988:
	mov r2, #0
	mov r1, r5
	mov r0, #1
	strb r2, [r4, #9]
	bl ovl08_2177870
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021759A4: .word 0x0217B010
_021759A8: .word 0x0217B00C
_021759AC: .word 0x0217E960
_021759B0: .word 0x04001050
_021759B4: .word 0x04000050
	arm_func_end ovl08_2175880

	arm_func_start ovl08_21759B8
ovl08_21759B8: // 0x021759B8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r4, _02175A84 // =0x0217B014
	mov r5, r0
	ldrb r0, [r4, #3]
	ldrb r6, [r4]
	ldrb lr, [r4, #1]
	strb r0, [sp, #3]
	cmp r1, #1
	ldreq r0, _02175A88 // =0x0217E960
	ldrb ip, [r4, #2]
	strb r6, [sp]
	ldreq r6, [r0]
	ldrne r0, _02175A88 // =0x0217E960
	strb lr, [sp, #1]
	ldrne r0, [r0]
	strb ip, [sp, #2]
	addne r6, r0, #0xc
	ldrb r0, [r6, #9]
	mov r4, r3
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	cmp r1, #1
	bne _02175A38
	add r0, sp, #0
	mov r1, r2
	ldrsb r2, [r0, r5]
	ldr r0, _02175A8C // =0x04001050
	bl G2x_SetBlendBrightness_
	b _02175A4C
_02175A38:
	add r0, sp, #0
	mov r1, r2
	ldrsb r2, [r0, r5]
	ldr r0, _02175A90 // =0x04000050
	bl G2x_SetBlendBrightness_
_02175A4C:
	ldr r1, _02175A94 // =ovl08_2175880
	mov r2, r6
	mov r0, #1
	mov r3, #0xc8
	bl ovl08_2177924
	str r0, [r6]
	mov r0, #0
	strh r0, [r6, #4]
	strb r5, [r6, #8]
	strh r4, [r6, #6]
	mov r0, #1
	strb r0, [r6, #9]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02175A84: .word 0x0217B014
_02175A88: .word 0x0217E960
_02175A8C: .word 0x04001050
_02175A90: .word 0x04000050
_02175A94: .word ovl08_2175880
	arm_func_end ovl08_21759B8

	arm_func_start ovl08_2175A98
ovl08_2175A98: // 0x02175A98
	cmp r0, #1
	ldreq r0, _02175AB8 // =0x0217E960
	ldreq r0, [r0]
	ldrne r0, _02175AB8 // =0x0217E960
	ldrne r0, [r0]
	addne r0, r0, #0xc
	ldrb r0, [r0, #9]
	bx lr
	.align 2, 0
_02175AB8: .word 0x0217E960
	arm_func_end ovl08_2175A98

	arm_func_start ovl08_2175ABC
ovl08_2175ABC: // 0x02175ABC
	ldr ip, _02175AC8 // =ovl08_2176714
	ldr r0, _02175ACC // =0x0217E960
	bx ip
	.align 2, 0
_02175AC8: .word ovl08_2176714
_02175ACC: .word 0x0217E960
	arm_func_end ovl08_2175ABC

	arm_func_start ovl08_2175AD0
ovl08_2175AD0: // 0x02175AD0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0x18
	mov r1, #4
	bl ovl08_2176764
	ldr r2, _02175B14 // =0x0217E960
	mov r1, #0x3f
	str r0, [r2]
	ldr r0, _02175B18 // =0x04000050
	mov r2, #0x10
	bl G2x_SetBlendBrightness_
	ldr r0, _02175B1C // =0x04001050
	mov r1, #0x3f
	mov r2, #0x10
	bl G2x_SetBlendBrightness_
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02175B14: .word 0x0217E960
_02175B18: .word 0x04000050
_02175B1C: .word 0x04001050
	arm_func_end ovl08_2175AD0

	arm_func_start ovl08_2175B20
ovl08_2175B20: // 0x02175B20
	ldr r2, _02175B48 // =0x0217E964
	ldr r1, _02175B4C // =0x00000718
	ldr r2, [r2]
	add r1, r2, r1
	cmp r0, r1
	moveq r0, #1
	streqb r0, [r2, #0x794]
	movne r0, #1
	strneb r0, [r2, #0x795]
	bx lr
	.align 2, 0
_02175B48: .word 0x0217E964
_02175B4C: .word 0x00000718
	arm_func_end ovl08_2175B20

	arm_func_start ovl08_2175B50
ovl08_2175B50: // 0x02175B50
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r6, r3
	mov r4, r0
	mov r8, r1
	mov r0, r6
	mov r1, #0
	mov r7, r2
	bl ovl08_21751F8
	mov r2, #0
	mov r5, r0
	mov r0, r6
	mvn r1, #0
	mov r3, r2
	bl ovl08_2175138
	mov r0, r6
	mvn r1, #0
	mov r2, #0
	mov r3, #0xf
	bl ovl08_21750B0
	mov r0, r6
	mvn r1, #0
	ldr r2, [sp, #0x28]
	bl ovl08_2174F30
	str r7, [sp]
	mov r0, r5
	mov r3, r8
	mov r1, #0
	str r1, [sp, #4]
	ldrh r2, [r4, #0x34]
	mov r1, #2
	str r2, [sp, #8]
	str r1, [sp, #0xc]
	ldrb r1, [r4, #0x36]
	ldrb r2, [r4, #0x37]
	bl NNS_G2dArrangeOBJ1D
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end ovl08_2175B50

	arm_func_start ovl08_2175BE8
ovl08_2175BE8: // 0x02175BE8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, [r0, #0x18]
	blx r2
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2175BE8

	arm_func_start ovl08_2175C00
ovl08_2175C00: // 0x02175C00
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	ldr lr, [sp, #0x18]
	ldr ip, [sp, #0x1c]
	str lr, [sp]
	ldr lr, [sp, #0x20]
	str ip, [sp, #4]
	ldr ip, [sp, #0x24]
	str lr, [sp, #8]
	add r0, r0, #0x20
	str ip, [sp, #0xc]
	bl NNSi_G2dTextCanvasDrawTextRect
	add sp, sp, #0x14
	ldmia sp!, {pc}
	arm_func_end ovl08_2175C00

	arm_func_start ovl08_2175C38
ovl08_2175C38: // 0x02175C38
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r7, [sp, #0x34]
	mov r9, r1
	ldrh r1, [r7]
	ldr r8, [sp, #0x30]
	ldr r6, [sp, #0x38]
	mov r10, r0
	mov r11, r2
	str r3, [sp, #8]
	cmp r1, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #0xc
	mul r4, r6, r0
_02175C74:
	ldr r0, _02175CF8 // =0x0217E964
	ldr r0, [r0]
	add r5, r0, r4
	mov r0, r5
	bl NNS_G2dFontFindGlyphIndex
	mov r1, r0
	ldr r0, _02175CFC // =0x0000FFFF
	cmp r1, r0
	ldreq r0, [r5]
	ldreqh r1, [r0, #2]
	mov r0, r5
	bl NNS_G2dFontGetCharWidthsFromIndex
	ldrh r1, [r5, #8]
	ldrh r2, [r7]
	ldr r3, [sp, #8]
	cmp r1, #0
	ldrnesb r1, [r0]
	ldrneb r0, [r0, #1]
	addne r0, r1, r0
	ldreqsb r0, [r0, #2]
	sub r1, r8, r0
	str r2, [sp]
	mov r0, r10
	mov r2, r11
	add r1, r9, r1, asr #1
	str r6, [sp, #4]
	bl ovl08_2175D00
	ldrh r1, [r7, #2]!
	add r9, r9, r8
	cmp r1, #0
	bne _02175C74
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02175CF8: .word 0x0217E964
_02175CFC: .word 0x0000FFFF
	arm_func_end ovl08_2175C38

	arm_func_start ovl08_2175D00
ovl08_2175D00: // 0x02175D00
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldrh ip, [sp, #0x10]
	str r3, [sp]
	ldr r3, _02175D40 // =0x0217E964
	str ip, [sp, #4]
	ldr lr, [r3]
	ldr ip, [sp, #0x14]
	mov r3, #0xc
	mov r4, r1
	mla r1, ip, r3, lr
	mov r3, r2
	mov r2, r4
	bl NNS_G2dCharCanvasDrawChar
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02175D40: .word 0x0217E964
	arm_func_end ovl08_2175D00

	arm_func_start ovl08_2175D44
ovl08_2175D44: // 0x02175D44
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr lr, [sp, #0x10]
	ldr ip, [sp, #0x14]
	str lr, [sp]
	add r0, r0, #0x20
	str ip, [sp, #4]
	bl NNSi_G2dTextCanvasDrawText
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl08_2175D44

	arm_func_start ovl08_2175D6C
ovl08_2175D6C: // 0x02175D6C
	ldr r2, _02175D8C // =0x0217E964
	ldr r1, _02175D90 // =0x00000718
	ldr r3, [r2]
	mov r2, #0x38
	add r1, r3, r1
	mla r0, r2, r0, r1
	ldr ip, _02175D94 // =sub_2175D98
	bx ip
	.align 2, 0
_02175D8C: .word 0x0217E964
_02175D90: .word 0x00000718
_02175D94: .word sub_2175D98
	arm_func_end ovl08_2175D6C

	arm_func_start sub_2175D98
sub_2175D98: // 0x02175D98
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x34]
	mov r0, #1
	bl ovl08_2177864
	ldr r1, _02175E1C // =0x0217E964
	ldr r0, _02175E20 // =0x00000718
	ldr r1, [r1]
	add r0, r1, r0
	cmp r4, r0
	bne _02175DEC
	bl G2_GetBG0CharPtr
	ldr r2, _02175E24 // =0x0217B01C
	mov r1, r0
	ldrh r3, [r2]
	ldrh r2, [r2, #2]
	mov r0, #0
	mul r2, r3, r2
	mov r2, r2, lsl #5
	bl MIi_CpuClear16
	b _02175E10
_02175DEC:
	bl G2_GetBG0CharPtr
	ldr r2, _02175E24 // =0x0217B01C
	mov r1, r0
	ldrh r3, [r2, #4]
	ldrh r2, [r2, #6]
	mov r0, #0
	mul r2, r3, r2
	mov r2, r2, lsl #5
	bl MIi_CpuClear16
_02175E10:
	add r0, r4, #0x30
	bl ovl08_2176714
	ldmia sp!, {r4, pc}
	.align 2, 0
_02175E1C: .word 0x0217E964
_02175E20: .word 0x00000718
_02175E24: .word 0x0217B01C
	arm_func_end sub_2175D98

	arm_func_start ovl08_2175E28
ovl08_2175E28: // 0x02175E28
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	ldrb r0, [r4]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, _02175EF0 // =0x0217E964
	ldr r0, _02175EF4 // =0x00000794
	ldr r2, [r1]
	add r0, r2, r0
	cmp r4, r0
	bne _02175EA0
	ldr r1, _02175EF8 // =0x0217B01C
	ldr r0, [r2, #0x748]
	ldrh r2, [r1]
	ldrh r1, [r1, #2]
	mul r1, r2, r1
	mov r5, r1, lsl #5
	mov r1, r5
	bl DC_FlushRange
	ldr r1, _02175EF0 // =0x0217E964
	ldr r0, _02175EFC // =0x0217B018
	ldr r2, [r1]
	ldrh r1, [r0]
	ldr r0, [r2, #0x748]
	mov r2, r5
	mov r1, r1, lsl #5
	bl GX_LoadBG0Char
	b _02175EE0
_02175EA0:
	ldr r1, _02175EF8 // =0x0217B01C
	ldr r0, [r2, #0x780]
	ldrh r2, [r1, #4]
	ldrh r1, [r1, #6]
	mul r1, r2, r1
	mov r5, r1, lsl #5
	mov r1, r5
	bl DC_FlushRange
	ldr r1, _02175EF0 // =0x0217E964
	ldr r0, _02175EFC // =0x0217B018
	ldr r2, [r1]
	ldrh r1, [r0, #2]
	ldr r0, [r2, #0x780]
	mov r2, r5
	mov r1, r1, lsl #5
	bl GXS_LoadBG0Char
_02175EE0:
	mov r0, #0
	strb r0, [r4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02175EF0: .word 0x0217E964
_02175EF4: .word 0x00000794
_02175EF8: .word 0x0217B01C
_02175EFC: .word 0x0217B018
	arm_func_end ovl08_2175E28

	arm_func_start ovl08_2175F00
ovl08_2175F00: // 0x02175F00
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r8, r0
	ldr r0, _02176064 // =0x0217E964
	ldr r3, _02176068 // =0x0217B01E
	mov r4, r8, lsl #2
	ldr r2, _0217606C // =0x0217B01C
	ldrh r5, [r3, r4]
	ldrh r4, [r2, r4]
	ldr r3, [r0]
	ldr r0, _02176070 // =0x00000718
	mul r2, r4, r5
	mov r7, r1
	add r1, r3, r0
	mov r0, #0x38
	mla r6, r8, r0, r1
	mov r0, r2, lsl #5
	mov r1, #0x20
	bl ovl08_2176788
	str r0, [r6, #0x30]
	cmp r8, #1
	bne _02175F7C
	ldr r1, _02176074 // =0x04001008
	ldrh r0, [r1]
	bic r0, r0, #0x40
	strh r0, [r1]
	ldrh r0, [r1]
	and r0, r0, #0x43
	orr r0, r0, #0xc00
	strh r0, [r1]
	b _02175F9C
_02175F7C:
	ldr r1, _02176078 // =0x04000008
	ldrh r0, [r1]
	bic r0, r0, #0x40
	strh r0, [r1]
	ldrh r0, [r1]
	and r0, r0, #0x43
	orr r0, r0, #0xc00
	strh r0, [r1]
_02175F9C:
	mov r0, #4
	str r0, [sp]
	ldr r1, [r6, #0x30]
	mov r0, r6
	mov r2, r4
	mov r3, r5
	bl NNS_G2dCharCanvasInitForBG
	ldr r1, _02176064 // =0x0217E964
	mov r0, #0xc
	ldr r2, [r1]
	mov r1, #1
	mla r0, r7, r0, r2
	str r6, [r6, #0x20]
	str r0, [r6, #0x24]
	str r1, [r6, #0x28]
	str r1, [r6, #0x2c]
	cmp r8, #1
	bne _02175FEC
	bl G2S_GetBG0ScrPtr
	b _02175FF0
_02175FEC:
	bl G2_GetBG0ScrPtr
_02175FF0:
	mov r3, #0
	str r3, [sp]
	mov r2, #0x20
	ldr r1, _0217607C // =0x0217B018
	str r2, [sp, #4]
	mov r2, r8, lsl #1
	ldrh r7, [r1, r2]
	mov r1, r4
	mov r2, r5
	str r7, [sp, #8]
	mov r4, #0xf
	str r4, [sp, #0xc]
	bl NNS_G2dMapScrToCharText
	mov r0, r6
	mov r1, #0
	bl ovl08_2175BE8
	ldr r1, _02176064 // =0x0217E964
	ldr r0, _02176080 // =0x00000794
	ldr r2, [r1]
	ldr r1, _02176084 // =ovl08_2175E28
	add r0, r2, r0
	add r2, r0, r8
	mov r0, #1
	mov r3, #0xc8
	bl ovl08_2177924
	str r0, [r6, #0x34]
	mov r0, r6
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02176064: .word 0x0217E964
_02176068: .word 0x0217B01E
_0217606C: .word 0x0217B01C
_02176070: .word 0x00000718
_02176074: .word 0x04001008
_02176078: .word 0x04000008
_0217607C: .word 0x0217B018
_02176080: .word 0x00000794
_02176084: .word ovl08_2175E28
	arm_func_end ovl08_2175F00

	arm_func_start ovl08_2176088
ovl08_2176088: // 0x02176088
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x30]
	bl ovl08_2177280
	ldr r0, _021760B0 // =0x0217E964
	mov r1, r4
	ldr r0, [r0]
	ldr r0, [r0, #0x788]
	bl ovl08_21756E0
	ldmia sp!, {r4, pc}
	.align 2, 0
_021760B0: .word 0x0217E964
	arm_func_end ovl08_2176088

	arm_func_start ovl08_21760B4
ovl08_21760B4: // 0x021760B4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r4, _0217618C // =0x0217E964
	mov r7, r0
	ldr r0, [r4]
	mov r6, r1
	ldr r0, [r0, #0x788]
	mov r5, r2
	mov r8, r3
	bl ovl08_2175688
	mov r4, r0
	strb r6, [r4, #0x36]
	mul r1, r6, r5
	mov r2, r8
	strb r5, [r4, #0x37]
	mov r0, r7
	add r3, sp, #4
	bl ovl08_21772C8
	str r0, [r4, #0x30]
	ldr r1, [sp, #4]
	mov r0, r6
	strh r1, [r4, #0x34]
	mov r1, r5
	bl NNSi_G2dCalcRequiredOBJ
	ldr r1, [sp, #0x20]
	cmp r7, #1
	str r0, [r1]
	moveq ip, #0x6600000
	ldr r7, [sp, #4]
	mov r1, #4
	movne ip, #0x6400000
	str r1, [sp]
	mov r0, r4
	mov r2, r6
	mov r3, r5
	add r1, ip, r7, lsl #7
	bl NNS_G2dCharCanvasInitForOBJ1D
	ldr r2, [r4, #0x18]
	mov r0, r4
	mov r1, #0
	blx r2
	ldr r0, _0217618C // =0x0217E964
	ldr r1, [sp, #0x24]
	ldr r2, [r0]
	mov r0, #0xc
	mla r0, r1, r0, r2
	str r4, [r4, #0x20]
	str r0, [r4, #0x24]
	mov r1, #1
	str r1, [r4, #0x28]
	mov r0, r4
	str r1, [r4, #0x2c]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0217618C: .word 0x0217E964
	arm_func_end ovl08_21760B4

	arm_func_start ovl08_2176190
ovl08_2176190: // 0x02176190
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r4, _021761DC // =0x0217E964
	mov r5, #0
_021761A0:
	ldr r0, [r4]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x78c]
	bl ovl08_2174AB8
	add r5, r5, #1
	cmp r5, #2
	blt _021761A0
	ldr r0, _021761DC // =0x0217E964
	ldr r0, [r0]
	ldr r0, [r0, #0x788]
	bl ovl08_2175740
	ldr r0, _021761DC // =0x0217E964
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_021761DC: .word 0x0217E964
	arm_func_end ovl08_2176190

	arm_func_start ovl08_21761E0
ovl08_21761E0: // 0x021761E0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	ldr r0, _021762E8 // =0x00000798
	mov r1, #4
	bl ovl08_2176788
	mov r4, r0
	ldr r3, _021762EC // =0x0217E964
	add r1, r4, #0x18
	mov r0, #0x20
	mov r2, #0x38
	str r4, [r3]
	bl ovl08_2175764
	ldr r1, _021762EC // =0x0217E964
	ldr r1, [r1]
	str r0, [r1, #0x788]
	bl ovl08_215E600
	cmp r0, #6
	bne _02176288
	mov r8, #0
	mov r7, r8
	ldr r6, _021762F0 // =0x0217C29C
	ldr r9, _021762EC // =0x0217E964
	mov r5, r8
	mov r4, #4
_02176240:
	ldr r0, [r6, r8, lsl #2]
	mov r1, r5
	mov r2, r4
	bl ovl08_2174AF4
	ldr r1, [r9]
	add r1, r1, r8, lsl #2
	str r0, [r1, #0x78c]
	ldr r2, [r9]
	add r0, r2, r8, lsl #2
	ldr r1, [r0, #0x78c]
	add r0, r2, r7
	bl NNS_G2dFontInitUTF16
	add r8, r8, #1
	cmp r8, #2
	add r7, r7, #0xc
	blt _02176240
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_02176288:
	mov r7, #0
	mov r8, r7
	ldr r6, _021762F4 // =0x0217C2A4
	ldr r9, _021762EC // =0x0217E964
	mov r5, r7
	mov r4, #4
_021762A0:
	ldr r0, [r6, r7, lsl #2]
	mov r1, r5
	mov r2, r4
	bl ovl08_2174AF4
	ldr r1, [r9]
	add r1, r1, r7, lsl #2
	str r0, [r1, #0x78c]
	ldr r2, [r9]
	add r0, r2, r7, lsl #2
	ldr r1, [r0, #0x78c]
	add r0, r2, r8
	bl NNS_G2dFontInitUTF16
	add r7, r7, #1
	cmp r7, #2
	add r8, r8, #0xc
	blt _021762A0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_021762E8: .word 0x00000798
_021762EC: .word 0x0217E964
_021762F0: .word 0x0217C29C
_021762F4: .word 0x0217C2A4
	arm_func_end ovl08_21761E0

	arm_func_start ovl08_21762F8
ovl08_21762F8: // 0x021762F8
	ldrh r3, [r0]
	strh r3, [r2]
	ldrh r3, [r0, #2]
	strh r3, [r2, #2]
	ldrh ip, [r0]
	ldrh r3, [r1]
	add r3, ip, r3
	strh r3, [r2, #4]
	ldrh r3, [r0, #2]
	ldrh r0, [r1, #2]
	add r0, r3, r0
	strh r0, [r2, #6]
	bx lr
	arm_func_end ovl08_21762F8

	arm_func_start ovl08_217632C
ovl08_217632C: // 0x0217632C
	ldr ip, [sp]
	strh r0, [ip]
	strh r1, [ip, #2]
	strh r2, [ip, #4]
	strh r3, [ip, #6]
	bx lr
	arm_func_end ovl08_217632C

	arm_func_start ovl08_2176344
ovl08_2176344: // 0x02176344
	strh r0, [r2]
	strh r1, [r2, #2]
	bx lr
	arm_func_end ovl08_2176344

	arm_func_start ovl08_2176350
ovl08_2176350: // 0x02176350
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	bx lr
_0217635C: // jump table
	b _0217636C // case 0
	b _021763BC // case 1
	b _0217640C // case 2
	b _0217645C // case 3
_0217636C:
	cmp r0, #1
	bne _02176398
	ldr r0, _021764AC // =0x04001048
	cmp r3, #0
	ldrh r0, [r0]
	bic r0, r0, #0x3f
	orr r1, r0, r2
	ldr r0, _021764AC // =0x04001048
	orrne r1, r1, #0x20
	strh r1, [r0]
	bx lr
_02176398:
	ldr r0, _021764B0 // =0x04000048
	cmp r3, #0
	ldrh r0, [r0]
	bic r0, r0, #0x3f
	orr r1, r0, r2
	ldr r0, _021764B0 // =0x04000048
	orrne r1, r1, #0x20
	strh r1, [r0]
	bx lr
_021763BC:
	cmp r0, #1
	bne _021763E8
	ldr r0, _021764AC // =0x04001048
	cmp r3, #0
	ldrh r0, [r0]
	bic r0, r0, #0x3f00
	orr r1, r0, r2, lsl #8
	ldr r0, _021764AC // =0x04001048
	orrne r1, r1, #0x2000
	strh r1, [r0]
	bx lr
_021763E8:
	ldr r0, _021764B0 // =0x04000048
	cmp r3, #0
	ldrh r0, [r0]
	bic r0, r0, #0x3f00
	orr r1, r0, r2, lsl #8
	ldr r0, _021764B0 // =0x04000048
	orrne r1, r1, #0x2000
	strh r1, [r0]
	bx lr
_0217640C:
	cmp r0, #1
	bne _02176438
	ldr r0, _021764B4 // =0x0400104A
	cmp r3, #0
	ldrh r0, [r0]
	bic r0, r0, #0x3f00
	orr r1, r0, r2, lsl #8
	ldr r0, _021764B4 // =0x0400104A
	orrne r1, r1, #0x2000
	strh r1, [r0]
	bx lr
_02176438:
	ldr r0, _021764B8 // =0x0400004A
	cmp r3, #0
	ldrh r0, [r0]
	bic r0, r0, #0x3f00
	orr r1, r0, r2, lsl #8
	ldr r0, _021764B8 // =0x0400004A
	orrne r1, r1, #0x2000
	strh r1, [r0]
	bx lr
_0217645C:
	cmp r0, #1
	bne _02176488
	ldr r0, _021764B4 // =0x0400104A
	cmp r3, #0
	ldrh r0, [r0]
	bic r0, r0, #0x3f
	orr r1, r0, r2
	ldr r0, _021764B4 // =0x0400104A
	orrne r1, r1, #0x20
	strh r1, [r0]
	bx lr
_02176488:
	ldr r0, _021764B8 // =0x0400004A
	cmp r3, #0
	ldrh r0, [r0]
	bic r0, r0, #0x3f
	orr r1, r0, r2
	ldr r0, _021764B8 // =0x0400004A
	orrne r1, r1, #0x20
	strh r1, [r0]
	bx lr
	.align 2, 0
_021764AC: .word 0x04001048
_021764B0: .word 0x04000048
_021764B4: .word 0x0400104A
_021764B8: .word 0x0400004A
	arm_func_end ovl08_2176350

	arm_func_start ovl08_21764BC
ovl08_21764BC: // 0x021764BC
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #1
	bne _02176564
	cmp r1, #0
	bne _0217651C
	ldrh r0, [r2]
	ldrh r1, [r2, #4]
	ldrh r3, [r2, #2]
	ldrh lr, [r2, #6]
	mov r2, r0, lsl #8
	mov r0, r3, lsl #8
	and r2, r2, #0xff00
	and r1, r1, #0xff
	orr ip, r2, r1
	ldr r3, _021765FC // =0x04001040
	and r2, r0, #0xff00
	and r1, lr, #0xff
	ldr r0, _02176600 // =0x04001044
	strh ip, [r3]
	orr r1, r2, r1
	strh r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
_0217651C:
	ldrh r0, [r2]
	ldrh r1, [r2, #4]
	ldrh r3, [r2, #2]
	ldrh lr, [r2, #6]
	mov r2, r0, lsl #8
	mov r0, r3, lsl #8
	and r2, r2, #0xff00
	and r1, r1, #0xff
	orr ip, r2, r1
	ldr r3, _02176604 // =0x04001042
	and r2, r0, #0xff00
	and r1, lr, #0xff
	ldr r0, _02176608 // =0x04001046
	strh ip, [r3]
	orr r1, r2, r1
	strh r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
_02176564:
	cmp r1, #0
	bne _021765B4
	ldrh r0, [r2]
	ldrh r1, [r2, #4]
	ldrh r3, [r2, #2]
	ldrh lr, [r2, #6]
	mov r2, r0, lsl #8
	mov r0, r3, lsl #8
	and r2, r2, #0xff00
	and r1, r1, #0xff
	orr ip, r2, r1
	ldr r3, _0217660C // =0x04000040
	and r2, r0, #0xff00
	and r1, lr, #0xff
	ldr r0, _02176610 // =0x04000044
	strh ip, [r3]
	orr r1, r2, r1
	strh r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
_021765B4:
	ldrh r0, [r2]
	ldrh r3, [r2, #2]
	ldrh r1, [r2, #4]
	ldrh lr, [r2, #6]
	mov r2, r0, lsl #8
	mov r0, r3, lsl #8
	and r2, r2, #0xff00
	and r1, r1, #0xff
	ldr r3, _02176614 // =0x04000042
	orr ip, r2, r1
	and r2, r0, #0xff00
	and r1, lr, #0xff
	ldr r0, _02176618 // =0x04000046
	strh ip, [r3]
	orr r1, r2, r1
	strh r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021765FC: .word 0x04001040
_02176600: .word 0x04001044
_02176604: .word 0x04001042
_02176608: .word 0x04001046
_0217660C: .word 0x04000040
_02176610: .word 0x04000044
_02176614: .word 0x04000042
_02176618: .word 0x04000046
	arm_func_end ovl08_21764BC

	arm_func_start ovl08_217661C
ovl08_217661C: // 0x0217661C
	cmp r0, #1
	bne _0217664C
	ldr r3, _02176674 // =0x04001000
	mvn r0, r1
	ldr r2, [r3]
	ldr r1, [r3]
	and r2, r2, #0x1f00
	bic r1, r1, #0x1f00
	and r0, r0, r2, lsr #8
	orr r0, r1, r0, lsl #8
	str r0, [r3]
	bx lr
_0217664C:
	mov r3, #0x4000000
	ldr r0, [r3]
	ldr r2, [r3]
	and ip, r0, #0x1f00
	mvn r0, r1
	bic r1, r2, #0x1f00
	and r0, r0, ip, lsr #8
	orr r0, r1, r0, lsl #8
	str r0, [r3]
	bx lr
	.align 2, 0
_02176674: .word 0x04001000
	arm_func_end ovl08_217661C

	arm_func_start ovl08_2176678
ovl08_2176678: // 0x02176678
	cmp r0, #1
	bne _021766A4
	ldr r3, _021766C8 // =0x04001000
	ldr r2, [r3]
	ldr r0, [r3]
	and ip, r2, #0x1f00
	bic r2, r0, #0x1f00
	orr r0, r1, ip, lsr #8
	orr r0, r2, r0, lsl #8
	str r0, [r3]
	bx lr
_021766A4:
	mov r3, #0x4000000
	ldr r2, [r3]
	ldr r0, [r3]
	and ip, r2, #0x1f00
	bic r2, r0, #0x1f00
	orr r0, r1, ip, lsr #8
	orr r0, r2, r0, lsl #8
	str r0, [r3]
	bx lr
	.align 2, 0
_021766C8: .word 0x04001000
	arm_func_end ovl08_2176678

	arm_func_start ovl08_21766CC
ovl08_21766CC: // 0x021766CC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, #1
	bl OS_DisableIrqMask
	cmp r5, #0
	mov r4, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, _02176710 // =0x0217E968
	mov r1, r5
	ldr r0, [r0]
	bl NNS_FndFreeToExpHeap
	mov r0, r4
	bl OS_EnableIrqMask
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02176710: .word 0x0217E968
	arm_func_end ovl08_21766CC

	arm_func_start ovl08_2176714
ovl08_2176714: // 0x02176714
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, #1
	bl OS_DisableIrqMask
	ldr r1, [r5]
	mov r4, r0
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, _02176760 // =0x0217E968
	ldr r0, [r0]
	bl NNS_FndFreeToExpHeap
	mov r0, r4
	bl OS_EnableIrqMask
	mov r0, #0
	str r0, [r5]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02176760: .word 0x0217E968
	arm_func_end ovl08_2176714

	arm_func_start ovl08_2176764
ovl08_2176764: // 0x02176764
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl08_2176788
	mov r2, r4
	mov r1, #0
	mov r4, r0
	bl MI_CpuFill8
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end ovl08_2176764

	arm_func_start ovl08_2176788
ovl08_2176788: // 0x02176788
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #1
	mov r5, r1
	bl OS_DisableIrqMask
	ldr r1, _021767D0 // =0x0217E968
	mov r4, r0
	ldr r0, [r1]
	mov r1, r6
	mov r2, r5
	bl NNS_FndAllocFromExpHeapEx
	movs r5, r0
	bne _021767C0
	bl OS_Terminate
_021767C0:
	mov r0, r4
	bl OS_EnableIrqMask
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021767D0: .word 0x0217E968
	arm_func_end ovl08_2176788

	arm_func_start ovl08_21767D4
ovl08_21767D4: // 0x021767D4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021767FC // =0x0217E968
	ldr r0, [r0]
	bl NNS_FndDestroyExpHeap
	ldr r0, _021767FC // =0x0217E968
	mov r1, #0
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021767FC: .word 0x0217E968
	arm_func_end ovl08_21767D4

	arm_func_start ovl08_2176800
ovl08_2176800: // 0x02176800
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	mov r2, #0x40000
	bl MI_CpuFill8
	mov r0, r4
	mov r1, #0x40000
	mov r2, #0
	bl NNS_FndCreateExpHeapEx
	ldr r1, _0217683C // =0x0217E968
	cmp r0, #0
	str r0, [r1]
	ldmneia sp!, {r4, pc}
	bl OS_Terminate
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217683C: .word 0x0217E968
	arm_func_end ovl08_2176800

	arm_func_start DWCi_IPTlCheckFold
DWCi_IPTlCheckFold: // 0x02176840
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021768C8 // =0x0217E96C
	ldrb r0, [r0]
	cmp r0, #0
	beq _02176890
	ldr r0, _021768CC // =0x027FFFA8
	ldrh r0, [r0]
	and r0, r0, #0x8000
	movs r0, r0, asr #0xf
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #1
	bl PM_SetLCDPower
	cmp r0, #0
	ldrne r0, _021768C8 // =0x0217E96C
	movne r1, #0
	strneb r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
_02176890:
	ldr r0, _021768CC // =0x027FFFA8
	ldrh r0, [r0]
	and r0, r0, #0x8000
	movs r0, r0, asr #0xf
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	bl PM_SetLCDPower
	cmp r0, #0
	ldrne r0, _021768C8 // =0x0217E96C
	movne r1, #1
	strneb r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021768C8: .word 0x0217E96C
_021768CC: .word 0x027FFFA8
	arm_func_end DWCi_IPTlCheckFold

	arm_func_start ovl08_21768D0
ovl08_21768D0: // 0x021768D0
	ldr r1, _02176914 // =0x0217E974
	ldr r3, [r1]
	ldrb r1, [r3, #0x38]
	mov r1, r1, lsl #0x1f
	movs r1, r1, lsr #0x1f
	ldrneh r2, [r3, #0x28]
	ldrneh r1, [r3, #0x2a]
	strneh r2, [r0]
	strneh r1, [r0, #2]
	movne r0, #1
	bxne lr
	ldrh r2, [r3, #0x2c]
	ldrh r1, [r3, #0x2e]
	strh r2, [r0]
	strh r1, [r0, #2]
	mov r0, #0
	bx lr
	.align 2, 0
_02176914: .word 0x0217E974
	arm_func_end ovl08_21768D0

	arm_func_start ovl08_2176918
ovl08_2176918: // 0x02176918
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldrh r1, [r0]
	strh r1, [sp]
	ldrh r1, [r0, #2]
	strh r1, [sp, #2]
	ldrh r2, [r0]
	ldrh r1, [r0, #4]
	add r1, r2, r1
	strh r1, [sp, #4]
	ldrh r2, [r0, #2]
	ldrh r1, [r0, #6]
	add r0, sp, #0
	add r1, r2, r1
	strh r1, [sp, #6]
	bl ovl08_2176A38
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl08_2176918

	arm_func_start ovl08_2176960
ovl08_2176960: // 0x02176960
	ldr r1, _021769C8 // =0x0217E974
	ldr r3, [r1]
	ldrb r1, [r3, #0x38]
	mov r1, r1, lsl #0x1c
	movs r1, r1, lsr #0x1f
	moveq r0, #0
	bxeq lr
	ldrh r2, [r3, #0x28]
	ldrh r1, [r0]
	cmp r1, r2
	movhi r0, #0
	bxhi lr
	ldrh r1, [r0, #4]
	cmp r1, r2
	movlo r0, #0
	bxlo lr
	ldrh r2, [r3, #0x2a]
	ldrh r1, [r0, #2]
	cmp r1, r2
	movhi r0, #0
	bxhi lr
	ldrh r0, [r0, #6]
	cmp r0, r2
	movhs r0, #1
	movlo r0, #0
	bx lr
	.align 2, 0
_021769C8: .word 0x0217E974
	arm_func_end ovl08_2176960

	arm_func_start ovl08_21769CC
ovl08_21769CC: // 0x021769CC
	ldr r1, _02176A34 // =0x0217E974
	ldr r3, [r1]
	ldrb r1, [r3, #0x38]
	mov r1, r1, lsl #0x1d
	movs r1, r1, lsr #0x1f
	moveq r0, #0
	bxeq lr
	ldrh r2, [r3, #0x28]
	ldrh r1, [r0]
	cmp r1, r2
	movhi r0, #0
	bxhi lr
	ldrh r1, [r0, #4]
	cmp r1, r2
	movlo r0, #0
	bxlo lr
	ldrh r2, [r3, #0x2a]
	ldrh r1, [r0, #2]
	cmp r1, r2
	movhi r0, #0
	bxhi lr
	ldrh r0, [r0, #6]
	cmp r0, r2
	movhs r0, #1
	movlo r0, #0
	bx lr
	.align 2, 0
_02176A34: .word 0x0217E974
	arm_func_end ovl08_21769CC

	arm_func_start ovl08_2176A38
ovl08_2176A38: // 0x02176A38
	ldr r1, _02176AA0 // =0x0217E974
	ldr r3, [r1]
	ldrb r1, [r3, #0x38]
	mov r1, r1, lsl #0x1e
	movs r1, r1, lsr #0x1f
	moveq r0, #0
	bxeq lr
	ldrh r2, [r3, #0x28]
	ldrh r1, [r0]
	cmp r1, r2
	movhi r0, #0
	bxhi lr
	ldrh r1, [r0, #4]
	cmp r1, r2
	movlo r0, #0
	bxlo lr
	ldrh r2, [r3, #0x2a]
	ldrh r1, [r0, #2]
	cmp r1, r2
	movhi r0, #0
	bxhi lr
	ldrh r0, [r0, #6]
	cmp r0, r2
	movhs r0, #1
	movlo r0, #0
	bx lr
	.align 2, 0
_02176AA0: .word 0x0217E974
	arm_func_end ovl08_2176A38

	arm_func_start ovl08_2176AA4
ovl08_2176AA4: // 0x02176AA4
	ldr r1, _02176B0C // =0x0217E974
	ldr r3, [r1]
	ldrb r1, [r3, #0x38]
	mov r1, r1, lsl #0x1f
	movs r1, r1, lsr #0x1f
	moveq r0, #0
	bxeq lr
	ldrh r2, [r3, #0x28]
	ldrh r1, [r0]
	cmp r1, r2
	movhi r0, #0
	bxhi lr
	ldrh r1, [r0, #4]
	cmp r1, r2
	movlo r0, #0
	bxlo lr
	ldrh r2, [r3, #0x2a]
	ldrh r1, [r0, #2]
	cmp r1, r2
	movhi r0, #0
	bxhi lr
	ldrh r0, [r0, #6]
	cmp r0, r2
	movhs r0, #1
	movlo r0, #0
	bx lr
	.align 2, 0
_02176B0C: .word 0x0217E974
	arm_func_end ovl08_2176AA4

	arm_func_start ovl08_2176B10
ovl08_2176B10: // 0x02176B10
	ldr r1, _02176B30 // =0x0217E974
	ldr r1, [r1]
	ldrh r1, [r1, #0x36]
	and r1, r0, r1
	cmp r0, r1
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_02176B30: .word 0x0217E974
	arm_func_end ovl08_2176B10

	arm_func_start ovl08_2176B34
ovl08_2176B34: // 0x02176B34
	ldr r1, _02176B54 // =0x0217E974
	ldr r1, [r1]
	ldrh r1, [r1, #0x34]
	and r1, r0, r1
	cmp r0, r1
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_02176B54: .word 0x0217E974
	arm_func_end ovl08_2176B34

	arm_func_start ovl08_2176B58
ovl08_2176B58: // 0x02176B58
	ldr r1, _02176B78 // =0x0217E974
	ldr r1, [r1]
	ldrh r1, [r1, #0x32]
	and r1, r0, r1
	cmp r0, r1
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_02176B78: .word 0x0217E974
	arm_func_end ovl08_2176B58

	arm_func_start ovl08_2176B7C
ovl08_2176B7C: // 0x02176B7C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r0, _02176D1C // =0x0217E974
	mov r4, #0
	ldr r0, [r0]
	ldrb r0, [r0, #0x38]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	movne r6, #1
	moveq r6, #0
	bl TP_GetLatestIndexInAuto
	ldr r7, _02176D1C // =0x0217E974
	mov r5, r4
	ldr r3, [r7]
	mov r8, #5
	ldrh r2, [r3, #0x28]
	ldrh r1, [r3, #0x2a]
	strh r2, [r3, #0x2c]
	strh r1, [r3, #0x2e]
_02176BC8:
	ldr r1, [r7]
	add r1, r1, r0, lsl #3
	ldrh r2, [r1, #4]
	cmp r2, #1
	bne _02176C10
	ldrh r2, [r1, #6]
	cmp r2, #0
	bne _02176C10
	add r0, sp, #0
	mov r4, #1
	bl TP_GetCalibratedPoint
	ldr r1, _02176D1C // =0x0217E974
	ldrh r0, [sp]
	ldr r2, [r1]
	ldrh r1, [sp, #2]
	add r2, r2, #0x28
	bl ovl08_2176344
	b _02176C28
_02176C10:
	mov r1, r8
	add r5, r5, #1
	add r0, r0, #4
	bl FX_ModS32
	cmp r5, #4
	blt _02176BC8
_02176C28:
	ldr r1, _02176D1C // =0x0217E974
	eor r7, r4, r6
	ldr r5, [r1]
	and r0, r4, r7
	ldrb r3, [r5, #0x38]
	and r2, r0, #0xff
	and r0, r6, r7
	bic r3, r3, #2
	and r2, r2, #1
	orr r2, r3, r2, lsl #1
	strb r2, [r5, #0x38]
	ldr r5, [r1]
	and r0, r0, #0xff
	ldrb r3, [r5, #0x38]
	and r2, r0, #1
	cmp r4, #0
	bic r3, r3, #8
	orr r2, r3, r2, lsl #3
	strb r2, [r5, #0x38]
	ldr r3, [r1]
	and r0, r4, #1
	ldrb r2, [r3, #0x38]
	addeq sp, sp, #8
	bic r2, r2, #1
	orr r0, r2, r0
	strb r0, [r3, #0x38]
	ldr r3, [r1]
	moveq r1, #0
	ldrb r2, [r3, #0x38]
	mov r0, r2, lsl #0x1e
	mov r0, r0, lsr #0x1f
	bic r2, r2, #4
	and r0, r0, #1
	orr r0, r2, r0, lsl #2
	strb r0, [r3, #0x38]
	ldreq r0, _02176D20 // =0x0217E970
	streqb r1, [r0]
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, _02176D20 // =0x0217E970
	ldrb r2, [r0]
	add r2, r2, #1
	strb r2, [r0]
	ldrb r2, [r0]
	cmp r2, #0x28
	ldreq r1, [r1]
	addeq sp, sp, #8
	ldreqb r0, [r1, #0x38]
	orreq r0, r0, #4
	streqb r0, [r1, #0x38]
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r2, #0x2f
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r3, [r1]
	mov r1, #0x28
	ldrb r2, [r3, #0x38]
	orr r2, r2, #4
	strb r2, [r3, #0x38]
	strb r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02176D1C: .word 0x0217E974
_02176D20: .word 0x0217E970
	arm_func_end ovl08_2176B7C

	arm_func_start ovl08_2176D24
ovl08_2176D24: // 0x02176D24
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r1, _02176E18 // =0x04000130
	ldr r0, _02176E1C // =0x027FFFA8
	ldrh r2, [r1]
	ldrh r1, [r0]
	ldr r4, _02176E20 // =0x0217E974
	ldr r0, _02176E24 // =0x00002FFF
	ldr r5, [r4]
	orr r1, r2, r1
	eor r1, r1, r0
	and r0, r1, r0
	mov r0, r0, lsl #0x10
	ldrh r1, [r5, #0x30]
	mov r3, r0, lsr #0x10
	ldr ip, _02176E28 // =0x0217E978
	eor r1, r1, r0, lsr #16
	and r1, r1, r0, lsr #16
	strh r1, [r5, #0x32]
	ldrh r2, [r5, #0x30]
	ldr r1, [r4]
	mov lr, #0
	eor r0, r2, r0, lsr #16
	and r0, r2, r0
	strh r0, [r1, #0x36]
	ldr r0, [r4]
	strh r3, [r0, #0x30]
	ldr r1, [r4]
	ldrh r0, [r1, #0x32]
	strh r0, [r1, #0x34]
	mov r0, lr
	mov r5, #0x28
	mov r2, #1
_02176DA8:
	mov r1, r2, lsl lr
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	ands r6, r3, r1
	streqb r0, [ip]
	beq _02176E00
	ldrb r6, [ip]
	add r6, r6, #1
	strb r6, [ip]
	ldrb r6, [ip]
	cmp r6, #0x28
	ldreq r7, [r4]
	ldreqh r6, [r7, #0x34]
	orreq r1, r6, r1
	streqh r1, [r7, #0x34]
	beq _02176E00
	cmp r6, #0x2f
	ldreq r7, [r4]
	ldreqh r6, [r7, #0x34]
	orreq r1, r6, r1
	streqh r1, [r7, #0x34]
	streqb r5, [ip]
_02176E00:
	add lr, lr, #1
	cmp lr, #0xe
	add ip, ip, #1
	blt _02176DA8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02176E18: .word 0x04000130
_02176E1C: .word 0x027FFFA8
_02176E20: .word 0x0217E974
_02176E24: .word 0x00002FFF
_02176E28: .word 0x0217E978
	arm_func_end ovl08_2176D24

	arm_func_start DWCi_IPTlRead
DWCi_IPTlRead: // 0x02176E2C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ovl08_2176D24
	bl ovl08_2176B7C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_IPTlRead

	arm_func_start ovl08_2176E44
ovl08_2176E44: // 0x02176E44
	stmdb sp!, {r4, lr}
	mov r4, #4
_02176E4C:
	bl TP_RequestAutoSamplingStopAsync
	mov r0, r4
	bl TP_WaitBusy
	mov r0, r4
	bl TP_CheckError
	cmp r0, #0
	bne _02176E4C
	ldr r0, _02176E74 // =0x0217E974
	bl ovl08_2176714
	ldmia sp!, {r4, pc}
	.align 2, 0
_02176E74: .word 0x0217E974
	arm_func_end ovl08_2176E44

	arm_func_start ovl08_2176E78
ovl08_2176E78: // 0x02176E78
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov r0, #0x3a
	mov r1, #4
	bl ovl08_2176764
	ldr r1, _02176EF0 // =0x0217E974
	str r0, [r1]
	add r0, sp, #0
	bl TP_GetUserInfo
	cmp r0, #0
	bne _02176EA8
	bl OS_Terminate
_02176EA8:
	add r0, sp, #0
	bl TP_SetCalibrateParam
	ldr r1, _02176EF0 // =0x0217E974
	mov r0, #0
	ldr r2, [r1]
	mov r1, #4
	mov r3, #5
	bl TP_RequestAutoSamplingStartAsync
	mov r0, #2
	bl TP_WaitBusy
	mov r0, #2
	bl TP_CheckError
	cmp r0, #0
	beq _02176EE4
	bl OS_Terminate
_02176EE4:
	bl DWCi_IPTlRead
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_02176EF0: .word 0x0217E974
	arm_func_end ovl08_2176E78

	arm_func_start ovl08_2176EF4
ovl08_2176EF4: // 0x02176EF4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl DWCi_TSKlAct
	ldr r0, _02176F20 // =0x027E0000
	add r0, r0, #0x3000
	ldr r1, [r0, #0xff8]
	orr r1, r1, #1
	str r1, [r0, #0xff8]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02176F20: .word 0x027E0000
	arm_func_end ovl08_2176EF4

	arm_func_start ovl08_2176F24
ovl08_2176F24: // 0x02176F24
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _02176F60 // =0x04000208
	mov r1, #0
	ldrh r0, [r2]
	ldr r0, _02176F64 // =0x0217E98C
	strh r1, [r2]
	ldr r0, [r0]
	bl OS_SetIrqMask
	ldr r1, _02176F68 // =0x0217E988
	mov r0, #1
	ldr r1, [r1]
	bl OS_SetIrqFunction
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02176F60: .word 0x04000208
_02176F64: .word 0x0217E98C
_02176F68: .word 0x0217E988
	arm_func_end ovl08_2176F24

	arm_func_start ovl08_2176F6C
ovl08_2176F6C: // 0x02176F6C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02176FD4 // =0x04000210
	ldr r1, _02176FD8 // =0x0217E98C
	ldr r2, [r0]
	ldr r0, _02176FDC // =0x00040018
	str r2, [r1]
	bl OS_SetIrqMask
	mov r0, #1
	bl OS_EnableIrqMask
	mov r0, #1
	bl OS_GetIrqFunction
	ldr r2, _02176FE0 // =0x0217E988
	ldr r1, _02176FE4 // =ovl08_2176EF4
	str r0, [r2]
	mov r0, #1
	bl OS_SetIrqFunction
	mov r0, #1
	bl OS_ResetRequestIrqMask
	ldr r2, _02176FE8 // =0x04000208
	mov r0, #1
	ldrh r1, [r2]
	strh r0, [r2]
	bl OS_EnableInterrupts
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02176FD4: .word 0x04000210
_02176FD8: .word 0x0217E98C
_02176FDC: .word 0x00040018
_02176FE0: .word 0x0217E988
_02176FE4: .word ovl08_2176EF4
_02176FE8: .word 0x04000208
	arm_func_end ovl08_2176F6C

	arm_func_start ovl08_2176FEC
ovl08_2176FEC: // 0x02176FEC
	ldr ip, _02176FF8 // =ovl08_217700C
	ldr r0, [r0, #4]
	bx ip
	.align 2, 0
_02176FF8: .word ovl08_217700C
	arm_func_end ovl08_2176FEC

	arm_func_start ovl08_2176FFC
ovl08_2176FFC: // 0x02176FFC
	ldr ip, _02177008 // =ovl08_217700C
	add r0, r0, #8
	bx ip
	.align 2, 0
_02177008: .word ovl08_217700C
	arm_func_end ovl08_2176FFC

	arm_func_start ovl08_217700C
ovl08_217700C: // 0x0217700C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, #1
	mov r4, r1
	bl OS_DisableIrqMask
	ldr r1, [r5]
	str r4, [r1, #4]
	ldr r1, [r5]
	str r1, [r4]
	str r5, [r4, #4]
	str r4, [r5]
	bl OS_EnableIrqMask
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end ovl08_217700C

	arm_func_start ovl08_2177048
ovl08_2177048: // 0x02177048
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #1
	bl OS_DisableIrqMask
	ldr r3, [r4, #4]
	ldr r2, [r4]
	mov r1, #0
	str r3, [r2, #4]
	ldr r3, [r4]
	ldr r2, [r4, #4]
	str r3, [r2]
	str r1, [r4, #4]
	ldr r1, [r4, #4]
	str r1, [r4]
	bl OS_EnableIrqMask
	ldmia sp!, {r4, pc}
	arm_func_end ovl08_2177048

	arm_func_start ovl08_2177088
ovl08_2177088: // 0x02177088
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {lr}
	sub sp, sp, #4
	add r0, sp, #8
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end ovl08_2177088

	arm_func_start ovl08_21770AC
ovl08_21770AC: // 0x021770AC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0x10
	mov r1, #4
	bl ovl08_2176788
	mov r2, #0
	str r2, [r0]
	add r1, r0, #8
	str r1, [r0, #4]
	str r0, [r0, #8]
	str r2, [r0, #0xc]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_21770AC

	arm_func_start ovl08_21770E0
ovl08_21770E0: // 0x021770E0
	ldr r2, _021770F4 // =0x0217E990
	ldr r2, [r2]
	add r0, r2, r0, lsl #10
	add r0, r0, r1, lsl #3
	bx lr
	.align 2, 0
_021770F4: .word 0x0217E990
	arm_func_end ovl08_21770E0

	arm_func_start ovl08_21770F8
ovl08_21770F8: // 0x021770F8
	mov r1, r0
	ldr r3, [r1]
	ldr r0, _02177138 // =0xC1FFFCFF
	ldr r2, _0217713C // =0x0217E990
	and r0, r3, r0
	orr r0, r0, #0x200
	str r0, [r1]
	ldr r2, [r2]
	mov r3, #0
	add r0, r2, #0x400
	cmp r1, r0
	movhs r3, #1
	add r0, r2, r3, lsl #2
	ldr ip, _02177140 // =ovl08_21756E0
	ldr r0, [r0, #0x800]
	bx ip
	.align 2, 0
_02177138: .word 0xC1FFFCFF
_0217713C: .word 0x0217E990
_02177140: .word ovl08_21756E0
	arm_func_end ovl08_21770F8

	arm_func_start ovl08_2177144
ovl08_2177144: // 0x02177144
	ldr r1, _0217715C // =0x0217E990
	ldr ip, _02177160 // =ovl08_2175688
	ldr r1, [r1]
	add r0, r1, r0, lsl #2
	ldr r0, [r0, #0x800]
	bx ip
	.align 2, 0
_0217715C: .word 0x0217E990
_02177160: .word ovl08_2175688
	arm_func_end ovl08_2177144

	arm_func_start ovl08_2177164
ovl08_2177164: // 0x02177164
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _02177190 // =0x0217E990
	mov r0, #1
	ldr r1, [r1]
	ldr r1, [r1, #0x808]
	bl ovl08_2177864
	ldr r0, _02177190 // =0x0217E990
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02177190: .word 0x0217E990
	arm_func_end ovl08_2177164

	arm_func_start ovl08_2177194
ovl08_2177194: // 0x02177194
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021771E0 // =0x0217E990
	mov r1, #0x800
	ldr r0, [r0]
	bl DC_FlushRange
	ldr r0, _021771E0 // =0x0217E990
	mov r1, #0
	ldr r0, [r0]
	mov r2, #0x400
	bl GX_LoadOAM
	ldr r0, _021771E0 // =0x0217E990
	mov r1, #0
	ldr r0, [r0]
	mov r2, #0x400
	add r0, r0, #0x400
	bl GXS_LoadOAM
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021771E0: .word 0x0217E990
	arm_func_end ovl08_2177194

	arm_func_start ovl08_21771E4
ovl08_21771E4: // 0x021771E4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r0, _02177274 // =0x0000080C
	mov r1, #4
	bl ovl08_2176788
	mov r1, r0
	ldr r3, _02177278 // =0x0217E990
	mov r0, #0x200
	mov r2, #0x800
	str r1, [r3]
	bl MIi_CpuClearFast
	mov r6, #0
	mov r5, r6
	ldr r7, _02177278 // =0x0217E990
	mov r4, #0x40
	mov r8, #8
_02177220:
	ldr r1, [r7]
	mov r0, r4
	mov r2, r8
	add r1, r1, r5
	bl ovl08_2175764
	ldr r1, [r7]
	add r5, r5, #0x400
	add r1, r1, r6, lsl #2
	add r6, r6, #1
	str r0, [r1, #0x800]
	cmp r6, #2
	blt _02177220
	ldr r1, _0217727C // =ovl08_2177194
	mov r0, #1
	mov r2, #0
	mov r3, #0xc8
	bl ovl08_2177924
	ldr r1, _02177278 // =0x0217E990
	ldr r1, [r1]
	str r0, [r1, #0x808]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02177274: .word 0x0000080C
_02177278: .word 0x0217E990
_0217727C: .word ovl08_2177194
	arm_func_end ovl08_21771E4

	arm_func_start ovl08_2177280
ovl08_2177280: // 0x02177280
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, #0
	bl ovl08_2177048
	ldr r0, _021772C4 // =0x0217E994
	ldr r1, [r0]
	add r0, r1, #0x1a0
	cmp r5, r0
	movhs r4, #1
	mov r0, #0x1a0
	mla r0, r4, r0, r1
	ldr r0, [r0, #0x19c]
	mov r1, r5
	bl ovl08_21756E0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_021772C4: .word 0x0217E994
	arm_func_end ovl08_2177280

	arm_func_start ovl08_21772C8
ovl08_21772C8: // 0x021772C8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r6, r0
	mov r0, #0x1a0
	mul r7, r6, r0
	ldr r0, _02177440 // =0x0217E994
	mov r4, r1
	ldr r0, [r0]
	mov r10, r2
	add r0, r0, r7
	ldr r0, [r0, #0x19c]
	mov r5, r3
	bl ovl08_2175688
	add r1, r4, #3
	bic r1, r1, #3
	mov r4, r0
	mov r8, r1, asr #2
	mov r0, #1
	strh r8, [r4, #0xa]
	bl OS_DisableIrqMask
	mov r9, r0
	cmp r10, #0
	beq _021773A4
	ldr r1, _02177440 // =0x0217E994
	mov r0, #0x1a0
	ldr r1, [r1]
	mla r0, r6, r0, r1
	add r6, r0, #0x180
	add r0, r0, #0x18c
	cmp r6, r0
	beq _02177384
	add r0, r1, r7
	add r1, r0, #0x18c
_02177348:
	ldr r0, [r6, #4]
	ldrh r10, [r6, #8]
	ldrh r3, [r6, #0xa]
	ldrh r2, [r0, #8]
	add r10, r10, r3
	add r3, r10, r8
	cmp r3, r2
	bgt _02177378
	mov r1, r4
	strh r10, [r4, #8]
	bl ovl08_217700C
	b _02177384
_02177378:
	mov r6, r0
	cmp r0, r1
	bne _02177348
_02177384:
	ldr r0, _02177440 // =0x0217E994
	ldr r0, [r0]
	add r0, r0, r7
	add r0, r0, #0x18c
	cmp r6, r0
	bne _02177428
	bl OS_Terminate
	b _02177428
_021773A4:
	ldr r1, _02177440 // =0x0217E994
	mov r0, #0x1a0
	ldr r1, [r1]
	mla r0, r6, r0, r1
	add r6, r0, #0x18c
	add r0, r0, #0x180
	cmp r6, r0
	beq _0217740C
	add r0, r1, r7
	add r0, r0, #0x180
_021773CC:
	ldr r10, [r6]
	ldrh r3, [r6, #8]
	ldrh r2, [r10, #8]
	ldrh r1, [r10, #0xa]
	sub r3, r3, r8
	add r1, r2, r1
	cmp r3, r1
	blt _02177400
	mov r0, r6
	mov r1, r4
	strh r3, [r4, #8]
	bl ovl08_217700C
	b _0217740C
_02177400:
	mov r6, r10
	cmp r10, r0
	bne _021773CC
_0217740C:
	ldr r0, _02177440 // =0x0217E994
	ldr r0, [r0]
	add r0, r0, r7
	add r0, r0, #0x180
	cmp r6, r0
	bne _02177428
	bl OS_Terminate
_02177428:
	ldrh r1, [r4, #8]
	mov r0, r9
	str r1, [r5]
	bl OS_EnableIrqMask
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02177440: .word 0x0217E994
	arm_func_end ovl08_21772C8

	arm_func_start ovl08_2177444
ovl08_2177444: // 0x02177444
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r0, #0x340
	mov r1, #4
	bl ovl08_2176764
	ldr r4, _02177500 // =0x0217E994
	mov r10, #0
	mov r9, r10
	str r0, [r4]
	mov r8, #0x20
	mov r7, #0xc
	mov r6, #0x300
	mov r5, #0x400
_02177474:
	ldr r1, [r4]
	mov r0, r8
	mov r2, r7
	add r1, r1, r9
	bl ovl08_2175764
	ldr r1, [r4]
	add r1, r1, r9
	str r0, [r1, #0x19c]
	bl ovl08_21770AC
	ldr r1, [r4]
	add r1, r1, r9
	str r0, [r1, #0x198]
	ldr r0, [r4]
	add r0, r0, r9
	add r0, r0, #0x100
	strh r6, [r0, #0x88]
	ldr r0, [r4]
	add r0, r0, r9
	add r0, r0, #0x100
	strh r5, [r0, #0x94]
	ldr r0, [r4]
	add r1, r0, r9
	ldr r0, [r1, #0x198]
	add r1, r1, #0x180
	bl ovl08_2176FEC
	ldr r0, [r4]
	add r1, r0, r9
	ldr r0, [r1, #0x198]
	add r1, r1, #0x18c
	bl ovl08_2176FFC
	add r10, r10, #1
	cmp r10, #2
	add r9, r9, #0x1a0
	blt _02177474
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02177500: .word 0x0217E994
	arm_func_end ovl08_2177444

	arm_func_start ovl08_2177504
ovl08_2177504: // 0x02177504
	cmp r1, #0
	mov r3, #0
	ble _02177528
_02177510:
	ldrb r2, [r0, r3]
	cmp r2, #0
	beq _02177528
	add r3, r3, #1
	cmp r3, r1
	blt _02177510
_02177528:
	mov r0, r3
	bx lr
	arm_func_end ovl08_2177504

	arm_func_start ovl08_2177530
ovl08_2177530: // 0x02177530
	ldr ip, _0217753C // =PMi_SendLEDPatternCommand
	mov r0, #1
	bx ip
	.align 2, 0
_0217753C: .word PMi_SendLEDPatternCommand
	arm_func_end ovl08_2177530

	arm_func_start DWCi_SetLedWireless
DWCi_SetLedWireless: // 0x02177540
	stmdb sp!, {lr}
	sub sp, sp, #4
	add r0, sp, #0
	bl PM_GetLEDPattern
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, [sp]
	cmp r0, #0xf
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0xf
	bl PMi_SendLEDPatternCommand
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_SetLedWireless

	arm_func_start ovl08_217757C
ovl08_217757C: // 0x0217757C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _021775F8 // =0x000001F3
	bl GX_SetBankForLCDC
	mov r0, #0
	mov r1, #0x6800000
	mov r2, #0x40000
	bl MIi_CpuClearFast
	ldr r1, _021775FC // =0x06880000
	mov r0, #0
	mov r2, #0x24000
	bl MIi_CpuClearFast
	bl GX_DisableBankForLCDC
	mov r0, #0x200
	mov r1, #0x7000000
	mov r2, #0x400
	bl MIi_CpuClearFast
	mov r0, #0
	mov r1, #0x5000000
	mov r2, #0x400
	bl MIi_CpuClearFast
	mov r0, #0x200
	ldr r1, _02177600 // =0x07000400
	mov r2, #0x400
	bl MIi_CpuClearFast
	mov r0, #0
	ldr r1, _02177604 // =0x05000400
	mov r2, #0x400
	bl MIi_CpuClearFast
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021775F8: .word 0x000001F3
_021775FC: .word 0x06880000
_02177600: .word 0x07000400
_02177604: .word 0x05000400
	arm_func_end ovl08_217757C

	arm_func_start ovl08_2177608
ovl08_2177608: // 0x02177608
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl GX_DisableBankForBG
	bl GX_DisableBankForOBJ
	bl GX_DisableBankForSubBG
	bl GX_DisableBankForSubOBJ
	bl ovl08_217757C
	ldr r0, _02177718 // =0x0217E998
	ldr r0, [r0]
	bl GX_SetBankForBG
	ldr r0, _02177718 // =0x0217E998
	ldr r0, [r0, #4]
	bl GX_SetBankForOBJ
	ldr r0, _02177718 // =0x0217E998
	ldr r0, [r0, #8]
	bl GX_SetBankForBGExtPltt
	ldr r0, _02177718 // =0x0217E998
	ldr r0, [r0, #0xc]
	bl GX_SetBankForOBJExtPltt
	ldr r0, _02177718 // =0x0217E998
	ldr r0, [r0, #0x10]
	bl GX_SetBankForTex
	ldr r0, _02177718 // =0x0217E998
	ldr r0, [r0, #0x14]
	bl GX_SetBankForTexPltt
	ldr r0, _02177718 // =0x0217E998
	ldr r0, [r0, #0x18]
	bl GX_SetBankForClearImage
	ldr r0, _02177718 // =0x0217E998
	ldr r0, [r0, #0x1c]
	bl GX_SetBankForSubBG
	ldr r0, _02177718 // =0x0217E998
	ldr r0, [r0, #0x20]
	bl GX_SetBankForSubOBJ
	ldr r0, _02177718 // =0x0217E998
	ldr r0, [r0, #0x24]
	bl GX_SetBankForSubBGExtPltt
	ldr r0, _02177718 // =0x0217E998
	ldr r0, [r0, #0x28]
	bl GX_SetBankForSubOBJExtPltt
	ldr r0, _02177718 // =0x0217E998
	ldr r0, [r0, #0x30]
	bl GX_SetBankForLCDC
	mov r2, #0
	ldr r1, _0217771C // =0x04000050
	ldr r0, _02177720 // =0x04001050
	strh r2, [r1]
	strh r2, [r0]
	ldr r1, _02177724 // =0x04000010
	ldr r0, _02177728 // =0x04000014
	str r2, [r1]
	str r2, [r0]
	ldr r1, _0217772C // =0x04000018
	ldr r0, _02177730 // =0x0400001C
	str r2, [r1]
	str r2, [r0]
	ldr r1, _02177734 // =0x04001010
	ldr r0, _02177738 // =0x04001014
	str r2, [r1]
	str r2, [r0]
	ldr r1, _0217773C // =0x04001018
	ldr r0, _02177740 // =0x0400101C
	str r2, [r1]
	str r2, [r0]
	mov r0, #1
	bl PM_SetLCDPower
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02177718: .word 0x0217E998
_0217771C: .word 0x04000050
_02177720: .word 0x04001050
_02177724: .word 0x04000010
_02177728: .word 0x04000014
_0217772C: .word 0x04000018
_02177730: .word 0x0400001C
_02177734: .word 0x04001010
_02177738: .word 0x04001014
_0217773C: .word 0x04001018
_02177740: .word 0x0400101C
	arm_func_end ovl08_2177608

	arm_func_start ovl08_2177744
ovl08_2177744: // 0x02177744
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl GX_DisableBankForBG
	ldr r1, _021777FC // =0x0217E998
	str r0, [r1]
	bl GX_DisableBankForOBJ
	ldr r1, _021777FC // =0x0217E998
	str r0, [r1, #4]
	bl GX_DisableBankForBGExtPltt
	ldr r1, _021777FC // =0x0217E998
	str r0, [r1, #8]
	bl GX_DisableBankForOBJExtPltt
	ldr r1, _021777FC // =0x0217E998
	str r0, [r1, #0xc]
	bl GX_DisableBankForTex
	ldr r1, _021777FC // =0x0217E998
	str r0, [r1, #0x10]
	bl GX_DisableBankForTexPltt
	ldr r1, _021777FC // =0x0217E998
	str r0, [r1, #0x14]
	bl GX_DisableBankForClearImage
	ldr r1, _021777FC // =0x0217E998
	str r0, [r1, #0x18]
	bl GX_DisableBankForSubBG
	ldr r1, _021777FC // =0x0217E998
	str r0, [r1, #0x1c]
	bl GX_DisableBankForSubOBJ
	ldr r1, _021777FC // =0x0217E998
	str r0, [r1, #0x20]
	bl GX_DisableBankForSubBGExtPltt
	ldr r1, _021777FC // =0x0217E998
	str r0, [r1, #0x24]
	bl GX_DisableBankForSubOBJExtPltt
	ldr r1, _021777FC // =0x0217E998
	str r0, [r1, #0x28]
	bl GX_DisableBankForARM7
	ldr r1, _021777FC // =0x0217E998
	str r0, [r1, #0x2c]
	bl GX_DisableBankForLCDC
	ldr r1, _021777FC // =0x0217E998
	str r0, [r1, #0x30]
	ldr r0, [r1, #0x2c]
	bl GX_SetBankForARM7
	bl ovl08_217757C
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_021777FC: .word 0x0217E998
	arm_func_end ovl08_2177744

	arm_func_start ovl08_2177800
ovl08_2177800: // 0x02177800
	ldr r2, _02177814 // =0x0217E9CC
	ldr r2, [r2]
	add r0, r2, r0, lsl #6
	strb r1, [r0, #0x38]
	bx lr
	.align 2, 0
_02177814: .word 0x0217E9CC
	arm_func_end ovl08_2177800

	arm_func_start ovl08_2177818
ovl08_2177818: // 0x02177818
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	ldrb r1, [r4, #0x11]
	mov r5, r0
	cmp r1, #0
	beq _0217783C
	add r0, r4, #0xc
	bl ovl08_2176714
_0217783C:
	mov r0, r4
	bl ovl08_2177048
	ldr r0, _02177860 // =0x0217E9CC
	mov r1, r4
	ldr r0, [r0]
	ldr r0, [r0, r5, lsl #6]
	bl ovl08_21756E0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02177860: .word 0x0217E9CC
	arm_func_end ovl08_2177818

	arm_func_start ovl08_2177864
ovl08_2177864: // 0x02177864
	ldr ip, _0217786C // =ovl08_2177818
	bx ip
	.align 2, 0
_0217786C: .word ovl08_2177818
	arm_func_end ovl08_2177864

	arm_func_start ovl08_2177870
ovl08_2177870: // 0x02177870
	ldr r2, _02177888 // =0x0217E9CC
	ldr ip, _0217788C // =ovl08_21756E0
	ldr r2, [r2]
	add r0, r2, r0, lsl #6
	ldr r0, [r0, #4]
	bx ip
	.align 2, 0
_02177888: .word 0x0217E9CC
_0217788C: .word ovl08_21756E0
	arm_func_end ovl08_2177870

	arm_func_start ovl08_2177890
ovl08_2177890: // 0x02177890
	str r1, [r0, #8]
	bx lr
	arm_func_end ovl08_2177890

	arm_func_start ovl08_2177898
ovl08_2177898: // 0x02177898
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r4, _02177920 // =0x0217E9CC
	mov r7, r0
	ldr r0, [r4]
	mov r8, r1
	ldr r0, [r0, r7, lsl #6]
	mov r4, r2
	mov r6, r3
	bl ovl08_2175688
	mov r5, r0
	str r8, [r5, #8]
	str r4, [r5, #0xc]
	ldrb r1, [sp, #0x18]
	strb r6, [r5, #0x10]
	mov r0, #1
	strb r1, [r5, #0x11]
	bl OS_DisableIrqMask
	ldr r1, _02177920 // =0x0217E9CC
	mov r4, r0
	ldr r0, [r1]
	add r0, r0, r7, lsl #6
	ldr r0, [r0, #0x10]
_021778F0:
	ldrb r1, [r0, #0x10]
	cmp r6, r1
	bhs _02177908
	mov r1, r5
	bl ovl08_217700C
	b _02177910
_02177908:
	ldr r0, [r0, #4]
	b _021778F0
_02177910:
	mov r0, r4
	bl OS_EnableIrqMask
	mov r0, r5
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02177920: .word 0x0217E9CC
	arm_func_end ovl08_2177898

	arm_func_start ovl08_2177924
ovl08_2177924: // 0x02177924
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov ip, #0
	str ip, [sp]
	bl ovl08_2177898
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ovl08_2177924

	arm_func_start DWCi_TSKlAct
DWCi_TSKlAct: // 0x02177940
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r7, _02177A04 // =0x0217E9CC
	mov r6, r0
	ldr r0, [r7]
	mov r4, r6, lsl #6
	add r2, r0, r6, lsl #6
	ldrb r1, [r2, #0x38]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r5, [r2, #0x10]
	add r1, r2, #0x20
	cmp r5, r1
	beq _021779A4
_0217797C:
	ldr r1, [r5, #0xc]
	ldr r2, [r5, #8]
	mov r0, r5
	blx r2
	ldr r0, [r7]
	ldr r5, [r5, #4]
	add r1, r0, r4
	add r1, r1, #0x20
	cmp r5, r1
	bne _0217797C
_021779A4:
	add r1, r0, r6, lsl #6
	ldr r1, [r1, #0x34]
	mov r4, r6, lsl #6
	cmp r1, #0
	mov r5, #0
	addle sp, sp, #4
	ldmleia sp!, {r4, r5, r6, r7, pc}
	ldr r7, _02177A04 // =0x0217E9CC
_021779C4:
	add r0, r4, r0
	ldr r0, [r0, #4]
	bl ovl08_2175688
	movs r1, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r6
	bl ovl08_2177818
	ldr r0, [r7]
	add r5, r5, #1
	add r1, r4, r0
	ldr r1, [r1, #0x34]
	cmp r5, r1
	blt _021779C4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02177A04: .word 0x0217E9CC
	arm_func_end DWCi_TSKlAct

	arm_func_start ovl08_2177A08
ovl08_2177A08: // 0x02177A08
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r4, _02177A50 // =0x0217E9CC
	mov r5, #0
_02177A18:
	ldr r0, [r4]
	add r0, r0, r5, lsl #6
	ldr r0, [r0, #8]
	bl ovl08_2177088
	ldr r0, [r4]
	ldr r0, [r0, r5, lsl #6]
	bl ovl08_2175740
	add r5, r5, #1
	cmp r5, #2
	blt _02177A18
	ldr r0, _02177A50 // =0x0217E9CC
	bl ovl08_2176714
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02177A50: .word 0x0217E9CC
	arm_func_end ovl08_2177A08

	arm_func_start ovl08_2177A54
ovl08_2177A54: // 0x02177A54
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r0, #0x80
	mov r1, #4
	bl ovl08_2176788
	ldr r4, _02177B78 // =0x0217E9CC
	mov r10, #0
	ldr r9, _02177B7C // =0x0217B02C
	mov r8, r10
	str r0, [r4]
	str r10, [sp]
	mov r7, #4
	mov r11, #0x14
	mov r6, #0xff
	mov r5, #1
_02177A90:
	ldr r0, [r4]
	ldrb r2, [r9]
	add r1, r0, r10, lsl #6
	mov r0, #0x14
	str r2, [r1, #0x34]
	ldrb r2, [r9]
	mov r1, r7
	mul r0, r2, r0
	bl ovl08_2176788
	ldr r1, [r4]
	mov r2, r11
	add r1, r1, r10, lsl #6
	str r0, [r1, #0x3c]
	ldr r1, [r4]
	ldrb r0, [r9]
	add r1, r1, r10, lsl #6
	ldr r1, [r1, #0x3c]
	bl ovl08_2175764
	ldr r1, [r4]
	str r0, [r1, r10, lsl #6]
	ldrb r0, [r9]
	bl ovl08_21757A4
	ldr r1, [r4]
	add r1, r1, r10, lsl #6
	str r0, [r1, #4]
	bl ovl08_21770AC
	ldr r1, [r4]
	add r1, r1, r10, lsl #6
	str r0, [r1, #8]
	ldr r0, [r4]
	add r1, r0, r10, lsl #6
	ldr r0, [sp]
	strb r0, [r1, #0x1c]
	ldr r0, [r4]
	add r0, r0, r10, lsl #6
	strb r6, [r0, #0x30]
	ldr r1, [r4]
	add r0, r1, r10, lsl #6
	add r1, r1, r8
	ldr r0, [r0, #8]
	add r1, r1, #0xc
	bl ovl08_2176FEC
	ldr r1, [r4]
	add r0, r1, r10, lsl #6
	add r1, r1, r8
	ldr r0, [r0, #8]
	add r1, r1, #0x20
	bl ovl08_2176FFC
	ldr r0, [r4]
	add r9, r9, #1
	add r0, r0, r10, lsl #6
	add r10, r10, #1
	strb r5, [r0, #0x38]
	add r8, r8, #0x40
	cmp r10, #2
	blt _02177A90
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02177B78: .word 0x0217E9CC
_02177B7C: .word 0x0217B02C
	arm_func_end ovl08_2177A54

	.rodata
	
aJefgisk: // 0x0217A580
	.asciz "jefgisk"
_0217A588:
	.byte 0x80, 0x04, 0x00, 0x00, 0x80, 0x02, 0x00, 0x00
	.byte 0x80, 0x02, 0x00, 0x00, 0x80, 0x02, 0x00, 0x00, 0x80, 0x02, 0x00, 0x00, 0x80, 0x02, 0x00, 0x00
	.byte 0x80, 0x02, 0x00, 0x00, 0x6B, 0x00, 0x22, 0x00, 0x6C, 0x00, 0x22, 0x00, 0x7C, 0x00, 0x22, 0x00
	.byte 0x5D, 0x00, 0x22, 0x00, 0x5F, 0x00, 0x22, 0x00, 0x7D, 0x00, 0x22, 0x00, 0x50, 0x00, 0x22, 0x00
	.byte 0x0A, 0x0B, 0x04, 0x05, 0x02, 0x03, 0x0C, 0x0D, 0xE5, 0x00, 0x26, 0x00, 0x18, 0x17, 0x16, 0x15
	.byte 0x5F, 0x5E, 0x5D, 0x5C, 0x02, 0x03, 0x00, 0x00, 0x04, 0x05, 0x00, 0x00, 0x3C, 0x3D, 0x00, 0x00
	.byte 0x82, 0x83, 0x00, 0x00, 0x3A, 0x3B, 0x35, 0x39, 0x1C, 0x00, 0x02, 0x00, 0x78, 0x00, 0x12, 0x00
	.byte 0x11, 0x00, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x0C, 0x0C, 0x0C, 0x0B
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x20, 0x80
	.byte 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0xAA, 0x00, 0x84, 0x00, 0xAA, 0x00, 0x04, 0x00, 0x67, 0x00
	.byte 0x04, 0x00, 0x7D, 0x00, 0x04, 0x00, 0x93, 0x00, 0xDC, 0x00, 0x51, 0x00, 0x1B, 0x00, 0x12, 0x00
	.byte 0x20, 0x00, 0x12, 0x00, 0x28, 0x00, 0x12, 0x00, 0x20, 0x00, 0x12, 0x00, 0x04, 0x00, 0x51, 0x00
	.byte 0x16, 0x00, 0x51, 0x00, 0x28, 0x00, 0x51, 0x00, 0x3A, 0x00, 0x51, 0x00, 0x4C, 0x00, 0x51, 0x00
	.byte 0x5E, 0x00, 0x51, 0x00, 0x70, 0x00, 0x51, 0x00, 0x82, 0x00, 0x51, 0x00, 0x94, 0x00, 0x51, 0x00
	.byte 0xA6, 0x00, 0x51, 0x00, 0xB8, 0x00, 0x51, 0x00, 0xCA, 0x00, 0x51, 0x00, 0x20, 0x00, 0x67, 0x00
	.byte 0x32, 0x00, 0x67, 0x00, 0x44, 0x00, 0x67, 0x00, 0x56, 0x00, 0x67, 0x00, 0x68, 0x00, 0x67, 0x00
	.byte 0x7A, 0x00, 0x67, 0x00, 0x8C, 0x00, 0x67, 0x00, 0x9E, 0x00, 0x67, 0x00, 0xB0, 0x00, 0x67, 0x00
	.byte 0xC2, 0x00, 0x67, 0x00, 0xD4, 0x00, 0x67, 0x00, 0xE6, 0x00, 0x67, 0x00, 0x25, 0x00, 0x7D, 0x00
	.byte 0x37, 0x00, 0x7D, 0x00, 0x49, 0x00, 0x7D, 0x00, 0x5B, 0x00, 0x7D, 0x00, 0x6D, 0x00, 0x7D, 0x00
	.byte 0x7F, 0x00, 0x7D, 0x00, 0x91, 0x00, 0x7D, 0x00, 0xA3, 0x00, 0x7D, 0x00, 0xB5, 0x00, 0x7D, 0x00
	.byte 0xC7, 0x00, 0x7D, 0x00, 0xD9, 0x00, 0x7D, 0x00, 0xEB, 0x00, 0x7D, 0x00, 0x2D, 0x00, 0x93, 0x00
	.byte 0x3F, 0x00, 0x93, 0x00, 0x51, 0x00, 0x93, 0x00, 0x63, 0x00, 0x93, 0x00, 0x75, 0x00, 0x93, 0x00
	.byte 0x87, 0x00, 0x93, 0x00, 0x99, 0x00, 0x93, 0x00, 0xAB, 0x00, 0x93, 0x00, 0xBD, 0x00, 0x93, 0x00
	.byte 0xCF, 0x00, 0x93, 0x00, 0xE1, 0x00, 0x93, 0x00, 0x02, 0x00, 0x4F, 0x00, 0x14, 0x00, 0x4F, 0x00
	.byte 0x26, 0x00, 0x4F, 0x00, 0x38, 0x00, 0x4F, 0x00, 0x4A, 0x00, 0x4F, 0x00, 0x5C, 0x00, 0x4F, 0x00
	.byte 0x6E, 0x00, 0x4F, 0x00, 0x80, 0x00, 0x4F, 0x00, 0x92, 0x00, 0x4F, 0x00, 0xA4, 0x00, 0x4F, 0x00
	.byte 0xB6, 0x00, 0x4F, 0x00, 0xC8, 0x00, 0x4F, 0x00, 0x1E, 0x00, 0x65, 0x00, 0x30, 0x00, 0x65, 0x00
	.byte 0x42, 0x00, 0x65, 0x00, 0x54, 0x00, 0x65, 0x00, 0x66, 0x00, 0x65, 0x00, 0x78, 0x00, 0x65, 0x00
	.byte 0x8A, 0x00, 0x65, 0x00, 0x9C, 0x00, 0x65, 0x00, 0xAE, 0x00, 0x65, 0x00, 0xC0, 0x00, 0x65, 0x00
	.byte 0xD2, 0x00, 0x65, 0x00, 0xE4, 0x00, 0x65, 0x00, 0x23, 0x00, 0x7B, 0x00, 0x35, 0x00, 0x7B, 0x00
	.byte 0x47, 0x00, 0x7B, 0x00, 0x59, 0x00, 0x7B, 0x00, 0x6B, 0x00, 0x7B, 0x00, 0x7D, 0x00, 0x7B, 0x00
	.byte 0x8F, 0x00, 0x7B, 0x00, 0xA1, 0x00, 0x7B, 0x00, 0xB3, 0x00, 0x7B, 0x00, 0xC5, 0x00, 0x7B, 0x00
	.byte 0xD7, 0x00, 0x7B, 0x00, 0xE9, 0x00, 0x7B, 0x00, 0x2B, 0x00, 0x91, 0x00, 0x3D, 0x00, 0x91, 0x00
	.byte 0x4F, 0x00, 0x91, 0x00, 0x61, 0x00, 0x91, 0x00, 0x73, 0x00, 0x91, 0x00, 0x85, 0x00, 0x91, 0x00
	.byte 0x97, 0x00, 0x91, 0x00, 0xA9, 0x00, 0x91, 0x00, 0xBB, 0x00, 0x91, 0x00, 0xCD, 0x00, 0x91, 0x00
	.byte 0xDF, 0x00, 0x91, 0x00, 0x02, 0x00, 0x65, 0x00, 0x02, 0x00, 0x7B, 0x00, 0x02, 0x00, 0x91, 0x00
	.byte 0xDA, 0x00, 0x4F, 0x00, 0x02, 0x00, 0xA8, 0x00, 0x82, 0x00, 0xA8, 0x00, 0x32, 0x33, 0x01, 0x2F
	.byte 0x00, 0x33, 0x02, 0x0C, 0x01, 0x33, 0x03, 0x0D, 0x02, 0x33, 0x04, 0x0E, 0x03, 0x33, 0x05, 0x0F
	.byte 0x04, 0x33, 0x06, 0x10, 0x05, 0x34, 0x07, 0x11, 0x06, 0x34, 0x08, 0x12, 0x07, 0x34, 0x09, 0x13
	.byte 0x08, 0x34, 0x0A, 0x14, 0x09, 0x34, 0x0B, 0x15, 0x0A, 0x34, 0x32, 0x16, 0x2F, 0x01, 0x0D, 0x18
	.byte 0x0C, 0x02, 0x0E, 0x19, 0x0D, 0x03, 0x0F, 0x1A, 0x0E, 0x04, 0x10, 0x1B, 0x0F, 0x05, 0x11, 0x1C
	.byte 0x10, 0x06, 0x12, 0x1D, 0x11, 0x07, 0x13, 0x1E, 0x12, 0x08, 0x14, 0x1F, 0x13, 0x09, 0x15, 0x20
	.byte 0x14, 0x0A, 0x16, 0x21, 0x15, 0x0B, 0x17, 0x22, 0x16, 0x32, 0x2F, 0x23, 0x30, 0x0C, 0x19, 0x24
	.byte 0x18, 0x0D, 0x1A, 0x25, 0x19, 0x0E, 0x1B, 0x26, 0x1A, 0x0F, 0x1C, 0x27, 0x1B, 0x10, 0x1D, 0x28
	.byte 0x1C, 0x11, 0x1E, 0x29, 0x1D, 0x12, 0x1F, 0x2A, 0x1E, 0x13, 0x20, 0x2B, 0x1F, 0x14, 0x21, 0x2C
	.byte 0x20, 0x15, 0x22, 0x2D, 0x21, 0x16, 0x23, 0x2E, 0x22, 0x17, 0x30, 0x2E, 0x31, 0x18, 0x25, 0x33
	.byte 0x24, 0x19, 0x26, 0x33, 0x25, 0x1A, 0x27, 0x33, 0x26, 0x1B, 0x28, 0x33, 0x27, 0x1C, 0x29, 0x33
	.byte 0x28, 0x1D, 0x2A, 0x34, 0x29, 0x1E, 0x2B, 0x34, 0x2A, 0x1F, 0x2C, 0x34, 0x2B, 0x20, 0x2D, 0x34
	.byte 0x2C, 0x21, 0x2E, 0x34, 0x2D, 0xFF, 0x31, 0x34, 0x17, 0x00, 0x0C, 0x30, 0x23, 0x2F, 0x18, 0x31
	.byte 0x2E, 0x30, 0x24, 0x33, 0x0B, 0x34, 0x00, 0x17, 0x34, 0xFE, 0x34, 0xFC, 0x33, 0xFD, 0x33, 0xFB
	.byte 0x04, 0x05, 0x00, 0x00, 0x37, 0x38, 0x00, 0x00, 0x3C, 0x3D, 0x00, 0x00, 0x02, 0x03, 0x00, 0x00
	.byte 0x12, 0x13, 0x00, 0x00, 0x10, 0x11, 0x00, 0x00, 0x1C, 0x00, 0x14, 0x00, 0x0C, 0x00, 0x04, 0x00
	.byte 0x1C, 0x00, 0x14, 0x00, 0x78, 0x00, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00
	.byte 0x03, 0x03, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x72, 0x00, 0x91, 0x00, 0x92, 0x00, 0x91, 0x00
	.byte 0x04, 0x00, 0xAA, 0x00, 0x84, 0x00, 0xAA, 0x00
a7894561230: // 0x0217A8F8
	.asciz "7894561230"
_0217A903:
	.byte 0x00, 0x37, 0x00, 0x38, 0x00, 0x39, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00
	.byte 0x31, 0x00, 0x32, 0x00, 0x33, 0x00, 0x30, 0x00, 0x20, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x52, 0x00, 0x4C, 0x00, 0x72, 0x00, 0x4C, 0x00, 0x92, 0x00, 0x4C, 0x00, 0x52, 0x00, 0x63, 0x00
	.byte 0x72, 0x00, 0x63, 0x00, 0x92, 0x00, 0x63, 0x00, 0x52, 0x00, 0x7A, 0x00, 0x72, 0x00, 0x7A, 0x00
	.byte 0x92, 0x00, 0x7A, 0x00, 0x52, 0x00, 0x91, 0x00, 0x50, 0x00, 0x4A, 0x00, 0x70, 0x00, 0x4A, 0x00
	.byte 0x90, 0x00, 0x4A, 0x00, 0x50, 0x00, 0x61, 0x00, 0x70, 0x00, 0x61, 0x00, 0x90, 0x00, 0x61, 0x00
	.byte 0x50, 0x00, 0x78, 0x00, 0x70, 0x00, 0x78, 0x00, 0x90, 0x00, 0x78, 0x00, 0x50, 0x00, 0x8F, 0x00
	.byte 0x70, 0x00, 0x8F, 0x00, 0x90, 0x00, 0x8F, 0x00, 0x02, 0x00, 0xA8, 0x00, 0x82, 0x00, 0xA8, 0x00
	.byte 0x02, 0x0C, 0x01, 0x03, 0x00, 0x0D, 0x02, 0x04, 0x01, 0x0D, 0x00, 0x05, 0x05, 0x00, 0x04, 0x06
	.byte 0x03, 0x01, 0x05, 0x07, 0x04, 0x02, 0x03, 0x08, 0x08, 0x03, 0x07, 0x09, 0x06, 0x04, 0x08, 0x0A
	.byte 0x07, 0x05, 0x06, 0x0B, 0x0B, 0x06, 0x0A, 0x0C, 0x09, 0x07, 0x0B, 0x0D, 0x0A, 0x08, 0x09, 0x0D
	.byte 0x0D, 0x09, 0x0D, 0x00, 0x0C, 0xFF, 0x0C, 0xFE
	
aNintendoDs_0: // 0x0217A9B8
	.asciz "NINTENDO-DS"
_0217A9C4:
	.byte 0x01, 0x02, 0x00, 0x00, 0x08, 0x00, 0x20, 0x00, 0xAC, 0x00, 0xA0, 0x00
	.byte 0xB4, 0x00, 0x20, 0x00, 0xF8, 0x00, 0xA0, 0x00, 0x06, 0x00, 0x1E, 0x00, 0x9E, 0x00, 0x92, 0x00
	.byte 0xB2, 0x00, 0x1E, 0x00, 0xEA, 0x00, 0x92, 0x00
aCharYbbgstep11: // 0x0217A9E8
	.asciz "char/ybBgStep11.ncl.l"
_0217A9FE:
	.byte 0x00, 0x00
	.byte 0x08, 0x00, 0x40, 0x00, 0xF0, 0x00, 0x1C, 0x00, 0x08, 0x00, 0x78, 0x00, 0xF0, 0x00, 0x1C, 0x00
	.byte 0x01, 0x02, 0x03, 0x00, 0xE0, 0x00, 0x84, 0x00
aCharYbbgoption: // 0x0217AA18
	.asciz "char/ybBgOption.ncl.l"
_0217AA2E:
	.byte 0x00, 0x00
aCharYbbgoption_0: // 0x0217AA30
	.asciz "char/ybBgOption1.ncl.l"
_0217AA47:
	.byte 0x00, 0x08, 0x00, 0x24, 0x00, 0xF8, 0x00, 0x44, 0x00
	.byte 0x08, 0x00, 0x50, 0x00, 0xF8, 0x00, 0x70, 0x00, 0x08, 0x00, 0x7C, 0x00, 0xF8, 0x00, 0x9C, 0x00
	.byte 0x06, 0x00, 0x22, 0x00, 0xEA, 0x00, 0x36, 0x00, 0x06, 0x00, 0x4E, 0x00, 0xEA, 0x00, 0x62, 0x00
	.byte 0x06, 0x00, 0x7A, 0x00, 0xEA, 0x00, 0x8E, 0x00, 0x08, 0x00, 0x35, 0x00, 0xF8, 0x00, 0x51, 0x00
	.byte 0x02, 0x00, 0x00, 0x00, 0x2E, 0x2D, 0x33, 0x00, 0x18, 0x17, 0x16, 0x15
aCharYbbgstep31: // 0x0217AA8C
	.asciz "char/ybBgStep31.ncl.l"
_0217AAA2:
	.byte 0x00, 0x00
aCharXb4aplistb: // 0x0217AAA4
	.asciz "char/xb4ApListBack.nsc.l"
_0217AABD:
	.byte 0x00, 0x00, 0x00
	.byte 0x07, 0x00, 0x32, 0x00, 0xD0, 0x00, 0x4C, 0x00, 0x07, 0x00, 0x4E, 0x00, 0xD0, 0x00, 0x68, 0x00
	.byte 0x07, 0x00, 0x6A, 0x00, 0xD0, 0x00, 0x84, 0x00, 0x07, 0x00, 0x86, 0x00, 0xD0, 0x00, 0xA0, 0x00
	.byte 0x85, 0x00, 0x1B, 0x00, 0xFD, 0x00, 0x2C, 0x00, 0x04, 0x00, 0x2E, 0x00, 0xDB, 0x00, 0x3F, 0x00
	.byte 0x04, 0x00, 0x4A, 0x00, 0xDB, 0x00, 0x5B, 0x00, 0x04, 0x00, 0x66, 0x00, 0xDB, 0x00, 0x77, 0x00
	.byte 0x04, 0x00, 0x82, 0x00, 0xDB, 0x00, 0x93, 0x00, 0x82, 0x00, 0x18, 0x00, 0xF0, 0x00, 0x2C, 0x00
	.byte 0x3E, 0x3D, 0x00, 0x00, 0x20, 0x31, 0x00, 0x00, 0x0E, 0x00, 0x10, 0x00, 0x47, 0x00, 0x00, 0x00
	.byte 0x48, 0x00, 0x00, 0x00, 0xEC, 0xF7, 0x16, 0x02, 0x40, 0xF6, 0x16, 0x02, 0x08, 0x17, 0x26, 0x35
	.byte 0x44, 0x53, 0x62, 0x71, 0x80, 0x8F, 0x9E, 0xAD, 0xBC, 0xCB, 0xDA, 0xE9, 0x32, 0x35, 0x35, 0x00
	.byte 0x0B, 0x00, 0x10, 0x00
aAbc: // 0x0217AB44
	.asciz "?@ABC"
_0217AB4A:
	.byte 0x00, 0x00, 0x00, 0x00, 0x29, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x31, 0x3D, 0x49, 0x5A, 0x66, 0x72, 0x83, 0x8F, 0x9B, 0xAC, 0xB8, 0xC4
	.byte 0x34, 0xF5, 0x16, 0x02, 0xF0, 0xF4, 0x16, 0x02, 0xA4, 0xF4, 0x16, 0x02, 0x58, 0xF4, 0x16, 0x02
	.byte 0x0C, 0xF4, 0x16, 0x02, 0x24, 0xF6, 0x16, 0x02, 0x08, 0xF6, 0x16, 0x02, 0xE4, 0xF5, 0x16, 0x02
	.byte 0xC0, 0xF5, 0x16, 0x02, 0x9C, 0xF5, 0x16, 0x02, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00
	.byte 0x0D, 0x00, 0x3C, 0x00, 0xE6, 0x00, 0x5E, 0x00, 0x62, 0x00, 0x22, 0x00, 0x62, 0x00, 0x22, 0x00
	.byte 0x3D, 0x00, 0x22, 0x00, 0x65, 0x00, 0x22, 0x00, 0x6C, 0x00, 0x22, 0x00, 0x34, 0x00, 0x22, 0x00
	.byte 0x4E, 0x00, 0x22, 0x00, 0x06, 0x08, 0x07, 0x00, 0x02, 0x03, 0x07, 0x08, 0xFF, 0x23, 0x27, 0xFF
	.byte 0x23, 0x2F, 0xFF, 0x00, 0xCC, 0x00, 0x34, 0x00, 0x1C, 0x00, 0x18, 0x00, 0x8F, 0x00, 0x34, 0x00
	.byte 0x2C, 0x00, 0x18, 0x00, 0xC0, 0x00, 0x34, 0x00, 0x2C, 0x00, 0x18, 0x00, 0x00, 0x01, 0x0E, 0x04
	.byte 0x05, 0x06, 0x0E, 0x09, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x05, 0x02, 0x07, 0x04, 0x01, 0x06, 0x03
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x02, 0x03, 0x04, 0x05, 0x06, 0x06, 0x07, 0x08, 0x00
	.byte 0x00, 0x00, 0x01, 0x02, 0x00, 0x00, 0x00, 0x01, 0x02, 0x00, 0x00, 0x03, 0x04, 0x05, 0x00, 0x00
	.byte 0x00, 0x29, 0x2C, 0x52, 0x53, 0x30, 0x00, 0x2A, 0x30, 0x54, 0x55, 0x00, 0x00, 0x2B, 0x00, 0x00
	.byte 0x00, 0x00, 0x60, 0x00, 0xE0, 0x00, 0x40, 0x01, 0xC0, 0x01, 0x40, 0x02, 0xA0, 0x02, 0x20, 0x03
	.byte 0xA0, 0x03, 0x00, 0x00
aCharYbbgstep2N: // 0x0217AC34
	.asciz "char/ybBgStep2.ncl.l"
_0217AC49:
	.byte 0x00, 0x00, 0x00
aCharYbbgstep21: // 0x0217AC4C
	.asciz "char/ybBgStep21.ncl.l"
_0217AC62:
	.byte 0x00, 0x00
aCharJb3listbac: // 0x0217AC64
	.asciz "char/jb3ListBack.nsc.l"
_0217AC7B:
	.byte 0x00, 0x84, 0x00, 0x1B, 0x00
	.byte 0xFC, 0x00, 0x2C, 0x00, 0x84, 0x00, 0xAC, 0x00, 0xFC, 0x00, 0xBD, 0x00, 0x04, 0x00, 0xAC, 0x00
	.byte 0x7C, 0x00, 0xBD, 0x00, 0xC8, 0x00, 0x31, 0x00, 0xE0, 0x00, 0x4D, 0x00, 0xBC, 0x00, 0x31, 0x00
	.byte 0xE0, 0x00, 0x4D, 0x00, 0x8B, 0x00, 0x31, 0x00, 0xAF, 0x00, 0x4D, 0x00, 0x82, 0x00, 0x18, 0x00
	.byte 0xEE, 0x00, 0x2C, 0x00, 0x82, 0x00, 0xA9, 0x00, 0xEE, 0x00, 0xBD, 0x00, 0x02, 0x00, 0xA9, 0x00
	.byte 0x6E, 0x00, 0xBD, 0x00, 0x13, 0x14, 0x12, 0x56, 0x03, 0x04, 0x05, 0x07, 0x0A, 0x09, 0x0B, 0x06
	.byte 0x03, 0x2D, 0x27, 0x1D, 0x32, 0x30, 0x06, 0x00
aCharYbbgstep11_0: // 0x0217ACD8
	.asciz "char/ybBgStep11.ncl.l"
_0217ACEE:
	.byte 0x00, 0x00
	.byte 0x08, 0x00, 0x30, 0x00, 0x5A, 0x00, 0x30, 0x00, 0xAC, 0x00, 0x30, 0x00, 0x0C, 0x00, 0x58, 0x00
	.byte 0x5E, 0x00, 0x58, 0x00, 0xB0, 0x00, 0x58, 0x00, 0x08, 0x00, 0x20, 0x00, 0x54, 0x00, 0x56, 0x00
	.byte 0x5A, 0x00, 0x20, 0x00, 0xA6, 0x00, 0x56, 0x00, 0xAC, 0x00, 0x20, 0x00, 0xF8, 0x00, 0x56, 0x00
	.byte 0x08, 0x00, 0x78, 0x00, 0xF8, 0x00, 0xA0, 0x00, 0x08, 0x00, 0x54, 0x00, 0x54, 0x00, 0x70, 0x00
	.byte 0x5A, 0x00, 0x54, 0x00, 0xA6, 0x00, 0x70, 0x00, 0xAC, 0x00, 0x54, 0x00, 0xF8, 0x00, 0x70, 0x00
	.byte 0x06, 0x00, 0x1E, 0x00, 0x46, 0x00, 0x48, 0x00, 0x58, 0x00, 0x1E, 0x00, 0x98, 0x00, 0x48, 0x00
	.byte 0xAA, 0x00, 0x1E, 0x00, 0xEA, 0x00, 0x48, 0x00, 0x06, 0x00, 0x76, 0x00, 0xEA, 0x00, 0x92, 0x00
	.byte 0x09, 0x00, 0x54, 0x00, 0x43, 0x00, 0x70, 0x00, 0x5B, 0x00, 0x54, 0x00, 0x95, 0x00, 0x70, 0x00
	.byte 0xAD, 0x00, 0x54, 0x00, 0xE7, 0x00, 0x70, 0x00, 0x01, 0x02, 0x03, 0x04, 0x03, 0xFF, 0xFF, 0xFF
	.byte 0xFF, 0xFF, 0x06, 0x00
aCharYbbgstep21_0: // 0x0217AD84
	.asciz "char/ybBgStep21.ncl.l"
_0217AD9A:
	.byte 0x00, 0x00, 0xFF, 0xFE, 0xFF, 0xFE
	.byte 0x03, 0x00, 0x03, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0x00, 0x01, 0x00, 0xFF, 0xFE, 0xFF, 0xFE
	.byte 0x03, 0x00, 0x02, 0x00, 0x01, 0x00, 0x03, 0x00, 0x02, 0x00, 0x01, 0x00, 0x08, 0x00, 0x20, 0x00
	.byte 0xF8, 0x00, 0x5C, 0x00, 0x08, 0x00, 0x64, 0x00, 0x7E, 0x00, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x83, 0x00, 0x64, 0x00, 0xF8, 0x00, 0xA0, 0x00, 0x08, 0x00, 0x20, 0x00
	.byte 0xF8, 0x00, 0x5C, 0x00, 0x08, 0x00, 0x64, 0x00, 0x64, 0x00, 0xA0, 0x00, 0x68, 0x00, 0x64, 0x00
	.byte 0xC4, 0x00, 0xA0, 0x00, 0xC8, 0x00, 0x64, 0x00, 0xF8, 0x00, 0xA0, 0x00, 0x06, 0x00, 0x1E, 0x00
	.byte 0xEA, 0x00, 0x4E, 0x00, 0x06, 0x00, 0x62, 0x00, 0x70, 0x00, 0x92, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x62, 0x00, 0xEA, 0x00, 0x92, 0x00, 0x06, 0x00, 0x1E, 0x00
	.byte 0xEA, 0x00, 0x4E, 0x00, 0x06, 0x00, 0x62, 0x00, 0x56, 0x00, 0x92, 0x00, 0x66, 0x00, 0x62, 0x00
	.byte 0xB6, 0x00, 0x92, 0x00, 0xC6, 0x00, 0x62, 0x00, 0xEA, 0x00, 0x92, 0x00, 0xEC, 0xC6, 0x16, 0x02
	.byte 0xDC, 0xC6, 0x16, 0x02, 0x03, 0x01, 0x00, 0x00, 0x2B, 0x00, 0x00, 0x00, 0x2B, 0x00, 0x00, 0x00
	.byte 0x49, 0x00, 0x00, 0x00, 0x10, 0x0F, 0x0E, 0x00, 0x55, 0x36, 0x1E, 0x00, 0x00, 0x50, 0xF2, 0x01
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0xFF, 0x3F
	.byte 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x01, 0x00, 0x05, 0x00, 0x06, 0x04, 0x00, 0x02, 0x00, 0x06, 0x04, 0x00, 0x05, 0x00, 0x03, 0x00
	.byte 0x02, 0x01, 0x03, 0x01, 0x03, 0x05, 0x01, 0x04, 0x01, 0x05, 0x07, 0x01, 0x07, 0x01, 0x06, 0x00
	.byte 0x20, 0x00, 0x21, 0x00, 0x50, 0x00, 0x30, 0x00, 0x68, 0x00, 0x21, 0x00, 0x98, 0x00, 0x30, 0x00
	.byte 0xB0, 0x00, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
aNwcusbap_1: // 0x0217AEEC
	.asciz "NWCUSBAP"
_0217AEF5:
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0xFF, 0x3F
	.byte 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x02, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x08, 0x00
	.byte 0x00, 0x00, 0x46, 0x46, 0x4F, 0x2F, 0x00, 0x00, 0x02, 0x01, 0x02, 0x01, 0x02, 0x00, 0x00, 0x00
	.byte 0x01, 0x01, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00, 0x04, 0x00, 0x1D, 0x00, 0xFC, 0x00, 0x44, 0x00
	.byte 0x00, 0x01, 0x01, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0xFF
	.byte 0x01, 0x00, 0x00, 0xFF, 0x01, 0x00, 0x00, 0x00, 0x1B, 0x19, 0x57, 0x00, 0x23, 0x1D, 0x59, 0x00
	.byte 0x23, 0x1D, 0x00, 0x00, 0x6C, 0x00, 0x10, 0x00, 0x6C, 0x00, 0x10, 0x00, 0x78, 0x00, 0x10, 0x00
	.byte 0x78, 0x00, 0x10, 0x00, 0x78, 0x00, 0x10, 0x00, 0xD8, 0x00, 0x50, 0x00, 0xD8, 0x00, 0x50, 0x00
	.byte 0xE6, 0x00, 0x4F, 0x00, 0xE6, 0x00, 0x4F, 0x00, 0xE6, 0x00, 0x48, 0x00, 0xDA, 0x00, 0x5C, 0x00
	.byte 0x0B, 0x00, 0x27, 0x00, 0x0B, 0x00, 0x27, 0x00, 0x04, 0x00, 0x4C, 0x00, 0x04, 0x00, 0x4C, 0x00
	.byte 0x04, 0x00, 0x54, 0x00, 0x0B, 0x00, 0x27, 0x00, 0xEA, 0x00, 0x72, 0x00, 0xEA, 0x00, 0x72, 0x00
	.byte 0xF8, 0x00, 0x70, 0x00, 0xF8, 0x00, 0x70, 0x00, 0x64, 0x00, 0x70, 0x00, 0xEA, 0x00, 0x72, 0x00
	.byte 0x10, 0x00, 0x84, 0x00, 0x84, 0x00, 0x84, 0x00, 0x10, 0x00, 0x84, 0x00, 0x84, 0x00, 0x84, 0x00
	.byte 0x09, 0x00, 0xA7, 0x00, 0x83, 0x00, 0xA7, 0x00, 0x09, 0x00, 0xA7, 0x00, 0x83, 0x00, 0xA7, 0x00
	.byte 0x09, 0x00, 0xA7, 0x00, 0x83, 0x00, 0xA7, 0x00, 0x64, 0x77, 0x63, 0x00, 0x00, 0xF0, 0x00, 0x10
	.byte 0x11, 0x10, 0x01, 0x00, 0xF0, 0x00, 0x10, 0x00, 0x00, 0x00, 0x80, 0x01, 0x20, 0x00, 0x18, 0x00
	.byte 0x20, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xC0, 0x00, 0x80, 0x20, 0x00, 0x00
	
	.section .sinit,4
	
	.data

_217B040:
	.byte 0x09, 0x08, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.byte 0x00, 0x00, 0x00, 0x01, 0x31, 0x2C, 0x15, 0x02, 0x19, 0x2C, 0x15, 0x02, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
aMelco: // 0x0217B0A8
	.asciz "MELCO"
_0217B0AE:
	.byte 0x00, 0x00
aEssidAoss: // 0x0217B0B0
	.asciz "ESSID-AOSS"
_0217B0BB:
	.byte 0x00, 0x01, 0x00, 0x02, 0x00
	.byte 0x02, 0x00, 0x04, 0x00, 0x04, 0x00, 0x0B, 0x00, 0x08, 0x00, 0x0C, 0x00, 0x10, 0x00, 0x12, 0x00
	.byte 0x20, 0x00, 0x16, 0x00, 0x40, 0x00, 0x18, 0x00, 0x80, 0x00, 0x24, 0x00, 0x00, 0x01, 0x30, 0x00
	.byte 0x00, 0x02, 0x48, 0x00, 0x00, 0x04, 0x60, 0x00, 0x00, 0x08, 0x6C, 0x00, 0xAC, 0xD7, 0x17, 0x02
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x40, 0x00, 0x00, 0x00
asc_217B100: // 0x0217B100
	.asciz "******"
_0217B107:
	.byte 0x00, 0x06, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x00
	.byte 0x4E, 0x49, 0x4E, 0x54, 0x45, 0x4E, 0x44, 0x4F, 0x2D, 0x44, 0x53, 0x00, 0x80, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01
	.byte 0x8D, 0x93, 0x15, 0x02, 0x5D, 0x93, 0x15, 0x02, 0x00, 0x00, 0x00, 0x00, 0xC0, 0xA8, 0x00, 0xB0
	.byte 0xFF, 0xFF, 0xFF, 0x00, 0xC0, 0xA8, 0x00, 0xC8, 0xC0, 0xA8, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x10, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x10, 0xB1, 0x17, 0x02, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x57, 0x41, 0x52, 0x50, 0x00, 0x00, 0x00, 0x00
aCharJtnullNscL: // 0x0217B1BC
	.asciz "char/jtNull.nsc.l"
_0217B1CE:
	.byte 0x00, 0x00
aCharJb2hlapNsc: // 0x0217B1D0
	.asciz "char/jb2HlAp.nsc.l"
_0217B1E3:
	.byte 0x00
aCharJb4hlipNsc: // 0x0217B1E4
	.asciz "char/jb4HlIp.nsc.l"
_0217B1F7:
	.byte 0x00
aCharJb4hlwepNs: // 0x0217B1F8
	.asciz "char/jb4HlWep.nsc.l"
aCharJb4hlusbNs: // 0x0217B20C
	.asciz "char/jb4HlUsb.nsc.l"
aCharJb4hldns1N: // 0x0217B220
	.asciz "char/jb4HlDns1.nsc.l"
_0217B235:
	.byte 0x00, 0x00, 0x00
aCharJb4hlssidN: // 0x0217B238
	.asciz "char/jb4HlSsid.nsc.l"
_0217B24D:
	.byte 0x00, 0x00, 0x00
aCharJb5hlmoveN: // 0x0217B250
	.asciz "char/jb5HlMove.nsc.l"
_0217B265:
	.byte 0x00, 0x00, 0x00
aCharJb2hlwifiN: // 0x0217B268
	.asciz "char/jb2HlWiFi.nsc.l"
_0217B27D:
	.byte 0x00, 0x00, 0x00
aCharJb5hlinfoN: // 0x0217B280
	.asciz "char/jb5HlInfo.nsc.l"
_0217B295:
	.byte 0x00, 0x00, 0x00
aCharJb4hlmaskN: // 0x0217B298
	.asciz "char/jb4HlMask.nsc.l"
_0217B2AD:
	.byte 0x00, 0x00, 0x00
aCharJb4hlset2N: // 0x0217B2B0
	.asciz "char/jb4HlSet2.nsc.l"
_0217B2C5:
	.byte 0x00, 0x00, 0x00
aCharJb4hldns0N: // 0x0217B2C8
	.asciz "char/jb4HlDns0.nsc.l"
_0217B2DD:
	.byte 0x00, 0x00, 0x00
aCharJb4hlset3N: // 0x0217B2E0
	.asciz "char/jb4HlSet3.nsc.l"
_0217B2F5:
	.byte 0x00, 0x00, 0x00
aCharJb4hlset1N: // 0x0217B2F8
	.asciz "char/jb4HlSet1.nsc.l"
_0217B30D:
	.byte 0x00, 0x00, 0x00
aCharJb3hllist1: // 0x0217B310
	.asciz "char/jb3HlList1.nsc.l"
_0217B326:
	.byte 0x00, 0x00
aCharJb3hllist2: // 0x0217B328
	.asciz "char/jb3HlList2.nsc.l"
_0217B33E:
	.byte 0x00, 0x00
aCharJb3hllist3: // 0x0217B340
	.asciz "char/jb3HlList3.nsc.l"
_0217B356:
	.byte 0x00, 0x00
aCharJb5hlerase: // 0x0217B358
	.asciz "char/jb5HlErase.nsc.l"
_0217B36E:
	.byte 0x00, 0x00
aCharJb5hloptio: // 0x0217B370
	.asciz "char/jb5HlOption.nsc.l"
_0217B387:
	.byte 0x00
aCharJb4hlgatew: // 0x0217B388
	.asciz "char/jb4HlGateway.nsc.l"
_0217B3A0:
	.byte 0x68, 0xB2, 0x17, 0x02, 0xD0, 0xB1, 0x17, 0x02, 0x10, 0xB3, 0x17, 0x02, 0x28, 0xB3, 0x17, 0x02
	.byte 0x40, 0xB3, 0x17, 0x02, 0xF8, 0xB2, 0x17, 0x02, 0xB0, 0xB2, 0x17, 0x02, 0xE0, 0xB2, 0x17, 0x02
	.byte 0x0C, 0xB2, 0x17, 0x02, 0x38, 0xB2, 0x17, 0x02, 0xF8, 0xB1, 0x17, 0x02, 0xE4, 0xB1, 0x17, 0x02
	.byte 0x98, 0xB2, 0x17, 0x02, 0x88, 0xB3, 0x17, 0x02, 0xC8, 0xB2, 0x17, 0x02, 0x20, 0xB2, 0x17, 0x02
	.byte 0x70, 0xB3, 0x17, 0x02, 0x80, 0xB2, 0x17, 0x02, 0x58, 0xB3, 0x17, 0x02, 0x50, 0xB2, 0x17, 0x02
aCharJbbghlNcgL: // 0x0217B3F0
	.asciz "char/jbBgHl.ncg.l"
_0217B402:
	.byte 0x00, 0x00, 0x8C, 0xB4, 0x17, 0x02, 0x2C, 0xB4, 0x17, 0x02, 0x5C, 0xB4, 0x17, 0x02
	.byte 0xBC, 0xB4, 0x17, 0x02, 0x20, 0xB5, 0x17, 0x02, 0x84, 0xB5, 0x17, 0x02, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x21, 0x40, 0x23, 0x24
	.byte 0x25, 0x5E, 0x26, 0x2A, 0x28, 0x29, 0x5F, 0x2B, 0x51, 0x57, 0x45, 0x52, 0x54, 0x59, 0x55, 0x49
	.byte 0x4F, 0x50, 0x7B, 0x7D, 0x41, 0x53, 0x44, 0x46, 0x47, 0x48, 0x4A, 0x4B, 0x4C, 0x3A, 0x22, 0x7E
	.byte 0x5A, 0x58, 0x43, 0x56, 0x42, 0x4E, 0x4D, 0x3C, 0x3E, 0x3F, 0x7C, 0x00, 0x31, 0x32, 0x33, 0x34
	.byte 0x35, 0x36, 0x37, 0x38, 0x39, 0x30, 0x2D, 0x3D, 0x51, 0x57, 0x45, 0x52, 0x54, 0x59, 0x55, 0x49
	.byte 0x4F, 0x50, 0x5B, 0x5D, 0x41, 0x53, 0x44, 0x46, 0x47, 0x48, 0x4A, 0x4B, 0x4C, 0x3B, 0x27, 0x60
	.byte 0x5A, 0x58, 0x43, 0x56, 0x42, 0x4E, 0x4D, 0x2C, 0x2E, 0x2F, 0x5C, 0x00, 0x31, 0x32, 0x33, 0x34
	.byte 0x35, 0x36, 0x37, 0x38, 0x39, 0x30, 0x2D, 0x3D, 0x71, 0x77, 0x65, 0x72, 0x74, 0x79, 0x75, 0x69
	.byte 0x6F, 0x70, 0x5B, 0x5D, 0x61, 0x73, 0x64, 0x66, 0x67, 0x68, 0x6A, 0x6B, 0x6C, 0x3B, 0x27, 0x60
	.byte 0x7A, 0x78, 0x63, 0x76, 0x62, 0x6E, 0x6D, 0x2C, 0x2E, 0x2F, 0x5C, 0x00, 0x31, 0x00, 0x32, 0x00
	.byte 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37, 0x00, 0x38, 0x00, 0x39, 0x00, 0x30, 0x00
	.byte 0x2D, 0x00, 0x3D, 0x00, 0x71, 0x00, 0x77, 0x00, 0x65, 0x00, 0x72, 0x00, 0x74, 0x00, 0x79, 0x00
	.byte 0x75, 0x00, 0x69, 0x00, 0x6F, 0x00, 0x70, 0x00, 0x5B, 0x00, 0x5D, 0x00, 0x61, 0x00, 0x73, 0x00
	.byte 0x64, 0x00, 0x66, 0x00, 0x67, 0x00, 0x68, 0x00, 0x6A, 0x00, 0x6B, 0x00, 0x6C, 0x00, 0x3B, 0x00
	.byte 0x27, 0x00, 0x60, 0x00, 0x7A, 0x00, 0x78, 0x00, 0x63, 0x00, 0x76, 0x00, 0x62, 0x00, 0x6E, 0x00
	.byte 0x6D, 0x00, 0x2C, 0x00, 0x2E, 0x00, 0x2F, 0x00, 0x5C, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x21, 0x00, 0x40, 0x00, 0x23, 0x00, 0x24, 0x00, 0x25, 0x00, 0x5E, 0x00, 0x26, 0x00, 0x2A, 0x00
	.byte 0x28, 0x00, 0x29, 0x00, 0x5F, 0x00, 0x2B, 0x00, 0x51, 0x00, 0x57, 0x00, 0x45, 0x00, 0x52, 0x00
	.byte 0x54, 0x00, 0x59, 0x00, 0x55, 0x00, 0x49, 0x00, 0x4F, 0x00, 0x50, 0x00, 0x7B, 0x00, 0x7D, 0x00
	.byte 0x41, 0x00, 0x53, 0x00, 0x44, 0x00, 0x46, 0x00, 0x47, 0x00, 0x48, 0x00, 0x4A, 0x00, 0x4B, 0x00
	.byte 0x4C, 0x00, 0x3A, 0x00, 0x22, 0x00, 0x7E, 0x00, 0x5A, 0x00, 0x58, 0x00, 0x43, 0x00, 0x56, 0x00
	.byte 0x42, 0x00, 0x4E, 0x00, 0x4D, 0x00, 0x3C, 0x00, 0x3E, 0x00, 0x3F, 0x00, 0x7C, 0x00, 0x20, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00
	.byte 0x37, 0x00, 0x38, 0x00, 0x39, 0x00, 0x30, 0x00, 0x2D, 0x00, 0x3D, 0x00, 0x51, 0x00, 0x57, 0x00
	.byte 0x45, 0x00, 0x52, 0x00, 0x54, 0x00, 0x59, 0x00, 0x55, 0x00, 0x49, 0x00, 0x4F, 0x00, 0x50, 0x00
	.byte 0x5B, 0x00, 0x5D, 0x00, 0x41, 0x00, 0x53, 0x00, 0x44, 0x00, 0x46, 0x00, 0x47, 0x00, 0x48, 0x00
	.byte 0x4A, 0x00, 0x4B, 0x00, 0x4C, 0x00, 0x3B, 0x00, 0x27, 0x00, 0x60, 0x00, 0x5A, 0x00, 0x58, 0x00
	.byte 0x43, 0x00, 0x56, 0x00, 0x42, 0x00, 0x4E, 0x00, 0x4D, 0x00, 0x2C, 0x00, 0x2E, 0x00, 0x2F, 0x00
	.byte 0x5C, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00
aDwcMoveChildSr: // 0x0217B5E8
	.asciz "dwc:/move/child.srl"
aDwcMoveBannerP: // 0x0217B5FC
	.asciz "dwc:/move/banner.plt"
_0217B611:
	.byte 0x00, 0x00, 0x00
aDwcMoveBannerC: // 0x0217B614
	.asciz "dwc:/move/banner.char"
_0217B62A:
	.byte 0x00, 0x00, 0xE8, 0xB5, 0x17, 0x02
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0xB6, 0x17, 0x02, 0xFC, 0xB5, 0x17, 0x02
	.byte 0x59, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x6D, 0x73, 0x67, 0x2F, 0x6B, 0x6F, 0x72, 0x2E
	.byte 0x62, 0x6D, 0x67, 0x2E, 0x6C, 0x00, 0x00, 0x00, 0x6D, 0x73, 0x67, 0x2F, 0x65, 0x6E, 0x67, 0x2E
	.byte 0x62, 0x6D, 0x67, 0x2E, 0x6C, 0x00, 0x00, 0x00, 0x6D, 0x73, 0x67, 0x2F, 0x69, 0x74, 0x61, 0x2E
	.byte 0x62, 0x6D, 0x67, 0x2E, 0x6C, 0x00, 0x00, 0x00, 0x6D, 0x73, 0x67, 0x2F, 0x67, 0x65, 0x72, 0x2E
	.byte 0x62, 0x6D, 0x67, 0x2E, 0x6C, 0x00, 0x00, 0x00, 0x6D, 0x73, 0x67, 0x2F, 0x66, 0x72, 0x65, 0x2E
	.byte 0x62, 0x6D, 0x67, 0x2E, 0x6C, 0x00, 0x00, 0x00, 0x6D, 0x73, 0x67, 0x2F, 0x73, 0x70, 0x61, 0x2E
	.byte 0x62, 0x6D, 0x67, 0x2E, 0x6C, 0x00, 0x00, 0x00, 0x6D, 0x73, 0x67, 0x2F, 0x6A, 0x61, 0x70, 0x2E
	.byte 0x62, 0x6D, 0x67, 0x2E, 0x6C, 0x00, 0x00, 0x00, 0xA8, 0xB6, 0x17, 0x02, 0x58, 0xB6, 0x17, 0x02
	.byte 0x88, 0xB6, 0x17, 0x02, 0x78, 0xB6, 0x17, 0x02, 0x68, 0xB6, 0x17, 0x02, 0x98, 0xB6, 0x17, 0x02
	.byte 0x48, 0xB6, 0x17, 0x02
aMsgUsaBmgL: // 0x0217B6D4
	.asciz "msg/usa.bmg.l"
_0217B6E2:
	.byte 0x00, 0x00
aCharJtmainNceL: // 0x0217B6E4
	.asciz "char/jtMain.nce.l"
_0217B6F6:
	.byte 0x00, 0x00
aCharJbmainNceL: // 0x0217B6F8
	.asciz "char/jbMain.nce.l"
_0217B70A:
	.byte 0x00, 0x00
aCharJtbgmainNc: // 0x0217B70C
	.asciz "char/jtBgMain.ncg.l"
aCharJtbgmainNc_0: // 0x0217B720
	.asciz "char/jtBgMain.ncl.l"
aCharJtobjmainN: // 0x0217B734
	.asciz "char/jtObjMain.ncg.l"
_0217B749:
	.byte 0x00, 0x00, 0x00
aCharXtobjmainN: // 0x0217B74C
	.asciz "char/xtObjMain.ncl.l"
_0217B761:
	.byte 0x00, 0x00, 0x00
aCharJbbgstep1N: // 0x0217B764
	.asciz "char/jbBgStep1.ncg.l"
_0217B779:
	.byte 0x00, 0x00, 0x00
aCharJbbgstep1N_0: // 0x0217B77C
	.asciz "char/jbBgStep1.ncl.l"
_0217B791:
	.byte 0x00, 0x00, 0x00
aCharJbobjmainN: // 0x0217B794
	.asciz "char/jbObjMain.ncg.l"
_0217B7A9:
	.byte 0x00, 0x00, 0x00
aCharYbobjmainN: // 0x0217B7AC
	.asciz "char/ybObjMain.ncl.l"
_0217B7C1:
	.byte 0x00, 0x00, 0x00
aCharJttopNscL: // 0x0217B7C4
	.asciz "char/jtTop.nsc.l"
_0217B7D5:
	.byte 0x00, 0x00, 0x00
aCharJtstep1Nsc: // 0x0217B7D8
	.asciz "char/jtStep1.nsc.l"
_0217B7EB:
	.byte 0x00
aCharJbbgstep1N_1: // 0x0217B7EC
	.asciz "char/jbBgStep1.ncg.l"
_0217B801:
	.byte 0x00, 0x00, 0x00
aCharJbbgstep1N_2: // 0x0217B804
	.asciz "char/jbBgStep1.ncl.l"
_0217B819:
	.byte 0x00, 0x00, 0x00
aCharJb2menuNsc: // 0x0217B81C
	.asciz "char/jb2Menu.nsc.l"
_0217B82F:
	.byte 0x00
aCharYb5multiNs: // 0x0217B830
	.asciz "char/yb5Multi.nsc.l"
aCharYb5multiNs_0: // 0x0217B844
	.asciz "char/yb5Multi.nsc.l"
_0217B858:
	.byte 0x25, 0x00, 0x30, 0x00, 0x32, 0x00, 0x58, 0x00
	.byte 0x2D, 0x00, 0x25, 0x00, 0x30, 0x00, 0x32, 0x00, 0x58, 0x00, 0x2D, 0x00, 0x25, 0x00, 0x30, 0x00
	.byte 0x32, 0x00, 0x58, 0x00, 0x2D, 0x00, 0x25, 0x00, 0x30, 0x00, 0x32, 0x00, 0x58, 0x00, 0x2D, 0x00
	.byte 0x25, 0x00, 0x30, 0x00, 0x32, 0x00, 0x58, 0x00, 0x2D, 0x00, 0x25, 0x00, 0x30, 0x00, 0x32, 0x00
	.byte 0x58, 0x00, 0x00, 0x00, 0x25, 0x00, 0x30, 0x00, 0x34, 0x00, 0x64, 0x00, 0x2D, 0x00, 0x25, 0x00
	.byte 0x30, 0x00, 0x34, 0x00, 0x64, 0x00, 0x2D, 0x00, 0x25, 0x00, 0x30, 0x00, 0x34, 0x00, 0x64, 0x00
	.byte 0x2D, 0x00, 0x25, 0x00, 0x30, 0x00, 0x34, 0x00, 0x64, 0x00, 0x00, 0x00, 0x2D, 0x00, 0x2D, 0x00
	.byte 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00
	.byte 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00
	.byte 0x2D, 0x00, 0x00, 0x00
aCharJb5infoNsc: // 0x0217B8E4
	.asciz "char/jb5Info.nsc.l"
_0217B8F7:
	.byte 0x00
aCharJbbgoption: // 0x0217B8F8
	.asciz "char/jbBgOption.ncg.l"
_0217B90E:
	.byte 0x00, 0x00
aCharJb5optmenu: // 0x0217B910
	.asciz "char/jb5OptMenu.nsc.l"
_0217B926:
	.byte 0x00, 0x00
aCharYb5multiNs_4: // 0x0217B928
	.asciz "char/yb5Multi.nsc.l"
aCharYb5multiNs_1: // 0x0217B93C
	.asciz "char/yb5Multi.nsc.l"
aCharYb5multiNs_5: // 0x0217B950
	.asciz "char/yb5Multi.nsc.l"
aCharYb5multiNs_3: // 0x0217B964
	.asciz "char/yb5Multi.nsc.l"
aCharJb5moveNsc: // 0x0217B978
	.asciz "char/jb5Move.nsc.l"
_0217B98B:
	.byte 0x00
aCharYb5multiNs_2: // 0x0217B98C
	.asciz "char/yb5Multi.nsc.l"
aCharJbbgstep3N_3: // 0x0217B9A0
	.asciz "char/jbBgStep3.ncg.l"
_0217B9B5:
	.byte 0x00, 0x00, 0x00
aCharYbbgstep3N_3: // 0x0217B9B8
	.asciz "char/ybBgStep3.ncl.l"
_0217B9CD:
	.byte 0x00, 0x00, 0x00
aCharXb4multiNs_0: // 0x0217B9D0
	.asciz "char/xb4Multi.nsc.l"
aCharXb4multiNs_8: // 0x0217B9E4
	.asciz "char/xb4Multi.nsc.l"
aCharJb4aplistN: // 0x0217B9F8
	.asciz "char/jb4ApList.nsc.l"
_0217BA0D:
	.byte 0x00, 0x00, 0x00
aCharYbobjmainN_2: // 0x0217BA10
	.asciz "char/ybObjMain.ncl.l"
_0217BA25:
	.byte 0x00, 0x00, 0x00
aCharYbobjkbNcl_0: // 0x0217BA28
	.asciz "char/ybObjKb.ncl.l"
_0217BA3B:
	.byte 0x00
aCharJbbgstep3N: // 0x0217BA3C
	.asciz "char/jbBgStep3.ncg.l"
_0217BA51:
	.byte 0x00, 0x00, 0x00
aCharYbbgstep3N: // 0x0217BA54
	.asciz "char/ybBgStep3.ncl.l"
_0217BA69:
	.byte 0x00, 0x00, 0x00
aCharXb4editNsc: // 0x0217BA6C
	.asciz "char/xb4Edit.nsc.l"
_0217BA7F:
	.byte 0x00
aCharYbobjmainN_3: // 0x0217BA80
	.asciz "char/ybObjMain.ncl.l"
_0217BA95:
	.byte 0x00, 0x00, 0x00
aCharYbobjkbNcl_1: // 0x0217BA98
	.asciz "char/ybObjKb.ncl.l"
_0217BAAB:
	.byte 0x00
aCharJbbgstep3N_0: // 0x0217BAAC
	.asciz "char/jbBgStep3.ncg.l"
_0217BAC1:
	.byte 0x00, 0x00, 0x00
aCharYbbgstep3N_0: // 0x0217BAC4
	.asciz "char/ybBgStep3.ncl.l"
_0217BAD9:
	.byte 0x00, 0x00, 0x00
aCharXb4editadd: // 0x0217BADC
	.asciz "char/xb4EditAddr.nsc.l"
_0217BAF3:
	.byte 0x00, 0x20, 0x20, 0x30, 0x00, 0x25, 0x00, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00
aCharJb4errorNs: // 0x0217BB00
	.asciz "char/jb4Error.nsc.l"
_0217BB14:
	.byte 0x25, 0x00, 0x33, 0x00, 0x64, 0x00, 0x2E, 0x00, 0x25, 0x00, 0x33, 0x00
	.byte 0x64, 0x00, 0x2E, 0x00, 0x25, 0x00, 0x33, 0x00, 0x64, 0x00, 0x2E, 0x00, 0x25, 0x00, 0x33, 0x00
	.byte 0x64, 0x00, 0x00, 0x00
aCharYbobjmainN_1: // 0x0217BB34
	.asciz "char/ybObjMain.ncl.l"
_0217BB49:
	.byte 0x00, 0x00, 0x00
aCharYbobjkbNcl: // 0x0217BB4C
	.asciz "char/ybObjKb.ncl.l"
_0217BB5F:
	.byte 0x00
aCharJbbgstep2N: // 0x0217BB60
	.asciz "char/jbBgStep2.ncg.l"
_0217BB75:
	.byte 0x00, 0x00, 0x00
aCharJbbgstep21: // 0x0217BB78
	.asciz "char/jbBgStep21.ncg.l"
_0217BB8E:
	.byte 0x00, 0x00
aCharJb3listNsc: // 0x0217BB90
	.asciz "char/jb3List.nsc.l"
_0217BBA3:
	.byte 0x00
aCharJbbgstep3N_1: // 0x0217BBA4
	.asciz "char/jbBgStep3.ncg.l"
_0217BBB9:
	.byte 0x00, 0x00, 0x00
aCharYbbgstep3N_1: // 0x0217BBBC
	.asciz "char/ybBgStep3.ncl.l"
_0217BBD1:
	.byte 0x00, 0x00, 0x00
aCharXb4noneNsc: // 0x0217BBD4
	.asciz "char/xb4None.nsc.l"
_0217BBE7:
	.byte 0x00
aCharXb4multiNs_2: // 0x0217BBE8
	.asciz "char/xb4Multi.nsc.l"
aCharXb4multiNs_3: // 0x0217BBFC
	.asciz "char/xb4Multi.nsc.l"
aCharXb4multiNs_4: // 0x0217BC10
	.asciz "char/xb4Multi.nsc.l"
aCharJbbgstep3N_4: // 0x0217BC24
	.asciz "char/jbBgStep3.ncg.l"
_0217BC39:
	.byte 0x00, 0x00, 0x00
aCharYbbgstep3N_4: // 0x0217BC3C
	.asciz "char/ybBgStep3.ncl.l"
_0217BC51:
	.byte 0x00, 0x00, 0x00
aCharXb4multiNs_1: // 0x0217BC54
	.asciz "char/xb4Multi.nsc.l"
aCharJbbgstep3N_2: // 0x0217BC68
	.asciz "char/jbBgStep3.ncg.l"
_0217BC7D:
	.byte 0x00, 0x00, 0x00
aCharYbbgstep3N_2: // 0x0217BC80
	.asciz "char/ybBgStep3.ncl.l"
_0217BC95:
	.byte 0x00, 0x00, 0x00
aCharXb4multiNs: // 0x0217BC98
	.asciz "char/xb4Multi.nsc.l"
aCharYbobjmainN_0: // 0x0217BCAC
	.asciz "char/ybObjMain.ncl.l"
_0217BCC1:
	.byte 0x00, 0x00, 0x00
aCharYbobjwayNc: // 0x0217BCC4
	.asciz "char/ybObjWay.ncl.l"
aCharJbbgstep1N_3: // 0x0217BCD8
	.asciz "char/jbBgStep1.ncg.l"
_0217BCED:
	.byte 0x00, 0x00, 0x00
aCharJbbgstep1N_4: // 0x0217BCF0
	.asciz "char/jbBgStep1.ncl.l"
_0217BD05:
	.byte 0x00, 0x00, 0x00
aCharJb2apNscL: // 0x0217BD08
	.asciz "char/jb2Ap.nsc.l"
_0217BD19:
	.byte 0x00, 0x00, 0x00
aCharJbbgstep2N_0: // 0x0217BD1C
	.asciz "char/jbBgStep2.ncg.l"
_0217BD31:
	.byte 0x00, 0x00, 0x00
aCharYbbgstep2N_0: // 0x0217BD34
	.asciz "char/ybBgStep2.ncl.l"
_0217BD49:
	.byte 0x00, 0x00, 0x00
aCharJb3wayNscL: // 0x0217BD4C
	.asciz "char/jb3Way.nsc.l"
_0217BD5E:
	.byte 0x00, 0x00
aCharJbbgstep3N_5: // 0x0217BD60
	.asciz "char/jbBgStep3.ncg.l"
_0217BD75:
	.byte 0x00, 0x00, 0x00
aCharYbbgstep3N_5: // 0x0217BD78
	.asciz "char/ybBgStep3.ncl.l"
_0217BD8D:
	.byte 0x00, 0x00, 0x00
aCharXb4multiNs_5: // 0x0217BD90
	.asciz "char/xb4Multi.nsc.l"
aCharXb4multiNs_6: // 0x0217BDA4
	.asciz "char/xb4Multi.nsc.l"
aCharXb4noneNsc_0: // 0x0217BDB8
	.asciz "char/xb4None.nsc.l"
_0217BDCB:
	.byte 0x00
aCharXb4multiNs_7: // 0x0217BDCC
	.asciz "char/xb4Multi.nsc.l"
aCharJbbgstep2N_1: // 0x0217BDE0
	.asciz "char/jbBgStep2.ncg.l"
_0217BDF5:
	.byte 0x00, 0x00, 0x00
aCharYbbgstep2N_1: // 0x0217BDF8
	.asciz "char/ybBgStep2.ncl.l"
_0217BE0D:
	.byte 0x00, 0x00, 0x00
aCharXb3multiNs: // 0x0217BE10
	.asciz "char/xb3Multi.nsc.l"
aCharJbbgstep3N_6: // 0x0217BE24
	.asciz "char/jbBgStep3.ncg.l"
_0217BE39:
	.byte 0x00, 0x00, 0x00
aCharYbbgstep3N_6: // 0x0217BE3C
	.asciz "char/ybBgStep3.ncl.l"
_0217BE51:
	.byte 0x00, 0x00, 0x00
aCharJb4usbNscL: // 0x0217BE54
	.asciz "char/jb4Usb.nsc.l"
_0217BE66:
	.byte 0x00, 0x00
a3d3d3d3d_0: // 0x0217BE68
	.asciz "%3d%3d%3d%3d"
_0217BE75:
	.byte 0x00, 0x00, 0x00
aSoundSoundData: // 0x0217BE78
	.asciz "sound/sound_data.sdat.l"
aCharJttopNscL_0: // 0x0217BE90
	.asciz "char/jtTop.nsc.l"
_0217BEA1:
	.byte 0x00, 0x00, 0x00
aCharJtstep1Nsc_0: // 0x0217BEA4
	.asciz "char/jtStep1.nsc.l"
_0217BEB7:
	.byte 0x00
aCharJtstep2Nsc: // 0x0217BEB8
	.asciz "char/jtStep2.nsc.l"
_0217BECB:
	.byte 0x00
aCharJtstep3Nsc: // 0x0217BECC
	.asciz "char/jtStep3.nsc.l"
_0217BEDF:
	.byte 0x00
aCharJtoptionNs: // 0x0217BEE0
	.asciz "char/jtOption.nsc.l"
_0217BEF4:
	.byte 0xA4, 0xBE, 0x17, 0x02, 0xB8, 0xBE, 0x17, 0x02, 0xCC, 0xBE, 0x17, 0x02
	.byte 0xE0, 0xBE, 0x17, 0x02, 0x90, 0xBE, 0x17, 0x02
aDwciMovWhSysst: // 0x0217BF08
	.asciz "DWCi_MOV_WH_SYSSTATE_STOP"
_0217BF22:
	.byte 0x00, 0x00
aDwciMovWhSysst_0: // 0x0217BF24
	.asciz "DWCi_MOV_WH_SYSSTATE_IDLE"
_0217BF3E:
	.byte 0x00, 0x00
aDwciMovWhSysst_1: // 0x0217BF40
	.asciz "DWCi_MOV_WH_SYSSTATE_BUSY"
_0217BF5A:
	.byte 0x00, 0x00
aDwciMovWhSysst_2: // 0x0217BF5C
	.asciz "DWCi_MOV_WH_SYSSTATE_ERROR"
_0217BF77:
	.byte 0x00
aDwciMovWhSysst_3: // 0x0217BF78
	.asciz "DWCi_MOV_WH_SYSSTATE_SCANNING"
_0217BF96:
	.byte 0x00, 0x00
aDwciMovWhSysst_4: // 0x0217BF98
	.asciz "DWCi_MOV_WH_SYSSTATE_CONNECTED"
_0217BFB7:
	.byte 0x00, 0x44, 0x57, 0x43, 0x69, 0x5F, 0x4D, 0x4F, 0x56
	.byte 0x5F, 0x57, 0x48, 0x5F, 0x53, 0x59, 0x53, 0x53, 0x54, 0x41, 0x54, 0x45, 0x5F, 0x4B, 0x45, 0x59
	.byte 0x53, 0x48, 0x41, 0x52, 0x49, 0x4E, 0x47, 0x00, 0x44, 0x57, 0x43, 0x69, 0x5F, 0x4D, 0x4F, 0x56
	.byte 0x5F, 0x57, 0x48, 0x5F, 0x53, 0x59, 0x53, 0x53, 0x54, 0x41, 0x54, 0x45, 0x5F, 0x44, 0x41, 0x54
	.byte 0x41, 0x53, 0x48, 0x41, 0x52, 0x49, 0x4E, 0x47, 0x00, 0x00, 0x00, 0x00
aDwciMovWhSysst_5: // 0x0217BFFC
	.asciz "DWCi_MOV_WH_SYSSTATE_CONNECT_FAIL"
_0217C01E:
	.byte 0x00, 0x00
aDwciMovWhSysst_6: // 0x0217C020
	.asciz "DWCi_MOV_WH_SYSSTATE_MEASURECHANNEL"
_0217C044:
	.byte 0x08, 0xBF, 0x17, 0x02, 0x24, 0xBF, 0x17, 0x02, 0x78, 0xBF, 0x17, 0x02
	.byte 0x40, 0xBF, 0x17, 0x02, 0x98, 0xBF, 0x17, 0x02, 0xD8, 0xBF, 0x17, 0x02, 0xB8, 0xBF, 0x17, 0x02
	.byte 0x20, 0xC0, 0x17, 0x02, 0xFC, 0xBF, 0x17, 0x02, 0x5C, 0xBF, 0x17, 0x02
aAlreadyDwciMov: // 0x0217C06C
	.asciz "already DWCi_MOV_WH_SYSSTATE_IDLE\n"
_0217C08F:
	.byte 0x00
aDwciMovWhFinal: // 0x0217C090
	.asciz "DWCi_MOV_WH_Finalize, state = %d\n"
_0217C0B2:
	.byte 0x00, 0x00
aDwciMovWhStepd: // 0x0217C0B4
	.asciz "DWCi_MOV_WH_StepDataSharing - Warning No Child\n"
aDwciMovWhStepd_0: // 0x0217C0E4
	.asciz "DWCi_MOV_WH_StepDataSharing - Warning No DataSet\n"
_0217C116:
	.byte 0x00, 0x00
aRecvBufferSize_0: // 0x0217C118
	.asciz "recv buffer size = %d\n"
_0217C12F:
	.byte 0x00
aSendBufferSize_0: // 0x0217C130
	.asciz "send buffer size = %d\n"
_0217C147:
	.byte 0x00
aUnknownConnect_1: // 0x0217C148
	.asciz "unknown connect mode %d\n"
_0217C161:
	.byte 0x00, 0x00, 0x00
aDecidedChannel_0: // 0x0217C164
	.asciz "decided channel = %d\n"
_0217C17A:
	.byte 0x00, 0x00
aChannelDBratio_0: // 0x0217C17C
	.asciz "channel %d bratio = %x\n"
aUnknownIndicat_0: // 0x0217C194
	.asciz "unknown indicate, state = %d\n"
_0217C1B2:
	.byte 0x00, 0x00
aDwciMovWhState: // 0x0217C1B4
	.asciz "DWCi_MOV_WH_StateInEndParent failed\n"
_0217C1D9:
	.byte 0x00, 0x00, 0x00
aDwciMovWhState_0: // 0x0217C1DC
	.asciz "DWCi_MOV_WH_StateInStartParentKeyShare failed\n"
_0217C20B:
	.byte 0x00
aStartparentNew_0: // 0x0217C20C
	.asciz "StartParent - new child (aid %x) connected\n"
aStartparentChi_1: // 0x0217C238
	.asciz "StartParent - child (aid %x) disconnected\n"
_0217C263:
	.byte 0x00
aS_10: // 0x0217C264
	.asciz "%s -> "
_0217C26B:
	.byte 0x00, 0x25, 0x73, 0x0A, 0x00
	.byte 0x2E, 0x6C, 0x00, 0x00
aRom_0: // 0x0217C274
	.asciz "rom:/"
_0217C27A:
	.byte 0x00, 0x00
aRomDwcUtilityB: // 0x0217C27C
	.asciz "rom:/dwc/utility.bin"
_0217C291:
	.byte 0x00, 0x00, 0x00, 0x25, 0x73, 0x3A, 0x2F, 0x00, 0x00, 0x00, 0x00, 0xBC, 0xC2, 0x17, 0x02
	.byte 0xAC, 0xC2, 0x17, 0x02, 0xCC, 0xC2, 0x17, 0x02, 0xAC, 0xC2, 0x17, 0x02
aMsgLcSNftrL: // 0x0217C2AC
	.asciz "msg/lc_s.NFTR.l"
aMsgKcMNftrL: // 0x0217C2BC
	.asciz "msg/kc_m.NFTR.l"
aMsgLcMNftrL: // 0x0217C2CC
	.asciz "msg/lc_m.NFTR.l"