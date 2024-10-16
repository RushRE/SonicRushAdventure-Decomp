	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SeaMapCutscene__Create
SeaMapCutscene__Create: // 0x0216FF90
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x6c
	bl ReleaseAudioSystem
	ldr r0, _02170260 // =aSndSb1SoundDat_ovl03
	bl LoadAudioSndArc
	ldr r1, _02170264 // =audioManagerSndHeap
	mov r0, #0
	ldr r1, [r1, #0]
	bl NNS_SndArcLoadSeqArc
	ldr r1, _02170264 // =audioManagerSndHeap
	mov r0, #1
	ldr r1, [r1, #0]
	bl NNS_SndArcLoadBank
	bl SeaMapCutscene__InitDisplay
	ldr r0, _02170268 // =VRAMSystem__GFXControl
	mov r2, #1
	ldr r1, _0217026C // =renderCurrentDisplay
	ldr r5, [r0, #0]
	str r2, [r1]
	sub r3, r2, #0x11
	strh r3, [r5, #0x58]
	ldr r6, [r0, #4]
	mov r1, #0xff
	mov r2, #0
	strh r3, [r6, #0x58]
	stmia sp, {r1, r2}
	mov r0, #0x14c
	str r0, [sp, #8]
	ldr r0, _02170270 // =SeaMapCutscene__Main
	ldr r1, _02170274 // =SeaMapCutscene__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x14c
	bl MIi_CpuClear16
	mov r0, #0
	str r0, [r4]
	ldrsh r0, [r5, #0x58]
	strh r0, [r4, #4]
	bl SeaMapManager__GetUnknown1
	ldr r1, _02170278 // =0x0217E0EC
	ldr r1, [r1, r0, lsl #2]
	add r0, r4, #0x28
	str r1, [r4, #8]
	bl TouchField__Init
	mov r2, #0
	str r2, [r4, #0x34]
	ldr r0, _0217027C // =aBbTkdmDownBb_ovl03
	strb r2, [r4, #0x3a]
	mov r1, #7
	bl ReadFileFromBundle
	str r0, [r4, #0x140]
	ldr r0, _0217027C // =aBbTkdmDownBb_ovl03
	mov r1, #6
	mov r2, #0
	bl ReadFileFromBundle
	str r0, [r4, #0x144]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _021700B8
_02170094: // jump table
	b _021700AC // case 0
	b _021700AC // case 1
	b _021700AC // case 2
	b _021700AC // case 3
	b _021700AC // case 4
	b _021700AC // case 5
_021700AC:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _021700BC
_021700B8:
	mov r1, #1
_021700BC:
	ldr r0, _02170280 // =0x0217E0F4
	mov r1, r1, lsl #1
	ldrh r1, [r0, r1]
	ldr r0, _0217027C // =aBbTkdmDownBb_ovl03
	mov r2, #0
	bl ReadFileFromBundle
	str r0, [r4, #0x148]
	mov r0, #0
	ldr r1, _02170284 // =SeaMapView__sVars+0x00000008
	ldr r3, _02170288 // =SeaMapView__sVars+0x00000004
	mov ip, #2
	str r0, [r1]
	mov r2, r0
	str ip, [r3]
	mov r1, #4
	bl SeaMapManager__Create
	ldrsh r1, [r4, #4]
	mov r0, #0
	strh r1, [r5, #0x58]
	bl SeaMapManager__EnableTouchField
	bl SeaMapManager__Func_2043D08
	bl SeaMapEventManager__Create
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r5, _0217028C // =0x04001008
	mov r2, #0
	ldrh r3, [r5, #0]
	mov r1, #0x20
	mov r0, #0x18
	and r3, r3, #0x43
	orr r3, r3, #4
	strh r3, [r5]
	strh r2, [r6]
	strh r2, [r6, #2]
	str r2, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r1, [r4, #0x140]
	add r0, sp, #0x24
	mov r3, #1
	bl InitBackground
	add r0, sp, #0x24
	bl DrawBackground
	ldr r1, _02170290 // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r0, #1
	ldr r5, [r1, #4]
	mov r1, #0x40
	bl VRAMSystem__AllocSpriteVram
	mov r1, #1
	mov r2, #0
	str r1, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	str r5, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	ldr r1, [r4, #0x148]
	add r0, r4, #0x78
	mov r3, r2
	bl AnimatorSprite__Init
	mov r0, #0
	strh r0, [r4, #0xc8]
	ldr r0, [r4, #0x144]
	bl Sprite__GetUnknown6
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	mov r1, #1
	stmia sp, {r1, r2}
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	str r5, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	ldr r1, [r4, #0x144]
	mov r3, r2
	add r0, r4, #0xdc
	bl AnimatorSprite__Init
	add r2, sp, #0x1c
	add r3, r4, #0x100
	mov r5, #1
	add r0, r4, #0xdc
	mov r1, #0
	strh r5, [r3, #0x2c]
	bl AnimatorSprite__GetBlockData
	ldr r0, _02170294 // =SeaMapCutscene__TouchCallback
	ldr r2, _02170298 // =TouchField__PointInRect
	str r0, [sp]
	add r3, sp, #0x1c
	add r0, r4, #0x40
	add r1, r4, #0xe4
	str r4, [sp, #4]
	bl TouchField__InitAreaShape
	add r0, r4, #0x28
	add r1, r4, #0x40
	mov r2, #0
	bl TouchField__AddArea
	ldr r1, [r4, #8]
	mov r0, r4
	blx r1
	bl ResetTouchInput
	add sp, sp, #0x6c
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02170260: .word aSndSb1SoundDat_ovl03
_02170264: .word audioManagerSndHeap
_02170268: .word VRAMSystem__GFXControl
_0217026C: .word renderCurrentDisplay
_02170270: .word SeaMapCutscene__Main
_02170274: .word SeaMapCutscene__Destructor
_02170278: .word 0x0217E0EC
_0217027C: .word aBbTkdmDownBb_ovl03
_02170280: .word 0x0217E0F4
_02170284: .word SeaMapView__sVars+0x00000008
_02170288: .word SeaMapView__sVars+0x00000004
_0217028C: .word 0x04001008
_02170290: .word VRAMSystem__VRAM_PALETTE_OBJ
_02170294: .word SeaMapCutscene__TouchCallback
_02170298: .word TouchField__PointInRect
	arm_func_end SeaMapCutscene__Create

	arm_func_start SeaMapCutscene__TouchCallback
SeaMapCutscene__TouchCallback: // 0x0217029C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r0, [r0, #0]
	mov r4, r2
	cmp r0, #0x40000
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	ldrh r0, [r4, #0xe8]
	cmp r0, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0xdc
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x118]
	mov ip, #0x62
	sub r1, ip, #0x63
	orr r0, r0, #4
	str r0, [r4, #0x118]
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapCutscene__TouchCallback

	arm_func_start SeaMapCutscene__InitDisplay
SeaMapCutscene__InitDisplay: // 0x02170304
	stmdb sp!, {r3, lr}
	bl VRAMSystem__Reset
	mov r0, #1
	bl VRAMSystem__SetupBGBank
	mov ip, #0x200
	mov r0, #0x60
	mov r1, #0x10
	mov r2, #0x40
	mov r3, #0
	str ip, [sp]
	bl VRAMSystem__SetupOBJBank
	mov r0, #4
	bl VRAMSystem__SetupSubBGBank
	mov r0, #0x400
	str r0, [sp]
	mov r0, #8
	mov r1, #0x10
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupSubOBJBank
	mov r1, #0x4000000
	ldr r0, [r1, #0]
	add r2, r1, #0x1000
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r1]
	ldr r0, [r2, #0]
	mov r1, #0
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1100
	str r0, [r2]
	ldr r0, _0217038C // =renderCurrentDisplay
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0217038C: .word renderCurrentDisplay
	arm_func_end SeaMapCutscene__InitDisplay

	arm_func_start SeaMapCutscene__Main
SeaMapCutscene__Main: // 0x02170390
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	ldr r1, _02170400 // =renderCoreGFXControlA
	mov r4, r0
	ldrsh r0, [r1, #0x58]
	cmp r0, #0
	ble _021703C8
	sub r2, r0, #1
	ldr r0, _02170404 // =renderCoreGFXControlB
	strh r2, [r1, #0x58]
	ldrsh r1, [r0, #0x58]
	sub r1, r1, #1
	strh r1, [r0, #0x58]
	b _021703F0
_021703C8:
	bge _021703E8
	add r2, r0, #1
	ldr r0, _02170404 // =renderCoreGFXControlB
	strh r2, [r1, #0x58]
	ldrsh r1, [r0, #0x58]
	add r1, r1, #1
	strh r1, [r0, #0x58]
	b _021703F0
_021703E8:
	ldr r0, _02170408 // =SeaMapCutscene__Main_Active
	bl SetCurrentTaskMainEvent
_021703F0:
	ldr r1, [r4, #0xc]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170400: .word renderCoreGFXControlA
_02170404: .word renderCoreGFXControlB
_02170408: .word SeaMapCutscene__Main_Active
	arm_func_end SeaMapCutscene__Main

	arm_func_start SeaMapCutscene__Main_Active
SeaMapCutscene__Main_Active: // 0x0217040C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x28
	bl TouchField__Process
	ldr r1, [r4, #8]
	mov r0, r4
	blx r1
	ldr r1, [r4, #0xc]
	mov r0, r4
	blx r1
	mov r1, #0
	add r0, r4, #0x78
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldrh r0, [r4, #0x24]
	add r0, r0, #1
	strh r0, [r4, #0x24]
	ldr r0, [r4, #0xb4]
	tst r0, #1
	ldrh r0, [r4, #0x24]
	beq _02170470
	cmp r0, #0x60
	b _02170474
_02170470:
	cmp r0, #0x40
_02170474:
	movhs r0, #0
	strhsh r0, [r4, #0x24]
	ldrh r0, [r4, #0x24]
	cmp r0, #0
	ldreq r0, [r4, #0xb4]
	eoreq r0, r0, #1
	streq r0, [r4, #0xb4]
	add r0, r4, #0x78
	bl AnimatorSprite__DrawFrame
	mov r1, #0
	mov r2, r1
	add r0, r4, #0xdc
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0xdc
	bl AnimatorSprite__DrawFrame
	ldrh r0, [r4, #0xe8]
	cmp r0, #1
	bne _021704E4
	ldrh r1, [r4, #0x26]
	add r0, r1, #1
	cmp r1, #0x1e
	addls sp, sp, #8
	strh r0, [r4, #0x26]
	ldmlsia sp!, {r4, pc}
	ldr r0, _02170534 // =SeaMapCutscene__Main_FadeOut
	bl SetCurrentTaskMainEvent
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_021704E4:
	ldr r0, _02170538 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0xdc
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x118]
	mov ip, #0x62
	sub r1, ip, #0x63
	orr r0, r0, #4
	str r0, [r4, #0x118]
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170534: .word SeaMapCutscene__Main_FadeOut
_02170538: .word padInput
	arm_func_end SeaMapCutscene__Main_Active

	arm_func_start SeaMapCutscene__Main_FadeOut
SeaMapCutscene__Main_FadeOut: // 0x0217053C
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r2, _021705BC // =renderCoreGFXControlA
	ldrsh r1, [r0, #4]
	ldrsh r3, [r2, #0x58]
	cmp r1, r3
	bge _02170574
	sub r3, r3, #1
	ldr r1, _021705C0 // =renderCoreGFXControlB
	strh r3, [r2, #0x58]
	ldrsh r2, [r1, #0x58]
	sub r2, r2, #1
	strh r2, [r1, #0x58]
	b _021705B0
_02170574:
	ble _02170594
	add r3, r3, #1
	ldr r1, _021705C0 // =renderCoreGFXControlB
	strh r3, [r2, #0x58]
	ldrsh r2, [r1, #0x58]
	add r2, r2, #1
	strh r2, [r1, #0x58]
	b _021705B0
_02170594:
	bl DestroyCurrentTask
	bl SeaMapEventManager__Destroy
	bl SeaMapManager__Destroy
	mov r0, #0
	bl RequestSysEventChange
	bl NextSysEvent
	ldmia sp!, {r3, pc}
_021705B0:
	ldr r1, [r0, #0xc]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_021705BC: .word renderCoreGFXControlA
_021705C0: .word renderCoreGFXControlB
	arm_func_end SeaMapCutscene__Main_FadeOut

	arm_func_start SeaMapCutscene__Destructor
SeaMapCutscene__Destructor: // 0x021705C4
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x78
	bl AnimatorSprite__Release
	add r0, r4, #0xdc
	bl AnimatorSprite__Release
	ldr r0, [r4, #0x140]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x144]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x148]
	bl _FreeHEAP_USER
	bl ReleaseAudioSystem
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapCutscene__Destructor

	arm_func_start SeaMapCutscene__Func_2170600
SeaMapCutscene__Func_2170600: // 0x02170600
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl SeaMapManager__GetWork
	ldr r5, [r0, #0x160]
	mov r6, #0
	ldrh r0, [r5, #0]
	cmp r0, #0
	bls _0217066C
	add r4, r5, #2
	mov r7, #0x12
_02170624:
	mla r8, r6, r7, r4
	mov r0, r8
	bl SeaMapEventManager__GetObjectType
	cmp r0, #2
	cmpne r0, #3
	bne _02170654
	ldrb r0, [r8, #7]
	tst r0, #1
	ldreqsh r0, [r8, #0x10]
	cmpeq r0, #0xe
	moveq r0, r8
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
_02170654:
	ldrh r1, [r5, #0]
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r6, r0, lsr #0x10
	bhi _02170624
_0217066C:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end SeaMapCutscene__Func_2170600

	arm_func_start SeaMapCutscene__State2_2170674
SeaMapCutscene__State2_2170674: // 0x02170674
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	mov r1, #0x118000
	bl SeaMapManager__Func_2043974
	ldr r0, _021706AC // =SeaMapCutscene__State2_21706B8
	ldr r3, _021706B0 // =SeaMapCutscene__State1_21706B4
	str r0, [r4, #8]
	add r1, r4, #0x10
	mov r0, #0
	mov r2, #2
	str r3, [r4, #0xc]
	bl MIi_CpuClear16
	ldmia sp!, {r4, pc}
	.align 2, 0
_021706AC: .word SeaMapCutscene__State2_21706B8
_021706B0: .word SeaMapCutscene__State1_21706B4
	arm_func_end SeaMapCutscene__State2_2170674

	arm_func_start SeaMapCutscene__State1_21706B4
SeaMapCutscene__State1_21706B4: // 0x021706B4
	bx lr
	arm_func_end SeaMapCutscene__State1_21706B4

	arm_func_start SeaMapCutscene__State2_21706B8
SeaMapCutscene__State2_21706B8: // 0x021706B8
	ldrh r2, [r0, #0x10]
	add r1, r2, #1
	strh r1, [r0, #0x10]
	cmp r2, #0x3c
	ldrhi r1, _021706D4 // =SeaMapCutscene__State2_21706D8
	strhi r1, [r0, #8]
	bx lr
	.align 2, 0
_021706D4: .word SeaMapCutscene__State2_21706D8
	arm_func_end SeaMapCutscene__State2_21706B8

	arm_func_start SeaMapCutscene__State2_21706D8
SeaMapCutscene__State2_21706D8: // 0x021706D8
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r0, #3
	bl SeaMapEventManager__GetObjectFromID
	mov r5, r0
	bl SeaMapCutscene__Func_2170600
	add r1, r0, #8
	str r1, [sp]
	mov r3, #0
	str r3, [sp, #4]
	ldrsh r1, [r0, #2]
	ldrsh r2, [r0, #4]
	mov r0, #2
	bl SeaMapEventManager__CreateObject
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	ldrsh r2, [r5, #4]
	ldrsh r1, [r5, #2]
	mov r0, #0xc
	sub r2, r2, #0x20
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	bl SeaMapEventManager__CreateObject
	bl SeaMapEventManager__UnlockCoralCave
	mov r0, #0
	str r0, [sp]
	mov r1, #0x52
	str r1, [sp, #4]
	sub r1, r1, #0x53
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #0
	strh r0, [r4, #0x10]
	ldr r0, _02170778 // =SeaMapCutscene__State2_217077C
	str r0, [r4, #8]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02170778: .word SeaMapCutscene__State2_217077C
	arm_func_end SeaMapCutscene__State2_21706D8

	arm_func_start SeaMapCutscene__State2_217077C
SeaMapCutscene__State2_217077C: // 0x0217077C
	stmdb sp!, {r3, lr}
	ldrh r2, [r0, #0x10]
	add r1, r2, #1
	strh r1, [r0, #0x10]
	cmp r2, #0xb4
	ldmlsia sp!, {r3, pc}
	ldr r0, _021707A0 // =SeaMapCutscene__Main_FadeOut
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_021707A0: .word SeaMapCutscene__Main_FadeOut
	arm_func_end SeaMapCutscene__State2_217077C

	arm_func_start SeaMapCutscene__State_21707A4
SeaMapCutscene__State_21707A4: // 0x021707A4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r0, #6
	bl SeaMapEventManager__GetObjectFromID
	ldrsh r1, [r0, #2]
	ldrsh r0, [r0, #4]
	sub r2, r1, #0x80
	sub r1, r0, #0x60
	mov r0, r2, lsl #0xc
	mov r1, r1, lsl #0xc
	bl SeaMapManager__Func_2043974
	ldr r0, _0217084C // =SeaMapCutscene__State2_217085C
	ldr r3, _02170850 // =SeaMapCutscene__State1_2170858
	str r0, [r4, #8]
	add r1, r4, #0x10
	mov r0, #0
	mov r2, #0x14
	str r3, [r4, #0xc]
	bl MIi_CpuClear16
	mov r0, #0xb
	bl SeaMapEventManager__GetObjectFromID
	ldr r1, _02170854 // =gameState
	mov r3, #0
	ldr r1, [r1, #0xa0]
	cmp r1, #0
	cmpne r1, #2
	movne r1, #2
	mov r1, r1, lsl #0x10
	str r3, [sp]
	mov r1, r1, asr #0x10
	str r1, [sp, #4]
	ldrsh r2, [r0, #4]
	ldrsh r1, [r0, #2]
	mov r0, #9
	add r2, r2, #8
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	bl SeaMapEventManager__CreateObject
	str r0, [r4, #0x10]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217084C: .word SeaMapCutscene__State2_217085C
_02170850: .word SeaMapCutscene__State1_2170858
_02170854: .word gameState
	arm_func_end SeaMapCutscene__State_21707A4

	arm_func_start SeaMapCutscene__State1_2170858
SeaMapCutscene__State1_2170858: // 0x02170858
	bx lr
	arm_func_end SeaMapCutscene__State1_2170858

	arm_func_start SeaMapCutscene__State2_217085C
SeaMapCutscene__State2_217085C: // 0x0217085C
	ldrh r2, [r0, #0x22]
	add r1, r2, #1
	strh r1, [r0, #0x22]
	cmp r2, #0x3c
	ldrhi r1, _02170878 // =SeaMapCutscene__State2_217087C
	strhi r1, [r0, #8]
	bx lr
	.align 2, 0
_02170878: .word SeaMapCutscene__State2_217087C
	arm_func_end SeaMapCutscene__State2_217085C

	arm_func_start SeaMapCutscene__State2_217087C
SeaMapCutscene__State2_217087C: // 0x0217087C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r0, #6
	bl SeaMapEventManager__GetObjectFromID
	mov r5, r0
	bl SeaMapEventManager__UnlockSkyBabylon
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	ldrsh r2, [r5, #4]
	ldrsh r1, [r5, #2]
	mov r0, #0xc
	sub r2, r2, #0x20
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	bl SeaMapEventManager__CreateObject
	mov r0, #0
	str r0, [sp]
	mov r1, #0x52
	str r1, [sp, #4]
	sub r1, r1, #0x53
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #0
	strh r0, [r4, #0x22]
	ldr r0, _021708F8 // =SeaMapCutscene__State2_21708FC
	str r0, [r4, #8]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021708F8: .word SeaMapCutscene__State2_21708FC
	arm_func_end SeaMapCutscene__State2_217087C

	arm_func_start SeaMapCutscene__State2_21708FC
SeaMapCutscene__State2_21708FC: // 0x021708FC
	ldrh r2, [r0, #0x22]
	add r1, r2, #1
	strh r1, [r0, #0x22]
	cmp r2, #0xb4
	ldrhi r1, _02170918 // =SeaMapCutscene__State2_217091C
	strhi r1, [r0, #8]
	bx lr
	.align 2, 0
_02170918: .word SeaMapCutscene__State2_217091C
	arm_func_end SeaMapCutscene__State2_21708FC

	arm_func_start SeaMapCutscene__State2_217091C
SeaMapCutscene__State2_217091C: // 0x0217091C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x10]
	mov r0, #6
	ldrsh r1, [r1, #0xe]
	mov r1, r1, lsl #0xc
	str r1, [r4, #0x14]
	bl SeaMapEventManager__GetObjectFromID
	ldrsh r2, [r0, #4]
	ldr r0, _02170990 // =0x00000333
	mov r1, #0
	mov r2, r2, lsl #0xc
	str r2, [r4, #0x1c]
	ldr lr, [r4, #0x14]
	rsb r2, lr, r2
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r2, r2, asr #0x1f
	mla r3, r2, r0, r3
	adds ip, ip, #0x800
	adc r0, r3, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r0, lsl #20
	add r0, lr, r2
	str r0, [r4, #0x18]
	ldr r0, _02170994 // =SeaMapCutscene__State2_2170998
	strh r1, [r4, #0x20]
	str r0, [r4, #8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170990: .word 0x00000333
_02170994: .word SeaMapCutscene__State2_2170998
	arm_func_end SeaMapCutscene__State2_217091C

	arm_func_start SeaMapCutscene__State2_2170998
SeaMapCutscene__State2_2170998: // 0x02170998
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldrsh r2, [r0, #0x20]
	mov r1, #0
	mov ip, #2
	add r2, r2, #0x44
	strh r2, [r0, #0x20]
	ldrsh r2, [r0, #0x20]
	mov r6, #0
	mov r5, #0x800
	cmp r2, #0x1000
	movge r1, #0x1000
	strgeh r1, [r0, #0x20]
	ldrsh r4, [r0, #0x20]
	ldr r3, [r0, #0x18]
	ldr r2, [r0, #0x14]
	movge r1, #1
	mov lr, r4, asr #0x1f
_021709DC:
	sub r7, r3, r2
	umull r9, r8, r7, r4
	mla r8, r7, lr, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, r4, r8
	adds r9, r9, r5
	adc r7, r8, r6
	mov r8, r9, lsr #0xc
	orr r8, r8, r7, lsl #20
	cmp ip, #0
	add r2, r2, r8
	sub ip, ip, #1
	bne _021709DC
	ldr r3, [r0, #0x10]
	mov r2, r2, asr #0xc
	strh r2, [r3, #0xe]
	cmp r1, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r2, #0
	ldr r1, _02170A38 // =SeaMapCutscene__State2_2170A3C
	strh r2, [r0, #0x20]
	str r1, [r0, #8]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02170A38: .word SeaMapCutscene__State2_2170A3C
	arm_func_end SeaMapCutscene__State2_2170998

	arm_func_start SeaMapCutscene__State2_2170A3C
SeaMapCutscene__State2_2170A3C: // 0x02170A3C
	stmdb sp!, {r4, lr}
	ldrsh r2, [r0, #0x20]
	mov r1, #0
	add r2, r2, #0x51
	strh r2, [r0, #0x20]
	ldrsh r2, [r0, #0x20]
	cmp r2, #0x1000
	movge r1, #0x1000
	strgeh r1, [r0, #0x20]
	ldr r4, [r0, #0x18]
	ldr r2, [r0, #0x1c]
	ldrsh r3, [r0, #0x20]
	sub ip, r2, r4
	movge r1, #1
	smull lr, r3, ip, r3
	adds ip, lr, #0x800
	adc r3, r3, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r3, lsl #20
	add r3, r4, ip
	cmp r1, #0
	ldr r2, [r0, #0x10]
	mov r3, r3, asr #0xc
	strh r3, [r2, #0xe]
	mov r2, #0
	ldrne r1, _02170AB0 // =SeaMapCutscene__State2_2170AB4
	strneh r2, [r0, #0x22]
	strne r1, [r0, #8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170AB0: .word SeaMapCutscene__State2_2170AB4
	arm_func_end SeaMapCutscene__State2_2170A3C

	arm_func_start SeaMapCutscene__State2_2170AB4
SeaMapCutscene__State2_2170AB4: // 0x02170AB4
	stmdb sp!, {r3, lr}
	ldrh r2, [r0, #0x22]
	add r1, r2, #1
	strh r1, [r0, #0x22]
	cmp r2, #0x3c
	ldmlsia sp!, {r3, pc}
	ldr r0, _02170AD8 // =SeaMapCutscene__Main_FadeOut
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02170AD8: .word SeaMapCutscene__Main_FadeOut
	arm_func_end SeaMapCutscene__State2_2170AB4

	.data
	
aSndSb1SoundDat_ovl03: // 0x0217EE28
	.asciz "snd/sb1/sound_data.sdat"
	.align 4
	
aBbTkdmDownBb_ovl03: // 0x0217EE40
	.asciz "bb/tkdm_down.bb"
	.align 4
