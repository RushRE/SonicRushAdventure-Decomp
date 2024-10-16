	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ovl09_2173CC8
ovl09_2173CC8: // 0x02173CC8
	stmdb sp!, {r3, lr}
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _02173DDC
_02173CD8: // jump table
	b _02173DDC // case 0
	b _02173DDC // case 1
	b _02173CFC // case 2
	b _02173CFC // case 3
	b _02173DDC // case 4
	b _02173D88 // case 5
	b _02173DDC // case 6
	b _02173DDC // case 7
	b _02173DB0 // case 8
_02173CFC:
	bl exSysTask__GetStatus
	ldrh r1, [r0, #6]
	ldr r0, _02173E08 // =playerGameStatus
	str r1, [r0, #0x1c]
	bl exSysTask__GetStatus
	ldrh r1, [r0, #0xe]
	ldr r0, _02173E08 // =playerGameStatus
	str r1, [r0, #0xc]
	bl exSysTask__GetStatus
	ldr r1, _02173E08 // =playerGameStatus
	ldrh r2, [r0, #0xc]
	ldr r3, [r1, #0xc]
	mov r0, #0xa
	mla r0, r2, r0, r3
	str r0, [r1, #0xc]
	bl exSysTask__GetStatus
	ldr r1, _02173E08 // =playerGameStatus
	ldrh r2, [r0, #0xa]
	ldr r3, [r1, #0xc]
	mov r0, #0x3c
	mla r3, r2, r0, r3
	mul r0, r3, r0
	str r0, [r1, #0xc]
	bl ovl09_2172A28
	ldr r1, _02173E0C // =saveGame
	mov r2, r0, lsl #0x19
	ldr r3, [r1, #0x1c0]
	mov r0, #9
	bic r3, r3, #0x3f8
	orr r2, r3, r2, lsr #22
	str r2, [r1, #0x1c0]
	bl SaveGame__SetUnknown1
	mov r0, #0
	bl RequestSysEventChange
	b _02173E00
_02173D88:
	bl ovl09_2172A28
	ldr r1, _02173E0C // =saveGame
	mov r2, r0, lsl #0x19
	ldr r3, [r1, #0x1c0]
	mov r0, #1
	bic r3, r3, #0x3f8
	orr r2, r3, r2, lsr #22
	str r2, [r1, #0x1c0]
	bl RequestSysEventChange
	b _02173E00
_02173DB0:
	ldr r0, _02173E0C // =saveGame
	ldr r1, _02173E10 // =gameState
	ldr r3, [r0, #0x1c0]
	mov r2, #6
	bic r3, r3, #0x3f8
	orr r3, r3, #0x10
	str r3, [r0, #0x1c0]
	mov r0, #1
	strb r2, [r1, #0xdc]
	bl RequestSysEventChange
	b _02173E00
_02173DDC:
	bl ovl09_2172A28
	ldr r1, _02173E0C // =saveGame
	mov r2, r0, lsl #0x19
	ldr r3, [r1, #0x1c0]
	mov r0, #1
	bic r3, r3, #0x3f8
	orr r2, r3, r2, lsr #22
	str r2, [r1, #0x1c0]
	bl RequestSysEventChange
_02173E00:
	bl NextSysEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02173E08: .word playerGameStatus
_02173E0C: .word saveGame
_02173E10: .word gameState
	arm_func_end ovl09_2173CC8