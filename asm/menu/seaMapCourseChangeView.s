	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__GFXControl
.public VRAMSystem__VRAM_BG

	.bss
	
.public SeaMapCourseChangeView__stru_2134440
SeaMapCourseChangeView__stru_2134440: // 0x02134440
    .space 0x04 * 2

	.text

	arm_func_start SeaMapCourseChangeView__Create
SeaMapCourseChangeView__Create: // 0x0204B51C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x1c
	bl ReleaseAudioSystem
	ldr r0, _0204B6E4 // =aSndSysSoundDat_0
	bl LoadAudioSndArc
	ldr r1, _0204B6E8 // =audioManagerSndHeap
	mov r0, #6
	ldr r1, [r1, #0]
	bl NNS_SndArcLoadGroup
	bl LoadSpriteButtonCursorSprite
	bl LoadSpriteButtonTouchpadSprite
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r0, _0204B6EC // =SeaMapCourseChangeView__Main
	ldr r1, _0204B6F0 // =SeaMapCourseChangeView__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0xc
	bl MIi_CpuClear16
	ldr r0, _0204B6F4 // =SeaMapCourseChangeView__State_Setup
	str r0, [r4]
	bl SeaMapCourseChangeView__ResetDisplay
	mov r0, #0
	ldr r1, _0204B6F8 // =gameState
	mov r2, #1
	ldr r1, [r1, #0xa0]
	bl SeaMapChartCourseView__Create
	bl SeaMapManager__Func_20444E8
	ldr r10, _0204B6FC // =SeaMapView__sVars+0x0000000C
	ldr r9, _0204B700 // =SeaMapCourseChangeView__02134174
	ldr r0, [r10, #0]
	add r8, sp, #0x14
	add r7, sp, #0x18
	add r6, sp, #0x10
	add r5, sp, #0x12
	mov r4, #1
_0204B5C8:
	ldr r3, [r9, #0]
	mov r1, r8
	mov r2, r7
	sub r0, r0, r3
	bl SeaMapManager__Func_2045BF8
	ldr r0, [sp, #0x14]
	ldr r1, [sp, #0x18]
	mov r2, r6
	mov r3, r5
	bl SeaMapManager__Func_2043B60
	ldrh r0, [sp, #0x10]
	ldrh r1, [sp, #0x12]
	mov r2, r4
	bl SeaMapCollision__Collide
	cmp r0, #0
	beq _0204B628
	ldr r0, [r10, #0]
	ldr r1, [r9, #0]
	sub r0, r0, #0x800
	str r0, [r10]
	cmp r1, r0
	ble _0204B5C8
	ldr r0, _0204B6FC // =SeaMapView__sVars+0x0000000C
	str r1, [r0]
_0204B628:
	ldr r1, _0204B6FC // =SeaMapView__sVars+0x0000000C
	ldr r0, _0204B700 // =SeaMapCourseChangeView__02134174
	ldr r3, [r1, #0]
	ldr r0, [r0, #0]
	ldr r1, _0204B704 // =SeaMapCourseChangeView__stru_2134440
	ldr r2, _0204B708 // =SeaMapCourseChangeView__stru_2134440+0x00000004
	sub r0, r3, r0
	bl SeaMapManager__Func_2045BF8
	bl SeaMapManager__RemoveAllNodes
	ldr r1, _0204B70C // =SeaMapCourseChangeView__stru_2134440
	ldmia r1, {r0, r1}
	bl SeaMapView__Func_203DCE0
	ldr r1, _0204B70C // =SeaMapCourseChangeView__stru_2134440
	add r2, sp, #0xc
	add r3, sp, #0xe
	ldmia r1, {r0, r1}
	bl SeaMapManager__Func_2043B28
	ldrh r0, [sp, #0xc]
	ldrh r1, [sp, #0xe]
	bl SeaMapManager__AddNode
	mov r3, #0
	str r3, [sp]
	ldr r1, _0204B70C // =SeaMapCourseChangeView__stru_2134440
	str r3, [sp, #4]
	ldr r2, [r1, #4]
	ldr r4, [r1, #0]
	mov r2, r2, lsl #4
	mov r1, r4, lsl #4
	mov r0, #9
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	bl SeaMapEventManager__CreateObject
	ldr r1, _0204B6F8 // =gameState
	mov r0, #1
	ldr r1, [r1, #0xa0]
	mov r2, #0
	bl CreateNavTails
	mov r0, #7
	str r0, [sp]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlayTrack
	bl ResetTouchInput
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0204B6E4: .word aSndSysSoundDat_0
_0204B6E8: .word audioManagerSndHeap
_0204B6EC: .word SeaMapCourseChangeView__Main
_0204B6F0: .word SeaMapCourseChangeView__Destructor
_0204B6F4: .word SeaMapCourseChangeView__State_Setup
_0204B6F8: .word gameState
_0204B6FC: .word SeaMapView__sVars+0x0000000C
_0204B700: .word SeaMapCourseChangeView__02134174
_0204B704: .word SeaMapCourseChangeView__stru_2134440
_0204B708: .word SeaMapCourseChangeView__stru_2134440+0x00000004
_0204B70C: .word SeaMapCourseChangeView__stru_2134440
	arm_func_end SeaMapCourseChangeView__Create

	arm_func_start SeaMapCourseChangeView__Main
SeaMapCourseChangeView__Main: // 0x0204B710
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0]
	blx r1
	ldr r0, [r4, #4]
	cmp r0, #0
	mov r0, r4
	bne _0204B73C
	bl SeaMapCourseChangeView__RunningState
	ldmia sp!, {r4, pc}
_0204B73C:
	bl SeaMapCourseChangeView__Destroy
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapCourseChangeView__Main

	arm_func_start SeaMapCourseChangeView__Destructor
SeaMapCourseChangeView__Destructor: // 0x0204B744
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl ReleaseAudioSystem
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapCourseChangeView__Destructor

	arm_func_start SeaMapCourseChangeView__Destroy
SeaMapCourseChangeView__Destroy: // 0x0204B754
	stmdb sp!, {r3, lr}
	bl SeaMapChartCourseView__Destroy
	bl ReleaseSpriteButtonCursorSprite
	bl ReleaseSpriteButtonTouchpadSprite
	bl DestroyCurrentTask
	bl SeaMapView__Func_203DCB4
	cmp r0, #1
	beq _0204B780
	cmp r0, #2
	beq _0204B794
	b _0204B7AC
_0204B780:
	mov r0, #2
	bl SaveGame__Func_205B9F0
	mov r0, #0
	bl RequestSysEventChange
	b _0204B7AC
_0204B794:
	bl MultibootManager__Func_2063C40
	ldr r1, _0204B7B4 // =gameState
	mov r2, #0
	mov r0, #1
	strb r2, [r1, #0xdc]
	bl RequestSysEventChange
_0204B7AC:
	bl NextSysEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_0204B7B4: .word gameState
	arm_func_end SeaMapCourseChangeView__Destroy

	arm_func_start SeaMapCourseChangeView__RunningState
SeaMapCourseChangeView__RunningState: // 0x0204B7B8
	bx lr
	arm_func_end SeaMapCourseChangeView__RunningState

	arm_func_start SeaMapCourseChangeView__ResetDisplay
SeaMapCourseChangeView__ResetDisplay: // 0x0204B7BC
	stmdb sp!, {r3, lr}
	bl VRAMSystem__Reset
	mov r0, #8
	bl VRAMSystem__SetupBGBank
	mov ip, #0x400
	mov r0, #0x60
	mov r1, #0x10
	mov r2, #0x40
	mov r3, #0
	str ip, [sp]
	bl VRAMSystem__SetupOBJBank
	mov r0, #4
	bl VRAMSystem__SetupSubBGBank
	mov r0, #0x200
	str r0, [sp]
	mov r0, #0x100
	mov r1, #0x10
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupSubOBJBank
	mov r1, #0
	ldr r0, _0204B81C // =renderCurrentDisplay
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0204B81C: .word renderCurrentDisplay
	arm_func_end SeaMapCourseChangeView__ResetDisplay

	arm_func_start SeaMapCourseChangeView__State_Setup
SeaMapCourseChangeView__State_Setup: // 0x0204B820
	ldr r1, _0204B82C // =SeaMapCourseChangeView__State_FadeIn
	str r1, [r0]
	bx lr
	.align 2, 0
_0204B82C: .word SeaMapCourseChangeView__State_FadeIn
	arm_func_end SeaMapCourseChangeView__State_Setup

	arm_func_start SeaMapCourseChangeView__State_FadeIn
SeaMapCourseChangeView__State_FadeIn: // 0x0204B830
	stmdb sp!, {r4, lr}
	mov lr, #0
	ldr r3, _0204B88C // =VRAMSystem__GFXControl
	mov ip, #1
	mov r1, lr
_0204B844:
	ldr r4, [r3, lr, lsl #2]
	ldrsh r2, [r4, #0x58]
	cmp r2, #0
	subgt r2, r2, #1
	strgth r2, [r4, #0x58]
	bgt _0204B864
	addlt r2, r2, #1
	strlth r2, [r4, #0x58]
_0204B864:
	ldrsh r2, [r4, #0x58]
	add lr, lr, #1
	cmp r2, #0
	movne ip, r1
	cmp lr, #2
	blt _0204B844
	cmp ip, #0
	ldrne r1, _0204B890 // =SeaMapCourseChangeView__State_Active
	strne r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0204B88C: .word VRAMSystem__GFXControl
_0204B890: .word SeaMapCourseChangeView__State_Active
	arm_func_end SeaMapCourseChangeView__State_FadeIn

	arm_func_start SeaMapCourseChangeView__State_Active
SeaMapCourseChangeView__State_Active: // 0x0204B894
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapChartCourseView__Func_2040978
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, #7
	mov r1, #0x10
	bl NNS_SndPlayerStopSeqBySeqNo
	ldr r0, _0204B8C0 // =SeaMapCourseChangeView__State_FadeOut
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0204B8C0: .word SeaMapCourseChangeView__State_FadeOut
	arm_func_end SeaMapCourseChangeView__State_Active

	arm_func_start SeaMapCourseChangeView__State_FadeOut
SeaMapCourseChangeView__State_FadeOut: // 0x0204B8C4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, #0
	ldr lr, _0204B910 // =VRAMSystem__GFXControl
	mov r4, #1
	mov r2, r5
	mvn r1, #0xf
_0204B8DC:
	ldr ip, [lr, r5, lsl #2]
	add r5, r5, #1
	ldrsh r3, [ip, #0x58]
	cmp r3, r1
	subgt r3, r3, #1
	movgt r4, r2
	strgth r3, [ip, #0x58]
	cmp r5, #2
	blt _0204B8DC
	cmp r4, #0
	movne r1, #1
	strne r1, [r0, #4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0204B910: .word VRAMSystem__GFXControl
	arm_func_end SeaMapCourseChangeView__State_FadeOut

	.data
	
aSndSysSoundDat_0: // 0x0211994C
	.asciz "snd/sys/sound_data.sdat"
	.align 4