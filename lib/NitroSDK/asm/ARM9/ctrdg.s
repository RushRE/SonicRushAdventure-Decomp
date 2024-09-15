	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CTRDG_Enable
CTRDG_Enable: // 0x020FC1F4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _020FC244 // =0x02151DF4
	mov r4, r0
	str r5, [r1]
	bl CTRDG_IsOptionCartridge
	cmp r0, #0
	bne _020FC230
	cmp r5, #0
	movne r1, #0x1000
	moveq r1, #0x5000
	mov r0, #0xf000
	bl OS_SetIPermissionsForProtectionRegion
_020FC230:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020FC244: .word 0x02151DF4
	arm_func_end CTRDG_Enable

	arm_func_start CTRDGi_SendtoPxi
CTRDGi_SendtoPxi: // 0x020FC248
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r1, r7
	mov r0, #0xd
	mov r2, #0
	bl PXI_SendWordByFifo
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r6, #1
	mov r5, #0xd
	mov r4, #0
_020FC280:
	mov r0, r6
	blx SVC_WaitByLoop
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	bne _020FC280
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end CTRDGi_SendtoPxi

	arm_func_start CTRDGi_UnlockByProcessor
CTRDGi_UnlockByProcessor: // 0x020FC2AC
	stmdb sp!, {r4, lr}
	mov r4, r1
	ldr r1, [r4]
	cmp r1, #0
	bne _020FC2C4
	bl OS_UnLockCartridge
_020FC2C4:
	ldr r0, [r4, #4]
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end CTRDGi_UnlockByProcessor

	arm_func_start CTRDGi_LockByProcessor
CTRDGi_LockByProcessor: // 0x020FC2D4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	ldr r5, _020FC350 // =0x027FFFE8
	mov r4, #1
_020FC2EC:
	bl OS_DisableInterrupts
	str r0, [r6, #4]
	mov r0, r5
	bl OS_ReadOwnerOfLockWord
	and r0, r0, #0x40
	str r0, [r6]
	ldr r0, [r6]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	mov r0, r7
	bl OS_LockCartridge
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldr r0, [r6, #4]
	bl OS_RestoreInterrupts
	mov r0, r4
	blx SVC_WaitByLoop
	b _020FC2EC
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020FC350: .word 0x027FFFE8
	arm_func_end CTRDGi_LockByProcessor

	arm_func_start CTRDGi_RestoreAccessCycle
CTRDGi_RestoreAccessCycle: // 0x020FC354
	ldr r3, _020FC384 // =0x04000204
	ldr r2, [r0]
	ldrh r1, [r3]
	bic r1, r1, #0xc
	orr r1, r1, r2, lsl #2
	strh r1, [r3]
	ldrh r1, [r3]
	ldr r2, [r0, #4]
	bic r0, r1, #0x10
	orr r0, r0, r2, lsl #4
	strh r0, [r3]
	bx lr
	.align 2, 0
_020FC384: .word 0x04000204
	arm_func_end CTRDGi_RestoreAccessCycle

	arm_func_start CTRDGi_ChangeLatestAccessCycle
CTRDGi_ChangeLatestAccessCycle: // 0x020FC388
	ldr r2, _020FC3CC // =0x04000204
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
_020FC3CC: .word 0x04000204
	arm_func_end CTRDGi_ChangeLatestAccessCycle

	arm_func_start CTRDG_IsExisting
CTRDG_IsExisting: // 0x020FC3D0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	ldr r2, _020FC4DC // =0x027FFC30
	ldr r0, _020FC4E0 // =0x0000FFFF
	ldrh r1, [r2]
	mov r4, #1
	cmp r1, r0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldrb r0, [r2, #5]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r0, _020FC4E4 // =0x02151DF8
	add r1, sp, #0
	ldrh r0, [r0, #2]
	bl CTRDGi_LockByProcessor
	add r0, sp, #8
	bl CTRDGi_ChangeLatestAccessCycle
	mov r0, #0x8000000
	ldrb r2, [r0, #0xb2]
	cmp r2, #0x96
	bne _020FC458
	ldr r1, _020FC4DC // =0x027FFC30
	ldrh r0, [r0, #0xbe]
	ldrh r1, [r1]
	cmp r1, r0
	bne _020FC4A0
_020FC458:
	cmp r2, #0x96
	beq _020FC478
	ldr r1, _020FC4DC // =0x027FFC30
	ldr r0, _020FC4E8 // =0x0801FFFE
	ldrh r1, [r1]
	ldrh r0, [r0]
	cmp r1, r0
	bne _020FC4A0
_020FC478:
	ldr r2, _020FC4DC // =0x027FFC30
	mov r0, #0x8000000
	ldr r1, [r2, #8]
	ldr r0, [r0, #0xac]
	cmp r1, r0
	beq _020FC4B4
	ldrb r0, [r2, #5]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _020FC4B4
_020FC4A0:
	ldr r1, _020FC4DC // =0x027FFC30
	mov r4, #0
	ldrb r0, [r1, #5]
	orr r0, r0, #2
	strb r0, [r1, #5]
_020FC4B4:
	add r0, sp, #8
	bl CTRDGi_RestoreAccessCycle
	ldr r0, _020FC4E4 // =0x02151DF8
	add r1, sp, #0
	ldrh r0, [r0, #2]
	bl CTRDGi_UnlockByProcessor
	mov r0, r4
	add sp, sp, #0x10
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020FC4DC: .word 0x027FFC30
_020FC4E0: .word 0x0000FFFF
_020FC4E4: .word 0x02151DF8
_020FC4E8: .word 0x0801FFFE
	arm_func_end CTRDG_IsExisting

	arm_func_start CTRDGi_IsAgbCartridgeAtInit
CTRDGi_IsAgbCartridgeAtInit: // 0x020FC4EC
	ldr r0, _020FC500 // =0x027FFC30
	ldrb r0, [r0, #5]
	mov r0, r0, lsl #0x1f
	mov r0, r0, lsr #0x1f
	bx lr
	.align 2, 0
_020FC500: .word 0x027FFC30
	arm_func_end CTRDGi_IsAgbCartridgeAtInit

	arm_func_start CTRDG_IsOptionCartridge
CTRDG_IsOptionCartridge: // 0x020FC504
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl CTRDG_IsExisting
	cmp r0, #0
	beq _020FC530
	bl CTRDGi_IsAgbCartridgeAtInit
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {lr}
	bxeq lr
_020FC530:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CTRDG_IsOptionCartridge

	arm_func_start CTRDGi_InitCommon
CTRDGi_InitCommon: // 0x020FC540
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020FC578 // =0x02151DF8
	mov r3, #0
	ldr r2, _020FC57C // =0x05000001
	add r0, sp, #0
	str r3, [sp]
	blx SVC_CpuSet
	bl OS_GetLockID
	ldr r1, _020FC578 // =0x02151DF8
	strh r0, [r1, #2]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020FC578: .word 0x02151DF8
_020FC57C: .word 0x05000001
	arm_func_end CTRDGi_InitCommon

	arm_func_start CTRDGi_CallbackForSetPhi
CTRDGi_CallbackForSetPhi: // 0x020FC580
	ldr r0, _020FC590 // =0x02151E00
	mov r1, #0
	str r1, [r0]
	bx lr
	.align 2, 0
_020FC590: .word 0x02151E00
	arm_func_end CTRDGi_CallbackForSetPhi

	arm_func_start CTRDG_TerminateForPulledOut
CTRDG_TerminateForPulledOut: // 0x020FC594
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	bl CTRDGi_SendtoPxi
	bl OS_Terminate
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CTRDG_TerminateForPulledOut

	arm_func_start CTRDGi_PulledOutCallback
CTRDGi_PulledOutCallback: // 0x020FC5B4
	stmdb sp!, {lr}
	sub sp, sp, #4
	and r0, r1, #0x3f
	cmp r0, #0x11
	bne _020FC61C
	ldr r0, _020FC62C // =0x02151E08
	ldr r0, [r0]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldr r1, _020FC630 // =0x02151E0C
	mov r0, #0
	ldr r1, [r1]
	cmp r1, #0
	beq _020FC5F8
	blx r1
_020FC5F8:
	cmp r0, #0
	beq _020FC604
	bl CTRDG_TerminateForPulledOut
_020FC604:
	ldr r0, _020FC62C // =0x02151E08
	mov r1, #1
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020FC61C:
	bl OS_Terminate
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020FC62C: .word 0x02151E08
_020FC630: .word 0x02151E0C
	arm_func_end CTRDGi_PulledOutCallback

	arm_func_start CTRDGi_CallbackForInitModuleInfo
CTRDGi_CallbackForInitModuleInfo: // 0x020FC634
	stmdb sp!, {lr}
	sub sp, sp, #4
	and r0, r1, #0x3f
	cmp r0, #1
	ldreq r0, _020FC66C // =0x02151DF8
	moveq r1, #1
	streqh r1, [r0]
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	bl OS_Terminate
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020FC66C: .word 0x02151DF8
	arm_func_end CTRDGi_CallbackForInitModuleInfo

	arm_func_start CTRDGi_InitModuleInfo
CTRDGi_InitModuleInfo: // 0x020FC670
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	ldr r0, _020FC858 // =0x02151DFC
	ldr r1, [r0]
	cmp r1, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	ldr r1, _020FC85C // =0x04000300
	mov r2, #1
	str r2, [r0]
	ldrh r0, [r1]
	ands r0, r0, #1
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r0, #0x40000
	bl OS_SetIrqMask
	ldr r3, _020FC860 // =0x04000208
	mov r2, #1
	ldrh r4, [r3]
	ldr r1, _020FC864 // =0x02151DF8
	mov r6, r0
	strh r2, [r3]
	ldrh r0, [r1, #2]
	add r1, sp, #0
	bl CTRDGi_LockByProcessor
	ldr r1, _020FC868 // =0x04000204
	add r0, sp, #8
	ldrh r1, [r1]
	and r1, r1, #0x8000
	mov r5, r1, asr #0xf
	bl CTRDGi_ChangeLatestAccessCycle
	ldr r3, _020FC868 // =0x04000204
	ldr r0, _020FC86C // =0x02151E20
	ldrh r2, [r3]
	add r0, r0, #0x80
	mov r1, #0x40
	bic r2, r2, #0x8000
	strh r2, [r3]
	bl DC_InvalidateRange
	ldr r2, _020FC86C // =0x02151E20
	ldr r1, _020FC870 // =0x08000080
	mov r0, #1
	mov r3, #0x40
	add r2, r2, #0x80
	bl MI_DmaCopy16
	ldr r2, _020FC868 // =0x04000204
	add r0, sp, #8
	ldrh r1, [r2]
	bic r1, r1, #0x8000
	orr r1, r1, r5, lsl #15
	strh r1, [r2]
	bl CTRDGi_RestoreAccessCycle
	ldr r0, _020FC864 // =0x02151DF8
	add r1, sp, #0
	ldrh r0, [r0, #2]
	bl CTRDGi_UnlockByProcessor
	ldr r0, _020FC874 // =0x027FFF9B
	ldrb r0, [r0]
	cmp r0, #0
	bne _020FC778
	ldr r0, _020FC878 // =0x027FFF9A
	ldrb r0, [r0]
	cmp r0, #0
	bne _020FC7E4
_020FC778:
	ldr r2, _020FC86C // =0x02151E20
	ldr r0, _020FC87C // =0x027FFC30
	ldrh r1, [r2, #0xbe]
	mov r3, #0
	strh r1, [r0]
_020FC78C:
	add r0, r2, r3
	ldrb r1, [r0, #0xb5]
	add r0, r3, #0x2700000
	add r0, r0, #0xff000
	add r3, r3, #1
	strb r1, [r0, #0xc32]
	cmp r3, #3
	blt _020FC78C
	ldrh r0, [r2, #0xb0]
	ldr r1, _020FC87C // =0x027FFC30
	strh r0, [r1, #6]
	ldr r0, [r2, #0xac]
	str r0, [r1, #8]
	bl CTRDG_IsExisting
	cmp r0, #0
	movne r2, #1
	ldr r1, _020FC874 // =0x027FFF9B
	moveq r2, #0
	strb r2, [r1]
	ldr r0, _020FC878 // =0x027FFF9A
	mov r1, #1
	strb r1, [r0]
_020FC7E4:
	ldr r0, _020FC880 // =0xFFFF0020
	ldr r1, _020FC884 // =0x02151E24
	mov r2, #0x9c
	bl MIi_CpuCopy32
	bl DC_FlushAll
	ldr r0, _020FC86C // =0x02151E20
	add r0, r0, #0xfe000000
	mov r0, r0, lsr #5
	mov r0, r0, lsl #6
	orr r0, r0, #1
	bl CTRDGi_SendtoPxi
	ldr r5, _020FC864 // =0x02151DF8
	ldrh r0, [r5]
	cmp r0, #1
	beq _020FC838
	mov r7, #1
_020FC824:
	mov r0, r7
	blx SVC_WaitByLoop
	ldrh r0, [r5]
	cmp r0, #1
	bne _020FC824
_020FC838:
	ldr r2, _020FC860 // =0x04000208
	mov r0, r6
	ldrh r1, [r2]
	strh r4, [r2]
	bl OS_SetIrqMask
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020FC858: .word 0x02151DFC
_020FC85C: .word 0x04000300
_020FC860: .word 0x04000208
_020FC864: .word 0x02151DF8
_020FC868: .word 0x04000204
_020FC86C: .word 0x02151E20
_020FC870: .word 0x08000080
_020FC874: .word 0x027FFF9B
_020FC878: .word 0x027FFF9A
_020FC87C: .word 0x027FFC30
_020FC880: .word 0xFFFF0020
_020FC884: .word 0x02151E24
	arm_func_end CTRDGi_InitModuleInfo

	arm_func_start CTRDG_Init
CTRDG_Init: // 0x020FC888
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _020FC93C // =0x02151E04
	ldr r1, [r0]
	cmp r1, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	mov r1, #1
	str r1, [r0]
	bl CTRDGi_InitCommon
	ldr r0, _020FC940 // =0x02151E08
	mov r1, #0
	str r1, [r0]
	bl PXI_Init
	mov r5, #0xd
	mov r4, #1
_020FC8CC:
	mov r0, r5
	mov r1, r4
	bl PXI_IsCallbackReady
	cmp r0, #0
	beq _020FC8CC
	ldr r1, _020FC944 // =CTRDGi_CallbackForInitModuleInfo
	mov r0, #0xd
	bl PXI_SetFifoRecvCallback
	bl CTRDGi_InitModuleInfo
	mov r0, #0xd
	mov r1, #0
	bl PXI_SetFifoRecvCallback
	ldr r1, _020FC948 // =CTRDGi_PulledOutCallback
	mov r0, #0xd
	bl PXI_SetFifoRecvCallback
	ldr r1, _020FC94C // =0x02151E0C
	mov r2, #0
	ldr r0, _020FC950 // =0x02151EE0
	str r2, [r1]
	bl CTRDGi_InitTaskThread
	ldr r1, _020FC954 // =CTRDGi_CallbackForSetPhi
	mov r0, #0x11
	bl PXI_SetFifoRecvCallback
	mov r0, #0
	bl CTRDG_Enable
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020FC93C: .word 0x02151E04
_020FC940: .word 0x02151E08
_020FC944: .word CTRDGi_CallbackForInitModuleInfo
_020FC948: .word CTRDGi_PulledOutCallback
_020FC94C: .word 0x02151E0C
_020FC950: .word 0x02151EE0
_020FC954: .word CTRDGi_CallbackForSetPhi
	arm_func_end CTRDG_Init

	arm_func_start CTRDGi_TaskThread
CTRDGi_TaskThread: // 0x020FC958
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x28
	ldr r6, _020FCA3C // =0x02151FCC
	ldr r5, _020FCA40 // =0x02151FC8
	mov r4, r0
	add r9, sp, #0
	mov r8, #0
	mov r7, #0x24
_020FC978:
	mov r0, r9
	mov r1, r8
	mov r2, r7
	bl MI_CpuFill8
	bl OS_DisableInterrupts
	ldr r1, [r4, #0xc0]
	mov r10, r0
	cmp r1, #0
	bne _020FC9B0
_020FC99C:
	mov r0, r8
	bl OS_SleepThread
	ldr r0, [r4, #0xc0]
	cmp r0, #0
	beq _020FC99C
_020FC9B0:
	ldr lr, [r4, #0xc0]
	add ip, sp, #0
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r1, [lr]
	mov r0, r10
	str r1, [ip]
	bl OS_RestoreInterrupts
	ldr r1, [sp]
	cmp r1, #0
	beq _020FC9F0
	mov r0, r9
	blx r1
	str r0, [sp, #8]
_020FC9F0:
	bl OS_DisableInterrupts
	ldr r1, [sp, #4]
	mov r10, r0
	strb r8, [r6, #0x22]
	cmp r1, #0
	beq _020FCA10
	mov r0, r9
	blx r1
_020FCA10:
	ldr r0, [r5]
	cmp r0, #0
	beq _020FCA2C
	mov r0, r10
	str r8, [r4, #0xc0]
	bl OS_RestoreInterrupts
	b _020FC978
_020FCA2C:
	bl OS_ExitThread
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_020FCA3C: .word 0x02151FCC
_020FCA40: .word 0x02151FC8
	arm_func_end CTRDGi_TaskThread

	arm_func_start CTRDGi_InitTaskInfo
CTRDGi_InitTaskInfo: // 0x020FCA44
	ldr ip, _020FCA54 // =MI_CpuFill8
	mov r1, #0
	mov r2, #0x24
	bx ip
	.align 2, 0
_020FCA54: .word MI_CpuFill8
	arm_func_end CTRDGi_InitTaskInfo

	arm_func_start CTRDGi_InitTaskThread
CTRDGi_InitTaskThread: // 0x020FCA58
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _020FCAD8 // =0x02151FC8
	mov r4, r0
	ldr r0, [r1]
	cmp r0, #0
	bne _020FCAC4
	add r0, r5, #0xc4
	str r5, [r1]
	bl CTRDGi_InitTaskInfo
	ldr r0, _020FCADC // =0x02151FCC
	bl CTRDGi_InitTaskInfo
	mov r0, #0
	str r0, [r5, #0xc0]
	mov r2, #0x400
	ldr r1, _020FCAE0 // =CTRDGi_TaskThread
	ldr r3, _020FCAE4 // =0x021523F0
	mov r0, r5
	str r2, [sp]
	mov r2, #0x14
	str r2, [sp, #4]
	mov r2, r5
	bl OS_CreateThread
	mov r0, r5
	bl OS_WakeupThreadDirect
_020FCAC4:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020FCAD8: .word 0x02151FC8
_020FCADC: .word 0x02151FCC
_020FCAE0: .word CTRDGi_TaskThread
_020FCAE4: .word 0x021523F0
	arm_func_end CTRDGi_InitTaskThread
