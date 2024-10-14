	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start ViTalkPurchase__Create
ViTalkPurchase__Create: // 0x021697A0
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r4, _02169908 // =0x00001010
	mov r5, r0
	mov r2, #0
	ldr r0, _0216990C // =ViTalkPurchase__Main
	ldr r1, _02169910 // =ViTalkPurchase__Destructor
	mov r3, r2
	str r4, [sp]
	mov r4, #0x10
	str r4, [sp, #4]
	bl ViTalkPurchase__CreateInternal
	bl GetTaskWork_
	mov r4, r0
	mov r0, #6
	str r0, [r4]
	mov r0, #4
	str r0, [r4, #4]
	mov r0, #9
	str r0, [r4, #8]
	mov r6, #0
	str r6, [r4, #0xc]
	cmp r5, #0
	bne _02169834
	bl ViHubAreaPreview__Func_215B4E0
	str r0, [r4]
	cmp r0, #5
	bge _0216981C
	bl ViTalkPurchase__Func_216A07C
	str r0, [r4, #0x10]
	b _021698D0
_0216981C:
	bl SaveGame__GetGameProgress
	cmp r0, #0x10
	bne _021698D0
	bl ViTalkPurchase__Func_216A08C
	str r0, [r4, #0x10]
	b _021698D0
_02169834:
	cmp r5, #1
	bne _02169884
_0216983C:
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__Func_205D520
	cmp r0, #0
	beq _02169868
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetBoughtInfo
	cmp r0, #0
	streq r6, [r4, #4]
	beq _02169874
_02169868:
	add r6, r6, #1
	cmp r6, #3
	blt _0216983C
_02169874:
	ldr r0, [r4, #4]
	bl ViTalkPurchase__Func_216A09C
	str r0, [r4, #0x10]
	b _021698D0
_02169884:
	cmp r5, #2
	bne _021698B8
	add r0, sp, #0xa
	add r1, sp, #8
	bl SaveGame__GetNextShipUpgrade
	ldrh r1, [sp, #8]
	ldrh r0, [sp, #0xa]
	sub r1, r1, #1
	add r0, r1, r0, lsl #1
	str r0, [r4, #8]
	bl ViTalkPurchase__Func_216A0AC
	str r0, [r4, #0x10]
	b _021698D0
_021698B8:
	cmp r5, #3
	bne _021698D0
	mov r0, #1
	str r0, [r4, #0xc]
	bl SaveGame__CheckRingsForPurchase
	str r0, [r4, #0x10]
_021698D0:
	mov r0, r4
	bl ViTalkPurchase__Func_2169998
	add r0, r4, #0x130
	add r0, r0, #0x1000
	mov r1, #0x400
	bl InitThreadWorker
	add r0, r4, #0x130
	ldr r1, _02169914 // =ViTalkPurchase__Func_2169980
	mov r2, r4
	add r0, r0, #0x1000
	mov r3, #0x14
	bl CreateThreadWorker
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02169908: .word 0x00001010
_0216990C: .word ViTalkPurchase__Main
_02169910: .word ViTalkPurchase__Destructor
_02169914: .word ViTalkPurchase__Func_2169980
	arm_func_end ViTalkPurchase__Create

	arm_func_start ViTalkPurchase__CreateInternal
ViTalkPurchase__CreateInternal: // 0x02169918
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldrh r4, [sp, #0x18]
	ldrb lr, [sp, #0x1c]
	ldr ip, _02169968 // =0x000011FC
	stmia sp, {r4, lr}
	str ip, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r1, r0
	ldr r0, _02169968 // =0x000011FC
	bl _ZnwmPv
	cmp r0, #0
	beq _0216995C
	add r0, r0, #0x14
	bl ViEvtCmnTalk__Constructor
_0216995C:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02169968: .word 0x000011FC
	arm_func_end ViTalkPurchase__CreateInternal

	arm_func_start ViTalkPurchase__Func_216996C
ViTalkPurchase__Func_216996C: // 0x0216996C
	stmdb sp!, {r3, lr}
	mov r0, #0
	bl DockHelpers__GetShipBuildCost
	bl ViTalkPurchase__Func_216A144
	ldmia sp!, {r3, pc}
	arm_func_end ViTalkPurchase__Func_216996C

	arm_func_start ViTalkPurchase__Func_2169980
ViTalkPurchase__Func_2169980: // 0x02169980
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ViTalkPurchase__Func_21699A8
	mov r0, r4
	bl ViTalkPurchase__Func_2169B20
	ldmia sp!, {r4, pc}
	arm_func_end ViTalkPurchase__Func_2169980

	arm_func_start ViTalkPurchase__Func_2169998
ViTalkPurchase__Func_2169998: // 0x02169998
	stmdb sp!, {r3, lr}
	bl ViHubAreaPreview__Func_215A888
	bl ViHubAreaPreview__Func_215AAB4
	ldmia sp!, {r3, pc}
	arm_func_end ViTalkPurchase__Func_2169998

	arm_func_start ViTalkPurchase__Func_21699A8
ViTalkPurchase__Func_21699A8: // 0x021699A8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	mov r0, #7
	bl HubControl__GetFileFrom_ViAct
	mov r5, r0
	bl Sprite__GetSpriteSize1
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r5
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r3, _02169B18 // =0x05000200
	add r0, r4, #0xcc
	str r3, [sp, #0x10]
	add r0, r0, #0x400
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r3, r2
	bl AnimatorSprite__Init
	mov r1, #0x10
	add r0, r4, #0x400
	strh r1, [r0, #0xd4]
	mov r1, #0x20
	strh r1, [r0, #0xd6]
	mov r1, #8
	add r0, r4, #0x500
	strh r1, [r0, #0x1c]
	mov r0, #9
	bl HubControl__GetFileFrom_ViAct
	mov r5, r0
	bl Sprite__GetSpriteSize1
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r5
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r3, _02169B18 // =0x05000200
	add r0, r4, #0x530
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r3, r2
	bl AnimatorSprite__Init
	mov r1, #0x10
	add r0, r4, #0x500
	strh r1, [r0, #0x38]
	mov r1, #0x20
	strh r1, [r0, #0x3a]
	mov r1, #8
	strh r1, [r0, #0x80]
	mov r0, #3
	bl HubControl__GetFileFrom_ViAct
	mov r5, r0
	mov r1, #1
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	add r0, r4, #0x194
	ldr r1, _02169B18 // =0x05000200
	str r3, [sp, #0xc]
	str r1, [sp, #0x10]
	mov r1, r5
	str r3, [sp, #0x14]
	mov r2, #1
	add r0, r0, #0x400
	str r2, [sp, #0x18]
	bl AnimatorSprite__Init
	add r0, r4, #0x500
	mov r1, #8
	strh r1, [r0, #0x9c]
	mov r1, #0x18
	strh r1, [r0, #0x9e]
	mov r2, #9
	ldr r1, _02169B1C // =0x0000FFFF
	strh r2, [r0, #0xe4]
	strh r1, [r0, #0xf8]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02169B18: .word 0x05000200
_02169B1C: .word 0x0000FFFF
	arm_func_end ViTalkPurchase__Func_21699A8

	arm_func_start ViTalkPurchase__Func_2169B20
ViTalkPurchase__Func_2169B20: // 0x02169B20
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl NpcOptions__Func_216E330
	mov r1, #3
	add r0, r4, #0x1fc
	mov r2, #0x3c0
	str r1, [sp]
	mov r1, #0xc
	str r1, [sp, #4]
	mov ip, #0xf
	add r0, r0, #0x400
	add r3, r2, #0x3f
	mov r1, #2
	str ip, [sp, #8]
	bl NpcOptions__Func_216E390
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	arm_func_end ViTalkPurchase__Func_2169B20

	arm_func_start ViTalkPurchase__Func_2169B70
ViTalkPurchase__Func_2169B70: // 0x02169B70
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x130
	add r0, r0, #0x1000
	bl JoinThreadWorker
	add r0, r4, #0x130
	add r0, r0, #0x1000
	bl ReleaseThreadWorker
	mov r0, r4
	bl ViTalkPurchase__Func_2169C00
	mov r0, r4
	bl ViTalkPurchase__Func_2169BC4
	add r0, r4, #0x14
	bl ViEvtCmnTalk__Func_216D72C
	mov r0, r4
	bl ViTalkPurchase__Func_2169BB4
	ldmia sp!, {r4, pc}
	arm_func_end ViTalkPurchase__Func_2169B70

	arm_func_start ViTalkPurchase__Func_2169BB4
ViTalkPurchase__Func_2169BB4: // 0x02169BB4
	stmdb sp!, {r3, lr}
	bl ViHubAreaPreview__Func_215A96C
	bl ViHubAreaPreview__Func_215AB84
	ldmia sp!, {r3, pc}
	arm_func_end ViTalkPurchase__Func_2169BB4

	arm_func_start ViTalkPurchase__Func_2169BC4
ViTalkPurchase__Func_2169BC4: // 0x02169BC4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x194
	add r0, r0, #0x400
	bl AnimatorSprite__Release
	add r0, r4, #0x530
	bl AnimatorSprite__Release
	add r0, r4, #0xcc
	add r0, r0, #0x400
	bl AnimatorSprite__Release
	ldr r1, _02169BFC // =0x0000FFFF
	add r0, r4, #0x500
	strh r1, [r0, #0xf8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169BFC: .word 0x0000FFFF
	arm_func_end ViTalkPurchase__Func_2169BC4

	arm_func_start ViTalkPurchase__Func_2169C00
ViTalkPurchase__Func_2169C00: // 0x02169C00
	ldr ip, _02169C10 // =NpcOptions__Func_216E8A4
	add r0, r0, #0x1fc
	add r0, r0, #0x400
	bx ip
	.align 2, 0
_02169C10: .word NpcOptions__Func_216E8A4
	arm_func_end ViTalkPurchase__Func_2169C00

	arm_func_start ViTalkPurchase__Main
ViTalkPurchase__Main: // 0x02169C14
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x130
	add r0, r0, #0x1000
	bl IsThreadWorkerFinished
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #4]
	cmp r0, #3
	bge _02169C4C
	bl DockHelpers__Func_2152B38
	mov r5, r0
	b _02169C9C
_02169C4C:
	ldr r0, [r4, #0]
	cmp r0, #5
	bge _02169C64
	bl DockHelpers__Func_2152B1C
	mov r5, r0
	b _02169C9C
_02169C64:
	ldr r0, [r4, #8]
	cmp r0, #8
	bge _02169C7C
	bl DockHelpers__Func_2152B48
	mov r5, r0
	b _02169C9C
_02169C7C:
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _02169C94
	bl DockHelpers__Func_2152B58
	mov r5, r0
	b _02169C9C
_02169C94:
	bl DockHelpers__Func_2152B2C
	mov r5, r0
_02169C9C:
	bl HubControl__GetFileFrom_ViMsgCtrl
	ldrh r1, [r5, #0]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldrh r2, [r5, #2]
	ldr r3, _02169CE4 // =0x0000FFFF
	add r0, r4, #0x14
	bl ViEvtCmnTalk__Func_216D680
	ldr r1, _02169CE8 // =ViTalkPurchase__Func_2169FF0
	mov r2, r4
	add r0, r4, #0x14
	bl ViEvtCmnTalk__Func_216D8AC
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl NpcOptions__Func_216EC50
	ldr r0, _02169CEC // =ViTalkPurchase__Func_2169CF0
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02169CE4: .word 0x0000FFFF
_02169CE8: .word ViTalkPurchase__Func_2169FF0
_02169CEC: .word ViTalkPurchase__Func_2169CF0
	arm_func_end ViTalkPurchase__Main

	arm_func_start ViTalkPurchase__Func_2169CF0
ViTalkPurchase__Func_2169CF0: // 0x02169CF0
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl NpcOptions__Func_216E8F0
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl NpcOptions__Func_216ED10
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x10]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	mov r1, r0, lsl #0x10
	add r0, r4, #0x14
	mov r1, r1, lsr #0x10
	bl ViEvtCmnTalk__Func_216D7D0
	ldr r0, _02169D48 // =ViTalkPurchase__Func_2169D4C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169D48: .word ViTalkPurchase__Func_2169D4C
	arm_func_end ViTalkPurchase__Func_2169CF0

	arm_func_start ViTalkPurchase__Func_2169D4C
ViTalkPurchase__Func_2169D4C: // 0x02169D4C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x14
	bl ViEvtCmnTalk__Func_216D81C
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl NpcOptions__Func_216E8F0
	add r0, r4, #0x500
	ldrh r1, [r0, #0xf8]
	ldr r0, _02169E08 // =0x0000FFFF
	cmp r1, r0
	beq _02169DE0
	cmp r1, #9
	mov r1, #0
	bne _02169DA4
	mov r2, r1
	add r0, r4, #0x530
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x530
	bl AnimatorSprite__DrawFrame
	b _02169DC0
_02169DA4:
	add r0, r4, #0xcc
	mov r2, r1
	add r0, r0, #0x400
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0xcc
	add r0, r0, #0x400
	bl AnimatorSprite__DrawFrame
_02169DC0:
	add r0, r4, #0x194
	mov r1, #0
	mov r2, r1
	add r0, r0, #0x400
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x194
	add r0, r0, #0x400
	bl AnimatorSprite__DrawFrame
_02169DE0:
	add r0, r4, #0x14
	bl ViEvtCmnTalk__Func_216D888
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl NpcOptions__Func_216ED24
	ldr r0, _02169E0C // =ViTalkPurchase__Func_2169E10
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169E08: .word 0x0000FFFF
_02169E0C: .word ViTalkPurchase__Func_2169E10
	arm_func_end ViTalkPurchase__Func_2169D4C

	arm_func_start ViTalkPurchase__Func_2169E10
ViTalkPurchase__Func_2169E10: // 0x02169E10
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl NpcOptions__Func_216E8F0
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl NpcOptions__Func_216ED60
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _02169E48 // =ViTalkPurchase__Func_2169E4C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169E48: .word ViTalkPurchase__Func_2169E4C
	arm_func_end ViTalkPurchase__Func_2169E10

	arm_func_start ViTalkPurchase__Func_2169E4C
ViTalkPurchase__Func_2169E4C: // 0x02169E4C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x14
	bl ViEvtCmnTalk__Func_216D89C
	cmp r0, #2
	beq _02169E7C
	cmp r0, #0x14
	beq _02169F1C
	cmp r0, #0x16
	beq _02169F58
	b _02169F88
_02169E7C:
	ldr r0, [r4, #4]
	cmp r0, #3
	bge _02169EB0
	bl DockHelpers__GetInfoPurchaseCost
	bl ViTalkPurchase__Func_216A144
	mov r0, #6
	bl _ZN15CViDockNpcGroup12Func_2168744Em
	ldr r1, [r4, #4]
	ldr r0, _02169FA0 // =0x02173190
	mov r1, r1, lsl #1
	ldrh r0, [r0, r1]
	bl _ZN15CViDockNpcGroup12Func_2168754El
	b _02169F98
_02169EB0:
	ldr r0, [r4, #0]
	cmp r0, #5
	bge _02169ED8
	bl DockHelpers__GetShipBuildCost
	bl ViTalkPurchase__Func_216A144
	mov r0, #4
	bl _ZN15CViDockNpcGroup12Func_2168744Em
	ldr r0, [r4, #0]
	bl _ZN15CViDockNpcGroup12Func_2168754El
	b _02169F98
_02169ED8:
	ldr r0, [r4, #8]
	cmp r0, #8
	bge _02169F00
	bl DockHelpers__GetShipUpgradeCost
	bl ViTalkPurchase__Func_216A144
	mov r0, #0x1d
	bl _ZN15CViDockNpcGroup12Func_2168744Em
	ldr r0, [r4, #8]
	bl _ZN15CViDockNpcGroup12Func_2168754El
	b _02169F98
_02169F00:
	bl DockHelpers__GetUnknownPurchaseCost
	bl ViTalkPurchase__Func_216A144
	mov r0, #6
	bl _ZN15CViDockNpcGroup12Func_2168744Em
	mov r0, #7
	bl _ZN15CViDockNpcGroup12Func_2168754El
	b _02169F98
_02169F1C:
	ldr r0, [r4, #8]
	cmp r0, #8
	bge _02169F44
	bl DockHelpers__GetShipUpgradeCost
	bl ViTalkPurchase__Func_216A144
	mov r0, #0x1d
	bl _ZN15CViDockNpcGroup12Func_2168744Em
	ldr r0, [r4, #8]
	bl _ZN15CViDockNpcGroup12Func_2168754El
	b _02169F98
_02169F44:
	mov r0, #0
	bl _ZN15CViDockNpcGroup12Func_2168744Em
	mov r0, #0
	bl _ZN15CViDockNpcGroup12Func_2168754El
	b _02169F98
_02169F58:
	mov r0, #0
	bl SaveGame__GetProgressFlags_0x100000
	cmp r0, #0
	bne _02169F74
	mov r0, #0
	bl SaveGame__SetProgressFlags_0x100000
	bl SaveGame__UseRingsForPurchase
_02169F74:
	mov r0, #0
	bl _ZN15CViDockNpcGroup12Func_2168744Em
	mov r0, #0
	bl _ZN15CViDockNpcGroup12Func_2168754El
	b _02169F98
_02169F88:
	mov r0, #0
	bl _ZN15CViDockNpcGroup12Func_2168744Em
	mov r0, #0
	bl _ZN15CViDockNpcGroup12Func_2168754El
_02169F98:
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169FA0: .word 0x02173190
	arm_func_end ViTalkPurchase__Func_2169E4C

	arm_func_start ViTalkPurchase__Destructor
ViTalkPurchase__Destructor: // 0x02169FA4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	bl ViTalkPurchase__Func_2169B70
	mov r0, r4
	bl ViTalkPurchase__Func_2169FC0
	ldmia sp!, {r4, pc}
	arm_func_end ViTalkPurchase__Destructor

	arm_func_start ViTalkPurchase__Func_2169FC0
ViTalkPurchase__Func_2169FC0: // 0x02169FC0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x10]
	cmp r4, #0
	beq _02169FE4
	add r0, r4, #0x14
	bl ViEvtCmnTalk__VTableFunc_216D618
	mov r0, r4
	bl _ZdlPv
_02169FE4:
	mov r0, #0
	str r0, [r5, #0x10]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViTalkPurchase__Func_2169FC0

	arm_func_start ViTalkPurchase__Func_2169FF0
ViTalkPurchase__Func_2169FF0: // 0x02169FF0
	stmdb sp!, {r4, lr}
	mov r4, r1
	cmp r0, #0xa
	blo _0216A050
	cmp r0, #0x13
	bhi _0216A050
	sub r1, r0, #0xa
	add r0, r2, #0x500
	strh r1, [r0, #0xf8]
	ldrh r1, [r0, #0xf8]
	cmp r1, #9
	bne _0216A030
	add r0, r2, #0x530
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	b _0216A03C
_0216A030:
	add r0, r2, #0xcc
	add r0, r0, #0x400
	bl AnimatorSprite__SetAnimation
_0216A03C:
	mov r0, r4
	mov r1, #0
	mov r2, #0x30
	bl FontAnimator__InitStartPos
	ldmia sp!, {r4, pc}
_0216A050:
	cmp r0, #0x14
	ldmneia sp!, {r4, pc}
	ldr ip, _0216A078 // =0x0000FFFF
	add r3, r2, #0x500
	mov r1, #0
	mov r0, r4
	mov r2, r1
	strh ip, [r3, #0xf8]
	bl FontAnimator__InitStartPos
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A078: .word 0x0000FFFF
	arm_func_end ViTalkPurchase__Func_2169FF0

	arm_func_start ViTalkPurchase__Func_216A07C
ViTalkPurchase__Func_216A07C: // 0x0216A07C
	stmdb sp!, {r3, lr}
	bl DockHelpers__GetShipBuildCost
	bl ViTalkPurchase__Func_216A0F0
	ldmia sp!, {r3, pc}
	arm_func_end ViTalkPurchase__Func_216A07C

	arm_func_start ViTalkPurchase__Func_216A08C
ViTalkPurchase__Func_216A08C: // 0x0216A08C
	stmdb sp!, {r3, lr}
	bl DockHelpers__GetUnknownPurchaseCost
	bl ViTalkPurchase__Func_216A0F0
	ldmia sp!, {r3, pc}
	arm_func_end ViTalkPurchase__Func_216A08C

	arm_func_start ViTalkPurchase__Func_216A09C
ViTalkPurchase__Func_216A09C: // 0x0216A09C
	stmdb sp!, {r3, lr}
	bl DockHelpers__GetInfoPurchaseCost
	bl ViTalkPurchase__Func_216A0F0
	ldmia sp!, {r3, pc}
	arm_func_end ViTalkPurchase__Func_216A09C

	arm_func_start ViTalkPurchase__Func_216A0AC
ViTalkPurchase__Func_216A0AC: // 0x0216A0AC
	stmdb sp!, {r3, lr}
	bl DockHelpers__GetShipUpgradeCost
	bl ViTalkPurchase__Func_216A0F0
	ldmia sp!, {r3, pc}
	arm_func_end ViTalkPurchase__Func_216A0AC

	arm_func_start ViTalkPurchase__Func_216A0BC
ViTalkPurchase__Func_216A0BC: // 0x0216A0BC
	stmdb sp!, {r3, lr}
	mov r1, r0
	cmp r1, #9
	movhs r0, #0
	ldmhsia sp!, {r3, pc}
	ldr r0, _0216A0DC // =saveGame+0x00000028
	bl SaveGame__GetMaterialCount
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216A0DC: .word saveGame+0x00000028
	arm_func_end ViTalkPurchase__Func_216A0BC

	arm_func_start ViTalkPurchase__Func_216A0E0
ViTalkPurchase__Func_216A0E0: // 0x0216A0E0
	ldr r0, _0216A0EC // =saveGame
	ldr r0, [r0, #0x1bc]
	bx lr
	.align 2, 0
_0216A0EC: .word saveGame
	arm_func_end ViTalkPurchase__Func_216A0E0

	arm_func_start ViTalkPurchase__Func_216A0F0
ViTalkPurchase__Func_216A0F0: // 0x0216A0F0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl ViTalkPurchase__Func_216A0E0
	ldr r1, [r5, #0]
	cmp r1, r0
	movhi r0, #0
	ldmhiia sp!, {r3, r4, r5, pc}
	mov r4, #0
_0216A110:
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ViTalkPurchase__Func_216A0BC
	add r1, r5, r4
	ldrb r1, [r1, #4]
	cmp r1, r0
	movgt r0, #0
	ldmgtia sp!, {r3, r4, r5, pc}
	add r4, r4, #1
	cmp r4, #9
	blt _0216A110
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViTalkPurchase__Func_216A0F0

	arm_func_start ViTalkPurchase__Func_216A144
ViTalkPurchase__Func_216A144: // 0x0216A144
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r2, [r4, #0]
	cmp r2, #0
	beq _0216A168
	ldr r0, _0216A19C // =saveGame
	ldr r1, [r0, #0x1bc]
	sub r1, r1, r2
	str r1, [r0, #0x1bc]
_0216A168:
	ldr r5, _0216A1A0 // =saveGame+0x00000028
	mov r6, #0
_0216A170:
	add r0, r4, r6
	ldrb r2, [r0, #4]
	cmp r2, #0
	beq _0216A18C
	mov r0, r5
	mov r1, r6
	bl SaveGame__UseMaterial
_0216A18C:
	add r6, r6, #1
	cmp r6, #9
	blt _0216A170
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216A19C: .word saveGame
_0216A1A0: .word saveGame+0x00000028
	arm_func_end ViTalkPurchase__Func_216A144
