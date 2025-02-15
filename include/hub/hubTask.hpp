#ifndef RUSH_HUBTASK_HPP
#define RUSH_HUBTASK_HPP

#include <game/system/task.h>
#include <game/math/cppMath.hpp>

#ifdef __cplusplus

// --------------------
// MACROS
// --------------------

#ifdef RUSH_DEBUG
#define HubTaskCreate(taskMain, taskDestructor, flags, pauseLevel, priority, group, name) HubTaskCreate_<name>(taskMain, taskDestructor, flags, pauseLevel, priority, group, #name)
#else
#define HubTaskCreate(taskMain, taskDestructor, flags, pauseLevel, priority, group, name) HubTaskCreate_<name>(taskMain, taskDestructor, flags, pauseLevel, priority, group)
#endif

// --------------------
// FUNCTIONS
// --------------------

#ifdef RUSH_DEBUG
template <typename T> static Task *HubTaskCreate_(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u16 priority, TaskGroup group, const char *name)
#else
template <typename T> static Task *HubTaskCreate_(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u16 priority, TaskGroup group)
#endif
{
    Task *task = TaskCreate_(taskMain, taskDestructor, flags, pauseLevel, priority, group, sizeof(T));

    T *work = (T *)GetTaskWork_(task);
    PlacementNew(work, T);

    return task;
}

template <typename T> static void HubTaskDestroy(Task *task)
{
    T *work = (T *)task->workPtr;
    delete work;

    task->workPtr = NULL;
}

#endif // __cplusplus

#endif // RUSH_HUBTASK_HPP
