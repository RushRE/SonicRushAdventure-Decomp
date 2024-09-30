	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWCi_WStrLen
DWCi_WStrLen: // 0x0208F52C
	ldrh r1, [r0, #0]
	mov r2, #0
	cmp r1, #0
	beq _0208F550
_0208F53C:
	add r2, r2, #1
	mov r1, r2, lsl #1
	ldrh r1, [r0, r1]
	cmp r1, #0
	bne _0208F53C
_0208F550:
	mov r0, r2
	bx lr
	arm_func_end DWCi_WStrLen

	arm_func_start DWCi_GetMathRand32
DWCi_GetMathRand32: // 0x0208F558
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r2, _0208F674 // =0x021439F8
	mov r1, #0
	ldr r3, [r2, #4]
	ldr ip, [r2]
	cmp r3, r1
	mov r4, r0
	cmpeq ip, r1
	bne _0208F61C
	ldr r0, [r2, #0xc]
	ldr r3, [r2, #8]
	cmp r0, r1
	cmpeq r3, r1
	bne _0208F61C
	ldr r0, [r2, #0x14]
	ldr r2, [r2, #0x10]
	cmp r0, r1
	cmpeq r2, r1
	bne _0208F61C
	add r0, sp, #0
	bl OS_GetMacAddress
	bl OS_GetTick
	ldr r2, [sp]
	ldr r3, [sp, #4]
	mov lr, r2, lsr #0x18
	mov r2, r1, lsl #0x18
	orr lr, lr, r3, lsl #8
	mvn r1, #0xff000000
	mov ip, r3, lsr #0x18
	and r1, lr, r1
	orr r3, r1, r0, lsl #24
	and r1, ip, #0
	orr r2, r2, r0, lsr #8
	orr r1, r1, r2
	str r1, [sp, #4]
	ldr ip, _0208F674 // =0x021439F8
	add r0, sp, #0
	str r3, [sp]
	ldmia r0, {r2, r3}
	stmia ip, {r2, r3}
	ldr r3, _0208F678 // =0x6C078965
	ldr r2, _0208F67C // =0x5D588B65
	ldr r1, _0208F680 // =0x00269EC3
	mov r0, #0
	str r3, [ip, #8]
	str r2, [ip, #0xc]
	str r1, [ip, #0x10]
	str r0, [ip, #0x14]
_0208F61C:
	ldr r1, _0208F674 // =0x021439F8
	ldr r3, [r1, #8]
	ldr r2, [r1, #0]
	ldr r0, [r1, #4]
	umull lr, ip, r3, r2
	mla ip, r3, r0, ip
	ldr r0, [r1, #0xc]
	ldr r3, [r1, #0x10]
	mla ip, r0, r2, ip
	adds r2, r3, lr
	ldr r0, [r1, #0x14]
	str r2, [r1]
	adc r0, r0, ip
	cmp r4, #0
	str r0, [r1, #4]
	movne r3, #0
	umullne r2, r1, r0, r4
	mlane r1, r0, r3, r1
	mlane r1, r3, r4, r1
	movne r0, r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208F674: .word 0x021439F8
_0208F678: .word 0x6C078965
_0208F67C: .word 0x5D588B65
_0208F680: .word 0x00269EC3
	arm_func_end DWCi_GetMathRand32

	arm_func_start DWC_GetCommonValueString
DWC_GetCommonValueString: // 0x0208F684
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r4, r1
	mov r7, r0
	mov r6, r3
	addeq sp, sp, #4
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r2
	mov r1, r6
	bl strchr
	movs r5, r0
	addeq sp, sp, #4
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_0208F6C0:
	mov r0, r7
	bl strlen
	mov r2, r0
	mov r1, r7
	add r0, r5, #1
	bl strncmp
	cmp r0, #0
	bne _0208F6F8
	mov r0, r7
	bl strlen
	add r0, r0, r5
	ldrsb r0, [r0, #1]
	cmp r6, r0
	beq _0208F734
_0208F6F8:
	mov r1, r6
	add r0, r5, #1
	bl strchr
	cmp r0, #0
	addeq sp, sp, #4
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r1, r6
	add r0, r0, #1
	bl strchr
	movs r5, r0
	bne _0208F6C0
	add sp, sp, #4
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_0208F734:
	mov r1, r6
	add r0, r5, #1
	bl strchr
	movs r5, r0
	addeq sp, sp, #4
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r1, r6
	add r0, r5, #1
	bl strchr
	cmp r0, #0
	addne r1, r5, #1
	subne r6, r0, r1
	bne _0208F778
	add r0, r5, #1
	bl strlen
	mov r6, r0
_0208F778:
	mov r0, r4
	mov r2, r6
	add r1, r5, #1
	bl strncpy
	mov r1, #0
	mov r0, r6
	strb r1, [r4, r6]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end DWC_GetCommonValueString

	arm_func_start DWC_AddCommonKeyValueString
DWC_AddCommonKeyValueString: // 0x0208F79C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r2
	mov r7, r0
	mov r6, r1
	mov r4, r3
	mov r0, r5
	mov r1, #0
	bl strchr
	mov r2, r0
	mov r0, r7
	mov r1, r6
	mov r3, r4
	bl DWC_SetCommonKeyValueString
	mov r0, r5
	bl strlen
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end DWC_AddCommonKeyValueString

	arm_func_start DWC_SetCommonKeyValueString
DWC_SetCommonKeyValueString: // 0x0208F7E4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	str r0, [sp]
	mov r4, r2
	str r3, [sp, #4]
	str r1, [sp, #8]
	ldr r2, _0208F81C // =aCSCS
	mov r0, r4
	mov r1, #0x1000
	bl OS_SNPrintf
	mov r0, r4
	bl strlen
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208F81C: .word aCSCS
	arm_func_end DWC_SetCommonKeyValueString

	.data
	
aCSCS: // 0x0211C1E4
	.asciz "%c%s%c%s"
	.align 4