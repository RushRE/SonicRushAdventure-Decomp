#include <ex/effects/exBossHitEffect.h>
#include <ex/effects/exBossFireballShotEffect.h>
#include <ex/effects/exBossFireballEffect.h>
#include <ex/effects/exBossHomingEffect.h>
#include <ex/effects/exBossShotEffect.h>
#include <ex/effects/exBossFireEffect.h>
#include <ex/boss/exBoss.h>
#include <ex/system/exSystem.h>
#include <game/file/binaryBundle.h>
#include <game/audio/audioSystem.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

static s16 sExBossEffectHitInstanceCount;
static s16 sExBossEffectFireBallInstanceCount;
static s16 sExBossEffectFireInstanceCount;
static s16 sExBossEffectShotInstanceCount;
static s16 sExBossEffectHomingInstanceCount;
static s16 sExBossEffectFireBallShotInstanceCount;

static void *sExBossEffectFireTaskSingleton;
static void *sExBossEffectFireUnused;
static void *sExBossEffectShotModelResource;
static u32 sExBossEffectFireBallModelFileSize;
static BOOL sExBossEffectHitEnabled;
static void *sExBossEffectHitLastSpawnedWorker;
static void *sExBossEffectShotLastSpawnedWorker;
static void *sExBossEffectHitUnused;
static void *sExBossEffectHomingTaskSingleton;
static void *sExBossEffectFireBallShotModelResource;
static void *sExBossEffectHomingUnused;
static void *sExBossEffectFireLastSpawnedWorker;
static void *sExBossEffectFireModelResource;
static void *sExBossEffectFireBallShotUnused;
static BOOL sExBossEffectShotEnabled;
static void *sExBossEffectShotTaskSingleton;
static u32 sExBossEffectShotTextureFileSize;
static u32 sExBossEffectFireBallShotModelFileSize;
static void *sExBossEffectFireBallUnused;
static s32 sExBossEffectFireEnabled;
static void *sExBossEffectFireBallShotLastSpawnedWorker;
static u32 sExBossEffectHitModelFileSize;
static u32 sExBossEffectFireTextureFileSize;
static BOOL sExBossEffectHomingEnabled;
static u32 sExBossEffectHomingTextureFileSize;
static u32 sExBossEffectFireModelFileSize;
static void *sExBossEffectShotUnused;
static void *sExBossEffectHomingLastSpawnedWorker;
static void *sExBossEffectHomingModelResource;
static u32 sExBossEffectHomingModelFileSize;
static BOOL sExBossEffectFireBallEnabled;
static void *sExBossEffectFireBallTaskSingleton;
static u32 sExBossEffectFireBallTextureFileSize;
static u32 sExBossEffectHitTextureFileSize;
static void *sExBossEffectHitModelResource;
static void *sExBossEffectFireBallLastSpawnedWorker;
static void *sExBossEffectFireBallModelResource;
static void *sExBossEffectHitTaskSingleton;
static BOOL sExBossEffectFireBallShotEnabled;
static void *sExBossEffectFireBallShotTaskSingleton;
static u32 sExBossEffectFireBallShotTextureFileSize;
static u32 sExBossEffectShotModelFileSize;

static u32 sExBossEffectHitAnimType[2];
static u32 sExBossEffectFireBallShotAnimType[2];
static void *sExBossEffectShotAnimResource[2];
static u32 sExBossEffectShotAnimType[2];
static void *sExBossEffectHitAnimResource[2];
static void *sExBossEffectFireBallShotAnimResource[2];
static u32 sExBossEffectHomingAnimType[4];
static void *sExBossEffectFireBallAnimResource[4];
static void *sExBossEffectFireAnimResource[4];
static u32 sExBossEffectFireBallAnimType[4];
static u32 sExBossEffectFireAnimType[4];
static void *sExBossEffectHomingAnimResource[4];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(sExBossEffectHitUnused)
FORCE_INCLUDE_VARIABLE_BSS(sExBossEffectFireBallShotUnused)
FORCE_INCLUDE_VARIABLE_BSS(sExBossEffectFireBallUnused)
FORCE_INCLUDE_VARIABLE_BSS(sExBossEffectHomingUnused)
FORCE_INCLUDE_VARIABLE_BSS(sExBossEffectShotUnused)
FORCE_INCLUDE_VARIABLE_BSS(sExBossEffectFireUnused)

// --------------------
// FUNCTION DECLS
// --------------------

// exBossEffectHit
static BOOL LoadExBossEffectHitAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBossEffectHitAssets(EX_ACTION_NN_WORK *work);
static void ExBossEffectHit_Main_Init(void);
static void ExBossEffectHit_OnCheckStageFinished(void);
static void ExBossEffectHit_Destructor(void);
static void ExBossEffectHit_Main_Active(void);

// exBossEffectFireBallShot
static BOOL LoadExBossEffectFireballShotAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBossEffectFireballShotAssets(EX_ACTION_NN_WORK *work);
static void ExBossEffectFireballShot_Main_Init(void);
static void ExBossEffectFireballShot_OnCheckStageFinished(void);
static void ExBossEffectFireballShot_Destructor(void);
static void ExBossEffectFireballShot_Main_Active(void);

// exBossEffectFireBall
static BOOL LoadExBossEffectFireballAssets(EX_ACTION_NN_WORK *work);
static void SetExBossEffectFireballAnimation(EX_ACTION_NN_WORK *work, u16 animID);
static void ReleaseExBossEffectFireballAssets(EX_ACTION_NN_WORK *work);
static void ExBossEffectFireball_Main_Init(void);
static void ExBossEffectFireball_OnCheckStageFinished(void);
static void ExBossEffectFireball_Destructor(void);
static void ExBossEffectFireball_Main_Appear(void);
static void ExBossEffectFireball_Action_SetActive(void);
static void ExBossEffectFireball_Main_Active(void);
static void ExBossEffectFireball_Action_Disappear(void);
static void ExBossEffectFireball_Main_Disappear(void);

// exBossEffectHoming
static BOOL LoadExEffectHomingAssets(EX_ACTION_NN_WORK *work);
static void SetExBossEffectHomingAnimation(EX_ACTION_NN_WORK *work, u16 animID);
static void ReleaseExBossEffectHomingAssets(EX_ACTION_NN_WORK *work);
static void ExBossEffectHoming_Main_Init(void);
static void ExBossEffectHoming_OnCheckStageFinished(void);
static void ExBossEffectHoming_Destructor(void);
static void ExBossEffectHoming_Main_Appear(void);
static void ExBossEffectHoming_Action_SetActive(void);
static void ExBossEffectHoming_Main_Active(void);
static void ExBossEffectHoming_Action_Disappear(void);
static void ExBossEffectHoming_Main_Disappear(void);

// exBossEffectShot
static BOOL LoadExBossEffectShotAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBossEffectShotAssets(EX_ACTION_NN_WORK *work);
static void ExBossEffectShot_Main_Init(void);
static void ExBossEffectShot_OnCheckStageFinished(void);
static void ExBossEffectShot_Destructor(void);
static void ExBossEffectShot_Main_Active(void);

// exBossEffectFire
static BOOL LoadExBossEffectFireAssets(EX_ACTION_NN_WORK *work);
static void SetExBossEffectFireAnimation(EX_ACTION_NN_WORK *work, u16 animID);
static void ReleaseExBossEffectFireAssets(EX_ACTION_NN_WORK *work);
static void ExBossEffectFire_Main_Init(void);
static void ExBossEffectFire_OnCheckStageFinished(void);
static void ExBossEffectFire_Destructor(void);
static void ExBossEffectFire_Main_Appear(void);
static void ExBossEffectFire_Action_SetActive(void);
static void ExBossEffectFire_Main_Active(void);
static void ExBossEffectFire_Action_Disappear(void);
static void ExBossEffectFire_Main_Disappear(void);

// --------------------
// FUNCTIONS
// --------------------

// exBossEffectHit
BOOL LoadExBossEffectHitAssets(EX_ACTION_NN_WORK *work)
{
    sExBossEffectHitLastSpawnedWorker = work;

    if (sExBossEffectHitModelFileSize != 0 && sExBossEffectHitTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < sExBossEffectHitModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < sExBossEffectHitTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < sExBossEffectHitModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (sExBossEffectHitInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_HITC_NSBMD, &sExBossEffectHitModelResource, &sExBossEffectHitModelFileSize, TRUE,
                                      FALSE);

        sExBossEffectHitAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_HITC_NSBCA);
        sExBossEffectHitAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        sExBossEffectHitAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_HITC_NSBTA);
        sExBossEffectHitAnimType[1]     = B3D_ANIM_TEX_ANIM;

        CreateAsset3DSetup(sExBossEffectHitModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sExBossEffectHitModelResource, 0, FALSE, FALSE);

    for (u16 i = 0; i < 2; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectHitAnimType[i], sExBossEffectHitAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = sExBossEffectHitAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[sExBossEffectHitAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(0.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z       = FLOAT_DEG_TO_IDX(179.96);

    work->hitChecker.type                    = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isBossHitEffect = TRUE;
    work->hitChecker.box.size.x              = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y              = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z              = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position            = &work->model.translation;

    sExBossEffectHitInstanceCount++;

    return TRUE;
}

void ReleaseExBossEffectHitAssets(EX_ACTION_NN_WORK *work)
{
    if (sExBossEffectHitInstanceCount <= 1)
    {
        if (sExBossEffectHitModelResource != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectHitModelResource);

        if (sExBossEffectHitAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectHitAnimResource[0]);

        if (sExBossEffectHitAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectHitAnimResource[1]);

        if (sExBossEffectHitModelResource != NULL)
            HeapFree(HEAP_USER, sExBossEffectHitModelResource);
        sExBossEffectHitModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    sExBossEffectHitInstanceCount--;
}

void ExBossEffectHit_Main_Init(void)
{
    exBossEffectHitTask *work = ExTaskGetWorkCurrent(exBossEffectHitTask);

    sExBossEffectHitTaskSingleton = GetCurrentTask();

    LoadExBossEffectHitAssets(&work->aniHit);
    SetExDrawRequestPriority(&work->aniHit.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniHit.config);

    work->aniHit.model.translation.x = work->parent->aniBoss.model.bossChestPos.x;
    work->aniHit.model.translation.y = work->parent->aniBoss.model.bossChestPos.y;
    work->aniHit.model.translation.z = work->parent->aniBoss.model.bossChestPos.z;

    sExBossEffectHitEnabled = TRUE;

    SetCurrentExTaskMainEvent(ExBossEffectHit_Main_Active);
}

void ExBossEffectHit_OnCheckStageFinished(void)
{
    exBossEffectHitTask *work = ExTaskGetWorkCurrent(exBossEffectHitTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();

    if (ExBoss_IsBossFleeing() == TRUE)
        DestroyCurrentExTask();
}

void ExBossEffectHit_Destructor(void)
{
    exBossEffectHitTask *work = ExTaskGetWorkCurrent(exBossEffectHitTask);

    ReleaseExBossEffectHitAssets(&work->aniHit);

    sExBossEffectHitTaskSingleton = NULL;
}

void ExBossEffectHit_Main_Active(void)
{
    exBossEffectHitTask *work = ExTaskGetWorkCurrent(exBossEffectHitTask);

    AnimateExDrawRequestModel(&work->aniHit);

    if (GetExBossTask() == NULL)
    {
        DestroyCurrentExTask();
    }
    else
    {
        if (IsExDrawRequestModelAnimFinished(&work->aniHit))
        {
            DestroyCurrentExTask();
        }
        else
        {
            AddExDrawRequest(&work->aniHit, &work->aniHit.config);

            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

BOOL CreateExBossEffectHit(void)
{
    Task *task =
        ExTaskCreate(ExBossEffectHit_Main_Init, ExBossEffectHit_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exBossEffectHitTask);

    exBossEffectHitTask *work = ExTaskGetWork(task, exBossEffectHitTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWork(GetExBossTask(), exBossSysAdminTask);

    SetExTaskOnCheckStageFinishedEvent(task, ExBossEffectHit_OnCheckStageFinished);

    return TRUE;
}

// exBossEffectFireBallShot
BOOL LoadExBossEffectFireballShotAssets(EX_ACTION_NN_WORK *work)
{
    sExBossEffectFireBallShotLastSpawnedWorker = work;

    if (sExBossEffectFireBallShotModelFileSize != 0 && sExBossEffectFireBallShotTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < sExBossEffectFireBallShotModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < sExBossEffectFireBallShotTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < sExBossEffectFireBallShotModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (sExBossEffectFireBallShotInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_FBSHK_NSBMD, &sExBossEffectFireBallShotModelResource,
                                      &sExBossEffectFireBallShotModelFileSize, TRUE, FALSE);

        sExBossEffectFireBallShotAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FBSHK_NSBCA);
        sExBossEffectFireBallShotAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        sExBossEffectFireBallShotAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FBSHK_NSBVA);
        sExBossEffectFireBallShotAnimType[1]     = B3D_ANIM_VIS_ANIM;

        CreateAsset3DSetup(sExBossEffectFireBallShotModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sExBossEffectFireBallShotModelResource, 0, FALSE, FALSE);

    for (u16 i = 0; i < 2; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectFireBallShotAnimType[i], sExBossEffectFireBallShotAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = sExBossEffectFireBallShotAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[sExBossEffectFireBallShotAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(0.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z       = FLOAT_DEG_TO_IDX(179.96);

    work->hitChecker.type                           = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isBossFireballShotEffect = TRUE;
    work->hitChecker.box.size.x                     = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.size.y                     = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.size.z                     = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.position                   = &work->model.translation;

    sExBossEffectFireBallShotInstanceCount++;

    return TRUE;
}

void ReleaseExBossEffectFireballShotAssets(EX_ACTION_NN_WORK *work)
{
    if (sExBossEffectFireBallShotInstanceCount <= 1)
    {
        if (sExBossEffectFireBallShotModelResource != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectFireBallShotModelResource);

        if (sExBossEffectFireBallShotAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectFireBallShotAnimResource[0]);

        if (sExBossEffectFireBallShotAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectFireBallShotAnimResource[1]);

        if (sExBossEffectFireBallShotModelResource != NULL)
            HeapFree(HEAP_USER, sExBossEffectFireBallShotModelResource);
        sExBossEffectFireBallShotModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    sExBossEffectFireBallShotInstanceCount--;
}

void ExBossEffectFireballShot_Main_Init(void)
{
    exBossEffectFireBallShotTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallShotTask);

    sExBossEffectFireBallShotTaskSingleton = GetCurrentTask();

    LoadExBossEffectFireballShotAssets(&work->aniShot);
    SetExDrawRequestPriority(&work->aniShot.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniShot.config);

    work->aniShot.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
    work->aniShot.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
    work->aniShot.model.translation.z = work->parent->aniBoss.model.bossStaffPos.z;

    sExBossEffectFireBallShotEnabled = TRUE;

    SetCurrentExTaskMainEvent(ExBossEffectFireballShot_Main_Active);
}

void ExBossEffectFireballShot_OnCheckStageFinished(void)
{
    exBossEffectFireBallShotTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallShotTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();

    if (ExBoss_IsBossFleeing() == TRUE)
        DestroyCurrentExTask();
}

void ExBossEffectFireballShot_Destructor(void)
{
    exBossEffectFireBallShotTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallShotTask);

    ReleaseExBossEffectFireballShotAssets(&work->aniShot);

    sExBossEffectFireBallShotTaskSingleton = NULL;
}

void ExBossEffectFireballShot_Main_Active(void)
{
    exBossEffectFireBallShotTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallShotTask);

    AnimateExDrawRequestModel(&work->aniShot);

    if (GetExBossTask() == NULL)
    {
        DestroyCurrentExTask();
    }
    else if (IsExDrawRequestModelAnimFinished(&work->aniShot))
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->aniShot, &work->aniShot.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

BOOL CreateExBossEffectFireballShot(void)
{
    Task *task = ExTaskCreate(ExBossEffectFireballShot_Main_Init, ExBossEffectFireballShot_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0,
                              EXTASK_TYPE_REGULAR, exBossEffectFireBallShotTask);

    exBossEffectFireBallShotTask *work = ExTaskGetWork(task, exBossEffectFireBallShotTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExTaskOnCheckStageFinishedEvent(task, ExBossEffectFireballShot_OnCheckStageFinished);

    return TRUE;
}

void DisableExBossEffectFireballShot(void)
{
    sExBossEffectFireBallShotEnabled = FALSE;
}

// exBossEffectFireBall
BOOL LoadExBossEffectFireballAssets(EX_ACTION_NN_WORK *work)
{
    sExBossEffectFireBallLastSpawnedWorker = work;

    if (sExBossEffectFireBallModelFileSize != 0 && sExBossEffectFireBallTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < sExBossEffectFireBallModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < sExBossEffectFireBallTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < sExBossEffectFireBallModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (sExBossEffectFireBallInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_SFB_NSBMD, &sExBossEffectFireBallModelResource, &sExBossEffectFireBallModelFileSize,
                                      TRUE, FALSE);

        sExBossEffectFireBallAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFB_NSBCA);
        sExBossEffectFireBallAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        sExBossEffectFireBallAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFB_NSBMA);
        sExBossEffectFireBallAnimType[1]     = B3D_ANIM_MAT_ANIM;

        sExBossEffectFireBallAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFB_NSBTA);
        sExBossEffectFireBallAnimType[2]     = B3D_ANIM_TEX_ANIM;

        sExBossEffectFireBallAnimResource[3] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFB_NSBTP);
        sExBossEffectFireBallAnimType[3]     = B3D_ANIM_PAT_ANIM;

        CreateAsset3DSetup(sExBossEffectFireBallModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sExBossEffectFireBallModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (i = 0; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectFireBallAnimType[i], sExBossEffectFireBallAnimResource[i], 0, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectFireBallAnimType[i], sExBossEffectFireBallAnimResource[i], 0, NNS_G3dGetTex(sExBossEffectFireBallModelResource));

    work->model.primaryAnimType     = sExBossEffectFireBallAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[sExBossEffectFireBallAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(0.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z       = FLOAT_DEG_TO_IDX(179.96);

    work->hitChecker.type                       = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isBossFireballEffect = TRUE;
    work->hitChecker.box.size.x                 = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.size.y                 = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.size.z                 = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.position               = &work->model.translation;

    sExBossEffectFireBallInstanceCount++;

    return TRUE;
}

void SetExBossEffectFireballAnimation(EX_ACTION_NN_WORK *work, u16 animID)
{
    u16 i = 0;
    for (; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectFireBallAnimType[i], sExBossEffectFireBallAnimResource[i], animID, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectFireBallAnimType[i], sExBossEffectFireBallAnimResource[i], animID,
                              NNS_G3dGetTex(sExBossEffectFireBallModelResource));

    work->model.primaryAnimType     = sExBossEffectFireBallAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[sExBossEffectFireBallAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }
}

void ReleaseExBossEffectFireballAssets(EX_ACTION_NN_WORK *work)
{
    if (sExBossEffectFireBallInstanceCount <= 1)
    {
        if (sExBossEffectFireBallModelResource)
            NNS_G3dResDefaultRelease(sExBossEffectFireBallModelResource);

        if (sExBossEffectFireBallAnimResource[0])
            NNS_G3dResDefaultRelease(sExBossEffectFireBallAnimResource[0]);

        if (sExBossEffectFireBallAnimResource[1])
            NNS_G3dResDefaultRelease(sExBossEffectFireBallAnimResource[1]);

        if (sExBossEffectFireBallAnimResource[2])
            NNS_G3dResDefaultRelease(sExBossEffectFireBallAnimResource[2]);

        if (sExBossEffectFireBallAnimResource[3])
            NNS_G3dResDefaultRelease(sExBossEffectFireBallAnimResource[3]);

        if (sExBossEffectFireBallModelResource)
            HeapFree(HEAP_USER, sExBossEffectFireBallModelResource);
        sExBossEffectFireBallModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    sExBossEffectFireBallInstanceCount--;
}

void ExBossEffectFireball_Main_Init(void)
{
    exBossEffectFireBallTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallTask);

    sExBossEffectFireBallTaskSingleton = GetCurrentTask();

    LoadExBossEffectFireballAssets(&work->aniFire);
    SetExDrawRequestPriority(&work->aniFire.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniFire.config);

    sExBossEffectFireBallEnabled = TRUE;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FIRE_CHARGE);

    SetCurrentExTaskMainEvent(ExBossEffectFireball_Main_Appear);
}

void ExBossEffectFireball_OnCheckStageFinished(void)
{
    exBossEffectFireBallTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();

    if (ExBoss_IsBossFleeing() == TRUE)
        DestroyCurrentExTask();
}

void ExBossEffectFireball_Destructor(void)
{
    exBossEffectFireBallTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallTask);

    ReleaseExBossEffectFireballAssets(&work->aniFire);

    sExBossEffectFireBallTaskSingleton = NULL;
}

void ExBossEffectFireball_Main_Appear(void)
{
    exBossEffectFireBallTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallTask);

    AnimateExDrawRequestModel(&work->aniFire);

    if (GetExBossTask() == NULL)
    {
        DestroyCurrentExTask();
    }
    else
    {
        work->aniFire.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
        work->aniFire.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
        work->aniFire.model.translation.z = work->parent->aniBoss.model.bossStaffPos.z;

        if (IsExDrawRequestModelAnimFinished(&work->aniFire))
        {
            ExBossEffectFireball_Action_SetActive();
        }
        else
        {
            AddExDrawRequest(&work->aniFire, &work->aniFire.config);

            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

void ExBossEffectFireball_Action_SetActive(void)
{
    exBossEffectFireBallTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallTask);

    SetExBossEffectFireballAnimation(&work->aniFire, 1);
    SetExDrawRequestAnimAsOneShot(&work->aniFire.config);

    SetCurrentExTaskMainEvent(ExBossEffectFireball_Main_Active);
    ExBossEffectFireball_Main_Active();
}

void ExBossEffectFireball_Main_Active(void)
{
    exBossEffectFireBallTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallTask);

    AnimateExDrawRequestModel(&work->aniFire);

    if (GetExBossTask() == NULL)
    {
        DestroyCurrentExTask();
    }
    else
    {
        work->aniFire.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
        work->aniFire.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
        work->aniFire.model.translation.z = work->parent->aniBoss.model.bossStaffPos.z;

        if (sExBossEffectFireBallEnabled == FALSE)
        {
            ExBossEffectFireball_Action_Disappear();
        }
        else
        {
            AddExDrawRequest(&work->aniFire, &work->aniFire.config);

            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

void ExBossEffectFireball_Action_Disappear(void)
{
    exBossEffectFireBallTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallTask);

    SetExBossEffectFireballAnimation(&work->aniFire, 2);
    SetExDrawRequestAnimStopOnFinish(&work->aniFire.config);

    SetCurrentExTaskMainEvent(ExBossEffectFireball_Main_Disappear);
    ExBossEffectFireball_Main_Disappear();
}

void ExBossEffectFireball_Main_Disappear(void)
{
    exBossEffectFireBallTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallTask);

    AnimateExDrawRequestModel(&work->aniFire);

    if (GetExBossTask() == NULL)
    {
        DestroyCurrentExTask();
    }
    else
    {
        work->aniFire.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
        work->aniFire.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
        work->aniFire.model.translation.z = work->parent->aniBoss.model.bossStaffPos.z;

        if (IsExDrawRequestModelAnimFinished(&work->aniFire))
        {
            DestroyCurrentExTask();
        }
        else
        {
            AddExDrawRequest(&work->aniFire, &work->aniFire.config);

            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

BOOL CreateExBossEffectFireball(void)
{
    Task *task = ExTaskCreate(ExBossEffectFireball_Main_Init, ExBossEffectFireball_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exBossEffectFireBallTask);

    exBossEffectFireBallTask *work = ExTaskGetWork(task, exBossEffectFireBallTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExTaskOnCheckStageFinishedEvent(task, ExBossEffectFireball_OnCheckStageFinished);

    return TRUE;
}

void DisableExBossEffectFireball(void)
{
    sExBossEffectFireBallEnabled = FALSE;
}

// exBossEffectHoming
BOOL LoadExEffectHomingAssets(EX_ACTION_NN_WORK *work)
{
    sExBossEffectHomingLastSpawnedWorker = work;

    if (sExBossEffectHomingModelFileSize != 0 && sExBossEffectHomingTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < sExBossEffectHomingModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < sExBossEffectHomingTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < sExBossEffectHomingModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (sExBossEffectHomingInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_SHOMI_NSBMD, &sExBossEffectHomingModelResource, &sExBossEffectHomingModelFileSize,
                                      TRUE, FALSE);

        sExBossEffectHomingAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SHOMI_NSBCA);
        sExBossEffectHomingAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        sExBossEffectHomingAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SHOMI_NSBMA);
        sExBossEffectHomingAnimType[1]     = B3D_ANIM_MAT_ANIM;

        sExBossEffectHomingAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SHOMI_NSBTA);
        sExBossEffectHomingAnimType[2]     = B3D_ANIM_TEX_ANIM;

        sExBossEffectHomingAnimResource[3] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SHOMI_NSBTP);
        sExBossEffectHomingAnimType[3]     = B3D_ANIM_PAT_ANIM;

        CreateAsset3DSetup(sExBossEffectHomingModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sExBossEffectHomingModelResource, 0, FALSE, FALSE);

    for (u16 i = 0; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectHomingAnimType[i], sExBossEffectHomingAnimResource[i], 0, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectHomingAnimType[3], sExBossEffectHomingAnimResource[3], 0, NNS_G3dGetTex(sExBossEffectHomingModelResource));

    work->model.primaryAnimType     = sExBossEffectHomingAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[sExBossEffectHomingAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(0.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z       = FLOAT_DEG_TO_IDX(179.96);

    work->hitChecker.type                     = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isBossHomingEffect = TRUE;
    work->hitChecker.box.size.x               = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.size.y               = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.size.z               = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.position             = &work->model.translation;

    sExBossEffectHomingInstanceCount++;

    return TRUE;
}

void SetExBossEffectHomingAnimation(EX_ACTION_NN_WORK *work, u16 animID)
{
    for (u16 i = 0; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectHomingAnimType[i], sExBossEffectHomingAnimResource[i], animID, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectHomingAnimType[3], sExBossEffectHomingAnimResource[3], animID, NNS_G3dGetTex(sExBossEffectHomingModelResource));

    work->model.primaryAnimType     = sExBossEffectHomingAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[sExBossEffectHomingAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }
}

void ReleaseExBossEffectHomingAssets(EX_ACTION_NN_WORK *work)
{
    if (sExBossEffectHomingInstanceCount <= 1)
    {
        if (sExBossEffectHomingModelResource != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectHomingModelResource);

        if (sExBossEffectHomingAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectHomingAnimResource[0]);

        if (sExBossEffectHomingAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectHomingAnimResource[1]);

        if (sExBossEffectHomingAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectHomingAnimResource[2]);

        if (sExBossEffectHomingAnimResource[3] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectHomingAnimResource[3]);

        if (sExBossEffectHomingModelResource != NULL)
            HeapFree(HEAP_USER, sExBossEffectHomingModelResource);
        sExBossEffectHomingModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    sExBossEffectHomingInstanceCount--;
}

void ExBossEffectHoming_Main_Init(void)
{
    exBossEffectHomingTask *work = ExTaskGetWorkCurrent(exBossEffectHomingTask);

    sExBossEffectHomingTaskSingleton = GetCurrentTask();

    LoadExEffectHomingAssets(&work->aniHoming);
    SetExDrawRequestPriority(&work->aniHoming.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniHoming.config);

    sExBossEffectHomingEnabled = TRUE;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_LASER_CHARGE);

    SetCurrentExTaskMainEvent(ExBossEffectHoming_Main_Appear);
}

void ExBossEffectHoming_OnCheckStageFinished(void)
{
    exBossEffectHomingTask *work = ExTaskGetWorkCurrent(exBossEffectHomingTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();

    if (ExBoss_IsBossFleeing() == TRUE)
        DestroyCurrentExTask();
}

void ExBossEffectHoming_Destructor(void)
{
    exBossEffectHomingTask *work = ExTaskGetWorkCurrent(exBossEffectHomingTask);

    ReleaseExBossEffectHomingAssets(&work->aniHoming);

    sExBossEffectHomingTaskSingleton = NULL;
}

void ExBossEffectHoming_Main_Appear(void)
{
    exBossEffectHomingTask *work = ExTaskGetWorkCurrent(exBossEffectHomingTask);

    AnimateExDrawRequestModel(&work->aniHoming);

    if (GetExBossTask() == NULL)
    {
        DestroyCurrentExTask();
    }
    else
    {
        work->aniHoming.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
        work->aniHoming.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
        work->aniHoming.model.translation.z = work->parent->aniBoss.model.bossStaffPos.z;

        if (IsExDrawRequestModelAnimFinished(&work->aniHoming))
        {
            ExBossEffectHoming_Action_SetActive();
        }
        else
        {
            AddExDrawRequest(&work->aniHoming, &work->aniHoming.config);

            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

void ExBossEffectHoming_Action_SetActive(void)
{
    exBossEffectHomingTask *work = ExTaskGetWorkCurrent(exBossEffectHomingTask);

    SetExBossEffectHomingAnimation(&work->aniHoming, 1);
    SetExDrawRequestAnimAsOneShot(&work->aniHoming.config);

    SetCurrentExTaskMainEvent(ExBossEffectHoming_Main_Active);
    ExBossEffectHoming_Main_Active();
}

void ExBossEffectHoming_Main_Active(void)
{
    exBossEffectHomingTask *work = ExTaskGetWorkCurrent(exBossEffectHomingTask);

    AnimateExDrawRequestModel(&work->aniHoming);

    if (GetExBossTask() == NULL)
    {
        DestroyCurrentExTask();
    }
    else
    {
        work->aniHoming.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
        work->aniHoming.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
        work->aniHoming.model.translation.z = work->parent->aniBoss.model.bossStaffPos.z;

        if (sExBossEffectHomingEnabled == FALSE)
        {
            ExBossEffectHoming_Action_Disappear();
        }
        else
        {
            AddExDrawRequest(&work->aniHoming, &work->aniHoming.config);

            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

void ExBossEffectHoming_Action_Disappear(void)
{
    exBossEffectHomingTask *work = ExTaskGetWorkCurrent(exBossEffectHomingTask);

    SetExBossEffectHomingAnimation(&work->aniHoming, 2);
    SetExDrawRequestAnimStopOnFinish(&work->aniHoming.config);

    SetCurrentExTaskMainEvent(ExBossEffectHoming_Main_Disappear);
    ExBossEffectHoming_Main_Disappear();
}

void ExBossEffectHoming_Main_Disappear(void)
{
    exBossEffectHomingTask *work = ExTaskGetWorkCurrent(exBossEffectHomingTask);

    AnimateExDrawRequestModel(&work->aniHoming);

    if (!GetExBossTask())
    {
        DestroyCurrentExTask();
    }
    else
    {
        work->aniHoming.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
        work->aniHoming.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
        work->aniHoming.model.translation.z = work->parent->aniBoss.model.bossStaffPos.z;

        if (IsExDrawRequestModelAnimFinished(&work->aniHoming))
        {
            DestroyCurrentExTask();
        }
        else
        {
            AddExDrawRequest(&work->aniHoming, &work->aniHoming.config);

            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

BOOL CreateExBossEffectHoming(void)
{
    Task *task = ExTaskCreate(ExBossEffectHoming_Main_Init, ExBossEffectHoming_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exBossEffectHomingTask);

    exBossEffectHomingTask *work = ExTaskGetWork(task, exBossEffectHomingTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExTaskOnCheckStageFinishedEvent(task, ExBossEffectHoming_OnCheckStageFinished);

    return TRUE;
}

void DisableExBossEffectHoming(void)
{
    sExBossEffectHomingEnabled = FALSE;
}

// exBossEffectShot
BOOL LoadExBossEffectShotAssets(EX_ACTION_NN_WORK *work)
{
    sExBossEffectShotLastSpawnedWorker = work;

    if (sExBossEffectShotModelFileSize != 0 && sExBossEffectShotTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < sExBossEffectShotModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < sExBossEffectShotTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < sExBossEffectShotModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (sExBossEffectShotInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_FSHK_NSBMD, &sExBossEffectShotModelResource, &sExBossEffectShotModelFileSize, TRUE,
                                      FALSE);

        sExBossEffectShotAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FSHK_NSBCA);
        sExBossEffectShotAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        sExBossEffectShotAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FSHK_NSBVA);
        sExBossEffectShotAnimType[1]     = B3D_ANIM_VIS_ANIM;

        CreateAsset3DSetup(sExBossEffectShotModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sExBossEffectShotModelResource, 0, FALSE, FALSE);

    for (u16 i = 0; i < 2; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectShotAnimType[i], sExBossEffectShotAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = sExBossEffectShotAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[sExBossEffectShotAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(0.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z       = FLOAT_DEG_TO_IDX(179.96);

    work->hitChecker.type                   = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isBossShotEffect = TRUE;
    work->hitChecker.box.size.x             = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.size.y             = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.size.z             = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.position           = &work->model.translation;

    sExBossEffectShotInstanceCount++;

    return TRUE;
}

void ReleaseExBossEffectShotAssets(EX_ACTION_NN_WORK *work)
{
    if (sExBossEffectShotInstanceCount <= 1)
    {
        if (sExBossEffectShotModelResource != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectShotModelResource);

        if (sExBossEffectShotAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectShotAnimResource[0]);

        if (sExBossEffectShotAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectShotAnimResource[1]);

        if (sExBossEffectShotModelResource != NULL)
            HeapFree(HEAP_USER, sExBossEffectShotModelResource);
        sExBossEffectShotModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    sExBossEffectShotInstanceCount--;
}

void ExBossEffectShot_Main_Init(void)
{
    exBossEffectShotTask *work = ExTaskGetWorkCurrent(exBossEffectShotTask);

    sExBossEffectShotTaskSingleton = GetCurrentTask();

    LoadExBossEffectShotAssets(&work->aniShot);
    SetExDrawRequestPriority(&work->aniShot.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniShot.config);

    work->aniShot.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
    work->aniShot.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
    work->aniShot.model.translation.z = work->parent->aniBoss.model.bossStaffPos.z;

    sExBossEffectShotEnabled = TRUE;

    SetCurrentExTaskMainEvent(ExBossEffectShot_Main_Active);
}

void ExBossEffectShot_OnCheckStageFinished(void)
{
    exBossEffectShotTask *work = ExTaskGetWorkCurrent(exBossEffectShotTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();

    if (ExBoss_IsBossFleeing() == TRUE)
        DestroyCurrentExTask();
}

void ExBossEffectShot_Destructor(void)
{
    exBossEffectShotTask *work = ExTaskGetWorkCurrent(exBossEffectShotTask);

    ReleaseExBossEffectShotAssets(&work->aniShot);

    sExBossEffectShotTaskSingleton = NULL;
}

void ExBossEffectShot_Main_Active(void)
{
    exBossEffectShotTask *work = ExTaskGetWorkCurrent(exBossEffectShotTask);

    AnimateExDrawRequestModel(&work->aniShot);

    if (GetExBossTask() == NULL)
    {
        DestroyCurrentExTask();
    }
    else
    {
        if (IsExDrawRequestModelAnimFinished(&work->aniShot))
        {
            DestroyCurrentExTask();
        }
        else
        {
            AddExDrawRequest(&work->aniShot, &work->aniShot.config);

            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

BOOL CreateExBossEffectShot(void)
{
    Task *task = ExTaskCreate(ExBossEffectShot_Main_Init, ExBossEffectShot_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exBossEffectShotTask);

    exBossEffectShotTask *work = ExTaskGetWork(task, exBossEffectShotTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExTaskOnCheckStageFinishedEvent(task, ExBossEffectShot_OnCheckStageFinished);

    return TRUE;
}

// exBossEffectFire
BOOL LoadExBossEffectFireAssets(EX_ACTION_NN_WORK *work)
{
    sExBossEffectFireLastSpawnedWorker = work;

    if (sExBossEffectFireModelFileSize != 0 && sExBossEffectFireTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < sExBossEffectFireModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < sExBossEffectFireTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < sExBossEffectFireModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (sExBossEffectFireInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_SFIRE_NSBMD, &sExBossEffectFireModelResource, &sExBossEffectFireModelFileSize, TRUE,
                                      FALSE);

        sExBossEffectFireAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFIRE_NSBCA);
        sExBossEffectFireAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        sExBossEffectFireAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFIRE_NSBMA);
        sExBossEffectFireAnimType[1]     = B3D_ANIM_MAT_ANIM;

        sExBossEffectFireAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFIRE_NSBTA);
        sExBossEffectFireAnimType[2]     = B3D_ANIM_TEX_ANIM;

        sExBossEffectFireAnimResource[3] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFIRE_NSBTP);
        sExBossEffectFireAnimType[3]     = B3D_ANIM_PAT_ANIM;

        CreateAsset3DSetup(sExBossEffectFireModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sExBossEffectFireModelResource, 0, FALSE, FALSE);

    for (u16 i = 0; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectFireAnimType[i], sExBossEffectFireAnimResource[i], 0, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectFireAnimType[3], sExBossEffectFireAnimResource[3], 0, NNS_G3dGetTex(sExBossEffectFireModelResource));

    work->model.primaryAnimType     = sExBossEffectFireAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[sExBossEffectFireAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(0.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z       = FLOAT_DEG_TO_IDX(179.96);

    work->hitChecker.type                   = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isBossFireEffect = TRUE;
    work->hitChecker.box.size.x             = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.size.y             = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.size.z             = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.position           = &work->model.translation;

    sExBossEffectFireInstanceCount++;

    return TRUE;
}

void SetExBossEffectFireAnimation(EX_ACTION_NN_WORK *work, u16 animID)
{
    for (u16 i = 0; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectFireAnimType[i], sExBossEffectFireAnimResource[i], animID, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, sExBossEffectFireAnimType[3], sExBossEffectFireAnimResource[3], animID, NNS_G3dGetTex(sExBossEffectFireModelResource));

    work->model.primaryAnimType     = sExBossEffectFireAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[sExBossEffectFireAnimType[0]];
    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }
}

void ReleaseExBossEffectFireAssets(EX_ACTION_NN_WORK *work)
{
    if (sExBossEffectFireInstanceCount <= 1)
    {
        if (sExBossEffectFireModelResource != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectFireModelResource);

        if (sExBossEffectFireAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectFireAnimResource[0]);

        if (sExBossEffectFireAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectFireAnimResource[1]);

        if (sExBossEffectFireAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectFireAnimResource[2]);

        if (sExBossEffectFireAnimResource[3] != NULL)
            NNS_G3dResDefaultRelease(sExBossEffectFireAnimResource[3]);

        if (sExBossEffectFireModelResource != NULL)
            HeapFree(HEAP_USER, sExBossEffectFireModelResource);
        sExBossEffectFireModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    sExBossEffectFireInstanceCount--;
}

void ExBossEffectFire_Main_Init(void)
{
    exBossEffectFireTask *work = ExTaskGetWorkCurrent(exBossEffectFireTask);

    sExBossEffectFireTaskSingleton = GetCurrentTask();

    LoadExBossEffectFireAssets(&work->aniFire);
    SetExDrawRequestPriority(&work->aniFire.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniFire.config);

    sExBossEffectFireEnabled = TRUE;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FIRE_CHARGE);

    SetCurrentExTaskMainEvent(ExBossEffectFire_Main_Appear);
}

void ExBossEffectFire_OnCheckStageFinished(void)
{
    exBossEffectFireTask *work = ExTaskGetWorkCurrent(exBossEffectFireTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();

    if (ExBoss_IsBossFleeing() == TRUE)
        DestroyCurrentExTask();
}

void ExBossEffectFire_Destructor(void)
{
    exBossEffectFireTask *work = ExTaskGetWorkCurrent(exBossEffectFireTask);

    ReleaseExBossEffectFireAssets(&work->aniFire);

    sExBossEffectFireTaskSingleton = NULL;
}

void ExBossEffectFire_Main_Appear(void)
{
    exBossEffectFireTask *work = ExTaskGetWorkCurrent(exBossEffectFireTask);

    AnimateExDrawRequestModel(&work->aniFire);

    if (GetExBossTask() == NULL)
    {
        DestroyCurrentExTask();
    }
    else
    {
        work->aniFire.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
        work->aniFire.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
        work->aniFire.model.translation.z = work->parent->aniBoss.model.bossStaffPos.z;

        if (IsExDrawRequestModelAnimFinished(&work->aniFire))
        {
            ExBossEffectFire_Action_SetActive();
        }
        else
        {
            AddExDrawRequest(&work->aniFire, &work->aniFire.config);

            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

void ExBossEffectFire_Action_SetActive(void)
{
    exBossEffectFireTask *work = ExTaskGetWorkCurrent(exBossEffectFireTask);

    SetExBossEffectFireAnimation(&work->aniFire, 1);
    SetExDrawRequestAnimAsOneShot(&work->aniFire.config);

    SetCurrentExTaskMainEvent(ExBossEffectFire_Main_Active);
    ExBossEffectFire_Main_Active();
}

void ExBossEffectFire_Main_Active(void)
{
    exBossEffectFireTask *work = ExTaskGetWorkCurrent(exBossEffectFireTask);

    AnimateExDrawRequestModel(&work->aniFire);

    if (GetExBossTask() == NULL)
    {
        DestroyCurrentExTask();
    }
    else
    {
        work->aniFire.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
        work->aniFire.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
        work->aniFire.model.translation.z = work->parent->aniBoss.model.bossStaffPos.z;

        if (sExBossEffectFireEnabled == FALSE)
        {
            ExBossEffectFire_Action_Disappear();
        }
        else
        {
            AddExDrawRequest(&work->aniFire, &work->aniFire.config);

            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

void ExBossEffectFire_Action_Disappear(void)
{
    exBossEffectFireTask *work = ExTaskGetWorkCurrent(exBossEffectFireTask);

    SetExBossEffectFireAnimation(&work->aniFire, 2);
    SetExDrawRequestAnimStopOnFinish(&work->aniFire.config);

    SetCurrentExTaskMainEvent(ExBossEffectFire_Main_Disappear);
    ExBossEffectFire_Main_Disappear();
}

void ExBossEffectFire_Main_Disappear(void)
{
    exBossEffectFireTask *work = ExTaskGetWorkCurrent(exBossEffectFireTask);

    AnimateExDrawRequestModel(&work->aniFire);

    if (GetExBossTask() == NULL)
    {
        DestroyCurrentExTask();
    }
    else
    {
        work->aniFire.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
        work->aniFire.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
        work->aniFire.model.translation.z = work->parent->aniBoss.model.bossStaffPos.z;

        if (IsExDrawRequestModelAnimFinished(&work->aniFire))
        {
            DestroyCurrentExTask();
        }
        else
        {
            AddExDrawRequest(&work->aniFire, &work->aniFire.config);

            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

BOOL CreateExBossEffectFire(void)
{
    Task *task = ExTaskCreate(ExBossEffectFire_Main_Init, ExBossEffectFire_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exBossEffectFireTask);

    exBossEffectFireTask *work = ExTaskGetWork(task, exBossEffectFireTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExTaskOnCheckStageFinishedEvent(task, ExBossEffectFire_OnCheckStageFinished);

    return TRUE;
}

void DisableExBossEffectFire(void)
{
    sExBossEffectFireEnabled = FALSE;
}