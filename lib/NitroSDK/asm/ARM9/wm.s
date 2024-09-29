	.include "asm/macros.inc"
	.include "global.inc"

	.bss

_02150948: // 0x02150948
	.space 0x13C0

	.text

	arm_func_start WMi_GetMPReadyAIDs
WMi_GetMPReadyAIDs: // 0x020F130C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	ldr r1, _020F135C // =0x0215094C
	mov r4, r0
	ldr r0, [r1]
	cmp r0, #0
	moveq r5, #0
	beq _020F1344
	ldr r5, [r0, #4]
	mov r1, #2
	add r0, r5, #0x86
	bl DC_InvalidateRange
	ldrh r5, [r5, #0x86]
_020F1344:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F135C: .word 0x0215094C
	arm_func_end WMi_GetMPReadyAIDs

	arm_func_start WM_GetConnectedAIDs
WM_GetConnectedAIDs: // 0x020F1360
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020F1390 // =0x0215094C
	ldr r1, [r1]
	cmp r1, #0
	ldrne r4, [r1, #0x14c]
	moveq r4, #0
	bl OS_RestoreInterrupts
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F1390: .word 0x0215094C
	arm_func_end WM_GetConnectedAIDs

	arm_func_start WM_GetAID
WM_GetAID: // 0x020F1394
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020F13C4 // =0x0215094C
	ldr r1, [r1]
	cmp r1, #0
	addne r1, r1, #0x100
	ldrneh r4, [r1, #0x50]
	moveq r4, #0
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F13C4: .word 0x0215094C
	arm_func_end WM_GetAID

	arm_func_start WMi_GetStatusAddress
WMi_GetStatusAddress: // 0x020F13C8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WMi_CheckInitialized
	cmp r0, #0
	movne r0, #0
	ldreq r0, _020F13F4 // =0x0215094C
	ldreq r0, [r0]
	ldreq r0, [r0, #4]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F13F4: .word 0x0215094C
	arm_func_end WMi_GetStatusAddress

	arm_func_start WmClearFifoRecvFlag
WmClearFifoRecvFlag: // 0x020F13F8
	ldr r1, _020F1410 // =0x027FFF96
	ldrh r0, [r1]
	ands r2, r0, #1
	bicne r0, r0, #1
	strneh r0, [r1]
	bx lr
	.align 2, 0
_020F1410: .word 0x027FFF96
	arm_func_end WmClearFifoRecvFlag

	arm_func_start WmReceiveFifo
WmReceiveFifo: // 0x020F1414
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r0, _020F17DC // =0x0215094C
	cmp r2, #0
	ldr r8, [r0]
	mov r10, r1
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	ldr r0, [r8, #0x10]
	mov r1, #0x100
	bl DC_InvalidateRange
	ldrh r0, [r8, #0x16]
	cmp r0, #0
	bne _020F145C
	ldr r0, [r8, #4]
	mov r1, #0x800
	bl DC_InvalidateRange
_020F145C:
	ldr r0, [r8, #0x10]
	cmp r10, r0
	beq _020F1474
	mov r0, r10
	mov r1, #0x100
	bl DC_InvalidateRange
_020F1474:
	ldrh r0, [r10]
	cmp r0, #0x2c
	blo _020F152C
	cmp r0, #0x80
	bne _020F14B0
	ldrh r0, [r10, #2]
	cmp r0, #0x13
	bne _020F1498
	bl OS_Terminate
_020F1498:
	ldr r1, [r8, #0xc8]
	cmp r1, #0
	beq _020F1794
	mov r0, r10
	blx r1
	b _020F1794
_020F14B0:
	cmp r0, #0x82
	bne _020F1504
	ldrh r0, [r10, #6]
	add r1, r8, r0, lsl #2
	ldr r0, [r1, #0xcc]
	cmp r0, #0
	beq _020F1794
	ldr r0, [r1, #0x10c]
	str r0, [r10, #0x1c]
	ldr r0, [r8, #0x14c]
	strh r0, [r10, #0x22]
	ldr r1, [r8, #4]
	ldr r0, [r10, #8]
	ldrh r1, [r1, #0x72]
	bl DC_InvalidateRange
	ldrh r1, [r10, #6]
	mov r0, r10
	add r1, r8, r1, lsl #2
	ldr r1, [r1, #0xcc]
	blx r1
	b _020F1794
_020F1504:
	cmp r0, #0x81
	bne _020F1794
	mov r0, #0xf
	strh r0, [r10]
	ldr r1, [r10, #0x1c]
	cmp r1, #0
	beq _020F1794
	mov r0, r10
	blx r1
	b _020F1794
_020F152C:
	cmp r0, #0xe
	bne _020F156C
	ldrh r1, [r10, #4]
	ldr r0, _020F17E0 // =0x0000FFF5
	add r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _020F156C
	ldrh r0, [r10, #2]
	cmp r0, #0
	bne _020F156C
	ldr r1, [r8, #4]
	ldr r0, [r10, #8]
	ldrh r1, [r1, #0x72]
	bl DC_InvalidateRange
_020F156C:
	ldrh r1, [r10]
	cmp r1, #2
	bne _020F15B4
	ldrh r0, [r10, #2]
	cmp r0, #0
	bne _020F15B4
	add r0, r8, r1, lsl #2
	ldr r4, [r0, #0x18]
	bl WM_Finish
	cmp r4, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	mov r0, r10
	blx r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F15B4:
	add r0, r8, r1, lsl #2
	ldr r1, [r0, #0x18]
	cmp r1, #0
	beq _020F15E4
	mov r0, r10
	blx r1
	ldr r0, _020F17E4 // =_02150948
	ldrh r0, [r0]
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
_020F15E4:
	ldrh r0, [r10]
	cmp r0, #8
	beq _020F15F8
	cmp r0, #0xc
	bne _020F1794
_020F15F8:
	cmp r0, #8
	bne _020F162C
	add r0, r10, #0xa
	str r0, [sp]
	ldrh r0, [r10, #0x2c]
	add r11, r10, #0x14
	ldrh r7, [r10, #8]
	ldrh r6, [r10, #0x10]
	ldrh r4, [r10, #0x12]
	str r0, [sp, #4]
	ldrh r9, [r10, #0x2e]
	mov r5, #0
	b _020F165C
_020F162C:
	cmp r0, #0xc
	bne _020F165C
	ldrh r0, [r10, #0x16]
	mov r6, #0
	ldrh r7, [r10, #8]
	str r0, [sp, #4]
	add r0, r10, #0x10
	ldrh r5, [r10, #0xa]
	ldrh r4, [r10, #0xc]
	ldrh r9, [r10, #0x18]
	mov r11, r6
	str r0, [sp]
_020F165C:
	cmp r7, #7
	beq _020F1674
	cmp r7, #9
	beq _020F1674
	cmp r7, #0x1a
	bne _020F1794
_020F1674:
	cmp r7, #7
	ldreq r1, [r8, #0x14c]
	moveq r0, #1
	orreq r0, r1, r0, lsl r6
	streq r0, [r8, #0x14c]
	movne r0, #1
	mvnne r0, r0, lsl r6
	ldrne r1, [r8, #0x14c]
	add r3, r8, #0x100
	andne r0, r1, r0
	strne r0, [r8, #0x14c]
	ldr r0, _020F17E8 // =0x02150998
	mov r1, #0
	mov r2, #0x44
	strh r5, [r3, #0x50]
	bl MI_CpuFill8
	ldr r3, _020F17E8 // =0x02150998
	mov r1, #0
	mov r2, #0x82
	strh r2, [r3]
	strh r7, [r3, #4]
	strh r6, [r3, #0x12]
	strh r5, [r3, #0x20]
	strh r1, [r3, #2]
	str r1, [r3, #8]
	str r1, [r3, #0xc]
	strh r1, [r3, #0x10]
	ldr r1, [r8, #0x14c]
	ldr r2, _020F17EC // =0x0000FFFF
	strh r1, [r3, #0x22]
	strh r2, [r3, #0x1a]
	ldr r0, [sp]
	ldr r1, _020F17F0 // =0x021509AC
	mov r2, #6
	strh r4, [r3, #0x3c]
	bl MI_CpuCopy8
	cmp r11, #0
	beq _020F1720
	ldr r1, _020F17F4 // =0x021509BC
	mov r0, r11
	mov r2, #0x18
	bl MIi_CpuCopy16
	b _020F1730
_020F1720:
	ldr r1, _020F17F4 // =0x021509BC
	mov r0, #0
	mov r2, #0x18
	bl MIi_CpuClear16
_020F1730:
	cmp r5, #0
	ldreq r1, [sp, #4]
	ldr r0, _020F17E8 // =0x02150998
	movne r1, r9
	cmp r5, #0
	ldrne r9, [sp, #4]
	ldr r5, _020F17E8 // =0x02150998
	strh r1, [r0, #0x40]
	mov r4, #0
	strh r9, [r5, #0x42]
_020F1758:
	strh r4, [r5, #6]
	add r2, r8, r4, lsl #2
	ldr r0, [r2, #0xcc]
	cmp r0, #0
	beq _020F1780
	ldr r1, [r2, #0x10c]
	mov r0, r5
	str r1, [r5, #0x1c]
	ldr r1, [r2, #0xcc]
	blx r1
_020F1780:
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	cmp r4, #0x10
	blo _020F1758
_020F1794:
	ldr r0, [r8, #0x10]
	mov r1, #0x100
	bl DC_InvalidateRange
	bl WmClearFifoRecvFlag
	ldr r0, [r8, #0x10]
	cmp r10, r0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldrh r2, [r10]
	mov r0, r10
	mov r1, #0x100
	orr r2, r2, #0x8000
	strh r2, [r10]
	bl DC_StoreRange
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F17DC: .word 0x0215094C
_020F17E0: .word 0x0000FFF5
_020F17E4: .word _02150948
_020F17E8: .word 0x02150998
_020F17EC: .word 0x0000FFFF
_020F17F0: .word 0x021509AC
_020F17F4: .word 0x021509BC
	arm_func_end WmReceiveFifo

	arm_func_start WMi_CheckStateEx
WMi_CheckStateEx: // 0x020F17F8
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WMi_CheckInitialized
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	addne sp, sp, #0x10
	bxne lr
	ldr r0, _020F189C // =0x0215094C
	mov r1, #2
	ldr r0, [r0]
	ldr r0, [r0, #4]
	bl DC_InvalidateRange
	ldr r0, _020F189C // =0x0215094C
	add r1, sp, #8
	ldr r2, [r0]
	ldr r0, [sp, #8]
	ldr r2, [r2, #4]
	cmp r0, #0
	bic r1, r1, #3
	addeq sp, sp, #4
	add ip, r1, #4
	ldrh r3, [r2]
	mov r0, #3
	ldmeqia sp!, {lr}
	addeq sp, sp, #0x10
	bxeq lr
	mov r2, #0
_020F186C:
	add ip, ip, #4
	ldr r1, [ip, #-4]
	cmp r1, r3
	ldr r1, [sp, #8]
	moveq r0, r2
	subs r1, r1, #1
	str r1, [sp, #8]
	bne _020F186C
	add sp, sp, #4
	ldmia sp!, {lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_020F189C: .word 0x0215094C
	arm_func_end WMi_CheckStateEx

	arm_func_start WMi_CheckIdle
WMi_CheckIdle: // 0x020F18A0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WMi_CheckInitialized
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldr r0, _020F18F8 // =0x0215094C
	mov r1, #2
	ldr r0, [r0]
	ldr r0, [r0, #4]
	bl DC_InvalidateRange
	ldr r0, _020F18F8 // =0x0215094C
	ldr r0, [r0]
	ldr r0, [r0, #4]
	ldrh r0, [r0]
	cmp r0, #1
	movls r0, #3
	movhi r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F18F8: .word 0x0215094C
	arm_func_end WMi_CheckIdle

	arm_func_start WMi_CheckInitialized
WMi_CheckInitialized: // 0x020F18FC
	ldr r0, _020F1914 // =_02150948
	ldrh r0, [r0]
	cmp r0, #0
	movne r0, #0
	moveq r0, #3
	bx lr
	.align 2, 0
_020F1914: .word _02150948
	arm_func_end WMi_CheckInitialized

	arm_func_start WMi_GetSystemWork
WMi_GetSystemWork: // 0x020F1918
	ldr r0, _020F1924 // =0x0215094C
	ldr r0, [r0]
	bx lr
	.align 2, 0
_020F1924: .word 0x0215094C
	arm_func_end WMi_GetSystemWork

	arm_func_start WMi_SendCommandDirect
WMi_SendCommandDirect: // 0x020F1928
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r4, r1
	bl WmGetCommandBuffer4Arm7
	movs r5, r0
	moveq r0, #8
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl MI_CpuCopy8
	mov r0, r5
	mov r1, r4
	bl DC_StoreRange
	mov r1, r5
	mov r0, #0xa
	mov r2, #0
	bl PXI_SendWordByFifo
	mov r4, r0
	ldr r0, _020F199C // =0x02150950
	mov r1, r5
	mov r2, #1
	bl OS_SendMessage
	cmp r4, #0
	movlt r0, #8
	movge r0, #2
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020F199C: .word 0x02150950
	arm_func_end WMi_SendCommandDirect

	arm_func_start WMi_SendCommand
WMi_SendCommand: // 0x020F19A0
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	bl WmGetCommandBuffer4Arm7
	movs r5, r0
	addeq sp, sp, #4
	moveq r0, #8
	ldmeqia sp!, {r4, r5, lr}
	addeq sp, sp, #0x10
	bxeq lr
	strh r4, [r5]
	ldrh r2, [sp, #0x14]
	add r0, sp, #0x14
	bic r0, r0, #3
	mov r3, #0
	cmp r2, #0
	add r4, r0, #4
	ble _020F1A08
_020F19EC:
	add r4, r4, #4
	ldr r1, [r4, #-4]
	add r0, r5, r3, lsl #2
	add r3, r3, #1
	str r1, [r0, #4]
	cmp r3, r2
	blt _020F19EC
_020F1A08:
	mov r0, r5
	mov r1, #0x100
	bl DC_StoreRange
	mov r1, r5
	mov r0, #0xa
	mov r2, #0
	bl PXI_SendWordByFifo
	mov r4, r0
	ldr r0, _020F1A54 // =0x02150950
	mov r1, r5
	mov r2, #1
	bl OS_SendMessage
	cmp r4, #0
	movlt r0, #8
	movge r0, #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_020F1A54: .word 0x02150950
	arm_func_end WMi_SendCommand

	arm_func_start WmGetCommandBuffer4Arm7
WmGetCommandBuffer4Arm7: // 0x020F1A58
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020F1AC8 // =0x02150950
	add r1, sp, #0
	mov r2, #0
	bl OS_ReceiveMessage
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {lr}
	bxeq lr
	ldr r0, [sp]
	mov r1, #2
	bl DC_InvalidateRange
	ldr r1, [sp]
	ldrh r0, [r1]
	ands r0, r0, #0x8000
	addne sp, sp, #4
	movne r0, r1
	ldmneia sp!, {lr}
	bxne lr
	ldr r0, _020F1AC8 // =0x02150950
	mov r2, #1
	bl OS_JamMessage
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F1AC8: .word 0x02150950
	arm_func_end WmGetCommandBuffer4Arm7

	arm_func_start WMi_SetCallbackTable
WMi_SetCallbackTable: // 0x020F1ACC
	ldr r2, _020F1AE0 // =0x0215094C
	ldr r2, [r2]
	add r0, r2, r0, lsl #2
	str r1, [r0, #0x18]
	bx lr
	.align 2, 0
_020F1AE0: .word 0x0215094C
	arm_func_end WMi_SetCallbackTable

	arm_func_start WM_Finish
WM_Finish: // 0x020F1AE4
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	mov r4, r0
	bl WMi_CheckInitialized
	cmp r0, #0
	beq _020F1B10
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	ldmia sp!, {r4, lr}
	bx lr
_020F1B10:
	mov r0, #1
	mov r1, #0
	bl WMi_CheckStateEx
	cmp r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	bl WmClearFifoRecvFlag
	mov r0, #0xa
	mov r1, #0
	bl PXI_SetFifoRecvCallback
	ldr r2, _020F1B60 // =0x0215094C
	mov r3, #0
	ldr r1, _020F1B64 // =_02150948
	mov r0, r4
	str r3, [r2]
	strh r3, [r1]
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F1B60: .word 0x0215094C
_020F1B64: .word _02150948
	arm_func_end WM_Finish

	arm_func_start WmInitCore
WmInitCore: // 0x020F1B68
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r6, r0
	mov r5, r1
	mov r7, r2
	bl OS_DisableInterrupts
	ldr r1, _020F1D48 // =_02150948
	mov r4, r0
	ldrh r1, [r1]
	cmp r1, #0
	beq _020F1BA0
	bl OS_RestoreInterrupts
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
_020F1BA0:
	cmp r6, #0
	bne _020F1BB8
	bl OS_RestoreInterrupts
	mov r0, #6
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
_020F1BB8:
	cmp r5, #3
	bls _020F1BD0
	bl OS_RestoreInterrupts
	mov r0, #6
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
_020F1BD0:
	ands r1, r6, #0x1f
	beq _020F1BE8
	bl OS_RestoreInterrupts
	mov r0, #6
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
_020F1BE8:
	bl PXI_Init
	mov r0, #0xa
	mov r1, #1
	bl PXI_IsCallbackReady
	cmp r0, #0
	bne _020F1C14
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
_020F1C14:
	mov r0, r6
	mov r1, r7
	bl DC_InvalidateRange
	mov r0, r5
	mov r1, r6
	mov r3, r7
	mov r2, #0
	bl MI_DmaFill32
	ldr r0, _020F1D4C // =0x0215094C
	add r1, r6, #0x200
	str r6, [r0]
	str r1, [r6]
	ldr r2, [r0]
	ldr r1, [r2]
	add r1, r1, #0x300
	str r1, [r2, #4]
	ldr r2, [r0]
	ldr r1, [r2, #4]
	add r1, r1, #0x800
	str r1, [r2, #0xc]
	ldr r1, [r0]
	ldr r0, [r1, #0xc]
	add r0, r0, #0x100
	str r0, [r1, #0x10]
	bl WmClearFifoRecvFlag
	ldr r1, _020F1D4C // =0x0215094C
	mov r3, #0
	ldr r0, [r1]
	strh r5, [r0, #0x14]
	ldr r0, [r1]
	str r3, [r0, #0x14c]
	ldr r0, [r1]
	add r0, r0, #0x100
	strh r3, [r0, #0x50]
	mov r2, r3
_020F1CA0:
	ldr r0, [r1]
	add r0, r0, r3, lsl #2
	str r2, [r0, #0xcc]
	ldr r0, [r1]
	add r0, r0, r3, lsl #2
	add r3, r3, #1
	str r2, [r0, #0x10c]
	cmp r3, #0x10
	blt _020F1CA0
	ldr r0, _020F1D50 // =0x02150950
	ldr r1, _020F1D54 // =0x02150970
	mov r2, #0xa
	bl OS_InitMessageQueue
	ldr r9, _020F1D58 // =0x021509E0
	mov r10, #0
	ldr r6, _020F1D50 // =0x02150950
	mov r8, #0x8000
	mov r7, #2
	mov r5, #1
_020F1CEC:
	mov r0, r9
	mov r1, r7
	strh r8, [r9]
	bl DC_StoreRange
	mov r0, r6
	mov r1, r9
	mov r2, r5
	bl OS_SendMessage
	add r10, r10, #1
	cmp r10, #0xa
	add r9, r9, #0x100
	blt _020F1CEC
	ldr r1, _020F1D5C // =WmReceiveFifo
	mov r0, #0xa
	bl PXI_SetFifoRecvCallback
	ldr r1, _020F1D48 // =_02150948
	mov r2, #1
	mov r0, r4
	strh r2, [r1]
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_020F1D48: .word _02150948
_020F1D4C: .word 0x0215094C
_020F1D50: .word 0x02150950
_020F1D54: .word 0x02150970
_020F1D58: .word 0x021509E0
_020F1D5C: .word WmReceiveFifo
	arm_func_end WmInitCore

	arm_func_start WM_Init
WM_Init: // 0x020F1D60
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #0xf00
	bl WmInitCore
	cmp r0, #0
	ldreq r1, _020F1D90 // =0x0215094C
	moveq r2, #0
	ldreq r1, [r1]
	streqh r2, [r1, #0x16]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F1D90: .word 0x0215094C
	arm_func_end WM_Init

	arm_func_start WM_GetNextTgid
WM_GetNextTgid: // 0x020F1D94
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r0, _020F1E08 // _0211F9B8
	ldr r0, [r0]
	cmp r0, #0x10000
	bne _020F1DDC
	bl RTC_Init
	add r0, sp, #0
	bl RTC_GetTime
	cmp r0, #0
	bne _020F1DDC
	ldr r2, [sp, #8]
	ldr r0, [sp, #4]
	ldr r1, _020F1E08 // _0211F9B8
	add r0, r2, r0, lsl #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [r1]
_020F1DDC:
	ldr r1, _020F1E08 // _0211F9B8
	ldr r0, [r1]
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r2, lsl #0x10
	str r2, [r1]
	mov r0, r0, lsr #0x10
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F1E08: .word _0211F9B8
	arm_func_end WM_GetNextTgid

	arm_func_start WM_GetOtherElements
WM_GetOtherElements: // 0x020F1E0C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x88
	ldrh r2, [r1, #0x3c]
	mov lr, r0
	cmp r2, #0
	beq _020F1E58
	mov r0, #0
	add r5, sp, #0
	strb r0, [sp]
	mov r4, #8
_020F1E34:
	ldmia r5!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	subs r4, r4, #1
	bne _020F1E34
	ldr r0, [r5]
	add sp, sp, #0x88
	str r0, [lr]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F1E58:
	ldrh r0, [r1, #0x3e]
	strb r0, [sp]
	ldrb r0, [sp]
	cmp r0, #0
	bne _020F1E98
	add r5, sp, #0
	mov r4, #8
_020F1E74:
	ldmia r5!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	subs r4, r4, #1
	bne _020F1E74
	ldr r0, [r5]
	add sp, sp, #0x88
	str r0, [lr]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F1E98:
	cmp r0, #0x10
	movhi r0, #0x10
	strhib r0, [sp]
	ldrh r2, [r1]
	ldrb r3, [sp]
	mov r0, #0
	mov r2, r2, lsl #1
	sub r4, r2, #0x40
	cmp r3, #0
	add r3, r1, #0x40
	mov r2, r0
	and r1, r4, #0xff
	ble _020F1F4C
	add ip, sp, #0
_020F1ED0:
	ldrb r5, [r3]
	add r6, ip, r2, lsl #3
	add r4, r3, #2
	strb r5, [r6, #4]
	ldrb r5, [r3, #1]
	strb r5, [r6, #5]
	str r4, [r6, #8]
	ldrb r4, [r6, #5]
	add r4, r4, #2
	and r5, r4, #0xff
	add r0, r0, r5
	and r0, r0, #0xff
	cmp r0, r1
	bls _020F1F38
	mov r0, #0
	strb r0, [sp]
	mov r4, #8
_020F1F14:
	ldmia ip!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	subs r4, r4, #1
	bne _020F1F14
	ldr r0, [ip]
	add sp, sp, #0x88
	str r0, [lr]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F1F38:
	ldrb r4, [sp]
	add r2, r2, #1
	add r3, r3, r5
	cmp r2, r4
	blt _020F1ED0
_020F1F4C:
	add r4, sp, #0
	mov ip, #8
_020F1F54:
	ldmia r4!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	subs ip, ip, #1
	bne _020F1F54
	ldr r0, [r4]
	str r0, [lr]
	add sp, sp, #0x88
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end WM_GetOtherElements

	arm_func_start WM_GetDispersionScanPeriod
WM_GetDispersionScanPeriod: // 0x020F1F78
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	add r0, sp, #0
	bl OS_GetMacAddress
	mov r2, #0
	add r1, sp, #0
	mov r3, r2
_020F1F94:
	ldrb r0, [r1]
	add r2, r2, #1
	cmp r2, #6
	add r0, r3, r0
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	add r1, r1, #1
	blt _020F1F94
	ldr r0, _020F2010 // =0x027FFC3C
	mov r1, #0xd
	ldr r0, [r0]
	ldr r2, _020F2014 // =0x66666667
	add r0, r3, r0
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mul r0, r3, r1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	smull r0, r1, r2, r3
	mov r1, r1, asr #2
	mov r0, r3, lsr #0x1f
	ldr r2, _020F2018 // =0x0000000A
	add r1, r0, r1
	smull r0, r1, r2, r1
	sub r1, r3, r0
	add r0, r1, #0x1e
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F2010: .word 0x027FFC3C
_020F2014: .word 0x66666667
_020F2018: .word 0x0000000A
	arm_func_end WM_GetDispersionScanPeriod

	arm_func_start WM_GetDispersionBeaconPeriod
WM_GetDispersionBeaconPeriod: // 0x020F201C
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	add r0, sp, #0
	bl OS_GetMacAddress
	mov r2, #0
	add r1, sp, #0
	mov r3, r2
_020F2038:
	ldrb r0, [r1]
	add r2, r2, #1
	cmp r2, #6
	add r0, r3, r0
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	add r1, r1, #1
	blt _020F2038
	ldr r0, _020F20B4 // =0x027FFC3C
	mov r1, #7
	ldr r0, [r0]
	ldr r2, _020F20B8 // =0x66666667
	add r0, r3, r0
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mul r0, r3, r1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	smull r0, r1, r2, r3
	mov r1, r1, asr #3
	mov r0, r3, lsr #0x1f
	ldr r2, _020F20BC // =0x00000014
	add r1, r0, r1
	smull r0, r1, r2, r1
	sub r1, r3, r0
	add r0, r1, #0xc8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F20B4: .word 0x027FFC3C
_020F20B8: .word 0x66666667
_020F20BC: .word 0x00000014
	arm_func_end WM_GetDispersionBeaconPeriod

	arm_func_start WM_GetLinkLevel
WM_GetLinkLevel: // 0x020F20C0
	stmdb sp!, {r4, lr}
	bl WMi_GetSystemWork
	mov r4, r0
	bl WMi_CheckInitialized
	cmp r0, #0
	movne r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	ldr r0, [r4, #4]
	mov r1, #2
	bl DC_InvalidateRange
	ldr r2, [r4, #4]
	ldrh r0, [r2]
	cmp r0, #9
	beq _020F2110
	cmp r0, #0xa
	beq _020F213C
	cmp r0, #0xb
	beq _020F213C
	b _020F2158
_020F2110:
	ldr r0, _020F2164 // =0x00000182
	mov r1, #2
	add r0, r2, r0
	bl DC_InvalidateRange
	ldr r2, [r4, #4]
	add r0, r2, #0x100
	ldrh r0, [r0, #0x82]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
_020F213C:
	add r0, r2, #0xbc
	mov r1, #2
	bl DC_InvalidateRange
	ldr r0, [r4, #4]
	ldrh r0, [r0, #0xbc]
	ldmia sp!, {r4, lr}
	bx lr
_020F2158:
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F2164: .word 0x00000182
	arm_func_end WM_GetLinkLevel

	arm_func_start WM_GetAllowedChannel
WM_GetAllowedChannel: // 0x020F2168
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WMi_CheckInitialized
	cmp r0, #0
	movne r0, #0x8000
	ldreq r0, _020F2190 // =0x027FFCFA
	ldreqh r0, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F2190: .word 0x027FFCFA
	arm_func_end WM_GetAllowedChannel

	arm_func_start WM_ReadMPData
WM_ReadMPData: // 0x020F2194
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x40
	mov r5, r0
	mov r4, r1
	bl WMi_GetSystemWork
	mov r6, r0
	bl WMi_CheckInitialized
	cmp r0, #0
	addne sp, sp, #0x40
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	cmp r4, #1
	blo _020F21D4
	cmp r4, #0xf
	bls _020F21E4
_020F21D4:
	add sp, sp, #0x40
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F21E4:
	ldr r2, [r6, #4]
	ldr r0, _020F2294 // =0x00000182
	mov r1, #2
	add r0, r2, r0
	bl DC_InvalidateRange
	ldr r0, [r6, #4]
	mov r1, #1
	add r0, r0, #0x100
	ldrh r2, [r0, #0x82]
	mov r0, r1, lsl r4
	ands r0, r2, r0
	addeq sp, sp, #0x40
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldrh r0, [r5, #4]
	cmp r0, #0
	addeq sp, sp, #0x40
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	add r0, r5, #0xa
	str r0, [sp]
	mov r3, #0
	add r2, sp, #0
_020F2248:
	ldr r0, [r2, r3, lsl #2]
	ldrh r1, [r0, #4]
	cmp r4, r1
	addeq sp, sp, #0x40
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	add r3, r3, #1
	sub r0, r3, #1
	ldrh r1, [r5, #6]
	ldr r0, [r2, r0, lsl #2]
	add r0, r1, r0
	str r0, [r2, r3, lsl #2]
	ldrh r0, [r5, #4]
	cmp r3, r0
	blt _020F2248
	mov r0, #0
	add sp, sp, #0x40
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020F2294: .word 0x00000182
	arm_func_end WM_ReadMPData

	arm_func_start WM_GetMPReceiveBufferSize
WM_GetMPReceiveBufferSize: // 0x020F2298
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl WMi_GetSystemWork
	mov r4, r0
	mov r0, #2
	mov r1, #7
	mov r2, #8
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	ldr r0, [r4, #4]
	mov r1, #4
	add r0, r0, #0xc
	bl DC_InvalidateRange
	ldr r1, [r4, #4]
	ldr r0, [r1, #0xc]
	cmp r0, #1
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	add r0, r1, #0x188
	mov r1, #2
	bl DC_InvalidateRange
	ldr r1, [r4, #4]
	add r0, r1, #0x100
	ldrh r0, [r0, #0x88]
	cmp r0, #0
	moveq r5, #1
	add r0, r1, #0x3e
	mov r1, #2
	movne r5, #0
	bl DC_InvalidateRange
	cmp r5, #1
	ldr r0, [r4, #4]
	addne sp, sp, #4
	ldrh r5, [r0, #0x3e]
	addne r0, r5, #0x51
	bicne r0, r0, #0x1f
	movne r0, r0, lsl #1
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	add r0, r0, #0xf8
	mov r1, #2
	bl DC_InvalidateRange
	ldr r0, [r4, #4]
	add r1, r5, #0xc
	ldrh r0, [r0, #0xf8]
	mul r0, r1, r0
	add r0, r0, #0x29
	bic r0, r0, #0x1f
	mov r0, r0, lsl #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WM_GetMPReceiveBufferSize

	arm_func_start WM_GetMPSendBufferSize
WM_GetMPSendBufferSize: // 0x020F2380
	stmdb sp!, {r4, lr}
	bl WMi_GetSystemWork
	mov r4, r0
	mov r0, #2
	mov r1, #7
	mov r2, #8
	bl WMi_CheckStateEx
	cmp r0, #0
	movne r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	ldr r0, [r4, #4]
	mov r1, #4
	add r0, r0, #0xc
	bl DC_InvalidateRange
	ldr r1, [r4, #4]
	ldr r0, [r1, #0xc]
	cmp r0, #1
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	add r0, r1, #0x3c
	mov r1, #4
	bl DC_InvalidateRange
	ldr r0, [r4, #4]
	ldrh r0, [r0, #0x3c]
	add r0, r0, #0x1f
	bic r0, r0, #0x1f
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WM_GetMPSendBufferSize

	arm_func_start WM_ReadStatus
WM_ReadStatus: // 0x020F23F8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl WMi_GetSystemWork
	mov r4, r0
	bl WMi_CheckInitialized
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	cmp r5, #0
	addeq sp, sp, #4
	moveq r0, #6
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r0, [r4, #4]
	mov r1, #0x7c0
	bl DC_InvalidateRange
	ldr r0, [r4, #4]
	mov r1, r5
	mov r2, #0x7c0
	bl MIi_CpuCopyFast
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WM_ReadStatus

	arm_func_start WM_SetPortCallback
WM_SetPortCallback: // 0x020F2460
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x48
	movs r5, r1
	mov r6, r0
	mov r4, r2
	beq _020F24C8
	add r0, sp, #0
	mov r1, #0
	mov r2, #0x44
	bl MI_CpuFill8
	mov r3, #0
	ldr r1, _020F253C // =0x0000FFFF
	mov r7, #0x82
	mov r2, #0x19
	add r0, sp, #0x14
	strh r7, [sp]
	strh r3, [sp, #2]
	strh r2, [sp, #4]
	strh r6, [sp, #6]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	strh r3, [sp, #0x10]
	strh r1, [sp, #0x1a]
	str r4, [sp, #0x1c]
	strh r3, [sp, #0x12]
	bl OS_GetMacAddress
_020F24C8:
	bl OS_DisableInterrupts
	mov r8, r0
	bl WMi_CheckInitialized
	movs r7, r0
	beq _020F24F4
	mov r0, r8
	bl OS_RestoreInterrupts
	add sp, sp, #0x48
	mov r0, r7
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F24F4:
	bl WMi_GetSystemWork
	add r0, r0, r6, lsl #2
	str r5, [r0, #0xcc]
	str r4, [r0, #0x10c]
	cmp r5, #0
	beq _020F2524
	bl WM_GetConnectedAIDs
	strh r0, [sp, #0x22]
	bl WM_GetAID
	strh r0, [sp, #0x20]
	add r0, sp, #0
	blx r5
_020F2524:
	mov r0, r8
	bl OS_RestoreInterrupts
	mov r0, #0
	add sp, sp, #0x48
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020F253C: .word 0x0000FFFF
	arm_func_end WM_SetPortCallback

	arm_func_start WM_SetIndCallback
WM_SetIndCallback: // 0x020F2540
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl OS_DisableInterrupts
	mov r5, r0
	bl WMi_CheckInitialized
	movs r4, r0
	beq _020F2570
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F2570:
	bl WMi_GetSystemWork
	str r6, [r0, #0xc8]
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end WM_SetIndCallback

	arm_func_start WM_Disconnect
WM_Disconnect: // 0x020F258C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	mov r5, r1
	bl WMi_GetSystemWork
	mov r1, #0xa
	mov r4, r0
	str r1, [sp]
	mov ip, #0xb
	mov r0, #5
	mov r1, #7
	mov r2, #9
	mov r3, #8
	str ip, [sp, #4]
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	ldr r2, [r4, #4]
	ldrh r0, [r2]
	cmp r0, #7
	beq _020F25F0
	cmp r0, #9
	bne _020F264C
_020F25F0:
	cmp r5, #1
	blo _020F2600
	cmp r5, #0xf
	bls _020F2610
_020F2600:
	add sp, sp, #8
	mov r0, #6
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F2610:
	ldr r0, _020F2690 // =0x00000182
	mov r1, #2
	add r0, r2, r0
	bl DC_InvalidateRange
	ldr r0, [r4, #4]
	mov r1, #1
	add r0, r0, #0x100
	ldrh r2, [r0, #0x82]
	mov r0, r1, lsl r5
	ands r0, r2, r0
	bne _020F2660
	add sp, sp, #8
	mov r0, #7
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F264C:
	cmp r5, #0
	addne sp, sp, #8
	movne r0, #6
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
_020F2660:
	mov r1, r6
	mov r0, #0xd
	bl WMi_SetCallbackTable
	mov r1, #1
	mov r2, r1, lsl r5
	mov r0, #0xd
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020F2690: .word 0x00000182
	arm_func_end WM_Disconnect

	arm_func_start WM_StartConnectEx
WM_StartConnectEx: // 0x020F2694
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x2c
	mov r7, r0
	mov r6, r1
	mov r0, #1
	mov r1, #2
	mov r5, r2
	mov r4, r3
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #0x2c
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	cmp r6, #0
	addeq sp, sp, #0x2c
	moveq r0, #6
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldrh r1, [r6]
	mov r0, r6
	mov r1, r1, lsl #1
	bl DC_StoreRange
	bl WMi_GetSystemWork
	add r1, r0, #0x100
	mov r2, #0
	strh r2, [r1, #0x50]
	str r2, [r0, #0x14c]
	mov r1, r7
	mov r0, #0xc
	bl WMi_SetCallbackTable
	mov r0, #0xc
	strh r0, [sp]
	str r6, [sp, #4]
	cmp r5, #0
	beq _020F2734
	add r1, sp, #8
	mov r0, r5
	mov r2, #0x18
	bl MI_CpuCopy8
	b _020F2744
_020F2734:
	add r0, sp, #8
	mov r1, #0
	mov r2, #0x18
	bl MI_CpuFill8
_020F2744:
	ldrh r2, [sp, #0x40]
	add r0, sp, #0
	mov r1, #0x28
	str r4, [sp, #0x20]
	strh r2, [sp, #0x26]
	bl WMi_SendCommandDirect
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end WM_StartConnectEx

	arm_func_start WM_EndScan
WM_EndScan: // 0x020F2770
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #1
	mov r1, #5
	bl WMi_CheckStateEx
	cmp r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r1, r4
	mov r0, #0xb
	bl WMi_SetCallbackTable
	mov r0, #0xb
	mov r1, #0
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WM_EndScan

	arm_func_start WM_StartScanEx
WM_StartScanEx: // 0x020F27B8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x3c
	mov r5, r0
	mov r0, #3
	mov r4, r1
	mov r2, r0
	mov r1, #2
	mov r3, #5
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #0x3c
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	cmp r4, #0
	addeq sp, sp, #0x3c
	moveq r0, #6
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r0, [r4]
	cmp r0, #0
	addeq sp, sp, #0x3c
	moveq r0, #6
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldrh r0, [r4, #4]
	cmp r0, #0x400
	addhi sp, sp, #0x3c
	movhi r0, #6
	ldmhiia sp!, {r4, r5, lr}
	bxhi lr
	ldrh r0, [r4, #0x12]
	cmp r0, #0x20
	addhi sp, sp, #0x3c
	movhi r0, #6
	ldmhiia sp!, {r4, r5, lr}
	bxhi lr
	ldrh r1, [r4, #0x10]
	cmp r1, #0
	beq _020F2878
	cmp r1, #1
	beq _020F2878
	cmp r1, #2
	beq _020F2878
	cmp r1, #3
	addne sp, sp, #0x3c
	movne r0, #6
	ldmneia sp!, {r4, r5, lr}
	bxne lr
_020F2878:
	ldr r0, _020F2934 // =0x0000FFFE
	add r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _020F28A8
	ldrh r0, [r4, #0x34]
	cmp r0, #0x20
	addhi sp, sp, #0x3c
	movhi r0, #6
	ldmhiia sp!, {r4, r5, lr}
	bxhi lr
_020F28A8:
	mov r1, r5
	mov r0, #0x26
	bl WMi_SetCallbackTable
	mov r0, #0x26
	strh r0, [sp]
	ldrh r2, [r4, #6]
	add r1, sp, #0xc
	add r0, r4, #0xa
	strh r2, [sp, #2]
	ldr r3, [r4]
	mov r2, #6
	str r3, [sp, #4]
	ldrh r3, [r4, #4]
	strh r3, [sp, #8]
	ldrh r3, [r4, #8]
	strh r3, [sp, #0xa]
	bl MI_CpuCopy8
	ldrh r2, [r4, #0x10]
	add r1, sp, #0x16
	add r0, r4, #0x14
	strh r2, [sp, #0x12]
	ldrh r3, [r4, #0x34]
	mov r2, #0x20
	strh r3, [sp, #0x36]
	ldrh r3, [r4, #0x12]
	strh r3, [sp, #0x14]
	bl MI_CpuCopy8
	add r0, sp, #0
	mov r1, #0x3c
	bl WMi_SendCommandDirect
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F2934: .word 0x0000FFFE
	arm_func_end WM_StartScanEx

	arm_func_start WM_StartScan
WM_StartScan: // 0x020F2938
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r5, r0
	mov r0, #3
	mov r4, r1
	mov r2, r0
	mov r1, #2
	mov r3, #5
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	cmp r4, #0
	addeq sp, sp, #0x14
	moveq r0, #6
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r0, [r4]
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, #6
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldrh r0, [r4, #4]
	cmp r0, #1
	blo _020F29AC
	cmp r0, #0xe
	bls _020F29BC
_020F29AC:
	add sp, sp, #0x14
	mov r0, #6
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F29BC:
	mov r1, r5
	mov r0, #0xa
	bl WMi_SetCallbackTable
	mov r0, #0xa
	strh r0, [sp]
	ldrh r2, [r4, #4]
	add r0, sp, #0
	mov r1, #0x10
	strh r2, [sp, #2]
	ldr r2, [r4]
	str r2, [sp, #4]
	ldrh r2, [r4, #6]
	strh r2, [sp, #8]
	ldrb r2, [r4, #8]
	strb r2, [sp, #0xa]
	ldrb r2, [r4, #9]
	strb r2, [sp, #0xb]
	ldrb r2, [r4, #0xa]
	strb r2, [sp, #0xc]
	ldrb r2, [r4, #0xb]
	strb r2, [sp, #0xd]
	ldrb r2, [r4, #0xc]
	strb r2, [sp, #0xe]
	ldrb r2, [r4, #0xd]
	strb r2, [sp, #0xf]
	bl WMi_SendCommandDirect
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WM_StartScan

	arm_func_start WM_EndParent
WM_EndParent: // 0x020F2A38
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #1
	mov r1, #7
	bl WMi_CheckStateEx
	cmp r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r1, r4
	mov r0, #9
	bl WMi_SetCallbackTable
	mov r0, #9
	mov r1, #0
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WM_EndParent

	arm_func_start WM_StartParent
WM_StartParent: // 0x020F2A80
	ldr ip, _020F2A8C // =WMi_StartParentEx
	mov r1, #1
	bx ip
	.align 2, 0
_020F2A8C: .word WMi_StartParentEx
	arm_func_end WM_StartParent

	arm_func_start WMi_StartParentEx
WMi_StartParentEx: // 0x020F2A90
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	mov r0, #1
	mov r1, #2
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	bl WMi_GetSystemWork
	add r1, r0, #0x100
	mov r2, #0
	strh r2, [r1, #0x50]
	str r2, [r0, #0x14c]
	mov r1, r5
	mov r0, #8
	bl WMi_SetCallbackTable
	mov r2, r4
	mov r0, #8
	mov r1, #1
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WMi_StartParentEx

	arm_func_start WmCheckParentParameter
WmCheckParentParameter: // 0x020F2B00
	ldrh r1, [r0, #4]
	cmp r1, #0x70
	movhi r0, #0
	bxhi lr
	ldrh r1, [r0, #0x18]
	cmp r1, #0xa
	blo _020F2B24
	cmp r1, #0x3e8
	bls _020F2B2C
_020F2B24:
	mov r0, #0
	bx lr
_020F2B2C:
	ldrh r0, [r0, #0x32]
	cmp r0, #1
	blo _020F2B40
	cmp r0, #0xe
	bls _020F2B48
_020F2B40:
	mov r0, #0
	bx lr
_020F2B48:
	mov r0, #1
	bx lr
	arm_func_end WmCheckParentParameter

	arm_func_start WM_SetParentParameter
WM_SetParentParameter: // 0x020F2B50
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	mov r0, #1
	mov r1, #2
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	cmp r4, #0
	addeq sp, sp, #4
	moveq r0, #6
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldrh r0, [r4, #4]
	cmp r0, #0
	beq _020F2BB4
	ldr r0, [r4]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #6
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
_020F2BB4:
	ldrh r1, [r4, #0x14]
	ldrh r0, [r4, #0x34]
	cmp r1, #0
	movne r2, #0x2a
	moveq r2, #0
	add r0, r0, r2
	cmp r0, #0x200
	bgt _020F2BF0
	ldrh r0, [r4, #0x36]
	cmp r1, #0
	movne r1, #6
	moveq r1, #0
	add r0, r0, r1
	cmp r0, #0x200
	ble _020F2C00
_020F2BF0:
	add sp, sp, #4
	mov r0, #6
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F2C00:
	mov r0, r4
	bl WmCheckParentParameter
	mov r1, r5
	mov r0, #7
	bl WMi_SetCallbackTable
	mov r0, r4
	mov r1, #0x40
	bl DC_StoreRange
	ldrh r1, [r4, #4]
	cmp r1, #0
	beq _020F2C34
	ldr r0, [r4]
	bl DC_StoreRange
_020F2C34:
	mov r2, r4
	mov r0, #7
	mov r1, #1
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WM_SetParentParameter

	arm_func_start WM_End
WM_End: // 0x020F2C58
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #1
	mov r1, #2
	bl WMi_CheckStateEx
	cmp r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r1, r4
	mov r0, #2
	bl WMi_SetCallbackTable
	mov r0, #2
	mov r1, #0
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WM_End

	arm_func_start WM_Reset
WM_Reset: // 0x020F2CA0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WMi_CheckIdle
	cmp r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r1, r4
	mov r0, #1
	bl WMi_SetCallbackTable
	mov r0, #1
	mov r1, #0
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WM_Reset

	arm_func_start WM_Initialize
WM_Initialize: // 0x020F2CE0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r1, r2
	bl WM_Init
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r1, r4
	mov r0, #0
	bl WMi_SetCallbackTable
	bl WMi_GetSystemWork
	mov r3, r0
	ldr r1, [r3, #0x10]
	mov r0, #0
	str r1, [sp]
	ldr r2, [r3]
	ldr r3, [r3, #4]
	mov r1, #3
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WM_Initialize

	arm_func_start WM_PowerOff
WM_PowerOff: // 0x020F2D48
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #1
	mov r1, #2
	bl WMi_CheckStateEx
	cmp r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r1, r4
	mov r0, #6
	bl WMi_SetCallbackTable
	mov r0, #6
	mov r1, #0
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WM_PowerOff

	arm_func_start WM_PowerOn
WM_PowerOn: // 0x020F2D90
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #1
	mov r1, r0
	bl WMi_CheckStateEx
	cmp r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r1, r4
	mov r0, #5
	bl WMi_SetCallbackTable
	mov r0, #5
	mov r1, #0
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WM_PowerOn

	arm_func_start WM_Disable
WM_Disable: // 0x020F2DD8
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #1
	mov r1, r0
	bl WMi_CheckStateEx
	cmp r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r1, r4
	mov r0, #4
	bl WMi_SetCallbackTable
	mov r0, #4
	mov r1, #0
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WM_Disable

	arm_func_start WM_Enable
WM_Enable: // 0x020F2E20
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r0, #1
	mov r1, #0
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r1, r4
	mov r0, #3
	bl WMi_SetCallbackTable
	bl WMi_GetSystemWork
	mov r3, r0
	ldr r1, [r3, #0x10]
	mov r0, #3
	str r1, [sp]
	ldr r2, [r3]
	ldr r3, [r3, #4]
	mov r1, r0
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WM_Enable

	arm_func_start WM_EndMP
WM_EndMP: // 0x020F2E8C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl WMi_GetSystemWork
	mov r4, r0
	mov r0, #2
	mov r1, #9
	mov r2, #0xa
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	ldr r0, [r4, #4]
	mov r1, #4
	add r0, r0, #0xc
	bl DC_InvalidateRange
	ldr r0, [r4, #4]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #3
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	mov r1, r5
	mov r0, #0x10
	bl WMi_SetCallbackTable
	mov r0, #0x10
	mov r1, #0
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WM_EndMP

	arm_func_start WM_SetMPDataToPort
WM_SetMPDataToPort: // 0x020F2F18
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x14
	mov r9, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	mov r5, #1
	bl WMi_GetSystemWork
	ldr r4, [r0, #4]
	mov r0, #2
	mov r1, #9
	mov r2, #0xa
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	add r0, r4, #0x3c
	mov r1, #2
	bl DC_InvalidateRange
	add r0, r4, #0x188
	mov r1, #2
	bl DC_InvalidateRange
	add r0, r4, #0x100
	ldrh r0, [r0, #0x88]
	cmp r0, #0
	bne _020F2FA8
	ldr r0, _020F3070 // =0x00000182
	mov r1, #2
	add r0, r4, r0
	bl DC_InvalidateRange
	add r2, r4, #0x100
	add r0, r4, #0x86
	mov r1, #2
	ldrh r5, [r2, #0x82]
	bl DC_InvalidateRange
_020F2FA8:
	cmp r7, #0
	addeq sp, sp, #0x14
	moveq r0, #6
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	cmp r5, #0
	addeq sp, sp, #0x14
	moveq r0, #7
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	add r0, r4, #0x7c
	mov r1, #2
	bl DC_InvalidateRange
	ldr r0, [r4, #0x7c]
	cmp r7, r0
	addeq sp, sp, #0x14
	moveq r0, #6
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	cmp r6, #0x200
	addhi sp, sp, #0x14
	movhi r0, #6
	ldmhiia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxhi lr
	cmp r6, #0
	addeq sp, sp, #0x14
	moveq r0, #6
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	mov r0, r7
	mov r1, r6
	bl DC_StoreRange
	ldrh r2, [sp, #0x30]
	ldrh r1, [sp, #0x34]
	ldrh r0, [sp, #0x38]
	str r2, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r9, [sp, #0xc]
	mov r2, r7
	mov r3, r6
	mov r0, #0xf
	mov r1, #7
	str r8, [sp, #0x10]
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020F3070: .word 0x00000182
	arm_func_end WM_SetMPDataToPort

	arm_func_start WM_StartMP
WM_StartMP: // 0x020F3074
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x24
	mov r6, r1
	mov r7, r0
	mov r5, r2
	add r1, sp, #8
	mov r0, #0
	mov r2, #0x1c
	mov r4, r3
	bl MIi_CpuClear32
	ldrh ip, [sp, #0x3c]
	mov r0, #3
	str r0, [sp, #8]
	ldrh lr, [sp, #0x38]
	strh ip, [sp, #0xc]
	strh ip, [sp, #0xe]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	add ip, sp, #8
	str lr, [sp]
	str ip, [sp, #4]
	bl WMi_StartMP
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end WM_StartMP

	arm_func_start WM_StartMPEx
WM_StartMPEx: // 0x020F30E0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x28
	mov r6, r1
	mov r7, r0
	mov r5, r2
	add r1, sp, #8
	mov r0, #0
	mov r2, #0x1c
	mov r4, r3
	bl MIi_CpuClear32
	ldrh lr, [sp, #0x44]
	ldr r1, [sp, #0x58]
	ldrh ip, [sp, #0x48]
	ldr r0, [sp, #0x54]
	ldr r8, _020F3180 // =0x00001E03
	cmp r0, #0
	ldr r3, [sp, #0x4c]
	ldr r2, [sp, #0x50]
	strb r1, [sp, #0x22]
	strh ip, [sp, #0x1e]
	strb r3, [sp, #0x20]
	strb r2, [sp, #0x21]
	ldrh r1, [sp, #0x40]
	str r8, [sp, #8]
	orrne r0, r8, #4
	strne r0, [sp, #8]
	strh lr, [sp, #0xc]
	strh lr, [sp, #0xe]
	strneh lr, [sp, #0x10]
	str r1, [sp]
	add ip, sp, #8
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	str ip, [sp, #4]
	bl WMi_StartMP
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020F3180: .word 0x00001E03
	arm_func_end WM_StartMPEx

	arm_func_start WMi_StartMP
WMi_StartMP: // 0x020F3184
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x34
	mov r9, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	bl WMi_GetSystemWork
	ldr r5, [r0, #4]
	mov r0, #2
	mov r1, #7
	mov r2, #8
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #0x34
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	add r0, r5, #0x188
	mov r1, #2
	bl DC_InvalidateRange
	add r0, r5, #0xc6
	mov r1, #2
	bl DC_InvalidateRange
	add r0, r5, #0x100
	ldrh r0, [r0, #0x88]
	cmp r0, #0
	beq _020F3204
	ldrh r0, [r5, #0xc6]
	cmp r0, #1
	addne sp, sp, #0x34
	movne r0, #3
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
_020F3204:
	add r0, r5, #0xc
	mov r1, #4
	bl DC_InvalidateRange
	ldr r0, [r5, #0xc]
	cmp r0, #1
	addeq sp, sp, #0x34
	moveq r0, #3
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	ands r0, r7, #0x3f
	addne sp, sp, #0x34
	movne r0, #6
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	ldrh r4, [sp, #0x50]
	ands r0, r4, #0x1f
	addne sp, sp, #0x34
	movne r0, #6
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	add r0, r5, #0x9c
	mov r1, #2
	bl DC_InvalidateRange
	ldrh r0, [r5, #0x9c]
	cmp r0, #0
	bne _020F329C
	bl WM_GetMPReceiveBufferSize
	cmp r7, r0
	addlt sp, sp, #0x34
	movlt r0, #6
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxlt lr
	bl WM_GetMPSendBufferSize
	cmp r4, r0
	addlt sp, sp, #0x34
	movlt r0, #6
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxlt lr
_020F329C:
	mov r1, r9
	mov r0, #0xe
	bl WMi_SetCallbackTable
	add r1, sp, #0
	mov r0, #0
	mov r2, #0x30
	bl MIi_CpuClear32
	ldrh r3, [sp, #0x50]
	mov r4, r7, lsr #1
	mov r5, #0xe
	ldr r0, [sp, #0x54]
	add r1, sp, #0x14
	mov r2, #0x1c
	strh r5, [sp]
	str r8, [sp, #4]
	str r4, [sp, #8]
	str r6, [sp, #0xc]
	str r3, [sp, #0x10]
	bl MIi_CpuCopy32
	add r0, sp, #0
	mov r1, #0x30
	bl WMi_SendCommandDirect
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end WMi_StartMP

	arm_func_start WM_EndDCF
WM_EndDCF: // 0x020F3308
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl WMi_GetSystemWork
	mov r4, r0
	mov r0, #1
	mov r1, #0xb
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	ldr r0, [r4, #4]
	mov r1, #4
	add r0, r0, #0x10
	bl DC_InvalidateRange
	ldr r0, [r4, #4]
	ldr r0, [r0, #0x10]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #3
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	mov r1, r5
	mov r0, #0x13
	bl WMi_SetCallbackTable
	mov r0, #0x13
	mov r1, #0
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WM_EndDCF

	arm_func_start WM_SetDCFData
WM_SetDCFData: // 0x020F3390
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl WMi_GetSystemWork
	mov r8, r0
	mov r0, #1
	mov r1, #0xb
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #0x10
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	ldr r0, [r8, #4]
	mov r1, #4
	add r0, r0, #0x10
	bl DC_InvalidateRange
	ldr r0, [r8, #4]
	ldr r0, [r0, #0x10]
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #3
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldr r0, _020F3468 // =0x000005E4
	cmp r4, r0
	addhi sp, sp, #0x10
	movhi r0, #6
	ldmhiia sp!, {r4, r5, r6, r7, r8, lr}
	bxhi lr
	mov r0, r5
	mov r1, r4
	bl DC_StoreRange
	mov r1, r7
	mov r0, #0x12
	bl WMi_SetCallbackTable
	add r1, sp, #8
	mov r0, r6
	mov r2, #6
	bl MI_CpuCopy8
	str r5, [sp]
	str r4, [sp, #4]
	ldr r2, [sp, #8]
	ldr r3, [sp, #0xc]
	mov r0, #0x12
	mov r1, #4
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020F3468: .word 0x000005E4
	arm_func_end WM_SetDCFData

	arm_func_start WM_StartDCF
WM_StartDCF: // 0x020F346C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl WMi_GetSystemWork
	mov r4, r0
	mov r0, #1
	mov r1, #8
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	ldr r0, [r4, #4]
	mov r1, #4
	add r0, r0, #0x10
	bl DC_InvalidateRange
	ldr r0, [r4, #4]
	ldr r0, [r0, #0x10]
	cmp r0, #1
	addeq sp, sp, #4
	moveq r0, #3
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	cmp r5, #0x10
	addlo sp, sp, #4
	movlo r0, #6
	ldmloia sp!, {r4, r5, r6, r7, lr}
	bxlo lr
	cmp r6, #0
	addeq sp, sp, #4
	moveq r0, #6
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r0, r6
	mov r1, r5
	bl DC_StoreRange
	mov r1, r7
	mov r0, #0x11
	bl WMi_SetCallbackTable
	mov r2, r6
	mov r3, r5
	mov r0, #0x11
	mov r1, #2
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end WM_StartDCF

	arm_func_start WmDataSharingGetNextIndex
WmDataSharingGetNextIndex: // 0x020F3538
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov ip, #1
	mov r3, ip, lsl r3
	sub r3, r3, #1
	mov r5, r0
	and r0, r1, r3
	mov r4, r2
	bl MATH_CountPopulation
	add r1, r5, #0x800
	ldrh r1, [r1, #0x10]
	mla r0, r1, r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmDataSharingGetNextIndex

	arm_func_start WM_GetSharedDataAddress
WM_GetSharedDataAddress: // 0x020F3574
	stmdb sp!, {r4, lr}
	mov r4, r1
	ldrh lr, [r4, #2]
	cmp r0, #0
	mov r3, r2
	mov r1, #1
	mov ip, r1, lsl r3
	ldrh r1, [r4]
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	cmp r4, #0
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ands r2, r1, ip
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ands r2, lr, ip
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	add r2, r4, #4
	bl WmDataSharingGetNextIndex
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WM_GetSharedDataAddress

	arm_func_start WmDataSharingSendDataSet
WmDataSharingSendDataSet: // 0x020F35E0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x10
	mov r10, r0
	mov r9, r1
	bl OS_DisableInterrupts
	add r1, r10, #0x800
	ldrh r1, [r1, #8]
	mov r7, r0
	mov r1, r1, lsl #9
	ldrh r1, [r10, r1]
	cmp r1, #0
	bne _020F373C
	bl WMi_GetMPReadyAIDs
	add r1, r10, #0x800
	ldrh r6, [r1, #8]
	mov r5, r0
	ldrh r1, [r1, #0x18]
	add r0, r6, #1
	and r0, r0, #3
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	cmp r1, #1
	addeq r0, r4, #1
	andeq r0, r0, #3
	moveq r0, r0, lsl #0x10
	moveq r8, r0, lsr #0x10
	movne r8, r4
	add r1, r10, r8, lsl #9
	mov r0, #0
	mov r2, #0x200
	bl MIi_CpuClear16
	add r0, r10, #0x800
	ldrh r3, [r0, #0xe]
	orr r2, r5, #1
	mov r1, r8, lsl #9
	and r2, r3, r2
	strh r2, [r10, r1]
	strh r4, [r0, #8]
	ldrh r0, [r0, #0xe]
	mov r1, r6, lsl #9
	cmp r9, #1
	strh r0, [r10, r1]
	ldreqh r0, [r10, r1]
	biceq r0, r0, #1
	streqh r0, [r10, r1]
	mov r0, r7
	bl OS_RestoreInterrupts
	add r3, r10, #0x800
	ldrh r1, [r3, #0xe]
	mov r4, #1
	ldr r0, _020F374C // =WmDataSharingSetDataCallback
	and r1, r1, r5
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp]
	ldrh r5, [r3, #0x16]
	mov r1, r10
	add r2, r10, r6, lsl #9
	str r5, [sp, #4]
	str r4, [sp, #8]
	ldrh r3, [r3, #0x14]
	bl WM_SetMPDataToPort
	cmp r0, #7
	bne _020F3710
	add r0, r10, r6, lsl #1
	ldr r1, _020F3750 // =0x0000FFFF
	add r0, r0, #0x800
	strh r1, [r0]
	add r0, r10, #0x800
	ldrh r1, [r0, #0xa]
	add sp, sp, #0x10
	add r1, r1, #1
	and r1, r1, #3
	strh r1, [r0, #0xa]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
_020F3710:
	cmp r0, #0
	addeq sp, sp, #0x10
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bxeq lr
	cmp r0, #2
	addne r0, r10, #0x800
	movne r1, #5
	strneh r1, [r0, #0x1c]
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
_020F373C:
	bl OS_RestoreInterrupts
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_020F374C: .word WmDataSharingSetDataCallback
_020F3750: .word 0x0000FFFF
	arm_func_end WmDataSharingSendDataSet

	arm_func_start WmDataSharingReceiveData
WmDataSharingReceiveData: // 0x020F3754
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r3, r1
	mov r0, #1
	mov r0, r0, lsl r3
	add ip, r7, #0x800
	mov r0, r0, lsl #0x10
	ldrh r1, [ip, #0xe]
	mov r5, r0, lsr #0x10
	mov r6, r2
	ands r0, r1, r5
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldrh r4, [ip, #8]
	mov r0, r4, lsl #9
	ldrh r0, [r7, r0]
	ands r0, r5, r0
	bne _020F37E0
	ldrh r0, [ip, #0x18]
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	add r0, r4, #1
	and r0, r0, #3
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	mov r0, r4, lsl #9
	ldrh r0, [r7, r0]
	ands r0, r5, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
_020F37E0:
	add r2, r7, r4, lsl #9
	mov r0, r7
	add r2, r2, #4
	bl WmDataSharingGetNextIndex
	mov r1, r0
	cmp r6, #0
	beq _020F3810
	add r0, r7, #0x800
	ldrh r2, [r0, #0x10]
	mov r0, r6
	bl MIi_CpuCopy16
	b _020F3820
_020F3810:
	add r0, r7, #0x800
	ldrh r2, [r0, #0x10]
	mov r0, #0
	bl MIi_CpuClear16
_020F3820:
	bl OS_DisableInterrupts
	mov r4, r4, lsl #9
	ldrh r3, [r7, r4]
	mvn r1, r5
	add r2, r7, #2
	and r1, r3, r1
	strh r1, [r7, r4]
	ldrh r1, [r2, r4]
	orr r1, r1, r5
	strh r1, [r2, r4]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end WmDataSharingReceiveData

	arm_func_start WmDataSharingReceiveCallback_Child
WmDataSharingReceiveCallback_Child: // 0x020F3858
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldr r7, [r8, #0x1c]
	cmp r7, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldrh r0, [r8, #2]
	cmp r0, #0
	bne _020F3984
	ldrh r0, [r8, #4]
	cmp r0, #0x15
	bgt _020F38C0
	cmp r0, #0x15
	bge _020F38F0
	cmp r0, #9
	ldmgtia sp!, {r4, r5, r6, r7, r8, lr}
	bxgt lr
	cmp r0, #7
	ldmltia sp!, {r4, r5, r6, r7, r8, lr}
	bxlt lr
	cmp r0, #7
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	cmp r0, #9
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F38C0:
	cmp r0, #0x1a
	ldmgtia sp!, {r4, r5, r6, r7, r8, lr}
	bxgt lr
	cmp r0, #0x19
	ldmltia sp!, {r4, r5, r6, r7, r8, lr}
	bxlt lr
	cmp r0, #0x19
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	cmp r0, #0x1a
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F38F0:
	ldr r4, [r8, #0xc]
	ldrh r6, [r8, #0x10]
	ldrh r5, [r4]
	bl WM_GetAID
	add r1, r7, #0x800
	ldrh r1, [r1, #0x14]
	cmp r6, r1
	beq _020F3918
	cmp r6, #0x200
	movhi r6, #0x200
_020F3918:
	cmp r6, #4
	ldmloia sp!, {r4, r5, r6, r7, r8, lr}
	bxlo lr
	mov r1, #1
	mov r0, r1, lsl r0
	ands r0, r5, r0
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	add r0, r7, #0x800
	ldrh r1, [r0, #8]
	mov r0, r4
	mov r2, r6
	add r1, r7, r1, lsl #9
	bl MIi_CpuCopy16
	add r1, r7, #0x800
	ldrh r0, [r1, #8]
	ldrh r2, [r8, #0x1a]
	add r0, r7, r0, lsl #1
	mov r2, r2, asr #1
	add r0, r0, #0x800
	strh r2, [r0]
	ldrh r0, [r1, #8]
	add r0, r0, #1
	and r0, r0, #3
	strh r0, [r1, #8]
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F3984:
	add r0, r7, #0x800
	mov r1, #5
	strh r1, [r0, #0x1c]
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end WmDataSharingReceiveCallback_Child

	arm_func_start WmDataSharingReceiveCallback_Parent
WmDataSharingReceiveCallback_Parent: // 0x020F3998
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, [r0, #0x1c]
	cmp r4, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldrh r1, [r0, #2]
	cmp r1, #0
	bne _020F3AF0
	ldrh r1, [r0, #4]
	cmp r1, #0x15
	bgt _020F39FC
	cmp r1, #0x15
	bge _020F3A30
	cmp r1, #9
	ldmgtia sp!, {r4, r5, r6, lr}
	bxgt lr
	cmp r1, #7
	ldmltia sp!, {r4, r5, r6, lr}
	bxlt lr
	cmp r1, #7
	beq _020F3A54
	cmp r1, #9
	beq _020F3A68
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F39FC:
	cmp r1, #0x1a
	ldmgtia sp!, {r4, r5, r6, lr}
	bxgt lr
	cmp r1, #0x19
	ldmltia sp!, {r4, r5, r6, lr}
	bxlt lr
	cmp r1, #0x19
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	cmp r1, #0x1a
	beq _020F3A68
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F3A30:
	ldrh r1, [r0, #0x12]
	ldr r2, [r0, #0xc]
	mov r0, r4
	bl WmDataSharingReceiveData
	mov r0, r4
	mov r1, #0
	bl WmDataSharingSendDataSet
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F3A54:
	mov r0, r4
	mov r1, #0
	bl WmDataSharingSendDataSet
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F3A68:
	ldrh r5, [r0, #0x12]
	mov r6, #1
	bl OS_DisableInterrupts
	add r1, r4, #0x800
	ldrh lr, [r1, #8]
	mvn ip, r6, lsl r5
	mov r3, lr, lsl #9
	ldrh r2, [r4, r3]
	and r2, r2, ip
	strh r2, [r4, r3]
	ldrh r1, [r1, #0x18]
	cmp r1, #1
	bne _020F3AB8
	add r1, lr, #1
	and r1, r1, #3
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #7
	ldrh r1, [r4, r2]
	and r1, r1, ip
	strh r1, [r4, r2]
_020F3AB8:
	bl OS_RestoreInterrupts
	mov r0, r4
	mov r1, #0
	bl WmDataSharingSendDataSet
	add r0, r4, #0x800
	ldrh r0, [r0, #0x18]
	cmp r0, #1
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	mov r0, r4
	mov r1, #0
	bl WmDataSharingSendDataSet
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F3AF0:
	add r0, r4, #0x800
	mov r1, #5
	strh r1, [r0, #0x1c]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end WmDataSharingReceiveCallback_Parent

	arm_func_start WmDataSharingSetDataCallback
WmDataSharingSetDataCallback: // 0x020F3B04
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl WMi_GetSystemWork
	ldrh r2, [r5, #0xa]
	ldr r1, _020F3C10 // =WmDataSharingReceiveCallback_Parent
	add r0, r0, r2, lsl #2
	ldr r2, [r0, #0xcc]
	ldr r4, [r0, #0x10c]
	cmp r2, r1
	beq _020F3B44
	ldr r0, _020F3C14 // =WmDataSharingReceiveCallback_Child
	cmp r2, r0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
_020F3B44:
	cmp r4, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r0, [r5, #0x20]
	cmp r4, r0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	bl WM_GetAID
	ldrh r1, [r5, #2]
	cmp r1, #0
	bne _020F3BC0
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	add r1, r4, #0x800
	ldrh r0, [r1, #0xa]
	ldrh r2, [r5, #0x1a]
	add sp, sp, #4
	add r0, r4, r0, lsl #1
	mov r2, r2, asr #1
	add r0, r0, #0x800
	strh r2, [r0]
	ldrh r0, [r1, #0xa]
	add r0, r0, #1
	and r0, r0, #3
	strh r0, [r1, #0xa]
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F3BC0:
	cmp r1, #0xa
	bne _020F3BF8
	cmp r0, #0
	addne r0, r4, #0x800
	ldrneh r1, [r0, #0xa]
	add sp, sp, #4
	addne r1, r1, #3
	andne r1, r1, #3
	strneh r1, [r0, #0xa]
	add r0, r4, #0x800
	mov r1, #4
	strh r1, [r0, #0x1c]
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F3BF8:
	add r0, r4, #0x800
	mov r1, #5
	strh r1, [r0, #0x1c]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F3C10: .word WmDataSharingReceiveCallback_Parent
_020F3C14: .word WmDataSharingReceiveCallback_Child
	arm_func_end WmDataSharingSetDataCallback

	arm_func_start WM_StepDataSharing
WM_StepDataSharing: // 0x020F3C18
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r0
	mov r9, r1
	mov r8, r2
	mov r0, #2
	mov r1, #9
	mov r2, #0xa
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	cmp r10, #0
	addeq sp, sp, #0xc
	moveq r0, #6
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	cmp r9, #0
	addeq sp, sp, #0xc
	moveq r0, #6
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	cmp r8, #0
	addeq sp, sp, #0xc
	moveq r0, #6
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	bl WM_GetAID
	movs r4, r0
	bne _020F3C9C
	bl WMi_GetMPReadyAIDs
	mov r7, r0
_020F3C9C:
	add r0, r10, #0x800
	ldrh r0, [r0, #0x1c]
	cmp r0, #5
	addeq sp, sp, #0xc
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	cmp r0, #1
	beq _020F3CD4
	cmp r0, #4
	addne sp, sp, #0xc
	movne r0, #3
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
_020F3CD4:
	cmp r4, #0
	mov r4, #5
	bne _020F3E78
	mov r6, #0
	mov r11, r6
	cmp r0, #4
	bne _020F3D9C
	add r1, r10, #0x800
	mov r3, #1
	strh r3, [r1, #0x1c]
	ldrh r5, [r1, #0xe]
	ldrh r2, [r1, #8]
	ldr r0, _020F3F90 // =WmDataSharingSetDataCallback
	and r5, r5, r7
	mov r5, r5, lsl #0x10
	mov r5, r5, lsr #0x10
	str r5, [sp]
	ldrh r5, [r1, #0x16]
	add r2, r2, #3
	and r2, r2, #3
	str r5, [sp, #4]
	str r3, [sp, #8]
	mov r2, r2, lsl #0x10
	mov r5, r2, lsr #0x10
	ldrh r3, [r1, #0x14]
	mov r1, r10
	add r2, r10, r5, lsl #9
	bl WM_SetMPDataToPort
	cmp r0, #7
	bne _020F3D74
	add r0, r10, r5, lsl #1
	ldr r1, _020F3F94 // =0x0000FFFF
	add r0, r0, #0x800
	strh r1, [r0]
	add r0, r10, #0x800
	ldrh r1, [r0, #0xa]
	add r1, r1, #1
	and r1, r1, #3
	strh r1, [r0, #0xa]
	b _020F3D9C
_020F3D74:
	cmp r0, #0
	beq _020F3D9C
	cmp r0, #2
	addne r0, r10, #0x800
	movne r1, r4
	strneh r1, [r0, #0x1c]
	addne sp, sp, #0xc
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
_020F3D9C:
	add r0, r10, #0x800
	ldrh r2, [r0, #0xc]
	ldrh r1, [r0, #0xa]
	cmp r2, r1
	beq _020F3E34
	mov r4, r2, lsl #9
	ldrh r3, [r10, r4]
	mov r1, r8
	mov r2, #0x200
	orr r3, r3, #1
	strh r3, [r10, r4]
	ldrh r0, [r0, #0xc]
	add r0, r10, r0, lsl #9
	bl MIi_CpuCopy16
	add r1, r10, #0x800
	ldrh r0, [r1, #0xc]
	mov r6, #1
	mov r4, #0
	add r0, r10, r0, lsl #1
	add r0, r0, #0x800
	ldrh r0, [r0]
	strh r0, [r1, #0x1a]
	ldrh r0, [r1, #0xc]
	add r0, r0, #1
	and r0, r0, #3
	strh r0, [r1, #0xc]
	ldrh r0, [r1, #0x18]
	cmp r0, #0
	bne _020F3E30
	cmp r7, #0
	beq _020F3E30
	ldrh r0, [r1, #8]
	mov r0, r0, lsl #9
	ldrh r0, [r10, r0]
	cmp r0, #1
	moveq r11, r6
	beq _020F3E34
_020F3E30:
	mov r11, #0
_020F3E34:
	mov r0, r10
	mov r1, #0
	bl WmDataSharingSendDataSet
	cmp r6, #0
	beq _020F3F80
	mov r0, r10
	mov r2, r9
	mov r1, #0
	bl WmDataSharingReceiveData
	add r0, r10, #0x800
	ldrh r0, [r0, #0x18]
	cmp r0, #0
	bne _020F3F80
	mov r0, r10
	mov r1, r11
	bl WmDataSharingSendDataSet
	b _020F3F80
_020F3E78:
	cmp r0, #4
	mov r0, #0
	addeq r1, r10, #0x800
	moveq r0, #1
	streqh r0, [r1, #0x1c]
	beq _020F3EFC
	add r1, r10, #0x800
	ldrh r2, [r1, #0xc]
	ldrh r1, [r1, #8]
	cmp r2, r1
	beq _020F3EFC
	mov r2, r2, lsl #9
	ldrh r1, [r10, r2]
	ands r3, r1, #1
	orreq r1, r1, #1
	streqh r1, [r10, r2]
	beq _020F3EFC
	mov r1, r8
	add r0, r10, r2
	mov r2, #0x200
	bl MIi_CpuCopy16
	add r2, r10, #0x800
	ldrh r1, [r2, #0xc]
	mov r0, #1
	mov r4, #0
	add r1, r10, r1, lsl #1
	add r1, r1, #0x800
	ldrh r1, [r1]
	strh r1, [r2, #0x1a]
	ldrh r1, [r2, #0xc]
	add r1, r1, #1
	and r1, r1, #3
	strh r1, [r2, #0xc]
_020F3EFC:
	cmp r0, #0
	beq _020F3F80
	add r0, r10, #0x800
	ldrh r1, [r0, #0xa]
	ldrh r2, [r0, #0x10]
	mov r0, r9
	add r1, r10, r1, lsl #9
	add r7, r1, #0x20
	mov r1, r7
	bl MIi_CpuCopy16
	add r3, r10, #0x800
	ldrh r1, [r3, #0xe]
	mov r5, #1
	ldr r0, _020F3F90 // =WmDataSharingSetDataCallback
	str r1, [sp]
	ldrh r6, [r3, #0x16]
	mov r1, r10
	mov r2, r7
	str r6, [sp, #4]
	str r5, [sp, #8]
	ldrh r3, [r3, #0x10]
	bl WM_SetMPDataToPort
	add r1, r10, #0x800
	ldrh r2, [r1, #0xa]
	cmp r0, #2
	add r2, r2, #1
	and r2, r2, #3
	strh r2, [r1, #0xa]
	beq _020F3F80
	cmp r0, #0
	movne r0, #5
	strneh r0, [r1, #0x1c]
	movne r4, r5
_020F3F80:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F3F90: .word WmDataSharingSetDataCallback
_020F3F94: .word 0x0000FFFF
	arm_func_end WM_StepDataSharing

	arm_func_start WM_EndDataSharing
WM_EndDataSharing: // 0x020F3F98
	stmdb sp!, {r4, lr}
	movs r4, r0
	moveq r0, #6
	ldmeqia sp!, {r4, lr}
	bxeq lr
	add r0, r4, #0x800
	ldrh r1, [r0, #0xe]
	cmp r1, #0
	moveq r0, #3
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldrh r0, [r0, #0x16]
	mov r1, #0
	mov r2, r1
	bl WM_SetPortCallback
	add r1, r4, #0x800
	mov r0, #0
	strh r0, [r1, #0xe]
	strh r0, [r1, #0x1c]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WM_EndDataSharing

	arm_func_start WM_StartDataSharing
WM_StartDataSharing: // 0x020F3FEC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r0
	mov r7, r1
	mov r6, r2
	mov r0, #2
	mov r1, #9
	mov r2, #0xa
	mov r5, r3
	mov r9, #1
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	cmp r10, #0
	addeq sp, sp, #0xc
	moveq r0, #6
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	cmp r7, #0x10
	addhs sp, sp, #0xc
	movhs r0, #6
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxhs lr
	cmp r6, #0
	addeq sp, sp, #0xc
	moveq r0, #6
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	bl WM_GetAID
	movs r4, r0
	bne _020F4078
	bl WMi_GetMPReadyAIDs
	mov r9, r0
_020F4078:
	mov r1, r10
	mov r0, #0
	mov r2, #0x820
	bl MIi_CpuClearFast
	add r0, r10, #0x800
	mov r2, #0
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	strh r2, [r0, #0xc]
	strh r5, [r0, #0x10]
	strh r7, [r0, #0x16]
	strh r2, [r0, #0xe]
	mov r0, #1
	ldr r1, [sp, #0x30]
	orr r0, r6, r0, lsl r4
	cmp r1, #0
	mov r0, r0, lsl #0x10
	movne r2, #1
	add r1, r10, #0x800
	strh r2, [r1, #0x18]
	mov r0, r0, lsr #0x10
	strh r0, [r1, #0xe]
	bl MATH_CountPopulation
	add r3, r10, #0x800
	mul r1, r5, r0
	strh r0, [r3, #0x12]
	strh r1, [r3, #0x14]
	ldrh r0, [r3, #0x14]
	cmp r0, #0x1fc
	movhi r0, #0
	strhih r0, [r3, #0xe]
	addhi sp, sp, #0xc
	movhi r0, #6
	ldmhiia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxhi lr
	add r0, r0, #4
	strh r0, [r3, #0x14]
	mov r0, #1
	strh r0, [r3, #0x1c]
	cmp r4, #0
	bne _020F4230
	orr r2, r9, #1
	mov r4, #0
_020F4124:
	ldrh r1, [r3, #0xe]
	mov r0, r4, lsl #9
	add r4, r4, #1
	and r1, r1, r2
	strh r1, [r10, r0]
	cmp r4, #4
	blt _020F4124
	ldr r1, _020F4258 // =WmDataSharingReceiveCallback_Parent
	mov r0, r7
	mov r2, r10
	bl WM_SetPortCallback
	mov r8, r10
	mov r7, #0
	mov r4, #2
	mov r6, #1
	ldr r11, _020F425C // =WmDataSharingSetDataCallback
	ldr r5, _020F4260 // =0x0000FFFF
	b _020F4210
_020F416C:
	add ip, r10, #0x800
	ldrh r2, [ip, #8]
	mov r0, r11
	mov r1, r10
	add r2, r2, #1
	and r2, r2, #3
	strh r2, [ip, #8]
	ldrh r3, [ip, #0xe]
	mov r2, r8
	and r3, r3, r9
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	str r3, [sp]
	ldrh r3, [ip, #0x16]
	str r3, [sp, #4]
	str r6, [sp, #8]
	ldrh r3, [ip, #0x14]
	bl WM_SetMPDataToPort
	cmp r0, #7
	bne _020F41E0
	add r0, r10, r7, lsl #1
	add r0, r0, #0x800
	strh r5, [r0]
	add r0, r10, #0x800
	ldrh r1, [r0, #0xa]
	add r1, r1, #1
	and r1, r1, #3
	strh r1, [r0, #0xa]
	b _020F4208
_020F41E0:
	cmp r0, #0
	beq _020F4208
	cmp r0, #2
	addne r0, r10, #0x800
	movne r1, #5
	strneh r1, [r0, #0x1c]
	addne sp, sp, #0xc
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
_020F4208:
	add r8, r8, #0x200
	add r7, r7, #1
_020F4210:
	add r0, r10, #0x800
	ldrh r0, [r0, #0x18]
	cmp r0, #1
	movne r0, r6
	moveq r0, r4
	cmp r7, r0
	blt _020F416C
	b _020F4248
_020F4230:
	ldr r1, _020F4264 // =WmDataSharingReceiveCallback_Child
	mov r4, #3
	mov r0, r7
	mov r2, r10
	strh r4, [r3, #0xa]
	bl WM_SetPortCallback
_020F4248:
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F4258: .word WmDataSharingReceiveCallback_Parent
_020F425C: .word WmDataSharingSetDataCallback
_020F4260: .word 0x0000FFFF
_020F4264: .word WmDataSharingReceiveCallback_Child
	arm_func_end WM_StartDataSharing

	arm_func_start WM_EndKeySharing
WM_EndKeySharing: // 0x020F4268
	ldr ip, _020F4270 // =WM_EndDataSharing
	bx ip
	.align 2, 0
_020F4270: .word WM_EndDataSharing
	arm_func_end WM_EndKeySharing

	arm_func_start WM_StartKeySharing
WM_StartKeySharing: // 0x020F4274
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _020F429C // =0x0000FFFF
	mov ip, #1
	mov r3, #2
	str ip, [sp]
	bl WM_StartDataSharing
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F429C: .word 0x0000FFFF
	arm_func_end WM_StartKeySharing

	arm_func_start WM_MeasureChannel
WM_MeasureChannel: // 0x020F42A0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl WMi_GetSystemWork
	mov r0, #1
	mov r1, #2
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	mov r1, r7
	mov r0, #0x1e
	bl WMi_SetCallbackTable
	ldrh r2, [sp, #0x20]
	mov r3, #0x1e
	add r0, sp, #0
	mov r1, #0xa
	strh r3, [sp]
	strh r6, [sp, #2]
	strh r5, [sp, #4]
	strh r4, [sp, #6]
	strh r2, [sp, #8]
	bl WMi_SendCommandDirect
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end WM_MeasureChannel

	arm_func_start WM_SetLifeTime
WM_SetLifeTime: // 0x020F4320
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl WMi_CheckIdle
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	mov r1, r7
	mov r0, #0x1d
	bl WMi_SetCallbackTable
	ldrh ip, [sp, #0x20]
	str r4, [sp]
	mov r2, r6
	mov r3, r5
	mov r0, #0x1d
	mov r1, #4
	str ip, [sp, #4]
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end WM_SetLifeTime

	arm_func_start WM_SetBeaconIndication
WM_SetBeaconIndication: // 0x020F438C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMi_CheckIdle
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	cmp r4, #0
	beq _020F43CC
	cmp r4, #1
	addne sp, sp, #4
	movne r0, #6
	ldmneia sp!, {r4, r5, lr}
	bxne lr
_020F43CC:
	mov r1, r5
	mov r0, #0x19
	bl WMi_SetCallbackTable
	mov r2, r4
	mov r0, #0x19
	mov r1, #1
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WM_SetBeaconIndication

	arm_func_start WM_SetGameInfo
WM_SetGameInfo: // 0x020F43FC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r0, #2
	mov r1, #7
	mov r2, #9
	mov r4, r3
	bl WMi_CheckStateEx
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	cmp r6, #0
	addeq sp, sp, #0xc
	moveq r0, #6
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	cmp r5, #0x70
	addhi sp, sp, #0xc
	movhi r0, #6
	ldmhiia sp!, {r4, r5, r6, r7, lr}
	bxhi lr
	ldr r1, _020F44C0 // =0x021513E0
	mov r0, r6
	mov r2, r5
	bl MIi_CpuCopy16
	ldr r0, _020F44C0 // =0x021513E0
	mov r1, r5
	bl DC_StoreRange
	mov r1, r7
	mov r0, #0x18
	bl WMi_SetCallbackTable
	ldrh r0, [sp, #0x20]
	str r4, [sp]
	ldrb r1, [sp, #0x24]
	str r0, [sp, #4]
	ldr r2, _020F44C0 // =0x021513E0
	str r1, [sp, #8]
	mov r3, r5
	mov r0, #0x18
	mov r1, #5
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F44C0: .word 0x021513E0
	arm_func_end WM_SetGameInfo

	arm_func_start WM_SetWEPKeyEx
WM_SetWEPKeyEx: // 0x020F44C4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl WMi_CheckIdle
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	cmp r6, #3
	addhi sp, sp, #4
	movhi r0, #6
	ldmhiia sp!, {r4, r5, r6, r7, lr}
	bxhi lr
	cmp r6, #0
	beq _020F452C
	cmp r4, #0
	addeq sp, sp, #4
	moveq r0, #6
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r0, r4
	mov r1, #0x50
	bl DC_StoreRange
_020F452C:
	mov r1, r7
	mov r0, #0x27
	bl WMi_SetCallbackTable
	mov r2, r6
	mov r3, r4
	mov r0, #0x27
	mov r1, #3
	str r5, [sp]
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end WM_SetWEPKeyEx

	arm_func_start WM_SetWEPKey
WM_SetWEPKey: // 0x020F4564
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl WMi_CheckIdle
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	cmp r5, #3
	movhi r0, #6
	ldmhiia sp!, {r4, r5, r6, lr}
	bxhi lr
	cmp r5, #0
	beq _020F45B8
	cmp r4, #0
	moveq r0, #6
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	mov r0, r4
	mov r1, #0x50
	bl DC_StoreRange
_020F45B8:
	mov r1, r6
	mov r0, #0x14
	bl WMi_SetCallbackTable
	mov r2, r5
	mov r3, r4
	mov r0, #0x14
	mov r1, #2
	bl WMi_SendCommand
	cmp r0, #0
	moveq r0, #2
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end WM_SetWEPKey

	arm_func_start sub_20F45E8
sub_20F45E8: // 0x020F45E8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, [r5]
	mov r4, r1
	cmp r0, #0
	mov r6, #0
	add r8, r5, #0x9c
	addne sp, sp, #8
	movne r0, r6
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	ldr r0, [r8]
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, r6
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	bl sub_20F6D20
	bl sub_20F6D48
	ldr r1, [r8]
	mov r7, r0
	cmp r1, #0xa
	addls pc, pc, r1, lsl #2
	b _020F4838
_020F464C: // jump table
	b _020F4838 // case 0
	b _020F4838 // case 1
	b _020F4678 // case 2
	b _020F4838 // case 3
	b _020F4760 // case 4
	b _020F4838 // case 5
	b _020F46B8 // case 6
	b _020F4838 // case 7
	b _020F4838 // case 8
	b _020F4838 // case 9
	b _020F4804 // case 10
_020F4678:
	mov r0, r8
	mov r1, r5
	mov r2, #0x9c
	bl MIi_CpuCopy32
	strb r7, [r5, #0xc]
	bl sub_20F6CEC
	mov r6, r0
	bl sub_20F6CFC
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	ldrh r1, [r5, #8]
	ldrb r2, [r5, #0xc]
	bl sub_20F5F3C
	mov r6, r0
	b _020F4838
_020F46B8:
	mov r0, r8
	mov r1, r5
	mov r2, #0x9c
	bl MIi_CpuCopy32
	strb r7, [r5, #0xc]
	add r6, r5, #0x1f8
	mov r7, #0
_020F46D4:
	ldrh r0, [r5, #8]
	mov r0, r0, asr r7
	ands r0, r0, #1
	beq _020F46FC
	add r0, r5, r7, lsl #2
	ldr r1, [r5, #0x18]
	ldr r3, [r0, #0x1c]
	mov r0, r6
	add r2, r6, #0x1c
	bl sub_20F57A8
_020F46FC:
	add r7, r7, #1
	cmp r7, #0x10
	add r6, r6, #0x6c
	blt _020F46D4
	ldr r0, [r8]
	cmp r0, #4
	bne _020F473C
	mov r0, #0
	str r0, [sp]
	ldrh r1, [r5, #8]
	ldrb r2, [r5, #0xc]
	ldr r3, [r5, #0x14]
	mov r0, r4
	bl sub_20F5E00
	mov r6, r0
	b _020F4838
_020F473C:
	mov r0, #0
	str r0, [sp]
	ldrh r1, [r5, #8]
	ldrb r2, [r5, #0xc]
	ldr r3, [r5, #0x14]
	mov r0, r4
	bl sub_20F5CA4
	mov r6, r0
	b _020F4838
_020F4760:
	mov r0, r8
	mov r1, r5
	mov r2, #0x9c
	bl MIi_CpuCopy32
	strb r7, [r5, #0xc]
	add r7, r5, #0x1f8
_020F4778:
	ldrh r0, [r5, #8]
	mov r0, r0, asr r6
	ands r0, r0, #1
	beq _020F47A0
	add r0, r5, r6, lsl #2
	ldr r1, [r5, #0x18]
	ldr r2, [r0, #0x5c]
	ldr r3, [r0, #0x1c]
	mov r0, r7
	bl sub_20F57A8
_020F47A0:
	add r6, r6, #1
	cmp r6, #0x10
	add r7, r7, #0x6c
	blt _020F4778
	ldr r0, [r8]
	cmp r0, #4
	bne _020F47E0
	mov r0, #0
	str r0, [sp]
	ldrh r1, [r5, #8]
	ldrb r2, [r5, #0xc]
	ldr r3, [r5, #0x14]
	mov r0, r4
	bl sub_20F5E00
	mov r6, r0
	b _020F4838
_020F47E0:
	mov r0, #0
	str r0, [sp]
	ldrh r1, [r5, #8]
	ldrb r2, [r5, #0xc]
	ldr r3, [r5, #0x14]
	mov r0, r4
	bl sub_20F5CA4
	mov r6, r0
	b _020F4838
_020F4804:
	mov r0, r8
	mov r1, r5
	mov r2, #0x9c
	bl MIi_CpuCopy32
	strb r7, [r5, #0xc]
	ldrb r1, [r5, #0x1d]
	mov r0, r4
	add r3, r5, #0x14
	str r1, [sp]
	ldrh r1, [r5, #8]
	ldrb r2, [r5, #0xc]
	bl sub_20F5A44
	mov r6, r0
_020F4838:
	mov r1, #0
	mov r0, r6
	str r1, [r8]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20F45E8

	arm_func_start sub_20F4850
sub_20F4850: // 0x020F4850
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r2, [r5]
	mov r4, r1
	cmp r2, #0xa
	mov r0, #0
	addls pc, pc, r2, lsl #2
	b _020F49A8
_020F4874: // jump table
	b _020F49A8 // case 0
	b _020F49A8 // case 1
	b _020F48A0 // case 2
	b _020F49A8 // case 3
	b _020F48D0 // case 4
	b _020F49A8 // case 5
	b _020F48D0 // case 6
	b _020F49A8 // case 7
	b _020F49A8 // case 8
	b _020F49A8 // case 9
	b _020F498C // case 10
_020F48A0:
	bl sub_20F6CEC
	mov r6, r0
	bl sub_20F6CFC
	str r0, [sp]
	ldrh r1, [r5, #8]
	ldrb r2, [r5, #0xc]
	mov r0, r4
	mov r3, r6
	bl sub_20F5F3C
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
_020F48D0:
	mov r10, r0
	add r9, r5, #0x1f8
	mov r7, #1
	mvn r6, #0
_020F48E0:
	mov r8, r7, lsl r10
	mov r1, r8, lsl #0x10
	ldrh r2, [r5, #8]
	mov r1, r1, lsr #0x10
	ands r1, r2, r1
	beq _020F4970
	mov r0, r9
	bl sub_20F56BC
	cmp r0, r6
	bne _020F4924
	ldrb r2, [r5, #0xc]
	mov r1, r8, lsl #0x10
	ldr r3, [r5, #0x14]
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl sub_20F5B5C
	b _020F4960
_020F4924:
	ldr r2, [r5]
	ldrh r1, [r5, #8]
	cmp r2, #4
	bne _020F494C
	str r0, [sp]
	ldrb r2, [r5, #0xc]
	ldr r3, [r5, #0x14]
	mov r0, r4
	bl sub_20F5E00
	b _020F4960
_020F494C:
	str r0, [sp]
	ldrb r2, [r5, #0xc]
	ldr r3, [r5, #0x14]
	mov r0, r4
	bl sub_20F5CA4
_020F4960:
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bxne lr
_020F4970:
	add r10, r10, #1
	cmp r10, #0x10
	add r9, r9, #0x6c
	blt _020F48E0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
_020F498C:
	ldrb r1, [r5, #0x1d]
	mov r0, r4
	add r3, r5, #0x14
	str r1, [sp]
	ldrh r1, [r5, #8]
	ldrb r2, [r5, #0xc]
	bl sub_20F5A44
_020F49A8:
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	arm_func_end sub_20F4850

	arm_func_start sub_20F49B4
sub_20F49B4: // 0x020F49B4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r3, #0x6c
	mul r4, r1, r3
	mov r9, r0
	add r1, r9, #0x1d4
	ldrb r0, [r1, r4]
	mov r8, r2
	add r5, r1, r4
	cmp r0, #2
	mov r6, #0
	bne _020F4A64
	bl sub_20F6BA0
	cmp r0, #0
	ldreq r7, _020F4A74 // =0x0000FFFF
	ldrb r0, [r5, #1]
	movne r7, #1
	cmp r0, #6
	bne _020F4A64
	add r1, r9, #0x23c
	ldr r0, [r1, r4]
	add r4, r1, r4
	cmp r0, #1
	moveq r6, #0
	beq _020F4A30
	ldr r0, [r5, #0x10]
	ldr r1, [r5, #0x14]
	bl sub_20F5834
	movs r6, r0
	moveq r0, #1
	streq r0, [r4]
_020F4A30:
	bl sub_20F6CEC
	ldr r2, [r5, #0x14]
	mov r1, r7
	str r2, [sp]
	str r6, [sp, #4]
	str r0, [sp, #8]
	ldrb r2, [r5, #2]
	ldr r3, [r5, #0x10]
	mov r0, r8
	bl sub_20F5BDC
	mov r1, #1
	mov r6, r0
	strb r1, [r5]
_020F4A64:
	mov r0, r6
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020F4A74: .word 0x0000FFFF
	arm_func_end sub_20F49B4

	arm_func_start sub_20F4A78
sub_20F4A78: // 0x020F4A78
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r3, #0x6c
	mul r4, r1, r3
	mov r9, r0
	add r1, r9, #0x1d4
	ldrb r0, [r1, r4]
	mov r8, r2
	add r5, r1, r4
	cmp r0, #2
	mov r6, #0
	bne _020F4B24
	bl sub_20F6BA0
	cmp r0, #0
	ldreq r7, _020F4B34 // =0x0000FFFF
	ldrb r0, [r5, #1]
	movne r7, #1
	cmp r0, #6
	bne _020F4B24
	add r0, r9, r4
	ldr r0, [r0, #0x23c]
	cmp r0, #1
	moveq r4, #0
	beq _020F4AE8
	ldr r0, [r5, #0x10]
	ldr r1, [r5, #0x14]
	bl sub_20F5834
	mov r4, r0
_020F4AE8:
	cmp r4, #0
	beq _020F4B24
	bl sub_20F6CEC
	ldr r2, [r5, #0x14]
	mov r1, r7
	str r2, [sp]
	str r4, [sp, #4]
	str r0, [sp, #8]
	ldrb r2, [r5, #2]
	ldr r3, [r5, #0x10]
	mov r0, r8
	bl sub_20F5BDC
	mov r1, #1
	mov r6, r0
	strb r1, [r5]
_020F4B24:
	mov r0, r6
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020F4B34: .word 0x0000FFFF
	arm_func_end sub_20F4A78

	arm_func_start sub_20F4B38
sub_20F4B38: // 0x020F4B38
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	mov r3, #0x6c
	mul r5, r1, r3
	mov r10, r0
	str r1, [sp, #0xc]
	add r1, r10, #0x1d4
	ldrb r0, [r1, r5]
	mov r9, r2
	add r7, r10, #0x138
	cmp r0, #2
	add r6, r1, r5
	mov r11, #0
	bne _020F4C88
	bl sub_20F6BA0
	cmp r0, #0
	ldreq r8, _020F4C98 // =0x0000FFFE
	ldrb r0, [r6, #1]
	movne r8, #1
	cmp r0, #4
	bne _020F4C88
	ldr r0, [r6, #0x10]
	bl sub_20F6BC0
	str r0, [sp, #0x10]
	cmp r0, #0
	beq _020F4C74
	ldr r0, [r6, #0x10]
	ldr r1, [r6, #0x14]
	bl sub_20F58CC
	mov r4, r0
	mvn r0, #0
	cmp r4, r0
	beq _020F4C74
	ldr r0, [sp, #0x10]
	ldrh r0, [r0, #0x32]
	cmp r0, #0
	bne _020F4C08
	ldr r0, [r6, #0x10]
	mov r1, r4
	bl sub_20F5834
	mov r7, r0
	bl sub_20F6CEC
	str r4, [sp]
	str r7, [sp, #4]
	str r0, [sp, #8]
	ldrb r2, [r6, #2]
	mov r0, r9
	mov r1, r8
	ldr r3, [r6, #0x10]
	bl sub_20F5D38
	mov r11, r0
	b _020F4C74
_020F4C08:
	cmp r0, #1
	bne _020F4C74
	ldr r0, [r6, #0x10]
	str r0, [r7, #0x14]
	str r4, [r7, #0x18]
	bl sub_20F6CEC
	strh r0, [r7, #0x20]
	mov r3, #0
	ldr r2, [sp, #0xc]
	mov r0, r10
	str r3, [r7, #0x1c]
	mov r1, #0xd
	bl sub_20F54E4
	ldr r2, [r7, #0x1c]
	cmp r2, #0
	beq _020F4C74
	ldr r1, [r7, #0x18]
	mov r0, r9
	str r1, [sp]
	str r2, [sp, #4]
	ldrsh r2, [r7, #0x20]
	mov r1, r8
	str r2, [sp, #8]
	ldrb r2, [r6, #2]
	ldr r3, [r7, #0x14]
	bl sub_20F5D38
	mov r11, r0
_020F4C74:
	mov r0, #1
	strb r0, [r6]
	add r0, r10, r5
	mov r1, #0
	str r1, [r0, #0x23c]
_020F4C88:
	mov r0, r11
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F4C98: .word 0x0000FFFE
	arm_func_end sub_20F4B38

	arm_func_start sub_20F4C9C
sub_20F4C9C: // 0x020F4C9C
	stmdb sp!, {r4, r5, r6, lr}
	mov r3, #0x6c
	mul r4, r1, r3
	mov r5, r0
	add r3, r5, #0x1d4
	mov r0, #1
	mov r0, r0, lsl r1
	ldrb r1, [r3, r4]
	mov r0, r0, lsl #0x10
	add r6, r3, r4
	cmp r1, #2
	mov r1, r0, lsr #0x10
	mov r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	ldrb r3, [r6, #1]
	cmp r3, #0xa
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	mov r0, r2
	ldrb r2, [r6, #2]
	bl sub_20F59D8
	mov r1, #1
	strb r1, [r6]
	add r1, r5, r4
	mov r2, #0
	str r2, [r1, #0x23c]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20F4C9C

	arm_func_start sub_20F4D10
sub_20F4D10: // 0x020F4D10
	stmdb sp!, {r4, r5, r6, lr}
	mov r3, #0x6c
	mul r4, r1, r3
	mov r5, r0
	add r3, r5, #0x1d4
	mov r0, #1
	mov r0, r0, lsl r1
	ldrb r1, [r3, r4]
	mov r0, r0, lsl #0x10
	add r6, r3, r4
	cmp r1, #2
	mov r1, r0, lsr #0x10
	mov r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	ldrb r3, [r6, #1]
	cmp r3, #8
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	mov r0, r2
	ldrb r2, [r6, #2]
	ldr r3, [r6, #0x10]
	bl sub_20F5ADC
	mov r1, #1
	strb r1, [r6]
	add r1, r5, r4
	mov r2, #0
	str r2, [r1, #0x23c]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20F4D10

	arm_func_start sub_20F4D88
sub_20F4D88: // 0x020F4D88
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	mov r3, #0x6c
	mul r4, r1, r3
	mov r8, r0
	add r3, r8, #0x1d4
	mov r0, #1
	mov r0, r0, lsl r1
	ldrb r1, [r3, r4]
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r1, #2
	mov r7, r2
	add r6, r3, r4
	addne sp, sp, #8
	mov r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bxne lr
	ldrb r1, [r6, #1]
	cmp r1, #2
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bxne lr
	bl sub_20F6A9C
	mov r10, r0
	bl sub_20F6CEC
	mov r9, r0
	bl sub_20F6CFC
	str r9, [sp]
	mov r1, r5
	mov r2, r10, lsl #0x10
	mov r3, r2, asr #0x10
	str r0, [sp, #4]
	mov r0, r7
	ldrb r2, [r6, #2]
	bl sub_20F5E94
	add r1, r8, r4
	mov r2, #1
	strb r2, [r6]
	mov r2, #0
	str r2, [r1, #0x23c]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	arm_func_end sub_20F4D88

	arm_func_start sub_20F4E38
sub_20F4E38: // 0x020F4E38
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x3c
	mov r10, r1
	mov r1, #0x6c
	mul r4, r10, r1
	mov r9, r0
	str r3, [sp]
	ldr r0, [sp]
	add r3, r9, #0x1d4
	mov r6, #1
	add r1, r9, #0x1f8
	cmp r0, #0
	add r0, r1, r4
	str r0, [sp, #4]
	mov r7, #0
	mov r8, r2
	add r5, r3, r4
	addeq sp, sp, #0x3c
	strb r6, [r3, r4]
	moveq r0, r7
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldr r0, [sp]
	cmp r0, #0
	ble _020F53DC
	mov r0, #0xf
	str r0, [sp, #0x38]
	mov r0, #3
	str r0, [sp, #0x18]
	mov r0, #8
	str r0, [sp, #0x34]
	mov r0, #5
	str r0, [sp, #0x20]
	mov r0, #9
	str r0, [sp, #0x30]
	mov r0, #7
	str r0, [sp, #0x28]
	mov r0, #0xa
	str r6, [sp, #0x10]
	str r7, [sp, #0x14]
	str r7, [sp, #0xc]
	str r6, [sp, #0x1c]
	str r6, [sp, #0x2c]
	str r6, [sp, #8]
	mov r11, #2
	mov r4, #4
	str r0, [sp, #0x24]
_020F4EF4:
	cmp r6, #0xa
	addls pc, pc, r6, lsl #2
	b _020F53BC
_020F4F00: // jump table
	b _020F53BC // case 0
	b _020F4F2C // case 1
	b _020F4F4C // case 2
	b _020F4FB0 // case 3
	b _020F50B0 // case 4
	b _020F50D8 // case 5
	b _020F53BC // case 6
	b _020F51A0 // case 7
	b _020F52A0 // case 8
	b _020F5080 // case 9
	b _020F5060 // case 10
_020F4F2C:
	ldr r2, [sp, #8]
	mov r0, r8
	add r1, r5, #1
	bl MI_CpuCopy8
	add r8, r8, #1
	add r7, r7, #1
	mov r6, r11
	b _020F53D0
_020F4F4C:
	mov r0, r8
	add r1, r5, #8
	mov r2, r11
	bl MI_CpuCopy8
	add r8, r8, #2
	add r7, r7, #2
	ldrh r6, [r5, #8]
	bl sub_20F6BA0
	mvn r1, #0
	cmp r0, r1
	ldreq r0, [sp, #0xc]
	beq _020F4F94
	bl sub_20F6BA0
	ldr r1, [sp, #0x10]
	mov r0, r1, lsl r0
	ands r0, r6, r0
	movne r0, r1
	ldreq r0, [sp, #0x14]
_020F4F94:
	cmp r0, #0
	addeq sp, sp, #0x3c
	moveq r0, r7
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldr r6, [sp, #0x18]
	b _020F53D0
_020F4FB0:
	ldr r2, [sp, #0x1c]
	mov r0, r8
	add r1, r5, #2
	bl MI_CpuCopy8
	ldrb r1, [r5, #1]
	add r8, r8, #1
	add r7, r7, #1
	cmp r1, #0xb
	addls pc, pc, r1, lsl #2
	b _020F5058
_020F4FD8: // jump table
	b _020F5058 // case 0
	b _020F5008 // case 1
	b _020F5018 // case 2
	b _020F5020 // case 3
	b _020F5058 // case 4
	b _020F5058 // case 5
	b _020F5058 // case 6
	b _020F5058 // case 7
	b _020F5058 // case 8
	b _020F5058 // case 9
	b _020F5050 // case 10
	b _020F5028 // case 11
_020F5008:
	add sp, sp, #0x3c
	mov r0, r7
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F5018:
	ldr r6, [sp, #0x20]
	b _020F53D0
_020F5020:
	mov r6, r4
	b _020F53D0
_020F5028:
	ldr r0, [r9]
	cmp r0, #0xa
	bne _020F5040
	mov r0, r9
	mov r2, r10
	bl sub_20F5400
_020F5040:
	add sp, sp, #0x3c
	mov r0, r7
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F5050:
	ldr r6, [sp, #0x24]
	b _020F53D0
_020F5058:
	ldr r6, [sp, #0x28]
	b _020F53D0
_020F5060:
	ldr r2, [sp, #0x2c]
	mov r0, r8
	add r1, r5, #0xd
	bl MI_CpuCopy8
	add r8, r8, #1
	add r7, r7, #1
	ldr r6, [sp, #0x30]
	b _020F53D0
_020F5080:
	str r8, [r5, #0x20]
	ldrb r1, [r5, #1]
	mov r0, r9
	mov r2, r10
	mov r3, #0
	bl sub_20F54E4
	mov r0, #2
	strb r0, [r5]
	add sp, sp, #0x3c
	add r0, r7, #9
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F50B0:
	mov r0, r8
	add r1, r5, #0xa
	mov r2, r11
	bl MI_CpuCopy8
	ldrb r0, [r5, #1]
	add r8, r8, #2
	add r7, r7, #2
	cmp r0, #3
	ldreq r6, [sp, #0x20]
	b _020F53D0
_020F50D8:
	mov r0, r8
	add r1, r5, #6
	mov r2, #2
	bl MI_CpuCopy8
	add r0, r8, #2
	add r1, r5, #4
	mov r2, #2
	bl MI_CpuCopy8
	bl sub_20F6BA0
	cmp r0, #0
	beq _020F5114
	ldrsh r0, [r5, #4]
	bl sub_20F6CCC
	ldrsh r0, [r5, #6]
	bl sub_20F6CDC
_020F5114:
	ldrb r1, [r5, #1]
	cmp r1, #2
	beq _020F512C
	cmp r1, #3
	beq _020F5154
	b _020F517C
_020F512C:
	mov r0, r9
	mov r2, r10
	mov r3, #0
	bl sub_20F54E4
	mov r0, #2
	strb r0, [r5]
	add sp, sp, #0x3c
	add r0, r7, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F5154:
	ldr r0, [r9]
	cmp r0, #2
	bne _020F516C
	mov r0, r9
	mov r2, r10
	bl sub_20F5400
_020F516C:
	add sp, sp, #0x3c
	add r0, r7, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F517C:
	mov r0, r9
	mov r2, r10
	mov r1, #0xf
	mov r3, #3
	bl sub_20F54E4
	add sp, sp, #0x3c
	add r0, r7, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F51A0:
	mov r0, r8
	add r1, r5, #0x10
	mov r2, r4
	bl MI_CpuCopy8
	ldrb r1, [r5, #1]
	add r8, r8, #4
	add r7, r7, #4
	cmp r1, #9
	addls pc, pc, r1, lsl #2
	b _020F5288
_020F51C8: // jump table
	b _020F5288 // case 0
	b _020F5288 // case 1
	b _020F5288 // case 2
	b _020F5288 // case 3
	b _020F5280 // case 4
	b _020F5280 // case 5
	b _020F5280 // case 6
	b _020F5280 // case 7
	b _020F51F0 // case 8
	b _020F5218 // case 9
_020F51F0:
	mov r0, r9
	mov r2, r10
	mov r3, #0
	bl sub_20F54E4
	mov r1, #2
	add sp, sp, #0x3c
	mov r0, r7
	strb r1, [r5]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F5218:
	ldr r0, [r9]
	cmp r0, #4
	bne _020F5248
	ldr r1, [r9, #0x14]
	ldr r0, [r5, #0x10]
	cmp r1, r0
	bne _020F5270
	mov r0, r9
	mov r2, r10
	mov r1, #5
	bl sub_20F5400
	b _020F5270
_020F5248:
	cmp r0, #6
	bne _020F5270
	ldr r1, [r9, #0x14]
	ldr r0, [r5, #0x10]
	cmp r1, r0
	bne _020F5270
	mov r0, r9
	mov r2, r10
	mov r1, #7
	bl sub_20F5400
_020F5270:
	add sp, sp, #0x3c
	mov r0, r7
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F5280:
	ldr r6, [sp, #0x34]
	b _020F53D0
_020F5288:
	ldr r1, [sp, #0x38]
	ldr r3, [sp, #0x18]
	mov r0, r9
	mov r2, r10
	bl sub_20F54E4
	b _020F53D0
_020F52A0:
	mov r0, r8
	add r1, r5, #0x14
	mov r2, r4
	bl MI_CpuCopy8
	ldrb r0, [r5, #1]
	add r8, r8, #4
	add r7, r7, #4
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _020F53A4
_020F52C8: // jump table
	b _020F53A4 // case 0
	b _020F53A4 // case 1
	b _020F53A4 // case 2
	b _020F53A4 // case 3
	b _020F52E8 // case 4
	b _020F5300 // case 5
	b _020F52E8 // case 6
	b _020F5300 // case 7
_020F52E8:
	mov r1, #2
	add sp, sp, #0x3c
	mov r0, r7
	strb r1, [r5]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F5300:
	str r8, [r5, #0x20]
	ldr r0, [r9]
	cmp r0, #4
	beq _020F5318
	cmp r0, #6
	bne _020F5394
_020F5318:
	ldr r1, [r5, #0x10]
	ldr r0, [r9, #0x14]
	cmp r1, r0
	bne _020F5394
	mov r0, #1
	mov r0, r0, lsl r10
	mov r0, r0, lsl #0x10
	ldrh r1, [r9, #8]
	mov r0, r0, lsr #0x10
	ands r0, r1, r0
	beq _020F5394
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #4]
	bl sub_20F5784
	cmp r0, #0
	bne _020F5394
	ldr r1, [r5, #0x14]
	ldr r2, [r5, #0x20]
	ldr r0, [sp, #4]
	bl sub_20F5624
	cmp r0, #1
	bne _020F5380
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #4]
	bl sub_20F5754
	b _020F5394
_020F5380:
	mov r0, r9
	mov r2, r10
	mov r1, #0xf
	mov r3, #6
	bl sub_20F54E4
_020F5394:
	add sp, sp, #0x3c
	mov r0, r7
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F53A4:
	ldr r1, [sp, #0x38]
	ldr r3, [sp, #0x18]
	mov r0, r9
	mov r2, r10
	bl sub_20F54E4
	b _020F53D0
_020F53BC:
	ldr r1, [sp, #0x38]
	mov r0, r9
	mov r2, r10
	mov r3, r4
	bl sub_20F54E4
_020F53D0:
	ldr r0, [sp]
	cmp r7, r0
	blt _020F4EF4
_020F53DC:
	mov r0, r9
	mov r2, r10
	mov r1, #0xf
	mov r3, #5
	bl sub_20F54E4
	mov r0, r7
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	arm_func_end sub_20F4E38

	arm_func_start sub_20F5400
sub_20F5400: // 0x020F5400
	stmdb sp!, {r4, lr}
	mov r4, r0
	add lr, r4, #0x1d4
	mov r0, #0x6c
	mov r3, #1
	mov r3, r3, lsl r2
	mov r3, r3, lsl #0x10
	mov ip, r3, lsr #0x10
	mla r0, r2, r0, lr
	strh ip, [r4, #0xa]
	ldrb r3, [r0, #2]
	ldrb r2, [r4, #0xc]
	cmp r2, r3
	ldmneia sp!, {r4, lr}
	bxne lr
	strb r3, [r4, #0xd]
	ldrh r3, [r4, #8]
	ands r2, r3, ip
	beq _020F54CC
	mvn r2, ip
	and r2, r3, r2
	strh r2, [r4, #8]
	cmp r1, #0xb
	addls pc, pc, r1, lsl #2
	b _020F54AC
_020F5464: // jump table
	b _020F54AC // case 0
	b _020F54AC // case 1
	b _020F54AC // case 2
	b _020F5494 // case 3
	b _020F54AC // case 4
	b _020F54AC // case 5
	b _020F54AC // case 6
	b _020F54AC // case 7
	b _020F54AC // case 8
	b _020F54AC // case 9
	b _020F54AC // case 10
	b _020F54AC // case 11
_020F5494:
	ldrsh r2, [r0, #0xa]
	strh r2, [r4, #0x14]
	ldrsh r2, [r0, #6]
	strh r2, [r4, #0x16]
	ldrsh r0, [r0, #4]
	strh r0, [r4, #0x18]
_020F54AC:
	str r1, [r4, #4]
	mov r0, #0
	strh r0, [r4, #0xe]
	ldr r1, [r4, #0x10]
	cmp r1, #0
	beq _020F54CC
	mov r0, r4
	blx r1
_020F54CC:
	ldrh r0, [r4, #8]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20F5400

	arm_func_start sub_20F54E4
sub_20F54E4: // 0x020F54E4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	add r5, r0, #0x1d4
	mov r4, #0x6c
	mla ip, r2, r4, r5
	mov r5, r1
	cmp r5, #0xd
	add r4, r0, #0x138
	beq _020F5520
	ldrb r1, [ip, #2]
	ldrb r0, [ip, #3]
	cmp r1, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
_020F5520:
	cmp r5, #8
	bne _020F553C
	ldr r0, [ip, #0x10]
	cmp r0, #0x3e8
	addlo sp, sp, #4
	ldmloia sp!, {r4, r5, lr}
	bxlo lr
_020F553C:
	mov r0, #1
	mov r1, #0xc
	mov r0, r0, lsl r2
	str r1, [r4]
	strh r0, [r4, #0xa]
	cmp r5, #0xd
	ldrneb r0, [ip, #2]
	strneb r0, [ip, #3]
	ldrb r0, [ip, #2]
	cmp r5, #2
	strb r0, [r4, #0xd]
	strh r3, [r4, #0xe]
	bgt _020F557C
	cmp r5, #2
	beq _020F55B4
	b _020F55F8
_020F557C:
	sub r0, r5, #8
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b _020F55F8
_020F558C: // jump table
	b _020F55A8 // case 0
	b _020F55F8 // case 1
	b _020F55D0 // case 2
	b _020F55F8 // case 3
	b _020F55F8 // case 4
	b _020F55F8 // case 5
	b _020F55F8 // case 6
_020F55A8:
	ldr r0, [ip, #0x10]
	str r0, [r4, #0x14]
	b _020F55F8
_020F55B4:
	ldrsh r0, [ip, #0xa]
	strh r0, [r4, #0x14]
	ldrsh r0, [ip, #6]
	strh r0, [r4, #0x16]
	ldrsh r0, [ip, #4]
	strh r0, [r4, #0x18]
	b _020F55F8
_020F55D0:
	ldrb r0, [ip, #0xd]
	cmp r0, #9
	movhi r0, #0
	strhib r0, [r4, #0x1d]
	bhi _020F55F8
	strb r0, [r4, #0x1d]
	ldrb r2, [r4, #0x1d]
	ldr r0, [ip, #0x20]
	add r1, r4, #0x14
	bl MI_CpuCopy8
_020F55F8:
	str r5, [r4, #4]
	ldr r1, [r4, #0x10]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	mov r0, r4
	blx r1
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20F54E4

	arm_func_start sub_20F5624
sub_20F5624: // 0x020F5624
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	bl sub_20F6CFC
	ldr r1, [r8, #4]
	mov r4, r0
	cmp r7, r1
	ldr r5, [r8, #0x18]
	bge _020F56A4
	sub r0, r1, #1
	cmp r7, r0
	bne _020F5690
	ldr r0, [r8]
	mov r1, r4
	bl _s32_div_f
	movs r2, r1
	beq _020F567C
	mla r1, r7, r4, r5
	mov r0, r6
	bl MI_CpuCopy8
	b _020F56B0
_020F567C:
	mla r1, r7, r4, r5
	mov r0, r6
	mov r2, r4
	bl MI_CpuCopy8
	b _020F56B0
_020F5690:
	mla r1, r7, r4, r5
	mov r0, r6
	mov r2, r4
	bl MI_CpuCopy8
	b _020F56B0
_020F56A4:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F56B0:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20F5624

	arm_func_start sub_20F56BC
sub_20F56BC: // 0x020F56BC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r1, [r0, #0xc]
	ldr r4, [r0, #4]
	add r8, r1, #1
	cmp r8, r4
	movge r8, #0
	ldr lr, [r0, #0x14]
	mov r1, r8, asr #5
	add r5, lr, r1, lsl #2
	mov r7, r8
	and r6, r8, #0x1f
	mov r1, #0
	mov r2, #1
_020F56F0:
	mov r3, r2, lsl r6
	ldr ip, [r5]
	ands r3, ip, r3
	beq _020F5738
	add r8, r8, #1
	cmp r8, r4
	bge _020F5720
	add r6, r6, #1
	cmp r6, #0x1f
	movgt r6, r1
	addgt r5, r5, #4
	b _020F572C
_020F5720:
	mov r8, r1
	mov r6, r1
	mov r5, lr
_020F572C:
	cmp r8, r7
	bne _020F56F0
	b _020F5748
_020F5738:
	str r8, [r0, #8]
	mov r0, r8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F5748:
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20F56BC

	arm_func_start sub_20F5754
sub_20F5754: // 0x020F5754
	ldr r2, [r0, #0x10]
	mov r3, r1, asr #5
	add r2, r2, #1
	str r2, [r0, #0x10]
	str r1, [r0, #0xc]
	ldr ip, [r0, #0x14]
	and r0, r1, #0x1f
	ldr r2, [ip, r3, lsl #2]
	mov r1, #1
	orr r0, r2, r1, lsl r0
	str r0, [ip, r3, lsl #2]
	bx lr
	arm_func_end sub_20F5754

	arm_func_start sub_20F5784
sub_20F5784: // 0x020F5784
	ldr r3, [r0, #0x14]
	mov r2, r1, asr #5
	and r1, r1, #0x1f
	mov r0, #1
	mov r1, r0, lsl r1
	ldr r2, [r3, r2, lsl #2]
	ands r1, r2, r1
	moveq r0, #0
	bx lr
	arm_func_end sub_20F5784

	arm_func_start sub_20F57A8
sub_20F57A8: // 0x020F57A8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl sub_20F6CFC
	mov r8, r0
	str r6, [r7]
	mov r2, #0
	str r2, [r7, #8]
	str r2, [r7, #0xc]
	mov r0, r6
	mov r1, r8
	str r2, [r7, #0x10]
	bl _s32_div_f
	cmp r1, #0
	movne r9, #1
	moveq r9, #0
	mov r0, r6
	mov r1, r8
	bl _s32_div_f
	add r0, r0, r9
	str r0, [r7, #4]
	str r5, [r7, #0x14]
	mov r0, r6
	str r4, [r7, #0x18]
	bl sub_20F6B24
	mov r2, r0
	mov r0, r5
	mov r1, #0
	bl MI_CpuFill8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end sub_20F57A8

	arm_func_start sub_20F5834
sub_20F5834: // 0x020F5834
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl sub_20F6C0C
	mov r4, r0
	cmp r6, #0x3e8
	bhs _020F588C
	mov r0, #0
_020F5854:
	cmp r4, #0
	beq _020F5880
	cmp r0, r6
	bne _020F5874
	bl sub_20F6CEC
	mla r0, r5, r0, r4
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F5874:
	add r0, r0, #1
	ldr r4, [r4, #0x28]
	b _020F5854
_020F5880:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F588C:
	cmp r4, #0
	beq _020F58C0
_020F5894:
	ldr r0, [r4]
	cmp r0, r6
	bne _020F58B4
	ldr r4, [r4, #0x2c]
	bl sub_20F6CEC
	mla r0, r5, r0, r4
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F58B4:
	ldr r4, [r4, #0x28]
	cmp r4, #0
	bne _020F5894
_020F58C0:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20F5834

	arm_func_start sub_20F58CC
sub_20F58CC: // 0x020F58CC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r9, r1
	bl sub_20F6C0C
	cmp r10, #0x3e8
	mov r7, r0
	addlo sp, sp, #4
	movlo r0, r9
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxlo lr
	cmp r7, #0
	beq _020F59BC
_020F5900:
	ldr r0, [r7]
	cmp r0, r10
	bne _020F59B0
	ldr r0, _020F59CC // _0211F9C0
	ldr r0, [r0]
	cmp r10, r0
	bne _020F5984
	mov r8, #0
	mov r5, r8
	ldr r11, _020F59D0 // _0211F9C4
	ldr r4, _020F59D4 // _0211F9BC
	b _020F596C
_020F5930:
	add r9, r9, #1
	bl sub_20F6CEC
	mov r6, r0
	bl sub_20F6CEC
	ldr r2, [r7, #4]
	mov r1, r0
	add r0, r2, r6
	sub r0, r0, #1
	bl _s32_div_f
	sub r0, r0, #1
	cmp r9, r0
	add r8, r8, #1
	movgt r9, r5
	cmp r8, #2
	bgt _020F5984
_020F596C:
	ldr r0, [r4]
	cmp r9, r0
	beq _020F5930
	ldr r0, [r11]
	cmp r9, r0
	beq _020F5930
_020F5984:
	ldr r2, _020F59D4 // _0211F9BC
	ldr r3, _020F59CC // _0211F9C0
	ldr r4, [r2]
	ldr r1, _020F59D0 // _0211F9C4
	add sp, sp, #4
	mov r0, r9
	str r10, [r3]
	str r4, [r1]
	str r9, [r2]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F59B0:
	ldr r7, [r7, #0x28]
	cmp r7, #0
	bne _020F5900
_020F59BC:
	mvn r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F59CC: .word _0211F9C0
_020F59D0: .word _0211F9C4
_020F59D4: .word _0211F9BC
	arm_func_end sub_20F58CC

	arm_func_start sub_20F59D8
sub_20F59D8: // 0x020F59D8
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	strh r1, [sp, #2]
	mov r3, #0xb
	add r0, sp, #0
	mov r1, r5
	mov r2, #1
	strb r3, [sp]
	bl MI_CpuCopy8
	add r4, r5, #1
	add r0, sp, #2
	mov r1, r4
	mov r2, #2
	bl MI_CpuCopy8
	add r4, r4, #2
	add r0, sp, #0x18
	mov r1, r4
	mov r2, #1
	bl MI_CpuCopy8
	add r0, r4, #1
	sub r0, r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20F59D8

	arm_func_start sub_20F5A44
sub_20F5A44: // 0x020F5A44
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r4, r0
	strh r1, [sp, #2]
	mov ip, #0xa
	add r0, sp, #0
	mov r1, r4
	mov r2, #1
	mov r6, r3
	strb ip, [sp]
	bl MI_CpuCopy8
	add r5, r4, #1
	add r0, sp, #2
	mov r1, r5
	mov r2, #2
	bl MI_CpuCopy8
	add r5, r5, #2
	add r0, sp, #0x20
	mov r1, r5
	mov r2, #1
	bl MI_CpuCopy8
	add r5, r5, #1
	add r0, sp, #0x28
	mov r1, r5
	mov r2, #1
	bl MI_CpuCopy8
	add r5, r5, #1
	mov r0, r6
	mov r1, r5
	mov r2, #9
	bl MI_CpuCopy8
	add r0, r5, #9
	sub r0, r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20F5A44

	arm_func_start sub_20F5ADC
sub_20F5ADC: // 0x020F5ADC
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	strh r1, [sp, #2]
	mov r3, #9
	add r0, sp, #0
	mov r1, r5
	mov r2, #1
	strb r3, [sp]
	bl MI_CpuCopy8
	add r4, r5, #1
	add r0, sp, #2
	mov r1, r4
	mov r2, #2
	bl MI_CpuCopy8
	add r4, r4, #2
	add r0, sp, #0x18
	mov r1, r4
	mov r2, #1
	bl MI_CpuCopy8
	add r4, r4, #1
	add r0, sp, #0x1c
	mov r1, r4
	mov r2, #4
	bl MI_CpuCopy8
	add r0, r4, #4
	sub r0, r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20F5ADC

	arm_func_start sub_20F5B5C
sub_20F5B5C: // 0x020F5B5C
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	strh r1, [sp, #2]
	mov r3, #8
	add r0, sp, #0
	mov r1, r5
	mov r2, #1
	strb r3, [sp]
	bl MI_CpuCopy8
	add r4, r5, #1
	add r0, sp, #2
	mov r1, r4
	mov r2, #2
	bl MI_CpuCopy8
	add r4, r4, #2
	add r0, sp, #0x18
	mov r1, r4
	mov r2, #1
	bl MI_CpuCopy8
	add r4, r4, #1
	add r0, sp, #0x1c
	mov r1, r4
	mov r2, #4
	bl MI_CpuCopy8
	add r0, r4, #4
	sub r0, r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20F5B5C

	arm_func_start sub_20F5BDC
sub_20F5BDC: // 0x020F5BDC
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	strh r1, [sp, #2]
	mov r3, #7
	add r0, sp, #0
	mov r1, r4
	mov r2, #1
	strb r3, [sp]
	bl MI_CpuCopy8
	add r5, r4, #1
	add r0, sp, #2
	mov r1, r5
	mov r2, #2
	bl MI_CpuCopy8
	add r5, r5, #2
	add r0, sp, #0x18
	mov r1, r5
	mov r2, #1
	bl MI_CpuCopy8
	add r5, r5, #1
	add r0, sp, #0x1c
	mov r1, r5
	mov r2, #4
	bl MI_CpuCopy8
	add r5, r5, #4
	add r0, sp, #0x20
	mov r1, r5
	mov r2, #4
	bl MI_CpuCopy8
	ldr r0, [sp, #0x24]
	add r5, r5, #4
	cmp r0, #0
	bne _020F5C7C
	ldr r2, [sp, #0x28]
	mov r0, r5
	mov r1, #0
	bl MI_CpuFill8
	b _020F5C88
_020F5C7C:
	ldr r2, [sp, #0x28]
	mov r1, r5
	bl MI_CpuCopy8
_020F5C88:
	ldr r0, [sp, #0x28]
	add r0, r5, r0
	sub r0, r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20F5BDC

	arm_func_start sub_20F5CA4
sub_20F5CA4: // 0x020F5CA4
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	strh r1, [sp, #2]
	mov r3, #6
	add r0, sp, #0
	mov r1, r5
	mov r2, #1
	strb r3, [sp]
	bl MI_CpuCopy8
	add r4, r5, #1
	add r0, sp, #2
	mov r1, r4
	mov r2, #2
	bl MI_CpuCopy8
	add r4, r4, #2
	add r0, sp, #0x18
	mov r1, r4
	mov r2, #1
	bl MI_CpuCopy8
	add r4, r4, #1
	add r0, sp, #0x1c
	mov r1, r4
	mov r2, #4
	bl MI_CpuCopy8
	add r4, r4, #4
	add r0, sp, #0x20
	mov r1, r4
	mov r2, #4
	bl MI_CpuCopy8
	add r0, r4, #4
	sub r0, r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20F5CA4

	arm_func_start sub_20F5D38
sub_20F5D38: // 0x020F5D38
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	strh r1, [sp, #2]
	mov r3, #5
	add r0, sp, #0
	mov r1, r4
	mov r2, #1
	strb r3, [sp]
	bl MI_CpuCopy8
	add r5, r4, #1
	add r0, sp, #2
	mov r1, r5
	mov r2, #2
	bl MI_CpuCopy8
	add r5, r5, #2
	add r0, sp, #0x18
	mov r1, r5
	mov r2, #1
	bl MI_CpuCopy8
	add r5, r5, #1
	add r0, sp, #0x1c
	mov r1, r5
	mov r2, #4
	bl MI_CpuCopy8
	add r5, r5, #4
	add r0, sp, #0x20
	mov r1, r5
	mov r2, #4
	bl MI_CpuCopy8
	ldr r0, [sp, #0x24]
	add r5, r5, #4
	cmp r0, #0
	bne _020F5DD8
	ldr r2, [sp, #0x28]
	mov r0, r5
	mov r1, #0
	bl MI_CpuFill8
	b _020F5DE4
_020F5DD8:
	ldr r2, [sp, #0x28]
	mov r1, r5
	bl MI_CpuCopy8
_020F5DE4:
	ldr r0, [sp, #0x28]
	add r0, r5, r0
	sub r0, r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20F5D38

	arm_func_start sub_20F5E00
sub_20F5E00: // 0x020F5E00
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	strh r1, [sp, #2]
	mov r3, #4
	add r0, sp, #0
	mov r1, r5
	mov r2, #1
	strb r3, [sp]
	bl MI_CpuCopy8
	add r4, r5, #1
	add r0, sp, #2
	mov r1, r4
	mov r2, #2
	bl MI_CpuCopy8
	add r4, r4, #2
	add r0, sp, #0x18
	mov r1, r4
	mov r2, #1
	bl MI_CpuCopy8
	add r4, r4, #1
	add r0, sp, #0x1c
	mov r1, r4
	mov r2, #4
	bl MI_CpuCopy8
	add r4, r4, #4
	add r0, sp, #0x20
	mov r1, r4
	mov r2, #4
	bl MI_CpuCopy8
	add r0, r4, #4
	sub r0, r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20F5E00

	arm_func_start sub_20F5E94
sub_20F5E94: // 0x020F5E94
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	strh r1, [sp, #2]
	mov r3, #3
	add r0, sp, #0
	mov r1, r4
	mov r2, #1
	strb r3, [sp]
	bl MI_CpuCopy8
	add r5, r4, #1
	add r0, sp, #2
	mov r1, r5
	mov r2, #2
	bl MI_CpuCopy8
	add r5, r5, #2
	add r0, sp, #0x18
	mov r1, r5
	mov r2, #1
	bl MI_CpuCopy8
	add r5, r5, #1
	add r0, sp, #0x1c
	mov r1, r5
	mov r2, #2
	bl MI_CpuCopy8
	add r5, r5, #2
	add r0, sp, #0x20
	mov r1, r5
	mov r2, #2
	bl MI_CpuCopy8
	add r5, r5, #2
	add r0, sp, #0x24
	mov r1, r5
	mov r2, #2
	bl MI_CpuCopy8
	add r0, r5, #2
	sub r0, r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20F5E94

	arm_func_start sub_20F5F3C
sub_20F5F3C: // 0x020F5F3C
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	strh r1, [sp, #2]
	mov r3, #2
	add r0, sp, #0
	mov r1, r5
	mov r2, #1
	strb r3, [sp]
	bl MI_CpuCopy8
	add r4, r5, #1
	add r0, sp, #2
	mov r1, r4
	mov r2, #2
	bl MI_CpuCopy8
	add r4, r4, #2
	add r0, sp, #0x18
	mov r1, r4
	mov r2, #1
	bl MI_CpuCopy8
	add r4, r4, #1
	add r0, sp, #0x1c
	mov r1, r4
	mov r2, #2
	bl MI_CpuCopy8
	add r4, r4, #2
	add r0, sp, #0x20
	mov r1, r4
	mov r2, #2
	bl MI_CpuCopy8
	add r0, r4, #2
	sub r0, r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20F5F3C

	arm_func_start sub_20F5FD0
sub_20F5FD0: // 0x020F5FD0
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	strh r1, [sp, #2]
	mov r2, #1
	add r0, sp, #0
	mov r1, r5
	strb r2, [sp]
	bl MI_CpuCopy8
	add r4, r5, #1
	add r0, sp, #2
	mov r1, r4
	mov r2, #2
	bl MI_CpuCopy8
	add r4, r4, #2
	add r0, sp, #0x18
	mov r1, r4
	mov r2, #1
	bl MI_CpuCopy8
	add r0, r4, #1
	sub r0, r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20F5FD0

	arm_func_start WBT_MpChildRecvHook
WBT_MpChildRecvHook: // 0x020F6038
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	ldr r2, _020F6084 // =0x0000FFFF
	cmp r1, r2
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	bl sub_20F64E4
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F6084: .word 0x0000FFFF
	arm_func_end WBT_MpChildRecvHook

	arm_func_start WBT_MpChildSendHook
WBT_MpChildSendHook: // 0x020F6088
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #0
	addle sp, sp, #4
	ldmleia sp!, {lr}
	bxle lr
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	bl sub_20F63C0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end WBT_MpChildSendHook

	arm_func_start WBT_MpParentRecvHook
WBT_MpParentRecvHook: // 0x020F60C0
	stmdb sp!, {lr}
	sub sp, sp, #4
	movs ip, r0
	addeq sp, sp, #4
	mov r3, r1
	ldmeqia sp!, {lr}
	bxeq lr
	cmp r3, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	ldr r0, _020F611C // =0x0000FFFF
	cmp r3, r0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	mov r0, r2
	mov r1, ip
	mov r2, r3
	bl sub_20F6514
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F611C: .word 0x0000FFFF
	arm_func_end WBT_MpParentRecvHook

	arm_func_start WBT_MpParentSendHook
WBT_MpParentSendHook: // 0x020F6120
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #0
	mov r2, #0
	ble _020F6148
	cmp r0, #0
	beq _020F6148
	bl sub_20F654C
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
_020F6148:
	mov r0, r2
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end WBT_MpParentSendHook

	arm_func_start WBT_End
WBT_End: // 0x020F6158
	stmdb sp!, {r4, lr}
	sub sp, sp, #0xa0
	bl OS_DisableInterrupts
	ldr r1, _020F621C // =0x02151460
	mov r4, r0
	ldr r2, [r1]
	cmp r2, #0
	bne _020F6188
	bl OS_RestoreInterrupts
	add sp, sp, #0xa0
	ldmia sp!, {r4, lr}
	bx lr
_020F6188:
	mov r2, #0
	mvn r0, #0
	str r2, [r1]
	bl WBT_SetOwnAid
	mov r0, #0
	bl sub_20F6BFC
	bl sub_20F6CC0
	mov r2, #0
	str r2, [r0]
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	str r2, [r0, #0x10]
	str r2, [r0, #0x138]
	add r1, r0, #0x100
	strh r2, [r1, #0x40]
	strh r2, [r1, #0x42]
	str r2, [r0, #0x148]
	mov r1, r2
_020F61D0:
	strb r1, [r0, #0x1d7]
	add r2, r2, #1
	str r1, [r0, #0x23c]
	cmp r2, #0x10
	add r0, r0, #0x6c
	blt _020F61D0
	add r0, sp, #0
	str r1, [sp]
	bl sub_20F6C1C
	bl sub_20F6D0C
	mvn r0, #0
	bl sub_20F6CCC
	mvn r0, #0
	bl sub_20F6CDC
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #0xa0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F621C: .word 0x02151460
	arm_func_end WBT_End

	arm_func_start WBT_InitChild
WBT_InitChild: // 0x020F6220
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x9c
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _020F62E8 // =0x02151460
	mov r4, r0
	ldr r2, [r1]
	cmp r2, #1
	bne _020F6254
	bl OS_RestoreInterrupts
	add sp, sp, #0x9c
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F6254:
	mov r2, #1
	mvn r0, #0
	str r2, [r1]
	bl WBT_SetOwnAid
	mov r0, #0
	bl sub_20F6BFC
	bl sub_20F6CC0
	mov r2, #0
	str r2, [r0]
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	str r2, [r0, #0x10]
	str r2, [r0, #0x138]
	add r1, r0, #0x100
	strh r2, [r1, #0x40]
	strh r2, [r1, #0x42]
	str r5, [r0, #0x148]
	mov r1, r2
_020F629C:
	strb r1, [r0, #0x1d7]
	add r2, r2, #1
	str r1, [r0, #0x23c]
	cmp r2, #0x10
	add r0, r0, #0x6c
	blt _020F629C
	add r0, sp, #0
	str r1, [sp]
	bl sub_20F6C1C
	bl sub_20F6D0C
	mov r0, #0
	bl sub_20F6CCC
	mov r0, #0
	bl sub_20F6CDC
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #0x9c
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F62E8: .word 0x02151460
	arm_func_end WBT_InitChild

	arm_func_start WBT_InitParent
WBT_InitParent: // 0x020F62EC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x9c
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl OS_DisableInterrupts
	ldr r1, _020F63BC // =0x02151460
	mov r4, r0
	ldr r2, [r1]
	cmp r2, #1
	bne _020F6328
	bl OS_RestoreInterrupts
	add sp, sp, #0x9c
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F6328:
	mov r2, #1
	mov r0, #0
	str r2, [r1]
	bl WBT_SetOwnAid
	mov r0, #0
	bl sub_20F6BFC
	bl sub_20F6CC0
	mov r2, #0
	str r2, [r0]
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	str r2, [r0, #0x10]
	str r2, [r0, #0x138]
	add r1, r0, #0x100
	strh r2, [r1, #0x40]
	strh r2, [r1, #0x42]
	str r5, [r0, #0x148]
	mov r1, r2
_020F6370:
	strb r1, [r0, #0x1d7]
	add r2, r2, #1
	str r1, [r0, #0x23c]
	cmp r2, #0x10
	add r0, r0, #0x6c
	blt _020F6370
	add r0, sp, #0
	str r1, [sp]
	bl sub_20F6C1C
	bl sub_20F6D0C
	sub r0, r7, #0xe
	bl sub_20F6CCC
	sub r0, r6, #0xe
	bl sub_20F6CDC
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #0x9c
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F63BC: .word 0x02151460
	arm_func_end WBT_InitParent

	arm_func_start sub_20F63C0
sub_20F63C0: // 0x020F63C0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl sub_20F6CC0
	mov r2, r6
	mov r3, r5
	mov r1, #0
	mov r4, r0
	bl sub_20F4C9C
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	mov r0, r4
	mov r2, r6
	mov r3, r5
	mov r1, #0
	bl sub_20F4D88
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	mov r0, r4
	mov r2, r6
	mov r3, r5
	mov r1, #0
	bl sub_20F4A78
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	mov r0, r4
	mov r2, r6
	mov r3, r5
	mov r1, #0
	bl sub_20F4D10
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	mov r0, r4
	mov r2, r6
	mov r3, r5
	mov r1, #0
	bl sub_20F4B38
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	mov r0, r4
	mov r2, r6
	mov r3, r5
	mov r1, #0
	bl sub_20F49B4
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	mov r0, r4
	mov r1, r6
	mov r2, r5
	bl sub_20F4850
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	mov r0, r4
	mov r1, r6
	mov r2, r5
	bl sub_20F45E8
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	ldr r1, _020F64E0 // =0x0000FFFF
	mov r0, r6
	mov r2, #0
	bl sub_20F5FD0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020F64E0: .word 0x0000FFFF
	arm_func_end sub_20F63C0

	arm_func_start sub_20F64E4
sub_20F64E4: // 0x020F64E4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl sub_20F6CC0
	mov r2, r5
	mov r3, r4
	mov r1, #0
	bl sub_20F4E38
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20F64E4

	arm_func_start sub_20F6514
sub_20F6514: // 0x020F6514
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r2
	mov r6, r0
	mov r5, r1
	cmp r4, #0
	ldmleia sp!, {r4, r5, r6, lr}
	bxle lr
	bl sub_20F6CC0
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl sub_20F4E38
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20F6514

	arm_func_start sub_20F654C
sub_20F654C: // 0x020F654C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	bl sub_20F6CC0
	ldr r8, _020F6718 // _0211F9C8
	mov r5, r0
	ldr r4, [r8]
	mov r9, #1
_020F6570:
	add r4, r4, #1
	cmp r4, #0xf
	movgt r4, r9
	mov r0, r5
	mov r1, r4
	mov r2, r7
	mov r3, r6
	bl sub_20F4C9C
	cmp r0, #0
	ldrne r1, _020F6718 // _0211F9C8
	addne sp, sp, #4
	strne r4, [r1]
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	mov r0, r5
	mov r1, r4
	mov r2, r7
	mov r3, r6
	bl sub_20F4D88
	cmp r0, #0
	ldrne r1, _020F6718 // _0211F9C8
	addne sp, sp, #4
	strne r4, [r1]
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	mov r0, r5
	mov r1, r4
	mov r2, r7
	mov r3, r6
	bl sub_20F4A78
	cmp r0, #0
	ldrne r1, _020F6718 // _0211F9C8
	addne sp, sp, #4
	strne r4, [r1]
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	mov r0, r5
	mov r1, r4
	mov r2, r7
	mov r3, r6
	bl sub_20F4D10
	cmp r0, #0
	ldrne r1, _020F6718 // _0211F9C8
	addne sp, sp, #4
	strne r4, [r1]
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	ldr r0, [r8]
	cmp r4, r0
	bne _020F6570
	mov r0, r5
	mov r1, r7
	mov r2, r6
	bl sub_20F4850
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	mov r0, r5
	mov r1, r7
	mov r2, r6
	bl sub_20F45E8
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	ldr r8, _020F6718 // _0211F9C8
	ldr r4, [r8]
	mov r9, #1
_020F6684:
	add r4, r4, #1
	cmp r4, #0xf
	movgt r4, r9
	mov r0, r5
	mov r1, r4
	mov r2, r7
	mov r3, r6
	bl sub_20F4B38
	cmp r0, #0
	ldrne r1, _020F6718 // _0211F9C8
	addne sp, sp, #4
	strne r4, [r1]
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	ldr r0, [r8]
	cmp r4, r0
	bne _020F6684
	mov r4, #1
_020F66CC:
	mov r0, r5
	mov r1, r4
	mov r2, r7
	mov r3, r6
	bl sub_20F49B4
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	add r4, r4, #1
	cmp r4, #0x10
	blt _020F66CC
	ldr r1, _020F671C // =0x0000FFFE
	mov r0, r7
	mov r2, #0
	bl sub_20F5FD0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020F6718: .word _0211F9C8
_020F671C: .word 0x0000FFFE
	arm_func_end sub_20F654C

	arm_func_start WBT_CancelCurrentCommand
WBT_CancelCurrentCommand: // 0x020F6720
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r8, #0
	bl OS_DisableInterrupts
	ldr r1, _020F67E4 // =0x02151460
	mov r11, r0
	ldr r0, [r1]
	cmp r0, #1
	bne _020F67CC
	bl sub_20F6CC0
	mov r7, r0
	ldr r0, [r7]
	cmp r0, #0
	beq _020F67CC
	mov r9, r8
	add r5, r7, #8
	mov r4, #0x10
	mov r6, #1
_020F676C:
	mov r0, r6, lsl r9
	mov r1, r0, lsl #0x10
	ldrh r2, [r7, #8]
	mov r0, r1, lsr #0x10
	and r1, r2, r1, lsr #16
	ands r1, r10, r1
	beq _020F67B8
	ldrh r2, [r5]
	mvn r1, r0
	mov r8, r6
	and r1, r2, r1
	strh r1, [r5]
	str r4, [r7, #4]
	strh r0, [r7, #0xa]
	ldr r1, [r7, #0x10]
	cmp r1, #0
	beq _020F67B8
	mov r0, r7
	blx r1
_020F67B8:
	add r9, r9, #1
	cmp r9, #0x10
	blt _020F676C
	mov r0, #0
	str r0, [r7]
_020F67CC:
	mov r0, r11
	bl OS_RestoreInterrupts
	mov r0, r8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F67E4: .word 0x02151460
	arm_func_end WBT_CancelCurrentCommand

	arm_func_start WBT_PutUserData
WBT_PutUserData: // 0x020F67E8
	stmdb sp!, {r4, lr}
	sub sp, sp, #0xa0
	movs r4, r2
	bmi _020F6800
	cmp r4, #9
	ble _020F6810
_020F6800:
	add sp, sp, #0xa0
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
_020F6810:
	strh r0, [sp, #8]
	mov r0, r1
	mov ip, #0xa
	add r1, sp, #0x14
	str ip, [sp]
	str r3, [sp, #0x10]
	bl MI_CpuCopy8
	add r0, sp, #0
	strb r4, [sp, #0x1d]
	bl sub_20F6C1C
	add sp, sp, #0xa0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WBT_PutUserData

	arm_func_start WBT_GetBlock
WBT_GetBlock: // 0x020F6844
	stmdb sp!, {lr}
	sub sp, sp, #0x9c
	ldr ip, [sp, #0xa4]
	str r1, [sp, #0x14]
	strh r0, [sp, #8]
	mov r0, r2
	mov lr, #4
	add r1, sp, #0x1c
	mov r2, #0x40
	str lr, [sp]
	str ip, [sp, #0x10]
	str r3, [sp, #0x18]
	bl MIi_CpuCopy32
	ldr r0, [sp, #0xa0]
	add r1, sp, #0x5c
	mov r2, #0x40
	bl MIi_CpuCopy32
	add r0, sp, #0
	bl sub_20F6C1C
	add sp, sp, #0x9c
	ldmia sp!, {lr}
	bx lr
	arm_func_end WBT_GetBlock

	arm_func_start sub_20F689C
sub_20F689C: // 0x020F689C
	stmdb sp!, {lr}
	sub sp, sp, #0x9c
	str r1, [sp, #0x14]
	strh r0, [sp, #8]
	mov r0, r2
	mov lr, #6
	mov ip, #0x28
	add r1, sp, #0x1c
	mov r2, #0x40
	str lr, [sp]
	str r3, [sp, #0x10]
	str ip, [sp, #0x18]
	bl MIi_CpuCopy32
	add r0, sp, #0
	bl sub_20F6C1C
	add sp, sp, #0x9c
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20F689C

	arm_func_start WBT_RequestSync
WBT_RequestSync: // 0x020F68E4
	stmdb sp!, {lr}
	sub sp, sp, #0x9c
	strh r0, [sp, #8]
	mov r2, #2
	add r0, sp, #0
	str r2, [sp]
	str r1, [sp, #0x10]
	bl sub_20F6C1C
	add sp, sp, #0x9c
	ldmia sp!, {lr}
	bx lr
	arm_func_end WBT_RequestSync

	arm_func_start WBT_UnregisterBlock
WBT_UnregisterBlock: // 0x020F6910
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	bl OS_DisableInterrupts
	mov r4, r0
	bl sub_20F6C0C
	movs r5, r0
	bne _020F6948
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F6948:
	ldr r0, [r5]
	cmp r0, r7
	bne _020F6974
	ldr r0, [r5, #0x28]
	bl sub_20F6BFC
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, r5
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F6974:
	ldr r6, [r5, #0x28]
	cmp r6, #0
	beq _020F69BC
_020F6980:
	ldr r0, [r6]
	cmp r0, r7
	bne _020F69AC
	ldr r1, [r6, #0x28]
	mov r0, r4
	str r1, [r5, #0x28]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, r6
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F69AC:
	mov r5, r6
	ldr r6, [r6, #0x28]
	cmp r6, #0
	bne _020F6980
_020F69BC:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end WBT_UnregisterBlock

	arm_func_start WBT_RegisterBlock
WBT_RegisterBlock: // 0x020F69D4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r8, r3
	bl OS_DisableInterrupts
	mov r4, r0
	bl sub_20F6C0C
	cmp r0, #0
	bne _020F6A08
	mov r0, r7
	bl sub_20F6BFC
	b _020F6A2C
_020F6A08:
	bl sub_20F6C0C
	ldr r1, [r0, #0x28]
	cmp r1, #0
	beq _020F6A28
_020F6A18:
	mov r0, r1
	ldr r1, [r1, #0x28]
	cmp r1, #0
	bne _020F6A18
_020F6A28:
	str r7, [r0, #0x28]
_020F6A2C:
	cmp r8, #0
	moveq r0, #1
	streqh r0, [r7, #0x32]
	strne r8, [r7, #0x2c]
	movne r0, #0
	strneh r0, [r7, #0x32]
	mov r1, #0
	str r1, [r7, #0x28]
	ldr r2, [sp, #0x18]
	str r6, [r7]
	ldrh r0, [sp, #0x1c]
	str r2, [r7, #4]
	cmp r5, #0
	strh r0, [r7, #0x30]
	beq _020F6A7C
	mov r0, r5
	add r1, r7, #8
	mov r2, #0x20
	bl MI_CpuCopy8
	b _020F6A88
_020F6A7C:
	add r0, r7, #8
	mov r2, #0x20
	bl MI_CpuFill8
_020F6A88:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end WBT_RegisterBlock

	arm_func_start sub_20F6A9C
sub_20F6A9C: // 0x020F6A9C
	stmdb sp!, {r4, lr}
	mov r4, #0
	bl sub_20F6C0C
	cmp r0, #0
	beq _020F6AC0
_020F6AB0:
	ldr r0, [r0, #0x28]
	add r4, r4, #1
	cmp r0, #0
	bne _020F6AB0
_020F6AC0:
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20F6A9C

	arm_func_start WBT_SetPacketSize
WBT_SetPacketSize: // 0x020F6ACC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl sub_20F6CC0
	ldr r0, [r0]
	cmp r0, #4
	beq _020F6AF4
	cmp r0, #6
	bne _020F6B04
_020F6AF4:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F6B04:
	sub r0, r5, #0xe
	bl sub_20F6CCC
	sub r0, r4, #0xe
	bl sub_20F6CDC
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WBT_SetPacketSize

	arm_func_start sub_20F6B24
sub_20F6B24: // 0x020F6B24
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl sub_20F6CFC
	mov r4, r0
	mov r0, r6
	mov r1, r4
	bl _s32_div_f
	cmp r1, #0
	movne r5, #1
	moveq r5, #0
	mov r0, r6
	mov r1, r4
	bl _s32_div_f
	add r1, r0, r5
	ands r0, r1, #0x1f
	movne r0, #1
	moveq r0, #0
	add r0, r0, r1, asr #5
	mov r0, r0, lsl #2
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20F6B24

	arm_func_start WBT_AidbitmapToAid
WBT_AidbitmapToAid: // 0x020F6B78
	mov r2, #0
_020F6B7C:
	mov r1, r0, asr r2
	ands r1, r1, #1
	movne r0, r2
	bxne lr
	add r2, r2, #1
	cmp r2, #0x10
	blt _020F6B7C
	mvn r0, #0
	bx lr
	arm_func_end WBT_AidbitmapToAid

	arm_func_start sub_20F6BA0
sub_20F6BA0: // 0x020F6BA0
	ldr r0, _020F6BAC // _0211F9CC
	ldr r0, [r0]
	bx lr
	.align 2, 0
_020F6BAC: .word _0211F9CC
	arm_func_end sub_20F6BA0

	arm_func_start WBT_SetOwnAid
WBT_SetOwnAid: // 0x020F6BB0
	ldr r1, _020F6BBC // _0211F9CC
	str r0, [r1]
	bx lr
	.align 2, 0
_020F6BBC: .word _0211F9CC
	arm_func_end WBT_SetOwnAid

	arm_func_start sub_20F6BC0
sub_20F6BC0: // 0x020F6BC0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20F6C0C
	cmp r0, #0
	beq _020F6BF0
_020F6BD4:
	ldr r1, [r0]
	cmp r1, r4
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r0, [r0, #0x28]
	cmp r0, #0
	bne _020F6BD4
_020F6BF0:
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20F6BC0

	arm_func_start sub_20F6BFC
sub_20F6BFC: // 0x020F6BFC
	ldr r1, _020F6C08 // =0x02151470
	str r0, [r1]
	bx lr
	.align 2, 0
_020F6C08: .word 0x02151470
	arm_func_end sub_20F6BFC

	arm_func_start sub_20F6C0C
sub_20F6C0C: // 0x020F6C0C
	ldr r0, _020F6C18 // =0x02151470
	ldr r0, [r0]
	bx lr
	.align 2, 0
_020F6C18: .word 0x02151470
	arm_func_end sub_20F6C0C

	arm_func_start sub_20F6C1C
sub_20F6C1C: // 0x020F6C1C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _020F6CAC // =0x02151460
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #1
	beq _020F6C54
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F6C54:
	bl sub_20F6CB4
	cmp r0, #0
	beq _020F6C6C
	ldr r0, [r0]
	cmp r0, #0
	beq _020F6C84
_020F6C6C:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F6C84:
	ldr r1, _020F6CB0 // =0x02151510
	mov r0, r5
	mov r2, #0x9c
	bl MIi_CpuCopy32
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F6CAC: .word 0x02151460
_020F6CB0: .word 0x02151510
	arm_func_end sub_20F6C1C

	arm_func_start sub_20F6CB4
sub_20F6CB4: // 0x020F6CB4
	ldr r0, _020F6CBC // =0x02151510
	bx lr
	.align 2, 0
_020F6CBC: .word 0x02151510
	arm_func_end sub_20F6CB4

	arm_func_start sub_20F6CC0
sub_20F6CC0: // 0x020F6CC0
	ldr r0, _020F6CC8 // =0x02151474
	bx lr
	.align 2, 0
_020F6CC8: .word 0x02151474
	arm_func_end sub_20F6CC0

	arm_func_start sub_20F6CCC
sub_20F6CCC: // 0x020F6CCC
	ldr r1, _020F6CD8 // =0x0215146C
	strh r0, [r1]
	bx lr
	.align 2, 0
_020F6CD8: .word 0x0215146C
	arm_func_end sub_20F6CCC

	arm_func_start sub_20F6CDC
sub_20F6CDC: // 0x020F6CDC
	ldr r1, _020F6CE8 // =0x02151468
	strh r0, [r1]
	bx lr
	.align 2, 0
_020F6CE8: .word 0x02151468
	arm_func_end sub_20F6CDC

	arm_func_start sub_20F6CEC
sub_20F6CEC: // 0x020F6CEC
	ldr r0, _020F6CF8 // =0x0215146C
	ldrsh r0, [r0]
	bx lr
	.align 2, 0
_020F6CF8: .word 0x0215146C
	arm_func_end sub_20F6CEC

	arm_func_start sub_20F6CFC
sub_20F6CFC: // 0x020F6CFC
	ldr r0, _020F6D08 // =0x02151468
	ldrsh r0, [r0]
	bx lr
	.align 2, 0
_020F6D08: .word 0x02151468
	arm_func_end sub_20F6CFC

	arm_func_start sub_20F6D0C
sub_20F6D0C: // 0x020F6D0C
	ldr r0, _020F6D1C // =0x02151464
	mov r1, #0
	strb r1, [r0]
	bx lr
	.align 2, 0
_020F6D1C: .word 0x02151464
	arm_func_end sub_20F6D0C

	arm_func_start sub_20F6D20
sub_20F6D20: // 0x020F6D20
	ldr r0, _020F6D44 // =0x02151464
	ldrb r1, [r0]
	add r1, r1, #1
	strb r1, [r0]
	ldrb r1, [r0]
	cmp r1, #0
	addeq r1, r1, #1
	streqb r1, [r0]
	bx lr
	.align 2, 0
_020F6D44: .word 0x02151464
	arm_func_end sub_20F6D20

	arm_func_start sub_20F6D48
sub_20F6D48: // 0x020F6D48
	ldr r0, _020F6D54 // =0x02151464
	ldrb r0, [r0]
	bx lr
	.align 2, 0
_020F6D54: .word 0x02151464
	arm_func_end sub_20F6D48

	.data
	
_0211F9B8: // 0x0211F9B8
    .word 0x10000
	
_0211F9BC: // 0x0211F9BC
    .word 0xFFFFFFFF
	
_0211F9C0: // 0x0211F9C0
    .word 0xFFFFFFFF
	
_0211F9C4: // 0x0211F9C4
    .word 0xFFFFFFFF
	
_0211F9C8: // 0x0211F9C8
    .word 1
	
_0211F9CC: // 0x0211F9CC
    .word 0xFFFFFFFF