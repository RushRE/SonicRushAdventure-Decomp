#include <ex/core/exMeteorManager.h>
#include <ex/system/exSystem.h>
#include <ex/player/exPlayerHelpers.h>
#include <game/file/binaryBundle.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// ENUMS
// --------------------

enum ExMeteorConfigFlags
{
    EXMETEORCONFIG_SPAWN_NONE = 0x00,

    EXMETEORCONFIG_SPAWN_L4 = 1 << 0,
    EXMETEORCONFIG_SPAWN_L3 = 1 << 1,
    EXMETEORCONFIG_SPAWN_L2 = 1 << 2,
    EXMETEORCONFIG_SPAWN_L1 = 1 << 3,

    EXMETEORCONFIG_SPAWN_R1 = 1 << 4,
    EXMETEORCONFIG_SPAWN_R2 = 1 << 5,
    EXMETEORCONFIG_SPAWN_R3 = 1 << 6,
    EXMETEORCONFIG_SPAWN_R4 = 1 << 7,
};

// --------------------
// VARIABLES
// --------------------

static s16 exBrokenMeteorInstanceCount;
static s16 exMeteorInstanceCount;

static void *exMeteorModelResource;
static void *exMeteorLastSpawnedWorker;
static u32 exMeteorModelFileSize;
static void *exBrokenMeteorLastSpawnedWorker;
static u32 exBrokenMeteorModelFileSize;
static void *exBrokenMeteorModelResource;
static u32 exBrokenMeteorTextureFileSize;
static void *exMeteorUnused;
static u32 exMeteorTextureFileSize;
static void *exEffectMeteoAdminTask__TaskSingleton;
static void *exBrokenMeteorUnused;
static void *exBrokenMeteorAnimResource[2];
static u32 exBrokenMeteorAnimType[2];

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(exMeteorUnused)
FORCE_INCLUDE_VARIABLE_BSS(exBrokenMeteorUnused)

static struct exMeteorConfig exMeteorSpawnTable0_Normal[] = {
    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_L2 | EXMETEORCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_R2,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(0.5),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(0.5),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_NONE,
    },
};

static struct exMeteorConfig exMeteorSpawnTable0_Easy[] = {
    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_L2 | EXMETEORCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_R2,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(1.0),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(0.5),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(0.5),
        .velocity       = 0.75f,
        .spawnPos.field = EXMETEORCONFIG_SPAWN_NONE,
    },
};

static u16 exMeteorManagerSpawnTableInfo[] = { ARRAY_COUNT(exMeteorSpawnTable0_Normal), ARRAY_COUNT(exMeteorSpawnTable0_Easy) };

static struct exMeteorConfig *exMeteorManagerSpawnConfig[] = { exMeteorSpawnTable0_Normal, exMeteorSpawnTable0_Easy };

// --------------------
// FUNCTION DECLS
// --------------------

// ExMeteorManager helpers
static BOOL LoadExMeteorAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExMeteorAssets(EX_ACTION_NN_WORK *work);
static BOOL LoadExBrokenMeteorAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBrokenMeteorAssets(EX_ACTION_NN_WORK *work);

// ExMeteor
static void ExMeteor_Main_Init(void);
static void ExMeteor_TaskUnknown(void);
static void ExMeteor_Destructor(void);
static void ExMeteor_Main_Moving(void);
static void ExMeteor_Action_Shatter(void);
static void ExMeteor_Main_Shatter(void);
static void ExMeteor_Action_Reflect(void);
static void ExMeteor_Main_Reflect(void);
static BOOL CreateExMeteor(VecFx32 position, VecFx32 velocity);

// ExMeteorManager
static void ExMeteorManager_Main_Init(void);
static void ExMeteorManager_TaskUnknown(void);
static void ExMeteorManager_Destructor(void);
static void ExMeteorManager_Main_Active(void);
static void ConfigureExMeteorManagerSpawning(void);

// --------------------
// FUNCTIONS
// --------------------

// ExMeteorManager helpers
BOOL LoadExMeteorAssets(EX_ACTION_NN_WORK *work)
{
    exMeteorLastSpawnedWorker = work;

    if (exMeteorModelFileSize != 0 && exMeteorTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exMeteorModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exMeteorTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exMeteorModelFileSize)
            return FALSE;
    }

    exDrawReqTask__InitModel(work);

    if (exMeteorInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_METEO_NSBMD, &exMeteorModelResource, &exMeteorModelFileSize, TRUE, FALSE);

        Asset3DSetup__Create(exMeteorModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exMeteorModelResource, 0, FALSE, FALSE);

    work->model.translation.z = FLOAT_TO_FX32(60.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z       = FLOAT_DEG_TO_IDX(179.9561);

    work->hitChecker.type             = 5;
    work->hitChecker.field_4.value_10 = TRUE;
    work->hitChecker.box.size.x       = FLOAT_TO_FX32(3.0);
    work->hitChecker.box.size.y       = FLOAT_TO_FX32(3.0);
    work->hitChecker.box.size.z       = FLOAT_TO_FX32(3.0);
    work->hitChecker.box.position     = &work->model.translation;

    exMeteorInstanceCount++;

    return TRUE;
}

void ReleaseExMeteorAssets(EX_ACTION_NN_WORK *work)
{
    if (exMeteorInstanceCount <= 1)
    {
        if (exMeteorModelResource != NULL)
            NNS_G3dResDefaultRelease(exMeteorModelResource);

        if (exMeteorModelResource != NULL)
            HeapFree(HEAP_USER, exMeteorModelResource);
        exMeteorModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    exMeteorInstanceCount--;
}

BOOL LoadExBrokenMeteorAssets(EX_ACTION_NN_WORK *work)
{
    exBrokenMeteorLastSpawnedWorker = work;

    if (exBrokenMeteorModelFileSize != 0 && exBrokenMeteorTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exBrokenMeteorModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exBrokenMeteorTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exBrokenMeteorModelFileSize)
            return FALSE;
    }

    exDrawReqTask__InitModel(work);

    if (exBrokenMeteorInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_METEO_BR_NSBMD, &exBrokenMeteorModelResource, &exBrokenMeteorModelFileSize, TRUE,
                                      FALSE);

        exBrokenMeteorAnimResource[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_METEO_BRK_NSBCA);
        exBrokenMeteorAnimType[0]     = B3D_ANIM_JOINT_ANIM;
        exBrokenMeteorAnimResource[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_EFFE_METEO_BRK_NSBVA);
        exBrokenMeteorAnimType[1]     = B3D_ANIM_VIS_ANIM;

        Asset3DSetup__Create(exBrokenMeteorModelResource);
    }

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exBrokenMeteorModelResource, 0, FALSE, FALSE);
    AnimatorMDL__SetAnimation(&work->model.animator, exBrokenMeteorAnimType[0], exBrokenMeteorAnimResource[0], 0, NULL);
    AnimatorMDL__SetAnimation(&work->model.animator, exBrokenMeteorAnimType[1], exBrokenMeteorAnimResource[1], 0, NULL);

    work->model.field_32C = exBrokenMeteorAnimType[0];
    work->model.field_328 = work->model.animator.currentAnimObj[exBrokenMeteorAnimType[0]];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->model.translation.z = FLOAT_TO_FX32(60.0);
    work->model.scale.x       = FLOAT_TO_FX32(1.0);
    work->model.scale.y       = FLOAT_TO_FX32(1.0);
    work->model.scale.z       = FLOAT_TO_FX32(1.0);
    work->model.angle.x       = -FLOAT_DEG_TO_IDX(90.066);
    work->model.angle.z       = FLOAT_DEG_TO_IDX(179.9561);

    work->hitChecker.type             = 5;
    work->hitChecker.field_4.value_20 = TRUE;
    work->hitChecker.box.size.x       = FLOAT_TO_FX32(3.0);
    work->hitChecker.box.size.y       = FLOAT_TO_FX32(3.0);
    work->hitChecker.box.size.z       = FLOAT_TO_FX32(3.0);
    work->hitChecker.box.position     = &work->model.translation;

    exBrokenMeteorInstanceCount++;

    return TRUE;
}

void ReleaseExBrokenMeteorAssets(EX_ACTION_NN_WORK *work)
{
    if (exBrokenMeteorInstanceCount <= 1)
    {
        if (exBrokenMeteorModelResource != NULL)
            NNS_G3dResDefaultRelease(exBrokenMeteorModelResource);

        if (exBrokenMeteorAnimResource[0] != NULL)
            NNS_G3dResDefaultRelease(exBrokenMeteorAnimResource[0]);

        if (exBrokenMeteorAnimResource[1] != NULL)
            NNS_G3dResDefaultRelease(exBrokenMeteorAnimResource[1]);

        if (exBrokenMeteorModelResource != NULL)
            HeapFree(HEAP_USER, exBrokenMeteorModelResource);
        exBrokenMeteorModelResource = NULL;
    }

    AnimatorMDL__Release(&work->model.animator);

    exBrokenMeteorInstanceCount--;
}

// ExMeteor
void ExMeteor_Main_Init(void)
{
    exEffectMeteoTask *work = ExTaskGetWorkCurrent(exEffectMeteoTask);

    if (!work->isActive)
    {
        DestroyCurrentExTask();
    }
    else
    {
        work->rotateDir.x = mtMathRand() % 3;
        work->rotateDir.y = mtMathRand() % 3;
        work->rotateDir.z = mtMathRand() % 3;

        work->rotateSpeed.x = mtMathRand() % 3;
        work->rotateSpeed.y = mtMathRand() % 3;
        work->rotateSpeed.z = mtMathRand() % 3;

        SetCurrentExTaskMainEvent(ExMeteor_Main_Moving);
    }
}

void ExMeteor_TaskUnknown(void)
{
    exEffectMeteoTask *work = ExTaskGetWorkCurrent(exEffectMeteoTask);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExMeteor_Destructor(void)
{
    exEffectMeteoTask *work = ExTaskGetWorkCurrent(exEffectMeteoTask);

    ReleaseExMeteorAssets(&work->aniMeteor);
    ReleaseExBrokenMeteorAssets(&work->mdlMeteorBroken);
}

void ExMeteor_Main_Moving(void)
{
    exEffectMeteoTask *work = ExTaskGetWorkCurrent(exEffectMeteoTask);

    exDrawReqTask__Model__Animate(&work->aniMeteor);

    exPlayerHelpers__Func_2152D28(&work->aniMeteor.model.angle, &work->rotateDir, &work->rotateSpeed, 0);
    exPlayerHelpers__Func_2152D28(&work->aniMeteor.model.angle, &work->rotateDir, &work->rotateSpeed, 1);
    exPlayerHelpers__Func_2152D28(&work->aniMeteor.model.angle, &work->rotateDir, &work->rotateSpeed, 2);

    work->aniMeteor.model.translation.y -= work->velocity.y;

    if (work->aniMeteor.model.translation.x >= FLOAT_TO_FX32(90.0) || work->aniMeteor.model.translation.x <= -FLOAT_TO_FX32(90.0)
        || work->aniMeteor.model.translation.y <= -FLOAT_TO_FX32(60.0))
    {
        DestroyCurrentExTask();
    }
    else if (work->aniMeteor.hitChecker.hitFlags.value_1)
    {
        switch (work->aniMeteor.hitChecker.type)
        {
            case 2:
                if (work->aniMeteor.hitChecker.hitFlags.value_2)
                    ExMeteor_Action_Shatter();
                else
                    ExMeteor_Action_Reflect();
                break;

            default:
                ExMeteor_Action_Shatter();
                break;
        }
    }
    else
    {
        exDrawReqTask__AddRequest(&work->aniMeteor, &work->aniMeteor.config);
        exHitCheckTask__AddHitCheck(&work->aniMeteor.hitChecker);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExMeteor_Action_Shatter(void)
{
    exEffectMeteoTask *work = ExTaskGetWorkCurrent(exEffectMeteoTask);

    work->aniMeteor.hitChecker.hitFlags.value_1 = FALSE;

    work->mdlMeteorBroken.model.translation.x = work->aniMeteor.model.translation.x;
    work->mdlMeteorBroken.model.translation.y = work->aniMeteor.model.translation.y;
    work->mdlMeteorBroken.model.translation.z = work->aniMeteor.model.translation.z;

    SetCurrentExTaskMainEvent(ExMeteor_Main_Shatter);
    ExMeteor_Main_Shatter();
}

void ExMeteor_Main_Shatter(void)
{
    exEffectMeteoTask *work = ExTaskGetWorkCurrent(exEffectMeteoTask);

    exDrawReqTask__Model__Animate(&work->mdlMeteorBroken);

    if (exDrawReqTask__Model__IsAnimFinished(&work->mdlMeteorBroken))
    {
        DestroyCurrentExTask();
    }
    else
    {
        exDrawReqTask__AddRequest(&work->mdlMeteorBroken, &work->mdlMeteorBroken.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExMeteor_Action_Reflect(void)
{
    exEffectMeteoTask *work = ExTaskGetWorkCurrent(exEffectMeteoTask);

    work->aniMeteor.hitChecker.hitFlags.value_1 = FALSE;

    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        if (work->aniMeteor.hitChecker.power == 6)
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
        if (work->aniMeteor.hitChecker.power == 7)
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(4.0), work->velocity.y);
        }
        else
        {
            work->velocity.y = MultiplyFX(FLOAT_TO_FX32(6.0), work->velocity.y);
        }
    }

    SetCurrentExTaskMainEvent(ExMeteor_Main_Reflect);
    ExMeteor_Main_Reflect();
}

void ExMeteor_Main_Reflect(void)
{
    exEffectMeteoTask *work = ExTaskGetWorkCurrent(exEffectMeteoTask);

    exDrawReqTask__Model__Animate(&work->aniMeteor);

    work->aniMeteor.model.translation.y += work->velocity.y;

    if (work->aniMeteor.model.translation.x >= FLOAT_TO_FX32(90.0) || work->aniMeteor.model.translation.x <= -FLOAT_TO_FX32(90.0)
        || work->aniMeteor.model.translation.y >= FLOAT_TO_FX32(200.0))
    {
        DestroyCurrentExTask();
    }
    else
    {
        exDrawReqTask__AddRequest(&work->aniMeteor, &work->aniMeteor.config);

        RunCurrentExTaskUnknownEvent();
    }
}

BOOL CreateExMeteor(VecFx32 position, VecFx32 velocity)
{
    Task *task = ExTaskCreate(ExMeteor_Main_Init, ExMeteor_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x4000, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exEffectMeteoTask);

    exEffectMeteoTask *work = ExTaskGetWork(task, exEffectMeteoTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExMeteor_TaskUnknown);

    if (!LoadExMeteorAssets(&work->aniMeteor))
    {
        work->isActive = FALSE;
        return TRUE;
    }

    work->isActive = TRUE;
    exDrawReqTask__SetConfigPriority(&work->aniMeteor.config, 0xA800);
    exDrawReqTask__Func_21641F0(&work->aniMeteor.config);

    if (!LoadExBrokenMeteorAssets(&work->mdlMeteorBroken))
    {
        work->isActive = FALSE;
        return TRUE;
    }

    work->isActive = TRUE;
    exDrawReqTask__SetConfigPriority(&work->mdlMeteorBroken.config, 0xA800);
    exDrawReqTask__Func_21641F0(&work->mdlMeteorBroken.config);

    work->aniMeteor.model.translation.x = position.x;
    work->aniMeteor.model.translation.y = position.y;
    work->velocity.x                    = velocity.x;
    work->velocity.y                    = velocity.y;
    work->velocity.z                    = velocity.z;

    return TRUE;
}

// ExMeteorManager
void ExMeteorManager_Main_Init(void)
{
    exEffectMeteoAdminTask *work = ExTaskGetWorkCurrent(exEffectMeteoAdminTask);

    exEffectMeteoAdminTask__TaskSingleton = GetCurrentTask();

    ConfigureExMeteorManagerSpawning();
    work->tablePos       = 0;
    work->tableLoopCount = 0;

    work->spawnConfig = exMeteorManagerSpawnConfig[work->tableID][work->tablePos];

    work->tableSize = exMeteorManagerSpawnTableInfo[work->tableID];

    SetCurrentExTaskMainEvent(ExMeteorManager_Main_Active);
}

void ExMeteorManager_TaskUnknown(void)
{
    exEffectMeteoAdminTask *work = ExTaskGetWorkCurrent(exEffectMeteoAdminTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExMeteorManager_Destructor(void)
{
    exEffectMeteoAdminTask *work = ExTaskGetWorkCurrent(exEffectMeteoAdminTask);
    UNUSED(work);

    exEffectMeteoAdminTask__TaskSingleton = NULL;
}

void ExMeteorManager_Main_Active(void)
{
    exEffectMeteoAdminTask *work = ExTaskGetWorkCurrent(exEffectMeteoAdminTask);

    if (GetExSystemStatus()->state != EXSYSTASK_STATE_STAGE_FINISHED)
    {
        if (work->spawnConfig.spawnDelay-- < 0)
        {
            VecFx32 meteorPos;
            meteorPos.x = FLOAT_TO_FX32(0.0);
            meteorPos.y = FLOAT_TO_FX32(190.0);
            meteorPos.z = FLOAT_TO_FX32(0.0);

            VecFx32 meteorVel;
            meteorVel.x = FLOAT_TO_FX32(0.0);

            float meteorY;
            if (work->spawnConfig.velocity > 0.0f)
            {
                meteorY = ((float)FLOAT_TO_FX32(1.0) * work->spawnConfig.velocity) + 0.5f;
            }
            else
            {
                meteorY = ((float)FLOAT_TO_FX32(1.0) * work->spawnConfig.velocity) - 0.5f;
            }
            meteorVel.y = meteorY;
            meteorVel.z = FLOAT_TO_FX32(0.0);

            if (work->spawnConfig.spawnPos.useColumnL4)
            {
                meteorPos.x = FLOAT_TO_FX32(40.0);
                CreateExMeteor(meteorPos, meteorVel);
            }

            if (work->spawnConfig.spawnPos.useColumnL3)
            {
                meteorPos.x = FLOAT_TO_FX32(30.0);
                CreateExMeteor(meteorPos, meteorVel);
            }

            if (work->spawnConfig.spawnPos.useColumnL2)
            {
                meteorPos.x = FLOAT_TO_FX32(20.0);
                CreateExMeteor(meteorPos, meteorVel);
            }

            if (work->spawnConfig.spawnPos.useColumnL1)
            {
                meteorPos.x = FLOAT_TO_FX32(10.0);
                CreateExMeteor(meteorPos, meteorVel);
            }

            if (work->spawnConfig.spawnPos.useColumnR1)
            {
                meteorPos.x = -FLOAT_TO_FX32(10.0);
                CreateExMeteor(meteorPos, meteorVel);
            }

            if (work->spawnConfig.spawnPos.useColumnR2)
            {
                meteorPos.x = -FLOAT_TO_FX32(20.0);
                CreateExMeteor(meteorPos, meteorVel);
            }

            if (work->spawnConfig.spawnPos.useColumnR3)
            {
                meteorPos.x = -FLOAT_TO_FX32(30.0);
                CreateExMeteor(meteorPos, meteorVel);
            }

            if (work->spawnConfig.spawnPos.useColumnR4)
            {
                meteorPos.x = -FLOAT_TO_FX32(40.0);
                CreateExMeteor(meteorPos, meteorVel);
            }

            work->tablePos++;
            if (work->tablePos < work->tableSize)
            {
                work->spawnConfig = exMeteorManagerSpawnConfig[work->tableID][work->tablePos];
            }
            else
            {
                work->tableLoopCount++;
                work->tablePos = 0;

                work->spawnConfig = exMeteorManagerSpawnConfig[work->tableID][work->tablePos];
            }
        }

        ConfigureExMeteorManagerSpawning();

        RunCurrentExTaskUnknownEvent();
    }
}

void ConfigureExMeteorManagerSpawning(void)
{
    exEffectMeteoAdminTask *work = ExTaskGetWorkCurrent(exEffectMeteoAdminTask);

    u8 tableID = 0;
    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        switch (GetExSystemStatus()->state)
        {
            case EXSYSTASK_STATE_STARTED:
            case EXSYSTASK_STATE_2:
            case EXSYSTASK_STATE_BOSS_ACTIVE:
                tableID = 0;
                break;

            case EXSYSTASK_STATE_BOSS_FLEE_DONE:
            case EXSYSTASK_STATE_BOSS_HEAL_PHASE2_DONE:
            case EXSYSTASK_STATE_BOSS_HEAL_PHASE3_DONE:
                DestroyCurrentExTask();
                break;
        }
    }
    else
    {
        switch (GetExSystemStatus()->state)
        {
            case EXSYSTASK_STATE_STARTED:
            case EXSYSTASK_STATE_2:
            case EXSYSTASK_STATE_BOSS_ACTIVE:
                tableID = 1;
                break;

            case EXSYSTASK_STATE_BOSS_FLEE_DONE:
            case EXSYSTASK_STATE_BOSS_HEAL_PHASE2_DONE:
            case EXSYSTASK_STATE_BOSS_HEAL_PHASE3_DONE:
                DestroyCurrentExTask();
                break;
        }
    }

    work->tableID = tableID;
}

BOOL CreateExMeteorManager(void)
{
    Task *task = ExTaskCreate(ExMeteorManager_Main_Init, ExMeteorManager_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x4000, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exEffectMeteoAdminTask);

    exEffectMeteoAdminTask *work = ExTaskGetWork(task, exEffectMeteoAdminTask);
    UNUSED(work);

    SetExTaskUnknownEvent(task, ExMeteorManager_TaskUnknown);

    return TRUE;
}

void DestroyExMeteorManager(void)
{
    if (exEffectMeteoAdminTask__TaskSingleton != NULL)
        DestroyExTask(exEffectMeteoAdminTask__TaskSingleton);
}