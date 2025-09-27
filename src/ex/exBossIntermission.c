
#include <ex/boss/exBoss.h>
#include <ex/effects/exBossFireEffect.h>
#include <ex/effects/exBossShotEffect.h>
#include <ex/system/exDrawReq.h>
#include <ex/system/exSystem.h>
#include <ex/system/exStage.h>
#include <ex/system/exSave.h>
#include <ex/system/exUtils.h>
#include <game/file/binaryBundle.h>
#include <game/audio/audioSystem.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

static s16 exBossInstanceCount;

static void *exBossLastSpawnedWorker;
static void *exBossModelResource;
static void *exBossAnimResource[1];
static void *exBossPaletteAnimResource[15];

static const char *texturePaletteNameList[15] = {
    "ex_arm_pl",  "ex_arm_top_pl", "ex_back_pl", "ex_bl_pl",     "ex_engine_pl",  "ex_eye_pl",  "ex_hand_pl",    "ex_maga_pl",
    "ex_pipe_pl", "ex_setu_pl",    "ex_side_pl", "ex_stomac_pl", "ex_tue_top_pl", "ex_tuno_pl", "ex_under_b_pl",
};

// --------------------
// FUNCTION DECLS
// --------------------

// Hurt
static void ExBoss_Main_Dmg0(void);
static void ExBoss_Action_StartDmg1(void);
static void ExBoss_Main_Dmg1(void);
static void ExBoss_Action_FinishDmg(void);

// Critically Hurt (Phase 1 Complete)
static void ExBoss_Main_BDmg0_Phase1Complete(void);
static void ExBoss_Action_StartPhase2(void);
static void ExBoss_Main_WaitForPhase2Regenerate(void);
static void ExBoss_Action_RegenerateForPhase2(void);
static void ExBoss_Main_RegenerateForPhase2(void);
static void ExBoss_Action_FinishRegenerateForPhase2(void);

// Critically Hurt (Phase 2 Complete)
static void ExBoss_Main_BDmg1_Phase2Complete(void);
static void ExBoss_Action_StartPhase3(void);
static void ExBoss_Main_WaitForPhase3Regenerate(void);
static void ExBoss_Action_RegenerateForPhase3(void);
static void ExBoss_Main_RegenerateForPhase3(void);
static void ExBoss_Action_FinishRegenerateForPhase3(void);

// Critically Hurt (Phase 3 Complete)
static void ExBoss_Main_BDmg1_BossDefeated(void);
static void ExBoss_Action_StartBossDefeat(void);
static void ExBoss_Main_WaitForFleeFinish(void);
static void ExBoss_Action_AppearForDefeat(void);
static void ExBoss_Main_DefeatedFlashing(void);
static void ExBoss_Action_FinalizeDefeatedFlashing(void);
static void ExBoss_Main_FinalizeDefeatedFlashing(void);
static void ExBoss_Action_SetDefeated(void);
static void ExBoss_Main_Defeated(void);

// --------------------
// FUNCTIONS
// --------------------

void LoadExBossAssets(EX_ACTION_NN_WORK *work)
{
    exBossLastSpawnedWorker = work;

    InitExDrawRequestModel(work);

    if (exBossInstanceCount == 0)
    {
        GetCompressedFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_BOSS_BODY_NSBMD, &exBossModelResource, FALSE, FALSE);

        exBossAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_BOSS_NSBCA);

        NNS_G3dResDefaultSetup(exBossModelResource);

        void *mdlResource   = exBossModelResource;
        exBossModelResource = HeapAllocHead(HEAP_USER, Asset3DSetup__GetTexSize(exBossModelResource));
        Asset3DSetup__GetTexture(mdlResource, exBossModelResource);
        HeapFree(HEAP_USER, mdlResource);
    }

    AnimatorMDL *animator = &work->model.animator;
    AnimatorMDL__Init(animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(animator, exBossModelResource, 0, FALSE, FALSE);

    animator->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;
    NNS_G3dRenderObjSetCallBack(&animator->renderObj, ExBoss_BossRenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);

    u16 i = 0;
    for (; i < ARRAY_COUNT(exBossAnimResource); i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, exBossAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = B3D_ANIM_JOINT_ANIM;
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[B3D_ANIM_JOINT_ANIM];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    exBossPaletteAnimResource[0]  = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ARM_BPA);
    exBossPaletteAnimResource[1]  = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ARM_TOP_BPA);
    exBossPaletteAnimResource[2]  = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_BACK_BPA);
    exBossPaletteAnimResource[3]  = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_BL_BPA);
    exBossPaletteAnimResource[4]  = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ENGINE_BPA);
    exBossPaletteAnimResource[5]  = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EYE_BPA);
    exBossPaletteAnimResource[6]  = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_HAND_BPA);
    exBossPaletteAnimResource[7]  = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_MAGA_BPA);
    exBossPaletteAnimResource[8]  = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_PIPE_BPA);
    exBossPaletteAnimResource[9]  = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_SETU_BPA);
    exBossPaletteAnimResource[10] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_SIDE_BPA);
    exBossPaletteAnimResource[11] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_STOMAC_BPA);
    exBossPaletteAnimResource[12] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_TUE_TOP_BPA);
    exBossPaletteAnimResource[13] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_TUNO_BPA);
    exBossPaletteAnimResource[14] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_UNDER_B_BPA);

    for (s16 p = 0; p < 15; p++)
    {
        InitPaletteAnimator(&work->model.paletteAnimator[p], exBossPaletteAnimResource[p], 0, ANIMATORBPA_FLAG_CAN_LOOP, PALETTE_MODE_TEXTURE,
                            VRAMKEY_TO_ADDR(Asset3DSetup__PaletteFromName(NNS_G3dGetTex(exBossModelResource), texturePaletteNameList[p])));
    }

    work->model.scale.x = FLOAT_TO_FX32(1.0);
    work->model.scale.y = FLOAT_TO_FX32(1.0);
    work->model.scale.z = FLOAT_TO_FX32(1.0);

    work->model.angle.x = FLOAT_DEG_TO_IDX(89.98);

    work->hitChecker.type         = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isBoss = TRUE;

    work->model.bossChestPos.x = FLOAT_TO_FX32(0.0);
    work->model.bossChestPos.y = FLOAT_TO_FX32(0.0);
    work->model.bossChestPos.z = FLOAT_TO_FX32(0.0);

    work->hitChecker.box.size.x   = FLOAT_TO_FX32(12.0);
    work->hitChecker.box.size.y   = FLOAT_TO_FX32(12.0);
    work->hitChecker.box.size.z   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position = &work->model.bossChestPos;

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_B;

    exBossInstanceCount++;
}

void SetExBossAnimation(EX_ACTION_NN_WORK *work, ExBossAnimIDs animID)
{
    ExUtils_SetJointAnimation(work, exBossModelResource, NULL, exBossAnimResource[0], animID);
}

void ReleaseExBossAssets(EX_ACTION_NN_WORK *work)
{
    if (exBossInstanceCount <= 1)
    {
        if (exBossModelResource)
            NNS_G3dResDefaultRelease(exBossModelResource);

        if (exBossModelResource)
            HeapFree(HEAP_USER, exBossModelResource);
        else
            exBossModelResource = NULL;
    }

    for (s16 p = 0; p < 15; p++)
    {
        ReleasePaletteAnimator(&work->model.paletteAnimator[p]);
    }
    AnimatorMDL__Release(&work->model.animator);

    exBossInstanceCount--;
}

EX_ACTION_NN_WORK *GetExBossAssets(void)
{
    return exBossLastSpawnedWorker;
}

void ExBoss_BossRenderCallback(NNSG3dRS *rs)
{
    static const NNSG3dResName effectNodeName = { "effect" };
    static const NNSG3dResName chestNodeName  = { "chest" };

    s32 targetNode = NNS_G3dGetResDictIdxByName(&rs->pRenderObj->resMdl->nodeInfo.dict, &effectNodeName);
    if (NNS_G3dRSGetCurrentNodeDescID(rs) == targetNode)
    {
        NNS_G3dGeStoreMtx(NNS_G3D_MTXSTACK_SYS);
        return;
    }

    targetNode = NNS_G3dGetResDictIdxByName(&rs->pRenderObj->resMdl->nodeInfo.dict, &chestNodeName);
    if (NNS_G3dRSGetCurrentNodeDescID(rs) == targetNode)
    {
        NNS_G3dGeStoreMtx(NNS_G3D_MTXSTACK_USER);
        return;
    }
}

void ExBoss_Action_StartHurt(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_dmg0);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_Dmg0);
    ExBoss_Main_Dmg0();
}

void ExBoss_Main_Dmg0(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
        ExBoss_Action_StartDmg1();
    else
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
}

void ExBoss_Action_StartDmg1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_dmg1);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_Dmg1);
    ExBoss_Main_Dmg1();
}

void ExBoss_Main_Dmg1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
        ExBoss_Action_FinishDmg();
    else
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
}

void ExBoss_Action_FinishDmg(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->aniBoss.hitChecker.output.hasCollision = FALSE;
    work->aniBoss.hitChecker.output.isHurt       = FALSE;

    work->nextAttackState();
}

void ExBoss_Action_StartPhase1Defeat(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_bdmg0);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);
    ExBoss_SetBossFleeing(TRUE);

    SetCurrentExTaskMainEvent(ExBoss_Main_BDmg0_Phase1Complete);
    ExBoss_Main_BDmg0_Phase1Complete();
}

void ExBoss_Main_BDmg0_Phase1Complete(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
        ExBoss_Action_StartPhase2();
    else
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
}

void ExBoss_Action_StartPhase2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->aniBoss.model.translation.y = EX_STAGE_BOUNDARY_B;

    SetCurrentExTaskMainEvent(ExBoss_Main_WaitForPhase2Regenerate);
    ExBoss_Main_WaitForPhase2Regenerate();
}

void ExBoss_Main_WaitForPhase2Regenerate(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    if (ExBoss_IsBossFleeing() == FALSE)
        ExBoss_Action_RegenerateForPhase2();
}

void ExBoss_Action_RegenerateForPhase2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    SetCurrentExTaskMainEvent(ExBoss_Main_RegenerateForPhase2);
    ExBoss_Main_RegenerateForPhase2();
}

void ExBoss_Main_RegenerateForPhase2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    HandleExBossMovement();

    // Regenerate to 2/3 the maximum health
    s16 targetHealth = 2 * (GetExBossWork()->maxHealth / 3);

    if (GetExBossWork()->health < targetHealth)
    {
        GetExBossWork()->health++;
    }
    else
    {
        GetExBossWork()->health = targetHealth + 1;

        if (work->aniBoss.model.translation.y <= FLOAT_TO_FX32(100.0))
        {
            ExBoss_Action_FinishRegenerateForPhase2();
            return;
        }
    }

    AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
}

void ExBoss_Action_FinishRegenerateForPhase2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->aniBoss.hitChecker.output.hasCollision = FALSE;
    work->aniBoss.hitChecker.output.isHurt       = FALSE;

    GetExSystemStatus()->state = EXSYSTASK_STATE_BOSS_HEAL_PHASE2_DONE;

    // Always start phase 2 with a magma eruption
    work->attackFlags.doMagmaWave = TRUE;
    work->nextAttackState();
}

void ExBoss_Action_StartPhase2Defeat(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_bdmg1);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);
    ExBoss_SetBossFleeing(TRUE);

    SetCurrentExTaskMainEvent(ExBoss_Main_BDmg1_Phase2Complete);
    ExBoss_Main_BDmg1_Phase2Complete();
}

void ExBoss_Main_BDmg1_Phase2Complete(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
        ExBoss_Action_StartPhase3();
    else
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
}

void ExBoss_Action_StartPhase3(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->aniBoss.model.translation.y = EX_STAGE_BOUNDARY_B;
    PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_ZONE_SEQ_SEQ_BOSSEW);

    SetCurrentExTaskMainEvent(ExBoss_Main_WaitForPhase3Regenerate);
    ExBoss_Main_WaitForPhase3Regenerate();
}

void ExBoss_Main_WaitForPhase3Regenerate(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    if (ExBoss_IsBossFleeing() == FALSE)
        ExBoss_Action_RegenerateForPhase3();
}

void ExBoss_Action_RegenerateForPhase3(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    SetCurrentExTaskMainEvent(ExBoss_Main_RegenerateForPhase3);
    ExBoss_Main_RegenerateForPhase3();
}

void ExBoss_Main_RegenerateForPhase3(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    HandleExBossMovement();

    // Regenerate to 1/3 the maximum health
    s16 targetHealth = (GetExBossWork()->maxHealth / 3);

    if (GetExBossWork()->health < targetHealth)
    {
        GetExBossWork()->health++;
    }
    else
    {
        GetExBossWork()->health = targetHealth + 1;

        if (work->aniBoss.model.translation.y <= FLOAT_TO_FX32(100.0))
        {
            ExBoss_Action_FinishRegenerateForPhase3();
            return;
        }
    }

    AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
}

void ExBoss_Action_FinishRegenerateForPhase3(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->aniBoss.hitChecker.output.hasCollision = FALSE;
    work->aniBoss.hitChecker.output.isHurt       = FALSE;

    GetExSystemStatus()->state = EXSYSTASK_STATE_BOSS_HEAL_PHASE3_DONE;

    // Always start phase 3 with a line missile
    work->attackFlags.doLineMissile = TRUE;
    work->nextAttackState();
}

void ExBoss_Action_StartPhase3Defeat(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_bdmg1);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);
    ExBoss_SetBossFleeing(TRUE);

    SetCurrentExTaskMainEvent(ExBoss_Main_BDmg1_BossDefeated);
    ExBoss_Main_BDmg1_BossDefeated();
}

void ExBoss_Main_BDmg1_BossDefeated(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
        ExBoss_Action_StartBossDefeat();
    else
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
}

void ExBoss_Action_StartBossDefeat(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    SetCurrentExTaskMainEvent(ExBoss_Main_WaitForFleeFinish);
    ExBoss_Main_WaitForFleeFinish();
}

void ExBoss_Main_WaitForFleeFinish(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    if (ExBoss_IsBossFleeing() == FALSE)
        ExBoss_Action_AppearForDefeat();
}

void ExBoss_Action_AppearForDefeat(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->aniBoss.model.translation.y = EX_STAGE_BOUNDARY_B;

    SetCurrentExTaskMainEvent(ExBoss_Main_DefeatedFlashing);
    ExBoss_Main_DefeatedFlashing();
}

void ExBoss_Main_DefeatedFlashing(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    HandleExBossMovement();

    if (work->aniBoss.model.translation.y <= FLOAT_TO_FX32(100.0))
    {
        ExBoss_Action_FinalizeDefeatedFlashing();
    }
    else
    {
        if (!Camera3D__UseEngineA())
        {
            if (work->moveFlags.flashTimer++ != 0)
                SetExDrawLightType(&work->aniBoss.config, EXDRAWREQ_LIGHT_RED);
            else
                SetExDrawLightType(&work->aniBoss.config, EXDRAWREQ_LIGHT_DEFAULT);
        }
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
    }
}

void ExBoss_Action_FinalizeDefeatedFlashing(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->genericCooldown = 1;

    SetCurrentExTaskMainEvent(ExBoss_Main_FinalizeDefeatedFlashing);
    ExBoss_Main_FinalizeDefeatedFlashing();
}

void ExBoss_Main_FinalizeDefeatedFlashing(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    if (work->genericCooldown <= 0)
    {
        work->genericCooldown = 0;
        ExBoss_Action_SetDefeated();
    }
    else
    {
        work->genericCooldown--;
        if (!Camera3D__UseEngineA())
        {
            if (work->moveFlags.flashTimer++ != 0)
                SetExDrawLightType(&work->aniBoss.config, EXDRAWREQ_LIGHT_RED);
            else
                SetExDrawLightType(&work->aniBoss.config, EXDRAWREQ_LIGHT_DEFAULT);
        }
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
    }
}

void ExBoss_Action_SetDefeated(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    GetExSystemStatus()->finishMode = EXFINISHMODE_BOSS_DEFEATED;

    SetCurrentExTaskMainEvent(ExBoss_Main_Defeated);
    ExBoss_Main_Defeated();
}

void ExBoss_Main_Defeated(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (!Camera3D__UseEngineA())
    {
        if (work->moveFlags.flashTimer++ != 0)
            SetExDrawLightType(&work->aniBoss.config, EXDRAWREQ_LIGHT_RED);
        else
            SetExDrawLightType(&work->aniBoss.config, EXDRAWREQ_LIGHT_DEFAULT);
    }
    AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
}