#include <stage/objects/bgUnknownTrigger.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/stage/mapFarSys.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

// TODO: actual names
#define mapObjectParam_left   mapObject->left
#define mapObjectParam_top    mapObject->top
#define mapObjectParam_width  mapObject->width
#define mapObjectParam_height mapObject->height

// --------------------
// ENUMS
// --------------------

enum Unknown1ObjectFlags
{
    BGUNKNOWNTRIGGER_OBJFLAG_NONE,

    BGUNKNOWNTRIGGER_OBJFLAG_USE_Y      = 1 << 0,
    BGUNKNOWNTRIGGER_OBJFLAG_FLIPPED    = 1 << 1,
    BGUNKNOWNTRIGGER_OBJFLAG_APPLY_ONCE = 1 << 2,
    BGUNKNOWNTRIGGER_OBJFLAG_USE_PLAYER = 1 << 3,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void BGUnknownTrigger_State_Active(BGUnknownTrigger *work);
static BOOL BGUnknownTrigger_CheckBounds(BGUnknownTrigger *work, MapSysCamera *camera);

// --------------------
// FUNCTIONS
// --------------------

BGUnknownTrigger *CreateBGUnknownTrigger(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task;
    BGUnknownTrigger *work;
    fx32 mx = -1;
    fx32 my = -1;
    s32 i;

    if ((mapObject->flags & BGUNKNOWNTRIGGER_OBJFLAG_USE_Y) != 0)
        my = 10000 * mapObjectParam_left + 100 * mapObjectParam_top + mapObjectParam_width;
    else
        mx = 10000 * mapObjectParam_left + 100 * mapObjectParam_top + mapObjectParam_width;

    if ((mapObject->flags & BGUNKNOWNTRIGGER_OBJFLAG_APPLY_ONCE) != 0)
    {
        if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
        {
            MapFarSys__Func_200B524(mx, my, mapObjectParam_height, GRAPHICS_ENGINE_A);
        }
        else
        {
            MapFarSys__Func_200B524(mx, my, mapObjectParam_height, GRAPHICS_ENGINE_A);
            MapFarSys__Func_200B524(mx, my, mapObjectParam_height, GRAPHICS_ENGINE_B);
        }

        DestroyMapObject(mapObject);

        return NULL;
    }

    task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, BGUnknownTrigger);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, BGUnknownTrigger);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
    work->unknown.x = mx;
    work->unknown.y = my;

    if ((mapObject->flags & BGUNKNOWNTRIGGER_OBJFLAG_USE_PLAYER) != 0)
    {
        s8 targetPlayer[2];

        if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
        {
            targetPlayer[0] = mapCamera.camera[0].targetPlayerID;
            targetPlayer[1] = -1;
        }
        else
        {
            targetPlayer[0] = mapCamera.camera[0].targetPlayerID;
            targetPlayer[1] = mapCamera.camera[1].targetPlayerID;
        }

        for (i = 0; i < 2; i++)
        {
            s8 target = targetPlayer[i];
            if (target >= 0)
            {
                Player *player = gPlayerList[target];

                if (player->objWork.position.x >= work->gameWork.objWork.position.x - FLOAT_TO_FX32(64.0)
                    && player->objWork.position.x <= work->gameWork.objWork.position.x + FLOAT_TO_FX32(64.0))
                {
                    if (player->objWork.position.y >= work->gameWork.objWork.position.y - FLOAT_TO_FX32(64.0)
                        && player->objWork.position.y <= work->gameWork.objWork.position.y + FLOAT_TO_FX32(64.0))
                    {
                        MapFarSys__Func_200B524(mx, my, mapObjectParam_height, i);
                    }
                }
            }
        }
    }
    else
    {
        SetTaskState(&work->gameWork.objWork, BGUnknownTrigger_State_Active);
    }

    return work;
}

void BGUnknownTrigger_State_Active(BGUnknownTrigger *work)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        if (BGUnknownTrigger_CheckBounds(work, MapSys__GetCameraA()))
            MapFarSys__Func_200B524(work->unknown.x, work->unknown.y, work->gameWork.mapObjectParam_height, GRAPHICS_ENGINE_A);
    }
    else
    {
        for (s32 i = 0; i < GRAPHICS_ENGINE_COUNT; i++)
        {
            if (BGUnknownTrigger_CheckBounds(work, &mapCamera.camera[i]))
                MapFarSys__Func_200B524(work->unknown.x, work->unknown.y, work->gameWork.mapObjectParam_height, i);
        }
    }
}

BOOL BGUnknownTrigger_CheckBounds(BGUnknownTrigger *work, MapSysCamera *camera)
{
    BOOL inBounds = FALSE;

    if ((work->gameWork.mapObject->flags & BGUNKNOWNTRIGGER_OBJFLAG_USE_Y) != 0)
    {
        if ((work->gameWork.mapObject->flags & BGUNKNOWNTRIGGER_OBJFLAG_FLIPPED) != 0)
        {
            if (camera->disp_pos.y < (u32)FX32_FROM_WHOLE(work->unknown.y))
                inBounds = TRUE;
        }
        else
        {
            if (camera->disp_pos.y >= (u32)FX32_FROM_WHOLE(work->unknown.y))
                inBounds = TRUE;
        }
    }
    else
    {
        if ((work->gameWork.mapObject->flags & BGUNKNOWNTRIGGER_OBJFLAG_FLIPPED) != 0)
        {
            if (camera->disp_pos.x < (u32)FX32_FROM_WHOLE(work->unknown.x))
                inBounds = TRUE;
        }
        else
        {
            if (camera->disp_pos.x >= (u32)FX32_FROM_WHOLE(work->unknown.x))
                inBounds = TRUE;
        }
    }

    return inBounds;
}