#include <ex/effects/exBlazeFireball.h>
#include <ex/player/exPlayer.h>
#include <ex/system/exSystem.h>
#include <ex/system/exStage.h>
#include <ex/system/exMath.h>
#include <game/audio/audioSystem.h>
#include <game/file/binaryBundle.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// STRUCTS
// --------------------

struct ExBlazeFireballEffectConfig
{
    VecFloat scale;
    VecFloat size;
};

// --------------------
// VARIABLES
// --------------------

static s16 exBlazeFireballChargingEffectInstanceCount;
static s16 exBlazeFireballEffectInstanceCount;
static s16 exBlazeFireballShotEffectInstanceCount;

static void *exEffectBlazeFireballUnused;
static void *exBlazeFireballChargingEffectTaskSingleton;
static void *exBlazeFireballEffectSpriteResource;
static u32 exBlazeFireballShotEffectTextureFileSize;
static u32 exBlazeFireballShotEffectModelFileSize;
static void *exBlazeFireballShotEffectTaskSingleton;
static void *exBlazeFireballShotEffectLastSpawnedWorker;
static void *exBlazeFireballShotEffectModelResource;
static void *exBlazeFireballEffectTaskSingleton;
static u32 exBlazeFireballChargingEffectTextureFileSize;
static u32 exBlazeFireballChargingEffectModelFileSize;
static void *exEffectBlazeFireballShotUnused;
static void *ExBlazeFireballChargingEffectLastSpawnedWorker;
static void *exBlazeFireballChargingEffectModelResource;
static void *exBlazeFireballChargingEffectAnimResource[2];
static void *exBlazeFireballShotEffectAnimResource[4];
static u32 exBlazeFireballShotEffectAnimType[4];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(exEffectBlazeFireballUnused)
FORCE_INCLUDE_VARIABLE_BSS(exEffectBlazeFireballShotUnused)

static struct ExBlazeFireballEffectConfig exBlazeFireballChargingEffectConfig[] = {
    [0] = { .scale = { 0.1f, 0.1f, 0.1f }, .size = { 1.5f, 1.5f, 0.0f } }, [1] = { .scale = { 0.2f, 0.2f, 0.2f }, .size = { 2.0f, 2.0f, 0.0f } },
    [2] = { .scale = { 0.3f, 0.3f, 0.3f }, .size = { 3.5f, 3.5f, 0.0f } }, [3] = { .scale = { 1.0f, 1.0f, 1.0f }, .size = { 0.0f, 0.0f, 0.0f } },
    [4] = { .scale = { 1.5f, 1.5f, 1.5f }, .size = { 0.0f, 0.0f, 0.0f } }, [5] = { .scale = { 2.5f, 2.5f, 2.5f }, .size = { 0.0f, 0.0f, 0.0f } },
};

// --------------------
// FUNCTION DECLS
// --------------------

// ExBlazeFireballEffect Helpers
static void LoadExBlazeFireballEffectAssets(EX_ACTION_BAC3D_WORK *work, u16 anim);
static void ReleaseExBlazeFireballEffectAssets(EX_ACTION_BAC3D_WORK *work);
static BOOL LoadExBlazeFireballChargingEffectAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBlazeFireballChargingEffectAssets(EX_ACTION_NN_WORK *work);
static BOOL LoadExBlazeFireballShotEffectAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBlazeFireballShotEffectAssets(EX_ACTION_NN_WORK *work);

// ExBlazeFireballEffect
static void ExBlazeFireballEffect_Main_Init(void);
static void ExBlazeFireballEffect_OnCheckStageFinished(void);
static void ExBlazeFireballEffect_Destructor(void);
static void ExBlazeFireballEffect_Main_Charging(void);
static void ExBlazeFireballEffect_Action_FireShot(void);
static void ExBlazeFireballEffect_Main_Fired(void);

// ExBlazeFireballChargingEffect
static void ExBlazeFireballChargingEffect_Main_Init(void);
static void ExBlazeFireballChargingEffect_OnCheckStageFinished(void);
static void ExBlazeFireballChargingEffect_Destructor(void);
static void ExBlazeFireballChargingEffect_Main_Active(void);

// ExBlazeFireballShotEffect
static void ExBlazeFireballShotEffect_Main_Init(void);
static void ExBlazeFireballShotEffect_OnCheckStageFinished(void);
static void ExBlazeFireballShotEffect_Destructor(void);
static void ExBlazeFireballShotEffect_Main_Active(void);

// --------------------
// FUNCTIONS
// --------------------

void LoadExBlazeFireballEffectAssets(EX_ACTION_BAC3D_WORK *work, u16 anim)
{
    InitExDrawRequestSprite3D(work);

    if (exBlazeFireballEffectInstanceCount == 0)
        exBlazeFireballEffectSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(exBlazeFireballEffectSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(exBlazeFireballEffectSpriteResource, 1), FALSE);

    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, exBlazeFireballEffectSpriteResource, anim, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels, vramPalette);
    work->sprite.animator.polygonAttr.xluDepthUpdate = TRUE;

    work->hitChecker.type                        = EXHITCHECK_TYPE_ACTIVE_PLAYER;
    work->hitChecker.input.isBlazeFireballEffect = TRUE;

    work->sprite.translation.z = FLOAT_TO_FX32(70.0);

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_BOTH;

    work->sprite.scale.x = FLOAT_TO_FX32(0.001);
    work->sprite.scale.y = FLOAT_TO_FX32(0.001);
    work->sprite.angle.z = FLOAT_DEG_TO_IDX(179.9561);

    work->hitChecker.box.size.x   = FLOAT_TO_FX32(0.001);
    work->hitChecker.box.size.y   = FLOAT_TO_FX32(0.001);
    work->hitChecker.box.size.z   = FLOAT_TO_FX32(0.001);
    work->hitChecker.box.position = &work->sprite.translation;

    exBlazeFireballEffectInstanceCount++;
}

void ReleaseExBlazeFireballEffectAssets(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    exBlazeFireballEffectInstanceCount--;
}

BOOL LoadExBlazeFireballChargingEffectAssets(EX_ACTION_NN_WORK *work)
{
    ExBlazeFireballChargingEffectLastSpawnedWorker = work;

    if (exBlazeFireballChargingEffectModelFileSize != 0 && exBlazeFireballChargingEffectTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exBlazeFireballChargingEffectModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exBlazeFireballChargingEffectTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exBlazeFireballChargingEffectModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (exBlazeFireballChargingEffectInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_BLZFA_NSBMD, &exBlazeFireballChargingEffectModelResource,
                                      &exBlazeFireballChargingEffectModelFileSize, TRUE, FALSE);

        exBlazeFireballChargingEffectAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BLZFA_NSBCA);
        exBlazeFireballChargingEffectAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BLZFA_NSBVA);

        CreateAsset3DSetup(exBlazeFireballChargingEffectModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exBlazeFireballChargingEffectModelResource, 0, FALSE, FALSE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, exBlazeFireballChargingEffectAnimResource[0], 0, NULL);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_VIS_ANIM, exBlazeFireballChargingEffectAnimResource[1], 0, NULL);

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

    work->hitChecker.type                     = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isSpriteOrModelVFX = TRUE;
    work->hitChecker.box.size.x               = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y               = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z               = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position             = &work->model.translation;

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    exBlazeFireballChargingEffectInstanceCount++;

    return TRUE;
}

void ReleaseExBlazeFireballChargingEffectAssets(EX_ACTION_NN_WORK *work)
{
    if (exBlazeFireballChargingEffectInstanceCount <= 1)
    {
        if (exBlazeFireballChargingEffectModelResource != NULL)
            NNS_G3dResDefaultRelease(exBlazeFireballChargingEffectModelResource);

        if (exBlazeFireballChargingEffectAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(exBlazeFireballChargingEffectAnimResource[0]);

        if (exBlazeFireballChargingEffectAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(exBlazeFireballChargingEffectAnimResource[1]);

        if (exBlazeFireballChargingEffectModelResource != NULL)
            HeapFree(HEAP_USER, exBlazeFireballChargingEffectModelResource);
        exBlazeFireballChargingEffectModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    exBlazeFireballChargingEffectInstanceCount--;
}

BOOL LoadExBlazeFireballShotEffectAssets(EX_ACTION_NN_WORK *work)
{
    exBlazeFireballShotEffectLastSpawnedWorker = work;

    if (exBlazeFireballShotEffectModelFileSize != 0 && exBlazeFireballShotEffectTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exBlazeFireballShotEffectModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exBlazeFireballShotEffectTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exBlazeFireballShotEffectModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (exBlazeFireballShotEffectInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_BLZFB_NSBMD, &exBlazeFireballShotEffectModelResource,
                                      &exBlazeFireballShotEffectModelFileSize, TRUE, FALSE);

        exBlazeFireballShotEffectAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BLZFB_NSBVA);
        exBlazeFireballShotEffectAnimType[0]     = B3D_ANIM_VIS_ANIM;

        exBlazeFireballShotEffectAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BLZFB_NSBCA);
        exBlazeFireballShotEffectAnimType[1]     = B3D_ANIM_JOINT_ANIM;

        exBlazeFireballShotEffectAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BLZFB_NSBMA);
        exBlazeFireballShotEffectAnimType[2]     = B3D_ANIM_MAT_ANIM;

        exBlazeFireballShotEffectAnimResource[3] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BLZFB_NSBTP);
        exBlazeFireballShotEffectAnimType[3]     = B3D_ANIM_PAT_ANIM;

        CreateAsset3DSetup(exBlazeFireballShotEffectModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exBlazeFireballShotEffectModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, exBlazeFireballShotEffectAnimType[i], exBlazeFireballShotEffectAnimResource[i], 0, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, exBlazeFireballShotEffectAnimType[3], exBlazeFireballShotEffectAnimResource[3], 0,
                              NNS_G3dGetTex(exBlazeFireballShotEffectModelResource));

    work->model.primaryAnimType     = exBlazeFireballShotEffectAnimType[1];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[exBlazeFireballShotEffectAnimType[1]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(60.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z       = FLOAT_DEG_TO_IDX(179.9561);

    work->hitChecker.type                     = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isSpriteOrModelVFX = TRUE;
    work->hitChecker.box.size.x               = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y               = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z               = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position             = &work->model.translation;

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    exBlazeFireballShotEffectInstanceCount++;

    return TRUE;
}

void ReleaseExBlazeFireballShotEffectAssets(EX_ACTION_NN_WORK *work)
{
    if (exBlazeFireballShotEffectInstanceCount <= 1)
    {
        if (exBlazeFireballShotEffectModelResource != NULL)
            NNS_G3dResDefaultRelease(exBlazeFireballShotEffectModelResource);

        if (exBlazeFireballShotEffectAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(exBlazeFireballShotEffectAnimResource[0]);

        if (exBlazeFireballShotEffectAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(exBlazeFireballShotEffectAnimResource[1]);

        if (exBlazeFireballShotEffectAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(exBlazeFireballShotEffectAnimResource[2]);

        if (exBlazeFireballShotEffectAnimResource[3] != NULL)
            NNS_G3dResDefaultRelease(exBlazeFireballShotEffectAnimResource[3]);

        if (exBlazeFireballShotEffectModelResource != NULL)
            HeapFree(HEAP_USER, exBlazeFireballShotEffectModelResource);
        exBlazeFireballShotEffectModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    exBlazeFireballShotEffectInstanceCount--;
}

void ExBlazeFireballEffect_Main_Init(void)
{
    exEffectBlzFireTask *work = ExTaskGetWorkCurrent(exEffectBlzFireTask);

    exBlazeFireballEffectTaskSingleton = GetCurrentTask();

    LoadExBlazeFireballEffectAssets(&work->aniFire, EX_ACTCOM_ANI_BLAZE_FIRE);

    SetExDrawRequestPriority(&work->aniFire.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->aniFire.config);

    work->scale = FLOAT_TO_FX32(0.0);

    SetCurrentExTaskMainEvent(ExBlazeFireballEffect_Main_Charging);
    ExBlazeFireballEffect_Main_Charging();
}

void ExBlazeFireballEffect_OnCheckStageFinished(void)
{
    exEffectBlzFireTask *work = ExTaskGetWorkCurrent(exEffectBlzFireTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBlazeFireballEffect_Destructor(void)
{
    exEffectBlzFireTask *work = ExTaskGetWorkCurrent(exEffectBlzFireTask);

    ReleaseExBlazeFireballEffectAssets(&work->aniFire);

    exBlazeFireballEffectTaskSingleton = NULL;
}

void ExBlazeFireballEffect_Main_Charging(void)
{
    exEffectBlzFireTask *work = ExTaskGetWorkCurrent(exEffectBlzFireTask);

    s32 animID = work->parent->model.animID;
    if (animID == ex_blz_fb_04)
    {
        ExBlazeFireballEffect_Action_FireShot();
    }
    else
    {
        if (animID != ex_blz_fb_01 && animID != ex_blz_fb_02 && animID != ex_blz_fb_03)
        {
            DestroyCurrentExTask();
        }
        else
        {
            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

void ExBlazeFireballEffect_Action_FireShot(void)
{
    exEffectBlzFireTask *work = ExTaskGetWorkCurrent(exEffectBlzFireTask);

    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        if (work->parent->hitChecker.power < EXPLAYER_FIREBALL_REGULAR_POWER_NORMAL)
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, exBlazeFireballChargingEffectConfig[0].scale.x)
            work->scale = scale;

            float sizeX;
            MULTIPLY_FLOAT_FX(sizeX, exBlazeFireballChargingEffectConfig[0].size.x)
            work->aniFire.hitChecker.box.size.x = sizeX;

            float sizeY;
            MULTIPLY_FLOAT_FX(sizeY, exBlazeFireballChargingEffectConfig[0].size.y)
            work->aniFire.hitChecker.box.size.y = sizeY;
        }

        if (work->parent->hitChecker.power >= EXPLAYER_FIREBALL_REGULAR_POWER_NORMAL)
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, exBlazeFireballChargingEffectConfig[1].scale.x)
            work->scale = scale;

            float sizeX;
            MULTIPLY_FLOAT_FX(sizeX, exBlazeFireballChargingEffectConfig[1].size.x)
            work->aniFire.hitChecker.box.size.x = sizeX;

            float sizeY;
            MULTIPLY_FLOAT_FX(sizeY, exBlazeFireballChargingEffectConfig[1].size.y)
            work->aniFire.hitChecker.box.size.y = sizeY;
        }

        if (work->parent->hitChecker.power >= EXPLAYER_FIREBALL_CHARGED_POWER_NORMAL)
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, exBlazeFireballChargingEffectConfig[2].scale.x)
            work->scale = scale;

            float sizeX;
            MULTIPLY_FLOAT_FX(sizeX, exBlazeFireballChargingEffectConfig[2].size.x)
            work->aniFire.hitChecker.box.size.x = sizeX;

            float sizeY;
            MULTIPLY_FLOAT_FX(sizeY, exBlazeFireballChargingEffectConfig[2].size.y)
            work->aniFire.hitChecker.box.size.y = sizeY;
        }
    }
    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
    {
        if (work->parent->hitChecker.power < EXPLAYER_FIREBALL_REGULAR_POWER_EASY)
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, exBlazeFireballChargingEffectConfig[0].scale.x)
            work->scale = scale;

            float sizeX;
            MULTIPLY_FLOAT_FX(sizeX, exBlazeFireballChargingEffectConfig[0].size.x)
            work->aniFire.hitChecker.box.size.x = sizeX;

            float sizeY;
            MULTIPLY_FLOAT_FX(sizeY, exBlazeFireballChargingEffectConfig[0].size.y)
            work->aniFire.hitChecker.box.size.y = sizeY;
        }

        if (work->parent->hitChecker.power >= EXPLAYER_FIREBALL_REGULAR_POWER_EASY)
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, exBlazeFireballChargingEffectConfig[1].scale.x)
            work->scale = scale;

            float sizeX;
            MULTIPLY_FLOAT_FX(sizeX, exBlazeFireballChargingEffectConfig[1].size.x)
            work->aniFire.hitChecker.box.size.x = sizeX;

            float sizeY;
            MULTIPLY_FLOAT_FX(sizeY, exBlazeFireballChargingEffectConfig[1].size.y)
            work->aniFire.hitChecker.box.size.y = sizeY;
        }

        if (work->parent->hitChecker.power >= EXPLAYER_FIREBALL_CHARGED_POWER_EASY)
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, exBlazeFireballChargingEffectConfig[2].scale.x)
            work->scale = scale;

            float sizeX;
            MULTIPLY_FLOAT_FX(sizeX, exBlazeFireballChargingEffectConfig[2].size.x)
            work->aniFire.hitChecker.box.size.x = sizeX;

            float sizeY;
            MULTIPLY_FLOAT_FX(sizeY, exBlazeFireballChargingEffectConfig[2].size.y)
            work->aniFire.hitChecker.box.size.y = sizeY;
        }
    }

    work->aniFire.hitChecker.power = work->parent->hitChecker.power;
    work->parent->hitChecker.power = 0;

    work->aniFire.sprite.translation.x = work->parent->model.translation.x;
    work->aniFire.sprite.translation.y = work->parent->model.translation.y + FLOAT_TO_FX32(10.0);

    work->aniFire.sprite.scale.x = work->scale;
    work->aniFire.sprite.scale.y = work->scale;

    work->velocity.y = FLOAT_TO_FX32(2.0);

    SetCurrentExTaskMainEvent(ExBlazeFireballEffect_Main_Fired);
    ExBlazeFireballEffect_Main_Fired();
}

void ExBlazeFireballEffect_Main_Fired(void)
{
    exEffectBlzFireTask *work = ExTaskGetWorkCurrent(exEffectBlzFireTask);

    AnimateExDrawRequestSprite3D(&work->aniFire);

    work->aniFire.sprite.translation.y += work->velocity.y;

    if (work->aniFire.hitChecker.output.hasCollision)
    {
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_HIT);

        DestroyCurrentExTask();
    }
    else
    {
        if (work->aniFire.sprite.translation.x >= EX_STAGE_BOUNDARY_R || work->aniFire.sprite.translation.x <= EX_STAGE_BOUNDARY_L
            || work->aniFire.sprite.translation.y >= FLOAT_TO_FX32(150.0))
        {
            DestroyCurrentExTask();
        }
        else
        {
            AddExDrawRequest(&work->aniFire, &work->aniFire.config);
            exHitCheckTask_AddHitCheck(&work->aniFire.hitChecker);

            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

BOOL CreateExBlazeFireballEffect(EX_ACTION_NN_WORK *parent)
{
    Task *task = ExTaskCreate(ExBlazeFireballEffect_Main_Init, ExBlazeFireballEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exEffectBlzFireTask);

    exEffectBlzFireTask *work = ExTaskGetWork(task, exEffectBlzFireTask);
    TaskInitWork8(work);

    work->parent     = parent;
    work->parentTask = GetCurrentTask();

    SetExTaskOnCheckStageFinishedEvent(task, ExBlazeFireballEffect_OnCheckStageFinished);

    return TRUE;
}

void ExBlazeFireballChargingEffect_Main_Init(void)
{
    exExEffectBlzFireTaMeTask *work = ExTaskGetWorkCurrent(exExEffectBlzFireTaMeTask);

    exBlazeFireballChargingEffectTaskSingleton = GetCurrentTask();

    LoadExBlazeFireballChargingEffectAssets(&work->aniTaMe);

    SetExDrawRequestPriority(&work->aniTaMe.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->aniTaMe.config);

    work->scale = FLOAT_TO_FX32(1.0);

    work->handle = AllocSndHandle();

    PlayHandleStageSfx(work->handle, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_BULLET);

    SetCurrentExTaskMainEvent(ExBlazeFireballChargingEffect_Main_Active);
}

void ExBlazeFireballChargingEffect_OnCheckStageFinished(void)
{
    exExEffectBlzFireTaMeTask *work = ExTaskGetWorkCurrent(exExEffectBlzFireTaMeTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBlazeFireballChargingEffect_Destructor(void)
{
    exExEffectBlzFireTaMeTask *work = ExTaskGetWorkCurrent(exExEffectBlzFireTaMeTask);

    StopStageSfx(work->handle);
    FreeSndHandle(work->handle);

    ReleaseExBlazeFireballChargingEffectAssets(&work->aniTaMe);

    exBlazeFireballChargingEffectTaskSingleton = NULL;
}

void ExBlazeFireballChargingEffect_Main_Active(void)
{
    exExEffectBlzFireTaMeTask *work = ExTaskGetWorkCurrent(exExEffectBlzFireTaMeTask);

    AnimateExDrawRequestModel(&work->aniTaMe);

    if (work->parent->model.animID == ex_blz_fb_01 || work->parent->model.animID == ex_blz_fb_02)
    {
        float maxScale;
        MULTIPLY_FLOAT_FX(maxScale, exBlazeFireballChargingEffectConfig[5].scale.x)

        if (work->scale >= (fx32)maxScale)
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, exBlazeFireballChargingEffectConfig[5].scale.x)
            work->scale = scale;
        }
        else
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, (exBlazeFireballChargingEffectConfig[5].scale.x - exBlazeFireballChargingEffectConfig[3].scale.x) / 120.0f)
            work->scale += (fx32)scale;
        }
    }

    work->aniTaMe.model.translation.x = work->parent->model.translation.x;
    work->aniTaMe.model.translation.y = work->parent->model.translation.y;
    work->aniTaMe.model.translation.z = work->parent->model.translation.z;

    work->aniTaMe.model.scale.x = work->scale;
    work->aniTaMe.model.scale.y = work->scale;
    work->aniTaMe.model.scale.z = work->scale;

    s32 animID = work->parent->model.animID;
    if (animID != ex_blz_fb_01 && animID != ex_blz_fb_02 && animID != ex_blz_fb_03)
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->aniTaMe, &work->aniTaMe.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

BOOL CreateExBlazeFireballChargingEffect(EX_ACTION_NN_WORK *parent)
{
    Task *task = ExTaskCreate(ExBlazeFireballChargingEffect_Main_Init, ExBlazeFireballChargingEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(5), 0,
                              EXTASK_TYPE_REGULAR, exExEffectBlzFireTaMeTask);

    exExEffectBlzFireTaMeTask *work = ExTaskGetWork(task, exExEffectBlzFireTaMeTask);
    TaskInitWork8(work);

    work->parent     = parent;
    work->parentTask = GetCurrentTask();

    SetExTaskOnCheckStageFinishedEvent(task, ExBlazeFireballChargingEffect_OnCheckStageFinished);

    return TRUE;
}

void ExBlazeFireballShotEffect_Main_Init(void)
{
    exEffectBlzFireShotTask *work = ExTaskGetWorkCurrent(exEffectBlzFireShotTask);

    exBlazeFireballShotEffectTaskSingleton = GetCurrentTask();

    LoadExBlazeFireballShotEffectAssets(&work->aniShot);
    SetExDrawRequestPriority(&work->aniShot.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniShot.config);

    SetCurrentExTaskMainEvent(ExBlazeFireballShotEffect_Main_Active);
}

void ExBlazeFireballShotEffect_OnCheckStageFinished(void)
{
    exEffectBlzFireShotTask *work = ExTaskGetWorkCurrent(exEffectBlzFireShotTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBlazeFireballShotEffect_Destructor(void)
{
    exEffectBlzFireShotTask *work = ExTaskGetWorkCurrent(exEffectBlzFireShotTask);

    ReleaseExBlazeFireballShotEffectAssets(&work->aniShot);

    exBlazeFireballShotEffectTaskSingleton = NULL;
}

void ExBlazeFireballShotEffect_Main_Active(void)
{
    exEffectBlzFireShotTask *work = ExTaskGetWorkCurrent(exEffectBlzFireShotTask);

    AnimateExDrawRequestModel(&work->aniShot);

    work->aniShot.model.translation.x = work->parent->model.translation.x;
    work->aniShot.model.translation.y = work->parent->model.translation.y + FLOAT_TO_FX32(5.0);
    work->aniShot.model.translation.z = work->parent->model.translation.z;

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

BOOL CreateExBlazeFireballShotEffect(EX_ACTION_NN_WORK *parent)
{
    Task *task = ExTaskCreate(ExBlazeFireballShotEffect_Main_Init, ExBlazeFireballShotEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(5), 0,
                              EXTASK_TYPE_REGULAR, exEffectBlzFireShotTask);

    exEffectBlzFireShotTask *work = ExTaskGetWork(task, exEffectBlzFireShotTask);
    TaskInitWork8(work);

    work->parent     = parent;
    work->parentTask = GetCurrentTask();

    SetExTaskOnCheckStageFinishedEvent(task, ExBlazeFireballShotEffect_OnCheckStageFinished);

    return TRUE;
}