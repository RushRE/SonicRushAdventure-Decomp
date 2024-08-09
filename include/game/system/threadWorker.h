#ifndef RUSH2_THREAD_H
#define RUSH2_THREAD_H

#include <global.h>

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
void CreateThreadWorker(Thread *thread, ThreadFunc func, void *arg, int prio);
BOOL IsThreadWorkerFinished(Thread *thread);
void JoinThreadWorker(Thread *thread);
void DestroyThreadWorker(Thread *thread);
void ReleaseThreadWorker(Thread *thread);

#endif // RUSH2_THREAD_H
