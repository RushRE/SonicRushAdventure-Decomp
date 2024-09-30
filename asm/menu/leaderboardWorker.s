	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public LeaderboardWorker__Singleton
LeaderboardWorker__Singleton: // 0x0217EFF4
	.space 0x04 // Task*

	.text

	arm_func_start LeaderboardWorker__Create
LeaderboardWorker__Create: // 0x02174858
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl MultibootManager__Func_20618F0
	cmp r0, #0
	beq _02174884
	bl MultibootManager__Func_2061904
	cmp r0, #0
	bne _02174890
_02174884:
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_02174890:
	ldr r0, _0217494C // =0x00001010
	mov r2, #0
	str r0, [sp]
	ldr r0, _02174950 // =LeaderboardWorker__Main
	ldr r1, _02174954 // =LeaderboardWorker__Destructor
	mov r3, r2
	str r2, [sp, #4]
	mov r4, #0x108
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _02174958 // =LeaderboardWorker__Singleton
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #2
	str r0, [r4]
	mov r1, #0
	mov r0, r7
	str r1, [r4, #4]
	bl LeaderboardWorker__GetRankCategory
	str r0, [r4, #0x24]
	mov r0, r7
	bl LeaderboardWorker__GetRankScore
	str r0, [r4, #0x28]
	str r7, [r4, #0x2c]
	str r6, [r4, #0x30]
	mov r0, #0
	str r0, [r4, #0x34]
	mov r1, r5
	mov r2, r7
	add r0, r4, #8
	bl LeaderboardWorker__GetRankData
	str r0, [r4, #0x38]
	cmp r0, #0
	beq _02174928
	ldr r0, [r4, #0x28]
	cmp r0, #0
	bge _02174930
_02174928:
	mov r0, #0
	str r0, [r4, #0x30]
_02174930:
	mov r1, #0
	mov r0, r4
	str r1, [r4, #0x104]
	bl LeaderboardWorker__Func_2174D88
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0217494C: .word 0x00001010
_02174950: .word LeaderboardWorker__Main
_02174954: .word LeaderboardWorker__Destructor
_02174958: .word LeaderboardWorker__Singleton
	arm_func_end LeaderboardWorker__Create

	arm_func_start LeaderboardWorker__GetFlags
LeaderboardWorker__GetFlags: // 0x0217495C
	stmdb sp!, {r3, lr}
	ldr r0, _02174980 // =LeaderboardWorker__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	moveq r0, #5
	ldmeqia sp!, {r3, pc}
	bl GetTaskWork_
	ldr r0, [r0, #0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02174980: .word LeaderboardWorker__Singleton
	arm_func_end LeaderboardWorker__GetFlags

	arm_func_start LeaderboardWorker__Destroy
LeaderboardWorker__Destroy: // 0x02174984
	stmdb sp!, {r3, lr}
	ldr r0, _021749A4 // =LeaderboardWorker__Singleton
	ldr r0, [r0, #0]
	bl DestroyTask
	ldr r0, _021749A4 // =LeaderboardWorker__Singleton
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021749A4: .word LeaderboardWorker__Singleton
	arm_func_end LeaderboardWorker__Destroy

	arm_func_start LeaderboardWorker__Main
LeaderboardWorker__Main: // 0x021749A8
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x104]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	blx r1
	ldmia sp!, {r3, pc}
	arm_func_end LeaderboardWorker__Main

	arm_func_start LeaderboardWorker__Destructor
LeaderboardWorker__Destructor: // 0x021749C4
	ldr r0, _021749D4 // =LeaderboardWorker__Singleton
	mov r1, #0
	str r1, [r0]
	bx lr
	.align 2, 0
_021749D4: .word LeaderboardWorker__Singleton
	arm_func_end LeaderboardWorker__Destructor

	arm_func_start LeaderboardWorker__State_21749D8
LeaderboardWorker__State_21749D8: // 0x021749D8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0x11
	beq _02174A00
	mov r0, r4
	bl LeaderboardWorker__Func_2174EBC
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
_02174A00:
	ldr r0, [r4, #0x34]
	cmp r0, #0
	beq _02174A1C
	mov r0, r4
	bl LeaderboardWorker__Func_2174F0C
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
_02174A1C:
	add r0, sp, #0xc
	add r1, sp, #0
	bl DWC_GetDateTime
	cmp r0, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r3, r4, pc}
	add r0, sp, #0xc
	add r1, sp, #0
	bl RTC_ConvertDateTimeToSecond
	ldr r3, [r4, #0x1c]
	ldr r2, [r4, #0x20]
	adds ip, r3, #0x78
	adc r3, r2, #0
	subs r2, r0, ip
	sbcs r2, r1, r3
	addlt sp, sp, #0x1c
	ldmltia sp!, {r3, r4, pc}
	mov r2, #1
	bl LeaderboardWorker__SetSaveSeconds
	cmp r0, #0
	bne _02174A88
	mov r1, #1
	mov r0, r4
	str r1, [r4, #4]
	bl LeaderboardWorker__Func_2174EBC
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
_02174A88:
	mov r0, r4
	bl LeaderboardWorker__Func_2174DAC
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
	arm_func_end LeaderboardWorker__State_21749D8

	arm_func_start LeaderboardWorker__State_2174A98
LeaderboardWorker__State_2174A98: // 0x02174A98
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0x11
	bne _02174AB8
	bl GetLeaderboardsManagerStatus
	cmp r0, #5
	bne _02174AC4
_02174AB8:
	mov r0, r4
	bl LeaderboardWorker__Func_2174EBC
	ldmia sp!, {r4, pc}
_02174AC4:
	bl GetLeaderboardsManagerStatus
	cmp r0, #4
	bne _02174ADC
	mov r0, r4
	bl LeaderboardWorker__Func_2174EEC
	ldmia sp!, {r4, pc}
_02174ADC:
	ldr r0, [r4, #0x34]
	cmp r0, #0
	beq _02174AF4
	mov r0, r4
	bl LeaderboardWorker__Func_2174F0C
	ldmia sp!, {r4, pc}
_02174AF4:
	bl GetLeaderboardsManagerStatus
	cmp r0, #1
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x30]
	cmp r0, #0
	mov r0, r4
	beq _02174B18
	bl LeaderboardWorker__Func_2174DCC
	ldmia sp!, {r4, pc}
_02174B18:
	bl LeaderboardWorker__Func_2174E08
	ldmia sp!, {r4, pc}
	arm_func_end LeaderboardWorker__State_2174A98

	arm_func_start LeaderboardWorker__State_2174B20
LeaderboardWorker__State_2174B20: // 0x02174B20
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0x11
	bne _02174B40
	bl GetLeaderboardsManagerStatus
	cmp r0, #5
	bne _02174B4C
_02174B40:
	mov r0, r4
	bl LeaderboardWorker__Func_2174EBC
	ldmia sp!, {r4, pc}
_02174B4C:
	bl GetLeaderboardsManagerStatus
	cmp r0, #4
	bne _02174B64
	mov r0, r4
	bl LeaderboardWorker__Func_2174EEC
	ldmia sp!, {r4, pc}
_02174B64:
	ldr r0, [r4, #0x34]
	cmp r0, #0
	beq _02174B7C
	mov r0, r4
	bl LeaderboardWorker__Func_2174F0C
	ldmia sp!, {r4, pc}
_02174B7C:
	bl GetLeaderboardsManagerStatus
	cmp r0, #1
	bne _02174B94
	mov r0, r4
	bl LeaderboardWorker__Func_2174E08
	ldmia sp!, {r4, pc}
_02174B94:
	bl GetLeaderboardsManagerStatus
	cmp r0, #2
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl LeaderboardWorker__Func_2174EBC
	ldmia sp!, {r4, pc}
	arm_func_end LeaderboardWorker__State_2174B20

	arm_func_start LeaderboardWorker__State_2174BAC
LeaderboardWorker__State_2174BAC: // 0x02174BAC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0x11
	bne _02174BCC
	bl GetLeaderboardsManagerStatus
	cmp r0, #5
	bne _02174BD8
_02174BCC:
	mov r0, r4
	bl LeaderboardWorker__Func_2174EBC
	ldmia sp!, {r4, pc}
_02174BD8:
	bl GetLeaderboardsManagerStatus
	cmp r0, #4
	bne _02174BF0
	mov r0, r4
	bl LeaderboardWorker__Func_2174EEC
	ldmia sp!, {r4, pc}
_02174BF0:
	ldr r0, [r4, #0x34]
	cmp r0, #0
	beq _02174C08
	mov r0, r4
	bl LeaderboardWorker__Func_2174F0C
	ldmia sp!, {r4, pc}
_02174C08:
	bl GetLeaderboardsManagerStatus
	cmp r0, #1
	bne _02174C3C
	mov r0, r4
	bl LeaderboardWorker__LoadRankList1
	ldr r0, [r4, #0x38]
	cmp r0, #0
	mov r0, r4
	beq _02174C34
	bl LeaderboardWorker__Func_2174E44
	ldmia sp!, {r4, pc}
_02174C34:
	bl LeaderboardWorker__Func_2174E80
	ldmia sp!, {r4, pc}
_02174C3C:
	bl GetLeaderboardsManagerStatus
	cmp r0, #3
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl LeaderboardWorker__Func_2174EBC
	ldmia sp!, {r4, pc}
	arm_func_end LeaderboardWorker__State_2174BAC

	arm_func_start LeaderboardWorker__State_2174C54
LeaderboardWorker__State_2174C54: // 0x02174C54
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0x11
	bne _02174C74
	bl GetLeaderboardsManagerStatus
	cmp r0, #5
	bne _02174C80
_02174C74:
	mov r0, r4
	bl LeaderboardWorker__Func_2174EBC
	ldmia sp!, {r4, pc}
_02174C80:
	bl GetLeaderboardsManagerStatus
	cmp r0, #4
	bne _02174C98
	mov r0, r4
	bl LeaderboardWorker__Func_2174EEC
	ldmia sp!, {r4, pc}
_02174C98:
	ldr r0, [r4, #0x34]
	cmp r0, #0
	beq _02174CB0
	mov r0, r4
	bl LeaderboardWorker__Func_2174F0C
	ldmia sp!, {r4, pc}
_02174CB0:
	bl GetLeaderboardsManagerStatus
	cmp r0, #1
	bne _02174CD0
	mov r0, r4
	bl LeaderboardWorker__LoadRankList2
	mov r0, r4
	bl LeaderboardWorker__Func_2174E80
	ldmia sp!, {r4, pc}
_02174CD0:
	bl GetLeaderboardsManagerStatus
	cmp r0, #3
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl LeaderboardWorker__Func_2174EBC
	ldmia sp!, {r4, pc}
	arm_func_end LeaderboardWorker__State_2174C54

	arm_func_start LeaderboardWorker__State_2174CE8
LeaderboardWorker__State_2174CE8: // 0x02174CE8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0x11
	bne _02174D0C
	bl GetLeaderboardsManagerStatus
	cmp r0, #5
	bne _02174D1C
_02174D0C:
	mov r0, r4
	bl LeaderboardWorker__Func_2174EBC
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
_02174D1C:
	ldr r0, [r4, #0x34]
	cmp r0, #0
	beq _02174D38
	mov r0, r4
	bl LeaderboardWorker__Func_2174F0C
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
_02174D38:
	bl GetLeaderboardsManagerStatus
	cmp r0, #0
	addne sp, sp, #0x1c
	ldmneia sp!, {r3, r4, pc}
	add r0, sp, #0xc
	add r1, sp, #0
	bl DWC_GetDateTime
	cmp r0, #0
	beq _02174D70
	add r0, sp, #0xc
	add r1, sp, #0
	bl RTC_ConvertDateTimeToSecond
	mov r2, #0
	bl LeaderboardWorker__SetSaveSeconds
_02174D70:
	mov r0, r4
	bl LeaderboardWorker__Func_2175294
	mov r0, r4
	bl LeaderboardWorker__Func_2174E9C
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
	arm_func_end LeaderboardWorker__State_2174CE8

	arm_func_start LeaderboardWorker__Func_2174D88
LeaderboardWorker__Func_2174D88: // 0x02174D88
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl LeaderboardWorker__GetSaveSeconds
	str r0, [r4, #0x1c]
	ldr r0, _02174DA8 // =LeaderboardWorker__State_21749D8
	str r1, [r4, #0x20]
	str r0, [r4, #0x104]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02174DA8: .word LeaderboardWorker__State_21749D8
	arm_func_end LeaderboardWorker__Func_2174D88

	arm_func_start LeaderboardWorker__Func_2174DAC
LeaderboardWorker__Func_2174DAC: // 0x02174DAC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl LeaderboardWorker__GetUserProfile
	bl CreateLeaderboardsManager
	ldr r0, _02174DC8 // =LeaderboardWorker__State_2174A98
	str r0, [r4, #0x104]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02174DC8: .word LeaderboardWorker__State_2174A98
	arm_func_end LeaderboardWorker__Func_2174DAC

	arm_func_start LeaderboardWorker__Func_2174DCC
LeaderboardWorker__Func_2174DCC: // 0x02174DCC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r1, #0x14
	mov r4, r0
	str r1, [sp]
	ldr r0, [r4, #0x24]
	ldr r2, [r4, #0x28]
	add r3, r4, #8
	mov r1, #4 // ROM DIFF: 4 = EU, 2 = US, 1 = JP
	bl PutScoreToLeaderboards
	ldr r0, _02174E04 // =LeaderboardWorker__State_2174B20
	str r0, [r4, #0x104]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02174E04: .word LeaderboardWorker__State_2174B20
	arm_func_end LeaderboardWorker__Func_2174DCC

	arm_func_start LeaderboardWorker__Func_2174E08
LeaderboardWorker__Func_2174E08: // 0x02174E08
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r1, #3
	mov r4, r0
	str r1, [sp]
	mov r2, #0
	ldr r0, [r4, #0x24]
	mov r3, r2
	mov r1, #7
	bl LoadLeaderboardRanksTopList
	ldr r0, _02174E40 // =LeaderboardWorker__State_2174BAC
	str r0, [r4, #0x104]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02174E40: .word LeaderboardWorker__State_2174BAC
	arm_func_end LeaderboardWorker__Func_2174E08

	arm_func_start LeaderboardWorker__Func_2174E44
LeaderboardWorker__Func_2174E44: // 0x02174E44
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r1, #5
	mov r4, r0
	str r1, [sp]
	mov r2, #0
	ldr r0, [r4, #0x24]
	mov r3, r2
	mov r1, #7
	bl LoadLeaderboardRanksNear
	ldr r0, _02174E7C // =LeaderboardWorker__State_2174C54
	str r0, [r4, #0x104]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02174E7C: .word LeaderboardWorker__State_2174C54
	arm_func_end LeaderboardWorker__Func_2174E44

	arm_func_start LeaderboardWorker__Func_2174E80
LeaderboardWorker__Func_2174E80: // 0x02174E80
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DestroyLeaderboardsManager
	ldr r0, _02174E98 // =LeaderboardWorker__State_2174CE8
	str r0, [r4, #0x104]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02174E98: .word LeaderboardWorker__State_2174CE8
	arm_func_end LeaderboardWorker__Func_2174E80

	arm_func_start LeaderboardWorker__Func_2174E9C
LeaderboardWorker__Func_2174E9C: // 0x02174E9C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DestroyLeaderboardsManager
	mov r0, #3
	str r0, [r4]
	mov r0, #0
	str r0, [r4, #0x104]
	ldmia sp!, {r4, pc}
	arm_func_end LeaderboardWorker__Func_2174E9C

	arm_func_start LeaderboardWorker__Func_2174EBC
LeaderboardWorker__Func_2174EBC: // 0x02174EBC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl MultibootManager__Func_2060CC8
	cmp r0, #0
	beq _02174ED8
	ldr r0, [r4, #4]
	bl MultibootManager__Func_2061BF0
_02174ED8:
	bl DestroyLeaderboardsManager
	mov r0, #0
	str r0, [r4]
	str r0, [r4, #0x104]
	ldmia sp!, {r4, pc}
	arm_func_end LeaderboardWorker__Func_2174EBC

	arm_func_start LeaderboardWorker__Func_2174EEC
LeaderboardWorker__Func_2174EEC: // 0x02174EEC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DestroyLeaderboardsManager
	mov r0, #1
	str r0, [r4]
	mov r0, #0
	str r0, [r4, #0x104]
	ldmia sp!, {r4, pc}
	arm_func_end LeaderboardWorker__Func_2174EEC

	arm_func_start LeaderboardWorker__Func_2174F0C
LeaderboardWorker__Func_2174F0C: // 0x02174F0C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DestroyLeaderboardsManager
	mov r0, #3
	str r0, [r4]
	mov r0, #0
	str r0, [r4, #0x104]
	ldmia sp!, {r4, pc}
	arm_func_end LeaderboardWorker__Func_2174F0C

	arm_func_start LeaderboardWorker__GetRankData
LeaderboardWorker__GetRankData: // 0x02174F2C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r1, r6
	mov r0, #0
	mov r2, #0x14
	bl MIi_CpuClear16
	cmp r5, #0
	ldrne r0, [r6, #0]
	add r1, r6, #4
	orrne r0, r0, #1
	strne r0, [r6]
	ldr r0, _02174F98 // =saveGame
	mov r2, #0x10
	bl MIi_CpuCopy16
	mov r0, r4
	bl LeaderboardWorker__GetCharacterID
	cmp r0, #2
	movhs r0, #0
	ldmhsia sp!, {r4, r5, r6, pc}
	cmp r0, #1
	ldreq r0, [r6, #0]
	orreq r0, r0, #2
	streq r0, [r6]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02174F98: .word saveGame
	arm_func_end LeaderboardWorker__GetRankData

	arm_func_start LeaderboardWorker__GetRankCategory
LeaderboardWorker__GetRankCategory: // 0x02174F9C
	bx lr
	arm_func_end LeaderboardWorker__GetRankCategory

	arm_func_start LeaderboardWorker__GetRankScore
LeaderboardWorker__GetRankScore: // 0x02174FA0
	ldr ip, _02174FA8 // =LeaderboardWorker__GetRankScore_Internal
	bx ip
	.align 2, 0
_02174FA8: .word LeaderboardWorker__GetRankScore_Internal
	arm_func_end LeaderboardWorker__GetRankScore

	arm_func_start LeaderboardWorker__LoadRankList1
LeaderboardWorker__LoadRankList1: // 0x02174FAC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	str r0, [sp]
	bl GetLeaderboardsRankCount
	movs r6, r0
	mov r7, #0
	beq _02175040
	ldr r9, [sp]
	mov r4, r7
	mov r0, r9
	add r8, r0, #0x3c
	add r10, r0, #0x40
	mov r11, #0x18
_02174FDC:
	mov r0, r7
	bl GetLeaderboardsRankData
	mov r5, r0
	mov r0, r4
	mov r1, r8
	mov r2, r11
	bl MIi_CpuClear16
	ldr r0, [r5, #0x14]
	cmp r0, #0x14
	bne _02175028
	ldr r0, [r5, #8]
	mov r1, r10
	str r0, [r9, #0x3c]
	ldr r0, [r5, #0x18]
	mov r2, #0x14
	bl MIi_CpuCopy16
	ldr r0, [r9, #0x40]
	orr r0, r0, #0x80000000
	str r0, [r9, #0x40]
_02175028:
	add r7, r7, #1
	cmp r7, r6
	add r8, r8, #0x18
	add r9, r9, #0x18
	add r10, r10, #0x18
	blo _02174FDC
_02175040:
	cmp r7, #3
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp]
	mov r5, #0
	add r1, r0, #0x3c
	mov r0, #0x18
	mla r6, r7, r0, r1
	mov r4, r0
_02175060:
	mov r0, r5
	mov r1, r6
	mov r2, r4
	bl MIi_CpuClear16
	add r7, r7, #1
	cmp r7, #3
	add r6, r6, #0x18
	blt _02175060
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end LeaderboardWorker__LoadRankList1

	arm_func_start LeaderboardWorker__LoadRankList2
LeaderboardWorker__LoadRankList2: // 0x02175084
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	mov r10, r0
	bl GetLeaderboardsRankOrder
	cmp r0, #0
	str r0, [r10, #0x100]
	moveq r0, #0
	addeq sp, sp, #0x18
	streq r0, [r10, #0x100]
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl GetLeaderboardsRankCount
	movs r5, r0
	mov r6, #0
	beq _02175130
	mov r8, r10
	add r7, r10, #0x84
	add r9, r10, #0x88
	mov r11, r6
_021750CC:
	mov r0, r6
	bl GetLeaderboardsRankData
	mov r4, r0
	mov r0, r11
	mov r1, r7
	mov r2, #0x18
	bl MIi_CpuClear16
	ldr r0, [r4, #0x14]
	cmp r0, #0x14
	bne _02175118
	ldr r0, [r4, #8]
	mov r1, r9
	str r0, [r8, #0x84]
	ldr r0, [r4, #0x18]
	mov r2, #0x14
	bl MIi_CpuCopy16
	ldr r0, [r8, #0x88]
	orr r0, r0, #0x80000000
	str r0, [r8, #0x88]
_02175118:
	add r6, r6, #1
	cmp r6, r5
	add r7, r7, #0x18
	add r8, r8, #0x18
	add r9, r9, #0x18
	blo _021750CC
_02175130:
	cmp r6, #5
	bge _0217516C
	mov r0, #0x18
	add r1, r10, #0x84
	mla r7, r6, r0, r1
	mov r5, #0
	mov r4, r0
_0217514C:
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl MIi_CpuClear16
	add r6, r6, #1
	cmp r6, #5
	add r7, r7, #0x18
	blt _0217514C
_0217516C:
	mov r0, #0
	str r0, [r10, #0xfc]
	ldr r0, [r10, #0x88]
	tst r0, #0x80000000
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, [r10, #0xfc]
	cmp r2, #4
	addhs sp, sp, #0x18
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r6, #0x18
	add r9, r10, #0x84
	add r8, sp, #0
	mov r11, r6
	mov r4, r6
	mov r5, r6
	mov r7, r6
_021751B0:
	mul r0, r2, r7
	add r1, r10, r0
	ldr r1, [r1, #0xa0]
	tst r1, #0x80000000
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mla r1, r2, r6, r10
	ldr r2, [r1, #0x84]
	ldr r1, [r1, #0x9c]
	cmp r2, r1
	addge sp, sp, #0x18
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r1, r8
	mov r2, #0x18
	add r0, r9, r0
	bl MIi_CpuCopy16
	ldr r3, [r10, #0xfc]
	mov r2, #0x18
	add r1, r3, #1
	mla r0, r1, r11, r9
	mla r1, r3, r4, r9
	bl MIi_CpuCopy16
	ldr r1, [r10, #0xfc]
	mov r0, r8
	add r3, r1, #1
	mla r1, r3, r5, r9
	mov r2, #0x18
	bl MIi_CpuCopy16
	ldr r0, [r10, #0xfc]
	add r2, r0, #1
	str r2, [r10, #0xfc]
	cmp r2, #4
	blo _021751B0
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end LeaderboardWorker__LoadRankList2

	arm_func_start LeaderboardWorker__GetSaveSeconds
LeaderboardWorker__GetSaveSeconds: // 0x0217523C
	ldr r1, _0217524C // =saveGame
	ldr r0, [r1, #0x20]
	ldr r1, [r1, #0x24]
	bx lr
	.align 2, 0
_0217524C: .word saveGame
	arm_func_end LeaderboardWorker__GetSaveSeconds

	arm_func_start LeaderboardWorker__SetSaveSeconds
LeaderboardWorker__SetSaveSeconds: // 0x02175250
	stmdb sp!, {r3, lr}
	ldr r3, _02175284 // =saveGame
	cmp r2, #0
	str r0, [r3, #0x20]
	str r1, [r3, #0x24]
	beq _0217527C
	mov r0, #6
	bl TrySaveGameData
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
_0217527C:
	mov r0, #1
	ldmia sp!, {r3, pc}
	.align 2, 0
_02175284: .word saveGame
	arm_func_end LeaderboardWorker__SetSaveSeconds

	arm_func_start LeaderboardWorker__GetUserProfile
LeaderboardWorker__GetUserProfile: // 0x02175288
	ldr r0, _02175290 // =0x0213529C
	bx lr
	.align 2, 0
_02175290: .word 0x0213529C
	arm_func_end LeaderboardWorker__GetUserProfile

	arm_func_start LeaderboardWorker__Func_2175294
LeaderboardWorker__Func_2175294: // 0x02175294
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r0
	ldr r0, [r10, #0x38]
	cmp r0, #0
	ldrne r1, [r10, #0x100]
	cmpne r1, #0
	beq _021752CC
	ldr r0, _02175460 // =0x0098967F
	cmp r1, r0
	strhi r0, [r10, #0x100]
	ldr r0, [r10, #0x2c]
	ldr r1, [r10, #0x100]
	bl SaveGame__SaveLeaderboardRankOrder
_021752CC:
	mov r5, #0
	ldr r11, _02175464 // =_0217EF10
	mov r8, r10
	add r9, r10, #0x44
	mov r4, r5
_021752E0:
	ldr r0, [r8, #0x40]
	tst r0, #0x80000000
	bne _0217530C
	stmia sp, {r4, r7}
	mov r1, r5, lsl #0x10
	ldr r0, [r10, #0x2c]
	mov r2, r11
	mov r3, r4
	mov r1, r1, lsr #0x10
	bl SaveGame__SaveLeaderboardRank_Top
	b _02175360
_0217530C:
	tst r0, #2
	movne r7, #1
	moveq r7, #0
	mov r6, #0
_0217531C:
	add r0, r8, r6, lsl #1
	ldrh r0, [r0, #0x44]
	cmp r0, #0
	beq _02175338
	add r6, r6, #1
	cmp r6, #8
	blt _0217531C
_02175338:
	ldr r0, [r8, #0x3c]
	bl LeaderboardWorker__Func_21754E8
	mov r1, r6, lsl #0x10
	mov r3, r1, lsr #0x10
	stmia sp, {r0, r7}
	mov r1, r5, lsl #0x10
	ldr r0, [r10, #0x2c]
	mov r1, r1, lsr #0x10
	mov r2, r9
	bl SaveGame__SaveLeaderboardRank_Top
_02175360:
	add r5, r5, #1
	cmp r5, #3
	add r8, r8, #0x18
	add r9, r9, #0x18
	blt _021752E0
	mov r4, r10
	add r5, r10, #0x8c
	mov r6, #0
_02175380:
	ldr r0, [r10, #0x38]
	cmp r0, #0
	beq _021753A0
	ldr r1, [r4, #0x88]
	tst r1, #0x80000000
	ldrne r0, [r10, #0x100]
	cmpne r0, #0
	bne _021753C0
_021753A0:
	mov r3, #0
	stmia sp, {r3, r7}
	mov r1, r6, lsl #0x10
	ldr r0, [r10, #0x2c]
	ldr r2, _02175464 // =_0217EF10
	mov r1, r1, lsr #0x10
	bl SaveGame__SaveLeaderboardRank_Near
	b _0217543C
_021753C0:
	ldr r0, [r4, #0x84]
	tst r1, #2
	movne r7, #1
	moveq r7, #0
	bl LeaderboardWorker__Func_21754E8
	ldr r1, [r10, #0xfc]
	mov r2, #0
	cmp r6, r1
	bne _02175400
	stmia sp, {r0, r7}
	mov r1, r6, lsl #0x10
	ldr r0, [r10, #0x2c]
	mov r3, r2
	mov r1, r1, lsr #0x10
	bl SaveGame__SaveLeaderboardRank_Near
	b _0217543C
_02175400:
	add r1, r4, r2, lsl #1
	ldrh r1, [r1, #0x8c]
	cmp r1, #0
	beq _0217541C
	add r2, r2, #1
	cmp r2, #8
	blt _02175400
_0217541C:
	mov r3, r2, lsl #0x10
	stmia sp, {r0, r7}
	mov r1, r6, lsl #0x10
	ldr r0, [r10, #0x2c]
	mov r2, r5
	mov r1, r1, lsr #0x10
	mov r3, r3, lsr #0x10
	bl SaveGame__SaveLeaderboardRank_Near
_0217543C:
	add r6, r6, #1
	cmp r6, #5
	add r4, r4, #0x18
	add r5, r5, #0x18
	blt _02175380
	ldr r0, [r10, #0x2c]
	bl SaveGame__SetLeaderboardLastUpdatedTime
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02175460: .word 0x0098967F
_02175464: .word _0217EF10
	arm_func_end LeaderboardWorker__Func_2175294

	arm_func_start LeaderboardWorker__GetRankScore_Internal
LeaderboardWorker__GetRankScore_Internal: // 0x02175468
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl LeaderboardWorker__GetStageID
	mov r4, r0
	mov r0, r5
	bl LeaderboardWorker__GetCharacterID
	mov r1, r0
	cmp r1, #2
	mvnhs r0, #0
	ldmhsia sp!, {r3, r4, r5, pc}
	ldr r0, _021754DC // =0x02134CE4
	mov r2, r4
	and r1, r1, #0xff
	mov r3, #1
	bl SaveGame__GetTimeAttackRecord
	cmp r0, #1
	ldr r1, _021754E0 // =0x00008C9F
	movlt r0, #1
	cmp r0, r1
	movgt r0, r1
	ldr r2, _021754E4 // =0x0213513C
	mov r3, r5, lsl #1
	ldr r1, _021754E0 // =0x00008C9F
	ldrh r3, [r2, r3]
	sub r2, r1, #0xca0
	sub r1, r1, r0
	and r0, r3, r2
	orr r0, r0, r1, lsl #15
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021754DC: .word 0x02134CE4
_021754E0: .word 0x00008C9F
_021754E4: .word 0x0213513C
	arm_func_end LeaderboardWorker__GetRankScore_Internal

	arm_func_start LeaderboardWorker__Func_21754E8
LeaderboardWorker__Func_21754E8: // 0x021754E8
	ldr r1, _02175510 // =0x00008C9F
	sub r0, r1, r0, asr #15
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	ldr r1, _02175510 // =0x00008C9F
	movlo r0, #1
	cmp r0, r1
	movhi r0, r1
	bx lr
	.align 2, 0
_02175510: .word 0x00008C9F
	arm_func_end LeaderboardWorker__Func_21754E8

	arm_func_start LeaderboardWorker__GetCharacterID
LeaderboardWorker__GetCharacterID: // 0x02175514
	stmdb sp!, {r4, r5, r6, lr}
	bl LeaderboardWorker__GetStageID
	mov r4, r0
	ldr r5, _021755A8 // =0x02134CE4
	mov r2, r4
	mov r0, r5
	mov r1, #0
	mov r3, #1
	bl SaveGame__GetTimeAttackRecord
	mov r1, #1
	mov r6, r0
	mov r0, r5
	mov r2, r4
	mov r3, r1
	bl SaveGame__GetTimeAttackRecord
	cmp r6, #0
	cmpne r0, #0
	beq _0217558C
	mov r0, r4, asr #3
	add r0, r4, r0, lsr #28
	mov r0, r0, asr #4
	add r0, r5, r0, lsl #1
	add r0, r0, #0x400
	mov r2, r4, lsr #0x1f
	ldrh r3, [r0, #0x50]
	rsb r1, r2, r4, lsl #28
	add r0, r2, r1, ror #28
	mov r0, r3, asr r0
	and r0, r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0217558C:
	cmp r6, #0
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	cmp r0, #0
	movne r0, #1
	ldreq r0, _021755AC // =0x0000FFFF
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021755A8: .word 0x02134CE4
_021755AC: .word 0x0000FFFF
	arm_func_end LeaderboardWorker__GetCharacterID

	arm_func_start LeaderboardWorker__GetStageID
LeaderboardWorker__GetStageID: // 0x021755B0
	mov r1, r0, lsr #0x1f
	add r2, r0, r0, lsr #31
	rsb r0, r1, r0, lsl #31
	mov r2, r2, asr #1
	add r1, r1, r0, ror #31
	add r0, r2, r2, lsl #1
	add r0, r1, r0
	bx lr
	arm_func_end LeaderboardWorker__GetStageID

	.data
	
_0217EF10: // 0x0217EF10
	.hword 0x00, 0x00
	.align 4
