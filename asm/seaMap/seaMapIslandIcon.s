	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SeaMapIslandIcon__Create
SeaMapIslandIcon__Create: // 0x020483E4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x1c
	mov r4, r1
	mov r5, r0
	add r1, sp, #0xc
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	add r0, sp, #0xc
	mov r2, r5
	mov r3, r4
	mov r1, #0
	bl SeaMapEventManager__InitMapObject
	ldrb r0, [r4, #7]
	tst r0, #1
	bne _02048490
	mov r0, r4
	bl SeaMapIslandIcon__Func_2048824
	cmp r0, #0
	beq _02048444
	mov r1, r4
	mov r0, #1
	mov r2, #0
	bl SeaMapUnknown204A9E4__RunCallbacks
_02048444:
	ldrsh r0, [r4, #0x10]
	bl SeaMapIslandIcon__IsEnabled
	cmp r0, #0
	addeq sp, sp, #0x1c
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldrh r0, [r4, #0]
	add r1, r4, #8
	cmp r0, #2
	add r0, r4, #2
	bne _02048478
	bl SeaMapIslandDrawIcon__Func_20481FC
	b _0204847C
_02048478:
	bl SeaMapIslandDrawIcon__Func_20482E8
_0204847C:
	add r0, sp, #0xc
	bl SeaMapEventManager__SetObjectAsActive
	add sp, sp, #0x1c
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_02048490:
	ldrsh r0, [r4, #0x10]
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	bne _02048594
	bl SeaMapView__GetMode
	cmp r0, #3
	cmpne r0, #4
	beq _020484EC
	cmp r0, #5
	bne _02048520
	ldr r0, _020485C8 // =0x00000111
	mov r2, #0
	str r0, [sp]
	mov ip, #1
	ldr r0, _020485CC // =SeaMapIslandIcon__Main1
	ldr r1, _020485D0 // =SeaMapIslandIcon__Destructor1
	mov r3, r2
	str ip, [sp, #4]
	mov ip, #0x18
	str ip, [sp, #8]
	bl TaskCreate_
	mov r6, r0
	b _02048534
_020484EC:
	ldr r0, _020485C8 // =0x00000111
	mov r2, #0
	str r0, [sp]
	mov ip, #1
	ldr r0, _020485D4 // =SeaMapIslandIcon__Main2
	ldr r1, _020485D0 // =SeaMapIslandIcon__Destructor1
	mov r3, r2
	str ip, [sp, #4]
	mov ip, #0x18
	str ip, [sp, #8]
	bl TaskCreate_
	mov r6, r0
	b _02048534
_02048520:
	add r0, sp, #0xc
	bl SeaMapEventManager__SetObjectAsActive
	add sp, sp, #0x1c
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_02048534:
	mov r0, r6
	bl GetTaskWork_
	mov r7, r0
	mov r1, r7
	mov r0, #0
	mov r2, #0x18
	bl MIi_CpuClear16
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl SeaMapEventManager__InitMapObject
	bl SeaMapView__GetMode
	cmp r0, #5
	bne _02048580
	ldr r0, _020485D8 // =SeaMapIslandIcon__Destructor2
	mov r1, r7
	bl SeaMapUnknown204A9E4__AddObject
	str r0, [r7, #0x14]
_02048580:
	mov r0, r7
	bl SeaMapEventManager__SetObjectAsActive
	add sp, sp, #0x1c
	mov r0, r7
	ldmia sp!, {r4, r5, r6, r7, pc}
_02048594:
	ldrh r0, [r4, #0]
	add r1, r4, #8
	cmp r0, #2
	add r0, r4, #2
	bne _020485B0
	bl SeaMapIslandDrawIcon__Func_20481FC
	b _020485B4
_020485B0:
	bl SeaMapIslandDrawIcon__Func_20482E8
_020485B4:
	add r0, sp, #0xc
	bl SeaMapEventManager__SetObjectAsActive
	mov r0, #0
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020485C8: .word 0x00000111
_020485CC: .word SeaMapIslandIcon__Main1
_020485D0: .word SeaMapIslandIcon__Destructor1
_020485D4: .word SeaMapIslandIcon__Main2
_020485D8: .word SeaMapIslandIcon__Destructor2
	arm_func_end SeaMapIslandIcon__Create

	arm_func_start SeaMapIslandIcon__Destructor2
SeaMapIslandIcon__Destructor2: // 0x020485DC
	stmdb sp!, {r4, lr}
	mov r4, r1
	cmp r0, #7
	ldmneia sp!, {r4, pc}
	mov r0, r2
	bl SeaMapEventManager__Func_2046EEC
	ldr r1, [r4, #8]
	ldrsh r1, [r1, #0x10]
	cmp r0, r1
	moveq r0, #1
	streq r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapIslandIcon__Destructor2

	arm_func_start SeaMapIslandIcon__Main1
SeaMapIslandIcon__Main1: // 0x0204860C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x34
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #4]
	add r0, r4, #0xc
	add r1, r1, #4
	ldr r5, [r4, #8]
	bl SeaMapEventManager__ObjectInBounds
	cmp r0, #0
	bne _0204864C
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsInactive
	bl DestroyCurrentTask
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, pc}
_0204864C:
	add r0, sp, #0x1c
	add r1, sp, #0x20
	bl SailSeaMapView__GetPosition
	ldr r0, [r4, #8]
	bl SeaMapEventManager__GetObjectType
	cmp r0, #2
	bne _02048710
	add r0, sp, #0x18
	str r0, [sp]
	add r1, sp, #0xc
	add r0, sp, #0x10
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldrsh r1, [r5, #2]
	ldrsh r2, [r5, #4]
	add r3, sp, #0x14
	add r0, r5, #8
	bl SeaMapEventManager__GetViewRect2
	ldr r0, [sp, #0x1c]
	str r0, [sp]
	ldr r0, [sp, #0x20]
	str r0, [sp, #4]
	ldr r0, [sp, #0x14]
	ldr r1, [sp, #0x18]
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #0x10]
	bl SeaMapEventManager__PointInViewRect2
	cmp r0, #0
	addeq sp, sp, #0x34
	ldmeqia sp!, {r4, r5, pc}
	mov r1, r5
	mov r0, #2
	mov r2, #0
	bl SeaMapUnknown204A9E4__RunCallbacks
	ldr r0, [r4, #0x10]
	cmp r0, #0
	addeq sp, sp, #0x34
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r5
	bl SeaMapIslandDrawIcon__Func_204839C
	add r0, r5, #2
	add r1, r5, #8
	bl SeaMapIslandDrawIcon__Func_20481FC
	ldrsh r0, [r5, #0x10]
	mov r1, #1
	bl SeaMapManager__SetSaveFlag
	bl DestroyCurrentTask
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, pc}
_02048710:
	ldrsh r1, [r5, #2]
	ldrsh r2, [r5, #4]
	add r3, sp, #0x24
	add r0, r5, #8
	bl SeaMapEventManager__GetViewRect
	ldr r0, [sp, #0x1c]
	str r0, [sp]
	ldr r0, [sp, #0x20]
	str r0, [sp, #4]
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x30]
	bl SeaMapEventManager__PointInViewRect
	cmp r0, #0
	addeq sp, sp, #0x34
	ldmeqia sp!, {r4, r5, pc}
	mov r1, r5
	mov r0, #2
	mov r2, #0
	bl SeaMapUnknown204A9E4__RunCallbacks
	ldr r0, [r4, #0x10]
	cmp r0, #0
	addeq sp, sp, #0x34
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r5
	bl SeaMapIslandDrawIcon__Func_204839C
	add r0, r5, #2
	add r1, r5, #8
	bl SeaMapIslandDrawIcon__Func_20482E8
	ldrsh r0, [r5, #0x10]
	mov r1, #1
	bl SeaMapManager__SetSaveFlag
	bl DestroyCurrentTask
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, pc}
	arm_func_end SeaMapIslandIcon__Main1

	arm_func_start SeaMapIslandIcon__Main2
SeaMapIslandIcon__Main2: // 0x020487A0
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #4]
	add r0, r4, #0xc
	add r1, r1, #4
	ldr r5, [r4, #8]
	bl SeaMapEventManager__ObjectInBounds
	cmp r0, #0
	bne _020487D8
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsInactive
	bl DestroyCurrentTask
	ldmia sp!, {r3, r4, r5, pc}
_020487D8:
	mov r0, r5
	bl SeaMapIslandIcon__Func_2048824
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r1, r5
	mov r0, #1
	mov r2, #0
	bl SeaMapUnknown204A9E4__RunCallbacks
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapIslandIcon__Main2

	arm_func_start SeaMapIslandIcon__Destructor1
SeaMapIslandIcon__Destructor1: // 0x020487FC
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x14]
	cmp r0, #0
	beq _02048818
	bl SeaMapUnknown204A9E4__RemoveObject
_02048818:
	mov r0, r4
	bl SeaMapEventManager__DestroyObject
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapIslandIcon__Destructor1

	arm_func_start SeaMapIslandIcon__Func_2048824
SeaMapIslandIcon__Func_2048824: // 0x02048824
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x3c
	mov r4, r0
	bl SeaMapEventManager__GetObjectType
	cmp r0, #2
	bne _020488D8
	add r0, sp, #0x28
	str r0, [sp]
	add r1, sp, #0x1c
	add r0, sp, #0x20
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldrsh r1, [r4, #2]
	ldrsh r2, [r4, #4]
	add r3, sp, #0x24
	add r0, r4, #8
	bl SeaMapEventManager__GetViewRect2
	bl SeaMapManager__GetStartNode
	movs r6, r0
	beq _02048958
	add r5, sp, #0x14
	add r4, sp, #0x18
_0204887C:
	ldrh r0, [r6, #8]
	ldrh r1, [r6, #0xa]
	mov r2, r5
	mov r3, r4
	bl SeaMapManager__Func_2043B44
	ldr r0, [sp, #0x14]
	str r0, [sp]
	ldr r0, [sp, #0x18]
	str r0, [sp, #4]
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x1c]
	ldr r3, [sp, #0x20]
	bl SeaMapEventManager__PointInViewRect2
	cmp r0, #0
	addne sp, sp, #0x3c
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, pc}
	mov r0, r6
	bl SeaMapManager__GetNextNode
	movs r6, r0
	bne _0204887C
	b _02048958
_020488D8:
	ldrsh r1, [r4, #2]
	ldrsh r2, [r4, #4]
	add r3, sp, #0x2c
	add r0, r4, #8
	bl SeaMapEventManager__GetViewRect
	bl SeaMapManager__GetStartNode
	movs r6, r0
	beq _02048958
	add r5, sp, #0xc
	add r4, sp, #0x10
_02048900:
	ldrh r0, [r6, #8]
	ldrh r1, [r6, #0xa]
	mov r2, r5
	mov r3, r4
	bl SeaMapManager__Func_2043B44
	ldr r0, [sp, #0xc]
	str r0, [sp]
	ldr r0, [sp, #0x10]
	str r0, [sp, #4]
	ldr r0, [sp, #0x2c]
	ldr r1, [sp, #0x30]
	ldr r2, [sp, #0x34]
	ldr r3, [sp, #0x38]
	bl SeaMapEventManager__PointInViewRect
	cmp r0, #0
	addne sp, sp, #0x3c
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, pc}
	mov r0, r6
	bl SeaMapManager__GetNextNode
	movs r6, r0
	bne _02048900
_02048958:
	mov r0, #0
	add sp, sp, #0x3c
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end SeaMapIslandIcon__Func_2048824

	arm_func_start SeaMapIslandIcon__ViewCheck
SeaMapIslandIcon__ViewCheck: // 0x02048964
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrb r0, [r6, #7]
	mov r5, r1
	mov r4, r2
	tst r0, #1
	beq _020489C8
	cmp r3, #0
	bne _02048998
	ldrsh r0, [r6, #0x10]
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	bne _02048A10
_02048998:
	mov r0, r6
	bl SeaMapEventManager__GetObjectType
	cmp r0, #2
	mov r0, r6
	mov r1, r5
	bne _020489BC
	mov r2, r4
	bl SeaMapEventManager__ViewRectCheck2
	ldmia sp!, {r4, r5, r6, pc}
_020489BC:
	mov r2, r4
	bl SeaMapEventManager__ViewRectCheck
	ldmia sp!, {r4, r5, r6, pc}
_020489C8:
	bl SaveGame__GetGameProgress
	ldrsh r2, [r6, #0x10]
	ldr r1, _02048A18 // =0x02110048
	ldr r1, [r1, r2, lsl #2]
	cmp r1, r0
	bgt _02048A10
	mov r0, r6
	bl SeaMapEventManager__GetObjectType
	cmp r0, #2
	mov r0, r6
	mov r1, r5
	bne _02048A04
	mov r2, r4
	bl SeaMapEventManager__ViewRectCheck2
	ldmia sp!, {r4, r5, r6, pc}
_02048A04:
	mov r2, r4
	bl SeaMapEventManager__ViewRectCheck
	ldmia sp!, {r4, r5, r6, pc}
_02048A10:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02048A18: .word 0x02110048
	arm_func_end SeaMapIslandIcon__ViewCheck