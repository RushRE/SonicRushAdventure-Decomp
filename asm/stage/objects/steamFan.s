	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start SteamFan__Create
SteamFan__Create: // 0x02165F28
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x36c
	ldr r0, _021660F4 // =StageTask_Main
	ldr r1, _021660F8 // =SteamFan__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x36c
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xa5
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _021660FC // =gameArchiveStage
	mov r1, #0
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02166100 // =aActAcGmkSteamF_0
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	ldr r1, [r4, #0x1a4]
	mov r0, #0xa6
	orr r1, r1, #0x200
	str r1, [r4, #0x1a4]
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #8
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #0
	mov r2, #0x22
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	ldr r0, [r4, #0x340]
	mov r3, #0x2c
	ldrh r0, [r0, #4]
	sub r1, r3, #0x58
	mov r2, r1
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	str r4, [r4, #0x234]
	add r0, r4, #0x218
	str r3, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _02166104 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02166108 // =SteamFan__OnDefend
	ldr r1, _0216610C // =SteamFan__Draw
	str r0, [r4, #0x23c]
	ldr r2, [r4, #0x230]
	ldr r0, _02166110 // =SteamFan__State_2166138
	orr r2, r2, #0x400
	str r2, [r4, #0x230]
	str r1, [r4, #0xfc]
	str r0, [r4, #0xf4]
	bl AllocSndHandle
	str r0, [r4, #0x138]
	mov r0, #0
	str r0, [sp]
	mov r0, #0x57
	sub r1, r0, #0x58
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021660F4: .word StageTask_Main
_021660F8: .word SteamFan__Destructor
_021660FC: .word gameArchiveStage
_02166100: .word aActAcGmkSteamF_0
_02166104: .word 0x0000FFFE
_02166108: .word SteamFan__OnDefend
_0216610C: .word SteamFan__Draw
_02166110: .word SteamFan__State_2166138
	arm_func_end SteamFan__Create

	arm_func_start SteamFan__Destructor
SteamFan__Destructor: // 0x02166114
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	ldr r0, [r0, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r4, pc}
	arm_func_end SteamFan__Destructor

	arm_func_start SteamFan__State_2166138
SteamFan__State_2166138: // 0x02166138
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x340]
	ldrh r0, [r0, #4]
	tst r0, #1
	beq _02166180
	add r0, r5, #0x300
	ldrh r1, [r0, #0x64]
	mov r3, #2
	sub r4, r3, #3
	sub r1, r1, #0x3d80
	sub r1, r1, #0xc000
	strh r1, [r0, #0x64]
	ldrh r2, [r0, #0x66]
	mov r1, #0xa00
	sub r2, r2, #0xfd00
	strh r2, [r0, #0x66]
	b _021661B0
_02166180:
	add r2, r5, #0x300
	ldrh r0, [r2, #0x64]
	mov r1, #0xa00
	rsb r1, r1, #0
	add r0, r0, #0x3d80
	add r0, r0, #0xc000
	strh r0, [r2, #0x64]
	ldrh r0, [r2, #0x66]
	mov r3, #0xfd
	mov r4, #1
	add r0, r0, #0xfd00
	strh r0, [r2, #0x66]
_021661B0:
	ldr r0, _02166284 // =playerGameStatus
	ldr r0, [r0, #0xc]
	tst r0, #1
	bne _02166204
	add r0, r5, #0x300
	ldrh ip, [r0, #0x64]
	ldrh r2, [r0, #0x68]
	mov r0, r5
	add r1, ip, r1
	add r1, r1, r2, lsl #14
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	mov r1, #0x20000
	bl EffectSteamFan__Create
	add r0, r5, #0x300
	ldrh r1, [r0, #0x68]
	add r1, r1, r4
	strh r1, [r0, #0x68]
	ldrh r1, [r0, #0x68]
	and r1, r1, #3
	strh r1, [r0, #0x68]
_02166204:
	ldr r0, [r5, #0x35c]
	cmp r0, #0
	beq _02166254
	ldr r0, [r0, #0x6d8]
	cmp r0, r5
	bne _02166240
	ldr r0, [r5, #0x340]
	ldrh r0, [r0, #4]
	tst r0, #1
	ldrh r0, [r5, #0x34]
	subne r0, r0, #0xfd00
	strneh r0, [r5, #0x34]
	addeq r0, r0, #0xfd00
	streqh r0, [r5, #0x34]
	b _02166274
_02166240:
	mov r0, #0
	str r0, [r5, #0x35c]
	mov r0, #0x14
	str r0, [r5, #0x2c]
	b _02166274
_02166254:
	ldr r0, [r5, #0x2c]
	cmp r0, #0
	beq _02166274
	subs r0, r0, #1
	str r0, [r5, #0x2c]
	ldreq r0, [r5, #0x18]
	biceq r0, r0, #2
	streq r0, [r5, #0x18]
_02166274:
	ldr r0, [r5, #0x138]
	add r1, r5, #0x44
	bl ProcessSpatialSfx
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02166284: .word playerGameStatus
	arm_func_end SteamFan__State_2166138

	arm_func_start SteamFan__OnDefend
SteamFan__OnDefend: // 0x02166288
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x6d8]
	cmp r0, r4
	ldmeqia sp!, {r3, r4, r5, pc}
	str r5, [r4, #0x35c]
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r3, [r5, #0x48]
	ldr r0, [r4, #0x48]
	ldr r2, [r5, #0x44]
	ldr r1, [r4, #0x44]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	strh r0, [r4, #0x34]
	ldr r1, [r4, #0x340]
	mov r0, r5
	ldrsb r2, [r1, #6]
	mov r1, r4
	mov r2, r2, lsl #0xb
	add r2, r2, #0x6000
	bl Player__Action_SteamFan
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SteamFan__OnDefend

	arm_func_start SteamFan__Draw
SteamFan__Draw: // 0x02166308
	stmdb sp!, {r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #0x14
	bl GetCurrentTaskWork_
	mov r7, r0
	mov r8, #0
	ldr sb, [r7, #0x128]
	add r0, r7, #0x300
	strh r8, [sp, #0xe]
	strh r8, [sp, #0xc]
	ldrh r0, [r0, #0x64]
	add r6, r7, #0x20
	mov r5, r8
	strh r0, [sp, #0x10]
	add r4, sp, #0xc
_02166340:
	str r6, [sp]
	str r5, [sp, #4]
	mov r0, sb
	mov r2, r4
	mov r3, r5
	str r5, [sp, #8]
	add r1, r7, #0x44
	bl StageTask__Draw2DEx
	ldrh r0, [sp, #0x10]
	add r8, r8, #1
	cmp r8, #4
	add r0, r0, #0x4000
	strh r0, [sp, #0x10]
	blt _02166340
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, sb, pc}
	arm_func_end SteamFan__Draw

	.data
	
aActAcGmkSteamF_0: // 0x0218916C
	.asciz "/act/ac_gmk_steam_fan.bac"
	.align 4