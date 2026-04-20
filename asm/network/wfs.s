	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public wfsi_work
wfsi_work: // 0x02138DA0
	.space 0x4 // WFSWork*
	
.public WFS__init_flag
WFS__init_flag: // 0x02138DA4
	.space 0x4
	
.public wfsi_debug_enable
wfsi_debug_enable: // 0x02138DA8
	.space 0x4
	
.public wfsi_task
wfsi_task: // 0x02138DAC
	.space 0x4CC // WFSiTask
	
.public sFilebuf
sFilebuf: // 0x02139278
	.space 0x4 // u8*
	
.public dword_213927C
dword_213927C: // 0x0213927C
	.space 0x4
	
.public sCWork
sCWork: // 0x02139280
	.space 0x4 // u32*

    .text

	arm_func_start WFSi_ReadRomCallback
WFSi_ReadRomCallback: // 0x0206BEFC
	stmdb sp!, {r3, lr}
	mov r0, r2
	mov r2, r3
	bl MI_CpuCopy8
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end WFSi_ReadRomCallback

	arm_func_start WFSi_WriteRomCallback
WFSi_WriteRomCallback: // 0x0206BF14
	mov r0, #1
	bx lr
	arm_func_end WFSi_WriteRomCallback

	arm_func_start WFSi_RomArchiveProc
WFSi_RomArchiveProc: // 0x0206BF1C
	stmdb sp!, {r3, lr}
	cmp r1, #0
	beq _0206BF34
	cmp r1, #1
	beq _0206BF74
	b _0206BF7C
_0206BF34:
	ldr r1, _0206BF84 // =wfsi_work
	ldr r1, [r1, #0]
	cmp r1, #0
	beq _0206BF50
	ldr r1, [r1, #0xc]
	cmp r1, #2
	beq _0206BF58
_0206BF50:
	mov r0, #5
	ldmia sp!, {r3, pc}
_0206BF58:
	ldr r1, [r0, #0x38]
	cmp r1, #0
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	bl WFSi_ReadRequest
	mov r0, #6
	ldmia sp!, {r3, pc}
_0206BF74:
	mov r0, #4
	ldmia sp!, {r3, pc}
_0206BF7C:
	mov r0, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206BF84: .word wfsi_work
	arm_func_end WFSi_RomArchiveProc

	arm_func_start WFSi_LoadTables
WFSi_LoadTables: // 0x0206BF88
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xf4
	movs r5, r0
	mov r0, #0
	moveq r4, #1
	movne r4, r0
	str r0, [sp, #4]
	cmp r4, #0
	mov r8, #0
	bne _0206BFB8
	cmp r1, #0
	movne r8, #1
_0206BFB8:
	add r0, sp, #0x4c
	bl FS_InitFile
	mov r1, #0
	add r0, sp, #0x4c
	sub r2, r1, #0x80000001
	bl FS_CreateFileFromRom
	cmp r4, #0
	beq _0206BFEC
	mov r4, #0
	mov r6, r4
	bl CARD_GetRomHeader
	mov r7, r0
	b _0206C024
_0206BFEC:
	ldr r1, [r5, #0x24]
	ldr r0, [r5, #0x2c]
	add r7, sp, #0x94
	sub r9, r0, r1
	add r4, r9, r1
	mov r0, r5
	mov r1, r7
	mov r2, #0x60
	mov r6, r4
	bl FS_ReadFile
	mov r0, r5
	mov r1, r9
	mov r2, #0
	bl FS_SeekFile
_0206C024:
	cmp r8, #0
	bne _0206C070
	ldr r1, [r7, #0x48]
	ldr r0, [r7, #0x4c]
	str r1, [sp, #0x2c]
	str r0, [sp, #0x30]
	ldr r1, [r7, #0x40]
	ldr r0, [r7, #0x44]
	str r1, [sp, #0x34]
	str r0, [sp, #0x38]
	ldr r1, [r7, #0x50]
	ldr r0, [r7, #0x54]
	str r1, [sp, #0x3c]
	str r0, [sp, #0x40]
	ldr r1, [r7, #0x58]
	ldr r0, [r7, #0x5c]
	str r1, [sp, #0x44]
	str r0, [sp, #0x48]
	b _0206C0C4
_0206C070:
	bl CARD_GetRomHeader
	ldr r1, [r0, #0x48]
	ldr r0, [r0, #0x4c]
	str r1, [sp, #0x2c]
	str r0, [sp, #0x30]
	bl CARD_GetRomHeader
	ldr r1, [r0, #0x40]
	ldr r0, [r0, #0x44]
	mov r6, #0
	str r1, [sp, #0x34]
	str r0, [sp, #0x38]
	ldr r0, [r7, #0x50]
	add r0, r0, r4
	str r0, [sp, #0x3c]
	ldr r0, [r7, #0x54]
	str r0, [sp, #0x40]
	ldr r0, [r7, #0x58]
	add r0, r0, r4
	str r0, [sp, #0x44]
	ldr r0, [r7, #0x5c]
	str r0, [sp, #0x48]
_0206C0C4:
	ldr r0, [sp, #4]
	mov r2, #0
	add r0, r0, #4
	str r0, [sp, #4]
	add r1, sp, #0x2c
	mov r0, #2
	add r9, sp, #0x1c
_0206C0E0:
	add r3, r1, r2, lsl #3
	cmp r2, #0
	ldr r5, [r3, #4]
	bne _0206C118
	cmp r8, #0
	beq _0206C118
	mov r10, r0
_0206C0FC:
	add r3, r1, r10, lsl #3
	ldr r3, [r3, #4]
	add r10, r10, #1
	mov r3, r3, lsr #5
	cmp r10, #4
	add r5, r5, r3, lsl #3
	blt _0206C0FC
_0206C118:
	add r3, r5, #0x1f
	bic r3, r3, #0x1f
	str r3, [r9, r2, lsl #2]
	add r5, r3, #4
	ldr r3, [sp, #4]
	add r2, r2, #1
	add r3, r3, r5
	cmp r2, #4
	str r3, [sp, #4]
	blt _0206C0E0
	bl OS_DisableInterrupts
	ldr r1, _0206C2E8 // =wfsi_work
	mov r5, r0
	ldr r2, [r1, #0]
	ldr r1, [sp, #4]
	ldr r0, [r2, #0x18]
	ldr r3, [r2, #0x14]
	mov r2, #0
	blx r3
	str r0, [sp, #8]
	mov r0, r5
	bl OS_RestoreInterrupts
	ldr r0, [sp, #8]
	mov r10, #0
	str r6, [r0]
	add r9, r0, #4
	add r5, sp, #0x2c
	add r11, sp, #0x4c
_0206C188:
	add r0, r5, r10, lsl #3
	ldr r1, [r0, #4]
	add r0, sp, #0xc
	str r1, [r9]
	ldr r1, [r5, r10, lsl #3]
	str r9, [r0, r10, lsl #2]
	mov r0, r11
	mov r2, #0
	add r1, r6, r1
	bl FS_SeekFile
	ldr r2, [r9, #0]
	mov r0, r11
	add r1, r9, #4
	bl FS_ReadFile
	add r0, sp, #0x1c
	ldr r0, [r0, r10, lsl #2]
	add r10, r10, #1
	add r0, r0, #4
	add r9, r9, r0
	cmp r10, #4
	blt _0206C188
	cmp r8, #0
	beq _0206C2AC
	ldr r2, [sp, #0xc]
	ldr r0, [r7, #0x48]
	ldr r1, [r2, #0]
	add r11, r4, r0
	mov r0, #2
	add r5, r2, #4
	mov r6, r1, lsr #3
	add r10, r5, r6, lsl #3
	str r0, [sp]
_0206C208:
	ldr r0, [sp]
	add r1, sp, #0xc
	ldr r0, [r1, r0, lsl #2]
	mov r9, #0
	add r7, r0, #4
	ldr r0, [r0, #0]
	mov r8, r0, lsr #5
	cmp r8, #0
	ble _0206C28C
_0206C22C:
	add r1, r7, r9, lsl #5
	ldr r1, [r1, #0x18]
	add r0, sp, #0x4c
	mov r2, #0
	add r1, r11, r1, lsl #3
	bl FS_SeekFile
	add r0, sp, #0x4c
	mov r1, r10
	mov r2, #8
	bl FS_ReadFile
	ldr r2, [r5, r6, lsl #3]
	add r1, r7, r9, lsl #5
	add r2, r2, r4
	add r9, r9, #1
	add r0, r5, r6, lsl #3
	str r2, [r5, r6, lsl #3]
	ldr r2, [r0, #4]
	add r10, r10, #8
	add r2, r2, r4
	str r2, [r0, #4]
	str r6, [r1, #0x18]
	add r6, r6, #1
	cmp r9, r8
	blt _0206C22C
_0206C28C:
	ldr r0, [sp]
	add r0, r0, #1
	str r0, [sp]
	cmp r0, #4
	blt _0206C208
	ldr r0, [sp, #0xc]
	mov r1, r6, lsl #3
	str r1, [r0]
_0206C2AC:
	ldr r0, [sp, #8]
	ldr r1, [sp, #4]
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	add r0, sp, #0x4c
	bl FS_CloseFile
	ldr r1, _0206C2E8 // =wfsi_work
	ldr r0, [sp, #8]
	ldr r2, [r1, #0]
	str r0, [r2, #0x20]
	ldr r1, [r1, #0]
	ldr r0, [sp, #4]
	str r0, [r1, #0x24]
	add sp, sp, #0xf4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0206C2E8: .word wfsi_work
	arm_func_end WFSi_LoadTables

	arm_func_start WFSi_ReplaceRomArchive
WFSi_ReplaceRomArchive: // 0x0206C2EC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x30
	mov r6, r0
	ldr r0, _0206C398 // =aRom
	mov r1, #3
	bl FS_FindArchive
	mov r5, r0
	bl FS_UnloadArchive
	ldr r1, _0206C39C // =WFSi_RomArchiveProc
	mov r0, r5
	mvn r2, #0
	bl FS_SetArchiveProc
	ldr r4, [r6], #4
	mov r3, #0
	add r2, sp, #0x10
_0206C328:
	add r0, r6, #4
	str r0, [r2, r3, lsl #3]
	ldr r1, [r6, #0]
	add r0, r2, r3, lsl #3
	str r1, [r0, #4]
	add r0, r1, #0x1f
	ldr r1, [r2, r3, lsl #3]
	bic r0, r0, #0x1f
	add r3, r3, #1
	cmp r3, #4
	add r6, r1, r0
	blt _0206C328
	ldr r0, [sp, #0x18]
	ldr r1, _0206C3A0 // =WFSi_ReadRomCallback
	str r0, [sp]
	ldr r2, [sp, #0x1c]
	ldr r0, _0206C3A4 // =WFSi_WriteRomCallback
	str r2, [sp, #4]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	ldr r2, [sp, #0x10]
	ldr r3, [sp, #0x14]
	mov r0, r5
	mov r1, #0
	bl FS_LoadArchive
	mov r0, r4
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0206C398: .word aRom
_0206C39C: .word WFSi_RomArchiveProc
_0206C3A0: .word WFSi_ReadRomCallback
_0206C3A4: .word WFSi_WriteRomCallback
	arm_func_end WFSi_ReplaceRomArchive

	arm_func_start WFSi_OnSendMessageDone
WFSi_OnSendMessageDone: // 0x0206C3A8
	stmdb sp!, {r3, lr}
	ldr r1, _0206C3EC // =wfsi_work
	ldr r2, [r1, #0]
	cmp r2, #0
	ldrne r1, [r2, #0xc]
	cmpne r1, #0
	ldrne r1, [r2, #0]
	cmpne r1, #0
	ldmeqia sp!, {r3, pc}
	ldrh r0, [r0, #8]
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	add r0, r2, #0x10000
	mov r1, #0
	str r1, [r0, #0xb94]
	bl WFSi_SendAck
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206C3EC: .word wfsi_work
	arm_func_end WFSi_OnSendMessageDone

	arm_func_start WFSi_SendMessage
WFSi_SendMessage: // 0x0206C3F0
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr ip, [sp]
	and r0, r0, #0xf
	bic ip, ip, #0xf
	orr ip, ip, r0
	and ip, ip, #0xff
	orr ip, ip, r3, lsl #8
	ldr r0, _0206C460 // =wfsi_work
	str r2, [sp, #4]
	ldr r3, [r0, #0]
	str ip, [sp]
	ldr r0, [r3, #0x28]
	bic r2, ip, #0xf0
	mov r0, r0, asr #8
	and r0, r0, #0xff
	mov r0, r0, lsl #0x1c
	orr r0, r2, r0, lsr #24
	str r0, [sp]
	ldr ip, [r3, #0x28]
	mov r0, r1
	ldr r3, _0206C464 // =WFSi_OnSendMessageDone
	add r1, sp, #0
	mov r2, #9
	strb ip, [sp, #8]
	bl WBT_PutUserData
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0206C460: .word wfsi_work
_0206C464: .word WFSi_OnSendMessageDone
	arm_func_end WFSi_SendMessage

	arm_func_start WFSi_SendAck
WFSi_SendAck: // 0x0206C468
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r0, _0206C6E4 // =wfsi_work
	ldr r2, [r0, #0]
	cmp r2, #0
	ldrne r0, [r2, #0]
	add r4, r2, #0x440
	cmpne r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r3, r4, #0x10000
	ldr r0, [r3, #0x754]
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [r3, #0x74c]
	ldr r0, [r3, #0x758]
	and r0, r1, r0
	str r0, [r3, #0x74c]
	ldr r1, [r3, #0x750]
	ldr r0, [r3, #0x758]
	and r0, r1, r0
	str r0, [r3, #0x750]
	ldr r1, [r3, #0x75c]
	ldr r0, [r3, #0x758]
	and r0, r1, r0
	str r0, [r3, #0x75c]
	ldr r1, [r3, #0x768]
	ldr r0, [r3, #0x758]
	and r0, r1, r0
	str r0, [r3, #0x768]
	ldr r0, [r3, #0x760]
	cmp r0, #0
	beq _0206C550
	ldr r0, [r3, #0x764]
	cmp r0, #0
	bne _0206C550
	ldr r0, [r3, #0x76c]
	ldr r1, [r2, #0x2c]
	mov r5, #0
	str r5, [r3, #0x760]
	str r0, [r2, #0x28]
	bl WBT_SetPacketSize
	add r0, r4, #0x10000
	ldr r0, [r0, #0x768]
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r0, lsl #0x10
	mov r2, r5
	mov r1, r0, lsr #0x10
	mov r3, r2
	mov r0, #1
	bl WFSi_SendMessage
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r0, r4, #0x10000
	mov r1, #1
	str r1, [r0, #0x754]
	mov r1, r5
	str r1, [r0, #0x768]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0206C550:
	add r0, r4, #0x10000
	ldr r5, [r0, #0x74c]
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r3, [r0, #0x750]
	mov r1, #0
	cmp r3, #0
	beq _0206C580
	and r0, r3, r5
	cmp r3, r0
	moveq r6, #1
	beq _0206C584
_0206C580:
	mov r6, #0
_0206C584:
	cmp r6, #0
	movne r5, r3
	mvneq r0, r3
	andeq r5, r5, r0
	mov lr, r4
	mov r2, #0
	mov r0, #1
_0206C5A0:
	cmp r5, r0, lsl r2
	mov ip, r0, lsl r2
	blt _0206C5F8
	tst ip, r5
	beq _0206C5EC
	cmp r1, #0
	moveq r1, lr
	beq _0206C5EC
	ldr r8, [r1, #0]
	ldr r7, [lr]
	mov r8, r8, lsl #0x1c
	mov r8, r8, lsr #0x1c
	mov r7, r7, lsl #0x1c
	cmp r8, r7, lsr #28
	ldreq r8, [r1, #4]
	ldreq r7, [lr, #4]
	cmpeq r8, r7
	mvnne ip, ip
	andne r5, r5, ip
_0206C5EC:
	add lr, lr, #0xc
	add r2, r2, #1
	b _0206C5A0
_0206C5F8:
	cmp r6, #0
	cmpne r5, r3
	addne r0, r4, #0x10000
	movne r2, #0
	strne r2, [r0, #0x750]
	cmp r1, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r1, #0]
	mov r2, r0, lsl #0x1c
	movs r2, r2, lsr #0x1c
	beq _0206C630
	cmp r2, #2
	beq _0206C640
	b _0206C698
_0206C630:
	bic r0, r0, #0xf
	orr r0, r0, #1
	str r0, [r1]
	b _0206C698
_0206C640:
	bic r0, r0, #0xf
	orr r0, r0, #3
	str r0, [r1]
	add r0, r4, #0x10000
	ldr r3, [r0, #0x75c]
	mvn r2, r5
	and r2, r3, r2
	mov r6, #1
	str r2, [r0, #0x75c]
	mov r3, r6
_0206C668:
	tst r5, r3, lsl r6
	beq _0206C684
	add r0, r4, r6, lsl #2
	add r0, r0, #0x10000
	ldr r2, [r0, #0x770]
	add r2, r2, #1
	str r2, [r0, #0x770]
_0206C684:
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0x10
	blo _0206C668
_0206C698:
	ldr r0, [r1, #0]
	mov r3, r5, lsl #0x10
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	ldr r2, [r1, #4]
	mov r1, r3, lsr #0x10
	and r0, r0, #0xff
	mov r3, #1
	bl WFSi_SendMessage
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r0, r4, #0x10000
	mov r1, #1
	str r1, [r0, #0x754]
	ldr r2, [r0, #0x74c]
	mvn r1, r5
	and r1, r2, r1
	str r1, [r0, #0x74c]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0206C6E4: .word wfsi_work
	arm_func_end WFSi_SendAck

	arm_func_start WFSi_SendOpenAck
WFSi_SendOpenAck: // 0x0206C6E8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	mov r6, r1
	bl OS_DisableInterrupts
	ldr r1, _0206C7C8 // =wfsi_work
	mov r4, r0
	ldr r0, [r1, #0]
	cmp r0, #0
	ldrne r0, [r0, #0xc]
	cmpne r0, #0
	beq _0206C7B8
	ldr r5, [r6, #0x88]
	mov r3, #0
	str r3, [r6, #0x88]
	add r0, r7, #0x10000
	ldr r1, [r0, #0x74c]
	orr r1, r1, r5
	str r1, [r0, #0x74c]
	ldr r0, [r6, #0x84]
	cmp r0, #0
	bgt _0206C77C
	ldr r2, [r6, #0x60]
	ldr r0, [r6, #0x5c]
	ldr r1, [r6, #0x8c]
	sub r0, r2, r0
	cmp r0, #0x400
	str r0, [sp]
	mov ip, #0
	ldr r2, _0206C7CC // =wfsi_def_user_data
	addls r3, r6, #0xc0
	add r0, r6, #4
	str ip, [sp, #4]
	bl WBT_RegisterBlock
	mov r0, r7
	mov r1, r6
	bl WFSi_FromBusyToAlive
_0206C77C:
	mov r2, #0
	mov r1, #1
_0206C784:
	cmp r5, r1, lsl r2
	mov r0, r1, lsl r2
	blt _0206C7B8
	tst r0, r5
	beq _0206C7AC
	ldr r0, [r6, #0x84]
	add r0, r0, #1
	str r0, [r6, #0x84]
	ldr r0, [r6, #0x8c]
	str r0, [r7, #4]
_0206C7AC:
	add r7, r7, #0xc
	add r2, r2, #1
	b _0206C784
_0206C7B8:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206C7C8: .word wfsi_work
_0206C7CC: .word wfsi_def_user_data
	arm_func_end WFSi_SendOpenAck

	arm_func_start WFSi_FindAlive
WFSi_FindAlive: // 0x0206C7D0
	add r0, r0, #0x10000
	ldr r0, [r0, #0x744]
	cmp r0, #0
	bxeq lr
_0206C7E0:
	ldr r3, [r0, #0x80]
	cmp r3, #2
	ldreq ip, [r0, #0x5c]
	cmpeq r1, ip
	ldreq r3, [r0, #0x60]
	subeq r3, r3, ip
	cmpeq r2, r3
	bxeq lr
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0206C7E0
	bx lr
	arm_func_end WFSi_FindAlive

	arm_func_start WFSi_FindBusy
WFSi_FindBusy: // 0x0206C810
	stmdb sp!, {r4, r5, r6, lr}
	add r3, r0, #0x10000
	ldr r4, [r3, #0x748]
	mov r6, r1
	mov r5, r2
	cmp r4, #0
	beq _0206C854
_0206C82C:
	ldr r1, [r4, #0x80]
	cmp r1, #1
	ldreq r1, [r4, #0x90]
	cmpeq r1, r6
	ldreq r1, [r4, #0x94]
	cmpeq r1, r5
	beq _0206C854
	ldr r4, [r4, #0]
	cmp r4, #0
	bne _0206C82C
_0206C854:
	cmp r4, #0
	bne _0206C878
	bl WFSi_FromFreeToBusy
	mov r4, r0
	mov r0, #0
	str r0, [r4, #0x84]
	str r6, [r4, #0x90]
	str r5, [r4, #0x94]
	bl WFSi_NotifyBusy
_0206C878:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end WFSi_FindBusy

	arm_func_start WFSi_FindAliveForID
WFSi_FindAliveForID: // 0x0206C880
	add r0, r0, #0x10000
	ldr r0, [r0, #0x744]
	cmp r0, #0
	bxeq lr
_0206C890:
	ldr r2, [r0, #0x80]
	cmp r2, #2
	ldreq r2, [r0, #4]
	cmpeq r2, r1
	bxeq lr
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0206C890
	bx lr
	arm_func_end WFSi_FindAliveForID

	arm_func_start WFSi_MoveList
WFSi_MoveList: // 0x0206C8B4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl OS_DisableInterrupts
	ldr r1, [r6, #0]
	cmp r1, #0
	beq _0206C924
_0206C8D4:
	ldr r2, [r6, #0]
	cmp r2, r4
	bne _0206C914
	ldr r1, [r4, #0]
	str r1, [r6]
	ldr r1, [r5, #0]
	cmp r1, #0
	beq _0206C904
_0206C8F4:
	mov r5, r1
	ldr r1, [r1, #0]
	cmp r1, #0
	bne _0206C8F4
_0206C904:
	str r4, [r5]
	mov r1, #0
	str r1, [r4]
	b _0206C924
_0206C914:
	ldr r1, [r2, #0]
	mov r6, r2
	cmp r1, #0
	bne _0206C8D4
_0206C924:
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end WFSi_MoveList

	arm_func_start WFSi_FromFreeToBusy
WFSi_FromFreeToBusy: // 0x0206C92C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0x10000
	ldr r4, [r0, #0x740]
	add r0, r5, #0x740
	add r1, r5, #0x348
	mov r2, r4
	add r0, r0, #0x10000
	add r1, r1, #0x10400
	bl WFSi_MoveList
	mov r0, #1
	str r0, [r4, #0x80]
	add r1, r5, #0x10000
	ldr r2, [r1, #0x764]
	mov r0, r4
	add r2, r2, #1
	str r2, [r1, #0x764]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end WFSi_FromFreeToBusy

	arm_func_start WFSi_FromBusyToAlive
WFSi_FromBusyToAlive: // 0x0206C974
	stmdb sp!, {r4, lr}
	mov r4, r1
	add r1, r0, #0x348
	add r3, r0, #0x344
	add r0, r1, #0x10400
	mov r2, r4
	add r1, r3, #0x10400
	bl WFSi_MoveList
	mov r0, #2
	str r0, [r4, #0x80]
	ldmia sp!, {r4, pc}
	arm_func_end WFSi_FromBusyToAlive

	arm_func_start WFSi_FromAliveToBusy
WFSi_FromAliveToBusy: // 0x0206C9A0
	stmdb sp!, {r4, lr}
	mov r4, r1
	add r1, r0, #0x344
	add r3, r0, #0x348
	add r0, r1, #0x10400
	mov r2, r4
	add r1, r3, #0x10400
	bl WFSi_MoveList
	mov r0, #3
	str r0, [r4, #0x80]
	ldmia sp!, {r4, pc}
	arm_func_end WFSi_FromAliveToBusy

	arm_func_start WFSi_FromBusyToFree
WFSi_FromBusyToFree: // 0x0206C9CC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	add r0, r5, #0x348
	add r1, r5, #0x740
	mov r2, r4
	add r0, r0, #0x10400
	add r1, r1, #0x10000
	bl WFSi_MoveList
	mov r0, #0
	str r0, [r4, #0x80]
	add r0, r5, #0x10000
	ldr r1, [r0, #0x764]
	sub r1, r1, #1
	str r1, [r0, #0x764]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end WFSi_FromBusyToFree

	arm_func_start WFSi_ReadRequest
WFSi_ReadRequest: // 0x0206CA0C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0206CA60 // =wfsi_work
	mov r5, r0
	ldr r4, [r1, #0]
	ldr r1, [r5, #0x38]
	add r0, r4, #0x440
	bl WFSi_ReallocBitmap
	ldr r1, _0206CA60 // =wfsi_work
	mov r0, #0
	ldr r2, [r1, #0]
	mov r1, #1
	str r5, [r2, #0x1c]
	ldr ip, [r4, #0xf44]
	ldr r2, [r5, #0x2c]
	ldr r3, [r5, #0x38]
	add r2, ip, r2
	bl WFSi_SendMessage
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	bl OS_Terminate
	arm_func_end WFSi_ReadRequest

	arm_func_start sub_206ca5c
sub_206ca5c: // 0x0206CA5C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206CA60: .word wfsi_work
	arm_func_end sub_206ca5c

	arm_func_start WFSi_SetMPData
WFSi_SetMPData: // 0x0206CA64
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldr r0, _0206CB18 // =wfsi_work
	ldr r4, [r0, #0]
	ldr r2, [r4, #0]
	cmp r2, #0
	ldrne r0, [r4, #0x28]
	ldreq r0, [r4, #0x2c]
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	ldr r0, [r4, #4]
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, pc}
	cmp r2, #0
	add r0, r4, #0x40
	beq _0206CAB0
	bl WBT_MpParentSendHook
	b _0206CAB4
_0206CAB0:
	bl WBT_MpChildSendHook
_0206CAB4:
	ldr r1, _0206CB1C // =0x0000FFFF
	mov r0, r0, lsl #0x10
	str r1, [sp]
	ldrh r1, [r4, #0x30]
	mov r3, r0, lsr #0x10
	ldr r0, _0206CB20 // =WFSi_OnSetMPDataDone
	str r1, [sp, #4]
	mov ip, #3
	add r2, r4, #0x40
	mov r1, #0
	str ip, [sp, #8]
	bl WM_SetMPDataToPort
	cmp r0, #2
	moveq r1, #1
	movne r1, #0
	ldr r0, _0206CB18 // =wfsi_work
	str r1, [r4, #8]
	ldr r0, [r0, #0]
	ldr r0, [r0, #8]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	str r0, [r4, #4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0206CB18: .word wfsi_work
_0206CB1C: .word 0x0000FFFF
_0206CB20: .word WFSi_OnSetMPDataDone
	arm_func_end WFSi_SetMPData

	arm_func_start WFSi_OnSetMPDataDone
WFSi_OnSetMPDataDone: // 0x0206CB24
	stmdb sp!, {r3, lr}
	ldr r0, _0206CB54 // =wfsi_work
	ldr r1, [r0, #0]
	cmp r1, #0
	ldrne r0, [r1, #0xc]
	cmpne r0, #0
	ldmeqia sp!, {r3, pc}
	mov r0, #1
	str r0, [r1, #4]
	bl WFSi_SendAck
	bl WFSi_SetMPData
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206CB54: .word wfsi_work
	arm_func_end WFSi_OnSetMPDataDone

	arm_func_start WFSi_PortCallback
WFSi_PortCallback: // 0x0206CB58
	stmdb sp!, {r3, lr}
	ldr r1, _0206CC74 // =wfsi_work
	ldr r3, [r1, #0]
	cmp r3, #0
	ldrne r2, [r3, #0xc]
	add ip, r3, #0x440
	cmpne r2, #0
	ldmeqia sp!, {r3, pc}
	ldrh r1, [r0, #4]
	cmp r1, #0x15
	bgt _0206CBA8
	bge _0206CC28
	cmp r1, #9
	ldmgtia sp!, {r3, pc}
	cmp r1, #7
	ldmltia sp!, {r3, pc}
	beq _0206CBC0
	cmp r1, #9
	beq _0206CBE4
	ldmia sp!, {r3, pc}
_0206CBA8:
	cmp r1, #0x1a
	ldmgtia sp!, {r3, pc}
	cmp r1, #0x19
	ldmltia sp!, {r3, pc}
	cmpne r1, #0x1a
	ldmia sp!, {r3, pc}
_0206CBC0:
	ldr r0, [r3, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	cmp r2, #2
	ldreq r0, [r3, #8]
	cmpeq r0, #0
	ldmneia sp!, {r3, pc}
	bl WFSi_SetMPData
	ldmia sp!, {r3, pc}
_0206CBE4:
	ldr r1, [r3, #0]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	cmp r2, #2
	ldmneia sp!, {r3, pc}
	ldrh r2, [r0, #0x12]
	mov r3, #1
	add r1, ip, #0x10000
	mov r0, r3, lsl r2
	mvn r2, r3, lsl r2
	ldr r3, [r1, #0x758]
	mov r0, r0, lsl #0x10
	and r2, r3, r2
	mov r0, r0, lsr #0x10
	str r2, [r1, #0x758]
	bl WBT_CancelCurrentCommand
	ldmia sp!, {r3, pc}
_0206CC28:
	ldr r1, [r3, #0]
	ldr lr, [r0, #0xc]
	cmp r1, #0
	ldrh r1, [r0, #0x10]
	beq _0206CC68
	cmp r2, #2
	bne _0206CC68
	add r3, ip, #0x10000
	ldrh r2, [r0, #0x12]
	ldr ip, [r3, #0x758]
	mov r0, #1
	orr ip, ip, r0, lsl r2
	mov r0, lr
	str ip, [r3, #0x758]
	bl WBT_MpParentRecvHook
	ldmia sp!, {r3, pc}
_0206CC68:
	mov r0, lr
	bl WBT_MpChildRecvHook
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206CC74: .word wfsi_work
	arm_func_end WFSi_PortCallback

	arm_func_start WFSi_OnParentSystemCallback
WFSi_OnParentSystemCallback: // 0x0206CC78
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	ldrh r0, [r4, #0xa]
	bl WBT_AidbitmapToAid
	ldr r1, [r4, #0]
	mov r5, r0
	cmp r1, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r4, #4]
	cmp r0, #2
	ldmleia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r0, #0xd
	ldmgtia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r0, #8
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r0, #0xa
	beq _0206CCCC
	cmp r0, #0xd
	beq _0206CE64
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CCCC:
	ldr r3, _0206CFBC // =wfsi_work
	add r6, r4, #0x14
	ldr r1, [r3, #0]
	mov r0, #0xc
	mla r0, r5, r0, r1
	add r7, r0, #0x440
	ldmia r6, {r0, r1, r2}
	stmia r7, {r0, r1, r2}
	ldr r4, [r4, #0x14]
	mov r0, r4, lsl #0x1c
	movs r0, r0, lsr #0x1c
	beq _0206CD08
	cmp r0, #2
	beq _0206CDEC
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CD08:
	ldr r1, [r3, #0]
	mov r3, r4, lsl #0x18
	add r7, r1, #0x440
	add r0, r7, #0x10000
	ldr r0, [r0, #0x760]
	ldrb r2, [r6, #8]
	mov r3, r3, lsr #0x1c
	cmp r0, #0
	ldreq r0, [r1, #0x28]
	orr r2, r2, r3, lsl #8
	mov r4, r4, lsr #8
	ldr r6, [r6, #4]
	cmpeq r2, r0
	beq _0206CD68
	add r0, r7, #0x10000
	mov r2, #1
	str r2, [r0, #0x760]
	ldr r1, [r0, #0x768]
	orr r1, r1, r2, lsl r5
	str r1, [r0, #0x768]
	ldr r1, [r0, #0x75c]
	orr r1, r1, r2, lsl r5
	str r1, [r0, #0x75c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CD68:
	mov r0, r7
	mov r1, r6
	mov r2, r4
	bl WFSi_FindAlive
	cmp r0, #0
	beq _0206CDB4
	add r1, r7, #0x10000
	mov r2, #0xc
	ldr r4, [r1, #0x74c]
	mov r3, #1
	orr r3, r4, r3, lsl r5
	str r3, [r1, #0x74c]
	mla r1, r5, r2, r7
	ldr r2, [r0, #0x8c]
	str r2, [r1, #4]
	ldr r1, [r0, #0x84]
	add r1, r1, #1
	str r1, [r0, #0x84]
	b _0206CDD4
_0206CDB4:
	mov r0, r7
	mov r1, r6
	mov r2, r4
	bl WFSi_FindBusy
	ldr r2, [r0, #0x88]
	mov r1, #1
	orr r1, r2, r1, lsl r5
	str r1, [r0, #0x88]
_0206CDD4:
	add r0, r7, #0x10000
	ldr r2, [r0, #0x75c]
	mov r1, #1
	orr r1, r2, r1, lsl r5
	str r1, [r0, #0x75c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CDEC:
	ldr r0, [r3, #0]
	add r4, r0, #0x440
	bl OS_DisableInterrupts
	add r1, r4, #0x10000
	ldr r3, [r1, #0x74c]
	mov r2, #1
	orr r2, r3, r2, lsl r5
	str r2, [r1, #0x74c]
	mov r7, r0
	ldr r1, [r6, #4]
	mov r0, r4
	bl WFSi_FindAliveForID
	movs r5, r0
	beq _0206CE58
	ldr r0, [r5, #0x84]
	sub r0, r0, #1
	str r0, [r5, #0x84]
	cmp r0, #0
	bgt _0206CE58
	mov r0, #0
	str r0, [r5, #0x88]
	ldr r0, [r6, #4]
	bl WBT_UnregisterBlock
	mov r0, r4
	mov r1, r5
	bl WFSi_FromAliveToBusy
	bl WFSi_NotifyBusy
_0206CE58:
	mov r0, r7
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CE64:
	ldr r0, _0206CFBC // =wfsi_work
	ldr r1, [r4, #0x14]
	ldr r0, [r0, #0]
	mov r2, #0
	add r0, r0, #0x440
	str r2, [r4, #0x1c]
	bl WFSi_FindAliveForID
	movs r5, r0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, [r5, #0x9c]
	ldrsh r0, [r4, #0x20]
	cmp r1, #2
	ldr r1, [r5, #0x98]
	ldr r2, [r4, #0x18]
	beq _0206CEBC
	ldr r3, [r5, #0x44]
	tst r3, #1
	movne r3, #1
	moveq r3, #0
	cmp r3, #0
	moveq r3, #2
	streq r3, [r5, #0x9c]
_0206CEBC:
	mul ip, r0, r1
	str r2, [r5, #0x98]
	mov r3, #0
	b _0206CF10
_0206CECC:
	ldr r6, [r5, #0x9c]
	cmp r3, r6
	beq _0206CF0C
	add r6, r5, r3, lsl #2
	ldr r6, [r6, #0xa4]
	subs r7, ip, r6
	bmi _0206CF0C
	add r6, r7, r0
	cmp r6, #0x400
	bgt _0206CF0C
	add r6, r5, #0xc0
	add r6, r6, r3, lsl #10
	str r1, [r4, #0x18]
	add r1, r6, r7
	str r1, [r4, #0x1c]
	b _0206CF18
_0206CF0C:
	add r3, r3, #1
_0206CF10:
	cmp r3, #2
	blt _0206CECC
_0206CF18:
	ldr r1, [r5, #0x9c]
	cmp r1, #2
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mul r6, r0, r2
	mov r2, #0
	b _0206CF50
_0206CF30:
	add r1, r5, r2, lsl #2
	ldr r1, [r1, #0xa4]
	subs r1, r6, r1
	bmi _0206CF4C
	add r1, r1, r0
	cmp r1, #0x400
	ble _0206CF58
_0206CF4C:
	add r2, r2, #1
_0206CF50:
	cmp r2, #2
	blt _0206CF30
_0206CF58:
	cmp r2, #2
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r4, [r5, #0xa0]
	mov r0, #0
_0206CF68:
	add r4, r4, #1
	cmp r4, #2
	movge r4, r0
	cmp r4, r3
	beq _0206CF68
	mov r0, #0x200
	str r4, [r5, #0xa0]
	rsb r0, r0, #0
	and r1, r6, r0
	str r4, [r5, #0x9c]
	add r3, r5, r4, lsl #2
	add r0, r5, #0x38
	mov r2, #0
	str r1, [r3, #0xa4]
	bl FS_SeekFile
	add r1, r5, #0xc0
	add r0, r5, #0x38
	add r1, r1, r4, lsl #10
	mov r2, #0x400
	bl FS_ReadFileAsync
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206CFBC: .word wfsi_work
	arm_func_end WFSi_OnParentSystemCallback

	arm_func_start WFSi_ReallocBitmap
WFSi_ReallocBitmap: // 0x0206CFC0
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	cmp r1, #0
	ldrlt r1, [r4, #0xb08]
	movlt r0, #0
	strlt r0, [r4, #0xb08]
	ldr r0, [r4, #0xb08]
	cmp r0, r1
	ldmhsia sp!, {r4, r5, r6, pc}
	str r1, [r4, #0xb08]
	ldr r6, [r4, #0xb00]
	cmp r6, #0
	beq _0206D020
	bl OS_DisableInterrupts
	ldr r1, _0206D088 // =wfsi_work
	mov r5, r0
	ldr r1, [r1, #0]
	mov r2, r6
	ldr r0, [r1, #0x18]
	ldr r3, [r1, #0x14]
	mov r1, #0
	blx r3
	mov r0, r5
	bl OS_RestoreInterrupts
_0206D020:
	ldr r0, _0206D088 // =wfsi_work
	ldr r2, [r4, #0xb08]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x28]
	sub r1, r0, #0xe
	add r0, r2, r1
	sub r0, r0, #1
	bl _u32_div_f
	add r0, r0, #0x1f
	mov r0, r0, lsr #2
	mov r5, r0, lsl #4
	bl OS_DisableInterrupts
	ldr r1, _0206D088 // =wfsi_work
	mov r6, r0
	ldr r2, [r1, #0]
	mov r1, r5
	ldr r0, [r2, #0x18]
	ldr r3, [r2, #0x14]
	mov r2, #0
	blx r3
	mov r5, r0
	mov r0, r6
	bl OS_RestoreInterrupts
	str r5, [r4, #0xb00]
	str r5, [r4, #0x80]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0206D088: .word wfsi_work
	arm_func_end WFSi_ReallocBitmap

	arm_func_start WFSi_OnChildSystemCallback
WFSi_OnChildSystemCallback: // 0x0206D08C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r6, r0
	ldrh r0, [r6, #0xa]
	bl WBT_AidbitmapToAid
	ldr r1, _0206D38C // =wfsi_work
	ldr r3, [r6, #0]
	ldr r2, [r1, #0]
	mov r4, r0
	cmp r3, #6
	add r5, r2, #0x440
	bgt _0206D0E4
	cmp r3, #2
	addlt sp, sp, #8
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
	beq _0206D0F4
	cmp r3, #4
	beq _0206D224
	cmp r3, #6
	beq _0206D180
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D0E4:
	cmp r3, #0xc
	beq _0206D2C0
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D0F4:
	ldrh r0, [r6, #8]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldrsh r0, [r6, #0x16]
	add r0, r0, #0xe
	str r0, [r2, #0x28]
	ldrsh r2, [r6, #0x18]
	ldr r0, [r1, #0]
	add r2, r2, #0xe
	str r2, [r0, #0x2c]
	ldr r1, [r1, #0]
	ldr r0, [r1, #0x20]
	cmp r0, #0
	bne _0206D14C
	ldr r3, _0206D390 // =WFSi_OnChildSystemCallback
	mov r2, r5
	mov r0, #1
	mov r1, #0
	bl sub_20F689C
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D14C:
	ldr r0, [r1, #0x1c]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r5
	mvn r1, #0
	bl WFSi_ReallocBitmap
	ldr r0, _0206D38C // =wfsi_work
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x1c]
	bl WFSi_ReadRequest
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D180:
	ldr r0, [r5, r4, lsl #2]
	ldr r0, [r0, #4]
	str r0, [r2, #0x24]
	ldr r0, [r1, #0]
	ldr r6, [r0, #0x24]
	bl OS_DisableInterrupts
	ldr r1, _0206D38C // =wfsi_work
	mov r7, r0
	ldr r2, [r1, #0]
	mov r1, r6
	ldr r0, [r2, #0x18]
	ldr r3, [r2, #0x14]
	mov r2, #0
	blx r3
	mov r6, r0
	mov r0, r7
	bl OS_RestoreInterrupts
	ldr r1, _0206D38C // =wfsi_work
	mov r0, r5
	ldr r2, [r1, #0]
	str r6, [r2, #0x20]
	ldr r1, [r1, #0]
	ldr r1, [r1, #0x24]
	bl WFSi_ReallocBitmap
	ldr r1, _0206D38C // =wfsi_work
	add r6, r5, r4, lsl #2
	ldr r0, [r1, #0]
	add r4, r5, #0x80
	add r2, r5, #0x40
	ldr r5, [r0, #0x20]
	ldr r3, _0206D390 // =WFSi_OnChildSystemCallback
	str r5, [r6, #0x40]
	str r4, [sp]
	str r3, [sp, #4]
	ldr r3, [r1, #0]
	mov r0, #1
	ldr r3, [r3, #0x24]
	mov r1, #0x20000
	bl WBT_GetBlock
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D224:
	ldrh r0, [r6, #8]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r2, #0xc]
	cmp r0, #2
	beq _0206D294
	ldr r0, [r2, #0x20]
	ldr r1, [r2, #0x24]
	bl DC_FlushRange
	ldr r0, _0206D38C // =wfsi_work
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x20]
	bl WFSi_ReplaceRomArchive
	ldr r1, _0206D38C // =wfsi_work
	str r0, [r5, #0xb04]
	ldr r0, [r1, #0]
	mov r2, #2
	str r2, [r0, #0xc]
	ldr r0, [r1, #0]
	ldr r1, [r0, #0x10]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, #0
	blx r1
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D294:
	mov r1, #1
	ldr r2, [r5, #0xb0c]
	mov r3, r1
	mov r0, #2
	bl WFSi_SendMessage
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	bl OS_Terminate
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D2C0:
	ldr r0, [r6, #4]
	cmp r0, #0xa
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r6, #0x14]
	mov r3, r0, lsl #0x1c
	mov r3, r3, lsr #0x1c
	cmp r3, #1
	beq _0206D2F4
	cmp r3, #3
	beq _0206D360
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D2F4:
	movs r0, r0, lsr #8
	bne _0206D310
	ldr r1, _0206D390 // =WFSi_OnChildSystemCallback
	mov r0, #1
	bl WBT_RequestSync
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D310:
	ldr r0, [r6, #0x18]
	add r4, r5, r4, lsl #2
	str r0, [r5, #0xb0c]
	ldr r0, [r1, #0]
	add r3, r5, #0x80
	ldr r2, [r0, #0x1c]
	ldr r0, _0206D390 // =WFSi_OnChildSystemCallback
	ldr r6, [r2, #0x30]
	add r2, r5, #0x40
	str r6, [r4, #0x40]
	str r3, [sp]
	str r0, [sp, #4]
	ldr r0, [r1, #0]
	ldr r1, [r5, #0xb0c]
	ldr r3, [r0, #0x1c]
	mov r0, #1
	ldr r3, [r3, #0x38]
	bl WBT_GetBlock
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D360:
	ldr r4, [r2, #0x1c]
	mov r1, #0
	ldr r0, [r4, #8]
	str r1, [r2, #0x1c]
	ldr r3, [r4, #0x2c]
	ldr r2, [r4, #0x38]
	add r2, r3, r2
	str r2, [r4, #0x2c]
	bl FS_NotifyArchiveAsyncEnd
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206D38C: .word wfsi_work
_0206D390: .word WFSi_OnChildSystemCallback
	arm_func_end WFSi_OnChildSystemCallback

	arm_func_start WFSi_InitCommon
WFSi_InitCommon: // 0x0206D394
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r5, r3
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r0, r5
	mov r1, #0x10c00
	mov r2, #0
	blx r6
	movs r4, r0
	bne _0206D3C4
	bl OS_Terminate
_0206D3C4:
	ldr r1, _0206D434 // =wfsi_work
	mvn r0, #0
	str r4, [r1]
	bl FS_Init
	mov r0, r8, lsl #0x10
	mov r0, r0, lsr #0x10
	strh r0, [r4, #0x30]
	mov r2, #0
	str r2, [r4, #4]
	str r2, [r4, #8]
	str r2, [r4, #0xc]
	str r7, [r4, #0x10]
	str r6, [r4, #0x14]
	str r5, [r4, #0x18]
	str r2, [r4, #0x1c]
	str r2, [r4, #0x24]
	str r2, [r4, #0x20]
	str r2, [r4, #0x28]
	mov r1, #0xe
	str r1, [r4, #0x2c]
	ldr r3, _0206D434 // =wfsi_work
	ldr r1, _0206D438 // =WFSi_PortCallback
	str r2, [r3, #8]
	bl WM_SetPortCallback
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	bl OS_Terminate
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0206D434: .word wfsi_work
_0206D438: .word WFSi_PortCallback
	arm_func_end WFSi_InitCommon

	arm_func_start WFS_InitParent
WFS_InitParent: // 0x0206D43C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl OS_DisableInterrupts
	ldr r9, _0206D654 // =wfsi_work
	mov r4, r0
	ldr r1, [r9, #4]
	cmp r1, #0
	bne _0206D648
	mov r10, #1
	mov r0, r8
	mov r1, r7
	mov r2, r6
	mov r3, r5
	str r10, [r9, #4]
	bl WFSi_InitCommon
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, r9
	ldr r8, [r0, #0]
	mov r3, r10
	add r9, r8, #0x440
	ldr r2, _0206D658 // =0x000107B0
	mov r0, r9
	mov r1, #0
	str r3, [r8]
	bl MI_CpuFill8
	ldr r1, _0206D658 // =0x000107B0
	mov r0, r9
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	add r10, r9, #0xc0
	add r0, r9, #0x10000
	str r10, [r0, #0x740]
	add r0, r9, #0x740
	ldr r4, _0206D65C // =0xEA0EA0EB
	mov r6, r10
	add r5, r0, #0x10000
	mov r7, #0
_0206D4E4:
	add r1, r10, #0x8c0
	add r0, r10, #0x38
	str r1, [r10]
	bl FS_InitFile
	add r0, r10, #0x8c0
	add r0, r0, #0x8c00000
	sub r1, r0, r6
	smull r0, r2, r4, r1
	str r7, [r10, #0x84]
	add r2, r1, r2
	mov r0, r1, lsr #0x1f
	str r7, [r10, #0x80]
	add r2, r0, r2, asr #11
	str r2, [r10, #0x8c]
	ldr r0, [r10, #0]
	cmp r0, r5
	strhs r7, [r10]
	bhs _0206D534
	mov r10, r0
	b _0206D4E4
_0206D534:
	add r3, r9, #0x10000
	str r7, [r3, #0x750]
	str r7, [r3, #0x74c]
	str r7, [r3, #0x754]
	str r7, [r3, #0x744]
	ldr r0, [sp, #0x28]
	str r7, [r3, #0x748]
	str r0, [r8, #0x28]
	mov r0, #1
	str r0, [r3, #0x758]
	str r7, [r3, #0x75c]
	str r7, [r3, #0x760]
	str r7, [r3, #0x768]
	str r7, [r3, #0x764]
	add r1, r9, #0x770
	ldr r4, [r8, #0x28]
	mov r0, r7
	add r1, r1, #0x10000
	mov r2, #0x40
	str r4, [r3, #0x76c]
	bl MIi_CpuClear32
	ldr r1, _0206D658 // =0x000107B0
	mov r0, r9
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	ldr r0, [r8, #0x28]
	ldr r1, [r8, #0x2c]
	ldr r2, _0206D660 // =WFSi_OnParentSystemCallback
	bl WBT_InitParent
	ldr r0, [sp, #0x2c]
	ldr r1, [sp, #0x30]
	bl WFSi_LoadTables
	add r2, r9, #0x10000
	ldr r5, [r2, #0x740]
	mov r3, #1
	ldr r1, [r5, #0]
	mov r0, r5
	str r1, [r2, #0x740]
	ldr r4, [r2, #0x744]
	mov r1, #0
	str r4, [r5]
	str r5, [r2, #0x744]
	str r3, [r5, #0x84]
	mov r2, #0x8c0
	bl MI_CpuFill8
	add r0, r5, #4
	ldr r1, _0206D654 // =wfsi_work
	mov r3, #0
	ldr r2, [r1, #0]
	mov r1, #0x20000
	ldr r4, [r2, #0x24]
	ldr r2, _0206D664 // =wfsi_def_user_data
	str r4, [sp]
	str r3, [sp, #4]
	ldr r3, [r8, #0x20]
	bl WBT_RegisterBlock
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, #1
	str r0, [r8, #0xc]
	ldr r0, [r8, #4]
	cmp r0, #0
	beq _0206D634
	bl WFS_Start
_0206D634:
	mov r0, r4
	bl OS_RestoreInterrupts
	bl WFSi_CreateTaskThread
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0206D648:
	bl OS_RestoreInterrupts
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0206D654: .word wfsi_work
_0206D658: .word 0x000107B0
_0206D65C: .word 0xEA0EA0EB
_0206D660: .word WFSi_OnParentSystemCallback
_0206D664: .word wfsi_def_user_data
	arm_func_end WFS_InitParent

	arm_func_start WFS_InitChild
WFS_InitChild: // 0x0206D668
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl OS_DisableInterrupts
	ldr ip, _0206D760 // =wfsi_work
	mov r4, r0
	ldr r1, [ip, #4]
	cmp r1, #0
	bne _0206D758
	mov lr, #1
	mov r0, r8
	mov r1, r7
	mov r2, r6
	mov r3, r5
	str lr, [ip, #4]
	bl WFSi_InitCommon
	mov r0, r4
	bl OS_RestoreInterrupts
	ldr r0, _0206D760 // =wfsi_work
	mov r2, #0
	ldr r4, [r0, #0]
	mov r1, #0xb10
	add r5, r4, #0x440
	mov r0, r5
	str r2, [r4]
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	mov r1, #0
	add r3, r5, #0xc0
	mov r2, r1
_0206D6E8:
	str r3, [r5, r1, lsl #2]
	add r0, r5, r1, lsl #2
	str r2, [r0, #0x40]
	add r1, r1, #1
	str r2, [r0, #0x80]
	cmp r1, #0x10
	add r3, r3, #0x28
	blt _0206D6E8
	str r2, [r5, #0xb00]
	str r2, [r5, #0xb08]
	mov r0, r5
	mov r1, #0xb10
	str r2, [r5, #0xb0c]
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	ldr r0, _0206D764 // =WFSi_OnChildSystemCallback
	bl WBT_InitChild
	bl OS_DisableInterrupts
	mov r1, #1
	str r1, [r4, #0xc]
	ldr r1, [r4, #4]
	mov r4, r0
	cmp r1, #0
	beq _0206D74C
	bl WFS_Start
_0206D74C:
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0206D758:
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0206D760: .word wfsi_work
_0206D764: .word WFSi_OnChildSystemCallback
	arm_func_end WFS_InitChild

	arm_func_start WFS_Start
WFS_Start: // 0x0206D768
	stmdb sp!, {r3, r4, r5, lr}
	bl OS_DisableInterrupts
	mov r4, r0
	bl WFS_GetStatus
	cmp r0, #1
	beq _0206D794
	ldr r0, _0206D808 // =wfsi_work
	mov r1, #1
	ldr r0, [r0, #0]
	str r1, [r0, #4]
	b _0206D7FC
_0206D794:
	ldr r0, _0206D808 // =wfsi_work
	mov r2, #1
	ldr r1, [r0, #0]
	str r2, [r1, #4]
	ldr r5, [r0, #0]
	ldr r1, [r5, #0]
	cmp r1, #0
	bne _0206D7D8
	add r0, r5, #0x780
	bl WM_ReadStatus
	add r0, r5, #0x840
	ldrh r0, [r0, #0xc8]
	bl WBT_SetOwnAid
	ldr r1, _0206D80C // =WFSi_OnChildSystemCallback
	mov r0, #1
	bl WBT_RequestSync
	b _0206D7F8
_0206D7D8:
	mov r1, #2
	str r1, [r5, #0xc]
	ldr r0, [r0, #0]
	ldr r1, [r0, #0x10]
	cmp r1, #0
	beq _0206D7F8
	mov r0, #0
	blx r1
_0206D7F8:
	bl WFSi_SetMPData
_0206D7FC:
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206D808: .word wfsi_work
_0206D80C: .word WFSi_OnChildSystemCallback
	arm_func_end WFS_Start

	arm_func_start WFS_End
WFS_End: // 0x0206D810
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r0, _0206D968 // =wfsi_work
	ldr r4, [r0, #0]
	bl OS_DisableInterrupts
	ldr r1, _0206D968 // =wfsi_work
	mov r5, r0
	ldr r0, [r1, #4]
	cmp r0, #0
	beq _0206D95C
	ldr r7, [r4, #0x20]
	cmp r7, #0
	beq _0206D87C
	beq _0206D870
	bl OS_DisableInterrupts
	ldr r1, _0206D968 // =wfsi_work
	mov r6, r0
	ldr r1, [r1, #0]
	mov r2, r7
	ldr r0, [r1, #0x18]
	ldr r3, [r1, #0x14]
	mov r1, #0
	blx r3
	mov r0, r6
	bl OS_RestoreInterrupts
_0206D870:
	mov r0, #0
	str r0, [r4, #0x20]
	str r0, [r4, #0x24]
_0206D87C:
	mov r2, #0
	ldr r0, _0206D968 // =wfsi_work
	str r2, [r4, #0xc]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0206D8F0
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	beq _0206D8B4
	ldr r0, [r0, #8]
	mov r1, #5
	str r2, [r4, #0x1c]
	bl FS_NotifyArchiveAsyncEnd
_0206D8B4:
	ldr r6, [r4, #0xf40]
	cmp r6, #0
	beq _0206D8F4
	bl OS_DisableInterrupts
	ldr r1, _0206D968 // =wfsi_work
	mov r4, r0
	ldr r1, [r1, #0]
	mov r2, r6
	ldr r0, [r1, #0x18]
	ldr r3, [r1, #0x14]
	mov r1, #0
	blx r3
	mov r0, r4
	bl OS_RestoreInterrupts
	b _0206D8F4
_0206D8F0:
	bl WFSi_EndTaskThread
_0206D8F4:
	bl WBT_End
	ldr r0, _0206D968 // =wfsi_work
	mov r1, #0
	ldr r0, [r0, #0]
	mov r2, r1
	ldrh r0, [r0, #0x30]
	bl WM_SetPortCallback
	ldr r0, _0206D968 // =wfsi_work
	ldr r6, [r0, #0]
	cmp r6, #0
	beq _0206D94C
	bl OS_DisableInterrupts
	ldr r1, _0206D968 // =wfsi_work
	mov r4, r0
	ldr r1, [r1, #0]
	mov r2, r6
	ldr r0, [r1, #0x18]
	ldr r3, [r1, #0x14]
	mov r1, #0
	blx r3
	mov r0, r4
	bl OS_RestoreInterrupts
_0206D94C:
	ldr r0, _0206D968 // =wfsi_work
	mov r1, #0
	str r1, [r0]
	str r1, [r0, #4]
_0206D95C:
	mov r0, r5
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206D968: .word wfsi_work
	arm_func_end WFS_End

	arm_func_start WFS_GetStatus
WFS_GetStatus: // 0x0206D96C
	ldr r0, _0206D984 // =wfsi_work
	ldr r0, [r0, #0]
	cmp r0, #0
	ldrne r0, [r0, #0xc]
	moveq r0, #0
	bx lr
	.align 2, 0
_0206D984: .word wfsi_work
	arm_func_end WFS_GetStatus

	arm_func_start WFS_GetBusyBitmap
WFS_GetBusyBitmap: // 0x0206D988
	ldr r0, _0206D9B0 // =wfsi_work
	ldr r1, [r0, #4]
	cmp r1, #0
	ldrne r1, [r0, #0]
	ldrne r0, [r1, #0]
	cmpne r0, #0
	moveq r0, #0
	addne r0, r1, #0x10000
	ldrne r0, [r0, #0xb98]
	bx lr
	.align 2, 0
_0206D9B0: .word wfsi_work
	arm_func_end WFS_GetBusyBitmap

	arm_func_start WFS_Func_206D9B4
WFS_Func_206D9B4: // 0x0206D9B4
	stmdb sp!, {r4, lr}
	ldr r0, _0206DA24 // =wfsi_work
	mvn r4, #0
	ldr r1, [r0, #4]
	cmp r1, #0
	ldrne r0, [r0, #0]
	ldrne r0, [r0, #0]
	cmpne r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	bl WFS_GetBusyBitmap
	ldr r1, _0206DA24 // =wfsi_work
	mov ip, #1
	mov r3, ip
	ldr r2, [r1, #0]
	b _0206DA14
_0206D9F4:
	tst r0, r3, lsl ip
	beq _0206DA10
	add r1, r2, ip, lsl #2
	add r1, r1, #0x10000
	ldr r1, [r1, #0xbb0]
	cmp r4, r1
	movhi r4, r1
_0206DA10:
	add ip, ip, #1
_0206DA14:
	cmp ip, #0x10
	blt _0206D9F4
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206DA24: .word wfsi_work
	arm_func_end WFS_Func_206D9B4

	arm_func_start WFS_EnableSync
WFS_EnableSync: // 0x0206DA28
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, _0206DA50 // =wfsi_work
	bic r2, r4, #1
	ldr r1, [r1, #0]
	add r1, r1, #0x10000
	str r2, [r1, #0xb90]
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206DA50: .word wfsi_work
	arm_func_end WFS_EnableSync

	arm_func_start WFS_SetDebugMode
WFS_SetDebugMode: // 0x0206DA54
	ldr r1, _0206DA60 // =wfsi_work
	str r0, [r1, #8]
	bx lr
	.align 2, 0
_0206DA60: .word wfsi_work
	arm_func_end WFS_SetDebugMode

	arm_func_start WFSi_NotifyBusy
WFSi_NotifyBusy: // 0x0206DA64
	ldr ip, _0206DA70 // =OS_WakeupThreadDirect
	ldr r0, _0206DA74 // =wfsi_task+0x00000400
	bx ip
	.align 2, 0
_0206DA70: .word OS_WakeupThreadDirect
_0206DA74: .word wfsi_task+0x00000400
	arm_func_end WFSi_NotifyBusy

	arm_func_start WFSi_TaskThread
WFSi_TaskThread: // 0x0206DA78
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r0, _0206DBA0 // =wfsi_work
	ldr r0, [r0, #0]
	add r4, r0, #0x440
_0206DA88:
	bl OS_DisableInterrupts
	add r7, r4, #0x10000
	ldr r5, [r7, #0x748]
	mov r6, r0
	cmp r5, #0
	bne _0206DAD8
	ldr r8, _0206DBA0 // =wfsi_work
	mov r9, #0
_0206DAA8:
	ldr r0, [r8, #0]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _0206DAC4
	mov r0, r6
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0206DAC4:
	mov r0, r9
	bl OS_SleepThread
	ldr r5, [r7, #0x748]
	cmp r5, #0
	beq _0206DAA8
_0206DAD8:
	mov r0, r6
	bl OS_RestoreInterrupts
	ldr r0, [r5, #0x80]
	cmp r0, #1
	bne _0206DB74
	ldr r1, [r5, #0x90]
	ldr r2, [r5, #0x94]
	add r0, r5, #0x38
	bl FS_CreateFileFromRom
	mov r7, #0
	mov r8, r7
	add r9, r5, #0xc0
	mov r6, #0x400
_0206DB0C:
	add r3, r5, r7, lsl #2
	mov r1, r9
	mov r2, r6
	add r0, r5, #0x38
	str r8, [r3, #0xa4]
	bl FS_ReadFile
	add r7, r7, #1
	cmp r7, #2
	add r8, r8, #0x400
	add r9, r9, #0x400
	blt _0206DB0C
	mov r0, #0
	str r0, [r5, #0x98]
	mov r0, #1
	str r0, [r5, #0xa0]
	mov r0, #2
	str r0, [r5, #0x9c]
	bl OS_DisableInterrupts
	mov r6, r0
	mov r0, r4
	mov r1, r5
	mov r2, #1
	bl WFSi_SendOpenAck
	mov r0, r6
	bl OS_RestoreInterrupts
	b _0206DA88
_0206DB74:
	add r0, r5, #0x38
	bl FS_CloseFile
	bl OS_DisableInterrupts
	mov r6, r0
	mov r0, r4
	mov r1, r5
	bl WFSi_FromBusyToFree
	mov r0, r6
	bl OS_RestoreInterrupts
	b _0206DA88
	arm_func_end WFSi_TaskThread

	arm_func_start sub_206DB9C
sub_206DB9C: // 0x0206DB9C
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0206DBA0: .word wfsi_work
	arm_func_end sub_206DB9C

	arm_func_start WFSi_CreateTaskThread
WFSi_CreateTaskThread: // 0x0206DBA4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, _0206DBF0 // =wfsi_task
	mov r0, #0
	str r0, [r4, #0x4c4]
	str r0, [r4, #0x4c0]
	mov r0, #0x400
	str r0, [sp]
	add r0, r4, #0x400
	mov ip, #0xf
	ldr r1, _0206DBF4 // =WFSi_TaskThread
	mov r2, r4
	mov r3, r0
	str ip, [sp, #4]
	bl OS_CreateThread
	add r0, r4, #0x400
	bl OS_WakeupThreadDirect
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206DBF0: .word wfsi_task
_0206DBF4: .word WFSi_TaskThread
	arm_func_end WFSi_CreateTaskThread

	arm_func_start WFSi_EndTaskThread
WFSi_EndTaskThread: // 0x0206DBF8
	stmdb sp!, {r4, lr}
	ldr r4, _0206DC28 // =wfsi_task
	b _0206DC14
_0206DC04:
	add r0, r4, #0x400
	bl OS_WakeupThreadDirect
	add r0, r4, #0x400
	bl OS_JoinThread
_0206DC14:
	add r0, r4, #0x400
	bl OS_IsThreadTerminated
	cmp r0, #0
	beq _0206DC04
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206DC28: .word wfsi_task
	arm_func_end WFSi_EndTaskThread

	.rodata

.public wfsi_def_user_data
wfsi_def_user_data: // 0x021116C8
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	.data

aRom: // 0x0211AA30
	.asciz "rom"
	.align 4
