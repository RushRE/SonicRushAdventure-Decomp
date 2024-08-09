	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SeaMapUnknown5__Create
SeaMapUnknown5__Create: // 0x02048C4C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r6, r1
	mov r7, r0
	bl SeaMapManager__GetWork
	ldrsh r0, [r6, #0x10]
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _02048CE8 // =0x00000111
	mov r2, #0
	str r0, [sp]
	mov r4, #1
	ldr r0, _02048CEC // =SeaMapUnknown5__Main
	ldr r1, _02048CF0 // =SeaMapUnknown5__Destructor
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0x10
	str r4, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r1, r5
	mov r2, r7
	mov r3, r6
	mov r0, r4
	bl SeaMapEventManager__InitMapObject
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsActive
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02048CE8: .word 0x00000111
_02048CEC: .word SeaMapUnknown5__Main
_02048CF0: .word SeaMapUnknown5__Destructor
	arm_func_end SeaMapUnknown5__Create

	arm_func_start SeaMapUnknown5__Main
SeaMapUnknown5__Main: // 0x02048CF4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	bl GetCurrentTaskWork_
	mov r2, r0
	ldr r1, [r2, #4]
	add r0, r2, #0xc
	add r1, r1, #4
	ldr r4, [r2, #8]
	bl SeaMapEventManager__ObjectInBounds
	cmp r0, #0
	bne _02048D2C
	bl DestroyCurrentTask
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}
_02048D2C:
	ldrsh r1, [r4, #2]
	ldrsh r2, [r4, #4]
	add r3, sp, #0x10
	add r0, r4, #8
	bl SeaMapEventManager__GetViewRect
	add r0, sp, #8
	add r1, sp, #0xc
	bl SailSeaMapView__GetPosition
	arm_func_end SeaMapUnknown5__Main

	arm_func_start SeaMapUnknown5__Func_2048D4C
SeaMapUnknown5__Func_2048D4C: // 0x02048D4C
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
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, pc}
	mov r1, r4
	mov r0, #6
	mov r2, #0
	bl SeaMapUnknown204A9E4__RunCallbacks
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapUnknown5__Func_2048D4C

	arm_func_start SeaMapUnknown5__Destructor
SeaMapUnknown5__Destructor: // 0x02048D94
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl SeaMapEventManager__SetObjectAsInactive
	mov r0, r4
	bl SeaMapEventManager__DestroyObject
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapUnknown5__Destructor

	arm_func_start SeaMapUnknown5__ViewCheck
SeaMapUnknown5__ViewCheck: // 0x02048DB0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrsh r0, [r6, #0x10]
	mov r5, r1
	mov r4, r2
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl SeaMapEventManager__ViewRectCheck2
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SeaMapUnknown5__ViewCheck