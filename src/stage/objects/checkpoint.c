#include <stage/objects/checkpoint.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>
#include <stage/core/hud.h>
#include <game/graphics/drawFadeTask.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_checkpointID mapObject->flags
#define mapObjectParam_lapMarkerUnknown mapObject->left
#define mapObjectParam_lapMarkerYSize mapObject->top

// --------------------
// FUNCTION DECLS
// --------------------

static void Checkpoint_State_Active(Checkpoint *work);
static void Checkpoint_OnDefend_AwaitPlayer(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Checkpoint_OnDefend_Activated(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void InitCheckpointForLaps(Checkpoint *work);
static void Checkpoint_State_LapMarker(Checkpoint *work);
static void Checkpoint_State_FinishedLaps(Checkpoint *work);
static void InitCheckpointForAwardRings(Checkpoint *work);
static void Checkpoint_State_AwardRings(Checkpoint *work);
static void HandleLapCheckpointInteractions(Checkpoint *work);
static BOOL CheckPlayerPassedLapCheckpoint(Checkpoint *work, Player *player);

// --------------------
// FUNCTIONS
// --------------------

Checkpoint *CreateCheckpoint(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // - destroy the checkpoint if we're in a mission that ISN"T a "reach the goal within the time limit" type
    // - destroy the checkpoint if it's the alternate variant and we're not in a vs battle
    if ((gameState.gameMode == GAMEMODE_MISSION && gameState.missionType != MISSION_TYPE_REACH_GOAL_TIME_LIMIT)
        || (mapObject->id == MAPOBJECT_270 && gameState.gameMode != GAMEMODE_VS_BATTLE))
    {
        DestroyMapObject(mapObject);
        return NULL;
    }

    // also destroy the checkpoint if it's the alternate variant anyways /shrug
    if (mapObject->id == MAPOBJECT_270)
    {
        DestroyMapObject(mapObject);
        return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, Checkpoint);
    if (task == HeapNull)
        return NULL;

    Checkpoint *work = TaskGetWork(task, Checkpoint);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/ac_gmk_check.bac", GetObjectFileWork(OBJDATAWORK_72), gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, CHECKPOINT_ANI_IDLE, 91);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, CHECKPOINT_ANI_IDLE);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    if (Player__UseUpsideDownGravity(work->gameWork.objWork.position.x, work->gameWork.objWork.position.y))
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

    ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);
    ObjRect__SetDefenceStat(work->gameWork.colliders, ~1, 0);

    ObjRect__SetOnDefend(&work->gameWork.colliders[0], Checkpoint_OnDefend_AwaitPlayer);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    SetTaskState(&work->gameWork.objWork, Checkpoint_State_Active);

    if (gmCheckRingBattle())
    {
        InitCheckpointForAwardRings(work);
    }
    else if (gmCheckRaceStage())
    {
        InitCheckpointForLaps(work);
    }

    return work;
}

void Checkpoint_State_Active(Checkpoint *work)
{
    OBS_ACTION2D_BAC_WORK *ani = work->gameWork.objWork.obj_2d;
    if (!ani->ani.work.animID && playerGameStatus.recallCheckpointID >= (s32)(u8)work->gameWork.mapObjectParam_checkpointID
        || ani->ani.work.animID == CHECKPOINT_ANI_ACTIVATING && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        StageTask__SetAnimation(&work->gameWork.objWork, CHECKPOINT_ANI_ACTIVATED);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    }
}

void Checkpoint_OnDefend_AwaitPlayer(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Checkpoint *checkpoint = (Checkpoint *)rect2->parent;
    Player *player         = (Player *)rect1->parent;

    if (checkpoint == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER || CheckIsPlayer1(player) == FALSE)
        return;

    s16 bottom               = player->objWork.hitboxRect.bottom;
    PlayerGameStatus *status = &playerGameStatus;

    status->spawnPosition.x = checkpoint->gameWork.objWork.position.x;

    if ((checkpoint->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) == 0)
        status->spawnPosition.y = checkpoint->gameWork.objWork.position.y - FX32_FROM_WHOLE(bottom);
    else
        status->spawnPosition.y = checkpoint->gameWork.objWork.position.y + FX32_FROM_WHOLE(bottom);

    status->recallCheckpointID    = checkpoint->gameWork.mapObjectParam_checkpointID;
    status->recallWaterLevel = mapCamera.camera[player->cameraID].waterLevel;
    status->recallTime       = status->stageTimer;
    Player__GiveTension(player, PLAYER_TENSION_CHECKPOINT);

    if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
    {
        status->speedBonus += PLAYER_SPEEDBONUS_SUPERBOOST;
    }
    else if ((player->playerFlag & PLAYER_FLAG_BOOST) != 0)
    {
        status->speedBonus += PLAYER_SPEEDBONUS_BOOST;
    }
    else if (player->objWork.move.x >= player->spdThresholdRun)
    {
        status->speedBonus += PLAYER_SPEEDBONUS_RUN;
    }
    status->speedBonusCount++;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CHECK_POINT);

    if (gameState.gameMode == GAMEMODE_TIMEATTACK)
        CreateCheckpointTimeHUD(status->recallTime);

    checkpoint->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    StageTask__SetAnimation(&checkpoint->gameWork.objWork, CHECKPOINT_ANI_ACTIVATING);
}

void Checkpoint_OnDefend_Activated(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    // Nothin'
}

void InitCheckpointForLaps(Checkpoint *work)
{
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    ObjRect__SetOnDefend(&work->gameWork.colliders[0], Checkpoint_OnDefend_Activated);

    if (work->gameWork.mapObjectParam_lapMarkerUnknown != 0)
    {
        SetTaskState(&work->gameWork.objWork, NULL);
    }
    else
    {
        SetTaskState(&work->gameWork.objWork, Checkpoint_State_LapMarker);
        playerGameStatus.lapMarkerPos = work->gameWork.objWork.position.x;
    }
}

void Checkpoint_State_LapMarker(Checkpoint *work)
{
    Player *player = gPlayer;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        StageTask__SetAnimation(&work->gameWork.objWork, CHECKPOINT_ANI_IDLE);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
    }

    HandleLapCheckpointInteractions(work);

    if (CheckPlayerPassedLapCheckpoint(work, player))
    {
        CreateCheckpointTimeHUD(playerGameStatus.stageTimer - playerGameStatus.recallTime);
        AddLapTimeToHUD(work->gameWork.objWork.userTimer - 1, playerGameStatus.stageTimer - playerGameStatus.recallTime);
        playerGameStatus.recallTime = playerGameStatus.stageTimer;

        if (work->gameWork.objWork.userTimer == CHECKPOINT_LAP_COUNT)
        {
            SetTaskState(&work->gameWork.objWork, Checkpoint_State_FinishedLaps);
            Player__Action_FinishMission(player, &work->gameWork);
            work->gameWork.objWork.userFlag = 120;
        }

        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CHECK_POINT);
    }
}

void Checkpoint_State_FinishedLaps(Checkpoint *work)
{
    if (work->gameWork.objWork.userFlag != 0)
    {
        work->gameWork.objWork.userFlag--;
        if (work->gameWork.objWork.userFlag == 0)
        {
            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(1.0));
            SendPacketForStageFinishEvent();
        }
    }
    else if (IsDrawFadeTaskFinished())
    {
        playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_CAN_CHANGE_EVENT;
        SetTaskState(&work->gameWork.objWork, NULL);
    }
}

void InitCheckpointForAwardRings(Checkpoint *work)
{
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], Checkpoint_OnDefend_Activated);
    SetTaskState(&work->gameWork.objWork, Checkpoint_State_AwardRings);
}

void Checkpoint_State_AwardRings(Checkpoint *work)
{
    Player *player = gPlayer;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        StageTask__SetAnimation(&work->gameWork.objWork, CHECKPOINT_ANI_IDLE);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
    }

    if (work->gameWork.objWork.userFlag != 0)
    {
        work->gameWork.objWork.userFlag--;
        if ((work->gameWork.objWork.userFlag & 1) == 0)
            Player__GiveRings(player, 1);
    }

    if (CheckPlayerPassedLapCheckpoint(work, player))
        work->gameWork.objWork.userFlag = 19;
}

void HandleLapCheckpointInteractions(Checkpoint *work)
{
    u32 p;

    if ((gPlayer->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
    {
        s32 lapCounterStore = playerGameStatus.playerLapCounter[0];
        s32 targetLapsStore = playerGameStatus.playerTargetLaps[0];

        s32 playerCount = Player__GetPlayerCount();
        if (gameState.gameMode == GAMEMODE_TIMEATTACK)
            playerCount = 1;

        for (p = 0; p < playerCount; p++)
        {
            Player *player = gPlayerList[p];
            if ((player->playerFlag & PLAYER_FLAG_DEATH) == 0)
            {
                work->gameWork.objWork.userTimer = playerGameStatus.playerLapCounter[p];
                work->gameWork.objWork.userWork  = playerGameStatus.playerTargetLaps[p];

                CheckPlayerPassedLapCheckpoint(work, player);

                playerGameStatus.playerLapCounter[p] = work->gameWork.objWork.userTimer;
                playerGameStatus.playerTargetLaps[p] = work->gameWork.objWork.userWork;
            }
        }

        work->gameWork.objWork.userTimer = lapCounterStore;
        work->gameWork.objWork.userWork  = targetLapsStore;
    }
}

BOOL CheckPlayerPassedLapCheckpoint(Checkpoint *work, Player *player)
{
    BOOL completedLap = FALSE;

    if (work->gameWork.mapObjectParam_lapMarkerYSize != 0 && work->gameWork.objWork.position.y + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_lapMarkerYSize << 1) > player->objWork.position.y)
        return completedLap;

    if (work->gameWork.objWork.position.y + FLOAT_TO_FX32(32.0) > player->objWork.position.y)
    {
        if (work->gameWork.objWork.position.x >= player->objWork.prevPosition.x && work->gameWork.objWork.position.x < player->objWork.position.x)
        {
            // increment lap counter
            work->gameWork.objWork.userTimer++;
            if (work->gameWork.objWork.userTimer > work->gameWork.objWork.userWork)
            {
                completedLap                    = TRUE;
                work->gameWork.objWork.userWork = work->gameWork.objWork.userTimer;
                StageTask__SetAnimation(&work->gameWork.objWork, CHECKPOINT_ANI_ACTIVATING);
                work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;
            }
        }
        else
        {
            if (work->gameWork.objWork.position.x <= player->objWork.prevPosition.x && work->gameWork.objWork.position.x > player->objWork.position.x)
            {
                // decrement lap counter
                if (work->gameWork.objWork.userWork == work->gameWork.objWork.userTimer)
                    work->gameWork.objWork.userTimer--;
            }
        }
    }

    return completedLap;
}
