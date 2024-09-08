#include <stage/objects/missionFlag.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>
#include <game/object/obj.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_flagID             mapObject->left
#define mapObjectParam_rewardSeconds      mapObject->top
#define mapObjectParam_rewardMilliseconds mapObject->width
#define mapObjectParam_totalFlagCount     mapObject->height

// --------------------
// MACROS
// --------------------

#define MISSIONFLAG_GET_REWARD_TIME(seconds, msecs) 60 * (seconds) + 6000 * (msecs)

// --------------------
// ENUMS
// --------------------

enum MissionFlagState
{
    MISSIONFLAG_STATE_NUMBER_SCALE_IN,
    MISSIONFLAG_STATE_SHOW_NUMBER,
    MISSIONFLAG_STATE_NUMBER_SCALE_OUT,
    MISSIONFLAG_STATE_HIDE_NUMBER,
};

enum MissionFlagAnimIDs
{
    MISSIONFLAG_ANI_FLAG,
    MISSIONFLAG_ANI_NUM_0,
    MISSIONFLAG_ANI_NUM_1,
    MISSIONFLAG_ANI_NUM_2,
    MISSIONFLAG_ANI_NUM_3,
    MISSIONFLAG_ANI_NUM_4,
    MISSIONFLAG_ANI_NUM_5,
    MISSIONFLAG_ANI_NUM_6,
    MISSIONFLAG_ANI_NUM_7,
    MISSIONFLAG_ANI_NUM_8,
    MISSIONFLAG_ANI_NUM_9,
    MISSIONFLAG_ANI_LAST_FLAG_PALETTE,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void MissionFlag_Destructor(Task *task);
static void MissionFlag_State_Passed(MissionFlag *work);
static void MissionFlag_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void MissionFlag_Draw(void);

// --------------------
// FUNCTIONS
// --------------------

MissionFlag *CreateMissionFlag(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    MissionFlag *work;
    s32 d;
    u32 digits[2] = { 0, 0 };

    if (gameState.gameMode != GAMEMODE_MISSION || gameState.missionType != MISSION_TYPE_PASS_FLAGS)
    {
        DestroyMapObject(mapObject);
        return NULL;
    }

    if (mapObjectParam_flagID <= 0)
    {
        playerGameStatus.missionStatus.stageTimeLimit = MISSIONFLAG_GET_REWARD_TIME(mapObjectParam_rewardSeconds, mapObjectParam_rewardMilliseconds);
        playerGameStatus.missionStatus.quota          = MTM_MATH_CLIP_U32(mapObjectParam_totalFlagCount, 1, 99);

        DestroyMapObject(mapObject);
        return NULL;
    }

    Task *task = CreateStageTask(MissionFlag_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, MissionFlag);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, MissionFlag);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_flag.bac", GetObjectDataWork(OBJDATAWORK_104), gameArchiveMission, 32);
    if (mapObjectParam_flagID == playerGameStatus.missionStatus.quota)
        ObjActionAllocSpritePalette(&work->gameWork.objWork, MISSIONFLAG_ANI_LAST_FLAG_PALETTE, 103);
    else
        ObjActionAllocSpritePalette(&work->gameWork.objWork, MISSIONFLAG_ANI_FLAG, 91);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, MISSIONFLAG_ANI_FLAG);

    digits[1] = FX_DivS32(mapObjectParam_flagID, 10);
    digits[0] = mapObjectParam_flagID - 10 * digits[1];

    AnimatorSpriteDS *aniDigit = work->aniDigit;
    for (d = 0; d < 2; d++)
    {
        ObjAction2dBACLoad(aniDigit, "/act/ac_gmk_flag.bac", 4, GetObjectDataWork(OBJDATAWORK_104), gameArchiveMission);
        aniDigit->cParam[0].palette = aniDigit->cParam[1].palette = aniDigit->work.palette = work->gameWork.objWork.obj_2d->ani.work.palette;

        aniDigit->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
        AnimatorSpriteDS__SetAnimation(aniDigit, digits[d] + MISSIONFLAG_ANI_NUM_0);
        StageTask__SetOAMOrder(&aniDigit->work, SPRITE_ORDER_23);
        StageTask__SetOAMPriority(&aniDigit->work, SPRITE_PRIORITY_2);

        aniDigit++;
    }

    if (digits[1] != 0)
    {
        work->digitCount         = 2;
        work->digitPosition[0].x = FLOAT_TO_FX32(22.0);
        work->digitPosition[0].y = -FLOAT_TO_FX32(27.0);
        work->digitPosition[1].x = FLOAT_TO_FX32(10.0);
        work->digitPosition[1].y = -FLOAT_TO_FX32(27.0);
    }
    else
    {
        work->digitCount         = 1;
        work->digitPosition[0].x = FLOAT_TO_FX32(17.0);
        work->digitPosition[0].y = -FLOAT_TO_FX32(27.0);
    }

    if (mapObjectParam_flagID > playerGameStatus.missionStatus.passedFlagID)
    {
        ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);
        ObjRect__SetDefenceStat(work->gameWork.colliders, ~1, 0);
        ObjRect__SetOnDefend(&work->gameWork.colliders[0], MissionFlag_OnDefend);
        work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;
    }
    else
    {
        work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_800;
        work->gameWork.flags |= 1;
    }

    work->scale = FLOAT_TO_FX32(1.0);
    SetTaskOutFunc(&work->gameWork.objWork, MissionFlag_Draw);

    return work;
}

void MissionFlag_Destructor(Task *task)
{
    MissionFlag *work = TaskGetWork(task, MissionFlag);

    for (s32 i = 0; i < 2; i++)
    {
        ObjAction2dBACRelease(GetObjectFileWork(OBJDATAWORK_104), &work->aniDigit[i]);
    }

    GameObject__Destructor(task);
}

void MissionFlag_State_Passed(MissionFlag *work)
{
    switch (work->gameWork.objWork.userWork)
    {
        case MISSIONFLAG_STATE_NUMBER_SCALE_IN:
            work->scale = ObjDiffSet(work->scale, FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(1.0), 1, FLOAT_TO_FX32(0.3125), FLOAT_TO_FX32(0.1875));
            if (work->scale == FLOAT_TO_FX32(2.0))
            {
                work->gameWork.objWork.userWork++;
                work->gameWork.objWork.userTimer = 16;
            }
            break;

        case MISSIONFLAG_STATE_SHOW_NUMBER:
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer <= 0)
                work->gameWork.objWork.userWork++;
            break;

        case MISSIONFLAG_STATE_NUMBER_SCALE_OUT:
            if (work->scale <= FLOAT_TO_FX32(1.0))
            {
                work->aniDigit[0].work.flags &= ~ANIMATOR_FLAG_ENABLE_SCALE;
                work->aniDigit[1].work.flags &= ~ANIMATOR_FLAG_ENABLE_SCALE;
                work->gameWork.objWork.userWork++;
            }
            // fallthrough

        case MISSIONFLAG_STATE_HIDE_NUMBER:
            work->scale = ObjShiftSet(work->scale, FLOAT_TO_FX32(0.0), 1, FLOAT_TO_FX32(0.09375), FLOAT_TO_FX32(0.015625));
            if (work->scale == FLOAT_TO_FX32(0.0))
            {
                SetTaskState(&work->gameWork.objWork, NULL);
                work->gameWork.flags |= 1;
            }
            break;

        default:
            break;
    }
}

void MissionFlag_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    MissionFlag *flag = (MissionFlag *)rect2->parent;
    Player *player    = (Player *)rect1->parent;

    if (flag == NULL || player == NULL || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER || CheckIsPlayer1(player) == FALSE)
        return;

    if (flag->gameWork.mapObjectParam_flagID == playerGameStatus.missionStatus.passedFlagID + 1)
    {
        playerGameStatus.missionStatus.stageTimeLimit =
            playerGameStatus.stageTimer + MISSIONFLAG_GET_REWARD_TIME(flag->gameWork.mapObjectParam_rewardSeconds, flag->gameWork.mapObjectParam_rewardMilliseconds);
        playerGameStatus.missionStatus.passedFlagID++;

        flag->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_800;
        flag->aniDigit[0].work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
        flag->aniDigit[1].work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;

        SetTaskState(&flag->gameWork.objWork, MissionFlag_State_Passed);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ITEM_BREAK);
    }
}

void MissionFlag_Draw(void)
{
    s32 d;
    VecFx32 position;
    VecFx32 scale;

    MissionFlag *work = TaskGetWorkCurrent(MissionFlag);

    position.z = FLOAT_TO_FX32(0.0);
    scale.z    = FLOAT_TO_FX32(1.0);

    // Check if digits are visible
    if ((work->gameWork.flags & 1) == 0)
    {
        // Draw digits
        for (d = 0; d < work->digitCount; d++)
        {
            u32 displayFlag = work->gameWork.objWork.displayFlag;
            position.x      = work->gameWork.objWork.position.x + work->digitPosition[d].x;
            position.y      = work->gameWork.objWork.position.y + work->digitPosition[d].y;
            scale.x = scale.y = work->scale;

            StageTask__Draw2DEx(&work->aniDigit[d], &position, NULL, &scale, &displayFlag, NULL, NULL);
        }
    }

    // Draw flag
    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);
}
