	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ovl09_2167054
ovl09_2167054: // 0x02167054
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _021671C0 // =0x02176550
	mov r4, r0
	str r4, [r1, #0x28]
	ldr r0, [r1, #8]
	cmp r0, #0
	ldrne r0, [r1, #0x1c]
	cmpne r0, #0
	beq _021670C0
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _021671C0 // =0x02176550
	ldr r1, [r1, #8]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _021671C0 // =0x02176550
	ldr r1, [r1, #0x1c]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _021671C0 // =0x02176550
	ldr r1, [r1, #8]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
_021670C0:
	mov r0, r4
	bl ovl09_2161CB0
	ldr r0, _021671C0 // =0x02176550
	ldrsh r0, [r0]
	cmp r0, #0
	bne _02167128
	mov r1, #0xb
	ldr r0, _021671C4 // =aExtraExBb_9
	sub r2, r1, #0xc
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5]
	ldr r1, _021671C0 // =0x02176550
	mov r0, r0, lsr #8
	str r0, [r1, #8]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _021671C0 // =0x02176550
	mov r0, r5
	str r1, [r2, #0x2c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	ldr r0, _021671C0 // =0x02176550
	ldr r0, [r0, #0x2c]
	bl Asset3DSetup__Create
_02167128:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _021671C0 // =0x02176550
	str r2, [sp]
	ldr r1, [r0, #0x2c]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r0, #0x3c000
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, _021671C8 // =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _021671CC // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #5
	strb r0, [r4]
	ldrb r2, [r4, #4]
	mov r1, #0x3000
	add r0, r4, #0x350
	orr r2, r2, #0x10
	strb r2, [r4, #4]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str r1, [r4, #0x14]
	ldr r1, _021671C0 // =0x02176550
	str r0, [r4, #0x18]
	ldrsh r2, [r1]
	mov r0, #1
	add r2, r2, #1
	strh r2, [r1]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021671C0: .word 0x02176550
_021671C4: .word aExtraExBb_9
_021671C8: .word 0x0000BFF4
_021671CC: .word 0x00007FF8
	arm_func_end ovl09_2167054

	arm_func_start ovl09_21671D0
ovl09_21671D0: // 0x021671D0
	stmdb sp!, {r4, lr}
	ldr r1, _02167234 // =0x02176550
	mov r4, r0
	ldrsh r0, [r1]
	cmp r0, #1
	bgt _02167218
	ldr r0, [r1, #0x2c]
	cmp r0, #0
	beq _021671F8
	bl NNS_G3dResDefaultRelease
_021671F8:
	ldr r0, _02167234 // =0x02176550
	ldr r0, [r0, #0x2c]
	cmp r0, #0
	beq _0216720C
	bl _FreeHEAP_USER
_0216720C:
	ldr r0, _02167234 // =0x02176550
	mov r1, #0
	str r1, [r0, #0x2c]
_02167218:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _02167234 // =0x02176550
	ldrsh r1, [r0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167234: .word 0x02176550
	arm_func_end ovl09_21671D0

	arm_func_start ovl09_2167238
ovl09_2167238: // 0x02167238
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0216745C // =0x02176550
	mov r4, r0
	str r4, [r1, #4]
	ldr r0, [r1, #0x10]
	cmp r0, #0
	ldrne r0, [r1, #0x14]
	cmpne r0, #0
	beq _021672A4
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _0216745C // =0x02176550
	ldr r1, [r1, #0x10]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _0216745C // =0x02176550
	ldr r1, [r1, #0x14]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _0216745C // =0x02176550
	ldr r1, [r1, #0x10]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
_021672A4:
	mov r0, r4
	bl ovl09_2161CB0
	ldr r0, _0216745C // =0x02176550
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _02167338
	mov r1, #0xc
	ldr r0, _02167460 // =aExtraExBb_9
	sub r2, r1, #0xd
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5]
	ldr r1, _0216745C // =0x02176550
	mov r0, r0, lsr #8
	str r0, [r1, #0x10]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _0216745C // =0x02176550
	mov r0, r5
	str r1, [r2, #0x20]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x23
	bl ovl09_21733D4
	ldr r1, _0216745C // =0x02176550
	mov r2, #0
	str r0, [r1, #0x38]
	mov r0, #0x24
	str r2, [r1, #0x30]
	bl ovl09_21733D4
	ldr r1, _0216745C // =0x02176550
	mov r2, #4
	str r0, [r1, #0x3c]
	str r2, [r1, #0x34]
	ldr r0, [r1, #0x20]
	bl Asset3DSetup__Create
_02167338:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0216745C // =0x02176550
	str r2, [sp]
	ldr r1, [r0, #0x20]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r3, #0
	ldr r0, _0216745C // =0x02176550
	str r3, [sp]
	ldr r1, [r0, #0x30]
	ldr r2, [r0, #0x38]
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	mov r3, #0
	ldr r2, _0216745C // =0x02176550
	str r3, [sp]
	ldr r1, [r2, #0x34]
	ldr r2, [r2, #0x3c]
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	ldr r1, _0216745C // =0x02176550
	add r0, r4, #0x300
	ldr r2, [r1, #0x30]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x30]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_021673C0:
	mov r0, r2, lsl r3
	tst r0, #0x11
	beq _021673E0
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_021673E0:
	add r3, r3, #1
	cmp r3, #5
	blo _021673C0
	mov r0, #0x3c000
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, _02167464 // =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _02167468 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #5
	strb r0, [r4]
	ldrb r2, [r4, #4]
	mov r1, #0x3000
	add r0, r4, #0x350
	orr r2, r2, #0x20
	strb r2, [r4, #4]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str r1, [r4, #0x14]
	ldr r1, _0216745C // =0x02176550
	str r0, [r4, #0x18]
	ldrsh r2, [r1, #2]
	mov r0, #1
	add r2, r2, #1
	strh r2, [r1, #2]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216745C: .word 0x02176550
_02167460: .word aExtraExBb_9
_02167464: .word 0x0000BFF4
_02167468: .word 0x00007FF8
	arm_func_end ovl09_2167238

	arm_func_start ovl09_216746C
ovl09_216746C: // 0x0216746C
	stmdb sp!, {r4, lr}
	ldr r1, _021674F8 // =0x02176550
	mov r4, r0
	ldrsh r0, [r1, #2]
	cmp r0, #1
	bgt _021674DC
	ldr r0, [r1, #0x20]
	cmp r0, #0
	beq _02167494
	bl NNS_G3dResDefaultRelease
_02167494:
	ldr r0, _021674F8 // =0x02176550
	ldr r0, [r0, #0x38]
	cmp r0, #0
	beq _021674A8
	bl NNS_G3dResDefaultRelease
_021674A8:
	ldr r0, _021674F8 // =0x02176550
	ldr r0, [r0, #0x3c]
	cmp r0, #0
	beq _021674BC
	bl NNS_G3dResDefaultRelease
_021674BC:
	ldr r0, _021674F8 // =0x02176550
	ldr r0, [r0, #0x20]
	cmp r0, #0
	beq _021674D0
	bl _FreeHEAP_USER
_021674D0:
	ldr r0, _021674F8 // =0x02176550
	mov r1, #0
	str r1, [r0, #0x20]
_021674DC:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _021674F8 // =0x02176550
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021674F8: .word 0x02176550
	arm_func_end ovl09_216746C

	arm_func_start exEffectMeteoTask__Main
exEffectMeteoTask__Main: // 0x021674FC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, [r0]
	cmp r1, #0
	bne _02167520
	bl GetExTaskCurrent
	ldr r1, _0216764C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02167520:
	ldr lr, _02167650 // =_mt_math_rand
	ldr r1, _02167654 // =0x00196225
	ldr r3, [lr]
	ldr r2, _02167658 // =0x3C6EF35F
	ldr ip, _0216765C // =0x55555556
	mla r4, r3, r1, r2
	mov r3, r4, lsr #0x10
	mov r5, r3, lsl #0x10
	mov r6, r5, lsr #0x10
	smull r3, r7, ip, r6
	add r7, r7, r6, lsr #31
	mov r3, #3
	smull r6, r7, r3, r7
	str r4, [lr]
	rsb r7, r6, r5, lsr #16
	strh r7, [r0, #0x10]
	ldr r5, [lr]
	mla r4, r5, r1, r2
	mov r5, r4, lsr #0x10
	mov r5, r5, lsl #0x10
	mov r7, r5, lsr #0x10
	smull r6, r8, ip, r7
	add r8, r8, r7, lsr #31
	smull r6, r7, r3, r8
	str r4, [lr]
	rsb r8, r6, r5, lsr #16
	strh r8, [r0, #0x12]
	ldr r4, [lr]
	mla r8, r4, r1, r2
	mov r4, r8, lsr #0x10
	mov r4, r4, lsl #0x10
	mov r6, r4, lsr #0x10
	smull r5, r7, ip, r6
	add r7, r7, r6, lsr #31
	smull r5, r6, r3, r7
	str r8, [lr]
	rsb r7, r5, r4, lsr #16
	strh r7, [r0, #0x14]
	ldr r4, [lr]
	mla r5, r4, r1, r2
	mov r4, r5, lsr #0x10
	mov r4, r4, lsl #0x10
	mov r6, r4, lsr #0x10
	str r5, [lr]
	smull r5, r7, ip, r6
	add r7, r7, r6, lsr #31
	smull r5, r6, r3, r7
	rsb r7, r5, r4, lsr #16
	strh r7, [r0, #0x16]
	ldr r4, [lr]
	mla r5, r4, r1, r2
	mov r4, r5, lsr #0x10
	mov r4, r4, lsl #0x10
	mov r6, r4, lsr #0x10
	str r5, [lr]
	smull r5, r7, ip, r6
	add r7, r7, r6, lsr #31
	smull r5, r6, r3, r7
	rsb r7, r5, r4, lsr #16
	strh r7, [r0, #0x18]
	ldr r4, [lr]
	mla r1, r4, r1, r2
	str r1, [lr]
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
	smull r2, r5, ip, r4
	add r5, r5, r4, lsr #31
	smull r2, r4, r3, r5
	rsb r5, r2, r1, lsr #16
	strh r5, [r0, #0x1a]
	bl GetExTaskCurrent
	ldr r1, _02167660 // =ovl09_21676B0
	str r1, [r0]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216764C: .word ExTask_State_Destroy
_02167650: .word _mt_math_rand
_02167654: .word 0x00196225
_02167658: .word 0x3C6EF35F
_0216765C: .word 0x55555556
_02167660: .word ovl09_21676B0
	arm_func_end exEffectMeteoTask__Main

	arm_func_start exEffectMeteoTask__Func8
exEffectMeteoTask__Func8: // 0x02167664
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_2172AE0
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02167688 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02167688: .word ExTask_State_Destroy
	arm_func_end exEffectMeteoTask__Func8

	arm_func_start exEffectMeteoTask__Destructor
exEffectMeteoTask__Destructor: // 0x0216768C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x1c
	bl ovl09_21671D0
	add r0, r4, #0xf8
	add r0, r0, #0x400
	bl ovl09_216746C
	ldmia sp!, {r4, pc}
	arm_func_end exEffectMeteoTask__Destructor

	arm_func_start ovl09_21676B0
ovl09_21676B0: // 0x021676B0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x1c
	bl ovl09_2162164
	add r0, r4, #0x66
	add r0, r0, #0x300
	add r1, r4, #0x10
	add r2, r4, #0x16
	mov r3, #0
	bl ovl09_2152D28
	add r0, r4, #0x66
	add r0, r0, #0x300
	add r1, r4, #0x10
	add r2, r4, #0x16
	mov r3, #1
	bl ovl09_2152D28
	add r0, r4, #0x66
	add r0, r0, #0x300
	add r1, r4, #0x10
	add r2, r4, #0x16
	mov r3, #2
	bl ovl09_2152D28
	ldr r1, [r4, #0x370]
	ldr r0, [r4, #8]
	sub r0, r1, r0
	str r0, [r4, #0x370]
	ldr r1, [r4, #0x36c]
	cmp r1, #0x5a000
	bge _02167744
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ldrgt r1, [r4, #0x370]
	addgt r0, r0, #0x1e000
	cmpgt r1, r0
	bgt _02167754
_02167744:
	bl GetExTaskCurrent
	ldr r1, _021677B8 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02167754:
	ldrb r1, [r4, #0x22]
	mov r0, r1, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _02167794
	ldrb r0, [r4, #0x1c]
	cmp r0, #2
	bne _0216778C
	mov r0, r1, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _02167784
	bl ovl09_21677BC
	ldmia sp!, {r4, pc}
_02167784:
	bl ovl09_2167864
	ldmia sp!, {r4, pc}
_0216778C:
	bl ovl09_21677BC
	ldmia sp!, {r4, pc}
_02167794:
	add r0, r4, #0x1c
	add r1, r4, #0x3a8
	bl ovl09_2164034
	add r0, r4, #0x1c
	bl ovl09_216AE78
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_021677B8: .word ExTask_State_Destroy
	arm_func_end ovl09_21676B0

	arm_func_start ovl09_21677BC
ovl09_21677BC: // 0x021677BC
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrb r1, [r0, #0x22]
	bic r1, r1, #1
	strb r1, [r0, #0x22]
	ldr r1, [r0, #0x36c]
	str r1, [r0, #0x848]
	ldr r1, [r0, #0x370]
	str r1, [r0, #0x84c]
	ldr r1, [r0, #0x374]
	str r1, [r0, #0x850]
	bl GetExTaskCurrent
	ldr r1, _021677FC // =ovl09_2167800
	str r1, [r0]
	bl ovl09_2167800
	ldmia sp!, {r3, pc}
	.align 2, 0
_021677FC: .word ovl09_2167800
	arm_func_end ovl09_21677BC

	arm_func_start ovl09_2167800
ovl09_2167800: // 0x02167800
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0xf8
	add r0, r0, #0x400
	bl ovl09_2162164
	add r0, r4, #0xf8
	add r0, r0, #0x400
	bl ovl09_21623F8
	cmp r0, #0
	beq _0216783C
	bl GetExTaskCurrent
	ldr r1, _02167860 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0216783C:
	add r0, r4, #0xf8
	add r1, r4, #0x84
	add r0, r0, #0x400
	add r1, r1, #0x800
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167860: .word ExTask_State_Destroy
	arm_func_end ovl09_2167800

	arm_func_start ovl09_2167864
ovl09_2167864: // 0x02167864
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrb r0, [r4, #0x22]
	bic r0, r0, #1
	strb r0, [r4, #0x22]
	bl exSysTask__GetStatus
	ldrb r0, [r0]
	cmp r0, #1
	bne _021678F4
	ldrsh r0, [r4, #0x24]
	ldr r2, [r4, #8]
	cmp r0, #6
	bne _021678C4
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _02167968
_021678C4:
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
	b _02167968
_021678F4:
	bl exSysTask__GetStatus
	ldrb r0, [r0]
	cmp r0, #2
	bne _02167968
	ldrsh r0, [r4, #0x24]
	ldr r2, [r4, #8]
	cmp r0, #7
	bne _0216793C
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _02167968
_0216793C:
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
_02167968:
	bl GetExTaskCurrent
	ldr r1, _0216797C // =ovl09_2167980
	str r1, [r0]
	bl ovl09_2167980
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216797C: .word ovl09_2167980
	arm_func_end ovl09_2167864

	arm_func_start ovl09_2167980
ovl09_2167980: // 0x02167980
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x1c
	bl ovl09_2162164
	ldr r1, [r4, #0x370]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #0x370]
	ldr r1, [r4, #0x36c]
	cmp r1, #0x5a000
	bge _021679CC
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _021679CC
	ldr r0, [r4, #0x370]
	cmp r0, #0xc8000
	blt _021679DC
_021679CC:
	bl GetExTaskCurrent
	ldr r1, _021679F8 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021679DC:
	add r0, r4, #0x1c
	add r1, r4, #0x3a8
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_021679F8: .word ExTask_State_Destroy
	arm_func_end ovl09_2167980

	arm_func_start exEffectMeteoTask__Create
exEffectMeteoTask__Create: // 0x021679FC
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _02167B34 // =0x000009D4
	str r4, [sp]
	str r1, [sp, #4]
	ldr r0, _02167B38 // =aExeffectmeteot
	ldr r1, _02167B3C // =exEffectMeteoTask__Destructor
	str r0, [sp, #8]
	ldr r0, _02167B40 // =exEffectMeteoTask__Main
	mov r2, #0x4000
	mov r3, #5
	str r4, [sp, #0xc]
	ldr r7, [sp, #0x2c]
	ldr r6, [sp, #0x38]
	ldr r5, [sp, #0x3c]
	bl ExTaskCreate_
	mov r8, r0
	bl GetExTaskWork_
	mov r1, r4
	ldr r2, _02167B34 // =0x000009D4
	mov r4, r0
	bl MI_CpuFill8
	mov r0, r8
	bl GetExTask
	ldr r1, _02167B44 // =exEffectMeteoTask__Func8
	str r1, [r0, #8]
	add r0, r4, #0x1c
	bl ovl09_2167054
	cmp r0, #0
	bne _02167A98
	mov r0, #0
	str r0, [r4]
	add sp, sp, #0x10
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	add sp, sp, #0x10
	bx lr
_02167A98:
	mov r2, #1
	add r0, r4, #0x3a8
	mov r1, #0xa800
	str r2, [r4]
	bl ovl09_21641E8
	add r0, r4, #0x3a8
	bl ovl09_21641F0
	add r0, r4, #0xf8
	add r0, r0, #0x400
	bl ovl09_2167238
	cmp r0, #0
	bne _02167AE4
	mov r0, #0
	str r0, [r4]
	add sp, sp, #0x10
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	add sp, sp, #0x10
	bx lr
_02167AE4:
	add r0, r4, #0x84
	mov r2, #1
	add r0, r0, #0x800
	mov r1, #0xa800
	str r2, [r4]
	bl ovl09_21641E8
	add r0, r4, #0x84
	add r0, r0, #0x800
	bl ovl09_21641F0
	ldr r1, [sp, #0x28]
	ldr r0, [sp, #0x34]
	str r1, [r4, #0x36c]
	str r7, [r4, #0x370]
	stmib r4, {r0, r6}
	str r5, [r4, #0xc]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02167B34: .word 0x000009D4
_02167B38: .word aExeffectmeteot
_02167B3C: .word exEffectMeteoTask__Destructor
_02167B40: .word exEffectMeteoTask__Main
_02167B44: .word exEffectMeteoTask__Func8
	arm_func_end exEffectMeteoTask__Create