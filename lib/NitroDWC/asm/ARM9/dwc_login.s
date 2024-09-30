	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWCi_CheckLogin
DWCi_CheckLogin: // 0x0209127C
	ldr r0, _020912A4 // =0x02143B9C
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _0209129C
	ldr r0, [r0, #4]
	cmp r0, #5
	moveq r0, #1
	bxeq lr
_0209129C:
	mov r0, #0
	bx lr
	.align 2, 0
_020912A4: .word 0x02143B9C
	arm_func_end DWCi_CheckLogin

	arm_func_start DWCi_GPGetInfoCallback
DWCi_GPGetInfoCallback: // 0x020912A8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x4c
	mov r4, r1
	ldr r1, [r4, #0]
	mov r5, r0
	cmp r1, #0
	addne sp, sp, #0x4c
	ldmneia sp!, {r4, r5, pc}
	ldr r1, _0209144C // =0x02143B9C
	ldr r2, [r1, #0]
	ldr r1, [r2, #4]
	cmp r1, #3
	bne _02091384
	ldrsb r1, [r4, #0x8e]
	cmp r1, #0
	bne _0209135C
	ldr r0, [r2, #0x1c]
	ldr r1, [r2, #0xc]
	add r2, sp, #8
	add r0, r0, #4
	bl DWCi_Acc_LoginIdToUserName
	ldr r1, _02091450 // =0x00000705
	add r2, sp, #8
	mov r0, r5
	bl sub_20A57F8
	bl DWCi_HandleGPError
	cmp r0, #0
	addne sp, sp, #0x4c
	ldmneia sp!, {r4, r5, pc}
	ldr r0, _0209144C // =0x02143B9C
	mov r3, #4
	ldr r1, [r0, #0]
	ldr r0, _02091454 // =DWCi_GPGetInfoCallback
	str r3, [r1, #4]
	mov r2, #0
	str r0, [sp]
	str r2, [sp, #4]
	ldr r1, [r4, #4]
	mov r0, r5
	mov r3, r2
	bl gpGetInfo
	bl DWCi_HandleGPError
	add sp, sp, #0x4c
	cmp r0, #0
	ldmia sp!, {r4, r5, pc}
_0209135C:
	bl gpDisconnect
	ldr r0, _02091458 // =DWCi_RemoteAuthCallback
	mov r1, #0
	bl DWCi_RemoteLogin
	ldr r0, _0209144C // =0x02143B9C
	mov r1, #1
	ldr r0, [r0, #0]
	add sp, sp, #0x4c
	str r1, [r0, #4]
	ldmia sp!, {r4, r5, pc}
_02091384:
	cmp r1, #4
	addne sp, sp, #0x4c
	ldmneia sp!, {r4, r5, pc}
	ldr r0, [r2, #0x1c]
	ldr r1, [r2, #0xc]
	add r2, sp, #0x1d
	add r0, r0, #4
	bl DWCi_Acc_LoginIdToUserName
	add r1, sp, #0x1d
	add r0, r4, #0x8e
	bl strcmp
	cmp r0, #0
	bne _0209141C
	ldr r0, _0209144C // =0x02143B9C
	add r2, sp, #0x32
	ldr r0, [r0, #0]
	ldr r1, [r0, #0xc]
	add r0, r0, #0x3c
	bl DWCi_Acc_LoginIdToUserName
	ldr r0, _0209144C // =0x02143B9C
	ldr r2, [r4, #4]
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x1c]
	add r1, r1, #0x3c
	bl DWCi_Acc_SetLoginIdToUserData
	mov r0, r5
	bl gpDisconnect
	ldr r0, _0209144C // =0x02143B9C
	ldr r1, _0209145C // =0x02143B98
	ldr r4, [r0, #0]
	ldr r0, _02091460 // =0x02143BA0
	ldr r2, [r1, #0]
	ldr r3, [r0, #0]
	add r0, r4, #0x48
	add r1, r4, #0x148
	blx r3
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_0209141C:
	ldr r0, _02091454 // =DWCi_GPGetInfoCallback
	mov r2, #0
	str r0, [sp]
	str r2, [sp, #4]
	ldr r1, [r4, #4]
	mov r0, r5
	mov r3, r2
	bl gpGetInfo
	bl DWCi_HandleGPError
	cmp r0, #0
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0209144C: .word 0x02143B9C
_02091450: .word 0x00000705
_02091454: .word DWCi_GPGetInfoCallback
_02091458: .word DWCi_RemoteAuthCallback
_0209145C: .word 0x02143B98
_02091460: .word 0x02143BA0
	arm_func_end DWCi_GPGetInfoCallback

	arm_func_start DWCi_RemoteLoginProcess
DWCi_RemoteLoginProcess: // 0x02091464
	stmdb sp!, {lr}
	sub sp, sp, #0x3d4
	bl DWC_Auth_GetError
	cmp r0, #0x15
	bne _0209153C
	add r0, sp, #0
	bl DWC_Auth_GetResult
	ldr r0, _0209165C // =0x02143B9C
	add r1, sp, #0x4a
	ldr r0, [r0, #0]
	add r0, r0, #0x48
	bl strcpy
	ldr r0, _0209165C // =0x02143B9C
	add r1, sp, #0x100
	ldr r0, [r0, #0]
	add r1, r1, #0x77
	add r0, r0, #0x148
	bl strcpy
	bl DWC_Auth_Destroy
	ldr r1, _0209165C // =0x02143B9C
	mov r0, #0
	ldr r1, [r1, #0]
	mov r2, r0
	ldr r1, [r1, #0x24]
	bl DWC_Free
	ldr r0, _0209165C // =0x02143B9C
	mov r2, #0
	ldr r1, [r0, #0]
	str r2, [r1, #0x24]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x1c]
	bl DWCi_Acc_IsAuthentic
	cmp r0, #0
	beq _02091518
	ldr r0, _0209165C // =0x02143B9C
	ldr r1, _02091660 // =0x02143B98
	ldr ip, [r0]
	ldr r0, _02091664 // =0x02143BA0
	ldr r2, [r1, #0]
	ldr r3, [r0, #0]
	add r0, ip, #0x48
	add r1, ip, #0x148
	blx r3
	add sp, sp, #0x3d4
	ldmia sp!, {pc}
_02091518:
	ldr r0, _0209165C // =0x02143B9C
	ldr r2, _02091668 // =DWCi_GPConnectCallback
	ldr r1, [r0, #0]
	mov r3, #3
	add r0, r1, #0x48
	add r1, r1, #0x148
	bl DWCi_GPConnect
	add sp, sp, #0x3d4
	ldmia sp!, {pc}
_0209153C:
	bl DWC_Auth_GetError
	cmp r0, #0
	addeq sp, sp, #0x3d4
	ldmeqia sp!, {pc}
	bl OS_GetTick
	ldr r3, _0209165C // =0x02143B9C
	ldr r2, _0209166C // =0x000082EA
	ldr ip, [r3]
	mov r3, #0
	ldr lr, [ip, #0x28]
	ldr ip, [ip, #0x2c]
	subs lr, r0, lr
	sbc r0, r1, ip
	mov r1, r0, lsl #6
	orr r1, r1, lr, lsr #26
	mov r0, lr, lsl #6
	bl _ll_udiv
	ldr r2, _02091670 // =0x00002710
	cmp r1, #0
	cmpeq r0, r2
	bls _020915D8
	add r0, sp, #0x1c4
	bl DWC_Auth_GetResult
	bl DWC_Auth_Destroy
	ldr r1, _0209165C // =0x02143B9C
	mov r0, #0
	ldr r1, [r1, #0]
	mov r2, r0
	ldr r1, [r1, #0x24]
	bl DWC_Free
	ldr r0, _0209165C // =0x02143B9C
	mov r2, #0
	ldr r1, [r0, #0]
	mov r0, #2
	str r2, [r1, #0x24]
	ldr r1, [sp, #0x1c4]
	bl DWCi_StopLogin
	add sp, sp, #0x3d4
	ldmia sp!, {pc}
_020915D8:
	bl DWC_Auth_Destroy
	add r0, sp, #0x388
	mov r1, #0
	mov r2, #0x48
	bl MI_CpuFill8
	ldr r0, _0209165C // =0x02143B9C
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x10]
	bl DWCi_WStrLen
	ldr r1, _0209165C // =0x02143B9C
	mov r2, r0, lsl #1
	ldr r1, [r1, #0]
	add r2, r2, #2
	ldr r0, [r1, #0x10]
	add r1, sp, #0x388
	bl MI_CpuCopy8
	ldr r0, _0209165C // =0x02143B9C
	ldr r1, _02091674 // =0x00000251
	ldr r2, [r0, #0]
	add r0, sp, #0x3bc
	add r1, r2, r1
	bl strcpy
	ldr r2, _02091678 // =DWC_Alloc
	ldr r0, _0209165C // =0x02143B9C
	str r2, [sp, #0x3c8]
	ldr r2, _0209167C // =DWC_Free
	ldr r1, [r0, #0]
	str r2, [sp, #0x3cc]
	ldr r1, [r1, #0x24]
	add r0, sp, #0x388
	bl DWC_Auth_Create
	add sp, sp, #0x3d4
	ldmia sp!, {pc}
	.align 2, 0
_0209165C: .word 0x02143B9C
_02091660: .word 0x02143B98
_02091664: .word 0x02143BA0
_02091668: .word DWCi_GPConnectCallback
_0209166C: .word 0x000082EA
_02091670: .word 0x00002710
_02091674: .word 0x00000251
_02091678: .word DWC_Alloc
_0209167C: .word DWC_Free
	arm_func_end DWCi_RemoteLoginProcess

	arm_func_start DWCi_RemoteLogin
DWCi_RemoteLogin: // 0x02091680
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x4c
	mov r5, r0
	mov r4, r1
	add r0, sp, #0
	mov r1, #0
	mov r2, #0x48
	bl MI_CpuFill8
	ldr r0, _02091838 // =0x02143B9C
	ldr r2, _0209183C // =0x02143BA0
	ldr r1, _02091840 // =0x02143B98
	ldr r0, [r0, #0]
	str r5, [r2]
	str r4, [r1]
	ldr r0, [r0, #0x1c]
	bl DWCi_Acc_IsAuthentic
	cmp r0, #0
	beq _020916E8
	ldr r0, _02091838 // =0x02143B9C
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x1c]
	add r2, r1, #0x248
	ldr r1, [r0, #0x24]
	add r0, r0, #0x10
	bl DWCi_Acc_LoginIdToUserName
	b _0209179C
_020916E8:
	ldr r0, _02091838 // =0x02143B9C
	ldr r0, [r0, #0]
	add r0, r0, #0x3c
	bl DWCi_Acc_IsValidLoginId
	cmp r0, #0
	bne _02091750
	ldr r0, _02091838 // =0x02143B9C
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x1c]
	add r0, r0, #4
	bl DWCi_Acc_CheckConsoleUserId
	cmp r0, #0
	beq _0209173C
	ldr r0, _02091838 // =0x02143B9C
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x1c]
	add r3, r1, #0x3c
	add r0, r0, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	b _02091784
_0209173C:
	ldr r0, _02091838 // =0x02143B9C
	ldr r0, [r0, #0]
	add r0, r0, #0x3c
	bl DWCi_Acc_CreateTempLoginId
	b _02091784
_02091750:
	bl OS_GetTick
	ldr r2, _02091844 // =0x6C078965
	ldr r3, _02091848 // =0x5D588B65
	umull ip, r4, r0, r2
	mla r4, r0, r3, r4
	ldr r3, _02091838 // =0x02143B9C
	ldr r0, _0209184C // =0x00269EC3
	mla r4, r1, r2, r4
	adds r0, ip, r0
	ldr r3, [r3, #0]
	adc r1, r4, #0
	add r0, r3, #0x3c
	bl DWCi_Acc_SetPlayerId
_02091784:
	ldr r0, _02091838 // =0x02143B9C
	ldr r2, [r0, #0]
	ldr r1, [r2, #0xc]
	add r0, r2, #0x3c
	add r2, r2, #0x248
	bl DWCi_Acc_LoginIdToUserName
_0209179C:
	ldr r0, _02091838 // =0x02143B9C
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x10]
	bl DWCi_WStrLen
	ldr r1, _02091838 // =0x02143B9C
	mov r2, r0, lsl #1
	ldr r1, [r1, #0]
	add r2, r2, #2
	ldr r0, [r1, #0x10]
	add r1, sp, #0
	bl MI_CpuCopy8
	ldr r0, _02091838 // =0x02143B9C
	ldr r1, _02091850 // =0x00000251
	ldr r2, [r0, #0]
	add r0, sp, #0x34
	add r1, r2, r1
	bl strcpy
	ldr r4, _02091854 // =DWC_Alloc
	ldr r3, _02091858 // =DWC_Free
	ldr r1, _0209185C // =0x00001C14
	mov r0, #0
	mov r2, #4
	str r4, [sp, #0x40]
	str r3, [sp, #0x44]
	bl DWC_AllocEx
	ldr r1, _02091838 // =0x02143B9C
	mov r4, r0
	ldr r0, [r1, #0]
	str r4, [r0, #0x24]
	bl OS_GetTick
	ldr r2, _02091838 // =0x02143B9C
	ldr r2, [r2, #0]
	str r0, [r2, #0x28]
	str r1, [r2, #0x2c]
	mov r1, r4
	add r0, sp, #0
	bl DWC_Auth_Create
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02091838: .word 0x02143B9C
_0209183C: .word 0x02143BA0
_02091840: .word 0x02143B98
_02091844: .word 0x6C078965
_02091848: .word 0x5D588B65
_0209184C: .word 0x00269EC3
_02091850: .word 0x00000251
_02091854: .word DWC_Alloc
_02091858: .word DWC_Free
_0209185C: .word 0x00001C14
	arm_func_end DWCi_RemoteLogin

	arm_func_start DWCi_GPConnect
DWCi_GPConnect: // 0x02091860
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	ldr r4, _020918FC // =0x02143B9C
	mov r6, r1
	ldr r4, [r4, #0]
	mov r1, r0
	add r0, r4, #0x48
	mov r5, r2
	mov r4, r3
	bl strcpy
	ldr r0, _020918FC // =0x02143B9C
	mov r1, r6
	ldr r0, [r0, #0]
	add r0, r0, #0x148
	bl strcpy
	ldr r0, _020918FC // =0x02143B9C
	ldr r6, [r0, #0]
	bl OS_GetTick
	str r0, [r6, #0x34]
	str r1, [r6, #0x38]
	mov r3, #1
	ldr r0, _020918FC // =0x02143B9C
	str r3, [r6, #0x30]
	ldr r2, [r0, #0]
	mov r1, #0
	str r1, [sp]
	str r5, [sp, #4]
	str r1, [sp, #8]
	ldr r0, [r2, #0]
	add r1, r2, #0x48
	add r2, r2, #0x148
	bl gpConnectPreAuthenticatedA
	bl DWCi_HandleGPError
	cmp r0, #0
	ldreq r0, _020918FC // =0x02143B9C
	ldreq r0, [r0, #0]
	streq r4, [r0, #4]
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020918FC: .word 0x02143B9C
	arm_func_end DWCi_GPConnect

	arm_func_start DWCi_RemoteAuthCallback
DWCi_RemoteAuthCallback: // 0x02091900
	ldr ip, _02091910 // =DWCi_GPConnect
	ldr r2, _02091914 // =DWCi_GPConnectCallback
	mov r3, #2
	bx ip
	.align 2, 0
_02091910: .word DWCi_GPConnect
_02091914: .word DWCi_GPConnectCallback
	arm_func_end DWCi_RemoteAuthCallback

	arm_func_start DWCi_GPConnectCallback
DWCi_GPConnectCallback: // 0x02091918
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r3, _02091A20 // =0x02143B9C
	mov r2, #0
	ldr ip, [r3]
	mov r4, r1
	str r2, [ip, #0x30]
	ldr r1, [r4, #0]
	cmp r1, #0
	bne _02091A10
	ldr ip, [r3]
	ldr r1, [ip, #4]
	cmp r1, #2
	bne _020919DC
	ldr r1, [ip, #0x1c]
	ldr r0, [r4, #4]
	ldr r1, [r1, #0x1c]
	cmp r1, r0
	bne _020919C8
	ldr r1, _02091A24 // =0x0211C200
	mov r3, #5
	mov r0, #1
	str r3, [ip, #4]
	bl DWCi_SetGPStatus
	bl DWCi_HandleGPError
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	ldr r0, _02091A20 // =0x02143B9C
	ldr r1, [r4, #4]
	ldr r3, [r0, #0]
	mov r0, #0
	ldr r2, [r3, #0x18]
	ldr r3, [r3, #0x14]
	blx r3
	bl DWCi_GT2Startup
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #4]
	bl DWCi_QR2Startup
	add sp, sp, #8
	cmp r0, #0
	ldmia sp!, {r4, pc}
_020919C8:
	ldr r1, _02091A28 // =0xFFFF15A0
	mov r0, #6
	bl DWCi_StopLogin
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_020919DC:
	cmp r1, #3
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	ldr r1, _02091A2C // =DWCi_GPGetInfoCallback
	mov r3, r2
	str r1, [sp]
	str r2, [sp, #4]
	ldr r1, [r4, #4]
	bl gpGetInfo
	bl DWCi_HandleGPError
	add sp, sp, #8
	cmp r0, #0
	ldmia sp!, {r4, pc}
_02091A10:
	mov r0, r1
	bl DWCi_HandleGPError
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02091A20: .word 0x02143B9C
_02091A24: .word 0x0211C200
_02091A28: .word 0xFFFF15A0
_02091A2C: .word DWCi_GPGetInfoCallback
	arm_func_end DWCi_GPConnectCallback

	arm_func_start DWCi_HandleGPError
DWCi_HandleGPError: // 0x02091A30
	stmdb sp!, {r4, lr}
	movs r4, r0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	cmp r4, #4
	addls pc, pc, r4, lsl #2
	b _02091A8C
_02091A4C: // jump table
	b _02091A8C // case 0
	b _02091A60 // case 1
	b _02091A6C // case 2
	b _02091A78 // case 3
	b _02091A84 // case 4
_02091A60:
	mov r0, #9
	mvn r2, #0
	b _02091A8C
_02091A6C:
	mov r0, #9
	mvn r2, #1
	b _02091A8C
_02091A78:
	mov r0, #6
	mvn r2, #9
	b _02091A8C
_02091A84:
	mov r0, #6
	mvn r2, #0x13
_02091A8C:
	ldr r1, _02091AA0 // =0xFFFF11B8
	add r1, r2, r1
	bl DWCi_StopLogin
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02091AA0: .word 0xFFFF11B8
	arm_func_end DWCi_HandleGPError

	arm_func_start DWCi_CloseLogin
DWCi_CloseLogin: // 0x02091AA4
	ldr r0, _02091AC4 // =0x02143B9C
	ldr r2, [r0, #0]
	cmp r2, #0
	movne r1, #0
	strne r1, [r2, #4]
	ldrne r0, [r0, #0]
	strne r1, [r0, #0x30]
	bx lr
	.align 2, 0
_02091AC4: .word 0x02143B9C
	arm_func_end DWCi_CloseLogin

	arm_func_start DWCi_ShutdownLogin
DWCi_ShutdownLogin: // 0x02091AC8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02091B28 // =0x02143B9C
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x24]
	cmp r0, #0
	beq _02091B14
	bl DWC_Auth_Abort
	bl DWC_Auth_Destroy
	ldr r1, _02091B28 // =0x02143B9C
	mov r0, #0
	ldr r1, [r1, #0]
	mov r2, r0
	ldr r1, [r1, #0x24]
	bl DWC_Free
	ldr r0, _02091B28 // =0x02143B9C
	mov r1, #0
	ldr r0, [r0, #0]
	str r1, [r0, #0x24]
_02091B14:
	ldr r0, _02091B28 // =0x02143B9C
	mov r1, #0
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02091B28: .word 0x02143B9C
	arm_func_end DWCi_ShutdownLogin

	arm_func_start DWCi_StopLogin
DWCi_StopLogin: // 0x02091B2C
	stmdb sp!, {r4, lr}
	ldr r2, _02091B7C // =0x02143B9C
	mov r4, r0
	ldr r2, [r2, #0]
	cmp r2, #0
	ldmeqia sp!, {r4, pc}
	cmp r4, #0
	ldmeqia sp!, {r4, pc}
	bl DWCi_SetError
	ldr r0, _02091B7C // =0x02143B9C
	ldr r0, [r0, #0]
	ldr r3, [r0, #0x14]
	cmp r3, #0
	beq _02091B74
	ldr r2, [r0, #0x18]
	mov r0, r4
	mov r1, #0
	blx r3
_02091B74:
	bl DWCi_CloseLogin
	ldmia sp!, {r4, pc}
	.align 2, 0
_02091B7C: .word 0x02143B9C
	arm_func_end DWCi_StopLogin

	arm_func_start DWCi_GetUserData
DWCi_GetUserData: // 0x02091B80
	ldr r0, _02091B98 // =0x02143B9C
	ldr r0, [r0, #0]
	cmp r0, #0
	ldrne r0, [r0, #0x1c]
	moveq r0, #0
	bx lr
	.align 2, 0
_02091B98: .word 0x02143B9C
	arm_func_end DWCi_GetUserData

	arm_func_start DWCi_LoginProcess
DWCi_LoginProcess: // 0x02091B9C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02091CA4 // =0x02143B9C
	ldr r0, [r0, #0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02091CA4 // =0x02143B9C
	ldr r1, [r0, #0]
	ldr r0, [r1, #4]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02091C9C
_02091BE0: // jump table
	b _02091C9C // case 0
	b _02091BF8 // case 1
	b _02091C04 // case 2
	b _02091C04 // case 3
	b _02091C04 // case 4
	b _02091C9C // case 5
_02091BF8:
	bl DWCi_RemoteLoginProcess
	add sp, sp, #4
	ldmia sp!, {pc}
_02091C04:
	ldr r0, [r1, #0]
	cmp r0, #0
	beq _02091C20
	ldr r1, [r0, #0]
	cmp r1, #0
	beq _02091C20
	bl gpProcess
_02091C20:
	ldr r0, _02091CA4 // =0x02143B9C
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x30]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl OS_GetTick
	ldr r3, _02091CA4 // =0x02143B9C
	ldr r2, _02091CA8 // =0x000082EA
	ldr ip, [r3]
	mov r3, #0
	ldr lr, [ip, #0x34]
	ldr ip, [ip, #0x38]
	subs lr, r0, lr
	sbc r0, r1, ip
	mov r1, r0, lsl #6
	orr r1, r1, lr, lsr #26
	mov r0, lr, lsl #6
	bl _ll_udiv
	ldr r2, _02091CAC // =0x0000EA60
	cmp r1, #0
	cmpeq r0, r2
	addls sp, sp, #4
	ldmlsia sp!, {pc}
	ldr r1, _02091CB0 // =0xFFFF1172
	mov r0, #6
	bl DWCi_StopLogin
	ldr r0, _02091CA4 // =0x02143B9C
	mov r1, #0
	ldr r0, [r0, #0]
	str r1, [r0, #0x30]
_02091C9C:
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02091CA4: .word 0x02143B9C
_02091CA8: .word 0x000082EA
_02091CAC: .word 0x0000EA60
_02091CB0: .word 0xFFFF1172
	arm_func_end DWCi_LoginProcess

	arm_func_start DWCi_LoginAsync
DWCi_LoginAsync: // 0x02091CB4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02091CEC // =DWCi_RemoteAuthCallback
	mov r1, #0
	bl DWCi_RemoteLogin
	ldr r0, _02091CF0 // =0x02143B9C
	mov r3, #1
	ldr r2, [r0, #0]
	mov r1, #0
	str r3, [r2, #4]
	ldr r0, [r0, #0]
	str r1, [r0, #0x30]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02091CEC: .word DWCi_RemoteAuthCallback
_02091CF0: .word 0x02143B9C
	arm_func_end DWCi_LoginAsync

	arm_func_start DWCi_LoginInit
DWCi_LoginInit: // 0x02091CF4
	stmdb sp!, {r4, r5, r6, lr}
	ldr ip, _02091D74 // =0x02143B9C
	mov r6, r1
	mov r5, r2
	mov r1, #0
	mov r2, #0x260
	mov r4, r3
	str r0, [ip]
	bl MI_CpuFill8
	ldr r0, _02091D74 // =0x02143B9C
	mov r2, #0
	ldr r1, [r0, #0]
	ldr ip, [sp, #0x10]
	str r5, [r1]
	ldr r1, [r0, #0]
	ldr r5, [sp, #0x14]
	str r2, [r1, #4]
	ldr r1, [r0, #0]
	ldr r3, [sp, #0x18]
	str r4, [r1, #8]
	ldr r1, [r0, #0]
	ldr r2, [sp, #0x1c]
	str ip, [r1, #0xc]
	ldr r1, [r0, #0]
	str r5, [r1, #0x10]
	ldr r1, [r0, #0]
	str r3, [r1, #0x14]
	ldr r1, [r0, #0]
	str r2, [r1, #0x18]
	ldr r0, [r0, #0]
	str r6, [r0, #0x1c]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02091D74: .word 0x02143B9C
	arm_func_end DWCi_LoginInit
