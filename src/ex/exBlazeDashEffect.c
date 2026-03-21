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

static s16 sExRegularBlazeInstanceCount;
static s16 sExBurningBlazeInstanceCount;
static s16 sExBlazeDashEffectInstanceCount;
static s16 sExBurningBlazeSpriteInstanceCount;
static void *sExBlazeDashEffectTaskSingleton;
static u32 sExBlazeDashEffectTextureFileSize;
static u32 sExBlazeDashEffectModelFileSize;
static void *sExBurningBlazeJointAniResource;
static void *sExBlazeDashEffectUnused;
static void *sExBlazeDashEffectModelResource;
static void *sExBlazeDashEffectLastSpawnedWorker;
static void *sExRegularBlazeLastSpawnedWorker;
static void *sExBurningBlazeSpriteResource;
static void *sExRegularBlazeJointAniResource;
static void *sExRegularBlazeModelResource;
static void *sExBurningBlazeLastSpawnedWorker;
static void *sExBurningBlazeModelResource;
static void *sExBlazeDashEffectAnimResource[3];
static B3DAnimationTypes sExBlazeDashEffectAnimType[3];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(sExBlazeDashEffectUnused)

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
    sExBurningBlazeLastSpawnedWorker = work;

    InitExDrawRequestModel(work);

    if (sExBurningBlazeInstanceCount == 0)
    {
        GetCompressedFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_BLZ_NSBMD, &sExBurningBlazeModelResource, TRUE, FALSE);

        sExBurningBlazeJointAniResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_BLZ_NSBCA);
        NNS_G3dResDefaultSetup(sExBurningBlazeModelResource);

        void *oldMemory             = sExBurningBlazeModelResource;
        sExBurningBlazeModelResource = HeapAllocHead(HEAP_USER, Asset3DSetup_GetResourceSize(sExBurningBlazeModelResource));
        Asset3DSetup_CopyResourceData(oldMemory, sExBurningBlazeModelResource);
        HeapFree(HEAP_USER, oldMemory);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sExBurningBlazeModelResource, 0, TRUE, TRUE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, sExBurningBlazeJointAniResource, 0, NULL);

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

    sExBurningBlazeInstanceCount++;
}

void SetExBurningBlazeAnimation(EX_ACTION_NN_WORK *work, u16 anim)
{
    ExUtils_SetJointAnimation(work, sExBurningBlazeModelResource, NULL, sExBurningBlazeJointAniResource, anim);
}

void ReleaseExBurningBlazeModel(EX_ACTION_NN_WORK *work)
{
    if (sExBurningBlazeInstanceCount == 1)
    {
        if (sExBurningBlazeModelResource != NULL)
            NNS_G3dResDefaultRelease(sExBurningBlazeModelResource);

        if (sExBurningBlazeModelResource != NULL)
            HeapFree(HEAP_USER, sExBurningBlazeModelResource);
        else
            sExBurningBlazeModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (sExBurningBlazeInstanceCount > 0)
        sExBurningBlazeInstanceCount--;
}

EX_ACTION_NN_WORK *GetExBurningBlazeWorker(void)
{
    return sExBurningBlazeLastSpawnedWorker;
}

void LoadExRegularBlazeModel(EX_ACTION_NN_WORK *work)
{
    sExRegularBlazeLastSpawnedWorker = work;

    InitExDrawRequestModel(work);

    if (sExRegularBlazeInstanceCount == 0)
    {
        GetCompressedFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_NBLZ_NSBMD, &sExRegularBlazeModelResource, TRUE, FALSE);

        sExRegularBlazeJointAniResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_NBLZ_NSBCA);
        CreateAsset3DSetup(sExRegularBlazeModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sExRegularBlazeModelResource, 0, TRUE, TRUE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, sExRegularBlazeJointAniResource, 0, NULL);

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

    sExRegularBlazeInstanceCount++;
}

void SetExRegularBlazeAnimation(EX_ACTION_NN_WORK *work, u16 anim)
{
    ExUtils_SetJointAnimation(work, sExRegularBlazeModelResource, NULL, sExRegularBlazeJointAniResource, anim);
}

void ReleaseExRegularBlazeModel(EX_ACTION_NN_WORK *work)
{
    if (sExRegularBlazeInstanceCount == 1)
    {
        if (sExRegularBlazeModelResource != NULL)
            NNS_G3dResDefaultRelease(sExRegularBlazeModelResource);

        if (sExRegularBlazeModelResource != NULL)
            HeapFree(HEAP_USER, sExRegularBlazeModelResource);
        else
            sExRegularBlazeModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (sExRegularBlazeInstanceCount > 0)
        sExRegularBlazeInstanceCount--;
}

BOOL LoadExBlazeDashEffectAssets(EX_ACTION_NN_WORK *work)
{
    sExBlazeDashEffectLastSpawnedWorker = work;

    if (sExBlazeDashEffectModelFileSize != 0 && sExBlazeDashEffectTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < sExBlazeDashEffectModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < sExBlazeDashEffectTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < sExBlazeDashEffectModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (sExBlazeDashEffectInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_BDASH_NSBMD, &sExBlazeDashEffectModelResource, &sExBlazeDashEffectModelFileSize, TRUE,
                                      FALSE);

        sExBlazeDashEffectAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BDASH_NSBCA);
        sExBlazeDashEffectAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        sExBlazeDashEffectAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BDASH_NSBMA);
        sExBlazeDashEffectAnimType[1]     = B3D_ANIM_MAT_ANIM;

        sExBlazeDashEffectAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BDASH_NSBVA);
        sExBlazeDashEffectAnimType[2]     = B3D_ANIM_VIS_ANIM;

        CreateAsset3DSetup(sExBlazeDashEffectModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sExBlazeDashEffectModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, sExBlazeDashEffectAnimType[i], sExBlazeDashEffectAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = sExBlazeDashEffectAnimType[1];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[sExBlazeDashEffectAnimType[1]];

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

    sExBlazeDashEffectInstanceCount++;

    return TRUE;
}

void ReleaseExBlazeDashEffectAssets(EX_ACTION_NN_WORK *work)
{
    if (sExBlazeDashEffectInstanceCount <= 1)
    {
        if (sExBlazeDashEffectModelResource != NULL)
            NNS_G3dResDefaultRelease(sExBlazeDashEffectModelResource);

        if (sExBlazeDashEffectAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(sExBlazeDashEffectAnimResource[0]);

        if (sExBlazeDashEffectAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(sExBlazeDashEffectAnimResource[1]);

        if (sExBlazeDashEffectAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(sExBlazeDashEffectAnimResource[2]);

        if (sExBlazeDashEffectModelResource != NULL)
            HeapFree(HEAP_USER, sExBlazeDashEffectModelResource);
        sExBlazeDashEffectModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (sExBlazeDashEffectInstanceCount > 0)
        sExBlazeDashEffectInstanceCount--;
}

void ExBlazeDashEffect_Main_Init(void)
{
    exBlzDushEffectTask *work = ExTaskGetWorkCurrent(exBlzDushEffectTask);

    sExBlazeDashEffectTaskSingleton = GetCurrentTask();

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

    sExBlazeDashEffectTaskSingleton = NULL;
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
    if (sExBlazeDashEffectTaskSingleton != NULL)
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
    if (sExBlazeDashEffectTaskSingleton != NULL)
        DestroyExTask(sExBlazeDashEffectTaskSingleton);
}

void LoadExBurningBlazeSprite(EX_ACTION_BAC3D_WORK *work)
{
    InitExDrawRequestSprite3D(work);

    if (sExBurningBlazeSpriteInstanceCount == 0)
        sExBurningBlazeSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(sExBurningBlazeSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(sExBurningBlazeSpriteResource, 1), FALSE);
    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, sExBurningBlazeSpriteResource, EX_ACTCOM_ANI_BURNINGBLAZE, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels,
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

    sExBurningBlazeSpriteInstanceCount++;
}

void ReleaseExBurningBlazeSprite(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    sExBurningBlazeSpriteInstanceCount--;
}