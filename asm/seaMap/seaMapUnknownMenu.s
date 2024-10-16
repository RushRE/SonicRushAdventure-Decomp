	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SeaMapUnknown__Create
SeaMapUnknown__Create: // 0x0216FC98
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	bl ReleaseAudioSystem
	ldr r0, _0216FD7C // =aSndSysSoundDat_2
	bl LoadAudioSndArc
	ldr r1, _0216FD80 // =audioManagerSndHeap
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
	ldr r0, _0216FD84 // =SeaMapUnknown__Main
	ldr r1, _0216FD88 // =SeaMapUnknown__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0xc
	bl MIi_CpuClear16
	ldr r0, _0216FD8C // =SeaMapUnknown__State_216FE9C
	str r0, [r4]
	bl SeaMapUnknown__InitDisplay
	ldr r1, _0216FD90 // =gameState
	mov r0, #0
	ldr r1, [r1, #0xa0]
	mov r2, r0
	bl SeaMapChartCourseView__Create
	ldr r0, _0216FD90 // =gameState
	ldr r0, [r0, #0x80]
	bl SeaMapEventManager__GetObjectFromID
	ldrsh r1, [r0, #4]
	ldrsh r2, [r0, #2]
	mov r1, r1, lsl #0xc
	mov r0, r2, lsl #0xc
	bl SeaMapView__Func_203DCE0
	ldr r1, _0216FD90 // =gameState
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
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216FD7C: .word aSndSysSoundDat_2
_0216FD80: .word audioManagerSndHeap
_0216FD84: .word SeaMapUnknown__Main
_0216FD88: .word SeaMapUnknown__Destructor
_0216FD8C: .word SeaMapUnknown__State_216FE9C
_0216FD90: .word gameState
	arm_func_end SeaMapUnknown__Create

	arm_func_start SeaMapUnknown__Main
SeaMapUnknown__Main: // 0x0216FD94
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0]
	blx r1
	ldr r0, [r4, #4]
	cmp r0, #0
	mov r0, r4
	bne _0216FDC0
	bl SeaMapUnknown__RunState
	ldmia sp!, {r4, pc}
_0216FDC0:
	bl SeaMapUnknown__Destroy
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapUnknown__Main

	arm_func_start SeaMapUnknown__Destructor
SeaMapUnknown__Destructor: // 0x0216FDC8
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl ReleaseAudioSystem
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapUnknown__Destructor

	arm_func_start SeaMapUnknown__Destroy
SeaMapUnknown__Destroy: // 0x0216FDD8
	stmdb sp!, {r3, lr}
	bl SeaMapChartCourseView__Destroy
	bl ReleaseSpriteButtonCursorSprite
	bl ReleaseSpriteButtonTouchpadSprite
	bl DestroyCurrentTask
	bl SeaMapView__Func_203DCB4
	cmp r0, #1
	beq _0216FE04
	cmp r0, #2
	beq _0216FE18
	b _0216FE28
_0216FE04:
	mov r0, #2
	bl SaveGame__SetUnknown1
	mov r0, #0
	bl RequestSysEventChange
	b _0216FE28
_0216FE18:
	ldr r1, _0216FE30 // =gameState
	mov r0, #1
	strb r0, [r1, #0xdc]
	bl RequestSysEventChange
_0216FE28:
	bl NextSysEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216FE30: .word gameState
	arm_func_end SeaMapUnknown__Destroy

	arm_func_start SeaMapUnknown__RunState
SeaMapUnknown__RunState: // 0x0216FE34
	bx lr
	arm_func_end SeaMapUnknown__RunState

	arm_func_start SeaMapUnknown__InitDisplay
SeaMapUnknown__InitDisplay: // 0x0216FE38
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
	ldr r0, _0216FE98 // =renderCurrentDisplay
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216FE98: .word renderCurrentDisplay
	arm_func_end SeaMapUnknown__InitDisplay

	arm_func_start SeaMapUnknown__State_216FE9C
SeaMapUnknown__State_216FE9C: // 0x0216FE9C
	ldr r1, _0216FEA8 // =SeaMapUnknown__State_216FEAC
	str r1, [r0]
	bx lr
	.align 2, 0
_0216FEA8: .word SeaMapUnknown__State_216FEAC
	arm_func_end SeaMapUnknown__State_216FE9C

	arm_func_start SeaMapUnknown__State_216FEAC
SeaMapUnknown__State_216FEAC: // 0x0216FEAC
	stmdb sp!, {r4, lr}
	mov lr, #0
	ldr r3, _0216FF08 // =VRAMSystem__GFXControl
	mov ip, #1
	mov r1, lr
_0216FEC0:
	ldr r4, [r3, lr, lsl #2]
	ldrsh r2, [r4, #0x58]
	cmp r2, #0
	subgt r2, r2, #1
	strgth r2, [r4, #0x58]
	bgt _0216FEE0
	addlt r2, r2, #1
	strlth r2, [r4, #0x58]
_0216FEE0:
	ldrsh r2, [r4, #0x58]
	add lr, lr, #1
	cmp r2, #0
	movne ip, r1
	cmp lr, #2
	blt _0216FEC0
	cmp ip, #0
	ldrne r1, _0216FF0C // =SeaMapUnknown__State_216FF10
	strne r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FF08: .word VRAMSystem__GFXControl
_0216FF0C: .word SeaMapUnknown__State_216FF10
	arm_func_end SeaMapUnknown__State_216FEAC

	arm_func_start SeaMapUnknown__State_216FF10
SeaMapUnknown__State_216FF10: // 0x0216FF10
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapChartCourseView__Func_2040978
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, #7
	mov r1, #0x10
	bl NNS_SndPlayerStopSeqBySeqNo
	ldr r0, _0216FF3C // =SeaMapUnknown__State_216FF40
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FF3C: .word SeaMapUnknown__State_216FF40
	arm_func_end SeaMapUnknown__State_216FF10

	arm_func_start SeaMapUnknown__State_216FF40
SeaMapUnknown__State_216FF40: // 0x0216FF40
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, #0
	ldr lr, _0216FF8C // =VRAMSystem__GFXControl
	mov r4, #1
	mov r2, r5
	mvn r1, #0xf
_0216FF58:
	ldr ip, [lr, r5, lsl #2]
	add r5, r5, #1
	ldrsh r3, [ip, #0x58]
	cmp r3, r1
	subgt r3, r3, #1
	movgt r4, r2
	strgth r3, [ip, #0x58]
	cmp r5, #2
	blt _0216FF58
	cmp r4, #0
	movne r1, #1
	strne r1, [r0, #4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216FF8C: .word VRAMSystem__GFXControl
	arm_func_end SeaMapUnknown__State_216FF40
	
	.data
	
aSndSysSoundDat_2: // 0x0217EE10
	.asciz "snd/sys/sound_data.sdat"
	.align 4
