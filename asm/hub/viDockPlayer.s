	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start ViDockPlayer__Constructor
ViDockPlayer__Constructor: // 0x02166574
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ViDockNpc__Func_2167384
	ldr r0, _021665A8 // =0x0217384C
	mov r1, #0
	str r0, [r4]
	str r1, [r4, #0x330]
	str r1, [r4, #0x334]
	mov r0, r4
	str r1, [r4, #0x310]
	bl ViDockPlayer__Func_2166748
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021665A8: .word 0x0217384C
	arm_func_end ViDockPlayer__Constructor

	arm_func_start ViDockPlayer__VTableFunc_21665AC
ViDockPlayer__VTableFunc_21665AC: // 0x021665AC
	stmdb sp!, {r4, lr}
	ldr r1, _021665D0 // =0x0217384C
	mov r4, r0
	str r1, [r4]
	bl ViDockPlayer__Func_2166748
	mov r0, r4
	bl Vi3dObject__Func_216761C
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021665D0: .word 0x0217384C
	arm_func_end ViDockPlayer__VTableFunc_21665AC

	arm_func_start ViDockPlayer__VTableFunc_21665D4
ViDockPlayer__VTableFunc_21665D4: // 0x021665D4
	stmdb sp!, {r4, lr}
	ldr r1, _02166600 // =0x0217384C
	mov r4, r0
	str r1, [r4]
	bl ViDockPlayer__Func_2166748
	mov r0, r4
	bl Vi3dObject__Func_216761C
	mov r0, r4
	bl CPPHelpers__Free
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166600: .word 0x0217384C
	arm_func_end ViDockPlayer__VTableFunc_21665D4

	arm_func_start ViDockPlayer__LoadAssets
ViDockPlayer__LoadAssets: // 0x02166604
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	ldr r0, [r4, #0x310]
	cmp r0, #0
	bne _02166700
	mov r1, #0
	ldr r0, _0216673C // =aBbViSonBb
	sub r2, r1, #1
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x330]
	mov r1, r0
	mov r0, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r1, #1
	ldr r0, _0216673C // =aBbViSonBb
	sub r2, r1, #2
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x334]
	ldr r1, [r4, #0x334]
	mov r0, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r2, #0
	str r2, [sp]
	ldr r1, [r4, #0x334]
	ldr r0, _02166740 // =0x0000FFFF
	stmib sp, {r1, r2}
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r1, [r4, #0x330]
	mov r0, r4
	mov r3, r2
	bl Vi3dObject__Func_216763C
	mov r0, #0x400
	str r0, [r4, #0x160]
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	mov r0, r4
	mov r3, r1
	bl Vi3dObject__Func_2167900
	ldr r1, [r4, #4]
	ldr r0, _02166744 // =0x00000E38
	orr r1, r1, #1
	str r1, [r4, #4]
	strh r0, [r4, #0x3e]
	mov r0, #1
	str r0, [r4, #0x310]
_02166700:
	mov r1, #0
	str r1, [r4, #0x300]
	str r1, [r4, #0x304]
	mov r0, #3
	str r0, [r4, #0x308]
	str r1, [r4, #0x30c]
	str r1, [r4, #0x318]
	str r1, [r4, #0x31c]
	str r1, [r4, #0x320]
	str r1, [r4, #0x324]
	str r0, [r4, #0x328]
	mov r0, #0x1000
	str r0, [r4, #0x32c]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216673C: .word aBbViSonBb
_02166740: .word 0x0000FFFF
_02166744: .word 0x00000E38
	arm_func_end ViDockPlayer__LoadAssets

	arm_func_start ViDockPlayer__Func_2166748
ViDockPlayer__Func_2166748: // 0x02166748
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl Vi3dObject__Func_21677C4
	ldr r0, [r4, #0x330]
	cmp r0, #0
	beq _02166774
	bl NNS_G3dResDefaultRelease
	ldr r0, [r4, #0x330]
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x330]
_02166774:
	ldr r0, [r4, #0x334]
	cmp r0, #0
	beq _0216678C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x334]
_0216678C:
	mov r0, #1
	str r0, [r4, #0x314]
	mov r0, #0
	str r0, [r4, #0x310]
	ldmia sp!, {r4, pc}
	arm_func_end ViDockPlayer__Func_2166748

	arm_func_start ViDockPlayer__Func_21667A0
ViDockPlayer__Func_21667A0: // 0x021667A0
	add r0, r0, #0x318
	bx lr
	arm_func_end ViDockPlayer__Func_21667A0

	arm_func_start ViDockPlayer__Func_21667A8
ViDockPlayer__Func_21667A8: // 0x021667A8
	strh r1, [r0, #0x38]
	cmp r2, #0
	ldrneh r1, [r0, #0x38]
	strneh r1, [r0, #0x3a]
	bx lr
	arm_func_end ViDockPlayer__Func_21667A8

	arm_func_start ViDockPlayer__Func_21667BC
ViDockPlayer__Func_21667BC: // 0x021667BC
	strh r1, [r0, #0x38]
	cmp r2, #0
	movne r1, #1
	moveq r1, #0
	str r1, [r0, #0x328]
	bx lr
	arm_func_end ViDockPlayer__Func_21667BC

	arm_func_start ViDockPlayer__Func_21667D4
ViDockPlayer__Func_21667D4: // 0x021667D4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x70
	mov r5, r0
	add r0, sp, #0x4c
	mov r4, r1
	bl CPPHelpers__Func_2085E40
	add r0, sp, #0x28
	bl CPPHelpers__Func_2085E40
	add r0, sp, #0x1c
	bl CPPHelpers__Func_2085EE8
	ldrh r1, [r5, #0x38]
	ldr r2, _02166B78 // =FX_SinCosTable_
	add r0, sp, #0x4c
	mov r1, r1, asr #4
	mov ip, r1, lsl #1
	add r1, ip, #1
	mov r1, r1, lsl #1
	ldrsh r3, [r2, r1]
	mov r1, ip, lsl #1
	ldrsh r2, [r2, r1]
	add r1, sp, #0xc
	str r3, [sp, #8]
	str r2, [sp, #0xc]
	add r2, sp, #8
	bl CPPHelpers__MtxRotY33
	mov r0, #0
	str r0, [sp, #0x1c]
	str r0, [sp, #0x20]
	mov r0, #0x1000
	str r0, [sp, #0x24]
	add r0, sp, #0x1c
	add r1, sp, #0x4c
	bl CPPHelpers__Func_2085E74
	ldr r3, [r5, #0x328]
	cmp r3, #2
	bhs _021668E4
	ldr r1, _02166B7C // =0x02173040
	mov r0, #0xc
	mla r2, r3, r0, r1
	ldr r0, [r2, #4]
	ldr r1, [r5, #0x324]
	cmp r1, r0
	strlt r0, [r5, #0x324]
	blt _021668C4
	ldr r0, [r2]
	cmp r1, r0
	bge _021668AC
	ldr r0, [r2, #8]
	add r1, r1, r0
	str r1, [r5, #0x324]
	ldr r0, [r2]
	cmp r1, r0
	strgt r0, [r5, #0x324]
	b _021668C4
_021668AC:
	ble _021668C4
	sub r1, r1, #0x80
	str r1, [r5, #0x324]
	ldr r0, [r2]
	cmp r1, r0
	strlt r0, [r5, #0x324]
_021668C4:
	ldr r0, [r5, #0x328]
	cmp r0, #1
	beq _021668EC
	ldr r1, [r5, #0x32c]
	ldr r0, [r5, #0x324]
	cmp r0, r1
	strgt r1, [r5, #0x324]
	b _021668EC
_021668E4:
	mov r0, #0
	str r0, [r5, #0x324]
_021668EC:
	ldr r1, [r5, #0x324]
	add r0, sp, #0x1c
	smull r3, r2, r1, r4
	adds r1, r3, #0x800
	adc r2, r2, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r2, lsl #20
	bl CPPHelpers__VEC_Multiply_Alt
	ldr r0, [r5, #0x324]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r5, #0x300]
	beq _02166934
	cmp r0, #0x1000
	movle r0, #1
	strle r0, [r5, #0x300]
	movgt r0, #2
	strgt r0, [r5, #0x300]
_02166934:
	ldr r1, [r5, #0x300]
	ldr r0, [r5, #0x304]
	cmp r1, r0
	beq _021669E0
	cmp r1, #0
	beq _02166960
	cmp r1, #1
	beq _02166980
	cmp r1, #2
	beq _021669A4
	b _021669C4
_02166960:
	mov r1, #0
	mov r2, #1
	str r1, [sp]
	mov r0, r5
	mov r3, r2
	str r1, [sp, #4]
	bl Vi3dObject__Func_2167900
	b _021669C4
_02166980:
	mov r1, #1
	mov r0, r5
	mov r2, r1
	mov r3, r1
	str r1, [sp]
	mov r4, #0
	str r4, [sp, #4]
	bl Vi3dObject__Func_2167900
	b _021669C4
_021669A4:
	mov r2, #1
	mov r0, r5
	mov r3, r2
	str r2, [sp]
	mov r4, #0
	mov r1, #2
	str r4, [sp, #4]
	bl Vi3dObject__Func_2167900
_021669C4:
	ldr r1, [r5, #0x300]
	mov r0, #3
	str r1, [r5, #0x304]
	str r0, [r5, #0x308]
	mov r0, #0
	str r0, [r5, #0x30c]
	b _02166AC8
_021669E0:
	cmp r1, #0
	bne _02166A30
	ldr r0, [r5, #0x308]
	cmp r0, #3
	beq _02166A30
	ldr r0, [r5, #0x314]
	cmp r0, #0
	bne _02166A30
	mov r1, #0
	mov r2, #1
	str r1, [sp]
	mov r0, r5
	mov r3, r2
	str r1, [sp, #4]
	bl Vi3dObject__Func_2167900
	mov r0, #3
	str r0, [r5, #0x308]
	mov r0, #0
	str r0, [r5, #0x30c]
	b _02166AC8
_02166A30:
	ldr r0, [r5, #0x314]
	cmp r0, #0
	beq _02166AC8
	cmp r1, #0
	bne _02166AC8
	ldr r0, [r5, #0x30c]
	cmp r0, #0xb4
	blo _02166AC8
	ldr r0, [r5, #0x308]
	cmp r0, #0
	beq _02166A94
	cmp r0, #1
	beq _02166AC8
	cmp r0, #3
	bne _02166AC8
	mov r2, #0
	str r2, [sp]
	mov r0, r5
	mov r3, r2
	mov r1, #3
	str r2, [sp, #4]
	bl Vi3dObject__Func_2167900
	mov r0, #0
	str r0, [r5, #0x308]
	b _02166AC8
_02166A94:
	add r0, r5, #0x100
	ldrh r0, [r0, #0x50]
	tst r0, #0x8000
	beq _02166AC8
	mov r3, #0
	str r3, [sp]
	mov r0, r5
	mov r1, #4
	mov r2, #1
	str r3, [sp, #4]
	bl Vi3dObject__Func_2167900
	mov r0, #1
	str r0, [r5, #0x308]
_02166AC8:
	ldr r0, [r5, #0x300]
	cmp r0, #0
	beq _02166AF0
	cmp r0, #1
	beq _02166AFC
	cmp r0, #2
	ldreq r0, [r5, #0x324]
	addeq r0, r0, r0, asr #1
	streq r0, [r5, #0x160]
	b _02166B08
_02166AF0:
	mov r0, #0x1000
	str r0, [r5, #0x160]
	b _02166B08
_02166AFC:
	ldr r0, [r5, #0x324]
	mov r0, r0, lsl #1
	str r0, [r5, #0x160]
_02166B08:
	add r0, r5, #8
	bl CPPHelpers__Func_2085F9C
	ldr r2, [r0]
	add r1, sp, #0x1c
	str r2, [r5, #0x318]
	ldr r3, [r0, #4]
	add r2, r5, #0x318
	str r3, [r5, #0x31c]
	ldr r3, [r0, #8]
	add r0, sp, #0x10
	str r3, [r5, #0x320]
	bl CPPHelpers__VEC_Add_Alt2
	add r0, sp, #0x10
	bl CPPHelpers__Func_2085F98
	mov r1, r0
	add r0, r5, #8
	bl CPPHelpers__VEC_Copy_Alt
	mov r0, r5
	bl Vi3dObject__Func_2167ADC
	ldr r1, [r5, #0x30c]
	mov r0, #0
	add r1, r1, #1
	str r1, [r5, #0x30c]
	str r0, [r5, #0x300]
	mov r0, #3
	str r0, [r5, #0x328]
	add sp, sp, #0x70
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02166B78: .word FX_SinCosTable_
_02166B7C: .word 0x02173040
	arm_func_end ViDockPlayer__Func_21667D4

	arm_func_start ViDockPlayer__Func_2166B80
ViDockPlayer__Func_2166B80: // 0x02166B80
	str r1, [r0, #0x314]
	mov r1, #0
	str r1, [r0, #0x30c]
	bx lr
	arm_func_end ViDockPlayer__Func_2166B80

	arm_func_start ViDockPlayer__Func_2166B90
ViDockPlayer__Func_2166B90: // 0x02166B90
	str r1, [r0, #0x32c]
	bx lr
	arm_func_end ViDockPlayer__Func_2166B90
