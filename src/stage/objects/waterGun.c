#include <stage/objects/waterGun.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/audio/spatialAudio.h>

// --------------------
// MACROS
// --------------------

#define GET_ANIMATOR_FOR_ANIMATION(anim) ((anim) - WATERGUN_ANI_GUN_WATER_TRAIL_STRAIGHT)

// --------------------
// MAPOBJECT PARAMS
// --------------------

// WaterGun & WaterGrindRailSegment
#define mapObjectParam_id mapObject->left

// WaterGun only
#define mapObjectParam_trailDuration1 mapObject->width
#define mapObjectParam_trailDuration2 mapObject->height

// --------------------
// ENUMS
// --------------------

enum WaterGrindRailSegmentObjectFlags
{
    WATERGRINDTRIGGER_OBJFLAG_NONE,

    WATERGRINDTRIGGER_OBJFLAG_FLIP_X = 1 << 0,

    WATERGRINDTRIGGER_OBJFLAG_GRIND_ID_MASK = 0x3F,
};

enum WaterGunAnimIDs
{
    WATERGUN_ANI_GUN_HORIZONTAL,
    WATERGUN_ANI_GUN_UPWARDS,
    WATERGUN_ANI_GUN_WATER_TRAIL_STRAIGHT,
    WATERGUN_ANI_GUN_WATER_TRAIL_UPWARDS,
    WATERGUN_ANI_GUN_WATER_SPLASH,
    WATERGUN_ANI_GUN_WATER_TRAIL_DOWN_CURVE_1,
    WATERGUN_ANI_GUN_WATER_TRAIL_DOWN_CURVE_2,
};

enum WaterGunFlags
{
    WATERGUN_FLAG_NONE,

    WATERGUN_FLAG_SHAKING = 1 << 0,
};

// --------------------
// VARIABLES
// --------------------

static u32 isGrindRailVisible;
static u32 activeGrindRails;
static u32 isGrindRailAimedUpwards;
static Task *grindRailTaskSingleton[2];

static u8 grindRailSpriteSize[5] = { 8, 17, 16, 51, 49 };

NOT_DECOMPILED const char *aActAcGmkWaterG;
NOT_DECOMPILED const char *aDfGmkWaterGrai;
NOT_DECOMPILED const char *aDfGmkWaterGrai_0;

// --------------------
// FUNCTION DECLS
// --------------------

// WaterGun
static void WaterGun_Destructor(Task *task);
static void WaterGun_State_PlayerAiming(WaterGun *work);
static void WaterGun_State_CreateWaterTrail(WaterGun *work);
static void WaterGun_State_TrailActive(WaterGun *work);
static void WaterGun_Action_ResetGun(WaterGun *work);
static void WaterGun_State_ResetGun(WaterGun *work);
static void ProcessWaterGunSfx(WaterGun *work);
static void WaterGun_Draw(void);
static void WaterGun_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// WaterGrindRailSegment
void WaterGrindRailSegment_State_Active(WaterGrindRailSegment *work);
void WaterGrindRailSegment_Draw(void);
void WaterGrindRailSegment_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// WaterGrindRailManager
AnimatorSpriteDS *CreateWaterGrindRailManager(s32 id);
void DestroyWaterGrindRailManager(s32 id);
void WaterGrindRailManager_Destructor(Task *task);
void ReleaseWaterGrindRailManager(WaterGrindRailManager *work);
AnimatorSpriteDS *GetWaterGrindRailManagerAnimators(u16 id);
void WaterGrindRailManager_Draw(void);

// --------------------
// FUNCTIONS
// --------------------

WaterGun *CreateWaterGun(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(WaterGun_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_GROUP(2), WaterGun);
    if (task == HeapNull)
        return NULL;

    void *collisionData;

    WaterGun *work = TaskGetWork(task, WaterGun);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_water_graind.bac", GetObjectFileWork(OBJDATAWORK_172), gameArchiveStage, 0x31);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 95);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_22);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, WATERGUN_ANI_GUN_HORIZONTAL);
    if (mapObject->id == MAPOBJECT_235)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    ObjRect__SetAttackStat(&work->gameWork.colliders[0], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], WaterGun_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    ObjRect__SetGroupFlags(&work->gameWork.colliders[1], 1, 2);
    ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, -8, -8, 8, 8);
    ObjRect__SetAttackStat(&work->gameWork.colliders[1], OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_HITPOWER_DEFAULT);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[1], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_NONE), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_ALLOW_MULTI_ATK_PER_FRAME;

    collisionData = (void *)GetObjectFileWork(OBJDATAWORK_193);
    ObjObjectCollisionDifSet(&work->gameWork.objWork, "/df/gmk_water_graind_gun00.df", collisionData, gameArchiveStage);
    work->gameWork.collisionObject.work.parent = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.width  = 112;
    work->gameWork.collisionObject.work.height = 64;
    work->gameWork.collisionObject.work.ofst_x = work->gameWork.collisionObject.work.height - 96;
    work->gameWork.collisionObject.work.ofst_y = -64;

    CreateWaterGrindRailManager(mapObjectParam_id);

    work->gameWork.objWork.sequencePlayerPtr = AllocSndHandle();

    return work;
}

WaterGrindRailSegment *CreateWaterGrindRailSegment(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(WaterGun_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1801, TASK_GROUP(2), WaterGrindRailSegment);
    if (task == HeapNull)
        return NULL;

    WaterGrindRailSegment *work = TaskGetWork(task, WaterGrindRailSegment);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_UPDATE | DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_DISABLE_DRAW;

    if (mapObject->id == MAPOBJECT_237 || mapObject->id == MAPOBJECT_239 || mapObject->id == MAPOBJECT_247 || mapObject->id == MAPOBJECT_249 || mapObject->id == MAPOBJECT_251)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if (mapObject->id <= MAPOBJECT_239)
    {
        s16 top;
        s16 right;
        s16 bottom;
        if (mapObject->id == MAPOBJECT_236 || mapObject->id == MAPOBJECT_237)
        {
            top    = -24;
            right  = 32;
            bottom = 8;
        }
        else
        {
            top    = -48;
            right  = 48;
            bottom = -9;
        }
        ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, 0, top, right, bottom);
        ObjRect__SetAttackStat(&work->gameWork.colliders[0], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[0], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
        ObjRect__SetOnDefend(&work->gameWork.colliders[0], WaterGrindRailSegment_OnDefend);
        work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_DISABLE_DEF_RESPONSE | OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE;
        work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    }

    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    SetTaskState(&work->gameWork.objWork, WaterGrindRailSegment_State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, WaterGrindRailSegment_Draw);

    CreateWaterGrindRailManager(mapObjectParam_id);

    return work;
}

void WaterGun_Destructor(Task *task)
{
    WaterGun *work = TaskGetWork(task, WaterGun);

    DestroyWaterGrindRailManager(work->gameWork.mapObjectParam_id);

    if (work->gameWork.mapObject->id == MAPOBJECT_234 || work->gameWork.mapObject->id == MAPOBJECT_235)
    {
        StopStageSfx(work->gameWork.objWork.sequencePlayerPtr);

        if (StageTaskStateMatches(&work->gameWork.objWork, WaterGun_State_TrailActive) || StageTaskStateMatches(&work->gameWork.objWork, WaterGun_Action_ResetGun))
        {
            activeGrindRails &= ~(1 << work->gameWork.mapObjectParam_id);
            isGrindRailAimedUpwards &= ~(1 << work->gameWork.mapObjectParam_id);
            isGrindRailVisible &= ~(1 << work->gameWork.mapObjectParam_id);
        }
    }

    GameObject__Destructor(task);
}

void WaterGun_State_PlayerAiming(WaterGun *work)
{
    Player *player = (Player *)work->gameWork.parent;

    if (CheckPlayerGimmickObj(player, work) == FALSE)
    {
        StageTask__SetAnimation(&work->gameWork.objWork, WATERGUN_ANI_GUN_HORIZONTAL);

        work->gameWork.objWork.flag &= ~(STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION);

        work->gameWork.colliders[0].parent = &work->gameWork.objWork;
        work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

        SetTaskState(&work->gameWork.objWork, NULL);
        work->gameWork.parent = NULL;
    }
    else
    {
        if ((player->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
        {
            work->gameWork.objWork.userTimer = 0;

            SetTaskState(&work->gameWork.objWork, WaterGun_State_CreateWaterTrail);
            SetTaskOutFunc(&work->gameWork.objWork, WaterGun_Draw);

            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_USE_DEFAULT_DRAW;

            work->gameWork.colliders[1].parent = &work->gameWork.objWork;
            work->gameWork.colliders[1].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

            work->gameWork.flags &= ~WATERGUN_FLAG_SHAKING;
            PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DRAINAGE);
            ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
        }
        else
        {
            work->gameWork.objWork.userTimer++;
            if ((work->gameWork.objWork.userTimer & 0x1F) == 0)
            {
                if ((work->gameWork.objWork.userTimer & 0x20) != 0)
                {
                    StageTask__SetAnimation(&work->gameWork.objWork, WATERGUN_ANI_GUN_UPWARDS);
                    work->gameWork.objWork.userFlag |= WATERGUN_USERFLAG_AIMING_UPWARDS;
                }
                else
                {
                    StageTask__SetAnimation(&work->gameWork.objWork, WATERGUN_ANI_GUN_HORIZONTAL);
                    work->gameWork.objWork.userFlag &= ~WATERGUN_USERFLAG_AIMING_UPWARDS;
                }

                work->gameWork.flags |= WATERGUN_FLAG_SHAKING;
                work->gameWork.objWork.userWork = 8;
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ANGLE);
            }

            if ((work->gameWork.flags & WATERGUN_FLAG_SHAKING) != 0)
            {
                work->gameWork.objWork.offset.x = FX32_FROM_WHOLE(mtMathRandRepeat(4) - 1);
                work->gameWork.objWork.offset.y = FX32_FROM_WHOLE(mtMathRandRepeat(4) - 1);

                work->gameWork.objWork.userWork--;
                if (work->gameWork.objWork.userWork == 0)
                    work->gameWork.flags &= ~WATERGUN_FLAG_SHAKING;
            }
        }
    }
}

void WaterGun_State_CreateWaterTrail(WaterGun *work)
{
    work->gameWork.objWork.userTimer += FLOAT_TO_FX32(16.0);

    if (work->gameWork.objWork.userTimer >= FLOAT_TO_FX32(192.0))
    {
        activeGrindRails |= 1 << work->gameWork.mapObjectParam_id;
        isGrindRailAimedUpwards &= ~(1 << work->gameWork.mapObjectParam_id);

        if (work->gameWork.objWork.obj_2d->ani.work.animID == WATERGUN_ANI_GUN_UPWARDS)
            isGrindRailAimedUpwards |= (1 << work->gameWork.mapObjectParam_id);

        isGrindRailVisible |= 1 << work->gameWork.mapObjectParam_id;

        work->gameWork.objWork.userTimer = 2 * (work->gameWork.mapObjectParam_trailDuration2 + work->gameWork.mapObjectParam_trailDuration1);
        if (work->gameWork.objWork.userTimer == 0)
            work->gameWork.objWork.userTimer = SECONDS_TO_FRAMES(15.0);

        if (work->gameWork.objWork.obj_2d->ani.work.animID == WATERGUN_ANI_GUN_HORIZONTAL)
        {
            if (work->gameWork.objWork.collisionObj->diff_data_work != GetObjectFileWork(OBJDATAWORK_193))
            {
                ObjDataRelease(work->gameWork.objWork.collisionObj->diff_data_work);
                ObjObjectCollisionDifSet(&work->gameWork.objWork, "/df/gmk_water_graind_gun00.df", GetObjectFileWork(OBJDATAWORK_193), gameArchiveStage);
            }
        }
        else
        {
            if (work->gameWork.objWork.collisionObj->diff_data_work != GetObjectFileWork(OBJDATAWORK_194))
            {
                ObjDataRelease(work->gameWork.objWork.collisionObj->diff_data_work);
                ObjObjectCollisionDifSet(&work->gameWork.objWork, "/df/gmk_water_graind_gun01.df", GetObjectFileWork(OBJDATAWORK_194), gameArchiveStage);
            }
        }

        work->gameWork.colliders[1].parent = NULL;
        work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

        SetTaskState(&work->gameWork.objWork, WaterGun_State_TrailActive);
        SetTaskOutFunc(&work->gameWork.objWork, NULL);

        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_USE_DEFAULT_DRAW;
        work->gameWork.objWork.userFlag |= WATERGUN_USERFLAG_USED_GUN;
    }

    ProcessWaterGunSfx(work);
}

void WaterGun_State_TrailActive(WaterGun *work)
{
    ProcessWaterGunSfx(work);

    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer == 0)
    {
        WaterGun_Action_ResetGun(work);
        FadeOutStageSfx(work->gameWork.objWork.sequencePlayerPtr, 15);
    }
    else if (work->gameWork.objWork.userTimer < SECONDS_TO_FRAMES(1.0))
    {
        isGrindRailVisible ^= 1 << work->gameWork.mapObjectParam_id;
    }
}

void WaterGun_Action_ResetGun(WaterGun *work)
{
    GetWaterGrindRailManagerAnimators(work->gameWork.mapObjectParam_id);

    activeGrindRails &= ~(1 << work->gameWork.mapObjectParam_id);
    isGrindRailAimedUpwards &= ~(1 << work->gameWork.mapObjectParam_id);
    isGrindRailVisible &= ~(1 << work->gameWork.mapObjectParam_id);

    if (work->gameWork.objWork.obj_2d->ani.work.animID != WATERGUN_ANI_GUN_HORIZONTAL)
    {
        StageTask__SetAnimation(&work->gameWork.objWork, WATERGUN_ANI_GUN_HORIZONTAL);

        ObjDataRelease(work->gameWork.objWork.collisionObj->diff_data_work);
        ObjObjectCollisionDifSet(&work->gameWork.objWork, "/df/gmk_water_graind_gun00.df", GetObjectFileWork(OBJDATAWORK_193), gameArchiveStage);

        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ANGLE);
        ProcessSpatialSfx(&defaultSfxPlayer, &work->gameWork.objWork.position);

        SetTaskState(&work->gameWork.objWork, WaterGun_State_ResetGun);
        work->gameWork.objWork.userWork = 4;
    }
    else
    {
        work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

        work->gameWork.colliders[0].parent = &work->gameWork.objWork;
        work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

        SetTaskState(&work->gameWork.objWork, NULL);
        work->gameWork.parent = NULL;
    }
}

void WaterGun_State_ResetGun(WaterGun *work)
{
    work->gameWork.objWork.offset.x = FX32_FROM_WHOLE(mtMathRandRepeat(4) - 1);
    work->gameWork.objWork.offset.y = FX32_FROM_WHOLE(mtMathRandRepeat(4) - 1);

    work->gameWork.objWork.userWork--;
    if (work->gameWork.objWork.userWork == 0)
    {
        work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

        work->gameWork.colliders[0].parent = &work->gameWork.objWork;
        work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

        SetTaskState(&work->gameWork.objWork, NULL);
        work->gameWork.parent = NULL;
    }
}

void ProcessWaterGunSfx(WaterGun *work)
{
    VecFx32 position = work->gameWork.objWork.position;

    fx32 playerX = gPlayer->objWork.position.x;
    if (playerX >= position.x)
    {
        if (playerX <= position.x + FLOAT_TO_FX32(512.0))
            position.x = playerX;
        else
            position.x += FLOAT_TO_FX32(512.0);
    }

    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &position);
}

void WaterGun_Draw(void)
{
    AnimatorFlags flags;
    WaterGun *work;
    AnimatorSpriteDS *animator;

    s32 i;
    fx32 x     = 0;
    fx32 y     = 0;
    fx32 slope = 0;
    StageDisplayFlags displayFlag;
    fx32 end     = 0;
    fx32 stepX   = 0;
    fx32 stepY   = 0;
    fx32 offsetX = 0;
    fx32 offsetY = 0;

    work = TaskGetWorkCurrent(WaterGun);

    if (work->gameWork.objWork.obj_2d->ani.work.animID == WATERGUN_ANI_GUN_HORIZONTAL)
    {
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        {
            x     = -FLOAT_TO_FX32(80.0);
            stepX = -FLOAT_TO_FX32(32.0);
        }
        else
        {
            x     = FLOAT_TO_FX32(80.0);
            stepX = FLOAT_TO_FX32(32.0);
        }

        y     = -FLOAT_TO_FX32(24.0);
        stepY = FLOAT_TO_FX32(0.0);

        slope = FLOAT_TO_FX32(32.0);

        animator = &GetWaterGrindRailManagerAnimators(work->gameWork.mapObjectParam_id)[0];
    }
    else
    {
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        {
            x     = -FLOAT_TO_FX32(72.0);
            stepX = -FLOAT_TO_FX32(48.0);
        }
        else
        {
            x     = FLOAT_TO_FX32(72.0);
            stepX = FLOAT_TO_FX32(48.0);
        }

        y     = -FLOAT_TO_FX32(57.0);
        stepY = -FLOAT_TO_FX32(16.0);

        slope = FLOAT_TO_FX32(48.0);

        animator = &GetWaterGrindRailManagerAnimators(work->gameWork.mapObjectParam_id)[1];
    }

    end     = FX_DivS32(FX32_TO_WHOLE(work->gameWork.objWork.userTimer), FX32_TO_WHOLE(slope));
    offsetX = work->gameWork.objWork.userTimer - end * slope;

    if (offsetX != FLOAT_TO_FX32(0.0))
    {
        offsetX = slope - offsetX;
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
            offsetX = -offsetX;

        end++;
        offsetY = MultiplyFX(stepY, FX_Div(offsetX, stepX));
    }

    displayFlag = work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X | DISPLAY_FLAG_DISABLE_UPDATE | DISPLAY_FLAG_DISABLE_ROTATION;

    VecFx32 position;
    position.x = work->gameWork.objWork.position.x + x + offsetX;
    position.y = work->gameWork.objWork.position.y + y + offsetY;
    position.z = FLOAT_TO_FX32(0.0);

    flags = animator->work.flags;
    for (i = 0; i < end; i++)
    {
        StageTask__Draw2DEx(animator, &position, NULL, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);

        position.x += stepX;
        position.y += stepY;
    }

    fx32 drawX                             = position.x;
    fx32 drawY                             = position.y;
    animator->work.flags                   = flags;
    work->gameWork.colliders[1].rect.pos.x = FX32_TO_WHOLE(drawX - work->gameWork.objWork.position.x);
    work->gameWork.colliders[1].rect.pos.y = FX32_TO_WHOLE(drawY - work->gameWork.objWork.position.y);
}

void WaterGun_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    WaterGun *waterGun = (WaterGun *)rect2->parent;
    Player *player     = (Player *)rect1->parent;

    if (waterGun == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (player->objWork.rideObj == &waterGun->gameWork.objWork || (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0
        || (((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 || (waterGun->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
            && ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 || (waterGun->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)))
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        waterGun->gameWork.parent = &player->objWork;
        waterGun->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

        waterGun->gameWork.colliders[0].parent = NULL;
        waterGun->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

        waterGun->gameWork.objWork.userTimer = 0;
        waterGun->gameWork.objWork.userFlag  = WATERGUN_USERFLAG_NONE;

        SetTaskState(&waterGun->gameWork.objWork, WaterGun_State_PlayerAiming);

        Player__Action_WaterGun(player, &waterGun->gameWork);
    }
}

void WaterGrindRailSegment_State_Active(WaterGrindRailSegment *work)
{
    MapObject *mapObject = work->gameWork.mapObject;

    if ((activeGrindRails & (1 << mapObjectParam_id)) == 0)
        return;

    if ((isGrindRailAimedUpwards & (1 << mapObjectParam_id)) != 0)
    {
        if ((mapObject->id == MAPOBJECT_236 || mapObject->id == MAPOBJECT_237) || (mapObject->id == MAPOBJECT_246 || mapObject->id == MAPOBJECT_247))
            return;

        if ((mapObject->id == MAPOBJECT_250 || mapObject->id == MAPOBJECT_251) && (mapObject->flags & WATERGRINDTRIGGER_OBJFLAG_FLIP_X) == 0)
            return;
    }
    else
    {
        if ((mapObject->id == MAPOBJECT_238 || mapObject->id == MAPOBJECT_239) || (mapObject->id == MAPOBJECT_248 || mapObject->id == MAPOBJECT_249))
            return;

        if ((mapObject->id == MAPOBJECT_250 || mapObject->id == MAPOBJECT_251) && (mapObject->flags & WATERGRINDTRIGGER_OBJFLAG_FLIP_X) != 0)
            return;
    }

    if (mapObject->id <= MAPOBJECT_239)
    {
        work->gameWork.colliders[0].parent = &work->gameWork.objWork;
        work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_ENABLED;
        work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    }
    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

    SetTaskState(&work->gameWork.objWork, NULL);
}

void WaterGrindRailSegment_Draw(void)
{
    WaterGrindRailSegment *work = TaskGetWorkCurrent(WaterGrindRailSegment);

    if ((activeGrindRails & (1 << work->gameWork.mapObjectParam_id)) == 0)
    {
        work->gameWork.colliders[0].parent = NULL;
        work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

        SetTaskState(&work->gameWork.objWork, WaterGrindRailSegment_State_Active);
    }
    else
    {
        if ((isGrindRailVisible & (1 << work->gameWork.mapObjectParam_id)) != 0)
        {
            AnimatorSpriteDS *animator = GetWaterGrindRailManagerAnimators(work->gameWork.mapObjectParam_id);
            switch (work->gameWork.mapObject->id)
            {
                case MAPOBJECT_236:
                case MAPOBJECT_237:
                    // animator += GET_ANIMATOR_FOR_ANIMATION(WATERGUN_ANI_GUN_WATER_TRAIL_STRAIGHT);
                    break;

                case MAPOBJECT_238:
                case MAPOBJECT_239:
                    animator += GET_ANIMATOR_FOR_ANIMATION(WATERGUN_ANI_GUN_WATER_TRAIL_UPWARDS);
                    break;

                case MAPOBJECT_250:
                case MAPOBJECT_251:
                    animator += GET_ANIMATOR_FOR_ANIMATION(WATERGUN_ANI_GUN_WATER_SPLASH);
                    break;

                case MAPOBJECT_246:
                case MAPOBJECT_247:
                    animator += GET_ANIMATOR_FOR_ANIMATION(WATERGUN_ANI_GUN_WATER_TRAIL_DOWN_CURVE_1);
                    break;

                case MAPOBJECT_248:
                case MAPOBJECT_249:
                    animator += GET_ANIMATOR_FOR_ANIMATION(WATERGUN_ANI_GUN_WATER_TRAIL_DOWN_CURVE_2);
                    break;
            }

            AnimatorFlags flags = animator->work.flags;
            StageTask__Draw2DEx(animator, &work->gameWork.objWork.position, NULL, &work->gameWork.objWork.scale, &work->gameWork.objWork.displayFlag, NULL, NULL);
            animator->work.flags = flags;
        }
    }
}

void WaterGrindRailSegment_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    WaterGrindRailSegment *trigger = (WaterGrindRailSegment *)rect2->parent;
    Player *player                 = (Player *)rect1->parent;

    if (trigger == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    player->objWork.flag &= ~STAGE_TASK_FLAG_ON_PLANE_B;
    player->gimmickFlag |= PLAYER_GIMMICK_USE_WATER_GRIND_SPARK;

    if ((player->grindID & ~PLAYER_GRIND_ACTIVE) != trigger->gameWork.mapObject->flags + 1)
    {
        if ((player->actionState < PLAYER_ACTION_GRIND || player->actionState > PLAYER_ACTION_GRINDTRICK_3_03)
            && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0 && (player->grindPrevRide & 2) == 0)
        {
            player->grindPrevRide |= 3;
            player->grindID = (trigger->gameWork.mapObject->flags & WATERGRINDTRIGGER_OBJFLAG_GRIND_ID_MASK) + 1;

            fx32 speed;
            switch (trigger->gameWork.mapObject->id)
            {
                case MAPOBJECT_236:
                case MAPOBJECT_238:
                default:
                    speed = player->topSpeed;
                    break;

                case MAPOBJECT_237:
                case MAPOBJECT_239:
                    speed = -player->topSpeed;
                    break;
            }
            Player__UseDashPanel(player, speed, FLOAT_TO_FX32(0.0));
        }
    }

    player->gimmickFlag |= PLAYER_GIMMICK_CHECK_GRIND_COLLISIONS;

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
    {
        switch (trigger->gameWork.mapObject->id)
        {
            case MAPOBJECT_236:
            case MAPOBJECT_238:
            default:
                if (player->objWork.groundVel < FLOAT_TO_FX32(2.0))
                {
                    player->objWork.groundVel = FLOAT_TO_FX32(2.0);
                    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
                }
                break;

            case MAPOBJECT_237:
            case MAPOBJECT_239:
                if (player->objWork.groundVel > -FLOAT_TO_FX32(2.0))
                {
                    player->objWork.groundVel = -FLOAT_TO_FX32(2.0);
                    player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                }
                break;
        }
    }
}

AnimatorSpriteDS *CreateWaterGrindRailManager(s32 id)
{
    s32 fileWorkID;
    s32 fileWorkID2;
    s32 i;
    AnimatorSpriteDS *animator;
    WaterGrindRailManager *work;
    Task *task;

    if (grindRailTaskSingleton[id] != NULL)
    {
        work = TaskGetWork(grindRailTaskSingleton[id], WaterGrindRailManager);
        work->instanceCount++;
        return work->animators;
    }

    task = CreateStageTask(WaterGrindRailManager_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_GROUP(2), WaterGrindRailManager);

    if (task == HeapNull)
        return NULL;

    grindRailTaskSingleton[id] = task;

    work = TaskGetWork(grindRailTaskSingleton[id], WaterGrindRailManager);
    TaskInitWork8(work);
    fileWorkID  = OBJDATAWORK_173 + id * 5 * 2;
    fileWorkID2 = fileWorkID + 1;

    work->objWork.objType = STAGE_OBJ_TYPE_DECORATION;
    work->instanceID      = id;
    work->instanceCount += 1;
    work->objWork.moveFlag |= (STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT);
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

    animator = &work->animators[0];
    i        = 0;
    do
    {
        ObjAction2dBACLoad(animator, "/act/ac_gmk_water_graind.bac", OBJ_DATA_GFX_NONE, GetObjectFileWork(OBJDATAWORK_172), gameArchiveStage);

        animator->vramPixels[GRAPHICS_ENGINE_A] = ObjActionAllocSprite(GetObjectFileWork(fileWorkID + i * 2), GRAPHICS_ENGINE_A, grindRailSpriteSize[i]);
        animator->vramPixels[GRAPHICS_ENGINE_B] = ObjActionAllocSprite(GetObjectFileWork(fileWorkID2 + i * 2), GRAPHICS_ENGINE_B, grindRailSpriteSize[i]);

        animator->work.cParam.palette = ObjDrawAllocSpritePalette(animator->work.fileData, WATERGUN_ANI_GUN_WATER_TRAIL_STRAIGHT + i, 93);
        animator->cParam[GRAPHICS_ENGINE_A].palette = animator->cParam[GRAPHICS_ENGINE_B].palette = animator->work.cParam.palette;

        animator->work.flags |= (ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_DISABLE_PALETTES);
        AnimatorSpriteDS__SetAnimation(animator, WATERGUN_ANI_GUN_WATER_TRAIL_STRAIGHT + i);
        StageTask__SetOAMOrder(&animator->work, SPRITE_ORDER_23);
        StageTask__SetOAMPriority(&animator->work, SPRITE_PRIORITY_2);

        ++i;
        ++animator;
    } while (i < (s32)ARRAY_COUNT(work->animators));

    StageTask__SetOAMOrder(&work->animators[2].work, SPRITE_ORDER_22);

    SetTaskOutFunc(&work->objWork, WaterGrindRailManager_Draw);

    return work->animators;
}

void DestroyWaterGrindRailManager(s32 id)
{
    Task *task = grindRailTaskSingleton[id];
    if (task == NULL)
        return;

    WaterGrindRailManager *work = TaskGetWork(task, WaterGrindRailManager);
    work->instanceCount--;

    if (work->instanceCount == 0)
    {
        work->objWork.flag |= STAGE_TASK_FLAG_DESTROY_NEXT_FRAME;
        ReleaseWaterGrindRailManager(work);
    }
}

void WaterGrindRailManager_Destructor(Task *task)
{
    WaterGrindRailManager *work = TaskGetWork(task, WaterGrindRailManager);

    if (grindRailTaskSingleton[work->instanceID] == task)
        ReleaseWaterGrindRailManager(work);

    StageTask_Destructor(task);
}

void ReleaseWaterGrindRailManager(WaterGrindRailManager *work)
{
    s32 i;
    s32 fileWorkID = OBJDATAWORK_173 + 10 * work->instanceID;

    for (i = 0; i < (s32)ARRAY_COUNT(work->animators); i++)
    {
        AnimatorSpriteDS *animator = &work->animators[i];

        ObjDrawReleaseSpritePalette(animator->work.cParam.palette);
        ObjActionReleaseSpriteDS(GetObjectFileWork(fileWorkID));
        animator->vramPixels[GRAPHICS_ENGINE_A] = NULL;
        animator->vramPixels[GRAPHICS_ENGINE_B] = NULL;
        ObjAction2dBACRelease(GetObjectFileWork(OBJDATAWORK_172), animator);

        fileWorkID += 2;
    }

    grindRailTaskSingleton[work->instanceID] = NULL;
}

AnimatorSpriteDS *GetWaterGrindRailManagerAnimators(u16 id)
{
    Task *task = grindRailTaskSingleton[id];

    AnimatorSpriteDS *animators = NULL;
    if (task != NULL)
    {
        WaterGrindRailManager *work = TaskGetWork(task, WaterGrindRailManager);
        animators                   = work->animators;
    }

    return animators;
}

void WaterGrindRailManager_Draw(void)
{
    WaterGrindRailManager *work = TaskGetWorkCurrent(WaterGrindRailManager);

    for (s32 i = 0; i < (s32)ARRAY_COUNT(work->animators); i++)
    {
        AnimatorSpriteDS__ProcessAnimationFast(&work->animators[i]);
    }
}