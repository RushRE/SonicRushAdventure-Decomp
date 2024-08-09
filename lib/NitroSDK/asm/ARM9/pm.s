	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public PMi_IsInit
PMi_IsInit: // 0x0214FFEC
    .space 0x02
	.align 4

.public PMi_SyncFlag
PMi_SyncFlag: // 0x0214FFF0
    .space 0x04

.public PMi_SleepEndFlag
PMi_SleepEndFlag: // 0x0214FFF4
    .space 0x04

.public PMi_PreSleepCallbackList
PMi_PreSleepCallbackList: // 0x0214FFF8
    .space 0x04

.public PMi_LCDCount
PMi_LCDCount: // 0x0214FFFC
    .space 0x04

.public PMi_PostSleepCallbackList
PMi_PostSleepCallbackList: // 0x02150000
    .space 0x04

.public PMi_Work
PMi_Work: // 0x02150004
    .space 0x10 // PMiWork

.public PMi_Mutex
PMi_Mutex: // 0x02150014
    .space 0x18 // OSMutex

.public PMi_RegisterBuffer
PMi_RegisterBuffer: // 0x0215002C
    .space 0x8 * 5 // PMData16[5]

	.text

	arm_func_start PM_PrependPostSleepCallback
PM_PrependPostSleepCallback: // 0x020EDFE8
	ldr ip, _020EDFF8 // =sub_20EE078
	mov r1, r0
	ldr r0, _020EDFFC // =PMi_PostSleepCallbackList
	bx ip
	.align 2, 0
_020EDFF8: .word sub_20EE078
_020EDFFC: .word PMi_PostSleepCallbackList
	arm_func_end PM_PrependPostSleepCallback

	arm_func_start PM_AppendPostSleepCallback
PM_AppendPostSleepCallback: // 0x020EE000
	ldr ip, _020EE010 // =sub_20EE078
	mov r1, r0
	ldr r0, _020EE014 // =PMi_PreSleepCallbackList
	bx ip
	.align 2, 0
_020EE010: .word sub_20EE078
_020EE014: .word PMi_PreSleepCallbackList
	arm_func_end PM_AppendPostSleepCallback

	arm_func_start PM_PrependPreSleepCallback
PM_PrependPreSleepCallback: // 0x020EE018
	ldr ip, _020EE028 // =sub_20EE0C4
	mov r1, r0
	ldr r0, _020EE02C // =PMi_PostSleepCallbackList
	bx ip
	.align 2, 0
_020EE028: .word sub_20EE0C4
_020EE02C: .word PMi_PostSleepCallbackList
	arm_func_end PM_PrependPreSleepCallback

	arm_func_start PM_AppendPreSleepCallback
PM_AppendPreSleepCallback: // 0x020EE030
	ldr ip, _020EE040 // =sub_20EE10C
	mov r1, r0
	ldr r0, _020EE044 // =PMi_PreSleepCallbackList
	bx ip
	.align 2, 0
_020EE040: .word sub_20EE10C
_020EE044: .word PMi_PreSleepCallbackList
	arm_func_end PM_AppendPreSleepCallback

	arm_func_start PMi_ExecuteList
PMi_ExecuteList: // 0x020EE048
	stmdb sp!, {r4, lr}
	movs r4, r0
	ldmeqia sp!, {r4, lr}
	bxeq lr
_020EE058:
	ldr r0, [r4, #4]
	ldr r1, [r4]
	blx r1
	ldr r4, [r4, #8]
	cmp r4, #0
	bne _020EE058
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end PMi_ExecuteList

	arm_func_start sub_20EE078
sub_20EE078: // 0x020EE078
	cmp r0, #0
	bxeq lr
	ldr r3, [r0]
	mov r2, r3
	cmp r3, #0
	bxeq lr
_020EE090:
	cmp r3, r1
	bne _020EE0B0
	cmp r3, r2
	ldreq r1, [r3, #8]
	streq r1, [r0]
	ldrne r0, [r3, #8]
	strne r0, [r2, #8]
	bx lr
_020EE0B0:
	mov r2, r3
	ldr r3, [r3, #8]
	cmp r3, #0
	bne _020EE090
	bx lr
	arm_func_end sub_20EE078

	arm_func_start sub_20EE0C4
sub_20EE0C4: // 0x020EE0C4
	cmp r0, #0
	bxeq lr
	ldr r2, [r0]
	cmp r2, #0
	moveq r2, #0
	streq r2, [r1, #8]
	streq r1, [r0]
	bxeq lr
	ldr r0, [r2, #8]
	cmp r0, #0
	beq _020EE100
_020EE0F0:
	mov r2, r0
	ldr r0, [r0, #8]
	cmp r0, #0
	bne _020EE0F0
_020EE100:
	str r0, [r1, #8]
	str r1, [r2, #8]
	bx lr
	arm_func_end sub_20EE0C4

	arm_func_start sub_20EE10C
sub_20EE10C: // 0x020EE10C
	cmp r0, #0
	ldrne r2, [r0]
	strne r2, [r1, #8]
	strne r1, [r0]
	bx lr
	arm_func_end sub_20EE10C

	arm_func_start PM_GetLEDPattern
PM_GetLEDPattern: // 0x020EE120
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020EE158 // =PMi_DummyCallback
	add r2, sp, #0
	bl PM_GetLEDPatternAsync
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	bl PMi_WaitBusy
	ldr r0, [sp]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EE158: .word PMi_DummyCallback
	arm_func_end PM_GetLEDPattern

	arm_func_start PM_GetLEDPatternAsync
PM_GetLEDPatternAsync: // 0x020EE15C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl PMi_Lock
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r1, _020EE1A4 // =PMi_Work
	ldr r0, _020EE1A8 // =0x03006700
	str r5, [r1, #4]
	str r4, [r1, #8]
	str r6, [r1, #0xc]
	bl PMi_SendPxiData
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020EE1A4: .word PMi_Work
_020EE1A8: .word 0x03006700
	arm_func_end PM_GetLEDPatternAsync

	arm_func_start PMi_SendLEDPatternCommand
PMi_SendLEDPatternCommand: // 0x020EE1AC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020EE1E4 // =PMi_DummyCallback
	add r2, sp, #0
	bl PMi_SendLEDPatternCommandAsync
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	bl PMi_WaitBusy
	ldr r0, [sp]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EE1E4: .word PMi_DummyCallback
	arm_func_end PMi_SendLEDPatternCommand

	arm_func_start PMi_SendLEDPatternCommandAsync
PMi_SendLEDPatternCommandAsync: // 0x020EE1E8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl PMi_Lock
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r0, _020EE234 // =0x03006600
	ldr r1, _020EE238 // =PMi_Work
	and r2, r6, #0xff
	orr r0, r2, r0
	str r5, [r1, #4]
	str r4, [r1, #8]
	bl PMi_SendPxiData
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020EE234: .word 0x03006600
_020EE238: .word PMi_Work
	arm_func_end PMi_SendLEDPatternCommandAsync

	arm_func_start PM_GetLCDPower
PM_GetLCDPower: // 0x020EE23C
	ldr r0, _020EE254 // =0x04000304
	ldrh r0, [r0]
	ands r0, r0, #1
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_020EE254: .word 0x04000304
	arm_func_end PM_GetLCDPower

	arm_func_start PM_SetLCDPower
PM_SetLCDPower: // 0x020EE258
	ldr ip, _020EE274 // =PMi_SetLCDPower
	mov r1, #0
	cmp r0, #1
	movne r0, #0
	mov r2, r1
	mov r3, #1
	bx ip
	.align 2, 0
_020EE274: .word PMi_SetLCDPower
	arm_func_end PM_SetLCDPower

	arm_func_start PMi_SetLCDPower
PMi_SetLCDPower: // 0x020EE278
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	beq _020EE300
	cmp r0, #1
	bne _020EE34C
	cmp r2, #0
	bne _020EE2C0
	ldr r2, _020EE35C // =0x027FFC3C
	ldr r0, _020EE360 // =PMi_LCDCount
	ldr r2, [r2]
	ldr r0, [r0]
	sub r0, r2, r0
	cmp r0, #7
	addls sp, sp, #4
	movls r0, #0
	ldmlsia sp!, {lr}
	bxls lr
_020EE2C0:
	cmp r1, #0
	beq _020EE2EC
	cmp r3, #0
	beq _020EE2DC
	mov r0, r1
	bl PMi_SetLED
	b _020EE2EC
_020EE2DC:
	mov r0, r1
	mov r1, #0
	mov r2, r1
	bl PMi_SetLEDAsync
_020EE2EC:
	ldr r1, _020EE364 // =0x04000304
	ldrh r0, [r1]
	orr r0, r0, #1
	strh r0, [r1]
	b _020EE34C
_020EE300:
	ldr lr, _020EE364 // =0x04000304
	ldr r2, _020EE35C // =0x027FFC3C
	ldrh ip, [lr]
	ldr r0, _020EE360 // =PMi_LCDCount
	cmp r1, #0
	bic ip, ip, #1
	strh ip, [lr]
	ldr r2, [r2]
	str r2, [r0]
	beq _020EE34C
	cmp r3, #0
	beq _020EE33C
	mov r0, r1
	bl PMi_SetLED
	b _020EE34C
_020EE33C:
	mov r0, r1
	mov r1, #0
	mov r2, r1
	bl PMi_SetLEDAsync
_020EE34C:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EE35C: .word 0x027FFC3C
_020EE360: .word PMi_LCDCount
_020EE364: .word 0x04000304
	arm_func_end PMi_SetLCDPower

	arm_func_start PM_GoSleepMode
PM_GoSleepMode: // 0x020EE368
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x1c
	ldr r3, _020EE584 // =PMi_PreSleepCallbackList
	mov sl, r0
	ldr r0, [r3]
	mov sb, r1
	mov fp, r2
	mov r8, #0
	bl PMi_ExecuteList
	ldr r1, _020EE588 // =0x04000208
	mov r0, r8
	ldrh r4, [r1]
	strh r0, [r1]
	bl OS_DisableInterrupts
	str r0, [sp]
	ldr r0, _020EE58C // =0x003FFFFF
	bl OS_DisableIrqMask
	str r0, [sp, #4]
	mov r0, #0x40000
	bl OS_SetIrqMask
	ldr r0, [sp]
	bl OS_RestoreInterrupts
	ldr r2, _020EE588 // =0x04000208
	mov r1, #1
	ldrh r0, [r2]
	ands r0, sl, #8
	strh r1, [r2]
	beq _020EE3E8
	ldr r0, _020EE590 // =0x027FFC40
	ldrh r0, [r0]
	cmp r0, #2
	biceq sl, sl, #8
_020EE3E8:
	ands r0, sl, #0x10
	beq _020EE3FC
	bl CTRDG_IsExisting
	cmp r0, #0
	biceq sl, sl, #0x10
_020EE3FC:
	ldr r0, _020EE594 // =0x04001000
	mov r1, #0x4000000
	ldr r7, [r1]
	ldr r6, [r0]
	bl PM_GetLCDPower
	str r0, [sp, #8]
	add r0, sp, #0xc
	add r1, sp, #0x10
	bl PM_GetBackLight
	mov r0, #2
	mov r1, #0
	bl PM_SetBackLight
	ldr r2, _020EE598 // =0x027FFC3C
	ldr r0, [r2]
	str r0, [sp, #0x14]
_020EE438:
	ldr r1, [r2]
	ldr r0, [sp, #0x14]
	cmp r0, r1
	beq _020EE438
	ldr r0, [r2]
	mov r2, #0x4000000
	str r0, [sp, #0x14]
	ldr r0, [r2]
	ldr r1, _020EE594 // =0x04001000
	bic r0, r0, #0x30000
	str r0, [r2]
	ldr r0, [r1]
	bic r0, r0, #0x10000
	str r0, [r1]
	ldr r2, _020EE598 // =0x027FFC3C
_020EE474:
	ldr r1, [r2]
	ldr r0, [sp, #0x14]
	cmp r0, r1
	beq _020EE474
	ldr r0, [r2]
	str r0, [sp, #0x14]
	ldr r2, _020EE598 // =0x027FFC3C
_020EE490:
	ldr r1, [r2]
	ldr r0, [sp, #0x14]
	cmp r0, r1
	beq _020EE490
	ldr r0, [sp, #0xc]
	ldr r1, [sp, #0x10]
	orr r0, sl, r0, lsl #5
	orr r0, r0, r1, lsl #6
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	orr r0, sb, fp
	mov r0, r0, lsl #0x10
	mov sb, r0, lsr #0x10
_020EE4C4:
	mov r0, r5
	mov r1, sb
	bl PMi_SendSleepStart
	cmp r0, #0
	bne _020EE4C4
	bl OS_Halt
	ldr r0, _020EE59C // =0x00996A00
	bl OS_SpinWait
	ands r0, sl, #8
	beq _020EE4FC
	ldr r0, _020EE5A0 // =0x04000214
	ldr r0, [r0]
	ands r0, r0, #0x100000
	movne r8, #1
_020EE4FC:
	cmp r8, #0
	bne _020EE540
	ldr r0, [sp, #8]
	cmp r0, #1
	bne _020EE528
	mov r0, #1
	mov r1, r0
	mov r2, r0
	mov r3, #0
	bl PMi_SetLCDPower
	b _020EE530
_020EE528:
	mov r0, #1
	bl PMi_SetLED
_020EE530:
	mov r1, #0x4000000
	ldr r0, _020EE594 // =0x04001000
	str r7, [r1]
	str r6, [r0]
_020EE540:
	bl OS_DisableInterrupts
	ldr r0, [sp, #4]
	bl OS_SetIrqMask
	ldr r0, [sp]
	bl OS_RestoreInterrupts
	ldr r1, _020EE588 // =0x04000208
	cmp r8, #0
	ldrh r0, [r1]
	strh r4, [r1]
	beq _020EE56C
	bl PM_ForceToPowerOff
_020EE56C:
	ldr r0, _020EE5A4 // =PMi_PostSleepCallbackList
	ldr r0, [r0]
	bl PMi_ExecuteList
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	bx lr
	.align 2, 0
_020EE584: .word PMi_PreSleepCallbackList
_020EE588: .word 0x04000208
_020EE58C: .word 0x003FFFFF
_020EE590: .word 0x027FFC40
_020EE594: .word 0x04001000
_020EE598: .word 0x027FFC3C
_020EE59C: .word 0x00996A00
_020EE5A0: .word 0x04000214
_020EE5A4: .word PMi_PostSleepCallbackList
	arm_func_end PM_GoSleepMode

	arm_func_start PMi_SendPxiData
PMi_SendPxiData: // 0x020EE5A8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, #8
	mov r4, #0
_020EE5B8:
	mov r0, r5
	mov r1, r6
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	bne _020EE5B8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end PMi_SendPxiData

	arm_func_start PM_GetBackLight
PM_GetBackLight: // 0x020EE5D8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r5, r0
	add r1, sp, #0
	mov r0, #0
	bl PM_SendUtilityCommand
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	cmp r5, #0
	beq _020EE620
	ldrh r1, [sp]
	ands r1, r1, #8
	movne r1, #1
	moveq r1, #0
	str r1, [r5]
_020EE620:
	cmp r4, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldrh r1, [sp]
	ands r1, r1, #4
	movne r1, #1
	moveq r1, #0
	str r1, [r4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end PM_GetBackLight

	arm_func_start PM_SetAmp
PM_SetAmp: // 0x020EE650
	ldr ip, _020EE664 // =PMi_WriteRegister
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, #2
	bx ip
	.align 2, 0
_020EE664: .word PMi_WriteRegister
	arm_func_end PM_SetAmp

	arm_func_start PM_ForceToPowerOff
PM_ForceToPowerOff: // 0x020EE668
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020EE6A0 // =PMi_DummyCallback
	add r1, sp, #0
	bl PM_ForceToPowerOffAsync
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	bl PMi_WaitBusy
	ldr r0, [sp]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EE6A0: .word PMi_DummyCallback
	arm_func_end PM_ForceToPowerOff

	arm_func_start PM_ForceToPowerOffAsync
PM_ForceToPowerOffAsync: // 0x020EE6A4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	ldr r0, _020EE750 // =0x00996A00
	mov r6, r1
	bl OS_SpinWait
	bl PM_GetLCDPower
	cmp r0, #1
	beq _020EE734
	add r0, sp, #0
	add r1, sp, #4
	bl PM_GetBackLight
	ldr r0, [sp]
	cmp r0, #0
	beq _020EE6EC
	mov r0, #0
	mov r1, r0
	bl PM_SetBackLight
_020EE6EC:
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _020EE704
	mov r0, #1
	mov r1, #0
	bl PM_SetBackLight
_020EE704:
	mov r0, #1
	bl PM_SetLCDPower
	cmp r0, #0
	bne _020EE734
	ldr r5, _020EE750 // =0x00996A00
	mov r4, #1
_020EE71C:
	mov r0, r5
	bl OS_SpinWait
	mov r0, r4
	bl PM_SetLCDPower
	cmp r0, #0
	beq _020EE71C
_020EE734:
	mov r1, r7
	mov r2, r6
	mov r0, #0xe
	bl PM_SendUtilityCommandAsync
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020EE750: .word 0x00996A00
	arm_func_end PM_ForceToPowerOffAsync

	arm_func_start PM_SetBackLight
PM_SetBackLight: // 0x020EE754
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _020EE78C // =PMi_DummyCallback
	add r3, sp, #0
	bl PM_SetBackLightAsync
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	bl PMi_WaitBusy
	ldr r0, [sp]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EE78C: .word PMi_DummyCallback
	arm_func_end PM_SetBackLight

	arm_func_start PM_SetBackLightAsync
PM_SetBackLightAsync: // 0x020EE790
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	mov ip, #0
	bne _020EE7B8
	cmp r1, #1
	moveq ip, #6
	cmp r1, #0
	moveq ip, #7
	b _020EE7EC
_020EE7B8:
	cmp r0, #1
	bne _020EE7D4
	cmp r1, #1
	moveq ip, #4
	cmp r1, #0
	moveq ip, #5
	b _020EE7EC
_020EE7D4:
	cmp r0, #2
	bne _020EE7EC
	cmp r1, #1
	moveq ip, #8
	cmp r1, #0
	moveq ip, #9
_020EE7EC:
	cmp ip, #0
	addeq sp, sp, #4
	ldreq r0, _020EE81C // =0x0000FFFF
	ldmeqia sp!, {lr}
	bxeq lr
	mov r1, r2
	mov r0, ip
	mov r2, r3
	bl PM_SendUtilityCommandAsync
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EE81C: .word 0x0000FFFF
	arm_func_end PM_SetBackLightAsync

	arm_func_start PMi_SetLED
PMi_SetLED: // 0x020EE820
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020EE858 // =PMi_DummyCallback
	add r2, sp, #0
	bl PMi_SetLEDAsync
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	bl PMi_WaitBusy
	ldr r0, [sp]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EE858: .word PMi_DummyCallback
	arm_func_end PMi_SetLED

	arm_func_start PMi_SetLEDAsync
PMi_SetLEDAsync: // 0x020EE85C
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #1
	beq _020EE880
	cmp r0, #2
	beq _020EE890
	cmp r0, #3
	beq _020EE888
	b _020EE898
_020EE880:
	mov r0, #1
	b _020EE89C
_020EE888:
	mov r0, #2
	b _020EE89C
_020EE890:
	mov r0, #3
	b _020EE89C
_020EE898:
	mov r0, #0
_020EE89C:
	cmp r0, #0
	addeq sp, sp, #4
	ldreq r0, _020EE8C0 // =0x0000FFFF
	ldmeqia sp!, {lr}
	bxeq lr
	bl PM_SendUtilityCommandAsync
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EE8C0: .word 0x0000FFFF
	arm_func_end PMi_SetLEDAsync

	arm_func_start PMi_WriteRegister
PMi_WriteRegister: // 0x020EE8C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _020EE8FC // =PMi_DummyCallback
	add r3, sp, #0
	bl PMi_WriteRegisterAsync
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	bl PMi_WaitBusy
	ldr r0, [sp]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EE8FC: .word PMi_DummyCallback
	arm_func_end PMi_WriteRegister

	arm_func_start PMi_WriteRegisterAsync
PMi_WriteRegisterAsync: // 0x020EE900
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r4, r1
	mov r6, r2
	mov r5, r3
	bl PMi_Lock
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldr r0, _020EE970 // =0x02006400
	ldr r1, _020EE974 // =PMi_Work
	and r2, r7, #0xff
	orr r0, r2, r0
	str r6, [r1, #4]
	str r5, [r1, #8]
	bl PMi_SendPxiData
	ldr r0, _020EE978 // =0x0000FFFF
	ldr r1, _020EE97C // =0x01010000
	and r0, r4, r0
	orr r0, r0, r1
	bl PMi_SendPxiData
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020EE970: .word 0x02006400
_020EE974: .word PMi_Work
_020EE978: .word 0x0000FFFF
_020EE97C: .word 0x01010000
	arm_func_end PMi_WriteRegisterAsync

	arm_func_start PM_SendUtilityCommand
PM_SendUtilityCommand: // 0x020EE980
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _020EE9B8 // =PMi_DummyCallback
	add r3, sp, #0
	bl PMi_ReadRegisterAsync
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	bl PMi_WaitBusy
	ldr r0, [sp]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EE9B8: .word PMi_DummyCallback
	arm_func_end PM_SendUtilityCommand

	arm_func_start PMi_ReadRegisterAsync
PMi_ReadRegisterAsync: // 0x020EE9BC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl PMi_Lock
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldr ip, _020EEA24 // =PMi_RegisterBuffer
	ldr r1, _020EEA28 // =PMi_Work
	ldr r0, _020EEA2C // =0x03006500
	and r2, r7, #0xff
	mov lr, r7, lsl #3
	mov r8, #0
	ldr r3, _020EEA30 // =0x02150030
	strh r8, [ip, lr]
	orr r0, r2, r0
	str r5, [r1, #4]
	str r4, [r1, #8]
	str r6, [r3, r7, lsl #3]
	bl PMi_SendPxiData
	mov r0, r8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020EEA24: .word PMi_RegisterBuffer
_020EEA28: .word PMi_Work
_020EEA2C: .word 0x03006500
_020EEA30: .word 0x02150030
	arm_func_end PMi_ReadRegisterAsync

	arm_func_start PM_SendUtilityCommandAsync
PM_SendUtilityCommandAsync: // 0x020EEA34
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r6, r1
	mov r5, r2
	bl PMi_Lock
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	mov r2, r4, lsr #0x10
	ldr r1, _020EEA98 // =PMi_Work
	ldr r0, _020EEA9C // =0x02006300
	and r2, r2, #0xff
	orr r0, r2, r0
	str r6, [r1, #4]
	str r5, [r1, #8]
	bl PMi_SendPxiData
	ldr r0, _020EEAA0 // =0x0000FFFF
	ldr r1, _020EEAA4 // =0x01010000
	and r0, r4, r0
	orr r0, r0, r1
	bl PMi_SendPxiData
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020EEA98: .word PMi_Work
_020EEA9C: .word 0x02006300
_020EEAA0: .word 0x0000FFFF
_020EEAA4: .word 0x01010000
	arm_func_end PM_SendUtilityCommandAsync

	arm_func_start PMi_SendSleepStart
PMi_SendSleepStart: // 0x020EEAA8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl PMi_Lock
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r1, _020EEB48 // =PMi_SyncFlag
	mov r2, #0
	ldr r0, _020EEB4C // =0x03006000
	str r2, [r1]
	bl PMi_SendPxiData
	ldr r1, _020EEB48 // =PMi_SyncFlag
_020EEAE8:
	ldr r0, [r1]
	cmp r0, #0
	beq _020EEAE8
	mov r0, #0
	ldr ip, _020EEB50 // =PMi_SleepEndFlag
	str r0, [r1]
	mov r2, r0
	mov r3, r0
	mov r1, #2
	str r0, [ip]
	bl PMi_SetLCDPower
	ldr r0, _020EEB54 // =0x02006100
	and r1, r5, #0xff
	orr r0, r1, r0
	bl PMi_SendPxiData
	ldr r0, _020EEB58 // =0x0000FFFF
	ldr r1, _020EEB5C // =0x01010000
	and r0, r4, r0
	orr r0, r0, r1
	bl PMi_SendPxiData
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020EEB48: .word PMi_SyncFlag
_020EEB4C: .word 0x03006000
_020EEB50: .word PMi_SleepEndFlag
_020EEB54: .word 0x02006100
_020EEB58: .word 0x0000FFFF
_020EEB5C: .word 0x01010000
	arm_func_end PMi_SendSleepStart

	arm_func_start PMi_CommonCallback
PMi_CommonCallback: // 0x020EEB60
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r2, #0
	beq _020EEB84
	mov r0, #2
	bl PMi_CallCallbackAndUnlock
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020EEB84:
	and r0, r1, #0x7f00
	mov r0, r0, lsl #8
	and r1, r1, #0xff
	mov r2, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	cmp r2, #0x70
	mov r0, r0, lsr #0x10
	blo _020EEBE4
	cmp r2, #0x74
	bhi _020EEBE4
	ldr r1, _020EEC38 // =0x02150030
	sub r2, r2, #0x70
	and r0, r0, #0xff
	ldr r1, [r1, r2, lsl #3]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r1, #0
	strneh r0, [r1]
	mov r1, r2, lsl #3
	ldr r0, _020EEC3C // =PMi_RegisterBuffer
	mov r2, #1
	strh r2, [r0, r1]
	mov r0, #0
	b _020EEC28
_020EEBE4:
	cmp r2, #0x60
	ldreq r1, _020EEC40 // =PMi_SyncFlag
	moveq r2, #1
	streq r2, [r1]
	beq _020EEC28
	cmp r2, #0x62
	ldreq r1, _020EEC44 // =PMi_SleepEndFlag
	moveq r2, #1
	streq r2, [r1]
	beq _020EEC28
	cmp r2, #0x67
	bne _020EEC28
	ldr r1, _020EEC48 // =PMi_Work
	ldr r1, [r1, #0xc]
	cmp r1, #0
	strne r0, [r1]
	mov r0, #0
_020EEC28:
	bl PMi_CallCallbackAndUnlock
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EEC38: .word 0x02150030
_020EEC3C: .word PMi_RegisterBuffer
_020EEC40: .word PMi_SyncFlag
_020EEC44: .word PMi_SleepEndFlag
_020EEC48: .word PMi_Work
	arm_func_end PMi_CommonCallback

	arm_func_start PM_Init
PM_Init: // 0x020EEC4C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _020EECF4 // =PMi_IsInit
	ldrh r0, [r1]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	ldr r0, _020EECF8 // =PMi_Work
	mov r2, #0
	mov r3, #1
	strh r3, [r1]
	str r2, [r0]
	str r2, [r0, #4]
	bl PXI_Init
	mov r5, #8
	mov r4, #1
_020EEC90:
	mov r0, r5
	mov r1, r4
	bl PXI_IsCallbackReady
	cmp r0, #0
	beq _020EEC90
	ldr r1, _020EECFC // =PMi_CommonCallback
	mov r0, #8
	bl PXI_SetFifoRecvCallback
	mov r3, #0
	ldr r0, _020EED00 // =PMi_RegisterBuffer
	mov r2, r3
_020EECBC:
	mov r1, r3, lsl #3
	add r3, r3, #1
	strh r2, [r0, r1]
	cmp r3, #5
	blt _020EECBC
	ldr r0, _020EED04 // =PMi_Mutex
	bl OS_InitMutex
	ldr r1, _020EED08 // =0x027FFC3C
	ldr r0, _020EED0C // =PMi_LCDCount
	ldr r1, [r1]
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020EECF4: .word PMi_IsInit
_020EECF8: .word PMi_Work
_020EECFC: .word PMi_CommonCallback
_020EED00: .word PMi_RegisterBuffer
_020EED04: .word PMi_Mutex
_020EED08: .word 0x027FFC3C
_020EED0C: .word PMi_LCDCount
	arm_func_end PM_Init

	arm_func_start PMi_CallCallbackAndUnlock
PMi_CallCallbackAndUnlock: // 0x020EED10
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _020EED60 // =PMi_Work
	ldr r1, [r2]
	ldr ip, [r2, #4]
	cmp r1, #0
	movne r3, #0
	strne r3, [r2]
	cmp ip, #0
	addeq sp, sp, #4
	ldr r1, [r2, #8]
	ldmeqia sp!, {lr}
	bxeq lr
	ldr r2, _020EED60 // =PMi_Work
	mov r3, #0
	str r3, [r2, #4]
	blx ip
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EED60: .word PMi_Work
	arm_func_end PMi_CallCallbackAndUnlock

	arm_func_start PMi_DummyCallback
PMi_DummyCallback: // 0x020EED64
	str r0, [r1]
	bx lr
	arm_func_end PMi_DummyCallback

	arm_func_start PMi_WaitBusy
PMi_WaitBusy: // 0x020EED6C
	stmdb sp!, {r4, lr}
	ldr r4, _020EEDA8 // =PMi_Work
	ldr r0, [r4]
	cmp r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
_020EED84:
	bl OS_GetCpsrIrq
	cmp r0, #0x80
	bne _020EED94
	bl PXIi_HandlerRecvFifoNotEmpty
_020EED94:
	ldr r0, [r4]
	cmp r0, #0
	bne _020EED84
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020EEDA8: .word PMi_Work
	arm_func_end PMi_WaitBusy

	arm_func_start PMi_Lock
PMi_Lock: // 0x020EEDAC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	ldr r1, _020EEDF8 // =PMi_Work
	ldr r2, [r1]
	cmp r2, #0
	beq _020EEDDC
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {lr}
	bx lr
_020EEDDC:
	mov r2, #1
	str r2, [r1]
	bl OS_RestoreInterrupts
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EEDF8: .word PMi_Work
	arm_func_end PMi_Lock