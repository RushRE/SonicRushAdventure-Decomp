#include <stage/objects/waterGun.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/audio/spatialAudio.h>

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED void *WaterGun__dword_218A3CC;
NOT_DECOMPILED void *WaterGrindRail__Singleton;

NOT_DECOMPILED void *WaterGrindRail__byte_2189D28;

NOT_DECOMPILED void *aActAcGmkWaterG;
NOT_DECOMPILED void *aDfGmkWaterGrai;
NOT_DECOMPILED void *aDfGmkWaterGrai_0;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC WaterGun *WaterGun__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, =0x000010F6
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, =StageTask_Main
	ldr r1, =WaterGun__Destructor
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
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xac
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	mov r1, #0x31
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, =aActAcGmkWaterG
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x5f
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x16
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldrh r0, [r7, #2]
	cmp r0, #0xeb
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #1
	streq r0, [r4, #0x20]
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, =WaterGun__OnDefend
	mov r3, #8
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	ldr r2, =0x00000201
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	add r0, r4, #0x200
	strh r2, [r0, #0x8c]
	sub r1, r3, #0x10
	mov r2, r1
	add r0, r4, #0x258
	str r3, [sp]
	bl ObjRect__SetBox2D
	add r0, r4, #0x258
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFF
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x270]
	mov r0, #0xc1
	orr r1, r1, #0x20
	str r1, [r4, #0x270]
	bl GetObjectFileWork
	ldr r3, =gameArchiveStage
	mov r2, r0
	ldr r1, =aDfGmkWaterGrai
	ldr r3, [r3, #0]
	mov r0, r4
	bl ObjObjectCollisionDifSet
	str r4, [r4, #0x2d8]
	mov r1, #0x70
	add r0, r4, #0x300
	strh r1, [r0, #8]
	mov r1, #0x40
	strh r1, [r0, #0xa]
	sub r2, r1, #0x60
	add r0, r4, #0x200
	sub r1, r1, #0x80
	strh r2, [r0, #0xf0]
	strh r1, [r0, #0xf2]
	ldrsb r0, [r7, #6]
	bl WaterGrindRail__Create
	bl AllocSndHandle
	str r0, [r4, #0x138]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC WaterGun *WaterGrindTrigger__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, =0x00001801
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, =StageTask_Main
	ldr r1, =WaterGun__Destructor
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
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x120
	orr r0, r0, #0x1000
	str r0, [r4, #0x20]
	ldrh r0, [r7, #2]
	cmp r0, #0xed
	cmpne r0, #0xef
	cmpne r0, #0xf7
	cmpne r0, #0xf9
	cmpne r0, #0xfb
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #1
	streq r0, [r4, #0x20]
	ldrh r0, [r7, #2]
	cmp r0, #0xef
	bhi _02183DB0
	add r0, r0, #0x314
	add r0, r0, #0xfc00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	movhi r3, #0x30
	subhi r5, r3, #0x39
	mvnhi r2, #0x2f
	bhi _02183D68
	mvn r2, #0x17
	mov r3, #0x20
	mov r5, #8
_02183D68:
	add r0, r4, #0x218
	mov r1, #0
	str r5, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, =WaterGrindTrigger__OnDefend
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	orr r0, r0, #0xc0
	bic r0, r0, #4
	str r0, [r4, #0x230]
_02183DB0:
	ldr r0, [r4, #0x18]
	ldr r1, =WaterGrindTrigger__State_218477C
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r0, =WaterGrindTrigger__Draw
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldrsb r0, [r7, #6]
	bl WaterGrindRail__Create
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGun__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x340]
	ldrsb r0, [r0, #6]
	bl WaterGrindRail__Func_2184D34
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	add r0, r0, #0x16
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _02183EAC
	ldr r0, [r4, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	ldr r1, [r4, #0xf4]
	ldr r0, =WaterGun__State_2184248
	cmp r1, r0
	ldrne r0, =WaterGun__State_21842A8
	cmpne r1, r0
	bne _02183EAC
	ldr r1, [r4, #0x340]
	ldr r0, =WaterGun__dword_218A3CC
	ldrsb r1, [r1, #6]
	mov r3, #1
	ldr r2, [r0, #8]
	mvn r1, r3, lsl r1
	and r1, r2, r1
	str r1, [r0, #8]
	ldr r1, [r4, #0x340]
	ldr r2, [r0, #4]
	ldrsb r1, [r1, #6]
	mvn r1, r3, lsl r1
	and r1, r2, r1
	str r1, [r0, #4]
	ldr r1, [r4, #0x340]
	ldr r2, [r0, #0]
	ldrsb r1, [r1, #6]
	mvn r1, r3, lsl r1
	and r1, r2, r1
	str r1, [r0]
_02183EAC:
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGun__State_2183EC4(WaterGun *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r2, [r4, #0x35c]
	ldr r1, [r2, #0x6d8]
	cmp r1, r4
	beq _02183F18
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r1, [r4, #0x18]
	mov r0, #0
	bic r1, r1, #0x12
	str r1, [r4, #0x18]
	str r4, [r4, #0x234]
	ldr r1, [r4, #0x230]
	add sp, sp, #8
	bic r1, r1, #0x800
	str r1, [r4, #0x230]
	str r0, [r4, #0xf4]
	str r0, [r4, #0x35c]
	ldmia sp!, {r4, pc}
_02183F18:
	add r1, r2, #0x700
	ldrh r1, [r1, #0x22]
	tst r1, #3
	beq _02183F9C
	mov ip, #0
	ldr r1, =WaterGun__State_21840B4
	str ip, [r4, #0x2c]
	str r1, [r4, #0xf4]
	ldr r0, =WaterGun__Draw
	sub r1, ip, #1
	str r0, [r4, #0xfc]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x40
	str r0, [r4, #0x20]
	str r4, [r4, #0x274]
	ldr r2, [r4, #0x270]
	mov r0, #0x11c
	bic r2, r2, #0x800
	str r2, [r4, #0x270]
	ldr r3, [r4, #0x354]
	mov r2, r1
	bic r3, r3, #1
	str r3, [r4, #0x354]
	str ip, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02183F9C:
	ldr r1, [r4, #0x2c]
	add r1, r1, #1
	str r1, [r4, #0x2c]
	tst r1, #0x1f
	bne _02184010
	tst r1, #0x20
	beq _02183FCC
	mov r1, #1
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x24]
	orr r0, r0, #2
	b _02183FDC
_02183FCC:
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x24]
	bic r0, r0, #2
_02183FDC:
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x354]
	ldr ip, =0x0000011B
	orr r0, r0, #1
	sub r1, ip, #0x11c
	str r0, [r4, #0x354]
	mov r0, #8
	str r0, [r4, #0x28]
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
_02184010:
	ldr r0, [r4, #0x354]
	tst r0, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r3, =_mt_math_rand
	ldr r1, =0x00196225
	ldr r0, [r3, #0]
	ldr r2, =0x3C6EF35F
	mla ip, r0, r1, r2
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	sub r0, r0, #1
	str ip, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x50]
	ldr r0, [r3, #0]
	mla r1, r0, r1, r2
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	sub r0, r0, #1
	str r1, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x54]
	ldr r0, [r4, #0x28]
	subs r0, r0, #1
	str r0, [r4, #0x28]
	ldreq r0, [r4, #0x354]
	biceq r0, r0, #1
	streq r0, [r4, #0x354]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGun__State_21840B4(WaterGun *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, [r4, #0x2c]
	add r0, r0, #0x10000
	str r0, [r4, #0x2c]
	cmp r0, #0xc0000
	blt _02184228
	ldr r1, [r4, #0x340]
	ldr r0, =WaterGun__dword_218A3CC
	ldrsb r1, [r1, #6]
	ldr r2, [r0, #8]
	mov r3, #1
	orr r1, r2, r3, lsl r1
	str r1, [r0, #8]
	ldr r1, [r4, #0x340]
	ldr r2, [r0, #4]
	ldrsb r1, [r1, #6]
	mvn r1, r3, lsl r1
	and r2, r2, r1
	str r2, [r0, #4]
	ldr r1, [r4, #0x128]
	ldrh r1, [r1, #0xc]
	cmp r1, #1
	bne _02184124
	ldr r1, [r4, #0x340]
	ldrsb r1, [r1, #6]
	orr r1, r2, r3, lsl r1
	str r1, [r0, #4]
_02184124:
	ldr r1, [r4, #0x340]
	ldr r0, =WaterGun__dword_218A3CC
	ldrsb r1, [r1, #6]
	ldr r3, [r0, #0]
	mov r2, #1
	orr r1, r3, r2, lsl r1
	str r1, [r0]
	ldr r0, [r4, #0x340]
	ldrb r1, [r0, #9]
	ldrb r0, [r0, #8]
	add r0, r1, r0
	movs r0, r0, lsl #1
	str r0, [r4, #0x2c]
	moveq r0, #0x384
	streq r0, [r4, #0x2c]
	ldr r0, [r4, #0x128]
	ldr r1, [r4, #0x13c]
	ldrh r0, [r0, #0xc]
	cmp r0, #0
	bne _021841B4
	ldr r5, [r1, #0x58]
	mov r0, #0xc1
	bl GetObjectFileWork
	cmp r5, r0
	beq _021841F0
	mov r0, r5
	bl ObjDataRelease
	mov r0, #0xc1
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r2, r0
	ldr r3, [r1, #0]
	ldr r1, =aDfGmkWaterGrai
	mov r0, r4
	bl ObjObjectCollisionDifSet
	b _021841F0
_021841B4:
	ldr r5, [r1, #0x58]
	mov r0, #0xc2
	bl GetObjectFileWork
	cmp r5, r0
	beq _021841F0
	mov r0, r5
	bl ObjDataRelease
	mov r0, #0xc2
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r2, r0
	ldr r3, [r1, #0]
	ldr r1, =aDfGmkWaterGrai_0
	mov r0, r4
	bl ObjObjectCollisionDifSet
_021841F0:
	mov r2, #0
	str r2, [r4, #0x274]
	ldr r1, [r4, #0x270]
	ldr r0, =WaterGun__State_2184248
	orr r1, r1, #0x800
	str r1, [r4, #0x270]
	str r0, [r4, #0xf4]
	str r2, [r4, #0xfc]
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x40
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x24]
	orr r0, r0, #1
	str r0, [r4, #0x24]
_02184228:
	mov r0, r4
	bl WaterGun__Func_218448C
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGun__State_2184248(WaterGun *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WaterGun__Func_218448C
	ldr r0, [r4, #0x2c]
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	bne _0218427C
	mov r0, r4
	bl WaterGun__State_21842A8
	ldr r0, [r4, #0x138]
	mov r1, #0xf
	bl NNS_SndPlayerStopSeq
	ldmia sp!, {r4, pc}
_0218427C:
	cmp r0, #0x3c
	ldmgeia sp!, {r4, pc}
	ldr r1, [r4, #0x340]
	ldr r0, =WaterGun__dword_218A3CC
	ldrsb r1, [r1, #6]
	ldr r3, [r0, #0]
	mov r2, #1
	eor r1, r3, r2, lsl r1
	str r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGun__State_21842A8(WaterGun *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x340]
	ldrsb r0, [r0, #6]
	bl WaterGrindRail__GetAnimator
	ldr r1, [r4, #0x340]
	ldr r0, =WaterGun__dword_218A3CC
	ldrsb r1, [r1, #6]
	mov r3, #1
	ldr r2, [r0, #8]
	mvn r1, r3, lsl r1
	and r1, r2, r1
	str r1, [r0, #8]
	ldr r1, [r4, #0x340]
	ldr r2, [r0, #4]
	ldrsb r1, [r1, #6]
	mvn r1, r3, lsl r1
	and r1, r2, r1
	str r1, [r0, #4]
	ldr r1, [r4, #0x340]
	ldr r2, [r0, #0]
	ldrsb r1, [r1, #6]
	mvn r1, r3, lsl r1
	and r1, r2, r1
	str r1, [r0]
	ldr r0, [r4, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, #0
	beq _0218439C
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x13c]
	ldr r0, [r0, #0x58]
	bl ObjDataRelease
	mov r0, #0xc1
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r2, r0
	ldr r3, [r1, #0]
	ldr r1, =aDfGmkWaterGrai
	mov r0, r4
	bl ObjObjectCollisionDifSet
	mov r0, #0
	ldr r1, =0x0000011B
	str r0, [sp]
	str r1, [sp, #4]
	sub r1, r1, #0x11c
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, =defaultSfxPlayer
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r1, =WaterGun__State_21843E4
	mov r0, #4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}
_0218439C:
	ldr r1, [r4, #0x18]
	mov r0, #0
	bic r1, r1, #0x10
	str r1, [r4, #0x18]
	str r4, [r4, #0x234]
	ldr r1, [r4, #0x230]
	bic r1, r1, #0x800
	str r1, [r4, #0x230]
	str r0, [r4, #0xf4]
	str r0, [r4, #0x35c]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGun__State_21843E4(WaterGun *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr ip, =_mt_math_rand
	ldr r2, =0x00196225
	ldr r1, [ip]
	ldr r3, =0x3C6EF35F
	mla lr, r1, r2, r3
	mov r1, lr, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #3
	sub r1, r1, #1
	str lr, [ip]
	mov r1, r1, lsl #0xc
	str r1, [r0, #0x50]
	ldr r1, [ip]
	mla r2, r1, r2, r3
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #3
	sub r1, r1, #1
	str r2, [ip]
	mov r1, r1, lsl #0xc
	str r1, [r0, #0x54]
	ldr r1, [r0, #0x28]
	subs r1, r1, #1
	str r1, [r0, #0x28]
	ldmneia sp!, {r3, pc}
	ldr r2, [r0, #0x18]
	mov r1, #0
	bic r2, r2, #0x10
	str r2, [r0, #0x18]
	str r0, [r0, #0x234]
	ldr r2, [r0, #0x230]
	bic r2, r2, #0x800
	str r2, [r0, #0x230]
	str r1, [r0, #0xf4]
	str r1, [r0, #0x35c]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGun__Func_218448C(WaterGun *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov lr, r0
	add r0, lr, #0x44
	ldr r3, =gPlayer
	add ip, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r1, [r3, #0]
	ldr r0, [sp]
	ldr r1, [r1, #0x44]
	cmp r1, r0
	blt _021844D0
	add r0, r0, #0x200000
	cmp r1, r0
	strle r1, [sp]
	strgt r0, [sp]
_021844D0:
	ldr r0, [lr, #0x138]
	add r1, sp, #0
	bl ProcessSpatialSfx
	add sp, sp, #0xc
	ldmia sp!, {pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGun__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x28
	mov r0, #0
	str r0, [sp, #0xc]
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, #0
	ldr r0, [r4, #0x20]
	bne _02184558
	tst r0, #1
	mov r0, #0x50000
	streq r0, [sp, #0x10]
	moveq r8, #0x20000
	beq _02184534
	rsb r0, r0, #0
	str r0, [sp, #0x10]
	add r8, r0, #0x30000
_02184534:
	ldr r0, [r4, #0x340]
	mov r11, #0x18000
	ldrsb r0, [r0, #6]
	rsb r11, r11, #0
	mov r9, #0
	mov r6, #0x20000
	bl WaterGrindRail__GetAnimator
	mov r5, r0
	b _02184598
_02184558:
	tst r0, #1
	mov r0, #0x48000
	streq r0, [sp, #0x10]
	moveq r8, #0x30000
	beq _02184578
	rsb r0, r0, #0
	str r0, [sp, #0x10]
	add r8, r0, #0x18000
_02184578:
	ldr r0, [r4, #0x340]
	mov r11, #0x39000
	ldrsb r0, [r0, #6]
	rsb r11, r11, #0
	add r9, r11, #0x29000
	mov r6, #0x30000
	bl WaterGrindRail__GetAnimator
	add r5, r0, #0xa4
_02184598:
	ldr r0, [r4, #0x2c]
	mov r1, r6, asr #0xc
	mov r0, r0, asr #0xc
	bl FX_DivS32
	mov r7, r0
	mul r0, r7, r6
	ldr r1, [r4, #0x2c]
	subs r10, r1, r0
	beq _021845F4
	ldr r0, [r4, #0x20]
	sub r10, r6, r10
	tst r0, #1
	rsbeq r10, r10, #0
	mov r0, r10
	mov r1, r8
	add r7, r7, #1
	bl FX_Div
	smull r1, r0, r9, r0
	adds r2, r1, #0x800
	adc r1, r0, #0
	mov r0, r2, lsr #0xc
	orr r0, r0, r1, lsl #20
	str r0, [sp, #0xc]
_021845F4:
	ldr r0, [r4, #0x20]
	mov r6, #0
	and r0, r0, #1
	orr r0, r0, #0x1100
	str r0, [sp, #0x18]
	ldr r1, [r4, #0x44]
	ldr r0, [sp, #0x10]
	cmp r7, #0
	add r0, r1, r0
	add r0, r10, r0
	str r0, [sp, #0x1c]
	ldr r0, [r4, #0x48]
	add r1, r0, r11
	ldr r0, [sp, #0xc]
	str r6, [sp, #0x24]
	add r0, r0, r1
	str r0, [sp, #0x20]
	ldr r0, [r5, #0x3c]
	str r0, [sp, #0x14]
	ble _0218468C
	add r10, sp, #0x18
	mov r11, r6
_0218464C:
	stmia sp, {r10, r11}
	mov r0, r5
	add r1, sp, #0x1c
	mov r2, r11
	str r11, [sp, #8]
	add r3, r4, #0x38
	bl StageTask__Draw2DEx
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x20]
	add r1, r1, r8
	add r0, r0, r9
	add r6, r6, #1
	str r1, [sp, #0x1c]
	str r0, [sp, #0x20]
	cmp r6, r7
	blt _0218464C
_0218468C:
	ldr r2, [sp, #0x1c]
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x14]
	str r0, [r5, #0x3c]
	ldr r0, [r4, #0x44]
	sub r0, r2, r0
	mov r0, r0, asr #0xc
	str r0, [r4, #0x264]
	ldr r0, [r4, #0x48]
	sub r0, r1, r0
	mov r0, r0, asr #0xc
	str r0, [r4, #0x268]
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGun__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r2, [r1, #0x1c]
	ldr r3, [r0, #0x1c]
	cmp r2, #0
	cmpne r3, #0
	ldmeqia sp!, {r3, pc}
	ldrh ip, [r3]
	cmp ip, #1
	ldmneia sp!, {r3, pc}
	ldr ip, [r3, #0x114]
	cmp ip, r2
	beq _0218472C
	ldr ip, [r3, #0x1c]
	tst ip, #1
	beq _0218472C
	ldr ip, [r3, #0x20]
	ands lr, ip, #1
	beq _02184718
	ldr ip, [r2, #0x20]
	tst ip, #1
	bne _02184734
_02184718:
	cmp lr, #0
	bne _0218472C
	ldr ip, [r2, #0x20]
	tst ip, #1
	beq _02184734
_0218472C:
	bl ObjRect__FuncNoHit
	ldmia sp!, {r3, pc}
_02184734:
	str r3, [r2, #0x35c]
	ldr r0, [r2, #0x18]
	mov r1, #0
	orr r0, r0, #0x10
	str r0, [r2, #0x18]
	str r1, [r2, #0x234]
	ldr r0, [r2, #0x230]
	ldr ip, =WaterGun__State_2183EC4
	orr r0, r0, #0x800
	str r0, [r2, #0x230]
	str r1, [r2, #0x2c]
	str r1, [r2, #0x24]
	mov r0, r3
	mov r1, r2
	str ip, [r2, #0xf4]
	bl Player__Action_WaterGun
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGrindTrigger__State_218477C(WaterGrindTrigger *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x340]
	ldr r2, =WaterGun__dword_218A3CC
	ldrsb ip, [r1, #6]
	ldr r3, [r2, #8]
	mov lr, #1
	tst r3, lr, lsl ip
	ldmeqia sp!, {r3, pc}
	ldr r2, [r2, #4]
	tst r2, lr, lsl ip
	ldrh r2, [r1, #2]
	beq _021847F8
	cmp r2, #0xec
	cmpne r2, #0xed
	ldmeqia sp!, {r3, pc}
	add r3, r2, #0xa
	add r3, r3, #0xff00
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #1
	ldmlsia sp!, {r3, pc}
	add r3, r2, #6
	add r3, r3, #0xff00
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #1
	bhi _02184840
	ldrh r1, [r1, #4]
	tst r1, #1
	bne _02184840
	ldmia sp!, {r3, pc}
_021847F8:
	cmp r2, #0xee
	cmpne r2, #0xef
	ldmeqia sp!, {r3, pc}
	add r3, r2, #0x308
	add r3, r3, #0xfc00
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #1
	ldmlsia sp!, {r3, pc}
	add r3, r2, #6
	add r3, r3, #0xff00
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #1
	bhi _02184840
	ldrh r1, [r1, #4]
	tst r1, #1
	ldmneia sp!, {r3, pc}
_02184840:
	cmp r2, #0xef
	bhi _02184864
	str r0, [r0, #0x234]
	ldr r1, [r0, #0x230]
	orr r1, r1, #4
	str r1, [r0, #0x230]
	ldr r1, [r0, #0x18]
	bic r1, r1, #2
	str r1, [r0, #0x18]
_02184864:
	ldr r2, [r0, #0x20]
	mov r1, #0
	bic r2, r2, #0x20
	str r2, [r0, #0x20]
	str r1, [r0, #0xf4]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGrindTrigger__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x340]
	ldr r0, =WaterGun__dword_218A3CC
	ldrsb r3, [r1, #6]
	ldr r1, [r0, #8]
	mov r2, #1
	tst r1, r2, lsl r3
	bne _021848E8
	mov r0, #0
	str r0, [r4, #0x234]
	ldr r1, [r4, #0x230]
	ldr r0, =WaterGrindTrigger__State_218477C
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x18]
	add sp, sp, #0xc
	orr r1, r1, #2
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x20
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r3, r4, r5, r6, pc}
_021848E8:
	ldr r0, [r0, #0]
	tst r0, r2, lsl r3
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	mov r0, r3, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WaterGrindRail__GetAnimator
	ldr r1, [r4, #0x340]
	mov r5, r0
	ldrh r0, [r1, #2]
	sub r0, r0, #0xec
	cmp r0, #0xf
	addls pc, pc, r0, lsl #2
	b _0218497C
_02184920: // jump table
	b _0218497C // case 0
	b _0218497C // case 1
	b _02184960 // case 2
	b _02184960 // case 3
	b _0218497C // case 4
	b _0218497C // case 5
	b _0218497C // case 6
	b _0218497C // case 7
	b _0218497C // case 8
	b _0218497C // case 9
	b _02184970 // case 10
	b _02184970 // case 11
	b _02184978 // case 12
	b _02184978 // case 13
	b _02184968 // case 14
	b _02184968 // case 15
_02184960:
	add r5, r5, #0xa4
	b _0218497C
_02184968:
	add r5, r5, #0x148
	b _0218497C
_02184970:
	add r5, r5, #0x1ec
	b _0218497C
_02184978:
	add r5, r5, #0x290
_0218497C:
	ldr r6, [r5, #0x3c]
	add r0, r4, #0x20
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r0, r5
	add r1, r4, #0x44
	add r3, r4, #0x38
	str r2, [sp, #8]
	bl StageTask__Draw2DEx
	str r6, [r5, #0x3c]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGrindTrigger__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x18]
	bic r0, r0, #1
	str r0, [r5, #0x18]
	ldr r0, [r5, #0x5dc]
	orr r0, r0, #0x10000
	str r0, [r5, #0x5dc]
	ldr r0, [r4, #0x340]
	ldrb r1, [r5, #0x710]
	ldrh r0, [r0, #4]
	bic r1, r1, #0x80
	add r0, r0, #1
	cmp r1, r0
	beq _02184AA0
	add r0, r5, #0x500
	ldrsh r0, [r0, #0xd4]
	cmp r0, #0x1b
	blt _02184A28
	cmp r0, #0x21
	ble _02184AA0
_02184A28:
	ldr r0, [r5, #0x1c]
	tst r0, #1
	beq _02184AA0
	ldrb r0, [r5, #0x711]
	tst r0, #2
	bne _02184AA0
	orr r0, r0, #3
	strb r0, [r5, #0x711]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #4]
	and r0, r0, #0x3f
	add r0, r0, #1
	strb r0, [r5, #0x710]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	sub r0, r0, #0xec
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02184A84
_02184A74: // jump table
	b _02184A84 // case 0
	b _02184A8C // case 1
	b _02184A84 // case 2
	b _02184A8C // case 3
_02184A84:
	ldr r1, [r5, #0x604]
	b _02184A94
_02184A8C:
	ldr r0, [r5, #0x604]
	rsb r1, r0, #0
_02184A94:
	mov r0, r5
	mov r2, #0
	bl Player__UseDashPanel
_02184AA0:
	ldr r0, [r5, #0x5dc]
	orr r0, r0, #4
	str r0, [r5, #0x5dc]
	ldr r0, [r5, #0x1c]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	sub r0, r0, #0xec
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02184AE0
_02184AD0: // jump table
	b _02184AE0 // case 0
	b _02184B04 // case 1
	b _02184AE0 // case 2
	b _02184B04 // case 3
_02184AE0:
	ldr r0, [r5, #0xc8]
	cmp r0, #0x2000
	ldmgeia sp!, {r3, r4, r5, pc}
	mov r0, #0x2000
	str r0, [r5, #0xc8]
	ldr r0, [r5, #0x20]
	bic r0, r0, #1
	str r0, [r5, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
_02184B04:
	mov r0, #0x2000
	ldr r1, [r5, #0xc8]
	rsb r0, r0, #0
	cmp r1, r0
	ldmleia sp!, {r3, r4, r5, pc}
	str r0, [r5, #0xc8]
	ldr r0, [r5, #0x20]
	orr r0, r0, #1
	str r0, [r5, #0x20]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGrindRail__Create(s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r1, =WaterGrindRail__Singleton
	mov r4, r0
	ldr r0, [r1, r4, lsl #2]
	cmp r0, #0
	beq _02184B68
	bl GetTaskWork_
	add r1, r0, #0x400
	ldrh r2, [r1, #0x9e]
	add sp, sp, #0xc
	add r0, r0, #0x168
	add r2, r2, #1
	strh r2, [r1, #0x9e]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02184B68:
	ldr r0, =0x000010F6
	mov r2, #0
	str r0, [sp]
	mov r5, #2
	str r5, [sp, #4]
	mov r5, #0x4a0
	ldr r0, =StageTask_Main
	ldr r1, =WaterGrindRail__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, =WaterGrindRail__Singleton
	mov r0, r5
	str r5, [r1, r4, lsl #2]
	bl GetTaskWork_
	mov r1, #0
	mov r2, #0x4a0
	mov r10, r0
	bl MI_CpuFill8
	mov r0, #0xa
	mul r0, r4, r0
	add r8, r0, #0xad
	mov r1, #4
	strh r1, [r10]
	add r0, r10, #0x400
	strh r4, [r0, #0x9c]
	ldrh r1, [r0, #0x9e]
	ldr r7, =WaterGrindRail__byte_2189D28
	ldr r4, =gameArchiveStage
	add r1, r1, #1
	strh r1, [r0, #0x9e]
	ldr r0, [r10, #0x1c]
	add r6, r10, #0x168
	orr r0, r0, #0x2100
	str r0, [r10, #0x1c]
	ldr r0, [r10, #0x20]
	add r9, r8, #1
	orr r0, r0, #0x20
	mov r5, #0
	str r0, [r10, #0x20]
	mov r11, #0xac
_02184C28:
	mov r0, r11
	bl GetObjectFileWork
	ldr r1, [r4, #0]
	mov r3, r0
	str r1, [sp]
	ldr r1, =aActAcGmkWaterG
	mov r0, r6
	mov r2, #0
	bl ObjAction2dBACLoad
	mov r0, r8
	bl GetObjectFileWork
	ldrb r2, [r7, #0]
	mov r1, #0
	bl ObjActionAllocSprite
	str r0, [r6, #0x78]
	mov r0, r9
	bl GetObjectFileWork
	ldrb r2, [r7], #1
	mov r1, #1
	bl ObjActionAllocSprite
	add r1, r5, #2
	str r0, [r6, #0x7c]
	mov r1, r1, lsl #0x10
	ldr r0, [r6, #0x14]
	mov r1, r1, lsr #0x10
	mov r2, #0x5d
	bl ObjDrawAllocSpritePalette
	strh r0, [r6, #0x50]
	ldrh r2, [r6, #0x50]
	add r1, r5, #2
	mov r1, r1, lsl #0x10
	strh r2, [r6, #0x92]
	strh r2, [r6, #0x90]
	ldr r2, [r6, #0x3c]
	mov r0, r6
	orr r2, r2, #0x14
	mov r1, r1, lsr #0x10
	str r2, [r6, #0x3c]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r6
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r6
	mov r1, #2
	bl StageTask__SetOAMPriority
	add r5, r5, #1
	add r8, r8, #2
	add r9, r9, #2
	cmp r5, #5
	add r6, r6, #0xa4
	blt _02184C28
	add r0, r10, #0x2b0
	mov r1, #0x16
	bl StageTask__SetOAMOrder
	ldr r1, =WaterGrindRail__Draw
	add r0, r10, #0x168
	str r1, [r10, #0xfc]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGrindRail__Func_2184D34(s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, =WaterGrindRail__Singleton
	ldr r0, [r1, r0, lsl #2]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetTaskWork_
	add r1, r0, #0x400
	ldrh r2, [r1, #0x9e]
	sub r2, r2, #1
	strh r2, [r1, #0x9e]
	ldrh r1, [r1, #0x9e]
	cmp r1, #0
	ldmneia sp!, {r3, pc}
	ldr r1, [r0, #0x18]
	orr r1, r1, #8
	str r1, [r0, #0x18]
	bl WaterGrindRail__Func_2184DB8
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGrindRail__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	add r1, r0, #0x400
	ldrh r2, [r1, #0x9c]
	ldr r1, =WaterGrindRail__Singleton
	ldr r1, [r1, r2, lsl #2]
	cmp r1, r4
	bne _02184DA8
	bl WaterGrindRail__Func_2184DB8
_02184DA8:
	mov r0, r4
	bl StageTask_Destructor
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGrindRail__Func_2184DB8(WaterGrindRail *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r5, r0
	add r0, r5, #0x400
	ldrh r1, [r0, #0x9c]
	mov r0, #0xa
	mov r8, #0
	mul r0, r1, r0
	add r4, r5, #0x168
	add r9, r0, #0xad
	mov r7, r8
	mov r6, #0xac
_02184DE4:
	ldrh r0, [r4, #0x50]
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	mov r0, r9
	bl GetObjectFileWork
	bl ObjActionReleaseSpriteDS
	str r7, [r4, #0x78]
	mov r0, r6
	str r7, [r4, #0x7c]
	bl GetObjectFileWork
	mov r1, r4
	bl ObjAction2dBACRelease
	add r8, r8, #1
	cmp r8, #5
	add r9, r9, #2
	add r4, r4, #0xa4
	blt _02184DE4
	add r0, r5, #0x400
	ldrh r1, [r0, #0x9c]
	ldr r0, =WaterGrindRail__Singleton
	mov r2, #0
	str r2, [r0, r1, lsl #2]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC AnimatorSpriteDS *WaterGrindRail__GetAnimator(s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, =WaterGrindRail__Singleton
	mov r2, #0
	ldr r0, [r1, r0, lsl #2]
	cmp r0, #0
	beq _02184E64
	bl GetTaskWork_
	add r2, r0, #0x168
_02184E64:
	mov r0, r2
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterGrindRail__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r5, #0
	add r6, r0, #0x168
	mov r4, r5
_02184E84:
	mov r0, r6
	mov r1, r4
	mov r2, r4
	bl AnimatorSpriteDS__ProcessAnimation
	add r5, r5, #1
	cmp r5, #5
	add r6, r6, #0xa4
	blt _02184E84
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}