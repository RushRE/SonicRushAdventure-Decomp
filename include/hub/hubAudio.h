#ifndef RUSH2_HUBAUDIO_H
#define RUSH2_HUBAUDIO_H

#include <game/system/task.h>

enum HubSfxIDs_
{
    HUB_SFX_PAUSE      = 0x0,
    HUB_SFX_V_DECIDE   = 0x1,
    HUB_SFX_V_CANCELL  = 0x2,
    HUB_SFX_CURSOL     = 0x3,
    HUB_SFX_V_POPUP    = 0x4,
    HUB_SFX_D_DECISION = 0x5,
    HUB_SFX_V_CHANGE   = 0x6,
    HUB_SFX_WAVE       = 0x7,
};
typedef u32 HubSfxIDs;

// --------------------
// FUNCTIONS
// --------------------

void DockHelpers__LoadVillageTrack(void);
void HubAudio__Release(BOOL releaseAudio);
void HubAudio__PlayVillageTrack(void);
void HubAudio__SetTrackVolume(u8 volume);
void HubAudio__FadeTrack(s32 fadeFrame);
void HubAudio__PlayItemJingle(void);
void HubAudio__PlayDecorationJingle(void);
void HubAudio__StopSoundHandle(void);
void HubAudio__PlaySfx(HubSfxIDs id);

#endif // RUSH2_HUBAUDIO_H
