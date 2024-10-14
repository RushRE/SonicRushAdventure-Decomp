	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public SeaMapUnknown204AB60__sVars
SeaMapUnknown204AB60__sVars: // 0x02134430
    .space 0x10

	.text

	arm_func_start SeaMapUnknown204AB60__Func_204AB60
SeaMapUnknown204AB60__Func_204AB60: // 0x0204AB60
	stmdb sp!, {r4, lr}
	ldr r0, _0204ABAC // =SeaMapUnknown204AB60__sVars
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0204AB84
	bl SeaMapUnknown204AB60__InitList
	ldr r0, _0204ABAC // =SeaMapUnknown204AB60__sVars
	mov r1, #1
	str r1, [r0]
_0204AB84:
	bl SeaMapUnknown204AB60__Func_204ABB0
	mov r4, #0
	bl SeaMapUnknown204AB60__Func_204AC04
_0204AB90:
	mov r1, r4
	add r4, r4, #0x4000
	mov r0, r4
	bl SeaMapUnknown204AB60__Func_204AC6C
	cmp r0, #0
	bne _0204AB90
	ldmia sp!, {r4, pc}
	.align 2, 0
_0204ABAC: .word SeaMapUnknown204AB60__sVars
	arm_func_end SeaMapUnknown204AB60__Func_204AB60

	arm_func_start SeaMapUnknown204AB60__Func_204ABB0
SeaMapUnknown204AB60__Func_204ABB0: // 0x0204ABB0
	ldr ip, _0204ABB8 // =SeaMapUnknown204AB60__RemoveAllObjects
	bx ip
	.align 2, 0
_0204ABB8: .word SeaMapUnknown204AB60__RemoveAllObjects
	arm_func_end SeaMapUnknown204AB60__Func_204ABB0

	arm_func_start SeaMapUnknown204AB60__Func_204ABBC
SeaMapUnknown204AB60__Func_204ABBC: // 0x0204ABBC
	ldr r0, _0204ABC8 // =SeaMapUnknown204AB60__sVars
	ldrh r0, [r0, #0xc]
	bx lr
	.align 2, 0
_0204ABC8: .word SeaMapUnknown204AB60__sVars
	arm_func_end SeaMapUnknown204AB60__Func_204ABBC

	arm_func_start SeaMapUnknown204AB60__Func_204ABCC
SeaMapUnknown204AB60__Func_204ABCC: // 0x0204ABCC
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, _0204AC00 // =0x02134434
	mov r5, r0
	mov r1, #0
_0204ABDC:
	mov r0, r4
	bl NNS_FndGetNextListObject
	sub r1, r5, #1
	mov r2, r1, lsl #0x10
	cmp r5, #0
	mov r1, r0
	mov r5, r2, lsr #0x10
	bne _0204ABDC
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0204AC00: .word 0x02134434
	arm_func_end SeaMapUnknown204AB60__Func_204ABCC

	arm_func_start SeaMapUnknown204AB60__Func_204AC04
SeaMapUnknown204AB60__Func_204AC04: // 0x0204AC04
	stmdb sp!, {lr}
	sub sp, sp, #0x1c
	add r1, sp, #0
	add r2, sp, #4
	mov r0, #0
	bl SeaMapManager__Func_2045BF8
	add r1, sp, #8
	mov r0, #0
	mov r2, #0x14
	bl MIi_CpuClear16
	mov r1, #0
	add r0, sp, #8
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	str r1, [sp, #0x10]
	bl SeaMapUnknown204AB60__AddObject
	ldr r1, [sp]
	ldr r2, [sp, #4]
	mov r0, #0
	bl SeaMapUnknown204AB60__AddObjectForAttr
	ldr r1, [sp]
	ldr r2, [sp, #4]
	mov r0, #0
	bl SeaMapUnknown204AB60__AddObjectForLV
	add sp, sp, #0x1c
	ldmia sp!, {pc}
	arm_func_end SeaMapUnknown204AB60__Func_204AC04

	arm_func_start SeaMapUnknown204AB60__Func_204AC6C
SeaMapUnknown204AB60__Func_204AC6C: // 0x0204AC6C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x18
	mov r4, r1
	add r1, sp, #0x10
	add r2, sp, #0x14
	mov r5, r0
	bl SeaMapManager__Func_2045BF8
	add r1, sp, #8
	add r2, sp, #0xc
	mov r0, r4
	bl SeaMapManager__Func_2045BF8
	ldr r1, [sp, #8]
	mov r0, r5
	str r1, [sp]
	ldr r1, [sp, #0xc]
	mov r3, r4
	str r1, [sp, #4]
	ldr r1, [sp, #0x10]
	ldr r2, [sp, #0x14]
	bl SeaMapUnknown204AB60__Func_204AD10
	cmp r0, #0
	addne sp, sp, #0x18
	movne r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov r0, r5
	bl SeaMapUnknown204AB60__AddObjectForAttr
	ldr r1, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov r0, r5
	bl SeaMapUnknown204AB60__AddObjectForLV
	ldr r1, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov r0, r5
	bl SeaMapUnknown204AB60__Func_204B038
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapUnknown204AB60__Func_204AC6C

	arm_func_start SeaMapUnknown204AB60__Func_204AD10
SeaMapUnknown204AB60__Func_204AD10: // 0x0204AD10
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x2c
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl SeaMapManager__GetTotalDistance
	mov r4, r0
	cmp r8, r4
	blt _0204AD90
	mov r0, r8
	mov r1, r7
	mov r2, r6
	bl SeaMapUnknown204AB60__Func_204AE28
	cmp r0, #0
	addne sp, sp, #0x2c
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, pc}
	add r1, sp, #0x18
	mov r0, #0
	mov r2, #0x14
	bl MIi_CpuClear16
	mov r2, #1
	mov r1, #0
	add r0, sp, #0x18
	str r4, [sp, #0x18]
	str r2, [sp, #0x1c]
	str r1, [sp, #0x20]
	bl SeaMapUnknown204AB60__AddObject
	add sp, sp, #0x2c
	mov r0, #1
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
_0204AD90:
	add r2, sp, #0x14
	add r3, sp, #0x16
	mov r0, r7
	mov r1, r6
	bl SeaMapManager__Func_2043B60
	ldr r0, [sp, #0x48]
	ldr r1, [sp, #0x4c]
	add r2, sp, #0x10
	add r3, sp, #0x12
	bl SeaMapManager__Func_2043B60
	mov r0, #0
	str r0, [sp]
	add r1, sp, #0xc
	add r0, sp, #0xe
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldrh r0, [sp, #0x14]
	ldrh r1, [sp, #0x16]
	ldrh r2, [sp, #0x10]
	ldrh r3, [sp, #0x12]
	bl SeaMapCollision__HandleCollisions
	cmp r0, #0
	addeq sp, sp, #0x2c
	mov r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	add r1, sp, #0x18
	mov r2, #0x14
	bl MIi_CpuClear16
	mov r2, #1
	mov r1, #2
	add r0, sp, #0x18
	str r5, [sp, #0x18]
	str r2, [sp, #0x1c]
	str r1, [sp, #0x20]
	bl SeaMapUnknown204AB60__AddObject
	mov r0, #1
	add sp, sp, #0x2c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	arm_func_end SeaMapUnknown204AB60__Func_204AD10

	arm_func_start SeaMapUnknown204AB60__Func_204AE28
SeaMapUnknown204AB60__Func_204AE28: // 0x0204AE28
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	str r0, [sp]
	mov r5, r1
	mov r4, r2
	bl SeaMapManager__GetWork
	ldr r7, [r0, #0x160]
	mov r8, #0
	ldrh r0, [r7, #0]
	cmp r0, #0
	bls _0204B028
	add r11, r7, #2
	add r6, sp, #4
_0204AE5C:
	mov r0, #0x12
	mla r9, r8, r0, r11
	mov r0, r9
	bl SeaMapEventManager__GetObjectType
	ldr r1, _0204B034 // =SeaMapEventManager__ObjectList
	add r10, r1, r0, lsl #4
	ldr ip, [r10, #0xc]
	cmp ip, #0
	beq _0204B010
	sub r0, r0, #2
	cmp r0, #1
	bhi _0204B010
	ldrb r0, [r9, #7]
	tst r0, #1
	beq _0204AF0C
	ldrsh r0, [r9, #0x10]
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	beq _0204B010
	ldr r10, [r10, #0xc]
	mov r0, r9
	mov r1, r5
	mov r2, r4
	mov r3, #1
	blx r10
	cmp r0, #0
	beq _0204B010
	add r1, sp, #4
	mov r0, #0
	mov r2, #0x14
	bl MIi_CpuClear16
	mov r1, #1
	ldr r0, [sp]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	str r0, [sp, #4]
	ldrsh r0, [r9, #0x10]
	bl SeaMapEventManager__Func_2046CE8
	str r0, [sp, #0x10]
	add r0, sp, #4
	bl SeaMapUnknown204AB60__AddObject
	add sp, sp, #0x18
	mov r0, #1
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204AF0C:
	ldrsh r0, [r9, #0x10]
	mov r10, #0
	cmp r0, #3
	beq _0204AF30
	cmp r0, #0xe
	beq _0204AF6C
	cmp r0, #0x28
	beq _0204AFA8
	b _0204AFE0
_0204AF30:
	mov r0, r9
	mov r1, r5
	mov r2, r4
	mov r3, #1
	blx ip
	cmp r0, #0
	beq _0204AFE0
	mov r0, r10
	mov r1, r6
	mov r2, #0x14
	bl MIi_CpuClear16
	mov r0, #1
	str r0, [sp, #0x10]
	mov r10, r0
	b _0204AFE0
_0204AF6C:
	mov r0, r9
	mov r1, r5
	mov r2, r4
	mov r3, #1
	blx ip
	cmp r0, #0
	beq _0204AFE0
	mov r0, r10
	mov r1, r6
	mov r2, #0x14
	bl MIi_CpuClear16
	mov r0, #3
	str r0, [sp, #0x10]
	mov r10, #1
	b _0204AFE0
_0204AFA8:
	mov r0, r9
	mov r1, r5
	mov r2, r4
	mov r3, #1
	blx ip
	cmp r0, #0
	beq _0204AFE0
	mov r0, r10
	mov r1, r6
	mov r2, #0x14
	bl MIi_CpuClear16
	mov r0, #8
	str r0, [sp, #0x10]
	mov r10, #1
_0204AFE0:
	cmp r10, #0
	beq _0204B010
	ldr r1, [sp]
	mov r2, #1
	add r0, sp, #4
	str r1, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	bl SeaMapUnknown204AB60__AddObject
	add sp, sp, #0x18
	mov r0, #1
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204B010:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	ldrh r1, [r7, #0]
	cmp r1, r0, lsr #16
	bhi _0204AE5C
_0204B028:
	mov r0, #0
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204B034: .word SeaMapEventManager__ObjectList
	arm_func_end SeaMapUnknown204AB60__Func_204AE28

	arm_func_start SeaMapUnknown204AB60__Func_204B038
SeaMapUnknown204AB60__Func_204B038: // 0x0204B038
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	mov r11, r0
	mov r10, r1
	mov r9, r2
	bl SeaMapManager__GetWork
	ldr r4, [r0, #0x160]
	mov r5, #0
	ldrh r0, [r4, #0]
	cmp r0, #0
	bls _0204B198
	add r0, r4, #2
	str r0, [sp]
_0204B06C:
	ldr r0, [sp]
	mov r1, #0x12
	mla r6, r5, r1, r0
	mov r0, r6
	bl SeaMapEventManager__GetObjectType
	ldr r1, _0204B1A4 // =SeaMapEventManager__ObjectList
	add r7, r1, r0, lsl #4
	ldr ip, [r7, #0xc]
	cmp ip, #0
	beq _0204B180
	sub r1, r0, #2
	cmp r1, #1
	bhi _0204B108
	ldrb r0, [r6, #7]
	tst r0, #1
	beq _0204B180
	mov r0, r6
	mov r1, r10
	mov r2, r9
	mov r3, #0
	blx ip
	cmp r0, #0
	beq _0204B180
	add r1, sp, #4
	mov r0, #0
	mov r2, #0x14
	bl MIi_CpuClear16
	mov r0, #1
	str r11, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	ldrsh r0, [r6, #0x10]
	bl SeaMapEventManager__Func_2046CE8
	str r0, [sp, #0x10]
	add r0, sp, #4
	bl SeaMapUnknown204AB60__AddObject
	add sp, sp, #0x18
	mov r0, #1
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204B108:
	cmp r0, #4
	beq _0204B11C
	cmp r0, #5
	moveq r8, #1
	b _0204B120
_0204B11C:
	mov r8, #0
_0204B120:
	mov r0, r8
	mov r1, r6
	bl SeaMapUnknown204AB60__FindObject2
	cmp r0, #0
	bne _0204B180
	ldr r7, [r7, #0xc]
	mov r0, r6
	mov r1, r10
	mov r2, r9
	mov r3, #0
	blx r7
	cmp r0, #0
	beq _0204B180
	mov r0, #0
	add r1, sp, #4
	mov r2, #0x14
	bl MIi_CpuClear16
	mov r0, #4
	str r0, [sp, #8]
	add r0, sp, #4
	str r6, [sp, #0x10]
	str r11, [sp, #4]
	str r8, [sp, #0xc]
	bl SeaMapUnknown204AB60__AddObject
_0204B180:
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	ldrh r1, [r4, #0]
	cmp r1, r0, lsr #16
	bhi _0204B06C
_0204B198:
	mov r0, #0
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204B1A4: .word SeaMapEventManager__ObjectList
	arm_func_end SeaMapUnknown204AB60__Func_204B038

	arm_func_start SeaMapUnknown204AB60__AddObjectForAttr
SeaMapUnknown204AB60__AddObjectForAttr: // 0x0204B1A8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r5, r0
	mov r0, r1
	mov r1, r2
	bl SeaMapManager__GetAttribute
	mov r4, r0
	mov r0, #2
	bl SeaMapUnknown204AB60__FindObject
	cmp r0, #0
	beq _0204B1E0
	ldr r0, [r0, #0x10]
	cmp r0, r4
	beq _0204B214
_0204B1E0:
	add r1, sp, #0
	mov r0, #0
	mov r2, #0x14
	bl MIi_CpuClear16
	mov r1, #2
	add r0, sp, #0
	str r5, [sp]
	str r1, [sp, #4]
	str r4, [sp, #8]
	bl SeaMapUnknown204AB60__AddObject
	add sp, sp, #0x14
	mov r0, #1
	ldmia sp!, {r4, r5, pc}
_0204B214:
	mov r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	arm_func_end SeaMapUnknown204AB60__AddObjectForAttr

	arm_func_start SeaMapUnknown204AB60__AddObjectForLV
SeaMapUnknown204AB60__AddObjectForLV: // 0x0204B220
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r5, r0
	mov r0, r1
	mov r1, r2
	bl SeaMapManager__GetCHLV
	mov r4, r0
	mov r0, #3
	bl SeaMapUnknown204AB60__FindObject
	cmp r0, #0
	beq _0204B258
	ldr r0, [r0, #0x10]
	cmp r0, r4
	beq _0204B28C
_0204B258:
	add r1, sp, #0
	mov r0, #0
	mov r2, #0x14
	bl MIi_CpuClear16
	mov r1, #3
	add r0, sp, #0
	str r5, [sp]
	str r1, [sp, #4]
	str r4, [sp, #8]
	bl SeaMapUnknown204AB60__AddObject
	add sp, sp, #0x14
	mov r0, #1
	ldmia sp!, {r4, r5, pc}
_0204B28C:
	mov r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	arm_func_end SeaMapUnknown204AB60__AddObjectForLV

	arm_func_start SeaMapUnknown204AB60__InitList
SeaMapUnknown204AB60__InitList: // 0x0204B298
	ldr ip, _0204B2A8 // =NNS_FndInitList
	ldr r0, _0204B2AC // =0x02134434
	mov r1, #0
	bx ip
	.align 2, 0
_0204B2A8: .word NNS_FndInitList
_0204B2AC: .word 0x02134434
	arm_func_end SeaMapUnknown204AB60__InitList

	arm_func_start SeaMapUnknown204AB60__AddObject
SeaMapUnknown204AB60__AddObject: // 0x0204B2B0
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _0204B300 // =SeaMapUnknown204AB60__sVars
	mov r6, r0
	ldrh r0, [r1, #0xc]
	ldr r4, _0204B304 // =0x02134434
	cmp r0, #0x100
	ldrhs r5, [r4, #4]
	bhs _0204B2E8
	mov r0, #0x1c
	bl _AllocTailHEAP_SYSTEM
	mov r5, r0
	mov r0, r4
	mov r1, r5
	bl NNS_FndAppendListObject
_0204B2E8:
	mov r0, r6
	add r1, r5, #8
	mov r2, #0x14
	bl MIi_CpuCopy16
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0204B300: .word SeaMapUnknown204AB60__sVars
_0204B304: .word 0x02134434
	arm_func_end SeaMapUnknown204AB60__AddObject

	arm_func_start SeaMapUnknown204AB60__RemoveAllObjects
SeaMapUnknown204AB60__RemoveAllObjects: // 0x0204B308
	stmdb sp!, {r3, r4, r5, lr}
	ldr r0, _0204B344 // =SeaMapUnknown204AB60__sVars
	ldr r4, _0204B348 // =0x02134434
	ldr r5, [r0, #4]
	cmp r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
_0204B320:
	mov r0, r4
	mov r1, r5
	bl NNS_FndRemoveListObject
	mov r0, r5
	bl _FreeHEAP_SYSTEM
	ldr r5, [r4, #0]
	cmp r5, #0
	bne _0204B320
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0204B344: .word SeaMapUnknown204AB60__sVars
_0204B348: .word 0x02134434
	arm_func_end SeaMapUnknown204AB60__RemoveAllObjects

	arm_func_start SeaMapUnknown204AB60__FindObject
SeaMapUnknown204AB60__FindObject: // 0x0204B34C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0204B38C // =SeaMapUnknown204AB60__sVars
	mov r5, r0
	ldr r1, [r1, #8]
	ldr r4, _0204B390 // =0x02134434
	cmp r1, #0
	beq _0204B384
_0204B368:
	ldr r0, [r1, #0xc]
	cmp r5, r0
	beq _0204B384
	mov r0, r4
	bl NNS_FndGetPrevListObject
	movs r1, r0
	bne _0204B368
_0204B384:
	mov r0, r1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0204B38C: .word SeaMapUnknown204AB60__sVars
_0204B390: .word 0x02134434
	arm_func_end SeaMapUnknown204AB60__FindObject

	arm_func_start SeaMapUnknown204AB60__FindObject2
SeaMapUnknown204AB60__FindObject2: // 0x0204B394
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, _0204B3E8 // =SeaMapUnknown204AB60__sVars
	mov r5, r1
	ldr r1, [r2, #8]
	mov r6, r0
	cmp r1, #0
	ldr r4, _0204B3EC // =0x02134434
	beq _0204B3E0
_0204B3B4:
	ldr r0, [r1, #0xc]
	cmp r0, #4
	ldreq r0, [r1, #0x10]
	cmpeq r0, r6
	ldreq r0, [r1, #0x14]
	cmpeq r0, r5
	beq _0204B3E0
	mov r0, r4
	bl NNS_FndGetPrevListObject
	movs r1, r0
	bne _0204B3B4
_0204B3E0:
	mov r0, r1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0204B3E8: .word SeaMapUnknown204AB60__sVars
_0204B3EC: .word 0x02134434
	arm_func_end SeaMapUnknown204AB60__FindObject2

	arm_func_start SeaMapManager__GetAttribute
SeaMapManager__GetAttribute: // 0x0204B3F0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl SeaMapManager__GetWork
	ldr ip, [r0, #0x164]
	mov r0, r4, asr #0xc
	mov r1, r0, lsl #0xd
	mov r0, r5, asr #0xc
	mov r0, r0, lsl #0xd
	mov r3, r0, lsr #0x10
	ldrh r2, [ip]
	mov r1, r1, lsr #0x10
	tst r3, #1
	mov r0, r2, asr #1
	mul r0, r1, r0
	add r1, ip, #4
	add r0, r0, r3, asr #1
	ldrb r0, [r1, r0]
	movne r0, r0, lsl #0x18
	moveq r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManager__GetAttribute

	arm_func_start SeaMapManager__GetCHLV
SeaMapManager__GetCHLV: // 0x0204B448
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl SeaMapManager__GetWork
	ldr lr, [r0, #0x168]
	mov r0, r4, asr #0xc
	mov r1, r0, lsl #0xd
	mov r0, r5, asr #0xc
	mov r0, r0, lsl #0xd
	mov ip, r0, lsr #0x10
	and r0, ip, #3
	ldrh r2, [lr]
	mov r3, r1, lsr #0x10
	cmp r0, #3
	mov r1, r2, asr #2
	mul r1, r3, r1
	add r2, lr, #4
	add r1, r1, ip, asr #2
	addls pc, pc, r0, lsl #2
	b _0204B4E8
_0204B498: // jump table
	b _0204B4A8 // case 0
	b _0204B4B8 // case 1
	b _0204B4C8 // case 2
	b _0204B4D8 // case 3
_0204B4A8:
	ldrb r0, [r2, r1]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1e
	ldmia sp!, {r3, r4, r5, pc}
_0204B4B8:
	ldrb r0, [r2, r1]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1e
	ldmia sp!, {r3, r4, r5, pc}
_0204B4C8:
	ldrb r0, [r2, r1]
	mov r0, r0, lsl #0x1a
	mov r0, r0, lsr #0x1e
	ldmia sp!, {r3, r4, r5, pc}
_0204B4D8:
	ldrb r0, [r2, r1]
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1e
	ldmia sp!, {r3, r4, r5, pc}
_0204B4E8:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManager__GetCHLV

	arm_func_start SeaMapUnknown204AB60__Func_204B4F0
SeaMapUnknown204AB60__Func_204B4F0: // 0x0204B4F0
	ldr ip, _0204B510 // =SeaMapCourseChangeView__stru_2134440
	ldr r3, _0204B514 // =0x02134184
	stmia ip, {r0, r1}
	ldr r1, [r3, #0]
	ldr r0, _0204B518 // =SeaMapCourseChangeView__02134174
	str r2, [r3]
	str r1, [r0]
	bx lr
	.align 2, 0
_0204B510: .word SeaMapCourseChangeView__stru_2134440
_0204B514: .word 0x02134184
_0204B518: .word SeaMapCourseChangeView__02134174
	arm_func_end SeaMapUnknown204AB60__Func_204B4F0
