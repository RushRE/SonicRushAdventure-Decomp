	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start Unknown2051334__Func_2051334
Unknown2051334__Func_2051334: // 0x02051334
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	mov r7, r0
	sub r4, r2, r7
	mov r6, r1
	sub r5, r3, r6
	ldr r1, [sp, #0x24]
	ldr r0, [sp, #0x20]
	smull r2, r8, r1, r5
	adds sb, r2, #0x800
	smull r2, r3, r0, r4
	adc r1, r8, #0
	adds r8, r2, #0x800
	mov r2, sb, lsr #0xc
	smull r0, sb, r7, r4
	adc lr, r3, #0
	adds ip, r0, #0x800
	mov r0, r8, lsr #0xc
	smull r3, r8, r6, r5
	orr r2, r2, r1, lsl #20
	orr r0, r0, lr, lsl #20
	adc r1, sb, #0
	mov sb, ip, lsr #0xc
	orr sb, sb, r1, lsl #20
	sub r0, r0, sb
	adds sb, r3, #0x800
	smull r1, r3, r4, r4
	add ip, r2, r0
	adc r0, r8, #0
	mov r2, sb, lsr #0xc
	orr r2, r2, r0, lsl #20
	sub r0, ip, r2
	adds r8, r1, #0x800
	smull r2, r1, r5, r5
	adc r3, r3, #0
	mov r8, r8, lsr #0xc
	orr r8, r8, r3, lsl #20
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, r8, r2
	mov r8, r4, asr #0x1f
	mov sb, r5, asr #0x1f
	bl FX_Div
	ldr r1, [sp, #0x28]
	cmp r1, #0
	beq _02051418
	mov r2, r0, asr #0x1f
	umull ip, r3, r4, r0
	mla r3, r4, r2, r3
	adds r4, ip, #0x800
	mla r3, r8, r0, r3
	adc r2, r3, #0
	mov r3, r4, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, r7, r3
	str r2, [r1]
_02051418:
	ldr r4, [sp, #0x2c]
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	mov r1, r0, asr #0x1f
	umull r3, r2, r5, r0
	mla r2, r5, r1, r2
	adds r1, r3, #0x800
	mla r2, sb, r0, r2
	adc r0, r2, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r6, r1
	str r0, [r4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	arm_func_end Unknown2051334__Func_2051334

	arm_func_start Unknown2051334__Func_2051450
Unknown2051334__Func_2051450: // 0x02051450
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #0x10
	ldr r7, [sp, #0x30]
	ldr r8, [sp, #0x34]
	ldr sb, [sp, #0x3c]
	sub r4, r0, r7
	sub r5, sb, r8
	smull r4, sl, r5, r4
	adds ip, r4, #0x800
	ldr lr, [sp, #0x38]
	sub r5, r1, r8
	sub r4, lr, r7
	smull r6, r5, r4, r5
	adc sl, sl, #0
	adds r4, r6, #0x800
	mov r6, ip, lsr #0xc
	adc r5, r5, #0
	mov r4, r4, lsr #0xc
	orr r6, r6, sl, lsl #20
	orr r4, r4, r5, lsl #20
	sub r4, r6, r4
	cmp r4, #0
	mov r4, #0
	addle sp, sp, #0x10
	movle r0, r4
	ldmleia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	stmia sp, {r0, r1, r2, r3}
	mov r0, lr
	mov r1, sb
	mov r2, r7
	mov r3, r8
	bl Unknown2051334__Func_2051334
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	arm_func_end Unknown2051334__Func_2051450

	arm_func_start Unknown2051334__Func_20514DC
Unknown2051334__Func_20514DC: // 0x020514DC
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r1]
	ldr ip, [r2]
	sub ip, ip, r5
	smull r4, lr, ip, r3
	adds ip, r4, #0x800
	adc r4, lr, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r4, lsl #20
	add r4, r5, ip
	str r4, [r0]
	ldr ip, [r1, #4]
	ldr r1, [r2, #4]
	sub r1, r1, ip
	smull r3, r2, r1, r3
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, ip, r2
	str r1, [r0, #4]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Unknown2051334__Func_20514DC

	arm_func_start Unknown2051334__Func_2051534
Unknown2051334__Func_2051534: // 0x02051534
	stmdb sp!, {r4, r5, r6, lr}
	ldr r5, [sp, #0x10]
	mov r6, r0
	cmp r5, #0x1000
	sub r4, r1, r6
	bne _02051560
	mul r0, r4, r3
	mov r1, r2
	bl FX_DivS32
	add r0, r6, r0
	ldmia sp!, {r4, r5, r6, pc}
_02051560:
	mov r0, r3, lsl #0xc
	mov r1, r2, lsl #0xc
	bl FX_Div
	cmp r5, #0
	bne _0205158C
	smull r2, r1, r0, r0
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	b _020515F4
_0205158C:
	cmp r5, #0x2000
	bne _020515B0
	smull r2, r1, r0, r0
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	rsb r1, r2, r0, lsl #1
	b _020515F4
_020515B0:
	smull r1, r3, r0, r5
	adds ip, r1, #0x800
	smull r2, r1, r0, r0
	adc r0, r3, #0
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	mov ip, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	rsb r1, r5, #0x1000
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr ip, ip, r0, lsl #20
	orr r2, r2, r1, lsl #20
	add r1, ip, r2
_020515F4:
	mul r0, r4, r1
	add r0, r6, r0, asr #12
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end Unknown2051334__Func_2051534

	arm_func_start Unknown2051334__Func_2051600
Unknown2051334__Func_2051600: // 0x02051600
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r2
	mov r5, r0
	cmp r4, #0x1000
	moveq r0, r1
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r1, lsl #0xc
	mov r1, r5, lsl #0xc
	bl FX_Div
	cmp r4, #0
	bne _02051644
	smull r2, r1, r0, r0
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	b _020516AC
_02051644:
	cmp r4, #0x2000
	bne _02051668
	smull r2, r1, r0, r0
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	rsb r1, r2, r0, lsl #1
	b _020516AC
_02051668:
	smull r1, r3, r0, r4
	adds ip, r1, #0x800
	smull r2, r1, r0, r0
	adc r3, r3, #0
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	mov ip, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	rsb r0, r4, #0x1000
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr ip, ip, r3, lsl #20
	orr r1, r1, r0, lsl #20
	add r1, ip, r1
_020516AC:
	mul r0, r5, r1
	mov r0, r0, asr #0xc
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Unknown2051334__Func_2051600

	arm_func_start Unknown2051334__Func_20516B8
Unknown2051334__Func_20516B8: // 0x020516B8
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r3, #0
	sub ip, r1, r4
	ldmeqia sp!, {r4, pc}
	cmp r3, r2
	beq _020516E4
	mul r0, ip, r3
	mov r1, r2
	bl FX_DivS32
	add r1, r4, r0
_020516E4:
	mov r0, r1
	ldmia sp!, {r4, pc}
	arm_func_end Unknown2051334__Func_20516B8

	arm_func_start Unknown2051334__Func_20516EC
Unknown2051334__Func_20516EC: // 0x020516EC
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	strh r1, [sp]
	strh r0, [sp, #2]
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	mov r4, r3
	mov r0, r0, lsl #0x1b
	mov r6, r1, lsl #0x1b
	mov r0, r0, lsr #0x1b
	sub r0, r0, r6, lsr #27
	mul r0, r4, r0
	mov r5, r2
	mov r1, r5
	bl FX_DivS32
	adds r0, r0, r6, lsr #27
	movmi r0, #0
	bmi _0205173C
	cmp r0, #0x1f
	movgt r0, #0x1f
_0205173C:
	ldrh r1, [sp, #2]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bic r1, r1, #0x1f
	and r0, r0, #0x1f
	orr r0, r1, r0
	strh r0, [sp, #2]
	ldrh r0, [sp]
	ldrh r2, [sp, #2]
	mov r1, r5
	mov r0, r0, lsl #0x16
	mov r6, r2, lsl #0x16
	mov r0, r0, lsr #0x1b
	sub r0, r0, r6, lsr #27
	mul r0, r4, r0
	bl FX_DivS32
	adds r0, r0, r6, lsr #27
	movmi r0, #0
	bmi _02051790
	cmp r0, #0x1f
	movgt r0, #0x1f
_02051790:
	ldrh r1, [sp, #2]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bic r1, r1, #0x3e0
	mov r0, r0, lsl #0x1b
	orr r0, r1, r0, lsr #22
	strh r0, [sp, #2]
	ldrh r0, [sp]
	ldrh r2, [sp, #2]
	mov r1, r5
	mov r0, r0, lsl #0x11
	mov r5, r2, lsl #0x11
	mov r0, r0, lsr #0x1b
	sub r0, r0, r5, lsr #27
	mul r0, r4, r0
	bl FX_DivS32
	adds r0, r0, r5, lsr #27
	movmi r0, #0
	bmi _020517E4
	cmp r0, #0x1f
	movgt r0, #0x1f
_020517E4:
	ldrh r1, [sp, #2]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bic r1, r1, #0x7c00
	mov r0, r0, lsl #0x1b
	orr r0, r1, r0, lsr #17
	strh r0, [sp, #2]
	ldrh r0, [sp, #2]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end Unknown2051334__Func_20516EC
