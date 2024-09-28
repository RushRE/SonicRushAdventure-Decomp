	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CTRDG_Enable
CTRDG_Enable: // 0x020FC1F4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _020FC244 // =0x02151DF4
	mov r4, r0
	str r5, [r1]
	bl CTRDG_IsOptionCartridge
	cmp r0, #0
	bne _020FC230
	cmp r5, #0
	movne r1, #0x1000
	moveq r1, #0x5000
	mov r0, #0xf000
	bl OS_SetIPermissionsForProtectionRegion
_020FC230:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020FC244: .word 0x02151DF4
	arm_func_end CTRDG_Enable

	arm_func_start CTRDGi_SendtoPxi
CTRDGi_SendtoPxi: // 0x020FC248
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r1, r7
	mov r0, #0xd
	mov r2, #0
	bl PXI_SendWordByFifo
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r6, #1
	mov r5, #0xd
	mov r4, #0
_020FC280:
	mov r0, r6
	blx SVC_WaitByLoop
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	bne _020FC280
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end CTRDGi_SendtoPxi

	arm_func_start CTRDGi_UnlockByProcessor
CTRDGi_UnlockByProcessor: // 0x020FC2AC
	stmdb sp!, {r4, lr}
	mov r4, r1
	ldr r1, [r4]
	cmp r1, #0
	bne _020FC2C4
	bl OS_UnLockCartridge
_020FC2C4:
	ldr r0, [r4, #4]
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end CTRDGi_UnlockByProcessor

	arm_func_start CTRDGi_LockByProcessor
CTRDGi_LockByProcessor: // 0x020FC2D4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	ldr r5, _020FC350 // =0x027FFFE8
	mov r4, #1
_020FC2EC:
	bl OS_DisableInterrupts
	str r0, [r6, #4]
	mov r0, r5
	bl OS_ReadOwnerOfLockWord
	and r0, r0, #0x40
	str r0, [r6]
	ldr r0, [r6]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	mov r0, r7
	bl OS_LockCartridge
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldr r0, [r6, #4]
	bl OS_RestoreInterrupts
	mov r0, r4
	blx SVC_WaitByLoop
	b _020FC2EC
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020FC350: .word 0x027FFFE8
	arm_func_end CTRDGi_LockByProcessor

	arm_func_start CTRDGi_RestoreAccessCycle
CTRDGi_RestoreAccessCycle: // 0x020FC354
	ldr r3, _020FC384 // =0x04000204
	ldr r2, [r0]
	ldrh r1, [r3]
	bic r1, r1, #0xc
	orr r1, r1, r2, lsl #2
	strh r1, [r3]
	ldrh r1, [r3]
	ldr r2, [r0, #4]
	bic r0, r1, #0x10
	orr r0, r0, r2, lsl #4
	strh r0, [r3]
	bx lr
	.align 2, 0
_020FC384: .word 0x04000204
	arm_func_end CTRDGi_RestoreAccessCycle

	arm_func_start CTRDGi_ChangeLatestAccessCycle
CTRDGi_ChangeLatestAccessCycle: // 0x020FC388
	ldr r2, _020FC3CC // =0x04000204
	ldrh r1, [r2]
	and r1, r1, #0xc
	mov r1, r1, asr #2
	str r1, [r0]
	ldrh r1, [r2]
	and r1, r1, #0x10
	mov r1, r1, asr #4
	str r1, [r0, #4]
	ldrh r0, [r2]
	bic r0, r0, #0xc
	orr r0, r0, #0xc
	strh r0, [r2]
	ldrh r0, [r2]
	bic r0, r0, #0x10
	strh r0, [r2]
	bx lr
	.align 2, 0
_020FC3CC: .word 0x04000204
	arm_func_end CTRDGi_ChangeLatestAccessCycle

	arm_func_start CTRDG_IsExisting
CTRDG_IsExisting: // 0x020FC3D0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	ldr r2, _020FC4DC // =0x027FFC30
	ldr r0, _020FC4E0 // =0x0000FFFF
	ldrh r1, [r2]
	mov r4, #1
	cmp r1, r0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldrb r0, [r2, #5]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r0, _020FC4E4 // =0x02151DF8
	add r1, sp, #0
	ldrh r0, [r0, #2]
	bl CTRDGi_LockByProcessor
	add r0, sp, #8
	bl CTRDGi_ChangeLatestAccessCycle
	mov r0, #0x8000000
	ldrb r2, [r0, #0xb2]
	cmp r2, #0x96
	bne _020FC458
	ldr r1, _020FC4DC // =0x027FFC30
	ldrh r0, [r0, #0xbe]
	ldrh r1, [r1]
	cmp r1, r0
	bne _020FC4A0
_020FC458:
	cmp r2, #0x96
	beq _020FC478
	ldr r1, _020FC4DC // =0x027FFC30
	ldr r0, _020FC4E8 // =0x0801FFFE
	ldrh r1, [r1]
	ldrh r0, [r0]
	cmp r1, r0
	bne _020FC4A0
_020FC478:
	ldr r2, _020FC4DC // =0x027FFC30
	mov r0, #0x8000000
	ldr r1, [r2, #8]
	ldr r0, [r0, #0xac]
	cmp r1, r0
	beq _020FC4B4
	ldrb r0, [r2, #5]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _020FC4B4
_020FC4A0:
	ldr r1, _020FC4DC // =0x027FFC30
	mov r4, #0
	ldrb r0, [r1, #5]
	orr r0, r0, #2
	strb r0, [r1, #5]
_020FC4B4:
	add r0, sp, #8
	bl CTRDGi_RestoreAccessCycle
	ldr r0, _020FC4E4 // =0x02151DF8
	add r1, sp, #0
	ldrh r0, [r0, #2]
	bl CTRDGi_UnlockByProcessor
	mov r0, r4
	add sp, sp, #0x10
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020FC4DC: .word 0x027FFC30
_020FC4E0: .word 0x0000FFFF
_020FC4E4: .word 0x02151DF8
_020FC4E8: .word 0x0801FFFE
	arm_func_end CTRDG_IsExisting

	arm_func_start CTRDGi_IsAgbCartridgeAtInit
CTRDGi_IsAgbCartridgeAtInit: // 0x020FC4EC
	ldr r0, _020FC500 // =0x027FFC30
	ldrb r0, [r0, #5]
	mov r0, r0, lsl #0x1f
	mov r0, r0, lsr #0x1f
	bx lr
	.align 2, 0
_020FC500: .word 0x027FFC30
	arm_func_end CTRDGi_IsAgbCartridgeAtInit

	arm_func_start CTRDG_IsOptionCartridge
CTRDG_IsOptionCartridge: // 0x020FC504
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl CTRDG_IsExisting
	cmp r0, #0
	beq _020FC530
	bl CTRDGi_IsAgbCartridgeAtInit
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {lr}
	bxeq lr
_020FC530:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CTRDG_IsOptionCartridge

	arm_func_start CTRDGi_InitCommon
CTRDGi_InitCommon: // 0x020FC540
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020FC578 // =0x02151DF8
	mov r3, #0
	ldr r2, _020FC57C // =0x05000001
	add r0, sp, #0
	str r3, [sp]
	blx SVC_CpuSet
	bl OS_GetLockID
	ldr r1, _020FC578 // =0x02151DF8
	strh r0, [r1, #2]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020FC578: .word 0x02151DF8
_020FC57C: .word 0x05000001
	arm_func_end CTRDGi_InitCommon
