	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss
	
.public SND_sFreeList
SND_sFreeList: // 0x0214E340
    .space 0x04

.public sFinishedTag
sFinishedTag: // sFinishedTag
	.space 0x04 // SNDCommand *

.public SND_sReserveList
SND_sReserveList: // SND_sReserveList
	.space 0x04 // SNDCommand *

.public SND_sReserveListEnd
SND_sReserveListEnd: // SND_sReserveListEnd
	.space 0x04 // SNDCommand *

.public SND_sFreeListEnd
SND_sFreeListEnd: // SND_sFreeListEnd
	.space 0x04 // SNDCommand *

.public sWaitingCommandListQueueRead
sWaitingCommandListQueueRead: // sWaitingCommandListQueueRead
	.space 0x04

.public sWaitingCommandListQueueWrite
sWaitingCommandListQueueWrite: // sWaitingCommandListQueueWrite
	.space 0x04

.public sWaitingCommandListCount
sWaitingCommandListCount: // 0x0214E35C
	.space 0x04

.public sCurrentTag
sCurrentTag: // 0x0214E360
	.space 0x04

.public sWaitingCommandListQueue
sWaitingCommandListQueue: // 0x0214E364
	.space 0x04 * 9
	.align 0x20

.public sSharedWork
sSharedWork: // 0x0214E3A0
	.space 0x280

.public sCommandArray
sCommandArray: // sCommandArray
	.space 0x18 * 256

.public sCallbackTable
sCallbackTable: // sCallbackTable
	.space 0x0C * 8 // AlarmCallbackInfo

.public SNDi_SharedWork
SNDi_SharedWork: // SNDi_SharedWork
	.space 0x04 // SNDSharedWork *

	.text
    
    arm_func_start SNDi_IsCommandAvailable
SNDi_IsCommandAvailable: // 0x020E8658
	stmdb sp!, {r4, lr}
	bl OS_IsRunOnEmulator
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r4, lr}
	bxeq lr
	bl OS_DisableInterrupts
	ldr r1, _020E869C // =0x04FFF200
	mov r2, #0x10
	str r2, [r1]
	ldr r4, [r1]
	bl OS_RestoreInterrupts
	cmp r4, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020E869C: .word 0x04FFF200
	arm_func_end SNDi_IsCommandAvailable

	arm_func_start SNDi_AllocCommand
SNDi_AllocCommand: // 0x020E86A0
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020E86F0 // =SND_sFreeList
	ldr r4, [r1]
	cmp r4, #0
	bne _020E86C8
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
_020E86C8:
	ldr r2, [r4]
	str r2, [r1]
	cmp r2, #0
	ldreq r1, _020E86F4 // =SND_sFreeListEnd
	moveq r2, #0
	streq r2, [r1]
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020E86F0: .word SND_sFreeList
_020E86F4: .word SND_sFreeListEnd
	arm_func_end SNDi_AllocCommand

	arm_func_start SND_RequestCommandProc
SND_RequestCommandProc: // 0x020E86F8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, #7
	mov r4, #0
_020E8708:
	mov r0, r5
	mov r1, r4
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	blt _020E8708
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end SND_RequestCommandProc

	arm_func_start SND_InitPXI
SND_InitPXI: // 0x020E872C
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _020E8794 // =SND_PxiFifoCallback
	mov r0, #7
	bl PXI_SetFifoRecvCallback
	bl SNDi_IsCommandAvailable
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	mov r0, #7
	mov r1, #1
	bl PXI_IsCallbackReady
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	mov r6, #0x64
	mov r5, #7
	mov r4, #1
_020E8770:
	mov r0, r6
	bl OS_SpinWait
	mov r0, r5
	mov r1, r4
	bl PXI_IsCallbackReady
	cmp r0, #0
	beq _020E8770
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020E8794: .word SND_PxiFifoCallback
	arm_func_end SND_InitPXI

	arm_func_start SND_PxiFifoCallback
SND_PxiFifoCallback: // 0x020E8798
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r1
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, r5
	bl SNDi_CallAlarmHandler
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end SND_PxiFifoCallback

	arm_func_start SND_CountWaitingCommand
SND_CountWaitingCommand: // 0x020E87C8
	stmdb sp!, {r4, lr}
	bl SND_CountFreeCommand
	mov r4, r0
	bl SND_CountReservedCommand
	rsb r1, r4, #0x100
	sub r0, r1, r0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end SND_CountWaitingCommand

	arm_func_start SND_CountReservedCommand
SND_CountReservedCommand: // 0x020E87E8
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020E8824 // =SND_sReserveList
	mov r4, #0
	ldr r1, [r1]
	cmp r1, #0
	beq _020E8814
_020E8804:
	ldr r1, [r1]
	add r4, r4, #1
	cmp r1, #0
	bne _020E8804
_020E8814:
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020E8824: .word SND_sReserveList
	arm_func_end SND_CountReservedCommand

	arm_func_start SND_CountFreeCommand
SND_CountFreeCommand: // 0x020E8828
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020E8864 // =SND_sFreeList
	mov r4, #0
	ldr r1, [r1]
	cmp r1, #0
	beq _020E8854
_020E8844:
	ldr r1, [r1]
	add r4, r4, #1
	cmp r1, #0
	bne _020E8844
_020E8854:
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020E8864: .word SND_sFreeList
	arm_func_end SND_CountFreeCommand

	arm_func_start SND_IsFinishedCommandTag
SND_IsFinishedCommandTag: // 0x020E8868
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, _020E88B8 // =sFinishedTag
	ldr r1, [r1]
	cmp r4, r1
	bls _020E8898
	sub r1, r4, r1
	cmp r1, #0x80000000
	movlo r4, #0
	movhs r4, #1
	b _020E88A8
_020E8898:
	sub r1, r1, r4
	cmp r1, #0x80000000
	movlo r4, #1
	movhs r4, #0
_020E88A8:
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020E88B8: .word sFinishedTag
	arm_func_end SND_IsFinishedCommandTag

	arm_func_start SND_GetCurrentCommandTag
SND_GetCurrentCommandTag: // 0x020E88BC
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020E88F0 // =SND_sReserveList
	ldr r1, [r1]
	cmp r1, #0
	ldreq r1, _020E88F4 // =sFinishedTag
	ldreq r4, [r1]
	ldrne r1, _020E88F8 // =sCurrentTag
	ldrne r4, [r1]
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020E88F0: .word SND_sReserveList
_020E88F4: .word sFinishedTag
_020E88F8: .word sCurrentTag
	arm_func_end SND_GetCurrentCommandTag

	arm_func_start SND_WaitForCommandProc
SND_WaitForCommandProc: // 0x020E88FC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl SND_IsFinishedCommandTag
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	mov r4, #0
_020E8920:
	mov r0, r4
	bl SND_RecvCommandReply
	cmp r0, #0
	bne _020E8920
	mov r0, r5
	bl SND_IsFinishedCommandTag
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	bl SND_RequestCommandProc
	mov r0, r5
	bl SND_IsFinishedCommandTag
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	mov r4, #1
_020E8968:
	mov r0, r4
	bl SND_RecvCommandReply
	mov r0, r5
	bl SND_IsFinishedCommandTag
	cmp r0, #0
	beq _020E8968
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end SND_WaitForCommandProc

	arm_func_start SND_FlushCommand
SND_FlushCommand: // 0x020E898C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _020E8B30 // =SND_sReserveList
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _020E89C4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020E89C4:
	ldr r1, _020E8B34 // =sWaitingCommandListCount
	ldr r1, [r1]
	cmp r1, #8
	blt _020E8A08
	ands r1, r5, #1
	bne _020E89F0
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020E89F0:
	mov r0, #1
	bl SND_RecvCommandReply
	ldr r0, _020E8B34 // =sWaitingCommandListCount
	ldr r0, [r0]
	cmp r0, #8
	bge _020E89F0
_020E8A08:
	ldr r0, _020E8B38 // =sCommandArray
	mov r1, #0x1800
	bl DC_FlushRange
	ldr r1, _020E8B30 // =SND_sReserveList
	mov r0, #7
	ldr r1, [r1]
	mov r2, #0
	bl PXI_SendWordByFifo
	cmp r0, #0
	bge _020E8AAC
	ands r0, r5, #1
	bne _020E8A50
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020E8A50:
	ldr r1, _020E8B30 // =SND_sReserveList
	mov r0, #7
	ldr r1, [r1]
	mov r2, #0
	bl PXI_SendWordByFifo
	cmp r0, #0
	bge _020E8AAC
	ldr r6, _020E8B30 // =SND_sReserveList
	mov r9, #0x64
	mov r8, #7
	mov r7, #0
_020E8A7C:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, r9
	bl OS_SpinWait
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, r8
	ldr r1, [r6]
	mov r2, r7
	bl PXI_SendWordByFifo
	cmp r0, #0
	blt _020E8A7C
_020E8AAC:
	ands r0, r5, #2
	beq _020E8AB8
	bl SND_RequestCommandProc
_020E8AB8:
	ldr r0, _020E8B3C // =sWaitingCommandListQueueWrite
	ldr r1, _020E8B30 // =SND_sReserveList
	ldr r3, [r0]
	ldr r5, [r1]
	add r1, r3, #1
	ldr r2, _020E8B40 // =sWaitingCommandListQueue
	str r1, [r0]
	str r5, [r2, r3, lsl #2]
	cmp r1, #8
	movgt r1, #0
	ldr r2, _020E8B34 // =sWaitingCommandListCount
	strgt r1, [r0]
	ldr r1, _020E8B44 // =sCurrentTag
	ldr r3, [r2]
	ldr r0, [r1]
	add ip, r3, #1
	add r6, r0, #1
	ldr r5, _020E8B30 // =SND_sReserveList
	mov lr, #0
	ldr r3, _020E8B48 // =SND_sReserveListEnd
	mov r0, r4
	str lr, [r5]
	str lr, [r3]
	str ip, [r2]
	str r6, [r1]
	bl OS_RestoreInterrupts
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020E8B30: .word SND_sReserveList
_020E8B34: .word sWaitingCommandListCount
_020E8B38: .word sCommandArray
_020E8B3C: .word sWaitingCommandListQueueWrite
_020E8B40: .word sWaitingCommandListQueue
_020E8B44: .word sCurrentTag
_020E8B48: .word SND_sReserveListEnd
	arm_func_end SND_FlushCommand

	arm_func_start SND_PushCommand
SND_PushCommand: // 0x020E8B4C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r2, _020E8B8C // =SND_sReserveListEnd
	ldr r1, [r2]
	cmp r1, #0
	ldreq r1, _020E8B90 // =SND_sReserveList
	streq r4, [r2]
	streq r4, [r1]
	strne r4, [r1]
	strne r4, [r2]
	mov r1, #0
	str r1, [r4]
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020E8B8C: .word SND_sReserveListEnd
_020E8B90: .word SND_sReserveList
	arm_func_end SND_PushCommand

	arm_func_start SND_AllocCommand
SND_AllocCommand: // 0x020E8B94
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SNDi_IsCommandAvailable
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	bl SNDi_AllocCommand
	cmp r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	ands r0, r4, #1
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	bl SND_CountWaitingCommand
	cmp r0, #0
	ble _020E8C04
	mov r4, #0
_020E8BE0:
	mov r0, r4
	bl SND_RecvCommandReply
	cmp r0, #0
	bne _020E8BE0
	bl SNDi_AllocCommand
	cmp r0, #0
	beq _020E8C0C
	ldmia sp!, {r4, lr}
	bx lr
_020E8C04:
	mov r0, #1
	bl SND_FlushCommand
_020E8C0C:
	bl SND_RequestCommandProc
	mov r4, #1
_020E8C14:
	mov r0, r4
	bl SND_RecvCommandReply
	bl SNDi_AllocCommand
	cmp r0, #0
	beq _020E8C14
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end SND_AllocCommand

	arm_func_start SND_RecvCommandReply
SND_RecvCommandReply: // 0x020E8C30
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	bl OS_DisableInterrupts
	mov r5, r0
	ands r0, r4, #1
	beq _020E8C8C
	bl SNDi_GetFinishedCommandTag
	ldr r4, _020E8D4C // =sFinishedTag
	ldr r1, [r4]
	cmp r1, r0
	bne _020E8CB4
	mov r6, #0x64
_020E8C60:
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r6
	bl OS_SpinWait
	bl OS_DisableInterrupts
	mov r5, r0
	bl SNDi_GetFinishedCommandTag
	ldr r1, [r4]
	cmp r1, r0
	beq _020E8C60
	b _020E8CB4
_020E8C8C:
	bl SNDi_GetFinishedCommandTag
	ldr r1, _020E8D4C // =sFinishedTag
	ldr r1, [r1]
	cmp r1, r0
	bne _020E8CB4
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020E8CB4:
	ldr r0, _020E8D50 // =sWaitingCommandListQueueRead
	ldr r2, _020E8D54 // =sWaitingCommandListQueue
	ldr r3, [r0]
	add r1, r3, #1
	ldr r4, [r2, r3, lsl #2]
	str r1, [r0]
	cmp r1, #8
	movgt r1, #0
	strgt r1, [r0]
	ldr r0, [r4]
	mov r1, r4
	cmp r0, #0
	beq _020E8CF8
_020E8CE8:
	ldr r1, [r1]
	ldr r0, [r1]
	cmp r0, #0
	bne _020E8CE8
_020E8CF8:
	ldr r0, _020E8D58 // =SND_sFreeListEnd
	ldr r3, _020E8D5C // =sWaitingCommandListCount
	ldr r0, [r0]
	ldr r2, _020E8D4C // =sFinishedTag
	cmp r0, #0
	strne r4, [r0]
	ldreq r0, _020E8D60 // =SND_sFreeList
	ldr lr, [r3]
	streq r4, [r0]
	ldr ip, _020E8D58 // =SND_sFreeListEnd
	sub r6, lr, #1
	ldr r0, [r2]
	str r1, [ip]
	add lr, r0, #1
	mov r0, r5
	str r6, [r3]
	str lr, [r2]
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020E8D4C: .word sFinishedTag
_020E8D50: .word sWaitingCommandListQueueRead
_020E8D54: .word sWaitingCommandListQueue
_020E8D58: .word SND_sFreeListEnd
_020E8D5C: .word sWaitingCommandListCount
_020E8D60: .word SND_sFreeList
	arm_func_end SND_RecvCommandReply

	arm_func_start SND_CommandInit
SND_CommandInit: // 0x020E8D64
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	bl SND_InitPXI
	ldr r3, _020E8E44 // =sCommandArray
	ldr r0, _020E8E48 // =SND_sFreeList
	mov r4, #0
	str r3, [r0]
	mov r1, r3
	mov r0, #0x18
_020E8D88:
	add r4, r4, #1
	mla r2, r4, r0, r1
	cmp r4, #0xff
	str r2, [r3], #0x18
	blt _020E8D88
	ldr r7, _020E8E4C // =0x0214F620
	mov r10, #0
	ldr r5, _020E8E50 // =SND_sReserveList
	ldr r4, _020E8E54 // =SND_sReserveListEnd
	ldr lr, _020E8E58 // =sWaitingCommandListCount
	ldr ip, _020E8E5C // =sWaitingCommandListQueueRead
	ldr r3, _020E8E60 // =sWaitingCommandListQueueWrite
	ldr r1, _020E8E64 // =sFinishedTag
	ldr r9, _020E8E68 // =0x0214FE08
	ldr r6, _020E8E6C // =SND_sFreeListEnd
	ldr r2, _020E8E70 // =sCurrentTag
	mov r8, #1
	ldr r0, _020E8E74 // =sSharedWork
	ldr r11, _020E8E78 // =SNDi_SharedWork
	str r9, [r6]
	str r10, [r7, #0x7e8]
	str r10, [r5]
	str r10, [r4]
	str r10, [lr]
	str r10, [ip]
	str r10, [r3]
	str r8, [r2]
	str r10, [r1]
	str r0, [r11]
	bl SNDi_InitSharedWork
	mov r0, r8
	bl SND_AllocCommand
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	mov r2, #0x1d
	mov r1, r11
	str r2, [r0, #4]
	ldr r1, [r1]
	str r1, [r0, #8]
	bl SND_PushCommand
	mov r0, r8
	bl SND_FlushCommand
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020E8E44: .word sCommandArray
_020E8E48: .word SND_sFreeList
_020E8E4C: .word 0x0214F620
_020E8E50: .word SND_sReserveList
_020E8E54: .word SND_sReserveListEnd
_020E8E58: .word sWaitingCommandListCount
_020E8E5C: .word sWaitingCommandListQueueRead
_020E8E60: .word sWaitingCommandListQueueWrite
_020E8E64: .word sFinishedTag
_020E8E68: .word 0x0214FE08
_020E8E6C: .word SND_sFreeListEnd
_020E8E70: .word sCurrentTag
_020E8E74: .word sSharedWork
_020E8E78: .word SNDi_SharedWork
	arm_func_end SND_CommandInit

	arm_func_start SNDi_CallAlarmHandler
SNDi_CallAlarmHandler: // 0x020E8E7C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, _020E8ED8 // =sCallbackTable
	and r2, r0, #0xff
	mov r1, #0xc
	mla r3, r2, r1, r3
	mov r1, r0, asr #8
	ldrb r0, [r3, #8]
	and r1, r1, #0xff
	cmp r1, r0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldr r1, [r3]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	ldr r0, [r3, #4]
	blx r1
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020E8ED8: .word sCallbackTable
	arm_func_end SNDi_CallAlarmHandler

	arm_func_start SNDi_SetAlarmHandler
SNDi_SetAlarmHandler: // 0x020E8EDC
	mov r3, #0xc
	mul r3, r0, r3
	ldr r0, _020E8F08 // =sCallbackTable
	str r1, [r0, r3]
	add r1, r0, r3
	str r2, [r1, #4]
	ldrb r0, [r1, #8]
	add r0, r0, #1
	strb r0, [r1, #8]
	ldrb r0, [r1, #8]
	bx lr
	.align 2, 0
_020E8F08: .word sCallbackTable
	arm_func_end SNDi_SetAlarmHandler

	arm_func_start SNDi_IncAlarmId
SNDi_IncAlarmId: // 0x020E8F0C
	ldr r2, _020E8F28 // =sCallbackTable
	mov r1, #0xc
	mla r1, r0, r1, r2
	ldrb r0, [r1, #8]
	add r0, r0, #1
	strb r0, [r1, #8]
	bx lr
	.align 2, 0
_020E8F28: .word sCallbackTable
	arm_func_end SNDi_IncAlarmId

	arm_func_start SND_AlarmInit
SND_AlarmInit: // 0x020E8F2C
	ldr r1, _020E8F58 // =sCallbackTable
	mov r2, #0
	mov r0, r2
_020E8F38:
	str r0, [r1]
	str r0, [r1, #4]
	add r2, r2, #1
	strb r0, [r1, #8]
	cmp r2, #8
	add r1, r1, #0xc
	blt _020E8F38
	bx lr
	.align 2, 0
_020E8F58: .word sCallbackTable
	arm_func_end SND_AlarmInit

	arm_func_start SNDi_InitSharedWork
SNDi_InitSharedWork: // 0x020E8F5C
	stmdb sp!, {r4, lr}
	mov r4, #0
	str r4, [r0, #4]
	strh r4, [r0, #8]
	strh r4, [r0, #0xa]
	mov ip, r0
	str r4, [r0]
	mov r3, r4
	mvn r2, #0
_020E8F80:
	mov lr, r3
	str r3, [ip, #0x40]
_020E8F88:
	add r1, ip, lr, lsl #1
	add lr, lr, #1
	strh r2, [r1, #0x20]
	cmp lr, #0x10
	blt _020E8F88
	add r4, r4, #1
	cmp r4, #0x10
	add ip, ip, #0x24
	blt _020E8F80
	mov r3, #0
	mvn r2, #0
_020E8FB4:
	add r1, r0, r3, lsl #1
	add r1, r1, #0x200
	add r3, r3, #1
	strh r2, [r1, #0x60]
	cmp r3, #0x10
	blt _020E8FB4
	mov r1, #0x280
	bl DC_FlushRange
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end SNDi_InitSharedWork

	arm_func_start SNDi_GetFinishedCommandTag
SNDi_GetFinishedCommandTag: // 0x020E8FDC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020E900C // =SNDi_SharedWork
	mov r1, #4
	ldr r0, [r0]
	bl DC_InvalidateRange
	ldr r0, _020E900C // =SNDi_SharedWork
	ldr r0, [r0]
	ldr r0, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020E900C: .word SNDi_SharedWork
	arm_func_end SNDi_GetFinishedCommandTag

	arm_func_start SND_ReadTrackInfo
SND_ReadTrackInfo: // 0x020E9010
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	cmp r1, #0
	blt _020E9028
	cmp r1, #0xf
	ble _020E9038
_020E9028:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020E9038:
	cmp r2, #0
	blt _020E9048
	cmp r2, #0xf
	ble _020E9058
_020E9048:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020E9058:
	mov ip, #0x24
	mla r4, r1, ip, r0
	add r1, r4, r2
	ldrb r2, [r1, #0x548]
	cmp r2, #0xff
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	add r1, r0, #0x780
	add r4, r1, r2, lsl #6
	ldrh r2, [r4, #2]
	add r1, r0, #0x1000
	strh r2, [r3]
	ldrb r2, [r4, #4]
	strb r2, [r3, #2]
	ldrb r2, [r4, #5]
	strb r2, [r3, #3]
	ldrsb r2, [r4, #6]
	strb r2, [r3, #4]
	ldrb r2, [r4, #7]
	strb r2, [r3, #5]
	ldrsb r2, [r4, #8]
	add r2, r2, #0x40
	strb r2, [r3, #6]
	ldrsb r2, [r4, #0x13]
	strb r2, [r3, #7]
	ldr r2, [r4, #0x3c]
	ldr r1, [r1, #0x1c0]
	cmp r2, #0
	mov r4, #0
	moveq r5, #0
	subne r1, r2, r1
	addne r5, r0, r1
	strb r4, [r3, #9]
	cmp r5, #0
	beq _020E9130
	add lr, r3, #9
	add r1, r0, #0x1000
_020E90F4:
	ldrb r2, [r3, #9]
	ldrb ip, [r5]
	add r2, r3, r2
	strb ip, [r2, #0xa]
	ldrb r2, [lr]
	add r2, r2, #1
	strb r2, [lr]
	ldr r2, [r5, #0x50]
	ldr ip, [r1, #0x1c0]
	cmp r2, #0
	moveq r5, r4
	subne r2, r2, ip
	addne r5, r0, r2
	cmp r5, #0
	bne _020E90F4
_020E9130:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end SND_ReadTrackInfo

	arm_func_start SND_ReadPlayerInfo
SND_ReadPlayerInfo: // 0x020E9140
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #0
	blt _020E9158
	cmp r1, #0xf
	ble _020E9168
_020E9158:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {lr}
	bx lr
_020E9168:
	add r3, r0, #0x540
	mov r0, #0x24
	mla r3, r1, r0, r3
	mov lr, #0
	strh lr, [r2, #4]
	add ip, r2, #4
	mov r0, #1
_020E9184:
	add r1, r3, lr
	ldrb r1, [r1, #8]
	cmp r1, #0xff
	ldrneh r1, [ip]
	orrne r1, r1, r0, lsl lr
	add lr, lr, #1
	strneh r1, [ip]
	cmp lr, #0x10
	blt _020E9184
	ldrb r1, [r3]
	ldr ip, [r2]
	mov r0, #1
	mov r1, r1, lsl #0x1f
	mov r1, r1, lsr #0x1f
	bic ip, ip, #1
	and r1, r1, #1
	orr r1, ip, r1
	str r1, [r2]
	ldrb r1, [r3]
	ldr ip, [r2]
	mov r1, r1, lsl #0x1d
	mov r1, r1, lsr #0x1f
	bic ip, ip, #2
	and r1, r1, #1
	orr r1, ip, r1, lsl #1
	str r1, [r2]
	ldrh r1, [r3, #0x18]
	strh r1, [r2, #6]
	ldrb r1, [r3, #5]
	strb r1, [r2, #8]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_ReadPlayerInfo

	arm_func_start SND_GetPlayerStatus
SND_GetPlayerStatus: // 0x020E9208
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020E923C // =SNDi_SharedWork
	mov r1, #4
	ldr r0, [r0]
	add r0, r0, #4
	bl DC_InvalidateRange
	ldr r0, _020E923C // =SNDi_SharedWork
	ldr r0, [r0]
	ldr r0, [r0, #4]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020E923C: .word SNDi_SharedWork
	arm_func_end SND_GetPlayerStatus

	arm_func_start SND_CalcChannelVolume
SND_CalcChannelVolume: // 0x020E9240
	ldr r1, _020E92A8 // =0xFFFFFD2D
	cmp r0, r1
	movlt r0, r1
	blt _020E9258
	cmp r0, #0
	movgt r0, #0
_020E9258:
	ldr r1, _020E92AC // =0x000002D3
	ldr r2, _020E92B0 // =_02116CC8
	add r3, r0, r1
	mvn r1, #0xef
	cmp r0, r1
	ldrb r2, [r2, r3]
	movlt r0, #3
	blt _020E9298
	mvn r1, #0x77
	cmp r0, r1
	movlt r0, #2
	blt _020E9298
	mvn r1, #0x3b
	cmp r0, r1
	movlt r0, #1
	movge r0, #0
_020E9298:
	orr r0, r2, r0, lsl #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
	.align 2, 0
_020E92A8: .word 0xFFFFFD2D
_020E92AC: .word 0x000002D3
_020E92B0: .word _02116CC8
	arm_func_end SND_CalcChannelVolume

	arm_func_start SND_GetWaveDataAddress
SND_GetWaveDataAddress: // 0x020E92B4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl SNDi_LockMutex
	add r0, r5, r4, lsl #2
	ldr r4, [r0, #0x3c]
	cmp r4, #0
	beq _020E92E4
	cmp r4, #0x2000000
	addlo r4, r5, r4
	b _020E92E8
_020E92E4:
	mov r4, #0
_020E92E8:
	bl SNDi_UnlockMutex
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end SND_GetWaveDataAddress

	arm_func_start SND_SetWaveDataAddress
SND_SetWaveDataAddress: // 0x020E92FC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl SNDi_LockMutex
	add r0, r6, #0x3c
	add r2, r6, r5, lsl #2
	add r0, r0, r5, lsl #2
	mov r1, #4
	str r4, [r2, #0x3c]
	bl DC_StoreRange
	bl SNDi_UnlockMutex
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end SND_SetWaveDataAddress

	arm_func_start SND_GetWaveDataCount
SND_GetWaveDataCount: // 0x020E9334
	ldr r0, [r0, #0x38]
	bx lr
	arm_func_end SND_GetWaveDataCount

	arm_func_start SND_GetNextInstData
SND_GetNextInstData: // 0x020E933C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r4, [r2]
	ldr r3, [r0, #0x38]
	cmp r4, r3
	bhs _020E9504
	mov ip, #0
_020E9358:
	add r3, r0, r4, lsl #2
	ldr r4, [r3, #0x3c]
	strb r4, [r1]
	ldrb r3, [r1]
	cmp r3, #0x10
	bgt _020E939C
	cmp r3, #0x10
	bge _020E93F4
	cmp r3, #5
	addls pc, pc, r3, lsl #2
	b _020E94E4
_020E9384: // jump table
	b _020E94E4 // case 0
	b _020E93A8 // case 1
	b _020E93A8 // case 2
	b _020E93A8 // case 3
	b _020E93A8 // case 4
	b _020E93A8 // case 5
_020E939C:
	cmp r3, #0x11
	beq _020E9470
	b _020E94E4
_020E93A8:
	mov r3, r4, lsr #8
	add r5, r0, r4, lsr #8
	ldrh r4, [r0, r3]
	ldrh r3, [r5, #2]
	add sp, sp, #4
	mov r0, #1
	strh r4, [r1, #2]
	strh r3, [r1, #4]
	ldrh r4, [r5, #4]
	ldrh r3, [r5, #6]
	strh r4, [r1, #6]
	strh r3, [r1, #8]
	ldrh r3, [r5, #8]
	strh r3, [r1, #0xa]
	ldr r1, [r2]
	add r1, r1, #1
	str r1, [r2]
	ldmia sp!, {r4, r5, lr}
	bx lr
_020E93F4:
	add r5, r0, r4, lsr #8
	b _020E9450
_020E93FC:
	mov r0, #0xc
	mla ip, lr, r0, r5
	ldrh r4, [ip, #2]
	ldrh r3, [ip, #4]
	add sp, sp, #4
	mov r0, #1
	strh r4, [r1]
	strh r3, [r1, #2]
	ldrh r4, [ip, #6]
	ldrh r3, [ip, #8]
	strh r4, [r1, #4]
	strh r3, [r1, #6]
	ldrh r4, [ip, #0xa]
	ldrh r3, [ip, #0xc]
	strh r4, [r1, #8]
	strh r3, [r1, #0xa]
	ldr r1, [r2, #4]
	add r1, r1, #1
	str r1, [r2, #4]
	ldmia sp!, {r4, r5, lr}
	bx lr
_020E9450:
	ldrb r4, [r5, #1]
	ldrb r3, [r5]
	ldr lr, [r2, #4]
	sub r3, r4, r3
	add r3, r3, #1
	cmp lr, r3
	blo _020E93FC
	b _020E94E4
_020E9470:
	add r4, r0, r4, lsr #8
	b _020E94D8
_020E9478:
	ldrb lr, [r4, r3]
	cmp lr, #0
	beq _020E94E4
	mov r0, #0xc
	mla lr, r3, r0, r4
	ldrh ip, [lr, #8]
	ldrh r3, [lr, #0xa]
	add sp, sp, #4
	mov r0, #1
	strh ip, [r1]
	strh r3, [r1, #2]
	ldrh ip, [lr, #0xc]
	ldrh r3, [lr, #0xe]
	strh ip, [r1, #4]
	strh r3, [r1, #6]
	ldrh ip, [lr, #0x10]
	ldrh r3, [lr, #0x12]
	strh ip, [r1, #8]
	strh r3, [r1, #0xa]
	ldr r1, [r2, #4]
	add r1, r1, #1
	str r1, [r2, #4]
	ldmia sp!, {r4, r5, lr}
	bx lr
_020E94D8:
	ldr r3, [r2, #4]
	cmp r3, #8
	blo _020E9478
_020E94E4:
	ldr r3, [r2]
	add r3, r3, #1
	str r3, [r2]
	str ip, [r2, #4]
	ldr r4, [r2]
	ldr r3, [r0, #0x38]
	cmp r4, r3
	blo _020E9358
_020E9504:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end SND_GetNextInstData

	arm_func_start SND_GetFirstInstDataPos
SND_GetFirstInstDataPos: // 0x020E9514
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [r0]
	str r1, [r0, #4]
	add sp, sp, #8
	bx lr
	arm_func_end SND_GetFirstInstDataPos

	arm_func_start SND_DestroyWaveArc
SND_DestroyWaveArc: // 0x020E9534
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	bl SNDi_LockMutex
	ldr r0, [r4, #0x18]
	cmp r0, #0
	beq _020E9574
	mov r5, #0
	mov r4, #8
_020E9554:
	ldr r6, [r0, #4]
	mov r1, r4
	str r5, [r0]
	str r5, [r0, #4]
	bl DC_StoreRange
	mov r0, r6
	cmp r6, #0
	bne _020E9554
_020E9574:
	bl SNDi_UnlockMutex
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end SND_DestroyWaveArc

	arm_func_start SND_DestroyBank
SND_DestroyBank: // 0x020E9580
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	bl SNDi_LockMutex
	add r5, r7, #0x18
	mov r6, #0
	mov r8, #8
	mov r4, #0x3c
_020E959C:
	add r1, r7, r6, lsl #3
	ldr r0, [r1, #0x18]
	cmp r0, #0
	beq _020E9604
	ldr r3, [r0, #0x18]
	cmp r5, r3
	bne _020E95CC
	ldr r2, [r1, #0x1c]
	mov r1, r4
	str r2, [r0, #0x18]
	bl DC_StoreRange
	b _020E9604
_020E95CC:
	cmp r3, #0
	beq _020E95EC
_020E95D4:
	ldr r0, [r3, #4]
	cmp r5, r0
	beq _020E95EC
	mov r3, r0
	cmp r0, #0
	bne _020E95D4
_020E95EC:
	add r0, r7, r6, lsl #3
	ldr r2, [r0, #0x1c]
	mov r0, r3
	mov r1, r8
	str r2, [r3, #4]
	bl DC_StoreRange
_020E9604:
	add r6, r6, #1
	cmp r6, #4
	add r5, r5, #8
	blt _020E959C
	bl SNDi_UnlockMutex
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end SND_DestroyBank

	arm_func_start SND_AssignWaveArc
SND_AssignWaveArc: // 0x020E9620
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl SNDi_LockMutex
	add r3, r6, r5, lsl #3
	ldr r2, [r3, #0x18]
	mov ip, r5, lsl #3
	cmp r2, #0
	beq _020E96BC
	cmp r4, r2
	bne _020E965C
	bl SNDi_UnlockMutex
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020E965C:
	add r1, r6, #0x18
	ldr r0, [r2, #0x18]
	add ip, r1, ip
	cmp ip, r0
	bne _020E9688
	ldr r0, [r3, #0x1c]
	mov r1, #0x3c
	str r0, [r2, #0x18]
	ldr r0, [r3, #0x18]
	bl DC_StoreRange
	b _020E96BC
_020E9688:
	cmp r0, #0
	beq _020E96A8
_020E9690:
	ldr r1, [r0, #4]
	cmp ip, r1
	beq _020E96A8
	mov r0, r1
	cmp r1, #0
	bne _020E9690
_020E96A8:
	add r1, r6, r5, lsl #3
	ldr r2, [r1, #0x1c]
	mov r1, #8
	str r2, [r0, #4]
	bl DC_StoreRange
_020E96BC:
	add r0, r6, #0x18
	ldr r1, [r4, #0x18]
	add r0, r0, r5, lsl #3
	str r0, [r4, #0x18]
	add r0, r6, r5, lsl #3
	str r1, [r0, #0x1c]
	str r4, [r0, #0x18]
	bl SNDi_UnlockMutex
	mov r0, r6
	mov r1, #0x3c
	bl DC_StoreRange
	mov r0, r4
	mov r1, #0x3c
	bl DC_StoreRange
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end SND_AssignWaveArc
	
	.rodata

	.public _02116BC8
_02116BC8: // 0x02116BC8
	.byte 0x00, 0x80, 0x5B, 0xFE, 0x97, 0xFE, 0xBB, 0xFE
	.byte 0xD4, 0xFE, 0xE7, 0xFE, 0xF7, 0xFE, 0x04, 0xFF, 0x10, 0xFF, 0x1A, 0xFF, 0x23, 0xFF, 0x2C, 0xFF
	.byte 0x33, 0xFF, 0x3A, 0xFF, 0x40, 0xFF, 0x46, 0xFF, 0x4C, 0xFF, 0x51, 0xFF, 0x56, 0xFF, 0x5B, 0xFF
	.byte 0x5F, 0xFF, 0x64, 0xFF, 0x68, 0xFF, 0x6C, 0xFF, 0x6F, 0xFF, 0x73, 0xFF, 0x76, 0xFF, 0x7A, 0xFF
	.byte 0x7D, 0xFF, 0x80, 0xFF, 0x83, 0xFF, 0x86, 0xFF, 0x88, 0xFF, 0x8B, 0xFF, 0x8E, 0xFF, 0x90, 0xFF
	.byte 0x92, 0xFF, 0x95, 0xFF, 0x97, 0xFF, 0x99, 0xFF, 0x9C, 0xFF, 0x9E, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF
	.byte 0xA4, 0xFF, 0xA6, 0xFF, 0xA8, 0xFF, 0xAA, 0xFF, 0xAB, 0xFF, 0xAD, 0xFF, 0xAF, 0xFF, 0xB1, 0xFF
	.byte 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB7, 0xFF, 0xB9, 0xFF, 0xBA, 0xFF, 0xBC, 0xFF, 0xBD, 0xFF
	.byte 0xBF, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC3, 0xFF, 0xC4, 0xFF, 0xC6, 0xFF, 0xC7, 0xFF, 0xC8, 0xFF
	.byte 0xCA, 0xFF, 0xCB, 0xFF, 0xCC, 0xFF, 0xCD, 0xFF, 0xCF, 0xFF, 0xD0, 0xFF, 0xD1, 0xFF, 0xD2, 0xFF
	.byte 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD7, 0xFF, 0xD8, 0xFF, 0xD9, 0xFF, 0xDA, 0xFF, 0xDB, 0xFF
	.byte 0xDC, 0xFF, 0xDD, 0xFF, 0xDE, 0xFF, 0xDF, 0xFF, 0xE0, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE3, 0xFF
	.byte 0xE4, 0xFF, 0xE5, 0xFF, 0xE6, 0xFF, 0xE7, 0xFF, 0xE8, 0xFF, 0xE9, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF
	.byte 0xEB, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEE, 0xFF, 0xEF, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF1, 0xFF
	.byte 0xF2, 0xFF, 0xF3, 0xFF, 0xF4, 0xFF, 0xF4, 0xFF, 0xF5, 0xFF, 0xF6, 0xFF, 0xF7, 0xFF, 0xF7, 0xFF
	.byte 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFA, 0xFF, 0xFB, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF, 0xFD, 0xFF
	.byte 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00
	
_02116CC8: // 0x02116CC8
	.byte 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02
	.byte 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02
	.byte 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02
	.byte 0x02, 0x02, 0x02, 0x02, 0x02, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03
	.byte 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03
	.byte 0x03, 0x03, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04
	.byte 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05
	.byte 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06
	.byte 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07
	.byte 0x07, 0x07, 0x07, 0x07, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x09
	.byte 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A
	.byte 0x0A, 0x0B, 0x0B, 0x0B, 0x0B, 0x0B, 0x0B, 0x0B, 0x0B, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
	.byte 0x0C, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0F, 0x0F
	.byte 0x0F, 0x0F, 0x0F, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x11, 0x11, 0x11, 0x11, 0x11, 0x12, 0x12
	.byte 0x12, 0x12, 0x12, 0x13, 0x13, 0x13, 0x13, 0x14, 0x14, 0x14, 0x14, 0x14, 0x15, 0x15, 0x15, 0x15
	.byte 0x16, 0x16, 0x16, 0x16, 0x17, 0x17, 0x17, 0x18, 0x18, 0x18, 0x18, 0x19, 0x19, 0x19, 0x19, 0x1A
	.byte 0x1A, 0x1A, 0x1B, 0x1B, 0x1B, 0x1C, 0x1C, 0x1C, 0x1D, 0x1D, 0x1D, 0x1E, 0x1E, 0x1E, 0x1F, 0x1F
	.byte 0x1F, 0x20, 0x20, 0x20, 0x21, 0x21, 0x22, 0x22, 0x22, 0x23, 0x23, 0x24, 0x24, 0x24, 0x25, 0x25
	.byte 0x26, 0x26, 0x27, 0x27, 0x27, 0x28, 0x28, 0x29, 0x29, 0x2A, 0x2A, 0x2B, 0x2B, 0x2C, 0x2C, 0x2D
	.byte 0x2D, 0x2E, 0x2E, 0x2F, 0x2F, 0x30, 0x31, 0x31, 0x32, 0x32, 0x33, 0x33, 0x34, 0x35, 0x35, 0x36
	.byte 0x36, 0x37, 0x38, 0x38, 0x39, 0x3A, 0x3A, 0x3B, 0x3C, 0x3C, 0x3D, 0x3E, 0x3F, 0x3F, 0x40, 0x41
	.byte 0x42, 0x42, 0x43, 0x44, 0x45, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E
	.byte 0x4F, 0x50, 0x51, 0x52, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5D, 0x5E
	.byte 0x5F, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6D, 0x6E, 0x6F, 0x71
	.byte 0x72, 0x73, 0x75, 0x76, 0x77, 0x79, 0x7A, 0x7B, 0x7D, 0x7E, 0x7F, 0x20, 0x21, 0x21, 0x21, 0x22
	.byte 0x22, 0x23, 0x23, 0x23, 0x24, 0x24, 0x25, 0x25, 0x26, 0x26, 0x26, 0x27, 0x27, 0x28, 0x28, 0x29
	.byte 0x29, 0x2A, 0x2A, 0x2B, 0x2B, 0x2C, 0x2C, 0x2D, 0x2D, 0x2E, 0x2E, 0x2F, 0x2F, 0x30, 0x30, 0x31
	.byte 0x31, 0x32, 0x33, 0x33, 0x34, 0x34, 0x35, 0x36, 0x36, 0x37, 0x37, 0x38, 0x39, 0x39, 0x3A, 0x3B
	.byte 0x3B, 0x3C, 0x3D, 0x3E, 0x3E, 0x3F, 0x40, 0x40, 0x41, 0x42, 0x43, 0x43, 0x44, 0x45, 0x46, 0x47
	.byte 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4D, 0x4E, 0x4F, 0x50, 0x51, 0x52, 0x53, 0x54, 0x55
	.byte 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F, 0x60, 0x62, 0x63, 0x64, 0x65, 0x66
	.byte 0x67, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6F, 0x70, 0x71, 0x73, 0x74, 0x75, 0x77, 0x78, 0x79, 0x7B
	.byte 0x7C, 0x7E, 0x7E, 0x40, 0x41, 0x42, 0x43, 0x43, 0x44, 0x45, 0x46, 0x47, 0x47, 0x48, 0x49, 0x4A
	.byte 0x4B, 0x4C, 0x4C, 0x4D, 0x4E, 0x4F, 0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59
	.byte 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F, 0x60, 0x61, 0x62, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6B
	.byte 0x6C, 0x6D, 0x6E, 0x70, 0x71, 0x72, 0x74, 0x75, 0x76, 0x78, 0x79, 0x7B, 0x7C, 0x7D, 0x7E, 0x40
	.byte 0x41, 0x42, 0x42, 0x43, 0x44, 0x45, 0x46, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4B, 0x4C, 0x4D
	.byte 0x4E, 0x4F, 0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D
	.byte 0x5E, 0x5F, 0x60, 0x61, 0x62, 0x63, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6C, 0x6D, 0x6E, 0x6F
	.byte 0x71, 0x72, 0x73, 0x75, 0x76, 0x77, 0x79, 0x7A, 0x7C, 0x7D, 0x7E, 0x7F