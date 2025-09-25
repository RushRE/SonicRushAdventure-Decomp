#include <ex/boss/exBossMeteor.h>
#include <ex/boss/exBossMeteorAttack.h>
#include <ex/effects/exBigExplosion.h>
#include <ex/effects/exBossFireEffect.h>
#include <ex/system/exDrawReq.h>
#include <ex/system/exSystem.h>
#include <ex/boss/exBossHelpers.h>
#include <ex/player/exPlayerHelpers.h>
#include <game/file/binaryBundle.h>
#include <game/audio/audioSystem.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// ENUMS
// --------------------

enum ExBossMeteorLockOnAnimIDs_
{
    ex_effe_targ0, // Appearing
    ex_effe_targ1, // Targeting
    ex_effe_targ2, // Shrinking
    ex_effe_targ3, // Exploding
};

// --------------------
// VARIABLES
// --------------------

static s16 meteorLockOnInstanceCount;
static s16 meteorInstanceCount;
static s16 meteorBombInstanceCount;

static u32 meteorBombModelFileSize;
static EX_ACTION_NN_WORK *meteorBombLastSpawnedWorker;
static void *meteorAnimResource[1];
static void *meteorModelResource;
static void *meteorUnused;
static Task *meteorTaskSingleton;
static u32 meteorTextureFileSize;
static u32 meteorModelFileSize;
static u32 meteorBombTextureFileSize;
static EX_ACTION_NN_WORK *meteorLastSpawnedWorker;
static u32 meteorAnimType[1];
static u32 meteorLockOnTextureFileSize;
static Task *meteorAdminTaskSingleton;
static Task *meteorLockOnTaskSingleton;
static u32 meteorLockOnModelFileSize;
static void *meteorLockOnUnused;
static EX_ACTION_NN_WORK *meteorLockOnLastSpawnedWorker;
static void *meteorLockOnModelResource;
static void *meteorBombModelResource;
static Task *meteorBombTaskSingleton;
static void *meteorBombUnused;
static VecFx32 meteorLockOnPosition;
static void *meteorLockOnAnimResource[3];
static u32 meteorLockOnAnimType[3];
static void *meteorBombAnimResource[4];
static u32 meteorBombAnimType[4];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(meteorBombUnused)
FORCE_INCLUDE_VARIABLE_BSS(meteorLockOnUnused)
FORCE_INCLUDE_VARIABLE_BSS(meteorUnused)

// --------------------
// FUNCTION DECLS
// --------------------

// External
extern BOOL SetExDrawRequestGlobalModelConfigTimer(u8 duration);

// ExBossMeteorBomb
static BOOL LoadExBossMeteorBombAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBossMeteorBombAssets(EX_ACTION_NN_WORK *work);
static void ExBossMeteorBomb_Main_Init(void);
static void ExBossMeteorBomb_TaskUnknown(void);
static void ExBossMeteorBomb_Destructor(void);
static void ExBossMeteorBomb_Main_Explode(void);

// ExBossMeteorLockOn
static BOOL LoadExBossMeteorLockOnAssets(EX_ACTION_NN_WORK *work);
static void SetExBossMeteorLockOnAnim(EX_ACTION_NN_WORK *work, u16 id);
static void ReleaseExBossMeteorLockOnAssets(EX_ACTION_NN_WORK *work);
static void ExBossMeteorLockOn_Main_Init(void);
static void ExBossMeteorLockOn_TaskUnknown(void);
static void ExBossMeteorLockOn_Destructor(void);
static void ExBossMeteorLockOn_Main_Appear(void);
static void ExBossMeteorLockOn_Main_FinishAppearing(void);
static void ExBossMeteorLockOn_Action_TargetPlayer(void);
static void ExBossMeteorLockOn_Main_TargetPlayer(void);
static void ExBossMeteorLockOn_Action_LockOn(void);
static void ExBossMeteorLockOn_Main_LockedOn(void);
static void ExBossMeteorLockOn_Action_Explode(void);
static void ExBossMeteorLockOn_Main_Exploded(void);

// ExBossMeteor
static BOOL LoadExBossMeteorAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBossMeteorAssets(EX_ACTION_NN_WORK *work);
static void ExBossMeteor_Main_Init(void);
static void ExBossMeteor_TaskUnknown(void);
static void ExBossMeteor_Destructor(void);
static void ExBossMeteor_Main_FallToLockOnPos(void);
static void ExBossMeteor_Action_Impact(void);
static void ExBossMeteor_Main_Impact(void);
static void ExBossMeteor_Action_Explode(void);
static void ExBossMeteor_Main_Explode(void);

// ExBossMeteorAdmin
static void ExBossMeteorAdmin_Main_Init(void);
static void ExBossMeteorAdmin_TaskUnknown(void);
static void ExBossMeteorAdmin_Destructor(void);
static void ExBossMeteorAdmin_Main_WaitForLockOn(void);
static void ExBossMeteorAdmin_Action_WaitForMeteor(void);
static void ExBossMeteorAdmin_Main_WaitForMeteor(void);
static void ExBossMeteorAdmin_Action_WaitForExplosion(void);
static void ExBossMeteorAdmin_Main_WaitForExplosion(void);

// --------------------
// FUNCTIONS
// --------------------

BOOL LoadExBossMeteorBombAssets(EX_ACTION_NN_WORK *work)
{
    meteorBombLastSpawnedWorker = work;

    if (meteorBombModelFileSize != 0 && meteorBombTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < meteorBombModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < meteorBombTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < meteorBombModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (meteorBombInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_METEXP_NSBMD, &meteorBombModelResource, &meteorBombModelFileSize, TRUE, FALSE);

        meteorBombAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_METEXP_NSBCA);
        meteorBombAnimType[0]     = B3D_ANIM_JOINT_ANIM;
        meteorBombAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_METEXP_NSBMA);
        meteorBombAnimType[1]     = B3D_ANIM_MAT_ANIM;
        meteorBombAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_METEXP_NSBTA);
        meteorBombAnimType[2]     = B3D_ANIM_TEX_ANIM;
        meteorBombAnimResource[3] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_METEXP_NSBVA);
        meteorBombAnimType[3]     = B3D_ANIM_VIS_ANIM;

        Asset3DSetup__Create(meteorBombModelResource);
    }

    AnimatorMDL *animator = &work->model.animator;
    AnimatorMDL__Init(animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(animator, meteorBombModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < ARRAY_COUNT(meteorBombAnimResource); i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, meteorBombAnimType[i], meteorBombAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = meteorBombAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[meteorBombAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(0.0);

    work->model.scale.x = FLOAT_TO_FX32(0.1001);
    work->model.scale.y = FLOAT_TO_FX32(0.1001);
    work->model.scale.z = FLOAT_TO_FX32(0.1001);

    work->model.angle.x = FLOAT_DEG_TO_IDX(269.935);
    work->model.angle.z = FLOAT_DEG_TO_IDX(179.96);

    work->hitChecker.type                     = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.field_2.isBossMeteorBomb = TRUE;
    work->hitChecker.box.size.x               = FLOAT_TO_FX32(0.01001);
    work->hitChecker.box.size.y               = FLOAT_TO_FX32(0.01001);
    work->hitChecker.box.size.z               = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position             = &work->model.translation;

    meteorBombInstanceCount++;

    return TRUE;
}

void ReleaseExBossMeteorBombAssets(EX_ACTION_NN_WORK *work)
{
    if (meteorBombInstanceCount <= 1)
    {
        if (meteorBombModelResource)
            NNS_G3dResDefaultRelease(meteorBombModelResource);

        if (meteorBombAnimResource[0])
            NNS_G3dResDefaultRelease(meteorBombAnimResource[0]);

        if (meteorBombAnimResource[1])
            NNS_G3dResDefaultRelease(meteorBombAnimResource[1]);

        if (meteorBombAnimResource[2])
            NNS_G3dResDefaultRelease(meteorBombAnimResource[2]);

        if (meteorBombAnimResource[3])
            NNS_G3dResDefaultRelease(meteorBombAnimResource[3]);

        if (meteorBombModelResource)
            HeapFree(HEAP_USER, meteorBombModelResource);
        meteorBombModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);
    meteorBombInstanceCount--;
}

void ExBossMeteorBomb_Main_Init(void)
{
    exBossMeteBombTask *work = ExTaskGetWorkCurrent(exBossMeteBombTask);

    meteorBombTaskSingleton = GetCurrentTask();

    LoadExBossMeteorBombAssets(&work->animator);
    SetExDrawRequestPriority(&work->animator.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->animator.config);

    work->animator.model.translation.x = work->targetPos.x;
    work->animator.model.translation.y = work->targetPos.y;
    work->animator.model.translation.z = FLOAT_TO_FX32(0.0);

    work->unknownTimer1 = 1 + (mtMathRand() % 2);
    work->unknownTimer2 = 5 + (mtMathRand() % 3);

    work->modelScaleSpeed.x = FLOAT_TO_FX32(0.025);
    work->modelScaleSpeed.y = FLOAT_TO_FX32(0.025);
    work->modelScaleSpeed.z = FLOAT_TO_FX32(0.025);

    work->hitboxScaleSpeed.x = FLOAT_TO_FX32(0.48755);
    work->hitboxScaleSpeed.y = FLOAT_TO_FX32(0.48755);
    work->hitboxScaleSpeed.z = FLOAT_TO_FX32(0.0);

    work->timer = SECONDS_TO_FRAMES(2.0);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_MAGMA_EXP);

    SetCurrentExTaskMainEvent(ExBossMeteorBomb_Main_Explode);
}

void ExBossMeteorBomb_TaskUnknown(void)
{
    exBossMeteBombTask *work = ExTaskGetWorkCurrent(exBossMeteBombTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBossMeteorBomb_Destructor(void)
{
    exBossMeteBombTask *work = ExTaskGetWorkCurrent(exBossMeteBombTask);

    ReleaseExBossMeteorBombAssets(&work->animator);
    meteorBombTaskSingleton = NULL;
}

void ExBossMeteorBomb_Main_Explode(void)
{
    exBossMeteBombTask *work = ExTaskGetWorkCurrent(exBossMeteBombTask);

    AnimateExDrawRequestModel(&work->animator);
    SetExDrawRequestGlobalModelConfigTimer(15);

    work->animator.model.scale.x += work->modelScaleSpeed.x;
    work->animator.model.scale.y += work->modelScaleSpeed.y;
    work->animator.model.scale.z += work->modelScaleSpeed.z;

    work->animator.hitChecker.box.size.x += work->hitboxScaleSpeed.x;
    work->animator.hitChecker.box.size.y += work->hitboxScaleSpeed.y;

    if (IsExDrawRequestModelAnimFinished(&work->animator))
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->animator, &work->animator.config);
        exHitCheckTask_AddHitCheck(&work->animator.hitChecker);

        RunCurrentExTaskUnknownEvent();
    }
}

BOOL CreateExBossMeteorBomb(VecFx32 *targetPos)
{
    Task *task =
        ExTaskCreate(ExBossMeteorBomb_Main_Init, ExBossMeteorBomb_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exBossMeteBombTask);

    exBossMeteBombTask *work = ExTaskGetWork(task, exBossMeteBombTask);
    TaskInitWork8(work);

    work->targetPos.x = targetPos->x;
    work->targetPos.y = targetPos->y;
    work->targetPos.z = targetPos->z;

    SetExTaskUnknownEvent(task, ExBossMeteorBomb_TaskUnknown);

    return TRUE;
}

BOOL LoadExBossMeteorLockOnAssets(EX_ACTION_NN_WORK *work)
{
    meteorLockOnLastSpawnedWorker = work;

    if (meteorLockOnModelFileSize != 0 && meteorLockOnTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < meteorLockOnModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < meteorLockOnTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < meteorLockOnModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (meteorLockOnInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_TARG_NSBMD, &meteorLockOnModelResource, &meteorLockOnModelFileSize, TRUE, FALSE);

        meteorLockOnAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_TARG_NSBCA);
        meteorLockOnAnimType[0]     = B3D_ANIM_JOINT_ANIM;
        meteorLockOnAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_TARG_NSBTA);
        meteorLockOnAnimType[1]     = B3D_ANIM_TEX_ANIM;

        Asset3DSetup__Create(meteorLockOnModelResource);
    }

    AnimatorMDL *animator = &work->model.animator;
    AnimatorMDL__Init(animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(animator, meteorLockOnModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < ARRAY_COUNT(meteorLockOnAnimResource) - 1; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, meteorLockOnAnimType[i], meteorLockOnAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = meteorLockOnAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[meteorLockOnAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(65.0);

    work->model.scale.x = FLOAT_TO_FX32(1.0);
    work->model.scale.y = FLOAT_TO_FX32(1.0);
    work->model.scale.z = FLOAT_TO_FX32(1.0);

    work->model.angle.x = FLOAT_DEG_TO_IDX(269.935);
    work->model.angle.z = FLOAT_DEG_TO_IDX(179.96);

    work->hitChecker.type                     = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.flags.isBossMeteorEffect = TRUE;
    work->hitChecker.box.size.x               = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y               = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z               = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position             = &work->model.translation;

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    meteorLockOnInstanceCount++;

    return TRUE;
}

void SetExBossMeteorLockOnAnim(EX_ACTION_NN_WORK *work, u16 id)
{
    for (u16 i = 0; i < ARRAY_COUNT(meteorLockOnAnimResource) - 1; i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, meteorLockOnAnimType[i], meteorLockOnAnimResource[i], id, NULL);
    }

    work->model.primaryAnimType     = meteorLockOnAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[meteorLockOnAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }
}

void ReleaseExBossMeteorLockOnAssets(EX_ACTION_NN_WORK *work)
{
    if (meteorLockOnInstanceCount <= 1)
    {
        if (meteorLockOnModelResource)
            NNS_G3dResDefaultRelease(meteorLockOnModelResource);

        if (meteorLockOnAnimResource[0])
            NNS_G3dResDefaultRelease(meteorLockOnAnimResource[0]);

        if (meteorLockOnAnimResource[1])
            NNS_G3dResDefaultRelease(meteorLockOnAnimResource[1]);

        if (meteorLockOnModelResource)
            HeapFree(HEAP_USER, meteorLockOnModelResource);
        meteorLockOnModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);
    meteorLockOnInstanceCount--;
}

void ExBossMeteorLockOn_Main_Init(void)
{
    exBossMeteLockOnTask *work = ExTaskGetWorkCurrent(exBossMeteLockOnTask);

    meteorLockOnTaskSingleton = GetCurrentTask();
    work->exploded            = FALSE;

    LoadExBossMeteorLockOnAssets(&work->animator);
    SetExDrawRequestPriority(&work->animator.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExBossMeteorLockOnAnim(&work->animator, ex_effe_targ1);
    SetExDrawRequestAnimAsOneShot(&work->animator.config);

    work->animator.model.translation.x = work->parent->aniBoss.model.translation.x;
    work->animator.model.translation.y = work->parent->aniBoss.model.translation.y;
    work->animator.model.translation.z = FLOAT_TO_FX32(65.0);

    work->animator.model.scale.x = FLOAT_TO_FX32(16.0);
    work->animator.model.scale.y = FLOAT_TO_FX32(16.0);
    work->animator.model.scale.z = FLOAT_TO_FX32(16.0);

    work->targetScale = FLOAT_TO_FX32(0.0);

    SetCurrentExTaskMainEvent(ExBossMeteorLockOn_Main_Appear);
}

void ExBossMeteorLockOn_TaskUnknown(void)
{
    exBossMeteLockOnTask *work = ExTaskGetWorkCurrent(exBossMeteLockOnTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBossMeteorLockOn_Destructor(void)
{
    exBossMeteLockOnTask *work = ExTaskGetWorkCurrent(exBossMeteLockOnTask);

    ReleaseExBossMeteorLockOnAssets(&work->animator);
    meteorLockOnTaskSingleton = NULL;
}

void ExBossMeteorLockOn_Main_Appear(void)
{
    exBossMeteLockOnTask *work = ExTaskGetWorkCurrent(exBossMeteLockOnTask);

    AnimateExDrawRequestModel(&work->animator);
    if (exBossHelpers__IsBossFleeing() == TRUE)
    {
        ExBossMeteorLockOn_Action_Explode();
    }
    else
    {
        work->animator.model.translation.x = GetExPlayerPosition()->x;
        work->animator.model.translation.y = GetExPlayerPosition()->y;
        work->animator.model.translation.z = meteorLockOnPosition.z + FLOAT_TO_FX32(5.0);

        work->targetScale += FLOAT_TO_FX32(0.125);

        work->animator.model.scale.x = FLOAT_TO_FX32(16.0) + MultiplyFX(-FLOAT_TO_FX32(15.5), work->targetScale);
        work->animator.model.scale.y = FLOAT_TO_FX32(16.0) + MultiplyFX(-FLOAT_TO_FX32(15.5), work->targetScale);
        work->animator.model.scale.z = FLOAT_TO_FX32(16.0) + MultiplyFX(-FLOAT_TO_FX32(15.5), work->targetScale);

        if (work->targetScale >= FLOAT_TO_FX32(1.0))
        {
            work->animator.model.scale.x = FLOAT_TO_FX32(8.0);
            work->animator.model.scale.y = FLOAT_TO_FX32(8.0);
            work->animator.model.scale.z = FLOAT_TO_FX32(8.0);

            work->targetScale = FLOAT_TO_FX32(0.0);

            SetCurrentExTaskMainEvent(ExBossMeteorLockOn_Main_FinishAppearing);
            AddExDrawRequest(&work->animator, &work->animator.config);
        }

        AddExDrawRequest(&work->animator, &work->animator.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBossMeteorLockOn_Main_FinishAppearing(void)
{
    exBossMeteLockOnTask *work = ExTaskGetWorkCurrent(exBossMeteLockOnTask);

    AnimateExDrawRequestModel(&work->animator);
    if (exBossHelpers__IsBossFleeing() == TRUE)
    {
        ExBossMeteorLockOn_Action_Explode();
    }
    else
    {
        work->animator.model.translation.x = GetExPlayerPosition()->x;
        work->animator.model.translation.y = GetExPlayerPosition()->y;
        work->animator.model.translation.z = meteorLockOnPosition.z + FLOAT_TO_FX32(5.0);

        work->targetScale += FLOAT_TO_FX32(0.1);

        work->animator.model.scale.x = MultiplyFX(-FLOAT_TO_FX32(7.0), work->targetScale) + FLOAT_TO_FX32(8.0);
        work->animator.model.scale.y = MultiplyFX(-FLOAT_TO_FX32(7.0), work->targetScale) + FLOAT_TO_FX32(8.0);
        work->animator.model.scale.z = MultiplyFX(-FLOAT_TO_FX32(7.0), work->targetScale) + FLOAT_TO_FX32(8.0);

        if (work->targetScale >= FLOAT_TO_FX32(1.0))
        {
            ExBossMeteorLockOn_Action_TargetPlayer();
        }
        else
        {
            AddExDrawRequest(&work->animator, &work->animator.config);

            RunCurrentExTaskUnknownEvent();
        }
    }
}

void ExBossMeteorLockOn_Action_TargetPlayer(void)
{
    exBossMeteLockOnTask *work = ExTaskGetWorkCurrent(exBossMeteLockOnTask);

    work->animator.model.scale.x = FLOAT_TO_FX32(1.0);
    work->animator.model.scale.y = FLOAT_TO_FX32(1.0);
    work->animator.model.scale.z = FLOAT_TO_FX32(1.0);

    work->timer = 10;

    SetCurrentExTaskMainEvent(ExBossMeteorLockOn_Main_TargetPlayer);
    ExBossMeteorLockOn_Main_TargetPlayer();
}

void ExBossMeteorLockOn_Main_TargetPlayer(void)
{
    exBossMeteLockOnTask *work = ExTaskGetWorkCurrent(exBossMeteLockOnTask);

    AnimateExDrawRequestModel(&work->animator);
    if (exBossHelpers__IsBossFleeing() == TRUE)
    {
        ExBossMeteorLockOn_Action_Explode();
    }
    else
    {
        if (work->timer > 0)
        {
            work->animator.model.translation.x += mtMoveTowards(FLOAT_TO_FX32(0.4), work->animator.model.translation.x, GetExPlayerPosition()->x);
            work->animator.model.translation.y += mtMoveTowards(FLOAT_TO_FX32(0.4), work->animator.model.translation.y, GetExPlayerPosition()->y);
            work->animator.model.translation.z = FLOAT_TO_FX32(65.0);
        }

        if (work->timer >= -23)
        {
            work->animator.model.translation.x += mtMoveTowards(FLOAT_TO_FX32(0.04004), work->animator.model.translation.x, GetExPlayerPosition()->x);
            work->animator.model.translation.y += mtMoveTowards(FLOAT_TO_FX32(0.04004), work->animator.model.translation.y, GetExPlayerPosition()->y);
            work->animator.model.translation.z = FLOAT_TO_FX32(65.0);
            work->timer--;
        }
        else
        {
            work->timer = 10;
        }

        if (work->parent->magmaEruptionTimer <= 10)
        {
            ExBossMeteorLockOn_Action_LockOn();
        }
        else
        {
            AddExDrawRequest(&work->animator, &work->animator.config);

            RunCurrentExTaskUnknownEvent();
        }
    }
}

void ExBossMeteorLockOn_Action_LockOn(void)
{
    exBossMeteLockOnTask *work = ExTaskGetWorkCurrent(exBossMeteLockOnTask);

    void *mdlResource = work->animator.model.animator.renderObj.resMdl;
    SetExBossMeteorLockOnAnim(&work->animator, ex_effe_targ2);
    SetExDrawRequestAnimStopOnFinish(&work->animator.config);

    meteorLockOnPosition.x = work->animator.model.translation.x;
    meteorLockOnPosition.y = work->animator.model.translation.y;
    meteorLockOnPosition.z = work->animator.model.translation.z;

    NNS_G3dMdlSetMdlDiffAll(mdlResource, GX_RGB_888(0xFF, 0x00, 0x00));

    SetCurrentExTaskMainEvent(ExBossMeteorLockOn_Main_LockedOn);
    ExBossMeteorLockOn_Main_LockedOn();
}

void ExBossMeteorLockOn_Main_LockedOn(void)
{
    exBossMeteLockOnTask *work = ExTaskGetWorkCurrent(exBossMeteLockOnTask);

    if (work->animator.model.primaryAnimResource->frame < FLOAT_TO_FX32(10.0))
        AnimateExDrawRequestModel(&work->animator);
    else
        Stop3DExDrawRequestAnimation(&work->animator.config);

    if (work->exploded)
    {
        ExBossMeteorLockOn_Action_Explode();
    }
    else if (exBossHelpers__IsBossFleeing() == TRUE)
    {
        ExBossMeteorLockOn_Action_Explode();
    }
    else
    {
        AddExDrawRequest(&work->animator, &work->animator.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBossMeteorLockOn_Action_Explode(void)
{
    exBossMeteLockOnTask *work = ExTaskGetWorkCurrent(exBossMeteLockOnTask);

    void *mdlResource = work->animator.model.animator.renderObj.resMdl;
    SetExBossMeteorLockOnAnim(&work->animator, ex_effe_targ3);
    SetExDrawRequestAnimStopOnFinish(&work->animator.config);
    NNS_G3dMdlSetMdlDiffAll(mdlResource, GX_RGB_888(0x00, 0x00, 0xFF));

    SetCurrentExTaskMainEvent(ExBossMeteorLockOn_Main_Exploded);
    ExBossMeteorLockOn_Main_Exploded();

    RunCurrentExTaskUnknownEvent();
}

void ExBossMeteorLockOn_Main_Exploded(void)
{
    exBossMeteLockOnTask *work = ExTaskGetWorkCurrent(exBossMeteLockOnTask);

    AnimateExDrawRequestModel(&work->animator);
    if (IsExDrawRequestModelAnimFinished(&work->animator))
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->animator, &work->animator.config);

        RunCurrentExTaskUnknownEvent();
    }
}

BOOL CreateExBossMeteorLockOn(void)
{
    Task *task = ExTaskCreate(ExBossMeteorLockOn_Main_Init, ExBossMeteorLockOn_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exBossMeteLockOnTask);

    exBossMeteLockOnTask *work = ExTaskGetWork(task, exBossMeteLockOnTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);
    SetExTaskUnknownEvent(task, ExBossMeteorLockOn_TaskUnknown);

    work->parent->currentMeteor->lockOn = work;

    return TRUE;
}

BOOL LoadExBossMeteorAssets(EX_ACTION_NN_WORK *work)
{
    meteorLastSpawnedWorker = work;

    if (meteorModelFileSize != 0 && meteorTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < meteorModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < meteorTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < meteorModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (meteorInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_METEF_NSBMD, &meteorModelResource, &meteorModelFileSize, TRUE, FALSE);

        meteorAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_METEF_NSBCA);
        meteorAnimType[0]     = B3D_ANIM_JOINT_ANIM;

        Asset3DSetup__Create(meteorModelResource);
    }

    AnimatorMDL *animator = &work->model.animator;
    AnimatorMDL__Init(animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(animator, meteorModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < ARRAY_COUNT(meteorAnimType); i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, meteorAnimType[i], meteorAnimResource[i], 0, NULL);
    }

    work->model.primaryAnimType     = meteorAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[meteorAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(0.0);

    work->model.scale.x = FLOAT_TO_FX32(1.0);
    work->model.scale.y = FLOAT_TO_FX32(1.0);
    work->model.scale.z = FLOAT_TO_FX32(1.0);

    work->model.angle.x = FLOAT_DEG_TO_IDX(89.98);
    work->model.angle.z = FLOAT_DEG_TO_IDX(179.96);

    work->hitChecker.type               = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.flags.isBossMeteor = TRUE;
    work->hitChecker.box.size.x         = FLOAT_TO_FX32(5.0);
    work->hitChecker.box.size.y         = FLOAT_TO_FX32(5.0);
    work->hitChecker.box.size.z         = FLOAT_TO_FX32(5.0);
    work->hitChecker.box.position       = &work->model.translation;

    meteorInstanceCount++;

    return TRUE;
}

void ReleaseExBossMeteorAssets(EX_ACTION_NN_WORK *work)
{
    if (meteorInstanceCount <= 1)
    {
        if (meteorModelResource)
            NNS_G3dResDefaultRelease(meteorModelResource);

        if (meteorAnimResource[0])
            NNS_G3dResDefaultRelease(meteorAnimResource[0]);

        if (meteorModelResource)
            HeapFree(HEAP_USER, meteorModelResource);
        meteorModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);
    meteorInstanceCount--;
}

void ExBossMeteor_Main_Init(void)
{
    exBossMeteMeteoTask *work = ExTaskGetWorkCurrent(exBossMeteMeteoTask);

    meteorTaskSingleton = GetCurrentTask();

    LoadExBossMeteorAssets(&work->animator);
    SetExDrawRequestPriority(&work->animator.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->animator.config);

    work->animator.model.translation.x = work->parent->aniBoss.model.translation4.x;
    work->animator.model.translation.y = work->parent->aniBoss.model.translation4.y;
    work->animator.model.translation.z = FLOAT_TO_FX32(67.351806640625);

    work->startPosition.x = work->animator.model.translation.x;
    work->startPosition.y = work->animator.model.translation.y;
    work->startPosition.z = work->animator.model.translation.z;

    work->targetPosition.x = meteorLockOnPosition.x;
    work->targetPosition.y = meteorLockOnPosition.y;
    work->targetPosition.z = FLOAT_TO_FX32(60.0);

    exPlayerHelpers__Func_2152FB0(&work->int568, &work->startPosition, &work->targetPosition, 0.00078125f, 1.0f);

    work->field_28.x = 1;
    work->field_28.y = 1 + (mtMathRand() % 2);
    work->field_2E.x = 1;
    work->angle.x    = 0;
    work->field_2E.y = 3 + (mtMathRand() % 3);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_METEORITE);

    work->exploded = FALSE;

    SetCurrentExTaskMainEvent(ExBossMeteor_Main_FallToLockOnPos);
}

void ExBossMeteor_TaskUnknown(void)
{
    exBossMeteMeteoTask *work = ExTaskGetWorkCurrent(exBossMeteMeteoTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBossMeteor_Destructor(void)
{
    exBossMeteMeteoTask *work = ExTaskGetWorkCurrent(exBossMeteMeteoTask);

    work->exploded = TRUE;

    ReleaseExBossMeteorAssets(&work->animator);
    meteorTaskSingleton = NULL;
}

void ExBossMeteor_Main_FallToLockOnPos(void)
{
    exBossMeteMeteoTask *work = ExTaskGetWorkCurrent(exBossMeteMeteoTask);

    AnimateExDrawRequestModel(&work->animator);
    if (work->animator.hitChecker.hitFlags.hasCollision && work->animator.hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
    {
        ExBossMeteor_Action_Explode();
    }
    else if (exPlayerHelpers__Func_21530FC(&work->int568, &work->animator.model.translation, TRUE) && work->animator.model.translation.z <= FLOAT_TO_FX32(60.0))
    {
        ExBossMeteor_Action_Impact();
    }
    else if (exBossHelpers__IsBossFleeing() == TRUE)
    {
        CreateExExplosion(&work->animator.model.translation);

        DestroyCurrentExTask();
    }
    else
    {
        work->animator.model.angle.x = exPlayerHelpers__Func_2152E28(work->int568.step.z, work->int568.step.y);
        work->animator.model.angle.z = exPlayerHelpers__Func_2152E28(work->int568.step.x, work->int568.step.y);

        if (Camera3D__UseEngineA() == FALSE)
            exPlayerHelpers__Func_2152D28(&work->angle, &work->field_28, &work->field_2E, 0);

        work->animator.model.angle.x += work->angle.x;
        work->animator.config.control.timer = 10;
        AddExDrawRequest(&work->animator, &work->animator.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBossMeteor_Action_Impact(void)
{
    exBossMeteMeteoTask *work = ExTaskGetWorkCurrent(exBossMeteMeteoTask);

    work->animator.model.translation.x = meteorLockOnPosition.x;
    work->animator.model.translation.y = meteorLockOnPosition.y;
    work->animator.model.translation.z = FLOAT_TO_FX32(60.0);

    work->timer = 3;

    SetCurrentExTaskMainEvent(ExBossMeteor_Main_Impact);
    ExBossMeteor_Main_Impact();
}

void ExBossMeteor_Main_Impact(void)
{
    exBossMeteMeteoTask *work = ExTaskGetWorkCurrent(exBossMeteMeteoTask);

    AnimateExDrawRequestModel(&work->animator);
    if (work->animator.hitChecker.hitFlags.hasCollision && work->animator.hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
    {
        ExBossMeteor_Action_Explode();
    }
    else if (exBossHelpers__IsBossFleeing() == TRUE)
    {
        CreateExExplosion(&work->animator.model.translation);
        DestroyCurrentExTask();
    }
    else if (work->timer <= 0)
    {
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_MAGMA_LANDING);
        CreateExBossMeteorBomb(&work->animator.model.translation);

        DestroyCurrentExTask();
    }
    else
    {
        work->animator.config.control.timer = 10;
        AddExDrawRequest(&work->animator, &work->animator.config);
        exHitCheckTask_AddHitCheck(&work->animator.hitChecker);
        work->timer--;
    }
}

void ExBossMeteor_Action_Explode(void)
{
    exBossMeteMeteoTask *work = ExTaskGetWorkCurrent(exBossMeteMeteoTask);

    work->animator.hitChecker.hitFlags.hasCollision = FALSE;
    work->animator.hitChecker.field_4.value_4_2  = TRUE;

    work->velocity.y = FLOAT_TO_FX32(0.5);

    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        if (work->animator.hitChecker.power == EXPLAYER_BARRIER_REGULAR_POWER_NORMAL)
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(4.0), work->velocity.y);
        }
        else
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(6.0), work->velocity.y);
        }
    }
    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
    {
        if (work->animator.hitChecker.power == EXPLAYER_BARRIER_REGULAR_POWER_EASY)
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(4.0), work->velocity.y);
        }
        else
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(6.0), work->velocity.y);
        }
    }

    work->field_2E.y *= 3;
    work->animator.model.angle.x = FLOAT_DEG_TO_IDX(44.99);
    work->exploded               = TRUE;

    SetCurrentExTaskMainEvent(ExBossMeteor_Main_Explode);
    ExBossMeteor_Main_Explode();
}

void ExBossMeteor_Main_Explode(void)
{
    exBossMeteMeteoTask *work = ExTaskGetWorkCurrent(exBossMeteMeteoTask);

    AnimateExDrawRequestModel(&work->animator);

    work->animator.model.translation.y += work->velocity.y;
    work->animator.config.control.timer = 10;

    exPlayerHelpers__Func_2152D28(&work->animator.model.angle, &work->field_28, &work->field_2E, 1);

    if (work->animator.model.translation.x >= FLOAT_TO_FX32(90.0) || work->animator.model.translation.x <= -FLOAT_TO_FX32(90.0)
        || work->animator.model.translation.y >= FLOAT_TO_FX32(200.0))
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->animator, &work->animator.config);
        if (work->animator.hitChecker.hitFlags.hasCollision == FALSE)
            exHitCheckTask_AddHitCheck(&work->animator.hitChecker);
    }
}

BOOL CreateExBossMeteor(void)
{
    Task *task =
        ExTaskCreate(ExBossMeteor_Main_Init, ExBossMeteor_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exBossMeteMeteoTask);

    exBossMeteMeteoTask *work = ExTaskGetWork(task, exBossMeteMeteoTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);
    SetExTaskUnknownEvent(task, ExBossMeteor_TaskUnknown);

    work->parent->currentMeteor->meteor = work;

    return TRUE;
}

void ExBossMeteorAdmin_Main_Init(void)
{
    exBossMeteAdminTask *work = ExTaskGetWorkCurrent(exBossMeteAdminTask);
    UNUSED(work);

    meteorAdminTaskSingleton = GetCurrentTask();

    SetCurrentExTaskMainEvent(ExBossMeteorAdmin_Main_WaitForLockOn);
    ExBossMeteorAdmin_Main_WaitForLockOn();
}

void ExBossMeteorAdmin_TaskUnknown(void)
{
    exBossMeteAdminTask *work = ExTaskGetWorkCurrent(exBossMeteAdminTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBossMeteorAdmin_Destructor(void)
{
    exBossMeteAdminTask *work = ExTaskGetWorkCurrent(exBossMeteAdminTask);
    UNUSED(work);

    meteorAdminTaskSingleton = NULL;
}

void ExBossMeteorAdmin_Main_WaitForLockOn(void)
{
    exBossMeteAdminTask *work = ExTaskGetWorkCurrent(exBossMeteAdminTask);

    if (work->lockOn != NULL)
    {
        ExBossMeteorAdmin_Action_WaitForMeteor();
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExBossMeteorAdmin_Action_WaitForMeteor(void)
{
    exBossMeteAdminTask *work = ExTaskGetWorkCurrent(exBossMeteAdminTask);
    UNUSED(work);

    SetCurrentExTaskMainEvent(ExBossMeteorAdmin_Main_WaitForMeteor);
    ExBossMeteorAdmin_Main_WaitForMeteor();
}

void ExBossMeteorAdmin_Main_WaitForMeteor(void)
{
    exBossMeteAdminTask *work = ExTaskGetWorkCurrent(exBossMeteAdminTask);

    if (work->meteor != NULL)
    {
        ExBossMeteorAdmin_Action_WaitForExplosion();
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExBossMeteorAdmin_Action_WaitForExplosion(void)
{
    exBossMeteAdminTask *work = ExTaskGetWorkCurrent(exBossMeteAdminTask);
    UNUSED(work);

    SetCurrentExTaskMainEvent(ExBossMeteorAdmin_Main_WaitForExplosion);
    ExBossMeteorAdmin_Main_WaitForExplosion();
}

void ExBossMeteorAdmin_Main_WaitForExplosion(void)
{
    exBossMeteAdminTask *work = ExTaskGetWorkCurrent(exBossMeteAdminTask);

    exBossMeteMeteoTask *meteor  = work->meteor;
    exBossMeteLockOnTask *lockOn = work->lockOn;
    if (meteor->exploded)
    {
        lockOn->exploded = TRUE;

        DestroyCurrentExTask();
    }

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExBossMeteorAdmin(void)
{
    exBossSysAdminTask *parent = ExTaskGetWorkCurrent(exBossSysAdminTask);

    Task *task = ExTaskCreate(ExBossMeteorAdmin_Main_Init, ExBossMeteorAdmin_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3200, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exBossMeteAdminTask);

    exBossMeteAdminTask *work = ExTaskGetWork(task, exBossMeteAdminTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExBossMeteorAdmin_TaskUnknown);

    parent->currentMeteor = work;
    work->meteor          = NULL;
    work->lockOn          = NULL;
    work->unknown         = NULL;

    return TRUE;
}

// ExBoss
void exBossSysAdminTask__RunTaskUnknownEvent(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    RunCurrentExTaskUnknownEvent();
}

void exBossSysAdminTask__Action_StartMete0(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    exBossHelpers__SetAnimation(&work->aniBoss, bse_body_mete0);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    CreateExBossEffectFire();
    PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_E_KURAE);
    CreateExBossMeteorAdmin();

    SetCurrentExTaskMainEvent(exBossSysAdminTask__Main_Mete0);
    exBossSysAdminTask__Main_Mete0();

    exBossSysAdminTask__RunTaskUnknownEvent();
}

void exBossSysAdminTask__Main_Mete0(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        exBossSysAdminTask__Action_StartMete1();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
        exBossSysAdminTask__RunTaskUnknownEvent();
    }
}

void exBossSysAdminTask__Action_StartMete1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->magmaEruptionTimer = SECONDS_TO_FRAMES(3.5);

    exBossHelpers__SetAnimation(&work->aniBoss, bse_body_mete1);
    SetExDrawRequestAnimAsOneShot(&work->aniBoss.config);
    CreateExBossMeteorLockOn();

    SetCurrentExTaskMainEvent(exBossSysAdminTask__Main_Mete1);
    exBossSysAdminTask__Main_Mete1();

    exBossSysAdminTask__RunTaskUnknownEvent();
}

void exBossSysAdminTask__Main_Mete1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    if (work->magmaEruptionTimer-- < 0)
    {
        exBossSysAdminTask__Action_StartMete2();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
        exBossSysAdminTask__RunTaskUnknownEvent();
    }
}

void exBossSysAdminTask__Action_StartMete2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->magmaEruptionTimer = 0;

    DisableExBossEffectFire();
    exBossHelpers__SetAnimation(&work->aniBoss, bse_body_mete2);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(exBossSysAdminTask__Main_StartMete2);
    exBossSysAdminTask__Main_StartMete2();

    exBossSysAdminTask__RunTaskUnknownEvent();
}

void exBossSysAdminTask__Main_StartMete2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (work->aniBoss.model.primaryAnimResource->frame >= FLOAT_TO_FX32(15.0))
    {
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_PREPARE);

        SetCurrentExTaskMainEvent(exBossSysAdminTask__Main_HandleMete2);
        exBossSysAdminTask__Main_HandleMete2();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
        exBossSysAdminTask__RunTaskUnknownEvent();
    }
}

void exBossSysAdminTask__Main_HandleMete2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (work->aniBoss.model.primaryAnimResource->frame == FLOAT_TO_FX32(35.0))
    {
        exBossSysAdminTask__Action_CreateMeteor();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
        exBossSysAdminTask__RunTaskUnknownEvent();
    }
}

void exBossSysAdminTask__Action_CreateMeteor(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    CreateExBossMeteor();

    SetCurrentExTaskMainEvent(exBossSysAdminTask__Main_FinishMete2);
    exBossSysAdminTask__Main_FinishMete2();

    exBossSysAdminTask__RunTaskUnknownEvent();
}

void exBossSysAdminTask__Main_FinishMete2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        exBossSysAdminTask__Action_FinishMeteorAttack();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
        exBossSysAdminTask__RunTaskUnknownEvent();
    }
}

void exBossSysAdminTask__Action_FinishMeteorAttack(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->nextAttackState();
}