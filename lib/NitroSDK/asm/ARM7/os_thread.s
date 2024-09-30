	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public OSi_StackForDestructor
OSi_StackForDestructor: // 0x0380841C
	.space 4

.public OSi_RescheduleCount
OSi_RescheduleCount: // 0x03808420
	.space 4

.public OSi_ThreadIdCount
OSi_ThreadIdCount: // 0x03808424
	.space 4

.public OSi_SystemCallbackInSwitchThread
OSi_SystemCallbackInSwitchThread: // 0x03808428
	.space 4

.public OSi_CurrentThreadPtr
OSi_CurrentThreadPtr: // 0x0380842C
	.space 4

.public OSi_IsThreadInitialized
OSi_IsThreadInitialized: // 0x03808430
	.space 4

.public OSi_ThreadInfo
OSi_ThreadInfo: // OSi_ThreadInfo
	.space 0x10

.public OSi_IdleThread
OSi_IdleThread: // 0x03808444
	.space 0xA4

.public OSi_LauncherThread
OSi_LauncherThread: // 0x038084E8
	.space 0xA4

	.text

	arm_func_start OS_SetThreadDestructor
OS_SetThreadDestructor: // 0x037FC1E0
	str r1, [r0, #0x98]
	bx lr
	arm_func_end OS_SetThreadDestructor

	arm_func_start OS_EnableScheduler
OS_EnableScheduler: // 0x037FC1E8
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	mov r4, #0
	ldr r1, _037FC21C // =OSi_RescheduleCount
	ldr r3, [r1, #0]
	cmp r3, #0
	subne r2, r3, #1
	strne r2, [r1]
	movne r4, r3
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FC21C: .word OSi_RescheduleCount
	arm_func_end OS_EnableScheduler

	arm_func_start OS_DisableScheduler
OS_DisableScheduler: // 0x037FC220
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r2, _037FC254 // =OSi_RescheduleCount
	ldr r3, [r2, #0]
	mvn r1, #0
	cmp r3, r1
	addlo r1, r3, #1
	strlo r1, [r2]
	movlo r4, r3
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FC254: .word OSi_RescheduleCount
	arm_func_end OS_DisableScheduler

	arm_func_start OS_SetSwitchThreadCallback
OS_SetSwitchThreadCallback: // 0x037FC258
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _037FC288 // =OSi_ThreadInfo
	ldr r4, [r1, #0xc]
	str r5, [r1, #0xc]
	bl OS_RestoreInterrupts
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FC288: .word OSi_ThreadInfo
	arm_func_end OS_SetSwitchThreadCallback

	arm_func_start OSi_SleepAlarmCallback
OSi_SleepAlarmCallback: // 0x037FC28C
	ldr r2, [r0, #0]
	mov r1, #0
	str r1, [r0]
	str r1, [r2, #0x94]
	mov r0, r2
	ldr ip, _037FC2A8 // =OS_WakeupThreadDirect
	bx ip
	.align 2, 0
_037FC2A8: .word OS_WakeupThreadDirect
	arm_func_end OSi_SleepAlarmCallback

	arm_func_start OS_Sleep
OS_Sleep: // 0x037FC2AC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x34
	mov r5, r0
	add r0, sp, #8
	bl OS_CreateAlarm
	ldr r0, _037FC344 // =OSi_CurrentThreadPtr
	ldr r0, [r0, #0]
	ldr r0, [r0, #0]
	str r0, [sp, #4]
	bl OS_DisableInterrupts
	mov r4, r0
	add r0, sp, #8
	ldr r1, [sp, #4]
	str r0, [r1, #0x94]
	add r1, sp, #4
	str r1, [sp]
	mov r2, #0
	ldr r1, _037FC348 // =0x000082EA
	umull ip, r3, r5, r1
	mla r3, r5, r2, r3
	mla r3, r2, r1, r3
	mov r2, r3, lsr #6
	mov r1, ip, lsr #6
	orr r1, r1, r3, lsl #26
	ldr r3, _037FC34C // =OSi_SleepAlarmCallback
	bl OS_SetAlarm
	mov r5, #0
	b _037FC324
_037FC31C:
	mov r0, r5
	bl OS_SleepThread
_037FC324:
	ldr r0, [sp, #4]
	cmp r0, #0
	bne _037FC31C
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FC344: .word OSi_CurrentThreadPtr
_037FC348: .word 0x000082EA
_037FC34C: .word OSi_SleepAlarmCallback
	arm_func_end OS_Sleep

	arm_func_start OS_YieldThread
OS_YieldThread: // 0x037FC350
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _037FC3F8 // =OSi_ThreadInfo
	ldr r8, [r0, #8]
	mov r7, #0
	bl OS_DisableInterrupts
	mov r4, r0
	b _037FC37C
_037FC374:
	mov r7, r8
	ldr r8, [r8, #0x4c]
_037FC37C:
	cmp r8, #0
	beq _037FC38C
	cmp r8, r6
	bne _037FC374
_037FC38C:
	cmp r8, #0
	beq _037FC3A0
	ldr r0, _037FC3FC // =OSi_IdleThread
	cmp r8, r0
	bne _037FC3B0
_037FC3A0:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #0
	b _037FC3F0
_037FC3B0:
	ldr r0, [r8, #0x54]
	cmp r0, r5
	beq _037FC3E4
	cmp r7, #0
	ldreq r1, [r6, #0x4c]
	ldreq r0, _037FC3F8 // =OSi_ThreadInfo
	streq r1, [r0, #8]
	ldrne r0, [r6, #0x4c]
	strne r0, [r7, #0x4c]
	str r5, [r6, #0x54]
	mov r0, r6
	bl OSi_InsertThreadToList
	bl OSi_RescheduleThread
_037FC3E4:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #1
_037FC3F0:
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_037FC3F8: .word OSi_ThreadInfo
_037FC3FC: .word OSi_IdleThread
	arm_func_end OS_YieldThread

	arm_func_start OS_RescheduleThread
OS_RescheduleThread: // 0x037FC400
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	mov r4, r0
	bl OSi_RescheduleThread
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end OS_RescheduleThread

	arm_func_start OS_SelectThread
OS_SelectThread: // 0x037FC420
	ldr r0, _037FC448 // =OSi_ThreadInfo
	ldr r0, [r0, #8]
	b _037FC430
_037FC42C:
	ldr r0, [r0, #0x4c]
_037FC430:
	cmp r0, #0
	bxeq lr
	ldr r1, [r0, #0x48]
	cmp r1, #1
	bne _037FC42C
	bx lr
	.align 2, 0
_037FC448: .word OSi_ThreadInfo
	arm_func_end OS_SelectThread

	arm_func_start OS_WakeupThreadDirect
OS_WakeupThreadDirect: // 0x037FC44C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, #1
	str r0, [r5, #0x48]
	bl OSi_RescheduleThread
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end OS_WakeupThreadDirect

	arm_func_start OS_WakeupThread
OS_WakeupThread: // 0x037FC480
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r0, [r5, #0]
	cmp r0, #0
	beq _037FC4E8
	mov r7, #1
	mov r6, #0
	b _037FC4C8
_037FC4AC:
	mov r0, r5
	bl OSi_RemoveLinkFromQueue
	str r7, [r0, #0x48]
	str r6, [r0, #0x5c]
	str r6, [r0, #0x64]
	ldr r1, [r0, #0x64]
	str r1, [r0, #0x60]
_037FC4C8:
	ldr r0, [r5, #0]
	cmp r0, #0
	bne _037FC4AC
	mov r0, #0
	str r0, [r5, #4]
	ldr r0, [r5, #4]
	str r0, [r5]
	bl OSi_RescheduleThread
_037FC4E8:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end OS_WakeupThread

	arm_func_start OS_SleepThread
OS_SleepThread: // 0x037FC4FC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl OS_DisableInterrupts
	mov r5, r0
	ldr r0, _037FC54C // =OSi_CurrentThreadPtr
	ldr r0, [r0, #0]
	ldr r4, [r0, #0]
	cmp r6, #0
	beq _037FC530
	str r6, [r4, #0x5c]
	mov r0, r6
	mov r1, r4
	bl OSi_InsertLinkToQueue
_037FC530:
	mov r0, #0
	str r0, [r4, #0x48]
	bl OSi_RescheduleThread
	mov r0, r5
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_037FC54C: .word OSi_CurrentThreadPtr
	arm_func_end OS_SleepThread

	arm_func_start OSi_ExitThread_Destroy
OSi_ExitThread_Destroy: // 0x037FC550
	stmdb sp!, {r4, lr}
	ldr r0, _037FC5AC // =OSi_CurrentThreadPtr
	ldr r0, [r0, #0]
	ldr r4, [r0, #0]
	bl OS_DisableScheduler
	mov r0, r4
	bl OSi_UnlockAllMutex
	ldr r0, [r4, #0x5c]
	cmp r0, #0
	beq _037FC580
	mov r1, r4
	bl OSi_RemoveSpecifiedLinkFromQueue
_037FC580:
	mov r0, r4
	bl OSi_RemoveThreadFromList
	mov r0, #2
	str r0, [r4, #0x48]
	add r0, r4, #0x80
	bl OS_WakeupThread
	bl OS_EnableScheduler
	bl OS_RescheduleThread
	bl OS_Terminate
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FC5AC: .word OSi_CurrentThreadPtr
	arm_func_end OSi_ExitThread_Destroy

	arm_func_start OSi_ExitThread
OSi_ExitThread: // 0x037FC5B0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _037FC5F4 // =OSi_CurrentThreadPtr
	ldr r1, [r1, #0]
	ldr r3, [r1, #0]
	ldr r2, [r3, #0x98]
	cmp r2, #0
	beq _037FC5E4
	mov r1, #0
	str r1, [r3, #0x98]
	mov lr, pc
	bx r2
_37FC5E0: // 0x037FC5E0
	bl OS_DisableInterrupts
_037FC5E4:
	bl OSi_ExitThread_Destroy
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FC5F4: .word OSi_CurrentThreadPtr
	arm_func_end OSi_ExitThread

	arm_func_start OSi_ExitThread_ArgSpecified
OSi_ExitThread_ArgSpecified: // 0x037FC5F8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	ldr r1, _037FC658 // =OSi_StackForDestructor
	ldr r2, [r1, #0]
	cmp r2, #0
	beq _037FC644
	ldr r1, _037FC65C // =OSi_ExitThread
	bl OS_InitContext
	str r4, [r5, #4]
	ldr r0, [r5, #0]
	orr r0, r0, #0x80
	str r0, [r5]
	mov r0, #1
	str r0, [r5, #0x48]
	mov r0, r5
	bl OS_LoadContext
	b _037FC64C
_037FC644:
	mov r0, r4
	bl OSi_ExitThread
_037FC64C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FC658: .word OSi_StackForDestructor
_037FC65C: .word OSi_ExitThread
	arm_func_end OSi_ExitThread_ArgSpecified

	arm_func_start OS_ExitThread
OS_ExitThread: // 0x037FC660
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	ldr r0, _037FC688 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	mov r1, #0
	bl OSi_ExitThread_ArgSpecified
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FC688: .word OSi_ThreadInfo
	arm_func_end OS_ExitThread

	arm_func_start OS_CreateThread
OS_CreateThread: // 0x037FC68C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	bl OS_DisableInterrupts
	mov r4, r0
	bl OSi_GetUnusedThreadId
	ldr r1, [sp, #0x24]
	str r1, [r9, #0x54]
	str r0, [r9, #0x50]
	mov r0, #0
	str r0, [r9, #0x48]
	str r0, [r9, #0x58]
	mov r0, r9
	bl OSi_InsertThreadToList
	str r6, [r9, #0x78]
	ldr r0, [sp, #0x20]
	sub r5, r6, r0
	str r5, [r9, #0x74]
	mov r2, #0
	str r2, [r9, #0x7c]
	ldr r1, _037FC790 // =0xD73BFDF7
	ldr r0, [r9, #0x78]
	str r1, [r0, #-4]
	ldr r1, _037FC794 // =0xFBDD37BB
	ldr r0, [r9, #0x74]
	str r1, [r0]
	str r2, [r9, #0x84]
	ldr r0, [r9, #0x84]
	str r0, [r9, #0x80]
	mov r0, r9
	mov r1, r8
	sub r2, r6, #4
	bl OS_InitContext
	str r7, [r9, #4]
	ldr r0, _037FC798 // =OS_ExitThread
	str r0, [r9, #0x3c]
	mov r0, #0
	add r1, r5, #4
	ldr r2, [sp, #0x20]
	sub r2, r2, #8
	bl MIi_CpuClear32
	mov r1, #0
	str r1, [r9, #0x68]
	str r1, [r9, #0x6c]
	str r1, [r9, #0x70]
	mov r0, r9
	bl OS_SetThreadDestructor
	mov r0, #0
	str r0, [r9, #0x5c]
	str r0, [r9, #0x64]
	ldr r1, [r9, #0x64]
	str r1, [r9, #0x60]
	add r1, r9, #0x88
	mov r2, #0xc
	bl MIi_CpuClear32
	mov r0, #0
	str r0, [r9, #0x94]
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_037FC790: .word 0xD73BFDF7
_037FC794: .word 0xFBDD37BB
_037FC798: .word OS_ExitThread
	arm_func_end OS_CreateThread

	arm_func_start OS_InitThread
OS_InitThread: // 0x037FC79C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _037FC874 // =OSi_IsThreadInitialized
	ldr r1, [r0, #0]
	cmp r1, #0
	bne _037FC868
	mov r2, #1
	str r2, [r0]
	ldr r1, _037FC878 // =0x03808438
	ldr r0, _037FC87C // =OSi_CurrentThreadPtr
	str r1, [r0]
	mov r0, #0x10
	ldr r1, _037FC880 // =OSi_LauncherThread
	str r0, [r1, #0x54]
	mov r0, #0
	str r0, [r1, #0x50]
	str r2, [r1, #0x48]
	str r0, [r1, #0x4c]
	str r0, [r1, #0x58]
	ldr r0, _037FC884 // =OSi_ThreadInfo
	str r1, [r0, #8]
	str r1, [r0, #4]
	ldr r2, _037FC888 // =0x00000400
	cmp r2, #0
	ldrle r0, _037FC88C // =VBlankIntr
	suble r2, r0, r2
	ldrgt r1, _037FC890 // =0x00000400
	ldrgt r0, _037FC894 // =0x0380FF80
	subgt r0, r0, r1
	subgt r2, r0, r2
	ldr r1, _037FC890 // =0x00000400
	ldr r0, _037FC894 // =0x0380FF80
	sub r3, r0, r1
	ldr r1, _037FC880 // =OSi_LauncherThread
	str r3, [r1, #0x78]
	str r2, [r1, #0x74]
	mov r0, #0
	str r0, [r1, #0x7c]
	ldr r2, _037FC898 // =0xD73BFDF7
	str r2, [r3, #-4]
	ldr r3, _037FC89C // =0xFBDD37BB
	ldr r2, [r1, #0x74]
	str r3, [r2]
	str r0, [r1, #0x84]
	str r0, [r1, #0x80]
	ldr r1, _037FC884 // =OSi_ThreadInfo
	strh r0, [r1]
	strh r0, [r1, #2]
	ldr r2, _037FC8A0 // =0x027FFFA4
	str r1, [r2]
	bl OS_SetSwitchThreadCallback
_037FC868:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FC874: .word OSi_IsThreadInitialized
_037FC878: .word 0x03808438
_037FC87C: .word OSi_CurrentThreadPtr
_037FC880: .word OSi_LauncherThread
_037FC884: .word OSi_ThreadInfo
_037FC888: .word 0x00000400
_037FC88C: .word VBlankIntr
_037FC890: .word 0x00000400
_037FC894: .word 0x0380FF80
_037FC898: .word 0xD73BFDF7
_037FC89C: .word 0xFBDD37BB
_037FC8A0: .word 0x027FFFA4
	arm_func_end OS_InitThread

	arm_func_start OSi_RescheduleThread
OSi_RescheduleThread: // 0x037FC8A4
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, _037FC974 // =OSi_RescheduleCount
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _037FC96C
	ldr r4, _037FC978 // =OSi_ThreadInfo
	ldrh r0, [r4, #2]
	cmp r0, #0
	bne _037FC8D4
	bl OS_GetProcMode
	cmp r0, #0x12
	bne _037FC8E0
_037FC8D4:
	mov r0, #1
	strh r0, [r4]
	b _037FC96C
_037FC8E0:
	ldr r0, _037FC97C // =OSi_CurrentThreadPtr
	ldr r0, [r0, #0]
	ldr r6, [r0, #0]
	bl OS_SelectThread
	mov r5, r0
	cmp r6, r5
	beq _037FC96C
	cmp r5, #0
	beq _037FC96C
	ldr r0, [r6, #0x48]
	cmp r0, #2
	beq _037FC920
	mov r0, r6
	bl OS_SaveContext
	cmp r0, #0
	bne _037FC96C
_037FC920:
	ldr r0, _037FC980 // =OSi_SystemCallbackInSwitchThread
	ldr r2, [r0, #0]
	cmp r2, #0
	beq _037FC940
	mov r0, r6
	mov r1, r5
	mov lr, pc
	bx r2
_037FC940:
	ldr r2, [r4, #0xc]
	cmp r2, #0
	beq _037FC95C
	mov r0, r6
	mov r1, r5
	mov lr, pc
	bx r2
_037FC95C:
	ldr r0, _037FC978 // =OSi_ThreadInfo
	str r5, [r0, #4]
	mov r0, r5
	bl OS_LoadContext
_037FC96C:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_037FC974: .word OSi_RescheduleCount
_037FC978: .word OSi_ThreadInfo
_037FC97C: .word OSi_CurrentThreadPtr
_037FC980: .word OSi_SystemCallbackInSwitchThread
	arm_func_end OSi_RescheduleThread

	arm_func_start OSi_RemoveThreadFromList
OSi_RemoveThreadFromList: // 0x037FC984
	ldr r1, _037FC9C8 // =OSi_ThreadInfo
	ldr r2, [r1, #8]
	mov r1, #0
	b _037FC99C
_037FC994:
	mov r1, r2
	ldr r2, [r2, #0x4c]
_037FC99C:
	cmp r2, #0
	beq _037FC9AC
	cmp r2, r0
	bne _037FC994
_037FC9AC:
	cmp r1, #0
	ldreq r1, [r0, #0x4c]
	ldreq r0, _037FC9C8 // =OSi_ThreadInfo
	streq r1, [r0, #8]
	ldrne r0, [r0, #0x4c]
	strne r0, [r1, #0x4c]
	bx lr
	.align 2, 0
_037FC9C8: .word OSi_ThreadInfo
	arm_func_end OSi_RemoveThreadFromList

	arm_func_start OSi_InsertThreadToList
OSi_InsertThreadToList: // 0x037FC9CC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _037FCA30 // =OSi_ThreadInfo
	ldr r3, [r1, #8]
	mov lr, r3
	mov ip, #0
	b _037FC9F0
_037FC9E8:
	mov ip, lr
	ldr lr, [lr, #0x4c]
_037FC9F0:
	cmp lr, #0
	beq _037FCA08
	ldr r2, [lr, #0x54]
	ldr r1, [r0, #0x54]
	cmp r2, r1
	blo _037FC9E8
_037FCA08:
	cmp ip, #0
	streq r3, [r0, #0x4c]
	ldreq r1, _037FCA30 // =OSi_ThreadInfo
	streq r0, [r1, #8]
	ldrne r1, [ip, #0x4c]
	strne r1, [r0, #0x4c]
	strne r0, [ip, #0x4c]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FCA30: .word OSi_ThreadInfo
	arm_func_end OSi_InsertThreadToList

	arm_func_start OSi_RemoveMutexLinkFromQueue
OSi_RemoveMutexLinkFromQueue: // 0x037FCA34
	ldr r2, [r0, #0]
	cmp r2, #0
	beq _037FCA5C
	ldr r1, [r2, #0x10]
	str r1, [r0]
	cmp r1, #0
	movne r0, #0
	strne r0, [r1, #0x14]
	moveq r1, #0
	streq r1, [r0, #4]
_037FCA5C:
	mov r0, r2
	bx lr
	arm_func_end OSi_RemoveMutexLinkFromQueue

	arm_func_start OSi_RemoveSpecifiedLinkFromQueue
OSi_RemoveSpecifiedLinkFromQueue: // 0x037FCA64
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, [r0, #0]
	mov lr, r2
	b _037FCAAC
_037FCA78:
	ldr ip, [lr, #0x64]
	cmp lr, r1
	bne _037FCAA8
	ldr r3, [lr, #0x60]
	cmp r2, lr
	streq ip, [r0]
	strne ip, [r3, #0x64]
	ldr r1, [r0, #4]
	cmp r1, lr
	streq r3, [r0, #4]
	strne r3, [ip, #0x60]
	b _037FCAB4
_037FCAA8:
	mov lr, ip
_037FCAAC:
	cmp lr, #0
	bne _037FCA78
_037FCAB4:
	mov r0, lr
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end OSi_RemoveSpecifiedLinkFromQueue

	arm_func_start OSi_RemoveLinkFromQueue
OSi_RemoveLinkFromQueue: // 0x037FCAC4
	ldr r2, [r0, #0]
	cmp r2, #0
	beq _037FCAF0
	ldr r1, [r2, #0x64]
	str r1, [r0]
	cmp r1, #0
	movne r0, #0
	strne r0, [r1, #0x60]
	moveq r1, #0
	streq r1, [r0, #4]
	streq r1, [r2, #0x5c]
_037FCAF0:
	mov r0, r2
	bx lr
	arm_func_end OSi_RemoveLinkFromQueue

	arm_func_start OSi_InsertLinkToQueue
OSi_InsertLinkToQueue: // 0x037FCAF8
	ldr ip, [r0]
	b _037FCB0C
_037FCB00:
	cmp ip, r1
	bxeq lr
	ldr ip, [ip, #0x64]
_037FCB0C:
	cmp ip, #0
	beq _037FCB24
	ldr r3, [ip, #0x54]
	ldr r2, [r1, #0x54]
	cmp r3, r2
	bls _037FCB00
_037FCB24:
	cmp ip, #0
	bne _037FCB50
	ldr r2, [r0, #4]
	cmp r2, #0
	streq r1, [r0]
	strne r1, [r2, #0x64]
	str r2, [r1, #0x60]
	mov r2, #0
	str r2, [r1, #0x64]
	str r1, [r0, #4]
	bx lr
_037FCB50:
	ldr r2, [ip, #0x60]
	cmp r2, #0
	streq r1, [r0]
	strne r1, [r2, #0x64]
	str r2, [r1, #0x60]
	str ip, [r1, #0x64]
	str r1, [ip, #0x60]
	bx lr
	arm_func_end OSi_InsertLinkToQueue

	arm_func_start OSi_GetUnusedThreadId
OSi_GetUnusedThreadId: // 0x037FCB70
	ldr r1, _037FCB84 // =OSi_ThreadIdCount
	ldr r0, [r1, #0]
	add r0, r0, #1
	str r0, [r1]
	bx lr
	.align 2, 0
_037FCB84: .word OSi_ThreadIdCount
	arm_func_end OSi_GetUnusedThreadId
