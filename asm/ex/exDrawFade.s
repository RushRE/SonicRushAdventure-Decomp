	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

exDrawFadeTask__word_21762E8: // 0x021762E8
	.space 0x04

exDrawFadeTask__word_21762EC: // 0x021762EC
	.space 0x04

exDrawFadeTask__word_21762F0: // 0x021762F0
	.space 0x02

exDrawFadeTask__word_21762F2: // 0x021762F2
	.space 0x02

exDrawFadeTask__word_21762F4: // 0x021762F4
	.space 0x02

exDrawFadeTask__word_21762F6: // 0x021762F6
	.space 0x02

	.align 4

exDrawFadeTask__unk_21762F8: // 0x021762F8
    .space 0x04
	
exDrawFadeTask__word_21762FC: // 0x021762FC
	.space 0xA4

	.align 4
	
exDrawFadeTask__word_21763A0: // 0x021763A0
	.space 0xA4

	.align 4

	.text

	arm_func_start ovl09_216078C
ovl09_216078C: // 0x0216078C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0xf
	bl ovl09_2154370
	add r0, r4, #0x3f8
	bl ovl09_21641F0
	mov r0, #0
	sub r1, r0, #1
	str r0, [sp]
	mov r2, #0x104
	str r2, [sp, #4]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	bl GetExTaskCurrent
	ldr r1, _021607E8 // =ovl09_21607EC
	str r1, [r0]
	bl ovl09_21607EC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021607E8: .word ovl09_21607EC
	arm_func_end ovl09_216078C

	arm_func_start ovl09_21607EC
ovl09_21607EC: // 0x021607EC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl ovl09_2162164
	add r0, r4, #0x6c
	bl ovl09_21623F8
	cmp r0, #0
	beq _02160818
	bl ovl09_216083C
	ldmia sp!, {r4, pc}
_02160818:
	add r0, r4, #0x6c
	bl ovl09_216AE78
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_21607EC

	arm_func_start ovl09_216083C
ovl09_216083C: // 0x0216083C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0x10
	bl ovl09_2154370
	add r0, r4, #0x3f8
	bl ovl09_21641F0
	bl GetExTaskCurrent
	ldr r1, _02160870 // =ovl09_2160874
	str r1, [r0]
	bl ovl09_2160874
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160870: .word ovl09_2160874
	arm_func_end ovl09_216083C

	arm_func_start ovl09_2160874
ovl09_2160874: // 0x02160874
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl ovl09_2162164
	add r0, r4, #0x6c
	bl ovl09_21623F8
	cmp r0, #0
	beq _021608A0
	bl ovl09_21608C4
	ldmia sp!, {r4, pc}
_021608A0:
	add r0, r4, #0x6c
	bl ovl09_216AE78
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2160874

	arm_func_start ovl09_21608C4
ovl09_21608C4: // 0x021608C4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0x11
	bl ovl09_2154370
	add r0, r4, #0x3f8
	bl ovl09_21641F0
	mov r0, #0
	str r0, [r4, #0x30]
	bl GetExTaskCurrent
	ldr r1, _02160900 // =ovl09_2160904
	str r1, [r0]
	bl ovl09_2160904
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160900: .word ovl09_2160904
	arm_func_end ovl09_21608C4

	arm_func_start ovl09_2160904
ovl09_2160904: // 0x02160904
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl ovl09_2162164
	ldr r0, [r4, #0x3c0]
	cmp r0, #0x78000
	ldrle r0, [r4, #0x30]
	cmple r0, #0x14000
	bgt _0216094C
	add r0, r0, #0xcd
	add r0, r0, #0xc00
	str r0, [r4, #0x30]
	ldr r0, [r4, #0x3c0]
	add r0, r0, #0xcd
	add r0, r0, #0xc00
	str r0, [r4, #0x3c0]
_0216094C:
	ldr r0, [r4, #0x3b0]
	ldr r0, [r0, #0]
	cmp r0, #0xf000
	blt _02160990
	mov r4, #0xc9
	sub r1, r4, #0xca
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _021609D4 // =ovl09_21609D8
	str r1, [r0]
	bl ovl09_21609D8
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02160990:
	add r0, r4, #0x6c
	bl ovl09_21623F8
	cmp r0, #0
	beq _021609AC
	bl ovl09_2160AD4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_021609AC:
	add r0, r4, #0x6c
	bl ovl09_216AE78
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021609D4: .word ovl09_21609D8
	arm_func_end ovl09_2160904

	arm_func_start ovl09_21609D8
ovl09_21609D8: // 0x021609D8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl ovl09_2162164
	ldr r0, [r4, #0x3c0]
	cmp r0, #0x78000
	ldrle r0, [r4, #0x30]
	cmple r0, #0x14000
	bgt _02160A1C
	add r0, r0, #0xcd
	add r0, r0, #0xc00
	str r0, [r4, #0x30]
	ldr r0, [r4, #0x3c0]
	add r0, r0, #0xcd
	add r0, r0, #0xc00
	str r0, [r4, #0x3c0]
_02160A1C:
	ldr r0, [r4, #0x3b0]
	ldr r0, [r0, #0]
	cmp r0, #0x25000
	blt _02160A44
	bl exBossMagmeWaveTask__Create
	bl GetExTaskCurrent
	ldr r1, _02160A80 // =ovl09_2160A84
	str r1, [r0]
	bl ovl09_2160A84
	ldmia sp!, {r4, pc}
_02160A44:
	add r0, r4, #0x6c
	bl ovl09_21623F8
	cmp r0, #0
	beq _02160A5C
	bl ovl09_2160AD4
	ldmia sp!, {r4, pc}
_02160A5C:
	add r0, r4, #0x6c
	bl ovl09_216AE78
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160A80: .word ovl09_2160A84
	arm_func_end ovl09_21609D8

	arm_func_start ovl09_2160A84
ovl09_2160A84: // 0x02160A84
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl ovl09_2162164
	add r0, r4, #0x6c
	bl ovl09_21623F8
	cmp r0, #0
	beq _02160AB0
	bl ovl09_2160AD4
	ldmia sp!, {r4, pc}
_02160AB0:
	add r0, r4, #0x6c
	bl ovl09_216AE78
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2160A84

	arm_func_start ovl09_2160AD4
ovl09_2160AD4: // 0x02160AD4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, _02160CA8 // =_mt_math_rand
	ldr r2, _02160CAC // =0x00196225
	ldr r5, [r1, #0]
	ldr r3, _02160CB0 // =0x3C6EF35F
	mov r4, r0
	mla r0, r5, r2, r3
	mla r2, r0, r2, r3
	mov r3, r0, lsr #0x10
	mov r0, r2, lsr #0x10
	mov r3, r3, lsl #0x10
	mov ip, r0, lsl #0x10
	mov r5, r3, lsr #0x10
	mov lr, ip, lsr #0x10
	ldr r8, _02160CB4 // =0x51EB851F
	mov r0, r5, lsr #0x1f
	smull r6, r5, r8, r5
	mov r7, lr, lsr #0x1f
	smull lr, r6, r8, lr
	add r5, r0, r5, asr #5
	mov lr, #0x64
	add r6, r7, r6, asr #5
	smull r5, r0, lr, r5
	smull r6, r0, lr, r6
	add r0, r4, #0x6c
	str r2, [r1]
	mov r1, #0x12
	rsb r5, r5, r3, lsr #16
	rsb r6, r6, ip, lsr #16
	bl ovl09_2154370
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_2164218
	cmp r5, #0x14
	bge _02160B70
	cmp r5, #0
	movge r0, #0xb4
	strgeh r0, [r4, #0x56]
	bge _02160B9C
_02160B70:
	cmp r5, #0x14
	blt _02160B88
	cmp r5, #0x46
	movlt r0, #0x12c
	strlth r0, [r4, #0x56]
	blt _02160B9C
_02160B88:
	cmp r5, #0x46
	blt _02160B9C
	cmp r5, #0x64
	movle r0, #0x1e0
	strleh r0, [r4, #0x56]
_02160B9C:
	cmp r6, #0x32
	bge _02160BC0
	cmp r5, #0
	blt _02160BC0
	ldr r0, [r4, #0x3bc]
	str r0, [r4, #0x14]
	ldr r0, [r4, #0x3bc]
	str r0, [r4, #0x20]
	b _02160C0C
_02160BC0:
	cmp r6, #0x32
	blt _02160BE8
	cmp r6, #0x50
	bge _02160BE8
	mov r0, #0xc800
	rsb r0, r0, #0
	str r0, [r4, #0x14]
	mov r0, #0xc800
	str r0, [r4, #0x20]
	b _02160C0C
_02160BE8:
	cmp r6, #0x50
	blt _02160C0C
	cmp r6, #0x64
	bgt _02160C0C
	mov r0, #0x19000
	rsb r0, r0, #0
	str r0, [r4, #0x14]
	mov r0, #0x19000
	str r0, [r4, #0x20]
_02160C0C:
	mov r6, #0
	str r6, [r4, #0x48]
	str r6, [r4, #0x4c]
	ldr r2, _02160CA8 // =_mt_math_rand
	str r6, [r4, #0x50]
	ldr r3, [r2, #0]
	ldr r0, _02160CAC // =0x00196225
	ldr r1, _02160CB0 // =0x3C6EF35F
	mla r5, r3, r0, r1
	mov r0, r5, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	adds r0, r1, r0, ror #31
	str r5, [r2]
	strne r6, [r4, #0xc]
	moveq r0, #1
	streq r0, [r4, #0xc]
	ldr r2, _02160CA8 // =_mt_math_rand
	ldr r0, _02160CAC // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02160CB0 // =0x3C6EF35F
	mla r5, r3, r0, r1
	mov r0, r5, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	adds r0, r1, r0, ror #31
	movne r0, #0
	str r5, [r2]
	moveq r0, #1
	str r0, [r4, #0x10]
	bl GetExTaskCurrent
	ldr r1, _02160CB8 // =ovl09_2160CBC
	str r1, [r0]
	bl ovl09_2160CBC
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02160CA8: .word _mt_math_rand
_02160CAC: .word 0x00196225
_02160CB0: .word 0x3C6EF35F
_02160CB4: .word 0x51EB851F
_02160CB8: .word ovl09_2160CBC
	arm_func_end ovl09_2160AD4

	arm_func_start ovl09_2160CBC
ovl09_2160CBC: // 0x02160CBC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl ovl09_2162164
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _02160CE8
	bl ovl09_2160E28
	b _02160CEC
_02160CE8:
	bl ovl09_2160E50
_02160CEC:
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _02160D00
	bl ovl09_2160DD8
	b _02160D04
_02160D00:
	bl ovl09_2160E04
_02160D04:
	ldr r3, [r4, #0x48]
	ldr r0, [r4, #0x3bc]
	ldr r2, [r4, #0x3c0]
	ldr r1, [r4, #0x4c]
	sub r0, r3, r0
	sub r1, r2, r1
	bl ovl09_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0xb8]
	ldrsh r0, [r4, #0x56]
	cmp r0, #0
	bgt _02160D60
	mov r1, #0
	add r0, r4, #0x3f8
	strh r1, [r4, #0x56]
	bl ovl09_21641F0
	add r0, r4, #0x6c
	bl ovl09_21623F8
	cmp r0, #0
	beq _02160DAC
	bl ovl09_2160E78
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02160D60:
	sub r0, r0, #1
	strh r0, [r4, #0x56]
	ldrsh ip, [r4, #0x56]
	ldr r3, _02160DD4 // =0x2AAAAAAB
	mov r2, #0xc
	mov r0, ip, lsr #0x1f
	smull r1, lr, r3, ip
	add lr, r0, lr, asr #1
	smull r0, r1, r2, lr
	subs lr, ip, r0
	bne _02160DAC
	mov ip, #0xca
	sub r1, ip, #0xcb
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl exBossMagmaAttackTask__Create
_02160DAC:
	add r0, r4, #0x6c
	bl ovl09_216AE78
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160DD4: .word 0x2AAAAAAB
	arm_func_end ovl09_2160CBC

	arm_func_start ovl09_2160DD8
ovl09_2160DD8: // 0x02160DD8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0x5a000
	ldr r2, [r0, #0x48]
	rsb r1, r1, #0
	cmp r2, r1
	movle r1, #0
	strle r1, [r0, #0xc]
	subgt r1, r2, #0x4000
	strgt r1, [r0, #0x48]
	ldmia sp!, {r3, pc}
	arm_func_end ovl09_2160DD8

	arm_func_start ovl09_2160E04
ovl09_2160E04: // 0x02160E04
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, [r0, #0x48]
	cmp r1, #0x5a000
	movge r1, #1
	strge r1, [r0, #0xc]
	addlt r1, r1, #0x4000
	strlt r1, [r0, #0x48]
	ldmia sp!, {r3, pc}
	arm_func_end ovl09_2160E04

	arm_func_start ovl09_2160E28
ovl09_2160E28: // 0x02160E28
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r2, [r0, #0x3bc]
	ldr r1, [r0, #0x14]
	cmp r2, r1
	movle r1, #0
	strle r1, [r0, #0x10]
	subgt r1, r2, #0x800
	strgt r1, [r0, #0x3bc]
	ldmia sp!, {r3, pc}
	arm_func_end ovl09_2160E28

	arm_func_start ovl09_2160E50
ovl09_2160E50: // 0x02160E50
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r2, [r0, #0x3bc]
	ldr r1, [r0, #0x20]
	cmp r2, r1
	movge r1, #1
	strge r1, [r0, #0x10]
	addlt r1, r2, #0x800
	strlt r1, [r0, #0x3bc]
	ldmia sp!, {r3, pc}
	arm_func_end ovl09_2160E50

	arm_func_start ovl09_2160E78
ovl09_2160E78: // 0x02160E78
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0x13
	bl ovl09_2154370
	add r0, r4, #0x3f8
	bl ovl09_21641F0
	bl GetExTaskCurrent
	ldr r1, _02160EAC // =ovl09_2160EB0
	str r1, [r0]
	bl ovl09_2160EB0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160EAC: .word ovl09_2160EB0
	arm_func_end ovl09_2160E78

	arm_func_start ovl09_2160EB0
ovl09_2160EB0: // 0x02160EB0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl ovl09_2162164
	ldr lr, [r4, #0x48]
	ldr r0, _02160F88 // =0x0000019A
	rsb r2, lr, #0
	umull ip, r3, r2, r0
	mov r1, #0
	mla r3, r2, r1, r3
	mov r2, r2, asr #0x1f
	mla r3, r2, r0, r3
	adds ip, ip, #0x800
	adc r2, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, lr, r3
	str r2, [r4, #0x48]
	ldr lr, [r4, #0x4c]
	rsb r2, lr, #0
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r1, ip, #0x800
	adc r0, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r2, lr, r1
	str r2, [r4, #0x4c]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x3bc]
	sub r0, r1, r0
	ldr r1, [r4, #0x3c0]
	sub r1, r1, r2
	bl ovl09_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0xb8]
	add r0, r4, #0x6c
	bl ovl09_21623F8
	cmp r0, #0
	beq _02160F64
	bl ovl09_2160F8C
	ldmia sp!, {r4, pc}
_02160F64:
	add r0, r4, #0x6c
	bl ovl09_216AE78
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160F88: .word 0x0000019A
	arm_func_end ovl09_2160EB0

	arm_func_start ovl09_2160F8C
ovl09_2160F8C: // 0x02160F8C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #0x548]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end ovl09_2160F8C

	arm_func_start ovl09_2160FA0
ovl09_2160FA0: // 0x02160FA0
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0xa4
	bl MIi_CpuClear16
	mov r1, #0
	strh r1, [r4, #0x50]
	strh r1, [r4]
	str r1, [r4, #0x54]
	str r1, [r4, #4]
	str r1, [r4, #0x58]
	str r1, [r4, #8]
	str r1, [r4, #0x5c]
	str r1, [r4, #0xc]
	str r1, [r4, #0x60]
	str r1, [r4, #0x10]
	str r1, [r4, #0x64]
	str r1, [r4, #0x68]
	str r1, [r4, #0x6c]
	ldr r0, [r4, #0x64]
	str r0, [r4, #0x14]
	ldr r0, [r4, #0x68]
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x6c]
	str r0, [r4, #0x1c]
	str r1, [r4, #0x70]
	str r1, [r4, #0x74]
	str r1, [r4, #0x78]
	ldr r0, [r4, #0x70]
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x74]
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x78]
	str r0, [r4, #0x28]
	str r1, [r4, #0x7c]
	str r1, [r4, #0x80]
	str r1, [r4, #0x84]
	ldr r0, [r4, #0x7c]
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x80]
	str r0, [r4, #0x30]
	ldr r0, [r4, #0x84]
	str r0, [r4, #0x34]
	str r1, [r4, #0x88]
	str r1, [r4, #0x8c]
	str r1, [r4, #0x90]
	ldr r0, [r4, #0x88]
	str r0, [r4, #0x38]
	ldr r0, [r4, #0x8c]
	str r0, [r4, #0x3c]
	ldr r0, [r4, #0x90]
	str r0, [r4, #0x40]
	str r1, [r4, #0x94]
	str r1, [r4, #0x98]
	str r1, [r4, #0x9c]
	ldr r0, [r4, #0x94]
	str r0, [r4, #0x44]
	ldr r0, [r4, #0x98]
	str r0, [r4, #0x48]
	ldr r0, [r4, #0x9c]
	str r0, [r4, #0x4c]
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2160FA0

	arm_func_start ovl09_216109C
ovl09_216109C: // 0x0216109C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x12
	bl MIi_CpuClear16
	mov r0, #0
	strh r0, [r4, #8]
	strh r0, [r4, #0xa]
	strh r0, [r4, #0xc]
	ldrsh r1, [r4, #8]
	ldr r0, _021610EC // =0x00007FFF
	strh r1, [r4]
	ldrsh r1, [r4, #0xa]
	strh r1, [r4, #2]
	ldrsh r1, [r4, #0xc]
	strh r1, [r4, #4]
	strh r0, [r4, #0xe]
	strh r0, [r4, #6]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021610EC: .word 0x00007FFF
	arm_func_end ovl09_216109C

	arm_func_start ovl09_21610F0
ovl09_21610F0: // 0x021610F0
	ldrh r1, [r0, #0x50]
	ldr ip, _021611B8 // =Camera3D__LoadState
	cmp r1, #0xb6
	movlo r1, #0xb6
	strloh r1, [r0, #0x50]
	ldrh r2, [r0, #0x50]
	ldr r1, _021611BC // =0x00003F49
	cmp r2, r1
	strhih r1, [r0, #0x50]
	ldrh r1, [r0, #0x50]
	strh r1, [r0]
	ldr r1, [r0, #0x54]
	str r1, [r0, #4]
	ldr r1, [r0, #0x58]
	str r1, [r0, #8]
	ldr r1, [r0, #0x5c]
	str r1, [r0, #0xc]
	ldr r1, [r0, #0x60]
	str r1, [r0, #0x10]
	ldr r1, [r0, #0x64]
	str r1, [r0, #0x14]
	ldr r1, [r0, #0x68]
	str r1, [r0, #0x18]
	ldr r1, [r0, #0x6c]
	str r1, [r0, #0x1c]
	ldr r1, [r0, #0x70]
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x74]
	str r1, [r0, #0x24]
	ldr r1, [r0, #0x78]
	str r1, [r0, #0x28]
	ldr r1, [r0, #0x7c]
	str r1, [r0, #0x2c]
	ldr r1, [r0, #0x80]
	str r1, [r0, #0x30]
	ldr r1, [r0, #0x84]
	str r1, [r0, #0x34]
	ldr r1, [r0, #0x88]
	str r1, [r0, #0x38]
	ldr r1, [r0, #0x8c]
	str r1, [r0, #0x3c]
	ldr r1, [r0, #0x90]
	str r1, [r0, #0x40]
	ldr r1, [r0, #0x94]
	str r1, [r0, #0x44]
	ldr r1, [r0, #0x98]
	str r1, [r0, #0x48]
	ldr r1, [r0, #0x9c]
	str r1, [r0, #0x4c]
	bx ip
	.align 2, 0
_021611B8: .word Camera3D__LoadState
_021611BC: .word 0x00003F49
	arm_func_end ovl09_21610F0

	arm_func_start ovl09_21611C0
ovl09_21611C0: // 0x021611C0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrb r0, [r4, #0x10]
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _021612B4
_021611D8: // jump table
	b _021612B4 // case 0
	b _021611F8 // case 1
	b _02161204 // case 2
	b _02161210 // case 3
	b _0216121C // case 4
	b _02161228 // case 5
	b _02161234 // case 6
	b _02161240 // case 7
_021611F8:
	mov r0, #0x7c00
	strh r0, [r4, #6]
	b _021612BC
_02161204:
	mov r0, #0x3e0
	strh r0, [r4, #6]
	b _021612BC
_02161210:
	ldr r0, _02161308 // =0x00007FE0
	strh r0, [r4, #6]
	b _021612BC
_0216121C:
	mov r0, #0x1f
	strh r0, [r4, #6]
	b _021612BC
_02161228:
	ldr r0, _0216130C // =0x00007C1F
	strh r0, [r4, #6]
	b _021612BC
_02161234:
	ldr r0, _02161310 // =0x000003FF
	strh r0, [r4, #6]
	b _021612BC
_02161240:
	bl ovl09_2173424
	mov r1, r4
	mov r2, #0
	bl GetDrawStateLight
	mov r1, r4
	mov r0, #0
	bl Camera3D__SetLight
	bl ovl09_2173424
	mov r1, r4
	mov r2, #1
	bl GetDrawStateLight
	mov r0, #1
	mov r1, r4
	bl Camera3D__SetLight
	bl ovl09_2173424
	mov r1, r4
	mov r2, #2
	bl GetDrawStateLight
	mov r0, #2
	mov r1, r4
	bl Camera3D__SetLight
	bl ovl09_2173424
	mov r1, r4
	mov r2, #3
	bl GetDrawStateLight
	mov r1, r4
	mov r0, #3
	bl Camera3D__SetLight
	ldmia sp!, {r4, pc}
_021612B4:
	ldrh r0, [r4, #0xe]
	strh r0, [r4, #6]
_021612BC:
	ldrsh r2, [r4, #8]
	mov r1, r4
	mov r0, #0
	strh r2, [r4]
	ldrsh r2, [r4, #0xa]
	strh r2, [r4, #2]
	ldrsh r2, [r4, #0xc]
	strh r2, [r4, #4]
	bl Camera3D__SetLight
	mov r1, r4
	mov r0, #1
	bl Camera3D__SetLight
	mov r1, r4
	mov r0, #2
	bl Camera3D__SetLight
	mov r1, r4
	mov r0, #3
	bl Camera3D__SetLight
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161308: .word 0x00007FE0
_0216130C: .word 0x00007C1F
_02161310: .word 0x000003FF
	arm_func_end ovl09_21611C0

	arm_func_start ovl09_2161314
ovl09_2161314: // 0x02161314
	mov r2, #1
	ldr r1, _021613A0 // =0x000004FA
	strh r2, [r0, #0xa2]
	strh r1, [r0, #0x50]
	mov ip, #0x1000
	str ip, [r0, #0x54]
	mov r3, #0x800000
	mov r2, #0
	ldr r1, _021613A4 // =0x00001555
	str r3, [r0, #0x58]
	str r1, [r0, #0x5c]
	str ip, [r0, #0x60]
	str r2, [r0, #0x70]
	sub r1, r2, #0x26800
	str r1, [r0, #0x74]
	mov r1, #0x134000
	str r1, [r0, #0x78]
	ldrh r1, [r0, #0xa0]
	cmp r1, #0
	bne _02161378
	str r2, [r0, #0x7c]
	mov r1, #0x80000
	str r1, [r0, #0x80]
	str r2, [r0, #0x84]
	b _02161388
_02161378:
	cmp r1, #1
	streq r2, [r0, #0x7c]
	streq r2, [r0, #0x80]
	streq r2, [r0, #0x84]
_02161388:
	mov r2, #0
	str r2, [r0, #0x88]
	mov r1, #0x1000
	str r1, [r0, #0x8c]
	str r2, [r0, #0x90]
	bx lr
	.align 2, 0
_021613A0: .word 0x000004FA
_021613A4: .word 0x00001555
	arm_func_end ovl09_2161314

	arm_func_start ovl09_21613A8
ovl09_21613A8: // 0x021613A8
	mov r2, #2
	ldr r1, _02161434 // =0x000004FA
	strh r2, [r0, #0xa2]
	strh r1, [r0, #0x50]
	mov ip, #0x1000
	str ip, [r0, #0x54]
	mov r3, #0x800000
	mov r2, #0
	ldr r1, _02161438 // =0x00001555
	str r3, [r0, #0x58]
	str r1, [r0, #0x5c]
	str ip, [r0, #0x60]
	str r2, [r0, #0x70]
	sub r1, r2, #0x26800
	str r1, [r0, #0x74]
	mov r1, #0x134000
	str r1, [r0, #0x78]
	ldrh r1, [r0, #0xa0]
	cmp r1, #0
	bne _0216140C
	str r2, [r0, #0x7c]
	mov r1, #0x80000
	str r1, [r0, #0x80]
	str r2, [r0, #0x84]
	b _0216141C
_0216140C:
	cmp r1, #1
	streq r2, [r0, #0x7c]
	streq r2, [r0, #0x80]
	streq r2, [r0, #0x84]
_0216141C:
	mov r2, #0
	str r2, [r0, #0x88]
	mov r1, #0x1000
	str r1, [r0, #0x8c]
	str r2, [r0, #0x90]
	bx lr
	.align 2, 0
_02161434: .word 0x000004FA
_02161438: .word 0x00001555
	arm_func_end ovl09_21613A8

	arm_func_start ovl09_216143C
ovl09_216143C: // 0x0216143C
	mov r2, #3
	ldr r1, _021614E0 // =0x000004FA
	strh r2, [r0, #0xa2]
	strh r1, [r0, #0x50]
	mov ip, #0x1000
	str ip, [r0, #0x54]
	mov r2, #0x1f4000
	mov r3, #0x800000
	ldr r1, _021614E4 // =0x00001555
	str r3, [r0, #0x58]
	str r1, [r0, #0x5c]
	str ip, [r0, #0x60]
	str r2, [r0, #0x70]
	sub r1, r2, #0x21c000
	str r1, [r0, #0x74]
	sub r1, r2, #0xd2000
	str r1, [r0, #0x78]
	ldrh r1, [r0, #0xa0]
	cmp r1, #0
	bne _021614A8
	ldr r2, _021614E8 // =0x00006666
	mov r1, #0x80000
	str r2, [r0, #0x7c]
	str r1, [r0, #0x80]
	mov r1, #0x40000
	str r1, [r0, #0x84]
	b _021614C8
_021614A8:
	cmp r1, #1
	bne _021614C8
	ldr r2, _021614E8 // =0x00006666
	mov r1, #0
	str r2, [r0, #0x7c]
	str r1, [r0, #0x80]
	mov r1, #0x40000
	str r1, [r0, #0x84]
_021614C8:
	mov r2, #0
	str r2, [r0, #0x88]
	mov r1, #0x1000
	str r1, [r0, #0x8c]
	str r2, [r0, #0x90]
	bx lr
	.align 2, 0
_021614E0: .word 0x000004FA
_021614E4: .word 0x00001555
_021614E8: .word 0x00006666
	arm_func_end ovl09_216143C

	arm_func_start ovl09_21614EC
ovl09_21614EC: // 0x021614EC
	mov r2, #4
	ldr r1, _02161594 // =0x000004FA
	strh r2, [r0, #0xa2]
	strh r1, [r0, #0x50]
	mov ip, #0x1000
	mov r1, #0x1f4000
	rsb r1, r1, #0
	str ip, [r0, #0x54]
	mov r3, #0x800000
	ldr r2, _02161598 // =0x00001555
	str r3, [r0, #0x58]
	str r2, [r0, #0x5c]
	str ip, [r0, #0x60]
	str r1, [r0, #0x70]
	add r2, r1, #0x1cc000
	ldr r1, _0216159C // =0x00122000
	str r2, [r0, #0x74]
	str r1, [r0, #0x78]
	ldrh r1, [r0, #0xa0]
	cmp r1, #0
	bne _0216155C
	ldr r2, _021615A0 // =0xFFFF999A
	mov r1, #0x80000
	str r2, [r0, #0x7c]
	str r1, [r0, #0x80]
	mov r1, #0x40000
	str r1, [r0, #0x84]
	b _0216157C
_0216155C:
	cmp r1, #1
	bne _0216157C
	ldr r2, _021615A0 // =0xFFFF999A
	mov r1, #0
	str r2, [r0, #0x7c]
	str r1, [r0, #0x80]
	mov r1, #0x40000
	str r1, [r0, #0x84]
_0216157C:
	mov r2, #0
	str r2, [r0, #0x88]
	mov r1, #0x1000
	str r1, [r0, #0x8c]
	str r2, [r0, #0x90]
	bx lr
	.align 2, 0
_02161594: .word 0x000004FA
_02161598: .word 0x00001555
_0216159C: .word 0x00122000
_021615A0: .word 0xFFFF999A
	arm_func_end ovl09_21614EC

	arm_func_start ovl09_21615A4
ovl09_21615A4: // 0x021615A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _02161680 // =exDrawFadeTask__word_21763A0
	bl ovl09_2160FA0
	ldr r1, _02161684 // =0x021763E8
	mov r2, #0
	ldr r0, _02161688 // =exDrawFadeTask__word_21762FC
	strh r2, [r1, #0x58]
	bl ovl09_2160FA0
	ldr r0, _0216168C // =exDrawFadeTask__word_21762E8
	mov r1, #1
	strh r1, [r0, #0xb4]
	cmp r4, #4
	addls pc, pc, r4, lsl #2
	b _02161644
_021615E0: // jump table
	b _02161644 // case 0
	b _021615F4 // case 1
	b _02161608 // case 2
	b _0216161C // case 3
	b _02161630 // case 4
_021615F4:
	ldr r0, _02161680 // =exDrawFadeTask__word_21763A0
	bl ovl09_2161314
	ldr r0, _02161688 // =exDrawFadeTask__word_21762FC
	bl ovl09_2161314
	b _02161654
_02161608:
	ldr r0, _02161680 // =exDrawFadeTask__word_21763A0
	bl ovl09_21613A8
	ldr r0, _02161688 // =exDrawFadeTask__word_21762FC
	bl ovl09_21613A8
	b _02161654
_0216161C:
	ldr r0, _02161680 // =exDrawFadeTask__word_21763A0
	bl ovl09_216143C
	ldr r0, _02161688 // =exDrawFadeTask__word_21762FC
	bl ovl09_216143C
	b _02161654
_02161630:
	ldr r0, _02161680 // =exDrawFadeTask__word_21763A0
	bl ovl09_21614EC
	ldr r0, _02161688 // =exDrawFadeTask__word_21762FC
	bl ovl09_21614EC
	b _02161654
_02161644:
	ldr r0, _02161680 // =exDrawFadeTask__word_21763A0
	bl ovl09_2161314
	ldr r0, _02161688 // =exDrawFadeTask__word_21762FC
	bl ovl09_2161314
_02161654:
	ldr r0, _02161690 // =exDrawFadeTask__word_21762E8
	bl ovl09_216109C
	mov r1, #0
	ldr r0, _0216168C // =exDrawFadeTask__word_21762E8
	sub r2, r1, #0x1000
	strh r1, [r0, #8]
	strh r1, [r0, #0xa]
	ldr r1, _02161694 // =0x00007FFF
	strh r2, [r0, #0xc]
	strh r1, [r0, #0xe]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161680: .word exDrawFadeTask__word_21763A0
_02161684: .word 0x021763E8
_02161688: .word exDrawFadeTask__word_21762FC
_0216168C: .word exDrawFadeTask__word_21762E8
_02161690: .word exDrawFadeTask__word_21762E8
_02161694: .word 0x00007FFF
	arm_func_end ovl09_21615A4

	arm_func_start ovl09_2161698
ovl09_2161698: // 0x02161698
	ldr r0, _021616A0 // =exDrawFadeTask__word_21763A0
	bx lr
	.align 2, 0
_021616A0: .word exDrawFadeTask__word_21763A0
	arm_func_end ovl09_2161698

	arm_func_start ovl09_21616A4
ovl09_21616A4: // 0x021616A4
	ldr r0, _021616AC // =exDrawFadeTask__word_21762FC
	bx lr
	.align 2, 0
_021616AC: .word exDrawFadeTask__word_21762FC
	arm_func_end ovl09_21616A4

	arm_func_start ovl09_21616B0
ovl09_21616B0: // 0x021616B0
	ldr r0, _021616B8 // =exDrawFadeTask__word_21762E8
	bx lr
	.align 2, 0
_021616B8: .word exDrawFadeTask__word_21762E8
	arm_func_end ovl09_21616B0

	arm_func_start ovl09_21616BC
ovl09_21616BC: // 0x021616BC
	stmdb sp!, {r4, lr}
	mov r1, #0
	mov r2, #0x80
	mov r4, r0
	bl MI_CpuFill8
	mov r1, #0
	strh r1, [r4, #0x74]
	strh r1, [r4, #0x68]
	strh r1, [r4, #0x6a]
	mov r0, #0x1000
	str r0, [r4, #0x6c]
	str r0, [r4, #0x70]
	str r1, [r4, #0x7c]
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_21616BC

	arm_func_start ovl09_21616F4
ovl09_21616F4: // 0x021616F4
	stmdb sp!, {r4, lr}
	ldrb r2, [r0, #0]
	mov r1, #0
	bic r4, r2, #3
	and r2, r4, #0xff
	bic r3, r2, #4
	and r2, r3, #0xff
	strb r4, [r0]
	bic r2, r2, #0xf0
	strb r2, [r0]
	ldrb r2, [r0, #1]
	bic r4, r2, #1
	and r2, r4, #0xff
	bic r3, r2, #2
	and r2, r3, #0xff
	bic lr, r2, #4
	and r2, lr, #0xff
	orr ip, r2, #8
	bic r3, ip, #0x10
	and r2, r3, #0xff
	bic r2, r2, #0xe0
	strb lr, [r0, #1]
	orr r2, r2, #0x40
	strb r2, [r0, #1]
	strh r1, [r0, #4]
	ldrb r1, [r0, #2]
	bic r1, r1, #0x20
	strb r1, [r0, #2]
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_21616F4

	arm_func_start ovl09_2161768
ovl09_2161768: // 0x02161768
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl09_21616BC
	add r0, r4, #0x80
	bl ovl09_21616F4
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2161768

	arm_func_start ovl09_2161780
ovl09_2161780: // 0x02161780
	ldrsh r1, [r0, #0x68]
	strh r1, [r0, #0xc]
	ldrsh r1, [r0, #0x6a]
	strh r1, [r0, #0xe]
	ldr r1, [r0, #0x6c]
	cmp r1, #0x2000
	movge r1, #0x2000
	strge r1, [r0, #0x6c]
	ldr r1, [r0, #0x70]
	cmp r1, #0x2000
	movge r1, #0x2000
	strge r1, [r0, #0x70]
	mov r1, #0x2000
	ldr r2, [r0, #0x6c]
	rsb r1, r1, #0
	cmp r2, r1
	strle r1, [r0, #0x6c]
	mov r1, #0x2000
	ldr r2, [r0, #0x70]
	rsb r1, r1, #0
	cmp r2, r1
	strle r1, [r0, #0x70]
	bx lr
	arm_func_end ovl09_2161780

	arm_func_start ovl09_21617DC
ovl09_21617DC: // 0x021617DC
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, _021618FC // =_mt_math_rand
	mov r5, r0
	ldr r3, [r2, #0]
	ldr r0, _02161900 // =0x00196225
	ldr r1, _02161904 // =0x3C6EF35F
	ldrb ip, [r5, #0x80]
	mla r4, r3, r0, r1
	mov r0, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r3, ip, lsl #0x18
	mov r1, r0, lsr #0x1f
	mov r3, r3, lsr #0x1d
	rsb r0, r1, r0, lsl #31
	and r3, r3, #0xff
	add r0, r1, r0, ror #31
	add r0, r3, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r4, [r2]
	mov r4, r0, lsl #0x10
	bl ovl09_216ADBC
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldrb r0, [r5, #0x80]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1c
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r2, _021618FC // =_mt_math_rand
	ldr r0, _02161900 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02161904 // =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldrsh r0, [r5, #0xc]
	ldr r2, _021618FC // =_mt_math_rand
	ldr r1, _02161904 // =0x3C6EF35F
	addne r0, r0, r4, asr #16
	subeq r0, r0, r4, asr #16
	strh r0, [r5, #0xc]
	ldr r0, _02161900 // =0x00196225
	ldr r3, [r2, #0]
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldrsh r0, [r5, #0xe]
	addne r0, r0, r4, asr #16
	subeq r0, r0, r4, asr #16
	strh r0, [r5, #0xe]
	ldrb r1, [r5, #0x80]
	mov r0, r1, lsl #0x18
	movs r0, r0, lsr #0x1c
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r0, #0xff
	and r0, r0, #0xff
	bic r1, r1, #0xf0
	mov r0, r0, lsl #0x1c
	orr r0, r1, r0, lsr #24
	strb r0, [r5, #0x80]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021618FC: .word _mt_math_rand
_02161900: .word 0x00196225
_02161904: .word 0x3C6EF35F
	arm_func_end ovl09_21617DC

	arm_func_start ovl09_2161908
ovl09_2161908: // 0x02161908
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrb r1, [r4, #0x81]
	mov r1, r1, lsl #0x1b
	movs r1, r1, lsr #0x1f
	beq _02161924
	bl ovl09_2161B44
_02161924:
	ldrb r0, [r4, #0x81]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	ldmneia sp!, {r4, pc}
	mov r1, #0
	mov r2, r1
	add r0, r4, #4
	bl AnimatorSprite__ProcessAnimation
	ldrb r0, [r4, #0x81]
	mov r1, r0, lsl #0x1d
	movs r1, r1, lsr #0x1f
	ldmeqia sp!, {r4, pc}
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl09_2161B94
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl09_2161B44
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2161908

	arm_func_start ovl09_216197C
ovl09_216197C: // 0x0216197C
	ldrh r1, [r0, #0x84]
	cmp r1, #0xa800
	movlo r1, #1
	strlob r1, [r0, #0x5a]
	ldrh r1, [r0, #0x84]
	cmp r1, #0xa800
	movhs r1, #0
	strhsb r1, [r0, #0x5a]
	bx lr
	arm_func_end ovl09_216197C

	arm_func_start ovl09_21619A0
ovl09_21619A0: // 0x021619A0
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldrb r0, [r4, #0x80]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r5, [r4, #0x78]
	cmp r5, #0
	beq _021619E0
	bl Camera3D__GetWork
	mov r1, r5
	add r0, r0, #0x7c
	mov r2, #0x1f
	bl RenderCore_ChangeBlendAlpha
	mov r0, #1
	str r0, [r4, #0x5c]
_021619E0:
	ldrb r0, [r4, #0x80]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1e
	bne _02161A7C
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _02161A48
	ldrsh r0, [r4, #0xe]
	add r0, r0, #0xc0
	strh r0, [r4, #0xe]
	ldrb r0, [r4, #0x82]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _02161A30
	ldrh r3, [r4, #0x74]
	ldr r1, [r4, #0x6c]
	ldr r2, [r4, #0x70]
	add r0, r4, #4
	bl AnimatorSprite__DrawFrameRotoZoom
	b _02161A38
_02161A30:
	add r0, r4, #4
	bl AnimatorSprite__DrawFrame
_02161A38:
	ldrsh r0, [r4, #0xe]
	sub r0, r0, #0xc0
	strh r0, [r4, #0xe]
	b _02161B08
_02161A48:
	ldrb r0, [r4, #0x82]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _02161A70
	ldrh r3, [r4, #0x74]
	ldr r1, [r4, #0x6c]
	ldr r2, [r4, #0x70]
	add r0, r4, #4
	bl AnimatorSprite__DrawFrameRotoZoom
	b _02161B08
_02161A70:
	add r0, r4, #4
	bl AnimatorSprite__DrawFrame
	b _02161B08
_02161A7C:
	cmp r0, #1
	bne _02161AC4
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _02161B08
	ldrb r0, [r4, #0x82]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _02161AB8
	ldrh r3, [r4, #0x74]
	ldr r1, [r4, #0x6c]
	ldr r2, [r4, #0x70]
	add r0, r4, #4
	bl AnimatorSprite__DrawFrameRotoZoom
	b _02161B08
_02161AB8:
	add r0, r4, #4
	bl AnimatorSprite__DrawFrame
	b _02161B08
_02161AC4:
	cmp r0, #2
	bne _02161B08
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02161B08
	ldrb r0, [r4, #0x82]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _02161B00
	ldrh r3, [r4, #0x74]
	ldr r1, [r4, #0x6c]
	ldr r2, [r4, #0x70]
	add r0, r4, #4
	bl AnimatorSprite__DrawFrameRotoZoom
	b _02161B08
_02161B00:
	add r0, r4, #4
	bl AnimatorSprite__DrawFrame
_02161B08:
	ldrsh r0, [r4, #0x68]
	strh r0, [r4, #0xc]
	ldrsh r0, [r4, #0x6a]
	strh r0, [r4, #0xe]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl09_21619A0

	arm_func_start ovl09_2161B1C
ovl09_2161B1C: // 0x02161B1C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl09_2161780
	mov r0, r4
	bl ovl09_21617DC
	mov r0, r4
	bl ovl09_216197C
	mov r0, r4
	bl ovl09_21619A0
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2161B1C

	arm_func_start ovl09_2161B44
ovl09_2161B44: // 0x02161B44
	ldrb r1, [r0, #0x81]
	bic r2, r1, #4
	and r1, r2, #0xff
	orr r1, r1, #2
	bic r2, r1, #8
	strb r1, [r0, #0x81]
	and r1, r2, #0xff
	bic r1, r1, #0x10
	strb r1, [r0, #0x81]
	bx lr
	arm_func_end ovl09_2161B44

	arm_func_start ovl09_2161B6C
ovl09_2161B6C: // 0x02161B6C
	ldrb r1, [r0, #0x80]
	bic r1, r1, #3
	orr r1, r1, #1
	strb r1, [r0, #0x80]
	bx lr
	arm_func_end ovl09_2161B6C

	arm_func_start ovl09_2161B80
ovl09_2161B80: // 0x02161B80
	ldrb r1, [r0, #0x80]
	bic r1, r1, #3
	orr r1, r1, #2
	strb r1, [r0, #0x80]
	bx lr
	arm_func_end ovl09_2161B80

	arm_func_start ovl09_2161B94
ovl09_2161B94: // 0x02161B94
	ldrh r2, [r0, #0x14]
	ldrh r1, [r0, #0x12]
	cmp r2, r1
	bne _02161BB8
	ldr r1, [r0, #0x38]
	ldr r0, [r0, #0x3c]
	cmp r1, r0
	movle r0, #1
	bxle lr
_02161BB8:
	mov r0, #0
	bx lr
	arm_func_end ovl09_2161B94

	arm_func_start ovl09_2161BC0
ovl09_2161BC0: // 0x02161BC0
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	mov r2, #0x370
	bl MI_CpuFill8
	add r0, r4, #4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r1, #0
	strh r1, [r4]
	add r0, r4, #0x300
	strh r1, [r0, #0x2e]
	strh r1, [r0, #0x30]
	strh r1, [r0, #0x32]
	str r1, [r4, #0x334]
	str r1, [r4, #0x338]
	str r1, [r4, #0x33c]
	mov r0, #0x1000
	str r0, [r4, #0x34c]
	str r0, [r4, #0x350]
	str r0, [r4, #0x354]
	str r1, [r4, #0x358]
	str r1, [r4, #0x35c]
	str r1, [r4, #0x360]
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2161BC0

	arm_func_start ovl09_2161C24
ovl09_2161C24: // 0x02161C24
	stmdb sp!, {r4, lr}
	ldrb r2, [r0, #0]
	mov r1, #0
	bic r3, r2, #3
	and r2, r3, #0xff
	bic r4, r2, #4
	and r2, r4, #0xff
	bic r3, r2, #8
	and r2, r3, #0xff
	strb r4, [r0]
	bic r2, r2, #0xf0
	strb r2, [r0]
	ldrb r2, [r0, #1]
	bic r4, r2, #1
	and r2, r4, #0xff
	bic r3, r2, #2
	and r2, r3, #0xff
	bic lr, r2, #4
	and r2, lr, #0xff
	orr ip, r2, #8
	bic r3, ip, #0x10
	and r2, r3, #0xff
	bic r2, r2, #0xe0
	strb lr, [r0, #1]
	orr r2, r2, #0x20
	strb r2, [r0, #1]
	ldrb r2, [r0, #2]
	bic r2, r2, #0x1c
	orr r2, r2, #0x1c
	strb r2, [r0, #2]
	strh r1, [r0, #4]
	ldrb r1, [r0, #2]
	bic r1, r1, #2
	strb r1, [r0, #2]
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2161C24

	arm_func_start ovl09_2161CB0
ovl09_2161CB0: // 0x02161CB0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x1c
	bl ovl09_2161BC0
	mov r0, r4
	bl ovl09_216ADF4
	add r0, r4, #0x38c
	bl ovl09_2161C24
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2161CB0

	arm_func_start ovl09_2161CD4
ovl09_2161CD4: // 0x02161CD4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x90
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0x2e]
	ldr r3, _02161DE0 // =FX_SinCosTable_
	add r0, sp, #0x24
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	add r0, r4, #0x300
	ldrh r1, [r0, #0x30]
	ldr r3, _02161DE0 // =FX_SinCosTable_
	add r0, sp, #0x48
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, r4, #0x300
	ldrh r1, [r0, #0x32]
	ldr r3, _02161DE0 // =FX_SinCosTable_
	add r0, sp, #0x6c
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotZ33_
	add r0, sp, #0x48
	add r1, sp, #0x24
	add r2, sp, #0
	bl MTX_Concat33
	add r0, sp, #0x6c
	add r1, sp, #0
	add r2, r4, #0x28
	bl MTX_Concat33
	ldr r0, [r4, #0x334]
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x338]
	str r0, [r4, #0x50]
	ldr r0, [r4, #0x33c]
	str r0, [r4, #0x54]
	ldr r0, [r4, #0x34c]
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x350]
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x354]
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x358]
	str r0, [r4, #0x58]
	ldr r0, [r4, #0x35c]
	str r0, [r4, #0x5c]
	ldr r0, [r4, #0x360]
	str r0, [r4, #0x60]
	add sp, sp, #0x90
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161DE0: .word FX_SinCosTable_
	arm_func_end ovl09_2161CD4

	arm_func_start ovl09_2161DE4
ovl09_2161DE4: // 0x02161DE4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrb r0, [r6, #0x38c]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02161E10
	add r0, r6, #0x38
	add r4, r6, #0x394
	add r5, r0, #0x400
	b _02161E20
_02161E10:
	bl ovl09_2161698
	mov r4, r0
	bl ovl09_21616A4
	mov r5, r0
_02161E20:
	ldrb r1, [r6, #2]
	mov r0, r1, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _02161ED8
	mov r0, r1, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _02161ED8
	mov r0, r1, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _02161ED8
	mov r0, r1, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _02161ED8
	ldrb r0, [r6, #1]
	mov r2, r0, lsl #0x1c
	movs r2, r2, lsr #0x1f
	bne _02161ED8
	mov r2, r0, lsl #0x1d
	movs r2, r2, lsr #0x1f
	bne _02161ED8
	mov r2, r0, lsl #0x1e
	movs r2, r2, lsr #0x1f
	bne _02161ED8
	mov r1, r1, lsl #0x18
	movs r1, r1, lsr #0x1f
	bne _02161ED8
	ldrb r1, [r6, #3]
	mov r1, r1, lsl #0x1f
	movs r1, r1, lsr #0x1f
	bne _02161ED8
	mov r1, r0, lsl #0x19
	movs r1, r1, lsr #0x1f
	bne _02161ED8
	mov r1, r0, lsl #0x1b
	movs r1, r1, lsr #0x1f
	bne _02161ED8
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _02161ED8
	ldrb r0, [r6, #4]
	mov r1, r0, lsl #0x1b
	movs r1, r1, lsr #0x1f
	bne _02161ED8
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	beq _02161F18
_02161ED8:
	ldr r1, [r6, #0x354]
	ldr r0, _02161FA8 // =0x00024C04
	cmp r1, r0
	ble _02161EF8
	ldrb r0, [r6, #0x38c]
	bic r0, r0, #3
	orr r0, r0, #2
	strb r0, [r6, #0x38c]
_02161EF8:
	ldr r1, [r6, #0x354]
	ldr r0, _02161FA8 // =0x00024C04
	cmp r1, r0
	bgt _02161F18
	ldrb r0, [r6, #0x38c]
	bic r0, r0, #3
	orr r0, r0, #1
	strb r0, [r6, #0x38c]
_02161F18:
	ldrb r0, [r6, #0x38c]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1e
	bne _02161F4C
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _02161F40
	mov r0, r4
	bl ovl09_21610F0
	ldmia sp!, {r4, r5, r6, pc}
_02161F40:
	mov r0, r5
	bl ovl09_21610F0
	ldmia sp!, {r4, r5, r6, pc}
_02161F4C:
	cmp r0, #1
	bne _02161F7C
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02161F6C
	mov r0, r5
	bl ovl09_21610F0
	ldmia sp!, {r4, r5, r6, pc}
_02161F6C:
	ldrb r0, [r6, #0x38c]
	orr r0, r0, #4
	strb r0, [r6, #0x38c]
	ldmia sp!, {r4, r5, r6, pc}
_02161F7C:
	cmp r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldreqb r0, [r6, #0x38c]
	orreq r0, r0, #4
	streqb r0, [r6, #0x38c]
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r4
	bl ovl09_21610F0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02161FA8: .word 0x00024C04
	arm_func_end ovl09_2161DE4

	arm_func_start ovl09_2161FAC
ovl09_2161FAC: // 0x02161FAC
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, _02162158 // =_mt_math_rand
	mov r5, r0
	ldr r3, [r2, #0]
	ldr r0, _0216215C // =0x00196225
	ldr r1, _02162160 // =0x3C6EF35F
	ldrb ip, [r5, #0x38c]
	mla r4, r3, r0, r1
	mov r0, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	mov r3, ip, lsl #0x18
	add r0, r1, r0, ror #31
	add r0, r0, r3, lsr #28
	str r4, [r2]
	mov r4, r0, lsl #7
	bl ovl09_216ADBC
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	bl ovl09_2164260
	ldrb r0, [r0, #0]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1c
	beq _02162080
	bl ovl09_2164260
	bl ovl09_21642BC
	bl ovl09_2164260
	ldrb r0, [r0, #0]
	ldrb r1, [r5, #0x38c]
	ldr r2, _02162158 // =_mt_math_rand
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1c
	bic r1, r1, #0xf0
	mov r0, r0, lsl #0x1c
	orr r4, r1, r0, lsr #24
	strb r4, [r5, #0x38c]
	ldr r3, [r2, #0]
	ldr r0, _0216215C // =0x00196225
	ldr r1, _02162160 // =0x3C6EF35F
	and ip, r4, #0xff
	mla r4, r3, r0, r1
	mov r0, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	mov r3, ip, lsl #0x18
	add r0, r1, r0, ror #31
	add r0, r0, r3, lsr #28
	str r4, [r2]
	mov r4, r0, lsl #7
_02162080:
	ldrb r0, [r5, #0x38c]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1c
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r2, _02162158 // =_mt_math_rand
	ldr r0, _0216215C // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02162160 // =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldr r0, [r5, #0x68]
	ldr r2, _02162158 // =_mt_math_rand
	addne r0, r0, r4
	subeq r0, r0, r4
	str r0, [r5, #0x68]
	ldr r0, _0216215C // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02162160 // =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldr r0, [r5, #0x6c]
	ldr r2, _02162158 // =_mt_math_rand
	addne r0, r0, r4
	subeq r0, r0, r4
	str r0, [r5, #0x6c]
	ldr r0, _0216215C // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02162160 // =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldr r0, [r5, #0x70]
	addne r0, r0, r4
	strne r0, [r5, #0x70]
	subeq r0, r0, r4
	streq r0, [r5, #0x70]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02162158: .word _mt_math_rand
_0216215C: .word 0x00196225
_02162160: .word 0x3C6EF35F
	arm_func_end ovl09_2161FAC

	arm_func_start ovl09_2162164
ovl09_2162164: // 0x02162164
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldrb r0, [r4, #1]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _021621AC
	add r6, r4, #0x164
	mov r5, #0
_02162184:
	mov r0, r6
	bl AnimatePalette
	mov r0, r6
	bl DrawAnimatedPalette
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	cmp r5, #0xf
	add r6, r6, #0x20
	blt _02162184
_021621AC:
	ldrb r0, [r4, #0x38d]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _021621CC
	mov r1, #0
	add r0, r4, #0x38c
	str r1, [r4, #0x344]
	bl ovl09_2164238
_021621CC:
	ldrb r0, [r4, #0x38d]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r4, #0x20
	bl AnimatorMDL__ProcessAnimation
	ldrb r0, [r4, #0x38d]
	mov r1, r0, lsl #0x1d
	movs r1, r1, lsr #0x1f
	beq _02162228
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r4
	bl ovl09_21623F8
	cmp r0, #0
	beq _02162228
	add r0, r4, #0x38c
	bl ovl09_2164238
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02162228:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl09_2162164

	arm_func_start ovl09_2162230
ovl09_2162230: // 0x02162230
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x40
	mov r5, r0
	ldrb r1, [r5, #0x38c]
	mov r2, r1, lsl #0x1d
	movs r2, r2, lsr #0x1f
	bicne r0, r1, #4
	addne sp, sp, #0x40
	strneb r0, [r5, #0x38c]
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r2, _02162398 // =0x04000060
	ldrh r1, [r2, #0]
	bic r1, r1, #0x3000
	orr r1, r1, #8
	strh r1, [r2]
	ldrb r1, [r5, #3]
	mov r1, r1, lsl #0x1c
	movs r1, r1, lsr #0x1f
	beq _021622A4
	bl ovl09_21623F8
	cmp r0, #0
	beq _02162298
	bl Camera3D__UseEngineA
	add r0, r5, #0x20
	bl AnimatorMDL__Draw
	b _02162378
_02162298:
	add r0, r5, #0x20
	bl AnimatorMDL__Draw
	b _02162378
_021622A4:
	ldrb r0, [r5, #1]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _02162370
	bl ovl09_215441C
	mov r4, r0
	add r0, r5, #0x20
	bl AnimatorMDL__Draw
	mov r3, #2
	add r1, sp, #0xc
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #0xc]
	bl NNS_G3dGeBufferOP_N
	mov r2, #0x1e
	str r2, [sp, #8]
	add r1, sp, #8
	mov r0, #0x14
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, sp, #0x10
	mov r1, #0
	bl NNS_G3dGetCurrentMtx
	ldr r0, [sp, #0x34]
	mov r2, #2
	str r0, [r4, #0x380]
	ldr r1, [sp, #0x38]
	mov r0, #0x10
	str r1, [r4, #0x384]
	ldr r3, [sp, #0x3c]
	add r1, sp, #4
	str r3, [r4, #0x388]
	str r2, [sp, #4]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #0x1d
	str r0, [sp]
	mov r0, #0x14
	add r1, sp, #0
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, sp, #0x10
	mov r1, #0
	bl NNS_G3dGetCurrentMtx
	ldr r1, [sp, #0x34]
	mov r0, #0x3c000
	str r1, [r4, #0x35c]
	ldr r1, [sp, #0x38]
	str r1, [r4, #0x360]
	str r0, [r4, #0x364]
	b _02162378
_02162370:
	add r0, r5, #0x20
	bl AnimatorMDL__Draw
_02162378:
	ldr r0, [r5, #0x350]
	str r0, [r5, #0x68]
	ldr r0, [r5, #0x354]
	str r0, [r5, #0x6c]
	ldr r0, [r5, #0x358]
	str r0, [r5, #0x70]
	add sp, sp, #0x40
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02162398: .word 0x04000060
	arm_func_end ovl09_2162230

	arm_func_start ovl09_216239C
ovl09_216239C: // 0x0216239C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl09_21616B0
	ldrb r1, [r4, #0x38e]
	mov r1, r1, lsl #0x1b
	mov r1, r1, lsr #0x1d
	strb r1, [r0, #0x10]
	bl ovl09_21616B0
	bl ovl09_21611C0
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_216239C

	arm_func_start ovl09_21623C4
ovl09_21623C4: // 0x021623C4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x1c
	bl ovl09_2161CD4
	mov r0, r4
	bl ovl09_216239C
	mov r0, r4
	bl ovl09_2161FAC
	mov r0, r4
	bl ovl09_2161DE4
	mov r0, r4
	bl ovl09_2162230
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_21623C4

	arm_func_start ovl09_21623F8
ovl09_21623F8: // 0x021623F8
	add r1, r0, #0x300
	ldrh r1, [r1, #0x48]
	add r0, r0, r1, lsl #1
	add r0, r0, #0x100
	ldrh r0, [r0, #0x2c]
	tst r0, #0x8000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end ovl09_21623F8

	arm_func_start ovl09_216241C
ovl09_216241C: // 0x0216241C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r1, #0
	mov r2, #0x1c
	ldrh r5, [r4, #0x20]
	bl MI_CpuFill8
	add r0, r4, #0x1c
	mov r1, #0
	mov r2, #0x250
	bl MI_CpuFill8
	add r0, r4, #0x26c
	mov r1, #0
	mov r2, #6
	bl MI_CpuFill8
	add r0, r4, #0x274
	mov r1, #0
	mov r2, #0xa4
	bl MI_CpuFill8
	add r0, r4, #0x318
	mov r1, #0
	mov r2, #0xa4
	bl MI_CpuFill8
	strh r5, [r4, #0x20]
	add r0, r4, #0x200
	strh r6, [r0, #0x64]
	ldrh r0, [r0, #0x64]
	cmp r0, #1
	beq _021624A8
	cmp r0, #2
	beq _021624B8
	cmp r0, #3
	beq _021624C8
	b _021624D4
_021624A8:
	mov r0, r4
	mov r1, r7
	bl ovl09_2162E8C
	b _021624D4
_021624B8:
	mov r0, r4
	mov r1, r7
	bl ovl09_2162AB4
	b _021624D4
_021624C8:
	mov r0, r4
	mov r1, r7
	bl ovl09_21624F4
_021624D4:
	ldrb r0, [r4, #0x26d]
	bic r0, r0, #0xe0
	orr r0, r0, #0x80
	strb r0, [r4, #0x26d]
	ldrb r0, [r4, #0x26c]
	bic r0, r0, #8
	strb r0, [r4, #0x26c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ovl09_216241C

	arm_func_start ovl09_21624F4
ovl09_21624F4: // 0x021624F4
	stmdb sp!, {r4, r5, r6, lr}
	add ip, r0, #0x1c
	mov r2, #0x2000
	str r2, [ip, #0x23c]
	ldr r5, _0216271C // =0x00007B39
	str r2, [ip, #0x240]
	mov r3, #0
_02162510:
	add r2, r3, #1
	add r4, ip, r3, lsl #1
	mov r3, r2, lsl #0x10
	add r2, r4, #0x100
	mov r3, r3, lsr #0x10
	strh r5, [r2, #0x70]
	cmp r3, #0x1e
	blo _02162510
	mov r5, #0
	mov r4, r5
_02162538:
	add r2, r5, #1
	mov r2, r2, lsl #0x10
	add r3, ip, r5, lsl #2
	mov r5, r2, lsr #0x10
	str r4, [r3, #0x1ac]
	cmp r5, #0x1e
	blo _02162538
	str r4, [ip, #0x24c]
	ldr r2, [r1, #0]
	ldr r3, _02162720 // =FX_SinCosTable_
	str r2, [ip, #0x224]
	ldr r2, [r1, #4]
	mov lr, #2
	str r2, [ip, #0x228]
	ldr r2, [r1, #8]
	str r2, [ip, #0x22c]
	str r4, [ip]
	ldrh r2, [ip, #4]
	add r2, r2, #0x4000
	strh r2, [ip, #4]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x23c]
	ldr r2, [r1, #0]
	mov r5, r5, asr #4
	mov r5, r5, lsl #1
	add r5, r5, #1
	mov r5, r5, lsl #1
	ldrsh r5, [r3, r5]
	smull r6, r4, r5, r4
	adds r5, r6, #0x800
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r2, r2, r5
	str r2, [ip, #8]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x240]
	ldr r2, [r1, #4]
	mov r5, r5, asr #4
	mov r5, r5, lsl #2
	ldrsh r5, [r3, r5]
	smull r6, r4, r5, r4
	adds r5, r6, #0x800
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r2, r2, r5
	str r2, [ip, #0xc]
	ldr r2, [r1, #8]
	str r2, [ip, #0x10]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x23c]
	ldr r2, [r1, #0]
	mov r5, r5, asr #4
	mov r5, r5, lsl #1
	add r5, r5, #1
	mov r5, r5, lsl #1
	ldrsh r5, [r3, r5]
	smull r6, r4, r5, r4
	adds r5, r6, #0x800
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r2, r2, r5
	str r2, [ip, #0x14]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x240]
	ldr r2, [r1, #4]
	mov r5, r5, asr #4
	mov r5, r5, lsl #2
	ldrsh r3, [r3, r5]
	smull r5, r4, r3, r4
	adds r5, r5, #0x800
	adc r3, r4, #0
	mov r4, r5, lsr #0xc
	orr r4, r4, r3, lsl #20
	add r2, r2, r4
	str r2, [ip, #0x18]
	ldr r2, [r1, #8]
	str r2, [ip, #0x1c]
	ldr r3, [ip, #8]
	ldr r2, [r1, #0]
	sub r2, r3, r2
	str r2, [ip, #0x230]
	ldr r3, [ip, #0xc]
	ldr r2, [r1, #4]
	sub r2, r3, r2
	str r2, [ip, #0x234]
	ldr r2, [ip, #0x10]
	ldr r1, [r1, #8]
	sub r1, r2, r1
	str r1, [ip, #0x238]
	mov r1, #0xc
_021626AC:
	mla r4, lr, r1, ip
	ldr r3, [r4, #-0x10]
	add r2, lr, #1
	str r3, [r4, #8]
	ldr r3, [r4, #-0xc]
	mov r2, r2, lsl #0x10
	str r3, [r4, #0xc]
	ldr r3, [r4, #-8]
	mov lr, r2, lsr #0x10
	str r3, [r4, #0x10]
	cmp lr, #0x1e
	blo _021626AC
	mov r1, #1
	strb r1, [r0]
	ldrb r3, [r0, #3]
	mov r2, #0x2000
	mov r1, #0
	orr r3, r3, #2
	strb r3, [r0, #3]
	str r2, [r0, #0xc]
	str r2, [r0, #0x10]
	str r1, [r0, #0x14]
	add r1, r0, #0x240
	str r1, [r0, #0x18]
	ldrb r1, [r0, #0x26c]
	bic r1, r1, #3
	strb r1, [r0, #0x26c]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216271C: .word 0x00007B39
_02162720: .word FX_SinCosTable_
	arm_func_end ovl09_21624F4

	arm_func_start ovl09_2162724
ovl09_2162724: // 0x02162724
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r1
	cmp r2, #0
	add r4, r0, #0x1c
	beq _0216274C
	cmp r2, #1
	beq _02162754
	cmp r2, #2
	moveq r5, #0x1800
	b _02162758
_0216274C:
	mov r5, #0x1800
	b _02162758
_02162754:
	mov r5, #0x3000
_02162758:
	ldr r1, [r6, #0]
	mov r0, #0x1d
	str r1, [r4, #0x224]
	ldr r1, [r6, #4]
	str r1, [r4, #0x228]
	ldr r1, [r6, #8]
	str r1, [r4, #0x22c]
	mov r1, #0xc
_02162778:
	mla r7, r0, r1, r4
	ldr r2, [r7, #-0x10]
	add r3, r4, r0, lsl #2
	str r2, [r7, #8]
	ldr r2, [r7, #-0xc]
	sub r0, r0, #1
	str r2, [r7, #0xc]
	ldr r2, [r7, #-8]
	mov r0, r0, lsl #0x10
	str r2, [r7, #0x10]
	ldr r2, [r3, #0x1a4]
	mov r0, r0, lsr #0x10
	cmp r2, #1
	subgt r2, r2, #2
	strgt r2, [r3, #0x1ac]
	cmp r0, #0xc
	bhs _02162778
	ldr r0, [r4, #0x68]
	ldr r3, _02162AB0 // =FX_SinCosTable_
	str r0, [r4, #0x80]
	ldr r0, [r4, #0x6c]
	mov r7, #0x1f
	str r0, [r4, #0x84]
	ldr r1, [r4, #0x70]
	mov r0, r5
	str r1, [r4, #0x88]
	ldr r2, [r4, #0x1cc]
	mov r1, #0x2000
	str r2, [r4, #0x1d4]
	ldr r2, [r4, #0x74]
	str r2, [r4, #0x8c]
	ldr r2, [r4, #0x78]
	str r2, [r4, #0x90]
	ldr r2, [r4, #0x7c]
	str r2, [r4, #0x94]
	ldr r2, [r4, #0x1d0]
	str r2, [r4, #0x1d8]
	ldrh r2, [r4, #4]
	add r2, r2, #0x4000
	strh r2, [r4, #4]
	ldrh ip, [r4, #4]
	ldr r8, [r4, #0x23c]
	ldr r2, [r6, #0]
	mov ip, ip, asr #4
	mov ip, ip, lsl #1
	add ip, ip, #1
	mov ip, ip, lsl #1
	ldrsh ip, [r3, ip]
	smull lr, r8, ip, r8
	adds ip, lr, #0x800
	adc r8, r8, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r8, lsl #20
	add r2, r2, ip
	str r2, [r4, #0x68]
	ldrh lr, [r4, #4]
	ldr ip, [r4, #0x240]
	ldr r2, [r6, #4]
	mov lr, lr, asr #4
	mov lr, lr, lsl #2
	ldrsh lr, [r3, lr]
	smull r8, ip, lr, ip
	adds lr, r8, #0x800
	adc r8, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r8, lsl #20
	add r2, r2, ip
	str r2, [r4, #0x6c]
	ldr r2, [r6, #8]
	str r2, [r4, #0x70]
	str r7, [r4, #0x1cc]
	ldrh lr, [r4, #4]
	ldr ip, [r4, #0x23c]
	ldr r2, [r6, #0]
	mov lr, lr, asr #4
	mov lr, lr, lsl #1
	add lr, lr, #1
	mov lr, lr, lsl #1
	ldrsh lr, [r3, lr]
	smull r7, ip, lr, ip
	adds lr, r7, #0x800
	adc r7, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r7, lsl #20
	sub r2, r2, ip
	str r2, [r4, #0x74]
	ldrh lr, [r4, #4]
	ldr ip, [r4, #0x240]
	ldr r2, [r6, #4]
	mov lr, lr, asr #4
	mov lr, lr, lsl #2
	ldrsh r3, [r3, lr]
	smull lr, ip, r3, ip
	adds lr, lr, #0x800
	adc r3, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r3, lsl #20
	sub r2, r2, ip
	str r2, [r4, #0x78]
	ldr r2, [r6, #8]
	str r2, [r4, #0x7c]
	ldr r2, [r4, #0x1cc]
	str r2, [r4, #0x1d0]
	bl FX_Div
	ldr r1, [r6, #0]
	mov r2, #0x1f
	add r0, r1, r0
	str r0, [r4, #8]
	ldr r1, [r6, #4]
	mov r0, r5
	add r1, r1, r5
	str r1, [r4, #0xc]
	ldr r3, [r6, #8]
	mov r1, #0x2000
	str r3, [r4, #0x10]
	str r2, [r4, #0x1ac]
	bl FX_Div
	ldr r1, [r6, #0]
	mov r2, #0x1f
	sub r0, r1, r0
	str r0, [r4, #0x14]
	ldr r1, [r6, #4]
	mov r0, r5
	add r1, r1, r5
	str r1, [r4, #0x18]
	ldr r3, [r6, #8]
	mov r1, #0x2000
	str r3, [r4, #0x1c]
	str r2, [r4, #0x1b0]
	ldr r2, [r6, #0]
	add r2, r2, r5
	str r2, [r4, #0x20]
	bl FX_Div
	ldr r2, [r6, #4]
	mov r1, #0x1f
	add r0, r2, r0
	str r0, [r4, #0x24]
	ldr r2, [r6, #8]
	mov r0, r5
	str r2, [r4, #0x28]
	str r1, [r4, #0x1b4]
	ldr r2, [r6, #0]
	mov r1, #0x2000
	sub r2, r2, r5
	str r2, [r4, #0x2c]
	bl FX_Div
	ldr r2, [r6, #4]
	mov r1, #0x1f
	add r0, r2, r0
	str r0, [r4, #0x30]
	ldr r2, [r6, #8]
	mov r0, r5
	str r2, [r4, #0x34]
	str r1, [r4, #0x1b8]
	ldr r2, [r6, #0]
	mov r1, #0x2000
	add r2, r2, r5
	str r2, [r4, #0x38]
	bl FX_Div
	ldr r2, [r6, #4]
	mov r1, #0x1f
	sub r0, r2, r0
	str r0, [r4, #0x3c]
	ldr r2, [r6, #8]
	mov r0, r5
	str r2, [r4, #0x40]
	str r1, [r4, #0x1bc]
	ldr r2, [r6, #0]
	mov r1, #0x2000
	sub r2, r2, r5
	str r2, [r4, #0x44]
	bl FX_Div
	ldr r2, [r6, #4]
	mov r1, #0x1f
	sub r0, r2, r0
	str r0, [r4, #0x48]
	ldr r2, [r6, #8]
	mov r0, r5
	str r2, [r4, #0x4c]
	str r1, [r4, #0x1c0]
	mov r1, #0x2000
	bl FX_Div
	ldr r1, [r6, #0]
	add r0, r1, r0
	str r0, [r4, #0x50]
	ldr r0, [r6, #4]
	sub r0, r0, r5
	str r0, [r4, #0x54]
	ldr r0, [r6, #8]
	mov r1, #0x1f
	str r0, [r4, #0x58]
	mov r0, r5
	str r1, [r4, #0x1c4]
	mov r1, #0x2000
	bl FX_Div
	ldr r2, [r6, #0]
	mov r1, #0x1f
	sub r0, r2, r0
	str r0, [r4, #0x5c]
	ldr r0, [r6, #4]
	sub r0, r0, r5
	str r0, [r4, #0x60]
	ldr r0, [r6, #8]
	str r0, [r4, #0x64]
	str r1, [r4, #0x1c8]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02162AB0: .word FX_SinCosTable_
	arm_func_end ovl09_2162724

	arm_func_start ovl09_2162AB4
ovl09_2162AB4: // 0x02162AB4
	stmdb sp!, {r4, r5, r6, lr}
	add ip, r0, #0x1c
	mov r2, #0x8000
	str r2, [ip, #0x23c]
	ldr r6, _02162CC0 // =0x0000023F
	str r2, [ip, #0x240]
	mov lr, #0
	mov r5, #1
_02162AD4:
	add r2, ip, lr, lsl #1
	add r3, lr, #1
	add r2, r2, #0x100
	mov r3, r3, lsl #0x10
	add r4, ip, lr, lsl #2
	strh r6, [r2, #0x70]
	mov lr, r3, lsr #0x10
	str r5, [r4, #0x1ac]
	cmp lr, #0x1e
	blo _02162AD4
	mov r4, #0
	str r4, [ip, #0x24c]
	ldr r2, [r1, #0]
	ldr r3, _02162CC4 // =FX_SinCosTable_
	str r2, [ip, #0x224]
	ldr r2, [r1, #4]
	mov lr, #2
	str r2, [ip, #0x228]
	ldr r2, [r1, #8]
	str r2, [ip, #0x22c]
	str r4, [ip]
	ldrh r2, [ip, #4]
	add r2, r2, #0x4000
	strh r2, [ip, #4]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x23c]
	ldr r2, [r1, #0]
	mov r5, r5, asr #4
	mov r5, r5, lsl #1
	add r5, r5, #1
	mov r5, r5, lsl #1
	ldrsh r5, [r3, r5]
	smull r6, r4, r5, r4
	adds r5, r6, #0x800
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r2, r2, r5
	str r2, [ip, #8]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x240]
	ldr r2, [r1, #4]
	mov r5, r5, asr #4
	mov r5, r5, lsl #2
	ldrsh r5, [r3, r5]
	smull r6, r4, r5, r4
	adds r5, r6, #0x800
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r2, r2, r5
	str r2, [ip, #0xc]
	ldr r2, [r1, #8]
	str r2, [ip, #0x10]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x23c]
	ldr r2, [r1, #0]
	mov r5, r5, asr #4
	mov r5, r5, lsl #1
	add r5, r5, #1
	mov r5, r5, lsl #1
	ldrsh r5, [r3, r5]
	smull r6, r4, r5, r4
	adds r5, r6, #0x800
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r2, r2, r5
	str r2, [ip, #0x14]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x240]
	ldr r2, [r1, #4]
	mov r5, r5, asr #4
	mov r5, r5, lsl #2
	ldrsh r3, [r3, r5]
	smull r5, r4, r3, r4
	adds r5, r5, #0x800
	adc r3, r4, #0
	mov r4, r5, lsr #0xc
	orr r4, r4, r3, lsl #20
	add r2, r2, r4
	str r2, [ip, #0x18]
	ldr r2, [r1, #8]
	str r2, [ip, #0x1c]
	ldr r3, [ip, #8]
	ldr r2, [r1, #0]
	sub r2, r3, r2
	str r2, [ip, #0x230]
	ldr r3, [ip, #0xc]
	ldr r2, [r1, #4]
	sub r2, r3, r2
	str r2, [ip, #0x234]
	ldr r2, [ip, #0x10]
	ldr r1, [r1, #8]
	sub r1, r2, r1
	str r1, [ip, #0x238]
	mov r1, #0xc
_02162C58:
	mla r4, lr, r1, ip
	ldr r3, [r4, #-0x10]
	add r2, lr, #1
	str r3, [r4, #8]
	ldr r3, [r4, #-0xc]
	mov r2, r2, lsl #0x10
	str r3, [r4, #0xc]
	ldr r3, [r4, #-8]
	mov lr, r2, lsr #0x10
	str r3, [r4, #0x10]
	cmp lr, #0x1e
	blo _02162C58
	mov r3, #0
	strb r3, [r0]
	ldrb r2, [r0, #5]
	add r1, r0, #0x240
	orr r2, r2, #2
	strb r2, [r0, #5]
	str r3, [r0, #0xc]
	str r3, [r0, #0x10]
	str r3, [r0, #0x14]
	str r1, [r0, #0x18]
	ldrb r1, [r0, #0x26c]
	bic r1, r1, #3
	strb r1, [r0, #0x26c]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02162CC0: .word 0x0000023F
_02162CC4: .word FX_SinCosTable_
	arm_func_end ovl09_2162AB4

	arm_func_start ovl09_2162CC8
ovl09_2162CC8: // 0x02162CC8
	stmdb sp!, {r4, lr}
	ldr r2, [r1, #0]
	add r3, r0, #0x1c
	str r2, [r3, #0x224]
	ldr r0, [r1, #4]
	mov lr, #0x1d
	str r0, [r3, #0x228]
	ldr r0, [r1, #8]
	mov r2, #0xc
	str r0, [r3, #0x22c]
_02162CF0:
	mla ip, lr, r2, r3
	ldr r0, [ip, #-0x10]
	add r4, r3, lr, lsl #2
	str r0, [ip, #8]
	ldr r0, [ip, #-0xc]
	str r0, [ip, #0xc]
	ldr r0, [ip, #-8]
	str r0, [ip, #0x10]
	ldr r0, [r4, #0x1a4]
	cmp r0, #1
	subgt r0, r0, #2
	strgt r0, [r4, #0x1ac]
	sub r0, lr, #1
	mov r0, r0, lsl #0x10
	mov lr, r0, lsr #0x10
	cmp lr, #4
	bhs _02162CF0
	ldr r2, [r3, #8]
	mov r0, #0x1f
	str r2, [r3, #0x20]
	ldr r4, [r3, #0xc]
	ldr r2, _02162E88 // =FX_SinCosTable_
	str r4, [r3, #0x24]
	ldr r4, [r3, #0x10]
	str r4, [r3, #0x28]
	ldr r4, [r3, #0x1ac]
	str r4, [r3, #0x1b4]
	ldr r4, [r3, #0x14]
	str r4, [r3, #0x2c]
	ldr r4, [r3, #0x18]
	str r4, [r3, #0x30]
	ldr r4, [r3, #0x1c]
	str r4, [r3, #0x34]
	ldr r4, [r3, #0x1b0]
	str r4, [r3, #0x1b8]
	str r0, [r3, #0x1ac]
	ldrh r0, [r3, #4]
	add r0, r0, #0x4000
	strh r0, [r3, #4]
	ldrh ip, [r3, #4]
	ldr r4, [r3, #0x23c]
	ldr r0, [r1, #0]
	mov ip, ip, asr #4
	mov ip, ip, lsl #1
	add ip, ip, #1
	mov ip, ip, lsl #1
	ldrsh ip, [r2, ip]
	smull lr, r4, ip, r4
	adds ip, lr, #0x800
	adc r4, r4, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r4, lsl #20
	add r0, r0, ip
	str r0, [r3, #8]
	ldrh r4, [r3, #4]
	ldr r0, [r3, #0x240]
	ldr lr, [r1, #4]
	mov r4, r4, asr #4
	mov r4, r4, lsl #2
	ldrsh r4, [r2, r4]
	smull ip, r0, r4, r0
	adds r4, ip, #0x800
	adc r0, r0, #0
	mov r4, r4, lsr #0xc
	orr r4, r4, r0, lsl #20
	add r0, lr, r4
	str r0, [r3, #0xc]
	ldr r0, [r1, #8]
	str r0, [r3, #0x10]
	ldrh lr, [r3, #4]
	ldr ip, [r3, #0x23c]
	ldr r0, [r1, #0]
	mov lr, lr, asr #4
	mov lr, lr, lsl #1
	add lr, lr, #1
	mov lr, lr, lsl #1
	ldrsh lr, [r2, lr]
	smull r4, ip, lr, ip
	adds lr, r4, #0x800
	adc r4, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r4, lsl #20
	sub r0, r0, ip
	str r0, [r3, #0x14]
	ldrh ip, [r3, #4]
	ldr r0, [r3, #0x240]
	ldr lr, [r1, #4]
	mov ip, ip, asr #4
	mov ip, ip, lsl #2
	ldrsh r2, [r2, ip]
	smull ip, r0, r2, r0
	adds r2, ip, #0x800
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	sub r0, lr, r2
	str r0, [r3, #0x18]
	ldr r0, [r1, #8]
	str r0, [r3, #0x1c]
	ldr r0, [r3, #0x1ac]
	str r0, [r3, #0x1b0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162E88: .word FX_SinCosTable_
	arm_func_end ovl09_2162CC8

	arm_func_start ovl09_2162E8C
ovl09_2162E8C: // 0x02162E8C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #0x2800
	add r4, r6, #0x1c
	str r0, [r4, #0x23c]
	sub r0, r0, #0x5800
	mov lr, #0
	ldr ip, _02162FD8 // =0x000003FF
	mov r5, r1
	str r0, [r4, #0x240]
	mov r3, lr
_02162EB8:
	add r0, r4, lr, lsl #1
	add r1, lr, #1
	add r0, r0, #0x100
	mov r1, r1, lsl #0x10
	add r2, r4, lr, lsl #2
	strh ip, [r0, #0x70]
	mov lr, r1, lsr #0x10
	str r3, [r2, #0x1ac]
	cmp lr, #0x1e
	blo _02162EB8
	mov r0, #1
	str r0, [r4, #0x24c]
	ldr r0, [r5, #0]
	mov r1, #0x2000
	str r0, [r4, #0x224]
	ldr r0, [r5, #4]
	str r0, [r4, #0x228]
	ldr r0, [r5, #8]
	str r0, [r4, #0x22c]
	ldr r0, [r4, #0x23c]
	bl FX_Div
	ldr r2, [r5, #0]
	mov r1, #0x2000
	sub r0, r2, r0
	str r0, [r4, #8]
	ldr r2, [r5, #4]
	ldr r0, [r4, #0x240]
	add r0, r2, r0
	str r0, [r4, #0xc]
	ldr r0, [r5, #8]
	str r0, [r4, #0x10]
	ldr r0, [r4, #0x23c]
	bl FX_Div
	ldr r2, [r5, #0]
	mov r1, #2
	add r0, r2, r0
	str r0, [r4, #0x14]
	ldr r2, [r5, #4]
	ldr r0, [r4, #0x240]
	add r0, r2, r0
	str r0, [r4, #0x18]
	ldr r0, [r5, #8]
	str r0, [r4, #0x1c]
	mov r0, #0xc
_02162F68:
	mla r3, r1, r0, r4
	ldr r2, [r3, #-0x10]
	add r1, r1, #1
	str r2, [r3, #8]
	ldr r2, [r3, #-0xc]
	mov r1, r1, lsl #0x10
	str r2, [r3, #0xc]
	ldr r2, [r3, #-8]
	mov r1, r1, lsr #0x10
	str r2, [r3, #0x10]
	cmp r1, #0x1e
	blo _02162F68
	mov r0, #0
	strb r0, [r6]
	ldrb r2, [r6, #5]
	mov r1, #0x1000
	add r0, r6, #0x240
	orr r2, r2, #2
	strb r2, [r6, #5]
	str r1, [r6, #0xc]
	str r1, [r6, #0x10]
	str r1, [r6, #0x14]
	str r0, [r6, #0x18]
	ldrb r0, [r6, #0x26c]
	bic r0, r0, #3
	orr r0, r0, #1
	strb r0, [r6, #0x26c]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02162FD8: .word 0x000003FF
	arm_func_end ovl09_2162E8C

	arm_func_start ovl09_2162FDC
ovl09_2162FDC: // 0x02162FDC
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	ldr r1, [r5, #0]
	add r4, r0, #0x1c
	str r1, [r4, #0x224]
	ldr r0, [r5, #4]
	cmp r2, #3
	str r0, [r4, #0x228]
	ldr r0, [r5, #8]
	str r0, [r4, #0x22c]
	addls pc, pc, r2, lsl #2
	b _02163068
_0216300C: // jump table
	b _0216301C // case 0
	b _02163030 // case 1
	b _02163044 // case 2
	b _02163058 // case 3
_0216301C:
	mov r0, #0x2800
	str r0, [r4, #0x23c]
	sub r0, r0, #0x5800
	str r0, [r4, #0x240]
	b _02163068
_02163030:
	mov r0, #0x1800
	str r0, [r4, #0x23c]
	sub r0, r0, #0x4800
	str r0, [r4, #0x240]
	b _02163068
_02163044:
	mov r0, #0x3800
	str r0, [r4, #0x23c]
	sub r0, r0, #0x7800
	str r0, [r4, #0x240]
	b _02163068
_02163058:
	mov r0, #0x2800
	str r0, [r4, #0x23c]
	sub r0, r0, #0x6800
	str r0, [r4, #0x240]
_02163068:
	cmp r3, #0
	beq _0216307C
	cmp r3, #1
	beq _021630A8
	b _021630D0
_0216307C:
	ldr r3, _02163230 // =0x000003FF
	mov r1, #0
_02163084:
	add r0, r1, #1
	add r2, r4, r1, lsl #1
	mov r1, r0, lsl #0x10
	add r0, r2, #0x100
	mov r1, r1, lsr #0x10
	strh r3, [r0, #0x70]
	cmp r1, #0x1e
	blo _02163084
	b _021630D0
_021630A8:
	ldr r3, _02163234 // =0x00007C1F
	mov r1, #0
_021630B0:
	add r0, r1, #1
	add r2, r4, r1, lsl #1
	mov r1, r0, lsl #0x10
	add r0, r2, #0x100
	mov r1, r1, lsr #0x10
	strh r3, [r0, #0x70]
	cmp r1, #0x1e
	blo _021630B0
_021630D0:
	mov r0, #0x1d
	mov r1, #0xc
_021630D8:
	mla r6, r0, r1, r4
	ldr r2, [r6, #-0x10]
	mov r3, r0, lsr #0x1f
	str r2, [r6, #8]
	ldr lr, [r4, #0x240]
	ldr ip, [r6, #-0xc]
	rsb r2, r3, r0, lsl #31
	add ip, lr, ip
	str ip, [r6, #0xc]
	ldr ip, [r6, #-8]
	adds r2, r3, r2, ror #31
	str ip, [r6, #0x10]
	bne _02163138
	add r3, r4, r0, lsl #2
	cmp r0, #0xa
	ldr r2, [r3, #0x1a4]
	bhs _0216312C
	cmp r2, #0x1d
	addlt r2, r2, #2
	strlt r2, [r3, #0x1ac]
	b _02163138
_0216312C:
	cmp r2, #0
	subgt r2, r2, #2
	strgt r2, [r3, #0x1ac]
_02163138:
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #4
	bhs _021630D8
	ldr r0, [r4, #0x23c]
	mov r1, #0x2000
	bl FX_Div
	ldr r2, [r4, #8]
	mov r1, #0x2000
	sub r0, r2, r0
	str r0, [r4, #0x20]
	ldr r2, [r4, #0xc]
	ldr r0, [r4, #0x240]
	add r0, r2, r0
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x10]
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x1ac]
	str r0, [r4, #0x1b4]
	ldr r0, [r4, #0x23c]
	bl FX_Div
	ldr r1, [r4, #0x14]
	mov r2, #0xf
	add r0, r1, r0
	str r0, [r4, #0x2c]
	ldr r3, [r4, #0x18]
	ldr r0, [r4, #0x240]
	mov r1, #0x2000
	add r0, r3, r0
	str r0, [r4, #0x30]
	ldr r0, [r4, #0x1c]
	str r0, [r4, #0x34]
	ldr r0, [r4, #0x1b0]
	str r0, [r4, #0x1b8]
	str r2, [r4, #0x1ac]
	ldr r0, [r4, #0x23c]
	bl FX_Div
	ldr r2, [r5, #0]
	mov r1, #0x2000
	sub r0, r2, r0
	str r0, [r4, #8]
	ldr r2, [r5, #4]
	ldr r0, [r4, #0x240]
	add r0, r2, r0
	str r0, [r4, #0xc]
	ldr r0, [r5, #8]
	str r0, [r4, #0x10]
	ldr r0, [r4, #0x23c]
	bl FX_Div
	ldr r1, [r5, #0]
	add r0, r1, r0
	str r0, [r4, #0x14]
	ldr r1, [r5, #4]
	ldr r0, [r4, #0x240]
	add r0, r1, r0
	str r0, [r4, #0x18]
	ldr r0, [r5, #8]
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x1ac]
	str r0, [r4, #0x1b0]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02163230: .word 0x000003FF
_02163234: .word 0x00007C1F
	arm_func_end ovl09_2162FDC

	arm_func_start ovl09_2163238
ovl09_2163238: // 0x02163238
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x118
	ldr r1, _021635D8 // =0x02176444
	mov r4, r0
	ldrh r0, [r1, #0]
	add r9, r4, #0x1c
	cmp r0, #0xa
	addlo r0, r0, #1
	addlo sp, sp, #0x118
	strloh r0, [r1]
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl Camera3D__GetTask
	cmp r0, #0
	addeq sp, sp, #0x118
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r2, sp, #0x64
	add r3, sp, #0x34
	add r0, r9, #8
	mov r1, #0x1e
	bl Unknown2066510__Func_2066D18
	ldrb r0, [r4, #0x26c]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	addeq r5, r4, #0x274
	addeq r6, r4, #0x318
	beq _021632B4
	bl ovl09_2161698
	mov r5, r0
	bl ovl09_21616A4
	mov r6, r0
_021632B4:
	cmp r5, #0
	cmpne r6, #0
	addeq sp, sp, #0x118
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r0, [r4, #0x26c]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1e
	bne _021632F8
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _021632EC
	mov r0, r5
	bl Camera3D__LoadState
	b _0216333C
_021632EC:
	mov r0, r6
	bl Camera3D__LoadState
	b _0216333C
_021632F8:
	cmp r0, #1
	bne _0216331C
	bl Camera3D__UseEngineA
	cmp r0, #0
	addne sp, sp, #0x118
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r6
	bl Camera3D__LoadState
	b _0216333C
_0216331C:
	cmp r0, #2
	bne _0216333C
	bl Camera3D__UseEngineA
	cmp r0, #0
	addeq sp, sp, #0x118
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r5
	bl Camera3D__LoadState
_0216333C:
	bl NNS_G3dGlbFlushVP
	mov r3, #0x20000000
	add r1, sp, #0x30
	mov r0, #0x2a
	mov r2, #1
	str r3, [sp, #0x30]
	bl NNS_G3dGeBufferOP_N
	mov r2, #1
	add r1, sp, #0x2c
	mov r0, #0x10
	str r2, [sp, #0x2c]
	bl NNS_G3dGeBufferOP_N
	add r1, sp, #0x34
	mov r0, #0x17
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	mov r11, #6
	add r6, r4, #0x200
	ldr r5, _021635DC // =0x000003FF
	mov r8, #0
	add r7, sp, #0x64
	mov r4, r11
_02163394:
	add r0, r9, r8, lsl #2
	ldr r1, [r0, #0x1ac]
	cmp r1, #0
	ble _021635BC
	ldrh r0, [r6, #0x64]
	cmp r0, #1
	beq _021633C4
	cmp r0, #2
	beq _0216340C
	cmp r0, #3
	beq _02163454
	b _02163498
_021633C4:
	ldr r2, [r9, #0x24c]
	mov r0, #0x29
	mov r2, r2, lsl #0x18
	orr r2, r2, #0x8c0
	orr r1, r2, r1, lsl #16
	str r1, [sp, #0x28]
	add r1, sp, #0x28
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r9, r8, lsl #1
	add r0, r0, #0x100
	ldrh r2, [r0, #0x70]
	mov r0, #0x20
	add r1, sp, #0x24
	str r2, [sp, #0x24]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	b _02163498
_0216340C:
	ldr r2, [r9, #0x24c]
	mov r0, #0x29
	mov r2, r2, lsl #0x18
	orr r2, r2, #0x880
	orr r1, r2, r1, lsl #16
	str r1, [sp, #0x20]
	add r1, sp, #0x20
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r9, r8, lsl #1
	add r0, r0, #0x100
	ldrh r2, [r0, #0x70]
	mov r0, #0x20
	add r1, sp, #0x1c
	str r2, [sp, #0x1c]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	b _02163498
_02163454:
	ldr r2, [r9, #0x24c]
	mov r0, #0x29
	mov r2, r2, lsl #0x18
	orr r2, r2, #0x880
	orr r1, r2, r1, lsl #16
	str r1, [sp, #0x18]
	add r1, sp, #0x18
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r9, r8, lsl #1
	add r0, r0, #0x100
	ldrh r2, [r0, #0x70]
	mov r0, #0x20
	add r1, sp, #0x14
	str r2, [sp, #0x14]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
_02163498:
	mov r0, #1
	str r0, [sp, #0x10]
	mov r0, #0x40
	add r1, sp, #0x10
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mul r0, r8, r11
	add r3, r7, r0
	ldrsh r1, [r7, r0]
	ldrsh r0, [r3, #2]
	ldrsh r2, [r3, #4]
	and r1, r5, r1, asr #6
	mov r0, r0, asr #6
	mov r2, r2, asr #6
	mov r0, r0, lsl #0x16
	orr r0, r1, r0, lsr #12
	mov r2, r2, lsl #0x16
	orr r0, r0, r2, lsr #2
	str r0, [sp, #0xc]
	mov r0, #0x24
	add r1, sp, #0xc
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mla r10, r8, r4, r7
	ldrsh r1, [r10, #8]
	ldrsh r0, [r10, #0xa]
	ldrsh r2, [r10, #6]
	mov r1, r1, asr #6
	mov r0, r0, asr #6
	and r2, r5, r2, asr #6
	mov r1, r1, lsl #0x16
	orr r1, r2, r1, lsr #12
	mov r0, r0, lsl #0x16
	orr r0, r1, r0, lsr #2
	str r0, [sp, #8]
	mov r0, #0x24
	add r1, sp, #8
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldrsh r1, [r10, #0x14]
	ldrsh r0, [r10, #0x16]
	ldrsh r2, [r10, #0x12]
	mov r1, r1, asr #6
	mov r0, r0, asr #6
	and r2, r5, r2, asr #6
	mov r1, r1, lsl #0x16
	orr r1, r2, r1, lsr #12
	mov r0, r0, lsl #0x16
	orr r0, r1, r0, lsr #2
	str r0, [sp, #4]
	mov r0, #0x24
	add r1, sp, #4
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldrsh r1, [r10, #0xe]
	ldrsh r0, [r10, #0x10]
	ldrsh r2, [r10, #0xc]
	mov r1, r1, asr #6
	mov r0, r0, asr #6
	and r2, r5, r2, asr #6
	mov r1, r1, lsl #0x16
	orr r1, r2, r1, lsr #12
	mov r0, r0, lsl #0x16
	orr r0, r1, r0, lsr #2
	str r0, [sp]
	mov r0, #0x24
	add r1, sp, #0
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r0, #0x41
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
_021635BC:
	add r0, r8, #2
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #0x1c
	blo _02163394
	add sp, sp, #0x118
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021635D8: .word 0x02176444
_021635DC: .word 0x000003FF
	arm_func_end ovl09_2163238

	arm_func_start ovl09_21635E0
ovl09_21635E0: // 0x021635E0
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x134
	bl MIi_CpuClear16
	mov r1, #0
	strh r1, [r4]
	add r0, r4, #0x100
	strh r1, [r0, #8]
	strh r1, [r0, #0xa]
	strh r1, [r0, #0xc]
	str r1, [r4, #0x110]
	str r1, [r4, #0x114]
	str r1, [r4, #0x118]
	mov r0, #0x1000
	str r0, [r4, #0x11c]
	str r0, [r4, #0x120]
	str r0, [r4, #0x124]
	str r1, [r4, #0x128]
	str r1, [r4, #0x12c]
	str r1, [r4, #0x130]
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_21635E0

	arm_func_start ovl09_216363C
ovl09_216363C: // 0x0216363C
	stmdb sp!, {r3, lr}
	ldrb r2, [r0, #0]
	mov r1, #0
	bic r3, r2, #3
	and r2, r3, #0xff
	bic ip, r2, #4
	and r2, ip, #0xff
	bic r3, r2, #8
	and r2, r3, #0xff
	strb ip, [r0]
	bic r2, r2, #0xf0
	strb r2, [r0]
	ldrb r2, [r0, #1]
	bic lr, r2, #1
	and r2, lr, #0xff
	bic ip, r2, #2
	and r2, ip, #0xff
	bic r3, r2, #4
	and r2, r3, #0xff
	orr r2, r2, #8
	strb lr, [r0, #1]
	bic r2, r2, #0x10
	strb r2, [r0, #1]
	ldrb r2, [r0, #2]
	bic r2, r2, #2
	strb r2, [r0, #2]
	ldrb r2, [r0, #1]
	bic r2, r2, #0xe0
	orr r2, r2, #0x60
	strb r2, [r0, #1]
	strh r1, [r0, #4]
	ldmia sp!, {r3, pc}
	arm_func_end ovl09_216363C

	arm_func_start ovl09_21636BC
ovl09_21636BC: // 0x021636BC
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x1c
	bl ovl09_21635E0
	mov r0, r4
	bl ovl09_216ADF4
	add r0, r4, #0x150
	bl ovl09_216363C
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_21636BC

	arm_func_start ovl09_21636E0
ovl09_21636E0: // 0x021636E0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x90
	mov r4, r0
	add r0, r4, #0x100
	ldrh r1, [r0, #8]
	ldr r3, _021637EC // =FX_SinCosTable_
	add r0, sp, #0x24
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	add r0, r4, #0x100
	ldrh r1, [r0, #0xa]
	ldr r3, _021637EC // =FX_SinCosTable_
	add r0, sp, #0x48
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, r4, #0x100
	ldrh r1, [r0, #0xc]
	ldr r3, _021637EC // =FX_SinCosTable_
	add r0, sp, #0x6c
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotZ33_
	add r0, sp, #0x48
	add r1, sp, #0x24
	add r2, sp, #0
	bl MTX_Concat33
	add r0, sp, #0x6c
	add r1, sp, #0
	add r2, r4, #0x28
	bl MTX_Concat33
	ldr r0, [r4, #0x110]
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x114]
	str r0, [r4, #0x50]
	ldr r0, [r4, #0x118]
	str r0, [r4, #0x54]
	ldr r0, [r4, #0x11c]
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x120]
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x124]
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x128]
	str r0, [r4, #0x58]
	ldr r0, [r4, #0x12c]
	str r0, [r4, #0x5c]
	ldr r0, [r4, #0x130]
	str r0, [r4, #0x60]
	add sp, sp, #0x90
	ldmia sp!, {r4, pc}
	.align 2, 0
_021637EC: .word FX_SinCosTable_
	arm_func_end ovl09_21636E0

	arm_func_start ovl09_21637F0
ovl09_21637F0: // 0x021637F0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrb r0, [r6, #0x150]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	addeq r4, r6, #0x158
	addeq r5, r6, #0x1fc
	beq _02163824
	bl ovl09_2161698
	mov r4, r0
	bl ovl09_21616A4
	mov r5, r0
_02163824:
	ldrb r0, [r6, #4]
	mov r1, r0, lsl #0x1d
	movs r1, r1, lsr #0x1f
	bne _02163850
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _02163850
	ldrb r0, [r6, #2]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _02163890
_02163850:
	ldr r1, [r6, #0x130]
	ldr r0, _02163920 // =0x00024C04
	cmp r1, r0
	ble _02163870
	ldrb r0, [r6, #0x150]
	bic r0, r0, #3
	orr r0, r0, #2
	strb r0, [r6, #0x150]
_02163870:
	ldr r1, [r6, #0x130]
	ldr r0, _02163920 // =0x00024C04
	cmp r1, r0
	bgt _02163890
	ldrb r0, [r6, #0x150]
	bic r0, r0, #3
	orr r0, r0, #1
	strb r0, [r6, #0x150]
_02163890:
	ldrb r0, [r6, #0x150]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1e
	bne _021638C4
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _021638B8
	mov r0, r4
	bl ovl09_21610F0
	ldmia sp!, {r4, r5, r6, pc}
_021638B8:
	mov r0, r5
	bl ovl09_21610F0
	ldmia sp!, {r4, r5, r6, pc}
_021638C4:
	cmp r0, #1
	bne _021638F4
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _021638E4
	mov r0, r5
	bl ovl09_21610F0
	ldmia sp!, {r4, r5, r6, pc}
_021638E4:
	ldrb r0, [r6, #0x150]
	orr r0, r0, #4
	strb r0, [r6, #0x150]
	ldmia sp!, {r4, r5, r6, pc}
_021638F4:
	cmp r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldreqb r0, [r6, #0x150]
	orreq r0, r0, #4
	streqb r0, [r6, #0x150]
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r4
	bl ovl09_21610F0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02163920: .word 0x00024C04
	arm_func_end ovl09_21637F0

	arm_func_start ovl09_2163924
ovl09_2163924: // 0x02163924
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, _02163AD0 // =_mt_math_rand
	mov r5, r0
	ldr r3, [r2, #0]
	ldr r0, _02163AD4 // =0x00196225
	ldr r1, _02163AD8 // =0x3C6EF35F
	ldrb ip, [r5, #0x150]
	mla r4, r3, r0, r1
	mov r0, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	mov r3, ip, lsl #0x18
	add r0, r1, r0, ror #31
	add r0, r0, r3, lsr #28
	str r4, [r2]
	mov r4, r0, lsl #7
	bl ovl09_216ADBC
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	bl ovl09_2164260
	ldrb r0, [r0, #0]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1c
	beq _021639F8
	bl ovl09_2164260
	bl ovl09_21642BC
	bl ovl09_2164260
	ldrb r0, [r0, #0]
	ldrb r1, [r5, #0x150]
	ldr r2, _02163AD0 // =_mt_math_rand
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1c
	bic r1, r1, #0xf0
	mov r0, r0, lsl #0x1c
	orr r4, r1, r0, lsr #24
	strb r4, [r5, #0x150]
	ldr r3, [r2, #0]
	ldr r0, _02163AD4 // =0x00196225
	ldr r1, _02163AD8 // =0x3C6EF35F
	and ip, r4, #0xff
	mla r4, r3, r0, r1
	mov r0, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	mov r3, ip, lsl #0x18
	add r0, r1, r0, ror #31
	add r0, r0, r3, lsr #28
	str r4, [r2]
	mov r4, r0, lsl #7
_021639F8:
	ldrb r0, [r5, #0x150]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1c
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r2, _02163AD0 // =_mt_math_rand
	ldr r0, _02163AD4 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02163AD8 // =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldr r0, [r5, #0x68]
	ldr r2, _02163AD0 // =_mt_math_rand
	addne r0, r0, r4
	subeq r0, r0, r4
	str r0, [r5, #0x68]
	ldr r0, _02163AD4 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02163AD8 // =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldr r0, [r5, #0x6c]
	ldr r2, _02163AD0 // =_mt_math_rand
	addne r0, r0, r4
	subeq r0, r0, r4
	str r0, [r5, #0x6c]
	ldr r0, _02163AD4 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02163AD8 // =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldr r0, [r5, #0x70]
	addne r0, r0, r4
	strne r0, [r5, #0x70]
	subeq r0, r0, r4
	streq r0, [r5, #0x70]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02163AD0: .word _mt_math_rand
_02163AD4: .word 0x00196225
_02163AD8: .word 0x3C6EF35F
	arm_func_end ovl09_2163924

	arm_func_start ovl09_2163ADC
ovl09_2163ADC: // 0x02163ADC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrb r0, [r4, #0x151]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02163B0C
	mov r0, #1
	strh r0, [r4, #0xc0]
	mov r1, #0
	add r0, r4, #0x150
	str r1, [r4, #0xe0]
	bl ovl09_2164238
_02163B0C:
	ldrb r0, [r4, #0x151]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	ldmneia sp!, {r4, pc}
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x20
	bl AnimatorSprite3D__ProcessAnimation
	ldrb r0, [r4, #0x151]
	mov r1, r0, lsl #0x1d
	movs r1, r1, lsr #0x1f
	ldmeqia sp!, {r4, pc}
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl09_2163BF4
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x150
	bl ovl09_2164238
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2163ADC

	arm_func_start ovl09_2163B64
ovl09_2163B64: // 0x02163B64
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrb r0, [r4, #0x150]
	mov r1, r0, lsl #0x1d
	movs r1, r1, lsr #0x1f
	bicne r0, r0, #4
	strneb r0, [r4, #0x150]
	ldmneia sp!, {r4, pc}
	ldr r2, _02163BBC // =0x04000060
	add r0, r4, #0x20
	ldrh r1, [r2, #0]
	bic r1, r1, #0x3000
	orr r1, r1, #8
	strh r1, [r2]
	bl AnimatorSprite3D__Draw
	ldr r0, [r4, #0x12c]
	str r0, [r4, #0x68]
	ldr r0, [r4, #0x130]
	str r0, [r4, #0x6c]
	ldr r0, [r4, #0x134]
	str r0, [r4, #0x70]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02163BBC: .word 0x04000060
	arm_func_end ovl09_2163B64

	arm_func_start ovl09_2163BC0
ovl09_2163BC0: // 0x02163BC0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x1c
	bl ovl09_21636E0
	bl ovl09_21616B0
	bl ovl09_21611C0
	mov r0, r4
	bl ovl09_2163924
	mov r0, r4
	bl ovl09_21637F0
	mov r0, r4
	bl ovl09_2163B64
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2163BC0

	arm_func_start ovl09_2163BF4
ovl09_2163BF4: // 0x02163BF4
	ldr r0, [r0, #0xec]
	tst r0, #0x40000000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end ovl09_2163BF4

	arm_func_start exDrawFadeTask__Main
exDrawFadeTask__Main: // 0x02163C08
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0
	str r1, [r0]
	bl GetExTaskCurrent
	ldr r1, _02163C2C // =ovl09_2163C48
	str r1, [r0]
	bl ovl09_2163C48
	ldmia sp!, {r3, pc}
	.align 2, 0
_02163C2C: .word ovl09_2163C48
	arm_func_end exDrawFadeTask__Main

	arm_func_start exDrawFadeTask__Func8
exDrawFadeTask__Func8: // 0x02163C30
	ldr ip, _02163C38 // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_02163C38: .word GetExTaskWorkCurrent_
	arm_func_end exDrawFadeTask__Func8

	arm_func_start exDrawFadeTask__Destructor
exDrawFadeTask__Destructor: // 0x02163C3C
	ldr ip, _02163C44 // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_02163C44: .word GetExTaskWorkCurrent_
	arm_func_end exDrawFadeTask__Destructor

	arm_func_start ovl09_2163C48
ovl09_2163C48: // 0x02163C48
	stmdb sp!, {r4, r5, r6, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrh r0, [r4, #4]
	add r0, r0, #1
	strh r0, [r4, #4]
	ldrh r1, [r4, #4]
	ldrh r0, [r4, #0xc]
	subs r5, r1, r0
	ldmmiia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #0]
	ldrsh r6, [r4, #6]
	cmp r0, #0
	moveq r0, #1
	streq r0, [r4]
	beq _02163CA0
	ldrsh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	sub r0, r0, r6
	mul r0, r5, r0
	bl _s32_div_f
	add r6, r6, r0
_02163CA0:
	ldrh r0, [r4, #0xe]
	tst r0, #1
	beq _02163CC8
	mvn r0, #0xf
	cmp r6, r0
	movlt r6, r0
	cmp r6, #0x10
	movgt r6, #0x10
	bl Camera3D__GetWork
	strh r6, [r0, #0x58]
_02163CC8:
	ldrh r0, [r4, #0xe]
	tst r0, #2
	beq _02163CF0
	mvn r0, #0xf
	cmp r6, r0
	movlt r6, r0
	cmp r6, #0x10
	movgt r6, #0x10
	bl Camera3D__GetWork
	strh r6, [r0, #0xb4]
_02163CF0:
	ldrh r0, [r4, #0xa]
	cmp r5, r0
	blt _02163D3C
	ldrh r0, [r4, #0xe]
	tst r0, #1
	beq _02163D14
	bl Camera3D__GetWork
	ldrsh r1, [r4, #8]
	strh r1, [r0, #0x58]
_02163D14:
	ldrh r0, [r4, #0xe]
	tst r0, #2
	beq _02163D2C
	bl Camera3D__GetWork
	ldrsh r1, [r4, #8]
	strh r1, [r0, #0xb4]
_02163D2C:
	bl GetExTaskCurrent
	ldr r1, _02163D4C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, r5, r6, pc}
_02163D3C:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02163D4C: .word ExTask_State_Destroy
	arm_func_end ovl09_2163C48

	arm_func_start exDrawFadeTask__Create
exDrawFadeTask__Create: // 0x02163D50
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x10
	movs r6, r2
	mov r8, r0
	mov r7, r1
	mov r5, r3
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r4, #0
	str r4, [sp]
	mov r1, #0x10
	str r1, [sp, #4]
	ldr r0, _02163E18 // =aExdrawfadetask
	ldr r1, _02163E1C // =exDrawFadeTask__Destructor
	str r0, [sp, #8]
	ldr r0, _02163E20 // =exDrawFadeTask__Main
	mov r2, #0xf000
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r9, r0
	bl GetExTaskWork_
	mov r1, r4
	mov r2, #0x10
	mov r4, r0
	bl MI_CpuFill8
	mov r0, r9
	bl GetExTask
	ldr r2, _02163E24 // =exDrawFadeTask__Func8
	mvn r1, #0xf
	cmp r8, r1
	movlt r8, r1
	str r2, [r0, #8]
	cmp r8, #0x10
	movgt r8, #0x10
	mvn r0, #0xf
	cmp r7, r0
	movlt r8, r0
	mov r0, #0
	cmp r7, #0x10
	strh r0, [r4, #4]
	movgt r8, #0x10
	strh r8, [r4, #6]
	strh r7, [r4, #8]
	strh r6, [r4, #0xa]
	ldrh r0, [sp, #0x30]
	strh r5, [r4, #0xc]
	strh r0, [r4, #0xe]
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02163E18: .word aExdrawfadetask
_02163E1C: .word exDrawFadeTask__Destructor
_02163E20: .word exDrawFadeTask__Main
_02163E24: .word exDrawFadeTask__Func8
	arm_func_end exDrawFadeTask__Create

	.data

aExdrawfadetask: // 0x021743D0
	.asciz "exDrawFadeTask"