#include <stage/objects/playerSnowboard.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>

// --------------------
// ENUMS
// --------------------

enum PlayerSnowboardAnim
{
    PLAYERSNOWBOARD_ANI_bd_com_dive_std,
    PLAYERSNOWBOARD_ANI_bd_com_dmg,
    PLAYERSNOWBOARD_ANI_bd_com_fw,
    PLAYERSNOWBOARD_ANI_bd_com_graind,
    PLAYERSNOWBOARD_ANI_bd_com_jump01,
    PLAYERSNOWBOARD_ANI_bd_com_jump02,
    PLAYERSNOWBOARD_ANI_bd_com_jump03,
    PLAYERSNOWBOARD_ANI_bd_com_jump_d,
    PLAYERSNOWBOARD_ANI_bd_com_jump_f_01,
    PLAYERSNOWBOARD_ANI_bd_com_jump_s_01,
    PLAYERSNOWBOARD_ANI_bd_com_jump_s_02,
    PLAYERSNOWBOARD_ANI_bd_com_jump_s_03,
    PLAYERSNOWBOARD_ANI_bd_com_tk_010,
    PLAYERSNOWBOARD_ANI_bd_com_tk_011,
    PLAYERSNOWBOARD_ANI_bd_com_tk_060,
    PLAYERSNOWBOARD_ANI_bd_com_tk_070,
    PLAYERSNOWBOARD_ANI_bd_com_tk_080,
    PLAYERSNOWBOARD_ANI_bd_com_tk_081,
    PLAYERSNOWBOARD_ANI_bd_com_tk_082,
    PLAYERSNOWBOARD_ANI_bd_com_walk,
    PLAYERSNOWBOARD_ANI_bd_son_tk_001,
    PLAYERSNOWBOARD_ANI_bd_son_tk_002,
    PLAYERSNOWBOARD_ANI_bd_son_tk_020,
    PLAYERSNOWBOARD_ANI_bd_son_tk_030,
    PLAYERSNOWBOARD_ANI_bd_son_tk_040,
    PLAYERSNOWBOARD_ANI_bd_blz_tk_001,
    PLAYERSNOWBOARD_ANI_bd_blz_tk_002,
    PLAYERSNOWBOARD_ANI_bd_blz_tk_020,
    PLAYERSNOWBOARD_ANI_bd_blz_tk_030,
    PLAYERSNOWBOARD_ANI_bd_blz_tk_040,
};

// --------------------
// VARIABLES
// --------------------

static void *playerSnowboardWork;
static Task *playerSnowboardTask;

static u16 const animForAction[CHARACTER_COUNT][PLAYERSNOWBOARD_ACTION_COUNT] = {
    [CHARACTER_SONIC] = {
        PLAYERSNOWBOARD_ANI_bd_com_fw,          // PLAYERSNOWBOARD_ACTION_START
        PLAYERSNOWBOARD_ANI_bd_com_walk,        // PLAYERSNOWBOARD_ACTION_1
        PLAYERSNOWBOARD_ANI_bd_com_fw,          // PLAYERSNOWBOARD_ACTION_IDLE
        PLAYERSNOWBOARD_ANI_bd_com_walk,        // PLAYERSNOWBOARD_ACTION_WALK
        PLAYERSNOWBOARD_ANI_bd_com_jump01,      // PLAYERSNOWBOARD_ACTION_JUMP_01
        PLAYERSNOWBOARD_ANI_bd_com_jump02,      // PLAYERSNOWBOARD_ACTION_JUMP_02
        PLAYERSNOWBOARD_ANI_bd_com_jump03,      // PLAYERSNOWBOARD_ACTION_JUMPFALL
        PLAYERSNOWBOARD_ANI_bd_com_jump_s_01,   // PLAYERSNOWBOARD_ACTION_AIRRISE
        PLAYERSNOWBOARD_ANI_bd_com_jump_s_02,   // PLAYERSNOWBOARD_ACTION_AIRFALL_01
        PLAYERSNOWBOARD_ANI_bd_com_jump_s_03,   // PLAYERSNOWBOARD_ACTION_AIRFALL_02
        PLAYERSNOWBOARD_ANI_bd_com_jump_f_01,   // PLAYERSNOWBOARD_ACTION_10
        PLAYERSNOWBOARD_ANI_bd_com_jump_d,      // PLAYERSNOWBOARD_ACTION_RAINBOWDASHRING
        PLAYERSNOWBOARD_ANI_bd_son_tk_001,      // PLAYERSNOWBOARD_ACTION_TRICK_FINISH_V_01
        PLAYERSNOWBOARD_ANI_bd_son_tk_002,      // PLAYERSNOWBOARD_ACTION_TRICK_FINISH_V_02
        PLAYERSNOWBOARD_ANI_bd_com_tk_010,      // PLAYERSNOWBOARD_ACTION_TRICK_FINISH_H_01
        PLAYERSNOWBOARD_ANI_bd_com_tk_011,      // PLAYERSNOWBOARD_ACTION_TRICK_FINISH_H_02
        PLAYERSNOWBOARD_ANI_bd_son_tk_020,      // PLAYERSNOWBOARD_ACTION_TRICK_SUCCESS1
        PLAYERSNOWBOARD_ANI_bd_son_tk_030,      // PLAYERSNOWBOARD_ACTION_TRICK_SUCCESS2
        PLAYERSNOWBOARD_ANI_bd_son_tk_040,      // PLAYERSNOWBOARD_ACTION_TRICK_FINISH
        PLAYERSNOWBOARD_ANI_bd_com_graind,      // PLAYERSNOWBOARD_ACTION_GRIND
        PLAYERSNOWBOARD_ANI_bd_com_tk_060,      // PLAYERSNOWBOARD_ACTION_GRINDTRICK_1
        PLAYERSNOWBOARD_ANI_bd_com_tk_070,      // PLAYERSNOWBOARD_ACTION_GRINDTRICK_2
        PLAYERSNOWBOARD_ANI_bd_com_tk_080,      // PLAYERSNOWBOARD_ACTION_GRINDTRICK_3_01
        PLAYERSNOWBOARD_ANI_bd_com_tk_081,      // PLAYERSNOWBOARD_ACTION_GRINDTRICK_3_02
        PLAYERSNOWBOARD_ANI_bd_com_tk_082,      // PLAYERSNOWBOARD_ACTION_GRINDTRICK_3_03
        PLAYERSNOWBOARD_ANI_bd_com_dmg,         // PLAYERSNOWBOARD_ACTION_HURT
        PLAYERSNOWBOARD_ANI_bd_com_dive_std,    // PLAYERSNOWBOARD_ACTION_DIVING_BOARD
    },

    [CHARACTER_BLAZE] = {
         PLAYERSNOWBOARD_ANI_bd_com_fw,         // PLAYERSNOWBOARD_ACTION_START
         PLAYERSNOWBOARD_ANI_bd_com_walk,       // PLAYERSNOWBOARD_ACTION_1
         PLAYERSNOWBOARD_ANI_bd_com_fw,         // PLAYERSNOWBOARD_ACTION_IDLE
         PLAYERSNOWBOARD_ANI_bd_com_walk,       // PLAYERSNOWBOARD_ACTION_WALK
         PLAYERSNOWBOARD_ANI_bd_com_jump01,     // PLAYERSNOWBOARD_ACTION_JUMP_01
         PLAYERSNOWBOARD_ANI_bd_com_jump02,     // PLAYERSNOWBOARD_ACTION_JUMP_02
         PLAYERSNOWBOARD_ANI_bd_com_jump03,     // PLAYERSNOWBOARD_ACTION_JUMPFALL
         PLAYERSNOWBOARD_ANI_bd_com_jump_s_01,  // PLAYERSNOWBOARD_ACTION_AIRRISE
         PLAYERSNOWBOARD_ANI_bd_com_jump_s_02,  // PLAYERSNOWBOARD_ACTION_AIRFALL_01
         PLAYERSNOWBOARD_ANI_bd_com_jump_s_03,  // PLAYERSNOWBOARD_ACTION_AIRFALL_02
         PLAYERSNOWBOARD_ANI_bd_com_jump_f_01,  // PLAYERSNOWBOARD_ACTION_10
         PLAYERSNOWBOARD_ANI_bd_com_jump_d,     // PLAYERSNOWBOARD_ACTION_RAINBOWDASHRING
         PLAYERSNOWBOARD_ANI_bd_blz_tk_001,     // PLAYERSNOWBOARD_ACTION_TRICK_FINISH_V_01
         PLAYERSNOWBOARD_ANI_bd_blz_tk_002,     // PLAYERSNOWBOARD_ACTION_TRICK_FINISH_V_02
         PLAYERSNOWBOARD_ANI_bd_com_tk_010,     // PLAYERSNOWBOARD_ACTION_TRICK_FINISH_H_01
         PLAYERSNOWBOARD_ANI_bd_com_tk_011,     // PLAYERSNOWBOARD_ACTION_TRICK_FINISH_H_02
         PLAYERSNOWBOARD_ANI_bd_blz_tk_020,     // PLAYERSNOWBOARD_ACTION_TRICK_SUCCESS1
         PLAYERSNOWBOARD_ANI_bd_blz_tk_030,     // PLAYERSNOWBOARD_ACTION_TRICK_SUCCESS2
         PLAYERSNOWBOARD_ANI_bd_blz_tk_040,     // PLAYERSNOWBOARD_ACTION_TRICK_FINISH
         PLAYERSNOWBOARD_ANI_bd_com_graind,     // PLAYERSNOWBOARD_ACTION_GRIND
         PLAYERSNOWBOARD_ANI_bd_com_tk_060,     // PLAYERSNOWBOARD_ACTION_GRINDTRICK_1
         PLAYERSNOWBOARD_ANI_bd_com_tk_070,     // PLAYERSNOWBOARD_ACTION_GRINDTRICK_2
         PLAYERSNOWBOARD_ANI_bd_com_tk_080,     // PLAYERSNOWBOARD_ACTION_GRINDTRICK_3_01
         PLAYERSNOWBOARD_ANI_bd_com_tk_081,     // PLAYERSNOWBOARD_ACTION_GRINDTRICK_3_02
         PLAYERSNOWBOARD_ANI_bd_com_tk_082,     // PLAYERSNOWBOARD_ACTION_GRINDTRICK_3_03
         PLAYERSNOWBOARD_ANI_bd_com_dmg,        // PLAYERSNOWBOARD_ACTION_HURT
         PLAYERSNOWBOARD_ANI_bd_com_dive_std,   // PLAYERSNOWBOARD_ACTION_DIVING_BOARD
    }
};

// --------------------
// FUNCTION DECLS
// --------------------

static void LosePlayerSnowboard(Player *player, fx32 velX);
static void PlayerSnowboard_Destructor(Task *task);
static void PlayerSnowboard_State_Active(PlayerSnowboard *work);
static void PlayerSnowboard_State_Lost(LoseSnowboardTrigger *work);
static void LoseSnowboardTrigger_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

PlayerSnowboard *SpawnLostPlayerSnowboard(fx32 type)
{
    return SpawnStageObjectEx(MAPOBJECT_320, gPlayer->objWork.position.x, gPlayer->objWork.position.y, PlayerSnowboard, 0, 0, 0, 0, 0, type);
}

void DestroyPlayerSnowboard(void)
{
    if (playerSnowboardTask != NULL)
    {
        PlayerSnowboard *work = TaskGetWork(playerSnowboardTask, PlayerSnowboard);

        DestroyStageTask(&work->gameWork.objWork);
        NNS_G3dResDefaultRelease(work->gameWork.objWork.obj_3d->file[0]->fileData);

        playerSnowboardTask = NULL;
        playerSnowboardWork = NULL;
    }
}

void ChangePlayerSnowboardAction(Player *player, PlayerSnowboardAction action)
{
    if (CheckIsPlayer1(player))
    {
        PlayerSnowboard *work = playerSnowboardWork;

        if (work != NULL)
        {
            work->gameWork.objWork.obj_3d->ani.animFlags[B3D_ANIM_JOINT_ANIM] |= 4;

            AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_JOINT_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_JOINT_ANIM],
                                      animForAction[((Player *)(work->gameWork.parent))->characterID][action], NULL);

            Player *parent = (Player *)work->gameWork.parent;
            if (parent != NULL)
            {
                if ((parent->objWork.displayFlag & DISPLAY_FLAG_DISABLE_LOOPING) != 0)
                    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            }
        }
    }
}

PlayerSnowboard *CreatePlayerSnowboard(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // clang-format off
static const char *boardModelPath[CHARACTER_COUNT] = { 
        [CHARACTER_SONIC] = "/mod/board_son.nsbmd", 
        [CHARACTER_BLAZE] = "/mod/board_blz.nsbmd" 
};

static u16 const initialAnimList[CHARACTER_COUNT][2] = {
        [CHARACTER_SONIC] = { PLAYERSNOWBOARD_ANI_bd_com_fw, PLAYERSNOWBOARD_ANI_bd_com_fw }, 
        [CHARACTER_BLAZE] = { PLAYERSNOWBOARD_ANI_bd_com_fw, PLAYERSNOWBOARD_ANI_bd_com_fw }
};
    // clang-format on

    Player *player = gPlayer;

    Task *task = CreateStageTask(PlayerSnowboard_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), PlayerSnowboard);
    if (task == HeapNull)
        return NULL;

    playerSnowboardTask = task;

    PlayerSnowboard *work = TaskGetWork(task, PlayerSnowboard);
    TaskInitWork8(work);
    playerSnowboardWork = work;

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR;

    ObjAction3dNNModelLoad(&work->gameWork.objWork, &work->aniSnowboard, boardModelPath[player->characterID], 0, GetObjectFileWork(OBJDATAWORK_165 + player->characterID),
                           gameArchiveStage);
    NNS_G3dResDefaultSetup(work->gameWork.objWork.obj_3d->file[0]->fileData);
    ObjAction3dNNMotionLoad(&work->gameWork.objWork, work->gameWork.objWork.obj_3d, "/mod/ply_board.nsbca", 0, gameArchiveStage);

    VEC_Set(&work->gameWork.objWork.obj_3d->ani.work.scale, FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3));
    work->gameWork.objWork.obj_3d->ani.work.translation2.y = -FLOAT_TO_FX32(16.0);
    work->gameWork.objWork.obj_3d->ani.work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;
    work->gameWork.objWork.obj_3d->ani.work.matrixOpIDs[1] = MATRIX_OP_IDENTITY;
    work->gameWork.objWork.obj_3d->ani.work.matrixOpIDs[2] = MATRIX_OP_IDENTITY_ROTATE_TRANSLATE2_SCALE;
    AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_JOINT_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_JOINT_ANIM],
                              initialAnimList[player->characterID][type], NULL);

    work->gameWork.parent              = &player->objWork;
    work->gameWork.objWork.ppViewCheck = NULL;
    SetTaskState(&work->gameWork.objWork, PlayerSnowboard_State_Active);

    return work;
}

void LosePlayerSnowboard(Player *player, fx32 velX)
{
    PlayerSnowboard *work = playerSnowboardWork;
    if (work != NULL)
    {
        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_WALK);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
        work->gameWork.objWork.obj_3d->ani.work.translation2.y = 0;
        SetTaskViewCheckFunc(&work->gameWork.objWork, StageTask__ViewCheck_Default);
        work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
        work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
        work->gameWork.objWork.velocity.x = velX;
        work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(8.0);

        SetTaskState(&work->gameWork.objWork, PlayerSnowboard_State_Lost);
    }
}

LoseSnowboardTrigger *CreateLoseSnowboardTrigger(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), LoseSnowboardTrigger);
    if (task == HeapNull)
        return NULL;

    LoseSnowboardTrigger *work = TaskGetWork(task, LoseSnowboardTrigger);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, 0, -128, 32, 128);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].onDefend = LoseSnowboardTrigger_OnDefend;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    SetTaskState(&work->gameWork.objWork, PlayerSnowboard_State_Lost);
    return work;
}

void PlayerSnowboard_Destructor(Task *task)
{
    PlayerSnowboard *work = TaskGetWork(task, PlayerSnowboard);

    if (playerSnowboardTask == task)
    {
        NNS_G3dResDefaultRelease(work->gameWork.objWork.obj_3d->file[0]->fileData);
        playerSnowboardWork = NULL;
        playerSnowboardTask = NULL;
    }

    GameObject__Destructor(task);
}

void PlayerSnowboard_State_Active(PlayerSnowboard *work)
{
    Player *player = (Player *)work->gameWork.parent;

    if ((player->playerFlag & PLAYER_FLAG_DEATH) != 0)
    {
        LosePlayerSnowboard(player, FLOAT_TO_FX32(0.0));
    }
    else
    {
        work->gameWork.objWork.position = player->objWork.position;
        work->gameWork.objWork.dir      = player->objWork.dir;

        work->gameWork.objWork.displayFlag =
            (work->gameWork.objWork.displayFlag & ~(DISPLAY_FLAG_ROTATE_CAMERA_DIR | DISPLAY_FLAG_DISABLE_LOOPING | DISPLAY_FLAG_FLIP_Y | DISPLAY_FLAG_FLIP_X))
            | (player->objWork.displayFlag & (DISPLAY_FLAG_ROTATE_CAMERA_DIR | DISPLAY_FLAG_DISABLE_LOOPING | DISPLAY_FLAG_FLIP_Y | DISPLAY_FLAG_FLIP_X));
        work->gameWork.objWork.obj_3d->ani.speedMultiplier = player->objWork.obj_3d->ani.speedMultiplier;
    }
}

void PlayerSnowboard_State_Lost(LoseSnowboardTrigger *work)
{
    work->gameWork.objWork.dir.z += FLOAT_DEG_TO_IDX(9.84375);
}

void LoseSnowboardTrigger_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    LoseSnowboardTrigger *trigger = (LoseSnowboardTrigger *)rect2->parent;
    Player *player                = (Player *)rect1->parent;

    if (trigger == NULL || player == NULL)
        return;

    if (CheckIsPlayer1(player) && player->objWork.objType == STAGE_OBJ_TYPE_PLAYER && (player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) != 0)
    {
        trigger->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        LosePlayerSnowboard(player, FLOAT_TO_FX32(3.0));
        Player__Action_LoseSnowboard(player);
    }
}