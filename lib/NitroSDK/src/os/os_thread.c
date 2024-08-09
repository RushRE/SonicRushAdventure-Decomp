#include <nitro.h>

// --------------------
// CONSTANTS/MACROS
// --------------------

extern void SDK_SYS_STACKSIZE(void);
extern void SDK_IRQ_STACKSIZE(void);
#define OSi_SYS_STACKSIZE ((s32)SDK_SYS_STACKSIZE)
#define OSi_IRQ_STACKSIZE ((s32)SDK_IRQ_STACKSIZE)

#ifdef SDK_ARM9
#define OSi_STACK_CHECKNUM_BOTTOM 0xfddb597dUL
#define OSi_STACK_CHECKNUM_TOP    0x7bf9dd5bUL
#define OSi_STACK_CHECKNUM_WARN   0x597dfbd9UL
#else
#define OSi_STACK_CHECKNUM_BOTTOM 0xd73bfdf7UL
#define OSi_STACK_CHECKNUM_TOP    0xfbdd37bbUL
#define OSi_STACK_CHECKNUM_WARN   0xbdf7db3dUL
#endif

#ifdef SDK_ARM9
extern void SDK_SECTION_ARENA_DTCM_START(void);
void SDK_AUTOLOAD_DTCM_END(void);
#define OSi_LAUNCHER_STACK_LO_DEFAULT SDK_SECTION_ARENA_DTCM_START
#define OSi_LAUNCHER_STACK_HI_MAX     (HW_DTCM_SVC_STACK - OSi_IRQ_STACKSIZE)
#define OSi_LAUNCHER_STACK_BOTTOM     (HW_DTCM_SVC_STACK - OSi_IRQ_STACKSIZE)
#else
#define OSi_LAUNCHER_STACK_LO_DEFAULT HW_WRAM
#define OSi_LAUNCHER_STACK_HI_MAX     (HW_PRV_WRAM_IRQ_STACK_END - OSi_IRQ_STACKSIZE)
#define OSi_LAUNCHER_STACK_BOTTOM     (HW_PRV_WRAM_IRQ_STACK_END - OSi_IRQ_STACKSIZE)
#endif

#ifdef SDK_CONTEXT_HAS_SP_SVC
#define OSi_IDLE_CHECKNUM_SIZE (sizeof(u32) * 2 + HW_SVC_STACK_SIZE)
#else
#define OSi_IDLE_CHECKNUM_SIZE (sizeof(u32) * 2)
#endif

#ifdef SDK_ARM9
#define OSi_IDLE_SVC_SIZE (sizeof(u32) * 32)
#else
#define OSi_IDLE_SVC_SIZE (sizeof(u32) * 16)
#endif

#define OSi_IDLE_THREAD_STACK_SIZE (OSi_IDLE_CHECKNUM_SIZE + OSi_IDLE_SVC_SIZE)

// --------------------
// VARIABLES
// --------------------

u32 OSi_IdleThreadStack[OSi_IDLE_THREAD_STACK_SIZE / sizeof(u32)];
OSThread OSi_LauncherThread;
OSThread OSi_IdleThread;
OSThreadInfo OSi_ThreadInfo;
void *OSi_SystemCallbackInSwitchThread;
OSThread **OSi_CurrentThreadPtr;
BOOL OSi_IsThreadInitialized;
void *OSi_StackForDestructor;
u32 OSi_RescheduleCount;
static int OSi_ThreadIdCount;

#define OSi_GetCurrentThread() (*OSi_CurrentThreadPtr)

// --------------------
// FUNCTION DECLS
// --------------------

static void OSi_CancelThreadAlarmForSleep(OSThread *thread);
static void OSi_InsertThreadToList(OSThread *thread);
static void OSi_RemoveThreadFromList(OSThread *thread);
static void OSi_SleepAlarmCallback(void *arg);
static void OSi_IdleThreadProc(void *);
static void OSi_SetSystemCallbackInSwitchThread(void *callback);

static void OSi_ExitThread_ArgSpecified(OSThread *thread, void *arg);
static void OSi_ExitThread(void *arg);
static void OSi_ExitThread_Destroy(void);

static void OSi_RescheduleThread(void);

// --------------------
// FUNCTIONS
// --------------------

static int OSi_GetUnusedThreadId(void)
{
    ++OSi_ThreadIdCount;
    return OSi_ThreadIdCount;
}

static void OSi_InsertLinkToQueue(OSThreadQueue *queue, OSThread *thread)
{
    OSThread *next = queue->head;

    while (next && next->priority <= thread->priority)
    {
        if (next == thread)
        {
            return;
        }
        next = next->link.next;
    }

    if (!next)
    {
        OSThread *prev = queue->tail;

        if (!prev)
        {
            queue->head = thread;
        }
        else
        {
            prev->link.next = thread;
        }

        thread->link.prev = prev;
        thread->link.next = NULL;
        queue->tail       = thread;
    }
    else
    {
        OSThread *prev = next->link.prev;

        if (!prev)
        {
            queue->head = thread;
        }
        else
        {
            prev->link.next = thread;
        }

        thread->link.prev = prev;
        thread->link.next = next;
        next->link.prev   = thread;
    }
}

static OSThread *OSi_RemoveLinkFromQueue(OSThreadQueue *queue)
{
    OSThread *t = queue->head;

    if (t)
    {
        OSThread *next = t->link.next;

        queue->head = next;

        if (next)
        {
            next->link.prev = NULL;
        }
        else
        {
            queue->tail = NULL;
            t->queue    = NULL;
        }
    }

    return t;
}

static OSThread *OSi_RemoveSpecifiedLinkFromQueue(OSThreadQueue *queue, OSThread *thread)
{
    OSThread *t = queue->head;
    OSThread *next;
    OSThread *prev;

    while (t)
    {
        next = t->link.next;

        if (t == thread)
        {
            prev = t->link.prev;

            if (queue->head == t)
            {
                queue->head = next;
            }
            else
            {
                prev->link.next = next;
            }

            if (queue->tail == t)
            {
                queue->tail = prev;
            }
            else
            {
                next->link.prev = prev;
            }

            break;
        }

        t = next;
    }

    return t;
}

OSMutex *OSi_RemoveMutexLinkFromQueue(OSMutexQueue *queue)
{
    OSMutex *t = queue->head;

    if (t != NULL)
    {
        OSMutex *next = t->link.next;

        queue->head = next;

        if (next)
        {
            next->link.prev = NULL;
        }
        else
        {
            queue->tail = NULL;
        }
    }

    return t;
}

static void OSi_InsertThreadToList(OSThread *thread)
{
    OSThread *t   = OSi_ThreadInfo.list;
    OSThread *pre = NULL;

    while (t != NULL && t->priority < thread->priority)
    {
        pre = t;
        t   = t->next;
    }

    if (!pre)
    {
        thread->next        = OSi_ThreadInfo.list;
        OSi_ThreadInfo.list = thread;
    }
    else
    {
        thread->next = pre->next;
        pre->next    = thread;
    }
}

static void OSi_RemoveThreadFromList(OSThread *thread)
{
    OSThread *t   = OSi_ThreadInfo.list;
    OSThread *pre = NULL;

    while (t != NULL && t != thread)
    {
        pre = t;
        t   = t->next;
    }

    if (!pre)
    {
        OSi_ThreadInfo.list = thread->next;
    }
    else
    {
        pre->next = thread->next;
    }
}

static void OSi_RescheduleThread(void)
{
    if (OSi_RescheduleCount <= 0)
    {
        OSThreadInfo *info = &OSi_ThreadInfo;
        if (info->irqDepth > 0 || OS_GetProcMode() == OS_PROCMODE_IRQ)
        {
            info->isNeedRescheduling = TRUE;
        }
        else
        {
            OSThread *currentThread, *nextThread;
            currentThread = OSi_GetCurrentThread();
            nextThread    = OS_SelectThread();

            if (currentThread == nextThread || nextThread == NULL)
            {
                return;
            }

            if (currentThread->state != OS_THREAD_STATE_TERMINATED && OS_SaveContext(&currentThread->context))
            {
                return;
            }

            if (OSi_SystemCallbackInSwitchThread)
            {
                ((OSSwitchThreadCallback)OSi_SystemCallbackInSwitchThread)(currentThread, nextThread);
            }

            if (info->switchCallback)
            {
                ((OSSwitchThreadCallback)info->switchCallback)(currentThread, nextThread);
            }

            OS_SetCurrentThread(nextThread);

            OS_LoadContext(&nextThread->context);
        }
    }
}

void OS_InitThread(void)
{
    void *stackLo;

    if (OSi_IsThreadInitialized)
        return;

    OSi_IsThreadInitialized = TRUE;

    OSi_CurrentThreadPtr = &(OSi_ThreadInfo.current);

    OSi_LauncherThread.priority = OS_THREAD_LAUNCHER_PRIORITY;
    OSi_LauncherThread.id       = 0;
    OSi_LauncherThread.state    = OS_THREAD_STATE_READY;
    OSi_LauncherThread.next     = NULL;

    OSi_LauncherThread.profiler = NULL;
    OSi_ThreadInfo.list         = &OSi_LauncherThread;

    OS_SetCurrentThread(&OSi_LauncherThread);

    stackLo = (OSi_SYS_STACKSIZE <= 0) ? (void *)((u32)OSi_LAUNCHER_STACK_LO_DEFAULT - OSi_SYS_STACKSIZE) : (void *)((u32)OSi_LAUNCHER_STACK_HI_MAX - OSi_SYS_STACKSIZE);

    OSi_LauncherThread.stackBottom        = (u32)OSi_LAUNCHER_STACK_BOTTOM;
    OSi_LauncherThread.stackTop           = (u32)stackLo;
    OSi_LauncherThread.stackWarningOffset = 0;

    *(u32 *)(OSi_LauncherThread.stackBottom - sizeof(u32)) = OSi_STACK_CHECKNUM_BOTTOM;
    *(u32 *)OSi_LauncherThread.stackTop                    = OSi_STACK_CHECKNUM_TOP;

    OS_InitThreadQueue(&OSi_LauncherThread.joinQueue);

    OSi_ThreadInfo.isNeedRescheduling = FALSE;
    OSi_ThreadInfo.irqDepth           = 0;

#ifdef SDK_ARM9
    OS_GetSystemWork()->threadinfo_mainp = &OSi_ThreadInfo;
#else
    OS_GetSystemWork()->threadinfo_subp = &OSi_ThreadInfo;
#endif

    (IGNORE_RETURN) OS_SetSwitchThreadCallback(NULL);

#ifdef SDK_ARM9
    OS_CreateThread(&OSi_IdleThread, OSi_IdleThreadProc, (void *)NULL, OSi_IdleThreadStack + OSi_IDLE_THREAD_STACK_SIZE / sizeof(u32), OSi_IDLE_THREAD_STACK_SIZE, OS_THREAD_PRIORITY_MAX);
    OSi_IdleThread.priority = OS_THREAD_PRIORITY_MAX + 1;
    OSi_IdleThread.state    = OS_THREAD_STATE_READY;
#endif
}

#include <nitro/code32.h>
asm BOOL OS_IsThreadAvailable(void)
{
    // clang-format off
    ldr r0, =OSi_IsThreadInitialized
    ldr r0, [r0] 
    bx lr
    // clang-format on
}
#include <nitro/codereset.h>

void OS_CreateThread(OSThread *thread, void (*func)(void *), void *arg, void *stack, u32 stackSize, u32 prio)
{
#define STACK_ALIGN 4

    OSIntrMode enable;
    int index;

    enable = OS_DisableInterrupts();

    index = OSi_GetUnusedThreadId();

    thread->priority = prio;
    thread->id       = (u32)index;
    thread->state    = OS_THREAD_STATE_WAITING;

    thread->profiler = NULL;

    OSi_InsertThreadToList(thread);

    thread->stackBottom        = (u32)stack;
    thread->stackTop           = (u32)stack - stackSize;
    thread->stackWarningOffset = 0;

    *(u32 *)(thread->stackBottom - sizeof(u32)) = OSi_STACK_CHECKNUM_BOTTOM;
    *(u32 *)thread->stackTop                    = OSi_STACK_CHECKNUM_TOP;

    OS_InitThreadQueue(&thread->joinQueue);

    OS_InitContext(&thread->context, (u32)func, (u32)stack - sizeof(u32));

    thread->context.r[0] = (u32)arg;
    thread->context.lr   = (u32)OS_ExitThread;

    MI_CpuClear32((void *)((u32)stack - stackSize + sizeof(u32)), stackSize - sizeof(u32) * 2);

    thread->mutex           = NULL;
    thread->mutexQueue.head = NULL;
    thread->mutexQueue.tail = NULL;

    OS_SetThreadDestructor(thread, NULL);

    thread->queue     = NULL;
    thread->link.prev = thread->link.next = NULL;

    MI_CpuClear32(&thread->specific[0], sizeof(void *) * OS_THREAD_SPECIFIC_MAX);

    thread->alarmForSleep = NULL;

    (IGNORE_RETURN) OS_RestoreInterrupts(enable);
}

void OS_ExitThread(void)
{
    (IGNORE_RETURN) OS_DisableInterrupts();

    OSi_ExitThread_ArgSpecified(OS_GetCurrentThread(), 0);
}

static void OSi_ExitThread_ArgSpecified(OSThread *thread, void *arg)
{
    if (OSi_StackForDestructor)
    {
        OS_InitContext(&thread->context, (u32)OSi_ExitThread, (u32)OSi_StackForDestructor);
        thread->context.r[0] = (u32)arg;
        thread->context.cpsr |= HW_PSR_IRQ_DISABLE;
        thread->state = OS_THREAD_STATE_READY;
        OS_LoadContext(&thread->context);
    }
    else
    {
        OSi_ExitThread(arg);
    }
}

static void OSi_ExitThread(void *arg)
{
    OSThread *currentThread = OSi_GetCurrentThread();
    OSThreadDestructor destructor;

    destructor = currentThread->destructor;
    if (destructor)
    {
        currentThread->destructor = NULL;
        destructor(arg);
        (IGNORE_RETURN) OS_DisableInterrupts();
    }

    OSi_ExitThread_Destroy();
}

static void OSi_ExitThread_Destroy(void)
{
    OSThread *currentThread = OSi_GetCurrentThread();

    (IGNORE_RETURN) OS_DisableScheduler();

    OSi_UnlockAllMutex(currentThread);

    if (currentThread->queue)
    {
        (IGNORE_RETURN) OSi_RemoveSpecifiedLinkFromQueue(currentThread->queue, currentThread);
    }

    OSi_RemoveThreadFromList(currentThread);

    currentThread->state = OS_THREAD_STATE_TERMINATED;

    OS_WakeupThread(&currentThread->joinQueue);

    (IGNORE_RETURN) OS_EnableScheduler();

    OS_RescheduleThread();

    OS_Terminate();
}

void OS_DestroyThread(OSThread *thread)
{
    OSIntrMode enabled = OS_DisableInterrupts();

    if (OS_GetCurrentThread() == thread)
    {
        OSi_ExitThread_Destroy();
    }

    (IGNORE_RETURN) OS_DisableScheduler();

    OSi_UnlockAllMutex(thread);
    OSi_CancelThreadAlarmForSleep(thread);

    if (thread->queue)
    {
        (IGNORE_RETURN) OSi_RemoveSpecifiedLinkFromQueue(thread->queue, thread);
    }

    OSi_RemoveThreadFromList(thread);

    thread->state = OS_THREAD_STATE_TERMINATED;

    OS_WakeupThread(&thread->joinQueue);

    (IGNORE_RETURN) OS_EnableScheduler();
    (IGNORE_RETURN) OS_RestoreInterrupts(enabled);

    OS_RescheduleThread();
}

static void OSi_CancelThreadAlarmForSleep(OSThread *thread)
{
    OSAlarm *alarm = thread->alarmForSleep;

    if (alarm)
    {
        OS_CancelAlarm(alarm);
    }
}

void OS_JoinThread(OSThread *thread)
{
    OSIntrMode enabled = OS_DisableInterrupts();

    if (thread->state != OS_THREAD_STATE_TERMINATED)
    {
        OS_SleepThread(&thread->joinQueue);
    }

    (IGNORE_RETURN) OS_RestoreInterrupts(enabled);
}

BOOL OS_IsThreadTerminated(const OSThread *thread)
{
    return (thread->state == OS_THREAD_STATE_TERMINATED) ? TRUE : FALSE;
}

void OS_SleepThread(OSThreadQueue *queue)
{
    OSIntrMode enable;
    OSThread *currentThread;

    enable = OS_DisableInterrupts();

    {
        currentThread = OSi_GetCurrentThread();

        if (queue)
        {
            currentThread->queue = queue;
            OSi_InsertLinkToQueue(queue, currentThread);
        }

        currentThread->state = OS_THREAD_STATE_WAITING;
        OSi_RescheduleThread();
    }

    (IGNORE_RETURN) OS_RestoreInterrupts(enable);
}

void OS_WakeupThread(OSThreadQueue *queue)
{
    OSIntrMode enable;
    BOOL isNeedRescheduling = FALSE;

    enable = OS_DisableInterrupts();

    if (queue->head)
    {
        while (queue->head)
        {
            OSThread *thread = OSi_RemoveLinkFromQueue(queue);

            thread->state     = OS_THREAD_STATE_READY;
            thread->queue     = NULL;
            thread->link.prev = thread->link.next = NULL;
        }

        OS_InitThreadQueue(queue);
        OSi_RescheduleThread();
    }

    (IGNORE_RETURN) OS_RestoreInterrupts(enable);
}

void OS_WakeupThreadDirect(OSThread *thread)
{
    OSIntrMode enable;

    enable = OS_DisableInterrupts();
    {
        thread->state = OS_THREAD_STATE_READY;
        OSi_RescheduleThread();
    }
    (IGNORE_RETURN) OS_RestoreInterrupts(enable);
}

OSThread *OS_SelectThread(void)
{
    OSThread *t = OSi_ThreadInfo.list;

    while (t != NULL && !OS_IsThreadRunnable(t))
    {
        t = t->next;
    }

    return t;
}

void OS_RescheduleThread(void)
{
    OSIntrMode bak_intr = OS_DisableInterrupts();
    OSi_RescheduleThread();
    (IGNORE_RETURN) OS_RestoreInterrupts(bak_intr);
}

void OS_YieldThread(void)
{
    OSThread *current      = OS_GetCurrentThread();
    OSThread *pre          = NULL;
    OSThread *lastThread   = NULL;
    int samePriorityThread = 0;
    OSIntrMode enable      = OS_DisableInterrupts();

    {
        OSThread *t    = OSi_ThreadInfo.list;
        OSThread *tPre = NULL;

        while (t != NULL)
        {
            if (t == current)
            {
                pre = tPre;
            }

            if (current->priority == t->priority)
            {
                lastThread = t;
                samePriorityThread++;
            }

            tPre = t;
            t    = t->next;
        }
    }

    if (samePriorityThread <= 1 || lastThread == current)
    {
        (IGNORE_RETURN) OS_RestoreInterrupts(enable);
        return;
    }

    if (!pre)
    {
        OSi_ThreadInfo.list = current->next;
    }
    else
    {
        pre->next = current->next;
    }

    current->next    = lastThread->next;
    lastThread->next = current;

    OSi_RescheduleThread();

    (IGNORE_RETURN) OS_RestoreInterrupts(enable);
}

BOOL OS_SetThreadPriority(OSThread *thread, u32 prio)
{
    OSThread *t   = OSi_ThreadInfo.list;
    OSThread *pre = NULL;
    OSIntrMode enable;

    enable = OS_DisableInterrupts();

    while (t && t != thread)
    {
        pre = t;
        t   = t->next;
    }

    if (t == NULL || t == &OSi_IdleThread)
    {
        (IGNORE_RETURN) OS_RestoreInterrupts(enable);
        return FALSE;
    }

    if (t->priority != prio)
    {
        if (!pre)
        {
            OSi_ThreadInfo.list = thread->next;
        }
        else
        {
            pre->next = thread->next;
        }

        thread->priority = prio;
        OSi_InsertThreadToList(thread);

        OSi_RescheduleThread();
    }

    (IGNORE_RETURN) OS_RestoreInterrupts(enable);

    return TRUE;
}

u32 OS_GetThreadPriority(const OSThread *thread)
{
    return thread->priority;
}

void OS_Sleep(u32 msec)
{
    OSAlarm alarm;

    OS_CreateAlarm(&alarm);
    {
        OSThread *volatile p_thread = OSi_GetCurrentThread();
        OSIntrMode bak_cpsr         = OS_DisableInterrupts();

        p_thread->alarmForSleep = &alarm;

        OS_SetAlarm(&alarm, OS_MilliSecondsToTicks(msec), &OSi_SleepAlarmCallback, (void *)&p_thread);
        while (p_thread != NULL)
        {
            OS_SleepThread(NULL);
        }

        (IGNORE_RETURN) OS_RestoreInterrupts(bak_cpsr);
    }
}

static void OSi_SleepAlarmCallback(void *arg)
{
    OSThread **pp_thread = (OSThread **)arg;
    OSThread *p_thread   = *pp_thread;
    *pp_thread           = NULL;

    p_thread->alarmForSleep = NULL;

    OS_WakeupThreadDirect(p_thread);
}

OSSwitchThreadCallback OS_SetSwitchThreadCallback(OSSwitchThreadCallback callback)
{
    OSSwitchThreadCallback prev;
    OSIntrMode enabled;

    enabled                       = OS_DisableInterrupts();
    prev                          = OSi_ThreadInfo.switchCallback;
    OSi_ThreadInfo.switchCallback = callback;

    (IGNORE_RETURN) OS_RestoreInterrupts(enabled);
    return prev;
}

static void OSi_IdleThreadProc(void *)
{
    (IGNORE_RETURN) OS_EnableInterrupts();

    while (1)
    {
        OS_Halt();
    }
}

u32 OS_DisableScheduler(void)
{
    OSIntrMode enabled = OS_DisableInterrupts();
    u32 count;

    if (OSi_RescheduleCount < (u32)(0 - 1)) // (0 - 1) == u32 max value -1
    {
        count = OSi_RescheduleCount++;
    }

    (IGNORE_RETURN) OS_RestoreInterrupts(enabled);

    return count;
}

u32 OS_EnableScheduler(void)
{
    OSIntrMode enabled = OS_DisableInterrupts();
    u32 count          = 0;

    if (OSi_RescheduleCount > 0)
    {
        count = OSi_RescheduleCount--;
    }

    (IGNORE_RETURN) OS_RestoreInterrupts(enabled);

    return count;
}

void OS_SetThreadDestructor(OSThread *thread, OSThreadDestructor dtor)
{
    thread->destructor = dtor;
}