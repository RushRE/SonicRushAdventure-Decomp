#include <ex/effects/exSonicDashEffect.h>
#include <ex/player/exPlayerHelpers.h>
#include <ex/system/exSystem.h>
#include <game/file/binaryBundle.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

static s16 exRegularSonicInstanceCount;
static s16 exSuperSonicInstanceCount;
static s16 exSonicDashEffectInstanceCount;
static s16 exSuperSonicSpriteInstanceCount;
static void *exSonicDashEffectTaskSingleton;
static u32 exSonicDashEffectTextureFileSize;
static u32 exSonicDashEffectModelFileSize;
static void *superSonicJointAniResource;
static void *exSonicDashEffectUnused;
static void *exSonicDashEffectModelResource;
static void *exSonicDashEffectLastSpawnedWorker;
static void *exRegularSonicLastSpawnedWorker;
static void *exSuperSonicSpriteResource;
static void *exRegularSonicJointAniResource;
static void *exRegularSonicModelResource;
static void *exSuperSonicLastSpawnedWorker;
static void *exSuperSonicModelResource;
static void *exSonicDashEffectAnimResource[3];
static u32 exSonicDashEffectAnimType[3];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(exSonicDashEffectUnused)

// --------------------
// FUNCTION DECLS
// --------------------

// ExSonicDashEffect
static BOOL LoadExSonicDashEffectAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExSonicDashEffectAssets(EX_ACTION_NN_WORK *work);
static void ExSonicDashEffect_Main_Init(void);
static void ExSonicDashEffect_TaskUnknown(void);
static void ExSonicDashEffect_Destructor(void);
static void ExSonicDashEffect_Main_Active(void);

// --------------------
// FUNCTIONS
// --------------------

// ExSonic
void LoadExSuperSonicModel(EX_ACTION_NN_WORK *work)
{
    exSuperSonicLastSpawnedWorker = work;

    exDrawReqTask__InitModel(work);

    if (exSuperSonicInstanceCount == 0)
    {
        GetCompressedFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_SON_NSBMD, &exSuperSonicModelResource, TRUE, FALSE);

        superSonicJointAniResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_SON_NSBCA);
        NNS_G3dResDefaultSetup(exSuperSonicModelResource);

        void *oldMemory           = exSuperSonicModelResource;
        exSuperSonicModelResource = HeapAllocHead(HEAP_USER, Asset3DSetup__GetTexSize(exSuperSonicModelResource));
        Asset3DSetup__GetTexture(oldMemory, exSuperSonicModelResource);
        HeapFree(HEAP_USER, oldMemory);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exSuperSonicModelResource, 0, TRUE, TRUE);
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

    work->hitChecker.type            = 2;
    work->hitChecker.field_3.value_8 = TRUE;
    work->hitChecker.box.size.x      = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.size.y      = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.size.z      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position    = &work->model.translation;

    work->config.field_0.value_1 = TRUE;

    exSuperSonicInstanceCount++;
}

void SetExSuperSonicAnimation(EX_ACTION_NN_WORK *work, u16 anim)
{
    exPlayerHelpers__SetAnimationInternal(work, exSuperSonicModelResource, NULL, superSonicJointAniResource, anim);
}

void ReleaseExSuperSonicModel(EX_ACTION_NN_WORK *work)
{
    if (exSuperSonicInstanceCount == 1)
    {
        if (exSuperSonicModelResource != NULL)
            NNS_G3dResDefaultRelease(exSuperSonicModelResource);

        if (exSuperSonicModelResource != NULL)
            HeapFree(HEAP_USER, exSuperSonicModelResource);
        else
            exSuperSonicModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (exSuperSonicInstanceCount > 0)
        exSuperSonicInstanceCount--;
}

EX_ACTION_NN_WORK *GetExSuperSonicWorker(void)
{
    return exSuperSonicLastSpawnedWorker;
}

void LoadExRegularSonicModel(EX_ACTION_NN_WORK *work)
{
    exRegularSonicLastSpawnedWorker = work;

    exDrawReqTask__InitModel(work);

    if (exRegularSonicInstanceCount == 0)
    {
        GetCompressedFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_NSON_NSBMD, &exRegularSonicModelResource, TRUE, FALSE);

        exRegularSonicJointAniResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_NSON_NSBCA);
        Asset3DSetup__Create(exRegularSonicModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exRegularSonicModelResource, 0, TRUE, TRUE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, exRegularSonicJointAniResource, 0, NULL);

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

    work->hitChecker.type             = 2;
    work->hitChecker.field_3.value_10 = TRUE;
    work->hitChecker.box.size.x       = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y       = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z       = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position     = &work->model.translation;

    work->config.field_0.value_1 = TRUE;

    exRegularSonicInstanceCount++;
}

void SetExRegularSonicAnimation(EX_ACTION_NN_WORK *work, u16 anim)
{
    exPlayerHelpers__SetAnimationInternal(work, exRegularSonicModelResource, NULL, exRegularSonicJointAniResource, anim);
}

void ReleaseExRegularSonicModel(EX_ACTION_NN_WORK *work)
{
    if (exRegularSonicInstanceCount == 1)
    {
        if (exRegularSonicModelResource != NULL)
            NNS_G3dResDefaultRelease(exRegularSonicModelResource);

        if (exRegularSonicModelResource != NULL)
            HeapFree(HEAP_USER, exRegularSonicModelResource);
        else
            exRegularSonicModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (exRegularSonicInstanceCount > 0)
        exRegularSonicInstanceCount--;
}

// ExSonicDashEffect
BOOL LoadExSonicDashEffectAssets(EX_ACTION_NN_WORK *work)
{
    exSonicDashEffectLastSpawnedWorker = work;

    if (exSonicDashEffectModelFileSize != 0 && exSonicDashEffectTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exSonicDashEffectModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exSonicDashEffectTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exSonicDashEffectModelFileSize)
            return FALSE;
    }

    exDrawReqTask__InitModel(work);

    if (exSonicDashEffectInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_SDASH_NSBMD, &exSonicDashEffectModelResource, &exSonicDashEffectModelFileSize, TRUE,
                                      FALSE);

        exSonicDashEffectAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SDASH_NSBCA);
        exSonicDashEffectAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        exSonicDashEffectAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SDASH_NSBMA);
        exSonicDashEffectAnimType[1]     = B3D_ANIM_MAT_ANIM;

        exSonicDashEffectAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_SDASH_NSBVA);
        exSonicDashEffectAnimType[2]     = B3D_ANIM_VIS_ANIM;

        Asset3DSetup__Create(exSonicDashEffectModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exSonicDashEffectModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, exSonicDashEffectAnimType[i], exSonicDashEffectAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = exSonicDashEffectAnimType[1];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[exSonicDashEffectAnimType[1]];

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

    work->hitChecker.type            = 0;
    work->hitChecker.field_5.value_1 = TRUE;
    work->hitChecker.box.size.x      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z      = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position    = &work->model.translation;

    work->config.field_0.value_1 = TRUE;

    exSonicDashEffectInstanceCount++;

    return TRUE;
}

void ReleaseExSonicDashEffectAssets(EX_ACTION_NN_WORK *work)
{
    if (exSonicDashEffectInstanceCount <= 1)
    {
        if (exSonicDashEffectModelResource != NULL)
            NNS_G3dResDefaultRelease(exSonicDashEffectModelResource);

        if (exSonicDashEffectAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(exSonicDashEffectAnimResource[0]);

        if (exSonicDashEffectAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(exSonicDashEffectAnimResource[1]);

        if (exSonicDashEffectAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(exSonicDashEffectAnimResource[2]);

        if (exSonicDashEffectModelResource != NULL)
            HeapFree(HEAP_USER, exSonicDashEffectModelResource);
        exSonicDashEffectModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (exSonicDashEffectInstanceCount > 0)
        exSonicDashEffectInstanceCount--;
}

void ExSonicDashEffect_Main_Init(void)
{
    exSonDushEffectTask *work = ExTaskGetWorkCurrent(exSonDushEffectTask);

    exSonicDashEffectTaskSingleton = GetCurrentTask();

    LoadExSonicDashEffectAssets(&work->aniDash);
    exDrawReqTask__SetConfigPriority(&work->aniDash.config, 0xA800);
    exDrawReqTask__Func_21641F0(&work->aniDash.config);

    SetCurrentExTaskMainEvent(ExSonicDashEffect_Main_Active);
}

void ExSonicDashEffect_TaskUnknown(void)
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

    exSonicDashEffectTaskSingleton = NULL;
}

void ExSonicDashEffect_Main_Active(void)
{
    exSonDushEffectTask *work = ExTaskGetWorkCurrent(exSonDushEffectTask);

    exDrawReqTask__Model__Animate(&work->aniDash);

    work->aniDash.model.translation.x = work->parent->model.translation.x;
    work->aniDash.model.translation.y = work->parent->model.translation.y;
    work->aniDash.model.translation.z = work->parent->model.translation.z;

    if (exDrawReqTask__Model__IsAnimFinished(&work->aniDash))
    {
        DestroyCurrentExTask();
    }
    else
    {
        exDrawReqTask__AddRequest(&work->aniDash, &work->aniDash.config);

        RunCurrentExTaskUnknownEvent();
    }
}

BOOL CreateExSonicDashEffect(EX_ACTION_NN_WORK *parent)
{
    if (exSonicDashEffectTaskSingleton != NULL)
        DestroyExSonicDashEffect();

    Task *task = ExTaskCreate(ExSonicDashEffect_Main_Init, ExSonicDashEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exSonDushEffectTask);

    exSonDushEffectTask *work = ExTaskGetWork(task, exSonDushEffectTask);
    TaskInitWork8(work);

    work->parent = parent;

    SetExTaskUnknownEvent(task, ExSonicDashEffect_TaskUnknown);

    return TRUE;
}

void DestroyExSonicDashEffect(void)
{
    if (exSonicDashEffectTaskSingleton != NULL)
        DestroyExTask(exSonicDashEffectTaskSingleton);
}

// ExSonicSprite
void LoadExSuperSonicSprite(EX_ACTION_BAC3D_WORK *work)
{
    exDrawReqTask__InitSprite3D(work);

    if (exSuperSonicSpriteInstanceCount == 0)
        exSuperSonicSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(exSuperSonicSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(exSuperSonicSpriteResource, 1), FALSE);
    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, exSuperSonicSpriteResource, EX_ACTCOM_ANI_SUPERSONIC, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels,
                           vramPalette);
    work->sprite.animator.polygonAttr |= GX_POLYGON_ATTR_MISC_XLU_DEPTH_UPDATE;

    work->hitChecker.type            = 0;
    work->hitChecker.field_5.value_4 = TRUE;

    work->sprite.translation.z   = FLOAT_TO_FX32(70.0);
    work->sprite.scale.x         = FLOAT_TO_FX32(0.2);
    work->sprite.scale.y         = FLOAT_TO_FX32(0.2);
    work->sprite.scale.z         = FLOAT_TO_FX32(0.2);
    work->config.field_0.value_1 = TRUE;

    work->hitChecker.box.size.x   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position = &work->sprite.translation;

    exSuperSonicSpriteInstanceCount++;
}

void ReleaseExSuperSonicSprite(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    exSuperSonicSpriteInstanceCount--;
}