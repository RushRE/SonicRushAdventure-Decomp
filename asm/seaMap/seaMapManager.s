	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public SeaMapManager__sVars
SeaMapManager__sVars: // 0x02134188
	.space 0x14

	.text

	arm_func_start SeaMapManager__SaveClearCallback_Chart
SeaMapManager__SaveClearCallback_Chart: // 0x02043548
	stmdb sp!, {r4, lr}
	mov r4, r0
	tst r1, #8
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x1d0
	bl SeaMapManager__ClearSeaMap
	add r0, r4, #0x890
	bl SeaMapManager__ClearSaveFlags
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__SaveClearCallback_Chart

	arm_func_start SeaMapManager__Create
SeaMapManager__Create: // 0x0204356C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r4, r1
	mov r5, r0
	mov r0, r4
	mov r1, r2
	bl SeaMapManager__InitArchives
	bl InitSeaMapEventTriggerSystem
	mov r0, #0x100
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r0, #0x19c
	str r0, [sp, #8]
	ldr r0, _02043670 // =SeaMapManager__Main
	ldr r1, _02043674 // =SeaMapManager__Destructor
	mov r3, r2
	bl TaskCreate_
	ldr r1, _02043678 // =SeaMapManager__sVars
	str r0, [r1]
	bl GetTaskWork_
	mov r6, r0
	mov r0, #0
	mov r1, r6
	mov r2, #0x19c
	bl MIi_CpuClear16
	ldr r0, _0204367C // =0x0000A098
	bl _AllocHeadHEAP_USER
	str r0, [r6, #0x138]
	mov r0, #0
	ldr r1, [r6, #0x138]
	ldr r2, _0204367C // =0x0000A098
	bl MIi_CpuClear16
	str r5, [r6, #0x158]
	mov r0, #0
	str r0, [r6]
	ldr r1, _02043680 // =SeaMapManager__State_2044DC8
	add r0, r6, #0x13c
	str r1, [r6, #0x198]
	str r4, [r6, #0x194]
	bl TouchField__Init
	mov r0, #0
	str r0, [r6, #0x148]
	strb r0, [r6, #0x14e]
	strb r0, [r6, #0x14c]
	add r0, r6, #0x15c
	bl SeaMapManager__LoadAssets
	mov r0, r6
	bl SeaMapManager__InitBackgrounds
	mov r0, #1
	bl SeaMapManager__EnableTouchField
	mov r0, r5
	bl SeaMapManager__SetupDisplay
	mov r0, r6
	bl SeaMapManager__LoadBackgroundPixels
	mov r0, r6
	bl SeaMapManager__LoadBackgroundPalette
	bl SaveGame__GetGameProgress
	cmp r0, #0xe
	blt _02043660
	bl SeaMapCollision__UpdateMapCollision
_02043660:
	mov r0, #0xf
	bl SeaMapManager__EnableDrawFlags
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02043670: .word SeaMapManager__Main
_02043674: .word SeaMapManager__Destructor
_02043678: .word SeaMapManager__sVars
_0204367C: .word 0x0000A098
_02043680: .word SeaMapManager__State_2044DC8
	arm_func_end SeaMapManager__Create

	arm_func_start SeaMapManager__Destroy
SeaMapManager__Destroy: // 0x02043684
	stmdb sp!, {r3, lr}
	bl SeaMapManager__Release
	bl SeaMapManager__IsActive
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl ReleaseSeaMapEventTriggerSystem
	ldr r0, _020436AC // =SeaMapManager__sVars
	ldr r0, [r0, #0]
	bl DestroyTask
	ldmia sp!, {r3, pc}
	.align 2, 0
_020436AC: .word SeaMapManager__sVars
	arm_func_end SeaMapManager__Destroy

	arm_func_start SeaMapManager__IsActive
SeaMapManager__IsActive: // 0x020436B0
	ldr r0, _020436C8 // =SeaMapManager__sVars
	ldr r0, [r0, #0]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_020436C8: .word SeaMapManager__sVars
	arm_func_end SeaMapManager__IsActive

	arm_func_start SeaMapManager__GetWork
SeaMapManager__GetWork: // 0x020436CC
	ldr r0, _020436DC // =SeaMapManager__sVars
	ldr ip, _020436E0 // =GetTaskWork_
	ldr r0, [r0, #0]
	bx ip
	.align 2, 0
_020436DC: .word SeaMapManager__sVars
_020436E0: .word GetTaskWork_
	arm_func_end SeaMapManager__GetWork

	arm_func_start SeaMapManager__EnableTouchField
SeaMapManager__EnableTouchField: // 0x020436E4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetWork
	str r4, [r0, #0x154]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__EnableTouchField

	arm_func_start SeaMapManager__EnableDrawFlags
SeaMapManager__EnableDrawFlags: // 0x020436F8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetWork
	ldr r1, [r0, #0x134]
	orr r1, r1, r4
	str r1, [r0, #0x134]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__EnableDrawFlags

	arm_func_start SeaMapManager__SetZoomLevel
SeaMapManager__SetZoomLevel: // 0x02043714
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SeaMapManager__GetWork
	mov r4, r0
	str r5, [r4]
	bl SeaMapManager__InitBackgrounds
	mov r0, r4
	bl SeaMapManager__LoadBackgroundPixels
	mov r0, r4
	bl SeaMapManager__LoadBackgroundPalette
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManager__SetZoomLevel

	arm_func_start SeaMapManager__GetZoomLevel
SeaMapManager__GetZoomLevel: // 0x02043740
	stmdb sp!, {r3, lr}
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0]
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapManager__GetZoomLevel

	arm_func_start SeaMapManager__GetZoomOutScale
SeaMapManager__GetZoomOutScale: // 0x02043750
	stmdb sp!, {r3, lr}
	bl SeaMapManager__GetWork
	ldr r1, [r0, #0]
	ldr r0, _02043768 // =SeaMapManager__ZoomOutScaleTable
	ldr r0, [r0, r1, lsl #2]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02043768: .word SeaMapManager__ZoomOutScaleTable
	arm_func_end SeaMapManager__GetZoomOutScale

	arm_func_start SeaMapManager__GetZoomInScale
SeaMapManager__GetZoomInScale: // 0x0204376C
	stmdb sp!, {r3, lr}
	bl SeaMapManager__GetWork
	ldr r1, [r0, #0]
	ldr r0, _02043784 // =SeaMapManager__ZoomInScaleTable
	ldr r0, [r0, r1, lsl #2]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02043784: .word SeaMapManager__ZoomInScaleTable
	arm_func_end SeaMapManager__GetZoomInScale

	arm_func_start SeaMapManager__Draw
SeaMapManager__Draw: // 0x02043788
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x134]
	tst r1, #1
	beq _020437A0
	bl SeaMapManager__Draw0
_020437A0:
	ldr r0, [r4, #0x134]
	tst r0, #2
	beq _020437B4
	mov r0, r4
	bl SeaMapManager__Draw1
_020437B4:
	ldr r0, [r4, #0x134]
	tst r0, #4
	beq _020437C8
	mov r0, r4
	bl SeaMapManager__Draw2
_020437C8:
	ldr r0, [r4, #0x134]
	tst r0, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl SeaMapManager__Draw3
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__Draw

	arm_func_start SeaMapManager__Draw0
SeaMapManager__Draw0: // 0x020437E0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetZoomOutScale
	ldr r1, [r4, #4]
	smull r2, r1, r0, r1
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	mov r1, r2, asr #0xc
	str r1, [r4, #0x1c]
	ldr r1, [r4, #8]
	smull r2, r1, r0, r1
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r1, r1, asr #0xc
	add r0, r4, #0x14
	str r1, [r4, #0x20]
	bl DrawBackground
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__Draw0

	arm_func_start SeaMapManager__Draw1
SeaMapManager__Draw1: // 0x02043838
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetZoomOutScale
	ldr r1, [r4, #4]
	smull r2, r1, r0, r1
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	mov r1, r2, asr #0xc
	str r1, [r4, #0x64]
	ldr r1, [r4, #8]
	smull r2, r1, r0, r1
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r1, r1, asr #0xc
	add r0, r4, #0x5c
	str r1, [r4, #0x68]
	bl DrawBackground
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__Draw1

	arm_func_start SeaMapManager__Draw2
SeaMapManager__Draw2: // 0x02043890
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetZoomOutScale
	ldr r1, [r4, #4]
	smull r2, r1, r0, r1
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	mov r1, r2, asr #0xc
	str r1, [r4, #0xac]
	ldr r1, [r4, #8]
	smull r2, r1, r0, r1
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r1, r1, asr #0xc
	add r0, r4, #0xa4
	str r1, [r4, #0xb0]
	bl DrawBackground
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__Draw2

	arm_func_start SeaMapManager__Draw3
SeaMapManager__Draw3: // 0x020438E8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x138]
	bl SeaMapManager__GetZoomOutScale
	ldr r2, [r5, #4]
	ldr r1, [r5, #8]
	smull r2, r3, r0, r2
	adds ip, r2, #0x800
	smull r2, r1, r0, r1
	adc lr, r3, #0
	mov r0, ip, lsr #0xc
	adds r2, r2, #0x800
	adc ip, r1, #0
	mov r1, r2, lsr #0xc
	add r2, sp, #0
	add r3, sp, #2
	orr r0, r0, lr, lsl #20
	orr r1, r1, ip, lsl #20
	bl SeaMapManager__Func_2043B28
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	bl SeaMapManager__Func_2044F24
	add r0, r4, #0x6c00
	mov r1, #0x3000
	bl DC_StoreRange
	add r0, r4, #0x6c00
	ldr r4, [r5, #0x158]
	ldr r3, _02043970 // =VRAMSystem__VRAM_BG
	mov r1, #0x3000
	ldr r3, [r3, r4, lsl #2]
	mov r2, #0
	add r3, r3, #0x18000
	bl QueueUncompressedPixels
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02043970: .word VRAMSystem__VRAM_BG
	arm_func_end SeaMapManager__Draw3

	arm_func_start SeaMapManager__Func_2043974
SeaMapManager__Func_2043974: // 0x02043974
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl SeaMapManager__GetWork
	mov r3, r0
	mov r0, r5
	mov r1, r4
	add r2, r3, #4
	add r3, r3, #8
	bl SeaMapManager__Func_2043C08
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManager__Func_2043974

	arm_func_start SeaMapManager__GetXPos
SeaMapManager__GetXPos: // 0x020439A0
	stmdb sp!, {r3, lr}
	bl SeaMapManager__GetWork
	ldr r0, [r0, #4]
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapManager__GetXPos

	arm_func_start SeaMapManager__GetYPos
SeaMapManager__GetYPos: // 0x020439B0
	stmdb sp!, {r3, lr}
	bl SeaMapManager__GetWork
	ldr r0, [r0, #8]
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapManager__GetYPos

	arm_func_start SeaMapManager__GetPosition
SeaMapManager__GetPosition: // 0x020439C0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r2
	mov r8, r0
	mov r7, r1
	mov r5, r3
	bl SeaMapManager__GetWork
	mov r4, r0
	bl SeaMapManager__GetZoomInScale
	cmp r6, #0
	ldrne r1, [r4, #4]
	mlane r1, r0, r8, r1
	strne r1, [r6]
	cmp r5, #0
	ldrne r1, [r4, #8]
	mlane r1, r0, r7, r1
	strne r1, [r5]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end SeaMapManager__GetPosition

	arm_func_start SeaMapManager__Func_2043A04
SeaMapManager__Func_2043A04: // 0x02043A04
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r2
	mov r8, r0
	mov r7, r1
	mov r5, r3
	bl SeaMapManager__GetWork
	mov r4, r0
	bl SeaMapManager__GetZoomOutScale
	cmp r6, #0
	beq _02043A50
	ldr r1, [r4, #4]
	sub r1, r8, r1
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	mov r1, r2, asr #0xc
	strh r1, [r6]
_02043A50:
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [r4, #8]
	sub r1, r7, r1
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r0, r1, asr #0xc
	strh r0, [r5]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end SeaMapManager__Func_2043A04

	arm_func_start SeaMapManager__Func_2043A80
SeaMapManager__Func_2043A80: // 0x02043A80
	cmp r2, #0
	movne r0, r0, asr #0xf
	strneh r0, [r2]
	cmp r3, #0
	movne r0, r1, asr #0xf
	strneh r0, [r3]
	bx lr
	arm_func_end SeaMapManager__Func_2043A80

	arm_func_start SeaMapManager__Func_2043A9C
SeaMapManager__Func_2043A9C: // 0x02043A9C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r2
	mov r4, r3
	add r2, sp, #4
	add r3, sp, #0
	bl SeaMapManager__GetPosition
	ldr r0, [sp, #4]
	ldr r1, [sp]
	mov r2, r5
	mov r3, r4
	bl SeaMapManager__Func_2043B28
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManager__Func_2043A9C

	arm_func_start SeaMapManager__Func_2043AD4
SeaMapManager__Func_2043AD4: // 0x02043AD4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r2
	mov r4, r3
	add r2, sp, #4
	add r3, sp, #0
	bl SeaMapManager__GetPosition2
	ldr r0, [sp, #4]
	ldr r1, [sp]
	mov r2, r5
	mov r3, r4
	bl SeaMapManager__Func_2043A04
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManager__Func_2043AD4

	arm_func_start SeaMapManager__Func_2043B0C
SeaMapManager__Func_2043B0C: // 0x02043B0C
	cmp r2, #0
	movne r0, r0, asr #2
	strneh r0, [r2]
	cmp r3, #0
	movne r0, r1, asr #2
	strneh r0, [r3]
	bx lr
	arm_func_end SeaMapManager__Func_2043B0C

	arm_func_start SeaMapManager__Func_2043B28
SeaMapManager__Func_2043B28: // 0x02043B28
	cmp r2, #0
	movne r0, r0, asr #0xd
	strneh r0, [r2]
	cmp r3, #0
	movne r0, r1, asr #0xd
	strneh r0, [r3]
	bx lr
	arm_func_end SeaMapManager__Func_2043B28

	arm_func_start SeaMapManager__GetPosition2
SeaMapManager__GetPosition2: // 0x02043B44
	cmp r2, #0
	movne r0, r0, lsl #0xd
	strne r0, [r2]
	cmp r3, #0
	movne r0, r1, lsl #0xd
	strne r0, [r3]
	bx lr
	arm_func_end SeaMapManager__GetPosition2

	arm_func_start SeaMapManager__Func_2043B60
SeaMapManager__Func_2043B60: // 0x02043B60
	cmp r2, #0
	movne r0, r0, asr #0xc
	strneh r0, [r2]
	cmp r3, #0
	movne r0, r1, asr #0xc
	strneh r0, [r3]
	bx lr
	arm_func_end SeaMapManager__Func_2043B60

	arm_func_start SeaMapManager__Func_2043B7C
SeaMapManager__Func_2043B7C: // 0x02043B7C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r2
	mov r4, r3
	add r2, sp, #4
	add r3, sp, #0
	bl SeaMapManager__GetPosition
	ldr r0, [sp, #4]
	ldr r1, [sp]
	mov r2, r5
	mov r3, r4
	bl SeaMapManager__Func_2043B60
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManager__Func_2043B7C

	arm_func_start SeaMapManager__Func_2043BB4
SeaMapManager__Func_2043BB4: // 0x02043BB4
	cmp r2, #0
	movne r0, r0, lsl #1
	strneh r0, [r2]
	cmp r3, #0
	movne r0, r1, lsl #1
	strneh r0, [r3]
	bx lr
	arm_func_end SeaMapManager__Func_2043BB4

	arm_func_start SeaMapManager__Func_2043BD0
SeaMapManager__Func_2043BD0: // 0x02043BD0
	cmp r2, #0
	movne r0, r0, asr #1
	strneh r0, [r2]
	cmp r3, #0
	movne r0, r1, asr #1
	strneh r0, [r3]
	bx lr
	arm_func_end SeaMapManager__Func_2043BD0

	arm_func_start SeaMapManager__Func_2043BEC
SeaMapManager__Func_2043BEC: // 0x02043BEC
	cmp r2, #0
	movne r0, r0, asr #3
	strneh r0, [r2]
	cmp r3, #0
	movne r0, r1, asr #3
	strneh r0, [r3]
	bx lr
	arm_func_end SeaMapManager__Func_2043BEC

	arm_func_start SeaMapManager__Func_2043C08
SeaMapManager__Func_2043C08: // 0x02043C08
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl SeaMapManager__GetZoomInScale
	mov r0, r0, lsl #8
	rsb r8, r0, #0x600000
	bl SeaMapManager__GetZoomInScale
	mov r1, #0xc0
	mul r1, r0, r1
	cmp r7, #0
	rsb r0, r1, #0x240000
	movlt r7, #0
	blt _02043C4C
	cmp r8, r7
	movlt r7, r8
_02043C4C:
	cmp r6, #0
	movlt r6, #0
	blt _02043C60
	cmp r0, r6
	movlt r6, r0
_02043C60:
	str r7, [r5]
	str r6, [r4]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end SeaMapManager__Func_2043C08

	arm_func_start SeaMapManager__ClearSaveFlags
SeaMapManager__ClearSaveFlags: // 0x02043C6C
	ldr ip, _02043C80 // =MIi_CpuClear32
	mov r1, r0
	mov r0, #0
	mov r2, #8
	bx ip
	.align 2, 0
_02043C80: .word MIi_CpuClear32
	arm_func_end SeaMapManager__ClearSaveFlags

	arm_func_start SeaMapManager__GetSaveFlag_
SeaMapManager__GetSaveFlag_: // 0x02043C84
	ldrb r0, [r0, r1, asr #3]
	and r1, r1, #7
	mov r2, #1
	and r0, r0, r2, lsl r1
	bx lr
	arm_func_end SeaMapManager__GetSaveFlag_

	arm_func_start SeaMapManager__GetSaveFlag
SeaMapManager__GetSaveFlag: // 0x02043C98
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetSaveBlockFlags
	mov r1, r4
	bl SeaMapManager__GetSaveFlag_
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__GetSaveFlag

	arm_func_start SeaMapManager__SetSaveFlag_
SeaMapManager__SetSaveFlag_: // 0x02043CB0
	cmp r2, #0
	mov r3, #1
	beq _02043CD0
	ldrb ip, [r0, r1, asr #3]
	and r2, r1, #7
	orr r2, ip, r3, lsl r2
	strb r2, [r0, r1, asr #3]
	bx lr
_02043CD0:
	and r2, r1, #7
	ldrb ip, [r0, r1, asr #3]
	mvn r2, r3, lsl r2
	and r2, ip, r2
	strb r2, [r0, r1, asr #3]
	bx lr
	arm_func_end SeaMapManager__SetSaveFlag_

	arm_func_start SeaMapManager__SetSaveFlag
SeaMapManager__SetSaveFlag: // 0x02043CE8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl SeaMapManager__GetSaveBlockFlags
	mov r1, r5
	mov r2, r4
	bl SeaMapManager__SetSaveFlag_
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManager__SetSaveFlag

	arm_func_start SeaMapManager__LoadMapBackground
SeaMapManager__LoadMapBackground: // 0x02043D08
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x16c]
	bl GetBackgroundMappings
	mov r8, #0
	mov r6, r0
	add r7, r6, #4
	mov r4, r8
	mov r5, r8
_02043D30:
	mov r9, r5
_02043D34:
	mov r0, r9
	mov r1, r8
	bl SeaMapManager__GetMapPixel
	cmp r0, #0
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	streqh r4, [r7]
	mov r9, r0, lsr #0x10
	cmp r9, #0xc0
	add r7, r7, #2
	blo _02043D34
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #0x48
	blo _02043D30
	add r0, r6, #4
	mov r1, #0x6c00
	bl DC_StoreRange
	ldr r0, _02043FA8 // =SeaMapManager__sVars
	ldr r0, [r0, #0xc]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x170]
	bl GetBackgroundMappings
	str r0, [sp]
	add r5, r0, #4
	mov r6, #0
_02043DAC:
	bic r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, #0x18
	mul r4, r1, r0
	mov r7, #0
	mov r8, r7
	mov r9, #1
_02043DCC:
	bl SeaMapManager__GetSaveMap
	bic r1, r7, #1
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	add r1, r2, #1
	add r3, r0, r4
	mov ip, r2, asr #5
	mov r0, r1, asr #5
	add r10, r3, ip, lsl #2
	add r11, r3, r0, lsl #2
	ldr r10, [r10, #0x18]
	and r2, r2, #0x1f
	ldr ip, [r3, ip, lsl #2]
	and r10, r10, r9, lsl r2
	ldr r0, [r3, r0, lsl #2]
	and r1, r1, #0x1f
	ldr r11, [r11, #0x18]
	and r2, ip, r9, lsl r2
	and r0, r0, r9, lsl r1
	orr r0, r2, r0
	and r11, r11, r9, lsl r1
	orr r0, r10, r0
	orrs r0, r11, r0
	add r0, r7, #2
	mov r0, r0, lsl #0x10
	streqh r8, [r5]
	mov r7, r0, lsr #0x10
	cmp r7, #0xc0
	add r5, r5, #2
	blo _02043DCC
	add r0, r6, #2
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0x48
	blo _02043DAC
	ldr r0, [sp]
	mov r1, #0x1b00
	add r0, r0, #4
	bl DC_StoreRange
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x174]
	bl GetBackgroundMappings
	str r0, [sp, #4]
	add r5, r0, #4
	mov r11, #0
_02043E80:
	mov r6, #0
	mov r4, #1
_02043E88:
	bl SeaMapManager__GetSaveMap
	mov r8, r0
	mov r0, r6
	mov r1, #3
	bl FX_DivS32
	add r0, r0, r0, lsl #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r0, r11
	mov r1, #3
	bl FX_DivS32
	add r0, r0, r0, lsl #1
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, #0x18
	mla r10, r1, r0, r8
	add r1, r7, #2
	mov r2, r1, asr #5
	add r3, r10, r2, lsl #2
	add r0, r7, #1
	mov lr, r0, asr #5
	mov ip, r7, asr #5
	and r9, r7, #0x1f
	ldr r7, [r3, #0x30]
	and r1, r1, #0x1f
	ldr r3, [r3, #0x18]
	ldr r2, [r10, r2, lsl #2]
	and r8, r7, r4, lsl r1
	and r3, r3, r4, lsl r1
	and r1, r2, r4, lsl r1
	add r2, r10, lr, lsl #2
	ldr r7, [r2, #0x30]
	and r0, r0, #0x1f
	ldr r2, [r2, #0x18]
	ldr lr, [r10, lr, lsl #2]
	and r7, r7, r4, lsl r0
	and r2, r2, r4, lsl r0
	and r0, lr, r4, lsl r0
	add lr, r10, ip, lsl #2
	ldr r10, [r10, ip, lsl #2]
	ldr ip, [lr, #0x30]
	ldr lr, [lr, #0x18]
	and ip, ip, r4, lsl r9
	and lr, lr, r4, lsl r9
	and r9, r10, r4, lsl r9
	orr r0, r9, r0
	orr r0, r1, r0
	orr r0, lr, r0
	orr r0, r2, r0
	orr r0, r3, r0
	orr r0, ip, r0
	orr r0, r7, r0
	orrs r0, r8, r0
	moveq r0, #0
	streqh r0, [r5]
	add r0, r6, #3
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0xc0
	add r5, r5, #2
	blo _02043E88
	add r0, r11, #3
	mov r0, r0, lsl #0x10
	mov r11, r0, lsr #0x10
	cmp r11, #0x48
	blo _02043E80
	ldr r0, [sp, #4]
	mov r1, #0xc00
	add r0, r0, #4
	bl DC_StoreRange
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02043FA8: .word SeaMapManager__sVars
	arm_func_end SeaMapManager__LoadMapBackground

	arm_func_start SeaMapManager__GetMapPixel
SeaMapManager__GetMapPixel: // 0x02043FAC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl SeaMapManager__GetSaveMap
	mov r1, #0x18
	mla r0, r4, r1, r0
	mov r1, r5, asr #5
	ldr r0, [r0, r1, lsl #2]
	and r1, r5, #0x1f
	mov r2, #1
	and r0, r0, r2, lsl r1
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManager__GetMapPixel

	arm_func_start SeaMapManager__Func_2043FDC
SeaMapManager__Func_2043FDC: // 0x02043FDC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r6, r0
	mov r5, r1
	cmp r6, #0xc0
	cmplo r5, #0x48
	addhs sp, sp, #8
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SeaMapManager__GetSaveMap
	mov r1, #0x18
	mla r4, r5, r1, r0
	mov r3, r6, asr #5
	ldr r1, [r4, r3, lsl #2]
	and r0, r6, #0x1f
	mov r2, #1
	tst r1, r2, lsl r0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mvn r0, r2, lsl r0
	and r0, r1, r0
	str r0, [r4, r3, lsl #2]
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x16c]
	bl GetBackgroundMappings
	mov r1, #0xc0
	mla r1, r5, r1, r6
	add r4, r0, #4
	mov r3, r1, lsl #1
	mov r2, #0
	add r0, r4, r1, lsl #1
	mov r1, #2
	strh r2, [r4, r3]
	bl DC_StoreRange
	ldr r0, _02044264 // =SeaMapManager__sVars
	ldr r0, [r0, #0xc]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SeaMapManager__GetSaveMap
	bic r1, r5, #1
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	mov r4, #0x18
	add r7, r2, #1
	bic r1, r6, #1
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	add r10, r3, #1
	mla r1, r2, r4, r0
	mov r2, r10, asr #5
	mla r9, r7, r4, r0
	mov r8, r3, asr #5
	ldr r7, [r1, r8, lsl #2]
	ldr r4, [r1, r2, lsl #2]
	and r0, r10, #0x1f
	mov r1, #1
	and r10, r3, #0x1f
	ldr r8, [r9, r8, lsl #2]
	ldr r9, [r9, r2, lsl #2]
	and r3, r7, r1, lsl r10
	and r2, r4, r1, lsl r0
	and r4, r8, r1, lsl r10
	orr r2, r3, r2
	and r1, r9, r1, lsl r0
	orr r0, r4, r2
	orrs r0, r1, r0
	bne _02044120
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x170]
	bl GetBackgroundMappings
	mov r2, r5, asr #1
	mov r1, #0x60
	mul r1, r2, r1
	add r1, r1, r6, asr #1
	add r4, r0, #4
	mov r3, r1, lsl #1
	mov r2, #0
	add r0, r4, r1, lsl #1
	mov r1, #2
	strh r2, [r4, r3]
	bl DC_StoreRange
_02044120:
	bl SeaMapManager__GetSaveMap
	mov r7, r0
	mov r0, r6
	mov r1, #3
	bl FX_DivS32
	add r0, r0, r0, lsl #1
	mov r2, r0, lsl #0x10
	mov r0, r5
	mov r1, #3
	mov r4, r2, lsr #0x10
	bl FX_DivS32
	add r0, r0, r0, lsl #1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r1, #0x18
	add lr, r4, #2
	add r2, r3, #1
	add r8, r3, #2
	mla r0, r3, r1, r7
	mla r3, r2, r1, r7
	mla r2, r8, r1, r7
	add r9, r4, #1
	mov r1, r9, asr #5
	ldr r11, [r2, r1, lsl #2]
	and r9, r9, #0x1f
	mov r10, #1
	and r11, r11, r10, lsl r9
	mov ip, lr, asr #5
	str r11, [sp, #4]
	mov r8, r4, asr #5
	and r7, r4, #0x1f
	and r4, lr, #0x1f
	ldr lr, [r2, ip, lsl #2]
	ldr r2, [r2, r8, lsl #2]
	and lr, lr, r10, lsl r4
	ldr r11, [r3, ip, lsl #2]
	str lr, [sp]
	and lr, r11, r10, lsl r4
	ldr r11, [r0, ip, lsl #2]
	ldr ip, [r3, r1, lsl #2]
	ldr r3, [r3, r8, lsl #2]
	ldr r1, [r0, r1, lsl #2]
	ldr r8, [r0, r8, lsl #2]
	and r0, r3, r10, lsl r7
	and r4, r11, r10, lsl r4
	and r3, r8, r10, lsl r7
	and r1, r1, r10, lsl r9
	orr r1, r3, r1
	orr r1, r4, r1
	and r11, ip, r10, lsl r9
	orr r0, r0, r1
	orr r0, r11, r0
	and r2, r2, r10, lsl r7
	orr r0, lr, r0
	orr r1, r2, r0
	ldr r0, [sp, #4]
	orr r1, r0, r1
	ldr r0, [sp]
	orrs r0, r0, r1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x174]
	bl GetBackgroundMappings
	add r7, r0, #4
	mov r0, r6
	mov r1, #3
	bl FX_DivS32
	mov r4, r0
	mov r0, r5
	mov r1, #3
	bl FX_DivS32
	add r0, r4, r0, lsl #6
	mov r3, r0, lsl #1
	mov r2, #0
	add r0, r7, r0, lsl #1
	mov r1, #2
	strh r2, [r7, r3]
	bl DC_StoreRange
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02044264: .word SeaMapManager__sVars
	arm_func_end SeaMapManager__Func_2043FDC

	arm_func_start SeaMapManager__Func_2044268
SeaMapManager__Func_2044268: // 0x02044268
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r1
	mov r4, r3
	mov r6, r0
	mov r5, r2
	cmp r8, r4
	ldmhsia sp!, {r4, r5, r6, r7, r8, pc}
_02044284:
	mov r7, r6
	cmp r6, r5
	bhs _020442B0
_02044290:
	mov r0, r7
	mov r1, r8
	bl SeaMapManager__Func_2043FDC
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	cmp r5, r0, lsr #16
	mov r7, r0, lsr #0x10
	bhi _02044290
_020442B0:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	cmp r4, r0, lsr #16
	mov r8, r0, lsr #0x10
	bhi _02044284
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end SeaMapManager__Func_2044268

	arm_func_start SeaMapManager__Func_20442C8
SeaMapManager__Func_20442C8: // 0x020442C8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	str r0, [sp]
	mov r10, r3
	str r1, [sp, #4]
	mov r1, r10
	mov r0, r2, lsl #0xc
	bl FX_DivS32
	rsb r1, r10, #0
	mul r1, r0, r1
	mul r2, r0, r10
	str r0, [sp, #0x18]
	ldr r0, [sp]
	mov r11, #0
	add r0, r0, r1, asr #12
	mov r1, r0, lsl #0x10
	ldr r0, [sp]
	mov r4, r1, asr #0x10
	add r0, r0, r2, asr #12
	mov r2, r10, lsl #1
	mov r6, r0, lsl #0x10
	cmp r4, r6, asr #16
	rsb r5, r2, #2
	bgt _0204434C
_02044328:
	mov r0, r4, lsl #0x10
	ldr r1, [sp, #4]
	mov r0, r0, lsr #0x10
	bl SeaMapManager__Func_2043FDC
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	cmp r4, r6, asr #16
	ble _02044328
_0204434C:
	ldr r0, [sp, #4]
	add r0, r10, r0
	mov r1, r0, lsl #0x10
	str r0, [sp, #8]
	ldr r0, [sp]
	mov r1, r1, lsr #0x10
	bl SeaMapManager__Func_2043FDC
	ldr r0, [sp, #4]
	sub r0, r0, r10
	mov r1, r0, lsl #0x10
	ldr r0, [sp]
	mov r1, r1, lsr #0x10
	bl SeaMapManager__Func_2043FDC
	mov r0, r10, lsl #1
	str r0, [sp, #0x14]
	mov r0, #1
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0xc]
_02044398:
	rsb r0, r10, #0
	cmp r5, r0
	ble _020443C8
	ldr r0, [sp, #0x14]
	sub r10, r10, #1
	sub r0, r0, #2
	rsb r1, r0, #1
	str r0, [sp, #0x14]
	ldr r0, [sp, #8]
	add r5, r5, r1
	sub r0, r0, #1
	str r0, [sp, #8]
_020443C8:
	cmp r5, r11
	bgt _020443F8
	ldr r0, [sp, #0x10]
	ldr r1, [sp, #0xc]
	add r0, r0, #2
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x18]
	add r11, r11, #1
	add r0, r1, r0
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x10]
	add r5, r5, r0
_020443F8:
	cmp r10, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x18]
	rsb r1, r11, #0
	mul r1, r0, r1
	ldr r0, [sp]
	add r0, r0, r1, asr #12
	mov r2, r0, lsl #0x10
	ldr r1, [sp]
	ldr r0, [sp, #0xc]
	mov r9, r2, asr #0x10
	add r3, r1, r0, asr #12
	ldr r0, [sp, #4]
	mov r4, r3, lsl #0x10
	sub r1, r0, r10
	ldr r0, [sp, #8]
	cmp r9, r4, asr #16
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	mov r0, r1, lsl #0x10
	mov r1, r0, asr #0x10
	bgt _02044398
	mov r0, r2, lsl #0x10
	mov r6, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	mov r7, r0, lsr #0x10
_02044464:
	mov r0, r9, lsl #0x10
	mov r8, r0, lsr #0x10
	mov r0, r8
	mov r1, r6
	bl SeaMapManager__Func_2043FDC
	mov r0, r8
	mov r1, r7
	bl SeaMapManager__Func_2043FDC
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, asr #0x10
	cmp r9, r4, asr #16
	ble _02044464
	b _02044398
_204449C: // 0x0204449C
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end SeaMapManager__Func_20442C8

	arm_func_start SeaMapManager__ClearGlobalNodeList
SeaMapManager__ClearGlobalNodeList: // 0x020444A4
	ldr ip, _020444B0 // =SeaMapManagerNodeList__Release
	ldr r0, _020444B4 // =gameState+0x00000084
	bx ip
	.align 2, 0
_020444B0: .word SeaMapManagerNodeList__Release
_020444B4: .word gameState+0x00000084
	arm_func_end SeaMapManager__ClearGlobalNodeList

	arm_func_start SeaMapManager__UpdateGlobalNodeList
SeaMapManager__UpdateGlobalNodeList: // 0x020444B8
	stmdb sp!, {r3, r4, r5, lr}
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	ldr r5, _020444E4 // =gameState+0x00000084
	add r4, r0, #0x2080
	mov r0, r5
	bl SeaMapManagerNodeList__Release
	mov r1, r5
	add r0, r4, #0x8000
	bl SeaMapManagerNodeList__CopyNodes
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_020444E4: .word gameState+0x00000084
	arm_func_end SeaMapManager__UpdateGlobalNodeList

	arm_func_start SeaMapManager__LoadNodeList
SeaMapManager__LoadNodeList: // 0x020444E8
	stmdb sp!, {r4, lr}
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	add r4, r0, #0x2080
	add r0, r4, #0x8000
	bl SeaMapManagerNodeList__Release
	ldr r0, _02044510 // =gameState+0x00000084
	add r1, r4, #0x8000
	bl SeaMapManagerNodeList__CopyNodes
	ldmia sp!, {r4, pc}
	.align 2, 0
_02044510: .word gameState+0x00000084
	arm_func_end SeaMapManager__LoadNodeList

	arm_func_start SeaMapManager__SetUnknown1
SeaMapManager__SetUnknown1: // 0x02044514
	ldr r1, _02044520 // =SeaMapManager__sVars
	str r0, [r1, #8]
	bx lr
	.align 2, 0
_02044520: .word SeaMapManager__sVars
	arm_func_end SeaMapManager__SetUnknown1

	arm_func_start SeaMapManager__GetUnknown1
SeaMapManager__GetUnknown1: // 0x02044524
	ldr r0, _02044530 // =SeaMapManager__sVars
	ldr r0, [r0, #8]
	bx lr
	.align 2, 0
_02044530: .word SeaMapManager__sVars
	arm_func_end SeaMapManager__GetUnknown1

	arm_func_start SeaMapManager__ClearSeaMap
SeaMapManager__ClearSeaMap: // 0x02044534
	ldr ip, _02044548 // =MIi_CpuClear32
	mov r1, r0
	mvn r0, #0
	mov r2, #0x6c0
	bx ip
	.align 2, 0
_02044548: .word MIi_CpuClear32
	arm_func_end SeaMapManager__ClearSeaMap

	arm_func_start SeaMapManager__GetSaveBlockFlags
SeaMapManager__GetSaveBlockFlags: // 0x0204454C
	ldr r0, _02044554 // =saveGame+0x00000890
	bx lr
	.align 2, 0
_02044554: .word saveGame+0x00000890
	arm_func_end SeaMapManager__GetSaveBlockFlags

	arm_func_start SeaMapManager__GetSaveMap
SeaMapManager__GetSaveMap: // 0x02044558
	ldr r0, _02044560 // =saveGame+0x000001D0
	bx lr
	.align 2, 0
_02044560: .word saveGame+0x000001D0
	arm_func_end SeaMapManager__GetSaveMap

	arm_func_start SeaMapManager__InitArchives
SeaMapManager__InitArchives: // 0x02044564
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	mov r4, r1
	bl SeaMapManager__Release
	mov r1, #0
	ldr r0, _0204468C // =aBbChBb
	sub r2, r1, #1
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02044690 // =SeaMapManager__sVars
	mov r0, r5
	str r1, [r2, #4]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	cmp r4, #0
	beq _02044600
	cmp r7, #4
	addls pc, pc, r7, lsl #2
	b _02044644
_020445C4: // jump table
	b _020445D8 // case 0
	b _020445E0 // case 1
	b _020445E8 // case 2
	b _020445F0 // case 3
	b _020445F8 // case 4
_020445D8:
	mov r6, #7
	b _02044644
_020445E0:
	mov r6, #8
	b _02044644
_020445E8:
	mov r6, #9
	b _02044644
_020445F0:
	mov r6, #0xa
	b _02044644
_020445F8:
	mov r6, #1
	b _02044644
_02044600:
	cmp r7, #4
	addls pc, pc, r7, lsl #2
	b _02044644
_0204460C: // jump table
	b _02044620 // case 0
	b _02044628 // case 1
	b _02044630 // case 2
	b _02044638 // case 3
	b _02044640 // case 4
_02044620:
	mov r6, #2
	b _02044644
_02044628:
	mov r6, #3
	b _02044644
_02044630:
	mov r6, #4
	b _02044644
_02044638:
	mov r6, #5
	b _02044644
_02044640:
	mov r6, #1
_02044644:
	ldr r0, _0204468C // =aBbChBb
	mov r1, r6
	mvn r2, #0
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02044690 // =SeaMapManager__sVars
	mov r0, r5
	str r1, [r2, #0x10]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	ldr r0, _02044690 // =SeaMapManager__sVars
	str r4, [r0, #0xc]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0204468C: .word aBbChBb
_02044690: .word SeaMapManager__sVars
	arm_func_end SeaMapManager__InitArchives

	arm_func_start SeaMapManager__Release
SeaMapManager__Release: // 0x02044694
	stmdb sp!, {r3, lr}
	ldr r1, _020446D8 // =SeaMapManager__sVars
	ldr r0, [r1, #4]
	cmp r0, #0
	ldreq r1, [r1, #0x10]
	cmpeq r1, #0
	ldmeqia sp!, {r3, pc}
	bl _FreeHEAP_USER
	ldr r0, _020446D8 // =SeaMapManager__sVars
	mov r1, #0
	str r1, [r0, #4]
	ldr r0, [r0, #0x10]
	bl _FreeHEAP_USER
	ldr r0, _020446D8 // =SeaMapManager__sVars
	mov r1, #0
	str r1, [r0, #0x10]
	ldmia sp!, {r3, pc}
	.align 2, 0
_020446D8: .word SeaMapManager__sVars
	arm_func_end SeaMapManager__Release

	arm_func_start SeaMapManager__LoadAssets
SeaMapManager__LoadAssets: // 0x020446DC
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	ldr r1, _02044808 // =SeaMapManager__sVars
	mov r4, r0
	ldr r2, [r1, #4]
	ldr r1, _0204480C // =aCh
	add r0, sp, #0
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #0
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4]
	add r0, sp, #0
	mov r1, #1
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #4]
	add r0, sp, #0
	mov r1, #2
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #8]
	add r0, sp, #0
	mov r1, #3
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0xc]
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	ldr r2, _02044808 // =SeaMapManager__sVars
	ldr r1, _0204480C // =aCh
	ldr r2, [r2, #0x10]
	add r0, sp, #0
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #0
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0x10]
	add r0, sp, #0
	mov r1, #1
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0x1c]
	add r0, sp, #0
	mov r1, #2
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0x28]
	add r0, sp, #0
	mov r1, #3
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0x14]
	add r0, sp, #0
	mov r1, #4
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0x20]
	add r0, sp, #0
	mov r1, #5
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0x2c]
	add r0, sp, #0
	mov r1, #6
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0x18]
	add r0, sp, #0
	mov r1, #7
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0x24]
	add r0, sp, #0
	mov r1, #8
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0x30]
	add r0, sp, #0
	mov r1, #9
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0x34]
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_02044808: .word SeaMapManager__sVars
_0204480C: .word aCh
	arm_func_end SeaMapManager__LoadAssets

	arm_func_start SeaMapManager__InitBackgrounds
SeaMapManager__InitBackgrounds: // 0x02044810
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x30
	mov r5, r0
	ldr r3, [r5, #0x158]
	ldr r0, [r5, #0]
	cmp r3, #0
	moveq ip, #1
	movne ip, #0xd
	cmp r0, #0
	beq _0204484C
	cmp r0, #1
	beq _02044854
	cmp r0, #2
	ldreq r4, [r5, #0x174]
	b _02044858
_0204484C:
	ldr r4, [r5, #0x16c]
	b _02044858
_02044854:
	ldr r4, [r5, #0x170]
_02044858:
	ldr r1, _02044A14 // =VRAMSystem__VRAM_PALETTE_BG
	mov r2, #0
	ldr r0, _02044A18 // =VRAMSystem__VRAM_BG
	str r2, [sp]
	ldr r0, [r0, r3, lsl #2]
	ldr r1, [r1, r3, lsl #2]
	str r2, [sp, #4]
	str r1, [sp, #8]
	str r2, [sp, #0xc]
	add r0, r0, #0x14000
	str r0, [sp, #0x10]
	str ip, [sp, #0x14]
	str r2, [sp, #0x18]
	str r2, [sp, #0x1c]
	str r2, [sp, #0x20]
	str r2, [sp, #0x24]
	mov r0, #0x20
	str r0, [sp, #0x28]
	mov r0, #0x18
	str r0, [sp, #0x2c]
	ldr r3, [r5, #0x158]
	ldr r2, _02044A1C // =0x000003C3
	mov r1, r4
	add r0, r5, #0x14
	bl InitBackgroundEx
	ldr ip, [r5, #0x158]
	ldr r0, [r5, #0]
	cmp ip, #0
	moveq lr, #1
	movne lr, #0xd
	cmp r0, #0
	beq _020448EC
	cmp r0, #1
	beq _020448F4
	cmp r0, #2
	ldreq r4, [r5, #0x180]
	b _020448F8
_020448EC:
	ldr r4, [r5, #0x178]
	b _020448F8
_020448F4:
	ldr r4, [r5, #0x17c]
_020448F8:
	ldr r1, _02044A14 // =VRAMSystem__VRAM_PALETTE_BG
	mov r2, #1
	ldr r0, _02044A18 // =VRAMSystem__VRAM_BG
	str r2, [sp]
	mov r3, #0
	ldr r0, [r0, ip, lsl #2]
	ldr r1, [r1, ip, lsl #2]
	str r3, [sp, #4]
	str r1, [sp, #8]
	str r3, [sp, #0xc]
	add r0, r0, #0x4000
	str r0, [sp, #0x10]
	str lr, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #2
	str r0, [sp, #0x1c]
	str r3, [sp, #0x20]
	str r3, [sp, #0x24]
	mov r0, #0x20
	str r0, [sp, #0x28]
	mov r0, #0x18
	str r0, [sp, #0x2c]
	ldr r3, [r5, #0x158]
	mov r1, r4
	add r0, r5, #0x5c
	rsb r2, r2, #0x3c4
	bl InitBackgroundEx
	ldr r3, [r5, #0x158]
	ldr r0, [r5, #0]
	cmp r3, #0
	moveq ip, #1
	movne ip, #0xd
	cmp r0, #0
	beq _02044994
	cmp r0, #1
	beq _0204499C
	cmp r0, #2
	ldreq r4, [r5, #0x18c]
	b _020449A0
_02044994:
	ldr r4, [r5, #0x184]
	b _020449A0
_0204499C:
	ldr r4, [r5, #0x188]
_020449A0:
	ldr r1, _02044A14 // =VRAMSystem__VRAM_PALETTE_BG
	mov r2, #2
	ldr r0, _02044A18 // =VRAMSystem__VRAM_BG
	str r2, [sp]
	mov r2, #0
	ldr r0, [r0, r3, lsl #2]
	ldr r1, [r1, r3, lsl #2]
	str r2, [sp, #4]
	str r1, [sp, #8]
	str r2, [sp, #0xc]
	add r0, r0, #0xc000
	str r0, [sp, #0x10]
	str ip, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r0, #4
	str r0, [sp, #0x1c]
	str r2, [sp, #0x20]
	str r2, [sp, #0x24]
	mov r0, #0x20
	str r0, [sp, #0x28]
	mov r0, #0x18
	str r0, [sp, #0x2c]
	ldr r3, [r5, #0x158]
	ldr r2, _02044A1C // =0x000003C3
	mov r1, r4
	add r0, r5, #0xa4
	bl InitBackgroundEx
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02044A14: .word VRAMSystem__VRAM_PALETTE_BG
_02044A18: .word VRAMSystem__VRAM_BG
_02044A1C: .word 0x000003C3
	arm_func_end SeaMapManager__InitBackgrounds

	arm_func_start SeaMapManager__SetupDisplay
SeaMapManager__SetupDisplay: // 0x02044A20
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r1, _02044C14 // =VRAMSystem__GFXControl
	mov r5, r0
	ldr r4, [r1, r5, lsl #2]
	mov r0, #0
	mov r1, r4
	mov r2, #0x5c
	bl MIi_CpuClear32
	mov r1, #0x800
	mov r2, r1
	add r0, r4, #0x40
	bl MTX_Scale22_
	add r1, sp, #8
	add r2, sp, #4
	mov r0, r5
	bl SeaMapManager__GetOBJBankInfo
	cmp r5, #0
	bne _02044B44
	mov r0, #1
	mov r1, #3
	mov r2, #0
	bl GX_SetGraphicsMode
	ldr r0, _02044C18 // =0x04000008
	ldr r1, _02044C1C // =0x00004014
	ldrh r2, [r0, #0]
	add r1, r1, #0x1f0
	and r2, r2, #0x43
	orr r2, r2, #0x14
	orr r2, r2, #0x4000
	strh r2, [r0]
	ldrh r2, [r0, #0]
	bic r2, r2, #3
	orr r2, r2, #1
	strh r2, [r0]
	ldrh r2, [r0, #2]
	and r2, r2, #0x43
	orr r1, r2, r1
	strh r1, [r0, #2]
	ldrh r1, [r0, #2]
	bic r1, r1, #3
	orr r1, r1, #2
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	and r1, r1, #0x43
	orr r1, r1, #0x8c
	orr r1, r1, #0x4400
	strh r1, [r0, #4]
	ldrh r1, [r0, #4]
	bic r1, r1, #3
	orr r1, r1, #3
	strh r1, [r0, #4]
	ldrh r1, [r0, #6]
	and r1, r1, #0x43
	orr r1, r1, #0x680
	strh r1, [r0, #6]
	ldrh r1, [r0, #6]
	bic r1, r1, #3
	strh r1, [r0, #6]
	bl GX_GetBankForOBJ
	ldrh r1, [sp, #4]
	mov r2, #0x40
	mov r3, #0
	str r1, [sp]
	ldr r1, [sp, #8]
	bl VRAMSystem__SetupOBJBank
	mov r1, #0x4000000
	ldr r0, [r1, #0]
	add sp, sp, #0xc
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r1]
	ldmia sp!, {r4, r5, pc}
_02044B44:
	mov r0, #3
	bl GXS_SetGraphicsMode
	ldr r0, _02044C20 // =0x04001008
	ldr r1, _02044C1C // =0x00004014
	ldrh r2, [r0, #0]
	add r1, r1, #0x1f0
	and r2, r2, #0x43
	orr r2, r2, #0x14
	orr r2, r2, #0x4000
	strh r2, [r0]
	ldrh r2, [r0, #0]
	bic r2, r2, #3
	orr r2, r2, #1
	strh r2, [r0]
	ldrh r2, [r0, #2]
	and r2, r2, #0x43
	orr r1, r2, r1
	strh r1, [r0, #2]
	ldrh r1, [r0, #2]
	bic r1, r1, #3
	orr r1, r1, #2
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	and r1, r1, #0x43
	orr r1, r1, #0x8c
	orr r1, r1, #0x4400
	strh r1, [r0, #4]
	ldrh r1, [r0, #4]
	bic r1, r1, #3
	orr r1, r1, #3
	strh r1, [r0, #4]
	ldrh r1, [r0, #6]
	and r1, r1, #0x43
	orr r1, r1, #0x680
	strh r1, [r0, #6]
	ldrh r1, [r0, #6]
	bic r1, r1, #3
	strh r1, [r0, #6]
	bl GX_GetBankForSubOBJ
	ldrh r1, [sp, #4]
	mov r2, #0x40
	mov r3, #0
	str r1, [sp]
	ldr r1, [sp, #8]
	bl VRAMSystem__SetupSubOBJBank
	ldr r1, _02044C24 // =0x04001000
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r1]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02044C14: .word VRAMSystem__GFXControl
_02044C18: .word 0x04000008
_02044C1C: .word 0x00004014
_02044C20: .word 0x04001008
_02044C24: .word 0x04001000
	arm_func_end SeaMapManager__SetupDisplay

	arm_func_start SeaMapManager__GetOBJBankInfo
SeaMapManager__GetOBJBankInfo: // 0x02044C28
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	mov r5, r2
	cmp r0, #0
	bne _02044C74
	bl GX_GetBankForOBJ
	cmp r0, #0x20
	cmpne r0, #0x40
	bne _02044C60
	mov r0, #0x200
	strh r0, [r5]
	mov r0, #0x10
	str r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
_02044C60:
	mov r0, #0x400
	strh r0, [r5]
	mov r0, #0x10
	str r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
_02044C74:
	bl GX_GetBankForSubOBJ
	cmp r0, #8
	beq _02044C9C
	cmp r0, #0x100
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #0x200
	strh r0, [r5]
	mov r0, #0x10
	str r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
_02044C9C:
	mov r0, #0x400
	strh r0, [r5]
	mov r0, #0x10
	str r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManager__GetOBJBankInfo

	arm_func_start SeaMapManager__LoadBackgroundPixels
SeaMapManager__LoadBackgroundPixels: // 0x02044CB0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x18]
	bl GetBackgroundPixels
	ldr r1, [r4, #0x34]
	ldr r2, [r4, #0x38]
	bl LoadCompressedPixels
	ldr r0, [r4, #0x60]
	bl GetBackgroundPixels
	ldr r1, [r4, #0x7c]
	ldr r2, [r4, #0x80]
	bl LoadCompressedPixels
	ldr r0, [r4, #0xa8]
	bl GetBackgroundPixels
	ldr r1, [r4, #0xc4]
	ldr r2, [r4, #0xc8]
	bl LoadCompressedPixels
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__LoadBackgroundPixels

	arm_func_start SeaMapManager__LoadBackgroundPalette
SeaMapManager__LoadBackgroundPalette: // 0x02044CF8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x18]
	bl GetBackgroundPalette
	ldr r1, [r4, #0x2c]
	ldr r2, [r4, #0x30]
	bl LoadCompressedPalette
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__LoadBackgroundPalette

	arm_func_start SeaMapManager__Main
SeaMapManager__Main: // 0x02044D18
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x154]
	cmp r0, #0
	beq _02044D38
	add r0, r4, #0x13c
	bl TouchField__Process
_02044D38:
	ldr r1, [r4, #0x198]
	mov r0, r4
	blx r1
	ldr r1, [r4, #0xc]
	ldr r0, [r4, #4]
	cmp r1, r0
	ldreq r1, [r4, #0x10]
	ldreq r0, [r4, #8]
	cmpeq r1, r0
	ldrne r0, [r4, #0x134]
	orrne r0, r0, #0xf
	strne r0, [r4, #0x134]
	mov r0, r4
	bl SeaMapManager__Draw
	mov r0, #0
	str r0, [r4, #0x134]
	ldr r0, [r4, #4]
	str r0, [r4, #0xc]
	ldr r0, [r4, #8]
	str r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__Main

	arm_func_start SeaMapManager__Destructor
SeaMapManager__Destructor: // 0x02044D8C
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x138]
	add r0, r0, #0x2080
	add r0, r0, #0x8000
	bl SeaMapManagerNodeList__Release
	ldr r0, [r4, #0x138]
	bl _FreeHEAP_USER
	mov r1, #0
	ldr r0, _02044DC4 // =SeaMapManager__sVars
	str r1, [r4, #0x138]
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02044DC4: .word SeaMapManager__sVars
	arm_func_end SeaMapManager__Destructor

	arm_func_start SeaMapManager__State_2044DC8
SeaMapManager__State_2044DC8: // 0x02044DC8
	bx lr
	arm_func_end SeaMapManager__State_2044DC8

	arm_func_start SeaMapManager__DrawNodeLine2
SeaMapManager__DrawNodeLine2: // 0x02044DCC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x10
	mov r7, r0
	mov r5, r2
	mov r6, r1
	mov r4, r3
	bl SeaMapManager__GetWork
	cmp r7, r5
	cmpeq r6, r4
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldrh ip, [sp, #0x28]
	cmp ip, #0
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	cmp ip, #1
	bne _02044E30
	str r4, [sp]
	ldr r0, [r0, #0x138]
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl SeaMapManager__DrawLine
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02044E30:
	ldr r0, [r0, #0x138]
	mov r3, r7
	str r6, [sp]
	str r5, [sp, #4]
	add r2, r0, #0x1e40
	str r4, [sp, #8]
	add r1, r0, #0x9c00
	add r2, r2, #0x8000
	str ip, [sp, #0xc]
	bl SeaMapManager__Func_2045798
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SeaMapManager__DrawNodeLine2

	arm_func_start SeaMapManager__DrawNodeLine
SeaMapManager__DrawNodeLine: // 0x02044E60
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r2
	mov r7, r0
	mov r6, r1
	bl SeaMapManager__GetWork
	mov r4, r0
	cmp r5, #0
	bne _02044EA4
	ldr r1, [r4, #0x138]
	mov r0, #0x60
	mla r3, r6, r0, r1
	ldrb r2, [r3, r7, asr #3]
	and r0, r7, #7
	mov r1, #1
	orr r0, r2, r1, lsl r0
	strb r0, [r3, r7, asr #3]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02044EA4:
	ldr r0, [r4, #0x138]
	add r1, r0, #0x1e40
	add r0, r0, #0x9c00
	add r1, r1, #0x8000
	bl SeaMapManager__ResetPtr1Ptr2
	ldr r3, [r4, #0x138]
	mov r0, r7
	add r1, r3, #0x1e40
	add r7, r1, #0x8000
	mov r1, r6
	mov r2, r5
	add r3, r3, #0x9c00
	str r7, [sp]
	bl SeaMapManager__Func_2045A58
	add r0, r5, #1
	subs r3, r6, r0, asr #1
	add r0, r6, r0, asr #1
	add r1, r0, #1
	movmi r3, #0
	ldr r0, [r4, #0x138]
	cmp r1, #0x120
	movgt r1, #0x120
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
	add r2, r0, #0x1e40
	mov r3, r3, lsl #0x10
	add r1, r0, #0x9c00
	add r2, r2, #0x8000
	mov r3, r3, lsr #0x10
	str r4, [sp]
	bl SeaMapManager__Func_2045128
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SeaMapManager__DrawNodeLine

	arm_func_start SeaMapManager__Func_2044F24
SeaMapManager__Func_2044F24: // 0x02044F24
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r5, r0
	mov r4, r1
	bl SeaMapManager__GetWork
	ldr r1, [r0, #0x138]
	mov r3, #0
	add lr, r1, #0x6c00
	b _02045040
_02044F44:
	add r0, r4, r3
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	mov r0, #0x60
	mla r0, r6, r0, r1
	mov r2, #0
	ldr r7, _0204504C // =dword_210FB40
	b _02045034
_02044F64:
	add r6, r5, r2
	mov r6, r6, lsl #0x10
	mov r8, r6, lsr #0x10
	add ip, r0, r8, asr #3
	ldrb r10, [ip, #1]
	and r6, r8, #7
	rsb r9, r6, #8
	ldrb r8, [r0, r8, asr #3]
	mov r10, r10, lsl r9
	ldrb r9, [ip, #2]
	orr r11, r10, r8, lsr r6
	rsb r8, r6, #0x10
	ldrb r10, [ip, #3]
	orr r11, r11, r9, lsl r8
	rsb r9, r6, #0x18
	ldrb r8, [ip, #4]
	orr r9, r11, r10, lsl r9
	rsb r6, r6, #0x20
	orr r8, r9, r8, lsl r6
	and r10, r8, #0xf
	mov r6, r8, lsr #4
	and r6, r6, #0xf
	mov r9, r8, lsr #8
	ldr ip, [r7, r10, lsl #2]
	and r10, r9, #0xf
	mov r9, r8, lsr #0xc
	and r9, r9, #0xf
	ldr r6, [r7, r6, lsl #2]
	str ip, [lr]
	ldr r10, [r7, r10, lsl #2]
	str r6, [lr, #4]
	ldr r6, [r7, r9, lsl #2]
	str r10, [lr, #8]
	str r6, [lr, #0xc]
	add r6, lr, #0x10
	mov r9, r8, lsr #0x10
	and r10, r9, #0xf
	mov r9, r8, lsr #0x14
	and ip, r9, #0xf
	mov r9, r8, lsr #0x18
	ldr lr, [r7, r10, lsl #2]
	and r9, r9, #0xf
	mov r8, r8, lsr #0x1c
	and r8, r8, #0xf
	ldr r10, [r7, ip, lsl #2]
	str lr, [r6]
	ldr ip, [r7, r9, lsl #2]
	ldr r8, [r7, r8, lsl #2]
	stmib r6, {r10, ip}
	str r8, [r6, #0xc]
	add lr, r6, #0x10
	add r2, r2, #0x20
_02045034:
	cmp r2, #0x80
	blt _02044F64
	add r3, r3, #1
_02045040:
	cmp r3, #0x60
	blt _02044F44
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204504C: .word dword_210FB40
	arm_func_end SeaMapManager__Func_2044F24

	arm_func_start SeaMapManager__ClearUnknownPtr
SeaMapManager__ClearUnknownPtr: // 0x02045050
	stmdb sp!, {r3, lr}
	bl SeaMapManager__GetWork
	ldr r1, [r0, #0x138]
	mov r0, #0
	mov r2, #0x6c00
	bl MIi_CpuClear32
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapManager__ClearUnknownPtr

	arm_func_start SeaMapManager__Func_204506C
SeaMapManager__Func_204506C: // 0x0204506C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r5, [r1, #0]
	ldmia r0, {ip, lr}
	smull r5, r6, ip, r5
	adds r7, r5, #0x800
	ldr r4, [r1, #8]
	adc r6, r6, #0
	smull r5, r4, lr, r4
	adds r5, r5, #0x800
	mov r7, r7, lsr #0xc
	orr r7, r7, r6, lsl #20
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	ldr r6, [r2, #0]
	add r4, r7, r5
	add r4, r6, r4
	str r4, [r3]
	ldr lr, [r0, #4]
	ldr r4, [r1, #4]
	ldr r0, [r1, #0xc]
	smull r1, r4, ip, r4
	adds ip, r1, #0x800
	smull r1, r0, lr, r0
	adc r4, r4, #0
	adds r1, r1, #0x800
	mov ip, ip, lsr #0xc
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr ip, ip, r4, lsl #20
	orr r1, r1, r0, lsl #20
	ldr r2, [r2, #4]
	add r0, ip, r1
	add r0, r2, r0
	str r0, [r3, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SeaMapManager__Func_204506C

	arm_func_start SeaMapManager__ResetPtr1Ptr2
SeaMapManager__ResetPtr1Ptr2: // 0x020450FC
	stmdb sp!, {r4, lr}
	mov r4, r1
	mov r1, r0
	mov r0, #0x300
	mov r2, #0x240
	bl MIi_CpuClear16
	mov r1, r4
	mov r0, #0
	mov r2, #0x240
	bl MIi_CpuClear16
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__ResetPtr1Ptr2

	arm_func_start SeaMapManager__Func_2045128
SeaMapManager__Func_2045128: // 0x02045128
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r5, [sp, #0x20]
	add r1, r1, r3, lsl #1
	cmp r3, r5
	add r2, r2, r3, lsl #1
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov ip, #1
	mov r7, #0x60
_02045148:
	ldrh lr, [r1]
	ldrh r4, [r2, #0]
	cmp lr, r4
	bhi _02045184
	mla r4, r3, r7, r0
_0204515C:
	ldrb r9, [r4, lr, asr #3]
	and r8, lr, #7
	add r6, lr, #1
	orr r8, r9, ip, lsl r8
	strb r8, [r4, lr, asr #3]
	ldrh r8, [r2, #0]
	mov r6, r6, lsl #0x10
	mov lr, r6, lsr #0x10
	cmp r8, r6, lsr #16
	bhs _0204515C
_02045184:
	add r3, r3, #1
	mov r3, r3, lsl #0x10
	cmp r5, r3, lsr #16
	add r1, r1, #2
	add r2, r2, #2
	mov r3, r3, lsr #0x10
	bhi _02045148
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end SeaMapManager__Func_2045128

	arm_func_start SeaMapManager__Func_20451A4
SeaMapManager__Func_20451A4: // 0x020451A4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x10
	mov r4, #0
	mov r8, r0
	mov r7, r1
	str r4, [r8]
	sub r9, r4, #0x800
	str r9, [r8, #4]
	str r4, [r7]
	mov r1, #0x800
	mov r6, r2
	str r1, [r7, #4]
	mov r0, #0x1000
	stmia r6, {r0, r1}
	mov r5, r3
	ldr r4, [sp, #0x30]
	stmia r5, {r0, r9}
	ldr r10, [sp, #0x34]
	ldr r0, [r4, #4]
	ldmia r10, {r2, r3}
	ldr r1, [r4, #0]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r9, r0
	mov r0, r9, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	mov ip, r1, lsl #1
	add r1, r1, #1
	ldr r3, _020452EC // =FX_SinCosTable_
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	add r0, sp, #0
	bl MTX_Rot22_
	ldr r1, [r4, #0]
	ldmia r10, {r2, r3}
	ldr r0, [r4, #4]
	sub r1, r2, r1
	sub r0, r3, r0
	smull r10, r3, r1, r1
	smull r2, r1, r0, r0
	adds r10, r10, #0x800
	adc r0, r3, #0
	mov r3, r10, lsr #0xc
	adds r2, r2, #0x800
	orr r3, r3, r0, lsl #20
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r3, r1
	bl FX_Sqrt
	mov r2, r0
	add r0, sp, #0
	ldr r3, [sp, #0x38]
	mov r1, r0
	bl MTX_ScaleApply22
	mov r0, r8
	mov r3, r8
	add r1, sp, #0
	mov r2, r4
	bl SeaMapManager__Func_204506C
	mov r0, r7
	mov r3, r7
	add r1, sp, #0
	mov r2, r4
	bl SeaMapManager__Func_204506C
	mov r0, r6
	mov r3, r6
	add r1, sp, #0
	mov r2, r4
	bl SeaMapManager__Func_204506C
	mov r2, r4
	mov r0, r5
	mov r3, r5
	add r1, sp, #0
	bl SeaMapManager__Func_204506C
	mov r0, r9
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020452EC: .word FX_SinCosTable_
	arm_func_end SeaMapManager__Func_20451A4

	arm_func_start SeaMapManager__Func_20452F0
SeaMapManager__Func_20452F0: // 0x020452F0
	stmdb sp!, {r4, r5, r6, lr}
	ldr r6, [sp, #0x10]
	ldr r5, [sp, #0x14]
	cmp r6, #0x4000
	ldr r4, [sp, #0x18]
	ldr lr, [sp, #0x1c]
	ldr ip, [sp, #0x20]
	bhs _02045324
	str r0, [r5]
	str r2, [r4]
	str r1, [lr]
	str r3, [ip]
	ldmia sp!, {r4, r5, r6, pc}
_02045324:
	cmp r6, #0x4000
	blo _02045348
	cmp r6, #0x8000
	bhs _02045348
	str r1, [r5]
	str r3, [r4]
	str r2, [lr]
	str r0, [ip]
	ldmia sp!, {r4, r5, r6, pc}
_02045348:
	cmp r6, #0x8000
	blo _0204536C
	cmp r6, #0xc000
	bhs _0204536C
	str r2, [r5]
	str r0, [r4]
	str r3, [lr]
	str r1, [ip]
	ldmia sp!, {r4, r5, r6, pc}
_0204536C:
	str r3, [r5]
	str r1, [r4]
	str r0, [lr]
	str r2, [ip]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SeaMapManager__Func_20452F0

	arm_func_start SeaMapManager__Func_2045380
SeaMapManager__Func_2045380: // 0x02045380
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	str r2, [sp, #4]
	mov r8, r0
	ldr r0, [sp, #4]
	ldr r2, [r8, #4]
	ldr r9, [r0, #4]
	str r3, [sp, #8]
	ldr r10, [r0, #0]
	str r1, [sp]
	mov r4, r2, asr #0xc
	mov r1, r10, asr #0xc
	movs r5, r9, asr #0xc
	ldr r7, [sp, #0x30]
	ldr r6, [sp, #0x34]
	ldr r3, [r8, #0]
	bmi _0204548C
	subs r0, r4, r5
	bne _02045404
	cmp r5, #0
	blt _0204548C
	cmp r5, #0x120
	bge _0204548C
	cmp r1, #0
	bge _020453F4
	mov r0, r5, lsl #1
	mov r1, #0
	strh r1, [r7, r0]
	b _0204548C
_020453F4:
	cmp r1, #0x300
	movlt r0, r5, lsl #1
	strlth r1, [r7, r0]
	b _0204548C
_02045404:
	sub r0, r3, r10
	sub r1, r2, r9
	bl FX_Div
	cmp r4, #0
	movlt r4, #0
	mov r9, r4, lsl #0xc
	mov r10, r0, asr #0x1f
	mov r11, #0
	b _0204547C
_02045428:
	ldr r1, [r8, #4]
	ldr lr, [r8]
	sub r2, r9, r1
	umull ip, r3, r2, r0
	mla r3, r2, r10, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r1, ip, #0x800
	adc r2, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r2, lsl #20
	adds r1, lr, r1
	movmi r1, r4, lsl #1
	strmih r11, [r7, r1]
	bmi _02045474
	cmp r1, #0x300000
	movlt r2, r1, asr #0xc
	movlt r1, r4, lsl #1
	strlth r2, [r7, r1]
_02045474:
	add r9, r9, #0x1000
	add r4, r4, #1
_0204547C:
	cmp r4, r5
	bgt _0204548C
	cmp r4, #0x120
	blt _02045428
_0204548C:
	ldr r0, [sp, #8]
	ldr r9, [r8, #4]
	ldr r3, [r0, #0]
	ldr r1, [r0, #4]
	mov r5, r9, asr #0xc
	mov r2, r3, asr #0xc
	movs r4, r1, asr #0xc
	ldr r10, [r8, #0]
	bmi _0204557C
	subs r0, r5, r4
	bne _020454F0
	cmp r4, #0
	blt _0204557C
	cmp r4, #0x120
	bge _0204557C
	cmp r2, #0x300
	blt _020454E0
	ldr r1, _02045794 // =0x000002FF
	mov r0, r4, lsl #1
	strh r1, [r6, r0]
	b _0204557C
_020454E0:
	cmp r2, #0
	movge r0, r4, lsl #1
	strgeh r2, [r6, r0]
	b _0204557C
_020454F0:
	sub r0, r10, r3
	sub r1, r9, r1
	bl FX_Div
	cmp r5, #0
	movlt r5, #0
	mov r11, r5, lsl #0xc
	mov ip, r0, asr #0x1f
	ldr lr, _02045794 // =0x000002FF
	b _0204556C
_02045514:
	ldr r1, [r8, #4]
	ldr r10, [r8, #0]
	sub r2, r11, r1
	umull r9, r3, r2, r0
	mla r3, r2, ip, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r1, r9, #0x800
	adc r2, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r2, lsl #20
	add r1, r10, r1
	cmp r1, #0x300000
	movge r1, r5, lsl #1
	strgeh lr, [r6, r1]
	bge _02045564
	cmp r1, #0
	movge r2, r1, asr #0xc
	movge r1, r5, lsl #1
	strgeh r2, [r6, r1]
_02045564:
	add r11, r11, #0x1000
	add r5, r5, #1
_0204556C:
	cmp r5, r4
	bgt _0204557C
	cmp r5, #0x120
	blt _02045514
_0204557C:
	ldr r0, [sp, #4]
	ldr r9, [r0, #0]
	ldr r3, [r0, #4]
	ldr r0, [sp]
	mov r8, r9, asr #0xc
	ldr r1, [r0, #4]
	mov r5, r3, asr #0xc
	movs r4, r1, asr #0xc
	ldr r2, [r0, #0]
	bmi _02045674
	subs r0, r5, r4
	bne _020455E4
	cmp r5, #0
	blt _02045674
	cmp r5, #0x120
	bge _02045674
	cmp r8, #0
	bge _020455D4
	mov r0, r5, lsl #1
	mov r1, #0
	strh r1, [r7, r0]
	b _02045674
_020455D4:
	cmp r8, #0x300
	movlt r0, r5, lsl #1
	strlth r8, [r7, r0]
	b _02045674
_020455E4:
	sub r0, r9, r2
	sub r1, r3, r1
	bl FX_Div
	adds ip, r5, #1
	movmi ip, #0
	mov r1, #0
	mov r10, ip, lsl #0xc
	mov r11, r0, asr #0x1f
	mov lr, r1
	b _02045664
_0204560C:
	ldr r2, [sp, #4]
	ldr r3, [r2, #4]
	ldr r9, [r2, #0]
	sub r3, r10, r3
	umull r8, r5, r3, r0
	mla r5, r3, r11, r5
	mov r2, r3, asr #0x1f
	adds r3, r8, #0x800
	mla r5, r2, r0, r5
	adc r2, r5, lr
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	adds r2, r9, r3
	movmi r2, ip, lsl #1
	strmih r1, [r7, r2]
	bmi _0204565C
	cmp r2, #0x300000
	movlt r3, r2, asr #0xc
	movlt r2, ip, lsl #1
	strlth r3, [r7, r2]
_0204565C:
	add r10, r10, #0x1000
	add ip, ip, #1
_02045664:
	cmp ip, r4
	bgt _02045674
	cmp ip, #0x120
	blt _0204560C
_02045674:
	ldr r0, [sp, #8]
	ldr r8, [r0, #0]
	ldr r3, [r0, #4]
	ldr r0, [sp]
	mov r7, r8, asr #0xc
	ldr r1, [r0, #4]
	mov r5, r3, asr #0xc
	movs r4, r1, asr #0xc
	addmi sp, sp, #0xc
	ldr r2, [r0, #0]
	ldmmiia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	subs r0, r5, r4
	bne _020456F0
	cmp r5, #0
	addlt sp, sp, #0xc
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r5, #0x120
	addge sp, sp, #0xc
	ldmgeia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r7, #0x300
	blt _020456DC
	ldr r1, _02045794 // =0x000002FF
	mov r0, r5, lsl #1
	add sp, sp, #0xc
	strh r1, [r6, r0]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020456DC:
	cmp r7, #0
	movge r0, r5, lsl #1
	add sp, sp, #0xc
	strgeh r7, [r6, r0]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020456F0:
	sub r0, r8, r2
	sub r1, r3, r1
	bl FX_Div
	adds ip, r5, #1
	movmi ip, #0
	mov r10, ip, lsl #0xc
	mov r11, r0, asr #0x1f
	ldr r2, _02045794 // =0x000002FF
	mov r1, #0
	mov lr, #0x800
	b _02045778
_0204571C:
	ldr r3, [sp, #8]
	ldr r5, [r3, #4]
	ldr r9, [r3, #0]
	sub r5, r10, r5
	umull r3, r7, r5, r0
	adds r3, r3, lr
	mov r8, r3, lsr #0xc
	mla r7, r5, r11, r7
	mov r3, r5, asr #0x1f
	mla r7, r3, r0, r7
	adc r3, r7, r1
	orr r8, r8, r3, lsl #20
	add r3, r9, r8
	cmp r3, #0x300000
	movge r3, ip, lsl #1
	strgeh r2, [r6, r3]
	bge _02045770
	cmp r3, #0
	movge r5, r3, asr #0xc
	movge r3, ip, lsl #1
	strgeh r5, [r6, r3]
_02045770:
	add r10, r10, #0x1000
	add ip, ip, #1
_02045778:
	cmp ip, r4
	addgt sp, sp, #0xc
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp ip, #0x120
	blt _0204571C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02045794: .word 0x000002FF
	arm_func_end SeaMapManager__Func_2045380

	arm_func_start SeaMapManager__Func_2045798
SeaMapManager__Func_2045798: // 0x02045798
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x54
	ldrh r5, [sp, #0x74]
	ldrh r4, [sp, #0x78]
	ldrh r6, [sp, #0x70]
	mov ip, r3, lsl #0xc
	mov r8, r5, lsl #0xc
	mov r3, r6, lsl #0xc
	mov r7, r4, lsl #0xc
	mov r6, r0
	str ip, [sp, #0x4c]
	str r3, [sp, #0x50]
	mov r5, r1
	mov r4, r2
	ldrh lr, [sp, #0x7c]
	add r0, sp, #0x4c
	str r8, [sp, #0x44]
	str r7, [sp, #0x48]
	str r0, [sp]
	add ip, sp, #0x44
	str ip, [sp, #4]
	mov ip, lr, lsl #0xc
	add r0, sp, #0x3c
	add r1, sp, #0x34
	add r2, sp, #0x2c
	add r3, sp, #0x24
	str ip, [sp, #8]
	bl SeaMapManager__Func_20451A4
	str r0, [sp]
	add r0, sp, #0x20
	str r0, [sp, #4]
	add r1, sp, #0x1c
	str r1, [sp, #8]
	add r0, sp, #0x18
	str r0, [sp, #0xc]
	add r2, sp, #0x14
	str r2, [sp, #0x10]
	add r0, sp, #0x3c
	add r1, sp, #0x34
	add r2, sp, #0x2c
	add r3, sp, #0x24
	bl SeaMapManager__Func_20452F0
	mov r0, r5
	mov r1, r4
	bl SeaMapManager__ResetPtr1Ptr2
	str r5, [sp]
	str r4, [sp, #4]
	ldr r0, [sp, #0x20]
	ldr r1, [sp, #0x1c]
	ldr r2, [sp, #0x18]
	ldr r3, [sp, #0x14]
	bl SeaMapManager__Func_2045380
	ldr r0, [sp, #0x20]
	ldrh r1, [sp, #0x7c]
	ldr r0, [r0, #4]
	add r1, r1, #1
	mov r0, r0, asr #0xc
	subs r2, r0, r1, asr #1
	ldr r0, [sp, #0x1c]
	movmi r2, #0
	mov r3, r2, lsl #0x10
	ldr r0, [r0, #4]
	mov r2, r4
	mov r0, r0, asr #0xc
	add r0, r0, r1, asr #1
	cmp r0, #0x120
	movgt r0, #0x120
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	mov r0, r6
	mov r1, r5
	mov r3, r3, lsr #0x10
	str ip, [sp]
	bl SeaMapManager__Func_2045128
	add sp, sp, #0x54
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	arm_func_end SeaMapManager__Func_2045798

	arm_func_start SeaMapManager__DrawLine
SeaMapManager__DrawLine: // 0x020458C8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr lr, [sp, #0x28]
	sub r4, r3, r1
	sub r5, lr, r2
	mov r4, r4, lsl #0x10
	mov r5, r5, lsl #0x10
	movs r4, r4, asr #0x10
	rsbmi r4, r4, #0
	mov r5, r5, asr #0x10
	mov r4, r4, lsl #0x10
	cmp r5, #0
	rsblt r5, r5, #0
	mov ip, r4, lsr #0x10
	mov r4, r5, lsl #0x10
	cmp ip, r4, lsr #16
	bls _020459B0
	cmp r2, lr
	movlo r11, #1
	mvnhs r11, #0
	cmp r1, r3
	movlo r5, r1
	movhs r5, r3
	add r5, r5, #1
	movlo r8, #1
	mov r5, r5, lsl #0x10
	movhs r3, r1
	mvnhs r8, #0
	mov r10, r5, lsr #0x10
	mov r9, #0
	cmp r3, r5, lsr #16
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r6, #1
_02045948:
	add r1, r1, r8
	add r5, r9, r4, lsr #16
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r5, r5, lsl #0x10
	cmp ip, r5, lsr #16
	mov r9, r5, lsr #0x10
	bhi _02045980
	sub r7, r9, ip
	add r5, r2, r11
	mov r2, r7, lsl #0x10
	mov r9, r2, lsr #0x10
	mov r2, r5, lsl #0x10
	mov r2, r2, lsr #0x10
_02045980:
	mov r5, #0x60
	mla lr, r2, r5, r0
	ldrb r7, [lr, r1, asr #3]
	and r5, r1, #7
	add r10, r10, #1
	orr r5, r7, r6, lsl r5
	strb r5, [lr, r1, asr #3]
	mov r5, r10, lsl #0x10
	cmp r3, r5, lsr #16
	mov r10, r5, lsr #0x10
	bhs _02045948
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020459B0:
	cmp r1, r3
	movlo r9, #1
	mvnhs r9, #0
	cmp r2, lr
	movlo r3, r2
	movhs r3, lr
	add r3, r3, #1
	movlo r8, #1
	mov r3, r3, lsl #0x10
	movhs lr, r2
	mvnhs r8, #0
	mov r11, r3, lsr #0x10
	mov r10, #0
	cmp lr, r3, lsr #16
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r5, #1
_020459F0:
	add r3, r10, ip
	add r2, r2, r8
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r10, r3, lsr #0x10
	cmp r10, r4, lsr #16
	blo _02045A28
	sub r6, r10, r4, lsr #16
	add r3, r1, r9
	mov r1, r6, lsl #0x10
	mov r10, r1, lsr #0x10
	mov r1, r3, lsl #0x10
	mov r1, r1, lsr #0x10
_02045A28:
	mov r3, #0x60
	mla r7, r2, r3, r0
	ldrb r6, [r7, r1, asr #3]
	and r3, r1, #7
	add r11, r11, #1
	orr r3, r6, r5, lsl r3
	strb r3, [r7, r1, asr #3]
	mov r3, r11, lsl #0x10
	cmp lr, r3, lsr #16
	mov r11, r3, lsr #0x10
	bhs _020459F0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end SeaMapManager__DrawLine

	arm_func_start SeaMapManager__Func_2045A58
SeaMapManager__Func_2045A58: // 0x02045A58
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r4, r2, lsr #1
	add ip, r4, #1
	mov r5, ip, lsl #2
	sub r4, ip, #1
	mul r6, r5, r4
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	add r6, r6, #2
	rsb r5, r2, #0
	mla lr, r5, r2, r6
	rsb r4, ip, #1
	tst r2, #1
	mov r2, r4, lsl #3
	mov r8, r0
	str r1, [sp]
	str r2, [sp, #4]
	ldr r9, [sp, #0x30]
	mov r11, #4
	bne _02045ACC
	add r2, r0, #1
	add r4, r1, #1
	mov r2, r2, lsl #0x10
	mov r4, r4, lsl #0x10
	mov r8, r2, lsr #0x10
	mov r2, r4, lsr #0x10
	str r2, [sp]
_02045ACC:
	cmp ip, #0
	addlt sp, sp, #8
	mov r2, #0
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r6, r0, ip
	add r7, r1, ip
_02045AE4:
	cmp lr, #0
	ble _02045B08
	ldr r4, [sp, #4]
	sub r6, r6, #1
	add lr, lr, r4
	add r4, r4, #8
	str r4, [sp, #4]
	sub r7, r7, #1
	sub ip, ip, #1
_02045B08:
	cmp r1, #0
	blt _02045B38
	cmp r1, #0x120
	bge _02045B38
	subs r5, r8, ip
	movmi r5, #0
	mov r4, r1, lsl #1
	mov r10, r6
	cmp r6, #0x300
	ldrge r10, _02045BF4 // =0x000002FF
	strh r5, [r3, r4]
	strh r10, [r9, r4]
_02045B38:
	cmp r7, #0
	blt _02045B68
	cmp r7, #0x120
	bge _02045B68
	subs r5, r8, r2
	movmi r5, #0
	mov r4, r7, lsl #1
	mov r10, r0
	cmp r0, #0x300
	ldrge r10, _02045BF4 // =0x000002FF
	strh r5, [r3, r4]
	strh r10, [r9, r4]
_02045B68:
	ldr r4, [sp]
	subs r10, r4, r2
	bmi _02045B9C
	cmp r10, #0x120
	bge _02045B9C
	subs r4, r8, ip
	movmi r4, #0
	mov r10, r10, lsl #1
	mov r5, r6
	cmp r6, #0x300
	ldrge r5, _02045BF4 // =0x000002FF
	strh r4, [r3, r10]
	strh r5, [r9, r10]
_02045B9C:
	ldr r4, [sp]
	subs r4, r4, ip
	bmi _02045BD0
	cmp r4, #0x120
	bge _02045BD0
	subs r5, r8, r2
	movmi r5, #0
	mov r4, r4, lsl #1
	mov r10, r0
	cmp r0, #0x300
	ldrge r10, _02045BF4 // =0x000002FF
	strh r5, [r3, r4]
	strh r10, [r9, r4]
_02045BD0:
	add lr, lr, r11
	add r11, r11, #8
	add r1, r1, #1
	add r0, r0, #1
	add r2, r2, #1
	cmp r2, ip
	ble _02045AE4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02045BF4: .word 0x000002FF
	arm_func_end SeaMapManager__Func_2045A58

	arm_func_start SeaMapManager__Func_2045BF8
SeaMapManager__Func_2045BF8: // 0x02045BF8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r6, r1
	mov r5, r2
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	add r0, r0, #0xa000
	ldr r4, [r0, #0x80]
	ldr r7, [r4, #4]
	cmp r7, #0
	bne _02045C3C
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	mov r2, r6
	mov r3, r5
	bl SeaMapManager__GetPosition2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02045C3C:
	mov r0, r7
	bl SeaMapManagerNodeList__GetNodeDistance
	mov r1, r0
	cmp r8, r1
	bgt _02045CD0
	mov r0, r8
	bl FX_Div
	ldrh r3, [r7, #0xa]
	mov r2, r0, lsl #0x10
	ldrh ip, [r7, #8]
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	mov r4, ip, lsl #0xc
	mov r3, r3, lsl #0xc
	mov r7, r2, asr #0x10
	sub r4, r4, r0, lsl #12
	sub r2, r3, r1, lsl #12
	smull r3, ip, r4, r7
	adds lr, r3, #0x800
	smull r4, r3, r2, r7
	adc r2, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r2, lsl #20
	adds r4, r4, #0x800
	adc r2, r3, #0
	mov r3, r4, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r1, r3, r1, lsl #12
	add r0, ip, r0, lsl #12
	mov r0, r0, lsl #4
	mov r1, r1, lsl #4
	mov r2, r6
	mov r3, r5
	mov r0, r0, lsr #0x10
	mov r1, r1, lsr #0x10
	bl SeaMapManager__GetPosition2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02045CD0:
	mov r4, r7
	ldr r7, [r7, #4]
	sub r8, r8, r1
	cmp r7, #0
	bne _02045C3C
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	mov r2, r6
	mov r3, r5
	bl SeaMapManager__GetPosition2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end SeaMapManager__Func_2045BF8

	arm_func_start SeaMapManager__AddNode
SeaMapManager__AddNode: // 0x02045CFC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	add r0, r0, #0x2080
	add r0, r0, #0x8000
	bl SeaMapManagerNodeList__AddNode
	strh r5, [r0, #8]
	strh r4, [r0, #0xa]
	bl SeaMapManagerNodeList__GetNodeDistance
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManager__AddNode

	arm_func_start SeaMapManager__RemoveNode
SeaMapManager__RemoveNode: // 0x02045D2C
	stmdb sp!, {r3, lr}
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	add r0, r0, #0x2080
	add r0, r0, #0x8000
	bl SeaMapManagerNodeList__RemoveLastNode
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapManager__RemoveNode

	arm_func_start SeaMapManager__RemoveAllNodes
SeaMapManager__RemoveAllNodes: // 0x02045D48
	stmdb sp!, {r3, lr}
_02045D4C:
	bl SeaMapManager__RemoveNode
	cmp r0, #0
	bne _02045D4C
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapManager__RemoveAllNodes

	arm_func_start SeaMapManager__GetStartNode
SeaMapManager__GetStartNode: // 0x02045D5C
	stmdb sp!, {r3, lr}
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	add r0, r0, #0xa000
	ldr r0, [r0, #0x80]
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapManager__GetStartNode

	arm_func_start SeaMapManager__GetEndNode
SeaMapManager__GetEndNode: // 0x02045D74
	stmdb sp!, {r3, lr}
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	add r0, r0, #0xa000
	ldr r0, [r0, #0x84]
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapManager__GetEndNode

	arm_func_start SeaMapManager__GetNextNode
SeaMapManager__GetNextNode: // 0x02045D8C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	mov r1, r4
	add r0, r0, #0x2080
	add r0, r0, #0x8000
	bl NNS_FndGetNextListObject
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__GetNextNode

	arm_func_start SeaMapManager__GetPrevNode
SeaMapManager__GetPrevNode: // 0x02045DB0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	mov r1, r4
	add r0, r0, #0x2080
	add r0, r0, #0x8000
	bl NNS_FndGetPrevListObject
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__GetPrevNode

	arm_func_start SeaMapManager__GetNodeCount
SeaMapManager__GetNodeCount: // 0x02045DD4
	stmdb sp!, {r3, lr}
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	add r0, r0, #0xa000
	ldrh r0, [r0, #0x88]
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapManager__GetNodeCount

	arm_func_start SeaMapManager__GetTotalDistance
SeaMapManager__GetTotalDistance: // 0x02045DEC
	stmdb sp!, {r4, lr}
	mov r4, #0
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	add r0, r0, #0xa000
	ldr r1, [r0, #0x80]
	cmp r1, #0
	beq _02045E20
_02045E0C:
	ldr r0, [r1, #0xc]
	ldr r1, [r1, #4]
	add r4, r4, r0
	cmp r1, #0
	bne _02045E0C
_02045E20:
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__GetTotalDistance

	arm_func_start SeaMapManager__GetLastNodePosition
SeaMapManager__GetLastNodePosition: // 0x02045E28
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	add r0, r0, #0xa000
	ldr r1, [r0, #0x84]
	ldrh r0, [r1, #8]
	strh r0, [r5]
	ldrh r0, [r1, #0xa]
	strh r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManager__GetLastNodePosition

	arm_func_start SeaMapManager__Func_2045E58
SeaMapManager__Func_2045E58: // 0x02045E58
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	mov r1, r4
	add r0, r0, #0x2080
	add r0, r0, #0x8000
	bl SeaMapManagerNodeList__Func_204611C
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManager__Func_2045E58

	.rodata

.public SeaMapManager__ZoomOutScaleTable
SeaMapManager__ZoomOutScaleTable: // 0x0210FB1C
	.word 0x1000, 0x800, 0x555

.public SeaMapManager__ZoomInScaleTable
SeaMapManager__ZoomInScaleTable: // 0x0210FB28
	.word 0x1000, 0x2000, 0x3000

_0210FB34:
	.word 0x00, 0x00, 0x00
	// .align 0x10


.public dword_210FB40
dword_210FB40: // 0x0210FB40 
	.word 0, 0xFF, 0xFF00, 0xFFFF, 0xFF0000, 0xFF00FF, 0xFFFF00
	.word 0xFFFFFF, 0xFF000000, 0xFF0000FF, 0xFF00FF00, 0xFF00FFFF
	.word 0xFFFF0000, 0xFFFF00FF, 0xFFFFFF00, 0xFFFFFFFF

	.data
	
aBbChBb: // 0x0211993C
	.asciz "/bb/ch.bb"
	.align 4

aCh: // 0x02119948
	.asciz "ch"
	.align 4