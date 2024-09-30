	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ovl09_215D0EC
ovl09_215D0EC: // 0x0215D0EC
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0215D2D8 // =0x021761CC
	mov r4, r0
	str r4, [r1, #0x28]
	ldr r0, [r1, #0x20]
	cmp r0, #0
	ldrne r0, [r1, #0x1c]
	cmpne r0, #0
	beq _0215D158
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _0215D2D8 // =0x021761CC
	ldr r1, [r1, #0x20]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _0215D2D8 // =0x021761CC
	ldr r1, [r1, #0x1c]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _0215D2D8 // =0x021761CC
	ldr r1, [r1, #0x20]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
_0215D158:
	mov r0, r4
	bl ovl09_2161CB0
	ldr r0, _0215D2D8 // =0x021761CC
	ldrsh r0, [r0, #4]
	cmp r0, #0
	bne _0215D1D4
	mov r1, #0x14
	ldr r0, _0215D2DC // =aExtraExBb_5
	sub r2, r1, #0x15
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _0215D2D8 // =0x021761CC
	mov r0, r0, lsr #8
	str r0, [r1, #0x20]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _0215D2D8 // =0x021761CC
	mov r0, r5
	str r1, [r2, #0x2c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x3b
	bl ovl09_21733D4
	ldr r1, _0215D2D8 // =0x021761CC
	mov r2, #0
	str r0, [r1, #8]
	str r2, [r1, #0x10]
	ldr r0, [r1, #0x2c]
	bl Asset3DSetup__Create
_0215D1D4:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0215D2D8 // =0x021761CC
	str r2, [sp]
	ldr r1, [r0, #0x2c]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r3, #0
	ldr r0, _0215D2D8 // =0x021761CC
	str r3, [sp]
	ldr r1, [r0, #0x10]
	ldr r2, [r0, #8]
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	ldr r1, _0215D2D8 // =0x021761CC
	add r0, r4, #0x300
	ldr r2, [r1, #0x10]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x10]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_0215D240:
	mov r0, r2, lsl r3
	tst r0, #1
	beq _0215D260
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215D260:
	add r3, r3, #1
	cmp r3, #5
	blo _0215D240
	mov r0, #0
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r1, _0215D2E0 // =0x00003FFC
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	mov r1, r1, lsl #1
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #1]
	mov r1, #0x5000
	add r2, r4, #0x350
	orr r3, r3, #0x80
	strb r3, [r4, #1]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str r1, [r4, #0x14]
	ldr r1, _0215D2D8 // =0x021761CC
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #4]
	add r2, r2, #1
	strh r2, [r1, #4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215D2D8: .word 0x021761CC
_0215D2DC: .word aExtraExBb_5
_0215D2E0: .word 0x00003FFC
	arm_func_end ovl09_215D0EC

	arm_func_start ovl09_215D2E4
ovl09_215D2E4: // 0x0215D2E4
	stmdb sp!, {r4, lr}
	ldr r1, _0215D35C // =0x021761CC
	mov r4, r0
	ldrsh r0, [r1, #4]
	cmp r0, #1
	bgt _0215D340
	ldr r0, [r1, #0x2c]
	cmp r0, #0
	beq _0215D30C
	bl NNS_G3dResDefaultRelease
_0215D30C:
	ldr r0, _0215D35C // =0x021761CC
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _0215D320
	bl NNS_G3dResDefaultRelease
_0215D320:
	ldr r0, _0215D35C // =0x021761CC
	ldr r0, [r0, #0x2c]
	cmp r0, #0
	beq _0215D334
	bl _FreeHEAP_USER
_0215D334:
	ldr r0, _0215D35C // =0x021761CC
	mov r1, #0
	str r1, [r0, #0x2c]
_0215D340:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _0215D35C // =0x021761CC
	ldrsh r1, [r0, #4]
	sub r1, r1, #1
	strh r1, [r0, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D35C: .word 0x021761CC
	arm_func_end ovl09_215D2E4

	arm_func_start exBossMeteMeteoTask__Main
exBossMeteMeteoTask__Main: // 0x0215D360
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _0215D4D0 // =0x021761CC
	str r0, [r1, #0x18]
	add r0, r4, #0x88
	bl ovl09_215D0EC
	add r0, r4, #0x14
	add r0, r0, #0x400
	mov r1, #0xa800
	bl ovl09_21641E8
	add r0, r4, #0x14
	add r0, r0, #0x400
	bl ovl09_2164218
	ldr r1, [r4, #0x564]
	ldr r0, _0215D4D4 // =0x000435A1
	ldr r1, [r1, #0x3ec]
	ldr r5, _0215D4D0 // =0x021761CC
	str r1, [r4, #0x3d8]
	ldr r1, [r4, #0x564]
	mov lr, #0x3c000
	ldr r1, [r1, #0x3f0]
	mov ip, #0x3f800000
	str r1, [r4, #0x3dc]
	str r0, [r4, #0x3e0]
	ldr r1, [r4, #0x3d8]
	add r0, r4, #0x168
	str r1, [r4, #0x40]
	add r0, r0, #0x400
	ldr r2, [r4, #0x3dc]
	add r1, r4, #0x40
	str r2, [r4, #0x44]
	ldr r3, [r4, #0x3e0]
	add r2, r4, #0x4c
	str r3, [r4, #0x48]
	ldr r6, [r5, #0x74]
	ldr r3, _0215D4D8 // =0x3A4CCCCD
	str r6, [r4, #0x4c]
	ldr r5, [r5, #0x78]
	str r5, [r4, #0x50]
	str lr, [r4, #0x54]
	str ip, [sp]
	bl ovl09_2152FB0
	mov r1, #1
	strh r1, [r4, #0x28]
	ldr r5, _0215D4DC // =_mt_math_rand
	ldr ip, _0215D4E0 // =0x00196225
	ldr r2, [r5, #0]
	ldr lr, _0215D4E4 // =0x3C6EF35F
	mov r0, #0
	mla r3, r2, ip, lr
	str r3, [r5]
	mov r2, r3, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r2, lsr #0x1f
	rsb r2, r3, r2, lsl #31
	add r2, r3, r2, ror #31
	add r2, r2, #1
	strh r2, [r4, #0x2a]
	strh r1, [r4, #0x2e]
	strh r0, [r4, #0x34]
	ldr r1, [r5, #0]
	ldr r3, _0215D4E8 // =0x55555556
	mla r2, r1, ip, lr
	str r2, [r5]
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r5, r1, lsr #0x10
	smull r2, lr, r3, r5
	add lr, lr, r5, lsr #31
	mov ip, #3
	smull r2, r3, ip, lr
	rsb lr, r2, r1, lsr #16
	add r1, lr, #3
	strh r1, [r4, #0x30]
	str r0, [sp]
	mov r1, #0xc0
	str r1, [sp, #4]
	sub r1, r1, #0xc1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #0
	str r0, [r4, #0x3c]
	bl GetExTaskCurrent
	ldr r1, _0215D4EC // =ovl09_215D544
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215D4D0: .word 0x021761CC
_0215D4D4: .word 0x000435A1
_0215D4D8: .word 0x3A4CCCCD
_0215D4DC: .word _mt_math_rand
_0215D4E0: .word 0x00196225
_0215D4E4: .word 0x3C6EF35F
_0215D4E8: .word 0x55555556
_0215D4EC: .word ovl09_215D544
	arm_func_end exBossMeteMeteoTask__Main

	arm_func_start exBossMeteMeteoTask__Func8
exBossMeteMeteoTask__Func8: // 0x0215D4F0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_2172AE0
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0215D514 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215D514: .word ExTask_State_Destroy
	arm_func_end exBossMeteMeteoTask__Func8

	arm_func_start exBossMeteMeteoTask__Destructor
exBossMeteMeteoTask__Destructor: // 0x0215D518
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #1
	str r1, [r0, #0x3c]
	add r0, r0, #0x88
	bl ovl09_215D2E4
	ldr r0, _0215D540 // =0x021761CC
	mov r1, #0
	str r1, [r0, #0x18]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215D540: .word 0x021761CC
	arm_func_end exBossMeteMeteoTask__Destructor

	arm_func_start ovl09_215D544
ovl09_215D544: // 0x0215D544
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x88
	bl ovl09_2162164
	ldrb r0, [r4, #0x8e]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _0215D57C
	ldrb r0, [r4, #0x88]
	cmp r0, #2
	bne _0215D57C
	bl ovl09_215D794
	ldmia sp!, {r4, pc}
_0215D57C:
	add r0, r4, #0x168
	add r0, r0, #0x400
	add r1, r4, #0x3d8
	mov r2, #1
	bl ovl09_21530FC
	cmp r0, #0
	beq _0215D5AC
	ldr r0, [r4, #0x3e0]
	cmp r0, #0x3c000
	bgt _0215D5AC
	bl ovl09_215D660
	ldmia sp!, {r4, pc}
_0215D5AC:
	bl ovl09_2154C28
	cmp r0, #1
	bne _0215D5D0
	add r0, r4, #0x3d8
	bl exEffectBigBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215D65C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215D5D0:
	ldr r0, [r4, #0x57c]
	ldr r1, [r4, #0x578]
	bl ovl09_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0xd2]
	ldr r0, [r4, #0x574]
	ldr r1, [r4, #0x578]
	bl ovl09_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0xd6]
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _0215D618
	add r0, r4, #0x34
	add r1, r4, #0x28
	add r2, r4, #0x2e
	mov r3, #0
	bl ovl09_2152D28
_0215D618:
	add r1, r4, #0x300
	ldrh ip, [r1, #0xd2]
	ldrh r3, [r4, #0x34]
	add r2, r4, #0x14
	add r0, r4, #0x88
	add r3, ip, r3
	strh r3, [r1, #0xd2]
	ldrb r3, [r4, #0x414]
	add r1, r2, #0x400
	bic r2, r3, #0xf0
	orr r2, r2, #0xa0
	strb r2, [r4, #0x414]
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D65C: .word ExTask_State_Destroy
	arm_func_end ovl09_215D544

	arm_func_start ovl09_215D660
ovl09_215D660: // 0x0215D660
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, _0215D6A0 // =0x021761CC
	mov r3, #0x3c000
	ldr ip, [r1, #0x74]
	mov r2, #3
	str ip, [r0, #0x3d8]
	ldr r1, [r1, #0x78]
	str r1, [r0, #0x3dc]
	str r3, [r0, #0x3e0]
	strh r2, [r0]
	bl GetExTaskCurrent
	ldr r1, _0215D6A4 // =ovl09_215D6A8
	str r1, [r0]
	bl ovl09_215D6A8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215D6A0: .word 0x021761CC
_0215D6A4: .word ovl09_215D6A8
	arm_func_end ovl09_215D660

	arm_func_start ovl09_215D6A8
ovl09_215D6A8: // 0x0215D6A8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x88
	bl ovl09_2162164
	ldrb r0, [r4, #0x8e]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _0215D6E8
	ldrb r0, [r4, #0x88]
	cmp r0, #2
	bne _0215D6E8
	bl ovl09_215D794
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215D6E8:
	bl ovl09_2154C28
	cmp r0, #1
	bne _0215D710
	add r0, r4, #0x3d8
	bl exEffectBigBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215D790 // =ExTask_State_Destroy
	add sp, sp, #8
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215D710:
	ldrsh r0, [r4, #0]
	cmp r0, #0
	bgt _0215D754
	mov ip, #0xc1
	sub r1, ip, #0xc2
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add r0, r4, #0x3d8
	bl exBossMeteBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215D790 // =ExTask_State_Destroy
	add sp, sp, #8
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215D754:
	ldrb r2, [r4, #0x414]
	add r1, r4, #0x14
	add r0, r4, #0x88
	bic r2, r2, #0xf0
	orr r2, r2, #0xa0
	add r1, r1, #0x400
	strb r2, [r4, #0x414]
	bl ovl09_2164034
	add r0, r4, #0x88
	bl ovl09_216AE78
	ldrsh r0, [r4, #0]
	sub r0, r0, #1
	strh r0, [r4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D790: .word ExTask_State_Destroy
	arm_func_end ovl09_215D6A8

	arm_func_start ovl09_215D794
ovl09_215D794: // 0x0215D794
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrb r1, [r4, #0x8e]
	mov r0, #0x800
	bic r1, r1, #1
	strb r1, [r4, #0x8e]
	ldrb r1, [r4, #0x8c]
	orr r1, r1, #2
	strb r1, [r4, #0x8c]
	str r0, [r4, #0x1c]
	bl exSysTask__GetStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _0215D838
	ldrsh r0, [r4, #0x90]
	ldr r2, [r4, #0x1c]
	cmp r0, #6
	bne _0215D808
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x1c]
	b _0215D8AC
_0215D808:
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
	str r1, [r4, #0x1c]
	b _0215D8AC
_0215D838:
	bl exSysTask__GetStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _0215D8AC
	ldrsh r0, [r4, #0x90]
	ldr r2, [r4, #0x1c]
	cmp r0, #7
	bne _0215D880
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x1c]
	b _0215D8AC
_0215D880:
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
	str r1, [r4, #0x1c]
_0215D8AC:
	ldrh r2, [r4, #0x30]
	ldr r1, _0215D8E0 // =0x00001FFE
	add r0, r4, #0x300
	add r2, r2, r2, lsl #1
	strh r2, [r4, #0x30]
	strh r1, [r0, #0xd2]
	mov r0, #1
	str r0, [r4, #0x3c]
	bl GetExTaskCurrent
	ldr r1, _0215D8E4 // =ovl09_215D8E8
	str r1, [r0]
	bl ovl09_215D8E8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D8E0: .word 0x00001FFE
_0215D8E4: .word ovl09_215D8E8
	arm_func_end ovl09_215D794

	arm_func_start ovl09_215D8E8
ovl09_215D8E8: // 0x0215D8E8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x88
	bl ovl09_2162164
	ldr r2, [r4, #0x3dc]
	ldr r1, [r4, #0x1c]
	add r0, r4, #0xd2
	add r1, r2, r1
	str r1, [r4, #0x3dc]
	ldrb r2, [r4, #0x414]
	add r0, r0, #0x300
	add r1, r4, #0x28
	bic r2, r2, #0xf0
	orr r2, r2, #0xa0
	strb r2, [r4, #0x414]
	add r2, r4, #0x2e
	mov r3, #1
	bl ovl09_2152D28
	ldr r1, [r4, #0x3d8]
	cmp r1, #0x5a000
	bge _0215D95C
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _0215D95C
	ldr r0, [r4, #0x3dc]
	cmp r0, #0xc8000
	blt _0215D96C
_0215D95C:
	bl GetExTaskCurrent
	ldr r1, _0215D998 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215D96C:
	add r1, r4, #0x14
	add r0, r4, #0x88
	add r1, r1, #0x400
	bl ovl09_2164034
	ldrb r0, [r4, #0x8e]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x88
	bl ovl09_216AE78
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D998: .word ExTask_State_Destroy
	arm_func_end ovl09_215D8E8

	arm_func_start exBossMeteMeteoTask__Create
exBossMeteMeteoTask__Create: // 0x0215D99C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _0215DA1C // =0x0000058C
	str r4, [sp]
	ldr r0, _0215DA20 // =aExbossmetemete
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215DA24 // =exBossMeteMeteoTask__Main
	ldr r1, _0215DA28 // =exBossMeteMeteoTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _0215DA1C // =0x0000058C
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x564]
	mov r0, r5
	bl GetExTask
	ldr r1, _0215DA2C // =exBossMeteMeteoTask__Func8
	str r1, [r0, #8]
	ldr r1, [r4, #0x564]
	mov r0, #1
	ldr r1, [r1, #0x68]
	str r4, [r1]
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215DA1C: .word 0x0000058C
_0215DA20: .word aExbossmetemete
_0215DA24: .word exBossMeteMeteoTask__Main
_0215DA28: .word exBossMeteMeteoTask__Destructor
_0215DA2C: .word exBossMeteMeteoTask__Func8
	arm_func_end exBossMeteMeteoTask__Create

	.data
	
aExbossmetemete: // 0x021742F4
	.asciz "exBossMeteMeteoTask"