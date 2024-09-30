	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public PMi_KeyPattern
PMi_KeyPattern: // 0x0380ABCC
	.space 4

.public PMi_TriggerBL
PMi_TriggerBL: // 0x0380ABD0
	.space 4

.public PMi_Initialized
PMi_Initialized: // 0x0380ABD4
	.space 4

.public PMi_Work
PMi_Work: // 0x0380ABD8
	.space 0x2C

.public PMi_BlinkCounter
PMi_BlinkCounter: // 0x0380AC04
	.space 4

.public PMi_BlinkPatternNo
PMi_BlinkPatternNo: // 0x0380AC08
	.space 4

	.text

	arm_func_start PM_ExecuteProcess
PM_ExecuteProcess: // 0x03805710
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	bl OS_DisableInterrupts
	mov r5, r0
	mov r0, #3
	bl SPIi_CheckException
	cmp r0, #0
	bne _03805754
	mov r0, r5
	bl OS_RestoreInterrupts
	ldr r0, [r4, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #4
	bl SPIi_ReturnResult
	b _03805880
_03805754:
	mov r0, #3
	bl SPIi_GetException
	mov r0, r5
	bl OS_RestoreInterrupts
	ldr r1, [r4, #4]
	sub r0, r1, #0x61
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _03805868
_03805778: // jump table
	b _03805790 // case 0
	b _03805868 // case 1
	b _03805834 // case 2
	b _038057BC // case 3
	b _038057F8 // case 4
	b _0380585C // case 5
_03805790:
	mov r1, #1
	ldr r0, _0380588C // =PMi_Work
	str r1, [r0, #0x20]
	ldr r1, [r4, #8]
	ldr r0, _03805890 // =PMi_TriggerBL
	strh r1, [r0]
	ldr r1, [r4, #0xc]
	ldr r0, _03805894 // =PMi_KeyPattern
	strh r1, [r0]
	bl PMi_DoSleep
	b _03805878
_038057BC:
	mov r1, #4
	ldr r0, _0380588C // =PMi_Work
	str r1, [r0, #0x20]
	ldr r2, [r4, #8]
	str r2, [r0, #0x28]
	ldr r1, [r4, #0xc]
	str r1, [r0, #0x24]
	mov r0, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	and r1, r1, #0xff
	bl PMi_SetRegister
	mov r0, #0x64
	mov r1, #0
	bl SPIi_ReturnResult
	b _03805878
_038057F8:
	mov r1, #3
	ldr r0, _0380588C // =PMi_Work
	str r1, [r0, #0x20]
	ldr r1, [r4, #8]
	str r1, [r0, #0x28]
	mov r0, r1, lsl #0x10
	mov r4, r0, lsr #0x10
	mov r0, r4
	bl PMi_GetRegister
	mov r1, r0
	add r0, r4, #0x70
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SPIi_ReturnResult
	b _03805878
_03805834:
	mov r0, #2
	ldr r1, _0380588C // =PMi_Work
	str r0, [r1, #0x20]
	ldr r0, [r4, #8]
	str r0, [r1, #0x24]
	bl PMi_SwitchUtilityProc
	mov r0, #0x63
	mov r1, #0
	bl SPIi_ReturnResult
	b _03805878
_0380585C:
	ldr r0, [r4, #8]
	bl PMi_SetLED
	b _03805878
_03805868:
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #1
	bl SPIi_ReturnResult
_03805878:
	mov r0, #3
	bl SPIi_ReleaseException
_03805880:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_0380588C: .word PMi_Work
_03805890: .word PMi_TriggerBL
_03805894: .word PMi_KeyPattern
	arm_func_end PM_ExecuteProcess

	arm_func_start PM_AnalyzeCommand
PM_AnalyzeCommand: // 0x03805898
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ands r1, r0, #0x2000000
	beq _038058C8
	mov r4, #0
	mov r3, r4
	ldr r1, _03805A64 // =PMi_Work
_038058B4:
	mov r2, r4, lsl #1
	strh r3, [r1, r2]
	add r4, r4, #1
	cmp r4, #0x10
	blt _038058B4
_038058C8:
	and r1, r0, #0xf0000
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #1
	ldr ip, _03805A64 // =PMi_Work
	strh r0, [ip, r1]
	ands r0, r0, #0x1000000
	beq _03805A58
	ldrh r3, [ip]
	and r0, r3, #0xff00
	mov r0, r0, lsl #8
	mov r4, r0, lsr #0x10
	sub r0, r4, #0x60
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _03805A4C
_03805904: // jump table
	b _03805924 // case 0
	b _03805934 // case 1
	b _03805A4C // case 2
	b _038059DC // case 3
	b _03805970 // case 4
	b _038059AC // case 5
	b _03805A18 // case 6
	b _03805A30 // case 7
_03805924:
	mov r0, #0x60
	mov r1, #0
	bl SPIi_ReturnResult
	b _03805A58
_03805934:
	ldrh r1, [ip, #2]
	ldr r0, _03805A68 // =0x0000FFFF
	and r0, r1, r0
	str r0, [sp]
	mov r0, #3
	mov r1, r4
	mov r2, #2
	and r3, r3, #0xff
	bl SPIi_SetEntry
	cmp r0, #0
	bne _03805A58
	mov r0, r4
	mov r1, #4
	bl SPIi_ReturnResult
	b _03805A58
_03805970:
	ldrh r1, [ip, #2]
	ldr r0, _03805A68 // =0x0000FFFF
	and r0, r1, r0
	str r0, [sp]
	mov r0, #3
	mov r1, r4
	mov r2, #2
	and r3, r3, #0xff
	bl SPIi_SetEntry
	cmp r0, #0
	bne _03805A58
	mov r0, r4
	mov r1, #4
	bl SPIi_ReturnResult
	b _03805A58
_038059AC:
	mov r0, #3
	mov r1, r4
	mov r2, #1
	ldr ip, _03805A68 // =0x0000FFFF
	and r3, r3, ip
	bl SPIi_SetEntry
	cmp r0, #0
	bne _03805A58
	mov r0, r4
	mov r1, #4
	bl SPIi_ReturnResult
	b _03805A58
_038059DC:
	mov r0, #3
	mov r1, r4
	mov r2, #1
	and lr, r3, #0xff
	ldrh ip, [ip, #2]
	ldr r3, _03805A68 // =0x0000FFFF
	and r3, ip, r3
	orr r3, r3, lr, lsl #16
	bl SPIi_SetEntry
	cmp r0, #0
	bne _03805A58
	mov r0, r4
	mov r1, #4
	bl SPIi_ReturnResult
	b _03805A58
_03805A18:
	and r0, r3, #0xff
	bl PM_SetLEDPattern
	mov r0, #0x66
	mov r1, #0
	bl SPIi_ReturnResult
	b _03805A58
_03805A30:
	bl PM_GetLEDPattern
	mov r1, r0
	mov r0, #0x67
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl SPIi_ReturnResult
	b _03805A58
_03805A4C:
	mov r0, r4
	mov r1, #1
	bl SPIi_ReturnResult
_03805A58:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_03805A64: .word PMi_Work
_03805A68: .word 0x0000FFFF
	arm_func_end PM_AnalyzeCommand

	arm_func_start PM_Init
PM_Init: // 0x03805A6C
	mov r1, #1
	ldr r0, _03805AA0 // =PMi_Initialized
	str r1, [r0]
	mov r3, #0
	ldr r0, _03805AA4 // =PMi_Work
	str r3, [r0, #0x20]
	mov r2, r3
_03805A88:
	mov r1, r3, lsl #1
	strh r2, [r0, r1]
	add r3, r3, #1
	cmp r3, #0x10
	blt _03805A88
	bx lr
	.align 2, 0
_03805AA0: .word PMi_Initialized
_03805AA4: .word PMi_Work
	arm_func_end PM_Init

	arm_func_start PMi_SendPxiCommand
PMi_SendPxiCommand: // 0x03805AA8
	ldr r3, _03805ACC // =0x0000FFFF
	and r3, r2, r3
	and r0, r0, #0x3c00000
	mov r2, r0, lsl #0x16
	and r0, r1, #0x3f0000
	orr r0, r2, r0, lsl #16
	orr r0, r3, r0
	ldr ip, _03805AD0 // =PMi_SendPxiData
	bx ip
	.align 2, 0
_03805ACC: .word 0x0000FFFF
_03805AD0: .word PMi_SendPxiData
	arm_func_end PMi_SendPxiCommand

	arm_func_start PMi_SendPxiData
PMi_SendPxiData: // 0x03805AD4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, #8
	mov r4, #0
_03805AE4:
	mov r0, r5
	mov r1, r6
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	bne _03805AE4
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end PMi_SendPxiData

	arm_func_start PMi_ResetControl
PMi_ResetControl: // 0x03805B04
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	bl PMi_GetRegister
	mvn r1, r4
	and r0, r0, r1
	and r1, r0, #0xff
	mov r0, #0
	bl PMi_SetRegister
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end PMi_ResetControl

	arm_func_start PMi_SetControl
PMi_SetControl: // 0x03805B30
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	bl PMi_GetRegister
	orr r1, r0, r4
	mov r0, #0
	bl PMi_SetRegister
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end PMi_SetControl

	arm_func_start PMi_GetRegister
PMi_GetRegister: // 0x03805B54
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, _03805BE0 // =0x040001C0
_03805B60:
	ldrh r0, [r1, #0]
	ands r0, r0, #0x80
	bne _03805B60
	bl PMi_ChangeSpiModeTP
	mov r0, #1
	bl PMi_ChangeSpiMode
	orr r0, r4, #0x80
	and r0, r0, #0xff
	and r1, r0, #0xff
	ldr r0, _03805BE4 // =0x040001C2
	strh r1, [r0]
	ldr r1, _03805BE0 // =0x040001C0
_03805B90:
	ldrh r0, [r1, #0]
	ands r0, r0, #0x80
	bne _03805B90
	mov r0, #0
	bl PMi_ChangeSpiMode
	mov r1, #0
	ldr r0, _03805BE4 // =0x040001C2
	strh r1, [r0]
	ldr r1, _03805BE0 // =0x040001C0
_03805BB4:
	ldrh r0, [r1, #0]
	ands r0, r0, #0x80
	bne _03805BB4
	ldr r0, _03805BE4 // =0x040001C2
	ldrh r0, [r0, #0]
	and r0, r0, #0xff
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0xff
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_03805BE0: .word 0x040001C0
_03805BE4: .word 0x040001C2
	arm_func_end PMi_GetRegister

	arm_func_start PMi_SetRegister
PMi_SetRegister: // 0x03805BE8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	ldr r1, _03805C54 // =0x040001C0
_03805BFC:
	ldrh r0, [r1, #0]
	ands r0, r0, #0x80
	bne _03805BFC
	bl PMi_ChangeSpiModeTP
	mov r0, #1
	bl PMi_ChangeSpiMode
	and r0, r5, #0xff
	and r1, r0, #0xff
	ldr r0, _03805C58 // =0x040001C2
	strh r1, [r0]
	ldr r1, _03805C54 // =0x040001C0
_03805C28:
	ldrh r0, [r1, #0]
	ands r0, r0, #0x80
	bne _03805C28
	mov r0, #0
	bl PMi_ChangeSpiMode
	and r1, r4, #0xff
	ldr r0, _03805C58 // =0x040001C2
	strh r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_03805C54: .word 0x040001C0
_03805C58: .word 0x040001C2
	arm_func_end PMi_SetRegister

	arm_func_start PMi_ChangeSpiModeTP
PMi_ChangeSpiModeTP: // 0x03805C5C
	ldr r1, _03805C6C // =0x00008202
	ldr r0, _03805C70 // =0x040001C0
	strh r1, [r0]
	bx lr
	.align 2, 0
_03805C6C: .word 0x00008202
_03805C70: .word 0x040001C0
	arm_func_end PMi_ChangeSpiModeTP

	arm_func_start PMi_ChangeSpiMode
PMi_ChangeSpiMode: // 0x03805C74
	ldr r1, _03805C88 // =0x00008002
	orr r1, r1, r0, lsl #11
	ldr r0, _03805C8C // =0x040001C0
	strh r1, [r0]
	bx lr
	.align 2, 0
_03805C88: .word 0x00008002
_03805C8C: .word 0x040001C0
	arm_func_end PMi_ChangeSpiMode

	arm_func_start PMi_SetLED
PMi_SetLED: // 0x03805C90
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r4, #1
	beq _03805CB4
	cmp r4, #2
	beq _03805CCC
	cmp r4, #3
	beq _03805CC0
	b _03805CE0
_03805CB4:
	mov r0, #0x10
	bl PMi_ResetControl
	b _03805CE4
_03805CC0:
	mov r0, #0x30
	bl PMi_SetControl
	b _03805CE4
_03805CCC:
	mov r0, #0x20
	bl PMi_ResetControl
	mov r0, #0x10
	bl PMi_SetControl
	b _03805CE4
_03805CE0:
	bl OS_Terminate
_03805CE4:
	ldr r0, _03805CF4 // =PMi_LEDStatus
	str r4, [r0]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_03805CF4: .word PMi_LEDStatus
	arm_func_end PMi_SetLED

	arm_func_start PMi_SwitchUtilityProc
PMi_SwitchUtilityProc: // 0x03805CF8
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0xf
	addls pc, pc, r0, lsl #2
	b _03805E18
_03805D0C: // jump table
	b _03805E18 // case 0
	b _03805D4C // case 1
	b _03805D60 // case 2
	b _03805D74 // case 3
	b _03805D88 // case 4
	b _03805D94 // case 5
	b _03805DA0 // case 6
	b _03805DAC // case 7
	b _03805DB8 // case 8
	b _03805DC4 // case 9
	b _03805DD0 // case 10
	b _03805DDC // case 11
	b _03805DE8 // case 12
	b _03805DF4 // case 13
	b _03805E0C // case 14
	b _03805E00 // case 15
_03805D4C:
	mov r0, #1
	bl PM_SetLEDPattern
	mov r0, #1
	bl PMi_SetLED
	b _03805E18
_03805D60:
	mov r0, #3
	bl PM_SetLEDPattern
	mov r0, #3
	bl PMi_SetLED
	b _03805E18
_03805D74:
	mov r0, #2
	bl PM_SetLEDPattern
	mov r0, #2
	bl PMi_SetLED
	b _03805E18
_03805D88:
	mov r0, #4
	bl PMi_SetControl
	b _03805E18
_03805D94:
	mov r0, #4
	bl PMi_ResetControl
	b _03805E18
_03805DA0:
	mov r0, #8
	bl PMi_SetControl
	b _03805E18
_03805DAC:
	mov r0, #8
	bl PMi_ResetControl
	b _03805E18
_03805DB8:
	mov r0, #0xc
	bl PMi_SetControl
	b _03805E18
_03805DC4:
	mov r0, #0xc
	bl PMi_ResetControl
	b _03805E18
_03805DD0:
	mov r0, #1
	bl PMi_SetControl
	b _03805E18
_03805DDC:
	mov r0, #1
	bl PMi_ResetControl
	b _03805E18
_03805DE8:
	mov r0, #2
	bl PMi_ResetControl
	b _03805E18
_03805DF4:
	mov r0, #2
	bl PMi_SetControl
	b _03805E18
_03805E00:
	mov r0, #0x40
	bl PMi_ResetControl
	b _03805E18
_03805E0C:
	bl SND_BeginSleep
	mov r0, #0x40
	bl PMi_SetControl
_03805E18:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end PMi_SwitchUtilityProc

	arm_func_start PMi_DoSleep
PMi_DoSleep: // 0x03805E24
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r5, #0
	ldr r0, _03805FE8 // =0x04000208
	ldrh r4, [r0, #0]
	strh r5, [r0]
	bl OS_DisableInterrupts
	mov r9, r0
	mvn r0, #0xfe000000
	bl OS_DisableIrqMask
	mov r8, r0
	mov r0, r5
	bl PMi_GetRegister
	mov r7, r0
	mov r0, #2
	bl PM_SetLEDPattern
	mov r0, #2
	bl PMi_SetLED
	mov r0, #2
	bl PMi_SetLED
	bl SND_BeginSleep
	mov r0, #1
	bl PMi_ResetControl
	ldr r0, _03805FEC // =PMi_TriggerBL
	ldrh r0, [r0, #0]
	ands r0, r0, #1
	beq _03805EAC
	ldr r0, _03805FF0 // =PMi_KeyPattern
	ldrh r0, [r0, #0]
	orr r1, r0, #0x4000
	ldr r0, _03805FF4 // =0x04000132
	strh r1, [r0]
	mov r0, #0x1000
	bl OS_EnableIrqMask
_03805EAC:
	ldr r0, _03805FEC // =PMi_TriggerBL
	ldrh r0, [r0, #0]
	ands r0, r0, #4
	beq _03805EC4
	mov r0, #0x400000
	bl OS_EnableIrqMask
_03805EC4:
	ldr r0, _03805FEC // =PMi_TriggerBL
	ldrh r0, [r0, #0]
	ands r0, r0, #2
	beq _03805F08
	ldr r0, _03805FF8 // =0x04000134
	ldrh r6, [r0, #0]
	mov r5, #1
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #0x40
	mov r1, #0
	bl EXIi_SetBitRcnt0L
	mov r0, #0x100
	mov r1, r0
	bl EXIi_SetBitRcnt0L
	mov r0, #0x80
	bl OS_EnableIrqMask
_03805F08:
	ldr r0, _03805FEC // =PMi_TriggerBL
	ldrh r0, [r0, #0]
	ands r0, r0, #8
	beq _03805F20
	mov r0, #0x100000
	bl OS_EnableIrqMask
_03805F20:
	ldr r0, _03805FEC // =PMi_TriggerBL
	ldrh r0, [r0, #0]
	ands r0, r0, #0x10
	beq _03805F38
	mov r0, #0x2000
	bl OS_EnableIrqMask
_03805F38:
	mov r0, r9
	bl OS_RestoreInterrupts
	ldr r1, _03805FE8 // =0x04000208
	ldrh r0, [r1, #0]
	mov r0, #1
	strh r0, [r1]
	bl _Ven__SVC_Sleep
	mov r0, #0
	mov r1, r7
	bl PMi_SetRegister
	ldr r0, _03805FEC // =PMi_TriggerBL
	ldrh r1, [r0, #0]
	ands r0, r1, #0x20
	movne r0, #6
	moveq r0, #7
	ands r1, r1, #0x40
	movne r7, #4
	moveq r7, #5
	bl PMi_SwitchUtilityProc
	mov r0, r7
	bl PMi_SwitchUtilityProc
	cmp r5, #0
	ldrne r0, _03805FF8 // =0x04000134
	strneh r6, [r0]
	mov r0, #1
	bl PMi_SetControl
	bl SND_EndSleep
	mov r1, #0
	ldr r0, _03805FFC // =PMi_Work
	str r1, [r0, #0x20]
	mov r0, #0x62
	mov r2, r1
	bl PMi_SendPxiCommand
	bl OS_DisableInterrupts
	mov r0, r8
	bl OS_SetIrqMask
	mov r0, r9
	bl OS_RestoreInterrupts
	ldr r1, _03805FE8 // =0x04000208
	ldrh r0, [r1, #0]
	strh r4, [r1]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_03805FE8: .word 0x04000208
_03805FEC: .word PMi_TriggerBL
_03805FF0: .word PMi_KeyPattern
_03805FF4: .word 0x04000132
_03805FF8: .word 0x04000134
_03805FFC: .word PMi_Work
	arm_func_end PMi_DoSleep

	arm_func_start _Ven__SVC_Sleep
_Ven__SVC_Sleep: // 0x03806000
	ldr ip, _03806008 // =SVC_Stop
	bx ip
	.align 2, 0
_03806008: .word SVC_Stop
	arm_func_end _Ven__SVC_Sleep

	arm_func_start PM_GetLEDPattern
PM_GetLEDPattern: // 0x0380600C
	ldr r0, _03806018 // =PMi_BlinkPatternNo
	ldr r0, [r0, #0]
	bx lr
	.align 2, 0
_03806018: .word PMi_BlinkPatternNo
	arm_func_end PM_GetLEDPattern

	arm_func_start PM_SetLEDPattern
PM_SetLEDPattern: // 0x0380601C
	cmp r0, #0xf
	ldrle r1, _03806038 // =PMi_BlinkPatternNo
	strle r0, [r1]
	movle r1, #0
	ldrle r0, _0380603C // =PMi_BlinkCounter
	strle r1, [r0]
	bx lr
	.align 2, 0
_03806038: .word PMi_BlinkPatternNo
_0380603C: .word PMi_BlinkCounter
	arm_func_end PM_SetLEDPattern

	arm_func_start PM_SelfBlinkProc
PM_SelfBlinkProc: // 0x03806040
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, _03806158 // =PMi_BlinkPatternNo
	ldr r3, [r0, #0]
	cmp r3, #0
	bne _0380607C
	mov r0, #3
	mov r1, #0x66
	mov r2, #1
	mov r3, r2
	bl SPIi_SetEntry
	cmp r0, #0
	beq _03806150
	mov r0, #1
	bl PM_SetLEDPattern
	b _03806150
_0380607C:
	cmp r3, #4
	bge _038060A8
	ldr r0, _0380615C // =PMi_LEDStatus
	ldr r0, [r0, #0]
	cmp r3, r0
	beq _03806150
	mov r0, #3
	mov r1, #0x66
	mov r2, #1
	bl SPIi_SetEntry
	b _03806150
_038060A8:
	ldr r6, _03806160 // =PMi_BlinkPatternData
	sub r1, r3, #4
	mov r0, #0xc
	mul r5, r1, r0
	add r4, r6, r5
	ldr r0, _03806164 // =PMi_BlinkCounter
	ldr r0, [r0, #0]
	ldrh r1, [r4, #0xa]
	bl _u32_div_f
	ldr r5, [r6, r5]
	ldr lr, [r4, #4]
	mov r3, #0
	mov r2, #0x80000000
	mov ip, r3, lsr r0
	rsb r1, r0, #0x20
	orr ip, ip, r2, lsl r1
	sub r1, r0, #0x20
	orr ip, ip, r2, lsr r1
	and r0, lr, r2, lsr r0
	and r1, r5, ip
	cmp r0, r3
	cmpeq r1, r3
	movne r3, #1
	moveq r3, #2
	ldr r0, _03806164 // =PMi_BlinkCounter
	ldr r1, [r0, #0]
	add ip, r1, #1
	str ip, [r0]
	ldrh r2, [r4, #8]
	ldrh r1, [r4, #0xa]
	mul r1, r2, r1
	cmp ip, r1
	movhs r1, #0
	strhs r1, [r0]
	ldr r0, _0380615C // =PMi_LEDStatus
	ldr r0, [r0, #0]
	cmp r3, r0
	beq _03806150
	mov r0, #3
	mov r1, #0x66
	mov r2, #1
	bl SPIi_SetEntry
_03806150:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_03806158: .word PMi_BlinkPatternNo
_0380615C: .word PMi_LEDStatus
_03806160: .word PMi_BlinkPatternData
_03806164: .word PMi_BlinkCounter
	arm_func_end PM_SelfBlinkProc

	.data

.public PMi_LEDStatus
PMi_LEDStatus:
	.word 1
	
.public PMi_BlinkPatternData
PMi_BlinkPatternData:
	.byte 0, 0, 0, 0, 0, 0, 0, 0xAA, 8, 0, 1, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0xCC, 8, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0x80
	.byte 0xE3, 0xC, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0xF0, 0xF0, 0x10
	.byte 0, 1, 0, 0, 0, 0, 0, 0, 0, 0x3E, 0xF8, 0x14, 0, 1
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0xFC, 0xC, 0, 1, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0xFF, 0x10, 0, 1, 0, 0, 0, 0, 0, 0, 0
	.byte 0xC0, 0xFF, 0x14, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0xFF
	.byte 0x20, 0, 1, 0, 0, 0, 0, 0, 0, 0xFF, 0, 0xFF, 0x20
	.byte 0, 1, 0, 0, 0, 0, 0, 0, 0xFF, 0xFF, 0xFF, 0x20, 0
	.byte 1, 0, 0, 0, 0, 0, 0, 0, 0, 0xC3, 0x28, 0, 2, 0
