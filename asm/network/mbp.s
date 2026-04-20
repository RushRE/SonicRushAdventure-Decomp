	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public mbpState
mbpState: // 0x02139284
	.space 0x0E // MBPState
	
.public childInfo
childInfo: // 0x02139292
	.space 15 * 0x1E

    .text

    arm_func_start MBP_Init
MBP_Init: // 0x0206DC2C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x78
	mov r5, r0
	add r0, sp, #0x28
	mov r4, r1
	bl OS_GetOwnerInfo
	ldrb r2, [sp, #0x12]
	ldrb r1, [sp, #0x29]
	ldrh r3, [sp, #0x40]
	bic r2, r2, #0xf
	and r1, r1, #0xf
	orr r2, r2, r1
	strb r2, [sp, #0x12]
	add r0, sp, #0x2c
	add r1, sp, #0x14
	mov r2, r3, lsl #1
	strb r3, [sp, #0x13]
	bl MI_CpuCopy8
	ldrb r1, [sp, #0x12]
	add ip, sp, #4
	mov r0, #0
	bic r1, r1, #0xf0
	ldr r3, _0206DD38 // =mbpState
	strb r1, [sp, #0x12]
	strh r0, [ip]
	strh r0, [ip, #2]
	strh r0, [ip, #4]
	strh r0, [ip, #6]
	strh r0, [ip, #8]
	strh r0, [ip, #0xa]
	strh r0, [ip, #0xc]
	mov r2, #3
_0206DCAC:
	ldrh r1, [ip]
	ldrh r0, [ip, #2]
	add ip, ip, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _0206DCAC
	ldr r0, _0206DD3C // =wfsi_task+0x000004C8
	ldrh r2, [ip]
	ldr r1, [r0, #0]
	mov r0, #0xc000
	strh r2, [r3]
	blx r1
	ldr r1, _0206DD3C // =wfsi_task+0x000004C8
	mov r2, #2
	str r0, [r1, #0xc]
	str r2, [sp]
	ldr r0, [r1, #0xc]
	add r1, sp, #0x12
	mov r2, r5
	mov r3, r4
	bl MB_Init
	cmp r0, #0
	beq _0206DD14
	bl OS_Terminate
_0206DD14:
	mov r0, #0x100
	mov r1, #0xf
	bl MB_SetParentCommParam
	ldr r0, _0206DD40 // =MBPi_ParentStateCallback
	bl MB_CommSetParentStateCallback
	mov r0, #1
	bl MBP_ChangeState
	add sp, sp, #0x78
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206DD38: .word mbpState
_0206DD3C: .word wfsi_task+0x000004C8
_0206DD40: .word MBPi_ParentStateCallback
	arm_func_end MBP_Init

	arm_func_start MBP_Start
MBP_Start: // 0x0206DD44
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	mov r0, #2
	bl MBP_ChangeState
	mov r0, r4
	bl MB_StartParent
	cmp r0, #0
	beq _0206DD74
	mov r0, #7
	bl MBP_ChangeState
	ldmia sp!, {r3, r4, r5, pc}
_0206DD74:
	mov r0, r5
	bl MBP_RegistFile
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	bl OS_Terminate
	arm_func_end MBP_Start

	arm_func_start sub_206dd88
sub_206dd88: // 0x0206DD88
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end sub_206dd88

	arm_func_start MBP_RegistFile
MBP_RegistFile: // 0x0206DD8C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x48
	mov r6, r0
	ldr r0, [r6, #0]
	mov r5, #0
	cmp r0, #0
	moveq r4, r5
	beq _0206DDD4
	add r0, sp, #0
	bl FS_InitFile
	ldr r1, [r6, #0]
	add r0, sp, #0
	bl FS_OpenFile
	cmp r0, #0
	addeq sp, sp, #0x48
	moveq r0, r5
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	add r4, sp, #0
_0206DDD4:
	mov r0, r4
	bl MB_GetSegmentLength
	movs r7, r0
	beq _0206DE40
	ldr r1, _0206DE5C // =wfsi_task+0x000004C8
	ldr r1, [r1, #0]
	blx r1
	movs r1, r0
	ldr r0, _0206DE5C // =wfsi_task+0x000004C8
	str r1, [r0, #4]
	beq _0206DE40
	mov r0, r4
	mov r2, r7
	bl MB_ReadSegment
	cmp r0, #0
	beq _0206DE2C
	ldr r1, _0206DE5C // =wfsi_task+0x000004C8
	mov r0, r6
	ldr r1, [r1, #4]
	bl MB_UnregisterFile
	cmp r0, #0
	movne r5, #1
_0206DE2C:
	cmp r5, #0
	bne _0206DE40
	ldr r1, _0206DE5C // =wfsi_task+0x000004C8
	ldmib r1, {r0, r1}
	blx r1
_0206DE40:
	add r0, sp, #0
	cmp r4, r0
	bne _0206DE50
	bl FS_CloseFile
_0206DE50:
	mov r0, r5
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206DE5C: .word wfsi_task+0x000004C8
	arm_func_end MBP_RegistFile

	arm_func_start MBP_AcceptChild
MBP_AcceptChild: // 0x0206DE60
	stmdb sp!, {r3, r4, r5, lr}
	mov r1, #1
	mov r4, r0
	bl MB_CommResponseRequest
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #1
	mvn r0, r0, lsl r4
	mov r5, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r1, _0206DEE4 // =wfsi_task+0x000004C8
	ldrh r2, [r1, #0x12]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x12]
	ldrh r2, [r1, #0x14]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x16]
	ldrh r2, [r1, #0x18]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x18]
	ldrh r2, [r1, #0x1a]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x1a]
	ldrh r2, [r1, #0x1c]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x1c]
	bl OS_RestoreInterrupts
	mov r0, r4
	bl MB_DisconnectChild
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206DEE4: .word wfsi_task+0x000004C8
	arm_func_end MBP_AcceptChild

	arm_func_start MBP_KickChild
MBP_KickChild: // 0x0206DEE8
	stmdb sp!, {r3, r4, r5, lr}
	mov r1, #0
	mov r4, r0
	bl MB_CommResponseRequest
	cmp r0, #0
	bne _0206DF6C
	mov r0, #1
	mvn r0, r0, lsl r4
	mov r5, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r1, _0206DF9C // =wfsi_task+0x000004C8
	ldrh r2, [r1, #0x12]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x12]
	ldrh r2, [r1, #0x14]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x16]
	ldrh r2, [r1, #0x18]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x18]
	ldrh r2, [r1, #0x1a]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x1a]
	ldrh r2, [r1, #0x1c]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x1c]
	bl OS_RestoreInterrupts
	mov r0, r4
	bl MB_DisconnectChild
	ldmia sp!, {r3, r4, r5, pc}
_0206DF6C:
	bl OS_DisableInterrupts
	ldr r1, _0206DF9C // =wfsi_task+0x000004C8
	mov r3, #1
	ldrh r2, [r1, #0x14]
	mvn r3, r3, lsl r4
	and r2, r2, r3
	strh r2, [r1, #0x14]
	ldrh r2, [r1, #0x12]
	and r2, r2, r3
	strh r2, [r1, #0x12]
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206DF9C: .word wfsi_task+0x000004C8
	arm_func_end MBP_KickChild

	arm_func_start MBP_StartDownload
MBP_StartDownload: // 0x0206DFA0
	stmdb sp!, {r3, r4, r5, lr}
	mov r1, #2
	mov r4, r0
	bl MB_CommResponseRequest
	cmp r0, #0
	bne _0206E024
	mov r0, #1
	mvn r0, r0, lsl r4
	mov r5, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r1, _0206E054 // =wfsi_task+0x000004C8
	ldrh r2, [r1, #0x12]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x12]
	ldrh r2, [r1, #0x14]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x16]
	ldrh r2, [r1, #0x18]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x18]
	ldrh r2, [r1, #0x1a]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x1a]
	ldrh r2, [r1, #0x1c]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x1c]
	bl OS_RestoreInterrupts
	mov r0, r4
	bl MB_DisconnectChild
	ldmia sp!, {r3, r4, r5, pc}
_0206E024:
	bl OS_DisableInterrupts
	ldr r1, _0206E054 // =wfsi_task+0x000004C8
	mov r5, #1
	ldrh r3, [r1, #0x16]
	mvn r2, r5, lsl r4
	and r2, r3, r2
	strh r2, [r1, #0x16]
	ldrh r2, [r1, #0x18]
	orr r2, r2, r5, lsl r4
	strh r2, [r1, #0x18]
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206E054: .word wfsi_task+0x000004C8
	arm_func_end MBP_StartDownload

	arm_func_start MBP_StartDownloadAll
MBP_StartDownloadAll: // 0x0206E058
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r0, #3
	bl MBP_ChangeState
	mov r5, #1
	ldr r7, _0206E104 // =wfsi_task+0x000004C8
	mov r4, r5
_0206E070:
	ldrh r0, [r7, #0x12]
	tst r0, r4, lsl r5
	beq _0206E0EC
	mov r0, r5
	bl MBP_GetChildState
	cmp r0, #1
	bne _0206E0EC
	mvn r0, r4, lsl r5
	mov r6, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldrh r1, [r7, #0x12]
	and r1, r1, r6, lsr #16
	strh r1, [r7, #0x12]
	ldrh r1, [r7, #0x14]
	and r1, r1, r6, lsr #16
	strh r1, [r7, #0x14]
	ldrh r1, [r7, #0x16]
	and r1, r1, r6, lsr #16
	strh r1, [r7, #0x16]
	ldrh r1, [r7, #0x18]
	and r1, r1, r6, lsr #16
	strh r1, [r7, #0x18]
	ldrh r1, [r7, #0x1a]
	and r1, r1, r6, lsr #16
	strh r1, [r7, #0x1a]
	ldrh r1, [r7, #0x1c]
	and r1, r1, r6, lsr #16
	strh r1, [r7, #0x1c]
	bl OS_RestoreInterrupts
	mov r0, r5
	bl MB_DisconnectChild
_0206E0EC:
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #0x10
	blo _0206E070
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206E104: .word wfsi_task+0x000004C8
	arm_func_end MBP_StartDownloadAll

	arm_func_start MBP_IsBootableAll
MBP_IsBootableAll: // 0x0206E108
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, _0206E164 // =wfsi_task+0x000004C8
	ldrh r0, [r4, #0x12]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r6, #1
	mov r5, r6
_0206E128:
	ldrh r0, [r4, #0x12]
	tst r0, r5, lsl r6
	beq _0206E148
	mov r0, r6
	bl MB_CommIsBootable
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
_0206E148:
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0x10
	blo _0206E128
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0206E164: .word wfsi_task+0x000004C8
	arm_func_end MBP_IsBootableAll

	arm_func_start MBP_StartRebootAll
MBP_StartRebootAll: // 0x0206E168
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r7, #1
	ldr r4, _0206E240 // =wfsi_task+0x000004C8
	mov r8, #0
	mov r5, #3
	mov r6, r7
_0206E180:
	ldrh r0, [r4, #0x1a]
	tst r0, r6, lsl r7
	beq _0206E20C
	mov r0, r7
	mov r1, r5
	bl MB_CommResponseRequest
	cmp r0, #0
	orrne r0, r8, r6, lsl r7
	movne r0, r0, lsl #0x10
	movne r8, r0, lsr #0x10
	bne _0206E20C
	mvn r0, r6, lsl r7
	mov r9, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldrh r1, [r4, #0x12]
	and r1, r1, r9, lsr #16
	strh r1, [r4, #0x12]
	ldrh r1, [r4, #0x14]
	and r1, r1, r9, lsr #16
	strh r1, [r4, #0x14]
	ldrh r1, [r4, #0x16]
	and r1, r1, r9, lsr #16
	strh r1, [r4, #0x16]
	ldrh r1, [r4, #0x18]
	and r1, r1, r9, lsr #16
	strh r1, [r4, #0x18]
	ldrh r1, [r4, #0x1a]
	and r1, r1, r9, lsr #16
	strh r1, [r4, #0x1a]
	ldrh r1, [r4, #0x1c]
	and r1, r1, r9, lsr #16
	strh r1, [r4, #0x1c]
	bl OS_RestoreInterrupts
	mov r0, r7
	bl MB_DisconnectChild
_0206E20C:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0x10
	blo _0206E180
	cmp r8, #0
	bne _0206E234
	mov r0, #7
	bl MBP_ChangeState
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0206E234:
	mov r0, #4
	bl MBP_ChangeState
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0206E240: .word wfsi_task+0x000004C8
	arm_func_end MBP_StartRebootAll

	arm_func_start MBP_Cancel
MBP_Cancel: // 0x0206E244
	stmdb sp!, {r3, lr}
	mov r0, #6
	bl MBP_ChangeState
	bl MB_End
	ldmia sp!, {r3, pc}
	arm_func_end MBP_Cancel

	arm_func_start MBPi_CheckAllReboot
MBPi_CheckAllReboot: // 0x0206E258
	stmdb sp!, {r3, lr}
	ldr r0, _0206E280 // =wfsi_task+0x000004C8
	ldrh r1, [r0, #0x10]
	cmp r1, #4
	ldreqh r1, [r0, #0x12]
	ldreqh r0, [r0, #0x1c]
	cmpeq r1, r0
	ldmneia sp!, {r3, pc}
	bl MB_End
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206E280: .word wfsi_task+0x000004C8
	arm_func_end MBPi_CheckAllReboot

	arm_func_start MBPi_ParentStateCallback
MBPi_ParentStateCallback: // 0x0206E284
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r2
	cmp r1, #0xe
	addls pc, pc, r1, lsl #2
	b _0206E560
_0206E29C: // jump table
	b _0206E560 // case 0
	ldmia sp!, {r3, r4, r5, pc} // case 1
	b _0206E2D8 // case 2
	b _0206E360 // case 3
	ldmia sp!, {r3, r4, r5, pc} // case 4
	ldmia sp!, {r3, r4, r5, pc} // case 5
	ldmia sp!, {r3, r4, r5, pc} // case 6
	b _0206E460 // case 7
	ldmia sp!, {r3, r4, r5, pc} // case 8
	b _0206E488 // case 9
	b _0206E3D4 // case 10
	ldmia sp!, {r3, r4, r5, pc} // case 11
	b _0206E4B4 // case 12
	b _0206E520 // case 13
	b _0206E434 // case 14
_0206E2D8:
	bl MBP_GetState
	cmp r0, #2
	ldmneia sp!, {r3, r4, r5, pc}
	bl OS_DisableInterrupts
	ldr r1, _0206E568 // =wfsi_task+0x000004C8
	mov r2, #1
	ldrh r3, [r1, #0x12]
	orr r2, r3, r2, lsl r5
	strh r2, [r1, #0x12]
	bl OS_RestoreInterrupts
	sub r1, r5, #1
	mov r0, #0x1e
	mul r0, r1, r0
	ldrb r3, [r4, #0xa]
	ldr r1, _0206E56C // =childInfo+0x00000016
	ldr r2, _0206E570 // =childInfo+0x00000017
	strb r3, [r1, r0]
	ldrb r3, [r4, #0xb]
	ldr r1, _0206E574 // =childInfo+0x00000018
	ldr ip, _0206E578 // =childInfo+0x00000019
	strb r3, [r2, r0]
	ldrb lr, [r4, #0xc]
	ldr r3, _0206E57C // =childInfo+0x0000001A
	ldr r2, _0206E580 // =childInfo+0x0000001B
	strb lr, [r1, r0]
	ldrb lr, [r4, #0xd]
	ldr r1, _0206E584 // =childInfo+0x0000001C
	strb lr, [ip, r0]
	ldrb ip, [r4, #0xe]
	strb ip, [r3, r0]
	ldrb r3, [r4, #0xf]
	strb r3, [r2, r0]
	strh r5, [r1, r0]
	ldmia sp!, {r3, r4, r5, pc}
_0206E360:
	bl MBP_GetChildState
	cmp r0, #6
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, #1
	mvn r0, r0, lsl r5
	mov r4, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r1, _0206E568 // =wfsi_task+0x000004C8
	ldrh r2, [r1, #0x12]
	and r2, r2, r4, lsr #16
	strh r2, [r1, #0x12]
	ldrh r2, [r1, #0x14]
	and r2, r2, r4, lsr #16
	strh r2, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	and r2, r2, r4, lsr #16
	strh r2, [r1, #0x16]
	ldrh r2, [r1, #0x18]
	and r2, r2, r4, lsr #16
	strh r2, [r1, #0x18]
	ldrh r2, [r1, #0x1a]
	and r2, r2, r4, lsr #16
	strh r2, [r1, #0x1a]
	ldrh r2, [r1, #0x1c]
	and r2, r2, r4, lsr #16
	strh r2, [r1, #0x1c]
	bl OS_RestoreInterrupts
	bl MBPi_CheckAllReboot
	ldmia sp!, {r3, r4, r5, pc}
_0206E3D4:
	bl MBP_GetState
	cmp r0, #2
	beq _0206E3EC
	mov r0, r5
	bl MBP_KickChild
	ldmia sp!, {r3, r4, r5, pc}
_0206E3EC:
	ldr r1, _0206E568 // =wfsi_task+0x000004C8
	mov r2, #1
	ldrh r3, [r1, #0x14]
	mov r0, r5
	orr r2, r3, r2, lsl r5
	strh r2, [r1, #0x14]
	bl MBP_AcceptChild
	mov r0, r5
	bl MB_CommGetChildUser
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r3, _0206E588 // =childInfo
	sub r2, r5, #1
	mov r1, #0x1e
	mla r1, r2, r1, r3
	mov r2, #0x16
	bl MI_CpuCopy8
	ldmia sp!, {r3, r4, r5, pc}
_0206E434:
	ldr r1, _0206E568 // =wfsi_task+0x000004C8
	mov r4, #1
	ldrh r3, [r1, #0x14]
	mvn r2, r4, lsl r5
	and r2, r3, r2
	strh r2, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	orr r2, r2, r4, lsl r5
	strh r2, [r1, #0x16]
	bl MBP_StartDownload
	ldmia sp!, {r3, r4, r5, pc}
_0206E460:
	ldr r0, _0206E568 // =wfsi_task+0x000004C8
	mov r3, #1
	ldrh r2, [r0, #0x18]
	mvn r1, r3, lsl r5
	and r1, r2, r1
	strh r1, [r0, #0x18]
	ldrh r1, [r0, #0x1a]
	orr r1, r1, r3, lsl r5
	strh r1, [r0, #0x1a]
	ldmia sp!, {r3, r4, r5, pc}
_0206E488:
	ldr r0, _0206E568 // =wfsi_task+0x000004C8
	mov r3, #1
	ldrh r2, [r0, #0x1a]
	mvn r1, r3, lsl r5
	and r1, r2, r1
	strh r1, [r0, #0x1a]
	ldrh r1, [r0, #0x1c]
	orr r1, r1, r3, lsl r5
	strh r1, [r0, #0x1c]
	bl MBPi_CheckAllReboot
	ldmia sp!, {r3, r4, r5, pc}
_0206E4B4:
	bl MBP_GetState
	cmp r0, #4
	bne _0206E4CC
	mov r0, #5
	bl MBP_ChangeState
	b _0206E4D4
_0206E4CC:
	mov r0, #0
	bl MBP_ChangeState
_0206E4D4:
	ldr r1, _0206E568 // =wfsi_task+0x000004C8
	ldr r0, [r1, #4]
	cmp r0, #0
	beq _0206E4F8
	ldr r1, [r1, #8]
	blx r1
	ldr r0, _0206E568 // =wfsi_task+0x000004C8
	mov r1, #0
	str r1, [r0, #4]
_0206E4F8:
	ldr r1, _0206E568 // =wfsi_task+0x000004C8
	ldr r0, [r1, #0xc]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r1, #8]
	blx r1
	ldr r0, _0206E568 // =wfsi_task+0x000004C8
	mov r1, #0
	str r1, [r0, #0xc]
	ldmia sp!, {r3, r4, r5, pc}
_0206E520:
	ldrh r0, [r4, #0]
	cmp r0, #8
	bgt _0206E54C
	ldmgeia sp!, {r3, r4, r5, pc}
	cmp r0, #2
	ldmgtia sp!, {r3, r4, r5, pc}
	cmp r0, #1
	ldmltia sp!, {r3, r4, r5, pc}
	cmpne r0, #2
	beq _0206E554
	ldmia sp!, {r3, r4, r5, pc}
_0206E54C:
	cmp r0, #9
	ldmneia sp!, {r3, r4, r5, pc}
_0206E554:
	mov r0, #7
	bl MBP_ChangeState
	ldmia sp!, {r3, r4, r5, pc}
_0206E560:
	bl OS_Terminate
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206E568: .word wfsi_task+0x000004C8
_0206E56C: .word childInfo+0x00000016
_0206E570: .word childInfo+0x00000017
_0206E574: .word childInfo+0x00000018
_0206E578: .word childInfo+0x00000019
_0206E57C: .word childInfo+0x0000001A
_0206E580: .word childInfo+0x0000001B
_0206E584: .word childInfo+0x0000001C
_0206E588: .word childInfo
	arm_func_end MBPi_ParentStateCallback

	arm_func_start MBP_ChangeState
MBP_ChangeState: // 0x0206E58C
	ldr r1, _0206E598 // =wfsi_task+0x000004C8
	strh r0, [r1, #0x10]
	bx lr
	.align 2, 0
_0206E598: .word wfsi_task+0x000004C8
	arm_func_end MBP_ChangeState

	arm_func_start MBP_GetState
MBP_GetState: // 0x0206E59C
	ldr r0, _0206E5A8 // =wfsi_task+0x000004C8
	ldrh r0, [r0, #0x10]
	bx lr
	.align 2, 0
_0206E5A8: .word wfsi_task+0x000004C8
	arm_func_end MBP_GetState

	arm_func_start MBP_GetChildBmp
MBP_GetChildBmp: // 0x0206E5AC
	ldr r1, _0206E5BC // =_0211AB20
	ldr r0, [r1, r0, lsl #2]
	ldrh r0, [r0, #0]
	bx lr
	.align 2, 0
_0206E5BC: .word _0211AB20
	arm_func_end MBP_GetChildBmp

	arm_func_start MBP_GetChildState
MBP_GetChildState: // 0x0206E5C0
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, _0206E680 // =wfsi_task+0x000004C8
	mov r2, #1
	mov r2, r2, lsl r4
	ldrh r1, [r1, #0x12]
	mov r4, r2, lsl #0x10
	mov r5, r0
	tst r1, r4, lsr #16
	bne _0206E600
	bl OS_RestoreInterrupts
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
_0206E600:
	ldr r0, _0206E684 // =mbpState
	add r1, sp, #0
	mov r2, #0xe
	bl MI_CpuCopy8
	mov r0, r5
	bl OS_RestoreInterrupts
	ldrh r0, [sp, #4]
	tst r0, r4, lsr #16
	addne sp, sp, #0x10
	movne r0, #2
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r0, [sp, #6]
	tst r0, r4, lsr #16
	addne sp, sp, #0x10
	movne r0, #3
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r0, [sp, #8]
	tst r0, r4, lsr #16
	addne sp, sp, #0x10
	movne r0, #4
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r0, [sp, #0xa]
	tst r0, r4, lsr #16
	addne sp, sp, #0x10
	movne r0, #5
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r0, [sp, #0xc]
	tst r0, r4, lsr #16
	movne r0, #6
	moveq r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206E680: .word wfsi_task+0x000004C8
_0206E684: .word mbpState
	arm_func_end MBP_GetChildState

	arm_func_start MBP_GetChildInfo
MBP_GetChildInfo: // 0x0206E688
	ldr r1, _0206E6B4 // =wfsi_task+0x000004C8
	mov r2, #1
	ldrh r1, [r1, #0x12]
	tst r1, r2, lsl r0
	moveq r0, #0
	bxeq lr
	ldr r2, _0206E6B8 // =childInfo
	sub r1, r0, #1
	mov r0, #0x1e
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_0206E6B4: .word wfsi_task+0x000004C8
_0206E6B8: .word childInfo
	arm_func_end MBP_GetChildInfo

	.data

aMbpStateStop: // 0x0211AA34
	.asciz "MBP_STATE_STOP"
	.align 4

aMbpStateIdle: // 0x0211AA44
	.asciz "MBP_STATE_IDLE"
	.align 4

aMbpStateError: // 0x0211AA54
	.asciz "MBP_STATE_ERROR"
	.align 4

aMbpStateEntry: // 0x0211AA64
	.asciz "MBP_STATE_ENTRY"
	.align 4

aMbpStateCancel: // 0x0211AA74
	.asciz "MBP_STATE_CANCEL"
	.align 4

aMbCommPstateEn: // 0x0211AA88
	.asciz "MB_COMM_PSTATE_END"
	.align 4

aMbpStateComple: // 0x0211AA9C
	.asciz "MBP_STATE_COMPLETE"
	.align 4

aMbCommPstateNo: // 0x0211AAB0
	.asciz "MB_COMM_PSTATE_NONE"
	.align 4

aMbpStateReboot: // 0x0211AAC4
	.asciz "MBP_STATE_REBOOTING"
	.align 4

aMbCommPstateEr: // 0x0211AAD8
	.asciz "MB_COMM_PSTATE_ERROR"
	.align 4

aMbpStateDatase: // 0x0211AAF0
	.asciz "MBP_STATE_DATASENDING"
	.align 4

aMbCommPstateKi: // 0x0211AB08
	.asciz "MB_COMM_PSTATE_KICKED"
	.align 4

.public _0211AB20
_0211AB20: // 0x0211AB20
	.word mbpState+0x02
	.word mbpState+0x04
	.word mbpState+0x06
	.word mbpState+0x08
	.word mbpState+0x0A
	.word mbpState+0x0C

.public _0211AB38
_0211AB38: // 0x0211AB38
	.word aMbpStateStop       // "MBP_STATE_STOP"
	.word aMbpStateIdle       // "MBP_STATE_IDLE"
	.word aMbpStateEntry      // "MBP_STATE_ENTRY"
	.word aMbpStateDatase     // "MBP_STATE_DATASENDING"
	.word aMbpStateReboot     // "MBP_STATE_REBOOTING"
	.word aMbpStateComple     // "MBP_STATE_COMPLETE"
	.word aMbpStateCancel     // "MBP_STATE_CANCEL"
	.word aMbpStateError      // "MBP_STATE_ERROR"
	.word aMbCommPstateNo     // "MB_COMM_PSTATE_NONE"
	.word aMbCommPstateIn     // "MB_COMM_PSTATE_INIT_COMPLETE"
	.word aMbCommPstateCo     // "MB_COMM_PSTATE_CONNECTED"
	.word aMbCommPstateDi     // "MB_COMM_PSTATE_DISCONNECTED"
	.word aMbCommPstateKi     // "MB_COMM_PSTATE_KICKED"
	.word aMbCommPstateRe     // "MB_COMM_PSTATE_REQ_ACCEPTED"
	.word aMbCommPstateSe     // "MB_COMM_PSTATE_SEND_PROCEED"
	.word aMbCommPstateSe_0   // "MB_COMM_PSTATE_SEND_COMPLETE"
	.word aMbCommPstateBo     // "MB_COMM_PSTATE_BOOT_REQUEST"
	.word aMbCommPstateBo_0   // "MB_COMM_PSTATE_BOOT_STARTABLE"
	.word aMbCommPstateRe_0   // "MB_COMM_PSTATE_REQUESTED"
	.word aMbCommPstateMe     // "MB_COMM_PSTATE_MEMBER_FULL"
	.word aMbCommPstateEn     // "MB_COMM_PSTATE_END"
	.word aMbCommPstateEr     // "MB_COMM_PSTATE_ERROR"
	.word aMbCommPstateWa     // "MB_COMM_PSTATE_WAIT_TO_SEND"

aMbCommPstateCo: // 0x0211AB94
	.asciz "MB_COMM_PSTATE_CONNECTED"
_0211ABAD:
	.byte 0x00, 0x00, 0x00
aMbCommPstateRe_0: // 0x0211ABB0
	.asciz "MB_COMM_PSTATE_REQUESTED"
_0211ABC9:
	.byte 0x00, 0x00, 0x00
aMbCommPstateMe: // 0x0211ABCC
	.asciz "MB_COMM_PSTATE_MEMBER_FULL"
_0211ABE7:
	.byte 0x00
aMbCommPstateDi: // 0x0211ABE8
	.asciz "MB_COMM_PSTATE_DISCONNECTED"
aMbCommPstateRe: // 0x0211AC04
	.asciz "MB_COMM_PSTATE_REQ_ACCEPTED"
aMbCommPstateSe: // 0x0211AC20
	.asciz "MB_COMM_PSTATE_SEND_PROCEED"
aMbCommPstateBo: // 0x0211AC3C
	.asciz "MB_COMM_PSTATE_BOOT_REQUEST"
aMbCommPstateWa: // 0x0211AC58
	.asciz "MB_COMM_PSTATE_WAIT_TO_SEND"
aMbCommPstateIn: // 0x0211AC74
	.asciz "MB_COMM_PSTATE_INIT_COMPLETE"
_0211AC91:
	.byte 0x00, 0x00, 0x00
aMbCommPstateSe_0: // 0x0211AC94
	.asciz "MB_COMM_PSTATE_SEND_COMPLETE"
_0211ACB1:
	.byte 0x00, 0x00, 0x00
aMbCommPstateBo_0: // 0x0211ACB4
	.asciz "MB_COMM_PSTATE_BOOT_STARTABLE"
	.align 4