	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start OSi_DequeueItem
OSi_DequeueItem: // 0x037FCE30
	ldr r2, [r1, #0x10]
	ldr r1, [r1, #0x14]
	cmp r2, #0
	streq r1, [r0, #0x70]
	strne r1, [r2, #0x14]
	cmp r1, #0
	streq r2, [r0, #0x6c]
	strne r2, [r1, #0x10]
	bx lr
	arm_func_end OSi_DequeueItem

	arm_func_start OSi_EnqueueTail
OSi_EnqueueTail: // 0x037FCE54
	ldr r2, [r0, #0x70]
	cmp r2, #0
	streq r1, [r0, #0x6c]
	strne r1, [r2, #0x10]
	str r2, [r1, #0x14]
	mov r2, #0
	str r2, [r1, #0x10]
	str r1, [r0, #0x70]
	bx lr
	arm_func_end OSi_EnqueueTail

	arm_func_start OSi_UnlockAllMutex
OSi_UnlockAllMutex: // 0x037FCE78
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	add r5, r6, #0x6c
	mov r4, #0
	b _037FCEA0
_037FCE8C:
	mov r0, r5
	bl OSi_RemoveMutexLinkFromQueue
	str r4, [r0, #0xc]
	str r4, [r0, #8]
	bl OS_WakeupThread
_037FCEA0:
	ldr r0, [r6, #0x6c]
	cmp r0, #0
	bne _037FCE8C
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end OSi_UnlockAllMutex

	arm_func_start OS_UnlockMutex
OS_UnlockMutex: // 0x037FCEB4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r0, _037FCF20 // =0x03808434
	ldr r0, [r0, #4]
	ldr r1, [r5, #8]
	cmp r1, r0
	bne _037FCF0C
	ldr r1, [r5, #0xc]
	sub r1, r1, #1
	str r1, [r5, #0xc]
	ldr r1, [r5, #0xc]
	cmp r1, #0
	bne _037FCF0C
	mov r1, r5
	bl OSi_DequeueItem
	mov r0, #0
	str r0, [r5, #8]
	mov r0, r5
	bl OS_WakeupThread
_037FCF0C:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FCF20: .word 0x03808434
	arm_func_end OS_UnlockMutex

	arm_func_start OS_LockMutex
OS_LockMutex: // 0x037FCF24
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r0, _037FCFAC // =0x03808434
	ldr r7, [r0, #4]
	mov r6, #0
_037FCF44:
	ldr r0, [r5, #8]
	cmp r0, #0
	bne _037FCF70
	str r7, [r5, #8]
	ldr r0, [r5, #0xc]
	add r0, r0, #1
	str r0, [r5, #0xc]
	mov r0, r7
	mov r1, r5
	bl OSi_EnqueueTail
	b _037FCF98
_037FCF70:
	cmp r0, r7
	ldreq r0, [r5, #0xc]
	addeq r0, r0, #1
	streq r0, [r5, #0xc]
	beq _037FCF98
	str r5, [r7, #0x68]
	mov r0, r5
	bl OS_SleepThread
	str r6, [r7, #0x68]
	b _037FCF44
_037FCF98:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037FCFAC: .word 0x03808434
	arm_func_end OS_LockMutex

	arm_func_start OS_InitMutex
OS_InitMutex: // 0x037FCFB0
	mov r2, #0
	str r2, [r0, #4]
	ldr r1, [r0, #4]
	str r1, [r0]
	str r2, [r0, #8]
	str r2, [r0, #0xc]
	bx lr
	arm_func_end OS_InitMutex