	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public isInitialized_3171
isInitialized_3171: // 0x03808418
	.space 4

	.text

	arm_func_start OS_UnLockCartridge
OS_UnLockCartridge: // 0x037FBEB0
	ldr r1, _037FBEB8 // =OS_UnlockCard
	bx r1
	.align 2, 0
_037FBEB8: .word OS_UnlockCard
	arm_func_end OS_UnLockCartridge

	arm_func_start OS_GetLockID
OS_GetLockID: // 0x037FBEBC
	ldr r3, _037FBF4C // =0x027FFFB8
	ldr r1, [r3, #0]
	mov r2, #0
	mov r0, #0x80000000
_037FBECC:
	tst r1, r0
	bne _037FBEE8
	add r2, r2, #1
	cmp r2, #0x20
	beq _037FBEE8
	mov r0, r0, lsr #1
	b _037FBECC
_037FBEE8:
	cmp r2, #0x20
	movne r0, #0x80
	bne _037FBF30
	add r3, r3, #4
	ldr r1, [r3, #0]
	mov r2, #0
	mov r0, #0x80000000
_037FBF04:
	tst r1, r0
	bne _037FBF20
	add r2, r2, #1
	cmp r2, #0x20
	beq _037FBF20
	mov r0, r0, lsr #1
	b _037FBF04
_037FBF20:
	cmp r2, #0x20
	ldr r0, _037FBF50 // =0xFFFFFFFD
	bxeq lr
	mov r0, #0xa0
_037FBF30:
	add r0, r0, r2
	mov r1, #0x80000000
	mov r1, r1, lsr r2
	ldr r2, [r3, #0]
	bic r2, r2, r1
	str r2, [r3]
	bx lr
	.align 2, 0
_037FBF4C: .word 0x027FFFB8
_037FBF50: .word 0xFFFFFFFD
	arm_func_end OS_GetLockID

	arm_func_start OS_ReleaseLockID
OS_ReleaseLockID: // 0x037FBF54
	ldr r3, _037FBF80 // =0x027FFFB8
	cmp r0, #0xa0
	addpl r3, r3, #4
	subpl r0, r0, #0xa0
	submi r0, r0, #0x80
	mov r1, #0x80000000
	mov r1, r1, lsr r0
	ldr r2, [r3, #0]
	orr r2, r2, r1
	str r2, [r3]
	bx lr
	.align 2, 0
_037FBF80: .word 0x027FFFB8
	arm_func_end OS_ReleaseLockID

	arm_func_start OS_ReadOwnerOfLockWord
OS_ReadOwnerOfLockWord: // 0x037FBF84
	ldrh r0, [r0, #4]
	bx lr
	arm_func_end OS_ReadOwnerOfLockWord

	arm_func_start OSi_FreeCardBus
OSi_FreeCardBus: // 0x037FBF8C
	bx lr
	arm_func_end OSi_FreeCardBus

	arm_func_start OSi_AllocateCardBus
OSi_AllocateCardBus: // 0x037FBF90
	bx lr
	arm_func_end OSi_AllocateCardBus

	arm_func_start OS_TryLockCard
OS_TryLockCard: // 0x037FBF94
	ldr r1, _037FBFA8 // =0x027FFFE8
	ldr r2, _037FBFAC // =OSi_AllocateCardBus
	mov r3, #1
	ldr ip, _037FBFB0 // =OS_TryLockByWord
	bx ip
	.align 2, 0
_037FBFA8: .word 0x027FFFE8
_037FBFAC: .word OSi_AllocateCardBus
_037FBFB0: .word OS_TryLockByWord
	arm_func_end OS_TryLockCard

	arm_func_start OS_UnlockCard
OS_UnlockCard: // 0x037FBFB4
	ldr r1, _037FBFC8 // =0x027FFFE8
	ldr r2, _037FBFCC // =OSi_FreeCardBus
	mov r3, #1
	ldr ip, _037FBFD0 // =OS_UnlockByWord
	bx ip
	.align 2, 0
_037FBFC8: .word 0x027FFFE8
_037FBFCC: .word OSi_FreeCardBus
_037FBFD0: .word OS_UnlockByWord
	arm_func_end OS_UnlockCard

	arm_func_start OS_LockCartridge
OS_LockCartridge: // 0x037FBFD4
	ldr r1, _037FBFE8 // =0x027FFFE8
	ldr r2, _037FBFEC // =OSi_AllocateCardBus
	mov r3, #1
	ldr ip, _037FBFF0 // =OS_LockByWord
	bx ip
	.align 2, 0
_037FBFE8: .word 0x027FFFE8
_037FBFEC: .word OSi_AllocateCardBus
_037FBFF0: .word OS_LockByWord
	arm_func_end OS_LockCartridge

	arm_func_start OS_TryLockByWord
OS_TryLockByWord: // 0x037FBFF4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	mov r8, r1
	mov r7, r2
	movs r6, r3
	beq _037FC01C
	bl OS_DisableInterrupts_IrqAndFiq
	mov r5, r0
	b _037FC024
_037FC01C:
	bl OS_DisableInterrupts
	mov r5, r0
_037FC024:
	mov r0, r9
	mov r1, r8
	bl MI_SwapWord
	movs r4, r0
	bne _037FC04C
	cmp r7, #0
	beq _037FC048
	mov lr, pc
	bx r7
_037FC048:
	strh r9, [r8, #4]
_037FC04C:
	cmp r6, #0
	beq _037FC060
	mov r0, r5
	bl OS_RestoreInterrupts_IrqAndFiq
	b _037FC068
_037FC060:
	mov r0, r5
	bl OS_RestoreInterrupts
_037FC068:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end OS_TryLockByWord

	arm_func_start OS_UnlockByWord
OS_UnlockByWord: // 0x037FC078
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r1
	mov r6, r2
	mov r5, r3
	ldrh r1, [r7, #4]
	cmp r0, r1
	mvnne r0, #1
	bne _037FC0F8
	cmp r5, #0
	beq _037FC0B0
	bl OS_DisableInterrupts_IrqAndFiq
	mov r4, r0
	b _037FC0B8
_037FC0B0:
	bl OS_DisableInterrupts
	mov r4, r0
_037FC0B8:
	mov r0, #0
	strh r0, [r7, #4]
	cmp r6, #0
	beq _037FC0D0
	mov lr, pc
	bx r6
_037FC0D0:
	mov r0, #0
	str r0, [r7]
	cmp r5, #0
	beq _037FC0EC
	mov r0, r4
	bl OS_RestoreInterrupts_IrqAndFiq
	b _037FC0F4
_037FC0EC:
	mov r0, r4
	bl OS_RestoreInterrupts
_037FC0F4:
	mov r0, #0
_037FC0F8:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end OS_UnlockByWord

	arm_func_start OS_LockByWord
OS_LockByWord: // 0x037FC104
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	mov r4, #0x400
	b _037FC128
_037FC120:
	mov r0, r4
	bl _Ven_SVC_WaitByLoop
_037FC128:
	mov r0, r8
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl OS_TryLockByWord
	cmp r0, #0
	bgt _037FC120
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end OS_LockByWord

	arm_func_start _Ven_SVC_WaitByLoop
_Ven_SVC_WaitByLoop: // 0x037FC14C
	ldr ip, _037FC154 // =SVC_WaitByLoop
	bx ip
	.align 2, 0
_037FC154: .word SVC_WaitByLoop
	arm_func_end _Ven_SVC_WaitByLoop

	arm_func_start OS_InitLock
OS_InitLock: // 0x037FC158
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _037FC1D0 // =isInitialized_3171
	ldr r1, [r0, #0]
	cmp r1, #0
	bne _037FC1C4
	mov r1, #1
	str r1, [r0]
	mov r0, #0
	ldr r4, _037FC1D4 // =0x027FFFF0
	strh r0, [r4, #6]
	mov r5, #0x400
	b _037FC194
_037FC18C:
	mov r0, r5
	bl _Ven_SVC_WaitByLoop
_037FC194:
	ldrh r0, [r4, #4]
	cmp r0, #0x7f
	bne _037FC18C
	mvn r1, #0
	ldr r0, _037FC1D8 // =0x027FFFB8
	str r1, [r0]
	mov r0, #0x10000
	rsb r1, r0, #0
	ldr r0, _037FC1DC // =0x027FFFBC
	str r1, [r0]
	mov r0, #0xbf
	strh r0, [r4, #6]
_037FC1C4:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FC1D0: .word isInitialized_3171
_037FC1D4: .word 0x027FFFF0
_037FC1D8: .word 0x027FFFB8
_037FC1DC: .word 0x027FFFBC
	arm_func_end OS_InitLock