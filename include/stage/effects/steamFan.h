#ifndef RUSH2_EFFECT_STEAM_FAN_H
#define RUSH2_EFFECT_STEAM_FAN_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectSteamFan_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectSteamFan;

// --------------------
// FUNCTIONS
// --------------------

EffectSteamFan *EffectSteamFan__Create(StageTask *parent, s32 userTimer, u16 angle, s32 userWork);
void EffectSteamFan__State_202B324(EffectSteamFan *work);

#endif // RUSH2_EFFECT_STEAM_FAN_H