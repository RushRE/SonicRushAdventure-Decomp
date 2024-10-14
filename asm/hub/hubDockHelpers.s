	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DockHelpers__Func_2152960
DockHelpers__Func_2152960: // 0x02152960
	ldr r1, _0215296C // =0x02171FE8
	add r0, r1, r0, lsl #6
	bx lr
	.align 2, 0
_0215296C: .word 0x02171FE8
	arm_func_end DockHelpers__Func_2152960

	arm_func_start DockHelpers__Func_2152970
DockHelpers__Func_2152970: // 0x02152970
	ldr r2, _02152980 // =0x02171E0C
	mov r1, #0x44
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_02152980: .word 0x02171E0C
	arm_func_end DockHelpers__Func_2152970

	arm_func_start DockHelpers__Func_2152984
DockHelpers__Func_2152984: // 0x02152984
	ldr r1, _02152990 // =0x02171914
	add r0, r1, r0, lsl #3
	bx lr
	.align 2, 0
_02152990: .word 0x02171914
	arm_func_end DockHelpers__Func_2152984

	arm_func_start DockHelpers__Func_2152994
DockHelpers__Func_2152994: // 0x02152994
	ldr r2, _021529A4 // =0x02171A1C
	mov r1, #0x28
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_021529A4: .word 0x02171A1C
	arm_func_end DockHelpers__Func_2152994

	arm_func_start DockHelpers__Func_21529A8
DockHelpers__Func_21529A8: // 0x021529A8
	ldr r2, _021529B8 // =0x02171CCC
	mov r1, #0x28
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_021529B8: .word 0x02171CCC
	arm_func_end DockHelpers__Func_21529A8

	arm_func_start DockHelpers__GetShipBuildCost
DockHelpers__GetShipBuildCost: // 0x021529BC
	ldr r1, _021529C8 // =0x0217194C
	add r0, r1, r0, lsl #4
	bx lr
	.align 2, 0
_021529C8: .word 0x0217194C
	arm_func_end DockHelpers__GetShipBuildCost

	arm_func_start DockHelpers__GetUnknownPurchaseCost
DockHelpers__GetUnknownPurchaseCost: // 0x021529CC
	ldr r0, _021529D4 // =0x02171838
	bx lr
	.align 2, 0
_021529D4: .word 0x02171838
	arm_func_end DockHelpers__GetUnknownPurchaseCost

	arm_func_start DockHelpers__GetInfoPurchaseCost
DockHelpers__GetInfoPurchaseCost: // 0x021529D8
	ldr r1, _021529E4 // =0x021718B0
	add r0, r1, r0, lsl #4
	bx lr
	.align 2, 0
_021529E4: .word 0x021718B0
	arm_func_end DockHelpers__GetInfoPurchaseCost

	arm_func_start DockHelpers__GetShipUpgradeCost
DockHelpers__GetShipUpgradeCost: // 0x021529E8
	ldr r1, _021529F4 // =0x0217199C
	add r0, r1, r0, lsl #4
	bx lr
	.align 2, 0
_021529F4: .word 0x0217199C
	arm_func_end DockHelpers__GetShipUpgradeCost

	arm_func_start DockHelpers__GetDockBackInfo
DockHelpers__GetDockBackInfo: // 0x021529F8
	ldr r2, _02152A08 // =0x02171AE4
	mov r1, #0x1c
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_02152A08: .word 0x02171AE4
	arm_func_end DockHelpers__GetDockBackInfo

	arm_func_start DockHelpers__GetNpcConfig
DockHelpers__GetNpcConfig: // 0x02152A0C
	ldr r2, _02152A1C // =0x02171BC4
	mov r1, #0xc
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_02152A1C: .word 0x02171BC4
	arm_func_end DockHelpers__GetNpcConfig

	arm_func_start DockHelpers__Func_2152A20
DockHelpers__Func_2152A20: // 0x02152A20
	ldr r1, _02152A2C // =0x02171882
	add r0, r1, r0, lsl #1
	bx lr
	.align 2, 0
_02152A2C: .word 0x02171882
	arm_func_end DockHelpers__Func_2152A20

	arm_func_start DockHelpers__Func_2152A30
DockHelpers__Func_2152A30: // 0x02152A30
	ldr r1, _02152A3C // =0x02171848
	add r0, r1, r0, lsl #1
	bx lr
	.align 2, 0
_02152A3C: .word 0x02171848
	arm_func_end DockHelpers__Func_2152A30

	arm_func_start DockHelpers__Func_2152A40
DockHelpers__Func_2152A40: // 0x02152A40
	ldr r1, _02152A4C // =0x02171864
	add r0, r1, r0, lsl #1
	bx lr
	.align 2, 0
_02152A4C: .word 0x02171864
	arm_func_end DockHelpers__Func_2152A40

	arm_func_start DockHelpers__GetMapBackConfig
DockHelpers__GetMapBackConfig: // 0x02152A50
	ldr r1, _02152A5C // =0x021718E0
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152A5C: .word 0x021718E0
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
	ldr r0, _02152A78 // =0x02171834
	bx lr
	.align 2, 0
_02152A78: .word 0x02171834
	arm_func_end DockHelpers__Func_2152A70

	arm_func_start DockHelpers__Func_2152A7C
DockHelpers__Func_2152A7C: // 0x02152A7C
	ldr r0, _02152A84 // =0x02171834
	bx lr
	.align 2, 0
_02152A84: .word 0x02171834
	arm_func_end DockHelpers__Func_2152A7C

	arm_func_start DockHelpers__Func_2152A88
DockHelpers__Func_2152A88: // 0x02152A88
	ldr r0, _02152A90 // =0x02171834
	bx lr
	.align 2, 0
_02152A90: .word 0x02171834
	arm_func_end DockHelpers__Func_2152A88

	arm_func_start DockHelpers__Func_2152A94
DockHelpers__Func_2152A94: // 0x02152A94
	ldr r0, _02152A9C // =0x02171834
	bx lr
	.align 2, 0
_02152A9C: .word 0x02171834
	arm_func_end DockHelpers__Func_2152A94

	arm_func_start DockHelpers__Func_2152AA0
DockHelpers__Func_2152AA0: // 0x02152AA0
	ldr r0, _02152AA8 // =0x02171834
	bx lr
	.align 2, 0
_02152AA8: .word 0x02171834
	arm_func_end DockHelpers__Func_2152AA0

	arm_func_start DockHelpers__Func_2152AAC
DockHelpers__Func_2152AAC: // 0x02152AAC
	ldr r0, _02152AB4 // =0x02171834
	bx lr
	.align 2, 0
_02152AB4: .word 0x02171834
	arm_func_end DockHelpers__Func_2152AAC

	arm_func_start DockHelpers__Func_2152AB8
DockHelpers__Func_2152AB8: // 0x02152AB8
	ldr r0, _02152AC0 // =0x02171834
	bx lr
	.align 2, 0
_02152AC0: .word 0x02171834
	arm_func_end DockHelpers__Func_2152AB8

	arm_func_start DockHelpers__Func_2152AC4
DockHelpers__Func_2152AC4: // 0x02152AC4
	ldr r0, _02152ACC // =0x02171834
	bx lr
	.align 2, 0
_02152ACC: .word 0x02171834
	arm_func_end DockHelpers__Func_2152AC4

	arm_func_start DockHelpers__Func_2152AD0
DockHelpers__Func_2152AD0: // 0x02152AD0
	ldr r0, _02152AD8 // =0x02171834
	bx lr
	.align 2, 0
_02152AD8: .word 0x02171834
	arm_func_end DockHelpers__Func_2152AD0

	arm_func_start DockHelpers__Func_2152ADC
DockHelpers__Func_2152ADC: // 0x02152ADC
	ldr r0, _02152AE4 // =0x02171834
	bx lr
	.align 2, 0
_02152AE4: .word 0x02171834
	arm_func_end DockHelpers__Func_2152ADC

	arm_func_start DockHelpers__Func_2152AE8
DockHelpers__Func_2152AE8: // 0x02152AE8
	ldr r0, _02152AF0 // =0x02171834
	bx lr
	.align 2, 0
_02152AF0: .word 0x02171834
	arm_func_end DockHelpers__Func_2152AE8

	arm_func_start DockHelpers__Func_2152AF4
DockHelpers__Func_2152AF4: // 0x02152AF4
	ldr r0, _02152AFC // =0x0217182C
	bx lr
	.align 2, 0
_02152AFC: .word 0x0217182C
	arm_func_end DockHelpers__Func_2152AF4

	arm_func_start DockHelpers__Func_2152B00
DockHelpers__Func_2152B00: // 0x02152B00
	ldr r0, _02152B08 // =0x02171830
	bx lr
	.align 2, 0
_02152B08: .word 0x02171830
	arm_func_end DockHelpers__Func_2152B00

	arm_func_start DockHelpers__GetNpcMessageInfo
DockHelpers__GetNpcMessageInfo: // 0x02152B0C
	ldr r1, _02152B18 // =0x021722E0
	add r0, r1, r0, lsl #3
	bx lr
	.align 2, 0
_02152B18: .word 0x021722E0
	arm_func_end DockHelpers__GetNpcMessageInfo

	arm_func_start DockHelpers__Func_2152B1C
DockHelpers__Func_2152B1C: // 0x02152B1C
	ldr r1, _02152B28 // =0x02172218
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152B28: .word 0x02172218
	arm_func_end DockHelpers__Func_2152B1C

	arm_func_start DockHelpers__Func_2152B2C
DockHelpers__Func_2152B2C: // 0x02152B2C
	ldr r0, _02152B34 // =0x021721EC
	bx lr
	.align 2, 0
_02152B34: .word 0x021721EC
	arm_func_end DockHelpers__Func_2152B2C

	arm_func_start DockHelpers__Func_2152B38
DockHelpers__Func_2152B38: // 0x02152B38
	ldr r1, _02152B44 // =0x021721FC
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152B44: .word 0x021721FC
	arm_func_end DockHelpers__Func_2152B38

	arm_func_start DockHelpers__Func_2152B48
DockHelpers__Func_2152B48: // 0x02152B48
	ldr r1, _02152B54 // =0x0217222C
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152B54: .word 0x0217222C
	arm_func_end DockHelpers__Func_2152B48

	arm_func_start DockHelpers__Func_2152B58
DockHelpers__Func_2152B58: // 0x02152B58
	ldr r0, _02152B60 // =0x021721E8
	bx lr
	.align 2, 0
_02152B60: .word 0x021721E8
	arm_func_end DockHelpers__Func_2152B58

	arm_func_start DockHelpers__GetAnnounceConfig
DockHelpers__GetAnnounceConfig: // 0x02152B64
	ldr r1, _02152B70 // =0x0217224C
	add r0, r1, r0, lsl #2
	bx lr
	.align 2, 0
_02152B70: .word 0x0217224C
	arm_func_end DockHelpers__GetAnnounceConfig

	arm_func_start DockHelpers__GetOptionsMessageInfo
DockHelpers__GetOptionsMessageInfo: // 0x02152B74
	ldr r0, _02152B7C // =0x02172208
	bx lr
	.align 2, 0
_02152B7C: .word 0x02172208
	arm_func_end DockHelpers__GetOptionsMessageInfo