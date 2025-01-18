#ifndef RUSH_HUBAUDIO_H
#define RUSH_HUBAUDIO_H

#include <game/system/task.h>

enum HubSfxIDs_
{
    HUB_SFX_PAUSE,
    HUB_SFX_V_DECIDE,
    HUB_SFX_V_CANCELL,
    HUB_SFX_CURSOL,
    HUB_SFX_V_POPUP,
    HUB_SFX_D_DECISION,
    HUB_SFX_V_CHANGE,
    HUB_SFX_WAVE,

    HUB_SFX_COUNT,
};
typedef u32 HubSfxIDs;

// --------------------
// FUNCTIONS
// --------------------

void InitHubAudio(void);
void ReleaseHubAudio(BOOL releaseAudio);
void PlayHubBGM(void);
void SetHubBGMVolume(u8 volume);
void FadeOutHubBGM(s32 fadeFrame);
void PlayHubItemJingle(void);
void PlayHubDecorationJingle(void);
void ReleaseHubBGM(void);
void PlayHubSfx(HubSfxIDs id);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void StopHubBGM(void)
{
    FadeOutHubBGM(0);
}

#endif // RUSH_HUBAUDIO_H
