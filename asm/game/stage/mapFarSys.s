	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__GFXControl

	.bss
	
.public MapFarSys__sVars
MapFarSys__sVars: // MapFarSys__sVars
	.space 0x10
	
MapFarSys__ReleaseTable: // 0x02133C18
	.space 0x04 * 46

	.text

	arm_func_start MapFarSys__SetAsset
MapFarSys__SetAsset: // 0x0200B234
	ldr r1, _0200B240 // =MapFarSys__sVars
	str r0, [r1]
	bx lr
	.align 2, 0
_0200B240: .word MapFarSys__sVars
	arm_func_end MapFarSys__SetAsset

	arm_func_start MapFarSys__GetAsset
MapFarSys__GetAsset: // 0x0200B244
	ldr r0, _0200B250 // =MapFarSys__sVars
	ldr r0, [r0, #0]
	bx lr
	.align 2, 0
_0200B250: .word MapFarSys__sVars
	arm_func_end MapFarSys__GetAsset

	arm_func_start MapFarSys__Release
MapFarSys__Release: // 0x0200B254
	stmdb sp!, {r3, lr}
	ldr r0, _0200B27C // =MapFarSys__sVars
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl _FreeHEAP_USER
	ldr r0, _0200B27C // =MapFarSys__sVars
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0200B27C: .word MapFarSys__sVars
	arm_func_end MapFarSys__Release

	arm_func_start MapFarSys__Build
MapFarSys__Build: // 0x0200B280
	stmdb sp!, {r4, lr}
	bl MapFarSys__GetAsset
	ldr r1, _0200B33C // =MapFarSys__sVars
	movs r4, r0
	ldr r0, [r1, #0xc]
	bic r0, r0, #3
	str r0, [r1, #0xc]
	ldmeqia sp!, {r4, pc}
	bl IsBossStage
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r1, _0200B340 // =0x06008000
	mov r0, #0
	mov r2, #0x8000
	bl MIi_CpuClear32
	ldr r1, _0200B344 // =0x06208000
	mov r0, #0
	mov r2, #0x8000
	bl MIi_CpuClear32
	ldr r1, _0200B348 // =0x06004000
	mov r0, #0
	mov r2, #0x2000
	bl MIi_CpuClear32
	ldr r1, _0200B34C // =0x06204000
	mov r0, #0
	mov r2, #0x2000
	bl MIi_CpuClear32
	mov r0, r4
	bl MapFarSys__Func_200B578
	ldr r1, _0200B33C // =MapFarSys__sVars
	mov r2, #0x5000000
	ldr ip, [r1, #0xc]
	mov r3, #0
	orr ip, ip, #1
	str ip, [r1, #0xc]
	strh r3, [r2]
	add r1, r2, #0x400
	mov r0, r4
	strh r3, [r1]
	bl GetBackgroundFormat
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, _0200B33C // =MapFarSys__sVars
	ldr r1, [r0, #0xc]
	orr r1, r1, #2
	str r1, [r0, #0xc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0200B33C: .word MapFarSys__sVars
_0200B340: .word 0x06008000
_0200B344: .word 0x06208000
_0200B348: .word 0x06004000
_0200B34C: .word 0x06204000
	arm_func_end MapFarSys__Build

	arm_func_start MapFarSys__BuildBG
MapFarSys__BuildBG: // 0x0200B350
	stmdb sp!, {r4, lr}
	ldr r0, _0200B3BC // =gameState
	ldr r1, _0200B3C0 // =MapFarSys__BuildTable
	ldrh r4, [r0, #0x28]
	ldr r0, [r1, r4, lsl #2]
	cmp r0, #0
	beq _0200B3B4
	mov r0, #0x1240
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r3, _0200B3C4 // =MapFarSys__sVars
	mov r0, #0
	mov r2, #0x1240
	str r1, [r3, #8]
	bl MIi_CpuClear16
	ldr r0, _0200B3C4 // =MapFarSys__sVars
	mov r3, #0x200
	ldr r2, [r0, #8]
	ldr r1, _0200B3C0 // =MapFarSys__BuildTable
	str r3, [r2, #0xc]
	ldr r2, [r0, #8]
	ldr r0, [r2, #0xc]
	str r0, [r2, #8]
	ldr r0, [r1, r4, lsl #2]
	blx r0
_0200B3B4:
	bl MapFarSys__Func_200B718
	ldmia sp!, {r4, pc}
	.align 2, 0
_0200B3BC: .word gameState
_0200B3C0: .word MapFarSys__BuildTable
_0200B3C4: .word MapFarSys__sVars
	arm_func_end MapFarSys__BuildBG

	arm_func_start MapFarSys__ReleaseBG
MapFarSys__ReleaseBG: // 0x0200B3C8
	stmdb sp!, {r4, lr}
	ldr r1, _0200B434 // =gameState
	mov r0, #0
	ldrh r4, [r1, #0x28]
	bl RenderCore_StopDMA
	mov r0, #1
	bl RenderCore_StopDMA
	ldr r0, _0200B438 // =MapFarSys__ReleaseTable
	ldr r0, [r0, r4, lsl #2]
	cmp r0, #0
	beq _0200B3F8
	blx r0
_0200B3F8:
	ldr r0, _0200B43C // =MapFarSys__sVars
	ldr r0, [r0, #8]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _0200B418
	bl DestroyTask
_0200B418:
	ldr r0, _0200B43C // =MapFarSys__sVars
	ldr r0, [r0, #8]
	bl _FreeHEAP_USER
	ldr r0, _0200B43C // =MapFarSys__sVars
	mov r1, #0
	str r1, [r0, #8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0200B434: .word gameState
_0200B438: .word MapFarSys__ReleaseTable
_0200B43C: .word MapFarSys__sVars
	arm_func_end MapFarSys__ReleaseBG

	arm_func_start MapFarSys__ProcessBG
MapFarSys__ProcessBG: // 0x0200B440
	stmdb sp!, {r3, r4, r5, lr}
	ldr r0, _0200B4B8 // =MapFarSys__sVars
	ldr r1, _0200B4BC // =gameState
	ldr r0, [r0, #0xc]
	ldrh r1, [r1, #0x28]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, _0200B4C0 // =MapFarSys__ProcessTable
	ldr r0, [r0, r1, lsl #2]
	cmp r0, #0
	beq _0200B470
	blx r0
_0200B470:
	ldr r4, _0200B4C4 // =mapCamera
	ldr lr, _0200B4C8 // =VRAMSystem__GFXControl
	ldr r1, _0200B4CC // =0x000001FF
	mov r5, #0
	mov r0, #0x70
_0200B484:
	mla r3, r5, r0, r4
	ldr r2, [r3, #0x38]
	ldr ip, [lr, r5, lsl #2]
	and r2, r1, r2, asr #12
	strh r2, [ip, #4]
	ldr r3, [r3, #0x3c]
	add r2, r5, #1
	and r3, r1, r3, asr #12
	and r5, r2, #0xff
	strh r3, [ip, #6]
	cmp r5, #1
	bls _0200B484
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0200B4B8: .word MapFarSys__sVars
_0200B4BC: .word gameState
_0200B4C0: .word MapFarSys__ProcessTable
_0200B4C4: .word mapCamera
_0200B4C8: .word VRAMSystem__GFXControl
_0200B4CC: .word 0x000001FF
	arm_func_end MapFarSys__ProcessBG

	arm_func_start MapFarSys__SetScrollSpeed
MapFarSys__SetScrollSpeed: // 0x0200B4D0
	ldr r3, _0200B4F8 // =MapFarSys__sVars
	ldr ip, [r3, #8]
	cmp ip, #0
	bxeq lr
	add ip, ip, r0, lsl #3
	str r1, [ip, #0x10]
	ldr r1, [r3, #8]
	add r0, r1, r0, lsl #3
	str r2, [r0, #0x14]
	bx lr
	.align 2, 0
_0200B4F8: .word MapFarSys__sVars
	arm_func_end MapFarSys__SetScrollSpeed

	arm_func_start MapFarSys__AdvanceScrollSpeed
MapFarSys__AdvanceScrollSpeed: // 0x0200B4FC
	ldr r2, _0200B520 // =MapFarSys__sVars
	ldr r2, [r2, #8]
	cmp r2, #0
	bxeq lr
	add r3, r2, #0x10
	ldr r2, [r3, r0, lsl #3]
	add r1, r2, r1
	str r1, [r3, r0, lsl #3]
	bx lr
	.align 2, 0
_0200B520: .word MapFarSys__sVars
	arm_func_end MapFarSys__AdvanceScrollSpeed

	arm_func_start MapFarSys__Func_200B524
MapFarSys__Func_200B524: // 0x0200B524
	ldr r1, _0200B574 // =MapFarSys__sVars
	ldr r0, [r1, #8]
	cmp r0, #0
	bxeq lr
	cmp r3, #0
	bxlt lr
	cmp r3, #2
	bxge lr
	add r0, r0, r3, lsl #1
	add r0, r0, #0x600
	ldrh ip, [r0, #0x38]
	cmp r2, ip
	bxeq lr
	strh r2, [r0, #0x38]
	ldr r2, [r1, #8]
	mov r0, #1
	ldr r1, [r2, #0]
	orr r0, r1, r0, lsl r3
	str r0, [r2]
	bx lr
	.align 2, 0
_0200B574: .word MapFarSys__sVars
	arm_func_end MapFarSys__Func_200B524

	arm_func_start MapFarSys__Func_200B578
MapFarSys__Func_200B578: // 0x0200B578
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x48
	ldr r5, _0200B710 // =0x0210E120
	add r4, sp, #0x28
	mov r10, r0
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r5, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	mov r0, r10
	bl GetBackgroundFormat
	str r0, [sp, #0x20]
	mov r0, r10
	bl GetBackgroundWidth
	str r0, [sp, #0x24]
	mov r0, r10
	bl GetBackgroundHeight
	mov r6, r0
	mov r5, #0
_0200B5C4:
	mov r0, r10
	bl GetBackgroundPixels
	add r1, sp, #0x28
	ldr r1, [r1, r5, lsl #4]
	bl RenderCore_CPUCopyCompressed
	mov r0, r10
	bl GetBackgroundTileCount
	ldr r1, _0200B714 // =MapFarSys__sVars
	str r0, [r1, #4]
	mov r0, r10
	bl GetBackgroundPalette
	ldr r1, [sp, #0x20]
	cmp r1, #0
	beq _0200B608
	cmp r1, #1
	beq _0200B620
	b _0200B634
_0200B608:
	add r2, sp, #0x28
	add r2, r2, r5, lsl #4
	ldr r2, [r2, #4]
	mov r1, #0
	bl LoadCompressedPalette
	b _0200B634
_0200B620:
	add r1, sp, #0x28
	add r1, r1, r5, lsl #4
	ldr r1, [r1, #8]
	mov r2, #0x6200
	bl LoadCompressedPalette
_0200B634:
	mov r0, r10
	bl GetBackgroundMappings
	mov r9, r0
	ldr r0, [sp, #0x24]
	cmp r0, #0x40
	bne _0200B698
	mov r0, r10
	bl GetBackgroundFlag
	add r1, sp, #0x28
	str r0, [sp]
	add r0, r1, r5, lsl #4
	mov r1, #0
	ldr r0, [r0, #0xc]
	mov r3, #0x40
	stmib sp, {r0, r1}
	mov r0, #8
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, r9
	mov r2, r1
	str r6, [sp, #0x1c]
	bl Mappings__ReadMappings
	b _0200B6FC
_0200B698:
	add r0, sp, #0x28
	add r0, r0, r5, lsl #4
	ldr r8, [r0, #0xc]
	mov r7, #0
	mov r4, #8
	mov r11, #0x20
_0200B6B0:
	mov r0, r10
	bl GetBackgroundFlag
	stmia sp, {r0, r8}
	mov r0, #0
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r7, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r1, #0
	str r11, [sp, #0x18]
	mov r0, r9
	mov r2, r1
	mov r3, r11
	str r6, [sp, #0x1c]
	bl Mappings__ReadMappings
	add r0, r7, #0x20
	and r7, r0, #0xff
	cmp r7, #0x40
	blo _0200B6B0
_0200B6FC:
	add r5, r5, #1
	cmp r5, #2
	blt _0200B5C4
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0200B710: .word 0x0210E120
_0200B714: .word MapFarSys__sVars
	arm_func_end MapFarSys__Func_200B578

	arm_func_start MapFarSys__Func_200B718
MapFarSys__Func_200B718: // 0x0200B718
	ldr r0, _0200B7D4 // =MapFarSys__sVars
	ldr r2, [r0, #0xc]
	tst r2, #1
	beq _0200B748
	ldr r0, _0200B7D8 // =mapCamera
	ldr r1, [r0, #0]
	orr r1, r1, #4
	str r1, [r0]
	ldr r1, [r0, #0x70]
	orr r1, r1, #4
	str r1, [r0, #0x70]
	b _0200B768
_0200B748:
	ldr r0, _0200B7D8 // =mapCamera
	ldr r1, [r0, #0]
	bic r1, r1, #4
	str r1, [r0]
	ldr r1, [r0, #0x70]
	bic r1, r1, #4
	str r1, [r0, #0x70]
	bx lr
_0200B768:
	tst r2, #2
	ldr r2, _0200B7DC // =0x0400000A
	beq _0200B7A4
	ldrh r0, [r2, #0]
	add r1, r2, #0x1000
	and r0, r0, #0x43
	orr r0, r0, #8
	orr r0, r0, #0xe800
	strh r0, [r2]
	ldrh r0, [r1, #0]
	and r0, r0, #0x43
	orr r0, r0, #8
	orr r0, r0, #0xe800
	strh r0, [r1]
	bx lr
_0200B7A4:
	ldrh r0, [r2, #0]
	add r1, r2, #0x1000
	and r0, r0, #0x43
	orr r0, r0, #0x88
	orr r0, r0, #0xe800
	strh r0, [r2]
	ldrh r0, [r1, #0]
	and r0, r0, #0x43
	orr r0, r0, #0x88
	orr r0, r0, #0xe800
	strh r0, [r1]
	bx lr
	.align 2, 0
_0200B7D4: .word MapFarSys__sVars
_0200B7D8: .word mapCamera
_0200B7DC: .word 0x0400000A
	arm_func_end MapFarSys__Func_200B718

	arm_func_start MapFarSys__Build_Z1
MapFarSys__Build_Z1: // 0x0200B7E0
	stmdb sp!, {r3, lr}
	ldr r0, _0200B938 // =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200B81C
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200B834
_0200B81C:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, _0200B93C // =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200B834:
	ldr r1, _0200B940 // =MapFarSys__sVars
	mov r3, #0x200
	ldr r2, [r1, #8]
	ldr r0, _0200B944 // =gameState
	str r3, [r2, #0xc]
	ldr r2, [r1, #8]
	ldr r1, [r2, #0xc]
	str r1, [r2, #8]
	ldrh r0, [r0, #0x28]
	cmp r0, #0
	cmpne r0, #2
	ldmneia sp!, {r3, pc}
	ldr r0, _0200B940 // =MapFarSys__sVars
	ldr r3, _0200B948 // =0x04000016
	ldr r0, [r0, #8]
	mov ip, #2
	add r1, r0, #0x20
	add r2, r0, #0x320
	mov r0, #0
	str ip, [sp]
	bl RenderCore_PrepareDMA
	ldr r0, _0200B940 // =MapFarSys__sVars
	ldr r3, _0200B94C // =0x04001016
	ldr r0, [r0, #8]
	mov ip, #2
	add r1, r0, #0x1a0
	add r2, r0, #0x4a0
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	ldr r0, _0200B944 // =gameState
	ldrh r1, [r0, #0x28]
	cmp r1, #0
	bne _0200B904
	ldr r0, [r0, #0x10]
	and r0, r0, #0x420
	cmp r0, #0x420
	bne _0200B8E8
	ldr r0, _0200B940 // =MapFarSys__sVars
	ldr r2, _0200B950 // =0x0210E23C
	ldr r1, [r0, #8]
	str r2, [r1, #0x620]
	ldr r0, [r0, #8]
	str r2, [r0, #0x62c]
	ldmia sp!, {r3, pc}
_0200B8E8:
	ldr r0, _0200B940 // =MapFarSys__sVars
	ldr r2, _0200B954 // =0x0210E1D4
	ldr r1, [r0, #8]
	str r2, [r1, #0x620]
	ldr r0, [r0, #8]
	str r2, [r0, #0x62c]
	ldmia sp!, {r3, pc}
_0200B904:
	ldr r0, _0200B940 // =MapFarSys__sVars
	ldr r3, _0200B958 // =0x0210E30C
	ldr r1, [r0, #8]
	mov r2, #0x1d0
	str r3, [r1, #0x620]
	ldr r1, [r0, #8]
	str r3, [r1, #0x62c]
	ldr r1, [r0, #8]
	str r2, [r1, #0xc]
	ldr r1, [r0, #8]
	ldr r0, [r1, #0xc]
	str r0, [r1, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0200B938: .word mapCamera
_0200B93C: .word mapCamera+0x00000070
_0200B940: .word MapFarSys__sVars
_0200B944: .word gameState
_0200B948: .word 0x04000016
_0200B94C: .word 0x04001016
_0200B950: .word 0x0210E23C
_0200B954: .word 0x0210E1D4
_0200B958: .word 0x0210E30C
	arm_func_end MapFarSys__Build_Z1

	arm_func_start MapFarSys__Build_Z2
MapFarSys__Build_Z2: // 0x0200B95C
	stmdb sp!, {r3, lr}
	ldr r0, _0200BA2C // =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200B998
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200B9B0
_0200B998:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, _0200BA30 // =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200B9B0:
	ldr r1, _0200BA34 // =MapFarSys__sVars
	mov r2, #0x1d0
	ldr r0, [r1, #8]
	ldr r3, _0200BA38 // =0x04000016
	str r2, [r0, #0xc]
	ldr lr, [r1, #8]
	mov ip, #2
	ldr r2, [lr, #0xc]
	mov r0, #0
	str r2, [lr, #8]
	ldr r2, [r1, #8]
	add r1, r2, #0x20
	add r2, r2, #0x320
	str ip, [sp]
	bl RenderCore_PrepareDMA
	ldr r0, _0200BA34 // =MapFarSys__sVars
	ldr r3, _0200BA3C // =0x04001016
	ldr r0, [r0, #8]
	mov ip, #2
	add r1, r0, #0x1a0
	add r2, r0, #0x4a0
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	ldr r0, _0200BA34 // =MapFarSys__sVars
	ldr r2, _0200BA40 // =0x0210E160
	ldr r1, [r0, #8]
	str r2, [r1, #0x620]
	ldr r0, [r0, #8]
	str r2, [r0, #0x62c]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0200BA2C: .word mapCamera
_0200BA30: .word mapCamera+0x00000070
_0200BA34: .word MapFarSys__sVars
_0200BA38: .word 0x04000016
_0200BA3C: .word 0x04001016
_0200BA40: .word 0x0210E160
	arm_func_end MapFarSys__Build_Z2

	arm_func_start MapFarSys__Build_Z3
MapFarSys__Build_Z3: // 0x0200BA44
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r0, _0200BB18 // =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200BA84
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200BA9C
_0200BA84:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, _0200BB1C // =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200BA9C:
	ldr r1, _0200BB20 // =MapFarSys__sVars
	mov ip, #0x200
	ldr r0, [r1, #8]
	ldr r2, _0200BB24 // =0x00000C04
	str ip, [r0, #8]
	ldr r3, [r1, #8]
	mov r0, #0
	str ip, [r3, #0xc]
	ldr r1, [r1, #8]
	add r1, r1, #0x23c
	add r4, r1, #0x400
	mov r1, r4
	bl MIi_CpuClear32
	add r0, r4, #0x204
	mov ip, #4
	ldr r3, _0200BB28 // =0x04000014
	add r1, r4, #4
	add r2, r0, #0x400
	mov r0, #0
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add r0, r4, #0x104
	mov ip, #4
	ldr r3, _0200BB2C // =0x04001014
	add r1, r4, #0x304
	add r2, r0, #0x800
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0200BB18: .word mapCamera
_0200BB1C: .word mapCamera+0x00000070
_0200BB20: .word MapFarSys__sVars
_0200BB24: .word 0x00000C04
_0200BB28: .word 0x04000014
_0200BB2C: .word 0x04001014
	arm_func_end MapFarSys__Build_Z3

	arm_func_start MapFarSys__Build_Z4
MapFarSys__Build_Z4: // 0x0200BB30
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r0, _0200BC00 // =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200BB70
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200BB88
_0200BB70:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, _0200BC04 // =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200BB88:
	ldr r1, _0200BC08 // =MapFarSys__sVars
	mov ip, #0x200
	ldr r0, [r1, #8]
	ldr r2, _0200BC0C // =0x00000604
	str ip, [r0, #8]
	ldr r3, [r1, #8]
	mov r0, #0
	str ip, [r3, #0xc]
	ldr r1, [r1, #8]
	add r1, r1, #0x23c
	add r4, r1, #0x400
	mov r1, r4
	bl MIi_CpuClear32
	mov ip, #2
	ldr r3, _0200BC10 // =0x04000014
	add r1, r4, #4
	add r2, r4, #0x304
	mov r0, #0
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add r0, r4, #0x84
	mov ip, #2
	ldr r3, _0200BC14 // =0x04001014
	add r1, r4, #0x184
	add r2, r0, #0x400
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0200BC00: .word mapCamera
_0200BC04: .word mapCamera+0x00000070
_0200BC08: .word MapFarSys__sVars
_0200BC0C: .word 0x00000604
_0200BC10: .word 0x04000014
_0200BC14: .word 0x04001014
	arm_func_end MapFarSys__Build_Z4

	arm_func_start MapFarSys__Build_Z5
MapFarSys__Build_Z5: // 0x0200BC18
	stmdb sp!, {r3, lr}
	ldr r0, _0200BC8C // =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200BC54
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200BC6C
_0200BC54:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, _0200BC90 // =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200BC6C:
	ldr r0, _0200BC94 // =MapFarSys__sVars
	mov r2, #0x200
	ldr r1, [r0, #8]
	str r2, [r1, #0xc]
	ldr r1, [r0, #8]
	ldr r0, [r1, #0xc]
	str r0, [r1, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0200BC8C: .word mapCamera
_0200BC90: .word mapCamera+0x00000070
_0200BC94: .word MapFarSys__sVars
	arm_func_end MapFarSys__Build_Z5

	arm_func_start MapFarSys__Build_Z6
MapFarSys__Build_Z6: // 0x0200BC98
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r0, _0200BD6C // =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200BCD8
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200BCF0
_0200BCD8:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, _0200BD70 // =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200BCF0:
	ldr r1, _0200BD74 // =MapFarSys__sVars
	mov r3, #0x200
	ldr r0, [r1, #8]
	ldr r2, _0200BD78 // =0x00000604
	str r3, [r0, #0xc]
	ldr ip, [r1, #8]
	mov r0, #0
	ldr r3, [ip, #0xc]
	str r3, [ip, #8]
	ldr r1, [r1, #8]
	add r1, r1, #0x23c
	add r4, r1, #0x400
	mov r1, r4
	bl MIi_CpuClear32
	mov ip, #2
	ldr r3, _0200BD7C // =0x04000014
	add r1, r4, #4
	add r2, r4, #0x304
	mov r0, #0
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add r0, r4, #0x84
	mov ip, #2
	ldr r3, _0200BD80 // =0x04001014
	add r1, r4, #0x184
	add r2, r0, #0x400
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0200BD6C: .word mapCamera
_0200BD70: .word mapCamera+0x00000070
_0200BD74: .word MapFarSys__sVars
_0200BD78: .word 0x00000604
_0200BD7C: .word 0x04000014
_0200BD80: .word 0x04001014
	arm_func_end MapFarSys__Build_Z6

	arm_func_start MapFarSys__Build_Z7
MapFarSys__Build_Z7: // 0x0200BD84
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r0, _0200BE5C // =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200BDC4
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200BDDC
_0200BDC4:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, _0200BE60 // =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200BDDC:
	ldr r1, _0200BE64 // =MapFarSys__sVars
	mov r3, #0x1d0
	ldr r0, [r1, #8]
	ldr r2, _0200BE68 // =0x00000C04
	str r3, [r0, #0xc]
	ldr ip, [r1, #8]
	mov r0, #0
	ldr r3, [ip, #0xc]
	str r3, [ip, #8]
	ldr r1, [r1, #8]
	add r1, r1, #0x23c
	add r4, r1, #0x400
	mov r1, r4
	bl MIi_CpuClear32
	add r0, r4, #0x204
	mov ip, #4
	ldr r3, _0200BE6C // =0x04000014
	add r1, r4, #4
	add r2, r0, #0x400
	mov r0, #0
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add r0, r4, #0x104
	mov ip, #4
	ldr r3, _0200BE70 // =0x04001014
	add r1, r4, #0x304
	add r2, r0, #0x800
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0200BE5C: .word mapCamera
_0200BE60: .word mapCamera+0x00000070
_0200BE64: .word MapFarSys__sVars
_0200BE68: .word 0x00000C04
_0200BE6C: .word 0x04000014
_0200BE70: .word 0x04001014
	arm_func_end MapFarSys__Build_Z7

	arm_func_start MapFarSys__Build_Z9
MapFarSys__Build_Z9: // 0x0200BE74
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r0, _0200BF48 // =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200BEB4
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200BECC
_0200BEB4:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, _0200BF4C // =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200BECC:
	ldr r1, _0200BF50 // =MapFarSys__sVars
	mov r3, #0x200
	ldr r0, [r1, #8]
	ldr r2, _0200BF54 // =0x00000604
	str r3, [r0, #0xc]
	ldr ip, [r1, #8]
	mov r0, #0
	ldr r3, [ip, #0xc]
	str r3, [ip, #8]
	ldr r1, [r1, #8]
	add r1, r1, #0x23c
	add r4, r1, #0x400
	mov r1, r4
	bl MIi_CpuClear32
	mov ip, #2
	ldr r3, _0200BF58 // =0x04000014
	add r1, r4, #4
	add r2, r4, #0x304
	mov r0, #0
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add r0, r4, #0x84
	mov ip, #2
	ldr r3, _0200BF5C // =0x04001014
	add r1, r4, #0x184
	add r2, r0, #0x400
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0200BF48: .word mapCamera
_0200BF4C: .word mapCamera+0x00000070
_0200BF50: .word MapFarSys__sVars
_0200BF54: .word 0x00000604
_0200BF58: .word 0x04000014
_0200BF5C: .word 0x04001014
	arm_func_end MapFarSys__Build_Z9

	arm_func_start MapFarSys__Process_Z1
MapFarSys__Process_Z1: // 0x0200BF60
	stmdb sp!, {r3, lr}
	mov r0, #0xe
	bl MapFarSys__Func_200CE58
	bl MapFarSys__Func_200CEB8
	ldr r0, _0200C0D0 // =MapFarSys__sVars
	ldr r2, _0200C0D4 // =mapCamera
	ldr r0, [r0, #8]
	ldr ip, [r2, #0x38]
	ldr r3, [r0, #0x10]
	ldr r1, _0200C0D8 // =gameState
	add r3, ip, r3
	str r3, [r2, #0x38]
	ldr ip, [r2, #0xa8]
	ldr r3, [r0, #0x18]
	add r3, ip, r3
	str r3, [r2, #0xa8]
	ldrh r1, [r1, #0x28]
	cmp r1, #0
	cmpne r1, #2
	ldmneia sp!, {r3, pc}
	cmp r1, #0
	bne _0200C0C8
	ldr r1, _0200C0D4 // =mapCamera
	ldr r2, [r1, #0xe0]
	ldr r1, [r1, #4]
	tst r2, #1
	beq _0200C03C
	cmp r1, #0x600000
	blt _0200BFF0
	ldr r2, _0200C0DC // =0x0210E2A4
	ldr r1, _0200C0D0 // =MapFarSys__sVars
	str r2, [r0, #0x62c]
	ldr r1, [r1, #8]
	ldr r0, [r1, #0x62c]
	str r0, [r1, #0x620]
	b _0200C0C8
_0200BFF0:
	ldr r1, _0200C0D8 // =gameState
	ldr r1, [r1, #0x10]
	and r1, r1, #0x420
	cmp r1, #0x420
	bne _0200C020
	ldr r2, _0200C0E0 // =0x0210E23C
	ldr r1, _0200C0D0 // =MapFarSys__sVars
	str r2, [r0, #0x62c]
	ldr r1, [r1, #8]
	ldr r0, [r1, #0x62c]
	str r0, [r1, #0x620]
	b _0200C0C8
_0200C020:
	ldr r2, _0200C0E4 // =0x0210E1D4
	ldr r1, _0200C0D0 // =MapFarSys__sVars
	str r2, [r0, #0x62c]
	ldr r1, [r1, #8]
	ldr r0, [r1, #0x62c]
	str r0, [r1, #0x620]
	b _0200C0C8
_0200C03C:
	cmp r1, #0x600000
	ldrge r1, _0200C0DC // =0x0210E2A4
	strge r1, [r0, #0x620]
	bge _0200C06C
	ldr r1, _0200C0D8 // =gameState
	ldr r1, [r1, #0x10]
	and r1, r1, #0x420
	cmp r1, #0x420
	ldreq r1, _0200C0E0 // =0x0210E23C
	streq r1, [r0, #0x620]
	ldrne r1, _0200C0E4 // =0x0210E1D4
	strne r1, [r0, #0x620]
_0200C06C:
	ldr r0, _0200C0D4 // =mapCamera
	ldr r0, [r0, #0x74]
	cmp r0, #0x600000
	blt _0200C090
	ldr r0, _0200C0D0 // =MapFarSys__sVars
	ldr r1, _0200C0DC // =0x0210E2A4
	ldr r0, [r0, #8]
	str r1, [r0, #0x62c]
	b _0200C0C8
_0200C090:
	ldr r0, _0200C0D8 // =gameState
	ldr r0, [r0, #0x10]
	and r0, r0, #0x420
	cmp r0, #0x420
	bne _0200C0B8
	ldr r0, _0200C0D0 // =MapFarSys__sVars
	ldr r1, _0200C0E0 // =0x0210E23C
	ldr r0, [r0, #8]
	str r1, [r0, #0x62c]
	b _0200C0C8
_0200C0B8:
	ldr r0, _0200C0D0 // =MapFarSys__sVars
	ldr r1, _0200C0E4 // =0x0210E1D4
	ldr r0, [r0, #8]
	str r1, [r0, #0x62c]
_0200C0C8:
	bl MapFarSys__ProcessScroll
	ldmia sp!, {r3, pc}
	.align 2, 0
_0200C0D0: .word MapFarSys__sVars
_0200C0D4: .word mapCamera
_0200C0D8: .word gameState
_0200C0DC: .word 0x0210E2A4
_0200C0E0: .word 0x0210E23C
_0200C0E4: .word 0x0210E1D4
	arm_func_end MapFarSys__Process_Z1

	arm_func_start MapFarSys__Process_Z2
MapFarSys__Process_Z2: // 0x0200C0E8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov lr, #0
	mov r0, #0x1d0
	ldr r1, _0200C1A0 // =0x0210E094
	ldr r3, _0200C1A4 // =0x0210E160
	ldr r6, _0200C1A8 // =MapFarSys__sVars
	mov r4, lr
	mov r2, r0
	mov ip, #1
_0200C10C:
	ldr r7, [r6, #8]
	ldr r5, [r7, #0]
	tst r5, ip, lsl lr
	beq _0200C17C
	add r5, r7, lr, lsl #1
	add r5, r5, #0x600
	ldrh r5, [r5, #0x38]
	cmp r5, #0
	beq _0200C13C
	cmp r5, #1
	beq _0200C154
	b _0200C168
_0200C13C:
	add r5, r7, r4
	str r3, [r5, #0x620]
	ldr r5, [r6, #8]
	add r5, r5, lr, lsl #2
	str r2, [r5, #8]
	b _0200C168
_0200C154:
	add r5, r7, r4
	str r1, [r5, #0x620]
	ldr r5, [r6, #8]
	add r5, r5, lr, lsl #2
	str r0, [r5, #8]
_0200C168:
	ldr r8, [r6, #8]
	mvn r5, ip, lsl lr
	ldr r7, [r8, #0]
	and r5, r7, r5
	str r5, [r8]
_0200C17C:
	add lr, lr, #1
	cmp lr, #2
	add r4, r4, #0xc
	blt _0200C10C
	mov r0, #0xe
	bl MapFarSys__Func_200CE58
	bl MapFarSys__Func_200CEB8
	bl MapFarSys__ProcessScroll
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0200C1A0: .word 0x0210E094
_0200C1A4: .word 0x0210E160
_0200C1A8: .word MapFarSys__sVars
	arm_func_end MapFarSys__Process_Z2

	arm_func_start MapFarSys__Process_Z3
MapFarSys__Process_Z3: // 0x0200C1AC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	ldr r0, _0200C490 // =mapCamera
	ldr r1, _0200C494 // =MapFarSys__sVars
	ldr r2, [r0, #0xe0]
	ldr r0, [r1, #8]
	tst r2, #1
	movne r10, #0x1d0
	mov r5, #0
	moveq r10, #0xc0
	str r0, [sp, #0x1c]
	cmp r5, #2
	bge _0200C474
	sub r0, r10, #0xe0
	str r0, [sp, #0x18]
_0200C1E8:
	ldr r0, _0200C494 // =MapFarSys__sVars
	ldr r1, [r0, #8]
	and r0, r5, #0xff
	add r1, r1, r5, lsl #3
	ldr r7, [r1, #0x10]
	bl RenderCore_GetDMASrc
	mov r6, r0
	ldr r0, _0200C490 // =mapCamera
	mov r1, #0x70
	mla r4, r5, r1, r0
	ldr r1, [r4, #8]
	ldr r0, [r0, #0xe0]
	ldrh r9, [r4, #0x6e]
	mov r8, r1, asr #0xc
	tst r0, #1
	beq _0200C234
	bl MapSys__GetCameraA
	cmp r4, r0
	subne r8, r8, #0x110
_0200C234:
	sub r8, r9, r8
	cmp r8, r10
	bge _0200C290
	ldr r0, _0200C498 // =mapCamera+0x00000100
	ldrh r0, [r0, #0x2c]
	sub r0, r0, r10
	sub r1, r9, r0
	sub r0, r8, r1
	mov r0, r0, lsl #0xc
	sub r1, r10, r1
	bl FX_DivS32
	mov r1, #0
	mov r3, r0
	str r1, [sp]
	ldr r0, [sp, #0x18]
	add r1, r10, #0x30
	mov r2, #0x1000
	bl Unknown2051334__Func_2051534
	mov r9, r0
	sub r0, r9, r8
	cmp r0, #0x30
	addlt r9, r8, #0x30
	b _0200C294
_0200C290:
	add r9, r8, #0x30
_0200C294:
	bl MapSys__GetCameraA
	cmp r4, r0
	beq _0200C2B0
	ldr r0, _0200C490 // =mapCamera
	ldr r0, [r0, #0xe0]
	tst r0, #1
	bne _0200C2B8
_0200C2B0:
	mov r11, #0
	b _0200C2BC
_0200C2B8:
	mov r11, #0x110
_0200C2BC:
	ldr r0, _0200C490 // =mapCamera
	ldr r0, [r0, #0xe0]
	tst r0, #1
	beq _0200C2DC
	bl MapSys__GetCameraA
	cmp r0, r4
	subne r8, r8, #0x110
	subne r9, r9, #0x110
_0200C2DC:
	cmp r8, #0
	ble _0200C334
	ldr r1, [r4, #4]
	cmp r8, #0xc0
	add r1, r1, r7, lsl #4
	suble r0, r8, #1
	str r1, [sp]
	mov r1, #0x100
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp, #8]
	ldr r1, _0200C49C // =0x0210E140
	movgt r2, #0xbf
	movle r0, r0, lsl #0x10
	movle r2, r0, lsr #0x10
	rsb r0, r11, #0
	mov r0, r0, lsl #0x10
	mov r3, r0, asr #0x10
	str r1, [sp, #0xc]
	mov r0, r6
	mov r1, #0
	bl MapFarSys__Func_200D144
_0200C334:
	cmp r8, #0xc0
	bge _0200C39C
	cmp r9, #0
	ble _0200C39C
	ldr r3, [r4, #4]
	cmp r8, #0
	add r3, r3, r7, lsl #4
	str r3, [sp]
	mov r3, #0x100
	str r3, [sp, #4]
	mov r3, #0
	str r3, [sp, #8]
	ldr r3, _0200C4A0 // =0x0210E0A4
	movlt r1, #0
	movge r0, r8, lsl #0x10
	movge r1, r0, lsr #0x10
	cmp r9, #0xc0
	suble r0, r9, #1
	str r3, [sp, #0xc]
	mov r3, r8, lsl #0x10
	movgt r2, #0xbf
	movle r0, r0, lsl #0x10
	movle r2, r0, lsr #0x10
	mov r0, r6
	mov r3, r3, asr #0x10
	bl MapFarSys__Func_200D144
_0200C39C:
	cmp r9, #0xc0
	bge _0200C3EC
	ldr r2, [r4, #4]
	cmp r9, #0
	add r2, r2, r7, lsl #4
	str r2, [sp]
	mov r2, #0x100
	str r2, [sp, #4]
	mov r2, #0x200
	str r2, [sp, #8]
	ldr r2, _0200C4A4 // =0x0210E0D8
	mov r3, r9, lsl #0x10
	str r2, [sp, #0xc]
	movlt r1, #0
	movge r0, r9, lsl #0x10
	movge r1, r0, lsr #0x10
	mov r0, r6
	mov r2, #0xbf
	mov r3, r3, asr #0x10
	bl MapFarSys__Func_200D144
_0200C3EC:
	cmp r8, #0xc0
	bge _0200C460
	cmp r8, #0
	rsblt r0, r8, #0
	movlt r1, #0
	movge r0, r8, lsl #0x10
	movge r1, r0, lsr #0x10
	movge r0, #0
	mov r0, r0, lsl #4
	add r4, r0, #0x2000
	mov r2, #0
	stmia sp, {r2, r4}
	sub r0, r1, r9
	mov r2, #0x40
	str r2, [sp, #8]
	mov r2, #0x8000
	str r2, [sp, #0xc]
	mov r2, #0
	str r2, [sp, #0x10]
	ldr r2, [sp, #0x1c]
	mov r3, r0, lsl #0xf
	ldr r4, [r2, #0x63c]
	mov r0, r6
	add r3, r3, r4, lsl #13
	str r3, [sp, #0x14]
	and r1, r1, #0xff
	mov r2, #0xbf
	mov r3, #0
	bl FontDMAControl__Func_20520B0
_0200C460:
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r5, r5, #1
	cmp r5, #2
	blt _0200C1E8
_0200C474:
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp, #0x1c]
	str r1, [r0, #0x63c]
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0200C490: .word mapCamera
_0200C494: .word MapFarSys__sVars
_0200C498: .word mapCamera+0x00000100
_0200C49C: .word 0x0210E140
_0200C4A0: .word 0x0210E0A4
_0200C4A4: .word 0x0210E0D8
	arm_func_end MapFarSys__Process_Z3

	arm_func_start MapFarSys__Process_Z4
MapFarSys__Process_Z4: // 0x0200C4A8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	ldr r0, _0200C66C // =_0210E074
	ldr r1, _0200C670 // =MapFarSys__sVars
	ldrh r9, [r0, #0x18]
	ldrh r8, [r0, #0x1a]
	ldrh r7, [r0, #0x1c]
	ldrh r6, [r0, #0x1e]
	ldrh r5, [r0, #0x10]
	ldrh r4, [r0, #0x12]
	ldrh r3, [r0, #0x14]
	ldrh r2, [r0, #0x16]
	ldr r1, [r1, #8]
	mov r0, #0xe
	strh r9, [sp, #0xc]
	strh r8, [sp, #0xe]
	strh r7, [sp, #0x10]
	strh r6, [sp, #0x12]
	strh r5, [sp, #4]
	strh r4, [sp, #6]
	strh r3, [sp, #8]
	strh r2, [sp, #0xa]
	str r1, [sp]
	bl MapFarSys__Func_200CE58
	bl MapFarSys__Func_200CEB8
	ldr r0, _0200C670 // =MapFarSys__sVars
	ldr r1, _0200C674 // =mapCamera
	ldr r4, [r0, #8]
	ldr r3, [r1, #0x38]
	ldr r2, [r4, #0x10]
	mov r0, #0
	add r2, r3, r2
	str r2, [r1, #0x38]
	ldr r3, [r1, #0xa8]
	ldr r2, [r4, #0x18]
	add r2, r3, r2
	str r2, [r1, #0xa8]
	ldr r1, [sp]
	add r3, sp, #4
	ldr r5, [r1, #0x63c]
	add r1, sp, #0x14
_0200C54C:
	mov r4, r0, lsl #1
	ldrsh r2, [r3, r4]
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mul r2, r5, r2
	mov r2, r2, lsr #0xc
	mov r0, r0, lsr #0x10
	strh r2, [r1, r4]
	cmp r0, #4
	blo _0200C54C
	mov r5, #0
	cmp r5, #2
	bge _0200C650
_0200C580:
	and r0, r5, #0xff
	bl RenderCore_GetDMASrc
	ldr r2, _0200C674 // =mapCamera
	mov r1, #0x70
	mla r2, r5, r1, r2
	ldr r1, [r2, #0x3c]
	ldr r2, [r2, #0x38]
	mov r1, r1, lsl #4
	mov r2, r2, asr #0xc
	mov r7, #0
	mov r6, r0
	mov r10, r7
	mov r1, r1, lsr #0x10
	mov r4, r2, lsl #0x10
	add r11, sp, #0xc
_0200C5BC:
	mov r0, r10, lsl #1
	ldrh r9, [r11, r0]
	cmp r1, r9
	bhs _0200C628
	sub r0, r9, r1
	mov r0, r0, lsl #0x10
	add r1, r7, r0, lsr #16
	cmp r1, #0xc0
	mov r8, r0, lsr #0x10
	rsbgt r0, r7, #0xc0
	movgt r0, r0, lsl #0x10
	movgt r8, r0, lsr #0x10
	cmp r8, #0
	beq _0200C618
	mov r1, r10, lsl #1
	add r0, sp, #0x14
	ldrh r0, [r0, r1]
	add r1, r6, r7, lsl #1
	mov r2, r8, lsl #1
	add r0, r0, r4, lsr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MIi_CpuClear16
_0200C618:
	add r0, r7, r8
	mov r0, r0, lsl #0x10
	mov r1, r9
	mov r7, r0, lsr #0x10
_0200C628:
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
	cmp r10, #4
	blo _0200C5BC
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r5, r5, #1
	cmp r5, #2
	blt _0200C580
_0200C650:
	ldr r0, [sp]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp]
	str r1, [r0, #0x63c]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0200C66C: .word _0210E074
_0200C670: .word MapFarSys__sVars
_0200C674: .word mapCamera
	arm_func_end MapFarSys__Process_Z4

	arm_func_start MapFarSys__Process_Z5
MapFarSys__Process_Z5: // 0x0200C678
	stmdb sp!, {r3, lr}
	mov r0, #0xe
	bl MapFarSys__Func_200CE58
	bl MapFarSys__Func_200CEB8
	ldr r1, _0200C6B8 // =MapFarSys__sVars
	ldr r0, _0200C6BC // =mapCamera
	ldr r3, [r1, #8]
	ldr r2, [r0, #0x38]
	ldr r1, [r3, #0x10]
	add r1, r2, r1
	str r1, [r0, #0x38]
	ldr r2, [r0, #0xa8]
	ldr r1, [r3, #0x18]
	add r1, r2, r1
	str r1, [r0, #0xa8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0200C6B8: .word MapFarSys__sVars
_0200C6BC: .word mapCamera
	arm_func_end MapFarSys__Process_Z5

	arm_func_start MapFarSys__Process_Z6
MapFarSys__Process_Z6: // 0x0200C6C0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x3c
	ldr r0, _0200C898 // =MapFarSys__sVars
	ldr r3, _0200C89C // =0x0210E0B4
	ldr r0, [r0, #8]
	add r5, sp, #0x16
	str r0, [sp]
	mov r2, #4
_0200C6E0:
	ldrh r1, [r3, #0]
	ldrh r0, [r3, #2]
	add r3, r3, #4
	strh r1, [r5]
	strh r0, [r5, #2]
	add r5, r5, #4
	subs r2, r2, #1
	bne _0200C6E0
	ldrh r0, [r3, #0]
	ldr r4, _0200C8A0 // =0x0210E0C6
	add r3, sp, #4
	strh r0, [r5]
	mov r2, #4
_0200C714:
	ldrh r1, [r4, #0]
	ldrh r0, [r4, #2]
	add r4, r4, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _0200C714
	ldrh r1, [r4, #0]
	mov r0, #0xe
	strh r1, [r3]
	bl MapFarSys__Func_200CE58
	bl MapFarSys__Func_200CEB8
	ldr r0, _0200C898 // =MapFarSys__sVars
	ldr r1, _0200C8A4 // =mapCamera
	ldr r4, [r0, #8]
	ldr r3, [r1, #0x38]
	ldr r2, [r4, #0x10]
	mov r0, #0
	add r2, r3, r2
	str r2, [r1, #0x38]
	ldr r3, [r1, #0xa8]
	ldr r2, [r4, #0x18]
	add r2, r3, r2
	str r2, [r1, #0xa8]
	ldr r1, [sp]
	add r3, sp, #4
	ldr r5, [r1, #0x63c]
	add r1, sp, #0x28
_0200C788:
	mov r4, r0, lsl #1
	ldrsh r2, [r3, r4]
	add r0, r0, #1
	cmp r0, #9
	mul r2, r5, r2
	mov r2, r2, lsr #0xc
	strh r2, [r1, r4]
	blt _0200C788
	mov r5, #0
	cmp r5, #2
	bge _0200C87C
_0200C7B4:
	and r0, r5, #0xff
	bl RenderCore_GetDMASrc
	ldr r2, _0200C8A4 // =mapCamera
	mov r1, #0x70
	mla r2, r5, r1, r2
	ldr r1, [r2, #0x3c]
	ldr r2, [r2, #0x38]
	mov r1, r1, lsl #4
	mov r2, r2, asr #0xc
	mov r7, #0
	mov r6, r0
	mov r10, r7
	mov r1, r1, lsr #0x10
	mov r4, r2, lsl #0x10
	add r11, sp, #0x16
_0200C7F0:
	mov r0, r10, lsl #1
	ldrh r9, [r11, r0]
	cmp r1, r9
	bhs _0200C85C
	sub r0, r9, r1
	mov r0, r0, lsl #0x10
	add r1, r7, r0, lsr #16
	cmp r1, #0xc0
	mov r8, r0, lsr #0x10
	rsbgt r0, r7, #0xc0
	movgt r0, r0, lsl #0x10
	movgt r8, r0, lsr #0x10
	cmp r8, #0
	beq _0200C84C
	mov r1, r10, lsl #1
	add r0, sp, #0x28
	ldrh r0, [r0, r1]
	add r1, r6, r7, lsl #1
	mov r2, r8, lsl #1
	add r0, r0, r4, lsr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MIi_CpuClear16
_0200C84C:
	add r0, r7, r8
	mov r0, r0, lsl #0x10
	mov r1, r9
	mov r7, r0, lsr #0x10
_0200C85C:
	add r10, r10, #1
	cmp r10, #9
	blt _0200C7F0
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r5, r5, #1
	cmp r5, #2
	blt _0200C7B4
_0200C87C:
	ldr r0, [sp]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp]
	str r1, [r0, #0x63c]
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0200C898: .word MapFarSys__sVars
_0200C89C: .word 0x0210E0B4
_0200C8A0: .word 0x0210E0C6
_0200C8A4: .word mapCamera
	arm_func_end MapFarSys__Process_Z6

	arm_func_start MapFarSys__Process_Z7
MapFarSys__Process_Z7: // 0x0200C8A8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x40
	ldr r0, _0200CC7C // =gameState
	ldr r1, _0200CC80 // =MapFarSys__sVars
	ldr r2, [r0, #0x10]
	ldr r0, [r1, #8]
	str r0, [sp, #0x2c]
	and r0, r2, #0x420
	cmp r0, #0x420
	bne _0200C8E4
	ldr r0, _0200CC84 // =0x0210E1AC
	str r0, [sp, #0x28]
	ldr r0, _0200CC88 // =0x0210E108
	str r0, [sp, #0x24]
	b _0200C8F4
_0200C8E4:
	ldr r0, _0200CC8C // =0x0210E184
	str r0, [sp, #0x28]
	ldr r0, _0200CC90 // =0x0210E0F0
	str r0, [sp, #0x24]
_0200C8F4:
	ldr r1, _0200CC94 // =mapCamera
	ldr r0, [r1, #0xe0]
	tst r0, #1
	beq _0200C91C
	bl MapSys__GetCameraA
	str r0, [sp, #0x38]
	bl MapSys__GetCameraA
	str r0, [sp, #0x3c]
	mov r7, #0x1d0
	b _0200C92C
_0200C91C:
	ldr r0, _0200CC98 // =mapCamera+0x00000070
	str r1, [sp, #0x38]
	str r0, [sp, #0x3c]
	mov r7, #0xc0
_0200C92C:
	mov r0, #0x1c
	bl MapFarSys__Func_200CE58
	ldr r0, _0200CC80 // =MapFarSys__sVars
	ldr r10, _0200CC94 // =mapCamera
	ldr r3, [r0, #8]
	rsb r0, r7, #0x1e0
	ldr r2, [r10, #0x38]
	ldr r1, [r3, #0x10]
	str r0, [sp, #0x20]
	add r0, r2, r1
	str r0, [r10, #0x38]
	rsb r0, r7, #0x208
	ldr r2, [r10, #0xa8]
	ldr r1, [r3, #0x18]
	str r0, [sp, #0x1c]
	add r0, r2, r1
	mvn r4, #0xbf
	str r0, [r10, #0xa8]
	add r0, r4, #0xb8
	mov r5, #0
	str r0, [sp, #0x34]
	str r0, [sp, #0x30]
_0200C984:
	add r0, sp, #0x38
	ldr r0, [r0, r5, lsl #2]
	ldrh r9, [r10, #0x6e]
	str r0, [sp, #0x18]
	ldr r3, [r10, #8]
	ldr r0, [r0, #8]
	cmp r9, #0
	sub r8, r3, r0
	beq _0200C9BC
	ldr r2, _0200CC9C // =mapCamera+0x00000100
	sub r1, r9, #8
	ldrh r2, [r2, #0x2c]
	sub r2, r2, r1
	b _0200C9CC
_0200C9BC:
	ldr r1, _0200CC9C // =mapCamera+0x00000100
	ldr r9, _0200CCA0 // =0x0000FFFF
	ldrh r1, [r1, #0x2c]
	mov r2, #0
_0200C9CC:
	mov ip, r9, lsl #0xc
	add r11, r0, r7, lsl #12
	sub r6, ip, #0x8000
	cmp r11, r6
	bgt _0200CA00
	ldr r0, [sp, #0x20]
	sub r1, r1, r7
	mul r0, r3, r0
	bl FX_DivS32
	add r0, r8, r0
	str r0, [r10, #0x3c]
	mov r6, #0xbf
	b _0200CAB4
_0200CA00:
	cmp r0, r1, lsl #12
	bge _0200CA58
	rsb r1, r1, r3, asr #12
	rsb r6, r1, #0
	cmp r6, #0
	ble _0200CA48
	sub r1, r9, #8
	sub r9, r1, r0, asr #12
	sub r0, r7, r9
	mov r0, r0, lsl #0x12
	mov r1, r7
	bl FX_DivS32
	mov r1, r9, lsl #0xc
	rsb r1, r1, #0x1e0000
	sub r0, r1, r0
	add r0, r8, r0
	str r0, [r10, #0x3c]
	b _0200CAB4
_0200CA48:
	rsb r0, r6, #0
	mov r0, r0, lsl #0xc
	str r0, [r10, #0x3c]
	b _0200CAB4
_0200CA58:
	cmp r0, ip
	bge _0200CA78
	rsb r0, r1, r3, asr #12
	rsb r6, r0, #0
	rsb r0, r6, #0
	mov r0, r0, lsl #0xc
	str r0, [r10, #0x3c]
	b _0200CAB4
_0200CA78:
	sub r0, r0, r1, lsl #12
	ldr r1, [sp, #0x1c]
	sub r0, r0, #0x8000
	mul r0, r1, r0
	sub r1, r2, #8
	sub r1, r1, r7
	bl FX_DivS32
	add r0, r0, #0x8000
	add r0, r8, r0
	str r0, [r10, #0x3c]
	ldr r0, [sp, #0x18]
	ldr r0, [r0, #8]
	sub r0, r9, r0, asr #12
	sub r0, r0, #8
	sub r6, r0, r8, asr #12
_0200CAB4:
	and r0, r5, #0xff
	bl RenderCore_GetDMASrc
	mov r8, r0
	cmp r6, #0
	ble _0200CB14
	ldr r1, [r10, #0x38]
	cmp r6, #0xbf
	str r1, [sp]
	mov r1, #0x1000
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp, #8]
	ldr r1, [sp, #0x28]
	movgt r2, #0xbf
	str r1, [sp, #0xc]
	ldr r3, [r10, #0x3c]
	movle r0, r6, lsl #0x10
	rsb r3, r3, #0
	mov r3, r3, lsl #4
	movle r2, r0, lsr #0x10
	mov r0, r8
	mov r1, #0
	mov r3, r3, asr #0x10
	bl MapFarSys__Func_200D144
_0200CB14:
	cmp r6, #0xc0
	bge _0200CC48
	cmp r6, #0
	bgt _0200CB48
	ldr r0, [r10, #0x3c]
	add r2, r6, #8
	rsb r0, r0, #0
	mov r0, r0, lsl #4
	mov r9, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r1, #0
	mov r0, r0, asr #0x10
	b _0200CB5C
_0200CB48:
	mov r0, r6, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r9, r0, asr #0x10
	add r0, r1, #8
	and r0, r0, #0xff
_0200CB5C:
	cmp r0, #0
	movlt r0, #0
	blt _0200CB70
	cmp r0, #0xbf
	movgt r0, #0xbf
_0200CB70:
	ldr r2, [r10, #0x38]
	mov r0, r0, lsl #0x10
	mov r2, r2, lsl #1
	str r2, [sp]
	mov r2, #0x1000
	str r2, [sp, #4]
	mov r2, #0
	str r2, [sp, #8]
	ldr r2, [sp, #0x24]
	mov r11, r0, asr #0x10
	str r2, [sp, #0xc]
	mov r0, r8
	mov r2, #0xbf
	mov r3, r9
	bl MapFarSys__Func_200D144
	ldr r0, [sp, #0x30]
	mov r2, #0x1800
	cmp r6, r0
	ldr r0, [sp, #0x2c]
	mov r3, #0x18000
	ldr r0, [r0, #0x63c]
	mov r6, r0, lsl #0xd
	bge _0200CC14
	ldr r0, [sp, #0x34]
	sub r1, r0, r9
	mul r3, r1, r4
	mov r0, r2
	add r2, r0, r1, lsl #6
	mov r0, #0x18000
	adds r3, r0, r3
	movmi r3, #0
	cmp r1, #0x200
	ldrgt r0, _0200CCA4 // =0x017F4000
	bgt _0200CC10
	mov r0, #0x18000
	add r9, r1, #1
	mul r0, r1, r0
	mul r1, r9, r1
	mul r9, r1, r4
	add r0, r0, r9, asr #1
_0200CC10:
	add r6, r6, r0
_0200CC14:
	mov r0, r8
	mov r8, #0
	str r8, [sp]
	str r2, [sp, #4]
	mov r2, #0x40
	str r2, [sp, #8]
	str r3, [sp, #0xc]
	str r4, [sp, #0x10]
	and r1, r11, #0xff
	mov r2, #0xbf
	mov r3, r8
	str r6, [sp, #0x14]
	bl FontDMAControl__Func_20520B0
_0200CC48:
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r10, r10, #0x70
	add r5, r5, #1
	cmp r5, #2
	blt _0200C984
	ldr r0, [sp, #0x2c]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp, #0x2c]
	str r1, [r0, #0x63c]
	add sp, sp, #0x40
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0200CC7C: .word gameState
_0200CC80: .word MapFarSys__sVars
_0200CC84: .word 0x0210E1AC
_0200CC88: .word 0x0210E108
_0200CC8C: .word 0x0210E184
_0200CC90: .word 0x0210E0F0
_0200CC94: .word mapCamera
_0200CC98: .word mapCamera+0x00000070
_0200CC9C: .word mapCamera+0x00000100
_0200CCA0: .word 0x0000FFFF
_0200CCA4: .word 0x017F4000
	arm_func_end MapFarSys__Process_Z7

	arm_func_start MapFarSys__Process_Z9
MapFarSys__Process_Z9: // 0x0200CCA8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	ldr r0, _0200CE4C // =_0210E074
	ldr r1, _0200CE50 // =MapFarSys__sVars
	ldrh r7, [r0, #0xa]
	ldrh r6, [r0, #0xc]
	ldrh r5, [r0, #0xe]
	ldrh r4, [r0, #4]
	ldrh r3, [r0, #6]
	ldrh r2, [r0, #8]
	ldr r1, [r1, #8]
	mov r0, #0xe
	strh r7, [sp, #0xa]
	strh r6, [sp, #0xc]
	strh r5, [sp, #0xe]
	strh r4, [sp, #4]
	strh r3, [sp, #6]
	strh r2, [sp, #8]
	str r1, [sp]
	bl MapFarSys__Func_200CE58
	bl MapFarSys__Func_200CEB8
	ldr r0, _0200CE50 // =MapFarSys__sVars
	ldr r1, _0200CE54 // =mapCamera
	ldr r4, [r0, #8]
	ldr r3, [r1, #0x38]
	ldr r2, [r4, #0x10]
	mov r0, #0
	add r2, r3, r2
	str r2, [r1, #0x38]
	ldr r3, [r1, #0xa8]
	ldr r2, [r4, #0x18]
	add r2, r3, r2
	str r2, [r1, #0xa8]
	ldr r1, [sp]
	add r3, sp, #4
	ldr r5, [r1, #0x63c]
	add r1, sp, #0x10
_0200CD3C:
	mov r4, r0, lsl #1
	ldrsh r2, [r3, r4]
	add r0, r0, #1
	cmp r0, #3
	mul r2, r5, r2
	mov r2, r2, lsr #0xc
	strh r2, [r1, r4]
	blt _0200CD3C
	mov r5, #0
	cmp r5, #2
	bge _0200CE30
_0200CD68:
	and r0, r5, #0xff
	bl RenderCore_GetDMASrc
	ldr r2, _0200CE54 // =mapCamera
	mov r1, #0x70
	mla r2, r5, r1, r2
	ldr r1, [r2, #0x3c]
	ldr r2, [r2, #0x38]
	mov r1, r1, lsl #4
	mov r2, r2, asr #0xc
	mov r7, #0
	mov r6, r0
	mov r10, r7
	mov r1, r1, lsr #0x10
	mov r4, r2, lsl #0x10
	add r11, sp, #0xa
_0200CDA4:
	mov r0, r10, lsl #1
	ldrh r9, [r11, r0]
	cmp r1, r9
	bhs _0200CE10
	sub r0, r9, r1
	mov r0, r0, lsl #0x10
	add r1, r7, r0, lsr #16
	cmp r1, #0xc0
	mov r8, r0, lsr #0x10
	rsbgt r0, r7, #0xc0
	movgt r0, r0, lsl #0x10
	movgt r8, r0, lsr #0x10
	cmp r8, #0
	beq _0200CE00
	mov r1, r10, lsl #1
	add r0, sp, #0x10
	ldrh r0, [r0, r1]
	add r1, r6, r7, lsl #1
	mov r2, r8, lsl #1
	add r0, r0, r4, lsr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MIi_CpuClear16
_0200CE00:
	add r0, r7, r8
	mov r0, r0, lsl #0x10
	mov r1, r9
	mov r7, r0, lsr #0x10
_0200CE10:
	add r10, r10, #1
	cmp r10, #3
	blt _0200CDA4
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r5, r5, #1
	cmp r5, #2
	blt _0200CD68
_0200CE30:
	ldr r0, [sp]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp]
	str r1, [r0, #0x63c]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0200CE4C: .word _0210E074
_0200CE50: .word MapFarSys__sVars
_0200CE54: .word mapCamera
	arm_func_end MapFarSys__Process_Z9

	arm_func_start MapFarSys__Func_200CE58
MapFarSys__Func_200CE58: // 0x0200CE58
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl CheckStageUsesLaps
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r4, _0200CEB0 // =mapCamera
	ldr r0, [r4, #0x40]
	tst r0, #1
	bne _0200CE8C
	ldr r0, [r4, #4]
	mov r1, r5
	bl _s32_div_f
	str r0, [r4, #0x38]
_0200CE8C:
	ldr r4, _0200CEB4 // =mapCamera+0x00000070
	ldr r0, [r4, #0x40]
	tst r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #4]
	mov r1, r5
	bl _s32_div_f
	str r0, [r4, #0x38]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0200CEB0: .word mapCamera
_0200CEB4: .word mapCamera+0x00000070
	arm_func_end MapFarSys__Func_200CE58

	arm_func_start MapFarSys__Func_200CEB8
MapFarSys__Func_200CEB8: // 0x0200CEB8
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, _0200CFC0 // =mapCamera
	ldr r0, [r4, #0xe0]
	tst r0, #1
	beq _0200CF48
	bl MapSys__GetCameraA
	mov r5, r0
	bl MapSys__GetCameraB
	ldr r1, _0200CFC4 // =MapFarSys__sVars
	ldr r2, [r5, #0x40]
	ldr r1, [r1, #8]
	mov r6, r0
	tst r2, #1
	ldr r4, [r1, #8]
	bne _0200CF14
	ldr r2, [r5, #8]
	sub r0, r4, #0x1d0
	ldr r1, _0200CFC8 // =mapCamera+0x00000100
	mul r0, r2, r0
	ldrh r1, [r1, #0x2c]
	sub r1, r1, #0xc0
	bl FX_DivS32
	str r0, [r5, #0x3c]
_0200CF14:
	ldr r0, [r6, #0x40]
	tst r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r2, [r5, #8]
	sub r0, r4, #0x1d0
	ldr r1, _0200CFC8 // =mapCamera+0x00000100
	mul r0, r2, r0
	ldrh r1, [r1, #0x2c]
	sub r1, r1, #0xc0
	bl FX_DivS32
	add r0, r0, #0x110000
	str r0, [r6, #0x3c]
	ldmia sp!, {r4, r5, r6, pc}
_0200CF48:
	ldr r0, _0200CFC4 // =MapFarSys__sVars
	ldr r1, [r4, #0x40]
	ldr r0, [r0, #8]
	tst r1, #1
	ldr r0, [r0, #8]
	bne _0200CF80
	ldr r2, [r4, #8]
	sub r0, r0, #0x1d0
	ldr r1, _0200CFC8 // =mapCamera+0x00000100
	mul r0, r2, r0
	ldrh r1, [r1, #0x2c]
	sub r1, r1, #0xc0
	bl FX_DivS32
	str r0, [r4, #0x3c]
_0200CF80:
	ldr r4, _0200CFCC // =mapCamera+0x00000070
	ldr r0, _0200CFC4 // =MapFarSys__sVars
	ldr r1, [r4, #0x40]
	ldr r0, [r0, #8]
	tst r1, #1
	ldr r0, [r0, #0xc]
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r2, [r4, #8]
	sub r0, r0, #0x1d0
	ldr r1, _0200CFC8 // =mapCamera+0x00000100
	mul r0, r2, r0
	ldrh r1, [r1, #0x2c]
	sub r1, r1, #0xc0
	bl FX_DivS32
	str r0, [r4, #0x3c]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0200CFC0: .word mapCamera
_0200CFC4: .word MapFarSys__sVars
_0200CFC8: .word mapCamera+0x00000100
_0200CFCC: .word mapCamera+0x00000070
	arm_func_end MapFarSys__Func_200CEB8

	arm_func_start MapFarSys__ProcessScroll
MapFarSys__ProcessScroll: // 0x0200CFD0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	ldr r0, _0200D138 // =mapCamera
	mov r4, #0
	ldr r1, [r0, #0x3c]
	str r0, [sp]
	ldr r0, [r0, #0xac]
	mov r1, r1, asr #0xc
	mov r0, r0, asr #0xc
	str r4, [sp, #4]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
_0200D000:
	ldr r0, _0200D138 // =mapCamera
	mov r1, #0
	ldr r0, [r0, #0xe0]
	tst r0, #1
	beq _0200D024
	ldr r0, _0200D13C // =MapFarSys__sVars
	ldr r0, [r0, #8]
	ldr r8, [r0, #0x620]
	b _0200D03C
_0200D024:
	ldr r0, _0200D13C // =MapFarSys__sVars
	ldr r3, [r0, #8]
	ldr r0, [sp, #4]
	add r2, r3, r0
	ldr r8, [r2, #0x620]
	add r0, r3, r4, lsl #2
_0200D03C:
	ldr r3, [r0, #8]
	add r0, sp, #8
	ldr r0, [r0, r4, lsl #2]
	b _0200D060
_0200D04C:
	add r2, r1, r2
	cmp r2, r0
	bgt _0200D074
	mov r1, r2
	add r8, r8, #4
_0200D060:
	cmp r1, r3
	bge _0200D074
	ldrh r2, [r8, #2]
	cmp r2, #0
	bne _0200D04C
_0200D074:
	add r0, sp, #8
	ldr r3, [r0, r4, lsl #2]
	ldrh r2, [r8, #0]
	sub r6, r3, r1
	and r0, r4, #0xff
	sub r1, r6, r2
	mov r1, r1, lsl #0x17
	mov r2, r1, lsr #0xb
	ldr r1, [sp]
	mov r7, r6
	str r2, [r1, #0x3c]
	bl RenderCore_GetDMASrc
	ldr r11, _0200D140 // =0x000001FF
	mov r9, r0
	mov r5, #0
_0200D0B0:
	ldrh r0, [r8, #2]
	mov r1, r9
	sub r10, r0, r7
	add r0, r5, r10
	cmp r0, #0xc0
	ldrh r0, [r8, #0]
	rsbge r10, r5, #0xc0
	mov r2, r10, lsl #1
	add r0, r6, r0
	and r0, r0, r11
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MIi_CpuClear16
	ldrh r0, [r8, #2]
	add r5, r5, r10
	mov r7, #0
	cmp r5, #0xc0
	sub r6, r6, r0
	add r8, r8, #4
	add r9, r9, r10, lsl #1
	blt _0200D0B0
	and r0, r4, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	ldr r0, [sp, #4]
	add r4, r4, #1
	add r0, r0, #0xc
	str r0, [sp, #4]
	ldr r0, [sp]
	cmp r4, #2
	add r0, r0, #0x70
	str r0, [sp]
	blt _0200D000
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0200D138: .word mapCamera
_0200D13C: .word MapFarSys__sVars
_0200D140: .word 0x000001FF
	arm_func_end MapFarSys__ProcessScroll

	arm_func_start MapFarSys__Func_200D144
MapFarSys__Func_200D144: // 0x0200D144
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r5, #0
	mov r10, r2
	mov r9, r3
	ldr r8, [sp, #0x30]
	ldr r7, [sp, #0x34]
	ldr r11, [sp, #0x38]
	ldr r4, [sp, #0x3c]
	str r0, [sp]
	str r1, [sp, #4]
	cmp r9, r10
	mov r6, r5
	addgt sp, sp, #8
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0200D180:
	ldrh r2, [r4, #0]
	ldr r0, [sp, #4]
	ldrh r1, [r4, #4]
	cmp r9, r0
	mul r0, r1, r2
	mov r0, r0, lsl #0x10
	blt _0200D240
	cmp r6, #0
	moveq r6, r2
	b _0200D228
_0200D1A8:
	smull r1, r0, r8, r7
	ldrh r3, [r4, #2]
	ldrh r2, [r4, #4]
	add r3, r3, r5
	sub r5, r2, r5
	sub r2, r3, r9
	adds r3, r1, #0x800
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	adc r0, r0, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	ldr r0, _0200D2C4 // =0x000001FF
	mov r2, r2, lsl #0x17
	and r0, r0, r1, asr #12
	add r1, r9, r5
	cmp r1, r10
	subhi r1, r10, r9
	addhi r5, r1, #1
	ldr r1, [sp]
	orr r0, r0, r2, lsr #7
	add r1, r1, r9, lsl #2
	mov r2, r5, lsl #2
	bl MIi_CpuClear32
	ldrh r1, [r4, #6]
	sub r0, r6, #1
	mov r0, r0, lsl #0x10
	add r9, r9, r5
	add r7, r7, r11
	add r8, r8, r1, lsl #12
	mov r6, r0, lsr #0x10
	mov r5, #0
_0200D228:
	cmp r9, r10
	bgt _0200D238
	cmp r6, #0
	bne _0200D1A8
_0200D238:
	add r4, r4, #8
	b _0200D2B4
_0200D240:
	ldr r3, [sp, #4]
	add r0, r9, r0, lsr #16
	cmp r0, r3
	ble _0200D29C
	mov r0, r3
	sub r5, r0, r9
	mov r0, r5
	bl FX_DivS32
	ldrh r3, [r4, #4]
	ldrh r2, [r4, #6]
	ldrh r1, [r4, #0]
	mul r6, r3, r0
	mov r3, r2, lsl #0xc
	sub r2, r1, r0
	sub r5, r5, r6
	mov r1, r5, lsl #0x10
	mov r2, r2, lsl #0x10
	mla r8, r3, r0, r8
	mla r7, r11, r0, r7
	ldr r9, [sp, #4]
	mov r5, r1, lsr #0x10
	mov r6, r2, lsr #0x10
	b _0200D2B4
_0200D29C:
	ldrh r1, [r4, #6]
	mla r7, r11, r2, r7
	mov r1, r1, lsl #0xc
	mla r8, r1, r2, r8
	mov r9, r0
	add r4, r4, #8
_0200D2B4:
	cmp r9, r10
	ble _0200D180
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0200D2C4: .word 0x000001FF
	arm_func_end MapFarSys__Func_200D144

	.rodata

_0210E074: // 0x0210E074
    .word 0x3000E0
	
_0210E078: // 0x0210E078
    .hword 0x400
	
_0210E07A: // 0x0210E07A
    .hword 0x199
	
_0210E07C: // 0x0210E07C
    .hword 0
	
_0210E07E: // 0x0210E07E
    .hword 0x68
	
_0210E080: // 0x0210E080
    .hword 0xE0
	
_0210E082: // 0x0210E082
    .hword 0x200
	
_0210E084: // 0x0210E084
    .hword 0x1000
	
_0210E086: // 0x0210E086
    .hword 0xC00
	
_0210E088: // 0x0210E088
    .hword 0x800
	
_0210E08A: // 0x0210E08A
    .hword 0x400
	
_0210E08C: // 0x0210E08C
    .hword 0x40
	
_0210E08E: // 0x0210E08E
    .hword 0x94
	
_0210E090: // 0x0210E090
    .hword 0x138
	
_0210E092: // 0x0210E092
    .hword 0x200
	
_0210E094: // 0x0210E094
    .hword 0xD0, 0x80, 0xE8, 0x90, 0x140, 0xC0, 0, 0xFFFF
	
_0210E0A4: // 0x0210E0A4
    .hword 1, 0x140, 0x24, 0, 0xFFFF, 0x160, 8, 0
	
_0210E0B4: // 0x0210E0B4
    .hword 0x60
	
_0210E0B6: // 0x0210E0B6
    .hword 0xA8, 0x108, 0x170, 0x178, 0x180, 0x188, 0x1A0, 0x200
	
_0210E0C6: // 0x0210E0C6
    .hword 0xCC
	
_0210E0C8: // 0x0210E0C8
    .hword 0x199, 0x266, 0x199, 0xCC, 0x199, 0x266, 0x333, 0x400
	
_0210E0D8: // 0x0210E0D8
    .hword 1, 0x168, 0x30, 0, 1, 0x198, 0x28, 0x28, 0xFFFF, 0x1C0, 0x30, 0x28

_0210E0F0: // 0x0210E0F0
    .hword 1, 0x150, 8, 0, 3, 0x158, 0xA8, 0, 0xFFFF, 0x158, 0xA8, 0

_0210E108: // 0x0210E108
    .hword 1, 0x150, 8, 0, 3, 0x158, 0xA8, 0, 0xFFFF, 0x158, 0xA8, 0

_0210E120: // 0x0210E120
    .word 0x6008000, 0x5000000, 1, 3
	
_0210E130: // 0x0210E130
    .word 0x6208000, 0x5000400, 3, 0xF
	
_0210E140: // 0x0210E140
    .word 1, 0xC0, 0xC00001, 0x50, 0xC00001, 0x78, 0x138FFFF, 4

_0210E160: // 0x0210E160
    .word 0x80000, 0x80000, 0x80000, 0x80000, 0x80000, 0x80000, 0xE00000, 0xC00090, 0xFFFF0000

_0210E184: // 0x0210E184
    .word 4, 0x20, 0x200001, 0xA0, 0xC00001, 0x78, 0x1380003, 0x18, 0x150FFFF, 8

_0210E1AC: // 0x0210E1AC
    .word 4, 0x20, 0x200001, 0xA0, 0xC00001, 0x78, 0x1380003, 0x18, 0x150FFFF, 8

_0210E1D4: // 0x0210E1D4
    .hword 0, 0x80, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80
	.hword 0x10, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10
	.hword 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80
	.hword 0x10, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10
	.hword 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80
	.hword 0x10, 0x80, 0x10, 0x80, 0x10, 0, 0xFFFF

_0210E23C: // 0x0210E23C
    .hword 0, 0x80, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80
	.hword 0x10, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10
	.hword 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80
	.hword 0x10, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10
	.hword 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80
	.hword 0x10, 0x80, 0x10, 0x80, 0x10, 0, 0xFFFF

_0210E2A4: // 0x0210E2A4
    .hword 0x90, 8, 0x90, 8, 0x90, 8, 0x90, 8, 0x90, 8, 0x90
	.hword 8, 0x90, 0xDC, 0x14C, 0xB0, 0x1F8, 4, 0x1F8, 4, 0x1F8
	.hword 4, 0x1F8, 4, 0x1F8, 4, 0x1F8, 4, 0x1F8, 4, 0x1F8, 4
	.hword 0x1F8, 4, 0x1F8, 4, 0x1F8, 4, 0x1F8, 4, 0x1F8, 4, 0x1F8
	.hword 4, 0x1F8, 4, 0x1F8, 4, 0x1F8, 4, 0, 0xFFFF

_0210E30C: // 0x0210E30C
    .hword 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0
	.hword 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8
	.hword 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0
	.hword 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8
	.hword 0, 0x90, 0x80, 0x10, 0x80, 0x10, 0x80, 0x10, 0x80
	.hword 0x10, 0, 0xFFFF

	.data

MapFarSys__BuildTable: // 0x02118AD0
	.word MapFarSys__Build_Z1, MapFarSys__Build_Z1
	.word MapFarSys__Build_Z1, 0, MapFarSys__Build_Z2
	.word MapFarSys__Build_Z2, 0, MapFarSys__Build_Z3
	.word MapFarSys__Build_Z3, MapFarSys__Build_Z9
	.word 0, MapFarSys__Build_Z4, MapFarSys__Build_Z4
	.word 0, MapFarSys__Build_Z5, MapFarSys__Build_Z5
	.word 0, MapFarSys__Build_Z6, MapFarSys__Build_Z6
	.word MapFarSys__Build_Z9, 0, MapFarSys__Build_Z7
	.word MapFarSys__Build_Z7, 0, 0, MapFarSys__Build_Z9
	.word MapFarSys__Build_Z3, MapFarSys__Build_Z9
	.word MapFarSys__Build_Z1, MapFarSys__Build_Z1
	.word MapFarSys__Build_Z3, MapFarSys__Build_Z2
	.word MapFarSys__Build_Z2, MapFarSys__Build_Z3
	.word MapFarSys__Build_Z5, MapFarSys__Build_Z5
	.word MapFarSys__Build_Z9, MapFarSys__Build_Z4
	.word MapFarSys__Build_Z9, MapFarSys__Build_Z1
	.word MapFarSys__Build_Z2, MapFarSys__Build_Z3
	.word MapFarSys__Build_Z4, MapFarSys__Build_Z9
	.word MapFarSys__Build_Z9, MapFarSys__Build_Z9

MapFarSys__ProcessTable: // 0x02118B88 
	.word MapFarSys__Process_Z1, MapFarSys__Process_Z1
	.word MapFarSys__Process_Z1, 0, MapFarSys__Process_Z2
	.word MapFarSys__Process_Z2, 0, MapFarSys__Process_Z3
	.word MapFarSys__Process_Z3, MapFarSys__Process_Z9
	.word 0, MapFarSys__Process_Z4, MapFarSys__Process_Z4
	.word 0, MapFarSys__Process_Z5, MapFarSys__Process_Z5
	.word MapFarSys__Process_Z9, MapFarSys__Process_Z6
	.word MapFarSys__Process_Z6, 0, 0, MapFarSys__Process_Z7
	.word MapFarSys__Process_Z7, 0, 0, MapFarSys__Process_Z9
	.word MapFarSys__Process_Z3, MapFarSys__Process_Z9
	.word MapFarSys__Process_Z1, MapFarSys__Process_Z1
	.word MapFarSys__Process_Z3, MapFarSys__Process_Z2
	.word MapFarSys__Process_Z2, MapFarSys__Process_Z3
	.word MapFarSys__Process_Z5, MapFarSys__Process_Z5
	.word MapFarSys__Process_Z9, MapFarSys__Process_Z4
	.word MapFarSys__Process_Z9, MapFarSys__Process_Z1
	.word MapFarSys__Process_Z2, MapFarSys__Process_Z3
	.word MapFarSys__Process_Z4, MapFarSys__Process_Z9
	.word MapFarSys__Process_Z9, MapFarSys__Process_Z9