	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__VRAM_PALETTE_OBJ

	.text

	arm_func_start SeaMapDSPopup__Create
SeaMapDSPopup__Create: // 0x0204953C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x1c
	mov r7, r0
	mov r6, r1
	bl SeaMapManager__GetWork
	ldr r1, _02049650 // =0x00000111
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #0x78
	ldr r0, _02049654 // =SeaMapDSPopup__Main
	ldr r1, _02049658 // =SeaMapDSPopup__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r8, r0
	bl SeaMapEventManager__GetWork
	str r8, [r0, #0x254]
	mov r0, r8
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x78
	bl MIi_CpuClear16
	mov r1, r8
	mov r0, r4
	mov r2, r7
	mov r3, r6
	bl SeaMapEventManager__InitMapObject
	mov r0, #0x180
	str r0, [r4, #0x10]
	bl GetSpriteButtonTouchpadSprite
	mov r8, r0
	bl GetSpriteButtonTouchpadSprite
	ldrh r1, [r7, #0]
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	ldr r0, [r5, #0x158]
	bl VRAMSystem__AllocSpriteVram
	ldr r2, [r5, #0x158]
	mov ip, #0
	stmia sp, {r2, ip}
	str r0, [sp, #8]
	str ip, [sp, #0xc]
	ldr r3, [r5, #0x158]
	ldr r2, _0204965C // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, r8
	ldr r2, [r2, r3, lsl #2]
	add r0, r4, #0x14
	str r2, [sp, #0x10]
	str ip, [sp, #0x14]
	str ip, [sp, #0x18]
	ldrh r2, [r7, #0]
	mov r3, #4
	bl AnimatorSprite__Init
	ldrsh r1, [r6, #2]
	mov r0, r4
	strh r1, [r4, #0x1c]
	ldrsh r1, [r6, #4]
	strh r1, [r4, #0x1e]
	ldrh r1, [r7, #2]
	strh r1, [r4, #0x64]
	bl SeaMapEventManager__SetObjectAsActive
	mov r0, r4
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02049650: .word 0x00000111
_02049654: .word SeaMapDSPopup__Main
_02049658: .word SeaMapDSPopup__Destructor
_0204965C: .word VRAMSystem__VRAM_PALETTE_OBJ
	arm_func_end SeaMapDSPopup__Create

	arm_func_start SeaMapDSPopup__Main
SeaMapDSPopup__Main: // 0x02049660
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	mov r4, r0
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02049690
	ldr r0, _02049704 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	movne r0, #0
	strne r0, [r4, #0x10]
_02049690:
	ldr r1, [r4, #0x10]
	ldr r0, _02049708 // =0x0000017B
	cmp r1, r0
	bne _020496C4
	mov r0, #0
	sub r1, r0, #1
	mov ip, #2
	mov r2, r1
	mov r3, r1
	str ip, [sp]
	mov ip, #8
	str ip, [sp, #4]
	bl PlaySfxEx
_020496C4:
	ldr r1, [r4, #0x10]
	sub r0, r1, #1
	str r0, [r4, #0x10]
	cmp r1, #0
	beq _020496F8
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x14
	bl SeaMapEventManager__Func_20471B8
	add r0, r4, #0x14
	bl AnimatorSprite__DrawFrame
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_020496F8:
	bl DestroyCurrentTask
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02049704: .word touchInput
_02049708: .word 0x0000017B
	arm_func_end SeaMapDSPopup__Main

	arm_func_start SeaMapDSPopup__Destructor
SeaMapDSPopup__Destructor: // 0x0204970C
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	mov r0, #2
	mov r1, #8
	mov r2, #0
	bl NNS_SndPlayerStopSeqBySeqArcIdx
	add r0, r4, #0x14
	bl AnimatorSprite__Release
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsInactive
	mov r0, r4
	bl SeaMapEventManager__DestroyObject
	ldr r0, _02049760 // =SeaMapEventManager__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl SeaMapEventManager__GetWork
	mov r1, #0
	str r1, [r0, #0x254]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02049760: .word SeaMapEventManager__Singleton
	arm_func_end SeaMapDSPopup__Destructor