	.include "asm/macros.inc"
	.include "global.inc"

	.public fsi_def_digest_key

	.text

	arm_func_start FS_UnloadOverlay
FS_UnloadOverlay: // 0x020EBC04
	stmdb sp!, {lr}
	sub sp, sp, #0x2c
	mov r3, r0
	mov r2, r1
	add r0, sp, #0
	mov r1, r3
	bl FS_LoadOverlayInfo
	cmp r0, #0
	beq _020EBC38
	add r0, sp, #0
	bl FS_UnloadOverlayImage
	cmp r0, #0
	bne _020EBC48
_020EBC38:
	add sp, sp, #0x2c
	mov r0, #0
	ldmia sp!, {lr}
	bx lr
_020EBC48:
	mov r0, #1
	add sp, sp, #0x2c
	ldmia sp!, {lr}
	bx lr
	arm_func_end FS_UnloadOverlay

	arm_func_start FS_LoadOverlay
FS_LoadOverlay: // 0x020EBC58
	stmdb sp!, {lr}
	sub sp, sp, #0x2c
	mov r3, r0
	mov r2, r1
	add r0, sp, #0
	mov r1, r3
	bl FS_LoadOverlayInfo
	cmp r0, #0
	beq _020EBC8C
	add r0, sp, #0
	bl FS_LoadOverlayImageAsync
	cmp r0, #0
	bne _020EBC9C
_020EBC8C:
	add sp, sp, #0x2c
	mov r0, #0
	ldmia sp!, {lr}
	bx lr
_020EBC9C:
	add r0, sp, #0
	bl FS_StartOverlay
	mov r0, #1
	add sp, sp, #0x2c
	ldmia sp!, {lr}
	bx lr
	arm_func_end FS_LoadOverlay

	arm_func_start FS_UnloadOverlayImage
FS_UnloadOverlayImage: // 0x020EBCB4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl FS_EndOverlay
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end FS_UnloadOverlayImage

	arm_func_start FS_EndOverlay
FS_EndOverlay: // 0x020EBCD0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r8, _020EBDD0 // =0x02152940
	mov r11, r0
	mov r9, #0
_020EBCE4:
	ldr r1, [r11, #8]
	ldr r0, [r11, #0xc]
	ldr r5, [r11, #4]
	add r0, r1, r0
	mov r7, r9
	mov r6, r9
	add r4, r5, r0
	bl OS_DisableInterrupts
	ldr lr, [r8]
	mov r10, r9
	mov ip, lr
	cmp lr, #0
	beq _020EBD88
_020EBD18:
	ldr r2, [ip, #8]
	ldr r3, [ip]
	cmp r2, #0
	ldr r1, [ip, #4]
	bne _020EBD3C
	cmp r1, r5
	blo _020EBD3C
	cmp r1, r4
	blo _020EBD4C
_020EBD3C:
	cmp r2, r5
	blo _020EBD78
	cmp r2, r4
	bhs _020EBD78
_020EBD4C:
	cmp r6, #0
	strne ip, [r6]
	moveq r7, ip
	cmp lr, ip
	streq r3, [r8]
	moveq lr, r3
	str r9, [ip]
	cmp r10, #0
	mov r6, ip
	strne r3, [r10]
	b _020EBD7C
_020EBD78:
	mov r10, ip
_020EBD7C:
	mov ip, r3
	cmp r3, #0
	bne _020EBD18
_020EBD88:
	bl OS_RestoreInterrupts
	cmp r7, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
_020EBD9C:
	ldr r1, [r7, #4]
	ldr r4, [r7]
	cmp r1, #0
	beq _020EBDB4
	ldr r0, [r7, #8]
	blx r1
_020EBDB4:
	mov r7, r4
	cmp r4, #0
	bne _020EBD9C
	b _020EBCE4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020EBDD0: .word 0x02152940
	arm_func_end FS_EndOverlay

	arm_func_start FS_StartOverlay
FS_StartOverlay: // 0x020EBDD4
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	bl FSi_GetOverlayBinarySize
	ldr r1, _020EBEC4 // =0x027FFC40
	mov r4, r0
	ldrh r0, [r1]
	cmp r0, #2
	bne _020EBE68
	ldrb r1, [r5, #0x1f]
	mov r0, #0
	ands r1, r1, #2
	beq _020EBE44
	ldr r1, _020EBEC8 // =0x2132A34
	ldr r3, _020EBECC // =0x2132A34
	ldr r2, _020EBED0 // =0x66666667
	sub ip, r1, r3
	smull r1, lr, r2, ip
	mov lr, lr, asr #3
	mov r1, ip, lsr #0x1f
	ldr r2, [r5]
	add lr, r1, lr
	cmp r2, lr
	bhs _020EBE44
	mov r0, #0x14
	mla r0, r2, r0, r3
	ldr r1, [r5, #4]
	mov r2, r4
	bl FSi_CompareDigest
_020EBE44:
	cmp r0, #0
	bne _020EBE68
	ldr r0, [r5, #4]
	mov r2, r4
	mov r1, #0
	bl MI_CpuFill8
	bl OS_Terminate
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020EBE68:
	ldrb r0, [r5, #0x1f]
	ands r0, r0, #1
	beq _020EBE80
	ldr r0, [r5, #4]
	add r0, r0, r4
	bl MIi_UncompressBackward
_020EBE80:
	ldr r0, [r5, #4]
	ldr r1, [r5, #8]
	bl DC_FlushRange
	ldr r6, [r5, #0x10]
	ldr r4, [r5, #0x14]
	cmp r6, r4
	ldmhsia sp!, {r4, r5, r6, lr}
	bxhs lr
_020EBEA0:
	ldr r0, [r6]
	cmp r0, #0
	beq _020EBEB0
	blx r0
_020EBEB0:
	add r6, r6, #4
	cmp r6, r4
	blo _020EBEA0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020EBEC4: .word 0x027FFC40
_020EBEC8: .word 0x2132A34 // TODO: this should be "(SDK_OVERLAY_DIGEST_END - SDK_OVERLAY_DIGEST) / FS_OVERLAY_DIGEST_SIZE"
_020EBECC: .word 0x2132A34 // TODO: this should be "(SDK_OVERLAY_DIGEST_END - SDK_OVERLAY_DIGEST) / FS_OVERLAY_DIGEST_SIZE"
_020EBED0: .word 0x66666667
	arm_func_end FS_StartOverlay

	arm_func_start FSi_CompareDigest
FSi_CompareDigest: // 0x020EBED4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x58
	mov r4, r0
	mov r6, r1
	mov r5, r2
	add r0, sp, #4
	mov r1, #0
	mov r2, #0x14
	bl MI_CpuFill8
	ldr r0, _020EBF70 // =fsi_digest_key_ptr
	ldr r1, _020EBF74 // =fsi_digest_key_len
	ldr r0, [r0]
	ldr r2, [r1]
	add r1, sp, #0x18
	bl MI_CpuCopy8
	ldr r3, _020EBF74 // =fsi_digest_key_len
	mov r1, r6
	ldr ip, [r3]
	mov r2, r5
	add r0, sp, #4
	add r3, sp, #0x18
	str ip, [sp]
	bl DGT_Hash2CalcHmac
	add r2, sp, #4
	mov r3, #0
_020EBF38:
	ldr r1, [r2]
	ldr r0, [r4, r3]
	cmp r1, r0
	bne _020EBF58
	add r3, r3, #4
	cmp r3, #0x14
	add r2, r2, #4
	blo _020EBF38
_020EBF58:
	cmp r3, #0x14
	moveq r0, #1
	movne r0, #0
	add sp, sp, #0x58
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020EBF70: .word fsi_digest_key_ptr
_020EBF74: .word fsi_digest_key_len
	arm_func_end FSi_CompareDigest

	arm_func_start FS_LoadOverlayImageAsync
FS_LoadOverlayImageAsync: // 0x020EBF78
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x54
	mov r5, r0
	add r0, sp, #8
	bl FS_InitFile
	add r0, sp, #0
	mov r1, r5
	bl FS_GetOverlayFileID
	add r1, sp, #0
	add r0, sp, #8
	ldmia r1, {r1, r2}
	bl FS_OpenFileFast
	cmp r0, #0
	addeq sp, sp, #0x54
	moveq r0, #0
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	mov r0, r5
	bl FSi_GetOverlayBinarySize
	mov r4, r0
	mov r0, r5
	bl FS_ClearOverlayImage
	ldr r1, [r5, #4]
	add r0, sp, #8
	mov r2, r4
	bl FS_ReadFile
	cmp r4, r0
	beq _020EC000
	add r0, sp, #8
	bl FS_CloseFile
	add sp, sp, #0x54
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020EC000:
	add r0, sp, #8
	bl FS_CloseFile
	mov r0, #1
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end FS_LoadOverlayImageAsync

	arm_func_start FS_LoadOverlayInfo
FS_LoadOverlayInfo: // 0x020EC018
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x64
	movs r4, r1
	mov r5, r0
	ldreq r0, _020EC118 // =fsi_ovt9
	ldrne r0, _020EC11C // =fsi_ovt7
	ldr r3, [r0]
	cmp r3, #0
	beq _020EC0D4
	ldr r0, [r0, #4]
	mov r2, r2, lsl #5
	cmp r2, r0
	addhs sp, sp, #0x64
	movhs r0, #0
	ldmhsia sp!, {r4, r5, lr}
	bxhs lr
	add r0, r3, r2
	mov r1, r5
	mov r2, #0x20
	bl MI_CpuCopy8
	add r0, sp, #0x18
	str r4, [r5, #0x20]
	bl FS_InitFile
	add r0, sp, #0x10
	mov r1, r5
	bl FS_GetOverlayFileID
	add r1, sp, #0x10
	add r0, sp, #0x18
	ldmia r1, {r1, r2}
	bl FS_OpenFileFast
	cmp r0, #0
	addeq sp, sp, #0x64
	moveq r0, #0
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r1, [sp, #0x3c]
	add r0, sp, #0x18
	str r1, [r5, #0x24]
	ldr r2, [sp, #0x40]
	ldr r1, [sp, #0x3c]
	sub r1, r2, r1
	str r1, [r5, #0x28]
	bl FS_CloseFile
	add sp, sp, #0x64
	mov r0, #1
	ldmia sp!, {r4, r5, lr}
	bx lr
_020EC0D4:
	ldr r1, _020EC120 // =0x027FFE50
	ldr ip, _020EC124 // =0x027FFE58
	ldr r0, [r1]
	ldr r3, _020EC128 // =fs_rom_archive
	str r0, [sp]
	ldr r1, [r1, #4]
	mov r0, r5
	str r1, [sp, #4]
	ldr r5, [ip]
	mov r1, r4
	str r5, [sp, #8]
	ldr r4, [ip, #4]
	str r4, [sp, #0xc]
	bl FSi_LoadOverlayInfoCore
	add sp, sp, #0x64
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020EC118: .word fsi_ovt9
_020EC11C: .word fsi_ovt7
_020EC120: .word 0x027FFE50
_020EC124: .word 0x027FFE58
_020EC128: .word fs_rom_archive
	arm_func_end FS_LoadOverlayInfo

	arm_func_start FSi_LoadOverlayInfoCore
FSi_LoadOverlayInfoCore: // 0x020EC12C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x54
	movs r9, r1
	ldreq r5, [sp, #0x74]
	ldreq r6, [sp, #0x70]
	ldrne r5, [sp, #0x7c]
	ldrne r6, [sp, #0x78]
	mov r7, r2, lsl #5
	cmp r7, r5
	mov r4, r0
	mov r8, r3
	addhs sp, sp, #0x54
	movhs r0, #0
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxhs lr
	add r0, sp, #0xc
	bl FS_InitFile
	mvn ip, #0
	add r0, sp, #0xc
	mov r1, r8
	add r2, r6, r7
	add r3, r6, r5
	str ip, [sp]
	bl FS_OpenFileDirect
	cmp r0, #0
	addeq sp, sp, #0x54
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	add r0, sp, #0xc
	mov r1, r4
	mov r2, #0x20
	bl FS_ReadFile
	cmp r0, #0x20
	beq _020EC1D0
	add r0, sp, #0xc
	bl FS_CloseFile
	add sp, sp, #0x54
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020EC1D0:
	add r0, sp, #0xc
	bl FS_CloseFile
	add r0, sp, #4
	mov r1, r4
	str r9, [r4, #0x20]
	bl FS_GetOverlayFileID
	add r1, sp, #4
	add r0, sp, #0xc
	ldmia r1, {r1, r2}
	bl FS_OpenFileFast
	cmp r0, #0
	addeq sp, sp, #0x54
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	ldr r1, [sp, #0x30]
	add r0, sp, #0xc
	str r1, [r4, #0x24]
	ldr r2, [sp, #0x34]
	ldr r1, [sp, #0x30]
	sub r1, r2, r1
	str r1, [r4, #0x28]
	bl FS_CloseFile
	mov r0, #1
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end FSi_LoadOverlayInfoCore

	arm_func_start FS_GetOverlayFileID
FS_GetOverlayFileID: // 0x020EC23C
	sub sp, sp, #8
	ldr r2, _020EC260 // =fs_rom_archive
	str r2, [sp]
	ldr r1, [r1, #0x18]
	str r1, [sp, #4]
	str r2, [r0]
	str r1, [r0, #4]
	add sp, sp, #8
	bx lr
	.align 2, 0
_020EC260: .word fs_rom_archive
	arm_func_end FS_GetOverlayFileID

	arm_func_start FS_ClearOverlayImage
FS_ClearOverlayImage: // 0x020EC264
	stmdb sp!, {r4, r5, r6, lr}
	ldr r5, [r0, #8]
	ldr r1, [r0, #0xc]
	ldr r6, [r0, #4]
	add r4, r5, r1
	mov r0, r6
	mov r1, r4
	bl IC_InvalidateRange
	mov r0, r6
	mov r1, r4
	bl DC_InvalidateRange
	add r0, r6, r5
	sub r2, r4, r5
	mov r1, #0
	bl MI_CpuFill8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end FS_ClearOverlayImage

	arm_func_start FSi_GetOverlayBinarySize
FSi_GetOverlayBinarySize: // 0x020EC2A8
	ldrb r1, [r0, #0x1f]
	ands r1, r1, #1
	ldrne r0, [r0, #0x1c]
	movne r0, r0, lsl #8
	movne r0, r0, lsr #8
	ldreq r0, [r0, #8]
	bx lr
	arm_func_end FSi_GetOverlayBinarySize

	.rodata
	
.public fsi_def_digest_key
fsi_def_digest_key: // 0x02116FC0
	.byte 0x21, 0x06, 0xC0, 0xDE, 0xBA, 0x98, 0xCE, 0x3F, 0xA6, 0x92, 0xE3, 0x9D, 0x46, 0xF2, 0xED, 0x01
	.byte 0x76, 0xE3, 0xCC, 0x08, 0x56, 0x23, 0x63, 0xFA, 0xCA, 0xD4, 0xEC, 0xDF, 0x9A, 0x62, 0x78, 0x34
	.byte 0x8F, 0x6D, 0x63, 0x3C, 0xFE, 0x22, 0xCA, 0x92, 0x20, 0x88, 0x97, 0x23, 0xD2, 0xCF, 0xAE, 0xC2
	.byte 0x32, 0x67, 0x8D, 0xFE, 0xCA, 0x83, 0x64, 0x98, 0xAC, 0xFD, 0x3E, 0x37, 0x87, 0x46, 0x58, 0x24

	.data

fsi_digest_key_ptr: // 0x0211F798
    .word fsi_def_digest_key
	
fsi_digest_key_len: // 0x0211F79C
    .word 0x40