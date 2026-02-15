#include <ex/effects/exBlazeDashEffect.h>
#include <ex/system/exUtils.h>
#include <ex/system/exSystem.h>
#include <game/file/binaryBundle.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

static s16 exRegularBlazeInstanceCount;
static s16 exBurningBlazeInstanceCount;
static s16 exBlazeDashEffectInstanceCount;
static s16 exBurningBlazeSpriteInstanceCount;
static void *exBlazeDashEffectTaskSingleton;
static u32 exBlazeDashEffectTextureFileSize;
static u32 exBlazeDashEffectModelFileSize;
static void *exBurningBlazeJointAniResource;
static void *exBlazeDashEffectUnused;
static void *exBlazeDashEffectModelResource;
static void *exBlazeDashEffectLastSpawnedWorker;
static void *exRegularBlazeLastSpawnedWorker;
static void *exBurningBlazeSpriteResource;
static void *exRegularBlazeJointAniResource;
static void *exRegularBlazeModelResource;
static void *exBurningBlazeLastSpawnedWorker;
static void *exBurningBlazeModelResource;
static void *exBlazeDashEffectAnimResource[3];
static B3DAnimationTypes exBlazeDashEffectAnimType[3];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(exBlazeDashEffectUnused)

// --------------------
// FUNCTION DECLS
// --------------------

static BOOL LoadExBlazeDashEffectAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBlazeDashEffectAssets(EX_ACTION_NN_WORK *work);
static void ExBlazeDashEffect_Main_Init(void);
static void ExBlazeDashEffect_OnCheckStageFinished(void);
static void ExBlazeDashEffect_Destructor(void);
static void ExBlazeDashEffect_Main_Active(void);

// --------------------
// FUNCTIONS
// --------------------

void LoadExBurningBlazeModel(EX_ACTION_NN_WORK *work)
{
    exBurningBlazeLastSpawnedWorker = work;

    InitExDrawRequestModel(work);

    if (exBurningBlazeInstanceCount == 0)
    {
        GetCompressedFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_BLZ_NSBMD, &exBurningBlazeModelResource, TRUE, FALSE);

        exBurningBlazeJointAniResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_BLZ_NSBCA);
        NNS_G3dResDefaultSetup(exBurningBlazeModelResource);

        void *oldMemory             = exBurningBlazeModelResource;
        exBurningBlazeModelResource = HeapAllocHead(HEAP_USER, Asset3DSetup_GetResourceSize(exBurningBlazeModelResource));
        Asset3DSetup_CopyResourceData(oldMemory, exBurningBlazeModelResource);
        HeapFree(HEAP_USER, oldMemory);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exBurningBlazeModelResource, 0, TRUE, TRUE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, exBurningBlazeJointAniResource, 0, NULL);

    work->model.primaryAnimType     = B3D_ANIM_JOINT_ANIM;
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[B3D_ANIM_JOINT_ANIM];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & B3D_ANIM_FLAG_JOINT_ANIM) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(60.0);

    work->model.scale.x = FLOAT_TO_FX32(1.0);
    work->model.scale.y = FLOAT_TO_FX32(1.0);
    work->model.scale.z = FLOAT_TO_FX32(1.0);

    work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z = FLOAT_DEG_TO_IDX(179.96);

    work->hitChecker.type                         = EXHITCHECK_TYPE_ACTIVE_PLAYER;
    work->hitChecker.input.isBurningBlazePlayer = TRUE;
    work->hitChecker.box.size.x                   = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.size.y                   = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.size.z                   = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.position                 = &work->model.translation;

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    exBurningBlazeInstanceCount++;
}

void SetExBurningBlazeAnimation(EX_ACTION_NN_WORK *work, u16 anim)
{
    ExUtils_SetJointAnimation(work, exBurningBlazeModelResource, NULL, exBurningBlazeJointAniResource, anim);
}

void ReleaseExBurningBlazeModel(EX_ACTION_NN_WORK *work)
{
    if (exBurningBlazeInstanceCount == 1)
    {
        if (exBurningBlazeModelResource != NULL)
            NNS_G3dResDefaultRelease(exBurningBlazeModelResource);

        if (exBurningBlazeModelResource != NULL)
            HeapFree(HEAP_USER, exBurningBlazeModelResource);
        else
            exBurningBlazeModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (exBurningBlazeInstanceCount > 0)
        exBurningBlazeInstanceCount--;
}

EX_ACTION_NN_WORK *GetExBurningBlazeWorker(void)
{
    return exBurningBlazeLastSpawnedWorker;
}

void LoadExRegularBlazeModel(EX_ACTION_NN_WORK *work)
{
    exRegularBlazeLastSpawnedWorker = work;

    InitExDrawRequestModel(work);

    if (exRegularBlazeInstanceCount == 0)
    {
        GetCompressedFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_NBLZ_NSBMD, &exRegularBlazeModelResource, TRUE, FALSE);

        exRegularBlazeJointAniResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_NBLZ_NSBCA);
        CreateAsset3DSetup(exRegularBlazeModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exRegularBlazeModelResource, 0, TRUE, TRUE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, exRegularBlazeJointAniResource, 0, NULL);

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

    work->hitChecker.type                  = EXHITCHECK_TYPE_ACTIVE_PLAYER;
    work->hitChecker.input.isBlazePlayer = TRUE;
    work->hitChecker.box.size.x            = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y            = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z            = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position          = &work->model.translation;

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    exRegularBlazeInstanceCount++;
}

void SetExRegularBlazeAnimation(EX_ACTION_NN_WORK *work, u16 anim)
{
    ExUtils_SetJointAnimation(work, exRegularBlazeModelResource, NULL, exRegularBlazeJointAniResource, anim);
}

void ReleaseExRegularBlazeModel(EX_ACTION_NN_WORK *work)
{
    if (exRegularBlazeInstanceCount == 1)
    {
        if (exRegularBlazeModelResource != NULL)
            NNS_G3dResDefaultRelease(exRegularBlazeModelResource);

        if (exRegularBlazeModelResource != NULL)
            HeapFree(HEAP_USER, exRegularBlazeModelResource);
        else
            exRegularBlazeModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (exRegularBlazeInstanceCount > 0)
        exRegularBlazeInstanceCount--;
}

BOOL LoadExBlazeDashEffectAssets(EX_ACTION_NN_WORK *work)
{
    exBlazeDashEffectLastSpawnedWorker = work;

    if (exBlazeDashEffectModelFileSize != 0 && exBlazeDashEffectTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exBlazeDashEffectModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exBlazeDashEffectTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exBlazeDashEffectModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (exBlazeDashEffectInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_BDASH_NSBMD, &exBlazeDashEffectModelResource, &exBlazeDashEffectModelFileSize, TRUE,
                                      FALSE);

        exBlazeDashEffectAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BDASH_NSBCA);
        exBlazeDashEffectAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        exBlazeDashEffectAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BDASH_NSBMA);
        exBlazeDashEffectAnimType[1]     = B3D_ANIM_MAT_ANIM;

        exBlazeDashEffectAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BDASH_NSBVA);
        exBlazeDashEffectAnimType[2]     = B3D_ANIM_VIS_ANIM;

        CreateAsset3DSetup(exBlazeDashEffectModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exBlazeDashEffectModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, exBlazeDashEffectAnimType[i], exBlazeDashEffectAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = exBlazeDashEffectAnimType[1];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[exBlazeDashEffectAnimType[1]];

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

    exBlazeDashEffectInstanceCount++;

    return TRUE;
}

void ReleaseExBlazeDashEffectAssets(EX_ACTION_NN_WORK *work)
{
    if (exBlazeDashEffectInstanceCount <= 1)
    {
        if (exBlazeDashEffectModelResource != NULL)
            NNS_G3dResDefaultRelease(exBlazeDashEffectModelResource);

        if (exBlazeDashEffectAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(exBlazeDashEffectAnimResource[0]);

        if (exBlazeDashEffectAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(exBlazeDashEffectAnimResource[1]);

        if (exBlazeDashEffectAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(exBlazeDashEffectAnimResource[2]);

        if (exBlazeDashEffectModelResource != NULL)
            HeapFree(HEAP_USER, exBlazeDashEffectModelResource);
        exBlazeDashEffectModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (exBlazeDashEffectInstanceCount > 0)
        exBlazeDashEffectInstanceCount--;
}

void ExBlazeDashEffect_Main_Init(void)
{
    exBlzDushEffectTask *work = ExTaskGetWorkCurrent(exBlzDushEffectTask);

    exBlazeDashEffectTaskSingleton = GetCurrentTask();

    LoadExBlazeDashEffectAssets(&work->aniDash);
    SetExDrawRequestPriority(&work->aniDash.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniDash.config);

    SetCurrentExTaskMainEvent(ExBlazeDashEffect_Main_Active);
}

void ExBlazeDashEffect_OnCheckStageFinished(void)
{
    exBlzDushEffectTask *work = ExTaskGetWorkCurrent(exBlzDushEffectTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBlazeDashEffect_Destructor(void)
{
    exBlzDushEffectTask *work = ExTaskGetWorkCurrent(exBlzDushEffectTask);

    ReleaseExBlazeDashEffectAssets(&work->aniDash);

    exBlazeDashEffectTaskSingleton = NULL;
}

void ExBlazeDashEffect_Main_Active(void)
{
    exBlzDushEffectTask *work = ExTaskGetWorkCurrent(exBlzDushEffectTask);

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

BOOL CreateExBlazeDashEffect(EX_ACTION_NN_WORK *parent)
{
    if (exBlazeDashEffectTaskSingleton != NULL)
        DestroyExBlazeDashEffect();

    if (parent == NULL)
        return FALSE;

    Task *task = ExTaskCreate(ExBlazeDashEffect_Main_Init, ExBlazeDashEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exBlzDushEffectTask);

    exBlzDushEffectTask *work = ExTaskGetWork(task, exBlzDushEffectTask);
    TaskInitWork8(work);

    work->parent = parent;

    SetExTaskOnCheckStageFinishedEvent(task, ExBlazeDashEffect_OnCheckStageFinished);

    return TRUE;
}

void DestroyExBlazeDashEffect(void)
{
    if (exBlazeDashEffectTaskSingleton != NULL)
        DestroyExTask(exBlazeDashEffectTaskSingleton);
}

void LoadExBurningBlazeSprite(EX_ACTION_BAC3D_WORK *work)
{
    InitExDrawRequestSprite3D(work);

    if (exBurningBlazeSpriteInstanceCount == 0)
        exBurningBlazeSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(exBurningBlazeSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(exBurningBlazeSpriteResource, 1), FALSE);
    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, exBurningBlazeSpriteResource, EX_ACTCOM_ANI_BURNINGBLAZE, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels,
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

    exBurningBlazeSpriteInstanceCount++;
}

void ReleaseExBurningBlazeSprite(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    exBurningBlazeSpriteInstanceCount--;
}