
#include <stage/objects/ghostTree.h>
#include <game/stage/gameSystem.h>
#include <game/audio/spatialAudio.h>
#include <game/object/objectManager.h>
#include <game/stage/bossArena.h>
#include <game/math/akMath.h>

// --------------------
// ENUMS
// --------------------

enum GhostTreeFlags
{
    GHOSTTREE_FLAG_NONE,

    GHOSTTREE_FLAG_STARTED_REACH = 1 << 0,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void GhostTree_RenderCallback(NNSG3dRS *rs);
static void GhostTree_State_ReachForPlayer(GhostTree *work);
static void GhostTree_State_FailedGrabWait(GhostTree *work);
static void GhostTree_State_GrabbedPlayer(GhostTree *work);
static void GhostTree_State_ThrownPlayer(GhostTree *work);
static void GhostTree_Draw(void);
static void GhostTree_OnDefend_GrabTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void GhostTree_OnDefend_Hand(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

GhostTree *CreateGhostTree(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_GROUP(2), GhostTree);
    if (task == HeapNull)
        return NULL;

    GhostTree *work = TaskGetWork(task, GhostTree);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR | DISPLAY_FLAG_PAUSED | DISPLAY_FLAG_FLIP_X;

    OBS_ACTION3D_NN_WORK *aniArm = &work->aniArm;
    ObjAction3dNNModelLoad(&work->gameWork.objWork, &work->aniArm, "/mod/gmk_gst_tree.nsbmd", 0, GetObjectDataWork(OBJDATAWORK_180), gameArchiveStage);
    ObjAction3dNNMotionLoad(&work->gameWork.objWork, &work->aniArm, "/mod/gmk_gst_tree.nsbca", GetObjectDataWork(OBJDATAWORK_181), gameArchiveStage);
    AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_JOINT_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_JOINT_ANIM], 0, NULL);
    ObjAction3dNNMotionLoad(&work->gameWork.objWork, &work->aniArm, "/mod/gmk_gst_tree.nsbva", GetObjectDataWork(OBJDATAWORK_182), gameArchiveStage);
    AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_VIS_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_VIS_ANIM], 0, NULL);
    aniArm->ani.work.scale.x = FLOAT_TO_FX32(3.3);
    aniArm->ani.work.scale.y = FLOAT_TO_FX32(3.3);
    aniArm->ani.work.scale.z = FLOAT_TO_FX32(3.3);
    NNS_G3dRenderObjSetCallBack(&aniArm->ani.renderObj, GhostTree_RenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);

    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -16, -16, 16, 16);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], GhostTree_OnDefend_Hand);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_NO_PARENT_OFFSET | OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect.pos.x = FX32_TO_WHOLE(work->gameWork.objWork.position.x);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect.pos.y = FX32_TO_WHOLE(work->gameWork.objWork.position.y);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect.pos.z = FX32_TO_WHOLE(work->gameWork.objWork.position.z);

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, -128, -64, 256, 128);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], GhostTree_OnDefend_GrabTrigger);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_NO_PARENT_OFFSET | OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect.pos.x = FX32_TO_WHOLE(work->gameWork.objWork.position.x);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect.pos.y = FX32_TO_WHOLE(work->gameWork.objWork.position.y);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect.pos.z = FX32_TO_WHOLE(work->gameWork.objWork.position.z);

    SetTaskOutFunc(&work->gameWork.objWork, GhostTree_Draw);

    return work;
}

void GhostTree_RenderCallback(NNSG3dRS *rs)
{
    static const NNSG3dResName name = { "tree_03" };

    if (AkMath__Func_2002C40(rs, NNS_G3D_MTXSTACK_SYS, &name))
    {
        NNS_G3dRSResetCallBack(rs, NNS_G3D_SBC_NODEDESC);
    }
}

void GhostTree_State_ReachForPlayer(GhostTree *work)
{
    AnimatorMDL *ani = &work->gameWork.objWork.obj_3d->ani;

    // set hand collider position to the hand pos
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect.pos.x = FX32_TO_WHOLE(work->gameWork.objWork.prevPosition.x);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect.pos.y = FX32_TO_WHOLE(work->gameWork.objWork.prevPosition.y);

    work->gameWork.objWork.userTimer++;
    if (work->gameWork.objWork.userTimer == 50)
    {
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = NULL;
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

        ani->animFlags[B3D_ANIM_JOINT_ANIM] |= ANIMATORMDL_FLAG_BLEND_ANIMATIONS;
        ani->ratioMultiplier = FLOAT_TO_FX32(0.02490234375);
        ani->speedMultiplier = FLOAT_TO_FX32(0.0);
        AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_JOINT_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_JOINT_ANIM], 0, NULL);
        work->gameWork.flags |= GHOSTTREE_FLAG_STARTED_REACH;
    }
    else if (work->gameWork.objWork.userTimer == 70 && (work->gameWork.flags & GHOSTTREE_FLAG_STARTED_REACH) != 0)
    {
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR;
    }

    if ((work->gameWork.flags & GHOSTTREE_FLAG_STARTED_REACH) != 0 && (ani->animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_BLENDING_PAUSED) != 0)
    {
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
        work->gameWork.flags &= ~GHOSTTREE_FLAG_STARTED_REACH;

        ani->animFlags[B3D_ANIM_JOINT_ANIM] |= ANIMATORMDL_FLAG_BLEND_ANIMATIONS;
        ani->ratioMultiplier = FLOAT_TO_FX32(0.5);
        AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_JOINT_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_JOINT_ANIM], 0, NULL);
        AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_VIS_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_VIS_ANIM], 0, NULL);
        ani->speedMultiplier = FLOAT_TO_FX32(1.0);

        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = NULL;
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

        work->gameWork.objWork.userTimer = 0;
        SetTaskState(&work->gameWork.objWork, GhostTree_State_FailedGrabWait);
    }
}

void GhostTree_State_FailedGrabWait(GhostTree *work)
{
    work->gameWork.objWork.userTimer++;
    if (work->gameWork.objWork.userTimer >= 60)
    {
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

        SetTaskState(&work->gameWork.objWork, NULL);
    }
}

void GhostTree_State_GrabbedPlayer(GhostTree *work)
{
    if (work->gameWork.objWork.obj_3d->ani.currentAnimObj[B3D_ANIM_JOINT_ANIM]->frame >= FLOAT_TO_FX32(145.0) && (work->gameWork.objWork.userFlag & PLAYER_PARENTFLAG_RELEASE_WITH_VELOCITY) == 0)
    {
        work->gameWork.objWork.userFlag |= PLAYER_PARENTFLAG_RELEASE_WITH_VELOCITY;
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(8.0);
        work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(8.0);
        NNS_G3dRenderObjResetCallBack(&work->gameWork.objWork.obj_3d->ani.renderObj);
    }
    else
    {
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        {
            AnimatorMDL *ani = &work->gameWork.objWork.obj_3d->ani;

            ani->animFlags[B3D_ANIM_JOINT_ANIM] |= ANIMATORMDL_FLAG_BLEND_ANIMATIONS;
            ani->ratioMultiplier = FLOAT_TO_FX32(0.033203125);
            ani->speedMultiplier = FLOAT_TO_FX32(0.0);
            AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_JOINT_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_JOINT_ANIM], 0, NULL);
            AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_VIS_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_VIS_ANIM], 0, NULL);
            work->gameWork.objWork.userTimer = 0;

            SetTaskState(&work->gameWork.objWork, GhostTree_State_ThrownPlayer);
        }
    }
}

void GhostTree_State_ThrownPlayer(GhostTree *work)
{
    AnimatorMDL *ani = &work->gameWork.objWork.obj_3d->ani;

    work->gameWork.objWork.userTimer++;
    if (work->gameWork.objWork.userTimer == 10)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR;

    if ((ani->animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_BLENDING_PAUSED) != 0)
    {
        ani->animFlags[B3D_ANIM_JOINT_ANIM] |= ANIMATORMDL_FLAG_BLEND_ANIMATIONS;
        ani->ratioMultiplier = FLOAT_TO_FX32(0.5);
        AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_JOINT_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_JOINT_ANIM], 0, NULL);
        AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_VIS_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_VIS_ANIM], 0, NULL);
        ani->speedMultiplier = FLOAT_TO_FX32(1.0);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
        work->gameWork.objWork.userFlag &= ~PLAYER_PARENTFLAG_RELEASE_WITH_VELOCITY;

        NNS_G3dRenderObjSetCallBack(&ani->renderObj, GhostTree_RenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

        SetTaskState(&work->gameWork.objWork, NULL);
    }
}

void GhostTree_Draw(void)
{
    GhostTree *work = TaskGetWorkCurrent(GhostTree);

    // draw arm
    StageTask__Draw(&work->gameWork.objWork);

    // store hand position for later use
    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
    NNS_G3dGeRestoreMtx(NNS_G3D_MTXSTACK_SYS);

    MtxFx43 cameraMtx;
    MtxFx33 mtxArm;
    NNS_G3dGetCurrentMtx(&cameraMtx, &mtxArm);

    fx32 cameraX;
    fx32 cameraY;
    if (g_obj.cameraFunc != NULL)
    {
        g_obj.cameraFunc(&cameraX, &cameraY);
    }
    else
    {
        cameraX = g_obj.camera[0].x;
        cameraY = g_obj.camera[0].y;
    }

    Camera3D *cameraConfig = BossArena__GetCameraConfig2(BossArena__GetCamera(0));

    VecFx32 armPos;
    armPos.x = FLOAT_TO_FX32(0.0);
    armPos.y = FLOAT_TO_FX32(56.0);
    armPos.z = FLOAT_TO_FX32(0.0);
    MTX_MultVec33(&armPos, &mtxArm, &armPos);

    work->gameWork.objWork.prevPosition.x = cameraX + cameraMtx.m[3][0] + cameraConfig->lookAtTo.x + armPos.x;
    work->gameWork.objWork.prevPosition.y = cameraY - cameraMtx.m[3][1] - cameraConfig->lookAtTo.y - armPos.y;
    work->gameWork.objWork.prevPosition.z = cameraMtx.m[3][2] + cameraConfig->lookAtTo.z + armPos.z;
}

void GhostTree_OnDefend_GrabTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    GhostTree *tree = (GhostTree *)rect2->parent;
    Player *player  = (Player *)rect1->parent;

    if (tree == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER || !CheckIsPlayer1(player))
        return;

    tree->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = NULL;
    tree->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

    tree->gameWork.objWork.displayFlag &= ~(DISPLAY_FLAG_ROTATE_CAMERA_DIR | DISPLAY_FLAG_PAUSED);

    tree->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &tree->gameWork.objWork;
    tree->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

    SetTaskState(&tree->gameWork.objWork, GhostTree_State_ReachForPlayer);
    tree->gameWork.objWork.userTimer = 0;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GHOST_TREE);
}

void GhostTree_OnDefend_Hand(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    GhostTree *tree = (GhostTree *)rect2->parent;
    Player *player  = (Player *)rect1->parent;

    if (tree == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER || !CheckIsPlayer1(player))
        return;

    tree->gameWork.parent = &player->objWork;
    Player__Action_GhostTree(player, &tree->gameWork);
    Player__Action_AllowTrickCombos(player, &tree->gameWork);

    tree->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = NULL;
    tree->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

    SetTaskState(&tree->gameWork.objWork, GhostTree_State_GrabbedPlayer);
    tree->gameWork.objWork.userTimer = 0;
}