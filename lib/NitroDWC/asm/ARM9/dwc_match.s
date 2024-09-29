	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWCi_SetMatchStatus
DWCi_SetMatchStatus: // 0x02093370
	ldr r1, _02093380 // =0x02143BB0
	ldr r1, [r1]
	str r0, [r1, #0x1a0]
	bx lr
	.align 2, 0
_02093380: .word 0x02143BB0
	arm_func_end DWCi_SetMatchStatus

	arm_func_start DWCi_GetMatchCnt
DWCi_GetMatchCnt: // 0x02093384
	ldr r0, _02093390 // =0x02143BB0
	ldr r0, [r0]
	bx lr
	.align 2, 0
_02093390: .word 0x02143BB0
	arm_func_end DWCi_GetMatchCnt

	arm_func_start DWCi_SetMatchCnt
DWCi_SetMatchCnt: // 0x02093394
	ldr r1, _020933A0 // =0x02143BB0
	str r0, [r1]
	bx lr
	.align 2, 0
_020933A0: .word 0x02143BB0
	arm_func_end DWCi_SetMatchCnt

	arm_func_start DWCi_ProcessNNFailure
DWCi_ProcessNNFailure: // 0x020933A4
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	beq _020933DC
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x17d]
	add r1, r1, #1
	strb r1, [r0, #0x17d]
_020933DC:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	beq _020933FC
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x17d]
	cmp r0, #5
	blo _02093414
_020933FC:
	ldr r1, _02093420 // =0xFFFEAE6C
	mov r0, #6
	bl DWCi_StopMatching
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_02093414:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02093420: .word 0xFFFEAE6C
	arm_func_end DWCi_ProcessNNFailure

	arm_func_start DWCi_NNCompletedCallback
DWCi_NNCompletedCallback: // 0x02093424
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	mov r5, r0
	mov r6, r2
	mov r4, r3
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #6
	beq _0209345C
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xb
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, pc}
_0209345C:
	cmp r4, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r5, #0
	bne _02093658
	mov r0, #0
	str r0, [r4, #8]
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x14]
	add r1, r1, #1
	strb r1, [r0, #0x14]
	bl DWCi_GetMatchCnt
	ldrb r1, [r4]
	ldrb r5, [r0, #0x14]
	cmp r1, #0
	beq _020935F0
	bl DWCi_GetMatchCnt
	ldr r1, [r6, #4]
	add r0, r0, r5, lsl #2
	str r1, [r0, #0x210]
	ldrh r4, [r6, #2]
	bl DWCi_GetMatchCnt
	mov r2, r4, asr #8
	mov r1, r4, lsl #8
	add r0, r0, r5, lsl #1
	and r2, r2, #0xff
	and r1, r1, #0xff00
	orr r1, r2, r1
	add r0, r0, #0x200
	strh r1, [r0, #0x90]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x17c]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x180]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x184]
	str r1, [r0, #0x188]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xb
	bne _02093518
	mov r0, #0xc
	bl DWCi_SetMatchStatus
	b _02093520
_02093518:
	mov r0, #7
	bl DWCi_SetMatchStatus
_02093520:
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0xc]
	bl DWCi_GetMatchCnt
	ldr r3, [r0, #0x200]
	ldr r2, _020937F8 // =0x0211C254
	add r0, sp, #0x10
	mov r1, #0xc
	bl OS_SNPrintf
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	add r1, r6, r5, lsl #2
	mov r2, r0
	ldr r0, [r1, #0x210]
	add r1, r2, r5, lsl #1
	add r1, r1, #0x200
	ldrh r1, [r1, #0x90]
	mov r2, #0
	bl gt2AddressToString
	mov r6, r0
	bl DWCi_GetMatchCnt
	mvn r1, #0
	str r1, [sp]
	ldr r3, _020937FC // =0x00001388
	mov r1, #0
	str r3, [sp, #4]
	ldr r0, [r0, #8]
	mov r2, r6
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, [r4, #4]
	add r3, sp, #0x10
	ldr r0, [r0]
	bl sub_20B2220
	cmp r0, #1
	bne _020935C8
	bl DWCi_HandleGT2Error_1
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
_020935C8:
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, pc}
	bl DWCi_GetMatchCnt
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelPreConnectedServerProcess
	add sp, sp, #0x20
	cmp r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020935F0:
	cmp r6, #0
	beq _02093634
	sub r4, r5, #1
	bl DWCi_GetMatchCnt
	ldr r1, [r6, #4]
	add r0, r0, r4, lsl #2
	str r1, [r0, #0x210]
	ldrh r5, [r6, #2]
	bl DWCi_GetMatchCnt
	mov r2, r5, asr #8
	mov r1, r5, lsl #8
	add r0, r0, r4, lsl #1
	and r2, r2, #0xff
	and r1, r1, #0xff00
	orr r1, r2, r1
	add r0, r0, #0x200
	strh r1, [r0, #0x90]
_02093634:
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0x18c]
	mov r0, #7
	str r1, [r4, #0x190]
	bl DWCi_SetMatchStatus
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
_02093658:
	ldr r0, [r4, #8]
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r5
	bl DWCi_HandleNNResult
	mov r6, r0
	cmp r6, #2
	beq _02093688
	cmp r6, #1
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, pc}
_02093688:
	ldrb r0, [r4]
	cmp r0, #0
	bne _02093714
	cmp r6, #1
	beq _020936B0
	cmp r6, #2
	bne _020936F0
	ldrb r0, [r4, #1]
	cmp r0, #1
	blo _020936F0
_020936B0:
	mov r0, #0
	str r0, [r4, #8]
	bl DWCi_ProcessNNFailure
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, pc}
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelPreConnectedClientProcess
	add sp, sp, #0x20
	cmp r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020936F0:
	ldrb r1, [r4, #1]
	mov r0, r4
	add r1, r1, #1
	strb r1, [r4, #1]
	bl DWCi_DoNatNegotiationAsync
	bl DWCi_HandleNNError
	add sp, sp, #0x20
	cmp r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02093714:
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl OS_GetTick
	str r0, [r5, #0x184]
	str r1, [r5, #0x188]
	cmp r6, #1
	beq _02093750
	cmp r6, #2
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x17c]
	cmp r0, #1
	addlo sp, sp, #0x20
	ldmloia sp!, {r4, r5, r6, pc}
_02093750:
	mov r0, #0
	str r0, [r4, #8]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	beq _02093778
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	bne _02093790
_02093778:
	mov r0, #1
	bl DWCi_ProcessNNFailure
	cmp r0, #0
	bne _020937A4
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
_02093790:
	mov r0, #0
	bl DWCi_ProcessNNFailure
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, pc}
_020937A4:
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x17c]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x180]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x184]
	str r1, [r0, #0x188]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r0, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelPreConnectedServerProcess
	cmp r0, #0
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020937F8: .word 0x0211C254
_020937FC: .word 0x00001388
	arm_func_end DWCi_NNCompletedCallback

	arm_func_start DWCi_NNProgressCallback
DWCi_NNProgressCallback: // 0x02093800
	bx lr
	arm_func_end DWCi_NNProgressCallback

	arm_func_start DWCi_QR2ClientMsgCallback
DWCi_QR2ClientMsgCallback: // 0x02093804
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x9c
	mov r10, r0
	mov r9, r1
	mov r8, #0
	bl DWC_GetState
	cmp r0, #5
	beq _02093858
	bl DWC_GetState
	cmp r0, #6
	addne sp, sp, #0x9c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	beq _02093858
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	addne sp, sp, #0x9c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02093858:
	cmp r9, #0x14
	addlo sp, sp, #0x9c
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r4, sp, #0x1c
	add r11, sp, #8
	add r5, r10, #0x14
	mov r7, #0x14
	mov r6, #4
_02093878:
	mov r0, r10
	mov r1, r11
	mov r2, r7
	bl MI_CpuCopy8
	ldr r1, _02093914 // =0x0211C258
	mov r0, r11
	mov r2, r6
	bl strncmp
	cmp r0, #0
	addne sp, sp, #0x9c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0xc]
	cmp r0, #3
	addne sp, sp, #0x9c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r2, [sp, #0x11]
	mov r0, r5
	mov r1, r4
	bl MI_CpuCopy8
	str r4, [sp]
	ldrb r0, [sp, #0x11]
	mov r0, r0, asr #2
	str r0, [sp, #4]
	ldrb r0, [sp, #0x10]
	ldrh r3, [sp, #0x12]
	ldr r1, [sp, #0x18]
	ldr r2, [sp, #0x14]
	bl DWCi_ProcessRecvMatchCommand
	cmp r0, #0
	addeq sp, sp, #0x9c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r0, [sp, #0x11]
	add r0, r0, #0x14
	add r8, r8, r0
	add r0, r8, #0x14
	cmp r0, r9
	bls _02093878
	add sp, sp, #0x9c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02093914: .word 0x0211C258
	arm_func_end DWCi_QR2ClientMsgCallback

	arm_func_start DWCi_QR2NatnegCallback
DWCi_QR2NatnegCallback: // 0x02093918
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #1
	bne _0209393C
	mov r0, #6
	bl DWCi_SetMatchStatus
	b _0209395C
_0209393C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #6
	beq _0209395C
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xb
	ldmneia sp!, {r4, pc}
_0209395C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x180]
	cmp r4, r0
	bne _02093980
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x17c]
	add r1, r1, #1
	strb r1, [r0, #0x17c]
	b _02093994
_02093980:
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x17c]
	bl DWCi_GetMatchCnt
	str r4, [r0, #0x180]
_02093994:
	bl DWCi_GetMatchCnt
	mov r2, #0
	str r2, [r0, #0x184]
	str r2, [r0, #0x188]
	mov r1, r4
	mov r0, #1
	bl DWCi_NNStartupAsync
	bl DWCi_HandleNNError
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	bl DWCi_GetMatchCnt
	mov r1, #0xff
	strb r1, [r0, #0x3cc]
	ldmia sp!, {r4, pc}
	arm_func_end DWCi_QR2NatnegCallback

	arm_func_start DWCi_QR2PublicAddrCallback
DWCi_QR2PublicAddrCallback: // 0x020939CC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl DWCi_GetMatchCnt
	str r5, [r0, #0x1c]
	bl DWCi_GetMatchCnt
	strh r4, [r0, #0x1a]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWCi_QR2PublicAddrCallback

	arm_func_start DWCi_QR2AddErrorCallback
DWCi_QR2AddErrorCallback: // 0x020939F4
	ldr ip, _020939FC // =DWCi_HandleQR2Error
	bx ip
	.align 2, 0
_020939FC: .word DWCi_HandleQR2Error
	arm_func_end DWCi_QR2AddErrorCallback

	arm_func_start DWCi_QR2CountCallback
DWCi_QR2CountCallback: // 0x02093A00
	mov r0, #0
	bx lr
	arm_func_end DWCi_QR2CountCallback

	arm_func_start DWCi_QR2KeyListCallback
DWCi_QR2KeyListCallback: // 0x02093A08
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	cmp r0, #0
	beq _02093A28
	cmp r0, #1
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r0, #2
	ldmia sp!, {r4, r5, r6, pc}
_02093A28:
	mov r0, r6
	mov r1, #8
	bl qr2_keybuffer_add
	mov r0, r6
	mov r1, #0xa
	bl qr2_keybuffer_add
	mov r0, r6
	mov r1, #0x32
	bl qr2_keybuffer_add
	mov r0, r6
	mov r1, #0x33
	bl qr2_keybuffer_add
	mov r0, r6
	mov r1, #0x34
	bl qr2_keybuffer_add
	mov r0, r6
	mov r1, #0x35
	bl qr2_keybuffer_add
	mov r0, r6
	mov r1, #0x36
	bl qr2_keybuffer_add
	ldr r4, _02093AAC // =0x02143BDC
	mov r5, #0
_02093A84:
	ldrb r1, [r4]
	cmp r1, #0
	beq _02093A98
	mov r0, r6
	bl qr2_keybuffer_add
_02093A98:
	add r5, r5, #1
	cmp r5, #0x9a
	add r4, r4, #0xc
	blt _02093A84
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02093AAC: .word 0x02143BDC
	arm_func_end DWCi_QR2KeyListCallback

	arm_func_start DWCi_QR2TeamKeyCallback
DWCi_QR2TeamKeyCallback: // 0x02093AB0
	bx lr
	arm_func_end DWCi_QR2TeamKeyCallback

	arm_func_start DWCi_QR2PlayerKeyCallback
DWCi_QR2PlayerKeyCallback: // 0x02093AB4
	bx lr
	arm_func_end DWCi_QR2PlayerKeyCallback

	arm_func_start DWCi_QR2ServerKeyCallback
DWCi_QR2ServerKeyCallback: // 0x02093AB8
	stmdb sp!, {r4, lr}
	mov r4, r1
	cmp r0, #0x32
	bgt _02093AF4
	cmp r0, #0x32
	bge _02093B3C
	cmp r0, #0xa
	bgt _02093B98
	cmp r0, #8
	blt _02093B98
	cmp r0, #8
	beq _02093B14
	cmp r0, #0xa
	beq _02093B28
	b _02093B98
_02093AF4:
	sub r1, r0, #0x33
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _02093B98
_02093B04: // jump table
	b _02093B50 // case 0
	b _02093B64 // case 1
	b _02093B78 // case 2
	b _02093B88 // case 3
_02093B14:
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x14]
	mov r0, r4
	bl qr2_buffer_add_int
	ldmia sp!, {r4, pc}
_02093B28:
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x16]
	mov r0, r4
	bl qr2_buffer_add_int
	ldmia sp!, {r4, pc}
_02093B3C:
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x200]
	mov r0, r4
	bl qr2_buffer_add_int
	ldmia sp!, {r4, pc}
_02093B50:
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x15]
	mov r0, r4
	bl qr2_buffer_add_int
	ldmia sp!, {r4, pc}
_02093B64:
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x20]
	mov r0, r4
	bl qr2_buffer_add_int
	ldmia sp!, {r4, pc}
_02093B78:
	mov r0, r4
	mov r1, #3
	bl qr2_buffer_add_int
	ldmia sp!, {r4, pc}
_02093B88:
	mov r0, r4
	mov r1, #1
	bl qr2_buffer_add_int
	ldmia sp!, {r4, pc}
_02093B98:
	subs r1, r0, #0x64
	ldmmiia sp!, {r4, pc}
	cmp r1, #0x9a
	ldmgeia sp!, {r4, pc}
	mov r0, #0xc
	mul r2, r1, r0
	ldr r0, _02093BFC // =0x02143BDC
	ldrb r0, [r0, r2]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _02093C00 // =0x02143BDD
	ldrb r0, [r0, r2]
	cmp r0, #0
	beq _02093BE4
	ldr r1, _02093C04 // =0x02143BE4
	mov r0, r4
	ldr r1, [r1, r2]
	bl qr2_buffer_addA
	ldmia sp!, {r4, pc}
_02093BE4:
	ldr r1, _02093C04 // =0x02143BE4
	mov r0, r4
	ldr r1, [r1, r2]
	ldr r1, [r1]
	bl qr2_buffer_add_int
	ldmia sp!, {r4, pc}
	.align 2, 0
_02093BFC: .word 0x02143BDC
_02093C00: .word 0x02143BDD
_02093C04: .word 0x02143BE4
	arm_func_end DWCi_QR2ServerKeyCallback

	arm_func_start DWCi_RandomizeServers
DWCi_RandomizeServers: // 0x02093C08
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r8, #0
	mov r7, r8
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserCount
	cmp r0, #1
	addle sp, sp, #0x1c
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r9, r8
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserCount
	cmp r0, #0
	ble _02093C98
	ldr r4, _02093D78 // =0x02112634
	ldr r6, _02093D7C // =aDwcEval
	mvn r5, #0
_02093C54:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	mov r1, r9
	bl ServerBrowserGetServer
	mov r1, r6
	mov r2, r5
	bl SBServerGetIntValueA
	cmp r0, r8
	movgt r8, r0
	ldr r0, [r4, r9, lsl #2]
	add r9, r9, #1
	add r7, r7, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserCount
	cmp r9, r0
	blt _02093C54
_02093C98:
	mov r0, #0x64
	bl DWCi_GetMathRand32
	mov r9, r0
	mov r6, #0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserCount
	cmp r0, #0
	ble _02093D30
	add r5, sp, #0
	mov r11, r6
	mov r4, #0x64
_02093CC8:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserCount
	sub r0, r0, #1
	cmp r6, r0
	beq _02093D30
	cmp r6, #0
	subgt r0, r6, #1
	ldrgt r10, [r5, r0, lsl #2]
	ldr r0, _02093D78 // =0x02112634
	movle r10, r11
	ldr r2, [r0, r6, lsl #2]
	mov r1, r7
	mul r0, r2, r4
	bl _s32_div_f
	add r0, r0, r10
	str r0, [r5, r6, lsl #2]
	ldr r0, [r5, r6, lsl #2]
	cmp r9, r0
	blo _02093D30
	add r6, r6, #1
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserCount
	cmp r6, r0
	blt _02093CC8
_02093D30:
	mvn r0, #0x80000000
	cmp r8, r0
	addlt r8, r8, #1
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	mov r1, r6
	bl ServerBrowserGetServer
	ldr r1, _02093D7C // =aDwcEval
	mov r2, r8
	bl SBServerAddIntKeyValue
	bl DWCi_GetMatchCnt
	mov r1, #0
	ldr r0, [r0, #0xe4]
	ldr r2, _02093D7C // =aDwcEval
	mov r3, r1
	bl ServerBrowserSortA
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02093D78: .word 0x02112634
_02093D7C: .word aDwcEval
	arm_func_end DWCi_RandomizeServers

	arm_func_start DWCi_EvaluateServers
DWCi_EvaluateServers: // 0x02093D80
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp]
	mov r8, r1
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserCount
	cmp r0, #0
	ble _02093F08
	mov r0, #0x80
	mov r4, #1
	mov r5, r8
	str r0, [sp, #8]
	mov r11, #0x100
_02093DC0:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	mov r1, r8
	bl ServerBrowserGetServer
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _02093E5C
	ldr r1, _02093F74 // =aDwcPid
	mov r0, r6
	mov r2, r5
	bl SBServerGetIntValueA
	mov r9, r0
	mov r10, r5
	mov r7, r4
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _02093E54
_02093E10:
	bl DWCi_GetMatchCnt
	add r0, r0, r7, lsl #2
	ldr r0, [r0, #0xf4]
	cmp r9, r0
	bne _02093E40
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	mov r1, r6
	bl ServerBrowserRemoveServer
	mov r10, r4
	sub r8, r8, #1
	b _02093E54
_02093E40:
	add r7, r7, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r7, r0
	ble _02093E10
_02093E54:
	cmp r10, #0
	bne _02093EF0
_02093E5C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x474]
	cmp r0, #0
	beq _02093ED8
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x478]
	ldr r2, [r7, #0x474]
	mov r0, r8
	blx r2
	mov r7, r0
	cmp r7, #0
	ble _02093EBC
	ldr r0, _02093F78 // =0x007FFFFF
	cmp r7, r0
	movgt r7, r0
	mov r0, r11
	bl DWCi_GetMathRand32
	orr r2, r0, r7, lsl #8
	ldr r1, _02093F7C // =aDwcEval
	mov r0, r6
	bl SBServerAddIntKeyValue
	b _02093EF0
_02093EBC:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	mov r1, r6
	bl ServerBrowserRemoveServer
	str r4, [sp, #4]
	sub r8, r8, #1
	b _02093EF0
_02093ED8:
	ldr r0, [sp, #8]
	bl DWCi_GetMathRand32
	mov r2, r0
	ldr r1, _02093F7C // =aDwcEval
	mov r0, r6
	bl SBServerAddIntKeyValue
_02093EF0:
	add r8, r8, #1
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserCount
	cmp r8, r0
	blt _02093DC0
_02093F08:
	ldr r0, [sp]
	cmp r0, #0
	beq _02093F40
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserCount
	cmp r0, #0
	beq _02093F40
	bl DWCi_GetMatchCnt
	mov r1, #0
	ldr r0, [r0, #0xe4]
	ldr r2, _02093F7C // =aDwcEval
	mov r3, r1
	bl ServerBrowserSortA
_02093F40:
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _02093F68
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserCount
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02093F68:
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02093F74: .word aDwcPid
_02093F78: .word 0x007FFFFF
_02093F7C: .word aDwcEval
	arm_func_end DWCi_EvaluateServers

	arm_func_start DWCi_SBPrintServerData
DWCi_SBPrintServerData: // 0x02093F80
	bx lr
	arm_func_end DWCi_SBPrintServerData

	arm_func_start DWCi_SBCallback
DWCi_SBCallback: // 0x02093F84
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	cmp r1, #0
	beq _02093FAC
	cmp r1, #4
	beq _02093FDC
	add sp, sp, #4
	cmp r1, #5
	ldmia sp!, {r4, r5, r6, r7, pc}
_02093FAC:
	mov r0, r2
	bl DWCi_SBPrintServerData
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	ldr r2, _020943A0 // =0x00EFB5F7
	add sp, sp, #4
	adds r0, r0, r2
	str r0, [r4, #0x174]
	adc r0, r1, #0
	str r0, [r4, #0x178]
	ldmia sp!, {r4, r5, r6, r7, pc}
_02093FDC:
	bl DWCi_GetMatchCnt
	mov r5, #0
	str r5, [r0, #0x174]
	str r5, [r0, #0x178]
	mov r0, r6
	bl ServerBrowserCount
	cmp r0, #0
	ble _0209403C
_02093FFC:
	mov r0, r6
	mov r1, r5
	bl ServerBrowserGetServer
	mov r4, r0
	bl DWCi_CheckDWCServer
	cmp r0, #0
	bne _02094028
	mov r0, r6
	mov r1, r4
	bl ServerBrowserRemoveServer
	sub r5, r5, #1
_02094028:
	mov r0, r6
	add r5, r5, #1
	bl ServerBrowserCount
	cmp r5, r0
	blt _02093FFC
_0209403C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #2
	beq _02094060
	cmp r0, #3
	beq _02094158
	cmp r0, #5
	beq _020941D4
	b _02094378
_02094060:
	mov r0, r6
	mov r5, #0
	bl ServerBrowserCount
	cmp r0, #0
	ble _020940F0
_02094074:
	mov r0, r6
	mov r1, r5
	bl ServerBrowserGetServer
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	beq _020940DC
	bl DWCi_GetMatchCnt
	mov r7, r0
	mov r0, r4
	bl SBServerGetPublicInetAddress
	ldr r1, [r7, #0x1c]
	cmp r1, r0
	bne _020940DC
	bl DWCi_GetMatchCnt
	ldrh r0, [r0, #0x1a]
	cmp r0, #0
	beq _020940DC
	bl DWCi_GetMatchCnt
	mov r7, r0
	mov r0, r4
	bl SBServerGetPublicQueryPort
	ldrh r1, [r7, #0x1a]
	cmp r1, r0
	beq _020940F0
_020940DC:
	mov r0, r6
	add r5, r5, #1
	bl ServerBrowserCount
	cmp r5, r0
	blt _02094074
_020940F0:
	mov r0, r6
	bl ServerBrowserCount
	cmp r5, r0
	bge _02094130
	mov r0, #3
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x204]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x204]
	bl DWCi_SBUpdateAsync
	bl DWCi_HandleSBError
	add sp, sp, #4
	cmp r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_02094130:
	bl DWCi_GetMatchCnt
	mov r1, #2
	str r1, [r0, #0xe8]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0xec]
	add sp, sp, #4
	str r1, [r4, #0xf0]
	ldmia sp!, {r4, r5, r6, r7, pc}
_02094158:
	mov r0, #1
	bl DWCi_EvaluateServers
	bl DWCi_RandomizeServers
	mov r0, r6
	bl ServerBrowserCount
	cmp r0, #0
	beq _020941AC
	mov r0, #0
	mov r1, r0
	bl DWCi_SendResvCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r0, #4
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0xe8]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
_020941AC:
	bl DWCi_GetMatchCnt
	mov r1, #2
	str r1, [r0, #0xe8]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0xec]
	add sp, sp, #4
	str r1, [r4, #0xf0]
	ldmia sp!, {r4, r5, r6, r7, pc}
_020941D4:
	mov r0, r6
	bl ServerBrowserCount
	cmp r0, #0
	beq _0209424C
	mov r4, #0
_020941E8:
	mov r0, r6
	mov r1, r4
	bl ServerBrowserGetServer
	mov r5, r0
	bl SBServerGetPublicInetAddress
	mov r7, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1b8]
	cmp r7, r0
	bne _02094230
	mov r0, r5
	bl SBServerGetPublicQueryPort
	mov r7, r0
	bl DWCi_GetMatchCnt
	add r0, r0, #0x100
	ldrh r0, [r0, #0xb4]
	cmp r7, r0
	beq _0209424C
_02094230:
	mov r0, r6
	mov r1, r5
	bl ServerBrowserRemoveServer
	mov r0, r6
	bl ServerBrowserCount
	cmp r0, #0
	bne _020941E8
_0209424C:
	mov r0, r6
	bl ServerBrowserCount
	cmp r0, #0
	beq _02094350
	mov r0, r6
	mov r1, #0
	bl ServerBrowserGetServer
	ldr r1, _020943A4 // =aDwcPid
	mov r2, #0
	bl SBServerGetIntValueA
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _0209431C
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	cmp r4, r0
	bne _0209431C
	mov r0, #0
	bl DWCi_EvaluateServers
	cmp r0, #0
	beq _020942D0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0
	beq _0209431C
	bl DWCi_ChangeToClient
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	beq _0209431C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
_020942D0:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelReservation
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r0, #4
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	mov r1, r0
	mov r0, #0
	ldr r2, [r1, #0xf4]
	mov r1, r0
	bl DWCi_SendResvCommandToFriend
	bl DWCi_HandleMatchCommandError
	add sp, sp, #4
	cmp r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209431C:
	mov r0, #6
	bl DWCi_SetMatchStatus
	mov r0, r6
	mov r1, #0
	bl ServerBrowserGetServer
	mov r2, r0
	mov r0, #0
	mov r1, r0
	bl DWCi_NNStartupAsync
	bl DWCi_HandleNNError
	add sp, sp, #4
	cmp r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_02094350:
	bl DWCi_GetMatchCnt
	mov r1, #2
	str r1, [r0, #0xe8]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0xec]
	add sp, sp, #4
	str r1, [r4, #0xf0]
	ldmia sp!, {r4, r5, r6, r7, pc}
_02094378:
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	ldr r2, _020943A0 // =0x00EFB5F7
	adds r0, r0, r2
	str r0, [r4, #0x174]
	adc r0, r1, #0
	str r0, [r4, #0x178]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020943A0: .word 0x00EFB5F7
_020943A4: .word aDwcPid
	arm_func_end DWCi_SBCallback

	arm_func_start DWCi_HandleGT2Error_1
DWCi_HandleGT2Error_1: // 0x020943A8
	stmdb sp!, {r4, lr}
	movs r4, r0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	cmp r4, #7
	addls pc, pc, r4, lsl #2
	b _0209442C
_020943C4: // jump table
	b _0209442C // case 0
	b _020943E4 // case 1
	b _020943F0 // case 2
	b _02094400 // case 3
	b _0209440C // case 4
	b _020943F0 // case 5
	b _02094418 // case 6
	b _02094424 // case 7
_020943E4:
	mov r0, #9
	mvn r2, #0
	b _0209442C
_020943F0:
	mov r0, #0
	mov r2, r0
	mov r4, r0
	b _0209442C
_02094400:
	mov r0, #6
	mvn r2, #9
	b _0209442C
_0209440C:
	mov r0, #6
	mvn r2, #0x1d
	b _0209442C
_02094418:
	mov r0, #6
	mvn r2, #0x45
	b _0209442C
_02094424:
	mov r0, #6
	mvn r2, #0x4f
_0209442C:
	cmp r0, #0
	beq _02094440
	ldr r1, _02094448 // =0xFFFEAC28
	add r1, r2, r1
	bl DWCi_StopMatching
_02094440:
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02094448: .word 0xFFFEAC28
	arm_func_end DWCi_HandleGT2Error_1

	arm_func_start DWCi_HandleNNResult
DWCi_HandleNNResult: // 0x0209444C
	stmdb sp!, {r4, lr}
	movs r4, r0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	cmp r4, #1
	beq _02094470
	cmp r4, #2
	beq _02094478
	b _02094480
_02094470:
	mov r0, #1
	ldmia sp!, {r4, pc}
_02094478:
	mov r0, #2
	ldmia sp!, {r4, pc}
_02094480:
	movs r0, #6
	beq _02094490
	ldr r1, _02094498 // =0xFFFEB007
	bl DWCi_StopMatching
_02094490:
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02094498: .word 0xFFFEB007
	arm_func_end DWCi_HandleNNResult

	arm_func_start DWCi_HandleNNError
DWCi_HandleNNError: // 0x0209449C
	stmdb sp!, {r4, lr}
	movs r4, r0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	cmp r4, #1
	beq _020944CC
	cmp r4, #2
	beq _020944D8
	cmp r4, #3
	moveq r0, #6
	mvneq r2, #0x1d
	b _020944E0
_020944CC:
	mov r0, #9
	mvn r2, #0
	b _020944E0
_020944D8:
	mov r0, #6
	mvn r2, #0x31
_020944E0:
	ldr r1, _020944F4 // =0xFFFEB010
	add r1, r2, r1
	bl DWCi_StopMatching
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_020944F4: .word 0xFFFEB010
	arm_func_end DWCi_HandleNNError

	arm_func_start DWCi_HandleQR2Error
DWCi_HandleQR2Error: // 0x020944F8
	stmdb sp!, {r4, r5, r6, lr}
	movs r6, r0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r6, #5
	addls pc, pc, r6, lsl #2
	b _02094564
_02094514: // jump table
	b _02094564 // case 0
	b _0209452C // case 1
	b _02094538 // case 2
	b _02094544 // case 3
	b _02094550 // case 4
	b _0209455C // case 5
_0209452C:
	mov r4, #6
	mvn r5, #0x31
	b _02094564
_02094538:
	mov r4, #6
	mvn r5, #0x3b
	b _02094564
_02094544:
	mov r4, #6
	mvn r5, #0x1d
	b _02094564
_02094550:
	mov r4, #6
	mvn r5, #0x4f
	b _02094564
_0209455C:
	mov r4, #6
	mvn r5, #0x13
_02094564:
	bl DWC_GetState
	cmp r0, #2
	beq _02094584
	cmp r0, #4
	beq _02094594
	cmp r0, #5
	beq _020945A8
	b _020945BC
_02094584:
	mov r0, r4
	sub r1, r5, #0xfa00
	bl DWCi_StopLogin
	b _020945CC
_02094594:
	ldr r1, _020945D4 // =0xFFFEDEF0
	mov r0, r4
	add r1, r5, r1
	bl DWCi_StopFriendProcess
	b _020945CC
_020945A8:
	ldr r1, _020945D8 // =0xFFFEB7E0
	mov r0, r4
	add r1, r5, r1
	bl DWCi_StopMatching
	b _020945CC
_020945BC:
	ldr r1, _020945DC // =0xFFFE90D0
	mov r0, r4
	add r1, r5, r1
	bl DWCi_SetError
_020945CC:
	mov r0, r6
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020945D4: .word 0xFFFEDEF0
_020945D8: .word 0xFFFEB7E0
_020945DC: .word 0xFFFE90D0
	arm_func_end DWCi_HandleQR2Error

	arm_func_start DWCi_HandleSBError
DWCi_HandleSBError: // 0x020945E0
	stmdb sp!, {r4, lr}
	movs r4, r0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	cmp r4, #6
	addls pc, pc, r4, lsl #2
	b _0209465C
_020945FC: // jump table
	b _0209465C // case 0
	b _02094618 // case 1
	b _02094624 // case 2
	b _02094630 // case 3
	b _0209463C // case 4
	b _02094648 // case 5
	b _02094654 // case 6
_02094618:
	mov r0, #6
	mvn r2, #0x31
	b _0209465C
_02094624:
	mov r0, #6
	mvn r2, #0x1d
	b _0209465C
_02094630:
	mov r0, #6
	mvn r2, #0x13
	b _0209465C
_0209463C:
	mov r0, #6
	mvn r2, #0x27
	b _0209465C
_02094648:
	mov r0, #9
	mvn r2, #0
	b _0209465C
_02094654:
	mov r0, #9
	mvn r2, #1
_0209465C:
	ldr r1, _02094670 // =0xFFFEB3F8
	add r1, r2, r1
	bl DWCi_StopMatching
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02094670: .word 0xFFFEB3F8
	arm_func_end DWCi_HandleSBError

	arm_func_start DWCi_HandleGPError_1
DWCi_HandleGPError_1: // 0x02094674
	stmdb sp!, {r4, lr}
	movs r4, r0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	cmp r4, #4
	addls pc, pc, r4, lsl #2
	b _020946D0
_02094690: // jump table
	b _020946D0 // case 0
	b _020946A4 // case 1
	b _020946B0 // case 2
	b _020946BC // case 3
	b _020946C8 // case 4
_020946A4:
	mov r0, #9
	mvn r2, #0
	b _020946D0
_020946B0:
	mov r0, #9
	mvn r2, #1
	b _020946D0
_020946BC:
	mov r0, #6
	mvn r2, #9
	b _020946D0
_020946C8:
	mov r0, #6
	mvn r2, #0x13
_020946D0:
	ldr r1, _020946E4 // =0xFFFEC398
	add r1, r2, r1
	bl DWCi_StopMatching
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_020946E4: .word 0xFFFEC398
	arm_func_end DWCi_HandleGPError_1

	arm_func_start DWCi_ProcessOptMinComp
DWCi_ProcessOptMinComp: // 0x020946E8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	ldr r0, _02094B14 // =0x02143BAC
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldrb r0, [r0]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0x13
	bne _02094950
	mov r0, #0
	bl DWCi_GetAIDBitmask
	ldr r1, _02094B14 // =0x02143BAC
	ldr r5, [r1]
	ldr r1, [r5, #8]
	cmp r1, r0
	bne _02094824
	ldr r1, [r5, #0xc]
	cmp r1, r0
	bne _020947B0
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	strb r0, [r4, #0x16]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0xd]
	mov r0, #0
	sub r1, r1, #1
	strb r1, [r4, #0x1a4]
	bl DWCi_PostProcessConnection
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020947B0:
	bl OS_GetTick
	str r0, [r5, #0x18]
	str r1, [r5, #0x1c]
	mov r0, #0
	str r0, [r5, #8]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _02094804
	mov r0, #3
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	mov r1, #2
	str r1, [r0, #0xe8]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0xec]
	add sp, sp, #8
	str r1, [r4, #0xf0]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02094804:
	mov r0, #4
	bl DWCi_SetMatchStatus
	mov r1, #0
	mov r2, r1
	mov r0, #1
	bl DWCi_SendResvCommandToFriend
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02094824:
	ldrb r4, [r5, #2]
	bl OS_GetTick
	ldr r3, [r5, #0x18]
	ldr r2, [r5, #0x1c]
	subs r3, r0, r3
	sbc r0, r1, r2
	mov r1, r0, lsl #6
	ldr r2, _02094B18 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	ldr r2, _02094B1C // =0x00001770
	mul r2, r4, r2
	cmp r1, r2, asr #31
	cmpeq r0, r2
	addlo sp, sp, #8
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	cmp r4, #5
	bls _02094890
	mov r0, #1
	bl DWCi_InitOptMinCompParam
	bl DWCi_CloseAllConnectionsByTimeout
	mov r0, #1
	bl DWCi_RestartFromCancel
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02094890:
	mov r7, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _02094934
	ldr r8, _02094B14 // =0x02143BAC
	mov r5, #0
	mov r4, #0x11
	mov r6, r7
_020948B4:
	bl DWCi_GetMatchCnt
	add r0, r0, r7
	ldrb r0, [r0, #0x2d0]
	ldr r1, [r8]
	mov r0, r6, lsl r0
	ldr r1, [r1, #8]
	ands r0, r1, r0
	bne _02094920
	bl DWCi_GetMatchCnt
	mov r10, r0
	bl DWCi_GetMatchCnt
	mov r9, r0
	bl DWCi_GetMatchCnt
	str r5, [sp]
	str r5, [sp, #4]
	add r0, r0, r7, lsl #1
	add r1, r10, r7, lsl #2
	add r2, r9, r7, lsl #2
	ldrh r3, [r0, #0xa4]
	ldr r1, [r1, #0xf4]
	ldr r2, [r2, #0x24]
	mov r0, r4
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02094920:
	add r7, r7, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r7, r0
	ble _020948B4
_02094934:
	ldr r0, _02094B14 // =0x02143BAC
	add sp, sp, #8
	ldr r1, [r0]
	ldrb r0, [r1, #2]
	add r0, r0, #1
	strb r0, [r1, #2]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02094950:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #4
	beq _02094974
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #3
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02094974:
	ldr r0, _02094B14 // =0x02143BAC
	ldr r4, [r0]
	bl DWCi_GetMatchCnt
	ldrb r1, [r4, #1]
	ldrb r2, [r0, #0xd]
	sub r0, r1, #1
	cmp r2, r0
	addlt sp, sp, #8
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldrb r0, [r4, #2]
	cmp r0, #0
	bne _020949E8
	ldr r0, _02094B14 // =0x02143BAC
	ldr r4, [r0]
	bl OS_GetTick
	ldr r3, [r4, #0x10]
	ldr r2, [r4, #0x14]
	subs r3, r0, r3
	sbc r0, r1, r2
	mov r1, r0, lsl #6
	ldr r2, _02094B18 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	ldr r2, [r4, #4]
	cmp r1, #0
	cmpeq r0, r2
	bhs _02094A40
_020949E8:
	ldrb r0, [r4, #2]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r0, _02094B14 // =0x02143BAC
	ldr r4, [r0]
	bl OS_GetTick
	ldr r3, [r4, #0x18]
	ldr r2, [r4, #0x1c]
	subs r3, r0, r3
	sbc r0, r1, r2
	mov r1, r0, lsl #6
	ldr r2, _02094B18 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	ldr r2, [r4, #4]
	cmp r1, #0
	cmpeq r0, r2, lsr #2
	addlo sp, sp, #8
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02094A40:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x204]
	cmp r0, #0
	beq _02094A6C
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x204]
	bl DWCi_CancelReservation
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02094A6C:
	mov r0, #0x13
	bl DWCi_SetMatchStatus
	mov r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _02094AF0
	mov r6, #0
	mov r5, #0x11
_02094A90:
	bl DWCi_GetMatchCnt
	mov r8, r0
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	str r6, [sp]
	str r6, [sp, #4]
	add r0, r0, r4, lsl #1
	add r1, r8, r4, lsl #2
	add r2, r7, r4, lsl #2
	ldrh r3, [r0, #0xa4]
	ldr r1, [r1, #0xf4]
	ldr r2, [r2, #0x24]
	mov r0, r5
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r4, r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r4, r0
	ble _02094A90
_02094AF0:
	ldr r0, _02094B14 // =0x02143BAC
	ldr r4, [r0]
	bl OS_GetTick
	str r0, [r4, #0x18]
	str r1, [r4, #0x1c]
	mov r0, #1
	strb r0, [r4, #2]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02094B14: .word 0x02143BAC
_02094B18: .word 0x000082EA
_02094B1C: .word 0x00001770
	arm_func_end DWCi_ProcessOptMinComp

	arm_func_start DWCi_InitOptMinCompParam
DWCi_InitOptMinCompParam: // 0x02094B20
	stmdb sp!, {r4, lr}
	ldr r1, _02094B90 // =0x02143BAC
	mov r4, r0
	ldr r3, [r1]
	cmp r3, #0
	ldmeqia sp!, {r4, pc}
	ldrb r0, [r3]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r2, #0
	str r2, [r3, #8]
	ldr r0, [r1]
	str r2, [r0, #0xc]
	ldr r0, [r1]
	strb r2, [r0, #2]
	bl OS_GetTick
	ldr r2, _02094B90 // =0x02143BAC
	cmp r4, #0
	ldr r2, [r2]
	str r0, [r2, #0x18]
	str r1, [r2, #0x1c]
	ldmneia sp!, {r4, pc}
	bl OS_GetTick
	ldr r2, _02094B90 // =0x02143BAC
	ldr r2, [r2]
	str r0, [r2, #0x10]
	str r1, [r2, #0x14]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02094B90: .word 0x02143BAC
	arm_func_end DWCi_InitOptMinCompParam

	arm_func_start DWCi_InitClWaitTimeout
DWCi_InitClWaitTimeout: // 0x02094B94
	stmdb sp!, {r4, lr}
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1ad]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0x1f8]
	str r1, [r4, #0x1fc]
	ldmia sp!, {r4, pc}
	arm_func_end DWCi_InitClWaitTimeout

	arm_func_start DWCi_GetAIDBitmask
DWCi_GetAIDBitmask: // 0x02094BBC
	stmdb sp!, {r4, r5, r6, lr}
	cmp r0, #0
	mov r6, #0
	beq _02094BDC
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x2f0]
	bic r0, r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_02094BDC:
	mov r5, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _02094C18
	mov r4, r5
_02094BF4:
	bl DWCi_GetMatchCnt
	add r0, r0, r5
	ldrb r0, [r0, #0x2d0]
	add r5, r5, #1
	orr r6, r6, r4, lsl r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r5, r0
	ble _02094BF4
_02094C18:
	mov r0, r6
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCi_GetAIDBitmask

	arm_func_start DWCi_GetAIDFromProfileID
DWCi_GetAIDFromProfileID: // 0x02094C20
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	cmp r1, #0
	moveq r4, #1
	mov r5, r0
	movne r4, #0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r4, r0
	bgt _02094C84
_02094C48:
	bl DWCi_GetMatchCnt
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #0xf4]
	cmp r5, r0
	bne _02094C70
	bl DWCi_GetMatchCnt
	add r0, r0, r4
	add sp, sp, #4
	ldrb r0, [r0, #0x2d0]
	ldmia sp!, {r4, r5, pc}
_02094C70:
	add r4, r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r4, r0
	ble _02094C48
_02094C84:
	mov r0, #0xff
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWCi_GetAIDFromProfileID

	arm_func_start DWCi_CheckDWCServer
DWCi_CheckDWCServer: // 0x02094C90
	stmdb sp!, {r4, lr}
	ldr r1, _02094D54 // =aNumplayers
	mvn r2, #0
	mov r4, r0
	bl SBServerGetIntValueA
	mvn r2, #0
	cmp r0, r2
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _02094D58 // =aMaxplayers
	mov r0, r4
	bl SBServerGetIntValueA
	mvn r2, #0
	cmp r0, r2
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _02094D5C // =aDwcMtype
	mov r0, r4
	bl SBServerGetIntValueA
	mvn r2, #0
	cmp r0, r2
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _02094D60 // =aDwcMresv
	mov r0, r4
	bl SBServerGetIntValueA
	mvn r1, #0
	cmp r0, r1
	bne _02094D20
	ldr r1, _02094D60 // =aDwcMresv
	mov r0, r4
	mov r2, #0
	bl SBServerGetIntValueA
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
_02094D20:
	ldr r1, _02094D64 // =aDwcMver
	mov r0, r4
	mvn r2, #0
	bl SBServerGetIntValueA
	mvn r1, #0
	cmp r0, r1
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _02094D68 // =aDwcPid
	mov r0, r4
	mov r2, #0
	bl SBServerGetIntValueA
	ldmia sp!, {r4, pc}
	.align 2, 0
_02094D54: .word aNumplayers
_02094D58: .word aMaxplayers
_02094D5C: .word aDwcMtype
_02094D60: .word aDwcMresv
_02094D64: .word aDwcMver
_02094D68: .word aDwcPid
	arm_func_end DWCi_CheckDWCServer

	arm_func_start DWCi_IsFriendByIdxList
DWCi_IsFriendByIdxList: // 0x02094D6C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x2fc]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	mov r4, #0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x344]
	cmp r0, #0
	ble _02094DE0
_02094DA4:
	bl DWCi_GetMatchCnt
	add r0, r0, r4
	ldrb r0, [r0, #0x304]
	bl DWCi_GetProfileIDFromList
	cmp r0, #0
	ble _02094DCC
	cmp r0, r5
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, pc}
_02094DCC:
	add r4, r4, #1
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x344]
	cmp r4, r0
	blt _02094DA4
_02094DE0:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWCi_IsFriendByIdxList

	arm_func_start DWCi_GetAIDFromList
DWCi_GetAIDFromList: // 0x02094DEC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, #0
	mov r4, r6
_02094DF8:
	mov r5, r4
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	cmp r0, #0
	blt _02094E34
_02094E0C:
	bl DWCi_GetMatchCnt
	add r0, r0, r5
	ldrb r0, [r0, #0x2d0]
	cmp r6, r0
	beq _02094E34
	add r5, r5, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	cmp r5, r0
	ble _02094E0C
_02094E34:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	cmp r5, r0
	bgt _02094E54
	add r0, r6, #1
	and r6, r0, #0xff
	cmp r6, #0x20
	blo _02094DF8
_02094E54:
	mov r0, r6
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCi_GetAIDFromList

	arm_func_start DWCi_ClearGameMatchKeys
DWCi_ClearGameMatchKeys: // 0x02094E5C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r6, _02094EB4 // =0x02143BDC
	mov r7, #0
	mov r4, r7
	mov r5, #4
_02094E74:
	ldr r1, [r6, #4]
	cmp r1, #0
	beq _02094E8C
	mov r0, r5
	mov r2, r4
	bl DWC_Free
_02094E8C:
	add r7, r7, #1
	cmp r7, #0x9a
	add r6, r6, #0xc
	blt _02094E74
	ldr r1, _02094EB4 // =0x02143BDC
	ldr r2, _02094EB8 // =0x00000738
	mov r0, #0
	bl MIi_CpuClear32
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02094EB4: .word 0x02143BDC
_02094EB8: .word 0x00000738
	arm_func_end DWCi_ClearGameMatchKeys

	arm_func_start DWCi_GetNewMatchKey
DWCi_GetNewMatchKey: // 0x02094EBC
	ldr r2, _02094EF8 // =0x02143BDC
	mov r3, #0
	mov r0, #0xc
_02094EC8:
	mul r1, r3, r0
	ldrb r1, [r2, r1]
	cmp r1, #0
	addeq r0, r3, #0x64
	andeq r0, r0, #0xff
	bxeq lr
	add r1, r3, #1
	and r3, r1, #0xff
	cmp r3, #0x9a
	blo _02094EC8
	mov r0, #0
	bx lr
	.align 2, 0
_02094EF8: .word 0x02143BDC
	arm_func_end DWCi_GetNewMatchKey

	arm_func_start DWCi_ProcessCancelMatchSynTimeout
DWCi_ProcessCancelMatchSynTimeout: // 0x02094EFC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #8
	beq _02094F34
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xe
	beq _02094F34
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xf
	bne _02094F78
_02094F34:
	bl OS_GetTick
	mov r4, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x1e8]
	ldr r0, [r0, #0x1ec]
	subs r3, r4, r1
	sbc r0, r5, r0
	mov r1, r0, lsl #6
	ldr r2, _02095110 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	mov r4, r0
	mov r5, r1
	b _02094F84
_02094F78:
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_02094F84:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #8
	beq _02094FA8
	cmp r0, #0xe
	beq _02094FDC
	cmp r0, #0xf
	beq _020950E4
	b _02095104
_02094FA8:
	ldr r0, _02095114 // =0x00001770
	cmp r5, #0
	cmpeq r4, r0
	bls _02095104
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	mov r1, #0xe
	bl DWCi_SendCancelMatchSynCommand
	cmp r0, #0
	bne _02095104
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_02094FDC:
	ldr r0, _02095114 // =0x00001770
	cmp r5, #0
	cmpeq r4, r0
	bls _02095104
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x1ac]
	add r1, r1, #1
	strb r1, [r0, #0x1ac]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1ac]
	cmp r0, #5
	bls _02095068
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1d8]
	bl DWCi_CloseShutdownClientSC
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0
	beq _0209505C
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1ac]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0x1e8]
	str r1, [r4, #0x1ec]
	b _02095104
_0209505C:
	mov r0, #2
	bl DWCi_RestartFromCancel
	b _02095104
_02095068:
	mov r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _02095104
	mov r5, #0xd
	mov r6, r4
_02095084:
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	add r0, r0, r4
	ldrb r0, [r0, #0x2d0]
	ldr r1, [r7, #0x1d8]
	mov r0, r6, lsl r0
	ands r0, r1, r0
	bne _020950CC
	bl DWCi_GetMatchCnt
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #0xf4]
	mov r1, r5
	bl DWCi_SendCancelMatchSynCommand
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_020950CC:
	add r4, r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r4, r0
	ble _02095084
	b _02095104
_020950E4:
	bl DWCi_GetMatchCnt
	add r0, r0, #0x100
	ldrh r0, [r0, #0xb2]
	cmp r5, r0, asr #31
	cmpeq r4, r0
	bls _02095104
	mov r0, #2
	bl DWCi_RestartFromCancel
_02095104:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02095110: .word 0x000082EA
_02095114: .word 0x00001770
	arm_func_end DWCi_ProcessCancelMatchSynTimeout

	arm_func_start DWCi_ProcessCancelMatchSynCommand
DWCi_ProcessCancelMatchSynCommand: // 0x02095118
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl DWC_GetState
	cmp r0, #6
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	cmp r5, #0xd
	beq _02095154
	cmp r5, #0xe
	beq _02095190
	cmp r5, #0xf
	beq _02095318
	b _02095330
_02095154:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #8
	beq _02095174
	mov r0, #8
	bl DWCi_SetMatchStatus
	mov r0, r4
	bl DWCi_CloseCancelHostAsync
_02095174:
	mov r0, r6
	mov r1, #0xe
	bl DWCi_SendCancelMatchSynCommand
	cmp r0, #0
	bne _02095330
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02095190:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xe
	bne _020952FC
	bl OS_GetTick
	mov r4, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x1e8]
	ldr r0, [r0, #0x1ec]
	subs r3, r4, r1
	sbc r0, r5, r0
	mov r1, r0, lsl #6
	ldr r2, _02095338 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	mov r2, r0, lsr #1
	mov r0, r1, lsr #1
	cmp r0, #0
	orr r2, r2, r1, lsl #31
	cmpeq r2, #0x12c
	bls _0209525C
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x1e8]
	ldr r0, [r0, #0x1ec]
	subs r3, r4, r1
	sbc r0, r5, r0
	mov r1, r0, lsl #6
	ldr r2, _02095338 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	mov r3, r0, lsr #1
	mov r0, #0x12c
	orr r3, r3, r1, lsl #31
	rsb r0, r0, #0
	mvn r2, #0
	adds r5, r3, r0
	adc r4, r2, r1, lsr #1
	bl DWCi_GetMatchCnt
	add r0, r0, #0x100
	ldrh r0, [r0, #0xb2]
	cmp r4, r0, asr #31
	cmpeq r5, r0
	bls _0209525C
	bl DWCi_GetMatchCnt
	add r0, r0, #0x100
	strh r5, [r0, #0xb2]
_0209525C:
	mov r0, r6
	mov r1, #0
	bl DWCi_GetAIDFromProfileID
	mov r4, r0
	cmp r4, #0xff
	beq _02095288
	bl DWCi_GetMatchCnt
	ldr r2, [r0, #0x1d8]
	mov r1, #1
	orr r1, r2, r1, lsl r4
	str r1, [r0, #0x1d8]
_02095288:
	mov r0, #1
	bl DWCi_GetAIDBitmask
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1d8]
	cmp r4, r0
	bne _02095330
	mov r5, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _020952F0
	mov r4, #0xf
_020952BC:
	bl DWCi_GetMatchCnt
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0xf4]
	mov r1, r4
	bl DWCi_SendCancelMatchSynCommand
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	add r5, r5, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r5, r0
	ble _020952BC
_020952F0:
	mov r0, #0xf
	bl DWCi_SetMatchStatus
	b _02095330
_020952FC:
	mov r0, r6
	mov r1, #0xf
	bl DWCi_SendCancelMatchSynCommand
	cmp r0, #0
	bne _02095330
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02095318:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #8
	bne _02095330
	mov r0, #2
	bl DWCi_RestartFromCancel
_02095330:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02095338: .word 0x000082EA
	arm_func_end DWCi_ProcessCancelMatchSynCommand

	arm_func_start DWCi_SendCancelMatchSynCommand
DWCi_SendCancelMatchSynCommand: // 0x0209533C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r5, r1
	cmp r5, #0xd
	mov r6, r0
	movne r4, #0
	bne _02095368
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20c]
	mov r4, #1
	str r0, [sp, #8]
_02095368:
	add r0, sp, #8
	str r0, [sp]
	mov r2, #0
	mov r0, r5
	mov r1, r6
	mov r3, r2
	str r4, [sp, #4]
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #0x10
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0x1e8]
	str r1, [r4, #0x1ec]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCi_SendCancelMatchSynCommand

	arm_func_start DWCi_ProcessMatchSynTimeout
DWCi_ProcessMatchSynTimeout: // 0x020953BC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #9
	beq _020953F4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0x10
	beq _020953F4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0x11
	bne _02095438
_020953F4:
	bl OS_GetTick
	mov r4, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x1e0]
	ldr r0, [r0, #0x1e4]
	subs r3, r4, r1
	sbc r0, r5, r0
	mov r1, r0, lsl #6
	ldr r2, _02095640 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	mov r4, r0
	mov r5, r1
	b _02095444
_02095438:
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_02095444:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #9
	beq _02095468
	cmp r0, #0x10
	beq _020954D8
	cmp r0, #0x11
	beq _02095614
	b _02095634
_02095468:
	ldr r0, _02095644 // =0x00001770
	cmp r5, #0
	cmpeq r4, r0
	bls _02095634
	bl DWC_GetState
	cmp r0, #5
	bne _020954B4
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1ad]
	cmp r0, #5
	blo _020954B4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelPreConnectedClientProcess
	cmp r0, #0
	bne _02095634
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020954B4:
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x1ad]
	add r1, r1, #1
	strb r1, [r0, #0x1ad]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x2d0]
	mov r1, #3
	bl DWCi_SendMatchSynPacket
	b _02095634
_020954D8:
	ldr r0, _02095644 // =0x00001770
	cmp r5, #0
	cmpeq r4, r0
	bls _02095634
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x1ab]
	add r1, r1, #1
	strb r1, [r0, #0x1ab]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1ab]
	cmp r0, #5
	bls _020955A8
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	beq _02095528
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02095538
_02095528:
	bl DWCi_CloseAllConnectionsByTimeout
	mov r0, #1
	bl DWCi_RestartFromCancel
	b _02095634
_02095538:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1d4]
	bl DWCi_CloseShutdownClientSC
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0
	beq _02095588
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1ab]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0x1e0]
	str r1, [r4, #0x1e4]
	b _02095634
_02095588:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20c]
	bl DWCi_CancelPreConnectedServerProcess
	cmp r0, #0
	bne _02095634
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020955A8:
	mov r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _02095634
	mov r5, #2
	mov r6, r4
_020955C4:
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	add r0, r0, r4
	ldrb r0, [r0, #0x2d0]
	ldr r1, [r7, #0x1d4]
	mov r0, r6, lsl r0
	ands r0, r1, r0
	bne _020955FC
	bl DWCi_GetMatchCnt
	add r0, r0, r4
	ldrb r0, [r0, #0x2d0]
	mov r1, r5
	bl DWCi_SendMatchSynPacket
_020955FC:
	add r4, r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r4, r0
	ble _020955C4
	b _02095634
_02095614:
	bl DWCi_GetMatchCnt
	add r0, r0, #0x100
	ldrh r0, [r0, #0xb0]
	cmp r5, r0, asr #31
	cmpeq r4, r0
	bls _02095634
	mov r0, #4
	bl DWCi_PostProcessConnection
_02095634:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02095640: .word 0x000082EA
_02095644: .word 0x00001770
	arm_func_end DWCi_ProcessMatchSynTimeout

	arm_func_start DWCi_SendMatchSynPacket
DWCi_SendMatchSynPacket: // 0x02095648
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r5, r0
	cmp r4, #2
	beq _0209566C
	cmp r4, #3
	beq _020956E4
	b _02095708
_0209566C:
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r6, r0
	ldrb r0, [r0, #0x2d0]
	mov r6, #1
	cmp r5, r0
	moveq r0, #1
	streqb r0, [sp]
	movne r0, #0
	strneb r0, [sp]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blo _02095708
_020956AC:
	bl DWCi_GetMatchCnt
	add r0, r0, r6
	ldrb r0, [r0, #0x2d0]
	cmp r5, r0
	streqb r6, [sp, #1]
	streqb r5, [sp, #2]
	beq _02095708
	add r0, r6, #1
	and r6, r0, #0xff
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r6, r0
	bls _020956AC
	b _02095708
_020956E4:
	bl DWCi_GetMatchCnt
	add r0, r0, #0x100
	ldrh r0, [r0, #0xb0]
	strb r0, [sp]
	bl DWCi_GetMatchCnt
	add r0, r0, #0x100
	ldrh r0, [r0, #0xb0]
	mov r0, r0, asr #8
	strb r0, [sp, #1]
_02095708:
	add r2, sp, #0
	mov r0, r4
	mov r1, r5
	mov r3, #4
	bl DWCi_SendReliable
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0x1e0]
	str r1, [r4, #0x1e4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCi_SendMatchSynPacket

	arm_func_start DWCi_CloseShutdownClientSC
DWCi_CloseShutdownClientSC: // 0x02095738
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x108
	mov r9, #0
	mov r10, r0
	mov r8, r9
	mov r7, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _020957C4
	add r4, sp, #8
	add r5, sp, #0x88
	mov r6, r7
_0209576C:
	bl DWCi_GetMatchCnt
	add r0, r0, r7
	ldrb r0, [r0, #0x2d0]
	mov r0, r6, lsl r0
	ands r0, r10, r0
	beq _0209579C
	bl DWCi_GetMatchCnt
	add r0, r0, r7, lsl #2
	ldr r0, [r0, #0xf4]
	str r0, [r5, r8, lsl #2]
	add r8, r8, #1
	b _020957B0
_0209579C:
	bl DWCi_GetMatchCnt
	add r0, r0, r7, lsl #2
	ldr r0, [r0, #0xf4]
	str r0, [r4, r9, lsl #2]
	add r9, r9, #1
_020957B0:
	add r7, r7, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r7, r0
	ble _0209576C
_020957C4:
	cmp r8, #0
	mov r10, #0
	ble _0209581C
	add r7, sp, #8
	add r5, sp, #0x88
	mov r4, r10
	mov r6, #0x10
_020957E0:
	str r7, [sp]
	str r9, [sp, #4]
	ldr r1, [r5, r10, lsl #2]
	mov r0, r6
	mov r2, r4
	mov r3, r4
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #0x108
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r10, r10, #1
	cmp r10, r8
	blt _020957E0
_0209581C:
	bl DWCi_GetMatchCnt
	mov r1, #2
	strb r1, [r0, #0x1a8]
	cmp r9, #0
	mov r6, #0
	ble _02095860
	add r5, sp, #8
	mov r4, r6
_0209583C:
	ldr r0, [r5, r6, lsl #2]
	mov r1, r4
	bl DWCi_GetAIDFromProfileID
	cmp r0, #0xff
	beq _02095854
	bl DWC_CloseConnectionHard
_02095854:
	add r6, r6, #1
	cmp r6, r9
	blt _0209583C
_02095860:
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a8]
	mov r0, #1
	add sp, sp, #0x108
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end DWCi_CloseShutdownClientSC

	arm_func_start DWCi_CloseAllConnectionsByTimeout
DWCi_CloseAllConnectionsByTimeout: // 0x02095878
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_GetMatchCnt
	mov r1, #2
	strb r1, [r0, #0x1a8]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2CloseAllConnections
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a8]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_CloseAllConnectionsByTimeout

	arm_func_start DWCi_CloseCancelHostAsync
DWCi_CloseCancelHostAsync: // 0x020958B0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl DWCi_GetMatchCnt
	str r5, [r0, #0x20c]
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0xd]
	mov r0, r5
	add r1, r1, #1
	bl DWCi_GetGT2ConnectionByProfileID
	movs r4, r0
	beq _0209590C
	bl DWCi_GetMatchCnt
	mov r1, #2
	strb r1, [r0, #0x1a8]
	ldr r0, [r4]
	bl gt2CloseConnectionHard
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a8]
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, pc}
_0209590C:
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0xd]
	mov r0, r5
	add r1, r1, #1
	bl DWCi_DeleteHostByProfileID
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWCi_CloseCancelHostAsync

	arm_func_start DWCi_ResumeMatching
DWCi_ResumeMatching: // 0x0209592C
	stmdb sp!, {r4, lr}
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x17]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x20]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a8]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x208]
	cmp r0, #0
	beq _020959DC
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _0209599C
	mov r0, #3
	bl DWCi_SetMatchStatus
	mov r0, #0
	bl DWCi_SBUpdateAsync
	mov r4, r0
	bl DWCi_HandleSBError
	cmp r0, #0
	beq _020959E4
	mov r0, r4
	ldmia sp!, {r4, pc}
_0209599C:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _020959E4
	mov r0, #4
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x208]
	mov r1, #0
	bl DWCi_SendResvCommand
	mov r4, r0
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	beq _020959E4
	mov r0, r4
	ldmia sp!, {r4, pc}
_020959DC:
	mov r0, #1
	bl DWCi_RestartFromCancel
_020959E4:
	mov r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end DWCi_ResumeMatching

	arm_func_start DWCi_RestartFromTimeout
DWCi_RestartFromTimeout: // 0x020959EC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl DWCi_CloseAllConnectionsByTimeout
	mov r0, #1
	bl DWCi_RestartFromCancel
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_RestartFromTimeout

	arm_func_start DWCi_RestartFromCancel
DWCi_RestartFromCancel: // 0x02095A30
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	movs r4, r0
	bne _02095A4C
	bl DWCi_FinishCancelMatching
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
_02095A4C:
	bl DWCi_ResetMatchParam
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	beq _02095A70
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	bne _02095ACC
_02095A70:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20c]
	cmp r0, #0
	moveq r6, #1
	movne r6, #0
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20c]
	bl DWCi_GetFriendListIndex
	mov r4, r0
	bl DWCi_GetMatchCnt
	str r4, [sp]
	ldr r1, [r0, #0x468]
	mov r0, #0
	str r1, [sp, #4]
	ldr ip, [r5, #0x464]
	mov r2, r6
	mov r1, #1
	mov r3, r0
	blx ip
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
_02095ACC:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _02095B00
	cmp r4, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, #0
	bl DWCi_SBUpdateAsync
	bl DWCi_HandleSBError
	add sp, sp, #8
	cmp r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02095B00:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	cmp r4, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, #0
	mov r1, r0
	mov r2, r0
	bl DWCi_SendResvCommandToFriend
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCi_RestartFromCancel

	arm_func_start DWCi_InvalidateReservation
DWCi_InvalidateReservation: // 0x02095B38
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r4, #0
	str r4, [sp, #8]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x17]
	cmp r0, #0
	beq _02095C00
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20]
	cmp r0, #0
	beq _02095C00
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldr r1, [r5, #0x20]
	ldr r0, [r0, #0x200]
	cmp r1, r0
	beq _02095C00
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	add r2, sp, #8
	mov r1, #1
	str r2, [sp]
	str r1, [sp, #4]
	ldrb r3, [r0, #0xd]
	ldrb r2, [r6, #0xd]
	ldr r1, [r7, #0x20]
	add r3, r3, #1
	add r2, r2, #1
	add r3, r4, r3, lsl #1
	add r2, r5, r2, lsl #2
	ldrh r3, [r3, #0xa4]
	ldr r2, [r2, #0x24]
	mov r0, #0xc
	bl DWCi_SendMatchCommand
	mov r4, r0
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x17]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x20]
_02095C00:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end DWCi_InvalidateReservation

	arm_func_start DWCi_FinishCancelMatching
DWCi_FinishCancelMatching: // 0x02095C0C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r1, _02095CC8 // =0x0211C2B0
	mov r0, #1
	mov r2, #0
	bl DWCi_SetGPStatus
	bl DWCi_HandleGPError_1
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_CloseMatching
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20c]
	cmp r0, #0
	movne r6, #1
	bne _02095C60
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	moveq r6, #1
	movne r6, #0
_02095C60:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20c]
	cmp r0, #0
	moveq r7, #1
	movne r7, #0
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20c]
	bl DWCi_GetFriendListIndex
	mov r4, r0
	bl DWCi_GetMatchCnt
	str r4, [sp]
	ldr r1, [r0, #0x468]
	mov r2, r7
	str r1, [sp, #4]
	ldr ip, [r5, #0x464]
	mov r3, r6
	mov r0, #0
	mov r1, #1
	blx ip
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a9]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02095CC8: .word 0x0211C2B0
	arm_func_end DWCi_FinishCancelMatching

	arm_func_start DWCi_DoCancelMatching
DWCi_DoCancelMatching: // 0x02095CCC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x20c]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #2
	bne _02095CFC
	bl DWCi_FinishCancelMatching
	add sp, sp, #4
	ldmia sp!, {pc}
_02095CFC:
	bl DWCi_GetMatchCnt
	mov r1, #1
	strb r1, [r0, #0x1a9]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	bne _02095D70
	bl DWCi_GetMatchCnt
	mov r1, #1
	strb r1, [r0, #0x1a9]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0
	beq _02095D48
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2CloseAllConnections
	b _02095D64
_02095D48:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelReservation
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
_02095D64:
	bl DWCi_FinishCancelMatching
	add sp, sp, #4
	ldmia sp!, {pc}
_02095D70:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #4
	beq _02095DD0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #5
	beq _02095DD0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #6
	beq _02095DD0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #7
	beq _02095DD0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xb
	beq _02095DD0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xc
	bne _02095E10
_02095DD0:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x204]
	cmp r0, #0
	beq _02095DFC
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelReservation
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
_02095DFC:
	bl DWCi_InvalidateReservation
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
_02095E10:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x19c]
	cmp r0, #0
	beq _02095E38
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x19c]
	bl NNCancel
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x19c]
_02095E38:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0
	beq _02095E64
	bl DWCi_GetMatchCnt
	mov r1, #1
	strb r1, [r0, #0x1a9]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2CloseAllConnections
_02095E64:
	bl DWCi_FinishCancelMatching
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_DoCancelMatching

	arm_func_start DWCi_AreAllBuddies
DWCi_AreAllBuddies: // 0x02095E70
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a6]
	cmp r0, #0
	beq _02095EA0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, pc}
_02095EA0:
	cmp r5, #0
	mov r4, #0
	bls _02095EF0
_02095EAC:
	ldr r0, [r6, r4, lsl #2]
	bl DWCi_IsFriendByIdxList
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a6]
	cmp r0, #0
	beq _02095EE4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #1
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, pc}
_02095EE4:
	add r4, r4, #1
	cmp r4, r5
	blo _02095EAC
_02095EF0:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCi_AreAllBuddies

	arm_func_start DWCi_PostProcessConnection
DWCi_PostProcessConnection: // 0x02095EF8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x20
	cmp r0, #4
	mov r5, #3
	mov r4, #0
	addls pc, pc, r0, lsl #2
	b _02096520
_02095F14: // jump table
	b _02095F28 // case 0
	b _020962CC // case 1
	b _02096310 // case 2
	b _020963D4 // case 3
	b _020963F4 // case 4
_02095F28:
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	ldrb r1, [r6, #0x1a4]
	sub r0, r0, #1
	cmp r1, r0
	bge _02095FE8
	mov r0, #0xd
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a4]
	add r0, r0, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0xf4]
	str r0, [sp, #8]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a4]
	add r0, r0, #1
	str r0, [sp, #0xc]
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a4]
	add r0, r0, #1
	add r0, r5, r0
	ldrb r0, [r0, #0x2d0]
	str r0, [sp, #0x10]
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a4]
	add r0, r0, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x24]
	str r0, [sp, #0x14]
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a4]
	mov r5, #5
	add r0, r0, #1
	add r0, r6, r0, lsl #1
	ldrh r0, [r0, #0xa4]
	str r0, [sp, #0x18]
	b _02096234
_02095FE8:
	bl DWCi_GetMatchCnt
	mov r1, r4
	strb r1, [r0, #0x17]
	bl DWCi_GetMatchCnt
	mov r1, r4
	str r1, [r0, #0x20]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	bl qr2_send_statechanged
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _02096028
	mov r0, r5
	bl DWCi_SetMatchStatus
	b _0209604C
_02096028:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02096044
	mov r0, #4
	bl DWCi_SetMatchStatus
	b _0209604C
_02096044:
	mov r0, #0xa
	bl DWCi_SetMatchStatus
_0209604C:
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a4]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	beq _02096084
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r1, [r6, #0xd]
	ldrb r0, [r0, #0x16]
	cmp r1, r0
	bne _02096134
_02096084:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	bne _020960BC
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r6, r0, lsl #2
	ldr r0, [r0, #0xf4]
	str r0, [r7, #0x20c]
	b _020960DC
_020960BC:
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x20c]
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x200]
	str r0, [r6, #0xf4]
_020960DC:
	mov r0, #0x10
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1d4]
	mov r7, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _02096224
	mov r6, #2
_02096108:
	bl DWCi_GetMatchCnt
	add r0, r0, r7
	ldrb r0, [r0, #0x2d0]
	mov r1, r6
	bl DWCi_SendMatchSynPacket
	add r7, r7, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r7, r0
	ble _02096108
	b _02096224
_02096134:
	mov r0, #0
	str r0, [sp, #8]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	str r0, [sp, #0xc]
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r6, r0
	ldrb r0, [r0, #0x2d0]
	str r0, [sp, #0x10]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _02096198
	bl DWCi_GetMatchCnt
	mov r1, #2
	str r1, [r0, #0xe8]
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl OS_GetTick
	str r0, [r6, #0xec]
	str r1, [r6, #0xf0]
	b _02096224
_02096198:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02096224
	mov r1, #0
	mov r2, r1
	mov r0, #1
	bl DWCi_SendResvCommandToFriend
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a6]
	cmp r0, #0
	bne _02096224
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #2
	blo _02096224
	bl DWCi_GetMatchCnt
	mov r8, r0
	mov r0, #0
	bl DWCi_GetAIDBitmask
	mov r6, r0
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	mov r1, #1
	ldr r2, [r8, #0x1dc]
	add r0, r7, r0
	ldrb r0, [r0, #0x2d0]
	mvn r0, r1, lsl r0
	and r0, r6, r0
	cmp r2, r0
	beq _02096224
	bl DWCi_RestartFromTimeout
	b _02096520
_02096224:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	movne r4, #1
_02096234:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0x10
	beq _02096520
	bl DWCi_GetMatchCnt
	mov r10, r0
	bl DWCi_GetMatchCnt
	mov r9, r0
	bl DWCi_GetMatchCnt
	mov r8, r0
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	add r1, sp, #8
	str r1, [sp]
	str r5, [sp, #4]
	mov ip, r0
	ldrb r3, [r9, #0xd]
	ldrb r2, [r7, #0xd]
	ldrb r1, [ip, #0xd]
	add r5, r10, r3, lsl #2
	add r2, r8, r2, lsl #2
	add r3, r6, r1, lsl #1
	ldrh r3, [r3, #0xa4]
	ldr r1, [r5, #0xf4]
	ldr r2, [r2, #0x24]
	mov r0, #8
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x3cd]
	b _02096520
_020962CC:
	mov r0, #1
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	bne _02096308
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0xf4]
	str r0, [r5, #0x20c]
_02096308:
	mov r4, #1
	b _02096520
_02096310:
	mov r0, #1
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	beq _02096338
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02096358
_02096338:
	bl DWCi_GetMatchCnt
	mov r1, #1
	strb r1, [r0, #0x17]
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x200]
	str r0, [r5, #0x20]
_02096358:
	bl DWCi_InitClWaitTimeout
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	bls _02096520
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	mov r8, r0
	bl DWCi_GetMatchCnt
	add r3, r8, #0xf4
	ldrb r2, [r0, #0xd]
	mov r1, #1
	mov r0, #9
	sub r2, r2, #1
	add r2, r3, r2, lsl #2
	str r2, [sp]
	str r1, [sp, #4]
	ldr r1, [r7, #0xf4]
	ldr r2, [r6, #0x24]
	ldrh r3, [r5, #0xa4]
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	beq _02096520
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020963D4:
	mov r0, #1
	bl DWCi_SetMatchStatus
	bl DWCi_InitClWaitTimeout
	bl DWCi_GetMatchCnt
	mov r1, r4
	str r1, [r0, #0x20c]
	mov r4, #1
	b _02096520
_020963F4:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	beq _02096414
	ldr r1, _02096554 // =0x0211C2B0
	mov r0, #2
	mov r2, r4
	bl DWCi_SetGPStatus
_02096414:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20c]
	cmp r0, #0
	moveq r7, #1
	movne r7, #0
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20c]
	bl DWCi_GetFriendListIndex
	mov r5, r0
	bl DWCi_GetMatchCnt
	str r5, [sp]
	ldr r1, [r0, #0x468]
	mov r0, #0
	str r1, [sp, #4]
	ldr r5, [r6, #0x464]
	mov r2, r7
	mov r1, r0
	mov r3, r0
	blx r5
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	beq _02096488
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02096490
_02096488:
	bl DWCi_CloseMatching
	b _02096514
_02096490:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	cmp r0, #0
	beq _020964B8
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserFree
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0xe4]
_020964B8:
	bl NNFreeNegotiateList
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	bne _02096500
	bl DWCi_GPSetServerStatus
	bl DWCi_HandleGPError_1
	cmp r0, #0
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r0, _02096558 // =0x02143BB4
	ldrb r1, [r0]
	cmp r1, #1
	moveq r1, #1
	streqb r1, [r0, #1]
	mov r0, #0xa
	bl DWCi_SetMatchStatus
	b _02096508
_02096500:
	mov r0, #1
	bl DWCi_SetMatchStatus
_02096508:
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x20c]
_02096514:
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a9]
_02096520:
	cmp r4, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserClear
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02096554: .word 0x0211C2B0
_02096558: .word 0x02143BB4
	arm_func_end DWCi_PostProcessConnection

	arm_func_start DWCi_ChangeToClient
DWCi_ChangeToClient: // 0x0209655C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _020965F4
	mov r5, #0xa
_0209657C:
	bl DWCi_GetMatchCnt
	mov r9, r0
	bl DWCi_GetMatchCnt
	mov r8, r0
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	add r1, r6, #0x348
	str r1, [sp]
	ldr ip, [r0, #0x348]
	add r3, r7, r4, lsl #1
	add ip, ip, #1
	str ip, [sp, #4]
	add r1, r9, r4, lsl #2
	add r2, r8, r4, lsl #2
	ldrh r3, [r3, #0xa4]
	ldr r1, [r1, #0xf4]
	ldr r2, [r2, #0x24]
	mov r0, r5
	bl DWCi_SendMatchCommand
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	add r4, r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r4, r0
	ble _0209657C
_020965F4:
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x17]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x20]
	bl DWCi_GetMatchCnt
	mov r1, #1
	strb r1, [r0, #0x1a8]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2CloseAllConnections
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a8]
	mov r0, r1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end DWCi_ChangeToClient

	arm_func_start DWCi_CancelPreConnectedClientProcess
DWCi_CancelPreConnectedClientProcess: // 0x02096640
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	bne _02096688
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0
	beq _02096670
	bl DWCi_CloseAllConnectionsByTimeout
_02096670:
	ldr r1, _02096708 // =0xFFFEC5D2
	mov r0, #6
	bl DWCi_StopMatching
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_02096688:
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	strb r0, [r5, #0x14]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x208]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x19c]
	cmp r0, #0
	beq _020966D0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x19c]
	bl NNCancel
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x19c]
_020966D0:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0
	beq _020966E8
	bl DWCi_RestartFromTimeout
	b _020966FC
_020966E8:
	mov r0, #4
	bl DWCi_SetMatchStatus
	mov r0, #0
	bl DWCi_RetryReserving
	mov r4, r0
_020966FC:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02096708: .word 0xFFFEC5D2
	arm_func_end DWCi_CancelPreConnectedClientProcess

	arm_func_start DWCi_CancelPreConnectedServerProcess
DWCi_CancelPreConnectedServerProcess: // 0x0209670C
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x17]
	cmp r0, #0
	beq _02096744
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldr r1, [r4, #0x20]
	ldr r0, [r0, #0x200]
	cmp r1, r0
	moveq r4, #0
	beq _02096748
_02096744:
	mov r4, #1
_02096748:
	cmp r4, #0
	beq _02096774
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x17]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x20]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	bl qr2_send_statechanged
_02096774:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0x1f
	bhs _020967A4
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	mov r1, #0
	add r0, r0, #1
	add r0, r6, r0, lsl #2
	str r1, [r0, #0xf4]
_020967A4:
	bl DWCi_GetMatchCnt
	mov r1, #0xff
	strb r1, [r0, #0x3cc]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x19c]
	cmp r0, #0
	beq _020967D8
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x19c]
	bl NNCancel
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x19c]
_020967D8:
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	strb r0, [r6, #0x14]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x204]
	cmp r4, #0
	bne _02096818
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	beq _02096920
	bl DWCi_RestartFromTimeout
	b _02096920
_02096818:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _02096854
	mov r0, #3
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	mov r1, #2
	str r1, [r0, #0xe8]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0xec]
	str r1, [r4, #0xf0]
	b _02096920
_02096854:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02096880
	mov r0, #4
	bl DWCi_SetMatchStatus
	mov r1, #0
	mov r2, r1
	mov r0, #1
	bl DWCi_SendResvCommandToFriend
	b _02096920
_02096880:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	bne _02096920
	mov r0, #0xe
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1d8]
	bl DWCi_GetMatchCnt
	add r1, r0, #0x100
	mov r2, #0
	mov r0, r5
	strh r2, [r1, #0xb2]
	bl DWCi_CloseCancelHostAsync
	mov r5, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _02096908
	mov r4, #0xd
_020968D4:
	bl DWCi_GetMatchCnt
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0xf4]
	mov r1, r4
	bl DWCi_SendCancelMatchSynCommand
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	add r5, r5, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r5, r0
	ble _020968D4
_02096908:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0
	bne _02096920
	mov r0, #2
	bl DWCi_RestartFromCancel
_02096920:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCi_CancelPreConnectedServerProcess

	arm_func_start DWCi_CancelReservation
DWCi_CancelReservation: // 0x02096928
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldrh r3, [r0, #0xa4]
	ldr r2, [r4, #0x24]
	mov r1, r5
	mov r0, #5
	bl DWCi_SendMatchCommand
	mov r4, r0
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x204]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWCi_CancelReservation

	arm_func_start DWCi_RetryReserving
DWCi_RetryReserving: // 0x0209697C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x208]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x204]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a7]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0x1cc]
	str r1, [r4, #0x1d0]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _020969F8
	mov r0, #3
	bl DWCi_SetMatchStatus
	mov r0, #0
	bl DWCi_SBUpdateAsync
	bl DWCi_HandleSBError
	cmp r0, #0
	beq _02096A58
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020969F8:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02096A30
	mov r0, #0
	mov r1, r0
	mov r2, r5
	bl DWCi_SendResvCommandToFriend
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	beq _02096A58
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_02096A30:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	bne _02096A58
	ldr r1, _02096A64 // =0xFFFEC5E6
	mov r0, #6
	bl DWCi_StopMatching
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_02096A58:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02096A64: .word 0xFFFEC5E6
	arm_func_end DWCi_RetryReserving

	arm_func_start DWCi_SendResvCommandToFriend
DWCi_SendResvCommandToFriend: // 0x02096A68
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x23c
	movs r4, r1
	str r0, [sp]
	str r2, [sp, #4]
	beq _02096A90
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a5]
	str r0, [sp, #0xc]
	b _02096AC8
_02096A90:
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x344]
	ldrb r1, [r5, #0x1a5]
	sub r0, r0, #1
	cmp r1, r0
	movge r0, #0
	strge r0, [sp, #0xc]
	bge _02096AC8
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a5]
	add r0, r0, #1
	str r0, [sp, #0xc]
_02096AC8:
	cmp r4, #0
	moveq r0, #1
	mov r9, #0
	streq r0, [sp, #8]
	strne r9, [sp, #8]
	mov r7, #1
	mov r8, #0
	mov r5, #0x2f
	mov r4, #0xa
_02096AEC:
	ldr r0, [sp, #8]
	cmp r0, #0
	bne _02096B00
	cmp r9, #0
	beq _02096B34
_02096B00:
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x1a5]
	add r1, r1, #1
	strb r1, [r0, #0x1a5]
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r1, [r6, #0x1a5]
	ldr r0, [r0, #0x344]
	cmp r1, r0
	blt _02096B34
	bl DWCi_GetMatchCnt
	strb r8, [r0, #0x1a5]
_02096B34:
	cmp r9, #0
	beq _02096B88
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x1a5]
	ldr r0, [sp, #0xc]
	cmp r0, r1
	bne _02096B88
	bl DWCi_GetMatchCnt
	ldr r1, _02096D60 // =0x00000BB8
	str r1, [r0, #0x1c8]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0x1cc]
	str r1, [r4, #0x1d0]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1bc]
	add sp, sp, #0x23c
	mov r0, r1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02096B88:
	mov r9, r7
	bl DWCi_GetUserData
	mov r11, r0
	bl DWCi_GetMatchCnt
	mov r10, r0
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	mov r1, r0
	ldrb r2, [r1, #0x1a5]
	ldr r3, [r10, #0x2fc]
	mov r1, #0xc
	add r2, r6, r2
	ldrb r2, [r2, #0x304]
	mov r0, r11
	mla r1, r2, r1, r3
	bl DWC_GetGsProfileId
	movs r10, r0
	beq _02096AEC
	mvn r0, #0
	cmp r10, r0
	beq _02096AEC
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	mov r11, r0
	bl DWCi_GetMatchCnt
	ldr r2, [r6, #0x2fc]
	ldrb r1, [r0, #0x1a5]
	mov r0, #0xc
	add r1, r11, r1
	ldrb r1, [r1, #0x304]
	mla r0, r1, r0, r2
	bl DWCi_Acc_IsValidFriendData
	cmp r0, #0
	beq _02096AEC
	mov r6, r7
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _02096C54
_02096C2C:
	bl DWCi_GetMatchCnt
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0xf4]
	cmp r10, r0
	beq _02096C54
	add r6, r6, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r6, r0
	ble _02096C2C
_02096C54:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r6, r0
	ble _02096AEC
	bl DWCi_GetMatchCnt
	ldr r0, [r0]
	mov r1, r10
	add r2, sp, #0x18
	bl gpGetBuddyIndex
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0]
	ldr r1, [sp, #0x18]
	add r2, sp, #0x28
	bl gpGetBuddyStatus
	orrs r0, r6, r0
	bne _02096AEC
	ldr r0, [sp, #0x2c]
	cmp r0, #4
	bne _02096AEC
	ldr r0, _02096D64 // =0x0211C2B4
	add r1, sp, #0x1c
	add r2, sp, #0x30
	mov r3, r5
	bl DWC_GetCommonValueString
	mov r6, r0
	ldr r0, _02096D68 // =0x0211C2B8
	add r1, sp, #0x12
	add r2, sp, #0x30
	mov r3, r5
	bl DWC_GetCommonValueString
	mov r11, r0
	ldr r0, _02096D6C // =0x0211C2BC
	add r1, sp, #0x10
	add r2, sp, #0x30
	mov r3, r5
	bl DWC_GetCommonValueString
	cmp r6, #0
	ble _02096AEC
	cmp r11, #0
	ble _02096AEC
	cmp r0, #0
	ble _02096AEC
	add r0, sp, #0x1c
	mov r1, r8
	mov r2, r4
	bl strtoul
	cmp r0, #3
	bne _02096AEC
	add r0, sp, #0x12
	mov r1, r8
	mov r2, r4
	bl strtoul
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x16]
	cmp r6, r0
	bne _02096AEC
	ldr r0, [sp, #4]
	cmp r10, r0
	moveq r0, #1
	streq r0, [sp]
	ldr r1, [sp]
	mov r0, r10
	bl DWCi_SendResvCommand
	add sp, sp, #0x23c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02096D60: .word 0x00000BB8
_02096D64: .word 0x0211C2B4
_02096D68: .word 0x0211C2B8
_02096D6C: .word 0x0211C2BC
	arm_func_end DWCi_SendResvCommandToFriend

	arm_func_start DWCi_SendResvCommand
DWCi_SendResvCommand: // 0x02096D70
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r5, r0
	cmp r1, #0
	bne _02096DA4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	bne _02096DD8
	bl DWCi_GetMatchCnt
	ldrh r0, [r0, #0x1a]
	cmp r0, #0
	bne _02096DD8
_02096DA4:
	bl DWCi_GetMatchCnt
	mov r1, #1
	str r1, [r0, #0x1bc]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0x1c0]
	str r1, [r4, #0x1c4]
	bl DWCi_GetMatchCnt
	str r5, [r0, #0xf4]
	add sp, sp, #0x14
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_02096DD8:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _02096E5C
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	mov r1, #0
	bl ServerBrowserGetServer
	mov r6, r0
	bl DWCi_GetMatchCnt
	mov r4, r0
	ldr r1, _02096F1C // =aDwcPid
	mov r0, r6
	mov r2, #0
	bl SBServerGetIntValueA
	str r0, [r4, #0xf4]
	bl DWCi_GetMatchCnt
	mov r4, r0
	mov r0, r6
	bl SBServerGetPublicInetAddress
	str r0, [r4, #0x24]
	bl DWCi_GetMatchCnt
	mov r4, r0
	mov r0, r6
	bl SBServerGetPublicQueryPort
	strh r0, [r4, #0xa4]
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	mov r4, #1
	str r0, [r6, #0x204]
	b _02096E98
_02096E5C:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02096E74
	bl DWCi_GetMatchCnt
	str r5, [r0, #0xf4]
_02096E74:
	bl DWCi_GetMatchCnt
	str r5, [r0, #0x204]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1c]
	str r0, [sp, #0xc]
	bl DWCi_GetMatchCnt
	ldrh r0, [r0, #0x1a]
	mov r4, #3
	str r0, [sp, #0x10]
_02096E98:
	bl DWCi_GetMatchCnt
	ldr r1, _02096F20 // =0x00001770
	str r1, [r0, #0x1c8]
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl OS_GetTick
	str r0, [r6, #0x1cc]
	str r1, [r6, #0x1d0]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1bc]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x208]
	cmp r0, #0
	movne r7, #0xb
	moveq r7, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	str r0, [sp, #8]
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	add r2, sp, #8
	str r2, [sp]
	mov r3, r0
	str r4, [sp, #4]
	ldrh r3, [r3, #0xa4]
	ldr r2, [r6, #0x24]
	mov r1, r5
	mov r0, r7
	bl DWCi_SendMatchCommand
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02096F1C: .word aDwcPid
_02096F20: .word 0x00001770
	arm_func_end DWCi_SendResvCommand

	arm_func_start DWCi_HandleMatchCommandError
DWCi_HandleMatchCommandError: // 0x02096F24
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _02096F48
	mov r0, r4
	bl DWCi_HandleSBError
	ldmia sp!, {r4, pc}
_02096F48:
	mov r0, r4
	bl DWCi_HandleGPError_1
	ldmia sp!, {r4, pc}
	arm_func_end DWCi_HandleMatchCommandError

	arm_func_start DWCi_MakeBackupServerData
DWCi_MakeBackupServerData: // 0x02096F54
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	ldr r1, [r5]
	mov r6, r0
	add r4, r1, #2
	cmp r4, #2
	bls _02096F88
	bl DWCi_GetMatchCnt
	sub r2, r4, #2
	add r1, r0, #0x350
	add r0, r5, #4
	mov r2, r2, lsl #2
	bl MIi_CpuCopy32
_02096F88:
	bl DWCi_GetMatchCnt
	sub r1, r4, #1
	str r1, [r0, #0x348]
	bl DWCi_GetMatchCnt
	str r6, [r0, #0x34c]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCi_MakeBackupServerData

	arm_func_start DWCi_ProcessResvOK
DWCi_ProcessResvOK: // 0x02096FA0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x14
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x17]
	cmp r0, #0
	beq _02096FDC
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20]
	cmp r6, r0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
_02096FDC:
	bl DWCi_GetMatchCnt
	mov r1, #1
	strb r1, [r0, #0x17]
	bl DWCi_GetMatchCnt
	str r6, [r0, #0x20]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1bc]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1c8]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	bl qr2_send_statechanged
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x204]
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	add r0, r0, #1
	add r0, r7, r0, lsl #2
	str r6, [r0, #0xf4]
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	add r0, r0, #1
	add r0, r7, r0, lsl #2
	str r5, [r0, #0x24]
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	add r0, r0, #1
	add r0, r7, r0, lsl #1
	strh r4, [r0, #0xa4]
	bl DWCi_GetMatchCnt
	str r5, [r0, #0x1b8]
	bl DWCi_GetMatchCnt
	add r0, r0, #0x100
	strh r4, [r0, #0xb4]
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetAIDFromList
	ldrb r1, [r4, #0x14]
	add r1, r1, #1
	add r1, r5, r1
	strb r0, [r1, #0x2d0]
	str r6, [sp, #8]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	mov r7, #1
	add r0, r0, #1
	add r0, r4, r0
	ldrb r0, [r0, #0x2d0]
	str r0, [sp, #0xc]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	cmp r0, #1
	blt _0209714C
	add r6, sp, #8
	mov r5, #2
	mov r4, #7
_020970F0:
	bl DWCi_GetMatchCnt
	mov r9, r0
	bl DWCi_GetMatchCnt
	mov r8, r0
	bl DWCi_GetMatchCnt
	str r6, [sp]
	str r5, [sp, #4]
	add r0, r0, r7, lsl #1
	add r1, r9, r7, lsl #2
	add r2, r8, r7, lsl #2
	ldrh r3, [r0, #0xa4]
	ldr r1, [r1, #0xf4]
	ldr r2, [r2, #0x24]
	mov r0, r4
	bl DWCi_SendMatchCommand
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	add r7, r7, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	cmp r7, r0
	ble _020970F0
_0209714C:
	mov r0, #1
	bl DWCi_InitOptMinCompParam
	mov r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end DWCi_ProcessResvOK

	arm_func_start DWCi_CheckResvCommand
DWCi_CheckResvCommand: // 0x02097160
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r8, r3
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	beq _020971C8
	cmp r0, #1
	beq _02097198
	cmp r0, #2
	beq _020973A8
	b _0209745C
_02097198:
	bl DWCi_GetMatchCnt
	ldr r0, [r0]
	mov r1, r7
	bl gpIsBuddy
	cmp r0, #0
	moveq r4, #0xff
	beq _0209745C
	mov r0, r7
	bl DWCi_IsFriendByIdxList
	cmp r0, #0
	moveq r4, #3
	beq _0209745C
_020971C8:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r8, r0
	bne _02097230
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a9]
	cmp r0, #0
	bne _02097230
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r1, [r4, #0x14]
	ldrb r0, [r0, #0x16]
	cmp r1, r0
	beq _02097230
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x17]
	cmp r0, #0
	beq _02097294
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldr r1, [r4, #0x20]
	ldr r0, [r0, #0x200]
	cmp r1, r0
	bne _02097294
_02097230:
	mov r4, #3
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _0209745C
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #0xb4]
	cmp r0, #0
	bne _0209745C
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x17]
	cmp r0, #0
	beq _0209745C
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldr r1, [r5, #0x20]
	ldr r0, [r0, #0x200]
	cmp r1, r0
	bne _0209745C
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	bl qr2_send_statechanged
	b _0209745C
_02097294:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #3
	beq _020972B4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #4
	bne _020972E4
_020972B4:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	bne _020972D4
	bl DWCi_GetMatchCnt
	ldrh r0, [r0, #0x1a]
	cmp r0, #0
	beq _020972E4
_020972D4:
	cmp r6, #0
	bne _020972EC
	cmp r5, #0
	bne _020972EC
_020972E4:
	mov r4, #4
	b _0209745C
_020972EC:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x204]
	cmp r0, #0
	beq _020973A0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x204]
	cmp r7, r0
	bne _02097348
	ldr r0, [sp, #0x18]
	cmp r0, #0
	bne _02097338
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x200]
	cmp r0, r7
	bge _02097340
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x208]
	cmp r7, r0
	beq _02097340
_02097338:
	mov r4, #2
	b _0209745C
_02097340:
	mov r4, #0xff
	b _0209745C
_02097348:
	ldr r0, [sp, #0x18]
	cmp r0, #0
	bne _02097374
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x200]
	cmp r0, r7
	bge _02097398
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x208]
	cmp r0, #0
	bne _02097398
_02097374:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x204]
	bl DWCi_CancelReservation
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	movne r0, #0xff
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r4, #2
	b _0209745C
_02097398:
	mov r4, #3
	b _0209745C
_020973A0:
	mov r4, #2
	b _0209745C
_020973A8:
	bl DWCi_GetMatchCnt
	ldr r0, [r0]
	mov r1, r7
	bl gpIsBuddy
	cmp r0, #0
	moveq r4, #0xff
	beq _0209745C
	cmp r8, #3
	bne _020973E8
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r1, [r4, #0x14]
	ldrb r0, [r0, #0x16]
	cmp r1, r0
	bne _020973F0
_020973E8:
	mov r4, #3
	b _0209745C
_020973F0:
	ldr r0, _02097464 // =0x02143BB4
	ldrb r1, [r0]
	cmp r1, #1
	bne _02097410
	ldrb r0, [r0, #1]
	cmp r0, #1
	moveq r4, #0x13
	beq _0209745C
_02097410:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xa
	bne _02097450
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	bne _02097440
	bl DWCi_GetMatchCnt
	ldrh r0, [r0, #0x1a]
	cmp r0, #0
	beq _02097450
_02097440:
	cmp r6, #0
	bne _02097458
	cmp r5, #0
	bne _02097458
_02097450:
	mov r4, #4
	b _0209745C
_02097458:
	mov r4, #2
_0209745C:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02097464: .word 0x02143BB4
	arm_func_end DWCi_CheckResvCommand

	arm_func_start DWCi_ProcessRecvMatchCommand
DWCi_ProcessRecvMatchCommand: // 0x02097468
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x118
	mov r9, r0
	mov r8, r1
	mov r7, r2
	mov r10, r3
	ldr r6, [sp, #0x138]
	ldr r5, [sp, #0x13c]
	mov r4, #0
	bl DWCi_GetMatchCnt
	cmp r0, #0
	beq _020974A8
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0
	bne _020974B4
_020974A8:
	add sp, sp, #0x118
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020974B4:
	bl DWC_GetState
	cmp r0, #5
	bne _020974E4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #1
	bne _020974E4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	cmp r8, r0
	bne _020974E4
	bl DWCi_InitClWaitTimeout
_020974E4:
	cmp r9, #0x40
	bgt _02097584
	cmp r9, #0x40
	bge _020982CC
	cmp r9, #0x20
	addls pc, pc, r9, lsl #2
	b _02098340
_02097500: // jump table
	b _02098340 // case 0
	b _0209758C // case 1
	b _02097758 // case 2
	b _02097930 // case 3
	b _02097990 // case 4
	b _02097AB0 // case 5
	b _02097B2C // case 6
	b _02097C3C // case 7
	b _02097D54 // case 8
	b _02097ED4 // case 9
	b _02097F28 // case 10
	b _0209758C // case 11
	b _02097FD0 // case 12
	b _02098044 // case 13
	b _02098044 // case 14
	b _02098044 // case 15
	b _02098068 // case 16
	b _020980B8 // case 17
	b _0209815C // case 18
	b _020981B8 // case 19
	b _02098340 // case 20
	b _02098340 // case 21
	b _02098340 // case 22
	b _02098340 // case 23
	b _02098340 // case 24
	b _02098340 // case 25
	b _02098340 // case 26
	b _02098340 // case 27
	b _02098340 // case 28
	b _02098340 // case 29
	b _02098340 // case 30
	b _02098340 // case 31
	b _020981D0 // case 32
_02097584:
	cmp r9, #0x41
	b _02098340
_0209758C:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	ldrne r0, [r6, #8]
	ldrne r7, [r6, #4]
	movne r0, r0, lsl #0x10
	movne r10, r0, lsr #0x10
	cmp r9, #0xb
	moveq r0, #1
	movne r0, #0
	str r0, [sp]
	ldr r3, [r6]
	mov r0, r8
	mov r1, r7
	mov r2, r10
	bl DWCi_CheckResvCommand
	mov r5, r0
	cmp r5, #2
	bne _020976CC
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1dc]
	mov r0, r8
	mov r1, r7
	mov r2, r10
	bl DWCi_ProcessResvOK
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #0x118
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	bne _02097650
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x46c]
	cmp r0, #0
	beq _02097650
	bl DWCi_GetMatchCnt
	mov r6, r0
	mov r0, r8
	bl DWCi_GetFriendListIndex
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x470]
	ldr r2, [r6, #0x46c]
	mov r0, r4
	blx r2
_02097650:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	mov r4, #1
	str r0, [sp, #0x14]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	cmp r0, #1
	blt _02097698
	add r6, sp, #0x14
_02097674:
	bl DWCi_GetMatchCnt
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #0xf4]
	str r0, [r6, r4, lsl #2]
	add r4, r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	cmp r4, r0
	ble _02097674
_02097698:
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x1c]
	add r0, sp, #0x14
	str r1, [r0, r4, lsl #2]
	bl DWCi_GetMatchCnt
	ldrh r2, [r0, #0x1a]
	add r3, r4, #1
	add r1, sp, #0x14
	mov r0, #0xb
	str r2, [r1, r3, lsl #2]
	add r4, r4, #2
	bl DWCi_SetMatchStatus
	b _02097718
_020976CC:
	cmp r5, #3
	bne _02097718
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x16]
	cmp r0, #0
	beq _02097718
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r1, [r6, #0x14]
	ldrb r0, [r0, #0x16]
	cmp r1, r0
	bne _02097718
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	moveq r0, #0x10
	streq r0, [sp, #0x14]
	moveq r4, #1
_02097718:
	cmp r5, #0xff
	beq _02098340
	add r1, sp, #0x14
	str r1, [sp]
	mov r0, r5
	mov r1, r8
	mov r2, r7
	mov r3, r10
	str r4, [sp, #4]
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	beq _02098340
	add sp, sp, #0x118
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02097758:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #4
	bne _02098340
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x204]
	cmp r8, r0
	bne _02098340
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x208]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a7]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1c8]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1bc]
	bl DWCi_GetMatchCnt
	ldr r1, [r6]
	add r1, r6, r1, lsl #2
	ldr r1, [r1, #4]
	str r1, [r0, #0x24]
	bl DWCi_GetMatchCnt
	ldr r1, [r6]
	add r1, r6, r1, lsl #2
	ldr r1, [r1, #8]
	strh r1, [r0, #0xa4]
	bl DWCi_GetMatchCnt
	ldr r1, [r6]
	add r1, r6, r1, lsl #2
	ldr r1, [r1, #4]
	str r1, [r0, #0x1b8]
	bl DWCi_GetMatchCnt
	ldr r1, [r6]
	add r0, r0, #0x100
	add r1, r6, r1, lsl #2
	ldr r1, [r1, #8]
	strh r1, [r0, #0xb4]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02097884
	ldr r1, [r6]
	add r0, r6, #4
	bl DWCi_AreAllBuddies
	cmp r0, #0
	beq _02097840
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0
	beq _02097884
	mov r0, r8
	mov r1, r6
	bl DWCi_MakeBackupServerData
	b _02097884
_02097840:
	mov r0, r8
	bl DWCi_CancelReservation
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #0x118
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, #0
	mov r1, r0
	mov r2, r8
	bl DWCi_SendResvCommandToFriend
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	beq _02098340
	add sp, sp, #0x118
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02097884:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _02097908
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0
	beq _020978C8
	mov r0, r8
	mov r1, r6
	bl DWCi_MakeBackupServerData
	bl DWCi_ChangeToClient
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #0x118
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020978C8:
	mov r0, #6
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	mov r1, #0
	bl ServerBrowserGetServer
	mov r2, r0
	mov r0, #0
	mov r1, r0
	bl DWCi_NNStartupAsync
	bl DWCi_HandleNNError
	cmp r0, #0
	beq _02098340
	add sp, sp, #0x118
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02097908:
	mov r0, #5
	bl DWCi_SetMatchStatus
	mov r0, r8
	bl DWCi_SBUpdateAsync
	bl DWCi_HandleSBError
	cmp r0, #0
	beq _02098340
	add sp, sp, #0x118
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02097930:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #4
	bne _02098340
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x204]
	cmp r8, r0
	bne _02098340
	cmp r5, #0
	ble _0209797C
	ldr r0, [r6]
	cmp r0, #0x10
	bne _0209797C
	mov r0, #0xd
	mov r1, #0
	bl DWCi_StopMatching
	add sp, sp, #0x118
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0209797C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x204]
	bl DWCi_RetryReserving
	add sp, sp, #0x118
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02097990:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #4
	bne _02098340
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x204]
	cmp r8, r0
	bne _02098340
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0x1cc]
	str r1, [r4, #0x1d0]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x208]
	cmp r0, #0
	beq _020979E4
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a7]
	cmp r0, #0x10
	blo _020979F4
_020979E4:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	bne _02097A38
_020979F4:
	bl DWCi_GetMatchCnt
	mov r1, #1
	str r1, [r0, #0x1bc]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0x1c0]
	str r1, [r4, #0x1c4]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	beq _02098340
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x1a7]
	add r1, r1, #1
	strb r1, [r0, #0x1a7]
	b _02098340
_02097A38:
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x208]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a7]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _02097A8C
	mov r0, #3
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	mov r1, #1
	str r1, [r0, #0xe8]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0xec]
	str r1, [r4, #0xf0]
	b _02098340
_02097A8C:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02098340
	mov r1, #0
	mov r2, r1
	mov r0, #1
	bl DWCi_SendResvCommandToFriend
	b _02098340
_02097AB0:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x17]
	cmp r0, #0
	beq _02098340
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20]
	cmp r8, r0
	bne _02098340
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	bne _02097B10
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	bne _02097B10
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf8]
	cmp r8, r0
	bne _02097B10
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2CloseAllConnections
_02097B10:
	mov r0, r8
	bl DWCi_CancelPreConnectedServerProcess
	cmp r0, #0
	bne _02098340
	add sp, sp, #0x118
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02097B2C:
	ldr r0, [r6, #4]
	ldr r4, [r6]
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #1
	bne _02097B58
	mov r0, #6
	bl DWCi_SetMatchStatus
	b _02097B88
_02097B58:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #6
	beq _02097B78
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xb
	bne _02098340
_02097B78:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20]
	cmp r8, r0
	bne _02098340
_02097B88:
	bl DWCi_GetMatchCnt
	mov r1, #0xff
	strb r1, [r0, #0x3cc]
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r0, #1
	add r0, r6, r0, lsl #2
	ldr r0, [r0, #0xf4]
	cmp r8, r0
	beq _02097BD4
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r0, #1
	add r0, r6, r0, lsl #2
	str r8, [r0, #0xf4]
_02097BD4:
	mov r1, r5, asr #8
	mov r0, r5, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	str r4, [sp, #0x10]
	strh r0, [sp, #0xe]
	bl DWCi_GetMatchCnt
	mov r1, #1
	strb r1, [r0, #0x194]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2GetSocketSOCKET
	mov r4, r0
	bl DWCi_GetMatchCnt
	add r3, r0, #0x194
	mov r1, r4
	mov r0, #0
	add r2, sp, #0xc
	bl DWCi_NNCompletedCallback
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x18c]
	str r1, [r0, #0x190]
	b _02098340
_02097C3C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #1
	bne _02098340
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	cmp r8, r0
	bne _02098340
	ldr r0, [r6]
	str r0, [sp, #8]
	ldr r0, [r6, #4]
	and r4, r0, #0xff
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02097CD0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a6]
	cmp r0, #0
	bne _02097CD0
	ldr r0, [sp, #8]
	bl DWCi_IsFriendByIdxList
	str r0, [sp, #0x14]
	add r0, sp, #0x14
	str r0, [sp]
	mov r5, #1
	mov r1, r8
	mov r2, r7
	mov r3, r10
	mov r0, #0x20
	str r5, [sp, #4]
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #0x118
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02097CD0:
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	ldr r1, [sp, #8]
	add r0, r0, #1
	add r0, r5, r0, lsl #2
	str r1, [r0, #0xf4]
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	add r0, r0, #1
	add r0, r5, r0
	strb r4, [r0, #0x2d0]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	bl qr2_send_statechanged
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x46c]
	cmp r0, #0
	beq _02098340
	bl DWCi_GetMatchCnt
	mov r5, r0
	ldr r0, [sp, #8]
	bl DWCi_GetFriendListIndex
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x470]
	ldr r2, [r5, #0x46c]
	mov r0, r4
	blx r2
	b _02098340
_02097D54:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #1
	bne _02098340
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	cmp r8, r0
	bne _02098340
	ldr r0, [r6]
	str r0, [sp, #8]
	cmp r0, #0
	bne _02097DBC
	ldr r5, [r6, #4]
	ldr r4, [r6, #8]
	bl DWCi_GetMatchCnt
	add r0, r5, r0
	strb r4, [r0, #0x2d0]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldr r2, [r0, #0x200]
	add r1, r4, r5, lsl #2
	mov r0, #3
	str r2, [r1, #0xf4]
	bl DWCi_PostProcessConnection
	b _02098340
_02097DBC:
	ldr r0, [r6, #8]
	ldr r4, [r6, #4]
	and r5, r0, #0xff
	bl DWCi_GetMatchCnt
	add r0, r0, r4, lsl #2
	ldr r1, [sp, #8]
	ldr r0, [r0, #0xf4]
	cmp r1, r0
	bne _02097E3C
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	sub r0, r0, #1
	cmp r4, r0
	bne _02097E3C
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	add r1, sp, #8
	str r1, [sp]
	mov r1, #1
	str r1, [sp, #4]
	ldrh r3, [r0, #0xa4]
	ldr r2, [r4, #0x24]
	mov r1, r8
	mov r0, #9
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	beq _02098340
	add sp, sp, #0x118
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02097E3C:
	bl DWCi_GetMatchCnt
	ldr r1, [sp, #8]
	add r0, r0, r4, lsl #2
	str r1, [r0, #0xf4]
	bl DWCi_GetMatchCnt
	add r0, r4, r0
	strb r5, [r0, #0x2d0]
	bl DWCi_GetMatchCnt
	ldr r1, [r6, #0xc]
	add r0, r0, r4, lsl #2
	str r1, [r0, #0x24]
	bl DWCi_GetMatchCnt
	ldr r1, [r6, #0x10]
	add r0, r0, r4, lsl #1
	strh r1, [r0, #0xa4]
	bl DWCi_GetMatchCnt
	ldr r1, [r6, #0xc]
	str r1, [r0, #0x1b8]
	bl DWCi_GetMatchCnt
	add r1, r0, #0x100
	ldr r2, [r6, #0x10]
	mov r0, #5
	strh r2, [r1, #0xb4]
	bl DWCi_SetMatchStatus
	ldr r0, [sp, #8]
	bl DWCi_SBUpdateAsync
	bl DWCi_HandleSBError
	cmp r0, #0
	addne sp, sp, #0x118
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1c8]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1bc]
	b _02098340
_02097ED4:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xd
	bne _02098340
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a4]
	ldr r1, [r6]
	add r0, r0, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0xf4]
	cmp r1, r0
	bne _02098340
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x1a4]
	add r1, r1, #1
	strb r1, [r0, #0x1a4]
	mov r0, #0
	bl DWCi_PostProcessConnection
	b _02098340
_02097F28:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #1
	beq _02097F48
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0x12
	bne _02098340
_02097F48:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	beq _02097F6C
	ldr r1, [r6]
	add r0, r6, #4
	bl DWCi_AreAllBuddies
	cmp r0, #0
	beq _02097F88
_02097F6C:
	bl DWCi_GetMatchCnt
	ldr r1, [r6, #4]
	str r1, [r0, #0x208]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a7]
	b _02097F94
_02097F88:
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x208]
_02097F94:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0
	beq _02097FB8
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2CloseAllConnections
	b _02098340
_02097FB8:
	bl DWCi_ResumeMatching
	cmp r0, #0
	beq _02098340
	add sp, sp, #0x118
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02097FD0:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	cmp r8, r0
	bne _02098340
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	beq _02098000
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _0209801C
_02098000:
	mov r0, r8
	bl DWCi_CancelPreConnectedClientProcess
	cmp r0, #0
	bne _02098340
	add sp, sp, #0x118
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0209801C:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	bne _02098340
	bl DWCi_GetMatchCnt
	str r8, [r0, #0x20c]
	bl DWCi_CloseAllConnectionsByTimeout
	mov r0, #0
	bl DWCi_RestartFromCancel
	b _02098340
_02098044:
	ldr r2, [r6]
	mov r0, r8
	mov r1, r9
	bl DWCi_ProcessCancelMatchSynCommand
	cmp r0, #0
	bne _02098340
	add sp, sp, #0x118
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02098068:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	cmp r8, r0
	addne sp, sp, #0x118
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	cmp r5, #0
	mov r7, #0
	ble _02098340
	mov r4, r7
_02098090:
	ldr r0, [r6, r7, lsl #2]
	mov r1, r4
	bl DWCi_GetAIDFromProfileID
	cmp r0, #0xff
	beq _020980A8
	bl DWC_CloseConnectionHard
_020980A8:
	add r7, r7, #1
	cmp r7, r5
	blt _02098090
	b _02098340
_020980B8:
	ldr r0, _0209834C // =0x02143BAC
	ldr r4, [r0]
	cmp r4, #0
	beq _02098118
	ldrb r0, [r4]
	cmp r0, #0
	beq _02098118
	bl OS_GetTick
	ldr r3, [r4, #0x10]
	ldr r2, [r4, #0x14]
	subs r3, r0, r3
	sbc r0, r1, r2
	mov r1, r0, lsl #6
	ldr r2, _02098350 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	ldr r2, [r4, #4]
	cmp r1, #0
	cmpeq r0, r2
	movhs r0, #1
	strhs r0, [sp, #0x14]
	bhs _02098120
_02098118:
	mov r0, #0
	str r0, [sp, #0x14]
_02098120:
	add r0, sp, #0x14
	str r0, [sp]
	mov r4, #1
	mov r1, r8
	mov r2, r7
	mov r3, r10
	mov r0, #0x12
	str r4, [sp, #4]
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	beq _02098340
	add sp, sp, #0x118
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0209815C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0x13
	bne _02098340
	mov r0, r8
	mov r1, #0
	bl DWCi_GetAIDFromProfileID
	cmp r0, #0xff
	beq _02098340
	ldr r1, _0209834C // =0x02143BAC
	mov r4, #1
	ldr r3, [r1]
	mov r5, r4, lsl r0
	ldr r2, [r3, #8]
	orr r0, r2, r4, lsl r0
	str r0, [r3, #8]
	ldr r0, [r6]
	cmp r0, #0
	ldrne r1, [r1]
	ldrne r0, [r1, #0xc]
	orrne r0, r0, r5
	strne r0, [r1, #0xc]
	b _02098340
_020981B8:
	mov r0, #0xc
	mov r1, #0
	bl DWCi_StopMatching
	add sp, sp, #0x118
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020981D0:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02098340
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a6]
	cmp r0, #0
	bne _02098340
	mov r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _02098340
_02098204:
	bl DWCi_GetMatchCnt
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #0xf4]
	cmp r8, r0
	bne _020982B4
	ldr r0, [r6]
	cmp r0, #0
	bne _0209828C
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xb
	beq _02098244
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xc
	bne _0209825C
_02098244:
	bl DWCi_InvalidateReservation
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #0x118
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0209825C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x19c]
	cmp r0, #0
	beq _02098284
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x19c]
	bl NNCancel
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x19c]
_02098284:
	bl DWCi_RestartFromTimeout
	b _02098340
_0209828C:
	bl DWCi_GetMatchCnt
	mov r4, r0
	mov r0, r8
	mov r1, #0
	bl DWCi_GetAIDFromProfileID
	ldr r2, [r4, #0x1dc]
	mov r1, #1
	orr r0, r2, r1, lsl r0
	str r0, [r4, #0x1dc]
	b _02098340
_020982B4:
	add r4, r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r4, r0
	ble _02098204
	b _02098340
_020982CC:
	mov r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _02098340
_020982E0:
	bl DWCi_GetMatchCnt
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #0xf4]
	cmp r8, r0
	bne _0209832C
	mov r4, #0
	str r4, [sp]
	mov r1, r8
	mov r2, r7
	mov r3, r10
	mov r0, #0x41
	str r4, [sp, #4]
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	beq _02098340
	add sp, sp, #0x118
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0209832C:
	add r4, r4, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r4, r0
	ble _020982E0
_02098340:
	mov r0, #1
	add sp, sp, #0x118
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0209834C: .word 0x02143BAC
_02098350: .word 0x000082EA
	arm_func_end DWCi_ProcessRecvMatchCommand

	arm_func_start DWCi_GetGPBuddyAdditionalMsg
DWCi_GetGPBuddyAdditionalMsg: // 0x02098354
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r1
	mov r4, r0
	mov r8, r2
	mov r0, r9
	mov r1, #0
	bl strchr
	mov r7, r0
	cmp r8, #0
	mov r6, #0
	ble _020983B4
	mov r5, #0x2f
_02098388:
	mov r0, r9
	mov r1, r5
	bl strchr
	cmp r0, #0
	addeq sp, sp, #4
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	add r6, r6, #1
	cmp r6, r8
	add r9, r0, #1
	blt _02098388
_020983B4:
	mov r0, r9
	mov r1, #0x2f
	bl strchr
	cmp r0, #0
	moveq r0, r7
	cmp r9, r0
	addeq sp, sp, #4
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	sub r5, r0, r9
	mov r0, r9
	mov r1, r4
	mov r2, r5
	bl MI_CpuCopy8
	mov r1, #0
	mov r0, r5
	strb r1, [r4, r5]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end DWCi_GetGPBuddyAdditionalMsg

	arm_func_start DWCi_SendGPBuddyMsgCommand
DWCi_SendGPBuddyMsgCommand: // 0x02098400
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x208
	mov r7, r0
	mov r5, r2
	mov r4, r3
	mov r0, #3
	mov r6, r1
	str r0, [sp]
	ldr ip, _02098498 // =0x0211C2D0
	ldr r2, _0209849C // =aSDvS
	ldr r3, _020984A0 // =_0211C2C8
	add r0, sp, #8
	mov r1, #0x200
	str ip, [sp, #4]
	bl OS_SNPrintf
	add r1, sp, #8
	add r2, sp, #9
	strb r6, [r1, r0]
	mov r1, #0
	strb r1, [r2, r0]
	cmp r4, #0
	add r8, r2, r0
	beq _02098480
	mov r0, r4
	bl strlen
	mov r6, r0
	mov r0, r4
	mov r1, r8
	mov r2, r6
	bl MI_CpuCopy8
	mov r0, #0
	strb r0, [r8, r6]
_02098480:
	add r2, sp, #8
	mov r0, r7
	mov r1, r5
	bl gpSendBuddyMessageA
	add sp, sp, #0x208
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02098498: .word 0x0211C2D0
_0209849C: .word aSDvS
_020984A0: .word _0211C2C8
	arm_func_end DWCi_SendGPBuddyMsgCommand

	arm_func_start DWCi_SendSBMsgCommand
DWCi_SendSBMsgCommand: // 0x020984A4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x9c
	mov r5, r0
	mov r8, r1
	mov r7, r2
	cmp r3, #0
	ldr r4, [sp, #0xb8]
	beq _020984E0
	cmp r4, #0
	beq _020984E0
	add r1, sp, #0x18
	mov r0, r3
	mov r2, r4, lsl #2
	bl MIi_CpuCopy32
	b _020984E4
_020984E0:
	mov r4, #0
_020984E4:
	ldr r6, _020985B8 // =0x0211C258
	add r9, sp, #4
	ldrb r3, [r6]
	ldrb r2, [r6, #1]
	mov r0, r4, lsl #2
	mov r1, #3
	strb r3, [r9]
	strb r2, [r9, #1]
	ldrb r3, [r6, #2]
	ldrb r2, [r6, #3]
	strb r3, [r9, #2]
	strb r2, [r9, #3]
	ldrb r2, [r6, #4]
	strb r2, [r9, #4]
	str r1, [sp, #8]
	strb r5, [sp, #0xc]
	strb r0, [sp, #0xd]
	bl DWCi_GetMatchCnt
	ldrh r0, [r0, #0x1a]
	strh r0, [sp, #0xe]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1c]
	str r0, [sp, #0x10]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x200]
	mov r6, #0
	str r0, [sp, #0x14]
	mov r4, r6
_02098554:
	bl DWCi_GetMatchCnt
	mov r5, r0
	mov r0, r8
	mov r1, r4
	mov r2, r4
	bl gt2AddressToString
	mov r1, r0
	ldrb r0, [sp, #0xd]
	mov r2, r7
	mov r3, r9
	add r0, r0, #0x14
	str r0, [sp]
	ldr r0, [r5, #0xe4]
	bl ServerBrowserSendMessageToServerA
	cmp r0, #0
	addeq sp, sp, #0x9c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	cmp r0, #2
	addne sp, sp, #0x9c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	add r6, r6, #1
	cmp r6, #5
	blt _02098554
	add sp, sp, #0x9c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020985B8: .word 0x0211C258
	arm_func_end DWCi_SendSBMsgCommand

	arm_func_start DWCi_SendMatchCommand
DWCi_SendMatchCommand: // 0x020985BC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x224
	mov r11, r0
	str r1, [sp, #4]
	str r2, [sp, #8]
	str r3, [sp, #0xc]
	ldr r10, [sp, #0x248]
	ldr r9, [sp, #0x24c]
	mov r8, #0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	beq _02098618
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	beq _02098610
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a6]
	cmp r0, #0
	beq _02098638
_02098610:
	cmp r11, #6
	bne _02098638
_02098618:
	ldr r1, [sp, #8]
	ldr r2, [sp, #0xc]
	mov r0, r11
	mov r3, r10
	str r9, [sp]
	bl DWCi_SendSBMsgCommand
	mov r4, r0
	b _020986D8
_02098638:
	cmp r10, #0
	beq _020986B0
	cmp r9, #0
	beq _020986B0
	ldr r3, [r10]
	ldr r2, _02098774 // =0x0211C254
	add r0, sp, #0x20
	mov r1, #0x200
	bl OS_SNPrintf
	mov r8, r0
	cmp r9, #1
	mov r7, #1
	ble _020986B0
	add r6, sp, #0x10
	mov r5, #0x10
_02098674:
	ldr r3, [r10, r7, lsl #2]
	ldr r2, _02098778 // =0x0211C2D4
	mov r0, r6
	mov r1, r5
	bl OS_SNPrintf
	mov r4, r0
	add r1, sp, #0x20
	mov r0, r6
	add r1, r1, r8
	mov r2, r4
	bl MI_CpuCopy8
	add r7, r7, #1
	add r8, r8, r4
	cmp r7, r9
	blt _02098674
_020986B0:
	add r0, sp, #0x20
	mov r1, #0
	strb r1, [r0, r8]
	bl DWCi_GetMatchCnt
	ldr r0, [r0]
	ldr r2, [sp, #4]
	add r3, sp, #0x20
	mov r1, r11
	bl DWCi_SendGPBuddyMsgCommand
	mov r4, r0
_020986D8:
	cmp r11, #2
	beq _020986F8
	cmp r11, #6
	beq _020986F8
	add r0, r11, #0xf8
	and r0, r0, #0xff
	cmp r0, #1
	bhi _02098768
_020986F8:
	bl DWCi_GetMatchCnt
	strb r11, [r0, #0x3cc]
	bl DWCi_GetMatchCnt
	add r1, r0, #0x300
	ldr r0, [sp, #0xc]
	strh r0, [r1, #0xce]
	bl DWCi_GetMatchCnt
	ldr r1, [sp, #8]
	str r1, [r0, #0x3d0]
	bl DWCi_GetMatchCnt
	ldr r1, [sp, #4]
	str r1, [r0, #0x454]
	bl DWCi_GetMatchCnt
	str r9, [r0, #0x458]
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl OS_GetTick
	str r0, [r5, #0x45c]
	str r1, [r5, #0x460]
	cmp r10, #0
	beq _02098768
	cmp r9, #0
	beq _02098768
	bl DWCi_GetMatchCnt
	add r1, r0, #0x3d4
	mov r0, r10
	mov r2, r9, lsl #2
	bl MIi_CpuCopy32
_02098768:
	mov r0, r4
	add sp, sp, #0x224
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02098774: .word 0x0211C254
_02098778: .word 0x0211C2D4
	arm_func_end DWCi_SendMatchCommand

	arm_func_start DWCi_DoNatNegotiationAsync
DWCi_DoNatNegotiationAsync: // 0x0209877C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	ldrb r0, [r7]
	cmp r0, #0
	bne _020987D4
	bl DWCi_GetMatchCnt
	mov r4, r0
	mov r1, #0
	ldr r0, [r7, #4]
	mov r2, r1
	bl gt2AddressToString
	mov r1, r0
	ldrh r2, [r7, #2]
	ldr r0, [r4, #0xe4]
	ldr r3, [r7, #8]
	bl ServerBrowserSendNatNegotiateCookieToServerA
	bl DWCi_HandleSBError
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, r7, pc}
_020987D4:
	ldr r5, _02098834 // =DWCi_NNCompletedCallback
	ldr r4, _02098838 // =DWCi_NNProgressCallback
	mov r6, #0
_020987E0:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2GetSocketSOCKET
	str r5, [sp]
	str r7, [sp, #4]
	ldrb r2, [r7]
	ldr r1, [r7, #8]
	mov r3, r4
	bl NNBeginNegotiationWithSocket
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r0, #3
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	add r6, r6, #1
	cmp r6, #5
	blt _020987E0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02098834: .word DWCi_NNCompletedCallback
_02098838: .word DWCi_NNProgressCallback
	arm_func_end DWCi_DoNatNegotiationAsync

	arm_func_start DWCi_NNStartupAsync
DWCi_NNStartupAsync: // 0x0209883C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x14
	mov r4, r0
	mov r8, r1
	mov r7, r2
	bl DWCi_GetMatchCnt
	cmp r4, #0
	ldrb r6, [r0, #0x14]
	mov r4, #0
	bne _02098A80
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	add r1, r0, #0x100
	ldr r2, [r5, #0x200]
	ldr r0, _02098B24 // =0x0000FFFF
	ldrh r1, [r1, #0x7e]
	and r2, r2, r0
	mov r0, r7
	orr r8, r2, r1, lsl #16
	bl SBServerHasPrivateAddress
	cmp r0, #0
	beq _020988F8
	mov r0, r7
	bl SBServerGetPublicInetAddress
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserGetMyPublicIPAddr
	cmp r5, r0
	movne r5, #1
	bne _02098980
	bl DWCi_GetMatchCnt
	mov r5, r0
	mov r0, r7
	bl SBServerGetPrivateInetAddress
	add r1, r5, r6, lsl #2
	str r0, [r1, #0x210]
	bl DWCi_GetMatchCnt
	mov r5, r0
	mov r0, r7
	bl SBServerGetPrivateQueryPort
	add r1, r5, r6, lsl #1
	add r1, r1, #0x200
	strh r0, [r1, #0x90]
	mov r5, r4
	b _02098980
_020988F8:
	bl SO_GetHostID
	mov r0, r0, lsl #0x10
	ldr r1, _02098B24 // =0x0000FFFF
	ldr r2, _02098B28 // =0x0000A8C0
	and r1, r1, r0, lsr #16
	cmp r1, r2
	mov r0, r0, lsr #0x10
	beq _02098940
	and r1, r0, #0xff
	cmp r1, #0xac
	bne _02098938
	and r0, r0, #0xff00
	cmp r0, #0x1000
	blo _02098938
	cmp r0, #0x1f00
	bls _02098940
_02098938:
	cmp r1, #0x10
	bne _02098948
_02098940:
	mov r5, #1
	b _02098980
_02098948:
	bl DWCi_GetMatchCnt
	mov r5, r0
	mov r0, r7
	bl SBServerGetPublicInetAddress
	add r1, r5, r6, lsl #2
	str r0, [r1, #0x210]
	bl DWCi_GetMatchCnt
	mov r5, r0
	mov r0, r7
	bl SBServerGetPublicQueryPort
	add r1, r5, r6, lsl #1
	add r1, r1, #0x200
	strh r0, [r1, #0x90]
	mov r5, #0
_02098980:
	cmp r5, #0
	beq _020989AC
	bl DWCi_GetMatchCnt
	mov r6, r0
	mov r0, #0x10000
	bl DWCi_GetMathRand32
	add r1, r6, #0x100
	strh r0, [r1, #0x7e]
	bl DWCi_GetMatchCnt
	str r8, [r0, #0x19c]
	b _02098A38
_020989AC:
	bl SO_GetHostID
	str r0, [sp, #8]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2GetLocalPort
	str r0, [sp, #0xc]
	bl DWCi_GetMatchCnt
	mov r9, r0
	mov r0, r7
	bl SBServerGetPublicInetAddress
	mov r8, r0
	mov r0, r7
	bl SBServerGetPublicQueryPort
	add r1, r9, r6, lsl #2
	add r6, sp, #8
	mov r3, r0
	mov r0, #2
	str r6, [sp]
	str r0, [sp, #4]
	ldr r1, [r1, #0xf4]
	mov r2, r8
	mov r0, #6
	bl DWCi_SendMatchCommand
	mov r6, r0
	bl DWCi_GetMatchCnt
	mov r1, #0
	cmp r6, #0
	strb r1, [r0, #0x3cd]
	addne sp, sp, #0x14
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x19c]
_02098A38:
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x194]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x195]
	bl DWCi_GetMatchCnt
	mov r6, r0
	mov r0, r7
	bl SBServerGetPublicQueryPort
	add r1, r6, #0x100
	strh r0, [r1, #0x96]
	bl DWCi_GetMatchCnt
	mov r6, r0
	mov r0, r7
	bl SBServerGetPublicInetAddress
	str r0, [r6, #0x198]
	b _02098AC0
_02098A80:
	bl DWCi_GetMatchCnt
	mov r1, #1
	strb r1, [r0, #0x194]
	bl DWCi_GetMatchCnt
	mov r1, r4
	strb r1, [r0, #0x195]
	bl DWCi_GetMatchCnt
	add r0, r0, #0x100
	mov r1, r4
	strh r1, [r0, #0x96]
	bl DWCi_GetMatchCnt
	mov r1, r4
	str r1, [r0, #0x198]
	bl DWCi_GetMatchCnt
	str r8, [r0, #0x19c]
	mov r5, #1
_02098AC0:
	cmp r5, #0
	beq _02098ADC
	bl DWCi_GetMatchCnt
	add r0, r0, #0x194
	bl DWCi_DoNatNegotiationAsync
	mov r4, r0
	b _02098B18
_02098ADC:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2GetSocketSOCKET
	mov r5, r0
	bl DWCi_GetMatchCnt
	add r3, r0, #0x194
	mov r0, #0
	mov r1, r5
	mov r2, r0
	bl DWCi_NNCompletedCallback
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x18c]
	str r1, [r0, #0x190]
_02098B18:
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02098B24: .word 0x0000FFFF
_02098B28: .word 0x0000A8C0
	arm_func_end DWCi_NNStartupAsync

	arm_func_start DWCi_GetDefaultMatchFilter
DWCi_GetDefaultMatchFilter: // 0x02098B2C
	stmdb sp!, {lr}
	sub sp, sp, #0x24
	mov lr, #3
	ldr ip, _02098B80 // =aDwcPid
	str lr, [sp]
	str ip, [sp, #4]
	str r1, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	ldr r2, _02098B84 // =aDwcMtype
	ldr r1, _02098B88 // =aDwcMresv
	str r2, [sp, #0x14]
	str r3, [sp, #0x18]
	str r1, [sp, #0x1c]
	ldr r2, _02098B8C // =aSDAndSUAndMaxp
	ldr r3, _02098B90 // =aDwcMver
	mov r1, #0x100
	str ip, [sp, #0x20]
	bl OS_SNPrintf
	add sp, sp, #0x24
	ldmia sp!, {pc}
	.align 2, 0
_02098B80: .word aDwcPid
_02098B84: .word aDwcMtype
_02098B88: .word aDwcMresv
_02098B8C: .word aSDAndSUAndMaxp
_02098B90: .word aDwcMver
	arm_func_end DWCi_GetDefaultMatchFilter

	arm_func_start DWCi_SBUpdateAsync
DWCi_SBUpdateAsync: // 0x02098B94
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1b4
	mov r7, #8
	mov r6, #0xa
	mov r5, #0x32
	mov r4, #0x33
	mov r3, #0x34
	mov r2, #0x35
	mov r1, #0x36
	strb r7, [sp, #0x10c]
	strb r6, [sp, #0x10d]
	strb r5, [sp, #0x10e]
	strb r4, [sp, #0x10f]
	strb r3, [sp, #0x110]
	strb r2, [sp, #0x111]
	strb r1, [sp, #0x112]
	mov r5, r0
	mov r4, #7
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	beq _02098BFC
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02098C2C
_02098BFC:
	add r1, sp, #0x100
	ldr r2, _02098D7C // =0x02143BDC
	add r1, r1, #0x13
	mov r3, #0
_02098C0C:
	ldrb r0, [r2]
	add r3, r3, #1
	add r2, r2, #0xc
	cmp r0, #0
	strneb r0, [r1], #1
	addne r4, r4, #1
	cmp r3, #0x9a
	blt _02098C0C
_02098C2C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02098CE4
_02098C40: // jump table
	b _02098CE4 // case 0
	b _02098CE4 // case 1
	b _02098CC4 // case 2
	b _02098C58 // case 3
	b _02098CC4 // case 4
	b _02098CC4 // case 5
_02098C58:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x208]
	cmp r0, #0
	bne _02098CBC
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldr r1, [r6, #0x200]
	ldrb r2, [r5, #0x16]
	ldrb r3, [r0, #0x15]
	add r0, sp, #0xc
	bl DWCi_GetDefaultMatchFilter
	ldr r0, _02098D80 // =0x02143BB8
	ldr r5, [r0]
	cmp r5, #0
	beq _02098CE4
	add r0, sp, #0xc
	ldr r2, _02098D84 // =aSAndS
	mov r3, r0
	mov r1, #0x100
	str r5, [sp]
	bl OS_SNPrintf
	b _02098CE4
_02098CBC:
	bl DWCi_GetMatchCnt
	ldr r5, [r0, #0x208]
_02098CC4:
	ldr r2, _02098D88 // =aSU
	ldr r3, _02098D8C // =aDwcPid
	add r0, sp, #0xc
	mov r1, #0x100
	str r5, [sp]
	bl OS_SNPrintf
	bl DWCi_GetMatchCnt
	str r5, [r0, #0x204]
_02098CE4:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserClear
	mov r9, #0
	add r8, sp, #0xc
	add r11, sp, #0x10c
	mov r5, r9
	mov r7, #6
	mov r6, #1
_02098D08:
	bl DWCi_GetMatchCnt
	str r4, [sp]
	str r8, [sp, #4]
	str r7, [sp, #8]
	ldr r0, [r0, #0xe4]
	mov r1, r6
	mov r2, r5
	mov r3, r11
	bl ServerBrowserLimitUpdateA
	movs r10, r0
	beq _02098D48
	cmp r10, #2
	bne _02098D48
	add r9, r9, #1
	cmp r9, #5
	blt _02098D08
_02098D48:
	cmp r10, #0
	bne _02098D70
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	ldr r2, _02098D90 // =0x00EFB5F7
	adds r0, r0, r2
	str r0, [r4, #0x174]
	adc r0, r1, #0
	str r0, [r4, #0x178]
_02098D70:
	mov r0, r10
	add sp, sp, #0x1b4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02098D7C: .word 0x02143BDC
_02098D80: .word 0x02143BB8
_02098D84: .word aSAndS
_02098D88: .word aSU
_02098D8C: .word aDwcPid
_02098D90: .word 0x00EFB5F7
	arm_func_end DWCi_SBUpdateAsync

	arm_func_start DWCi_CloseMatching
DWCi_CloseMatching: // 0x02098D94
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_GetMatchCnt
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	cmp r0, #0
	beq _02098DD4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserFree
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0xe4]
_02098DD4:
	bl NNFreeNegotiateList
	mov r0, #0
	bl DWCi_SetMatchStatus
	ldr r0, _02098E20 // =0x02143BB8
	ldr r1, [r0]
	cmp r1, #0
	beq _02098E08
	mov r0, #4
	mov r2, #0
	bl DWC_Free
	ldr r0, _02098E20 // =0x02143BB8
	mov r1, #0
	str r1, [r0]
_02098E08:
	bl DWCi_ClearGameMatchKeys
	bl DWCi_GetMatchCnt
	mov r1, #1
	strb r1, [r0, #0x18]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02098E20: .word 0x02143BB8
	arm_func_end DWCi_CloseMatching

	arm_func_start DWCi_SetMatchCommonParam
DWCi_SetMatchCommonParam: // 0x02098E24
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r0, #0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl DWCi_ResetMatchParam
	bl DWCi_GetMatchCnt
	strb r7, [r0, #0x15]
	bl DWCi_GetMatchCnt
	strb r6, [r0, #0x16]
	bl DWCi_GetMatchCnt
	str r5, [r0, #0x464]
	bl DWCi_GetMatchCnt
	str r4, [r0, #0x468]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x17d]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x2d0]
	mov r0, #0x32
	ldr r1, _02098EC0 // =aDwcPid
	bl qr2_register_keyA
	mov r0, #0x33
	ldr r1, _02098EC4 // =aDwcMtype
	bl qr2_register_keyA
	mov r0, #0x34
	ldr r1, _02098EC8 // =aDwcMresv
	bl qr2_register_keyA
	mov r0, #0x35
	ldr r1, _02098ECC // =aDwcMver
	bl qr2_register_keyA
	mov r0, #0x36
	ldr r1, _02098ED0 // =aDwcEval
	bl qr2_register_keyA
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02098EC0: .word aDwcPid
_02098EC4: .word aDwcMtype
_02098EC8: .word aDwcMresv
_02098ECC: .word aDwcMver
_02098ED0: .word aDwcEval
	arm_func_end DWCi_SetMatchCommonParam

	arm_func_start DWCi_ResetMatchParam
DWCi_ResetMatchParam: // 0x02098ED4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0xc]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x17c]
	bl DWCi_GetMatchCnt
	mov r5, r0
	mov r0, #0x10000
	bl DWCi_GetMathRand32
	add r1, r5, #0x100
	strh r0, [r1, #0x7e]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x180]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x184]
	str r1, [r0, #0x188]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x18c]
	str r1, [r0, #0x190]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a4]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a9]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1aa]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1ab]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1ac]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a7]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a8]
	bl DWCi_GetMatchCnt
	mov r1, #0
	add r0, r0, #0x100
	strh r1, [r0, #0xb2]
	bl DWCi_GetMatchCnt
	mov r1, #0
	add r0, r0, #0x100
	strh r1, [r0, #0xb4]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1b8]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1e0]
	str r1, [r0, #0x1e4]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1f0]
	str r1, [r0, #0x1f4]
	bl DWCi_GetMatchCnt
	add r1, r0, #0x3cc
	mov r0, #0
	mov r2, #0x98
	bl MIi_CpuClear32
	cmp r4, #2
	bne _02099050
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	strb r0, [r4, #0x14]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	bne _0209902C
	mov r0, #1
	bl DWCi_SetMatchStatus
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_0209902C:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	mov r0, #0xa
	bl DWCi_SetMatchStatus
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02099050:
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0xd]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0xe]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x14]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x17]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x20]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0xe8]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a5]
	bl DWCi_GetMatchCnt
	mov r1, #0
	add r0, r0, #0x100
	strh r1, [r0, #0xb0]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1bc]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1c0]
	str r1, [r0, #0x1c4]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1c8]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1cc]
	str r1, [r0, #0x1d0]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1d4]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x204]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x208]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x2f0]
	bl DWCi_GetMatchCnt
	add r1, r0, #0x24
	mov r0, #0
	mov r2, #0x80
	bl MIi_CpuClear32
	bl DWCi_GetMatchCnt
	add r1, r0, #0xa4
	mov r0, #0
	mov r2, #0x40
	bl MIi_CpuClear16
	bl DWCi_GetMatchCnt
	add r1, r0, #0xf4
	mov r0, #0
	mov r2, #0x80
	bl MIi_CpuClear32
	bl DWCi_GetMatchCnt
	add r1, r0, #0x194
	mov r0, #0
	mov r2, #0xc
	bl MIi_CpuClear32
	bl DWCi_GetMatchCnt
	add r1, r0, #0x210
	mov r0, #0
	mov r2, #0x80
	bl MIi_CpuClear32
	bl DWCi_GetMatchCnt
	add r1, r0, #0x290
	mov r0, #0
	mov r2, #0x40
	bl MIi_CpuClear16
	bl DWCi_GetMatchCnt
	add r0, r0, #0x2d0
	mov r1, #0
	mov r2, #0x20
	bl MI_CpuFill8
	bl DWCi_GetMatchCnt
	add r1, r0, #0x348
	mov r0, #0
	mov r2, #0x84
	bl MIi_CpuClear32
	cmp r4, #1
	bne _02099208
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _020991E4
	mov r0, #3
	bl DWCi_SetMatchStatus
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020991E4:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	mov r0, #4
	bl DWCi_SetMatchStatus
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02099208:
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x15]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x16]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x18]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x20c]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1a6]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1ae]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1ad]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1f8]
	str r1, [r0, #0x1fc]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x46c]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x470]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWCi_ResetMatchParam

	arm_func_start DWCi_IsShutdownMatch
DWCi_IsShutdownMatch: // 0x0209928C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_GetMatchCnt
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_IsShutdownMatch

	arm_func_start DWCi_ShutdownMatch
DWCi_ShutdownMatch: // 0x020992AC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl DWCi_SetMatchCnt
	ldr r0, _02099328 // =0x02143BB8
	ldr r1, [r0]
	cmp r1, #0
	beq _020992E4
	mov r0, #4
	mov r2, #0
	bl DWC_Free
	ldr r0, _02099328 // =0x02143BB8
	mov r1, #0
	str r1, [r0]
_020992E4:
	bl DWCi_ClearGameMatchKeys
	ldr r0, _0209932C // =0x02143BAC
	ldr r1, [r0]
	cmp r1, #0
	beq _02099310
	mov r0, #4
	mov r2, #0
	bl DWC_Free
	ldr r0, _0209932C // =0x02143BAC
	mov r1, #0
	str r1, [r0]
_02099310:
	ldr r0, _02099330 // =0x02143BB4
	mov r1, #0
	strb r1, [r0]
	strb r1, [r0, #1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02099328: .word 0x02143BB8
_0209932C: .word 0x02143BAC
_02099330: .word 0x02143BB4
	arm_func_end DWCi_ShutdownMatch

	arm_func_start DWCi_GPSetServerStatus
DWCi_GPSetServerStatus: // 0x02099334
	stmdb sp!, {lr}
	sub sp, sp, #0x2c
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	addne sp, sp, #0x2c
	movne r0, #0
	ldmneia sp!, {pc}
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x16]
	ldr r2, _020993F4 // =0x0211C254
	add r0, sp, #0
	add r3, r1, #1
	mov r1, #0xc
	bl OS_SNPrintf
	ldr r0, _020993F8 // =_0211C344
	add r1, sp, #0
	add r2, sp, #0xc
	mov r3, #0x2f
	bl DWC_SetCommonKeyValueString
	bl DWCi_GetMatchCnt
	ldrb r2, [r0, #0xd]
	add r0, sp, #0
	mov r1, #0xc
	add r3, r2, #1
	ldr r2, _020993F4 // =0x0211C254
	bl OS_SNPrintf
	ldr r0, _020993FC // =0x0211C348
	add r1, sp, #0
	add r2, sp, #0xc
	mov r3, #0x2f
	bl DWC_AddCommonKeyValueString
	ldr r2, _020993F4 // =0x0211C254
	add r0, sp, #0
	mov r1, #0xc
	mov r3, #3
	bl OS_SNPrintf
	ldr r0, _02099400 // =0x0211C2B4
	add r1, sp, #0
	add r2, sp, #0xc
	mov r3, #0x2f
	bl DWC_AddCommonKeyValueString
	mov r0, #6
	add r1, sp, #0xc
	mov r2, #0
	bl DWCi_SetGPStatus
	add sp, sp, #0x2c
	ldmia sp!, {pc}
	.align 2, 0
_020993F4: .word 0x0211C254
_020993F8: .word _0211C344
_020993FC: .word 0x0211C348
_02099400: .word 0x0211C2B4
	arm_func_end DWCi_GPSetServerStatus

	arm_func_start DWCi_GetValidAIDList
DWCi_GetValidAIDList: // 0x02099404
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	bl DWCi_GetMatchCnt
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, _020994A8 // =0x02143BBC
	mov r1, #0
	mov r2, #0x20
	bl MI_CpuFill8
	mov r6, #0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xe]
	cmp r0, #0
	blt _02099490
	ldr r5, _020994A8 // =0x02143BBC
	mov r4, #1
_02099448:
	bl DWCi_GetMatchCnt
	mov r8, r0
	bl DWCi_GetMatchCnt
	add r0, r0, r6
	ldrb r0, [r0, #0x2d0]
	ldr r1, [r8, #0x2f0]
	mov r0, r4, lsl r0
	ands r0, r1, r0
	beq _02099490
	bl DWCi_GetMatchCnt
	add r0, r0, r6
	ldrb r0, [r0, #0x2d0]
	add r6, r6, #1
	strb r0, [r5], #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xe]
	cmp r6, r0
	ble _02099448
_02099490:
	ldr r0, _020994A8 // =0x02143BBC
	str r0, [r7]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xe]
	add r0, r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020994A8: .word 0x02143BBC
	arm_func_end DWCi_GetValidAIDList

	arm_func_start DWCi_GetAllAIDList
DWCi_GetAllAIDList: // 0x020994AC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DWCi_GetMatchCnt
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	bl DWCi_GetMatchCnt
	add r0, r0, #0x2d0
	str r0, [r4]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end DWCi_GetAllAIDList

	arm_func_start DWCi_SetNumValidConnection
DWCi_SetNumValidConnection: // 0x020994E0
	stmdb sp!, {r4, r5, r6, lr}
	mvn r6, #0
	mov r5, #0
	mov r4, #1
_020994F0:
	bl DWCi_GetMatchCnt
	mov r1, r4, lsl r5
	ldr r0, [r0, #0x2f0]
	add r5, r5, #1
	ands r0, r1, r0
	addne r6, r6, #1
	cmp r5, #0x20
	blt _020994F0
	mvn r0, #0
	cmp r6, r0
	bne _0209952C
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0xe]
	ldmia sp!, {r4, r5, r6, pc}
_0209952C:
	bl DWCi_GetMatchCnt
	strb r6, [r0, #0xe]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCi_SetNumValidConnection

	arm_func_start DWCi_GetNumValidConnection
DWCi_GetNumValidConnection: // 0x02099538
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_GetMatchCnt
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xe]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_GetNumValidConnection

	arm_func_start DWCi_GetNumAllConnection
DWCi_GetNumAllConnection: // 0x02099564
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_GetMatchCnt
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_GetNumAllConnection

	arm_func_start DWCi_DeleteHostByIndex
DWCi_DeleteHostByIndex: // 0x02099590
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r9, r0
	mov r8, r1
	bl DWCi_GetMatchCnt
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl DWCi_GetMatchCnt
	add r0, r0, r9, lsl #2
	ldr r11, [r0, #0xf4]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	add r0, r0, r9
	ldrb r0, [r0, #0x2d0]
	mov r1, #1
	ldr r2, [r4, #0x2f0]
	mvn r0, r1, lsl r0
	and r0, r2, r0
	str r0, [r4, #0x2f0]
	bl DWCi_SetNumValidConnection
	sub r0, r8, #1
	cmp r9, r0
	bge _020996D0
	sub r0, r8, r9
	sub r6, r0, #1
	cmp r6, #0
	mov r7, #0
	ble _020996D0
_0209960C:
	add r4, r9, r7
	add r5, r4, #1
	bl DWCi_GetMatchCnt
	mov r10, r0
	bl DWCi_GetMatchCnt
	add r0, r0, r5, lsl #2
	ldr r1, [r0, #0x24]
	add r0, r10, r4, lsl #2
	str r1, [r0, #0x24]
	bl DWCi_GetMatchCnt
	mov r10, r0
	bl DWCi_GetMatchCnt
	add r0, r0, r5, lsl #1
	ldrh r1, [r0, #0xa4]
	add r0, r10, r4, lsl #1
	strh r1, [r0, #0xa4]
	bl DWCi_GetMatchCnt
	mov r10, r0
	bl DWCi_GetMatchCnt
	add r1, r10, r4, lsl #2
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0xf4]
	str r0, [r1, #0xf4]
	bl DWCi_GetMatchCnt
	mov r10, r0
	bl DWCi_GetMatchCnt
	add r1, r10, r4, lsl #2
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x210]
	str r0, [r1, #0x210]
	bl DWCi_GetMatchCnt
	mov r10, r0
	bl DWCi_GetMatchCnt
	add r1, r10, r4, lsl #1
	add r1, r1, #0x200
	add r0, r0, r5, lsl #1
	add r0, r0, #0x200
	ldrh r0, [r0, #0x90]
	strh r0, [r1, #0x90]
	bl DWCi_GetMatchCnt
	mov r10, r0
	bl DWCi_GetMatchCnt
	add r1, r0, r5
	add r0, r10, r4
	ldrb r1, [r1, #0x2d0]
	add r7, r7, #1
	cmp r7, r6
	strb r1, [r0, #0x2d0]
	blt _0209960C
_020996D0:
	cmp r8, #0
	ble _02099740
	sub r4, r8, #1
	bl DWCi_GetMatchCnt
	add r0, r0, r4, lsl #2
	mov r1, #0
	str r1, [r0, #0x24]
	bl DWCi_GetMatchCnt
	add r0, r0, r4, lsl #1
	mov r1, #0
	strh r1, [r0, #0xa4]
	bl DWCi_GetMatchCnt
	add r0, r0, r4, lsl #2
	mov r1, #0
	str r1, [r0, #0xf4]
	bl DWCi_GetMatchCnt
	add r0, r0, r4, lsl #2
	mov r1, #0
	str r1, [r0, #0x210]
	bl DWCi_GetMatchCnt
	add r0, r0, r4, lsl #1
	add r0, r0, #0x200
	mov r1, #0
	strh r1, [r0, #0x90]
	bl DWCi_GetMatchCnt
	add r0, r0, r4
	mov r1, #0
	strb r1, [r0, #0x2d0]
_02099740:
	mov r0, r11
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end DWCi_DeleteHostByIndex

	arm_func_start DWCi_DeleteHostByProfileID
DWCi_DeleteHostByProfileID: // 0x0209974C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r5, #0
	mov r4, #0
	ble _020997A8
_02099774:
	bl DWCi_GetMatchCnt
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #0xf4]
	cmp r6, r0
	bne _0209979C
	mov r0, r4
	mov r1, r5
	bl DWCi_DeleteHostByIndex
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0209979C:
	add r4, r4, #1
	cmp r4, r5
	blt _02099774
_020997A8:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCi_DeleteHostByProfileID

	arm_func_start DWCi_ProcessMatchSCClosing
DWCi_ProcessMatchSCClosing: // 0x020997B0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a8]
	cmp r0, #2
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl DWCi_CancelPreConnectedServerProcess
	ldmia sp!, {r4, pc}
	arm_func_end DWCi_ProcessMatchSCClosing

	arm_func_start DWCi_ProcessMatchClosing
DWCi_ProcessMatchClosing: // 0x020997D4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl DWC_GetState
	cmp r0, #5
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, pc}
	cmp r5, #0
	beq _02099834
	ldr r1, _02099960 // =0xFFFEC780
	mov r0, r5
	add r1, r4, r1
	bl DWCi_StopMatching
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, pc}
_02099834:
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x2d0]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a9]
	cmp r0, #1
	beq _02099870
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a8]
	cmp r0, #1
	beq _02099870
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a8]
	cmp r0, #2
	bne _0209987C
_02099870:
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, pc}
_0209987C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x19c]
	cmp r0, #0
	beq _020998A4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x19c]
	bl NNCancel
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x19c]
_020998A4:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0
	beq _020998E4
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a8]
	cmp r0, #0
	bne _02099954
	bl DWCi_GetMatchCnt
	mov r1, #3
	strb r1, [r0, #0x1a8]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2CloseAllConnections
	b _02099954
_020998E4:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	bne _02099904
	ldr r1, _02099964 // =0xFFFEC5D2
	mov r0, #6
	bl DWCi_StopMatching
	b _02099954
_02099904:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x208]
	cmp r0, #0
	beq _0209991C
	bl DWCi_ResumeMatching
	b _02099954
_0209991C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #1
	bne _0209994C
	mov r0, #0x12
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0x1f0]
	str r1, [r4, #0x1f4]
	b _02099954
_0209994C:
	mov r0, #1
	bl DWCi_RestartFromCancel
_02099954:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02099960: .word 0xFFFEC780
_02099964: .word 0xFFFEC5D2
	arm_func_end DWCi_ProcessMatchClosing

	arm_func_start DWCi_ProcessMatchSynPacket
DWCi_ProcessMatchSynPacket: // 0x02099968
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r2
	cmp r1, #2
	beq _02099990
	cmp r1, #3
	beq _02099A3C
	cmp r1, #4
	beq _02099B04
	ldmia sp!, {r4, r5, r6, pc}
_02099990:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #1
	bne _02099A2C
	ldrb r0, [r4]
	cmp r0, #1
	bne _020999B8
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x20c]
_020999B8:
	ldrb r6, [r4, #1]
	bl DWCi_GetMatchCnt
	ldrb r1, [r4, #2]
	add r0, r0, r6
	strb r1, [r0, #0x2d0]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x200]
	add r0, r4, r6, lsl #2
	str r1, [r0, #0xf4]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	beq _02099A04
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #1
	bne _02099A18
_02099A04:
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	strb r0, [r4, #0x16]
_02099A18:
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1ad]
	mov r0, #9
	bl DWCi_SetMatchStatus
_02099A2C:
	mov r0, r5
	mov r1, #3
	bl DWCi_SendMatchSynPacket
	ldmia sp!, {r4, r5, r6, pc}
_02099A3C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0x10
	bne _02099AF4
	bl DWCi_GetMatchCnt
	ldr r2, [r0, #0x1d4]
	mov r1, #1
	orr r1, r2, r1, lsl r5
	str r1, [r0, #0x1d4]
	ldrb r1, [r4]
	ldrb r0, [r4, #1]
	orr r4, r1, r0, lsl #8
	bl DWCi_GetMatchCnt
	add r0, r0, #0x100
	ldrh r0, [r0, #0xb0]
	cmp r4, r0
	ble _02099A8C
	bl DWCi_GetMatchCnt
	add r0, r0, #0x100
	strh r4, [r0, #0xb0]
_02099A8C:
	mov r0, #0
	bl DWCi_GetAIDBitmask
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1d4]
	cmp r4, r0
	ldmneia sp!, {r4, r5, r6, pc}
	mov r5, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #1
	blt _02099AE8
	mov r4, #4
_02099AC0:
	bl DWCi_GetMatchCnt
	add r0, r0, r5
	ldrb r0, [r0, #0x2d0]
	mov r1, r4
	bl DWCi_SendMatchSynPacket
	add r5, r5, #1
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r5, r0
	ble _02099AC0
_02099AE8:
	mov r0, #0x11
	bl DWCi_SetMatchStatus
	ldmia sp!, {r4, r5, r6, pc}
_02099AF4:
	mov r0, r5
	mov r1, #4
	bl DWCi_SendMatchSynPacket
	ldmia sp!, {r4, r5, r6, pc}
_02099B04:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #9
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, #4
	bl DWCi_PostProcessConnection
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCi_ProcessMatchSynPacket

	arm_func_start DWCi_ClearQR2Key
DWCi_ClearQR2Key: // 0x02099B20
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x14]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x16]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	bl qr2_send_statechanged
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_ClearQR2Key

	arm_func_start DWCi_StopMatching
DWCi_StopMatching: // 0x02099B68
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r4, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	bl DWCi_CloseAllConnectionsByTimeout
	mov r0, r4
	mov r1, r5
	bl DWCi_SetError
	ldr r1, _02099C28 // =0x0211C2B0
	mov r0, #1
	mov r2, #0
	bl DWCi_SetGPStatus
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	moveq r7, #1
	movne r7, #0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20c]
	cmp r0, #0
	moveq r8, #1
	movne r8, #0
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x20c]
	bl DWCi_GetFriendListIndex
	mov r5, r0
	bl DWCi_GetMatchCnt
	str r5, [sp]
	ldr r1, [r0, #0x468]
	mov r0, r4
	str r1, [sp, #4]
	ldr r4, [r6, #0x464]
	mov r2, r8
	mov r3, r7
	mov r1, #0
	blx r4
	bl DWCi_CloseMatching
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02099C28: .word 0x0211C2B0
	arm_func_end DWCi_StopMatching

	arm_func_start DWCi_StopResendingMatchCommand
DWCi_StopResendingMatchCommand: // 0x02099C2C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_GetMatchCnt
	mov r1, #0xff
	strb r1, [r0, #0x3cc]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x3cd]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWCi_StopResendingMatchCommand

	arm_func_start DWCi_MatchGPRecvBuddyMsgCallback
DWCi_MatchGPRecvBuddyMsgCallback: // 0x02099C54
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x21c
	mov r11, r2
	mov r10, #0
	str r1, [sp, #8]
	add r9, sp, #0xc
	add r5, sp, #0x1c
	mov r7, r10
	add r8, r11, #1
	mov r6, #0xa
	mvn r4, #0
_02099C80:
	mov r0, r9
	mov r1, r8
	mov r2, r10
	bl DWCi_GetGPBuddyAdditionalMsg
	cmp r0, r4
	beq _02099CB8
	mov r0, r9
	mov r1, r7
	mov r2, r6
	bl strtoul
	str r0, [r5, r10, lsl #2]
	add r10, r10, #1
	cmp r10, #0x80
	blt _02099C80
_02099CB8:
	add r0, sp, #0x1c
	str r0, [sp]
	str r10, [sp, #4]
	ldrb r0, [r11]
	mov r2, #0
	ldr r1, [sp, #8]
	mov r3, r2
	bl DWCi_ProcessRecvMatchCommand
	add sp, sp, #0x21c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end DWCi_MatchGPRecvBuddyMsgCallback

	arm_func_start DWCi_GT2ConnectedCallback
DWCi_GT2ConnectedCallback: // 0x02099CE0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x1c
	mov r6, r0
	mov r4, r1
	bl DWCi_GetMatchCnt
	cmp r0, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #7
	beq _02099D24
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xc
	addne sp, sp, #0x1c
	ldmneia sp!, {r4, r5, r6, r7, pc}
_02099D24:
	cmp r4, #0
	beq _02099EA0
	cmp r4, #5
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r4, #6
	bne _02099E74
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0xc]
	add r1, r1, #1
	strb r1, [r0, #0xc]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xc]
	cmp r0, #5
	bls _02099D90
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0xc]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelPreConnectedServerProcess
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
_02099D90:
	bl DWCi_GetMatchCnt
	ldr r3, [r0, #0x200]
	ldr r2, _02099F58 // =0x0211C254
	add r0, sp, #0x10
	mov r1, #0xc
	bl OS_SNPrintf
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldrb r2, [r6, #0x14]
	ldrb r1, [r0, #0x14]
	add r0, r7, r2, lsl #2
	add r1, r5, r1, lsl #1
	add r1, r1, #0x200
	ldrh r1, [r1, #0x90]
	ldr r0, [r0, #0x210]
	mov r2, #0
	bl gt2AddressToString
	mov r5, r0
	bl DWCi_GetMatchCnt
	mvn r1, #0
	str r1, [sp]
	ldr r3, _02099F5C // =0x00001388
	mov r1, #0
	str r3, [sp, #4]
	ldr r0, [r0, #8]
	mov r2, r5
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, [r4, #4]
	add r3, sp, #0x10
	ldr r0, [r0]
	bl sub_20B2220
	cmp r0, #1
	bne _02099E40
	bl DWCi_HandleGT2Error_1
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
_02099E40:
	cmp r0, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x14]
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelPreConnectedServerProcess
	add sp, sp, #0x1c
	cmp r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_02099E74:
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r0, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelPreConnectedServerProcess
	add sp, sp, #0x1c
	cmp r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_02099EA0:
	bl DWCi_GT2GetConnectionListIdx
	mov r5, r0
	mvn r1, #0
	cmp r5, r1
	bne _02099EC8
	ldr r1, _02099F60 // =0xFFFEABC4
	mov r0, #6
	bl DWCi_StopMatching
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
_02099EC8:
	bl DWCi_GetGT2ConnectionByIdx
	mov r4, r0
	mov r0, r5
	bl DWCi_GetConnectionInfoByIdx
	str r6, [r4]
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r2, [r0, #0xd]
	mov r1, #0
	add r2, r2, #1
	strb r2, [r0, #0xd]
	strb r5, [r4]
	strh r1, [r4, #2]
	str r1, [r4, #4]
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldrb r2, [r0, #0xd]
	mov r0, r6
	mov r1, r4
	add r2, r5, r2
	ldrb r2, [r2, #0x2d0]
	strb r2, [r4, #1]
	bl sub_20B20B4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xc
	bne _02099F48
	mov r0, #0
	bl DWCi_PostProcessConnection
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
_02099F48:
	mov r0, #1
	bl DWCi_PostProcessConnection
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02099F58: .word 0x0211C254
_02099F5C: .word 0x00001388
_02099F60: .word 0xFFFEABC4
	arm_func_end DWCi_GT2ConnectedCallback

	arm_func_start DWCi_GT2ConnectAttemptCallback
DWCi_GT2ConnectAttemptCallback: // 0x02099F64
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r1
	mov r7, r2
	mov r6, r3
	bl DWCi_GetMatchCnt
	cmp r0, #0
	beq _02099FA4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #7
	bne _02099FA4
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a9]
	cmp r0, #0
	beq _02099FBC
_02099FA4:
	ldr r1, _0209A1AC // =aInitState
	mov r0, r8
	mvn r2, #0
	bl sub_20B23A4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_02099FBC:
	bl DWCi_GT2GetConnectionListIdx
	mov r5, r0
	mvn r2, #0
	cmp r5, r2
	bne _02099FF0
	ldr r1, _0209A1B0 // =aServerFull
	mov r0, r8
	bl sub_20B23A4
	ldr r1, _0209A1B4 // =0xFFFEABC4
	mov r0, #6
	bl DWCi_StopMatching
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_02099FF0:
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x210]
	cmp r7, r0
	bne _0209A034
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r4, r0, lsl #1
	add r0, r0, #0x200
	ldrh r0, [r0, #0x90]
	cmp r6, r0
	beq _0209A0C4
_0209A034:
	ldr r0, [sp, #0x24]
	ldrb r1, [r0]
	cmp r1, #0
	beq _0209A0AC
	mov r1, #0
	mov r2, #0xa
	bl strtoul
	mov r4, r0
	bl DWCi_GetMatchCnt
	mov r9, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r9, r0, lsl #2
	ldr r0, [r0, #0xf4]
	cmp r4, r0
	bne _0209A0AC
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r4, r0, lsl #2
	str r7, [r0, #0x210]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r4, r0, lsl #1
	add r0, r0, #0x200
	strh r6, [r0, #0x90]
	b _0209A0C4
_0209A0AC:
	ldr r1, _0209A1B8 // =aUnknownConnect_0
	mov r0, r8
	mvn r2, #0
	bl sub_20B23A4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_0209A0C4:
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x18c]
	str r1, [r0, #0x190]
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #8]
	mov r0, r8
	bl sub_20B23B0
	cmp r0, #0
	bne _0209A100
	ldr r1, _0209A1BC // =0xFFFEC5E6
	mov r0, #6
	bl DWCi_StopMatching
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_0209A100:
	bl DWCi_StopResendingMatchCommand
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	cmp r0, #0
	bne _0209A134
	ldr r1, [sp, #0x20]
	ldr r0, _0209A1C0 // =0x0000FFFF
	mov r4, r1, asr #1
	cmp r4, r0
	movge r4, r0
	bl DWCi_GetMatchCnt
	add r0, r0, #0x100
	strh r4, [r0, #0xb0]
_0209A134:
	mov r0, r5
	bl DWCi_GetGT2ConnectionByIdx
	mov r4, r0
	mov r0, r5
	bl DWCi_GetConnectionInfoByIdx
	str r8, [r4]
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0xd]
	add r1, r1, #1
	strb r1, [r0, #0xd]
	strb r5, [r4]
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0xd]
	mov r0, r8
	mov r2, #0
	sub r1, r1, #1
	add r1, r5, r1
	ldrb r3, [r1, #0x2d0]
	mov r1, r4
	strb r3, [r4, #1]
	strh r2, [r4, #2]
	str r2, [r4, #4]
	bl sub_20B20B4
	mov r0, #2
	bl DWCi_PostProcessConnection
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0209A1AC: .word aInitState
_0209A1B0: .word aServerFull
_0209A1B4: .word 0xFFFEABC4
_0209A1B8: .word aUnknownConnect_0
_0209A1BC: .word 0xFFFEC5E6
_0209A1C0: .word 0x0000FFFF
	arm_func_end DWCi_GT2ConnectAttemptCallback

	arm_func_start DWCi_GT2UnrecognizedMessageCallback
DWCi_GT2UnrecognizedMessageCallback: // 0x0209A1C4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r0, [sp, #0x18]
	mov r5, r1
	mov r6, r2
	mov r4, r3
	cmp r0, #0
	beq _0209A1EC
	cmp r4, #0
	bne _0209A1F8
_0209A1EC:
	add sp, sp, #8
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0209A1F8:
	add r1, sp, #0
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear32
	mov r1, r6, asr #8
	mov r0, r6, lsl #8
	mov r2, #2
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	strb r2, [sp, #1]
	strh r0, [sp, #2]
	str r5, [sp, #4]
	ldrb r5, [r4]
	cmp r5, #0xfe
	bne _0209A244
	ldrb r0, [r4, #1]
	cmp r0, #0xfd
	beq _0209A24C
_0209A244:
	cmp r5, #0x5c
	bne _0209A278
_0209A24C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0209A2B8
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	ldr r2, [sp, #0x18]
	add r3, sp, #0
	mov r1, r4
	bl sub_20B5E9C
	b _0209A2B8
_0209A278:
	ldr r1, _0209A2C4 // =0x0211E8B4
	mov r0, r4
	mov r2, #6
	bl memcmp
	cmp r0, #0
	bne _0209A2A4
	ldr r1, [sp, #0x18]
	add r2, sp, #0
	mov r0, r4
	bl sub_20B4C6C
	b _0209A2B8
_0209A2A4:
	cmp r5, #0xfe
	moveq r0, #0
	add sp, sp, #8
	movne r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0209A2B8:
	mov r0, #1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209A2C4: .word 0x0211E8B4
	arm_func_end DWCi_GT2UnrecognizedMessageCallback

	arm_func_start DWCi_MatchProcess
DWCi_MatchProcess: // 0x0209A2C8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r4, r0
	bl DWCi_GetMatchCnt
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	cmp r4, #0
	bne _0209A344
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0209A318
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	bl qr2_think
_0209A318:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2Think
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209A344:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xd
	addls pc, pc, r0, lsl #2
	b _0209AA64
_0209A36C: // jump table
	b _0209AA64 // case 0
	b _0209A96C // case 1
	b _0209A518 // case 2
	b _0209A518 // case 3
	b _0209A3A4 // case 4
	b _0209A518 // case 5
	b _0209AA64 // case 6
	b _0209A5D0 // case 7
	b _0209AA64 // case 8
	b _0209AA64 // case 9
	b _0209AA64 // case 10
	b _0209A758 // case 11
	b _0209AA64 // case 12
	b _0209A84C // case 13
_0209A3A4:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1c8]
	cmp r0, #0
	beq _0209A490
	bl OS_GetTick
	mov r6, r0
	mov r7, r1
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	mov r4, r0
	ldr r1, [r5, #0x1cc]
	ldr r0, [r5, #0x1d0]
	subs r2, r6, r1
	sbc r0, r7, r0
	mov r1, r0, lsl #6
	orr r1, r1, r2, lsr #26
	mov r0, r2, lsl #6
	ldr r2, _0209ACB8 // =0x000082EA
	mov r3, #0
	bl _ll_udiv
	cmp r1, #0
	ldr r1, [r4, #0x1c8]
	cmpeq r0, r1
	bls _0209A490
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1c8]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #3
	bne _0209A47C
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x1aa]
	add r1, r1, #1
	strb r1, [r0, #0x1aa]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1aa]
	cmp r0, #5
	bls _0209A458
	ldr r1, _0209ACBC // =0xFFFEC5D2
	mov r0, #6
	bl DWCi_StopMatching
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209A458:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	mov r1, #0
	bl DWCi_SendResvCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	beq _0209A490
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209A47C:
	mov r0, #0
	bl DWCi_RetryReserving
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_0209A490:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1bc]
	cmp r0, #0
	beq _0209AA64
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0xd]
	ldr r0, _0209ACC0 // =0x00000BB8
	mla r5, r1, r0, r0
	bl OS_GetTick
	mov r4, r0
	mov r6, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x1c0]
	ldr r0, [r0, #0x1c4]
	subs r2, r4, r1
	sbc r0, r6, r0
	mov r1, r0, lsl #6
	orr r1, r1, r2, lsr #26
	mov r0, r2, lsl #6
	ldr r2, _0209ACB8 // =0x000082EA
	mov r3, #0
	bl _ll_udiv
	cmp r1, #0
	cmpeq r0, r5
	blo _0209AA64
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	mov r1, #0
	bl DWCi_SendResvCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	beq _0209AA64
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209A518:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe8]
	cmp r0, #0
	ble _0209AA64
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #3
	bne _0209A54C
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0xd]
	ldr r0, _0209ACC0 // =0x00000BB8
	mla r5, r1, r0, r0
	b _0209A560
_0209A54C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe8]
	cmp r0, #1
	moveq r5, #0x3e8
	ldrne r5, _0209ACC0 // =0x00000BB8
_0209A560:
	bl OS_GetTick
	mov r4, r0
	mov r6, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0xec]
	ldr r0, [r0, #0xf0]
	subs r3, r4, r1
	sbc r0, r6, r0
	mov r1, r0, lsl #6
	ldr r2, _0209ACB8 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	cmp r1, #0
	cmpeq r0, r5
	bls _0209AA64
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x204]
	bl DWCi_SBUpdateAsync
	bl DWCi_HandleSBError
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0xe8]
	b _0209AA64
_0209A5D0:
	bl DWCi_GetMatchCnt
	ldr r2, [r0, #0x18c]
	ldr r1, [r0, #0x190]
	mov r0, #0
	cmp r1, r0
	cmpeq r2, r0
	beq _0209A660
	bl OS_GetTick
	mov r4, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x18c]
	ldr r0, [r0, #0x190]
	subs r3, r4, r1
	sbc r0, r5, r0
	mov r1, r0, lsl #6
	ldr r2, _0209ACB8 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	ldr r2, _0209ACC4 // =0x000061A8
	cmp r1, #0
	cmpeq r0, r2
	bls _0209AA64
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x18c]
	str r1, [r0, #0x190]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelPreConnectedClientProcess
	cmp r0, #0
	bne _0209AA64
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209A660:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x3cc]
	cmp r0, #6
	bne _0209AA64
	bl OS_GetTick
	mov r4, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x45c]
	ldr r0, [r0, #0x460]
	subs r3, r4, r1
	sbc r0, r5, r0
	mov r1, r0, lsl #6
	ldr r2, _0209ACB8 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	ldr r2, _0209ACC8 // =0x00001770
	cmp r1, #0
	cmpeq r0, r2
	bls _0209AA64
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x3cd]
	add r1, r1, #1
	strb r1, [r0, #0x3cd]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x3cd]
	cmp r0, #5
	bls _0209A6F8
	bl DWCi_StopResendingMatchCommand
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelPreConnectedClientProcess
	cmp r0, #0
	bne _0209AA64
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209A6F8:
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	add r1, r4, #0x3d4
	str r1, [sp]
	add r3, r5, #0x300
	ldr r1, [r0, #0x458]
	mov r0, #6
	str r1, [sp, #4]
	ldr r1, [r7, #0x454]
	ldr r2, [r6, #0x3d0]
	ldrh r3, [r3, #0xce]
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	beq _0209AA64
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209A758:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x3cc]
	cmp r0, #2
	bne _0209AA64
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	bne _0209A7C0
	bl OS_GetTick
	mov r4, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x45c]
	ldr r0, [r0, #0x460]
	subs r3, r4, r1
	sbc r0, r5, r0
	mov r1, r0, lsl #6
	ldr r2, _0209ACB8 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	ldr r2, _0209ACC8 // =0x00001770
	cmp r1, #0
	cmpeq r0, r2
	bhi _0209A818
_0209A7C0:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	beq _0209AA64
	bl OS_GetTick
	mov r4, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x45c]
	ldr r0, [r0, #0x460]
	subs r3, r4, r1
	sbc r0, r5, r0
	mov r1, r0, lsl #6
	ldr r2, _0209ACB8 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	ldr r2, _0209ACCC // =0x00004A38
	cmp r1, #0
	cmpeq r0, r2
	bls _0209AA64
_0209A818:
	bl DWCi_StopResendingMatchCommand
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r0, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelPreConnectedServerProcess
	cmp r0, #0
	bne _0209AA64
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209A84C:
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x3cc]
	cmp r0, #8
	bne _0209AA64
	bl OS_GetTick
	mov r4, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x45c]
	ldr r0, [r0, #0x460]
	subs r3, r4, r1
	sbc r0, r5, r0
	mov r1, r0, lsl #6
	ldr r2, _0209ACB8 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	ldr r2, _0209ACD0 // =0x00007530
	cmp r1, #0
	cmpeq r0, r2
	bls _0209AA64
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x3cd]
	add r1, r1, #1
	strb r1, [r0, #0x3cd]
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x3cd]
	cmp r0, #0
	beq _0209A90C
	bl DWCi_StopResendingMatchCommand
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #2
	bne _0209A904
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelPreConnectedServerProcess
	cmp r0, #0
	bne _0209AA64
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209A904:
	bl DWCi_RestartFromTimeout
	b _0209AA64
_0209A90C:
	bl DWCi_GetMatchCnt
	mov r7, r0
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	add r1, r4, #0x3d4
	str r1, [sp]
	add r3, r5, #0x300
	ldr r1, [r0, #0x458]
	mov r0, #8
	str r1, [sp, #4]
	ldr r1, [r7, #0x454]
	ldr r2, [r6, #0x3d0]
	ldrh r3, [r3, #0xce]
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	beq _0209AA64
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209A96C:
	bl DWC_GetState
	cmp r0, #5
	bne _0209AA64
	bl OS_GetTick
	mov r4, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x1f8]
	ldr r0, [r0, #0x1fc]
	subs r3, r4, r1
	sbc r0, r5, r0
	mov r1, r0, lsl #6
	ldr r2, _0209ACB8 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	ldr r2, _0209ACD0 // =0x00007530
	cmp r1, #0
	cmpeq r0, r2
	bls _0209AA64
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1ad]
	cmp r0, #5
	blo _0209A9EC
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xf4]
	bl DWCi_CancelPreConnectedClientProcess
	cmp r0, #0
	bne _0209AA64
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209A9EC:
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldrh r3, [r0, #0xa4]
	ldr r1, [r5, #0xf4]
	ldr r2, [r4, #0x24]
	mov r0, #0x40
	bl DWCi_SendMatchCommand
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_GetMatchCnt
	ldrb r1, [r0, #0x1ad]
	add r1, r1, #1
	strb r1, [r0, #0x1ad]
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl OS_GetTick
	ldr r2, _0209ACD4 // =0xFF403B3A
	mvn r3, #0
	adds r0, r0, r2
	str r0, [r4, #0x1f8]
	adc r0, r1, r3
	str r0, [r4, #0x1fc]
_0209AA64:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xb
	beq _0209AA84
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #6
	bne _0209AB00
_0209AA84:
	bl DWCi_GetMatchCnt
	ldr r2, [r0, #0x184]
	ldr r1, [r0, #0x188]
	mov r0, #0
	cmp r1, r0
	cmpeq r2, r0
	beq _0209AB00
	bl OS_GetTick
	mov r4, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x184]
	ldr r0, [r0, #0x188]
	subs r3, r4, r1
	sbc r0, r5, r0
	mov r1, r0, lsl #6
	ldr r2, _0209ACB8 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	ldr r2, _0209ACD8 // =0x00002710
	cmp r1, #0
	cmpeq r0, r2
	bls _0209AB00
	bl DWCi_GetMatchCnt
	mov r1, #0
	add r3, r0, #0x194
	mov r2, r1
	mov r0, #1
	bl DWCi_NNCompletedCallback
_0209AB00:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	cmp r0, #0
	beq _0209AB7C
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl ServerBrowserThink
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	bl sub_20B88F8
	cmp r0, #0
	beq _0209AB7C
	bl DWCi_GetMatchCnt
	ldr r2, [r0, #0x174]
	ldr r1, [r0, #0x178]
	mov r0, #0
	cmp r1, r0
	cmpeq r2, r0
	beq _0209AB7C
	bl OS_GetTick
	mov r4, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x178]
	ldr r0, [r0, #0x174]
	cmp r5, r1
	cmpeq r4, r0
	bls _0209AB7C
	ldr r1, _0209ACDC // =0xFFFEB3EE
	mov r0, #6
	bl DWCi_StopMatching
_0209AB7C:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	bl DWCi_SendStateChanged
	bl NNThink
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _0209ABAC
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2Think
_0209ABAC:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0x12
	bne _0209AC14
	bl OS_GetTick
	mov r4, r0
	mov r5, r1
	bl DWCi_GetMatchCnt
	ldr r1, [r0, #0x1f0]
	ldr r0, [r0, #0x1f4]
	subs r3, r4, r1
	sbc r0, r5, r0
	mov r1, r0, lsl #6
	ldr r2, _0209ACB8 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	ldr r2, _0209ACC0 // =0x00000BB8
	cmp r1, #0
	cmpeq r0, r2
	bls _0209AC14
	bl DWCi_ResumeMatching
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
_0209AC14:
	bl DWCi_ProcessMatchSynTimeout
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_ProcessCancelMatchSynTimeout
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_ProcessOptMinComp
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1ae]
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xa
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0xd]
	strb r0, [r4, #0x16]
	bl DWCi_GPSetServerStatus
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1ae]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x47c]
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x480]
	ldr r1, [r4, #0x47c]
	blx r1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209ACB8: .word 0x000082EA
_0209ACBC: .word 0xFFFEC5D2
_0209ACC0: .word 0x00000BB8
_0209ACC4: .word 0x000061A8
_0209ACC8: .word 0x00001770
_0209ACCC: .word 0x00004A38
_0209ACD0: .word 0x00007530
_0209ACD4: .word 0xFF403B3A
_0209ACD8: .word 0x00002710
_0209ACDC: .word 0xFFFEB3EE
	arm_func_end DWCi_MatchProcess

	arm_func_start DWCi_SendStateChanged
DWCi_SendStateChanged: // 0x0209ACE0
	stmdb sp!, {r4, lr}
	movs r4, r0
	ldmeqia sp!, {r4, pc}
	bl qr2_think
	ldr r0, [r4, #0xb4]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x15]
	cmp r0, #0
	beq _0209AD20
	cmp r0, #1
	beq _0209AD20
	cmp r0, #2
	beq _0209AD74
	ldmia sp!, {r4, pc}
_0209AD20:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xb
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r4, pc}
_0209AD34: // jump table
	ldmia sp!, {r4, pc} // case 0
	b _0209AD64 // case 1
	b _0209AD64 // case 2
	b _0209AD64 // case 3
	b _0209AD64 // case 4
	ldmia sp!, {r4, pc} // case 5
	b _0209AD64 // case 6
	ldmia sp!, {r4, pc} // case 7
	ldmia sp!, {r4, pc} // case 8
	ldmia sp!, {r4, pc} // case 9
	ldmia sp!, {r4, pc} // case 10
	b _0209AD64 // case 11
_0209AD64:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	bl qr2_send_statechanged
	ldmia sp!, {r4, pc}
_0209AD74:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0xb
	ldmneia sp!, {r4, pc}
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	bl qr2_send_statechanged
	ldmia sp!, {r4, pc}
	arm_func_end DWCi_SendStateChanged

	arm_func_start DWCi_ConnectToFriendsAsync
DWCi_ConnectToFriendsAsync: // 0x0209AD94
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x40
	mov r8, r2
	mov r7, r3
	mov r5, r0
	mov r4, r1
	ldr r2, [sp, #0x58]
	ldr r3, [sp, #0x5c]
	mov r1, r8
	mov r0, #1
	bl DWCi_SetMatchCommonParam
	cmp r7, #0
	movne r6, #1
	moveq r6, #0
	bl DWCi_GetMatchCnt
	strb r6, [r0, #0x1a6]
	bl DWCi_GetMatchCnt
	ldr r1, [sp, #0x60]
	str r1, [r0, #0x474]
	bl DWCi_GetMatchCnt
	ldr r1, [sp, #0x64]
	str r1, [r0, #0x478]
	bl DWCi_GetMatchCnt
	mov r1, r0
	mov r0, r5
	add r1, r1, #0x304
	mov r2, r4
	bl MI_CpuCopy8
	bl DWCi_GetMatchCnt
	str r4, [r0, #0x344]
	cmp r4, #0
	beq _0209AE50
	cmp r4, r8
	bge _0209AE64
	cmp r7, #0
	bne _0209AE64
	ldr r0, _0209AFDC // =0x02143BAC
	ldr r1, [r0]
	cmp r1, #0
	beq _0209AE50
	ldrb r0, [r1]
	cmp r0, #0
	beq _0209AE50
	ldrb r0, [r1, #1]
	sub r0, r0, #1
	cmp r4, r0
	bge _0209AE64
_0209AE50:
	mov r0, #0xa
	mov r1, #0
	bl DWCi_StopMatching
	add sp, sp, #0x40
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0209AE64:
	mov r0, #4
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	cmp r0, #0
	bne _0209AED4
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	mov r2, r0
	mov r0, #0x14
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	mov r3, #0
	str r3, [sp, #8]
	ldr r0, _0209AFE0 // =DWCi_SBCallback
	str r0, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r0, [r5, #0x2f4]
	ldr r1, [r4, #0x2f4]
	ldr r2, [r2, #0x2f8]
	bl sub_20B8BD4
	str r0, [r6, #0xe4]
_0209AED4:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	cmp r0, #0
	bne _0209AEF8
	mov r0, #5
	bl DWCi_HandleSBError
	cmp r0, #0
	addne sp, sp, #0x40
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
_0209AEF8:
	ldr r2, _0209AFE4 // =0x0211C254
	add r0, sp, #0x14
	mov r3, r8
	mov r1, #0xc
	bl OS_SNPrintf
	ldr r0, _0209AFE8 // =0x0211C2B8
	add r1, sp, #0x14
	add r2, sp, #0x20
	mov r3, #0x2f
	bl DWC_SetCommonKeyValueString
	cmp r7, #0
	ldrne r1, _0209AFEC // =_0211C37C
	ldr r0, _0209AFF0 // =0x0211C2BC
	ldreq r1, _0209AFF4 // =0x0211C380
	add r2, sp, #0x20
	mov r3, #0x2f
	bl DWC_AddCommonKeyValueString
	ldr r2, _0209AFE4 // =0x0211C254
	add r0, sp, #0x14
	mov r1, #0xc
	mov r3, #3
	bl OS_SNPrintf
	ldr r0, _0209AFF8 // =0x0211C2B4
	add r1, sp, #0x14
	add r2, sp, #0x20
	mov r3, #0x2f
	bl DWC_AddCommonKeyValueString
	add r1, sp, #0x20
	mov r0, #4
	mov r2, #0
	bl DWCi_SetGPStatus
	bl DWCi_HandleGPError_1
	cmp r0, #0
	addne sp, sp, #0x40
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	cmp r0, #0
	bne _0209AFAC
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x200]
	bl DWCi_QR2Startup
	cmp r0, #0
	addne sp, sp, #0x40
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
_0209AFAC:
	mov r0, #0
	mov r2, r0
	mov r1, #1
	bl DWCi_SendResvCommandToFriend
	bl DWCi_HandleMatchCommandError
	cmp r0, #0
	addne sp, sp, #0x40
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0
	bl DWCi_InitOptMinCompParam
	add sp, sp, #0x40
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0209AFDC: .word 0x02143BAC
_0209AFE0: .word DWCi_SBCallback
_0209AFE4: .word 0x0211C254
_0209AFE8: .word 0x0211C2B8
_0209AFEC: .word _0211C37C
_0209AFF0: .word 0x0211C2BC
_0209AFF4: .word 0x0211C380
_0209AFF8: .word 0x0211C2B4
	arm_func_end DWCi_ConnectToFriendsAsync

	arm_func_start DWCi_ConnectToAnybodyAsync
DWCi_ConnectToAnybodyAsync: // 0x0209AFFC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x118
	ldr r4, _0209B1D4 // =0x02143BB8
	mov r7, r1
	ldr r1, [r4]
	mov r8, r0
	mov r6, r2
	mov r5, r3
	cmp r1, #0
	beq _0209B03C
	mov r0, #4
	mov r2, #0
	bl DWC_Free
	mov r0, r4
	mov r1, #0
	str r1, [r0]
_0209B03C:
	cmp r7, #0
	beq _0209B0BC
	add r0, sp, #0x14
	mvn r1, #0
	mov r2, #0x20
	mov r3, #3
	bl DWCi_GetDefaultMatchFilter
	mov r4, r0
	ldr r0, _0209B1D8 // =aAnd
	bl strlen
	rsb r1, r4, #0x100
	sub r4, r1, r0
	mov r1, r4
	mov r0, #4
	bl DWC_Alloc
	movs r1, r0
	ldr r0, _0209B1D4 // =0x02143BB8
	str r1, [r0]
	bne _0209B09C
	ldr r1, _0209B1DC // =0xFFFEC77F
	mov r0, #9
	bl DWCi_StopMatching
	add sp, sp, #0x118
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0209B09C:
	mov r0, r7
	mov r2, r4
	bl MI_CpuCopy8
	ldr r0, _0209B1D4 // =0x02143BB8
	mov r1, #0
	ldr r0, [r0]
	add r0, r0, r4
	strb r1, [r0, #-1]
_0209B0BC:
	mov r1, r8
	mov r2, r6
	mov r3, r5
	mov r0, #0
	bl DWCi_SetMatchCommonParam
	bl DWCi_GetMatchCnt
	ldr r1, [sp, #0x130]
	str r1, [r0, #0x474]
	bl DWCi_GetMatchCnt
	ldr r1, [sp, #0x134]
	str r1, [r0, #0x478]
	mov r0, #2
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	cmp r0, #0
	bne _0209B158
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	mov r5, r0
	bl DWCi_GetMatchCnt
	mov r4, r0
	bl DWCi_GetMatchCnt
	mov r2, r0
	mov r0, #0x14
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	mov r3, #0
	str r3, [sp, #8]
	ldr r0, _0209B1E0 // =DWCi_SBCallback
	str r0, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r0, [r5, #0x2f4]
	ldr r1, [r4, #0x2f4]
	ldr r2, [r2, #0x2f8]
	bl sub_20B8BD4
	str r0, [r6, #0xe4]
_0209B158:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	cmp r0, #0
	bne _0209B17C
	mov r0, #5
	bl DWCi_HandleSBError
	cmp r0, #0
	addne sp, sp, #0x118
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
_0209B17C:
	ldr r1, _0209B1E4 // =0x0211C2B0
	mov r0, #3
	mov r2, #0
	bl DWCi_SetGPStatus
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x200]
	bl DWCi_SBUpdateAsync
	bl DWCi_HandleSBError
	cmp r0, #0
	addne sp, sp, #0x118
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	cmp r0, #0
	bne _0209B1C4
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x200]
	bl DWCi_QR2Startup
_0209B1C4:
	mov r0, #0
	bl DWCi_InitOptMinCompParam
	add sp, sp, #0x118
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0209B1D4: .word 0x02143BB8
_0209B1D8: .word aAnd
_0209B1DC: .word 0xFFFEC77F
_0209B1E0: .word DWCi_SBCallback
_0209B1E4: .word 0x0211C2B0
	arm_func_end DWCi_ConnectToAnybodyAsync

	arm_func_start DWCi_QR2Startup
DWCi_QR2Startup: // 0x0209B1E8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	mov r4, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	cmp r0, #0
	addne sp, sp, #0x2c
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl DWCi_GetMatchCnt
	str r4, [r0, #0x200]
	mov r10, #0
	ldr r11, _0209B34C // =DWCi_QR2ServerKeyCallback
	mov r4, r10
	mov r5, #1
_0209B224:
	bl DWCi_GetMatchCnt
	mov r9, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2GetSocketSOCKET
	mov r8, r0
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #4]
	ldr r0, [r0]
	bl gt2GetLocalPort
	mov r7, r0
	bl DWCi_GetMatchCnt
	mov r6, r0
	bl DWCi_GetMatchCnt
	ldr r3, [r0, #0x2f8]
	mov r1, r8
	str r3, [sp]
	str r5, [sp, #4]
	str r5, [sp, #8]
	ldr r3, _0209B350 // =DWCi_QR2PlayerKeyCallback
	str r11, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r3, _0209B354 // =DWCi_QR2TeamKeyCallback
	mov r2, r7
	str r3, [sp, #0x14]
	ldr r3, _0209B358 // =DWCi_QR2KeyListCallback
	add r0, r9, #0x10
	str r3, [sp, #0x18]
	ldr r3, _0209B35C // =DWCi_QR2CountCallback
	str r3, [sp, #0x1c]
	ldr r3, _0209B360 // =DWCi_QR2AddErrorCallback
	str r3, [sp, #0x20]
	str r4, [sp, #0x24]
	ldr r3, [r6, #0x2f4]
	bl sub_20B72A4
	movs r6, r0
	beq _0209B2EC
	cmp r6, #3
	bne _0209B2CC
	cmp r10, #4
	bne _0209B2E0
_0209B2CC:
	mov r0, r6
	bl DWCi_HandleQR2Error
	add sp, sp, #0x2c
	mov r0, r6
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0209B2E0:
	add r10, r10, #1
	cmp r10, #5
	blt _0209B224
_0209B2EC:
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1c]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strh r1, [r0, #0x1a]
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	ldr r1, _0209B364 // =DWCi_QR2PublicAddrCallback
	bl sub_20B725C
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	ldr r1, _0209B368 // =DWCi_QR2NatnegCallback
	bl sub_20B728C
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	ldr r1, _0209B36C // =DWCi_QR2ClientMsgCallback
	bl sub_20B7274
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x10]
	bl qr2_send_statechanged
	mov r0, r6
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0209B34C: .word DWCi_QR2ServerKeyCallback
_0209B350: .word DWCi_QR2PlayerKeyCallback
_0209B354: .word DWCi_QR2TeamKeyCallback
_0209B358: .word DWCi_QR2KeyListCallback
_0209B35C: .word DWCi_QR2CountCallback
_0209B360: .word DWCi_QR2AddErrorCallback
_0209B364: .word DWCi_QR2PublicAddrCallback
_0209B368: .word DWCi_QR2NatnegCallback
_0209B36C: .word DWCi_QR2ClientMsgCallback
	arm_func_end DWCi_QR2Startup

	arm_func_start DWCi_MatchInit
DWCi_MatchInit: // 0x0209B370
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl DWCi_SetMatchCnt
	bl DWCi_GetMatchCnt
	str r6, [r0]
	bl DWCi_GetMatchCnt
	str r5, [r0, #4]
	bl DWCi_GetMatchCnt
	str r4, [r0, #8]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x10]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1c]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strh r1, [r0, #0x1a]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0xe4]
	mov r0, r1
	bl DWCi_SetMatchStatus
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0xf]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x19]
	bl DWCi_GetMatchCnt
	mov r1, #0
	strb r1, [r0, #0x1af]
	bl DWCi_GetMatchCnt
	mov r1, #0
	add r0, r0, #0x100
	strh r1, [r0, #0xb6]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x1dc]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x200]
	bl DWCi_GetMatchCnt
	ldr r1, [sp, #0x10]
	str r1, [r0, #0x2f4]
	bl DWCi_GetMatchCnt
	ldr r1, [sp, #0x14]
	str r1, [r0, #0x2f8]
	bl DWCi_GetMatchCnt
	ldr r1, [sp, #0x18]
	str r1, [r0, #0x2fc]
	bl DWCi_GetMatchCnt
	ldr r1, [sp, #0x1c]
	str r1, [r0, #0x300]
	bl DWCi_GetMatchCnt
	add r0, r0, #0x304
	mov r1, #0
	mov r2, #0x40
	bl MI_CpuFill8
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x344]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x464]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x468]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x474]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x478]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x47c]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x480]
	bl DWCi_GetMatchCnt
	mov r1, #0
	str r1, [r0, #0x174]
	str r1, [r0, #0x178]
	bl DWCi_ClearGameMatchKeys
	ldr r1, _0209B4E8 // =0x02143BB4
	mov r0, #0
	strb r0, [r1]
	strb r0, [r1, #1]
	strh r0, [r1, #2]
	bl DWCi_ResetMatchParam
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209B4E8: .word 0x02143BB4
	arm_func_end DWCi_MatchInit

	arm_func_start DWC_SetMatchingOption
DWC_SetMatchingOption: // 0x0209B4EC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl DWCi_GetMatchCnt
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, pc}
	cmp r4, #0
	addeq sp, sp, #4
	moveq r0, #3
	ldmeqia sp!, {r4, r5, pc}
	cmp r5, #0
	beq _0209B534
	cmp r5, #1
	beq _0209B61C
	b _0209B650
_0209B534:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0x1a0]
	cmp r0, #0x13
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, pc}
	ldrb r0, [r4]
	cmp r0, #0
	beq _0209B56C
	ldrb r0, [r4, #1]
	cmp r0, #1
	addls sp, sp, #4
	movls r0, #3
	ldmlsia sp!, {r4, r5, pc}
_0209B56C:
	ldr r0, _0209B65C // =0x02143BAC
	ldr r0, [r0]
	cmp r0, #0
	bne _0209B5A0
	mov r0, #4
	mov r1, #0x20
	bl DWC_Alloc
	ldr r1, _0209B65C // =0x02143BAC
	cmp r0, #0
	str r0, [r1]
	addeq sp, sp, #4
	moveq r0, #4
	ldmeqia sp!, {r4, r5, pc}
_0209B5A0:
	ldrb r2, [r4]
	ldr r1, _0209B65C // =0x02143BAC
	mov r3, #0
	strb r2, [r0]
	ldrb r2, [r4, #1]
	ldr r0, [r1]
	strb r2, [r0, #1]
	ldr r0, [r1]
	strb r3, [r0, #2]
	ldr r0, [r1]
	strb r3, [r0, #3]
	ldr r2, [r4, #4]
	ldr r0, [r1]
	str r2, [r0, #4]
	ldr r0, [r1]
	str r3, [r0, #8]
	ldr r0, [r1]
	str r3, [r0, #0xc]
	bl OS_GetTick
	ldr r2, _0209B65C // =0x02143BAC
	ldr r2, [r2]
	str r0, [r2, #0x10]
	str r1, [r2, #0x14]
	bl OS_GetTick
	ldr r2, _0209B65C // =0x02143BAC
	add sp, sp, #4
	ldr r2, [r2]
	str r0, [r2, #0x18]
	str r1, [r2, #0x1c]
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_0209B61C:
	ldr r0, [r4]
	add sp, sp, #4
	cmp r0, #0
	ldrne r0, _0209B660 // =0x02143BB4
	movne r1, #1
	strneb r1, [r0]
	ldreq r0, _0209B660 // =0x02143BB4
	moveq r1, #0
	streqb r1, [r0]
	ldr r1, _0209B660 // =0x02143BB4
	mov r0, #0
	strb r0, [r1, #1]
	ldmia sp!, {r4, r5, pc}
_0209B650:
	mov r0, #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0209B65C: .word 0x02143BAC
_0209B660: .word 0x02143BB4
	arm_func_end DWC_SetMatchingOption

	arm_func_start DWC_GetMatchStringValue
DWC_GetMatchStringValue: // 0x0209B664
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl DWCi_GetMatchCnt
	cmp r0, #0
	beq _0209B68C
	bl DWCi_IsError
	cmp r0, #0
	beq _0209B694
_0209B68C:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
_0209B694:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	mov r1, r6
	bl ServerBrowserGetServer
	cmp r0, #0
	beq _0209B6BC
	mov r1, r5
	mov r2, r4
	bl SBServerGetStringValueA
	mov r4, r0
_0209B6BC:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWC_GetMatchStringValue

	arm_func_start DWC_GetMatchIntValue
DWC_GetMatchIntValue: // 0x0209B6C4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl DWCi_GetMatchCnt
	cmp r0, #0
	beq _0209B6EC
	bl DWCi_IsError
	cmp r0, #0
	beq _0209B6F4
_0209B6EC:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
_0209B6F4:
	bl DWCi_GetMatchCnt
	ldr r0, [r0, #0xe4]
	mov r1, r6
	bl ServerBrowserGetServer
	cmp r0, #0
	beq _0209B71C
	mov r1, r5
	mov r2, r4
	bl SBServerGetIntValueA
	mov r4, r0
_0209B71C:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWC_GetMatchIntValue

	arm_func_start DWC_AddMatchKeyString
DWC_AddMatchKeyString: // 0x0209B724
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	movs r6, r1
	mov r7, r0
	mov r5, r2
	beq _0209B740
	cmp r5, #0
	bne _0209B748
_0209B740:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0209B748:
	cmp r7, #0x64
	blo _0209B790
	sub r2, r7, #0x64
	mov r0, #0xc
	mul r3, r2, r0
	ldr r0, _0209B848 // =0x02143BDC
	ldrb r0, [r0, r3]
	cmp r0, #0
	beq _0209B790
	ldr r0, _0209B84C // =0x02143BE0
	ldr r0, [r0, r3]
	cmp r0, #0
	beq _0209B7A0
	bl strcmp
	cmp r0, #0
	beq _0209B7A0
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0209B790:
	bl DWCi_GetNewMatchKey
	movs r7, r0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
_0209B7A0:
	sub r1, r7, #0x64
	mov r0, #0xc
	mul r4, r1, r0
	ldr r1, _0209B848 // =0x02143BDC
	ldr r0, _0209B850 // =0x02143BDD
	strb r7, [r1, r4]
	mov r2, #1
	ldr r1, _0209B854 // =0x02143BDE
	strb r2, [r0, r4]
	mov r2, #0
	ldr r0, _0209B84C // =0x02143BE0
	strh r2, [r1, r4]
	ldr r1, [r0, r4]
	cmp r1, #0
	beq _0209B7E4
	mov r0, #4
	bl DWC_Free
_0209B7E4:
	mov r0, r6
	ldr r8, _0209B84C // =0x02143BE0
	bl strlen
	add r1, r0, #1
	mov r0, #4
	bl DWC_Alloc
	str r0, [r8, r4]
	ldr r0, [r8, r4]
	cmp r0, #0
	bne _0209B820
	ldr r1, _0209B858 // =0xFFFEC77F
	mov r0, #9
	bl DWCi_StopMatching
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0209B820:
	mov r1, r6
	bl strcpy
	ldr r1, _0209B85C // =0x02143BE4
	mov r0, r8
	str r5, [r1, r4]
	ldr r1, [r0, r4]
	mov r0, r7
	bl qr2_register_keyA
	mov r0, r7
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0209B848: .word 0x02143BDC
_0209B84C: .word 0x02143BE0
_0209B850: .word 0x02143BDD
_0209B854: .word 0x02143BDE
_0209B858: .word 0xFFFEC77F
_0209B85C: .word 0x02143BE4
	arm_func_end DWC_AddMatchKeyString

	arm_func_start DWC_AddMatchKeyInt
DWC_AddMatchKeyInt: // 0x0209B860
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	movs r6, r1
	mov r7, r0
	mov r5, r2
	beq _0209B87C
	cmp r5, #0
	bne _0209B884
_0209B87C:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0209B884:
	cmp r7, #0x64
	blo _0209B8CC
	sub r2, r7, #0x64
	mov r0, #0xc
	mul r3, r2, r0
	ldr r0, _0209B980 // =0x02143BDC
	ldrb r0, [r0, r3]
	cmp r0, #0
	beq _0209B8CC
	ldr r0, _0209B984 // =0x02143BE0
	ldr r0, [r0, r3]
	cmp r0, #0
	beq _0209B8DC
	bl strcmp
	cmp r0, #0
	beq _0209B8DC
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0209B8CC:
	bl DWCi_GetNewMatchKey
	movs r7, r0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
_0209B8DC:
	sub r1, r7, #0x64
	mov r0, #0xc
	mul r4, r1, r0
	ldr r1, _0209B980 // =0x02143BDC
	ldr r0, _0209B988 // =0x02143BDD
	strb r7, [r1, r4]
	mov r2, #0
	ldr r1, _0209B98C // =0x02143BDE
	strb r2, [r0, r4]
	ldr r0, _0209B984 // =0x02143BE0
	strh r2, [r1, r4]
	ldr r1, [r0, r4]
	cmp r1, #0
	beq _0209B91C
	mov r0, #4
	bl DWC_Free
_0209B91C:
	mov r0, r6
	ldr r8, _0209B984 // =0x02143BE0
	bl strlen
	add r1, r0, #1
	mov r0, #4
	bl DWC_Alloc
	str r0, [r8, r4]
	ldr r0, [r8, r4]
	cmp r0, #0
	bne _0209B958
	ldr r1, _0209B990 // =0xFFFEC77F
	mov r0, #9
	bl DWCi_StopMatching
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0209B958:
	mov r1, r6
	bl strcpy
	ldr r1, _0209B994 // =0x02143BE4
	mov r0, r8
	str r5, [r1, r4]
	ldr r1, [r0, r4]
	mov r0, r7
	bl qr2_register_keyA
	mov r0, r7
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0209B980: .word 0x02143BDC
_0209B984: .word 0x02143BE0
_0209B988: .word 0x02143BDD
_0209B98C: .word 0x02143BDE
_0209B990: .word 0xFFFEC77F
_0209B994: .word 0x02143BE4
	arm_func_end DWC_AddMatchKeyInt

	arm_func_start DWC_IsValidCancelMatching
DWC_IsValidCancelMatching: // 0x0209B998
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
	bl DWCi_GetMatchCnt
	cmp r0, #0
	beq _0209B9DC
	bl DWC_GetState
	cmp r0, #5
	bne _0209B9DC
	bl DWCi_GetMatchCnt
	ldrb r0, [r0, #0x1a9]
	cmp r0, #0
	beq _0209B9E8
_0209B9DC:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_0209B9E8:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWC_IsValidCancelMatching

	arm_func_start DWC_CancelMatching
DWC_CancelMatching: // 0x0209B9F4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWC_IsValidCancelMatching
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	bl DWCi_DoCancelMatching
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWC_CancelMatching

    .data
	
aDwcEval: // 0x0211C260
	.asciz "dwc_eval"
	.align 4
	
aDwcPid: // 0x0211C26C
	.asciz "dwc_pid"
	.align 4
	
aNumplayers: // 0x0211C274
	.asciz "numplayers"
	.align 4
	
aMaxplayers: // 0x0211C280
	.asciz "maxplayers"
	.align 4
	
aDwcMtype: // 0x0211C28C
	.asciz "dwc_mtype"
	.align 4
	
aDwcMresv: // 0x0211C298
	.asciz "dwc_mresv"
	.align 4
	
aDwcMver: // 0x0211C2A4
	.asciz "dwc_mver"
	.align 4
	
.public _0211C2B0
_0211C2B0:
	.byte 0x00, 0x00, 0x00, 0x00, 0x56, 0x45, 0x52, 0x00, 0x46, 0x4D, 0x45, 0x00, 0x4D, 0x44, 0x46, 0x00

aSDvS: // 0x0211C2C0
	.asciz "%s%dv%s"
	.align 4
	
.public _0211C2C8
_0211C2C8:
	.byte 0x47, 0x50, 0x43, 0x4D, 0x00, 0x00, 0x00, 0x00
	.byte 0x4D, 0x41, 0x54, 0x00, 0x2F, 0x25, 0x75, 0x00

aSDAndSUAndMaxp: // 0x0211C2D8
	.asciz "%s = %d and %s != %u and maxplayers = %d and numplayers < %d and %s = %d and %s != %s"
	.align 4
	
aSAndS: // 0x0211C330
	.asciz "%s and (%s)"
	.align 4
	
aSU: // 0x0211C33C
	.asciz "%s = %u"
	.align 4
	
.public _0211C344
_0211C344:
	.byte 0x53, 0x43, 0x4D, 0x00, 0x53, 0x43, 0x4E, 0x00

aInitState: // 0x0211C34C
	.asciz "Init state"
	.align 4
	
aServerFull: // 0x0211C358
	.asciz "Server full"
	.align 4
	
aUnknownConnect_0: // 0x0211C364
	.asciz "Unknown connect attempt"
	.align 4
	
.public _0211C37C
_0211C37C:
	.byte 0x59, 0x00, 0x00, 0x00
	.byte 0x4E, 0x00, 0x00, 0x00

aAnd: // 0x0211C384
	.asciz " and ()"
	.align 4