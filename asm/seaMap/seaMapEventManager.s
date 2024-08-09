	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__VRAM_PALETTE_OBJ

	.text

	arm_func_start SeaMapEventManager__CheckFeatureUnlocked
SeaMapEventManager__CheckFeatureUnlocked: // 0x020466CC
	stmdb sp!, {r3, lr}
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _02046700
_020466DC: // jump table
	b _02046710 // case 0
	b _02046718 // case 1
	b _02046700 // case 2
	b _0204672C // case 3
	b _02046700 // case 4
	b _02046700 // case 5
	b _02046740 // case 6
	b _02046700 // case 7
	b _02046754 // case 8
_02046700:
	ldr r1, _02046768 // =0x0210FFA0
	ldr r0, [r1, r0, lsl #2]
	bl SeaMapManager__GetSaveFlag
	ldmia sp!, {r3, pc}
_02046710:
	mov r0, #1
	ldmia sp!, {r3, pc}
_02046718:
	bl SaveGame__GetGameProgress
	cmp r0, #3
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
_0204672C:
	bl SaveGame__GetGameProgress
	cmp r0, #0xe
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
_02046740:
	bl SaveGame__GetUnknownProgress2
	cmp r0, #4
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
_02046754:
	bl SaveGame__GetGameProgress
	cmp r0, #0x23
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02046768: .word 0x0210FFA0
	arm_func_end SeaMapEventManager__CheckFeatureUnlocked

	arm_func_start SeaMapEventManager__Create
SeaMapEventManager__Create: // 0x0204676C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x1c
	mov r0, #0x110
	mov r2, #0
	str r0, [sp]
	ldr r0, _02046968 // =SeaMapEventManager__SpawnObjects2
	ldr r1, _0204696C // =SeaMapEventManager__Func_20473C0
	mov r3, r2
	str r2, [sp, #4]
	mov r4, #0x260
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _02046970 // =0x0213419C
	str r0, [r1]
	bl GetTaskWork_
	mov r5, r0
	mov r1, r5
	mov r0, #0
	mov r2, r4
	bl MIi_CpuClear16
	bl SeaMapEventManager__Func_2046A78
	ldr r0, _02046974 // =0x0000FFFF
	mov r2, r5
	mov r1, #0
_020467CC:
	add r1, r1, #1
	strh r0, [r2, #8]
	cmp r1, #0x10
	add r2, r2, #0x12
	blt _020467CC
	bl SeaMapManager__GetWork
	mov r4, r0
	ldr r0, [r4, #0x15c]
	mov r1, #0x89
	add r6, r5, #0x128
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	ldr r0, [r4, #0x158]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r4, #0x158]
	mov r3, #0
	stmia sp, {r1, r3}
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, [r4, #0x158]
	ldr r0, _02046978 // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #0xc
	ldr r2, [r0, r2, lsl #2]
	mov r0, r6
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [r4, #0x15c]
	mov r2, #0x89
	mov r3, #0x800
	bl AnimatorSprite__Init
	mov r0, #6
	mov r1, #0
	strh r0, [r6, #0x50]
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r4, #0x15c]
	mov r1, #0x8a
	add r6, r5, #0x18c
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	ldr r0, [r4, #0x158]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r4, #0x158]
	mov r3, #0
	stmia sp, {r1, r3}
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, [r4, #0x158]
	ldr r0, _02046978 // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #0xc
	ldr r2, [r0, r2, lsl #2]
	mov r0, r6
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [r4, #0x15c]
	mov r2, #0x8a
	mov r3, #0x800
	bl AnimatorSprite__Init
	mov r0, #6
	mov r1, #0
	strh r0, [r6, #0x50]
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r4, #0x15c]
	mov r1, #0x8b
	add r5, r5, #0x1f0
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	ldr r0, [r4, #0x158]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r4, #0x158]
	mov r3, #0
	stmia sp, {r1, r3}
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r1, [r4, #0x158]
	ldr r0, _02046978 // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r2, #0xc
	ldr r1, [r0, r1, lsl #2]
	mov r0, r5
	str r1, [sp, #0x10]
	str r3, [sp, #0x14]
	str r2, [sp, #0x18]
	rsb r3, r2, #0x810
	ldr r1, [r4, #0x15c]
	mov r2, #0x8b
	bl AnimatorSprite__Init
	mov r3, #4
	mov r1, #0
	mov r0, r5
	mov r2, r1
	strh r3, [r5, #0x50]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r5, #0x3c]
	orr r0, r0, #0x10
	str r0, [r5, #0x3c]
	bl SeaMapEventManager__SpawnObjects1
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02046968: .word SeaMapEventManager__SpawnObjects2
_0204696C: .word SeaMapEventManager__Func_20473C0
_02046970: .word 0x0213419C
_02046974: .word 0x0000FFFF
_02046978: .word VRAMSystem__VRAM_PALETTE_OBJ
	arm_func_end SeaMapEventManager__Create

	arm_func_start SeaMapEventManager__Destroy
SeaMapEventManager__Destroy: // 0x0204697C
	stmdb sp!, {r3, lr}
	ldr r0, _020469A8 // =0x0213419C
	ldr r0, [r0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	mov r0, #1
	bl ClearTaskScope
	ldr r0, _020469A8 // =0x0213419C
	ldr r0, [r0]
	bl DestroyTask
	ldmia sp!, {r3, pc}
	.align 2, 0
_020469A8: .word 0x0213419C
	arm_func_end SeaMapEventManager__Destroy

	arm_func_start SeaMapEventManager__CreateObject
SeaMapEventManager__CreateObject: // 0x020469AC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	mov sb, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	bl SeaMapEventManager__GetWork
	ldr r1, _02046A64 // =SeaMapEventManager__ObjectList
	mov r5, #0
	add r4, r1, sb, lsl #4
	ldr r1, _02046A68 // =0x0000FFFF
	mov r3, r5
	mov ip, r0
_020469DC:
	ldrh r2, [ip, #8]
	cmp r2, r1
	bne _020469F8
	add r1, r0, #8
	mov r0, #0x12
	mla r5, r3, r0, r1
	b _02046A08
_020469F8:
	add r3, r3, #1
	cmp r3, #0x10
	add ip, ip, #0x12
	blt _020469DC
_02046A08:
	mov r1, r5
	mov r0, #0
	mov r2, #0x12
	bl MIi_CpuClear16
	strh sb, [r5]
	strh r8, [r5, #2]
	ldr r0, [sp, #0x20]
	strh r7, [r5, #4]
	mov r1, #0x80
	strb r1, [r5, #6]
	strb r6, [r5, #7]
	cmp r0, #0
	beq _02046A48
	add r1, r5, #8
	mov r2, #8
	bl MIi_CpuCopy16
_02046A48:
	ldrsh r2, [sp, #0x24]
	mov r0, r4
	mov r1, r5
	strh r2, [r5, #0x10]
	ldr r2, [r4, #8]
	blx r2
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_02046A64: .word SeaMapEventManager__ObjectList
_02046A68: .word 0x0000FFFF
	arm_func_end SeaMapEventManager__CreateObject

	arm_func_start SeaMapEventManager__GetWork2
SeaMapEventManager__GetWork2: // 0x02046A6C
	ldr ip, _02046A74 // =SeaMapEventManager__GetWork
	bx ip
	.align 2, 0
_02046A74: .word SeaMapEventManager__GetWork
	arm_func_end SeaMapEventManager__GetWork2

	arm_func_start SeaMapEventManager__Func_2046A78
SeaMapEventManager__Func_2046A78: // 0x02046A78
	stmdb sp!, {r3, lr}
	bl SeaMapEventManager__GetWork2
	mvn r1, #0
	str r1, [r0]
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapEventManager__Func_2046A78

	arm_func_start SeaMapEventManager__Func_2046A94
SeaMapEventManager__Func_2046A94: // 0x02046A94
	ldr ip, _02046AA4 // =SetSpriteButtonState
	add r0, r0, #0x10
	mov r1, #0
	bx ip
	.align 2, 0
_02046AA4: .word SetSpriteButtonState
	arm_func_end SeaMapEventManager__Func_2046A94

	arm_func_start SeaMapEventManager__GetObjectFromID
SeaMapEventManager__GetObjectFromID: // 0x02046AA8
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl SeaMapManager__GetWork
	ldr r2, [r0, #0x160]
	mov r0, #0x12
	ldrh r1, [r2]
	add r3, r2, #2
	mov lr, #0
	mul r0, r1, r0
	ldrh r5, [r3, r0]
	add ip, r3, r0
	cmp r5, #0
	bls _02046B0C
	mov r1, #0x12
_02046AE0:
	add r0, ip, lr, lsl #1
	ldrh r2, [r0, #2]
	mla r0, r2, r1, r3
	ldrsh r2, [r0, #0x10]
	cmp r2, r4
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, lr, #1
	mov r0, r0, lsl #0x10
	cmp r5, r0, lsr #16
	mov lr, r0, lsr #0x10
	bhi _02046AE0
_02046B0C:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapEventManager__GetObjectFromID

	arm_func_start SeaMapEventManager__Func_2046B14
SeaMapEventManager__Func_2046B14: // 0x02046B14
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x10
	str r0, [sp]
	str r1, [sp, #4]
	str r2, [sp, #8]
	mov r5, r3
	ldr r4, [sp, #0x38]
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x160]
	mov r8, #0
	strh r8, [r4]
	ldrh r2, [r0], #2
	mov r1, #0x12
	str r0, [sp, #0xc]
	mul r3, r2, r1
	ldrh r1, [r0, r3]
	add r7, r0, r3
	cmp r1, #0
	addls sp, sp, #0x10
	ldmlsia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr fp, _02046CC0 // =0x00000F5E
	ldr r6, _02046CC4 // =0x0000065D
_02046B6C:
	add r0, r7, r8, lsl #1
	ldrh r2, [r0, #2]
	ldr r0, [sp, #0xc]
	mov r1, #0x12
	mla sb, r2, r1, r0
	ldrsh r0, [sb, #0x10]
	cmp r0, #3
	beq _02046B98
	cmp r0, #6
	beq _02046CA0
	b _02046BA8
_02046B98:
	mov r0, #3
	bl SeaMapManager__GetSaveFlag
	cmp r0, #0
	beq _02046CA0
_02046BA8:
	ldrsh r1, [sb, #4]
	ldr r0, [sp, #4]
	ldrsh r2, [sb, #2]
	rsb r1, r0, r1, lsl #12
	ldr r0, [sp]
	rsbs r0, r0, r2, lsl #12
	rsbmi r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r0, r1
	mov r2, #0
	ble _02046C24
	umull lr, ip, r0, fp
	mla ip, r0, r2, ip
	mov sl, r0, asr #0x1f
	mov r0, #0x800
	adds r2, lr, r0
	mla ip, sl, fp, ip
	mov r0, #0
	adc r0, ip, r0
	mov sl, r2, lsr #0xc
	orr sl, sl, r0, lsl #20
	umull r2, r0, r1, r6
	mov ip, #0
	mla r0, r1, ip, r0
	mov r3, r1, asr #0x1f
	mla r0, r3, r6, r0
	mov r1, ip
	adds r2, r2, #0x800
	adc r0, r0, r1
	b _02046C68
_02046C24:
	umull sl, lr, r1, fp
	mla lr, r1, r2, lr
	mov ip, r1, asr #0x1f
	mla lr, ip, fp, lr
	adds r2, sl, #0x800
	adc r1, lr, #0
	mov sl, r2, lsr #0xc
	orr sl, sl, r1, lsl #20
	mov ip, #0
	umull r2, r1, r0, r6
	mla r1, r0, ip, r1
	mov r3, r0, asr #0x1f
	mov r0, #0x800
	adds r2, r2, r0
	mla r1, r3, r6, r1
	mov r0, ip
	adc r0, r1, r0
_02046C68:
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	ldr r0, [sp, #8]
	add r1, sl, r1
	cmp r1, r0
	bgt _02046CA0
	ldrh r0, [r4]
	str sb, [r5, r0, lsl #3]
	ldrh r0, [r4]
	add r0, r5, r0, lsl #3
	str r1, [r0, #4]
	ldrh r0, [r4]
	add r0, r0, #1
	strh r0, [r4]
_02046CA0:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	ldrh r1, [r7]
	cmp r1, r0, lsr #16
	bhi _02046B6C
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02046CC0: .word 0x00000F5E
_02046CC4: .word 0x0000065D
	arm_func_end SeaMapEventManager__Func_2046B14

	arm_func_start SeaMapEventManager__GetObjectType
SeaMapEventManager__GetObjectType: // 0x02046CC8
	ldrh r0, [r0]
	bic r0, r0, #0x8000
	bx lr
	arm_func_end SeaMapEventManager__GetObjectType

	arm_func_start SeaMapEventManager__ObjectIsActive
SeaMapEventManager__ObjectIsActive: // 0x02046CD4
	ldrh r0, [r0]
	tst r0, #0x8000
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end SeaMapEventManager__ObjectIsActive

	arm_func_start SeaMapEventManager__Func_2046CE8
SeaMapEventManager__Func_2046CE8: // 0x02046CE8
	cmp r0, #0x29
	addls pc, pc, r0, lsl #2
	b _02046D9C
_02046CF4: // jump table
	b _02046D9C // case 0
	b _02046DA4 // case 1
	b _02046DAC // case 2
	b _02046DB4 // case 3
	b _02046DBC // case 4
	b _02046DC4 // case 5
	b _02046DCC // case 6
	b _02046DD4 // case 7
	b _02046DDC // case 8
	b _02046DE4 // case 9
	b _02046DEC // case 10
	b _02046DF4 // case 11
	b _02046DFC // case 12
	b _02046E04 // case 13
	b _02046E0C // case 14
	b _02046E14 // case 15
	b _02046E1C // case 16
	b _02046E24 // case 17
	b _02046E2C // case 18
	b _02046E34 // case 19
	b _02046E3C // case 20
	b _02046E44 // case 21
	b _02046E4C // case 22
	b _02046E54 // case 23
	b _02046E5C // case 24
	b _02046E64 // case 25
	b _02046E6C // case 26
	b _02046E74 // case 27
	b _02046E7C // case 28
	b _02046E84 // case 29
	b _02046E8C // case 30
	b _02046E94 // case 31
	b _02046E9C // case 32
	b _02046EA4 // case 33
	b _02046EAC // case 34
	b _02046EB4 // case 35
	b _02046EBC // case 36
	b _02046EC4 // case 37
	b _02046ECC // case 38
	b _02046ED4 // case 39
	b _02046EDC // case 40
	b _02046EE4 // case 41
_02046D9C:
	mov r0, #0
	bx lr
_02046DA4:
	mov r0, #1
	bx lr
_02046DAC:
	mov r0, #2
	bx lr
_02046DB4:
	mov r0, #3
	bx lr
_02046DBC:
	mov r0, #4
	bx lr
_02046DC4:
	mov r0, #5
	bx lr
_02046DCC:
	mov r0, #6
	bx lr
_02046DD4:
	mov r0, #7
	bx lr
_02046DDC:
	mov r0, #8
	bx lr
_02046DE4:
	mov r0, #9
	bx lr
_02046DEC:
	mov r0, #0xa
	bx lr
_02046DF4:
	mov r0, #0xb
	bx lr
_02046DFC:
	mov r0, #0xc
	bx lr
_02046E04:
	mov r0, #0xd
	bx lr
_02046E0C:
	mov r0, #0xe
	bx lr
_02046E14:
	mov r0, #0xf
	bx lr
_02046E1C:
	mov r0, #0x10
	bx lr
_02046E24:
	mov r0, #0x11
	bx lr
_02046E2C:
	mov r0, #0x12
	bx lr
_02046E34:
	mov r0, #0x13
	bx lr
_02046E3C:
	mov r0, #0x14
	bx lr
_02046E44:
	mov r0, #0x15
	bx lr
_02046E4C:
	mov r0, #0x16
	bx lr
_02046E54:
	mov r0, #0x17
	bx lr
_02046E5C:
	mov r0, #0x18
	bx lr
_02046E64:
	mov r0, #0x19
	bx lr
_02046E6C:
	mov r0, #0x1a
	bx lr
_02046E74:
	mov r0, #0x1b
	bx lr
_02046E7C:
	mov r0, #0x1c
	bx lr
_02046E84:
	mov r0, #0x1d
	bx lr
_02046E8C:
	mov r0, #0x1e
	bx lr
_02046E94:
	mov r0, #0x1f
	bx lr
_02046E9C:
	mov r0, #0x20
	bx lr
_02046EA4:
	mov r0, #0x21
	bx lr
_02046EAC:
	mov r0, #0x22
	bx lr
_02046EB4:
	mov r0, #0x23
	bx lr
_02046EBC:
	mov r0, #0x24
	bx lr
_02046EC4:
	mov r0, #0x25
	bx lr
_02046ECC:
	mov r0, #0x26
	bx lr
_02046ED4:
	mov r0, #0x27
	bx lr
_02046EDC:
	mov r0, #0x28
	bx lr
_02046EE4:
	mov r0, #0x29
	bx lr
	arm_func_end SeaMapEventManager__Func_2046CE8

	arm_func_start SeaMapEventManager__Func_2046EEC
SeaMapEventManager__Func_2046EEC: // 0x02046EEC
	cmp r0, #0x20
	addls pc, pc, r0, lsl #2
	b _02046F7C
_02046EF8: // jump table
	b _02046F7C // case 0
	b _02046F84 // case 1
	b _02046F8C // case 2
	b _02046F94 // case 3
	b _02046F9C // case 4
	b _02046FA4 // case 5
	b _02046FAC // case 6
	b _02046FB4 // case 7
	b _02046FBC // case 8
	b _02046FC4 // case 9
	b _02046FCC // case 10
	b _02046FD4 // case 11
	b _02046FDC // case 12
	b _02046FE4 // case 13
	b _02046FEC // case 14
	b _02046FF4 // case 15
	b _02046FFC // case 16
	b _02047004 // case 17
	b _02046F7C // case 18
	b _02046F7C // case 19
	b _02046F7C // case 20
	b _02046F7C // case 21
	b _0204700C // case 22
	b _02047014 // case 23
	b _0204701C // case 24
	b _02047024 // case 25
	b _0204702C // case 26
	b _02047034 // case 27
	b _0204703C // case 28
	b _02047044 // case 29
	b _0204704C // case 30
	b _02047054 // case 31
	b _0204705C // case 32
_02046F7C:
	mov r0, #0
	bx lr
_02046F84:
	mov r0, #1
	bx lr
_02046F8C:
	mov r0, #2
	bx lr
_02046F94:
	mov r0, #3
	bx lr
_02046F9C:
	mov r0, #4
	bx lr
_02046FA4:
	mov r0, #5
	bx lr
_02046FAC:
	mov r0, #6
	bx lr
_02046FB4:
	mov r0, #7
	bx lr
_02046FBC:
	mov r0, #8
	bx lr
_02046FC4:
	mov r0, #9
	bx lr
_02046FCC:
	mov r0, #0xa
	bx lr
_02046FD4:
	mov r0, #0xb
	bx lr
_02046FDC:
	mov r0, #0xc
	bx lr
_02046FE4:
	mov r0, #0xd
	bx lr
_02046FEC:
	mov r0, #0xe
	bx lr
_02046FF4:
	mov r0, #0xf
	bx lr
_02046FFC:
	mov r0, #0x10
	bx lr
_02047004:
	mov r0, #0x11
	bx lr
_0204700C:
	mov r0, #0x16
	bx lr
_02047014:
	mov r0, #0x17
	bx lr
_0204701C:
	mov r0, #0x18
	bx lr
_02047024:
	mov r0, #0x19
	bx lr
_0204702C:
	mov r0, #0x1a
	bx lr
_02047034:
	mov r0, #0x1b
	bx lr
_0204703C:
	mov r0, #0x1c
	bx lr
_02047044:
	mov r0, #0x1d
	bx lr
_0204704C:
	mov r0, #0x1e
	bx lr
_02047054:
	mov r0, #0x1f
	bx lr
_0204705C:
	mov r0, #0x20
	bx lr
	arm_func_end SeaMapEventManager__Func_2046EEC

	arm_func_start SeaMapEventManager__Func_2047064
SeaMapEventManager__Func_2047064: // 0x02047064
	cmp r1, #0
	ldr r1, [r0, #0x4c]
	bicne r1, r1, #0x80
	orreq r1, r1, #0x80
	str r1, [r0, #0x4c]
	bx lr
	arm_func_end SeaMapEventManager__Func_2047064

	arm_func_start SeaMapEventManager__CreateStylusIcon
SeaMapEventManager__CreateStylusIcon: // 0x0204707C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r6, r1
	mov r1, #0
	str r1, [sp]
	mov r7, r0
	mov r5, r2
	mov r4, r3
	mov r2, r1
	mov r3, r1
	str r1, [sp, #4]
	mov r0, #0xa
	bl SeaMapEventManager__CreateObject
	str r7, [r0, #0x78]
	str r6, [r0, #0x7c]
	str r5, [r0, #0x80]
	ldrsh r1, [sp, #0x20]
	str r4, [r0, #0x84]
	strh r1, [r0, #0x88]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SeaMapEventManager__CreateStylusIcon

	arm_func_start SeaMapEventManager__DestroyStylusIcon
SeaMapEventManager__DestroyStylusIcon: // 0x020470D0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl DestroyTask
	mov r0, #0
	str r0, [r4]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapEventManager__DestroyStylusIcon

	arm_func_start SeaMapEventManager__CreateDSPopup
SeaMapEventManager__CreateDSPopup: // 0x020470F4
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	bl SeaMapEventManager__GetWork
	ldr r0, [r0, #0x254]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, pc}
	mov r3, #0
	str r3, [sp]
	mov r0, #0xb
	mov r1, #0x80
	mov r2, #0x60
	str r3, [sp, #4]
	bl SeaMapEventManager__CreateObject
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapEventManager__CreateDSPopup

	arm_func_start SeaMapEventManager__DestroyDSPopup
SeaMapEventManager__DestroyDSPopup: // 0x02047134
	stmdb sp!, {r3, lr}
	bl SeaMapEventManager__GetWork
	ldr r0, [r0, #0x254]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl SeaMapEventManager__GetWork
	ldr r0, [r0, #0x254]
	bl DestroyTask
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapEventManager__DestroyDSPopup

	arm_func_start SeaMapEventManager__UnlockCoralCave
SeaMapEventManager__UnlockCoralCave: // 0x02047158
	stmdb sp!, {r3, lr}
	bl SeaMapEventManager__GetWork
	ldr r0, [r0, #0x258]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl SeaMapEventManager__GetWork
	ldr r0, [r0, #0x258]
	bl GetTaskWork_
	ldr r1, _02047184 // =SeaMapCoralCaveIcon__Func_2049924
	str r1, [r0, #0x74]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02047184: .word SeaMapCoralCaveIcon__Func_2049924
	arm_func_end SeaMapEventManager__UnlockCoralCave

	arm_func_start SeaMapEventManager__UnlockSkyBabylon
SeaMapEventManager__UnlockSkyBabylon: // 0x02047188
	stmdb sp!, {r3, lr}
	bl SeaMapEventManager__GetWork
	ldr r0, [r0, #0x25c]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl SeaMapEventManager__GetWork
	ldr r0, [r0, #0x25c]
	bl GetTaskWork_
	ldr r1, _020471B4 // =SeaMapSkyBabylonIcon__Func_2049C74
	str r1, [r0, #0xdc]
	ldmia sp!, {r3, pc}
	.align 2, 0
_020471B4: .word SeaMapSkyBabylonIcon__Func_2049C74
	arm_func_end SeaMapEventManager__UnlockSkyBabylon

	arm_func_start SeaMapEventManager__Func_20471B8
SeaMapEventManager__Func_20471B8: // 0x020471B8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl RenderCore_GetTargetVBlankCount
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
_020471E8:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl AnimatorSprite__ProcessAnimation
	sub r0, r7, #1
	mov r0, r0, lsl #0x10
	cmp r7, #0
	mov r7, r0, lsr #0x10
	bne _020471E8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SeaMapEventManager__Func_20471B8

	arm_func_start SeaMapIslandIcon__IsEnabled
SeaMapIslandIcon__IsEnabled: // 0x02047210
	stmdb sp!, {r4, lr}
	ldr r2, _02047288 // =0x02110048
	sub r1, r0, #0x17
	ldr r4, [r2, r0, lsl #2]
	cmp r1, #7
	addls pc, pc, r1, lsl #2
	b _0204724C
_0204722C: // jump table
	b _02047260 // case 0
	b _02047260 // case 1
	b _02047260 // case 2
	b _02047274 // case 3
	b _02047274 // case 4
	b _02047274 // case 5
	b _02047274 // case 6
	b _02047274 // case 7
_0204724C:
	bl SaveGame__GetGameProgress
	cmp r4, r0
	movle r0, #1
	movgt r0, #0
	ldmia sp!, {r4, pc}
_02047260:
	bl SaveGame__GetUnknownProgress1
	cmp r4, r0
	movle r0, #1
	movgt r0, #0
	ldmia sp!, {r4, pc}
_02047274:
	bl SaveGame__GetUnknownProgress2
	cmp r4, r0
	movle r0, #1
	movgt r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02047288: .word 0x02110048
	arm_func_end SeaMapIslandIcon__IsEnabled

	arm_func_start SeaMapEventManager__GetWork
SeaMapEventManager__GetWork: // 0x0204728C
	ldr r0, _0204729C // =0x0213419C
	ldr ip, _020472A0 // =GetTaskWork_
	ldr r0, [r0]
	bx ip
	.align 2, 0
_0204729C: .word 0x0213419C
_020472A0: .word GetTaskWork_
	arm_func_end SeaMapEventManager__GetWork

	arm_func_start SeaMapEventManager__SpawnObjects1
SeaMapEventManager__SpawnObjects1: // 0x020472A4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	bl SeaMapManager__GetWork
	ldr r6, [r0, #0x160]
	mov r7, #0
	ldrh r0, [r6]
	cmp r0, #0
	ldmlsia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	ldr r4, _0204731C // =SeaMapEventManager__ObjectList
	add r5, r6, #2
	mov sb, #0x12
_020472CC:
	mla r8, r7, sb, r5
	mov r0, r8
	bl SeaMapEventManager__ObjectIsActive
	cmp r0, #0
	beq _02047300
	ldrh r0, [r8]
	ldrb r1, [r8, #6]
	add r0, r4, r0, lsl #4
	tst r1, #1
	beq _02047300
	ldr r2, [r0, #8]
	mov r1, r8
	blx r2
_02047300:
	ldrh r1, [r6]
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r7, r0, lsr #0x10
	bhi _020472CC
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_0204731C: .word SeaMapEventManager__ObjectList
	arm_func_end SeaMapEventManager__SpawnObjects1

	arm_func_start SeaMapEventManager__SpawnObjects2
SeaMapEventManager__SpawnObjects2: // 0x02047320
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	bl GetCurrentTaskWork_
	mov fp, r0
	bl SeaMapManager__GetWork
	ldr r7, [r0, #0x160]
	mov r8, #0
	ldrh r0, [r7]
	cmp r0, #0
	bls _020473A8
	ldr r5, _020473BC // =SeaMapEventManager__ObjectList
	add r6, r7, #2
	mov r4, #0x12
_02047350:
	mla sb, r8, r4, r6
	mov r0, sb
	bl SeaMapEventManager__ObjectIsActive
	cmp r0, #0
	beq _02047390
	ldrh r1, [sb]
	add r0, sb, #2
	add sl, r5, r1, lsl #4
	add r1, sl, #4
	bl SeaMapEventManager__ObjectInBounds
	cmp r0, #0
	beq _02047390
	ldr r2, [sl, #8]
	mov r0, sl
	mov r1, sb
	blx r2
_02047390:
	ldrh r1, [r7]
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r8, r0, lsr #0x10
	bhi _02047350
_020473A8:
	mov r1, #0
	mov r2, r1
	add r0, fp, #0x1f0
	bl SeaMapEventManager__Func_20471B8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_020473BC: .word SeaMapEventManager__ObjectList
	arm_func_end SeaMapEventManager__SpawnObjects2

	arm_func_start SeaMapEventManager__Func_20473C0
SeaMapEventManager__Func_20473C0: // 0x020473C0
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x128
	bl AnimatorSprite__Release
	add r0, r4, #0x18c
	bl AnimatorSprite__Release
	add r0, r4, #0x1f0
	bl AnimatorSprite__Release
	ldr r0, _020473F4 // =0x0213419C
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020473F4: .word 0x0213419C
	arm_func_end SeaMapEventManager__Func_20473C0

	arm_func_start SeaMapEventManager__InitMapObject
SeaMapEventManager__InitMapObject: // 0x020473F8
	stmia r0, {r1, r2, r3}
	ldrsh r1, [r3, #2]
	strh r1, [r0, #0xc]
	ldrsh r1, [r3, #4]
	strh r1, [r0, #0xe]
	bx lr
	arm_func_end SeaMapEventManager__InitMapObject

	arm_func_start SeaMapEventManager__DestroyObject
SeaMapEventManager__DestroyObject: // 0x02047410
	ldr r1, [r0, #8]
	ldrb r0, [r1, #6]
	tst r0, #0x80
	ldrne r0, _02047428 // =0x0000FFFF
	strneh r0, [r1]
	bx lr
	.align 2, 0
_02047428: .word 0x0000FFFF
	arm_func_end SeaMapEventManager__DestroyObject

	arm_func_start SeaMapEventManager__ObjectInBounds
SeaMapEventManager__ObjectInBounds: // 0x0204742C
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, lr}
	mov r7, r0
	mov r6, r1
	bl SeaMapManager__GetWork
	bl SeaMapManager__GetZoomInScale
	mov r4, r0
	bl SeaMapManager__GetXPos
	mov r8, r0, lsl #4
	bl SeaMapManager__GetYPos
	mov r1, #0xc0
	mov r0, r0, lsl #4
	mov r5, r0, asr #0x10
	mov r0, r4, lsl #8
	mov r0, r0, asr #0xc
	add r2, r0, r8, asr #16
	mul r0, r4, r1
	add r1, r5, #0xc0
	add r0, r1, r0, asr #12
	mov sb, r2, lsl #0x10
	mov sl, r0, lsl #0x10
	bl SeaMapManager__GetZoomInScale
	ldrsb r1, [r6]
	mul r0, r1, r0
	mov r0, r0, lsl #4
	mov r4, r0, asr #0x10
	bl SeaMapManager__GetZoomInScale
	ldrsb r1, [r6, #1]
	rsb r6, r4, r8, asr #16
	add r4, r4, sb, asr #16
	mul r0, r1, r0
	mov r0, r0, lsl #4
	mov r2, r0, asr #0x10
	sub r0, r5, r0, asr #16
	mov r1, r0, lsl #0x10
	add r3, r2, sl, asr #16
	ldrsh r2, [r7]
	mov r0, r6, lsl #0x10
	mov r5, r1, asr #0x10
	cmp r2, r0, asr #16
	mov r0, r4, lsl #0x10
	mov r1, r3, lsl #0x10
	blt _020474F4
	cmp r2, r0, asr #16
	bge _020474F4
	ldrsh r0, [r7, #2]
	cmp r5, r0
	bgt _020474F4
	cmp r0, r1, asr #16
	movlt r0, #1
	ldmltia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
_020474F4:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	arm_func_end SeaMapEventManager__ObjectInBounds

	arm_func_start SeaMapEventManager__Func_20474FC
SeaMapEventManager__Func_20474FC: // 0x020474FC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl SeaMapManager__GetZoomOutScale
	mov r4, r0
	bl SeaMapManager__GetXPos
	ldrsh r1, [r6]
	sub r0, r1, r0, asr #12
	mul r0, r4, r0
	mov r0, r0, asr #0xc
	strh r0, [r5]
	bl SeaMapManager__GetYPos
	ldrsh r1, [r6, #2]
	sub r0, r1, r0, asr #12
	mul r0, r4, r0
	mov r0, r0, asr #0xc
	strh r0, [r5, #2]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SeaMapEventManager__Func_20474FC

	arm_func_start SeaMapEventManager__SetObjectAsActive
SeaMapEventManager__SetObjectAsActive: // 0x02047544
	ldr r1, [r0, #8]
	ldrh r0, [r1]
	orr r0, r0, #0x8000
	strh r0, [r1]
	bx lr
	arm_func_end SeaMapEventManager__SetObjectAsActive

	arm_func_start SeaMapEventManager__SetObjectAsInactive
SeaMapEventManager__SetObjectAsInactive: // 0x02047558
	ldr r1, [r0, #8]
	ldrh r0, [r1]
	bic r0, r0, #0x8000
	strh r0, [r1]
	bx lr
	arm_func_end SeaMapEventManager__SetObjectAsInactive

	arm_func_start SeaMapEventManager__Func_204756C
SeaMapEventManager__Func_204756C: // 0x0204756C
	stmdb sp!, {r3, lr}
	ldrsh r1, [r0, #4]
	ldrsh ip, [r0, #2]
	add r2, sp, #0
	add r3, sp, #2
	mov r0, ip, lsl #0xc
	mov r1, r1, lsl #0xc
	bl SeaMapManager__Func_2043A80
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	bl SeaMapManager__GetMapPixel
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapEventManager__Func_204756C

	arm_func_start SeaMapEventManager__GetViewRect2
SeaMapEventManager__GetViewRect2: // 0x020475A8
	stmdb sp!, {r3, r4, r5, lr}
	ldrsh lr, [r0, #4]
	ldrsh ip, [r0]
	ldr r5, [sp, #0x14]
	ldr r4, [sp, #0x18]
	sub ip, lr, ip
	mov ip, ip, lsl #0xb
	str ip, [r5]
	ldrsh r5, [r0, #6]
	ldrsh lr, [r0, #2]
	ldr ip, [sp, #0x10]
	sub r5, r5, lr
	mov r5, r5, lsl #0xb
	str r5, [r4]
	ldrsh r4, [r0]
	ldrsh lr, [r0, #4]
	add r4, r4, lr
	add r1, r1, r4, asr #1
	mov r1, r1, lsl #0xc
	str r1, [r3]
	ldrsh r1, [r0, #2]
	ldrsh r0, [r0, #6]
	add r0, r1, r0
	add r0, r2, r0, asr #1
	mov r0, r0, lsl #0xc
	str r0, [ip]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapEventManager__GetViewRect2

	arm_func_start SeaMapEventManager__GetViewRect
SeaMapEventManager__GetViewRect: // 0x02047614
	ldrsh ip, [r0]
	add ip, r1, ip
	mov ip, ip, lsl #0xc
	str ip, [r3]
	ldrsh ip, [r0, #2]
	add ip, r2, ip
	mov ip, ip, lsl #0xc
	str ip, [r3, #4]
	ldrsh ip, [r0, #4]
	add r1, r1, ip
	mov r1, r1, lsl #0xc
	str r1, [r3, #8]
	ldrsh r0, [r0, #6]
	add r0, r2, r0
	mov r0, r0, lsl #0xc
	str r0, [r3, #0xc]
	bx lr
	arm_func_end SeaMapEventManager__GetViewRect

	arm_func_start SeaMapEventManager__PointInViewRect2
SeaMapEventManager__PointInViewRect2: // 0x02047658
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [sp, #0x10]
	mov r5, r3
	subs ip, r4, r0
	rsbmi r3, ip, #0
	ldr r0, [sp, #0x14]
	movpl r3, ip
	subs r4, r0, r1
	rsbmi r0, r4, #0
	movpl r0, r4
	cmp r3, r0
	movge r0, r3
	cmp r0, r2
	cmpgt r0, r5
	movgt r0, #0
	ldmgtia sp!, {r3, r4, r5, pc}
	smull r0, r3, ip, ip
	adds lr, r0, #0x800
	smull r0, r1, r2, r2
	adc ip, r3, #0
	adds r3, r0, #0x800
	mov r0, lr, lsr #0xc
	adc r2, r1, #0
	mov r1, r3, lsr #0xc
	orr r0, r0, ip, lsl #20
	orr r1, r1, r2, lsl #20
	bl FX_Div
	smull r1, r2, r4, r4
	adds ip, r1, #0x800
	mov r4, r0
	smull r0, r1, r5, r5
	adc r5, r2, #0
	adds r3, r0, #0x800
	mov r0, ip, lsr #0xc
	adc r2, r1, #0
	mov r1, r3, lsr #0xc
	orr r0, r0, r5, lsl #20
	orr r1, r1, r2, lsl #20
	bl FX_Div
	add r0, r4, r0
	cmp r0, #0x1000
	movle r0, #1
	movgt r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapEventManager__PointInViewRect2

	arm_func_start SeaMapEventManager__PointInViewRect
SeaMapEventManager__PointInViewRect: // 0x02047708
	ldr ip, [sp]
	cmp r0, ip
	cmple ip, r2
	ldrle r0, [sp, #4]
	cmple r1, r0
	cmple r0, r3
	movle r0, #1
	movgt r0, #0
	bx lr
	arm_func_end SeaMapEventManager__PointInViewRect

	arm_func_start SeaMapEventManager__ViewRectCheck
SeaMapEventManager__ViewRectCheck: // 0x0204772C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x18
	mov r5, r1
	mov r4, r2
	ldrsh r1, [r0, #2]
	ldrsh r2, [r0, #4]
	add r3, sp, #8
	add r0, r0, #8
	bl SeaMapEventManager__GetViewRect
	str r5, [sp]
	str r4, [sp, #4]
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	ldr r2, [sp, #0x10]
	ldr r3, [sp, #0x14]
	bl SeaMapEventManager__PointInViewRect
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapEventManager__ViewRectCheck

	arm_func_start SeaMapEventManager__ViewRectCheck2
SeaMapEventManager__ViewRectCheck2: // 0x02047780
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	add r3, sp, #0x18
	str r3, [sp]
	add ip, sp, #0xc
	add r3, sp, #0x10
	str ip, [sp, #4]
	str r3, [sp, #8]
	mov r5, r1
	mov r4, r2
	ldrsh r1, [r0, #2]
	ldrsh r2, [r0, #4]
	add r3, sp, #0x14
	add r0, r0, #8
	bl SeaMapEventManager__GetViewRect2
	str r5, [sp]
	str r4, [sp, #4]
	ldr r0, [sp, #0x14]
	ldr r1, [sp, #0x18]
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #0x10]
	bl SeaMapEventManager__PointInViewRect2
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
	arm_func_end SeaMapEventManager__ViewRectCheck2

	.rodata

.public SeaMapEventManager__ObjectList
SeaMapEventManager__ObjectList: // 0x021100FC
    .hword 0x2A                         // animID
    .hword 4                            // palette
    .byte 0x10, 0x10                    // viewBounds
    .byte 0, 0
    .word SeaMapIslandDrawIcon__Create   // createFunc
    .word 0                             // viewCheckFunc
    
    .hword 0                            // animID
    .hword 0                            // palette
    .byte 0x00, 0x00                    // viewBounds
    .byte 0, 0
    .word 0                             // createFunc
    .word 0                             // viewCheckFunc
    
    .hword 0                            // animID
    .hword 0                            // palette
    .byte 0x40, 0x40                    // viewBounds
    .byte 0, 0
    .word SeaMapIslandIcon__Create      // createFunc
    .word SeaMapIslandIcon__ViewCheck   // viewCheckFunc
    
    .hword 0                            // animID
    .hword 0                            // palette
    .byte 0x40, 0x40                    // viewBounds
    .byte 0, 0
    .word SeaMapIslandIcon__Create      // createFunc
    .word SeaMapIslandIcon__ViewCheck   // viewCheckFunc
    
    .hword 0                            // animID
    .hword 0                            // palette
    .byte 0x10, 0x10                    // viewBounds
    .byte 0, 0
    .word SeaMapJohnnyIcon__Create      // createFunc
    .word SeaMapJohnnyIcon__ViewCheck   // viewCheckFunc
    
    .hword 0                            // animID
    .hword 0                            // palette
    .byte 0x10, 0x10                    // viewBounds
    .byte 0, 0
    .word SeaMapUnknown5__Create        // createFunc
    .word SeaMapUnknown5__ViewCheck     // viewCheckFunc
    
    .hword 0x80                         // animID
    .hword 8                            // palette
    .byte 0x1C, 0x24                    // viewBounds
    .byte 0, 0
    .word SeaMapCoralCaveIcon__Create   // createFunc
    .word 0                             // viewCheckFunc
    
    .hword 0x82                         // animID
    .hword 9                            // palette
    .byte 0x1C, 0x24                    // viewBounds
    .byte 0, 0
    .word SeaMapSkyBabylonIcon__Create  // createFunc
    .word 0                             // viewCheckFunc
    
    .hword 0x8B                         // animID
    .hword 4                            // palette
    .byte 0x20, 0x20                    // viewBounds
    .byte 0, 0
    .word SeaMapTargetFlagIcon__Create  // createFunc
    .word 0                             // viewCheckFunc
    
    .hword 0                            // animID
    .hword 0xE                          // palette
    .byte 0x00, 0x00                    // viewBounds
    .byte 0, 0
    .word SeaMapBoatIcon__Create        // createFunc
    .word 0                             // viewCheckFunc
    
    .hword 0                            // animID
    .hword 0xE                          // palette
    .byte 0x00, 0x00                    // viewBounds
    .byte 0, 0
    .word SeaMapStylusIcon__Create      // createFunc
    .word 0                             // viewCheckFunc
    
    .hword 0                            // animID
    .hword 2                            // palette
    .byte 0x00, 0x00                    // viewBounds
    .byte 0, 0
    .word SeaMapDSPopup__Create         // createFunc
    .word 0                             // viewCheckFunc
    
    .hword 0                            // animID
    .hword 5                            // palette
    .byte 0x00, 0x00                    // viewBounds
    .byte 0, 0
    .word SeaMapSparkles__Create        // createFunc
    .word 0                             // viewCheckFunc
    
    .hword 0                            // animID
    .hword 5                            // palette
    .byte 0x00, 0x00                    // viewBounds
    .byte 0, 0
    .word SeaMapSparkles__Create        // createFunc
    .word 0                             // viewCheckFunc