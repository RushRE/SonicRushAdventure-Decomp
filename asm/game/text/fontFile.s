	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FontFile__Init
FontFile__Init: // 0x020521BC
	mov r1, #5
	str r1, [r0]
	mov r2, #0
	str r2, [r0, #0x54]
	str r2, [r0, #0x58]
	str r2, [r0, #0x5c]
	ldr r1, _02052218 // =0x0000FFFF
	str r2, [r0, #0x60]
	strh r1, [r0, #0x64]
	strh r1, [r0, #0x66]
	strh r1, [r0, #0x68]
	strh r1, [r0, #0x6a]
	str r2, [r0, #0x6c]
	str r2, [r0, #0x70]
	str r2, [r0, #0x74]
	str r2, [r0, #0x78]
	str r2, [r0, #0x7c]
	str r2, [r0, #0x80]
	str r2, [r0, #0x84]
	str r2, [r0, #0x88]
	ldr ip, _0205221C // =FS_InitFile
	add r0, r0, #0xc
	bx ip
	.align 2, 0
_02052218: .word 0x0000FFFF
_0205221C: .word FS_InitFile
	arm_func_end FontFile__Init

	arm_func_start FontFile__InitFromPath
FontFile__InitFromPath: // 0x02052220
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x24
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl FontFile__Release
	mov r1, r5
	str r4, [r6]
	mov r2, #0
	add r0, r6, #4
	str r2, [r6, #0x88]
	bl FS_ConvertPathToFileID
	add r2, sp, #0
	add r0, r6, #0xc
	add r1, r6, #4
	bl FontFile__GetFileSizeFromID
	add r1, sp, #4
	add r0, r6, #0xc
	bl FontFile__ReadHeaderFromFile
	add r0, sp, #4
	mov r1, r4
	bl FontFile__GetFileSize
	str r0, [r6, #0x80]
	cmp r4, #3
	ldr r0, [r6, #0x80]
	blt _02052290
	bl _AllocHeadHEAP_SYSTEM
	b _02052294
_02052290:
	bl _AllocHeadHEAP_USER
_02052294:
	str r0, [r6, #0x84]
	ldr r1, [r6, #0x84]
	ldr r2, [r6, #0x80]
	mov r0, #0
	bl MIi_CpuClearFast
	add r1, sp, #4
	mov r0, r6
	bl FontFile__Func_2052A2C
	ldr r1, [r6, #0x54]
	add r0, sp, #4
	mov r2, #0x20
	bl MIi_CpuCopyFast
	mov r0, r6
	bl FontFile__LoadXAdvanceBlock
	mov r0, r6
	bl FontFile__LoadBlock3
	mov r0, r6
	bl FontFile__LoadCharDataBlock
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end FontFile__InitFromPath

	arm_func_start FontFile__InitFromHeader
FontFile__InitFromHeader: // 0x020522E4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl FontFile__Release
	mov r0, #1
	str r0, [r5]
	str r4, [r5, #0x88]
	add r0, r5, #0xc
	bl FS_InitFile
	ldr r1, [r4, #0xc]
	mov r0, #0
	cmp r1, #0
	beq _02052334
	ldrb r2, [r4, #4]
	ldrb r1, [r4, #5]
	smulbb r1, r2, r1
	add r1, r1, r1, lsr #31
	add r0, r0, r1, asr #1
	add r0, r0, #0x1f
	bic r0, r0, #0x1f
_02052334:
	str r0, [r5, #0x80]
	bl _AllocHeadHEAP_USER
	str r0, [r5, #0x84]
	mov r1, r0
	ldr r2, [r5, #0x80]
	mov r0, #0
	bl MIi_CpuClearFast
	str r4, [r5, #0x54]
	mov r1, #0
	str r1, [r5, #0x5c]
	str r1, [r5, #0x60]
	str r1, [r5, #0x58]
	str r1, [r5, #0x6c]
	ldr r0, [r5, #0x84]
	str r0, [r5, #0x70]
	str r1, [r5, #0x7c]
	ldr r0, [r4, #0x10]
	cmp r0, #0
	addne r0, r4, r0
	strne r0, [r5, #0x5c]
	ldr r0, [r4, #0x14]
	cmp r0, #0
	addne r0, r4, r0
	strne r0, [r5, #0x60]
	ldr r0, [r4, #0xc]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r4, r0
	str r0, [r5, #0x58]
	ldr r0, [r4, #0x18]
	add r0, r4, r0
	str r0, [r5, #0x7c]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end FontFile__InitFromHeader

	arm_func_start FontFile__Release
FontFile__Release: // 0x020523B8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x18]
	tst r0, #0x10
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	beq _020523E0
	add r0, r4, #0xc
	bl FS_CloseFile
_020523E0:
	ldr r0, [r4, #0x84]
	cmp r0, #0
	beq _0205240C
	ldr r1, [r4, #0]
	cmp r1, #3
	blt _02052400
	bl _FreeHEAP_SYSTEM
	b _02052404
_02052400:
	bl _FreeHEAP_USER
_02052404:
	mov r0, #0
	str r0, [r4, #0x84]
_0205240C:
	mov r0, #5
	str r0, [r4]
	mov r1, #0
	str r1, [r4, #0x54]
	str r1, [r4, #0x58]
	str r1, [r4, #0x5c]
	ldr r0, _0205245C // =0x0000FFFF
	str r1, [r4, #0x60]
	strh r0, [r4, #0x64]
	strh r0, [r4, #0x66]
	strh r0, [r4, #0x68]
	strh r0, [r4, #0x6a]
	str r1, [r4, #0x6c]
	str r1, [r4, #0x70]
	str r1, [r4, #0x74]
	str r1, [r4, #0x78]
	str r1, [r4, #0x7c]
	str r1, [r4, #0x80]
	str r1, [r4, #0x84]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0205245C: .word 0x0000FFFF
	arm_func_end FontFile__Release

	arm_func_start FontFile__GetPixelWidth
FontFile__GetPixelWidth: // 0x02052460
	ldr r0, [r0, #0x54]
	ldrb r0, [r0, #4]
	bx lr
	arm_func_end FontFile__GetPixelWidth

	arm_func_start FontFile__GetPixelHeight
FontFile__GetPixelHeight: // 0x0205246C
	ldr r0, [r0, #0x54]
	ldrb r0, [r0, #5]
	bx lr
	arm_func_end FontFile__GetPixelHeight

	arm_func_start FontFile__GetPixelWidth2
FontFile__GetPixelWidth2: // 0x02052478
	ldr r0, [r0, #0x54]
	ldrb r0, [r0, #4]
	mov r0, r0, lsl #0xd
	mov r0, r0, lsr #0x10
	bx lr
	arm_func_end FontFile__GetPixelWidth2

	arm_func_start FontFile__GetPixels
FontFile__GetPixels: // 0x0205248C
	stmdb sp!, {r3, lr}
	ldr r2, [r0, #0]
	cmp r2, #3
	addls pc, pc, r2, lsl #2
	b _020524C8
_020524A0: // jump table
	b _020524B0 // case 0
	b _020524B8 // case 1
	b _020524C0 // case 2
	b _020524B0 // case 3
_020524B0:
	bl FontFile__GetPixels0
	ldmia sp!, {r3, pc}
_020524B8:
	bl FontFile__GetPixels1
	ldmia sp!, {r3, pc}
_020524C0:
	bl FontFile__GetPixels2
	ldmia sp!, {r3, pc}
_020524C8:
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end FontFile__GetPixels

	arm_func_start FontFile__GetCharXAdvance
FontFile__GetCharXAdvance: // 0x020524D0
	ldr r2, [r0, #0x5c]
	cmp r2, #0
	ldreq r0, [r0, #0x54]
	ldreqb r0, [r0, #4]
	ldrneb r0, [r2, r1]
	bx lr
	arm_func_end FontFile__GetCharXAdvance

	arm_func_start FontFile__ReadCharBlock
FontFile__ReadCharBlock: // 0x020524E8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r4, [r0, #0x58]
	mov r7, r1
	add r0, r4, r7, lsl #3
	mov r6, r2
	ldr r1, [r0, #4]
	mov r0, r6
	mov r2, #0
	mov r5, r3
	bl FS_SeekFile
	add r0, r4, r7, lsl #3
	ldrh r2, [r0, #2]
	mov r0, r6
	mov r1, r5
	bl FS_ReadFile
	add r0, r4, r7, lsl #3
	ldrh r1, [r0, #2]
	mov r0, r5
	bl DC_StoreRange
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end FontFile__ReadCharBlock

	arm_func_start FontFile__GetPixels0
FontFile__GetPixels0: // 0x02052538
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	mov r6, r1
	ldr r1, [r7, #0x78]
	ldr r2, [r7, #0x54]
	cmp r1, #0
	addne r4, r7, #0x6a
	addeq r4, r7, #0x66
	movne r5, r1
	ldrh r0, [r4, #0]
	ldreq r5, [r7, #0x70]
	cmp r0, r6
	moveq r0, r5
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r1, #0
	beq _020525A4
	ldrh r0, [r7, #0x66]
	cmp r0, r6
	bne _020525A4
	ldrb r3, [r2, #4]
	ldrb r2, [r2, #5]
	ldr r0, [r7, #0x70]
	smulbb r2, r3, r2
	mov r2, r2, asr #1
	bl MIi_CpuCopyFast
	mov r0, r5
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_020525A4:
	ldr r0, [r7, #0x74]
	cmp r0, #0
	beq _020525BC
	ldrh r1, [r7, #0x68]
	cmp r1, r6
	beq _020525E8
_020525BC:
	ldrh r0, [r7, #0x64]
	cmp r0, r6
	ldreq r0, [r7, #0x6c]
	beq _020525E8
	ldr r3, [r7, #0x6c]
	mov r0, r7
	mov r1, r6
	add r2, r7, #0xc
	bl FontFile__ReadCharBlock
	strh r6, [r7, #0x64]
	ldr r0, [r7, #0x6c]
_020525E8:
	mov r1, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	strh r6, [r4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end FontFile__GetPixels0

	arm_func_start FontFile__GetPixels1
FontFile__GetPixels1: // 0x020525FC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	ldr r1, [r0, #0x78]
	ldr ip, [r0, #0x54]
	cmp r1, #0
	addne r4, r0, #0x6a
	addeq r4, r0, #0x66
	movne r5, r1
	ldrh r2, [r4, #0]
	ldreq r5, [r0, #0x70]
	cmp r2, r6
	moveq r0, r5
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r1, #0
	beq _02052664
	ldrh r2, [r0, #0x66]
	cmp r2, r6
	bne _02052664
	ldrb r3, [ip, #4]
	ldrb r2, [ip, #5]
	ldr r0, [r0, #0x70]
	smulbb r2, r3, r2
	mov r2, r2, asr #1
	bl MIi_CpuCopyFast
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
_02052664:
	ldr r2, [r0, #0x58]
	ldr r1, [ip, #0x18]
	add r2, r2, r6, lsl #3
	ldr r2, [r2, #4]
	ldr r3, [r0, #0x7c]
	sub r0, r2, r1
	mov r1, r5
	add r0, r3, r0
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	strh r6, [r4]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end FontFile__GetPixels1

	arm_func_start FontFile__GetPixels2
FontFile__GetPixels2: // 0x02052694
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x54]
	mov r4, r1
	ldrb r2, [r0, #4]
	ldrb r0, [r0, #5]
	ldr r1, [r5, #0x78]
	ldr ip, [r5, #0x7c]
	smulbb r0, r2, r0
	mov r2, r0, asr #1
	mul r3, r2, r4
	cmp r1, #0
	beq _020526E8
	ldrh r0, [r5, #0x6a]
	cmp r0, r4
	beq _020526E0
	add r0, ip, r3
	bl MIi_CpuCopyFast
	strh r4, [r5, #0x6a]
_020526E0:
	ldr r0, [r5, #0x78]
	ldmia sp!, {r3, r4, r5, pc}
_020526E8:
	add r0, ip, r3
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end FontFile__GetPixels2

	arm_func_start FontFile__GetFileSizeFromID
FontFile__GetFileSizeFromID: // 0x020526F0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl FS_InitFile
	mov r0, r6
	ldmia r5, {r1, r2}
	bl FS_OpenFileFast
	cmp r4, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #0x28]
	ldr r0, [r6, #0x24]
	sub r0, r1, r0
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end FontFile__GetFileSizeFromID

	arm_func_start FontFile__ReadHeaderFromFile
FontFile__ReadHeaderFromFile: // 0x0205272C
	stmdb sp!, {r4, lr}
	mov r4, r1
	mov r2, #0x20
	bl FS_ReadFile
	mov r0, r4
	mov r1, #0x20
	bl DC_StoreRange
	ldmia sp!, {r4, pc}
	arm_func_end FontFile__ReadHeaderFromFile

	arm_func_start FontFile__LoadXAdvanceBlock
FontFile__LoadXAdvanceBlock: // 0x0205274C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x54]
	ldrh r0, [r4, #6]
	cmp r0, #0
	ldrne r1, [r4, #0x10]
	cmpne r1, #0
	ldrne r0, [r5, #0x5c]
	cmpne r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r5, #0xc
	mov r2, #0
	bl FS_SeekFile
	ldrh r2, [r4, #6]
	ldr r1, [r5, #0x5c]
	add r0, r5, #0xc
	bl FS_ReadFile
	ldrh r1, [r4, #6]
	ldr r0, [r5, #0x5c]
	bl DC_StoreRange
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end FontFile__LoadXAdvanceBlock

	arm_func_start FontFile__LoadBlock3
FontFile__LoadBlock3: // 0x020527A0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x54]
	ldrh r0, [r4, #8]
	cmp r0, #0
	ldrne r1, [r4, #0x14]
	cmpne r1, #0
	ldrne r0, [r5, #0x60]
	cmpne r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r5, #0xc
	mov r2, #0
	bl FS_SeekFile
	ldrh r2, [r4, #8]
	ldr r1, [r5, #0x60]
	add r0, r5, #0xc
	mov r2, r2, lsl #5
	bl FS_ReadFile
	ldrh r1, [r4, #8]
	ldr r0, [r5, #0x60]
	mov r1, r1, lsl #5
	bl DC_StoreRange
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end FontFile__LoadBlock3

	arm_func_start FontFile__LoadCharDataBlock
FontFile__LoadCharDataBlock: // 0x020527FC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	ldr r4, [r7, #0x54]
	ldrh r0, [r4, #6]
	cmp r0, #0
	ldrne r1, [r4, #0xc]
	cmpne r1, #0
	ldrne r0, [r4, #0x18]
	cmpne r0, #0
	ldrne r0, [r4, #0x1c]
	cmpne r0, #0
	ldrne r0, [r7, #0x58]
	cmpne r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r0, r7, #0xc
	mov r2, #0
	bl FS_SeekFile
	ldrh r2, [r4, #6]
	ldr r1, [r7, #0x58]
	add r0, r7, #0xc
	mov r2, r2, lsl #3
	bl FS_ReadFile
	ldrh r1, [r4, #6]
	ldr r0, [r7, #0x58]
	mov r1, r1, lsl #3
	bl DC_StoreRange
	ldr r0, [r7, #0]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02052874: // jump table
	ldmia sp!, {r4, r5, r6, r7, r8, pc} // case 0
	b _02052884 // case 1
	b _020528B4 // case 2
	ldmia sp!, {r4, r5, r6, r7, r8, pc} // case 3
_02052884:
	ldr r1, [r4, #0x18]
	add r0, r7, #0xc
	mov r2, #0
	bl FS_SeekFile
	ldr r1, [r7, #0x7c]
	ldr r2, [r4, #0x1c]
	add r0, r7, #0xc
	bl FS_ReadFile
	ldr r0, [r7, #0x7c]
	ldr r1, [r4, #0x1c]
	bl DC_StoreRange
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020528B4:
	ldrb r2, [r4, #4]
	ldrb r1, [r4, #5]
	ldrh r0, [r4, #6]
	mov r5, #0
	smulbb r1, r2, r1
	add r8, r1, r1, lsr #31
	cmp r0, #0
	ldmleia sp!, {r4, r5, r6, r7, r8, pc}
	mov r6, r5
_020528D8:
	mov r1, r5, lsl #0x10
	ldr r3, [r7, #0x6c]
	mov r0, r7
	mov r1, r1, lsr #0x10
	add r2, r7, #0xc
	bl FontFile__ReadCharBlock
	ldr r1, [r7, #0x7c]
	ldr r0, [r7, #0x6c]
	add r1, r1, r6
	bl RenderCore_CPUCopyCompressed
	ldrh r0, [r4, #6]
	add r5, r5, #1
	add r6, r6, r8, asr #1
	cmp r5, r0
	blt _020528D8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end FontFile__LoadCharDataBlock

	arm_func_start FontFile__GetFileSize
FontFile__GetFileSize: // 0x02052918
	stmdb sp!, {r3, lr}
	ldr r2, [r0, #0x10]
	mov r3, #0
	cmp r2, #0
	add r3, r3, #0x20
	beq _02052940
	ldrh r2, [r0, #6]
	add r2, r3, r2
	add r2, r2, #0x1f
	bic r3, r2, #0x1f
_02052940:
	ldr r2, [r0, #0x14]
	cmp r2, #0
	beq _0205295C
	ldrh r2, [r0, #8]
	add r2, r3, r2, lsl #5
	add r2, r2, #0x1f
	bic r3, r2, #0x1f
_0205295C:
	ldr r2, [r0, #0xc]
	cmp r2, #0
	beq _02052A24
	ldrh r2, [r0, #6]
	cmp r1, #3
	add r3, r3, r2, lsl #3
	add r3, r3, #0x1f
	bic r3, r3, #0x1f
	addls pc, pc, r1, lsl #2
	b _02052A24
_02052984: // jump table
	b _02052994 // case 0
	b _020529C4 // case 1
	b _020529F4 // case 2
	b _02052994 // case 3
_02052994:
	ldrh r2, [r0, #0xa]
	ldrb r1, [r0, #4]
	ldrb r0, [r0, #5]
	add r2, r3, r2
	add r2, r2, #0x1f
	smulbb r0, r1, r0
	bic r1, r2, #0x1f
	add r0, r0, r0, lsr #31
	add r0, r1, r0, asr #1
	add r0, r0, #0x1f
	bic r3, r0, #0x1f
	b _02052A24
_020529C4:
	ldrb r2, [r0, #4]
	ldrb r1, [r0, #5]
	ldr r0, [r0, #0x1c]
	add r3, r3, r0
	smulbb r0, r2, r1
	add r1, r3, #0x1f
	bic r1, r1, #0x1f
	add r0, r0, r0, lsr #31
	add r0, r1, r0, asr #1
	add r0, r0, #0x1f
	bic r3, r0, #0x1f
	b _02052A24
_020529F4:
	ldrb ip, [r0, #4]
	ldrb r1, [r0, #5]
	ldrh lr, [r0, #0xa]
	smulbb r0, ip, r1
	add r1, r3, lr
	add r1, r1, #0x1f
	add r0, r0, r0, lsr #31
	bic r1, r1, #0x1f
	mov r0, r0, asr #1
	mla r0, r2, r0, r1
	add r0, r0, #0x1f
	bic r3, r0, #0x1f
_02052A24:
	mov r0, r3
	ldmia sp!, {r3, pc}
	arm_func_end FontFile__GetFileSize

	arm_func_start FontFile__Func_2052A2C
FontFile__Func_2052A2C: // 0x02052A2C
	ldr r2, [r0, #0x84]
	mov ip, #0
	str r2, [r0, #0x54]
	ldr r3, [r1, #0x10]
	add r2, ip, #0x20
	cmp r3, #0
	beq _02052A64
	ldr r3, [r0, #0x84]
	add r3, r3, r2
	str r3, [r0, #0x5c]
	ldrh r3, [r1, #6]
	add r2, r2, r3
	add r2, r2, #0x1f
	bic r2, r2, #0x1f
_02052A64:
	ldr r3, [r1, #0x14]
	cmp r3, #0
	beq _02052A8C
	ldr r3, [r0, #0x84]
	add r3, r3, r2
	str r3, [r0, #0x60]
	ldrh r3, [r1, #8]
	add r2, r2, r3, lsl #5
	add r2, r2, #0x1f
	bic r2, r2, #0x1f
_02052A8C:
	ldr r3, [r1, #0xc]
	cmp r3, #0
	bxeq lr
	ldr r3, [r0, #0x84]
	add r3, r3, r2
	str r3, [r0, #0x58]
	ldrh ip, [r1, #6]
	ldr r3, [r0, #0]
	add r2, r2, ip, lsl #3
	add r2, r2, #0x1f
	cmp r3, #3
	bic r2, r2, #0x1f
	addls pc, pc, r3, lsl #2
	bx lr
_02052AC4: // jump table
	b _02052AD4 // case 0
	b _02052B08 // case 1
	b _02052B48 // case 2
	b _02052AD4 // case 3
_02052AD4:
	ldr ip, [r0, #0x84]
	mov r3, #0
	add ip, ip, r2
	str ip, [r0, #0x6c]
	ldrh ip, [r1, #0xa]
	ldr r1, [r0, #0x84]
	add r2, r2, ip
	add r2, r2, #0x1f
	bic r2, r2, #0x1f
	add r1, r1, r2
	str r1, [r0, #0x70]
	str r3, [r0, #0x7c]
	bx lr
_02052B08:
	mov r3, #0
	str r3, [r0, #0x6c]
	ldr r3, [r0, #0x84]
	add r3, r3, r2
	str r3, [r0, #0x70]
	ldrb ip, [r1, #4]
	ldrb r1, [r1, #5]
	ldr r3, [r0, #0x84]
	smulbb r1, ip, r1
	add r1, r1, r1, lsr #31
	add r1, r2, r1, asr #1
	add r1, r1, #0x1f
	bic r1, r1, #0x1f
	add r1, r3, r1
	str r1, [r0, #0x7c]
	bx lr
_02052B48:
	ldr ip, [r0, #0x84]
	mov r3, #0
	add ip, ip, r2
	str ip, [r0, #0x6c]
	ldrh r1, [r1, #0xa]
	str r3, [r0, #0x70]
	add r1, r2, r1
	add r2, r1, #0x1f
	ldr r1, [r0, #0x84]
	bic r2, r2, #0x1f
	add r1, r1, r2
	str r1, [r0, #0x7c]
	bx lr
	arm_func_end FontFile__Func_2052A2C

	arm_func_start FontFile__Func_2052B7C
FontFile__Func_2052B7C: // 0x02052B7C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x28
	str r1, [sp, #0x1c]
	mov r10, r0
	mov r6, r2
	mov r11, r3
	ldr r9, [sp, #0x58]
	ldr r8, [sp, #0x5c]
	bl FontFile__GetCharXAdvance
	mov r5, r0
	mov r0, r10
	bl FontFile__GetPixelHeight
	mov r7, r0
	mov r0, r10
	bl FontFile__GetPixelWidth2
	str r0, [sp, #0x24]
	cmp r6, #0
	bne _02052BE0
	ldr r0, [sp, #0x68]
	cmp r0, #0
	moveq r6, r5
	beq _02052BE0
	ldr r0, [sp, #0x24]
	mov r0, r0, lsl #0x13
	mov r6, r0, lsr #0x10
_02052BE0:
	add r0, r9, r6
	ldr r1, [sp, #0x68]
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	cmp r1, #0
	str r0, [sp, #0x20]
	beq _02052C3C
	cmp r5, r6
	bls _02052C1C
	sub r0, r5, r6
	mov r0, r0, lsl #0xf
	mov r1, r6, lsl #0x10
	mov r4, r0, asr #0x10
	mov r6, r1, asr #0x10
	b _02052C50
_02052C1C:
	sub r0, r6, r5
	add r1, r9, r0, asr #1
	mov r0, r5, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r6, r0, asr #0x10
	mov r9, r1, asr #0x10
	mov r4, #0
	b _02052C50
_02052C3C:
	cmp r5, r6
	movls r6, r5
	mov r0, r6, lsl #0x10
	mov r4, #0
	mov r6, r0, asr #0x10
_02052C50:
	mov r0, r7, lsl #0x10
	cmp r9, #0
	mov r7, r0, asr #0x10
	mov r5, #0
	bge _02052C80
	add r0, r6, r9
	sub r1, r4, r9
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r9, r5
	mov r6, r0, asr #0x10
	mov r4, r1, asr #0x10
_02052C80:
	cmp r8, #0
	bge _02052CA4
	add r0, r7, r8
	sub r1, r5, r8
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r7, r0, asr #0x10
	mov r5, r1, asr #0x10
	mov r8, #0
_02052CA4:
	ldrh r0, [sp, #0x50]
	add r1, r9, r6
	sub r0, r1, r0, lsl #3
	cmp r0, #0
	subgt r0, r6, r0
	movgt r0, r0, lsl #0x10
	movgt r6, r0, asr #0x10
	ldrh r0, [sp, #0x54]
	add r1, r8, r7
	sub r0, r1, r0, lsl #3
	cmp r0, #0
	subgt r0, r7, r0
	movgt r0, r0, lsl #0x10
	movgt r7, r0, asr #0x10
	cmp r6, #0
	cmpgt r7, #0
	ldrle r0, [sp, #0x20]
	addle sp, sp, #0x28
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x64]
	cmp r0, #0
	mov r0, r10
	beq _02052D64
	ldr r1, [sp, #0x1c]
	bl FontFile__GetPixels
	mov r1, r6, lsl #0x10
	mov r6, r1, lsr #0x10
	mov r1, r7, lsl #0x10
	str r6, [sp]
	mov r1, r1, lsr #0x10
	ldrh r6, [sp, #0x50]
	stmib sp, {r1, r11}
	mov r2, r9, lsl #0x10
	str r6, [sp, #0xc]
	mov r1, r2, lsr #0x10
	mov r4, r4, lsl #0x10
	mov r3, r8, lsl #0x10
	str r1, [sp, #0x10]
	mov r1, r3, lsr #0x10
	mov r5, r5, lsl #0x10
	str r1, [sp, #0x14]
	ldrh r6, [sp, #0x60]
	ldr r1, [sp, #0x24]
	mov r2, r4, lsr #0x10
	mov r3, r5, lsr #0x10
	str r6, [sp, #0x18]
	bl BackgroundUnknown__Func_204CAE4
	b _02052DC4
_02052D64:
	ldr r1, [sp, #0x1c]
	bl FontFile__GetPixels
	mov r1, r6, lsl #0x10
	mov r6, r1, lsr #0x10
	mov r1, r7, lsl #0x10
	str r6, [sp]
	mov r1, r1, lsr #0x10
	ldrh r6, [sp, #0x50]
	stmib sp, {r1, r11}
	mov r2, r9, lsl #0x10
	str r6, [sp, #0xc]
	mov r1, r2, lsr #0x10
	mov r4, r4, lsl #0x10
	mov r3, r8, lsl #0x10
	str r1, [sp, #0x10]
	mov r1, r3, lsr #0x10
	mov r5, r5, lsl #0x10
	str r1, [sp, #0x14]
	ldrh r6, [sp, #0x60]
	ldr r1, [sp, #0x24]
	mov r2, r4, lsr #0x10
	mov r3, r5, lsr #0x10
	str r6, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
_02052DC4:
	ldr r0, [sp, #0x20]
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end FontFile__Func_2052B7C

	arm_func_start FontFile__Func_2052DD0
FontFile__Func_2052DD0: // 0x02052DD0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x1c
	mov r7, r3
	mov r9, r0
	mov r0, r7
	mov r10, r1
	mov r8, r2
	ldr r6, [sp, #0x44]
	bl Unknown2056570__Func_2056834
	mov r5, r0
	mov r0, r7
	bl Unknown2056570__Func_2056824
	mov r4, r0
	mov r0, r7
	bl Unknown2056570__Func_205682C
	mov r1, r10
	mov r3, r5
	mov r5, r0
	str r4, [sp]
	mov r2, r8
	ldrsh r10, [sp, #0x40]
	str r5, [sp, #4]
	ldrh r8, [sp, #0x48]
	str r10, [sp, #8]
	str r6, [sp, #0xc]
	str r8, [sp, #0x10]
	ldr r0, [sp, #0x4c]
	ldr r8, [sp, #0x50]
	str r0, [sp, #0x14]
	mov r0, r9
	str r8, [sp, #0x18]
	bl FontFile__Func_2052B7C
	mov r8, r0
	mov r0, r9
	ldrsh r9, [sp, #0x40]
	mov r10, r8
	bl FontFile__GetPixelHeight
	ldrsh r1, [sp, #0x40]
	add r0, r6, r0
	mov r0, r0, lsl #0x10
	cmp r1, #0
	movlt r9, #0
	mov r1, r9, asr #3
	cmp r4, r9, asr #3
	suble r1, r4, #1
	movle r1, r1, lsl #0x10
	movle r1, r1, asr #0x10
	cmp r6, #0
	movlt r6, #0
	mov r2, r6, asr #3
	cmp r5, r6, asr #3
	suble r2, r5, #1
	movle r2, r2, lsl #0x10
	movle r2, r2, asr #0x10
	cmp r8, #0
	movlt r10, #0
	add r3, r10, #7
	mov r3, r3, lsl #0xd
	cmp r4, r3, asr #16
	mov r3, r3, asr #0x10
	suble r3, r4, #1
	movle r3, r3, lsl #0x10
	mov r0, r0, asr #0x10
	movle r3, r3, asr #0x10
	cmp r0, #0
	movlt r0, #0
	add r0, r0, #7
	mov r0, r0, lsl #0xd
	cmp r5, r0, asr #16
	mov r0, r0, asr #0x10
	suble r0, r5, #1
	movle r0, r0, lsl #0x10
	movle r0, r0, asr #0x10
	cmp r1, r3
	cmplt r2, r0
	bge _02052F2C
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r4, r0, lsr #0x10
	mov r0, r7
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
	mov r3, r3, lsr #0x10
	str r4, [sp]
	bl Unknown2056570__Func_2056958
_02052F2C:
	mov r0, r8
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end FontFile__Func_2052DD0

	arm_func_start FontFile__Func_2052F38
FontFile__Func_2052F38: // 0x02052F38
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x28
	mov r8, r0
	ldr r0, [sp, #0x78]
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl STD_GetStringLength
	mov r9, r0
	add r0, r9, #1
	mov r0, r0, lsl #1
	bl _AllocHeadHEAP_SYSTEM
	mov r1, #0
	str r1, [sp]
	ldr r2, [sp, #0x78]
	mov r3, r1
	mov r4, r0
	bl STD_ConvertStringSjisToUnicode
	mov r1, r7
	mov r2, r6
	mov r3, r5
	ldrh r7, [sp, #0x58]
	mov ip, r9, lsl #1
	mov r5, #0
	strh r5, [r4, ip]
	str r7, [sp]
	ldrh r6, [sp, #0x5c]
	ldrsh r5, [sp, #0x60]
	ldrsh r7, [sp, #0x64]
	str r6, [sp, #4]
	str r5, [sp, #8]
	str r7, [sp, #0xc]
	ldrh r6, [sp, #0x68]
	ldr r5, [sp, #0x6c]
	ldrh r7, [sp, #0x70]
	str r6, [sp, #0x10]
	str r5, [sp, #0x14]
	add r5, sp, #0x78
	bic r5, r5, #3
	ldr r6, [sp, #0x74]
	str r7, [sp, #0x18]
	str r6, [sp, #0x1c]
	mov r0, r8
	add r5, r5, #4
	str r4, [sp, #0x20]
	str r5, [sp, #0x24]
	bl FontFile__Func_2053140
	mov r0, r4
	bl _FreeHEAP_SYSTEM
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end FontFile__Func_2052F38

	arm_func_start FontFile__Func_2053010
FontFile__Func_2053010: // 0x02053010
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x20
	mov r8, r0
	ldr r0, [sp, #0x68]
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl STD_GetStringLength
	mov r9, r0
	add r0, r9, #1
	mov r0, r0, lsl #1
	bl _AllocHeadHEAP_SYSTEM
	mov r1, #0
	str r1, [sp]
	ldr r2, [sp, #0x68]
	mov r3, r1
	mov r4, r0
	bl STD_ConvertStringSjisToUnicode
	mov r1, r7
	mov r2, r6
	mov r3, r5
	ldrsh r7, [sp, #0x50]
	mov ip, r9, lsl #1
	mov r5, #0
	strh r5, [r4, ip]
	ldrsh r6, [sp, #0x54]
	str r7, [sp]
	ldrh r5, [sp, #0x58]
	str r6, [sp, #4]
	ldrh r6, [sp, #0x60]
	str r5, [sp, #8]
	ldr r5, [sp, #0x5c]
	mov r0, r8
	str r5, [sp, #0xc]
	ldr r5, [sp, #0x64]
	str r6, [sp, #0x10]
	str r5, [sp, #0x14]
	add r5, sp, #0x68
	bic r5, r5, #3
	str r4, [sp, #0x18]
	add r5, r5, #4
	str r5, [sp, #0x1c]
	bl FontFile__Func_20534F8
	mov r0, r4
	bl _FreeHEAP_SYSTEM
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end FontFile__Func_2053010

	arm_func_start FontFile__Func_20530D8
FontFile__Func_20530D8: // 0x020530D8
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	ldrsh lr, [sp, #0x38]
	ldrsh ip, [sp, #0x3c]
	ldrh r4, [sp, #0x40]
	str lr, [sp]
	str ip, [sp, #4]
	str r4, [sp, #8]
	ldr ip, [sp, #0x44]
	ldrh r4, [sp, #0x48]
	str ip, [sp, #0xc]
	add ip, sp, #0x50
	bic ip, ip, #3
	ldr lr, [sp, #0x4c]
	str r4, [sp, #0x10]
	str lr, [sp, #0x14]
	ldr lr, [sp, #0x50]
	add ip, ip, #4
	str lr, [sp, #0x18]
	str ip, [sp, #0x1c]
	bl FontFile__Func_20534F8
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end FontFile__Func_20530D8

	arm_func_start FontFile__Func_2053140
FontFile__Func_2053140: // 0x02053140
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x228
	sub sp, sp, #0x400
	str r3, [sp, #0x1c]
	ldr r3, [sp, #0x650]
	mov r9, r1
	str r3, [sp, #0x650]
	ldr r3, [sp, #0x654]
	add r1, sp, #0x400
	str r3, [sp, #0x654]
	ldr r8, [sp, #0x658]
	ldr r3, [sp, #0x65c]
	mov r10, r0
	str r3, [sp, #0x65c]
	ldr r3, [sp, #0x660]
	mov r11, r2
	str r3, [sp, #0x660]
	ldr r3, [sp, #0x664]
	ldr r6, [sp, #0x670]
	str r3, [sp, #0x664]
	ldr r3, [sp, #0x66c]
	add r1, r1, #0x28
	mov r0, #0
	mov r2, #0x200
	ldr r5, [sp, #0x668]
	str r3, [sp, #0x66c]
	bl MIi_CpuClear16
	ldrh r0, [r6, #0]
	cmp r0, #0x25
	ldreqh r0, [r6, #2]
	cmpeq r0, #0x73
	ldreqh r0, [r6, #4]
	cmpeq r0, #0
	bne _020531E4
	ldr r0, [sp, #0x674]
	add r1, sp, #0x400
	ldr r0, [r0, #0]
	ldr r2, _020534F0 // =0x000001FE
	add r1, r1, #0x28
	bl MIi_CpuCopy16
	b _0205323C
_020531E4:
	mov r0, #0
	add r1, sp, #0x28
	mov r2, #0x400
	bl MIi_CpuClear32
	mov r1, #0
	mov r2, r6
	add r0, sp, #0x28
	mov r3, r1
	str r1, [sp]
	bl STD_ConvertStringUnicodeToSjis
	ldr r3, [sp, #0x674]
	add r0, sp, #0x228
	mov r1, #0x200
	add r2, sp, #0x28
	bl OS_VSNPrintf
	mov r1, #0
	add r0, sp, #0x400
	add r0, r0, #0x28
	add r2, sp, #0x228
	mov r3, r1
	str r1, [sp]
	bl STD_ConvertStringSjisToUnicode
_0205323C:
	cmp r11, #0
	bne _02053250
	mov r0, r10
	bl FontFile__GetPixelHeight
	mov r11, r0
_02053250:
	cmp r9, #0
	movne r0, #1
	strne r0, [sp, #0x20]
	moveq r0, #0
	streq r0, [sp, #0x20]
	cmp r5, #0
	moveq r5, #6
	subne r0, r5, #1
	movne r0, r0, lsl #0x10
	add r2, sp, #0x400
	movne r5, r0, lsr #0x10
	mov r0, r10
	mov r1, r11
	add r2, r2, #0x28
	bl FontFile__GetTextHeight
	ldr r1, _020534F4 // =0x55555556
	str r0, [sp, #0x24]
	smull r0, r2, r1, r5
	adds r2, r2, r5, lsr #31
	beq _020532B0
	cmp r2, #1
	beq _020532CC
	cmp r2, #2
	b _020532E4
_020532B0:
	ldr r1, [sp, #0x65c]
	ldr r0, [sp, #0x24]
	sub r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x65c]
	b _020532E4
_020532CC:
	ldr r1, [sp, #0x65c]
	ldr r0, [sp, #0x24]
	sub r0, r1, r0, lsr #1
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x65c]
_020532E4:
	ldr r1, _020534F4 // =0x55555556
	mov r2, #3
	smull r0, r3, r1, r5
	add r3, r3, r5, lsr #31
	smull r0, r1, r2, r3
	subs r3, r5, r0
	beq _02053314
	cmp r3, #1
	beq _0205331C
	cmp r3, #2
	moveq r7, #2
	b _02053320
_02053314:
	mov r7, #0
	b _02053320
_0205331C:
	mov r7, #1
_02053320:
	add r6, sp, #0x400
	cmp r7, #0
	add r6, r6, #0x28
	beq _02053344
	cmp r7, #1
	beq _0205334C
	cmp r7, #2
	beq _02053364
	b _02053378
_02053344:
	mov r4, r8
	b _02053378
_0205334C:
	mov r0, r10
	mov r1, r9
	mov r2, r6
	bl FontFile__GetTextWidth
	sub r4, r8, r0, lsr #1
	b _02053378
_02053364:
	mov r0, r10
	mov r1, r9
	mov r2, r6
	bl FontFile__GetTextWidth
	sub r4, r8, r0
_02053378:
	ldrh r0, [r6, #0]
	ldr r5, [sp, #0x65c]
	cmp r0, #0
	beq _02053454
_02053388:
	cmp r0, #0xa
	bne _020533E8
	cmp r7, #0
	add r5, r5, r11
	beq _020533B0
	cmp r7, #1
	beq _020533B8
	cmp r7, #2
	beq _020533D0
	b _02053448
_020533B0:
	mov r4, r8
	b _02053448
_020533B8:
	mov r0, r10
	mov r1, r9
	add r2, r6, #2
	bl FontFile__GetTextWidth
	sub r4, r8, r0, lsr #1
	b _02053448
_020533D0:
	mov r0, r10
	mov r1, r9
	add r2, r6, #2
	bl FontFile__GetTextWidth
	sub r4, r8, r0
	b _02053448
_020533E8:
	bl GetFontCharacterFromUTF
	ldr r1, [sp, #0x650]
	mov r0, r0, lsl #0x10
	str r1, [sp]
	ldr r1, [sp, #0x654]
	ldr r3, [sp, #0x1c]
	str r1, [sp, #4]
	mov r1, r0, lsr #0x10
	mov r0, r4, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #8]
	mov r0, r5, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x660]
	mov r2, r9
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x664]
	str r0, [sp, #0x14]
	ldr r0, [sp, #0x20]
	str r0, [sp, #0x18]
	mov r0, r10
	bl FontFile__Func_2052B7C
	mov r4, r0
_02053448:
	ldrh r0, [r6, #2]!
	cmp r0, #0
	bne _02053388
_02053454:
	ldr r0, [sp, #0x66c]
	cmp r0, #0
	addeq sp, sp, #0x228
	addeq sp, sp, #0x400
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r2, sp, #0x400
	add r2, r2, #0x28
	mov r0, r10
	mov r1, r11
	bl FontFile__GetLineLength
	cmp r7, #0
	beq _020534AC
	cmp r7, #1
	beq _020534A0
	cmp r7, #2
	subeq r1, r8, r0
	moveq r1, r1, lsl #0x10
	moveq r8, r1, asr #0x10
	b _020534AC
_020534A0:
	sub r1, r8, r0, lsr #1
	mov r1, r1, lsl #0x10
	mov r8, r1, asr #0x10
_020534AC:
	ldr r1, [sp, #0x66c]
	strh r8, [r1]
	ldr r2, [sp, #0x65c]
	strh r2, [r1, #2]
	add r1, r8, r0
	ldr r0, [sp, #0x66c]
	strh r1, [r0, #4]
	ldr r1, [sp, #0x65c]
	ldr r0, [sp, #0x24]
	add r1, r1, r0
	ldr r0, [sp, #0x66c]
	strh r1, [r0, #6]
	strh r4, [r0, #8]
	strh r5, [r0, #0xa]
	add sp, sp, #0x228
	add sp, sp, #0x400
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020534F0: .word 0x000001FE
_020534F4: .word 0x55555556
	arm_func_end FontFile__Func_2053140

	arm_func_start FontFile__Func_20534F8
FontFile__Func_20534F8: // 0x020534F8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	mov r7, r3
	mov r10, r0
	mov r0, r7
	mov r9, r1
	mov r8, r2
	ldr r6, [sp, #0x6c]
	bl Unknown2056570__Func_2056834
	mov r11, r0
	mov r0, r7
	bl Unknown2056570__Func_2056824
	mov r4, r0
	mov r0, r7
	bl Unknown2056570__Func_205682C
	mov r5, r0
	cmp r6, #0
	ldrsh r1, [sp, #0x58]
	stmia sp, {r4, r5}
	str r1, [sp, #8]
	ldrsh r0, [sp, #0x5c]
	ldrh r1, [sp, #0x60]
	addeq r6, sp, #0x28
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	ldr r0, [sp, #0x64]
	ldrh r1, [sp, #0x68]
	str r0, [sp, #0x14]
	ldr r0, [sp, #0x70]
	str r1, [sp, #0x18]
	str r6, [sp, #0x1c]
	str r0, [sp, #0x20]
	ldr ip, [sp, #0x74]
	mov r0, r10
	mov r1, r9
	mov r2, r8
	mov r3, r11
	str ip, [sp, #0x24]
	bl FontFile__Func_2053140
	ldrsh r2, [r6, #0]
	ldrsh r3, [r6, #2]
	ldrsh r0, [r6, #4]
	cmp r2, #0
	movlt r2, #0
	cmp r4, r2, asr #3
	mov r2, r2, asr #3
	suble r2, r4, #1
	movle r2, r2, lsl #0x10
	movle r2, r2, asr #0x10
	cmp r3, #0
	movlt r3, #0
	cmp r5, r3, asr #3
	mov r3, r3, asr #3
	suble r3, r5, #1
	movle r3, r3, lsl #0x10
	movle r3, r3, asr #0x10
	cmp r0, #0
	movlt r0, #0
	add r0, r0, #7
	mov r0, r0, lsl #0xd
	cmp r4, r0, asr #16
	mov r0, r0, asr #0x10
	suble r0, r4, #1
	movle r0, r0, lsl #0x10
	ldrsh r1, [r6, #6]
	movle r0, r0, asr #0x10
	cmp r1, #0
	movlt r1, #0
	add r1, r1, #7
	mov r1, r1, lsl #0xd
	cmp r5, r1, asr #16
	mov r1, r1, asr #0x10
	suble r1, r5, #1
	movle r1, r1, lsl #0x10
	movle r1, r1, asr #0x10
	cmp r2, r0
	cmplt r3, r1
	addge sp, sp, #0x34
	ldmgeia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r4, r0, lsl #0x10
	mov r5, r1, lsr #0x10
	mov r0, r7
	mov r1, r2, lsr #0x10
	mov r2, r3, lsr #0x10
	mov r3, r4, lsr #0x10
	str r5, [sp]
	bl Unknown2056570__Func_2056958
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end FontFile__Func_20534F8

	arm_func_start FontFile__GetTextHeight
FontFile__GetTextHeight: // 0x02053668
	stmdb sp!, {r4, lr}
	mov r4, r2
	cmp r1, #0
	bne _02053680
	bl FontFile__GetPixelHeight
	mov r1, r0
_02053680:
	ldrh r2, [r4, #0]
	mov r0, r1
	cmp r2, #0
	ldmeqia sp!, {r4, pc}
_02053690:
	ldrh r2, [r4, #0]
	cmp r2, #0xa
	addeq r0, r0, r1
	moveq r0, r0, lsl #0x10
	ldrh r2, [r4, #2]!
	moveq r0, r0, lsr #0x10
	cmp r2, #0
	bne _02053690
	ldmia sp!, {r4, pc}
	arm_func_end FontFile__GetTextHeight

	arm_func_start FontFile__GetLineLength
FontFile__GetLineLength: // 0x020536B4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r5, #0
	mov r7, r2
	mov r8, r0
	mov r6, r5
	cmp r1, #0
	ldrh r0, [r7, #0]
	bne _0205372C
	cmp r0, #0
	beq _0205376C
	mov r4, r5
_020536E0:
	ldrh r0, [r7, #0]
	cmp r0, #0xa
	bne _020536FC
	cmp r5, r6
	movlo r5, r6
	movlo r6, r4
	b _0205371C
_020536FC:
	bl GetFontCharacterFromUTF
	mov r1, r0, lsl #0x10
	mov r0, r8
	mov r1, r1, lsr #0x10
	bl FontFile__GetCharXAdvance
	add r0, r6, r0
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
_0205371C:
	ldrh r0, [r7, #2]!
	cmp r0, #0
	bne _020536E0
	b _0205376C
_0205372C:
	cmp r0, #0
	beq _0205376C
	mov r2, r5
_02053738:
	ldrh r0, [r7, #0]
	cmp r0, #0xa
	bne _02053754
	cmp r5, r6
	movlo r5, r6
	movlo r6, r2
	b _02053760
_02053754:
	add r0, r6, r1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
_02053760:
	ldrh r0, [r7, #2]!
	cmp r0, #0
	bne _02053738
_0205376C:
	cmp r5, r6
	movlo r5, r6
	mov r0, r5
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end FontFile__GetLineLength

	arm_func_start FontFile__GetTextWidth
FontFile__GetTextWidth: // 0x0205377C
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r2
	mov r6, r0
	cmp r1, #0
	mov r4, #0
	ldrh r0, [r5, #0]
	bne _020537DC
	cmp r0, #0
	beq _02053808
_020537A0:
	ldrh r0, [r5, #0]
	cmp r0, #0xa
	beq _02053808
	bl GetFontCharacterFromUTF
	mov r1, r0, lsl #0x10
	mov r0, r6
	mov r1, r1, lsr #0x10
	bl FontFile__GetCharXAdvance
	ldrh r1, [r5, #2]!
	add r0, r4, r0
	mov r0, r0, lsl #0x10
	cmp r1, #0
	mov r4, r0, lsr #0x10
	bne _020537A0
	b _02053808
_020537DC:
	cmp r0, #0
	beq _02053808
_020537E4:
	ldrh r0, [r5, #0]
	cmp r0, #0xa
	beq _02053808
	ldrh r2, [r5, #2]!
	add r0, r4, r1
	mov r0, r0, lsl #0x10
	cmp r2, #0
	mov r4, r0, lsr #0x10
	bne _020537E4
_02053808:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end FontFile__GetTextWidth
