#ifndef RUSH_EXTASK_H
#define RUSH_EXTASK_H

#include <game/system/task.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// MACROS
// --------------------

#define ExTaskCreate(taskMain, taskDestructor, priority, group, pauseLevel, taskType, workType)                                                                                  \
    ExTaskCreate_(taskMain, taskDestructor, priority, group, pauseLevel, sizeof(workType), #workType, taskType)
#define ExTaskGetWork(task, type)  ((type *)GetExTaskWork_(task))
#define ExTaskGetWorkCurrent(type) ((type *)GetExTaskWorkCurrent_())
#define ExTaskInitWork8(work)      MI_CpuClear8(work, sizeof(*work))
#define ExTaskInitWork16(work)     MI_CpuClear16(work, sizeof(*work))

// --------------------
// TYPEDEFS
// --------------------

typedef struct ExTask_ ExTask;

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

struct ExTask_
{
    ExTaskMain main;
    s32 field_4;
    ExTaskUnknownFunc func8;
    ExTaskDestructor dtor;
    ExTaskDelayCallback delayCallback;
    s32 field_14;
    u16 priority;
    TaskGroup group;
    s16 timer;

#ifdef RUSH_DEBUG
    const char *name;
#endif
};

// --------------------
// VARIABLES
// --------------------

extern struct ExTaskStaticVars ExTask__sVars;

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

RUSH_INLINE void SetExTaskUnknownEvent(Task *task, ExTaskUnknownFunc event)
{
    GetExTask(task)->func8 = event;
}

RUSH_INLINE void RunExTaskUnknownEvent(ExTask *task)
{
    task->func8();
}

RUSH_INLINE void RunCurrentExTaskUnknownEvent(void)
{
    GetExTaskCurrent()->func8();
}

#endif // RUSH_EXTASK_H
