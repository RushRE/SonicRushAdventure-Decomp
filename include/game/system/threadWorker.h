#ifndef RUSH_THREAD_H
#define RUSH_THREAD_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define THREADWORKER_DEFAULT_STACK_SIZE 0x400

// --------------------
// TYPES
// --------------------

typedef void (*ThreadFunc)(void *arg);

// --------------------
// STRUCTS
// --------------------

typedef struct Thread_
{
    OSThread osThread;
    void *stackPtr;
    u32 stackSize;
    u32 isThreadActive;
} Thread;

// --------------------
// FUNCTIONS
// --------------------

void InitThreadWorker(Thread *thread, s32 stackSize);
void CreateThreadWorker(Thread *thread, ThreadFunc func, void *arg, s32 prio);
BOOL IsThreadWorkerFinished(Thread *thread);
void JoinThreadWorker(Thread *thread);
void DestroyThreadWorker(Thread *thread);
void ReleaseThreadWorker(Thread *thread);

#ifdef __cplusplus
}
#endif

#endif // RUSH_THREAD_H
