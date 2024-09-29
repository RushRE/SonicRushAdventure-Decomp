	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start WcmCountBits
WcmCountBits: // 0x020C9AA8
	mov r1, r0
	mov r0, #0
	mov r3, #1
_020C9AB4:
	clz r2, r1
	rsbs r2, r2, #0x1f
	bxlo lr
	bic r1, r1, r3, lsl r2
	add r0, r0, #1
	b _020C9AB4
	arm_func_end WcmCountBits

	arm_func_start WcmCountLeadingZero
WcmCountLeadingZero: // 0x020C9ACC
	clz r0, r0
	bx lr
	arm_func_end WcmCountLeadingZero

	arm_func_start WcmWmcbReset
WcmWmcbReset: // 0x020C9AD4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldrh r0, [r0, #2]
	cmp r0, #0
	bne _020C9DDC
	ldr r2, _020C9E04 // =0x021471EC
	mov r0, #0
	ldr r1, [r2]
	add r1, r1, #0x2000
	strb r0, [r1, #0x26b]
	ldr r1, [r2]
	add r1, r1, #0x2200
	strh r0, [r1, #0x82]
	ldr r3, [r2]
	add r1, r3, #0x2000
	ldr r1, [r1, #0x260]
	cmp r1, #0xd
	addls pc, pc, r1, lsl #2
	b _020C9DA8
_020C9B20: // jump table
	b _020C9DA8 // case 0
	b _020C9DA8 // case 1
	b _020C9DA8 // case 2
	b _020C9DA8 // case 3
	b _020C9DA8 // case 4
	b _020C9B58 // case 5
	b _020C9B58 // case 6
	b _020C9B80 // case 7
	b _020C9BA8 // case 8
	b _020C9CD0 // case 9
	b _020C9D00 // case 10
	b _020C9DA8 // case 11
	b _020C9CD0 // case 12
	b _020C9D30 // case 13
_020C9B58:
	mov r0, #3
	bl WcmSetPhase
	mov r1, #0
	ldr r3, _020C9E08 // =0x000008F5
	mov r2, r1
	mov r0, #1
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9B80:
	mov r0, #3
	bl WcmSetPhase
	mov r0, #0
	ldr r3, _020C9E0C // =0x000008FB
	mov r1, r0
	mov r2, r0
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9BA8:
	add r1, r3, #0x2200
	ldrh r4, [r1, #0xf8]
	strh r0, [r1, #0xf8]
	cmp r4, #0x12
	bne _020C9CA0
	ldr r1, [r2]
	add r1, r1, #0x2100
	ldrh r3, [r1, #0x70]
	and ip, r3, #0x24
	cmp ip, #0x24
	beq _020C9CA0
	orr r3, r3, #0x24
	strh r3, [r1, #0x70]
	ldr r2, [r2]
	add r1, r2, #0x2000
	ldr r3, [r1, #0x264]
	and r1, r3, #0xc0000
	cmp r1, #0xc0000
	moveq r0, #1
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	and r1, r3, #0x30000
	cmp r1, #0x30000
	movne r3, #1
	add r1, r2, #0x2140
	ldr r0, _020C9E10 // =WcmWmcbConnect
	moveq r3, #0
	mov r2, #0
	str ip, [sp]
	bl WM_StartConnectEx
	cmp r0, #2
	addeq sp, sp, #8
	ldmeqia sp!, {r4, lr}
	bxeq lr
	cmp r0, #3
	beq _020C9C70
	cmp r0, #8
	bne _020C9C70
	mov r0, #0xc
	bl WcmSetPhase
	ldr r0, _020C9E04 // =0x021471EC
	ldr r3, _020C9E14 // =0x0000091C
	ldr r0, [r0]
	mov r2, r4
	add r1, r0, #0x2140
	mov r0, #1
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9C70:
	mov r0, #0xb
	bl WcmSetPhase
	ldr r0, _020C9E04 // =0x021471EC
	ldr r3, _020C9E18 // =0x00000925
	ldr r0, [r0]
	mov r2, r4
	add r1, r0, #0x2140
	mov r0, #7
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9CA0:
	mov r0, #3
	bl WcmSetPhase
	ldr r0, _020C9E04 // =0x021471EC
	ldr r3, _020C9E1C // =0x0000092D
	ldr r0, [r0]
	mov r2, r4
	add r1, r0, #0x2140
	mov r0, #1
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9CD0:
	mov r0, #3
	bl WcmSetPhase
	ldr r0, _020C9E04 // =0x021471EC
	ldr r3, _020C9E20 // =0x00000935
	ldr r1, [r0]
	mov r0, #0
	add r1, r1, #0x2140
	mov r2, #1
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9D00:
	mov r0, #3
	bl WcmSetPhase
	ldr r1, _020C9E04 // =0x021471EC
	mov r0, #0
	ldr r1, [r1]
	ldr r3, _020C9E24 // =0x0000093C
	mov r2, r0
	add r1, r1, #0x2140
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9D30:
	ldr r0, _020C9E28 // =WcmWmcbCommon
	bl WM_PowerOff
	cmp r0, #2
	addeq sp, sp, #8
	ldmeqia sp!, {r4, lr}
	bxeq lr
	cmp r0, #3
	beq _020C9D80
	cmp r0, #8
	bne _020C9D80
	mov r0, #0xc
	bl WcmSetPhase
	mov r1, #0
	ldr r3, _020C9E2C // =0x0000094A
	mov r2, r1
	mov r0, #1
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9D80:
	mov r0, #0xb
	bl WcmSetPhase
	mov r1, #0
	ldr r3, _020C9E30 // =0x00000953
	mov r2, r1
	mov r0, #7
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9DA8:
	mov r0, #0xb
	bl WcmSetPhase
	ldr r0, _020C9E04 // =0x021471EC
	ldr r3, _020C9E34 // =0x00000959
	ldr r1, [r0]
	mov r0, #7
	add r1, r1, #0x2000
	ldr r2, [r1, #0x260]
	mov r1, #0
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9DDC:
	mov r0, #0xb
	bl WcmSetPhase
	mov r1, #0
	mov r2, r1
	mov r0, #7
	mov r3, #0x960
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C9E04: .word 0x021471EC
_020C9E08: .word 0x000008F5
_020C9E0C: .word 0x000008FB
_020C9E10: .word WcmWmcbConnect
_020C9E14: .word 0x0000091C
_020C9E18: .word 0x00000925
_020C9E1C: .word 0x0000092D
_020C9E20: .word 0x00000935
_020C9E24: .word 0x0000093C
_020C9E28: .word WcmWmcbCommon
_020C9E2C: .word 0x0000094A
_020C9E30: .word 0x00000953
_020C9E34: .word 0x00000959
	arm_func_end WcmWmcbReset

	arm_func_start WcmWmcbEndDCF
WcmWmcbEndDCF: // 0x020C9E38
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020C9F50
_020C9E50: // jump table
	b _020C9E64 // case 0
	b _020C9F38 // case 1
	b _020C9F50 // case 2
	b _020C9F38 // case 3
	b _020C9F50 // case 4
_020C9E64:
	ldr r0, _020C9F80 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #0xc
	bne _020C9E94
	mov r0, #0xa
	bl WcmSetPhase
	bl WcmWmReset
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C9E94:
	ldr r0, _020C9F84 // =WcmWmcbDisconnect
	mov r1, #0
	bl WM_Disconnect
	cmp r0, #2
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	cmp r0, #3
	beq _020C9EF0
	cmp r0, #8
	bne _020C9F08
	mov r0, #0xc
	bl WcmSetPhase
	ldr r0, _020C9F80 // =0x021471EC
	ldr r3, _020C9F88 // =0x000008B4
	ldr r1, [r0]
	mov r0, #1
	add r1, r1, #0x2140
	mov r2, #0
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C9EF0:
	mov r0, #0xa
	bl WcmSetPhase
	bl WcmWmReset
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C9F08:
	mov r0, #0xb
	bl WcmSetPhase
	ldr r1, _020C9F80 // =0x021471EC
	mov r0, #7
	ldr r1, [r1]
	mov r2, #0
	add r1, r1, #0x2140
	mov r3, #0x8c0
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C9F38:
	mov r0, #0xa
	bl WcmSetPhase
	bl WcmWmReset
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C9F50:
	mov r0, #0xb
	bl WcmSetPhase
	ldr r0, _020C9F80 // =0x021471EC
	ldr r3, _020C9F8C // =0x000008D3
	ldr r1, [r0]
	mov r0, #7
	add r1, r1, #0x2140
	mov r2, #0
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C9F80: .word 0x021471EC
_020C9F84: .word WcmWmcbDisconnect
_020C9F88: .word 0x000008B4
_020C9F8C: .word 0x000008D3
	arm_func_end WcmWmcbEndDCF

	arm_func_start WcmWmcbStartDCF
WcmWmcbStartDCF: // 0x020C9F90
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _020C9FAC
	cmp r0, #4
	b _020CA078
_020C9FAC:
	ldrh r0, [r4, #4]
	cmp r0, #0xe
	beq _020C9FC4
	cmp r0, #0xf
	beq _020CA01C
	b _020CA04C
_020C9FC4:
	ldr r0, _020CA0A4 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #0xc
	bne _020C9FF0
	mov r0, #8
	bl WcmSetPhase
	bl WcmWmReset
	ldmia sp!, {r4, lr}
	bx lr
_020C9FF0:
	mov r0, #9
	bl WcmSetPhase
	ldr r1, _020CA0A4 // =0x021471EC
	mov r0, #0
	ldr r1, [r1]
	ldr r3, _020CA0A8 // =0x00000872
	mov r2, r0
	add r1, r1, #0x2140
	bl WcmNotify
	ldmia sp!, {r4, lr}
	bx lr
_020CA01C:
	ldr r0, [r4, #8]
	ldrh r0, [r0, #0xe]
	mov r0, r0, asr #8
	and r0, r0, #0xff
	bl WCMi_ShelterRssi
	ldr r0, [r4, #8]
	mov r1, #0x620
	bl DC_InvalidateRange
	ldr r0, [r4, #8]
	bl WCMi_CpsifRecvCallback
	ldmia sp!, {r4, lr}
	bx lr
_020CA04C:
	mov r0, #0xb
	bl WcmSetPhase
	ldr r0, _020CA0A4 // =0x021471EC
	ldrh r2, [r4, #4]
	ldr r0, [r0]
	ldr r3, _020CA0AC // =0x00000881
	add r1, r0, #0x2140
	mov r0, #7
	bl WcmNotify
	ldmia sp!, {r4, lr}
	bx lr
_020CA078:
	mov r0, #0xb
	bl WcmSetPhase
	ldr r0, _020CA0A4 // =0x021471EC
	ldr r3, _020CA0B0 // =0x0000088C
	ldr r1, [r0]
	mov r0, #7
	add r1, r1, #0x2140
	mov r2, #0
	bl WcmNotify
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CA0A4: .word 0x021471EC
_020CA0A8: .word 0x00000872
_020CA0AC: .word 0x00000881
_020CA0B0: .word 0x0000088C
	arm_func_end WcmWmcbStartDCF

	arm_func_start WcmWmcbDisconnect
WcmWmcbDisconnect: // 0x020CA0B4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020CA164
_020CA0CC: // jump table
	b _020CA0E0 // case 0
	b _020CA14C // case 1
	b _020CA164 // case 2
	b _020CA14C // case 3
	b _020CA164 // case 4
_020CA0E0:
	ldr r0, _020CA194 // =0x021471EC
	ldr r1, [r0]
	add r0, r1, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #0xc
	bne _020CA110
	mov r0, #0xa
	bl WcmSetPhase
	bl WcmWmReset
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA110:
	add r1, r1, #0x2200
	mov r2, #0
	mov r0, #3
	strh r2, [r1, #0x82]
	bl WcmSetPhase
	ldr r1, _020CA194 // =0x021471EC
	mov r0, #0
	ldr r1, [r1]
	ldr r3, _020CA198 // =0x0000083D
	mov r2, r0
	add r1, r1, #0x2140
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA14C:
	mov r0, #0xa
	bl WcmSetPhase
	bl WcmWmReset
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA164:
	mov r0, #0xb
	bl WcmSetPhase
	ldr r0, _020CA194 // =0x021471EC
	ldr r3, _020CA19C // =0x0000084F
	ldr r1, [r0]
	mov r0, #7
	add r1, r1, #0x2140
	mov r2, #0
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CA194: .word 0x021471EC
_020CA198: .word 0x0000083D
_020CA19C: .word 0x0000084F
	arm_func_end WcmWmcbDisconnect

	arm_func_start WcmWmcbConnect
WcmWmcbConnect: // 0x020CA1A0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0xc
	addls pc, pc, r0, lsl #2
	b _020CA3E8
_020CA1B8: // jump table
	b _020CA1EC // case 0
	b _020CA3C0 // case 1
	b _020CA3E8 // case 2
	b _020CA3E8 // case 3
	b _020CA3E8 // case 4
	b _020CA3E8 // case 5
	b _020CA3D4 // case 6
	b _020CA3E8 // case 7
	b _020CA3E8 // case 8
	b _020CA3E8 // case 9
	b _020CA3E8 // case 10
	b _020CA3D4 // case 11
	b _020CA3D4 // case 12
_020CA1EC:
	ldrh r0, [r4, #8]
	cmp r0, #9
	bgt _020CA22C
	cmp r0, #0
	addge pc, pc, r0, lsl #2
	b _020CA394
_020CA204: // jump table
	b _020CA394 // case 0
	b _020CA394 // case 1
	b _020CA394 // case 2
	b _020CA394 // case 3
	b _020CA394 // case 4
	b _020CA394 // case 5
	b _020CA40C // case 6
	b _020CA2B4 // case 7
	b _020CA23C // case 8
	b _020CA23C // case 9
_020CA22C:
	cmp r0, #0x1a
	ldmeqia sp!, {r4, lr}
	bxeq lr
	b _020CA394
_020CA23C:
	ldr r1, _020CA414 // =0x021471EC
	ldr r2, [r1]
	add r0, r2, #0x2000
	ldr r0, [r0, #0x260]
	sub r0, r0, #8
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020CA40C
_020CA25C: // jump table
	b _020CA27C // case 0
	b _020CA28C // case 1
	b _020CA270 // case 2
	b _020CA40C // case 3
	b _020CA2A8 // case 4
_020CA270:
	add r0, r2, #0x2200
	mov r1, #0
	strh r1, [r0, #0x82]
_020CA27C:
	mov r0, #0xc
	bl WcmSetPhase
	ldmia sp!, {r4, lr}
	bx lr
_020CA28C:
	add r0, r2, #0x2200
	mov r2, #0
	strh r2, [r0, #0x82]
	ldr r0, [r1]
	mov r1, #6
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
_020CA2A8:
	bl WcmWmReset
	ldmia sp!, {r4, lr}
	bx lr
_020CA2B4:
	ldr r1, _020CA414 // =0x021471EC
	ldr r3, [r1]
	add r0, r3, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #0xc
	bne _020CA2E0
	mov r0, #8
	bl WcmSetPhase
	bl WcmWmReset
	ldmia sp!, {r4, lr}
	bx lr
_020CA2E0:
	ldrh r2, [r4, #0xa]
	cmp r2, #1
	blo _020CA388
	ldr r0, _020CA418 // =0x000007D7
	cmp r2, r0
	bhi _020CA388
	add r0, r3, #0x2200
	strh r2, [r0, #0x82]
	ldr r1, [r1]
	ldr r0, _020CA41C // =WcmWmcbStartDCF
	add r1, r1, #0x1500
	mov r2, #0x620
	bl WM_StartDCF
	cmp r0, #2
	ldmeqia sp!, {r4, lr}
	bxeq lr
	cmp r0, #3
	beq _020CA35C
	cmp r0, #8
	bne _020CA35C
	mov r0, #0xc
	bl WcmSetPhase
	ldr r0, _020CA414 // =0x021471EC
	ldr r3, _020CA420 // =0x000007ED
	ldr r1, [r0]
	mov r0, #1
	add r1, r1, #0x2140
	mov r2, #0
	bl WcmNotify
	ldmia sp!, {r4, lr}
	bx lr
_020CA35C:
	mov r0, #0xb
	bl WcmSetPhase
	ldr r0, _020CA414 // =0x021471EC
	ldr r3, _020CA424 // =0x000007F6
	ldr r1, [r0]
	mov r0, #7
	add r1, r1, #0x2140
	mov r2, #0
	bl WcmNotify
	ldmia sp!, {r4, lr}
	bx lr
_020CA388:
	bl WcmWmReset
	ldmia sp!, {r4, lr}
	bx lr
_020CA394:
	mov r0, #0xb
	bl WcmSetPhase
	ldr r0, _020CA414 // =0x021471EC
	ldrh r2, [r4, #8]
	ldr r0, [r0]
	ldr r3, _020CA428 // =0x00000804
	add r1, r0, #0x2140
	mov r0, #7
	bl WcmNotify
	ldmia sp!, {r4, lr}
	bx lr
_020CA3C0:
	ldr r0, _020CA414 // =0x021471EC
	ldrh r1, [r4, #0xe]
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0xf8]
_020CA3D4:
	mov r0, #8
	bl WcmSetPhase
	bl WcmWmReset
	ldmia sp!, {r4, lr}
	bx lr
_020CA3E8:
	mov r0, #0xb
	bl WcmSetPhase
	ldr r0, _020CA414 // =0x021471EC
	ldr r3, _020CA42C // =0x0000081B
	ldr r1, [r0]
	mov r0, #7
	add r1, r1, #0x2140
	mov r2, #0
	bl WcmNotify
_020CA40C:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CA414: .word 0x021471EC
_020CA418: .word 0x000007D7
_020CA41C: .word WcmWmcbStartDCF
_020CA420: .word 0x000007ED
_020CA424: .word 0x000007F6
_020CA428: .word 0x00000804
_020CA42C: .word 0x0000081B
	arm_func_end WcmWmcbConnect

	arm_func_start WcmWmcbEndScan
WcmWmcbEndScan: // 0x020CA430
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020CA494
_020CA448: // jump table
	b _020CA45C // case 0
	b _020CA484 // case 1
	b _020CA494 // case 2
	b _020CA494 // case 3
	b _020CA494 // case 4
_020CA45C:
	mov r0, #3
	bl WcmSetPhase
	mov r0, #0
	ldr r3, _020CA4BC // =0x00000783
	mov r1, r0
	mov r2, r0
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA484:
	bl WcmWmReset
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA494:
	mov r0, #0xb
	bl WcmSetPhase
	mov r1, #0
	ldr r3, _020CA4C0 // =0x00000793
	mov r2, r1
	mov r0, #7
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CA4BC: .word 0x00000783
_020CA4C0: .word 0x00000793
	arm_func_end WcmWmcbEndScan

	arm_func_start WcmWmcbScanEx
WcmWmcbScanEx: // 0x020CA4C4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r5, r0
	ldrh r0, [r5, #2]
	mov r4, #0x14
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020CA770
_020CA4E4: // jump table
	b _020CA4F8 // case 0
	b _020CA760 // case 1
	b _020CA770 // case 2
	b _020CA770 // case 3
	b _020CA770 // case 4
_020CA4F8:
	ldr r0, _020CA798 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #5
	bne _020CA52C
	mov r0, #6
	bl WcmSetPhase
	mov r0, #0
	ldr r3, _020CA79C // =0x00000704
	mov r1, r0
	mov r2, r0
	bl WcmNotify
_020CA52C:
	ldr r1, _020CA798 // =0x021471EC
	ldr r2, [r1]
	add r0, r2, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #6
	beq _020CA558
	cmp r0, #7
	beq _020CA6D0
	cmp r0, #0xd
	beq _020CA6E0
	b _020CA6F0
_020CA558:
	add r0, r2, #0x2200
	mov r2, #7
	strh r2, [r0, #0x80]
	ldrh r0, [r5, #8]
	cmp r0, #5
	bne _020CA5E4
	ldr r0, [r1]
	add r1, r0, #0x2200
	add r0, r0, #0x2000
	ldrh r1, [r1, #0x8c]
	ldr r0, [r0, #0x288]
	bl DC_InvalidateRange
	ldrh r0, [r5, #0xe]
	mov r4, #0
	cmp r0, #0
	ble _020CA5E4
	ldr r8, _020CA7A0 // =0x0000071A
	mov r6, r4
	mov r7, #7
_020CA5A4:
	add r0, r5, r4, lsl #1
	add r2, r5, r4, lsl #2
	ldrh r1, [r0, #0x50]
	ldr r0, [r2, #0x10]
	bl WCMi_EntryApList
	str r8, [sp]
	add r0, r5, r4, lsl #2
	ldr r2, [r0, #0x10]
	mov r0, r7
	mov r1, r6
	mov r3, r5
	bl WcmNotifyEx
	ldrh r0, [r5, #0xe]
	add r4, r4, #1
	cmp r4, r0
	blt _020CA5A4
_020CA5E4:
	ldr r0, _020CA798 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r1, [r0, #0x264]
	and r0, r1, #0xc00000
	cmp r0, #0xc00000
	bne _020CA650
	ldr r0, _020CA7A4 // =0x00003FFE
	and r0, r1, r0
	bl WcmCountBits
	movs r1, r0
	beq _020CA650
	ldr r0, _020CA798 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r6, [r0, #0x284]
	mov r0, r6
	bl _u32_div_f
	cmp r1, #0
	bne _020CA650
	ldr r4, _020CA7A8 // =0x00000728
	mov r1, #0
	mov r2, r6
	mov r3, r1
	mov r0, #8
	str r4, [sp]
	bl WcmNotifyEx
_020CA650:
	ldrh r0, [r5, #0xa]
	bl WcmCountLeadingZero
	rsb r0, r0, #0x20
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WcmGetNextScanChannel
	ldr r1, _020CA798 // =0x021471EC
	mov r2, #1
	mov r2, r2, lsl r0
	ldr r0, [r1]
	mov r2, r2, asr #1
	add r0, r0, #0x2200
	strh r2, [r0, #0x8e]
	ldr r0, [r1]
	add r1, r0, #0x2200
	add r0, r0, #0x2000
	ldrh r1, [r1, #0x8c]
	ldr r0, [r0, #0x288]
	bl DC_InvalidateRange
	ldr r3, _020CA798 // =0x021471EC
	ldr r2, _020CA7AC // =0x00002288
	ldr r1, [r3]
	ldr r0, _020CA7B0 // =WcmWmcbScanEx
	add r1, r1, #0x2000
	ldr r4, [r1, #0x284]
	add r4, r4, #1
	str r4, [r1, #0x284]
	ldr r1, [r3]
	add r1, r1, r2
	bl WM_StartScanEx
	mov r4, r0
	b _020CA6F0
_020CA6D0:
	ldr r0, _020CA7B4 // =WcmWmcbEndScan
	bl WM_EndScan
	mov r4, r0
	b _020CA6F0
_020CA6E0:
	bl WcmWmReset
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CA6F0:
	cmp r4, #2
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	cmp r4, #3
	beq _020CA738
	cmp r4, #8
	bne _020CA738
	mov r0, #0xc
	bl WcmSetPhase
	mov r1, #0
	ldr r3, _020CA7B8 // =0x00000753
	mov r2, r1
	mov r0, #1
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CA738:
	mov r0, #0xb
	bl WcmSetPhase
	mov r1, #0
	ldr r3, _020CA7BC // =0x0000075C
	mov r2, r1
	mov r0, #7
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CA760:
	bl WcmWmReset
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CA770:
	mov r0, #0xb
	bl WcmSetPhase
	mov r1, #0
	ldr r3, _020CA7C0 // =0x0000076D
	mov r2, r1
	mov r0, #7
	bl WcmNotify
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020CA798: .word 0x021471EC
_020CA79C: .word 0x00000704
_020CA7A0: .word 0x0000071A
_020CA7A4: .word 0x00003FFE
_020CA7A8: .word 0x00000728
_020CA7AC: .word 0x00002288
_020CA7B0: .word WcmWmcbScanEx
_020CA7B4: .word WcmWmcbEndScan
_020CA7B8: .word 0x00000753
_020CA7BC: .word 0x0000075C
_020CA7C0: .word 0x0000076D
	arm_func_end WcmWmcbScanEx

	arm_func_start WcmWmcbCommon
WcmWmcbCommon: // 0x020CA7C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r1, [r0, #2]
	mov r2, #0x14
	cmp r1, #4
	addls pc, pc, r1, lsl #2
	b _020CAA68
_020CA7E0: // jump table
	b _020CA7F4 // case 0
	b _020CAA28 // case 1
	b _020CAA68 // case 2
	b _020CAA68 // case 3
	b _020CAA68 // case 4
_020CA7F4:
	ldrh r0, [r0]
	cmp r0, #0x19
	bgt _020CA830
	cmp r0, #0x19
	bge _020CA910
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b _020CA988
_020CA814: // jump table
	b _020CA988 // case 0
	b _020CA988 // case 1
	b _020CA988 // case 2
	b _020CA850 // case 3
	b _020CA860 // case 4
	b _020CA8C4 // case 5
	b _020CA8EC // case 6
_020CA830:
	cmp r0, #0x1d
	bgt _020CA844
	cmp r0, #0x1d
	beq _020CA8FC
	b _020CA988
_020CA844:
	cmp r0, #0x27
	beq _020CA938
	b _020CA988
_020CA850:
	ldr r0, _020CAAA8 // =WcmWmcbCommon
	bl WM_PowerOn
	mov r2, r0
	b _020CA988
_020CA860:
	bl WM_Finish
	cmp r0, #0
	beq _020CA874
	cmp r0, #4
	b _020CA89C
_020CA874:
	mov r0, #1
	bl WcmSetPhase
	mov r0, #0
	ldr r3, _020CAAAC // =0x00000663
	mov r1, r0
	mov r2, r0
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA89C:
	mov r0, #0xb
	bl WcmSetPhase
	mov r1, #0
	ldr r3, _020CAAB0 // =0x0000066C
	mov r2, r1
	mov r0, #7
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA8C4:
	mov r0, #3
	bl WcmSetPhase
	mov r0, #0
	ldr r3, _020CAAB4 // =0x00000673
	mov r1, r0
	mov r2, r0
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA8EC:
	ldr r0, _020CAAA8 // =WcmWmcbCommon
	bl WM_Disable
	mov r2, r0
	b _020CA988
_020CA8FC:
	ldr r0, _020CAAA8 // =WcmWmcbCommon
	mov r1, #0
	bl WM_SetBeaconIndication
	mov r2, r0
	b _020CA988
_020CA910:
	ldr r1, _020CAAB8 // =0x021471EC
	ldr r0, _020CAAA8 // =WcmWmcbCommon
	ldr r3, [r1]
	add r2, r3, #0x2000
	ldrb r1, [r2, #0x250]
	ldrb r2, [r2, #0x251]
	add r3, r3, #0x2200
	bl WM_SetWEPKeyEx
	mov r2, r0
	b _020CA988
_020CA938:
	ldr r0, _020CAAB8 // =0x021471EC
	ldr r2, [r0]
	add r0, r2, #0x2000
	ldr r1, [r0, #0x264]
	and r0, r1, #0xc0000
	cmp r0, #0xc0000
	moveq r0, #1
	movne r0, #0
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	and r1, r1, #0x30000
	cmp r1, #0x30000
	movne r3, #1
	add r1, r2, #0x2140
	ldr r0, _020CAABC // =WcmWmcbConnect
	moveq r3, #0
	mov r2, #0
	str ip, [sp]
	bl WM_StartConnectEx
	mov r2, r0
_020CA988:
	cmp r2, #2
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	cmp r2, #3
	beq _020CA9E8
	cmp r2, #8
	bne _020CA9E8
	mov r0, #0xc
	bl WcmSetPhase
	ldr r0, _020CAAB8 // =0x021471EC
	ldr r3, _020CAAC0 // =0x000006AF
	ldr r1, [r0]
	mov r2, #0
	add r0, r1, #0x2200
	ldrsh r0, [r0, #0x80]
	cmp r0, #5
	addeq r1, r1, #0x2140
	movne r1, #0
	mov r0, #1
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA9E8:
	mov r0, #0xb
	bl WcmSetPhase
	ldr r0, _020CAAB8 // =0x021471EC
	ldr r3, _020CAAC4 // =0x000006B8
	ldr r1, [r0]
	mov r2, #0
	add r0, r1, #0x2200
	ldrsh r0, [r0, #0x80]
	cmp r0, #5
	addeq r1, r1, #0x2140
	movne r1, #0
	mov r0, #7
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CAA28:
	mov r0, #0xc
	bl WcmSetPhase
	ldr r0, _020CAAB8 // =0x021471EC
	ldr r3, _020CAAC8 // =0x000006DE
	ldr r1, [r0]
	mov r2, #0
	add r0, r1, #0x2200
	ldrsh r0, [r0, #0x80]
	cmp r0, #5
	addeq r1, r1, #0x2140
	movne r1, #0
	mov r0, #1
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CAA68:
	mov r0, #0xb
	bl WcmSetPhase
	ldr r0, _020CAAB8 // =0x021471EC
	ldr r3, _020CAACC // =0x000006E8
	ldr r1, [r0]
	mov r2, #0
	add r0, r1, #0x2200
	ldrsh r0, [r0, #0x80]
	cmp r0, #5
	addeq r1, r1, #0x2140
	movne r1, #0
	mov r0, #7
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CAAA8: .word WcmWmcbCommon
_020CAAAC: .word 0x00000663
_020CAAB0: .word 0x0000066C
_020CAAB4: .word 0x00000673
_020CAAB8: .word 0x021471EC
_020CAABC: .word WcmWmcbConnect
_020CAAC0: .word 0x000006AF
_020CAAC4: .word 0x000006B8
_020CAAC8: .word 0x000006DE
_020CAACC: .word 0x000006E8
	arm_func_end WcmWmcbCommon

	arm_func_start WcmWmcbIndication
WcmWmcbIndication: // 0x020CAAD0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r1, [r0, #2]
	cmp r1, #8
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldrh r1, [r0, #4]
	cmp r1, #0x16
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldrh r0, [r0, #6]
	cmp r0, #0x25
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldr r0, _020CAB80 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r0, [r0, #0x260]
	sub r0, r0, #8
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020CAB74
_020CAB34: // jump table
	b _020CAB48 // case 0
	b _020CAB5C // case 1
	b _020CAB6C // case 2
	b _020CAB74 // case 3
	b _020CAB5C // case 4
_020CAB48:
	mov r0, #0xc
	bl WcmSetPhase
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CAB5C:
	bl WcmWmReset
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CAB6C:
	mov r0, #0xc
	bl WcmSetPhase
_020CAB74:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CAB80: .word 0x021471EC
	arm_func_end WcmWmcbIndication

	arm_func_start WcmWmReset
WcmWmReset: // 0x020CAB84
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020CABF4 // =0x021471EC
	ldr r0, [r0]
	add r1, r0, #0x2000
	ldrb r0, [r1, #0x26b]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldr r0, _020CABF8 // =WcmWmcbReset
	mov r2, #1
	strb r2, [r1, #0x26b]
	bl WM_Reset
	cmp r0, #2
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	mov r0, #0xb
	bl WcmSetPhase
	mov r1, #0
	mov r2, r1
	mov r0, #7
	mov r3, #0x610
	bl WcmNotify
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CABF4: .word 0x021471EC
_020CABF8: .word WcmWmcbReset
	arm_func_end WcmWmReset

	arm_func_start WcmKeepAliveAlarm
WcmKeepAliveAlarm: // 0x020CABFC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WCMi_CpsifSendNullPacket
	bl WCMi_ResetKeepAliveAlarm
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end WcmKeepAliveAlarm

	arm_func_start WCMi_ResetKeepAliveAlarm
WCMi_ResetKeepAliveAlarm: // 0x020CAC18
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl OS_DisableInterrupts
	ldr r2, _020CAC84 // =0x021471EC
	ldr r1, _020CAC88 // =0x000022CC
	ldr r2, [r2]
	mov r4, r0
	add r0, r2, r1
	bl OS_CancelAlarm
	ldr r0, _020CAC84 // =0x021471EC
	ldr ip, [r0]
	add r0, ip, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #9
	bne _020CAC70
	ldr r0, _020CAC88 // =0x000022CC
	ldr r1, _020CAC8C // =0x022F5341
	mov r2, #0
	ldr r3, _020CAC90 // =WcmKeepAliveAlarm
	add r0, ip, r0
	str r2, [sp]
	bl OS_SetAlarm
_020CAC70:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CAC84: .word 0x021471EC
_020CAC88: .word 0x000022CC
_020CAC8C: .word 0x022F5341
_020CAC90: .word WcmKeepAliveAlarm
	arm_func_end WCMi_ResetKeepAliveAlarm

	arm_func_start WcmSetPhase
WcmSetPhase: // 0x020CAC94
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _020CAD2C // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	add r0, r1, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #9
	bne _020CACD4
	cmp r5, #9
	beq _020CACD4
	ldr r0, _020CAD30 // =0x000022CC
	add r0, r1, r0
	bl OS_CancelAlarm
_020CACD4:
	ldr r0, _020CAD2C // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r1, [r0, #0x260]
	cmp r1, #0xb
	strne r5, [r0, #0x260]
	cmp r5, #9
	bne _020CAD18
	mov r2, #0
	ldr r0, _020CAD2C // =0x021471EC
	str r2, [sp]
	ldr r5, [r0]
	ldr r0, _020CAD30 // =0x000022CC
	ldr r1, _020CAD34 // =0x022F5341
	ldr r3, _020CAD38 // =WcmKeepAliveAlarm
	add r0, r5, r0
	bl OS_SetAlarm
_020CAD18:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CAD2C: .word 0x021471EC
_020CAD30: .word 0x000022CC
_020CAD34: .word 0x022F5341
_020CAD38: .word WcmKeepAliveAlarm
	arm_func_end WcmSetPhase

	arm_func_start WcmNotifyEx
WcmNotifyEx: // 0x020CAD3C
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	ldr ip, _020CAD94 // =0x021471EC
	ldr ip, [ip]
	add ip, ip, #0x2000
	ldr lr, [ip, #0x27c]
	cmp lr, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {lr}
	bxeq lr
	ldr lr, [sp, #0x18]
	strh r0, [sp]
	str r2, [sp, #4]
	str r3, [sp, #8]
	str lr, [sp, #0xc]
	strh r1, [sp, #2]
	ldr r1, [ip, #0x27c]
	add r0, sp, #0
	blx r1
	add sp, sp, #0x14
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CAD94: .word 0x021471EC
	arm_func_end WcmNotifyEx

	arm_func_start WcmNotify
WcmNotify: // 0x020CAD98
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr ip, _020CADE4 // =0x021471EC
	mov r5, r0
	ldr r0, [ip]
	mov r4, r1
	add r1, r0, #0x2200
	ldrsh r0, [r1, #0x80]
	mov ip, #0
	mov lr, r2
	strh ip, [r1, #0x80]
	str r3, [sp]
	mov r1, r5
	mov r2, r4
	mov r3, lr
	bl WcmNotifyEx
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CADE4: .word 0x021471EC
	arm_func_end WcmNotify

	arm_func_start WcmGetNextScanChannel
WcmGetNextScanChannel: // 0x020CADE8
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _020CAE80 // =0x021471EC
	mov r2, r0
	ldr r1, [r1]
	mov r3, #0
	add r1, r1, #0x2000
	ldr r1, [r1, #0x264]
	mov r6, #1
	ldr r5, _020CAE84 // =0x4EC4EC4F
	ldr r4, _020CAE88 // =0x0000000D
_020CAE10:
	smull ip, lr, r5, r2
	mov lr, lr, asr #2
	mov ip, r2, lsr #0x1f
	add lr, ip, lr
	smull ip, lr, r4, lr
	sub lr, r2, ip
	add ip, lr, #1
	mov ip, r6, lsl ip
	ands ip, r1, ip
	bne _020CAE48
	add r3, r3, #1
	cmp r3, #0xd
	add r2, r2, #1
	blt _020CAE10
_020CAE48:
	ldr r1, _020CAE84 // =0x4EC4EC4F
	add r3, r0, r3
	smull r0, r4, r1, r3
	mov r4, r4, asr #2
	mov r0, r3, lsr #0x1f
	ldr r2, _020CAE88 // =0x0000000D
	add r4, r0, r4
	smull r0, r1, r2, r4
	sub r4, r3, r0
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020CAE80: .word 0x021471EC
_020CAE84: .word 0x4EC4EC4F
_020CAE88: .word 0x0000000D
	arm_func_end WcmGetNextScanChannel

	arm_func_start WcmInitOption
WcmInitOption: // 0x020CAE8C
	ldr r0, _020CAEA4 // =0x021471EC
	ldr r1, _020CAEA8 // =0x00AAA082
	ldr r0, [r0]
	add r0, r0, #0x2000
	str r1, [r0, #0x264]
	bx lr
	.align 2, 0
_020CAEA4: .word 0x021471EC
_020CAEA8: .word 0x00AAA082
	arm_func_end WcmInitOption

	arm_func_start WcmEditScanExParam
WcmEditScanExParam: // 0x020CAEAC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, r2
	mov r4, r1
	bl WCM_UpdateOption
	ldr r2, _020CB050 // =0x021471EC
	mov r3, #0x400
	ldr r1, [r2]
	mov r0, #0
	add ip, r1, #0x1500
	add r1, r1, #0x2000
	str ip, [r1, #0x288]
	ldr r1, [r2]
	add r1, r1, #0x2200
	strh r3, [r1, #0x8c]
	bl WcmGetNextScanChannel
	ldr r1, _020CB050 // =0x021471EC
	mov r2, #1
	mov r2, r2, lsl r0
	ldr r0, [r1]
	mov r2, r2, asr #1
	add r0, r0, #0x2200
	strh r2, [r0, #0x8e]
	ldr r0, [r1]
	add r0, r0, #0x2200
	ldrh r0, [r0, #0x68]
	cmp r0, #0
	bne _020CAF24
	bl WM_GetDispersionScanPeriod
_020CAF24:
	ldr r2, _020CB050 // =0x021471EC
	ldr r1, [r2]
	add r1, r1, #0x2200
	strh r0, [r1, #0x90]
	ldr r1, [r2]
	add r0, r1, #0x2000
	ldr r0, [r0, #0x264]
	and r0, r0, #0x300000
	cmp r0, #0x300000
	movne r2, #1
	moveq r2, #0
	add r0, r1, #0x2200
	strh r2, [r0, #0x98]
	cmp r5, #0
	bne _020CAF80
	ldr r0, _020CB050 // =0x021471EC
	ldr r1, _020CB054 // =0x00002292
	ldr r2, [r0]
	ldr r0, _020CB058 // =0x0211279C
	add r1, r2, r1
	mov r2, #6
	bl MI_CpuCopy8
	b _020CAF9C
_020CAF80:
	ldr r0, _020CB050 // =0x021471EC
	ldr r1, _020CB054 // =0x00002292
	ldr r2, [r0]
	mov r0, r5
	add r1, r2, r1
	mov r2, #6
	bl MI_CpuCopy8
_020CAF9C:
	cmp r4, #0
	beq _020CAFB0
	ldr r0, _020CB05C // =0x021127A4
	cmp r4, r0
	bne _020CAFE4
_020CAFB0:
	ldr r0, _020CB050 // =0x021471EC
	ldr r1, _020CB060 // =0x0000229C
	ldr r2, [r0]
	ldr r0, _020CB05C // =0x021127A4
	add r1, r2, r1
	mov r2, #0x20
	bl MI_CpuCopy8
	ldr r0, _020CB050 // =0x021471EC
	mov r1, #0
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x9a]
	b _020CB030
_020CAFE4:
	ldr r0, _020CB050 // =0x021471EC
	ldr r1, _020CB060 // =0x0000229C
	ldr r2, [r0]
	mov r0, r4
	add r1, r2, r1
	mov r2, #0x20
	bl MI_CpuCopy8
	mov r1, #0
_020CB004:
	ldrb r0, [r4]
	cmp r0, #0
	beq _020CB020
	add r1, r1, #1
	cmp r1, #0x20
	add r4, r4, #1
	blt _020CB004
_020CB020:
	ldr r0, _020CB050 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x9a]
_020CB030:
	ldr r0, _020CB050 // =0x021471EC
	mov r1, #0
	ldr r0, [r0]
	add r0, r0, #0x2000
	str r1, [r0, #0x284]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CB050: .word 0x021471EC
_020CB054: .word 0x00002292
_020CB058: .word 0x0211279C
_020CB05C: .word 0x021127A4
_020CB060: .word 0x0000229C
	arm_func_end WcmEditScanExParam

	arm_func_start WcmConfigure
WcmConfigure: // 0x020CB064
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r0
	mov r4, r1
	bne _020CB0B8
	ldr r1, _020CB190 // =0x021471EC
	mov r3, #3
	ldr r0, [r1]
	mov r2, #0
	add r0, r0, #0x2000
	str r3, [r0, #0x26c]
	ldr r0, [r1]
	add r0, r0, #0x2000
	str r2, [r0, #0x270]
	ldr r0, [r1]
	add r0, r0, #0x2000
	str r2, [r0, #0x274]
	ldr r0, [r1]
	add r0, r0, #0x2000
	str r2, [r0, #0x278]
	b _020CB174
_020CB0B8:
	ldr r1, _020CB190 // =0x021471EC
	ldr r2, [r5]
	ldr r0, [r1]
	and r2, r2, #3
	add r0, r0, #0x2000
	str r2, [r0, #0x26c]
	ldr r3, [r5, #4]
	ldr r0, [r5, #8]
	and r2, r3, #3
	rsb r2, r2, #4
	and r2, r2, #3
	add r2, r2, #0xc
	cmp r2, r0
	bls _020CB110
	ldr r0, [r1]
	mov r2, #0
	add r0, r0, #0x2000
	str r2, [r0, #0x270]
	ldr r0, [r1]
	add r0, r0, #0x2000
	str r2, [r0, #0x274]
	b _020CB160
_020CB110:
	ldr r0, [r1]
	add r2, r3, #3
	bic r2, r2, #3
	add r0, r0, #0x2000
	str r2, [r0, #0x270]
	ldr r2, [r5, #4]
	ldr r0, [r1]
	and r2, r2, #3
	rsb r2, r2, #4
	ldr r3, [r5, #8]
	and r2, r2, #3
	sub r2, r3, r2
	add r0, r0, #0x2000
	str r2, [r0, #0x274]
	ldr r0, [r1]
	mov r1, #0
	add r2, r0, #0x2000
	ldr r0, [r2, #0x270]
	ldr r2, [r2, #0x274]
	bl MI_CpuFill8
_020CB160:
	ldr r0, _020CB190 // =0x021471EC
	ldr r1, [r5, #0xc]
	ldr r0, [r0]
	add r0, r0, #0x2000
	str r1, [r0, #0x278]
_020CB174:
	ldr r0, _020CB190 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	str r4, [r0, #0x27c]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CB190: .word 0x021471EC
	arm_func_end WcmConfigure

	arm_func_start WCMi_GetSystemWork
WCMi_GetSystemWork: // 0x020CB194
	ldr r0, _020CB1A0 // =0x021471EC
	ldr r0, [r0]
	bx lr
	.align 2, 0
_020CB1A0: .word 0x021471EC
	arm_func_end WCMi_GetSystemWork

	arm_func_start WCM_UpdateOption
WCM_UpdateOption: // 0x020CB1A4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _020CB248 // =0x021471EC
	mov r2, #0
	ldr r1, [r1]
	add r3, r1, #0x2000
	cmp r1, #0
	ldr r4, [r3, #0x264]
	bne _020CB1E4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB1E4:
	ands r3, r5, #0x8000
	beq _020CB200
	ldr r3, _020CB24C // =0x00003FFE
	orr r2, r2, r3
	ands r3, r5, r3
	ldreq r3, _020CB250 // =0x0000A082
	orreq r5, r5, r3
_020CB200:
	ands r3, r5, #0x20000
	orrne r2, r2, #0x10000
	ands r3, r5, #0x80000
	orrne r2, r2, #0x40000
	ands r3, r5, #0x200000
	orrne r2, r2, #0x100000
	ands r3, r5, #0x800000
	orrne r2, r2, #0x400000
	mvn r2, r2
	and r2, r4, r2
	orr r2, r5, r2
	add r1, r1, #0x2000
	str r2, [r1, #0x264]
	bl OS_RestoreInterrupts
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CB248: .word 0x021471EC
_020CB24C: .word 0x00003FFE
_020CB250: .word 0x0000A082
	arm_func_end WCM_UpdateOption

	arm_func_start WCM_GetPhase
WCM_GetPhase: // 0x020CB254
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020CB284 // =0x021471EC
	mov r4, #0
	ldr r1, [r1]
	cmp r1, #0
	addne r1, r1, #0x2000
	ldrne r4, [r1, #0x260]
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CB284: .word 0x021471EC
	arm_func_end WCM_GetPhase

	arm_func_start WCM_TerminateAsync
WCM_TerminateAsync: // 0x020CB288
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	ldr r1, _020CB4D8 // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _020CB2BC
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB2BC:
	add r1, r1, #0x2000
	ldr r2, [r1, #0x260]
	cmp r2, #0xd
	addls pc, pc, r2, lsl #2
	b _020CB364
_020CB2D0: // jump table
	b _020CB364 // case 0
	b _020CB31C // case 1
	b _020CB364 // case 2
	b _020CB37C // case 3
	b _020CB364 // case 4
	b _020CB364 // case 5
	b _020CB330 // case 6
	b _020CB364 // case 7
	b _020CB364 // case 8
	b _020CB37C // case 9
	b _020CB364 // case 10
	b _020CB364 // case 11
	b _020CB37C // case 12
	b _020CB308 // case 13
_020CB308:
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB31C:
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB330:
	mov r0, #0xd
	bl WcmSetPhase
	ldr r1, _020CB4D8 // =0x021471EC
	mov r0, r4
	ldr r1, [r1]
	mov r2, #9
	add r1, r1, #0x2200
	strh r2, [r1, #0x80]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #3
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB364:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB37C:
	ldrb r0, [r1, #0x26b]
	cmp r0, #1
	bne _020CB3A8
	mov r0, #0xd
	bl WcmSetPhase
	ldr r0, _020CB4D8 // =0x021471EC
	mov r1, #9
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CB4C0
_020CB3A8:
	bl WMi_GetStatusAddress
	mov r5, r0
	mov r1, #2
	bl DC_InvalidateRange
	ldrh r0, [r5]
	cmp r0, #0
	beq _020CB3D8
	cmp r0, #1
	beq _020CB418
	cmp r0, #2
	beq _020CB424
	b _020CB430
_020CB3D8:
	bl WM_Finish
	cmp r0, #0
	bne _020CB44C
	mov r0, #1
	bl WcmSetPhase
	ldr r1, _020CB4D8 // =0x021471EC
	mov r0, r4
	ldr r1, [r1]
	mov r2, #0
	add r1, r1, #0x2200
	strh r2, [r1, #0x80]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB418:
	ldr r0, _020CB4DC // =WcmWmcbCommon
	bl WM_Disable
	b _020CB44C
_020CB424:
	ldr r0, _020CB4DC // =WcmWmcbCommon
	bl WM_PowerOff
	b _020CB44C
_020CB430:
	ldr r1, _020CB4D8 // =0x021471EC
	ldr r0, _020CB4E0 // =WcmWmcbReset
	ldr r1, [r1]
	mov r2, #1
	add r1, r1, #0x2000
	strb r2, [r1, #0x26b]
	bl WM_Reset
_020CB44C:
	cmp r0, #2
	beq _020CB468
	cmp r0, #3
	beq _020CB4A0
	cmp r0, #8
	beq _020CB488
	b _020CB4A0
_020CB468:
	mov r0, #0xd
	bl WcmSetPhase
	ldr r0, _020CB4D8 // =0x021471EC
	mov r1, #9
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CB4C0
_020CB488:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB4A0:
	mov r0, #0xb
	bl WcmSetPhase
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #7
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB4C0:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CB4D8: .word 0x021471EC
_020CB4DC: .word WcmWmcbCommon
_020CB4E0: .word WcmWmcbReset
	arm_func_end WCM_TerminateAsync

	arm_func_start WCM_DisconnectAsync
WCM_DisconnectAsync: // 0x020CB4E4
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020CB614 // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _020CB510
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020CB510:
	add r1, r1, #0x2000
	ldr r2, [r1, #0x260]
	cmp r2, #3
	beq _020CB540
	cmp r2, #9
	beq _020CB560
	cmp r2, #0xa
	bne _020CB550
	bl OS_RestoreInterrupts
	mov r0, #2
	ldmia sp!, {r4, lr}
	bx lr
_020CB540:
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
_020CB550:
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020CB560:
	ldrb r0, [r1, #0x26b]
	cmp r0, #1
	bne _020CB58C
	mov r0, #0xa
	bl WcmSetPhase
	ldr r0, _020CB614 // =0x021471EC
	mov r1, #6
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CB600
_020CB58C:
	ldr r0, _020CB618 // =WcmWmcbEndDCF
	bl WM_EndDCF
	cmp r0, #2
	beq _020CB5B0
	cmp r0, #3
	beq _020CB5E4
	cmp r0, #8
	beq _020CB5D0
	b _020CB5E4
_020CB5B0:
	mov r0, #0xa
	bl WcmSetPhase
	ldr r0, _020CB614 // =0x021471EC
	mov r1, #6
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CB600
_020CB5D0:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #4
	ldmia sp!, {r4, lr}
	bx lr
_020CB5E4:
	mov r0, #0xb
	bl WcmSetPhase
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, lr}
	bx lr
_020CB600:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CB614: .word 0x021471EC
_020CB618: .word WcmWmcbEndDCF
	arm_func_end WCM_DisconnectAsync

	arm_func_start WCM_ConnectAsync
WCM_ConnectAsync: // 0x020CB61C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl OS_DisableInterrupts
	ldr r2, _020CB870 // =0x021471EC
	mov r4, r0
	ldr ip, [r2]
	cmp ip, #0
	bne _020CB65C
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB65C:
	add r1, ip, #0x2000
	ldr r3, [r1, #0x260]
	cmp r3, #3
	beq _020CB680
	cmp r3, #8
	beq _020CB790
	cmp r3, #9
	beq _020CB7A4
	b _020CB7B8
_020CB680:
	cmp r7, #0
	bne _020CB69C
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB69C:
	ldrh r3, [r7, #0x3c]
	cmp r3, #0
	beq _020CB6BC
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB6BC:
	cmp r6, #0
	beq _020CB744
	ldrb r3, [r6]
	cmp r3, #4
	bhs _020CB6DC
	ldrb r0, [r6, #1]
	cmp r0, #4
	blo _020CB6F4
_020CB6DC:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB6F4:
	strb r3, [r1, #0x250]
	ldr r0, [r2]
	ldrb r1, [r6, #1]
	add r0, r0, #0x2000
	strb r1, [r0, #0x251]
	ldr r1, [r2]
	add r0, r1, #0x2000
	ldrb r0, [r0, #0x250]
	cmp r0, #0
	bne _020CB730
	add r0, r1, #0x2200
	mov r1, #0
	mov r2, #0x50
	bl MI_CpuFill8
	b _020CB754
_020CB730:
	add r0, r6, #2
	add r1, r1, #0x2200
	mov r2, #0x50
	bl MI_CpuCopy8
	b _020CB754
_020CB744:
	add r0, ip, #0x2200
	mov r1, #0
	mov r2, #0x52
	bl MI_CpuFill8
_020CB754:
	ldr r1, _020CB870 // =0x021471EC
	mov r0, r7
	ldr r1, [r1]
	mov r2, #0xc0
	add r1, r1, #0x2140
	bl MI_CpuCopy8
	ldr r1, _020CB870 // =0x021471EC
	mov r0, r5
	ldr r1, [r1]
	add r1, r1, #0x2100
	ldrh r2, [r1, #0x6e]
	orr r2, r2, #3
	strh r2, [r1, #0x70]
	bl WCM_UpdateOption
	b _020CB7CC
_020CB790:
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB7A4:
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB7B8:
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB7CC:
	ldr r1, _020CB874 // =0x0000FFFF
	ldr r0, _020CB878 // =WcmWmcbCommon
	mov r3, r1
	mov r2, #0x50
	str r1, [sp]
	bl WM_SetLifeTime
	cmp r0, #2
	beq _020CB800
	cmp r0, #3
	beq _020CB838
	cmp r0, #8
	beq _020CB820
	b _020CB838
_020CB800:
	mov r0, #8
	bl WcmSetPhase
	ldr r0, _020CB870 // =0x021471EC
	mov r1, #5
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CB858
_020CB820:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB838:
	mov r0, #0xb
	bl WcmSetPhase
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #7
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB858:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020CB870: .word 0x021471EC
_020CB874: .word 0x0000FFFF
_020CB878: .word WcmWmcbCommon
	arm_func_end WCM_ConnectAsync

	arm_func_start WCM_EndSearchAsync
WCM_EndSearchAsync: // 0x020CB87C
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020CB930 // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _020CB8A8
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020CB8A8:
	add r1, r1, #0x2000
	ldr r1, [r1, #0x260]
	cmp r1, #3
	beq _020CB8FC
	cmp r1, #6
	beq _020CB8CC
	cmp r1, #7
	beq _020CB8EC
	b _020CB90C
_020CB8CC:
	mov r0, #7
	bl WcmSetPhase
	ldr r0, _020CB930 // =0x021471EC
	mov r1, #4
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CB91C
_020CB8EC:
	bl OS_RestoreInterrupts
	mov r0, #2
	ldmia sp!, {r4, lr}
	bx lr
_020CB8FC:
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
_020CB90C:
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020CB91C:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CB930: .word 0x021471EC
	arm_func_end WCM_EndSearchAsync

	arm_func_start WCM_BeginSearchAsync
WCM_BeginSearchAsync: // 0x020CB934
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl OS_DisableInterrupts
	ldr r1, _020CBAE0 // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _020CB974
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB974:
	add r1, r1, #0x2000
	ldr r1, [r1, #0x260]
	cmp r1, #3
	beq _020CB9FC
	cmp r1, #5
	beq _020CB998
	cmp r1, #6
	beq _020CB9C0
	b _020CB9E8
_020CB998:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl WcmEditScanExParam
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB9C0:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl WcmEditScanExParam
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB9E8:
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB9FC:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl WcmEditScanExParam
	ldr r0, _020CBAE0 // =0x021471EC
	ldr r0, [r0]
	add r1, r0, #0x2200
	add r0, r0, #0x2000
	ldrh r1, [r1, #0x8c]
	ldr r0, [r0, #0x288]
	bl DC_InvalidateRange
	ldr r3, _020CBAE0 // =0x021471EC
	ldr r2, _020CBAE4 // =0x00002288
	ldr r1, [r3]
	ldr r0, _020CBAE8 // =WcmWmcbScanEx
	add r1, r1, #0x2000
	ldr r5, [r1, #0x284]
	add r5, r5, #1
	str r5, [r1, #0x284]
	ldr r1, [r3]
	add r1, r1, r2
	bl WM_StartScanEx
	cmp r0, #2
	beq _020CBA70
	cmp r0, #3
	beq _020CBAA8
	cmp r0, #8
	beq _020CBA90
	b _020CBAA8
_020CBA70:
	mov r0, #5
	bl WcmSetPhase
	ldr r0, _020CBAE0 // =0x021471EC
	mov r1, #3
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CBAC8
_020CBA90:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CBAA8:
	mov r0, #0xb
	bl WcmSetPhase
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #7
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CBAC8:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020CBAE0: .word 0x021471EC
_020CBAE4: .word 0x00002288
_020CBAE8: .word WcmWmcbScanEx
	arm_func_end WCM_BeginSearchAsync

	arm_func_start WCM_SearchAsync
WCM_SearchAsync: // 0x020CBAEC
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	beq _020CBB04
	cmp r1, #0
	bne _020CBB14
_020CBB04:
	bl WCM_EndSearchAsync
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CBB14:
	bl WCM_BeginSearchAsync
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end WCM_SearchAsync

	arm_func_start WCM_CleanupAsync
WCM_CleanupAsync: // 0x020CBB24
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020CBC28 // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _020CBB50
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020CBB50:
	add r1, r1, #0x2000
	ldr r1, [r1, #0x260]
	cmp r1, #1
	beq _020CBB80
	cmp r1, #3
	beq _020CBBA0
	cmp r1, #4
	bne _020CBB90
	bl OS_RestoreInterrupts
	mov r0, #2
	ldmia sp!, {r4, lr}
	bx lr
_020CBB80:
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
_020CBB90:
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020CBBA0:
	ldr r0, _020CBC2C // =WcmWmcbCommon
	bl WM_PowerOff
	cmp r0, #2
	beq _020CBBC4
	cmp r0, #3
	beq _020CBBF8
	cmp r0, #8
	beq _020CBBE4
	b _020CBBF8
_020CBBC4:
	mov r0, #4
	bl WcmSetPhase
	ldr r0, _020CBC28 // =0x021471EC
	mov r1, #2
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CBC14
_020CBBE4:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #4
	ldmia sp!, {r4, lr}
	bx lr
_020CBBF8:
	mov r0, #0xb
	bl WcmSetPhase
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, lr}
	bx lr
_020CBC14:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CBC28: .word 0x021471EC
_020CBC2C: .word WcmWmcbCommon
	arm_func_end WCM_CleanupAsync

	arm_func_start WCM_StartupAsync
WCM_StartupAsync: // 0x020CBC30
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl OS_DisableInterrupts
	ldr r1, _020CBE5C // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _020CBC64
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBC64:
	add r1, r1, #0x2000
	ldr r1, [r1, #0x260]
	cmp r1, #1
	beq _020CBC88
	cmp r1, #2
	beq _020CBC98
	cmp r1, #3
	beq _020CBCA8
	b _020CBCB8
_020CBC88:
	mov r0, r6
	mov r1, r5
	bl WcmConfigure
	b _020CBCC8
_020CBC98:
	bl OS_RestoreInterrupts
	mov r0, #2
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBCA8:
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBCB8:
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBCC8:
	ldr r0, _020CBE5C // =0x021471EC
	ldr r0, [r0]
	add r1, r0, #0x2000
	ldr r1, [r1, #0x26c]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl WM_Init
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b _020CBD3C
_020CBCF0: // jump table
	b _020CBD58 // case 0
	b _020CBD3C // case 1
	b _020CBD3C // case 2
	b _020CBD0C // case 3
	b _020CBD28 // case 4
	b _020CBD3C // case 5
	b _020CBD3C // case 6
_020CBD0C:
	mov r0, #0xb
	bl WcmSetPhase
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBD28:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #5
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBD3C:
	mov r0, #0xb
	bl WcmSetPhase
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBD58:
	bl WM_GetAllowedChannel
	cmp r0, #0
	bne _020CBDA0
	bl WM_Finish
	cmp r0, #0
	beq _020CBD8C
	mov r0, #0xb
	bl WcmSetPhase
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBD8C:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #5
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBDA0:
	ldr r0, _020CBE60 // =WcmWmcbIndication
	bl WM_SetIndCallback
	cmp r0, #0
	beq _020CBDCC
	mov r0, #0xb
	bl WcmSetPhase
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBDCC:
	ldr r0, _020CBE64 // =WcmWmcbCommon
	bl WM_Enable
	cmp r0, #2
	beq _020CBDF0
	cmp r0, #3
	beq _020CBE2C
	cmp r0, #8
	beq _020CBE10
	b _020CBE2C
_020CBDF0:
	mov r0, #2
	bl WcmSetPhase
	ldr r0, _020CBE5C // =0x021471EC
	mov r1, #1
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CBE48
_020CBE10:
	mov r0, #0xc
	bl WcmSetPhase
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBE2C:
	mov r0, #0xb
	bl WcmSetPhase
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBE48:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020CBE5C: .word 0x021471EC
_020CBE60: .word WcmWmcbIndication
_020CBE64: .word WcmWmcbCommon
	arm_func_end WCM_StartupAsync

	arm_func_start WCM_Finish
WCM_Finish: // 0x020CBE68
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	ldr r2, _020CBED8 // =0x021471EC
	ldr r1, [r2]
	cmp r1, #0
	bne _020CBE98
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {lr}
	bx lr
_020CBE98:
	add r1, r1, #0x2000
	ldr r1, [r1, #0x260]
	cmp r1, #1
	beq _020CBEBC
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {lr}
	bx lr
_020CBEBC:
	mov r1, #0
	str r1, [r2]
	bl OS_RestoreInterrupts
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CBED8: .word 0x021471EC
	arm_func_end WCM_Finish

	arm_func_start WCM_Init
WCM_Init: // 0x020CBEDC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl OS_DisableInterrupts
	ldr r2, _020CC004 // =0x021471EC
	mov r4, r0
	ldr r1, [r2]
	cmp r1, #0
	beq _020CBF10
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBF10:
	cmp r6, #0
	bne _020CBF28
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBF28:
	ands r1, r6, #0x1f
	beq _020CBF40
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBF40:
	cmp r5, #0x2300
	bhs _020CBF58
	bl OS_RestoreInterrupts
	mov r0, #6
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBF58:
	str r6, [r2]
	add r0, r6, #0x2000
	mov r1, #1
	str r1, [r0, #0x260]
	ldr r1, [r2]
	mov r0, #0
	add r1, r1, #0x2200
	strh r0, [r1, #0x80]
	ldr r1, [r2]
	add r1, r1, #0x2200
	strh r0, [r1, #0x68]
	ldr r1, [r2]
	add r1, r1, #0x2000
	strb r0, [r1, #0x26a]
	ldr r1, [r2]
	add r1, r1, #0x2000
	strb r0, [r1, #0x26b]
	ldr r1, [r2]
	add r1, r1, #0x2200
	strh r0, [r1, #0x82]
	ldr r1, [r2]
	add r1, r1, #0x2200
	strh r0, [r1, #0xf8]
	bl WcmInitOption
	bl WCMi_InitCpsif
	bl OS_IsTickAvailable
	cmp r0, #0
	bne _020CBFCC
	bl OS_InitTick
_020CBFCC:
	bl OS_IsAlarmAvailable
	cmp r0, #0
	bne _020CBFDC
	bl OS_InitAlarm
_020CBFDC:
	ldr r1, _020CC004 // =0x021471EC
	ldr r0, _020CC008 // =0x000022CC
	ldr r1, [r1]
	add r0, r1, r0
	bl OS_CreateAlarm
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020CC004: .word 0x021471EC
_020CC008: .word 0x000022CC
	arm_func_end WCM_Init
