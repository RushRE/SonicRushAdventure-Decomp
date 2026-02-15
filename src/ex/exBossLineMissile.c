#include <ex/boss/exBossLineMissile.h>
#include <ex/boss/exBoss.h>
#include <ex/effects/exBigExplosion.h>
#include <ex/effects/exBossFireEffect.h>
#include <ex/system/exDrawReq.h>
#include <ex/system/exSystem.h>
#include <ex/system/exStage.h>
#include <ex/system/exUtils.h>
#include <game/file/binaryBundle.h>
#include <game/audio/audioSystem.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// CONSTANTS
// --------------------

#define EXBOSSSPIKEDMISSILE_HEALTH_EASY   12
#define EXBOSSSPIKEDMISSILE_HEALTH_NORMAL 9

#define EXBOSSBLUNTMISSILE_HEALTH_EASY   12
#define EXBOSSBLUNTMISSILE_HEALTH_NORMAL 9

// --------------------
// VARIABLES
// --------------------

static s16 lineNeedleInstanceCount;
static s16 lineMissileInstanceCount;

static void *lineMissileAnimResource[1];
static u32 lineMissileAnimType[1];
static Task *lineMissileTaskSingleton;
static u32 lineMissileTextureFileSize;
static u32 lineMissileModelFileSize;
static void *lineNeedleModelResource;
static EX_ACTION_NN_WORK *lineMissileLastSpawnedWorker;
static void *lineMissileModelResource;
static void *lineMissileUnused;
static Task *lineNeedleTaskSingleton;
static u32 lineNeedleTextureFileSize;
static u32 lineNeedleModelFileSize;
static void *lineNeedleUnused;
static u32 lineNeedleAnimType[1];
static EX_ACTION_NN_WORK *lineNeedleLastSpawnedWorker;
static void *lineNeedleAnimResource[1];

static VecFx32 missilePositions[EXBOSS_LINE_MISSILE_COUNT][EXBOSS_LINE_MISSILE_COUNT] = { {
                                                                                              { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(25.0), FLOAT_TO_FX32(50.0) },
                                                                                              { -FLOAT_TO_FX32(37.1001), FLOAT_TO_FX32(30.0), FLOAT_TO_FX32(70.0) },
                                                                                              { -FLOAT_TO_FX32(37.2), FLOAT_TO_FX32(35.0), FLOAT_TO_FX32(130.0) },
                                                                                              { -FLOAT_TO_FX32(37.30005), -FLOAT_TO_FX32(70.0), FLOAT_TO_FX32(130.0) },
                                                                                              { -FLOAT_TO_FX32(37.4), -FLOAT_TO_FX32(30.0), FLOAT_TO_FX32(50.0) },
                                                                                              { -FLOAT_TO_FX32(37.5), -FLOAT_TO_FX32(50.0), FLOAT_TO_FX32(60.0) },
                                                                                          },

                                                                                          {
                                                                                              { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(25.0), FLOAT_TO_FX32(50.0) },
                                                                                              { -FLOAT_TO_FX32(22.1001), FLOAT_TO_FX32(35.0), FLOAT_TO_FX32(60.0) },
                                                                                              { -FLOAT_TO_FX32(22.2), FLOAT_TO_FX32(35.0), FLOAT_TO_FX32(130.0) },
                                                                                              { -FLOAT_TO_FX32(22.30005), -FLOAT_TO_FX32(70.0), FLOAT_TO_FX32(130.0) },
                                                                                              { -FLOAT_TO_FX32(22.4), -FLOAT_TO_FX32(30.0), FLOAT_TO_FX32(50.0) },
                                                                                              { -FLOAT_TO_FX32(22.5), -FLOAT_TO_FX32(50.0), FLOAT_TO_FX32(60.0) },
                                                                                          },

                                                                                          {
                                                                                              { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(25.0), FLOAT_TO_FX32(50.0) },
                                                                                              { -FLOAT_TO_FX32(7.1001), FLOAT_TO_FX32(35.0), FLOAT_TO_FX32(60.0) },
                                                                                              { -FLOAT_TO_FX32(7.2), FLOAT_TO_FX32(35.0), FLOAT_TO_FX32(130.0) },
                                                                                              { -FLOAT_TO_FX32(7.30005), -FLOAT_TO_FX32(70.0), FLOAT_TO_FX32(130.0) },
                                                                                              { -FLOAT_TO_FX32(7.4), -FLOAT_TO_FX32(30.0), FLOAT_TO_FX32(50.0) },
                                                                                              { -FLOAT_TO_FX32(7.5), -FLOAT_TO_FX32(50.0), FLOAT_TO_FX32(60.0) },
                                                                                          },

                                                                                          {
                                                                                              { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(25.0), FLOAT_TO_FX32(50.0) },
                                                                                              { FLOAT_TO_FX32(7.1001), FLOAT_TO_FX32(35.0), FLOAT_TO_FX32(60.0) },
                                                                                              { FLOAT_TO_FX32(7.2), FLOAT_TO_FX32(35.0), FLOAT_TO_FX32(130.0) },
                                                                                              { FLOAT_TO_FX32(7.30005), -FLOAT_TO_FX32(70.0), FLOAT_TO_FX32(130.0) },
                                                                                              { FLOAT_TO_FX32(7.4), -FLOAT_TO_FX32(30.0), FLOAT_TO_FX32(50.0) },
                                                                                              { FLOAT_TO_FX32(7.5), -FLOAT_TO_FX32(50.0), FLOAT_TO_FX32(60.0) },
                                                                                          },

                                                                                          {
                                                                                              { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(25.0), FLOAT_TO_FX32(50.0) },
                                                                                              { FLOAT_TO_FX32(22.1001), FLOAT_TO_FX32(35.0), FLOAT_TO_FX32(60.0) },
                                                                                              { FLOAT_TO_FX32(22.2), FLOAT_TO_FX32(35.0), FLOAT_TO_FX32(130.0) },
                                                                                              { FLOAT_TO_FX32(22.30005), -FLOAT_TO_FX32(70.0), FLOAT_TO_FX32(130.0) },
                                                                                              { FLOAT_TO_FX32(22.4), -FLOAT_TO_FX32(30.0), FLOAT_TO_FX32(50.0) },
                                                                                              { FLOAT_TO_FX32(22.5), -FLOAT_TO_FX32(50.0), FLOAT_TO_FX32(60.0) },
                                                                                          },

                                                                                          {
                                                                                              { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(25.0), FLOAT_TO_FX32(50.0) },
                                                                                              { FLOAT_TO_FX32(37.1001), FLOAT_TO_FX32(35.0), FLOAT_TO_FX32(60.0) },
                                                                                              { FLOAT_TO_FX32(37.2), FLOAT_TO_FX32(35.0), FLOAT_TO_FX32(130.0) },
                                                                                              { FLOAT_TO_FX32(37.30005), -FLOAT_TO_FX32(70.0), FLOAT_TO_FX32(130.0) },
                                                                                              { FLOAT_TO_FX32(37.4), -FLOAT_TO_FX32(30.0), FLOAT_TO_FX32(50.0) },
                                                                                              { FLOAT_TO_FX32(37.5), -FLOAT_TO_FX32(50.0), FLOAT_TO_FX32(60.0) },
                                                                                          } };

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(lineMissileUnused)
FORCE_INCLUDE_VARIABLE_BSS(lineNeedleUnused)

// --------------------
// FUNCTION DECLS
// --------------------

// Spiked Line Missile
static BOOL LoadExBossSpikedLineMissileAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBossSpikedLineMissileAssets(EX_ACTION_NN_WORK *work);
static void ExBossSpikedLineMissile_Main_Init(void);
static void ExBossSpikedLineMissile_OnCheckStageFinished(void);
static void ExBossSpikedLineMissile_Destructor(void);
static void ExBossSpikedLineMissile_Main_Appear(void);
static void ExBossSpikedLineMissile_Action_Move(void);
static void ExBossSpikedLineMissile_Main_Move(void);

// Blunt Line Missile
static BOOL LoadExBossBluntLineMissileAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBossBluntLineMissileAssets(EX_ACTION_NN_WORK *work);
static void ExBossBluntLineMissile_Main_Init(void);
static void ExBossBluntLineMissile_OnCheckStageFinished(void);
static void ExBossBluntLineMissile_Destructor(void);
static void ExBossBluntLineMissile_Main_Appear(void);
static void ExBossBluntLineMissile_Action_Move(void);
static void ExBossBluntLineMissile_Main_Move(void);
static void ExBossBluntLineMissile_Action_Repelled(void);
static void ExBossBluntLineMissile_Main_Repelled(void);

// ExBoss
static void ExBoss_Main_Line0(void);
static void ExBoss_Action_StartLine1(void);
static void ExBoss_Main_Line1(void);
static void ExBoss_Action_StartLine2(void);
static void ExBoss_Main_Line2(void);
static void ExBoss_Action_StartNextLine(void);
static void ExBoss_Main_StartNextLine(void);
static void ExBoss_Action_FinishLineAttack(void);

// --------------------
// FUNCTIONS
// --------------------

BOOL LoadExBossSpikedLineMissileAssets(EX_ACTION_NN_WORK *work)
{
    lineNeedleLastSpawnedWorker = work;

    if (lineNeedleModelFileSize != 0 && lineNeedleTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < lineNeedleModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < lineNeedleTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < lineNeedleModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (lineNeedleInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_MSLB_NSBMD, &lineNeedleModelResource, &lineNeedleModelFileSize, TRUE, FALSE);

        lineNeedleAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_MSLB_NSBTP);
        lineNeedleAnimType[0]     = B3D_ANIM_PAT_ANIM;

        CreateAsset3DSetup(lineNeedleModelResource);
    }

    AnimatorMDL *animator = &work->model.animator;
    AnimatorMDL__Init(animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(animator, lineNeedleModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < ARRAY_COUNT(lineNeedleAnimType); i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, lineNeedleAnimType[i], lineNeedleAnimResource[i], 0, NNS_G3dGetTex(lineNeedleModelResource));
    }

    work->model.primaryAnimType     = lineNeedleAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[lineNeedleAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_PAT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(0.0);

    work->model.scale.x = FLOAT_TO_FX32(1.0);
    work->model.scale.y = FLOAT_TO_FX32(1.0);
    work->model.scale.z = FLOAT_TO_FX32(1.0);

    work->model.angle.x = FLOAT_DEG_TO_IDX(89.98);

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_B;

    work->hitChecker.type                      = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isSpikedLineMissile = TRUE;
    work->hitChecker.box.size.x                = FLOAT_TO_FX32(6.0);
    work->hitChecker.box.size.y                = FLOAT_TO_FX32(16.0);
    work->hitChecker.box.size.z                = FLOAT_TO_FX32(6.0);
    work->hitChecker.box.position              = &work->model.translation;

    lineNeedleInstanceCount++;

    return TRUE;
}

void ReleaseExBossSpikedLineMissileAssets(EX_ACTION_NN_WORK *work)
{
    if (lineNeedleInstanceCount <= 1)
    {
        if (lineNeedleModelResource)
            NNS_G3dResDefaultRelease(lineNeedleModelResource);

        if (lineNeedleAnimResource[0])
            NNS_G3dResDefaultRelease(lineNeedleAnimResource[0]);

        if (lineNeedleModelResource)
            HeapFree(HEAP_USER, lineNeedleModelResource);
        lineNeedleModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    lineNeedleInstanceCount--;
}

void ExBossSpikedLineMissile_Main_Init(void)
{
    exBossLineNeedleTask *work = ExTaskGetWorkCurrent(exBossLineNeedleTask);

    lineNeedleTaskSingleton = GetCurrentTask();

    LoadExBossSpikedLineMissileAssets(&work->animator);
    SetExDrawRequestPriority(&work->animator.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->animator.config);

    for (u16 i = 0; i < EXBOSS_LINE_MISSILE_COUNT; i++)
    {
        work->positions[i].x = work->parent->aniBoss.model.translation.x + missilePositions[work->id][i].x;
        work->positions[i].y = work->parent->aniBoss.model.translation.y + missilePositions[work->id][i].y;
        work->positions[i].z = work->parent->aniBoss.model.translation.z + missilePositions[work->id][i].z;
    }

    work->animator.model.translation.x = work->positions[0].x;
    work->animator.model.translation.y = work->positions[0].x;
    work->animator.model.translation.z = work->positions[0].x;

    ExUtils_InitMissileMover(&work->missileMover, work->positions, EXBOSS_LINE_MISSILE_COUNT, 60 + (mtMathRand() % 30));

    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        work->animator.hitChecker.health = EXBOSSSPIKEDMISSILE_HEALTH_NORMAL;
    }
    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
    {
        work->animator.hitChecker.health = EXBOSSSPIKEDMISSILE_HEALTH_EASY;
    }

    work->unknown = 3;

    SetCurrentExTaskMainEvent(ExBossSpikedLineMissile_Main_Appear);
}

void ExBossSpikedLineMissile_OnCheckStageFinished(void)
{
    exBossLineNeedleTask *work = ExTaskGetWorkCurrent(exBossLineNeedleTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBossSpikedLineMissile_Destructor(void)
{
    exBossLineNeedleTask *work = ExTaskGetWorkCurrent(exBossLineNeedleTask);

    ReleaseExBossSpikedLineMissileAssets(&work->animator);

    lineNeedleTaskSingleton = NULL;
}

void ExBossSpikedLineMissile_Main_Appear(void)
{
    exBossLineNeedleTask *work = ExTaskGetWorkCurrent(exBossLineNeedleTask);

    AnimateExDrawRequestModel(&work->animator);
    if (work->animator.hitChecker.output.hasCollision)
    {
        if (work->animator.hitChecker.output.isHurt)
        {
            work->animator.hitChecker.health -= work->animator.hitChecker.power;
            if (work->animator.hitChecker.health <= 0)
            {
                CreateExExplosion(&work->animator.model.translation);
                DestroyCurrentExTask();
                return;
            }
            work->animator.hitChecker.power         = 0;
            work->animator.hitChecker.output.isHurt = FALSE;
        }

        work->animator.hitChecker.output.hasCollision = FALSE;
    }
    else if (work->animator.hitChecker.output.willExplodeOnContact)
    {
        DestroyCurrentExTask();
        return;
    }

    if (ExBoss_IsBossFleeing() == TRUE)
    {
        CreateExExplosion(&work->animator.model.translation);
        DestroyCurrentExTask();
        return;
    }

    if (ExUtils_ProcessMissileMover(&work->missileMover))
    {
        ExBossSpikedLineMissile_Action_Move();
    }
    else
    {
        work->animator.model.translation.x = work->missileMover.currentPosition.x;
        work->animator.model.translation.y = work->missileMover.currentPosition.y;
        work->animator.model.translation.z = work->missileMover.currentPosition.z;
        work->velocity.x                   = work->missileMover.velocity.x;
        work->velocity.y                   = work->missileMover.velocity.y;
        work->velocity.z                   = work->missileMover.velocity.z;

        AddExDrawRequest(&work->animator, &work->animator.config);
        exHitCheckTask_AddHitCheck(&work->animator.hitChecker);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBossSpikedLineMissile_Action_Move(void)
{
    exBossLineNeedleTask *work = ExTaskGetWorkCurrent(exBossLineNeedleTask);
    UNUSED(work);

    SetCurrentExTaskMainEvent(ExBossSpikedLineMissile_Main_Move);
    ExBossSpikedLineMissile_Main_Move();
}

void ExBossSpikedLineMissile_Main_Move(void)
{
    exBossLineNeedleTask *work = ExTaskGetWorkCurrent(exBossLineNeedleTask);

    AnimateExDrawRequestModel(&work->animator);
    if (work->animator.hitChecker.output.hasCollision)
    {
        if (work->animator.hitChecker.output.isHurt)
        {
            work->animator.hitChecker.health -= work->animator.hitChecker.power;
            if (work->animator.hitChecker.health <= 0)
            {
                CreateExExplosion(&work->animator.model.translation);
                DestroyCurrentExTask();
                return;
            }
            work->animator.hitChecker.power         = 0;
            work->animator.hitChecker.output.isHurt = FALSE;
        }

        work->animator.hitChecker.output.hasCollision = FALSE;
    }
    else if (work->animator.hitChecker.output.willExplodeOnContact)
    {
        DestroyCurrentExTask();
        return;
    }

    if (ExBoss_IsBossFleeing() == TRUE)
    {
        CreateExExplosion(&work->animator.model.translation);
        DestroyCurrentExTask();
        return;
    }

    work->velocity.y -= FLOAT_TO_FX32(0.03125);
    work->animator.model.translation.x += work->velocity.x;
    work->animator.model.translation.y += work->velocity.y;

    if ((work->animator.model.translation.x >= EX_STAGE_BOUNDARY_R || work->animator.model.translation.x <= EX_STAGE_BOUNDARY_L)
        || (work->animator.model.translation.y >= EX_STAGE_BOUNDARY_B || work->animator.model.translation.y <= EX_STAGE_BOUNDARY_T))
    {
        DestroyCurrentExTask();
        return;
    }

    AddExDrawRequest(&work->animator, &work->animator.config);
    exHitCheckTask_AddHitCheck(&work->animator.hitChecker);

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

BOOL CreateExBossSpikedLineMissile(void)
{
    Task *task = ExTaskCreate(ExBossSpikedLineMissile_Main_Init, ExBossSpikedLineMissile_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0,
                              EXTASK_TYPE_REGULAR, exBossLineNeedleTask);

    exBossLineNeedleTask *work = ExTaskGetWork(task, exBossLineNeedleTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);
    work->id     = work->parent->projectileID;

    SetExTaskOnCheckStageFinishedEvent(task, ExBossSpikedLineMissile_OnCheckStageFinished);

    return TRUE;
}

BOOL LoadExBossBluntLineMissileAssets(EX_ACTION_NN_WORK *work)
{
    lineMissileLastSpawnedWorker = work;

    if (lineMissileModelFileSize != 0 && lineMissileTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < lineMissileModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < lineMissileTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < lineMissileModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (lineMissileInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_MSLA_NSBMD, &lineMissileModelResource, &lineMissileModelFileSize, TRUE, FALSE);

        lineMissileAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_MSLA_NSBTP);
        lineMissileAnimType[0]     = B3D_ANIM_PAT_ANIM;

        CreateAsset3DSetup(lineMissileModelResource);
    }

    AnimatorMDL *animator = &work->model.animator;
    AnimatorMDL__Init(animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(animator, lineMissileModelResource, 0, FALSE, FALSE);

    u16 i = 0;
    for (; i < ARRAY_COUNT(lineMissileAnimType); i++)
    {
        AnimatorMDL__SetAnimation(&work->model.animator, lineMissileAnimType[i], lineMissileAnimResource[i], 0, NNS_G3dGetTex(lineMissileModelResource));
    }

    work->model.primaryAnimType     = lineMissileAnimType[0];
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[lineMissileAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_PAT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(0.0);

    work->model.scale.x = FLOAT_TO_FX32(1.0);
    work->model.scale.y = FLOAT_TO_FX32(1.0);
    work->model.scale.z = FLOAT_TO_FX32(1.0);

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_B;

    work->model.angle.x = FLOAT_DEG_TO_IDX(89.98);

    work->hitChecker.type                     = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isBluntLineMissile = TRUE;
    work->hitChecker.box.size.x               = FLOAT_TO_FX32(6.0);
    work->hitChecker.box.size.y               = FLOAT_TO_FX32(16.0);
    work->hitChecker.box.size.z               = FLOAT_TO_FX32(6.0);
    work->hitChecker.box.position             = &work->model.translation;

    lineMissileInstanceCount++;

    return TRUE;
}

void ReleaseExBossBluntLineMissileAssets(EX_ACTION_NN_WORK *work)
{
    if (lineMissileInstanceCount <= 1)
    {
        if (lineMissileModelResource)
            NNS_G3dResDefaultRelease(lineMissileModelResource);

        if (lineMissileAnimResource[0])
            NNS_G3dResDefaultRelease(lineMissileAnimResource[0]);

        if (lineMissileModelResource)
            HeapFree(HEAP_USER, lineMissileModelResource);
        lineMissileModelResource = NULL;
    }
    AnimatorMDL__Release(&work->model.animator);

    lineMissileInstanceCount--;
}

void ExBossBluntLineMissile_Main_Init(void)
{
    exBossLineMissileTask *work = ExTaskGetWorkCurrent(exBossLineMissileTask);

    lineMissileTaskSingleton = GetCurrentTask();

    LoadExBossBluntLineMissileAssets(&work->animator);
    SetExDrawRequestPriority(&work->animator.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->animator.config);

    for (u16 i = 0; i < EXBOSS_LINE_MISSILE_COUNT; i++)
    {
        work->positions[i].x = work->parent->aniBoss.model.translation.x + missilePositions[work->id][i].x;
        work->positions[i].y = work->parent->aniBoss.model.translation.y + missilePositions[work->id][i].y;
        work->positions[i].z = work->parent->aniBoss.model.translation.z + missilePositions[work->id][i].z;
    }

    work->animator.model.translation.x = work->positions[0].x;
    work->animator.model.translation.y = work->positions[0].x;
    work->animator.model.translation.z = work->positions[0].x;

    ExUtils_InitMissileMover(&work->missileMover, work->positions, EXBOSS_LINE_MISSILE_COUNT, 60 + (mtMathRand() % 30));

    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        work->animator.hitChecker.health = EXBOSSBLUNTMISSILE_HEALTH_NORMAL;
    }
    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
    {
        work->animator.hitChecker.health = EXBOSSBLUNTMISSILE_HEALTH_EASY;
    }

    SetCurrentExTaskMainEvent(ExBossBluntLineMissile_Main_Appear);
}

void ExBossBluntLineMissile_OnCheckStageFinished(void)
{
    exBossLineMissileTask *work = ExTaskGetWorkCurrent(exBossLineMissileTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBossBluntLineMissile_Destructor(void)
{
    exBossLineMissileTask *work = ExTaskGetWorkCurrent(exBossLineMissileTask);

    ReleaseExBossBluntLineMissileAssets(&work->animator);

    lineMissileTaskSingleton = NULL;
}

void ExBossBluntLineMissile_Main_Appear(void)
{
    exBossLineMissileTask *work = ExTaskGetWorkCurrent(exBossLineMissileTask);

    AnimateExDrawRequestModel(&work->animator);
    if (work->animator.hitChecker.output.hasCollision)
    {
        if (work->animator.hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
        {
            ExBossBluntLineMissile_Action_Repelled();
            return;
        }

        if (work->animator.hitChecker.output.isHurt)
        {
            work->animator.hitChecker.health -= work->animator.hitChecker.power;
            if (work->animator.hitChecker.health <= 0)
            {
                CreateExExplosion(&work->animator.model.translation);
                DestroyCurrentExTask();
                return;
            }
            work->animator.hitChecker.power         = 0;
            work->animator.hitChecker.output.isHurt = FALSE;
        }

        work->animator.hitChecker.output.hasCollision = FALSE;
    }
    else if (work->animator.hitChecker.output.willExplodeOnContact)
    {
        CreateExExplosion(&work->animator.model.translation);
        DestroyCurrentExTask();
        return;
    }

    if (ExBoss_IsBossFleeing() == TRUE)
    {
        CreateExExplosion(&work->animator.model.translation);
        DestroyCurrentExTask();
        return;
    }

    if (ExUtils_ProcessMissileMover(&work->missileMover))
    {
        ExBossBluntLineMissile_Action_Move();
    }
    else
    {
        work->animator.model.translation.x = work->missileMover.currentPosition.x;
        work->animator.model.translation.y = work->missileMover.currentPosition.y;
        work->animator.model.translation.z = work->missileMover.currentPosition.z;
        work->velocity.x                   = work->missileMover.velocity.x;
        work->velocity.y                   = work->missileMover.velocity.y;
        work->velocity.z                   = work->missileMover.velocity.z;

        AddExDrawRequest(&work->animator, &work->animator.config);
        exHitCheckTask_AddHitCheck(&work->animator.hitChecker);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBossBluntLineMissile_Action_Move(void)
{
    exBossLineMissileTask *work = ExTaskGetWorkCurrent(exBossLineMissileTask);
    UNUSED(work);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_LINE_REFIRE);

    SetCurrentExTaskMainEvent(ExBossBluntLineMissile_Main_Move);
    ExBossBluntLineMissile_Main_Move();
}

void ExBossBluntLineMissile_Main_Move(void)
{
    exBossLineMissileTask *work = ExTaskGetWorkCurrent(exBossLineMissileTask);

    AnimateExDrawRequestModel(&work->animator);
    if (work->animator.hitChecker.output.hasCollision)
    {
        if (work->animator.hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
        {
            ExBossBluntLineMissile_Action_Repelled();
            return;
        }

        if (work->animator.hitChecker.output.isHurt)
        {
            work->animator.hitChecker.health -= work->animator.hitChecker.power;
            if (work->animator.hitChecker.health <= 0)
            {
                CreateExExplosion(&work->animator.model.translation);
                DestroyCurrentExTask();
                return;
            }
            work->animator.hitChecker.power         = 0;
            work->animator.hitChecker.output.isHurt = FALSE;
        }

        work->animator.hitChecker.output.hasCollision = FALSE;
    }
    else if (work->animator.hitChecker.output.willExplodeOnContact)
    {
        CreateExExplosion(&work->animator.model.translation);
        DestroyCurrentExTask();
        return;
    }

    if (ExBoss_IsBossFleeing() == TRUE)
    {
        CreateExExplosion(&work->animator.model.translation);
        DestroyCurrentExTask();
        return;
    }

    work->velocity.y -= FLOAT_TO_FX32(0.03125);
    work->animator.model.translation.x += work->velocity.x;
    work->animator.model.translation.y += work->velocity.y;

    if (work->animator.model.translation.y <= FLOAT_TO_FX32(20.0))
        work->animator.config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    if ((work->animator.model.translation.x >= EX_STAGE_BOUNDARY_R || work->animator.model.translation.x <= EX_STAGE_BOUNDARY_L)
        || (work->animator.model.translation.y >= EX_STAGE_BOUNDARY_B || work->animator.model.translation.y <= EX_STAGE_BOUNDARY_T))
    {
        DestroyCurrentExTask();
        return;
    }

    AddExDrawRequest(&work->animator, &work->animator.config);
    exHitCheckTask_AddHitCheck(&work->animator.hitChecker);

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

void ExBossBluntLineMissile_Action_Repelled(void)
{
    exBossLineMissileTask *work = ExTaskGetWorkCurrent(exBossLineMissileTask);

    work->animator.hitChecker.output.hasCollision        = FALSE;
    work->animator.hitChecker.input.isRepelledProjectile = TRUE;

    work->velocity.x = FLOAT_TO_FX32(0.0);
    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        if (work->animator.hitChecker.power == EXPLAYER_BARRIER_REGULAR_POWER_NORMAL)
        {
            work->velocity.y = MultiplyFX(work->velocity.y, FX_Div(FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(2.0)));
        }
        else
        {
            work->velocity.y = MultiplyFX(work->velocity.y, FX_Div(FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(2.0)));
        }
    }
    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
    {
        if (work->animator.hitChecker.power == EXPLAYER_BARRIER_REGULAR_POWER_EASY)
        {
            work->velocity.y = MultiplyFX(work->velocity.y, FX_Div(FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(2.0)));
        }
        else
        {
            work->velocity.y = MultiplyFX(work->velocity.y, FX_Div(FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(2.0)));
        }
    }

    BOOL spinClockwise                   = FALSE;
    work->velocity.y                     = -work->velocity.y;
    work->velocity.z                     = FLOAT_TO_FX32(0.0);
    work->animator.model.angle.x         = FLOAT_DEG_TO_IDX(269.9341);
    work->animator.model.angle.y         = FLOAT_DEG_TO_IDX(0.0);
    work->animator.model.angle.z         = FLOAT_DEG_TO_IDX(0.0);
    work->animator.hitChecker.box.size.x = FLOAT_TO_FX32(6.0);
    work->animator.hitChecker.box.size.y = FLOAT_TO_FX32(8.0);
    work->animator.hitChecker.box.size.z = FLOAT_TO_FX32(6.0);
    work->spinSpeed                      = FLOAT_DEG_TO_IDX(29.993);

    if ((mtMathRand() % 2) != 0)
        spinClockwise = TRUE;
    work->spinClockwise = spinClockwise;

    SetCurrentExTaskMainEvent(ExBossBluntLineMissile_Main_Repelled);
    ExBossBluntLineMissile_Main_Repelled();
}

void ExBossBluntLineMissile_Main_Repelled(void)
{
    exBossLineMissileTask *work = ExTaskGetWorkCurrent(exBossLineMissileTask);

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

    if (work->spinClockwise)
    {
        work->animator.model.angle.y += work->spinSpeed;
    }
    else
    {
        work->animator.model.angle.y -= work->spinSpeed;
    }

    work->animator.model.translation.y += work->velocity.y;

    if ((work->animator.model.translation.x >= EX_STAGE_BOUNDARY_R || work->animator.model.translation.x <= EX_STAGE_BOUNDARY_L)
        || (work->animator.model.translation.y >= EX_STAGE_BOUNDARY_B || work->animator.model.translation.y <= EX_STAGE_BOUNDARY_T))
    {
        DestroyCurrentExTask();
        return;
    }

    AddExDrawRequest(&work->animator, &work->animator.config);
    exHitCheckTask_AddHitCheck(&work->animator.hitChecker);

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

BOOL CreateExBossBluntLineMissile(void)
{
    Task *task = ExTaskCreate(ExBossBluntLineMissile_Main_Init, ExBossBluntLineMissile_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exBossLineMissileTask);

    exBossLineMissileTask *work = ExTaskGetWork(task, exBossLineMissileTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);
    work->id     = work->parent->projectileID;

    SetExTaskOnCheckStageFinishedEvent(task, ExBossBluntLineMissile_OnCheckStageFinished);

    return TRUE;
}

// ExBoss
void ExBoss_Action_StartLineMissileAttack(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_line0);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_E_HORE);

    SetCurrentExTaskMainEvent(ExBoss_Main_Line0);
    ExBoss_Main_Line0();
}

void ExBoss_Main_Line0(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_StartLine1();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_Action_StartLine1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_line1);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_LINE_MISSLE);

    for (u16 m = 0; m < EXBOSS_LINE_MISSILE_COUNT; m++)
    {
        work->projectileID = m;

        if ((mtMathRand() % 2) != 0)
            CreateExBossBluntLineMissile();
        else
            CreateExBossSpikedLineMissile();
    }
    work->projectileID = 0;

    SetCurrentExTaskMainEvent(ExBoss_Main_Line1);
    ExBoss_Main_Line1();
}

void ExBoss_Main_Line1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_StartLine2();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_Action_StartLine2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_line2);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_Line2);
    ExBoss_Main_Line2();
}

void ExBoss_Main_Line2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        work->projectileRepeatCount++;
        if (work->projectileRepeatCount < 3)
        {
            ExBoss_Action_StartNextLine();
        }
        else
        {
            work->projectileRepeatCount = 0;
            ExBoss_Action_FinishLineAttack();
        }
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExBoss_Action_StartNextLine(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_fw0);
    SetExDrawRequestAnimAsOneShot(&work->aniBoss.config);
    work->genericCooldown = SECONDS_TO_FRAMES(1.0);

    SetCurrentExTaskMainEvent(ExBoss_Main_StartNextLine);
    ExBoss_Main_StartNextLine();
}

void ExBoss_Main_StartNextLine(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    HandleExBossMovement();

    if (work->genericCooldown <= 0)
    {
        work->genericCooldown = 0;
        if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
        {
            ExBoss_Action_StartLineMissileAttack();
            return;
        }
    }
    else
    {
        work->genericCooldown--;
    }

    exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
    AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

void ExBoss_Action_FinishLineAttack(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->nextAttackState();
}