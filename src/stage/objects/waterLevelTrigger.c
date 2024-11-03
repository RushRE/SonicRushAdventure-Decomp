#include <stage/objects/waterLevelTrigger.h>
#include <game/stage/mapSys.h>
#include <game/stage/gameSystem.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

// used in Spikes
#define mapObjectParam_waterLevelDigit1 mapObject->left
#define mapObjectParam_waterLevelDigit2 mapObject->top
#define mapObjectParam_waterLevelDigit3 mapObject->width

// --------------------
// ENUMS
// --------------------

enum WaterLevelTriggerObjectFlags
{
    WATERLEVELTRIGGER_OBJFLAG_1  = 1 << 0,
    WATERLEVELTRIGGER_OBJFLAG_2  = 1 << 1,
    WATERLEVELTRIGGER_OBJFLAG_4  = 1 << 2,
    WATERLEVELTRIGGER_OBJFLAG_8  = 1 << 3,
    WATERLEVELTRIGGER_OBJFLAG_10 = 1 << 4,
    WATERLEVELTRIGGER_OBJFLAG_20 = 1 << 5,
};

enum WaterLevelTriggerActivateMode
{
    WATERLEVELTRIGGER_MODE_RESET,
    WATERLEVELTRIGGER_MODE_SET,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void WaterLevelTrigger_State_Active(WaterLevelTrigger *work);
static void WaterLevelTrigger_SetupWaterLevel(fx32 x, u16 waterLevel, u16 flags, s8 *targetPlayers);

// --------------------
// FUNCTIONS
// --------------------

WaterLevelTrigger *CreateWaterLevelTrigger(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task;
    WaterLevelTrigger *work;

    u32 waterLevel = 10000 * mapObjectParam_waterLevelDigit1 + 100 * mapObjectParam_waterLevelDigit2 + mapObjectParam_waterLevelDigit3;
    if (waterLevel > MAPSYS_WATERLEVEL_NONE)
        waterLevel = MAPSYS_WATERLEVEL_NONE;

    s8 targetPlayers[2];
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        targetPlayers[1] = mapCamera.camera[0].targetPlayerID;
        targetPlayers[0] = mapCamera.camera[0].targetPlayerID;
    }
    else
    {
        targetPlayers[0] = mapCamera.camera[0].targetPlayerID;
        targetPlayers[1] = mapCamera.camera[1].targetPlayerID;
    }

    task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), WaterLevelTrigger);

    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, WaterLevelTrigger);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;

    work->waterLevel       = waterLevel;
    work->targetPlayers[0] = targetPlayers[0];
    work->targetPlayers[1] = targetPlayers[1];

    if ((mapObject->flags & (WATERLEVELTRIGGER_OBJFLAG_4 | WATERLEVELTRIGGER_OBJFLAG_8)) != 0)
        WaterLevelTrigger_SetupWaterLevel(x, waterLevel, mapObject->flags, targetPlayers);
    else
        SetTaskState(&work->gameWork.objWork, WaterLevelTrigger_State_Active);

    return work;
}

void WaterLevelTrigger_State_Active(WaterLevelTrigger *work)
{
    for (s32 i = 0; i < GRAPHICS_ENGINE_COUNT; i++)
    {
        MapSysCamera *camera = &mapCamera.camera[i];

        if (work->targetPlayers[i] >= 0)
        {
            u32 mode;
            if (gPlayerList[work->targetPlayers[i]]->objWork.position.x < work->gameWork.objWork.position.x)
            {
                if ((work->gameWork.mapObject->flags & WATERLEVELTRIGGER_OBJFLAG_1) != 0)
                    mode = WATERLEVELTRIGGER_MODE_RESET;
                else
                    mode = WATERLEVELTRIGGER_MODE_SET;
            }
            else
            {
                if ((work->gameWork.mapObject->flags & WATERLEVELTRIGGER_OBJFLAG_1) != 0)
                    mode = WATERLEVELTRIGGER_MODE_SET;
                else
                    mode = WATERLEVELTRIGGER_MODE_RESET;
            }

            switch (mode)
            {
                // case WATERLEVELTRIGGER_MODE_SET:
                default:
                    camera->flags |= MAPSYS_CAMERA_FLAG_1000000;
                    camera->waterLevel = work->waterLevel;

                    if ((work->gameWork.mapObject->flags & WATERLEVELTRIGGER_OBJFLAG_10) != 0)
                        camera->flags |= MAPSYS_CAMERA_FLAG_2000000;
                    break;

                case WATERLEVELTRIGGER_MODE_RESET:
                    if ((work->gameWork.mapObject->flags & WATERLEVELTRIGGER_OBJFLAG_20) == 0)
                    {
                        camera->flags &= ~(MAPSYS_CAMERA_FLAG_1000000 | MAPSYS_CAMERA_FLAG_2000000);
                        camera->waterLevel = MAPSYS_WATERLEVEL_NONE;
                    }
                    break;
            }
        }
    }
}

void WaterLevelTrigger_SetupWaterLevel(fx32 x, u16 waterLevel, u16 flags, s8 *targetPlayers)
{
    for (s32 i = 0; i < 2; i++)
    {
        MapSysCamera *camera = &mapCamera.camera[i];

        s8 targetPlayer = targetPlayers[i];
        if (targetPlayer >= 0)
        {
            if (x >= gPlayerList[targetPlayer]->objWork.position.x - FLOAT_TO_FX32(64.0) && x <= gPlayerList[targetPlayer]->objWork.position.x + FLOAT_TO_FX32(64.0))
            {
                camera->flags |= MAPSYS_CAMERA_FLAG_1000000;
                camera->waterLevel = waterLevel;

                camera->flags &= ~MAPSYS_CAMERA_FLAG_2000000;
                if ((flags & WATERLEVELTRIGGER_OBJFLAG_10) != 0)
                    camera->flags |= MAPSYS_CAMERA_FLAG_2000000;
            }
        }
    }
}