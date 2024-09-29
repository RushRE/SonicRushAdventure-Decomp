	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start _DWC_BM_initPage
_DWC_BM_initPage: // 0x0208E164
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	add r1, r5, r4, lsl #8
	mov r0, #0
	mov r2, #0x100
	bl MIi_CpuClear16
	add r0, r5, r4, lsl #8
	mov r1, #0xff
	strb r1, [r0, #0xe7]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end _DWC_BM_initPage

	arm_func_start _DWC_BM_init
_DWC_BM_init: // 0x0208E198
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r7, r0
	mov r1, r7
	mov r0, #0
	mov r2, #0x400
	bl MIi_CpuClear16
	mov r2, #0
	mov r1, #0xff
_0208E1BC:
	add r0, r7, r2, lsl #8
	add r2, r2, #1
	strb r1, [r0, #0xe7]
	cmp r2, #3
	blt _0208E1BC
	add r0, sp, #0
	bl DWCi_AUTH_GetNewWiFiInfo
	add r0, sp, #0
	bl DWCi_BACKUPlConvWifiInfo
	mov r6, r0
	mov r5, #0
	mov r4, #0xe
_0208E1EC:
	mov r0, r6
	mov r2, r4
	add r1, r7, #0xf0
	bl MI_CpuCopy8
	add r5, r5, #1
	cmp r5, #2
	add r7, r7, #0x100
	blt _0208E1EC
	mov r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end _DWC_BM_init

	arm_func_start _DWC_BM_checkAp
_DWC_BM_checkAp: // 0x0208E218
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldrb r0, [r4, #0xe7]
	cmp r0, #0xff
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	cmp r0, #2
	addhi sp, sp, #8
	movhi r0, #0
	ldmhiia sp!, {r4, pc}
	add r0, r4, #0x40
	bl DWC_BACKUPlCheckSsid
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _0208E314 // =0x02112618
	add r0, r4, #0xc0
	mov r2, #4
	bl memcmp
	cmp r0, #0
	beq _0208E2C8
	add r0, r4, #0xc4
	bl DWC_BACKUPlCheckAddress
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldrb r0, [r4, #0xd0]
	cmp r0, #0x20
	addhi sp, sp, #8
	movhi r0, #0
	ldmhiia sp!, {r4, pc}
	add r1, sp, #0
	bl DWCi_BACKUPlConvMaskAddr
	add r1, sp, #0
	add r0, r4, #0xc0
	bl DWC_BACKUPlCheckIp
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
_0208E2C8:
	ldr r1, _0208E314 // =0x02112618
	add r0, r4, #0xc8
	mov r2, #4
	bl memcmp
	cmp r0, #0
	beq _0208E308
	add r0, r4, #0xc8
	bl DWC_BACKUPlCheckAddress
	cmp r0, #0
	bne _0208E308
	add r0, r4, #0xcc
	bl DWC_BACKUPlCheckAddress
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
_0208E308:
	mov r0, #1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208E314: .word 0x02112618
	arm_func_end _DWC_BM_checkAp

	arm_func_start DWC_BM_Init
DWC_BM_Init: // 0x0208E318
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	mov r10, r0
	mov r1, #0
	mov r2, #0x700
	bl MI_CpuFill8
	mov r0, r10
	bl DWCi_BACKUPlInit
	cmp r0, #0
	addeq sp, sp, #0x14
	ldreq r0, _0208E63C // =0xFFFFD8EF
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _0208E640 // =0x0000A001
	add r0, r10, #0x500
	bl MATHi_CRC16InitTableRev
	mov r0, r10
	bl DWCi_BACKUPlRead
	cmp r0, #0
	addeq sp, sp, #0x14
	ldreq r0, _0208E63C // =0xFFFFD8EF
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, sp, #0
	mov r1, #0
	mov r2, #0x10
	bl MI_CpuFill8
	mov r8, r10
	mov r7, r10
	mov r9, #0
	add r11, sp, #0
	add r6, r10, #0x500
	mov r4, #1
	mov r5, #0xfe
_0208E398:
	mov r0, r6
	mov r1, r8
	mov r2, r5
	bl MATH_CalcCRC16
	add r1, r10, r9, lsl #8
	ldrh r1, [r1, #0xfe]
	cmp r0, r1
	bne _0208E3C8
	mov r0, r7
	bl _DWC_BM_checkAp
	cmp r0, #0
	strne r4, [r11, r9, lsl #2]
_0208E3C8:
	add r9, r9, #1
	cmp r9, #3
	add r8, r8, #0x100
	add r7, r7, #0x100
	blt _0208E398
	add r0, r10, #0x500
	add r1, r10, #0x300
	mov r2, #0xfe
	bl MATH_CalcCRC16
	add r1, r10, #0x300
	ldrh r1, [r1, #0xfe]
	cmp r0, r1
	moveq r0, #1
	ldr r1, [sp]
	streq r0, [sp, #0xc]
	cmp r1, #0
	beq _0208E444
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _0208E444
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0208E444
	ldr r0, [sp, #0xc]
	cmp r0, #0
	beq _0208E444
	add r0, r10, #0xf0
	bl sub_208DDAC
	add sp, sp, #0x14
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208E444:
	cmp r1, #0
	bne _0208E494
	ldr r0, [sp, #4]
	cmp r0, #0
	bne _0208E494
	ldr r0, [sp, #8]
	cmp r0, #0
	bne _0208E494
	ldr r0, [sp, #0xc]
	cmp r0, #0
	bne _0208E494
	mov r0, r10
	bl _DWC_BM_init
	mov r0, r10
	bl sub_208DDC4
	cmp r0, #0
	movne r0, #0
	add sp, sp, #0x14
	ldreq r0, _0208E644 // =0xFFFFD8F0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208E494:
	cmp r1, #0
	beq _0208E4A8
	ldr r0, [sp, #4]
	cmp r0, #0
	bne _0208E4E4
_0208E4A8:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0208E4C0
	ldr r0, [sp, #0xc]
	cmp r0, #0
	bne _0208E4E4
_0208E4C0:
	mov r0, r10
	bl _DWC_BM_init
	mov r0, r10
	bl sub_208DDC4
	cmp r0, #0
	movne r0, #0
	add sp, sp, #0x14
	ldreq r0, _0208E644 // =0xFFFFD8F0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208E4E4:
	cmp r1, #0
	bne _0208E51C
	ldr r0, [sp, #4]
	cmp r0, #0
	bne _0208E51C
	mov r0, r10
	bl _DWC_BM_init
	mov r0, r10
	bl sub_208DDC4
	cmp r0, #0
	ldrne r0, _0208E648 // =0xFFFFD8ED
	add sp, sp, #0x14
	ldreq r0, _0208E644 // =0xFFFFD8F0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208E51C:
	cmp r1, #0
	bne _0208E54C
	mov r0, r10
	mov r1, #0
	bl _DWC_BM_initPage
	add r0, r10, #0x1f0
	add r1, r10, #0xf0
	mov r2, #0xe
	bl MI_CpuCopy8
	ldrb r0, [r10, #0x1ef]
	strb r0, [r10, #0xef]
	b _0208E57C
_0208E54C:
	ldr r0, [sp, #4]
	cmp r0, #0
	bne _0208E57C
	mov r0, r10
	mov r1, #1
	bl _DWC_BM_initPage
	add r0, r10, #0xf0
	add r1, r10, #0x1f0
	mov r2, #0xe
	bl MI_CpuCopy8
	ldrb r0, [r10, #0xef]
	strb r0, [r10, #0x1ef]
_0208E57C:
	add r0, r10, #0xf0
	bl sub_208DDAC
	ldr r0, [sp, #8]
	cmp r0, #0
	bne _0208E59C
	mov r0, r10
	mov r1, #2
	bl _DWC_BM_initPage
_0208E59C:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	bne _0208E5B8
	add r1, r10, #0x300
	mov r0, #0
	mov r2, #0x100
	bl MIi_CpuClear16
_0208E5B8:
	mov r4, #0
	mov r1, r4
	add r0, sp, #0
	add r5, r10, #0xef
	mov r6, #1
_0208E5CC:
	ldr r2, [r0, r1, lsl #2]
	cmp r2, #0
	bne _0208E604
	ldrb r2, [r10, #0xef]
	mov r7, r6, lsl r1
	ands r2, r2, r7
	beq _0208E604
	ldrb r3, [r5]
	mvn r2, r7
	mov r4, r6
	and r2, r3, r2
	strb r2, [r5]
	ldrb r2, [r10, #0xef]
	strb r2, [r10, #0x1ef]
_0208E604:
	add r1, r1, #1
	cmp r1, #3
	blt _0208E5CC
	mov r0, r10
	bl sub_208DDC4
	cmp r0, #0
	addeq sp, sp, #0x14
	ldreq r0, _0208E644 // =0xFFFFD8F0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r4, #0
	ldrne r0, _0208E64C // =0xFFFFD8EE
	moveq r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0208E63C: .word 0xFFFFD8EF
_0208E640: .word 0x0000A001
_0208E644: .word 0xFFFFD8F0
_0208E648: .word 0xFFFFD8ED
_0208E64C: .word 0xFFFFD8EE
	arm_func_end DWC_BM_Init
