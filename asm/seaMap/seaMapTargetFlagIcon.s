	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SeaMapTargetFlagIcon__Create
SeaMapTargetFlagIcon__Create: // 0x02048DE8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r4, r1
	bl SeaMapManager__GetWork
	bl SeaMapView__GetMode
	cmp r0, #2
	bne _02048E14
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_02048E14:
	bl SaveGame__Func_205D65C
	movs r6, r0
	mov r7, #0
	beq _02048E4C
_02048E24:
	mov r0, r7
	bl SaveGame__Func_205D758
	ldrsh r1, [r4, #0x10]
	cmp r1, r0
	beq _02048E4C
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	cmp r6, r0, lsr #16
	mov r7, r0, lsr #0x10
	bhi _02048E24
_02048E4C:
	cmp r7, r6
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _02048ECC // =0x00000111
	mov r2, #0
	str r0, [sp]
	mov r6, #1
	ldr r0, _02048ED0 // =SeaMapTargetFlagIcon__Main
	ldr r1, _02048ED4 // =SeaMapTargetFlagIcon__Destructor
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
_02048ECC: .word 0x00000111
_02048ED0: .word SeaMapTargetFlagIcon__Main
_02048ED4: .word SeaMapTargetFlagIcon__Destructor
	arm_func_end SeaMapTargetFlagIcon__Create

	arm_func_start SeaMapTargetFlagIcon__Main
SeaMapTargetFlagIcon__Main: // 0x02048ED8
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	ldr r1, [r5, #4]
	add r0, r5, #0xc
	add r1, r1, #4
	bl SeaMapEventManager__ObjectInBounds
	cmp r0, #0
	bne _02048F04
	bl DestroyCurrentTask
	ldmia sp!, {r3, r4, r5, pc}
_02048F04:
	bl SeaMapEventManager__GetWork
	mov r4, r0
	add r0, r5, #0xc
	add r1, r4, #0x1f8
	bl SeaMapEventManager__Func_20474FC
	add r0, r4, #0x1f0
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapTargetFlagIcon__Main

	arm_func_start SeaMapTargetFlagIcon__Destructor
SeaMapTargetFlagIcon__Destructor: // 0x02048F24
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl SeaMapEventManager__SetObjectAsInactive
	mov r0, r4
	bl SeaMapEventManager__DestroyObject
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapTargetFlagIcon__Destructor