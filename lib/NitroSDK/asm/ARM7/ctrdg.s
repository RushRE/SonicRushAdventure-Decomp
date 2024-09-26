	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CTRDGi_SendtoPxi
CTRDGi_SendtoPxi: // 0x03806E44
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, #1
	mov r5, #0xd
	mov r4, #0
	b _03806E68
_03806E60:
	mov r0, r6
	bl SVC_WaitByLoop_ARM
_03806E68:
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	bne _03806E60
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end CTRDGi_SendtoPxi

	arm_func_start CTRDGi_UnlockByProcessor
CTRDGi_UnlockByProcessor: // 0x03806E8C
	stmdb sp!, {r4, lr}
	mov r4, r1
	ldr r1, [r4]
	cmp r1, #0
	bne _03806EA4
	bl OS_UnLockCartridge
_03806EA4:
	ldr r0, [r4, #4]
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end CTRDGi_UnlockByProcessor

	arm_func_start CTRDGi_LockByProcessor
CTRDGi_LockByProcessor: // 0x03806EB4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl OS_DisableInterrupts
	str r0, [r4, #4]
	ldr r0, _03806F10 // =0x027FFFE8
	bl OS_ReadOwnerOfLockWord
	and r0, r0, #0x80
	str r0, [r4]
	ldr r0, [r4]
	cmp r0, #0
	bne _03806EF8
	mov r0, r5
	bl OS_TryLockCard
	cmp r0, #0
	bne _03806F00
_03806EF8:
	mov r0, #1
	b _03806F04
_03806F00:
	mov r0, #0
_03806F04:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_03806F10: .word 0x027FFFE8
	arm_func_end CTRDGi_LockByProcessor

	arm_func_start CTRDGi_RestoreAccessCycle
CTRDGi_RestoreAccessCycle: // 0x03806F14
	ldr r3, [r0]
	ldr r2, _03806F44 // =0x04000204
	ldrh r1, [r2]
	bic r1, r1, #0xc
	orr r1, r1, r3, lsl #2
	strh r1, [r2]
	ldr r1, [r0, #4]
	ldrh r0, [r2]
	bic r0, r0, #0x10
	orr r0, r0, r1, lsl #4
	strh r0, [r2]
	bx lr
	.align 2, 0
_03806F44: .word 0x04000204
	arm_func_end CTRDGi_RestoreAccessCycle

	arm_func_start CTRDGi_ChangeLatestAccessCycle
CTRDGi_ChangeLatestAccessCycle: // 0x03806F48
	ldr r2, _03806F8C // =0x04000204
	ldrh r1, [r2]
	and r1, r1, #0xc
	mov r1, r1, asr #2
	str r1, [r0]
	ldrh r1, [r2]
	and r1, r1, #0x10
	mov r1, r1, asr #4
	str r1, [r0, #4]
	ldrh r0, [r2]
	bic r0, r0, #0xc
	orr r0, r0, #0xc
	strh r0, [r2]
	ldrh r0, [r2]
	bic r0, r0, #0x10
	strh r0, [r2]
	bx lr
	.align 2, 0
_03806F8C: .word 0x04000204
	arm_func_end CTRDGi_ChangeLatestAccessCycle

	arm_func_start CTRDG_IsExisting
CTRDG_IsExisting: // 0x03806F90
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #1
	ldr r2, _038070A4 // =0x027FFC30
	ldrh r1, [r2]
	ldr r0, _038070A8 // =0x0000FFFF
	cmp r1, r0
	moveq r0, #0
	beq _03807098
	ldrb r0, [r2, #5]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	moveq r0, #0
	beq _03807098
	ldr r0, _038070AC // =0x0380BBC8
	ldrh r0, [r0, #2]
	add r1, sp, #0
	bl CTRDGi_LockByProcessor
	cmp r0, #0
	bne _03806FF4
	ldr r0, [sp, #4]
	bl OS_RestoreInterrupts
	mov r0, r4
	b _03807098
_03806FF4:
	add r0, sp, #8
	bl CTRDGi_ChangeLatestAccessCycle
	mov r2, #0x8000000
	ldrb r3, [r2, #0xb2]
	cmp r3, #0x96
	bne _03807020
	ldr r0, _038070A4 // =0x027FFC30
	ldrh r1, [r0]
	ldrh r0, [r2, #0xbe]
	cmp r1, r0
	bne _03807068
_03807020:
	cmp r3, #0x96
	beq _03807040
	ldr r0, _038070A4 // =0x027FFC30
	ldrh r1, [r0]
	ldr r0, _038070B0 // =0x0801FFFE
	ldrh r0, [r0]
	cmp r1, r0
	bne _03807068
_03807040:
	ldr r2, _038070A4 // =0x027FFC30
	ldr r1, [r2, #8]
	mov r0, #0x8000000
	ldr r0, [r0, #0xac]
	cmp r1, r0
	beq _0380707C
	ldrb r0, [r2, #5]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _0380707C
_03807068:
	ldr r1, _038070A4 // =0x027FFC30
	ldrb r0, [r1, #5]
	orr r0, r0, #2
	strb r0, [r1, #5]
	mov r4, #0
_0380707C:
	add r0, sp, #8
	bl CTRDGi_RestoreAccessCycle
	ldr r0, _038070AC // =0x0380BBC8
	ldrh r0, [r0, #2]
	add r1, sp, #0
	bl CTRDGi_UnlockByProcessor
	mov r0, r4
_03807098:
	add sp, sp, #0x10
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_038070A4: .word 0x027FFC30
_038070A8: .word 0x0000FFFF
_038070AC: .word 0x0380BBC8
_038070B0: .word 0x0801FFFE
	arm_func_end CTRDG_IsExisting

	arm_func_start CTRDG_IsPulledOut
CTRDG_IsPulledOut: // 0x038070B4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _03807104 // =0x027FFC30
	ldrh r1, [r2]
	ldr r0, _03807108 // =0x0000FFFF
	cmp r1, r0
	moveq r0, #0
	beq _038070F8
	ldrb r0, [r2, #5]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _038070E8
	bl CTRDG_IsExisting
_038070E8:
	ldr r0, _03807104 // =0x027FFC30
	ldrb r0, [r0, #5]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
_038070F8:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03807104: .word 0x027FFC30
_03807108: .word 0x0000FFFF
	arm_func_end CTRDG_IsPulledOut

	arm_func_start CTRDGi_InitCommon
CTRDGi_InitCommon: // 0x0380710C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	str r0, [sp]
	add r0, sp, #0
	ldr r1, _03807144 // =0x0380BBC8
	ldr r2, _03807148 // =0x05000001
	bl _Ven__SVC_CpuSet
	bl OS_GetLockID
	ldr r1, _03807144 // =0x0380BBC8
	strh r0, [r1, #2]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03807144: .word 0x0380BBC8
_03807148: .word 0x05000001
	arm_func_end CTRDGi_InitCommon

	arm_func_start _Ven__SVC_CpuSet
_Ven__SVC_CpuSet: // 0x0380714C
	ldr ip, _03807154 // =SVC_CpuSet
	bx ip
	.align 2, 0
_03807154: .word SVC_CpuSet
	arm_func_end _Ven__SVC_CpuSet

	arm_func_start CTRDGi_CallbackForSetPhi
CTRDGi_CallbackForSetPhi: // 0x03807158
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	and r0, r1, #0x3f
	cmp r0, #3
	bne _038071C4
	ldr r0, _038071D4 // =0x01FFFFC0
	and r0, r1, r0
	mov r2, r0, lsr #6
	ldr r1, _038071D8 // =0x04000204
	ldrh r0, [r1]
	bic r0, r0, #0x60
	orr r0, r0, r2, lsl #5
	strh r0, [r1]
	mov r7, #1
	mov r6, #0x11
	mov r5, #0x12
	mov r4, #0
	b _038071A8
_038071A0:
	mov r0, r7
	bl SVC_WaitByLoop_ARM
_038071A8:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	bne _038071A0
	b _038071C8
_038071C4:
	bl OS_Terminate
_038071C8:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_038071D4: .word 0x01FFFFC0
_038071D8: .word 0x04000204
	arm_func_end CTRDGi_CallbackForSetPhi

	arm_func_start CTRDGi_TerminateARM7
CTRDGi_TerminateARM7: // 0x038071DC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl CTRDG_VibPulseEdgeUpdate
	bl SND_BeginSleep
	bl WVR_Shutdown
	bl OS_Terminate
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CTRDGi_TerminateARM7

	arm_func_start CTRDG_CheckPullOut_Polling
CTRDG_CheckPullOut_Polling: // 0x03807204
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r1, _03807304 // =nextCount_3292
	ldr r3, [r1]
	mvn r0, #0
	cmp r3, r0
	ldreq r0, _03807308 // =0x027FFC3C
	ldreq r0, [r0]
	addeq r0, r0, #0xa
	streq r0, [r1]
	beq _038072F8
	ldr r0, _0380730C // =0x0380BBDC
	ldr r0, [r0]
	cmp r0, #0
	bne _038072F8
	ldr r0, _03807310 // =0x0380BBD8
	ldr r0, [r0]
	cmp r0, #0
	bne _038072F8
	ldr r2, _03807308 // =0x027FFC3C
	ldr r0, [r2]
	cmp r0, r3
	blo _038072F8
	ldr r0, [r2]
	add r0, r0, #0xa
	str r0, [r1]
	bl CTRDG_IsPulledOut
	ldr r1, _03807310 // =0x0380BBD8
	str r0, [r1]
	bl CTRDG_IsExisting
	cmp r0, #0
	bne _038072AC
	ldr r0, _03807314 // =isFirstCheck_3294
	ldr r0, [r0]
	cmp r0, #0
	movne r1, #1
	ldrne r0, _0380730C // =0x0380BBDC
	strne r1, [r0]
	bne _038072F8
	mov r1, #1
	ldr r0, _03807310 // =0x0380BBD8
	str r1, [r0]
_038072AC:
	mov r7, #0
	ldr r0, _03807314 // =isFirstCheck_3294
	str r7, [r0]
	ldr r0, _03807310 // =0x0380BBD8
	ldr r0, [r0]
	cmp r0, #0
	beq _038072F8
	mov r6, #0x64
	mov r5, #0xd
	mov r4, #0x11
	b _038072E0
_038072D8:
	mov r0, r6
	bl OS_Sleep
_038072E0:
	mov r0, r5
	mov r1, r4
	mov r2, r7
	bl PXI_SendWordByFifo
	cmp r0, #0
	bne _038072D8
_038072F8:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_03807304: .word nextCount_3292
_03807308: .word 0x027FFC3C
_0380730C: .word 0x0380BBDC
_03807310: .word 0x0380BBD8
_03807314: .word isFirstCheck_3294
	arm_func_end CTRDG_CheckPullOut_Polling

	arm_func_start CTRDGi_IsNinLogoOfAgb
CTRDGi_IsNinLogoOfAgb: // 0x03807318
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	mov r0, #0x8000000
	add r6, r0, #4
	mov r4, #1
	bl OS_GetLockID
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	mov r0, r5
	bl OS_LockCartridge
	mov r1, #0
	ldr r0, _038073C0 // =0x0000FFFF
	eor r2, r0, #3
	mov r2, r2, lsl #0x10
	mov lr, r2, lsr #0x10
	eor r2, r0, #0x84
	mov r2, r2, lsl #0x10
	mov r8, r2, lsr #0x10
	b _0380739C
_03807364:
	mov ip, r0
	cmp r1, #0x4c
	moveq ip, r8
	beq _0380737C
	cmp r1, #0x4d
	moveq ip, lr
_0380737C:
	mov r3, r1, lsl #1
	ldrh r2, [r7, r3]
	and ip, ip, r2
	ldrh r2, [r6, r3]
	cmp ip, r2
	movne r4, #0
	bne _038073A4
	add r1, r1, #1
_0380739C:
	cmp r1, #0x4e
	blt _03807364
_038073A4:
	mov r0, r5
	bl OS_UnLockCartridge
	mov r0, r5
	bl OS_ReleaseLockID
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_038073C0: .word 0x0000FFFF
	arm_func_end CTRDGi_IsNinLogoOfAgb

	arm_func_start CTRDGi_VibOnOff
CTRDGi_VibOnOff: // 0x038073C4
	ldr r1, _038073D8 // =0x0380BBD0
	str r0, [r1]
	ldr r1, _038073DC // =0x08001000
	strh r0, [r1]
	bx lr
	.align 2, 0
_038073D8: .word 0x0380BBD0
_038073DC: .word 0x08001000
	arm_func_end CTRDGi_VibOnOff

	arm_func_start CTRDG_VibPulseEdgeUpdate
CTRDG_VibPulseEdgeUpdate: // 0x038073E0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	movs r5, r0
	beq _03807420
	ldr r0, [r5]
	cmp r0, #0
	bne _03807420
	ldr r0, [r5, #0x44]
	add r0, r0, #1
	str r0, [r5, #0x44]
	ldr r1, [r5, #0x40]
	cmp r1, #0
	beq _03807420
	ldr r0, [r5, #0x44]
	cmp r0, r1
	movhi r5, #0
_03807420:
	cmp r5, #0
	beq _03807434
	ldr r0, [r5, #0x3c]
	cmp r0, #0
	bne _038074CC
_03807434:
	bl OS_DisableInterrupts
	mov r9, r0
	ldr r0, _038075EC // =0x0380BBD0
	ldr r0, [r0]
	cmp r0, #2
	bne _038074B8
	mov r8, #0
	ldr r7, _038075F0 // =0x027FFFE8
	ldr r4, _038075F4 // =0x0380BBCC
	ldr r11, _038075F8 // =0x000080E8
	mov r6, r8
	mov r5, #1
	b _038074B0
_03807468:
	mov r0, r7
	bl OS_ReadOwnerOfLockWord
	ands r10, r0, #0x80
	bne _03807488
	ldrh r0, [r4]
	bl OS_TryLockCard
	cmp r0, #0
	bne _038074A8
_03807488:
	mov r0, r6
	bl CTRDGi_VibOnOff
	mov r8, r5
	cmp r10, #0
	bne _038074B0
	ldrh r0, [r4]
	bl OS_UnlockCard
	b _038074B0
_038074A8:
	mov r0, r11
	bl OS_SpinWait
_038074B0:
	cmp r8, #0
	beq _03807468
_038074B8:
	ldr r0, _038075FC // =0x0380BBFC
	bl OS_CancelAlarm
	mov r0, r9
	bl OS_RestoreInterrupts
	b _038075E0
_038074CC:
	cmp r5, #0
	beq _038075E0
	ldr r0, _038075F0 // =0x027FFFE8
	bl OS_ReadOwnerOfLockWord
	ands r4, r0, #0x80
	bne _038074F8
	ldr r0, _038075F4 // =0x0380BBCC
	ldrh r0, [r0]
	bl OS_TryLockCard
	cmp r0, #0
	bne _038075C8
_038074F8:
	ldr r1, [r5]
	ldr r0, [r5, #4]
	cmp r1, r0
	bne _03807534
	mov r0, #0
	bl CTRDGi_VibOnOff
	str r5, [sp]
	ldr r0, _038075FC // =0x0380BBFC
	ldr r1, [r5, #8]
	mov r2, #0
	ldr r3, _03807600 // =CTRDG_VibPulseEdgeUpdate
	bl OS_SetAlarm
	mov r0, #0
	str r0, [r5]
	b _038075B0
_03807534:
	ands r0, r1, #1
	beq _03807578
	mov r0, #0
	bl CTRDGi_VibOnOff
	str r5, [sp]
	ldr r0, _038075FC // =0x0380BBFC
	ldr r1, [r5]
	mov r1, r1, lsr #1
	add r1, r5, r1, lsl #2
	ldr r1, [r1, #0x24]
	mov r2, #0
	ldr r3, _03807600 // =CTRDG_VibPulseEdgeUpdate
	bl OS_SetAlarm
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	b _038075B0
_03807578:
	mov r0, #2
	bl CTRDGi_VibOnOff
	str r5, [sp]
	ldr r0, _038075FC // =0x0380BBFC
	ldr r1, [r5]
	mov r1, r1, lsr #1
	add r1, r5, r1, lsl #2
	ldr r1, [r1, #0xc]
	mov r2, #0
	ldr r3, _03807600 // =CTRDG_VibPulseEdgeUpdate
	bl OS_SetAlarm
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
_038075B0:
	cmp r4, #0
	bne _038075E0
	ldr r0, _038075F4 // =0x0380BBCC
	ldrh r0, [r0]
	bl OS_UnlockCard
	b _038075E0
_038075C8:
	str r5, [sp]
	ldr r0, _038075FC // =0x0380BBFC
	ldr r1, _03807604 // =0x0000020B
	mov r2, #0
	ldr r3, _03807600 // =CTRDG_VibPulseEdgeUpdate
	bl OS_SetAlarm
_038075E0:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_038075EC: .word 0x0380BBD0
_038075F0: .word 0x027FFFE8
_038075F4: .word 0x0380BBCC
_038075F8: .word 0x000080E8
_038075FC: .word 0x0380BBFC
_03807600: .word CTRDG_VibPulseEdgeUpdate
_03807604: .word 0x0000020B
	arm_func_end CTRDG_VibPulseEdgeUpdate

	arm_func_start CTRDGi_CallbackForCTREx
CTRDGi_CallbackForCTREx: // 0x03807608
	mov r0, r1
	ldr ip, _03807614 // =CTRDG_VibPulseEdgeUpdate
	bx ip
	.align 2, 0
_03807614: .word CTRDG_VibPulseEdgeUpdate
	arm_func_end CTRDGi_CallbackForCTREx

	arm_func_start CTRDGi_CallbackForPulledOut
CTRDGi_CallbackForPulledOut: // 0x03807618
	stmdb sp!, {lr}
	sub sp, sp, #4
	and r0, r1, #0x3f
	cmp r0, #2
	bne _03807634
	bl CTRDGi_TerminateARM7
	b _03807638
_03807634:
	bl OS_Terminate
_03807638:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CTRDGi_CallbackForPulledOut

	arm_func_start CTRDGi_CallbackForInitModuleInfo
CTRDGi_CallbackForInitModuleInfo: // 0x03807644
	stmdb sp!, {lr}
	sub sp, sp, #4
	and r0, r1, #0x3f
	cmp r0, #1
	ldreq r0, _03807678 // =0x0380BBE4
	streq r1, [r0]
	moveq r1, #1
	streq r1, [r0, #0x10]
	beq _0380766C
	bl OS_Terminate
_0380766C:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03807678: .word 0x0380BBE4
	arm_func_end CTRDGi_CallbackForInitModuleInfo

	arm_func_start CTRDGi_InitModuleInfo
CTRDGi_InitModuleInfo: // 0x0380767C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r0, _0380774C // =0x0380BBD4
	ldr r1, [r0]
	cmp r1, #0
	bne _03807740
	mov r1, #1
	str r1, [r0]
	ldr r0, _03807750 // =0x04000300
	ldrh r0, [r0]
	ands r0, r0, #1
	beq _03807740
	mov r0, #0x40000
	bl OS_SetIrqMask
	mov r5, r0
	ldr r1, _03807754 // =0x04000208
	ldrh r4, [r1]
	mov r0, #1
	strh r0, [r1]
	mov r7, #0x100
	ldr r6, _03807758 // =0x0380BBE4
	b _038076DC
_038076D4:
	mov r0, r7
	bl SVC_WaitByLoop_ARM
_038076DC:
	ldr r0, [r6, #0x10]
	cmp r0, #1
	bne _038076D4
	ldr r1, [r6]
	ldr r0, _0380775C // =0x01FFFFC0
	and r0, r1, r0
	mov r0, r0, lsr #6
	mov r0, r0, lsl #5
	add r0, r0, #0x2000000
	add r0, r0, #4
	bl CTRDGi_IsNinLogoOfAgb
	ldr r2, _03807760 // =0x027FFC30
	ldrb r1, [r2, #5]
	bic r1, r1, #1
	and r0, r0, #0xff
	and r0, r0, #1
	orr r0, r1, r0
	strb r0, [r2, #5]
	mov r0, #1
	bl CTRDGi_SendtoPxi
	ldr r1, _03807754 // =0x04000208
	ldrh r0, [r1]
	strh r4, [r1]
	mov r0, r5
	bl OS_SetIrqMask
_03807740:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_0380774C: .word 0x0380BBD4
_03807750: .word 0x04000300
_03807754: .word 0x04000208
_03807758: .word 0x0380BBE4
_0380775C: .word 0x01FFFFC0
_03807760: .word 0x027FFC30
	arm_func_end CTRDGi_InitModuleInfo

	arm_func_start CTRDG_Init
CTRDG_Init: // 0x03807764
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl OS_InitTick
	bl OS_InitAlarm
	ldr r0, _038077F4 // =0x0380BBFC
	bl OS_CreateAlarm
	ldr r0, _038077F8 // =0x0380BBE0
	ldr r1, [r0]
	cmp r1, #0
	bne _038077E8
	mov r1, #1
	str r1, [r0]
	bl CTRDGi_InitCommon
	bl OS_GetLockID
	mvn r1, #2
	cmp r0, r1
	beq _038077E8
	ldr r1, _038077FC // =0x0380BBCC
	strh r0, [r1]
	bl PXI_Init
	mov r0, #0xd
	ldr r1, _03807800 // =CTRDGi_CallbackForInitModuleInfo
	bl PXI_SetFifoRecvCallback
	bl CTRDGi_InitModuleInfo
	mov r0, #0xd
	ldr r1, _03807804 // =CTRDGi_CallbackForPulledOut
	bl PXI_SetFifoRecvCallback
	mov r0, #0x10
	ldr r1, _03807808 // =CTRDGi_CallbackForCTREx
	bl PXI_SetFifoRecvCallback
	mov r0, #0x11
	ldr r1, _0380780C // =CTRDGi_CallbackForSetPhi
	bl PXI_SetFifoRecvCallback
_038077E8:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_038077F4: .word 0x0380BBFC
_038077F8: .word 0x0380BBE0
_038077FC: .word 0x0380BBCC
_03807800: .word CTRDGi_CallbackForInitModuleInfo
_03807804: .word CTRDGi_CallbackForPulledOut
_03807808: .word CTRDGi_CallbackForCTREx
_0380780C: .word CTRDGi_CallbackForSetPhi
	arm_func_end CTRDG_Init

	.rodata

.public isFirstCheck_3294
isFirstCheck_3294:
	.word 1
	
.public nextCount_3292
nextCount_3292:
	.word 0xFFFFFFFF