#ifndef RUSH2_EFFECT_STEAM_BLASTER_STEAM_H
#define RUSH2_EFFECT_STEAM_BLASTER_STEAM_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectSteamBlasterSteam_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectSteamBlasterSteam;

// --------------------
// FUNCTIONS
// --------------------

EffectSteamBlasterSteam *EffectSteamBlasterSteam__Create(StageTask *parent, fx32 offsetX, fx32 offsetY, u32 timer);
void EffectSteamBlasterSteam__State_2029B74(EffectSteamBlasterSteam *work);

#endif // RUSH2_EFFECT_STEAM_BLASTER_STEAM_H