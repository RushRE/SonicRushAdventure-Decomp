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

static s16 exSonicBarrierHitEffectInstanceCount;
static s16 exSonicBarrierEffectSpriteInstanceCount;
static s16 exSonicBarrierChargingEffectInstanceCount;

static void *exSonicBarrierChargingEffectModelResource;
static u32 exSonicBarrierChargingEffectTextureFileSize;
static u32 exSonicBarrierChargingEffectModelFileSize;
static void *exSonicBarrierEffectUnused;
static u32 exSonicBarrierHitEffectTextureFileSize;
static void *exSonicBarrierHitEffectUnused;
static void *exSonicBarrierHitEffectModelResource;
static void *exSonicBarrierHitEffectLastSpawnedWorker;
static BOOL disableExSonicBarrierEffectSpawning;
static Task *exSonicBarrierEffectTaskSingleton;
static void *exSonicBarrierChargingEffectLastSpawnedWorker;
static void *exSonicBarrierEffectSpriteResource;
static Task *exSonicBarrierChargingEffectTaskSingleton;
static Task *exSonicBarrierHitEffectTaskSingleton;
static u32 exSonicBarrierHitEffectModelFileSize;
static void *exSonicBarrierChargingEffectAnimResource[2];
static void *exSonicBarrierHitEffectAnimResource[3];
static u32 exSonicBarrierHitEffectAnimType[3];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(exSonicBarrierEffectUnused)
FORCE_INCLUDE_VARIABLE_BSS(exSonicBarrierHitEffectUnused)

static struct ExBarrierChargingEffectConfig exSonicBarrierChargingEffectConfig[] = {
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
static void ExSonicBarrierHitEffect_TaskUnknown(void);
static void ExSonicBarrierHitEffect_Destructor(void);
static void ExSonicBarrierHitEffect_Main_Active(void);

// ExSonicBarrierEffect
static void LoadExSonicBarrierEffectAssets(EX_ACTION_BAC3D_WORK *work);
static void SetExSonicBarrierEffectAnimation(EX_ACTION_BAC3D_WORK *work, u16 anim);
static void ReleaseExSonicBarrierEffectAssets(EX_ACTION_BAC3D_WORK *work);
static void ExSonicBarrierEffect_Main_Init(void);
static void ExSonicBarrierEffect_TaskUnknown(void);
static void ExSonicBarrierEffect_Destructor(void);
static void ExSonicBarrierEffect_Main_InitBarrierActive(void);
static void ExSonicBarrierEffect_Main_BarrierActive(void);
static void ExSonicBarrierEffect_Main_InitBarrierHit(void);
static void ExSonicBarrierEffect_Main_BarrierHit(void);
static void ExSonicBarrierEffect_DelayCallback(void);

// ExSonicBarrierChargingEffect
static BOOL LoadExSonicBarrierChargingEffectAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExSonicBarrierChargingEffectAssets(EX_ACTION_NN_WORK *work);
static void ExSonicBarrierChargingEffect_Main_Init(void);
static void ExSonicBarrierChargingEffect_TaskUnknown(void);
static void ExSonicBarrierChargingEffect_Destructor(void);
static void ExSonicBarrierChargingEffect_Main_Active(void);

// --------------------
// FUNCTIONS
// --------------------

BOOL LoadExSonicBarrierHitEffectAssets(EX_ACTION_NN_WORK *work)
{
    exSonicBarrierHitEffectLastSpawnedWorker = work;

    if (exSonicBarrierHitEffectModelFileSize != 0 && exSonicBarrierHitEffectTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exSonicBarrierHitEffectModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exSonicBarrierHitEffectTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exSonicBarrierHitEffectModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (exSonicBarrierHitEffectInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_HIT0_NSBMD, &exSonicBarrierHitEffectModelResource,
                                      &exSonicBarrierHitEffectModelFileSize, TRUE, FALSE);

        exSonicBarrierHitEffectAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_HIT0_NSBCA);
        exSonicBarrierHitEffectAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        exSonicBarrierHitEffectAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_HIT0_NSBMA);
        exSonicBarrierHitEffectAnimType[1]     = B3D_ANIM_MAT_ANIM;

        exSonicBarrierHitEffectAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_HIT0_NSBVA);
        exSonicBarrierHitEffectAnimType[2]     = B3D_ANIM_VIS_ANIM;

        Asset3DSetup__Create(exSonicBarrierHitEffectModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exSonicBarrierHitEffectModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, exSonicBarrierHitEffectAnimType[i], exSonicBarrierHitEffectAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = exSonicBarrierHitEffectAnimType[1];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[exSonicBarrierHitEffectAnimType[1]];

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

    work->hitChecker.type            = 0;
    work->hitChecker.field_5.value_1 = TRUE;
    work->hitChecker.box.size.x      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position    = &work->model.translation;

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    exSonicBarrierHitEffectInstanceCount++;

    return TRUE;
}

void ReleaseExSonicBarrierHitEffectAssets(EX_ACTION_NN_WORK *work)
{
    if (exSonicBarrierHitEffectInstanceCount <= 1)
    {
        if (exSonicBarrierHitEffectModelResource != NULL)
            NNS_G3dResDefaultRelease(exSonicBarrierHitEffectModelResource);

        if (exSonicBarrierHitEffectAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(exSonicBarrierHitEffectAnimResource[0]);

        if (exSonicBarrierHitEffectAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(exSonicBarrierHitEffectAnimResource[1]);

        if (exSonicBarrierHitEffectAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(exSonicBarrierHitEffectAnimResource[2]);

        if (exSonicBarrierHitEffectModelResource != NULL)
            HeapFree(HEAP_USER, exSonicBarrierHitEffectModelResource);
        exSonicBarrierHitEffectModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    exSonicBarrierHitEffectInstanceCount--;
}

void ExSonicBarrierHitEffect_Main_Init(void)
{
    exEffectBarrierHitTask *work = ExTaskGetWorkCurrent(exEffectBarrierHitTask);

    exSonicBarrierHitEffectTaskSingleton = GetCurrentTask();

    LoadExSonicBarrierHitEffectAssets(&work->aniBarrier);
    SetExDrawRequestPriority(&work->aniBarrier.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniBarrier.config);

    SetCurrentExTaskMainEvent(ExSonicBarrierHitEffect_Main_Active);
}

void ExSonicBarrierHitEffect_TaskUnknown(void)
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

    exSonicBarrierHitEffectTaskSingleton = NULL;
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

        RunCurrentExTaskUnknownEvent();
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

    SetExTaskUnknownEvent(task, ExSonicBarrierHitEffect_TaskUnknown);

    return TRUE;
}

void LoadExSonicBarrierEffectAssets(EX_ACTION_BAC3D_WORK *work)
{
    InitExDrawRequestSprite3D(work);

    if (exSonicBarrierEffectSpriteInstanceCount == 0)
        exSonicBarrierEffectSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(exSonicBarrierEffectSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(exSonicBarrierEffectSpriteResource, 1), FALSE);

    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, exSonicBarrierEffectSpriteResource, EX_ACTCOM_ANI_SONIC_BARRIER_SHIELD, ANIMATOR_FLAG_DISABLE_LOOPING,
                           vramPixels, vramPalette);
    work->sprite.animator.polygonAttr.xluDepthUpdate = TRUE;

    work->hitChecker.type             = 2;
    work->hitChecker.field_3.value_80 = TRUE;

    work->sprite.translation.z = FLOAT_TO_FX32(70.0);
    work->sprite.scale.x       = FLOAT_TO_FX32(0.3125);
    work->sprite.scale.y       = FLOAT_TO_FX32(0.3125);
    work->sprite.scale.z       = FLOAT_TO_FX32(1.0);

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    work->hitChecker.box.size.x   = FLOAT_TO_FX32(6.25);
    work->hitChecker.box.size.y   = FLOAT_TO_FX32(6.25);
    work->hitChecker.box.size.z   = FLOAT_TO_FX32(6.25);
    work->hitChecker.box.position = &work->sprite.translation;

    exSonicBarrierEffectSpriteInstanceCount++;
}

void SetExSonicBarrierEffectAnimation(EX_ACTION_BAC3D_WORK *work, u16 anim)
{
    work->sprite.anim = anim;
    AnimatorSprite__SetAnimation(&work->sprite.animator.animatorSprite, anim);
}

void ReleaseExSonicBarrierEffectAssets(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    exSonicBarrierEffectSpriteInstanceCount--;
}

void ExSonicBarrierEffect_Main_Init(void)
{
    exEffectBarrierTask *work = ExTaskGetWorkCurrent(exEffectBarrierTask);

    exSonicBarrierEffectTaskSingleton = GetCurrentTask();

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

void ExSonicBarrierEffect_TaskUnknown(void)
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

    exSonicBarrierEffectTaskSingleton = NULL;
}

void ExSonicBarrierEffect_Main_InitBarrierActive(void)
{
    exEffectBarrierTask *work = ExTaskGetWorkCurrent(exEffectBarrierTask);

    SetExSonicBarrierEffectAnimation(&work->aniBarrier, EX_ACTCOM_ANI_SONIC_BARRIER_ACTIVE);
    SetExDrawRequestAnimStopOnFinish(&work->aniBarrier.config);

    disableExSonicBarrierEffectSpawning = FALSE;

    work->aniBarrier.sprite.translation.x = work->parent->model.translation.x;
    work->aniBarrier.sprite.translation.y = work->parent->model.translation.y;

    SetCurrentExTaskMainEvent(ExSonicBarrierEffect_Main_BarrierActive);
    ExSonicBarrierEffect_Main_BarrierActive();
}

void ExSonicBarrierEffect_Main_BarrierActive(void)
{
    exEffectBarrierTask *work = ExTaskGetWorkCurrent(exEffectBarrierTask);

    AnimateExDrawRequestSprite3D(&work->aniBarrier);

    if (work->aniBarrier.hitChecker.hitFlags.value_1)
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

        RunCurrentExTaskUnknownEvent();
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

            SetCurrentExTaskTimer(5);
            SetExTaskTimer(work->parentTask, 5);

            work->parent->config.control.timer = 5;
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

            SetCurrentExTaskTimer(5);
            SetExTaskTimer(work->parentTask, 5);

            work->parent->config.control.timer = 5;
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
        work->parent->config.control.timer = 0;
        work->aniBarrier.config.control.timer = 0;

        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->aniBarrier, &work->aniBarrier.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExSonicBarrierEffect_DelayCallback(void)
{
    exEffectBarrierTask *work = ExTaskGetWorkCurrent(exEffectBarrierTask);

    ProcessExDrawTimer(&work->parent->config);
    ProcessExDrawTimer(&work->aniBarrier.config);
    AddExDrawRequest(&work->aniBarrier, &work->aniBarrier.config);

    RunCurrentExTaskUnknownEvent();
}

void CreateExSonicBarrierEffect(EX_ACTION_NN_WORK *parent)
{
    if (disableExSonicBarrierEffectSpawning)
        return;

    Task *task = ExTaskCreate(ExSonicBarrierEffect_Main_Init, ExSonicBarrierEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exEffectBarrierTask);

    disableExSonicBarrierEffectSpawning = TRUE;

    exEffectBarrierTask *work = ExTaskGetWork(task, exEffectBarrierTask);
    TaskInitWork8(work);

    work->parent     = parent;
    work->parentTask = GetCurrentTask();
    work->power      = work->parent->hitChecker.power;

    SetExTaskUnknownEvent(task, ExSonicBarrierEffect_TaskUnknown);
    SetExTaskDelayEvent(task, ExSonicBarrierEffect_DelayCallback);
}

BOOL LoadExSonicBarrierChargingEffectAssets(EX_ACTION_NN_WORK *work)
{
    exSonicBarrierChargingEffectLastSpawnedWorker = work;

    if (exSonicBarrierChargingEffectModelFileSize != 0 && exSonicBarrierChargingEffectTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exSonicBarrierChargingEffectModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exSonicBarrierChargingEffectTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exSonicBarrierChargingEffectModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (exSonicBarrierChargingEffectInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_SONSA_NSBMD, &exSonicBarrierChargingEffectModelResource,
                                      &exSonicBarrierChargingEffectModelFileSize, TRUE, FALSE);

        exSonicBarrierChargingEffectAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SONSA_NSBCA);
        exSonicBarrierChargingEffectAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SONSA_NSBVA);
        Asset3DSetup__Create(exSonicBarrierChargingEffectModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exSonicBarrierChargingEffectModelResource, 0, FALSE, FALSE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, exSonicBarrierChargingEffectAnimResource[0], 0, NULL);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_VIS_ANIM, exSonicBarrierChargingEffectAnimResource[1], 0, NULL);

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

    work->hitChecker.type            = 0;
    work->hitChecker.field_5.value_1 = TRUE;
    work->hitChecker.box.size.x      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position    = &work->model.translation;

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    exSonicBarrierChargingEffectInstanceCount++;

    return TRUE;
}

void ReleaseExSonicBarrierChargingEffectAssets(EX_ACTION_NN_WORK *work)
{
    if (exSonicBarrierChargingEffectInstanceCount <= 1)
    {
        if (exSonicBarrierChargingEffectModelResource != NULL)
            NNS_G3dResDefaultRelease(exSonicBarrierChargingEffectModelResource);

        if (exSonicBarrierChargingEffectAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(exSonicBarrierChargingEffectAnimResource[0]);

        if (exSonicBarrierChargingEffectAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(exSonicBarrierChargingEffectAnimResource[1]);

        if (exSonicBarrierChargingEffectModelResource != NULL)
            HeapFree(HEAP_USER, exSonicBarrierChargingEffectModelResource);
        exSonicBarrierChargingEffectModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    exSonicBarrierChargingEffectInstanceCount--;
}

void ExSonicBarrierChargingEffect_Main_Init(void)
{
    exExEffectSonicBarrierTaMeTask *work = ExTaskGetWorkCurrent(exExEffectSonicBarrierTaMeTask);

    exSonicBarrierChargingEffectTaskSingleton = GetCurrentTask();

    LoadExSonicBarrierChargingEffectAssets(&work->aniTaMe);
    SetExDrawRequestPriority(&work->aniTaMe.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->aniTaMe.config);

    work->scale     = FLOAT_TO_FX32(1.0);
    work->sndHandle = AllocSndHandle();

    PlayHandleStageSfx(work->sndHandle, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_BULLET);

    SetCurrentExTaskMainEvent(ExSonicBarrierChargingEffect_Main_Active);
}

void ExSonicBarrierChargingEffect_TaskUnknown(void)
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

    exSonicBarrierChargingEffectTaskSingleton = NULL;
}

void ExSonicBarrierChargingEffect_Main_Active(void)
{
    exExEffectSonicBarrierTaMeTask *work = ExTaskGetWorkCurrent(exExEffectSonicBarrierTaMeTask);

    AnimateExDrawRequestModel(&work->aniTaMe);

    if (GetExPlayerWorker()->barrierChargeTimer != 0)
    {
        float maxScale;
        MULTIPLY_FLOAT_FX(maxScale, exSonicBarrierChargingEffectConfig[2].scale.x)

        if (work->scale >= (fx32)maxScale)
        {
            float scaleF;
            MULTIPLY_FLOAT_FX(scaleF, exSonicBarrierChargingEffectConfig[2].scale.x)
            work->scale = scaleF;
        }
        else
        {
            float scaleF;
            MULTIPLY_FLOAT_FX(scaleF, (exSonicBarrierChargingEffectConfig[2].scale.x - exSonicBarrierChargingEffectConfig[0].scale.x) / 120.0f)
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

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExSonicBarrierChargingEffect(EX_ACTION_NN_WORK *parent)
{
    Task *task = ExTaskCreate(ExSonicBarrierChargingEffect_Main_Init, ExSonicBarrierChargingEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(5), 0,
                              EXTASK_TYPE_REGULAR, exExEffectSonicBarrierTaMeTask);

    exExEffectSonicBarrierTaMeTask *work = ExTaskGetWork(task, exExEffectSonicBarrierTaMeTask);
    TaskInitWork8(work);

    work->parent     = parent;
    work->parentTask = GetCurrentTask();

    SetExTaskUnknownEvent(task, ExSonicBarrierChargingEffect_TaskUnknown);

    return TRUE;
}