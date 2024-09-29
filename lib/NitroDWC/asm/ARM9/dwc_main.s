	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWCi_GT2SocketErrorCallback
DWCi_GT2SocketErrorCallback: // 0x0208F820
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl gt2GetSocketSOCKET
	bl WSAGetLastError
	ldr r2, _0208F85C // =0x02143A14
	ldr r1, _0208F860 // =0xFFFE8515
	str r0, [r2]
	mov r0, #9
	bl DWCi_SetError
	ldr r0, _0208F864 // =0x02143A10
	mov r1, #0
	ldr r0, [r0]
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208F85C: .word 0x02143A14
_0208F860: .word 0xFFFE8515
_0208F864: .word 0x02143A10
	arm_func_end DWCi_GT2SocketErrorCallback

	arm_func_start DWCi_GT2PingCallback
DWCi_GT2PingCallback: // 0x0208F868
	ldr ip, _0208F870 // =DWCi_PingCallback
	bx ip
	.align 2, 0
_0208F870: .word DWCi_PingCallback
	arm_func_end DWCi_GT2PingCallback

	arm_func_start DWCi_GT2ClosedCallback
DWCi_GT2ClosedCallback: // 0x0208F874
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r7, #0
	mov r11, r0
	mov r9, r1
	mov r10, r7
	bl DWCi_IsShutdownMatch
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r9, #4
	addls pc, pc, r9, lsl #2
	b _0208F8D8
_0208F8A8: // jump table
	b _0208F8BC // case 0
	b _0208F8BC // case 1
	b _0208F8C4 // case 2
	b _0208F8C4 // case 3
	b _0208F8D0 // case 4
_0208F8BC:
	mov r4, r7
	b _0208F8D8
_0208F8C4:
	mov r4, #6
	ldr r6, _0208FBDC // =0xFFFFE250
	b _0208F8D8
_0208F8D0:
	ldr r6, _0208FBE0 // =0xFFFFE24F
	mov r4, #9
_0208F8D8:
	cmp r4, #0
	bne _0208F990
	mov r0, r11
	bl gt2GetConnectionData
	movs r7, r0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, _0208FBE4 // =0x02143A10
	ldrb r8, [r7, #1]
	ldr r1, [r0]
	mov r5, #1
	mov r0, r5, lsl r8
	ldr r1, [r1, #0x644]
	ands r0, r1, r0
	mov r0, r8
	moveq r5, #0
	bl DWCi_ClearTransConnection
	ldr r0, _0208FBE4 // =0x02143A10
	ldr r1, [r0]
	ldrb r0, [r1, #0x369]
	cmp r0, #2
	bne _0208F938
	cmp r9, #0
	beq _0208F94C
_0208F938:
	ldrb r0, [r1, #0x369]
	cmp r0, #3
	bne _0208F950
	cmp r8, #0
	bne _0208F950
_0208F94C:
	mov r10, #1
_0208F950:
	mov r0, r8
	bl DWCi_DeleteAID
	ldr r1, _0208FBE4 // =0x02143A10
	ldrb r7, [r7]
	ldr r2, _0208FBE8 // =0x02143A18
	mov r11, #0
	ldr r3, [r1]
	str r11, [r2, r7, lsl #2]
	ldrb r2, [r3, #0x361]
	mov r7, r0
	sub r0, r2, #1
	strb r0, [r3, #0x361]
	ldr r1, [r1]
	ldrb r0, [r1, #0x368]
	sub r0, r0, #1
	strb r0, [r1, #0x368]
_0208F990:
	ldr r0, _0208FBE4 // =0x02143A10
	ldr r1, [r0]
	ldrb r0, [r1, #0x2d]
	cmp r0, #0
	bne _0208F9E8
	ldr r0, [r1, #0x24]
	cmp r0, #6
	bne _0208F9E8
	cmp r5, #0
	bne _0208F9E8
	ldrb r0, [r1, #0x369]
	cmp r0, #2
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r4, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl DWCi_GPSetServerStatus
	mov r0, r7
	bl DWCi_ProcessMatchSCClosing
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208F9E8:
	mov r0, r4
	mov r1, r6
	mov r2, r7
	bl DWCi_ProcessMatchClosing
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r4, #0
	beq _0208FA20
	mov r0, r4
	mov r1, r6
	bl DWCi_SetError
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208FA20:
	ldr r0, _0208FBE4 // =0x02143A10
	ldr r1, [r0]
	ldrb r0, [r1, #0x2d]
	cmp r0, #0
	bne _0208FA94
	ldrb r0, [r1, #0x369]
	cmp r0, #2
	beq _0208FA4C
	ldrb r0, [r1, #0x369]
	cmp r0, #3
	bne _0208FA94
_0208FA4C:
	ldr r2, _0208FBE4 // =0x02143A10
	ldr r1, [r2]
	ldrb r0, [r1, #0x361]
	add r6, r0, #2
	add r3, r1, r6, lsl #2
	ldr r3, [r3, #0x448]
	cmp r3, #0
	beq _0208FA94
	add r3, r1, r6
	ldrb r3, [r3, #0x624]
	add r0, r0, #1
	add r0, r1, r0
	strb r3, [r0, #0x624]
	ldr r0, [r2]
	ldrb r1, [r0, #0x361]
	add r0, r1, #1
	add r1, r1, #3
	bl DWCi_DeleteHostByIndex
_0208FA94:
	ldr r0, _0208FBE4 // =0x02143A10
	ldr r1, [r0]
	ldrb r0, [r1, #0x369]
	cmp r0, #2
	bne _0208FADC
	ldrb r0, [r1, #0x2d]
	cmp r0, #0
	bne _0208FABC
	bl DWCi_GPSetServerStatus
	b _0208FAF8
_0208FABC:
	ldrb r0, [r1, #0x361]
	cmp r0, #0
	bne _0208FAF8
	ldr r1, _0208FBEC // =0x0211C1F0
	mov r0, #1
	mov r2, #0
	bl DWCi_SetGPStatus
	b _0208FAF8
_0208FADC:
	ldrb r0, [r1, #0x361]
	cmp r0, #0
	bne _0208FAF8
	ldr r1, _0208FBEC // =0x0211C1F0
	mov r0, #1
	mov r2, #0
	bl DWCi_SetGPStatus
_0208FAF8:
	ldr r0, _0208FBE4 // =0x02143A10
	ldr r1, [r0]
	ldrb r0, [r1, #0x369]
	cmp r0, #0
	beq _0208FB18
	ldrb r0, [r1, #0x369]
	cmp r0, #1
	bne _0208FB34
_0208FB18:
	ldr r0, _0208FBE4 // =0x02143A10
	ldr r2, [r0]
	ldrb r1, [r2, #0x368]
	strb r1, [r2, #0x36a]
	ldr r0, [r0]
	ldr r0, [r0, #0x364]
	bl qr2_send_statechanged
_0208FB34:
	ldr r0, _0208FBE4 // =0x02143A10
	ldr r6, [r0]
	ldr r0, [r6, #0x90]
	cmp r0, #0
	beq _0208FB90
	cmp r5, #0
	beq _0208FB90
	cmp r9, #0
	moveq r5, #1
	mov r0, r7
	movne r5, #0
	bl DWCi_GetFriendListIndex
	str r0, [sp]
	ldr r1, [r6, #0x94]
	ldr r0, _0208FBE4 // =0x02143A10
	str r1, [sp, #4]
	ldr r1, [r0]
	mov r0, r4
	ldr r4, [r1, #0x90]
	mov r1, r5
	mov r2, r10
	mov r3, r8
	blx r4
_0208FB90:
	ldr r0, _0208FBE4 // =0x02143A10
	ldr r1, [r0]
	ldrb r0, [r1, #0x2d]
	cmp r0, #0
	bne _0208FBB4
	ldrb r0, [r1, #0x369]
	cmp r0, #2
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208FBB4:
	ldrb r0, [r1, #0x361]
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl NNFreeNegotiateList
	bl DWCi_ClearQR2Key
	mov r0, #3
	bl DWCi_SetState
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0208FBDC: .word 0xFFFFE250
_0208FBE0: .word 0xFFFFE24F
_0208FBE4: .word 0x02143A10
_0208FBE8: .word 0x02143A18
_0208FBEC: .word 0x0211C1F0
	arm_func_end DWCi_GT2ClosedCallback

	arm_func_start DWCi_GT2ReceivedCallback
DWCi_GT2ReceivedCallback: // 0x0208FBF0
	ldr ip, _0208FBF8 // =DWCi_RecvCallback
	bx ip
	.align 2, 0
_0208FBF8: .word DWCi_RecvCallback
	arm_func_end DWCi_GT2ReceivedCallback

	arm_func_start DWCi_GPRecvBuddyMessageCallback
DWCi_GPRecvBuddyMessageCallback: // 0x0208FBFC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	add r4, sp, #0
	mov r3, #0
	strb r3, [r4]
	strb r3, [r4, #1]
	strb r3, [r4, #2]
	strb r3, [r4, #3]
	strb r3, [r4, #4]
	strb r3, [r4, #5]
	strb r3, [r4, #6]
	strb r3, [r4, #7]
	strb r3, [r4, #8]
	strb r3, [r4, #9]
	strb r3, [r4, #0xa]
	mov r5, r1
	strb r3, [r4, #0xb]
	ldr r4, [r5, #8]
	mov r6, r0
	bl DWCi_GPRecvBuddyAuthCallback
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0208FD58 // =0x0211C1F4
	bl strlen
	mov r2, r0
	ldr r1, _0208FD58 // =0x0211C1F4
	mov r0, r4
	bl memcmp
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0208FD58 // =0x0211C1F4
	bl strlen
	add r4, r4, r0
	mov r0, r4
	mov r1, #0x76
	bl strchr
	sub r7, r0, r4
	add r0, sp, #0
	mov r1, r4
	mov r2, r7
	bl strncpy
	cmp r7, #0xa
	addhi sp, sp, #0xc
	ldmhiia sp!, {r4, r5, r6, r7, pc}
	add r0, sp, #0
	mov r1, #0
	mov r2, #0xa
	bl strtoul
	cmp r0, #3
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0208FD5C // =0x0211C1FC
	add r1, r7, #1
	add r4, r4, r1
	bl strlen
	mov r2, r0
	ldr r1, _0208FD5C // =0x0211C1FC
	mov r0, r4
	bl memcmp
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0208FD60 // =0x02143A10
	ldr r1, [r0]
	ldr r0, [r1, #0x24]
	cmp r0, #5
	beq _0208FD38
	cmp r0, #6
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldrb r0, [r1, #0x369]
	cmp r0, #2
	beq _0208FD38
	ldrb r0, [r1, #0x369]
	cmp r0, #3
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
_0208FD38:
	ldr r0, _0208FD5C // =0x0211C1FC
	bl strlen
	add r2, r4, r0
	ldr r1, [r5]
	mov r0, r6
	bl DWCi_MatchGPRecvBuddyMsgCallback
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0208FD58: .word 0x0211C1F4
_0208FD5C: .word 0x0211C1FC
_0208FD60: .word 0x02143A10
	arm_func_end DWCi_GPRecvBuddyMessageCallback

	arm_func_start DWCi_GPErrorCallback
DWCi_GPErrorCallback: // 0x0208FD64
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, [r1, #4]
	ldr r0, _0208FDB0 // =0x00000603
	cmp r1, r0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _0208FDB4 // =0x00000901
	cmp r1, r0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _0208FDB8 // =0x00000B01
	cmp r1, r0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r0, #3
	bl DWCi_HandleGPError_3
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208FDB0: .word 0x00000603
_0208FDB4: .word 0x00000901
_0208FDB8: .word 0x00000B01
	arm_func_end DWCi_GPErrorCallback

	arm_func_start DWCi_MatchedCallback
DWCi_MatchedCallback: // 0x0208FDBC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bne _0208FE04
	cmp r6, #0
	beq _0208FE04
	ldr r0, _0208FF3C // =0x02143A10
	ldr r0, [r0]
	ldr r0, [r0, #0x4f4]
	cmp r0, #0
	bne _0208FE68
	bl DWCi_ClearQR2Key
	mov r0, #3
	bl DWCi_SetState
	b _0208FE68
_0208FE04:
	cmp r7, #0
	bne _0208FE68
	mov r0, #6
	bl DWCi_SetState
	ldr r1, _0208FF3C // =0x02143A10
	mov r0, #0
	ldr r3, [r1]
	ldrb r1, [r3, #0x361]
	cmp r1, #0
	blt _0208FE68
	ldr r2, [r3, #0x64]
_0208FE30:
	add r1, r3, r0, lsl #2
	ldr r1, [r1, #0x448]
	cmp r2, r1
	bne _0208FE58
	ldr r1, _0208FF3C // =0x02143A10
	ldr r1, [r1]
	add r0, r1, r0
	ldrb r0, [r0, #0x624]
	strb r0, [r1, #0x2c]
	b _0208FE68
_0208FE58:
	ldrb r1, [r3, #0x361]
	add r0, r0, #1
	cmp r0, r1
	ble _0208FE30
_0208FE68:
	ldr r1, _0208FF3C // =0x02143A10
	ldr r0, _0208FF40 // =0x00000624
	ldr r2, [r1]
	ldrb r1, [r2, #0x361]
	add r0, r2, r0
	add r1, r1, #1
	bl DWCi_GetAIDBitmapFromList
	ldr r1, _0208FF3C // =0x02143A10
	ldr r1, [r1]
	str r0, [r1, #0x644]
	bl DWCi_SetNumValidConnection
	ldr r0, _0208FF3C // =0x02143A10
	ldr r1, [r0]
	ldrb r0, [r1, #0x369]
	cmp r0, #2
	beq _0208FEB4
	ldrb r0, [r1, #0x369]
	cmp r0, #3
	bne _0208FEE8
_0208FEB4:
	ldr r0, _0208FF3C // =0x02143A10
	ldr r1, [sp, #0x20]
	ldr r3, [r0]
	mov r0, r7
	str r1, [sp]
	ldr r2, [r3, #0x8c]
	mov r1, r6
	str r2, [sp, #4]
	ldr r6, [r3, #0x88]
	mov r2, r5
	mov r3, r4
	blx r6
	b _0208FEFC
_0208FEE8:
	ldr r2, [r1, #0x84]
	ldr r3, [r1, #0x80]
	mov r0, r7
	mov r1, r6
	blx r3
_0208FEFC:
	cmp r7, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0208FF3C // =0x02143A10
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r0, #0x24]
	cmp r0, #5
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r0, #3
	bl DWCi_SetState
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0208FF3C: .word 0x02143A10
_0208FF40: .word 0x00000624
	arm_func_end DWCi_MatchedCallback

	arm_func_start DWCi_UpdateServersCallback
DWCi_UpdateServersCallback: // 0x0208FF44
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r2, _0208FF90 // =0x02143A10
	mov r5, r0
	ldr r0, [r2]
	mov r4, r1
	ldr r0, [r0, #0x28]
	cmp r0, #4
	beq _0208FF6C
	bl DWCi_SetState
_0208FF6C:
	ldr r1, _0208FF90 // =0x02143A10
	mov r0, r5
	ldr r3, [r1]
	mov r1, r4
	ldr r2, [r3, #0x7c]
	ldr r3, [r3, #0x78]
	blx r3
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0208FF90: .word 0x02143A10
	arm_func_end DWCi_UpdateServersCallback

	arm_func_start DWCi_LoginCallback
DWCi_LoginCallback: // 0x0208FF94
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r0
	mov r4, r1
	bne _0208FFC4
	ldr r1, _0208FFFC // =0x02143A10
	mov r0, #3
	ldr r1, [r1]
	str r4, [r1, #0x64]
	bl DWCi_SetState
	bl DWCi_InitGPProcessCount
	b _0208FFCC
_0208FFC4:
	mov r0, #0
	bl DWCi_SetState
_0208FFCC:
	ldr r0, _0208FFFC // =0x02143A10
	ldr r0, [r0]
	ldr r3, [r0, #0x70]
	cmp r3, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r2, [r0, #0x74]
	mov r0, r5
	mov r1, r4
	blx r3
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0208FFFC: .word 0x02143A10
	arm_func_end DWCi_LoginCallback

	arm_func_start DWCi_HandleGT2Error
DWCi_HandleGT2Error: // 0x02090000
	stmdb sp!, {r4, lr}
	movs r4, r0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	cmp r4, #7
	addls pc, pc, r4, lsl #2
	b _02090084
_0209001C: // jump table
	b _02090084 // case 0
	b _0209003C // case 1
	b _02090048 // case 2
	b _02090058 // case 3
	b _02090064 // case 4
	b _02090048 // case 5
	b _02090070 // case 6
	b _0209007C // case 7
_0209003C:
	mov r0, #9
	mvn r2, #0
	b _02090084
_02090048:
	mov r0, #0
	mov r2, r0
	mov r4, r0
	b _02090084
_02090058:
	mov r0, #6
	mvn r2, #9
	b _02090084
_02090064:
	mov r0, #6
	mvn r2, #0x1d
	b _02090084
_02090070:
	mov r0, #6
	mvn r2, #0x45
	b _02090084
_0209007C:
	mov r0, #6
	mvn r2, #0x4f
_02090084:
	cmp r0, #0
	beq _02090098
	ldr r1, _020900A0 // =0xFFFEFA48
	add r1, r2, r1
	bl DWCi_StopLogin
_02090098:
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_020900A0: .word 0xFFFEFA48
	arm_func_end DWCi_HandleGT2Error

	arm_func_start DWCi_HandleGPError_3
DWCi_HandleGPError_3: // 0x020900A4
	stmdb sp!, {r4, r5, r6, lr}
	movs r6, r0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r6, #4
	addls pc, pc, r6, lsl #2
	b _02090100
_020900C0: // jump table
	b _02090100 // case 0
	b _020900D4 // case 1
	b _020900E0 // case 2
	b _020900EC // case 3
	b _020900F8 // case 4
_020900D4:
	mov r4, #9
	mvn r5, #0
	b _02090100
_020900E0:
	mov r4, #9
	mvn r5, #1
	b _02090100
_020900EC:
	mov r4, #6
	mvn r5, #9
	b _02090100
_020900F8:
	mov r4, #6
	mvn r5, #0x13
_02090100:
	ldr r0, _020901AC // =0x02143A10
	ldr r1, [r0]
	ldr r0, [r1, #0x24]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02090190
_02090118: // jump table
	b _02090190 // case 0
	b _02090130 // case 1
	b _02090148 // case 2
	b _02090190 // case 3
	b _02090184 // case 4
	b _0209016C // case 5
_02090130:
	ldr r1, _020901B0 // =0xFFFF11B8
	mov r0, r4
	add r5, r5, r1
	mov r1, r5
	bl DWCi_StopLogin
	b _02090198
_02090148:
	ldr r1, [r1, #0x9c]
	ldr r0, _020901B0 // =0xFFFF11B8
	cmp r1, #1
	add r5, r5, r0
	bge _02090198
	mov r0, r4
	mov r1, r5
	bl DWCi_StopLogin
	b _02090198
_0209016C:
	ldr r1, _020901B4 // =0xFFFEC398
	mov r0, r4
	add r5, r5, r1
	mov r1, r5
	bl DWCi_StopMatching
	b _02090198
_02090184:
	ldr r0, _020901B8 // =0xFFFEEAA8
	add r5, r5, r0
	b _02090198
_02090190:
	ldr r0, _020901BC // =0xFFFE9C88
	add r5, r5, r0
_02090198:
	mov r0, r4
	mov r1, r5
	bl DWCi_StopFriendProcess
	mov r0, r6
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020901AC: .word 0x02143A10
_020901B0: .word 0xFFFF11B8
_020901B4: .word 0xFFFEC398
_020901B8: .word 0xFFFEEAA8
_020901BC: .word 0xFFFE9C88
	arm_func_end DWCi_HandleGPError_3

	arm_func_start DWCi_GetAIDBitmapFromList
DWCi_GetAIDBitmapFromList: // 0x020901C0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, #0
	mov ip, lr
	cmp r1, #0
	ble _020901F0
	mov r3, #1
_020901DC:
	ldrb r2, [r0, ip]
	add ip, ip, #1
	cmp ip, r1
	orr lr, lr, r3, lsl r2
	blt _020901DC
_020901F0:
	mov r0, lr
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_GetAIDBitmapFromList

	arm_func_start DWCi_DeleteAID
DWCi_DeleteAID: // 0x020901FC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, sp, #0
	bl DWCi_GetAllAIDList
	mov r1, r0
	cmp r1, #0
	mov r0, #0
	ble _02090240
	ldr r3, [sp]
_02090224:
	ldrb r2, [r3]
	cmp r4, r2
	beq _02090240
	add r0, r0, #1
	cmp r0, r1
	add r3, r3, #1
	blt _02090224
_02090240:
	cmp r0, r1
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	bl DWCi_DeleteHostByIndex
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end DWCi_DeleteAID

	arm_func_start DWCi_SetState
DWCi_SetState: // 0x0209025C
	ldr r1, _02090278 // =0x02143A10
	ldr r3, [r1]
	ldr r2, [r3, #0x24]
	str r2, [r3, #0x28]
	ldr r1, [r1]
	str r0, [r1, #0x24]
	bx lr
	.align 2, 0
_02090278: .word 0x02143A10
	arm_func_end DWCi_SetState

	arm_func_start DWCs_ForceShutdown
DWCs_ForceShutdown: // 0x0209027C
	bx lr
	arm_func_end DWCs_ForceShutdown

	arm_func_start DWCi_IsValidAID
DWCi_IsValidAID: // 0x02090280
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, #0
	ldr r4, _020902C4 // =0x02143A18
_02090290:
	ldr r0, [r4, r5, lsl #2]
	cmp r0, #0
	beq _020902B0
	bl gt2GetConnectionData
	ldrb r0, [r0, #1]
	cmp r6, r0
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, pc}
_020902B0:
	add r5, r5, #1
	cmp r5, #0x20
	blt _02090290
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020902C4: .word 0x02143A18
	arm_func_end DWCi_IsValidAID

	arm_func_start DWCi_GetConnectionInfoByIdx
DWCi_GetConnectionInfoByIdx: // 0x020902C8
	ldr r1, _020902D4 // =0x02143A98
	add r0, r1, r0, lsl #3
	bx lr
	.align 2, 0
_020902D4: .word 0x02143A98
	arm_func_end DWCi_GetConnectionInfoByIdx

	arm_func_start DWCi_GetGT2ConnectionByProfileID
DWCi_GetGT2ConnectionByProfileID: // 0x020902D8
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #0
	mov ip, #0
	ble _02090314
	ldr r2, _02090348 // =0x02143A10
	ldr r3, [r2]
_020902F4:
	add r2, r3, ip, lsl #2
	ldr r2, [r2, #0x448]
	cmp r0, r2
	beq _02090314
	add r2, ip, #1
	and ip, r2, #0xff
	cmp ip, r1
	blt _020902F4
_02090314:
	cmp ip, r1
	addge sp, sp, #4
	movge r0, #0
	ldmgeia sp!, {pc}
	ldr r0, _02090348 // =0x02143A10
	ldr r0, [r0]
	add r0, r0, ip
	ldrb r0, [r0, #0x624]
	bl DWCi_GetGT2Connection
	bl DWCi_GetConnectionIndex
	bl DWCi_GetGT2ConnectionByIdx
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02090348: .word 0x02143A10
	arm_func_end DWCi_GetGT2ConnectionByProfileID

	arm_func_start DWCi_GetGT2ConnectionByIdx
DWCi_GetGT2ConnectionByIdx: // 0x0209034C
	ldr r1, _02090358 // =0x02143A18
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02090358: .word 0x02143A18
	arm_func_end DWCi_GetGT2ConnectionByIdx

	arm_func_start DWCi_ClearGT2ConnectionList
DWCi_ClearGT2ConnectionList: // 0x0209035C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0209038C // =0x02143A18
	mov r0, #0
	mov r2, #0x80
	bl MIi_CpuClear32
	ldr r1, _02090390 // =0x02143A98
	mov r0, #0
	mov r2, #0x100
	bl MIi_CpuClear32
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209038C: .word 0x02143A18
_02090390: .word 0x02143A98
	arm_func_end DWCi_ClearGT2ConnectionList

	arm_func_start DWCi_GT2GetConnectionListIdx
DWCi_GT2GetConnectionListIdx: // 0x02090394
	ldr r2, _020903BC // =0x02143A18
	mov r0, #0
_0209039C:
	ldr r1, [r2, r0, lsl #2]
	cmp r1, #0
	bxeq lr
	add r0, r0, #1
	cmp r0, #0x20
	blt _0209039C
	mvn r0, #0
	bx lr
	.align 2, 0
_020903BC: .word 0x02143A18
	arm_func_end DWCi_GT2GetConnectionListIdx

	arm_func_start DWCi_GetConnectionIndex
DWCi_GetConnectionIndex: // 0x020903C0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl gt2GetConnectionData
	ldrb r0, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_GetConnectionIndex

	arm_func_start DWCi_GetConnectionAID
DWCi_GetConnectionAID: // 0x020903D8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl gt2GetConnectionData
	ldrb r0, [r0, #1]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_GetConnectionAID

	arm_func_start DWCi_GetGT2Connection
DWCi_GetGT2Connection: // 0x020903F0
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _0209044C // =0x02143A10
	mov r6, r0
	ldr r0, [r1]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r4, _02090450 // =0x02143A18
	mov r5, #0
_02090414:
	ldr r0, [r4, r5, lsl #2]
	cmp r0, #0
	beq _02090438
	bl gt2GetConnectionData
	ldrb r0, [r0, #1]
	cmp r6, r0
	ldreq r0, _02090450 // =0x02143A18
	ldreq r0, [r0, r5, lsl #2]
	ldmeqia sp!, {r4, r5, r6, pc}
_02090438:
	add r5, r5, #1
	cmp r5, #0x20
	blt _02090414
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209044C: .word 0x02143A10
_02090450: .word 0x02143A18
	arm_func_end DWCi_GetGT2Connection

	arm_func_start DWCi_GT2Startup
DWCi_GT2Startup: // 0x02090454
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r0, _0209050C // =0x02143A10
	ldr r0, [r0]
	ldr r0, [r0]
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, #0x4000
	bl DWCi_GetMathRand32
	add r0, r0, #0xc000
	mov r1, r0, lsl #0x10
	ldr r3, _0209050C // =0x02143A10
	mov r0, #0
	mov r2, r0
	mov r1, r1, lsr #0x10
	ldr r4, [r3]
	bl gt2AddressToString
	ldr r1, _02090510 // =DWCi_GT2SocketErrorCallback
	ldr r2, _0209050C // =0x02143A10
	str r1, [sp]
	mov r1, r0
	ldr r0, [r2]
	ldr r2, [r4, #0x14]
	ldr r3, [r4, #0x18]
	bl gt2CreateSocket
	mov r4, r0
	bl DWCi_HandleGT2Error
	cmp r0, #0
	addne sp, sp, #8
	movne r0, r4
	ldmneia sp!, {r4, pc}
	ldr r0, _0209050C // =0x02143A10
	ldr r1, _02090514 // =DWCi_GT2ConnectAttemptCallback
	ldr r0, [r0]
	ldr r0, [r0]
	bl gt2Listen
	ldr r0, _0209050C // =0x02143A10
	ldr r1, _02090518 // =DWCi_GT2UnrecognizedMessageCallback
	ldr r0, [r0]
	ldr r0, [r0]
	bl gt2SetUnrecognizedMessageCallback
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209050C: .word 0x02143A10
_02090510: .word DWCi_GT2SocketErrorCallback
_02090514: .word DWCi_GT2ConnectAttemptCallback
_02090518: .word DWCi_GT2UnrecognizedMessageCallback
	arm_func_end DWCi_GT2Startup

	arm_func_start DWC_GetState
DWC_GetState: // 0x0209051C
	ldr r0, _02090534 // =0x02143A10
	ldr r0, [r0]
	cmp r0, #0
	ldrne r0, [r0, #0x24]
	moveq r0, #0
	bx lr
	.align 2, 0
_02090534: .word 0x02143A10
	arm_func_end DWC_GetState

	arm_func_start DWC_IsValidAID
DWC_IsValidAID: // 0x02090538
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _02090580 // =0x02143A10
	ldr r2, [r1]
	cmp r2, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	mov r1, #1
	mov r1, r1, lsl r0
	ldr r2, [r2, #0x644]
	ands r1, r2, r1
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	bl DWCi_IsValidAID
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02090580: .word 0x02143A10
	arm_func_end DWC_IsValidAID

	arm_func_start DWC_GetAIDBitmap
DWC_GetAIDBitmap: // 0x02090584
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020905C0 // =0x02143A10
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	add r0, sp, #0
	bl DWC_GetAIDList
	mov r1, r0
	ldr r0, [sp]
	bl DWCi_GetAIDBitmapFromList
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020905C0: .word 0x02143A10
	arm_func_end DWC_GetAIDBitmap

	arm_func_start DWC_GetAIDList
DWC_GetAIDList: // 0x020905C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _02090624 // =0x02143A10
	ldr r3, [r2]
	cmp r3, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	ldr r1, _02090628 // =0x00000624
	add r1, r3, r1
	str r1, [r0]
	ldr r2, [r2]
	ldrb r1, [r2, #0x369]
	cmp r1, #2
	beq _0209060C
	ldrb r1, [r2, #0x369]
	cmp r1, #3
	bne _02090618
_0209060C:
	bl DWCi_GetValidAIDList
	add sp, sp, #4
	ldmia sp!, {pc}
_02090618:
	bl DWCi_GetAllAIDList
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02090624: .word 0x02143A10
_02090628: .word 0x00000624
	arm_func_end DWC_GetAIDList

	arm_func_start DWC_GetMyAID
DWC_GetMyAID: // 0x0209062C
	ldr r0, _02090644 // =0x02143A10
	ldr r0, [r0]
	cmp r0, #0
	ldrneb r0, [r0, #0x2c]
	moveq r0, #0
	bx lr
	.align 2, 0
_02090644: .word 0x02143A10
	arm_func_end DWC_GetMyAID

	arm_func_start DWC_GetNumConnectionHost
DWC_GetNumConnectionHost: // 0x02090648
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020906A0 // =0x02143A10
	ldr r1, [r0]
	cmp r1, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	ldrb r0, [r1, #0x369]
	cmp r0, #2
	beq _02090680
	ldrb r0, [r1, #0x369]
	cmp r0, #3
	bne _02090690
_02090680:
	bl DWCi_GetNumValidConnection
	add sp, sp, #4
	add r0, r0, #1
	ldmia sp!, {pc}
_02090690:
	bl DWCi_GetNumAllConnection
	add r0, r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020906A0: .word 0x02143A10
	arm_func_end DWC_GetNumConnectionHost

	arm_func_start DWC_CloseConnectionHard
DWC_CloseConnectionHard: // 0x020906A4
	stmdb sp!, {r4, lr}
	ldr r1, _0209070C // =0x02143A10
	mov r4, r0
	ldr r0, [r1]
	cmp r0, #0
	beq _020906E4
	bl DWCi_IsError
	cmp r0, #0
	bne _020906E4
	ldr r0, _0209070C // =0x02143A10
	ldr r0, [r0]
	ldr r0, [r0, #0x24]
	cmp r0, #5
	beq _020906EC
	cmp r0, #6
	beq _020906EC
_020906E4:
	mvn r0, #0
	ldmia sp!, {r4, pc}
_020906EC:
	mov r0, r4
	bl DWCi_GetGT2Connection
	cmp r0, #0
	mvneq r0, #1
	ldmeqia sp!, {r4, pc}
	bl gt2CloseConnectionHard
	mov r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209070C: .word 0x02143A10
	arm_func_end DWC_CloseConnectionHard

	arm_func_start DWC_CloseConnectionsAsync
DWC_CloseConnectionsAsync: // 0x02090710
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020907C0 // =0x02143A10
	ldr r0, [r0]
	cmp r0, #0
	beq _02090750
	bl DWCi_IsError
	cmp r0, #0
	bne _02090750
	ldr r0, _020907C0 // =0x02143A10
	ldr r2, [r0]
	ldr r0, [r2, #0x24]
	cmp r0, #5
	beq _0209075C
	cmp r0, #6
	beq _0209075C
_02090750:
	add sp, sp, #4
	mvn r0, #0
	ldmia sp!, {pc}
_0209075C:
	ldrb r0, [r2, #0x361]
	cmp r0, #0
	bne _02090790
	ldr r1, _020907C4 // =0x0211C1F0
	mov r0, #1
	mov r2, #0
	bl DWCi_SetGPStatus
	bl NNFreeNegotiateList
	mov r0, #3
	bl DWCi_SetState
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {pc}
_02090790:
	mov r1, #1
	ldr r0, _020907C0 // =0x02143A10
	strb r1, [r2, #0x2d]
	ldr r0, [r0]
	ldr r0, [r0]
	bl gt2CloseAllConnections
	ldr r1, _020907C0 // =0x02143A10
	mov r0, #0
	ldr r1, [r1]
	strb r0, [r1, #0x2d]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020907C0: .word 0x02143A10
_020907C4: .word 0x0211C1F0
	arm_func_end DWC_CloseConnectionsAsync

	arm_func_start DWC_SetConnectionClosedCallback
DWC_SetConnectionClosedCallback: // 0x020907C8
	ldr r2, _020907EC // =0x02143A10
	ldr r3, [r2]
	cmp r3, #0
	moveq r0, #0
	strne r0, [r3, #0x90]
	ldrne r2, [r2]
	movne r0, #1
	strne r1, [r2, #0x94]
	bx lr
	.align 2, 0
_020907EC: .word 0x02143A10
	arm_func_end DWC_SetConnectionClosedCallback

	arm_func_start DWC_ConnectToFriendsAsync
DWC_ConnectToFriendsAsync: // 0x020907F0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x94
	mov r4, r0
	mov r10, r1
	mov r9, r2
	mov r11, r3
	bl DWCi_IsError
	cmp r0, #0
	bne _02090828
	ldr r0, _02090994 // =0x02143A10
	ldr r0, [r0]
	ldr r0, [r0, #0x24]
	cmp r0, #3
	beq _02090834
_02090828:
	add sp, sp, #0x94
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02090834:
	bl DWCi_ClearGT2ConnectionList
	ldr r0, _02090994 // =0x02143A10
	ldr r3, [sp, #0xb8]
	ldr r1, [r0]
	ldr r2, [sp, #0xbc]
	str r3, [r1, #0x80]
	ldr r1, [r0]
	mov r0, #5
	str r2, [r1, #0x84]
	bl DWCi_SetState
	cmp r4, #0
	beq _020908A0
	ldr r0, _02090998 // =DWCi_MatchedCallback
	sub r2, r9, #1
	str r0, [sp]
	mov r1, #0
	ldr r0, [sp, #0xc0]
	str r1, [sp, #4]
	ldr r5, [sp, #0xc4]
	str r0, [sp, #8]
	mov r0, r4
	mov r1, r10
	mov r3, r11
	and r2, r2, #0xff
	str r5, [sp, #0xc]
	bl DWCi_ConnectToFriendsAsync
	b _02090988
_020908A0:
	mov r10, #0
	mov r5, r10
	bl DWCi_GetFriendListLen
	cmp r0, #0
	ble _020908D0
	add r4, sp, #0x50
_020908B8:
	add r0, r5, #1
	strb r5, [r4, r5]
	and r5, r0, #0xff
	bl DWCi_GetFriendListLen
	cmp r5, r0
	blt _020908B8
_020908D0:
	mov r6, #0
	bl DWCi_GetFriendListLen
	cmp r0, #0
	ble _02090950
	add r5, sp, #0x50
	add r4, sp, #0x10
_020908E8:
	bl DWCi_GetFriendListLen
	sub r0, r0, r6
	bl DWCi_GetMathRand32
	mov r8, r0
	ldrb r0, [r5, r8]
	add r7, r5, r8
	add r10, r10, #1
	strb r0, [r4, r6]
	bl DWCi_GetFriendListLen
	sub r0, r0, r6
	sub r0, r0, #1
	cmp r8, r0
	bhs _0209093C
_0209091C:
	ldrb r0, [r7, #1]
	add r8, r8, #1
	strb r0, [r7], #1
	bl DWCi_GetFriendListLen
	sub r0, r0, r6
	sub r0, r0, #1
	cmp r8, r0
	blo _0209091C
_0209093C:
	add r0, r6, #1
	and r6, r0, #0xff
	bl DWCi_GetFriendListLen
	cmp r6, r0
	blt _020908E8
_02090950:
	ldr r0, _02090998 // =DWCi_MatchedCallback
	sub r2, r9, #1
	str r0, [sp]
	mov r1, #0
	str r1, [sp, #4]
	ldr r0, [sp, #0xc0]
	ldr r4, [sp, #0xc4]
	str r0, [sp, #8]
	add r0, sp, #0x10
	mov r1, r10
	mov r3, r11
	and r2, r2, #0xff
	str r4, [sp, #0xc]
	bl DWCi_ConnectToFriendsAsync
_02090988:
	mov r0, #1
	add sp, sp, #0x94
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02090994: .word 0x02143A10
_02090998: .word DWCi_MatchedCallback
	arm_func_end DWC_ConnectToFriendsAsync

	arm_func_start DWC_ConnectToAnybodyAsync
DWC_ConnectToAnybodyAsync: // 0x0209099C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl DWCi_IsError
	cmp r0, #0
	bne _020909D4
	ldr r0, _02090A34 // =0x02143A10
	ldr r0, [r0]
	ldr r0, [r0, #0x24]
	cmp r0, #3
	beq _020909E0
_020909D4:
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020909E0:
	bl DWCi_ClearGT2ConnectionList
	ldr r1, _02090A34 // =0x02143A10
	mov r0, #5
	ldr r2, [r1]
	str r5, [r2, #0x80]
	ldr r1, [r1]
	str r4, [r1, #0x84]
	bl DWCi_SetState
	ldr r1, [sp, #0x20]
	sub r0, r7, #1
	ldr r4, [sp, #0x24]
	str r1, [sp]
	ldr r2, _02090A38 // =DWCi_MatchedCallback
	mov r1, r6
	and r0, r0, #0xff
	mov r3, #0
	str r4, [sp, #4]
	bl DWCi_ConnectToAnybodyAsync
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02090A34: .word 0x02143A10
_02090A38: .word DWCi_MatchedCallback
	arm_func_end DWC_ConnectToAnybodyAsync

	arm_func_start DWC_UpdateServersAsync
DWC_UpdateServersAsync: // 0x02090A3C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl DWCi_IsError
	cmp r0, #0
	bne _02090A78
	ldr r0, _02090ADC // =0x02143A10
	ldr r2, [r0]
	ldr r1, [r2, #0x24]
	cmp r1, #3
	blt _02090A78
	cmp r1, #4
	bne _02090A84
_02090A78:
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02090A84:
	str r6, [r2, #0x78]
	ldr r1, [r0]
	mov r0, #4
	str r5, [r1, #0x7c]
	bl DWCi_SetState
	ldr r0, _02090ADC // =0x02143A10
	ldr r1, [sp, #0x20]
	ldr r3, [r0]
	ldr r0, [sp, #0x24]
	str r4, [sp]
	str r1, [sp, #4]
	ldr r4, [sp, #0x28]
	str r0, [sp, #8]
	ldr r2, _02090AE0 // =DWCi_UpdateServersCallback
	add r0, r3, #0xe0
	add r1, r3, #0x1e0
	mov r3, #0
	str r4, [sp, #0xc]
	bl DWCi_UpdateServersAsync
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02090ADC: .word 0x02143A10
_02090AE0: .word DWCi_UpdateServersCallback
	arm_func_end DWC_UpdateServersAsync

	arm_func_start DWC_LoginAsync
DWC_LoginAsync: // 0x02090AE4
	stmdb sp!, {r4, r5, r6, lr}
	movs r4, r0
	mov r6, r2
	mov r5, r3
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl DWCi_IsError
	cmp r0, #0
	bne _02090B1C
	ldr r0, _02090BEC // =0x02143A10
	ldr r2, [r0]
	ldr r1, [r2, #0x24]
	cmp r1, #0
	beq _02090B24
_02090B1C:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02090B24:
	str r6, [r2, #0x70]
	ldr r1, [r0]
	cmp r4, #0
	str r5, [r1, #0x74]
	beq _02090B44
	ldrh r1, [r4]
	cmp r1, #0
	bne _02090B4C
_02090B44:
	mov r5, #0
	b _02090B98
_02090B4C:
	ldr r1, [r0]
	mov r0, #0
	add r1, r1, #0x2e
	mov r2, #0x34
	bl MIi_CpuClear16
	mov r0, r4
	bl DWCi_WStrLen
	cmp r0, #0x19
	movhi r5, #0x19
	bhi _02090B80
	mov r0, r4
	bl DWCi_WStrLen
	mov r5, r0
_02090B80:
	ldr r1, _02090BEC // =0x02143A10
	mov r0, r4
	ldr r1, [r1]
	mov r2, r5, lsl #1
	add r1, r1, #0x2e
	bl MIi_CpuCopy16
_02090B98:
	ldr r0, _02090BEC // =0x02143A10
	mov r1, #0
	ldr r0, [r0]
	add r0, r0, r5, lsl #1
	strh r1, [r0, #0x2e]
	bl DWC_GetInetStatus
	cmp r0, #4
	beq _02090BCC
	ldr r1, _02090BF0 // =0xFFFF1596
	mov r0, #2
	bl DWCi_StopLogin
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_02090BCC:
	mov r0, #1
	bl DWCi_SetState
	ldr r0, _02090BEC // =0x02143A10
	ldr r0, [r0]
	ldr r0, [r0, #0x68]
	bl GSIStartAvailableCheckA
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02090BEC: .word 0x02143A10
_02090BF0: .word 0xFFFF1596
	arm_func_end DWC_LoginAsync

	arm_func_start DWC_ProcessFriendsMatch
DWC_ProcessFriendsMatch: // 0x02090BF4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWC_UpdateConnection
	cmp r0, #0
	beq _02090C0C
	bl DWCs_ForceShutdown
_02090C0C:
	ldr r0, _02090E64 // =0x02143A10
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, [r0, #0x24]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02090E64 // =0x02143A10
	ldr r0, [r0]
	ldr r0, [r0, #0x24]
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b _02090E14
_02090C58: // jump table
	b _02090E14 // case 0
	b _02090C74 // case 1
	b _02090DA4 // case 2
	b _02090DAC // case 3
	b _02090DAC // case 4
	b _02090DBC // case 5
	b _02090DCC // case 6
_02090C74:
	bl GSIAvailableCheckThink
	cmp r0, #1
	beq _02090C94
	cmp r0, #2
	beq _02090D7C
	cmp r0, #3
	beq _02090D90
	b _02090E14
_02090C94:
	ldr r0, _02090E64 // =0x02143A10
	mov r2, #0
	ldr r0, [r0]
	ldr r1, [r0, #0xa0]
	add r0, r0, #0x1c
	bl gpInitialize
	bl DWCi_HandleGPError_3
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02090E64 // =0x02143A10
	mov r1, #0
	ldr r0, [r0]
	ldr r2, _02090E68 // =DWCi_GPErrorCallback
	mov r3, r1
	add r0, r0, #0x1c
	bl gpSetCallback
	bl DWCi_HandleGPError_3
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02090E64 // =0x02143A10
	ldr r2, _02090E6C // =DWCi_GPRecvBuddyMessageCallback
	ldr r0, [r0]
	mov r1, #3
	add r0, r0, #0x1c
	mov r3, #0
	bl gpSetCallback
	bl DWCi_HandleGPError_3
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02090E64 // =0x02143A10
	ldr r2, _02090E70 // =DWCi_GPRecvBuddyRequestCallback
	ldr r0, [r0]
	mov r1, #1
	add r0, r0, #0x1c
	mov r3, #0
	bl gpSetCallback
	bl DWCi_HandleGPError_3
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _02090E64 // =0x02143A10
	ldr r2, _02090E74 // =DWCi_GPRecvBuddyStatusCallback
	ldr r0, [r0]
	mov r1, #2
	add r0, r0, #0x1c
	mov r3, #0
	bl gpSetCallback
	bl DWCi_HandleGPError_3
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	mov r0, #2
	bl DWCi_SetState
	bl DWCi_LoginAsync
	b _02090E14
_02090D7C:
	ldr r1, _02090E78 // =0xFFFFB172
	mov r0, #3
	bl DWCi_StopLogin
	add sp, sp, #4
	ldmia sp!, {pc}
_02090D90:
	ldr r1, _02090E7C // =0xFFFFB17B
	mov r0, #4
	bl DWCi_StopLogin
	add sp, sp, #4
	ldmia sp!, {pc}
_02090DA4:
	bl DWCi_LoginProcess
	b _02090E14
_02090DAC:
	bl DWCi_FriendProcess
	mov r0, #0
	bl DWCi_MatchProcess
	b _02090E14
_02090DBC:
	mov r0, #1
	bl DWCi_MatchProcess
	bl DWCi_FriendProcess
	b _02090E14
_02090DCC:
	bl DWCi_TransportProcess
	bl DWCi_FriendProcess
	ldr r0, _02090E64 // =0x02143A10
	ldr r1, [r0]
	ldrb r0, [r1, #0x369]
	cmp r0, #2
	beq _02090DF4
	ldrb r0, [r1, #0x369]
	cmp r0, #3
	bne _02090E00
_02090DF4:
	mov r0, #1
	bl DWCi_MatchProcess
	b _02090E14
_02090E00:
	ldr r0, [r1]
	cmp r0, #0
	beq _02090E14
	mov r0, #0
	bl DWCi_MatchProcess
_02090E14:
	ldr r0, _02090E64 // =0x02143A10
	ldr r1, [r0]
	ldrb r0, [r1, #0x36c]
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, [r1, #0x364]
	cmp r0, #0
	beq _02090E4C
	bl qr2_shutdown
	ldr r0, _02090E64 // =0x02143A10
	mov r1, #0
	ldr r0, [r0]
	str r1, [r0, #0x364]
_02090E4C:
	ldr r0, _02090E64 // =0x02143A10
	mov r1, #0
	ldr r0, [r0]
	strb r1, [r0, #0x36c]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02090E64: .word 0x02143A10
_02090E68: .word DWCi_GPErrorCallback
_02090E6C: .word DWCi_GPRecvBuddyMessageCallback
_02090E70: .word DWCi_GPRecvBuddyRequestCallback
_02090E74: .word DWCi_GPRecvBuddyStatusCallback
_02090E78: .word 0xFFFFB172
_02090E7C: .word 0xFFFFB17B
	arm_func_end DWC_ProcessFriendsMatch

	arm_func_start DWC_ShutdownFriendsMatch
DWC_ShutdownFriendsMatch: // 0x02090E80
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02090FF0 // =0x02143A10
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, [r0, #0x364]
	cmp r0, #0
	beq _02090EBC
	bl qr2_shutdown
	ldr r0, _02090FF0 // =0x02143A10
	mov r1, #0
	ldr r0, [r0]
	str r1, [r0, #0x364]
_02090EBC:
	ldr r0, _02090FF0 // =0x02143A10
	mov r2, #0
	ldr r1, [r0]
	strb r2, [r1, #0x36c]
	ldr r0, [r0]
	ldr r0, [r0, #0x438]
	cmp r0, #0
	beq _02090EF0
	bl ServerBrowserFree
	ldr r0, _02090FF0 // =0x02143A10
	mov r1, #0
	ldr r0, [r0]
	str r1, [r0, #0x438]
_02090EF0:
	bl NNFreeNegotiateList
	bl CloseStatsConnection
	ldr r0, _02090FF0 // =0x02143A10
	ldr ip, [r0]
	ldr r0, [ip, #0x1c]
	cmp r0, #0
	beq _02090FA4
	mov r1, #0
	mov r2, r1
	mov r3, r1
	add r0, ip, #0x1c
	bl gpSetCallback
	ldr r0, _02090FF0 // =0x02143A10
	mov r2, #0
	ldr r0, [r0]
	mov r3, r2
	add r0, r0, #0x1c
	mov r1, #3
	bl gpSetCallback
	ldr r0, _02090FF0 // =0x02143A10
	mov r2, #0
	ldr r0, [r0]
	mov r3, r2
	add r0, r0, #0x1c
	mov r1, #1
	bl gpSetCallback
	ldr r0, _02090FF0 // =0x02143A10
	mov r2, #0
	ldr r0, [r0]
	mov r1, #2
	add r0, r0, #0x1c
	mov r3, r2
	bl gpSetCallback
	ldr r0, _02090FF0 // =0x02143A10
	ldr r0, [r0]
	add r0, r0, #0x1c
	bl gpProcess
	ldr r0, _02090FF0 // =0x02143A10
	ldr r0, [r0]
	add r0, r0, #0x1c
	bl gpDestroy
	mov r1, #0
	ldr r0, _02090FF0 // =0x02143A10
	ldr r0, [r0]
	str r1, [r0, #0x1c]
_02090FA4:
	bl DWCi_ShutdownLogin
	bl DWCi_ShutdownFriend
	bl DWCi_ShutdownMatch
	bl DWCi_ShutdownTransport
	ldr r0, _02090FF0 // =0x02143A10
	ldr r0, [r0]
	ldr r0, [r0]
	cmp r0, #0
	beq _02090FDC
	bl gt2CloseSocket
	ldr r0, _02090FF0 // =0x02143A10
	mov r1, #0
	ldr r0, [r0]
	str r1, [r0]
_02090FDC:
	ldr r0, _02090FF0 // =0x02143A10
	mov r1, #0
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02090FF0: .word 0x02143A10
	arm_func_end DWC_ShutdownFriendsMatch

	arm_func_start DWC_InitFriendsMatch
DWC_InitFriendsMatch: // 0x02090FF4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	ldr ip, _02091258 // =0x02143A10
	mov r6, r1
	mov r5, r2
	mov r4, r3
	str r0, [ip]
	bl DWC_ClearError
	ldr r0, _02091258 // =0x02143A10
	mov r2, #0
	ldr r1, [r0]
	ldr r3, _0209125C // =DWCi_GT2ConnectedCallback
	str r2, [r1]
	ldr r1, [r0]
	ldr r2, _02091260 // =DWCi_GT2ReceivedCallback
	str r3, [r1, #4]
	ldr r1, [r0]
	ldr ip, [sp, #0x24]
	str r2, [r1, #8]
	cmp ip, #0
	ldr r2, [r0]
	ldr r3, _02091264 // =DWCi_GT2ClosedCallback
	ldr r1, _02091268 // =DWCi_GT2PingCallback
	str r3, [r2, #0xc]
	ldr r0, [r0]
	ldr r3, [sp, #0x28]
	str r1, [r0, #0x10]
	ldr r0, _02091258 // =0x02143A10
	moveq ip, #0x2000
	ldr r0, [r0]
	cmp r3, #0
	str ip, [r0, #0x14]
	moveq r3, #0x2000
	ldr r1, _02091258 // =0x02143A10
	mov r0, #0
	ldr r2, [r1]
	ldr ip, _0209126C // =0x02144E84
	str r3, [r2, #0x18]
	ldr r2, [r1]
	ldr r3, _02091270 // =0x02144F84
	str r0, [r2, #0x1c]
	ldr r2, [r1]
	str r6, [r2, #0x20]
	ldr r2, [r1]
	str r0, [r2, #0x24]
	ldr r2, [r1]
	str r0, [r2, #0x28]
	ldr r2, [r1]
	strb r0, [r2, #0x2c]
	ldr r2, [r1]
	strb r0, [r2, #0x2d]
	ldr r2, [r1]
	str r0, [r2, #0x64]
	ldr r2, [r1]
	str ip, [r2, #0x68]
	ldr r2, [r1]
	str r3, [r2, #0x6c]
	ldr r2, [r1]
	str r0, [r2, #0x70]
	ldr r2, [r1]
	str r0, [r2, #0x74]
	ldr r2, [r1]
	str r0, [r2, #0x78]
	ldr r2, [r1]
	str r0, [r2, #0x7c]
	ldr r2, [r1]
	str r0, [r2, #0x80]
	ldr r2, [r1]
	str r0, [r2, #0x84]
	ldr r2, [r1]
	str r0, [r2, #0x88]
	ldr r2, [r1]
	str r0, [r2, #0x8c]
	ldr r2, [r1]
	str r0, [r2, #0x90]
	ldr r1, [r1]
	str r0, [r1, #0x94]
	bl DWCi_ClearGT2ConnectionList
	ldr r0, _02091258 // =0x02143A10
	mov r3, r5
	ldr r2, [r0]
	ldr r1, [r6, #0x24]
	ldr r0, _02091274 // =DWCi_LoginCallback
	str r1, [sp]
	add r1, r2, #0x2e
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r5, #0
	add r0, r2, #0x98
	mov r1, r6
	add r2, r2, #0x1c
	str r5, [sp, #0xc]
	bl DWCi_LoginInit
	ldr r0, _02091258 // =0x02143A10
	ldr r2, [sp, #0x30]
	ldr r5, [r0]
	ldr r3, [sp, #0x2c]
	str r2, [sp]
	add r0, r5, #0x2f8
	add r1, r5, #0x1c
	add r2, r5, #0x2e
	bl DWCi_FriendInit
	ldr r0, _02091258 // =0x02143A10
	ldr r1, _0209126C // =0x02144E84
	ldr r2, [r0]
	ldr r0, _02091270 // =0x02144F84
	str r1, [sp]
	str r0, [sp, #4]
	ldr r1, [sp, #0x2c]
	ldr r0, [sp, #0x30]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	add r0, r2, #0x354
	add r1, r2, #0x1c
	add r3, r2, #4
	bl DWCi_MatchInit
	ldr r1, _02091258 // =0x02143A10
	ldr r0, _02091278 // =0x000007D8
	ldr r1, [r1]
	add r0, r1, r0
	bl DWCi_InitTransport
	mov r0, r4
	bl strlen
	cmp r0, #0x100
	movhs r5, #0xff
	bhs _020911F8
	mov r0, r4
	bl strlen
	mov r5, r0
_020911F8:
	ldr r1, _0209126C // =0x02144E84
	mov r0, r4
	mov r2, r5
	bl MI_CpuCopy8
	ldr r0, [sp, #0x20]
	ldr r1, _0209126C // =0x02144E84
	mov r2, #0
	strb r2, [r1, r5]
	bl strlen
	cmp r0, #0x100
	movhs r4, #0xff
	bhs _02091234
	ldr r0, [sp, #0x20]
	bl strlen
	mov r4, r0
_02091234:
	ldr r0, [sp, #0x20]
	ldr r1, _02091270 // =0x02144F84
	mov r2, r4
	bl MI_CpuCopy8
	ldr r0, _02091270 // =0x02144F84
	mov r1, #0
	strb r1, [r0, r4]
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02091258: .word 0x02143A10
_0209125C: .word DWCi_GT2ConnectedCallback
_02091260: .word DWCi_GT2ReceivedCallback
_02091264: .word DWCi_GT2ClosedCallback
_02091268: .word DWCi_GT2PingCallback
_0209126C: .word 0x02144E84
_02091270: .word 0x02144F84
_02091274: .word DWCi_LoginCallback
_02091278: .word 0x000007D8
	arm_func_end DWC_InitFriendsMatch
