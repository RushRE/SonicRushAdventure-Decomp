	.include "asm/macros.inc"
	.include "global.inc"

    .text
    
	arm_func_start MissionHelpers__Func_2153A5C
MissionHelpers__Func_2153A5C: // 0x02153A5C
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, _02153AA8 // =Mission__PostGameMissionList1
	mov r5, #0
_02153A68:
	mov r0, r5, lsl #1
	ldrh r6, [r4, r0]
	mov r0, r6
	bl MissionHelpers__IsMissionBeaten
	cmp r0, #0
	bne _02153A94
	mov r0, r6
	bl MissionHelpers__IsMissionComplete
	cmp r0, #0
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
_02153A94:
	add r5, r5, #1
	cmp r5, #0x39
	blt _02153A68
	ldr r0, _02153AAC // =0x0000FFFF
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02153AA8: .word Mission__PostGameMissionList1
_02153AAC: .word 0x0000FFFF
	arm_func_end MissionHelpers__Func_2153A5C

	arm_func_start MissionHelpers__PostGameMissionCount1
MissionHelpers__PostGameMissionCount1: // 0x02153AB0
	mov r0, #0x39
	bx lr
	arm_func_end MissionHelpers__PostGameMissionCount1

	arm_func_start MissionHelpers__GetPostGameMission1
MissionHelpers__GetPostGameMission1: // 0x02153AB8
	ldr r1, _02153AC8 // =Mission__PostGameMissionList1
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02153AC8: .word Mission__PostGameMissionList1
	arm_func_end MissionHelpers__GetPostGameMission1

	arm_func_start MissionHelpers__GetPostGameMissionFlag1
MissionHelpers__GetPostGameMissionFlag1: // 0x02153ACC
	ldr r1, _02153ADC // =Mission__PostGameMissionFlagList1
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02153ADC: .word Mission__PostGameMissionFlagList1
	arm_func_end MissionHelpers__GetPostGameMissionFlag1

	arm_func_start MissionHelpers__PostGameMissionCount2
MissionHelpers__PostGameMissionCount2: // 0x02153AE0
	mov r0, #0xe
	bx lr
	arm_func_end MissionHelpers__PostGameMissionCount2

	arm_func_start MissionHelpers__GetPostGameMission2
MissionHelpers__GetPostGameMission2: // 0x02153AE8
	ldr r1, _02153AF8 // =DockHelpers__PostGameMissionList2
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02153AF8: .word DockHelpers__PostGameMissionList2
	arm_func_end MissionHelpers__GetPostGameMission2

	arm_func_start MissionHelpers__BlazeMissionCount
MissionHelpers__BlazeMissionCount: // 0x02153AFC
	mov r0, #7
	bx lr
	arm_func_end MissionHelpers__BlazeMissionCount

	arm_func_start MissionHelpers__IsBlazeMission
MissionHelpers__IsBlazeMission: // 0x02153B04
	ldr r1, _02153B14 // =DockHelpers__BlazeMissionIDs
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02153B14: .word DockHelpers__BlazeMissionIDs
	arm_func_end MissionHelpers__IsBlazeMission

	arm_func_start MissionHelpers__Func_2153B18
MissionHelpers__Func_2153B18: // 0x02153B18
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	movs r9, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x20]
	mov r4, #0
	beq _02153B88
_02153B38:
	mov r0, r4, lsl #1
	ldrh r0, [r8, r0]
	bl MissionHelpers__IsMissionBeaten
	cmp r0, #0
	bne _02153B74
	mov r0, r4, lsl #1
	ldrh r0, [r8, r0]
	bl MissionHelpers__IsMissionComplete
	cmp r0, #0
	beq _02153B74
	mov r0, r4, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrh r0, [r5, r0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02153B74:
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	cmp r9, r0, lsr #16
	mov r4, r0, lsr #0x10
	bhi _02153B38
_02153B88:
	cmp r9, #0
	mov r4, #0
	bls _02153BEC
_02153B94:
	mov r0, r4, lsl #1
	ldrh r0, [r8, r0]
	bl MissionHelpers__IsMissionUnlocked
	cmp r0, #0
	bne _02153BD8
	add r0, r4, r4, lsl #1
	add r0, r7, r0, lsl #1
	bl MissionHelpers__CheckSaveProgress
	cmp r0, #0
	beq _02153BD8
	mov r0, r4, lsl #1
	ldrh r0, [r6, r0]
	bl MissionHelpers__GetIslandProgress
	cmp r0, #0
	movne r0, r4, lsl #2
	ldrneh r0, [r5, r0]
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02153BD8:
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	cmp r9, r0, lsr #16
	mov r4, r0, lsr #0x10
	bhi _02153B94
_02153BEC:
	ldr r0, _02153BF4 // =0x0000FFFF
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02153BF4: .word 0x0000FFFF
	arm_func_end MissionHelpers__Func_2153B18

	arm_func_start MissionHelpers__Func_2153BF8
MissionHelpers__Func_2153BF8: // 0x02153BF8
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	ldr ip, _02153CE4 // =ovl05_021724C4
	add r3, sp, #4
	mov r2, #4
_02153C0C:
	ldrh r1, [ip]
	ldrh r0, [ip, #2]
	add ip, ip, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _02153C0C
	bl SaveGame__GetGameProgress
	cmp r0, #8
	bgt _02153C48
	bge _02153C80
	cmp r0, #1
	beq _02153C68
	b _02153CA4
_02153C48:
	cmp r0, #0x19
	bgt _02153CA4
	cmp r0, #0x15
	blt _02153CA4
	beq _02153C8C
	cmp r0, #0x19
	beq _02153C98
	b _02153CA4
_02153C68:
	bl SaveGame__Func_205BF24
	cmp r0, #0
	movne r0, #2
	add sp, sp, #0x14
	moveq r0, #8
	ldmia sp!, {pc}
_02153C80:
	add sp, sp, #0x14
	mov r0, #3
	ldmia sp!, {pc}
_02153C8C:
	add sp, sp, #0x14
	mov r0, #4
	ldmia sp!, {pc}
_02153C98:
	add sp, sp, #0x14
	mov r0, #5
	ldmia sp!, {pc}
_02153CA4:
	add r0, sp, #2
	add r1, sp, #0
	bl SaveGame__GetNextShipUpgrade
	cmp r0, #0
	addeq sp, sp, #0x14
	ldreq r0, _02153CE8 // =0x0000FFFF
	ldmeqia sp!, {pc}
	ldrh r0, [sp]
	ldrh r3, [sp, #2]
	add r2, sp, #4
	sub r0, r0, #1
	mov r1, r0, lsl #1
	add r0, r2, r3, lsl #2
	ldrh r0, [r1, r0]
	add sp, sp, #0x14
	ldmia sp!, {pc}
	.align 2, 0
_02153CE4: .word ovl05_021724C4
_02153CE8: .word 0x0000FFFF
	arm_func_end MissionHelpers__Func_2153BF8

	arm_func_start MissionHelpers__Func_2153CEC
MissionHelpers__Func_2153CEC: // 0x02153CEC
	stmdb sp!, {r3, lr}
	bl SaveGame__GetGameProgress
	cmp r0, #0x1d
	moveq r0, #6
	ldrne r0, _02153D04 // =0x0000FFFF
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153D04: .word 0x0000FFFF
	arm_func_end MissionHelpers__Func_2153CEC

	arm_func_start MissionHelpers__Func_2153D08
MissionHelpers__Func_2153D08: // 0x02153D08
	stmdb sp!, {r3, lr}
	bl SaveGame__GetProgressFlags_0x10
	cmp r0, #0
	ldrne r0, _02153D28 // =0x0000FFFF
	ldmneia sp!, {r3, pc}
	bl SaveGame__SetProgressFlags_0x10
	mov r0, #1
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153D28: .word 0x0000FFFF
	arm_func_end MissionHelpers__Func_2153D08

	arm_func_start MissionHelpers__Func_2153D2C
MissionHelpers__Func_2153D2C: // 0x02153D2C
	stmdb sp!, {r3, lr}
	bl SaveGame__GetGameProgress
	cmp r0, #0x1d
	moveq r0, #3
	ldrne r0, _02153D44 // =0x0000FFFF
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153D44: .word 0x0000FFFF
	arm_func_end MissionHelpers__Func_2153D2C

	arm_func_start MissionHelpers__CheckSaveProgress
MissionHelpers__CheckSaveProgress: // 0x02153D48
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl SaveGame__GetGameProgress
	mov r5, r0
	bl SaveGame__GetUnknownProgress1
	mov r4, r0
	bl SaveGame__GetUnknownProgress2
	ldrh r1, [r6, #0]
	cmp r5, r1
	ldrgeh r1, [r6, #2]
	cmpge r4, r1
	ldrgeh r1, [r6, #4]
	cmpge r0, r1
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end MissionHelpers__CheckSaveProgress

	arm_func_start MissionHelpers__GetIslandProgress
MissionHelpers__GetIslandProgress: // 0x02153D88
	stmdb sp!, {r3, lr}
	ldr r2, _02153DB8 // =0x0000FFFF
	mov r1, r0
	cmp r1, r2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	ldr r0, _02153DBC // =saveGame+0x00000028
	bl SaveGame__GetIslandProgress
	cmp r0, #2
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153DB8: .word 0x0000FFFF
_02153DBC: .word saveGame+0x00000028
	arm_func_end MissionHelpers__GetIslandProgress

	arm_func_start MissionHelpers__GetPostGameMission
MissionHelpers__GetPostGameMission: // 0x02153DC0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl MissionHelpers__IsMissionUnlocked
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #1
	bl SaveGame__SetMissionStatus
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #1
	bl SaveGame__SetMissionAttempted
	ldmia sp!, {r4, pc}
	arm_func_end MissionHelpers__GetPostGameMission

	arm_func_start MissionHelpers__IsMissionUnlocked
MissionHelpers__IsMissionUnlocked: // 0x02153DF8
	stmdb sp!, {r3, lr}
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetMissionStatus
	cmp r0, #1
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end MissionHelpers__IsMissionUnlocked

	arm_func_start MissionHelpers__GetUnlockedMissionCount
MissionHelpers__GetUnlockedMissionCount: // 0x02153E18
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, #0
	mov r4, r5
_02153E24:
	mov r0, r4
	bl MissionHelpers__IsMissionUnlocked
	cmp r0, #0
	add r4, r4, #1
	addne r5, r5, #1
	cmp r4, #0x64
	blt _02153E24
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end MissionHelpers__GetUnlockedMissionCount

	arm_func_start MissionHelpers__Func_2153E4C
MissionHelpers__Func_2153E4C: // 0x02153E4C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl MissionHelpers__IsMissionComplete
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #2
	bl SaveGame__SetMissionStatus
	mov r4, #0
_02153E74:
	mov r0, r4
	bl MissionHelpers__IsMissionComplete
	cmp r0, #0
	beq _02153E90
	add r4, r4, #1
	cmp r4, #0x63
	blt _02153E74
_02153E90:
	cmp r4, #0x63
	ldmltia sp!, {r4, pc}
	mov r0, #0x63
	bl MissionHelpers__GetPostGameMission
	ldmia sp!, {r4, pc}
	arm_func_end MissionHelpers__Func_2153E4C

	arm_func_start MissionHelpers__IsMissionComplete
MissionHelpers__IsMissionComplete: // 0x02153EA4
	stmdb sp!, {r3, lr}
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetMissionStatus
	cmp r0, #2
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end MissionHelpers__IsMissionComplete

	arm_func_start MissionHelpers__BeatMission
MissionHelpers__BeatMission: // 0x02153EC4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl MissionHelpers__IsMissionBeaten
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #3
	bl SaveGame__SetMissionStatus
	ldmia sp!, {r4, pc}
	arm_func_end MissionHelpers__BeatMission

	arm_func_start MissionHelpers__IsMissionBeaten
MissionHelpers__IsMissionBeaten: // 0x02153EEC
	stmdb sp!, {r3, lr}
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetMissionStatus
	cmp r0, #3
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end MissionHelpers__IsMissionBeaten

	arm_func_start MissionHelpers__ResetMissionAttempted
MissionHelpers__ResetMissionAttempted: // 0x02153F0C
	ldr ip, _02153F20 // =SaveGame__SetMissionAttempted
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bx ip
	.align 2, 0
_02153F20: .word SaveGame__SetMissionAttempted
	arm_func_end MissionHelpers__ResetMissionAttempted

	arm_func_start MissionHelpers__GetMissionAttempted
MissionHelpers__GetMissionAttempted: // 0x02153F24
	ldr ip, _02153F34 // =SaveGame__GetMissionAttempted
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx ip
	.align 2, 0
_02153F34: .word SaveGame__GetMissionAttempted
	arm_func_end MissionHelpers__GetMissionAttempted

	arm_func_start MissionHelpers__StartMission
MissionHelpers__StartMission: // 0x02153F38
	stmdb sp!, {r4, lr}
	ldr r1, _0215400C // =gameState
	mov r4, r0
	str r4, [r1, #0x144]
	mov r0, #5
	strb r0, [r1, #0xdc]
	cmp r4, #0x5f
	bge _02153FF0
	ldr r0, _02154010 // =DockHelpers__MissionForID
	mov r1, r4, lsl #1
	ldrh r0, [r0, r1]
	bl InitStageMission
	mov r0, r4
	bl MissionHelpers__CheckSonicMission
	cmp r0, #0
	beq _02153F90
	ldr r1, _0215400C // =gameState
	mov r2, #0
	mov r0, #8
	str r2, [r1, #4]
	bl RequestNewSysEventChange
	ldmia sp!, {r4, pc}
_02153F90:
	mov r0, r4
	bl MissionHelpers__CheckBlazeMission
	cmp r0, #0
	beq _02153FB8
	ldr r1, _0215400C // =gameState
	mov r2, #1
	mov r0, #8
	str r2, [r1, #4]
	bl RequestNewSysEventChange
	ldmia sp!, {r4, pc}
_02153FB8:
	bl SaveGame__BlazeUnlocked
	cmp r0, #0
	mov r2, #0
	beq _02153FDC
	ldr r1, _0215400C // =gameState
	mov r0, #7
	str r2, [r1, #4]
	bl RequestNewSysEventChange
	ldmia sp!, {r4, pc}
_02153FDC:
	ldr r1, _0215400C // =gameState
	mov r0, #8
	str r2, [r1, #4]
	bl RequestNewSysEventChange
	ldmia sp!, {r4, pc}
_02153FF0:
	ldr r0, _02154010 // =DockHelpers__MissionForID
	mov r1, r4, lsl #1
	ldrh r0, [r0, r1]
	bl MultibootManager__Func_2063C60
	mov r0, #0x1b
	bl RequestNewSysEventChange
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215400C: .word gameState
_02154010: .word DockHelpers__MissionForID
	arm_func_end MissionHelpers__StartMission

	arm_func_start MissionHelpers__GetMissionID
MissionHelpers__GetMissionID: // 0x02154014
	ldr r0, _02154020 // =gameState
	ldr r0, [r0, #0x144]
	bx lr
	.align 2, 0
_02154020: .word gameState
	arm_func_end MissionHelpers__GetMissionID

	arm_func_start MissionHelpers__GetMissionFromSelection_REAL
MissionHelpers__GetMissionFromSelection_REAL: // 0x02154024
	ldr r1, _02154034 // =MissionHelpers__missionIndexFromSelection
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02154034: .word MissionHelpers__missionIndexFromSelection
	arm_func_end MissionHelpers__GetMissionFromSelection_REAL

	arm_func_start MissionHelpers__HandlePostGameMissionBeaten
MissionHelpers__HandlePostGameMissionBeaten: // 0x02154038
	stmdb sp!, {r4, r5, r6, lr}
	bl MissionHelpers__PostGameMissionCount1
	mov r6, r0
	mov r5, #0
	cmp r6, #0
	ldmleia sp!, {r4, r5, r6, pc}
_02154050:
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MissionHelpers__GetPostGameMission1
	mov r4, r0
	bl MissionHelpers__IsMissionBeaten
	cmp r0, #0
	bne _02154084
	mov r0, r4
	bl MissionHelpers__IsMissionComplete
	cmp r0, #0
	beq _02154084
	mov r0, r4
	bl MissionHelpers__BeatMission
_02154084:
	add r5, r5, #1
	cmp r5, r6
	blt _02154050
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end MissionHelpers__HandlePostGameMissionBeaten

	arm_func_start MissionHelpers__GetMissionFromSelection
MissionHelpers__GetMissionFromSelection: // 0x02154094
	cmp r0, #0x31
	bgt _021540BC
	bge _02154140
	cmp r0, #9
	bgt _021540B0
	beq _02154130
	b _02154198
_021540B0:
	cmp r0, #0x27
	beq _02154138
	b _02154198
_021540BC:
	cmp r0, #0x3b
	bgt _021540CC
	beq _02154148
	b _02154198
_021540CC:
	sub r0, r0, #0x4f
	cmp r0, #0x14
	addls pc, pc, r0, lsl #2
	b _02154198
_021540DC: // jump table
	b _02154168 // case 0
	b _02154198 // case 1
	b _02154198 // case 2
	b _02154198 // case 3
	b _02154150 // case 4
	b _02154158 // case 5
	b _02154160 // case 6
	b _02154198 // case 7
	b _02154198 // case 8
	b _02154170 // case 9
	b _02154178 // case 10
	b _02154198 // case 11
	b _02154180 // case 12
	b _02154198 // case 13
	b _02154188 // case 14
	b _02154198 // case 15
	b _02154198 // case 16
	b _02154198 // case 17
	b _02154198 // case 18
	b _02154198 // case 19
	b _02154190 // case 20
_02154130:
	mov r0, #0x10
	bx lr
_02154138:
	mov r0, #2
	bx lr
_02154140:
	mov r0, #0x13
	bx lr
_02154148:
	mov r0, #0xd
	bx lr
_02154150:
	mov r0, #1
	bx lr
_02154158:
	mov r0, #0x14
	bx lr
_02154160:
	mov r0, #0x15
	bx lr
_02154168:
	mov r0, #0xa
	bx lr
_02154170:
	mov r0, #0x12
	bx lr
_02154178:
	mov r0, #0xb
	bx lr
_02154180:
	mov r0, #4
	bx lr
_02154188:
	mov r0, #0xc
	bx lr
_02154190:
	mov r0, #6
	bx lr
_02154198:
	mov r0, #0x17
	bx lr
	arm_func_end MissionHelpers__GetMissionFromSelection

	arm_func_start MissionHelpers__CheckPostGameMissionUnlock
MissionHelpers__CheckPostGameMissionUnlock: // 0x021541A0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r4, #0
	bl SaveGame__GetGameProgress
	cmp r0, #0x24
	blt _02154280
	mov r8, r4
	bl MissionHelpers__PostGameMissionCount1
	cmp r0, #0
	ble _02154234
	ldr r7, _02154288 // =saveGame+0x00000028
	ldr r5, _0215428C // =0x0000FFFF
	mov r6, #1
_021541D0:
	mov r0, r8, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MissionHelpers__GetPostGameMission1
	mov r1, r8, lsl #0x10
	mov r9, r0
	mov r0, r1, lsr #0x10
	bl MissionHelpers__GetPostGameMissionFlag1
	mov r1, r0
	cmp r1, r5
	beq _02154208
	mov r0, r7
	bl SaveGame__GetIslandProgress
	cmp r0, #2
	blt _02154224
_02154208:
	mov r0, r9
	bl MissionHelpers__IsMissionUnlocked
	cmp r0, #0
	bne _02154224
	mov r0, r9
	bl MissionHelpers__GetPostGameMission
	mov r4, r6
_02154224:
	add r8, r8, #1
	bl MissionHelpers__PostGameMissionCount1
	cmp r8, r0
	blt _021541D0
_02154234:
	mov r7, #0
	bl MissionHelpers__PostGameMissionCount2
	cmp r0, #0
	ble _02154280
	mov r5, #1
_02154248:
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MissionHelpers__GetPostGameMission2
	mov r6, r0
	bl MissionHelpers__IsMissionUnlocked
	cmp r0, #0
	bne _02154270
	mov r0, r6
	bl MissionHelpers__GetPostGameMission
	mov r4, r5
_02154270:
	add r7, r7, #1
	bl MissionHelpers__PostGameMissionCount2
	cmp r7, r0
	blt _02154248
_02154280:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02154288: .word saveGame+0x00000028
_0215428C: .word 0x0000FFFF
	arm_func_end MissionHelpers__CheckPostGameMissionUnlock

	arm_func_start MissionHelpers__CheckSonicMission
MissionHelpers__CheckSonicMission: // 0x02154290
	mov r0, #0
	bx lr
	arm_func_end MissionHelpers__CheckSonicMission

	arm_func_start MissionHelpers__CheckBlazeMission
MissionHelpers__CheckBlazeMission: // 0x02154298
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	mov r5, #0
	bl MissionHelpers__BlazeMissionCount
	cmp r0, #0
	ble _021542E0
	mov r0, r4, lsl #0x10
	mov r4, r0, lsr #0x10
_021542B8:
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MissionHelpers__IsBlazeMission
	cmp r4, r0
	moveq r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	add r5, r5, #1
	bl MissionHelpers__BlazeMissionCount
	cmp r5, r0
	blt _021542B8
_021542E0:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end MissionHelpers__CheckBlazeMission

	arm_func_start MissionHelpers__GetBlazeMissionCount
MissionHelpers__GetBlazeMissionCount: // 0x021542E8
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl MissionHelpers__IsMissionComplete
	cmp r0, #0
	ldrne r0, _0215434C // =0x0000FFFF
	ldmneia sp!, {r3, r4, r5, pc}
	mov r5, #0
	bl MissionHelpers__BlazeMissionCount
	cmp r0, #0
	ble _02154344
	mov r0, r4, lsl #0x10
	mov r4, r0, lsr #0x10
_02154318:
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MissionHelpers__IsBlazeMission
	cmp r4, r0
	moveq r0, r5, lsl #0x10
	moveq r0, r0, lsr #0x10
	ldmeqia sp!, {r3, r4, r5, pc}
	add r5, r5, #1
	bl MissionHelpers__BlazeMissionCount
	cmp r5, r0
	blt _02154318
_02154344:
	ldr r0, _0215434C // =0x0000FFFF
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215434C: .word 0x0000FFFF
	arm_func_end MissionHelpers__GetBlazeMissionCount

	arm_func_start MissionHelpers__GetUnknown2172B10
MissionHelpers__GetUnknown2172B10: // 0x02154350
	ldr r1, _0215435C // =Mission__unknown2172B10
	ldrb r0, [r1, r0]
	bx lr
	.align 2, 0
_0215435C: .word Mission__unknown2172B10
	arm_func_end MissionHelpers__GetUnknown2172B10
	
	.rodata

.public Mission__PostGameMissionFlagList1
Mission__PostGameMissionFlagList1: // Mission__PostGameMissionFlagList1
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 3, 4, 5, 9, 0xB, 0xC, 0xD

.public Mission__PostGameMissionList1
Mission__PostGameMissionList1: // Mission__PostGameMissionList1
	.hword 0, 1, 3, 4, 5, 8, 0xA, 0xB, 0xC, 0xE, 0xF, 0x12, 0x14
	.hword 0x15, 0x16, 0x18, 0x19, 0x1C, 0x1E, 0x1F, 0x20, 0x22
	.hword 0x23, 0x26, 0x28, 0x29, 0x2A, 0x2C, 0x2D, 0x2E, 0x32
	.hword 0x33, 0x34, 0x36, 0x37, 0x38, 0x3A, 0x3C, 0x3D, 0x3E
	.hword 0x40, 0x41, 0x42, 0x44, 0x46, 0x48, 0x49, 0x4A, 0x4B
	.hword 0x4C, 0x4E, 0x50, 0x52, 0x57, 0x5A, 0x5C, 0x5E
	
.public Mission__unknown2172B10
Mission__unknown2172B10: // Mission__unknown2172B10
	.byte 5, 4, 4, 7, 4, 9, 7, 4, 9, 7, 8, 9, 7, 8, 4, 5, 7
	.byte 4, 9, 5, 8, 10, 10, 2, 10, 10, 10, 2, 10, 10, 10, 10
	.byte 2, 10, 10, 2, 10, 10, 10, 10, 2, 10, 10, 2, 10, 10
	.byte 10, 10, 2, 10, 10, 2, 10, 10, 10, 10, 2, 10, 10, 10
	.byte 9, 2, 10, 10, 10, 2, 10, 10, 10, 2, 10, 10, 10, 10
	.byte 10, 10, 10, 10, 10, 2, 10, 10, 10, 2, 10, 7, 10, 7
	.byte 10, 10, 10, 10, 10, 10, 10, 3, 3, 3, 3, 2

.public MissionHelpers__missionIndexFromSelection
MissionHelpers__missionIndexFromSelection: // MissionHelpers__missionIndexFromSelection
	.hword 9, 83, 84, 19, 79, 6, 77, 89, 16, 29, 39, 26, 86, 88
	.hword 93, 59, 81, 85, 36, 49, 91, 0, 1, 2, 3, 4, 5, 7, 8
	.hword 10, 11, 12, 13, 14, 15, 17, 18, 20, 21, 22, 23, 24
	.hword 25, 27, 28, 30, 31, 32, 33, 34, 35, 37, 38, 40, 41
	.hword 42, 43, 44, 45, 46, 47, 48, 50, 51, 52, 53, 54, 55
	.hword 56, 57, 58, 60, 72, 73, 74, 75, 76, 61, 62, 63, 64
	.hword 65, 66, 67, 68, 69, 70, 71, 78, 80, 82, 87, 90, 92
	.hword 94, 95, 96, 97, 98, 99

.public DockHelpers__MissionForID
DockHelpers__MissionForID: // 0x02172C3C
	.hword 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
	.hword 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
	.hword 20, 21, 22, 23, 24, 25, 26, 27, 28, 29
	.hword 30, 31, 32, 33, 34, 35, 36, 37, 38, 39
	.hword 40, 41, 42, 43, 44, 45, 46, 47, 48, 49
	.hword 50, 51, 52, 53, 54, 55, 56, 57, 58, 59
	.hword 60, 61, 62, 63, 64, 65, 66, 67, 68, 69
	.hword 70, 71, 72, 73, 74, 75, 76, 77, 78, 79
	.hword 80, 81, 82, 83, 84, 85, 86, 87, 88, 89
	.hword 90, 91, 92, 93, 94, 5, 6, 7, 8, 65535
