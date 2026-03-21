#include <game/system/task.h>

// --------------------
// STRUCTS
// --------------------

typedef struct TaskList_
{
    u8 pauseLevel;
    TaskListFlags flags;
    s16 taskCount;
    Task *updateListStart;
    Task *curTask;
    Task *updateListEnd;
    Task *renderListEnd;
    Task *renderListStart;
} TaskList;

// --------------------
// VARIABLES
// --------------------

static TaskList sTaskManager;

static Task *sActiveTaskList[TASK_MAX_ACTIVE_SIZE];
static Task sReserveTaskList[TASK_MAX_ACTIVE_SIZE];

// --------------------
// PRIVATE FUNCTIONS
// --------------------

static Task *AllocTask(void);
static void RunTaskList(Task *firstTask, Task *lastTask);
static void FreeTask(Task *task);

// --------------------
// FUNCTIONS
// --------------------

void InitTaskSystem(void)
{
    sTaskManager.flags      = TASKLIST_FLAG_NONE;
    sTaskManager.pauseLevel = TASK_PAUSE_LOWEST;
    sTaskManager.taskCount  = 0;

    MI_CpuClear32(sReserveTaskList, sizeof(sReserveTaskList));

    for (s32 i = 0; i < TASK_MAX_ACTIVE_SIZE; i++)
    {
        sActiveTaskList[i] = &sReserveTaskList[i];
    }

    sTaskManager.updateListStart = AllocTask();
    sTaskManager.updateListEnd   = AllocTask();
    sTaskManager.renderListStart = AllocTask();
    sTaskManager.renderListEnd   = AllocTask();

    sTaskManager.updateListStart->prev       = NULL;
    sTaskManager.updateListStart->next       = sTaskManager.updateListEnd;
    sTaskManager.updateListStart->main       = NULL;
    sTaskManager.updateListStart->dtor       = NULL;
    sTaskManager.updateListStart->usrFlags   = TASK_FLAG_DISABLE_EXTERNAL_DESTROY;
    sTaskManager.updateListStart->priority   = TASK_PRIORITY_UPDATE_LIST_START;
    sTaskManager.updateListStart->group      = TASK_GROUP_HIGHEST;
    sTaskManager.updateListStart->pauseLevel = TASK_PAUSE_HIGHEST;

    sTaskManager.updateListEnd->prev       = sTaskManager.updateListStart;
    sTaskManager.updateListEnd->next       = sTaskManager.renderListStart;
    sTaskManager.updateListEnd->main       = NULL;
    sTaskManager.updateListEnd->dtor       = NULL;
    sTaskManager.updateListEnd->usrFlags   = TASK_FLAG_DISABLE_EXTERNAL_DESTROY;
    sTaskManager.updateListEnd->priority   = TASK_PRIORITY_UPDATE_LIST_END;
    sTaskManager.updateListEnd->group      = TASK_GROUP_HIGHEST;
    sTaskManager.updateListEnd->pauseLevel = TASK_PAUSE_HIGHEST;

    sTaskManager.renderListStart->prev       = sTaskManager.updateListEnd;
    sTaskManager.renderListStart->next       = sTaskManager.renderListEnd;
    sTaskManager.renderListStart->main       = NULL;
    sTaskManager.renderListStart->dtor       = NULL;
    sTaskManager.renderListStart->usrFlags   = TASK_FLAG_DISABLE_EXTERNAL_DESTROY;
    sTaskManager.renderListStart->priority   = TASK_PRIORITY_RENDER_LIST_START;
    sTaskManager.renderListStart->group      = TASK_GROUP_HIGHEST;
    sTaskManager.renderListStart->pauseLevel = TASK_PAUSE_HIGHEST;

    sTaskManager.renderListEnd->prev       = sTaskManager.renderListStart;
    sTaskManager.renderListEnd->next       = NULL;
    sTaskManager.renderListEnd->main       = NULL;
    sTaskManager.renderListEnd->dtor       = NULL;
    sTaskManager.renderListEnd->usrFlags   = TASK_FLAG_DISABLE_EXTERNAL_DESTROY;
    sTaskManager.renderListEnd->priority   = TASK_PRIORITY_RENDER_LIST_END;
    sTaskManager.renderListEnd->group      = TASK_GROUP_HIGHEST;
    sTaskManager.renderListEnd->pauseLevel = TASK_PAUSE_HIGHEST;

    sTaskManager.curTask = sTaskManager.updateListStart;
}

void RunUpdateTaskList(void)
{
    RunTaskList(sTaskManager.updateListStart, sTaskManager.updateListEnd);
}

void RunRenderTaskList(void)
{
    RunTaskList(sTaskManager.renderListStart, sTaskManager.renderListEnd);
}

void ClearTaskLists(void)
{
    for (Task *task = sTaskManager.updateListStart->next; task != sTaskManager.updateListEnd;)
    {
        Task *next = task->next;

        if ((task->sysFlags & TASK_SYSFLAG_INACTIVE) != 0)
            FreeTask(task);

        task = next;
    }

    for (Task *task = sTaskManager.renderListStart->next; task != sTaskManager.renderListEnd;)
    {
        Task *next = task->next;

        if ((task->sysFlags & TASK_SYSFLAG_INACTIVE) != 0)
            FreeTask(task);

        task = next;
    }

    sTaskManager.flags &= ~TASKLIST_FLAG_PRIORITY_ACTIVE;
    if ((sTaskManager.flags & TASKLIST_FLAG_PRIORITY_ENABLED) != 0)
        sTaskManager.flags |= TASKLIST_FLAG_PRIORITY_ACTIVE;
}

#ifdef RUSH_DEBUG
Task *TaskCreate_(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u32 priority, TaskGroup group, size_t workSize, const char *name)
#else
Task *TaskCreate_(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u32 priority, TaskGroup group, size_t workSize)
#endif
{
    Task *task = AllocTask();
    if (HeapNull == task)
        return (Task *)HeapNull;

    task->main       = taskMain;
    task->dtor       = taskDestructor;
    task->sysFlags   = TASK_SYSFLAG_NONE;
    task->usrFlags   = flags;
    task->priority   = priority;
    task->group      = group;
    task->pauseLevel = pauseLevel;
    task->workPtr    = NULL;
    if (workSize != 0)
        task->workPtr = HeapAllocHead(HEAP_SYSTEM, workSize);

#ifdef RUSH_DEBUG
    task->name = name;
#endif

    Task *next = NULL;
    if (priority <= TASK_PRIORITY_UPDATE_LIST_END)
    {
        if (priority == TASK_PRIORITY_UPDATE_LIST_END)
        {
            // place task at the end of the list
            next = sTaskManager.updateListEnd;
        }
        else
        {
            // place task at the start-ish of the list
            next = sTaskManager.updateListStart->next;
            while (priority >= next->priority)
            {
                // loop...
                next = next->next;
            }
        }
    }
    else
    {
        if (priority == TASK_PRIORITY_RENDER_LIST_END)
        {
            // place task at the end of the list
            next = sTaskManager.renderListEnd;
        }
        else
        {
            // place task at the start-ish of the list
            next = sTaskManager.renderListStart->next;
            while (priority >= next->priority)
            {
                // loop...
                next = next->next;
            }
        }
    }

    task->prev       = next->prev;
    task->next       = next;
    task->prev->next = task;
    next->prev       = task;

#ifdef RUSH_DEBUG
    // printf("TASK: Created Task '%s' => (0x%X, 0x%X)\n", name, taskMain, taskDestructor);
#endif

    return task;
}

void DestroyTask(Task *task)
{
    if (HeapNull != task && (task->sysFlags & TASK_SYSFLAG_INACTIVE) == 0)
    {
        if ((task->usrFlags & TASK_FLAG_DISABLE_EXTERNAL_DESTROY) == 0 || sTaskManager.curTask == task)
        {
            if (task->dtor != NULL)
                task->dtor(task);

            if (task->workPtr != NULL)
                HeapFree(HEAP_SYSTEM, task->workPtr);

            task->workPtr = NULL;
            task->sysFlags |= TASK_SYSFLAG_INACTIVE;
        }
    }
}

void DestroyCurrentTask(void)
{
    DestroyTask(sTaskManager.curTask);
}

void CloseTaskSystem(void)
{
    Task *task = NULL;
    for (task = sTaskManager.updateListStart->next; task != sTaskManager.updateListEnd; task = task->next)
    {
        DestroyTask(task);
    }

    for (task = sTaskManager.renderListStart->next; task != sTaskManager.renderListEnd; task = task->next)
    {
        DestroyTask(task);
    }
}

void DestroyTaskGroup(s32 group)
{
    Task *task = NULL;
    for (task = sTaskManager.updateListStart->next; task != sTaskManager.renderListEnd; task = task->next)
    {
        if (group == task->group)
            DestroyTask(task);
    }
}

void SetTaskMainEvent(Task *task, TaskMain main)
{
    task->main = main;
}

void SetCurrentTaskMainEvent(TaskMain main)
{
    sTaskManager.curTask->main = main;
}

void SetTaskDestructorEvent(Task *task, TaskDestructor dtor)
{
    task->dtor = dtor;
}

Task *GetCurrentTask(void)
{
    return sTaskManager.curTask;
}

void *GetTaskWork_(Task *task)
{
    return task->workPtr;
}

void *GetCurrentTaskWork_(void)
{
    return sTaskManager.curTask->workPtr;
}

void SetTaskFlags(Task *task, TaskFlags flags)
{
    task->usrFlags = flags;
}

void SetTaskPauseLevel(Task *task, u8 pauseLevel)
{
    task->pauseLevel = pauseLevel;
}

void StartTaskPause(u8 pauseLevel)
{
    sTaskManager.flags |= TASKLIST_FLAG_PRIORITY_ENABLED;
    sTaskManager.pauseLevel = pauseLevel;
}

void EndTaskPause(void)
{
    sTaskManager.flags &= ~TASKLIST_FLAG_PRIORITY_ENABLED;
}

BOOL CheckTaskPaused(u8 *pauseLevel)
{
    if (pauseLevel != NULL)
        *pauseLevel = sTaskManager.pauseLevel;

    return (sTaskManager.flags & TASKLIST_FLAG_PRIORITY_ENABLED) != 0;
}

Task *AllocTask(void)
{
    if (sTaskManager.taskCount >= TASK_MAX_ACTIVE_SIZE)
        return HeapNull;

    Task *next = sActiveTaskList[sTaskManager.taskCount];
    sTaskManager.taskCount++;

    return next;
}

void RunTaskList(Task *task, Task *lastTask)
{
    task             = task->next;
    sTaskManager.curTask = task;

    while (task != lastTask)
    {
        if ((task->sysFlags & TASK_SYSFLAG_INACTIVE) == 0)
        {
            if (task->main != NULL)
            {
                if ((sTaskManager.flags & TASKLIST_FLAG_PRIORITY_ACTIVE) != 0)
                {
                    if ((task->usrFlags & TASK_FLAG_IGNORE_PAUSELEVEL) != 0 || sTaskManager.pauseLevel < (u32)task->pauseLevel)
                    {
                        task->main();
                    }
                }
                else
                {
                    task->main();
                }
            }
        }

        task             = task->next;
        sTaskManager.curTask = task;
    }
}

void FreeTask(Task *task)
{
    if (HeapNull != task)
    {
        task->prev->next = task->next;
        task->next->prev = task->prev;

        sTaskManager.taskCount--;
        sActiveTaskList[sTaskManager.taskCount] = task;
    }
}
