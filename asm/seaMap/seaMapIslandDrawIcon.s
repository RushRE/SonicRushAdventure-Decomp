	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__VRAM_PALETTE_OBJ

	.text

	arm_func_start SeaMapIslandDrawIcon__CanDrawFrom
SeaMapIslandDrawIcon__CanDrawFrom: // 0x020477EC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x194]
	cmp r0, #4
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldrb r0, [r4, #7]
	tst r0, #0x80
	movne r0, #0
	ldmneia sp!, {r4, pc}
	bl SeaMapManager__GetWork
	ldr r1, [r0, #0x194]
	ldrb r2, [r4, #7]
	mov r0, #1
	tst r2, r0, lsl r1
	movne r0, #0
	ldmneia sp!, {r4, pc}
	ldrsh r1, [r4, #0x10]
	cmp r1, #0xe
	bgt _02047888
	cmp r1, #0
	addge pc, pc, r1, lsl #2
	b _02047890
_0204784C: // jump table
	b _02047894 // case 0
	b _02047898 // case 1
	b _020478AC // case 2
	b _020478C0 // case 3
	b _020478E8 // case 4
	b _02047924 // case 5
	b _02047890 // case 6
	b _020478FC // case 7
	b _02047910 // case 8
	b _02047890 // case 9
	b _02047890 // case 10
	b _02047938 // case 11
	b _0204794C // case 12
	b _02047890 // case 13
	b _020478D4 // case 14
_02047888:
	cmp r1, #0x20
	beq _02047960
_02047890:
	mov r0, #0
_02047894:
	ldmia sp!, {r4, pc}
_02047898:
	bl SaveGame__GetGameProgress
	cmp r0, #5
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
_020478AC:
	bl SaveGame__GetGameProgress
	cmp r0, #8
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
_020478C0:
	bl SaveGame__GetGameProgress
	cmp r0, #0x10
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
_020478D4:
	bl SaveGame__GetGameProgress
	cmp r0, #0x12
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
_020478E8:
	bl SaveGame__GetGameProgress
	cmp r0, #0x15
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
_020478FC:
	bl SaveGame__GetGameProgress
	cmp r0, #0x23
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
_02047910:
	bl SaveGame__GetGameProgress
	cmp r0, #0x24
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
_02047924:
	bl SaveGame__GetUnknownProgress1
	cmp r0, #4
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
_02047938:
	bl SaveGame__GetUnknownProgress2
	cmp r0, #6
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
_0204794C:
	bl SaveGame__GetUnknownProgress2
	cmp r0, #2
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
_02047960:
	ldr r0, _0204797C // =0x02134474
	mov r1, #0xd
	bl SaveGame__GetIslandProgress
	cmp r0, #2
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0204797C: .word 0x02134474
	arm_func_end SeaMapIslandDrawIcon__CanDrawFrom

	arm_func_start SeaMapIslandDrawIcon__Func_2047980
SeaMapIslandDrawIcon__Func_2047980: // 0x02047980
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #8]
	bl SeaMapIslandDrawIcon__CanDrawFrom
	cmp r0, #0
	movne r1, #0x2c
	ldrh r0, [r4, #0x1c]
	moveq r1, #0x29
	cmp r0, r1
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapIslandDrawIcon__Func_2047980

	arm_func_start SeaMapIslandDrawIcon__IsEnabled
SeaMapIslandDrawIcon__IsEnabled: // 0x020479B0
	stmdb sp!, {r3, lr}
	ldrsh r0, [r0, #0x10]
	cmp r0, #0x29
	addls pc, pc, r0, lsl #2
	b _02047DAC
_020479C4: // jump table
	b _02047A6C // case 0
	b _02047A74 // case 1
	b _02047AC4 // case 2
	b _02047A88 // case 3
	b _02047ADC // case 4
	b _02047AF4 // case 5
	b _02047A9C // case 6
	b _02047B0C // case 7
	b _02047AB0 // case 8
	b _02047DAC // case 9
	b _02047B24 // case 10
	b _02047B3C // case 11
	b _02047B54 // case 12
	b _02047DAC // case 13
	b _02047B6C // case 14
	b _02047B84 // case 15
	b _02047B9C // case 16
	b _02047BB4 // case 17
	b _02047DAC // case 18
	b _02047DAC // case 19
	b _02047DAC // case 20
	b _02047DAC // case 21
	b _02047BCC // case 22
	b _02047BE4 // case 23
	b _02047BFC // case 24
	b _02047C14 // case 25
	b _02047C2C // case 26
	b _02047C44 // case 27
	b _02047C5C // case 28
	b _02047C74 // case 29
	b _02047C8C // case 30
	b _02047CA4 // case 31
	b _02047CBC // case 32
	b _02047CD4 // case 33
	b _02047CEC // case 34
	b _02047D04 // case 35
	b _02047D1C // case 36
	b _02047D34 // case 37
	b _02047D4C // case 38
	b _02047D64 // case 39
	b _02047D7C // case 40
	b _02047D94 // case 41
_02047A6C:
	mov r0, #1
	ldmia sp!, {r3, pc}
_02047A74:
	bl SaveGame__GetGameProgress
	cmp r0, #3
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
_02047A88:
	bl SaveGame__GetGameProgress
	cmp r0, #0xe
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
_02047A9C:
	bl SaveGame__GetUnknownProgress2
	cmp r0, #4
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
_02047AB0:
	bl SaveGame__GetGameProgress
	cmp r0, #0x23
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
_02047AC4:
	mov r0, #2
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047ADC:
	mov r0, #4
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047AF4:
	mov r0, #5
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047B0C:
	mov r0, #7
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047B24:
	mov r0, #0xa
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047B3C:
	mov r0, #0xb
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047B54:
	mov r0, #0xc
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047B6C:
	mov r0, #0xe
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047B84:
	mov r0, #0xf
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047B9C:
	mov r0, #0x10
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047BB4:
	mov r0, #0x11
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047BCC:
	mov r0, #0x16
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047BE4:
	mov r0, #0x17
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047BFC:
	mov r0, #0x18
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047C14:
	mov r0, #0x19
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047C2C:
	mov r0, #0x1a
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047C44:
	mov r0, #0x1b
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047C5C:
	mov r0, #0x1c
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047C74:
	mov r0, #0x1d
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047C8C:
	mov r0, #0x1e
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047CA4:
	mov r0, #0x1f
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047CBC:
	mov r0, #0x20
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047CD4:
	mov r0, #0x21
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047CEC:
	mov r0, #0x22
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047D04:
	mov r0, #0x23
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047D1C:
	mov r0, #0x24
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047D34:
	mov r0, #0x25
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047D4C:
	mov r0, #0x26
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047D64:
	mov r0, #0x27
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047D7C:
	mov r0, #0x28
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047D94:
	mov r0, #0x29
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
_02047DAC:
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapIslandDrawIcon__IsEnabled

	arm_func_start SeaMapIslandDrawIcon__Create
SeaMapIslandDrawIcon__Create: // 0x02047DB4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x28
	mov r8, r1
	mov r9, r0
	bl SeaMapManager__GetWork
	ldrsh r1, [r8, #0x10]
	mov r5, r0
	cmp r1, #6
	beq _02047DF0
	mov r0, r8
	bl SeaMapEventManager__Func_204756C
	cmp r0, #0
	addeq sp, sp, #0x28
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02047DF0:
	mov r0, r8
	bl SeaMapIslandDrawIcon__IsEnabled
	cmp r0, #0
	addeq sp, sp, #0x28
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, _02047FA8 // =0x00000111
	mov r2, #0
	str r0, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #0xb4
	ldr r0, _02047FAC // =SeaMapIslandDrawIcon__Main
	ldr r1, _02047FB0 // =SeaMapIslandDrawIcon__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r6, r0
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0xb4
	bl MIi_CpuClear16
	mov r1, r6
	mov r0, r4
	mov r2, r9
	mov r3, r8
	bl SeaMapEventManager__InitMapObject
	mov r0, r8
	ldr r6, [r5, #0x15c]
	add r7, r4, #0x10
	bl SeaMapIslandDrawIcon__CanDrawFrom
	cmp r0, #0
	movne r0, #0x2a
	moveq r0, #0x27
	strh r0, [r7, #0xa2]
	mov r2, #0
_02047E88:
	ldrh r1, [r9, #2]
	add r0, r7, r2, lsl #1
	add r2, r2, #1
	strh r1, [r0, #0x9c]
	cmp r2, #3
	blo _02047E88
	ldrh r1, [r7, #0xa2]
	mov r0, r6
	bl GetSpriteButtonSpriteAllocSize
	mov r1, r0
	ldr r0, [r5, #0x158]
	bl VRAMSystem__AllocSpriteVram
	mov r1, r6
	ldr r2, [r5, #0x158]
	mov r6, #0
	stmia sp, {r2, r6}
	str r0, [sp, #8]
	str r6, [sp, #0xc]
	ldr r3, [r5, #0x158]
	ldr r0, _02047FB4 // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r2, #0xc
	ldr r3, [r0, r3, lsl #2]
	mov r0, r7
	str r3, [sp, #0x10]
	str r6, [sp, #0x14]
	str r2, [sp, #0x18]
	rsb r3, r2, #0x810
	ldrh r2, [r7, #0xa2]
	bl AnimatorSprite__Init
	ldrh r2, [r9, #2]
	mov r1, r6
	mov r0, r7
	strh r2, [r7, #0x50]
	ldrsh r3, [r8, #2]
	mov r2, r1
	strh r3, [r7, #8]
	ldrsh r3, [r8, #4]
	strh r3, [r7, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r7, #0x3c]
	mov r0, r7
	orr r1, r1, #0x10
	str r1, [r7, #0x3c]
	mov r1, r6
	add r2, sp, #0x20
	bl AnimatorSprite__GetBlockData
	ldrsh r3, [sp, #0x24]
	ldrsh r2, [sp, #0x20]
	ldr r1, _02047FB8 // =SeaMapIslandDrawIcon__Func_20480D0
	add r0, r7, #0x64
	sub r2, r3, r2
	mov r2, r2, asr #1
	mov r2, r2, lsl #0xc
	str r2, [sp, #0x1c]
	stmia sp, {r1, r4}
	ldr r2, _02047FBC // =TouchField__PointInCircle
	add r1, r7, #8
	add r3, sp, #0x1c
	bl TouchField__InitAreaShape
	add r0, r5, #0x13c
	add r1, r7, #0x64
	mov r2, #4
	bl TouchField__AddArea
	mov r1, r6
	mov r0, r7
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsActive
	mov r0, r4
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02047FA8: .word 0x00000111
_02047FAC: .word SeaMapIslandDrawIcon__Main
_02047FB0: .word SeaMapIslandDrawIcon__Destructor
_02047FB4: .word VRAMSystem__VRAM_PALETTE_OBJ
_02047FB8: .word SeaMapIslandDrawIcon__Func_20480D0
_02047FBC: .word TouchField__PointInCircle
	arm_func_end SeaMapIslandDrawIcon__Create

	arm_func_start SeaMapIslandDrawIcon__Main
SeaMapIslandDrawIcon__Main: // 0x02047FC0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x88]
	bic r0, r0, #0x40
	str r0, [r4, #0x88]
	bl SeaMapView__GetMode
	cmp r0, #3
	beq _02048000
	cmp r0, #4
	cmpne r0, #5
	ldreq r0, [r4, #0x88]
	orreq r0, r0, #0x40
	streq r0, [r4, #0x88]
	b _0204801C
_02048000:
	ldr r0, [r4, #8]
	bl SeaMapIslandDrawIcon__CanDrawFrom
	cmp r0, #0
	bne _0204801C
	ldr r0, [r4, #0x88]
	orr r0, r0, #0x40
	str r0, [r4, #0x88]
_0204801C:
	mov r0, r4
	bl SeaMapIslandDrawIcon__Func_2047980
	cmp r0, #0
	bne _02048050
	ldr r1, [r4, #4]
	add r0, r4, #0xc
	add r1, r1, #4
	bl SeaMapEventManager__ObjectInBounds
	cmp r0, #0
	bne _02048050
	bl DestroyCurrentTask
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
_02048050:
	add r1, sp, #0
	add r0, r4, #0xc
	bl SeaMapEventManager__Func_20474FC
	ldrsh r1, [sp]
	ldrsh r2, [sp, #2]
	add r0, r4, #0x10
	bl SetSpriteButtonPosition
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x10
	bl SeaMapEventManager__Func_20471B8
	add r0, r4, #0x10
	bl AnimatorSprite__DrawFrame
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end SeaMapIslandDrawIcon__Main

	arm_func_start SeaMapIslandDrawIcon__Destructor
SeaMapIslandDrawIcon__Destructor: // 0x0204808C
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x10
	bl AnimatorSprite__Release
	bl SeaMapManager__IsActive
	cmp r0, #0
	beq _020480BC
	bl SeaMapManager__GetWork
	add r0, r0, #0x13c
	add r1, r4, #0x74
	bl TouchField__RemoveArea
_020480BC:
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsInactive
	mov r0, r4
	bl SeaMapEventManager__DestroyObject
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapIslandDrawIcon__Destructor

	arm_func_start SeaMapIslandDrawIcon__Func_20480D0
SeaMapIslandDrawIcon__Func_20480D0: // 0x020480D0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	mov r7, r0
	mov r5, r2
	ldr r4, [r6, #0x14]
	bl SeaMapView__GetMode
	cmp r0, #3
	cmpne r0, #4
	ldr r0, [r7, #0]
	bne _02048148
	cmp r0, #0x400000
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	tst r4, #0x800
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	bl SeaMapView__GetMode
	cmp r0, #3
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	bl SeaMapEventManager__GetWork2
	mov r4, r0
	ldr r0, [r5, #8]
	bl SeaMapEventManager__GetObjectType
	str r0, [r4]
	add r0, r5, #0x10
	mov r1, #2
	str r5, [r4, #4]
	bl SetSpriteButtonState
	bl SeaMapView__GetTouchArea
	mov r1, r6
	bl TouchField__Func_206EAC4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02048148:
	cmp r0, #0x1000000
	bhi _02048170
	bhs _020481B4
	cmp r0, #0x40000
	bhi _02048164
	beq _020481DC
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02048164:
	cmp r0, #0x400000
	beq _0204818C
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02048170:
	cmp r0, #0x2000000
	bhi _02048180
	beq _0204818C
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02048180:
	cmp r0, #0x8000000
	beq _020481B4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0204818C:
	tst r4, #0x800
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r5
	bl SeaMapIslandDrawIcon__Func_2047980
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r5, #0x10
	mov r1, #1
	bl SetSpriteButtonState
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_020481B4:
	tst r4, #0x800
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r5
	bl SeaMapIslandDrawIcon__Func_2047980
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r5, #0x10
	mov r1, #0
	bl SetSpriteButtonState
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_020481DC:
	tst r4, #0x800
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	bl SeaMapEventManager__GetWork2
	mov r4, r0
	ldr r0, [r5, #8]
	bl SeaMapEventManager__GetObjectType
	stmia r4, {r0, r5}
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SeaMapIslandDrawIcon__Func_20480D0

	arm_func_start SeaMapIslandDrawIcon__Func_20481FC
SeaMapIslandDrawIcon__Func_20481FC: // 0x020481FC
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldrsh lr, [r1]
	ldrsh ip, [r0]
	add r2, sp, #0
	add r3, sp, #2
	add ip, lr, ip
	add ip, ip, #4
	bic ip, ip, #7
	strh ip, [sp]
	ldrsh lr, [r1, #2]
	ldrsh ip, [r0, #2]
	add ip, lr, ip
	add ip, ip, #4
	bic ip, ip, #7
	strh ip, [sp, #2]
	ldrsh lr, [r1, #4]
	ldrsh ip, [r0]
	add ip, lr, ip
	add ip, ip, #4
	bic ip, ip, #7
	strh ip, [sp, #4]
	ldrsh lr, [r1, #6]
	ldrsh ip, [r0, #2]
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	add ip, lr, ip
	add ip, ip, #4
	bic ip, ip, #7
	strh ip, [sp, #6]
	bl SeaMapManager__Func_2043BEC
	ldrh r0, [sp, #4]
	ldrh r1, [sp, #6]
	add r2, sp, #4
	add r3, sp, #6
	bl SeaMapManager__Func_2043BEC
	ldrh r2, [sp, #2]
	ldrh r1, [sp, #6]
	ldrh lr, [sp]
	ldrh ip, [sp, #4]
	add r0, r2, r1
	sub r2, r1, r2
	mov r0, r0, lsl #0xf
	mov r1, r0, lsr #0x10
	add r0, r2, #1
	mov r0, r0, lsl #0xf
	sub r2, ip, lr
	mov r3, r0, lsr #0x10
	add r0, lr, ip
	add r2, r2, #1
	mov r0, r0, lsl #0xf
	mov r2, r2, lsl #0xf
	mov r0, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	bl SeaMapManager__Func_20442C8
	mov r0, #1
	bl SeaMapManager__EnableDrawFlags
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapIslandDrawIcon__Func_20481FC

	arm_func_start SeaMapIslandDrawIcon__Func_20482E8
SeaMapIslandDrawIcon__Func_20482E8: // 0x020482E8
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldrsh lr, [r1]
	ldrsh ip, [r0]
	add r2, sp, #0
	add r3, sp, #2
	add ip, lr, ip
	add ip, ip, #4
	bic ip, ip, #7
	strh ip, [sp]
	ldrsh lr, [r1, #2]
	ldrsh ip, [r0, #2]
	add ip, lr, ip
	add ip, ip, #4
	bic ip, ip, #7
	strh ip, [sp, #2]
	ldrsh lr, [r1, #4]
	ldrsh ip, [r0]
	add ip, lr, ip
	add ip, ip, #4
	bic ip, ip, #7
	strh ip, [sp, #4]
	ldrsh lr, [r1, #6]
	ldrsh ip, [r0, #2]
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	add ip, lr, ip
	add ip, ip, #4
	bic ip, ip, #7
	strh ip, [sp, #6]
	bl SeaMapManager__Func_2043BEC
	ldrh r0, [sp, #4]
	ldrh r1, [sp, #6]
	add r2, sp, #4
	add r3, sp, #6
	bl SeaMapManager__Func_2043BEC
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	ldrh r2, [sp, #4]
	ldrh r3, [sp, #6]
	bl SeaMapManager__Func_2044268
	mov r0, #1
	bl SeaMapManager__EnableDrawFlags
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapIslandDrawIcon__Func_20482E8

	arm_func_start SeaMapIslandDrawIcon__Func_204839C
SeaMapIslandDrawIcon__Func_204839C: // 0x0204839C
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	mov r2, r0
	ldrsh r0, [r2, #0x10]
	cmp r0, #1
	blt _020483C0
	cmp r0, #9
	movle r0, #0xc
	ble _020483C4
_020483C0:
	mov r0, #0xd
_020483C4:
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	ldrsh r1, [r2, #2]
	ldrsh r2, [r2, #4]
	bl SeaMapEventManager__CreateObject
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapIslandDrawIcon__Func_204839C