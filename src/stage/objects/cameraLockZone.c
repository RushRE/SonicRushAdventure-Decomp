#include <stage/objects/cameraLockZone.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_left   mapObject->left
#define mapObjectParam_top    mapObject->top
#define mapObjectParam_width  mapObject->width
#define mapObjectParam_height mapObject->height

// --------------------
// ENUMS
// --------------------

enum CameraLockZoneObjectFlags
{
    CAMERALOCKZONE_OBJFLAG_NONE = 0x00,

    CAMERALOCKZONE_OBJFLAG_LOCK_L        = 1 << 0,
    CAMERALOCKZONE_OBJFLAG_LOCK_T        = 1 << 1,
    CAMERALOCKZONE_OBJFLAG_LOCK_R        = 1 << 2,
    CAMERALOCKZONE_OBJFLAG_LOCK_B        = 1 << 3,
    CAMERALOCKZONE_OBJFLAG_ALLOW_PLANE_A = 1 << 4,
    CAMERALOCKZONE_OBJFLAG_ALLOW_PLANE_B = 1 << 5,
};

enum CameraLockZoneFlags_
{
    CAMERALOCKZONE_FLAGS_NONE = 0x00,

    CAMERALOCKZONE_FLAGS_LOCK_L = 1 << 0,
    CAMERALOCKZONE_FLAGS_LOCK_T = 1 << 1,
    CAMERALOCKZONE_FLAGS_LOCK_R = 1 << 2,
    CAMERALOCKZONE_FLAGS_LOCK_B = 1 << 3,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void CameraLockZone_State_Active(CameraLockZone *work);
static void CameraLockZone_CameraState_ApplyStageBounds(CameraLockZone *work, s32 id);
static void CameraLockZone_CameraState_WaitForTriggerEnter(CameraLockZone *work, s32 id);
static void CameraLockZone_CameraState_ApplyLockedBounds(CameraLockZone *work, s32 id);
static void CameraLockZone_CameraState_WaitForTriggerExit(CameraLockZone *work, s32 id);
static BOOL CheckPlayerInTriggerBounds(CameraLockZone *work, s32 id);

// --------------------
// FUNCTIONS
// --------------------

CameraLockZone *CreateCameraLockZone(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task;
    CameraLockZone *work;
    s32 i;
    s32 cameraCount;

    task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), CameraLockZone);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, CameraLockZone);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        cameraCount                                  = 1;
        work->camera[GRAPHICS_ENGINE_B].targetPlayer = MAPSYS_CAMERA_TARGET_NONE;
    }
    else
    {
        cameraCount = (s32)ARRAY_COUNT(mapCamera.camera);
    }

    for (i = 0; i < cameraCount; i++)
    {
        MapSysCamera *camera                    = &mapCamera.camera[i];
        CameraLockZoneCamera *cameraTarget = &work->camera[i];

        cameraTarget->targetPlayer = camera->targetPlayerID;
        cameraTarget->state        = CameraLockZone_CameraState_ApplyStageBounds;
        cameraTarget->boundsL      = work->gameWork.objWork.position.x + mapObjectParam_left * camera->scale.x;
        cameraTarget->boundsT      = work->gameWork.objWork.position.y + mapObjectParam_top * camera->scale.y;
        cameraTarget->boundsR      = work->gameWork.objWork.position.x + camera->scale.x * (mapObjectParam_left + mapObjectParam_width);
        cameraTarget->boundsB      = work->gameWork.objWork.position.y + camera->scale.y * (mapObjectParam_top + mapObjectParam_height);
    }

    SetTaskState(&work->gameWork.objWork, CameraLockZone_State_Active);

    return work;
}

void CameraLockZone_State_Active(CameraLockZone *work)
{
    if (work->camera[GRAPHICS_ENGINE_A].state != NULL)
        work->camera[GRAPHICS_ENGINE_A].state(work, GRAPHICS_ENGINE_A);

    if (work->camera[GRAPHICS_ENGINE_B].state != NULL)
        work->camera[GRAPHICS_ENGINE_B].state(work, GRAPHICS_ENGINE_B);
}

void CameraLockZone_CameraState_ApplyStageBounds(CameraLockZone *work, s32 id)
{
    CameraLockZoneCamera *cameraTarget = &work->camera[id];
    MapSysCamera *camera                    = &mapCamera.camera[id];

    if ((cameraTarget->flags & CAMERALOCKZONE_FLAGS_LOCK_L) != 0)
    {
        camera->lockTimerL--;
        if (camera->lockTimerL == 0)
        {
            camera->boundsL = mapCamera.camControl.bounds.left;
            camera->flags &= ~MAPSYS_CAMERA_FLAG_10;
            cameraTarget->flags &= ~CAMERALOCKZONE_FLAGS_LOCK_L;
        }
    }

    if ((cameraTarget->flags & CAMERALOCKZONE_FLAGS_LOCK_T) != 0)
    {
        camera->lockTimerT--;
        if (camera->lockTimerT == 0)
        {
            camera->boundsT = mapCamera.camControl.bounds.top;
            camera->flags &= ~MAPSYS_CAMERA_FLAG_20;
            cameraTarget->flags &= ~CAMERALOCKZONE_FLAGS_LOCK_T;
        }
    }

    if ((cameraTarget->flags & CAMERALOCKZONE_FLAGS_LOCK_R) != 0)
    {
        camera->lockTimerR--;
        if (camera->lockTimerR == 0)
        {
            camera->boundsR = mapCamera.camControl.bounds.right;
            camera->flags &= ~MAPSYS_CAMERA_FLAG_10;
            cameraTarget->flags &= ~CAMERALOCKZONE_FLAGS_LOCK_R;
        }
    }

    if ((cameraTarget->flags & CAMERALOCKZONE_FLAGS_LOCK_B) != 0)
    {
        camera->lockTimerB--;
        if (camera->lockTimerB == 0)
        {
            camera->boundsB = mapCamera.camControl.bounds.bottom;
            camera->flags &= ~MAPSYS_CAMERA_FLAG_20;
            cameraTarget->flags &= ~CAMERALOCKZONE_FLAGS_LOCK_B;
        }
    }

    cameraTarget->state = CameraLockZone_CameraState_WaitForTriggerEnter;
}

void CameraLockZone_CameraState_WaitForTriggerEnter(CameraLockZone *work, s32 id)
{
    if (CheckPlayerInTriggerBounds(work, id))
        CameraLockZone_CameraState_ApplyLockedBounds(work, id);
}

void CameraLockZone_CameraState_ApplyLockedBounds(CameraLockZone *work, s32 id)
{
    CameraLockZoneCamera *cameraTarget = &work->camera[id];
    MapSysCamera *camera                    = &mapCamera.camera[id];

    MapObject *mapObject = work->gameWork.mapObject;

    if ((mapObject->flags & CAMERALOCKZONE_OBJFLAG_LOCK_L) != 0)
    {
        camera->boundsL = cameraTarget->boundsL;
        camera->lockTimerL++;
        cameraTarget->flags |= CAMERALOCKZONE_FLAGS_LOCK_L;
    }

    if ((mapObject->flags & CAMERALOCKZONE_OBJFLAG_LOCK_R) != 0)
    {
        camera->boundsR = cameraTarget->boundsR;
        camera->lockTimerR++;
        cameraTarget->flags |= CAMERALOCKZONE_FLAGS_LOCK_R;
    }

    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP) != 0)
        {
            if ((mapObject->flags & CAMERALOCKZONE_OBJFLAG_LOCK_T) != 0)
            {
                if (camera->disp_pos.y - FX32_FROM_WHOLE(HW_LCD_HEIGHT_SPACING) < cameraTarget->boundsT)
                    camera->flags |= MAPSYS_CAMERA_FLAG_20;
                else
                    camera->boundsT = cameraTarget->boundsT + FX32_FROM_WHOLE(HW_LCD_HEIGHT_SPACING);

                camera->lockTimerT++;
                cameraTarget->flags |= CAMERALOCKZONE_FLAGS_LOCK_T;
            }

            if ((mapObject->flags & CAMERALOCKZONE_OBJFLAG_LOCK_B) != 0)
            {
                if (camera->disp_pos.y + FX32_FROM_WHOLE(HW_LCD_HEIGHT) > cameraTarget->boundsB)
                    camera->flags |= MAPSYS_CAMERA_FLAG_20;
                else
                    camera->boundsB = cameraTarget->boundsB;

                camera->lockTimerB++;
                cameraTarget->flags |= CAMERALOCKZONE_FLAGS_LOCK_B;
            }
        }
        else
        {
            if ((mapObject->flags & CAMERALOCKZONE_OBJFLAG_LOCK_T) != 0)
            {
                if (camera->disp_pos.y < cameraTarget->boundsT)
                    camera->flags |= MAPSYS_CAMERA_FLAG_20;
                else
                    camera->boundsT = cameraTarget->boundsT;

                camera->lockTimerT++;
                cameraTarget->flags |= CAMERALOCKZONE_FLAGS_LOCK_T;
            }

            if ((mapObject->flags & CAMERALOCKZONE_OBJFLAG_LOCK_B) != 0)
            {
                if (camera->disp_pos.y + FX32_FROM_WHOLE(HW_LCD_DUAL_HEIGHT) > cameraTarget->boundsB)
                    camera->flags |= MAPSYS_CAMERA_FLAG_20;
                else
                    camera->boundsB = cameraTarget->boundsB - FX32_FROM_WHOLE(HW_LCD_DUAL_HEIGHT);

                camera->lockTimerB++;
                cameraTarget->flags |= CAMERALOCKZONE_FLAGS_LOCK_B;
            }
        }
    }
    else
    {
        if ((mapObject->flags & CAMERALOCKZONE_OBJFLAG_LOCK_T) != 0)
        {
            camera->boundsT = cameraTarget->boundsT;
            camera->lockTimerT++;
            cameraTarget->flags |= CAMERALOCKZONE_FLAGS_LOCK_T;
        }

        if ((mapObject->flags & CAMERALOCKZONE_OBJFLAG_LOCK_B) != 0)
        {
            camera->boundsB = cameraTarget->boundsB;
            camera->lockTimerB++;
            cameraTarget->flags |= CAMERALOCKZONE_FLAGS_LOCK_B;
        }
    }

    cameraTarget->state = CameraLockZone_CameraState_WaitForTriggerExit;
}

void CameraLockZone_CameraState_WaitForTriggerExit(CameraLockZone *work, s32 id)
{
    if (CheckPlayerInTriggerBounds(work, id) == FALSE)
        CameraLockZone_CameraState_ApplyStageBounds(work, id);
}

BOOL CheckPlayerInTriggerBounds(CameraLockZone *work, s32 id)
{
    MapObject *mapObject = work->gameWork.mapObject;
    BOOL inBounds        = FALSE;

    if (work->camera[id].targetPlayer != MAPSYS_CAMERA_TARGET_NONE)
    {
        Player *player = gPlayerList[work->camera[id].targetPlayer];

        fx32 boundsL = work->gameWork.objWork.position.x + FX32_FROM_WHOLE(mapObjectParam_left);
        fx32 x       = player->objWork.position.x;
        if (boundsL <= x && boundsL + FX32_FROM_WHOLE(mapObjectParam_width) >= x)
        {
            fx32 boundsT = work->gameWork.objWork.position.y + FX32_FROM_WHOLE(mapObjectParam_top);
            fx32 y       = player->objWork.position.y;
            if (boundsT <= y && boundsT + FX32_FROM_WHOLE(mapObjectParam_height) >= y)
            {
                if ((player->objWork.flag & STAGE_TASK_FLAG_ON_PLANE_B) == 0 && (mapObject->flags & CAMERALOCKZONE_OBJFLAG_ALLOW_PLANE_A) != 0
                    || (player->objWork.flag & STAGE_TASK_FLAG_ON_PLANE_B) != 0 && (mapObject->flags & CAMERALOCKZONE_OBJFLAG_ALLOW_PLANE_B) != 0)
                {
                    inBounds = TRUE;
                }
            }
        }
    }

    return inBounds;
}