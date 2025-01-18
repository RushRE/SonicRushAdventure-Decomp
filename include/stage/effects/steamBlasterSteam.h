#ifndef RUSH_EFFECT_STEAM_BLASTER_STEAM_H
#define RUSH_EFFECT_STEAM_BLASTER_STEAM_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectSteamBlasterSteam_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectSteamBlasterSteam;

// --------------------
// FUNCTIONS
// --------------------

EffectSteamBlasterSteam *CreateEffectSteamBlasterSteam(StageTask *parent, fx32 offsetX, fx32 offsetY, u32 timer);
void EffectSteamBlasterSteam_State_Active(EffectSteamBlasterSteam *work);

#endif // RUSH_EFFECT_STEAM_BLASTER_STEAM_H