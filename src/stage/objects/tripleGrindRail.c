#include <stage/objects/tripleGrindRail.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/stage/mapFarSys.h>
#include <stage/core/ringManager.h>

// --------------------
// VARIABLES
// --------------------

extern RingManager *ringManagerWork;

static Task *TripleGrindRail__Singleton;

NOT_DECOMPILED void *TripleGrindRail__stru_21884D4;
NOT_DECOMPILED void *TripleGrindRail__stru_21884E0;
NOT_DECOMPILED void *TripleGrindRail__word_21884EC;

NOT_DECOMPILED void *aActAcGmkGrd3lS;
NOT_DECOMPILED void *aModGmkGrd3line;
NOT_DECOMPILED void *aModGmkGrd3line_0;
NOT_DECOMPILED void *aActAcEffGrd3lL_0;
NOT_DECOMPILED void *aActAcItmRing3d;
NOT_DECOMPILED void *aActAcGmkBallSi;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC TripleGrindRailSpring *TripleGrindRailSpring__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
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
	mov r4, #0x364
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
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
	mov r0, #0xb0
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =aActAcGmkGrd3lS
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x56
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, =TripleGrindRailSpring__OnDefend
	ldr r2, =TripleGrindRailSpring__State_Active
	str r0, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	mov r0, r4
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	ldr r3, [r4, #0x1c]
	mov r1, #0
	orr r3, r3, #0x2100
	str r3, [r4, #0x1c]
	str r2, [r4, #0xf4]
	bl StageTask__SetAnimation
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC TripleGrindRail *TripleGrindRail__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r6, r0
	mov r5, r1
	mov r4, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r7, =0x0000117C
	ldr r0, =StageTask_Main
	ldr r1, =TripleGrindRail__Destructor
	mov r3, r2
	str r7, [sp, #8]
	bl TaskCreate_
	mov r7, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r7, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r7
	bl GetTaskWork_
	ldr r2, =0x0000117C
	mov r1, #0
	mov r7, r0
	bl MI_CpuFill8
	ldr r2, =TripleGrindRail__Singleton
	mov r0, r7
	str r7, [r2]
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	ldrsb r0, [r6, #6]
	mov r3, #0
	ldr r2, =aModGmkGrd3line
	cmp r0, #8
	movlt r0, #8
	sub r0, r0, #4
	add r0, r5, r0, lsl #18
	sub r1, r0, #0x22c000
	mov r0, #0x200
	str r1, [r7, #0xe08]
	rsb r0, r0, #0
	strh r0, [r7, #0xe]
	mov r0, #0x200
	strh r0, [r7, #0x14]
	ldr r0, [r7, #0xe04]
	add r1, r7, #0x364
	orr r0, r0, #1
	str r0, [r7, #0xe04]
	ldr r0, =gameArchiveStage
	str r3, [sp]
	ldr r4, [r0, #0]
	mov r0, r7
	str r4, [sp, #4]
	bl ObjAction3dNNModelLoad
	ldr r0, =gameArchiveStage
	ldr r2, =aModGmkGrd3line_0
	ldr r4, [r0, #0]
	mov r0, r7
	add r1, r7, #0x364
	mov r3, #0
	str r4, [sp]
	bl ObjAction3dNNMotionLoad
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x12c]
	mov r1, #3
	ldr r2, [r0, #0x154]
	bl AnimatorMDL__SetAnimation
	ldr r1, [r7, #0x20]
	mov r0, #0
	orr r1, r1, #4
	str r1, [r7, #0x20]
	str r0, [r7, #0x47c]
	ldr r2, [r7, #0x20]
	ldr r1, =0x000034CC
	orr r2, r2, #0x100
	str r2, [r7, #0x20]
	str r1, [r7, #0x37c]
	str r1, [r7, #0x380]
	str r1, [r7, #0x384]
	ldr r2, =0x00141BB2
	ldr r1, =aActAcEffGrd3lL_0
	str r2, [r7, #0x50]
	ldr r3, [r7, #0x20]
	ldr r2, =gameArchiveStage
	orr r3, r3, #0x20
	str r3, [r7, #0x20]
	ldr r2, [r2, #0]
	bl ObjDataLoad
	mov r9, r0
	add r10, r7, #0x4e0
	mov r8, #0
	mov r5, #0x860
	mov r4, #0x1d
	mov r11, #7
	b _02163884
_02163804:
	mov r1, r8, lsl #0x10
	mov r0, r9
	mov r1, r1, lsr #0x10
	bl Sprite__GetTextureSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r1, r8, lsl #0x10
	mov r6, r0
	mov r0, r9
	mov r1, r1, lsr #0x10
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocPalette
	stmia sp, {r5, r6}
	mov r3, r8, lsl #0x10
	str r0, [sp, #8]
	mov r0, r10
	mov r1, #0
	mov r2, r9
	mov r3, r3, lsr #0x10
	bl AnimatorSprite3D__Init
	strb r4, [r10, #0xa]
	mov r1, #0
	strb r11, [r10, #0xb]
	mov r0, r10
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, [r10, #0xcc]
	add r8, r8, #1
	orr r0, r0, #0x18
	str r0, [r10, #0xcc]
	add r10, r10, #0x104
_02163884:
	cmp r8, #7
	blt _02163804
	mov r8, #0
	mov r2, #0x100000
	mov r0, #0xc
	b _021638A8
_0216389C:
	mla r1, r8, r0, r7
	str r2, [r1, #0xe1c]
	add r8, r8, #1
_021638A8:
	cmp r8, #0x40
	blt _0216389C
	mov r8, #0
	mov r2, #0x100000
	mov r0, #0xc
	b _021638D0
_021638C0:
	mla r1, r8, r0, r7
	add r1, r1, #0x1000
	str r2, [r1, #0x120]
	add r8, r8, #1
_021638D0:
	cmp r8, #8
	blt _021638C0
	ldr r0, =gameArchiveStage
	ldr r1, =aActAcItmRing3d
	ldr r2, [r0, #0]
	mov r0, #0
	bl ObjDataLoad
	mov r4, r0
	mov r0, #0x80
	mov r1, #0
	add r5, r7, #0x3fc
	bl VRAMSystem__AllocTexture
	mov r6, r0
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	ldr r2, =0x00000844
	mov r1, #0
	stmia sp, {r2, r6}
	str r0, [sp, #8]
	add r0, r5, #0x800
	mov r2, r4
	mov r3, r1
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	strb r0, [r5, #0x80a]
	mov r0, #7
	mov r1, #0
	strb r0, [r5, #0x80b]
	add r0, r5, #0x800
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r1, [r5, #0x8cc]
	mov r0, #0x300
	orr r1, r1, #0x10
	str r1, [r5, #0x8cc]
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r5, r0
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0x860
	stmia sp, {r1, r5}
	str r0, [sp, #8]
	mov r2, r4
	add r0, r7, #0xd00
	mov r1, #0
	mov r3, #1
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	strb r0, [r7, #0xd0a]
	mov r0, #7
	mov r1, #0
	strb r0, [r7, #0xd0b]
	add r0, r7, #0xd00
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, [r7, #0xdcc]
	mov r1, #0
	orr r0, r0, #0x18
	str r0, [r7, #0xdcc]
	ldr r0, =StageTask__DefaultDiffData
	str r1, [r7, #0x13c]
	str r0, [r7, #0x2fc]
	mov r2, #0x200
	add r0, r7, #0x300
	strh r2, [r0, #8]
	mov r2, #8
	strh r2, [r0, #0xa]
	sub r0, r2, #0xc8
	add r3, r7, #0x200
	strh r0, [r3, #0xf0]
	mov r2, r1
	add r0, r7, #0x218
	strh r1, [r3, #0xf2]
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r7, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	mov r4, #0
	add r0, r7, #0x218
	sub r1, r4, #0x80
	sub r2, r4, #0xc0
	mov r3, #0x80
	str r4, [sp]
	bl ObjRect__SetBox2D
	ldr r1, =0x00000102
	add r0, r7, #0x200
	strh r1, [r0, #0x4c]
	ldr r0, =TripleGrindRail__OnDefend_StartTrigger
	str r7, [r7, #0x234]
	str r0, [r7, #0x23c]
	ldr r1, [r7, #0x230]
	mov r0, r7
	orr r1, r1, #0x400
	str r1, [r7, #0x230]
	ldr r1, [r7, #0x1c]
	orr r1, r1, #0x100
	str r1, [r7, #0x1c]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC TripleGrindRailEntity *TripleGrindRailEntity__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, =TripleGrindRail__Singleton
	mov r7, r0
	ldr r3, [r3, #0]
	mov r6, r1
	cmp r3, #0
	mov r5, r2
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r3, #0x44]
	cmp r6, r0
	addle sp, sp, #0xc
	movle r0, #0
	ldmleia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r3, #0xe04]
	tst r0, #1
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r0, #0x1800
	str r0, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, =0x0000117C
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
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
	mov r2, #0x480
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldrsb r2, [r7, #6]
	cmp r2, #0
	movlt r2, #0
	blt _02163B8C
	cmp r2, #2
	movgt r2, #2
_02163B8C:
	ldr r0, =0x00059184
	ldr r1, =0x000E8A2E
	mla r0, r2, r0, r1
	str r0, [r4, #0x478]
	ldrh r0, [r7, #2]
	cmp r0, #0x7a
	beq _02163BB0
	cmp r0, #0x7b
	beq _02163C88
_02163BB0:
	mov r0, #0xb1
	bl GetObjectFileWork
	mov r3, #0
	str r3, [sp]
	str r0, [sp, #4]
	ldr r0, =gameArchiveStage
	ldr r2, =aActAcGmkBallSi
	ldr r5, [r0, #0]
	mov r0, r4
	add r1, r4, #0x364
	str r5, [sp, #8]
	bl ObjObjectAction3dBACLoad
	mov r0, #0xb2
	bl GetObjectFileWork
	mov r3, r0
	mov r0, r4
	mov r1, #0x800
	mov r2, #0x10
	bl ObjObjectActionAllocTexture
	mov r0, #0xb2
	bl GetObjectFileWork
	ldrh r0, [r0, #4]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _02163C3C
	ldr r0, [r4, #0x430]
	mov r2, r4
	orr r0, r0, #0x60
	str r0, [r4, #0x430]
	ldr r1, [r4, #0x104]
	add r0, r4, #0x364
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, [r4, #0x430]
	orr r0, r0, #0x18
	str r0, [r4, #0x430]
_02163C3C:
	add r0, r4, #0x218
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFF
	add r0, r4, #0x218
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x230]
	mov r0, #0x2800
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x20]
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	b _02163D14
_02163C88:
	ldr r0, =TripleGrindRail__Singleton
	add r1, r4, #0x364
	ldr r0, [r0, #0]
	mov r2, #0x104
	add r0, r0, #0xd00
	bl MI_CpuCopy8
	mov r5, #4
	str r4, [r4, #0x234]
	mov r0, #8
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	add r0, r4, #0x218
	sub r1, r5, #0xc
	sub r2, r5, #0x14
	sub r3, r5, #8
	str r5, [sp, #8]
	bl ObjRect__SetBox3D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x230]
	ldr r0, =TripleGrindRailEntity__OnDefend
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	str r0, [r4, #0x23c]
	mov r0, #0x2800
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
_02163D14:
	ldr r0, [r4, #0x18]
	ldr r1, =TripleGrindRailEntity__State_Inactive
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x1c]
	mov r0, r4
	orr r2, r2, #0x2100
	str r2, [r4, #0x1c]
	ldr r2, [r4, #0x20]
	orr r2, r2, #0x20
	str r2, [r4, #0x20]
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailRingLoss__Create(Player *player)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	ldr r1, =TripleGrindRail__Singleton
	mov r8, r0
	ldr r0, [r1, #0]
	ldr r4, =0x00000488
	cmp r0, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r0, #0xe04]
	tst r0, #1
	addne sp, sp, #0x18
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #0x1800
	mov r2, #0
	str r0, [sp]
	mov r5, #2
	str r5, [sp, #4]
	add r5, r4, #0x1e4
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r5
	bl GetTaskWork_
	add r2, r4, #0x1e4
	mov r1, #0
	mov r5, r0
	bl MI_CpuFill8
	mov r0, #3
	strh r0, [r5]
	bl GetStageRingScale
	str r0, [r5, #0x38]
	str r0, [r5, #0x3c]
	str r0, [r5, #0x40]
	add r0, r8, #0x600
	ldrsh r10, [r0, #0x7e]
	mov r1, #0
	add lr, r5, #0x16c
	strh r1, [r0, #0x7e]
	cmp r10, #0x40
	movgt r10, #0x40
	add ip, sp, #0xc
	str r10, [r5, #0x168]
	add r0, r8, #0x44
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r0, =ringManagerWork
	ldrb r1, [r8, #0x5d1]
	ldr r0, [r0, #0]
	cmp r10, #0
	add r0, r0, r1
	ldrb r1, [r0, #0x364]
	add r0, r5, #0x6c
	add r8, r0, #0x400
	add r9, lr, #0x400
	add r4, r4, r1, lsl #8
	mov r11, #0
	ble _02163F14
	ldr r3, =FX_SinCosTable_
_02163E88:
	ldmia ip, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	cmp r4, #0
	blt _02163EF4
	mov r1, r4, lsl #0x18
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	mov r2, r1, lsl #1
	add r1, r3, r1, lsl #1
	ldrsh r6, [r3, r2]
	ldrsh r2, [r1, #2]
	mov r0, r4, asr #8
	cmp r0, #6
	add r1, r4, #0x10
	rsbge r0, r0, #9
	mov r4, r6, lsl #4
	mov r4, r4, asr r0
	mov r2, r2, lsl #4
	mov r0, r2, asr r0
	sub r6, r4, r4, asr #2
	sub r7, r0, r0, asr #2
	orr r4, r1, #0x80
_02163EF4:
	str r6, [r8], #4
	add r11, r11, #1
	cmp r11, r10
	str r7, [r9], #4
	rsb r4, r4, #0
	rsb r6, r6, #0
	add lr, lr, #0xc
	blt _02163E88
_02163F14:
	ldr r0, [r5, #0x18]
	ldr r1, =TripleGrindRailRingLoss__Draw
	orr r0, r0, #0x10
	str r0, [r5, #0x18]
	ldr r2, [r5, #0x1c]
	ldr r0, =TripleGrindRailRingLoss__State_Active
	orr r2, r2, #0x2100
	str r2, [r5, #0x1c]
	str r1, [r5, #0xfc]
	str r0, [r5, #0xf4]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailSpring__State_Active(TripleGrindRailSpring *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	add r1, r0, #0x100
	ldrh r1, [r1, #0x74]
	cmp r1, #1
	ldmneia sp!, {r3, pc}
	ldr r1, [r0, #0x20]
	tst r1, #8
	ldmeqia sp!, {r3, pc}
	ldr r2, [r0, #0x230]
	mov r1, #0
	bic r2, r2, #0x100
	str r2, [r0, #0x230]
	bl StageTask__SetAnimation
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailSpring__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	cmp r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [r4, #0x44]
	mov r0, r4
	str r1, [r5, #0x44]
	ldr r2, [r4, #0x48]
	mov r1, #1
	str r2, [r5, #0x48]
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x340]
	ldrsb ip, [r0, #6]
	cmp ip, #0x30
	movlt ip, #0x30
	blt _02163FFC
	cmp ip, #0x40
	movgt ip, #0x40
_02163FFC:
	ldr r1, =0xB60B60B7
	mov r3, ip, lsl #0xf
	smull r0, r2, r1, r3
	add r2, r2, ip, lsl #15
	mov ip, r3, lsr #0x1f
	ldr r3, =0xFFFEEEF0
	mov r0, r5
	mov r1, r4
	add r2, ip, r2, asr #6
	bl Player__Action_TripleGrindRailStartSpring
	add r0, r5, #0x500
	mov r1, #0x5a
	ldr r2, =0x00000611
	strh r1, [r0, #0xfa]
	mov r0, r5
	mov r1, r4
	str r2, [r5, #0xd8]
	bl Player__Action_AllowTrickCombos
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRail__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, #0
	ldr r5, =TripleGrindRail__Singleton
	mov r4, r0
	mov r7, r6
_02164068:
	ldr r0, [r5, #0]
	add r0, r0, #0x4e0
	add r0, r0, r7
	bl AnimatorSprite3D__Release
	add r6, r6, #1
	cmp r6, #7
	add r7, r7, #0x104
	blt _02164068
	ldr r0, =TripleGrindRail__Singleton
	ldr r0, [r0, #0]
	add r0, r0, #0x3fc
	add r0, r0, #0x800
	bl AnimatorSprite3D__Release
	ldr r0, =TripleGrindRail__Singleton
	ldr r0, [r0, #0]
	add r0, r0, #0xd00
	bl AnimatorSprite3D__Release
	ldr r2, =TripleGrindRail__Singleton
	mov r3, #0
	ldr r1, =g_obj
	mov r0, #0x1000
	str r3, [r2]
	str r3, [r1, #0x14]
	bl SetStageRingScale
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRail__State_21640DC(TripleGrindRail *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =0x00141BB2
	mov r5, r0
	str r1, [r5, #0x50]
	ldrh r0, [r5, #0x30]
	cmp r0, #0
	beq _02164164
	sub r0, r0, #0x350
	strh r0, [r5, #0x30]
	ldrh r0, [r5, #0x30]
	cmp r0, #0
	beq _02164114
	cmp r0, #0x8000
	bls _0216411C
_02164114:
	mov r0, #0
	strh r0, [r5, #0x30]
_0216411C:
	add r0, r5, #0x388
	bl MTX_Identity33_
	ldrh r1, [r5, #0x30]
	ldr r3, =FX_SinCosTable_
	add r0, r5, #0x388
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
_02164164:
	ldr r4, [r5, #0x35c]
	ldr r0, [r4, #0x6d8]
	cmp r0, r5
	bne _02164180
	ldr r0, [r4, #0x5d8]
	tst r0, #0x400
	beq _0216419C
_02164180:
	mov r1, #0
	ldr r0, =TripleGrindRail__State_216497C
	str r1, [r5, #0x35c]
	str r0, [r5, #0xf4]
	mov r0, #0x258
	str r0, [r5, #0x28]
	ldmia sp!, {r3, r4, r5, pc}
_0216419C:
	ldr r0, [r4, #0x1c]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl Player__Gimmick_TripleGrindRail
	ldr r1, [r4, #0x5dc]
	ldr r0, =TripleGrindRail__State_21641E0
	orr r1, r1, #0x600
	str r1, [r4, #0x5dc]
	str r0, [r5, #0xf4]
	mov r0, #0x400
	str r0, [r5, #0xe0c]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRail__State_21641E0(TripleGrindRail *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x50
	ldr r1, =0x00141BB2
	mov r6, r0
	str r1, [r6, #0x50]
	ldr r4, [r6, #0x35c]
	ldr r0, [r4, #0x6d8]
	cmp r0, r6
	bne _02164210
	ldr r0, [r4, #0x5d8]
	tst r0, #0x400
	beq _02164230
_02164210:
	mov r1, #0
	ldr r0, =TripleGrindRail__State_216497C
	str r1, [r6, #0x35c]
	str r0, [r6, #0xf4]
	mov r0, #0x258
	add sp, sp, #0x50
	str r0, [r6, #0x28]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02164230:
	ldr r2, [r6, #0x44]
	ldr r1, [r6, #0xe08]
	cmp r1, r2
	bgt _02164280
	mov r0, r4
	bl Player__Func_201DD24
	ldr r1, [r4, #0x5dc]
	ldr r0, =g_obj
	bic r1, r1, #0x600
	str r1, [r4, #0x5dc]
	mov r1, #0
	str r1, [r0, #0x14]
	str r1, [r6, #0x47c]
	ldr r1, [r6, #0xe04]
	ldr r0, =TripleGrindRail__State_216492C
	orr r1, r1, #2
	str r1, [r6, #0xe04]
	add sp, sp, #0x50
	str r0, [r6, #0xf4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02164280:
	sub r0, r1, #0x9600
	cmp r0, r2
	bgt _021642A8
	ldr r0, [r6, #0xe04]
	orr r0, r0, #1
	str r0, [r6, #0xe04]
	ldr r0, [r4, #0x5d8]
	orr r0, r0, #0x200000
	str r0, [r4, #0x5d8]
	b _021642C0
_021642A8:
	ldr r0, =0xFFFE0200
	add r0, r1, r0
	cmp r0, r2
	ldrle r0, [r6, #0xe04]
	orrle r0, r0, #1
	strle r0, [r6, #0xe04]
_021642C0:
	ldr r0, [r6, #0xe0c]
	add r0, r0, #0x10
	str r0, [r6, #0xe0c]
	cmp r0, #0x1000
	movgt r0, #0x1000
	strgt r0, [r6, #0xe0c]
	ldr r1, [r6, #0xe0c]
	mov r0, #0x600
	mul r2, r1, r0
	mov r0, r2, asr #0xb
	add r0, r2, r0, lsr #20
	ldr r1, =g_obj
	mov r0, r0, asr #0xc
	str r0, [r1, #0x14]
	ldr r0, =mapCamera
	ldr r2, [r6, #0xe0c]
	ldr r0, [r0, #0xe0]
	mov r1, r2, lsl #1
	tst r0, #1
	add r5, r1, r2, lsl #2
	beq _02164330
	mov r1, r5
	mov r0, #0
	bl MapFarSys__AdvanceScrollSpeed
	mov r1, r5
	mov r0, #1
	bl MapFarSys__AdvanceScrollSpeed
	b _0216433C
_02164330:
	ldrb r0, [r4, #0x5d3]
	mov r1, r5
	bl MapFarSys__AdvanceScrollSpeed
_0216433C:
	ldr r0, [r6, #0xe0c]
	ldr r2, =0x88888889
	mov r1, r0, lsl #0xc
	mov r0, r1, asr #0xb
	add r0, r1, r0, lsr #20
	mov r0, r0, asr #0xc
	mov r7, r0, lsl #2
	mov r3, r7, lsl #0xe
	smull r0, r5, r2, r3
	mov r0, r3, lsr #0x1f
	add r5, r5, r7, lsl #14
	mov r1, #0
	add r5, r0, r5, asr #5
	add r4, r6, #0x3fc
	mov r2, r1
	str r7, [r6, #0x47c]
	mov r5, r5, asr #0xe
	add r3, r6, #0xe00
	add r0, r4, #0x800
	strh r5, [r3, #0x14]
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, =TripleGrindRail__stru_21884D4
	add r4, r6, #0x218
	mov r5, #0x1100
	str r5, [sp, #0x1c]
	add r3, sp, #0x38
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0x190000
	str r0, [sp, #0x14]
	add r0, r6, #0x4e0
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	ldr r7, =TripleGrindRail__Singleton
	rsb r0, r0, #0
	add r4, r4, #0xc00
	mvn r11, #0
	mov r5, #0
	str r0, [sp, #0x14]
_021643D8:
	ldr r0, [r4, #4]
	cmp r0, #0x100000
	moveq r11, r5
	beq _02164514
	ldr r0, [r7, #0]
	ldrh r1, [r4, #8]
	add r0, r0, #0xe00
	ldrh r0, [r0, #0x14]
	add r0, r0, r0, asr #2
	sub r0, r1, r0
	strh r0, [r4, #8]
	ldrh r1, [r4, #8]
	ldr r0, =0x00006AAC
	cmp r1, r0
	bls _02164424
	ldr r0, [r4, #4]
	ldr r1, [sp, #0x14]
	cmp r0, r1
	bge _02164434
_02164424:
	mov r0, #0x100000
	str r0, [r4, #4]
	mov r11, r5
	b _02164514
_02164434:
	ldr r2, [r7, #0]
	add r1, sp, #0x44
	add r2, r2, #0xe00
	ldrh r8, [r2, #0x14]
	mov r2, #0
	add r3, sp, #0x38
	mov r8, r8, lsl #4
	rsb r8, r8, #0
	add r0, r0, r8
	str r0, [r4, #4]
	ldrh r0, [r4, #0xa]
	ldrh r10, [r4, #8]
	ldr ip, [r4]
	add r8, r0, r0, lsl #6
	ldr r0, [sp, #0x10]
	mov r10, r10, asr #4
	add r0, r0, r8, lsl #2
	ldr r8, =FX_SinCosTable_
	ldr r9, [r7, #0]
	add r8, r8, r10, lsl #2
	ldrsh r10, [r8, #2]
	ldr r8, [r9, #0x44]
	smull lr, ip, r10, ip
	adds lr, lr, #0x800
	mov r10, r2
	adc r10, ip, r10
	mov ip, lr, lsr #0xc
	orr ip, ip, r10, lsl #20
	add r10, r8, ip
	ldr r8, =0x00141BB2
	add r8, r10, r8
	str r8, [sp, #0x44]
	ldr r8, [r9, #0x48]
	ldr r9, [r4, #4]
	add r8, r9, r8
	str r8, [sp, #0x48]
	ldrh r8, [r4, #8]
	ldr r9, [r4, #0]
	mov r8, r8, asr #4
	mov r10, r8, lsl #2
	ldr r8, =FX_SinCosTable_
	ldrsh r8, [r8, r10]
	smull r10, r9, r8, r9
	adds r10, r10, #0x800
	mov r8, r2
	adc r8, r9, r8
	mov r9, r10, lsr #0xc
	orr r9, r9, r8, lsl #20
	str r9, [sp, #0x4c]
	add r8, sp, #0x1c
	str r8, [sp]
	mov r8, r2
	str r8, [sp, #4]
	str r8, [sp, #8]
	str r8, [sp, #0xc]
	bl StageTask__Draw3DEx
_02164514:
	add r5, r5, #1
	cmp r5, #0x40
	add r4, r4, #0xc
	blt _021643D8
	ldr r0, [r6, #0xe04]
	tst r0, #3
	bne _021645A4
	add r0, r6, #0xe00
	ldrsh r1, [r0, #0x16]
	sub r1, r1, #1
	strh r1, [r0, #0x16]
	ldrsh r0, [r0, #0x16]
	cmp r0, #0
	bgt _021645A4
	mvn r0, #0
	cmp r11, r0
	beq _021645A4
	ldr r1, =TripleGrindRail__Singleton
	add r0, r6, #0x218
	ldr r3, [r1, #0]
	add r2, r0, #0xc00
	add r0, r3, #0xe00
	ldrh r3, [r0, #0x14]
	mov r1, #0xc
	mla r0, r11, r1, r2
	rsb r4, r3, #0x100
	bl TripleGrindRail__CreateLeafParticle
	mov r0, r4, asr #5
	add r1, r0, r4, asr #3
	cmp r1, #3
	movlt r1, #3
	blt _0216459C
	cmp r1, #0x30
	movgt r1, #0x30
_0216459C:
	add r0, r6, #0xe00
	strh r1, [r0, #0x16]
_021645A4:
	ldr r0, =TripleGrindRail__stru_21884E0
	add r3, sp, #0x20
	ldmia r0, {r0, r1, r2}
	mov r5, #0x1100
	add r4, r6, #0x11c
	str r5, [sp, #0x18]
	add r5, r4, #0x1000
	stmia r3, {r0, r1, r2}
	ldr r4, =FX_SinCosTable_
	mvn r8, #0
	mov r7, #0
	add r9, r6, #0x2f8
_021645D4:
	ldr r0, [r5, #4]
	cmp r0, #0x100000
	moveq r8, r7
	beq _021646D4
	ldr r0, =TripleGrindRail__Singleton
	ldrh r1, [r5, #8]
	ldr r0, [r0, #0]
	add r0, r0, #0xe00
	ldrh r0, [r0, #0x14]
	sub r0, r1, r0
	strh r0, [r5, #8]
	ldrh r1, [r5, #8]
	ldr r0, =0x00006AAC
	cmp r1, r0
	bhi _02164620
	mov r0, #0x100000
	str r0, [r5, #4]
	mov r8, r7
	b _021646D4
_02164620:
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	add r0, r4, r0, lsl #2
	ldrsh r3, [r0, #2]
	ldr r2, [r5, #0]
	ldr r0, =TripleGrindRail__Singleton
	smull r11, r10, r3, r2
	adds r3, r11, #0x800
	ldr r1, [r0, #0]
	adc r2, r10, #0
	mov r3, r3, lsr #0xc
	ldr r0, [r1, #0x44]
	orr r3, r3, r2, lsl #20
	add r2, r0, r3
	ldr r0, =0x00141BB2
	add r3, sp, #0x20
	add r0, r2, r0
	str r0, [sp, #0x2c]
	ldr r1, [r1, #0x48]
	ldr r2, [r5, #4]
	add r0, r9, #0x800
	add r1, r2, r1
	str r1, [sp, #0x30]
	ldrh r2, [r5, #8]
	ldr r11, [r5, #0]
	add r1, sp, #0x2c
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r10, [r4, r2]
	mov r2, #0
	smull ip, r11, r10, r11
	adds r10, ip, #0x800
	mov ip, r2
	adc r11, r11, ip
	mov r10, r10, lsr #0xc
	orr r10, r10, r11, lsl #20
	str r10, [sp, #0x34]
	add r10, sp, #0x18
	str r10, [sp]
	mov r10, r2
	str r10, [sp, #4]
	str r10, [sp, #8]
	str r10, [sp, #0xc]
	bl StageTask__Draw3DEx
_021646D4:
	add r7, r7, #1
	cmp r7, #8
	add r5, r5, #0xc
	blt _021645D4
	ldr r0, [r6, #0xe04]
	tst r0, #3
	addne sp, sp, #0x50
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r6, #0x1100
	ldrsh r1, [r0, #0x18]
	sub r1, r1, #1
	strh r1, [r0, #0x18]
	ldrsh r0, [r0, #0x18]
	cmp r0, #0
	addgt sp, sp, #0x50
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mvn r0, #0
	cmp r8, r0
	addeq sp, sp, #0x50
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, =TripleGrindRail__Singleton
	add r0, r6, #0x11c
	ldr r3, [r1, #0]
	add r2, r0, #0x1000
	add r0, r3, #0xe00
	ldrh r3, [r0, #0x14]
	mov r1, #0xc
	mla r0, r8, r1, r2
	rsb r4, r3, #0x100
	bl TripleGrindRail__CreateMushroomParticle
	cmp r4, #0x14
	movlt r4, #0x14
	blt _02164760
	cmp r4, #0xa5
	movgt r4, #0xa5
_02164760:
	ldr r3, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r5, [r3, #0]
	ldr r1, =0x3C6EF35F
	add r2, r6, #0x1100
	mla r1, r5, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	str r1, [r3]
	add r0, r0, r4
	strh r0, [r2, #0x18]
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRail__CreateLeafParticle(TripleGrindRailParticle *particle)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	ldr r5, =TripleGrindRail__word_21884EC
	add r4, sp, #0
	mov r3, #4
_021647EC:
	ldrh r2, [r5, #0]
	ldrh r1, [r5, #2]
	add r5, r5, #4
	strh r2, [r4]
	strh r1, [r4, #2]
	add r4, r4, #4
	subs r3, r3, #1
	bne _021647EC
	ldr lr, =_mt_math_rand
	ldr r3, =0x00196225
	ldr r1, [lr]
	ldr ip, =0x3C6EF35F
	ldr r2, =0x000001FF
	mla r4, r1, r3, ip
	mov r1, r4, lsr #0x10
	mov r1, r1, lsl #0x10
	and r1, r2, r1, lsr #16
	rsb r1, r1, #0x80
	str r4, [lr]
	mov r1, r1, lsl #0xc
	str r1, [r0, #4]
	ldr r1, [lr]
	ldr r2, =0x000034CC
	mla r5, r1, r3, ip
	mov r1, r5, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r4, r1, #0x3f
	ldr r1, =0x00141BB2
	sub r4, r4, #0x1f
	mla r2, r4, r2, r1
	str r5, [lr]
	str r2, [r0]
	ldr r1, =0x0000D554
	add r2, sp, #0
	strh r1, [r0, #8]
	ldr r1, [lr]
	mla r3, r1, r3, ip
	mov r1, r3, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x1d
	mov r1, r1, lsr #0x1c
	ldrh r1, [r2, r1]
	str r3, [lr]
	strh r1, [r0, #0xa]
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRail__CreateMushroomParticle(TripleGrindRailParticle *particle)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r3, =_mt_math_rand
	ldr r1, =0x00196225
	ldr lr, [r3]
	ldr r2, =0x3C6EF35F
	ldr ip, =0x001CF9F6
	mla r2, lr, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0x1f
	add r1, r1, #8
	str r2, [r3]
	mov r1, r1, lsl #0xc
	str r1, [r0, #4]
	ldr r1, =0x0000D8E2
	str ip, [r0]
	strh r1, [r0, #8]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRail__State_216492C(TripleGrindRail *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, [r0, #0x35c]
	ldr r1, [r1, #0x2c]
	cmp r1, #0
	strne r1, [r0, #0xe10]
	ldr r1, =0x00141BB2
	str r1, [r0, #0x50]
	ldr r1, [r0, #0xe10]
	str r1, [r0, #0x58]
	ldr r1, [r0, #0x35c]
	ldr r1, [r1, #0x28]
	cmp r1, #0
	bxeq lr
	ldr r1, =TripleGrindRail__State_216497C
	str r1, [r0, #0xf4]
	ldr r1, [r0, #0x35c]
	ldr r1, [r1, #0x28]
	str r1, [r0, #0x28]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRail__State_216497C(TripleGrindRail *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, [r0, #0x28]
	subs r1, r1, #1
	str r1, [r0, #0x28]
	ldreq r1, [r0, #0x18]
	orreq r1, r1, #4
	streq r1, [r0, #0x18]
	ldr r1, =0x00141BB2
	str r1, [r0, #0x50]
	ldr r1, [r0, #0xe10]
	str r1, [r0, #0x58]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRail__OnDefend_StartTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r4, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r4, #0
	cmpne r0, #0
	ldmeqia sp!, {r4, pc}
	ldrh r1, [r0, #0]
	cmp r1, #1
	ldmneia sp!, {r4, pc}
	ldr r2, [r0, #0xf4]
	ldr r1, =Player__State_TripleGrindRailStartSpring
	cmp r2, r1
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0xe04]
	mov r1, r4
	bic r2, r2, #1
	str r2, [r4, #0xe04]
	ldr r2, [r4, #0x230]
	bic r2, r2, #4
	str r2, [r4, #0x230]
	str r0, [r4, #0x35c]
	bl Player__Action_TripleGrindRailEndSpring
	mov r0, #0x2000
	bl SetStageRingScale
	ldr r1, =TripleGrindRail__State_21640DC
	mov r0, #0x3000
	str r1, [r4, #0xf4]
	strh r0, [r4, #0x30]
	ldr r1, [r4, #0x20]
	mov r0, #0
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	str r0, [r4, #0x47c]
	str r4, [r4, #0x2d8]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailEntity__State_Inactive(TripleGrindRailEntity *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =TripleGrindRail__Singleton
	mov r4, r0
	ldr r2, [r1, #0]
	cmp r2, #0
	beq _02164A64
	ldr r1, [r2, #0xe04]
	tst r1, #3
	beq _02164A74
_02164A64:
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
_02164A74:
	ldr r1, [r2, #0x44]
	ldr r2, [r4, #0x44]
	add r1, r1, #0xa0000
	cmp r2, r1
	ldmgtia sp!, {r4, pc}
	ldr r2, =0x0000CE38
	add r1, r4, #0x400
	strh r2, [r1, #0x7c]
	ldr r2, [r4, #0x20]
	ldr r1, =TripleGrindRailEntity__State_Active
	bic r2, r2, #0x20
	str r2, [r4, #0x20]
	str r1, [r4, #0xf4]
	bl TripleGrindRailEntity__State_Active
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x7b
	ldreq r0, =TripleGrindRailEntity__Draw
	streq r0, [r4, #0xfc]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailEntity__State_Active(TripleGrindRailEntity *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r3, =TripleGrindRail__Singleton
	ldr r4, [r3, #0]
	cmp r4, #0
	ldrne r1, =g_obj
	ldrne r1, [r1, #0x14]
	cmpne r1, #0
	beq _02164B00
	ldr r1, [r4, #0xe04]
	tst r1, #2
	beq _02164B10
_02164B00:
	ldr r1, [r0, #0x18]
	orr r1, r1, #4
	str r1, [r0, #0x18]
	ldmia sp!, {r4, pc}
_02164B10:
	add r2, r0, #0x400
	add r1, r4, #0xe00
	ldrh ip, [r2, #0x7c]
	ldrh r4, [r1, #0x14]
	ldr r1, =0x000071C8
	sub r4, ip, r4
	strh r4, [r2, #0x7c]
	ldrh r2, [r2, #0x7c]
	cmp r2, r1
	bhi _02164B48
	ldr r1, [r0, #0x18]
	orr r1, r1, #4
	str r1, [r0, #0x18]
	ldmia sp!, {r4, pc}
_02164B48:
	ldr r1, [r0, #0x340]
	ldrh r1, [r1, #2]
	cmp r1, #0x7a
	bne _02164B68
	ldr r1, [r3, #0]
	ldr r1, [r1, #0x47c]
	mov r1, r1, asr #1
	str r1, [r0, #0x42c]
_02164B68:
	add r2, r0, #0x400
	ldrh r3, [r2, #0x7c]
	ldr r1, =TripleGrindRail__Singleton
	ldr lr, =FX_SinCosTable_
	mov r3, r3, asr #4
	mov r3, r3, lsl #1
	add r3, r3, #1
	mov r3, r3, lsl #1
	ldrsh ip, [lr, r3]
	ldr r3, [r0, #0x478]
	ldr r4, [r1, #0]
	smull r3, r1, ip, r3
	adds r3, r3, #0x800
	adc r1, r1, #0
	mov r3, r3, lsr #0xc
	ldr ip, [r4, #0x44]
	orr r3, r3, r1, lsl #20
	ldr r1, =0x00141BB2
	add r3, ip, r3
	add r1, r3, r1
	str r1, [r0, #0x44]
	ldrh r2, [r2, #0x7c]
	ldr r1, [r0, #0x478]
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r2, [lr, r2]
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x4c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailEntity__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x354]
	mov r2, #0
	tst r0, #1
	add r0, sp, #0x10
	beq _02164C70
	mov r1, #0x100
	str r1, [sp, #0x10]
	str r0, [sp]
	str r2, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	add r0, r4, #0x364
	add r1, r4, #0x44
	add r3, r4, #0x38
	bl StageTask__Draw3DEx
	ldr r0, [sp, #0x10]
	tst r0, #0x40000000
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x18]
	add sp, sp, #0x14
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, pc}
_02164C70:
	ldr r1, =0x00001104
	add r3, r4, #0x38
	str r1, [sp, #0x10]
	str r0, [sp]
	str r2, [sp, #4]
	str r2, [sp, #8]
	ldr r0, =TripleGrindRail__Singleton
	str r2, [sp, #0xc]
	ldr r0, [r0, #0]
	add r1, r4, #0x44
	add r0, r0, #0x3fc
	add r0, r0, #0x800
	bl StageTask__Draw3DEx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailEntity__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r4, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r4, #0
	ldmeqia sp!, {r4, pc}
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldrh r1, [r0, #0]
	cmp r1, #1
	ldreqb r1, [r0, #0x5d1]
	cmpeq r1, #0
	ldmneia sp!, {r4, pc}
	mov r1, #1
	bl Player__GiveRings
	ldr r1, [r4, #0x354]
	mov r0, #0
	orr r1, r1, #1
	orr r1, r1, #0x10000
	str r1, [r4, #0x354]
	str r0, [r4, #0x234]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailRingLoss__State_Active(TripleGrindRailRingLoss *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r1, =TripleGrindRail__Singleton
	mov r10, r0
	ldr r1, [r1, #0]
	ldr r6, [r10, #0x168]
	cmp r1, #0
	ldrne r0, =g_obj
	mov r11, #1
	ldrne r0, [r0, #0x14]
	cmpne r0, #0
	beq _02164D44
	ldr r0, [r1, #0xe04]
	tst r0, #2
	beq _02164D58
_02164D44:
	ldr r0, [r10, #0x18]
	add sp, sp, #0xc
	orr r0, r0, #4
	str r0, [r10, #0x18]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02164D58:
	add r7, r10, #0x16c
	add r0, r10, #0x6c
	cmp r6, #0
	add r8, r0, #0x400
	add r9, r7, #0x400
	mov r5, #0
	ble _02164DEC
	mov r4, r5
_02164D78:
	ldr r1, [r7, #0]
	ldr r0, [r8, #0]
	mov r2, #0x20
	add r0, r1, r0
	str r0, [r7]
	ldr r0, =0x02118D5C
	ldr r1, [r9, #0]
	ldrsh r0, [r0, #0]
	ldr r3, [r7, #4]
	add r1, r1, r0
	add r1, r3, r1
	str r1, [r7, #4]
	ldr r1, [r9, #0]
	mov r3, r4
	add r0, r1, r0
	str r0, [r9]
	str r4, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	ldmia r7, {r0, r1}
	bl StageTask__ViewOutCheck
	cmp r0, #0
	add r5, r5, #1
	moveq r11, #0
	cmp r5, r6
	add r7, r7, #0xc
	add r8, r8, #4
	add r9, r9, #4
	blt _02164D78
_02164DEC:
	cmp r11, #0
	ldrne r0, [r10, #0x18]
	orrne r0, r0, #4
	strne r0, [r10, #0x18]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailRingLoss__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x20
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x38
	add r7, sp, #0x14
	ldmia r0, {r0, r1, r2}
	ldr r3, =0x00001104
	stmia r7, {r0, r1, r2}
	str r3, [sp, #0x10]
	ldr r9, [r4, #0x168]
	mov r8, #0
	cmp r9, #0
	addle sp, sp, #0x20
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r10, r4, #0x16c
	ldr r4, =TripleGrindRail__Singleton
	add r6, sp, #0x10
	mov r5, r8
_02164E5C:
	str r6, [sp]
	str r5, [sp, #4]
	str r5, [sp, #8]
	str r5, [sp, #0xc]
	ldr r0, [r4, #0]
	mov r1, r10
	add r0, r0, #0x3fc
	mov r2, r5
	mov r3, r7
	add r0, r0, #0x800
	bl StageTask__Draw3DEx
	add r8, r8, #1
	cmp r8, r9
	add r10, r10, #0xc
	blt _02164E5C
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}