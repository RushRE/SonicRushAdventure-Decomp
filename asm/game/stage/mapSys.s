	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__GFXControl

	.bss
	
.public mapSystemTask
mapSystemTask: // 0x02133AA8
	.space 0x04
	
.public MapSys__files
MapSys__files: // 0x02133AAC
	.space 0x1C
	
.public mapCamera
mapCamera: // mapCamera
	.space 0x140

	.text

	arm_func_start MapSys__Init
MapSys__Init: // 0x020084D8
	stmdb sp!, {r3, r4, r5, lr}
	ldr r0, _02008514 // =0x02133BA8
	ldr r1, _02008518 // =mapCamera
	ldrh r4, [r0, #0x4a]
	ldrh r5, [r0, #0x4c]
	mov r0, #0
	mov r2, #0x140
	bl MIi_CpuClear16
	ldr r1, _02008514 // =0x02133BA8
	ldr r0, _0200851C // =mapSystemTask
	strh r4, [r1, #0x4a]
	strh r5, [r1, #0x4c]
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02008514: .word 0x02133BA8
_02008518: .word mapCamera
_0200851C: .word mapSystemTask
	arm_func_end MapSys__Init

	arm_func_start MapSys__Create
MapSys__Create: // 0x02008520
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldr r1, _020086DC // =mapCamera
	mov r0, #0
	mov r2, #0x140
	ldr r4, _020086E0 // =gameState
	bl MIi_CpuClear16
	bl MapSys__InitStageBounds
	ldr r1, _020086E4 // =0x0000FFFF
	ldr r0, _020086E8 // =mapSystemTask
	strh r1, [r0, #0xfe]
	ldrh r1, [r0, #0xfe]
	strh r1, [r0, #0x8e]
	bl IsBossStage
	cmp r0, #0
	beq _020085CC
	mov r0, r4
	ldrh r0, [r0, #0x28]
	cmp r0, #6
	beq _02008584
	cmp r0, #0xa
	beq _020085A4
	cmp r0, #0x10
	beq _020085C4
	b _02008628
_02008584:
	ldr r1, _020086EC // =0x001187BC
	ldr r0, _020086E8 // =mapSystemTask
	mov r2, #0x40000
	str r1, [r0, #0x118]
	ldr r1, _020086F0 // =0x00722543
	str r2, [r0, #0x11c]
	str r1, [r0, #0x120]
	b _02008628
_020085A4:
	ldr r1, _020086F4 // =0x00107FC0
	ldr r0, _020086E8 // =mapSystemTask
	mov r2, #0x40000
	str r1, [r0, #0x118]
	ldr r1, _020086F8 // =0x006BAA99
	str r2, [r0, #0x11c]
	str r1, [r0, #0x120]
	b _02008628
_020085C4:
	bl MapSys__SetupBoss_Zone5
	b _02008628
_020085CC:
	ldr r0, [r4, #0x10]
	tst r0, #0x20
	beq _02008608
	ldr r0, [r4, #0x20]
	cmp r0, #1
	bne _02008608
	bl MapSys__InitBoundsForVSRings
	ldr r1, _020086E8 // =mapSystemTask
	mov r2, #1
	ldr r0, _020086FC // =g_obj
	strb r2, [r1, #0xd6]
	ldr r1, [r0, #0x28]
	bic r1, r1, #0x800
	str r1, [r0, #0x28]
	b _0200861C
_02008608:
	bl MapSys__InitBoundsForStage
	ldr r0, _020086FC // =g_obj
	ldr r1, [r0, #0x28]
	orr r1, r1, #0x800
	str r1, [r0, #0x28]
_0200861C:
	ldr r1, _02008700 // =MapSys__GetCameraPositionCB
	ldr r0, _020086FC // =g_obj
	str r1, [r0, #0x40]
_02008628:
	bl IsBossStage
	cmp r0, #0
	mov r0, #0x1080
	mov r2, #0
	str r0, [sp]
	mov r4, #3
	bne _02008688
	ldr r0, _02008704 // =MapSys__Main_Zone
	str r4, [sp, #4]
	mov r4, #0x10
	ldr r1, _02008708 // =MapSys__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _020086E8 // =mapSystemTask
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	ldr r0, _0200870C // =MapSys__HandleCameraLookUpDown
	b _020086C8
_02008688:
	ldr r0, _02008710 // =MapSys__Main_Boss
	str r4, [sp, #4]
	mov r4, #0x10
	ldr r1, _02008708 // =MapSys__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _020086E8 // =mapSystemTask
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r0, #0
_020086C8:
	str r0, [r4, #0xc]
	bl InitWaterSurface
	bl MapFarSys__BuildBG
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_020086DC: .word mapCamera
_020086E0: .word gameState
_020086E4: .word 0x0000FFFF
_020086E8: .word mapSystemTask
_020086EC: .word 0x001187BC
_020086F0: .word 0x00722543
_020086F4: .word 0x00107FC0
_020086F8: .word 0x006BAA99
_020086FC: .word g_obj
_02008700: .word MapSys__GetCameraPositionCB
_02008704: .word MapSys__Main_Zone
_02008708: .word MapSys__Destructor
_0200870C: .word MapSys__HandleCameraLookUpDown
_02008710: .word MapSys__Main_Boss
	arm_func_end MapSys__Create

	arm_func_start MapSys__Func_2008714
MapSys__Func_2008714: // 0x02008714
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r7, _020087C0 // =mapSystemTask
	mov r4, #0
	ldr r0, _020087C4 // =0xFFF8FEFB
	ldr r1, [r7, #0x100]
	ldr r5, _020087C8 // =mapCamera
	and r0, r1, r0
	ldr r9, _020087CC // =0x0000FFFF
	ldr r6, _020087D0 // =0xFFFF0FCF
	str r0, [r7, #0x100]
	mov r8, r4
_02008740:
	ldrsb r0, [r5, #0x46]
	cmp r0, #1
	beq _020087AC
	ldr r0, [r5]
	and r0, r0, r6
	str r0, [r5]
	ldr r0, [r7, #0x150]
	str r0, [r5, #0x58]
	ldr r0, [r7, #0x154]
	str r0, [r5, #0x5c]
	ldr r0, [r7, #0x158]
	str r0, [r5, #0x60]
	ldr r0, [r7, #0x15c]
	str r0, [r5, #0x64]
	bl GetCurrentZoneID
	cmp r0, #0
	bne _02008794
	ldr r0, [r5]
	bic r0, r0, #0x3000000
	str r0, [r5]
	strh r9, [r5, #0x6e]
_02008794:
	strb r8, [r5, #0x6c]
	strb r8, [r5, #0x6b]
	ldrsb r0, [r5, #0x6b]
	strb r0, [r5, #0x6a]
	strb r0, [r5, #0x69]
	strb r0, [r5, #0x68]
_020087AC:
	add r4, r4, #1
	cmp r4, #2
	add r5, r5, #0x70
	blt _02008740
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020087C0: .word mapSystemTask
_020087C4: .word 0xFFF8FEFB
_020087C8: .word mapCamera
_020087CC: .word 0x0000FFFF
_020087D0: .word 0xFFFF0FCF
	arm_func_end MapSys__Func_2008714

	arm_func_start MapSys__LoadArchive_RAW
MapSys__LoadArchive_RAW: // 0x020087D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl IsBossStage
	cmp r0, #0
	bne _020087F4
	mov r0, r4
	bl MapSys__LoadZoneTiles
	ldmia sp!, {r4, pc}
_020087F4:
	bl GetCurrentZoneID
	mov r2, r0
	ldr r1, _02008810 // =MapSys__ZoneLoadBossTilesTable
	mov r0, r4
	ldr r1, [r1, r2, lsl #2]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02008810: .word MapSys__ZoneLoadBossTilesTable
	arm_func_end MapSys__LoadArchive_RAW

	arm_func_start MapSys__LoadArchive_MAP
MapSys__LoadArchive_MAP: // 0x02008814
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl IsBossStage
	cmp r0, #0
	bne _02008834
	mov r0, r4
	bl MapSys__LoadZoneMap
	b _0200884C
_02008834:
	bl GetCurrentZoneID
	mov r2, r0
	ldr r1, _02008874 // =MapSys__ZoneLoadBossMapTable
	mov r0, r4
	ldr r1, [r1, r2, lsl #2]
	blx r1
_0200884C:
	ldr r1, _02008878 // =mapSystemTask
	ldr r0, _0200887C // =0x02133BA8
	ldr r2, [r1, #0x14]
	ldrh r1, [r2]
	mov r1, r1, lsl #6
	strh r1, [r0, #0x4a]
	ldrh r1, [r2, #2]
	mov r1, r1, lsl #6
	strh r1, [r0, #0x4c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02008874: .word MapSys__ZoneLoadBossMapTable
_02008878: .word mapSystemTask
_0200887C: .word 0x02133BA8
	arm_func_end MapSys__LoadArchive_MAP

	arm_func_start MapSys__Flush
MapSys__Flush: // 0x02008880
	stmdb sp!, {r3, lr}
	ldr r0, _02008950 // =mapSystemTask
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _02008898
	bl _FreeHEAP_ITCM
_02008898:
	ldr r0, _02008950 // =mapSystemTask
	mov r1, #0
	str r1, [r0, #4]
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _020088B4
	bl _FreeHEAP_ITCM
_020088B4:
	ldr r0, _02008950 // =mapSystemTask
	mov r1, #0
	str r1, [r0, #8]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	beq _020088D0
	bl _FreeHEAP_ITCM
_020088D0:
	ldr r0, _02008950 // =mapSystemTask
	mov r1, #0
	str r1, [r0, #0xc]
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _020088EC
	bl _FreeHEAP_USER
_020088EC:
	ldr r0, _02008950 // =mapSystemTask
	mov r1, #0
	str r1, [r0, #0x10]
	ldr r0, [r0, #0x14]
	cmp r0, #0
	beq _02008908
	bl _FreeHEAP_USER
_02008908:
	ldr r0, _02008950 // =mapSystemTask
	mov r1, #0
	str r1, [r0, #0x14]
	ldr r0, [r0, #0x18]
	cmp r0, #0
	beq _02008924
	bl _FreeHEAP_USER
_02008924:
	ldr r0, _02008950 // =mapSystemTask
	mov r1, #0
	str r1, [r0, #0x18]
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	beq _02008940
	bl _FreeHEAP_USER
_02008940:
	ldr r0, _02008950 // =mapSystemTask
	mov r1, #0
	str r1, [r0, #0x1c]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02008950: .word mapSystemTask
	arm_func_end MapSys__Flush

	arm_func_start MapSys__BuildData
MapSys__BuildData: // 0x02008954
	bx lr
	arm_func_end MapSys__BuildData

	arm_func_start MapSys__Release
MapSys__Release: // 0x02008958
	bx lr
	arm_func_end MapSys__Release

	arm_func_start MapSys__DrawLayout
MapSys__DrawLayout: // 0x0200895C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x50
	mov r0, #0
	str r0, [sp, #0x34]
	ldr r0, _02008EAC // =mapCamera
	str r0, [sp, #0x24]
_02008974:
	ldr r0, [sp, #0x24]
	ldr r0, [r0]
	tst r0, #0x10000000
	bne _02008B18
	ldr r0, [sp, #0x24]
	ldrsh r1, [r0, #0x1c]
	ldr r2, [r0, #4]
	ldr r0, _02008EAC // =mapCamera
	add r1, r1, r2, asr #12
	add r0, r0, #0x100
	ldrh r3, [r0, #0x2a]
	ldrh r2, [r0, #0x2c]
	mov r0, r1, lsl #0xa
	mov r11, r0, lsr #0x10
	ldr r0, [sp, #0x24]
	mov r5, r3, asr #6
	mov r4, r2, asr #6
	ldrsh r1, [r0, #0x1e]
	ldr r3, [r0, #8]
	mov r0, r5, lsl #0x10
	str r0, [sp, #0x3c]
	add r0, r1, r3, asr #12
	mov r1, r0, lsl #0xa
	mov r0, r4, lsl #0x10
	str r0, [sp, #0x38]
	mov r0, r1, lsr #0x10
	mov r2, r11, lsl #0x10
	str r0, [sp, #0x20]
	movs r0, r2, asr #0x10
	ldr r0, [sp, #0x20]
	movmi r11, #0
	mov r0, r0, lsl #0x10
	movs r0, r0, asr #0x10
	movmi r0, #0
	strmi r0, [sp, #0x20]
	mov r0, #0
	str r0, [sp, #0x30]
_02008A08:
	ldr r0, [sp, #0x30]
	cmp r0, #0
	bne _02008A2C
	ldr r0, _02008EB0 // =mapSystemTask
	ldr r4, [r0, #0x14]
	ldr r0, [sp, #0x24]
	ldr r0, [r0, #0x30]
	str r0, [sp, #0x2c]
	b _02008A40
_02008A2C:
	ldr r0, _02008EB0 // =mapSystemTask
	ldr r4, [r0, #0x18]
	ldr r0, [sp, #0x24]
	ldr r0, [r0, #0x34]
	str r0, [sp, #0x2c]
_02008A40:
	mov r0, #0
	str r0, [sp, #0x28]
_02008A48:
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x28]
	add r9, r1, r0
	ldr r0, [sp, #0x38]
	cmp r9, r0, lsr #16
	bge _02008B04
	ldr r2, [sp, #0x28]
	ldr r0, [sp, #0x2c]
	mov r1, #0x280
	mla r10, r2, r1, r0
	mov r5, #0
_02008A74:
	ldr r0, [sp, #0x3c]
	add r1, r11, r5
	cmp r1, r0, lsr #16
	bge _02008AE8
	ldr r0, _02008EB0 // =mapSystemTask
	add r7, r10, r5, lsl #4
	ldr r2, [r0, #0x10]
	ldrh r0, [r4]
	mov r6, #0
	mla r1, r0, r9, r1
	add r0, r4, r1, lsl #1
	ldrh r0, [r0, #4]
	add r8, r2, r0, lsl #7
_02008AA8:
	mov r0, r8
	mov r1, r7
	mov r2, #0x10
	bl MIi_CpuCopy32
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	add r8, r8, #0x10
	add r7, r7, #0x50
	cmp r6, #8
	blo _02008AA8
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #5
	blo _02008A74
_02008AE8:
	ldr r0, [sp, #0x28]
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x28]
	cmp r0, #4
	blo _02008A48
_02008B04:
	ldr r0, [sp, #0x30]
	add r0, r0, #1
	str r0, [sp, #0x30]
	cmp r0, #2
	blo _02008A08
_02008B18:
	ldr r0, [sp, #0x34]
	add r0, r0, #1
	str r0, [sp, #0x34]
	cmp r0, #2
	ldr r0, [sp, #0x24]
	add r0, r0, #0x70
	str r0, [sp, #0x24]
	blo _02008974
	mov r9, #0
	ldr r8, _02008EAC // =mapCamera
	mov r5, r9
	mov r4, r9
	mov r11, #4
_02008B4C:
	ldr r0, [r8]
	cmp r9, #0
	moveq r10, #0xa
	movne r10, #0x16
	tst r0, #0x10000000
	bne _02008C80
	tst r0, #1
	ldrsh r2, [r8, #0x1c]
	ldr r3, [r8, #4]
	ldrsh r0, [r8, #0x1e]
	ldr r1, [r8, #8]
	add r2, r2, r3, asr #12
	add r0, r0, r1, asr #12
	mov r2, r2, asr #3
	mov r0, r0, asr #3
	and r6, r2, #7
	and r7, r0, #7
	beq _02008C04
	ldr r0, [r8, #0x28]
	ldr r1, [r8, #0x24]
	add r0, r0, #7
	add r1, r1, #7
	stmia sp, {r5, r10}
	mov r0, r0, asr #3
	mov r1, r1, asr #3
	add r0, r0, #1
	str r5, [sp, #8]
	cmp r0, #0x20
	movgt r0, #0x20
	add r1, r1, #1
	cmp r1, #0x28
	movgt r1, #0x28
	str r5, [sp, #0xc]
	mov r1, r1, lsl #0x10
	str r5, [sp, #0x10]
	mov r0, r0, lsl #0x10
	mov r1, r1, lsr #0x10
	str r5, [sp, #0x14]
	str r1, [sp, #0x18]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x1c]
	ldr r0, [r8, #0x30]
	mov r1, r6
	mov r2, r7
	mov r3, #0x28
	bl Mappings__ReadMappingsCompressed
_02008C04:
	ldr r0, [r8]
	tst r0, #2
	beq _02008C80
	ldr r0, [r8, #0x28]
	mov r2, r7
	add r0, r0, #7
	mov r0, r0, asr #3
	add r1, r0, #1
	ldr r0, [r8, #0x24]
	cmp r1, #0x20
	add r0, r0, #7
	stmia sp, {r4, r10}
	mov r0, r0, asr #3
	str r4, [sp, #8]
	movgt r1, #0x20
	add r0, r0, #1
	cmp r0, #0x28
	movgt r0, #0x28
	str r11, [sp, #0xc]
	mov r0, r0, lsl #0x10
	str r4, [sp, #0x10]
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r0, r0, lsr #0x10
	str r4, [sp, #0x14]
	str r0, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r0, [r8, #0x34]
	mov r1, r6
	mov r3, #0x28
	bl Mappings__ReadMappingsCompressed
_02008C80:
	add r8, r8, #0x70
	add r9, r9, #1
	cmp r9, #2
	blo _02008B4C
	ldr r0, _02008EAC // =mapCamera
	ldr r3, _02008EB4 // =FX_SinCosTable_
	ldrh r1, [r0, #0x2c]
	add r0, sp, #0x40
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	bl MTX_Rot22_
	ldr r1, _02008EAC // =mapCamera
	add r0, sp, #0x40
	ldr r2, [r1, #0x24]
	ldr r3, [r1, #0x28]
	mov r1, r0
	bl MTX_ScaleApply22
	ldr r0, _02008EAC // =mapCamera
	ldrsh r2, [r0, #0x1c]
	ldr r3, [r0, #4]
	ldr r1, [r0, #0x24]
	add r0, r3, r2, lsl #12
	and r0, r0, #0x7000
	bl FX_Div
	mov r2, r0, lsl #4
	ldr r0, _02008EAC // =mapCamera
	ldrsh r3, [r0, #0x1e]
	ldr r4, [r0, #8]
	ldr r1, [r0, #0x28]
	add r0, r4, r3, lsl #12
	and r0, r0, #0x7000
	mov r4, r2, asr #0x10
	bl FX_Div
	ldr r1, _02008EAC // =mapCamera
	mov r0, r0, lsl #4
	ldr r1, [r1]
	mov r5, r0, asr #0x10
	tst r1, #1
	beq _02008D5C
	ldr r0, _02008EB8 // =VRAMSystem__GFXControl
	add r1, sp, #0x40
	ldr r0, [r0]
	mov r6, #0
	add r7, r0, #0x28
	ldmia r1, {r0, r1, r2, r3}
	stmia r7, {r0, r1, r2, r3}
	strh r6, [r7, #0x12]
	strh r6, [r7, #0x10]
	strh r4, [r7, #0x14]
	strh r5, [r7, #0x16]
_02008D5C:
	ldr r0, _02008EAC // =mapCamera
	ldr r0, [r0]
	tst r0, #2
	beq _02008D98
	ldr r0, _02008EB8 // =VRAMSystem__GFXControl
	add r1, sp, #0x40
	ldr r0, [r0]
	mov r6, #0
	add r7, r0, #0x40
	ldmia r1, {r0, r1, r2, r3}
	stmia r7, {r0, r1, r2, r3}
	strh r6, [r7, #0x12]
	strh r6, [r7, #0x10]
	strh r4, [r7, #0x14]
	strh r5, [r7, #0x16]
_02008D98:
	ldr r0, _02008EAC // =mapCamera
	ldr r3, _02008EB4 // =FX_SinCosTable_
	ldrh r1, [r0, #0x9c]
	add r0, sp, #0x40
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	bl MTX_Rot22_
	ldr r1, _02008EAC // =mapCamera
	add r0, sp, #0x40
	ldr r2, [r1, #0x94]
	ldr r3, [r1, #0x98]
	mov r1, r0
	bl MTX_ScaleApply22
	ldr r0, _02008EAC // =mapCamera
	ldrsh r2, [r0, #0x8c]
	ldr r3, [r0, #0x74]
	ldr r1, [r0, #0x94]
	add r0, r3, r2
	and r0, r0, #0x7000
	bl FX_Div
	mov r2, r0, lsl #4
	ldr r0, _02008EAC // =mapCamera
	ldrsh r3, [r0, #0x8e]
	ldr r4, [r0, #0x78]
	ldr r1, [r0, #0x98]
	add r0, r4, r3
	and r0, r0, #0x7000
	mov r4, r2, asr #0x10
	bl FX_Div
	ldr r1, _02008EAC // =mapCamera
	mov r0, r0, lsl #4
	ldr r1, [r1, #0x70]
	mov r5, r0, asr #0x10
	tst r1, #1
	beq _02008E64
	ldr r0, _02008EB8 // =VRAMSystem__GFXControl
	add r1, sp, #0x40
	ldr r0, [r0, #4]
	mov r6, #0
	add r7, r0, #0x28
	ldmia r1, {r0, r1, r2, r3}
	stmia r7, {r0, r1, r2, r3}
	strh r6, [r7, #0x12]
	strh r6, [r7, #0x10]
	strh r4, [r7, #0x14]
	strh r5, [r7, #0x16]
_02008E64:
	ldr r0, _02008EAC // =mapCamera
	ldr r0, [r0, #0x70]
	tst r0, #2
	addeq sp, sp, #0x50
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, _02008EB8 // =VRAMSystem__GFXControl
	add r1, sp, #0x40
	ldr r0, [r0, #4]
	mov r6, #0
	add r7, r0, #0x40
	ldmia r1, {r0, r1, r2, r3}
	stmia r7, {r0, r1, r2, r3}
	strh r6, [r7, #0x12]
	strh r6, [r7, #0x10]
	strh r4, [r7, #0x14]
	strh r5, [r7, #0x16]
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02008EAC: .word mapCamera
_02008EB0: .word mapSystemTask
_02008EB4: .word FX_SinCosTable_
_02008EB8: .word VRAMSystem__GFXControl
	arm_func_end MapSys__DrawLayout

	arm_func_start MapSys__GetDispSelect
MapSys__GetDispSelect: // 0x02008EBC
	ldr r0, _02008EDC // =0x04000304
	ldrh r0, [r0]
	and r0, r0, #0x8000
	mov r0, r0, asr #0xf
	cmp r0, #1
	moveq r0, #0
	movne r0, #1
	bx lr
	.align 2, 0
_02008EDC: .word 0x04000304
	arm_func_end MapSys__GetDispSelect

	arm_func_start MapSys__GetCameraA
MapSys__GetCameraA: // 0x02008EE0
	ldr r0, _02008EF8 // =mapSystemTask
	ldr r0, [r0, #0x100]
	tst r0, #2
	ldrne r0, _02008EFC // =0x02133B38
	ldreq r0, _02008F00 // =mapCamera
	bx lr
	.align 2, 0
_02008EF8: .word mapSystemTask
_02008EFC: .word 0x02133B38
_02008F00: .word mapCamera
	arm_func_end MapSys__GetCameraA

	arm_func_start MapSys__GetCameraB
MapSys__GetCameraB: // 0x02008F04
	ldr r0, _02008F1C // =mapSystemTask
	ldr r0, [r0, #0x100]
	tst r0, #2
	ldrne r0, _02008F20 // =mapCamera
	ldreq r0, _02008F24 // =0x02133B38
	bx lr
	.align 2, 0
_02008F1C: .word mapSystemTask
_02008F20: .word mapCamera
_02008F24: .word 0x02133B38
	arm_func_end MapSys__GetCameraB

	arm_func_start MapSys__Func_2008F28
MapSys__Func_2008F28: // 0x02008F28
	stmdb sp!, {r4, lr}
	cmp r0, #0
	bne _02008F64
	ldr r1, _02009088 // =mapSystemTask
	ldr r2, [r1, #0x100]
	tst r2, #2
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _0200908C // =renderCurrentDisplay
	bic r2, r2, #2
	mov r3, #1
	str r3, [r0]
	orr r0, r2, #0x200
	str r0, [r1, #0x100]
	b _02008F90
_02008F64:
	ldr r1, _02009088 // =mapSystemTask
	ldr r2, [r1, #0x100]
	tst r2, #2
	movne r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, _0200908C // =renderCurrentDisplay
	orr r2, r2, #2
	mov r3, #0
	str r3, [r0]
	orr r0, r2, #0x200
	str r0, [r1, #0x100]
_02008F90:
	ldr r2, _02009090 // =mapCamera
	ldr r3, _02009094 // =0x02133B38
	mov ip, #0
_02008F9C:
	add r1, r2, ip, lsl #2
	add r0, r3, ip, lsl #2
	ldr lr, [r1, #4]
	ldr r4, [r0, #4]
	add ip, ip, #1
	eor lr, lr, r4
	str lr, [r1, #4]
	ldr r4, [r0, #4]
	and ip, ip, #0xff
	eor lr, r4, lr
	str lr, [r0, #4]
	ldr r4, [r1, #4]
	cmp ip, #2
	eor r4, r4, lr
	str r4, [r1, #4]
	ldr lr, [r1, #0xc]
	ldr r4, [r0, #0xc]
	eor lr, lr, r4
	str lr, [r1, #0xc]
	ldr r4, [r0, #0xc]
	eor lr, r4, lr
	str lr, [r0, #0xc]
	ldr r4, [r1, #0xc]
	eor r4, r4, lr
	str r4, [r1, #0xc]
	ldr lr, [r1, #0x38]
	ldr r4, [r0, #0x38]
	eor lr, lr, r4
	str lr, [r1, #0x38]
	ldr r4, [r0, #0x38]
	eor lr, r4, lr
	str lr, [r0, #0x38]
	ldr r4, [r1, #0x38]
	eor r4, r4, lr
	str r4, [r1, #0x38]
	ldr lr, [r1, #0x24]
	ldr r4, [r0, #0x24]
	eor r4, lr, r4
	str r4, [r1, #0x24]
	ldr r4, [r0, #0x24]
	ldr lr, [r1, #0x24]
	eor r4, r4, lr
	str r4, [r0, #0x24]
	ldr r0, [r1, #0x24]
	eor r0, r0, r4
	str r0, [r1, #0x24]
	blo _02008F9C
	ldrh ip, [r2, #0x2c]
	ldrh r1, [r3, #0x2c]
	mov r0, #1
	eor ip, ip, r1
	strh ip, [r2, #0x2c]
	ldrh ip, [r2, #0x2c]
	eor r1, r1, ip
	strh r1, [r3, #0x2c]
	ldrh r1, [r3, #0x2c]
	eor r1, ip, r1
	strh r1, [r2, #0x2c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02009088: .word mapSystemTask
_0200908C: .word renderCurrentDisplay
_02009090: .word mapCamera
_02009094: .word 0x02133B38
	arm_func_end MapSys__Func_2008F28

	arm_func_start MapSys__GetPosition
MapSys__GetPosition: // 0x02009098
	stmdb sp!, {r3, lr}
	ldrsh lr, [r0, #0x1c]
	ldr ip, [r0, #4]
	ldr r3, [r0, #0x14]
	add r3, ip, r3
	add r3, r3, lr, lsl #12
	str r3, [r1]
	ldrsh r3, [r0, #0x1e]
	ldr r1, [r0, #8]
	ldr r0, [r0, #0x18]
	add r0, r1, r0
	add r0, r0, r3, lsl #12
	str r0, [r2]
	ldmia sp!, {r3, pc}
	arm_func_end MapSys__GetPosition

	arm_func_start MapSys__Func_20090D0
MapSys__Func_20090D0: // 0x020090D0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r1
	mov r5, r2
	add r1, sp, #0
	add r2, sp, #4
	mov r4, r3
	bl MapSys__GetPosition
	ldr r1, [sp]
	ldr r0, [sp, #0x18]
	sub r1, r6, r1
	mov r1, r1, asr #0xc
	strh r1, [r4]
	ldr r1, [sp, #4]
	sub r1, r5, r1
	mov r1, r1, asr #0xc
	strh r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end MapSys__Func_20090D0

	arm_func_start MapSys__SetTargetOffsetA
MapSys__SetTargetOffsetA: // 0x0200911C
	ldr ip, _02009130 // =sub_2009134
	mov r2, r1
	mov r1, r0
	mov r0, #0
	bx ip
	.align 2, 0
_02009130: .word sub_2009134
	arm_func_end MapSys__SetTargetOffsetA

	arm_func_start sub_2009134
sub_2009134: // 0x02009134
	stmdb sp!, {r3, lr}
	mov r3, #0x70
	mul lr, r0, r3
	ldr ip, _0200917C // =0x02133B18
	ldr r3, _02009180 // =0x02133B1C
	str r1, [ip, lr]
	ldr r0, _02009184 // =mapCamera
	str r2, [r3, lr]
	ldr r0, [r0, lr]
	tst r0, #0x3000
	ldmneia sp!, {r3, pc}
	ldr r2, [ip, lr]
	ldr r1, _02009188 // =0x02133B10
	ldr r0, _0200918C // =0x02133B14
	str r2, [r1, lr]
	ldr r1, [r3, lr]
	str r1, [r0, lr]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0200917C: .word 0x02133B18
_02009180: .word 0x02133B1C
_02009184: .word mapCamera
_02009188: .word 0x02133B10
_0200918C: .word 0x02133B14
	arm_func_end sub_2009134

	arm_func_start MapSys__SetTargetOffset
MapSys__SetTargetOffset: // 0x02009190
	mov r1, #0x70
	mul r1, r0, r1
	ldr r2, _020091AC // =mapCamera
	ldr r0, [r2, r1]
	orr r0, r0, #0x40
	str r0, [r2, r1]
	bx lr
	.align 2, 0
_020091AC: .word mapCamera
	arm_func_end MapSys__SetTargetOffset

	arm_func_start MapSys__Func_20091B0
MapSys__Func_20091B0: // 0x020091B0
	mov r1, #0x70
	mul r1, r0, r1
	ldr r2, _020091CC // =mapCamera
	ldr r0, [r2, r1]
	orr r0, r0, #0x80
	str r0, [r2, r1]
	bx lr
	.align 2, 0
_020091CC: .word mapCamera
	arm_func_end MapSys__Func_20091B0

	arm_func_start MapSys__Func_20091D0
MapSys__Func_20091D0: // 0x020091D0
	mov r1, #0x70
	mul r1, r0, r1
	ldr r2, _020091EC // =mapCamera
	ldr r0, [r2, r1]
	bic r0, r0, #0x40
	str r0, [r2, r1]
	bx lr
	.align 2, 0
_020091EC: .word mapCamera
	arm_func_end MapSys__Func_20091D0

	arm_func_start MapSys__Func_20091F0
MapSys__Func_20091F0: // 0x020091F0
	mov r1, #0x70
	mul r1, r0, r1
	ldr r2, _0200920C // =mapCamera
	ldr r0, [r2, r1]
	bic r0, r0, #0x80
	str r0, [r2, r1]
	bx lr
	.align 2, 0
_0200920C: .word mapCamera
	arm_func_end MapSys__Func_20091F0

	arm_func_start MapSys__GetScreenSwapPos
MapSys__GetScreenSwapPos: // 0x02009210
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r1, _020092DC // =mapSystemTask
	mov r3, #0
	cmp r0, #0
	ldr r1, [r1, #0x1c]
	movlt r5, r3
	blt _02009244
	ldr r4, _020092E0 // =0x02133BA8
	ldrh r4, [r4, #0x4a]
	mov r4, r4, lsl #0xc
	sub r5, r4, #1
	cmp r0, r5
	movle r5, r0
_02009244:
	ldrh lr, [r1, #2]
	ldrh r4, [r1]
	mov r0, #0
	cmp lr, #0
	ble _020092D0
	mov ip, r0
	mov r7, #1
_02009260:
	add r9, ip, r5, asr #18
	mov r6, r9, lsl #0xe
	add r8, r1, r6, lsr #16
	mov r6, r9, lsl #0x1e
	mov r6, r6, lsr #0x1d
	mov r6, r6, lsl #0x10
	ldrb r8, [r8, #4]
	mov r6, r6, lsr #0x10
	cmp r3, #0
	mov r6, r8, asr r6
	and r6, r6, #3
	bne _020092AC
	cmp r6, #0
	beq _020092AC
	cmp r6, #1
	moveq r0, r0, lsl #0x12
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r3, r7
	mov r2, r0
_020092AC:
	cmp r3, #1
	cmpeq r6, #1
	addeq r0, r2, r0
	moveq r0, r0, lsl #0x11
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r0, r0, #1
	cmp r0, lr
	add ip, ip, r4
	blt _02009260
_020092D0:
	bl IsBossStage
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020092DC: .word mapSystemTask
_020092E0: .word 0x02133BA8
	arm_func_end MapSys__GetScreenSwapPos

	arm_func_start MapSys__GetCameraPositionCB
MapSys__GetCameraPositionCB: // 0x020092E4
	ldr ip, _020092FC // =MapSys__GetPosition
	mov r3, r0
	mov r2, r1
	ldr r0, _02009300 // =mapCamera
	mov r1, r3
	bx ip
	.align 2, 0
_020092FC: .word MapSys__GetPosition
_02009300: .word mapCamera
	arm_func_end MapSys__GetCameraPositionCB

	arm_func_start MapSys__LoadZoneTiles
MapSys__LoadZoneTiles: // 0x02009304
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x68
	mov r5, r0
	ldr r1, _02009380 // =aMAP
	add r0, sp, #0
	mov r2, r5
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #2
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	ldr r1, _02009384 // =0x06010000
	mov r0, #0
	mov r2, #0x10000
	bl MIi_CpuClearFast
	ldr r1, _02009388 // =0x06210000
	mov r0, #0
	mov r2, #0x10000
	bl MIi_CpuClearFast
	ldr r1, _02009384 // =0x06010000
	mov r0, r4
	bl RenderCore_CPUCopyCompressed
	ldr r1, _02009388 // =0x06210000
	mov r0, r4
	bl RenderCore_CPUCopyCompressed
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	mov r0, r5
	bl MapSys__LoadCollision
	add sp, sp, #0x68
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02009380: .word aMAP
_02009384: .word 0x06010000
_02009388: .word 0x06210000
	arm_func_end MapSys__LoadZoneTiles

	arm_func_start MapSys__LoadZoneMap
MapSys__LoadZoneMap: // 0x0200938C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x68
	mov r5, r0
	ldr r1, _0200940C // =aMAP
	add r0, sp, #0
	mov r2, r5
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #1
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	mov r1, #1
	mov r2, #0x4000
	bl LoadCompressedPalette
	mov r0, r4
	mov r1, #1
	mov r2, #0x6000
	bl LoadCompressedPalette
	mov r0, r4
	mov r1, #3
	mov r2, #0x4000
	bl LoadCompressedPalette
	mov r0, r4
	mov r1, #3
	mov r2, #0x6000
	bl LoadCompressedPalette
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	mov r0, r5
	bl MapSys__LoadTileLayout
	add sp, sp, #0x68
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0200940C: .word aMAP
	arm_func_end MapSys__LoadZoneMap

	arm_func_start MapSys__LoadBossTiles_Zone1
MapSys__LoadBossTiles_Zone1: // 0x02009410
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	mov r4, r0
	ldr r1, _02009444 // =0x02aRAW118ACC
	add r0, sp, #0
	mov r2, r4
	bl NNS_FndMountArchive
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	mov r0, r4
	bl MapSys__LoadCollision
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_02009444: .word aRAW
	arm_func_end MapSys__LoadBossTiles_Zone1

	arm_func_start MapSys__LoadBossTiles_Zone2
MapSys__LoadBossTiles_Zone2: // 0x02009448
	ldr ip, _02009450 // =MapSys__LoadBossTiles_Zone1
	bx ip
	.align 2, 0
_02009450: .word MapSys__LoadBossTiles_Zone1
	arm_func_end MapSys__LoadBossTiles_Zone2

	arm_func_start MapSys__LoadBossTiles_Zone3
MapSys__LoadBossTiles_Zone3: // 0x02009454
	ldr ip, _0200945C // =MapSys__LoadBossTiles_Zone1
	bx ip
	.align 2, 0
_0200945C: .word MapSys__LoadBossTiles_Zone1
	arm_func_end MapSys__LoadBossTiles_Zone3

	arm_func_start MapSys__LoadBossTiles_Zone4
MapSys__LoadBossTiles_Zone4: // 0x02009460
	ldr ip, _02009468 // =MapSys__LoadBossTiles_Zone1
	bx ip
	.align 2, 0
_02009468: .word MapSys__LoadBossTiles_Zone1
	arm_func_end MapSys__LoadBossTiles_Zone4

	arm_func_start MapSys__LoadBossTiles_Zone5
MapSys__LoadBossTiles_Zone5: // 0x0200946C
	ldr ip, _02009474 // =MapSys__LoadBossTiles_Zone1
	bx ip
	.align 2, 0
_02009474: .word MapSys__LoadBossTiles_Zone1
	arm_func_end MapSys__LoadBossTiles_Zone5

	arm_func_start MapSys__LoadBossTiles_Zone6
MapSys__LoadBossTiles_Zone6: // 0x02009478
	ldr ip, _02009480 // =MapSys__LoadBossTiles_Zone1
	bx ip
	.align 2, 0
_02009480: .word MapSys__LoadBossTiles_Zone1
	arm_func_end MapSys__LoadBossTiles_Zone6

	arm_func_start MapSys__LoadBossTiles_Zone7
MapSys__LoadBossTiles_Zone7: // 0x02009484
	ldr ip, _0200948C // =MapSys__LoadBossTiles_Zone1
	bx ip
	.align 2, 0
_0200948C: .word MapSys__LoadBossTiles_Zone1
	arm_func_end MapSys__LoadBossTiles_Zone7

	arm_func_start MapSys__LoadBossTiles_ZoneF
MapSys__LoadBossTiles_ZoneF: // 0x02009490
	ldr ip, _02009498 // =MapSys__LoadBossTiles_Zone1
	bx ip
	.align 2, 0
_02009498: .word MapSys__LoadBossTiles_Zone1
	arm_func_end MapSys__LoadBossTiles_ZoneF

	arm_func_start MapSys__LoadBossMap_Zone1
MapSys__LoadBossMap_Zone1: // 0x0200949C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	mov r4, r0
	ldr r1, _020094D0 // =aMAP
	add r0, sp, #0
	mov r2, r4
	bl NNS_FndMountArchive
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	mov r0, r4
	bl MapSys__LoadTileLayout
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_020094D0: .word aMAP
	arm_func_end MapSys__LoadBossMap_Zone1

	arm_func_start MapSys__LoadBossMap_Zone2
MapSys__LoadBossMap_Zone2: // 0x020094D4
	ldr ip, _020094DC // =MapSys__LoadBossMap_Zone1
	bx ip
	.align 2, 0
_020094DC: .word MapSys__LoadBossMap_Zone1
	arm_func_end MapSys__LoadBossMap_Zone2

	arm_func_start MapSys__LoadBossMap_Zone3
MapSys__LoadBossMap_Zone3: // 0x020094E0
	ldr ip, _020094E8 // =MapSys__LoadBossMap_Zone1
	bx ip
	.align 2, 0
_020094E8: .word MapSys__LoadBossMap_Zone1
	arm_func_end MapSys__LoadBossMap_Zone3

	arm_func_start MapSys__LoadBossMap_Zone4
MapSys__LoadBossMap_Zone4: // 0x020094EC
	ldr ip, _020094F4 // =MapSys__LoadBossMap_Zone1
	bx ip
	.align 2, 0
_020094F4: .word MapSys__LoadBossMap_Zone1
	arm_func_end MapSys__LoadBossMap_Zone4

	arm_func_start MapSys__LoadBossMap_Zone5
MapSys__LoadBossMap_Zone5: // 0x020094F8
	ldr ip, _02009500 // =MapSys__LoadBossMap_Zone1
	bx ip
	.align 2, 0
_02009500: .word MapSys__LoadBossMap_Zone1
	arm_func_end MapSys__LoadBossMap_Zone5

	arm_func_start MapSys__LoadBossMap_Zone6
MapSys__LoadBossMap_Zone6: // 0x02009504
	ldr ip, _0200950C // =MapSys__LoadBossMap_Zone1
	bx ip
	.align 2, 0
_0200950C: .word MapSys__LoadBossMap_Zone1
	arm_func_end MapSys__LoadBossMap_Zone6

	arm_func_start MapSys__LoadBossMap_Zone7
MapSys__LoadBossMap_Zone7: // 0x02009510
	ldr ip, _02009518 // =MapSys__LoadBossMap_Zone1
	bx ip
	.align 2, 0
_02009518: .word MapSys__LoadBossMap_Zone1
	arm_func_end MapSys__LoadBossMap_Zone7

	arm_func_start MapSys__LoadBossMap_ZoneF
MapSys__LoadBossMap_ZoneF: // 0x0200951C
	ldr ip, _02009524 // =MapSys__LoadBossMap_Zone1
	bx ip
	.align 2, 0
_02009524: .word MapSys__LoadBossMap_Zone1
	arm_func_end MapSys__LoadBossMap_ZoneF

	arm_func_start MapSys__LoadCollision
MapSys__LoadCollision: // 0x02009528
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	ldr r1, _02009610 // =aRAW
	mov r2, r0
	add r0, sp, #0
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #3
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_ITCM
	mov r1, r0
	ldr r2, _02009614 // =mapSystemTask
	mov r0, r4
	str r1, [r2, #4]
	bl RenderCore_CPUCopyCompressed
	add r0, sp, #0
	mov r1, #0
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_ITCM
	mov r1, r0
	ldr r2, _02009614 // =mapSystemTask
	mov r0, r4
	str r1, [r2, #8]
	bl RenderCore_CPUCopyCompressed
	add r0, sp, #0
	mov r1, #4
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_ITCM
	mov r1, r0
	ldr r2, _02009614 // =mapSystemTask
	mov r0, r4
	str r1, [r2, #0xc]
	bl RenderCore_CPUCopyCompressed
	add r0, sp, #0
	mov r1, #1
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02009614 // =mapSystemTask
	mov r0, r4
	str r1, [r2, #0x10]
	bl RenderCore_CPUCopyCompressed
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_02009610: .word aRAW
_02009614: .word mapSystemTask
	arm_func_end MapSys__LoadCollision

	arm_func_start MapSys__LoadTileLayout
MapSys__LoadTileLayout: // 0x02009618
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	ldr r1, _020096D0 // =aMAP
	mov r2, r0
	add r0, sp, #0
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #2
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _020096D4 // =mapSystemTask
	mov r0, r4
	str r1, [r2, #0x14]
	bl RenderCore_CPUCopyCompressed
	add r0, sp, #0
	mov r1, #3
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _020096D4 // =mapSystemTask
	mov r0, r4
	str r1, [r2, #0x18]
	bl RenderCore_CPUCopyCompressed
	add r0, sp, #0
	mov r1, #0
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _020096D4 // =mapSystemTask
	mov r0, r4
	str r1, [r2, #0x1c]
	bl RenderCore_CPUCopyCompressed
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_020096D0: .word aMAP
_020096D4: .word mapSystemTask
	arm_func_end MapSys__LoadTileLayout

	arm_func_start MapSys__InitStageBounds
MapSys__InitStageBounds: // 0x020096D8
	stmdb sp!, {r4, lr}
	ldr r2, _0200976C // =mapSystemTask
	ldr r1, _02009770 // =0x02133BA8
	ldr lr, [r2, #0x14]
	mov r3, #0x8000
	ldrh ip, [lr]
	mov r0, #0xa00
	mov ip, ip, lsl #6
	strh ip, [r1, #0x4a]
	ldrh ip, [lr, #2]
	mov ip, ip, lsl #6
	strh ip, [r1, #0x4c]
	str r3, [r2, #0x150]
	str r3, [r2, #0x154]
	ldrh r3, [r1, #0x4a]
	sub r3, r3, #8
	mov r3, r3, lsl #0xc
	str r3, [r2, #0x158]
	ldrh r1, [r1, #0x4c]
	sub r1, r1, #8
	mov r1, r1, lsl #0xc
	str r1, [r2, #0x15c]
	bl _AllocHeadHEAP_USER
	ldr r1, _0200976C // =mapSystemTask
	str r0, [r1, #0x50]
	mov r0, #0xa00
	bl _AllocHeadHEAP_USER
	ldr r1, _0200976C // =mapSystemTask
	ldr r4, _02009774 // =0x02133B38
	str r0, [r1, #0x54]
	mov r0, #0xa00
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x30]
	mov r0, #0xa00
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x34]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0200976C: .word mapSystemTask
_02009770: .word 0x02133BA8
_02009774: .word 0x02133B38
	arm_func_end MapSys__InitStageBounds

	arm_func_start MapSys__InitBoundsForStage
MapSys__InitBoundsForStage: // 0x02009778
	stmdb sp!, {r4, lr}
	ldr r0, _020098BC // =mapSystemTask
	mov r1, #0
	ldr r3, [r0, #0x100]
	mov r2, #0x50000
	orr r3, r3, #1
	bic r3, r3, #4
	str r3, [r0, #0x100]
	str r2, [r0, #0x108]
	strb r1, [r0, #0x66]
	sub r1, r1, #1
	strb r1, [r0, #0xd6]
	mov r1, #0x80000
	str r1, [r0, #0x68]
	mov r1, #0x60000
	str r1, [r0, #0x6c]
	tst r3, #4
	bne _02009860
	ldr r1, _020098C0 // =gameState
	ldr r0, [r1, #0x10]
	tst r0, #0x40
	ldrne r0, [r1, #0x34]
	ldrne r4, [r1, #0x38]
	ldreq r1, _020098C4 // =playerGameStatus
	ldreq r0, [r1, #0x2c]
	ldreq r4, [r1, #0x30]
	bl MapSys__GetScreenSwapPos
	cmp r0, r4
	ldr ip, _020098C8 // =0x04000304
	blt _0200982C
	ldrh r3, [ip]
	ldr r1, _020098CC // =renderCurrentDisplay
	ldr r0, _020098BC // =mapSystemTask
	orr r3, r3, #0x8000
	mov r2, #1
	strh r3, [ip]
	str r2, [r1]
	ldr r2, [r0, #0x100]
	mov r1, #0
	bic r2, r2, #2
	str r2, [r0, #0x100]
	str r1, [r0, #0x10c]
	mov r1, #0x110000
	str r1, [r0, #0x110]
	b _02009860
_0200982C:
	ldrh r2, [ip]
	ldr r1, _020098CC // =renderCurrentDisplay
	mov r3, #0
	bic r2, r2, #0x8000
	strh r2, [ip]
	str r3, [r1]
	ldr r0, _020098BC // =mapSystemTask
	sub r1, r3, #0x110000
	ldr r2, [r0, #0x100]
	orr r2, r2, #2
	str r2, [r0, #0x100]
	str r3, [r0, #0x10c]
	str r1, [r0, #0x110]
_02009860:
	ldr r4, _020098D0 // =mapCamera
	ldr r0, _020098BC // =mapSystemTask
	mov r3, #0
	mov r2, #0x1000
_02009870:
	ldr r1, [r4]
	add r3, r3, #1
	orr r1, r1, #0xf
	orr r1, r1, #0x30000
	str r1, [r4]
	str r2, [r4, #0x24]
	str r2, [r4, #0x28]
	ldr r1, [r0, #0x150]
	cmp r3, #2
	str r1, [r4, #0x58]
	ldr r1, [r0, #0x154]
	str r1, [r4, #0x5c]
	ldr r1, [r0, #0x158]
	str r1, [r4, #0x60]
	ldr r1, [r0, #0x15c]
	str r1, [r4, #0x64]
	add r4, r4, #0x70
	blo _02009870
	ldmia sp!, {r4, pc}
	.align 2, 0
_020098BC: .word mapSystemTask
_020098C0: .word gameState
_020098C4: .word playerGameStatus
_020098C8: .word 0x04000304
_020098CC: .word renderCurrentDisplay
_020098D0: .word mapCamera
	arm_func_end MapSys__InitBoundsForStage

	arm_func_start MapSys__InitBoundsForVSRings
MapSys__InitBoundsForVSRings: // 0x020098D4
	stmdb sp!, {r3, lr}
	ldr r2, _020099AC // =mapSystemTask
	ldr lr, _020099B0 // =0x04000304
	ldr r0, [r2, #0x100]
	ldr r1, _020099B4 // =renderCurrentDisplay
	bic r0, r0, #1
	orr r0, r0, #4
	str r0, [r2, #0x100]
	ldrh ip, [lr]
	mov r3, #1
	mov r0, #0
	orr ip, ip, #0x8000
	strh ip, [lr]
	str r3, [r1]
	ldr r1, [r2, #0x100]
	ldr r3, _020099B8 // =mapCamera
	bic r1, r1, #2
	str r1, [r2, #0x100]
	str r0, [r2, #0x10c]
	str r0, [r2, #0x110]
_02009924:
	ldr r1, [r3]
	add r0, r0, #1
	orr r1, r1, #0xf
	orr r1, r1, #0x30000
	str r1, [r3]
	ldr r1, [r2, #0x150]
	cmp r0, #2
	str r1, [r3, #0x58]
	ldr r1, [r2, #0x154]
	str r1, [r3, #0x5c]
	ldr r1, [r2, #0x158]
	str r1, [r3, #0x60]
	ldr r1, [r2, #0x15c]
	str r1, [r3, #0x64]
	add r3, r3, #0x70
	blo _02009924
	ldr r0, _020099AC // =mapSystemTask
	mov ip, #0
	strb ip, [r0, #0x66]
	mov r3, #0x80000
	str r3, [r0, #0x68]
	mov r1, #0x60000
	str r1, [r0, #0x6c]
	mov r2, #0x1000
	str r2, [r0, #0x44]
	ldr r1, _020099BC // =0x02133B38
	str r2, [r0, #0x48]
	mov r0, #0x58000
	strb ip, [r1, #0x46]
	str r3, [r1, #0x48]
	str r0, [r1, #0x4c]
	str r2, [r1, #0x24]
	str r2, [r1, #0x28]
	ldmia sp!, {r3, pc}
	.align 2, 0
_020099AC: .word mapSystemTask
_020099B0: .word 0x04000304
_020099B4: .word renderCurrentDisplay
_020099B8: .word mapCamera
_020099BC: .word 0x02133B38
	arm_func_end MapSys__InitBoundsForVSRings

	arm_func_start MapSys__SetupBoss_Zone5
MapSys__SetupBoss_Zone5: // 0x020099C0
	stmdb sp!, {r3, lr}
	ldr r2, _02009A98 // =mapSystemTask
	ldr lr, _02009A9C // =0x04000304
	ldr r0, [r2, #0x100]
	ldr r1, _02009AA0 // =renderCurrentDisplay
	bic r0, r0, #1
	orr r0, r0, #4
	str r0, [r2, #0x100]
	ldrh ip, [lr]
	mov r3, #1
	mov r0, #0
	orr ip, ip, #0x8000
	strh ip, [lr]
	str r3, [r1]
	ldr r1, [r2, #0x100]
	ldr r3, _02009AA4 // =mapCamera
	bic r1, r1, #2
	str r1, [r2, #0x100]
	str r0, [r2, #0x10c]
	str r0, [r2, #0x110]
_02009A10:
	ldr r1, [r3]
	add r0, r0, #1
	orr r1, r1, #0xf
	orr r1, r1, #0x30000
	str r1, [r3]
	ldr r1, [r2, #0x150]
	cmp r0, #2
	str r1, [r3, #0x58]
	ldr r1, [r2, #0x154]
	str r1, [r3, #0x5c]
	ldr r1, [r2, #0x158]
	str r1, [r3, #0x60]
	ldr r1, [r2, #0x15c]
	str r1, [r3, #0x64]
	add r3, r3, #0x70
	blo _02009A10
	ldr r0, _02009A98 // =mapSystemTask
	mov ip, #0
	strb ip, [r0, #0x66]
	mov r3, #0x80000
	str r3, [r0, #0x68]
	mov r1, #0x60000
	str r1, [r0, #0x6c]
	mov r2, #0x1000
	str r2, [r0, #0x44]
	ldr r1, _02009AA8 // =0x02133B38
	str r2, [r0, #0x48]
	mov r0, #0x58000
	strb ip, [r1, #0x46]
	str r3, [r1, #0x48]
	str r0, [r1, #0x4c]
	str r2, [r1, #0x24]
	str r2, [r1, #0x28]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02009A98: .word mapSystemTask
_02009A9C: .word 0x04000304
_02009AA0: .word renderCurrentDisplay
_02009AA4: .word mapCamera
_02009AA8: .word 0x02133B38
	arm_func_end MapSys__SetupBoss_Zone5

	arm_func_start MapSys__Destructor
MapSys__Destructor: // 0x02009AAC
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, _02009AF0 // =mapCamera
	mov r4, #0
_02009AB8:
	ldr r0, [r5, #0x30]
	bl _FreeHEAP_USER
	ldr r0, [r5, #0x34]
	bl _FreeHEAP_USER
	add r4, r4, #1
	cmp r4, #2
	add r5, r5, #0x70
	blo _02009AB8
	bl ReleaseWaterSurface
	bl MapFarSys__ReleaseBG
	ldr r0, _02009AF4 // =mapSystemTask
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02009AF0: .word mapCamera
_02009AF4: .word mapSystemTask
	arm_func_end MapSys__Destructor

	arm_func_start MapSys__Main_Zone
MapSys__Main_Zone: // 0x02009AF8
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	ldr r1, _02009C1C // =mapSystemTask
	mov r4, r0
	ldr r0, [r1, #0x100]
	bic r2, r0, #0x200
	str r2, [r1, #0x100]
	str r2, [r1, #0x104]
	ldr r0, [r1, #0x24]
	tst r2, #1
	str r0, [r1, #0x2c]
	ldr r0, [r1, #0x28]
	str r0, [r1, #0x30]
	ldr r0, [r1, #0x94]
	str r0, [r1, #0x9c]
	ldr r0, [r1, #0x98]
	str r0, [r1, #0xa0]
	beq _02009B80
	tst r2, #2
	bne _02009B58
	ldr r0, [r1, #0x48]
	add r0, r0, r0, lsl #4
	mov r2, r0, lsl #4
	b _02009B68
_02009B58:
	mov r0, #0x110
	ldr r1, [r1, #0x48]
	rsb r0, r0, #0
	mul r2, r1, r0
_02009B68:
	ldr r1, _02009C1C // =mapSystemTask
	mov r0, #0x50
	str r2, [r1, #0x110]
	ldr r2, [r1, #0x48]
	mul r0, r2, r0
	str r0, [r1, #0x108]
_02009B80:
	bl MapSys__Func_200B1B4
	mov r0, r4
	bl MapSys__HandleCamera
	bl MapFarSys__ProcessBG
	bl ProcessWaterSurface
	ldr r3, _02009C20 // =mapCamera
	mov r2, #0
_02009B9C:
	ldr r1, [r3, #4]
	ldr r0, [r3, #0x14]
	add r2, r2, #1
	add r0, r1, r0
	str r0, [r3, #4]
	ldr r1, [r3, #8]
	ldr r0, [r3, #0x18]
	cmp r2, #2
	add r0, r1, r0
	str r0, [r3, #8]
	add r3, r3, #0x70
	blo _02009B9C
	ldr r3, _02009C1C // =mapSystemTask
	ldr r0, [r3, #0x24]
	ldr r1, [r3, #0x28]
	ldr r2, [r3, #0x94]
	ldr r3, [r3, #0x98]
	bl SetObjCameraPosition
	bl MapSys__DrawLayout
	mov r3, #0
	ldr r2, _02009C20 // =mapCamera
	mov r1, r3
_02009BF4:
	str r1, [r2, #0x18]
	str r1, [r2, #0x14]
	strh r1, [r2, #0x1e]
	ldrsh r0, [r2, #0x1e]
	add r3, r3, #1
	cmp r3, #2
	strh r0, [r2, #0x1c]
	add r2, r2, #0x70
	blo _02009BF4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02009C1C: .word mapSystemTask
_02009C20: .word mapCamera
	arm_func_end MapSys__Main_Zone

	arm_func_start MapSys__Main_Boss
MapSys__Main_Boss: // 0x02009C24
	stmdb sp!, {r3, lr}
	ldr r0, _02009CEC // =mapSystemTask
	ldr r1, [r0, #0x100]
	str r1, [r0, #0x104]
	bl GetCurrentTaskWork_
	ldr r1, _02009CEC // =mapSystemTask
	ldr r2, [r1, #0x100]
	str r2, [r1, #0x104]
	ldr r2, [r1, #0x24]
	str r2, [r1, #0x2c]
	ldr r2, [r1, #0x28]
	str r2, [r1, #0x30]
	ldr r2, [r1, #0x94]
	str r2, [r1, #0x9c]
	ldr r2, [r1, #0x98]
	str r2, [r1, #0xa0]
	bl MapSys__HandleCamera
	ldr r3, _02009CF0 // =mapCamera
	mov r2, #0
_02009C70:
	ldr r1, [r3, #4]
	ldr r0, [r3, #0x14]
	add r2, r2, #1
	add r0, r1, r0
	str r0, [r3, #4]
	ldr r1, [r3, #8]
	ldr r0, [r3, #0x18]
	cmp r2, #2
	add r0, r1, r0
	str r0, [r3, #8]
	add r3, r3, #0x70
	blo _02009C70
	ldr r3, _02009CEC // =mapSystemTask
	ldr r0, [r3, #0x24]
	ldr r1, [r3, #0x28]
	ldr r2, [r3, #0x94]
	ldr r3, [r3, #0x98]
	bl SetObjCameraPosition
	mov r3, #0
	ldr r2, _02009CF0 // =mapCamera
	mov r1, r3
_02009CC4:
	str r1, [r2, #0x18]
	str r1, [r2, #0x14]
	strh r1, [r2, #0x1e]
	ldrsh r0, [r2, #0x1e]
	add r3, r3, #1
	cmp r3, #2
	strh r0, [r2, #0x1c]
	add r2, r2, #0x70
	blo _02009CC4
	ldmia sp!, {r3, pc}
	.align 2, 0
_02009CEC: .word mapSystemTask
_02009CF0: .word mapCamera
	arm_func_end MapSys__Main_Boss

	arm_func_start MapSys__HandleCamera
MapSys__HandleCamera: // 0x02009CF4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r1, _02009E30 // =mapSystemTask
	mov r6, r0
	ldr r1, [r1, #0x100]
	tst r1, #0x100
	bne _02009D10
	bl MapSys__HandleCamLook
_02009D10:
	ldr r0, _02009E30 // =mapSystemTask
	ldr r1, [r0, #0x100]
	tst r1, #0x200
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	tst r1, #1
	beq _02009DBC
	ldr r0, [r0, #0x20]
	ldr r4, _02009E34 // =mapCamera
	tst r0, #0x140
	mov r0, r6
	mov r1, #0
	bne _02009D54
	bl MapSys__Func_2009E3C
	mov r0, r6
	mov r1, #0
	bl MapSys__Func_200A780
	b _02009D58
_02009D54:
	bl MapSys__HandleHBounds
_02009D58:
	ldr r0, [r4]
	mov r1, #0
	tst r0, #0x280
	mov r0, r6
	bne _02009D80
	bl MapSys__Func_2009E80
	mov r0, r6
	mov r1, #0
	bl MapSys__Func_200A7E8
	b _02009D84
_02009D80:
	bl MapSys__HandleVBounds
_02009D84:
	ldr r4, _02009E38 // =0x02133B38
	ldr r0, [r4]
	tst r0, #0x140
	bne _02009DA0
	mov r0, r6
	mov r1, #1
	bl MapSys__Func_200A8D8
_02009DA0:
	ldr r0, [r4]
	tst r0, #0x280
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r6
	mov r1, #1
	bl MapSys__Func_200A910
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02009DBC:
	mov r5, #0
	cmp r5, #2
	ldmgeia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r4, _02009E34 // =mapCamera
	mov r7, #0x70
_02009DD0:
	mul r8, r5, r7
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl Player__Func_201301C
	ldr r0, [r4, r8]
	mov r1, r5
	tst r0, #0x140
	mov r0, r6
	bne _02009DFC
	bl MapSys__Func_2009E3C
	b _02009E00
_02009DFC:
	bl MapSys__HandleHBounds
_02009E00:
	ldr r0, [r4, r8]
	mov r1, r5
	tst r0, #0x280
	mov r0, r6
	bne _02009E1C
	bl MapSys__Func_200A460
	b _02009E20
_02009E1C:
	bl MapSys__HandleVBounds
_02009E20:
	add r5, r5, #1
	cmp r5, #2
	blt _02009DD0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02009E30: .word mapSystemTask
_02009E34: .word mapCamera
_02009E38: .word 0x02133B38
	arm_func_end MapSys__HandleCamera

	arm_func_start MapSys__Func_2009E3C
MapSys__Func_2009E3C: // 0x02009E3C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	mov r2, #0x70
	mul ip, r4, r2
	ldr r3, _02009E78 // =mapCamera
	ldr r2, _02009E7C // =0x00004010
	ldr r3, [r3, ip]
	mov r5, r0
	tst r3, r2
	bne _02009E68
	bl MapSys__FollowTargetX
_02009E68:
	mov r0, r5
	mov r1, r4
	bl MapSys__HandleCamBoundsX
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02009E78: .word mapCamera
_02009E7C: .word 0x00004010
	arm_func_end MapSys__Func_2009E3C

	arm_func_start MapSys__Func_2009E80
MapSys__Func_2009E80: // 0x02009E80
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r4, _0200A450 // =mapCamera
	mov r7, r1
	mov r1, #0x70
	mla r5, r7, r1, r4
	mov r8, r0
	ldr r0, [r5, #4]
	bl MapSys__GetScreenSwapPos
	ldr r1, _0200A454 // =mapSystemTask
	mov r6, r0
	ldr r0, [r1, #0x100]
	tst r0, #8
	ldrne r6, [r1, #0x114]
	tst r0, #0x10000
	beq _0200A2F8
	tst r0, #0x20000
	ldr r2, [r5, #8]
	ldr r1, [r8, #8]
	bne _02009EE8
	add r1, r2, r1
	mov r0, r8
	str r1, [r5, #8]
	bl MapSys__Func_200A948
	mov r0, r8
	bl MapSys__Func_200AAF8
	b _0200A440
_02009EE8:
	add r1, r2, r1
	ldr r0, _0200A454 // =mapSystemTask
	str r1, [r5, #8]
	ldr r0, [r0, #0x100]
	ands r2, r0, #2
	beq _02009F18
	ldrsb r1, [r5, #0x46]
	ldr r0, _0200A458 // =gPlayerList
	ldr r0, [r0, r1, lsl #2]
	ldr r0, [r0, #0x48]
	cmp r0, r6
	blt _02009F38
_02009F18:
	cmp r2, #0
	bne _0200A020
	ldrsb r1, [r5, #0x46]
	ldr r0, _0200A458 // =gPlayerList
	ldr r0, [r0, r1, lsl #2]
	ldr r0, [r0, #0x48]
	cmp r0, r6
	ble _0200A020
_02009F38:
	mov r0, r8
	bl MapSys__Func_200A948
	ldr r0, _0200A454 // =mapSystemTask
	ldr r0, [r0, #0x100]
	ands r1, r0, #2
	beq _02009FB4
	ldr r0, [r8, #8]
	cmp r0, #0
	bge _02009FB4
	ldr r1, [r5, #0x28]
	mov r0, #0x28
	mla r0, r1, r0, r6
	ldr r2, [r5, #8]
	cmp r2, r0
	bge _0200A440
	blt _02009F90
	mov r0, #0xc0
	mul r0, r1, r0
	ldr r1, [r5, #0x64]
	sub r0, r1, r0
	cmp r2, r0
	movle r0, r2
_02009F90:
	ldr r1, _0200A454 // =mapSystemTask
	str r0, [r5, #8]
	ldr r2, [r1, #0x100]
	mov r0, r8
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__Func_200B170
	b _0200A440
_02009FB4:
	cmp r1, #0
	bne _0200A440
	ldr r0, [r8, #8]
	cmp r0, #0
	ble _0200A440
	ldr r1, [r5, #0x28]
	mov r0, #0xe8
	mul r2, r1, r0
	ldr r0, [r5, #8]
	sub r1, r6, r2
	cmp r0, r1
	ble _0200A440
	ldr r2, [r5, #0x5c]
	cmp r0, r2
	blt _02009FFC
	cmp r0, r1
	movle r1, r0
	mov r2, r1
_02009FFC:
	ldr r1, _0200A454 // =mapSystemTask
	str r2, [r5, #8]
	ldr r2, [r1, #0x100]
	mov r0, r8
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__Func_200B170
	b _0200A440
_0200A020:
	cmp r2, #0
	ldr r0, [r8, #8]
	bne _0200A190
	cmp r0, #0
	ble _0200A0D8
	ldr r1, [r5, #0x28]
	mov r0, #0xe8
	mul r2, r1, r0
	ldr r0, [r5, #8]
	sub r1, r6, r2
	cmp r0, r1
	ble _0200A08C
	ldr r2, [r5, #0x5c]
	cmp r0, r2
	blt _0200A068
	cmp r0, r1
	movle r1, r0
	mov r2, r1
_0200A068:
	ldr r1, _0200A454 // =mapSystemTask
	str r2, [r5, #8]
	ldr r2, [r1, #0x100]
	mov r0, r8
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__Func_200B170
	b _0200A440
_0200A08C:
	mov r0, r8
	bl MapSys__Func_200AA18
	cmp r0, #0
	beq _0200A440
	ldrsb r1, [r5, #0x46]
	ldr r0, _0200A458 // =gPlayerList
	ldr r2, [r5, #0x54]
	ldr r0, [r0, r1, lsl #2]
	ldr r1, _0200A454 // =mapSystemTask
	ldr r3, [r0, #0x48]
	mov r0, r8
	sub r2, r3, r2
	str r2, [r5, #8]
	ldr r2, [r1, #0x100]
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__Func_200B170
	b _0200A440
_0200A0D8:
	bge _0200A160
	ldr r0, [r5, #0x28]
	mov r1, #0xe8
	mul r2, r0, r1
	ldr r0, [r5, #8]
	sub r2, r6, r2
	cmp r0, r2
	bge _0200A440
	ldrsb r4, [r5, #0x46]
	ldr r3, _0200A458 // =gPlayerList
	ldr r2, [r5, #0x54]
	ldr r3, [r3, r4, lsl #2]
	ldr r3, [r3, #0x48]
	sub r2, r3, r2
	cmp r0, r2
	bge _0200A440
	str r2, [r5, #8]
	ldr r0, [r5, #0x5c]
	cmp r2, r0
	blt _0200A13C
	ldr r0, [r5, #0x28]
	mul r1, r0, r1
	sub r0, r6, r1
	cmp r2, r0
	movle r0, r2
_0200A13C:
	ldr r1, _0200A454 // =mapSystemTask
	str r0, [r5, #8]
	ldr r2, [r1, #0x100]
	mov r0, r8
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__Func_200B170
	b _0200A440
_0200A160:
	mov r0, r8
	bl MapSys__Func_200AAF8
	cmp r0, #0
	beq _0200A440
	ldr r1, _0200A454 // =mapSystemTask
	mov r0, r8
	ldr r2, [r1, #0x100]
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__Func_200B170
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0200A190:
	cmp r0, #0
	ble _0200A220
	ldr r1, [r5, #0x28]
	mov r0, #0x28
	mla r2, r1, r0, r6
	ldr r4, [r5, #8]
	cmp r4, r2
	ble _0200A440
	ldrsb r3, [r5, #0x46]
	ldr r2, _0200A458 // =gPlayerList
	ldr r1, [r5, #0x54]
	ldr r2, [r2, r3, lsl #2]
	ldr r2, [r2, #0x48]
	sub r2, r2, r1
	cmp r4, r2
	ble _0200A440
	str r2, [r5, #8]
	ldr r1, [r5, #0x28]
	mla r0, r1, r0, r6
	cmp r2, r0
	blt _0200A1FC
	mov r0, #0xc0
	mul r0, r1, r0
	ldr r1, [r5, #0x64]
	sub r0, r1, r0
	cmp r2, r0
	movle r0, r2
_0200A1FC:
	ldr r1, _0200A454 // =mapSystemTask
	str r0, [r5, #8]
	ldr r2, [r1, #0x100]
	mov r0, r8
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__Func_200B170
	b _0200A440
_0200A220:
	bge _0200A2C8
	ldr r1, [r5, #0x28]
	mov r0, #0x28
	mla r0, r1, r0, r6
	ldr r2, [r5, #8]
	cmp r2, r0
	bge _0200A27C
	blt _0200A258
	mov r0, #0xc0
	mul r0, r1, r0
	ldr r1, [r5, #0x64]
	sub r0, r1, r0
	cmp r2, r0
	movle r0, r2
_0200A258:
	ldr r1, _0200A454 // =mapSystemTask
	str r0, [r5, #8]
	ldr r2, [r1, #0x100]
	mov r0, r8
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__Func_200B170
	b _0200A440
_0200A27C:
	mov r0, r8
	bl MapSys__Func_200AA18
	cmp r0, #0
	beq _0200A440
	ldrsb r1, [r5, #0x46]
	ldr r0, _0200A458 // =gPlayerList
	ldr r2, [r5, #0x54]
	ldr r0, [r0, r1, lsl #2]
	ldr r1, _0200A454 // =mapSystemTask
	ldr r3, [r0, #0x48]
	mov r0, r8
	sub r2, r3, r2
	str r2, [r5, #8]
	ldr r2, [r1, #0x100]
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__Func_200B170
	b _0200A440
_0200A2C8:
	mov r0, r8
	bl MapSys__Func_200AAF8
	cmp r0, #0
	beq _0200A440
	ldr r1, _0200A454 // =mapSystemTask
	mov r0, r8
	ldr r2, [r1, #0x100]
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__Func_200B170
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0200A2F8:
	tst r0, #4
	bne _0200A434
	tst r0, #2
	ldrsb r1, [r5, #0x46]
	bne _0200A39C
	ldr r0, _0200A458 // =gPlayerList
	ldr r0, [r0, r1, lsl #2]
	ldr r0, [r0, #0x48]
	cmp r0, r6
	ble _0200A350
	mov r0, r8
	mov r1, r7
	bl MapSys__FollowTargetY
	mov r0, #1
	bl MapSys__Func_2008F28
	ldr r1, [r4, #0xe0]
	ldr r0, [r4, #0xf0]
	orr r1, r1, #0x200
	rsb r0, r0, #0
	str r1, [r4, #0xe0]
	str r0, [r4, #0xf0]
	b _0200A440
_0200A350:
	ldr r1, [r5]
	ldr r0, _0200A45C // =0x00004020
	tst r1, r0
	bne _0200A440
	mov r0, r8
	mov r1, r7
	bl MapSys__FollowTargetY
	ldr r0, [r5, #0x5c]
	ldr r2, [r5, #8]
	cmp r2, r0
	blt _0200A394
	ldr r1, [r5, #0x28]
	mov r0, #0xe8
	mul r0, r1, r0
	sub r0, r6, r0
	cmp r2, r0
	movle r0, r2
_0200A394:
	str r0, [r5, #8]
	b _0200A440
_0200A39C:
	ldr r0, _0200A458 // =gPlayerList
	ldr r0, [r0, r1, lsl #2]
	ldr r0, [r0, #0x48]
	cmp r0, r6
	bge _0200A3E0
	mov r0, r8
	mov r1, r7
	bl MapSys__FollowTargetY
	mov r0, #0
	bl MapSys__Func_2008F28
	ldr r1, [r4, #0xe0]
	ldr r0, [r4, #0xf0]
	orr r1, r1, #0x200
	rsb r0, r0, #0
	str r1, [r4, #0xe0]
	str r0, [r4, #0xf0]
	b _0200A440
_0200A3E0:
	ldr r1, [r5]
	ldr r0, _0200A45C // =0x00004020
	tst r1, r0
	bne _0200A440
	mov r0, r8
	mov r1, r7
	bl MapSys__FollowTargetY
	ldr r1, [r5, #0x28]
	mov r0, #0x28
	mla r0, r1, r0, r6
	ldr r2, [r5, #8]
	cmp r2, r0
	blt _0200A42C
	mov r0, #0xc0
	mul r0, r1, r0
	ldr r1, [r5, #0x64]
	sub r0, r1, r0
	cmp r2, r0
	movle r0, r2
_0200A42C:
	str r0, [r5, #8]
	b _0200A440
_0200A434:
	mov r0, r8
	mov r1, r7
	bl MapSys__FollowTargetY
_0200A440:
	mov r0, r8
	mov r1, r7
	bl MapSys__Func_200A580
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0200A450: .word mapCamera
_0200A454: .word mapSystemTask
_0200A458: .word gPlayerList
_0200A45C: .word 0x00004020
	arm_func_end MapSys__Func_2009E80

	arm_func_start MapSys__Func_200A460
MapSys__Func_200A460: // 0x0200A460
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r2, #0x70
	mul r4, r5, r2
	ldr ip, _0200A534 // =mapCamera
	ldr r2, _0200A538 // =0x00004020
	ldr r3, [ip, r4]
	mov r6, r0
	tst r3, r2
	add r4, ip, r4
	beq _0200A494
	bl MapSys__Func_200A580
	ldmia sp!, {r4, r5, r6, pc}
_0200A494:
	ldr r2, _0200A53C // =mapSystemTask
	ldr r2, [r2, #0x100]
	tst r2, #0x10000
	beq _0200A520
	tst r2, #0x20000
	ldr r3, [r4, #8]
	ldr r2, [r6, #8]
	bne _0200A4C4
	add r2, r3, r2
	str r2, [r4, #8]
	bl MapSys__Func_200AC64
	b _0200A524
_0200A4C4:
	add r2, r3, r2
	str r2, [r4, #8]
	ldr r2, [r6, #8]
	cmp r2, #0
	beq _0200A524
	bl MapSys__Func_200AA84
	cmp r0, #0
	beq _0200A524
	ldrsb r1, [r4, #0x46]
	ldr r0, _0200A540 // =gPlayerList
	ldr r2, [r4, #0x54]
	ldr r0, [r0, r1, lsl #2]
	ldr r1, _0200A53C // =mapSystemTask
	ldr r3, [r0, #0x48]
	mov r0, r6
	sub r2, r3, r2
	str r2, [r4, #8]
	ldr r2, [r1, #0x100]
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__Func_200B170
	b _0200A524
_0200A520:
	bl MapSys__FollowTargetY
_0200A524:
	mov r0, r6
	mov r1, r5
	bl MapSys__Func_200A580
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0200A534: .word mapCamera
_0200A538: .word 0x00004020
_0200A53C: .word mapSystemTask
_0200A540: .word gPlayerList
	arm_func_end MapSys__Func_200A460

	arm_func_start MapSys__HandleCamBoundsX
MapSys__HandleCamBoundsX: // 0x0200A544
	ldr r2, _0200A57C // =mapCamera
	mov r0, #0x70
	mla r3, r1, r0, r2
	ldr r0, [r3, #0x58]
	ldr r2, [r3, #4]
	cmp r2, r0
	blt _0200A574
	ldr r1, [r3, #0x60]
	ldr r0, [r3, #0x24]
	sub r0, r1, r0, lsl #8
	cmp r2, r0
	movle r0, r2
_0200A574:
	str r0, [r3, #4]
	bx lr
	.align 2, 0
_0200A57C: .word mapCamera
	arm_func_end MapSys__HandleCamBoundsX

	arm_func_start MapSys__Func_200A580
MapSys__Func_200A580: // 0x0200A580
	ldr r3, _0200A650 // =mapCamera
	mov r0, #0x70
	ldr r2, _0200A654 // =mapSystemTask
	mla r0, r1, r0, r3
	ldr r1, [r2, #0x100]
	tst r1, #0x200
	bxne lr
	tst r1, #1
	beq _0200A61C
	tst r1, #2
	bne _0200A5E0
	ldr r1, [r0, #0x5c]
	ldr r3, [r0, #8]
	cmp r3, r1
	blt _0200A5D8
	ldr r2, [r0, #0x28]
	mov r1, #0x1d0
	mul r1, r2, r1
	ldr r2, [r0, #0x64]
	sub r1, r2, r1
	cmp r3, r1
	movle r1, r3
_0200A5D8:
	str r1, [r0, #8]
	bx lr
_0200A5E0:
	ldr ip, [r0, #0x28]
	ldr r2, [r0, #0x5c]
	add r1, ip, ip, lsl #4
	ldr r3, [r0, #8]
	add r1, r2, r1, lsl #4
	cmp r3, r1
	blt _0200A614
	mov r1, #0xc0
	mul r1, ip, r1
	ldr r2, [r0, #0x64]
	sub r1, r2, r1
	cmp r3, r1
	movle r1, r3
_0200A614:
	str r1, [r0, #8]
	bx lr
_0200A61C:
	ldr r1, [r0, #0x5c]
	ldr r3, [r0, #8]
	cmp r3, r1
	blt _0200A648
	ldr r2, [r0, #0x28]
	mov r1, #0xc0
	mul r1, r2, r1
	ldr r2, [r0, #0x64]
	sub r1, r2, r1
	cmp r3, r1
	movle r1, r3
_0200A648:
	str r1, [r0, #8]
	bx lr
	.align 2, 0
_0200A650: .word mapCamera
_0200A654: .word mapSystemTask
	arm_func_end MapSys__Func_200A580

	arm_func_start MapSys__HandleHBounds
MapSys__HandleHBounds: // 0x0200A658
	ldr r2, _0200A694 // =mapCamera
	mov r0, #0x70
	mla r3, r1, r0, r2
	ldr r0, _0200A698 // =0x02133BF8
	ldr r2, [r3, #4]
	ldr r1, [r0]
	cmp r2, r1
	blt _0200A68C
	ldr r1, [r0, #8]
	ldr r0, [r3, #0x24]
	sub r1, r1, r0, lsl #8
	cmp r2, r1
	movle r1, r2
_0200A68C:
	str r1, [r3, #4]
	bx lr
	.align 2, 0
_0200A694: .word mapCamera
_0200A698: .word 0x02133BF8
	arm_func_end MapSys__HandleHBounds

	arm_func_start MapSys__HandleVBounds
MapSys__HandleVBounds: // 0x0200A69C
	stmdb sp!, {r3, lr}
	ldr r2, _0200A774 // =mapCamera
	mov r0, #0x70
	mla r2, r1, r0, r2
	ldr r3, _0200A778 // =mapSystemTask
	ldr r0, _0200A77C // =0x02133BF8
	ldr r1, [r3, #0x100]
	tst r1, #0x200
	ldmneia sp!, {r3, pc}
	tst r1, #1
	beq _0200A740
	tst r1, #2
	bne _0200A704
	ldr r1, [r0, #4]
	ldr ip, [r2, #8]
	cmp ip, r1
	blt _0200A6FC
	ldr r3, [r2, #0x28]
	mov r1, #0x1d0
	mul r1, r3, r1
	ldr r0, [r0, #0xc]
	sub r1, r0, r1
	cmp ip, r1
	movle r1, ip
_0200A6FC:
	str r1, [r2, #8]
	ldmia sp!, {r3, pc}
_0200A704:
	ldr lr, [r2, #0x28]
	ldr ip, [r0, #4]
	add r1, lr, lr, lsl #4
	ldr r3, [r2, #8]
	add r1, ip, r1, lsl #4
	cmp r3, r1
	blt _0200A738
	mov r1, #0xc0
	mul r1, lr, r1
	ldr r0, [r0, #0xc]
	sub r1, r0, r1
	cmp r3, r1
	movle r1, r3
_0200A738:
	str r1, [r2, #8]
	ldmia sp!, {r3, pc}
_0200A740:
	ldr r1, [r0, #4]
	ldr ip, [r2, #8]
	cmp ip, r1
	blt _0200A76C
	ldr r3, [r2, #0x28]
	mov r1, #0xc0
	mul r1, r3, r1
	ldr r0, [r0, #0xc]
	sub r1, r0, r1
	cmp ip, r1
	movle r1, ip
_0200A76C:
	str r1, [r2, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0200A774: .word mapCamera
_0200A778: .word mapSystemTask
_0200A77C: .word 0x02133BF8
	arm_func_end MapSys__HandleVBounds

	arm_func_start MapSys__Func_200A780
MapSys__Func_200A780: // 0x0200A780
	stmdb sp!, {r3, lr}
	ldr r3, _0200A7E0 // =mapCamera
	mov r0, #0x70
	ldr r2, _0200A7E4 // =mapSystemTask
	mla lr, r1, r0, r3
	ldr r0, [r2, #0x100]
	tst r0, #0x200
	ldmneia sp!, {r3, pc}
	ldr ip, [lr]
	tst ip, #0x100000
	ldmeqia sp!, {r3, pc}
	ldrb r2, [lr, #0x20]
	ldr r3, [lr, #0xc]
	ldr r1, [lr, #4]
	add r0, r3, r2, lsl #12
	cmp r1, r0
	strgt r0, [lr, #4]
	ldmgtia sp!, {r3, pc}
	sub r0, r3, r2, lsl #12
	cmp r1, r0
	strlt r0, [lr, #4]
	orrge r0, ip, #0x400000
	strge r0, [lr]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0200A7E0: .word mapCamera
_0200A7E4: .word mapSystemTask
	arm_func_end MapSys__Func_200A780

	arm_func_start MapSys__Func_200A7E8
MapSys__Func_200A7E8: // 0x0200A7E8
	stmdb sp!, {r3, lr}
	ldr r3, _0200A848 // =mapCamera
	mov r0, #0x70
	ldr r2, _0200A84C // =mapSystemTask
	mla lr, r1, r0, r3
	ldr r0, [r2, #0x100]
	tst r0, #0x200
	ldmneia sp!, {r3, pc}
	ldr ip, [lr]
	tst ip, #0x200000
	ldmeqia sp!, {r3, pc}
	ldrb r2, [lr, #0x21]
	ldr r3, [lr, #0x10]
	ldr r1, [lr, #8]
	add r0, r3, r2, lsl #12
	cmp r1, r0
	strgt r0, [lr, #8]
	ldmgtia sp!, {r3, pc}
	sub r0, r3, r2, lsl #12
	cmp r1, r0
	strlt r0, [lr, #8]
	orrge r0, ip, #0x800000
	strge r0, [lr]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0200A848: .word mapCamera
_0200A84C: .word mapSystemTask
	arm_func_end MapSys__Func_200A7E8

	arm_func_start MapSys__FollowTargetX
MapSys__FollowTargetX: // 0x0200A850
	mov r0, #0x70
	mul r2, r1, r0
	ldr r1, _0200A88C // =mapCamera
	ldr r0, [r1, r2]
	add r3, r1, r2
	tst r0, #0x10000
	bxeq lr
	ldrsb r2, [r3, #0x46]
	ldr r1, _0200A890 // =gPlayerList
	ldr r0, [r3, #0x48]
	ldr r1, [r1, r2, lsl #2]
	ldr r1, [r1, #0x44]
	sub r0, r1, r0
	str r0, [r3, #4]
	bx lr
	.align 2, 0
_0200A88C: .word mapCamera
_0200A890: .word gPlayerList
	arm_func_end MapSys__FollowTargetX

	arm_func_start MapSys__FollowTargetY
MapSys__FollowTargetY: // 0x0200A894
	mov r0, #0x70
	mul r2, r1, r0
	ldr r1, _0200A8D0 // =mapCamera
	ldr r0, [r1, r2]
	add r3, r1, r2
	tst r0, #0x20000
	bxeq lr
	ldrsb r2, [r3, #0x46]
	ldr r1, _0200A8D4 // =gPlayerList
	ldr r0, [r3, #0x4c]
	ldr r1, [r1, r2, lsl #2]
	ldr r1, [r1, #0x48]
	sub r0, r1, r0
	str r0, [r3, #8]
	bx lr
	.align 2, 0
_0200A8D0: .word mapCamera
_0200A8D4: .word gPlayerList
	arm_func_end MapSys__FollowTargetY

	arm_func_start MapSys__Func_200A8D8
MapSys__Func_200A8D8: // 0x0200A8D8
	add r2, r1, #1
	mov r0, #0x70
	and ip, r2, #1
	ldr r2, _0200A908 // =mapSystemTask
	mul r3, r1, r0
	smulbb r0, ip, r0
	ldr r1, _0200A90C // =0x02133ACC
	ldr r2, [r2, #0x10c]
	ldr r0, [r1, r0]
	add r0, r2, r0
	str r0, [r1, r3]
	bx lr
	.align 2, 0
_0200A908: .word mapSystemTask
_0200A90C: .word 0x02133ACC
	arm_func_end MapSys__Func_200A8D8

	arm_func_start MapSys__Func_200A910
MapSys__Func_200A910: // 0x0200A910
	add r2, r1, #1
	mov r0, #0x70
	and ip, r2, #1
	ldr r2, _0200A940 // =mapSystemTask
	mul r3, r1, r0
	smulbb r0, ip, r0
	ldr r1, _0200A944 // =0x02133AD0
	ldr r2, [r2, #0x110]
	ldr r0, [r1, r0]
	add r0, r2, r0
	str r0, [r1, r3]
	bx lr
	.align 2, 0
_0200A940: .word mapSystemTask
_0200A944: .word 0x02133AD0
	arm_func_end MapSys__Func_200A910

	arm_func_start MapSys__Func_200A948
MapSys__Func_200A948: // 0x0200A948
	stmdb sp!, {r4, lr}
	ldr r0, _0200AA0C // =mapSystemTask
	ldr r4, _0200AA10 // =mapCamera
	ldr r0, [r0, #0x100]
	tst r0, #2
	bne _0200A9B0
	ldr r2, [r4, #8]
	ldr r1, [r4, #0x28]
	mov r0, #0xe8
	ldrsb ip, [r4, #0x46]
	ldr r3, _0200AA14 // =gPlayerList
	mla r0, r1, r0, r2
	ldr r1, [r3, ip, lsl #2]
	ldr r1, [r1, #0x48]
	cmp r1, r0
	ble _0200AA04
	mov r0, #1
	bl MapSys__Func_2008F28
	ldr r1, [r4, #0xe0]
	ldr r0, [r4, #0xf0]
	orr r1, r1, #0x200
	rsb r0, r0, #0
	str r0, [r4, #0xf0]
	str r1, [r4, #0xe0]
	mov r0, #1
	ldmia sp!, {r4, pc}
_0200A9B0:
	ldr r1, [r4, #0x28]
	mov r0, #0x28
	mul r0, r1, r0
	ldr r1, [r4, #8]
	ldrsb r3, [r4, #0x46]
	ldr r2, _0200AA14 // =gPlayerList
	sub r0, r1, r0
	ldr r1, [r2, r3, lsl #2]
	ldr r1, [r1, #0x48]
	cmp r1, r0
	bge _0200AA04
	mov r0, #0
	bl MapSys__Func_2008F28
	ldr r1, [r4, #0xe0]
	ldr r0, [r4, #0xf0]
	orr r1, r1, #0x200
	rsb r0, r0, #0
	str r0, [r4, #0xf0]
	str r1, [r4, #0xe0]
	mov r0, #1
	ldmia sp!, {r4, pc}
_0200AA04:
	mov r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0200AA0C: .word mapSystemTask
_0200AA10: .word mapCamera
_0200AA14: .word gPlayerList
	arm_func_end MapSys__Func_200A948

	arm_func_start MapSys__Func_200AA18
MapSys__Func_200AA18: // 0x0200AA18
	ldr r0, [r0, #8]
	ldr r3, _0200AA7C // =mapCamera
	cmp r0, #0
	ldrsb r1, [r3, #0x46]
	blt _0200AA54
	ldr r0, _0200AA80 // =gPlayerList
	ldr r2, [r3, #8]
	ldr r0, [r0, r1, lsl #2]
	ldr r1, [r3, #0x54]
	ldr r0, [r0, #0x48]
	add r1, r2, r1
	cmp r1, r0
	movge r0, #1
	movlt r0, #0
	bx lr
_0200AA54:
	ldr r0, _0200AA80 // =gPlayerList
	ldr r2, [r3, #8]
	ldr r0, [r0, r1, lsl #2]
	ldr r1, [r3, #0x54]
	ldr r0, [r0, #0x48]
	add r1, r2, r1
	cmp r1, r0
	movle r0, #1
	movgt r0, #0
	bx lr
	.align 2, 0
_0200AA7C: .word mapCamera
_0200AA80: .word gPlayerList
	arm_func_end MapSys__Func_200AA18

	arm_func_start MapSys__Func_200AA84
MapSys__Func_200AA84: // 0x0200AA84
	ldr r3, _0200AAF0 // =mapCamera
	mov r2, #0x70
	mla r3, r1, r2, r3
	ldr r0, [r0, #8]
	ldrsb r1, [r3, #0x46]
	cmp r0, #0
	blt _0200AAC8
	ldr r0, _0200AAF4 // =gPlayerList
	ldr r2, [r3, #8]
	ldr r0, [r0, r1, lsl #2]
	ldr r1, [r3, #0x54]
	ldr r0, [r0, #0x48]
	add r1, r2, r1
	cmp r1, r0
	movge r0, #1
	movlt r0, #0
	bx lr
_0200AAC8:
	ldr r0, _0200AAF4 // =gPlayerList
	ldr r2, [r3, #8]
	ldr r0, [r0, r1, lsl #2]
	ldr r1, [r3, #0x54]
	ldr r0, [r0, #0x48]
	add r1, r2, r1
	cmp r1, r0
	movle r0, #1
	movgt r0, #0
	bx lr
	.align 2, 0
_0200AAF0: .word mapCamera
_0200AAF4: .word gPlayerList
	arm_func_end MapSys__Func_200AA84

	arm_func_start MapSys__Func_200AAF8
MapSys__Func_200AAF8: // 0x0200AAF8
	stmdb sp!, {r3, lr}
	ldr r2, _0200AC58 // =mapSystemTask
	ldr r1, _0200AC5C // =mapCamera
	ldr r2, [r2, #0x100]
	tst r2, #0x200
	movne r0, #0
	ldmneia sp!, {r3, pc}
	tst r2, #2
	bne _0200ABAC
	ands r3, r2, #0x20000
	bne _0200AB30
	ldr r2, [r0]
	tst r2, #2
	bne _0200AB44
_0200AB30:
	cmp r3, #0
	beq _0200AB60
	ldr r0, [r0]
	tst r0, #4
	beq _0200AB60
_0200AB44:
	ldr r2, [r1, #0x5c]
	ldr r0, [r1, #8]
	cmp r0, r2
	bgt _0200ABA4
	str r2, [r1, #8]
	mov r0, #1
	ldmia sp!, {r3, pc}
_0200AB60:
	ldr r2, [r1, #0x28]
	mov r0, #0x60
	ldrsb lr, [r1, #0x46]
	ldr ip, _0200AC60 // =gPlayerList
	mul r3, r2, r0
	ldr r2, [ip, lr, lsl #2]
	ldr r0, [r1, #8]
	ldr r2, [r2, #0x48]
	sub r2, r2, r3
	cmp r0, r2
	blt _0200ABA4
	ldr r0, [r1, #0x5c]
	str r2, [r1, #8]
	cmp r2, r0
	strlt r0, [r1, #8]
	mov r0, #1
	ldmia sp!, {r3, pc}
_0200ABA4:
	mov r0, #0
	ldmia sp!, {r3, pc}
_0200ABAC:
	ands r3, r2, #0x20000
	bne _0200ABC0
	ldr r2, [r0]
	tst r2, #2
	bne _0200ABD4
_0200ABC0:
	cmp r3, #0
	beq _0200AC28
	ldr r0, [r0]
	tst r0, #4
	beq _0200AC28
_0200ABD4:
	ldr r2, [r1, #0x28]
	mov r0, #0x58
	ldrsb lr, [r1, #0x46]
	ldr ip, _0200AC60 // =gPlayerList
	mul r3, r2, r0
	ldr ip, [ip, lr, lsl #2]
	ldr r0, [r1, #8]
	ldr ip, [ip, #0x48]
	sub ip, ip, r3
	cmp r0, ip
	bgt _0200AC50
	mov r0, #0xc0
	mul r3, r2, r0
	ldr r2, [r1, #0x64]
	add r0, ip, r3
	cmp r2, r0
	str ip, [r1, #8]
	sublt r0, r2, r3
	strlt r0, [r1, #8]
	mov r0, #1
	ldmia sp!, {r3, pc}
_0200AC28:
	ldr r2, [r1, #0x28]
	mov r0, #0xc0
	mul r3, r2, r0
	ldr r2, [r1, #0x64]
	ldr r0, [r1, #8]
	sub r2, r2, r3
	cmp r0, r2
	strge r2, [r1, #8]
	movge r0, #1
	ldmgeia sp!, {r3, pc}
_0200AC50:
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0200AC58: .word mapSystemTask
_0200AC5C: .word mapCamera
_0200AC60: .word gPlayerList
	arm_func_end MapSys__Func_200AAF8

	arm_func_start MapSys__Func_200AC64
MapSys__Func_200AC64: // 0x0200AC64
	ldr r3, _0200AD2C // =mapCamera
	mov r2, #0x70
	mla r2, r1, r2, r3
	ldrsb ip, [r2, #0x46]
	ldr r3, _0200AD30 // =gPlayerList
	ldr r1, _0200AD34 // =mapSystemTask
	ldr ip, [r3, ip, lsl #2]
	ldr r3, [r1, #0x100]
	ldr r1, [ip, #0x48]
	ands ip, r3, #0x20000
	bne _0200AC9C
	ldr r3, [r0]
	tst r3, #2
	bne _0200ACB0
_0200AC9C:
	cmp ip, #0
	beq _0200ACEC
	ldr r0, [r0]
	tst r0, #4
	beq _0200ACEC
_0200ACB0:
	ldr r0, [r2, #0x5c]
	ldr ip, [r2, #8]
	cmp ip, r0
	strle r0, [r2, #8]
	movle r0, #1
	bxle lr
	ldr r3, [r2, #0x28]
	mov r0, #0xa8
	mul r0, r3, r0
	sub r0, r1, r0
	cmp ip, r0
	bgt _0200AD24
	str r0, [r2, #8]
	mov r0, #1
	bx lr
_0200ACEC:
	ldr r0, [r2, #0x64]
	ldr ip, [r2, #8]
	cmp ip, r0
	strge r0, [r2, #8]
	movge r0, #1
	bxge lr
	ldr r3, [r2, #0x28]
	mov r0, #0x18
	mul r0, r3, r0
	sub r0, r1, r0
	cmp ip, r0
	strge r0, [r2, #8]
	movge r0, #1
	bxge lr
_0200AD24:
	mov r0, #0
	bx lr
	.align 2, 0
_0200AD2C: .word mapCamera
_0200AD30: .word gPlayerList
_0200AD34: .word mapSystemTask
	arm_func_end MapSys__Func_200AC64

	arm_func_start MapSys__HandleCamLook
MapSys__HandleCamLook: // 0x0200AD38
	stmdb sp!, {r3, lr}
	ldr r1, _0200AD60 // =mapSystemTask
	ldr r1, [r1, #0x100]
	tst r1, #0x100
	ldmneia sp!, {r3, pc}
	ldr r1, [r0, #0xc]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0200AD60: .word mapSystemTask
	arm_func_end MapSys__HandleCamLook

	arm_func_start MapSys__HandleCameraLookUpDown
MapSys__HandleCameraLookUpDown: // 0x0200AD64
	ldr r1, _0200AE30 // =mapSystemTask
	ldr r3, _0200AE34 // =gPlayerList
	ldrsb r2, [r1, #0x66]
	ldr r1, _0200AE38 // =mapCamera
	ldr r2, [r3, r2, lsl #2]
	add r2, r2, #0x700
	ldrh r2, [r2, #0x20]
	tst r2, #0x40
	beq _0200ADD0
	ldrsb r2, [r1, #0x46]
	ldr r2, [r3, r2, lsl #2]
	add r2, r2, #0x500
	ldrsh r2, [r2, #0xd4]
	sub r2, r2, #0x22
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	cmp r2, #1
	bhi _0200ADD0
	ldr r2, [r0]
	mov r3, #0
	orr r2, r2, #2
	str r2, [r0]
	ldr r2, _0200AE3C // =MapSys__Func_200AE40
	strh r3, [r0, #6]
	str r2, [r0, #0xc]
_0200ADD0:
	ldrsb r2, [r1, #0x46]
	ldr r1, _0200AE34 // =gPlayerList
	ldr r2, [r1, r2, lsl #2]
	add r1, r2, #0x700
	ldrh r1, [r1, #0x20]
	tst r1, #0x80
	bxeq lr
	add r1, r2, #0x500
	ldrsh r1, [r1, #0xd4]
	sub r1, r1, #2
	mov r1, r1, lsl #0x10
	mov r1, r1, asr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r1, #1
	bxhi lr
	ldr r1, [r0]
	mov r2, #0
	orr r1, r1, #4
	str r1, [r0]
	ldr r1, _0200AE3C // =MapSys__Func_200AE40
	strh r2, [r0, #6]
	str r1, [r0, #0xc]
	bx lr
	.align 2, 0
_0200AE30: .word mapSystemTask
_0200AE34: .word gPlayerList
_0200AE38: .word mapCamera
_0200AE3C: .word MapSys__Func_200AE40
	arm_func_end MapSys__HandleCameraLookUpDown

	arm_func_start MapSys__Func_200AE40
MapSys__Func_200AE40: // 0x0200AE40
	stmdb sp!, {r3, lr}
	ldr r1, _0200AF4C // =mapSystemTask
	ldr r2, _0200AF50 // =mapCamera
	ldr r1, [r1, #0x100]
	tst r1, #0x40000
	beq _0200AE60
	bl MapSys__Func_200B170
	ldmia sp!, {r3, pc}
_0200AE60:
	ldrsb r2, [r2, #0x46]
	ldr r1, _0200AF54 // =gPlayerList
	ldr r2, [r1, r2, lsl #2]
	add r1, r2, #0x700
	ldrh r3, [r1, #0x20]
	tst r3, #1
	beq _0200AE84
	bl MapSys__Func_200B170
	ldmia sp!, {r3, pc}
_0200AE84:
	ldr ip, [r0]
	tst ip, #2
	beq _0200AEB4
	tst r3, #0x40
	beq _0200AEAC
	add r1, r2, #0x500
	ldrsh r1, [r1, #0xd4]
	cmp r1, #0x22
	cmpne r1, #0x23
	beq _0200AEB4
_0200AEAC:
	bl MapSys__Func_200B170
	ldmia sp!, {r3, pc}
_0200AEB4:
	tst ip, #4
	beq _0200AEE0
	tst r3, #0x80
	beq _0200AED8
	add r1, r2, #0x500
	ldrsh r1, [r1, #0xd4]
	cmp r1, #2
	cmpne r1, #3
	beq _0200AEE0
_0200AED8:
	bl MapSys__Func_200B170
	ldmia sp!, {r3, pc}
_0200AEE0:
	ldrsh r1, [r0, #6]
	add r1, r1, #1
	strh r1, [r0, #6]
	ldrsh r1, [r0, #6]
	cmp r1, #0x3c
	ldmltia sp!, {r3, pc}
	mov ip, #0
	strh ip, [r0, #6]
	ldr r1, [r0]
	tst r1, #2
	beq _0200AF2C
	ldr r1, _0200AF4C // =mapSystemTask
	ldr r2, _0200AF58 // =MapSys__Func_200AF60
	ldr r3, [r1, #0x100]
	orr r3, r3, #0x10000
	str r3, [r1, #0x100]
	str ip, [r0, #8]
	str r2, [r0, #0xc]
	ldmia sp!, {r3, pc}
_0200AF2C:
	ldr r1, _0200AF4C // =mapSystemTask
	ldr r2, _0200AF5C // =MapSys__Func_200B068
	ldr r3, [r1, #0x100]
	orr r3, r3, #0x10000
	str r3, [r1, #0x100]
	str ip, [r0, #8]
	str r2, [r0, #0xc]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0200AF4C: .word mapSystemTask
_0200AF50: .word mapCamera
_0200AF54: .word gPlayerList
_0200AF58: .word MapSys__Func_200AF60
_0200AF5C: .word MapSys__Func_200B068
	arm_func_end MapSys__Func_200AE40

	arm_func_start MapSys__Func_200AF60
MapSys__Func_200AF60: // 0x0200AF60
	ldr r1, _0200B018 // =mapSystemTask
	ldr r3, _0200B01C // =mapCamera
	ldr r2, [r1, #0x100]
	tst r2, #0x40000
	beq _0200AF94
	mov r3, #0
	ldr r2, _0200B020 // =MapSys__Func_200B028
	str r3, [r0, #8]
	str r2, [r0, #0xc]
	ldr r0, [r1, #0x100]
	orr r0, r0, #0x20000
	str r0, [r1, #0x100]
	bx lr
_0200AF94:
	ldrsb r2, [r3, #0x46]
	ldr r1, _0200B024 // =gPlayerList
	ldr r2, [r1, r2, lsl #2]
	add r1, r2, #0x700
	ldrh r1, [r1, #0x20]
	tst r1, #0x40
	beq _0200AFC4
	add r1, r2, #0x500
	ldrsh r1, [r1, #0xd4]
	cmp r1, #0x22
	cmpne r1, #0x23
	beq _0200AFE8
_0200AFC4:
	mov r1, #0
	str r1, [r0, #8]
	ldr r2, _0200B020 // =MapSys__Func_200B028
	ldr r1, _0200B018 // =mapSystemTask
	str r2, [r0, #0xc]
	ldr r0, [r1, #0x100]
	orr r0, r0, #0x20000
	str r0, [r1, #0x100]
	bx lr
_0200AFE8:
	ldr r3, [r3, #0x28]
	mov r1, #0x800
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xe
	adds ip, r1, r3, lsl #14
	orr r2, r2, r3, lsr #18
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	rsb r1, r2, #0
	str r1, [r0, #8]
	bx lr
	.align 2, 0
_0200B018: .word mapSystemTask
_0200B01C: .word mapCamera
_0200B020: .word MapSys__Func_200B028
_0200B024: .word gPlayerList
	arm_func_end MapSys__Func_200AF60

	arm_func_start MapSys__Func_200B028
MapSys__Func_200B028: // 0x0200B028
	ldr r2, _0200B064 // =mapSystemTask
	mov r1, #0x800
	ldr r3, [r2, #0x100]
	orr r3, r3, #0x20000
	str r3, [r2, #0x100]
	ldr r3, [r2, #0x48]
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0x10
	adds ip, r1, r3, lsl #16
	orr r2, r2, r3, lsr #16
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #8]
	bx lr
	.align 2, 0
_0200B064: .word mapSystemTask
	arm_func_end MapSys__Func_200B028

	arm_func_start MapSys__Func_200B068
MapSys__Func_200B068: // 0x0200B068
	ldr r1, _0200B11C // =mapSystemTask
	ldr r3, _0200B120 // =mapCamera
	ldr r2, [r1, #0x100]
	tst r2, #0x40000
	beq _0200B09C
	mov r3, #0
	ldr r2, _0200B124 // =MapSys__Func_200B12C
	str r3, [r0, #8]
	str r2, [r0, #0xc]
	ldr r0, [r1, #0x100]
	orr r0, r0, #0x20000
	str r0, [r1, #0x100]
	bx lr
_0200B09C:
	ldrsb r2, [r3, #0x46]
	ldr r1, _0200B128 // =gPlayerList
	ldr r2, [r1, r2, lsl #2]
	add r1, r2, #0x700
	ldrh r1, [r1, #0x20]
	tst r1, #0x80
	beq _0200B0CC
	add r1, r2, #0x500
	ldrsh r1, [r1, #0xd4]
	cmp r1, #2
	cmpne r1, #3
	beq _0200B0F0
_0200B0CC:
	mov r1, #0
	str r1, [r0, #8]
	ldr r2, _0200B124 // =MapSys__Func_200B12C
	ldr r1, _0200B11C // =mapSystemTask
	str r2, [r0, #0xc]
	ldr r0, [r1, #0x100]
	orr r0, r0, #0x20000
	str r0, [r1, #0x100]
	bx lr
_0200B0F0:
	ldr r3, [r3, #0x28]
	mov r1, #0x800
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xe
	adds ip, r1, r3, lsl #14
	orr r2, r2, r3, lsr #18
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #8]
	bx lr
	.align 2, 0
_0200B11C: .word mapSystemTask
_0200B120: .word mapCamera
_0200B124: .word MapSys__Func_200B12C
_0200B128: .word gPlayerList
	arm_func_end MapSys__Func_200B068

	arm_func_start MapSys__Func_200B12C
MapSys__Func_200B12C: // 0x0200B12C
	ldr r2, _0200B16C // =mapSystemTask
	mov r1, #0x800
	ldr r3, [r2, #0x100]
	orr r3, r3, #0x20000
	str r3, [r2, #0x100]
	ldr r3, [r2, #0x48]
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0x10
	adds ip, r1, r3, lsl #16
	orr r2, r2, r3, lsr #16
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	rsb r1, r2, #0
	str r1, [r0, #8]
	bx lr
	.align 2, 0
_0200B16C: .word mapSystemTask
	arm_func_end MapSys__Func_200B12C

	arm_func_start MapSys__Func_200B170
MapSys__Func_200B170: // 0x0200B170
	ldr r1, _0200B1AC // =mapSystemTask
	mov r3, #0
	ldr ip, [r1, #0x100]
	ldr r2, _0200B1B0 // =MapSys__HandleCameraLookUpDown
	bic ip, ip, #0x10000
	bic ip, ip, #0x20000
	str ip, [r1, #0x100]
	ldr r1, [r0]
	bic r1, r1, #2
	bic r1, r1, #4
	str r1, [r0]
	strh r3, [r0, #6]
	str r3, [r0, #8]
	str r2, [r0, #0xc]
	bx lr
	.align 2, 0
_0200B1AC: .word mapSystemTask
_0200B1B0: .word MapSys__HandleCameraLookUpDown
	arm_func_end MapSys__Func_200B170

	arm_func_start MapSys__Func_200B1B4
MapSys__Func_200B1B4: // 0x0200B1B4
	ldr r1, _0200B224 // =mapSystemTask
	ldr r0, _0200B228 // =mapCamera
	ldr r2, [r1, #0x100]
	tst r2, #1
	bxne lr
	ldr r0, [r0, #0xe0]
	tst r0, #0x800
	bxne lr
	ldr r0, _0200B22C // =padInput
	ldrh r0, [r0, #4]
	tst r0, #4
	bxeq lr
	tst r2, #2
	beq _0200B208
	ldr r0, _0200B230 // =renderCurrentDisplay
	mov r3, #1
	bic r2, r2, #2
	str r3, [r0]
	orr r0, r2, #0x200
	str r0, [r1, #0x100]
	bx lr
_0200B208:
	ldr r0, _0200B230 // =renderCurrentDisplay
	orr r2, r2, #2
	mov r3, #0
	str r3, [r0]
	orr r0, r2, #0x200
	str r0, [r1, #0x100]
	bx lr
	.align 2, 0
_0200B224: .word mapSystemTask
_0200B228: .word mapCamera
_0200B22C: .word padInput
_0200B230: .word renderCurrentDisplay
	arm_func_end MapSys__Func_200B1B4

	.rodata
	
.public MapSys__ZoneLoadBossMapTable
MapSys__ZoneLoadBossMapTable: // 0x0210E02C
	.word MapSys__LoadBossMap_Zone1, MapSys__LoadBossMap_Zone2
	.word MapSys__LoadBossMap_Zone3, MapSys__LoadBossMap_Zone4
	.word MapSys__LoadBossMap_Zone5, MapSys__LoadBossMap_Zone6
	.word MapSys__LoadBossMap_Zone7, MapSys__LoadBossMap_ZoneF
	.word 0

.public MapSys__ZoneLoadBossTilesTable
MapSys__ZoneLoadBossTilesTable: // 0x0210E050
	.word MapSys__LoadBossTiles_Zone1, MapSys__LoadBossTiles_Zone2
	.word MapSys__LoadBossTiles_Zone3, MapSys__LoadBossTiles_Zone4
	.word MapSys__LoadBossTiles_Zone5, MapSys__LoadBossTiles_Zone6
	.word MapSys__LoadBossTiles_Zone7, MapSys__LoadBossTiles_ZoneF
	.word 0

	.data
	
aMAP: // 0x02118AC8
	.asciz "MAP"
	
aRAW: // 0x02118ACC
	.asciz "RAW"