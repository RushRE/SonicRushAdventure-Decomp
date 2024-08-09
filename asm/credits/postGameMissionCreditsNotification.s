	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start PostGameMissionCreditsNotification__Create
PostGameMissionCreditsNotification__Create: // 0x02156574
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r0, #0
	mov r1, #1
	bl ovl05_2154520
	mov r0, #0x2000
	mov r2, #0
	str r0, [sp]
	ldr r4, _021565E0 // =0x00000BBC
	ldr r0, _021565E4 // =PostGameMissionCreditsNotification__Main
	ldr r1, _021565E8 // =PostGameMissionCreditsNotification__Destructor
	mov r3, r2
	stmib sp, {r2, r4}
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _021565E0 // =0x00000BBC
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	mov r1, #4
	mov r0, r4
	str r1, [r4, #0xc]
	bl TextCutscene__LoadAssets
	bl LoadSysSoundVillage
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021565E0: .word 0x00000BBC
_021565E4: .word PostGameMissionCreditsNotification__Main
_021565E8: .word PostGameMissionCreditsNotification__Destructor
	arm_func_end PostGameMissionCreditsNotification__Create

	arm_func_start PostGameMissionCreditsNotification__Destructor
PostGameMissionCreditsNotification__Destructor: // 0x021565EC
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl ReleaseSysSound
	mov r0, r4
	bl ovl05_21549A4
	ldmia sp!, {r4, pc}
	arm_func_end PostGameMissionCreditsNotification__Destructor

	arm_func_start PostGameMissionCreditsNotification__Main
PostGameMissionCreditsNotification__Main: // 0x02156608
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	mov r1, #1
	bl CreditsNotification__Create
	mov r0, #0
	mov r1, #1
	bl PlaySysTrack
	ldr r0, _02156630 // =Task__OV05Unknown2156574__Main_2156634
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156630: .word Task__OV05Unknown2156574__Main_2156634
	arm_func_end PostGameMissionCreditsNotification__Main

	arm_func_start Task__OV05Unknown2156574__Main_2156634
Task__OV05Unknown2156574__Main_2156634: // 0x02156634
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r0, [r0, #0x14]
	tst r0, #0x40
	ldmeqia sp!, {r3, pc}
	ldr r0, _02156654 // =Task__OV05Unknown2156574__Main_2156658
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156654: .word Task__OV05Unknown2156574__Main_2156658
	arm_func_end Task__OV05Unknown2156574__Main_2156634

	arm_func_start Task__OV05Unknown2156574__Main_2156658
Task__OV05Unknown2156574__Main_2156658: // 0x02156658
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	mov r1, #0x14
	str r1, [r0, #0x34]
	ldr r0, _02156674 // =Task__OV05Unknown2156574__Main_2156678
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156674: .word Task__OV05Unknown2156574__Main_2156678
	arm_func_end Task__OV05Unknown2156574__Main_2156658

	arm_func_start Task__OV05Unknown2156574__Main_2156678
Task__OV05Unknown2156574__Main_2156678: // 0x02156678
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x34]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x34]
	ldmneia sp!, {r3, pc}
	mov r0, #2
	bl ovl05_21551D8
	bl ovl05_2155188
	ldmia sp!, {r3, pc}
	arm_func_end Task__OV05Unknown2156574__Main_2156678