	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ovl09_21565A8
ovl09_21565A8: // 0x021565A8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _02156838 // =0x02175FC4
	mov r5, r0
	str r5, [r1, #0x94]
	ldr r0, [r1, #0x30]
	cmp r0, #0
	ldrne r0, [r1, #0x88]
	cmpne r0, #0
	beq _02156624
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _02156838 // =0x02175FC4
	ldr r1, [r1, #0x30]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02156838 // =0x02175FC4
	ldr r1, [r1, #0x88]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _02156838 // =0x02175FC4
	ldr r1, [r1, #0x30]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02156624:
	mov r0, r5
	bl ovl09_2161CB0
	ldr r0, _02156838 // =0x02175FC4
	ldrsh r0, [r0, #8]
	cmp r0, #0
	bne _021566E8
	mov r1, #0x1f
	ldr r0, _0215683C // =aExtraExBb_2
	sub r2, r1, #0x20
	bl ReadFileFromBundle
	mov r4, r0
	ldr r0, [r4]
	ldr r1, _02156838 // =0x02175FC4
	mov r0, r0, lsr #8
	str r0, [r1, #0x30]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02156838 // =0x02175FC4
	mov r0, r4
	str r1, [r2, #0x98]
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	mov r0, #0x51
	bl ovl09_21733D4
	ldr r1, _02156838 // =0x02175FC4
	mov r2, #0
	str r0, [r1, #0x124]
	mov r0, #0x52
	str r2, [r1, #0x104]
	bl ovl09_21733D4
	ldr r1, _02156838 // =0x02175FC4
	mov r2, #1
	str r0, [r1, #0x128]
	mov r0, #0x53
	str r2, [r1, #0x108]
	bl ovl09_21733D4
	ldr r1, _02156838 // =0x02175FC4
	mov r2, #3
	str r0, [r1, #0x12c]
	mov r0, #0x54
	str r2, [r1, #0x10c]
	bl ovl09_21733D4
	ldr r1, _02156838 // =0x02175FC4
	mov r2, #2
	str r0, [r1, #0x130]
	str r2, [r1, #0x110]
	ldr r0, [r1, #0x98]
	bl Asset3DSetup__Create
_021566E8:
	add r0, r5, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02156838 // =0x02175FC4
	str r2, [sp]
	ldr r1, [r0, #0x98]
	mov r3, r2
	add r0, r5, #0x20
	bl AnimatorMDL__SetResource
	mov r4, #0
	ldr r7, _02156840 // =0x021760C8
	ldr r6, _02156844 // =0x021760E8
	mov r8, r4
_02156720:
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
	blo _02156720
	ldr r0, _02156838 // =0x02175FC4
	ldr r0, [r0, #0x98]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r1, _02156840 // =0x021760C8
	ldr r0, _02156844 // =0x021760E8
	ldr r1, [r1, r4, lsl #2]
	ldr r2, [r0, r4, lsl #2]
	add r0, r5, #0x20
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, _02156838 // =0x02175FC4
	add r0, r5, #0x300
	ldr r2, [r1, #0x104]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x104]
	mov r2, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r5, #0x344]
_021567A0:
	mov r0, r2, lsl r3
	tst r0, #0xf
	beq _021567C0
	add r0, r5, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_021567C0:
	add r3, r3, #1
	cmp r3, #5
	blo _021567A0
	mov r0, #0
	str r0, [r5, #0x358]
	mov r4, #0x1000
	str r4, [r5, #0x368]
	str r4, [r5, #0x36c]
	ldr r2, _02156848 // =0x0000BFF4
	str r4, [r5, #0x370]
	add r0, r5, #0x300
	ldr r1, _0215684C // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r5]
	ldrb r3, [r5, #1]
	add r2, r5, #0x350
	ldr r1, _02156838 // =0x02175FC4
	orr r3, r3, #0x20
	strb r3, [r5, #1]
	str r4, [r5, #0xc]
	str r4, [r5, #0x10]
	str r4, [r5, #0x14]
	str r2, [r5, #0x18]
	ldrsh r2, [r1, #8]
	add r2, r2, #1
	strh r2, [r1, #8]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02156838: .word 0x02175FC4
_0215683C: .word aExtraExBb_2
_02156840: .word 0x021760C8
_02156844: .word 0x021760E8
_02156848: .word 0x0000BFF4
_0215684C: .word 0x00007FF8
	arm_func_end ovl09_21565A8

	arm_func_start ovl09_2156850
ovl09_2156850: // 0x02156850
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r7, #0
	ldr r5, _0215691C // =0x021760C8
	ldr r4, _02156920 // =0x021760E8
	mov r9, r0
	mov r8, r1
	mov r6, r7
_0215686C:
	str r6, [sp]
	ldr r1, [r5, r7, lsl #2]
	ldr r2, [r4, r7, lsl #2]
	mov r3, r8
	add r0, r9, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #3
	blo _0215686C
	ldr r0, _02156924 // =0x02175FC4
	ldr r0, [r0, #0x98]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r1, _0215691C // =0x021760C8
	ldr r0, _02156920 // =0x021760E8
	ldr r1, [r1, r7, lsl #2]
	ldr r2, [r0, r7, lsl #2]
	mov r3, r8
	add r0, r9, #0x20
	bl AnimatorMDL__SetAnimation
	ldr r1, _02156924 // =0x02175FC4
	add r0, r9, #0x300
	ldr r2, [r1, #0x104]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x104]
	mov r2, #1
	add r0, r9, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r9, #0x344]
_021568EC:
	mov r0, r2, lsl r3
	tst r0, #0xf
	beq _0215690C
	add r0, r9, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215690C:
	add r3, r3, #1
	cmp r3, #5
	blo _021568EC
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0215691C: .word 0x021760C8
_02156920: .word 0x021760E8
_02156924: .word 0x02175FC4
	arm_func_end ovl09_2156850

	arm_func_start ovl09_2156928
ovl09_2156928: // 0x02156928
	stmdb sp!, {r4, lr}
	ldr r1, _021569DC // =0x02175FC4
	mov r4, r0
	ldrsh r0, [r1, #8]
	cmp r0, #1
	bgt _021569C0
	ldr r0, [r1, #0x98]
	cmp r0, #0
	beq _02156950
	bl NNS_G3dResDefaultRelease
_02156950:
	ldr r0, _021569DC // =0x02175FC4
	ldr r0, [r0, #0x124]
	cmp r0, #0
	beq _02156964
	bl NNS_G3dResDefaultRelease
_02156964:
	ldr r0, _021569DC // =0x02175FC4
	ldr r0, [r0, #0x128]
	cmp r0, #0
	beq _02156978
	bl NNS_G3dResDefaultRelease
_02156978:
	ldr r0, _021569DC // =0x02175FC4
	ldr r0, [r0, #0x12c]
	cmp r0, #0
	beq _0215698C
	bl NNS_G3dResDefaultRelease
_0215698C:
	ldr r0, _021569DC // =0x02175FC4
	ldr r0, [r0, #0x130]
	cmp r0, #0
	beq _021569A0
	bl NNS_G3dResDefaultRelease
_021569A0:
	ldr r0, _021569DC // =0x02175FC4
	ldr r0, [r0, #0x98]
	cmp r0, #0
	beq _021569B4
	bl _FreeHEAP_USER
_021569B4:
	ldr r0, _021569DC // =0x02175FC4
	mov r1, #0
	str r1, [r0, #0x98]
_021569C0:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _021569DC // =0x02175FC4
	ldrsh r1, [r0, #8]
	sub r1, r1, #1
	strh r1, [r0, #8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021569DC: .word 0x02175FC4
	arm_func_end ovl09_2156928

	arm_func_start exBossEffectFireBallTask__Main
exBossEffectFireBallTask__Main: // 0x021569E0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02156A58 // =0x02175FC4
	str r0, [r1, #0x84]
	add r0, r4, #4
	bl ovl09_21565A8
	add r0, r4, #0x390
	mov r1, #0xa800
	bl ovl09_21641E8
	add r0, r4, #0x390
	bl ovl09_21641F0
	mov r2, #1
	ldr r1, _02156A58 // =0x02175FC4
	mov r0, #0
	str r2, [r1, #0x80]
	str r0, [sp]
	mov r1, #0xbf
	str r1, [sp, #4]
	sub r1, r1, #0xc0
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _02156A5C // =ovl09_2156AC4
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156A58: .word 0x02175FC4
_02156A5C: .word ovl09_2156AC4
	arm_func_end exBossEffectFireBallTask__Main

	arm_func_start exBossEffectFireBallTask__Func8
exBossEffectFireBallTask__Func8: // 0x02156A60
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_2172AE0
	cmp r0, #0
	beq _02156A80
	bl GetExTaskCurrent
	ldr r1, _02156A9C // =ExTask_State_Destroy
	str r1, [r0]
_02156A80:
	bl ovl09_2154C28
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02156A9C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156A9C: .word ExTask_State_Destroy
	arm_func_end exBossEffectFireBallTask__Func8

	arm_func_start exBossEffectFireBallTask__Destructor
exBossEffectFireBallTask__Destructor: // 0x02156AA0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl ovl09_2156928
	ldr r0, _02156AC0 // =0x02175FC4
	mov r1, #0
	str r1, [r0, #0x84]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156AC0: .word 0x02175FC4
	arm_func_end exBossEffectFireBallTask__Destructor

	arm_func_start ovl09_2156AC4
ovl09_2156AC4: // 0x02156AC4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl ovl09_2162164
	bl ovl09_215F014
	cmp r0, #0
	bne _02156AF4
	bl GetExTaskCurrent
	ldr r1, _02156B4C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02156AF4:
	ldr r1, [r4, #0x4e0]
	add r0, r4, #4
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	bl ovl09_21623F8
	cmp r0, #0
	beq _02156B30
	bl ovl09_2156B50
	ldmia sp!, {r4, pc}
_02156B30:
	add r0, r4, #4
	add r1, r4, #0x390
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156B4C: .word ExTask_State_Destroy
	arm_func_end ovl09_2156AC4

	arm_func_start ovl09_2156B50
ovl09_2156B50: // 0x02156B50
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	mov r1, #1
	bl ovl09_2156850
	add r0, r4, #0x390
	bl ovl09_2164218
	bl GetExTaskCurrent
	ldr r1, _02156B84 // =ovl09_2156B88
	str r1, [r0]
	bl ovl09_2156B88
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156B84: .word ovl09_2156B88
	arm_func_end ovl09_2156B50

	arm_func_start ovl09_2156B88
ovl09_2156B88: // 0x02156B88
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl ovl09_2162164
	bl ovl09_215F014
	cmp r0, #0
	bne _02156BB8
	bl GetExTaskCurrent
	ldr r1, _02156C10 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02156BB8:
	ldr r1, [r4, #0x4e0]
	ldr r0, _02156C14 // =0x02175FC4
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	ldr r0, [r0, #0x80]
	cmp r0, #0
	bne _02156BF4
	bl ovl09_2156C18
	ldmia sp!, {r4, pc}
_02156BF4:
	add r0, r4, #4
	add r1, r4, #0x390
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156C10: .word ExTask_State_Destroy
_02156C14: .word 0x02175FC4
	arm_func_end ovl09_2156B88

	arm_func_start ovl09_2156C18
ovl09_2156C18: // 0x02156C18
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	mov r1, #2
	bl ovl09_2156850
	add r0, r4, #0x390
	bl ovl09_21641F0
	bl GetExTaskCurrent
	ldr r1, _02156C4C // =ovl09_2156C50
	str r1, [r0]
	bl ovl09_2156C50
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156C4C: .word ovl09_2156C50
	arm_func_end ovl09_2156C18

	arm_func_start ovl09_2156C50
ovl09_2156C50: // 0x02156C50
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl ovl09_2162164
	bl ovl09_215F014
	cmp r0, #0
	bne _02156C80
	bl GetExTaskCurrent
	ldr r1, _02156CE0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02156C80:
	ldr r1, [r4, #0x4e0]
	add r0, r4, #4
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	bl ovl09_21623F8
	cmp r0, #0
	beq _02156CC4
	bl GetExTaskCurrent
	ldr r1, _02156CE0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02156CC4:
	add r0, r4, #4
	add r1, r4, #0x390
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156CE0: .word ExTask_State_Destroy
	arm_func_end ovl09_2156C50

	arm_func_start exBossEffectFireBallTask__Create
exBossEffectFireBallTask__Create: // 0x02156CE4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _02156D58 // =0x000004E4
	str r4, [sp]
	ldr r0, _02156D5C // =aExbosseffectfi_1
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02156D60 // =exBossEffectFireBallTask__Main
	ldr r1, _02156D64 // =exBossEffectFireBallTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _02156D58 // =0x000004E4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x4e0]
	mov r0, r5
	bl GetExTask
	ldr r1, _02156D68 // =exBossEffectFireBallTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02156D58: .word 0x000004E4
_02156D5C: .word aExbosseffectfi_1
_02156D60: .word exBossEffectFireBallTask__Main
_02156D64: .word exBossEffectFireBallTask__Destructor
_02156D68: .word exBossEffectFireBallTask__Func8
	arm_func_end exBossEffectFireBallTask__Create

	.data
	
aExbosseffectfi_1: // 0x02174008
	.asciz "exBossEffectFireBallTask"