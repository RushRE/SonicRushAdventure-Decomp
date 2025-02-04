#ifndef RUSH_TASK_H
#define RUSH_TASK_H

#include <global.h>
#include <game/system/allocator.h>
#include <game/math/mtMath.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define TASK_MAX_ACTIVE_SIZE 256

// --------------------
// MACROS
// --------------------

#ifdef RUSH_DEBUG
#define TaskCreate(taskMain, taskDestructor, flags, pauseLevel, priority, group, name)       TaskCreate_(taskMain, taskDestructor, flags, pauseLevel, priority, group, sizeof(name), #name)
#define TaskCreateNoWork(taskMain, taskDestructor, flags, pauseLevel, priority, group, name) TaskCreate_(taskMain, taskDestructor, flags, pauseLevel, priority, group, 0, #name)
#else
#define TaskCreate(taskMain, taskDestructor, flags, pauseLevel, priority, group, name)       TaskCreate_(taskMain, taskDestructor, flags, pauseLevel, priority, group, sizeof(name))
#define TaskCreateNoWork(taskMain, taskDestructor, flags, pauseLevel, priority, group, name) TaskCreate_(taskMain, taskDestructor, flags, pauseLevel, priority, group, 0)
#endif

#define TaskGetWork(task, type)  ((type *)GetTaskWork_(task))
#define TaskGetWorkCurrent(type) ((type *)GetCurrentTaskWork_())
#define TaskInitWork8(work)      MI_CpuClear8(work, sizeof(*work))
#define TaskInitWork16(work)     MI_CpuClear16(work, sizeof(*work))
#define TaskInitWork32(work)     MI_CpuClear32(work, sizeof(*work))

// --------------------
// TYPEDEFS
// --------------------

struct Task_;

typedef void (*TaskMain)(void);
typedef void (*TaskDestructor)(struct Task_ *task);

// --------------------
// ENUMS
// --------------------

// just a simple macro to visualize task groups better
#define TASK_GROUP(num) (num)

enum TaskGroup_
{
    TASK_GROUP_LOWEST  = 0x00,
    TASK_GROUP_HIGHEST = 0xFF
};
typedef u8 TaskGroup;

enum TaskPauseLevel_
{
    TASK_PAUSE_LOWEST  = 0x00,
    TASK_PAUSE_HIGHEST = 0xFF
};
typedef u8 TaskPauseLevel;

enum TaskPriority
{
    TASK_PRIORITY_UPDATE_LIST_START = 0x0000,
    TASK_PRIORITY_UPDATE_LIST_END   = 0xEFFF,

    TASK_PRIORITY_RENDER_LIST_START = 0xF000,
    TASK_PRIORITY_RENDER_LIST_END   = 0xFFFF,
};

enum TaskFlags_
{
    TASK_FLAG_NONE = 0,

    TASK_FLAG_INACTIVE        = 1 << 0,
    TASK_FLAG_DISABLE_DESTROY = 1 << 1,
};
typedef u16 TaskFlags;

enum TaskListFlags_
{
    TASKLIST_FLAG_NONE = 0,

    TASKLIST_FLAG_PRIORITY_ENABLED = 1 << 0,
    TASKLIST_FLAG_PRIORITY_ACTIVE  = 1 << 1,
};
typedef u16 TaskListFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct Task_
{
    struct Task_ *prev;
    struct Task_ *next;
    TaskMain main;
    TaskDestructor dtor;
    void *workPtr;
    TaskFlags sysFlags;
    TaskFlags usrFlags;
    u16 priority;
    TaskGroup group;
    TaskPauseLevel pauseLevel;
    
#ifdef RUSH_DEBUG
    // exTask has this, and sonic 4 has this, so it's a likely they had this feature in debug builds as well
    const char* name;
#endif
} Task;

typedef struct TaskList_
{
    u8 priority;
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

extern TaskList taskList;

extern Task *activeTaskList[TASK_MAX_ACTIVE_SIZE];
extern Task reserveTaskList[TASK_MAX_ACTIVE_SIZE];

// --------------------
// FUNCTIONS
// --------------------

void InitTaskSystem(void);
void RunUpdateTaskList(void);
void RunRenderTaskList(void);
void ClearTaskLists(void);
#ifdef RUSH_DEBUG
Task *TaskCreate_(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u32 priority, TaskGroup group, size_t workSize, const char* name);
#else
Task *TaskCreate_(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u32 priority, TaskGroup group, size_t workSize);
#endif
void DestroyTask(Task *task);
void DestroyCurrentTask(void);
void CloseTaskSystem(void);
void DestroyTaskGroup(s32 group);
void SetTaskMainEvent(Task *task, TaskMain main);
void SetCurrentTaskMainEvent(TaskMain main);
void SetTaskDestructorEvent(Task *task, TaskDestructor destructor);
Task *GetCurrentTask(void);
void *GetTaskWork_(Task *task);  // use TaskGetWork() instead of calling this function directly!
void *GetCurrentTaskWork_(void); // use TaskGetWorkCurrent() instead of calling this function directly!
void SetTaskFlags(Task *task, TaskFlags flags);
void SetTaskPauseLevel(Task *task, u8 pauseLevel);
void StartTaskPause(u8 priority);
void EndTaskPause(void);
BOOL CheckTaskPaused(u8 *priority);

#ifdef __cplusplus
}
#endif

#endif // RUSH_TASK_H
