#include <stage/objects/crumblingFloor.h>
#include <stage/objects/dashPanel.h>
#include <stage/effects/explosion.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/graphics/screenShake.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_delay mapObject->left

// --------------------
// ENUMS
// --------------------

enum CrumblingFloorObjectFlags
{
    CRUMBLINGFLOOR_OBJFLAG_NONE,

    CRUMBLINGFLOOR_OBJFLAG_HAS_DASH_PANEL  = 1 << 0,
    CRUMBLINGFLOOR_OBJFLAG_FLIP_DASH_PANEL = 1 << 1,
};

enum CrumblingFloorType
{
    CRUMBLINGFLOOR_TYPE_FLAT,
    CRUMBLINGFLOOR_TYPE_SLOPE,

    CRUMBLINGFLOOR_TYPE_COUNT,
};

enum CrumblingFloorAnimID
{
    CRUMBLINGFLOOR_ANI_FLAT,
    CRUMBLINGFLOOR_ANI_SLOPE,
    CRUMBLINGFLOOR_ANI_DEBRIS1,
    CRUMBLINGFLOOR_ANI_DEBRIS2,
};

enum CrumblingFloorFlags
{
    CRUMBLINGFLOOR_FLAG_NONE,

    CRUMBLINGFLOOR_FLAG_STOOD = 1 << 0,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void CrumblingFloor_State_Active(CrumblingFloor *work);

// --------------------
// FUNCTIONS
// --------------------

CrumblingFloor *CreateCrumblingFloor(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    static const char *collisionTable[CRUMBLINGFLOOR_TYPE_COUNT] = {
        [CRUMBLINGFLOOR_TYPE_FLAT] = "/df/gmk_b_fall_floor_flat.df", [CRUMBLINGFLOOR_TYPE_SLOPE] = "/df/gmk_b_fall_floor_up.df"
    };
    static const u16 spriteSizeTable[CRUMBLINGFLOOR_TYPE_COUNT] = { [CRUMBLINGFLOOR_TYPE_FLAT] = 0x10, [CRUMBLINGFLOOR_TYPE_SLOPE] = 0x20 };

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_SCOPE_2, CrumblingFloor);
    if (task == HeapNull)
        return NULL;

    CrumblingFloor *work = TaskGetWork(task, CrumblingFloor);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    u32 objType = (u16)(mapObject->id != MAPOBJECT_231 ? CRUMBLINGFLOOR_TYPE_SLOPE : CRUMBLINGFLOOR_TYPE_FLAT);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_b_fall_floor.bac", GetObjectDataWork(OBJDATAWORK_162), gameArchiveStage, 0);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, spriteSizeTable[objType], GetObjectSpriteRef(2 * objType + OBJDATAWORK_163));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, CRUMBLINGFLOOR_ANI_FLAT, 6);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, objType);
    ObjObjectCollisionDifSet(&work->gameWork.objWork, collisionTable[objType], GetObjectDataWork(objType + OBJDATAWORK_167), gameArchiveStage);
    if (mapObject->id != MAPOBJECT_231)
    {
        ObjObjectCollisionDirSet(&work->gameWork.objWork, "/df/gmk_b_fall_floor_up.di", GetObjectDataWork(OBJDATAWORK_169), gameArchiveStage);
    }

    work->gameWork.collisionObject.work.parent = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.width  = 64;
    work->gameWork.collisionObject.work.height = 64;

    if (mapObject->id == MAPOBJECT_232)
    {
        work->gameWork.collisionObject.work.ofst_x = -16;
        work->gameWork.collisionObject.work.ofst_y = -32;
    }
    else if (mapObject->id == MAPOBJECT_233)
    {
        work->gameWork.collisionObject.work.ofst_x = -16;
        work->gameWork.collisionObject.work.ofst_y = -32;
    }
    else
    {
        work->gameWork.collisionObject.work.ofst_x = -32;
        work->gameWork.collisionObject.work.ofst_y = 0;
    }

    if (mapObject->id == MAPOBJECT_233)
    {
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        work->gameWork.collisionObject.work.flag |= 8;
    }

    if (mapObjectParam_delay == 0)
        work->gameWork.objWork.userTimer = 15;
    else
        work->gameWork.objWork.userTimer = mapObjectParam_delay;

    if ((mapObject->flags & CRUMBLINGFLOOR_OBJFLAG_HAS_DASH_PANEL) != 0)
    {
        u16 dashPanelType;
        u16 dashPanelFlags = DASHPANEL_OBJFLAG_NONE;

        if (mapObject->id == MAPOBJECT_233)
        {
            dashPanelType = MAPOBJECT_333;
        }
        else if (mapObject->id == MAPOBJECT_232)
        {
            dashPanelType = MAPOBJECT_334;
        }
        else
        {
            dashPanelType = MAPOBJECT_95;

            if ((mapObject->flags & CRUMBLINGFLOOR_OBJFLAG_FLIP_DASH_PANEL) != 0)
                dashPanelFlags = DASHPANEL_OBJFLAG_FLIPPED;
        }

        DashPanel *dashPanel = SpawnStageObjectFlags(dashPanelType, work->gameWork.objWork.position.x, work->gameWork.objWork.position.y, DashPanel, dashPanelFlags);

        if (dashPanel != NULL)
        {
            dashPanel->gameWork.objWork.parentObj = &work->gameWork.objWork;
            dashPanel->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
        }
    }

    SetTaskState(&work->gameWork.objWork, CrumblingFloor_State_Active);

    return work;
}

void CrumblingFloor_State_Active(CrumblingFloor *work)
{
    StageTaskCollisionWork *collisionObj = work->gameWork.objWork.collisionObj;

    if ((collisionObj->work.riderObj != NULL && collisionObj->work.riderObj->objType == STAGE_OBJ_TYPE_PLAYER && collisionObj->work.riderObj->rideObj == &work->gameWork.objWork)
        || (collisionObj->work.toucherObj != NULL && collisionObj->work.toucherObj->objType == STAGE_OBJ_TYPE_PLAYER
            && collisionObj->work.toucherObj->touchObj == &work->gameWork.objWork))
        work->gameWork.flags |= CRUMBLINGFLOOR_FLAG_STOOD;

    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_HAS_GRAVITY) != 0)
    {
        if ((work->gameWork.flags & CRUMBLINGFLOOR_FLAG_STOOD) == 0)
        {
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer <= 0)
            {
                work->gameWork.collisionObject.work.flag |= 0x100;

                if ((work->gameWork.objWork.userTimer & 2) != 0)
                    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
                else
                    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;

                if (work->gameWork.objWork.userTimer <= -12)
                    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            }
        }

        work->gameWork.flags &= ~CRUMBLINGFLOOR_FLAG_STOOD;
    }
    else
    {
        if ((work->gameWork.flags & CRUMBLINGFLOOR_FLAG_STOOD) != 0)
        {
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer <= 0)
            {
                work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
                work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

                ShakeScreen(SCREENSHAKE_C_LONG);
                CreateEffectExplosion(&work->gameWork.objWork, 0, 0, 2);
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_LARGE_COLLAPSE);
                work->gameWork.objWork.userTimer = 8;
            }
        }
    }
}
