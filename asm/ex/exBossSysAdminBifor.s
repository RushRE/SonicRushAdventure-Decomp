	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exBossSysAdminBiforTask__Main
exBossSysAdminBiforTask__Main: // 0x0215F050
	stmdb sp!, {r3, lr}
	ldr r0, _0215F080 // =0x0217626C
	ldr r0, [r0, #0xc]
	bl GetExTaskWork_
	bl GetCurrentTask
	ldr r1, _0215F080 // =0x0217626C
	str r0, [r1, #8]
	bl GetExTaskCurrent
	ldr r1, _0215F084 // =ovl09_215F0C8
	str r1, [r0]
	bl ovl09_215F0C8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215F080: .word 0x0217626C
_0215F084: .word ovl09_215F0C8
	arm_func_end exBossSysAdminBiforTask__Main

	arm_func_start exBossSysAdminBiforTask__Func8
exBossSysAdminBiforTask__Func8: // 0x0215F088
	stmdb sp!, {r3, lr}
	bl ovl09_2172AE0
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0215F0A8 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215F0A8: .word ExTask_State_Destroy
	arm_func_end exBossSysAdminBiforTask__Func8

	arm_func_start exBossSysAdminBiforTask__Destructor
exBossSysAdminBiforTask__Destructor: // 0x0215F0AC
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, _0215F0C4 // =0x0217626C
	mov r1, #0
	str r1, [r0, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215F0C4: .word 0x0217626C
	arm_func_end exBossSysAdminBiforTask__Destructor

	arm_func_start ovl09_215F0C8
ovl09_215F0C8: // 0x0215F0C8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	ldr r0, _0215F7AC // =0x0217626C
	ldr r0, [r0, #0xc]
	bl GetExTaskWork_
	mov r4, r0
	ldrb r0, [r4, #1]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _0215F2E8
	ldrb r0, [r4, #2]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	beq _0215F138
	ldrb r0, [r4, #0x72]
	add sp, sp, #8
	bic r0, r0, #1
	orr r1, r0, #1
	and r0, r1, #0xff
	orr r0, r0, #2
	strb r0, [r4, #0x72]
	ldrb r0, [r4, #2]
	orr r0, r0, #2
	strb r0, [r4, #2]
	ldrb r0, [r4, #1]
	bic r0, r0, #0x80
	strb r0, [r4, #1]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215F138:
	mov r1, r0, lsl #0x1d
	movs r1, r1, lsr #0x1f
	beq _0215F180
	bic r1, r0, #4
	ldr r0, _0215F7B0 // =0x0217431C
	strb r1, [r4, #2]
	ldr r1, [r0, #0x24]
	ldr r0, _0215F7AC // =0x0217626C
	str r1, [r4, #0x54c]
	ldr r0, [r0, #0xc]
	bl GetExTask
	ldr r1, [r4, #0x54c]
	add sp, sp, #8
	str r1, [r0]
	ldrb r0, [r4, #1]
	bic r0, r0, #0x80
	strb r0, [r4, #1]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215F180:
	mov r1, r0, lsl #0x1c
	movs r1, r1, lsr #0x1f
	beq _0215F1C8
	bic r1, r0, #8
	ldr r0, _0215F7B0 // =0x0217431C
	strb r1, [r4, #2]
	ldr r1, [r0, #0x28]
	ldr r0, _0215F7AC // =0x0217626C
	str r1, [r4, #0x54c]
	ldr r0, [r0, #0xc]
	bl GetExTask
	ldr r1, [r4, #0x54c]
	add sp, sp, #8
	str r1, [r0]
	ldrb r0, [r4, #1]
	bic r0, r0, #0x80
	strb r0, [r4, #1]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215F1C8:
	mov r1, r0, lsl #0x1b
	movs r1, r1, lsr #0x1f
	beq _0215F210
	bic r1, r0, #0x10
	ldr r0, _0215F7B0 // =0x0217431C
	strb r1, [r4, #2]
	ldr r1, [r0, #0x2c]
	ldr r0, _0215F7AC // =0x0217626C
	str r1, [r4, #0x54c]
	ldr r0, [r0, #0xc]
	bl GetExTask
	ldr r1, [r4, #0x54c]
	add sp, sp, #8
	str r1, [r0]
	ldrb r0, [r4, #1]
	bic r0, r0, #0x80
	strb r0, [r4, #1]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215F210:
	mov r1, r0, lsl #0x1a
	movs r1, r1, lsr #0x1f
	beq _0215F258
	bic r1, r0, #0x20
	ldr r0, _0215F7B0 // =0x0217431C
	strb r1, [r4, #2]
	ldr r1, [r0, #0x30]
	ldr r0, _0215F7AC // =0x0217626C
	str r1, [r4, #0x54c]
	ldr r0, [r0, #0xc]
	bl GetExTask
	ldr r1, [r4, #0x54c]
	add sp, sp, #8
	str r1, [r0]
	ldrb r0, [r4, #1]
	bic r0, r0, #0x80
	strb r0, [r4, #1]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215F258:
	mov r1, r0, lsl #0x19
	movs r1, r1, lsr #0x1f
	beq _0215F2A0
	bic r1, r0, #0x40
	ldr r0, _0215F7B0 // =0x0217431C
	strb r1, [r4, #2]
	ldr r1, [r0, #0x34]
	ldr r0, _0215F7AC // =0x0217626C
	str r1, [r4, #0x54c]
	ldr r0, [r0, #0xc]
	bl GetExTask
	ldr r1, [r4, #0x54c]
	add sp, sp, #8
	str r1, [r0]
	ldrb r0, [r4, #1]
	bic r0, r0, #0x80
	strb r0, [r4, #1]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215F2A0:
	mov r1, r0, lsl #0x18
	movs r1, r1, lsr #0x1f
	beq _0215F2E8
	bic r1, r0, #0x80
	ldr r0, _0215F7B0 // =0x0217431C
	strb r1, [r4, #2]
	ldr r1, [r0, #0x38]
	ldr r0, _0215F7AC // =0x0217626C
	str r1, [r4, #0x54c]
	ldr r0, [r0, #0xc]
	bl GetExTask
	ldr r1, [r4, #0x54c]
	add sp, sp, #8
	str r1, [r0]
	ldrb r0, [r4, #1]
	bic r0, r0, #0x80
	strb r0, [r4, #1]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215F2E8:
	ldrsh r0, [r4, #0x5c]
	cmp r0, #0
	ldrb r0, [r4, #0x72]
	bgt _0215F718
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _0215F728
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _0215F728
	bl exBossEffectHitTask__Create
	ldrsh r1, [r4, #0x62]
	ldrsh r0, [r4, #0x74]
	sub r0, r1, r0
	strh r0, [r4, #0x62]
	ldrsh r0, [r4, #0x62]
	cmp r0, #8
	bgt _0215F5A8
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #6
	bne _0215F424
	mov r6, #0
	add r7, r4, #0x1d0
	mov r5, r6
_0215F34C:
	mov r0, r7
	mov r1, r5
	bl SetPaletteAnimation
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, asr #0x10
	cmp r6, #0xf
	add r7, r7, #0x20
	blt _0215F34C
	ldr r0, [r4, #4]
	cmp r0, #0
	mov r0, #0
	beq _0215F39C
	ldr r5, _0215F7B4 // =0x00000105
	rsb r1, r5, #0x104
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlayVoiceClipEx
	b _0215F3B4
_0215F39C:
	sub r1, r0, #1
	ldr r5, _0215F7B8 // =0x00000106
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlayVoiceClipEx
_0215F3B4:
	ldr r0, [r4, #4]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	str r0, [r4, #4]
	mov r0, #8
	strh r0, [r4, #0x62]
	bl exSysTask__GetStatus
	mov r2, #7
	strb r2, [r0, #3]
	ldr r1, _0215F7B0 // =0x0217431C
	ldr r0, _0215F7AC // =0x0217626C
	ldr r2, [r1, #0xc]
	str r2, [r4, #0x548]
	ldr r1, [r1, #0x40]
	str r1, [r4, #0x54c]
	ldr r0, [r0, #0xc]
	bl GetExTask
	ldr r1, [r4, #0x54c]
	str r1, [r0]
	ldrb r0, [r4, #1]
	bic r0, r0, #0x80
	strb r0, [r4, #1]
	bl GetExTaskCurrent
	ldr r1, _0215F7BC // =ovl09_215F7CC
	add sp, sp, #8
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215F424:
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #8
	bne _0215F518
	mov r7, #0
	add r6, r4, #0x1d0
	mov r5, r7
_0215F440:
	mov r0, r6
	mov r1, r5
	bl SetPaletteAnimation
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, asr #0x10
	cmp r7, #0xf
	add r6, r6, #0x20
	blt _0215F440
	ldr r0, [r4, #4]
	cmp r0, #0
	mov r0, #0
	beq _0215F490
	ldr r5, _0215F7B4 // =0x00000105
	rsb r1, r5, #0x104
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlayVoiceClipEx
	b _0215F4A8
_0215F490:
	sub r1, r0, #1
	ldr r5, _0215F7B8 // =0x00000106
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlayVoiceClipEx
_0215F4A8:
	ldr r0, [r4, #4]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	str r0, [r4, #4]
	mov r0, #8
	strh r0, [r4, #0x62]
	bl exSysTask__GetStatus
	mov r2, #9
	strb r2, [r0, #3]
	ldr r1, _0215F7B0 // =0x0217431C
	ldr r0, _0215F7AC // =0x0217626C
	ldr r2, [r1, #0x18]
	str r2, [r4, #0x548]
	ldr r1, [r1, #0x44]
	str r1, [r4, #0x54c]
	ldr r0, [r0, #0xc]
	bl GetExTask
	ldr r1, [r4, #0x54c]
	str r1, [r0]
	ldrb r0, [r4, #1]
	bic r0, r0, #0x80
	strb r0, [r4, #1]
	bl GetExTaskCurrent
	ldr r1, _0215F7BC // =ovl09_215F7CC
	add sp, sp, #8
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215F518:
	ldrsh r0, [r4, #0x62]
	cmp r0, #0
	bgt _0215F64C
	add r6, r4, #0x1d0
	mov r7, #0
	mov r5, #1
_0215F530:
	mov r0, r6
	mov r1, r5
	bl SetPaletteAnimation
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, asr #0x10
	cmp r7, #0xf
	add r6, r6, #0x20
	blt _0215F530
	mov r0, #0
	strh r0, [r4, #0x62]
	bl exSysTask__GetStatus
	mov r2, #0xb
	strb r2, [r0, #3]
	ldr r1, _0215F7B0 // =0x0217431C
	ldr r0, _0215F7AC // =0x0217626C
	ldr r1, [r1, #0x48]
	str r1, [r4, #0x54c]
	ldr r0, [r0, #0xc]
	bl GetExTask
	ldr r1, [r4, #0x54c]
	str r1, [r0]
	ldrb r0, [r4, #1]
	bic r0, r0, #0x80
	strb r0, [r4, #1]
	bl GetExTaskCurrent
	ldr r1, _0215F7BC // =ovl09_215F7CC
	add sp, sp, #8
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215F5A8:
	ldr r2, _0215F7C0 // =_mt_math_rand
	ldr r0, _0215F7C4 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0215F7C8 // =0x3C6EF35F
	mla r0, r3, r0, r1
	str r0, [r2]
	ldrsh r0, [r4, #0x54]
	cmp r0, #0
	bgt _0215F630
	mov r5, #0x3c
	strh r5, [r4, #0x54]
	ldr r0, [r4, #4]
	cmp r0, #0
	mov r0, #0
	sub r1, r0, #1
	beq _0215F604
	mov r2, r1
	mov r3, r1
	str r0, [sp]
	add r5, r5, #0xc9
	str r5, [sp, #4]
	bl PlayVoiceClipEx
	b _0215F61C
_0215F604:
	mov r2, r1
	mov r3, r1
	str r0, [sp]
	add r5, r5, #0xca
	str r5, [sp, #4]
	bl PlayVoiceClipEx
_0215F61C:
	ldr r0, [r4, #4]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	str r0, [r4, #4]
_0215F630:
	mov r5, #0xbd
	sub r1, r5, #0xbe
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlaySfxEx
_0215F64C:
	ldrb r0, [r4, #2]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _0215F6C0
	mov r5, #0xbd
	sub r1, r5, #0xbe
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlaySfxEx
	ldr r1, _0215F7B0 // =0x0217431C
	ldr r0, _0215F7AC // =0x0217626C
	ldr r1, [r1, #0x3c]
	str r1, [r4, #0x54c]
	ldr r0, [r0, #0xc]
	bl GetExTask
	ldr r1, [r4, #0x54c]
	str r1, [r0]
	ldrb r0, [r4, #1]
	bic r0, r0, #0x80
	strb r0, [r4, #1]
	ldrb r0, [r4, #2]
	bic r0, r0, #1
	strb r0, [r4, #2]
	bl GetExTaskCurrent
	ldr r1, _0215F7BC // =ovl09_215F7CC
	str r1, [r0]
	b _0215F728
_0215F6C0:
	add r6, r4, #0x1d0
	mov r7, #0
	mov r5, #1
_0215F6CC:
	mov r0, r6
	mov r1, r5
	bl SetPaletteAnimation
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, asr #0x10
	cmp r7, #0xf
	add r6, r6, #0x20
	blt _0215F6CC
	mov r0, #0x1e
	strh r0, [r4, #0x5c]
	mov r0, #0x3c
	strh r0, [r4, #0x5a]
	ldrb r0, [r4, #0x72]
	bic r1, r0, #2
	and r0, r1, #0xff
	bic r0, r0, #1
	strb r0, [r4, #0x72]
	b _0215F728
_0215F718:
	bic r1, r0, #2
	and r0, r1, #0xff
	bic r0, r0, #1
	strb r0, [r4, #0x72]
_0215F728:
	ldrsh r0, [r4, #0x54]
	cmp r0, #0
	subgt r0, r0, #1
	strgth r0, [r4, #0x54]
	ldrsh r0, [r4, #0x5c]
	cmp r0, #0
	subgt r0, r0, #1
	strgth r0, [r4, #0x5c]
	ldrsh r0, [r4, #0x5a]
	cmp r0, #1
	bne _0215F790
	mov r7, #0
	add r6, r4, #0x1d0
	mov r5, r7
_0215F760:
	mov r0, r6
	mov r1, r5
	bl SetPaletteAnimation
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, asr #0x10
	cmp r7, #0xf
	add r6, r6, #0x20
	blt _0215F760
	mov r0, #0
	strh r0, [r4, #0x5a]
	b _0215F798
_0215F790:
	sub r0, r0, #1
	strh r0, [r4, #0x5a]
_0215F798:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215F7AC: .word 0x0217626C
_0215F7B0: .word 0x0217431C
_0215F7B4: .word 0x00000105
_0215F7B8: .word 0x00000106
_0215F7BC: .word ovl09_215F7CC
_0215F7C0: .word _mt_math_rand
_0215F7C4: .word 0x00196225
_0215F7C8: .word 0x3C6EF35F
	arm_func_end ovl09_215F0C8

	arm_func_start ovl09_215F7CC
ovl09_215F7CC: // 0x0215F7CC
	stmdb sp!, {r3, lr}
	ldr r0, _0215F808 // =0x0217626C
	ldr r0, [r0, #0xc]
	bl GetExTaskWork_
	ldrb r0, [r0, #1]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _0215F7F8
	bl GetExTaskCurrent
	ldr r1, _0215F80C // =ovl09_215F0C8
	str r1, [r0]
_0215F7F8:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215F808: .word 0x0217626C
_0215F80C: .word ovl09_215F0C8
	arm_func_end ovl09_215F7CC
    
	arm_func_start exBossSysAdminBiforTask__Create
exBossSysAdminBiforTask__Create: // 0x0215F810
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x550
	ldr r0, _0215F878 // =aExbosssysadmin
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215F87C // =exBossSysAdminBiforTask__Main
	ldr r1, _0215F880 // =exBossSysAdminBiforTask__Destructor
	ldr r2, _0215F884 // =0x000037FF
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r1, #0
	mov r2, #0x550
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, _0215F888 // =exBossSysAdminBiforTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215F878: .word aExbosssysadmin
_0215F87C: .word exBossSysAdminBiforTask__Main
_0215F880: .word exBossSysAdminBiforTask__Destructor
_0215F884: .word 0x000037FF
_0215F888: .word exBossSysAdminBiforTask__Func8
	arm_func_end exBossSysAdminBiforTask__Create

	arm_func_start ovl09_215F88C
ovl09_215F88C: // 0x0215F88C
	stmdb sp!, {r4, lr}
	ldr r0, _0215F9FC // =0x0217626C
	ldr r0, [r0, #0xc]
	bl GetExTaskWork_
	mov r4, r0
	ldrsh r0, [r4, #0x60]
	cmp r0, #0
	bgt _0215F968
	mov r0, #0xb4
	strh r0, [r4, #0x60]
	ldr r2, _0215FA00 // =_mt_math_rand
	ldr r0, _0215FA04 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0215FA08 // =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldrb r0, [r4, #0]
	orreq r0, r0, #4
	biceq r0, r0, #8
	beq _0215F900
	bic r1, r0, #4
	and r0, r1, #0xff
	orr r0, r0, #8
_0215F900:
	ldr r2, _0215FA00 // =_mt_math_rand
	strb r0, [r4]
	ldr r0, _0215FA04 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0215FA08 // =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldrb r0, [r4, #0]
	beq _0215F950
	bic r1, r0, #1
	and r0, r1, #0xff
	orr r0, r0, #2
	strb r0, [r4]
	b _0215F970
_0215F950:
	bic r0, r0, #1
	orr r1, r0, #1
	and r0, r1, #0xff
	bic r0, r0, #2
	strb r0, [r4]
	b _0215F970
_0215F968:
	sub r0, r0, #1
	strh r0, [r4, #0x60]
_0215F970:
	mov r0, #0x19000
	ldr r1, [r4, #0x3bc]
	rsb r0, r0, #0
	cmp r1, r0
	addlt r0, r1, #0x400
	strlt r0, [r4, #0x3bc]
	ldr r0, [r4, #0x3bc]
	cmp r0, #0x19000
	subgt r0, r0, #0x400
	strgt r0, [r4, #0x3bc]
	ldr r0, [r4, #0x3c0]
	cmp r0, #0x6e000
	subgt r0, r0, #0x400
	strgt r0, [r4, #0x3c0]
	ldr r0, [r4, #0x3c0]
	cmp r0, #0x5a000
	addlt r0, r0, #0x400
	strlt r0, [r4, #0x3c0]
	bl ovl09_215FA10
	bl ovl09_215FA98
	ldr r1, [r4, #0x3bc]
	ldr r0, _0215FA0C // =0xFFFFFE66
	str r1, [r4, #0x48]
	ldr r1, [r4, #0x3c0]
	add r3, r1, r0
	str r3, [r4, #0x4c]
	ldr r1, [r4, #0x3c0]
	ldr r2, [r4, #0x48]
	ldr r0, [r4, #0x3bc]
	sub r1, r1, r3
	sub r0, r2, r0
	bl ovl09_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0xb8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215F9FC: .word 0x0217626C
_0215FA00: .word _mt_math_rand
_0215FA04: .word 0x00196225
_0215FA08: .word 0x3C6EF35F
_0215FA0C: .word 0xFFFFFE66
	arm_func_end ovl09_215F88C

	arm_func_start ovl09_215FA10
ovl09_215FA10: // 0x0215FA10
	stmdb sp!, {r3, lr}
	ldr r0, _0215FA94 // =0x0217626C
	ldr r0, [r0, #0xc]
	bl GetExTaskWork_
	ldrb r3, [r0, #0]
	mov r1, r3, lsl #0x1d
	movs r1, r1, lsr #0x1f
	beq _0215FA60
	mov r1, #0x19000
	ldr r2, [r0, #0x3bc]
	rsb r1, r1, #0
	cmp r2, r1
	subgt r1, r2, #0x400
	strgt r1, [r0, #0x3bc]
	ldmgtia sp!, {r3, pc}
	bic r2, r3, #4
	and r1, r2, #0xff
	orr r1, r1, #8
	strb r1, [r0]
	ldmia sp!, {r3, pc}
_0215FA60:
	mov r1, r3, lsl #0x1c
	movs r1, r1, lsr #0x1f
	ldmeqia sp!, {r3, pc}
	ldr r1, [r0, #0x3bc]
	cmp r1, #0x19000
	addlt r1, r1, #0x400
	strlt r1, [r0, #0x3bc]
	ldmltia sp!, {r3, pc}
	orr r2, r3, #4
	and r1, r2, #0xff
	bic r1, r1, #8
	strb r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215FA94: .word 0x0217626C
	arm_func_end ovl09_215FA10

	arm_func_start ovl09_215FA98
ovl09_215FA98: // 0x0215FA98
	stmdb sp!, {r3, lr}
	ldr r0, _0215FB18 // =0x0217626C
	ldr r0, [r0, #0xc]
	bl GetExTaskWork_
	ldrb r2, [r0, #0]
	mov r1, r2, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _0215FAE0
	ldr r1, [r0, #0x3c0]
	cmp r1, #0x6e000
	addlt r1, r1, #0x400
	strlt r1, [r0, #0x3c0]
	ldmltia sp!, {r3, pc}
	bic r2, r2, #1
	and r1, r2, #0xff
	orr r1, r1, #2
	strb r1, [r0]
	ldmia sp!, {r3, pc}
_0215FAE0:
	mov r1, r2, lsl #0x1e
	movs r1, r1, lsr #0x1f
	ldmeqia sp!, {r3, pc}
	ldr r1, [r0, #0x3c0]
	cmp r1, #0x5a000
	subgt r1, r1, #0x400
	strgt r1, [r0, #0x3c0]
	ldmgtia sp!, {r3, pc}
	bic r1, r2, #1
	orr r2, r1, #1
	and r1, r2, #0xff
	bic r1, r1, #2
	strb r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215FB18: .word 0x0217626C
	arm_func_end ovl09_215FA98