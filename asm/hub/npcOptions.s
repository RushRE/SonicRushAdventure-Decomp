	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start NpcOptions__Create
NpcOptions__Create: // 0x0216DD14
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, _0216DD7C // =0x00001010
	mov r2, #0
	ldr r0, _0216DD80 // =NpcOptions__Main
	ldr r1, _0216DD84 // =NpcOptions__Destructor
	mov r3, r2
	str r4, [sp]
	mov r4, #0x10
	str r4, [sp, #4]
	bl NpcOptions__CreateInternal
	bl GetTaskWork_
	mov r4, r0
	bl NpcOptions__Func_216DDE0
	add r0, r4, #0xb8
	add r0, r0, #0x400
	mov r1, #0x400
	bl InitThreadWorker
	add r0, r4, #0xb8
	add r0, r0, #0x400
	mov r2, r4
	ldr r1, _0216DD88 // =NpcOptions__ThreadFunc
	mov r3, #0x14
	bl CreateThreadWorker
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216DD7C: .word 0x00001010
_0216DD80: .word NpcOptions__Main
_0216DD84: .word NpcOptions__Destructor
_0216DD88: .word NpcOptions__ThreadFunc
	arm_func_end NpcOptions__Create

	arm_func_start NpcOptions__CreateInternal
NpcOptions__CreateInternal: // 0x0216DD8C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldrh r4, [sp, #0x18]
	ldrb lr, [sp, #0x1c]
	ldr ip, _0216DDD8 // =0x00000584
	stmia sp, {r4, lr}
	str ip, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r1, r0
	ldr r0, _0216DDD8 // =0x00000584
	bl _ZnwmPv
	cmp r0, #0
	beq _0216DDCC
	bl _ZN13CViEvtCmnTalkC1Ev
_0216DDCC:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216DDD8: .word 0x00000584
	arm_func_end NpcOptions__CreateInternal

	arm_func_start NpcOptions__ThreadFunc
NpcOptions__ThreadFunc: // 0x0216DDDC
	bx lr
	arm_func_end NpcOptions__ThreadFunc

	arm_func_start NpcOptions__Func_216DDE0
NpcOptions__Func_216DDE0: // 0x0216DDE0
	ldr ip, _0216DDE8 // =_ZN10HubControl12Func_215A888Ev
	bx ip
	.align 2, 0
_0216DDE8: .word _ZN10HubControl12Func_215A888Ev
	arm_func_end NpcOptions__Func_216DDE0

	arm_func_start NpcOptions__Func_216DDEC
NpcOptions__Func_216DDEC: // 0x0216DDEC
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xb8
	add r0, r0, #0x400
	bl JoinThreadWorker
	add r0, r4, #0xb8
	add r0, r0, #0x400
	bl ReleaseThreadWorker
	mov r0, r4
	bl _ZN13CViEvtCmnTalk7ReleaseEv
	mov r0, r4
	bl NpcOptions__Func_216DE20
	ldmia sp!, {r4, pc}
	arm_func_end NpcOptions__Func_216DDEC

	arm_func_start NpcOptions__Func_216DE20
NpcOptions__Func_216DE20: // 0x0216DE20
	ldr ip, _0216DE28 // =_ZN10HubControl12Func_215A96CEv
	bx ip
	.align 2, 0
_0216DE28: .word _ZN10HubControl12Func_215A96CEv
	arm_func_end NpcOptions__Func_216DE20

	arm_func_start NpcOptions__Main
NpcOptions__Main: // 0x0216DE2C
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	add r0, r5, #0xb8
	add r0, r0, #0x400
	bl IsThreadWorkerFinished
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	bl DockHelpers__GetOptionsMessageInfo
	mov r4, r0
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	ldrh r1, [r4, #0]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldrh r2, [r4, #2]
	mov r0, r5
	ldr r3, _0216DE8C // =0x0000FFFF
	bl _ZN13CViEvtCmnTalk4InitEPvtt
	mov r0, r5
	mov r1, #0
	bl _ZN13CViEvtCmnTalk7SetPageEt
	ldr r0, _0216DE90 // =NpcOptions__Main_216DE94
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216DE8C: .word 0x0000FFFF
_0216DE90: .word NpcOptions__Main_216DE94
	arm_func_end NpcOptions__Main

	arm_func_start NpcOptions__Main_216DE94
NpcOptions__Main_216DE94: // 0x0216DE94
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	bl _ZN13CViEvtCmnTalk13ProcessDialogEv
	mov r0, r5
	bl _ZN13CViEvtCmnTalk10IsFinishedEv
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl DockHelpers__GetOptionsMessageInfo
	mov r6, r0
	mov r0, r5
	bl _ZN13CViEvtCmnTalk9GetActionEv
	mov r4, r0
	mov r0, r5
	bl _ZN13CViEvtCmnTalk12GetSelectionEv
	cmp r4, #0
	bne _0216DEE0
	cmp r0, #0
	bne _0216DEF8
_0216DEE0:
	mov r0, #0
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	mov r0, #0
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	bl DestroyCurrentTask
	ldmia sp!, {r4, r5, r6, pc}
_0216DEF8:
	cmp r0, #1
	bne _0216DF48
	bl NpcOptions__GetDifficulty
	cmp r0, #0
	ldrneh r4, [r6, #4]
	ldreqh r4, [r6, #6]
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	ldrh r1, [r6, #0]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldr r3, _0216DFD0 // =0x0000FFFF
	mov r0, r5
	mov r2, r4
	bl _ZN13CViEvtCmnTalk4InitEPvtt
	mov r0, r5
	mov r1, #0
	bl _ZN13CViEvtCmnTalk7SetPageEt
	ldr r0, _0216DFD4 // =NpcOptions__Main_216DFE0
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, r5, r6, pc}
_0216DF48:
	cmp r0, #2
	bne _0216DF98
	bl NpcOptions__GetTimeLimit
	cmp r0, #0
	ldrneh r4, [r6, #8]
	ldreqh r4, [r6, #0xa]
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	ldrh r1, [r6, #0]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldr r3, _0216DFD0 // =0x0000FFFF
	mov r0, r5
	mov r2, r4
	bl _ZN13CViEvtCmnTalk4InitEPvtt
	mov r0, r5
	mov r1, #0
	bl _ZN13CViEvtCmnTalk7SetPageEt
	ldr r0, _0216DFD8 // =NpcOptions__Main_216E0B8
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, r5, r6, pc}
_0216DF98:
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	ldrh r1, [r6, #0]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldrh r2, [r6, #0xc]
	ldr r3, _0216DFD0 // =0x0000FFFF
	mov r0, r5
	bl _ZN13CViEvtCmnTalk4InitEPvtt
	mov r0, r5
	mov r1, #0
	bl _ZN13CViEvtCmnTalk7SetPageEt
	ldr r0, _0216DFDC // =NpcOptions__Main_216E190
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216DFD0: .word 0x0000FFFF
_0216DFD4: .word NpcOptions__Main_216DFE0
_0216DFD8: .word NpcOptions__Main_216E0B8
_0216DFDC: .word NpcOptions__Main_216E190
	arm_func_end NpcOptions__Main_216DE94

	arm_func_start NpcOptions__Main_216DFE0
NpcOptions__Main_216DFE0: // 0x0216DFE0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, #0
	bl GetCurrentTaskWork_
	mov r5, r0
	bl _ZN13CViEvtCmnTalk13ProcessDialogEv
	mov r0, r5
	bl _ZN13CViEvtCmnTalk10IsFinishedEv
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	bl DockHelpers__GetOptionsMessageInfo
	mov r6, r0
	mov r0, r5
	bl _ZN13CViEvtCmnTalk9GetActionEv
	mov r4, r0
	mov r0, r5
	bl _ZN13CViEvtCmnTalk12GetSelectionEv
	cmp r4, #0
	bne _0216E058
	cmp r0, #1
	blo _0216E058
	bne _0216E048
	mov r0, #1
	bl NpcOptions__EnableNormalMode
	cmp r0, #0
	moveq r7, #1
	b _0216E058
_0216E048:
	mov r0, r7
	bl NpcOptions__EnableNormalMode
	cmp r0, #0
	moveq r7, #1
_0216E058:
	cmp r7, #0
	beq _0216E078
	mov r0, #0x1e
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	mov r0, #0
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	bl DestroyCurrentTask
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0216E078:
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	ldrh r1, [r6, #0]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldrh r2, [r6, #2]
	ldr r3, _0216E0B0 // =0x0000FFFF
	mov r0, r5
	bl _ZN13CViEvtCmnTalk4InitEPvtt
	mov r0, r5
	mov r1, #0
	bl _ZN13CViEvtCmnTalk7SetPageEt
	ldr r0, _0216E0B4 // =NpcOptions__Main_216DE94
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216E0B0: .word 0x0000FFFF
_0216E0B4: .word NpcOptions__Main_216DE94
	arm_func_end NpcOptions__Main_216DFE0

	arm_func_start NpcOptions__Main_216E0B8
NpcOptions__Main_216E0B8: // 0x0216E0B8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, #0
	bl GetCurrentTaskWork_
	mov r5, r0
	bl _ZN13CViEvtCmnTalk13ProcessDialogEv
	mov r0, r5
	bl _ZN13CViEvtCmnTalk10IsFinishedEv
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	bl DockHelpers__GetOptionsMessageInfo
	mov r6, r0
	mov r0, r5
	bl _ZN13CViEvtCmnTalk9GetActionEv
	mov r4, r0
	mov r0, r5
	bl _ZN13CViEvtCmnTalk12GetSelectionEv
	cmp r4, #0
	bne _0216E130
	cmp r0, #1
	blo _0216E130
	bne _0216E120
	mov r0, #1
	bl NpcOptions__EnableTimeLimit
	cmp r0, #0
	moveq r7, #1
	b _0216E130
_0216E120:
	mov r0, r7
	bl NpcOptions__EnableTimeLimit
	cmp r0, #0
	moveq r7, #1
_0216E130:
	cmp r7, #0
	beq _0216E150
	mov r0, #0x1e
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	mov r0, #0
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	bl DestroyCurrentTask
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0216E150:
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	ldrh r1, [r6, #0]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldrh r2, [r6, #2]
	ldr r3, _0216E188 // =0x0000FFFF
	mov r0, r5
	bl _ZN13CViEvtCmnTalk4InitEPvtt
	mov r0, r5
	mov r1, #0
	bl _ZN13CViEvtCmnTalk7SetPageEt
	ldr r0, _0216E18C // =NpcOptions__Main_216DE94
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216E188: .word 0x0000FFFF
_0216E18C: .word NpcOptions__Main_216DE94
	arm_func_end NpcOptions__Main_216E0B8

	arm_func_start NpcOptions__Main_216E190
NpcOptions__Main_216E190: // 0x0216E190
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	bl _ZN13CViEvtCmnTalk13ProcessDialogEv
	mov r0, r5
	bl _ZN13CViEvtCmnTalk10IsFinishedEv
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl DockHelpers__GetOptionsMessageInfo
	mov r6, r0
	mov r0, r5
	bl _ZN13CViEvtCmnTalk9GetActionEv
	mov r4, r0
	mov r0, r5
	bl _ZN13CViEvtCmnTalk12GetSelectionEv
	cmp r4, #0
	cmpeq r0, #1
	bne _0216E1F0
	mov r0, #0xe
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	mov r0, #0
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	bl DestroyCurrentTask
	ldmia sp!, {r4, r5, r6, pc}
_0216E1F0:
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	ldrh r1, [r6, #0]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldrh r2, [r6, #2]
	ldr r3, _0216E228 // =0x0000FFFF
	mov r0, r5
	bl _ZN13CViEvtCmnTalk4InitEPvtt
	mov r0, r5
	mov r1, #0
	bl _ZN13CViEvtCmnTalk7SetPageEt
	ldr r0, _0216E22C // =NpcOptions__Main_216DE94
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216E228: .word 0x0000FFFF
_0216E22C: .word NpcOptions__Main_216DE94
	arm_func_end NpcOptions__Main_216E190

	arm_func_start NpcOptions__Destructor
NpcOptions__Destructor: // 0x0216E230
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	bl NpcOptions__Func_216DDEC
	mov r0, r4
	bl NpcOptions__Func_216E24C
	ldmia sp!, {r4, pc}
	arm_func_end NpcOptions__Destructor

	arm_func_start NpcOptions__Func_216E24C
NpcOptions__Func_216E24C: // 0x0216E24C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x10]
	cmp r4, #0
	beq _0216E270
	mov r0, r4
	bl _ZN13CViEvtCmnTalkD1Ev
	mov r0, r4
	bl _ZdlPv
_0216E270:
	mov r0, #0
	str r0, [r5, #0x10]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end NpcOptions__Func_216E24C

	arm_func_start NpcOptions__GetDifficulty
NpcOptions__GetDifficulty: // 0x0216E27C
	ldr r0, _0216E298 // =saveGame
	ldr r0, [r0, #0x1c0]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1e
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0216E298: .word saveGame
	arm_func_end NpcOptions__GetDifficulty

	arm_func_start NpcOptions__GetTimeLimit
NpcOptions__GetTimeLimit: // 0x0216E29C
	ldr r0, _0216E2B8 // =saveGame
	ldr r0, [r0, #0x1c0]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0216E2B8: .word saveGame
	arm_func_end NpcOptions__GetTimeLimit

	arm_func_start NpcOptions__EnableNormalMode
NpcOptions__EnableNormalMode: // 0x0216E2BC
	cmp r0, #0
	ldreq r0, _0216E2F0 // =saveGame
	ldreq r1, [r0, #0x1c0]
	biceq r1, r1, #3
	beq _0216E2E0
	ldr r0, _0216E2F0 // =saveGame
	ldr r1, [r0, #0x1c0]
	bic r1, r1, #3
	orr r1, r1, #1
_0216E2E0:
	ldr ip, _0216E2F4 // =TrySaveGameData
	str r1, [r0, #0x1c0]
	mov r0, #1
	bx ip
	.align 2, 0
_0216E2F0: .word saveGame
_0216E2F4: .word TrySaveGameData
	arm_func_end NpcOptions__EnableNormalMode

	arm_func_start NpcOptions__EnableTimeLimit
NpcOptions__EnableTimeLimit: // 0x0216E2F8
	cmp r0, #0
	ldreq r0, _0216E328 // =saveGame
	ldreq r1, [r0, #0x1c0]
	biceq r1, r1, #4
	beq _0216E318
	ldr r0, _0216E328 // =saveGame
	ldr r1, [r0, #0x1c0]
	orr r1, r1, #4
_0216E318:
	ldr ip, _0216E32C // =TrySaveGameData
	str r1, [r0, #0x1c0]
	mov r0, #1
	bx ip
	.align 2, 0
_0216E328: .word saveGame
_0216E32C: .word TrySaveGameData
	arm_func_end NpcOptions__EnableTimeLimit
