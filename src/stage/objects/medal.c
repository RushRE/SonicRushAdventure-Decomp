#include <stage/objects/medal.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>
#include <stage/core/hud.h>
#include <stage/core/ringManager.h>
#include <stage/objects/goalChest.h>

// --------------------
// ENUMS
// --------------------

enum MedalObjectFlags
{
	MISSIONRING_OBJFLAG_DISABLED = 1 << 14,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void Medal_State_Active(Medal *work);

// --------------------
// FUNCTIONS
// --------------------

Medal *CreateMedal(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (gameState.gameMode != GAMEMODE_MISSION || gameState.missionType != MISSION_TYPE_FIND_MEDAL)
    {
        DestroyMapObject(mapObject);
        return NULL;
    }

    if (playerGameStatus.missionStatus.quota >= MEDAL_STAGE_MAX || (mapObject->flags & MISSIONRING_OBJFLAG_DISABLED) == 0)
    {
        DestroyMapObject(mapObject);
        return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, Medal);
    if (task == HeapNull)
        return NULL;

    Medal *work = TaskGetWork(task, Medal);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DESTROY_ON_COLLIDE;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/ac_itm_ring.bac", GetObjectFileWork(OBJDATAWORK_105), gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, RING_ANI_RING, 113);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, RING_ANI_SPARKLE);

    // increment quota and set id (this is never used in the retail rom)
    work->gameWork.objWork.userWork = playerGameStatus.missionStatus.quota;
    playerGameStatus.missionStatus.quota++;

    SetTaskState(&work->gameWork.objWork, Medal_State_Active);

    return work;
}

void Medal_State_Active(Medal *work)
{
    // only spawn goal chest if the target medal has been set to this medal 
    // (this is always true in the retail rom, because there's only ever 1 medal and the target (quotaTarget is always set to 0))
    if (work->gameWork.objWork.userWork == FX_ModS32(playerGameStatus.missionStatus.quotaTarget, playerGameStatus.missionStatus.quota))
    {
        // spawn goal chest and indicator
        GoalChest *goal = SpawnStageObjectEx(MAPOBJECT_113, work->gameWork.objWork.position.x, work->gameWork.objWork.position.y, GoalChest, 0, 0, 0, 0, 0, 1);
        if (goal != NULL)
            CreateTargetIndicatorHUD(&goal->gameWork.objWork);

        SetTaskState(&work->gameWork.objWork, NULL);
    }
    
    work->gameWork.flags |= 0x10000;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DESTROYED | STAGE_TASK_FLAG_2;
}
