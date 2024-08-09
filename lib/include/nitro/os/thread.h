#ifndef NITRO_OS_THREAD_H
#define NITRO_OS_THREAD_H

#include <nitro/os/context.h>
#include <nitro/os/common/thread_shared.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// MACROS
// --------------------

#define SDK_THREAD_INFINITY

#define OS_THREADINFO_OFFSET_ISNEEDRESCHEDULING 0
#define OS_THREADINFO_OFFSET_IRQDEPTH           2
#define OS_THREADINFO_OFFSET_CURRENT            4
#define OS_THREADINFO_OFFSET_LIST               8
#define OS_THREADINFO_OFFSET_SWITCHCALLBACK     12
#define OS_THREADINFO_OFFSET_ENTRY              16

#define OS_THREAD_OFFSET_CONTEXT 0
#define OS_THREAD_OFFSET_STATE   (sizeof(OSContext))
#define OS_THREAD_OFFSET_NEXT    (sizeof(OSContext) + sizeof(OSThreadState))

// --------------------
// FUNCTIONS
// --------------------

OSMutex *OSi_RemoveMutexLinkFromQueue(OSMutexQueue *queue);
void OS_InitThread(void);
BOOL OS_IsThreadAvailable(void);
void OS_CreateThread(OSThread *thread, void (*func)(void *), void *arg, void *stack, u32 stackSize, u32 prio);
void OS_ExitThread(void);
void OS_DestroyThread(OSThread *thread);
void OS_JoinThread(OSThread *thread);
BOOL OS_IsThreadTerminated(const OSThread *thread);
void OS_SleepThread(OSThreadQueue *queue);
void OS_WakeupThread(OSThreadQueue *queue);
void OS_WakeupThreadDirect(OSThread *thread);
OSThread *OS_SelectThread(void);
void OS_RescheduleThread(void);
void OS_YieldThread(void);
BOOL OS_SetThreadPriority(OSThread *thread, u32 prio);
u32 OS_GetThreadPriority(const OSThread *thread);
void OS_Sleep(u32 msec);
OSSwitchThreadCallback OS_SetSwitchThreadCallback(OSSwitchThreadCallback callback);
u32 OS_DisableScheduler(void);
u32 OS_EnableScheduler(void);
void OS_SetThreadDestructor(OSThread *thread, OSThreadDestructor dtor);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_THREAD_H
