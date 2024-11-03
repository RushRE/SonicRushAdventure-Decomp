#include <stage/objects/steamFan.h>
#include <stage/effects/steamFan.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/audio/spatialAudio.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_radius mapObject->left

// --------------------
// ENUMS
// --------------------

enum SteamFanObjectFlags
{
    STEAMFAN_OBJFLAG_NONE,

    STEAMFAN_OBJFLAG_REVERSE_DIR = 1 << 0,
};

enum SteamFanAnimIDs
{
    STEAMFAN_ANI_FAN,
    STEAMFAN_ANI_STEAM,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void SteamFan_Destructor(Task *task);
static void SteamFan_State_Spinning(SteamFan *work);
static void SteamFan_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void SteamFan_Draw(void);

// --------------------
// FUNCTIONS
// --------------------

SteamFan *CreateSteamFan(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(SteamFan_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), SteamFan);
    if (task == HeapNull)
        return NULL;

    SteamFan *work = TaskGetWork(task, SteamFan);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_steam_fan.bac", GetObjectDataWork(OBJDATAWORK_165), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    work->gameWork.animator.ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 8, GetObjectSpriteRef(OBJDATAWORK_166));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, STEAMFAN_ANI_FAN, 34);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    if ((work->gameWork.mapObject->flags & STEAMFAN_OBJFLAG_REVERSE_DIR) != 0)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -44, -44, 44, 44);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~1, 0);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], SteamFan_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    SetTaskOutFunc(&work->gameWork.objWork, SteamFan_Draw);
    SetTaskState(&work->gameWork.objWork, SteamFan_State_Spinning);

    work->gameWork.objWork.sequencePlayerPtr = AllocSndHandle();
    PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FAN);
    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    return work;
}

void SteamFan_Destructor(Task *task)
{
    SteamFan *work = TaskGetWork(task, SteamFan);

    StopStageSfx(work->gameWork.objWork.sequencePlayerPtr);

    GameObject__Destructor(task);
}

void SteamFan_State_Spinning(SteamFan *work)
{
    u32 angle;
    u8 userWork;
    s16 angleDir;

    if ((work->gameWork.mapObject->flags & STEAMFAN_OBJFLAG_REVERSE_DIR) != 0)
    {
        userWork = 2;
        angleDir = -1;

        u32 angle2  = (work->angle - FLOAT_DEG_TO_IDX(86.484375));
        work->angle = angle2 - (u16)-FLOAT_DEG_TO_IDX(90.0);

        u16 unknownAngle = work->unknownAngle;
        unknownAngle -= (u16)-FLOAT_DEG_TO_IDX(4.21875);
        work->unknownAngle = unknownAngle;

        angle = (u16)FLOAT_DEG_TO_IDX(14.0625);
    }
    else
    {
        userWork = -3;
        angleDir = 1;

        u16 angle2 = work->angle;
        angle2 += (u16)-FLOAT_DEG_TO_IDX(273.515625);
        angle2 += (u16)-FLOAT_DEG_TO_IDX(90.0);
        work->angle = angle2;

        u16 unknownAngle = work->unknownAngle;
        unknownAngle += (u16)-FLOAT_DEG_TO_IDX(4.21875);
        work->unknownAngle = unknownAngle;

        angle = -FLOAT_DEG_TO_IDX(14.0625);
    }

    if ((playerGameStatus.stageTimer & 1) == 0)
    {
        EffectCreateSteamFan(&work->gameWork.objWork, FLOAT_TO_FX32(32.0), work->angle + angle + ((work->angleOffset + work->angleOffset) << 13), userWork);
        work->angleOffset += angleDir;
        work->angleOffset &= 3;
    }

    Player *player = (Player *)work->gameWork.parent;
    if (player != NULL)
    {
        if (CheckPlayerGimmickObj(player, work))
        {
            if ((work->gameWork.mapObject->flags & STEAMFAN_OBJFLAG_REVERSE_DIR) != 0)
                work->gameWork.objWork.dir.z -= (u16)-FLOAT_DEG_TO_IDX(4.21875);
            else
                work->gameWork.objWork.dir.z += (u16)-FLOAT_DEG_TO_IDX(4.21875);
        }
        else
        {
            work->gameWork.parent            = NULL;
            work->gameWork.objWork.userTimer = 20;
        }
    }
    else
    {
        if (work->gameWork.objWork.userTimer != 0)
        {
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer == 0)
                work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        }
    }

    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
}

void SteamFan_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SteamFan *fan  = (SteamFan *)rect2->parent;
    Player *player = (Player *)rect1->parent;

    if (fan == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (!CheckPlayerGimmickObj(player, fan))
    {
        fan->gameWork.parent = &player->objWork;
        fan->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        fan->gameWork.objWork.dir.z = FX_Atan2Idx(player->objWork.position.y - fan->gameWork.objWork.position.y, player->objWork.position.x - fan->gameWork.objWork.position.x);
        Player__Action_SteamFan(player, &fan->gameWork, (fan->gameWork.mapObjectParam_radius << 11) + FLOAT_DEG_TO_IDX(135.0));
    }
}

void SteamFan_Draw(void)
{
    s32 i;
    AnimatorSpriteDS *aniFan;
    SteamFan *work = TaskGetWorkCurrent(SteamFan);

    aniFan = &work->gameWork.objWork.obj_2d->ani;

    VecU16 direction;
    direction.x = direction.y = FLOAT_DEG_TO_IDX(0.0);
    direction.z               = work->angle;

    for (i = 0; i < 4; i++)
    {
        StageTask__Draw2DEx(aniFan, &work->gameWork.objWork.position, &direction, NULL, &work->gameWork.objWork.displayFlag, NULL, NULL);
        direction.z += FLOAT_DEG_TO_IDX(90.0);
    }
}
