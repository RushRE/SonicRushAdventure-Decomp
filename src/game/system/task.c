#include <game/system/task.h>

// --------------------
// VARIABLES
// --------------------

TaskList taskList;

Task *activeTaskList[TASK_MAX_ACTIVE_SIZE];
Task reserveTaskList[TASK_MAX_ACTIVE_SIZE];

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
    taskList.flags     = TASKLIST_FLAG_NONE;
    taskList.priority  = 0;
    taskList.taskCount = 0;

    MI_CpuClear32(reserveTaskList, sizeof(reserveTaskList));

    for (s32 i = 0; i < TASK_MAX_ACTIVE_SIZE; i++)
    {
        activeTaskList[i] = &reserveTaskList[i];
    }

    taskList.updateListStart = AllocTask();
    taskList.updateListEnd   = AllocTask();
    taskList.renderListStart = AllocTask();
    taskList.renderListEnd   = AllocTask();

    taskList.updateListStart->prev       = NULL;
    taskList.updateListStart->next       = taskList.updateListEnd;
    taskList.updateListStart->main       = NULL;
    taskList.updateListStart->dtor       = NULL;
    taskList.updateListStart->usrFlags   = TASK_FLAG_DISABLE_DESTROY;
    taskList.updateListStart->priority   = TASK_PRIORITY_UPDATE_LIST_START;
    taskList.updateListStart->group      = TASK_GROUP_HIGHEST;
    taskList.updateListStart->pauseLevel = TASK_PAUSE_HIGHEST;

    taskList.updateListEnd->prev       = taskList.updateListStart;
    taskList.updateListEnd->next       = taskList.renderListStart;
    taskList.updateListEnd->main       = NULL;
    taskList.updateListEnd->dtor       = NULL;
    taskList.updateListEnd->usrFlags   = TASK_FLAG_DISABLE_DESTROY;
    taskList.updateListEnd->priority   = TASK_PRIORITY_UPDATE_LIST_END;
    taskList.updateListEnd->group      = TASK_GROUP_HIGHEST;
    taskList.updateListEnd->pauseLevel = TASK_PAUSE_HIGHEST;

    taskList.renderListStart->prev       = taskList.updateListEnd;
    taskList.renderListStart->next       = taskList.renderListEnd;
    taskList.renderListStart->main       = NULL;
    taskList.renderListStart->dtor       = NULL;
    taskList.renderListStart->usrFlags   = TASK_FLAG_DISABLE_DESTROY;
    taskList.renderListStart->priority   = TASK_PRIORITY_RENDER_LIST_START;
    taskList.renderListStart->group      = TASK_GROUP_HIGHEST;
    taskList.renderListStart->pauseLevel = TASK_PAUSE_HIGHEST;

    taskList.renderListEnd->prev       = taskList.renderListStart;
    taskList.renderListEnd->next       = NULL;
    taskList.renderListEnd->main       = NULL;
    taskList.renderListEnd->dtor       = NULL;
    taskList.renderListEnd->usrFlags   = TASK_FLAG_DISABLE_DESTROY;
    taskList.renderListEnd->priority   = TASK_PRIORITY_RENDER_LIST_END;
    taskList.renderListEnd->group      = TASK_GROUP_HIGHEST;
    taskList.renderListEnd->pauseLevel = TASK_PAUSE_HIGHEST;

    taskList.curTask = taskList.updateListStart;
}

void RunUpdateTaskList(void)
{
    RunTaskList(taskList.updateListStart, taskList.updateListEnd);
}

void RunRenderTaskList(void)
{
    RunTaskList(taskList.renderListStart, taskList.renderListEnd);
}

void ClearTaskLists(void)
{
    for (Task *task = taskList.updateListStart->next; task != taskList.updateListEnd;)
    {
        Task *next = task->next;
        
        if ((task->sysFlags & TASK_FLAG_INACTIVE) != 0)
            FreeTask(task);
        
        task = next;
    }

    for (Task *task = taskList.renderListStart->next; task != taskList.renderListEnd;)
    {
        Task *next = task->next;
        
        if ((task->sysFlags & TASK_FLAG_INACTIVE) != 0)
            FreeTask(task);
        
        task = next;
    }

    taskList.flags &= ~TASKLIST_FLAG_PRIORITY_ACTIVE;
    if ((taskList.flags & TASKLIST_FLAG_PRIORITY_ENABLED) != 0)
        taskList.flags |= TASKLIST_FLAG_PRIORITY_ACTIVE;
}

#ifdef RUSH_DEBUG
Task *TaskCreate_(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u32 priority, TaskGroup group, size_t workSize, const char* name)
#else
Task *TaskCreate_(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u32 priority, TaskGroup group, size_t workSize)
#endif
{
    Task *task = AllocTask();
    if (HeapNull == task)
        return (Task *)HeapNull;

    task->main       = taskMain;
    task->dtor       = taskDestructor;
    task->sysFlags   = TASK_FLAG_NONE;
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
            next = taskList.updateListEnd;
        }
        else
        {
            // place task at the start-ish of the list
            next = taskList.updateListStart->next;
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
            next = taskList.renderListEnd;
        }
        else
        {
            // place task at the start-ish of the list
            next = taskList.renderListStart->next;
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
    if (HeapNull != task && (task->sysFlags & TASK_FLAG_INACTIVE) == 0)
    {
        if ((task->usrFlags & TASK_FLAG_DISABLE_DESTROY) == 0 || taskList.curTask == task)
        {
            if (task->dtor != NULL)
                task->dtor(task);

            if (task->workPtr != NULL)
                HeapFree(HEAP_SYSTEM, task->workPtr);

            task->workPtr = NULL;
            task->sysFlags |= TASK_FLAG_INACTIVE;
        }
    }
}

void DestroyCurrentTask(void)
{
    DestroyTask(taskList.curTask);
}

void CloseTaskSystem(void)
{
    Task *task = NULL;
    for (task = taskList.updateListStart->next; task != taskList.updateListEnd; task = task->next)
    {
        DestroyTask(task);
    }

    for (task = taskList.renderListStart->next; task != taskList.renderListEnd; task = task->next)
    {
        DestroyTask(task);
    }
}

void DestroyTaskGroup(s32 group)
{
    Task *task = NULL;
    for (task = taskList.updateListStart->next; task != taskList.renderListEnd; task = task->next)
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
    taskList.curTask->main = main;
}

void SetTaskDestructorEvent(Task *task, TaskDestructor dtor)
{
    task->dtor = dtor;
}

Task *GetCurrentTask(void)
{
    return taskList.curTask;
}

void *GetTaskWork_(Task *task)
{
    return task->workPtr;
}

void *GetCurrentTaskWork_(void)
{
    return taskList.curTask->workPtr;
}

void SetTaskFlags(Task *task, TaskFlags flags)
{
    task->usrFlags = flags;
}

void SetTaskPauseLevel(Task *task, u8 pauseLevel)
{
    task->pauseLevel = pauseLevel;
}

void StartTaskPause(u8 priority)
{
    taskList.flags |= TASKLIST_FLAG_PRIORITY_ENABLED;
    taskList.priority = priority;
}

void EndTaskPause(void)
{
    taskList.flags &= ~TASKLIST_FLAG_PRIORITY_ENABLED;
}

BOOL CheckTaskPaused(u8 *priority)
{
    if (priority != NULL)
        *priority = taskList.priority;

    return (taskList.flags & TASKLIST_FLAG_PRIORITY_ENABLED) != 0;
}

Task* AllocTask(void)
{
	if (taskList.taskCount >= TASK_MAX_ACTIVE_SIZE)
        return HeapNull;

    Task *next = activeTaskList[taskList.taskCount];
	taskList.taskCount++;

    return next;
}

void RunTaskList(Task *task, Task *lastTask)
{
  	task = task->next;
    taskList.curTask = task;

    while (task != lastTask)
    {
        if ((task->sysFlags & TASK_FLAG_INACTIVE) == 0)
        {
            if (task->main)
            {
                if ((taskList.flags & TASKLIST_FLAG_PRIORITY_ACTIVE) != 0)
                {
                    if ((task->usrFlags & 1) != 0 || taskList.priority < (u32)task->pauseLevel)
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
        
        task = task->next;
        taskList.curTask = task;
    }
}

void FreeTask(Task *task)
{
    if (HeapNull != task)
    {
        task->prev->next = task->next;
        task->next->prev = task->prev;

        taskList.taskCount--;
        activeTaskList[taskList.taskCount] = task;
    }
}

