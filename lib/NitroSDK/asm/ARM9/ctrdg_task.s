	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CTRDGi_TaskThread
CTRDGi_TaskThread: // 0x020FC958
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x28
	ldr r6, _020FCA3C // =0x02151FCC
	ldr r5, _020FCA40 // =0x02151FC8
	mov r4, r0
	add r9, sp, #0
	mov r8, #0
	mov r7, #0x24
_020FC978:
	mov r0, r9
	mov r1, r8
	mov r2, r7
	bl MI_CpuFill8
	bl OS_DisableInterrupts
	ldr r1, [r4, #0xc0]
	mov r10, r0
	cmp r1, #0
	bne _020FC9B0
_020FC99C:
	mov r0, r8
	bl OS_SleepThread
	ldr r0, [r4, #0xc0]
	cmp r0, #0
	beq _020FC99C
_020FC9B0:
	ldr lr, [r4, #0xc0]
	add ip, sp, #0
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r1, [lr]
	mov r0, r10
	str r1, [ip]
	bl OS_RestoreInterrupts
	ldr r1, [sp]
	cmp r1, #0
	beq _020FC9F0
	mov r0, r9
	blx r1
	str r0, [sp, #8]
_020FC9F0:
	bl OS_DisableInterrupts
	ldr r1, [sp, #4]
	mov r10, r0
	strb r8, [r6, #0x22]
	cmp r1, #0
	beq _020FCA10
	mov r0, r9
	blx r1
_020FCA10:
	ldr r0, [r5]
	cmp r0, #0
	beq _020FCA2C
	mov r0, r10
	str r8, [r4, #0xc0]
	bl OS_RestoreInterrupts
	b _020FC978
_020FCA2C:
	bl OS_ExitThread
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_020FCA3C: .word 0x02151FCC
_020FCA40: .word 0x02151FC8
	arm_func_end CTRDGi_TaskThread

	arm_func_start CTRDGi_InitTaskInfo
CTRDGi_InitTaskInfo: // 0x020FCA44
	ldr ip, _020FCA54 // =MI_CpuFill8
	mov r1, #0
	mov r2, #0x24
	bx ip
	.align 2, 0
_020FCA54: .word MI_CpuFill8
	arm_func_end CTRDGi_InitTaskInfo

	arm_func_start CTRDGi_InitTaskThread
CTRDGi_InitTaskThread: // 0x020FCA58
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _020FCAD8 // =0x02151FC8
	mov r4, r0
	ldr r0, [r1]
	cmp r0, #0
	bne _020FCAC4
	add r0, r5, #0xc4
	str r5, [r1]
	bl CTRDGi_InitTaskInfo
	ldr r0, _020FCADC // =0x02151FCC
	bl CTRDGi_InitTaskInfo
	mov r0, #0
	str r0, [r5, #0xc0]
	mov r2, #0x400
	ldr r1, _020FCAE0 // =CTRDGi_TaskThread
	ldr r3, _020FCAE4 // =_021523F0
	mov r0, r5
	str r2, [sp]
	mov r2, #0x14
	str r2, [sp, #4]
	mov r2, r5
	bl OS_CreateThread
	mov r0, r5
	bl OS_WakeupThreadDirect
_020FCAC4:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020FCAD8: .word 0x02151FC8
_020FCADC: .word 0x02151FCC
_020FCAE0: .word CTRDGi_TaskThread
_020FCAE4: .word _021523F0
	arm_func_end CTRDGi_InitTaskThread
