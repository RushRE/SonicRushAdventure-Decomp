#include <stage/objects/dashPanel.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SetupDashPanelObject(DashPanel *work);
static void DashPanel_State_Active(DashPanel *work);
static void DashPanel_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// ENUMS
// --------------------

enum DashPanelAnimID
{
    DASHPANEL_ANI_HORIZONTAL,
    DASHPANEL_ANI_VERTICAL,
    DASHPANEL_ANI_HORIZONTAL_ALT,
    DASHPANEL_ANI_DIAGONAL_UR_STEEP,
    DASHPANEL_ANI_DIAGONAL_UL_STEEP,
    DASHPANEL_ANI_DIAGONAL_UR_MILD,
    DASHPANEL_ANI_DIAGONAL_DR_MILD,
};

// --------------------
// FUNCTIONS
// --------------------

DashPanel *CreateDashPanel(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), DashPanel);
    if (task == HeapNull)
        return NULL;

    DashPanel *work = TaskGetWork(task, DashPanel);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    if (mapObject->id == MAPOBJECT_333 || mapObject->id == MAPOBJECT_334)
    {
        ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_dash_p_60.bac", GetObjectFileWork(OBJDATAWORK_34), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    }
    else
    {
        ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_dash_p.bac", GetObjectFileWork(OBJDATAWORK_33), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    }

    ObjActionAllocSpritePalette(&work->gameWork.objWork, DASHPANEL_ANI_HORIZONTAL, 2);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);
    ObjRect__SetDefenceStat(work->gameWork.colliders, ~1, 0);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], DashPanel_OnDefend);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    switch (mapObject->id)
    {
        case MAPOBJECT_92:
        case MAPOBJECT_95:
        default:
            if ((mapObject->flags & DASHPANEL_OBJFLAG_FLIPPED) == 0)
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            break;

        case MAPOBJECT_96:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

            if ((mapObject->flags & DASHPANEL_OBJFLAG_FLIPPED) == 0)
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            break;

        case MAPOBJECT_97:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

            if ((mapObject->flags & DASHPANEL_OBJFLAG_FLIPPED) != 0)
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
            break;

        case MAPOBJECT_98:
            if ((mapObject->flags & DASHPANEL_OBJFLAG_FLIPPED) != 0)
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
            break;

        case MAPOBJECT_152:
        case MAPOBJECT_154:
        case MAPOBJECT_156:
        case MAPOBJECT_158:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            break;

        case MAPOBJECT_153:
        case MAPOBJECT_155:
        case MAPOBJECT_157:
        case MAPOBJECT_159:
            break;

        case MAPOBJECT_333:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            break;

        case MAPOBJECT_334:
            break;
    }

    // set animation id
    switch (work->gameWork.mapObject->id)
    {
        case MAPOBJECT_95:
        case MAPOBJECT_96:
        default:
            // dash panel (horizontal)
            work->gameWork.objWork.userWork = DASHPANEL_ANI_HORIZONTAL;
            break;

        case MAPOBJECT_97:
        case MAPOBJECT_98:
            // dash panel (vertical)
            work->gameWork.objWork.userWork = DASHPANEL_ANI_VERTICAL;
            break;

        case MAPOBJECT_92:
            // dash panel - alternate variant (horizontal)
            work->gameWork.objWork.userWork = DASHPANEL_ANI_HORIZONTAL_ALT;

            if (Player__UseUpsideDownGravity(work->gameWork.objWork.position.x, work->gameWork.objWork.position.y))
                work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_Y;
            break;

        case MAPOBJECT_152:
        case MAPOBJECT_153:
            // dash panel (diagonal, up-right, steep slope)
            work->gameWork.objWork.userWork = DASHPANEL_ANI_DIAGONAL_UL_STEEP;
            break;

        case MAPOBJECT_154:
        case MAPOBJECT_155:
            // dash panel (diagonal, up-left, steep slope)
            work->gameWork.objWork.userWork = DASHPANEL_ANI_DIAGONAL_UR_STEEP;
            break;

        case MAPOBJECT_156:
        case MAPOBJECT_157:
            // dash panel (diagonal, up-right, mild slope)
            work->gameWork.objWork.userWork = DASHPANEL_ANI_DIAGONAL_DR_MILD;
            break;

        case MAPOBJECT_158:
        case MAPOBJECT_159:
            // dash panel (diagonal, down-right, mild slope)
            work->gameWork.objWork.userWork = DASHPANEL_ANI_DIAGONAL_UR_MILD;
            break;

        case MAPOBJECT_333:
        case MAPOBJECT_334:
            // dash panel (sky babylon variant)
            work->gameWork.objWork.userWork = DASHPANEL_ANI_HORIZONTAL;
            break;
    }

    SetupDashPanelObject(work);
    return work;
}

void SetupDashPanelObject(DashPanel *work)
{
    StageTask__SetAnimation(&work->gameWork.objWork, work->gameWork.objWork.userWork);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    SetTaskState(&work->gameWork.objWork, DashPanel_State_Active);
}

void DashPanel_State_Active(DashPanel *work)
{
    work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_100;

    if (work->gameWork.objWork.parentObj != NULL)
    {
        if (!IsStageTaskDestroyedAny(work->gameWork.objWork.parentObj))
        {
            work->gameWork.objWork.position.x = work->gameWork.objWork.parentObj->position.x;
            work->gameWork.objWork.position.y = work->gameWork.objWork.parentObj->position.y;
        }
    }
}

void DashPanel_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    DashPanel *dashPanel = (DashPanel *)rect2->parent;
    Player *player       = (Player *)rect1->parent;

    u16 id;
    fx32 velX = 0;
    fx32 velY = 0;

    if (dashPanel == NULL)
        return;

    if (player == NULL || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    id = dashPanel->gameWork.mapObject->id;
    if (id != MAPOBJECT_92 && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
    {
        dashPanel->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_100;
        ObjRect__FuncNoHit(rect1, rect2);
        return;
    }

    if (id == MAPOBJECT_92 && (player->actionState < PLAYER_ACTION_GRIND || player->actionState > PLAYER_ACTION_GRINDTRICK_3_03))
    {
        dashPanel->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_100;
        ObjRect__FuncNoHit(rect1, rect2);
        return;
    }

    switch (id)
    {
        default:
        case MAPOBJECT_92:
        case MAPOBJECT_95:
        case MAPOBJECT_96:
            if ((dashPanel->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                velX = player->topSpeed;
            else
                velX = -player->topSpeed;
            break;

        case MAPOBJECT_97:
        case MAPOBJECT_98:
            if ((dashPanel->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
                velY = player->topSpeed;
            else
                velY = -player->topSpeed;
            break;

        case MAPOBJECT_152:
        case MAPOBJECT_154:
        case MAPOBJECT_156:
        case MAPOBJECT_158:
        case MAPOBJECT_333:
            velX = -player->topSpeed;
            break;

        case MAPOBJECT_153:
        case MAPOBJECT_155:
        case MAPOBJECT_157:
        case MAPOBJECT_159:
        case MAPOBJECT_334:
            velX = player->topSpeed;
            break;
    }

    Player__UseDashPanel(player, velX, velY);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DASH_PANEL);
}
