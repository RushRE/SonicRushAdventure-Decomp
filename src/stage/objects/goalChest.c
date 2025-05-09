#include <stage/objects/goalChest.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>
#include <game/graphics/drawFadeTask.h>
#include <stage/effects/medal.h>
#include <stage/effects/goalJewel.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED const char *aGmkGoalChestNs;
NOT_DECOMPILED const char *aGmkGoalChestNs_0;
NOT_DECOMPILED const char *aGmkChestEfectN;
NOT_DECOMPILED const char *aGmkChestEfectN_0;

// --------------------
// ENUMS
// --------------------

enum GoalChestOpenState
{
    GOALCHEST_OPENSTATE_SPINNING,
    GOALCHEST_OPENSTATE_SPIN_SLOWDOWN,
    GOALCHEST_OPENSTATE_PREPARE_OPEN,
    GOALCHEST_OPENSTATE_OPEN_DELAY,
    GOALCHEST_OPENSTATE_OPENING,
    GOALCHEST_OPENSTATE_JEWEL_CHEST_FX,
    GOALCHEST_OPENSTATE_CHEST_FX_DELAY,
    GOALCHEST_OPENSTATE_SPAWN_JEWEL,
    GOALCHEST_OPENSTATE_FADEOUT_JEWEL,
    GOALCHEST_OPENSTATE_MEDAL_CHEST_FX,
    GOALCHEST_OPENSTATE_FADEOUT_MEDAL,
    GOALCHEST_OPENSTATE_DONE,
};

enum GoalChestAnimID
{
    GOALCHEST_ANI_SPINNING,
    GOALCHEST_ANI_OPENING,
};

enum GoalChestEffectAnimID
{
    GOALCHEST_ANI_EFFECT_ACTIVE,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void GoalChest_Destructor(Task *task);
static void GoalChest_State_Opened(GoalChest *work);
static void GoalChest_State_MedalLocator(GoalChest *work);
static void GoalChest_Draw_Effect(void);
static void SpawnGoalChestJewel(GoalChest *work, u16 type);
static void GoalChest_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC GoalChest *CreateGoalChest(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // https://decomp.me/scratch/IBXHO -> 97.73%
    // issue with '(gameState.gameMode == GAMEMODE_MISSION)'
#ifdef NON_MATCHING
    switch (type)
    {
        case 0:
            if ((gmCheckGameMode(GAMEMODE_VS_BATTLE) && gameState.vsBattleType == VSBATTLE_RINGS)
                || ((gameState.gameMode == GAMEMODE_MISSION)
                    && (gameState.missionType != MISSION_TYPE_REACH_GOAL_TIME_LIMIT && gameState.missionType != MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING
                        && gameState.missionType != MISSION_TYPE_REACH_GOAL)))
            {
                DestroyMapObject(mapObject);
                return NULL;
            }
            break;

        // case 1:
        default:
            if (!gmCheckMissionType(MISSION_TYPE_FIND_MEDAL))
            {
                DestroyMapObject(mapObject);
                return NULL;
            }
            break;
    }

    Task *task = CreateStageTask(GoalChest_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), GoalChest);
    if (task == HeapNull)
        return NULL;

    GoalChest *work = TaskGetWork(task, GoalChest);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED | DISPLAY_FLAG_DISABLE_LOOPING;
    work->gameWork.objWork.offset.z = -FLOAT_TO_FX32(32.0);
    VEC_Set(&work->gameWork.objWork.scale, FLOAT_TO_FX32(1.1875), FLOAT_TO_FX32(1.1875), FLOAT_TO_FX32(1.1875));

    ObjAction3dNNModelLoad(&work->gameWork.objWork, &work->aniChest, "/gmk_goal_chest.nsbmd", 0, NULL, gameArchiveCommon);
    ObjAction3dNNMotionLoad(&work->gameWork.objWork, &work->aniChest, "/gmk_goal_chest.nsbca", NULL, gameArchiveCommon);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_APPLY_CAMERA_CONFIG | DISPLAY_FLAG_DISABLE_ROTATION;
    VEC_Set(&work->aniChest.ani.work.scale, FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3));

    AnimatorMDL__Init(&work->aniChestEffect, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->aniChestEffect, ObjDataLoad(NULL, "/gmk_chest_efect.nsbmd", gameArchiveCommon), 0, FALSE, FALSE);
    void *dataEffect = ObjDataLoad(NULL, "/gmk_chest_efect.nsbta", gameArchiveCommon);
    AnimatorMDL__SetAnimation(&work->aniChestEffect, B3D_ANIM_TEX_ANIM, dataEffect, GOALCHEST_ANI_EFFECT_ACTIVE, NULL);
    VEC_Set(&work->aniChestEffect.work.scale, FLOAT_TO_FX32(1.65), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(2.2));
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW_EVENT;

    work->gameWork.objWork.collisionObj      = NULL;
    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    work->gameWork.collisionObject.work.width     = 64;
    work->gameWork.collisionObject.work.height    = 40;
    work->gameWork.collisionObject.work.ofst_x    = -32;
    work->gameWork.collisionObject.work.ofst_y    = -40;

    ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);
    ObjRect__SetDefenceStat(work->gameWork.colliders, ~2, 0);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], GoalChest_OnDefend);
    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -32, -56, 32, 0);
    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400 | OBS_RECT_WORK_FLAG_IS_ACTIVE;

    if (gmCheckMissionType(MISSION_TYPE_FIND_MEDAL))
    {
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
        SetTaskState(&work->gameWork.objWork, GoalChest_State_MedalLocator);
    }

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	mov r6, r1
	mov r5, r2
	cmp r3, #0
	bne _02165384
	ldr r0, =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #1
	ldreq r0, [r0, #0x20]
	cmpeq r0, #1
	beq _02165370
	ldr r0, =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	bne _021653B0
	ldr r0, [r0, #0x70]
	cmp r0, #8
	cmpne r0, #0xb
	cmpne r0, #6
	beq _021653B0
_02165370:
	mov r0, #0xff
	strb r0, [r7]
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_02165384:
	ldr r0, =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xa
	beq _021653B0
	mov r0, #0xff
	strb r0, [r7]
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_021653B0:
	mov r0, #0x1800
	str r0, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, =0x00000624
	ldr r0, =StageTask_Main
	ldr r1, =GoalChest_Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	ldr r2, =0x00000624
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0x20000
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	rsb r0, r0, #0
	orr r1, r1, #0x14
	str r1, [r4, #0x20]
	str r0, [r4, #0x58]
	mov r0, #0x1300
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	mov r3, #0
	str r3, [sp]
	ldr r1, =gameArchiveCommon
	mov r0, r4
	ldr r2, [r1, #0]
	add r1, r4, #0x364
	str r2, [sp, #4]
	ldr r2, =aGmkGoalChestNs
	bl ObjAction3dNNModelLoad
	ldr r1, =gameArchiveCommon
	mov r0, r4
	ldr r2, [r1, #0]
	add r1, r4, #0x364
	str r2, [sp]
	ldr r2, =aGmkGoalChestNs_0
	mov r3, #0
	bl ObjAction3dNNMotionLoad
	ldr r1, [r4, #0x20]
	ldr r0, =0x000034CC
	orr r1, r1, #0x300
	str r1, [r4, #0x20]
	str r0, [r4, #0x37c]
	str r0, [r4, #0x380]
	str r0, [r4, #0x384]
	add r0, r4, #0x4e0
	mov r1, #0
	bl AnimatorMDL__Init
	mov r0, #0
	ldr r1, =aGmkChestEfectN
	ldr r2, =gameArchiveCommon
	ldr r2, [r2, #0]
	bl ObjDataLoad
	mov r1, r0
	mov r2, #0
	str r2, [sp]
	add r0, r4, #0x4e0
	mov r3, r2
	bl AnimatorMDL__SetResource
	mov r0, #0
	ldr r1, =aGmkChestEfectN_0
	ldr r2, =gameArchiveCommon
	ldr r2, [r2, #0]
	bl ObjDataLoad
	mov r2, r0
	mov r3, #0
	add r0, r4, #0x4e0
	mov r1, #3
	str r3, [sp]
	bl AnimatorMDL__SetAnimation
	ldr r0, =0x00001A66
	mov r1, #0
	str r0, [r4, #0x4f8]
	ldr r0, =0x00002332
	str r1, [r4, #0x4fc]
	str r0, [r4, #0x500]
	ldr r2, [r4, #0x20]
	ldr r0, =StageTask__DefaultDiffData
	orr r2, r2, #0x40
	str r2, [r4, #0x20]
	str r1, [r4, #0x13c]
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	add r0, r4, #0x300
	mov r2, #0x40
	strh r2, [r0, #8]
	mov r5, #0x28
	strh r5, [r0, #0xa]
	sub r0, r5, #0x48
	add r3, r4, #0x200
	strh r0, [r3, #0xf0]
	sub r5, r5, #0x50
	mov r2, r1
	add r0, r4, #0x218
	strh r5, [r3, #0xf2]
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFD
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =GoalChest_OnDefend
	mov r2, #0
	str r1, [r4, #0x23c]
	add r0, r4, #0x218
	str r2, [sp]
	sub r1, r2, #0x20
	sub r2, r2, #0x38
	mov r3, #0x20
	bl ObjRect__SetBox2D
	str r4, [r4, #0x234]
	ldr r1, [r4, #0x230]
	ldr r0, =gameState
	orr r1, r1, #4
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xa
	bne _021655F8
	ldr r1, [r4, #0x18]
	ldr r0, =GoalChest_State_MedalLocator
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	str r0, [r4, #0xf4]
_021655F8:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
// clang-format on
#endif
}

void GoalChest_Destructor(Task *task)
{
    GoalChest *work = TaskGetWork(task, GoalChest);

    Animator3D__Release(&work->aniChestEffect.work);
    GameObject__Destructor(task);
}

void GoalChest_State_Opened(GoalChest *work)
{
    u16 e;

    switch (work->gameWork.objWork.userWork)
    {
        case GOALCHEST_OPENSTATE_SPINNING:
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                work->gameWork.objWork.userWork++;
            break;

        case GOALCHEST_OPENSTATE_SPIN_SLOWDOWN:
            work->gameWork.objWork.obj_3d->ani.speedMultiplier -= FLOAT_TO_FX32(0.03125);
            if (work->gameWork.objWork.obj_3d->ani.speedMultiplier <= FLOAT_TO_FX32(1.0))
            {
                work->gameWork.objWork.userWork++;
                work->gameWork.objWork.obj_3d->ani.speedMultiplier = FLOAT_TO_FX32(1.0);
            }
            break;

        case GOALCHEST_OPENSTATE_PREPARE_OPEN:
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                work->gameWork.objWork.userWork++;
                AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_JOINT_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_JOINT_ANIM],
                                          GOALCHEST_ANI_OPENING, NULL);
                work->gameWork.objWork.obj_3d->ani.speedMultiplier = FLOAT_TO_FX32(1.0);
                work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_LOOPING;
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
                work->gameWork.objWork.userTimer = 0;
            }
            break;

        case GOALCHEST_OPENSTATE_OPEN_DELAY:
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer <= 0)
            {
                work->gameWork.objWork.userWork++;
                work->gameWork.objWork.userTimer = 42;
                work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CHEST_OPEN);
            }
            break;

        case GOALCHEST_OPENSTATE_OPENING:
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.ppOut != NULL)
            {
                work->aniChestEffect.work.scale.x += FLOAT_TO_FX32(0.082275390625);
                work->aniChestEffect.work.scale.y += FLOAT_TO_FX32(1.1);

                if (work->aniChestEffect.work.scale.y > FLOAT_TO_FX32(3.3))
                    work->aniChestEffect.work.scale.y = FLOAT_TO_FX32(3.3);
            }

            if (work->gameWork.objWork.userTimer <= 0)
            {
                if (gmCheckMissionType(MISSION_TYPE_FIND_MEDAL))
                {
                    work->gameWork.objWork.userWork  = GOALCHEST_OPENSTATE_MEDAL_CHEST_FX;
                    work->gameWork.objWork.userTimer = 180;
                    EffectMedal__Create(&work->gameWork.objWork);
                }
                else
                {
                    work->gameWork.objWork.userWork++;
                    if (gameState.stageID == STAGE_Z51)
                        work->gameWork.objWork.userTimer = 48;
                    else
                        work->gameWork.objWork.userTimer = 64;
                }

                work->aniChestEffect.work.scale.y = FLOAT_TO_FX32(3.3);
                SetTaskOutFunc(&work->gameWork.objWork, GoalChest_Draw_Effect);
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CHEST_EFFECT);
            }
            else
            {
                if (work->gameWork.objWork.userTimer == 3)
                    SetTaskOutFunc(&work->gameWork.objWork, GoalChest_Draw_Effect);
            }
            break;

        case GOALCHEST_OPENSTATE_JEWEL_CHEST_FX: {
            s32 jewelTypeCount = 10;
            if (gameState.stageID == STAGE_TUTORIAL)
                jewelTypeCount = 6;

            for (e = 0; e < 2; e++, work->gameWork.objWork.userTimer--)
            {
                u16 type = FX_ModS32(work->gameWork.objWork.userTimer, jewelTypeCount);

                EffectGoalJewel__Create(type, work->gameWork.objWork.position.x + FX32_FROM_WHOLE(mtMathRandRepeat(16) - 7),
                                          work->gameWork.objWork.position.y - FLOAT_TO_FX32(32.0), FX32_FROM_WHOLE(mtMathRandRepeat(8) - 3),
                                          -FLOAT_TO_FX32(5.0) - (u16)((u16)(FX32_FROM_WHOLE((u32)mtMathRand()) << 2) >> 2));
            }

            if (work->aniChestEffect.work.scale.x != FLOAT_TO_FX32(3.3))
            {
                work->aniChestEffect.work.scale.x += FLOAT_TO_FX32(0.082275390625);

                if (work->aniChestEffect.work.scale.x > FLOAT_TO_FX32(3.3))
                    work->aniChestEffect.work.scale.x = FLOAT_TO_FX32(3.3);
            }

            if (work->gameWork.objWork.userTimer <= 0)
            {
                work->gameWork.objWork.userWork++;

                if (g_obj.camera[0].y > g_obj.camera[1].y)
                    work->gameWork.objWork.userTimer = 20;
                else
                    work->gameWork.objWork.userTimer = 8;
            }
        }
        break;

        case GOALCHEST_OPENSTATE_CHEST_FX_DELAY:
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer <= 0)
            {
                work->gameWork.objWork.userWork++;
                work->gameWork.objWork.userTimer = 66;
            }
            break;

        case GOALCHEST_OPENSTATE_SPAWN_JEWEL: {
            work->gameWork.objWork.userTimer--;

            s32 jewelTypeCount = 10;
            if (gameState.stageID == STAGE_TUTORIAL)
                jewelTypeCount = 6;

            SpawnGoalChestJewel(work, FX_ModS32(mtMathRand(), jewelTypeCount));
            if (work->gameWork.objWork.userTimer <= 0)
            {
                work->gameWork.objWork.userWork++;
                CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(1.0));
                SendPacketForStageFinishEvent();
            }
        }
        break;

        case GOALCHEST_OPENSTATE_FADEOUT_JEWEL:
            SpawnGoalChestJewel(work, FX_ModS32(mtMathRand(), 10));

            if (IsDrawFadeTaskFinished())
            {
                work->gameWork.objWork.userWork = GOALCHEST_OPENSTATE_DONE;
                playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_CAN_CHANGE_EVENT;
            }
            break;

        case GOALCHEST_OPENSTATE_MEDAL_CHEST_FX:
            if (work->aniChestEffect.work.scale.x != FLOAT_TO_FX32(3.3))
            {
                work->aniChestEffect.work.scale.x += FLOAT_TO_FX32(0.082275390625);
                if (work->aniChestEffect.work.scale.x > FLOAT_TO_FX32(3.3))
                    work->aniChestEffect.work.scale.x = FLOAT_TO_FX32(3.3);
            }

            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer <= 0)
            {
                work->gameWork.objWork.userWork++;
                CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(1.0));
            }
            break;

        case GOALCHEST_OPENSTATE_FADEOUT_MEDAL:
            if (IsDrawFadeTaskFinished())
            {
                work->gameWork.objWork.userWork = GOALCHEST_OPENSTATE_DONE;
                playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_CAN_CHANGE_EVENT;
            }
            break;

        default:
            break;
    }
}

void GoalChest_State_MedalLocator(GoalChest *work)
{
    if (mapCamera.camera[0].disp_pos.x - FLOAT_TO_FX32(64.0) < work->gameWork.objWork.position.x
        && mapCamera.camera[0].disp_pos.x + FLOAT_TO_FX32(320.0) > work->gameWork.objWork.position.x
        && mapCamera.camera[0].disp_pos.y - FLOAT_TO_FX32(64.0) < work->gameWork.objWork.position.y
        && mapCamera.camera[0].disp_pos.y + FLOAT_TO_FX32(256.0) > work->gameWork.objWork.position.y)
    {
        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
    }
    else
    {
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
    }
}

void GoalChest_Draw_Effect(void)
{
    GoalChest *work = TaskGetWorkCurrent(GoalChest);

    u32 displayFlag = work->gameWork.objWork.displayFlag;

    work->gameWork.objWork.displayFlag = DISPLAY_FLAG_APPLY_CAMERA_CONFIG | DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_DISABLE_LOOPING;
    work->gameWork.objWork.offset.y    = -FLOAT_TO_FX32(26.0);
    StageTask__Draw3D(&work->gameWork.objWork, &work->aniChestEffect.work);

    work->gameWork.objWork.offset.y    = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.displayFlag = displayFlag;
}

void SpawnGoalChestJewel(GoalChest *work, u16 type)
{
    fx32 camX;
    fx32 camY;

    if ((g_obj.flag & OBJECTMANAGER_FLAG_USE_DUAL_CAMERAS) != 0 && g_obj.camera[0].y > g_obj.camera[1].y)
    {
        camX = g_obj.camera[1].x;
        camY = g_obj.camera[1].y;
    }
    else
    {
        camX = g_obj.camera[0].x;
        camY = g_obj.camera[0].y;
    }

    fx32 velY          = -FLOAT_TO_FX32(2.0) - (u16)((u16)(FX32_FROM_WHOLE((u32)mtMathRand()) << 2) >> 2);
    fx32 offsetY       = -FLOAT_TO_FX32(12.0);
    fx32 offsetX       = (u32)(FX32_FROM_WHOLE((u32)mtMathRand()) >> 12 << 24) >> 12;
    EffectGoalJewel *effect = EffectGoalJewel__Create(type, camX + offsetX, camY + offsetY, FLOAT_TO_FX32(0.0), velY);
    effect->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
}

void GoalChest_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    GoalChest *goalChest = (GoalChest *)rect2->parent;
    Player *player       = (Player *)rect1->parent;

    if (goalChest == NULL || player == NULL)
        return;

    if (player->objWork.objType == STAGE_OBJ_TYPE_EFFECT)
    {
        if (player->objWork.parentObj == NULL)
            return;

        if (player->objWork.parentObj->objType != STAGE_OBJ_TYPE_PLAYER)
            return;

        player = (Player *)player->objWork.parentObj;
    }
    else
    {
        if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
            return;
    }

    if ((goalChest->gameWork.objWork.flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) == 0)
    {
        Player__Action_FinishMission(player, &goalChest->gameWork);
        AnimatorMDL__SetAnimation(&goalChest->gameWork.objWork.obj_3d->ani, B3D_ANIM_JOINT_ANIM, goalChest->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_JOINT_ANIM],
                                  GOALCHEST_ANI_SPINNING, NULL);
        goalChest->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        goalChest->gameWork.collisionObject.work.parent = NULL;
        goalChest->gameWork.objWork.displayFlag &= ~(DISPLAY_FLAG_NO_DRAW | DISPLAY_FLAG_PAUSED);
        SetTaskState(&goalChest->gameWork.objWork, GoalChest_State_Opened);
        goalChest->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_800;
        goalChest->gameWork.collisionObject.work.flag |= STAGE_TASK_OBJCOLLISION_FLAG_100;

        fx32 impactVelocity = MATH_ABS(player->objWork.move.x) + MATH_ABS(player->objWork.move.y);
        if (impactVelocity > FLOAT_TO_FX32(12.0))
            impactVelocity = FLOAT_TO_FX32(12.0);

        goalChest->gameWork.objWork.obj_3d->ani.speedMultiplier = FLOAT_TO_FX32(1.0) + FX_Div(MultiplyFX(impactVelocity, FLOAT_TO_FX32(2.0)), FLOAT_TO_FX32(12.0));
        goalChest->gameWork.objWork.userWork                    = 0;

        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CHEST_KNOCK);
        playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_NO_MORE_STAGEFINISHEVENTS;

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
    }
}
