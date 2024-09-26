	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SPI_OnFifoRecv
SPI_OnFifoRecv: // 0x038045A4
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r2, #0
	bne _03804608
	sub r0, r0, #4
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _03804608
_038045C4: // jump table
	b _03804600 // case 0
	b _03804608 // case 1
	b _038045DC // case 2
	b _03804608 // case 3
	b _038045F4 // case 4
	b _038045E8 // case 5
_038045DC:
	mov r0, r1
	bl TP_AnalyzeCommand
	b _03804608
_038045E8:
	mov r0, r1
	bl MIC_AnalyzeCommand
	b _03804608
_038045F4:
	mov r0, r1
	bl PM_AnalyzeCommand
	b _03804608
_03804600:
	mov r0, r1
	bl NVRAM_AnalyzeCommand
_03804608:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SPI_OnFifoRecv

	arm_func_start SPI_ThreadHandler
SPI_ThreadHandler: // 0x03804614
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r6, _0380467C // =0x0380A8FC
	add r5, sp, #0
	mov r4, #1
_03804628:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl OS_ReceiveMessage
	ldr r0, [sp]
	ldr r1, [r0]
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _03804628
_0380464C: // jump table
	b _0380465C // case 0
	b _03804674 // case 1
	b _03804664 // case 2
	b _0380466C // case 3
_0380465C:
	bl TP_ExecuteProcess
	b _03804628
_03804664:
	bl MIC_ExecuteProcess
	b _03804628
_0380466C:
	bl PM_ExecuteProcess
	b _03804628
_03804674:
	bl NVRAM_ExecuteProcess
	b _03804628
	.align 2, 0
_0380467C: .word 0x0380A8FC
	arm_func_end SPI_ThreadHandler

	arm_func_start SPIi_CheckEntry
SPIi_CheckEntry: // 0x03804680
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _038046A4 // =0x0380A8FC
	add r1, sp, #0
	mov r2, #0
	bl OS_JamMessage
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_038046A4: .word 0x0380A8FC
	arm_func_end SPIi_CheckEntry

	arm_func_start SPIi_SetEntry
SPIi_SetEntry: // 0x038046A8
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r1
	ldrh r0, [sp, #0x18]
	cmp r0, #4
	movhi r0, #0
	bhi _03804760
	bl OS_DisableInterrupts
	ldr r2, _0380476C // =spiWork
	ldr r3, [r2, #0x48c]
	mov r1, #0x18
	mul ip, r3, r1
	ldr r3, _03804770 // =0x0380A95C
	str r5, [r3, ip]
	ldr r3, [r2, #0x48c]
	mul r5, r3, r1
	ldr r3, _03804774 // =0x0380A960
	str r4, [r3, r5]
	add r3, sp, #0x18
	bic r3, r3, #3
	add r6, r3, #4
	mov lr, #0
	ldrh ip, [sp, #0x18]
	b _03804728
_0380470C:
	add r6, r6, #4
	ldr r5, [r6, #-4]
	ldr r4, [r2, #0x48c]
	mla r3, r4, r1, r2
	add r3, r3, lr, lsl #2
	str r5, [r3, #0x314]
	add lr, lr, #1
_03804728:
	cmp lr, ip
	blt _0380470C
	ldr r1, _0380476C // =spiWork
	ldr r4, [r1, #0x48c]
	add r2, r4, #1
	and r2, r2, #0xf
	str r2, [r1, #0x48c]
	bl OS_RestoreInterrupts
	ldr r0, _03804778 // =0x0380A8FC
	ldr r2, _03804770 // =0x0380A95C
	mov r1, #0x18
	mla r1, r4, r1, r2
	mov r2, #0
	bl OS_SendMessage
_03804760:
	ldmia sp!, {r4, r5, r6, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_0380476C: .word spiWork
_03804770: .word 0x0380A95C
_03804774: .word 0x0380A960
_03804778: .word 0x0380A8FC
	arm_func_end SPIi_SetEntry

	arm_func_start SPIi_ReleaseException
SPIi_ReleaseException: // 0x0380477C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _038047B8 // =spiWork
	ldr r2, [r1, #4]
	cmp r2, r0
	bne _038047AC
	mov r0, #5
	str r0, [r1, #4]
	mov r0, #0
	str r0, [r1]
	ldr r0, _038047BC // =0x0380AAE0
	bl OS_WakeupThread
_038047AC:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_038047B8: .word spiWork
_038047BC: .word 0x0380AAE0
	arm_func_end SPIi_ReleaseException

	arm_func_start SPIi_GetException
SPIi_GetException: // 0x038047C0
	mov r2, #1
	ldr r1, _038047D4 // =spiWork
	str r2, [r1]
	str r0, [r1, #4]
	bx lr
	.align 2, 0
_038047D4: .word spiWork
	arm_func_end SPIi_GetException

	arm_func_start SPIi_CheckException
SPIi_CheckException: // 0x038047D8
	ldr r0, _038047F0 // =spiWork
	ldr r0, [r0]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_038047F0: .word spiWork
	arm_func_end SPIi_CheckException

	arm_func_start SPIi_ReturnResult
SPIi_ReturnResult: // 0x038047F4
	stmdb sp!, {r4, r5, r6, lr}
	and r2, r0, #0x70
	cmp r2, #0x30
	bgt _03804834
	cmp r2, #0x30
	bge _03804888
	cmp r2, #0x10
	bgt _03804828
	cmp r2, #0x10
	bge _03804870
	cmp r2, #0
	beq _03804870
	b _0380488C
_03804828:
	cmp r2, #0x20
	beq _03804888
	b _0380488C
_03804834:
	cmp r2, #0x50
	bgt _03804850
	cmp r2, #0x50
	bge _03804878
	cmp r2, #0x40
	beq _03804878
	b _0380488C
_03804850:
	cmp r2, #0x60
	bgt _03804864
	cmp r2, #0x60
	beq _03804880
	b _0380488C
_03804864:
	cmp r2, #0x70
	beq _03804880
	b _0380488C
_03804870:
	mov r4, #6
	b _0380488C
_03804878:
	mov r4, #9
	b _0380488C
_03804880:
	mov r4, #8
	b _0380488C
_03804888:
	mov r4, #4
_0380488C:
	and r0, r0, #0xff
	orr r0, r0, #0x80
	mov r0, r0, lsl #8
	orr r2, r0, #0x3000000
	and r0, r1, #0xff
	orr r6, r2, r0
	mov r5, #0
_038048A8:
	mov r0, r4
	mov r1, r6
	mov r2, r5
	bl PXI_SendWordByFifo
	cmp r0, #0
	blt _038048A8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end SPIi_ReturnResult

	arm_func_start SPI_Unlock
SPI_Unlock: // 0x038048C8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0380492C // =spiWork
	ldr r2, [r1]
	cmp r2, #0
	beq _03804920
	ldr r2, [r1, #4]
	cmp r2, #4
	bne _03804920
	ldr r1, [r1, #0x498]
	cmp r1, r0
	bne _03804920
	bl OS_DisableInterrupts
	mov r2, #5
	ldr r1, _0380492C // =spiWork
	str r2, [r1, #4]
	mov r2, #0
	str r2, [r1]
	str r2, [r1, #0x498]
	bl OS_RestoreInterrupts
	ldr r0, _03804930 // =0x0380AAE0
	bl OS_WakeupThread
_03804920:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_0380492C: .word spiWork
_03804930: .word 0x0380AAE0
	arm_func_end SPI_Unlock

	arm_func_start SPI_Lock
SPI_Lock: // 0x03804934
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r5, _03804990 // =0x0380AAE0
	ldr r4, _03804994 // =spiWork
_03804948:
	bl OS_DisableInterrupts
	mov r6, r0
	ldr r1, [r4]
	cmp r1, #0
	beq _0380496C
	bl OS_RestoreInterrupts
	mov r0, r5
	bl OS_SleepThread
	b _03804948
_0380496C:
	mov r0, #4
	bl SPIi_GetException
	ldr r0, _03804994 // =spiWork
	str r7, [r0, #0x498]
	mov r0, r6
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_03804990: .word 0x0380AAE0
_03804994: .word spiWork
	arm_func_end SPI_Lock

	arm_func_start SPI_Init
SPI_Init: // 0x03804998
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, _03804A94 // =spiInitialized
	ldrh r1, [r0]
	cmp r1, #0
	bne _03804A88
	mov r1, #1
	strh r1, [r0]
	mov r1, #0
	ldr r0, _03804A98 // =spiWork
	str r1, [r0]
	mov r1, #5
	str r1, [r0, #4]
	bl TP_Init
	bl NVRAM_Init
	bl MIC_Init
	bl PM_Init
	bl PXI_Init
	mov r0, #6
	ldr r1, _03804A9C // =SPI_OnFifoRecv
	bl PXI_SetFifoRecvCallback
	mov r0, #9
	ldr r1, _03804A9C // =SPI_OnFifoRecv
	bl PXI_SetFifoRecvCallback
	mov r0, #8
	ldr r1, _03804A9C // =SPI_OnFifoRecv
	bl PXI_SetFifoRecvCallback
	mov r0, #4
	ldr r1, _03804A9C // =SPI_OnFifoRecv
	bl PXI_SetFifoRecvCallback
	ldr r0, _03804AA0 // =0x0380A8FC
	ldr r1, _03804AA4 // =0x0380A91C
	mov r2, #0x10
	bl OS_InitMessageQueue
	mov r8, #0
	ldr r7, _03804AA8 // =0x0380A95C
	mov r6, r8
	mov r5, #0x18
_03804A34:
	mla r0, r8, r5, r7
	mov r1, r6
	mov r2, r5
	bl MI_CpuFill8
	add r8, r8, #1
	cmp r8, #0x10
	blt _03804A34
	mov r2, #0
	ldr r0, _03804A98 // =spiWork
	str r2, [r0, #0x48c]
	str r2, [r0, #0x494]
	str r2, [r0, #0x490]
	mov r0, #0x200
	str r0, [sp]
	str r4, [sp, #4]
	ldr r0, _03804AAC // =0x0380A658
	ldr r1, _03804AB0 // =SPI_ThreadHandler
	ldr r3, _03804AA0 // =0x0380A8FC
	bl OS_CreateThread
	ldr r0, _03804AAC // =0x0380A658
	bl OS_WakeupThreadDirect
_03804A88:
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_03804A94: .word spiInitialized
_03804A98: .word spiWork
_03804A9C: .word SPI_OnFifoRecv
_03804AA0: .word 0x0380A8FC
_03804AA4: .word 0x0380A91C
_03804AA8: .word 0x0380A95C
_03804AAC: .word 0x0380A658
_03804AB0: .word SPI_ThreadHandler
	arm_func_end SPI_Init

	arm_func_start SetStability
SetStability: // 0x03804AB4
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	bne _03804AD4
	mov r0, #3
	mov r1, #2
	bl SPIi_ReturnResult
	b _03804AEC
_03804AD4:
	ldr r1, _03804AF8 // =tpw
	str r0, [r1, #0x24]
	str r0, [r1, #0x28]
	mov r0, #3
	mov r1, #0
	bl SPIi_ReturnResult
_03804AEC:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03804AF8: .word tpw
	arm_func_end SetStability

	arm_func_start TpVAlarmHandler
TpVAlarmHandler: // 0x03804AFC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r0, #0
	mov r1, #0x10
	mov r2, #1
	mov r3, r4
	bl SPIi_SetEntry
	cmp r0, #0
	bne _03804B60
	ldr r0, [sp]
	bic r0, r0, #0x6000000
	orr r0, r0, #0x6000000
	str r0, [sp]
	ldrh r1, [sp]
	ldr r0, _03804B6C // =0x027FFFAA
	strh r1, [r0]
	ldrh r1, [sp, #2]
	ldr r0, _03804B70 // =0x027FFFAC
	strh r1, [r0]
	mov r0, #0x10
	and r1, r4, #0xff
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl SPIi_ReturnResult
_03804B60:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_03804B6C: .word 0x027FFFAA
_03804B70: .word 0x027FFFAC
	arm_func_end TpVAlarmHandler
