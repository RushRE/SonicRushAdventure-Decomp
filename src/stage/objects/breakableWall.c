#include <stage/objects/breakableWall.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/obj.h>
#include <game/object/objectManager.h>
#include <game/graphics/screenShake.h>
#include <game/graphics/oamSystem.h>

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void *aActAcGmkWallBr;

BreakableWall *BreakableWall__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), BreakableWall);
    if (task == HeapNull)
        return NULL;

    BreakableWall *work = TaskGetWork(task, BreakableWall);
    TaskInitWork8(work);

    u16 anim;
    if (mapObject->id == MAPOBJECT_119)
        anim = mapObject->flags & 3;
    else
        anim = 3;

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_wall_braek.bac", GetObjectDataWork(OBJDATAWORK_61), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 6);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, Sprite__GetSpriteSize2FromAnim(work->gameWork.animator.fileWork->fileData, anim),
                               GetObjectSpriteRef(2 * anim + OBJDATAWORK_62));
    StageTask__SetAnimation(&work->gameWork.objWork, anim);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);

    if (mapObject->id == MAPOBJECT_119)
    {
        ObjRect__SetDefenceStat(work->gameWork.colliders, ~1, 0);
        work->gameWork.colliders[0].onDefend = BreakableWall__OnDefend_2160518;
        work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;
    }
    else
    {
        ObjRect__SetDefenceStat(work->gameWork.colliders, ~2, 0);
        work->gameWork.colliders[0].onDefend = BreakableWall__OnDefend_21608E0;
        work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

        ObjRect__SetAttackStat(&work->gameWork.colliders[1], 0, 0);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[1], ~2, 0);
        work->gameWork.colliders[1].onDefend = BreakableWall__OnDefend_2160A88;
        work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_400;
    }

    switch (anim)
    {
        case 0:
        case 1:
        case 2:
            work->gameWork.objWork.collisionObj           = 0;
            work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
            work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
            work->gameWork.collisionObject.work.width     = 32;
            work->gameWork.collisionObject.work.height    = 64;
            break;

        case 3:
            work->gameWork.objWork.collisionObj           = 0;
            work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
            work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
            work->gameWork.collisionObject.work.width     = 64;
            work->gameWork.collisionObject.work.height    = 32;
            break;
    }

    if (Player__UseUpsideDownGravity(work->gameWork.objWork.position.x, work->gameWork.objWork.position.y))
        work->gameWork.objWork.fallDir = FLOAT_DEG_TO_IDX(180.0);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    return work;
}

NONMATCH_FUNC void BreakableWall__OnDefend_2160518(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	mov r4, #0
	mov r6, r4
	cmp r5, #0
	ldr r7, [r1, #0x1c]
	beq _02160564
	ldrh r2, [r5, #0]
	cmp r2, #1
	moveq r4, r5
	beq _02160564
	cmp r2, #3
	bne _02160564
	ldr r3, [r5, #0x340]
	ldr r2, =0x0000014A
	ldrh r3, [r3, #2]
	cmp r3, r2
	moveq r6, r5
_02160564:
	cmp r4, #0
	beq _021607A0
	ldr r3, [r7, #0x340]
	ldr r5, [r4, #0xc8]
	ldrh r3, [r3, #4]
	ldr r8, [r4, #0x98]
	cmp r5, #0
	rsblt r2, r5, #0
	movge r2, r5
	cmp r8, #0
	and r6, r3, #3
	rsblt r3, r8, #0
	movge r3, r8
	cmp r2, r3
	bge _021605B0
	mov r5, r8
	cmp r8, #0
	rsblt r8, r8, #0
	mov r2, r8
_021605B0:
	cmp r6, #0
	bne _021605E0
	ldr r3, [r4, #0x648]
	cmp r2, r3
	bgt _02160608
	ldr r8, [r7, #0x44]
	ldr r3, [r4, #0x44]
	add r8, r8, #0x10000
	subs r3, r8, r3
	rsbmi r3, r3, #0
	cmp r3, #0x20000
	blt _02160608
_021605E0:
	cmp r6, #1
	bne _021605F4
	ldr r3, [r4, #0x648]
	cmp r2, r3
	bgt _02160608
_021605F4:
	cmp r6, #2
	bne _02160734
	ldr r2, [r4, #0x5d8]
	tst r2, #0x80
	beq _02160734
_02160608:
	mov r0, #3
	bl ShakeScreen
	ldr r1, =BreakableWall__State_Broken
	ldr r0, =BreakableWall__Draw_Broken
	str r1, [r7, #0xf4]
	str r0, [r7, #0xfc]
	ldr r0, [r7, #0x18]
	mov r6, #0
	orr r0, r0, #2
	str r0, [r7, #0x18]
	str r6, [r7, #0x2d8]
	ldr r0, [r7, #0x1a4]
	mov r2, r5, asr #1
	bic r0, r0, #0x800
	str r0, [r7, #0x1a4]
	ldr r0, [r7, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x77
	bne _02160694
	cmp r2, #0
	subgt r3, r6, #0x100
	mov r5, #0
	movle r3, #0x100
	mov r6, r5
	sub r8, r5, #0x5000
_0216066C:
	add r1, r2, r6
	add r0, r7, r5, lsl #3
	str r1, [r0, #0x3e4]
	add r5, r5, #1
	str r8, [r0, #0x3e8]
	cmp r5, #0x10
	add r6, r6, r3
	add r8, r8, #0x800
	blt _0216066C
	b _02160708
_02160694:
	mov ip, #0x1000
	rsb ip, ip, #0
	mov r1, r6
	mov r3, r6
	sub r2, r6, #0x5000
	sub r5, r6, #0x6000
	add lr, ip, #0x800
_021606B0:
	sub r8, ip, r1
	add r0, r7, r6, lsl #3
	str r8, [r0, #0x3e4]
	str r2, [r0, #0x3e8]
	ldr r9, [r0, #0x3e4]
	sub r8, lr, r3
	rsb r9, r9, #0
	str r9, [r0, #0x3ec]
	str r2, [r0, #0x3f0]
	str r8, [r0, #0x3f4]
	str r5, [r0, #0x3f8]
	ldr r8, [r0, #0x3f4]
	add r6, r6, #4
	rsb r8, r8, #0
	str r8, [r0, #0x3fc]
	str r5, [r0, #0x400]
	cmp r6, #0x10
	add r1, r1, #0x400
	add r2, r2, #0x1000
	add r3, r3, #0x200
	add r5, r5, #0x1000
	blt _021606B0
_02160708:
	mov r5, #0x42
	sub r1, r5, #0x43
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlaySfxEx
	mov r0, #0x4000
	add sp, sp, #8
	str r0, [r4, #8]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02160734:
	bl ObjRect__FuncNoHit
	cmp r6, #2
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r4, #0x118]
	cmp r0, r7
	ldr r0, [r7, #0x354]
	bne _02160790
	tst r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r4, #0x36
	sub r1, r4, #0x37
	mov r0, #0
	stmia sp, {r0, r4}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r7, #0x354]
	add sp, sp, #8
	orr r0, r0, #1
	str r0, [r7, #0x354]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02160790:
	bic r0, r0, #1
	add sp, sp, #8
	str r0, [r7, #0x354]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_021607A0:
	cmp r6, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, #3
	ldr r4, [r6, #0x98]
	bl ShakeScreen
	ldr r1, =BreakableWall__State_Broken
	ldr r0, =BreakableWall__Draw_Broken
	str r1, [r7, #0xf4]
	str r0, [r7, #0xfc]
	ldr r0, [r7, #0x18]
	mov r5, #0
	orr r0, r0, #2
	str r0, [r7, #0x18]
	str r5, [r7, #0x2d8]
	ldr r0, [r7, #0x1a4]
	mov r4, r4, asr #1
	bic r0, r0, #0x800
	str r0, [r7, #0x1a4]
	ldr r0, [r7, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x77
	bne _0216083C
	cmp r4, #0
	subgt r2, r5, #0x100
	mov r3, #0
	movle r2, #0x100
	mov r5, r3
	sub r6, r3, #0x5000
_02160814:
	add r1, r4, r5
	add r0, r7, r3, lsl #3
	str r1, [r0, #0x3e4]
	add r3, r3, #1
	str r6, [r0, #0x3e8]
	cmp r3, #0x10
	add r5, r5, r2
	add r6, r6, #0x800
	blt _02160814
	b _021608B0
_0216083C:
	mov r6, #0x1000
	rsb r6, r6, #0
	mov r1, r5
	mov r3, r5
	sub r2, r5, #0x5000
	sub r4, r5, #0x6000
	add ip, r6, #0x800
_02160858:
	sub r8, r6, r1
	add r0, r7, r5, lsl #3
	str r8, [r0, #0x3e4]
	str r2, [r0, #0x3e8]
	ldr r8, [r0, #0x3e4]
	sub lr, ip, r3
	rsb r8, r8, #0
	str r8, [r0, #0x3ec]
	str r2, [r0, #0x3f0]
	str lr, [r0, #0x3f4]
	str r4, [r0, #0x3f8]
	ldr lr, [r0, #0x3f4]
	add r5, r5, #4
	rsb lr, lr, #0
	str lr, [r0, #0x3fc]
	str r4, [r0, #0x400]
	cmp r5, #0x10
	add r1, r1, #0x400
	add r2, r2, #0x1000
	add r3, r3, #0x200
	add r4, r4, #0x1000
	blt _02160858
_021608B0:
	mov r4, #0x42
	sub r1, r4, #0x43
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void BreakableWall__OnDefend_21608E0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	ldr r3, [r0, #0x1c]
	ldr r6, [r1, #0x1c]
	cmp r3, #0
	mov r4, #0
	beq _02160908
	ldrh r2, [r3, #0]
	cmp r2, #1
	moveq r4, r3
_02160908:
	cmp r4, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r2, [r4, #0xc0]
	cmp r2, #0
	bge _02160A74
	ldr r5, [r4, #0xc8]
	ldr r0, [r4, #0x9c]
	cmp r5, #0
	rsblt r1, r5, #0
	movge r1, r5
	cmp r0, #0
	rsblt r2, r0, #0
	movge r2, r0
	cmp r1, r2
	movlt r5, r0
	mov r0, #3
	bl ShakeScreen
	ldr r1, =BreakableWall__State_Broken
	ldr r0, =BreakableWall__Draw_Broken
	str r1, [r6, #0xf4]
	str r0, [r6, #0xfc]
	ldr r0, [r6, #0x18]
	mov ip, #0
	orr r0, r0, #2
	str r0, [r6, #0x18]
	str ip, [r6, #0x2d8]
	ldr r0, [r6, #0x1a4]
	mov r2, r5, asr #1
	bic r0, r0, #0x800
	str r0, [r6, #0x1a4]
	ldr r0, [r6, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x77
	bne _021609D4
	mov r5, #0
	cmp r2, #0
	subgt r3, ip, #0x100
	movle r3, #0x100
	mov r7, r5
	sub r8, r5, #0x5000
_021609AC:
	add r1, r2, r7
	add r0, r6, r5, lsl #3
	str r1, [r0, #0x3e4]
	add r5, r5, #1
	str r8, [r0, #0x3e8]
	cmp r5, #0x10
	add r7, r7, r3
	add r8, r8, #0x800
	blt _021609AC
	b _02160A48
_021609D4:
	mov lr, #0x1000
	rsb lr, lr, #0
	mov r1, ip
	mov r3, ip
	sub r2, ip, #0x5000
	sub r5, ip, #0x6000
	add r7, lr, #0x800
_021609F0:
	sub r8, lr, r1
	add r0, r6, ip, lsl #3
	str r8, [r0, #0x3e4]
	str r2, [r0, #0x3e8]
	ldr r9, [r0, #0x3e4]
	sub r8, r7, r3
	rsb r9, r9, #0
	str r9, [r0, #0x3ec]
	str r2, [r0, #0x3f0]
	str r8, [r0, #0x3f4]
	str r5, [r0, #0x3f8]
	ldr r8, [r0, #0x3f4]
	add ip, ip, #4
	rsb r8, r8, #0
	str r8, [r0, #0x3fc]
	str r5, [r0, #0x400]
	cmp ip, #0x10
	add r1, r1, #0x400
	add r2, r2, #0x1000
	add r3, r3, #0x200
	add r5, r5, #0x1000
	blt _021609F0
_02160A48:
	mov r5, #0x42
	sub r1, r5, #0x43
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlaySfxEx
	mov r0, #0x4000
	add sp, sp, #8
	str r0, [r4, #8]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02160A74:
	bl ObjRect__FuncNoHit
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void BreakableWall__OnDefend_2160A88(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	ldr r3, [r0, #0x1c]
	ldr r6, [r1, #0x1c]
	cmp r3, #0
	mov r4, #0
	beq _02160AB0
	ldrh r2, [r3, #0]
	cmp r2, #1
	moveq r4, r3
_02160AB0:
	cmp r4, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r2, [r4, #0xc0]
	cmp r2, #0
	ble _02160C1C
	ldr r5, [r4, #0xc8]
	ldr r0, [r4, #0x9c]
	cmp r5, #0
	rsblt r1, r5, #0
	movge r1, r5
	cmp r0, #0
	rsblt r2, r0, #0
	movge r2, r0
	cmp r1, r2
	movlt r5, r0
	mov r0, #3
	bl ShakeScreen
	ldr r1, =BreakableWall__State_Broken
	ldr r0, =BreakableWall__Draw_Broken
	str r1, [r6, #0xf4]
	str r0, [r6, #0xfc]
	ldr r0, [r6, #0x18]
	mov ip, #0
	orr r0, r0, #2
	str r0, [r6, #0x18]
	str ip, [r6, #0x2d8]
	ldr r0, [r6, #0x1a4]
	mov r2, r5, asr #1
	bic r0, r0, #0x800
	str r0, [r6, #0x1a4]
	ldr r0, [r6, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x77
	bne _02160B7C
	mov r5, #0
	cmp r2, #0
	subgt r3, ip, #0x100
	movle r3, #0x100
	mov r7, r5
	sub r8, r5, #0x5000
_02160B54:
	add r1, r2, r7
	add r0, r6, r5, lsl #3
	str r1, [r0, #0x3e4]
	add r5, r5, #1
	str r8, [r0, #0x3e8]
	cmp r5, #0x10
	add r7, r7, r3
	add r8, r8, #0x800
	blt _02160B54
	b _02160BF0
_02160B7C:
	mov lr, #0x1000
	rsb lr, lr, #0
	mov r1, ip
	mov r3, ip
	sub r2, ip, #0x5000
	sub r5, ip, #0x6000
	add r7, lr, #0x800
_02160B98:
	sub r8, lr, r1
	add r0, r6, ip, lsl #3
	str r8, [r0, #0x3e4]
	str r2, [r0, #0x3e8]
	ldr r9, [r0, #0x3e4]
	sub r8, r7, r3
	rsb r9, r9, #0
	str r9, [r0, #0x3ec]
	str r2, [r0, #0x3f0]
	str r8, [r0, #0x3f4]
	str r5, [r0, #0x3f8]
	ldr r8, [r0, #0x3f4]
	add ip, ip, #4
	rsb r8, r8, #0
	str r8, [r0, #0x3fc]
	str r5, [r0, #0x400]
	cmp ip, #0x10
	add r1, r1, #0x400
	add r2, r2, #0x1000
	add r3, r3, #0x200
	add r5, r5, #0x1000
	blt _02160B98
_02160BF0:
	mov r5, #0x42
	sub r1, r5, #0x43
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlaySfxEx
	mov r0, #0x4000
	add sp, sp, #8
	str r0, [r4, #8]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02160C1C:
	bl ObjRect__FuncNoHit
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

void BreakableWall__State_Broken(BreakableWall *work)
{
    fx32 stepUp;
    fx32 stepDown;
    if (work->gameWork.mapObject->id == MAPOBJECT_119)
    {
        stepUp   = FLOAT_TO_FX32(0.1640625);
        stepDown = FLOAT_TO_FX32(0.09375);
    }
    else
    {
        stepUp   = FLOAT_TO_FX32(0.171875);
        stepDown = FLOAT_TO_FX32(0.00390625);
    }

    if (work->gameWork.objWork.fallDir != FLOAT_DEG_TO_IDX(0.0))
        stepUp = -stepUp;

    for (u16 i = 0; i < 16; i++)
    {
        work->blockPos[i].x += work->blockVel[i].x;
        work->blockPos[i].y += work->blockVel[i].y;

        work->blockPos[i].x = MTM_MATH_CLIP(work->blockPos[i].x, -FLOAT_TO_FX32(4095.0), FLOAT_TO_FX32(4095.0));
        work->blockPos[i].y = MTM_MATH_CLIP(work->blockPos[i].y, -FLOAT_TO_FX32(4095.0), FLOAT_TO_FX32(4095.0));

        work->blockVel[i].x = ObjSpdDownSet(work->blockVel[i].x, stepDown);
        work->blockVel[i].y = ObjSpdUpSet(work->blockVel[i].y, stepUp, FLOAT_TO_FX32(48.0));
    }
}

NONMATCH_FUNC void BreakableWall__Draw_Broken(void)
{
    // https://decomp.me/scratch/mL4cp -> 39.67%
#ifdef NON_MATCHING
    BreakableWall *work = TaskGetWorkCurrent(BreakableWall);

    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.animator.ani);

    for (fx32 e = 0; e < GRAPHICS_ENGINE_COUNT; e++)
    {
        Vec2Fx32 *pos = work->blockPos;

        GXOamAttr *sprite = work->gameWork.animator.ani.firstSprite[e];
        s16 spriteX       = work->gameWork.animator.ani.position[e].x;
        s16 spriteY       = work->gameWork.animator.ani.position[e].y;

        for (s32 i = 0; i < 16 && sprite != NULL; i++)
        {
            s16 drawX = spriteX + FX32_FROM_WHOLE(pos->x) + 16 * (i % 2);
            s16 drawY = spriteY + FX32_FROM_WHOLE(pos->y) + 8 * (i / 2);

            s16 x;
            s16 y;
            if (drawX + 16 >= 0 && drawX < HW_LCD_WIDTH && drawY + 8 >= 0 && drawY < HW_LCD_HEIGHT)
            {
                x = FX32_FROM_WHOLE(pos->x) + sprite->x;
                y = FX32_FROM_WHOLE(pos->y) + sprite->y;
            }
            else
            {
                x = 0;
                y = -64;
            }

            sprite->x = x;
            sprite->y = y;

            sprite = OAMSystem__Func_207D624(e, sprite);
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	add r1, r0, #0x168
	str r0, [sp, #4]
	str r1, [sp]
	bl StageTask__Draw2D
	mov r8, #0
_02160D40:
	ldr r0, [sp]
	mov r4, #0
	add r2, r0, r8, lsl #2
	ldr r0, [sp, #4]
	mov r9, #0x200
	add r5, r0, #0x364
	ldr r1, [r2, #0x94]
	ldrsh r6, [r2, #0x68]
	ldrsh r7, [r2, #0x6a]
	rsb r9, r9, #0
	mov r11, r4
	ldr r10, =0x000001FF
	b _02160E60
_02160D74:
	ldr r2, [r5, #0]
	ldr r0, [r5, #4]
	mov ip, r2, asr #0xc
	add lr, r6, r2, asr #12
	mov r3, r4, lsr #0x1f
	rsb r2, r3, r4, lsl #31
	add r2, r3, r2, ror #31
	add r2, lr, r2, lsl #4
	mov r2, r2, lsl #0x10
	mov r3, r2, asr #0x10
	adds r2, r3, #0x10
	mov r2, r0, asr #0xc
	add r0, r7, r0, asr #12
	add lr, r4, r4, lsr #31
	mov lr, lr, asr #1
	add r0, r0, lr, lsl #3
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	bmi _02160DD8
	cmp r3, #0x100
	bge _02160DD8
	adds r3, r0, #8
	bmi _02160DD8
	cmp r0, #0xc0
	blt _02160DE4
_02160DD8:
	mov r2, r11
	mov r0, #0xc0
	b _02160E24
_02160DE4:
	mov r0, ip, lsl #0x10
	mov r3, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r0, r0, asr #0x10
	ldrh r2, [r1, #2]
	ldrh ip, [r1]
	and r2, r2, r10
	mov r2, r2, lsl #0x10
	add r2, r3, r2, asr #16
	and r3, ip, #0xff
	mov r3, r3, lsl #0x10
	add r3, r0, r3, asr #16
	mov r0, r2, lsl #0x10
	mov r2, r0, asr #0x10
	mov r0, r3, lsl #0x10
	mov r0, r0, asr #0x10
_02160E24:
	and r3, r2, r10
	and r2, r0, #0xff
	ldrh ip, [r1, #2]
	mov r0, r8
	and ip, ip, r9
	orr r3, ip, r3
	strh r3, [r1, #2]
	ldrh r3, [r1, #0]
	bic r3, r3, #0xff
	orr r2, r3, r2
	strh r2, [r1]
	bl OAMSystem__Func_207D624
	mov r1, r0
	add r4, r4, #1
	add r5, r5, #8
_02160E60:
	cmp r4, #0x10
	bge _02160E70
	cmp r1, #0
	bne _02160D74
_02160E70:
	add r8, r8, #1
	cmp r8, #2
	blt _02160D40
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}
