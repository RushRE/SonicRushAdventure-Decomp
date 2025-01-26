#include <ex/system/exGameSystem.h>
#include <ex/system/exStage.h>
#include <ex/boss/exBoss.h>
#include <ex/player/exPlayer.h>
#include <ex/core/exRingManager.h>
#include <game/audio/audioSystem.h>

// --------------------
// VARIABLES
// --------------------

static Task *exGameSystemTaskSingleton;

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void exEffectMeteoAdminTask__Create(void);
NOT_DECOMPILED void exEffectMeteoAdminTask__Destroy_2168044(void);

// --------------------
// FUNCTION DECLS
// --------------------

// ExGameSystem
static void ExGameSystem_Main_Init(void);
static void ExGameSystem_TaskUnknown(void);
static void ExGameSystem_Destructor(void);
static void ExGameSystem_Action_WaitForState4(void);
static void ExGameSystem_Action_WaitForBossTrigger(void);
static void ExGameSystem_Main_WaitForBossTrigger(void);
static void ExGameSystem_Action_CreateStageObjects(void);
static void ExGameSystem_Main_CreatedStageObjects(void);
static void ExGameSystem_Action_StopSpawningMeteors(void);
static void ExGameSystem_Main_StoppedSpawningMeteors(void);
static void ExGameSystem_Main_GoIdle(void);
static void ExGameSystem_Main_Idle(void);

// --------------------
// FUNCTIONS
// --------------------

// ExGameSystem
void ExGameSystem_Main_Init(void)
{
    exGameSystemTask *work = ExTaskGetWorkCurrent(exGameSystemTask);

    exGameSystemTaskSingleton = GetCurrentTask();
    TaskInitWork8(work);

    work->status = GetExSystemStatus();

    CreateExStage();
    exPlayerAdminTask__Create();
    exBossSysAdminTask__Create();

    PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_ZONE_SEQ_SEQ_BOSSE);

    SetCurrentExTaskMainEvent(ExGameSystem_Action_WaitForState4);
}

void ExGameSystem_TaskUnknown(void)
{
    exGameSystemTask *work = ExTaskGetWorkCurrent(exGameSystemTask);

    work->field_2++;
    if (work->field_2 == 0)
        work->field_0++;
}

void ExGameSystem_Destructor(void)
{
    exGameSystemTask *work = ExTaskGetWorkCurrent(exGameSystemTask);
    UNUSED(work);

    exEffectRingAdminTask__Destroy();
    ExBossSysAdminTask__Destroy();
    exPlayerAdminTask__Destroy_2171730();
    DestroyExStage();
    exEffectMeteoAdminTask__Destroy_2168044();

    exGameSystemTaskSingleton = NULL;
}

void ExGameSystem_Action_WaitForState4(void)
{
    exGameSystemTask *work = ExTaskGetWorkCurrent(exGameSystemTask);
    UNUSED(work);

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_4)
    {
        ExGameSystem_Action_WaitForBossTrigger();
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExGameSystem_Action_WaitForBossTrigger(void)
{
    exGameSystemTask *work = ExTaskGetWorkCurrent(exGameSystemTask);
    UNUSED(work);

    SetCurrentExTaskMainEvent(ExGameSystem_Main_WaitForBossTrigger);
    ExGameSystem_Main_WaitForBossTrigger();

    RunCurrentExTaskUnknownEvent();
}

void ExGameSystem_Main_WaitForBossTrigger(void)
{
    exGameSystemTask *work = ExTaskGetWorkCurrent(exGameSystemTask);
    UNUSED(work);

    if (!ExBossSysAdminTask__Func_215DF1C())
    {
        ExGameSystem_Action_CreateStageObjects();
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExGameSystem_Action_CreateStageObjects(void)
{
    exGameSystemTask *work = ExTaskGetWorkCurrent(exGameSystemTask);

    exEffectMeteoAdminTask__Create();
    exEffectRingAdminTask__Create();

    work->timer = SECONDS_TO_FRAMES(15.0);

    SetCurrentExTaskMainEvent(ExGameSystem_Main_CreatedStageObjects);
    ExGameSystem_Main_CreatedStageObjects();
}

void ExGameSystem_Main_CreatedStageObjects(void)
{
    exGameSystemTask *work = ExTaskGetWorkCurrent(exGameSystemTask);

    if (work->timer-- == 0)
    {
        ExGameSystem_Action_StopSpawningMeteors();
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExGameSystem_Action_StopSpawningMeteors(void)
{
    exGameSystemTask *work = ExTaskGetWorkCurrent(exGameSystemTask);

    exEffectMeteoAdminTask__Destroy_2168044();

    work->timer = 0;

    ExBossSysAdminTask__Func_215DF2C(1, 0);

    SetCurrentExTaskMainEvent(ExGameSystem_Main_StoppedSpawningMeteors);
    ExGameSystem_Main_StoppedSpawningMeteors();
}

void ExGameSystem_Main_StoppedSpawningMeteors(void)
{
    exGameSystemTask *work = ExTaskGetWorkCurrent(exGameSystemTask);
    UNUSED(work);

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_10)
    {
        ExGameSystem_Main_GoIdle();
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExGameSystem_Main_GoIdle(void)
{
    exGameSystemTask *work = ExTaskGetWorkCurrent(exGameSystemTask);
    UNUSED(work);

    SetCurrentExTaskMainEvent(ExGameSystem_Main_Idle);
    ExGameSystem_Main_Idle();
}

void ExGameSystem_Main_Idle(void)
{
    exGameSystemTask *work = ExTaskGetWorkCurrent(exGameSystemTask);
    UNUSED(work);

    RunCurrentExTaskUnknownEvent();
}

void CreateExGameSystem(void)
{
    Task *task =
        ExTaskCreate(ExGameSystem_Main_Init, ExGameSystem_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1000, TASK_GROUP(1), 0, EXTASK_TYPE_REGULAR, exGameSystemTask);

    exGameSystemTask *work = ExTaskGetWork(task, exGameSystemTask);
    UNUSED(work);

    SetExTaskUnknownEvent(task, ExGameSystem_TaskUnknown);
}

void DestroyExGameSystem(void)
{
    if (exGameSystemTaskSingleton != NULL)
        DestroyExTask(exGameSystemTaskSingleton);
}
