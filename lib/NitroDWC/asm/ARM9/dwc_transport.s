	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWCs_GetOutgoingBufferFreeSize
DWCs_GetOutgoingBufferFreeSize: // 0x0209BA20
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_GetGT2Connection
	bl gt2GetOutgoingBufferFreeSpace
	ldr r1, _0209BA48 // =0xFFFFFDF9
	add r0, r0, r1
	cmp r0, #0
	movle r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209BA48: .word 0xFFFFFDF9
	arm_func_end DWCs_GetOutgoingBufferFreeSize

	arm_func_start DWCs_RecvSystemDataBody
DWCs_RecvSystemDataBody: // 0x0209BA4C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl DWCs_GetTransConnection
	ldrb r1, [r0, #0x1e]
	strb r1, [r0, #0x1d]
	ldrh r1, [r0, #0x22]
	cmp r1, #2
	beq _0209BA88
	cmp r1, #3
	beq _0209BA88
	cmp r1, #4
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
_0209BA88:
	mov r0, r5
	mov r2, r4
	bl DWCi_ProcessMatchSynPacket
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWCs_RecvSystemDataBody

	arm_func_start DWCs_RecvDataBody
DWCs_RecvDataBody: // 0x0209BA9C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r3, _0209BB94 // =0x02144314
	mov r7, r0
	ldr r4, [r3, #0]
	mov r3, #0x30
	mla r4, r7, r3, r4
	mov r6, r1
	mov r5, r2
	bl DWCs_GetRecvState
	cmp r0, #2
	bne _0209BB08
	ldr r3, [r4, #0x10]
	ldr r0, [r4, #8]
	add r1, r3, r5
	cmp r1, r0
	ble _0209BAF4
	ldr r1, _0209BB98 // =0xFFFE82AC
	mov r0, #6
	bl DWCi_SetError
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209BAF4:
	ldr r1, [r4, #4]
	mov r0, r6
	mov r2, r5
	add r1, r1, r3
	bl MI_CpuCopy8
_0209BB08:
	ldr r0, [r4, #0x10]
	add r0, r0, r5
	str r0, [r4, #0x10]
	ldr r2, [r4, #0x18]
	ldr r0, [r4, #0x10]
	cmp r0, r2
	bne _0209BB58
	mov r0, #1
	strb r0, [r4, #0x1d]
	mov r1, #0
	str r1, [r4, #0x10]
	ldr r0, _0209BB94 // =0x02144314
	str r1, [r4, #0x18]
	ldr r0, [r0, #0]
	ldr r3, [r0, #0x604]
	cmp r3, #0
	beq _0209BB58
	ldr r1, [r4, #4]
	mov r0, r7
	blx r3
_0209BB58:
	ldr r0, _0209BB94 // =0x02144314
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x608]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl OS_GetTick
	str r0, [r4, #0x24]
	str r1, [r4, #0x28]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209BB94: .word 0x02144314
_0209BB98: .word 0xFFFE82AC
	arm_func_end DWCs_RecvDataBody

	arm_func_start DWCs_RecvDataHeader
DWCs_RecvDataHeader: // 0x0209BB9C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r4, _0209BC60 // =0x02144314
	mov r3, #0x30
	ldr r4, [r4, #0]
	mov r7, r1
	mla r5, r0, r3, r4
	mov r6, r2
	bl DWCs_GetRecvState
	strb r0, [r5, #0x1e]
	mov r0, r7
	bl DWCs_DecodeHeader
	mov r4, r0
	cmp r4, #4
	addls pc, pc, r4, lsl #2
	b _0209BC54
_0209BBDC: // jump table
	b _0209BC54 // case 0
	b _0209BBF0 // case 1
	b _0209BC4C // case 2
	b _0209BC4C // case 3
	b _0209BC4C // case 4
_0209BBF0:
	cmp r6, #8
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	add r1, sp, #0
	mov r0, r7
	mov r2, #8
	bl MI_CpuCopy8
	ldr r1, [sp]
	mov r0, #0
	str r1, [r5, #0x18]
	str r0, [r5, #0x10]
	ldr r0, [r5, #4]
	cmp r0, #0
	beq _0209BC40
	ldr r1, [r5, #8]
	ldr r0, [r5, #0x18]
	cmp r1, r0
	movge r0, #2
	strgeb r0, [r5, #0x1d]
	bge _0209BC54
_0209BC40:
	mov r0, #4
	strb r0, [r5, #0x1d]
	b _0209BC54
_0209BC4C:
	mov r0, #3
	strb r0, [r5, #0x1d]
_0209BC54:
	strh r4, [r5, #0x22]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209BC60: .word 0x02144314
	arm_func_end DWCs_RecvDataHeader

	arm_func_start DWCs_HandleUnreliableMessage
DWCs_HandleUnreliableMessage: // 0x0209BC64
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r1
	mov r6, r2
	bl DWCi_GetConnectionAID
	ldr r1, _0209BD18 // =0x02144314
	mov r4, r0
	ldr r1, [r1, #0]
	mov r0, #0x30
	mla r5, r4, r0, r1
	ldr r1, [r5, #4]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r5, #8]
	cmp r0, r6
	addlt sp, sp, #4
	ldmltia sp!, {r4, r5, r6, r7, pc}
	mov r0, r7
	mov r2, r6
	bl MI_CpuCopy8
	ldr r0, _0209BD18 // =0x02144314
	ldr r0, [r0, #0]
	ldr r3, [r0, #0x604]
	cmp r3, #0
	beq _0209BCDC
	ldr r1, [r5, #4]
	mov r0, r4
	mov r2, r6
	blx r3
_0209BCDC:
	ldr r0, _0209BD18 // =0x02144314
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x608]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r5, #0x2c]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	bl OS_GetTick
	str r0, [r5, #0x24]
	str r1, [r5, #0x28]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209BD18: .word 0x02144314
	arm_func_end DWCs_HandleUnreliableMessage

	arm_func_start DWCs_HandleReliableMessage
DWCs_HandleReliableMessage: // 0x0209BD1C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	mov r5, r2
	bl DWCi_GetConnectionAID
	mov r4, r0
	bl DWCs_GetRecvState
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _0209BDF8
_0209BD40: // jump table
	b _0209BD54 // case 0
	b _0209BD80 // case 1
	b _0209BD94 // case 2
	b _0209BDA8 // case 3
	b _0209BDBC // case 4
_0209BD54:
	mov r0, r6
	bl DWCs_DecodeHeader
	cmp r0, #2
	ldmloia sp!, {r4, r5, r6, pc}
	cmp r0, #4
	ldmhiia sp!, {r4, r5, r6, pc}
	mov r0, r4
	mov r1, r6
	mov r2, r5
	bl DWCs_RecvDataHeader
	ldmia sp!, {r4, r5, r6, pc}
_0209BD80:
	mov r0, r4
	mov r1, r6
	mov r2, r5
	bl DWCs_RecvDataHeader
	ldmia sp!, {r4, r5, r6, pc}
_0209BD94:
	mov r0, r4
	mov r1, r6
	mov r2, r5
	bl DWCs_RecvDataBody
	ldmia sp!, {r4, r5, r6, pc}
_0209BDA8:
	mov r0, r4
	mov r1, r6
	mov r2, r5
	bl DWCs_RecvSystemDataBody
	ldmia sp!, {r4, r5, r6, pc}
_0209BDBC:
	mov r0, #0x30
	mul ip, r4, r0
	ldr r0, _0209BE08 // =0x02144314
	mov r3, #1
	ldr r1, [r0, #0]
	mov r2, #0
	add r1, r1, ip
	strb r3, [r1, #0x1d]
	ldr r1, [r0, #0]
	add r1, r1, ip
	str r2, [r1, #0x10]
	ldr r0, [r0, #0]
	add r0, r0, ip
	str r2, [r0, #0x18]
	ldmia sp!, {r4, r5, r6, pc}
_0209BDF8:
	ldr r1, _0209BE0C // =0xFFFE82B6
	mov r0, #6
	bl DWCi_SetError
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209BE08: .word 0x02144314
_0209BE0C: .word 0xFFFE82B6
	arm_func_end DWCs_HandleReliableMessage

	arm_func_start DWCs_Send
DWCs_Send: // 0x0209BE10
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl DWCi_GetGT2Connection
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl sub_20B218C
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCs_Send

	arm_func_start DWCs_GetRecvState
DWCs_GetRecvState: // 0x0209BE38
	ldr r2, _0209BE50 // =0x02144314
	mov r1, #0x30
	ldr r2, [r2, #0]
	mla r1, r0, r1, r2
	ldrb r0, [r1, #0x1d]
	bx lr
	.align 2, 0
_0209BE50: .word 0x02144314
	arm_func_end DWCs_GetRecvState

	arm_func_start DWCs_GetSendState
DWCs_GetSendState: // 0x0209BE54
	ldr r2, _0209BE6C // =0x02144314
	mov r1, #0x30
	ldr r2, [r2, #0]
	mla r1, r0, r1, r2
	ldrb r0, [r1, #0x1c]
	bx lr
	.align 2, 0
_0209BE6C: .word 0x02144314
	arm_func_end DWCs_GetSendState

	arm_func_start DWCs_GetTransConnection
DWCs_GetTransConnection: // 0x0209BE70
	ldr r2, _0209BE84 // =0x02144314
	mov r1, #0x30
	ldr r2, [r2, #0]
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_0209BE84: .word 0x02144314
	arm_func_end DWCs_GetTransConnection

	arm_func_start DWCi_ShutdownTransport
DWCi_ShutdownTransport: // 0x0209BE88
	ldr r0, _0209BE98 // =0x02144314
	mov r1, #0
	str r1, [r0]
	bx lr
	.align 2, 0
_0209BE98: .word 0x02144314
	arm_func_end DWCi_ShutdownTransport

	arm_func_start DWCi_ClearTransConnection
DWCi_ClearTransConnection: // 0x0209BE9C
	ldr r2, _0209BF24 // =0x02144314
	ldr r3, [r2, #0]
	cmp r3, #0
	bxeq lr
	mov r1, #0x30
	mul r1, r0, r1
	add r0, r3, r1
	mov r3, #0
	str r3, [r0, #0xc]
	ldr r0, [r2, #0]
	add r0, r0, r1
	str r3, [r0, #0x10]
	ldr r0, [r2, #0]
	add r0, r0, r1
	str r3, [r0, #0x14]
	ldr r0, [r2, #0]
	add r0, r0, r1
	str r3, [r0, #0x18]
	ldr r0, [r2, #0]
	add r0, r0, r1
	strb r3, [r0, #0x1c]
	ldr r0, [r2, #0]
	add r2, r0, #0x1d
	ldrb r0, [r2, r1]
	add r2, r2, r1
	cmp r0, #0
	movne r0, #1
	strneb r0, [r2]
	ldr r0, _0209BF24 // =0x02144314
	mov r2, #0
	ldr r0, [r0, #0]
	add r0, r0, r1
	strh r2, [r0, #0x22]
	bx lr
	.align 2, 0
_0209BF24: .word 0x02144314
	arm_func_end DWCi_ClearTransConnection

	arm_func_start DWCi_TransportProcess
DWCi_TransportProcess: // 0x0209BF28
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r0, _0209C0D8 // =0x02144314
	ldr r0, [r0, #0]
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, sp, #8
	bl DWC_GetAIDList
	mov r9, r0
	cmp r9, #0
	mov r8, #0
	addle sp, sp, #0xc
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r4, _0209C0D8 // =0x02144314
	str r8, [sp]
	str r8, [sp, #4]
	mov r11, #1
_0209BF70:
	ldr r0, [sp, #8]
	ldrb r7, [r0, r8]
	mov r0, r7
	bl DWC_IsValidAID
	cmp r0, #0
	beq _0209C008
	mov r0, r7
	bl DWCs_GetTransConnection
	ldr r1, [r4, #0]
	mov r6, r0
	ldr r0, [r1, #0x608]
	cmp r0, #0
	beq _0209C008
	ldr r0, [r6, #0x2c]
	cmp r0, #0
	beq _0209C008
	bl OS_GetTick
	mov r10, r1
	ldr r2, [r6, #0x24]
	mov r5, r0
	subs r2, r5, r2
	ldr r1, [r6, #0x28]
	mov r0, r2, lsl #6
	sbc r1, r10, r1
	mov r1, r1, lsl #6
	orr r1, r1, r2, lsr #26
	ldr r2, _0209C0DC // =0x000082EA
	ldr r3, [sp]
	bl _ll_udiv
	ldr r1, [r6, #0x2c]
	cmp r0, r1
	bls _0209C008
	ldr r1, [r4, #0]
	mov r0, r7
	ldr r1, [r1, #0x608]
	blx r1
	str r5, [r6, #0x24]
	str r10, [r6, #0x28]
_0209C008:
	bl DWC_GetMyAID
	cmp r7, r0
	beq _0209C0C4
	mov r0, r7
	bl DWCs_GetSendState
	cmp r0, #1
	bne _0209C0C4
	mov r0, r7
	bl DWCs_GetTransConnection
	mov r5, r0
	ldr r0, [r4, #0]
	ldr r2, [r5, #0x14]
	add r0, r0, #0x600
	ldr r1, [r5, #0xc]
	ldrh r6, [r0, #0x10]
	sub r0, r2, r1
	cmp r0, r6
	movle r6, r0
	mov r0, r7
	bl DWCs_GetOutgoingBufferFreeSize
	cmp r0, r6
	blt _0209C0C4
	ldr r3, [r5, #0]
	ldr r1, [r5, #0xc]
	mov r0, r7
	mov r2, r6
	add r1, r3, r1
	mov r3, r11
	bl DWCs_Send
	ldr r0, [r5, #0xc]
	add r0, r0, r6
	str r0, [r5, #0xc]
	ldr r0, [r5, #0x14]
	ldr r1, [r5, #0xc]
	cmp r1, r0
	bne _0209C0C4
	ldr r1, [sp, #4]
	strb r1, [r5, #0x1c]
	str r1, [r5]
	str r1, [r5, #0xc]
	str r1, [r5, #0x14]
	ldr r1, [r4, #0]
	ldr r2, [r1, #0x600]
	cmp r2, #0
	beq _0209C0C4
	mov r1, r7
	blx r2
_0209C0C4:
	add r8, r8, #1
	cmp r8, r9
	blt _0209BF70
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0209C0D8: .word 0x02144314
_0209C0DC: .word 0x000082EA
	arm_func_end DWCi_TransportProcess

	arm_func_start DWCi_PingCallback
DWCi_PingCallback: // 0x0209C0E0
	stmdb sp!, {r4, lr}
	ldr r2, _0209C11C // =0x02144314
	mov r4, r1
	ldr r1, [r2, #0]
	ldr r1, [r1, #0x60c]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	bl DWCi_GetConnectionAID
	ldr r2, _0209C11C // =0x02144314
	mov r1, r0
	ldr r2, [r2, #0]
	mov r0, r4
	ldr r2, [r2, #0x60c]
	blx r2
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209C11C: .word 0x02144314
	arm_func_end DWCi_PingCallback

	arm_func_start DWCi_RecvCallback
DWCi_RecvCallback: // 0x0209C120
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr ip, _0209C174 // =0x02144314
	ldr ip, [ip]
	cmp ip, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	cmp r2, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	cmp r3, #0
	beq _0209C168
	bl DWCs_HandleReliableMessage
	add sp, sp, #4
	ldmia sp!, {pc}
_0209C168:
	bl DWCs_HandleUnreliableMessage
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209C174: .word 0x02144314
	arm_func_end DWCi_RecvCallback

	arm_func_start DWCi_InitTransport
DWCi_InitTransport: // 0x0209C178
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, _0209C1B0 // =0x02144314
	ldr r2, _0209C1B4 // =0x00000614
	mov r1, #0
	str r0, [r3]
	bl MI_CpuFill8
	ldr r0, _0209C1B0 // =0x02144314
	ldr r1, _0209C1B8 // =0x000005B9
	ldr r0, [r0, #0]
	add r0, r0, #0x600
	strh r1, [r0, #0x10]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209C1B0: .word 0x02144314
_0209C1B4: .word 0x00000614
_0209C1B8: .word 0x000005B9
	arm_func_end DWCi_InitTransport

	arm_func_start DWC_SetRecvTimeoutTime
DWC_SetRecvTimeoutTime: // 0x0209C1BC
	stmdb sp!, {r4, lr}
	ldr r2, _0209C204 // =0x02144314
	ldr r3, [r2, #0]
	cmp r3, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	mov r2, #0x30
	mul r4, r0, r2
	add r0, r3, r4
	str r1, [r0, #0x2c]
	bl OS_GetTick
	ldr r2, _0209C204 // =0x02144314
	ldr r2, [r2, #0]
	add r2, r2, r4
	str r0, [r2, #0x24]
	str r1, [r2, #0x28]
	mov r0, #1
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209C204: .word 0x02144314
	arm_func_end DWC_SetRecvTimeoutTime

	arm_func_start DWCs_GetRequiredHeaderSize
DWCs_GetRequiredHeaderSize: // 0x0209C208
	cmp r0, #2
	beq _0209C220
	cmp r0, #3
	beq _0209C220
	cmp r0, #4
	bne _0209C228
_0209C220:
	mov r0, #0xc
	bx lr
_0209C228:
	mov r0, #8
	bx lr
	arm_func_end DWCs_GetRequiredHeaderSize

	arm_func_start DWCs_DecodeHeader
DWCs_DecodeHeader: // 0x0209C230
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	add r1, sp, #0
	mov r2, #8
	bl MI_CpuCopy8
	ldr r1, _0209C268 // =_0211C38C
	add r0, sp, #6
	mov r2, #2
	bl memcmp
	cmp r0, #0
	ldreqh r0, [sp, #4]
	movne r0, #0
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0209C268: .word _0211C38C
	arm_func_end DWCs_DecodeHeader

	arm_func_start DWCs_EncodeHeader
DWCs_EncodeHeader: // 0x0209C26C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	ldr r1, _0209C298 // =_0211C38C
	add r0, r6, #6
	mov r2, #2
	bl strncpy
	strh r5, [r6, #4]
	str r4, [r6]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209C298: .word _0211C38C
	arm_func_end DWCs_EncodeHeader

	arm_func_start DWC_SetUserRecvTimeoutCallback
DWC_SetUserRecvTimeoutCallback: // 0x0209C29C
	ldr r1, _0209C2B8 // =0x02144314
	ldr r1, [r1, #0]
	cmp r1, #0
	moveq r0, #0
	strne r0, [r1, #0x608]
	movne r0, #1
	bx lr
	.align 2, 0
_0209C2B8: .word 0x02144314
	arm_func_end DWC_SetUserRecvTimeoutCallback

	arm_func_start DWC_SetUserRecvCallback
DWC_SetUserRecvCallback: // 0x0209C2BC
	ldr r1, _0209C2D8 // =0x02144314
	ldr r1, [r1, #0]
	cmp r1, #0
	moveq r0, #0
	strne r0, [r1, #0x604]
	movne r0, #1
	bx lr
	.align 2, 0
_0209C2D8: .word 0x02144314
	arm_func_end DWC_SetUserRecvCallback

	arm_func_start DWC_SetRecvBuffer
DWC_SetRecvBuffer: // 0x0209C2DC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl DWCs_GetTransConnection
	mov r4, r0
	mov r0, r7
	bl DWCs_GetRecvState
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	str r6, [r4, #4]
	str r5, [r4, #8]
	mov r0, #1
	strb r0, [r4, #0x1d]
	mov r1, #0
	str r1, [r4, #0x10]
	str r1, [r4, #0x18]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end DWC_SetRecvBuffer

	arm_func_start DWC_SendUnreliableBitmap
DWC_SendUnreliableBitmap: // 0x0209C334
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r8, #0
	mov r7, #1
_0209C350:
	cmp r8, #0
	movne r9, r7, lsl r8
	moveq r9, r7
	ands r0, r6, r9
	beq _0209C38C
	bl DWC_GetMyAID
	cmp r8, r0
	beq _0209C38C
	mov r0, r8
	mov r1, r5
	mov r2, r4
	bl DWC_SendUnreliable
	cmp r0, #0
	mvneq r0, r9
	andeq r6, r6, r0
_0209C38C:
	add r0, r8, #1
	and r8, r0, #0xff
	cmp r8, #0x20
	blo _0209C350
	mov r0, r6
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end DWC_SendUnreliableBitmap

	arm_func_start DWC_SendUnreliable
DWC_SendUnreliable: // 0x0209C3A8
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	mov r6, r1
	mov r4, r2
	bl DWCi_IsError
	cmp r0, #0
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r5
	bl DWC_IsValidAID
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, _0209C434 // =0x02144314
	ldr r0, [r0, #0]
	add r0, r0, #0x600
	ldrh r0, [r0, #0x10]
	cmp r4, r0
	movgt r0, #0
	ldmgtia sp!, {r4, r5, r6, pc}
	mov r0, r5
	mov r1, r6
	mov r2, r4
	mov r3, #0
	bl DWCs_Send
	ldr r0, _0209C434 // =0x02144314
	ldr r0, [r0, #0]
	ldr r2, [r0, #0x600]
	cmp r2, #0
	beq _0209C42C
	mov r0, r4
	mov r1, r5
	blx r2
_0209C42C:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209C434: .word 0x02144314
	arm_func_end DWC_SendUnreliable

	arm_func_start DWCi_SendReliable
DWCi_SendReliable: // 0x0209C438
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r7, r1
	mov r8, r0
	mov r0, r7
	mov r6, r2
	mov r5, r3
	bl DWCs_GetTransConnection
	mov r4, r0
	mov r0, r7
	mov r1, r8
	bl DWCi_IsSendableReliable
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r0, #1
	strb r0, [r4, #0x1c]
	str r6, [r4]
	mov r0, #0
	str r0, [r4, #0xc]
	add r0, sp, #0
	mov r1, r8
	mov r2, r5
	str r5, [r4, #0x14]
	bl DWCs_EncodeHeader
	add r1, sp, #0
	mov r0, r7
	mov r2, #8
	mov r3, #1
	bl DWCs_Send
	ldr r0, _0209C558 // =0x02144314
	ldr r0, [r0, #0]
	add r0, r0, #0x600
	ldrh r9, [r0, #0x10]
	mov r0, r7
	cmp r5, r9
	movle r9, r5
	bl DWCs_GetOutgoingBufferFreeSize
	cmp r9, r0
	addgt sp, sp, #0xc
	movgt r0, #1
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r0, r7
	mov r1, r6
	mov r2, r9
	mov r3, #1
	bl DWCs_Send
	ldr r0, [r4, #0xc]
	add r0, r0, r9
	str r0, [r4, #0xc]
	ldr r0, [r4, #0x14]
	ldr r1, [r4, #0xc]
	cmp r1, r0
	bne _0209C54C
	mov r2, #0
	strb r2, [r4, #0x1c]
	str r2, [r4]
	str r2, [r4, #0xc]
	ldr r1, _0209C558 // =0x02144314
	str r2, [r4, #0x14]
	ldr r1, [r1, #0]
	ldr r2, [r1, #0x600]
	cmp r2, #0
	beq _0209C54C
	cmp r8, #1
	bne _0209C54C
	mov r1, r7
	blx r2
_0209C54C:
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0209C558: .word 0x02144314
	arm_func_end DWCi_SendReliable

	arm_func_start DWC_SendReliable
DWC_SendReliable: // 0x0209C55C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov ip, r1
	mov r3, r2
	mov r1, r0
	mov r2, ip
	mov r0, #1
	bl DWCi_SendReliable
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWC_SendReliable

	arm_func_start DWCi_IsSendableReliable
DWCi_IsSendableReliable: // 0x0209C584
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r5, r1
	bl DWCi_IsError
	cmp r0, #0
	bne _0209C5C8
	cmp r5, #1
	bne _0209C5B8
	mov r0, r4
	bl DWC_IsValidAID
	cmp r0, #0
	beq _0209C5C8
_0209C5B8:
	mov r0, r4
	bl DWCi_IsValidAID
	cmp r0, #0
	bne _0209C5D4
_0209C5C8:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_0209C5D4:
	mov r0, r4
	bl DWCs_GetSendState
	cmp r0, #1
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r4
	bl DWCs_GetOutgoingBufferFreeSize
	mov r4, r0
	mov r0, r5
	bl DWCs_GetRequiredHeaderSize
	cmp r4, r0
	movge r0, #1
	movlt r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWCi_IsSendableReliable

	arm_func_start DWC_IsSendableReliable
DWC_IsSendableReliable: // 0x0209C614
	ldr ip, _0209C620 // =DWCi_IsSendableReliable
	mov r1, #1
	bx ip
	.align 2, 0
_0209C620: .word DWCi_IsSendableReliable
	arm_func_end DWC_IsSendableReliable

	.data
	
.public _0211C38C
_0211C38C:
	.byte 0x44, 0x54, 0x00, 0x00
