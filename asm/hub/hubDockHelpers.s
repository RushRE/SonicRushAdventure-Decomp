	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DockHelpers__Func_2152960
DockHelpers__Func_2152960: // 0x02152960
	ldr r1, _0215296C // =ovl05_02171FE8
	add r0, r1, r0, lsl #6
	bx lr
	.align 2, 0
_0215296C: .word ovl05_02171FE8
	arm_func_end DockHelpers__Func_2152960

	arm_func_start DockHelpers__Func_2152970
DockHelpers__Func_2152970: // 0x02152970
	ldr r2, _02152980 // =DockHelpers__dockStageConfig
	mov r1, #0x44
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_02152980: .word DockHelpers__dockStageConfig
	arm_func_end DockHelpers__Func_2152970

	arm_func_start DockHelpers__Func_2152984
DockHelpers__Func_2152984: // 0x02152984
	ldr r1, _02152990 // =DockHelpers__dockUnknownConfig
	add r0, r1, r0, lsl #3
	bx lr
	.align 2, 0
_02152990: .word DockHelpers__dockUnknownConfig
	arm_func_end DockHelpers__Func_2152984

	arm_func_start DockHelpers__Func_2152994
DockHelpers__Func_2152994: // 0x02152994
	ldr r2, _021529A4 // =DockHelpers__dockMapConfig
	mov r1, #0x28
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_021529A4: .word DockHelpers__dockMapConfig
	arm_func_end DockHelpers__Func_2152994

	arm_func_start DockHelpers__Func_21529A8
DockHelpers__Func_21529A8: // 0x021529A8
	ldr r2, _021529B8 // =ovl05_02171CCC
	mov r1, #0x28
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_021529B8: .word ovl05_02171CCC
	arm_func_end DockHelpers__Func_21529A8

	arm_func_start DockHelpers__GetShipBuildCost
DockHelpers__GetShipBuildCost: // 0x021529BC
	ldr r1, _021529C8 // =DockHelpers__shipBuildCost
	add r0, r1, r0, lsl #4
	bx lr
	.align 2, 0
_021529C8: .word DockHelpers__shipBuildCost
	arm_func_end DockHelpers__GetShipBuildCost

	arm_func_start DockHelpers__GetUnknownPurchaseCost
DockHelpers__GetUnknownPurchaseCost: // 0x021529CC
	ldr r0, _021529D4 // =ovl05_02171838
	bx lr
	.align 2, 0
_021529D4: .word ovl05_02171838
	arm_func_end DockHelpers__GetUnknownPurchaseCost

	arm_func_start DockHelpers__GetInfoPurchaseCost
DockHelpers__GetInfoPurchaseCost: // 0x021529D8
	ldr r1, _021529E4 // =DockHelpers__infoPurchaseCost
	add r0, r1, r0, lsl #4
	bx lr
	.align 2, 0
_021529E4: .word DockHelpers__infoPurchaseCost
	arm_func_end DockHelpers__GetInfoPurchaseCost

	arm_func_start DockHelpers__GetShipUpgradeCost
DockHelpers__GetShipUpgradeCost: // 0x021529E8
	ldr r1, _021529F4 // =DockHelpers__shipUpgradeCost
	add r0, r1, r0, lsl #4
	bx lr
	.align 2, 0
_021529F4: .word DockHelpers__shipUpgradeCost
	arm_func_end DockHelpers__GetShipUpgradeCost

	arm_func_start DockHelpers__GetDockBackInfo
DockHelpers__GetDockBackInfo: // 0x021529F8
	ldr r2, _02152A08 // =DockHelpers__DockBackInfo
	mov r1, #0x1c
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_02152A08: .word DockHelpers__DockBackInfo
	arm_func_end DockHelpers__GetDockBackInfo

	arm_func_start DockHelpers__GetNpcConfig
DockHelpers__GetNpcConfig: // 0x02152A0C
	ldr r2, _02152A1C // =DockHelpers__npcConfig
	mov r1, #0xc
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_02152A1C: .word DockHelpers__npcConfig
	arm_func_end DockHelpers__GetNpcConfig

	arm_func_start DockHelpers__Func_2152A20
DockHelpers__Func_2152A20: // 0x02152A20
	ldr r1, _02152A2C // =ovl05_02171882
	add r0, r1, r0, lsl #1
	bx lr
	.align 2, 0
_02152A2C: .word ovl05_02171882
	arm_func_end DockHelpers__Func_2152A20

	arm_func_start DockHelpers__Func_2152A30
DockHelpers__Func_2152A30: // 0x02152A30
	ldr r1, _02152A3C // =ovl05_02171848
	add r0, r1, r0, lsl #1
	bx lr
	.align 2, 0
_02152A3C: .word ovl05_02171848
	arm_func_end DockHelpers__Func_2152A30

	arm_func_start DockHelpers__Func_2152A40
DockHelpers__Func_2152A40: // 0x02152A40
	ldr r1, _02152A4C // =ovl05_02171864
	add r0, r1, r0, lsl #1
	bx lr
	.align 2, 0
_02152A4C: .word ovl05_02171864
	arm_func_end DockHelpers__Func_2152A40

	arm_func_start DockHelpers__GetMapBackConfig
DockHelpers__GetMapBackConfig: // 0x02152A50
	ldr r1, _02152A5C // =ovl05_021718E0
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152A5C: .word ovl05_021718E0
	arm_func_end DockHelpers__GetMapBackConfig

	arm_func_start DockHelpers__Func_2152A60
DockHelpers__Func_2152A60: // 0x02152A60
	cmp r0, #6
	movls r0, #1
	movhi r0, #0
	bx lr
	arm_func_end DockHelpers__Func_2152A60

	arm_func_start DockHelpers__Func_2152A70
DockHelpers__Func_2152A70: // 0x02152A70
	ldr r0, _02152A78 // =ovl05_02171834
	bx lr
	.align 2, 0
_02152A78: .word ovl05_02171834
	arm_func_end DockHelpers__Func_2152A70

	arm_func_start DockHelpers__Func_2152A7C
DockHelpers__Func_2152A7C: // 0x02152A7C
	ldr r0, _02152A84 // =ovl05_02171834
	bx lr
	.align 2, 0
_02152A84: .word ovl05_02171834
	arm_func_end DockHelpers__Func_2152A7C

	arm_func_start DockHelpers__Func_2152A88
DockHelpers__Func_2152A88: // 0x02152A88
	ldr r0, _02152A90 // =ovl05_02171834
	bx lr
	.align 2, 0
_02152A90: .word ovl05_02171834
	arm_func_end DockHelpers__Func_2152A88

	arm_func_start DockHelpers__Func_2152A94
DockHelpers__Func_2152A94: // 0x02152A94
	ldr r0, _02152A9C // =ovl05_02171834
	bx lr
	.align 2, 0
_02152A9C: .word ovl05_02171834
	arm_func_end DockHelpers__Func_2152A94

	arm_func_start DockHelpers__Func_2152AA0
DockHelpers__Func_2152AA0: // 0x02152AA0
	ldr r0, _02152AA8 // =ovl05_02171834
	bx lr
	.align 2, 0
_02152AA8: .word ovl05_02171834
	arm_func_end DockHelpers__Func_2152AA0

	arm_func_start DockHelpers__Func_2152AAC
DockHelpers__Func_2152AAC: // 0x02152AAC
	ldr r0, _02152AB4 // =ovl05_02171834
	bx lr
	.align 2, 0
_02152AB4: .word ovl05_02171834
	arm_func_end DockHelpers__Func_2152AAC

	arm_func_start DockHelpers__Func_2152AB8
DockHelpers__Func_2152AB8: // 0x02152AB8
	ldr r0, _02152AC0 // =ovl05_02171834
	bx lr
	.align 2, 0
_02152AC0: .word ovl05_02171834
	arm_func_end DockHelpers__Func_2152AB8

	arm_func_start DockHelpers__Func_2152AC4
DockHelpers__Func_2152AC4: // 0x02152AC4
	ldr r0, _02152ACC // =ovl05_02171834
	bx lr
	.align 2, 0
_02152ACC: .word ovl05_02171834
	arm_func_end DockHelpers__Func_2152AC4

	arm_func_start DockHelpers__Func_2152AD0
DockHelpers__Func_2152AD0: // 0x02152AD0
	ldr r0, _02152AD8 // =ovl05_02171834
	bx lr
	.align 2, 0
_02152AD8: .word ovl05_02171834
	arm_func_end DockHelpers__Func_2152AD0

	arm_func_start DockHelpers__Func_2152ADC
DockHelpers__Func_2152ADC: // 0x02152ADC
	ldr r0, _02152AE4 // =ovl05_02171834
	bx lr
	.align 2, 0
_02152AE4: .word ovl05_02171834
	arm_func_end DockHelpers__Func_2152ADC

	arm_func_start DockHelpers__Func_2152AE8
DockHelpers__Func_2152AE8: // 0x02152AE8
	ldr r0, _02152AF0 // =ovl05_02171834
	bx lr
	.align 2, 0
_02152AF0: .word ovl05_02171834
	arm_func_end DockHelpers__Func_2152AE8

	arm_func_start DockHelpers__Func_2152AF4
DockHelpers__Func_2152AF4: // 0x02152AF4
	ldr r0, _02152AFC // =ovl05_0217182C
	bx lr
	.align 2, 0
_02152AFC: .word ovl05_0217182C
	arm_func_end DockHelpers__Func_2152AF4

	arm_func_start DockHelpers__Func_2152B00
DockHelpers__Func_2152B00: // 0x02152B00
	ldr r0, _02152B08 // =ovl05_02171830
	bx lr
	.align 2, 0
_02152B08: .word ovl05_02171830
	arm_func_end DockHelpers__Func_2152B00

	arm_func_start DockHelpers__GetNpcMessageInfo
DockHelpers__GetNpcMessageInfo: // 0x02152B0C
	ldr r1, _02152B18 // =DockHelpers__NpcMsgInfo
	add r0, r1, r0, lsl #3
	bx lr
	.align 2, 0
_02152B18: .word DockHelpers__NpcMsgInfo
	arm_func_end DockHelpers__GetNpcMessageInfo

	arm_func_start DockHelpers__Func_2152B1C
DockHelpers__Func_2152B1C: // 0x02152B1C
	ldr r1, _02152B28 // =ovl05_02172218
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152B28: .word ovl05_02172218
	arm_func_end DockHelpers__Func_2152B1C

	arm_func_start DockHelpers__Func_2152B2C
DockHelpers__Func_2152B2C: // 0x02152B2C
	ldr r0, _02152B34 // =ovl05_021721EC
	bx lr
	.align 2, 0
_02152B34: .word ovl05_021721EC
	arm_func_end DockHelpers__Func_2152B2C

	arm_func_start DockHelpers__Func_2152B38
DockHelpers__Func_2152B38: // 0x02152B38
	ldr r1, _02152B44 // =ovl05_021721FC
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152B44: .word ovl05_021721FC
	arm_func_end DockHelpers__Func_2152B38

	arm_func_start DockHelpers__Func_2152B48
DockHelpers__Func_2152B48: // 0x02152B48
	ldr r1, _02152B54 // =ovl05_0217222C
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152B54: .word ovl05_0217222C
	arm_func_end DockHelpers__Func_2152B48

	arm_func_start DockHelpers__Func_2152B58
DockHelpers__Func_2152B58: // 0x02152B58
	ldr r0, _02152B60 // =ovl05_021721E8
	bx lr
	.align 2, 0
_02152B60: .word ovl05_021721E8
	arm_func_end DockHelpers__Func_2152B58

	arm_func_start DockHelpers__GetAnnounceConfig
DockHelpers__GetAnnounceConfig: // 0x02152B64
	ldr r1, _02152B70 // =DockHelpers__announceConfig
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152B70: .word DockHelpers__announceConfig
	arm_func_end DockHelpers__GetAnnounceConfig

	arm_func_start DockHelpers__GetOptionsMessageInfo
DockHelpers__GetOptionsMessageInfo: // 0x02152B74
	ldr r0, _02152B7C // =DockHelpers__optionsMessageInfo
	bx lr
	.align 2, 0
_02152B7C: .word DockHelpers__optionsMessageInfo
	arm_func_end DockHelpers__GetOptionsMessageInfo
	
	.rodata

.public ovl05_0217182C
ovl05_0217182C: // 0x0217182C
    .hword 0xA, 0x10
	
.public ovl05_02171830
ovl05_02171830: // 0x02171830
    .hword 0xA, 0xF
	
.public ovl05_02171834
ovl05_02171834: // 0x02171834
    .hword 0, 0
	
.public ovl05_02171838
ovl05_02171838: // 0x02171838
    .word 1000                		// ringCost
	.byte 0, 0, 5, 5, 0, 0, 0, 0, 0 // materialCost
	.align 4

.public ovl05_02171848
ovl05_02171848: // 0x02171848
    .hword 0, 1, 4, 3, 5, 2, 0xA, 6, 7, 8, 9, 0xB, 0xC, 0xD
	
.public ovl05_02171864
ovl05_02171864: // 0x02171864
    .hword 0, 1, 2, 3, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
	
.public ovl05_02171882
ovl05_02171882: // 0x02171882
    .hword 7, 8, 9, 10, 11, 12, 13, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 0
	
.public DockHelpers__infoPurchaseCost
DockHelpers__infoPurchaseCost: // DockHelpers__infoPurchaseCost
	.word 600                   	// ringCost
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0	// materialCost
	.align 4
	
	.word 800                   	// ringCost
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0	// materialCost
	.align 4
	
	.word 1200                   	// ringCost
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0	// materialCost
	.align 4
	
.public ovl05_021718E0
ovl05_021718E0: // 0x021718E0
    .hword 0, 0
	.hword 0, 1
	.hword 0, 2
	.hword 0, 3
	.hword 0, 4
	.hword 2, 7
	.hword 0, 8
	.hword 0, 9
	.hword 0, 10
	.hword 1, 11
	.hword 1, 12
	.hword 1, 13
	.hword 1, 14

.public DockHelpers__dockUnknownConfig
DockHelpers__dockUnknownConfig: // DockHelpers__dockUnknownConfig
	.word 0, 0 // DOCKAREA_BASE
	.word 2, 2 // DOCKAREA_JET
	.word 3, 3 // DOCKAREA_SHIP
	.word 4, 4 // DOCKAREA_BOAT
	.word 5, 5 // DOCKAREA_SUBMARINE
	.word 6, 6 // DOCKAREA_BEACH
	.word 7, 8 // DOCKAREA_DRILL

.public DockHelpers__shipBuildCost
DockHelpers__shipBuildCost: // DockHelpers__shipBuildCost
	.word 0                   		// ringCost
	.byte 1, 1, 0, 0, 0, 0, 0, 0, 0	// materialCost
	.align 4

	.word 0                   		// ringCost
	.byte 0, 0, 5, 5, 0, 0, 0, 0, 0	// materialCost
	.align 4

	.word 0                   		// ringCost
	.byte 1, 1, 2, 2, 5, 5, 0, 0, 0	// materialCost
	.align 4

	.word 0                   		// ringCost
	.byte 1, 1, 1, 1, 2, 2, 5, 5, 0	// materialCost
	.align 4

	.word 0                   		// ringCost
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 1	// materialCost
	.align 4

.public DockHelpers__shipUpgradeCost
DockHelpers__shipUpgradeCost: // DockHelpers__shipUpgradeCost
	.word 0                   		// ringCost
	.byte 3, 3, 0, 0, 0, 0, 0, 0, 3	// materialCost
	.align 4

	.word 0                   		// ringCost
	.byte 5, 5, 0, 0, 0, 0, 0, 0, 5	// materialCost
	.align 4

	.word 0                   		// ringCost
	.byte 0, 0, 3, 3, 0, 0, 0, 0, 3	// materialCost
	.align 4

	.word 0                   		// ringCost
	.byte 0, 0, 5, 5, 0, 0, 0, 0, 5	// materialCost
	.align 4

	.word 0                   		// ringCost
	.byte 0, 0, 3, 3, 3, 3, 0, 0, 3	// materialCost
	.align 4

	.word 0                   		// ringCost
	.byte 0, 0, 5, 5, 5, 5, 0, 0, 5	// materialCost
	.align 4

	.word 0                   		// ringCost
	.byte 0, 0, 0, 0, 3, 3, 3, 3, 3	// materialCost
	.align 4

	.word 0                   		// ringCost
	.byte 0, 0, 0, 0, 5, 5, 5, 5, 5	// materialCost
	.align 4

.public DockHelpers__dockMapConfig
DockHelpers__dockMapConfig: // DockHelpers__dockMapConfig
	.word 2, 1, 0x3000, 0 // DOCKAREA_JET
	.hword 0x71C, 0
	.word 2, 0x10000, 0, 0, 0

	.word 3, 2, 0x800, 0 // DOCKAREA_SHIP
	.hword 0xE38, 1
	.word 2, 0x30002, 0, 0, 0

	.word 4, 3, 0x800, 0 // DOCKAREA_BOAT
	.hword 0xE38, 2, 
	.word 6, 0x10000, 0x30002, 0x50004, 0

	.word 5, 4, 0x800, 0 // DOCKAREA_SUBMARINE
	.hword 0xE38, 3
	.word 8, 0x10000, 0x30002, 0x50004, 0x70006

	.word 7, 6, 0x800, 0 // DOCKAREA_DRILL
	.hword 0xE38, 4
	.word 1, 8, 0, 0, 0

.public DockHelpers__DockBackInfo
DockHelpers__DockBackInfo: // DockHelpers__DockBackInfo
	.word 0
	.hword 0xFFFF, 0xFFFF, 0x00, 0xFFFF, 0xFFFF, 0xFFFF, 1, 0xFFFF
	.word 0xFFFFC000, 0

	.word 1,
	.hword 0xFFFF, 0xFFFF, 0x02, 0xFFFF, 0xFFFF, 0xFFFF, 3, 0xFFFF
	.word 0xFFFFC000, 0

	.word 2
	.hword 0x08, 0x09, 0x0A, 0xFFFF, 0x0B, 0xFFFF, 0xC, 0xFFFF
	.word 0xFFFFC000, 0xC000
	
	.word 3
	.hword 0x0D, 0x0E, 0x0F, 0xFFFF, 0x10, 0xFFFF, 0x11, 0xFFFF
	.word 0xFFFF6000, 0xC000
	
	.word 4
	.hword 0x12, 0x13, 0x14, 0xFFFF,  0x15, 0xFFFF, 0x16, 0xFFFF
	.word 0, 0xC000
	
	.word 5
	.hword 0x17, 0x18, 0x19, 0xFFFF,  0x1A, 0xFFFF, 0x1B, 0xFFFF
	.word 0, 0xC000
	
	.word 6
	.hword 0xFFFF, 0xFFFF, 0x04, 0x05, 0xFFFF, 0x06, 7, 0xFFFF
	.word 0xFFFFC000, 0
	
	.word 8
	.hword 0x1C, 0xFFFF, 0x1D, 0xFFFF, 0xFFFF, 0xFFFF, 0x1E, 0xFFFF
	.word 0xFFFF6000, 0

.public DockHelpers__npcConfig
DockHelpers__npcConfig: // DockHelpers__npcConfig
	.hword 1, 0, 9, 0
	.word DockHelpers__Func_2152A70			

	.hword 2, 0x4000, 0xFFF1, 0x12
	.word DockHelpers__Func_2152A7C

	.hword 0, 0, 0xFFF7, 0
	.word DockHelpers__Func_2152A88

	.hword 5, 0, 0xFFF7, 0
	.word DockHelpers__Func_2152AA0

	.hword 6, 0, 0xFFF7, 0
	.word DockHelpers__Func_2152AAC

	.hword 4, 0xC000, 0xB, 8
	.word DockHelpers__Func_2152A94

	.hword 6, 0x4000, 0xFFF5, 8
	.word DockHelpers__Func_2152AAC

	.hword 0xB, 0, 0xFFF9, 0xFFF5
	.word DockHelpers__Func_2152AF4

	.hword 0xC, 0, 7, 0xFFF5
	.word DockHelpers__Func_2152B00

	.hword 1, 0xE38E, 0x20, 0x21
	.word DockHelpers__Func_2152A70

	.hword 2, 0xC000, 0x10, 0x2D
	.word DockHelpers__Func_2152A7C

	.hword 5, 0x4000, 0x20, 0x2D
	.word DockHelpers__Func_2152AA0

	.hword 9, 0, 0xC, 0x2D
	.word DockHelpers__Func_2152AD0

	.hword 6, 0, 0xFFEB, 0x54
	.word DockHelpers__Func_2152AAC

	.hword 7, 0, 0x15, 0x54
	.word DockHelpers__Func_2152AB8

	.hword 3, 0, 0xFFEB, 0x54
	.word DockHelpers__Func_2152AE8

	.hword 6, 0, 0x15, 0x54
	.word DockHelpers__Func_2152AAC

	.hword 8, 0, 0xFFEB, 0x54
	.word DockHelpers__Func_2152AC4

	.hword 6, 0, 0x15, 0x54
	.word DockHelpers__Func_2152AAC

	.hword 8, 0, 0xFFEB, 0x54
	.word DockHelpers__Func_2152AC4

	.hword 5, 0, 0xFFFB, 0x1B
	.word DockHelpers__Func_2152AA0

	.hword 0xA, 0, 0xFFFB, 0x1B
	.word DockHelpers__Func_2152ADC
	
.public ovl05_02171CCC
ovl05_02171CCC: // 0x02171CCC
    .word 9, 1, 0, 0, 0, 3, 0x10000, 8, 0, 0
	.word 9, 1, 0, 0, 0, 3, 0x10000, 8, 0, 0
	.word 9, 2, 0, 0, 0, 3, 0x30002, 8, 0, 0
	.word 9, 2, 0, 0, 0, 3, 0x30002, 8, 0, 0
	.word 9, 3, 0, 0, 0, 5, 0x30002, 0x50004, 8, 0
	.word 9, 3, 0, 0, 0, 5, 0x30002, 0x50004, 8, 0
	.word 9, 4, 0, 0, 0, 5, 0x50004, 0x70006, 8, 0
	.word 9, 4, 0, 0, 0, 5, 0x50004, 0x70006, 8, 0

.public DockHelpers__dockStageConfig
DockHelpers__dockStageConfig: // DockHelpers__dockStageConfig
	.word 0x00, 0x00
	.word 0, 0, 0xFFFE9000
	.word 0x3C000, 0xF1C8, 0, 0x3000, 0xFFFFC000, 0, 0x3000, 0x4000, 8, 0x800, 0
	.hword 0x1000, 0

	.word 0x01, 0x00
	.word 0, 0, 0xFFFE9000
	.word 0x3C000, 0xF1C8, 0, 0x3000, 0xFFFFC000, 0, 0x3000, 0x4000, 8, 0x800, 0
	.hword 0x1000, 0

	.word 0x02, 0x01
	.word 0, 0, 0xFFFF1000
	.word 0x50000, 0xF1C8, 0xFFFEC000, 0, 0x20000, 0x14000, 0, 0x32000, 0x10, 0x1000, 1
	.hword 0x1000, 0

	.word 0x03, 0x02
	.word 0, 0, 0xFFFE2000
	.word 0x80000, 0xEAAB, 0xFFF97000, 0, 0, 0x69000, 0, 0x4C000, 0xC, 0x2000, 1
	.hword 0x1800, 0

	.word 0x04, 0x03
	.word 0, 0, 0xFFFE2000
	.word 0x80000, 0xEAAB, 0xFFFAB000, 0, 0, 0x2D000, 0, 0x4C000, 0xC, 0x2000, 1
	.hword 0x1800, 0

	.word 0x05, 0x04
	.word 0, 0, 0xFFFE2000
	.word 0x80000, 0xEAAB, 0xFFFD3000, 0, 0, 0x2D000, 0,  0x4C000, 0xC, 0x2000, 1
	.hword 0x1800, 0

	.word 0x06, 0x05
	.word 0, 0, 0xFFFF8000
	.word 0x64000, 0xE38F, 0xFFFF5000, 0, 0xFFF00000, 0xB000, 0, 0x21000, 0x10, 0x2000, 1
	.hword 0x1000, 0

.public ovl05_02171FE8
ovl05_02171FE8: // 0x02171FE8
    .hword 0x90               // field_0
	.hword 0x94               // field_2
	.word 0                   // field_4
	.word 0                   // field_8
	.word 3, 4, 5             // field_C
	.word 6, 4, 7             // field_18
	.word 2, 7, 9             // field_24
	.word 1, 9, 9             // field_30
	.hword 1                  // field_3C
	.hword 0                  // field_3E
	.hword 0x78               // field_0
	.hword 0xD4               // field_2
	.word 2                   // field_4
	.word 1                   // field_8
	.word 5, 3, 4             // field_C
	.word 0, 9, 9             // field_18
	.word 2, 0, 9             // field_24
	.word 9, 9, 9             // field_30
	.hword 2                  // field_3C
	.hword 0                  // field_3E
	.hword 0x104              // field_0
	.hword 0xBE               // field_2
	.word 3                   // field_4
	.word 2                   // field_8
	.word 0, 9, 9             // field_C
	.word 7, 9, 9             // field_18
	.word 9, 9, 9             // field_24
	.word 1, 9, 9             // field_30
	.hword 3                  // field_3C
	.hword 0                  // field_3E
	.hword 0x3C               // field_0
	.hword 0x9E               // field_2
	.word 4                   // field_4
	.word 3                   // field_8
	.word 9, 9, 9             // field_C
	.word 4, 9, 9             // field_18
	.word 0, 9, 9             // field_24
	.word 5, 1, 9             // field_30
	.hword 4                  // field_3C
	.hword 0                  // field_3E
	.hword 0x50               // field_0
	.hword 0x64               // field_2
	.word 5                   // field_4
	.word 4                   // field_8
	.word 3, 9, 9             // field_C
	.word 6, 9, 9             // field_18
	.word 6, 0, 9             // field_24
	.word 3, 0, 1             // field_30
	.hword 5                  // field_3C
	.hword 0                  // field_3E
	.hword 0x2C               // field_0
	.hword 0xCC               // field_2
	.word 6                   // field_4
	.word 5                   // field_8
	.word 9, 9, 9             // field_C
	.word 3, 9, 9             // field_18
	.word 1, 0, 9             // field_24
	.word 1, 9, 9             // field_30
	.hword 0xFFFF             // field_3C
	.hword 0                  // field_3E
	.hword 0x9A               // field_0
	.hword 0x50               // field_2
	.word 8                   // field_4
	.word 6                   // field_8
	.word 4, 9, 9             // field_C
	.word 9, 9, 9             // field_18
	.word 7, 9, 9             // field_24
	.word 0, 9, 9             // field_30
	.hword 6                  // field_3C
	.hword 0                  // field_3E
	.hword 0x114              // field_0
	.hword 0x68               // field_2
	.word 8                   // field_4
	.word 7                   // field_8
	.word 6, 0, 9             // field_C
	.word 6, 9, 9             // field_18
	.word 9, 9, 9             // field_24
	.word 2, 0, 9             // field_30
	.hword 0xFFFF             // field_3C
	.hword 0                  // field_3E

.public ovl05_021721E8
ovl05_021721E8: // 0x021721E8
    .hword 0xF, 0x06
	
.public ovl05_021721EC
ovl05_021721EC: // 0x021721EC
    .hword 0xB, 0x09
	.hword 0xC, 0x00
	.hword 0xC, 0x01
	.hword 0xC, 0x02

.public ovl05_021721FC
ovl05_021721FC: // 0x021721FC
    .hword 0xF, 0x00
	.hword 0xF, 0x02
	.hword 0xF, 0x04
	
.public DockHelpers__optionsMessageInfo
DockHelpers__optionsMessageInfo: // DockHelpers__optionsMessageInfo
	.hword 0x0D
	.hword 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x00

.public ovl05_02172218
ovl05_02172218: // 0x02172218
    .hword 0xFFFF, 0xFFFF
	.hword 0xB, 0x01
	.hword 0xB, 0x03
	.hword 0xB, 0x05
	.hword 0xB, 0x07
	
.public ovl05_0217222C
ovl05_0217222C: // 0x0217222C
    .hword 0x10, 0x00
	.hword 0x10, 0x02
	.hword 0x10, 0x04
	.hword 0x10, 0x06
	.hword 0x10, 0x08
	.hword 0x10, 0x0A
	.hword 0x10, 0x0C
	.hword 0x10, 0x0E

.public DockHelpers__announceConfig
DockHelpers__announceConfig: // DockHelpers__announceConfig
	.hword 0xC, 5
	.hword 0xC, 9
	.hword 0xC, 0xD
	.hword 0xC, 0x11
	.hword 0xC, 0x15
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0x13, 8
	.hword 0xFFFF, 0xFFFF
	.hword 0xC, 0x19
	.hword 0x13, 0xC
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0x13, 0x10
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF
	.hword 0xE, 9
	.hword 0xE, 0xA
	.hword 0x14, 9
	.hword 0x14, 9
	.hword 0x14, 0xE
	.hword 0x14, 0xE
	.hword 0x14, 0x13
	.hword 0x14, 0x13
	.hword 0x14, 0x18
	.hword 0x14, 0x18

.public DockHelpers__NpcMsgInfo
DockHelpers__NpcMsgInfo: // 0x021722E0
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0x0B, 0x00, 0xFFFF, 0xFFFF
	.hword 0x0B, 0x02, 0xFFFF, 0xFFFF
	.hword 0x0B, 0x04, 0xFFFF, 0xFFFF
	.hword 0x0B, 0x06, 0xFFFF, 0xFFFF
	.hword 0x0B, 0x08, 0xFFFF, 0xFFFF
	.hword 0x0C, 0x03, 0xFFFF, 0xFFFF
	.hword 0x0C, 0x04, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0x03, 0x0A, 0xFFFF, 0xFFFF
	.hword 0x07, 0x09, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0x07, 0x0F, 0xFFFF, 0xFFFF
	.hword 0x0F, 0x01, 0xFFFF, 0xFFFF
	.hword 0x01, 0x19, 0xFFFF, 0xFFFF
	.hword 0x0B, 0x0A, 0xFFFF, 0xFFFF
	.hword 0x0F, 0x03, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0x03, 0x10, 0xFFFF, 0xFFFF
	.hword 0x03, 0x13, 0xFFFF, 0xFFFF
	.hword 0x03, 0x16, 0xFFFF, 0xFFFF
	.hword 0x04, 0x12, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0x04, 0x0C, 0xFFFF, 0xFFFF
	.hword 0x0F, 0x05, 0xFFFF, 0xFFFF
	.hword 0x07, 0x0C, 0xFFFF, 0xFFFF
	.hword 0x04, 0x0F, 0xFFFF, 0xFFFF
	.hword 0x03, 0x0D, 0xFFFF, 0xFFFF
	.hword 0x03, 0x19, 0xFFFF, 0xFFFF
	.hword 0x10, 0x01, 0xFFFF, 0xFFFF
	.hword 0x10, 0x03, 0xFFFF, 0xFFFF
	.hword 0x10, 0x05, 0xFFFF, 0xFFFF
	.hword 0x10, 0x07, 0xFFFF, 0xFFFF
	.hword 0x10, 0x09, 0xFFFF, 0xFFFF
	.hword 0x10, 0x0B, 0xFFFF, 0xFFFF
	.hword 0x10, 0x0D, 0xFFFF, 0xFFFF
	.hword 0x10, 0x0F, 0xFFFF, 0xFFFF
	.hword 0x0F, 0x07, 0xFFFF, 0xFFFF
	.hword 0x00, 0x07, 0xFFFF, 0xFFFF