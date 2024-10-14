	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWCi_GetPersCallbackLevel
DWCi_GetPersCallbackLevel: // 0x02091D78
	ldr r0, _02091D88 // =0x02143BA4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x20]
	bx lr
	.align 2, 0
_02091D88: .word 0x02143BA4
	arm_func_end DWCi_GetPersCallbackLevel

	arm_func_start DWCi_GPGetInfoCallback_RecvAuthMessage
DWCi_GPGetInfoCallback_RecvAuthMessage: // 0x02091D8C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	mov r10, r1
	ldr r0, [r10, #0]
	mov r8, #0
	cmp r0, #0
	mov r0, #1
	str r0, [sp]
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r4, _02091F34 // =0x02143BA4
	mov r9, r8
	ldr r2, [r4, #0]
	ldr r1, [r2, #0x14]
	cmp r1, #0
	ble _02091EF4
	mov r7, r8
	str r0, [sp, #4]
	mov r11, r8
	mov r5, r0
_02091DDC:
	ldr r0, [r2, #0x18]
	add r0, r0, r7
	bl DWC_GetFriendDataType
	cmp r0, #1
	bne _02091E48
	bl DWCi_GetUserData
	ldr r1, [r4, #0]
	add r2, sp, #8
	ldr r1, [r1, #0x18]
	add r1, r1, r7
	bl DWC_LoginIdToUserName
	add r0, sp, #8
	add r1, r10, #0x8e
	bl strcmp
	cmp r0, #0
	bne _02091EDC
	ldr r0, [r4, #0]
	ldr r1, [r10, #4]
	ldr r0, [r0, #0x18]
	add r0, r0, r7
	bl DWC_SetGsProfileId
	ldr r0, [r4, #0]
	ldr r0, [r0, #0x18]
	add r0, r0, r7
	bl DWCi_SetBuddyFriendData
	mov r8, r5
	b _02091EDC
_02091E48:
	ldr r0, [r4, #0]
	ldr r0, [r0, #0x18]
	add r0, r0, r7
	bl DWC_GetFriendDataType
	cmp r0, #3
	beq _02091E78
	ldr r0, [r4, #0]
	ldr r0, [r0, #0x18]
	add r0, r0, r7
	bl DWC_GetFriendDataType
	cmp r0, #2
	bne _02091EDC
_02091E78:
	ldr r0, [r4, #0]
	ldr r0, [r0, #0x18]
	add r0, r0, r7
	bl DWC_IsBuddyFriendData
	cmp r0, #1
	streq r11, [sp]
	beq _02091EDC
	ldr r6, [r10, #4]
	bl DWCi_GetUserData
	ldr r1, [r4, #0]
	ldr r1, [r1, #0x18]
	add r1, r1, r7
	bl DWC_GetGsProfileId
	cmp r6, r0
	bne _02091EDC
	ldr r0, [r4, #0]
	mov r1, r6
	ldr r0, [r0, #0x18]
	add r0, r0, r7
	bl DWC_SetGsProfileId
	ldr r0, [r4, #0]
	ldr r0, [r0, #0x18]
	add r0, r0, r7
	bl DWCi_SetBuddyFriendData
	ldr r8, [sp, #4]
_02091EDC:
	ldr r2, [r4, #0]
	add r9, r9, #1
	ldr r1, [r2, #0x14]
	add r7, r7, #0xc
	cmp r9, r1
	blt _02091DDC
_02091EF4:
	cmp r8, #0
	addeq sp, sp, #0x24
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r2, #0x18]
	ldr r2, [r10, #4]
	bl DWCi_RefreshFriendListAll
	ldr r1, [sp]
	cmp r1, #0
	beq _02091F1C
	bl DWCi_CallBuddyFriendCallback
_02091F1C:
	ldr r0, _02091F34 // =0x02143BA4
	mov r1, #1
	ldr r0, [r0, #0]
	strb r1, [r0, #0x1d]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02091F34: .word 0x02143BA4
	arm_func_end DWCi_GPGetInfoCallback_RecvAuthMessage

	arm_func_start DWCi_GPGetInfoCallback_RecvBuddyRequest
DWCi_GPGetInfoCallback_RecvBuddyRequest: // 0x02091F38
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	mov r9, r1
	ldr r1, [r9, #0]
	mov r10, r0
	cmp r1, #0
	mov r11, #0
	addne sp, sp, #0x34
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r4, _020920F0 // =0x02143BA4
	mov r8, r11
	ldr r1, [r4, #0]
	ldr r0, [r1, #0x14]
	cmp r0, #0
	ble _020920C4
	mov r0, #4
	str r0, [sp, #0x10]
	mov r0, #5
	mov r7, r11
	mov r5, #1
	str r0, [sp, #0xc]
_02091F8C:
	ldr r0, [r1, #0x18]
	add r0, r0, r7
	bl DWC_GetFriendDataType
	cmp r0, #1
	bne _02091FF4
	bl DWCi_GetUserData
	ldr r1, [r4, #0]
	add r2, sp, #0x19
	ldr r1, [r1, #0x18]
	add r1, r1, r7
	bl DWC_LoginIdToUserName
	add r0, sp, #0x19
	add r1, r9, #0x8e
	bl strcmp
	cmp r0, #0
	bne _020920AC
	ldr r1, [r9, #4]
	mov r0, r10
	bl gpAuthBuddyRequest
	ldr r0, [r4, #0]
	ldr r1, [r9, #4]
	ldr r0, [r0, #0x18]
	add r0, r0, r7
	bl DWC_SetGsProfileId
	mov r11, r5
	b _020920AC
_02091FF4:
	ldr r0, [r4, #0]
	ldr r0, [r0, #0x18]
	add r0, r0, r7
	bl DWC_GetFriendDataType
	cmp r0, #3
	beq _02092024
	ldr r0, [r4, #0]
	ldr r0, [r0, #0x18]
	add r0, r0, r7
	bl DWC_GetFriendDataType
	cmp r0, #2
	bne _020920AC
_02092024:
	bl DWCi_GetUserData
	ldr r1, [r0, #0x24]
	add r0, sp, #0x14
	mov r2, r1, lsr #0x10
	and r2, r2, #0xff
	str r2, [sp]
	mov r2, r1, lsr #8
	and r2, r2, #0xff
	str r2, [sp, #4]
	and r2, r1, #0xff
	mov r1, r1, lsr #0x18
	str r2, [sp, #8]
	and r3, r1, #0xff
	ldr r1, [sp, #0xc]
	ldr r2, _020920F4 // =aCCCC
	bl OS_SNPrintf
	ldr r6, [r9, #4]
	bl DWCi_GetUserData
	ldr r1, [r4, #0]
	ldr r1, [r1, #0x18]
	add r1, r1, r7
	bl DWC_GetGsProfileId
	cmp r6, r0
	bne _020920AC
	ldr r2, [sp, #0x10]
	add r0, sp, #0x14
	add r1, r9, #0x97
	bl memcmp
	cmp r0, #0
	bne _020920AC
	mov r0, r10
	mov r1, r6
	bl gpAuthBuddyRequest
	mov r11, r5
_020920AC:
	ldr r1, [r4, #0]
	add r8, r8, #1
	add r7, r7, #0xc
	ldr r0, [r1, #0x14]
	cmp r8, r0
	blt _02091F8C
_020920C4:
	cmp r11, #0
	beq _020920DC
	ldr r0, [r9, #4]
	bl DWCi_GPSendBuddyRequest
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020920DC:
	ldr r1, [r9, #4]
	mov r0, r10
	bl gpDenyBuddyRequest
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020920F0: .word 0x02143BA4
_020920F4: .word aCCCC
	arm_func_end DWCi_GPGetInfoCallback_RecvBuddyRequest

	arm_func_start DWCi_GPProfileSearchCallback
DWCi_GPProfileSearchCallback: // 0x020920F8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r9, r1
	ldr r1, [r9, #0]
	mov r10, r0
	mov r8, r2
	cmp r1, #0
	bne _020922E0
	ldr r0, [r9, #4]
	cmp r0, #0
	beq _020922E0
	mov r0, #0xc
	ldr r1, _02092354 // =0x02143BA4
	mul r6, r8, r0
	ldr r0, [r1, #0]
	ldr r0, [r0, #0x18]
	add r0, r0, r6
	bl DWC_GetFriendDataType
	cmp r0, #0
	beq _020922E0
	ldr r7, _02092354 // =0x02143BA4
	ldr r0, [r7, #0]
	ldr r0, [r0, #0]
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r9, #4]
	mov r5, #0
	cmp r0, #0
	ble _020921D8
	mov r4, r5
_02092174:
	ldr r0, [r7, #0]
	ldr r1, [r9, #0xc]
	ldr r0, [r0, #0x18]
	ldr r2, [r1, r4]
	mov r1, r8
	bl DWCi_RefreshFriendListForth
	cmp r0, #0
	beq _020921C4
	ldr r0, _02092354 // =0x02143BA4
	mov r2, #1
	ldr r4, [r0, #0]
	ldr r1, _02092358 // =0x00000601
	ldrb r3, [r4, #0x1c]
	add sp, sp, #4
	add r3, r3, #1
	strb r3, [r4, #0x1c]
	ldr r0, [r0, #0]
	strb r2, [r0, #0x1e]
	str r1, [r9, #8]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020921C4:
	ldr r0, [r9, #4]
	add r5, r5, #1
	cmp r5, r0
	add r4, r4, #0xac
	blt _02092174
_020921D8:
	cmp r0, #0
	mov r5, #0
	ble _020922A8
	mov r7, r5
	add r11, sp, #0
	mvn r4, #0
_020921F0:
	ldr r1, [r9, #0xc]
	mov r0, r10
	ldr r1, [r1, r7]
	mov r2, r11
	bl gpGetBuddyIndex
	bl DWCi_HandleGPError_2
	ldr r0, [sp]
	cmp r0, r4
	bne _02092224
	ldr r0, [r9, #0xc]
	ldr r0, [r0, r7]
	bl DWCi_GPSendBuddyRequest
	b _02092294
_02092224:
	ldr r0, _02092354 // =0x02143BA4
	ldr r1, [r9, #0xc]
	ldr r0, [r0, #0]
	ldr r1, [r1, #0]
	ldr r0, [r0, #0x18]
	add r0, r0, r6
	bl DWC_SetGsProfileId
	ldr r0, _02092354 // =0x02143BA4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x18]
	add r0, r0, r6
	bl DWCi_SetBuddyFriendData
	mov r0, r8
	bl DWCi_CallBuddyFriendCallback
	ldr r0, _02092354 // =0x02143BA4
	mov r3, #1
	ldr r4, [r0, #0]
	ldr r1, _02092358 // =0x00000601
	ldrb r2, [r4, #0x1c]
	add sp, sp, #4
	add r2, r2, #1
	strb r2, [r4, #0x1c]
	ldr r2, [r0, #0]
	strb r3, [r2, #0x1e]
	str r1, [r9, #8]
	ldr r0, [r0, #0]
	strb r3, [r0, #0x1d]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02092294:
	ldr r0, [r9, #4]
	add r5, r5, #1
	cmp r5, r0
	add r7, r7, #0xac
	blt _020921F0
_020922A8:
	ldr r0, [r9, #8]
	cmp r0, #0x600
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, _02092354 // =0x02143BA4
	mov r1, #1
	ldr r3, [r0, #0]
	add sp, sp, #4
	ldrb r2, [r3, #0x1c]
	add r2, r2, #1
	strb r2, [r3, #0x1c]
	ldr r0, [r0, #0]
	strb r1, [r0, #0x1e]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020922E0:
	ldr r0, [r9, #0]
	cmp r0, #0
	beq _020922FC
	bl DWCi_HandleGPError_2
	add sp, sp, #4
	cmp r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020922FC:
	ldr r0, _02092354 // =0x02143BA4
	ldr r1, [r0, #0]
	ldr r0, [r1, #0]
	cmp r0, #1
	beq _0209232C
	ldr r1, [r1, #0x18]
	mov r0, #0xc
	mla r0, r8, r0, r1
	bl DWC_GetFriendDataType
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0209232C:
	ldr r0, _02092354 // =0x02143BA4
	mov r1, #1
	ldr r3, [r0, #0]
	ldrb r2, [r3, #0x1c]
	add r2, r2, #1
	strb r2, [r3, #0x1c]
	ldr r0, [r0, #0]
	strb r1, [r0, #0x1e]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02092354: .word 0x02143BA4
_02092358: .word 0x00000601
	arm_func_end DWCi_GPProfileSearchCallback

	arm_func_start DWCi_HandleGPError_2
DWCi_HandleGPError_2: // 0x0209235C
	stmdb sp!, {r4, lr}
	movs r4, r0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	cmp r4, #4
	addls pc, pc, r4, lsl #2
	b _020923B8
_02092378: // jump table
	b _020923B8 // case 0
	b _0209238C // case 1
	b _02092398 // case 2
	b _020923A4 // case 3
	b _020923B0 // case 4
_0209238C:
	mov r0, #9
	mvn r2, #0
	b _020923B8
_02092398:
	mov r0, #9
	mvn r2, #1
	b _020923B8
_020923A4:
	mov r0, #6
	mvn r2, #9
	b _020923B8
_020923B0:
	mov r0, #6
	mvn r2, #0x13
_020923B8:
	ldr r1, _020923CC // =0xFFFEEAA8
	add r1, r2, r1
	bl DWCi_StopFriendProcess
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_020923CC: .word 0xFFFEEAA8
	arm_func_end DWCi_HandleGPError_2

	arm_func_start DWCi_GetFriendBuddyStatus
DWCi_GetFriendBuddyStatus: // 0x020923D0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r2, _0209249C // =0x02143BA4
	mov r3, #0
	ldr r2, [r2, #0]
	mov r5, r0
	mov r4, r1
	str r3, [sp]
	cmp r2, #0
	beq _02092404
	bl DWCi_CheckLogin
	cmp r0, #0
	bne _02092410
_02092404:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_02092410:
	bl DWCi_GetUserData
	mov r1, r5
	bl DWC_GetGsProfileId
	mov r5, r0
	cmp r5, #0
	ble _02092450
	ldr r0, _0209249C // =0x02143BA4
	add r2, sp, #0
	ldr r0, [r0, #0]
	mov r1, r5
	ldr r0, [r0, #4]
	bl gpGetBuddyIndex
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, pc}
_02092450:
	cmp r5, #0
	ble _02092468
	ldr r1, [sp]
	mvn r0, #0
	cmp r1, r0
	bne _02092474
_02092468:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_02092474:
	ldr r0, _0209249C // =0x02143BA4
	mov r2, r4
	ldr r0, [r0, #0]
	ldr r0, [r0, #4]
	bl gpGetBuddyStatus
	cmp r0, #0
	movne r0, #0
	moveq r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0209249C: .word 0x02143BA4
	arm_func_end DWCi_GetFriendBuddyStatus

	arm_func_start DWCi_GPSendBuddyRequest
DWCi_GPSendBuddyRequest: // 0x020924A0
	stmdb sp!, {r4, lr}
	ldr r2, _020924CC // =0x02143BA4
	mov r1, r0
	ldr r0, [r2, #0]
	ldr r2, _020924D0 // =_0211C210
	ldr r0, [r0, #4]
	bl sub_20A5678
	mov r4, r0
	bl DWCi_HandleGPError_2
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_020924CC: .word 0x02143BA4
_020924D0: .word _0211C210
	arm_func_end DWCi_GPSendBuddyRequest

	arm_func_start DWCi_RefreshFriendListAll
DWCi_RefreshFriendListAll: // 0x020924D4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r1
	mov r11, r0
	mvn r0, #0
	str r2, [sp]
	cmp r10, #0
	str r0, [sp, #4]
	mov r8, #0
	ble _020925D4
	mov r6, r11
	mov r5, r11
	mov r0, #1
	str r0, [sp, #8]
_0209250C:
	mov r0, r8
	bl DWCi_GetProfileIDFromList
	movs r9, r0
	beq _020925C0
	ldr r0, [sp]
	add r7, r8, #1
	cmp r9, r0
	streq r8, [sp, #4]
	cmp r7, r10
	bge _020925C0
	mov r0, #0xc
	mla r4, r7, r0, r11
_0209253C:
	mov r0, r7
	bl DWCi_GetProfileIDFromList
	cmp r9, r0
	bne _020925B0
	mov r0, r6
	bl DWC_GetFriendDataType
	cmp r0, #2
	bne _02092578
	mov r0, r4
	bl DWC_GetFriendDataType
	cmp r0, #3
	bne _02092578
	mov r0, r5
	mov r1, r9
	bl DWC_SetGsProfileId
_02092578:
	mov r0, r4
	bl DWC_IsBuddyFriendData
	cmp r0, #0
	beq _02092590
	mov r0, r5
	bl DWCi_SetBuddyFriendData
_02092590:
	mov r0, r11
	mov r1, r7
	mov r2, r8
	bl DWCi_DeleteFriendFromList
	ldr r0, _020925E0 // =0x02143BA4
	ldr r1, [r0, #0]
	ldr r0, [sp, #8]
	strb r0, [r1, #0x1d]
_020925B0:
	add r7, r7, #1
	cmp r7, r10
	add r4, r4, #0xc
	blt _0209253C
_020925C0:
	add r8, r8, #1
	cmp r8, r10
	add r6, r6, #0xc
	add r5, r5, #0xc
	blt _0209250C
_020925D4:
	ldr r0, [sp, #4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020925E0: .word 0x02143BA4
	arm_func_end DWCi_RefreshFriendListAll

	arm_func_start DWCi_RefreshFriendListForth
DWCi_RefreshFriendListForth: // 0x020925E4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r1
	mov r7, r0
	mov r5, r2
	cmp r6, #0
	mov r4, #0
	ble _0209268C
_02092604:
	mov r0, r4
	bl DWCi_GetProfileIDFromList
	cmp r0, #0
	beq _02092680
	cmp r0, r5
	bne _02092680
	mov r0, #0xc
	mla r0, r6, r0, r7
	bl DWC_IsBuddyFriendData
	cmp r0, #0
	beq _02092658
	mov r0, #0xc
	mla r0, r4, r0, r7
	bl DWC_IsBuddyFriendData
	cmp r0, #0
	bne _02092658
	mov r0, r7
	mov r1, r4
	mov r2, r6
	bl DWCi_DeleteFriendFromList
	b _02092668
_02092658:
	mov r0, r7
	mov r1, r6
	mov r2, r4
	bl DWCi_DeleteFriendFromList
_02092668:
	ldr r1, _02092698 // =0x02143BA4
	mov r0, #1
	ldr r1, [r1, #0]
	add sp, sp, #4
	strb r0, [r1, #0x1d]
	ldmia sp!, {r4, r5, r6, r7, pc}
_02092680:
	add r4, r4, #1
	cmp r4, r6
	blt _02092604
_0209268C:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02092698: .word 0x02143BA4
	arm_func_end DWCi_RefreshFriendListForth

	arm_func_start DWCi_DeleteFriendFromList
DWCi_DeleteFriendFromList: // 0x0209269C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r3, _02092700 // =0x02143BA4
	mov r5, r1
	ldr r1, [r3, #0]
	mov r4, r2
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	mov r2, #0xc
	mla r0, r5, r2, r0
	mov r1, #0
	bl MI_CpuFill8
	ldr r0, _02092700 // =0x02143BA4
	ldr r0, [r0, #0]
	ldr r3, [r0, #0x3c]
	cmp r3, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r2, [r0, #0x40]
	mov r0, r5
	mov r1, r4
	blx r3
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02092700: .word 0x02143BA4
	arm_func_end DWCi_DeleteFriendFromList

	arm_func_start DWCi_EndUpdateServers
DWCi_EndUpdateServers: // 0x02092704
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _02092740 // =0x02143BA4
	mov r0, #0
	ldr r3, [r1, #0]
	ldrb r1, [r3, #0x1d]
	ldr r2, [r3, #0x30]
	ldr r3, [r3, #0x2c]
	blx r3
	ldr r0, _02092740 // =0x02143BA4
	mov r1, #2
	ldr r0, [r0, #0]
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02092740: .word 0x02143BA4
	arm_func_end DWCi_EndUpdateServers

	arm_func_start DWCi_UpdateFriendReq
DWCi_UpdateFriendReq: // 0x02092744
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24c
	ldr r2, _020929A8 // =0x02143BA4
	mov r6, r0
	ldr r2, [r2, #0]
	mov r5, r1
	ldrb r0, [r2, #0x1e]
	cmp r0, #0
	bne _02092870
	ldr r0, [r2, #4]
	add r1, sp, #0x18
	bl gpGetNumBuddies
	bl DWCi_HandleGPError_2
	ldr r0, [sp, #0x18]
	mov r11, #0
	str r11, [sp, #0x1c]
	cmp r0, #0
	ble _02092860
	ldr r8, _020929A8 // =0x02143BA4
	mov r9, #1
	mov r7, #0xc
_02092798:
	ldr r0, [r8, #0]
	ldr r1, [sp, #0x1c]
	ldr r0, [r0, #4]
	add r2, sp, #0x38
	bl gpGetBuddyStatus
	bl DWCi_HandleGPError_2
	mov r4, r11
	cmp r5, #0
	ble _02092814
_020927BC:
	mov r0, r4
	bl DWCi_GetProfileIDFromList
	ldr r1, [sp, #0x38]
	cmp r1, r0
	bne _02092808
	mul r10, r4, r7
	add r0, r6, r10
	bl DWC_IsBuddyFriendData
	cmp r0, #0
	bne _02092814
	add r10, r6, r10
	ldr r1, [sp, #0x38]
	mov r0, r10
	bl DWC_SetGsProfileId
	mov r0, r10
	bl DWCi_SetBuddyFriendData
	ldr r0, [r8, #0]
	strb r9, [r0, #0x1d]
	b _02092814
_02092808:
	add r4, r4, #1
	cmp r4, r5
	blt _020927BC
_02092814:
	cmp r4, r5
	bne _02092848
	ldr r0, [r8, #0]
	ldr r1, [sp, #0x38]
	ldr r0, [r0, #4]
	bl gpDeleteBuddy
	bl DWCi_HandleGPError_2
	ldr r1, [sp, #0x18]
	ldr r0, [sp, #0x1c]
	sub r1, r1, #1
	sub r0, r0, #1
	str r1, [sp, #0x18]
	str r0, [sp, #0x1c]
_02092848:
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	add r1, r1, #1
	str r1, [sp, #0x1c]
	cmp r1, r0
	blt _02092798
_02092860:
	ldr r0, _020929A8 // =0x02143BA4
	mov r1, #1
	ldr r0, [r0, #0]
	strb r1, [r0, #0x1e]
_02092870:
	ldr r10, _020929A8 // =0x02143BA4
	ldr r0, [r10, #0]
	ldrb r0, [r0, #0x1c]
	cmp r0, r5
	addge sp, sp, #0x24c
	ldmgeia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r4, sp, #0x1c
	mov r8, #0xc
	mvn r9, #0
_02092894:
	bl DWCi_GetProfileIDFromList
	movs r7, r0
	beq _020928EC
	ldr r1, [r10, #0]
	mov r0, r6
	ldrb r1, [r1, #0x1c]
	mov r2, r7
	bl DWCi_RefreshFriendListForth
	cmp r0, #0
	bne _02092980
	ldr r0, [r10, #0]
	mov r1, r7
	ldr r0, [r0, #4]
	mov r2, r4
	bl gpGetBuddyIndex
	bl DWCi_HandleGPError_2
	ldr r0, [sp, #0x1c]
	cmp r0, r9
	bne _02092980
	mov r0, r7
	bl DWCi_GPSendBuddyRequest
	b _02092980
_020928EC:
	bl DWCi_GetUserData
	ldr r1, [r10, #0]
	ldrb r2, [r1, #0x1c]
	mla r1, r2, r8, r6
	bl DWC_GetGsProfileId
	cmp r0, r9
	bne _02092980
	bl DWCi_GetUserData
	ldr r2, _020929A8 // =0x02143BA4
	mov r1, #0xc
	ldr r3, [r2, #0]
	add r2, sp, #0x20
	ldrb r3, [r3, #0x1c]
	mla r1, r3, r1, r6
	bl DWC_LoginIdToUserName
	ldr r0, _020929A8 // =0x02143BA4
	mov r1, #0
	ldr r4, [r0, #0]
	add r2, sp, #0x20
	str r1, [sp]
	str r2, [sp, #4]
	str r1, [sp, #8]
	ldr r0, _020929AC // =DWCi_GPProfileSearchCallback
	str r1, [sp, #0xc]
	str r0, [sp, #0x10]
	ldrb r0, [r4, #0x1c]
	mov r2, r1
	mov r3, r1
	str r0, [sp, #0x14]
	ldr r0, [r4, #4]
	bl gpProfileSearchA
	ldr r0, _020929A8 // =0x02143BA4
	mov r1, #2
	ldr r0, [r0, #0]
	add sp, sp, #0x24c
	strb r1, [r0, #0x1e]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02092980:
	ldr r1, [r10, #0]
	ldrb r0, [r1, #0x1c]
	add r0, r0, #1
	strb r0, [r1, #0x1c]
	ldr r0, [r10, #0]
	ldrb r0, [r0, #0x1c]
	cmp r0, r5
	blt _02092894
	add sp, sp, #0x24c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020929A8: .word 0x02143BA4
_020929AC: .word DWCi_GPProfileSearchCallback
	arm_func_end DWCi_UpdateFriendReq

	arm_func_start DWCi_CloseFriendProcess
DWCi_CloseFriendProcess: // 0x020929B0
	ldr r0, _020929DC // =0x02143BA4
	ldr r1, [r0, #0]
	cmp r1, #0
	bxeq lr
	mov r2, #0
	str r2, [r1]
	ldr r1, [r0, #0]
	strb r2, [r1, #0x1e]
	ldr r0, [r0, #0]
	strb r2, [r0, #0x1f]
	bx lr
	.align 2, 0
_020929DC: .word 0x02143BA4
	arm_func_end DWCi_CloseFriendProcess

	arm_func_start DWCi_GPProcess
DWCi_GPProcess: // 0x020929E0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _02092A6C // =0x02143BA4
	mov r5, #0
	ldr r4, [r0, #0]
	bl OS_GetTick
	ldr r3, [r4, #0xc]
	ldr r2, [r4, #0x10]
	subs r3, r0, r3
	sbc r0, r1, r2
	mov r1, r0, lsl #6
	ldr r2, _02092A70 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, r5
	bl _ll_udiv
	cmp r1, #0
	cmpeq r0, #0x12c
	blo _02092A60
	ldr r1, [r4, #8]
	ldr r0, _02092A6C // =0x02143BA4
	add r1, r1, #1
	str r1, [r4, #8]
	ldr r0, [r0, #0]
	ldr r0, [r0, #4]
	bl gpProcess
	mov r5, r0
	bl OS_GetTick
	ldr r2, _02092A6C // =0x02143BA4
	ldr r2, [r2, #0]
	str r0, [r2, #0xc]
	str r1, [r2, #0x10]
_02092A60:
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02092A6C: .word 0x02143BA4
_02092A70: .word 0x000082EA
	arm_func_end DWCi_GPProcess

	arm_func_start DWCi_ShutdownFriend
DWCi_ShutdownFriend: // 0x02092A74
	ldr r0, _02092A84 // =0x02143BA4
	mov r1, #0
	str r1, [r0]
	bx lr
	.align 2, 0
_02092A84: .word 0x02143BA4
	arm_func_end DWCi_ShutdownFriend

	arm_func_start DWCi_CallBuddyFriendCallback
DWCi_CallBuddyFriendCallback: // 0x02092A88
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x210
	ldr r1, _02092B10 // =0x02143BA4
	mov r4, r0
	ldr r3, [r1, #0]
	ldr r2, [r3, #0x44]
	cmp r2, #0
	beq _02092ABC
	ldr r1, [r3, #0]
	cmp r1, #1
	beq _02092ABC
	ldr r1, [r3, #0x48]
	blx r2
_02092ABC:
	ldr r0, _02092B10 // =0x02143BA4
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x34]
	cmp r0, #0
	addeq sp, sp, #0x210
	ldmeqia sp!, {r4, pc}
	ldr r1, [r1, #0x18]
	mov r0, #0xc
	mla r0, r4, r0, r1
	add r1, sp, #0x108
	bl DWC_GetFriendStatus
	ldr r2, _02092B10 // =0x02143BA4
	mov r1, r0
	ldr r0, [r2, #0]
	add r2, sp, #0x108
	ldr r3, [r0, #0x38]
	ldr ip, [r0, #0x34]
	mov r0, r4
	blx ip
	add sp, sp, #0x210
	ldmia sp!, {r4, pc}
	.align 2, 0
_02092B10: .word 0x02143BA4
	arm_func_end DWCi_CallBuddyFriendCallback

	arm_func_start DWCi_SetGPStatus
DWCi_SetGPStatus: // 0x02092B14
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, _02092BB4 // =0x02143BA4
	mov r6, r0
	ldr r0, [r3, #0]
	mov r5, r1
	mov r4, r2
	cmp r0, #0
	beq _02092B40
	bl DWCi_CheckLogin
	cmp r0, #0
	bne _02092B48
_02092B40:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02092B48:
	mvn r0, #0
	cmp r6, r0
	ldreq r0, _02092BB4 // =0x02143BA4
	ldreq r0, [r0, #0]
	ldreq r0, [r0, #4]
	ldreq r0, [r0, #0]
	ldreq r6, [r0, #0x214]
	cmp r5, #0
	ldreq r0, _02092BB4 // =0x02143BA4
	mov r1, r6
	ldreq r0, [r0, #0]
	ldreq r0, [r0, #4]
	ldreq r0, [r0, #0]
	addeq r5, r0, #0x218
	cmp r4, #0
	ldreq r0, _02092BB4 // =0x02143BA4
	mov r2, r5
	ldreq r0, [r0, #0]
	ldreq r0, [r0, #4]
	ldreq r0, [r0, #0]
	addeq r4, r0, #0x318
	ldr r0, _02092BB4 // =0x02143BA4
	mov r3, r4
	ldr r0, [r0, #0]
	ldr r0, [r0, #4]
	bl sub_20A5014
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02092BB4: .word 0x02143BA4
	arm_func_end DWCi_SetGPStatus

	arm_func_start DWCi_InitGPProcessCount
DWCi_InitGPProcessCount: // 0x02092BB8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02092BF8 // =0x02143BA4
	ldr r1, [r0, #0]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #0
	str r0, [r1, #8]
	bl OS_GetTick
	ldr r2, _02092BF8 // =0x02143BA4
	ldr r2, [r2, #0]
	str r0, [r2, #0xc]
	str r1, [r2, #0x10]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02092BF8: .word 0x02143BA4
	arm_func_end DWCi_InitGPProcessCount

	arm_func_start DWCi_GetFriendListIndex
DWCi_GetFriendListIndex: // 0x02092BFC
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, _02092C64 // =0x02143BA4
	mov r6, r0
	ldr r0, [r4, #0]
	cmp r0, #0
	beq _02092C1C
	cmp r6, #0
	bne _02092C24
_02092C1C:
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02092C24:
	ldr r0, [r0, #0x14]
	mov r5, #0
	cmp r0, #0
	ble _02092C5C
_02092C34:
	mov r0, r5
	bl DWCi_GetProfileIDFromList
	cmp r6, r0
	moveq r0, r5
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #0]
	add r5, r5, #1
	ldr r0, [r0, #0x14]
	cmp r5, r0
	blt _02092C34
_02092C5C:
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02092C64: .word 0x02143BA4
	arm_func_end DWCi_GetFriendListIndex

	arm_func_start DWCi_GetProfileIDFromList
DWCi_GetProfileIDFromList: // 0x02092C68
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _02092CC4 // =0x02143BA4
	mov r5, r0
	ldr r0, [r1, #0]
	ldr r4, [r0, #0x18]
	cmp r4, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	bl DWCi_GetUserData
	mov r1, #0xc
	mla r1, r5, r1, r4
	bl DWC_GetGsProfileId
	cmp r0, #0
	beq _02092CB8
	mvn r1, #0
	cmp r0, r1
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
_02092CB8:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02092CC4: .word 0x02143BA4
	arm_func_end DWCi_GetProfileIDFromList

	arm_func_start DWCi_GetFriendListLen
DWCi_GetFriendListLen: // 0x02092CC8
	ldr r0, _02092CE0 // =0x02143BA4
	ldr r0, [r0, #0]
	cmp r0, #0
	ldrne r0, [r0, #0x14]
	moveq r0, #0
	bx lr
	.align 2, 0
_02092CE0: .word 0x02143BA4
	arm_func_end DWCi_GetFriendListLen

	arm_func_start DWCi_GPRecvBuddyStatusCallback
DWCi_GPRecvBuddyStatusCallback: // 0x02092CE4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x210
	ldr r2, _02092D64 // =0x02143BA4
	mov r6, r0
	ldr r0, [r2, #0]
	mov r5, r1
	ldr r0, [r0, #0x34]
	cmp r0, #0
	addeq sp, sp, #0x210
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r5, #0]
	bl DWCi_GetFriendListIndex
	mov r4, r0
	mvn r0, #0
	cmp r4, r0
	addeq sp, sp, #0x210
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r5, #8]
	add r2, sp, #0
	mov r0, r6
	bl gpGetBuddyStatus
	ldr r0, _02092D64 // =0x02143BA4
	ldr r1, [sp, #4]
	ldr r0, [r0, #0]
	add r2, sp, #0x108
	ldr r3, [r0, #0x38]
	ldr ip, [r0, #0x34]
	mov r0, r4
	and r1, r1, #0xff
	blx ip
	add sp, sp, #0x210
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02092D64: .word 0x02143BA4
	arm_func_end DWCi_GPRecvBuddyStatusCallback

	arm_func_start DWCi_GPRecvBuddyAuthCallback
DWCi_GPRecvBuddyAuthCallback: // 0x02092D68
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r1
	mov r5, r0
	ldr r0, [r4, #8]
	ldr r1, _02092DC0 // =aIHaveAuthorize
	bl strcmp
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, pc}
	ldr r0, _02092DC4 // =DWCi_GPGetInfoCallback_RecvAuthMessage
	mov r2, #0
	str r0, [sp]
	str r2, [sp, #4]
	ldr r1, [r4, #0]
	mov r0, r5
	mov r3, r2
	bl gpGetInfo
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02092DC0: .word aIHaveAuthorize
_02092DC4: .word DWCi_GPGetInfoCallback_RecvAuthMessage
	arm_func_end DWCi_GPRecvBuddyAuthCallback

	arm_func_start DWCi_GPRecvBuddyRequestCallback
DWCi_GPRecvBuddyRequestCallback: // 0x02092DC8
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r2, _02092E0C // =0x02143BA4
	ldr r2, [r2, #0]
	ldr r2, [r2, #0x18]
	cmp r2, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {pc}
	ldr r3, _02092E10 // =DWCi_GPGetInfoCallback_RecvBuddyRequest
	mov r2, #0
	str r3, [sp]
	str r2, [sp, #4]
	ldr r1, [r1, #0]
	mov r3, r2
	bl gpGetInfo
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_02092E0C: .word 0x02143BA4
_02092E10: .word DWCi_GPGetInfoCallback_RecvBuddyRequest
	arm_func_end DWCi_GPRecvBuddyRequestCallback

	arm_func_start DWCi_StopFriendProcess
DWCi_StopFriendProcess: // 0x02092E14
	stmdb sp!, {r4, lr}
	ldr r2, _02092E70 // =0x02143BA4
	mov r4, r0
	ldr r2, [r2, #0]
	cmp r2, #0
	ldmeqia sp!, {r4, pc}
	cmp r4, #0
	ldmeqia sp!, {r4, pc}
	bl DWCi_SetError
	ldr r0, _02092E70 // =0x02143BA4
	ldr r3, [r0, #0]
	ldr r0, [r3, #0]
	cmp r0, #0
	beq _02092E68
	cmp r0, #2
	beq _02092E68
	ldrb r1, [r3, #0x1d]
	ldr r2, [r3, #0x30]
	ldr r3, [r3, #0x2c]
	mov r0, r4
	blx r3
_02092E68:
	bl DWCi_CloseFriendProcess
	ldmia sp!, {r4, pc}
	.align 2, 0
_02092E70: .word 0x02143BA4
	arm_func_end DWCi_StopFriendProcess

	arm_func_start DWCi_UpdateServersAsync
DWCi_UpdateServersAsync: // 0x02092E74
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _02092F24 // =0x02143BA4
	ldr r5, [sp, #0x10]
	ldr r1, [r0, #0]
	ldr r4, [sp, #0x14]
	str r2, [r1, #0x2c]
	ldr r1, [r0, #0]
	ldr lr, [sp, #0x18]
	str r3, [r1, #0x30]
	ldr r1, [r0, #0]
	ldr ip, [sp, #0x1c]
	str r5, [r1, #0x34]
	ldr r1, [r0, #0]
	mov r3, #0
	str r4, [r1, #0x38]
	ldr r1, [r0, #0]
	mov r2, #1
	str lr, [r1, #0x3c]
	ldr r1, [r0, #0]
	str ip, [r1, #0x40]
	ldr r1, [r0, #0]
	strb r3, [r1, #0x1d]
	ldr r1, [r0, #0]
	strb r3, [r1, #0x1e]
	ldr r1, [r0, #0]
	strb r3, [r1, #0x1f]
	ldr r1, [r0, #0]
	strb r3, [r1, #0x1c]
	ldr r1, [r0, #0]
	str r2, [r1]
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x18]
	cmp r0, #0
	ldreqb r0, [r1, #0x1f]
	addeq r0, r0, #1
	streqb r0, [r1, #0x1f]
	ldr r0, _02092F24 // =0x02143BA4
	ldr r1, [r0, #0]
	ldrb r0, [r1, #0x1f]
	add r0, r0, #1
	strb r0, [r1, #0x1f]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02092F24: .word 0x02143BA4
	arm_func_end DWCi_UpdateServersAsync

	arm_func_start DWCi_FriendProcess
DWCi_FriendProcess: // 0x02092F28
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02093058 // =0x02143BA4
	ldr r0, [r0, #0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, [r0, #0x18]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	bl DWCi_GetPersCallbackLevel
	cmp r0, #0
	bne _02092F7C
	bl DWC__IsStatsConnected
	cmp r0, #0
	beq _02092F80
_02092F7C:
	bl DWC__PersistThink
_02092F80:
	ldr r0, _02093058 // =0x02143BA4
	ldr r0, [r0, #0]
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _0209302C
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _0209302C
	bl DWCi_GPProcess
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02093058 // =0x02143BA4
	ldr r3, [r0, #0]
	ldr r0, [r3, #0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, [r3, #0x18]
	cmp r0, #0
	beq _0209302C
	ldrb r2, [r3, #0x1e]
	cmp r2, #3
	beq _0209302C
	ldr r1, [r3, #8]
	cmp r1, #7
	bls _0209302C
	cmp r2, #1
	bhi _02092FFC
	ldr r1, [r3, #0x14]
	bl DWCi_UpdateFriendReq
_02092FFC:
	ldr r0, _02093058 // =0x02143BA4
	ldr r3, [r0, #0]
	ldrb r2, [r3, #0x1c]
	ldr r1, [r3, #0x14]
	cmp r2, r1
	blt _0209302C
	mov r1, #3
	strb r1, [r3, #0x1e]
	ldr r1, [r0, #0]
	ldrb r0, [r1, #0x1f]
	add r0, r0, #1
	strb r0, [r1, #0x1f]
_0209302C:
	ldr r0, _02093058 // =0x02143BA4
	ldr r1, [r0, #0]
	ldrb r0, [r1, #0x1f]
	cmp r0, #2
	addlo sp, sp, #4
	ldmloia sp!, {pc}
	mov r0, #0
	strb r0, [r1, #0x1f]
	bl DWCi_EndUpdateServers
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02093058: .word 0x02143BA4
	arm_func_end DWCi_FriendProcess

	arm_func_start DWCi_FriendInit
DWCi_FriendInit: // 0x0209305C
	stmdb sp!, {r4, lr}
	ldr lr, _02093138 // =0x02143BA4
	mov ip, #0
	str r0, [lr]
	str ip, [r0]
	ldr r4, [lr]
	ldr r0, [sp, #8]
	str r1, [r4, #4]
	ldr r1, [lr]
	str ip, [r1, #8]
	ldr r1, [lr]
	str ip, [r1, #0xc]
	str ip, [r1, #0x10]
	str r0, [r1, #0x14]
	ldr r0, [lr]
	str r3, [r0, #0x18]
	ldr r0, [lr]
	strb ip, [r0, #0x1c]
	ldr r0, [lr]
	strb ip, [r0, #0x1d]
	ldr r0, [lr]
	strb ip, [r0, #0x1e]
	ldr r0, [lr]
	strb ip, [r0, #0x1f]
	ldr r0, [lr]
	str ip, [r0, #0x20]
	ldr r0, [lr]
	str ip, [r0, #0x24]
	ldr r0, [lr]
	str r2, [r0, #0x28]
	ldr r0, [lr]
	str ip, [r0, #0x2c]
	ldr r0, [lr]
	str ip, [r0, #0x30]
	ldr r0, [lr]
	str ip, [r0, #0x34]
	ldr r0, [lr]
	str ip, [r0, #0x38]
	ldr r0, [lr]
	str ip, [r0, #0x3c]
	ldr r0, [lr]
	str ip, [r0, #0x40]
	ldr r0, [lr]
	str ip, [r0, #0x44]
	ldr r0, [lr]
	str ip, [r0, #0x48]
	ldr r0, [lr]
	str ip, [r0, #0x4c]
	ldr r0, [lr]
	str ip, [r0, #0x50]
	ldr r0, [lr]
	str ip, [r0, #0x54]
	ldr r0, [lr]
	str ip, [r0, #0x58]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02093138: .word 0x02143BA4
	arm_func_end DWCi_FriendInit

	arm_func_start DWC_LogoutFromStorageServer
DWC_LogoutFromStorageServer: // 0x0209313C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl CloseStatsConnection
	ldr r0, _0209316C // =0x02143BA4
	ldr r1, _02093170 // =0x02143BA8
	ldr r0, [r0, #0]
	mov r2, #0
	str r2, [r1]
	cmp r0, #0
	strne r2, [r0, #0x20]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209316C: .word 0x02143BA4
_02093170: .word 0x02143BA8
	arm_func_end DWC_LogoutFromStorageServer

	arm_func_start DWC_SetBuddyFriendCallback
DWC_SetBuddyFriendCallback: // 0x02093174
	ldr r2, _02093198 // =0x02143BA4
	ldr r3, [r2, #0]
	cmp r3, #0
	moveq r0, #0
	strne r0, [r3, #0x44]
	ldrne r2, [r2, #0]
	movne r0, #1
	strne r1, [r2, #0x48]
	bx lr
	.align 2, 0
_02093198: .word 0x02143BA4
	arm_func_end DWC_SetBuddyFriendCallback

	arm_func_start DWC_DeleteBuddyFriendData
DWC_DeleteBuddyFriendData: // 0x0209319C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _02093238 // =0x02143BA4
	mov r4, r0
	ldr r0, [r1, #0]
	cmp r0, #0
	beq _02093220
	bl DWCi_CheckLogin
	cmp r0, #0
	beq _02093220
	bl DWCi_GetUserData
	cmp r0, #0
	beq _02093220
	bl DWCi_GetUserData
	mov r1, r4
	bl DWC_GetGsProfileId
	movs r5, r0
	beq _02093220
	mvn r0, #0
	cmp r5, r0
	beq _02093220
	ldr r0, _02093238 // =0x02143BA4
	mov r1, r5
	ldr r0, [r0, #0]
	ldr r0, [r0, #4]
	bl gpIsBuddy
	cmp r0, #0
	beq _02093220
	ldr r0, _02093238 // =0x02143BA4
	mov r1, r5
	ldr r0, [r0, #0]
	ldr r0, [r0, #4]
	bl gpDeleteBuddy
_02093220:
	mov r0, r4
	mov r1, #0
	mov r2, #0xc
	bl MI_CpuFill8
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02093238: .word 0x02143BA4
	arm_func_end DWC_DeleteBuddyFriendData

	arm_func_start DWC_GetFriendStatusSC
DWC_GetFriendStatusSC: // 0x0209323C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x218
	mov r6, r1
	add r1, sp, #4
	mov r4, r2
	mov r5, r3
	bl DWCi_GetFriendBuddyStatus
	cmp r0, #0
	beq _0209332C
	ldr r0, [sp, #8]
	cmp r0, #6
	bne _020932F0
	cmp r6, #0
	beq _020932AC
	ldr r0, _02093350 // =_0211C24C
	add r1, sp, #0
	add r2, sp, #0xc
	mov r3, #0x2f
	bl DWC_GetCommonValueString
	cmp r0, #0
	movle r0, #0
	strleb r0, [r6]
	ble _020932AC
	add r0, sp, #0
	mov r1, #0
	mov r2, #0xa
	bl strtoul
	strb r0, [r6]
_020932AC:
	cmp r4, #0
	beq _02093308
	ldr r0, _02093354 // =0x0211C250
	add r1, sp, #0
	add r2, sp, #0xc
	mov r3, #0x2f
	bl DWC_GetCommonValueString
	cmp r0, #0
	movle r0, #0
	strleb r0, [r4]
	ble _02093308
	add r0, sp, #0
	mov r1, #0
	mov r2, #0xa
	bl strtoul
	strb r0, [r4]
	b _02093308
_020932F0:
	cmp r6, #0
	movne r0, #0
	strneb r0, [r6]
	cmp r4, #0
	movne r0, #0
	strneb r0, [r4]
_02093308:
	cmp r5, #0
	beq _0209331C
	add r1, sp, #0x10c
	mov r0, r5
	bl strcpy
_0209331C:
	ldr r0, [sp, #8]
	add sp, sp, #0x218
	and r0, r0, #0xff
	ldmia sp!, {r4, r5, r6, pc}
_0209332C:
	cmp r6, #0
	movne r0, #0
	strneb r0, [r6]
	cmp r4, #0
	movne r0, #0
	strneb r0, [r4]
	mov r0, #0
	add sp, sp, #0x218
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02093350: .word _0211C24C
_02093354: .word 0x0211C250
	arm_func_end DWC_GetFriendStatusSC

	arm_func_start DWC_GetFriendStatus
DWC_GetFriendStatus: // 0x02093358
	ldr ip, _0209336C // =DWC_GetFriendStatusSC
	mov r3, r1
	mov r1, #0
	mov r2, r1
	bx ip
	.align 2, 0
_0209336C: .word DWC_GetFriendStatusSC
	arm_func_end DWC_GetFriendStatus

	.data
	
.public _0211C1F0
_0211C1F0:
	.byte 0x00, 0x00, 0x00, 0x00, 0x47, 0x50, 0x43, 0x4D, 0x00, 0x00, 0x00, 0x00, 0x4D, 0x41, 0x54, 0x00
	.byte 0x00, 0x00, 0x00, 0x00

aCCCC: // 0x0211C204
	.asciz "%c%c%c%c"
	.align 4
	
.public _0211C210
_0211C210:
	.byte 0x00, 0x00, 0x00, 0x00

aIHaveAuthorize: // 0x0211C214
	.asciz "I have authorized your request to add me to your list"
	.align 4
	
.public _0211C24C
_0211C24C:
	.byte 0x53, 0x43, 0x4D, 0x00
	.byte 0x53, 0x43, 0x4E, 0x00, 0x25, 0x75, 0x00, 0x00, 0x53, 0x42, 0x43, 0x4D, 0x00, 0x00, 0x00, 0x00
