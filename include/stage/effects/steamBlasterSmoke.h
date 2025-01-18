#ifndef RUSH_EFFECT_STEAM_BLASTER_SMOKE_H
#define RUSH_EFFECT_STEAM_BLASTER_SMOKE_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectSteamBlasterSmoke_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectSteamBlasterSmoke;

// --------------------
// FUNCTIONS
// --------------------

EffectSteamBlasterSmoke *CreateEffectSteamBlasterSmoke(StageTask *parent);
void EffectSteamBlasterSmoke_State_Active(EffectSteamBlasterSmoke *work);

#endif // RUSH_EFFECT_STEAM_BLASTER_SMOKE_H