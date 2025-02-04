#include <stage/objects/winch.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>

// --------------------
// ENUMS
// --------------------

enum WinchObjectFlags
{
    WINCH_OBJFLAG_NONE,

    WINCH_OBJFLAG_FLIPPED = 1 << 0,
};

enum WinchFlags
{
    WINCH_FLAG_NONE,

    WINCH_FLAG_PLAYER_DETACHED = 1 << 0,
};

enum WinchAnimIDs
{
    WINCH_ANI_WHEEL,
    WINCH_ANI_HOOK,
    WINCH_ANI_LINE,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void Winch_Destructor(Task *task);
static void Winch_State_PlayerAttached(Winch *work);
static void Winch_State_Retract(Winch *work);
static void Winch_Draw(void);
static void Winch_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void *aActAcGmkWinchB;

NONMATCH_FUNC Winch *CreateWinch(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // https://decomp.me/scratch/YwBsC -> 96.48%
#ifdef NON_MATCHING
    Task *task = CreateStageTask(Winch_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_GROUP(2), Winch);
    if (task == HeapNull)
        return NULL;

    Winch *work = TaskGetWork(task, Winch);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_SCALE;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_winch.bac", GetObjectDataWork(OBJDATAWORK_179), gameArchiveStage, 32);
    work->gameWork.animator.ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 51);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);
    StageTask__SetAnimation(&work->gameWork.objWork, WINCH_ANI_WHEEL);

    AnimatorSpriteDS *aniHook = &work->aniHook;
    ObjAction2dBACLoad(aniHook, "/act/ac_gmk_winch.bac", 12, GetObjectDataWork(OBJDATAWORK_179), gameArchiveStage);
    aniHook->work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    u16 palette                = ObjDrawAllocSpritePalette(aniHook->work.fileData, 1, 51);
    aniHook->work.cParam.palette      = palette;
    aniHook->cParam[0].palette = aniHook->cParam[1].palette = palette;
    AnimatorSpriteDS__SetAnimation(aniHook, WINCH_ANI_HOOK);
    StageTask__SetOAMOrder(&aniHook->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniHook->work, SPRITE_PRIORITY_2);

    AnimatorSpriteDS *aniLine = &work->aniLine;
    ObjAction2dBACLoad(aniLine, "/act/ac_gmk_winch.bac", 1, GetObjectDataWork(OBJDATAWORK_179), gameArchiveStage);
    aniLine->work.cParam.palette      = palette;
    aniLine->cParam[0].palette = aniLine->cParam[1].palette = aniLine->work.cParam.palette;
    aniLine->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    AnimatorSpriteDS__SetAnimation(aniLine, WINCH_ANI_LINE);
    StageTask__SetOAMOrder(&aniLine->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniLine->work, SPRITE_PRIORITY_2);

    fx32 width;
    if ((mapObject->flags & WINCH_OBJFLAG_FLIPPED) != 0)
        width = 62;
    else
        width = -62;
    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, width - 16, 48, width + 16, 80);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~1, 0);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], Winch_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    work->hookOffset.x = -FLOAT_TO_FX32(60.0);
    work->hookOffset.y = FLOAT_TO_FX32(16.0);
    if ((mapObject->flags & WINCH_OBJFLAG_FLIPPED) != 0)
        work->hookOffset.x = -work->hookOffset.x;
    work->lineLength = FLOAT_TO_FX32(32.0);

    SetTaskOutFunc(&work->gameWork.objWork, Winch_Draw);

    work->gameWork.objWork.sequencePlayerPtr = AllocSndHandle();

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, =0x000010F6
	mov r7, r0
	str r3, [sp]
	mov r0, #2
	mov r6, r1
	mov r4, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r5, =0x000004CC
	ldr r0, =StageTask_Main
	ldr r1, =Winch_Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r5
	bl GetTaskWork_
	ldr r2, =0x000004CC
	mov r5, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r5
	mov r1, r7
	mov r2, r6
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r1, [r5, #0x1c]
	mov r0, #0xb3
	orr r1, r1, #0x2100
	str r1, [r5, #0x1c]
	ldr r1, [r5, #0x20]
	orr r1, r1, #0x10000
	str r1, [r5, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	mov r1, #0x20
	ldr r2, [r0, #0]
	mov r0, r5
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r5, #0x168
	ldr r2, =aActAcGmkWinchB
	bl ObjObjectAction2dBACLoad
	ldr r1, [r5, #0x1a4]
	mov r0, r5
	orr r1, r1, #0x200
	str r1, [r5, #0x1a4]
	mov r1, #0
	mov r2, #0x33
	bl ObjActionAllocSpritePalette
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r5
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimation
	add r6, r5, #0x364
	mov r0, #0xb3
	bl GetObjectFileWork
	mov r3, r0
	ldr r1, =gameArchiveStage
	mov r0, r6
	ldr r2, [r1, #0]
	ldr r1, =aActAcGmkWinchB
	str r2, [sp]
	mov r2, #0xc
	bl ObjAction2dBACLoad
	ldr r0, [r6, #0x3c]
	mov r1, #1
	orr r0, r0, #0x200
	str r0, [r6, #0x3c]
	ldr r0, [r6, #0x14]
	mov r2, #0x33
	bl ObjDrawAllocSpritePalette
	mov r4, r0
	strh r4, [r6, #0x50]
	ldrh r0, [r6, #0x50]
	strh r0, [r6, #0x92]
	ldrh r2, [r6, #0x92]
	mov r0, r6
	mov r1, #1
	strh r2, [r6, #0x90]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r6
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r6
	mov r1, #2
	bl StageTask__SetOAMPriority
	add r0, r5, #8
	add r6, r0, #0x400
	mov r0, #0xb3
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r2, [r1, #0]
	ldr r1, =aActAcGmkWinchB
	str r2, [sp]
	mov r0, r6
	mov r2, #1
	bl ObjAction2dBACLoad
	strh r4, [r6, #0x50]
	ldrh r2, [r6, #0x50]
	mov r0, r6
	mov r1, #2
	strh r2, [r6, #0x92]
	strh r2, [r6, #0x90]
	ldr r2, [r6, #0x3c]
	orr r2, r2, #0x10
	str r2, [r6, #0x3c]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r6
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r6
	mov r1, #2
	bl StageTask__SetOAMPriority
	ldrh r0, [r7, #4]
	mov r4, #0x50
	tst r0, #1
	movne r0, #0x3e
	mvneq r0, #0x3d
	sub r1, r0, #0x10
	add r0, r0, #0x10
	mov r2, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	str r5, [r5, #0x234]
	mov r3, r2, asr #0x10
	add r0, r5, #0x218
	mov r1, r1, asr #0x10
	mov r2, #0x30
	str r4, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r5, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r5, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =Winch_OnDefend
	mov r0, #0x3c000
	str r1, [r5, #0x23c]
	ldr r1, [r5, #0x230]
	rsb r0, r0, #0
	orr r1, r1, #0x400
	str r1, [r5, #0x230]
	str r0, [r5, #0x4ac]
	mov r0, #0x10000
	str r0, [r5, #0x4b0]
	ldrh r0, [r7, #4]
	mov r1, #0x20000
	tst r0, #1
	ldrne r0, [r5, #0x4ac]
	rsbne r0, r0, #0
	strne r0, [r5, #0x4ac]
	ldr r0, =Winch_Draw
	str r1, [r5, #0x4c0]
	str r0, [r5, #0xfc]
	bl AllocSndHandle
	str r0, [r5, #0x138]
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void Winch_Destructor(Task *task)
{
    Winch *work = TaskGetWork(task, Winch);

    ObjDrawReleaseSpritePalette(work->aniHook.cParam[0].palette);

    ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_179), &work->aniHook);
    ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_179), &work->aniLine);

    GameObject__Destructor(task);
}

void Winch_State_PlayerAttached(Winch *work)
{
    if ((work->gameWork.flags & WINCH_FLAG_PLAYER_DETACHED) == 0 && !CheckPlayerGimmickObj(work->gameWork.parent, work))
    {
        work->gameWork.flags |= WINCH_FLAG_PLAYER_DETACHED;
        work->spinSpeed = -work->speed >> 2;

        StopStageSfx(work->gameWork.objWork.sequencePlayerPtr);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_WINCH_ROLL);
    }

    if (work->spinSpeed > 0)
    {
        work->centerAngle += (u16)(work->spinSpeed >> 6);
        work->lineLength += work->spinSpeed;
        work->spinSpeed -= work->spinSpeed >> 5;

        if (work->lineLength >= work->maxLineLength)
        {
            work->lineLength = work->maxLineLength;
            work->spinSpeed  = FLOAT_TO_FX32(0.0);
            if (work->lineLength >= FLOAT_TO_FX32(160.0))
                work->gameWork.objWork.shakeTimer = FLOAT_TO_FX32(16.0);
        }
        else
        {
            if (work->spinSpeed < FLOAT_TO_FX32(1.0))
                work->spinSpeed = FLOAT_TO_FX32(0.0);
        }
    }
    else
    {
        if (work->spinSpeed < 0)
        {
            work->centerAngle += (u16)(work->spinSpeed >> 6);
            work->lineLength += work->spinSpeed;
            work->spinSpeed += (work->spinSpeed >> 4);

            if (-work->spinSpeed > work->speed)
                work->spinSpeed = -work->speed;

            if (work->lineLength <= FLOAT_TO_FX32(0.0))
            {
                work->lineLength = FLOAT_TO_FX32(0.0);
                SetTaskState(&work->gameWork.objWork, Winch_State_Retract);

                work->gameWork.objWork.userTimer = 0;
                work->gameWork.objWork.userWork  = 0;
                work->gameWork.objWork.userFlag |= PLAYER_PARENTFLAG_RELEASE_WITH_VELOCITY;
                work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
                work->gameWork.objWork.velocity.y = -work->speed;
            }
        }
        else
        {
            work->gameWork.objWork.userTimer++;
            if (work->gameWork.objWork.userTimer >= 16)
            {
                work->spinSpeed = -work->speed >> 2;

                StopStageSfx(work->gameWork.objWork.sequencePlayerPtr);
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_WINCH_ROLL);
            }
        }
    }

    work->gameWork.objWork.prevPosition.x = work->gameWork.objWork.position.x + work->hookOffset.x;
    work->gameWork.objWork.prevPosition.y = work->gameWork.objWork.position.y + work->hookOffset.y + work->lineLength + 0x1A000;
}

void Winch_State_Retract(Winch *work)
{
    switch (work->gameWork.objWork.userWork)
    {
        case 0:
            work->hookAngle += FLOAT_DEG_TO_IDX(5.625);
            work->lineLength -= FLOAT_TO_FX32(1.5);
            work->centerAngle += (u16)(work->spinSpeed >> 6);

            if (work->hookAngle >= FLOAT_DEG_TO_IDX(22.5))
                work->gameWork.objWork.userWork++;
            break;

        case 1:
            work->gameWork.objWork.userTimer++;
            work->centerAngle += (u16)(work->spinSpeed >> 6);

            if (work->gameWork.objWork.userTimer >= 24)
                work->gameWork.objWork.userWork++;
            break;

        case 2:
            work->hookAngle -= FLOAT_DEG_TO_IDX(1.40625);
            work->lineLength += FLOAT_TO_FX32(0.75);
            work->centerAngle += FLOAT_DEG_TO_IDX(0.52734375);

            if (work->hookAngle > FLOAT_DEG_TO_IDX(180.0))
                work->hookAngle = FLOAT_DEG_TO_IDX(0.0);

            if (work->lineLength >= FLOAT_TO_FX32(32.0))
            {
                work->hookAngle  = FLOAT_DEG_TO_IDX(0.0);
                work->lineLength = FLOAT_TO_FX32(32.0);

                SetTaskState(&work->gameWork.objWork, NULL);
                work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
            }
            break;
    }
}

void Winch_Draw(void)
{
    s32 i;
    u32 displayFlag;

    Winch *work = TaskGetWorkCurrent(Winch);

    VecU16 direction;
    direction.x = direction.y = FLOAT_DEG_TO_IDX(0.0);

    if ((work->gameWork.mapObject->flags & WINCH_OBJFLAG_FLIPPED) != 0)
        direction.z = work->centerAngle;
    else
        direction.z = -work->centerAngle;

    u16 flipFlags[4] = { DISPLAY_FLAG_NONE, DISPLAY_FLAG_FLIP_X, DISPLAY_FLAG_FLIP_Y, DISPLAY_FLAG_FLIP_X | DISPLAY_FLAG_FLIP_Y };

    // Draw Wheel
    for (i = 0; i < 4; i++)
    {
        displayFlag = work->gameWork.objWork.displayFlag | flipFlags[i];
        StageTask__Draw2DEx(&work->gameWork.objWork.obj_2d->ani, &work->gameWork.objWork.position, &direction, NULL, &displayFlag, NULL, NULL);
    }

    if ((work->gameWork.mapObject->flags & WINCH_OBJFLAG_FLIPPED) != 0)
        direction.z = -work->hookAngle;
    else
        direction.z = work->hookAngle;

    displayFlag = DISPLAY_FLAG_DISABLE_SCALE;
    if ((work->gameWork.mapObject->flags & WINCH_OBJFLAG_FLIPPED) != 0)
        displayFlag |= DISPLAY_FLAG_FLIP_X;

    // Draw Hook
    VecFx32 position;
    position.x = work->gameWork.objWork.position.x + work->hookOffset.x + work->gameWork.objWork.offset.x;
    position.y = work->gameWork.objWork.position.y + work->hookOffset.y + work->gameWork.objWork.offset.y + work->lineLength;
    position.z = work->gameWork.objWork.position.z + work->hookOffset.z;
    StageTask__Draw2DEx(&work->aniHook, &position, &direction, NULL, &displayFlag, NULL, NULL);

    // Draw Line
    if (work->lineLength > 0)
    {
        AnimatorSpriteDS *aniLine = &work->aniLine;
        displayFlag |= DISPLAY_FLAG_DISABLE_SCALE | DISPLAY_FLAG_DISABLE_ROTATION;

        s32 lineLength = FX32_TO_WHOLE(work->lineLength);
        if ((lineLength & 7) != 0)
        {
            position.y = work->gameWork.objWork.position.y + work->hookOffset.y + work->gameWork.objWork.offset.y + work->lineLength - FLOAT_TO_FX32(6.0)
                         - FX32_FROM_WHOLE((lineLength & 7));
            StageTask__Draw2DEx(aniLine, &position, NULL, NULL, &displayFlag, NULL, NULL);
        }

        position.y = work->gameWork.objWork.position.y + work->hookOffset.y + work->gameWork.objWork.offset.y - FLOAT_TO_FX32(6.0);

        for (lineLength >>= 3; lineLength;)
        {
            StageTask__Draw2DEx(aniLine, &position, NULL, NULL, &displayFlag, NULL, NULL);
            position.y += FLOAT_TO_FX32(8.0);
            lineLength--;
        }
    }
}

void Winch_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Player *player = (Player *)rect1->parent;
    Winch *winch   = (Winch *)rect2->parent;

    if (winch == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    winch->gameWork.parent = &player->objWork;
    winch->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
    {
        winch->speed = MATH_ABS(player->objWork.groundVel);
    }
    else
    {
        winch->speed = MATH_ABS(player->objWork.velocity.x) + MATH_ABS(player->objWork.velocity.y);
    }

    // clamp func, neither MTM_MATH_CLIP or MTM_MATH_CLIP_2 got it to match though
    if (winch->speed < FLOAT_TO_FX32(4.0))
    {
        winch->speed = FLOAT_TO_FX32(4.0);
    }
    else if (winch->speed > FLOAT_TO_FX32(12.0))
    {
        winch->speed = FLOAT_TO_FX32(12.0);
    }

    winch->maxLineLength = 16 * winch->speed;

    // clamp func, neither MTM_MATH_CLIP or MTM_MATH_CLIP_2 got it to match though
    if (winch->maxLineLength < FLOAT_TO_FX32(160.0))
    {
        winch->maxLineLength = FLOAT_TO_FX32(160.0);
    }
    else if (winch->maxLineLength > FLOAT_TO_FX32(288.0))
    {
        winch->maxLineLength = FLOAT_TO_FX32(288.0);
    }

    winch->hookAngle                  = FLOAT_DEG_TO_IDX(0.0);
    winch->spinSpeed                  = winch->speed;
    winch->lineLength                 = FLOAT_TO_FX32(32.0);
    winch->gameWork.objWork.userFlag  = PLAYER_PARENTFLAG_NONE;
    winch->gameWork.objWork.userTimer = 0;
    winch->gameWork.flags &= ~WINCH_FLAG_PLAYER_DETACHED;

    SetTaskState(&winch->gameWork.objWork, Winch_State_PlayerAttached);

    u32 flipFlag = DISPLAY_FLAG_NONE;
    if ((winch->gameWork.mapObject->flags & WINCH_OBJFLAG_FLIPPED) == 0)
        flipFlag = DISPLAY_FLAG_FLIP_X;

    Player__Action_Winch(player, &winch->gameWork, flipFlag);
    Player__Action_AllowTrickCombos(player, &winch->gameWork);

    StopStageSfx(winch->gameWork.objWork.sequencePlayerPtr);
    PlayHandleStageSfx(winch->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_WINCH_SEND);
}
