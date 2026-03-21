#include <ex/effects/exSonicDashEffect.h>
#include <ex/system/exUtils.h>
#include <ex/system/exSystem.h>
#include <game/file/binaryBundle.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

static s16 sRegularSonicInstanceCount;
static s16 sSuperSonicInstanceCount;
static s16 sSonicDashEffectInstanceCount;
static s16 sSuperSonicSpriteInstanceCount;
static void *sSonicDashEffectTaskSingleton;
static u32 sSonicDashEffectTextureFileSize;
static u32 sSonicDashEffectModelFileSize;
static void *superSonicJointAniResource;
static void *sSonicDashEffectUnused;
static void *sSonicDashEffectModelResource;
static void *sSonicDashEffectLastSpawnedWorker;
static void *sRegularSonicLastSpawnedWorker;
static void *sSuperSonicSpriteResource;
static void *sRegularSonicJointAniResource;
static void *sRegularSonicModelResource;
static void *sSuperSonicLastSpawnedWorker;
static void *sSuperSonicModelResource;
static void *sSonicDashEffectAnimResource[3];
static u32 sSonicDashEffectAnimType[3];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(sSonicDashEffectUnused)

// --------------------
// FUNCTION DECLS
// --------------------

// ExSonicDashEffect
static BOOL LoadExSonicDashEffectAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExSonicDashEffectAssets(EX_ACTION_NN_WORK *work);
static void ExSonicDashEffect_Main_Init(void);
static void ExSonicDashEffect_OnCheckStageFinished(void);
static void ExSonicDashEffect_Destructor(void);
static void ExSonicDashEffect_Main_Active(void);

// --------------------
// FUNCTIONS
// --------------------

// ExSonic
void LoadExSuperSonicModel(EX_ACTION_NN_WORK *work)
{
    sSuperSonicLastSpawnedWorker = work;

    InitExDrawRequestModel(work);

    if (sSuperSonicInstanceCount == 0)
    {
        GetCompressedFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_SON_NSBMD, &sSuperSonicModelResource, TRUE, FALSE);

        superSonicJointAniResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_SON_NSBCA);
        NNS_G3dResDefaultSetup(sSuperSonicModelResource);

        void *oldMemory           = sSuperSonicModelResource;
        sSuperSonicModelResource = HeapAllocHead(HEAP_USER, Asset3DSetup_GetResourceSize(sSuperSonicModelResource));
        Asset3DSetup_CopyResourceData(oldMemory, sSuperSonicModelResource);
        HeapFree(HEAP_USER, oldMemory);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sSuperSonicModelResource, 0, TRUE, TRUE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, superSonicJointAniResource, 0, NULL);

    work->model.primaryAnimType     = B3D_ANIM_JOINT_ANIM;
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[B3D_ANIM_JOINT_ANIM];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & B3D_ANIM_FLAG_JOINT_ANIM) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.animID        = 0;
    work->model.translation.z = FLOAT_TO_FX32(60.0);

    work->model.scale.x = FLOAT_TO_FX32(1.0);
    work->model.scale.y = FLOAT_TO_FX32(1.0);
    work->model.scale.z = FLOAT_TO_FX32(1.0);

    work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z = FLOAT_DEG_TO_IDX(179.96);

    work->hitChecker.type            = EXHITCHECK_TYPE_ACTIVE_PLAYER;
    work->hitChecker.input.isSuperSonicPlayer = TRUE;
    work->hitChecker.box.size.x      = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.size.y      = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.size.z      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position    = &work->model.translation;

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    sSuperSonicInstanceCount++;
}

void SetExSuperSonicAnimation(EX_ACTION_NN_WORK *work, u16 anim)
{
    ExUtils_SetJointAnimation(work, sSuperSonicModelResource, NULL, superSonicJointAniResource, anim);
}

void ReleaseExSuperSonicModel(EX_ACTION_NN_WORK *work)
{
    if (sSuperSonicInstanceCount == 1)
    {
        if (sSuperSonicModelResource != NULL)
            NNS_G3dResDefaultRelease(sSuperSonicModelResource);

        if (sSuperSonicModelResource != NULL)
            HeapFree(HEAP_USER, sSuperSonicModelResource);
        else
            sSuperSonicModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (sSuperSonicInstanceCount > 0)
        sSuperSonicInstanceCount--;
}

EX_ACTION_NN_WORK *GetExSuperSonicWorker(void)
{
    return sSuperSonicLastSpawnedWorker;
}

void LoadExRegularSonicModel(EX_ACTION_NN_WORK *work)
{
    sRegularSonicLastSpawnedWorker = work;

    InitExDrawRequestModel(work);

    if (sRegularSonicInstanceCount == 0)
    {
        GetCompressedFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_NSON_NSBMD, &sRegularSonicModelResource, TRUE, FALSE);

        sRegularSonicJointAniResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_NSON_NSBCA);
        CreateAsset3DSetup(sRegularSonicModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sRegularSonicModelResource, 0, TRUE, TRUE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, sRegularSonicJointAniResource, 0, NULL);

    work->model.primaryAnimType     = B3D_ANIM_JOINT_ANIM;
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[B3D_ANIM_JOINT_ANIM];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & B3D_ANIM_FLAG_JOINT_ANIM) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.animID        = 0;
    work->model.translation.z = FLOAT_TO_FX32(60.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z       = FLOAT_DEG_TO_IDX(179.96);

    work->hitChecker.type             = EXHITCHECK_TYPE_ACTIVE_PLAYER;
    work->hitChecker.input.isSonicPlayer = TRUE;
    work->hitChecker.box.size.x       = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y       = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z       = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position     = &work->model.translation;

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    sRegularSonicInstanceCount++;
}

void SetExRegularSonicAnimation(EX_ACTION_NN_WORK *work, u16 anim)
{
    ExUtils_SetJointAnimation(work, sRegularSonicModelResource, NULL, sRegularSonicJointAniResource, anim);
}

void ReleaseExRegularSonicModel(EX_ACTION_NN_WORK *work)
{
    if (sRegularSonicInstanceCount == 1)
    {
        if (sRegularSonicModelResource != NULL)
            NNS_G3dResDefaultRelease(sRegularSonicModelResource);

        if (sRegularSonicModelResource != NULL)
            HeapFree(HEAP_USER, sRegularSonicModelResource);
        else
            sRegularSonicModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (sRegularSonicInstanceCount > 0)
        sRegularSonicInstanceCount--;
}

// ExSonicDashEffect
BOOL LoadExSonicDashEffectAssets(EX_ACTION_NN_WORK *work)
{
    sSonicDashEffectLastSpawnedWorker = work;

    if (sSonicDashEffectModelFileSize != 0 && sSonicDashEffectTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < sSonicDashEffectModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < sSonicDashEffectTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < sSonicDashEffectModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (sSonicDashEffectInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_SDASH_NSBMD, &sSonicDashEffectModelResource, &sSonicDashEffectModelFileSize, TRUE,
                                      FALSE);

        sSonicDashEffectAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SDASH_NSBCA);
        sSonicDashEffectAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        sSonicDashEffectAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SDASH_NSBMA);
        sSonicDashEffectAnimType[1]     = B3D_ANIM_MAT_ANIM;

        sSonicDashEffectAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SDASH_NSBVA);
        sSonicDashEffectAnimType[2]     = B3D_ANIM_VIS_ANIM;

        CreateAsset3DSetup(sSonicDashEffectModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sSonicDashEffectModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, sSonicDashEffectAnimType[i], sSonicDashEffectAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = sSonicDashEffectAnimType[1];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[sSonicDashEffectAnimType[1]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(60.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);

    if (GetExPlayerWorker()->playerFlags.btnLeft == TRUE || GetExPlayerWorker()->playerFlags.btnRight == TRUE || GetExPlayerWorker()->playerFlags.btnDown == TRUE
        || GetExPlayerWorker()->playerFlags.btnUp == TRUE)
    {
        if (GetExSystemStatus()->state == EXSYSTASK_STATE_STAGE_FINISHED || GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE2_STARTED
            || GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE3_STARTED)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
        }
        else if (!GetExPlayerWorker()->playerFlags.btnLeft && !GetExPlayerWorker()->playerFlags.btnRight && !GetExPlayerWorker()->playerFlags.btnDown
                 && GetExPlayerWorker()->playerFlags.btnUp == TRUE)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
        }
        else if (!GetExPlayerWorker()->playerFlags.btnLeft && GetExPlayerWorker()->playerFlags.btnRight == TRUE && !GetExPlayerWorker()->playerFlags.btnDown
                 && GetExPlayerWorker()->playerFlags.btnUp == TRUE)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
            work->model.angle.y = FLOAT_DEG_TO_IDX(44.99);
        }
        else if (!GetExPlayerWorker()->playerFlags.btnLeft && GetExPlayerWorker()->playerFlags.btnRight == TRUE && !GetExPlayerWorker()->playerFlags.btnDown
                 && !GetExPlayerWorker()->playerFlags.btnUp)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
            work->model.angle.y = FLOAT_DEG_TO_IDX(89.98);
        }
        else if (!GetExPlayerWorker()->playerFlags.btnLeft && GetExPlayerWorker()->playerFlags.btnRight == TRUE && GetExPlayerWorker()->playerFlags.btnDown == TRUE
                 && !GetExPlayerWorker()->playerFlags.btnUp)

        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
            work->model.angle.y = FLOAT_DEG_TO_IDX(134.97);
        }
        else if (!GetExPlayerWorker()->playerFlags.btnLeft && !GetExPlayerWorker()->playerFlags.btnRight && GetExPlayerWorker()->playerFlags.btnDown == TRUE
                 && !GetExPlayerWorker()->playerFlags.btnUp)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
            work->model.angle.y = FLOAT_DEG_TO_IDX(179.96);
        }
        else if (GetExPlayerWorker()->playerFlags.btnLeft == TRUE && !GetExPlayerWorker()->playerFlags.btnRight && GetExPlayerWorker()->playerFlags.btnDown == TRUE
                 && !GetExPlayerWorker()->playerFlags.btnUp)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
            work->model.angle.y = -FLOAT_DEG_TO_IDX(135.055);
        }
        else if (GetExPlayerWorker()->playerFlags.btnLeft == TRUE && !GetExPlayerWorker()->playerFlags.btnRight && !GetExPlayerWorker()->playerFlags.btnDown
                 && !GetExPlayerWorker()->playerFlags.btnUp)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
            work->model.angle.y = -FLOAT_DEG_TO_IDX(90.066);
        }
        else if (GetExPlayerWorker()->playerFlags.btnLeft == TRUE && !GetExPlayerWorker()->playerFlags.btnRight && !GetExPlayerWorker()->playerFlags.btnDown
                 && GetExPlayerWorker()->playerFlags.btnUp == TRUE)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
            work->model.angle.y = -FLOAT_DEG_TO_IDX(45.077);
        }
    }
    else
    {
        work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
    }

    work->hitChecker.type            = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isSpriteOrModelVFX = TRUE;
    work->hitChecker.box.size.x      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position    = &work->model.translation;

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    sSonicDashEffectInstanceCount++;

    return TRUE;
}

void ReleaseExSonicDashEffectAssets(EX_ACTION_NN_WORK *work)
{
    if (sSonicDashEffectInstanceCount <= 1)
    {
        if (sSonicDashEffectModelResource != NULL)
            NNS_G3dResDefaultRelease(sSonicDashEffectModelResource);

        if (sSonicDashEffectAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(sSonicDashEffectAnimResource[0]);

        if (sSonicDashEffectAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(sSonicDashEffectAnimResource[1]);

        if (sSonicDashEffectAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(sSonicDashEffectAnimResource[2]);

        if (sSonicDashEffectModelResource != NULL)
            HeapFree(HEAP_USER, sSonicDashEffectModelResource);
        sSonicDashEffectModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (sSonicDashEffectInstanceCount > 0)
        sSonicDashEffectInstanceCount--;
}

void ExSonicDashEffect_Main_Init(void)
{
    exSonDushEffectTask *work = ExTaskGetWorkCurrent(exSonDushEffectTask);

    sSonicDashEffectTaskSingleton = GetCurrentTask();

    LoadExSonicDashEffectAssets(&work->aniDash);
    SetExDrawRequestPriority(&work->aniDash.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniDash.config);

    SetCurrentExTaskMainEvent(ExSonicDashEffect_Main_Active);
}

void ExSonicDashEffect_OnCheckStageFinished(void)
{
    exSonDushEffectTask *work = ExTaskGetWorkCurrent(exSonDushEffectTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExSonicDashEffect_Destructor(void)
{
    exSonDushEffectTask *work = ExTaskGetWorkCurrent(exSonDushEffectTask);

    ReleaseExSonicDashEffectAssets(&work->aniDash);

    sSonicDashEffectTaskSingleton = NULL;
}

void ExSonicDashEffect_Main_Active(void)
{
    exSonDushEffectTask *work = ExTaskGetWorkCurrent(exSonDushEffectTask);

    AnimateExDrawRequestModel(&work->aniDash);

    work->aniDash.model.translation.x = work->parent->model.translation.x;
    work->aniDash.model.translation.y = work->parent->model.translation.y;
    work->aniDash.model.translation.z = work->parent->model.translation.z;

    if (IsExDrawRequestModelAnimFinished(&work->aniDash))
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->aniDash, &work->aniDash.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

BOOL CreateExSonicDashEffect(EX_ACTION_NN_WORK *parent)
{
    if (sSonicDashEffectTaskSingleton != NULL)
        DestroyExSonicDashEffect();

    Task *task = ExTaskCreate(ExSonicDashEffect_Main_Init, ExSonicDashEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exSonDushEffectTask);

    exSonDushEffectTask *work = ExTaskGetWork(task, exSonDushEffectTask);
    TaskInitWork8(work);

    work->parent = parent;

    SetExTaskOnCheckStageFinishedEvent(task, ExSonicDashEffect_OnCheckStageFinished);

    return TRUE;
}

void DestroyExSonicDashEffect(void)
{
    if (sSonicDashEffectTaskSingleton != NULL)
        DestroyExTask(sSonicDashEffectTaskSingleton);
}

// ExSonicSprite
void LoadExSuperSonicSprite(EX_ACTION_BAC3D_WORK *work)
{
    InitExDrawRequestSprite3D(work);

    if (sSuperSonicSpriteInstanceCount == 0)
        sSuperSonicSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(sSuperSonicSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(sSuperSonicSpriteResource, 1), FALSE);
    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, sSuperSonicSpriteResource, EX_ACTCOM_ANI_SUPERSONIC, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels,
                           vramPalette);
    work->sprite.animator.polygonAttr.xluDepthUpdate = TRUE;

    work->hitChecker.type            = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isPlayerSprite = TRUE;

    work->sprite.translation.z         = FLOAT_TO_FX32(70.0);
    work->sprite.scale.x               = FLOAT_TO_FX32(0.2);
    work->sprite.scale.y               = FLOAT_TO_FX32(0.2);
    work->sprite.scale.z               = FLOAT_TO_FX32(0.2);
    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    work->hitChecker.box.size.x   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position = &work->sprite.translation;

    sSuperSonicSpriteInstanceCount++;
}

void ReleaseExSuperSonicSprite(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    sSuperSonicSpriteInstanceCount--;
}