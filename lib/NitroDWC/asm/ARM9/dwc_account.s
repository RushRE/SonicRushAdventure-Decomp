	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWC_IsEqualFriendData
DWC_IsEqualFriendData: // 0x0209D5B4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r7, r0
	bl DWCi_Acc_GetFlag_DataType
	mov r5, r0
	mov r0, r4
	bl DWCi_Acc_GetFlag_DataType
	cmp r5, r0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
	cmp r5, #3
	bne _0209D614
	mov r0, r7
	bl DWCi_Acc_GetGsProfileId
	mov r5, r0
	mov r0, r4
	bl DWCi_Acc_GetGsProfileId
	cmp r5, r0
	moveq r0, #1
	add sp, sp, #4
	movne r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209D614:
	cmp r5, #1
	bne _0209D670
	mov r0, r7
	bl DWCi_Acc_GetUserId
	mov r5, r0
	mov r6, r1
	mov r0, r4
	bl DWCi_Acc_GetUserId
	cmp r6, r1
	cmpeq r5, r0
	bne _0209D664
	mov r0, r7
	bl DWCi_Acc_GetPlayerId
	mov r5, r0
	mov r0, r4
	bl DWCi_Acc_GetPlayerId
	cmp r5, r0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_0209D664:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209D670:
	cmp r5, #2
	bne _0209D6A8
	mov r0, r7
	bl DWCi_Acc_GetFriendKey
	mov r5, r0
	mov r6, r1
	mov r0, r4
	bl DWCi_Acc_GetFriendKey
	cmp r6, r1
	cmpeq r5, r0
	moveq r0, #1
	add sp, sp, #4
	movne r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209D6A8:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end DWC_IsEqualFriendData

	arm_func_start DWC_LoginIdToUserName
DWC_LoginIdToUserName: // 0x0209D6B4
	ldr ip, _0209D6C8 // =DWCi_Acc_LoginIdToUserName
	mov r3, r0
	mov r0, r1
	ldr r1, [r3, #0x24]
	bx ip
	.align 2, 0
_0209D6C8: .word DWCi_Acc_LoginIdToUserName
	arm_func_end DWC_LoginIdToUserName

	arm_func_start DWC_SetGsProfileId
DWC_SetGsProfileId: // 0x0209D6CC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r5, r0
	mov r1, #0
	mov r2, #0xc
	bl MI_CpuFill8
	mov r0, r5
	mov r1, r4
	bl DWCi_Acc_SetGsProfileId
	mov r0, r5
	mov r1, #3
	bl DWCi_Acc_SetFlag_DataType
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWC_SetGsProfileId

	arm_func_start DWC_CreateExchangeToken
DWC_CreateExchangeToken: // 0x0209D708
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r5, r0
	mov r0, r4
	mov r1, #0
	mov r2, #0xc
	bl MI_CpuFill8
	mov r0, r5
	bl DWCi_Acc_IsAuthentic
	cmp r0, #0
	addeq r0, r5, #4
	ldmeqia r0, {r0, r1, r2}
	addeq sp, sp, #4
	stmeqia r4, {r0, r1, r2}
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, [r5, #0x1c]
	mov r0, r4
	bl DWCi_Acc_SetGsProfileId
	mov r0, r4
	mov r1, #3
	bl DWCi_Acc_SetFlag_DataType
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWC_CreateExchangeToken

	arm_func_start DWC_CreateFriendKeyToken
DWC_CreateFriendKeyToken: // 0x0209D768
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r4, r2
	mov r6, r0
	mov r1, #0
	mov r2, #0xc
	bl MI_CpuFill8
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl DWCi_Acc_SetFriendKey
	mov r0, r6
	mov r1, #2
	bl DWCi_Acc_SetFlag_DataType
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWC_CreateFriendKeyToken

	arm_func_start DWC_CreateFriendKey
DWC_CreateFriendKey: // 0x0209D7A4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r3, r0
	ldr r0, [r3, #0x1c]
	mov r2, #0
	mov r1, r2
	cmp r0, #0
	beq _0209D7D0
	ldr r1, [r3, #0x24]
	bl DWC_Acc_CreateFriendKey
	mov r2, r0
_0209D7D0:
	mov r0, r2
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWC_CreateFriendKey

	arm_func_start DWC_GetGsProfileId
DWC_GetGsProfileId: // 0x0209D7DC
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r1
	mov r6, r0
	mov r0, r4
	bl DWCi_Acc_GetFlag_DataType
	cmp r0, #1
	beq _0209D850
	cmp r0, #2
	beq _0209D80C
	cmp r0, #3
	beq _0209D844
	b _0209D858
_0209D80C:
	mov r0, r4
	bl DWCi_Acc_GetFriendKey
	ldr r2, [r6, #0x24]
	mov r4, r0
	mov r5, r1
	bl DWC_Acc_CheckFriendKey
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r2, [r6, #0x24]
	mov r0, r4
	mov r1, r5
	bl DWC_Acc_FriendKeyToGsProfileId
	ldmia sp!, {r4, r5, r6, pc}
_0209D844:
	mov r0, r4
	bl DWCi_Acc_GetGsProfileId
	ldmia sp!, {r4, r5, r6, pc}
_0209D850:
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0209D858:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWC_GetGsProfileId

	arm_func_start DWCi_Acc_ClearDirty
DWCi_Acc_ClearDirty: // 0x0209D860
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x400
	mov r4, r0
	ldr r1, [r4, #0x20]
	add r0, sp, #0
	bic r2, r1, #1
	ldr r1, _0209D8A0 // =0xEDB88320
	str r2, [r4, #0x20]
	bl MATHi_CRC32InitTableRev
	add r0, sp, #0
	mov r1, r4
	mov r2, #0x3c
	bl MATH_CalcCRC32
	str r0, [r4, #0x3c]
	add sp, sp, #0x400
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209D8A0: .word 0xEDB88320
	arm_func_end DWCi_Acc_ClearDirty

	arm_func_start DWC_ClearDirtyFlag
DWC_ClearDirtyFlag: // 0x0209D8A4
	ldr ip, _0209D8AC // =DWCi_Acc_ClearDirty
	bx ip
	.align 2, 0
_0209D8AC: .word DWCi_Acc_ClearDirty
	arm_func_end DWC_ClearDirtyFlag

	arm_func_start sub_209D8B0
sub_209D8B0: // 0x0209D8B0
	ldr r0, [r0, #0x20]
	and r0, r0, #1
	cmp r0, #1
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end sub_209D8B0

	arm_func_start DWC_CheckDirtyFlag
DWC_CheckDirtyFlag: // 0x0209D8C8
	ldr ip, _0209D8D0 // =sub_209D8B0
	bx ip
	.align 2, 0
_0209D8D0: .word sub_209D8B0
	arm_func_end DWC_CheckDirtyFlag

	arm_func_start DWCi_Acc_SetLoginIdToUserData
DWCi_Acc_SetLoginIdToUserData: // 0x0209D8D4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x400
	mov r4, r0
	add r3, r4, #0x10
	mov ip, r2
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, _0209D928 // =0xEDB88320
	add r0, sp, #0
	str ip, [r4, #0x1c]
	bl MATHi_CRC32InitTableRev
	add r0, sp, #0
	mov r1, r4
	mov r2, #0x3c
	bl MATH_CalcCRC32
	str r0, [r4, #0x3c]
	ldr r0, [r4, #0x20]
	orr r0, r0, #1
	str r0, [r4, #0x20]
	add sp, sp, #0x400
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209D928: .word 0xEDB88320
	arm_func_end DWCi_Acc_SetLoginIdToUserData

	arm_func_start DWC_CheckValidConsole
DWC_CheckValidConsole: // 0x0209D92C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	add r0, r4, #0x10
	bl DWCi_Acc_GetFlag_DataType
	cmp r0, #0
	addeq sp, sp, #0x18
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	add r0, sp, #0
	bl DWC_Auth_GetId
	ldr r0, [sp, #0x10]
	cmp r0, #0
	addeq sp, sp, #0x18
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x10
	bl DWCi_Acc_GetUserId
	ldr r2, [sp, #4]
	ldr r3, [sp]
	cmp r2, r1
	cmpeq r3, r0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	arm_func_end DWC_CheckValidConsole

	arm_func_start DWC_CheckHasProfile
DWC_CheckHasProfile: // 0x0209D994
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x10
	bl DWCi_Acc_IsValidLoginId
	cmp r0, #0
	beq _0209D9BC
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	movgt r0, #1
	ldmgtia sp!, {r4, pc}
_0209D9BC:
	mov r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end DWC_CheckHasProfile

	arm_func_start DWC_CheckUserData
DWC_CheckUserData: // 0x0209D9C4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x400
	ldr r1, _0209DA04 // =0xEDB88320
	mov r4, r0
	add r0, sp, #0
	bl MATHi_CRC32InitTableRev
	add r0, sp, #0
	mov r1, r4
	mov r2, #0x3c
	bl MATH_CalcCRC32
	ldr r1, [r4, #0x3c]
	cmp r0, r1
	moveq r0, #1
	movne r0, #0
	add sp, sp, #0x400
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209DA04: .word 0xEDB88320
	arm_func_end DWC_CheckUserData

	arm_func_start DWC_CreateUserData
DWC_CreateUserData: // 0x0209DA08
	ldr ip, _0209DA10 // =DWCi_Acc_CreateUserData
	bx ip
	.align 2, 0
_0209DA10: .word DWCi_Acc_CreateUserData
	arm_func_end DWC_CreateUserData

	arm_func_start DWCi_Acc_IsValidFriendData
DWCi_Acc_IsValidFriendData: // 0x0209DA14
	ldr ip, _0209DA1C // =DWC_IsValidFriendData
	bx ip
	.align 2, 0
_0209DA1C: .word DWC_IsValidFriendData
	arm_func_end DWCi_Acc_IsValidFriendData

	arm_func_start DWC_IsValidFriendData
DWC_IsValidFriendData: // 0x0209DA20
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_Acc_GetFlag_DataType
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWC_IsValidFriendData

	arm_func_start DWCi_Acc_IsAuthentic
DWCi_Acc_IsAuthentic: // 0x0209DA40
	ldr ip, _0209DA4C // =DWCi_Acc_IsValidLoginId
	add r0, r0, #0x10
	bx ip
	.align 2, 0
_0209DA4C: .word DWCi_Acc_IsValidLoginId
	arm_func_end DWCi_Acc_IsAuthentic

	arm_func_start DWCi_Acc_IsValidLoginId
DWCi_Acc_IsValidLoginId: // 0x0209DA50
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_Acc_GetFlag_DataType
	cmp r0, #1
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_Acc_IsValidLoginId

	arm_func_start DWCi_Acc_CheckConsoleUserId
DWCi_Acc_CheckConsoleUserId: // 0x0209DA70
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	add r0, sp, #0
	bl DWC_Auth_GetId
	ldr r0, [sp, #0x10]
	cmp r0, #0
	beq _0209DAB8
	mov r0, r4
	bl DWCi_Acc_GetUserId
	ldr r2, [sp, #4]
	ldr r3, [sp]
	cmp r2, r1
	cmpeq r3, r0
	moveq r0, #1
	add sp, sp, #0x18
	movne r0, #0
	ldmia sp!, {r4, pc}
_0209DAB8:
	mov r0, r4
	bl DWCi_Acc_GetUserId
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #8]
	cmp r2, r1
	cmpeq r3, r0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	arm_func_end DWCi_Acc_CheckConsoleUserId

	arm_func_start DWCi_Acc_CreateTempLoginId
DWCi_Acc_CreateTempLoginId: // 0x0209DAE0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x38
	mov r6, r0
	add r0, sp, #0x14
	bl OS_GetLowEntropyData
	mov r3, #1
	add r2, sp, #0x14
_0209DAFC:
	add r0, r2, r3, lsl #2
	ldr r1, [r2, r3, lsl #2]
	ldr r0, [r0, #-4]
	eor r0, r1, r0
	str r0, [r2, r3, lsl #2]
	add r3, r3, #1
	cmp r3, #8
	blo _0209DAFC
	add r0, sp, #0
	ldr r5, [sp, #0x30]
	mov r4, #0
	bl DWC_Auth_GetId
	ldr r0, [sp, #0x10]
	cmp r0, #0
	beq _0209DB4C
	ldr r1, [sp]
	ldr r2, [sp, #4]
	mov r0, r6
	bl DWCi_Acc_SetUserId
	b _0209DB5C
_0209DB4C:
	ldr r1, [sp, #8]
	ldr r2, [sp, #0xc]
	mov r0, r6
	bl DWCi_Acc_SetUserId
_0209DB5C:
	ldr r0, _0209DB98 // =0x6C078965
	ldr r1, _0209DB9C // =0x5D588B65
	umull r3, r2, r5, r0
	mla r2, r5, r1, r2
	ldr r1, _0209DBA0 // =0x00269EC3
	mla r2, r4, r0, r2
	adds r0, r3, r1
	mov r0, r6
	adc r1, r2, #0
	bl DWCi_Acc_SetPlayerId
	mov r0, r6
	mov r1, #1
	bl DWCi_Acc_SetFlag_DataType
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209DB98: .word 0x6C078965
_0209DB9C: .word 0x5D588B65
_0209DBA0: .word 0x00269EC3
	arm_func_end DWCi_Acc_CreateTempLoginId

	arm_func_start DWCi_Acc_CreateUserData
DWCi_Acc_CreateUserData: // 0x0209DBA4
	stmdb sp!, {r4, r5, lr}
	ldr ip, _0209DC24 // =0x00000404
	sub sp, sp, ip
	mov r4, r1
	mov r1, #0
	mov r2, #0x40
	mov r5, r0
	bl MI_CpuFill8
	mov r0, #0x40
	str r0, [r5]
	mov r0, #0
	str r0, [r5, #0x1c]
	add r0, r5, #4
	str r4, [r5, #0x24]
	bl DWCi_Acc_CreateTempLoginId
	add r0, r5, #0x10
	mov r1, #0
	bl DWCi_Acc_SetFlag_DataType
	ldr r1, _0209DC28 // =0xEDB88320
	add r0, sp, #0
	bl MATHi_CRC32InitTableRev
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x3c
	bl MATH_CalcCRC32
	str r0, [r5, #0x3c]
	ldr r0, [r5, #0x20]
	orr r0, r0, #1
	str r0, [r5, #0x20]
	ldr ip, _0209DC24 // =0x00000404
	add sp, sp, ip
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0209DC24: .word 0x00000404
_0209DC28: .word 0xEDB88320
	arm_func_end DWCi_Acc_CreateUserData

	arm_func_start DWCi_Acc_LoginIdToUserName
DWCi_Acc_LoginIdToUserName: // 0x0209DC2C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x40
	mov r6, r0
	mov r4, r1
	mov r5, r2
	bl DWCi_Acc_GetUserId
	add r3, sp, #0x14
	mov r2, #0x2b
	bl DWCi_Acc_U64ToString32
	mov r0, r6
	bl DWCi_Acc_GetPlayerId
	mov r1, #0
	mov r2, #0x20
	add r3, sp, #0x29
	bl DWCi_Acc_U64ToString32
	mov r1, r4, lsr #0x18
	and r1, r1, #0xff
	str r1, [sp]
	mov r1, r4, lsr #0x10
	and r1, r1, #0xff
	str r1, [sp, #4]
	mov r1, r4, lsr #8
	and r1, r1, #0xff
	str r1, [sp, #8]
	and r1, r4, #0xff
	str r1, [sp, #0xc]
	add r2, sp, #0x29
	str r2, [sp, #0x10]
	ldr r2, _0209DCB8 // =aSCCCCS
	mov r0, r5
	mov r1, #0x15
	add r3, sp, #0x14
	bl OS_SNPrintf
	add sp, sp, #0x40
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209DCB8: .word aSCCCCS
	arm_func_end DWCi_Acc_LoginIdToUserName

	arm_func_start DWCi_Acc_U64ToString32
DWCi_Acc_U64ToString32: // 0x0209DCBC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr lr, _0209DD30 // =0x66666667
	add r4, r2, #4
	smull ip, r2, lr, r4
	mov r2, r2, asr #1
	mov ip, r4, lsr #0x1f
	add r2, ip, r2
	cmp r2, #0
	ldr r6, _0209DD34 // =a0123456789abcd
	mov r7, #0
	ble _0209DD20
	add r4, r3, r2
	sub r4, r4, #1
	mov ip, #0x1f
_0209DCF8:
	and r5, r0, ip
	ldrsb r5, [r6, r5]
	mov r0, r0, lsr #5
	mov lr, r1, lsr #5
	strb r5, [r4, -r7]
	add r7, r7, #1
	orr r0, r0, r1, lsl #27
	mov r1, lr
	cmp r7, r2
	blt _0209DCF8
_0209DD20:
	mov r0, #0
	strb r0, [r3, r2]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209DD30: .word 0x66666667
_0209DD34: .word a0123456789abcd
	arm_func_end DWCi_Acc_U64ToString32

	arm_func_start DWC_Acc_NumericKeyToFriendKey
DWC_Acc_NumericKeyToFriendKey: // 0x0209DD38
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov ip, #0
	mov r1, ip
	mov r2, ip
	mov lr, ip
	mov r3, #1
	add r0, r0, #0xb
	mov r7, ip
	mov r6, #0xa
_0209DD5C:
	ldrsb r4, [r0, -lr]
	cmp r4, #0x30
	blt _0209DD70
	cmp r4, #0x39
	ble _0209DD7C
_0209DD70:
	mov r0, #0
	mov r1, r0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0209DD7C:
	sub r9, r4, #0x30
	umull r8, r10, r9, r3
	umull r4, r5, r3, r6
	mla r5, r3, r7, r5
	adds ip, ip, r8
	mov r8, r9, asr #0x1f
	mla r10, r9, r2, r10
	mla r10, r8, r3, r10
	adc r1, r1, r10
	mov r3, r4
	mla r5, r2, r6, r5
	mov r2, r5
	add lr, lr, #1
	cmp lr, #0xc
	blt _0209DD5C
	mov r0, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end DWC_Acc_NumericKeyToFriendKey

	arm_func_start DWC_Acc_FriendKeyToNumericKey
DWC_Acc_FriendKeyToNumericKey: // 0x0209DDC0
	stmdb sp!, {lr}
	sub sp, sp, #4
	str r2, [sp]
	mov r3, r1
	ldr r2, _0209DDE4 // =a012llu
	mov r1, #0xd
	bl OS_SNPrintf
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209DDE4: .word a012llu
	arm_func_end DWC_Acc_FriendKeyToNumericKey

	arm_func_start DWC_Acc_FriendKeyToGsProfileId
DWC_Acc_FriendKeyToGsProfileId: // 0x0209DDE8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DWC_Acc_CheckFriendKey
	cmp r0, #0
	mvnne r0, #0
	andne r0, r4, r0
	moveq r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end DWC_Acc_FriendKeyToGsProfileId

	arm_func_start DWC_Acc_CheckFriendKey
DWC_Acc_CheckFriendKey: // 0x0209DE08
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x108
	mov r4, r1
	and r3, r4, #0
	mov r1, #0
	and ip, r0, #0x80000000
	cmp r3, r1
	cmpeq ip, r1
	addne sp, sp, #0x108
	movne r0, r1
	ldmneia sp!, {r4, pc}
	str r0, [sp]
	add r0, sp, #8
	mov r1, #7
	str r2, [sp, #4]
	bl MATHi_CRC8InitTable
	add r0, sp, #8
	add r1, sp, #0
	mov r2, #8
	bl MATH_CalcCRC8
	and r2, r0, #0x7f
	mov r1, r2, asr #0x1f
	mov r0, #0
	cmp r1, r0
	cmpeq r2, r4
	moveq r0, #1
	add sp, sp, #0x108
	ldmia sp!, {r4, pc}
	arm_func_end DWC_Acc_CheckFriendKey

	arm_func_start DWC_CheckFriendKey
DWC_CheckFriendKey: // 0x0209DE78
	ldr ip, _0209DE90 // =DWC_Acc_CheckFriendKey
	mov r3, r0
	mov r0, r1
	mov r1, r2
	ldr r2, [r3, #0x24]
	bx ip
	.align 2, 0
_0209DE90: .word DWC_Acc_CheckFriendKey
	arm_func_end DWC_CheckFriendKey

	arm_func_start DWC_Acc_CreateFriendKey
DWC_Acc_CreateFriendKey: // 0x0209DE94
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x108
	mov r4, r0
	str r1, [sp, #4]
	add r0, sp, #8
	mov r1, #7
	str r4, [sp]
	bl MATHi_CRC8InitTable
	add r0, sp, #8
	add r1, sp, #0
	mov r2, #8
	bl MATH_CalcCRC8
	and r0, r0, #0x7f
	orr r1, r0, #0
	orr r0, r4, #0
	add sp, sp, #0x108
	ldmia sp!, {r4, pc}
	arm_func_end DWC_Acc_CreateFriendKey

	arm_func_start DWCi_SetBuddyFriendData
DWCi_SetBuddyFriendData: // 0x0209DED8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DWCi_Acc_GetFlag_DataType
	cmp r0, #3
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl DWCi_Acc_GetFlags
	orr r1, r0, #4
	mov r0, r4
	bl DWCi_Acc_SetFlags
	ldmia sp!, {r4, pc}
	arm_func_end DWCi_SetBuddyFriendData

	arm_func_start DWCi_Acc_SetFlag_DataType
DWCi_Acc_SetFlag_DataType: // 0x0209DF04
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl DWCi_Acc_GetFlags
	bic r1, r0, #3
	mov r0, r5
	orr r1, r1, r4
	bl DWCi_Acc_SetFlags
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWCi_Acc_SetFlag_DataType

	arm_func_start DWCi_Acc_SetFlags
DWCi_Acc_SetFlags: // 0x0209DF30
	ldr ip, _0209DF40 // =DWCi_Acc_SetMaskBits
	ldr r3, _0209DF44 // =0x001FFFFF
	mov r2, #0xb
	bx ip
	.align 2, 0
_0209DF40: .word DWCi_Acc_SetMaskBits
_0209DF44: .word 0x001FFFFF
	arm_func_end DWCi_Acc_SetFlags

	arm_func_start DWC_GetFriendDataType
DWC_GetFriendDataType: // 0x0209DF48
	ldr ip, _0209DF50 // =DWCi_Acc_GetFlag_DataType
	bx ip
	.align 2, 0
_0209DF50: .word DWCi_Acc_GetFlag_DataType
	arm_func_end DWC_GetFriendDataType

	arm_func_start DWC_IsBuddyFriendData
DWC_IsBuddyFriendData: // 0x0209DF54
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DWCi_Acc_GetFlag_DataType
	cmp r0, #3
	bne _0209DF84
	mov r0, r4
	bl DWCi_Acc_GetFlags
	and r0, r0, #4
	cmp r0, #4
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, pc}
_0209DF84:
	mov r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end DWC_IsBuddyFriendData

	arm_func_start DWCi_Acc_GetFlag_DataType
DWCi_Acc_GetFlag_DataType: // 0x0209DF8C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_Acc_GetFlags
	and r0, r0, #3
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_Acc_GetFlag_DataType

	arm_func_start DWCi_Acc_GetFlags
DWCi_Acc_GetFlags: // 0x0209DFA4
	ldr r1, [r0]
	ldr r0, _0209DFB4 // =0x001FFFFF
	and r0, r0, r1, lsr #11
	bx lr
	.align 2, 0
_0209DFB4: .word 0x001FFFFF
	arm_func_end DWCi_Acc_GetFlags

	arm_func_start DWCi_Acc_SetGsProfileId
DWCi_Acc_SetGsProfileId: // 0x0209DFB8
	str r1, [r0, #4]
	bx lr
	arm_func_end DWCi_Acc_SetGsProfileId

	arm_func_start DWCi_Acc_SetFriendKey
DWCi_Acc_SetFriendKey: // 0x0209DFC0
	str r1, [r0, #4]
	str r2, [r0, #8]
	bx lr
	arm_func_end DWCi_Acc_SetFriendKey

	arm_func_start DWCi_Acc_SetPlayerId
DWCi_Acc_SetPlayerId: // 0x0209DFCC
	str r1, [r0, #8]
	bx lr
	arm_func_end DWCi_Acc_SetPlayerId

	arm_func_start DWCi_Acc_SetUserId
DWCi_Acc_SetUserId: // 0x0209DFD4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov ip, #0
	mov r4, r1
	mov r1, r2
	ldr r3, _0209E004 // =0x000007FF
	mov r2, ip
	mov r5, r0
	bl DWCi_Acc_SetMaskBits
	str r4, [r5, #4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0209E004: .word 0x000007FF
	arm_func_end DWCi_Acc_SetUserId

	arm_func_start DWCi_Acc_GetGsProfileId
DWCi_Acc_GetGsProfileId: // 0x0209E008
	ldr r0, [r0, #4]
	bx lr
	arm_func_end DWCi_Acc_GetGsProfileId

	arm_func_start DWCi_Acc_GetFriendKey
DWCi_Acc_GetFriendKey: // 0x0209E010
	ldr r1, [r0, #8]
	ldr r0, [r0, #4]
	orr r1, r1, #0
	orr r0, r0, #0
	bx lr
	arm_func_end DWCi_Acc_GetFriendKey

	arm_func_start DWCi_Acc_GetPlayerId
DWCi_Acc_GetPlayerId: // 0x0209E024
	ldr r0, [r0, #8]
	bx lr
	arm_func_end DWCi_Acc_GetPlayerId

	arm_func_start DWCi_Acc_GetUserId
DWCi_Acc_GetUserId: // 0x0209E02C
	ldr r2, [r0]
	ldr r1, _0209E048 // =0x000007FF
	ldr r0, [r0, #4]
	and r1, r2, r1
	orr r1, r1, #0
	orr r0, r0, #0
	bx lr
	.align 2, 0
_0209E048: .word 0x000007FF
	arm_func_end DWCi_Acc_GetUserId

	arm_func_start DWCi_Acc_SetMaskBits
DWCi_Acc_SetMaskBits: // 0x0209E04C
	mvn ip, r3
	ands ip, r1, ip
	movne r0, #0
	bxne lr
	mvn r3, r3, lsl r2
	ldr ip, [r0]
	and r3, ip, r3
	orr r1, r3, r1, lsl r2
	str r1, [r0]
	mov r0, #1
	bx lr
	arm_func_end DWCi_Acc_SetMaskBits

	.data
	
aSCCCCS: // 0x0211C3B0
	.asciz "%s%c%c%c%c%s"
	.align 4
	
a0123456789abcd: // 0x0211C3C0
	.asciz "0123456789abcdefghijklmnopqrstuv"
	.align 4
	
a012llu: // 0x0211C3E4
	.asciz "%012llu"
	.align 4
