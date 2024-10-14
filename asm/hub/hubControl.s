	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public HubControl__sVars
HubControl__sVars: // 0x02173A44
	.space 0x04
	
HubControl__TaskSingleton: // 0x02173A48
	.space 0x04

	.text

	arm_func_start HubControl__ReturnToHub
HubControl__ReturnToHub: // 0x02156DD0
	stmdb sp!, {r4, lr}
	bl HubControl__Func_2157288
	mov r0, #0
	bl OAMSystem__GetList2
	mov r1, r0
	mov r0, #0x200
	mov r2, #0x400
	bl MIi_CpuClear16
	mov r0, #1
	bl OAMSystem__GetList2
	mov r1, r0
	mov r0, #0x200
	mov r2, #0x400
	bl MIi_CpuClear16
	bl TalkHelpers__Func_2152F88
	cmp r0, #7
	ldrne r0, _02156FFC // =gameState+0x00000100
	movne r1, #0
	strneh r1, [r0, #0x52]
	bl SaveGame__Func_205BC7C
	cmp r0, #0
	beq _02156E48
	bl HubControl__Func_21572B8
	ldr r1, _02157000 // =gameState
	mov r2, #3
	mov r0, #6
	str r2, [r1, #0x15c]
	bl RequestNewSysEventChange
	bl NextSysEvent
	ldmia sp!, {r4, pc}
_02156E48:
	bl MissionHelpers__CheckPostGameMissionUnlock
	cmp r0, #0
	beq _02156E74
	bl HubControl__Func_21572B8
	ldr r1, _02157000 // =gameState
	mov r2, #4
	mov r0, #6
	str r2, [r1, #0x15c]
	bl RequestNewSysEventChange
	bl NextSysEvent
	ldmia sp!, {r4, pc}
_02156E74:
	bl SaveGame__GetGameProgress
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	bl SaveGame__Func_205BB18
	cmp r4, #0
	bne _02156EA4
	cmp r0, #6
	bhi _02156E9C
	bl HubControl__Func_2157124
	ldmia sp!, {r4, pc}
_02156E9C:
	bl HubControl__Func_215713C
	ldmia sp!, {r4, pc}
_02156EA4:
	cmp r4, #1
	bne _02156ED4
	ldr r0, _02157000 // =gameState
	ldrb r0, [r0, #0xdc]
	cmp r0, #0
	beq _02156EC8
	mov r0, #1
	bl HubControl__Func_21570B8
	ldmia sp!, {r4, pc}
_02156EC8:
	mov r0, #0
	bl HubControl__Func_21570B8
	ldmia sp!, {r4, pc}
_02156ED4:
	cmp r4, #3
	bhs _02156F04
	ldr r0, _02157000 // =gameState
	ldrb r0, [r0, #0xdc]
	cmp r0, #0
	beq _02156EF8
	mov r0, #1
	bl HubControl__Func_215710C
	ldmia sp!, {r4, pc}
_02156EF8:
	mov r0, #0
	bl HubControl__Func_215710C
	ldmia sp!, {r4, pc}
_02156F04:
	bl TalkHelpers__Func_2152F88
	cmp r0, #4
	bne _02156F58
	ldr r0, _02157000 // =gameState
	ldr r0, [r0, #0xcc]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl NpcViking__Func_2171150
	movs r4, r0
	beq _02156F64
	ldr r0, _02157000 // =gameState
	ldr r0, [r0, #0xd4]
	cmp r0, #0
	bne _02156F64
	bl HubControl__Func_21572B8
	mov r0, r4
	bl ViHubAreaPreview__Func_215B8FC
	mov r0, #0x22
	bl RequestNewSysEventChange
	bl NextSysEvent
	ldmia sp!, {r4, pc}
_02156F58:
	ldr r0, _02157000 // =gameState
	mov r1, #0
	str r1, [r0, #0xcc]
_02156F64:
	bl TalkHelpers__Func_2152F88
	cmp r0, #5
	bne _02156FC4
	ldr r0, _02157000 // =gameState
	ldr r0, [r0, #0x7c]
	cmp r0, #0
	beq _02156FC4
	bl MissionHelpers__GetMissionID
	bl MissionHelpers__GetBlazeMissionCount
	mov r4, r0
	cmp r4, #7
	bhs _02156FC4
	bl HubControl__Func_21572B8
	ldr r2, _02157000 // =gameState
	mov r1, #0xff
	strb r1, [r2, #0x150]
	and r1, r4, #0xff
	ldr r0, _02157004 // =saveGame+0x00000028
	strb r1, [r2, #0x151]
	bl SaveGame__SetSolEmeraldCollected
	mov r0, #0x1f
	bl RequestNewSysEventChange
	bl NextSysEvent
	ldmia sp!, {r4, pc}
_02156FC4:
	ldr r0, _02157000 // =gameState
	ldrb r0, [r0, #0xdc]
	cmp r0, #0
	beq _02156FE4
	cmp r0, #8
	bhs _02156FE4
	bl HubControl__Func_215701C
	ldmia sp!, {r4, pc}
_02156FE4:
	ldr r1, _02157008 // =gameState+0xDC
	mov r0, #0
	mov r2, #0x6c
	bl MIi_CpuClear32
	bl HubControl__Func_215700C
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156FFC: .word gameState+0x00000100
_02157000: .word gameState
_02157004: .word saveGame+0x00000028
_02157008: .word gameState+0xDC
	arm_func_end HubControl__ReturnToHub

	arm_func_start HubControl__Func_215700C
HubControl__Func_215700C: // 0x0215700C
	ldr ip, _02157018 // =HubControl__Create
	mov r0, #0
	bx ip
	.align 2, 0
_02157018: .word HubControl__Create
	arm_func_end HubControl__Func_215700C

	arm_func_start HubControl__Func_215701C
HubControl__Func_215701C: // 0x0215701C
	stmdb sp!, {r4, lr}
	bl TalkHelpers__Func_2152F88
	cmp r0, #6
	beq _02157038
	bl TalkHelpers__Func_2152F88
	cmp r0, #7
	bne _02157074
_02157038:
	bl TalkHelpers__Func_2152F88
	cmp r0, #7
	mov r0, #0
	moveq r4, #1
	mov r1, r0
	mov r2, r0
	movne r4, #0
	bl HubControl__Create2
	ldr r0, _021570B4 // =HubControl__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r1, #1
	str r1, [r0, #0x130]
	str r4, [r0, #0x134]
	ldmia sp!, {r4, pc}
_02157074:
	bl TalkHelpers__Func_2152DE4
	cmp r0, #0
	bne _0215708C
	bl TalkHelpers__Func_2152E04
	bl HubControl__Create
	ldmia sp!, {r4, pc}
_0215708C:
	bl TalkHelpers__Func_2152DE4
	cmp r0, #1
	bne _021570AC
	bl TalkHelpers__Func_2152E04
	mov r1, #1
	mov r2, #0
	bl HubControl__Create2
	ldmia sp!, {r4, pc}
_021570AC:
	bl HubControl__Func_215700C
	ldmia sp!, {r4, pc}
	.align 2, 0
_021570B4: .word HubControl__sVars
	arm_func_end HubControl__Func_215701C

	arm_func_start HubControl__Func_21570B8
HubControl__Func_21570B8: // 0x021570B8
	stmdb sp!, {r4, lr}
	movs r4, r0
	beq _021570F4
	bl TalkHelpers__Func_2152DE4
	cmp r0, #1
	bne _021570F4
	bl TalkHelpers__Func_2152E04
	ldr r1, _02157108 // =gameState
	cmp r0, #0
	cmpne r0, #1
	ldrb r1, [r1, #0xdc]
	movne r0, #0
	cmp r1, #2
	moveq r0, #1
	b _021570F8
_021570F4:
	mov r0, #0
_021570F8:
	mov r1, r4
	mov r2, #1
	bl HubControl__Create2
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157108: .word gameState
	arm_func_end HubControl__Func_21570B8

	arm_func_start HubControl__Func_215710C
HubControl__Func_215710C: // 0x0215710C
	ldr ip, _02157120 // =HubControl__Create2
	mov r1, r0
	mov r0, #2
	mov r2, #1
	bx ip
	.align 2, 0
_02157120: .word HubControl__Create2
	arm_func_end HubControl__Func_215710C

	arm_func_start HubControl__Func_2157124
HubControl__Func_2157124: // 0x02157124
	stmdb sp!, {r3, lr}
	mov r0, #5
	bl HubControl__Create
	mov r0, #7
	bl HubControl__Func_21576AC
	ldmia sp!, {r3, pc}
	arm_func_end HubControl__Func_2157124

	arm_func_start HubControl__Func_215713C
HubControl__Func_215713C: // 0x0215713C
	stmdb sp!, {r3, lr}
	mov r0, #7
	bl HubControl__Create
	mov r0, #0
	bl HubControl__Func_21576AC
	ldmia sp!, {r3, pc}
	arm_func_end HubControl__Func_215713C

	arm_func_start HubControl__Func_2157154
HubControl__Func_2157154: // 0x02157154
	stmdb sp!, {r3, lr}
	ldr r0, _02157174 // =HubControl__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r1, [r0, #0x2c]
	orr r1, r1, #1
	str r1, [r0, #0x2c]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02157174: .word HubControl__sVars
	arm_func_end HubControl__Func_2157154

	arm_func_start HubControl__Func_2157178
HubControl__Func_2157178: // 0x02157178
	stmdb sp!, {r3, lr}
	ldr r0, _0215719C // =HubControl__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r0, [r0, #0x2c]
	tst r0, #1
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215719C: .word HubControl__sVars
	arm_func_end HubControl__Func_2157178

	arm_func_start HubControl__GetFileFrom_ViAct
HubControl__GetFileFrom_ViAct: // 0x021571A0
	stmdb sp!, {r4, lr}
	ldr r1, _021571C4 // =HubControl__sVars
	mov r4, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	ldr r0, [r0, #0x34]
	mov r1, r4
	bl FileUnknown__GetAOUFile
	ldmia sp!, {r4, pc}
	.align 2, 0
_021571C4: .word HubControl__sVars
	arm_func_end HubControl__GetFileFrom_ViAct

	arm_func_start HubControl__GetFileFrom_ViActLoc
HubControl__GetFileFrom_ViActLoc: // 0x021571C8
	stmdb sp!, {r4, lr}
	ldr r1, _021571EC // =HubControl__sVars
	mov r4, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	ldr r0, [r0, #0x38]
	mov r1, r4
	bl FileUnknown__GetAOUFile
	ldmia sp!, {r4, pc}
	.align 2, 0
_021571EC: .word HubControl__sVars
	arm_func_end HubControl__GetFileFrom_ViActLoc

	arm_func_start HubControl__GetFileFrom_ViBG
HubControl__GetFileFrom_ViBG: // 0x021571F0
	stmdb sp!, {r4, lr}
	ldr r1, _02157214 // =HubControl__sVars
	mov r4, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	ldr r0, [r0, #0x3c]
	mov r1, r4
	bl FileUnknown__GetAOUFile
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157214: .word HubControl__sVars
	arm_func_end HubControl__GetFileFrom_ViBG

	arm_func_start HubControl__GetFileFrom_ViMsg
HubControl__GetFileFrom_ViMsg: // 0x02157218
	stmdb sp!, {r3, lr}
	ldr r0, _02157230 // =HubControl__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r0, [r0, #0x44]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02157230: .word HubControl__sVars
	arm_func_end HubControl__GetFileFrom_ViMsg

	arm_func_start HubControl__GetFileFrom_ViMsgCtrl
HubControl__GetFileFrom_ViMsgCtrl: // 0x02157234
	stmdb sp!, {r3, lr}
	ldr r0, _0215724C // =HubControl__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r0, [r0, #0x48]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215724C: .word HubControl__sVars
	arm_func_end HubControl__GetFileFrom_ViMsgCtrl

	arm_func_start HubControl__GetField54
HubControl__GetField54: // 0x02157250
	stmdb sp!, {r3, lr}
	ldr r0, _02157268 // =HubControl__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	add r0, r0, #0x54
	ldmia sp!, {r3, pc}
	.align 2, 0
_02157268: .word HubControl__sVars
	arm_func_end HubControl__GetField54

	arm_func_start HubControl__GetTKDMNameSprite
HubControl__GetTKDMNameSprite: // 0x0215726C
	stmdb sp!, {r3, lr}
	ldr r0, _02157284 // =HubControl__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r0, [r0, #0x50]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02157284: .word HubControl__sVars
	arm_func_end HubControl__GetTKDMNameSprite

	arm_func_start HubControl__Func_2157288
HubControl__Func_2157288: // 0x02157288
	ldr r2, _021572B0 // =0x04000204
	ldr r0, _021572B4 // =HubControl__sVars
	ldrh r1, [r2, #0]
	and r1, r1, #0x8000
	mov r1, r1, asr #0xf
	str r1, [r0]
	ldrh r0, [r2, #0]
	orr r0, r0, #0x8000
	strh r0, [r2]
	bx lr
	.align 2, 0
_021572B0: .word 0x04000204
_021572B4: .word HubControl__sVars
	arm_func_end HubControl__Func_2157288

	arm_func_start HubControl__Func_21572B8
HubControl__Func_21572B8: // 0x021572B8
	ldr r0, _021572F0 // =HubControl__sVars
	ldr r2, _021572F4 // =0x04000204
	ldr r1, [r0, #0]
	cmp r1, #1
	cmpne r1, #0
	movne r1, #0
	strne r1, [r0]
	ldr r0, _021572F0 // =HubControl__sVars
	ldrh r1, [r2, #0]
	ldr r3, [r0, #0]
	bic r0, r1, #0x8000
	orr r0, r0, r3, lsl #15
	strh r0, [r2]
	bx lr
	.align 2, 0
_021572F0: .word HubControl__sVars
_021572F4: .word 0x04000204
	arm_func_end HubControl__Func_21572B8

	arm_func_start HubControl__Create
HubControl__Create: // 0x021572F8
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	bl ViHubAreaPreview__Func_215A520
	ldr r4, _02157468 // =0x00001050
	mov r2, #0
	str r4, [sp]
	mov r4, #0x10
	ldr r0, _0215746C // =HubControl__Main1
	ldr r1, _02157470 // =HubControl__Destructor1
	mov r3, r2
	str r4, [sp, #4]
	bl HubControl__CreateInternal
	ldr r1, _02157474 // =HubControl__sVars
	str r0, [r1, #4]
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0x10000
	str r1, [r4]
	mov r1, #0
	str r1, [r4, #4]
	str r1, [r4, #8]
	str r1, [r4, #0x30]
	mov r1, #0x10
	mov r0, r5, lsl #0x10
	str r1, [r4, #0x104]
	mov r1, #8
	str r1, [r4, #0xc]
	mov r0, r0, lsr #0x10
	bl DockHelpers__Func_2152960
	ldr r0, [r0, #8]
	mov r1, #9
	str r0, [r4, #0x10]
	str r5, [r4, #0x14]
	str r5, [r4, #0x18]
	mov r0, #6
	str r0, [r4, #0x1c]
	mov r0, #0x17
	str r0, [r4, #0x20]
	mov r0, r4
	str r1, [r4, #0x24]
	bl ViHubAreaPreview__LoadArchives
	bl ViMap__Create
	ldr r0, [r4, #0x14]
	mov r1, #0
	bl ViMap__Func_215BCE4
	mov r0, #1
	bl ViMap__Func_215BB28
	mov r0, #1
	bl ViMap__Func_215C84C
	bl ViDock__Create
	cmp r5, #7
	bne _021573D8
	str r5, [r4, #0x18]
	bl ViDock__Func_215DEF4
	b _021573EC
_021573D8:
	ldr r0, [r4, #0x10]
	mov r1, #0
	bl ViDock__Func_215DD64
	mov r0, #0
	bl ViDock__Func_215DF64
_021573EC:
	mov r0, r4
	bl ViHubAreaPreview__ClearAnimators
	bl HubHUD__Create
	mov r0, #0
	mov r1, #1
	bl HubHUD__Func_2160110
	mov r0, #0
	mov r1, #1
	bl HubHUD__Func_21603B0
	bl ViMapPaletteAnimation__Create
	mov r0, r4
	bl ViHubAreaPreview__Create
	bl ResetTouchInput
	ldr r0, _02157478 // =renderCurrentDisplay
	mov r1, #1
	str r1, [r0]
	mov r0, #9
	str r0, [r4, #0x114]
	mov r0, #0
	str r0, [r4, #0x118]
	str r0, [r4, #0x11c]
	str r0, [r4, #0x124]
	str r0, [r4, #0x128]
	str r0, [r4, #0x12c]
	str r0, [r4, #0x130]
	str r0, [r4, #0x134]
	bl TalkHelpers__Func_2152DA0
	bl DockHelpers__LoadVillageTrack
	bl HubAudio__PlayVillageTrack
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02157468: .word 0x00001050
_0215746C: .word HubControl__Main1
_02157470: .word HubControl__Destructor1
_02157474: .word HubControl__sVars
_02157478: .word renderCurrentDisplay
	arm_func_end HubControl__Create

	arm_func_start HubControl__CreateInternal
HubControl__CreateInternal: // 0x0215747C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldrh lr, [sp, #0x18]
	ldrb ip, [sp, #0x1c]
	mov r4, #0x590
	str lr, [sp]
	str ip, [sp, #4]
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r1, r0
	mov r0, #0x590
	bl _ZnwmPv
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	arm_func_end HubControl__CreateInternal

	arm_func_start HubControl__Create2
HubControl__Create2: // 0x021574C0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl ViHubAreaPreview__Func_215A520
	ldr r3, _02157698 // =0x00001050
	mov r2, #0
	str r3, [sp]
	mov r3, #0x10
	str r3, [sp, #4]
	ldr r0, _0215769C // =HubControl__Main2
	ldr r1, _021576A0 // =HubControl__Destructor1
	mov r3, r2
	bl HubControl__CreateInternal
	ldr r1, _021576A4 // =HubControl__sVars
	str r0, [r1, #4]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x10000
	str r0, [r4]
	mov r0, #0
	str r0, [r4, #4]
	str r0, [r4, #8]
	str r0, [r4, #0x30]
	mov r0, #0x10
	str r0, [r4, #0x104]
	mov r0, r7, lsl #0x10
	str r7, [r4, #0xc]
	mov r1, #9
	mov r0, r0, lsr #0x10
	str r1, [r4, #0x10]
	bl DockHelpers__Func_2152970
	ldr r1, [r0, #4]
	mov r0, #6
	str r1, [r4, #0x14]
	str r1, [r4, #0x18]
	str r0, [r4, #0x1c]
	mov r0, #0x17
	str r0, [r4, #0x20]
	mov r0, #9
	str r0, [r4, #0x24]
	mov r0, r4
	bl ViHubAreaPreview__LoadArchives
	bl ViMap__Create
	ldr r0, [r4, #0x14]
	mov r1, #0
	bl ViMap__Func_215BCE4
	mov r0, #1
	bl ViMap__Func_215BB28
	mov r0, #0
	bl ViMap__Func_215C84C
	bl ViDock__Create
	ldr r0, [r4, #0xc]
	bl ViDock__Func_215DBC8
	cmp r6, #0
	beq _021575D8
	mov r7, #1
	bl TalkHelpers__Func_2152F88
	cmp r0, #1
	beq _021575CC
	bl TalkHelpers__Func_2152F88
	cmp r0, #3
	beq _021575CC
	bl TalkHelpers__Func_2152F88
	cmp r0, #5
	bne _021575D0
_021575CC:
	mov r7, #0
_021575D0:
	mov r0, r7
	bl ViDock__Func_215E578
_021575D8:
	mov r0, #0
	bl ViDock__Func_215DF64
	mov r0, r5
	bl ViDock__Func_215E658
	mov r0, r4
	bl ViHubAreaPreview__ClearAnimators
	bl HubHUD__Create
	mov r0, #0
	mov r1, #1
	bl HubHUD__Func_2160110
	mov r0, #0
	mov r1, #1
	bl HubHUD__Func_21603B0
	bl ViMapPaletteAnimation__Create
	bl ResetTouchInput
	ldr r0, _021576A8 // =renderCurrentDisplay
	cmp r6, #0
	mov r1, #0
	str r1, [r0]
	mov r0, #9
	str r0, [r4, #0x114]
	str r1, [r4, #0x118]
	str r5, [r4, #0x11c]
	str r1, [r4, #0x124]
	str r1, [r4, #0x128]
	str r1, [r4, #0x12c]
	str r1, [r4, #0x130]
	str r1, [r4, #0x134]
	beq _02157684
	bl TalkHelpers__Func_2152F88
	cmp r0, #2
	moveq r0, #1
	streq r0, [r4, #0x124]
	beq _02157684
	bl TalkHelpers__Func_2152F88
	cmp r0, #4
	moveq r0, #1
	streq r0, [r4, #0x128]
	beq _02157684
	bl TalkHelpers__Func_2152F88
	cmp r0, #5
	moveq r0, #1
	streq r0, [r4, #0x12c]
_02157684:
	bl TalkHelpers__Func_2152DA0
	bl DockHelpers__LoadVillageTrack
	bl HubAudio__PlayVillageTrack
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02157698: .word 0x00001050
_0215769C: .word HubControl__Main2
_021576A0: .word HubControl__Destructor1
_021576A4: .word HubControl__sVars
_021576A8: .word renderCurrentDisplay
	arm_func_end HubControl__Create2

	arm_func_start HubControl__Func_21576AC
HubControl__Func_21576AC: // 0x021576AC
	stmdb sp!, {r4, lr}
	ldr r1, _021576C8 // =HubControl__sVars
	mov r4, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	str r4, [r0, #0x114]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021576C8: .word HubControl__sVars
	arm_func_end HubControl__Func_21576AC

	arm_func_start HubControl__Func_21576CC
HubControl__Func_21576CC: // 0x021576CC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ViHubAreaPreview__Func_2158C04
	mov r0, r4
	bl ViHubAreaPreview__Func_2159D08
	bl ViMap__Func_215C960
	bl HubHUD__Func_21600E4
	bl ViDock__Func_215DB9C
	bl ViMap__Func_215BAF0
	mov r0, r4
	bl ViHubAreaPreview__Func_215966C
	ldr r0, [r4, #0x104]
	bl ViHubAreaPreview__Func_2159854
	bl HubAudio__Release
	ldmia sp!, {r4, pc}
	arm_func_end HubControl__Func_21576CC

	arm_func_start HubControl__Main1
HubControl__Main1: // 0x02157708
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r0
	mov r2, #1
	mov r5, #9
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	bne _021577E8
	ldr r0, [r4, #0]
	bic r0, r0, #0x10000
	str r0, [r4]
	ldr r0, [r4, #0x114]
	cmp r0, #8
	bge _02157780
	mov r0, #1
	bl ViMap__Func_215BCA0
	ldr r1, [r4, #0x114]
	cmp r1, r0
	bne _0215776C
	mov r0, r5
	mov r5, r1
	str r0, [r4, #0x114]
	b _021577E8
_0215776C:
	ldr r0, _021578B8 // =HubControl__Main_21588D4
	mov r1, #0
	str r1, [r4, #0x120]
	bl SetCurrentTaskMainEvent
	b _021577E8
_02157780:
	bl SaveGame__CheckProgress15
	cmp r0, #0
	beq _021577A0
	ldr r0, _021578BC // =HubControl__Main_2158A04
	mov r1, #0
	str r1, [r4, #0x120]
	bl SetCurrentTaskMainEvent
	b _021577E8
_021577A0:
	bl SaveGame__CheckProgress30
	cmp r0, #0
	beq _021577C0
	ldr r0, _021578BC // =HubControl__Main_2158A04
	mov r1, #0
	str r1, [r4, #0x120]
	bl SetCurrentTaskMainEvent
	b _021577E8
_021577C0:
	mov r0, #0
	bl ViMap__Func_215BB28
	mov r0, #1
	mov r1, r0
	bl HubHUD__Func_2160110
	mov r0, #1
	mov r1, r0
	bl HubHUD__Func_21603B0
	ldr r0, _021578C0 // =HubControl__Main_21578CC
	bl SetCurrentTaskMainEvent
_021577E8:
	cmp r5, #8
	bge _021578AC
	mov r0, #1
	bl ViMap__Func_215BB28
	mov r0, #0
	mov r1, #1
	bl HubHUD__Func_2160110
	mov r0, #0
	mov r1, #1
	bl HubHUD__Func_21603B0
	mov r0, #5
	bl HubAudio__PlaySfx
	str r5, [r4, #0x14]
	ldr r1, [r4, #0]
	mov r0, r5, lsl #0x10
	orr r1, r1, #0x10000
	str r1, [r4]
	mov r0, r0, lsr #0x10
	bl DockHelpers__Func_2152960
	ldr r0, [r0, #4]
	cmp r0, #7
	bge _02157868
	ldr r0, [r4, #0x11c]
	bl ViDock__Func_215E658
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl DockHelpers__Func_2152960
	ldr r1, [r0, #4]
	ldr r0, _021578C4 // =HubControl__Main_2157C0C
	str r1, [r4, #0xc]
	bl SetCurrentTaskMainEvent
	b _021578AC
_02157868:
	cmp r5, #6
	bne _02157884
	mov r0, #0
	str r0, [r4, #0x104]
	mov r0, #8
	str r0, [r4, #0x108]
	b _0215789C
_02157884:
	cmp r5, #7
	bne _0215789C
	mov r0, #0xa
	str r0, [r4, #0x104]
	mov r0, #0
	str r0, [r4, #0x108]
_0215789C:
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021578C8 // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
_021578AC:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021578B8: .word HubControl__Main_21588D4
_021578BC: .word HubControl__Main_2158A04
_021578C0: .word HubControl__Main_21578CC
_021578C4: .word HubControl__Main_2157C0C
_021578C8: .word HubControl__Main_2158868
	arm_func_end HubControl__Main1

	arm_func_start HubControl__Main_21578CC
HubControl__Main_21578CC: // 0x021578CC
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #1
	mov r5, #0
	bl ViMap__Func_215BCA0
	cmp r0, #8
	mov r0, #1
	bge _0215799C
	mov r1, r0
	bl HubHUD__Func_2160110
	mov r0, #1
	mov r1, r0
	bl HubHUD__Func_21603B0
	bl HubHUD__Func_216016C
	cmp r0, #0
	beq _02157934
	mov r0, #1
	bl ViMap__Func_215BB28
	ldr r0, _02157A88 // =HubControl__Main_2157A94
	bl SetCurrentTaskMainEvent
	mov r0, r5
	mov r1, #1
	bl HubHUD__Func_21603B0
	mov r5, #1
	b _021579B0
_02157934:
	bl HubHUD__Func_21603F0
	cmp r0, #0
	beq _021579B0
	mov r0, r4
	mov r1, #1
	bl ViHubAreaPreview__Func_2159758
	mov r0, r5
	bl HubAudio__PlaySfx
	mov r0, #2
	str r0, [r4, #0x104]
	mov r1, r5
	mov r0, #1
	str r1, [r4, #0x108]
	bl ViMap__Func_215BB28
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _02157A8C // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	mov r0, r5
	mov r1, #1
	bl HubHUD__Func_2160110
	mov r0, r5
	mov r1, #1
	bl HubHUD__Func_21603B0
	mov r5, #1
	b _021579B0
_0215799C:
	mov r1, r5
	bl HubHUD__Func_2160110
	mov r0, #1
	mov r1, r5
	bl HubHUD__Func_21603B0
_021579B0:
	cmp r5, #0
	bne _02157A7C
	bl ViMap__Func_215BDCC
	mov r5, r0
	cmp r5, #8
	bge _02157A7C
	mov r0, #1
	bl ViMap__Func_215BB28
	mov r0, #0
	mov r1, #1
	bl HubHUD__Func_2160110
	mov r0, #0
	mov r1, #1
	bl HubHUD__Func_21603B0
	mov r0, #5
	bl HubAudio__PlaySfx
	str r5, [r4, #0x14]
	ldr r1, [r4, #0]
	mov r0, r5, lsl #0x10
	orr r1, r1, #0x10000
	str r1, [r4]
	mov r0, r0, lsr #0x10
	bl DockHelpers__Func_2152960
	ldr r0, [r0, #4]
	cmp r0, #7
	bge _02157A38
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl DockHelpers__Func_2152960
	ldr r1, [r0, #4]
	ldr r0, _02157A90 // =HubControl__Main_2157C0C
	str r1, [r4, #0xc]
	bl SetCurrentTaskMainEvent
	b _02157A7C
_02157A38:
	cmp r5, #6
	bne _02157A54
	mov r0, #0
	str r0, [r4, #0x104]
	mov r0, #8
	str r0, [r4, #0x108]
	b _02157A6C
_02157A54:
	cmp r5, #7
	bne _02157A6C
	mov r0, #0xa
	str r0, [r4, #0x104]
	mov r0, #0
	str r0, [r4, #0x108]
_02157A6C:
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _02157A8C // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
_02157A7C:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02157A88: .word HubControl__Main_2157A94
_02157A8C: .word HubControl__Main_2158868
_02157A90: .word HubControl__Main_2157C0C
	arm_func_end HubControl__Main_21578CC

	arm_func_start HubControl__Main_2157A94
HubControl__Main_2157A94: // 0x02157A94
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r6, #0
	bl HubHUD__Func_216016C
	cmp r0, #0
	bne _02157AC8
	mov r0, r6
	bl ViMap__Func_215BB28
	ldr r0, _02157C08 // =HubControl__Main_21578CC
	bl SetCurrentTaskMainEvent
	mov r6, #1
_02157AC8:
	cmp r6, #0
	bne _02157B04
	bl ViMap__Func_215BC80
	mov r5, r0
	cmp r5, #8
	bge _02157B04
	bl HubHUD__Func_2160194
	mov r0, #0
	bl ViMap__Func_215BB28
	mov r0, r5
	mov r1, #1
	bl ViMap__Func_215BCE4
	ldr r0, _02157C08 // =HubControl__Main_21578CC
	bl SetCurrentTaskMainEvent
	mov r6, #1
_02157B04:
	cmp r6, #0
	bne _02157BF8
	mov r2, #0
	add r0, sp, #8
	add r1, sp, #0xa
	strh r2, [sp, #4]
	strh r2, [sp, #6]
	bl ViMap__Func_215BC40
	bl HubHUD__Func_21602BC
	cmp r0, #0
	beq _02157B58
	add r0, sp, #4
	add r1, sp, #6
	bl HubHUD__Func_21602D8
	add r0, sp, #0
	add r1, sp, #2
	bl HubHUD__Func_2160344
	ldrsh r0, [sp]
	ldrsh r1, [sp, #2]
	bl ViMap__Func_215C878
	b _02157BA8
_02157B58:
	bl HubHUD__Func_21601BC
	cmp r0, #0
	ldrnesh r0, [sp, #4]
	addne r0, r0, #2
	strneh r0, [sp, #4]
	bl HubHUD__Func_21601FC
	cmp r0, #0
	ldrnesh r0, [sp, #6]
	addne r0, r0, #2
	strneh r0, [sp, #6]
	bl HubHUD__Func_216023C
	cmp r0, #0
	ldrnesh r0, [sp, #4]
	subne r0, r0, #2
	strneh r0, [sp, #4]
	bl HubHUD__Func_216027C
	cmp r0, #0
	ldrnesh r0, [sp, #6]
	subne r0, r0, #2
	strneh r0, [sp, #6]
_02157BA8:
	ldrh r1, [sp, #8]
	ldrsh r0, [sp, #4]
	subs r2, r1, r0
	movmi r2, #0
	bmi _02157BC4
	cmp r2, #0x40
	movgt r2, #0x40
_02157BC4:
	ldrh r1, [sp, #0xa]
	ldrsh r0, [sp, #6]
	strh r2, [sp, #8]
	sub r0, r1, r0
	cmp r0, #0x10
	movlt r0, #0x10
	blt _02157BE8
	cmp r0, #0x40
	movgt r0, #0x40
_02157BE8:
	strh r0, [sp, #0xa]
	ldrh r0, [sp, #8]
	ldrh r1, [sp, #0xa]
	bl ViMap__Func_215BBAC
_02157BF8:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02157C08: .word HubControl__Main_21578CC
	arm_func_end HubControl__Main_2157A94

	arm_func_start HubControl__Main_2157C0C
HubControl__Main_2157C0C: // 0x02157C0C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mvn r0, #0xf
	mov r1, r0
	mov r2, #1
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	bne _02157C70
	mov r0, r4
	bl ViHubAreaPreview__Func_2158C04
	ldr r0, [r4, #0xc]
	bl ViDock__Func_215DBC8
	mov r0, #0
	bl ViDock__Func_215DF64
	mov r0, #0
	bl ViMap__Func_215C84C
	ldr r0, _02157C7C // =renderCurrentDisplay
	mov r1, #0
	str r1, [r0]
	ldr r1, [r4, #0]
	ldr r0, _02157C80 // =HubControl__Main2
	orr r1, r1, #0x10000
	str r1, [r4]
	bl SetCurrentTaskMainEvent
_02157C70:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157C7C: .word renderCurrentDisplay
_02157C80: .word HubControl__Main2
	arm_func_end HubControl__Main_2157C0C

	arm_func_start HubControl__Main2
HubControl__Main2: // 0x02157C84
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r0
	mov r2, #1
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	bne _02157F10
	ldr r0, [r4, #0x118]
	cmp r0, #0
	beq _02157CE0
	mov r0, #0
	ldr r1, _02157F1C // =0x0000FFFF
	str r0, [r4, #0x120]
	add r0, r4, #0x100
	strh r1, [r0, #0x38]
	ldr r1, [r4, #0]
	ldr r0, _02157F20 // =HubControl__Main_2158AB4
	bic r1, r1, #0x10000
	str r1, [r4]
	bl SetCurrentTaskMainEvent
	b _02157F10
_02157CE0:
	ldr r0, [r4, #0x124]
	cmp r0, #0
	beq _02157D24
	mov r1, #0
	mov r0, #5
	str r1, [r4, #0x124]
	bl ViDock__Func_215E104
	bl ViDock__Func_215E178
	mov r0, #0
	mov r1, #1
	bl HubHUD__Func_21603B0
	mov r0, #7
	mov r1, #0
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	ldr r0, _02157F24 // =HubControl__Main_2158160
	bl SetCurrentTaskMainEvent
	b _02157F10
_02157D24:
	ldr r0, [r4, #0x128]
	cmp r0, #0
	beq _02157D74
	mov r0, #0
	str r0, [r4, #0x128]
	ldr r0, [r4, #0xc]
	cmp r0, #2
	bne _02157D4C
	mov r0, #0xc
	bl ViDock__Func_215E104
_02157D4C:
	bl ViDock__Func_215E178
	mov r0, #0
	mov r1, #1
	bl HubHUD__Func_21603B0
	mov r0, #8
	mov r1, #0
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	ldr r0, _02157F24 // =HubControl__Main_2158160
	bl SetCurrentTaskMainEvent
	b _02157F10
_02157D74:
	ldr r0, [r4, #0x12c]
	cmp r0, #0
	beq _02157DB8
	mov r1, #0
	mov r0, #1
	str r1, [r4, #0x12c]
	bl ViDock__Func_215E104
	bl ViDock__Func_215E178
	mov r0, #0
	mov r1, #1
	bl HubHUD__Func_21603B0
	mov r0, #4
	mov r1, #0
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	ldr r0, _02157F24 // =HubControl__Main_2158160
	bl SetCurrentTaskMainEvent
	b _02157F10
_02157DB8:
	ldr r0, [r4, #0x130]
	cmp r0, #0
	beq _02157E18
	mov r0, #0
	bl ViDock__Func_215E104
	bl ViDock__Func_215E178
	mov r0, #0
	mov r1, #1
	bl HubHUD__Func_21603B0
	ldr r0, [r4, #0x134]
	cmp r0, #0
	mov r0, #9
	beq _02157DF8
	mov r1, #1
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	b _02157E00
_02157DF8:
	mov r1, #0
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
_02157E00:
	ldr r0, _02157F24 // =HubControl__Main_2158160
	bl SetCurrentTaskMainEvent
	mov r0, #0
	str r0, [r4, #0x130]
	str r0, [r4, #0x134]
	b _02157F10
_02157E18:
	bl SaveGame__CheckProgress24
	cmp r0, #0
	beq _02157E44
	ldr r0, [r4, #0xc]
	cmp r0, #0
	bne _02157E44
	bl SaveGame__Func_205BC18
	mov r0, #0x2f
	mov r1, #8
	bl ViHubAreaPreview__Func_21597A4
	b _02157F10
_02157E44:
	mov r0, #0
	bl SaveGame__CheckProgressForShip
	cmp r0, #0
	beq _02157E78
	ldr r0, [r4, #0xc]
	cmp r0, #3
	bne _02157E78
	mov r0, #0
	bl SaveGame__Func_205BC38
	mov r0, #0xf
	mov r1, #0
	bl ViHubAreaPreview__Func_21597A4
	b _02157F10
_02157E78:
	mov r0, #1
	bl SaveGame__CheckProgressForShip
	cmp r0, #0
	beq _02157EAC
	ldr r0, [r4, #0xc]
	cmp r0, #4
	bne _02157EAC
	mov r0, #1
	bl SaveGame__Func_205BC38
	mov r0, #0x24
	mov r1, #8
	bl ViHubAreaPreview__Func_21597A4
	b _02157F10
_02157EAC:
	mov r0, #2
	bl SaveGame__CheckProgressForShip
	cmp r0, #0
	beq _02157EE0
	ldr r0, [r4, #0xc]
	cmp r0, #5
	bne _02157EE0
	mov r0, #2
	bl SaveGame__Func_205BC38
	mov r0, #0x30
	mov r1, #8
	bl ViHubAreaPreview__Func_21597A4
	b _02157F10
_02157EE0:
	bl SaveGame__GetGameProgress
	cmp r0, #0x25
	ldreq r0, [r4, #0xc]
	cmpeq r0, #0
	bne _02157EFC
	bl ViHubAreaPreview__Func_2159810
	b _02157F10
_02157EFC:
	ldr r1, [r4, #0]
	ldr r0, _02157F28 // =HubControl__Main_2157F2C
	bic r1, r1, #0x10000
	str r1, [r4]
	bl SetCurrentTaskMainEvent
_02157F10:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157F1C: .word 0x0000FFFF
_02157F20: .word HubControl__Main_2158AB4
_02157F24: .word HubControl__Main_2158160
_02157F28: .word HubControl__Main_2157F2C
	arm_func_end HubControl__Main2

	arm_func_start HubControl__Main_2157F2C
HubControl__Main_2157F2C: // 0x02157F2C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #1
	bl ViDock__Func_215DF64
	mov r0, #1
	mov r1, r0
	bl HubHUD__Func_21603B0
	ldr r0, _02157F60 // =HubControl__Main_2157F64
	bl SetCurrentTaskMainEvent
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157F60: .word HubControl__Main_2157F64
	arm_func_end HubControl__Main_2157F2C

	arm_func_start HubControl__Main_2157F64
HubControl__Main_2157F64: // 0x02157F64
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	mov r4, r0
	bl ViDock__Func_215DFA0
	cmp r0, #0
	beq _02157FB4
	mov r0, #0
	bl ViDock__Func_215DF64
	mov r0, #0
	mov r1, r0
	bl HubHUD__Func_21603B0
	ldr r1, [r4, #0]
	ldr r0, _021580B0 // =HubControl__Main_21587D8
	orr r1, r1, #0x10000
	str r1, [r4]
	bl SetCurrentTaskMainEvent
	mov r0, #6
	bl HubAudio__PlaySfx
	b _021580A0
_02157FB4:
	bl ViDock__Func_215DFE4
	ldr r1, [r4, #0xc]
	cmp r1, r0
	beq _02157FF8
	mov r0, #0
	bl ViDock__Func_215DF64
	mov r0, #0
	mov r1, r0
	bl HubHUD__Func_21603B0
	ldr r1, [r4, #0]
	ldr r0, _021580B4 // =HubControl__Main_21580C0
	orr r1, r1, #0x10000
	str r1, [r4]
	bl SetCurrentTaskMainEvent
	mov r0, #6
	bl HubAudio__PlaySfx
	b _021580A0
_02157FF8:
	bl ViDock__Func_215E000
	cmp r0, #0
	beq _02158050
	add r0, sp, #4
	add r1, sp, #0
	bl ViDock__Func_215E02C
	ldr r0, [sp, #4]
	cmp r0, #0
	cmpne r0, #0xa
	bne _02158028
	mov r0, #1
	bl HubAudio__PlaySfx
_02158028:
	bl ViDock__Func_215E178
	mov r0, #0
	mov r1, #1
	bl HubHUD__Func_21603B0
	ldr r0, [sp, #4]
	ldr r1, [sp]
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	ldr r0, _021580B8 // =HubControl__Main_2158160
	bl SetCurrentTaskMainEvent
	b _021580A0
_02158050:
	bl HubHUD__Func_21603F0
	cmp r0, #0
	beq _021580A0
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	mov r0, #0
	bl HubAudio__PlaySfx
	mov r0, #0
	bl ViDock__Func_215DF64
	mov r0, #2
	str r0, [r4, #0x104]
	mov r0, #0
	mov r1, #1
	str r0, [r4, #0x108]
	bl HubHUD__Func_21603B0
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021580BC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
_021580A0:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021580B0: .word HubControl__Main_21587D8
_021580B4: .word HubControl__Main_21580C0
_021580B8: .word HubControl__Main_2158160
_021580BC: .word HubControl__Main_2158868
	arm_func_end HubControl__Main_2157F64

	arm_func_start HubControl__Main_21580C0
HubControl__Main_21580C0: // 0x021580C0
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	mvn r0, #0xf
	mov r1, #0
	mov r2, #1
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	bl ViDock__Func_215DFE4
	ldr r1, [r5, #0xc]
	mov r4, r0
	bl ViDock__Func_215DC80
	ldr r0, _02158104 // =HubControl__Main_2158108
	str r4, [r5, #0xc]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02158104: .word HubControl__Main_2158108
	arm_func_end HubControl__Main_21580C0

	arm_func_start HubControl__Main_2158108
HubControl__Main_2158108: // 0x02158108
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl ViDock__Func_215DD00
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0xc]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl DockHelpers__Func_2152970
	ldr r0, [r0, #4]
	ldr r1, [r4, #0x14]
	cmp r0, r1
	beq _0215814C
	mov r1, #1
	str r0, [r4, #0x14]
	bl ViMap__Func_215BCE4
_0215814C:
	bl ViDock__Func_215DD2C
	ldr r0, _0215815C // =HubControl__Main2
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215815C: .word HubControl__Main2
	arm_func_end HubControl__Main_2158108

	arm_func_start HubControl__Main_2158160
HubControl__Main_2158160: // 0x02158160
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl _ZN15CViDockNpcGroup12Func_2168724Ev
	cmp r0, #0x20
	addls pc, pc, r0, lsl #2
	b _021587A8
_0215817C: // jump table
	b _02158200 // case 0
	b _02158210 // case 1
	b _02158250 // case 2
	b _02158294 // case 3
	b _021582A4 // case 4
	b _021582E4 // case 5
	b _021582F4 // case 6
	b _0215832C // case 7
	b _02158340 // case 8
	b _02158350 // case 9
	b _02158388 // case 10
	b _021583A0 // case 11
	b _02158424 // case 12
	b _02158434 // case 13
	b _02158468 // case 14
	b _0215849C // case 15
	b _021584D0 // case 16
	b _02158504 // case 17
	b _02158530 // case 18
	b _02158554 // case 19
	b _02158564 // case 20
	b _0215859C // case 21
	b _021585D4 // case 22
	b _02158614 // case 23
	b _02158648 // case 24
	b _02158648 // case 25
	b _0215867C // case 26
	b _02158708 // case 27
	b _0215873C // case 28
	b _0215874C // case 29
	b _02158780 // case 30
	b _021587A8 // case 31
	b _021587B4 // case 32
_02158200:
	bl ViDock__Func_215E410
	ldr r0, _021587C8 // =HubControl__Main_2157F2C
	bl SetCurrentTaskMainEvent
	b _021587B4
_02158210:
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	ldr r0, [r4, #0xc]
	mov r1, #0
	bl ViHubAreaPreview__Func_215A2E0
	mov r0, #0
	str r0, [r4, #0x104]
	mov r1, #1
	str r1, [r4, #0x108]
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_02158250:
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	ldr r0, [r4, #0xc]
	mov r1, #1
	bl ViHubAreaPreview__Func_215A2E0
	mov r0, #1
	str r0, [r4, #0x104]
	bl _ZN15CViDockNpcGroup12Func_2168734Ev
	str r0, [r4, #0x108]
	mov r0, #0
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_02158294:
	mov r0, #2
	mov r1, #0
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	b _021587B4
_021582A4:
	bl _ZN15CViDockNpcGroup12Func_2168734Ev
	str r0, [r4, #0x1c]
	cmp r0, #0
	bne _021582B8
	bl ViTalkPurchase__Func_216996C
_021582B8:
	bl ViDock__Func_215E0CC
	str r0, [r4, #0x28]
	ldr r1, [r4, #4]
	ldr r0, _021587D0 // =ViHubAreaPreview__Func_2158D28
	str r1, [r4, #8]
	bl SetCurrentTaskMainEvent
	mov r0, #0xc
	bl HubAudio__FadeTrack
	mov r0, #0
	bl ViDock__Func_215DF64
	b _021587B4
_021582E4:
	mov r0, #2
	mov r1, #1
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	b _021587B4
_021582F4:
	bl _ZN15CViDockNpcGroup12Func_2168734Ev
	str r0, [r4, #0x20]
	bl ViDock__Func_215E0CC
	str r0, [r4, #0x28]
	ldr r1, [r4, #4]
	ldr r0, _021587D0 // =ViHubAreaPreview__Func_2158D28
	str r1, [r4, #8]
	bl SetCurrentTaskMainEvent
	mov r0, #0
	bl ViDock__Func_215DF64
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	b _021587B4
_0215832C:
	bl _ZN15CViDockNpcGroup12Func_2168734Ev
	mov r1, r0
	mov r0, #5
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	b _021587B4
_02158340:
	mov r0, #3
	mov r1, #0
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	b _021587B4
_02158350:
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	mov r0, #9
	str r0, [r4, #0x104]
	bl _ZN15CViDockNpcGroup12Func_2168734Ev
	str r0, [r4, #0x108]
	mov r0, #0
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_02158388:
	bl _ZN15CViDockNpcGroup12Func_2168734Ev
	bl MissionHelpers__GetPostGameMission
	mov r0, #5
	mov r1, #0x1c
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	b _021587B4
_021583A0:
	bl _ZN15CViDockNpcGroup12Func_2168734Ev
	cmp r0, #0x64
	bhs _02158410
	bl _ZN15CViDockNpcGroup12Func_2168734Ev
	mov r5, r0
	bl MissionHelpers__GetMissionFromSelection
	cmp r0, #0x16
	mov r0, r5
	bhs _021583FC
	bl MissionHelpers__GetMissionFromSelection
	str r0, [r4, #0x20]
	bl ViDock__Func_215E0CC
	str r0, [r4, #0x28]
	ldr r1, [r4, #4]
	ldr r0, _021587D0 // =ViHubAreaPreview__Func_2158D28
	str r1, [r4, #8]
	bl SetCurrentTaskMainEvent
	mov r0, #0
	bl ViDock__Func_215DF64
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	b _021587B4
_021583FC:
	bl MissionHelpers__BeatMission
	bl ViDock__Func_215E410
	ldr r0, _021587C8 // =HubControl__Main_2157F2C
	bl SetCurrentTaskMainEvent
	b _021587B4
_02158410:
	bl MissionHelpers__HandlePostGameMissionBeaten
	bl ViDock__Func_215E410
	ldr r0, _021587C8 // =HubControl__Main_2157F2C
	bl SetCurrentTaskMainEvent
	b _021587B4
_02158424:
	mov r0, #7
	mov r1, #0
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	b _021587B4
_02158434:
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	mov r0, #4
	str r0, [r4, #0x104]
	mov r0, #0
	str r0, [r4, #0x108]
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_02158468:
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	mov r0, #3
	str r0, [r4, #0x104]
	mov r0, #0
	str r0, [r4, #0x108]
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_0215849C:
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	mov r0, #5
	str r0, [r4, #0x104]
	mov r0, #0
	str r0, [r4, #0x108]
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_021584D0:
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	mov r0, #6
	str r0, [r4, #0x104]
	mov r0, #0
	str r0, [r4, #0x108]
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_02158504:
	mov r0, #1
	str r0, [r4, #0x114]
	bl ViDock__Func_215E410
	ldr r1, [r4, #0]
	ldr r0, _021587D4 // =HubControl__Main_21587D8
	orr r1, r1, #0x10000
	str r1, [r4]
	bl SetCurrentTaskMainEvent
	mov r0, #6
	bl HubAudio__PlaySfx
	b _021587B4
_02158530:
	mov r0, #0
	str r0, [r4, #0x104]
	str r0, [r4, #0x108]
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_02158554:
	mov r0, #8
	mov r1, #0
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	b _021587B4
_02158564:
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	mov r0, #7
	str r0, [r4, #0x104]
	bl _ZN15CViDockNpcGroup12Func_2168734Ev
	str r0, [r4, #0x108]
	mov r0, #0
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_0215859C:
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	mov r0, #8
	str r0, [r4, #0x104]
	bl _ZN15CViDockNpcGroup12Func_2168734Ev
	str r0, [r4, #0x108]
	mov r0, #0
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_021585D4:
	mov r0, #0
	bl SaveGame__GetProgressFlags_0x100000
	cmp r0, #0
	bne _021585F4
	mov r0, #0
	bl SaveGame__HasDoorPuzzlePiece
	cmp r0, #0
	beq _02158604
_021585F4:
	mov r0, #0
	mov r1, #0x26
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	b _021587B4
_02158604:
	mov r0, #2
	mov r1, #3
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	b _021587B4
_02158614:
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	mov r0, #0xb
	str r0, [r4, #0x104]
	mov r0, #0
	str r0, [r4, #0x108]
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_02158648:
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	mov r0, #0xc
	str r0, [r4, #0x104]
	mov r0, #0
	str r0, [r4, #0x108]
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_0215867C:
	mov r6, #0x65
	mov r7, #0
	bl MissionHelpers__PostGameMissionCount2
	cmp r0, #0
	ble _021586C8
_02158690:
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MissionHelpers__GetPostGameMission2
	mov r5, r0
	bl MissionHelpers__GetMissionID
	cmp r5, r0
	bne _021586B8
	bl MissionHelpers__GetMissionID
	mov r6, r0
	b _021586C8
_021586B8:
	add r7, r7, #1
	bl MissionHelpers__PostGameMissionCount2
	cmp r7, r0
	blt _02158690
_021586C8:
	cmp r6, #0x65
	beq _021586F8
	mov r0, r6
	bl MissionHelpers__IsMissionBeaten
	cmp r0, #0
	bne _021586F8
	mov r0, r6
	bl MissionHelpers__BeatMission
	mov r0, #5
	mov r1, #0x1b
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	b _021587B4
_021586F8:
	bl ViDock__Func_215E410
	ldr r0, _021587C8 // =HubControl__Main_2157F2C
	bl SetCurrentTaskMainEvent
	b _021587B4
_02158708:
	mov r0, r4
	mov r1, #0
	bl ViHubAreaPreview__Func_2159758
	mov r0, #0xd
	str r0, [r4, #0x104]
	mov r0, #0
	str r0, [r4, #0x108]
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_0215873C:
	mov r0, #2
	mov r1, r0
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	b _021587B4
_0215874C:
	bl _ZN15CViDockNpcGroup12Func_2168734Ev
	str r0, [r4, #0x24]
	bl ViDock__Func_215E0CC
	str r0, [r4, #0x28]
	ldr r1, [r4, #4]
	ldr r0, _021587D0 // =ViHubAreaPreview__Func_2158D28
	str r1, [r4, #8]
	bl SetCurrentTaskMainEvent
	mov r0, #0xc
	bl HubAudio__FadeTrack
	mov r0, #0
	bl ViDock__Func_215DF64
	b _021587B4
_02158780:
	mov r0, #0xe
	str r0, [r4, #0x104]
	mov r0, #0
	str r0, [r4, #0x108]
	bl ViDock__Func_215DF64
	mov r0, r4
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021587CC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _021587B4
_021587A8:
	bl ViDock__Func_215E410
	ldr r0, _021587C8 // =HubControl__Main_2157F2C
	bl SetCurrentTaskMainEvent
_021587B4:
	add r0, r4, #0x54
	bl FontWindow__PrepareSwapBuffer
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021587C8: .word HubControl__Main_2157F2C
_021587CC: .word HubControl__Main_2158868
_021587D0: .word ViHubAreaPreview__Func_2158D28
_021587D4: .word HubControl__Main_21587D8
	arm_func_end HubControl__Main_2158160

	arm_func_start HubControl__Main_21587D8
HubControl__Main_21587D8: // 0x021587D8
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mvn r0, #0xf
	mov r1, r0
	mov r2, #1
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	bne _02158854
	ldr r0, [r4, #0x14]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl DockHelpers__Func_2152960
	ldr r0, [r0, #8]
	mov r1, #0
	str r0, [r4, #0x10]
	bl ViDock__Func_215DD64
	ldr r1, [r4, #0x14]
	mov r0, r4
	str r1, [r4, #0x18]
	bl ViHubAreaPreview__Create
	mov r0, #1
	bl ViMap__Func_215C84C
	ldr r1, [r4, #0]
	ldr r0, _02158860 // =HubControl__Main1
	orr r1, r1, #0x10000
	str r1, [r4]
	bl SetCurrentTaskMainEvent
	ldr r0, _02158864 // =renderCurrentDisplay
	mov r1, #1
	str r1, [r0]
_02158854:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158860: .word HubControl__Main1
_02158864: .word renderCurrentDisplay
	arm_func_end HubControl__Main_21587D8

	arm_func_start HubControl__Main_2158868
HubControl__Main_2158868: // 0x02158868
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mvn r0, #0xf
	mov r1, r0
	mov r2, #1
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	mov r0, r4
	bne _021588C8
	ldr r5, [r4, #0x104]
	ldr r4, [r4, #0x108]
	bl HubControl__Func_21576CC
	bl DestroyCurrentTask
	bl ClearPixelsQueue
	bl ClearPaletteQueue
	bl Mappings__ClearQueue
	ldr r0, _021588D0 // =renderCurrentDisplay
	mov r1, #1
	str r1, [r0]
	mov r0, r5
	mov r1, r4
	bl ViHubAreaPreview__Func_215A400
	ldmia sp!, {r3, r4, r5, pc}
_021588C8:
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021588D0: .word renderCurrentDisplay
	arm_func_end HubControl__Main_2158868

	arm_func_start HubControl__Main_21588D4
HubControl__Main_21588D4: // 0x021588D4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x120]
	add r0, r0, #1
	str r0, [r4, #0x120]
	cmp r0, #0x40
	blo _02158908
	ldr r0, [r4, #0x114]
	mov r1, #1
	bl ViMap__Func_215BCE4
	ldr r0, _02158914 // =HubControl__Main_2158918
	bl SetCurrentTaskMainEvent
_02158908:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158914: .word HubControl__Main_2158918
	arm_func_end HubControl__Main_21588D4

	arm_func_start HubControl__Main_2158918
HubControl__Main_2158918: // 0x02158918
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #1
	bl ViMap__Func_215BCA0
	ldr r1, [r4, #0x114]
	cmp r1, r0
	bne _02158948
	ldr r0, _02158954 // =HubControl__Main_2158958
	mov r1, #0
	str r1, [r4, #0x120]
	bl SetCurrentTaskMainEvent
_02158948:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158954: .word HubControl__Main_2158958
	arm_func_end HubControl__Main_2158918

	arm_func_start HubControl__Main_2158958
HubControl__Main_2158958: // 0x02158958
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x120]
	add r1, r1, #1
	str r1, [r4, #0x120]
	cmp r1, #0x40
	blo _021589F0
	ldr r1, [r4, #0x114]
	cmp r1, #0
	bne _02158994
	bl ViHubAreaPreview__Func_215A3EC
	mov r0, #1
	str r0, [r4, #0x11c]
	b _021589DC
_02158994:
	cmp r1, #1
	bne _021589AC
	mov r0, #1
	str r0, [r4, #0x11c]
	str r0, [r4, #0x118]
	b _021589DC
_021589AC:
	cmp r1, #7
	bne _021589DC
	mov r1, #0
	str r1, [r4, #0x104]
	str r1, [r4, #0x108]
	ldr r1, [r4, #0]
	orr r1, r1, #0x10000
	str r1, [r4]
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _021589FC // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
_021589DC:
	ldr r1, [r4, #0]
	ldr r0, _02158A00 // =HubControl__Main1
	orr r1, r1, #0x10000
	str r1, [r4]
	bl SetCurrentTaskMainEvent
_021589F0:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_021589FC: .word HubControl__Main_2158868
_02158A00: .word HubControl__Main1
	arm_func_end HubControl__Main_2158958

	arm_func_start HubControl__Main_2158A04
HubControl__Main_2158A04: // 0x02158A04
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x120]
	add r0, r0, #1
	str r0, [r4, #0x120]
	cmp r0, #0x40
	blo _02158AA4
	bl SaveGame__CheckProgress30
	cmp r0, #0
	beq _02158A70
	bl SaveGame__Func_205BC28
	mov r0, r4
	mov r1, #1
	bl ViHubAreaPreview__Func_2159758
	mov r0, #8
	str r0, [r4, #0x104]
	mov r0, #0x39
	str r0, [r4, #0x108]
	ldr r1, [r4, #0]
	mov r0, r4
	orr r1, r1, #0x10000
	str r1, [r4]
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _02158AB0 // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
	b _02158AA4
_02158A70:
	bl SaveGame__CheckProgress15
	cmp r0, #0
	beq _02158AA4
	mov r0, #0
	str r0, [r4, #0x104]
	str r0, [r4, #0x108]
	ldr r1, [r4, #0]
	mov r0, r4
	orr r1, r1, #0x10000
	str r1, [r4]
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _02158AB0 // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
_02158AA4:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158AB0: .word HubControl__Main_2158868
	arm_func_end HubControl__Main_2158A04

	arm_func_start HubControl__Main_2158AB4
HubControl__Main_2158AB4: // 0x02158AB4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x120]
	add r0, r0, #1
	str r0, [r4, #0x120]
	cmp r0, #0x40
	blo _02158B44
	add r1, r4, #0x100
	ldrh r2, [r1, #0x38]
	ldr r0, _02158B50 // =0x0000FFFE
	cmp r2, r0
	bne _02158AFC
	mov r0, #0
	str r0, [r4, #0x104]
	mov r0, #8
	str r0, [r4, #0x108]
	b _02158B28
_02158AFC:
	add r0, r0, #1
	cmp r2, r0
	bne _02158B18
	mov r0, #0
	str r0, [r4, #0x104]
	str r0, [r4, #0x108]
	b _02158B28
_02158B18:
	mov r0, #8
	str r0, [r4, #0x104]
	ldrh r0, [r1, #0x38]
	str r0, [r4, #0x108]
_02158B28:
	ldr r1, [r4, #0]
	mov r0, r4
	orr r1, r1, #0x10000
	str r1, [r4]
	bl ViHubAreaPreview__Func_21598B4
	ldr r0, _02158B54 // =HubControl__Main_2158868
	bl SetCurrentTaskMainEvent
_02158B44:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158B50: .word 0x0000FFFE
_02158B54: .word HubControl__Main_2158868
	arm_func_end HubControl__Main_2158AB4

	arm_func_start HubControl__Destructor1
HubControl__Destructor1: // 0x02158B58
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	bl HubControl__Func_21576CC
	mov r0, r4
	bl HubControl__Func_2158B84
	ldr r0, _02158B80 // =HubControl__sVars
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158B80: .word HubControl__sVars
	arm_func_end HubControl__Destructor1

	arm_func_start HubControl__Func_2158B84
HubControl__Func_2158B84: // 0x02158B84
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x10]
	bl _ZdlPv
	mov r0, #0
	str r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	arm_func_end HubControl__Func_2158B84
