#include <nitro.h>

// --------------------
// FUNCTION DECLS
// --------------------

void OSi_EnqueueTail(OSThread *thread, OSMutex *mutex);
void OSi_DequeueItem(OSThread *thread, OSMutex *mutex);
OSMutex *OSi_DequeueHead(OSThread *thread);

// --------------------
// FUNCTIONS
// --------------------

void OS_InitMutex(OSMutex *mutex)
{
    OS_InitThreadQueue(&mutex->queue);
    mutex->thread = NULL;
    mutex->count  = 0;
}

void OS_LockMutex(OSMutex *mutex)
{
    OSIntrMode saved;
    OSThread *currentThread;
    OSThread *ownerThread;

    saved         = OS_DisableInterrupts();
    currentThread = OS_GetCurrentThread();

    for (;;)
    {
        ownerThread = ((volatile OSMutex *)mutex)->thread;

        if (ownerThread == NULL) // can lock mutex
        {
            mutex->thread = currentThread;
            mutex->count++;
            OSi_EnqueueTail(currentThread, mutex);
            break;
        }
        else if (ownerThread == currentThread) // if current thread is same with thread locking mutex
        {
            mutex->count++;
            break;
        }
        else // if current thread is different from locking mutex
        {
            currentThread->mutex = mutex;
            OS_SleepThread(&mutex->queue);
            currentThread->mutex = NULL;
        }
    }

    (IGNORE_RETURN) OS_RestoreInterrupts(saved);
}

void OS_UnlockMutex(OSMutex *mutex)
{
    OSIntrMode saved;
    OSThread *currentThread;

    saved         = OS_DisableInterrupts();
    currentThread = OS_GetCurrentThread();

    if (mutex->thread == currentThread && --mutex->count == 0)
    {
        OSi_DequeueItem(currentThread, mutex);
        mutex->thread = NULL;

        // wakeup threads entered in mutex thread queue
        OS_WakeupThread(&mutex->queue);
    }

    (IGNORE_RETURN) OS_RestoreInterrupts(saved);
}

void OSi_UnlockAllMutex(OSThread *thread)
{
    OSMutex *mutex;

    while (thread->mutexQueue.head)
    {
        mutex = OSi_RemoveMutexLinkFromQueue(&thread->mutexQueue);

        mutex->count = 0;
        mutex->thread = NULL;
        OS_WakeupThread(&mutex->queue);
    }
}

BOOL OS_TryLockMutex(OSMutex *mutex)
{
    OSIntrMode saved;
    OSThread *currentThread;
    BOOL locked;

    saved         = OS_DisableInterrupts();
    currentThread = OS_GetCurrentThread();

    if (mutex->thread == NULL) // can lock mutex
    {
        mutex->thread = currentThread;
        mutex->count++;
        OSi_EnqueueTail(currentThread, mutex);
        locked = TRUE;
    }
    else if (mutex->thread == currentThread) // if current thread is same with thread locking mutex
    {
        mutex->count++;
        locked = TRUE;
    }
    else // if current thread is different from locking mutex
    {
        locked = FALSE;
    }

    (IGNORE_RETURN) OS_RestoreInterrupts(saved);
    return locked;
}

void OSi_EnqueueTail(OSThread *thread, OSMutex *mutex)
{
    OSMutex *prev = thread->mutexQueue.tail;

    if (!prev)
    {
        thread->mutexQueue.head = mutex;
    }
    else
    {
        prev->link.next = mutex;
    }

    mutex->link.prev = prev;
    mutex->link.next = NULL;
    thread->mutexQueue.tail = mutex;
}

void OSi_DequeueItem(OSThread *thread, OSMutex *mutex)
{
    OSMutex *next = mutex->link.next;
    OSMutex *prev = mutex->link.prev;

    if (!next)
    {
        thread->mutexQueue.tail = prev;
    }
    else
    {
        next->link.prev = prev;
    }

    if (!prev)
    {
        thread->mutexQueue.head = next;
    }
    else
    {
        prev->link.next = next;
    }
}

OSMutex *OSi_DequeueHead(OSThread *thread)
{
    OSMutex *mutex = thread->mutexQueue.head;
    OSMutex *next = mutex->link.next;

    if (!next)
    {
        thread->mutexQueue.tail = NULL;
    }
    else
    {
        next->link.prev = NULL;
    }

    thread->mutexQueue.head = next;

    return mutex;
}
