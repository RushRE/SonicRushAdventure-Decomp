#include <ex/effects/exBlazeDashEffect.h>
#include <ex/player/exPlayerHelpers.h>
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
static s16 blazeDashEffectInstanceCount;
static s16 exBurningBlazeSpriteInstanceCount;

static void *blazeDashEffectTaskSingleton;
static u32 blazeDashEffectTextureFileSize;
static u32 blazeDashEffectModelFileSize;
static void *burningBlazeJointAniResource;
static void *blazeDashEffectUnused;
static void *blazeDashEffectModelResource;
static void *blazeDashEffectLastSpawnedWorker;
static void *exRegularBlazeLastSpawnedWorker;
static void *burningBlazeSpriteResource;
static void *regularBlazeJointAniResource;
static void *regularBlazeModelResource;
static void *exBurningBlazeLastSpawnedWorker;
static void *burningBlazeModelResource;
static void *blazeDashEffectAnimResource[3];
static B3DAnimationTypes blazeDashEffectAnimType[3];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(blazeDashEffectUnused)

// --------------------
// FUNCTION DECLS
// --------------------

static BOOL LoadExBlazeDashEffectAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBlazeDashEffectAssets(EX_ACTION_NN_WORK *work);
static void ExBlazeDashEffect_Main_Init(void);
static void ExBlazeDashEffect_TaskUnknown(void);
static void ExBlazeDashEffect_Destructor(void);
static void ExBlazeDashEffect_Main_Active(void);

// --------------------
// FUNCTIONS
// --------------------

void LoadExBurningBlazeModel(EX_ACTION_NN_WORK *work)
{
    exBurningBlazeLastSpawnedWorker = work;

    exDrawReqTask__InitModel(work);

    if (exBurningBlazeInstanceCount == 0)
    {
        GetCompressedFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_BLZ_NSBMD, &burningBlazeModelResource, TRUE, FALSE);

        burningBlazeJointAniResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_BLZ_NSBCA);
        NNS_G3dResDefaultSetup(burningBlazeModelResource);

        void *oldMemory           = burningBlazeModelResource;
        burningBlazeModelResource = HeapAllocHead(HEAP_USER, Asset3DSetup__GetTexSize(burningBlazeModelResource));
        Asset3DSetup__GetTexture(oldMemory, burningBlazeModelResource);
        HeapFree(HEAP_USER, oldMemory);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, burningBlazeModelResource, 0, TRUE, TRUE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, burningBlazeJointAniResource, 0, NULL);

    work->model.field_32C = 0;
    work->model.field_328 = work->model.animator.currentAnimObj[0];

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

    work->hitChecker.type             = 2;
    work->hitChecker.field_3.value_20 = TRUE;
    work->hitChecker.box.size.x       = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.size.y       = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.size.z       = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.position     = &work->model.translation;

    work->config.field_0.value_1 = 1;

    exBurningBlazeInstanceCount++;
}

void SetExBurningBlazeAnimation(EX_ACTION_NN_WORK *work, u16 anim)
{
    exPlayerHelpers__SetAnimationInternal(work, burningBlazeModelResource, NULL, burningBlazeJointAniResource, anim);
}

void ReleaseExBurningBlazeModel(EX_ACTION_NN_WORK *work)
{
    if (exBurningBlazeInstanceCount == 1)
    {
        if (burningBlazeModelResource != NULL)
            NNS_G3dResDefaultRelease(burningBlazeModelResource);

        if (burningBlazeModelResource != NULL)
            HeapFree(HEAP_USER, burningBlazeModelResource);
        else
            burningBlazeModelResource = NULL;
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

    exDrawReqTask__InitModel(work);

    if (exRegularBlazeInstanceCount == 0)
    {
        GetCompressedFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_NBLZ_NSBMD, &regularBlazeModelResource, TRUE, FALSE);

        regularBlazeJointAniResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_NBLZ_NSBCA);
        Asset3DSetup__Create(regularBlazeModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, regularBlazeModelResource, 0, TRUE, TRUE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, regularBlazeJointAniResource, 0, NULL);

    work->model.field_32C = 0;
    work->model.field_328 = work->model.animator.currentAnimObj[0];

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
    work->hitChecker.field_3.value_40 = TRUE;
    work->hitChecker.box.size.x       = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y       = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z       = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position     = &work->model.translation;

    work->config.field_0.value_1 = 1;

    exRegularBlazeInstanceCount++;
}

void SetExRegularBlazeAnimation(EX_ACTION_NN_WORK *work, u16 anim)
{
    exPlayerHelpers__SetAnimationInternal(work, regularBlazeModelResource, NULL, regularBlazeJointAniResource, anim);
}

void ReleaseExRegularBlazeModel(EX_ACTION_NN_WORK *work)
{
    if (exRegularBlazeInstanceCount == 1)
    {
        if (regularBlazeModelResource != NULL)
            NNS_G3dResDefaultRelease(regularBlazeModelResource);

        if (regularBlazeModelResource != NULL)
            HeapFree(HEAP_USER, regularBlazeModelResource);
        else
            regularBlazeModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (exRegularBlazeInstanceCount > 0)
        exRegularBlazeInstanceCount--;
}

BOOL LoadExBlazeDashEffectAssets(EX_ACTION_NN_WORK *work)
{
    blazeDashEffectLastSpawnedWorker = work;

    if (blazeDashEffectModelFileSize != 0 && blazeDashEffectTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < blazeDashEffectModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < blazeDashEffectTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < blazeDashEffectModelFileSize)
            return FALSE;
    }

    exDrawReqTask__InitModel(work);

    if (blazeDashEffectInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_BDASH_NSBMD, &blazeDashEffectModelResource, &blazeDashEffectModelFileSize, TRUE,
                                      FALSE);

        blazeDashEffectAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BDASH_NSBCA);
        blazeDashEffectAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        blazeDashEffectAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BDASH_NSBMA);
        blazeDashEffectAnimType[1]     = B3D_ANIM_MAT_ANIM;

        blazeDashEffectAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_BDASH_NSBVA);
        blazeDashEffectAnimType[2]     = B3D_ANIM_VIS_ANIM;

        Asset3DSetup__Create(blazeDashEffectModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, blazeDashEffectModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, blazeDashEffectAnimType[i], blazeDashEffectAnimResource[i], 0, NULL);
    }

    work->model.field_32C = blazeDashEffectAnimType[1];
    work->model.field_328 = work->model.animator.currentAnimObj[blazeDashEffectAnimType[1]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(60.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);

    if (exPlayerAdminTask__GetUnknown2()->activeCharacter.value_8 == TRUE || exPlayerAdminTask__GetUnknown2()->activeCharacter.value_2 == TRUE
        || exPlayerAdminTask__GetUnknown2()->activeCharacter.value_10 == TRUE || exPlayerAdminTask__GetUnknown2()->activeCharacter.value_4 == TRUE)
    {
        if (GetExSystemStatus()->state == EXSYSTASK_STATE_11 || GetExSystemStatus()->state == EXSYSTASK_STATE_7 || GetExSystemStatus()->state == EXSYSTASK_STATE_9)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
        }
        else if (!exPlayerAdminTask__GetUnknown2()->activeCharacter.value_8 && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_2
                 && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_10 && exPlayerAdminTask__GetUnknown2()->activeCharacter.value_4 == TRUE)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
        }
        else if (!exPlayerAdminTask__GetUnknown2()->activeCharacter.value_8 && exPlayerAdminTask__GetUnknown2()->activeCharacter.value_2 == TRUE
                 && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_10 && exPlayerAdminTask__GetUnknown2()->activeCharacter.value_4 == TRUE)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
            work->model.angle.y = FLOAT_DEG_TO_IDX(44.99);
        }
        else if (!exPlayerAdminTask__GetUnknown2()->activeCharacter.value_8 && exPlayerAdminTask__GetUnknown2()->activeCharacter.value_2 == TRUE
                 && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_10 && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_4)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
            work->model.angle.y = FLOAT_DEG_TO_IDX(89.98);
        }
        else if (!exPlayerAdminTask__GetUnknown2()->activeCharacter.value_8 && exPlayerAdminTask__GetUnknown2()->activeCharacter.value_2 == TRUE
                 && exPlayerAdminTask__GetUnknown2()->activeCharacter.value_10 == TRUE && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_4)

        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
            work->model.angle.y = FLOAT_DEG_TO_IDX(134.97);
        }
        else if (!exPlayerAdminTask__GetUnknown2()->activeCharacter.value_8 && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_2
                 && exPlayerAdminTask__GetUnknown2()->activeCharacter.value_10 == TRUE && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_4)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
            work->model.angle.y = FLOAT_DEG_TO_IDX(179.96);
        }
        else if (exPlayerAdminTask__GetUnknown2()->activeCharacter.value_8 == TRUE && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_2
                 && exPlayerAdminTask__GetUnknown2()->activeCharacter.value_10 == TRUE && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_4)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
            work->model.angle.y = -FLOAT_DEG_TO_IDX(135.055);
        }
        else if (exPlayerAdminTask__GetUnknown2()->activeCharacter.value_8 == TRUE && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_2
                 && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_10 && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_4)
        {
            work->model.angle.x = -FLOAT_DEG_TO_IDX(90.066);
            work->model.angle.y = -FLOAT_DEG_TO_IDX(90.066);
        }
        else if (exPlayerAdminTask__GetUnknown2()->activeCharacter.value_8 == TRUE && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_2
                 && !exPlayerAdminTask__GetUnknown2()->activeCharacter.value_10 && exPlayerAdminTask__GetUnknown2()->activeCharacter.value_4 == TRUE)
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

    work->config.field_0.value_1 = 1;

    blazeDashEffectInstanceCount++;

    return TRUE;
}

void ReleaseExBlazeDashEffectAssets(EX_ACTION_NN_WORK *work)
{
    if (blazeDashEffectInstanceCount <= 1)
    {
        if (blazeDashEffectModelResource != NULL)
            NNS_G3dResDefaultRelease(blazeDashEffectModelResource);

        if (blazeDashEffectAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(blazeDashEffectAnimResource[0]);

        if (blazeDashEffectAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(blazeDashEffectAnimResource[1]);

        if (blazeDashEffectAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(blazeDashEffectAnimResource[2]);

        if (blazeDashEffectModelResource != NULL)
            HeapFree(HEAP_USER, blazeDashEffectModelResource);
        blazeDashEffectModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    if (blazeDashEffectInstanceCount > 0)
        blazeDashEffectInstanceCount--;
}

void ExBlazeDashEffect_Main_Init(void)
{
    exBlzDushEffectTask *work = ExTaskGetWorkCurrent(exBlzDushEffectTask);

    blazeDashEffectTaskSingleton = GetCurrentTask();

    LoadExBlazeDashEffectAssets(&work->aniDash);
    exDrawReqTask__SetConfigPriority(&work->aniDash.config, 0xA800);
    exDrawReqTask__Func_21641F0(&work->aniDash.config);

    SetCurrentExTaskMainEvent(ExBlazeDashEffect_Main_Active);
}

void ExBlazeDashEffect_TaskUnknown(void)
{
    exBlzDushEffectTask *work = ExTaskGetWorkCurrent(exBlzDushEffectTask);
    UNUSED(work);

    if (GetExSystemFlag_2178650())
        DestroyCurrentExTask();
}

void ExBlazeDashEffect_Destructor(void)
{
    exBlzDushEffectTask *work = ExTaskGetWorkCurrent(exBlzDushEffectTask);

    ReleaseExBlazeDashEffectAssets(&work->aniDash);

    blazeDashEffectTaskSingleton = NULL;
}

void ExBlazeDashEffect_Main_Active(void)
{
    exBlzDushEffectTask *work = ExTaskGetWorkCurrent(exBlzDushEffectTask);

    exDrawReqTask__Model__Animate(&work->aniDash);

    work->aniDash.model.translation.x = work->parent->spriteBlaze.sprite.animator.work.matrix43.m[2][0];
    work->aniDash.model.translation.y = work->parent->spriteBlaze.sprite.animator.work.matrix43.m[2][1];
    work->aniDash.model.translation.z = work->parent->spriteBlaze.sprite.animator.work.matrix43.m[2][2];

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

BOOL CreateExBlazeDashEffect(exPlayerAdminTask *parent)
{
    if (blazeDashEffectTaskSingleton != NULL)
        DestroyExBlazeDashEffect();

    if (parent == NULL)
        return FALSE;

    Task *task = ExTaskCreate(ExBlazeDashEffect_Main_Init, ExBlazeDashEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exBlzDushEffectTask);

    exBlzDushEffectTask *work = ExTaskGetWork(task, exBlzDushEffectTask);
    TaskInitWork8(work);

    work->parent = parent;

    SetExTaskUnknownEvent(task, ExBlazeDashEffect_TaskUnknown);

    return TRUE;
}

void DestroyExBlazeDashEffect(void)
{
    if (blazeDashEffectTaskSingleton != NULL)
        DestroyExTask(blazeDashEffectTaskSingleton);
}

void LoadExBurningBlazeSprite(EX_ACTION_BAC3D_WORK *work)
{
    exDrawReqTask__InitSprite3D(work);

    if (exBurningBlazeSpriteInstanceCount == 0)
        burningBlazeSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(burningBlazeSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(burningBlazeSpriteResource, 1), FALSE);
    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, burningBlazeSpriteResource, EX_ACTCOM_ANI_BURNINGBLAZE, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels,
                           vramPalette);
    work->sprite.animator.polygonAttr |= (1 << REG_G3_POLYGON_ATTR_XL_SHIFT);

    work->hitChecker.type            = 0;
    work->hitChecker.field_5.value_4 = TRUE;

    work->sprite.translation.z   = FLOAT_TO_FX32(70.0);
    work->sprite.scale.x         = FLOAT_TO_FX32(0.2);
    work->sprite.scale.y         = FLOAT_TO_FX32(0.2);
    work->sprite.scale.z         = FLOAT_TO_FX32(0.2);
    work->config.field_0.value_1 = 1;

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