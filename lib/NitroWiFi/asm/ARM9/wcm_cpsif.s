	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start WcmCpsifUnlockMutexInIRQ
WcmCpsifUnlockMutexInIRQ: // 0x020CC590
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, [r0, #8]
	ldr r1, _020CC5E8 // =OS_IrqHandler
	cmp r2, r1
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldr r1, [r0, #0xc]
	sub r1, r1, #1
	str r1, [r0, #0xc]
	ldr r1, [r0, #0xc]
	cmp r1, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	mov r1, #0
	str r1, [r0, #8]
	bl OS_WakeupThread
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CC5E8: .word OS_IrqHandler
	arm_func_end WcmCpsifUnlockMutexInIRQ

	arm_func_start WcmCpsifTryLockMutexInIRQ
WcmCpsifTryLockMutexInIRQ: // 0x020CC5EC
	ldr r2, [r0, #8]
	cmp r2, #0
	bne _020CC614
	ldr r1, _020CC634 // =OS_IrqHandler
	str r1, [r0, #8]
	ldr r1, [r0, #0xc]
	add r1, r1, #1
	str r1, [r0, #0xc]
	mov r0, #1
	bx lr
_020CC614:
	ldr r1, _020CC634 // =OS_IrqHandler
	cmp r2, r1
	ldreq r1, [r0, #0xc]
	addeq r1, r1, #1
	streq r1, [r0, #0xc]
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_020CC634: .word OS_IrqHandler
	arm_func_end WcmCpsifTryLockMutexInIRQ

	arm_func_start WcmCpsifKACallback
WcmCpsifKACallback: // 0x020CC638
	ldr ip, _020CC644 // =WcmCpsifUnlockMutexInIRQ
	ldr r0, _020CC648 // =0x021471FC
	bx ip
	.align 2, 0
_020CC644: .word WcmCpsifUnlockMutexInIRQ
_020CC648: .word 0x021471FC
	arm_func_end WcmCpsifKACallback

	arm_func_start WcmCpsifWmCallback
WcmCpsifWmCallback: // 0x020CC64C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r1, [r0, #0]
	cmp r1, #0x12
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldrh r2, [r0, #2]
	ldr r1, _020CC698 // =0x021471F0
	str r2, [r1, #0x24]
	ldrh r0, [r0, #2]
	cmp r0, #0
	bne _020CC684
	bl WCMi_ResetKeepAliveAlarm
_020CC684:
	ldr r0, _020CC69C // =0x021471F4
	bl OS_WakeupThread
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CC698: .word 0x021471F0
_020CC69C: .word 0x021471F4
	arm_func_end WcmCpsifWmCallback

	arm_func_start WCM_SendDCFData
WCM_SendDCFData: // 0x020CC6A0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	bl OS_DisableInterrupts
	mov r5, r0
	bl WCMi_GetSystemWork
	cmp r0, #0
	bne _020CC6D8
	mov r0, r5
	bl OS_RestoreInterrupts
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CC6D8:
	ldr r0, _020CC808 // =0x021471FC
	bl OS_LockMutex
	bl WCMi_GetSystemWork
	movs r4, r0
	bne _020CC708
	ldr r0, _020CC808 // =0x021471FC
	bl OS_UnlockMutex
	mov r0, r5
	bl OS_RestoreInterrupts
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CC708:
	add r0, r4, #0x2000
	ldr r1, [r0, #0x260]
	cmp r1, #9
	bne _020CC724
	ldrb r0, [r0, #0x26b]
	cmp r0, #1
	bne _020CC740
_020CC724:
	ldr r0, _020CC808 // =0x021471FC
	bl OS_UnlockMutex
	mov r0, r5
	bl OS_RestoreInterrupts
	mvn r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CC740:
	mov r0, r7
	mov r2, r6
	add r1, r4, #0xf00
	bl MI_CpuCopy8
	mov r3, r6, lsl #0x10
	ldr r0, _020CC80C // =WcmCpsifWmCallback
	mov r1, r8
	add r2, r4, #0xf00
	mov r3, r3, lsr #0x10
	bl WM_SetDCFData
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _020CC798
_020CC774: // jump table
	b _020CC798 // case 0
	b _020CC798 // case 1
	b _020CC7B4 // case 2
	b _020CC798 // case 3
	b _020CC798 // case 4
	b _020CC798 // case 5
	b _020CC798 // case 6
	b _020CC798 // case 7
	b _020CC798 // case 8
_020CC798:
	ldr r0, _020CC808 // =0x021471FC
	bl OS_UnlockMutex
	mov r0, r5
	bl OS_RestoreInterrupts
	mvn r0, #4
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CC7B4:
	ldr r0, _020CC810 // =0x021471F4
	bl OS_SleepThread
	ldr r0, _020CC814 // =0x021471F0
	ldr r0, [r0, #0x24]
	cmp r0, #0
	beq _020CC7EC
	cmp r0, #1
	ldr r0, _020CC808 // =0x021471FC
	bl OS_UnlockMutex
	mov r0, r5
	bl OS_RestoreInterrupts
	mvn r0, #4
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CC7EC:
	ldr r0, _020CC808 // =0x021471FC
	bl OS_UnlockMutex
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r6
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020CC808: .word 0x021471FC
_020CC80C: .word WcmCpsifWmCallback
_020CC810: .word 0x021471F4
_020CC814: .word 0x021471F0
	arm_func_end WCM_SendDCFData

	arm_func_start WCM_SetRecvDCFCallback
WCM_SetRecvDCFCallback: // 0x020CC818
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, _020CC838 // =0x021471F0
	str r4, [r1, #0x28]
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CC838: .word 0x021471F0
	arm_func_end WCM_SetRecvDCFCallback

	arm_func_start WCM_GetApEssid
WCM_GetApEssid: // 0x020CC83C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, #0
	mov r4, r0
	mov r6, r7
	bl WCMi_GetSystemWork
	mov r5, r0
	bl OS_DisableInterrupts
	cmp r5, #0
	beq _020CC88C
	add r1, r5, #0x2000
	ldr r2, [r1, #0x260]
	cmp r2, #9
	bne _020CC88C
	ldrb r1, [r1, #0x26b]
	cmp r1, #0
	addeq r2, r5, #0x2100
	ldreq r1, _020CC8A8 // =0x0000214C
	ldreqh r6, [r2, #0x4a]
	addeq r7, r5, r1
_020CC88C:
	bl OS_RestoreInterrupts
	cmp r4, #0
	strneh r6, [r4]
	mov r0, r7
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020CC8A8: .word 0x0000214C
	arm_func_end WCM_GetApEssid

	arm_func_start WCM_GetApMacAddress
WCM_GetApMacAddress: // 0x020CC8AC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, #0
	bl WCMi_GetSystemWork
	mov r4, r0
	bl OS_DisableInterrupts
	cmp r4, #0
	beq _020CC8EC
	add r1, r4, #0x2000
	ldr r2, [r1, #0x260]
	cmp r2, #9
	bne _020CC8EC
	ldrb r1, [r1, #0x26b]
	cmp r1, #0
	ldreq r1, _020CC900 // =0x00002144
	addeq r5, r4, r1
_020CC8EC:
	bl OS_RestoreInterrupts
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CC900: .word 0x00002144
	arm_func_end WCM_GetApMacAddress

	arm_func_start WCMi_CpsifSendNullPacket
WCMi_CpsifSendNullPacket: // 0x020CC904
	stmdb sp!, {r4, lr}
	bl WCMi_GetSystemWork
	movs r4, r0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	add r0, r4, #0x2000
	ldr r1, [r0, #0x260]
	cmp r1, #9
	ldmneia sp!, {r4, lr}
	bxne lr
	ldrb r0, [r0, #0x26b]
	cmp r0, #1
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r0, _020CC984 // =0x021471FC
	bl WcmCpsifTryLockMutexInIRQ
	cmp r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r1, _020CC988 // =0x00002144
	ldr r0, _020CC98C // =WcmCpsifKACallback
	add r1, r4, r1
	add r2, r4, #0xf00
	mov r3, #0
	bl WM_SetDCFData
	cmp r0, #2
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r0, _020CC984 // =0x021471FC
	bl WcmCpsifUnlockMutexInIRQ
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CC984: .word 0x021471FC
_020CC988: .word 0x00002144
_020CC98C: .word WcmCpsifKACallback
	arm_func_end WCMi_CpsifSendNullPacket

	arm_func_start WCMi_CpsifRecvCallback
WCMi_CpsifRecvCallback: // 0x020CC990
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020CC9D4 // =0x021471F0
	mov r2, r0
	ldr ip, [r1, #0x28]
	cmp ip, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	ldrh r3, [r2, #6]
	add r0, r2, #0x1e
	add r1, r2, #0x18
	add r2, r2, #0x2c
	blx ip
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CC9D4: .word 0x021471F0
	arm_func_end WCMi_CpsifRecvCallback

	arm_func_start WCMi_InitCpsif
WCMi_InitCpsif: // 0x020CC9D8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020CCA24 // =0x021471F0
	ldrb r0, [r1, #0]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldr r0, _020CCA28 // =0x021471FC
	mov r2, #0
	mov r3, #1
	strb r3, [r1]
	str r2, [r1, #0x24]
	str r2, [r1, #8]
	str r2, [r1, #4]
	bl OS_InitMutex
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CCA24: .word 0x021471F0
_020CCA28: .word 0x021471FC
	arm_func_end WCMi_InitCpsif
