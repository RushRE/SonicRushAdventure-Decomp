#ifndef NITRO_OS_MUTEX_H
#define NITRO_OS_MUTEX_H

#include <nitro/os/context.h>
#include <nitro/os/common/mutex_shared.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void OS_InitMutex(OSMutex *mutex);
BOOL OS_TryLockMutex(OSMutex *mutex);
void OS_UnlockMutex(OSMutex *mutex);
void OSi_UnlockAllMutex(OSThread *thread);
void OS_LockMutex(OSMutex *mtx);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_MUTEX_H
