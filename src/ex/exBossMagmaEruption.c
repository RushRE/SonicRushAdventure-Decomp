#include <ex/boss/exBossMagmaWave.h>
#include <ex/boss/exBoss.h>
#include <ex/system/exSystem.h>
#include <ex/system/exStage.h>
#include <ex/system/exUtils.h>
#include <game/file/binaryBundle.h>
#include <game/audio/audioSystem.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// ENUMS
// --------------------

enum ExBossMagmaEruptionAnimIDs_
{
    ex_effe_fcol0, // Rising
    ex_effe_fcol1, // Erupting
    ex_effe_fcol2, // Lowering
};

// --------------------
// VARIABLES
// --------------------

static s16 magmaWaveInstanceCount;
static s16 magmaEruptionInstanceCount;

static u32 magmaWaveModelFileSize;
static EX_ACTION_NN_WORK *magmaEruptionLastSpawnedWorker;
static Task *magmaWaveTaskSingleton;
static u32 magmaWaveWaveTextureFileSize;
static void *magmaEruptionUnused;
static void *magmaWaveUnused;
static EX_ACTION_NN_WORK *magmaWaveLastSpawnedWorker;
static void *magmaWaveModelResource;
static void *magmaEruptionModelResource;
static Task *magmaEruptionTaskSingleton;
static u32 magmaEruptionTextureFileSize;
static u32 magmaEruptionModelFileSize;

static B3DAnimationTypes magmaEruptionAnimType[2];
static void *magmaEruptionAnimResource[2];
static B3DAnimationTypes magmaWaveAnimType[4];
static void *magmaWaveAnimResource[4];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(magmaWaveUnused)
FORCE_INCLUDE_VARIABLE_BSS(magmaEruptionUnused)

// --------------------
// FUNCTION DECLS
// --------------------

// Magma Eruption
BOOL LoadExBossMagmeWaveAttackAssets(EX_ACTION_NN_WORK *work);
void SetExBossMagmaAttackAnim(EX_ACTION_NN_WORK *work, u16 id);
void ReleaseExBossMagmeWaveAttackAssets(EX_ACTION_NN_WORK *work);
void ExBossMagmaEruption_Main_Init(void);
void ExBossMagmaEruption_OnCheckStageFinished(void);
void ExBossMagmaEruption_Destructor(void);
void ExBossMagmaEruption_Main_Rise(void);
void ExBossMagmaEruption_Action_Activate(void);
void ExBossMagmaEruption_Main_Active(void);
void ExBossMagmaEruption_Action_Lower(void);
void ExBossMagmaEruption_Main_Lower(void);
BOOL CreateExBossMagmaEruption(void);

// Magma Wave
BOOL LoadExBossMagmaWaveAssets(EX_ACTION_NN_WORK *work);
void ReleaseExBossMagmaWaveAssets(EX_ACTION_NN_WORK *work);
void ExBossMagmaWave_Main_Init(void);
void ExBossMagmaWave_OnCheckStageFinished(void);
void ExBossMagmaWave_Destructor(void);
void ExBossMagmaWave_Main_Active(void);
BOOL CreateExBossMagmaWave(void);

// ExBoss
void ExBoss_Main_MagmaEruption0(void);
void ExBoss_Action_StartMagmaEruption1(void);
void ExBoss_Main_MagmaEruption1(void);
void ExBoss_Action_StartMagmaEruption2(void);
void ExBoss_Main_StartMagmaEruption2(void);
void ExBoss_Main_ProcessMagmaEruption2(void);
void ExBoss_Main_FinishMagmaEruption2(void);
void ExBoss_Action_StartMagmaEruption3(void);
void ExBoss_Main_MagmaEruption3(void);
void ExBoss_WaveAngleMoveL(void);
void ExBoss_WaveAngleMoveR(void);
void ExBoss_WaveMoveL(void);
void ExBoss_WaveMoveR(void);
void ExBoss_Action_StartMagmaEruption4(void);
void ExBoss_Main_MagmaEruption4(void);
void ExBoss_Main_FinishMagmaEruptionAttack(void);

// --------------------
// FUNCTIONS
// --------------------

BOOL LoadExBossMagmeWaveAttackAssets(EX_ACTION_NN_WORK *work)
{
    magmaEruptionLastSpawnedWorker = work;

    if (magmaEruptionModelFileSize != 0 && magmaEruptionTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < magmaEruptionModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < magmaEruptionTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < magmaEruptionModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (magmaEruptionInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_FCOL_NSBMD, &magmaEruptionModelResource, &magmaEruptionModelFileSize, TRUE, FALSE);

        magmaEruptionAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FCOL_NSBCA);
        magmaEruptionAnimType[0]     = B3D_ANIM_JOINT_ANIM;
        magmaEruptionAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FCOL_NSBTA);
        magmaEruptionAnimType[1]     = B3D_ANIM_TEX_ANIM;

        Asset3DSetup__Create(magmaEruptionModelResource);
    }

    AnimatorMDL *animator = &work->model.animator;
    AnimatorMDL__Init(animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(animator, magmaEruptionModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < ARRAY_COUNT(magmaEruptionAnimResource); i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, magmaEruptionAnimType[i], magmaEruptionAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = magmaEruptionAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[magmaEruptionAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(0.0);

    work->model.scale.x = FLOAT_TO_FX32(1.0);
    work->model.scale.y = FLOAT_TO_FX32(1.0);
    work->model.scale.z = FLOAT_TO_FX32(1.0);
    work->model.angle.x = FLOAT_DEG_TO_IDX(89.98);

    work->hitChecker.type                          = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isBossMagmaWaveAttack = TRUE;
    work->hitChecker.box.size.x                    = FLOAT_TO_FX32(5.0);
    work->hitChecker.box.size.y                    = FLOAT_TO_FX32(5.0);
    work->hitChecker.box.size.z                    = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position                  = &work->model.translation;

    magmaEruptionInstanceCount++;

    return TRUE;
}

void SetExBossMagmaAttackAnim(EX_ACTION_NN_WORK *work, u16 id)
{
    for (u16 i = 0; i < ARRAY_COUNT(magmaEruptionAnimResource); i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, magmaEruptionAnimType[i], magmaEruptionAnimResource[i], id, NULL);
    }

    work->model.primaryAnimType     = magmaEruptionAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[magmaEruptionAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }
}

void ReleaseExBossMagmeWaveAttackAssets(EX_ACTION_NN_WORK *work)
{
    if (magmaEruptionInstanceCount <= 1)
    {
        if (magmaEruptionModelResource)
            NNS_G3dResDefaultRelease(magmaEruptionModelResource);

        if (magmaEruptionAnimResource[0])
            NNS_G3dResDefaultRelease(magmaEruptionAnimResource[0]);

        if (magmaEruptionAnimResource[1])
            NNS_G3dResDefaultRelease(magmaEruptionAnimResource[1]);

        if (magmaEruptionModelResource)
            HeapFree(HEAP_USER, magmaEruptionModelResource);
        magmaEruptionModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);
    magmaEruptionInstanceCount--;
}

void ExBossMagmaEruption_Main_Init(void)
{
    exBossMagmaAttackTask *work = ExTaskGetWorkCurrent(exBossMagmaAttackTask);

    magmaEruptionTaskSingleton = GetCurrentTask();

    LoadExBossMagmeWaveAttackAssets(&work->animator);
    SetExDrawRequestPriority(&work->animator.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->animator.config);

    work->animator.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
    work->animator.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
    work->animator.model.translation.z = FLOAT_TO_FX32(0.0);

    work->velocity.y = FLOAT_TO_FX32(3.0);

    SetCurrentExTaskMainEvent(ExBossMagmaEruption_Main_Rise);
}

void ExBossMagmaEruption_OnCheckStageFinished(void)
{
    exBossMagmaAttackTask *work = ExTaskGetWorkCurrent(exBossMagmaAttackTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBossMagmaEruption_Destructor(void)
{
    exBossMagmaAttackTask *work = ExTaskGetWorkCurrent(exBossMagmaAttackTask);

    ReleaseExBossMagmeWaveAttackAssets(&work->animator);

    magmaEruptionTaskSingleton = NULL;
}

void ExBossMagmaEruption_Main_Rise(void)
{
    exBossMagmaAttackTask *work = ExTaskGetWorkCurrent(exBossMagmaAttackTask);

    AnimateExDrawRequestModel(&work->animator);
    if (IsExDrawRequestModelAnimFinished(&work->animator))
    {
        ExBossMagmaEruption_Action_Activate();
    }
    else
    {
        work->animator.model.translation.y -= work->velocity.y;

        if (work->animator.model.translation.x >= EX_STAGE_BOUNDARY_R || work->animator.model.translation.x <= EX_STAGE_BOUNDARY_L
            || work->animator.model.translation.y >= EX_STAGE_BOUNDARY_B || work->animator.model.translation.y <= EX_STAGE_BOUNDARY_T)
        {
            DestroyCurrentExTask();
        }
        else
        {
            AddExDrawRequest(&work->animator, &work->animator.config);

            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

void ExBossMagmaEruption_Action_Activate(void)
{
    exBossMagmaAttackTask *work = ExTaskGetWorkCurrent(exBossMagmaAttackTask);

    SetExBossMagmaAttackAnim(&work->animator, ex_effe_fcol1);
    SetExDrawRequestAnimAsOneShot(&work->animator.config);

    work->velocity.y = FLOAT_TO_FX32(3.0);

    work->timer = 5 + (mtMathRand() % 5);

    SetCurrentExTaskMainEvent(ExBossMagmaEruption_Main_Active);
    ExBossMagmaEruption_Main_Active();
}

void ExBossMagmaEruption_Main_Active(void)
{
    exBossMagmaAttackTask *work = ExTaskGetWorkCurrent(exBossMagmaAttackTask);

    AnimateExDrawRequestModel(&work->animator);
    work->animator.model.translation.y -= work->velocity.y;

    if (work->timer <= 0)
    {
        work->timer = 0;

        SetExDrawRequestAnimStopOnFinish(&work->animator.config);
        if (IsExDrawRequestModelAnimFinished(&work->animator))
        {
            ExBossMagmaEruption_Action_Lower();
            return;
        }
    }
    else
    {
        work->timer--;
    }

    if (work->animator.model.translation.x >= EX_STAGE_BOUNDARY_R || work->animator.model.translation.x <= EX_STAGE_BOUNDARY_L
        || work->animator.model.translation.y >= EX_STAGE_BOUNDARY_B || work->animator.model.translation.y <= EX_STAGE_BOUNDARY_T)
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->animator, &work->animator.config);
        exHitCheckTask_AddHitCheck(&work->animator.hitChecker);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBossMagmaEruption_Action_Lower(void)
{
    exBossMagmaAttackTask *work = ExTaskGetWorkCurrent(exBossMagmaAttackTask);

    SetExBossMagmaAttackAnim(&work->animator, ex_effe_fcol2);
    SetExDrawRequestAnimStopOnFinish(&work->animator.config);
    SetExDrawRequestAnimStopOnFinish(&work->animator.config);

    work->velocity.y = FLOAT_TO_FX32(3.0);

    SetCurrentExTaskMainEvent(ExBossMagmaEruption_Main_Lower);
    ExBossMagmaEruption_Main_Lower();
}

void ExBossMagmaEruption_Main_Lower(void)
{
    exBossMagmaAttackTask *work = ExTaskGetWorkCurrent(exBossMagmaAttackTask);

    AnimateExDrawRequestModel(&work->animator);
    work->animator.model.translation.y -= work->velocity.y;

    if (IsExDrawRequestModelAnimFinished(&work->animator))
    {
        DestroyCurrentExTask();
    }
    else if (work->animator.model.translation.x >= EX_STAGE_BOUNDARY_R|| work->animator.model.translation.x <= EX_STAGE_BOUNDARY_L
             || work->animator.model.translation.y >= EX_STAGE_BOUNDARY_B || work->animator.model.translation.y <= EX_STAGE_BOUNDARY_T)
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->animator, &work->animator.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

BOOL CreateExBossMagmaEruption(void)
{
    Task *task = ExTaskCreate(ExBossMagmaEruption_Main_Init, ExBossMagmaEruption_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exBossMagmaAttackTask);

    exBossMagmaAttackTask *work = ExTaskGetWork(task, exBossMagmaAttackTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);
    SetExTaskOnCheckStageFinishedEvent(task, ExBossMagmaEruption_OnCheckStageFinished);

    return TRUE;
}

BOOL LoadExBossMagmaWaveAssets(EX_ACTION_NN_WORK *work)
{
    magmaWaveLastSpawnedWorker = work;

    if (magmaWaveModelFileSize != 0 && magmaWaveWaveTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < magmaWaveModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < magmaWaveWaveTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < magmaWaveModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (magmaWaveInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_WAVE_NSBMD, &magmaWaveModelResource, &magmaWaveModelFileSize, TRUE, FALSE);

        magmaWaveAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_WAVE_NSBCA);
        magmaWaveAnimType[0]     = B3D_ANIM_JOINT_ANIM;
        magmaWaveAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_WAVE_NSBMA);
        magmaWaveAnimType[1]     = B3D_ANIM_MAT_ANIM;
        magmaWaveAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_WAVE_NSBTA);
        magmaWaveAnimType[2]     = B3D_ANIM_TEX_ANIM;
        magmaWaveAnimResource[3] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_WAVE_NSBVA);
        magmaWaveAnimType[3]     = B3D_ANIM_VIS_ANIM;

        Asset3DSetup__Create(magmaWaveModelResource);
    }

    AnimatorMDL *animator = &work->model.animator;
    AnimatorMDL__Init(animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(animator, magmaWaveModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < ARRAY_COUNT(magmaWaveAnimType); i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, magmaWaveAnimType[i], magmaWaveAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = magmaWaveAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[magmaWaveAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(0.0);

    work->model.scale.x = FLOAT_TO_FX32(1.0);
    work->model.scale.y = FLOAT_TO_FX32(1.0);
    work->model.scale.z = FLOAT_TO_FX32(1.0);
    work->model.angle.x = FLOAT_DEG_TO_IDX(89.98);

    work->hitChecker.type                    = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isBossMagmaWave = TRUE;
    work->hitChecker.box.size.x              = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y              = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z              = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position            = &work->model.translation;

    magmaWaveInstanceCount++;

    return TRUE;
}

void ReleaseExBossMagmaWaveAssets(EX_ACTION_NN_WORK *work)
{
    if (magmaWaveInstanceCount <= 1)
    {
        if (magmaWaveModelResource)
            NNS_G3dResDefaultRelease(magmaWaveModelResource);

        if (magmaWaveAnimResource[0])
            NNS_G3dResDefaultRelease(magmaWaveAnimResource[0]);

        if (magmaWaveAnimResource[1])
            NNS_G3dResDefaultRelease(magmaWaveAnimResource[1]);

        if (magmaWaveAnimResource[2])
            NNS_G3dResDefaultRelease(magmaWaveAnimResource[2]);

        if (magmaWaveAnimResource[3])
            NNS_G3dResDefaultRelease(magmaWaveAnimResource[3]);

        if (magmaWaveModelResource)
            HeapFree(HEAP_USER, magmaWaveModelResource);
        magmaWaveModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);
    magmaWaveInstanceCount--;
}

void ExBossMagmaWave_Main_Init(void)
{
    exBossMagmeWaveTask *work = ExTaskGetWorkCurrent(exBossMagmeWaveTask);

    magmaWaveTaskSingleton = GetCurrentTask();

    LoadExBossMagmaWaveAssets(&work->animator);
    SetExDrawRequestPriority(&work->animator.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->animator.config);

    work->animator.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
    work->animator.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
    work->animator.model.translation.z = FLOAT_TO_FX32(0.0);

    SetCurrentExTaskMainEvent(ExBossMagmaWave_Main_Active);
}

void ExBossMagmaWave_OnCheckStageFinished(void)
{
    exBossMagmeWaveTask *work = ExTaskGetWorkCurrent(exBossMagmeWaveTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBossMagmaWave_Destructor(void)
{
    exBossMagmeWaveTask *work = ExTaskGetWorkCurrent(exBossMagmeWaveTask);

    ReleaseExBossMagmaWaveAssets(&work->animator);

    magmaWaveTaskSingleton = NULL;
}

void ExBossMagmaWave_Main_Active(void)
{
    exBossMagmeWaveTask *work = ExTaskGetWorkCurrent(exBossMagmeWaveTask);

    AnimateExDrawRequestModel(&work->animator);
    if (IsExDrawRequestModelAnimFinished(&work->animator))
    {
        GetExTaskCurrent()->main = ExTask_State_Destroy;
    }
    else
    {
        AddExDrawRequest(&work->animator, &work->animator.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

BOOL CreateExBossMagmaWave(void)
{
    Task *task =
        ExTaskCreate(ExBossMagmaWave_Main_Init, ExBossMagmaWave_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exBossMagmeWaveTask);

    exBossMagmeWaveTask *work = ExTaskGetWork(task, exBossMagmeWaveTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);
    SetExTaskOnCheckStageFinishedEvent(task, ExBossMagmaWave_OnCheckStageFinished);

    return TRUE;
}

// ExBoss
void ExBoss_Action_StartMagmaEruptionAttack(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_wave0);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);
    PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_E_HORE);

    SetCurrentExTaskMainEvent(ExBoss_Main_MagmaEruption0);
    ExBoss_Main_MagmaEruption0();
}

void ExBoss_Main_MagmaEruption0(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_StartMagmaEruption1();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_Action_StartMagmaEruption1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_wave1);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_MagmaEruption1);
    ExBoss_Main_MagmaEruption1();
}

void ExBoss_Main_MagmaEruption1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_StartMagmaEruption2();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_Action_StartMagmaEruption2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_wave2);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    work->magmaEruptionUnknownPos.y = FLOAT_TO_FX32(0.0);

    SetCurrentExTaskMainEvent(ExBoss_Main_StartMagmaEruption2);
    ExBoss_Main_StartMagmaEruption2();
}

void ExBoss_Main_StartMagmaEruption2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    if (work->aniBoss.model.translation.y <= FLOAT_TO_FX32(120.0) && work->magmaEruptionUnknownPos.y <= FLOAT_TO_FX32(20.0))
    {
        work->magmaEruptionUnknownPos.y += FLOAT_TO_FX32(0.80005);
        work->aniBoss.model.translation.y += FLOAT_TO_FX32(0.80005);
    }

    if (work->aniBoss.model.primaryAnimResource->frame >= FLOAT_TO_FX32(15.0))
    {
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_PREPARE);

        SetCurrentExTaskMainEvent(ExBoss_Main_ProcessMagmaEruption2);
        ExBoss_Main_ProcessMagmaEruption2();
    }
    else if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_StartMagmaEruption3();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_Main_ProcessMagmaEruption2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    if (work->aniBoss.model.translation.y <= FLOAT_TO_FX32(120.0) && work->magmaEruptionUnknownPos.y <= FLOAT_TO_FX32(20.0))
    {
        work->magmaEruptionUnknownPos.y += FLOAT_TO_FX32(0.80005);
        work->aniBoss.model.translation.y += FLOAT_TO_FX32(0.80005);
    }

    if (work->aniBoss.model.primaryAnimResource->frame >= FLOAT_TO_FX32(37.0))
    {
        CreateExBossMagmaWave();

        SetCurrentExTaskMainEvent(ExBoss_Main_FinishMagmaEruption2);
        ExBoss_Main_FinishMagmaEruption2();
    }
    else if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_StartMagmaEruption3();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_Main_FinishMagmaEruption2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_StartMagmaEruption3();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_Action_StartMagmaEruption3(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    s32 timerChance = mtMathRand() % 100;
    s32 moveChance  = mtMathRand() % 100;

    SetExBossAnimation(&work->aniBoss, bse_body_wave3);
    SetExDrawRequestAnimAsOneShot(&work->aniBoss.config);

    if (timerChance < 20 && timerChance >= 0)
    {
        work->genericAttackTimer = SECONDS_TO_FRAMES(3);
    }
    else if (timerChance >= 20 && timerChance < 70)
    {
        work->genericAttackTimer = SECONDS_TO_FRAMES(5);
    }
    else if (timerChance >= 70 && timerChance <= 100)
    {
        work->genericAttackTimer = SECONDS_TO_FRAMES(8);
    }

    // Why are we using "timerChance" here? This looks like it should be using "moveChance" instead...
    if (moveChance < 50 && timerChance >= 0)
    {
        work->magmaEruptionTargetPosL.x = work->aniBoss.model.translation.x;
        work->magmaEruptionTargetPosR.x = work->aniBoss.model.translation.x;
    }
    else if (moveChance >= 50 && moveChance < 80)
    {
        work->magmaEruptionTargetPosL.x = -FLOAT_TO_FX32(12.5);
        work->magmaEruptionTargetPosR.x = FLOAT_TO_FX32(12.5);
    }
    else if (moveChance >= 80 && moveChance <= 100)
    {
        work->magmaEruptionTargetPosL.x = -FLOAT_TO_FX32(25.0);
        work->magmaEruptionTargetPosR.x = FLOAT_TO_FX32(25.0);
    }

    work->targetPos.x = FLOAT_TO_FX32(0.0);
    work->targetPos.y = FLOAT_TO_FX32(0.0);
    work->targetPos.z = FLOAT_TO_FX32(0.0);

    if ((mtMathRand() % 2) != 0)
        work->isMagmaEruptionOscillatingLeft = FALSE;
    else
        work->isMagmaEruptionOscillatingLeft = TRUE;

    if ((mtMathRand() % 2) != 0)
        work->isMagmaEruptionMovingLeft = FALSE;
    else
        work->isMagmaEruptionMovingLeft = TRUE;

    SetCurrentExTaskMainEvent(ExBoss_Main_MagmaEruption3);
    ExBoss_Main_MagmaEruption3();
}

void ExBoss_Main_MagmaEruption3(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    if (work->isMagmaEruptionMovingLeft)
        ExBoss_WaveMoveL();
    else
        ExBoss_WaveMoveR();

    if (work->isMagmaEruptionOscillatingLeft)
        ExBoss_WaveAngleMoveL();
    else
        ExBoss_WaveAngleMoveR();

    work->aniBoss.model.angle.y = ExUtils_Atan2(work->targetPos.x - work->aniBoss.model.translation.x, work->aniBoss.model.translation.y - work->targetPos.y);

    if (work->genericAttackTimer <= 0)
    {
        work->genericAttackTimer = 0;

        SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);
        if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
        {
            ExBoss_Action_StartMagmaEruption4();
            return;
        }
    }
    else
    {
        work->genericAttackTimer--;

        if ((work->genericAttackTimer % 12) == 0)
        {
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_MAGMA_WAVE);
            CreateExBossMagmaEruption();
        }
    }

    exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
    AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

void ExBoss_WaveAngleMoveL(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    if (work->targetPos.x <= EX_STAGE_BOUNDARY_L)
        work->isMagmaEruptionOscillatingLeft = FALSE;
    else
        work->targetPos.x -= FLOAT_TO_FX32(4.0);
}

void ExBoss_WaveAngleMoveR(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    if (work->targetPos.x >= EX_STAGE_BOUNDARY_R)
        work->isMagmaEruptionOscillatingLeft = TRUE;
    else
        work->targetPos.x += FLOAT_TO_FX32(4.0);
}

void ExBoss_WaveMoveL(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    if (work->aniBoss.model.translation.x <= work->magmaEruptionTargetPosL.x)
        work->isMagmaEruptionMovingLeft = FALSE;
    else
        work->aniBoss.model.translation.x -= FLOAT_TO_FX32(0.5);
}

void ExBoss_WaveMoveR(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    if (work->aniBoss.model.translation.x >= work->magmaEruptionTargetPosR.x)
        work->isMagmaEruptionMovingLeft = TRUE;
    else
        work->aniBoss.model.translation.x += FLOAT_TO_FX32(0.5);
}

void ExBoss_Action_StartMagmaEruption4(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_wave4);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_MagmaEruption4);
    ExBoss_Main_MagmaEruption4();
}

void ExBoss_Main_MagmaEruption4(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    work->targetPos.x += mtMoveTowards(FLOAT_TO_FX32(0.1001), work->targetPos.x, FLOAT_TO_FX32(0.0));
    work->targetPos.y += mtMoveTowards(FLOAT_TO_FX32(0.1001), work->targetPos.y, FLOAT_TO_FX32(0.0));

    work->aniBoss.model.angle.y = ExUtils_Atan2(work->targetPos.x - work->aniBoss.model.translation.x, work->aniBoss.model.translation.y - work->targetPos.y);

    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Main_FinishMagmaEruptionAttack();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_Main_FinishMagmaEruptionAttack(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->nextAttackState();
}