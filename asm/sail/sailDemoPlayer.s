	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailDemoPlayer__Create
SailDemoPlayer__Create: // 0x0218B028
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r5, _0218B19C // =gameState
	mov r0, #2
	ldrh r2, [r5, #0x6e]
	mov r1, #4
	strh r2, [r5, #0x6a]
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #2
	bl StageTask__SetType
	ldr r0, [r4, #0x18]
	ldr r1, _0218B1A0 // =SailDemoPlayer__State_Playback
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x20]
	mov r0, #0x51
	orr r2, r2, #0x180
	str r2, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	orr r2, r2, #0x2100
	str r2, [r4, #0x1c]
	str r1, [r4, #0xf4]
	bl GetObjectFileWork
	ldr r0, [r0]
	cmp r0, #0
	bne _0218B0F4
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0218B0CC
_0218B0A8: // jump table
	b _0218B0C0 // case 0
	b _0218B0C0 // case 1
	b _0218B0C0 // case 2
	b _0218B0C0 // case 3
	b _0218B0C0 // case 4
	b _0218B0C0 // case 5
_0218B0C0:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	b _0218B0D0
_0218B0CC:
	mov r0, #1
_0218B0D0:
	mov r1, r0, lsl #0x10
	ldr r0, _0218B1A4 // =aBbGmDemoplayBb_0
	mov r1, r1, lsr #0x10
	mov r2, #0
	bl ReadFileFromBundle
	mov r6, r0
	mov r0, #0x51
	bl GetObjectFileWork
	str r6, [r0]
_0218B0F4:
	mov r0, #0x51
	bl GetObjectFileWork
	mov r1, #0
	ldr ip, _0218B1A8 // =0x0000FFFF
	mov r3, r0
	mov r0, r4
	mov r2, r1
	stmia sp, {r1, ip}
	bl ObjObjectAction2dBACLoad
	ldr r2, _0218B1AC // =0x0000041F
	mov r0, r4
	mov r1, #0
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	mov r0, #0x80000
	str r0, [r4, #0x44]
	mov r0, #0x60000
	str r0, [r4, #0x48]
	mov r3, #0
	str r3, [sp]
	ldrh r4, [r5, #0x6a]
	ldr r2, _0218B1B0 // =SailDemoPlayer__DemoList
	ldr r1, _0218B1B4 // =padInput
	ldr r2, [r2, r4, lsl #4]
	mov r0, #2
	bl CreateReplayRecorderPad
	mov r3, #0
	str r3, [sp]
	ldrh r4, [r5, #0x6a]
	ldr r2, _0218B1B8 // =0x0218C910
	ldr r1, _0218B1BC // =touchInput
	ldr r2, [r2, r4, lsl #4]
	mov r0, #2
	bl CreateReplayRecorderTouch
	ldrh r1, [r5, #0x6a]
	ldr r0, _0218B1C0 // =0x0218C918
	ldr r0, [r0, r1, lsl #4]
	bl MultibootManager__Func_2063C60
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0218B19C: .word gameState
_0218B1A0: .word SailDemoPlayer__State_Playback
_0218B1A4: .word aBbGmDemoplayBb_0
_0218B1A8: .word 0x0000FFFF
_0218B1AC: .word 0x0000041F
_0218B1B0: .word SailDemoPlayer__DemoList
_0218B1B4: .word padInput
_0218B1B8: .word 0x0218C910
_0218B1BC: .word touchInput
_0218B1C0: .word 0x0218C918
	arm_func_end SailDemoPlayer__Create

	arm_func_start SailDemoPlayer__State_Playback
SailDemoPlayer__State_Playback: // 0x0218B1C4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x2c]
	ldr r4, _0218B310 // =gameState
	add r0, r0, #1
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	cmp r0, #0xa0
	movhi r0, #0
	strhi r0, [r5, #0x28]
	ldr r0, [r5, #0x20]
	bic r0, r0, #0x20
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x28]
	cmp r0, #0x3c
	bls _0218B214
	cmp r0, #0x50
	blo _0218B21C
_0218B214:
	cmp r0, #0x8c
	bls _0218B228
_0218B21C:
	ldr r0, [r5, #0x20]
	orr r0, r0, #0x20
	str r0, [r5, #0x20]
_0218B228:
	ldr r0, [r5, #0x28]
	cmp r0, #0
	bne _0218B240
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimation
_0218B240:
	ldr r0, [r5, #0x28]
	cmp r0, #0x50
	bne _0218B258
	mov r0, r5
	mov r1, #1
	bl StageTask__SetAnimation
_0218B258:
	ldr r0, [r5, #0x24]
	tst r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, _0218B314 // =0x04000130
	ldr r0, _0218B318 // =0x027FFFA8
	ldrh r3, [r1]
	ldrh r2, [r0]
	ldr r0, _0218B31C // =0x00002FFF
	ldr r1, _0218B320 // =0x00000C0B
	orr r2, r3, r2
	eor r2, r2, r0
	and r0, r2, r0
	mov r0, r0, lsl #0x10
	tst r1, r0, lsr #16
	bne _0218B2AC
	bl SailDemoPlayer__TouchCallback
	cmp r0, #0
	beq _0218B2D0
_0218B2AC:
	mov r0, #5
	bl RequestSysEventChange
	mov r0, #5
	mov r1, #0x4000
	bl CreateDrawFadeTask
	ldr r0, [r5, #0x24]
	orr r0, r0, #1
	str r0, [r5, #0x24]
	bl SailExitEvent__Create
_0218B2D0:
	ldrh r1, [r4, #0x6a]
	ldr r0, _0218B324 // =0x0218C914
	ldr r2, [r5, #0x2c]
	ldr r0, [r0, r1, lsl #4]
	cmp r2, r0
	ldmlsia sp!, {r3, r4, r5, pc}
	mov r0, #6
	bl RequestSysEventChange
	mov r0, #5
	mov r1, #0x1000
	bl CreateDrawFadeTask
	ldr r0, [r5, #0x24]
	orr r0, r0, #1
	str r0, [r5, #0x24]
	bl SailExitEvent__Create
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0218B310: .word gameState
_0218B314: .word 0x04000130
_0218B318: .word 0x027FFFA8
_0218B31C: .word 0x00002FFF
_0218B320: .word 0x00000C0B
_0218B324: .word 0x0218C914
	arm_func_end SailDemoPlayer__State_Playback

	arm_func_start SailDemoPlayer__TouchCallback
SailDemoPlayer__TouchCallback: // 0x0218B328
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	add r4, sp, #0
_0218B334:
	bl TP_RequestSamplingAsync
	mov r0, r4
	bl TP_WaitCalibratedResult
	cmp r0, #0
	bne _0218B334
	ldrh r0, [sp, #4]
	cmp r0, #1
	ldreqh r0, [sp, #6]
	cmpeq r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end SailDemoPlayer__TouchCallback

	.rodata

SailDemoPlayer__DemoList: // 0x0218C90C
	.word aKeydatPdShip00
	.word aKeydatTpShip00
	.word 1200
	.word 5

	.data

aKeydatPdShip00: // 0x0218D7E8
	.asciz "/keydat/pd_ship00.dat"
    .align 4

aKeydatTpShip00: // 0x0218D800
	.asciz "/keydat/tp_ship00.dat"
    .align 4

aBbGmDemoplayBb_0: // 0x0218D818
	.asciz "/bb/gm_demoplay.bb"
    .align 4
