#include <stage/objects/popSteam.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/audio/spatialAudio.h>
#include <game/graphics/screenShake.h>
#include <stage/effects/steam.h>

// --------------------
// VARIABLES
// --------------------

static const Vec2Fx16 PopSteam__offsetTable[4] = {
    { -16, -28 },
    { -16, -28 },
    { -4, -16 },
    { -4, -16 },
};

NOT_DECOMPILED void *aActAcGmkPopSte;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC PopSteam *PopSteam__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // https://decomp.me/scratch/Xo0hU -> 85.79%
#ifdef NON_MATCHING
    Task *task;
    PopSteam *work;

    s16 popSteamType = 0;

    task = CreateStageTask(PopSteam__Destructor, TASK_FLAG_NONE, TASK_PAUSELEVEL_0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), PopSteam);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, PopSteam);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.sequencePlayerPtr = AllocSndHandle();

    if (mapObject->id >= MAPOBJECT_86)
        popSteamType++;

    work->steamSize = 8 * mapObject->left + 120;
    work->steamSize = ClampS32(work->steamSize, 120, 256);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

    if (mapObject->id == MAPOBJECT_86)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if (mapObject->id == MAPOBJECT_85)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_pop_steam.bac", GetObjectFileWork(OBJDATAWORK_170), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 2, GetObjectSpriteRef(2 * popSteamType + OBJDATAWORK_171));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 34);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, 2 * popSteamType + 1);

    if ((mapObject->flags & 1) != 0)
    {
        AnimatorSpriteDS *aniCork = &work->aniCork.ani;

        ObjAction2dBACLoad(aniCork, "/act/ac_gmk_pop_steam.bac", OBJ_DATA_GFX_AUTO, GetObjectFileWork(OBJDATAWORK_170), gameArchiveStage);
        StageTask__SetOAMOrder(&aniCork->work, SPRITE_ORDER_23);
        StageTask__SetOAMPriority(&aniCork->work, SPRITE_PRIORITY_2);
        aniCork->flags |= ANIMATORSPRITEDS_FLAG_11 | ANIMATORSPRITEDS_FLAG_4;
        AnimatorSpriteDS__SetAnimation(aniCork, 2 * popSteamType);

        aniCork->cParam[1].palette = aniCork->cParam[0].palette = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;
        aniCork->work.cParam.palette                            = aniCork->cParam[0].palette;

        work->gameWork.objWork.collisionObj           = NULL;
        work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
        work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
        work->gameWork.collisionObject.work.width     = 32;
        work->gameWork.collisionObject.work.height    = 32;
        work->gameWork.collisionObject.work.ofst_x    = PopSteam__offsetTable[mapObject->id - MAPOBJECT_84].x;
        work->gameWork.collisionObject.work.ofst_y    = PopSteam__offsetTable[mapObject->id - MAPOBJECT_84].y;

        ObjRect__SetAttackStat(&work->gameWork.colliders[0], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[0], OBS_RECT_WORK_ATTR_BODY, OBS_RECT_DEFPOWER_VULNERABLE);
        ObjRect__SetOnDefend(&work->gameWork.colliders[0], PopSteam__OnDefend_Cork);

        work->gameWork.flags |= 1;
    }
    else
    {
        work->gameWork.colliders[1].parent = &work->gameWork.objWork;

        if (mapObject->id == MAPOBJECT_86 || (s32)mapObject->id == MAPOBJECT_87)
            ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, 0, -16, work->steamSize, 16);
        else
            ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, -16, -work->steamSize, 16, 0);

        work->steamPos = work->steamSize;
        work->gameWork.flags |= 2;
        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_STEAM);
        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
    }

    ObjRect__SetAttackStat(&work->gameWork.colliders[1], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[1], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[1], PopSteam__OnDefend_Steam);
    work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    u16 steamEffectType = EFFECTSTEAM_TYPE_LARGE;

    fx32 duration   = FX_DivS32(FLOAT_TO_FX32(48.0), (work->gameWork.mapObject->top << (FX32_SHIFT - 1)) + FLOAT_TO_FX32(4.0)) << 12;
    work->durationS = duration;
    work->durationL = duration;
    work->timerL    = duration >> 1;

    fx32 steamTimerStep = FX32_TO_WHOLE(duration >> 1);
    fx32 force          = (mapObject->top << (FX32_SHIFT - 1)) + FLOAT_TO_FX32(6.0);
    fx32 steamSpawnX    = work->gameWork.objWork.position.x;
    fx32 steamSpawnY    = work->gameWork.objWork.position.y;
    fx32 steamOffsetX   = FLOAT_TO_FX32(0.0);
    fx32 steamOffsetY   = FLOAT_TO_FX32(0.0);
    fx32 steamVelX      = FLOAT_TO_FX32(0.0);
    fx32 steamVelY      = FLOAT_TO_FX32(0.0);
    fx32 steamStepX     = FLOAT_TO_FX32(0.0);
    fx32 steamStepY     = FLOAT_TO_FX32(0.0);

    switch (mapObject->id)
    {
        case MAPOBJECT_87:
            steamStepX   = force * steamTimerStep;
            steamVelX    = force;
            steamOffsetX = FLOAT_TO_FX32(16.0);
            break;

        case MAPOBJECT_86:
        default:
            steamVelX    = -force;
            steamStepX   = -force * steamTimerStep;
            steamOffsetX = -FLOAT_TO_FX32(16.0);
            break;

        case MAPOBJECT_84:
            steamStepY   = -force * steamTimerStep;
            steamVelY    = -force;
            steamOffsetY = -FLOAT_TO_FX32(16.0);
            break;

        case MAPOBJECT_85:
            steamStepY   = force * steamTimerStep;
            steamVelY    = force;
            steamOffsetY = FLOAT_TO_FX32(16.0);
            break;
    }

    s32 v27         = FX_DivS32(FX32_FROM_WHOLE(work->steamPos), force);
    fx32 steamTimer = FX32_FROM_WHOLE(v27);

    s32 i = FX_DivS32(v27, steamTimerStep);
    while (i > 0)
    {
        EffectSteamEffect__Create(steamEffectType, steamSpawnX + steamOffsetX, steamSpawnY + steamOffsetY, steamVelX, steamVelY, steamTimer);
        steamEffectType ^= 1;
        steamOffsetY += steamStepY;
        steamOffsetX += steamStepX;
        steamTimer -= FX32_FROM_WHOLE(steamTimerStep);
        i--;
    }

    SetTaskOutFunc(&work->gameWork.objWork, PopSteam__Draw);
    SetTaskState(&work->gameWork.objWork, PopSteam__State_Active);

    return work;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	mov r3, #0x1800
	mov r5, r0
	mov r8, r1
	str r3, [sp]
	mov r0, #2
	mov r6, #0
	str r0, [sp, #4]
	ldr r4, =0x00000428
	mov r7, r2
	ldr r0, =StageTask_Main
	ldr r1, =PopSteam__Destructor
	mov r2, r6
	mov r3, r6
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, r6
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0x20
	moveq r0, r6
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r4
	bl GetTaskWork_
	ldr r2, =0x00000428
	mov r4, r0
	mov r1, r6
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r5
	mov r2, r8
	mov r3, r7
	bl GameObject__InitFromObject
	bl AllocSndHandle
	str r0, [r4, #0x138]
	ldrh r0, [r5, #2]
	ldrsb r1, [r5, #6]
	cmp r0, #0x56
	addhs r0, r6, #1
	movhs r0, r0, lsl #0x10
	mov r1, r1, lsl #3
	movhs r6, r0, asr #0x10
	add r0, r4, #0x400
	add r1, r1, #0x78
	strh r1, [r0, #0x14]
	ldrsh r1, [r0, #0x14]
	cmp r1, #0x78
	movlt r1, #0x78
	blt _02166454
	cmp r1, #0x100
	movgt r1, #0x100
_02166454:
	add r0, r4, #0x400
	strh r1, [r0, #0x14]
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldrh r0, [r5, #2]
	cmp r0, #0x56
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #1
	streq r0, [r4, #0x20]
	ldrh r0, [r5, #2]
	cmp r0, #0x55
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #2
	streq r0, [r4, #0x20]
	mov r0, #0xaa
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1, #0]
	ldr r2, =aActAcGmkPopSte
	str r1, [sp]
	mov r7, #0
	mov r0, r4
	add r1, r4, #0x168
	str r7, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r6, lsl #1
	add r0, r0, #0xab
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #2
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, r7
	mov r2, #0x22
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r1, r6, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldrh r0, [r5, #4]
	tst r0, #1
	beq _0216662C
	mov r0, #0xaa
	add r7, r4, #0x364
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r8, [r1, #0]
	ldr r1, =aActAcGmkPopSte
	ldr r2, =0x0000FFFF
	mov r0, r7
	str r8, [sp]
	bl ObjAction2dBACLoad
	mov r0, r7
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r7
	mov r1, #2
	bl StageTask__SetOAMPriority
	ldr r2, [r7, #0x64]
	mov r0, r6, lsl #0x11
	orr r2, r2, #0x810
	mov r1, r0, lsr #0x10
	mov r0, r7
	str r2, [r7, #0x64]
	bl AnimatorSpriteDS__SetAnimation
	ldr r0, [r4, #0x128]
	mov r1, #0
	ldrh r2, [r0, #0x50]
	ldr r0, =StageTask__DefaultDiffData
	mov r6, #0x20
	strh r2, [r7, #0x90]
	strh r2, [r7, #0x92]
	ldrh r3, [r7, #0x90]
	add r2, r4, #0x300
	ldr r8, =PopSteam__offsetTable
	strh r3, [r7, #0x50]
	str r1, [r4, #0x13c]
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	ldrh r7, [r5, #2]
	add r3, r4, #0x200
	add r0, r4, #0x218
	strh r6, [r2, #8]
	sub r7, r7, #0x54
	strh r6, [r2, #0xa]
	mov r2, r7, lsl #2
	ldrsh r6, [r8, r2]
	add r7, r8, r7, lsl #2
	mov r2, r1
	strh r6, [r3, #0xf0]
	ldrsh r6, [r7, #2]
	strh r6, [r3, #0xf2]
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, =PopSteam__OnDefend_Cork
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x354]
	orr r0, r0, #1
	str r0, [r4, #0x354]
	b _021666D8
_0216662C:
	str r4, [r4, #0x274]
	ldrh r0, [r5, #2]
	cmp r0, #0x56
	cmpne r0, #0x57
	bne _02166664
	mov r0, #0x10
	str r0, [sp]
	add r0, r4, #0x400
	mov r1, #0
	ldrsh r3, [r0, #0x14]
	add r0, r4, #0x258
	sub r2, r1, #0x10
	bl ObjRect__SetBox2D
	b _02166690
_02166664:
	mov r1, r7
	str r1, [sp]
	add r0, r4, #0x400
	ldrsh r2, [r0, #0x14]
	add r0, r4, #0x258
	sub r1, r1, #0x10
	rsb r2, r2, #0
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	mov r3, #0x10
	bl ObjRect__SetBox2D
_02166690:
	add r0, r4, #0x400
	ldrsh r2, [r0, #0x14]
	mov r6, #0x58
	sub r1, r6, #0x59
	strh r2, [r0, #0x16]
	ldr r0, [r4, #0x354]
	mov r3, #0
	orr r0, r0, #2
	str r0, [r4, #0x354]
	ldr r0, [r4, #0x138]
	mov r2, r1
	str r3, [sp]
	mov r3, r1
	str r6, [sp, #4]
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
_021666D8:
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x258
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =PopSteam__OnDefend_Steam
	mov r0, #0x30000
	str r1, [r4, #0x27c]
	ldr r1, [r4, #0x270]
	orr r1, r1, #0x400
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x340]
	ldrsb r1, [r1, #7]
	mov r1, r1, lsl #0xb
	add r1, r1, #0x4000
	bl FX_DivS32
	mov r7, #0
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x418]
	str r0, [r4, #0x420]
	mov r0, r0, asr #1
	str r0, [r4, #0x424]
	ldrh r0, [r5, #2]
	ldrsb r1, [r5, #7]
	ldr r3, [r4, #0x418]
	sub r2, r0, #0x54
	ldr r0, [r4, #0x44]
	mov r1, r1, lsl #0xb
	str r0, [sp, #0x14]
	ldr r0, [r4, #0x48]
	str r7, [sp, #0x1c]
	str r7, [sp, #0x18]
	mov r8, r7
	mov r6, r3, asr #0xd
	add r1, r1, #0x6000
	cmp r2, #3
	str r0, [sp, #0x10]
	mov r9, r7
	str r7, [sp, #0xc]
	mov r11, r7
	addls pc, pc, r2, lsl #2
	b _0216679C
_0216678C: // jump table
	b _021667CC // case 0
	b _021667E0 // case 1
	b _0216679C // case 2
	b _021667B8 // case 3
_0216679C:
	rsb r0, r1, #0
	mul r2, r0, r6
	mov r8, #0x10000
	str r0, [sp, #0x1c]
	str r2, [sp, #0xc]
	rsb r8, r8, #0
	b _021667EC
_021667B8:
	mul r0, r1, r6
	str r0, [sp, #0xc]
	str r1, [sp, #0x1c]
	mov r8, #0x10000
	b _021667EC
_021667CC:
	rsb r0, r1, #0
	mul r11, r0, r6
	str r0, [sp, #0x18]
	sub r9, r7, #0x10000
	b _021667EC
_021667E0:
	mul r11, r1, r6
	str r1, [sp, #0x18]
	mov r9, #0x10000
_021667EC:
	add r0, r4, #0x400
	ldrsh r0, [r0, #0x16]
	mov r0, r0, lsl #0xc
	bl FX_DivS32
	mov r1, r6
	mov r10, r0, lsl #0xc
	bl FX_DivS32
	mov r5, r0
	b _02166858
_02166810:
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x14]
	str r0, [sp]
	ldr r2, [sp, #0x10]
	ldr r3, [sp, #0x1c]
	mov r0, r7
	add r1, r1, r8
	add r2, r2, r9
	str r10, [sp, #4]
	bl EffectSteamEffect__Create
	eor r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	ldr r0, [sp, #0xc]
	add r9, r9, r11
	add r8, r8, r0
	sub r10, r10, r6, lsl #12
	sub r5, r5, #1
_02166858:
	cmp r5, #0
	bgt _02166810
	ldr r0, =PopSteam__Draw
	ldr r1, =PopSteam__State_Active
	str r0, [r4, #0xfc]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void PopSteam__Destructor(Task *task)
{
    PopSteam *work = TaskGetWork(task, PopSteam);

    if ((work->gameWork.mapObject->flags & 1) != 0)
    {
        ObjAction2dBACRelease(GetObjectFileWork(OBJDATAWORK_170), &work->aniCork.ani);
    }

    StopStageSfx(work->gameWork.objWork.sequencePlayerPtr);

    GameObject__Destructor(task);
}

NONMATCH_FUNC void PopSteam__State_Active(PopSteam *work)
{
    // https://decomp.me/scratch/E7uW9 -> 99.24%
    // very minor register issues
#ifdef NON_MATCHING
    if (work->gameWork.objWork.userTimer != 0)
    {
        work->gameWork.objWork.userTimer--;

        if (work->gameWork.objWork.userTimer == 0)
        {
            work->gameWork.colliders[1].flag &= ~OBS_RECT_WORK_FLAG_NO_ONATTACK_ONENTER;
        }
        else if ((work->gameWork.colliders[1].flag & OBS_RECT_WORK_FLAG_NO_ONATTACK_ONENTER) == 0)
        {
            work->gameWork.objWork.userTimer = 0;
        }
    }

    if ((work->gameWork.flags & 4) != 0)
    {
        fx32 force = (work->gameWork.mapObject->top << (FX32_SHIFT - 1)) + FLOAT_TO_FX32(6.0);

        force <<= 4;
        force >>= 4;
        work->steamPos += FX32_TO_WHOLE(force);

        if (work->steamPos >= work->steamSize)
        {
            work->steamPos = work->steamSize;
            work->gameWork.flags &= ~4;
        }

        if (work->gameWork.mapObject->id == MAPOBJECT_86 || work->gameWork.mapObject->id == MAPOBJECT_87)
            ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, 0, -16, work->steamPos, 16);
        else
            ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, -16, -work->steamPos, 16, 0);
    }

    if ((work->gameWork.flags & 2) != 0)
    {
        u16 type = 0xFFFF;

        fx32 steamVelX;
        fx32 steamVelY;

        fx32 offsetX = FLOAT_TO_FX32(0.0);
        fx32 offsetY = FLOAT_TO_FX32(0.0);

        work->timerS += GetObjSpeed();
        work->timerL += GetObjSpeed();

        if (work->timerS >= work->durationS)
        {
			// spawn small puff
            work->timerS = 0;
            type         = EFFECTSTEAM_TYPE_SMALL;
        }
        else if (work->timerL >= work->durationL)
        {
			// spawn large puff
            type         = EFFECTSTEAM_TYPE_LARGE;
            work->timerL = 0;

            offsetY = FX32_FROM_WHOLE((mtMathRand() & 0xF) - 7);
        }

        if (type != 0xFFFF)
        {
            MapObject *mapObject = work->gameWork.mapObject;

            steamVelX = FLOAT_TO_FX32(0.0);
            steamVelY = FLOAT_TO_FX32(0.0);

            fx32 force = (mapObject->top << (FX32_SHIFT - 1)) + FLOAT_TO_FX32(6.0);
            switch (mapObject->id)
            {
                case MAPOBJECT_86:
                default:
                    steamVelX = -force;

                    offsetX = -FLOAT_TO_FX32(16.0);
                    break;

                case MAPOBJECT_87:
                    steamVelX = force;

                    offsetX = FLOAT_TO_FX32(16.0);
                    break;

                case MAPOBJECT_84:
                    steamVelY = -force;

                    offsetX = offsetY;
                    offsetY = -FLOAT_TO_FX32(16.0);
                    break;

                case MAPOBJECT_85:
                    steamVelY = force;

                    offsetX = offsetY;
                    offsetY = FLOAT_TO_FX32(16.0);
                    break;
            }

            EffectSteamEffect__Create(type, work->gameWork.objWork.position.x + offsetX, work->gameWork.objWork.position.y + offsetY, steamVelX, steamVelY,
                                      FX32_FROM_WHOLE(FX_DivS32(FX32_FROM_WHOLE(work->steamPos), force)));
        }

        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r9, r0
	ldr r0, [r9, #0x2c]
	cmp r0, #0
	beq _02166934
	subs r0, r0, #1
	str r0, [r9, #0x2c]
	ldr r0, [r9, #0x270]
	biceq r0, r0, #0x40000
	streq r0, [r9, #0x270]
	beq _02166934
	tst r0, #0x40000
	moveq r0, #0
	streq r0, [r9, #0x2c]
_02166934:
	ldr r0, [r9, #0x354]
	tst r0, #4
	beq _021669F0
	ldr r0, [r9, #0x340]
	add r1, r9, #0x400
	ldrsb r0, [r0, #7]
	ldrsh r2, [r1, #0x16]
	mov r0, r0, lsl #0xb
	add r0, r0, #0x6000
	mov r0, r0, lsl #4
	add r0, r2, r0, asr #16
	strh r0, [r1, #0x16]
	ldrsh r2, [r1, #0x14]
	ldrsh r0, [r1, #0x16]
	cmp r0, r2
	blt _02166984
	strh r2, [r1, #0x16]
	ldr r0, [r9, #0x354]
	bic r0, r0, #4
	str r0, [r9, #0x354]
_02166984:
	ldr r0, [r9, #0x340]
	mov r1, #0
	ldrh r0, [r0, #2]
	add r0, r0, #0xaa
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _021669C8
	mov r0, #0x10
	str r0, [sp]
	add r0, r9, #0x400
	ldrsh r3, [r0, #0x16]
	add r0, r9, #0x258
	sub r2, r1, #0x10
	bl ObjRect__SetBox2D
	b _021669F0
_021669C8:
	str r1, [sp]
	add r0, r9, #0x400
	ldrsh r2, [r0, #0x16]
	add r0, r9, #0x258
	sub r1, r1, #0x10
	rsb r2, r2, #0
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	mov r3, #0x10
	bl ObjRect__SetBox2D
_021669F0:
	ldr r0, [r9, #0x354]
	tst r0, #2
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r4, =0x0000FFFF
	mov r8, #0
	bl GetObjSpeed
	ldr r1, [r9, #0x41c]
	add r0, r1, r0
	str r0, [r9, #0x41c]
	bl GetObjSpeed
	ldr r1, [r9, #0x424]
	add r0, r1, r0
	str r0, [r9, #0x424]
	ldr r1, [r9, #0x41c]
	ldr r0, [r9, #0x418]
	cmp r1, r0
	blt _02166A48
	mov r0, r8
	str r0, [r9, #0x41c]
	mov r4, #1
	b _02166A90
_02166A48:
	ldr r1, [r9, #0x424]
	ldr r0, [r9, #0x420]
	cmp r1, r0
	blt _02166A90
	mov r4, r8
	ldr r2, =_mt_math_rand
	str r4, [r9, #0x424]
	ldr r3, [r2, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0xf
	sub r0, r0, #7
	str r1, [r2]
	mov r8, r0, lsl #0xc
_02166A90:
	ldr r0, =0x0000FFFF
	cmp r4, r0
	beq _02166B48
	ldr r0, [r9, #0x340]
	mov r5, #0
	ldrsb r1, [r0, #7]
	ldrh r0, [r0, #2]
	mov r6, r5
	mov r1, r1, lsl #0xb
	sub r0, r0, #0x54
	cmp r0, #3
	add r1, r1, #0x6000
	addls pc, pc, r0, lsl #2
	b _02166AD8
_02166AC8: // jump table
	b _02166AF4 // case 0
	b _02166B04 // case 1
	b _02166AD8 // case 2
	b _02166AE8 // case 3
_02166AD8:
	mov r7, #0x10000
	rsb r5, r1, #0
	rsb r7, r7, #0
	b _02166B10
_02166AE8:
	mov r5, r1
	mov r7, #0x10000
	b _02166B10
_02166AF4:
	mov r7, r8
	rsb r6, r1, #0
	sub r8, r5, #0x10000
	b _02166B10
_02166B04:
	mov r6, r1
	mov r7, r8
	mov r8, #0x10000
_02166B10:
	add r0, r9, #0x400
	ldrsh r0, [r0, #0x16]
	mov r0, r0, lsl #0xc
	bl FX_DivS32
	mov r0, r0, lsl #0xc
	str r6, [sp]
	str r0, [sp, #4]
	ldr r1, [r9, #0x44]
	ldr r2, [r9, #0x48]
	mov r0, r4
	mov r3, r5
	add r1, r1, r7
	add r2, r2, r8
	bl EffectSteamEffect__Create
_02166B48:
	ldr r0, [r9, #0x138]
	add r1, r9, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

void PopSteam__OnDefend_Steam(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    PopSteam *popSteam = (PopSteam *)rect2->parent;
    Player *player     = (Player *)rect1->parent;

    fx32 velX = FLOAT_TO_FX32(0.0);
    fx32 velY = FLOAT_TO_FX32(0.0);

    if (popSteam == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    MapObject *mapObject = popSteam->gameWork.mapObject;

    fx32 force = (mapObject->top << (FX32_SHIFT - 1)) + FLOAT_TO_FX32(6.0);
    switch (mapObject->id)
    {
        case MAPOBJECT_84:
            velY = -force;
            break;

        case MAPOBJECT_85:
            velY = force;
            break;

        case MAPOBJECT_86:
            velX = -force;
            break;

        case MAPOBJECT_87:
            velX = force;
            break;
    }

    Player__Action_PopSteam(player, &popSteam->gameWork, velX, velY, FX32_FROM_WHOLE(popSteam->steamSize), 1);
    Player__Action_AllowTrickCombos(player, &popSteam->gameWork);
    popSteam->gameWork.objWork.userTimer = 60;
}

void PopSteam__OnDefend_Cork(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    PopSteam *popSteam = (PopSteam *)rect2->parent;
    Player *player     = (Player *)rect1->parent;

    if (popSteam == NULL || player == NULL)
        return;

    switch (player->objWork.objType)
    {
        case STAGE_OBJ_TYPE_EFFECT:
            player = (Player *)player->objWork.parentObj;

            if (player == NULL || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
                return;

            player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL;
            break;

        default:
            if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
                return;

            if (((player->objWork.moveFlag == STAGE_TASK_MOVE_FLAG_NONE) & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0)
                return;

            Player__Action_DestroyAttackRecoil(player);
            break;
    }

    ShakeScreen(SCREENSHAKE_C_SHORT);

    popSteam->gameWork.colliders[0].parent = NULL;
    popSteam->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    popSteam->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
    popSteam->gameWork.collisionObject.work.parent = NULL;

    popSteam->gameWork.flags &= ~1;
    popSteam->gameWork.flags |= (2 | 4);

    popSteam->gameWork.colliders[1].parent = &popSteam->gameWork.objWork;

    fx32 spawnX = popSteam->gameWork.objWork.position.x;
    fx32 spawnY = popSteam->gameWork.objWork.position.y;

    fx32 velX;
    fx32 velY;

    switch (popSteam->gameWork.mapObject->id)
    {
        case MAPOBJECT_84:
            velX = 0;
            spawnY -= 0x10000;
            velY = -0x4000;
            break;

        case MAPOBJECT_85:
            velX = 0;
            spawnY += 0x10000;
            velY = 0x4000;
            break;

        case MAPOBJECT_86:
            velX = -16384;
            velY = -16384;
            spawnX -= 0x10000;
            break;

        case MAPOBJECT_87:
            velX = 0x4000;
            spawnX += 0x10000;
            velY = -0x4000;
            break;
    }

    EffectSteamDust__Create(0, spawnX, spawnY, velX - 0x2800, velY);
    EffectSteamDust__Create(1, spawnX, spawnY, velX + 0x1800, velY + 0x2000);
    EffectSteamDust__Create(0, spawnX, spawnY, velX, velY - 0x2000);
    EffectSteamDust__Create(1, spawnX, spawnY, velX - 0x1800, velY + 0x1000);
    EffectSteamDust__Create(0, spawnX, spawnY, velX + 0x2800, velY - 0x1000);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DEST_OBJ);
    PlayHandleStageSfx(popSteam->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_STEAM);

    ProcessSpatialSfx(popSteam->gameWork.objWork.sequencePlayerPtr, &popSteam->gameWork.objWork.position);
}

void PopSteam__Draw(void)
{
    PopSteam *work = TaskGetWorkCurrent(PopSteam);

    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);

    if ((work->gameWork.flags & 1) != 0)
    {
        u32 displayFlag = work->gameWork.objWork.displayFlag;

        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        StageTask__Draw2D(&work->gameWork.objWork, &work->aniCork.ani);

        work->gameWork.objWork.displayFlag = displayFlag;
    }
}