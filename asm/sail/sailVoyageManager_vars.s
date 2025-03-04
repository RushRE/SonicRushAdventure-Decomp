	.include "asm/macros.inc"
	.include "global.inc"

    .text
    
	thumb_func_start SailVoyageManager__Func_2157C34
SailVoyageManager__Func_2157C34: // 0x02157C34
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x20
	mov r5, r0
	mov r0, #0
	str r0, [sp, #0x10]
	bl SailManager__GetWork
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	mov r7, #0
	str r0, [sp, #0xc]
	bl SailManager__GetWork
	mov r6, r0
	ldr r0, _02157F50 // =gameState
	ldr r3, _02157F54 // =_0218BBA8
	str r0, [sp, #8]
	ldmia r3!, {r0, r1}
	add r2, sp, #0x14
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	str r0, [r2]
	ldr r0, [sp, #0xc]
	cmp r0, #0
	beq _02157C74
	bl SailManager__GetWork
	ldr r1, [r0, #0x70]
	mov r0, #0x49
	lsl r0, r0, #2
	ldr r7, [r1, r0]
_02157C74:
	mov r0, r5
	add r0, #0xc0
	ldr r2, [r0, #0]
	ldrh r1, [r5, #0x24]
	mov r0, #0x28
	mul r0, r1
	add r4, r2, r0
	cmp r7, #0
	beq _02157CA6
	ldr r0, [r7, #0x10]
	str r0, [sp, #0x10]
	bl SailManager__GetShipType
	cmp r0, #0
	beq _02157C9A
	bl SailManager__GetShipType
	cmp r0, #2
	bne _02157CA6
_02157C9A:
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _02157CA6
	mov r0, #0
	str r0, [sp, #0x10]
_02157CA6:
	ldr r0, [r5, #0x44]
	mov r2, r5
	str r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	ldr r0, [sp, #0x10]
	mov r3, r5
	add r0, r1, r0
	str r0, [r5, #0x44]
	ldr r1, [r5, #0x4c]
	ldr r0, [sp, #0x10]
	add r2, #0xc
	add r0, r1, r0
	str r0, [r5, #0x4c]
	ldmia r3!, {r0, r1}
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	str r0, [r2]
	mov r0, #0
	str r0, [r5, #0x70]
	str r0, [r5, #0x74]
	ldrh r0, [r5, #0x34]
	strh r0, [r5, #0x36]
	bl SailManager__GetShipType
	cmp r0, #0
	beq _02157CE2
	bl SailManager__GetShipType
	cmp r0, #2
	bne _02157CFC
_02157CE2:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	beq _02157CFC
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _02157CFC
	mov r0, #0
	str r0, [r5, #0x28]
	str r0, [r5, #0x2c]
	str r0, [r5, #0x30]
	add sp, #0x20
	strh r0, [r5, #0x38]
	pop {r3, r4, r5, r6, r7, pc}
_02157CFC:
	cmp r7, #0
	beq _02157D74
	ldr r0, [r6, #0x24]
	mov r1, #1
	tst r1, r0
	bne _02157D74
	mov r1, #2
	tst r0, r1
	bne _02157D74
	ldr r0, [sp, #0xc]
	bl SailPlayer__HasRetired
	cmp r0, #0
	bne _02157D2C
	mov r0, r5
	ldr r1, [r5, #0x44]
	add r0, #0xc0
	asr r2, r1, #0x13
	mov r1, #0x28
	ldr r0, [r0, #0]
	mul r1, r2
	ldrb r0, [r0, r1]
	cmp r0, #0xe
	blo _02157D30
_02157D2C:
	mov r0, #0
	strh r0, [r5, #0x3c]
_02157D30:
	ldr r0, _02157F58 // =0x000001CA
	ldrsh r0, [r7, r0]
	str r0, [sp, #4]
	mov r0, #0x3c
	ldrsh r1, [r5, r0]
	ldr r0, [sp, #4]
	cmp r0, r1
	beq _02157D74
	mov r2, #0x40
	ldrsh r0, [r5, r2]
	mov r1, #8
	add r2, #0xe0
	bl ObjSpdUpSet
	mov r1, r5
	add r1, #0x40
	strh r0, [r1]
	ldr r0, _02157F58 // =0x000001CA
	mov r2, #0x40
	ldrh r0, [r7, r0]
	ldrh r1, [r5, #0x3c]
	ldrsh r2, [r5, r2]
	bl ObjRoopMove16
	ldr r1, _02157F58 // =0x000001CA
	strh r0, [r7, r1]
	ldrsh r1, [r7, r1]
	ldr r0, [sp, #4]
	cmp r1, r0
	bne _02157D74
	mov r0, r5
	mov r1, #0
	add r0, #0x40
	strh r1, [r0]
_02157D74:
	mov r0, r5
	add r0, #0xb8
	ldrh r1, [r0, #0]
	ldrh r0, [r5, #0x24]
	cmp r1, r0
	bls _02157D8C
	mov r0, r4
	bl SailVoyageManager__GetVoyageUnknownValue
	ldr r1, [r5, #0x4c]
	cmp r1, r0
	bge _02157D8E
_02157D8C:
	b _02157F08
_02157D8E:
	mov r0, r4
	bl SailVoyageManager__GetVoyageUnknownValue
	ldr r1, [r5, #0x4c]
	sub r0, r1, r0
	str r0, [r5, #0x4c]
	mov r0, r5
	add r0, #0x6e
	ldrh r1, [r0, #0]
	cmp r1, #0
	beq _02157E0E
	ldrh r0, [r5, #0x24]
	add r0, r0, #1
	cmp r0, r1
	bne _02157E0E
	mov r0, r4
	add r0, #0x28
	bl SailVoyageManager__GetVoyageUnknownValue
	mov r1, r0
	ldr r0, [r5, #0x4c]
	bl FX_Div
	add r4, #0x28
	mov r1, r0
	mov r0, r4
	add r2, sp, #0x14
	add r3, sp, #0x1c
	bl SailVoyageManager__Func_2158888
	mov r0, #0
	str r0, [sp, #0x18]
	mov r0, r5
	add r0, #0x6c
	ldrh r2, [r0, #0]
	mov r0, r5
	add r0, #0xc0
	strh r2, [r5, #0x24]
	ldr r1, [r0, #0]
	mov r0, #0x28
	mul r0, r2
	add r4, r1, r0
	mov r0, r4
	bl SailVoyageManager__GetVoyageUnknownValue
	mov r1, r5
	add r1, #0x6e
	ldrh r2, [r1, #0]
	mov r1, r5
	add r1, #0x6c
	ldrh r1, [r1, #0]
	sub r1, r2, r1
	neg r1, r1
	mov r2, r1
	mul r2, r0
	str r2, [r5, #0x74]
	ldr r0, [r5, #0x48]
	add r0, r0, r2
	str r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x74]
	add r0, r1, r0
	str r0, [r5, #0x44]
	b _02157E16
_02157E0E:
	ldrh r0, [r5, #0x24]
	add r4, #0x28
	add r0, r0, #1
	strh r0, [r5, #0x24]
_02157E16:
	ldrh r0, [r4, #2]
	mov r2, r5
	mov r3, r5
	strh r0, [r5, #0x34]
	ldr r0, [r4, #0xc]
	add r2, #0x18
	str r0, [r5]
	ldr r0, [r4, #0x10]
	str r0, [r5, #8]
	ldrh r0, [r5, #0x34]
	strh r0, [r5, #0x3a]
	ldmia r3!, {r0, r1}
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	str r0, [r2]
	mov r0, #0x3c
	ldrsh r0, [r5, r0]
	strh r0, [r5, #0x3e]
	mov r0, #0xa
	ldrsh r0, [r4, r0]
	strh r0, [r5, #0x3c]
	ldrb r1, [r4, #0]
	cmp r1, #0xe
	blo _02157E78
	ldr r0, [sp, #0xc]
	cmp r0, #0
	beq _02157E78
	mov r0, r5
	bl SailVoyageManager__Func_2158028
	ldrh r0, [r5, #0x24]
	ldr r1, [r5, #0x44]
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl SailEventManager__LoadMapObjects
	mov r0, r6
	mov r1, #0
	add r0, #0x5e
	strh r1, [r0]
	mov r0, r6
	add r0, #0x60
	ldrh r0, [r0, #0]
	add r1, r0, #1
	mov r0, r6
	add r0, #0x60
	strh r1, [r0]
	b _02157F08
_02157E78:
	cmp r1, #7
	bhs _02157EBC
	ldrh r0, [r6, #0x14]
	cmp r0, #0
	bne _02157EA6
	ldr r0, [r6, #0xc]
	cmp r0, #1
	beq _02157EA6
	bl SailManager__GetShipType
	cmp r0, #1
	beq _02157EA6
	ldrh r0, [r4, #8]
	cmp r0, #3
	blo _02157E9E
	bl SailManager__GetShipType
	cmp r0, #3
	bne _02157EA6
_02157E9E:
	ldr r1, [r6, #0x24]
	mov r0, #4
	eor r0, r1
	str r0, [r6, #0x24]
_02157EA6:
	mov r0, r6
	mov r1, #0
	add r0, #0x5e
	strh r1, [r0]
	mov r0, r6
	add r0, #0x60
	ldrh r0, [r0, #0]
	add r1, r0, #1
	mov r0, r6
	add r0, #0x60
	strh r1, [r0]
_02157EBC:
	mov r0, r5
	add r0, #0x6e
	ldrh r1, [r0, #0]
	cmp r1, #0
	beq _02157EF4
	ldrh r0, [r5, #0x24]
	add r0, r0, #1
	cmp r0, r1
	bne _02157EF4
	mov r0, r4
	bl SailVoyageManager__GetVoyageUnknownValue
	mov r1, r5
	add r1, #0x6e
	ldrh r2, [r1, #0]
	mov r1, r5
	add r1, #0x6c
	ldrh r1, [r1, #0]
	sub r1, r2, r1
	mul r0, r1
	str r0, [r5, #0x70]
	mov r0, r5
	add r0, #0x6c
	ldrh r0, [r0, #0]
	ldr r1, [r5, #0x44]
	bl SailEventManager__LoadMapObjects
	b _02157F02
_02157EF4:
	ldrh r0, [r5, #0x24]
	ldr r1, [r5, #0x44]
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl SailEventManager__LoadMapObjects
_02157F02:
	mov r0, r5
	bl SailVoyageManager__Func_2158234
_02157F08:
	mov r0, r4
	bl SailVoyageManager__GetVoyageUnknownValue
	mov r1, r0
	ldr r0, [r5, #0x4c]
	bl FX_Div
	mov r7, r0
	mov r0, r4
	mov r1, r7
	bl SailVoyageManager__Func_2158854
	mov r3, r5
	strh r0, [r5, #0x34]
	mov r0, r4
	mov r1, r7
	mov r2, r5
	add r3, #8
	bl SailVoyageManager__Func_2158888
	ldrh r1, [r5, #0x34]
	ldrh r0, [r5, #0x36]
	sub r0, r1, r0
	strh r0, [r5, #0x38]
	ldr r0, [sp, #0x18]
	cmp r0, #0
	bne _02157F5C
	mov r1, r5
	mov r2, r5
	add r0, sp, #0x14
	add r1, #0xc
	add r2, #0x28
	bl VEC_Subtract
	b _02157F6A
	nop
_02157F50: .word gameState
_02157F54: .word _0218BBA8
_02157F58: .word 0x000001CA
_02157F5C:
	mov r1, r5
	mov r2, r5
	mov r0, r5
	add r1, #0xc
	add r2, #0x28
	bl VEC_Subtract
_02157F6A:
	ldrh r0, [r5, #0x34]
	bl SailSea__Func_215FA54
	ldr r0, [sp, #0x10]
	bl SailSea__Func_215F9D8
	ldr r0, [r6, #0xc]
	cmp r0, #0
	bne _0215801E
	ldrh r0, [r6, #0x12]
	cmp r0, #0
	bne _0215801E
	ldr r0, [sp, #8]
	add r0, #0x8c
	ldrh r0, [r0, #0]
	cmp r0, #0
	beq _0215801E
	ldr r1, [r6, #0x24]
	mov r0, #8
	tst r0, r1
	bne _0215801E
	ldrb r1, [r4, #0]
	cmp r1, #0xe
	blo _02157FA0
	mov r0, #1
	tst r0, r1
	bne _0215801E
_02157FA0:
	bl SailManager__GetShipType
	lsl r1, r0, #2
	ldr r0, _02158024 // =_0218BBC0
	mov r6, #2
	ldr r7, [r0, r1]
	mov r4, #0x80
	ldr r0, [r5, #0x44]
	lsl r1, r4, #0xc
	lsl r6, r6, #8
	bl FX_Div
	asr r1, r0, #0x1f
	asr r3, r7, #0x1f
	mov r2, r7
	bl _ull_mul
	mov r3, #0
	lsl r2, r4, #4
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	ldr r0, [sp, #8]
	mov r2, r5
	add r0, #0xa8
	str r1, [r5, #0x54]
	str r0, [sp, #8]
	ldr r0, [r0, #0]
	add r2, #0x60
	add r0, r1, r0
	mov r1, r5
	add r1, #0x5c
	str r0, [r5, #0x54]
	bl SeaMapManager__Func_2045BF8
	bl SailManager__GetShipType
	cmp r0, #1
	bne _02157FF6
	sub r6, #0x40
	mov r4, r6
_02157FF6:
	ldr r0, [r5, #0x64]
	ldr r1, [r5, #0x5c]
	cmp r1, r0
	beq _0215800A
	mov r2, #1
	mov r3, r6
	str r4, [sp]
	bl ObjShiftSet
	str r0, [r5, #0x64]
_0215800A:
	ldr r0, [r5, #0x68]
	ldr r1, [r5, #0x60]
	cmp r1, r0
	beq _0215801E
	mov r2, #1
	mov r3, r6
	str r4, [sp]
	bl ObjShiftSet
	str r0, [r5, #0x68]
_0215801E:
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02158024: .word _0218BBC0
	thumb_func_end SailVoyageManager__Func_2157C34

	.rodata

.public _0218BBA8
_0218BBA8: // 0x0218BBA8
    .word 0, 1, 0

.public _0218BBB4
_0218BBB4: // 0x0218BBB4
    .word 0, 0, 0xFFEC0000

.public _0218BBC0
_0218BBC0: // 0x0218BBC0
    .word 0x4000, 0xE000, 0x8000, 0x6000