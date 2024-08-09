#ifndef NITRO_SND_COMMON_MAIN_H
#define NITRO_SND_COMMON_MAIN_H

#include <nitro/types.h>
#include <nitro/os.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define SND_PROC_INTERVAL 0xAA8 // ~5.2095 msecs

#define SND_MESSAGE_PERIODIC      1
#define SND_MESSAGE_WAKEUP_THREAD 2

// --------------------
// FUNCTIONS
// --------------------

#ifdef SDK_ARM9

void SND_Init(void);

#else // SDK_ARM7

void SND_Init(u32 threadPrio);

void SND_CreateThread(u32 threadPrio);
BOOL SND_SetThreadPriority(u32 prio);

void SND_InitIntervalTimer(void);
void SND_StartIntervalTimer(void);
void SND_StopIntervalTimer(void);
OSMessage SND_WaitForIntervalTimer(void);
BOOL SND_SendWakeupMessage(void);

#endif // SDK_ARM9

void SNDi_LockMutex(void);
void SNDi_UnlockMutex(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_SND_COMMON_MAIN_H
