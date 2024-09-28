	.include "asm/macros.inc"
	.include "global.inc"

	.text

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
