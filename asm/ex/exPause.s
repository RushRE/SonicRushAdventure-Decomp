	.include "asm/macros.inc"
	.include "global.inc"

	.bss

exPauseTask__word_2177B98: // 0x02177B98
    .space 0x02

	.align 4
	
exPauseTask__TaskSingleton: // 0x02177B9C
    .space 0x04
	
	.text

	arm_func_start exPauseTask__Main
exPauseTask__Main: // 0x0216D8D8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	bl GetExTaskWorkCurrent_
	mov r7, r0
	bl GetCurrentTask
	ldr r2, _0216DB80 // =exPauseTask__word_2177B98
	mov r4, #0x2c
	str r0, [r2, #4]
	sub r1, r4, #0x2d
	mov r0, #0
	stmia sp, {r0, r4}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0216D984
_0216D924: // jump table
	b _0216D93C // case 0
	b _0216D948 // case 1
	b _0216D954 // case 2
	b _0216D960 // case 3
	b _0216D96C // case 4
	b _0216D978 // case 5
_0216D93C:
	mov r0, #0
	strh r0, [r7]
	b _0216D98C
_0216D948:
	mov r0, #1
	strh r0, [r7]
	b _0216D98C
_0216D954:
	mov r0, #2
	strh r0, [r7]
	b _0216D98C
_0216D960:
	mov r0, #3
	strh r0, [r7]
	b _0216D98C
_0216D96C:
	mov r0, #4
	strh r0, [r7]
	b _0216D98C
_0216D978:
	mov r0, #5
	strh r0, [r7]
	b _0216D98C
_0216D984:
	mov r0, #1
	strh r0, [r7]
_0216D98C:
	ldrh r2, [r7, #0]
	ldr r1, _0216DB84 // =_02175DEC
	add r0, r7, #0x18
	mov r2, r2, lsl #1
	ldrh r2, [r1, r2]
	mov r1, #8
	strh r2, [r7, #0x18]
	strh r1, [r7, #0x1a]
	bl ovl09_2168EA4
	add r0, r7, #0x98
	mov r1, #0xe000
	bl ovl09_21641E8
	mvn r0, #0x23
	strh r0, [r7, #0x80]
	mov r1, #0x3c
	add r0, r7, #0x18
	strh r1, [r7, #0x82]
	bl ovl09_2161B80
	add r0, r7, #0x98
	bl ovl09_2164218
	ldrb r0, [r7, #0x9a]
	add r1, r7, #0x32
	mov r8, #0
	orr r0, r0, #0x20
	strb r0, [r7, #0x9a]
	add r0, r7, #0x22
	add r11, r0, #0x100
	add r0, r7, #0x1b0
	str r0, [sp, #0xc]
	add r0, r7, #0x230
	str r0, [sp, #0x10]
	add r0, r1, #0x200
	strb r8, [r7, #0x72]
	add r6, r7, #0xa0
	add r5, r7, #0x120
	str r0, [sp, #0x14]
	mvn r4, #0x23
_0216DA20:
	mov r0, #0xc
	mul r0, r8, r0
	str r0, [sp, #8]
	mov r0, #0x88
	mul r9, r8, r0
	ldrh r2, [r7, #0]
	ldr r1, _0216DB88 // =0x02175DF8
	ldr r0, [sp, #8]
	mov r2, r2, lsl #1
	add r1, r1, r0
	ldrh r1, [r2, r1]
	add r10, r7, r9
	add r0, r6, r9
	strh r1, [r10, #0xa0]
	mov r1, #8
	strh r1, [r10, #0xa2]
	bl ovl09_2168EA4
	add r0, r5, r9
	mov r1, #0xe000
	bl ovl09_21641E8
	add r1, r10, #0x100
	strh r4, [r1, #8]
	mov r0, #0x48
	strh r0, [r1, #0xa]
	add r0, r6, r9
	bl ovl09_2161B80
	add r0, r5, r9
	bl ovl09_21641F0
	ldr r1, _0216DB8C // =0x02175E10
	ldr r0, [sp, #8]
	add r2, r10, #0x100
	add r3, r1, r0
	ldrb r1, [r11, r9]
	ldr r0, [sp, #0xc]
	orr r1, r1, #0x20
	strb r1, [r11, r9]
	mov r1, #0
	strb r1, [r10, #0xfa]
	ldrh r1, [r7, #0]
	add r0, r0, r9
	mov r1, r1, lsl #1
	ldrh r1, [r1, r3]
	strh r1, [r2, #0xb0]
	mov r1, #8
	strh r1, [r2, #0xb2]
	bl ovl09_2168EA4
	ldr r0, [sp, #0x10]
	mov r1, #0xe000
	add r0, r0, r9
	bl ovl09_21641E8
	add r1, r10, #0x200
	strh r4, [r1, #0x18]
	mov r0, #0x58
	strh r0, [r1, #0x1a]
	ldr r0, [sp, #0xc]
	add r0, r0, r9
	bl ovl09_2161B80
	ldr r0, [sp, #0x10]
	add r0, r0, r9
	bl ovl09_21641F0
	ldr r0, [sp, #0x14]
	ldrb r2, [r0, r9]
	add r0, r8, #1
	mov r1, r0, lsl #0x10
	mov r8, r1, lsr #0x10
	ldr r0, [sp, #0x14]
	orr r2, r2, #0x20
	strb r2, [r0, r9]
	mov r0, #0
	strb r0, [r10, #0x20a]
	cmp r8, #2
	blo _0216DA20
	mov r0, #1
	strh r0, [r7, #2]
	mov r0, #0
	strh r0, [r7, #4]
	strh r0, [r7, #8]
	strh r0, [r7, #0xa]
	strh r0, [r7, #0xc]
	strh r0, [r7, #0xe]
	strh r0, [r7, #0x10]
	strh r0, [r7, #0x12]
	strh r0, [r7, #6]
	bl GetExTaskCurrent
	ldr r1, _0216DB90 // =ovl09_216DC00
	str r1, [r0]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216DB80: .word exPauseTask__word_2177B98
_0216DB84: .word _02175DEC
_0216DB88: .word 0x02175DF8
_0216DB8C: .word 0x02175E10
_0216DB90: .word ovl09_216DC00
	arm_func_end exPauseTask__Main

	arm_func_start exPauseTask__Func8
exPauseTask__Func8: // 0x0216DB94
	ldr ip, _0216DB9C // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_0216DB9C: .word GetExTaskWorkCurrent_
	arm_func_end exPauseTask__Func8

	arm_func_start exPauseTask__Destructor
exPauseTask__Destructor: // 0x0216DBA0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x18
	bl ovl09_2168F68
	mov r7, #0
	add r6, r4, #0xa0
	add r5, r4, #0x1b0
	mov r4, #0x88
_0216DBC4:
	mul r8, r7, r4
	add r0, r6, r8
	bl ovl09_2168F68
	add r0, r5, r8
	bl ovl09_2168F68
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #2
	blo _0216DBC4
	ldr r0, _0216DBFC // =exPauseTask__word_2177B98
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216DBFC: .word exPauseTask__word_2177B98
	arm_func_end exPauseTask__Destructor

	arm_func_start ovl09_216DC00
ovl09_216DC00: // 0x0216DC00
	stmdb sp!, {r4, r5, r6, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrsh r0, [r4, #8]
	cmp r0, #0x1000
	blt _0216DC74
	ldrsh r0, [r4, #0xe]
	cmp r0, #0x1000
	bge _0216DCDC
	add r0, r0, #0x800
	strh r0, [r4, #0xe]
	ldrsh r2, [r4, #0xe]
	mvn r1, #0
	mov r0, r1, lsl #0xe
	umull r5, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	adds r2, r5, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x84000
	bl _f_itof
	ldr r1, _0216DEFC // =0x45800000
	bl _fdiv
	bl _f_ftoi
	strh r0, [r4, #0x80]
	b _0216DCDC
_0216DC74:
	add r0, r0, #0x200
	strh r0, [r4, #8]
	ldrsh r3, [r4, #8]
	mov r1, #2
	mov r0, #0x84000
	mov r2, r3, asr #0x1f
	mov lr, #0
	mov ip, #0x800
_0216DC94:
	add r0, r0, #0x24000
	umull r6, r5, r0, r3
	mla r5, r0, r2, r5
	mov r0, r0, asr #0x1f
	mla r5, r0, r3, r5
	adds r6, r6, ip
	adc r0, r5, lr
	mov r5, r6, lsr #0xc
	orr r5, r5, r0, lsl #20
	cmp r1, #0
	sub r0, r5, #0x24000
	sub r1, r1, #1
	bne _0216DC94
	bl _f_itof
	ldr r1, _0216DEFC // =0x45800000
	bl _fdiv
	bl _f_ftoi
	strh r0, [r4, #0x80]
_0216DCDC:
	ldrsh r0, [r4, #6]
	cmp r0, #2
	ble _0216DDD8
	ldrsh r0, [r4, #0xa]
	cmp r0, #0x1000
	blt _0216DD60
	ldrsh r0, [r4, #0x10]
	cmp r0, #0x1000
	bge _0216DDD8
	add r0, r0, #0x800
	strh r0, [r4, #0x10]
	ldrsh r2, [r4, #0x10]
	mvn r1, #0
	mov r0, r1, lsl #0xe
	umull r5, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	adds r2, r5, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x84000
	bl _f_itof
	ldr r1, _0216DEFC // =0x45800000
	bl _fdiv
	bl _f_ftoi
	ldrh r2, [r4, #2]
	mov r1, #0x88
	mla r1, r2, r1, r4
	add r1, r1, #0x100
	strh r0, [r1, #8]
	b _0216DDD8
_0216DD60:
	add r0, r0, #0x200
	strh r0, [r4, #0xa]
	ldrsh r3, [r4, #0xa]
	mov r1, #2
	mov r0, #0x84000
	mov r2, r3, asr #0x1f
	mov lr, #0
	mov ip, #0x800
_0216DD80:
	add r0, r0, #0x24000
	umull r6, r5, r0, r3
	mla r5, r0, r2, r5
	mov r0, r0, asr #0x1f
	mla r5, r0, r3, r5
	adds r6, r6, ip
	adc r0, r5, lr
	mov r5, r6, lsr #0xc
	orr r5, r5, r0, lsl #20
	cmp r1, #0
	sub r0, r5, #0x24000
	sub r1, r1, #1
	bne _0216DD80
	bl _f_itof
	ldr r1, _0216DEFC // =0x45800000
	bl _fdiv
	bl _f_ftoi
	ldrh r2, [r4, #2]
	mov r1, #0x88
	mla r1, r2, r1, r4
	add r1, r1, #0x100
	strh r0, [r1, #8]
_0216DDD8:
	ldrsh r0, [r4, #6]
	cmp r0, #4
	ble _0216DEE0
	ldrsh r0, [r4, #0xc]
	cmp r0, #0x1000
	blt _0216DE64
	ldrsh r0, [r4, #0x12]
	cmp r0, #0x1000
	blt _0216DE04
	bl ovl09_216DF00
	ldmia sp!, {r4, r5, r6, pc}
_0216DE04:
	add r0, r0, #0x800
	strh r0, [r4, #0x12]
	ldrsh r2, [r4, #0x12]
	mvn r1, #0
	mov r0, r1, lsl #0xe
	umull r5, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	adds r2, r5, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x84000
	bl _f_itof
	ldr r1, _0216DEFC // =0x45800000
	bl _fdiv
	bl _f_ftoi
	ldrh r2, [r4, #4]
	mov r1, #0x88
	mla r1, r2, r1, r4
	add r1, r1, #0x200
	strh r0, [r1, #0x18]
	b _0216DEE8
_0216DE64:
	add r0, r0, #0x200
	strh r0, [r4, #0xc]
	ldrsh r3, [r4, #0xc]
	mov r1, #2
	mov r0, #0x84000
	mov r2, r3, asr #0x1f
	mov lr, #0
	mov ip, #0x800
_0216DE84:
	add r0, r0, #0x24000
	umull r6, r5, r0, r3
	mla r5, r0, r2, r5
	mov r0, r0, asr #0x1f
	mla r5, r0, r3, r5
	adds r6, r6, ip
	adc r0, r5, lr
	mov r5, r6, lsr #0xc
	orr r5, r5, r0, lsl #20
	cmp r1, #0
	sub r0, r5, #0x24000
	sub r1, r1, #1
	bne _0216DE84
	bl _f_itof
	ldr r1, _0216DEFC // =0x45800000
	bl _fdiv
	bl _f_ftoi
	ldrh r2, [r4, #4]
	mov r1, #0x88
	mla r1, r2, r1, r4
	add r1, r1, #0x200
	strh r0, [r1, #0x18]
	b _0216DEE8
_0216DEE0:
	add r0, r0, #1
	strh r0, [r4, #6]
_0216DEE8:
	bl ovl09_216E270
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216DEFC: .word 0x45800000
	arm_func_end ovl09_216DC00

	arm_func_start ovl09_216DF00
ovl09_216DF00: // 0x0216DF00
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0x80
	strh r1, [r0, #0x80]
	mov ip, r1
	mov r3, #0
	mov r1, #0x88
_0216DF1C:
	mla lr, r3, r1, r0
	add r3, r3, #1
	add r2, lr, #0x100
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	strh ip, [r2, #8]
	add r2, lr, #0x200
	strh ip, [r2, #0x18]
	cmp r3, #2
	blo _0216DF1C
	bl GetExTaskCurrent
	ldr r1, _0216DF58 // =ovl09_216DF5C
	str r1, [r0]
	bl ovl09_216DF5C
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216DF58: .word ovl09_216DF5C
	arm_func_end ovl09_216DF00

	arm_func_start ovl09_216DF5C
ovl09_216DF5C: // 0x0216DF5C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	ldr r1, _0216E074 // =padInput
	mov r4, r0
	ldrh r0, [r1, #4]
	tst r0, #0x40
	beq _0216DFAC
	mov ip, #0x2d
	sub r1, ip, #0x2e
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	mov r0, #1
	strh r0, [r4, #2]
	mov r0, #0
	strh r0, [r4, #4]
	b _0216E05C
_0216DFAC:
	tst r0, #0x80
	beq _0216DFE4
	mov ip, #0x2d
	sub r1, ip, #0x2e
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	mov r0, #0
	strh r0, [r4, #2]
	mov r0, #1
	strh r0, [r4, #4]
	b _0216E05C
_0216DFE4:
	tst r0, #1
	beq _0216E01C
	mov r0, #1
	mov ip, #0x2e
	sub r1, ip, #0x2f
	str r0, [r4, #0x14]
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl ovl09_216E078
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0216E01C:
	tst r0, #8
	beq _0216E05C
	mov r0, #0
	str r0, [r4, #0x14]
	mov r1, #1
	strh r1, [r4, #2]
	mov ip, #0x2c
	sub r1, ip, #0x2d
	strh r0, [r4, #4]
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl ovl09_216E078
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0216E05C:
	bl ovl09_216E270
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E074: .word padInput
	arm_func_end ovl09_216DF5C

	arm_func_start ovl09_216E078
ovl09_216E078: // 0x0216E078
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0
	strh r1, [r0, #0xc]
	strh r1, [r0, #0xa]
	mov r1, #0x10
	strh r1, [r0, #6]
	bl GetExTaskCurrent
	ldr r1, _0216E0A8 // =ovl09_216E0AC
	str r1, [r0]
	bl ovl09_216E0AC
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216E0A8: .word ovl09_216E0AC
	arm_func_end ovl09_216E078

	arm_func_start ovl09_216E0AC
ovl09_216E0AC: // 0x0216E0AC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _0216E144
	ldrsh r0, [r4, #0xc]
	cmp r0, #0x1000
	blt _0216E0E4
	bl GetExTaskCurrent
	ldr r1, _0216E1E0 // =ovl09_216E1E8
	str r1, [r0]
	bl ovl09_216E1E8
	ldmia sp!, {r4, pc}
_0216E0E4:
	add r0, r0, #0x200
	strh r0, [r4, #0xc]
	ldrsh r2, [r4, #0xc]
	mov r0, #0xa0000
	mov r1, #0
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	adds r2, ip, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x80000
	bl _f_itof
	ldr r1, _0216E1E4 // =0x45800000
	bl _fdiv
	bl _f_ftoi
	ldrh r2, [r4, #4]
	mov r1, #0x88
	mla r1, r2, r1, r4
	add r1, r1, #0x200
	strh r0, [r1, #0x18]
	b _0216E1CC
_0216E144:
	ldrh r0, [r4, #4]
	cmp r0, #0
	beq _0216E1CC
	ldrsh r0, [r4, #0xa]
	cmp r0, #0x1000
	blt _0216E170
	bl GetExTaskCurrent
	ldr r1, _0216E1E0 // =ovl09_216E1E8
	str r1, [r0]
	bl ovl09_216E1E8
	ldmia sp!, {r4, pc}
_0216E170:
	add r0, r0, #0x200
	strh r0, [r4, #0xa]
	ldrsh r2, [r4, #0xa]
	mov r0, #0xa0000
	mov r1, #0
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	adds r2, ip, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x80000
	bl _f_itof
	ldr r1, _0216E1E4 // =0x45800000
	bl _fdiv
	bl _f_ftoi
	ldrh r2, [r4, #2]
	mov r1, #0x88
	mla r1, r2, r1, r4
	add r1, r1, #0x100
	strh r0, [r1, #8]
_0216E1CC:
	bl ovl09_216E270
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E1E0: .word ovl09_216E1E8
_0216E1E4: .word 0x45800000
	arm_func_end ovl09_216E0AC

	arm_func_start ovl09_216E1E8
ovl09_216E1E8: // 0x0216E1E8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrsh r1, [r0, #6]
	cmp r1, #0
	suble r1, r1, #1
	strleh r1, [r0, #6]
	ble _0216E254
	ldr r1, [r0, #0x14]
	cmp r1, #0
	beq _0216E248
	ldrh r1, [r0, #2]
	cmp r1, #0
	beq _0216E22C
	ldr r0, _0216E268 // =exPauseTask__word_2177B98
	mov r1, #1
	strh r1, [r0]
	b _0216E254
_0216E22C:
	ldrh r0, [r0, #4]
	cmp r0, #0
	beq _0216E254
	ldr r0, _0216E268 // =exPauseTask__word_2177B98
	mov r1, #2
	strh r1, [r0]
	b _0216E254
_0216E248:
	ldr r0, _0216E268 // =exPauseTask__word_2177B98
	mov r1, #1
	strh r1, [r0]
_0216E254:
	bl ovl09_216E270
	bl GetExTaskCurrent
	ldr r1, _0216E26C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216E268: .word exPauseTask__word_2177B98
_0216E26C: .word ExTask_State_Destroy
	arm_func_end ovl09_216E1E8

	arm_func_start ovl09_216E270
ovl09_216E270: // 0x0216E270
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x18
	bl ovl09_2161908
	ldrh r1, [r4, #2]
	add r2, r4, #0xa0
	mov r0, #0x88
	mla r0, r1, r0, r2
	bl ovl09_2161908
	ldrh r1, [r4, #4]
	add r2, r4, #0x1b0
	mov r0, #0x88
	mla r0, r1, r0, r2
	bl ovl09_2161908
	ldrsh r0, [r4, #0x80]
	mov r1, #0x88
	strh r0, [r4, #0x24]
	ldrsh r0, [r4, #0x82]
	strh r0, [r4, #0x26]
	ldrh r0, [r4, #2]
	mla r2, r0, r1, r4
	add r0, r2, #0x100
	ldrsh r0, [r0, #8]
	strh r0, [r2, #0xac]
	ldrh r0, [r4, #2]
	mla r2, r0, r1, r4
	add r0, r2, #0x100
	ldrsh r0, [r0, #0xa]
	strh r0, [r2, #0xae]
	ldrh r0, [r4, #4]
	mla r3, r0, r1, r4
	add r0, r3, #0x200
	ldrsh r2, [r0, #0x18]
	add r0, r3, #0x100
	strh r2, [r0, #0xbc]
	ldrh r0, [r4, #4]
	mla r2, r0, r1, r4
	add r0, r2, #0x200
	ldrsh r1, [r0, #0x1a]
	add r0, r2, #0x100
	strh r1, [r0, #0xbe]
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x1c
	bl AnimatorSprite__DrawFrame
	ldrh r1, [r4, #2]
	add r2, r4, #0xa4
	mov r0, #0x88
	mla r0, r1, r0, r2
	bl AnimatorSprite__DrawFrame
	ldrh r1, [r4, #4]
	add r2, r4, #0x1b4
	mov r0, #0x88
	mla r0, r1, r0, r2
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_216E270

	arm_func_start exPauseTask__Create
exPauseTask__Create: // 0x0216E358
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r0, #0
	str r0, [sp]
	mov r1, #0x2c0
	mov r4, #1
	ldr r0, _0216E3D0 // =aExpausetask
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0216E3D4 // =exPauseTask__Main
	ldr r1, _0216E3D8 // =exPauseTask__Destructor
	rsb r2, r4, #0xf000
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r1, #0
	mov r2, #0x2c0
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r2, _0216E3DC // =exPauseTask__Func8
	ldr r1, _0216E3E0 // =exPauseTask__word_2177B98
	str r2, [r0, #8]
	mov r0, #0
	strh r0, [r1]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E3D0: .word aExpausetask
_0216E3D4: .word exPauseTask__Main
_0216E3D8: .word exPauseTask__Destructor
_0216E3DC: .word exPauseTask__Func8
_0216E3E0: .word exPauseTask__word_2177B98
	arm_func_end exPauseTask__Create

	arm_func_start ovl09_216E3E4
ovl09_216E3E4: // 0x0216E3E4
	ldr r0, _0216E3F0 // =exPauseTask__word_2177B98
	ldrh r0, [r0, #0]
	bx lr
	.align 2, 0
_0216E3F0: .word exPauseTask__word_2177B98
	arm_func_end ovl09_216E3E4

	.data
	
_02175DEC:
	.hword 0x59, 0x5E, 0x63, 0x68, 0x6D, 0x72, 0x5A, 0x5F, 0x64, 0x69, 0x6E, 0x73, 0x5B, 0x60, 0x65, 0x6A, 0x6F, 0x74
    .hword 0x5C, 0x61, 0x66, 0x6B, 0x70, 0x75, 0x5D, 0x62, 0x67, 0x6C, 0x71, 0x76

aExpausetask: // 0x02175E28
	.asciz "exPauseTask"