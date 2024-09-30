	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ovl09_215C614
ovl09_215C614: // 0x0215C614
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _0215C85C // =0x021761CC
	mov r4, r0
	str r4, [r1, #0x44]
	ldr r0, [r1, #0x3c]
	cmp r0, #0
	ldrne r0, [r1, #0x30]
	cmpne r0, #0
	beq _0215C690
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _0215C85C // =0x021761CC
	ldr r1, [r1, #0x3c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _0215C85C // =0x021761CC
	ldr r1, [r1, #0x30]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _0215C85C // =0x021761CC
	ldr r1, [r1, #0x3c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_0215C690:
	mov r0, r4
	bl ovl09_2161CB0
	ldr r0, _0215C85C // =0x021761CC
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _0215C724
	mov r1, #0x16
	ldr r0, _0215C860 // =aExtraExBb_5
	sub r2, r1, #0x17
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _0215C85C // =0x021761CC
	mov r0, r0, lsr #8
	str r0, [r1, #0x3c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _0215C85C // =0x021761CC
	mov r0, r5
	str r1, [r2, #0x48]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x40
	bl ovl09_21733D4
	ldr r1, _0215C85C // =0x021761CC
	mov r2, #0
	str r0, [r1, #0x68]
	mov r0, #0x42
	str r2, [r1, #0x5c]
	bl ovl09_21733D4
	ldr r1, _0215C85C // =0x021761CC
	mov r2, #3
	str r0, [r1, #0x6c]
	str r2, [r1, #0x60]
	ldr r0, [r1, #0x48]
	bl Asset3DSetup__Create
_0215C724:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0215C85C // =0x021761CC
	str r2, [sp]
	ldr r1, [r0, #0x48]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _0215C864 // =0x02176228
	ldr r5, _0215C868 // =0x02176234
	mov r7, r8
_0215C75C:
	str r7, [sp]
	ldr r1, [r6, r8, lsl #2]
	ldr r2, [r5, r8, lsl #2]
	mov r3, r7
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #2
	blo _0215C75C
	ldr r1, _0215C85C // =0x021761CC
	add r0, r4, #0x300
	ldr r2, [r1, #0x5c]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x5c]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_0215C7B0:
	mov r0, r2, lsl r3
	tst r0, #9
	beq _0215C7D0
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215C7D0:
	add r3, r3, #1
	cmp r3, #5
	blo _0215C7B0
	mov r0, #0x41000
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, _0215C86C // =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _0215C870 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r3, #0
	strb r3, [r4]
	ldrb r2, [r4, #1]
	add r0, r4, #0x350
	ldr r1, _0215C85C // =0x021761CC
	orr r2, r2, #0x40
	strb r2, [r4, #1]
	str r3, [r4, #0xc]
	str r3, [r4, #0x10]
	str r3, [r4, #0x14]
	str r0, [r4, #0x18]
	ldrb r2, [r4, #0x38c]
	mov r0, #1
	bic r2, r2, #3
	orr r2, r2, #1
	strb r2, [r4, #0x38c]
	ldrsh r2, [r1, #0]
	add r2, r2, #1
	strh r2, [r1]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215C85C: .word 0x021761CC
_0215C860: .word aExtraExBb_5
_0215C864: .word 0x02176228
_0215C868: .word 0x02176234
_0215C86C: .word 0x0000BFF4
_0215C870: .word 0x00007FF8
	arm_func_end ovl09_215C614

	arm_func_start ovl09_215C874
ovl09_215C874: // 0x0215C874
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, #0
	ldr r7, _0215C914 // =0x02176228
	ldr r6, _0215C918 // =0x02176234
	mov r5, r0
	mov r4, r1
	mov r8, r9
_0215C890:
	str r8, [sp]
	ldr r1, [r7, r9, lsl #2]
	ldr r2, [r6, r9, lsl #2]
	mov r3, r4
	add r0, r5, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #2
	blo _0215C890
	ldr r1, _0215C91C // =0x021761CC
	add r0, r5, #0x300
	ldr r2, [r1, #0x5c]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x5c]
	mov r2, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r5, #0x344]
_0215C8E4:
	mov r0, r2, lsl r3
	tst r0, #9
	beq _0215C904
	add r0, r5, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215C904:
	add r3, r3, #1
	cmp r3, #5
	blo _0215C8E4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0215C914: .word 0x02176228
_0215C918: .word 0x02176234
_0215C91C: .word 0x021761CC
	arm_func_end ovl09_215C874

	arm_func_start ovl09_215C920
ovl09_215C920: // 0x0215C920
	stmdb sp!, {r4, lr}
	ldr r1, _0215C9AC // =0x021761CC
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _0215C990
	ldr r0, [r1, #0x48]
	cmp r0, #0
	beq _0215C948
	bl NNS_G3dResDefaultRelease
_0215C948:
	ldr r0, _0215C9AC // =0x021761CC
	ldr r0, [r0, #0x68]
	cmp r0, #0
	beq _0215C95C
	bl NNS_G3dResDefaultRelease
_0215C95C:
	ldr r0, _0215C9AC // =0x021761CC
	ldr r0, [r0, #0x6c]
	cmp r0, #0
	beq _0215C970
	bl NNS_G3dResDefaultRelease
_0215C970:
	ldr r0, _0215C9AC // =0x021761CC
	ldr r0, [r0, #0x48]
	cmp r0, #0
	beq _0215C984
	bl _FreeHEAP_USER
_0215C984:
	ldr r0, _0215C9AC // =0x021761CC
	mov r1, #0
	str r1, [r0, #0x48]
_0215C990:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _0215C9AC // =0x021761CC
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C9AC: .word 0x021761CC
	arm_func_end ovl09_215C920

	arm_func_start exBossMeteLockOnTask__Main
exBossMeteLockOnTask__Main: // 0x0215C9B0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _0215CA40 // =0x021761CC
	mov r2, #0
	str r0, [r1, #0x34]
	add r0, r4, #0x10
	str r2, [r4, #4]
	bl ovl09_215C614
	add r0, r4, #0x39c
	mov r1, #0xa800
	bl ovl09_21641E8
	add r0, r4, #0x10
	mov r1, #1
	bl ovl09_215C874
	add r0, r4, #0x39c
	bl ovl09_2164218
	ldr r0, [r4, #0x4ec]
	mov r2, #0x41000
	ldr r0, [r0, #0x3bc]
	mov r1, #0x10000
	str r0, [r4, #0x360]
	ldr r3, [r4, #0x4ec]
	mov r0, #0
	ldr r3, [r3, #0x3c0]
	str r3, [r4, #0x364]
	str r2, [r4, #0x368]
	str r1, [r4, #0x378]
	str r1, [r4, #0x37c]
	str r1, [r4, #0x380]
	strh r0, [r4, #8]
	bl GetExTaskCurrent
	ldr r1, _0215CA44 // =ovl09_215CA94
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CA40: .word 0x021761CC
_0215CA44: .word ovl09_215CA94
	arm_func_end exBossMeteLockOnTask__Main

	arm_func_start exBossMeteLockOnTask__Func8
exBossMeteLockOnTask__Func8: // 0x0215CA48
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_2172AE0
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0215CA6C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215CA6C: .word ExTask_State_Destroy
	arm_func_end exBossMeteLockOnTask__Func8

	arm_func_start exBossMeteLockOnTask__Destructor
exBossMeteLockOnTask__Destructor: // 0x0215CA70
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x10
	bl ovl09_215C920
	ldr r0, _0215CA90 // =0x021761CC
	mov r1, #0
	str r1, [r0, #0x34]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215CA90: .word 0x021761CC
	arm_func_end exBossMeteLockOnTask__Destructor

	arm_func_start ovl09_215CA94
ovl09_215CA94: // 0x0215CA94
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	bl ovl09_2162164
	bl ovl09_2154C28
	cmp r0, #1
	bne _0215CABC
	bl ovl09_215CFB4
	ldmia sp!, {r4, pc}
_0215CABC:
	bl ovl09_217175C
	ldr r0, [r0, #0]
	str r0, [r4, #0x360]
	bl ovl09_217175C
	ldr r1, [r0, #4]
	ldr r0, _0215CBD8 // =0x021761CC
	str r1, [r4, #0x364]
	ldr r1, [r0, #0x7c]
	mov r0, #0xf800
	add r1, r1, #0x5000
	str r1, [r4, #0x368]
	ldrsh r2, [r4, #8]
	rsb r0, r0, #0
	mvn r1, #0
	add r2, r2, #0x200
	strh r2, [r4, #8]
	ldrsh r3, [r4, #8]
	mov r2, #0
	umull lr, ip, r3, r0
	adds lr, lr, #0x800
	mla ip, r3, r1, ip
	mov r3, r3, asr #0x1f
	mla ip, r3, r0, ip
	adc r3, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r3, lsl #20
	add r3, ip, #0x10000
	str r3, [r4, #0x378]
	ldrsh r3, [r4, #8]
	umull lr, ip, r3, r0
	adds lr, lr, #0x800
	mla ip, r3, r1, ip
	mov r3, r3, asr #0x1f
	mla ip, r3, r0, ip
	adc r3, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r3, lsl #20
	add r3, ip, #0x10000
	str r3, [r4, #0x37c]
	ldrsh r3, [r4, #8]
	umull lr, ip, r3, r0
	mla ip, r3, r1, ip
	mov r1, r3, asr #0x1f
	mla ip, r1, r0, ip
	adds r1, lr, #0x800
	adc r0, ip, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x10000
	str r0, [r4, #0x380]
	ldrsh r0, [r4, #8]
	cmp r0, #0x1000
	blt _0215CBBC
	mov r0, #0x8000
	str r0, [r4, #0x378]
	str r0, [r4, #0x37c]
	str r0, [r4, #0x380]
	strh r2, [r4, #8]
	bl GetExTaskCurrent
	ldr r2, _0215CBDC // =ovl09_215CBE0
	add r1, r4, #0x39c
	str r2, [r0]
	add r0, r4, #0x10
	bl ovl09_2164034
_0215CBBC:
	add r0, r4, #0x10
	add r1, r4, #0x39c
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CBD8: .word 0x021761CC
_0215CBDC: .word ovl09_215CBE0
	arm_func_end ovl09_215CA94

	arm_func_start ovl09_215CBE0
ovl09_215CBE0: // 0x0215CBE0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	bl ovl09_2162164
	bl ovl09_2154C28
	cmp r0, #1
	bne _0215CC08
	bl ovl09_215CFB4
	ldmia sp!, {r4, pc}
_0215CC08:
	bl ovl09_217175C
	ldr r0, [r0, #0]
	str r0, [r4, #0x360]
	bl ovl09_217175C
	ldr r1, [r0, #4]
	ldr r0, _0215CD00 // =0x021761CC
	str r1, [r4, #0x364]
	ldr r0, [r0, #0x7c]
	mov r1, #0x7000
	add r0, r0, #0x5000
	str r0, [r4, #0x368]
	ldrsh r0, [r4, #8]
	rsb r1, r1, #0
	mvn r2, #0
	add r0, r0, #0x99
	add r0, r0, #0x100
	strh r0, [r4, #8]
	ldrsh r0, [r4, #8]
	umull ip, r3, r0, r1
	adds ip, ip, #0x800
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	adc r0, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r0, lsl #20
	add r0, r3, #0x8000
	str r0, [r4, #0x378]
	ldrsh r0, [r4, #8]
	umull ip, r3, r0, r1
	adds ip, ip, #0x800
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	adc r0, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r0, lsl #20
	add r0, r3, #0x8000
	str r0, [r4, #0x37c]
	ldrsh r0, [r4, #8]
	umull ip, r3, r0, r1
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	adds r1, ip, #0x800
	adc r0, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x8000
	str r0, [r4, #0x380]
	ldrsh r0, [r4, #8]
	cmp r0, #0x1000
	blt _0215CCE4
	bl ovl09_215CD04
	ldmia sp!, {r4, pc}
_0215CCE4:
	add r0, r4, #0x10
	add r1, r4, #0x39c
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CD00: .word 0x021761CC
	arm_func_end ovl09_215CBE0

	arm_func_start ovl09_215CD04
ovl09_215CD04: // 0x0215CD04
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0x1000
	str r1, [r0, #0x378]
	str r1, [r0, #0x37c]
	str r1, [r0, #0x380]
	mov r1, #0xa
	strh r1, [r0]
	bl GetExTaskCurrent
	ldr r1, _0215CD38 // =ovl09_215CD3C
	str r1, [r0]
	bl ovl09_215CD3C
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215CD38: .word ovl09_215CD3C
	arm_func_end ovl09_215CD04

	arm_func_start ovl09_215CD3C
ovl09_215CD3C: // 0x0215CD3C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	bl ovl09_2162164
	bl ovl09_2154C28
	cmp r0, #1
	bne _0215CD64
	bl ovl09_215CFB4
	ldmia sp!, {r4, pc}
_0215CD64:
	ldrsh r0, [r4, #0]
	cmp r0, #0
	ble _0215CDF8
	bl ovl09_217175C
	ldr r1, [r0, #0]
	ldr lr, [r4, #0x360]
	ldr r0, _0215CED4 // =0x00000666
	sub r2, r1, lr
	umull ip, r3, r2, r0
	mov r1, #0
	adds ip, ip, #0x800
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, lr, r1
	str r0, [r4, #0x360]
	bl ovl09_217175C
	ldr r1, [r0, #4]
	ldr lr, [r4, #0x364]
	ldr r0, _0215CED4 // =0x00000666
	sub r2, r1, lr
	umull ip, r3, r2, r0
	mov r1, #0
	adds ip, ip, #0x800
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, lr, r1
	str r0, [r4, #0x364]
	mov r0, #0x41000
	str r0, [r4, #0x368]
_0215CDF8:
	ldrsh r1, [r4, #0]
	mvn r0, #0x16
	cmp r1, r0
	movlt r0, #0xa
	blt _0215CE9C
	bl ovl09_217175C
	ldr r0, [r0, #0]
	ldr lr, [r4, #0x360]
	mov r1, #0
	sub r2, r0, lr
	mov r0, #0xa4
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds ip, ip, #0x800
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, lr, r1
	str r0, [r4, #0x360]
	bl ovl09_217175C
	ldr r0, [r0, #4]
	ldr lr, [r4, #0x364]
	mov r1, #0
	sub r2, r0, lr
	mov r0, #0xa4
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds ip, ip, #0x800
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, lr, r1
	str r0, [r4, #0x364]
	mov r0, #0x41000
	str r0, [r4, #0x368]
	ldrsh r0, [r4, #0]
	sub r0, r0, #1
_0215CE9C:
	strh r0, [r4]
	ldr r0, [r4, #0x4ec]
	ldrsh r0, [r0, #0x56]
	cmp r0, #0xa
	bgt _0215CEB8
	bl ovl09_215CED8
	ldmia sp!, {r4, pc}
_0215CEB8:
	add r0, r4, #0x10
	add r1, r4, #0x39c
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CED4: .word 0x00000666
	arm_func_end ovl09_215CD3C

	arm_func_start ovl09_215CED8
ovl09_215CED8: // 0x0215CED8
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	mov r1, #2
	ldr r5, [r4, #0xc4]
	bl ovl09_215C874
	add r0, r4, #0x39c
	bl ovl09_21641F0
	ldr r1, [r4, #0x360]
	ldr r2, _0215CF38 // =0x021761CC
	mov r0, r5
	str r1, [r2, #0x74]
	ldr r3, [r4, #0x364]
	mov r1, #0x1f
	str r3, [r2, #0x78]
	ldr r3, [r4, #0x368]
	str r3, [r2, #0x7c]
	bl NNS_G3dMdlSetMdlDiffAll
	bl GetExTaskCurrent
	ldr r1, _0215CF3C // =ovl09_215CF40
	str r1, [r0]
	bl ovl09_215CF40
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215CF38: .word 0x021761CC
_0215CF3C: .word ovl09_215CF40
	arm_func_end ovl09_215CED8

	arm_func_start ovl09_215CF40
ovl09_215CF40: // 0x0215CF40
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #0x354]
	ldr r0, [r0, #0]
	cmp r0, #0xa000
	bge _0215CF68
	add r0, r4, #0x10
	bl ovl09_2162164
	b _0215CF70
_0215CF68:
	add r0, r4, #0x39c
	bl ovl09_2164238
_0215CF70:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0215CF84
	bl ovl09_215CFB4
	ldmia sp!, {r4, pc}
_0215CF84:
	bl ovl09_2154C28
	cmp r0, #1
	bne _0215CF98
	bl ovl09_215CFB4
	ldmia sp!, {r4, pc}
_0215CF98:
	add r0, r4, #0x10
	add r1, r4, #0x39c
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_215CF40

	arm_func_start ovl09_215CFB4
ovl09_215CFB4: // 0x0215CFB4
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	ldr r5, [r4, #0xc4]
	mov r1, #3
	bl ovl09_215C874
	add r0, r4, #0x39c
	bl ovl09_21641F0
	mov r0, r5
	mov r1, #0x7c00
	bl NNS_G3dMdlSetMdlDiffAll
	bl GetExTaskCurrent
	ldr r1, _0215D004 // =ovl09_215D008
	str r1, [r0]
	bl ovl09_215D008
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215D004: .word ovl09_215D008
	arm_func_end ovl09_215CFB4

	arm_func_start ovl09_215D008
ovl09_215D008: // 0x0215D008
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	bl ovl09_2162164
	add r0, r4, #0x10
	bl ovl09_21623F8
	cmp r0, #0
	beq _0215D03C
	bl GetExTaskCurrent
	ldr r1, _0215D058 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215D03C:
	add r0, r4, #0x10
	add r1, r4, #0x39c
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D058: .word ExTask_State_Destroy
	arm_func_end ovl09_215D008

	arm_func_start exBossMeteLockOnTask__Create
exBossMeteLockOnTask__Create: // 0x0215D05C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x4f0
	ldr r0, _0215D0DC // =aExbossmetelock
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215D0E0 // =exBossMeteLockOnTask__Main
	ldr r1, _0215D0E4 // =exBossMeteLockOnTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x4f0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x4ec]
	mov r0, r5
	bl GetExTask
	ldr r1, _0215D0E8 // =exBossMeteLockOnTask__Func8
	str r1, [r0, #8]
	ldr r1, [r4, #0x4ec]
	mov r0, #1
	ldr r1, [r1, #0x68]
	str r4, [r1, #4]
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215D0DC: .word aExbossmetelock
_0215D0E0: .word exBossMeteLockOnTask__Main
_0215D0E4: .word exBossMeteLockOnTask__Destructor
_0215D0E8: .word exBossMeteLockOnTask__Func8
	arm_func_end exBossMeteLockOnTask__Create

	.data
	
aExbossmetelock: // 0x021742DC
	.asciz "exBossMeteLockOnTask"