	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__GFXControl
.public VRAMSystem__VRAM_PALETTE_OBJ
.public SeaMapView__sVars
.public SeaMapCourseChangeView_02134174

	.text

	arm_func_start SeaMapChartCourseView__Create
SeaMapChartCourseView__Create: // 0x02040788
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	ldr r4, _02040904 // =VRAMSystem__GFXControl
	mov r7, r0
	mov r5, r2
	ldr r6, _02040908 // =seaMapViewMode
	mov ip, #3
	ldr r3, _0204090C // =seaMapViewUnknown1
	mov r2, #0
	ldr r4, [r4, r7, lsl #2]
	str ip, [r6]
	str r2, [r3]
	ldrsh r8, [r4, #0x58]
	mov r6, r1
	bl SeaMapManager__Create
	strh r8, [r4, #0x58]
	bl SeaMapManager__LoadMapBackground
	mov r0, #0xff
	mov r2, #0
	str r0, [sp]
	ldr r0, _02040910 // =0x00000ADC
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02040914 // =SeaMapChartCourseView__Main
	ldr r1, _02040918 // =SeaMapChartCourseView__Destructor
	mov r3, r2
	bl TaskCreate_
	ldr r1, _0204091C // =SeaMapView__sVars
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	ldr r2, _02040910 // =0x00000ADC
	bl MIi_CpuClear16
	cmp r5, #1
	beq _02040838
	ldr r2, _02040920 // =seaMapViewUnknown2
	mov r3, #0
	ldr r1, _02040924 // =SeaMapCourseChangeView_02134174
	ldr r0, _02040928 // =gameState
	str r3, [r2]
	str r3, [r1]
	str r3, [r0, #0xb0]
_02040838:
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, #1
	bl SeaMapView__InitView
	cmp r5, #2
	ldrne r1, _0204092C // =SeaMapChartCourseView__State_2041978
	ldrne r0, _02040930 // =SeaMapChartCourseView__Draw_2041440
	bne _02040870
	add r0, r4, #0x1d4
	add r0, r0, #0x800
	bl TouchField__Init
	ldr r1, _02040934 // =SeaMapChartCourseView__State_2042524
	ldr r0, _02040938 // =SeaMapChartCourseView__Draw_20414A0
_02040870:
	str r1, [r4, #0x7c4]
	str r0, [r4, #0x7c8]
	mov r0, r4
	str r5, [r4, #0x7b4]
	bl SeaMapChartCourseView__Func_2040B90
	ldr r1, _0204093C // =dword_210FAD0
	mov r0, r4
	bl SeaMapView__EnableMultipleButtons
	cmp r5, #1
	bne _020408AC
	mov r0, r4
	mov r1, #3
	mov r2, #0
	bl SeaMapView__EnableTouchArea
	b _020408C4
_020408AC:
	cmp r5, #2
	bne _020408C4
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl SeaMapView__EnableTouchArea
_020408C4:
	cmp r5, #2
	mov r0, r4
	bne _020408DC
	mov r1, #2
	bl SeaMapView__SetZoomLevel
	b _020408E4
_020408DC:
	mov r1, #0
	bl SeaMapView__SetZoomLevel
_020408E4:
	bl SeaMapEventManager__Create
	cmp r5, #0
	cmpne r5, #1
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl SeaMapEventManager__CreateDSPopup
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02040904: .word VRAMSystem__GFXControl
_02040908: .word seaMapViewMode
_0204090C: .word seaMapViewUnknown1
_02040910: .word 0x00000ADC
_02040914: .word SeaMapChartCourseView__Main
_02040918: .word SeaMapChartCourseView__Destructor
_0204091C: .word SeaMapView__sVars
_02040920: .word seaMapViewUnknown2
_02040924: .word SeaMapCourseChangeView_02134174
_02040928: .word gameState
_0204092C: .word SeaMapChartCourseView__State_2041978
_02040930: .word SeaMapChartCourseView__Draw_2041440
_02040934: .word SeaMapChartCourseView__State_2042524
_02040938: .word SeaMapChartCourseView__Draw_20414A0
_0204093C: .word dword_210FAD0
	arm_func_end SeaMapChartCourseView__Create

	arm_func_start SeaMapChartCourseView__Destroy
SeaMapChartCourseView__Destroy: // 0x02040940
	stmdb sp!, {r3, lr}
	ldr r0, _02040974 // =SeaMapView__sVars
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl DestroyTask
	ldr r0, _02040974 // =SeaMapView__sVars
	mov r1, #0
	str r1, [r0]
	bl SeaMapEventManager__Destroy
	bl SeaMapManager__Destroy
	bl DestroyNavTails
	ldmia sp!, {r3, pc}
	.align 2, 0
_02040974: .word SeaMapView__sVars
	arm_func_end SeaMapChartCourseView__Destroy

	arm_func_start SeaMapChartCourseView__Func_2040978
SeaMapChartCourseView__Func_2040978: // 0x02040978
	stmdb sp!, {r3, lr}
	ldr r0, _020409A8 // =SeaMapView__sVars
	ldr r0, [r0, #0]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetTaskWork_
	ldr r0, [r0, #0x7cc]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_020409A8: .word SeaMapView__sVars
	arm_func_end SeaMapChartCourseView__Func_2040978

	arm_func_start SeaMapChartCourseView__TouchAreaCallback
SeaMapChartCourseView__TouchAreaCallback: // 0x020409AC
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, [r5, #0]
	mov r4, r2
	cmp r0, #0x400000
	ldr r1, [r1, #0x14]
	bhi _020409E4
	cmp r0, #0x400000
	bhs _02040A08
	cmp r0, #0x200000
	beq _02040A50
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_020409E4:
	cmp r0, #0x800000
	bhi _020409F8
	beq _02040AD8
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_020409F8:
	cmp r0, #0x1000000
	beq _02040AA4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_02040A08:
	tst r1, #0x800
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, _02040B8C // =touchInput
	mov r0, r4
	ldrh r3, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	and r1, r3, #0xff
	and r2, r2, #0xff
	bl SeaMapChartCourseView__Func_2040FE8
	cmp r0, #0
	beq _02040A3C
	bl SeaMapView__Func_203FAD4
_02040A3C:
	mov r0, r4
	mvn r1, #0
	bl SeaMapView__InitTouchCursor
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_02040A50:
	tst r1, #0x800
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	add r0, r4, #0x700
	ldrh r1, [r0, #0xb0]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	sub r1, r1, #1
	strh r1, [r0, #0xb0]
	ldrh r0, [r0, #0xb0]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x7a8]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	add sp, sp, #8
	str r0, [r4, #0x7ac]
	ldmia sp!, {r3, r4, r5, pc}
_02040AA4:
	tst r1, #0x800
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl SeaMapView__Func_203FE80
	bl SeaMapView__DrawVoyagePath
	ldr r0, [r4, #0x7a8]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	add sp, sp, #8
	str r0, [r4, #0x7ac]
	ldmia sp!, {r3, r4, r5, pc}
_02040AD8:
	tst r1, #0x800
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, _02040B8C // =touchInput
	mov r0, r4
	ldrh r3, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	and r1, r3, #0xff
	and r2, r2, #0xff
	bl SeaMapChartCourseView__Func_2040FE8
	cmp r0, #0
	beq _02040B0C
	bl SeaMapView__Func_203FAD4
_02040B0C:
	mov r0, r4
	mvn r1, #0
	bl SeaMapView__InitTouchCursor
	ldr r0, [r4, #0x79c]
	cmp r0, #0x3000
	addle sp, sp, #8
	ldmleia sp!, {r3, r4, r5, pc}
	ldrsh r0, [r5, #4]
	cmp r0, #0
	ldreqsh r0, [r5, #6]
	cmpeq r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x7ac]
	cmp r0, #0
	bne _02040B78
	mov r1, #2
	mov r0, #0xa
	str r1, [sp]
	sub r1, r0, #0xb
	str r0, [sp, #4]
	ldr r0, [r4, #0x7a8]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #1
	str r0, [r4, #0x7ac]
_02040B78:
	add r0, r4, #0x700
	mov r1, #8
	strh r1, [r0, #0xb0]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02040B8C: .word touchInput
	arm_func_end SeaMapChartCourseView__TouchAreaCallback

	arm_func_start SeaMapChartCourseView__Func_2040B90
SeaMapChartCourseView__Func_2040B90: // 0x02040B90
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r10, r0
	mov r7, #0
	ldr r9, _02040C4C // =byte_210FA4C
	ldr r5, _02040C50 // =VRAMSystem__VRAM_PALETTE_OBJ
	add r8, r10, #0x7d0
	mov r6, r7
	mov r11, #0x800
	mov r4, #4
_02040BB8:
	ldr r0, [r10, #0xc]
	ldrb r1, [r9, #0]
	ldr r0, [r0, #0]
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	ldr r0, [r10, #4]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r10, #4]
	mov r3, r11
	stmia sp, {r1, r6}
	str r0, [sp, #8]
	str r6, [sp, #0xc]
	ldr r1, [r10, #4]
	mov r0, r8
	ldr r1, [r5, r1, lsl #2]
	str r1, [sp, #0x10]
	str r6, [sp, #0x14]
	ldrb r1, [r9, #1]
	str r1, [sp, #0x18]
	ldr r1, [r10, #0xc]
	ldrb r2, [r9], #2
	ldr r1, [r1, #0]
	bl AnimatorSprite__Init
	mov r1, #0
	strh r4, [r8, #0x50]
	mov r0, r8
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r8, #0x3c]
	add r7, r7, #1
	orr r0, r0, #0x10
	str r0, [r8, #0x3c]
	cmp r7, #5
	add r8, r8, #0x64
	blo _02040BB8
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02040C4C: .word byte_210FA4C
_02040C50: .word VRAMSystem__VRAM_PALETTE_OBJ
	arm_func_end SeaMapChartCourseView__Func_2040B90

	arm_func_start SeaMapChartCourseView__Func_2040C54
SeaMapChartCourseView__Func_2040C54: // 0x02040C54
	stmdb sp!, {r3, r4, r5, lr}
	add r5, r0, #0x7d0
	mov r4, #0
_02040C60:
	mov r0, r5
	bl AnimatorSprite__Release
	add r4, r4, #1
	cmp r4, #5
	add r5, r5, #0x64
	blo _02040C60
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapChartCourseView__Func_2040C54

	arm_func_start SeaMapChartCourseView__Func_2040C7C
SeaMapChartCourseView__Func_2040C7C: // 0x02040C7C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r1, [r5, #0x790]
	mov r4, #1
	cmp r1, #0
	beq _02040CAC
	cmp r1, #1
	beq _02040CF4
	cmp r1, #2
	beq _02040CFC
	b _02040D04
_02040CAC:
	mov r0, #0
	sub r1, r0, #1
	mov ip, #2
	str ip, [sp]
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	ldr r0, _02040D1C // =seaMapViewUnknown1
	mov r1, #2
	str r1, [r0]
	ldr r0, [r5, #0x7b4]
	cmp r0, #2
	ldreq r0, _02040D20 // =SeaMapChartCourseView__State_20431D4
	streq r0, [r5, #0x7c4]
	ldrne r0, _02040D24 // =SeaMapChartCourseView__State_2041E30
	strne r0, [r5, #0x7c4]
	b _02040D08
_02040CF4:
	bl SeaMapChartCourseView__Func_20416F0
	b _02040D08
_02040CFC:
	bl SeaMapChartCourseView__Func_2041834
	b _02040D08
_02040D04:
	mov r4, #0
_02040D08:
	mvn r1, #0
	mov r0, r4
	str r1, [r5, #0x790]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02040D1C: .word seaMapViewUnknown1
_02040D20: .word SeaMapChartCourseView__State_20431D4
_02040D24: .word SeaMapChartCourseView__State_2041E30
	arm_func_end SeaMapChartCourseView__Func_2040C7C

	arm_func_start SeaMapChartCourseView__Func_2040D28
SeaMapChartCourseView__Func_2040D28: // 0x02040D28
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	bl SeaMapManager__GetWork
	bl SeaMapEventManager__GetWork2
	mov r6, r0
	ldr r0, [r6, #0]
	mov r4, #1
	cmp r0, #0
	bne _02040DC8
	mov r2, #2
	mov r0, #0
	sub r1, r0, #1
	str r2, [sp]
	mov ip, #3
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	ldr r0, [r6, #4]
	str r0, [r5, #0x9c4]
	bl SeaMapEventManager__Func_2046A78
	ldr r1, [r5, #0x9c4]
	add r2, sp, #8
	ldrsh r0, [r1, #0xc]
	ldrsh r1, [r1, #0xe]
	add r3, sp, #0xa
	mov r0, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	bl SeaMapManager__Func_2043B28
	ldrh r0, [sp, #8]
	ldrh r1, [sp, #0xa]
	bl SeaMapManager__AddNode
	ldr r0, [r5, #0x7b4]
	cmp r0, #2
	ldreq r0, _02040DD8 // =SeaMapChartCourseView__State_2042D14
	streq r0, [r5, #0x7c4]
	ldrne r0, _02040DDC // =SeaMapChartCourseView__State_2041A68
	strne r0, [r5, #0x7c4]
	b _02040DCC
_02040DC8:
	mov r4, #0
_02040DCC:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02040DD8: .word SeaMapChartCourseView__State_2042D14
_02040DDC: .word SeaMapChartCourseView__State_2041A68
	arm_func_end SeaMapChartCourseView__Func_2040D28

	arm_func_start SeaMapChartCourseView__Func_2040DE0
SeaMapChartCourseView__Func_2040DE0: // 0x02040DE0
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r1, [r5, #0x790]
	mov r4, #1
	cmp r1, #4
	addls pc, pc, r1, lsl #2
	b _02040EC8
_02040E00: // jump table
	b _02040EC8 // case 0
	b _02040EB0 // case 1
	b _02040EBC // case 2
	b _02040E6C // case 3
	b _02040E14 // case 4
_02040E14:
	mov ip, #2
	mov r0, #0
	sub r1, r0, #1
	str ip, [sp]
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	ldr r0, [r5, #0x7b4]
	cmp r0, #1
	bne _02040E60
	bl SeaMapManager__GetNodeCount
	cmp r0, #1
	ldrls r0, _02040EE0 // =SeaMapChartCourseView__State_2041DD0
	strls r0, [r5, #0x7c4]
	bls _02040ECC
	mov r0, r5
	bl SeaMapChartCourseView__Func_2041048
	b _02040ECC
_02040E60:
	mov r0, r5
	bl SeaMapChartCourseView__Func_2041048
	b _02040ECC
_02040E6C:
	mov r0, #0
	sub r1, r0, #1
	mov r2, #2
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
	mov r0, r5
	bl SeaMapChartCourseView__Func_2042208
	ldr r0, [r5, #0x7b4]
	cmp r0, #2
	ldreq r0, _02040EE4 // =SeaMapChartCourseView__State_2042FA8
	streq r0, [r5, #0x7c4]
	ldrne r0, _02040EE8 // =SeaMapChartCourseView__State_2041C64
	strne r0, [r5, #0x7c4]
	b _02040ECC
_02040EB0:
	bl SeaMapChartCourseView__Func_20416F0
	bl SeaMapView__DrawVoyagePath
	b _02040ECC
_02040EBC:
	bl SeaMapChartCourseView__Func_2041834
	bl SeaMapView__DrawVoyagePath
	b _02040ECC
_02040EC8:
	mov r4, #0
_02040ECC:
	mvn r1, #0
	mov r0, r4
	str r1, [r5, #0x790]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02040EE0: .word SeaMapChartCourseView__State_2041DD0
_02040EE4: .word SeaMapChartCourseView__State_2042FA8
_02040EE8: .word SeaMapChartCourseView__State_2041C64
	arm_func_end SeaMapChartCourseView__Func_2040DE0

	arm_func_start SeaMapChartCourseView__State_2040EEC
SeaMapChartCourseView__State_2040EEC: // 0x02040EEC
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, [r5, #0x790]
	mov r4, #1
	cmp r0, #6
	beq _02040F14
	cmp r0, #7
	beq _02040F4C
	b _02040F84
_02040F14:
	mov ip, #2
	mov r0, #0
	sub r1, r0, #1
	str ip, [sp]
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	ldr r0, [r5, #0x9c8]
	cmp r0, #0
	cmpne r0, #1
	ldreq r0, _02040F9C // =SeaMapChartCourseView__State_2041A68
	streq r0, [r5, #0x7c4]
	b _02040F88
_02040F4C:
	mov r0, #0
	sub r1, r0, #1
	mov r2, #2
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
	ldr r0, _02040FA0 // =seaMapViewUnknown1
	mov r2, #2
	ldr r1, _02040FA4 // =SeaMapChartCourseView__State_2041E30
	str r2, [r0]
	str r1, [r5, #0x7c4]
	b _02040F88
_02040F84:
	mov r4, #0
_02040F88:
	mvn r1, #0
	mov r0, r4
	str r1, [r5, #0x790]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02040F9C: .word SeaMapChartCourseView__State_2041A68
_02040FA0: .word seaMapViewUnknown1
_02040FA4: .word SeaMapChartCourseView__State_2041E30
	arm_func_end SeaMapChartCourseView__State_2040EEC

	arm_func_start SeaMapChartCourseView__SetTouchCallback
SeaMapChartCourseView__SetTouchCallback: // 0x02040FA8
	stmdb sp!, {r3, r4, r5, lr}
	movs r4, r1
	mov r5, r0
	beq _02040FC4
	cmp r4, #1
	beq _02040FD0
	b _02040FD8
_02040FC4:
	ldr r1, _02040FE0 // =SeaMapChartCourseView__TouchAreaCallback
	bl SeaMapView__SetTouchAreaCallback
	b _02040FD8
_02040FD0:
	ldr r1, _02040FE4 // =SeaMapView__TouchAreaCallback
	bl SeaMapView__SetTouchAreaCallback
_02040FD8:
	str r4, [r5, #0x9c8]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02040FE0: .word SeaMapChartCourseView__TouchAreaCallback
_02040FE4: .word SeaMapView__TouchAreaCallback
	arm_func_end SeaMapChartCourseView__SetTouchCallback

	arm_func_start SeaMapChartCourseView__Func_2040FE8
SeaMapChartCourseView__Func_2040FE8: // 0x02040FE8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r0, r1
	mov r1, r2
	add r2, sp, #0
	add r3, sp, #2
	bl SeaMapManager__Func_2043A9C
	ldrh r1, [sp]
	ldrh r2, [sp, #2]
	mov r0, r4
	bl SeaMapView__Func_203FC7C
	mvn r1, #1
	cmp r0, r1
	addne r1, r1, #1
	cmpne r0, r1
	cmpne r0, #0
	bne _0204103C
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r3, r4, pc}
_0204103C:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end SeaMapChartCourseView__Func_2040FE8

	arm_func_start SeaMapChartCourseView__Func_2041048
SeaMapChartCourseView__Func_2041048: // 0x02041048
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r0, [r4, #0x7b4]
	cmp r0, #1
	bne _02041094
	bl SeaMapManager__GetStartNode
	ldrh r5, [r0, #8]
	ldrh r6, [r0, #0xa]
	mov r0, r4
	bl SeaMapView__Func_203FE44
	mov r0, r5
	mov r1, r6
	bl SeaMapManager__AddNode
	bl SeaMapView__DrawVoyagePath
	mov r0, r4
	mov r1, #3
	mov r2, #0
	bl SeaMapView__EnableTouchArea
	ldmia sp!, {r4, r5, r6, pc}
_02041094:
	ldr r0, [r4, #0x9c4]
	bl SeaMapEventManager__Func_2046A94
	mov r0, #0
	str r0, [r4, #0x9c4]
	bl SeaMapEventManager__Func_2046A78
	ldr r1, _020410F4 // =dword_210FAD0
	mov r0, r4
	bl SeaMapView__EnableMultipleButtons
	mov r0, r4
	bl SeaMapView__Func_203FE44
	bl SeaMapView__DrawVoyagePath
	ldr r1, _020410F8 // =SeaMapView__TouchAreaCallback
	mov r0, r4
	bl SeaMapView__SetTouchAreaCallback
	ldr r0, [r4, #0x7b4]
	cmp r0, #2
	ldrne r0, _020410FC // =SeaMapChartCourseView__State_20419B0
	strne r0, [r4, #0x7c4]
	ldmneia sp!, {r4, r5, r6, pc}
	mov r1, #0
	ldr r0, _02041100 // =SeaMapChartCourseView__State_2042C6C
	str r1, [r4, #0xab8]
	str r0, [r4, #0x7c4]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020410F4: .word dword_210FAD0
_020410F8: .word SeaMapView__TouchAreaCallback
_020410FC: .word SeaMapChartCourseView__State_20419B0
_02041100: .word SeaMapChartCourseView__State_2042C6C
	arm_func_end SeaMapChartCourseView__Func_2041048

	arm_func_start SeaMapChartCourseView__Func_2041104
SeaMapChartCourseView__Func_2041104: // 0x02041104
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r1
	mov r4, r2
	bl SeaMapView__Func_203DD44
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	bl SeaMapManager__GetNodeCount
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	add r0, sp, #2
	add r1, sp, #0
	bl SeaMapManager__GetLastNodePosition
	ldrh r0, [sp, #2]
	ldrh r1, [sp]
	add r2, sp, #6
	add r3, sp, #4
	bl SeaMapManager__Func_2043AD4
	ldrsh r2, [sp, #6]
	cmp r2, #0
	blt _02041184
	cmp r2, #0x100
	bge _02041184
	ldrsh r0, [sp, #4]
	cmp r0, #0
	blt _02041184
	cmp r0, #0xc0
	blt _02041190
_02041184:
	add sp, sp, #8
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_02041190:
	sub r1, r0, r4
	sub r0, r2, r5
	movs r0, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	rsbmi r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r0, r1
	ldr r2, _02041260 // =0x00000F5E
	ldr r3, _02041264 // =0x0000065D
	mov ip, #0
	ble _02041208
	umull lr, r6, r0, r2
	mla r6, r0, ip, r6
	umull r5, r4, r1, r3
	mov r0, r0, asr #0x1f
	mla r6, r0, r2, r6
	adds lr, lr, #0x800
	adc r6, r6, #0
	adds r2, r5, #0x800
	mov r5, lr, lsr #0xc
	mla r4, r1, ip, r4
	mov r0, r1, asr #0x1f
	mla r4, r0, r3, r4
	adc r0, r4, #0
	mov r1, r2, lsr #0xc
	orr r5, r5, r6, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r5, r1
	b _0204124C
_02041208:
	umull r6, r5, r1, r2
	mla r5, r1, ip, r5
	umull r4, lr, r0, r3
	mla lr, r0, ip, lr
	mov r1, r1, asr #0x1f
	mov r0, r0, asr #0x1f
	mla r5, r1, r2, r5
	adds r6, r6, #0x800
	adc r2, r5, #0
	adds r1, r4, #0x800
	mla lr, r0, r3, lr
	mov r4, r6, lsr #0xc
	adc r0, lr, #0
	mov r1, r1, lsr #0xc
	orr r4, r4, r2, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r4, r1
_0204124C:
	cmp r0, #0x8000
	movgt r0, #1
	movle r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02041260: .word 0x00000F5E
_02041264: .word 0x0000065D
	arm_func_end SeaMapChartCourseView__Func_2041104

	arm_func_start SeaMapChartCourseView__Func_2041268
SeaMapChartCourseView__Func_2041268: // 0x02041268
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r0, _020413B0 // =touchInput
	add r2, sp, #2
	ldrh r1, [r0, #0x16]
	ldrh r4, [r0, #0x14]
	add r3, sp, #0
	and r1, r1, #0xff
	and r0, r4, #0xff
	bl SeaMapManager__Func_2043B7C
	ldrh r0, [sp, #2]
	ldrh r1, [sp]
	mov r2, #1
	bl SeaMapCollision__Collide
	cmp r0, #0
	beq _020413A4
	bl SeaMapManager__GetEndNode
	mov r1, r0
	ldrh r0, [r1, #8]
	ldrh r1, [r1, #0xa]
	add r2, sp, #4
	add r3, sp, #6
	bl SeaMapManager__Func_2043AD4
	ldr r0, _020413B0 // =touchInput
	ldrsh r1, [sp, #6]
	ldrh r3, [r0, #0x16]
	ldrh r2, [r0, #0x14]
	ldrsh r0, [sp, #4]
	sub r1, r3, r1
	mov r1, r1, lsl #0xc
	sub r0, r2, r0
	movs r0, r0, lsl #0xc
	rsbmi r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r0, r1
	ldr r2, _020413B4 // =0x00000F5E
	ldr r3, _020413B8 // =0x0000065D
	mov ip, #0
	ble _02041350
	umull lr, r6, r0, r2
	mla r6, r0, ip, r6
	umull r5, r4, r1, r3
	mov r0, r0, asr #0x1f
	mla r6, r0, r2, r6
	adds lr, lr, #0x800
	adc r6, r6, #0
	adds r2, r5, #0x800
	mov r5, lr, lsr #0xc
	mla r4, r1, ip, r4
	mov r0, r1, asr #0x1f
	mla r4, r0, r3, r4
	adc r0, r4, #0
	mov r1, r2, lsr #0xc
	orr r5, r5, r6, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r5, r1
	b _02041394
_02041350:
	umull r6, r5, r1, r2
	mla r5, r1, ip, r5
	umull r4, lr, r0, r3
	mla lr, r0, ip, lr
	mov r1, r1, asr #0x1f
	mov r0, r0, asr #0x1f
	mla r5, r1, r2, r5
	adds r6, r6, #0x800
	adc r2, r5, #0
	adds r1, r4, #0x800
	mla lr, r0, r3, lr
	mov r4, r6, lsr #0xc
	adc r0, lr, #0
	mov r1, r1, lsr #0xc
	orr r4, r4, r2, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r4, r1
_02041394:
	cmp r0, #0x8000
	addgt sp, sp, #8
	movgt r0, #1
	ldmgtia sp!, {r4, r5, r6, pc}
_020413A4:
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020413B0: .word touchInput
_020413B4: .word 0x00000F5E
_020413B8: .word 0x0000065D
	arm_func_end SeaMapChartCourseView__Func_2041268

	arm_func_start SeaMapChartCourseView__Main
SeaMapChartCourseView__Main: // 0x020413BC
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x7c4]
	blx r1
	ldr r0, [r4, #0x7cc]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x7c8]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapChartCourseView__Main

	arm_func_start SeaMapChartCourseView__Destructor
SeaMapChartCourseView__Destructor: // 0x020413EC
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl SeaMapChartCourseView__Func_2040C54
	ldr r0, [r4, #0x7b4]
	cmp r0, #2
	bne _02041418
	ldr r0, [r4, #0xab0]
	cmp r0, #0
	beq _02041418
	bl SeaMapEventTrigger_RemoveEventListener
_02041418:
	mov r0, r4
	bl SeaMapView__ReleaseAssets
	ldr r1, _02041438 // =seaMapViewMode
	mov r2, #0
	ldr r0, _0204143C // =SeaMapView__sVars
	str r2, [r1]
	str r2, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02041438: .word seaMapViewMode
_0204143C: .word SeaMapView__sVars
	arm_func_end SeaMapChartCourseView__Destructor

	arm_func_start SeaMapChartCourseView__Draw_2041440
SeaMapChartCourseView__Draw_2041440: // 0x02041440
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapChartCourseView__Func_204153C
	mov r0, r4
	bl SeaMapView__Func_203E8A8
	ldr r0, [r4, #0x9cc]
	cmp r0, #0
	beq _02041468
	mov r0, r4
	bl SeaMapView__DrawPadCursors
_02041468:
	mov r0, r4
	bl SeaMapView__Func_203F770
	mov r0, r4
	bl SeaMapView__DrawButtons
	mov r0, r4
	bl SeaMapView__DrawTouchCursor
	mov r0, r4
	bl SeaMapView__DrawPenMarker
	ldr r0, [r4, #0x9d0]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl SeaMapView__Func_203E914
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapChartCourseView__Draw_2041440

	arm_func_start SeaMapChartCourseView__Draw_20414A0
SeaMapChartCourseView__Draw_20414A0: // 0x020414A0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r1, r5, #0x1d4
	add r4, r1, #0x800
	bl SeaMapChartCourseView__Func_204153C
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x154]
	cmp r0, #0
	beq _020414E0
	mov r0, r5
	bl SeaMapView__Func_203E8A8
	ldr r0, [r5, #0x9cc]
	cmp r0, #0
	beq _020414E0
	mov r0, r5
	bl SeaMapView__DrawPadCursors
_020414E0:
	mov r0, r5
	bl SeaMapView__Func_203F770
	mov r0, r5
	bl SeaMapView__DrawButtons
	mov r0, r5
	bl SeaMapView__DrawTouchCursor
	mov r0, r5
	bl SeaMapView__DrawPenMarker
	ldr r0, [r5, #0x9d0]
	cmp r0, #0
	bne _02041514
	mov r0, r5
	bl SeaMapView__Func_203E914
_02041514:
	ldr r0, [r4, #0xcc]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x28
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x28
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapChartCourseView__Draw_20414A0

	arm_func_start SeaMapChartCourseView__Func_204153C
SeaMapChartCourseView__Func_204153C: // 0x0204153C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r5, r0
	add r0, r5, #0x7d0
	mov r1, #0xe
	strh r1, [r0, #8]
	mov r1, #0xf
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, [r5, #0x798]
	mov r1, #8
	mov r0, r0, asr #0xc
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	add r1, r5, #0x34
	movs r4, r0, lsr #0x10
	add r7, r1, #0x800
	mov r6, #0
	beq _020415B0
_02041584:
	mov r0, r6
	add r1, r7, #8
	add r2, r7, #0xa
	bl SeaMapChartCourseView__Func_20416D8
	mov r0, r7
	bl AnimatorSprite__DrawFrame
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	cmp r4, r0, lsr #16
	mov r6, r0, lsr #0x10
	bhi _02041584
_020415B0:
	add r0, r5, #0x98
	add r6, r0, #0x800
	mov r0, r4
	add r1, r6, #8
	add r2, r6, #0xa
	bl SeaMapChartCourseView__Func_20416D8
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	ldr r0, [r5, #0x79c]
	ldr r1, _020416CC // =0x04000280
	mov r2, #0
	strh r2, [r1]
	mov r0, r0, asr #0xc
	str r0, [r1, #0x10]
	mov r0, #8
	str r0, [r1, #0x18]
	str r2, [r1, #0x1c]
_020415F4:
	ldrh r0, [r1, #0]
	tst r0, #0x8000
	bne _020415F4
	ldr r1, _020416D0 // =0x040002A0
	ldr r0, [r1, #0]
	sub r1, r1, #0x20
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
_02041614:
	ldrh r0, [r1, #0]
	tst r0, #0x8000
	bne _02041614
	ldr r0, _020416D4 // =0x040002A8
	mov r1, #8
	ldr r0, [r0, #0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0xd
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	add r1, r5, #0xfc
	cmp r4, #0
	mov r6, r0, lsr #0x10
	add r7, r1, #0x800
	mov r8, #0
	bls _02041680
_02041654:
	mov r0, r8
	add r1, r7, #8
	add r2, r7, #0xa
	bl SeaMapChartCourseView__Func_20416D8
	mov r0, r7
	bl AnimatorSprite__DrawFrame
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	cmp r4, r0, lsr #16
	mov r8, r0, lsr #0x10
	bhi _02041654
_02041680:
	cmp r6, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	rsb r0, r6, #0x24
	add r5, r5, #0x960
	mov r1, r0, lsl #0x10
	mov r0, r5
	mov r1, r1, lsr #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	add r1, r5, #8
	add r2, r5, #0xa
	bl SeaMapChartCourseView__Func_20416D8
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020416CC: .word 0x04000280
_020416D0: .word 0x040002A0
_020416D4: .word 0x040002A8
	arm_func_end SeaMapChartCourseView__Func_204153C

	arm_func_start SeaMapChartCourseView__Func_20416D8
SeaMapChartCourseView__Func_20416D8: // 0x020416D8
	mov r0, r0, lsl #3
	add r0, r0, #0x1c
	strh r0, [r1]
	mov r0, #8
	strh r0, [r2]
	bx lr
	arm_func_end SeaMapChartCourseView__Func_20416D8

	arm_func_start SeaMapChartCourseView__Func_20416F0
SeaMapChartCourseView__Func_20416F0: // 0x020416F0
	ldr r2, [r0, #0x7c4]
	ldr r1, _02041704 // =SeaMapChartCourseView__State_2041708
	str r2, [r0, #0x7c0]
	str r1, [r0, #0x7c4]
	bx lr
	.align 2, 0
_02041704: .word SeaMapChartCourseView__State_2041708
	arm_func_end SeaMapChartCourseView__Func_20416F0

	arm_func_start SeaMapChartCourseView__State_2041708
SeaMapChartCourseView__State_2041708: // 0x02041708
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl SeaMapView__InitZoomControl
	mov r0, #0
	bl SeaMapManager__EnableTouchField
	mov r0, #0
	mov r3, #2
	sub r1, r0, #1
	str r3, [sp]
	mov r3, #0xe
	str r3, [sp, #4]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, _02041768 // =SeaMapChartCourseView__State_204176C
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02041768: .word SeaMapChartCourseView__State_204176C
	arm_func_end SeaMapChartCourseView__State_2041708

	arm_func_start SeaMapChartCourseView__State_204176C
SeaMapChartCourseView__State_204176C: // 0x0204176C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView__CanZoomIn
	cmp r0, #0
	ldrne r0, _02041790 // =SeaMapChartCourseView__State_2041794
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02041790: .word SeaMapChartCourseView__State_2041794
	arm_func_end SeaMapChartCourseView__State_204176C

	arm_func_start SeaMapChartCourseView__State_2041794
SeaMapChartCourseView__State_2041794: // 0x02041794
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetZoomLevel
	cmp r0, #1
	beq _020417B4
	cmp r0, #2
	beq _020417C4
	b _020417D0
_020417B4:
	mov r0, r4
	mov r1, #0
	bl SeaMapView__SetZoomLevel
	b _020417D0
_020417C4:
	mov r0, r4
	mov r1, #1
	bl SeaMapView__SetZoomLevel
_020417D0:
	mov r0, r4
	bl SeaMapView__ProcessPadInputs
	bl SeaMapView__DrawVoyagePath
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl SeaMapView__InitZoomControl
	ldr r1, _02041800 // =SeaMapChartCourseView__State_2041804
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02041800: .word SeaMapChartCourseView__State_2041804
	arm_func_end SeaMapChartCourseView__State_2041794

	arm_func_start SeaMapChartCourseView__State_2041804
SeaMapChartCourseView__State_2041804: // 0x02041804
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView__HandleZoomIn
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x7c0]
	mov r0, #1
	str r1, [r4, #0x7c4]
	bl SeaMapManager__EnableTouchField
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapChartCourseView__State_2041804

	arm_func_start SeaMapChartCourseView__Func_2041834
SeaMapChartCourseView__Func_2041834: // 0x02041834
	ldr r2, [r0, #0x7c4]
	ldr r1, _02041848 // =SeaMapChartCourseView__Func_204184C
	str r2, [r0, #0x7c0]
	str r1, [r0, #0x7c4]
	bx lr
	.align 2, 0
_02041848: .word SeaMapChartCourseView__Func_204184C
	arm_func_end SeaMapChartCourseView__Func_2041834

	arm_func_start SeaMapChartCourseView__Func_204184C
SeaMapChartCourseView__Func_204184C: // 0x0204184C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl SeaMapView__InitZoomControl
	mov r0, #0
	bl SeaMapManager__EnableTouchField
	mov r0, #0
	mov r3, #2
	sub r1, r0, #1
	str r3, [sp]
	mov r3, #0xf
	str r3, [sp, #4]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, _020418AC // =SeaMapChartCourseView__Func_20418B0
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_020418AC: .word SeaMapChartCourseView__Func_20418B0
	arm_func_end SeaMapChartCourseView__Func_204184C

	arm_func_start SeaMapChartCourseView__Func_20418B0
SeaMapChartCourseView__Func_20418B0: // 0x020418B0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView__CanZoomOut
	cmp r0, #0
	ldrne r0, _020418D4 // =SeaMapChartCourseView__Func_20418D8
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020418D4: .word SeaMapChartCourseView__Func_20418D8
	arm_func_end SeaMapChartCourseView__Func_20418B0

	arm_func_start SeaMapChartCourseView__Func_20418D8
SeaMapChartCourseView__Func_20418D8: // 0x020418D8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetZoomLevel
	cmp r0, #0
	beq _020418F8
	cmp r0, #1
	beq _02041908
	b _02041914
_020418F8:
	mov r0, r4
	mov r1, #1
	bl SeaMapView__SetZoomLevel
	b _02041914
_02041908:
	mov r0, r4
	mov r1, #2
	bl SeaMapView__SetZoomLevel
_02041914:
	mov r0, r4
	bl SeaMapView__ProcessPadInputs
	bl SeaMapView__DrawVoyagePath
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl SeaMapView__InitZoomControl
	ldr r1, _02041944 // =SeaMapChartCourseView__Func_2041948
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02041944: .word SeaMapChartCourseView__Func_2041948
	arm_func_end SeaMapChartCourseView__Func_20418D8

	arm_func_start SeaMapChartCourseView__Func_2041948
SeaMapChartCourseView__Func_2041948: // 0x02041948
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView__HandleZoomOut
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x7c0]
	mov r0, #1
	str r1, [r4, #0x7c4]
	bl SeaMapManager__EnableTouchField
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapChartCourseView__Func_2041948

	arm_func_start SeaMapChartCourseView__State_2041978
SeaMapChartCourseView__State_2041978: // 0x02041978
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapView__FadeToBlack
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x7b4]
	cmp r0, #1
	ldreq r0, _020419A8 // =SeaMapChartCourseView__State_2041A68
	streq r0, [r4, #0x7c4]
	ldrne r0, _020419AC // =SeaMapChartCourseView__State_20419B0
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020419A8: .word SeaMapChartCourseView__State_2041A68
_020419AC: .word SeaMapChartCourseView__State_20419B0
	arm_func_end SeaMapChartCourseView__State_2041978

	arm_func_start SeaMapChartCourseView__State_20419B0
SeaMapChartCourseView__State_20419B0: // 0x020419B0
	stmdb sp!, {r4, lr}
	ldr r1, _02041A0C // =seaMapViewMode
	mov r2, #3
	mov r4, r0
	str r2, [r1]
	bl SeaMapView__Func_203E898
	ldr r1, _02041A10 // =dword_210FAD0
	mov r0, r4
	bl SeaMapView__EnableMultipleButtons
	bl SeaMapManager__GetZoomLevel
	mov r1, r0
	mov r0, r4
	bl SeaMapView__SetButtonMode
	mov r0, #0x28
	mov r1, #0x258
	bl NavTailsSpeak
	mov r0, #1
	str r0, [r4, #0x9cc]
	ldr r1, _02041A14 // =SeaMapChartCourseView__State_2041A18
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02041A0C: .word seaMapViewMode
_02041A10: .word dword_210FAD0
_02041A14: .word SeaMapChartCourseView__State_2041A18
	arm_func_end SeaMapChartCourseView__State_20419B0

	arm_func_start SeaMapChartCourseView__State_2041A18
SeaMapChartCourseView__State_2041A18: // 0x02041A18
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapView__ProcessPadInputs
	mov r0, r4
	bl SeaMapView__ProcessButtons
	bl SeaMapEventManager__GetWork2
	ldr r1, [r0, #0]
	mvn r0, #0
	cmp r1, r0
	mov r0, r4
	beq _02041A60
	bl SeaMapChartCourseView__Func_2040D28
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x7c4]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
_02041A60:
	bl SeaMapChartCourseView__Func_2040C7C
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapChartCourseView__State_2041A18

	arm_func_start SeaMapChartCourseView__State_2041A68
SeaMapChartCourseView__State_2041A68: // 0x02041A68
	stmdb sp!, {r4, lr}
	ldr r1, _02041AD0 // =seaMapViewMode
	mov r2, #4
	mov r4, r0
	str r2, [r1]
	bl SeaMapView__Func_203E898
	mov r2, #1
	ldr r1, _02041AD4 // =dword_210FAF0
	mov r0, r4
	str r2, [r4, #0x9cc]
	bl SeaMapView__EnableMultipleButtons
	bl SeaMapManager__GetZoomLevel
	mov r1, r0
	mov r0, r4
	bl SeaMapView__SetButtonMode
	mov r0, r4
	mov r1, #0
	bl SeaMapChartCourseView__SetTouchCallback
	mov r0, r4
	mov r1, #0
	bl SeaMapView__Func_203F35C
	ldr r1, _02041AD8 // =SeaMapChartCourseView__State_2041ADC
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02041AD0: .word seaMapViewMode
_02041AD4: .word dword_210FAF0
_02041AD8: .word SeaMapChartCourseView__State_2041ADC
	arm_func_end SeaMapChartCourseView__State_2041A68

	arm_func_start SeaMapChartCourseView__State_2041ADC
SeaMapChartCourseView__State_2041ADC: // 0x02041ADC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapEventManager__GetWork2
	mov r0, r4
	bl SeaMapView__ProcessPadInputs
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02041B48
	ldr r0, _02041C60 // =touchInput
	ldrh r1, [r0, #0x12]
	tst r1, #4
	beq _02041B48
	ldrh r1, [r0, #0x1c]
	ldrh r2, [r0, #0x1e]
	mov r0, r4
	and r1, r1, #0xff
	and r2, r2, #0xff
	bl SeaMapChartCourseView__Func_2041104
	mov r1, r0
	mov r0, r4
	bl SeaMapChartCourseView__SetTouchCallback
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	beq _02041C4C
	mov r0, r4
	bl SeaMapView__Func_203F344
	b _02041C4C
_02041B48:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02041BFC
	ldr r0, _02041C60 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #8
	beq _02041BFC
	mov r0, r4
	bl SeaMapView__Func_203E898
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	bne _02041C4C
	ldr r0, [r4, #0x7a8]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	str r0, [r4, #0x7ac]
	bl SeaMapManager__GetNodeCount
	cmp r0, #1
	bne _02041BA4
	mov r0, r4
	bl SeaMapChartCourseView__Func_2041048
	ldmia sp!, {r4, pc}
_02041BA4:
	bl SeaMapManager__GetNodeCount
	cmp r0, #1
	bls _02041C4C
	bl SeaMapManager__GetTotalDistance
	cmp r0, #0x8000
	bge _02041BC8
	mov r0, r4
	bl SeaMapChartCourseView__Func_2041048
	ldmia sp!, {r4, pc}
_02041BC8:
	ldr r0, [r4, #0x7b4]
	cmp r0, #1
	bne _02041C4C
	mov r0, r4
	mov r1, #3
	bl SeaMapView__IsTouchAreaActive
	cmp r0, #0
	bne _02041C4C
	mov r0, r4
	mov r1, #3
	mov r2, #1
	bl SeaMapView__EnableTouchArea
	b _02041C4C
_02041BFC:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02041C4C
	ldr r0, _02041C60 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	beq _02041C4C
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	bne _02041C4C
	mov r0, r4
	bl SeaMapChartCourseView__Func_2041268
	cmp r0, #0
	beq _02041C4C
	bl CheckNavTailsSpeaking
	cmp r0, #0x29
	beq _02041C4C
	mov r0, #0x29
	mov r1, #0x258
	bl NavTailsSpeak
_02041C4C:
	mov r0, r4
	bl SeaMapView__ProcessButtons
	mov r0, r4
	bl SeaMapChartCourseView__Func_2040DE0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02041C60: .word touchInput
	arm_func_end SeaMapChartCourseView__State_2041ADC

	arm_func_start SeaMapChartCourseView__State_2041C64
SeaMapChartCourseView__State_2041C64: // 0x02041C64
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	mov r4, r0
	mov r2, #0
	ldr r1, _02041CFC // =dword_210FA90
	str r2, [r4, #0x9cc]
	bl SeaMapView__EnableMultipleButtons
	ldr r1, [r4, #4]
	add r0, sp, #0
	mov r2, #3
	bl InitSpriteButtonConfig
	ldr r1, [r4, #0x38]
	add r0, sp, #0
	str r1, [sp, #8]
	ldr r6, [r4, #0x3c]
	mov r5, #1
	mov lr, #2
	mov ip, #3
	mov r3, #0
	mov r2, #4
	mov r1, #0x3540
	str r6, [sp, #0xc]
	strh r5, [sp, #0x10]
	strh lr, [sp, #0x12]
	strh ip, [sp, #0x14]
	strb r3, [sp, #0x1c]
	strb r2, [sp, #0x1d]
	strh r1, [sp, #0x16]
	bl CreateSpriteButton
	mov r0, #0
	bl SeaMapManager__EnableTouchField
	mov r0, #0x2b
	mov r1, #0
	bl NavTailsSpeak
	ldr r0, _02041D00 // =SeaMapChartCourseView__State_2041D04
	str r0, [r4, #0x7c4]
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02041CFC: .word dword_210FA90
_02041D00: .word SeaMapChartCourseView__State_2041D04
	arm_func_end SeaMapChartCourseView__State_2041C64

	arm_func_start SeaMapChartCourseView__State_2041D04
SeaMapChartCourseView__State_2041D04: // 0x02041D04
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl GetSelectedSpriteButton
	cmp r0, #0
	beq _02041D2C
	cmp r0, #1
	beq _02041D70
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02041D2C:
	bl DestroySpriteButton
	mov r0, #0
	sub r1, r0, #1
	mov r2, #2
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
	bl SeaMapManager__UpdateGlobalNodeList
	ldr r0, _02041DC4 // =seaMapViewUnknown1
	mov r2, #1
	ldr r1, _02041DC8 // =SeaMapChartCourseView__State_2041E30
	str r2, [r0]
	add sp, sp, #8
	str r1, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
_02041D70:
	bl DestroySpriteButton
	mov r0, #1
	bl SeaMapManager__EnableTouchField
	mov r0, #0
	sub r1, r0, #1
	mov ip, #2
	str ip, [sp]
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	mov r0, #0x28
	mov r1, #0x258
	bl NavTailsSpeak
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	cmpne r0, #1
	ldreq r0, _02041DCC // =SeaMapChartCourseView__State_2041A68
	streq r0, [r4, #0x7c4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02041DC4: .word seaMapViewUnknown1
_02041DC8: .word SeaMapChartCourseView__State_2041E30
_02041DCC: .word SeaMapChartCourseView__State_2041A68
	arm_func_end SeaMapChartCourseView__State_2041D04

	arm_func_start SeaMapChartCourseView__State_2041DD0
SeaMapChartCourseView__State_2041DD0: // 0x02041DD0
	stmdb sp!, {r4, lr}
	ldr r1, _02041E18 // =dword_210FAB0
	mov r4, r0
	mov r2, #0
	str r2, [r4, #0x9cc]
	bl SeaMapView__EnableMultipleButtons
	ldr r1, _02041E1C // =SeaMapView__TouchAreaCallback2
	mov r0, r4
	bl SeaMapView__SetTouchAreaCallback
	mov r0, r4
	mov r1, #1
	bl SeaMapView__Func_203F35C
	mov r0, #0x2b
	mov r1, #0
	bl NavTailsSpeak
	ldr r0, _02041E20 // =SeaMapChartCourseView__State_2041E24
	str r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02041E18: .word dword_210FAB0
_02041E1C: .word SeaMapView__TouchAreaCallback2
_02041E20: .word SeaMapChartCourseView__State_2041E24
	arm_func_end SeaMapChartCourseView__State_2041DD0

	arm_func_start SeaMapChartCourseView__State_2041E24
SeaMapChartCourseView__State_2041E24: // 0x02041E24
	ldr ip, _02041E2C // =SeaMapChartCourseView__State_2040EEC
	bx ip
	.align 2, 0
_02041E2C: .word SeaMapChartCourseView__State_2040EEC
	arm_func_end SeaMapChartCourseView__State_2041E24

	arm_func_start SeaMapChartCourseView__State_2041E30
SeaMapChartCourseView__State_2041E30: // 0x02041E30
	mov r1, #1
	str r1, [r0, #0x7cc]
	bx lr
	arm_func_end SeaMapChartCourseView__State_2041E30

	arm_func_start SeaMapChartCourseView__Func_2041E3C
SeaMapChartCourseView__Func_2041E3C: // 0x02041E3C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r1
	mov r4, r2
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl SeaMapEventManager__GetObjectType
	cmp r0, #2
	cmpne r0, #3
	ldmneia sp!, {r3, r4, r5, pc}
	ldrb r0, [r4, #7]
	tst r0, #1
	ldreqsh r0, [r4, #0x10]
	cmpeq r0, #3
	moveq r0, #1
	streq r0, [r5, #0xab8]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapChartCourseView__Func_2041E3C

	arm_func_start SeaMapChartCourseView__Func_2041E80
SeaMapChartCourseView__Func_2041E80: // 0x02041E80
	stmdb sp!, {r4, r5, r6, lr}
	add r6, r0, #0x1d4
	add r0, r6, #0x900
	ldrh r3, [r0, #0]
	mov r5, r1
	mov r4, r2
	add r1, r3, #1
	strh r1, [r0]
	cmp r3, #0x258
	blo _02041F18
	bl CheckNavTailsSpeaking
	cmp r4, #0
	mov r2, #0
	bls _02041EEC
_02041EB8:
	mov r1, r2, lsl #1
	ldrh r1, [r5, r1]
	cmp r0, r1
	bne _02041ED8
	add r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	b _02041EEC
_02041ED8:
	add r1, r2, #1
	mov r1, r1, lsl #0x10
	cmp r4, r1, lsr #16
	mov r2, r1, lsr #0x10
	bhi _02041EB8
_02041EEC:
	cmp r4, r2
	movls r2, #0
	mov r0, r2, lsl #1
	ldrh r0, [r5, r0]
	mov r1, #0
	bl NavTailsSpeak
	add r0, r6, #0x900
	mov r1, #0
	strh r1, [r0]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_02041F18:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SeaMapChartCourseView__Func_2041E80

	arm_func_start SeaMapChartCourseView__Func_2041F20
SeaMapChartCourseView__Func_2041F20: // 0x02041F20
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r3, _02041F88 // =byte_210FA78
	mov r2, #0xb
	mla r5, r1, r2, r3
	mov r7, #0
	ldr r0, [r0, #0xc]
	mov r8, r7
	ldr r6, [r0, #0]
	mov r4, r7
_02041F44:
	mov r9, r4
_02041F48:
	ldrb r1, [r5, r8]
	mov r0, r6
	add r1, r9, r1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize1FromAnim
	cmp r7, r0
	add r9, r9, #1
	movlo r7, r0
	cmp r9, #2
	blt _02041F48
	add r8, r8, #1
	cmp r8, #8
	blt _02041F44
	mov r0, r7
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02041F88: .word byte_210FA78
	arm_func_end SeaMapChartCourseView__Func_2041F20

	arm_func_start SeaMapChartCourseView__Func_2041F8C
SeaMapChartCourseView__Func_2041F8C: // 0x02041F8C
	stmdb sp!, {r3, lr}
	ldr r3, [r0, #0]
	add r0, r2, #0x1d4
	cmp r3, #0x1000000
	add r2, r0, #0x800
	ldr r0, [r1, #0x14]
	bhi _02041FD0
	cmp r3, #0x1000000
	bhs _02042004
	cmp r3, #0x40000
	bhi _02041FC4
	moveq r0, #1
	streq r0, [r2, #0xd0]
	ldmia sp!, {r3, pc}
_02041FC4:
	cmp r3, #0x400000
	beq _02041FEC
	ldmia sp!, {r3, pc}
_02041FD0:
	cmp r3, #0x2000000
	bhi _02041FE0
	beq _02041FEC
	ldmia sp!, {r3, pc}
_02041FE0:
	cmp r3, #0x8000000
	beq _02042004
	ldmia sp!, {r3, pc}
_02041FEC:
	tst r0, #0x800
	ldmneia sp!, {r3, pc}
	add r0, r2, #0x28
	mov r1, #1
	bl SetSpriteButtonState
	ldmia sp!, {r3, pc}
_02042004:
	tst r0, #0x800
	ldmneia sp!, {r3, pc}
	add r0, r2, #0x28
	mov r1, #0
	bl SetSpriteButtonState
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapChartCourseView__Func_2041F8C

	arm_func_start SeaMapChartCourseView__Func_204201C
SeaMapChartCourseView__Func_204201C: // 0x0204201C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x24
	mov r9, r0
	add r0, r9, #0x1d4
	add r5, r0, #0x800
	ldr r2, _02042168 // =byte_210FA78
	mov r8, r1
	mov r0, #0xb
	mla r4, r8, r0, r2
	add r6, r5, #0x28
	ldr r7, [r9, #4]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02042080
_0204205C: // jump table
	b _02042074 // case 0
	b _02042074 // case 1
	b _02042074 // case 2
	b _02042074 // case 3
	b _02042074 // case 4
	b _02042074 // case 5
_02042074:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _02042084
_02042080:
	mov r0, #1
_02042084:
	ldrb r0, [r4, r0]
	mov r2, #0
	strh r0, [r6, #0xa2]
_02042090:
	add r0, r4, r2
	ldrb r1, [r0, #8]
	add r0, r6, r2, lsl #1
	add r2, r2, #1
	strh r1, [r0, #0x9c]
	cmp r2, #3
	blt _02042090
	mov r0, r9
	mov r1, r8
	bl SeaMapChartCourseView__Func_2041F20
	mov r1, r0
	mov r0, r7
	bl VRAMSystem__AllocSpriteVram
	ldr r1, _0204216C // =VRAMSystem__VRAM_PALETTE_OBJ
	str r7, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r1, [r1, r7, lsl #2]
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	ldr r0, [r9, #0xc]
	ldrh r2, [r6, #0xa2]
	ldr r1, [r0, #0]
	mov r0, r6
	mov r3, #4
	bl AnimatorSprite__Init
	ldrh r2, [r6, #0x9c]
	mov r1, #0x80
	mov r0, r6
	strh r2, [r6, #0x50]
	strh r1, [r6, #8]
	strh r1, [r6, #0xa]
	mov r1, #0
	add r2, sp, #0x1c
	bl AnimatorSprite__GetBlockData
	ldr r1, _02042170 // =SeaMapChartCourseView__Func_2041F8C
	ldr r2, _02042174 // =TouchField__PointInRect
	stmia sp, {r1, r9}
	add r0, r6, #0x64
	add r1, r6, #8
	add r3, sp, #0x1c
	bl TouchField__InitAreaShape
	mov r0, r5
	add r1, r6, #0x64
	mov r2, #0x10
	bl TouchField__AddArea
	mov r0, r6
	mov r1, #0
	bl SetSpriteButtonState
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02042168: .word byte_210FA78
_0204216C: .word VRAMSystem__VRAM_PALETTE_OBJ
_02042170: .word SeaMapChartCourseView__Func_2041F8C
_02042174: .word TouchField__PointInRect
	arm_func_end SeaMapChartCourseView__Func_204201C

	arm_func_start SeaMapChartCourseView__Func_2042178
SeaMapChartCourseView__Func_2042178: // 0x02042178
	stmdb sp!, {r4, lr}
	add r0, r0, #0x1d4
	add r4, r0, #0x800
	add r0, r4, #0x28
	bl AnimatorSprite__Release
	mov r0, r4
	add r1, r4, #0x8c
	bl TouchField__RemoveArea
	add r1, r4, #0x28
	mov r0, #0
	mov r2, #0xa4
	bl MIi_CpuClear16
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapChartCourseView__Func_2042178

	arm_func_start SeaMapChartCourseView__Func_20421AC
SeaMapChartCourseView__Func_20421AC: // 0x020421AC
	stmdb sp!, {r3, r4, r5, lr}
	add r4, r0, #0x1d4
	ldr r0, [r4, #0x8d8]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #0
	bl SeaMapEventManager__GetObjectFromID
	mov r5, r0
	mov r0, #1
	bl SeaMapEventManager__GetObjectFromID
	mov r1, #0x16
	str r1, [sp]
	ldrsh r1, [r5, #4]
	ldrsh r2, [r0, #2]
	ldrsh r3, [r0, #4]
	ldrsh ip, [r5, #2]
	mov r1, r1, lsl #0xc
	mov r2, r2, lsl #0xc
	mov r0, ip, lsl #0xc
	mov r3, r3, lsl #0xc
	bl SeaMapEventManager__CreateStylusIcon
	str r0, [r4, #0x8d8]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapChartCourseView__Func_20421AC

	arm_func_start SeaMapChartCourseView__Func_2042208
SeaMapChartCourseView__Func_2042208: // 0x02042208
	stmdb sp!, {r4, lr}
	add r4, r0, #0x1d4
	ldr r0, [r4, #0x8d8]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl SeaMapEventManager__DestroyStylusIcon
	mov r0, #0
	str r0, [r4, #0x8d8]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapChartCourseView__Func_2042208

	arm_func_start SeaMapChartCourseView__StartNavTailsTalk
SeaMapChartCourseView__StartNavTailsTalk: // 0x0204222C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x1d4
	add ip, r0, #0x800
	str r1, [ip, #0x18]
	strh r2, [ip, #0x1c]
	str r3, [ip, #0x20]
	mov r1, #0
	ldr r0, [sp, #8]
	strh r1, [ip, #0x1e]
	str r0, [ip, #0x24]
	ldr r0, [r4, #0x7a8]
	bl NNS_SndPlayerStopSeq
	mov r1, #0
	ldr r0, _02042274 // =SeaMapChartCourseView__State_2042278
	str r1, [r4, #0x7ac]
	str r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02042274: .word SeaMapChartCourseView__State_2042278
	arm_func_end SeaMapChartCourseView__StartNavTailsTalk

	arm_func_start SeaMapChartCourseView__State_2042278
SeaMapChartCourseView__State_2042278: // 0x02042278
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x1d4
	bl SeaMapView__Func_203F344
	mov r0, r5
	bl SeaMapView__ProcessPadInputs
	ldr r0, [r4, #0x824]
	cmp r0, #0
	ldreq r0, _020422CC // =SeaMapChartCourseView__State_204231C
	streq r0, [r5, #0x7c4]
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl CreateSeaMapPenPalette
	mov r1, #1
	str r0, [r4, #0x8e0]
	bl SetSeaMapPenPaletteMode
	mov r1, #1
	ldr r0, _020422D0 // =SeaMapChartCourseView__State_20422D4
	str r1, [r5, #0x9d0]
	str r0, [r5, #0x7c4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_020422CC: .word SeaMapChartCourseView__State_204231C
_020422D0: .word SeaMapChartCourseView__State_20422D4
	arm_func_end SeaMapChartCourseView__State_2042278

	arm_func_start SeaMapChartCourseView__State_20422D4
SeaMapChartCourseView__State_20422D4: // 0x020422D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xab4]
	bl GetSeaMapPenPaletteMode
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02042308
	ldr r0, _02042314 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	ldmneia sp!, {r4, pc}
_02042308:
	ldr r0, _02042318 // =SeaMapChartCourseView__State_204231C
	str r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02042314: .word touchInput
_02042318: .word SeaMapChartCourseView__State_204231C
	arm_func_end SeaMapChartCourseView__State_20422D4

	arm_func_start SeaMapChartCourseView__State_204231C
SeaMapChartCourseView__State_204231C: // 0x0204231C
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	add r0, r4, #0x1d4
	add r5, r0, #0x800
	ldrh r2, [r5, #0x1e]
	ldr r3, [r5, #0x18]
	mov r1, #0
	mov r0, r2, lsl #3
	ldrh r0, [r3, r0]
	add r6, r3, r2, lsl #3
	bl NavTailsSpeak
	ldr r1, [r6, #4]
	cmp r1, #2
	movge r0, #0
	strgeh r0, [r5, #0xd4]
	bge _02042370
	mov r0, r4
	bl SeaMapChartCourseView__Func_204201C
	mov r0, #0
	str r0, [r5, #0xd0]
	str r0, [r5, #0xcc]
_02042370:
	ldr r1, _02042384 // =SeaMapChartCourseView__State_2042388
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02042384: .word SeaMapChartCourseView__State_2042388
	arm_func_end SeaMapChartCourseView__State_204231C

	arm_func_start SeaMapChartCourseView__State_2042388
SeaMapChartCourseView__State_2042388: // 0x02042388
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	add r0, r6, #0x1d4
	add r4, r0, #0x800
	ldrh r0, [r4, #0x1e]
	ldr r1, [r4, #0x18]
	add r5, r1, r0, lsl #3
	bl CheckNavTailsLastDialog
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r5, #4]
	mov r5, #0
	cmp r0, #2
	bge _0204244C
	ldr r0, [r4, #0xcc]
	cmp r0, #0
	bne _02042400
	mov ip, #4
	sub r1, ip, #5
	mov r0, #2
	str r0, [sp]
	mov r0, r5
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	mov r0, #1
	str r0, [r4, #0xcc]
_02042400:
	mov r0, r4
	bl TouchField__Process
	ldr r0, [r4, #0xd0]
	cmp r0, #0
	beq _02042460
	mov r0, #0
	sub r1, r0, #1
	mov r2, #2
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
	mov r0, r6
	bl SeaMapChartCourseView__Func_2042178
	mov r0, #0
	str r0, [r4, #0xcc]
	mov r5, #1
	b _02042460
_0204244C:
	ldrh r1, [r4, #0xd4]
	add r0, r1, #1
	cmp r1, #0x12c
	strh r0, [r4, #0xd4]
	movhi r5, #1
_02042460:
	cmp r5, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r0, [r4, #0x1e]
	add r0, r0, #1
	strh r0, [r4, #0x1e]
	ldrh r1, [r4, #0x1e]
	ldrh r0, [r4, #0x1c]
	cmp r1, r0
	ldrlo r0, _020424D4 // =SeaMapChartCourseView__State_204231C
	addlo sp, sp, #8
	strlo r0, [r6, #0x7c4]
	ldmloia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #0x24]
	cmp r0, #0
	beq _020424BC
	ldr r0, [r4, #0xe0]
	mov r1, #2
	bl SetSeaMapPenPaletteMode
	ldr r0, _020424D8 // =SeaMapChartCourseView__State_20424DC
	add sp, sp, #8
	str r0, [r6, #0x7c4]
	ldmia sp!, {r4, r5, r6, pc}
_020424BC:
	ldr r1, [r4, #0x20]
	mov r0, r6
	str r1, [r6, #0x7c4]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020424D4: .word SeaMapChartCourseView__State_204231C
_020424D8: .word SeaMapChartCourseView__State_20424DC
	arm_func_end SeaMapChartCourseView__State_2042388

	arm_func_start SeaMapChartCourseView__State_20424DC
SeaMapChartCourseView__State_20424DC: // 0x020424DC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x1d4
	ldr r0, [r4, #0x8e0]
	bl GetSeaMapPenPaletteMode
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #0
	str r0, [r5, #0x9d0]
	ldr r0, [r4, #0x8e0]
	bl DestroySeaMapPenPalette
	mov r0, #0
	str r0, [r4, #0x8e0]
	ldr r1, [r4, #0x820]
	mov r0, r5
	str r1, [r5, #0x7c4]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapChartCourseView__State_20424DC

	arm_func_start SeaMapChartCourseView__State_2042524
SeaMapChartCourseView__State_2042524: // 0x02042524
	stmdb sp!, {r4, lr}
	ldr r1, _02042584 // =dword_210FAD0
	mov r4, r0
	bl SeaMapView__EnableMultipleButtons
	bl SeaMapManager__GetZoomLevel
	mov r1, r0
	mov r0, r4
	bl SeaMapView__SetButtonMode
	mov r0, #0
	bl SeaMapManager__EnableTouchField
	mov r0, #0
	bl SeaMapEventManager__GetObjectFromID
	ldrsh r1, [r0, #4]
	ldrsh r2, [r0, #2]
	mov r1, r1, lsl #0xc
	mov r0, r2, lsl #0xc
	bl SeaMapView__SetViewPosition
	mov r0, r4
	bl SeaMapView__ProcessPadInputs
	ldr r1, _02042588 // =SeaMapChartCourseView__State_204258C
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02042584: .word dword_210FAD0
_02042588: .word SeaMapChartCourseView__State_204258C
	arm_func_end SeaMapChartCourseView__State_2042524

	arm_func_start SeaMapChartCourseView__State_204258C
SeaMapChartCourseView__State_204258C: // 0x0204258C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapView__FadeToBlack
	cmp r0, #0
	ldrne r0, _020425A8 // =SeaMapChartCourseView__State_20425AC
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020425A8: .word SeaMapChartCourseView__State_20425AC
	arm_func_end SeaMapChartCourseView__State_204258C

	arm_func_start SeaMapChartCourseView__State_20425AC
SeaMapChartCourseView__State_20425AC: // 0x020425AC
	stmdb sp!, {r3, lr}
	ldr r2, _020425CC // =SeaMapChartCourseView__State_20425D0
	add r1, r0, #0xa00
	mov r3, #0
	strh r3, [r1, #0xd8]
	str r2, [r0, #0x7c4]
	blx r2
	ldmia sp!, {r3, pc}
	.align 2, 0
_020425CC: .word SeaMapChartCourseView__State_20425D0
	arm_func_end SeaMapChartCourseView__State_20425AC

	arm_func_start SeaMapChartCourseView__State_20425D0
SeaMapChartCourseView__State_20425D0: // 0x020425D0
	add r1, r0, #0x1d4
	add r1, r1, #0x900
	ldrh r3, [r1, #4]
	add r2, r3, #1
	strh r2, [r1, #4]
	cmp r3, #0x3c
	ldrhi r1, _020425F4 // =SeaMapChartCourseView__State_20425F8
	strhi r1, [r0, #0x7c4]
	bx lr
	.align 2, 0
_020425F4: .word SeaMapChartCourseView__State_20425F8
	arm_func_end SeaMapChartCourseView__State_20425D0

	arm_func_start SeaMapChartCourseView__State_20425F8
SeaMapChartCourseView__State_20425F8: // 0x020425F8
	stmdb sp!, {r3, lr}
	ldr r1, _02042614 // =stru_210FA1C
	mov r2, #1
	ldr r3, _02042618 // =SeaMapChartCourseView__State_204261C
	str r2, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	ldmia sp!, {r3, pc}
	.align 2, 0
_02042614: .word stru_210FA1C
_02042618: .word SeaMapChartCourseView__State_204261C
	arm_func_end SeaMapChartCourseView__State_20425F8

	arm_func_start SeaMapChartCourseView__State_204261C
SeaMapChartCourseView__State_204261C: // 0x0204261C
	stmdb sp!, {r3, lr}
	ldr r2, _0204263C // =SeaMapChartCourseView__State_2042640
	add r1, r0, #0xa00
	mov r3, #0
	strh r3, [r1, #0xd8]
	str r2, [r0, #0x7c4]
	blx r2
	ldmia sp!, {r3, pc}
	.align 2, 0
_0204263C: .word SeaMapChartCourseView__State_2042640
	arm_func_end SeaMapChartCourseView__State_204261C

	arm_func_start SeaMapChartCourseView__State_2042640
SeaMapChartCourseView__State_2042640: // 0x02042640
	add r1, r0, #0x1d4
	add r1, r1, #0x900
	ldrh r3, [r1, #4]
	add r2, r3, #1
	strh r2, [r1, #4]
	cmp r3, #0x1e
	ldrhi r1, _02042664 // =SeaMapChartCourseView__State_2042668
	strhi r1, [r0, #0x7c4]
	bx lr
	.align 2, 0
_02042664: .word SeaMapChartCourseView__State_2042668
	arm_func_end SeaMapChartCourseView__State_2042640

	arm_func_start SeaMapChartCourseView__State_2042668
SeaMapChartCourseView__State_2042668: // 0x02042668
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl SeaMapView__InitZoomControl
	mov r0, #0
	sub r1, r0, #1
	mov ip, #2
	str ip, [sp]
	mov ip, #0xe
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	ldr r1, _020426C0 // =SeaMapChartCourseView__State_TryZoomIn
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_020426C0: .word SeaMapChartCourseView__State_TryZoomIn
	arm_func_end SeaMapChartCourseView__State_2042668

	arm_func_start SeaMapChartCourseView__State_TryZoomIn
SeaMapChartCourseView__State_TryZoomIn: // 0x020426C4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView__CanZoomIn
	cmp r0, #0
	ldrne r0, _020426E8 // =SeaMapChartCourseView__State_20426EC
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020426E8: .word SeaMapChartCourseView__State_20426EC
	arm_func_end SeaMapChartCourseView__State_TryZoomIn

	arm_func_start SeaMapChartCourseView__State_20426EC
SeaMapChartCourseView__State_20426EC: // 0x020426EC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetZoomLevel
	cmp r0, #1
	beq _02042718
	cmp r0, #2
	bne _02042724
	mov r0, r4
	mov r1, #1
	bl SeaMapView__SetZoomLevel
	b _02042724
_02042718:
	mov r0, r4
	mov r1, #0
	bl SeaMapView__SetZoomLevel
_02042724:
	mov r0, #0
	bl SeaMapEventManager__GetObjectFromID
	ldrsh r1, [r0, #4]
	ldrsh r2, [r0, #2]
	mov r1, r1, lsl #0xc
	mov r0, r2, lsl #0xc
	bl SeaMapView__SetViewPosition
	mov r0, r4
	bl SeaMapView__ProcessPadInputs
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl SeaMapView__InitZoomControl
	ldr r1, _0204276C // =SeaMapChartCourseView__State_ZoomIn
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_0204276C: .word SeaMapChartCourseView__State_ZoomIn
	arm_func_end SeaMapChartCourseView__State_20426EC

	arm_func_start SeaMapChartCourseView__State_ZoomIn
SeaMapChartCourseView__State_ZoomIn: // 0x02042770
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView__HandleZoomIn
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl SeaMapManager__GetZoomLevel
	cmp r0, #0
	ldrne r0, _020427A8 // =SeaMapChartCourseView__State_204261C
	strne r0, [r4, #0x7c4]
	ldreq r0, _020427AC // =SeaMapChartCourseView__State_20427B0
	streq r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020427A8: .word SeaMapChartCourseView__State_204261C
_020427AC: .word SeaMapChartCourseView__State_20427B0
	arm_func_end SeaMapChartCourseView__State_ZoomIn

	arm_func_start SeaMapChartCourseView__State_20427B0
SeaMapChartCourseView__State_20427B0: // 0x020427B0
	stmdb sp!, {r3, lr}
	ldr r1, _020427D0 // =stru_210FA58
	mov ip, #1
	ldr r3, _020427D4 // =SeaMapChartCourseView__State_20427D8
	mov r2, #2
	str ip, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	ldmia sp!, {r3, pc}
	.align 2, 0
_020427D0: .word stru_210FA58
_020427D4: .word SeaMapChartCourseView__State_20427D8
	arm_func_end SeaMapChartCourseView__State_20427B0

	arm_func_start SeaMapChartCourseView__State_20427D8
SeaMapChartCourseView__State_20427D8: // 0x020427D8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetWork
	add r1, r4, #0x1d4
	add r2, r1, #0x900
	mov r3, #0
	strh r3, [r2]
	str r3, [r1, #0x8fc]
	ldr r2, [r0, #4]
	str r2, [r1, #0x8f0]
	ldr r2, [r0, #8]
	mov r0, #1
	str r2, [r1, #0x8f4]
	bl SeaMapManager__EnableTouchField
	bl SeaMapEventManager__CreateDSPopup
	mov r0, r4
	bl SeaMapView__Func_203E898
	mov r1, #1
	mov r0, r4
	str r1, [r4, #0x9cc]
	bl SeaMapView__Func_203F35C
	ldr r1, _02042840 // =SeaMapChartCourseView__State_2042844
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02042840: .word SeaMapChartCourseView__State_2042844
	arm_func_end SeaMapChartCourseView__State_20427D8

	arm_func_start SeaMapChartCourseView__State_2042844
SeaMapChartCourseView__State_2042844: // 0x02042844
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	bl SeaMapManager__GetWork
	mov r4, r0
	mov r0, r5
	bl SeaMapView__ProcessPadInputs
	mov r0, r5
	bl SeaMapView__ProcessButtons
	mov r0, r5
	bl SeaMapChartCourseView__Func_2040DE0
	mov r0, r5
	ldr r1, _0204292C // =word_210FA16
	mov r2, #3
	bl SeaMapChartCourseView__Func_2041E80
	bl SeaMapManager__GetZoomLevel
	ldr r1, [r5, #0xacc]
	cmp r1, r0
	bne _020428F8
	bl SeaMapManager__GetZoomOutScale
	ldr r1, [r5, #0xac4]
	ldmib r4, {r2, ip}
	ldr r3, [r5, #0xac8]
	sub r2, r2, r1
	sub lr, ip, r3
	smull r1, r3, r2, r2
	adds ip, r1, #0x800
	smull r2, r1, lr, lr
	adc r3, r3, #0
	adds r2, r2, #0x800
	mov ip, ip, lsr #0xc
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr ip, ip, r3, lsl #20
	orr r2, r2, r1, lsl #20
	mov r6, r0
	add r0, ip, r2
	bl FX_Sqrt
	smull r2, r1, r0, r6
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	ldr r2, [r5, #0xad0]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	str r0, [r5, #0xad0]
_020428F8:
	ldr r0, [r4, #4]
	str r0, [r5, #0xac4]
	ldr r0, [r4, #8]
	str r0, [r5, #0xac8]
	bl SeaMapManager__GetZoomLevel
	str r0, [r5, #0xacc]
	ldr r0, [r5, #0xad0]
	cmp r0, #0x258000
	ldmleia sp!, {r4, r5, r6, pc}
	bl SeaMapEventManager__DestroyDSPopup
	ldr r0, _02042930 // =SeaMapChartCourseView__State_2042934
	str r0, [r5, #0x7c4]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0204292C: .word word_210FA16
_02042930: .word SeaMapChartCourseView__State_2042934
	arm_func_end SeaMapChartCourseView__State_2042844

	arm_func_start SeaMapChartCourseView__State_2042934
SeaMapChartCourseView__State_2042934: // 0x02042934
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r1, #0
	mov r4, r0
	bl SeaMapView__Func_203F35C
	mov r0, #0
	bl SeaMapManager__EnableTouchField
	mov r2, #1
	ldr r1, _02042970 // =stru_210FA3C
	ldr r3, _02042974 // =SeaMapChartCourseView__State_2042978
	mov r0, r4
	str r2, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02042970: .word stru_210FA3C
_02042974: .word SeaMapChartCourseView__State_2042978
	arm_func_end SeaMapChartCourseView__State_2042934

	arm_func_start SeaMapChartCourseView__State_2042978
SeaMapChartCourseView__State_2042978: // 0x02042978
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetZoomLevel
	cmp r0, #0
	ldreq r0, _020429A4 // =SeaMapChartCourseView__State_20429AC
	ldrne r0, _020429A8 // =SeaMapChartCourseView__State_2042B04
	str r0, [r4, #0x7c4]
	ldr r1, [r4, #0x7c4]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_020429A4: .word SeaMapChartCourseView__State_20429AC
_020429A8: .word SeaMapChartCourseView__State_2042B04
	arm_func_end SeaMapChartCourseView__State_2042978

	arm_func_start SeaMapChartCourseView__State_20429AC
SeaMapChartCourseView__State_20429AC: // 0x020429AC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetWork
	ldr r2, [r0, #4]
	add r1, r4, #0x1d4
	add r2, r2, #0x80000
	str r2, [r1, #0x8f0]
	ldr r0, [r0, #8]
	ldr r2, _020429F4 // =SeaMapChartCourseView__State_20429F8
	add r0, r0, #0x60000
	str r0, [r1, #0x8f4]
	add r0, r1, #0x900
	mov r1, #0
	strh r1, [r0, #2]
	mov r0, r4
	str r2, [r4, #0x7c4]
	blx r2
	ldmia sp!, {r4, pc}
	.align 2, 0
_020429F4: .word SeaMapChartCourseView__State_20429F8
	arm_func_end SeaMapChartCourseView__State_20429AC

	arm_func_start SeaMapChartCourseView__State_20429F8
SeaMapChartCourseView__State_20429F8: // 0x020429F8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r5, r0
	mov r0, #0
	add r4, r5, #0x1d4
	bl SeaMapEventManager__GetObjectFromID
	mov r6, r0
	mov r0, #1
	bl SeaMapEventManager__GetObjectFromID
	add r3, r4, #0x900
	ldrsh r1, [r3, #2]
	ldrsh r8, [r6, #2]
	ldrsh r7, [r0, #2]
	ldrsh r6, [r6, #4]
	ldrsh r2, [r0, #4]
	add r0, r1, #0x22
	add r1, r8, r7
	strh r0, [r3, #2]
	ldrsh r0, [r3, #2]
	add r2, r6, r2
	mov r1, r1, asr #1
	cmp r0, #0x1000
	mov r2, r2, asr #1
	blt _02042A64
	mov r6, #0x1000
	ldr r0, _02042B00 // =SeaMapChartCourseView__State_2042C04
	strh r6, [r3, #2]
	str r0, [r5, #0x7c4]
_02042A64:
	add r0, r4, #0x900
	ldrsh lr, [r0, #2]
	ldr r0, [r4, #0x8f0]
	mov r3, #2
	mov ip, lr, asr #0x1f
	mov r6, #0
	mov r5, #0x800
_02042A80:
	rsb r7, r0, r1, lsl #12
	umull r9, r8, r7, lr
	mla r8, r7, ip, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, lr, r8
	adds r9, r9, r5
	adc r7, r8, r6
	mov r8, r9, lsr #0xc
	orr r8, r8, r7, lsl #20
	cmp r3, #0
	add r0, r0, r8
	sub r3, r3, #1
	bne _02042A80
	ldr r1, [r4, #0x8f4]
	mov r3, #2
	mov r5, #0
	mov r4, #0x800
_02042AC4:
	rsb r6, r1, r2, lsl #12
	umull r8, r7, r6, lr
	mla r7, r6, ip, r7
	mov r6, r6, asr #0x1f
	mla r7, r6, lr, r7
	adds r8, r8, r4
	adc r6, r7, r5
	mov r7, r8, lsr #0xc
	orr r7, r7, r6, lsl #20
	cmp r3, #0
	add r1, r1, r7
	sub r3, r3, #1
	bne _02042AC4
	bl SeaMapView__SetViewPosition
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02042B00: .word SeaMapChartCourseView__State_2042C04
	arm_func_end SeaMapChartCourseView__State_20429F8

	arm_func_start SeaMapChartCourseView__State_2042B04
SeaMapChartCourseView__State_2042B04: // 0x02042B04
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl SeaMapView__InitZoomControl
	ldr r1, _02042B30 // =SeaMapChartCourseView__State_2042B34
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02042B30: .word SeaMapChartCourseView__State_2042B34
	arm_func_end SeaMapChartCourseView__State_2042B04

	arm_func_start SeaMapChartCourseView__State_2042B34
SeaMapChartCourseView__State_2042B34: // 0x02042B34
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView__CanZoomIn
	cmp r0, #0
	ldrne r0, _02042B58 // =SeaMapChartCourseView__State_2042B5C
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02042B58: .word SeaMapChartCourseView__State_2042B5C
	arm_func_end SeaMapChartCourseView__State_2042B34

	arm_func_start SeaMapChartCourseView__State_2042B5C
SeaMapChartCourseView__State_2042B5C: // 0x02042B5C
	stmdb sp!, {r3, r4, r5, lr}
	mov r1, #0
	mov r4, r0
	bl SeaMapView__SetZoomLevel
	mov r0, #0
	bl SeaMapEventManager__GetObjectFromID
	mov r5, r0
	mov r0, #1
	bl SeaMapEventManager__GetObjectFromID
	ldrsh r2, [r0, #2]
	ldrsh r3, [r5, #2]
	ldrsh r1, [r5, #4]
	ldrsh r0, [r0, #4]
	add r2, r3, r2
	mov r2, r2, asr #1
	add r0, r1, r0
	mov r1, r0, asr #1
	mov r0, r2, lsl #0xc
	mov r1, r1, lsl #0xc
	bl SeaMapView__SetViewPosition
	mov r0, r4
	bl SeaMapView__ProcessPadInputs
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl SeaMapView__InitZoomControl
	ldr r1, _02042BD8 // =SeaMapChartCourseView__State_2042BDC
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02042BD8: .word SeaMapChartCourseView__State_2042BDC
	arm_func_end SeaMapChartCourseView__State_2042B5C

	arm_func_start SeaMapChartCourseView__State_2042BDC
SeaMapChartCourseView__State_2042BDC: // 0x02042BDC
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView__HandleZoomIn
	cmp r0, #0
	ldrne r0, _02042C00 // =SeaMapChartCourseView__State_2042C04
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02042C00: .word SeaMapChartCourseView__State_2042C04
	arm_func_end SeaMapChartCourseView__State_2042BDC

	arm_func_start SeaMapChartCourseView__State_2042C04
SeaMapChartCourseView__State_2042C04: // 0x02042C04
	stmdb sp!, {r3, lr}
	ldr r1, _02042C24 // =stru_210FA68
	mov ip, #1
	ldr r3, _02042C28 // =SeaMapChartCourseView__State_2042C2C
	mov r2, #2
	str ip, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	ldmia sp!, {r3, pc}
	.align 2, 0
_02042C24: .word stru_210FA68
_02042C28: .word SeaMapChartCourseView__State_2042C2C
	arm_func_end SeaMapChartCourseView__State_2042C04

	arm_func_start SeaMapChartCourseView__State_2042C2C
SeaMapChartCourseView__State_2042C2C: // 0x02042C2C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _02042C64 // =SeaMapChartCourseView__Func_2041E3C
	mov r1, r4
	bl SeaMapEventTrigger_AddEventListener
	str r0, [r4, #0xab0]
	mov r0, #1
	bl SeaMapManager__EnableTouchField
	bl SeaMapEventManager__CreateDSPopup
	ldr r1, _02042C68 // =SeaMapChartCourseView__State_2042C6C
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02042C64: .word SeaMapChartCourseView__Func_2041E3C
_02042C68: .word SeaMapChartCourseView__State_2042C6C
	arm_func_end SeaMapChartCourseView__State_2042C2C

	arm_func_start SeaMapChartCourseView__State_2042C6C
SeaMapChartCourseView__State_2042C6C: // 0x02042C6C
	stmdb sp!, {r4, lr}
	ldr r1, _02042CA8 // =seaMapViewMode
	mov r2, #3
	mov r4, r0
	str r2, [r1]
	bl SeaMapView__Func_203E898
	mov r1, #1
	mov r0, r4
	str r1, [r4, #0x9cc]
	bl SeaMapChartCourseView__Func_20421AC
	ldr r1, _02042CAC // =SeaMapChartCourseView__State_2042CB0
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02042CA8: .word seaMapViewMode
_02042CAC: .word SeaMapChartCourseView__State_2042CB0
	arm_func_end SeaMapChartCourseView__State_2042C6C

	arm_func_start SeaMapChartCourseView__State_2042CB0
SeaMapChartCourseView__State_2042CB0: // 0x02042CB0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapView__ProcessPadInputs
	mov r0, r4
	bl SeaMapView__ProcessButtons
	bl SeaMapEventManager__GetWork2
	ldr r1, [r0, #0]
	mvn r0, #0
	cmp r1, r0
	mov r0, r4
	beq _02042CF8
	bl SeaMapChartCourseView__Func_2040D28
	cmp r0, #0
	beq _02042CFC
	ldr r1, [r4, #0x7c4]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
_02042CF8:
	bl SeaMapChartCourseView__Func_2040C7C
_02042CFC:
	ldr r1, _02042D10 // =word_210FA0C
	mov r0, r4
	mov r2, #2
	bl SeaMapChartCourseView__Func_2041E80
	ldmia sp!, {r4, pc}
	.align 2, 0
_02042D10: .word word_210FA0C
	arm_func_end SeaMapChartCourseView__State_2042CB0

	arm_func_start SeaMapChartCourseView__State_2042D14
SeaMapChartCourseView__State_2042D14: // 0x02042D14
	stmdb sp!, {r4, lr}
	ldr r1, _02042D8C // =seaMapViewMode
	mov r2, #4
	mov r4, r0
	str r2, [r1]
	bl SeaMapView__Func_203E898
	mov r2, #1
	ldr r1, _02042D90 // =dword_210FAF0
	mov r0, r4
	str r2, [r4, #0x9cc]
	bl SeaMapView__EnableMultipleButtons
	bl SeaMapManager__GetZoomLevel
	mov r1, r0
	mov r0, r4
	bl SeaMapView__SetButtonMode
	mov r0, r4
	mov r1, #0
	bl SeaMapChartCourseView__SetTouchCallback
	mov r0, r4
	mov r1, #0
	bl SeaMapView__Func_203F35C
	mov r0, #1
	bl SeaMapManager__EnableTouchField
	mov r0, r4
	bl SeaMapChartCourseView__Func_20421AC
	ldr r1, _02042D94 // =SeaMapChartCourseView__State_2042D98
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02042D8C: .word seaMapViewMode
_02042D90: .word dword_210FAF0
_02042D94: .word SeaMapChartCourseView__State_2042D98
	arm_func_end SeaMapChartCourseView__State_2042D14

	arm_func_start SeaMapChartCourseView__State_2042D98
SeaMapChartCourseView__State_2042D98: // 0x02042D98
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	add r5, r4, #0x1d4
	bl SeaMapEventManager__GetWork2
	mov r0, r4
	bl SeaMapView__ProcessPadInputs
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02042E08
	ldr r0, _02042F90 // =touchInput
	ldrh r1, [r0, #0x12]
	tst r1, #4
	beq _02042E08
	ldrh r1, [r0, #0x1c]
	ldrh r2, [r0, #0x1e]
	mov r0, r4
	and r1, r1, #0xff
	and r2, r2, #0xff
	bl SeaMapChartCourseView__Func_2041104
	mov r1, r0
	mov r0, r4
	bl SeaMapChartCourseView__SetTouchCallback
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	beq _02042ED8
	mov r0, r4
	bl SeaMapView__Func_203F344
	b _02042ED8
_02042E08:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02042E88
	ldr r0, _02042F90 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #8
	beq _02042E88
	mov r0, r4
	bl SeaMapView__Func_203E898
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	bne _02042ED8
	ldr r0, [r4, #0x7a8]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	str r0, [r4, #0x7ac]
	bl SeaMapManager__GetNodeCount
	cmp r0, #1
	bne _02042E64
	mov r0, r4
	bl SeaMapChartCourseView__Func_2041048
	ldmia sp!, {r3, r4, r5, pc}
_02042E64:
	bl SeaMapManager__GetNodeCount
	cmp r0, #1
	bls _02042ED8
	bl SeaMapManager__GetTotalDistance
	cmp r0, #0x8000
	bge _02042ED8
	mov r0, r4
	bl SeaMapChartCourseView__Func_2041048
	ldmia sp!, {r3, r4, r5, pc}
_02042E88:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02042ED8
	ldr r0, _02042F90 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	beq _02042ED8
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	bne _02042ED8
	mov r0, r4
	bl SeaMapChartCourseView__Func_2041268
	cmp r0, #0
	beq _02042ED8
	bl CheckNavTailsSpeaking
	cmp r0, #0x29
	beq _02042ED8
	mov r0, #0x29
	mov r1, #0x258
	bl NavTailsSpeak
_02042ED8:
	ldr r0, [r5, #0x8ec]
	cmp r0, #0
	bne _02042F1C
	ldr r0, [r5, #0x8e4]
	cmp r0, #0
	beq _02042F1C
	mov r1, #1
	mov r0, #0
	str r1, [r5, #0x8ec]
	bl SeaMapManager__EnableTouchField
	mov r2, #1
	ldr r1, _02042F94 // =stru_210FA2C
	ldr r3, _02042F98 // =SeaMapChartCourseView__State_2042D14
	mov r0, r4
	str r2, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	ldmia sp!, {r3, r4, r5, pc}
_02042F1C:
	ldr r0, [r5, #0x8e8]
	cmp r0, #0
	bne _02042F6C
	ldr r0, [r4, #0x79c]
	ldr r1, [r4, #0x798]
	bl FX_Div
	ldr r1, _02042F9C // =0x00000199
	cmp r0, r1
	bge _02042F6C
	mov r1, #1
	mov r0, #0
	str r1, [r5, #0x8e8]
	bl SeaMapManager__EnableTouchField
	mov r2, #1
	ldr r1, _02042FA0 // =stru_210FA24
	ldr r3, _02042F98 // =SeaMapChartCourseView__State_2042D14
	mov r0, r4
	str r2, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	ldmia sp!, {r3, r4, r5, pc}
_02042F6C:
	ldr r1, _02042FA4 // =word_210FA10
	mov r0, r4
	mov r2, #3
	bl SeaMapChartCourseView__Func_2041E80
	mov r0, r4
	bl SeaMapView__ProcessButtons
	mov r0, r4
	bl SeaMapChartCourseView__Func_2040DE0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02042F90: .word touchInput
_02042F94: .word stru_210FA2C
_02042F98: .word SeaMapChartCourseView__State_2042D14
_02042F9C: .word 0x00000199
_02042FA0: .word stru_210FA24
_02042FA4: .word word_210FA10
	arm_func_end SeaMapChartCourseView__State_2042D98

	arm_func_start SeaMapChartCourseView__State_2042FA8
SeaMapChartCourseView__State_2042FA8: // 0x02042FA8
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x24
	mov r4, r0
	mov r0, #0
	bl SeaMapManager__EnableTouchField
	ldr r0, [r4, #0xab8]
	cmp r0, #0
	beq _02043050
	mov r2, #0
	ldr r1, _02043070 // =dword_210FA90
	mov r0, r4
	str r2, [r4, #0x9cc]
	bl SeaMapView__EnableMultipleButtons
	ldr r1, [r4, #4]
	add r0, sp, #4
	mov r2, #3
	bl InitSpriteButtonConfig
	ldr r1, [r4, #0x38]
	add r0, sp, #4
	str r1, [sp, #0xc]
	ldr r6, [r4, #0x3c]
	mov r5, #1
	mov lr, #2
	mov ip, #3
	mov r3, #0
	mov r2, #4
	mov r1, #0x3540
	str r6, [sp, #0x10]
	strh r5, [sp, #0x14]
	strh lr, [sp, #0x16]
	strh ip, [sp, #0x18]
	strb r3, [sp, #0x20]
	strb r2, [sp, #0x21]
	strh r1, [sp, #0x1a]
	bl CreateSpriteButton
	mov r0, #0x2b
	mov r1, #0
	bl NavTailsSpeak
	ldr r0, _02043074 // =SeaMapChartCourseView__State_2043080
	add sp, sp, #0x24
	str r0, [r4, #0x7c4]
	ldmia sp!, {r3, r4, r5, r6, pc}
_02043050:
	ldr r1, _02043078 // =stru_210FA34
	mov r2, #1
	ldr r3, _0204307C // =SeaMapChartCourseView__State_2042D14
	mov r0, r4
	str r2, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02043070: .word dword_210FA90
_02043074: .word SeaMapChartCourseView__State_2043080
_02043078: .word stru_210FA34
_0204307C: .word SeaMapChartCourseView__State_2042D14
	arm_func_end SeaMapChartCourseView__State_2042FA8

	arm_func_start SeaMapChartCourseView__State_2043080
SeaMapChartCourseView__State_2043080: // 0x02043080
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl GetSelectedSpriteButton
	cmp r0, #0
	beq _020430A8
	cmp r0, #1
	beq _020430E8
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_020430A8:
	bl DestroySpriteButton
	mov r0, #0
	sub r1, r0, #1
	mov r2, #2
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
	ldr r0, _0204313C // =seaMapViewUnknown1
	mov r2, #1
	ldr r1, _02043140 // =SeaMapChartCourseView__State_2043148
	str r2, [r0]
	add sp, sp, #8
	str r1, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
_020430E8:
	bl DestroySpriteButton
	mov r0, #1
	bl SeaMapManager__EnableTouchField
	mov r0, #0
	sub r1, r0, #1
	mov ip, #2
	str ip, [sp]
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	add r0, r4, #0xa00
	mov r1, #0x258
	strh r1, [r0, #0xd4]
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	cmpne r0, #1
	ldreq r0, _02043144 // =SeaMapChartCourseView__State_2042D14
	streq r0, [r4, #0x7c4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0204313C: .word seaMapViewUnknown1
_02043140: .word SeaMapChartCourseView__State_2043148
_02043144: .word SeaMapChartCourseView__State_2042D14
	arm_func_end SeaMapChartCourseView__State_2043080

	arm_func_start SeaMapChartCourseView__State_2043148
SeaMapChartCourseView__State_2043148: // 0x02043148
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #4]
	ldr r0, _02043178 // =VRAMSystem__GFXControl
	mov r1, #0x3f
	ldr r0, [r0, r2, lsl #2]
	sub r2, r1, #0x40
	add r0, r0, #0x20
	bl RenderCore_SetBlendBrightness
	ldr r0, _0204317C // =SeaMapChartCourseView__State_2043180
	str r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02043178: .word VRAMSystem__GFXControl
_0204317C: .word SeaMapChartCourseView__State_2043180
	arm_func_end SeaMapChartCourseView__State_2043148

	arm_func_start SeaMapChartCourseView__State_2043180
SeaMapChartCourseView__State_2043180: // 0x02043180
	ldr r2, [r0, #4]
	ldr r1, _020431A8 // =VRAMSystem__GFXControl
	ldr r2, [r1, r2, lsl #2]
	ldrh r1, [r2, #0x24]
	cmp r1, #4
	addlo r0, r1, #1
	ldrhs r1, _020431AC // =SeaMapChartCourseView__State_20431B0
	strloh r0, [r2, #0x24]
	strhs r1, [r0, #0x7c4]
	bx lr
	.align 2, 0
_020431A8: .word VRAMSystem__GFXControl
_020431AC: .word SeaMapChartCourseView__State_20431B0
	arm_func_end SeaMapChartCourseView__State_2043180

	arm_func_start SeaMapChartCourseView__State_20431B0
SeaMapChartCourseView__State_20431B0: // 0x020431B0
	stmdb sp!, {r3, lr}
	ldr r1, _020431CC // =stru_210FA44
	mov r2, #1
	ldr r3, _020431D0 // =SeaMapChartCourseView__State_20431D4
	str r2, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	ldmia sp!, {r3, pc}
	.align 2, 0
_020431CC: .word stru_210FA44
_020431D0: .word SeaMapChartCourseView__State_20431D4
	arm_func_end SeaMapChartCourseView__State_20431B0

	arm_func_start SeaMapChartCourseView__State_20431D4
SeaMapChartCourseView__State_20431D4: // 0x020431D4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r11, r0
	bl SeaMapView__FadeActiveScreen
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SeaMapManager__GetTotalDistance
	mov r9, r0
	cmp r9, #0
	mov r10, #0
	ble _0204325C
	add r8, sp, #8
	add r7, sp, #4
	add r6, sp, #2
	add r5, sp, #0
	mov r4, #3
_02043218:
	mov r0, r10
	mov r1, r8
	mov r2, r7
	bl SeaMapManager__Func_2045BF8
	ldr r0, [sp, #8]
	ldr r1, [sp, #4]
	mov r2, r6
	mov r3, r5
	bl SeaMapManager__Func_2043A80
	ldrh r0, [sp, #2]
	ldrh r1, [sp]
	mov r2, r4
	mov r3, r4
	bl SeaMapManager__Func_20442C8
	add r10, r10, #0x10000
	cmp r10, r9
	blt _02043218
_0204325C:
	add r1, sp, #8
	add r2, sp, #4
	mov r0, r9
	bl SeaMapManager__Func_2045BF8
	ldr r0, [sp, #8]
	ldr r1, [sp, #4]
	add r2, sp, #2
	add r3, sp, #0
	bl SeaMapManager__Func_2043A80
	mov r2, #3
	ldrh r0, [sp, #2]
	ldrh r1, [sp]
	mov r3, r2
	bl SeaMapManager__Func_20442C8
	ldr r1, [r11, #4]
	ldr r0, _020432B8 // =VRAMSystem__GFXControl
	ldr r0, [r0, r1, lsl #2]
	add r0, r0, #0x20
	bl RenderCore_DisableBlending
	mov r0, #1
	str r0, [r11, #0x7cc]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020432B8: .word VRAMSystem__GFXControl
	arm_func_end SeaMapChartCourseView__State_20431D4

	.rodata
	
.public word_210FA0C
word_210FA0C: // 0x0210FA0C
	.hword 51, 52

.public word_210FA10
word_210FA10: // 0x0210FA10
	.hword 54, 51, 55

.public word_210FA16
word_210FA16: // 0x0210FA16
	.hword 49, 46, 47

.public stru_210FA1C
stru_210FA1C: // 0x0210FA1C
	.hword 0x2E // navTailsSequence
	.align 4
	.word 1                   // dword4

.public stru_210FA24
stru_210FA24: // 0x0210FA24
	.hword 0x37 // navTailsSequence
	.align 4
	.word 1                   // dword4

.public stru_210FA2C
stru_210FA2C: // 0x0210FA2C
	.hword 0x39 // navTailsSequence
	.align 4
	.word 1                   // dword4

.public stru_210FA34
stru_210FA34: // 0x0210FA34
	.hword 0x38 // navTailsSequence
	.align 4
	.word 1                   // dword4

.public stru_210FA3C
stru_210FA3C: // 0x0210FA3C
	.hword 0x32 // navTailsSequence
	.align 4
	.word 1                   // dword4

.public stru_210FA44
stru_210FA44: // 0x0210FA44
	.hword 0x3A // navTailsSequence
	.align 4
	.word 2                   // dword4

.public byte_210FA4C
byte_210FA4C: // 0x0210FA4C
	.byte 0x19

.public byte_210FA4D
byte_210FA4D: // 0x0210FA4D
	.byte 3  
	.byte 0x1A
	.byte    3
	.byte 0x1B
	.byte    3
	.byte 0x1C
	.byte    2
	.byte 0x1C
	.byte    2
	.byte    0
	.byte    0

.public stru_210FA58
stru_210FA58: // 0x0210FA58
	.hword 0x2F // navTailsSequence
	.align 4
	.word 0 // dword4
	.hword 0x30 // navTailsSequence
	.align 4
	.word 1 // dword4

.public stru_210FA68
stru_210FA68: // 0x0210FA68
	.hword 0x33 // navTailsSequence
	.align 4
	.word 0 // dword4
	.hword 0x34 // navTailsSequence
	.align 4
	.word 1 // dword4

.public byte_210FA78
byte_210FA78: // 0x0210FA78
	.byte 0x67, 0x6B, 0x6F, 0x73, 0x77, 0x7B, 0, 0, 0xF, 0xF, 0xF
	.byte 0x65, 0x69, 0x6D, 0x71, 0x75, 0x79, 0, 0, 0xF, 0xF, 0xF
	.align 4

.public dword_210FA90
dword_210FA90: // 0x0210FA90
	.word 0, 0, 0, 0, 0, 0, 0, 0

.public dword_210FAB0
dword_210FAB0: // 0x0210FAB0
	.word 0, 0, 0, 0, 0, 0, 1, 1

.public dword_210FAD0
dword_210FAD0: // 0x0210FAD0
	.word 1, 1, 1, 0, 0, 0, 0, 0

.public dword_210FAF0
dword_210FAF0: // 0x0210FAF0
	.word 0, 1, 1, 1, 1, 0, 0, 0, 0x2400600, 0x1200300, 0xC00200