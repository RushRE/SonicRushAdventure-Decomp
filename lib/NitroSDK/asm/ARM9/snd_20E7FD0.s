	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SNDi_PushCommand_impl
SNDi_PushCommand_impl: // 0x020E7FD0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r0, #1
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl SND_AllocCommand
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	str r7, [r0, #4]
	str r6, [r0, #8]
	str r5, [r0, #0xc]
	ldr r1, [sp, #0x18]
	str r4, [r0, #0x10]
	str r1, [r0, #0x14]
	bl SND_PushCommand
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end SNDi_PushCommand_impl

	arm_func_start SNDi_SetSurroundDecay
SNDi_SetSurroundDecay: // 0x020E8028
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #0
	mov r1, r0
	mov r3, r2
	mov r0, #0x16
	str r2, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SNDi_SetSurroundDecay

	arm_func_start SNDi_SetTrackParam
SNDi_SetTrackParam: // 0x020E8054
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr ip, [sp, #8]
	mov lr, r2
	str r3, [sp]
	mov r2, r1
	orr r1, r0, ip, lsl #24
	mov r3, lr
	mov r0, #7
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SNDi_SetTrackParam

	arm_func_start SNDi_SetPlayerParam
SNDi_SetPlayerParam: // 0x020E8088
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, r1
	mov ip, r2
	str r3, [sp]
	mov r1, r0
	mov r2, lr
	mov r3, ip
	mov r0, #6
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SNDi_SetPlayerParam

	arm_func_start SND_ReadDriverInfo
SND_ReadDriverInfo: // 0x020E80BC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #0
	mov r1, r0
	mov r3, r2
	mov r0, #0x21
	str r2, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_ReadDriverInfo

	arm_func_start SND_SetOutputSelector
SND_SetOutputSelector: // 0x020E80E8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, r1
	mov ip, r2
	str r3, [sp]
	mov r1, r0
	mov r2, lr
	mov r3, ip
	mov r0, #0x19
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_SetOutputSelector

	arm_func_start SND_InvalidateWaveData
SND_InvalidateWaveData: // 0x020E811C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r1
	mov r3, #0
	mov r1, r0
	mov r0, #0x20
	str r3, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_InvalidateWaveData

	arm_func_start SND_InvalidateBankData
SND_InvalidateBankData: // 0x020E8148
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r1
	mov r3, #0
	mov r1, r0
	mov r0, #0x1f
	str r3, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_InvalidateBankData

	arm_func_start SND_InvalidateSeqData
SND_InvalidateSeqData: // 0x020E8174
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r1
	mov r3, #0
	mov r1, r0
	mov r0, #0x1e
	str r3, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_InvalidateSeqData

	arm_func_start SND_SetupChannelPcm
SND_SetupChannelPcm: // 0x020E81A0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr ip, [sp, #0x18]
	mov r3, r3, lsl #0x1a
	orr r4, r3, r1, lsl #24
	ldr r5, [sp, #0x24]
	mov r3, ip, lsl #0x18
	ldr r1, [sp, #0x1c]
	ldr ip, [sp, #0x10]
	orr r4, r4, r5, lsl #16
	orr r4, ip, r4
	ldr lr, [sp, #0x20]
	orr r3, r3, r1, lsl #22
	ldr ip, [sp, #0x14]
	orr r1, r0, lr, lsl #16
	orr r3, ip, r3
	mov r0, #0xe
	str r4, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end SND_SetupChannelPcm

	arm_func_start SND_SetChannelPan
SND_SetChannelPan: // 0x020E81F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r1
	mov r3, #0
	mov r1, r0
	mov r0, #0x15
	str r3, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_SetChannelPan

	arm_func_start SND_SetChannelVolume
SND_SetChannelVolume: // 0x020E8224
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, r1
	mov r3, r2
	mov ip, #0
	mov r1, r0
	mov r2, lr
	mov r0, #0x14
	str ip, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_SetChannelVolume

	arm_func_start SND_UnlockChannel
SND_UnlockChannel: // 0x020E8258
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r1
	mov r3, #0
	mov r1, r0
	mov r0, #0x1b
	str r3, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_UnlockChannel

	arm_func_start SND_LockChannel
SND_LockChannel: // 0x020E8284
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r1
	mov r3, #0
	mov r1, r0
	mov r0, #0x1a
	str r3, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_LockChannel

	arm_func_start SND_StopUnlockedChannel
SND_StopUnlockedChannel: // 0x020E82B0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r1
	mov r3, #0
	mov r1, r0
	mov r0, #0x1c
	str r3, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_StopUnlockedChannel

	arm_func_start SND_SetupAlarm
SND_SetupAlarm: // 0x020E82DC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r4, r2
	mov r5, r1
	ldr r2, [sp, #0x18]
	mov r6, r0
	mov r1, r3
	bl SNDi_SetAlarmHandler
	str r0, [sp]
	mov r1, r6
	mov r2, r5
	mov r3, r4
	mov r0, #0x12
	bl SNDi_PushCommand_impl
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end SND_SetupAlarm

	arm_func_start SND_SetupCapture
SND_SetupCapture: // 0x020E8320
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, r0, lsl #0x1f
	orr r0, r0, r1, lsl #30
	ldr ip, [sp, #8]
	mov r1, r2
	orr r0, r0, ip, lsl #29
	ldr r2, [sp, #0xc]
	mov lr, #0
	orr r0, r0, r2, lsl #28
	ldr ip, [sp, #0x10]
	mov r2, r3
	orr r3, r0, ip, lsl #27
	mov r0, #0x11
	str lr, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_SetupCapture

	arm_func_start SND_StopTimer
SND_StopTimer: // 0x020E836C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r7, r2
	mov r9, r0
	mov r8, r1
	mov r6, r3
	mov r4, r7
	mov r5, #0
	b _020E83A8
_020E8390:
	ands r0, r4, #1
	beq _020E83A0
	mov r0, r5
	bl SNDi_IncAlarmId
_020E83A0:
	add r5, r5, #1
	mov r4, r4, lsr #1
_020E83A8:
	cmp r5, #8
	bge _020E83B8
	cmp r4, #0
	bne _020E8390
_020E83B8:
	mov r1, r9
	mov r2, r8
	mov r3, r7
	mov r0, #0xd
	str r6, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end SND_StopTimer

	arm_func_start SND_StartTimer
SND_StartTimer: // 0x020E83DC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, r1
	mov ip, r2
	str r3, [sp]
	mov r1, r0
	mov r2, lr
	mov r3, ip
	mov r0, #0xc
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_StartTimer

	arm_func_start SND_SetTrackAllocatableChannel
SND_SetTrackAllocatableChannel: // 0x020E8410
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, r1
	mov r3, r2
	mov ip, #0
	mov r1, r0
	mov r2, lr
	mov r0, #9
	str ip, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_SetTrackAllocatableChannel

	arm_func_start SND_SetTrackModDepth
SND_SetTrackModDepth: // 0x020E8444
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r3, r2
	mov ip, #1
	mov r2, #0x1a
	str ip, [sp]
	bl SNDi_SetTrackParam
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_SetTrackModDepth

	arm_func_start SND_SetTrackPan
SND_SetTrackPan: // 0x020E846C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r3, r2
	mov ip, #1
	mov r2, #9
	str ip, [sp]
	bl SNDi_SetTrackParam
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_SetTrackPan

	arm_func_start SND_SetTrackPitch
SND_SetTrackPitch: // 0x020E8494
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r3, r2
	mov ip, #2
	mov r2, #0xc
	str ip, [sp]
	bl SNDi_SetTrackParam
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_SetTrackPitch

	arm_func_start SND_SetTrackVolume
SND_SetTrackVolume: // 0x020E84BC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r3, r2
	mov ip, #2
	mov r2, #0xa
	str ip, [sp]
	bl SNDi_SetTrackParam
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_SetTrackVolume

	arm_func_start SND_SetPlayerChannelPriority
SND_SetPlayerChannelPriority: // 0x020E84E4
	ldr ip, _020E84F8 // =SNDi_SetPlayerParam
	mov r2, r1
	mov r1, #4
	mov r3, #1
	bx ip
	.align 2, 0
_020E84F8: .word SNDi_SetPlayerParam
	arm_func_end SND_SetPlayerChannelPriority

	arm_func_start SND_SetPlayerVolume
SND_SetPlayerVolume: // 0x020E84FC
	ldr ip, _020E8510 // =SNDi_SetPlayerParam
	mov r2, r1
	mov r1, #6
	mov r3, #2
	bx ip
	.align 2, 0
_020E8510: .word SNDi_SetPlayerParam
	arm_func_end SND_SetPlayerVolume

	arm_func_start SND_SetPlayerTempoRatio
SND_SetPlayerTempoRatio: // 0x020E8514
	ldr ip, _020E8528 // =SNDi_SetPlayerParam
	mov r2, r1
	mov r1, #0x1a
	mov r3, #2
	bx ip
	.align 2, 0
_020E8528: .word SNDi_SetPlayerParam
	arm_func_end SND_SetPlayerTempoRatio

	arm_func_start SND_PauseSeq
SND_PauseSeq: // 0x020E852C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r1
	mov r3, #0
	mov r1, r0
	mov r0, #4
	str r3, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_PauseSeq

	arm_func_start SND_StartPreparedSeq
SND_StartPreparedSeq: // 0x020E8558
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #0
	mov r1, r0
	mov r3, r2
	mov r0, #3
	str r2, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_StartPreparedSeq

	arm_func_start SND_PrepareSeq
SND_PrepareSeq: // 0x020E8584
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, r1
	mov ip, r2
	str r3, [sp]
	mov r1, r0
	mov r2, lr
	mov r3, ip
	mov r0, #2
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_PrepareSeq

	arm_func_start SND_StopSeq
SND_StopSeq: // 0x020E85B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #0
	mov r1, r0
	mov r3, r2
	mov r0, #1
	str r2, [sp]
	bl SNDi_PushCommand_impl
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SND_StopSeq

