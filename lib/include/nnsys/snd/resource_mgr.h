#ifndef NNS_SND_RESOURCE_MGR_H
#define NNS_SND_RESOURCE_MGR_H

#include <nitro/types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

BOOL NNS_SndLockChannel(u32 chBitFlag);
void NNS_SndUnlockChannel(u32 chBitFlag);

BOOL NNS_SndLockCapture(u32 capBitFlag);
void NNS_SndUnlockCapture(u32 capBitFlag);

int NNS_SndAllocAlarm(void);
void NNS_SndFreeAlarm(int alarmNo);

void NNSi_SndInitResourceMgr(void);
u32 NNSi_GetLockedChannel(void);

#ifdef __cplusplus
}
#endif

#endif // NNS_SND_RESOURCE_MGR_H