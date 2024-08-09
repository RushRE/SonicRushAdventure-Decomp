	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ovl09_21602D4
ovl09_21602D4: // 0x021602D4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _02160530 // =0x02176284
	mov r4, r0
	str r4, [r1, #0x14]
	ldr r0, [r1, #0x10]
	cmp r0, #0
	ldrne r0, [r1, #4]
	cmpne r0, #0
	beq _02160350
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _02160530 // =0x02176284
	ldr r1, [r1, #0x10]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02160530 // =0x02176284
	ldr r1, [r1, #4]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _02160530 // =0x02176284
	ldr r1, [r1, #0x10]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02160350:
	mov r0, r4
	bl ovl09_2161CB0
	ldr r0, _02160530 // =0x02176284
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _02160414
	mov r1, #0x10
	ldr r0, _02160534 // =aExtraExBb_6
	sub r2, r1, #0x11
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5]
	ldr r1, _02160530 // =0x02176284
	mov r0, r0, lsr #8
	str r0, [r1, #0x10]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02160530 // =0x02176284
	mov r0, r5
	str r1, [r2, #0x1c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x2f
	bl ovl09_21733D4
	ldr r1, _02160530 // =0x02176284
	mov r2, #0
	str r0, [r1, #0x44]
	mov r0, #0x30
	str r2, [r1, #0x54]
	bl ovl09_21733D4
	ldr r1, _02160530 // =0x02176284
	mov r2, #1
	str r0, [r1, #0x48]
	mov r0, #0x31
	str r2, [r1, #0x58]
	bl ovl09_21733D4
	ldr r1, _02160530 // =0x02176284
	mov r2, #3
	str r0, [r1, #0x4c]
	mov r0, #0x32
	str r2, [r1, #0x5c]
	bl ovl09_21733D4
	ldr r1, _02160530 // =0x02176284
	mov r2, #4
	str r0, [r1, #0x50]
	str r2, [r1, #0x60]
	ldr r0, [r1, #0x1c]
	bl Asset3DSetup__Create
_02160414:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02160530 // =0x02176284
	str r2, [sp]
	ldr r1, [r0, #0x1c]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _02160538 // =0x021762D8
	ldr r5, _0216053C // =0x021762C8
	mov r7, r8
_0216044C:
	str r7, [sp]
	ldr r1, [r6, r8, lsl #2]
	ldr r2, [r5, r8, lsl #2]
	mov r3, r7
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #4
	blo _0216044C
	ldr r1, _02160530 // =0x02176284
	add r0, r4, #0x300
	ldr r2, [r1, #0x54]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x54]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_021604A0:
	mov r0, r2, lsl r3
	tst r0, #0x1b
	beq _021604C0
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_021604C0:
	add r3, r3, #1
	cmp r3, #5
	blo _021604A0
	mov ip, #0
	str ip, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r1, _02160540 // =0x00003FFC
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #2]
	add r2, r4, #0x350
	ldr r1, _02160530 // =0x02176284
	orr r3, r3, #8
	strb r3, [r4, #2]
	str ip, [r4, #0xc]
	str ip, [r4, #0x10]
	str ip, [r4, #0x14]
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #2]
	add r2, r2, #1
	strh r2, [r1, #2]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02160530: .word 0x02176284
_02160534: .word aExtraExBb_6
_02160538: .word 0x021762D8
_0216053C: .word 0x021762C8
_02160540: .word 0x00003FFC
	arm_func_end ovl09_21602D4

	arm_func_start ovl09_2160544
ovl09_2160544: // 0x02160544
	stmdb sp!, {r4, lr}
	ldr r1, _021605F8 // =0x02176284
	mov r4, r0
	ldrsh r0, [r1, #2]
	cmp r0, #1
	bgt _021605DC
	ldr r0, [r1, #0x1c]
	cmp r0, #0
	beq _0216056C
	bl NNS_G3dResDefaultRelease
_0216056C:
	ldr r0, _021605F8 // =0x02176284
	ldr r0, [r0, #0x44]
	cmp r0, #0
	beq _02160580
	bl NNS_G3dResDefaultRelease
_02160580:
	ldr r0, _021605F8 // =0x02176284
	ldr r0, [r0, #0x48]
	cmp r0, #0
	beq _02160594
	bl NNS_G3dResDefaultRelease
_02160594:
	ldr r0, _021605F8 // =0x02176284
	ldr r0, [r0, #0x4c]
	cmp r0, #0
	beq _021605A8
	bl NNS_G3dResDefaultRelease
_021605A8:
	ldr r0, _021605F8 // =0x02176284
	ldr r0, [r0, #0x50]
	cmp r0, #0
	beq _021605BC
	bl NNS_G3dResDefaultRelease
_021605BC:
	ldr r0, _021605F8 // =0x02176284
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	beq _021605D0
	bl _FreeHEAP_USER
_021605D0:
	ldr r0, _021605F8 // =0x02176284
	mov r1, #0
	str r1, [r0, #0x1c]
_021605DC:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _021605F8 // =0x02176284
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021605F8: .word 0x02176284
	arm_func_end ovl09_2160544

	arm_func_start exBossMagmeWaveTask__Main
exBossMagmeWaveTask__Main: // 0x021605FC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02160660 // =0x02176284
	str r0, [r1, #8]
	add r0, r4, #0x14
	bl ovl09_21602D4
	add r0, r4, #0x3a0
	mov r1, #0xa800
	bl ovl09_21641E8
	add r0, r4, #0x3a0
	bl ovl09_21641F0
	ldr r1, [r4, #0x10]
	mov r0, #0
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x364]
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x368]
	str r0, [r4, #0x36c]
	bl GetExTaskCurrent
	ldr r1, _02160664 // =ovl09_21606B4
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160660: .word 0x02176284
_02160664: .word ovl09_21606B4
	arm_func_end exBossMagmeWaveTask__Main

	arm_func_start exBossMagmeWaveTask__Func8
exBossMagmeWaveTask__Func8: // 0x02160668
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_2172AE0
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0216068C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216068C: .word ExTask_State_Destroy
	arm_func_end exBossMagmeWaveTask__Func8

	arm_func_start exBossMagmeWaveTask__Destructor
exBossMagmeWaveTask__Destructor: // 0x02160690
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x14
	bl ovl09_2160544
	ldr r0, _021606B0 // =0x02176284
	mov r1, #0
	str r1, [r0, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021606B0: .word 0x02176284
	arm_func_end exBossMagmeWaveTask__Destructor

	arm_func_start ovl09_21606B4
ovl09_21606B4: // 0x021606B4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x14
	bl ovl09_2162164
	add r0, r4, #0x14
	bl ovl09_21623F8
	cmp r0, #0
	beq _021606E8
	bl GetExTaskCurrent
	ldr r1, _02160704 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021606E8:
	add r0, r4, #0x14
	add r1, r4, #0x3a0
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160704: .word ExTask_State_Destroy
	arm_func_end ovl09_21606B4

	arm_func_start exBossMagmeWaveTask__Create
exBossMagmeWaveTask__Create: // 0x02160708
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x4f0
	ldr r0, _0216077C // =aExbossmagmewav
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02160780 // =exBossMagmeWaveTask__Main
	ldr r1, _02160784 // =exBossMagmeWaveTask__Destructor
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
	str r0, [r4, #0x10]
	mov r0, r5
	bl GetExTask
	ldr r1, _02160788 // =exBossMagmeWaveTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216077C: .word aExbossmagmewav
_02160780: .word exBossMagmeWaveTask__Main
_02160784: .word exBossMagmeWaveTask__Destructor
_02160788: .word exBossMagmeWaveTask__Func8
	arm_func_end exBossMagmeWaveTask__Create

	.data
	
aExbossmagmewav: // 0x021743BC
	.asciz "exBossMagmeWaveTask"