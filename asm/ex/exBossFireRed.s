	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ovl09_2158CE4
ovl09_2158CE4: // 0x02158CE4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _02158F70 // =0x02176108
	mov r5, r0
	str r5, [r1, #0x14]
	ldr r0, [r1, #0x10]
	cmp r0, #0
	ldrne r0, [r1, #4]
	cmpne r0, #0
	beq _02158D60
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _02158F70 // =0x02176108
	ldr r1, [r1, #0x10]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02158F70 // =0x02176108
	ldr r1, [r1, #4]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _02158F70 // =0x02176108
	ldr r1, [r1, #0x10]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02158D60:
	mov r0, r5
	bl ovl09_2161CB0
	ldr r0, _02158F70 // =0x02176108
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _02158E24
	mov r1, #8
	ldr r0, _02158F74 // =aExtraExBb_3
	sub r2, r1, #9
	bl ReadFileFromBundle
	mov r4, r0
	ldr r0, [r4]
	ldr r1, _02158F70 // =0x02176108
	mov r0, r0, lsr #8
	str r0, [r1, #0x10]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02158F70 // =0x02176108
	mov r0, r4
	str r1, [r2, #0x1c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	mov r0, #0x18
	bl ovl09_21733D4
	ldr r1, _02158F70 // =0x02176108
	mov r2, #1
	str r0, [r1, #0x34]
	mov r0, #0x1b
	str r2, [r1, #0x44]
	bl ovl09_21733D4
	ldr r1, _02158F70 // =0x02176108
	mov r2, #4
	str r0, [r1, #0x38]
	mov r0, #0x1a
	str r2, [r1, #0x48]
	bl ovl09_21733D4
	ldr r1, _02158F70 // =0x02176108
	mov r2, #3
	str r0, [r1, #0x3c]
	mov r0, #0x19
	str r2, [r1, #0x4c]
	bl ovl09_21733D4
	ldr r1, _02158F70 // =0x02176108
	mov r2, #2
	str r0, [r1, #0x40]
	str r2, [r1, #0x50]
	ldr r0, [r1, #0x1c]
	bl Asset3DSetup__Create
_02158E24:
	add r0, r5, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02158F70 // =0x02176108
	str r2, [sp]
	ldr r1, [r0, #0x1c]
	mov r3, r2
	add r0, r5, #0x20
	bl AnimatorMDL__SetResource
	mov r4, #0
	ldr r7, _02158F78 // =0x0217614C
	ldr r6, _02158F7C // =0x0217613C
	mov r8, r4
_02158E5C:
	str r8, [sp]
	ldr r1, [r7, r4, lsl #2]
	ldr r2, [r6, r4, lsl #2]
	mov r3, r8
	add r0, r5, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	cmp r4, #3
	blo _02158E5C
	ldr r0, _02158F70 // =0x02176108
	ldr r0, [r0, #0x1c]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r1, _02158F78 // =0x0217614C
	ldr r0, _02158F7C // =0x0217613C
	ldr r1, [r1, r4, lsl #2]
	ldr r2, [r0, r4, lsl #2]
	add r0, r5, #0x20
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, _02158F70 // =0x02176108
	add r0, r5, #0x300
	ldr r2, [r1, #0x44]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x44]
	mov r2, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r5, #0x344]
_02158EDC:
	mov r0, r2, lsl r3
	tst r0, #0x1e
	beq _02158EFC
	add r0, r5, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02158EFC:
	add r3, r3, #1
	cmp r3, #5
	blo _02158EDC
	mov r0, #0
	str r0, [r5, #0x358]
	mov r0, #0x1000
	str r0, [r5, #0x368]
	str r0, [r5, #0x36c]
	ldr r1, _02158F80 // =0x00003FFC
	str r0, [r5, #0x370]
	add r0, r5, #0x300
	strh r1, [r0, #0x4a]
	mov r0, #1
	strb r0, [r5]
	ldrb r3, [r5, #2]
	mov r1, #0x4000
	add r2, r5, #0x350
	orr r3, r3, #2
	strb r3, [r5, #2]
	str r1, [r5, #0xc]
	str r1, [r5, #0x10]
	str r1, [r5, #0x14]
	ldr r1, _02158F70 // =0x02176108
	str r2, [r5, #0x18]
	ldrsh r2, [r1, #2]
	add r2, r2, #1
	strh r2, [r1, #2]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02158F70: .word 0x02176108
_02158F74: .word aExtraExBb_3
_02158F78: .word 0x0217614C
_02158F7C: .word 0x0217613C
_02158F80: .word 0x00003FFC
	arm_func_end ovl09_2158CE4

	arm_func_start ovl09_2158F84
ovl09_2158F84: // 0x02158F84
	stmdb sp!, {r4, lr}
	ldr r1, _02159038 // =0x02176108
	mov r4, r0
	ldrsh r0, [r1, #2]
	cmp r0, #1
	bgt _0215901C
	ldr r0, [r1, #0x1c]
	cmp r0, #0
	beq _02158FAC
	bl NNS_G3dResDefaultRelease
_02158FAC:
	ldr r0, _02159038 // =0x02176108
	ldr r0, [r0, #0x34]
	cmp r0, #0
	beq _02158FC0
	bl NNS_G3dResDefaultRelease
_02158FC0:
	ldr r0, _02159038 // =0x02176108
	ldr r0, [r0, #0x38]
	cmp r0, #0
	beq _02158FD4
	bl NNS_G3dResDefaultRelease
_02158FD4:
	ldr r0, _02159038 // =0x02176108
	ldr r0, [r0, #0x3c]
	cmp r0, #0
	beq _02158FE8
	bl NNS_G3dResDefaultRelease
_02158FE8:
	ldr r0, _02159038 // =0x02176108
	ldr r0, [r0, #0x40]
	cmp r0, #0
	beq _02158FFC
	bl NNS_G3dResDefaultRelease
_02158FFC:
	ldr r0, _02159038 // =0x02176108
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	beq _02159010
	bl _FreeHEAP_USER
_02159010:
	ldr r0, _02159038 // =0x02176108
	mov r1, #0
	str r1, [r0, #0x1c]
_0215901C:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _02159038 // =0x02176108
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02159038: .word 0x02176108
	arm_func_end ovl09_2158F84

	arm_func_start exBossFireRedTask__Main
exBossFireRedTask__Main: // 0x0215903C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _021590EC // =0x02176108
	str r0, [r1, #8]
	add r0, r4, #0x2c
	bl ovl09_2158CE4
	add r0, r4, #0x3b8
	mov r1, #0xa800
	bl ovl09_21641E8
	add r0, r4, #0x3b8
	bl ovl09_2164218
	mov r0, #0
	str r0, [sp]
	mov r1, #0xc3
	str r1, [sp, #4]
	sub r1, r1, #0xc4
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, [r4, #0x28]
	mov r0, #0x3c000
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x37c]
	ldr r1, [r4, #0x28]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x380]
	ldr r1, [r4, #0x28]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x384]
	ldr r1, [r4, #0x28]
	ldr r1, [r1, #0x48]
	str r1, [r4, #0x10]
	ldr r1, [r4, #0x28]
	ldr r1, [r1, #0x4c]
	str r1, [r4, #0x14]
	str r0, [r4, #0x18]
	bl GetExTaskCurrent
	ldr r1, _021590F0 // =ovl09_2159140
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021590EC: .word 0x02176108
_021590F0: .word ovl09_2159140
	arm_func_end exBossFireRedTask__Main

	arm_func_start exBossFireRedTask__Func8
exBossFireRedTask__Func8: // 0x021590F4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_2172AE0
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02159118 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02159118: .word ExTask_State_Destroy
	arm_func_end exBossFireRedTask__Func8

	arm_func_start exBossFireRedTask__Destructor
exBossFireRedTask__Destructor: // 0x0215911C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x2c
	bl ovl09_2158F84
	ldr r0, _0215913C // =0x02176108
	mov r1, #0
	str r1, [r0, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215913C: .word 0x02176108
	arm_func_end exBossFireRedTask__Destructor

	arm_func_start ovl09_2159140
ovl09_2159140: // 0x02159140
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl ovl09_2162164
	ldrb r0, [r4, #0x32]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _02159178
	ldrb r0, [r4, #0x2c]
	cmp r0, #2
	bne _02159194
	bl ovl09_21594B0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02159178:
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02159194
	bl GetExTaskCurrent
	ldr r1, _02159380 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02159194:
	ldr r3, [r4, #0x37c]
	ldr r0, [r4, #0x10]
	mov lr, #0
	sub r0, r0, r3
	mov ip, #0xcd
	umull r2, r1, r0, ip
	mla r1, r0, lr, r1
	mov r0, r0, asr #0x1f
	adds r2, r2, #0x800
	mla r1, r0, ip, r1
	adc r0, r1, #0
	mov r5, r2, lsr #0xc
	orr r5, r5, r0, lsl #20
	ldr r2, [r4, #0x380]
	ldr r1, [r4, #0x384]
	add r0, r3, r5
	str r0, [r4, #0x37c]
	ldr r0, [r4, #0x380]
	ldr r5, [r4, #0x14]
	sub r5, r5, r0
	umull r7, r6, r5, ip
	mla r6, r5, lr, r6
	mov r5, r5, asr #0x1f
	mla r6, r5, ip, r6
	adds r7, r7, #0x800
	adc r5, r6, #0
	mov r6, r7, lsr #0xc
	orr r6, r6, r5, lsl #20
	add r0, r0, r6
	str r0, [r4, #0x380]
	ldr r0, [r4, #0x384]
	ldr r5, [r4, #0x18]
	sub r6, r5, r0
	umull r8, r7, r6, ip
	mla r7, r6, lr, r7
	mov r5, r6, asr #0x1f
	mla r7, r5, ip, r7
	adds r6, r8, #0x800
	adc r5, r7, #0
	mov r6, r6, lsr #0xc
	orr r6, r6, r5, lsl #20
	add r0, r0, r6
	str r0, [r4, #0x384]
	ldr r0, [r4, #0x37c]
	mov ip, #0
	sub r0, r0, r3
	str r0, [r4, #4]
	ldr r0, [r4, #0x380]
	sub r0, r0, r2
	str r0, [r4, #8]
	ldr r0, [r4, #0x384]
	sub r0, r0, r1
	str r0, [r4, #0xc]
	ldr r3, [r4, #0x380]
	ldr r1, [r4, #0x14]
	ldr r2, [r4, #0x37c]
	ldr r0, [r4, #0x10]
	sub r1, r3, r1
	subs r0, r2, r0
	rsbmi r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r0, r1
	ldr r2, _02159384 // =0x00000F5E
	ldr r3, _02159388 // =0x0000065D
	ble _021592E4
	umull lr, r7, r0, r2
	mla r7, r0, ip, r7
	umull r6, r5, r1, r3
	mov r0, r0, asr #0x1f
	mla r7, r0, r2, r7
	adds lr, lr, #0x800
	adc r7, r7, #0
	adds r2, r6, #0x800
	mov r6, lr, lsr #0xc
	mla r5, r1, ip, r5
	mov r0, r1, asr #0x1f
	mla r5, r0, r3, r5
	adc r0, r5, #0
	mov r1, r2, lsr #0xc
	orr r6, r6, r7, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r6, r1
	b _02159328
_021592E4:
	umull r7, r6, r1, r2
	mla r6, r1, ip, r6
	umull r5, lr, r0, r3
	mla lr, r0, ip, lr
	mov r1, r1, asr #0x1f
	mov r0, r0, asr #0x1f
	mla r6, r1, r2, r6
	adds r7, r7, #0x800
	adc r2, r6, #0
	adds r1, r5, #0x800
	mla lr, r0, r3, lr
	mov r5, r7, lsr #0xc
	adc r0, lr, #0
	mov r1, r1, lsr #0xc
	orr r5, r5, r2, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r5, r1
_02159328:
	cmp r0, #0xf000
	bge _02159338
	bl ovl09_215938C
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02159338:
	ldr r0, [r4, #0xc]
	ldr r1, [r4, #8]
	bl ovl09_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0x76]
	ldmib r4, {r0, r1}
	bl ovl09_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0x7a]
	add r0, r4, #0x2c
	add r1, r4, #0x3b8
	bl ovl09_2164034
	add r0, r4, #0x2c
	bl ovl09_216AE78
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02159380: .word ExTask_State_Destroy
_02159384: .word 0x00000F5E
_02159388: .word 0x0000065D
	arm_func_end ovl09_2159140

	arm_func_start ovl09_215938C
ovl09_215938C: // 0x0215938C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, _021593A8 // =ovl09_21593AC
	str r1, [r0]
	bl ovl09_21593AC
	ldmia sp!, {r3, pc}
	.align 2, 0
_021593A8: .word ovl09_21593AC
	arm_func_end ovl09_215938C

	arm_func_start ovl09_21593AC
ovl09_21593AC: // 0x021593AC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl ovl09_2162164
	ldrb r0, [r4, #0x32]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _021593E4
	ldrb r0, [r4, #0x2c]
	cmp r0, #2
	bne _02159400
	bl ovl09_21594B0
	ldmia sp!, {r4, pc}
_021593E4:
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02159400
	bl GetExTaskCurrent
	ldr r1, _021594AC // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02159400:
	ldr r1, [r4, #0x37c]
	ldr r0, [r4, #4]
	add r0, r1, r0
	str r0, [r4, #0x37c]
	ldr r1, [r4, #0x380]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #0x380]
	ldr r0, [r4, #0xc]
	ldr r1, [r4, #8]
	bl ovl09_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0x76]
	ldmib r4, {r0, r1}
	bl ovl09_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0x7a]
	ldr r1, [r4, #0x37c]
	cmp r1, #0x5a000
	bge _02159478
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _02159478
	ldr r1, [r4, #0x380]
	cmp r1, #0xc8000
	bge _02159478
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _02159488
_02159478:
	bl GetExTaskCurrent
	ldr r1, _021594AC // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02159488:
	add r0, r4, #0x2c
	add r1, r4, #0x3b8
	bl ovl09_2164034
	add r0, r4, #0x2c
	bl ovl09_216AE78
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_021594AC: .word ExTask_State_Destroy
	arm_func_end ovl09_21593AC

	arm_func_start ovl09_21594B0
ovl09_21594B0: // 0x021594B0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrb r1, [r4, #0x32]
	mov r0, #0
	bic r1, r1, #1
	strb r1, [r4, #0x32]
	ldrb r1, [r4, #0x30]
	orr r1, r1, #2
	strb r1, [r4, #0x30]
	str r0, [r4, #4]
	bl exSysTask__GetStatus
	ldrb r0, [r0]
	cmp r0, #1
	bne _02159554
	ldrsh r0, [r4, #0x34]
	ldr r2, [r4, #8]
	cmp r0, #6
	bne _02159524
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _021595C8
_02159524:
	mov r0, #0x6000
	mov r1, #0
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, ip, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _021595C8
_02159554:
	bl exSysTask__GetStatus
	ldrb r0, [r0]
	cmp r0, #2
	bne _021595C8
	ldrsh r0, [r4, #0x34]
	ldr r2, [r4, #8]
	cmp r0, #7
	bne _0215959C
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _021595C8
_0215959C:
	mov r0, #0x6000
	mov r1, #0
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, ip, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
_021595C8:
	ldr r1, [r4, #8]
	mov r0, #0
	rsb r1, r1, #0
	str r1, [r4, #8]
	ldr r2, _02159644 // =0x00007FF8
	str r0, [r4, #0xc]
	add r1, r4, #0x300
	strh r2, [r1, #0x76]
	strh r0, [r1, #0x78]
	strh r0, [r1, #0x7a]
	ldr r2, _02159648 // =0x00001554
	ldr r3, _0215964C // =_mt_math_rand
	strh r2, [r4, #0x20]
	ldr ip, [r3]
	ldr r1, _02159650 // =0x00196225
	ldr r2, _02159654 // =0x3C6EF35F
	mla lr, ip, r1, r2
	mov r1, lr, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, lsr #0x1f
	rsb r1, r2, r1, lsl #31
	adds r1, r2, r1, ror #31
	str lr, [r3]
	movne r0, #1
	str r0, [r4, #0x24]
	bl GetExTaskCurrent
	ldr r1, _02159658 // =ovl09_215965C
	str r1, [r0]
	bl ovl09_215965C
	ldmia sp!, {r4, pc}
	.align 2, 0
_02159644: .word 0x00007FF8
_02159648: .word 0x00001554
_0215964C: .word _mt_math_rand
_02159650: .word 0x00196225
_02159654: .word 0x3C6EF35F
_02159658: .word ovl09_215965C
	arm_func_end ovl09_21594B0

	arm_func_start ovl09_215965C
ovl09_215965C: // 0x0215965C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl ovl09_2162164
	ldrb r0, [r4, #0x32]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _02159690
	bl GetExTaskCurrent
	ldr r1, _02159750 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02159690:
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _021596AC
	bl GetExTaskCurrent
	ldr r1, _02159750 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021596AC:
	ldr r0, [r4, #0x24]
	cmp r0, #0
	add r0, r4, #0x300
	ldreqh r2, [r0, #0x7a]
	ldreqh r1, [r4, #0x20]
	subeq r1, r2, r1
	beq _021596D4
	ldrh r2, [r0, #0x7a]
	ldrh r1, [r4, #0x20]
	add r1, r2, r1
_021596D4:
	strh r1, [r0, #0x7a]
	ldr r1, [r4, #0x380]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #0x380]
	ldr r1, [r4, #0x37c]
	cmp r1, #0x5a000
	bge _0215971C
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _0215971C
	ldr r1, [r4, #0x380]
	cmp r1, #0xc8000
	bge _0215971C
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _0215972C
_0215971C:
	bl GetExTaskCurrent
	ldr r1, _02159750 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215972C:
	add r0, r4, #0x2c
	add r1, r4, #0x3b8
	bl ovl09_2164034
	add r0, r4, #0x2c
	bl ovl09_216AE78
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02159750: .word ExTask_State_Destroy
	arm_func_end ovl09_215965C

	arm_func_start exBossFireRedTask__Create
exBossFireRedTask__Create: // 0x02159754
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _021597C8 // =0x00000508
	str r4, [sp]
	ldr r0, _021597CC // =aExbossfireredt
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021597D0 // =exBossFireRedTask__Main
	ldr r1, _021597D4 // =exBossFireRedTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _021597C8 // =0x00000508
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x28]
	mov r0, r5
	bl GetExTask
	ldr r1, _021597D8 // =exBossFireRedTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021597C8: .word 0x00000508
_021597CC: .word aExbossfireredt
_021597D0: .word exBossFireRedTask__Main
_021597D4: .word exBossFireRedTask__Destructor
_021597D8: .word exBossFireRedTask__Func8
	arm_func_end exBossFireRedTask__Create

	.data
	
aExbossfireredt: // 0x02174090
	.asciz "exBossFireRedTask"