	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SeaMapJohnnyIcon__Create
SeaMapJohnnyIcon__Create: // 0x02048A1C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r4, r1
	mov r5, r0
	bl SeaMapManager__GetWork
	ldrb r0, [r4, #7]
	tst r0, #1
	beq _02048A54
	bl SaveGame__GetGameProgress
	cmp r0, #0xc
	blt _02048A68
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_02048A54:
	bl SaveGame__GetGameProgress
	cmp r0, #0xc
	addlt sp, sp, #0xc
	movlt r0, #0
	ldmltia sp!, {r4, r5, r6, r7, pc}
_02048A68:
	ldr r0, _02048AD8 // =0x00000111
	mov r2, #0
	str r0, [sp]
	mov r6, #1
	ldr r0, _02048ADC // =SeaMapJohnnyIcon__Main
	ldr r1, _02048AE0 // =SeaMapJohnnyIcon__Destructor
	mov r3, r2
	str r6, [sp, #4]
	mov r6, #0x10
	str r6, [sp, #8]
	bl TaskCreate_
	mov r7, r0
	bl GetTaskWork_
	mov r6, r0
	mov r1, r6
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r5
	mov r3, r4
	mov r0, r6
	bl SeaMapEventManager__InitMapObject
	mov r0, r6
	bl SeaMapEventManager__SetObjectAsActive
	mov r0, r6
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02048AD8: .word 0x00000111
_02048ADC: .word SeaMapJohnnyIcon__Main
_02048AE0: .word SeaMapJohnnyIcon__Destructor
	arm_func_end SeaMapJohnnyIcon__Create

	arm_func_start SeaMapJohnnyIcon__Main
SeaMapJohnnyIcon__Main: // 0x02048AE4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x20
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #4]
	add r0, r4, #0xc
	add r1, r1, #4
	ldr r5, [r4, #8]
	bl SeaMapEventManager__ObjectInBounds
	cmp r0, #0
	bne _02048B1C
	bl DestroyCurrentTask
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, pc}
_02048B1C:
	bl SeaMapView__GetMode
	cmp r0, #5
	bne _02048B84
	ldrsh r1, [r5, #2]
	ldrsh r2, [r5, #4]
	add r3, sp, #0x10
	add r0, r5, #8
	bl SeaMapEventManager__GetViewRect
	add r0, sp, #8
	add r1, sp, #0xc
	bl SailSeaMapView__GetPosition
	ldr r0, [sp, #8]
	str r0, [sp]
	ldr r0, [sp, #0xc]
	str r0, [sp, #4]
	ldr r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r2, [sp, #0x18]
	ldr r3, [sp, #0x1c]
	bl SeaMapEventManager__PointInViewRect
	cmp r0, #0
	beq _02048B84
	mov r1, r5
	mov r0, #5
	mov r2, #0
	bl SeaMapUnknown204A9E4__RunCallbacks
_02048B84:
	mov r0, r5
	bl SeaMapEventManager__Func_204756C
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r3, r4, r5, pc}
	bl SeaMapEventManager__GetWork
	ldrsh r0, [r5, #0x10]
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	beq _02048BB8
	bl SeaMapEventManager__GetWork
	add r5, r0, #0x18c
	b _02048BC0
_02048BB8:
	bl SeaMapEventManager__GetWork
	add r5, r0, #0x128
_02048BC0:
	add r0, r4, #0xc
	add r1, r5, #8
	bl SeaMapEventManager__Func_20474FC
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapJohnnyIcon__Main

	arm_func_start SeaMapJohnnyIcon__Destructor
SeaMapJohnnyIcon__Destructor: // 0x02048BDC
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl SeaMapEventManager__SetObjectAsInactive
	mov r0, r4
	bl SeaMapEventManager__DestroyObject
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapJohnnyIcon__Destructor

	arm_func_start SeaMapJohnnyIcon__ViewCheck
SeaMapJohnnyIcon__ViewCheck: // 0x02048BF8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrb r0, [r6, #7]
	mov r5, r1
	mov r4, r2
	tst r0, #1
	beq _02048C28
	bl SaveGame__GetGameProgress
	cmp r0, #0xc
	blt _02048C38
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02048C28:
	bl SaveGame__GetGameProgress
	cmp r0, #0xc
	movlt r0, #0
	ldmltia sp!, {r4, r5, r6, pc}
_02048C38:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl SeaMapEventManager__ViewRectCheck2
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SeaMapJohnnyIcon__ViewCheck