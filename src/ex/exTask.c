#include <ex/system/exTask.h>
#include <ex/system/exSystem.h>
#include <game/input/padInput.h>

// --------------------
// MACROS
// --------------------

#define ExTaskGetTaskInternal(task) ((ExTask *)TaskGetWork(task, ExTask))

// --------------------
// STRUCTS
// --------------------

struct ExTaskMemoryLayout
{
    ExTask exTask;
    u8 userWork[1]; // used for addressing purposes
};

// --------------------
// VARIABLES
// --------------------

static Task *currentExTask;
static BOOL disableExTaskUpdate;

// --------------------
// FUNCTION DECLS
// --------------------

static void ExTask_Main_AlwaysUpdate(void);
static void ExTask_Destructor_AlwaysUpdate(Task *task);

static void ExTask_Main_Regular(void);
static void ExTask_Destructor_Regular(Task *task);

// --------------------
// FUNCTIONS
// --------------------

// ========
// Internal
// ========

void ExTask_Main_AlwaysUpdate(void)
{
    currentExTask = GetCurrentTask();
    ExTask *task  = ExTaskGetTaskInternal(currentExTask);

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_STAGE_FINISHED)
    {
        padInput.btnDown        = PAD_INPUT_NONE_MASK;
        padInput.btnPress       = PAD_INPUT_NONE_MASK;
        padInput.prevBtnDown    = PAD_INPUT_NONE_MASK;
        padInput.btnRelease     = PAD_INPUT_NONE_MASK;
        padInput.btnPressRepeat = PAD_INPUT_NONE_MASK;
    }

    task->main();
}

void ExTask_Destructor_AlwaysUpdate(Task *task)
{
    ExTask *work = ExTaskGetTaskInternal(task);

    if (work->dtor != NULL)
        work->dtor();
}

void ExTask_Main_Regular(void)
{
    if (GetExSystemStatus()->state == EXSYSTASK_STATE_STAGE_FINISHED)
    {
        padInput.btnDown        = PAD_INPUT_NONE_MASK;
        padInput.btnPress       = PAD_INPUT_NONE_MASK;
        padInput.prevBtnDown    = PAD_INPUT_NONE_MASK;
        padInput.btnRelease     = PAD_INPUT_NONE_MASK;
        padInput.btnPressRepeat = PAD_INPUT_NONE_MASK;
    }

    currentExTask = GetCurrentTask();
    ExTask *task  = ExTaskGetTaskInternal(currentExTask);

    if (disableExTaskUpdate)
        return;

    if (task->hitstopTimer > 0)
    {
        task->hitstopTimer--;

        if (task->onHitstopActive == NULL)
            return;
    }
    else
    {
        task->main();
        return;
    }

    task->onHitstopActive();
}

void ExTask_Destructor_Regular(Task *task)
{
    ExTask *work = ExTaskGetTaskInternal(task);

    if (work->dtor != NULL)
        work->dtor();
}

// ======
// ExTask
// ======

Task *ExTaskCreate_(ExTaskMain main, ExTaskDestructor destructor, u16 priority, TaskGroup group, u8 pauseLevel, size_t workSize, const char *name, ExTaskType type)
{
#ifndef RUSH_DEBUG
    UNUSED(name); // probably used in debug builds
#endif

    Task *task;
    size_t memSize = sizeof(ExTask) + workSize;

    switch (type)
    {
        case EXTASK_TYPE_REGULAR:
#ifdef RUSH_DEBUG
            task = TaskCreate_(ExTask_Main_Regular, ExTask_Destructor_Regular, TASK_FLAG_NONE, pauseLevel, priority, group, memSize, name);
#else
            task = TaskCreate_(ExTask_Main_Regular, ExTask_Destructor_Regular, TASK_FLAG_NONE, pauseLevel, priority, group, memSize);
#endif
            break;

        case EXTASK_TYPE_ALWAYSUPDATE:
#ifdef RUSH_DEBUG
            task = TaskCreate_(ExTask_Main_Regular, ExTask_Destructor_AlwaysUpdate, TASK_FLAG_NONE, pauseLevel, priority, group, memSize, name);
#else
            task = TaskCreate_(ExTask_Main_AlwaysUpdate, ExTask_Destructor_AlwaysUpdate, TASK_FLAG_NONE, pauseLevel, priority, group, memSize);
#endif
            break;

        default:
#ifdef RUSH_DEBUG
            task = TaskCreate_(ExTask_Main_Regular, ExTask_Destructor_Regular, TASK_FLAG_NONE, pauseLevel, priority, group, memSize, name);
#else
            task = TaskCreate_(ExTask_Main_Regular, ExTask_Destructor_Regular, TASK_FLAG_NONE, pauseLevel, priority, group, memSize);
#endif
            break;
    }

    if (task == NULL)
        return NULL;

    ExTask *exTask = GetExTask(task);
    MI_CpuClear8(exTask, memSize);

    exTask->main            = main;
    exTask->dtor            = destructor;
    exTask->priority        = priority;
    exTask->group           = group;
    exTask->onHitstopActive = NULL;

#ifdef RUSH_DEBUG
    exTask->name = name;
#endif

    return task;
}

ExTask *GetExTaskCurrent(void)
{
    return TaskGetWork(currentExTask, ExTask);
}

void *GetExTaskWorkCurrent_(void)
{
    struct ExTaskMemoryLayout *work = (struct ExTaskMemoryLayout *)GetExTaskCurrent();
    return (void *)work->userWork;
}

ExTask *GetExTask(Task *task)
{
    return TaskGetWork(task, ExTask);
}

void *GetExTaskWork_(Task *task)
{
    struct ExTaskMemoryLayout *work = (struct ExTaskMemoryLayout *)GetExTask(task);
    return (void *)work->userWork;
}

// ======
// States
// ======

void ExTask_State_Destroy(void)
{
    DestroyCurrentTask();
}

// =======
// Setters
// =======

void EnableExTaskNoUpdate(BOOL enabled)
{
    disableExTaskUpdate = enabled;
}
