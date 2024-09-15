	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CARD_GetRomHeader
CARD_GetRomHeader: // 0x03803330
	ldr r0, _03803338 // =0x027FFA80
	bx lr
	.align 2, 0
_03803338: .word 0x027FFA80
	arm_func_end CARD_GetRomHeader

	arm_func_start CARD_SetThreadPriority
CARD_SetThreadPriority: // 0x0380333C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r6, _03803380 // =0x03809DE0
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r5, [r6, #0xf0]
	str r7, [r6, #0xf0]
	add r0, r6, #0x48
	ldr r1, [r6, #0xf0]
	bl OS_YieldThread
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_03803380: .word 0x03809DE0
	arm_func_end CARD_SetThreadPriority

	arm_func_start CARD_Enable
CARD_Enable: // 0x03803384
	ldr r1, _03803390 // =0x03809DC4
	str r0, [r1]
	bx lr
	.align 2, 0
_03803390: .word 0x03809DC4
	arm_func_end CARD_Enable

	arm_func_start CARDi_InitCommon
CARDi_InitCommon: // 0x03803394
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mvn r1, #2
	ldr r0, _0380342C // =0x03809DE0
	str r1, [r0, #0xc]
	mov r2, #0
	str r2, [r0, #0x10]
	str r2, [r0, #0x1c]
	str r2, [r0]
	str r2, [r0, #8]
	str r2, [r0, #0x18]
	str r2, [r0, #0x14]
	str r2, [r0, #0xf8]
	str r2, [r0, #0xf4]
	mov r1, #4
	str r1, [r0, #0xf0]
	mov r1, #0x400
	str r1, [sp]
	ldr r0, [r0, #0xf0]
	str r0, [sp, #4]
	ldr r0, _03803430 // =0x03809E28
	ldr r1, _03803434 // =CARDi_TaskThread
	ldr r3, _03803438 // =0x0380A400
	bl OS_CreateThread
	ldr r0, _03803430 // =0x03809E28
	bl OS_WakeupThreadDirect
	mov r0, #0xb
	ldr r1, _0380343C // =CARDi_OnFifoRecv
	bl PXI_SetFifoRecvCallback
	ldr r0, _03803440 // =0x027FFC40
	ldrh r0, [r0]
	cmp r0, #2
	beq _03803420
	mov r0, #1
	bl CARD_Enable
_03803420:
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_0380342C: .word 0x03809DE0
_03803430: .word 0x03809E28
_03803434: .word CARDi_TaskThread
_03803438: .word 0x0380A400
_0380343C: .word CARDi_OnFifoRecv
_03803440: .word 0x027FFC40
	arm_func_end CARDi_InitCommon

	arm_func_start CARDi_SetWriteProtectCore
CARDi_SetWriteProtectCore: // 0x03803444
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	mov r4, r0
	bl CARDi_WaitPrevCommand
	cmp r0, #0
	beq _038034CC
	ldr r0, _038034D8 // =0x03809DE0
	ldr r10, [r0]
	mov r9, #0xa
	mov r0, #1
	strb r0, [sp]
	strb r4, [sp, #1]
	mov r8, #2
	add r7, sp, #0
	mov r6, #0
	ldr r5, _038034DC // =sub_3803A70
	mov r4, #5
_03803488:
	bl CARDi_WriteEnable
	mov r0, r8
	bl CARDi_CommandBegin
	mov r0, r7
	mov r1, r6
	mov r2, r8
	mov r3, r5
	bl CARDi_CommArray
	mov r0, r4
	mov r1, r6
	bl CARDi_CommandEnd
	ldr r0, [r10]
	cmp r0, #4
	bne _038034CC
	sub r9, r9, #1
	cmp r9, #0
	bgt _03803488
_038034CC:
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_038034D8: .word 0x03809DE0
_038034DC: .word sub_3803A70
	arm_func_end CARDi_SetWriteProtectCore

	arm_func_start CARDi_EraseChipCore
CARDi_EraseChipCore: // 0x038034E0
	stmdb sp!, {r4, lr}
	bl CARDi_WaitPrevCommand
	cmp r0, #0
	beq _03803524
	ldr r0, _0380352C // =0x03809DE0
	ldr r4, [r0]
	bl CARDi_WriteEnable
	mov r0, #1
	bl CARDi_CommandBegin
	ldr r0, _03803530 // =0x03807F54
	mov r1, #0
	mov r2, #1
	ldr r3, _03803534 // =sub_3803A70
	bl CARDi_CommArray
	ldr r0, [r4, #0x34]
	ldr r1, [r4, #0x38]
	bl CARDi_CommandEnd
_03803524:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_0380352C: .word 0x03809DE0
_03803530: .word 0x03807F54
_03803534: .word sub_3803A70
	arm_func_end CARDi_EraseChipCore

	arm_func_start CARDi_EraseBackupSectorCore
CARDi_EraseBackupSectorCore: // 0x03803538
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	mov r6, r1
	ldr r0, _038035C8 // =0x03809DE0
	ldr r5, [r0]
	ldr r4, [r5, #0x1c]
	sub r1, r4, #1
	orr r0, r7, r6
	ands r0, r1, r0
	movne r0, #2
	strne r0, [r5]
	bne _038035C0
	bl CARDi_WaitPrevCommand
	cmp r0, #0
	beq _038035C0
	mov r8, #0xd8
	b _038035B8
_0380357C:
	bl CARDi_WriteEnable
	ldr r0, [r5, #0x24]
	add r0, r0, #1
	bl CARDi_CommandBegin
	mov r0, r7
	mov r1, r8
	bl CARDi_SendSpiAddressingCommand
	ldr r0, [r5, #0x3c]
	ldr r1, [r5, #0x40]
	bl CARDi_CommandEnd
	ldr r0, [r5]
	cmp r0, #0
	bne _038035C0
	add r7, r7, r4
	sub r6, r6, r4
_038035B8:
	cmp r6, #0
	bne _0380357C
_038035C0:
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_038035C8: .word 0x03809DE0
	arm_func_end CARDi_EraseBackupSectorCore

	arm_func_start CARDi_VerifyBackupCore
CARDi_VerifyBackupCore: // 0x038035CC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl CARDi_WaitPrevCommand
	cmp r0, #0
	beq _0380365C
	ldr r0, _03803668 // =0x03809DE0
	ldr r4, [r0]
	mov r1, #1
	ldr r0, _0380366C // =0x0380A404
	str r1, [r0, #0xc]
	ldr r0, [r4, #0x24]
	add r0, r0, #1
	add r0, r0, r5
	bl CARDi_CommandBegin
	mov r0, r7
	mov r1, #3
	bl CARDi_SendSpiAddressingCommand
	mov r0, r6
	mov r1, #0
	mov r2, r5
	ldr r3, _03803670 // =sub_3803A08
	bl CARDi_CommArray
	mov r0, #0
	mov r1, r0
	bl CARDi_CommandEnd
	ldr r0, [r4]
	cmp r0, #0
	bne _0380365C
	ldr r0, _0380366C // =0x0380A404
	ldr r0, [r0, #0xc]
	cmp r0, #0
	moveq r0, #1
	streq r0, [r4]
_0380365C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_03803668: .word 0x03809DE0
_0380366C: .word 0x0380A404
_03803670: .word sub_3803A08
	arm_func_end CARDi_VerifyBackupCore

	arm_func_start CARDi_WriteBackupCore
CARDi_WriteBackupCore: // 0x03803674
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r9, r1
	mov r8, r2
	bl CARDi_WaitPrevCommand
	cmp r0, #0
	beq _03803724
	ldr r0, _03803730 // =0x03809DE0
	ldr r7, [r0]
	ldr r6, [r7, #0x20]
	sub r4, r6, #1
	mov r11, #0xa
	mov r0, #0
	str r0, [sp]
	b _0380371C
_038036B4:
	and r0, r10, r4
	sub r5, r6, r0
	cmp r5, r8
	movhi r5, r8
	bl CARDi_WriteEnable
	ldr r0, [r7, #0x24]
	add r0, r0, #1
	add r0, r0, r5
	bl CARDi_CommandBegin
	mov r0, r10
	mov r1, r11
	bl CARDi_SendSpiAddressingCommand
	mov r0, r9
	ldr r1, [sp]
	mov r2, r5
	ldr r3, _03803734 // =sub_3803A70
	bl CARDi_CommArray
	ldr r0, [r7, #0x2c]
	ldr r1, [r7, #0x30]
	bl CARDi_CommandEnd
	ldr r0, [r7]
	cmp r0, #0
	bne _03803724
	add r9, r9, r5
	add r10, r10, r5
	sub r8, r8, r5
_0380371C:
	cmp r8, #0
	bne _038036B4
_03803724:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_03803730: .word 0x03809DE0
_03803734: .word sub_3803A70
	arm_func_end CARDi_WriteBackupCore

	arm_func_start CARDi_ProgramBackupCore
CARDi_ProgramBackupCore: // 0x03803738
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r9, r1
	mov r8, r2
	bl CARDi_WaitPrevCommand
	cmp r0, #0
	beq _038037E8
	ldr r0, _038037F4 // =0x03809DE0
	ldr r7, [r0]
	ldr r6, [r7, #0x20]
	sub r4, r6, #1
	mov r0, #2
	str r0, [sp]
	mov r11, #0
	b _038037E0
_03803778:
	and r0, r10, r4
	sub r5, r6, r0
	cmp r5, r8
	movhi r5, r8
	bl CARDi_WriteEnable
	ldr r0, [r7, #0x24]
	add r0, r0, #1
	add r0, r0, r5
	bl CARDi_CommandBegin
	mov r0, r10
	ldr r1, [sp]
	bl CARDi_SendSpiAddressingCommand
	mov r0, r9
	mov r1, r11
	mov r2, r5
	ldr r3, _038037F8 // =sub_3803A70
	bl CARDi_CommArray
	ldr r0, [r7, #0x28]
	mov r1, r11
	bl CARDi_CommandEnd
	ldr r0, [r7]
	cmp r0, #0
	bne _038037E8
	add r9, r9, r5
	add r10, r10, r5
	sub r8, r8, r5
_038037E0:
	cmp r8, #0
	bne _03803778
_038037E8:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_038037F4: .word 0x03809DE0
_038037F8: .word sub_3803A70
	arm_func_end CARDi_ProgramBackupCore

	arm_func_start CARDi_ReadBackupCore
CARDi_ReadBackupCore: // 0x038037FC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl CARDi_WaitPrevCommand
	cmp r0, #0
	beq _0380385C
	ldr r0, _03803864 // =0x03809DE0
	ldr r0, [r0]
	ldr r0, [r0, #0x24]
	add r0, r0, #1
	add r0, r0, r4
	bl CARDi_CommandBegin
	mov r0, r6
	mov r1, #3
	bl CARDi_SendSpiAddressingCommand
	mov r0, #0
	mov r1, r5
	mov r2, r4
	ldr r3, _03803868 // =sub_3803ABC
	bl CARDi_CommArray
	mov r0, #0
	mov r1, r0
	bl CARDi_CommandEnd
_0380385C:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_03803864: .word 0x03809DE0
_03803868: .word sub_3803ABC
	arm_func_end CARDi_ReadBackupCore

	arm_func_start CARDi_InitStatusRegister
CARDi_InitStatusRegister: // 0x0380386C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r0, _03803908 // =0x03809DE0
	ldr r0, [r0]
	ldrb r4, [r0, #0x48]
	cmp r4, #0xff
	beq _038038FC
	ldr r0, _0380390C // =0x0380A400
	ldr r0, [r0]
	cmp r0, #0
	bne _038038FC
	mov r0, #5
	strb r0, [sp]
	mov r0, #2
	bl CARDi_CommandBegin
	add r0, sp, #0
	mov r1, #0
	mov r2, #1
	ldr r3, _03803910 // =sub_3803A70
	bl CARDi_CommArray
	mov r0, #0
	add r1, sp, #1
	mov r2, #1
	ldr r3, _03803914 // =sub_3803ABC
	bl CARDi_CommArray
	mov r0, #0
	mov r1, r0
	bl CARDi_CommandEnd
	ldrb r0, [sp, #1]
	cmp r0, r4
	beq _038038F0
	mov r0, r4
	bl CARDi_SetWriteProtectCore
_038038F0:
	mov r1, #1
	ldr r0, _0380390C // =0x0380A400
	str r1, [r0]
_038038FC:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_03803908: .word 0x03809DE0
_0380390C: .word 0x0380A400
_03803910: .word sub_3803A70
_03803914: .word sub_3803ABC
	arm_func_end CARDi_InitStatusRegister

	arm_func_start CARDi_SendSpiAddressingCommand
CARDi_SendSpiAddressingCommand: // 0x03803918
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _038039BC // =0x03809DE0
	ldr r2, [r2]
	ldr r2, [r2, #0x24]
	cmp r2, #1
	beq _03803948
	cmp r2, #2
	beq _03803964
	cmp r2, #3
	beq _0380397C
	b _0380399C
_03803948:
	and r3, r0, #0xff
	mov r0, r0, lsr #5
	and r0, r0, #8
	orr r0, r1, r0
	orr r0, r0, r3, lsl #8
	str r0, [sp]
	b _0380399C
_03803964:
	and r3, r0, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	orr r0, r0, r3, lsl #16
	str r0, [sp]
	b _0380399C
_0380397C:
	and ip, r0, #0xff
	and r3, r0, #0xff00
	mov r0, r0, lsr #8
	and r0, r0, #0xff00
	orr r0, r1, r0
	orr r0, r0, r3, lsl #8
	orr r0, r0, ip, lsl #24
	str r0, [sp]
_0380399C:
	add r0, sp, #0
	mov r1, #0
	add r2, r2, #1
	ldr r3, _038039C0 // =sub_3803A70
	bl CARDi_CommArray
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_038039BC: .word 0x03809DE0
_038039C0: .word sub_3803A70
	arm_func_end CARDi_SendSpiAddressingCommand

	arm_func_start CARDi_WriteEnable
CARDi_WriteEnable: // 0x038039C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl CARDi_CommandBegin
	ldr r0, _03803A00 // =0x03807F58
	mov r1, #0
	mov r2, #1
	ldr r3, _03803A04 // =sub_3803A70
	bl CARDi_CommArray
	mov r0, #0
	mov r1, r0
	bl CARDi_CommandEnd
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03803A00: .word 0x03807F58
_03803A04: .word sub_3803A70
	arm_func_end CARDi_WriteEnable

	arm_func_start sub_3803A08
sub_3803A08: // 0x03803A08
	mov r2, #0
	ldr r1, _03803A68 // =0x040001A2
	strh r2, [r1]
	ldr r2, _03803A6C // =0x040001A0
_03803A18:
	ldrh r1, [r2]
	ands r1, r1, #0x80
	bne _03803A18
	ldr r1, _03803A68 // =0x040001A2
	ldrh r1, [r1]
	and r2, r1, #0xff
	ldr r1, [r0, #4]
	ldrb r1, [r1]
	cmp r2, r1
	beq _03803A58
	mov r1, #0
	str r1, [r0, #0xc]
	ldr r1, [r0]
	cmp r1, #1
	movhi r1, #1
	strhi r1, [r0]
_03803A58:
	ldr r1, [r0, #4]
	add r1, r1, #1
	str r1, [r0, #4]
	bx lr
	.align 2, 0
_03803A68: .word 0x040001A2
_03803A6C: .word 0x040001A0
	arm_func_end sub_3803A08

	arm_func_start sub_3803A70
sub_3803A70: // 0x03803A70
	sub sp, sp, #8
	ldr r1, [r0, #4]
	ldrb r2, [r1]
	ldr r1, _03803AB4 // =0x040001A2
	strh r2, [r1]
	ldr r1, [r0, #4]
	add r1, r1, #1
	str r1, [r0, #4]
	ldr r1, _03803AB8 // =0x040001A0
_03803A94:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _03803A94
	ldr r0, _03803AB4 // =0x040001A2
	ldrh r0, [r0]
	strh r0, [sp]
	add sp, sp, #8
	bx lr
	.align 2, 0
_03803AB4: .word 0x040001A2
_03803AB8: .word 0x040001A0
	arm_func_end sub_3803A70

	arm_func_start sub_3803ABC
sub_3803ABC: // 0x03803ABC
	mov r2, #0
	ldr r1, _03803AF8 // =0x040001A2
	strh r2, [r1]
	ldr r2, _03803AFC // =0x040001A0
_03803ACC:
	ldrh r1, [r2]
	ands r1, r1, #0x80
	bne _03803ACC
	ldr r1, _03803AF8 // =0x040001A2
	ldrh r2, [r1]
	ldr r1, [r0, #8]
	strb r2, [r1]
	ldr r1, [r0, #8]
	add r1, r1, #1
	str r1, [r0, #8]
	bx lr
	.align 2, 0
_03803AF8: .word 0x040001A2
_03803AFC: .word 0x040001A0
	arm_func_end sub_3803ABC

	arm_func_start CARDi_CommArray
CARDi_CommArray: // 0x03803B00
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r2
	mov r6, r3
	ldr r5, _03803B84 // =0x0380A404
	str r0, [r5, #4]
	str r1, [r5, #8]
	ldr r0, _03803B88 // =0x0000A040
	ldr r4, _03803B8C // =0x040001A0
	strh r0, [r4]
	mov r8, #0xa000
	b _03803B60
_03803B2C:
	ldr r0, [r5]
	sub r0, r0, #1
	str r0, [r5]
	ldr r0, [r5]
	cmp r0, #0
	streqh r8, [r4]
_03803B44:
	ldrh r0, [r4]
	ands r0, r0, #0x80
	bne _03803B44
	mov r0, r5
	mov lr, pc
	bx r6
	arm_func_end CARDi_CommArray

	arm_func_start sub_3803B5C
sub_3803B5C: // 0x03803B5C
	sub r7, r7, #1
_03803B60:
	cmp r7, #0
	bne _03803B2C
	ldr r0, [r5]
	cmp r0, #0
	moveq r1, #0
	ldreq r0, _03803B8C // =0x040001A0
	streqh r1, [r0]
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_03803B84: .word 0x0380A404
_03803B88: .word 0x0000A040
_03803B8C: .word 0x040001A0
	arm_func_end sub_3803B5C

	arm_func_start CARDi_WaitPrevCommand
CARDi_WaitPrevCommand: // 0x03803B90
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	mov r1, #0x32
	bl CARDi_CommandEnd
	ldr r0, _03803BD0 // =0x03809DE0
	ldr r1, [r0]
	ldr r0, [r1]
	cmp r0, #4
	moveq r0, #6
	streq r0, [r1]
	moveq r0, #0
	movne r0, #1
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03803BD0: .word 0x03809DE0
	arm_func_end CARDi_WaitPrevCommand

	arm_func_start CARDi_CommandCheckBusy
CARDi_CommandCheckBusy: // 0x03803BD4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #2
	bl CARDi_CommandBegin
	ldr r0, _03803C34 // =0x03807F5C
	mov r1, #0
	mov r2, #1
	ldr r3, _03803C38 // =sub_3803A70
	bl CARDi_CommArray
	mov r0, #0
	add r1, sp, #0
	mov r2, #1
	ldr r3, _03803C3C // =sub_3803ABC
	bl CARDi_CommArray
	mov r0, #0
	mov r1, r0
	bl CARDi_CommandEnd
	ldrb r0, [sp]
	ands r0, r0, #1
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03803C34: .word 0x03807F5C
_03803C38: .word sub_3803A70
_03803C3C: .word sub_3803ABC
	arm_func_end CARDi_CommandCheckBusy

	arm_func_start CARDi_CommandEnd
CARDi_CommandEnd: // 0x03803C40
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r1
	adds r1, r5, r4
	beq _03803CB8
	cmp r5, #0
	beq _03803C60
	bl OS_Sleep
_03803C60:
	cmp r4, #0
	beq _03803CA0
	sub r6, r4, r5
	mov r4, #5
	b _03803C8C
_03803C74:
	cmp r6, #5
	movlt r5, r6
	movge r5, r4
	mov r0, r5
	bl OS_Sleep
	sub r6, r6, r5
_03803C8C:
	bl CARDi_CommandCheckBusy
	cmp r0, #0
	bne _03803CA0
	cmp r6, #0
	bgt _03803C74
_03803CA0:
	bl CARDi_CommandCheckBusy
	cmp r0, #0
	moveq r1, #4
	ldreq r0, _03803CC0 // =0x03809DE0
	ldreq r0, [r0]
	streq r1, [r0]
_03803CB8:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_03803CC0: .word 0x03809DE0
	arm_func_end CARDi_CommandEnd

	arm_func_start CARDi_CommandBegin
CARDi_CommandBegin: // 0x03803CC4
	ldr r1, _03803CD0 // =0x0380A404
	str r0, [r1]
	bx lr
	.align 2, 0
_03803CD0: .word 0x0380A404
	arm_func_end CARDi_CommandBegin

	arm_func_start CARDi_GetRomAccessor
CARDi_GetRomAccessor: // 0x03803CD4
	ldr r0, _03803CDC // =CARD_Func_3803E8C
	bx lr
	.align 2, 0
_03803CDC: .word CARD_Func_3803E8C
	arm_func_end CARDi_GetRomAccessor

	arm_func_start CARD_Init
CARD_Init: // 0x03803CE0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _03803D50 // =0x03809DE0
	ldr r0, [r2, #0xfc]
	cmp r0, #0
	bne _03803D44
	mov r0, #1
	str r0, [r2, #0xfc]
	mov r1, #0
	str r1, [r2, #0x28]
	ldr r0, [r2, #0x28]
	str r0, [r2, #0x24]
	ldr r0, [r2, #0x24]
	str r0, [r2, #0x20]
	mvn r0, #0
	str r0, [r2, #0x2c]
	str r1, [r2, #0x3c]
	str r1, [r2, #0x40]
	ldr r0, _03803D54 // =0x0380A414
	str r1, [r0]
	bl CARDi_InitCommon
	bl CARDi_GetRomAccessor
	ldr r1, _03803D58 // =0x0380A420
	str r0, [r1]
	bl CARD_InitPulledOutCallback
_03803D44:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03803D50: .word 0x03809DE0
_03803D54: .word 0x0380A414
_03803D58: .word 0x0380A420
	arm_func_end CARD_Init

	arm_func_start CARDi_ReadRomID
CARDi_ReadRomID: // 0x03803D5C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r5, _03803E20 // =0x03809DE0
	bl OS_DisableInterrupts
	mov r4, r0
	add r6, r5, #0xf4
	b _03803D7C
_03803D74:
	mov r0, r6
	bl OS_SleepThread
_03803D7C:
	ldr r0, [r5, #0xfc]
	ands r0, r0, #4
	bne _03803D74
	ldr r0, [r5, #0xfc]
	orr r0, r0, #4
	str r0, [r5, #0xfc]
	mov r0, #0
	str r0, [r5, #0x3c]
	str r0, [r5, #0x40]
	mov r0, r4
	bl OS_RestoreInterrupts
	bl CARDi_ReadRomIDCore
	mov r8, r0
	ldr r7, _03803E20 // =0x03809DE0
	mov r1, #0
	ldr r0, [r7]
	str r1, [r0]
	ldr r6, [r7, #0x3c]
	ldr r5, [r7, #0x40]
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r0, [r7, #0xfc]
	bic r0, r0, #0x4c
	str r0, [r7, #0xfc]
	add r0, r7, #0xf4
	bl OS_WakeupThread
	ldr r0, [r7, #0xfc]
	ands r0, r0, #0x10
	beq _03803DF8
	add r0, r7, #0x48
	bl OS_WakeupThreadDirect
_03803DF8:
	mov r0, r4
	bl OS_RestoreInterrupts
	cmp r6, #0
	beq _03803E14
	mov r0, r5
	mov lr, pc
	bx r6
_03803E14:
	mov r0, r8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_03803E20: .word 0x03809DE0
	arm_func_end CARDi_ReadRomID

	arm_func_start CARDi_ReadRomIDCore
CARDi_ReadRomIDCore: // 0x03803E24
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0xb8000000
	mov r1, #0
	bl CARDi_SetRomOp
	ldr r0, _03803E80 // =_038082FC
	ldr r0, [r0]
	ldr r0, [r0, #0x60]
	bic r0, r0, #0x7000000
	orr r1, r0, #0xa7000000
	mov r0, #0x2000
	rsb r0, r0, #0
	and r0, r1, r0
	ldr r1, _03803E84 // =0x040001A4
	str r0, [r1]
_03803E60:
	ldr r0, [r1]
	ands r0, r0, #0x800000
	beq _03803E60
	ldr r0, _03803E88 // =0x04100010
	ldr r0, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03803E80: .word _038082FC
_03803E84: .word 0x040001A4
_03803E88: .word 0x04100010
	arm_func_end CARDi_ReadRomIDCore

	arm_func_start CARD_Func_3803E8C
CARD_Func_3803E8C: // 0x03803E8C
	bx lr
	arm_func_end CARD_Func_3803E8C

	arm_func_start CARDi_SetRomOp
CARDi_SetRomOp: // 0x03803E90
	ldr r3, _03803F08 // =0x040001A4
_03803E94:
	ldr r2, [r3]
	ands r2, r2, #0x80000000
	bne _03803E94
	mov r3, #0xc0
	ldr r2, _03803F0C // =0x040001A1
	strb r3, [r2]
	mov r3, r0, lsr #0x18
	ldr r2, _03803F10 // =0x040001A8
	strb r3, [r2]
	mov r3, r0, lsr #0x10
	ldr r2, _03803F14 // =0x040001A9
	strb r3, [r2]
	mov r3, r0, lsr #8
	ldr r2, _03803F18 // =0x040001AA
	strb r3, [r2]
	ldr r2, _03803F1C // =0x040001AB
	strb r0, [r2]
	mov r2, r1, lsr #0x18
	ldr r0, _03803F20 // =0x040001AC
	strb r2, [r0]
	mov r2, r1, lsr #0x10
	ldr r0, _03803F24 // =0x040001AD
	strb r2, [r0]
	mov r2, r1, lsr #8
	ldr r0, _03803F28 // =0x040001AE
	strb r2, [r0]
	ldr r0, _03803F2C // =0x040001AF
	strb r1, [r0]
	bx lr
	.align 2, 0
_03803F08: .word 0x040001A4
_03803F0C: .word 0x040001A1
_03803F10: .word 0x040001A8
_03803F14: .word 0x040001A9
_03803F18: .word 0x040001AA
_03803F1C: .word 0x040001AB
_03803F20: .word 0x040001AC
_03803F24: .word 0x040001AD
_03803F28: .word 0x040001AE
_03803F2C: .word 0x040001AF
	arm_func_end CARDi_SetRomOp

	arm_func_start CARDi_TaskThread
CARDi_TaskThread: // 0x03803F30
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r9, _03804138 // =0x03809DE0
	add r5, r9, #0x48
	mov r8, #0
	add r7, r9, #0xfc
	mov r6, #1
	mov r4, #3
	mov r11, #0xb
_03803F54:
	mov r10, r8
	bl OS_DisableInterrupts
	str r0, [sp]
_03803F60:
	ldr r0, [r9, #0xfc]
	ands r0, r0, #4
	bne _03803F98
	ldr r0, [r9, #0xfc]
	ands r0, r0, #0x10
	beq _03803FA4
	ldr r0, [r7]
	orr r0, r0, #4
	str r0, [r7]
	ldr r0, [r7]
	bic r0, r0, #0x10
	str r0, [r7]
	mov r10, r6
	b _03803FB4
_03803F98:
	ldr r0, [r9, #0xfc]
	ands r0, r0, #8
	bne _03803FB4
_03803FA4:
	str r5, [r9, #0xec]
	mov r0, r8
	bl OS_SleepThread
	b _03803F60
_03803FB4:
	ldr r0, [sp]
	bl OS_RestoreInterrupts
	cmp r10, #0
	beq _03804124
	ldr r0, [r9]
	str r8, [r0]
	ldr r2, [r9]
	ldr r1, [r2, #0x4c]
	ldr r0, [r9, #4]
	mov r0, r6, lsl r0
	ands r0, r1, r0
	streq r4, [r2]
	ldr r0, [r9, #4]
	cmp r0, #0xc
	addls pc, pc, r0, lsl #2
	b _038040C8
_03803FF4: // jump table
	b _038040D0 // case 0
	b _038040D0 // case 1
	b _03804028 // case 2
	b _03804030 // case 3
	b _03804040 // case 4
	b _038040C8 // case 5
	b _0380404C // case 6
	b _03804064 // case 7
	b _0380407C // case 8
	b _03804094 // case 9
	b _038040C8 // case 10
	b _038040AC // case 11
	b _038040C0 // case 12
_03804028:
	bl CARDi_InitStatusRegister
	b _038040D0
_03804030:
	bl CARDi_ReadRomIDCore
	ldr r1, [r9]
	str r0, [r1, #8]
	b _038040D0
_03804040:
	ldr r0, [r9]
	str r4, [r0]
	b _038040D0
_0380404C:
	ldr r2, [r9]
	ldr r0, [r2, #0xc]
	ldr r1, [r2, #0x10]
	ldr r2, [r2, #0x14]
	bl CARDi_ReadBackupCore
	b _038040D0
_03804064:
	ldr r2, [r9]
	ldr r0, [r2, #0x10]
	ldr r1, [r2, #0xc]
	ldr r2, [r2, #0x14]
	bl CARDi_WriteBackupCore
	b _038040D0
_0380407C:
	ldr r2, [r9]
	ldr r0, [r2, #0x10]
	ldr r1, [r2, #0xc]
	ldr r2, [r2, #0x14]
	bl CARDi_ProgramBackupCore
	b _038040D0
_03804094:
	ldr r2, [r9]
	ldr r0, [r2, #0x10]
	ldr r1, [r2, #0xc]
	ldr r2, [r2, #0x14]
	bl CARDi_VerifyBackupCore
	b _038040D0
_038040AC:
	ldr r1, [r9]
	ldr r0, [r1, #0x10]
	ldr r1, [r1, #0x14]
	bl CARDi_EraseBackupSectorCore
	b _038040D0
_038040C0:
	bl CARDi_EraseChipCore
	b _038040D0
_038040C8:
	ldr r0, [r9]
	str r4, [r0]
_038040D0:
	mov r0, r11
	mov r1, r6
	mov r2, r6
	bl PXI_SendWordByFifo
	cmp r0, #0
	blt _038040D0
	bl OS_DisableInterrupts
	mov r10, r0
	ldr r0, [r9, #0xfc]
	bic r0, r0, #0x4c
	str r0, [r9, #0xfc]
	add r0, r9, #0xf4
	bl OS_WakeupThread
	ldr r0, [r9, #0xfc]
	ands r0, r0, #0x10
	beq _03804118
	mov r0, r5
	bl OS_WakeupThreadDirect
_03804118:
	mov r0, r10
	bl OS_RestoreInterrupts
	b _03803F54
_03804124:
	mov r0, r9
	ldr r1, [r9, #0x44]
	mov lr, pc
	bx r1
	arm_func_end CARDi_TaskThread

	arm_func_start sub_3804134
sub_3804134: // 0x03804134
	b _03803F54
	.align 2, 0
_03804138: .word 0x03809DE0
	arm_func_end sub_3804134

	arm_func_start CARDi_OnFifoRecv
CARDi_OnFifoRecv: // 0x0380413C
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0xb
	bne _0380420C
	cmp r2, #0
	beq _0380420C
	ldr r0, _03804218 // =0x03809DE0
	ldr r2, [r0, #8]
	cmp r2, #0
	streq r1, [r0, #4]
	ldr r2, [r0, #4]
	cmp r2, #0xc
	addls pc, pc, r2, lsl #2
	b _038041D8
_03804174: // jump table
	b _038041A8 // case 0
	b _038041D8 // case 1
	b _038041CC // case 2
	b _038041CC // case 3
	b _038041CC // case 4
	b _038041CC // case 5
	b _038041CC // case 6
	b _038041CC // case 7
	b _038041CC // case 8
	b _038041CC // case 9
	b _038041CC // case 10
	b _038041CC // case 11
	b _038041CC // case 12
_038041A8:
	ldr r2, [r0, #8]
	cmp r2, #0
	beq _038041D8
	cmp r2, #1
	streq r1, [r0]
	ldreq r1, [r0, #0xfc]
	orreq r1, r1, #0x10
	streq r1, [r0, #0xfc]
	b _038041D8
_038041CC:
	ldr r1, [r0, #0xfc]
	orr r1, r1, #0x10
	str r1, [r0, #0xfc]
_038041D8:
	ldr r1, [r0, #0xfc]
	ands r1, r1, #0x10
	ldreq r1, [r0, #8]
	addeq r1, r1, #1
	streq r1, [r0, #8]
	beq _0380420C
	mov r1, #0
	str r1, [r0, #8]
	ldr r1, [r0, #0xfc]
	ands r1, r1, #4
	ldrne r0, [r0, #0xec]
	addeq r0, r0, #0x48
	bl OS_WakeupThreadDirect
_0380420C:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03804218: .word 0x03809DE0
	arm_func_end CARDi_OnFifoRecv

	arm_func_start CARD_Func_380421C
CARD_Func_380421C: // 0x0380421C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, #0xe
	mov r4, #0
	b _03804240
_03804238:
	mov r0, r6
	bl SVC_WaitByLoop_ARM
_03804240:
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	bne _03804238
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end CARD_Func_380421C

	arm_func_start CARD_Func_3804264
CARD_Func_3804264: // 0x03804264
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl CTRDG_VibPulseEdgeUpdate
	bl SND_BeginSleep
	bl WVR_Shutdown
	bl OS_Terminate
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CARD_Func_3804264

	arm_func_start CARD_CheckPullOut_Polling
CARD_CheckPullOut_Polling: // 0x0380428C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _03804360 // =0x0380A640
	ldr r0, [r0]
	cmp r0, #0
	bne _03804354
	ldr r0, _03804364 // =0x027FFC40
	ldrh r0, [r0]
	cmp r0, #2
	beq _03804354
	ldr r1, _03804368 // =_03808300
	ldr r3, [r1]
	mvn r0, #0
	cmp r3, r0
	ldreq r0, _0380436C // =0x027FFC3C
	ldreq r0, [r0]
	addeq r0, r0, #0xa
	streq r0, [r1]
	beq _03804354
	ldr r2, _0380436C // =0x027FFC3C
	ldr r0, [r2]
	cmp r0, r3
	blo _03804354
	ldr r0, [r2]
	add r0, r0, #0xa
	str r0, [r1]
	bl CARD_IsPulledOut
	cmp r0, #0
	beq _0380432C
	mov r1, #1
	ldr r0, _03804360 // =0x0380A640
	str r1, [r0]
	bl CARD_GetRomHeader
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _0380432C
	ldr r0, _03804370 // =_03808304
	ldr r0, [r0]
	cmp r0, #0
	bne _03804354
_0380432C:
	mov r1, #0
	ldr r0, _03804370 // =_03808304
	str r1, [r0]
	ldr r0, _03804360 // =0x0380A640
	ldr r0, [r0]
	cmp r0, #0
	beq _03804354
	mov r0, #0x11
	mov r1, #0x64
	bl CARD_Func_380421C
_03804354:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03804360: .word 0x0380A640
_03804364: .word 0x027FFC40
_03804368: .word _03808300
_0380436C: .word 0x027FFC3C
_03804370: .word _03808304
	arm_func_end CARD_CheckPullOut_Polling

	arm_func_start CARD_IsCardIreqLo
CARD_IsCardIreqLo: // 0x03804374
	mov r2, #1
	mov r0, r2
	ldr r1, _03804398 // =0x04000214
	ldr r1, [r1]
	ands r1, r1, #0x100000
	movne r0, #0
	ldrne r1, _0380439C // =0x0380A648
	strne r2, [r1]
	bx lr
	.align 2, 0
_03804398: .word 0x04000214
_0380439C: .word 0x0380A648
	arm_func_end CARD_IsCardIreqLo

	arm_func_start CARD_CompareCardID
CARD_CompareCardID: // 0x038043A0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _038043F8 // =0x027FFC10
	ldrh r0, [r0]
	cmp r0, #0
	ldreq r0, _038043FC // =0x027FF800
	ldrne r0, _03804400 // =0x027FFC00
	ldr r0, [r0]
	str r0, [sp]
	bl CARDi_ReadRomID
	ldr r1, [sp]
	cmp r0, r1
	moveq r0, #1
	movne r0, #0
	cmp r0, #0
	moveq r2, #1
	movne r2, #0
	ldr r1, _03804404 // =0x0380A648
	str r2, [r1]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_038043F8: .word 0x027FFC10
_038043FC: .word 0x027FF800
_03804400: .word 0x027FFC00
_03804404: .word 0x0380A648
	arm_func_end CARD_CompareCardID

	arm_func_start CARD_IsPulledOut
CARD_IsPulledOut: // 0x03804408
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _03804450 // =0x0380A648
	ldr r0, [r0]
	cmp r0, #0
	bne _0380443C
	ldr r0, _03804454 // =0x027FFC1F
	ldrb r0, [r0]
	ands r0, r0, #1
	beq _03804438
	bl CARD_CompareCardID
	b _0380443C
_03804438:
	bl CARD_IsCardIreqLo
_0380443C:
	ldr r0, _03804450 // =0x0380A648
	ldr r0, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03804450: .word 0x0380A648
_03804454: .word 0x027FFC1F
	arm_func_end CARD_IsPulledOut

	arm_func_start CARDi_PulledOutCallback
CARDi_PulledOutCallback: // 0x03804458
	stmdb sp!, {lr}
	sub sp, sp, #4
	and r0, r1, #0x3f
	cmp r0, #1
	bne _03804474
	bl CARD_Func_3804264
	b _03804478
_03804474:
	bl OS_Terminate
_03804478:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CARDi_PulledOutCallback

	arm_func_start CARD_InitPulledOutCallback
CARD_InitPulledOutCallback: // 0x03804484
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _038044DC // =0x0380A644
	ldr r1, [r0]
	cmp r1, #0
	bne _038044D0
	mov r1, #1
	str r1, [r0]
	bl PXI_Init
	mov r5, #0xe
	mov r4, #0
_038044B0:
	mov r0, r5
	mov r1, r4
	bl PXI_IsCallbackReady
	cmp r0, #0
	beq _038044B0
	mov r0, #0xe
	ldr r1, _038044E0 // =CARDi_PulledOutCallback
	bl PXI_SetFifoRecvCallback
_038044D0:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_038044DC: .word 0x0380A644
_038044E0: .word CARDi_PulledOutCallback
	arm_func_end CARD_InitPulledOutCallback

	.rodata
	
_038082FC:
	.word 0x27FFE00
	
_03808300:
	.word 0xFFFFFFFF
	
_03808304:
	.word 1