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
	ldr r1, _0216A910 // =ovl09_216A94C
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216A90C: .word exFixRemainderTask__TaskSingleton
_0216A910: .word ovl09_216A94C
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
	bl ovl09_216A110
	bl ovl09_2169D90
	bl ovl09_21697B4
	bl ovl09_216A8B8
	ldr r0, _0216A948 // =exFixRemainderTask__TaskSingleton
	mov r1, #0
	str r1, [r0, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216A948: .word exFixRemainderTask__TaskSingleton
	arm_func_end exFixAdminTask__Destructor

	arm_func_start ovl09_216A94C
ovl09_216A94C: // 0x0216A94C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #4
	bne _0216A96C
	bl ovl09_216A97C
	ldmia sp!, {r3, pc}
_0216A96C:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end ovl09_216A94C

	arm_func_start ovl09_216A97C
ovl09_216A97C: // 0x0216A97C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exFixTimeTask__Create
	bl exFixRingTask__Create
	bl exMsgTutorialTask__Create
	bl GetExTaskCurrent
	ldr r1, _0216A9A4 // =ovl09_216A9A8
	str r1, [r0]
	bl ovl09_216A9A8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216A9A4: .word ovl09_216A9A8
	arm_func_end ovl09_216A97C

	arm_func_start ovl09_216A9A8
ovl09_216A9A8: // 0x0216A9A8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #4
	ldmlsia sp!, {r3, pc}
	bl ovl09_216A9C8
	ldmia sp!, {r3, pc}
	arm_func_end ovl09_216A9A8

	arm_func_start ovl09_216A9C8
ovl09_216A9C8: // 0x0216A9C8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_216C8BC
	bl exFixRemainderTask__Create
	bl exFixBossLifeGaugeTask__Create
	bl GetExTaskCurrent
	ldr r1, _0216A9F0 // =ovl09_216A9F4
	str r1, [r0]
	bl ovl09_216A9F4
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216A9F0: .word ovl09_216A9F4
	arm_func_end ovl09_216A9C8

	arm_func_start ovl09_216A9F4
ovl09_216A9F4: // 0x0216A9F4
	ldr ip, _0216A9FC // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_0216A9FC: .word GetExTaskWorkCurrent_
	arm_func_end ovl09_216A9F4

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

	arm_func_start ovl09_216AA78
ovl09_216AA78: // 0x0216AA78
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
	arm_func_end ovl09_216AA78

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