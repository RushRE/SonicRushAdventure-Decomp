#include <ex/exBossFireRed.h>
#include <ex/exBossFireBlue.h>
#include <ex/exPlayerHelpers.h>
#include <ex/exSysTask.h>
#include <game/audio/audioSystem.h>
#include <game/file/binaryBundle.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

static s16 fireballBlueInstanceCount;
static s16 fireballRedInstanceCount;
static u32 fireballRedModelFileSize;
static void *fireballBlueLastSpawnedWorker;
static Task *fireballRedLastSpawnedTask;
static u32 fireballRedTextureFileSize;
static u32 fireballBlueUnused;
static void *fireballBlueModelResource;
static EX_ACTION_NN_WORK *fireballRedLastSpawnedWorker;
static void *fireballRedModelResource;
static u32 fireballRedUnused;
static Task *fireballBlueLastSpawnedTask;
static u32 fireballBlueTextureFileSize;
static u32 fireballBlueModelFileSize;
static void *fireballRedAnimResource[4];
static void *fireballBlueAnimResource[4];
static u32 fireballBlueAnimType[4];
static u32 fireballRedAnimType[4];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(fireballRedUnused)
FORCE_INCLUDE_VARIABLE_BSS(fireballBlueUnused)

// --------------------
// FUNCTION DECLS
// --------------------

// Blue Fireball
static BOOL LoadExBossFireBlueAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBossFireBlueAssets(EX_ACTION_NN_WORK *work);
static void ExBossFireBlue_Main_Init(void);
static void ExBossFireBlue_TaskUnknown(void);
static void ExBossFireBlue_Destructor(void);
static void ExBossFireBlue_Main_MoveFast(void);
static void ExBossFireBlue_Action_SlowDown(void);
static void ExBossFireBlue_Main_MoveSlow(void);
static void ExBossFireBlue_Action_Repelled(void);
static void ExBossFireBlue_Main_Repelled(void);

// Red Fireball
static BOOL LoadExBossFireRedAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBossFireRedAssets(EX_ACTION_NN_WORK *work);
static void ExBossFireRed_Main_Init(void);
static void ExBossFireRed_TaskUnknown(void);
static void ExBossFireRed_Destructor(void);
static void ExBossFireRed_Main_MoveFast(void);
static void ExBossFireRed_Action_SlowDown(void);
static void ExBossFireRed_Main_MoveSlow(void);
static void ExBossFireRed_Action_Repelled(void);
static void ExBossFireRed_Main_Repelled(void);

// --------------------
// FUNCTIONS
// --------------------

BOOL LoadExBossFireBlueAssets(EX_ACTION_NN_WORK *work)
{
    fireballBlueLastSpawnedWorker = work;

    if (fireballBlueModelFileSize != 0 && fireballBlueTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < fireballBlueModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < fireballBlueTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < fireballBlueModelFileSize)
            return FALSE;
    }

    exDrawReqTask__InitModel(work);
    if (fireballBlueInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_FIRE2_NSBMD, &fireballBlueModelResource, &fireballBlueModelFileSize, TRUE);

        fireballBlueAnimResource[0] = exSysTask__LoadExFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE2_NSBMA);
        fireballBlueAnimType[0]     = B3D_ANIM_MAT_ANIM;

        fireballBlueAnimResource[1] = exSysTask__LoadExFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE2_NSBVA);
        fireballBlueAnimType[1]     = B3D_ANIM_VIS_ANIM;

        fireballBlueAnimResource[2] = exSysTask__LoadExFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE2_NSBTA);
        fireballBlueAnimType[2]     = B3D_ANIM_TEX_ANIM;

        fireballBlueAnimResource[3] = exSysTask__LoadExFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE2_NSBTP);
        fireballBlueAnimType[3]     = B3D_ANIM_PAT_ANIM;

        Asset3DSetup__Create(fireballBlueModelResource);
    }

    AnimatorMDL *animator = &work->model.animator;
    AnimatorMDL__Init(animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(animator, fireballBlueModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(animator, fireballBlueAnimType[i], fireballBlueAnimResource[i], 0, NULL);
    }

    AnimatorMDL__SetAnimation(animator, fireballBlueAnimType[i], fireballBlueAnimResource[i], 0, NNS_G3dGetTex(fireballBlueModelResource));

    work->model.field_32C = fireballBlueAnimType[0];
    work->model.field_328 = work->model.animator.currentAnimObj[fireballBlueAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }
    work->model.translation.z = FLOAT_TO_FX32(0.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = FLOAT_DEG_TO_IDX(89.98);
    work->hitChecker.field_0  = 1;
    work->hitChecker.field_2 |= 4;
    work->hitChecker.box.size.x   = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.size.y   = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.size.z   = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.position = &work->model.translation;

    fireballBlueInstanceCount++;

    return TRUE;
}

void ReleaseExBossFireBlueAssets(EX_ACTION_NN_WORK *work)
{
    if (fireballBlueInstanceCount <= 1)
    {
        if (fireballBlueModelResource != NULL)
            NNS_G3dResDefaultRelease(fireballBlueModelResource);

        if (fireballBlueAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(fireballBlueAnimResource[0]);

        if (fireballBlueAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(fireballBlueAnimResource[1]);

        if (fireballBlueAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(fireballBlueAnimResource[2]);

        if (fireballBlueAnimResource[3] != NULL)
            NNS_G3dResDefaultRelease(fireballBlueAnimResource[3]);

        if (fireballBlueModelResource != NULL)
            HeapFree(HEAP_USER, fireballBlueModelResource);
        fireballBlueModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);
    fireballBlueInstanceCount--;
}

void ExBossFireBlue_Main_Init(void)
{
    exBossFireBlueTask *work = ExTaskGetWorkCurrent(exBossFireBlueTask);

    fireballBlueLastSpawnedTask = GetCurrentTask();
    LoadExBossFireBlueAssets(&work->animator);
    exDrawReqTask__SetConfigPriority(&work->animator.config, 0xA800);
    exDrawReqTask__Func_2164218(&work->animator.config);

    work->animator.model.translation.x = work->parent->aniBoss.model.field_364.x;
    work->animator.model.translation.y = work->parent->aniBoss.model.field_364.y;
    work->animator.model.translation.z = work->parent->aniBoss.model.field_364.z;

    work->targetPos.x = work->parent->field_48;
    work->targetPos.y = work->parent->field_4C;
    work->targetPos.z = FLOAT_TO_FX32(60.0);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_FIREBALL);

    SetCurrentExTaskMainEvent(ExBossFireBlue_Main_MoveFast);
}

void ExBossFireBlue_TaskUnknown(void)
{
    exBossFireBlueTask *work = ExTaskGetWorkCurrent(exBossFireBlueTask);

    if (exSysTask__GetFlag_2178650())
        DestroyCurrentExTask();
}

void ExBossFireBlue_Destructor(void)
{
    exBossFireBlueTask *work = ExTaskGetWorkCurrent(exBossFireBlueTask);

    ReleaseExBossFireBlueAssets(&work->animator);
    fireballBlueLastSpawnedTask = NULL;
}

void ExBossFireBlue_Main_MoveFast(void)
{
    exBossFireBlueTask *work = ExTaskGetWorkCurrent(exBossFireBlueTask);

    exDrawReqTask__Model__Animate(&work->animator);

    if (work->animator.hitChecker.hitFlags.value_1)
    {
        if (work->animator.hitChecker.field_0 == 2)
        {
            ExBossFireBlue_Action_Repelled();
            return;
        }

        work->animator.hitChecker.hitFlags.value_1 = FALSE;
    }
    else
    {
        if (work->animator.hitChecker.hitFlags.value_10)
        {
            DestroyCurrentExTask();
            return;
        }
    }

    fx32 lastX = work->animator.model.translation.x;
    fx32 lastY = work->animator.model.translation.y;
    fx32 lastZ = work->animator.model.translation.z;

    work->animator.model.translation.x += MultiplyFX(FLOAT_TO_FX32(0.1001), work->targetPos.x - work->animator.model.translation.x);
    work->animator.model.translation.y += MultiplyFX(FLOAT_TO_FX32(0.1001), work->targetPos.y - work->animator.model.translation.y);
    work->animator.model.translation.z += MultiplyFX(FLOAT_TO_FX32(0.1001), work->targetPos.z - work->animator.model.translation.z);

    work->velocity.x = work->animator.model.translation.x - lastX;
    work->velocity.y = work->animator.model.translation.y - lastY;
    work->velocity.z = work->animator.model.translation.z - lastZ;

    s32 y = (work->animator.model.translation.y - work->targetPos.y);
    s32 x = (work->animator.model.translation.x - work->targetPos.x);

    x = MATH_ABS(x);
    y = MATH_ABS(y);

    s32 distance;
    if (x > y)
        distance = MultiplyFX(FLOAT_TO_FX32(0.96045), x) + MultiplyFX(FLOAT_TO_FX32(0.3978), y);
    else
        distance = MultiplyFX(FLOAT_TO_FX32(0.96045), y) + MultiplyFX(FLOAT_TO_FX32(0.3978), x);

    if (distance < FLOAT_TO_FX32(15.0))
    {
        ExBossFireBlue_Action_SlowDown();
    }
    else
    {
        work->animator.model.angle.x = exPlayerHelpers__Func_2152E28(work->velocity.z, work->velocity.y);
        work->animator.model.angle.z = exPlayerHelpers__Func_2152E28(work->velocity.x, work->velocity.y);
        exDrawReqTask__AddRequest(&work->animator.hitChecker, &work->animator.config);
        exHitCheckTask__AddHitCheck(&work->animator.hitChecker);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBossFireBlue_Action_SlowDown(void)
{
    exBossFireBlueTask *work = ExTaskGetWorkCurrent(exBossFireBlueTask);

    SetCurrentExTaskMainEvent(ExBossFireBlue_Main_MoveSlow);

    ExBossFireBlue_Main_MoveSlow();
}

void ExBossFireBlue_Main_MoveSlow(void)
{
    exBossFireBlueTask *work = ExTaskGetWorkCurrent(exBossFireBlueTask);

    exDrawReqTask__Model__Animate(&work->animator);

    if (work->animator.hitChecker.hitFlags.value_1)
    {
        if (work->animator.hitChecker.field_0 == 2)
        {
            ExBossFireBlue_Action_Repelled();
            return;
        }

        work->animator.hitChecker.hitFlags.value_1 = FALSE;
    }
    else
    {
        if (work->animator.hitChecker.hitFlags.value_10)
        {
            DestroyCurrentExTask();
            return;
        }
    }
    work->animator.model.translation.x += work->velocity.x;
    work->animator.model.translation.y += work->velocity.y;
    work->animator.model.angle.x = exPlayerHelpers__Func_2152E28(work->velocity.z, work->velocity.y);
    work->animator.model.angle.z = exPlayerHelpers__Func_2152E28(work->velocity.x, work->velocity.y);

    if ((work->animator.model.translation.x >= FLOAT_TO_FX32(90.0) || work->animator.model.translation.x <= -FLOAT_TO_FX32(90.0))
        || (work->animator.model.translation.y >= FLOAT_TO_FX32(200.0) || work->animator.model.translation.y <= -FLOAT_TO_FX32(60.0)))
    {
        DestroyCurrentExTask();
    }
    else
    {
        exDrawReqTask__AddRequest(&work->animator.hitChecker, &work->animator.config);
        exHitCheckTask__AddHitCheck(&work->animator.hitChecker);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBossFireBlue_Action_Repelled(void)
{
    exBossFireBlueTask *work = ExTaskGetWorkCurrent(exBossFireBlueTask);

    work->animator.hitChecker.hitFlags.value_1 = FALSE;
    work->animator.hitChecker.field_4 |= 2;
    work->velocity.x = 0;

    if (exSysTask__GetStatus()->difficulty == 1)
    {
        if (work->animator.hitChecker.field_8 == 6)
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(4.0), work->velocity.y);
        }
        else
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(6.0), work->velocity.y);
        }
    }
    else if (exSysTask__GetStatus()->difficulty == 2)
    {
        if (work->animator.hitChecker.field_8 == 7)
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(4.0), work->velocity.y);
        }
        else
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(6.0), work->velocity.y);
        }
    }

    work->velocity.y             = -work->velocity.y;
    work->velocity.z             = FLOAT_TO_FX32(0.0);
    work->animator.model.angle.x = FLOAT_DEG_TO_IDX(179.96);
    work->animator.model.angle.y = FLOAT_DEG_TO_IDX(0.0);
    work->animator.model.angle.z = FLOAT_DEG_TO_IDX(0.0);
    work->spinSpeed              = FLOAT_DEG_TO_IDX(29.993);

    if ((mtMathRand() % 2) != 0)
        work->spinDirection = 1;
    else
        work->spinDirection = 0;

    SetCurrentExTaskMainEvent(ExBossFireBlue_Main_Repelled);
    ExBossFireBlue_Main_Repelled();
}

void ExBossFireBlue_Main_Repelled(void)
{
    exBossFireBlueTask *work = ExTaskGetWorkCurrent(exBossFireBlueTask);

    exDrawReqTask__Model__Animate(&work->animator);

    if (work->animator.hitChecker.hitFlags.value_1)
    {
        DestroyCurrentExTask();
        return;
    }

    if (work->animator.hitChecker.hitFlags.value_10)
    {
        DestroyCurrentExTask();
        return;
    }

    if (work->spinDirection != 0)
        work->animator.model.angle.z += work->spinSpeed;
    else
        work->animator.model.angle.z -= work->spinSpeed;

    work->animator.model.translation.y += work->velocity.y;

    if ((work->animator.model.translation.x >= FLOAT_TO_FX32(90.0) || work->animator.model.translation.x <= -FLOAT_TO_FX32(90.0))
        || (work->animator.model.translation.y >= FLOAT_TO_FX32(200.0) || work->animator.model.translation.y <= -FLOAT_TO_FX32(60.0)))
    {
        DestroyCurrentExTask();
        return;
    }

    exDrawReqTask__AddRequest(&work->animator.hitChecker, &work->animator.config);
    exHitCheckTask__AddHitCheck(&work->animator.hitChecker);

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExBossFireBlue(void)
{
    Task *task =
        ExTaskCreate(ExBossFireBlue_Main_Init, ExBossFireBlue_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exBossFireBlueTask);

    exBossFireBlueTask *work = ExTaskGetWork(task, exBossFireBlueTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);
    SetExTaskUnknownEvent(task, ExBossFireBlue_TaskUnknown);

    return TRUE;
}

BOOL LoadExBossFireRedAssets(EX_ACTION_NN_WORK *work)
{
    fireballRedLastSpawnedWorker = work;

    if (fireballRedModelFileSize != 0 && fireballRedTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < fireballRedModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < fireballRedTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < fireballRedModelFileSize)
            return FALSE;
    }

    exDrawReqTask__InitModel(work);
    if (fireballRedInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_FIRE1_NSBMD, &fireballRedModelResource, &fireballRedModelFileSize, TRUE);

        fireballRedAnimResource[0] = exSysTask__LoadExFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE1_NSBMA);
        fireballRedAnimType[0]     = B3D_ANIM_MAT_ANIM;

        fireballRedAnimResource[1] = exSysTask__LoadExFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE1_NSBVA);
        fireballRedAnimType[1]     = B3D_ANIM_VIS_ANIM;

        fireballRedAnimResource[2] = exSysTask__LoadExFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE1_NSBTA);
        fireballRedAnimType[2]     = B3D_ANIM_TEX_ANIM;

        fireballRedAnimResource[3] = exSysTask__LoadExFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE1_NSBTP);
        fireballRedAnimType[3]     = B3D_ANIM_PAT_ANIM;

        Asset3DSetup__Create(fireballRedModelResource);
    }

    AnimatorMDL *animator = &work->model.animator;
    AnimatorMDL__Init(animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(animator, fireballRedModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < 3; i++)
    {
        AnimatorMDL__SetAnimation(animator, fireballRedAnimType[i], fireballRedAnimResource[i], 0, NULL);
    }

    AnimatorMDL__SetAnimation(animator, fireballRedAnimType[i], fireballRedAnimResource[i], 0, NNS_G3dGetTex(fireballRedModelResource));

    work->model.field_32C = fireballRedAnimType[0];
    work->model.field_328 = work->model.animator.currentAnimObj[fireballRedAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }
    work->model.translation.z = FLOAT_TO_FX32(0.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = FLOAT_DEG_TO_IDX(89.98);
    work->hitChecker.field_0  = 1;
    work->hitChecker.field_2 |= 2;
    work->hitChecker.box.size.x   = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.size.y   = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.size.z   = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.position = &work->model.translation;

    fireballRedInstanceCount++;

    return TRUE;
}

void ReleaseExBossFireRedAssets(EX_ACTION_NN_WORK *work)
{
    if (fireballRedInstanceCount <= 1)
    {
        if (fireballRedModelResource != NULL)
            NNS_G3dResDefaultRelease(fireballRedModelResource);

        if (fireballRedAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(fireballRedAnimResource[0]);

        if (fireballRedAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(fireballRedAnimResource[1]);

        if (fireballRedAnimResource[2] != NULL)
            NNS_G3dResDefaultRelease(fireballRedAnimResource[2]);

        if (fireballRedAnimResource[3] != NULL)
            NNS_G3dResDefaultRelease(fireballRedAnimResource[3]);

        if (fireballRedModelResource != NULL)
            HeapFree(HEAP_USER, fireballRedModelResource);
        fireballRedModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);
    fireballRedInstanceCount--;
}

void ExBossFireRed_Main_Init(void)
{
    exBossFireRedTask *work = ExTaskGetWorkCurrent(exBossFireRedTask);

    fireballRedLastSpawnedTask = GetCurrentTask();
    LoadExBossFireRedAssets(&work->animator);
    exDrawReqTask__SetConfigPriority(&work->animator.config, 0xA800);
    exDrawReqTask__Func_2164218(&work->animator.config);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_FIREBALL);

    work->animator.model.translation.x = work->parent->aniBoss.model.field_364.x;
    work->animator.model.translation.y = work->parent->aniBoss.model.field_364.y;
    work->animator.model.translation.z = work->parent->aniBoss.model.field_364.z;

    work->targetPos.x = work->parent->field_48;
    work->targetPos.y = work->parent->field_4C;
    work->targetPos.z = FLOAT_TO_FX32(60.0);

    SetCurrentExTaskMainEvent(ExBossFireRed_Main_MoveFast);
}

void ExBossFireRed_TaskUnknown(void)
{
    exBossFireRedTask *work = ExTaskGetWorkCurrent(exBossFireRedTask);

    if (exSysTask__GetFlag_2178650())
        DestroyCurrentExTask();
}

void ExBossFireRed_Destructor(void)
{
    exBossFireRedTask *work = ExTaskGetWorkCurrent(exBossFireRedTask);

    ReleaseExBossFireRedAssets(&work->animator);
    fireballRedLastSpawnedTask = NULL;
}

void ExBossFireRed_Main_MoveFast(void)
{
    exBossFireRedTask *work = ExTaskGetWorkCurrent(exBossFireRedTask);

    exDrawReqTask__Model__Animate(&work->animator);

    if (work->animator.hitChecker.hitFlags.value_1)
    {
        if (work->animator.hitChecker.field_0 == 2)
        {
            ExBossFireRed_Action_Repelled();
            return;
        }
    }
    else
    {
        if (work->animator.hitChecker.hitFlags.value_10)
        {
            DestroyCurrentExTask();
            return;
        }
    }

    fx32 lastX = work->animator.model.translation.x;
    fx32 lastY = work->animator.model.translation.y;
    fx32 lastZ = work->animator.model.translation.z;

    work->animator.model.translation.x += MultiplyFX(FLOAT_TO_FX32(0.05005), work->targetPos.x - work->animator.model.translation.x);
    work->animator.model.translation.y += MultiplyFX(FLOAT_TO_FX32(0.05005), work->targetPos.y - work->animator.model.translation.y);
    work->animator.model.translation.z += MultiplyFX(FLOAT_TO_FX32(0.05005), work->targetPos.z - work->animator.model.translation.z);

    work->velocity.x = work->animator.model.translation.x - lastX;
    work->velocity.y = work->animator.model.translation.y - lastY;
    work->velocity.z = work->animator.model.translation.z - lastZ;

    s32 y = (work->animator.model.translation.y - work->targetPos.y);
    s32 x = (work->animator.model.translation.x - work->targetPos.x);

    x = MATH_ABS(x);
    y = MATH_ABS(y);

    s32 distance;
    if (x > y)
        distance = MultiplyFX(FLOAT_TO_FX32(0.96045), x) + MultiplyFX(FLOAT_TO_FX32(0.3978), y);
    else
        distance = MultiplyFX(FLOAT_TO_FX32(0.96045), y) + MultiplyFX(FLOAT_TO_FX32(0.3978), x);

    if (distance < FLOAT_TO_FX32(15.0))
    {
        ExBossFireRed_Action_SlowDown();
    }
    else
    {
        work->animator.model.angle.x = exPlayerHelpers__Func_2152E28(work->velocity.z, work->velocity.y);
        work->animator.model.angle.z = exPlayerHelpers__Func_2152E28(work->velocity.x, work->velocity.y);
        exDrawReqTask__AddRequest(&work->animator.hitChecker, &work->animator.config);
        exHitCheckTask__AddHitCheck(&work->animator.hitChecker);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBossFireRed_Action_SlowDown(void)
{
    exBossFireRedTask *work = ExTaskGetWorkCurrent(exBossFireRedTask);

    SetCurrentExTaskMainEvent(ExBossFireRed_Main_MoveSlow);

    ExBossFireRed_Main_MoveSlow();
}

void ExBossFireRed_Main_MoveSlow(void)
{
    exBossFireRedTask *work = ExTaskGetWorkCurrent(exBossFireRedTask);

    exDrawReqTask__Model__Animate(&work->animator);

    if (work->animator.hitChecker.hitFlags.value_1)
    {
        if (work->animator.hitChecker.field_0 == 2)
        {
            ExBossFireRed_Action_Repelled();
            return;
        }
    }
    else
    {
        if (work->animator.hitChecker.hitFlags.value_10)
        {
            DestroyCurrentExTask();
            return;
        }
    }
    work->animator.model.translation.x += work->velocity.x;
    work->animator.model.translation.y += work->velocity.y;
    work->animator.model.angle.x = exPlayerHelpers__Func_2152E28(work->velocity.z, work->velocity.y);
    work->animator.model.angle.z = exPlayerHelpers__Func_2152E28(work->velocity.x, work->velocity.y);

    if ((work->animator.model.translation.x >= FLOAT_TO_FX32(90.0) || work->animator.model.translation.x <= -FLOAT_TO_FX32(90.0))
        || (work->animator.model.translation.y >= FLOAT_TO_FX32(200.0) || work->animator.model.translation.y <= -FLOAT_TO_FX32(60.0)))
    {
        DestroyCurrentExTask();
    }
    else
    {
        exDrawReqTask__AddRequest(&work->animator.hitChecker, &work->animator.config);
        exHitCheckTask__AddHitCheck(&work->animator.hitChecker);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBossFireRed_Action_Repelled(void)
{
    exBossFireRedTask *work = ExTaskGetWorkCurrent(exBossFireRedTask);

    work->animator.hitChecker.hitFlags.value_1 = FALSE;
    work->animator.hitChecker.field_4 |= 2;
    work->velocity.x = 0;

    if (exSysTask__GetStatus()->difficulty == 1)
    {
        if (work->animator.hitChecker.field_8 == 6)
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(4.0), work->velocity.y);
        }
        else
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(6.0), work->velocity.y);
        }
    }
    else if (exSysTask__GetStatus()->difficulty == 2)
    {
        if (work->animator.hitChecker.field_8 == 7)
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(4.0), work->velocity.y);
        }
        else
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(6.0), work->velocity.y);
        }
    }

    work->velocity.y             = -work->velocity.y;
    work->velocity.z             = 0;
    work->animator.model.angle.x = FLOAT_DEG_TO_IDX(179.96);
    work->animator.model.angle.y = FLOAT_DEG_TO_IDX(0.0);
    work->animator.model.angle.z = FLOAT_DEG_TO_IDX(0.0);
    work->spinSpeed              = FLOAT_DEG_TO_IDX(29.993);

    if ((mtMathRand() % 2) != 0)
        work->spinDirection = 1;
    else
        work->spinDirection = 0;

    SetCurrentExTaskMainEvent(ExBossFireRed_Main_Repelled);
    ExBossFireRed_Main_Repelled();
}

void ExBossFireRed_Main_Repelled(void)
{
    exBossFireRedTask *work = ExTaskGetWorkCurrent(exBossFireRedTask);

    exDrawReqTask__Model__Animate(&work->animator);

    if (work->animator.hitChecker.hitFlags.value_1)
    {
        DestroyCurrentExTask();
        return;
    }

    if (work->animator.hitChecker.hitFlags.value_10)
    {
        DestroyCurrentExTask();
        return;
    }

    if (work->spinDirection != 0)
        work->animator.model.angle.z += work->spinSpeed;
    else
        work->animator.model.angle.z -= work->spinSpeed;

    work->animator.model.translation.y += work->velocity.y;

    if ((work->animator.model.translation.x >= FLOAT_TO_FX32(90.0) || work->animator.model.translation.x <= -FLOAT_TO_FX32(90.0))
        || (work->animator.model.translation.y >= FLOAT_TO_FX32(200.0) || work->animator.model.translation.y <= -FLOAT_TO_FX32(60.0)))
    {
        DestroyCurrentExTask();
        return;
    }

    exDrawReqTask__AddRequest(&work->animator.hitChecker, &work->animator.config);
    exHitCheckTask__AddHitCheck(&work->animator.hitChecker);

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExBossFireRed(void)
{
    Task *task =
        ExTaskCreate(ExBossFireRed_Main_Init, ExBossFireRed_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exBossFireRedTask);

    exBossFireRedTask *work = ExTaskGetWork(task, exBossFireRedTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);
    SetExTaskUnknownEvent(task, ExBossFireRed_TaskUnknown);

    return TRUE;
}
