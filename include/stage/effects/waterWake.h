#ifndef RUSH_EFFECT_WATERWAKE_H
#define RUSH_EFFECT_WATERWAKE_H

#include <stage/effectTask.h>
#include <stage/effects/waterCommon.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectWaterWake_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectWaterWake;

// --------------------
// FUNCTIONS
// --------------------

EffectWaterWake *CreateEffectWaterWake(StageTask *parent, fx32 offsetX, fx32 positionY, fx32 offsetY, u16 type);

EffectWaterWake *CreateEffectWaterWakeForPlayer(Player *player);
EffectWaterWake *CreateEffectWaterWakeForPlayer2(Player *player);

#endif // RUSH_EFFECT_WATERWAKE_H