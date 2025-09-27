#include <ex/boss/exBossFireballRed.h>
#include <ex/boss/exBossFireballBlue.h>
#include <ex/boss/exBoss.h>
#include <ex/boss/exBossFireDragon.h>
#include <ex/boss/exBossHomingLaser.h>
#include <ex/effects/exBossFireballEffect.h>
#include <ex/effects/exBossFireballShotEffect.h>
#include <ex/effects/exBossHomingEffect.h>
#include <ex/system/exUtils.h>
#include <ex/system/exSystem.h>
#include <ex/system/exStage.h>
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
static void *fireballBlueUnused;
static void *fireballBlueModelResource;
static EX_ACTION_NN_WORK *fireballRedLastSpawnedWorker;
static void *fireballRedModelResource;
static void *fireballRedUnused;
static Task *fireballBlueLastSpawnedTask;
static u32 fireballBlueTextureFileSize;
static u32 fireballBlueModelFileSize;
static void *fireballRedAnimResource[4];
static void *fireballBlueAnimResource[4];
static B3DAnimationTypes fireballBlueAnimType[4];
static B3DAnimationTypes fireballRedAnimType[4];

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
static void ExBossFireBlue_OnCheckStageFinished(void);
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
static void ExBossFireRed_OnCheckStageFinished(void);
static void ExBossFireRed_Destructor(void);
static void ExBossFireRed_Main_MoveFast(void);
static void ExBossFireRed_Action_SlowDown(void);
static void ExBossFireRed_Main_MoveSlow(void);
static void ExBossFireRed_Action_Repelled(void);
static void ExBossFireRed_Main_Repelled(void);

// ExBoss
static void ExBoss_Main_StartFire0(void);
static void ExBoss_Main_FinishFire0(void);
static void ExBoss_Action_StartFire1(void);
static void ExBoss_Main_Fire1(void);
static void ExBoss_Action_StartFire2(void);
static void ExBoss_Main_Fire2(void);
static void ExBoss_HandleFireShoot(void);
static void ExBoss_Action_StartFire4(void);
static void ExBoss_Main_Fire4(void);
static void ExBoss_Action_FinishFireballAttack(void);

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

    InitExDrawRequestModel(work);

    if (fireballBlueInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_FIRE2_NSBMD, &fireballBlueModelResource, &fireballBlueModelFileSize, TRUE, FALSE);

        fireballBlueAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE2_NSBMA);
        fireballBlueAnimType[0]     = B3D_ANIM_MAT_ANIM;

        fireballBlueAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE2_NSBVA);
        fireballBlueAnimType[1]     = B3D_ANIM_VIS_ANIM;

        fireballBlueAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE2_NSBTA);
        fireballBlueAnimType[2]     = B3D_ANIM_TEX_ANIM;

        fireballBlueAnimResource[3] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE2_NSBTP);
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

    work->model.primaryAnimType     = fireballBlueAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[fireballBlueAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }
    work->model.translation.z        = FLOAT_TO_FX32(0.0);
    work->model.scale.x              = FLOAT_TO_FX32(1.0);
    work->model.scale.y              = FLOAT_TO_FX32(1.0);
    work->model.scale.z              = FLOAT_TO_FX32(1.0);
    work->model.angle.x              = FLOAT_DEG_TO_IDX(89.98);
    work->hitChecker.type            = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isBossFireBlue = TRUE;
    work->hitChecker.box.size.x      = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.size.y      = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.size.z      = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.position    = &work->model.translation;

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
    SetExDrawRequestPriority(&work->animator.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->animator.config);

    work->animator.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
    work->animator.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
    work->animator.model.translation.z = work->parent->aniBoss.model.bossStaffPos.z;

    work->targetPos.x = work->parent->targetPos.x;
    work->targetPos.y = work->parent->targetPos.y;
    work->targetPos.z = FLOAT_TO_FX32(60.0);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_FIREBALL);

    SetCurrentExTaskMainEvent(ExBossFireBlue_Main_MoveFast);
}

void ExBossFireBlue_OnCheckStageFinished(void)
{
    exBossFireBlueTask *work = ExTaskGetWorkCurrent(exBossFireBlueTask);

    if (CheckExStageFinished())
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

    AnimateExDrawRequestModel(&work->animator);

    if (work->animator.hitChecker.output.hasCollision)
    {
        if (work->animator.hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
        {
            ExBossFireBlue_Action_Repelled();
            return;
        }

        work->animator.hitChecker.output.hasCollision = FALSE;
    }
    else
    {
        if (work->animator.hitChecker.output.willExplodeOnContact)
        {
            DestroyCurrentExTask();
            return;
        }
    }

    fx32 lastX = work->animator.model.translation.x;
    fx32 lastY = work->animator.model.translation.y;
    fx32 lastZ = work->animator.model.translation.z;

    work->animator.model.translation.x += mtMoveTowards(FLOAT_TO_FX32(0.1001), work->animator.model.translation.x, work->targetPos.x);
    work->animator.model.translation.y += mtMoveTowards(FLOAT_TO_FX32(0.1001), work->animator.model.translation.y, work->targetPos.y);
    work->animator.model.translation.z += mtMoveTowards(FLOAT_TO_FX32(0.1001), work->animator.model.translation.z, work->targetPos.z);

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
        work->animator.model.angle.x = ExUtils_Atan2(work->velocity.z, work->velocity.y);
        work->animator.model.angle.z = ExUtils_Atan2(work->velocity.x, work->velocity.y);
        AddExDrawRequest(&work->animator.hitChecker, &work->animator.config);
        exHitCheckTask_AddHitCheck(&work->animator.hitChecker);

        RunCurrentExTaskOnCheckStageFinishedEvent();
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

    AnimateExDrawRequestModel(&work->animator);

    if (work->animator.hitChecker.output.hasCollision)
    {
        if (work->animator.hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
        {
            ExBossFireBlue_Action_Repelled();
            return;
        }

        work->animator.hitChecker.output.hasCollision = FALSE;
    }
    else
    {
        if (work->animator.hitChecker.output.willExplodeOnContact)
        {
            DestroyCurrentExTask();
            return;
        }
    }
    work->animator.model.translation.x += work->velocity.x;
    work->animator.model.translation.y += work->velocity.y;
    work->animator.model.angle.x = ExUtils_Atan2(work->velocity.z, work->velocity.y);
    work->animator.model.angle.z = ExUtils_Atan2(work->velocity.x, work->velocity.y);

    if ((work->animator.model.translation.x >= EX_STAGE_BOUNDARY_R || work->animator.model.translation.x <= EX_STAGE_BOUNDARY_L)
        || (work->animator.model.translation.y >= EX_STAGE_BOUNDARY_B || work->animator.model.translation.y <= EX_STAGE_BOUNDARY_T))
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->animator.hitChecker, &work->animator.config);
        exHitCheckTask_AddHitCheck(&work->animator.hitChecker);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBossFireBlue_Action_Repelled(void)
{
    exBossFireBlueTask *work = ExTaskGetWorkCurrent(exBossFireBlueTask);

    work->animator.hitChecker.output.hasCollision = FALSE;
    work->animator.hitChecker.input.isRepelledProjectile  = TRUE;
    work->velocity.x                           = 0;

    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        if (work->animator.hitChecker.power == 6)
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
        if (work->animator.hitChecker.power == 7)
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

    AnimateExDrawRequestModel(&work->animator);

    if (work->animator.hitChecker.output.hasCollision)
    {
        DestroyCurrentExTask();
        return;
    }

    if (work->animator.hitChecker.output.willExplodeOnContact)
    {
        DestroyCurrentExTask();
        return;
    }

    if (work->spinDirection != 0)
        work->animator.model.angle.z += work->spinSpeed;
    else
        work->animator.model.angle.z -= work->spinSpeed;

    work->animator.model.translation.y += work->velocity.y;

    if ((work->animator.model.translation.x >= EX_STAGE_BOUNDARY_R || work->animator.model.translation.x <= EX_STAGE_BOUNDARY_L)
        || (work->animator.model.translation.y >= EX_STAGE_BOUNDARY_B || work->animator.model.translation.y <= EX_STAGE_BOUNDARY_T))
    {
        DestroyCurrentExTask();
        return;
    }

    AddExDrawRequest(&work->animator.hitChecker, &work->animator.config);
    exHitCheckTask_AddHitCheck(&work->animator.hitChecker);

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

BOOL CreateExBossFireBlue(void)
{
    Task *task =
        ExTaskCreate(ExBossFireBlue_Main_Init, ExBossFireBlue_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exBossFireBlueTask);

    exBossFireBlueTask *work = ExTaskGetWork(task, exBossFireBlueTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);
    SetExTaskOnCheckStageFinishedEvent(task, ExBossFireBlue_OnCheckStageFinished);

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

    InitExDrawRequestModel(work);
    if (fireballRedInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_FIRE1_NSBMD, &fireballRedModelResource, &fireballRedModelFileSize, TRUE, FALSE);

        fireballRedAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE1_NSBMA);
        fireballRedAnimType[0]     = B3D_ANIM_MAT_ANIM;

        fireballRedAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE1_NSBVA);
        fireballRedAnimType[1]     = B3D_ANIM_VIS_ANIM;

        fireballRedAnimResource[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE1_NSBTA);
        fireballRedAnimType[2]     = B3D_ANIM_TEX_ANIM;

        fireballRedAnimResource[3] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_FIRE1_NSBTP);
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

    work->model.primaryAnimType     = fireballRedAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[fireballRedAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }
    work->model.translation.z        = FLOAT_TO_FX32(0.0);
    work->model.scale.x              = FLOAT_TO_FX32(1.0);
    work->model.scale.y              = FLOAT_TO_FX32(1.0);
    work->model.scale.z              = FLOAT_TO_FX32(1.0);
    work->model.angle.x              = FLOAT_DEG_TO_IDX(89.98);
    work->hitChecker.type            = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isBossFireRed = TRUE;
    work->hitChecker.box.size.x      = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.size.y      = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.size.z      = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.position    = &work->model.translation;

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
    SetExDrawRequestPriority(&work->animator.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->animator.config);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_FIREBALL);

    work->animator.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
    work->animator.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
    work->animator.model.translation.z = work->parent->aniBoss.model.bossStaffPos.z;

    work->targetPos.x = work->parent->targetPos.x;
    work->targetPos.y = work->parent->targetPos.y;
    work->targetPos.z = FLOAT_TO_FX32(60.0);

    SetCurrentExTaskMainEvent(ExBossFireRed_Main_MoveFast);
}

void ExBossFireRed_OnCheckStageFinished(void)
{
    exBossFireRedTask *work = ExTaskGetWorkCurrent(exBossFireRedTask);

    if (CheckExStageFinished())
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

    AnimateExDrawRequestModel(&work->animator);

    if (work->animator.hitChecker.output.hasCollision)
    {
        if (work->animator.hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
        {
            ExBossFireRed_Action_Repelled();
            return;
        }
    }
    else
    {
        if (work->animator.hitChecker.output.willExplodeOnContact)
        {
            DestroyCurrentExTask();
            return;
        }
    }

    fx32 lastX = work->animator.model.translation.x;
    fx32 lastY = work->animator.model.translation.y;
    fx32 lastZ = work->animator.model.translation.z;

    work->animator.model.translation.x += mtMoveTowards(FLOAT_TO_FX32(0.05005), work->animator.model.translation.x, work->targetPos.x);
    work->animator.model.translation.y += mtMoveTowards(FLOAT_TO_FX32(0.05005), work->animator.model.translation.y, work->targetPos.y);
    work->animator.model.translation.z += mtMoveTowards(FLOAT_TO_FX32(0.05005), work->animator.model.translation.z, work->targetPos.z);

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
        work->animator.model.angle.x = ExUtils_Atan2(work->velocity.z, work->velocity.y);
        work->animator.model.angle.z = ExUtils_Atan2(work->velocity.x, work->velocity.y);
        AddExDrawRequest(&work->animator.hitChecker, &work->animator.config);
        exHitCheckTask_AddHitCheck(&work->animator.hitChecker);

        RunCurrentExTaskOnCheckStageFinishedEvent();
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

    AnimateExDrawRequestModel(&work->animator);

    if (work->animator.hitChecker.output.hasCollision)
    {
        if (work->animator.hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
        {
            ExBossFireRed_Action_Repelled();
            return;
        }
    }
    else
    {
        if (work->animator.hitChecker.output.willExplodeOnContact)
        {
            DestroyCurrentExTask();
            return;
        }
    }
    work->animator.model.translation.x += work->velocity.x;
    work->animator.model.translation.y += work->velocity.y;
    work->animator.model.angle.x = ExUtils_Atan2(work->velocity.z, work->velocity.y);
    work->animator.model.angle.z = ExUtils_Atan2(work->velocity.x, work->velocity.y);

    if ((work->animator.model.translation.x >= EX_STAGE_BOUNDARY_R || work->animator.model.translation.x <= EX_STAGE_BOUNDARY_L)
        || (work->animator.model.translation.y >= EX_STAGE_BOUNDARY_B || work->animator.model.translation.y <= EX_STAGE_BOUNDARY_T))
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->animator.hitChecker, &work->animator.config);
        exHitCheckTask_AddHitCheck(&work->animator.hitChecker);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBossFireRed_Action_Repelled(void)
{
    exBossFireRedTask *work = ExTaskGetWorkCurrent(exBossFireRedTask);

    work->animator.hitChecker.output.hasCollision = FALSE;
    work->animator.hitChecker.input.isRepelledProjectile  = TRUE;
    work->velocity.x                           = 0;

    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        if (work->animator.hitChecker.power == 6)
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
        if (work->animator.hitChecker.power == 7)
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

    AnimateExDrawRequestModel(&work->animator);

    if (work->animator.hitChecker.output.hasCollision)
    {
        DestroyCurrentExTask();
        return;
    }

    if (work->animator.hitChecker.output.willExplodeOnContact)
    {
        DestroyCurrentExTask();
        return;
    }

    if (work->spinDirection != 0)
        work->animator.model.angle.z += work->spinSpeed;
    else
        work->animator.model.angle.z -= work->spinSpeed;

    work->animator.model.translation.y += work->velocity.y;

    if ((work->animator.model.translation.x >= EX_STAGE_BOUNDARY_R || work->animator.model.translation.x <= EX_STAGE_BOUNDARY_L)
        || (work->animator.model.translation.y >= EX_STAGE_BOUNDARY_B || work->animator.model.translation.y <= EX_STAGE_BOUNDARY_T))
    {
        DestroyCurrentExTask();
        return;
    }

    AddExDrawRequest(&work->animator.hitChecker, &work->animator.config);
    exHitCheckTask_AddHitCheck(&work->animator.hitChecker);

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

BOOL CreateExBossFireRed(void)
{
    Task *task =
        ExTaskCreate(ExBossFireRed_Main_Init, ExBossFireRed_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exBossFireRedTask);

    exBossFireRedTask *work = ExTaskGetWork(task, exBossFireRedTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);
    SetExTaskOnCheckStageFinishedEvent(task, ExBossFireRed_OnCheckStageFinished);

    return TRUE;
}

// ExBoss
void ExBoss_Action_StartFireballAttack(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    CreateExBossEffectFireball();

    PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_E_KURAE);

    SetExBossAnimation(&work->aniBoss, bse_body_fire0);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_StartFire0);
    ExBoss_Main_StartFire0();
}

void ExBoss_Main_StartFire0(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    if (work->aniBoss.model.primaryAnimResource->frame >= FLOAT_TO_FX32(15.0))
    {
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_PREPARE);

        SetCurrentExTaskMainEvent(ExBoss_Main_FinishFire0);
        ExBoss_Main_FinishFire0();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_Main_FinishFire0(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_StartFire1();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_Action_StartFire1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_fire1);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    DisableExBossEffectFireball();
    work->projectileRepeatCount = 0;

    SetCurrentExTaskMainEvent(ExBoss_Main_Fire1);
    ExBoss_Main_Fire1();
}

void ExBoss_Main_Fire1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    work->targetPos.x += mtMoveTowards(FLOAT_TO_FX32(0.1001), work->targetPos.x, GetExPlayerPosition()->x);
    work->targetPos.y += mtMoveTowards(FLOAT_TO_FX32(0.1001), work->targetPos.y, GetExPlayerPosition()->y);

    work->aniBoss.model.angle.y = ExUtils_Atan2(work->targetPos.x - work->aniBoss.model.translation.x, work->aniBoss.model.translation.y - work->targetPos.y);

    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_StartFire2();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_Action_StartFire2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_fire2);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    CreateExBossEffectFireballShot();

    if ((mtMathRand() % 2) != 0)
        CreateExBossFireRed();
    else
        CreateExBossFireBlue();

    SetCurrentExTaskMainEvent(ExBoss_Main_Fire2);
    ExBoss_Main_Fire2();
}

void ExBoss_Main_Fire2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    work->targetPos.x += mtMoveTowards(FLOAT_TO_FX32(0.1001), work->targetPos.x, GetExPlayerPosition()->x);
    work->targetPos.y += mtMoveTowards(FLOAT_TO_FX32(0.1001), work->targetPos.y, GetExPlayerPosition()->y);

    work->aniBoss.model.angle.y = ExUtils_Atan2(work->targetPos.x - work->aniBoss.model.translation.x, work->aniBoss.model.translation.y - work->targetPos.y);

    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_HandleFireShoot();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_HandleFireShoot(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    if (GetActiveExBossFireDragonCount() == 0 && GetActiveExBossHomingLaserCount() == 0)
    {
        work->projectileRepeatCount++;
        if (work->projectileRepeatCount < 5)
        {
            ExBoss_Action_StartFire2();
            return;
        }
    }
    else
    {
        work->projectileRepeatCount++;
        if (work->projectileRepeatCount < 3)
        {
            ExBoss_Action_StartFire2();
            return;
        }
    }

    DisableExBossEffectFireballShot();
    work->projectileRepeatCount = 0;
    ExBoss_Action_StartFire4();
}

void ExBoss_Action_StartFire4(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->aniBoss.model.angle.y = 0;

    SetExBossAnimation(&work->aniBoss, bse_body_fire4);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_Fire4);
    ExBoss_Main_Fire4();
}

void ExBoss_Main_Fire4(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_FinishFireballAttack();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_Action_FinishFireballAttack(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->nextAttackState();
}
