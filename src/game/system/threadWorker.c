
#include <game/system/threadWorker.h>
#include <game/system/allocator.h>

// --------------------
// FUNCTIONS
// --------------------

void InitThreadWorker(Thread *thread, s32 stackSize)
{
    MI_CpuClear32(thread, sizeof(*thread));

    if (!stackSize)
        stackSize = THREADWORKER_DEFAULT_STACK_SIZE;
    thread->stackSize = stackSize;

    thread->stackPtr       = HeapAllocHead(HEAP_SYSTEM, stackSize);
    thread->isThreadActive = FALSE;
}

void CreateThreadWorker(Thread *thread, ThreadFunc func, void *arg, s32 prio)
{
    DestroyThreadWorker(thread);

    thread->isThreadActive = TRUE;
    OS_CreateThread(&thread->osThread, func, arg, thread->stackPtr + thread->stackSize, thread->stackSize, prio);
    OS_WakeupThreadDirect(&thread->osThread);
}

BOOL IsThreadWorkerFinished(Thread *thread)
{
    if (thread->isThreadActive == FALSE)
        return TRUE;

    if (OS_IsThreadTerminated(&thread->osThread))
    {
        thread->isThreadActive = FALSE;
        return TRUE;
    }

    return FALSE;
}

void JoinThreadWorker(Thread *thread)
{
    if (thread->isThreadActive == FALSE)
        return;

    OS_JoinThread(&thread->osThread);
    thread->isThreadActive = FALSE;
}

void DestroyThreadWorker(Thread *thread)
{
    if (IsThreadWorkerFinished(thread))
        return;

    OS_DestroyThread(&thread->osThread);
    thread->isThreadActive = FALSE;
}

void ReleaseThreadWorker(Thread *thread)
{
    DestroyThreadWorker(thread);
    
    if (thread->stackPtr != NULL)
    {
        HeapFree(HEAP_SYSTEM, thread->stackPtr);
        thread->stackPtr = NULL;
    }

    thread->stackSize = 0;
}
