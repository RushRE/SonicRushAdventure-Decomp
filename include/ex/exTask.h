#ifndef RUSH2_EXTASK_H
#define RUSH2_EXTASK_H

#include <game/system/task.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// MACROS
// --------------------

#define ExTaskCreate(taskMain, taskDestructor, priority, group, pauseLevel, workSize, name, type)                                                                                  \
    ExTaskCreate_(taskMain, taskDestructor, priority, group, pauseLevel, workSize, name, type)
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
    void (*func8)(void);
    ExTaskDestructor dtor;
    void (*delayCallback)(void);
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

#endif // RUSH2_EXTASK_H
