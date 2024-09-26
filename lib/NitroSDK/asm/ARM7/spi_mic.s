	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public micw
micw: // 0x0380BB7C
	.space 0x3C

.public micIntrInfo
micIntrInfo: // 0x0380BBB8
	.space 0x10

	.text

	arm_func_start MicTimerHandler
MicTimerHandler: // 0x03806298
	stmdb sp!, {r4, r5, r6, r7, lr}
	ldr r4, _038063F0 // =micw
	ldrh r5, [r4, #0x26]
	and r0, r5, #4
	cmp r0, #4
	ldrh r6, [r4, #0x38]
	ldrneh r7, [r4, #0x3a]
	ldreq r7, _038063F4 // =0x0000FFFF
	bl SPIi_CheckEntry
	cmp r0, #0
	bne _03806304
	mov r0, #2
	bl SPIi_CheckException
	cmp r0, #0
	beq _03806304
	and r0, r5, #1
	cmp r0, #1
	bne _038062F4
	bl MIC_ExecSampling12
	tst r5, #2
	moveq r7, r0
	eorne r7, r0, #0x8000
	b _03806304
_038062F4:
	bl MIC_ExecSampling8
	tst r5, #2
	moveq r7, r0
	eorne r7, r0, #0x80
_03806304:
	and r0, r5, #1
	ldr r3, _038063F8 // =0x027FFC00
	ldr r1, [r4, #0x2c]
	cmp r0, #1
	bne _03806334
	ldr r2, [r4, #0x28]
	strh r7, [r2, r1]!
	str r2, [r3, #0x390]
	add r3, r3, #0x394
	strh r7, [r3]
	add r1, r1, #2
	b _0380636C
_03806334:
	and r7, r7, #0xff
	tst r1, #1
	bne _0380634C
	mov r6, r7
	add r1, r1, #1
	b _0380636C
_0380634C:
	orr r0, r6, r7, lsl #8
	ldr r2, [r4, #0x28]
	sub r1, r1, #1
	strh r0, [r2, r1]!
	str r2, [r3, #0x390]
	add r3, r3, #0x394
	strh r0, [r3]
	add r1, r1, #2
_0380636C:
	strh r6, [r4, #0x38]
	strh r7, [r4, #0x3a]
	ldr r0, [r4, #0x30]
	cmp r1, r0
	movhs r1, #0
	str r1, [r4, #0x2c]
	blo _038063E8
	ldrh r0, [r4, #0x24]
	and r0, r0, #0x10
	cmp r0, #0x10
	bne _038063A8
	mov r0, #0x51
	mov r1, #0
	bl SPIi_ReturnResult
	b _038063E8
_038063A8:
	mov r0, #2
	mov r1, #0x42
	mov r2, #0
	bl SPIi_SetEntry
	cmp r0, #0
	bne _038063D0
	mov r0, #0x51
	mov r1, #4
	bl SPIi_ReturnResult
	b _038063E8
_038063D0:
	mov r0, #4
	str r0, [r4, #0x20]
	ldr r1, _038063FC // =0x0400010E
	ldrh r0, [r1]
	bic r0, r0, #0x80
	strh r0, [r1]
_038063E8:
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_038063F0: .word micw
_038063F4: .word 0x0000FFFF
_038063F8: .word 0x027FFC00
_038063FC: .word 0x0400010E
	arm_func_end MicTimerHandler

	arm_func_start MIC_TimerHandler
MIC_TimerHandler: // 0x03806400
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl MicTimerHandler
	ldr r1, _03806434 // =0x0380FFF8
	ldr r0, [r1]
	orr r0, r0, #0x40
	str r0, [r1]
	mov r1, #0x40
	ldr r0, _03806438 // =0x04000214
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03806434: .word 0x0380FFF8
_03806438: .word 0x04000214
	arm_func_end MIC_TimerHandler

	arm_func_start MIC_ExecuteProcess
MIC_ExecuteProcess: // 0x0380643C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r2, [r5, #4]
	cmp r2, #0x40
	beq _03806468
	cmp r2, #0x41
	beq _03806534
	cmp r2, #0x42
	beq _038065D0
	b _03806674
_03806468:
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, #2
	bl SPIi_CheckException
	cmp r0, #0
	bne _038064A0
	mov r0, r4
	bl OS_RestoreInterrupts
	ldr r0, [r5, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #4
	bl SPIi_ReturnResult
	b _03806674
_038064A0:
	mov r0, #2
	bl SPIi_GetException
	mov r0, r4
	bl OS_RestoreInterrupts
	ldr r0, [r5, #8]
	and r0, r0, #1
	cmp r0, #1
	bne _038064EC
	bl MIC_ExecSampling12
	ldr r1, [r5, #8]
	ands r1, r1, #2
	eorne r0, r0, #0x8000
	movne r0, r0, lsl #0x10
	movne r0, r0, lsr #0x10
	ldr r1, _03806680 // =0x027FFF94
	strh r0, [r1]
	ldr r0, _03806684 // =0x027FFF90
	str r1, [r0]
	b _03806514
_038064EC:
	bl MIC_ExecSampling8
	ldr r1, [r5, #8]
	ands r1, r1, #2
	eorne r0, r0, #0x80
	movne r0, r0, lsl #0x10
	movne r0, r0, lsr #0x10
	ldr r1, _03806680 // =0x027FFF94
	strh r0, [r1]
	ldr r0, _03806684 // =0x027FFF90
	str r1, [r0]
_03806514:
	ldr r0, [r5, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl SPIi_ReturnResult
	mov r0, #2
	bl SPIi_ReleaseException
	b _03806674
_03806534:
	ldr r0, _03806688 // =micw
	ldr r1, [r0, #0x20]
	cmp r1, #1
	bne _038065BC
	mov r1, #0
	strh r1, [r0, #0x3a]
	strh r1, [r0, #0x38]
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, #0x40
	bl OS_EnableIrqMask
	mov r0, #0x40
	ldr r1, _0380668C // =MIC_TimerHandler
	bl MIC_SetIrqFunction
	bl MIC_EnableMultipleInterrupt
	ldr r0, _03806688 // =micw
	ldrh r2, [r0, #0x34]
	ldr r1, _03806690 // =0x0400010C
	strh r2, [r1]
	ldrh r0, [r0, #0x36]
	orr r1, r0, #0xc0
	ldr r0, _03806694 // =0x0400010E
	strh r1, [r0]
	mov r0, r4
	bl OS_RestoreInterrupts
	ldr r0, [r5, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl SPIi_ReturnResult
	mov r1, #2
	ldr r0, _03806688 // =micw
	str r1, [r0, #0x20]
	b _03806674
_038065BC:
	mov r0, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #3
	bl SPIi_ReturnResult
	b _03806674
_038065D0:
	ldr r0, _03806688 // =micw
	ldr r1, [r0, #0x20]
	sub r0, r1, #3
	cmp r0, #1
	bhi _03806650
	ldr r1, _03806694 // =0x0400010E
	ldrh r0, [r1]
	bic r0, r0, #0x80
	strh r0, [r1]
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, #0x40
	mov r1, #0
	bl MIC_SetIrqFunction
	bl MIC_DisableMultipleInterrupt
	mov r0, r4
	bl OS_RestoreInterrupts
	ldr r0, _03806688 // =micw
	ldr r0, [r0, #0x20]
	cmp r0, #3
	bne _03806634
	mov r0, #0x42
	mov r1, #0
	bl SPIi_ReturnResult
	b _03806640
_03806634:
	mov r0, #0x51
	mov r1, #0
	bl SPIi_ReturnResult
_03806640:
	mov r1, #0
	ldr r0, _03806688 // =micw
	str r1, [r0, #0x20]
	b _03806674
_03806650:
	cmp r1, #3
	bne _03806668
	mov r0, #0x42
	mov r1, #3
	bl SPIi_ReturnResult
	b _03806674
_03806668:
	mov r0, #0x51
	mov r1, #3
	bl SPIi_ReturnResult
_03806674:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_03806680: .word 0x027FFF94
_03806684: .word 0x027FFF90
_03806688: .word micw
_0380668C: .word MIC_TimerHandler
_03806690: .word 0x0400010C
_03806694: .word 0x0400010E
	arm_func_end MIC_ExecuteProcess

	arm_func_start MicSetTimerValue
MicSetTimerValue: // 0x03806698
	cmp r0, #0x10000
	bhs _038066BC
	mov r2, #0
	ldr r1, _03806738 // =micw
	strh r2, [r1, #0x36]
	rsb r0, r0, #0x10000
	strh r0, [r1, #0x34]
	mov r0, #1
	bx lr
_038066BC:
	cmp r0, #0x400000
	bhs _038066E4
	mov r2, #1
	ldr r1, _03806738 // =micw
	strh r2, [r1, #0x36]
	mov r0, r0, lsr #6
	rsb r0, r0, #0x10000
	strh r0, [r1, #0x34]
	mov r0, r2
	bx lr
_038066E4:
	cmp r0, #0x1000000
	bhs _0380670C
	mov r2, #2
	ldr r1, _03806738 // =micw
	strh r2, [r1, #0x36]
	mov r0, r0, lsr #8
	rsb r0, r0, #0x10000
	strh r0, [r1, #0x34]
	mov r0, #1
	bx lr
_0380670C:
	cmp r0, #0x4000000
	movhs r0, #0
	bxhs lr
	mov r2, #3
	ldr r1, _03806738 // =micw
	strh r2, [r1, #0x36]
	mov r0, r0, lsr #0xa
	rsb r0, r0, #0x10000
	strh r0, [r1, #0x34]
	mov r0, #1
	bx lr
	.align 2, 0
_03806738: .word micw
	arm_func_end MicSetTimerValue

	arm_func_start MIC_AnalyzeCommand
MIC_AnalyzeCommand: // 0x0380673C
	stmdb sp!, {r4, lr}
	ands r1, r0, #0x2000000
	beq _03806768
	mov r4, #0
	mov r3, r4
	ldr r1, _038069FC // =micw
_03806754:
	mov r2, r4, lsl #1
	strh r3, [r1, r2]
	add r4, r4, #1
	cmp r4, #0x10
	blt _03806754
_03806768:
	and r1, r0, #0xf0000
	mov r1, r1, lsr #0x10
	mov r2, r1, lsl #1
	ldr r1, _038069FC // =micw
	strh r0, [r1, r2]
	ands r0, r0, #0x1000000
	beq _038069F4
	ldrh r3, [r1]
	and r0, r3, #0xff00
	mov r0, r0, lsl #8
	mov r4, r0, lsr #0x10
	sub r0, r4, #0x40
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _038069E8
_038067A4: // jump table
	b _038067B4 // case 0
	b _038067F4 // case 1
	b _038068FC // case 2
	b _03806960 // case 3
_038067B4:
	mov r0, #2
	mov r1, r4
	mov r2, #1
	and r3, r3, #0xff
	bl SPIi_SetEntry
	cmp r0, #0
	bne _038067DC
	mov r0, r4
	mov r1, #4
	bl SPIi_ReturnResult
_038067DC:
	mov r1, #0
	ldr r0, _03806A00 // =0x027FFF94
	strh r1, [r0]
	ldr r0, _03806A04 // =0x027FFF90
	str r1, [r0]
	b _038069F4
_038067F4:
	ldr r0, [r1, #0x20]
	cmp r0, #0
	beq _03806810
	mov r0, r4
	mov r1, #3
	bl SPIi_ReturnResult
	b _038069F4
_03806810:
	and r0, r3, #0xff
	strh r0, [r1, #0x24]
	ldrh r2, [r1, #2]
	ldrh r0, [r1, #4]
	orr r3, r0, r2, lsl #16
	cmp r3, #0x2000000
	blo _03806834
	cmp r3, #0x2400000
	blo _03806844
_03806834:
	mov r0, r4
	mov r1, #2
	bl SPIi_ReturnResult
	b _038069F4
_03806844:
	str r3, [r1, #0x28]
	ldrh r2, [r1, #6]
	ldrh r0, [r1, #8]
	orr r2, r0, r2, lsl #16
	add r0, r3, r2
	cmp r0, #0x2400000
	bls _03806870
	mov r0, r4
	mov r1, #2
	bl SPIi_ReturnResult
	b _038069F4
_03806870:
	str r2, [r1, #0x30]
	ldrh r2, [r1, #0xa]
	ldrh r0, [r1, #0xc]
	orr r0, r0, r2, lsl #16
	bl MicSetTimerValue
	cmp r0, #0
	bne _0380689C
	mov r0, r4
	mov r1, #2
	bl SPIi_ReturnResult
	b _038069F4
_0380689C:
	mov r2, #0
	ldr r0, _038069FC // =micw
	str r2, [r0, #0x2c]
	ldrh r1, [r0, #0x24]
	and r1, r1, #7
	strh r1, [r0, #0x26]
	mov r0, #2
	mov r1, r4
	bl SPIi_SetEntry
	cmp r0, #0
	bne _038068D8
	mov r0, r4
	mov r1, #4
	bl SPIi_ReturnResult
	b _038069F4
_038068D8:
	mov r1, #0
	ldr r0, _03806A00 // =0x027FFF94
	strh r1, [r0]
	ldr r0, _03806A04 // =0x027FFF90
	str r1, [r0]
	mov r1, #1
	ldr r0, _038069FC // =micw
	str r1, [r0, #0x20]
	b _038069F4
_038068FC:
	ldr r0, [r1, #0x20]
	cmp r0, #2
	beq _03806918
	mov r0, r4
	mov r1, #3
	bl SPIi_ReturnResult
	b _038069F4
_03806918:
	mov r0, #2
	mov r1, r4
	mov r2, #0
	bl SPIi_SetEntry
	cmp r0, #0
	bne _03806940
	mov r0, r4
	mov r1, #4
	bl SPIi_ReturnResult
	b _038069F4
_03806940:
	mov r1, #3
	ldr r0, _038069FC // =micw
	str r1, [r0, #0x20]
	ldr r1, _03806A08 // =0x0400010E
	ldrh r0, [r1]
	bic r0, r0, #0x80
	strh r0, [r1]
	b _038069F4
_03806960:
	ldr r0, [r1, #0x20]
	cmp r0, #2
	beq _0380697C
	mov r0, r4
	mov r1, #3
	bl SPIi_ReturnResult
	b _038069F4
_0380697C:
	ldrh r2, [r1, #2]
	ldrh r0, [r1, #4]
	orr r0, r0, r2, lsl #16
	bl MicSetTimerValue
	cmp r0, #0
	bne _038069A4
	mov r0, r4
	mov r1, #2
	bl SPIi_ReturnResult
	b _038069F4
_038069A4:
	bl OS_DisableInterrupts
	ldr ip, _03806A08 // =0x0400010E
	ldrh r1, [ip]
	bic r1, r1, #0x80
	strh r1, [ip]
	ldr r1, _038069FC // =micw
	ldrh r3, [r1, #0x34]
	ldr r2, _03806A0C // =0x0400010C
	strh r3, [r2]
	ldrh r1, [r1, #0x36]
	orr r1, r1, #0xc0
	strh r1, [ip]
	bl OS_RestoreInterrupts
	mov r0, r4
	mov r1, #0
	bl SPIi_ReturnResult
	b _038069F4
_038069E8:
	mov r0, r4
	mov r1, #1
	bl SPIi_ReturnResult
_038069F4:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_038069FC: .word micw
_03806A00: .word 0x027FFF94
_03806A04: .word 0x027FFF90
_03806A08: .word 0x0400010E
_03806A0C: .word 0x0400010C
	arm_func_end MIC_AnalyzeCommand

	arm_func_start MIC_Init
MIC_Init: // 0x03806A10
	mov r3, #0
	ldr r0, _03806A48 // =micw
	str r3, [r0, #0x20]
	mov r2, r3
_03806A20:
	mov r1, r3, lsl #1
	strh r2, [r0, r1]
	add r3, r3, #1
	cmp r3, #0x10
	blt _03806A20
	ldr r1, _03806A4C // =0x0400010E
	ldrh r0, [r1]
	bic r0, r0, #0x80
	strh r0, [r1]
	bx lr
	.align 2, 0
_03806A48: .word micw
_03806A4C: .word 0x0400010E
	arm_func_end MIC_Init

	arm_func_start MIC_ExecSampling12
MIC_ExecSampling12: // 0x03806A50
	ldr r1, _03806B04 // =0x040001C0
_03806A54:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _03806A54
	ldr r0, _03806B08 // =0x00008A01
	strh r0, [r1]
	mov r1, #0xe4
	ldr r0, _03806B0C // =0x040001C2
	strh r1, [r0]
	ldr r1, _03806B04 // =0x040001C0
_03806A78:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _03806A78
	mov r1, #0
	ldr r0, _03806B0C // =0x040001C2
	strh r1, [r0]
	ldr r2, _03806B04 // =0x040001C0
_03806A94:
	ldrh r0, [r2]
	ands r0, r0, #0x80
	bne _03806A94
	ldr r1, _03806B0C // =0x040001C2
	ldrh r0, [r1]
	and r0, r0, #0xff
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x18
	mov r3, r0, lsr #0x10
	ldr r0, _03806B10 // =0x00008201
	strh r0, [r2]
	mov r0, #0
	strh r0, [r1]
	ldr r1, _03806B04 // =0x040001C0
_03806AD0:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _03806AD0
	ldr r0, _03806B0C // =0x040001C2
	ldrh r0, [r0]
	and r0, r0, #0xff
	mov r0, r0, lsl #0x10
	orr r1, r3, r0, lsr #16
	ldr r0, _03806B14 // =0x00007FF8
	and r0, r1, r0
	mov r0, r0, lsl #0x11
	mov r0, r0, lsr #0x10
	bx lr
	.align 2, 0
_03806B04: .word 0x040001C0
_03806B08: .word 0x00008A01
_03806B0C: .word 0x040001C2
_03806B10: .word 0x00008201
_03806B14: .word 0x00007FF8
	arm_func_end MIC_ExecSampling12

	arm_func_start MIC_ExecSampling8
MIC_ExecSampling8: // 0x03806B18
	ldr r1, _03806BCC // =0x040001C0
_03806B1C:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _03806B1C
	ldr r0, _03806BD0 // =0x00008A01
	strh r0, [r1]
	mov r1, #0xec
	ldr r0, _03806BD4 // =0x040001C2
	strh r1, [r0]
	ldr r1, _03806BCC // =0x040001C0
_03806B40:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _03806B40
	mov r1, #0
	ldr r0, _03806BD4 // =0x040001C2
	strh r1, [r0]
	ldr r2, _03806BCC // =0x040001C0
_03806B5C:
	ldrh r0, [r2]
	ands r0, r0, #0x80
	bne _03806B5C
	ldr r1, _03806BD4 // =0x040001C2
	ldrh r0, [r1]
	and r0, r0, #0xff
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x18
	mov r3, r0, lsr #0x10
	ldr r0, _03806BD8 // =0x00008201
	strh r0, [r2]
	mov r0, #0
	strh r0, [r1]
	ldr r1, _03806BCC // =0x040001C0
_03806B98:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _03806B98
	ldr r0, _03806BD4 // =0x040001C2
	ldrh r0, [r0]
	and r0, r0, #0xff
	mov r0, r0, lsl #0x10
	orr r1, r3, r0, lsr #16
	ldr r0, _03806BDC // =0x00007F80
	and r0, r1, r0
	mov r0, r0, lsl #9
	mov r0, r0, lsr #0x10
	bx lr
	.align 2, 0
_03806BCC: .word 0x040001C0
_03806BD0: .word 0x00008A01
_03806BD4: .word 0x040001C2
_03806BD8: .word 0x00008201
_03806BDC: .word 0x00007F80
	arm_func_end MIC_ExecSampling8

	arm_func_start MIC_IrqHandler
MIC_IrqHandler: // 0x03806BE0
	mov ip, #0x4000000
	add r1, ip, #0x208
	ldrh r0, [r1]
	tst r0, r0
	bxeq lr
	ldr r3, [ip, #0x210]
	ldr r1, [ip, #0x214]
	ands r2, r1, r3
	bxeq lr
	ldr r0, _03806D4C // =0x01DF3FFF
	tst r2, r0
	streq r2, [ip, #0x214]
	bxeq lr
	stmdb sp!, {lr}
	mrs r0, spsr
	stmdb sp!, {r0}
	stmdb sp, {sp, lr} ^
	sub sp, sp, #8
	mov r0, #0x9f
	msr cpsr_c, r0
	ldr r1, _03806D50 // =OSi_ThreadInfo
	ldrh r0, [r1, #2]
	add r0, r0, #1
	strh r0, [r1, #2]
	ldr r1, _03806D54 // =micIntrInfo
	cmp r0, #1
	moveq r0, sp
	ldreq sp, [r1, #4]
	streq r0, [r1, #4]
	stmdb sp!, {r3}
	ldr r1, _03806D58 // =0x03807F60
	ldr r0, [r1]
	tst r0, r2
	strne r0, [ip, #0x214]
	ldrne r0, [r1, #4]
	ldrne r3, _03806D5C // =OS_IRQTable
	ldrne r0, [r3, r0, lsl #2]
	bne _03806CBC
	mov r3, #1
_03806C7C:
	ldr r0, [r1, r3, lsl #3]
	tst r0, r2
	addeq r3, r3, #1
	beq _03806C7C
	str r0, [ip, #0x214]
	add r0, r1, r3, lsl #3
	ldr r2, [r0, #4]
	ldr r3, _03806D5C // =OS_IRQTable
	ldr r0, [r3, r2, lsl #2]
	ldr r2, _03806D50 // =OSi_ThreadInfo
	ldrh r3, [r2, #2]
	cmp r3, #1
	ldreq r2, [r1]
	streq r2, [ip, #0x210]
	moveq r2, #0x1f
	msreq cpsr_c, r2
_03806CBC:
	ldr r1, [ip, #0x210]
	stmdb sp!, {r1}
	add lr, pc, #0x0 // =_3806CCC
	bx r0
_3806CCC: // 0x03806CCC
	mov r0, #0x9f
	msr cpsr_c, r0
	mov ip, #0x4000000
	ldmia sp!, {r0}
	ldr r1, [ip, #0x210]
	eor r2, r0, r1
	and r1, r2, r1
	and r0, r2, r0
	ldmia sp!, {r3}
	orr r3, r3, r1
	bic r3, r3, r0
	str r3, [ip, #0x210]
	ldr r2, _03806D50 // =OSi_ThreadInfo
	ldr r3, _03806D54 // =micIntrInfo
	ldrh r0, [r2, #2]
	subs r1, r0, #1
	strh r1, [r2, #2]
	moveq r0, sp
	ldreq sp, [r3, #4]
	streq r0, [r3, #4]
	mov r0, #0x92
	msr cpsr_c, r0
	ldmia sp, {sp, lr} ^
	mov r0, r0
	add sp, sp, #8
	ldmia sp!, {r0}
	msr spsr_fc, r0
	tst r1, r1
	ldreq r0, _03806D60 // =OS_IrqHandler_ThreadSwitch
	addeq lr, pc, #0x0 // =0x03806D48
	bxeq r0
	ldmia sp!, {pc}
	.align 2, 0
_03806D4C: .word 0x01DF3FFF
_03806D50: .word OSi_ThreadInfo
_03806D54: .word micIntrInfo
_03806D58: .word 0x03807F60
_03806D5C: .word OS_IRQTable
_03806D60: .word OS_IrqHandler_ThreadSwitch
	arm_func_end MIC_IrqHandler

	arm_func_start MIC_DisableMultipleInterrupt
MIC_DisableMultipleInterrupt: // 0x03806D64
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _03806DA4 // =0x0380FFFC
	ldr r1, [r0]
	ldr r0, _03806DA8 // =MIC_IrqHandler
	cmp r1, r0
	bne _03806D98
	bl OS_DisableInterrupts
	ldr r1, _03806DAC // =micIntrInfo
	ldr r2, [r1, #0xc]
	ldr r1, _03806DA4 // =0x0380FFFC
	str r2, [r1]
	bl OS_RestoreInterrupts
_03806D98:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03806DA4: .word 0x0380FFFC
_03806DA8: .word MIC_IrqHandler
_03806DAC: .word micIntrInfo
	arm_func_end MIC_DisableMultipleInterrupt

	arm_func_start MIC_EnableMultipleInterrupt
MIC_EnableMultipleInterrupt: // 0x03806DB0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _03806E0C // =0x0380FFFC
	ldr r2, [r0]
	ldr r0, _03806E10 // =MIC_IrqHandler
	cmp r2, r0
	beq _03806E00
	mov r1, #0
	ldr r0, _03806E14 // =micIntrInfo
	str r1, [r0]
	ldr r1, _03806E18 // =0x0380FE80
	str r1, [r0, #4]
	mov r1, #0x40
	str r1, [r0, #8]
	str r2, [r0, #0xc]
	bl OS_DisableInterrupts
	ldr r2, _03806E10 // =MIC_IrqHandler
	ldr r1, _03806E0C // =0x0380FFFC
	str r2, [r1]
	bl OS_RestoreInterrupts
_03806E00:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03806E0C: .word 0x0380FFFC
_03806E10: .word MIC_IrqHandler
_03806E14: .word micIntrInfo
_03806E18: .word 0x0380FE80
	arm_func_end MIC_EnableMultipleInterrupt

	arm_func_start MIC_SetIrqFunction
MIC_SetIrqFunction: // 0x03806E1C
	mov ip, #0
	ldr r2, _03806E40 // =OS_IRQTable
_03806E24:
	ands r3, r0, #1
	strne r1, [r2, ip, lsl #2]
	mov r0, r0, lsr #1
	add ip, ip, #1
	cmp ip, #0x19
	blt _03806E24
	bx lr
	.align 2, 0
_03806E40: .word OS_IRQTable
	arm_func_end MIC_SetIrqFunction