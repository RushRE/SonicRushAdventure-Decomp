	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

exBossMeteLockOnTask__ActiveInstanceCount: // 0x021761CC
	.space 0x02

exBossMeteBombTask__ActiveInstanceCount: // 0x021761CE
	.space 0x02

exBossMeteMeteoTask__ActiveInstanceCount: // 0x021761D0
	.space 0x02

	.align 4

exBossMeteMeteoTask__FileTable: // 0x021761D4
    .space 0x04
	
exBossMeteMeteoTask_unk_21761D8: // 0x021761D8
    .space 0x04
	
exBossMeteMeteoTask__AnimTable: // 0x021761DC
    .space 0x04
	
exBossMeteBombTask__unk_21761E0: // 0x021761E0
    .space 0x04
	
exBossMeteMeteoTask__TaskSingleton: // 0x021761E4
    .space 0x04
	
exBossMeteMeteoTask__unk_21761E8: // 0x021761E8
    .space 0x04
	
exBossMeteMeteoTask__dword_21761EC: // 0x021761EC
    .space 0x04
	
exBossMeteBombTask__unk_21761F0: // 0x021761F0
    .space 0x04
	
exBossMeteMeteoTask__unk_21761F4: // 0x021761F4
    .space 0x04
	
exBossMeteMeteoTask__dword_21761F8: // 0x021761F8
    .space 0x04
	
exBossMeteLockOnTask__unk_21761FC: // 0x021761FC
    .space 0x04
	
exBossMeteLockOnTask__TaskSingleton: // 0x02176200
    .space 0x04
	
exBossMeteAdminTask__TaskSingleton: // 0x02176204
    .space 0x04
	
exBossMeteLockOnTask__unk_2176208: // 0x02176208
    .space 0x04
	
exBossMeteLockOnTask__unk_217620C: // 0x0217620C
    .space 0x04

exBossMeteLockOnTask__unk_2176210: // 0x02176210
    .space 0x04
	
exBossMeteLockOnTask__dword_2176214: // 0x02176214
    .space 0x04
	
exBossMeteBombTask__dword_2176218: // 0x02176218
    .space 0x04
	
exBossMeteBombTask__TaskSingleton: // 0x0217621C
    .space 0x04
	
exBossMeteBombTask__unk_2176220: // 0x02176220
    .space 0x04
	
exBossMeteBombTask__dword_2176224: // 0x02176224
    .space 0x04
	
exBossMeteLockOnTask__AnimTable: // 0x02176228
    .space 0x04 * 3
	
exBossMeteLockOnTask__FileTable: // 0x02176234
    .space 0x04 * 3
	
exBossMeteMeteoTask__unk_2176240: // 0x02176240
    .space 0x04
	
exBossMeteMeteoTask__unk_2176244: // 0x02176244
    .space 0x04
	
exBossMeteMeteoTask__unk_2176248: // 0x02176248
    .space 0x04
	
exBossMeteBombTask__AnimTable: // 0x0217624C
    .space 0x04 * 4
	
exBossMeteBombTask__FileTable: // 0x0217625C
    .space 0x04 * 4

	.text

	arm_func_start exBossMeteAdminTask__Main
exBossMeteAdminTask__Main: // 0x0215DA30
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetCurrentTask
	ldr r1, _0215DA58 // =exBossMeteLockOnTask__ActiveInstanceCount
	str r0, [r1, #0x38]
	bl GetExTaskCurrent
	ldr r1, _0215DA5C // =exBossMeteAdminTask__Func_215DAA4
	str r1, [r0]
	bl exBossMeteAdminTask__Func_215DAA4
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DA58: .word exBossMeteLockOnTask__ActiveInstanceCount
_0215DA5C: .word exBossMeteAdminTask__Func_215DAA4
	arm_func_end exBossMeteAdminTask__Main

	arm_func_start exBossMeteAdminTask__Func8
exBossMeteAdminTask__Func8: // 0x0215DA60
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0215DA84 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DA84: .word ExTask_State_Destroy
	arm_func_end exBossMeteAdminTask__Func8

	arm_func_start exBossMeteAdminTask__Destructor
exBossMeteAdminTask__Destructor: // 0x0215DA88
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, _0215DAA0 // =exBossMeteLockOnTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x38]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DAA0: .word exBossMeteLockOnTask__ActiveInstanceCount
	arm_func_end exBossMeteAdminTask__Destructor

	arm_func_start exBossMeteAdminTask__Func_215DAA4
exBossMeteAdminTask__Func_215DAA4: // 0x0215DAA4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _0215DAC0
	bl exBossMeteAdminTask__Func_215DAD0
	ldmia sp!, {r3, pc}
_0215DAC0:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exBossMeteAdminTask__Func_215DAA4

	arm_func_start exBossMeteAdminTask__Func_215DAD0
exBossMeteAdminTask__Func_215DAD0: // 0x0215DAD0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, _0215DAEC // =exBossMeteAdminTask__Func_215DAF0
	str r1, [r0]
	bl exBossMeteAdminTask__Func_215DAF0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DAEC: .word exBossMeteAdminTask__Func_215DAF0
	arm_func_end exBossMeteAdminTask__Func_215DAD0

	arm_func_start exBossMeteAdminTask__Func_215DAF0
exBossMeteAdminTask__Func_215DAF0: // 0x0215DAF0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _0215DB0C
	bl exBossMeteAdminTask__Func_215DB1C
	ldmia sp!, {r3, pc}
_0215DB0C:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exBossMeteAdminTask__Func_215DAF0

	arm_func_start exBossMeteAdminTask__Func_215DB1C
exBossMeteAdminTask__Func_215DB1C: // 0x0215DB1C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, _0215DB38 // =exBossMeteAdminTask__Func_215DB3C
	str r1, [r0]
	bl exBossMeteAdminTask__Func_215DB3C
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DB38: .word exBossMeteAdminTask__Func_215DB3C
	arm_func_end exBossMeteAdminTask__Func_215DB1C

	arm_func_start exBossMeteAdminTask__Func_215DB3C
exBossMeteAdminTask__Func_215DB3C: // 0x0215DB3C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldmia r0, {r1, r2}
	ldr r0, [r1, #0x3c]
	cmp r0, #0
	beq _0215DB68
	mov r0, #1
	str r0, [r2, #4]
	bl GetExTaskCurrent
	ldr r1, _0215DB78 // =ExTask_State_Destroy
	str r1, [r0]
_0215DB68:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DB78: .word ExTask_State_Destroy
	arm_func_end exBossMeteAdminTask__Func_215DB3C

	arm_func_start exBossMeteAdminTask__Create
exBossMeteAdminTask__Create: // 0x0215DB7C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	bl GetExTaskWorkCurrent_
	mov r5, #0
	mov r4, r0
	str r5, [sp]
	mov r1, #0xc
	str r1, [sp, #4]
	ldr r0, _0215DC04 // =aExbossmeteadmi
	ldr r1, _0215DC08 // =exBossMeteAdminTask__Destructor
	str r0, [sp, #8]
	ldr r0, _0215DC0C // =exBossMeteAdminTask__Main
	mov r2, #0x3200
	mov r3, #5
	str r5, [sp, #0xc]
	bl ExTaskCreate_
	mov r6, r0
	bl GetExTaskWork_
	mov r1, r5
	mov r2, #0xc
	mov r5, r0
	bl MI_CpuFill8
	mov r0, r6
	bl GetExTask
	ldr r2, _0215DC10 // =exBossMeteAdminTask__Func8
	mov r1, #0
	str r2, [r0, #8]
	str r5, [r4, #0x68]
	str r1, [r5]
	str r1, [r5, #4]
	str r1, [r5, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215DC04: .word aExbossmeteadmi
_0215DC08: .word exBossMeteAdminTask__Destructor
_0215DC0C: .word exBossMeteAdminTask__Main
_0215DC10: .word exBossMeteAdminTask__Func8
	arm_func_end exBossMeteAdminTask__Create

	.data

aExbossmeteadmi: // 0x02174308
	.asciz "exBossMeteAdminTask"