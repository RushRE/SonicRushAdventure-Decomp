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

static s16 sBlazeFireballChargingEffectInstanceCount;
static s16 sBlazeFireballEffectInstanceCount;
static s16 sBlazeFireballShotEffectInstanceCount;

static void *sBlazeFireballUnused;
static void *sBlazeFireballChargingEffectTaskSingleton;
static void *sBlazeFireballEffectSpriteResource;
static u32 sBlazeFireballShotEffectTextureFileSize;
static u32 sBlazeFireballShotEffectModelFileSize;
static void *sBlazeFireballShotEffectTaskSingleton;
static void *sBlazeFireballShotEffectLastSpawnedWorker;
static void *sBlazeFireballShotEffectModelResource;
static void *sBlazeFireballEffectTaskSingleton;
static u32 sBlazeFireballChargingEffectTextureFileSize;
static u32 sBlazeFireballChargingEffectModelFileSize;
static void *sBlazeFireballShotUnused;
static void *ExBlazeFireballChargingEffectLastSpawnedWorker;
static void *sBlazeFireballChargingEffectModelResource;
static void *sBlazeFireballChargingEffectAnimResource[2];
static void *sBlazeFireballShotEffectAnimResource[4];
static u32 sBlazeFireballShotEffectAnimType[4];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(sBlazeFireballUnused)
FORCE_INCLUDE_VARIABLE_BSS(sBlazeFireballShotUnused)

static struct ExBlazeFireballEffectConfig sBlazeFireballChargingEffectConfig[] = {
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

    if (sBlazeFireballEffectInstanceCount == 0)
        sBlazeFireballEffectSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(sBlazeFireballEffectSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(sBlazeFireballEffectSpriteResource, 1), FALSE);

    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, sBlazeFireballEffectSpriteResource, anim, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels, vramPalette);
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

    sBlazeFireballEffectInstanceCount++;
}

void ReleaseExBlazeFireballEffectAssets(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    sBlazeFireballEffectInstanceCount--;
}

BOOL LoadExBlazeFireballChargingEffectAssets(EX_ACTION_NN_WORK *work)
{
    ExBlazeFireballChargingEffectLastSpawnedWorker = work;

    if (sBlazeFireballChargingEffectModelFileSize != 0 && sBlazeFireballChargingEffectTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < sBlazeFireballChargingEffectModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < sBlazeFireballChargingEffectTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < sBlazeFireballChargingEffectModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (sBlazeFireballChargingEffectInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_BLZFA_NSBMD, &sBlazeFireballChargingEffectModelResource,
                                      &sBlazeFireballChargingEffectModelFileSize, TRUE, FALSE);

        sBlazeFireballChargingEffectAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BLZFA_NSBCA);
        sBlazeFireballChargingEffectAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BLZFA_NSBVA);

        CreateAsset3DSetup(sBlazeFireballChargingEffectModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sBlazeFireballChargingEffectModelResource, 0, FALSE, FALSE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, sBlazeFireballChargingEffectAnimResource[0], 0, NULL);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_VIS_ANIM, sBlazeFireballChargingEffectAnimResource[1], 0, NULL);

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

    sBlazeFireballChargingEffectInstanceCount++;

    return TRUE;
}

void ReleaseExBlazeFireballChargingEffectAssets(EX_ACTION_NN_WORK *work)
{
    if (sBlazeFireballChargingEffectInstanceCount <= 1)
    {
        if (sBlazeFireballChargingEffectModelResource != NULL)
            NNS_G3dResDefaultRelease(sBlazeFireballChargingEffectModelResource);

        if (sBlazeFireballChargingEffectAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(sBlazeFireballChargingEffectAnimResource[0]);

        if (sBlazeFireballChargingEffectAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(sBlazeFireballChargingEffectAnimResource[1]);

        if (sBlazeFireballChargingEffectModelResource != NULL)
            HeapFree(HEAP_USER, sBlazeFireballChargingEffectModelResource);
        sBlazeFireballChargingEffectModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    sBlazeFireballChargingEffectInstanceCount--;
}

BOOL LoadExBlazeFireballShotEffectAssets(EX_ACTION_NN_WORK *work)
{
    sBlazeFireballShotEffectLastSpawnedWorker = work;

    if (sBlazeFireballShotEffectModelFileSize != 0 && sBlazeFireballShotEffectTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < sBlazeFireballShotEffectModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < sBlazeFireballShotEffectTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < sBlazeFireballShotEffectModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (sBlazeFireballShotEffectInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_BLZFB_NSBMD, &sBlazeFireballShotEffectModelResource,
                                      &sBlazeFireballShotEffectModelFileSize, TRUE, FALSE);

        sBlazeFireballShotEffectAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BLZFB_NSBVA);
        sBlazeFireballShotEffectAnimType[0]     = B3D_ANIM_VIS_ANIM;

        sBlazeFireballShotEffectAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BLZFB_NSBCA);
        sBlazeFireballShotEffectAnimType[1]     = B3D_ANIM_JOINT_ANIM;

        sBlazeFireballShotEffectAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BLZFB_NSBMA);
        sBlazeFireballShotEffectAnimType[2]     = B3D_ANIM_MAT_ANIM;

        sBlazeFireballShotEffectAnimResource[3] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BLZFB_NSBTP);
        sBlazeFireballShotEffectAnimType[3]     = B3D_ANIM_PAT_ANIM;

        CreateAsset3DSetup(sBlazeFireballShotEffectModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sBlazeFireballShotEffectModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, sBlazeFireballShotEffectAnimType[i], sBlazeFireballShotEffectAnimResource[i], 0, NULL);
    }

    AnimatorMDL__SetAnimation(&work->model.animator, sBlazeFireballShotEffectAnimType[3], sBlazeFireballShotEffectAnimResource[3], 0,
                              NNS_G3dGetTex(sBlazeFireballShotEffectModelResource));

    work->model.primaryAnimType     = sBlazeFireballShotEffectAnimType[1];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[sBlazeFireballShotEffectAnimType[1]];

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

    sBlazeFireballShotEffectInstanceCount++;

    return TRUE;
}

void ReleaseExBlazeFireballShotEffectAssets(EX_ACTION_NN_WORK *work)
{
    if (sBlazeFireballShotEffectInstanceCount <= 1)
    {
        if (sBlazeFireballShotEffectModelResource != NULL)
            NNS_G3dResDefaultRelease(sBlazeFireballShotEffectModelResource);

        if (sBlazeFireballShotEffectAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(sBlazeFireballShotEffectAnimResource[0]);

        if (sBlazeFireballShotEffectAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(sBlazeFireballShotEffectAnimResource[1]);

        if (sBlazeFireballShotEffectAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(sBlazeFireballShotEffectAnimResource[2]);

        if (sBlazeFireballShotEffectAnimResource[3] != NULL)
            NNS_G3dResDefaultRelease(sBlazeFireballShotEffectAnimResource[3]);

        if (sBlazeFireballShotEffectModelResource != NULL)
            HeapFree(HEAP_USER, sBlazeFireballShotEffectModelResource);
        sBlazeFireballShotEffectModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    sBlazeFireballShotEffectInstanceCount--;
}

void ExBlazeFireballEffect_Main_Init(void)
{
    exEffectBlzFireTask *work = ExTaskGetWorkCurrent(exEffectBlzFireTask);

    sBlazeFireballEffectTaskSingleton = GetCurrentTask();

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

    sBlazeFireballEffectTaskSingleton = NULL;
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
            MULTIPLY_FLOAT_FX(scale, sBlazeFireballChargingEffectConfig[0].scale.x)
            work->scale = scale;

            float sizeX;
            MULTIPLY_FLOAT_FX(sizeX, sBlazeFireballChargingEffectConfig[0].size.x)
            work->aniFire.hitChecker.box.size.x = sizeX;

            float sizeY;
            MULTIPLY_FLOAT_FX(sizeY, sBlazeFireballChargingEffectConfig[0].size.y)
            work->aniFire.hitChecker.box.size.y = sizeY;
        }

        if (work->parent->hitChecker.power >= EXPLAYER_FIREBALL_REGULAR_POWER_NORMAL)
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, sBlazeFireballChargingEffectConfig[1].scale.x)
            work->scale = scale;

            float sizeX;
            MULTIPLY_FLOAT_FX(sizeX, sBlazeFireballChargingEffectConfig[1].size.x)
            work->aniFire.hitChecker.box.size.x = sizeX;

            float sizeY;
            MULTIPLY_FLOAT_FX(sizeY, sBlazeFireballChargingEffectConfig[1].size.y)
            work->aniFire.hitChecker.box.size.y = sizeY;
        }

        if (work->parent->hitChecker.power >= EXPLAYER_FIREBALL_CHARGED_POWER_NORMAL)
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, sBlazeFireballChargingEffectConfig[2].scale.x)
            work->scale = scale;

            float sizeX;
            MULTIPLY_FLOAT_FX(sizeX, sBlazeFireballChargingEffectConfig[2].size.x)
            work->aniFire.hitChecker.box.size.x = sizeX;

            float sizeY;
            MULTIPLY_FLOAT_FX(sizeY, sBlazeFireballChargingEffectConfig[2].size.y)
            work->aniFire.hitChecker.box.size.y = sizeY;
        }
    }
    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
    {
        if (work->parent->hitChecker.power < EXPLAYER_FIREBALL_REGULAR_POWER_EASY)
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, sBlazeFireballChargingEffectConfig[0].scale.x)
            work->scale = scale;

            float sizeX;
            MULTIPLY_FLOAT_FX(sizeX, sBlazeFireballChargingEffectConfig[0].size.x)
            work->aniFire.hitChecker.box.size.x = sizeX;

            float sizeY;
            MULTIPLY_FLOAT_FX(sizeY, sBlazeFireballChargingEffectConfig[0].size.y)
            work->aniFire.hitChecker.box.size.y = sizeY;
        }

        if (work->parent->hitChecker.power >= EXPLAYER_FIREBALL_REGULAR_POWER_EASY)
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, sBlazeFireballChargingEffectConfig[1].scale.x)
            work->scale = scale;

            float sizeX;
            MULTIPLY_FLOAT_FX(sizeX, sBlazeFireballChargingEffectConfig[1].size.x)
            work->aniFire.hitChecker.box.size.x = sizeX;

            float sizeY;
            MULTIPLY_FLOAT_FX(sizeY, sBlazeFireballChargingEffectConfig[1].size.y)
            work->aniFire.hitChecker.box.size.y = sizeY;
        }

        if (work->parent->hitChecker.power >= EXPLAYER_FIREBALL_CHARGED_POWER_EASY)
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, sBlazeFireballChargingEffectConfig[2].scale.x)
            work->scale = scale;

            float sizeX;
            MULTIPLY_FLOAT_FX(sizeX, sBlazeFireballChargingEffectConfig[2].size.x)
            work->aniFire.hitChecker.box.size.x = sizeX;

            float sizeY;
            MULTIPLY_FLOAT_FX(sizeY, sBlazeFireballChargingEffectConfig[2].size.y)
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

    sBlazeFireballChargingEffectTaskSingleton = GetCurrentTask();

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

    sBlazeFireballChargingEffectTaskSingleton = NULL;
}

void ExBlazeFireballChargingEffect_Main_Active(void)
{
    exExEffectBlzFireTaMeTask *work = ExTaskGetWorkCurrent(exExEffectBlzFireTaMeTask);

    AnimateExDrawRequestModel(&work->aniTaMe);

    if (work->parent->model.animID == ex_blz_fb_01 || work->parent->model.animID == ex_blz_fb_02)
    {
        float maxScale;
        MULTIPLY_FLOAT_FX(maxScale, sBlazeFireballChargingEffectConfig[5].scale.x)

        if (work->scale >= (fx32)maxScale)
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, sBlazeFireballChargingEffectConfig[5].scale.x)
            work->scale = scale;
        }
        else
        {
            float scale;
            MULTIPLY_FLOAT_FX(scale, (sBlazeFireballChargingEffectConfig[5].scale.x - sBlazeFireballChargingEffectConfig[3].scale.x) / 120.0f)
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

    sBlazeFireballShotEffectTaskSingleton = GetCurrentTask();

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

    sBlazeFireballShotEffectTaskSingleton = NULL;
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