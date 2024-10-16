	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__GFXControl
.public VRAMSystem__VRAM_PALETTE_OBJ
.public VRAMSystem__VRAM_PALETTE_BG

	.text

	arm_func_start SeaMapMenu__Create
SeaMapMenu__Create: // 0x0203FECC
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r5, _0203FFEC // =VRAMSystem__GFXControl
	mov r4, r0
	ldr r3, _0203FFF0 // =SeaMapView__sVars+0x00000004
	mov ip, #1
	ldr r1, _0203FFF4 // =SeaMapView__sVars+0x00000008
	mov r2, #0
	str r2, [r1]
	ldr r6, [r5, r4, lsl #2]
	str ip, [r3]
	ldrsh r5, [r6, #0x58]
	mov r1, #4
	bl SeaMapManager__Create
	strh r5, [r6, #0x58]
	bl SeaMapManager__Func_2043D08
	bl ReleaseAudioSystem
	ldr r0, _0203FFF8 // =aSndSysSoundDat
	bl LoadAudioSndArc
	ldr r1, _0203FFFC // =audioManagerSndHeap
	mov r0, #6
	ldr r1, [r1, #0]
	bl NNS_SndArcLoadGroup
	mov r0, #0xff
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r0, #0x7d0
	str r0, [sp, #8]
	ldr r0, _02040000 // =SeaMapMenu_Main
	ldr r1, _02040004 // =SeaMapMenu_Destructor
	mov r3, r2
	bl TaskCreate_
	ldr r1, _02040008 // =SeaMapView__sVars
	str r0, [r1]
	bl GetTaskWork_
	mov r5, r0
	mov r0, #0
	mov r1, r5
	mov r2, #0x7d0
	bl MIi_CpuClear16
	mov r1, r4
	mov r0, r5
	mov r2, #4
	mov r3, #1
	bl SeaMapView__InitView
	ldr r1, _0204000C // =SeaMapMenu__State_20405D4
	ldr r0, _02040010 // =gameState
	str r1, [r5, #0x7c0]
	ldr r0, [r0, #0x80]
	bl SeaMapEventManager__GetObjectFromID
	ldrsh r1, [r0, #4]
	ldrsh r2, [r0, #2]
	mov r1, r1, lsl #0xc
	mov r0, r2, lsl #0xc
	bl SeaMapView__Func_203DCE0
	ldr r1, _02040014 // =0x0210F87C
	mov r0, r5
	bl SeaMapView__EnableMultipleButtons
	mov r0, r5
	mov r1, #0
	bl SeaMapView__SetZoomLevel
	bl SeaMapEventManager__Create
	mov r0, #7
	str r0, [sp]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlayTrack
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0203FFEC: .word VRAMSystem__GFXControl
_0203FFF0: .word SeaMapView__sVars+0x00000004
_0203FFF4: .word SeaMapView__sVars+0x00000008
_0203FFF8: .word aSndSysSoundDat
_0203FFFC: .word audioManagerSndHeap
_02040000: .word SeaMapMenu_Main
_02040004: .word SeaMapMenu_Destructor
_02040008: .word SeaMapView__sVars
_0204000C: .word SeaMapMenu__State_20405D4
_02040010: .word gameState
_02040014: .word 0x0210F87C
	arm_func_end SeaMapMenu__Create

	arm_func_start SeaMapMenu__GetIslandInfoText
SeaMapMenu__GetIslandInfoText: // 0x02040018
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r4, #7
	beq _02040034
	cmp r4, #0xe
	beq _02040048
	b _0204005C
_02040034:
	bl SaveGame__GetGameProgress
	cmp r0, #0x20
	movge r0, #0x10
	movlt r0, #0x11
	ldmia sp!, {r4, pc}
_02040048:
	bl SaveGame__GetGameProgress
	cmp r0, #0x12
	movge r0, #0x18
	movlt r0, #0x19
	ldmia sp!, {r4, pc}
_0204005C:
	ldr r0, _02040094 // =0x0210F964
	mov r1, #1
	ldr r0, [r0, r4, lsl #2]
	mov r2, #0
	bl MenuHelpers__CheckProgress
	cmp r0, #0
	ldreq r0, _02040098 // =0x0210F910
	moveq r1, r4, lsl #1
	ldreqh r0, [r0, r1]
	ldmeqia sp!, {r4, pc}
	ldr r0, _0204009C // =0x0210F8BC
	mov r1, r4, lsl #1
	ldrh r0, [r0, r1]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02040094: .word 0x0210F964
_02040098: .word 0x0210F910
_0204009C: .word 0x0210F8BC
	arm_func_end SeaMapMenu__GetIslandInfoText

	arm_func_start SeaMapMenu__Func_20400A0
SeaMapMenu__Func_20400A0: // 0x020400A0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	bl SeaMapManager__GetWork
	bl SeaMapEventManager__GetWork2
	mov r6, r0
	ldr r0, [r6, #0]
	mov r4, #1
	cmp r0, #0
	bne _02040108
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
	ldr r0, [r0, #8]
	str r0, [r5, #0x7c8]
	bl SeaMapEventManager__Func_2046A78
	ldr r0, _02040118 // =SeaMapMenu__State_2040690
	str r0, [r5, #0x7c0]
	b _0204010C
_02040108:
	mov r4, #0
_0204010C:
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02040118: .word SeaMapMenu__State_2040690
	arm_func_end SeaMapMenu__Func_20400A0

	arm_func_start SeaMapMenu__Func_204011C
SeaMapMenu__Func_204011C: // 0x0204011C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r1, [r5, #0x790]
	mov r4, #1
	cmp r1, #0
	beq _0204014C
	cmp r1, #1
	beq _02040190
	cmp r1, #2
	beq _02040198
	b _020401A0
_0204014C:
	ldr r2, _020401B0 // =SeaMapView__sVars+0x00000008
	mov r3, #2
	mov r0, #7
	mov r1, #0x10
	str r3, [r2]
	bl NNS_SndPlayerStopSeqBySeqNo
	ldr r2, _020401B4 // =SeaMapMenu__State_Close
	mov r0, #0
	sub r1, r0, #1
	str r2, [r5, #0x7c0]
	mov ip, #2
	str ip, [sp]
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	b _020401A4
_02040190:
	bl SeaMapMenu__Action_ZoomIn
	b _020401A4
_02040198:
	bl SeaMapMenu__Action_ZoomOut
	b _020401A4
_020401A0:
	mov r4, #0
_020401A4:
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_020401B0: .word SeaMapView__sVars+0x00000008
_020401B4: .word SeaMapMenu__State_Close
	arm_func_end SeaMapMenu__Func_204011C

	arm_func_start SeaMapMenu__Func_20401B8
SeaMapMenu__Func_20401B8: // 0x020401B8
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, [r5, #0x790]
	mov r4, #1
	cmp r0, #5
	beq _020401E4
	cmp r0, #6
	beq _02040238
	cmp r0, #7
	bne _02040288
_020401E4:
	ldr r1, [r5, #0x7c8]
	mov r0, #0
	ldrsh lr, [r1, #0x10]
	ldr r3, _02040298 // =gameState
	ldr r2, _0204029C // =SeaMapView__sVars+0x00000008
	sub r1, r0, #1
	mov ip, #1
	str lr, [r3, #0x80]
	str ip, [r2]
	mov r2, #2
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	mov r0, #7
	mov r1, #0x10
	bl NNS_SndPlayerStopSeqBySeqNo
	ldr r0, _020402A0 // =SeaMapMenu__State_FadeOut
	str r0, [r5, #0x7c0]
	b _0204028C
_02040238:
	mov r0, #8
	mov r1, #0x258
	bl NavTailsSpeak
	mov r0, r5
	mov r1, #0
	bl SeaMapView__Func_203F35C
	ldr r1, _020402A4 // =SeaMapView__TouchAreaCallback
	mov r0, r5
	bl SeaMapView__SetTouchAreaCallback
	mov r0, #2
	str r0, [sp]
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _020402A8 // =SeaMapMenu__State_20405F4
	str r0, [r5, #0x7c0]
	b _0204028C
_02040288:
	mov r4, #0
_0204028C:
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02040298: .word gameState
_0204029C: .word SeaMapView__sVars+0x00000008
_020402A0: .word SeaMapMenu__State_FadeOut
_020402A4: .word SeaMapView__TouchAreaCallback
_020402A8: .word SeaMapMenu__State_20405F4
	arm_func_end SeaMapMenu__Func_20401B8

	arm_func_start SeaMapMenu_Main
SeaMapMenu_Main: // 0x020402AC
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x7c0]
	blx r1
	ldr r0, [r4, #0x7c4]
	cmp r0, #0
	bne _020402D8
	mov r0, r4
	bl SeaMapMenu__Draw
	ldmia sp!, {r4, pc}
_020402D8:
	bl DestroyCurrentTask
	bl SeaMapEventManager__Destroy
	bl SeaMapManager__Destroy
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapMenu_Main

	arm_func_start SeaMapMenu_Destructor
SeaMapMenu_Destructor: // 0x020402E8
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl SeaMapView__ReleaseAssets
	bl ReleaseAudioSystem
	ldr r1, _02040310 // =SeaMapView__sVars+0x00000004
	mov r2, #0
	ldr r0, _02040314 // =SeaMapView__sVars
	str r2, [r1]
	str r2, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02040310: .word SeaMapView__sVars+0x00000004
_02040314: .word SeaMapView__sVars
	arm_func_end SeaMapMenu_Destructor

	arm_func_start SeaMapMenu__Draw
SeaMapMenu__Draw: // 0x02040318
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapView__Func_203E8A8
	ldr r0, [r4, #0x7cc]
	cmp r0, #0
	beq _02040338
	mov r0, r4
	bl SeaMapView__DrawPadCursors
_02040338:
	mov r0, r4
	bl SeaMapView__Func_203F770
	mov r0, r4
	bl SeaMapView__DrawButtons
	mov r0, r4
	bl SeaMapView__DrawTouchCursor
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapMenu__Draw

	arm_func_start SeaMapMenu__Action_ZoomIn
SeaMapMenu__Action_ZoomIn: // 0x02040354
	ldr r2, [r0, #0x7c0]
	ldr r1, _02040368 // =SeaMapMenu__State_ZoomIn
	str r2, [r0, #0x7bc]
	str r1, [r0, #0x7c0]
	bx lr
	.align 2, 0
_02040368: .word SeaMapMenu__State_ZoomIn
	arm_func_end SeaMapMenu__Action_ZoomIn

	arm_func_start SeaMapMenu__State_ZoomIn
SeaMapMenu__State_ZoomIn: // 0x0204036C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x3b4
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
	ldr r1, _020403CC // =SeaMapMenu__State_TryZoomIn
	mov r0, r4
	str r1, [r4, #0x7c0]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_020403CC: .word SeaMapMenu__State_TryZoomIn
	arm_func_end SeaMapMenu__State_ZoomIn

	arm_func_start SeaMapMenu__State_TryZoomIn
SeaMapMenu__State_TryZoomIn: // 0x020403D0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b4
	add r0, r0, #0x400
	bl SeaMapView__CanZoomIn
	cmp r0, #0
	ldrne r0, _020403F4 // =SeaMapMenu__State_PrepareZoomIn
	strne r0, [r4, #0x7c0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020403F4: .word SeaMapMenu__State_PrepareZoomIn
	arm_func_end SeaMapMenu__State_TryZoomIn

	arm_func_start SeaMapMenu__State_PrepareZoomIn
SeaMapMenu__State_PrepareZoomIn: // 0x020403F8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetZoomLevel
	cmp r0, #1
	beq _02040418
	cmp r0, #2
	beq _02040428
	b _02040434
_02040418:
	mov r0, r4
	mov r1, #0
	bl SeaMapView__SetZoomLevel
	b _02040434
_02040428:
	mov r0, r4
	mov r1, #1
	bl SeaMapView__SetZoomLevel
_02040434:
	mov r0, r4
	bl SeaMapView__ProcessPadInputs
	add r0, r4, #0x3b4
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl SeaMapView__InitZoomControl
	ldr r1, _02040460 // =SeaMapMenu__State_ZoomInFinish
	mov r0, r4
	str r1, [r4, #0x7c0]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02040460: .word SeaMapMenu__State_ZoomInFinish
	arm_func_end SeaMapMenu__State_PrepareZoomIn

	arm_func_start SeaMapMenu__State_ZoomInFinish
SeaMapMenu__State_ZoomInFinish: // 0x02040464
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b4
	add r0, r0, #0x400
	bl SeaMapView__HandleZoomIn
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x7bc]
	mov r0, #1
	str r1, [r4, #0x7c0]
	bl SeaMapManager__EnableTouchField
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapMenu__State_ZoomInFinish

	arm_func_start SeaMapMenu__Action_ZoomOut
SeaMapMenu__Action_ZoomOut: // 0x02040494
	ldr r2, [r0, #0x7c0]
	ldr r1, _020404A8 // =SeaMapMenu__State_ZoomOut
	str r2, [r0, #0x7bc]
	str r1, [r0, #0x7c0]
	bx lr
	.align 2, 0
_020404A8: .word SeaMapMenu__State_ZoomOut
	arm_func_end SeaMapMenu__Action_ZoomOut

	arm_func_start SeaMapMenu__State_ZoomOut
SeaMapMenu__State_ZoomOut: // 0x020404AC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x3b4
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
	ldr r1, _0204050C // =SeaMapMenu__State_TryZoomOut
	mov r0, r4
	str r1, [r4, #0x7c0]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0204050C: .word SeaMapMenu__State_TryZoomOut
	arm_func_end SeaMapMenu__State_ZoomOut

	arm_func_start SeaMapMenu__State_TryZoomOut
SeaMapMenu__State_TryZoomOut: // 0x02040510
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b4
	add r0, r0, #0x400
	bl SeaMapView__CanZoomOut
	cmp r0, #0
	ldrne r0, _02040534 // =SeaMapMenu__State_PrepareZoomOut
	strne r0, [r4, #0x7c0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02040534: .word SeaMapMenu__State_PrepareZoomOut
	arm_func_end SeaMapMenu__State_TryZoomOut

	arm_func_start SeaMapMenu__State_PrepareZoomOut
SeaMapMenu__State_PrepareZoomOut: // 0x02040538
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetZoomLevel
	cmp r0, #0
	beq _02040558
	cmp r0, #1
	beq _02040568
	b _02040574
_02040558:
	mov r0, r4
	mov r1, #1
	bl SeaMapView__SetZoomLevel
	b _02040574
_02040568:
	mov r0, r4
	mov r1, #2
	bl SeaMapView__SetZoomLevel
_02040574:
	mov r0, r4
	bl SeaMapView__ProcessPadInputs
	add r0, r4, #0x3b4
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl SeaMapView__InitZoomControl
	ldr r1, _020405A0 // =SeaMapMenu__State_ZoomOutFinish
	mov r0, r4
	str r1, [r4, #0x7c0]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_020405A0: .word SeaMapMenu__State_ZoomOutFinish
	arm_func_end SeaMapMenu__State_PrepareZoomOut

	arm_func_start SeaMapMenu__State_ZoomOutFinish
SeaMapMenu__State_ZoomOutFinish: // 0x020405A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b4
	add r0, r0, #0x400
	bl SeaMapView__HandleZoomOut
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x7bc]
	mov r0, #1
	str r1, [r4, #0x7c0]
	bl SeaMapManager__EnableTouchField
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapMenu__State_ZoomOutFinish

	arm_func_start SeaMapMenu__State_20405D4
SeaMapMenu__State_20405D4: // 0x020405D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapView__FadeToBlack
	cmp r0, #0
	ldrne r0, _020405F0 // =SeaMapMenu__State_20405F4
	strne r0, [r4, #0x7c0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020405F0: .word SeaMapMenu__State_20405F4
	arm_func_end SeaMapMenu__State_20405D4

	arm_func_start SeaMapMenu__State_20405F4
SeaMapMenu__State_20405F4: // 0x020405F4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapView__Func_203E898
	mov r2, #1
	ldr r1, _02040644 // =0x0210F87C
	mov r0, r4
	str r2, [r4, #0x7cc]
	bl SeaMapView__EnableMultipleButtons
	bl SeaMapManager__GetZoomLevel
	mov r1, r0
	mov r0, r4
	bl SeaMapView__SetButtonMode
	mov r0, #8
	mov r1, #0x258
	bl NavTailsSpeak
	ldr r1, _02040648 // =SeaMapMenu__State_204064C
	mov r0, r4
	str r1, [r4, #0x7c0]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02040644: .word 0x0210F87C
_02040648: .word SeaMapMenu__State_204064C
	arm_func_end SeaMapMenu__State_20405F4

	arm_func_start SeaMapMenu__State_204064C
SeaMapMenu__State_204064C: // 0x0204064C
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
	beq _02040680
	bl SeaMapMenu__Func_20400A0
	b _02040684
_02040680:
	bl SeaMapMenu__Func_204011C
_02040684:
	mvn r0, #0
	str r0, [r4, #0x790]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapMenu__State_204064C

	arm_func_start SeaMapMenu__State_2040690
SeaMapMenu__State_2040690: // 0x02040690
	stmdb sp!, {r4, lr}
	ldr r1, _02040728 // =0x0210F89C
	mov r4, r0
	bl SeaMapView__EnableMultipleButtons
	ldr r0, [r4, #0x7c8]
	mov r2, #1
	ldrsh r0, [r0, #0x10]
	cmp r0, #0
	mov r0, r4
	bne _020406C4
	mov r1, #7
	bl SeaMapView__EnableButton
	b _020406CC
_020406C4:
	mov r1, #5
	bl SeaMapView__EnableButton
_020406CC:
	mov r0, #0
	ldr r2, _0204072C // =SeaMapMenu__State_2040734
	str r0, [r4, #0x7cc]
	mov r0, r4
	mov r1, #1
	str r2, [r4, #0x7c0]
	bl SeaMapView__Func_203F35C
	ldr r1, _02040730 // =SeaMapView__TouchAreaCallback2
	mov r0, r4
	bl SeaMapView__SetTouchAreaCallback
	mov r0, r4
	bl SeaMapView__Func_203F344
	mov r0, r4
	bl SeaMapView__ProcessPadInputs
	ldr r0, [r4, #0x7c8]
	ldrsh r0, [r0, #0x10]
	bl SeaMapMenu__GetIslandInfoText
	mov r1, #0
	bl NavTailsSpeak
	ldr r1, [r4, #0x7c0]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02040728: .word 0x0210F89C
_0204072C: .word SeaMapMenu__State_2040734
_02040730: .word SeaMapView__TouchAreaCallback2
	arm_func_end SeaMapMenu__State_2040690

	arm_func_start SeaMapMenu__State_2040734
SeaMapMenu__State_2040734: // 0x02040734
	ldr ip, _0204073C // =SeaMapMenu__Func_20401B8
	bx ip
	.align 2, 0
_0204073C: .word SeaMapMenu__Func_20401B8
	arm_func_end SeaMapMenu__State_2040734

	arm_func_start SeaMapMenu__State_Close
SeaMapMenu__State_Close: // 0x02040740
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapView__FadeActiveScreen
	cmp r0, #0
	movne r0, #1
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapMenu__State_Close

	arm_func_start SeaMapMenu__State_FadeOut
SeaMapMenu__State_FadeOut: // 0x0204075C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SeaMapView__FadeActiveScreen
	mov r4, r0
	mov r0, r5
	bl SeaMapView__FadeOtherScreen
	cmp r4, #0
	cmpne r0, #0
	movne r0, #1
	strne r0, [r5, #0x7c4]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapMenu__State_FadeOut

	.data

aSndSysSoundDat: // 0x02119924
	.asciz "snd/sys/sound_data.sdat"
	.align 4