#ifndef NNS_SND_MAIN_H
#define NNS_SND_MAIN_H

#include <nitro/snd.h>
#include <nnsys/snd/config.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void NNS_SndInit(void);
void NNS_SndMain(void);

void NNS_SndStopSoundAll(void);
void NNS_SndStopChannelAll(void);
void NNS_SndSetMasterVolume(int volume);
void NNS_SndSetMonoFlag(BOOL flag);

BOOL NNS_SndUpdateDriverInfo(void);
BOOL NNS_SndReadDriverChannelInfo(int chNo, SNDChannelInfo *info);

BOOL NNSi_SndReadDriverPlayerInfo(int playerNo, SNDPlayerInfo *info);
BOOL NNSi_SndReadDriverTrackInfo(int playerNo, int trackNo, SNDTrackInfo *info);

// --------------------
// INLINE FUNCTIONS
// --------------------

NNS_SND_INLINE void NNS_SndBeginSleep(void) {}
NNS_SND_INLINE void NNS_SndEndSleep(void) {}

#ifdef __cplusplus
}
#endif

#endif // NNS_SND_MAIN_H