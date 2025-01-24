	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

exFixRemainderTask__TaskSingleton: // 0x021766A8
    .space 0x04
	
exFixBossLifeGaugeTask__TaskSingleton: // 0x021766AC
    .space 0x04
	
exFixAdminTask__TaskSingleton: // 0x021766B0
    .space 0x04
	
exFixTimeTask__TaskSingleton: // 0x021766B4
    .space 0x04
	
exFixRingTask__TaskSingleton: // 0x021766B8
    .space 0x04
	
exFixTimeTask__byte_21766BC: // 0x21766BC
	.space 0xDD4

	.text

	arm_func_start exFixAdminTask__Main
exFixAdminTask__Main: // 0x0216A8E4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetStatus
	bl GetCurrentTask
	ldr r1, _0216A90C // =exFixRemainderTask__TaskSingleton
	str r0, [r1, #8]
	bl GetExTaskCurrent
	ldr r1, _0216A910 // =exFixAdminTask__Main_WaitForCommonHUD
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216A90C: .word exFixRemainderTask__TaskSingleton
_0216A910: .word exFixAdminTask__Main_WaitForCommonHUD
	arm_func_end exFixAdminTask__Main

	arm_func_start exFixAdminTask__Func8
exFixAdminTask__Func8: // 0x0216A914
	ldr ip, _0216A91C // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_0216A91C: .word GetExTaskWorkCurrent_
	arm_func_end exFixAdminTask__Func8

	arm_func_start exFixAdminTask__Destructor
exFixAdminTask__Destructor: // 0x0216A920
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exFixRemainderTask__Destroy
	bl exFixRingTask__Destroy
	bl exFixTimeTask__Destroy
	bl exFixBossLifeGaugeTask__Destroy
	ldr r0, _0216A948 // =exFixRemainderTask__TaskSingleton
	mov r1, #0
	str r1, [r0, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216A948: .word exFixRemainderTask__TaskSingleton
	arm_func_end exFixAdminTask__Destructor

	arm_func_start exFixAdminTask__Main_WaitForCommonHUD
exFixAdminTask__Main_WaitForCommonHUD: // 0x0216A94C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #4
	bne _0216A96C
	bl exFixAdminTask__Action_CreateCommonHUD
	ldmia sp!, {r3, pc}
_0216A96C:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exFixAdminTask__Main_WaitForCommonHUD

	arm_func_start exFixAdminTask__Action_CreateCommonHUD
exFixAdminTask__Action_CreateCommonHUD: // 0x0216A97C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exFixTimeTask__Create
	bl exFixRingTask__Create
	bl exMsgTutorialTask__Create
	bl GetExTaskCurrent
	ldr r1, _0216A9A4 // =exFixAdminTask__Main_WaitForBossHUD
	str r1, [r0]
	bl exFixAdminTask__Main_WaitForBossHUD
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216A9A4: .word exFixAdminTask__Main_WaitForBossHUD
	arm_func_end exFixAdminTask__Action_CreateCommonHUD

	arm_func_start exFixAdminTask__Main_WaitForBossHUD
exFixAdminTask__Main_WaitForBossHUD: // 0x0216A9A8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #4
	ldmlsia sp!, {r3, pc}
	bl exFixAdminTask__Action_CreateBossHUD
	ldmia sp!, {r3, pc}
	arm_func_end exFixAdminTask__Main_WaitForBossHUD

	arm_func_start exFixAdminTask__Action_CreateBossHUD
exFixAdminTask__Action_CreateBossHUD: // 0x0216A9C8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exMsgTutorialTask__Destroy
	bl exFixRemainderTask__Create
	bl exFixBossLifeGaugeTask__Create
	bl GetExTaskCurrent
	ldr r1, _0216A9F0 // =exFixAdminTask__Main_Idle
	str r1, [r0]
	bl exFixAdminTask__Main_Idle
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216A9F0: .word exFixAdminTask__Main_Idle
	arm_func_end exFixAdminTask__Action_CreateBossHUD

	arm_func_start exFixAdminTask__Main_Idle
exFixAdminTask__Main_Idle: // 0x0216A9F4
	ldr ip, _0216A9FC // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_0216A9FC: .word GetExTaskWorkCurrent_
	arm_func_end exFixAdminTask__Main_Idle

	arm_func_start exFixAdminTask__Create
exFixAdminTask__Create: // 0x0216AA00
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #2
	ldr r0, _0216AA68 // =aExfixadmintask
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0216AA6C // =exFixAdminTask__Main
	ldr r1, _0216AA70 // =exFixAdminTask__Destructor
	mov r2, #0x1800
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r1, #0
	mov r2, #2
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, _0216AA74 // =exFixAdminTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216AA68: .word aExfixadmintask
_0216AA6C: .word exFixAdminTask__Main
_0216AA70: .word exFixAdminTask__Destructor
_0216AA74: .word exFixAdminTask__Func8
	arm_func_end exFixAdminTask__Create

	arm_func_start exFixAdminTask__Destroy
exFixAdminTask__Destroy: // 0x0216AA78
	stmdb sp!, {r3, lr}
	ldr r0, _0216AA9C // =exFixRemainderTask__TaskSingleton
	ldr r0, [r0, #8]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, _0216AAA0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216AA9C: .word exFixRemainderTask__TaskSingleton
_0216AAA0: .word ExTask_State_Destroy
	arm_func_end exFixAdminTask__Destroy

	.data
	
_02175CA0: // 0x02175CA0
    .hword 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 0x30, 0x31, 0x32, 0x33, 0x34, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F, 0x40

_02175CC8: // 0x02175CC8
    .hword 0x1F, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28

_02175CDC: // 0x02175CDC
    .hword 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 0x30, 0x31, 0x32, 0x33, 0x34

_02175CF0: // 0x02175CF0
    .hword 0x1F, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28

aExfixtimetask: // 0x02175D04
	.asciz "exFixTimeTask"
	.align 4
	
aExfixringtask: // 0x02175D14
	.asciz "exFixRingTask"
	.align 4
	
aExfixremainder: // 0x02175D24
	.asciz "exFixRemainderTask"
	.align 4
	
aExfixbosslifeg: // 0x02175D38
	.asciz "exFixBossLifeGaugeTask"
	.align 4
	
aExfixadmintask: // 0x02175D50
	.asciz "exFixAdminTask"