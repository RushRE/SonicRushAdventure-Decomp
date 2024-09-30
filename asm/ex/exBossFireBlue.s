	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

exBossFireBlueTask__ActiveInstanceCount: // 0x02176108
    .space 0x02

exBossFireRedTask__ActiveInstanceCount: // 0x0217610A
    .space 0x02

	.align 4

exBossFireRedTask__unk_217610C: // 0x0217610C
    .space 0x04
	
exBossFireRedTask__TaskSingleton: // 0x02176110
    .space 0x04
	
exBossFireBlueTask__TaskSingleton: // 0x02176114
    .space 0x04
	
exBossFireRedTask__dword_2176118: // 0x02176118
    .space 0x04
	
exBossFireRedTask__unk_217611C: // 0x0217611C
    .space 0x04
	
exBossFireBlueTask__unk_2176120: // 0x02176120
    .space 0x04
	
exBossFireRedTask__unk_2176124: // 0x02176124
    .space 0x04
	
exBossFireRedTask__unk_2176128: // 0x02176128
    .space 0x04
	
exBossFireBlueTask__dword_217612C: // 0x0217612C
    .space 0x04
	
exBossFireBlueTask__unk_2176130: // 0x02176130
    .space 0x04
	
exBossFireBlueTask__unk_2176134: // 0x02176134
    .space 0x04
	
exBossFireBlueTask__unk_2176138: // 0x02176138
    .space 0x04
	
exBossFireRedTask__FileTable: // 0x0217613C
    .space 0x04 * 4
	
exBossFireRedTask__AnimTable: // 0x0217614C
    .space 0x04 * 4
	
exBossFireBlueTask__AnimTable: // 0x0217615C
    .space 0x04 * 4
	
exBossFireBlueTask__FileTable: // 0x0217616C
    .space 0x04 * 4

	.text

	arm_func_start ovl09_21581C0
ovl09_21581C0: // 0x021581C0
	ldr r0, _021581D0 // =0x02175FC4
	mov r1, #0
	str r1, [r0, #0x20]
	bx lr
	.align 2, 0
_021581D0: .word 0x02175FC4
	arm_func_end ovl09_21581C0

	arm_func_start ovl09_21581D4
ovl09_21581D4: // 0x021581D4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	mov r5, r0
	str r5, [r1, #0x18]
	ldr r0, [r1, #0x2c]
	cmp r0, #0
	ldrne r0, [r1, #0x28]
	cmpne r0, #0
	beq _02158250
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	ldr r1, [r1, #0x2c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	ldr r1, [r1, #0x28]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	ldr r1, [r1, #0x2c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02158250:
	mov r0, r5
	bl ovl09_2161CB0
	ldr r0, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _02158314
	mov r1, #9
	ldr r0, _02158464 // =aExtraExBb_3
	sub r2, r1, #0xa
	bl ReadFileFromBundle
	mov r4, r0
	ldr r0, [r4, #0]
	ldr r1, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x2c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	mov r0, r4
	str r1, [r2, #0x24]
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	mov r0, #0x1c
	bl ovl09_21733D4
	ldr r1, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	mov r2, #1
	str r0, [r1, #0x64]
	mov r0, #0x1f
	str r2, [r1, #0x54]
	bl ovl09_21733D4
	ldr r1, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	mov r2, #4
	str r0, [r1, #0x68]
	mov r0, #0x1e
	str r2, [r1, #0x58]
	bl ovl09_21733D4
	ldr r1, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	mov r2, #3
	str r0, [r1, #0x6c]
	mov r0, #0x1d
	str r2, [r1, #0x5c]
	bl ovl09_21733D4
	ldr r1, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	mov r2, #2
	str r0, [r1, #0x70]
	str r2, [r1, #0x60]
	ldr r0, [r1, #0x24]
	bl Asset3DSetup__Create
_02158314:
	add r0, r5, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0x24]
	mov r3, r2
	add r0, r5, #0x20
	bl AnimatorMDL__SetResource
	mov r4, #0
	ldr r7, _02158468 // =exBossFireBlueTask__AnimTable
	ldr r6, _0215846C // =exBossFireBlueTask__FileTable
	mov r8, r4
_0215834C:
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
	blo _0215834C
	ldr r0, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	ldr r0, [r0, #0x24]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r1, _02158468 // =exBossFireBlueTask__AnimTable
	ldr r0, _0215846C // =exBossFireBlueTask__FileTable
	ldr r1, [r1, r4, lsl #2]
	ldr r2, [r0, r4, lsl #2]
	add r0, r5, #0x20
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	add r0, r5, #0x300
	ldr r2, [r1, #0x54]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x54]
	mov r2, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r5, #0x344]
_021583CC:
	mov r0, r2, lsl r3
	tst r0, #0x1e
	beq _021583EC
	add r0, r5, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_021583EC:
	add r3, r3, #1
	cmp r3, #5
	blo _021583CC
	mov r0, #0
	str r0, [r5, #0x358]
	mov r0, #0x1000
	str r0, [r5, #0x368]
	str r0, [r5, #0x36c]
	ldr r1, _02158470 // =0x00003FFC
	str r0, [r5, #0x370]
	add r0, r5, #0x300
	strh r1, [r0, #0x4a]
	mov r0, #1
	strb r0, [r5]
	ldrb r3, [r5, #2]
	mov r1, #0x4000
	add r2, r5, #0x350
	orr r3, r3, #4
	strb r3, [r5, #2]
	str r1, [r5, #0xc]
	str r1, [r5, #0x10]
	str r1, [r5, #0x14]
	ldr r1, _02158460 // =exBossFireBlueTask__ActiveInstanceCount
	str r2, [r5, #0x18]
	ldrsh r2, [r1, #0]
	add r2, r2, #1
	strh r2, [r1]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02158460: .word exBossFireBlueTask__ActiveInstanceCount
_02158464: .word aExtraExBb_3
_02158468: .word exBossFireBlueTask__AnimTable
_0215846C: .word exBossFireBlueTask__FileTable
_02158470: .word 0x00003FFC
	arm_func_end ovl09_21581D4

	arm_func_start ovl09_2158474
ovl09_2158474: // 0x02158474
	stmdb sp!, {r4, lr}
	ldr r1, _02158528 // =exBossFireBlueTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _0215850C
	ldr r0, [r1, #0x24]
	cmp r0, #0
	beq _0215849C
	bl NNS_G3dResDefaultRelease
_0215849C:
	ldr r0, _02158528 // =exBossFireBlueTask__ActiveInstanceCount
	ldr r0, [r0, #0x64]
	cmp r0, #0
	beq _021584B0
	bl NNS_G3dResDefaultRelease
_021584B0:
	ldr r0, _02158528 // =exBossFireBlueTask__ActiveInstanceCount
	ldr r0, [r0, #0x68]
	cmp r0, #0
	beq _021584C4
	bl NNS_G3dResDefaultRelease
_021584C4:
	ldr r0, _02158528 // =exBossFireBlueTask__ActiveInstanceCount
	ldr r0, [r0, #0x6c]
	cmp r0, #0
	beq _021584D8
	bl NNS_G3dResDefaultRelease
_021584D8:
	ldr r0, _02158528 // =exBossFireBlueTask__ActiveInstanceCount
	ldr r0, [r0, #0x70]
	cmp r0, #0
	beq _021584EC
	bl NNS_G3dResDefaultRelease
_021584EC:
	ldr r0, _02158528 // =exBossFireBlueTask__ActiveInstanceCount
	ldr r0, [r0, #0x24]
	cmp r0, #0
	beq _02158500
	bl _FreeHEAP_USER
_02158500:
	ldr r0, _02158528 // =exBossFireBlueTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x24]
_0215850C:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _02158528 // =exBossFireBlueTask__ActiveInstanceCount
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158528: .word exBossFireBlueTask__ActiveInstanceCount
	arm_func_end ovl09_2158474

	arm_func_start exBossFireBlueTask__Main
exBossFireBlueTask__Main: // 0x0215852C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _021585D8 // =exBossFireBlueTask__ActiveInstanceCount
	str r0, [r1, #0xc]
	add r0, r4, #0x2c
	bl ovl09_21581D4
	add r0, r4, #0x3b8
	mov r1, #0xa800
	bl ovl09_21641E8
	add r0, r4, #0x3b8
	bl ovl09_2164218
	ldr r0, [r4, #0x28]
	mov ip, #0xc3
	ldr r1, [r0, #0x3ec]
	mov lr, #0x3c000
	str r1, [r4, #0x37c]
	ldr r1, [r4, #0x28]
	mov r0, #0
	ldr r2, [r1, #0x3f0]
	sub r1, ip, #0xc4
	str r2, [r4, #0x380]
	ldr r3, [r4, #0x28]
	mov r2, r1
	ldr r5, [r3, #0x3f4]
	mov r3, r1
	str r5, [r4, #0x384]
	ldr r5, [r4, #0x28]
	ldr r5, [r5, #0x48]
	str r5, [r4, #0x10]
	ldr r5, [r4, #0x28]
	ldr r5, [r5, #0x4c]
	str r5, [r4, #0x14]
	str lr, [r4, #0x18]
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _021585DC // =ovl09_215862C
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021585D8: .word exBossFireBlueTask__ActiveInstanceCount
_021585DC: .word ovl09_215862C
	arm_func_end exBossFireBlueTask__Main

	arm_func_start exBossFireBlueTask__Func8
exBossFireBlueTask__Func8: // 0x021585E0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_2172AE0
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02158604 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02158604: .word ExTask_State_Destroy
	arm_func_end exBossFireBlueTask__Func8

	arm_func_start exBossFireBlueTask__Destructor
exBossFireBlueTask__Destructor: // 0x02158608
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x2c
	bl ovl09_2158474
	ldr r0, _02158628 // =exBossFireBlueTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0xc]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02158628: .word exBossFireBlueTask__ActiveInstanceCount
	arm_func_end exBossFireBlueTask__Destructor

	arm_func_start ovl09_215862C
ovl09_215862C: // 0x0215862C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl ovl09_2162164
	ldrb r1, [r4, #0x32]
	mov r0, r1, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _02158670
	ldrb r0, [r4, #0x2c]
	cmp r0, #2
	bne _02158664
	bl ovl09_21589B8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02158664:
	bic r0, r1, #1
	strb r0, [r4, #0x32]
	b _0215868C
_02158670:
	mov r0, r1, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _0215868C
	bl GetExTaskCurrent
	ldr r1, _02158878 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0215868C:
	ldr r3, [r4, #0x37c]
	ldr r0, [r4, #0x10]
	ldr ip, _0215887C // =0x0000019A
	sub r0, r0, r3
	umull r2, r1, r0, ip
	mov lr, #0
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
	ldr r2, _02158880 // =0x00000F5E
	ldr r3, _02158884 // =0x0000065D
	ble _021587DC
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
	b _02158820
_021587DC:
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
_02158820:
	cmp r0, #0xf000
	bge _02158830
	bl ovl09_2158888
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02158830:
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
_02158878: .word ExTask_State_Destroy
_0215887C: .word 0x0000019A
_02158880: .word 0x00000F5E
_02158884: .word 0x0000065D
	arm_func_end ovl09_215862C

	arm_func_start ovl09_2158888
ovl09_2158888: // 0x02158888
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, _021588A4 // =ovl09_21588A8
	str r1, [r0]
	bl ovl09_21588A8
	ldmia sp!, {r3, pc}
	.align 2, 0
_021588A4: .word ovl09_21588A8
	arm_func_end ovl09_2158888

	arm_func_start ovl09_21588A8
ovl09_21588A8: // 0x021588A8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl ovl09_2162164
	ldrb r1, [r4, #0x32]
	mov r0, r1, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _021588EC
	ldrb r0, [r4, #0x2c]
	cmp r0, #2
	bne _021588E0
	bl ovl09_21589B8
	ldmia sp!, {r4, pc}
_021588E0:
	bic r0, r1, #1
	strb r0, [r4, #0x32]
	b _02158908
_021588EC:
	mov r0, r1, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02158908
	bl GetExTaskCurrent
	ldr r1, _021589B4 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02158908:
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
	bge _02158980
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _02158980
	ldr r1, [r4, #0x380]
	cmp r1, #0xc8000
	bge _02158980
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _02158990
_02158980:
	bl GetExTaskCurrent
	ldr r1, _021589B4 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02158990:
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
_021589B4: .word ExTask_State_Destroy
	arm_func_end ovl09_21588A8

	arm_func_start ovl09_21589B8
ovl09_21589B8: // 0x021589B8
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
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02158A5C
	ldrsh r0, [r4, #0x34]
	ldr r2, [r4, #8]
	cmp r0, #6
	bne _02158A2C
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _02158AD0
_02158A2C:
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
	b _02158AD0
_02158A5C:
	bl exSysTask__GetStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _02158AD0
	ldrsh r0, [r4, #0x34]
	ldr r2, [r4, #8]
	cmp r0, #7
	bne _02158AA4
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _02158AD0
_02158AA4:
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
_02158AD0:
	ldr r1, [r4, #8]
	mov r0, #0
	rsb r1, r1, #0
	str r1, [r4, #8]
	ldr r2, _02158B4C // =0x00007FF8
	str r0, [r4, #0xc]
	add r1, r4, #0x300
	strh r2, [r1, #0x76]
	strh r0, [r1, #0x78]
	strh r0, [r1, #0x7a]
	ldr r2, _02158B50 // =0x00001554
	ldr r3, _02158B54 // =_mt_math_rand
	strh r2, [r4, #0x20]
	ldr ip, [r3]
	ldr r1, _02158B58 // =0x00196225
	ldr r2, _02158B5C // =0x3C6EF35F
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
	ldr r1, _02158B60 // =ovl09_2158B64
	str r1, [r0]
	bl ovl09_2158B64
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158B4C: .word 0x00007FF8
_02158B50: .word 0x00001554
_02158B54: .word _mt_math_rand
_02158B58: .word 0x00196225
_02158B5C: .word 0x3C6EF35F
_02158B60: .word ovl09_2158B64
	arm_func_end ovl09_21589B8

	arm_func_start ovl09_2158B64
ovl09_2158B64: // 0x02158B64
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl ovl09_2162164
	ldrb r0, [r4, #0x32]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _02158B98
	bl GetExTaskCurrent
	ldr r1, _02158C58 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02158B98:
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02158BB4
	bl GetExTaskCurrent
	ldr r1, _02158C58 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02158BB4:
	ldr r0, [r4, #0x24]
	cmp r0, #0
	add r0, r4, #0x300
	ldreqh r2, [r0, #0x7a]
	ldreqh r1, [r4, #0x20]
	subeq r1, r2, r1
	beq _02158BDC
	ldrh r2, [r0, #0x7a]
	ldrh r1, [r4, #0x20]
	add r1, r2, r1
_02158BDC:
	strh r1, [r0, #0x7a]
	ldr r1, [r4, #0x380]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #0x380]
	ldr r1, [r4, #0x37c]
	cmp r1, #0x5a000
	bge _02158C24
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _02158C24
	ldr r1, [r4, #0x380]
	cmp r1, #0xc8000
	bge _02158C24
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _02158C34
_02158C24:
	bl GetExTaskCurrent
	ldr r1, _02158C58 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02158C34:
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
_02158C58: .word ExTask_State_Destroy
	arm_func_end ovl09_2158B64

	arm_func_start exBossFireBlueTask__Create
exBossFireBlueTask__Create: // 0x02158C5C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _02158CD0 // =0x00000508
	str r4, [sp]
	ldr r0, _02158CD4 // =aExbossfireblue
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02158CD8 // =exBossFireBlueTask__Main
	ldr r1, _02158CDC // =exBossFireBlueTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _02158CD0 // =0x00000508
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x28]
	mov r0, r5
	bl GetExTask
	ldr r1, _02158CE0 // =exBossFireBlueTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02158CD0: .word 0x00000508
_02158CD4: .word aExbossfireblue
_02158CD8: .word exBossFireBlueTask__Main
_02158CDC: .word exBossFireBlueTask__Destructor
_02158CE0: .word exBossFireBlueTask__Func8
	arm_func_end exBossFireBlueTask__Create

	.data
	
aExtraExBb_3: // 0x0217406C
	.asciz "/extra/ex.bb"
	.align 4
	
aExbossfireblue: // 0x0217407C
	.asciz "exBossFireBlueTask"