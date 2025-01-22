#include <stage/objects/flagChange.h>
#include <stage/objects/truck.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void FlagChange_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// ENUMS
// --------------------

enum FlagChangeObjectFlags
{
    FLAGCHANGE_OBJFLAG_NONE,

    // used for MAPOBJECT_64 & MAPOBJECT_259 only
    FLAGCHANGE_OBJFLAG_ENABLE_GIMMICK2 = 1 << 4,

    // used for MAPOBJECT_151 only
    FLAGCHANGE_OBJFLAG_GIMMICKOFFSET_X_MASK     = (1 << 0) | (1 << 1) | (1 << 2),
    FLAGCHANGE_OBJFLAG_GIMMICKOFFSET_X_NEGATIVE = 1 << 3,
    FLAGCHANGE_OBJFLAG_GIMMICKOFFSET_Y_MASK     = (1 << 4) | (1 << 5) | (1 << 6),
    FLAGCHANGE_OBJFLAG_GIMMICKOFFSET_Y_NEGATIVE = 1 << 7,

    // used for MAPOBJECT_89 only
    FLAGCHANGE_OBJFLAG_GRIND_ID_MASK = (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4) | (1 << 5),
};

// --------------------
// FUNCTIONS
// --------------------

FlagChange *CreateFlagChange(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), FlagChange);
    if (task == HeapNull)
        return NULL;

    FlagChange *work = TaskGetWork(task, FlagChange);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, mapObject->left, mapObject->top, mapObject->width + mapObject->left, mapObject->height + mapObject->top);
    ObjRect__SetGroupFlags(&work->gameWork.colliders[0], 2, 1);
    ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);
    ObjRect__SetDefenceStat(work->gameWork.colliders, ~1, 0);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_80 | OBS_RECT_WORK_FLAG_40;
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], FlagChange_OnDefend);
    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_20;

    switch (work->gameWork.mapObject->id)
    {
        case MAPOBJECT_241:
            work->gameWork.colliders[0].rect.front = 50;
            work->gameWork.colliders[0].rect.back  = -80;
            break;

        case MAPOBJECT_230:
            work->gameWork.colliders[0].rect.front = 256;
            work->gameWork.colliders[0].rect.back  = -256;
            break;

        case MAPOBJECT_259:
            ObjRect__SetAttackStat(&work->gameWork.colliders[0], 2, 0x40);
            ObjRect__SetDefenceStat(&work->gameWork.colliders[0], 0, 0x3F);
            work->gameWork.colliders[0].flag &= ~(OBS_RECT_WORK_FLAG_80 | OBS_RECT_WORK_FLAG_40);
            ObjRect__SetOnDefend(&work->gameWork.colliders[0], NULL);
            break;
    }

    return work;
}

void FlagChange_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    FlagChange *flagChange = (FlagChange *)rect2->parent;
    Player *player         = (Player *)rect1->parent;

    if (flagChange == NULL || player == NULL || CheckStageTaskType(&player->objWork, STAGE_OBJ_TYPE_PLAYER) == FALSE)
        return;

    switch (flagChange->gameWork.mapObject->id)
    {
        default:
            // case MAPOBJECT_64:
            // case MAPOBJECT_259:
            if (CheckStageTaskType(rect1->parent, STAGE_OBJ_TYPE_PLAYER) == FALSE || (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0)
                return;

            player->gimmickFlag |= PLAYER_GIMMICK_1;

            if ((flagChange->gameWork.mapObject->flags & FLAGCHANGE_OBJFLAG_ENABLE_GIMMICK2) != 0)
                player->gimmickFlag |= PLAYER_GIMMICK_2;

            player->starComboCount = 0;
            player->gimmickFlag &= ~PLAYER_GIMMICK_ALLOW_TRICK_COMBO;
            break;

        case MAPOBJECT_65:
            player->objWork.flag &= ~STAGE_TASK_FLAG_ON_PLANE_B;

            if (CheckStageTaskType(&player->objWork, STAGE_OBJ_TYPE_PLAYER) == FALSE)
                return;

            player->grindPrevRide = 0;
            break;

        case MAPOBJECT_66:
            player->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;

            if (CheckStageTaskType(&player->objWork, STAGE_OBJ_TYPE_PLAYER) == FALSE)
                return;

            player->grindPrevRide = 0;
            break;

        case MAPOBJECT_89:
            if (CheckStageTaskType(&player->objWork, STAGE_OBJ_TYPE_PLAYER) == FALSE)
                return;

            if ((player->grindID & ~PLAYER_GRIND_ACTIVE) != flagChange->gameWork.mapObject->flags + 1)
            {
                if ((player->actionState < PLAYER_ACTION_GRIND || player->actionState > PLAYER_ACTION_GRINDTRICK_3_03) && (player->grindPrevRide & 2) == 0)
                {
                    player->grindPrevRide = (player->objWork.flag & STAGE_TASK_FLAG_ON_PLANE_B) | 2;
                    player->grindID       = (flagChange->gameWork.mapObject->flags & FLAGCHANGE_OBJFLAG_GRIND_ID_MASK) + 1;
                    player->objWork.flag &= ~STAGE_TASK_FLAG_ON_PLANE_B;
                }
            }

            player->gimmickFlag |= PLAYER_GIMMICK_4;
            break;

        case MAPOBJECT_90:
            if (CheckStageTaskType(&player->objWork, STAGE_OBJ_TYPE_PLAYER) == FALSE)
                return;

            if (player->actionState >= PLAYER_ACTION_GRIND && player->actionState <= PLAYER_ACTION_GRINDTRICK_3_03)
                player->objWork.flag &= ~STAGE_TASK_FLAG_ON_PLANE_B;
            break;

        case MAPOBJECT_91:
            if (CheckStageTaskType(&player->objWork, STAGE_OBJ_TYPE_PLAYER) == FALSE)
                return;

            if (player->actionState >= PLAYER_ACTION_GRIND && player->actionState <= PLAYER_ACTION_GRINDTRICK_3_03)
                player->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
            break;

        case MAPOBJECT_140:
            if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
            {
                ObjRect__FuncNoHit(rect1, rect2);
            }
            else
            {
                Player__Action_IceSlide(player, 0);
                Player__Action_AllowTrickCombos(player, &flagChange->gameWork);
            }
            break;

        case MAPOBJECT_151: {
            if (CheckStageTaskType(&player->objWork, STAGE_OBJ_TYPE_PLAYER) == FALSE)
                return;

            u32 flags = flagChange->gameWork.mapObject->flags;

            s16 x = flags & FLAGCHANGE_OBJFLAG_GIMMICKOFFSET_X_MASK;
            if ((flags & FLAGCHANGE_OBJFLAG_GIMMICKOFFSET_X_NEGATIVE) != 0)
                x = -x;
            player->gimmickCamCenterOffsetX = 8 * x;

            s16 y = (flags & FLAGCHANGE_OBJFLAG_GIMMICKOFFSET_Y_MASK) >> 4;
            if ((flags & FLAGCHANGE_OBJFLAG_GIMMICKOFFSET_Y_NEGATIVE) != 0)
                y = -y;
            player->gimmickCamCenterOffsetY = 8 * y;
        }
        break;

        case MAPOBJECT_175:
            if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_2000000) != 0 && player->objWork.touchObj != NULL)
            {
                Truck *truck = (Truck *)player->objWork.touchObj;
                if (truck->gameWork.objWork.objType == STAGE_OBJ_TYPE_OBJECT && truck->gameWork.mapObject->id == MAPOBJECT_173)
                {
                    Truck__Func_216F2FC(player, truck);
                    Player__Gimmick_2021394(player, (GameObjectTask *)player->objWork.touchObj);
                }
            }
            break;

        case MAPOBJECT_177:
            if (player->gimmickObj != NULL)
            {
                Truck *truck = (Truck *)player->gimmickObj;
                if (truck->gameWork.objWork.objType == STAGE_OBJ_TYPE_OBJECT && truck->gameWork.mapObject->id == MAPOBJECT_173)
                    Truck__Action_Enter3D(truck);
            }
            break;

        case MAPOBJECT_186:
            if (CheckStageTaskType(&player->objWork, STAGE_OBJ_TYPE_PLAYER) == FALSE)
                return;

            if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
            {
                playerGameStatus.speedBonus += PLAYER_SPEEDBONUS_SUPERBOOST;
            }
            else if ((player->playerFlag & PLAYER_FLAG_BOOST) != 0)
            {
                playerGameStatus.speedBonus += PLAYER_SPEEDBONUS_BOOST;
            }
            else if (player->objWork.move.x >= player->spdThresholdRun)
            {
                playerGameStatus.speedBonus += PLAYER_SPEEDBONUS_RUN;
            }
            playerGameStatus.speedBonusCount++;

            flagChange->gameWork.objWork.flag |= STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
            flagChange->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_800;
            flagChange->gameWork.flags |= GAMEOBJECT_FLAG_ALLOW_RESPAWN;
            break;

        case MAPOBJECT_230:
            if (CheckStageTaskType(&player->objWork, STAGE_OBJ_TYPE_PLAYER) == FALSE)
                return;

            if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT) == 0)
                Player__Action_Die(player);
            break;

        case MAPOBJECT_241:
            if (CheckStageTaskType(&player->objWork, STAGE_OBJ_TYPE_PLAYER) == FALSE)
                return;

            Player__Func_202374C(player);
            break;
    }
}
