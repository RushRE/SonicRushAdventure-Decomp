	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWCi_BACKUPlGetWifi
DWCi_BACKUPlGetWifi: // 0x0208D4AC
	ldr r0, _0208D4B4 // =0x02143994
	bx lr
	.align 2, 0
_0208D4B4: .word 0x02143994
	arm_func_end DWCi_BACKUPlGetWifi

	arm_func_start DWCi_BACKUPlConvWifiInfo
DWCi_BACKUPlConvWifiInfo: // 0x0208D4B8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r3, [r4, #8]
	ldr r2, [r4, #0xc]
	ldr r1, _0208D56C // =0x02143994
	str r2, [sp, #4]
	str r3, [sp]
	mov r2, #5
	bl MI_CpuCopy8
	ldr r1, [sp]
	ldr r2, [r4, #4]
	ldr r0, [sp, #4]
	mov r2, r2, lsr #8
	mov ip, r1, lsr #5
	mov r3, r0, lsr #5
	orr ip, ip, r0, lsl #27
	and lr, r2, #7
	and r0, r1, #0x1f
	orr lr, lr, r0, lsl #3
	ldr r2, _0208D56C // =0x02143994
	ldr r1, _0208D570 // =0x0214399A
	strb lr, [r2, #5]
	add r0, sp, #0
	str ip, [sp]
	str r3, [sp, #4]
	mov r2, #4
	bl MI_CpuCopy8
	ldrh r0, [r4, #0x10]
	ldr r1, [sp, #4]
	ldr r3, _0208D56C // =0x02143994
	and r1, r1, #0x3f
	and r0, r0, #3
	orr r0, r1, r0, lsl #6
	strb r0, [r3, #0xa]
	ldrh r2, [r4, #0x10]
	add r0, r4, #0x12
	ldr r1, _0208D574 // =0x021439A0
	mov r4, r2, asr #2
	mov r2, #2
	strb r4, [r3, #0xb]
	bl MI_CpuCopy8
	ldr r0, _0208D56C // =0x02143994
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208D56C: .word 0x02143994
_0208D570: .word 0x0214399A
_0208D574: .word 0x021439A0
	arm_func_end DWCi_BACKUPlConvWifiInfo

	arm_func_start sub_208D578
sub_208D578: // 0x0208D578
	ldr r3, _0208D5A8 // =0x02143988
	and ip, r1, #0xff
	ldr r0, _0208D5AC // =0x0214398C
	mov r1, #1
	strh ip, [r3]
	str r1, [r0]
	cmp r2, #0
	movne r0, #0xff
	strneh r0, [r3]
	ldr r0, _0208D5A8 // =0x02143988
	ldrh r0, [r0]
	bx lr
	.align 2, 0
_0208D5A8: .word 0x02143988
_0208D5AC: .word 0x0214398C
	arm_func_end sub_208D578

	arm_func_start sub_208D5B0
sub_208D5B0: // 0x0208D5B0
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, #4
	mov r4, #1
_0208D5BC:
	mov r0, r5
	mov r1, r4
	bl PXI_IsCallbackReady
	cmp r0, #0
	beq _0208D5BC
	ldr r1, _0208D618 // =sub_208D578
	mov r0, #4
	bl PXI_SetFifoRecvCallback
	mov r4, #0x40000
	mov r6, #7
	mov r5, #0
_0208D5E8:
	mov r0, r6
	mov r1, r5
	mov r2, r5
	mov r3, r5
	bl sub_208D77C
	cmp r0, #1
	beq _0208D610
	mov r0, r4
	blx SVC_WaitByLoop
	b _0208D5E8
_0208D610:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0208D618: .word sub_208D578
	arm_func_end sub_208D5B0

	arm_func_start sub_208D61C
sub_208D61C: // 0x0208D61C
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r2
	mov r4, r3
	mov r6, r0
	mov r0, r1
	mov r1, r5
	mov r2, r4
	bl sub_208D6E4
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r6
	mov r1, r4
	mov r2, r5
	bl memcmp
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_208D61C

	arm_func_start sub_208D668
sub_208D668: // 0x0208D668
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, #4
	mov r4, #1
_0208D680:
	mov r0, r5
	mov r1, r4
	bl PXI_IsCallbackReady
	cmp r0, #0
	beq _0208D680
	ldr r1, _0208D6E0 // =sub_208D578
	mov r0, #4
	bl PXI_SetFifoRecvCallback
	mov r0, r6
	mov r1, r7
	bl DC_StoreRange
	mov r4, #0x40000
	mov r5, #2
_0208D6B4:
	mov r0, r5
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl sub_208D77C
	cmp r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r4
	blx SVC_WaitByLoop
	b _0208D6B4
	arm_func_end sub_208D668

	arm_func_start sub_208D6DC
sub_208D6DC: // 0x0208D6DC
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0208D6E0: .word sub_208D578
	arm_func_end sub_208D6DC

	arm_func_start sub_208D6E4
sub_208D6E4: // 0x0208D6E4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r4, r2
	mov r6, r0
	mov r0, r4
	mov r5, r1
	bl DC_InvalidateRange
	mov r8, #4
	mov r7, #1
_0208D708:
	mov r0, r8
	mov r1, r7
	bl PXI_IsCallbackReady
	cmp r0, #0
	beq _0208D708
	ldr r1, _0208D778 // =sub_208D578
	mov r0, #4
	bl PXI_SetFifoRecvCallback
	mov r0, r5, lsl #0x10
	mov r8, r0, lsr #0x10
	mov r7, #0x40000
	mov r9, #1
_0208D738:
	mov r0, r9
	mov r1, r6
	mov r2, r8
	mov r3, r4
	bl sub_208D77C
	cmp r0, #1
	beq _0208D760
	mov r0, r7
	blx SVC_WaitByLoop
	b _0208D738
_0208D760:
	mov r0, r4
	mov r1, r5
	bl DC_InvalidateRange
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0208D778: .word sub_208D578
	arm_func_end sub_208D6E4

	arm_func_start sub_208D77C
sub_208D77C: // 0x0208D77C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc4
	ldr ip, _0208DC34 // =0x0000FFFF
	ldr r10, _0208DC38 // =0x021439C0
	and r8, r2, ip
	and r7, r1, ip
	mov r5, r1, lsr #0x10
	mov r4, r3, lsr #0x10
	and r1, r3, ip
	orr r3, r8, #0x30000
	str r3, [sp, #0xc]
	ldr r3, _0208DC3C // =0x01050000
	orr r2, r2, #0x20000
	orr r3, r1, r3
	str r3, [sp, #0x14]
	orr r1, r1, #0x1040000
	mov r9, r0
	and r0, r5, #0xff
	str r2, [sp, #0x1c]
	str r1, [sp, #0x24]
	ldr r1, _0208DC40 // =0x02002200
	mov r8, #0
	orr r2, r4, #0x40000
	orr r1, r1, r10, lsr #24
	str r1, [sp, #0x28]
	and r1, ip, r10, lsr #8
	orr r1, r1, #0x10000
	ldr r3, _0208DC44 // =0x02002300
	str r2, [sp, #0x10]
	orr r2, r0, r3
	str r2, [sp, #8]
	orr r2, r4, #0x30000
	str r2, [sp, #0x20]
	ldr r2, _0208DC48 // =0x02002500
	mov r6, r10, lsl #8
	str r1, [sp, #0x2c]
	and r1, r6, #0xff00
	orr r0, r0, r2
	ldr r3, _0208DC4C // =0x01020000
	str r0, [sp, #0x18]
	orr r0, r1, r3
	str r0, [sp, #0x30]
	mov r0, #0x20000
	str r0, [sp, #0x40]
	mov r0, #5
	str r0, [sp, #0xac]
	mov r0, #3
	str r0, [sp, #0xb0]
	mov r0, #6
	str r0, [sp, #0xb8]
	mov r0, #0x4000
	orr r7, r7, #0x10000
	str r8, [sp, #0xb4]
	mov r4, #1
	str r8, [sp, #0xa8]
	mov r5, #4
	str r8, [sp, #0xa4]
	str r8, [sp, #0xa0]
	str r8, [sp, #0x90]
	str r8, [sp, #0x98]
	str r8, [sp, #0x9c]
	str r8, [sp, #0x94]
	str r8, [sp, #0x8c]
	str r8, [sp, #0x6c]
	str r8, [sp, #0x74]
	str r8, [sp, #0x7c]
	str r8, [sp, #0x84]
	str r8, [sp, #0x88]
	str r8, [sp, #0x80]
	str r8, [sp, #0x78]
	str r8, [sp, #0x70]
	str r8, [sp, #0x68]
	str r8, [sp, #0x64]
	str r8, [sp, #0x38]
	str r8, [sp, #0x44]
	str r8, [sp, #0x4c]
	str r8, [sp, #0x54]
	str r8, [sp, #0x5c]
	str r8, [sp, #0x60]
	str r8, [sp, #0x58]
	str r8, [sp, #0x50]
	str r8, [sp, #0x48]
	str r8, [sp, #0x3c]
	str r8, [sp, #0x34]
	mov r6, r8
	str r0, [sp, #0xbc]
_0208D8D4:
	cmp r8, #0
	bne _0208DB10
	ldr r0, _0208DC50 // =0x0214398C
	cmp r9, #7
	str r6, [r0]
	addls pc, pc, r9, lsl #2
	b _0208D8D4
_0208D8F0: // jump table
	b _0208D8D4 // case 0
	b _0208D910 // case 1
	b _0208D9BC // case 2
	b _0208D9DC // case 3
	b _0208DA78 // case 4
	b _0208DA78 // case 5
	b _0208DAD0 // case 6
	b _0208DAF0 // case 7
_0208D910:
	ldr r1, [sp, #8]
	mov r0, r5
	mov r2, r6
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x34]
	blt _0208D8D4
	ldr r2, [sp, #0x38]
	mov r0, r5
	mov r1, r7
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x3c]
	blt _0208D8D4
	ldr r1, [sp, #0x40]
	ldr r2, [sp, #0x44]
	mov r0, r5
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x48]
	blt _0208D8D4
	ldr r1, [sp, #0xc]
	ldr r2, [sp, #0x4c]
	mov r0, r5
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x50]
	blt _0208D8D4
	ldr r1, [sp, #0x10]
	ldr r2, [sp, #0x54]
	mov r0, r5
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x58]
	blt _0208D8D4
	ldr r1, [sp, #0x14]
	ldr r2, [sp, #0x5c]
	mov r0, r5
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x60]
	movge r8, r4
	b _0208D8D4
_0208D9BC:
	ldr r1, _0208DC54 // =0x03002000
	mov r0, r5
	mov r2, r6
	bl PXI_SendWordByFifo
	cmp r0, #0
	movge r8, r4
	ldrlt r8, [sp, #0x64]
	b _0208D8D4
_0208D9DC:
	ldr r1, [sp, #0x18]
	mov r0, r5
	mov r2, r6
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x68]
	blt _0208DA68
	ldr r2, [sp, #0x6c]
	mov r0, r5
	mov r1, r7
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x70]
	blt _0208DA68
	ldr r1, [sp, #0x1c]
	ldr r2, [sp, #0x74]
	mov r0, r5
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x78]
	blt _0208DA68
	ldr r1, [sp, #0x20]
	ldr r2, [sp, #0x7c]
	mov r0, r5
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x80]
	blt _0208DA68
	ldr r1, [sp, #0x24]
	ldr r2, [sp, #0x84]
	mov r0, r5
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x88]
	movge r8, r4
_0208DA68:
	bl OS_GetTick
	str r0, [sp]
	mov r11, r1
	b _0208D8D4
_0208DA78:
	ldr r1, [sp, #0x28]
	mov r0, r5
	mov r2, r6
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x8c]
	blt _0208D8D4
	ldr r1, [sp, #0x2c]
	ldr r2, [sp, #0x90]
	mov r0, r5
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x94]
	blt _0208D8D4
	ldr r1, [sp, #0x30]
	ldr r2, [sp, #0x98]
	mov r0, r5
	bl PXI_SendWordByFifo
	cmp r0, #0
	ldrlt r8, [sp, #0x9c]
	movge r8, r4
	b _0208D8D4
_0208DAD0:
	ldr r1, _0208DC58 // =0x03002D00
	mov r0, r5
	mov r2, r6
	bl PXI_SendWordByFifo
	cmp r0, #0
	movge r8, r4
	ldrlt r8, [sp, #0xa0]
	b _0208D8D4
_0208DAF0:
	ldr r1, _0208DC5C // =0x03002100
	mov r0, r5
	mov r2, r6
	bl PXI_SendWordByFifo
	cmp r0, #0
	movge r8, r4
	ldrlt r8, [sp, #0xa4]
	b _0208D8D4
_0208DB10:
	ldr r0, _0208DC50 // =0x0214398C
	ldr r0, [r0]
	cmp r0, #1
	bne _0208D8D4
	ldr r0, _0208DC60 // =0x02143988
	ldr r8, [sp, #0xa8]
	ldrh r0, [r0]
	cmp r0, #0
	bne _0208DC28
	cmp r9, #7
	addls pc, pc, r9, lsl #2
	b _0208D8D4
_0208DB40: // jump table
	b _0208D8D4 // case 0
	b _0208DB60 // case 1
	b _0208DB6C // case 2
	b _0208DB74 // case 3
	b _0208DB7C // case 4
	b _0208DB7C // case 5
	b _0208DC10 // case 6
	b _0208DC1C // case 7
_0208DB60:
	add sp, sp, #0xc4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208DB6C:
	mov r9, r5
	b _0208D8D4
_0208DB74:
	ldr r9, [sp, #0xac]
	b _0208D8D4
_0208DB7C:
	mov r0, r10
	mov r1, r4
	bl DC_InvalidateRange
	cmp r9, #4
	bne _0208DBAC
	ldrb r0, [r10]
	ands r0, r0, #2
	ldrne r9, [sp, #0xb0]
	bne _0208D8D4
	add sp, sp, #0xc4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208DBAC:
	ldrb r1, [r10]
	ands r0, r1, #1
	addeq sp, sp, #0xc4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ands r0, r1, #0x20
	bne _0208DBFC
	bl OS_GetTick
	ldr r2, [sp]
	ldr r3, [sp, #0xb4]
	subs r2, r0, r2
	sbc r0, r1, r11
	mov r1, r0, lsl #6
	orr r1, r1, r2, lsr #26
	mov r0, r2, lsl #6
	ldr r2, _0208DC64 // =0x000082EA
	bl _ll_udiv
	cmp r1, #0
	cmpeq r0, #0xfa0
	bls _0208DC04
_0208DBFC:
	ldr r9, [sp, #0xb8]
	b _0208D8D4
_0208DC04:
	ldr r0, [sp, #0xbc]
	blx SVC_WaitByLoop
	b _0208D8D4
_0208DC10:
	add sp, sp, #0xc4
	mov r0, r8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208DC1C:
	add sp, sp, #0xc4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208DC28:
	mov r0, r8
	add sp, sp, #0xc4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0208DC34: .word 0x0000FFFF
_0208DC38: .word 0x021439C0
_0208DC3C: .word 0x01050000
_0208DC40: .word 0x02002200
_0208DC44: .word 0x02002300
_0208DC48: .word 0x02002500
_0208DC4C: .word 0x01020000
_0208DC50: .word 0x0214398C
_0208DC54: .word 0x03002000
_0208DC58: .word 0x03002D00
_0208DC5C: .word 0x03002100
_0208DC60: .word 0x02143988
_0208DC64: .word 0x000082EA
	arm_func_end sub_208D77C

	arm_func_start DWC_BACKUPlCheckAddress
DWC_BACKUPlCheckAddress: // 0x0208DC68
	ldrb r0, [r0]
	cmp r0, #0x7f
	moveq r0, #0
	bxeq lr
	cmp r0, #1
	movlo r0, #0
	bxlo lr
	cmp r0, #0xdf
	movls r0, #1
	movhi r0, #0
	bx lr
	arm_func_end DWC_BACKUPlCheckAddress

	arm_func_start DWC_BACKUPlCheckIp
DWC_BACKUPlCheckIp: // 0x0208DC94
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r4, r1
	bl DWC_BACKUPlCheckAddress
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	add r1, sp, #0
	mov r0, r5
	mov r2, #4
	bl MI_CpuCopy8
	add r1, sp, #4
	mov r0, r4
	mov r2, #4
	bl MI_CpuCopy8
	ldr r3, [sp, #4]
	ldr r2, [sp]
	mvn r0, #1
	orr r1, r2, r3
	cmp r1, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	mvn r0, r3
	ands r0, r2, r0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWC_BACKUPlCheckIp

	arm_func_start DWC_BACKUPlCheckSsid
DWC_BACKUPlCheckSsid: // 0x0208DD10
	mov r2, #0
_0208DD14:
	ldrb r1, [r0, r2]
	cmp r1, #0
	movne r0, #1
	bxne lr
	add r2, r2, #1
	cmp r2, #0x20
	blt _0208DD14
	mov r0, #0
	bx lr
	arm_func_end DWC_BACKUPlCheckSsid

	arm_func_start DWCi_BACKUPlConvMaskAddr
DWCi_BACKUPlConvMaskAddr: // 0x0208DD38
	mvn r2, #0
	mov ip, #0
	eor r3, r2, r2, lsr r0
	mov r2, ip
_0208DD48:
	rsb r0, r2, #0x18
	mov r0, r3, lsr r0
	strb r0, [r1, ip]
	add ip, ip, #1
	cmp ip, #4
	add r2, r2, #8
	blt _0208DD48
	bx lr
	arm_func_end DWCi_BACKUPlConvMaskAddr

	arm_func_start sub_208DD68
sub_208DD68: // 0x0208DD68
	stmdb sp!, {r4, lr}
	mov lr, #0
	mov r4, lr
	mov r2, lr
_0208DD78:
	ldrb r3, [r0, lr]
	mov ip, r2
_0208DD80:
	mov r1, r3, asr ip
	ands r1, r1, #1
	add ip, ip, #1
	addne r4, r4, #1
	cmp ip, #8
	blt _0208DD80
	add lr, lr, #1
	cmp lr, #4
	blt _0208DD78
	and r0, r4, #0xff
	ldmia sp!, {r4, pc}
	arm_func_end sub_208DD68

	arm_func_start sub_208DDAC
sub_208DDAC: // 0x0208DDAC
	ldr ip, _0208DDBC // =MI_CpuCopy8
	ldr r1, _0208DDC0 // =0x02143994
	mov r2, #0xe
	bx ip
	.align 2, 0
_0208DDBC: .word MI_CpuCopy8
_0208DDC0: .word 0x02143994
	arm_func_end sub_208DDAC

	arm_func_start sub_208DDC4
sub_208DDC4: // 0x0208DDC4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r1, _0208DE60 // =0x02143990
	mov r10, r0
	ldr r8, [r1]
	mov r7, r10
	mov r9, #0
	add r4, r10, #0x400
	add r6, r10, #0x500
	mov r5, #0x100
	mov r11, #0xfe
_0208DDF0:
	mov r0, r6
	mov r1, r7
	mov r2, r11
	bl MATH_CalcCRC16
	add r1, r10, r9, lsl #8
	strh r0, [r1, #0xfe]
_0208DE08:
	mov r0, r8
	mov r1, r5
	mov r2, r7
	bl sub_208D668
	mov r0, r7
	mov r1, r8
	mov r2, r5
	mov r3, r4
	bl sub_208D61C
	cmp r0, #0
	beq _0208DE08
	add r9, r9, #1
	cmp r9, #4
	add r7, r7, #0x100
	add r8, r8, #0x100
	blt _0208DDF0
	bl sub_208D5B0
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0208DE60: .word 0x02143990
	arm_func_end sub_208DDC4

	arm_func_start sub_208DE64
sub_208DE64: // 0x0208DE64
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	ldr r3, _0208DEEC // =0x02143990
	mov r4, r0
	ldr r6, [r3]
	mov r9, r1
	mov r8, r2
	mov r7, #0
	mov r5, #0x100
_0208DE88:
	ldr r0, [r9, r7, lsl #2]
	cmp r0, #0
	beq _0208DEC0
_0208DE94:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_208D668
	mov r0, r4
	mov r1, r6
	mov r2, r5
	mov r3, r8
	bl sub_208D61C
	cmp r0, #0
	beq _0208DE94
_0208DEC0:
	add r7, r7, #1
	cmp r7, #4
	add r4, r4, #0x100
	add r6, r6, #0x100
	blt _0208DE88
	bl sub_208D5B0
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0208DEEC: .word 0x02143990
	arm_func_end sub_208DE64

	arm_func_start DWCi_BACKUPlRead
DWCi_BACKUPlRead: // 0x0208DEF0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0208DF20 // =0x02143990
	mov r2, r0
	ldr r0, [r1]
	mov r1, #0x400
	bl sub_208D6E4
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208DF20: .word 0x02143990
	arm_func_end DWCi_BACKUPlRead

	arm_func_start DWCi_BACKUPlInit
DWCi_BACKUPlInit: // 0x0208DF24
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x20
	mov r1, r0
	mov r2, r4
	bl sub_208D6E4
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldrh r2, [r4]
	ldr r1, _0208DF64 // =0x02143990
	mov r0, #1
	mov r2, r2, lsl #3
	sub r2, r2, #0x400
	str r2, [r1]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208DF64: .word 0x02143990
	arm_func_end DWCi_BACKUPlInit

	arm_func_start DWCi_BM_SetWiFiInfo
DWCi_BM_SetWiFiInfo: // 0x0208DF68
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r2, _0208E044 // =0x02143990
	mov r10, r1
	ldr r8, [r2]
	bl DWCi_BACKUPlConvWifiInfo
	ldr r1, _0208E048 // =0x0000A001
	add r0, r10, #0x200
	bl MATHi_CRC16InitTableRev
	mov r9, #0
	add r4, r10, #0x100
	add r6, r10, #0xf0
	mov r7, #0x100
	mov r5, #0xe
	mov r11, #0xfe
_0208DFA4:
	mov r0, r8
	mov r1, r7
	mov r2, r10
	bl sub_208D6E4
	cmp r0, #0
	bne _0208DFCC
	bl OS_Terminate
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208DFCC:
	ldr r0, _0208E04C // =0x02143994
	mov r1, r6
	mov r2, r5
	bl MI_CpuCopy8
	mov r1, r10
	mov r2, r11
	add r0, r10, #0x200
	bl MATH_CalcCRC16
	strh r0, [r10, #0xfe]
_0208DFF0:
	mov r0, r8
	mov r1, r7
	mov r2, r10
	bl sub_208D668
	mov r0, r10
	mov r1, r8
	mov r2, r7
	mov r3, r4
	bl sub_208D61C
	cmp r0, #0
	beq _0208DFF0
	add r9, r9, #1
	cmp r9, #2
	add r8, r8, #0x100
	blt _0208DFA4
	bl sub_208D5B0
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0208E044: .word 0x02143990
_0208E048: .word 0x0000A001
_0208E04C: .word 0x02143994
	arm_func_end DWCi_BM_SetWiFiInfo

	arm_func_start DWCi_BM_GetWiFiInfo
DWCi_BM_GetWiFiInfo: // 0x0208E050
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _0208E118 // =0x02143994
	mov r1, r4
	mov r2, #6
	bl MI_CpuCopy8
	ldr r3, [r4]
	mvn r0, #0
	ldr r2, [r4, #4]
	ldr r1, _0208E11C // =0x000007FF
	and r0, r3, r0
	str r0, [r4]
	and r1, r2, r1
	ldr r0, _0208E120 // =0x02143999
	str r1, [r4, #4]
	add r1, r4, #8
	mov r2, #6
	bl MI_CpuCopy8
	add ip, r4, #8
	ldr r1, [r4, #8]
	ldr r0, [ip, #4]
	mov r1, r1, lsr #3
	orr r1, r1, r0, lsl #29
	str r1, [r4, #8]
	mov r0, r0, lsr #3
	str r0, [ip, #4]
	ldr r3, [r4, #8]
	mvn r0, #0
	ldr r2, [ip, #4]
	ldr r1, _0208E11C // =0x000007FF
	and r0, r3, r0
	str r0, [r4, #8]
	and r1, r2, r1
	ldr r0, _0208E124 // =0x0214399E
	str r1, [ip, #4]
	add r1, r4, #0x10
	mov r2, #2
	bl MI_CpuCopy8
	ldrh r1, [r4, #0x10]
	ldr r3, _0208E128 // =0x000003FF
	ldr r0, _0208E12C // =0x021439A0
	mov r1, r1, asr #6
	strh r1, [r4, #0x10]
	ldrh ip, [r4, #0x10]
	add r1, r4, #0x12
	mov r2, #2
	and r3, ip, r3
	strh r3, [r4, #0x10]
	bl MI_CpuCopy8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208E118: .word 0x02143994
_0208E11C: .word 0x000007FF
_0208E120: .word 0x02143999
_0208E124: .word 0x0214399E
_0208E128: .word 0x000003FF
_0208E12C: .word 0x021439A0
	arm_func_end DWCi_BM_GetWiFiInfo

	arm_func_start sub_208E130
sub_208E130: // 0x0208E130
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0208E160 // =0x02143990
	mov r2, r0
	ldr r0, [r1]
	mov r1, #0x300
	bl sub_208D6E4
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208E160: .word 0x02143990
	arm_func_end sub_208E130
