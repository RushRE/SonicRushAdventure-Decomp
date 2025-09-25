#include <ex/effects/exBossHitEffect.h>
#include <ex/effects/exBossFireballShotEffect.h>
#include <ex/effects/exBossFireballEffect.h>
#include <ex/effects/exBossHomingEffect.h>
#include <ex/effects/exBossShotEffect.h>
#include <ex/effects/exBossFireEffect.h>
#include <ex/boss/exBossHelpers.h>
#include <ex/system/exSystem.h>
#include <game/file/binaryBundle.h>
#include <game/audio/audioSystem.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

static s16 exBossEffectHitInstanceCount;
static s16 exBossEffectFireBallInstanceCount;
static s16 exBossEffectFireInstanceCount;
static s16 exBossEffectShotInstanceCount;
static s16 exBossEffectHomingInstanceCount;
static s16 exBossEffectFireBallShotInstanceCount;

static void *exBossEffectFireTaskSingleton;
static void *exBossEffectFireUnused;
static void *exBossEffectShotModelResource;
static u32 exBossEffectFireBallModelFileSize;
static BOOL exBossEffectHitEnabled;
static void *exBossEffectHitLastSpawnedWorker;
static void *exBossEffectShotLastSpawnedWorker;
static void *exBossEffectHitUnused;
static void *exBossEffectHomingTaskSingleton;
static void *exBossEffectFireBallShotModelResource;
static void *exBossEffectHomingUnused;
static void *exBossEffectFireLastSpawnedWorker;
static void *exBossEffectFireModelResource;
static void *exBossEffectFireBallShotUnused;
static BOOL exBossEffectShotEnabled;
static void *exBossEffectShotTaskSingleton;
static u32 exBossEffectShotTextureFileSize;
static u32 exBossEffectFireBallShotModelFileSize;
static void *exBossEffectFireBallUnused;
static s32 exBossEffectFireEnabled;
static void *exBossEffectFireBallShotLastSpawnedWorker;
static u32 exBossEffectHitModelFileSize;
static u32 exBossEffectFireTextureFileSize;
static BOOL exBossEffectHomingEnabled;
static u32 exBossEffectHomingTextureFileSize;
static u32 exBossEffectFireModelFileSize;
static void *exBossEffectShotUnused;
static void *exBossEffectHomingLastSpawnedWorker;
static void *exBossEffectHomingModelResource;
static u32 exBossEffectHomingModelFileSize;
static BOOL exBossEffectFireBallEnabled;
static void *exBossEffectFireBallTaskSingleton;
static u32 exBossEffectFireBallTextureFileSize;
static u32 exBossEffectHitTextureFileSize;
static void *exBossEffectHitModelResource;
static void *exBossEffectFireBallLastSpawnedWorker;
static void *exBossEffectFireBallModelResource;
static void *exBossEffectHitTaskSingleton;
static BOOL exBossEffectFireBallShotEnabled;
static void *exBossEffectFireBallShotTaskSingleton;
static u32 exBossEffectFireBallShotTextureFileSize;
static u32 exBossEffectShotModelFileSize;

static u32 exBossEffectHitAnimType[2];
static u32 exBossEffectFireBallShotAnimType[2];
static void *exBossEffectShotAnimResource[2];
static u32 exBossEffectShotAnimType[2];
static void *exBossEffectHitAnimResource[2];
static void *exBossEffectFireBallShotAnimResource[2];
static u32 exBossEffectHomingAnimType[4];
static void *exBossEffectFireBallAnimResource[4];
static void *exBossEffectFireAnimResource[4];
static u32 exBossEffectFireBallAnimType[4];
static u32 exBossEffectFireAnimType[4];
static void *exBossEffectHomingAnimResource[4];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(exBossEffectHitUnused)
FORCE_INCLUDE_VARIABLE_BSS(exBossEffectFireBallShotUnused)
FORCE_INCLUDE_VARIABLE_BSS(exBossEffectFireBallUnused)
FORCE_INCLUDE_VARIABLE_BSS(exBossEffectHomingUnused)
FORCE_INCLUDE_VARIABLE_BSS(exBossEffectShotUnused)
FORCE_INCLUDE_VARIABLE_BSS(exBossEffectFireUnused)

// --------------------
// FUNCTION DECLS
// --------------------

// exBossEffectHit
static BOOL LoadExBossEffectHitAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBossEffectHitAssets(EX_ACTION_NN_WORK *work);
static void ExBossEffectHit_Main_Init(void);
static void ExBossEffectHit_TaskUnknown(void);
static void ExBossEffectHit_Destructor(void);
static void ExBossEffectHit_Main_Active(void);

// exBossEffectFireBallShot
static BOOL LoadExBossEffectFireballShotAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBossEffectFireballShotAssets(EX_ACTION_NN_WORK *work);
static void ExBossEffectFireballShot_Main_Init(void);
static void ExBossEffectFireballShot_TaskUnknown(void);
static void ExBossEffectFireballShot_Destructor(void);
static void ExBossEffectFireballShot_Main_Active(void);

// exBossEffectFireBall
static BOOL LoadExBossEffectFireballAssets(EX_ACTION_NN_WORK *work);
static void SetExBossEffectFireballAnimation(EX_ACTION_NN_WORK *work, u16 animID);
static void ReleaseExBossEffectFireballAssets(EX_ACTION_NN_WORK *work);
static void ExBossEffectFireball_Main_Init(void);
static void ExBossEffectFireball_TaskUnknown(void);
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
static void ExBossEffectHoming_TaskUnknown(void);
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
static void ExBossEffectShot_TaskUnknown(void);
static void ExBossEffectShot_Destructor(void);
static void ExBossEffectShot_Main_Active(void);

// exBossEffectFire
static BOOL LoadExBossEffectFireAssets(EX_ACTION_NN_WORK *work);
static void SetExBossEffectFireAnimation(EX_ACTION_NN_WORK *work, u16 animID);
static void ReleaseExBossEffectFireAssets(EX_ACTION_NN_WORK *work);
static void ExBossEffectFire_Main_Init(void);
static void ExBossEffectFire_TaskUnknown(void);
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
    exBossEffectHitLastSpawnedWorker = work;

    if (exBossEffectHitModelFileSize != 0 && exBossEffectHitTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exBossEffectHitModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exBossEffectHitTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exBossEffectHitModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (exBossEffectHitInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_HITC_NSBMD, &exBossEffectHitModelResource, &exBossEffectHitModelFileSize, TRUE,
                                      FALSE);

        exBossEffectHitAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_HITC_NSBCA);
        exBossEffectHitAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        exBossEffectHitAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_HITC_NSBTA);
        exBossEffectHitAnimType[1]     = B3D_ANIM_TEX_ANIM;

        Asset3DSetup__Create(exBossEffectHitModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exBossEffectHitModelResource, 0, FALSE, FALSE);

    for (u16 i = 0; i < 2; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectHitAnimType[i], exBossEffectHitAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = exBossEffectHitAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[exBossEffectHitAnimType[0]];

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

    exBossEffectHitInstanceCount++;

    return TRUE;
}

void ReleaseExBossEffectHitAssets(EX_ACTION_NN_WORK *work)
{
    if (exBossEffectHitInstanceCount <= 1)
    {
        if (exBossEffectHitModelResource != NULL)
            NNS_G3dResDefaultRelease(exBossEffectHitModelResource);

        if (exBossEffectHitAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectHitAnimResource[0]);

        if (exBossEffectHitAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectHitAnimResource[1]);

        if (exBossEffectHitModelResource != NULL)
            HeapFree(HEAP_USER, exBossEffectHitModelResource);
        exBossEffectHitModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    exBossEffectHitInstanceCount--;
}

void ExBossEffectHit_Main_Init(void)
{
    exBossEffectHitTask *work = ExTaskGetWorkCurrent(exBossEffectHitTask);

    exBossEffectHitTaskSingleton = GetCurrentTask();

    LoadExBossEffectHitAssets(&work->aniHit);
    SetExDrawRequestPriority(&work->aniHit.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniHit.config);

    work->aniHit.model.translation.x = work->parent->aniBoss.model.translation3.x;
    work->aniHit.model.translation.y = work->parent->aniBoss.model.translation3.y;
    work->aniHit.model.translation.z = work->parent->aniBoss.model.translation3.z;

    exBossEffectHitEnabled = TRUE;

    SetCurrentExTaskMainEvent(ExBossEffectHit_Main_Active);
}

void ExBossEffectHit_TaskUnknown(void)
{
    exBossEffectHitTask *work = ExTaskGetWorkCurrent(exBossEffectHitTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();

    if (exBossHelpers__IsBossFleeing() == TRUE)
        DestroyCurrentExTask();
}

void ExBossEffectHit_Destructor(void)
{
    exBossEffectHitTask *work = ExTaskGetWorkCurrent(exBossEffectHitTask);

    ReleaseExBossEffectHitAssets(&work->aniHit);

    exBossEffectHitTaskSingleton = NULL;
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

            RunCurrentExTaskUnknownEvent();
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

    SetExTaskUnknownEvent(task, ExBossEffectHit_TaskUnknown);

    return TRUE;
}

// exBossEffectFireBallShot
BOOL LoadExBossEffectFireballShotAssets(EX_ACTION_NN_WORK *work)
{
    exBossEffectFireBallShotLastSpawnedWorker = work;

    if (exBossEffectFireBallShotModelFileSize != 0 && exBossEffectFireBallShotTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exBossEffectFireBallShotModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exBossEffectFireBallShotTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exBossEffectFireBallShotModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (exBossEffectFireBallShotInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_FBSHK_NSBMD, &exBossEffectFireBallShotModelResource,
                                      &exBossEffectFireBallShotModelFileSize, TRUE, FALSE);

        exBossEffectFireBallShotAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FBSHK_NSBCA);
        exBossEffectFireBallShotAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        exBossEffectFireBallShotAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FBSHK_NSBVA);
        exBossEffectFireBallShotAnimType[1]     = B3D_ANIM_VIS_ANIM;

        Asset3DSetup__Create(exBossEffectFireBallShotModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exBossEffectFireBallShotModelResource, 0, FALSE, FALSE);

    for (u16 i = 0; i < 2; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectFireBallShotAnimType[i], exBossEffectFireBallShotAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = exBossEffectFireBallShotAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[exBossEffectFireBallShotAnimType[0]];

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

    exBossEffectFireBallShotInstanceCount++;

    return TRUE;
}

void ReleaseExBossEffectFireballShotAssets(EX_ACTION_NN_WORK *work)
{
    if (exBossEffectFireBallShotInstanceCount <= 1)
    {
        if (exBossEffectFireBallShotModelResource != NULL)
            NNS_G3dResDefaultRelease(exBossEffectFireBallShotModelResource);

        if (exBossEffectFireBallShotAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectFireBallShotAnimResource[0]);

        if (exBossEffectFireBallShotAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectFireBallShotAnimResource[1]);

        if (exBossEffectFireBallShotModelResource != NULL)
            HeapFree(HEAP_USER, exBossEffectFireBallShotModelResource);
        exBossEffectFireBallShotModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    exBossEffectFireBallShotInstanceCount--;
}

void ExBossEffectFireballShot_Main_Init(void)
{
    exBossEffectFireBallShotTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallShotTask);

    exBossEffectFireBallShotTaskSingleton = GetCurrentTask();

    LoadExBossEffectFireballShotAssets(&work->aniShot);
    SetExDrawRequestPriority(&work->aniShot.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniShot.config);

    work->aniShot.model.translation.x = work->parent->aniBoss.model.translation4.x;
    work->aniShot.model.translation.y = work->parent->aniBoss.model.translation4.y;
    work->aniShot.model.translation.z = work->parent->aniBoss.model.translation4.z;

    exBossEffectFireBallShotEnabled = TRUE;

    SetCurrentExTaskMainEvent(ExBossEffectFireballShot_Main_Active);
}

void ExBossEffectFireballShot_TaskUnknown(void)
{
    exBossEffectFireBallShotTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallShotTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();

    if (exBossHelpers__IsBossFleeing() == TRUE)
        DestroyCurrentExTask();
}

void ExBossEffectFireballShot_Destructor(void)
{
    exBossEffectFireBallShotTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallShotTask);

    ReleaseExBossEffectFireballShotAssets(&work->aniShot);

    exBossEffectFireBallShotTaskSingleton = 0;
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

        RunCurrentExTaskUnknownEvent();
    }
}

BOOL CreateExBossEffectFireballShot(void)
{
    Task *task = ExTaskCreate(ExBossEffectFireballShot_Main_Init, ExBossEffectFireballShot_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0,
                              EXTASK_TYPE_REGULAR, exBossEffectFireBallShotTask);

    exBossEffectFireBallShotTask *work = ExTaskGetWork(task, exBossEffectFireBallShotTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExTaskUnknownEvent(task, ExBossEffectFireballShot_TaskUnknown);

    return TRUE;
}

void DisableExBossEffectFireballShot(void)
{
    exBossEffectFireBallShotEnabled = FALSE;
}

// exBossEffectFireBall
BOOL LoadExBossEffectFireballAssets(EX_ACTION_NN_WORK *work)
{
    exBossEffectFireBallLastSpawnedWorker = work;

    if (exBossEffectFireBallModelFileSize != 0 && exBossEffectFireBallTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exBossEffectFireBallModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exBossEffectFireBallTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exBossEffectFireBallModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (exBossEffectFireBallInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_SFB_NSBMD, &exBossEffectFireBallModelResource, &exBossEffectFireBallModelFileSize,
                                      TRUE, FALSE);

        exBossEffectFireBallAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFB_NSBCA);
        exBossEffectFireBallAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        exBossEffectFireBallAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFB_NSBMA);
        exBossEffectFireBallAnimType[1]     = B3D_ANIM_MAT_ANIM;

        exBossEffectFireBallAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFB_NSBTA);
        exBossEffectFireBallAnimType[2]     = B3D_ANIM_TEX_ANIM;

        exBossEffectFireBallAnimResource[3] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFB_NSBTP);
        exBossEffectFireBallAnimType[3]     = B3D_ANIM_PAT_ANIM;

        Asset3DSetup__Create(exBossEffectFireBallModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exBossEffectFireBallModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (i = 0; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectFireBallAnimType[i], exBossEffectFireBallAnimResource[i], 0, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectFireBallAnimType[i], exBossEffectFireBallAnimResource[i], 0, NNS_G3dGetTex(exBossEffectFireBallModelResource));

    work->model.primaryAnimType     = exBossEffectFireBallAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[exBossEffectFireBallAnimType[0]];

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

    exBossEffectFireBallInstanceCount++;

    return TRUE;
}

void SetExBossEffectFireballAnimation(EX_ACTION_NN_WORK *work, u16 animID)
{
    u16 i = 0;
    for (; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectFireBallAnimType[i], exBossEffectFireBallAnimResource[i], animID, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectFireBallAnimType[i], exBossEffectFireBallAnimResource[i], animID,
                              NNS_G3dGetTex(exBossEffectFireBallModelResource));

    work->model.primaryAnimType     = exBossEffectFireBallAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[exBossEffectFireBallAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }
}

void ReleaseExBossEffectFireballAssets(EX_ACTION_NN_WORK *work)
{
    if (exBossEffectFireBallInstanceCount <= 1)
    {
        if (exBossEffectFireBallModelResource)
            NNS_G3dResDefaultRelease(exBossEffectFireBallModelResource);

        if (exBossEffectFireBallAnimResource[0])
            NNS_G3dResDefaultRelease(exBossEffectFireBallAnimResource[0]);

        if (exBossEffectFireBallAnimResource[1])
            NNS_G3dResDefaultRelease(exBossEffectFireBallAnimResource[1]);

        if (exBossEffectFireBallAnimResource[2])
            NNS_G3dResDefaultRelease(exBossEffectFireBallAnimResource[2]);

        if (exBossEffectFireBallAnimResource[3])
            NNS_G3dResDefaultRelease(exBossEffectFireBallAnimResource[3]);

        if (exBossEffectFireBallModelResource)
            HeapFree(HEAP_USER, exBossEffectFireBallModelResource);
        exBossEffectFireBallModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    exBossEffectFireBallInstanceCount--;
}

void ExBossEffectFireball_Main_Init(void)
{
    exBossEffectFireBallTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallTask);

    exBossEffectFireBallTaskSingleton = GetCurrentTask();

    LoadExBossEffectFireballAssets(&work->aniFire);
    SetExDrawRequestPriority(&work->aniFire.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniFire.config);

    exBossEffectFireBallEnabled = TRUE;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FIRE_CHARGE);

    SetCurrentExTaskMainEvent(ExBossEffectFireball_Main_Appear);
}

void ExBossEffectFireball_TaskUnknown(void)
{
    exBossEffectFireBallTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();

    if (exBossHelpers__IsBossFleeing() == TRUE)
        DestroyCurrentExTask();
}

void ExBossEffectFireball_Destructor(void)
{
    exBossEffectFireBallTask *work = ExTaskGetWorkCurrent(exBossEffectFireBallTask);

    ReleaseExBossEffectFireballAssets(&work->aniFire);

    exBossEffectFireBallTaskSingleton = NULL;
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
        work->aniFire.model.translation.x = work->parent->aniBoss.model.translation4.x;
        work->aniFire.model.translation.y = work->parent->aniBoss.model.translation4.y;
        work->aniFire.model.translation.z = work->parent->aniBoss.model.translation4.z;

        if (IsExDrawRequestModelAnimFinished(&work->aniFire))
        {
            ExBossEffectFireball_Action_SetActive();
        }
        else
        {
            AddExDrawRequest(&work->aniFire, &work->aniFire.config);

            RunCurrentExTaskUnknownEvent();
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
        work->aniFire.model.translation.x = work->parent->aniBoss.model.translation4.x;
        work->aniFire.model.translation.y = work->parent->aniBoss.model.translation4.y;
        work->aniFire.model.translation.z = work->parent->aniBoss.model.translation4.z;

        if (exBossEffectFireBallEnabled == FALSE)
        {
            ExBossEffectFireball_Action_Disappear();
        }
        else
        {
            AddExDrawRequest(&work->aniFire, &work->aniFire.config);

            RunCurrentExTaskUnknownEvent();
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
        work->aniFire.model.translation.x = work->parent->aniBoss.model.translation4.x;
        work->aniFire.model.translation.y = work->parent->aniBoss.model.translation4.y;
        work->aniFire.model.translation.z = work->parent->aniBoss.model.translation4.z;

        if (IsExDrawRequestModelAnimFinished(&work->aniFire))
        {
            DestroyCurrentExTask();
        }
        else
        {
            AddExDrawRequest(&work->aniFire, &work->aniFire.config);

            RunCurrentExTaskUnknownEvent();
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

    SetExTaskUnknownEvent(task, ExBossEffectFireball_TaskUnknown);

    return TRUE;
}

void DisableExBossEffectFireball(void)
{
    exBossEffectFireBallEnabled = FALSE;
}

// exBossEffectHoming
BOOL LoadExEffectHomingAssets(EX_ACTION_NN_WORK *work)
{
    exBossEffectHomingLastSpawnedWorker = work;

    if (exBossEffectHomingModelFileSize != 0 && exBossEffectHomingTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exBossEffectHomingModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exBossEffectHomingTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exBossEffectHomingModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (exBossEffectHomingInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_SHOMI_NSBMD, &exBossEffectHomingModelResource, &exBossEffectHomingModelFileSize,
                                      TRUE, FALSE);

        exBossEffectHomingAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SHOMI_NSBCA);
        exBossEffectHomingAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        exBossEffectHomingAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SHOMI_NSBMA);
        exBossEffectHomingAnimType[1]     = B3D_ANIM_MAT_ANIM;

        exBossEffectHomingAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SHOMI_NSBTA);
        exBossEffectHomingAnimType[2]     = B3D_ANIM_TEX_ANIM;

        exBossEffectHomingAnimResource[3] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SHOMI_NSBTP);
        exBossEffectHomingAnimType[3]     = B3D_ANIM_PAT_ANIM;

        Asset3DSetup__Create(exBossEffectHomingModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exBossEffectHomingModelResource, 0, FALSE, FALSE);

    for (u16 i = 0; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectHomingAnimType[i], exBossEffectHomingAnimResource[i], 0, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectHomingAnimType[3], exBossEffectHomingAnimResource[3], 0, NNS_G3dGetTex(exBossEffectHomingModelResource));

    work->model.primaryAnimType     = exBossEffectHomingAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[exBossEffectHomingAnimType[0]];

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

    exBossEffectHomingInstanceCount++;

    return TRUE;
}

void SetExBossEffectHomingAnimation(EX_ACTION_NN_WORK *work, u16 animID)
{
    for (u16 i = 0; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectHomingAnimType[i], exBossEffectHomingAnimResource[i], animID, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectHomingAnimType[3], exBossEffectHomingAnimResource[3], animID, NNS_G3dGetTex(exBossEffectHomingModelResource));

    work->model.primaryAnimType     = exBossEffectHomingAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[exBossEffectHomingAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }
}

void ReleaseExBossEffectHomingAssets(EX_ACTION_NN_WORK *work)
{
    if (exBossEffectHomingInstanceCount <= 1)
    {
        if (exBossEffectHomingModelResource != NULL)
            NNS_G3dResDefaultRelease(exBossEffectHomingModelResource);

        if (exBossEffectHomingAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectHomingAnimResource[0]);

        if (exBossEffectHomingAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectHomingAnimResource[1]);

        if (exBossEffectHomingAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectHomingAnimResource[2]);

        if (exBossEffectHomingAnimResource[3] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectHomingAnimResource[3]);

        if (exBossEffectHomingModelResource != NULL)
            HeapFree(HEAP_USER, exBossEffectHomingModelResource);
        exBossEffectHomingModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    exBossEffectHomingInstanceCount--;
}

void ExBossEffectHoming_Main_Init(void)
{
    exBossEffectHomingTask *work = ExTaskGetWorkCurrent(exBossEffectHomingTask);

    exBossEffectHomingTaskSingleton = GetCurrentTask();

    LoadExEffectHomingAssets(&work->aniHoming);
    SetExDrawRequestPriority(&work->aniHoming.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniHoming.config);

    exBossEffectHomingEnabled = TRUE;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_LASER_CHARGE);

    SetCurrentExTaskMainEvent(ExBossEffectHoming_Main_Appear);
}

void ExBossEffectHoming_TaskUnknown(void)
{
    exBossEffectHomingTask *work = ExTaskGetWorkCurrent(exBossEffectHomingTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();

    if (exBossHelpers__IsBossFleeing() == TRUE)
        DestroyCurrentExTask();
}

void ExBossEffectHoming_Destructor(void)
{
    exBossEffectHomingTask *work = ExTaskGetWorkCurrent(exBossEffectHomingTask);

    ReleaseExBossEffectHomingAssets(&work->aniHoming);

    exBossEffectHomingTaskSingleton = NULL;
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
        work->aniHoming.model.translation.x = work->parent->aniBoss.model.translation4.x;
        work->aniHoming.model.translation.y = work->parent->aniBoss.model.translation4.y;
        work->aniHoming.model.translation.z = work->parent->aniBoss.model.translation4.z;

        if (IsExDrawRequestModelAnimFinished(&work->aniHoming))
        {
            ExBossEffectHoming_Action_SetActive();
        }
        else
        {
            AddExDrawRequest(&work->aniHoming, &work->aniHoming.config);

            RunCurrentExTaskUnknownEvent();
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
        work->aniHoming.model.translation.x = work->parent->aniBoss.model.translation4.x;
        work->aniHoming.model.translation.y = work->parent->aniBoss.model.translation4.y;
        work->aniHoming.model.translation.z = work->parent->aniBoss.model.translation4.z;

        if (exBossEffectHomingEnabled == FALSE)
        {
            ExBossEffectHoming_Action_Disappear();
        }
        else
        {
            AddExDrawRequest(&work->aniHoming, &work->aniHoming.config);

            RunCurrentExTaskUnknownEvent();
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
        work->aniHoming.model.translation.x = work->parent->aniBoss.model.translation4.x;
        work->aniHoming.model.translation.y = work->parent->aniBoss.model.translation4.y;
        work->aniHoming.model.translation.z = work->parent->aniBoss.model.translation4.z;

        if (IsExDrawRequestModelAnimFinished(&work->aniHoming))
        {
            DestroyCurrentExTask();
        }
        else
        {
            AddExDrawRequest(&work->aniHoming, &work->aniHoming.config);

            RunCurrentExTaskUnknownEvent();
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

    SetExTaskUnknownEvent(task, ExBossEffectHoming_TaskUnknown);

    return TRUE;
}

void DisableExBossEffectHoming(void)
{
    exBossEffectHomingEnabled = FALSE;
}

// exBossEffectShot
BOOL LoadExBossEffectShotAssets(EX_ACTION_NN_WORK *work)
{
    exBossEffectShotLastSpawnedWorker = work;

    if (exBossEffectShotModelFileSize != 0 && exBossEffectShotTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exBossEffectShotModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exBossEffectShotTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exBossEffectShotModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (exBossEffectShotInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_FSHK_NSBMD, &exBossEffectShotModelResource, &exBossEffectShotModelFileSize, TRUE,
                                      FALSE);

        exBossEffectShotAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FSHK_NSBCA);
        exBossEffectShotAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        exBossEffectShotAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FSHK_NSBVA);
        exBossEffectShotAnimType[1]     = B3D_ANIM_VIS_ANIM;

        Asset3DSetup__Create(exBossEffectShotModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exBossEffectShotModelResource, 0, FALSE, FALSE);

    for (u16 i = 0; i < 2; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectShotAnimType[i], exBossEffectShotAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = exBossEffectShotAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[exBossEffectShotAnimType[0]];

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

    exBossEffectShotInstanceCount++;

    return TRUE;
}

void ReleaseExBossEffectShotAssets(EX_ACTION_NN_WORK *work)
{
    if (exBossEffectShotInstanceCount <= 1)
    {
        if (exBossEffectShotModelResource != NULL)
            NNS_G3dResDefaultRelease(exBossEffectShotModelResource);

        if (exBossEffectShotAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectShotAnimResource[0]);

        if (exBossEffectShotAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectShotAnimResource[1]);

        if (exBossEffectShotModelResource != NULL)
            HeapFree(HEAP_USER, exBossEffectShotModelResource);
        exBossEffectShotModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    exBossEffectShotInstanceCount--;
}

void ExBossEffectShot_Main_Init(void)
{
    exBossEffectShotTask *work = ExTaskGetWorkCurrent(exBossEffectShotTask);

    exBossEffectShotTaskSingleton = GetCurrentTask();

    LoadExBossEffectShotAssets(&work->aniShot);
    SetExDrawRequestPriority(&work->aniShot.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniShot.config);

    work->aniShot.model.translation.x = work->parent->aniBoss.model.translation4.x;
    work->aniShot.model.translation.y = work->parent->aniBoss.model.translation4.y;
    work->aniShot.model.translation.z = work->parent->aniBoss.model.translation4.z;

    exBossEffectShotEnabled = TRUE;

    SetCurrentExTaskMainEvent(ExBossEffectShot_Main_Active);
}

void ExBossEffectShot_TaskUnknown(void)
{
    exBossEffectShotTask *work = ExTaskGetWorkCurrent(exBossEffectShotTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();

    if (exBossHelpers__IsBossFleeing() == TRUE)
        DestroyCurrentExTask();
}

void ExBossEffectShot_Destructor(void)
{
    exBossEffectShotTask *work = ExTaskGetWorkCurrent(exBossEffectShotTask);

    ReleaseExBossEffectShotAssets(&work->aniShot);

    exBossEffectShotTaskSingleton = NULL;
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

            RunCurrentExTaskUnknownEvent();
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

    SetExTaskUnknownEvent(task, ExBossEffectShot_TaskUnknown);

    return TRUE;
}

// exBossEffectFire
BOOL LoadExBossEffectFireAssets(EX_ACTION_NN_WORK *work)
{
    exBossEffectFireLastSpawnedWorker = work;

    if (exBossEffectFireModelFileSize != 0 && exBossEffectFireTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exBossEffectFireModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exBossEffectFireTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exBossEffectFireModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (exBossEffectFireInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_SFIRE_NSBMD, &exBossEffectFireModelResource, &exBossEffectFireModelFileSize, TRUE,
                                      FALSE);

        exBossEffectFireAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFIRE_NSBCA);
        exBossEffectFireAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        exBossEffectFireAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFIRE_NSBMA);
        exBossEffectFireAnimType[1]     = B3D_ANIM_MAT_ANIM;

        exBossEffectFireAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFIRE_NSBTA);
        exBossEffectFireAnimType[2]     = B3D_ANIM_TEX_ANIM;

        exBossEffectFireAnimResource[3] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SFIRE_NSBTP);
        exBossEffectFireAnimType[3]     = B3D_ANIM_PAT_ANIM;

        Asset3DSetup__Create(exBossEffectFireModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exBossEffectFireModelResource, 0, FALSE, FALSE);

    for (u16 i = 0; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectFireAnimType[i], exBossEffectFireAnimResource[i], 0, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectFireAnimType[3], exBossEffectFireAnimResource[3], 0, NNS_G3dGetTex(exBossEffectFireModelResource));

    work->model.primaryAnimType     = exBossEffectFireAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[exBossEffectFireAnimType[0]];

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

    exBossEffectFireInstanceCount++;

    return TRUE;
}

void SetExBossEffectFireAnimation(EX_ACTION_NN_WORK *work, u16 animID)
{
    for (u16 i = 0; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectFireAnimType[i], exBossEffectFireAnimResource[i], animID, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, exBossEffectFireAnimType[3], exBossEffectFireAnimResource[3], animID, NNS_G3dGetTex(exBossEffectFireModelResource));

    work->model.primaryAnimType     = exBossEffectFireAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[exBossEffectFireAnimType[0]];
    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }
}

void ReleaseExBossEffectFireAssets(EX_ACTION_NN_WORK *work)
{
    if (exBossEffectFireInstanceCount <= 1)
    {
        if (exBossEffectFireModelResource != NULL)
            NNS_G3dResDefaultRelease(exBossEffectFireModelResource);

        if (exBossEffectFireAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectFireAnimResource[0]);

        if (exBossEffectFireAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectFireAnimResource[1]);

        if (exBossEffectFireAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectFireAnimResource[2]);

        if (exBossEffectFireAnimResource[3] != NULL)
            NNS_G3dResDefaultRelease(exBossEffectFireAnimResource[3]);

        if (exBossEffectFireModelResource != NULL)
            HeapFree(HEAP_USER, exBossEffectFireModelResource);
        exBossEffectFireModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    exBossEffectFireInstanceCount--;
}

void ExBossEffectFire_Main_Init(void)
{
    exBossEffectFireTask *work = ExTaskGetWorkCurrent(exBossEffectFireTask);

    exBossEffectFireTaskSingleton = GetCurrentTask();

    LoadExBossEffectFireAssets(&work->aniFire);
    SetExDrawRequestPriority(&work->aniFire.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniFire.config);

    exBossEffectFireEnabled = TRUE;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FIRE_CHARGE);

    SetCurrentExTaskMainEvent(ExBossEffectFire_Main_Appear);
}

void ExBossEffectFire_TaskUnknown(void)
{
    exBossEffectFireTask *work = ExTaskGetWorkCurrent(exBossEffectFireTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();

    if (exBossHelpers__IsBossFleeing() == TRUE)
        DestroyCurrentExTask();
}

void ExBossEffectFire_Destructor(void)
{
    exBossEffectFireTask *work = ExTaskGetWorkCurrent(exBossEffectFireTask);

    ReleaseExBossEffectFireAssets(&work->aniFire);

    exBossEffectFireTaskSingleton = NULL;
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
        work->aniFire.model.translation.x = work->parent->aniBoss.model.translation4.x;
        work->aniFire.model.translation.y = work->parent->aniBoss.model.translation4.y;
        work->aniFire.model.translation.z = work->parent->aniBoss.model.translation4.z;

        if (IsExDrawRequestModelAnimFinished(&work->aniFire))
        {
            ExBossEffectFire_Action_SetActive();
        }
        else
        {
            AddExDrawRequest(&work->aniFire, &work->aniFire.config);

            RunCurrentExTaskUnknownEvent();
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
        work->aniFire.model.translation.x = work->parent->aniBoss.model.translation4.x;
        work->aniFire.model.translation.y = work->parent->aniBoss.model.translation4.y;
        work->aniFire.model.translation.z = work->parent->aniBoss.model.translation4.z;

        if (exBossEffectFireEnabled == FALSE)
        {
            ExBossEffectFire_Action_Disappear();
        }
        else
        {
            AddExDrawRequest(&work->aniFire, &work->aniFire.config);

            RunCurrentExTaskUnknownEvent();
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
        work->aniFire.model.translation.x = work->parent->aniBoss.model.translation4.x;
        work->aniFire.model.translation.y = work->parent->aniBoss.model.translation4.y;
        work->aniFire.model.translation.z = work->parent->aniBoss.model.translation4.z;

        if (IsExDrawRequestModelAnimFinished(&work->aniFire))
        {
            DestroyCurrentExTask();
        }
        else
        {
            AddExDrawRequest(&work->aniFire, &work->aniFire.config);

            RunCurrentExTaskUnknownEvent();
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

    SetExTaskUnknownEvent(task, ExBossEffectFire_TaskUnknown);

    return TRUE;
}

void DisableExBossEffectFire(void)
{
    exBossEffectFireEnabled = FALSE;
}