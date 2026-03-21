#include <ex/effects/exSonicBarrier.h>
#include <ex/player/exPlayer.h>
#include <ex/system/exSystem.h>
#include <ex/system/exMath.h>
#include <game/audio/audioSystem.h>
#include <game/file/binaryBundle.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// STRUCTS
// --------------------

struct ExBarrierChargingEffectConfig
{
    VecFloat scale;
    VecFloat size;
};

// --------------------
// VARIABLES
// --------------------

static s16 sSonicBarrierHitEffectInstanceCount;
static s16 sSonicBarrierEffectSpriteInstanceCount;
static s16 sSonicBarrierChargingEffectInstanceCount;

static void *sSonicBarrierChargingEffectModelResource;
static u32 sSonicBarrierChargingEffectTextureFileSize;
static u32 sSonicBarrierChargingEffectModelFileSize;
static void *sSonicBarrierEffectUnused;
static u32 sSonicBarrierHitEffectTextureFileSize;
static void *sSonicBarrierHitEffectUnused;
static void *sSonicBarrierHitEffectModelResource;
static void *sSonicBarrierHitEffectLastSpawnedWorker;
static BOOL sDisableSonicBarrierEffectSpawning;
static Task *sSonicBarrierEffectTaskSingleton;
static void *sSonicBarrierChargingEffectLastSpawnedWorker;
static void *sSonicBarrierEffectSpriteResource;
static Task *sSonicBarrierChargingEffectTaskSingleton;
static Task *sSonicBarrierHitEffectTaskSingleton;
static u32 sSonicBarrierHitEffectModelFileSize;
static void *sSonicBarrierChargingEffectAnimResource[2];
static void *sSonicBarrierHitEffectAnimResource[3];
static u32 sSonicBarrierHitEffectAnimType[3];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(sSonicBarrierEffectUnused)
FORCE_INCLUDE_VARIABLE_BSS(sSonicBarrierHitEffectUnused)

static struct ExBarrierChargingEffectConfig sSonicBarrierChargingEffectConfig[] = {
    [0] = { .scale = { 1.0f, 1.0f, 1.0f }, .size = { 0.0f, 0.0f, 0.0f } },
    [1] = { .scale = { 2.5f, 2.5f, 2.5f }, .size = { 0.0f, 0.0f, 0.0f } },
    [2] = { .scale = { 2.5f, 2.5f, 2.5f }, .size = { 0.0f, 0.0f, 0.0f } },
};

// --------------------
// FUNCTION DECLS
// --------------------

// ExSonicBarrierHitEffect
static BOOL LoadExSonicBarrierHitEffectAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExSonicBarrierHitEffectAssets(EX_ACTION_NN_WORK *work);
static void ExSonicBarrierHitEffect_Main_Init(void);
static void ExSonicBarrierHitEffect_OnCheckStageFinished(void);
static void ExSonicBarrierHitEffect_Destructor(void);
static void ExSonicBarrierHitEffect_Main_Active(void);

// ExSonicBarrierEffect
static void LoadExSonicBarrierEffectAssets(EX_ACTION_BAC3D_WORK *work);
static void SetExSonicBarrierEffectAnimation(EX_ACTION_BAC3D_WORK *work, u16 anim);
static void ReleaseExSonicBarrierEffectAssets(EX_ACTION_BAC3D_WORK *work);
static void ExSonicBarrierEffect_Main_Init(void);
static void ExSonicBarrierEffect_OnCheckStageFinished(void);
static void ExSonicBarrierEffect_Destructor(void);
static void ExSonicBarrierEffect_Main_InitBarrierActive(void);
static void ExSonicBarrierEffect_Main_BarrierActive(void);
static void ExSonicBarrierEffect_Main_InitBarrierHit(void);
static void ExSonicBarrierEffect_Main_BarrierHit(void);
static void ExSonicBarrierEffect_OnHitstopActive(void);

// ExSonicBarrierChargingEffect
static BOOL LoadExSonicBarrierChargingEffectAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExSonicBarrierChargingEffectAssets(EX_ACTION_NN_WORK *work);
static void ExSonicBarrierChargingEffect_Main_Init(void);
static void ExSonicBarrierChargingEffect_OnCheckStageFinished(void);
static void ExSonicBarrierChargingEffect_Destructor(void);
static void ExSonicBarrierChargingEffect_Main_Active(void);

// --------------------
// FUNCTIONS
// --------------------

BOOL LoadExSonicBarrierHitEffectAssets(EX_ACTION_NN_WORK *work)
{
    sSonicBarrierHitEffectLastSpawnedWorker = work;

    if (sSonicBarrierHitEffectModelFileSize != 0 && sSonicBarrierHitEffectTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < sSonicBarrierHitEffectModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < sSonicBarrierHitEffectTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < sSonicBarrierHitEffectModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (sSonicBarrierHitEffectInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_HIT0_NSBMD, &sSonicBarrierHitEffectModelResource,
                                      &sSonicBarrierHitEffectModelFileSize, TRUE, FALSE);

        sSonicBarrierHitEffectAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_HIT0_NSBCA);
        sSonicBarrierHitEffectAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        sSonicBarrierHitEffectAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_HIT0_NSBMA);
        sSonicBarrierHitEffectAnimType[1]     = B3D_ANIM_MAT_ANIM;

        sSonicBarrierHitEffectAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_HIT0_NSBVA);
        sSonicBarrierHitEffectAnimType[2]     = B3D_ANIM_VIS_ANIM;

        CreateAsset3DSetup(sSonicBarrierHitEffectModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sSonicBarrierHitEffectModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, sSonicBarrierHitEffectAnimType[i], sSonicBarrierHitEffectAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = sSonicBarrierHitEffectAnimType[1];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[sSonicBarrierHitEffectAnimType[1]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(60.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z       = FLOAT_DEG_TO_IDX(179.9561);

    work->hitChecker.type            = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isSpriteOrModelVFX = TRUE;
    work->hitChecker.box.size.x      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position    = &work->model.translation;

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    sSonicBarrierHitEffectInstanceCount++;

    return TRUE;
}

void ReleaseExSonicBarrierHitEffectAssets(EX_ACTION_NN_WORK *work)
{
    if (sSonicBarrierHitEffectInstanceCount <= 1)
    {
        if (sSonicBarrierHitEffectModelResource != NULL)
            NNS_G3dResDefaultRelease(sSonicBarrierHitEffectModelResource);

        if (sSonicBarrierHitEffectAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(sSonicBarrierHitEffectAnimResource[0]);

        if (sSonicBarrierHitEffectAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(sSonicBarrierHitEffectAnimResource[1]);

        if (sSonicBarrierHitEffectAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(sSonicBarrierHitEffectAnimResource[2]);

        if (sSonicBarrierHitEffectModelResource != NULL)
            HeapFree(HEAP_USER, sSonicBarrierHitEffectModelResource);
        sSonicBarrierHitEffectModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    sSonicBarrierHitEffectInstanceCount--;
}

void ExSonicBarrierHitEffect_Main_Init(void)
{
    exEffectBarrierHitTask *work = ExTaskGetWorkCurrent(exEffectBarrierHitTask);

    sSonicBarrierHitEffectTaskSingleton = GetCurrentTask();

    LoadExSonicBarrierHitEffectAssets(&work->aniBarrier);
    SetExDrawRequestPriority(&work->aniBarrier.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniBarrier.config);

    SetCurrentExTaskMainEvent(ExSonicBarrierHitEffect_Main_Active);
}

void ExSonicBarrierHitEffect_OnCheckStageFinished(void)
{
    exEffectBarrierHitTask *work = ExTaskGetWorkCurrent(exEffectBarrierHitTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExSonicBarrierHitEffect_Destructor(void)
{
    exEffectBarrierHitTask *work = ExTaskGetWorkCurrent(exEffectBarrierHitTask);

    ReleaseExSonicBarrierHitEffectAssets(&work->aniBarrier);

    sSonicBarrierHitEffectTaskSingleton = NULL;
}

void ExSonicBarrierHitEffect_Main_Active(void)
{
    exEffectBarrierHitTask *work = ExTaskGetWorkCurrent(exEffectBarrierHitTask);

    AnimateExDrawRequestModel(&work->aniBarrier);

    work->aniBarrier.model.translation.x = work->targetPos.x;
    work->aniBarrier.model.translation.y = work->targetPos.y;
    work->aniBarrier.model.translation.z = work->targetPos.z;

    if (IsExDrawRequestModelAnimFinished(&work->aniBarrier))
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->aniBarrier, &work->aniBarrier.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

BOOL CreateExSonicBarrierHitEffect(VecFx32 *targetPos)
{
    if (targetPos == NULL)
        return FALSE;

    Task *task = ExTaskCreate(ExSonicBarrierHitEffect_Main_Init, ExSonicBarrierHitEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(5), 0,
                              EXTASK_TYPE_REGULAR, exEffectBarrierHitTask);

    exEffectBarrierHitTask *work = ExTaskGetWork(task, exEffectBarrierHitTask);
    TaskInitWork8(work);

    work->targetPos.x = targetPos->x;
    work->targetPos.y = targetPos->y;
    work->targetPos.z = targetPos->z;

    SetExTaskOnCheckStageFinishedEvent(task, ExSonicBarrierHitEffect_OnCheckStageFinished);

    return TRUE;
}

void LoadExSonicBarrierEffectAssets(EX_ACTION_BAC3D_WORK *work)
{
    InitExDrawRequestSprite3D(work);

    if (sSonicBarrierEffectSpriteInstanceCount == 0)
        sSonicBarrierEffectSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(sSonicBarrierEffectSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(sSonicBarrierEffectSpriteResource, 1), FALSE);

    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, sSonicBarrierEffectSpriteResource, EX_ACTCOM_ANI_SONIC_BARRIER_SHIELD, ANIMATOR_FLAG_DISABLE_LOOPING,
                           vramPixels, vramPalette);
    work->sprite.animator.polygonAttr.xluDepthUpdate = TRUE;

    work->hitChecker.type                         = EXHITCHECK_TYPE_ACTIVE_PLAYER;
    work->hitChecker.input.isSonicBarrierEffect = TRUE;

    work->sprite.translation.z = FLOAT_TO_FX32(70.0);
    work->sprite.scale.x       = FLOAT_TO_FX32(0.3125);
    work->sprite.scale.y       = FLOAT_TO_FX32(0.3125);
    work->sprite.scale.z       = FLOAT_TO_FX32(1.0);

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    work->hitChecker.box.size.x   = FLOAT_TO_FX32(6.25);
    work->hitChecker.box.size.y   = FLOAT_TO_FX32(6.25);
    work->hitChecker.box.size.z   = FLOAT_TO_FX32(6.25);
    work->hitChecker.box.position = &work->sprite.translation;

    sSonicBarrierEffectSpriteInstanceCount++;
}

void SetExSonicBarrierEffectAnimation(EX_ACTION_BAC3D_WORK *work, u16 anim)
{
    work->sprite.anim = anim;
    AnimatorSprite__SetAnimation(&work->sprite.animator.animatorSprite, anim);
}

void ReleaseExSonicBarrierEffectAssets(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    sSonicBarrierEffectSpriteInstanceCount--;
}

void ExSonicBarrierEffect_Main_Init(void)
{
    exEffectBarrierTask *work = ExTaskGetWorkCurrent(exEffectBarrierTask);

    sSonicBarrierEffectTaskSingleton = GetCurrentTask();

    LoadExSonicBarrierEffectAssets(&work->aniBarrier);
    SetExDrawRequestPriority(&work->aniBarrier.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniBarrier.config);

    work->aniBarrier.hitChecker.power = work->power;

    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        if (work->parent->hitChecker.power == EXPLAYER_BARRIER_CHARGED_POWER_NORMAL)
        {
            work->aniBarrier.sprite.scale.x        = FLOAT_TO_FX32(0.46875);
            work->aniBarrier.sprite.scale.y        = FLOAT_TO_FX32(0.46875);
            work->aniBarrier.hitChecker.box.size.x = FLOAT_TO_FX32(9.375);
            work->aniBarrier.hitChecker.box.size.y = FLOAT_TO_FX32(9.375);
        }
    }
    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
    {
        if (work->parent->hitChecker.power == EXPLAYER_BARRIER_CHARGED_POWER_EASY)
        {
            work->aniBarrier.sprite.scale.x        = FLOAT_TO_FX32(0.46875);
            work->aniBarrier.sprite.scale.y        = FLOAT_TO_FX32(0.46875);
            work->aniBarrier.hitChecker.box.size.x = FLOAT_TO_FX32(9.375);
            work->aniBarrier.hitChecker.box.size.y = FLOAT_TO_FX32(9.375);
        }
    }

    work->field_2 = 0;

    SetCurrentExTaskMainEvent(ExSonicBarrierEffect_Main_InitBarrierActive);
}

void ExSonicBarrierEffect_OnCheckStageFinished(void)
{
    exEffectBarrierTask *work = ExTaskGetWorkCurrent(exEffectBarrierTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExSonicBarrierEffect_Destructor(void)
{
    exEffectBarrierTask *work = ExTaskGetWorkCurrent(exEffectBarrierTask);

    ReleaseExSonicBarrierEffectAssets(&work->aniBarrier);

    sSonicBarrierEffectTaskSingleton = NULL;
}

void ExSonicBarrierEffect_Main_InitBarrierActive(void)
{
    exEffectBarrierTask *work = ExTaskGetWorkCurrent(exEffectBarrierTask);

    SetExSonicBarrierEffectAnimation(&work->aniBarrier, EX_ACTCOM_ANI_SONIC_BARRIER_ACTIVE);
    SetExDrawRequestAnimStopOnFinish(&work->aniBarrier.config);

    sDisableSonicBarrierEffectSpawning = FALSE;

    work->aniBarrier.sprite.translation.x = work->parent->model.translation.x;
    work->aniBarrier.sprite.translation.y = work->parent->model.translation.y;

    SetCurrentExTaskMainEvent(ExSonicBarrierEffect_Main_BarrierActive);
    ExSonicBarrierEffect_Main_BarrierActive();
}

void ExSonicBarrierEffect_Main_BarrierActive(void)
{
    exEffectBarrierTask *work = ExTaskGetWorkCurrent(exEffectBarrierTask);

    AnimateExDrawRequestSprite3D(&work->aniBarrier);

    if (work->aniBarrier.hitChecker.output.hasCollision)
    {
        CreateExSonicBarrierHitEffect(&work->aniBarrier.sprite.translation);
        ExSonicBarrierEffect_Main_InitBarrierHit();
    }
    else if (IsExDrawRequestSprite3DAnimFinished(&work->aniBarrier))
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->aniBarrier, &work->aniBarrier.config);
        exHitCheckTask_AddHitCheck(&work->aniBarrier.hitChecker);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExSonicBarrierEffect_Main_InitBarrierHit(void)
{
    exEffectBarrierTask *work = ExTaskGetWorkCurrent(exEffectBarrierTask);

    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        if (work->parent->hitChecker.power == EXPLAYER_BARRIER_CHARGED_POWER_NORMAL)
        {
            work->aniBarrier.sprite.scale.x        = FLOAT_TO_FX32(0.40625);
            work->aniBarrier.sprite.scale.y        = FLOAT_TO_FX32(0.40625);
            work->aniBarrier.hitChecker.box.size.x = FLOAT_TO_FX32(8.125);
            work->aniBarrier.hitChecker.box.size.y = FLOAT_TO_FX32(8.125);

            SetCurrentExTaskHitstopTimer(5);
            SetExTaskHitstopTimer(work->parentTask, 5);

            work->parent->config.control.timer    = 5;
            work->aniBarrier.config.control.timer = 5;

            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_RETURN_L);
        }
        else
        {
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_RETURN_S);
        }
    }
    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
    {
        if (work->parent->hitChecker.power == EXPLAYER_BARRIER_CHARGED_POWER_EASY)
        {
            work->aniBarrier.sprite.scale.x        = FLOAT_TO_FX32(0.40625);
            work->aniBarrier.sprite.scale.y        = FLOAT_TO_FX32(0.40625);
            work->aniBarrier.hitChecker.box.size.x = FLOAT_TO_FX32(8.125);
            work->aniBarrier.hitChecker.box.size.y = FLOAT_TO_FX32(8.125);

            SetCurrentExTaskHitstopTimer(5);
            SetExTaskHitstopTimer(work->parentTask, 5);

            work->parent->config.control.timer    = 5;
            work->aniBarrier.config.control.timer = 5;

            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_RETURN_L);
        }
        else
        {
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_RETURN_S);
        }
    }

    SetExSonicBarrierEffectAnimation(&work->aniBarrier, EX_ACTCOM_ANI_SONIC_BARRIER_HIT);
    SetExDrawRequestAnimStopOnFinish(&work->aniBarrier.config);

    SetCurrentExTaskMainEvent(ExSonicBarrierEffect_Main_BarrierHit);
    ExSonicBarrierEffect_Main_BarrierHit();
}

void ExSonicBarrierEffect_Main_BarrierHit(void)
{
    exEffectBarrierTask *work = ExTaskGetWorkCurrent(exEffectBarrierTask);

    AnimateExDrawRequestSprite3D(&work->aniBarrier);

    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        if (work->parent->hitChecker.power == EXPLAYER_BARRIER_CHARGED_POWER_NORMAL)
        {
            ProcessExDrawTimer(&work->parent->config);
            ProcessExDrawTimer(&work->aniBarrier.config);
        }
    }
    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
    {
        if (work->parent->hitChecker.power == EXPLAYER_BARRIER_CHARGED_POWER_EASY)
        {
            ProcessExDrawTimer(&work->parent->config);
            ProcessExDrawTimer(&work->aniBarrier.config);
        }
    }

    if (IsExDrawRequestSprite3DAnimFinished(&work->aniBarrier))
    {
        work->parent->config.control.timer    = 0;
        work->aniBarrier.config.control.timer = 0;

        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->aniBarrier, &work->aniBarrier.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExSonicBarrierEffect_OnHitstopActive(void)
{
    exEffectBarrierTask *work = ExTaskGetWorkCurrent(exEffectBarrierTask);

    ProcessExDrawTimer(&work->parent->config);
    ProcessExDrawTimer(&work->aniBarrier.config);
    AddExDrawRequest(&work->aniBarrier, &work->aniBarrier.config);

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

void CreateExSonicBarrierEffect(EX_ACTION_NN_WORK *parent)
{
    if (sDisableSonicBarrierEffectSpawning)
        return;

    Task *task = ExTaskCreate(ExSonicBarrierEffect_Main_Init, ExSonicBarrierEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exEffectBarrierTask);

    sDisableSonicBarrierEffectSpawning = TRUE;

    exEffectBarrierTask *work = ExTaskGetWork(task, exEffectBarrierTask);
    TaskInitWork8(work);

    work->parent     = parent;
    work->parentTask = GetCurrentTask();
    work->power      = work->parent->hitChecker.power;

    SetExTaskOnCheckStageFinishedEvent(task, ExSonicBarrierEffect_OnCheckStageFinished);
    SetExTaskOnHitstopActiveEvent(task, ExSonicBarrierEffect_OnHitstopActive);
}

BOOL LoadExSonicBarrierChargingEffectAssets(EX_ACTION_NN_WORK *work)
{
    sSonicBarrierChargingEffectLastSpawnedWorker = work;

    if (sSonicBarrierChargingEffectModelFileSize != 0 && sSonicBarrierChargingEffectTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < sSonicBarrierChargingEffectModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < sSonicBarrierChargingEffectTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < sSonicBarrierChargingEffectModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (sSonicBarrierChargingEffectInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_SONSA_NSBMD, &sSonicBarrierChargingEffectModelResource,
                                      &sSonicBarrierChargingEffectModelFileSize, TRUE, FALSE);

        sSonicBarrierChargingEffectAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SONSA_NSBCA);
        sSonicBarrierChargingEffectAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SONSA_NSBVA);
        CreateAsset3DSetup(sSonicBarrierChargingEffectModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sSonicBarrierChargingEffectModelResource, 0, FALSE, FALSE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, sSonicBarrierChargingEffectAnimResource[0], 0, NULL);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_VIS_ANIM, sSonicBarrierChargingEffectAnimResource[1], 0, NULL);

    work->model.primaryAnimType     = B3D_ANIM_JOINT_ANIM;
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[B3D_ANIM_JOINT_ANIM];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(70.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z       = FLOAT_DEG_TO_IDX(179.9561);

    work->hitChecker.type            = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isSpriteOrModelVFX = TRUE;
    work->hitChecker.box.size.x      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position    = &work->model.translation;

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    sSonicBarrierChargingEffectInstanceCount++;

    return TRUE;
}

void ReleaseExSonicBarrierChargingEffectAssets(EX_ACTION_NN_WORK *work)
{
    if (sSonicBarrierChargingEffectInstanceCount <= 1)
    {
        if (sSonicBarrierChargingEffectModelResource != NULL)
            NNS_G3dResDefaultRelease(sSonicBarrierChargingEffectModelResource);

        if (sSonicBarrierChargingEffectAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(sSonicBarrierChargingEffectAnimResource[0]);

        if (sSonicBarrierChargingEffectAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(sSonicBarrierChargingEffectAnimResource[1]);

        if (sSonicBarrierChargingEffectModelResource != NULL)
            HeapFree(HEAP_USER, sSonicBarrierChargingEffectModelResource);
        sSonicBarrierChargingEffectModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    sSonicBarrierChargingEffectInstanceCount--;
}

void ExSonicBarrierChargingEffect_Main_Init(void)
{
    exExEffectSonicBarrierTaMeTask *work = ExTaskGetWorkCurrent(exExEffectSonicBarrierTaMeTask);

    sSonicBarrierChargingEffectTaskSingleton = GetCurrentTask();

    LoadExSonicBarrierChargingEffectAssets(&work->aniTaMe);
    SetExDrawRequestPriority(&work->aniTaMe.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->aniTaMe.config);

    work->scale     = FLOAT_TO_FX32(1.0);
    work->sndHandle = AllocSndHandle();

    PlayHandleStageSfx(work->sndHandle, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_BULLET);

    SetCurrentExTaskMainEvent(ExSonicBarrierChargingEffect_Main_Active);
}

void ExSonicBarrierChargingEffect_OnCheckStageFinished(void)
{
    exExEffectSonicBarrierTaMeTask *work = ExTaskGetWorkCurrent(exExEffectSonicBarrierTaMeTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExSonicBarrierChargingEffect_Destructor(void)
{
    exExEffectSonicBarrierTaMeTask *work = ExTaskGetWorkCurrent(exExEffectSonicBarrierTaMeTask);

    StopStageSfx(work->sndHandle);
    FreeSndHandle(work->sndHandle);

    ReleaseExSonicBarrierChargingEffectAssets(&work->aniTaMe);

    sSonicBarrierChargingEffectTaskSingleton = NULL;
}

void ExSonicBarrierChargingEffect_Main_Active(void)
{
    exExEffectSonicBarrierTaMeTask *work = ExTaskGetWorkCurrent(exExEffectSonicBarrierTaMeTask);

    AnimateExDrawRequestModel(&work->aniTaMe);

    if (GetExPlayerWorker()->barrierChargeTimer != 0)
    {
        float maxScale;
        MULTIPLY_FLOAT_FX(maxScale, sSonicBarrierChargingEffectConfig[2].scale.x)

        if (work->scale >= (fx32)maxScale)
        {
            float scaleF;
            MULTIPLY_FLOAT_FX(scaleF, sSonicBarrierChargingEffectConfig[2].scale.x)
            work->scale = scaleF;
        }
        else
        {
            float scaleF;
            MULTIPLY_FLOAT_FX(scaleF, (sSonicBarrierChargingEffectConfig[2].scale.x - sSonicBarrierChargingEffectConfig[0].scale.x) / 120.0f)
            work->scale += (fx32)scaleF;
        }
    }
    else
    {
        DestroyCurrentExTask();
        return;
    }

    work->aniTaMe.model.translation.x = work->parent->model.translation.x;
    work->aniTaMe.model.translation.y = work->parent->model.translation.y;
    work->aniTaMe.model.translation.z = work->parent->model.translation.z;

    work->aniTaMe.model.scale.x = work->scale;
    work->aniTaMe.model.scale.y = work->scale;
    work->aniTaMe.model.scale.z = work->scale;

    AddExDrawRequest(&work->aniTaMe, &work->aniTaMe.config);

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

BOOL CreateExSonicBarrierChargingEffect(EX_ACTION_NN_WORK *parent)
{
    Task *task = ExTaskCreate(ExSonicBarrierChargingEffect_Main_Init, ExSonicBarrierChargingEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(5), 0,
                              EXTASK_TYPE_REGULAR, exExEffectSonicBarrierTaMeTask);

    exExEffectSonicBarrierTaMeTask *work = ExTaskGetWork(task, exExEffectSonicBarrierTaMeTask);
    TaskInitWork8(work);

    work->parent     = parent;
    work->parentTask = GetCurrentTask();

    SetExTaskOnCheckStageFinishedEvent(task, ExSonicBarrierChargingEffect_OnCheckStageFinished);

    return TRUE;
}