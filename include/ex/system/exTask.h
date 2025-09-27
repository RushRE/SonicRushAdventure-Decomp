#ifndef RUSH_EXTASK_H
#define RUSH_EXTASK_H

#include <game/system/task.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// MACROS
// --------------------

#define ExTaskCreate(taskMain, taskDestructor, priority, group, pauseLevel, taskType, workType)                                                                                    \
    ExTaskCreate_(taskMain, taskDestructor, priority, group, pauseLevel, sizeof(workType), #workType, taskType)
#define ExTaskGetWork(task, type)  ((type *)GetExTaskWork_(task))
#define ExTaskGetWorkCurrent(type) ((type *)GetExTaskWorkCurrent_())
#define ExTaskInitWork8(work)      MI_CpuClear8(work, sizeof(*work))
#define ExTaskInitWork16(work)     MI_CpuClear16(work, sizeof(*work))

// --------------------
// TYPEDEFS
// --------------------

struct ExTask_;

typedef void (*ExTaskMain)(void);
typedef void (*ExTaskDestructor)(void);
typedef void (*ExTaskUnknownFunc)(void);
typedef void (*ExTaskDelayCallback)(void);

// --------------------
// ENUMS
// --------------------

enum ExTaskType_
{
    EXTASK_TYPE_REGULAR,
    EXTASK_TYPE_ALWAYSUPDATE,
};
typedef u32 ExTaskType;

// --------------------
// STRUCTS
// --------------------

typedef struct ExTask_
{
    ExTaskMain main;
    s32 unused1;
    ExTaskUnknownFunc onCheckStageFinished;
    ExTaskDestructor dtor;
    ExTaskDelayCallback onHitstopActive;
    s32 unused2;
    u16 priority;
    TaskGroup group;
    s16 hitstopTimer;

#ifdef RUSH_DEBUG
    const char *name;
#endif
} ExTask;

// --------------------
// FUNCTIONS
// --------------------

// ExTask
Task *ExTaskCreate_(ExTaskMain main, ExTaskDestructor destructor, u16 priority, TaskGroup group, u8 pauseLevel, size_t workSize, const char *name, ExTaskType type);
ExTask *GetExTaskCurrent(void);
void *GetExTaskWorkCurrent_(void);
ExTask *GetExTask(Task *task);
void *GetExTaskWork_(Task *task);

// States
void ExTask_State_Destroy(void);

// Setters
void EnableExTaskNoUpdate(BOOL enabled);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void SetExTaskMainEvent(ExTask *task, ExTaskMain main)
{
    task->main = main;
}

RUSH_INLINE void SetCurrentExTaskMainEvent(ExTaskMain main)
{
    GetExTaskCurrent()->main = main;
}

RUSH_INLINE void DestroyExTask(Task *task)
{
    SetExTaskMainEvent(GetExTask(task), ExTask_State_Destroy);
}

RUSH_INLINE void DestroyCurrentExTask(void)
{
    SetCurrentExTaskMainEvent(ExTask_State_Destroy);
}

RUSH_INLINE void SetExTaskOnCheckStageFinishedEvent(Task *task, ExTaskUnknownFunc event)
{
    GetExTask(task)->onCheckStageFinished = event;
}

RUSH_INLINE void RunExTaskOnCheckStageFinishedEvent(ExTask *task)
{
    task->onCheckStageFinished();
}

RUSH_INLINE void RunCurrentExTaskOnCheckStageFinishedEvent(void)
{
    GetExTaskCurrent()->onCheckStageFinished();
}

RUSH_INLINE void SetExTaskOnHitstopActiveEvent(Task *task, ExTaskDelayCallback event)
{
    GetExTask(task)->onHitstopActive = event;
}

RUSH_INLINE void SetExTaskHitstopTimer(Task *task, s16 hitstopTimer)
{
    GetExTask(task)->hitstopTimer = hitstopTimer;
}

RUSH_INLINE void SetCurrentExTaskHitstopTimer(s16 hitstopTimer)
{
    GetExTaskCurrent()->hitstopTimer = hitstopTimer;
}

#endif // RUSH_EXTASK_H
