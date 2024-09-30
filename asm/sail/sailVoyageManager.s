	.include "asm/macros.inc"
	.include "global.inc"

	.text

	thumb_func_start SailVoyageManager__Create
SailVoyageManager__Create: // 0x021573C8
	push {r3, r4, r5, r6, lr}
	sub sp, #0xc
	bl SailManager__GetWork
	mov r4, r0
	ldr r0, _02157470 // =0x0000EFFE
	mov r2, #0
	str r0, [sp]
	mov r0, #4
	str r0, [sp, #4]
	add r0, #0xfc
	str r0, [sp, #8]
	ldr r0, _02157474 // =SailVoyageManager__Main
	ldr r1, _02157478 // =SailVoyageManager__Destructor
	mov r3, r2
	ldr r6, _0215747C // =gameState
	bl TaskCreate_
	bl GetTaskWork_
	mov r5, r0
	mov r2, #1
	mov r0, #0
	mov r1, r5
	lsl r2, r2, #8
	bl MIi_CpuClear16
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _0215740E
	mov r0, #0xa
	lsl r0, r0, #0xa
	bl _AllocHeadHEAP_USER
	b _02157416
_0215740E:
	mov r0, #0xa
	lsl r0, r0, #0xa
	bl _AllocHeadHEAP_SYSTEM
_02157416:
	mov r1, r5
	add r1, #0xc0
	str r0, [r1]
	mov r1, r5
	add r1, #0xc0
	mov r2, #0xa
	ldr r1, [r1, #0]
	mov r0, #0
	lsl r2, r2, #0xa
	bl MIi_CpuClear16
	bl SailManager__GetShipType
	cmp r0, #1
	bne _0215743A
	mov r0, #0xf
	lsl r0, r0, #0xa
	strh r0, [r5, #0x3c]
_0215743A:
	ldr r0, [r4, #0xc]
	cmp r0, #0
	bne _02157446
	ldrh r0, [r4, #0x12]
	cmp r0, #0
	beq _0215744C
_02157446:
	add sp, #0xc
	mov r0, r5
	pop {r3, r4, r5, r6, pc}
_0215744C:
	add r6, #0x8c
	ldrh r0, [r6, #0]
	cmp r0, #0
	beq _0215746A
	mov r1, r5
	mov r2, r5
	ldr r0, [r5, #0x54]
	add r1, #0x5c
	add r2, #0x60
	bl SeaMapManager__Func_2045BF8
	ldr r0, [r5, #0x5c]
	str r0, [r5, #0x64]
	ldr r0, [r5, #0x60]
	str r0, [r5, #0x68]
_0215746A:
	mov r0, r5
	add sp, #0xc
	pop {r3, r4, r5, r6, pc}
	.align 2, 0
_02157470: .word 0x0000EFFE
_02157474: .word SailVoyageManager__Main
_02157478: .word SailVoyageManager__Destructor
_0215747C: .word gameState
	thumb_func_end SailVoyageManager__Create

	thumb_func_start SailVoyageManager__Destructor
SailVoyageManager__Destructor: // 0x02157480
	push {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	mov r4, r0
	mov r0, r5
	bl GetTaskWork_
	mov r5, r0
	add r0, #0xc0
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _021574AA
	ldr r1, [r4, #0xc]
	cmp r1, #0
	beq _021574A6
	bl _FreeHEAP_USER
	b _021574AA
_021574A6:
	bl _FreeHEAP_SYSTEM
_021574AA:
	mov r0, #0
	add r5, #0xc0
	str r0, [r5]
	pop {r3, r4, r5, pc}
	.align 2, 0
	thumb_func_end SailVoyageManager__Destructor

	thumb_func_start SailVoyageManager__Func_21574B4
SailVoyageManager__Func_21574B4: // 0x021574B4
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r5, r0
	bl SailManager__GetWork
	mov r6, r0
	mov r4, #0
	bl SailManager__GetShipType
	lsl r1, r0, #2
	ldr r0, _02157618 // =_0218BBC0
	ldr r0, [r0, r1]
	str r0, [sp]
	bl SeaMapManager__GetTotalDistance
	str r0, [r5, #0x50]
	ldr r0, [r6, #0xc]
	cmp r0, #0
	bne _021574E8
	ldr r0, _0215761C // =0x021394D4
	ldr r1, _02157620 // =gameState
	ldr r0, [r0, #0x28]
	cmp r0, #0
	beq _021574E8
	add r1, #0xa8
	ldr r4, [r1, #0]
_021574E8:
	mov r0, r4
	add r1, sp, #8
	add r2, sp, #4
	bl SeaMapManager__Func_2045BF8
	mov r1, #1
	lsl r1, r1, #0xe
	ldr r0, [r5, #0x50]
	add r1, r4, r1
	cmp r1, r0
	add r2, sp, #0xc
	ble _02157508
	add r1, sp, #0x10
	bl SeaMapManager__Func_2045BF8
	b _02157510
_02157508:
	mov r0, r1
	add r1, sp, #0x10
	bl SeaMapManager__Func_2045BF8
_02157510:
	ldr r1, [sp, #8]
	ldr r0, [sp, #0x10]
	ldr r2, [sp, #4]
	sub r0, r1, r0
	ldr r1, [sp, #0xc]
	sub r1, r2, r1
	bl FX_Atan2Idx
	strh r0, [r5, #0x34]
	ldrh r0, [r5, #0x34]
	mov r6, #0
	strh r0, [r5, #0x36]
	ldrh r7, [r5, #0x34]
_0215752A:
	mov r0, r4
	add r1, sp, #8
	add r2, sp, #4
	bl SeaMapManager__Func_2045BF8
	ldr r0, [sp]
	add r4, r4, r0
	ldr r0, [r5, #0x50]
	cmp r4, r0
	blt _02157540
	mov r4, r0
_02157540:
	mov r0, r4
	add r1, sp, #0x10
	add r2, sp, #0xc
	bl SeaMapManager__Func_2045BF8
	ldr r1, [sp, #8]
	ldr r0, [sp, #0x10]
	ldr r2, [sp, #4]
	sub r0, r1, r0
	ldr r1, [sp, #0xc]
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r2, r5
	add r2, #0xc0
	mov r1, #0x28
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	ldr r2, [r2, #0]
	mul r1, r6
	sub r0, r0, r7
	add r2, r2, r1
	strh r0, [r2, #4]
	mov r0, r5
	add r0, #0xc0
	ldr r0, [r0, #0]
	add r2, r0, r1
	mov r0, #4
	ldrsh r3, [r2, r0]
	add r0, r7, r3
	lsl r0, r0, #0x10
	lsr r7, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	cmp r3, r0
	ble _0215758A
	strh r0, [r2, #4]
_0215758A:
	mov r0, r5
	add r0, #0xc0
	ldr r0, [r0, #0]
	add r0, r0, r1
	mov r1, #4
	ldrsh r2, [r0, r1]
	ldr r1, _02157624 // =0xFFFFE000
	cmp r2, r1
	bge _0215759E
	strh r1, [r0, #4]
_0215759E:
	ldr r0, [r5, #0x50]
	cmp r0, r4
	ble _021575AC
	add r0, r6, #1
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	b _0215752A
_021575AC:
	mov r0, r5
	add r0, #0xb8
	strh r6, [r0]
	bl SailVoyageManager__Func_2157628
	mov r0, r5
	add r0, #0xb8
	ldrh r1, [r0, #0]
	cmp r1, #0
	beq _02157614
	mov r0, r5
	add r0, #0xc0
	ldr r3, [r0, #0]
	sub r0, r1, #1
	mov r2, #0x28
	mov r1, r0
	mul r1, r2
	ldrb r0, [r3, r1]
	cmp r0, #0xe
	bhs _02157614
	mov r0, #0x14
	strb r0, [r3, r1]
	mov r0, r5
	add r0, #0xc0
	ldr r3, [r0, #0]
	mov r0, r5
	add r0, #0xb8
	ldrh r0, [r0, #0]
	mov r4, #0x15
	mov r1, r0
	mul r1, r2
	strb r4, [r3, r1]
	mov r1, r5
	add r1, #0xc0
	ldr r4, [r1, #0]
	mov r1, r5
	add r1, #0xb8
	ldrh r1, [r1, #0]
	mov r0, #0
	sub r1, r1, #1
	mov r3, r1
	mul r3, r2
	add r1, r4, r3
	strh r0, [r1, #0xa]
	mov r1, r5
	add r1, #0xc0
	add r5, #0xb8
	ldr r3, [r1, #0]
	ldrh r1, [r5, #0]
	mul r2, r1
	add r1, r3, r2
	strh r0, [r1, #0xa]
_02157614:
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02157618: .word _0218BBC0
_0215761C: .word 0x021394D4
_02157620: .word gameState
_02157624: .word 0xFFFFE000
	thumb_func_end SailVoyageManager__Func_21574B4

	thumb_func_start SailVoyageManager__Func_2157628
SailVoyageManager__Func_2157628: // 0x02157628
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	bl SailManager__GetWork
	mov r7, #0
	str r0, [sp, #0x10]
	sub r0, r7, #1
	mov r6, r7
	str r0, [sp, #4]
	bl SailManager__GetShipType
	lsl r1, r0, #2
	ldr r0, _02157764 // =_0218BBC0
	ldr r0, [r0, r1]
	str r0, [sp]
	bl SailManager__GetWork
	add r0, #0x98
	ldr r5, [r0, #0]
	mov r4, r7
	ldr r0, [sp, #0x10]
	str r4, [sp, #8]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _02157672
	ldr r0, _02157768 // =gameState
	add r0, #0xa8
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _02157672
	ldr r1, _02157768 // =gameState
	add r1, #0xb6
	ldrh r1, [r1, #0]
	cmp r1, #0
	beq _02157672
	str r1, [sp, #8]
	str r0, [sp, #4]
_02157672:
	bl SeaMapUnknown204AB60__Func_204ABBC
	ldr r1, [sp, #8]
	cmp r1, r0
	bhs _02157760
_0215767C:
	ldr r0, [sp, #8]
	bl SeaMapUnknown204AB60__Func_204ABCC
	str r0, [sp, #0xc]
	ldr r0, [r0, #8]
	ldr r1, [sp, #4]
	cmp r0, r1
	ble _0215774C
	sub r0, r0, r1
	ldr r1, [sp]
	bl FX_DivS32
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	cmp r4, r1
	bhs _021576C2
	cmp r4, r1
	bhs _021576C2
	mov r3, #0x28
_021576A2:
	mov r2, r5
	add r2, #0xc0
	mov r0, r4
	ldr r2, [r2, #0]
	mul r0, r3
	strb r6, [r2, r0]
	mov r2, r5
	add r2, #0xc0
	ldr r2, [r2, #0]
	add r0, r2, r0
	strb r7, [r0, #1]
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	cmp r4, r1
	blo _021576A2
_021576C2:
	cmp r4, r1
	bne _021576DC
	mov r1, r5
	add r1, #0xc0
	mov r0, #0x28
	ldr r1, [r1, #0]
	mul r0, r4
	strb r6, [r1, r0]
	mov r1, r5
	add r1, #0xc0
	ldr r1, [r1, #0]
	add r0, r1, r0
	strb r7, [r0, #1]
_021576DC:
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0xc]
	cmp r0, #4
	bhi _02157740
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_021576F0: // jump table
	.hword _02157740 - _021576F0 - 2 // case 0
	.hword _021576FA - _021576F0 - 2 // case 1
	.hword _02157704 - _021576F0 - 2 // case 2
	.hword _0215770E - _021576F0 - 2 // case 3
	.hword _02157718 - _021576F0 - 2 // case 4
_021576FA:
	ldr r0, [sp, #0xc]
	mov r1, r4
	bl SailVoyageManager__Func_215776C
	b _02157740
_02157704:
	ldr r0, [sp, #0xc]
	bl SailVoyageManager__Func_215794C
	mov r6, r0
	b _02157740
_0215770E:
	ldr r0, [sp, #0xc]
	bl SailVoyageManager__Func_215799C
	mov r7, r0
	b _02157740
_02157718:
	ldr r0, [sp, #0xc]
	mov r1, r4
	bl SailVoyageManager__Func_2157894
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0x14]
	ldrb r1, [r0, #7]
	mov r0, #1
	tst r0, r1
	beq _02157736
	ldr r1, _02157768 // =gameState
	ldr r0, [sp, #8]
	add r1, #0xb6
	strh r0, [r1]
	b _02157740
_02157736:
	ldr r0, [sp, #8]
	add r1, r0, #1
	ldr r0, _02157768 // =gameState
	add r0, #0xb6
	strh r1, [r0]
_02157740:
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0xc]
	cmp r0, #1
	beq _02157760
	cmp r0, #4
	beq _02157760
_0215774C:
	ldr r0, [sp, #8]
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	bl SeaMapUnknown204AB60__Func_204ABBC
	ldr r1, [sp, #8]
	cmp r1, r0
	blo _0215767C
_02157760:
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02157764: .word _0218BBC0
_02157768: .word gameState
	thumb_func_end SailVoyageManager__Func_2157628

	thumb_func_start SailVoyageManager__Func_215776C
SailVoyageManager__Func_215776C: // 0x0215776C
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r4, r1
	bl SailManager__GetWork
	mov r6, r0
	bl SailManager__GetWork
	add r0, #0x98
	ldr r0, [r0, #0]
	cmp r4, #1
	bhi _021577A2
	mov r2, r0
	add r2, #0xc0
	mov r1, #0x28
	mul r1, r4
	ldr r3, [r2, #0]
	mov r4, #2
	ldrb r2, [r3, r1]
	add r3, #0x28
	strb r2, [r3]
	mov r2, r0
	add r2, #0xc0
	ldr r2, [r2, #0]
	ldrb r1, [r2, r1]
	add r2, #0x50
	strb r1, [r2]
_021577A2:
	ldr r1, [r5, #0x10]
	cmp r1, #0
	beq _021577B2
	cmp r1, #1
	beq _021577DE
	cmp r1, #2
	beq _0215780C
	b _0215785C
_021577B2:
	mov r1, r0
	add r1, #0xb8
	mov r2, r0
	strh r4, [r1]
	add r2, #0xc0
	sub r3, r4, #1
	ldr r7, [r2, #0]
	mov r2, #0x28
	mov r6, r3
	mov r1, #0x1a
	mul r6, r2
	strb r1, [r7, r6]
	mov r1, r0
	add r1, #0xc0
	ldr r3, [r1, #0]
	mov r1, r4
	mov r6, #0x1b
	mul r1, r2
	strb r6, [r3, r1]
	ldr r1, [r5, #8]
	str r1, [r0, #0x58]
	b _0215785C
_021577DE:
	mov r1, r0
	add r1, #0xb8
	strh r4, [r1]
	mov r1, r0
	add r1, #0xc0
	ldr r1, [r1, #0]
	sub r7, r4, #1
	mov r3, #0x28
	mov r2, #0xe
	mul r3, r7
	strb r2, [r1, r3]
	mov r2, r0
	add r2, #0xc0
	ldr r3, [r2, #0]
	mov r2, #0x28
	mov r1, #0xf
	mul r2, r4
	strb r1, [r3, r2]
	ldr r1, [r5, #8]
	str r1, [r0, #0x58]
	ldr r1, [r5, #0x14]
	str r1, [r6, #4]
	b _0215785C
_0215780C:
	mov r1, r0
	add r1, #0xb8
	strh r4, [r1]
	ldr r1, [r5, #8]
	mov r5, r4
	str r1, [r0, #0x58]
	mov r1, #0x28
	mul r5, r1
	mov r1, r0
	add r1, #0xc0
	ldr r3, [r1, #0]
	ldrb r1, [r3, r5]
	cmp r1, #5
	bhi _02157840
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add pc, r1
_02157834: // jump table
	.hword _02157840 - _02157834 - 2 // case 0
	.hword _02157844 - _02157834 - 2 // case 1
	.hword _02157844 - _02157834 - 2 // case 2
	.hword _02157848 - _02157834 - 2 // case 3
	.hword _02157840 - _02157834 - 2 // case 4
	.hword _02157848 - _02157834 - 2 // case 5
_02157840:
	mov r2, #0x15
	b _0215784A
_02157844:
	mov r2, #0x11
	b _0215784A
_02157848:
	mov r2, #0x13
_0215784A:
	sub r7, r4, #1
	mov r6, #0x28
	sub r1, r2, #1
	mul r6, r7
	strb r1, [r3, r6]
	mov r1, r0
	add r1, #0xc0
	ldr r1, [r1, #0]
	strb r2, [r1, r5]
_0215785C:
	sub r1, r4, #1
	mov r3, r1
	mov r1, r0
	add r1, #0xc0
	mov r5, #0x28
	ldr r1, [r1, #0]
	mul r3, r5
	mov r2, #0
	add r1, r1, r3
	strh r2, [r1, #0xa]
	mov r1, r4
	mov r4, r0
	add r4, #0xc0
	ldr r4, [r4, #0]
	mul r1, r5
	add r4, r4, r1
	strh r2, [r4, #0xa]
	mov r4, r0
	add r4, #0xc0
	ldr r4, [r4, #0]
	add r0, #0xc0
	add r3, r4, r3
	strh r2, [r3, #4]
	ldr r0, [r0, #0]
	add r0, r0, r1
	strh r2, [r0, #4]
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
	thumb_func_end SailVoyageManager__Func_215776C

	thumb_func_start SailVoyageManager__Func_2157894
SailVoyageManager__Func_2157894: // 0x02157894
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r4, r1
	bl SailManager__GetWork
	mov r6, r0
	bl SailManager__GetWork
	add r0, #0x98
	ldr r0, [r0, #0]
	cmp r4, #1
	bhi _021578AE
	mov r4, #2
_021578AE:
	ldr r1, [r5, #0x10]
	cmp r1, #0
	beq _021578BA
	cmp r1, #1
	beq _021578EC
	b _02157916
_021578BA:
	mov r1, r0
	add r1, #0xb8
	strh r4, [r1]
	mov r1, r0
	add r1, #0xc0
	ldr r1, [r1, #0]
	sub r7, r4, #1
	mov r3, #0x28
	mov r2, #0x16
	mul r3, r7
	strb r2, [r1, r3]
	mov r2, r0
	add r2, #0xc0
	ldr r3, [r2, #0]
	mov r2, #0x28
	mov r1, #0x17
	mul r2, r4
	strb r1, [r3, r2]
	ldr r2, [r5, #0x14]
	mov r1, #0x10
	ldrsh r1, [r2, r1]
	str r1, [r6, #8]
	ldr r1, [r5, #8]
	str r1, [r0, #0x58]
	b _02157916
_021578EC:
	mov r1, r0
	add r1, #0xb8
	mov r2, r0
	strh r4, [r1]
	add r2, #0xc0
	sub r3, r4, #1
	ldr r7, [r2, #0]
	mov r2, #0x28
	mov r6, r3
	mov r1, #0x18
	mul r6, r2
	strb r1, [r7, r6]
	mov r1, r0
	add r1, #0xc0
	ldr r3, [r1, #0]
	mov r1, r4
	mov r6, #0x19
	mul r1, r2
	strb r6, [r3, r1]
	ldr r1, [r5, #8]
	str r1, [r0, #0x58]
_02157916:
	sub r1, r4, #1
	mov r3, r1
	mov r1, r0
	add r1, #0xc0
	mov r5, #0x28
	ldr r1, [r1, #0]
	mul r3, r5
	mov r2, #0
	add r1, r1, r3
	strh r2, [r1, #0xa]
	mov r1, r4
	mov r4, r0
	add r4, #0xc0
	ldr r4, [r4, #0]
	mul r1, r5
	add r4, r4, r1
	strh r2, [r4, #0xa]
	mov r4, r0
	add r4, #0xc0
	ldr r4, [r4, #0]
	add r0, #0xc0
	add r3, r4, r3
	strh r2, [r3, #4]
	ldr r0, [r0, #0]
	add r0, r0, r1
	strh r2, [r0, #4]
	pop {r3, r4, r5, r6, r7, pc}
	thumb_func_end SailVoyageManager__Func_2157894

	thumb_func_start SailVoyageManager__Func_215794C
SailVoyageManager__Func_215794C: // 0x0215794C
	push {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r0, [r4, #0x10]
	cmp r0, #5
	bhi _02157996
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02157966: // jump table
	.hword _02157972 - _02157966 - 2 // case 0
	.hword _02157976 - _02157966 - 2 // case 1
	.hword _0215797A - _02157966 - 2 // case 2
	.hword _0215797E - _02157966 - 2 // case 3
	.hword _0215798E - _02157966 - 2 // case 4
	.hword _02157992 - _02157966 - 2 // case 5
_02157972:
	mov r0, #0
	pop {r4, pc}
_02157976:
	mov r0, #5
	pop {r4, pc}
_0215797A:
	mov r0, #3
	pop {r4, pc}
_0215797E:
	bl SailManager__GetShipType
	cmp r0, #2
	bne _0215798A
	mov r0, #2
	pop {r4, pc}
_0215798A:
	mov r0, #1
	pop {r4, pc}
_0215798E:
	mov r0, #6
	pop {r4, pc}
_02157992:
	mov r0, #4
	pop {r4, pc}
_02157996:
	mov r0, #0
	pop {r4, pc}
	.align 2, 0
	thumb_func_end SailVoyageManager__Func_215794C

	thumb_func_start SailVoyageManager__Func_215799C
SailVoyageManager__Func_215799C: // 0x0215799C
	push {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r1, [r4, #0x10]
	cmp r1, #3
	bhi _021579D2
	add r0, r1, r1
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_021579B6: // jump table
	.hword _021579BE - _021579B6 - 2 // case 0
	.hword _021579BE - _021579B6 - 2 // case 1
	.hword _021579C2 - _021579B6 - 2 // case 2
	.hword _021579CA - _021579B6 - 2 // case 3
_021579BE:
	mov r0, #0
	pop {r4, pc}
_021579C2:
	sub r0, r1, #1
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	pop {r4, pc}
_021579CA:
	sub r0, r1, #1
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	pop {r4, pc}
_021579D2:
	mov r0, #0
	pop {r4, pc}
	.align 2, 0
	thumb_func_end SailVoyageManager__Func_215799C

	thumb_func_start SailVoyageManager__SetupVoyage
SailVoyageManager__SetupVoyage: // 0x021579D8
	push {r3, r4, r5, r6, r7, lr}
	bl SailManager__GetWork
	mov r5, r0
	ldr r6, _02157ADC // =gameState
	bl SailManager__GetWork
	add r0, #0x98
	ldr r4, [r0, #0]
	ldr r0, [r5, #0xc]
	cmp r0, #0
	bne _02157A04
	ldrh r0, [r5, #0x12]
	cmp r0, #0
	bne _02157A04
	add r6, #0x8c
	ldrh r0, [r6, #0]
	cmp r0, #0
	beq _02157A04
	mov r0, r4
	bl SailVoyageManager__Func_21574B4
_02157A04:
	ldrh r0, [r5, #0x12]
	cmp r0, #6
	bne _02157A8A
	mov r0, r4
	mov r1, #0x1a
	add r0, #0xb8
	strh r1, [r0]
	bl SailManager__GetShipType
	cmp r0, #1
	bne _02157A22
	mov r0, r4
	mov r1, #0x12
	add r0, #0xb8
	strh r1, [r0]
_02157A22:
	bl SailManager__GetShipType
	cmp r0, #3
	bne _02157A32
	mov r0, r4
	mov r1, #0x1e
	add r0, #0xb8
	strh r1, [r0]
_02157A32:
	mov r0, r4
	add r0, #0xb8
	ldrh r1, [r0, #0]
	mov r6, #0
	add r0, r1, #1
	cmp r0, #0
	ble _02157A66
	ldr r7, _02157AE0 // =0x000005DC
	mov r0, #0x28
_02157A44:
	mov r1, r4
	add r1, #0xc0
	ldr r2, [r1, #0]
	mov r1, r6
	mul r1, r0
	ldr r3, [r5, r7]
	add r1, r2, r1
	strb r3, [r1, #1]
	add r1, r6, #1
	lsl r1, r1, #0x10
	lsr r6, r1, #0x10
	mov r1, r4
	add r1, #0xb8
	ldrh r1, [r1, #0]
	add r2, r1, #1
	cmp r6, r2
	blt _02157A44
_02157A66:
	mov r2, r4
	add r2, #0xc0
	sub r1, r1, #1
	ldr r5, [r2, #0]
	mov r3, r1
	mov r2, #0x28
	mov r1, r4
	mov r0, #0x1a
	mul r3, r2
	strb r0, [r5, r3]
	add r1, #0xc0
	ldr r3, [r1, #0]
	mov r1, r4
	add r1, #0xb8
	ldrh r1, [r1, #0]
	mov r0, #0x1b
	mul r2, r1
	strb r0, [r3, r2]
_02157A8A:
	bl SailManager__GetShipType
	cmp r0, #3
	bne _02157AC0
	mov r0, #2
	lsl r0, r0, #0xe
	strh r0, [r4, #0x34]
	ldrh r0, [r4, #0x34]
	mov r1, #0
	mov r3, #0x28
	strh r0, [r4, #0x36]
	mov r0, r1
_02157AA2:
	mov r2, r4
	add r2, #0xc0
	ldr r5, [r2, #0]
	mov r2, r1
	mul r2, r3
	add r2, r5, r2
	strh r0, [r2, #4]
	mov r2, r4
	add r2, #0xb8
	add r1, r1, #1
	lsl r1, r1, #0x10
	ldrh r2, [r2, #0]
	lsr r1, r1, #0x10
	cmp r1, r2
	bls _02157AA2
_02157AC0:
	bl SailEventManager__ProcessSBB
	mov r0, r4
	bl SailVoyageManager__LinkSegments
	mov r0, #0
	mov r1, r0
	bl SailEventManager__LoadMapObjects
	mov r0, #1
	mov r1, #0
	bl SailEventManager__LoadMapObjects
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02157ADC: .word gameState
_02157AE0: .word 0x000005DC
	thumb_func_end SailVoyageManager__SetupVoyage

	thumb_func_start SailVoyageManager__Func_2157AE4
SailVoyageManager__Func_2157AE4: // 0x02157AE4
	push {r3, lr}
	bl SailManager__GetWork
	add r0, #0x98
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x44]
	pop {r3, pc}
	.align 2, 0
	thumb_func_end SailVoyageManager__Func_2157AE4

	thumb_func_start SailVoyageManager__Func_2157AF4
SailVoyageManager__Func_2157AF4: // 0x02157AF4
	push {r3, lr}
	bl SailManager__GetWork
	add r0, #0x98
	ldr r0, [r0, #0]
	add r0, #0x28
	pop {r3, pc}
	.align 2, 0
	thumb_func_end SailVoyageManager__Func_2157AF4

	thumb_func_start SailVoyageManager__Func_2157B04
SailVoyageManager__Func_2157B04: // 0x02157B04
	push {r3, lr}
	bl SailManager__GetWork
	add r0, #0x98
	ldr r0, [r0, #0]
	ldrh r0, [r0, #0x34]
	pop {r3, pc}
	.align 2, 0
	thumb_func_end SailVoyageManager__Func_2157B04

	thumb_func_start SailVoyageManager__Func_2157B14
SailVoyageManager__Func_2157B14: // 0x02157B14
	mov r0, #2
	lsl r0, r0, #0x12
	bx lr
	.align 2, 0
	thumb_func_end SailVoyageManager__Func_2157B14

	thumb_func_start SailVoyageManager__Main
SailVoyageManager__Main: // 0x02157B1C
	push {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailManager__GetWork
	mov r5, r0
	mov r0, r4
	bl SailVoyageManager__Func_2157C34
	mov r0, r4
	add r0, #0xbc
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _02157B5E
	mov r0, r4
	add r0, #0xbc
	ldr r1, [r0, #0]
	mov r0, #1
	lsl r0, r0, #0xa
	sub r1, r1, r0
	mov r0, r4
	add r0, #0xbc
	str r1, [r0]
	mov r0, r4
	add r0, #0xbc
	ldr r0, [r0, #0]
	cmp r0, #0
	bge _02157B5E
	mov r0, r4
	mov r1, #0
	add r0, #0xbc
	str r1, [r0]
_02157B5E:
	bl SailManager__GetShipType
	cmp r0, #3
	beq _02157C30
	ldr r1, [r4, #0x44]
	ldr r0, [r4, #0x48]
	asr r1, r1, #0x13
	lsl r1, r1, #0x10
	lsr r2, r1, #0x10
	mov r1, #0x28
	mul r1, r2
	mov r2, r4
	add r2, #0xc0
	ldr r3, [r2, #0]
	asr r0, r0, #0x13
	lsl r0, r0, #0x10
	ldrb r2, [r3, r1]
	lsr r0, r0, #0x10
	cmp r2, #0xc
	bgt _02157B9E
	bge _02157BAA
	cmp r2, #5
	bgt _02157B98
	cmp r2, #4
	blt _02157BBC
	beq _02157BCE
	cmp r2, #5
	beq _02157BAA
	b _02157BBC
_02157B98:
	cmp r2, #0xb
	beq _02157BCE
	b _02157BBC
_02157B9E:
	cmp r2, #0x12
	bgt _02157BA6
	beq _02157BAA
	b _02157BBC
_02157BA6:
	cmp r2, #0x13
	bne _02157BBC
_02157BAA:
	mov r0, r4
	add r0, #0xba
	ldrh r2, [r0, #0]
	mov r0, #2
	orr r2, r0
	mov r0, r4
	add r0, #0xba
	strh r2, [r0]
	b _02157BE6
_02157BBC:
	mov r0, r5
	add r0, #0x5a
	ldrh r0, [r0, #0]
	cmp r0, #3
	bne _02157BE6
	mov r0, #2
	add r5, #0x5a
	strh r0, [r5]
	b _02157BE6
_02157BCE:
	cmp r0, #0
	beq _02157BE0
	mov r2, #0x28
	mul r2, r0
	ldrb r0, [r3, r2]
	cmp r0, #4
	beq _02157BE6
	cmp r0, #0xb
	beq _02157BE6
_02157BE0:
	mov r0, #3
	add r5, #0x5a
	strh r0, [r5]
_02157BE6:
	mov r0, r4
	add r0, #0xc0
	ldr r0, [r0, #0]
	ldrb r0, [r0, r1]
	cmp r0, #0
	bne _02157C02
	mov r0, r4
	add r0, #0xba
	ldrh r1, [r0, #0]
	mov r0, #2
	bic r1, r0
	mov r0, r4
	add r0, #0xba
	strh r1, [r0]
_02157C02:
	mov r0, r4
	add r0, #0xba
	ldrh r0, [r0, #0]
	mov r1, #2
	tst r0, r1
	beq _02157C30
	mov r0, r4
	add r0, #0xbc
	ldr r2, [r0, #0]
	lsl r0, r1, #0xa
	add r1, r2, r0
	mov r0, r4
	add r0, #0xbc
	str r1, [r0]
	mov r0, r4
	add r0, #0xbc
	ldr r1, [r0, #0]
	mov r0, #0xa
	lsl r0, r0, #0xc
	cmp r1, r0
	ble _02157C30
	add r4, #0xbc
	str r0, [r4]
_02157C30:
	pop {r3, r4, r5, pc}
	.align 2, 0
	thumb_func_end SailVoyageManager__Main

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
	bl SailVoyageManager__Func_2157B14
	ldr r1, [r5, #0x4c]
	cmp r1, r0
	bge _02157D8E
_02157D8C:
	b _02157F08
_02157D8E:
	mov r0, r4
	bl SailVoyageManager__Func_2157B14
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
	bl SailVoyageManager__Func_2157B14
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
	bl SailVoyageManager__Func_2157B14
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
	bl SailVoyageManager__Func_2157B14
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
	bl SailVoyageManager__Func_2157B14
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

	thumb_func_start SailVoyageManager__Func_2158028
SailVoyageManager__Func_2158028: // 0x02158028
	push {r4, r5, r6, r7, lr}
	sub sp, #0x54
	str r1, [sp, #4]
	mov r5, r0
	bl SailManager__GetWork
	mov r4, r0
	ldr r7, _02158220 // =gameState
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	mov r6, #0
	str r0, [sp, #8]
	cmp r0, #0
	beq _02158052
	bl SailManager__GetWork
	ldr r1, [r0, #0x70]
	mov r0, #0x49
	lsl r0, r0, #2
	ldr r6, [r1, r0]
_02158052:
	ldr r0, [r4, #0x24]
	mov r2, #8
	mov r1, r0
	tst r1, r2
	beq _0215805E
	b _0215821C
_0215805E:
	ldr r1, [sp, #4]
	sub r1, #0xe
	str r1, [sp, #4]
	cmp r1, #0xd
	bhi _02158138
	ldr r1, [sp, #4]
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add pc, r1
_02158076: // jump table
	.hword _0215809C - _02158076 - 2 // case 0
	.hword _02158138 - _02158076 - 2 // case 1
	.hword _021580F6 - _02158076 - 2 // case 2
	.hword _02158196 - _02158076 - 2 // case 3
	.hword _021580F6 - _02158076 - 2 // case 4
	.hword _02158196 - _02158076 - 2 // case 5
	.hword _021580F6 - _02158076 - 2 // case 6
	.hword _02158196 - _02158076 - 2 // case 7
	.hword _02158092 - _02158076 - 2 // case 8
	.hword _021581BA - _02158076 - 2 // case 9
	.hword _02158138 - _02158076 - 2 // case 10
	.hword _02158138 - _02158076 - 2 // case 11
	.hword _021580F6 - _02158076 - 2 // case 12
	.hword _021581E6 - _02158076 - 2 // case 13
_02158092:
	lsl r1, r2, #6
	orr r0, r1
	add sp, #0x54
	str r0, [r4, #0x24]
	pop {r4, r5, r6, r7, pc}
_0215809C:
	ldr r3, _02158224 // =_0218BBB4
	add r2, sp, #0xc
	ldmia r3!, {r0, r1}
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	ldr r3, _02158228 // =FX_SinCosTable_
	str r0, [r2]
	ldrh r0, [r5, #0x34]
	asr r0, r0, #4
	lsl r2, r0, #1
	lsl r1, r2, #1
	add r2, r2, #1
	lsl r2, r2, #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, sp, #0x18
	bl MTX_RotY33_
	add r0, sp, #0xc
	add r1, sp, #0x18
	mov r2, r0
	bl MTX_MultVec33
	mov r6, r5
	add r3, sp, #0x3c
	ldmia r6!, {r0, r1}
	mov r2, r3
	stmia r3!, {r0, r1}
	ldr r0, [r6, #0]
	add r1, sp, #0xc
	str r0, [r3]
	mov r0, r2
	bl VEC_Add
	mov r1, #0
	add r0, sp, #0xc
	strh r1, [r0, #0x3c]
	mov r1, #6
	lsl r1, r1, #6
	add r0, sp, #0x3c
	strh r1, [r0, #0x10]
	ldr r1, [r4, #4]
	str r1, [sp, #0x50]
	bl SailEventManager__LoadObject
_021580F6:
	ldr r0, [r4, #0xc]
	ldr r1, [r5, #0x44]
	cmp r0, #0
	ldr r0, _0215822C // =0xFFF80000
	bne _0215810E
	and r1, r0
	mov r0, #2
	lsl r0, r0, #0x12
	add r0, r1, r0
	bl SailGoalText__Create
	b _0215811A
_0215810E:
	and r1, r0
	mov r0, #2
	lsl r0, r0, #0x12
	add r0, r1, r0
	bl SailChaosEmerald__Create
_0215811A:
	ldr r1, [r5, #0x44]
	ldr r0, _0215822C // =0xFFF80000
	and r1, r0
	mov r0, #2
	lsl r0, r0, #0x12
	add r0, r1, r0
	bl SailGoal__Create
	mov r0, #2
	ldr r1, [r4, #0x24]
	lsl r0, r0, #8
	orr r0, r1
	add sp, #0x54
	str r0, [r4, #0x24]
	pop {r4, r5, r6, r7, pc}
_02158138:
	ldr r0, [r5, #0x58]
	mov r1, #0
	str r0, [r5, #0x54]
	ldr r0, _02158230 // =defaultTrackPlayer
	bl NNS_SndPlayerStopSeq
	mov r0, #5
	str r0, [sp]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlayTrack
	ldr r1, [r4, #0x24]
	mov r0, #0x20
	orr r0, r1
	str r0, [r4, #0x24]
	ldr r0, [sp, #8]
	bl SailPlayer__Action_ReachedGoal
	ldr r0, [r4, #4]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	bl SeaMapEventManager__Func_2046CE8
	mov r1, #1
	ldr r2, [r4, #0x24]
	lsl r1, r1, #0xc
	tst r1, r2
	bne _0215821C
	bl SeaMapEventManager__CheckFeatureUnlocked
	cmp r0, #0
	bne _02158188
	mov r0, #2
	ldr r1, [r4, #0x24]
	lsl r0, r0, #0x12
	orr r0, r1
	str r0, [r4, #0x24]
_02158188:
	ldr r1, [r4, #4]
	mov r0, #7
	mov r2, #0
	bl SeaMapUnknown204A9E4__RunCallbacks
	add sp, #0x54
	pop {r4, r5, r6, r7, pc}
_02158196:
	ldr r0, [r5, #0x58]
	str r0, [r5, #0x54]
	ldr r1, [r4, #0x24]
	mov r0, #0x40
	orr r0, r1
	str r0, [r4, #0x24]
	ldr r0, [sp, #8]
	bl SailPlayer__Action_ReachedGoal
	cmp r6, #0
	beq _0215821C
	mov r0, #0x6e
	lsl r0, r0, #2
	ldr r0, [r6, r0]
	add r7, #0xac
	add sp, #0x54
	str r0, [r7]
	pop {r4, r5, r6, r7, pc}
_021581BA:
	ldr r0, [r5, #0x58]
	str r0, [r5, #0x54]
	ldr r1, [r4, #0x24]
	lsl r0, r2, #0xb
	orr r0, r1
	str r0, [r4, #0x24]
	ldr r0, [sp, #8]
	bl SailPlayer__Action_ReachedGoal
	cmp r6, #0
	beq _021581DC
	mov r0, #0x6e
	lsl r0, r0, #2
	ldr r1, [r6, r0]
	mov r0, r7
	add r0, #0xac
	str r1, [r0]
_021581DC:
	ldr r0, [r5, #0x54]
	add r7, #0xa8
	add sp, #0x54
	str r0, [r7]
	pop {r4, r5, r6, r7, pc}
_021581E6:
	lsl r1, r2, #0x16
	orr r0, r1
	str r0, [r4, #0x24]
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _02158212
	mov r0, r7
	add r0, #0xb8
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02158212
	cmp r6, #0
	beq _02158212
	mov r0, r7
	add r0, #0xac
	ldr r0, [r0, #0]
	add r7, #0xac
	str r0, [r4, #0x2c]
	mov r0, #0x6e
	lsl r0, r0, #2
	ldr r0, [r6, r0]
	str r0, [r7]
_02158212:
	ldr r0, [r5, #0x58]
	str r0, [r5, #0x54]
	ldr r0, [sp, #8]
	bl SailPlayer__Action_ReachedGoal
_0215821C:
	add sp, #0x54
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02158220: .word gameState
_02158224: .word _0218BBB4
_02158228: .word FX_SinCosTable_
_0215822C: .word 0xFFF80000
_02158230: .word defaultTrackPlayer
	thumb_func_end SailVoyageManager__Func_2158028

	thumb_func_start SailVoyageManager__Func_2158234
SailVoyageManager__Func_2158234: // 0x02158234
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x30
	mov r5, r0
	bl SailManager__GetWork
	str r0, [sp, #8]
	bl SailManager__GetShipType
	cmp r0, #3
	beq _02158340
	ldr r0, [sp, #8]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _02158340
	ldr r0, [sp, #8]
	ldrh r0, [r0, #0x12]
	cmp r0, #0
	bne _02158340
	mov r1, r5
	add r1, #0xfe
	ldrh r4, [r1, #0]
	mov r0, #0
	cmp r4, #0
	bls _02158288
	mov r2, #0x10
_02158266:
	lsl r1, r0, #3
	add r1, r5, r1
	add r1, #0xcc
	ldr r1, [r1, #0]
	ldrsh r3, [r1, r2]
	lsl r1, r0, #1
	add r1, r5, r1
	add r1, #0xf4
	strh r3, [r1]
	mov r1, r5
	add r1, #0xfe
	add r0, r0, #1
	lsl r0, r0, #0x10
	ldrh r4, [r1, #0]
	lsr r0, r0, #0x10
	cmp r0, r4
	blo _02158266
_02158288:
	mov r0, r5
	mov r1, #5
	add r0, #0xfe
	strh r1, [r0]
	mov r0, r5
	add r0, #0xfe
	str r0, [sp]
	mov r2, #1
	mov r3, r5
	ldr r0, [r5, #0x5c]
	ldr r1, [r5, #0x60]
	lsl r2, r2, #0x12
	add r3, #0xcc
	bl SeaMapEventManager__Func_2046B14
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r5
	add r0, #0xfe
	ldrh r0, [r0, #0]
	cmp r0, #0
	bls _02158340
_021582B4:
	mov r1, #1
	mov r0, #0
	cmp r4, #0
	bls _021582EE
	ldr r2, [sp, #4]
	mov r7, r0
	lsl r2, r2, #3
	add r2, r5, r2
	add r2, #0xcc
	ldr r3, [r2, #0]
	mov r2, #0x10
	ldrsh r2, [r3, r2]
	ldr r3, [sp, #8]
	ldr r3, [r3, #4]
_021582D0:
	lsl r6, r0, #1
	add r6, r5, r6
	add r6, #0xf4
	ldrh r6, [r6, #0]
	cmp r6, r2
	bne _021582DE
	mov r1, r7
_021582DE:
	cmp r3, r2
	bne _021582E4
	mov r1, #0
_021582E4:
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	cmp r0, r4
	blo _021582D0
_021582EE:
	cmp r1, #0
	beq _0215832A
	add r0, sp, #0xc
	mov r7, #0
	str r7, [r0]
	str r7, [r0, #4]
	add r3, sp, #0x18
	mov r6, r5
	str r7, [r0, #8]
	ldmia r6!, {r0, r1}
	mov r2, r3
	stmia r3!, {r0, r1}
	ldr r0, [r6, #0]
	mov r1, #6
	str r0, [r3]
	add r0, sp, #0xc
	strh r7, [r0, #0x18]
	lsl r1, r1, #6
	strh r1, [r0, #0x1c]
	ldr r0, [sp, #4]
	lsl r0, r0, #3
	add r0, r5, r0
	add r0, #0xcc
	ldr r1, [r0, #0]
	mov r0, #0x10
	ldrsh r0, [r1, r0]
	str r0, [sp, #0x2c]
	mov r0, r2
	bl SailEventManager__LoadObject
_0215832A:
	ldr r0, [sp, #4]
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #4]
	mov r0, r5
	add r0, #0xfe
	ldrh r1, [r0, #0]
	ldr r0, [sp, #4]
	cmp r0, r1
	blo _021582B4
_02158340:
	add sp, #0x30
	pop {r3, r4, r5, r6, r7, pc}
	thumb_func_end SailVoyageManager__Func_2158234

	thumb_func_start SailVoyageManager__LinkSegments
SailVoyageManager__LinkSegments: // 0x02158344
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x30
	str r0, [sp, #4]
	add r1, sp, #0x28
	mov r0, #0
	str r0, [r1]
	str r0, [r1, #4]
	add r1, sp, #0x20
	str r0, [r1]
	str r0, [r1, #4]
	ldr r1, [sp, #4]
	add r1, #0xc0
	ldr r4, [r1, #0]
	ldr r1, [sp, #4]
	ldr r1, [r1, #0x18]
	str r1, [r4, #0xc]
	ldr r1, [sp, #4]
	ldr r2, [r1, #0x20]
	str r2, [r4, #0x10]
	ldr r1, [r4, #0xc]
	str r1, [r4, #0x14]
	ldr r1, [sp, #4]
	str r2, [r4, #0x18]
	ldrh r1, [r1, #0x34]
	strh r1, [r4, #2]
	strh r0, [r4, #4]
	str r0, [r4, #0x24]
	ldrh r0, [r4, #2]
	asr r0, r0, #4
	lsl r1, r0, #2
	ldr r0, _02158684 // =FX_SinCosTable_
	ldrsh r5, [r0, r1]
	mov r0, r4
	bl SailVoyageManager__Func_2157B14
	neg r0, r0
	asr r1, r0, #0x1f
	asr r3, r5, #0x1f
	mov r2, r5
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	str r1, [sp, #0x28]
	ldrh r0, [r4, #2]
	asr r0, r0, #4
	lsl r0, r0, #1
	add r0, r0, #1
	lsl r1, r0, #1
	ldr r0, _02158684 // =FX_SinCosTable_
	ldrsh r5, [r0, r1]
	mov r0, r4
	bl SailVoyageManager__Func_2157B14
	neg r0, r0
	asr r1, r0, #0x1f
	asr r3, r5, #0x1f
	mov r2, r5
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	str r1, [sp, #0x2c]
	ldr r1, [r4, #0xc]
	ldr r0, [sp, #0x28]
	ldr r7, _02158684 // =FX_SinCosTable_
	add r0, r1, r0
	str r0, [r4, #0x1c]
	ldr r1, [r4, #0x10]
	ldr r0, [sp, #0x2c]
	mov r6, #1
	add r0, r1, r0
	str r0, [r4, #0x20]
	ldr r0, [sp, #0x28]
	asr r1, r0, #1
	ldr r0, [sp, #0x2c]
	str r1, [sp, #0x28]
	asr r0, r0, #1
	str r0, [sp, #0x2c]
	ldr r0, [r4, #0xc]
	add r0, r0, r1
	str r0, [r4, #0x14]
	ldr r1, [r4, #0x10]
	ldr r0, [sp, #0x2c]
	add r0, r1, r0
	str r0, [r4, #0x18]
_02158408:
	ldr r0, [sp, #4]
	sub r2, r6, #1
	add r0, #0xc0
	mov r1, #0x28
	ldr r0, [r0, #0]
	mul r1, r2
	add r4, r0, r1
	mov r1, #0x28
	mul r1, r6
	add r5, r0, r1
	ldr r0, [r4, #0x24]
	str r0, [r5, #0x24]
	ldrh r0, [r4, #2]
	strh r0, [r5, #2]
	ldr r1, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	str r1, [r5, #0xc]
	str r0, [r5, #0x10]
	mov r0, r4
	bl SailVoyageManager__Func_2157B14
	ldr r1, [r5, #0x24]
	add r0, r1, r0
	str r0, [r5, #0x24]
	mov r0, #4
	ldrh r1, [r5, #2]
	ldrsh r0, [r4, r0]
	add r0, r1, r0
	strh r0, [r5, #2]
	mov r1, #4
	ldrsh r1, [r5, r1]
	ldrh r0, [r5, #2]
	asr r1, r1, #1
	add r0, r0, r1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	asr r0, r0, #4
	lsl r0, r0, #2
	ldrsh r0, [r7, r0]
	str r0, [sp, #0x1c]
	mov r0, r5
	bl SailVoyageManager__Func_2157B14
	ldr r2, [sp, #0x1c]
	neg r0, r0
	asr r1, r0, #0x1f
	asr r3, r2, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r0, r0, r2
	ldr r2, _02158688 // =0x00000000
	adc r1, r2
	lsl r1, r1, #0x14
	lsr r0, r0, #0xc
	orr r0, r1
	str r0, [sp, #0x28]
	mov r1, #4
	ldrsh r1, [r5, r1]
	ldrh r0, [r5, #2]
	asr r1, r1, #1
	add r0, r0, r1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	asr r0, r0, #4
	lsl r0, r0, #2
	add r1, r7, r0
	mov r0, #2
	ldrsh r0, [r1, r0]
	str r0, [sp, #0x18]
	mov r0, r5
	bl SailVoyageManager__Func_2157B14
	ldr r2, [sp, #0x18]
	neg r0, r0
	asr r1, r0, #0x1f
	asr r3, r2, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r0, r0, r2
	ldr r2, _02158688 // =0x00000000
	adc r1, r2
	lsl r1, r1, #0x14
	lsr r0, r0, #0xc
	orr r0, r1
	str r0, [sp, #0x2c]
	ldr r1, [r5, #0xc]
	ldr r0, [sp, #0x28]
	add r0, r1, r0
	str r0, [r5, #0x1c]
	ldr r1, [r5, #0x10]
	ldr r0, [sp, #0x2c]
	add r0, r1, r0
	str r0, [r5, #0x20]
	mov r0, #4
	ldrsh r1, [r5, r0]
	cmp r1, #0
	beq _021584E0
	lsl r0, r0, #0xd
	cmp r1, r0
	bne _0215855A
_021584E0:
	ldrh r0, [r5, #2]
	asr r0, r0, #4
	lsl r0, r0, #2
	ldrsh r0, [r7, r0]
	str r0, [sp, #0x14]
	mov r0, r4
	bl SailVoyageManager__Func_2157B14
	ldr r2, [sp, #0x14]
	neg r0, r0
	asr r1, r0, #0x1f
	asr r3, r2, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r0, r0, r2
	ldr r2, _02158688 // =0x00000000
	adc r1, r2
	lsl r1, r1, #0x14
	lsr r0, r0, #0xc
	orr r0, r1
	str r0, [sp, #0x28]
	ldrh r0, [r5, #2]
	asr r0, r0, #4
	lsl r0, r0, #2
	add r1, r7, r0
	mov r0, #2
	ldrsh r0, [r1, r0]
	str r0, [sp, #0x10]
	mov r0, r4
	bl SailVoyageManager__Func_2157B14
	ldr r2, [sp, #0x10]
	neg r0, r0
	asr r1, r0, #0x1f
	asr r3, r2, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _02158688 // =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r2, r2, #0xc
	orr r2, r0
	ldr r0, [sp, #0x28]
	str r2, [sp, #0x2c]
	asr r1, r0, #1
	asr r0, r2, #1
	str r1, [sp, #0x28]
	str r0, [sp, #0x2c]
	ldr r0, [r5, #0xc]
	add r0, r0, r1
	str r0, [r5, #0x14]
	ldr r1, [r5, #0x10]
	ldr r0, [sp, #0x2c]
	add r0, r1, r0
	str r0, [r5, #0x18]
	b _02158664
_0215855A:
	ldrh r0, [r5, #2]
	asr r0, r0, #4
	lsl r0, r0, #2
	ldrsh r0, [r7, r0]
	str r0, [sp, #0xc]
	mov r0, r4
	bl SailVoyageManager__Func_2157B14
	ldr r2, [sp, #0xc]
	neg r0, r0
	asr r1, r0, #0x1f
	asr r3, r2, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r0, r0, r2
	ldr r2, _02158688 // =0x00000000
	adc r1, r2
	lsl r1, r1, #0x14
	lsr r0, r0, #0xc
	orr r0, r1
	str r0, [sp, #0x28]
	ldrh r0, [r5, #2]
	asr r0, r0, #4
	lsl r0, r0, #2
	add r1, r7, r0
	mov r0, #2
	ldrsh r0, [r1, r0]
	str r0, [sp, #8]
	mov r0, r4
	bl SailVoyageManager__Func_2157B14
	ldr r2, [sp, #8]
	neg r0, r0
	asr r1, r0, #0x1f
	asr r3, r2, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _02158688 // =0x00000000
	adc r1, r0
	lsr r0, r2, #0xc
	lsl r1, r1, #0x14
	orr r0, r1
	str r0, [sp, #0x2c]
	ldr r2, [sp, #0x28]
	ldr r1, [r5, #0xc]
	add r1, r2, r1
	str r1, [sp, #0x28]
	ldr r1, [r5, #0x10]
	add r0, r0, r1
	str r0, [sp, #0x2c]
	mov r0, #4
	ldrh r1, [r5, #2]
	ldrsh r0, [r5, r0]
	add r0, r1, r0
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	asr r0, r0, #4
	lsl r0, r0, #2
	ldrsh r4, [r7, r0]
	mov r0, r5
	bl SailVoyageManager__Func_2157B14
	neg r0, r0
	asr r1, r0, #0x1f
	asr r3, r4, #0x1f
	mov r2, r4
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _02158688 // =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	str r1, [sp, #0x20]
	mov r0, #4
	ldrh r1, [r5, #2]
	ldrsh r0, [r5, r0]
	add r0, r1, r0
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	asr r0, r0, #4
	lsl r0, r0, #2
	add r1, r7, r0
	mov r0, #2
	ldrsh r4, [r1, r0]
	mov r0, r5
	bl SailVoyageManager__Func_2157B14
	neg r0, r0
	asr r1, r0, #0x1f
	asr r3, r4, #0x1f
	mov r2, r4
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _02158688 // =0x00000000
	add r3, sp, #0x20
	adc r1, r0
	lsr r0, r2, #0xc
	lsl r1, r1, #0x14
	orr r0, r1
	str r0, [sp, #0x24]
	ldr r2, [sp, #0x20]
	ldr r1, [r5, #0x1c]
	add r1, r2, r1
	str r1, [sp, #0x20]
	ldr r1, [r5, #0x20]
	add r0, r0, r1
	str r0, [sp, #0x24]
	mov r0, r5
	add r0, #0x14
	str r0, [sp]
	mov r0, r5
	add r5, #0x1c
	add r0, #0xc
	add r1, sp, #0x28
	mov r2, r5
	bl SailVoyageManager__Func_215868C
_02158664:
	ldr r0, [sp, #4]
	add r0, #0xb8
	ldrh r0, [r0, #0]
	add r0, r0, #1
	cmp r6, r0
	beq _02158680
	add r0, r6, #1
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	mov r0, #1
	lsl r0, r0, #8
	cmp r6, r0
	bhs _02158680
	b _02158408
_02158680:
	add sp, #0x30
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02158684: .word FX_SinCosTable_
_02158688: .word 0x00000000
	thumb_func_end SailVoyageManager__LinkSegments

	thumb_func_start SailVoyageManager__Func_215868C
SailVoyageManager__Func_215868C: // 0x0215868C
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x48
	mov r6, r2
	ldr r2, [r0, #4]
	ldr r0, [r0, #0]
	asr r5, r2, #4
	ldr r2, [r1, #4]
	str r3, [sp]
	asr r2, r2, #4
	sub r2, r2, r5
	str r2, [sp, #0x20]
	asr r2, r0, #4
	ldr r0, [r1, #0]
	asr r3, r2, #0x1f
	asr r0, r0, #4
	sub r0, r2, r0
	str r0, [sp, #0x24]
	asr r0, r0, #0x1f
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x20]
	ldr r4, [sp, #0x60]
	neg r0, r0
	asr r1, r0, #0x1f
	bl _ull_mul
	str r0, [sp, #0x2c]
	mov r7, r1
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	asr r3, r5, #0x1f
	mov r2, r5
	bl _ull_mul
	mov r2, r0
	mov r3, r1
	mov r0, #2
	ldr r1, [sp, #0x2c]
	mov r5, #0
	lsl r0, r0, #0xa
	add r0, r1, r0
	adc r7, r5
	lsl r1, r7, #0x14
	lsr r0, r0, #0xc
	orr r0, r1
	mov r1, #2
	lsl r1, r1, #0xa
	add r2, r2, r1
	adc r3, r5
	lsl r1, r3, #0x14
	lsr r2, r2, #0xc
	orr r2, r1
	sub r0, r0, r2
	str r0, [sp, #0x18]
	ldr r0, [r6, #4]
	asr r5, r0, #4
	ldr r0, [sp]
	ldr r0, [r0, #4]
	asr r0, r0, #4
	sub r0, r0, r5
	str r0, [sp, #0x1c]
	ldr r0, [r6, #0]
	asr r2, r0, #4
	ldr r0, [sp]
	asr r3, r2, #0x1f
	ldr r0, [r0, #0]
	asr r0, r0, #4
	sub r6, r2, r0
	ldr r0, [sp, #0x1c]
	asr r7, r6, #0x1f
	neg r0, r0
	asr r1, r0, #0x1f
	bl _ull_mul
	str r0, [sp, #0x30]
	str r1, [sp, #0x10]
	mov r0, r6
	mov r1, r7
	asr r3, r5, #0x1f
	mov r2, r5
	bl _ull_mul
	mov r2, #2
	ldr r3, [sp, #0x30]
	lsl r2, r2, #0xa
	mov r5, #0
	add r3, r3, r2
	ldr r2, [sp, #0x10]
	adc r2, r5
	str r2, [sp, #0x10]
	lsl r2, r2, #0x14
	lsr r3, r3, #0xc
	orr r3, r2
	mov r2, #2
	lsl r2, r2, #0xa
	add r0, r0, r2
	adc r1, r5
	lsl r1, r1, #0x14
	lsr r0, r0, #0xc
	orr r0, r1
	sub r5, r3, r0
	ldr r0, [sp, #0x20]
	ldr r1, [sp, #0x28]
	asr r0, r0, #0x1f
	str r0, [sp, #0x34]
	ldr r0, [sp, #0x1c]
	ldr r2, [sp, #0x1c]
	asr r0, r0, #0x1f
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x24]
	ldr r3, [sp, #0x38]
	bl _ull_mul
	str r0, [sp, #0x3c]
	str r1, [sp, #8]
	ldr r2, [sp, #0x20]
	ldr r3, [sp, #0x34]
	mov r0, r6
	mov r1, r7
	bl _ull_mul
	mov ip, r0
	mov r3, r1
	mov r0, #2
	ldr r1, [sp, #0x3c]
	lsl r0, r0, #0xa
	add r2, r1, r0
	ldr r1, [sp, #8]
	ldr r0, _02158850 // =0x00000000
	adc r1, r0
	str r1, [sp, #8]
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	mov r0, #2
	lsl r0, r0, #0xa
	mov r2, ip
	add r2, r2, r0
	ldr r0, _02158850 // =0x00000000
	adc r3, r0
	lsl r0, r3, #0x14
	lsr r2, r2, #0xc
	orr r2, r0
	sub r0, r1, r2
	str r0, [sp, #0x14]
	beq _0215884A
	asr r0, r5, #0x1f
	str r0, [sp, #0x40]
	ldr r0, [sp, #0x18]
	mov r2, r6
	asr r0, r0, #0x1f
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x44]
	mov r3, r7
	bl _ull_mul
	mov r6, r1
	mov r7, r0
	ldr r1, [sp, #0x40]
	ldr r2, [sp, #0x24]
	ldr r3, [sp, #0x28]
	mov r0, r5
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	ldr r3, _02158850 // =0x00000000
	add r2, r7, r2
	adc r6, r3
	lsl r3, r6, #0x14
	lsr r2, r2, #0xc
	orr r2, r3
	mov r3, #2
	lsl r3, r3, #0xa
	add r3, r0, r3
	ldr r0, _02158850 // =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r3, #0xc
	orr r1, r0
	sub r0, r2, r1
	ldr r1, [sp, #0x14]
	bl FX_Div
	str r0, [r4]
	ldr r0, [sp, #0x20]
	ldr r1, [sp, #0x34]
	ldr r3, [sp, #0x40]
	mov r2, r5
	bl _ull_mul
	mov r6, r0
	mov r5, r1
	ldr r0, [sp, #0x1c]
	ldr r1, [sp, #0x38]
	ldr r2, [sp, #0x18]
	ldr r3, [sp, #0x44]
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r6, r6, r2
	adc r5, r3
	lsl r5, r5, #0x14
	lsr r6, r6, #0xc
	orr r6, r5
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	sub r0, r6, r1
	ldr r1, [sp, #0x14]
	bl FX_Div
	str r0, [r4, #4]
	ldr r0, [r4, #0]
	lsl r0, r0, #4
	str r0, [r4]
	ldr r0, [r4, #4]
	lsl r0, r0, #4
	str r0, [r4, #4]
_0215884A:
	add sp, #0x48
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02158850: .word 0x00000000
	thumb_func_end SailVoyageManager__Func_215868C

	thumb_func_start SailVoyageManager__Func_2158854
SailVoyageManager__Func_2158854: // 0x02158854
	push {r3, r4, r5, lr}
	mov r4, r0
	mov r5, r1
	bl SailManager__GetWork
	mov r2, #4
	ldrsh r2, [r4, r2]
	asr r1, r5, #0x1f
	mov r0, r5
	asr r3, r2, #0x1f
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	ldrh r4, [r4, #2]
	orr r1, r0
	add r0, r4, r1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	pop {r3, r4, r5, pc}
	.align 2, 0
	thumb_func_end SailVoyageManager__Func_2158854

	thumb_func_start SailVoyageManager__Func_2158888
SailVoyageManager__Func_2158888: // 0x02158888
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x40
	mov r4, r0
	mov r7, r1
	str r2, [sp]
	str r3, [sp, #4]
	bl SailManager__GetWork
	mov r0, #1
	lsl r0, r0, #0xc
	sub r0, r0, r7
	asr r5, r0, #0x1f
	mov r1, r5
	mov r2, r0
	mov r3, r5
	str r0, [sp, #0x18]
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsr r6, r2, #0xc
	lsl r0, r1, #0x14
	orr r6, r0
	lsl r0, r7, #1
	ldr r2, [sp, #0x18]
	asr r1, r0, #0x1f
	mov r3, r5
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r5, r2, #0xc
	asr r1, r7, #0x1f
	orr r5, r0
	mov r0, r7
	mov r2, r7
	mov r3, r1
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r0, r0, r2
	adc r1, r3
	lsr r0, r0, #0xc
	lsl r1, r1, #0x14
	str r0, [sp, #0x14]
	orr r0, r1
	add r1, r6, r5
	str r0, [sp, #0x14]
	add r1, r0, r1
	lsl r0, r2, #1
	cmp r1, r0
	beq _02158906
	sub r0, r0, r1
	add r5, r5, r0
_02158906:
	asr r0, r5, #0x1f
	str r0, [sp, #0x1c]
	asr r0, r6, #0x1f
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x14]
	ldr r2, [r4, #0x1c]
	asr r0, r0, #0x1f
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x14]
	ldr r1, [sp, #0x24]
	asr r3, r2, #0x1f
	bl _ull_mul
	ldr r2, [r4, #0xc]
	str r1, [sp, #0xc]
	str r0, [sp, #0x28]
	ldr r1, [sp, #0x20]
	mov r0, r6
	asr r3, r2, #0x1f
	bl _ull_mul
	ldr r2, [r4, #0x14]
	str r1, [sp, #0x3c]
	str r0, [sp, #0x2c]
	ldr r1, [sp, #0x1c]
	mov r0, r5
	asr r3, r2, #0x1f
	bl _ull_mul
	mov ip, r0
	mov r7, r1
	mov r0, #2
	ldr r1, [sp, #0x28]
	lsl r0, r0, #0xa
	add r0, r1, r0
	ldr r2, [sp, #0xc]
	ldr r1, _021589FC // =0x00000000
	adc r2, r1
	str r2, [sp, #0xc]
	lsl r1, r2, #0x14
	lsr r2, r0, #0xc
	orr r2, r1
	mov r0, #2
	ldr r1, [sp, #0x2c]
	lsl r0, r0, #0xa
	add r3, r1, r0
	ldr r1, _021589FC // =0x00000000
	ldr r0, [sp, #0x3c]
	adc r0, r1
	str r0, [sp, #0x3c]
	lsr r1, r3, #0xc
	lsl r0, r0, #0x14
	orr r1, r0
	mov r0, #2
	mov r3, ip
	lsl r0, r0, #0xa
	add r3, r3, r0
	ldr r0, _021589FC // =0x00000000
	adc r7, r0
	lsl r0, r7, #0x14
	lsr r3, r3, #0xc
	orr r3, r0
	add r0, r1, r3
	add r0, r2, r0
	ldr r2, [r4, #0x20]
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	ldr r1, [sp, #0x24]
	asr r3, r2, #0x1f
	bl _ull_mul
	ldr r2, [r4, #0x10]
	mov r7, r1
	str r0, [sp, #0x30]
	ldr r1, [sp, #0x20]
	mov r0, r6
	asr r3, r2, #0x1f
	bl _ull_mul
	ldr r2, [r4, #0x18]
	mov r6, r1
	str r0, [sp, #0x34]
	ldr r1, [sp, #0x1c]
	mov r0, r5
	asr r3, r2, #0x1f
	bl _ull_mul
	mov r3, r0
	mov r0, #2
	mov r4, r1
	ldr r2, [sp, #0x30]
	mov r1, #0
	lsl r0, r0, #0xa
	add r2, r2, r0
	adc r7, r1
	lsl r5, r7, #0x14
	lsr r2, r2, #0xc
	orr r2, r5
	ldr r5, [sp, #0x34]
	add r5, r5, r0
	adc r6, r1
	lsl r6, r6, #0x14
	lsr r5, r5, #0xc
	orr r5, r6
	add r3, r3, r0
	adc r4, r1
	lsl r0, r4, #0x14
	lsr r1, r3, #0xc
	orr r1, r0
	add r0, r5, r1
	add r2, r2, r0
	ldr r0, [sp]
	cmp r0, #0
	beq _021589EE
	ldr r1, [sp, #0x10]
	str r1, [r0]
_021589EE:
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _021589F6
	str r2, [r0]
_021589F6:
	add sp, #0x40
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021589FC: .word 0x00000000
	thumb_func_end SailVoyageManager__Func_2158888

	.rodata

_0218BBA8: // 0x0218BBA8
    .word 0, 1, 0

_0218BBB4: // 0x0218BBB4
    .word 0, 0

_0218BBBC: // 0x0218BBBC
    .word 0xFFEC0000

_0218BBC0: // 0x0218BBC0
    .word 0x4000, 0xE000, 0x8000, 0x6000