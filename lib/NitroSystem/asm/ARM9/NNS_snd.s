	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public _0214A1B4
_0214A1B4:
	.space 0x3D58

	.text

    arm_func_start NNS_EndSleep
NNS_EndSleep: // 0x020D85C4
	ldr ip, _020D85CC // =NNSi_SndCaptureEndSleep
	bx ip
	.align 2, 0
_020D85CC: .word NNSi_SndCaptureEndSleep
	arm_func_end NNS_EndSleep

	arm_func_start NNS_BeginSleep
NNS_BeginSleep: // 0x020D85D0
	stmdb sp!, {r4, lr}
	bl NNSi_SndCaptureBeginSleep
	mov r0, #0
	mov r1, r0
	mov r2, r0
	mov r3, r0
	bl SND_StopTimer
	bl SND_GetCurrentCommandTag
	mov r4, r0
	mov r0, #1
	bl SND_FlushCommand
	mov r0, r4
	bl SND_WaitForCommandProc
	ldmia sp!, {r4, pc}
	arm_func_end NNS_BeginSleep

	arm_func_start NNSi_SndReadDriverPlayerInfo
NNSi_SndReadDriverPlayerInfo: // 0x020D8608
	stmdb sp!, {r4, lr}
	ldr r3, _020D8650 // =_0214A1B4
	mov r4, r0
	ldrsb ip, [r3]
	mov lr, r1
	mov r3, r2
	cmp ip, #0
	movlt r0, #0
	ldrge r1, _020D8654 // =0x0214A1E0
	ldrge r0, _020D8658 // =0x000011E0
	mlage r0, ip, r0, r1
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	mov r1, r4
	mov r2, lr
	bl SND_ReadTrackInfo
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D8650: .word _0214A1B4
_020D8654: .word 0x0214A1E0
_020D8658: .word 0x000011E0
	arm_func_end NNSi_SndReadDriverPlayerInfo

	arm_func_start NNS_SndReadDriverChannelInfo
NNS_SndReadDriverChannelInfo: // 0x020D865C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _020D86A8 // =_0214A1B4
	mov ip, r0
	ldrsb r3, [r2]
	mov r2, r1
	cmp r3, #0
	movlt r0, #0
	ldrge r1, _020D86AC // =0x0214A1E0
	ldrge r0, _020D86B0 // =0x000011E0
	mlage r0, r3, r0, r1
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	mov r1, ip
	bl SND_ReadPlayerInfo
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D86A8: .word _0214A1B4
_020D86AC: .word 0x0214A1E0
_020D86B0: .word 0x000011E0
	arm_func_end NNS_SndReadDriverChannelInfo

	arm_func_start NNS_SndUpdateDriverInfo
NNS_SndUpdateDriverInfo: // 0x020D86B4
	stmdb sp!, {r4, lr}
	ldr r0, _020D8794 // =0x0214A1B8
	ldr r0, [r0]
	cmp r0, #0
	bne _020D8770
	mov r4, #0
_020D86CC:
	mov r0, r4
	bl SND_RecvCommandReply
	cmp r0, #0
	bne _020D86CC
	ldr r0, _020D8798 // =0x0214A1BC
	ldr r0, [r0]
	bl SND_IsFinishedCommandTag
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _020D879C // =_0214A1B4
	ldr r2, _020D87A0 // =0x0214A1E0
	ldrsb r1, [r0]
	cmp r1, #0
	movlt r1, #1
	strltb r1, [r0]
	ldr r0, _020D879C // =_0214A1B4
	ldrsb r1, [r0]
	ldr r0, _020D87A4 // =0x000011E0
	mla r0, r1, r0, r2
	bl SND_ReadDriverInfo
	bl SND_GetCurrentCommandTag
	ldr r1, _020D879C // =_0214A1B4
	ldr r2, _020D8798 // =0x0214A1BC
	ldrsb r3, [r1]
	str r0, [r2]
	cmp r3, #0
	moveq r0, #1
	streqb r0, [r1]
	movne r0, #0
	strneb r0, [r1]
	ldr r0, _020D879C // =_0214A1B4
	ldr r3, _020D87A0 // =0x0214A1E0
	ldrsb r2, [r0]
	ldr r1, _020D87A4 // =0x000011E0
	mla r0, r2, r1, r3
	bl DC_InvalidateRange
	mov r0, #0
	bl SND_FlushCommand
	mov r0, #1
	ldmia sp!, {r4, pc}
_020D8770:
	ldr r0, _020D87A0 // =0x0214A1E0
	bl SND_ReadDriverInfo
	bl SND_GetCurrentCommandTag
	ldr r2, _020D8798 // =0x0214A1BC
	ldr r1, _020D8794 // =0x0214A1B8
	str r0, [r2]
	mov r0, #0
	str r0, [r1]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D8794: .word 0x0214A1B8
_020D8798: .word 0x0214A1BC
_020D879C: .word _0214A1B4
_020D87A0: .word 0x0214A1E0
_020D87A4: .word 0x000011E0
	arm_func_end NNS_SndUpdateDriverInfo

	arm_func_start NNS_SndStopChannelAll
NNS_SndStopChannelAll: // 0x020D87A8
	ldr ip, _020D87B8 // =SND_StopUnlockedChannel
	ldr r0, _020D87BC // =0x0000FFFF
	mov r1, #0
	bx ip
	.align 2, 0
_020D87B8: .word SND_StopUnlockedChannel
_020D87BC: .word 0x0000FFFF
	arm_func_end NNS_SndStopChannelAll

	arm_func_start NNS_SndStopSoundAll
NNS_SndStopSoundAll: // 0x020D87C0
	stmdb sp!, {r4, lr}
	mov r0, #0
	bl NNS_SndPlayerStopSeqAll
	mov r0, #0
	bl NNS_SndArcStrmStopAll
	bl NNSi_SndCaptureStop
	mov r0, #0
	bl SNDi_SetSurroundDecay
	ldr r0, _020D8810 // =0x0000FFFF
	mov r3, #0
	mov r1, r0
	mov r2, r0
	bl SND_StopTimer
	bl SND_GetCurrentCommandTag
	mov r4, r0
	mov r0, #1
	bl SND_FlushCommand
	mov r0, r4
	bl SND_WaitForCommandProc
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D8810: .word 0x0000FFFF
	arm_func_end NNS_SndStopSoundAll

	arm_func_start NNS_SndMain
NNS_SndMain: // 0x020D8814
	stmdb sp!, {r4, lr}
	mov r4, #0
_020D881C:
	mov r0, r4
	bl SND_RecvCommandReply
	cmp r0, #0
	bne _020D881C
	bl NNSi_SndPlayerMain
	bl NNSi_SndCaptureMain
	bl NNSi_SndArcStrmMain
	mov r0, #0
	bl SND_FlushCommand
	ldmia sp!, {r4, pc}
	arm_func_end NNS_SndMain

	arm_func_start NNS_SndInit
NNS_SndInit: // 0x020D8844
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020D88C8 // =0x0214A1C0
	ldr r1, [r0]
	cmp r1, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r1, #1
	str r1, [r0]
	bl SND_Init
	ldr ip, _020D88CC // =NNS_BeginSleep
	ldr r0, _020D88D0 // =0x0214A1C4
	mov r3, #0
	ldr r1, _020D88D4 // =0x0214A1D0
	ldr r2, _020D88D8 // =NNS_EndSleep
	str ip, [r0]
	str r3, [r0, #4]
	str r2, [r1]
	str r3, [r1, #4]
	bl PM_AppendPreSleepCallback
	ldr r0, _020D88D4 // =0x0214A1D0
	bl PM_PrependPreSleepCallback
	bl NNSi_SndInitResourceMgr
	bl NNSi_SndCaptureInit
	bl NNSi_SndPlayerInit
	ldr r1, _020D88DC // =_0214A1B4
	mvn r3, #0
	ldr r0, _020D88E0 // =0x0214A1B8
	mov r2, #1
	strb r3, [r1]
	str r2, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D88C8: .word 0x0214A1C0
_020D88CC: .word NNS_BeginSleep
_020D88D0: .word 0x0214A1C4
_020D88D4: .word 0x0214A1D0
_020D88D8: .word NNS_EndSleep
_020D88DC: .word _0214A1B4
_020D88E0: .word 0x0214A1B8
	arm_func_end NNS_SndInit

	arm_func_start NNSi_SndInitResourceMgr
NNSi_SndInitResourceMgr: // 0x020D88E4
	ldr r2, _020D8904 // =0x0214C5A8
	mov r3, #0
	ldr r1, _020D8908 // =0x0214C5A0
	ldr r0, _020D890C // =0x0214C5A4
	str r3, [r2]
	str r3, [r1]
	str r3, [r0]
	bx lr
	.align 2, 0
_020D8904: .word 0x0214C5A8
_020D8908: .word 0x0214C5A0
_020D890C: .word 0x0214C5A4
	arm_func_end NNSi_SndInitResourceMgr

	arm_func_start NNS_SndFreeAlarm
NNS_SndFreeAlarm: // 0x020D8910
	ldr r1, _020D892C // =0x0214C5A4
	mov r2, #1
	mvn r0, r2, lsl r0
	ldr r2, [r1]
	and r0, r2, r0
	str r0, [r1]
	bx lr
	.align 2, 0
_020D892C: .word 0x0214C5A4
	arm_func_end NNS_SndFreeAlarm

	arm_func_start NNS_SndAllocAlarm
NNS_SndAllocAlarm: // 0x020D8930
	ldr r0, _020D8970 // =0x0214C5A4
	mov r3, #1
	ldr r2, [r0]
	mov r0, #0
_020D8940:
	ands r1, r2, r3
	ldreq r1, _020D8970 // =0x0214C5A4
	ldreq r2, [r1]
	orreq r2, r2, r3
	streq r2, [r1]
	bxeq lr
	add r0, r0, #1
	cmp r0, #8
	mov r3, r3, lsl #1
	blt _020D8940
	mvn r0, #0
	bx lr
	.align 2, 0
_020D8970: .word 0x0214C5A4
	arm_func_end NNS_SndAllocAlarm

	arm_func_start NNS_SndUnlockCapture
NNS_SndUnlockCapture: // 0x020D8974
	ldr r1, _020D898C // =0x0214C5A0
	mvn r0, r0
	ldr r2, [r1]
	and r0, r2, r0
	str r0, [r1]
	bx lr
	.align 2, 0
_020D898C: .word 0x0214C5A0
	arm_func_end NNS_SndUnlockCapture

	arm_func_start NNS_SndLockCapture
NNS_SndLockCapture: // 0x020D8990
	ldr r1, _020D89B0 // =0x0214C5A0
	ldr r2, [r1]
	ands r3, r0, r2
	movne r0, #0
	orreq r0, r2, r0
	streq r0, [r1]
	moveq r0, #1
	bx lr
	.align 2, 0
_020D89B0: .word 0x0214C5A0
	arm_func_end NNS_SndLockCapture

	arm_func_start NNS_SndUnlockChannel
NNS_SndUnlockChannel: // 0x020D89B4
	stmdb sp!, {r4, lr}
	movs r4, r0
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	bl SND_UnlockChannel
	ldr r0, _020D89E0 // =0x0214C5A8
	mvn r1, r4
	ldr r2, [r0]
	and r1, r2, r1
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D89E0: .word 0x0214C5A8
	arm_func_end NNS_SndUnlockChannel

	arm_func_start NNS_SndLockChannel
NNS_SndLockChannel: // 0x020D89E4
	stmdb sp!, {r4, lr}
	movs r4, r0
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	ldr r1, _020D8A28 // =0x0214C5A8
	ldr r1, [r1]
	ands r1, r4, r1
	movne r0, #0
	ldmneia sp!, {r4, pc}
	mov r1, #0
	bl SND_LockChannel
	ldr r1, _020D8A28 // =0x0214C5A8
	mov r0, #1
	ldr r2, [r1]
	orr r2, r2, r4
	str r2, [r1]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D8A28: .word 0x0214C5A8
	arm_func_end NNS_SndLockChannel

	arm_func_start NNS_Snd_SetPlayerPriority
NNS_Snd_SetPlayerPriority: // 0x020D8A2C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #4]
	mov r5, r1
	cmp r4, #0
	beq _020D8A58
	mov r0, r4
	mov r1, r6
	bl NNS_FndRemoveListObject
	mov r0, #0
	str r0, [r6, #4]
_020D8A58:
	ldr r0, _020D8A88 // =0x0214C5B8
	mov r1, r6
	bl NNS_FndRemoveListObject
	strb r5, [r6, #0x3d]
	cmp r4, #0
	beq _020D8A7C
	mov r0, r4
	mov r1, r6
	bl NNS_Snd_InsertPlayerList
_020D8A7C:
	mov r0, r6
	bl NNS_Snd_InsertPrioList
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020D8A88: .word 0x0214C5B8
	arm_func_end NNS_Snd_SetPlayerPriority

	arm_func_start PlayerHeapDisposeCallback
PlayerHeapDisposeCallback: // 0x020D8A8C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #8]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl NNS_SndHeapDestroy
	ldr r1, [r4, #0xc]
	cmp r1, #0
	movne r0, #0
	strne r0, [r1, #8]
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x10]
	ldr r2, _020D8AD8 // =0x0214CA04
	mov r0, #0x24
	mla r0, r1, r0, r2
	mov r1, r4
	add r0, r0, #0xc
	bl NNS_FndRemoveListObject
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D8AD8: .word 0x0214CA04
	arm_func_end PlayerHeapDisposeCallback

	arm_func_start NNS_Snd_ShutdownPlayer
NNS_Snd_ShutdownPlayer: // 0x020D8ADC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r1, [r4]
	cmp r1, #0
	movne r0, #0
	strne r0, [r1]
	strne r0, [r4]
	ldr r5, [r4, #4]
	mov r1, r4
	mov r0, r5
	bl NNS_FndRemoveListObject
	mov r0, #0
	str r0, [r4, #4]
	ldr r1, [r4, #8]
	cmp r1, #0
	beq _020D8B38
	add r0, r5, #0xc
	bl NNS_FndAppendListObject
	ldr r0, [r4, #8]
	mov r1, #0
	str r1, [r0, #0xc]
	str r1, [r4, #8]
_020D8B38:
	ldr r0, _020D8B60 // =0x0214C5B8
	mov r1, r4
	bl NNS_FndRemoveListObject
	ldr r0, _020D8B64 // =0x0214C5AC
	mov r1, r4
	bl NNS_FndAppendListObject
	mov r0, #0
	strb r0, [r4, #0x2c]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D8B60: .word 0x0214C5B8
_020D8B64: .word 0x0214C5AC
	arm_func_end NNS_Snd_ShutdownPlayer

	arm_func_start NNS_Snd_AllocSeqPlayer
NNS_Snd_AllocSeqPlayer: // 0x020D8B68
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, _020D8BD4 // =0x0214C5AC
	mov r1, #0
	bl NNS_FndGetNextListObject
	movs r4, r0
	bne _020D8BB0
	ldr r0, _020D8BD8 // =0x0214C5B8
	mov r1, #0
	bl NNS_FndGetNextListObject
	mov r4, r0
	ldrb r1, [r4, #0x3d]
	cmp r5, r1
	addlt sp, sp, #4
	movlt r0, #0
	ldmltia sp!, {r4, r5, pc}
	bl NNS_Snd_ForceStopSeq
_020D8BB0:
	ldr r0, _020D8BD4 // =0x0214C5AC
	mov r1, r4
	bl NNS_FndRemoveListObject
	mov r0, r4
	strb r5, [r4, #0x3d]
	bl NNS_Snd_InsertPrioList
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D8BD4: .word 0x0214C5AC
_020D8BD8: .word 0x0214C5B8
	arm_func_end NNS_Snd_AllocSeqPlayer

	arm_func_start NNS_Snd_ForceStopSeq
NNS_Snd_ForceStopSeq: // 0x020D8BDC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrb r0, [r4, #0x2c]
	cmp r0, #2
	bne _020D8BFC
	ldrb r0, [r4, #0x3c]
	ldr r1, _020D8C10 // =0xFFFFFD2D
	bl SND_SetPlayerVolume
_020D8BFC:
	ldrb r0, [r4, #0x3c]
	bl SND_StopSeq
	mov r0, r4
	bl NNS_Snd_ShutdownPlayer
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D8C10: .word 0xFFFFFD2D
	arm_func_end NNS_Snd_ForceStopSeq

	arm_func_start NNS_Snd_InsertPrioList
NNS_Snd_InsertPrioList: // 0x020D8C14
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, _020D8C6C // =0x0214C5B8
	mov r1, #0
	bl NNS_FndGetNextListObject
	movs r1, r0
	beq _020D8C58
	ldr r4, _020D8C6C // =0x0214C5B8
_020D8C38:
	ldrb r2, [r5, #0x3d]
	ldrb r0, [r1, #0x3d]
	cmp r2, r0
	blo _020D8C58
	mov r0, r4
	bl NNS_FndGetNextListObject
	movs r1, r0
	bne _020D8C38
_020D8C58:
	ldr r0, _020D8C6C // =0x0214C5B8
	mov r2, r5
	bl NNS_FndInsertListObject
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D8C6C: .word 0x0214C5B8
	arm_func_end NNS_Snd_InsertPrioList

	arm_func_start NNS_Snd_InsertPlayerList
NNS_Snd_InsertPlayerList: // 0x020D8C70
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r1, #0
	mov r5, r0
	bl NNS_FndGetNextListObject
	movs r1, r0
	beq _020D8CB0
_020D8C90:
	ldrb r2, [r4, #0x3d]
	ldrb r0, [r1, #0x3d]
	cmp r2, r0
	blo _020D8CB0
	mov r0, r5
	bl NNS_FndGetNextListObject
	movs r1, r0
	bne _020D8C90
_020D8CB0:
	mov r0, r5
	mov r2, r4
	bl NNS_FndInsertListObject
	str r5, [r4, #4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNS_Snd_InsertPlayerList

	arm_func_start NNS_Snd_InitPlayer
NNS_Snd_InitPlayer: // 0x020D8CC8
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	strb r0, [r4, #0x2e]
	strb r0, [r4, #0x2d]
	strb r0, [r4, #0x2f]
	strh r0, [r4, #0x34]
	strh r0, [r4, #0x3e]
	mov r1, #0x7f
	strb r1, [r4, #0x40]
	add r0, r4, #0x1c
	strb r1, [r4, #0x41]
	bl NNSi_SndFaderInit
	add r0, r4, #0x1c
	mov r1, #0x7f00
	mov r2, #1
	bl NNSi_SndFaderSet
	ldmia sp!, {r4, pc}
	arm_func_end NNS_Snd_InitPlayer

	arm_func_start NNSi_SndPlayerAllocHeap
NNSi_SndPlayerAllocHeap: // 0x020D8D10
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, _020D8D60 // =0x0214CA04
	mov r2, #0x24
	mla r5, r0, r2, r3
	mov r6, r1
	add r0, r5, #0xc
	mov r1, #0
	bl NNS_FndGetNextListObject
	movs r4, r0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r1, r4
	add r0, r5, #0xc
	bl NNS_FndRemoveListObject
	str r6, [r4, #0xc]
	str r4, [r6, #8]
	ldr r0, [r4, #8]
	bl NNS_SndHeapClear
	ldr r0, [r4, #8]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020D8D60: .word 0x0214CA04
	arm_func_end NNSi_SndPlayerAllocHeap

	arm_func_start NNSi_SndPlayerPause
NNSi_SndPlayerPause: // 0x020D8D64
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r0
	mov r4, r1
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldrb r0, [r5, #0x2e]
	cmp r4, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldrb r0, [r5, #0x3c]
	bl SND_PauseSeq
	strb r4, [r5, #0x2e]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNSi_SndPlayerPause

	arm_func_start NNSi_SndPlayerStopSeq
NNSi_SndPlayerStopSeq: // 0x020D8DA0
	stmdb sp!, {r4, lr}
	movs r4, r0
	mov r2, r1
	ldmeqia sp!, {r4, pc}
	ldrb r1, [r4, #0x2c]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	cmp r2, #0
	bne _020D8DCC
	bl NNS_Snd_ForceStopSeq
	ldmia sp!, {r4, pc}
_020D8DCC:
	add r0, r4, #0x1c
	mov r1, #0
	bl NNSi_SndFaderSet
	mov r0, r4
	mov r1, #0
	bl NNS_Snd_SetPlayerPriority
	mov r0, #2
	strb r0, [r4, #0x2c]
	ldmia sp!, {r4, pc}
	arm_func_end NNSi_SndPlayerStopSeq

	arm_func_start NNSi_SndPlayerStartSeq
NNSi_SndPlayerStartSeq: // 0x020D8DF0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldrb r0, [r5, #0x3c]
	ldr r4, [r5, #4]
	bl SND_PrepareSeq
	ldr r2, [r4, #0x1c]
	cmp r2, #0
	beq _020D8E20
	ldrb r0, [r5, #0x3c]
	ldr r1, _020D8E44 // =0x0000FFFF
	bl SND_SetTrackAllocatableChannel
_020D8E20:
	mov r0, r5
	bl NNS_Snd_InitPlayer
	bl SND_GetCurrentCommandTag
	str r0, [r5, #0x30]
	mov r0, #1
	strb r0, [r5, #0x2f]
	strb r0, [r5, #0x2c]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D8E44: .word 0x0000FFFF
	arm_func_end NNSi_SndPlayerStartSeq

	arm_func_start NNSi_SndPlayerFreeSeqPlayer
NNSi_SndPlayerFreeSeqPlayer: // 0x020D8E48
	ldr ip, _020D8E50 // =NNS_Snd_ShutdownPlayer
	bx ip
	.align 2, 0
_020D8E50: .word NNS_Snd_ShutdownPlayer
	arm_func_end NNSi_SndPlayerFreeSeqPlayer

	arm_func_start NNSi_SndPlayerAllocSeqPlayer
NNSi_SndPlayerAllocSeqPlayer: // 0x020D8E54
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr ip, _020D8EFC // =0x0214CA04
	mov r3, #0x24
	mov r4, r0
	ldr r5, [r4]
	mla r6, r1, r3, ip
	mov r7, r2
	cmp r5, #0
	beq _020D8E80
	bl NNS_SndHandleReleaseSeq
_020D8E80:
	ldrh r1, [r6, #8]
	ldr r0, [r6, #0x18]
	cmp r1, r0
	blo _020D8EC4
	mov r0, r6
	mov r1, #0
	bl NNS_FndGetNextListObject
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldrb r1, [r0, #0x3d]
	cmp r7, r1
	addlt sp, sp, #4
	movlt r0, #0
	ldmltia sp!, {r4, r5, r6, r7, pc}
	bl NNS_Snd_ForceStopSeq
_020D8EC4:
	mov r0, r7
	bl NNS_Snd_AllocSeqPlayer
	movs r5, r0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r6
	mov r1, r5
	bl NNS_Snd_InsertPlayerList
	str r4, [r5]
	mov r0, r5
	str r5, [r4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020D8EFC: .word 0x0214CA04
	arm_func_end NNSi_SndPlayerAllocSeqPlayer

	arm_func_start NNSi_SndPlayerMain
NNSi_SndPlayerMain: // 0x020D8F00
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0xc
	bl SND_GetPlayerStatus
	str r0, [sp]
	ldr r0, _020D9074 // =0x0214C5B8
	mov r1, #0
	bl NNS_FndGetNextListObject
	movs sl, r0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, #0x8000
	rsb r0, r0, #0
	ldr r4, _020D9078 // =_02116BC8
	str r0, [sp, #4]
	mov r5, #1
	mov fp, #0
_020D8F40:
	ldr r0, _020D9074 // =0x0214C5B8
	mov r1, sl
	bl NNS_FndGetNextListObject
	ldrb r1, [sl, #0x2d]
	mov sb, r0
	cmp r1, #0
	bne _020D8F6C
	ldr r0, [sl, #0x30]
	bl SND_IsFinishedCommandTag
	cmp r0, #0
	strneb r5, [sl, #0x2d]
_020D8F6C:
	ldrb r0, [sl, #0x2d]
	cmp r0, #0
	beq _020D8F98
	ldrb r0, [sl, #0x3c]
	mov r1, r5, lsl r0
	ldr r0, [sp]
	ands r0, r0, r1
	bne _020D8F98
	mov r0, sl
	bl NNS_Snd_ShutdownPlayer
	b _020D9060
_020D8F98:
	add r0, sl, #0x1c
	bl NNSi_SndFaderUpdate
	ldr r0, [sl, #4]
	ldrb r2, [sl, #0x41]
	ldrb r1, [sl, #0x40]
	ldrb r0, [r0, #0x20]
	mov r3, r2, lsl #1
	mov r2, r1, lsl #1
	mov r1, r0, lsl #1
	add r0, sl, #0x1c
	ldrsh r8, [r4, r3]
	ldrsh r7, [r4, r2]
	ldrsh r6, [r4, r1]
	bl NNSi_SndFaderGet
	mov r0, r0, asr #8
	mov r2, r0, lsl #1
	add r1, r7, r8
	mov r0, #0x8000
	ldrsh r2, [r4, r2]
	add r1, r6, r1
	rsb r0, r0, #0
	add r6, r2, r1
	cmp r6, r0
	ldrlt r6, [sp, #4]
	blt _020D9008
	ldr r0, _020D907C // =0x00007FFF
	cmp r6, r0
	movgt r6, r0
_020D9008:
	ldrsh r0, [sl, #0x3e]
	cmp r6, r0
	beq _020D9024
	ldrb r0, [sl, #0x3c]
	mov r1, r6
	bl SND_SetPlayerVolume
	strh r6, [sl, #0x3e]
_020D9024:
	ldrb r0, [sl, #0x2c]
	cmp r0, #2
	bne _020D9048
	add r0, sl, #0x1c
	bl NNSi_SndFaderIsFinished
	cmp r0, #0
	beq _020D9048
	mov r0, sl
	bl NNS_Snd_ForceStopSeq
_020D9048:
	ldrb r0, [sl, #0x2f]
	cmp r0, #0
	beq _020D9060
	ldrb r0, [sl, #0x3c]
	bl SND_StartPreparedSeq
	strb fp, [sl, #0x2f]
_020D9060:
	mov sl, sb
	cmp sb, #0
	bne _020D8F40
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_020D9074: .word 0x0214C5B8
_020D9078: .word _02116BC8
_020D907C: .word 0x00007FFF
	arm_func_end NNSi_SndPlayerMain

	arm_func_start NNSi_SndPlayerInit
NNSi_SndPlayerInit: // 0x020D9080
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, lr}
	ldr r0, _020D9124 // =0x0214C5B8
	mov r1, #0x14
	bl NNS_FndInitList
	ldr r0, _020D9128 // =0x0214C5AC
	mov r1, #0x14
	bl NNS_FndInitList
	ldr r6, _020D912C // =0x0214C5C4
	mov r7, #0
	ldr r4, _020D9128 // =0x0214C5AC
	mov r5, r7
_020D90AC:
	strb r5, [r6, #0x2c]
	mov r0, r4
	mov r1, r6
	strb r7, [r6, #0x3c]
	bl NNS_FndAppendListObject
	add r7, r7, #1
	cmp r7, #0x10
	add r6, r6, #0x44
	blt _020D90AC
	ldr sl, _020D9130 // =0x0214CA04
	mov sb, #0
	mov r7, sb
	mov r4, sb
	mov r8, #0xc
	mov r6, #0x7f
	mov r5, #1
_020D90EC:
	mov r0, sl
	mov r1, r8
	bl NNS_FndInitList
	mov r1, r7
	add r0, sl, #0xc
	bl NNS_FndInitList
	strb r6, [sl, #0x20]
	str r5, [sl, #0x18]
	add sb, sb, #1
	str r4, [sl, #0x1c]
	cmp sb, #0x20
	add sl, sl, #0x24
	blt _020D90EC
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	.align 2, 0
_020D9124: .word 0x0214C5B8
_020D9128: .word 0x0214C5AC
_020D912C: .word 0x0214C5C4
_020D9130: .word 0x0214CA04
	arm_func_end NNSi_SndPlayerInit

	arm_func_start NNS_SndPlayerReadDriverTrackInfo
NNS_SndPlayerReadDriverTrackInfo: // 0x020D9134
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	ldrb r0, [r0, #0x3c]
	bl NNSi_SndReadDriverPlayerInfo
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndPlayerReadDriverTrackInfo

	arm_func_start NNS_SndPlayerReadDriverPlayerInfo
NNS_SndPlayerReadDriverPlayerInfo: // 0x020D9160
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	ldrb r0, [r0, #0x3c]
	bl NNS_SndReadDriverChannelInfo
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndPlayerReadDriverPlayerInfo

	arm_func_start NNS_SndPlayerSetSeqArcNo
NNS_SndPlayerSetSeqArcNo: // 0x020D918C
	ldr ip, [r0]
	cmp ip, #0
	bxeq lr
	mov r3, #2
	strh r3, [ip, #0x34]
	ldr r3, [r0]
	strh r1, [r3, #0x38]
	ldr r0, [r0]
	strh r2, [r0, #0x3a]
	bx lr
	arm_func_end NNS_SndPlayerSetSeqArcNo

	arm_func_start NNS_SndPlayerSetSeqNo
NNS_SndPlayerSetSeqNo: // 0x020D91B4
	ldr r3, [r0]
	cmp r3, #0
	movne r2, #1
	strneh r2, [r3, #0x34]
	ldrne r0, [r0]
	strneh r1, [r0, #0x38]
	bx lr
	arm_func_end NNS_SndPlayerSetSeqNo

	arm_func_start NNS_SndPlayerSetTempoRatio
NNS_SndPlayerSetTempoRatio: // 0x020D91D0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldrb r0, [r0, #0x3c]
	bl SND_SetPlayerTempoRatio
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndPlayerSetTempoRatio

	arm_func_start NNS_SndPlayerSetTrackModDepth
NNS_SndPlayerSetTrackModDepth: // 0x020D91F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldrb r0, [r0, #0x3c]
	bl SND_SetTrackModDepth
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndPlayerSetTrackModDepth

	arm_func_start NNS_SndPlayerSetTrackPan
NNS_SndPlayerSetTrackPan: // 0x020D9220
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldrb r0, [r0, #0x3c]
	bl SND_SetTrackPan
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndPlayerSetTrackPan

	arm_func_start NNS_SndPlayerSetTrackPitch
NNS_SndPlayerSetTrackPitch: // 0x020D9248
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldrb r0, [r0, #0x3c]
	bl SND_SetTrackPitch
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndPlayerSetTrackPitch

	arm_func_start NNS_SndPlayerSetTrackVolume
NNS_SndPlayerSetTrackVolume: // 0x020D9270
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r3, _020D92A4 // =_02116BC8
	mov r2, r2, lsl #1
	ldrb r0, [r0, #0x3c]
	ldrsh r2, [r3, r2]
	bl SND_SetTrackVolume
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D92A4: .word _02116BC8
	arm_func_end NNS_SndPlayerSetTrackVolume

	arm_func_start NNS_SndPlayerSetChannelPriority
NNS_SndPlayerSetChannelPriority: // 0x020D92A8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldrb r0, [r0, #0x3c]
	bl SND_SetPlayerChannelPriority
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndPlayerSetChannelPriority

	arm_func_start NNS_SndPlayerSetPlayerPriority
NNS_SndPlayerSetPlayerPriority: // 0x020D92D0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl NNS_Snd_SetPlayerPriority
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndPlayerSetPlayerPriority

	arm_func_start NNS_SndPlayerMoveVolume
NNS_SndPlayerMoveVolume: // 0x020D92F4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, [r0]
	cmp r3, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldrb r0, [r3, #0x2c]
	cmp r0, #2
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	add r0, r3, #0x1c
	mov r1, r1, lsl #8
	bl NNSi_SndFaderSet
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndPlayerMoveVolume

	arm_func_start NNS_SndPlayerSetInitialVolume
NNS_SndPlayerSetInitialVolume: // 0x020D9330
	ldr r0, [r0]
	cmp r0, #0
	strneb r1, [r0, #0x40]
	bx lr
	arm_func_end NNS_SndPlayerSetInitialVolume

	arm_func_start NNS_SndPlayerSetVolume
NNS_SndPlayerSetVolume: // 0x020D9340
	ldr r0, [r0]
	cmp r0, #0
	strneb r1, [r0, #0x41]
	bx lr
	arm_func_end NNS_SndPlayerSetVolume

	arm_func_start NNS_SndPlayerCountPlayingSeqBySeqArcNo
NNS_SndPlayerCountPlayingSeqBySeqArcNo: // 0x020D9350
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r5, #0
	mov r6, r1
	ldr r0, _020D93BC // =0x0214C5B8
	mov r1, r5
	bl NNS_FndGetNextListObject
	movs r1, r0
	beq _020D93B0
	ldr r4, _020D93BC // =0x0214C5B8
_020D937C:
	ldrh r0, [r1, #0x34]
	cmp r0, #2
	bne _020D93A0
	ldrh r0, [r1, #0x38]
	cmp r0, r7
	bne _020D93A0
	ldrh r0, [r1, #0x3a]
	cmp r0, r6
	addeq r5, r5, #1
_020D93A0:
	mov r0, r4
	bl NNS_FndGetNextListObject
	movs r1, r0
	bne _020D937C
_020D93B0:
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020D93BC: .word 0x0214C5B8
	arm_func_end NNS_SndPlayerCountPlayingSeqBySeqArcNo

	arm_func_start NNS_SndHandleReleaseSeq
NNS_SndHandleReleaseSeq: // 0x020D93C0
	ldr r2, [r0]
	cmp r2, #0
	movne r1, #0
	strne r1, [r2]
	strne r1, [r0]
	bx lr
	arm_func_end NNS_SndHandleReleaseSeq

	arm_func_start NNS_SndHandleInit
NNS_SndHandleInit: // 0x020D93D8
	mov r1, #0
	str r1, [r0]
	bx lr
	arm_func_end NNS_SndHandleInit

	arm_func_start NNS_SndPlayerPauseAll
NNS_SndPlayerPauseAll: // 0x020D93E4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r0, _020D943C // =0x0214C5B8
	mov r1, #0
	bl NNS_FndGetNextListObject
	movs r6, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r5, _020D943C // =0x0214C5B8
_020D940C:
	mov r0, r5
	mov r1, r6
	bl NNS_FndGetNextListObject
	mov r4, r0
	mov r0, r6
	mov r1, r7
	bl NNSi_SndPlayerPause
	mov r6, r4
	cmp r4, #0
	bne _020D940C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020D943C: .word 0x0214C5B8
	arm_func_end NNS_SndPlayerPauseAll

	arm_func_start NNS_SndPlayerPauseByPlayerNo
NNS_SndPlayerPauseByPlayerNo: // 0x020D9440
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r3, _020D94A0 // =0x0214CA04
	mov r2, #0x24
	mla r5, r0, r2, r3
	mov r7, r1
	mov r0, r5
	mov r1, #0
	bl NNS_FndGetNextListObject
	movs r6, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_020D9470:
	mov r0, r5
	mov r1, r6
	bl NNS_FndGetNextListObject
	mov r4, r0
	mov r0, r6
	mov r1, r7
	bl NNSi_SndPlayerPause
	mov r6, r4
	cmp r4, #0
	bne _020D9470
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020D94A0: .word 0x0214CA04
	arm_func_end NNS_SndPlayerPauseByPlayerNo

	arm_func_start NNS_SndPlayerPause
NNS_SndPlayerPause: // 0x020D94A4
	ldr ip, _020D94B0 // =NNSi_SndPlayerPause
	ldr r0, [r0]
	bx ip
	.align 2, 0
_020D94B0: .word NNSi_SndPlayerPause
	arm_func_end NNS_SndPlayerPause

	arm_func_start NNS_SndPlayerStopSeqAll
NNS_SndPlayerStopSeqAll: // 0x020D94B4
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, _020D94F0 // =0x0214C5C4
	mov r6, r0
	mov r5, #0
_020D94C4:
	ldrb r0, [r4, #0x2c]
	cmp r0, #0
	beq _020D94DC
	mov r0, r4
	mov r1, r6
	bl NNSi_SndPlayerStopSeq
_020D94DC:
	add r5, r5, #1
	cmp r5, #0x10
	add r4, r4, #0x44
	blt _020D94C4
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020D94F0: .word 0x0214C5C4
	arm_func_end NNS_SndPlayerStopSeqAll

	arm_func_start NNS_SndPlayerStopSeqBySeqArcIdx
NNS_SndPlayerStopSeqBySeqArcIdx: // 0x020D94F4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r4, _020D955C // =0x0214C5C4
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, #0
_020D950C:
	ldrb r0, [r4, #0x2c]
	cmp r0, #0
	beq _020D9548
	ldrh r0, [r4, #0x34]
	cmp r0, #2
	bne _020D9548
	ldrh r0, [r4, #0x38]
	cmp r0, r8
	bne _020D9548
	ldrh r0, [r4, #0x3a]
	cmp r0, r7
	bne _020D9548
	mov r0, r4
	mov r1, r6
	bl NNSi_SndPlayerStopSeq
_020D9548:
	add r5, r5, #1
	cmp r5, #0x10
	add r4, r4, #0x44
	blt _020D950C
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020D955C: .word 0x0214C5C4
	arm_func_end NNS_SndPlayerStopSeqBySeqArcIdx

	arm_func_start NNS_SndPlayerStopSeqBySeqArcNo
NNS_SndPlayerStopSeqBySeqArcNo: // 0x020D9560
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r4, _020D95C0 // =0x0214C5C4
	mov r7, r0
	mov r6, r1
	mov r5, #0
_020D9578:
	ldrb r0, [r4, #0x2c]
	cmp r0, #0
	beq _020D95A8
	ldrh r0, [r4, #0x34]
	cmp r0, #1
	bne _020D95A8
	ldrh r0, [r4, #0x38]
	cmp r0, r7
	bne _020D95A8
	mov r0, r4
	mov r1, r6
	bl NNSi_SndPlayerStopSeq
_020D95A8:
	add r5, r5, #1
	cmp r5, #0x10
	add r4, r4, #0x44
	blt _020D9578
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020D95C0: .word 0x0214C5C4
	arm_func_end NNS_SndPlayerStopSeqBySeqArcNo

	arm_func_start NNS_SndPlayerStopSeq
NNS_SndPlayerStopSeq: // 0x020D95C4
	ldr ip, _020D95D0 // =NNSi_SndPlayerStopSeq
	ldr r0, [r0]
	bx ip
	.align 2, 0
_020D95D0: .word NNSi_SndPlayerStopSeq
	arm_func_end NNS_SndPlayerStopSeq

	arm_func_start NNS_SndPlayerCreateHeap
NNS_SndPlayerCreateHeap: // 0x020D95D4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r2
	mov r6, r0
	mov r0, r1
	mov r3, #0
	ldr r2, _020D9660 // =PlayerHeapDisposeCallback
	add r1, r5, #0x14
	str r3, [sp]
	bl NNS_SndHeapAlloc
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r2, #0
	str r2, [r4, #0xc]
	str r6, [r4, #0x10]
	mov r1, r5
	add r0, r4, #0x14
	str r2, [r4, #8]
	bl NNS_SndHeapCreate
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r2, _020D9664 // =0x0214CA04
	mov r1, #0x24
	mla r2, r6, r1, r2
	str r0, [r4, #8]
	mov r1, r4
	add r0, r2, #0xc
	bl NNS_FndAppendListObject
	mov r0, #1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020D9660: .word PlayerHeapDisposeCallback
_020D9664: .word 0x0214CA04
	arm_func_end NNS_SndPlayerCreateHeap

	arm_func_start NNS_SndPlayerSetPlayableSeqCount
NNS_SndPlayerSetPlayableSeqCount: // 0x020D9668
	mov r2, #0x24
	mul r2, r0, r2
	ldr r0, _020D967C // =0x0214CA20
	str r1, [r0, r2]
	bx lr
	.align 2, 0
_020D967C: .word 0x0214CA20
	arm_func_end NNS_SndPlayerSetPlayableSeqCount

	arm_func_start NNS_SndPlayerSetPlayerVolume
NNS_SndPlayerSetPlayerVolume: // 0x020D9680
	mov r2, #0x24
	mul r2, r0, r2
	mov r0, r1, lsl #0x10
	ldr r1, _020D969C // =0x0214CA1C
	mov r0, r0, lsr #0x10
	str r0, [r1, r2]
	bx lr
	.align 2, 0
_020D969C: .word 0x0214CA1C
	arm_func_end NNS_SndPlayerSetPlayerVolume

	arm_func_start NNS_Snd_EndSleep
NNS_Snd_EndSleep: // 0x020D96A0
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r0, [r4, #0x24]
	mov r0, r0, lsl #0x1e
	movs r0, r0, asr #0x1f
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #0x38]
	cmp r0, #0
	beq _020D96F0
	mov r5, #1
_020D96C8:
	bl OS_DisableInterrupts
	mov r6, r0
	mov r0, r4
	mov r1, r5
	bl NNS_StrmCallback
	mov r0, r6
	bl OS_RestoreInterrupts
	ldr r0, [r4, #0x38]
	cmp r0, #0
	bne _020D96C8
_020D96F0:
	ldr r0, [r4, #0x40]
	mov r2, #1
	mov r1, #0
	mov r2, r2, lsl r0
	ldr r0, [r4, #0x44]
	mov r3, r1
	bl SND_StartTimer
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNS_Snd_EndSleep

	arm_func_start NNS_Snd_BeginSleep
NNS_Snd_BeginSleep: // 0x020D9710
	stmdb sp!, {r4, lr}
	ldr r1, [r0, #0x24]
	mov r1, r1, lsl #0x1e
	movs r1, r1, asr #0x1f
	ldmeqia sp!, {r4, pc}
	ldr r2, [r0, #0x40]
	mov r3, #1
	mov r1, #0
	mov r2, r3, lsl r2
	ldr r0, [r0, #0x44]
	mov r3, r1
	bl SND_StopTimer
	bl SND_GetCurrentCommandTag
	mov r4, r0
	mov r0, #1
	bl SND_FlushCommand
	mov r0, r4
	bl SND_WaitForCommandProc
	ldmia sp!, {r4, pc}
	arm_func_end NNS_Snd_BeginSleep

	arm_func_start NNS_StrmCallback
NNS_StrmCallback: // 0x020D975C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r4, r1
	ldr r0, [r5, #0x28]
	ldr r1, [r5, #0x2c]
	bl _u32_div_f
	ldr r1, [r5, #0x48]
	ldr r2, [r5, #0x38]
	mov r3, r0
	mul lr, r3, r2
	cmp r1, #0
	mov ip, #0
	ble _020D97C0
	ldr r2, _020D9808 // =0x0214CED4
	ldr r0, _020D980C // =0x0214CE94
_020D979C:
	add r1, r5, ip
	ldrb r1, [r1, #0x4c]
	ldr r1, [r2, r1, lsl #3]
	add r1, r1, lr
	str r1, [r0, ip, lsl #2]
	ldr r1, [r5, #0x48]
	add ip, ip, #1
	cmp ip, r1
	blt _020D979C
_020D97C0:
	ldr r0, [r5, #0x20]
	ldr r2, _020D980C // =0x0214CE94
	str r0, [sp]
	ldr ip, [r5, #0x34]
	mov r0, r4
	str ip, [sp, #4]
	ldr r4, [r5, #0x30]
	blx r4
	ldr r0, [r5, #0x38]
	add r0, r0, #1
	str r0, [r5, #0x38]
	ldr r1, [r5, #0x38]
	ldr r0, [r5, #0x2c]
	cmp r1, r0
	movge r0, #0
	strge r0, [r5, #0x38]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D9808: .word 0x0214CED4
_020D980C: .word 0x0214CE94
	arm_func_end NNS_StrmCallback

	arm_func_start NNS_AlarmCallback
NNS_AlarmCallback: // 0x020D9810
	ldr ip, _020D981C // =NNS_StrmCallback
	mov r1, #1
	bx ip
	.align 2, 0
_020D981C: .word NNS_StrmCallback
	arm_func_end NNS_AlarmCallback

	arm_func_start NNS_ShutdownStrm
NNS_ShutdownStrm: // 0x020D9820
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x40]
	bl NNS_SndFreeAlarm
	ldr r0, _020D984C // =0x0214CE88
	mov r1, r4
	bl NNS_FndRemoveListObject
	ldr r0, [r4, #0x24]
	bic r0, r0, #1
	str r0, [r4, #0x24]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D984C: .word 0x0214CE88
	arm_func_end NNS_ShutdownStrm

	arm_func_start NNS_ForceStopStrm
NNS_ForceStopStrm: // 0x020D9850
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x24]
	mov r0, r0, lsl #0x1e
	movs r0, r0, asr #0x1f
	beq _020D98BC
	ldr r0, [r4, #0x40]
	mov r2, #1
	mov r1, #0
	mov r2, r2, lsl r0
	ldr r0, [r4, #0x44]
	mov r3, r1
	bl SND_StopTimer
	add r0, r4, #8
	bl PM_AppendPostSleepCallback
	add r0, r4, #0x14
	bl PM_PrependPostSleepCallback
	ldr r0, [r4, #0x24]
	bic r0, r0, #2
	str r0, [r4, #0x24]
	bl SND_GetCurrentCommandTag
	mov r5, r0
	mov r0, #1
	bl SND_FlushCommand
	mov r0, r5
	bl SND_WaitForCommandProc
_020D98BC:
	mov r0, r4
	bl NNS_ShutdownStrm
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNS_ForceStopStrm

	arm_func_start NNS_SndStrmSetChannelPan
NNS_SndStrmSetChannelPan: // 0x020D98CC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, [r0, #0x48]
	sub r3, r3, #1
	cmp r1, r3
	addgt sp, sp, #4
	ldmgtia sp!, {pc}
	add r0, r0, r1
	ldrb r0, [r0, #0x4c]
	mov r3, #1
	mov r1, r2
	mov r0, r3, lsl r0
	bl SND_SetChannelPan
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndStrmSetChannelPan

	arm_func_start NNS_SndStrmSetVolume
NNS_SndStrmSetVolume: // 0x020D9908
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	str r1, [r7, #0x3c]
	ldr r0, [r7, #0x48]
	mov r5, #0
	cmp r0, #0
	ldmleia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r4, _020D9970 // =0x0214CED4
	mov r8, #1
_020D992C:
	add r0, r7, r5
	ldrb r6, [r0, #0x4c]
	ldr r1, [r7, #0x3c]
	add r0, r4, r6, lsl #3
	ldr r0, [r0, #4]
	add r0, r1, r0
	bl SND_CalcChannelVolume
	mov r2, r0
	mov r0, r8, lsl r6
	and r1, r2, #0xff
	mov r2, r2, asr #8
	bl SND_SetChannelVolume
	ldr r0, [r7, #0x48]
	add r5, r5, #1
	cmp r5, r0
	blt _020D992C
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020D9970: .word 0x0214CED4
	arm_func_end NNS_SndStrmSetVolume

	arm_func_start NNS_SndStrmStop
NNS_SndStrmStop: // 0x020D9974
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, [r0, #0x24]
	mov r1, r1, lsl #0x1f
	movs r1, r1, asr #0x1f
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl NNS_ForceStopStrm
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndStrmStop

	arm_func_start NNS_SndStrmStart
NNS_SndStrmStart: // 0x020D999C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x40]
	mov r2, #1
	mov r1, #0
	mov r2, r2, lsl r0
	ldr r0, [r4, #0x44]
	mov r3, r1
	bl SND_StartTimer
	ldr r0, [r4, #0x24]
	mov r0, r0, lsl #0x1e
	movs r0, r0, asr #0x1f
	ldmneia sp!, {r4, pc}
	add r0, r4, #8
	bl PM_AppendPreSleepCallback
	add r0, r4, #0x14
	bl PM_PrependPreSleepCallback
	ldr r0, [r4, #0x24]
	orr r0, r0, #2
	str r0, [r4, #0x24]
	ldmia sp!, {r4, pc}
	arm_func_end NNS_SndStrmStart

	arm_func_start NNS_SndStrmSetup
NNS_SndStrmSetup: // 0x020D99F0
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x24
	mov sl, r0
	ldr r4, [sl, #0x24]
	mov sb, r1
	mov r1, r4, lsl #0x1f
	movs r1, r1, asr #0x1f
	ldr r1, [sp, #0x4c]
	str r2, [sp, #0x18]
	mov r4, r3
	str r1, [sp, #0x4c]
	beq _020D9A24
	bl NNS_SndStrmStop
_020D9A24:
	ldr r0, [sp, #0x4c]
	ldr r2, [sl, #0x48]
	mov r0, r0, lsl #5
	mul r1, r2, r0
	mov r0, r4
	bl _u32_div_f
	ldr r1, [sp, #0x4c]
	ldr r2, [sp, #0x48]
	mul r1, r0, r1
	mov r0, r1, lsl #5
	str r0, [sl, #0x28]
	ldr r0, [sl, #0x28]
	cmp sb, #1
	moveq r0, r0, lsr #1
	mul r0, r2, r0
	ldr r1, [sp, #0x4c]
	bl _u32_div_f
	str r0, [sp, #0x1c]
	bl NNS_SndAllocAlarm
	str r0, [sl, #0x40]
	ldr r0, [sl, #0x40]
	cmp r0, #0
	addlt sp, sp, #0x24
	movlt r0, #0
	ldmltia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r0, [sl, #0x48]
	mov r8, #0
	cmp r0, #0
	ble _020D9B18
	ldr r0, [sp, #0x48]
	mov r7, r0, lsl #5
	ldr r6, _020D9BAC // =0x0214CED4
	mov r5, r8
	mov r4, #0x7f
	mov fp, #0x40
	mov r0, #1
	str r0, [sp, #0x20]
_020D9AB8:
	ldr r2, [sl, #0x28]
	ldr r1, [sp, #0x18]
	add r0, sl, r8
	mla r1, r2, r8, r1
	ldrb r0, [r0, #0x4c]
	ldr r3, [sp, #0x20]
	str r1, [r6, r0, lsl #3]
	add r1, r6, r0, lsl #3
	str r5, [r1, #4]
	str r5, [sp]
	ldr r2, [sl, #0x28]
	mov r1, sb
	mov r2, r2, lsr #2
	str r2, [sp, #4]
	str r4, [sp, #8]
	str r5, [sp, #0xc]
	str r7, [sp, #0x10]
	str fp, [sp, #0x14]
	ldr r2, [r6, r0, lsl #3]
	bl SND_SetupChannelPcm
	ldr r0, [sl, #0x48]
	add r8, r8, #1
	cmp r8, r0
	blt _020D9AB8
_020D9B18:
	str sl, [sp]
	ldr r1, [sp, #0x1c]
	ldr r0, [sl, #0x40]
	ldr r3, _020D9BB0 // =NNS_AlarmCallback
	mov r2, r1
	bl SND_SetupAlarm
	ldr r0, _020D9BB4 // =0x0214CE88
	mov r1, sl
	bl NNS_FndAppendListObject
	ldr r0, [sp, #0x4c]
	str sb, [sl, #0x20]
	str r0, [sl, #0x2c]
	ldr r1, [sp, #0x50]
	ldr r0, [sp, #0x54]
	str r1, [sl, #0x30]
	str r0, [sl, #0x34]
	mov r0, #0
	str r0, [sl, #0x38]
	str r0, [sl, #0x3c]
	ldr r0, [sl, #0x24]
	bic r0, r0, #1
	orr r0, r0, #1
	str r0, [sl, #0x24]
	bl OS_DisableInterrupts
	mov r4, r0
	mov r2, #1
	mov r0, sl
	mov r1, #0
	str r2, [sl, #0x2c]
	bl NNS_StrmCallback
	ldr r1, [sp, #0x4c]
	mov r0, r4
	str r1, [sl, #0x2c]
	bl OS_RestoreInterrupts
	mov r0, #1
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_020D9BAC: .word 0x0214CED4
_020D9BB0: .word NNS_AlarmCallback
_020D9BB4: .word 0x0214CE88
	arm_func_end NNS_SndStrmSetup

	arm_func_start NNS_SndStrmFreeChannel
NNS_SndStrmFreeChannel: // 0x020D9BB8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x44]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl NNS_SndUnlockChannel
	mov r0, #0
	str r0, [r4, #0x44]
	str r0, [r4, #0x48]
	ldmia sp!, {r4, pc}
	arm_func_end NNS_SndStrmFreeChannel

	arm_func_start NNS_SndStrmAllocChannel
NNS_SndStrmAllocChannel: // 0x020D9BE0
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r4, #0
	mov r6, r0
	mov ip, r4
	cmp r5, #0
	ble _020D9C20
	mov r1, #1
_020D9C00:
	ldrb r3, [r2, ip]
	add r0, r6, ip
	strb r3, [r0, #0x4c]
	ldrb r0, [r2, ip]
	add ip, ip, #1
	cmp ip, r5
	orr r4, r4, r1, lsl r0
	blt _020D9C00
_020D9C20:
	mov r0, r4
	bl NNS_SndLockChannel
	cmp r0, #0
	moveq r0, #0
	strne r5, [r6, #0x48]
	strne r4, [r6, #0x44]
	movne r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNS_SndStrmAllocChannel

	arm_func_start NNS_SndStrmInit
NNS_SndStrmInit: // 0x020D9C40
	stmdb sp!, {r4, lr}
	ldr r1, _020D9CB0 // =0x0214CE84
	mov r4, r0
	ldr r0, [r1]
	cmp r0, #0
	bne _020D9C70
	ldr r0, _020D9CB4 // =0x0214CE88
	mov r1, #0
	bl NNS_FndInitList
	ldr r0, _020D9CB0 // =0x0214CE84
	mov r1, #1
	str r1, [r0]
_020D9C70:
	ldr r1, _020D9CB8 // =NNS_Snd_BeginSleep
	ldr r0, _020D9CBC // =NNS_Snd_EndSleep
	str r1, [r4, #8]
	str r4, [r4, #0xc]
	str r0, [r4, #0x14]
	str r4, [r4, #0x18]
	mov r0, #0
	str r0, [r4, #0x44]
	str r0, [r4, #0x48]
	ldr r0, [r4, #0x24]
	bic r0, r0, #1
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x24]
	bic r0, r0, #2
	str r0, [r4, #0x24]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D9CB0: .word 0x0214CE84
_020D9CB4: .word 0x0214CE88
_020D9CB8: .word NNS_Snd_BeginSleep
_020D9CBC: .word NNS_Snd_EndSleep
	arm_func_end NNS_SndStrmInit

	arm_func_start NNSi_AlarmCallback
NNSi_AlarmCallback: // 0x020D9CC0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r4, [r7, #0x18]
	ldr r0, [r7, #0x1c]
	ldr r1, _020D9DB0 // =0x0214CF54
	mul r0, r4, r0
	ldr r3, [r7, #0xc]
	ldr r2, [r7, #0x10]
	ldr r1, [r1]
	add r6, r3, r0
	cmp r1, #0
	add r5, r2, r0
	beq _020D9D50
	ldr r2, _020D9DB4 // =0x0214CF58
	mov r1, #0x14
	ldr r2, [r2]
	ldr r3, _020D9DB8 // =0x0214CFD0
	mul r1, r2, r1
	str r7, [r3, r1]
	add r1, r3, r1
	str r4, [r1, #4]
	str r0, [r1, #8]
	str r6, [r1, #0xc]
	ldr r0, _020D9DBC // =0x0214CF5C
	mov r2, #0
	str r5, [r1, #0x10]
	bl OS_SendMessage
	ldr r0, _020D9DB4 // =0x0214CF58
	ldr r1, [r0]
	add r1, r1, #1
	str r1, [r0]
	cmp r1, #8
	movge r1, #0
	strge r1, [r0]
	b _020D9D88
_020D9D50:
	mov r0, r6
	mov r1, r4
	bl DC_InvalidateRange
	mov r0, r5
	mov r1, r4
	bl DC_InvalidateRange
	ldr r1, [r7, #0x38]
	mov r0, r6
	str r1, [sp]
	ldr r3, [r7, #8]
	ldr r6, [r7, #0x34]
	mov r1, r5
	mov r2, r4
	blx r6
_020D9D88:
	ldr r0, [r7, #0x1c]
	add r0, r0, #1
	str r0, [r7, #0x1c]
	ldr r1, [r7, #0x1c]
	ldr r0, [r7, #0x30]
	cmp r1, r0
	movge r0, #0
	strge r0, [r7, #0x1c]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020D9DB0: .word 0x0214CF54
_020D9DB4: .word 0x0214CF58
_020D9DB8: .word 0x0214CFD0
_020D9DBC: .word 0x0214CF5C
	arm_func_end NNSi_AlarmCallback

	arm_func_start NNSi_SndCaptureEndSleep
NNSi_SndCaptureEndSleep: // 0x020D9DC0
	stmdb sp!, {r4, lr}
	ldr r4, _020D9E38 // =0x0214CF7C
	ldr r0, [r4]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	str r0, [r4, #0x1c]
	ldr r1, [r4, #0xc]
	ldr r2, [r4, #0x14]
	bl MIi_CpuClear32
	ldr r1, [r4, #0x10]
	ldr r2, [r4, #0x14]
	mov r0, #0
	bl MIi_CpuClear32
	ldr r0, [r4, #0xc]
	ldr r1, [r4, #0x14]
	bl DC_FlushRange
	ldr r0, [r4, #0x10]
	ldr r1, [r4, #0x14]
	bl DC_FlushRange
	ldr r1, [r4, #0x2c]
	mov r3, #0
	cmp r1, #0
	movge r0, #1
	movge r2, r0, lsl r1
	ldr r0, [r4, #0x24]
	ldr r1, [r4, #0x28]
	movlt r2, #0
	bl SND_StartTimer
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D9E38: .word 0x0214CF7C
	arm_func_end NNSi_SndCaptureEndSleep

	arm_func_start NNSi_SndCaptureBeginSleep
NNSi_SndCaptureBeginSleep: // 0x020D9E3C
	stmdb sp!, {r4, lr}
	ldr r3, _020D9E90 // =0x0214CF7C
	ldr r0, [r3]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r3, #0x2c]
	cmp r1, #0
	movge r0, #1
	movge r2, r0, lsl r1
	ldr r0, [r3, #0x24]
	ldr r1, [r3, #0x28]
	movlt r2, #0
	mov r3, #0
	bl SND_StopTimer
	bl SND_GetCurrentCommandTag
	mov r4, r0
	mov r0, #1
	bl SND_FlushCommand
	mov r0, r4
	bl SND_WaitForCommandProc
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D9E90: .word 0x0214CF7C
	arm_func_end NNSi_SndCaptureBeginSleep

	arm_func_start NNSi_SndCaptureStop
NNSi_SndCaptureStop: // 0x020D9E94
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r4, _020D9F80 // =0x0214CF7C
	ldr r0, [r4]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r1, [r4, #0x2c]
	mov r3, #0
	cmp r1, #0
	movge r7, #1
	movlt r7, #0
	cmp r7, #0
	movne r0, #1
	movne r2, r0, lsl r1
	ldr r0, [r4, #0x24]
	ldr r1, [r4, #0x28]
	moveq r2, #0
	bl SND_StopTimer
	cmp r7, #0
	beq _020D9F20
	bl SND_GetCurrentCommandTag
	mov r5, r0
	mov r0, #1
	bl SND_FlushCommand
	mov r0, r5
	bl SND_WaitForCommandProc
	ldr r6, _020D9F84 // =0x0214CF5C
	mov r5, #0
_020D9F08:
	mov r0, r6
	mov r1, r5
	mov r2, r5
	bl OS_ReceiveMessage
	cmp r0, #0
	bne _020D9F08
_020D9F20:
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _020D9F30
	bl NNS_SndUnlockCapture
_020D9F30:
	ldr r0, [r4, #0x20]
	cmp r0, #0
	beq _020D9F40
	bl NNS_SndUnlockChannel
_020D9F40:
	cmp r7, #0
	beq _020D9F50
	ldr r0, [r4, #0x2c]
	bl NNS_SndFreeAlarm
_020D9F50:
	ldr r0, [r4, #4]
	cmp r0, #1
	bne _020D9F70
	mov r0, #0
	mov r1, r0
	mov r2, r0
	mov r3, r0
	bl SND_SetOutputSelector
_020D9F70:
	mov r0, #0
	str r0, [r4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020D9F80: .word 0x0214CF7C
_020D9F84: .word 0x0214CF5C
	arm_func_end NNSi_SndCaptureStop

	arm_func_start NNSi_SndCaptureStart
NNSi_SndCaptureStart: // 0x020D9F88
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x3c
	mov sl, r3
	str r0, [sp, #0x18]
	str r2, [sp, #0x20]
	mov r2, #0
	str r1, [sp, #0x1c]
	mov r0, r1
	mov r1, sl
	ldr sb, [sp, #0x6c]
	ldr r8, [sp, #0x74]
	str r2, [sp, #0x2c]
	mvn r6, #0
	ldr r4, _020DA2D4 // =0x0214CF7C
	bl DC_FlushRange
	ldr r0, [sp, #0x20]
	mov r1, sl
	bl DC_FlushRange
	ldr r0, [sp, #0x60]
	ldr r1, [sp, #0x70]
	cmp r0, #1
	moveq r7, #1
	ldr r0, _020DA2D8 // =0x00FFB0FF
	movne r7, #0
	bl _s32_div_f
	ldr r1, [sp, #0x84]
	mov fp, r0
	cmp r1, #0
	beq _020DA044
	add r1, fp, #0x10
	bic fp, r1, #0x1f
	mov r2, fp, asr #5
	mov r0, sl
	cmp r7, #0
	ldr r1, [sp, #0x80]
	moveq r0, sl, lsr #1
	str r2, [sp, #0x34]
	bl _u32_div_f
	ldr r1, [sp, #0x34]
	mov r5, #0x20
	mul r0, r1, r0
	str r0, [sp, #0x30]
	cmp r7, #0
	ldr r0, [sp, #0x34]
	moveq r5, r5, lsr #1
	mul r0, r5, r0
	mov r5, r0
_020DA044:
	cmp r7, #0
	movne r0, #0
	strne r0, [sp, #0x28]
	moveq r0, #1
	streq r0, [sp, #0x28]
	cmp r7, #0
	movne r0, #1
	strne r0, [sp, #0x24]
	moveq r0, #0
	streq r0, [sp, #0x24]
	ldr r0, [sp, #0x18]
	cmp r0, #2
	movne r0, #0xa
	strne r0, [sp, #0x2c]
	ldr r0, [sp, #0x84]
	cmp r0, #0
	beq _020DA09C
	bl NNS_SndAllocAlarm
	movs r6, r0
	addmi sp, sp, #0x3c
	movmi r0, #0
	ldmmiia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_020DA09C:
	mov r0, #3
	bl NNS_SndLockCapture
	cmp r0, #0
	bne _020DA0C8
	cmp r6, #0
	blt _020DA0BC
	mov r0, r6
	bl NNS_SndFreeAlarm
_020DA0BC:
	add sp, sp, #0x3c
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_020DA0C8:
	mov r0, #0xa
	bl NNS_SndLockChannel
	cmp r0, #0
	bne _020DA0FC
	cmp r6, #0
	blt _020DA0E8
	mov r0, r6
	bl NNS_SndFreeAlarm
_020DA0E8:
	mov r0, #3
	bl NNS_SndUnlockCapture
	add sp, sp, #0x3c
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_020DA0FC:
	mov r0, #0
	mov r7, sl, lsr #2
	str r0, [sp]
	str r7, [sp, #4]
	str r8, [sp, #8]
	str r0, [sp, #0xc]
	cmp sb, #0
	movne r3, #1
	ldr r1, [sp, #0x78]
	str fp, [sp, #0x10]
	str r1, [sp, #0x14]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x1c]
	moveq r3, #2
	mov r0, #1
	bl SND_SetupChannelPcm
	ldr r1, [sp, #0x64]
	str sb, [sp]
	str r1, [sp, #4]
	ldr r0, [sp, #0x68]
	ldr r1, [sp, #0x24]
	str r0, [sp, #8]
	ldr r2, [sp, #0x1c]
	mov r0, #0
	mov r3, r7
	bl SND_SetupCapture
	mov r0, #0
	str r0, [sp]
	str r7, [sp, #4]
	str r8, [sp, #8]
	str r0, [sp, #0xc]
	cmp sb, #0
	movne r3, #1
	ldr r2, [sp, #0x7c]
	str fp, [sp, #0x10]
	str r2, [sp, #0x14]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x20]
	moveq r3, #2
	mov r0, #3
	bl SND_SetupChannelPcm
	ldr r2, [sp, #0x64]
	str sb, [sp]
	str r2, [sp, #4]
	ldr r0, [sp, #0x68]
	ldr r1, [sp, #0x24]
	str r0, [sp, #8]
	ldr r2, [sp, #0x20]
	mov r3, r7
	mov r0, #1
	bl SND_SetupCapture
	cmp r6, #0
	blt _020DA1EC
	ldr r2, [sp, #0x30]
	ldr r3, _020DA2DC // =NNSi_AlarmCallback
	mov r1, r2
	mov r0, r6
	add r1, r1, r5
	str r4, [sp]
	bl SND_SetupAlarm
_020DA1EC:
	ldr r0, [sp, #0x18]
	cmp r0, #1
	bne _020DA20C
	mov r0, #1
	mov r2, r0
	mov r3, r0
	mov r1, #2
	bl SND_SetOutputSelector
_020DA20C:
	cmp r6, #0
	movge r0, #1
	movge r2, r0, lsl r6
	ldr r0, [sp, #0x2c]
	movlt r2, #0
	mov r1, #3
	mov r3, #0
	bl SND_StartTimer
	mov r0, #1
	str r0, [r4]
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x80]
	str r0, [r4, #4]
	mov r0, #0xa
	str r0, [r4, #0x20]
	ldr r0, [sp, #0x2c]
	str r0, [r4, #0x24]
	mov r0, #3
	str r0, [r4, #0x28]
	ldr r0, [sp, #0x60]
	str r6, [r4, #0x2c]
	str r0, [r4, #8]
	ldr r0, [sp, #0x1c]
	str r0, [r4, #0xc]
	ldr r0, [sp, #0x20]
	str r0, [r4, #0x10]
	mov r0, sl
	str sl, [r4, #0x14]
	bl _u32_div_f
	str r0, [r4, #0x18]
	mov r1, #0
	str r1, [r4, #0x1c]
	ldr r0, [sp, #0x80]
	ldr r1, [sp, #0x84]
	str r0, [r4, #0x30]
	ldr r0, [sp, #0x88]
	str r1, [r4, #0x34]
	str r0, [r4, #0x38]
	add r0, r4, #0x3c
	str r8, [r4, #0x50]
	bl NNSi_SndFaderInit
	add r0, r4, #0x3c
	mov r1, r8, lsl #8
	mov r2, #1
	bl NNSi_SndFaderSet
	mov r0, #0
	str r0, [r4, #0x4c]
	mov r0, #1
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_020DA2D4: .word 0x0214CF7C
_020DA2D8: .word 0x00FFB0FF
_020DA2DC: .word NNSi_AlarmCallback
	arm_func_end NNSi_SndCaptureStart

	arm_func_start NNSi_SndCaptureMain
NNSi_SndCaptureMain: // 0x020DA2E0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r5, _020DA378 // =0x0214CF7C
	ldr r0, [r5]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [r5, #4]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	add r4, r5, #0x3c
	mov r0, r4
	bl NNSi_SndFaderUpdate
	ldr r0, [r5, #0x4c]
	cmp r0, #0
	beq _020DA340
	mov r0, r4
	bl NNSi_SndFaderIsFinished
	cmp r0, #0
	beq _020DA340
	bl NNSi_SndCaptureStop
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020DA340:
	mov r0, r4
	bl NNSi_SndFaderGet
	ldr r1, [r5, #0x50]
	mov r4, r0, asr #8
	cmp r4, r1
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [r5, #0x24]
	mov r1, r4
	mov r2, #0
	bl SND_SetChannelVolume
	str r4, [r5, #0x50]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020DA378: .word 0x0214CF7C
	arm_func_end NNSi_SndCaptureMain

	arm_func_start NNSi_SndCaptureInit
NNSi_SndCaptureInit: // 0x020DA37C
	ldr r1, _020DA394 // =0x0214CF54
	mov r2, #0
	ldr r0, _020DA398 // =0x0214CF7C
	str r2, [r1]
	str r2, [r0]
	bx lr
	.align 2, 0
_020DA394: .word 0x0214CF54
_020DA398: .word 0x0214CF7C
	arm_func_end NNSi_SndCaptureInit

	arm_func_start NNS_SndCaptureStopSampling
NNS_SndCaptureStopSampling: // 0x020DA39C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020DA3D4 // =0x0214CF7C
	ldr r1, [r0]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, [r0, #4]
	cmp r0, #2
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl NNSi_SndCaptureStop
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020DA3D4: .word 0x0214CF7C
	arm_func_end NNS_SndCaptureStopSampling

	arm_func_start NNS_SndCaptureStartSampling
NNS_SndCaptureStartSampling: // 0x020DA3D8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x2c
	mov r5, r0
	mov r4, r1
	mov r7, r2
	mov r6, r3
	bl NNS_SndCaptureStopSampling
	ldr r0, _020DA488 // =0x0214CF7C
	ldr r0, [r0]
	cmp r0, #0
	addne sp, sp, #0x2c
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r1, r5
	mov r2, r4
	mov r0, #0
	bl MIi_CpuClear32
	mov r0, r5
	mov r1, r4
	bl DC_FlushRange
	str r7, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r1, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	str r6, [sp, #0x10]
	mov r0, #0x7f
	str r0, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [sp, #0x40]
	str r0, [sp, #0x1c]
	ldr r0, [sp, #0x44]
	str r1, [sp, #0x20]
	ldr ip, [sp, #0x48]
	str r0, [sp, #0x24]
	mov r1, r5
	mov r3, r4, lsr #1
	add r2, r5, r4, lsr #1
	mov r0, #2
	str ip, [sp, #0x28]
	bl NNSi_SndCaptureStart
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020DA488: .word 0x0214CF7C
	arm_func_end NNS_SndCaptureStartSampling

	arm_func_start NNS_SndCaptureStopEffect
NNS_SndCaptureStopEffect: // 0x020DA48C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020DA4C4 // =0x0214CF7C
	ldr r1, [r0]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, [r0, #4]
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl NNSi_SndCaptureStop
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020DA4C4: .word 0x0214CF7C
	arm_func_end NNS_SndCaptureStopEffect

	arm_func_start NNS_SndCaptureStopReverb
NNS_SndCaptureStopReverb: // 0x020DA4C8
	stmdb sp!, {r4, lr}
	ldr r4, _020DA514 // =0x0214CF7C
	mov r2, r0
	ldr r0, [r4]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #4]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	cmp r2, #0
	bne _020DA4FC
	bl NNSi_SndCaptureStop
	ldmia sp!, {r4, pc}
_020DA4FC:
	add r0, r4, #0x3c
	mov r1, #0
	bl NNSi_SndFaderSet
	mov r0, #1
	str r0, [r4, #0x4c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020DA514: .word 0x0214CF7C
	arm_func_end NNS_SndCaptureStopReverb

	arm_func_start NNS_SymbolDisposeCallback
NNS_SymbolDisposeCallback: // 0x020DA518
	mov r0, #0
	str r0, [r2, #0x88]
	bx lr
	arm_func_end NNS_SymbolDisposeCallback

	arm_func_start NNS_FatDisposeCallback
NNS_FatDisposeCallback: // 0x020DA524
	mov r0, #0
	str r0, [r2, #0x84]
	bx lr
	arm_func_end NNS_FatDisposeCallback

	arm_func_start NNS_InfoDisposeCallback
NNS_InfoDisposeCallback: // 0x020DA530
	mov r0, #0
	str r0, [r2, #0x8c]
	bx lr
	arm_func_end NNS_InfoDisposeCallback

	arm_func_start NNS_SndArcSetFileAddress
NNS_SndArcSetFileAddress: // 0x020DA53C
	ldr r2, _020DA554 // =0x0214D070
	ldr r2, [r2]
	ldr r2, [r2, #0x84]
	add r0, r2, r0, lsl #4
	str r1, [r0, #0x14]
	bx lr
	.align 2, 0
_020DA554: .word 0x0214D070
	arm_func_end NNS_SndArcSetFileAddress

	arm_func_start NNS_SndArcGetFileAddress
NNS_SndArcGetFileAddress: // 0x020DA558
	ldr r1, _020DA57C // =0x0214D070
	ldr r1, [r1]
	ldr r2, [r1, #0x84]
	ldr r1, [r2, #8]
	cmp r0, r1
	movhs r0, #0
	addlo r0, r2, r0, lsl #4
	ldrlo r0, [r0, #0x14]
	bx lr
	.align 2, 0
_020DA57C: .word 0x0214D070
	arm_func_end NNS_SndArcGetFileAddress

	arm_func_start NNS_SndArcGetFileID
NNS_SndArcGetFileID: // 0x020DA580
	ldr r1, _020DA59C // =0x0214D070
	ldr r1, [r1]
	ldr r2, [r1, #0x7c]
	ldr r1, [r1, #0x80]
	str r2, [r0]
	str r1, [r0, #4]
	bx lr
	.align 2, 0
_020DA59C: .word 0x0214D070
	arm_func_end NNS_SndArcGetFileID

	arm_func_start NNS_SndArcReadFile
NNS_SndArcReadFile: // 0x020DA5A0
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, _020DA614 // =0x0214D070
	mov r5, r2
	ldr r4, [r4]
	mov r6, r1
	ldr r2, [r4, #0x84]
	ldr r1, [r2, #8]
	cmp r0, r1
	mvnhs r0, #0
	ldmhsia sp!, {r4, r5, r6, pc}
	add r1, r2, #0xc
	add r1, r1, r0, lsl #4
	ldr r0, [r1, #4]
	ldr r1, [r1]
	sub r0, r0, r3
	cmp r5, r0
	movhi r5, r0
	add r0, r4, #0x34
	add r1, r1, r3
	mov r2, #0
	bl FS_SeekFile
	cmp r0, #0
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r1, r6
	mov r2, r5
	add r0, r4, #0x34
	bl FS_ReadFile
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020DA614: .word 0x0214D070
	arm_func_end NNS_SndArcReadFile

	arm_func_start NNS_SndArcGetFileSize
NNS_SndArcGetFileSize: // 0x020DA618
	ldr r1, _020DA63C // =0x0214D070
	ldr r1, [r1]
	ldr r2, [r1, #0x84]
	ldr r1, [r2, #8]
	cmp r0, r1
	movhs r0, #0
	addlo r0, r2, r0, lsl #4
	ldrlo r0, [r0, #0x10]
	bx lr
	.align 2, 0
_020DA63C: .word 0x0214D070
	arm_func_end NNS_SndArcGetFileSize

	arm_func_start NNS_SndArcGetFileOffset
NNS_SndArcGetFileOffset: // 0x020DA640
	ldr r1, _020DA664 // =0x0214D070
	ldr r1, [r1]
	ldr r2, [r1, #0x84]
	ldr r1, [r2, #8]
	cmp r0, r1
	movhs r0, #0
	addlo r0, r2, r0, lsl #4
	ldrlo r0, [r0, #0xc]
	bx lr
	.align 2, 0
_020DA664: .word 0x0214D070
	arm_func_end NNS_SndArcGetFileOffset

	arm_func_start NNS_SndArcGetGroupInfo
NNS_SndArcGetGroupInfo: // 0x020DA668
	ldr r1, _020DA6C8 // =0x0214D070
	ldr r3, [r1]
	ldr r2, [r3, #0x8c]
	ldr r1, [r2, #0x1c]
	cmp r1, #0
	moveq r2, #0
	addne r2, r2, r1
	cmp r2, #0
	moveq r0, #0
	bxeq lr
	cmp r0, #0
	movlt r0, #0
	bxlt lr
	ldr r1, [r2]
	cmp r0, r1
	movhs r0, #0
	bxhs lr
	add r0, r2, r0, lsl #2
	ldr r1, [r0, #4]
	ldr r0, [r3, #0x8c]
	cmp r1, #0
	moveq r0, #0
	addne r0, r0, r1
	bx lr
	.align 2, 0
_020DA6C8: .word 0x0214D070
	arm_func_end NNS_SndArcGetGroupInfo

	arm_func_start NNS_SndArcGetStrmPlayerInfo
NNS_SndArcGetStrmPlayerInfo: // 0x020DA6CC
	ldr r1, _020DA72C // =0x0214D070
	ldr r3, [r1]
	ldr r2, [r3, #0x8c]
	ldr r1, [r2, #0x20]
	cmp r1, #0
	moveq r2, #0
	addne r2, r2, r1
	cmp r2, #0
	moveq r0, #0
	bxeq lr
	cmp r0, #0
	movlt r0, #0
	bxlt lr
	ldr r1, [r2]
	cmp r0, r1
	movhs r0, #0
	bxhs lr
	add r0, r2, r0, lsl #2
	ldr r1, [r0, #4]
	ldr r0, [r3, #0x8c]
	cmp r1, #0
	moveq r0, #0
	addne r0, r0, r1
	bx lr
	.align 2, 0
_020DA72C: .word 0x0214D070
	arm_func_end NNS_SndArcGetStrmPlayerInfo

	arm_func_start NNS_SndArcGetPlayerInfo
NNS_SndArcGetPlayerInfo: // 0x020DA730
	ldr r1, _020DA790 // =0x0214D070
	ldr r3, [r1]
	ldr r2, [r3, #0x8c]
	ldr r1, [r2, #0x18]
	cmp r1, #0
	moveq r2, #0
	addne r2, r2, r1
	cmp r2, #0
	moveq r0, #0
	bxeq lr
	cmp r0, #0
	movlt r0, #0
	bxlt lr
	ldr r1, [r2]
	cmp r0, r1
	movhs r0, #0
	bxhs lr
	add r0, r2, r0, lsl #2
	ldr r1, [r0, #4]
	ldr r0, [r3, #0x8c]
	cmp r1, #0
	moveq r0, #0
	addne r0, r0, r1
	bx lr
	.align 2, 0
_020DA790: .word 0x0214D070
	arm_func_end NNS_SndArcGetPlayerInfo

	arm_func_start NNS_SndArcGetStrmInfo
NNS_SndArcGetStrmInfo: // 0x020DA794
	ldr r1, _020DA7F4 // =0x0214D070
	ldr r3, [r1]
	ldr r2, [r3, #0x8c]
	ldr r1, [r2, #0x24]
	cmp r1, #0
	moveq r2, #0
	addne r2, r2, r1
	cmp r2, #0
	moveq r0, #0
	bxeq lr
	cmp r0, #0
	movlt r0, #0
	bxlt lr
	ldr r1, [r2]
	cmp r0, r1
	movhs r0, #0
	bxhs lr
	add r0, r2, r0, lsl #2
	ldr r1, [r0, #4]
	ldr r0, [r3, #0x8c]
	cmp r1, #0
	moveq r0, #0
	addne r0, r0, r1
	bx lr
	.align 2, 0
_020DA7F4: .word 0x0214D070
	arm_func_end NNS_SndArcGetStrmInfo

	arm_func_start NNS_SndArcGetWaveArcInfo
NNS_SndArcGetWaveArcInfo: // 0x020DA7F8
	ldr r1, _020DA858 // =0x0214D070
	ldr r3, [r1]
	ldr r2, [r3, #0x8c]
	ldr r1, [r2, #0x14]
	cmp r1, #0
	moveq r2, #0
	addne r2, r2, r1
	cmp r2, #0
	moveq r0, #0
	bxeq lr
	cmp r0, #0
	movlt r0, #0
	bxlt lr
	ldr r1, [r2]
	cmp r0, r1
	movhs r0, #0
	bxhs lr
	add r0, r2, r0, lsl #2
	ldr r1, [r0, #4]
	ldr r0, [r3, #0x8c]
	cmp r1, #0
	moveq r0, #0
	addne r0, r0, r1
	bx lr
	.align 2, 0
_020DA858: .word 0x0214D070
	arm_func_end NNS_SndArcGetWaveArcInfo

	arm_func_start NNS_SndArcGetBankInfo
NNS_SndArcGetBankInfo: // 0x020DA85C
	ldr r1, _020DA8BC // =0x0214D070
	ldr r3, [r1]
	ldr r2, [r3, #0x8c]
	ldr r1, [r2, #0x10]
	cmp r1, #0
	moveq r2, #0
	addne r2, r2, r1
	cmp r2, #0
	moveq r0, #0
	bxeq lr
	cmp r0, #0
	movlt r0, #0
	bxlt lr
	ldr r1, [r2]
	cmp r0, r1
	movhs r0, #0
	bxhs lr
	add r0, r2, r0, lsl #2
	ldr r1, [r0, #4]
	ldr r0, [r3, #0x8c]
	cmp r1, #0
	moveq r0, #0
	addne r0, r0, r1
	bx lr
	.align 2, 0
_020DA8BC: .word 0x0214D070
	arm_func_end NNS_SndArcGetBankInfo

	arm_func_start NNS_SndArcGetSeqArcInfo
NNS_SndArcGetSeqArcInfo: // 0x020DA8C0
	ldr r1, _020DA920 // =0x0214D070
	ldr r3, [r1]
	ldr r2, [r3, #0x8c]
	ldr r1, [r2, #0xc]
	cmp r1, #0
	moveq r2, #0
	addne r2, r2, r1
	cmp r2, #0
	moveq r0, #0
	bxeq lr
	cmp r0, #0
	movlt r0, #0
	bxlt lr
	ldr r1, [r2]
	cmp r0, r1
	movhs r0, #0
	bxhs lr
	add r0, r2, r0, lsl #2
	ldr r1, [r0, #4]
	ldr r0, [r3, #0x8c]
	cmp r1, #0
	moveq r0, #0
	addne r0, r0, r1
	bx lr
	.align 2, 0
_020DA920: .word 0x0214D070
	arm_func_end NNS_SndArcGetSeqArcInfo

	arm_func_start NNS_SndArcGetSeqInfo
NNS_SndArcGetSeqInfo: // 0x020DA924
	ldr r1, _020DA984 // =0x0214D070
	ldr r3, [r1]
	ldr r2, [r3, #0x8c]
	ldr r1, [r2, #8]
	cmp r1, #0
	moveq r2, #0
	addne r2, r2, r1
	cmp r2, #0
	moveq r0, #0
	bxeq lr
	cmp r0, #0
	movlt r0, #0
	bxlt lr
	ldr r1, [r2]
	cmp r0, r1
	movhs r0, #0
	bxhs lr
	add r0, r2, r0, lsl #2
	ldr r1, [r0, #4]
	ldr r0, [r3, #0x8c]
	cmp r1, #0
	moveq r0, #0
	addne r0, r0, r1
	bx lr
	.align 2, 0
_020DA984: .word 0x0214D070
	arm_func_end NNS_SndArcGetSeqInfo

	arm_func_start NNS_SndArcGetCurrent
NNS_SndArcGetCurrent: // 0x020DA988
	ldr r0, _020DA994 // =0x0214D070
	ldr r0, [r0]
	bx lr
	.align 2, 0
_020DA994: .word 0x0214D070
	arm_func_end NNS_SndArcGetCurrent

	arm_func_start NNS_SndArcSetCurrent
NNS_SndArcSetCurrent: // 0x020DA998
	ldr r1, _020DA9AC // =0x0214D070
	ldr r2, [r1]
	str r0, [r1]
	mov r0, r2
	bx lr
	.align 2, 0
_020DA9AC: .word 0x0214D070
	arm_func_end NNS_SndArcSetCurrent

	arm_func_start NNS_SndArcInitOnMemory
NNS_SndArcInitOnMemory: // 0x020DA9B0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	mov r0, r4
	mov r1, r5
	mov r2, #0x30
	bl MIi_CpuCopy32
	ldr r0, [r5, #0x18]
	mov ip, #0
	cmp r0, #0
	moveq r0, #0
	addne r0, r4, r0
	str r0, [r5, #0x8c]
	ldr r0, [r5, #0x20]
	cmp r0, #0
	moveq r0, #0
	addne r0, r4, r0
	str r0, [r5, #0x84]
	ldr r0, [r5, #0x10]
	cmp r0, #0
	moveq r0, #0
	addne r0, r4, r0
	str r0, [r5, #0x88]
	ldr r2, [r5, #0x84]
	ldr r0, [r2, #8]
	cmp r0, #0
	bls _020DAA5C
	mov r3, ip
	mov r1, ip
_020DAA28:
	add r2, r2, #0xc
	ldr r0, [r2, r3]
	add r2, r2, r3
	cmp r0, #0
	moveq r0, r1
	addne r0, r4, r0
	str r0, [r2, #8]
	ldr r2, [r5, #0x84]
	add ip, ip, #1
	ldr r0, [r2, #8]
	add r3, r3, #0x10
	cmp ip, r0
	blo _020DAA28
_020DAA5C:
	mov r1, #0
	ldr r0, _020DAA74 // =0x0214D070
	str r1, [r5, #0x30]
	str r5, [r0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020DAA74: .word 0x0214D070
	arm_func_end NNS_SndArcInitOnMemory

	arm_func_start NNS_SndArcSetup
NNS_SndArcSetup: // 0x020DAA78
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	mov r5, r1
	mov r1, #0
	mov r4, r2
	mov r2, r1
	add r0, r6, #0x34
	bl FS_SeekFile
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r1, r6
	add r0, r6, #0x34
	mov r2, #0x30
	bl FS_ReadFile
	cmp r0, #0x30
	addne sp, sp, #8
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	cmp r5, #0
	beq _020DAC4C
	mov r0, #0
	str r0, [sp]
	ldr r1, [r6, #0x1c]
	ldr r2, _020DAC58 // =NNS_InfoDisposeCallback
	mov r0, r5
	mov r3, r6
	bl NNS_SndHeapAlloc
	str r0, [r6, #0x8c]
	ldr r0, [r6, #0x8c]
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #0x18]
	add r0, r6, #0x34
	mov r2, #0
	bl FS_SeekFile
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #0x8c]
	ldr r2, [r6, #0x1c]
	add r0, r6, #0x34
	bl FS_ReadFile
	ldr r1, [r6, #0x1c]
	cmp r0, r1
	addne sp, sp, #8
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, #0
	str r0, [sp]
	ldr r1, [r6, #0x24]
	ldr r2, _020DAC5C // =NNS_FatDisposeCallback
	mov r0, r5
	mov r3, r6
	bl NNS_SndHeapAlloc
	str r0, [r6, #0x84]
	ldr r0, [r6, #0x84]
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #0x20]
	add r0, r6, #0x34
	mov r2, #0
	bl FS_SeekFile
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #0x84]
	ldr r2, [r6, #0x24]
	add r0, r6, #0x34
	bl FS_ReadFile
	ldr r1, [r6, #0x24]
	cmp r0, r1
	addne sp, sp, #8
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	cmp r4, #0
	beq _020DAC4C
	ldr r1, [r6, #0x14]
	cmp r1, #0
	beq _020DAC4C
	mov r4, #0
	ldr r2, _020DAC60 // =NNS_SymbolDisposeCallback
	mov r0, r5
	mov r3, r6
	str r4, [sp]
	bl NNS_SndHeapAlloc
	str r0, [r6, #0x88]
	ldr r0, [r6, #0x88]
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, r4
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #0x10]
	add r0, r6, #0x34
	mov r2, r4
	bl FS_SeekFile
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, r4
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #0x88]
	ldr r2, [r6, #0x14]
	add r0, r6, #0x34
	bl FS_ReadFile
	ldr r1, [r6, #0x14]
	cmp r0, r1
	addne sp, sp, #8
	movne r0, r4
	ldmneia sp!, {r4, r5, r6, pc}
_020DAC4C:
	mov r0, #1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020DAC58: .word NNS_InfoDisposeCallback
_020DAC5C: .word NNS_FatDisposeCallback
_020DAC60: .word NNS_SymbolDisposeCallback
	arm_func_end NNS_SndArcSetup

	arm_func_start NNS_SndArcInitWithResult
NNS_SndArcInitWithResult: // 0x020DAC64
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov ip, #0
	str ip, [r6, #0x8c]
	str ip, [r6, #0x84]
	add r0, r6, #0x7c
	mov r5, r2
	mov r4, r3
	str ip, [r6, #0x88]
	bl FS_ConvertPathToFileID
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	add r0, r6, #0x34
	bl FS_InitFile
	add r1, r6, #0x7c
	add r0, r6, #0x34
	ldmia r1, {r1, r2}
	bl FS_OpenFileFast
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r3, #1
	mov r0, r6
	mov r1, r5
	mov r2, r4
	str r3, [r6, #0x30]
	bl NNS_SndArcSetup
	cmp r0, #0
	ldrne r0, _020DACDC // =0x0214D070
	strne r6, [r0]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020DACDC: .word 0x0214D070
	arm_func_end NNS_SndArcInitWithResult

	arm_func_start _NNS_EraseSync
_NNS_EraseSync: // 0x020DACE0
	stmdb sp!, {r4, lr}
	bl SND_GetCurrentCommandTag
	mov r4, r0
	mov r0, #1
	bl SND_FlushCommand
	mov r0, r4
	bl SND_WaitForCommandProc
	ldmia sp!, {r4, pc}
	arm_func_end _NNS_EraseSync

	arm_func_start _NNS_NewSection
_NNS_NewSection: // 0x020DAD00
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, [r5]
	mov r1, #0x14
	mov r2, #4
	bl NNS_FndAllocFromFrmHeapEx
	movs r4, r0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	bl _NNS_InitHeapSection
	mov r1, r4
	add r0, r5, #4
	bl NNS_FndAppendListObject
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end _NNS_NewSection

	arm_func_start _NNS_InitHeap
_NNS_InitHeap: // 0x020DAD48
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	add r0, r5, #4
	mov r1, #0xc
	bl NNS_FndInitList
	mov r0, r5
	str r4, [r5]
	bl _NNS_NewSection
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end _NNS_InitHeap

	arm_func_start _NNS_InitHeapSection
_NNS_InitHeapSection: // 0x020DAD84
	ldr ip, _020DAD90 // =NNS_FndInitList
	mov r1, #0
	bx ip
	.align 2, 0
_020DAD90: .word NNS_FndInitList
	arm_func_end _NNS_InitHeapSection

	arm_func_start NNS_SndHeapAlloc
NNS_SndHeapAlloc: // 0x020DAD94
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r1
	mov r8, r0
	add r0, r7, #0x1f
	bic r1, r0, #0x1f
	mov r6, r2
	ldr r0, [r8]
	add r1, r1, #0x20
	mov r2, #0x20
	mov r5, r3
	bl NNS_FndAllocFromFrmHeapEx
	movs r4, r0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r0, r8, #4
	mov r1, #0
	bl NNS_FndGetPrevListObject
	str r7, [r4, #8]
	str r6, [r4, #0xc]
	ldr r2, [sp, #0x18]
	str r5, [r4, #0x10]
	mov r1, r4
	str r2, [r4, #0x14]
	bl NNS_FndAppendListObject
	add r0, r4, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end NNS_SndHeapAlloc

	arm_func_start NNS_SndHeapClear
NNS_SndHeapClear: // 0x020DADFC
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, lr}
	mov r8, r0
	mov r5, #0
	mov r1, r5
	add r0, r8, #4
	bl NNS_FndGetPrevListObject
	movs r7, r0
	beq _020DAE94
	add sb, r8, #4
	mov sl, #1
	mov r4, r5
_020DAE28:
	mov r0, r7
	mov r1, r4
	bl NNS_FndGetPrevListObject
	movs r6, r0
	beq _020DAE74
_020DAE3C:
	ldr ip, [r6, #0xc]
	cmp ip, #0
	beq _020DAE60
	ldr r1, [r6, #8]
	ldr r2, [r6, #0x10]
	ldr r3, [r6, #0x14]
	add r0, r6, #0x20
	blx ip
	mov r5, sl
_020DAE60:
	mov r0, r7
	mov r1, r6
	bl NNS_FndGetPrevListObject
	movs r6, r0
	bne _020DAE3C
_020DAE74:
	mov r0, sb
	mov r1, r7
	bl NNS_FndRemoveListObject
	mov r0, sb
	mov r1, r4
	bl NNS_FndGetPrevListObject
	movs r7, r0
	bne _020DAE28
_020DAE94:
	ldr r0, [r8]
	mov r1, #3
	bl NNS_FndFreeToFrmHeap
	cmp r5, #0
	beq _020DAEAC
	bl _NNS_EraseSync
_020DAEAC:
	mov r0, r8
	bl _NNS_NewSection
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	arm_func_end NNS_SndHeapClear

	arm_func_start NNS_SndHeapDestroy
NNS_SndHeapDestroy: // 0x020DAEB8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl NNS_SndHeapClear
	ldr r0, [r4]
	bl NNS_FndDestroyFrmHeap
	ldmia sp!, {r4, pc}
	arm_func_end NNS_SndHeapDestroy

	arm_func_start NNS_SndHeapCreate
NNS_SndHeapCreate: // 0x020DAED0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	add r2, r0, #3
	add r0, r0, r1
	bic r5, r2, #3
	cmp r5, r0
	addhi sp, sp, #4
	movhi r0, #0
	ldmhiia sp!, {r4, r5, pc}
	sub r1, r0, r5
	cmp r1, #0x10
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r4, r5, pc}
	add r0, r5, #0x10
	sub r1, r1, #0x10
	mov r2, #0
	bl NNS_FndCreateFrmHeapEx
	movs r4, r0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r5
	mov r1, r4
	bl _NNS_InitHeap
	cmp r0, #0
	addne sp, sp, #4
	movne r0, r5
	ldmneia sp!, {r4, r5, pc}
	mov r0, r4
	bl NNS_FndDestroyFrmHeap
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNS_SndHeapCreate

	arm_func_start _NNS_LoadSingleWaves
_NNS_LoadSingleWaves: // 0x020DAF58
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #0x20
	mov r8, r0
	add r0, sp, #8
	mov r7, r1
	mov r6, r2
	mov r5, r3
	ldr r4, [sp, #0x40]
	bl SND_GetFirstInstDataPos
	ldr r1, [sp, #8]
	ldr r0, [sp, #0xc]
	str r1, [sp]
	str r0, [sp, #4]
	cmp r7, #0
	add r2, sp, #0
	addeq sp, sp, #0x20
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	add r1, sp, #0x10
	mov r0, r7
	bl SND_GetNextInstData
	cmp r0, #0
	beq _020DB010
	add sl, sp, #0x10
	add sb, sp, #0
_020DAFBC:
	ldrb r0, [sp, #0x10]
	cmp r0, #1
	bne _020DAFF8
	ldrh r0, [sp, #0x14]
	cmp r6, r0
	bne _020DAFF8
	ldrh r1, [sp, #0x12]
	mov r0, r8
	mov r2, r5
	mov r3, r4
	bl _NNS_LoadSingleWave
	cmp r0, #0
	addeq sp, sp, #0x20
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
_020DAFF8:
	mov r0, r7
	mov r1, sl
	mov r2, sb
	bl SND_GetNextInstData
	cmp r0, #0
	bne _020DAFBC
_020DB010:
	mov r0, #1
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	arm_func_end _NNS_LoadSingleWaves

	arm_func_start _NNS_LoadSingleWave
_NNS_LoadSingleWave: // 0x020DB01C
	stmdb sp!, {r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl SND_GetWaveDataAddress
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, sb, pc}
	mov r0, r7
	bl SND_GetWaveDataCount
	ldr r1, [r7, #0x38]
	sub r0, r0, #1
	add r1, r1, r6
	add r1, r7, r1, lsl #2
	cmp r6, r0
	ldrlo r0, [r1, #0x40]
	ldr r8, [r1, #0x3c]
	ldrhs r0, [r7, #8]
	cmp r4, #0
	sub sb, r0, r8
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, pc}
	ldr r2, _020DB0F8 // =_NNS_SingleWaveDisposeCallback
	mov r0, r4
	mov r3, r7
	add r1, sb, #0x20
	str r6, [sp]
	bl NNS_SndHeapAlloc
	movs r4, r0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, pc}
	mov r0, r5
	mov r1, r4
	mov r2, sb
	mov r3, r8
	bl NNS_SndArcReadFile
	cmp sb, r0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, sb, pc}
	mov r0, r4
	mov r1, sb
	bl DC_StoreRange
	mov r0, r7
	mov r1, r6
	mov r2, r4
	bl SND_SetWaveDataAddress
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_020DB0F8: .word _NNS_SingleWaveDisposeCallback
	arm_func_end _NNS_LoadSingleWave

	arm_func_start _NNS_SingleWaveDisposeCallback
_NNS_SingleWaveDisposeCallback: // 0x020DB0FC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r2
	mov r7, r0
	mov r4, r3
	mov r6, r1
	mov r0, r5
	mov r1, r4
	bl SND_GetWaveDataAddress
	cmp r7, r0
	bne _020DB138
	mov r0, r5
	mov r1, r4
	mov r2, #0
	bl SND_SetWaveDataAddress
_020DB138:
	mov r0, r7
	add r1, r7, r6
	bl SND_InvalidateWaveData
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end _NNS_SingleWaveDisposeCallback

	arm_func_start _NNS_WaveArcTableDisposeCallback
_NNS_WaveArcTableDisposeCallback: // 0x020DB14C
	stmdb sp!, {r4, lr}
	mov r1, r2
	mov r4, r0
	mov r2, r3
	bl _NNS_DisposeCallback
	mov r0, r4
	bl SND_DestroyWaveArc
	ldmia sp!, {r4, pc}
	arm_func_end _NNS_WaveArcTableDisposeCallback

	arm_func_start _NNS_WaveArcDisposeCallback
_NNS_WaveArcDisposeCallback: // 0x020DB16C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r1, r2
	mov r5, r0
	mov r2, r3
	bl _NNS_DisposeCallback
	mov r0, r5
	add r1, r5, r4
	bl SND_InvalidateWaveData
	mov r0, r5
	bl SND_DestroyWaveArc
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end _NNS_WaveArcDisposeCallback

	arm_func_start _NNS_BankDisposeCallback
_NNS_BankDisposeCallback: // 0x020DB1A4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r1, r2
	mov r5, r0
	mov r2, r3
	bl _NNS_DisposeCallback
	mov r0, r5
	add r1, r5, r4
	bl SND_InvalidateBankData
	mov r0, r5
	bl SND_DestroyBank
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end _NNS_BankDisposeCallback

	arm_func_start _NNS_SeqDisposeCallback
_NNS_SeqDisposeCallback: // 0x020DB1DC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r1, r2
	mov r5, r0
	mov r2, r3
	bl _NNS_DisposeCallback
	mov r0, r5
	add r1, r5, r4
	bl SND_InvalidateSeqData
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end _NNS_SeqDisposeCallback

	arm_func_start _NNS_DisposeCallback
_NNS_DisposeCallback: // 0x020DB20C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r5, r1
	mov r7, r0
	mov r6, r2
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, r5
	bl NNS_SndArcSetCurrent
	mov r5, r0
	mov r0, r6
	bl NNS_SndArcGetFileAddress
	cmp r7, r0
	bne _020DB258
	mov r0, r6
	mov r1, #0
	bl NNS_SndArcSetFileAddress
_020DB258:
	mov r0, r5
	bl NNS_SndArcSetCurrent
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end _NNS_DisposeCallback

	arm_func_start _NNS_LoadWaveArcTable
_NNS_LoadWaveArcTable: // 0x020DB270
	stmdb sp!, {r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #4
	mov sb, r0
	mov r8, r1
	mov r7, r2
	bl NNS_SndArcGetFileAddress
	movs r6, r0
	bne _020DB37C
	ldr r1, _020DB388 // =0x0214D074
	mov r0, sb
	mov r2, #0x3c
	mov r3, #0
	bl NNS_SndArcReadFile
	cmp r0, #0x3c
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, sb, pc}
	ldr r0, _020DB388 // =0x0214D074
	cmp r8, #0
	ldr r0, [r0, #0x38]
	addeq sp, sp, #4
	mov r4, r0, lsl #2
	mov r0, r4, lsl #1
	add r5, r0, #0x3c
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, pc}
	cmp r7, #0
	moveq r3, #0
	beq _020DB2EC
	bl NNS_SndArcGetCurrent
	mov r3, r0
_020DB2EC:
	ldr r2, _020DB38C // =_NNS_WaveArcTableDisposeCallback
	mov r0, r8
	add r1, r5, #0x20
	str sb, [sp]
	bl NNS_SndHeapAlloc
	movs r6, r0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, pc}
	mov r0, sb
	mov r1, r6
	add r2, r4, #0x3c
	mov r3, #0
	bl NNS_SndArcReadFile
	add r1, r4, #0x3c
	cmp r0, r1
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, sb, pc}
	ldr r1, [r6, #0x38]
	add r0, r6, #0x3c
	mov r2, r4
	add r1, r0, r1, lsl #2
	bl MI_CpuCopy8
	mov r2, r4
	add r0, r6, #0x3c
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r6
	mov r1, r5
	bl DC_StoreRange
	cmp r7, #0
	beq _020DB37C
	mov r0, sb
	mov r1, r6
	bl NNS_SndArcSetFileAddress
_020DB37C:
	mov r0, r6
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_020DB388: .word 0x0214D074
_020DB38C: .word _NNS_WaveArcTableDisposeCallback
	arm_func_end _NNS_LoadWaveArcTable

	arm_func_start _NNS_LoadWaveArc
_NNS_LoadWaveArc: // 0x020DB390
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl NNS_SndArcGetFileAddress
	movs r4, r0
	bne _020DB3F8
	cmp r5, #0
	moveq r2, #0
	beq _020DB3C4
	bl NNS_SndArcGetCurrent
	mov r2, r0
_020DB3C4:
	ldr r1, _020DB404 // =_NNS_WaveArcDisposeCallback
	mov r0, r7
	mov r3, r7
	str r6, [sp]
	bl NNSi_SndArcLoadFile
	mov r4, r0
	cmp r5, #0
	beq _020DB3F8
	cmp r4, #0
	beq _020DB3F8
	mov r0, r7
	mov r1, r4
	bl NNS_SndArcSetFileAddress
_020DB3F8:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020DB404: .word _NNS_WaveArcDisposeCallback
	arm_func_end _NNS_LoadWaveArc

	arm_func_start _NNS_LoadBank
_NNS_LoadBank: // 0x020DB408
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl NNS_SndArcGetFileAddress
	movs r4, r0
	bne _020DB470
	cmp r5, #0
	moveq r2, #0
	beq _020DB43C
	bl NNS_SndArcGetCurrent
	mov r2, r0
_020DB43C:
	ldr r1, _020DB47C // =_NNS_BankDisposeCallback
	mov r0, r7
	mov r3, r7
	str r6, [sp]
	bl NNSi_SndArcLoadFile
	mov r4, r0
	cmp r5, #0
	beq _020DB470
	cmp r4, #0
	beq _020DB470
	mov r0, r7
	mov r1, r4
	bl NNS_SndArcSetFileAddress
_020DB470:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020DB47C: .word _NNS_BankDisposeCallback
	arm_func_end _NNS_LoadBank

	arm_func_start _NNS_LoadSeqArc
_NNS_LoadSeqArc: // 0x020DB480
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl NNS_SndArcGetFileAddress
	movs r4, r0
	bne _020DB4E8
	cmp r5, #0
	moveq r2, #0
	beq _020DB4B4
	bl NNS_SndArcGetCurrent
	mov r2, r0
_020DB4B4:
	ldr r1, _020DB4F4 // =_NNS_SeqDisposeCallback
	mov r0, r7
	mov r3, r7
	str r6, [sp]
	bl NNSi_SndArcLoadFile
	mov r4, r0
	cmp r5, #0
	beq _020DB4E8
	cmp r4, #0
	beq _020DB4E8
	mov r0, r7
	mov r1, r4
	bl NNS_SndArcSetFileAddress
_020DB4E8:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020DB4F4: .word _NNS_SeqDisposeCallback
	arm_func_end _NNS_LoadSeqArc

	arm_func_start _NNS_LoadSeq
_NNS_LoadSeq: // 0x020DB4F8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl NNS_SndArcGetFileAddress
	movs r4, r0
	bne _020DB560
	cmp r5, #0
	moveq r2, #0
	beq _020DB52C
	bl NNS_SndArcGetCurrent
	mov r2, r0
_020DB52C:
	ldr r1, _020DB56C // =_NNS_SeqDisposeCallback
	mov r0, r7
	mov r3, r7
	str r6, [sp]
	bl NNSi_SndArcLoadFile
	mov r4, r0
	cmp r5, #0
	beq _020DB560
	cmp r4, #0
	beq _020DB560
	mov r0, r7
	mov r1, r4
	bl NNS_SndArcSetFileAddress
_020DB560:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020DB56C: .word _NNS_SeqDisposeCallback
	arm_func_end _NNS_LoadSeq

	arm_func_start NNSi_SndArcLoadFile
NNSi_SndArcLoadFile: // 0x020DB570
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r4, r3
	bl NNS_SndArcGetFileSize
	movs r5, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [sp, #0x20]
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r2, r7
	mov r3, r6
	add r1, r5, #0x20
	str r4, [sp]
	bl NNS_SndHeapAlloc
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r8
	mov r1, r4
	mov r2, r5
	mov r3, #0
	bl NNS_SndArcReadFile
	cmp r5, r0
	addne sp, sp, #8
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r4
	mov r1, r5
	bl DC_StoreRange
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end NNSi_SndArcLoadFile

	arm_func_start NNSi_SndArcLoadWaveArc
NNSi_SndArcLoadWaveArc: // 0x020DB610
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl NNS_SndArcGetWaveArcInfo
	cmp r0, #0
	moveq r0, #5
	ldmeqia sp!, {r4, r5, r6, pc}
	ands r1, r6, #4
	beq _020DB688
	ldrb r1, [r0, #3]
	ands r1, r1, #1
	beq _020DB660
	ldr r0, [r0]
	mov r1, r5
	mov r0, r0, lsl #8
	mov r2, r4
	mov r0, r0, lsr #8
	bl _NNS_LoadWaveArcTable
	b _020DB678
_020DB660:
	ldr r0, [r0]
	mov r1, r5
	mov r0, r0, lsl #8
	mov r2, r4
	mov r0, r0, lsr #8
	bl _NNS_LoadWaveArc
_020DB678:
	cmp r0, #0
	bne _020DB698
	mov r0, #9
	ldmia sp!, {r4, r5, r6, pc}
_020DB688:
	ldr r0, [r0]
	mov r0, r0, lsl #8
	mov r0, r0, lsr #8
	bl NNS_SndArcGetFileAddress
_020DB698:
	ldr r1, [sp, #0x10]
	cmp r1, #0
	strne r0, [r1]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNSi_SndArcLoadWaveArc

	arm_func_start NNSi_SndArcLoadBank
NNSi_SndArcLoadBank: // 0x020DB6AC
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0xc
	mov sl, r1
	mov sb, r2
	mov fp, r3
	bl NNS_SndArcGetBankInfo
	movs r8, r0
	addeq sp, sp, #0xc
	moveq r0, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ands r0, sl, #2
	beq _020DB700
	ldr r0, [r8]
	mov r1, sb
	mov r2, fp
	bl _NNS_LoadBank
	movs r7, r0
	bne _020DB70C
	add sp, sp, #0xc
	mov r0, #8
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_020DB700:
	ldr r0, [r8]
	bl NNS_SndArcGetFileAddress
	mov r7, r0
_020DB70C:
	and r5, sl, #4
	mov r6, #0
_020DB714:
	add r0, r8, r6, lsl #1
	ldrh r0, [r0, #4]
	ldr r1, _020DB7F0 // =0x0000FFFF
	cmp r0, r1
	beq _020DB7CC
	bl NNS_SndArcGetWaveArcInfo
	movs r4, r0
	addeq sp, sp, #0xc
	moveq r0, #5
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	add r0, sp, #4
	str r0, [sp]
	add r0, r8, r6, lsl #1
	ldrh r0, [r0, #4]
	mov r1, sl
	mov r2, sb
	mov r3, fp
	bl NNSi_SndArcLoadWaveArc
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldrb r0, [r4, #3]
	ands r0, r0, #1
	beq _020DB7AC
	cmp r5, #0
	beq _020DB7AC
	str sb, [sp]
	ldr r1, [r4]
	ldr r0, [sp, #4]
	mov r3, r1, lsl #8
	mov r1, r7
	mov r2, r6
	mov r3, r3, lsr #8
	bl _NNS_LoadSingleWaves
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #9
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_020DB7AC:
	cmp r7, #0
	beq _020DB7CC
	ldr r2, [sp, #4]
	cmp r2, #0
	beq _020DB7CC
	mov r0, r7
	mov r1, r6
	bl SND_AssignWaveArc
_020DB7CC:
	add r6, r6, #1
	cmp r6, #4
	blt _020DB714
	ldr r0, [sp, #0x30]
	cmp r0, #0
	strne r7, [r0]
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_020DB7F0: .word 0x0000FFFF
	arm_func_end NNSi_SndArcLoadBank

	arm_func_start NNSi_SndArcLoadSeqArc
NNSi_SndArcLoadSeqArc: // 0x020DB7F4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl NNS_SndArcGetSeqArcInfo
	cmp r0, #0
	moveq r0, #3
	ldmeqia sp!, {r4, r5, r6, pc}
	ands r1, r6, #8
	beq _020DB83C
	ldr r0, [r0]
	mov r1, r5
	mov r2, r4
	bl _NNS_LoadSeqArc
	cmp r0, #0
	bne _020DB844
	mov r0, #7
	ldmia sp!, {r4, r5, r6, pc}
_020DB83C:
	ldr r0, [r0]
	bl NNS_SndArcGetFileAddress
_020DB844:
	ldr r1, [sp, #0x10]
	cmp r1, #0
	strne r0, [r1]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNSi_SndArcLoadSeqArc

	arm_func_start NNSi_SndArcLoadSeq
NNSi_SndArcLoadSeq: // 0x020DB858
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl NNS_SndArcGetSeqInfo
	movs r4, r0
	addeq sp, sp, #4
	moveq r0, #2
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, #0
	str r0, [sp]
	ldrh r0, [r4, #4]
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl NNSi_SndArcLoadBank
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ands r0, r7, #1
	beq _020DB8D4
	ldr r0, [r4]
	mov r1, r6
	mov r2, r5
	bl _NNS_LoadSeq
	cmp r0, #0
	bne _020DB8DC
	add sp, sp, #4
	mov r0, #6
	ldmia sp!, {r4, r5, r6, r7, pc}
_020DB8D4:
	ldr r0, [r4]
	bl NNS_SndArcGetFileAddress
_020DB8DC:
	ldr r1, [sp, #0x18]
	cmp r1, #0
	strne r0, [r1]
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end NNSi_SndArcLoadSeq

	arm_func_start NNSi_SndArcLoadGroup
NNSi_SndArcLoadGroup: // 0x020DB8F4
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0xc
	mov sb, r1
	bl NNS_SndArcGetGroupInfo
	movs r8, r0
	addeq sp, sp, #0xc
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r0, [r8]
	mov r7, #0
	cmp r0, #0
	bls _020DBA10
	add r6, r8, #4
	str r7, [sp, #4]
	mov fp, r7
	mov sl, r7
	mov r5, r7
	mov r4, #1
_020DB93C:
	ldrb r0, [r6]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _020DB9FC
_020DB94C: // jump table
	b _020DB95C // case 0
	b _020DB9AC // case 1
	b _020DB9D4 // case 2
	b _020DB984 // case 3
_020DB95C:
	str r5, [sp]
	ldrb r1, [r6, #1]
	ldr r0, [r6, #4]
	mov r2, sb
	mov r3, r4
	bl NNSi_SndArcLoadSeq
	cmp r0, #0
	beq _020DB9FC
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_020DB984:
	str sl, [sp]
	ldrb r1, [r6, #1]
	ldr r0, [r6, #4]
	mov r2, sb
	mov r3, r4
	bl NNSi_SndArcLoadSeqArc
	cmp r0, #0
	beq _020DB9FC
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_020DB9AC:
	str fp, [sp]
	ldrb r1, [r6, #1]
	ldr r0, [r6, #4]
	mov r2, sb
	mov r3, r4
	bl NNSi_SndArcLoadBank
	cmp r0, #0
	beq _020DB9FC
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_020DB9D4:
	ldr r0, [sp, #4]
	mov r2, sb
	str r0, [sp]
	ldrb r1, [r6, #1]
	ldr r0, [r6, #4]
	mov r3, r4
	bl NNSi_SndArcLoadWaveArc
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_020DB9FC:
	ldr r0, [r8]
	add r7, r7, #1
	cmp r7, r0
	add r6, r6, #8
	blo _020DB93C
_020DBA10:
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end NNSi_SndArcLoadGroup

	arm_func_start NNS_SndArcLoadSeqArc
NNS_SndArcLoadSeqArc: // 0x020DBA1C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r1
	mov ip, #0
	mov r1, #0xff
	mov r3, #1
	str ip, [sp]
	bl NNSi_SndArcLoadBank
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndArcLoadSeqArc

	arm_func_start NNS_SndArcLoadWaveArc
NNS_SndArcLoadWaveArc: // 0x020DBA50
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r1
	mov ip, #0
	mov r1, #0xff
	mov r3, #1
	str ip, [sp]
	bl NNSi_SndArcLoadSeqArc
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndArcLoadWaveArc

	arm_func_start NNS_SndArcLoadSeq
NNS_SndArcLoadSeq: // 0x020DBA84
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r1
	mov ip, #0
	mov r1, #0xff
	mov r3, #1
	str ip, [sp]
	bl NNSi_SndArcLoadSeq
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndArcLoadSeq

	arm_func_start NNS_SndArcLoadGroup
NNS_SndArcLoadGroup: // 0x020DBAB8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl NNSi_SndArcLoadGroup
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndArcLoadGroup

	arm_func_start _NNS_StartSeqArc
_NNS_StartSeqArc: // 0x020DBAD8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r7, r2
	mov r2, r3
	ldr r6, [sp, #0x20]
	mov r4, r0
	mov r8, r1
	bl NNSi_SndPlayerAllocSeqPlayer
	movs r5, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r8
	mov r1, r5
	bl NNSi_SndPlayerAllocHeap
	add ip, sp, #4
	mov r2, r0
	mov r0, r7
	mov r1, #6
	mov r3, #0
	str ip, [sp]
	bl NNSi_SndArcLoadBank
	cmp r0, #0
	beq _020DBB4C
	mov r0, r5
	bl NNSi_SndPlayerFreeSeqPlayer
	add sp, sp, #8
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020DBB4C:
	ldr ip, [sp, #0x24]
	ldr r2, [r6]
	ldr r1, [ip, #0x18]
	ldr r3, [sp, #4]
	mov r0, r5
	add r1, ip, r1
	bl NNSi_SndPlayerStartSeq
	ldrb r1, [r6, #6]
	mov r0, r4
	bl NNS_SndPlayerSetInitialVolume
	ldrb r1, [r6, #7]
	mov r0, r4
	bl NNS_SndPlayerSetChannelPriority
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	mov r0, r4
	bl NNS_SndPlayerSetSeqArcNo
	mov r0, #1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end _NNS_StartSeqArc

	arm_func_start _NNS_StartSeq
_NNS_StartSeq: // 0x020DBB9C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r8, r2
	mov r2, r3
	ldr r5, [sp, #0x28]
	mov r6, r0
	mov r7, r1
	bl NNSi_SndPlayerAllocSeqPlayer
	movs r4, r0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r7
	mov r1, r4
	bl NNSi_SndPlayerAllocHeap
	mov r7, r0
	add ip, sp, #8
	mov r0, r8
	mov r2, r7
	mov r1, #6
	mov r3, #0
	str ip, [sp]
	bl NNSi_SndArcLoadBank
	cmp r0, #0
	beq _020DBC14
	mov r0, r4
	bl NNSi_SndPlayerFreeSeqPlayer
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020DBC14:
	ldr r0, [sp, #0x2c]
	add ip, sp, #4
	mov r2, r7
	mov r1, #1
	mov r3, #0
	str ip, [sp]
	bl NNSi_SndArcLoadSeq
	cmp r0, #0
	beq _020DBC4C
	mov r0, r4
	bl NNSi_SndPlayerFreeSeqPlayer
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020DBC4C:
	ldr r2, [sp, #4]
	ldr r3, [sp, #8]
	ldr r1, [r2, #0x18]
	mov r0, r4
	add r1, r2, r1
	mov r2, #0
	bl NNSi_SndPlayerStartSeq
	ldrb r1, [r5, #6]
	mov r0, r6
	bl NNS_SndPlayerSetInitialVolume
	ldrb r1, [r5, #7]
	mov r0, r6
	bl NNS_SndPlayerSetChannelPriority
	ldr r1, [sp, #0x2c]
	mov r0, r6
	bl NNS_SndPlayerSetSeqNo
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end _NNS_StartSeq

	arm_func_start NNS_SndArcPlayerStartSeqArcEx
NNS_SndArcPlayerStartSeqArcEx: // 0x020DBC98
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r8, r0
	ldr r0, [sp, #0x28]
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl NNS_SndArcGetSeqArcInfo
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r0]
	bl NNS_SndArcGetFileAddress
	movs r4, r0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [sp, #0x2c]
	bl NNSi_SndSeqArcGetSeqInfo
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r5, #0
	ldrltb r5, [r0, #8]
	cmp r6, #0
	ldrlth r6, [r0, #4]
	cmp r7, #0
	ldrltb r7, [r0, #9]
	ldr ip, [sp, #0x2c]
	mov r2, r6
	str r0, [sp]
	ldr r0, [sp, #0x28]
	str r4, [sp, #4]
	str r0, [sp, #8]
	mov r0, r8
	mov r1, r7
	mov r3, r5
	str ip, [sp, #0xc]
	bl _NNS_StartSeqArc
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end NNS_SndArcPlayerStartSeqArcEx

	arm_func_start NNS_SndArcPlayerStartSeqArc
NNS_SndArcPlayerStartSeqArc: // 0x020DBD44
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r1
	mov r7, r0
	mov r0, r6
	mov r5, r2
	bl NNS_SndArcGetSeqArcInfo
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r0]
	bl NNS_SndArcGetFileAddress
	movs r4, r0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r1, r5
	bl NNSi_SndSeqArcGetSeqInfo
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	str r0, [sp]
	str r4, [sp, #4]
	str r6, [sp, #8]
	str r5, [sp, #0xc]
	ldrb r1, [r0, #9]
	ldrh r2, [r0, #4]
	ldrb r3, [r0, #8]
	mov r0, r7
	bl _NNS_StartSeqArc
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end NNS_SndArcPlayerStartSeqArc

	arm_func_start NNS_SndArcPlayerStartSeqEx
NNS_SndArcPlayerStartSeqEx: // 0x020DBDCC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	ldr r0, [sp, #0x20]
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl NNS_SndArcGetSeqInfo
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r4, #0
	ldrltb r4, [r0, #8]
	cmp r5, #0
	ldrlth r5, [r0, #4]
	cmp r6, #0
	ldrltb r6, [r0, #9]
	ldr ip, [sp, #0x20]
	mov r2, r5
	str r0, [sp]
	mov r0, r7
	mov r1, r6
	mov r3, r4
	str ip, [sp, #4]
	bl _NNS_StartSeq
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end NNS_SndArcPlayerStartSeqEx

	arm_func_start NNS_SndArcPlayerStartSeq
NNS_SndArcPlayerStartSeq: // 0x020DBE3C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r1
	mov r5, r0
	mov r0, r4
	bl NNS_SndArcGetSeqInfo
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	str r0, [sp]
	str r4, [sp, #4]
	ldrb r1, [r0, #9]
	ldrh r2, [r0, #4]
	ldrb r3, [r0, #8]
	mov r0, r5
	bl _NNS_StartSeq
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNS_SndArcPlayerStartSeq

	arm_func_start NNS_SndArcPlayerSetup
NNS_SndArcPlayerSetup: // 0x020DBE88
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r0
	bl NNS_SndArcGetCurrent
	mov r5, #0
	mov r7, r5
_020DBE9C:
	mov r0, r5
	bl NNS_SndArcGetPlayerInfo
	movs r4, r0
	beq _020DBF14
	ldrb r1, [r4]
	mov r0, r5
	bl NNS_SndPlayerSetPlayerVolume
	ldrh r1, [r4, #2]
	mov r0, r5
	bl NNS_SndPlayerSetPlayableSeqCount
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _020DBF14
	cmp r6, #0
	beq _020DBF14
	ldrb r0, [r4]
	mov r8, r7
	cmp r0, #0
	ble _020DBF14
_020DBEE8:
	ldr r2, [r4, #4]
	mov r0, r5
	mov r1, r6
	bl NNS_SndPlayerCreateHeap
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldrb r0, [r4]
	add r8, r8, #1
	cmp r8, r0
	blt _020DBEE8
_020DBF14:
	add r5, r5, #1
	cmp r5, #0x20
	blt _020DBE9C
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end NNS_SndArcPlayerSetup

	arm_func_start _NNS_StrmThread
_NNS_StrmThread: // 0x020DBF28
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r1, _020DBF84 // =0x000004C8
	add r5, r0, #0x4e0
	add r6, r0, r1
	add r7, r0, #0x4c0
_020DBF40:
	mov r0, r7
	bl OS_SleepThread
_020DBF48:
	mov r0, r6
	bl OS_LockMutex
	mov r0, r5
	bl _NNS_ReadCommandBuffer
	movs r4, r0
	bne _020DBF6C
	mov r0, r6
	bl OS_UnlockMutex
	b _020DBF40
_020DBF6C:
	bl _NNS_MakeWaveData
	mov r0, r4
	bl _NNS_FreeCommandBuffer
	mov r0, r6
	bl OS_UnlockMutex
	b _020DBF48
	.align 2, 0
_020DBF84: .word 0x000004C8
	arm_func_end _NNS_StrmThread

	arm_func_start _NNS_CancelMemoryStream
_NNS_CancelMemoryStream: // 0x020DBF88
	bx lr
	arm_func_end _NNS_CancelMemoryStream

	arm_func_start _NNS_ReadMemoryStream
_NNS_ReadMemoryStream: // 0x020DBF8C
	stmdb sp!, {r4, lr}
	ldr r0, [r0, #0xa4]
	mov r4, r2
	add r0, r0, r3
	bl MI_CpuCopy8
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end _NNS_ReadMemoryStream

	arm_func_start _NNS_CloseMemoryStream
_NNS_CloseMemoryStream: // 0x020DBFA8
	bx lr
	arm_func_end _NNS_CloseMemoryStream

	arm_func_start _NNS_OpenMemoryStream
_NNS_OpenMemoryStream: // 0x020DBFAC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	bl NNS_SndArcGetFileAddress
	str r0, [r4, #0xa4]
	ldr r0, [r4, #0xa4]
	add r1, r4, #0xa8
	mov r2, #0x40
	bl MI_CpuCopy8
	mov r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end _NNS_OpenMemoryStream

	arm_func_start _NNS_CancelFileStream
_NNS_CancelFileStream: // 0x020DBFD8
	ldr ip, _020DBFE4 // =FS_CancelFile
	add r0, r0, #0x5c
	bx ip
	.align 2, 0
_020DBFE4: .word FS_CancelFile
	arm_func_end _NNS_CancelFileStream

	arm_func_start _NNS_ReadFileStream
_NNS_ReadFileStream: // 0x020DBFE8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr ip, [r6, #0xa4]
	mov r5, r1
	mov r4, r2
	add r0, r6, #0x5c
	add r1, ip, r3
	mov r2, #0
	bl FS_SeekFile
	mov r1, r5
	mov r2, r4
	add r0, r6, #0x5c
	bl FS_ReadFile
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end _NNS_ReadFileStream

	arm_func_start _NNS_CloseFileStream
_NNS_CloseFileStream: // 0x020DC020
	ldr ip, _020DC02C // =FS_CloseFile
	add r0, r0, #0x5c
	bx ip
	.align 2, 0
_020DC02C: .word FS_CloseFile
	arm_func_end _NNS_CloseFileStream

	arm_func_start _NNS_OpenFileStream
_NNS_OpenFileStream: // 0x020DC030
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r4, r1
	mov r0, r4
	add r1, r5, #0xa8
	mov r2, #0x40
	mov r3, #0
	bl NNS_SndArcReadFile
	cmp r0, #0x40
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, pc}
	add r0, sp, #0
	bl NNS_SndArcGetFileID
	add r1, sp, #0
	add r0, r5, #0x5c
	ldmia r1, {r1, r2}
	bl FS_OpenFileFast
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r4
	bl NNS_SndArcGetFileOffset
	str r0, [r5, #0xa4]
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end _NNS_OpenFileStream

	arm_func_start _NNS_SetupStreamFunction
_NNS_SetupStreamFunction: // 0x020DC0A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	bl NNS_SndArcGetFileAddress
	cmp r0, #0
	bne _020DC0E0
	ldr r1, _020DC104 // =_NNS_OpenFileStream
	ldr r0, _020DC108 // =_NNS_CloseFileStream
	str r1, [r4, #0x160]
	str r0, [r4, #0x164]
	ldr r1, _020DC10C // =_NNS_ReadFileStream
	ldr r0, _020DC110 // =_NNS_CancelFileStream
	str r1, [r4, #0x168]
	str r0, [r4, #0x16c]
	ldmia sp!, {r4, pc}
_020DC0E0:
	ldr r1, _020DC114 // =_NNS_OpenMemoryStream
	ldr r0, _020DC118 // =_NNS_CloseMemoryStream
	str r1, [r4, #0x160]
	ldr r1, _020DC11C // =_NNS_ReadMemoryStream
	str r0, [r4, #0x164]
	ldr r0, _020DC120 // =_NNS_CancelMemoryStream
	str r1, [r4, #0x168]
	str r0, [r4, #0x16c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020DC104: .word _NNS_OpenFileStream
_020DC108: .word _NNS_CloseFileStream
_020DC10C: .word _NNS_ReadFileStream
_020DC110: .word _NNS_CancelFileStream
_020DC114: .word _NNS_OpenMemoryStream
_020DC118: .word _NNS_CloseMemoryStream
_020DC11C: .word _NNS_ReadMemoryStream
_020DC120: .word _NNS_CancelMemoryStream
	arm_func_end _NNS_SetupStreamFunction

	arm_func_start _NNS_MakeWaveData
_NNS_MakeWaveData: // 0x020DC124
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x7c
	str r0, [sp, #8]
	ldr r0, [r0, #8]
	str r0, [sp, #0xc]
	ldr r0, [r0, #0x110]
	mov r0, r0, lsl #0x1a
	movs r0, r0, asr #0x1f
	beq _020DC168
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0x114]
	cmp r0, #0
	ldrgt r0, [sp, #0xc]
	ldrgt r0, [r0, #0x114]
	subgt r1, r0, #1
	ldrgt r0, [sp, #0xc]
	strgt r1, [r0, #0x114]
_020DC168:
	ldr r0, [sp, #8]
	ldr r0, [r0, #0x2c]
	str r0, [sp, #0x18]
	mov r0, #0
	str r0, [sp, #0x14]
	ldr r0, [sp, #0x18]
	cmp r0, #0
	beq _020DC8EC
	ldr r0, [sp, #0x14]
	mov r1, #0x8000
	str r0, [sp, #0x60]
	str r0, [sp, #0x6c]
	str r0, [sp, #0x54]
	str r0, [sp, #0x70]
	str r0, [sp, #0x74]
	str r0, [sp, #0x40]
	mov r0, #1
	str r0, [sp, #0x48]
	ldr r0, [sp, #0x14]
	ldr r7, _020DC99C // =0x00007FFF
	rsb r8, r1, #0
	mov r6, #0x58
	str r0, [sp, #0x44]
	str r0, [sp, #0x50]
	str r0, [sp, #0x4c]
_020DC1CC:
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0x110]
	mov r0, r0, lsl #0x1a
	movs r0, r0, asr #0x1f
	beq _020DC230
	ldr r0, [sp, #8]
	mov r4, #0
	ldr r0, [r0, #0x10]
	cmp r0, #0
	ble _020DC8EC
	mov r5, r4
_020DC1F8:
	ldr r0, [sp, #8]
	ldr r2, [sp, #0x18]
	add r0, r0, r4, lsl #2
	ldr r3, [r0, #0x14]
	ldr r0, [sp, #0x14]
	mov r1, r5
	add r0, r3, r0
	bl MI_CpuFill8
	ldr r0, [sp, #8]
	add r4, r4, #1
	ldr r0, [r0, #0x10]
	cmp r4, r0
	blt _020DC1F8
	b _020DC8EC
_020DC230:
	ldr r0, [sp, #0xc]
	ldr r5, [r0, #0xdc]
	ldr r4, [r0, #0x15c]
	mov r1, r5
	mov r0, r4
	bl _u32_div_f
	ldr r1, [sp, #0xc]
	mul r2, r0, r5
	ldr r1, [r1, #0xd4]
	sub r2, r4, r2
	sub r1, r1, #1
	cmp r0, r1
	ldrlo r1, [sp, #0xc]
	str r2, [sp, #0x20]
	ldrlo r1, [r1, #0xd8]
	ldr r2, [sp, #0x18]
	strlo r1, [sp, #0x1c]
	movlo r1, r5
	ldrhs r1, [sp, #0xc]
	str r2, [sp, #0x28]
	ldr r2, [sp, #0xc]
	ldrhs r1, [r1, #0xe0]
	ldrb r2, [r2, #0xc0]
	strhs r1, [sp, #0x1c]
	ldrhs r1, [sp, #0xc]
	ldrhs r1, [r1, #0xe4]
	cmp r2, #0
	ldrne r2, [sp, #0x18]
	movne r2, r2, lsr #1
	strne r2, [sp, #0x28]
	ldr r2, [sp, #0xc]
	ldr r3, [r2, #0x110]
	mov r2, r3, lsl #0x1b
	movs r2, r2, asr #0x1f
	beq _020DC2DC
	ldr r2, [sp, #0x20]
	cmp r2, #0
	ldreq r2, [sp, #0xc]
	biceq r3, r3, #0x10
	streq r3, [r2, #0x110]
	strne r2, [sp, #0x28]
	ldrne r2, [sp, #0x40]
	strne r2, [sp, #0x20]
_020DC2DC:
	ldr r2, [sp, #0x44]
	ldr r3, [sp, #0x20]
	str r2, [sp, #0x10]
	ldr r2, [sp, #0x28]
	add r2, r3, r2
	cmp r2, r1
	blo _020DC340
	mov r2, r3
	sub r1, r1, r2
	str r1, [sp, #0x28]
	ldr r1, [sp, #0xc]
	ldr r1, [r1, #0xd4]
	sub r1, r1, #1
	cmp r0, r1
	blo _020DC340
	ldr r1, [sp, #0xc]
	ldrb r1, [r1, #0xc1]
	cmp r1, #0
	ldrne r1, [sp, #0x48]
	strne r1, [sp, #0x10]
	ldreq r1, [sp, #0xc]
	ldreq r1, [r1, #0x110]
	orreq r2, r1, #0x20
	ldreq r1, [sp, #0xc]
	streq r2, [r1, #0x110]
_020DC340:
	ldr r2, [sp, #0x28]
	ldr r1, [sp, #0x20]
	str r2, [sp, #0x2c]
	ldr r2, [sp, #0xc]
	ldrb r2, [r2, #0xc0]
	cmp r2, #0
	beq _020DC370
	cmp r2, #1
	beq _020DC37C
	cmp r2, #2
	beq _020DC394
	b _020DC3D4
_020DC370:
	ldr r2, [sp, #0x28]
	str r2, [sp, #0x30]
	b _020DC3D4
_020DC37C:
	ldr r2, [sp, #0x28]
	mov r1, r1, lsl #1
	mov r2, r2, lsl #1
	str r2, [sp, #0x2c]
	str r2, [sp, #0x30]
	b _020DC3D4
_020DC394:
	ldr r3, [sp, #0x20]
	ldr r2, [sp, #0x28]
	cmp r1, #0
	add r2, r3, r2
	add r2, r2, #1
	mov r3, r2, lsr #1
	ldr r2, [sp, #0x20]
	mov r1, r1, lsr #1
	sub r2, r3, r2, lsr #1
	str r2, [sp, #0x30]
	addeq r2, r2, #4
	streq r2, [sp, #0x30]
	ldr r2, [sp, #0x2c]
	addne r1, r1, #4
	mov r2, r2, lsl #1
	str r2, [sp, #0x2c]
_020DC3D4:
	ldr r2, [sp, #0xc]
	ldr r3, [r2, #0xd8]
	ldrb r4, [r2, #0xc2]
	mul r3, r0, r3
	mla r0, r4, r3, r1
	ldr r2, [r2, #0xd0]
	add r0, r0, r2
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x4c]
	str r0, [sp, #0x3c]
	ldr r0, [sp, #8]
	ldr r0, [r0, #0x10]
	cmp r0, #0
	ble _020DC844
	ldr r0, [sp, #0xc]
	ldr r1, [sp, #0x20]
	add r4, r0, #0xf8
	ldr r0, [sp, #0x28]
	add r0, r1, r0
	str r0, [sp, #0x34]
	mov r0, r1
	and r0, r0, #1
	str r0, [sp, #0x38]
_020DC430:
	ldr r1, [sp, #8]
	ldr r0, [sp, #0x3c]
	add r0, r1, r0, lsl #2
	ldr r1, [r0, #0x14]
	ldr r0, [sp, #0xc]
	ldrb r2, [r0, #0xc2]
	ldr r0, [sp, #0x14]
	add r1, r1, r0
	ldr r0, [sp, #0x3c]
	mov r5, r1
	cmp r0, r2
	bge _020DC7E0
	ldr r0, [sp, #0xc]
	ldrb r0, [r0, #0xc0]
	cmp r0, #2
	bne _020DC480
	ldr r0, _020DC9A0 // =0x0214D0C8
	bl OS_LockMutex
	ldr r0, _020DC9A4 // =0x0214D0B8
	ldr r1, [r0]
_020DC480:
	ldr sl, [sp, #0x3c]
	ldr sb, [sp, #0x1c]
	ldr r3, [sp, #0x24]
	ldr r0, [sp, #0xc]
	mla r3, sl, sb, r3
	mov sb, r0
	ldr r2, [sp, #0x30]
	ldr sb, [sb, #0x168]
	blx sb
	ldr r1, [sp, #0x30]
	cmp r0, r1
	beq _020DC4EC
	ldr r0, [sp, #0x50]
	str r0, [sp, #0x2c]
	str r0, [sp, #0x28]
	str r0, [sp, #0x10]
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0x110]
	orr r1, r0, #0x20
	ldr r0, [sp, #0xc]
	str r1, [r0, #0x110]
	ldrb r0, [r0, #0xc0]
	cmp r0, #2
	bne _020DC844
	ldr r0, _020DC9A0 // =0x0214D0C8
	bl OS_UnlockMutex
	b _020DC844
_020DC4EC:
	ldr r0, [sp, #0xc]
	ldrb r0, [r0, #0xc0]
	cmp r0, #2
	bne _020DC820
	ldr r0, [sp, #0x20]
	cmp r0, #0
	ldr r0, _020DC9A4 // =0x0214D0B8
	ldr r0, [r0]
	mov r1, r0
	addeq r1, r0, #4
	ldreqh r2, [r0]
	ldreqh r0, [r0, #2]
	streqh r2, [r4]
	streqh r0, [r4, #2]
	ldr r0, [sp, #0x38]
	cmp r0, #0
	ldr r0, [sp, #0x20]
	beq _020DC5D4
	ldrb r2, [r1]
	ldrb r3, [r4, #2]
	ldrsh sb, [r4]
	mov r2, r2, asr #4
	and fp, r2, #0xf
	ands r2, fp, #4
	ldr r2, _020DC9A8 // =_0211289C
	mov sl, r3, lsl #1
	ldrsh sl, [r2, sl]
	mov r2, sl, asr #3
	addne r2, r2, sl
	ands ip, fp, #2
	addne r2, r2, sl, asr #1
	ands ip, fp, #1
	addne r2, r2, sl, asr #2
	ands sl, fp, #8
	beq _020DC590
	sub sb, sb, r2
	mov r2, #0x8000
	rsb r2, r2, #0
	cmp sb, r2
	movlt sb, r8
	b _020DC59C
_020DC590:
	add sb, sb, r2
	cmp sb, r7
	movgt sb, r7
_020DC59C:
	ldr r2, _020DC9AC // =_0211288C
	ldrsb r2, [r2, fp]
	adds r3, r3, r2
	ldrmi r3, [sp, #0x54]
	bmi _020DC5B8
	cmp r3, #0x58
	movgt r3, r6
_020DC5B8:
	mov r2, sb, lsl #0x10
	mov r2, r2, asr #0x10
	strh r2, [r4]
	strb r3, [r4, #2]
	strh r2, [r5], #2
	add r0, r0, #1
	add r1, r1, #1
_020DC5D4:
	ldr r2, [sp, #0x34]
	bic fp, r2, #1
	cmp r0, fp
	bhs _020DC734
_020DC5E4:
	ldrb r2, [r1]
	ldrb r3, [r4, #2]
	ldrsh sb, [r4]
	and lr, r2, #0xf
	ands r2, lr, #4
	ldr r2, _020DC9A8 // =_0211289C
	mov sl, r3, lsl #1
	ldrsh ip, [r2, sl]
	mov r2, ip, asr #3
	addne r2, r2, ip
	ands sl, lr, #2
	str sl, [sp, #0x58]
	addne r2, r2, ip, asr #1
	ands sl, lr, #1
	str sl, [sp, #0x5c]
	addne r2, r2, ip, asr #2
	ands sl, lr, #8
	beq _020DC644
	sub sb, sb, r2
	mov r2, #0x8000
	rsb r2, r2, #0
	cmp sb, r2
	movlt sb, r8
	b _020DC650
_020DC644:
	add sb, sb, r2
	cmp sb, r7
	movgt sb, r7
_020DC650:
	ldr r2, _020DC9AC // =_0211288C
	ldrsb r2, [r2, lr]
	adds r3, r3, r2
	ldrmi r3, [sp, #0x60]
	bmi _020DC66C
	cmp r3, #0x58
	movgt r3, r6
_020DC66C:
	mov r2, sb, lsl #0x10
	mov r2, r2, asr #0x10
	strh r2, [r4]
	strb r3, [r4, #2]
	strh r2, [r5]
	ldrb r2, [r1]
	ldrb r3, [r4, #2]
	ldrsh ip, [r4]
	mov r2, r2, asr #4
	and sb, r2, #0xf
	ands r2, sb, #4
	ldr r2, _020DC9A8 // =_0211289C
	mov sl, r3, lsl #1
	ldrsh lr, [r2, sl]
	mov r2, lr, asr #3
	addne r2, r2, lr
	ands sl, sb, #2
	str sl, [sp, #0x64]
	addne r2, r2, lr, asr #1
	ands sl, sb, #1
	str sl, [sp, #0x68]
	addne r2, r2, lr, asr #2
	ands sl, sb, #8
	beq _020DC6E4
	sub ip, ip, r2
	mov r2, #0x8000
	rsb r2, r2, #0
	cmp ip, r2
	movlt ip, r8
	b _020DC6F0
_020DC6E4:
	add ip, ip, r2
	cmp ip, r7
	movgt ip, r7
_020DC6F0:
	ldr r2, _020DC9AC // =_0211288C
	ldrsb r2, [r2, sb]
	adds r3, r3, r2
	ldrmi r3, [sp, #0x6c]
	bmi _020DC70C
	cmp r3, #0x58
	movgt r3, r6
_020DC70C:
	mov r2, ip, lsl #0x10
	mov sb, r2, asr #0x10
	strh sb, [r4]
	strb r3, [r4, #2]
	add r0, r0, #2
	strh sb, [r5, #2]
	add r5, r5, #4
	cmp r0, fp
	add r1, r1, #1
	blo _020DC5E4
_020DC734:
	ldr r2, [sp, #0x34]
	cmp r0, r2
	bhs _020DC7D4
	ldrb r2, [r1]
	ldrb r0, [r4, #2]
	ldrsh r1, [r4]
	and r2, r2, #0xf
	ands r3, r2, #4
	ldr r3, _020DC9A8 // =_0211289C
	mov sb, r0, lsl #1
	ldrsh sl, [r3, sb]
	mov sb, sl, asr #3
	addne sb, sb, sl
	ands r3, r2, #2
	addne sb, sb, sl, asr #1
	ands r3, r2, #1
	addne sb, sb, sl, asr #2
	ands r3, r2, #8
	beq _020DC798
	mov r3, #0x8000
	sub r1, r1, sb
	rsb r3, r3, #0
	cmp r1, r3
	movlt r1, r8
	b _020DC7A4
_020DC798:
	add r1, r1, sb
	cmp r1, r7
	movgt r1, r7
_020DC7A4:
	ldr r3, _020DC9AC // =_0211288C
	ldrsb r2, [r3, r2]
	adds r0, r0, r2
	ldrmi r0, [sp, #0x70]
	bmi _020DC7C0
	cmp r0, #0x58
	movgt r0, r6
_020DC7C0:
	mov r1, r1, lsl #0x10
	mov r1, r1, asr #0x10
	strh r1, [r4]
	strb r0, [r4, #2]
	strh r1, [r5]
_020DC7D4:
	ldr r0, _020DC9A0 // =0x0214D0C8
	bl OS_UnlockMutex
	b _020DC820
_020DC7E0:
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0x110]
	mov r0, r0, lsl #0x19
	movs r0, r0, asr #0x1f
	beq _020DC808
	mov r0, r1
	ldr r1, [sp, #0x74]
	ldr r2, [sp, #0x2c]
	bl MI_CpuFill8
	b _020DC820
_020DC808:
	ldr r0, [sp, #8]
	ldr r2, [sp, #0x2c]
	ldr r3, [r0, #0x14]
	ldr r0, [sp, #0x14]
	add r0, r3, r0
	bl MI_CpuCopy8
_020DC820:
	ldr r0, [sp, #0x3c]
	add r4, r4, #4
	add r0, r0, #1
	str r0, [sp, #0x3c]
	ldr r0, [sp, #8]
	ldr r1, [r0, #0x10]
	ldr r0, [sp, #0x3c]
	cmp r0, r1
	blt _020DC430
_020DC844:
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0x110]
	mov r1, r0, lsl #0x1b
	movs r1, r1, asr #0x1f
	bicne r1, r0, #0x10
	ldrne r0, [sp, #0xc]
	strne r1, [r0, #0x110]
	bne _020DC8E0
	ldr r0, [sp, #0x10]
	cmp r0, #0
	ldrne r0, [sp, #0xc]
	ldrne r1, [r0, #0xc8]
	strne r1, [r0, #0x15c]
	bne _020DC894
	ldr r0, [sp, #0xc]
	ldr r1, [r0, #0x15c]
	ldr r0, [sp, #0x28]
	add r1, r1, r0
	ldr r0, [sp, #0xc]
	str r1, [r0, #0x15c]
_020DC894:
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x2c]
	add r0, r1, r0
	str r0, [sp, #0x14]
	ldr r1, [sp, #0x18]
	ldr r0, [sp, #0x2c]
	sub r0, r1, r0
	str r0, [sp, #0x18]
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0x110]
	mov r0, r0, lsl #0x1a
	movs r0, r0, asr #0x1f
	beq _020DC8E0
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0x13c]
	cmp r0, #0
	beq _020DC8E0
	ldr r0, [sp, #0xc]
	bl _NNS_OnDataEnd
_020DC8E0:
	ldr r0, [sp, #0x18]
	cmp r0, #0
	bne _020DC1CC
_020DC8EC:
	ldr r0, [sp, #0xc]
	ldr r4, [r0, #0x134]
	cmp r4, #0
	beq _020DC93C
	ldrb r0, [r0, #0xc0]
	ldr r3, [sp, #8]
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	str r0, [sp]
	ldr r0, [sp, #0xc]
	ldr r1, [r0, #0x138]
	ldr r0, [sp, #8]
	str r1, [sp, #4]
	ldr r1, [sp, #8]
	add r2, r0, #0x14
	ldr r0, [r0, #0xc]
	ldr r1, [r1, #0x10]
	ldr r3, [r3, #0x2c]
	blx r4
_020DC93C:
	ldr r0, [sp, #8]
	mov r4, #0
	ldr r0, [r0, #0x10]
	cmp r0, #0
	ble _020DC97C
_020DC950:
	ldr r0, [sp, #8]
	ldr r1, [sp, #8]
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #0x14]
	ldr r1, [r1, #0x2c]
	bl DC_FlushRange
	ldr r0, [sp, #8]
	add r4, r4, #1
	ldr r0, [r0, #0x10]
	cmp r4, r0
	blt _020DC950
_020DC97C:
	ldr r0, [sp, #8]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	ldreq r0, [sp, #0xc]
	moveq r1, #1
	streq r1, [r0, #0x118]
	add sp, sp, #0x7c
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_020DC99C: .word 0x00007FFF
_020DC9A0: .word 0x0214D0C8
_020DC9A4: .word 0x0214D0B8
_020DC9A8: .word 0x0211289C
_020DC9AC: .word 0x0211288C
	arm_func_end _NNS_MakeWaveData

	arm_func_start _NNS_OnDataEnd
_NNS_OnDataEnd: // 0x020DC9B0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r5, r0
	ldr r1, [r5, #0x148]
	mov r0, #0
	str r1, [sp]
	ldr r2, [r5, #0x144]
	add r1, sp, #0
	str r2, [sp, #4]
	ldr r3, [r5, #0x144]
	add r2, sp, #8
	str r3, [sp, #8]
	str r0, [sp, #0xc]
	ldr r3, [r5, #0x140]
	ldr r4, [r5, #0x13c]
	blx r4
	cmp r0, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [sp, #8]
	bl NNS_SndArcGetStrmInfo
	movs r6, r0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r1, [r5, #0x164]
	mov r0, r5
	ldrb r4, [r5, #0xc0]
	ldrh r7, [r5, #0xc4]
	blx r1
	ldr r1, [r6]
	mov r0, r5
	bl _NNS_SetupStreamFunction
	ldr r1, [r6]
	ldr r2, [r5, #0x160]
	mov r0, r5
	blx r2
	cmp r0, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldrh r0, [r5, #0xc4]
	cmp r7, r0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, r6, r7, pc}
	cmp r4, #0
	bne _020DCA74
	ldrb r0, [r5, #0xc0]
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, r6, r7, pc}
_020DCA74:
	cmp r4, #0
	beq _020DCA8C
	ldrb r0, [r5, #0xc0]
	cmp r0, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_020DCA8C:
	ldr r1, [sp, #8]
	ldr r0, _020DCAF4 // =0x10624DD3
	str r1, [r5, #0x144]
	ldrh r2, [r5, #0xc4]
	ldr r1, [sp, #0xc]
	mul r1, r2, r1
	umull r0, r2, r1, r0
	mov r2, r2, lsr #6
	str r2, [r5, #0x15c]
	ldr r0, [r5, #0x15c]
	cmp r0, #0
	beq _020DCAD4
	ldrb r0, [r5, #0xc0]
	cmp r0, #2
	ldreq r0, [r5, #0x110]
	orreq r0, r0, #0x10
	streq r0, [r5, #0x110]
	beq _020DCAE0
_020DCAD4:
	ldr r0, [r5, #0x110]
	bic r0, r0, #0x10
	str r0, [r5, #0x110]
_020DCAE0:
	ldr r0, [r5, #0x110]
	bic r0, r0, #0x20
	str r0, [r5, #0x110]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020DCAF4: .word 0x10624DD3
	arm_func_end _NNS_OnDataEnd

	arm_func_start _NNS_StrmCallback
_NNS_StrmCallback: // 0x020DCAF8
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #4
	ldr r7, [sp, #0x2c]
	mov sl, r0
	ldr r0, [r7, #0x11c]
	mov sb, r1
	mov r8, r2
	mov fp, r3
	cmp r0, #2
	blt _020DCBB0
	ldr r0, _020DCC2C // =0x0214D940
	mov r1, #0
	bl NNS_FndGetNextListObject
	movs r6, r0
	beq _020DCB58
	ldr r4, _020DCC2C // =0x0214D940
_020DCB38:
	ldr r0, [r6, #8]
	cmp r0, r7
	beq _020DCB58
	mov r0, r4
	mov r1, r6
	bl NNS_FndGetNextListObject
	movs r6, r0
	bne _020DCB38
_020DCB58:
	ldr r0, [r6, #0x10]
	mov r5, #0
	cmp r0, #0
	ble _020DCB90
	mov r4, r5
_020DCB6C:
	add r0, r6, r5, lsl #2
	ldr r0, [r0, #0x14]
	ldr r2, [r6, #0x2c]
	mov r1, r4
	bl MI_CpuFill8
	ldr r0, [r6, #0x10]
	add r5, r5, #1
	cmp r5, r0
	blt _020DCB6C
_020DCB90:
	ldr r0, _020DCC2C // =0x0214D940
	mov r1, r6
	bl NNS_FndRemoveListObject
	ldr r1, [r7, #0x11c]
	mov r0, r6
	sub r1, r1, #1
	str r1, [r7, #0x11c]
	bl _NNS_FreeCommandBuffer
_020DCBB0:
	bl _NNS_AllocCommandBuffer
	mov r1, r0
	str r7, [r1, #8]
	str sl, [r1, #0xc]
	str sb, [r1, #0x10]
	cmp sb, #0
	mov r3, #0
	ble _020DCBE8
_020DCBD0:
	ldr r2, [r8, r3, lsl #2]
	add r0, r1, r3, lsl #2
	add r3, r3, #1
	str r2, [r0, #0x14]
	cmp r3, sb
	blt _020DCBD0
_020DCBE8:
	str fp, [r1, #0x2c]
	cmp sl, #0
	ldr r4, _020DCC30 // =0x0214D460
	bne _020DCC08
	ldr r0, _020DCC34 // =0x0214D0B4
	ldr r0, [r0]
	cmp r0, #0
	movne r4, r0
_020DCC08:
	ldr r2, [r7, #0x11c]
	add r0, r4, #0x4e0
	add r2, r2, #1
	str r2, [r7, #0x11c]
	bl NNS_FndAppendListObject
	add r0, r4, #0x4c0
	bl OS_WakeupThread
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_020DCC2C: .word 0x0214D940
_020DCC30: .word 0x0214D460
_020DCC34: .word 0x0214D0B4
	arm_func_end _NNS_StrmCallback

	arm_func_start _NNS_DisposeCallback_2
_NNS_DisposeCallback_2: // 0x020DCC38
	stmdb sp!, {r4, lr}
	mov r4, r2
	ldr r1, [r4, #0x12c]
	cmp r0, r1
	ldmneia sp!, {r4, pc}
	ldr r0, _020DCCCC // =0x0214D928
	bl OS_LockMutex
	ldr r0, _020DCCD0 // =0x0214D0B4
	ldr r1, [r0]
	cmp r1, #0
	beq _020DCC70
	ldr r0, _020DCCD4 // =0x000004C8
	add r0, r1, r0
	bl OS_LockMutex
_020DCC70:
	mov r0, r4
	bl _NNS_ForceStopStrm
	mov r0, #0
	str r0, [r4, #0x12c]
	str r0, [r4, #0x130]
	strb r0, [r4, #0x124]
	ldr r0, [r4, #0x120]
	cmp r0, #0
	ble _020DCCA4
	mov r0, r4
	bl NNS_SndStrmFreeChannel
	mov r0, #0
	str r0, [r4, #0x120]
_020DCCA4:
	ldr r0, _020DCCCC // =0x0214D928
	bl OS_UnlockMutex
	ldr r0, _020DCCD0 // =0x0214D0B4
	ldr r1, [r0]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _020DCCD4 // =0x000004C8
	add r0, r1, r0
	bl OS_UnlockMutex
	ldmia sp!, {r4, pc}
	.align 2, 0
_020DCCCC: .word 0x0214D928
_020DCCD0: .word 0x0214D0B4
_020DCCD4: .word 0x000004C8
	arm_func_end _NNS_DisposeCallback_2

	arm_func_start _NNS_FreeCommandBuffer
_NNS_FreeCommandBuffer: // 0x020DCCD8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r0, _020DCD08 // =0x0214D0BC
	mov r1, r5
	bl NNS_FndAppendListObject
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020DCD08: .word 0x0214D0BC
	arm_func_end _NNS_FreeCommandBuffer

	arm_func_start _NNS_AllocCommandBuffer
_NNS_AllocCommandBuffer: // 0x020DCD0C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	mov r5, r0
	ldr r0, _020DCD50 // =0x0214D0BC
	mov r1, #0
	bl NNS_FndGetNextListObject
	movs r4, r0
	beq _020DCD3C
	ldr r0, _020DCD50 // =0x0214D0BC
	mov r1, r4
	bl NNS_FndRemoveListObject
_020DCD3C:
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020DCD50: .word 0x0214D0BC
	arm_func_end _NNS_AllocCommandBuffer

	arm_func_start _NNS_ReadCommandBuffer
_NNS_ReadCommandBuffer: // 0x020DCD54
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl OS_DisableInterrupts
	mov r5, r0
	mov r0, r6
	mov r1, #0
	bl NNS_FndGetNextListObject
	movs r4, r0
	beq _020DCD94
	mov r0, r6
	mov r1, r4
	bl NNS_FndRemoveListObject
	ldr r1, [r4, #8]
	ldr r0, [r1, #0x11c]
	sub r0, r0, #1
	str r0, [r1, #0x11c]
_020DCD94:
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end _NNS_ReadCommandBuffer

	arm_func_start _NNS_RemoveCommandByPlayer
_NNS_RemoveCommandByPlayer: // 0x020DCDA4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	bl OS_DisableInterrupts
	mov r6, r0
	mov r0, r8
	mov r1, #0
	bl NNS_FndGetNextListObject
	movs r5, r0
	beq _020DCE08
_020DCDCC:
	mov r0, r8
	mov r1, r5
	bl NNS_FndGetNextListObject
	ldr r1, [r5, #8]
	mov r4, r0
	cmp r1, r7
	bne _020DCDFC
	mov r0, r8
	mov r1, r5
	bl NNS_FndRemoveListObject
	mov r0, r5
	bl _NNS_FreeCommandBuffer
_020DCDFC:
	mov r5, r4
	cmp r4, #0
	bne _020DCDCC
_020DCE08:
	mov r0, r6
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end _NNS_RemoveCommandByPlayer

	arm_func_start _NNS_CreateThread
_NNS_CreateThread: // 0x020DCE14
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r2, #0x400
	str r2, [sp]
	mov r4, r0
	str r1, [sp, #4]
	ldr r1, _020DCE74 // =_NNS_StrmThread
	mov r2, r4
	add r3, r4, #0x4c0
	bl OS_CreateThread
	add r0, r4, #0x4e0
	mov r1, #0
	bl NNS_FndInitList
	ldr r0, _020DCE78 // =0x000004C8
	add r0, r4, r0
	bl OS_InitMutex
	mov r0, #0
	str r0, [r4, #0x4c4]
	ldr r1, [r4, #0x4c4]
	mov r0, r4
	str r1, [r4, #0x4c0]
	bl OS_WakeupThreadDirect
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_020DCE74: .word _NNS_StrmThread
_020DCE78: .word 0x000004C8
	arm_func_end _NNS_CreateThread

	arm_func_start _NNS_FreeChannel
_NNS_FreeChannel: // 0x020DCE7C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, [r0, #0x120]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	sub r1, r1, #1
	str r1, [r0, #0x120]
	ldr r1, [r0, #0x120]
	cmp r1, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl NNS_SndStrmFreeChannel
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end _NNS_FreeChannel

	arm_func_start _NNS_AllocChannel
_NNS_AllocChannel: // 0x020DCEB8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r3, [r4, #0x120]
	cmp r3, #0
	bne _020DCEDC
	bl NNS_SndStrmAllocChannel
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
_020DCEDC:
	ldr r1, [r4, #0x120]
	mov r0, #1
	add r1, r1, #1
	str r1, [r4, #0x120]
	ldmia sp!, {r4, pc}
	arm_func_end _NNS_AllocChannel

	arm_func_start _NNS_ShutdownPlayer
_NNS_ShutdownPlayer: // 0x020DCEF0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x110]
	mov r1, r1, lsl #0x1f
	movs r1, r1, asr #0x1f
	ldmeqia sp!, {r4, pc}
	bl _NNS_FreeChannel
	ldr r1, [r4, #0x164]
	mov r0, r4
	blx r1
	ldr r0, _020DCF4C // =0x0214D940
	mov r1, r4
	bl _NNS_RemoveCommandByPlayer
	ldr r0, _020DCF50 // =0x0214D0B4
	ldr r0, [r0]
	cmp r0, #0
	beq _020DCF40
	mov r1, r4
	add r0, r0, #0x4e0
	bl _NNS_RemoveCommandByPlayer
_020DCF40:
	mov r0, r4
	bl _NNS_FreePlayer
	ldmia sp!, {r4, pc}
	.align 2, 0
_020DCF4C: .word 0x0214D940
_020DCF50: .word 0x0214D0B4
	arm_func_end _NNS_ShutdownPlayer

	arm_func_start _NNS_ForceStopStrm
_NNS_ForceStopStrm: // 0x020DCF54
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _020DCFE4 // =0x0214D928
	bl OS_LockMutex
	ldr r0, _020DCFE8 // =0x0214D0B4
	ldr r1, [r0]
	cmp r1, #0
	beq _020DCF80
	ldr r0, _020DCFEC // =0x000004C8
	add r0, r1, r0
	bl OS_LockMutex
_020DCF80:
	ldr r0, [r4, #0x110]
	mov r0, r0, lsl #0x1e
	movs r0, r0, asr #0x1f
	beq _020DCF98
	mov r0, r4
	bl NNS_SndStrmStop
_020DCF98:
	ldr r0, [r4, #0x110]
	mov r0, r0, lsl #0x1f
	movs r0, r0, asr #0x1f
	beq _020DCFB4
	ldr r1, [r4, #0x16c]
	mov r0, r4
	blx r1
_020DCFB4:
	mov r0, r4
	bl _NNS_ShutdownPlayer
	ldr r0, _020DCFE4 // =0x0214D928
	bl OS_UnlockMutex
	ldr r0, _020DCFE8 // =0x0214D0B4
	ldr r1, [r0]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _020DCFEC // =0x000004C8
	add r0, r1, r0
	bl OS_UnlockMutex
	ldmia sp!, {r4, pc}
	.align 2, 0
_020DCFE4: .word 0x0214D928
_020DCFE8: .word 0x0214D0B4
_020DCFEC: .word 0x000004C8
	arm_func_end _NNS_ForceStopStrm

	arm_func_start _NNS_StopStrm
_NNS_StopStrm: // 0x020DCFF0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r3, [r4, #0x110]
	mov r2, r1
	mov r1, r3, lsl #0x1e
	movs r1, r1, asr #0x1f
	bne _020DD014
	bl _NNS_ForceStopStrm
	ldmia sp!, {r4, pc}
_020DD014:
	cmp r2, #0
	bne _020DD024
	bl _NNS_ForceStopStrm
	ldmia sp!, {r4, pc}
_020DD024:
	add r0, r4, #0xe8
	mov r1, #0
	bl NNSi_SndFaderSet
	ldr r1, [r4, #0x110]
	mov r0, #0
	orr r1, r1, #8
	str r1, [r4, #0x110]
	str r0, [r4, #0x150]
	ldmia sp!, {r4, pc}
	arm_func_end _NNS_StopStrm

	arm_func_start _NNS_PrepareStrm
_NNS_PrepareStrm: // 0x020DD048
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r4, r1
	mov r1, r2
	mov r2, r3
	bl _NNS_AllocPlayer
	movs r6, r0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r4]
	bl _NNS_SetupStreamFunction
	ldr r1, [r4]
	ldr r2, [r6, #0x160]
	mov r0, r6
	blx r2
	cmp r0, #0
	bne _020DD0A4
	mov r0, r6
	bl _NNS_FreePlayer
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020DD0A4:
	ldrh r2, [r6, #0xc4]
	ldr r1, [sp, #0x24]
	ldr r0, _020DD2C8 // =0x10624DD3
	mul r1, r2, r1
	umull r0, r2, r1, r0
	mov r2, r2, lsr #6
	str r2, [r6, #0x15c]
	ldr r0, [r6, #0x15c]
	cmp r0, #0
	beq _020DD0E4
	ldrb r0, [r6, #0xc0]
	cmp r0, #2
	ldreq r0, [r6, #0x110]
	orreq r0, r0, #0x10
	streq r0, [r6, #0x110]
	beq _020DD0F0
_020DD0E4:
	ldr r0, [r6, #0x110]
	bic r0, r0, #0x10
	str r0, [r6, #0x110]
_020DD0F0:
	mov r0, #4
	str r0, [r6, #0x114]
	ldr r0, [r6, #0x110]
	mov ip, #0
	bic r0, r0, #0x20
	str r0, [r6, #0x110]
	ldr r0, [r6, #0x110]
	ldr r2, [sp, #0x28]
	bic r0, r0, #2
	str r0, [r6, #0x110]
	str ip, [r6, #0x118]
	ldr r0, [r6, #0x110]
	ldr r1, [sp, #0x2c]
	bic r0, r0, #4
	str r0, [r6, #0x110]
	ldr r3, [r6, #0x110]
	ldr r0, [sp, #0x30]
	bic r3, r3, #8
	str r3, [r6, #0x110]
	str ip, [r6, #0x11c]
	str r2, [r6, #0x134]
	str r1, [r6, #0x138]
	ldr r1, [sp, #0x34]
	str r0, [r6, #0x13c]
	ldr r0, [sp, #0x20]
	str r1, [r6, #0x140]
	str r0, [r6, #0x144]
	str ip, [r6, #0x158]
	ldrb r1, [r4, #4]
	add r0, r6, #0xe8
	str r1, [r6, #0x154]
	bl NNSi_SndFaderInit
	add r0, r6, #0xe8
	mov r1, #0x7f00
	mov r2, #1
	bl NNSi_SndFaderSet
	ldrb r0, [r6, #0xc0]
	cmp r0, #0
	beq _020DD1A0
	cmp r0, #1
	beq _020DD1A8
	cmp r0, #2
	beq _020DD1A8
	b _020DD1AC
_020DD1A0:
	mov r5, #0
	b _020DD1AC
_020DD1A8:
	mov r5, #1
_020DD1AC:
	ldrb r0, [r4, #7]
	ldr r2, _020DD2CC // =0x00000126
	ldrb r4, [r6, #0xc2]
	ands r0, r0, #1
	ldrb r0, [r6, #0x124]
	movne r4, #2
	add r2, r6, r2
	cmp r4, r0
	movgt r4, r0
	cmp r4, #1
	moveq r3, #1
	ldr r0, [r6, #0x110]
	movne r3, #0
	bic r1, r0, #0x40
	and r0, r3, #1
	orr r3, r1, r0, lsl #6
	mov r0, r6
	mov r1, r4
	str r3, [r6, #0x110]
	bl _NNS_AllocChannel
	cmp r0, #0
	bne _020DD224
	ldr r1, [r6, #0x164]
	mov r0, r6
	blx r1
	mov r0, r6
	bl _NNS_FreePlayer
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020DD224:
	ldr r2, [r6, #0x130]
	ldrb r1, [r6, #0x124]
	mul r0, r2, r4
	bl _u32_div_f
	ldrh r3, [r6, #0xc6]
	mov r2, #4
	ldr r1, _020DD2D0 // =_NNS_StrmCallback
	str r3, [sp]
	str r2, [sp, #4]
	str r1, [sp, #8]
	str r6, [sp, #0xc]
	mov r3, r0
	ldr r2, [r6, #0x12c]
	mov r0, r6
	mov r1, r5
	bl NNS_SndStrmSetup
	cmp r0, #0
	bne _020DD294
	mov r0, r6
	bl _NNS_FreeChannel
	ldr r1, [r6, #0x164]
	mov r0, r6
	blx r1
	mov r0, r6
	bl _NNS_FreePlayer
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020DD294:
	cmp r4, #2
	bne _020DD2BC
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl NNS_SndStrmSetChannelPan
	mov r0, r6
	mov r1, #1
	mov r2, #0x7f
	bl NNS_SndStrmSetChannelPan
_020DD2BC:
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020DD2C8: .word 0x10624DD3
_020DD2CC: .word 0x00000126
_020DD2D0: .word _NNS_StrmCallback
	arm_func_end _NNS_PrepareStrm

	arm_func_start _NNS_FreePlayer
_NNS_FreePlayer: // 0x020DD2D4
	ldr r2, [r0, #0x14c]
	cmp r2, #0
	movne r1, #0
	strne r1, [r2]
	strne r1, [r0, #0x14c]
	ldr r1, [r0, #0x110]
	bic r1, r1, #1
	str r1, [r0, #0x110]
	ldr r1, [r0, #0x110]
	bic r1, r1, #4
	str r1, [r0, #0x110]
	ldr r1, [r0, #0x110]
	bic r1, r1, #2
	str r1, [r0, #0x110]
	bx lr
	arm_func_end _NNS_FreePlayer

	arm_func_start _NNS_AllocPlayer
_NNS_AllocPlayer: // 0x020DD310
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	ldr r3, [r6]
	mov r7, r1
	mov r5, r2
	cmp r3, #0
	beq _020DD334
	bl NNS_SndStrmHandleRelease
_020DD334:
	ldr r1, _020DD3A8 // =0x0214D94C
	mov r0, #0x170
	mla r4, r7, r0, r1
	ldr r0, [r4, #0x12c]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r4, #0x110]
	mov r0, r0, lsl #0x1f
	movs r0, r0, asr #0x1f
	beq _020DD380
	ldr r0, [r4, #0x150]
	cmp r5, r0
	addlt sp, sp, #4
	movlt r0, #0
	ldmltia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl _NNS_ForceStopStrm
_020DD380:
	str r5, [r4, #0x150]
	ldr r1, [r4, #0x110]
	mov r0, r4
	bic r1, r1, #1
	orr r1, r1, #1
	str r1, [r4, #0x110]
	str r6, [r4, #0x14c]
	str r4, [r6]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020DD3A8: .word 0x0214D94C
	arm_func_end _NNS_AllocPlayer

	arm_func_start NNSi_SndArcStrmMain
NNSi_SndArcStrmMain: // 0x020DD3AC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r5, _020DD4B8 // =0x0214D94C
	mov r7, #0
	ldr r4, _020DD4BC // =_02116BC8
_020DD3C0:
	ldr r1, [r5, #0x110]
	mov r0, r1, lsl #0x1f
	movs r0, r0, asr #0x1f
	beq _020DD4A0
	ldr r0, [r5, #0x114]
	cmp r0, #0
	bne _020DD3E8
	mov r0, r5
	bl _NNS_ForceStopStrm
	b _020DD4A0
_020DD3E8:
	mov r0, r1, lsl #0x1d
	movs r0, r0, asr #0x1f
	beq _020DD420
	ldr r0, [r5, #0x118]
	cmp r0, #0
	beq _020DD420
	mov r0, r5
	bl NNS_SndStrmStart
	ldr r0, [r5, #0x110]
	orr r0, r0, #2
	str r0, [r5, #0x110]
	ldr r0, [r5, #0x110]
	bic r0, r0, #4
	str r0, [r5, #0x110]
_020DD420:
	ldr r0, [r5, #0x110]
	mov r0, r0, lsl #0x1e
	movs r0, r0, asr #0x1f
	beq _020DD4A0
	add r0, r5, #0xe8
	bl NNSi_SndFaderUpdate
	ldr r1, [r5, #0x154]
	add r0, r5, #0xe8
	mov r1, r1, lsl #1
	ldrsh r6, [r4, r1]
	bl NNSi_SndFaderGet
	mov r0, r0, asr #8
	mov r0, r0, lsl #1
	ldrsh r1, [r4, r0]
	ldr r0, [r5, #0x158]
	add r6, r1, r6
	cmp r6, r0
	beq _020DD478
	mov r0, r5
	mov r1, r6
	bl NNS_SndStrmSetVolume
	str r6, [r5, #0x158]
_020DD478:
	ldr r0, [r5, #0x110]
	mov r0, r0, lsl #0x1c
	movs r0, r0, asr #0x1f
	beq _020DD4A0
	add r0, r5, #0xe8
	bl NNSi_SndFaderIsFinished
	cmp r0, #0
	beq _020DD4A0
	mov r0, r5
	bl _NNS_ForceStopStrm
_020DD4A0:
	add r7, r7, #1
	cmp r7, #4
	add r5, r5, #0x170
	blt _020DD3C0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020DD4B8: .word 0x0214D94C
_020DD4BC: .word _02116BC8
	arm_func_end NNSi_SndArcStrmMain

	arm_func_start NNS_SndStrmHandleRelease
NNS_SndStrmHandleRelease: // 0x020DD4C0
	ldr r2, [r0]
	cmp r2, #0
	movne r1, #0
	strne r1, [r2, #0x14c]
	strne r1, [r0]
	bx lr
	arm_func_end NNS_SndStrmHandleRelease

	arm_func_start NNS_SndStrmHandleInit
NNS_SndStrmHandleInit: // 0x020DD4D8
	mov r1, #0
	str r1, [r0]
	bx lr
	arm_func_end NNS_SndStrmHandleInit

	arm_func_start NNS_SndArcStrmStopAll
NNS_SndArcStrmStopAll: // 0x020DD4E4
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, _020DD524 // =0x0214D94C
	mov r6, r0
	mov r5, #0
_020DD4F4:
	ldr r0, [r4, #0x110]
	mov r0, r0, lsl #0x1f
	movs r0, r0, asr #0x1f
	beq _020DD510
	mov r0, r4
	mov r1, r6
	bl _NNS_StopStrm
_020DD510:
	add r5, r5, #1
	cmp r5, #4
	add r4, r4, #0x170
	blt _020DD4F4
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020DD524: .word 0x0214D94C
	arm_func_end NNS_SndArcStrmStopAll

	arm_func_start NNS_SndArcStrmStop
NNS_SndArcStrmStop: // 0x020DD528
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl _NNS_StopStrm
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_SndArcStrmStop

	arm_func_start NNS_SndArcStrmStart
NNS_SndArcStrmStart: // 0x020DD54C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl NNS_SndArcStrmPrepare
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl NNS_SndArcStrmStartPrepared
	mov r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end NNS_SndArcStrmStart

	arm_func_start NNS_SndArcStrmStartPrepared
NNS_SndArcStrmStartPrepared: // 0x020DD574
	ldr r1, [r0]
	cmp r1, #0
	ldrne r0, [r1, #0x110]
	orrne r0, r0, #4
	strne r0, [r1, #0x110]
	bx lr
	arm_func_end NNS_SndArcStrmStartPrepared

	arm_func_start NNS_SndArcStrmPrepare
NNS_SndArcStrmPrepare: // 0x020DD58C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x18
	mov r5, r1
	mov r6, r0
	mov r0, r5
	mov r4, r2
	bl NNS_SndArcGetStrmInfo
	movs r1, r0
	addeq sp, sp, #0x18
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	str r5, [sp]
	str r4, [sp, #4]
	mov r0, #0
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	ldrb r2, [r1, #6]
	ldrb r3, [r1, #5]
	mov r0, r6
	bl _NNS_PrepareStrm
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNS_SndArcStrmPrepare

	arm_func_start NNS_SndArcStrmSetupPlayer
NNS_SndArcStrmSetupPlayer: // 0x020DD5EC
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #4
	ldr r7, _020DD6B8 // =0x0214D94C
	mov sl, r0
	mov sb, #0
	ldr fp, _020DD6BC // =_NNS_DisposeCallback_2
	mov r6, sb
	mov r5, sb
_020DD60C:
	mov r0, sb
	bl NNS_SndArcGetStrmPlayerInfo
	cmp r0, #0
	beq _020DD69C
	ldrb r2, [r0]
	mov r1, r6
	strb r2, [r7, #0x124]
	ldrb r2, [r0]
	cmp r2, #0
	ble _020DD654
_020DD634:
	add r2, r0, r1
	ldrb r3, [r2, #1]
	add r2, r7, r1
	add r1, r1, #1
	strb r3, [r2, #0x126]
	ldrb r2, [r0]
	cmp r1, r2
	blt _020DD634
_020DD654:
	cmp sl, #0
	beq _020DD69C
	ldrb r1, [r7, #0x124]
	mov r0, sl
	mov r2, fp
	mov r8, r1, lsl #0xb
	mov r1, r8
	mov r3, r7
	str r5, [sp]
	bl NNS_SndHeapAlloc
	movs r4, r0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, r7
	bl _NNS_ForceStopStrm
	str r4, [r7, #0x12c]
	str r8, [r7, #0x130]
_020DD69C:
	add sb, sb, #1
	cmp sb, #4
	add r7, r7, #0x170
	blt _020DD60C
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_020DD6B8: .word 0x0214D94C
_020DD6BC: .word _NNS_DisposeCallback_2
	arm_func_end NNS_SndArcStrmSetupPlayer

	arm_func_start NNS_SndArcStrmInit
NNS_SndArcStrmInit: // 0x020DD6C0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r2, _020DD79C // =0x0214D0B0
	mov r6, r0
	ldr r0, [r2]
	mov r5, r1
	cmp r0, #0
	beq _020DD6E8
	mov r0, r5
	bl NNS_SndArcStrmSetupPlayer
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020DD6E8:
	ldr r0, _020DD7A0 // =0x0214D0BC
	mov r3, #1
	mov r1, #0
	str r3, [r2]
	bl NNS_FndInitList
	ldr r7, _020DD7A4 // =0x0214D0E0
	mov r8, #0
	ldr r4, _020DD7A0 // =0x0214D0BC
_020DD708:
	mov r0, r4
	mov r1, r7
	bl NNS_FndAppendListObject
	add r8, r8, #1
	cmp r8, #8
	add r7, r7, #0x30
	blt _020DD708
	ldr r0, _020DD7A8 // =0x0214D0C8
	bl OS_InitMutex
	ldr r1, _020DD7AC // =0x0214D260
	ldr r0, _020DD7B0 // =0x0214D0B8
	ldr r4, _020DD7B4 // =0x0214D94C
	str r1, [r0]
	mov r8, #0
	mov r7, r8
_020DD744:
	ldr r1, [r4, #0x110]
	add r0, r4, #0x5c
	bic r1, r1, #1
	str r1, [r4, #0x110]
	bl FS_InitFile
	mov r0, r4
	bl NNS_SndStrmInit
	str r8, [r4, #0x148]
	strb r7, [r4, #0x124]
	str r7, [r4, #0x12c]
	str r7, [r4, #0x130]
	add r8, r8, #1
	str r7, [r4, #0x120]
	cmp r8, #4
	add r4, r4, #0x170
	blt _020DD744
	mov r0, r5
	bl NNS_SndArcStrmSetupPlayer
	ldr r0, _020DD7B8 // =0x0214D460
	mov r1, r6
	bl _NNS_CreateThread
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020DD79C: .word 0x0214D0B0
_020DD7A0: .word 0x0214D0BC
_020DD7A4: .word 0x0214D0E0
_020DD7A8: .word 0x0214D0C8
_020DD7AC: .word 0x0214D260
_020DD7B0: .word 0x0214D0B8
_020DD7B4: .word 0x0214D94C
_020DD7B8: .word 0x0214D460
	arm_func_end NNS_SndArcStrmInit

	arm_func_start NNS_SndCaptureStopOutputEffect
NNS_SndCaptureStopOutputEffect: // 0x020DD7BC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020DD7E8 // =_0211F69C
	ldr r0, [r0]
	cmp r0, #1
	bne _020DD7DC
	mov r0, #0
	bl SNDi_SetSurroundDecay
_020DD7DC:
	bl NNS_SndCaptureStopEffect
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020DD7E8: .word _0211F69C
	arm_func_end NNS_SndCaptureStopOutputEffect

	arm_func_start NNSi_SndSeqArcGetSeqInfo
NNSi_SndSeqArcGetSeqInfo: // 0x020DD7EC
	cmp r1, #0
	movlt r0, #0
	bxlt lr
	ldr r2, [r0, #0x1c]
	cmp r1, r2
	movhs r0, #0
	bxhs lr
	mov r2, #0xc
	mul r2, r1, r2
	add r3, r0, #0x20
	ldr r1, [r3, r2]
	mvn r0, #0
	cmp r1, r0
	add r0, r3, r2
	moveq r0, #0
	bx lr
	arm_func_end NNSi_SndSeqArcGetSeqInfo

	arm_func_start NNSi_SndFaderIsFinished
NNSi_SndFaderIsFinished: // 0x020DD82C
	ldr r1, [r0, #8]
	ldr r0, [r0, #0xc]
	cmp r1, r0
	movge r0, #1
	movlt r0, #0
	bx lr
	arm_func_end NNSi_SndFaderIsFinished

	arm_func_start NNSi_SndFaderUpdate
NNSi_SndFaderUpdate: // 0x020DD844
	ldr r2, [r0, #8]
	ldr r1, [r0, #0xc]
	cmp r2, r1
	addlt r1, r2, #1
	strlt r1, [r0, #8]
	bx lr
	arm_func_end NNSi_SndFaderUpdate

	arm_func_start NNSi_SndFaderGet
NNSi_SndFaderGet: // 0x020DD85C
	stmdb sp!, {r4, lr}
	ldr r1, [r0, #0xc]
	ldr r2, [r0, #8]
	cmp r2, r1
	ldrge r0, [r0, #4]
	ldmgeia sp!, {r4, pc}
	ldr r4, [r0]
	ldr r0, [r0, #4]
	sub r0, r0, r4
	mul r0, r2, r0
	bl _s32_div_f
	add r0, r4, r0
	ldmia sp!, {r4, pc}
	arm_func_end NNSi_SndFaderGet

	arm_func_start NNSi_SndFaderSet
NNSi_SndFaderSet: // 0x020DD890
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl NNSi_SndFaderGet
	str r0, [r6]
	str r5, [r6, #4]
	str r4, [r6, #0xc]
	mov r0, #0
	str r0, [r6, #8]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNSi_SndFaderSet

	arm_func_start NNSi_SndFaderInit
NNSi_SndFaderInit: // 0x020DD8BC
	mov r2, #0
	str r2, [r0, #4]
	ldr r1, [r0, #4]
	str r1, [r0]
	str r2, [r0, #0xc]
	ldr r1, [r0, #0xc]
	str r1, [r0, #8]
	bx lr
	arm_func_end NNSi_SndFaderInit

    .data

_0211F69C: // 0x0211F69C
    .word 0xFFFFFFFF

_0211F6A0:
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0