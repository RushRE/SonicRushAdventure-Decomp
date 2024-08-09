#ifndef RUSH2_EFFECT_WATERWAKE_H
#define RUSH2_EFFECT_WATERWAKE_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectWaterWake_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectWaterWake;

// --------------------
// FUNCTIONS
// --------------------

EffectWaterWake *CreateEffectWaterWake(StageTask *parent, fx32 offsetX, fx32 positionY, fx32 offsetY, u16 type);

EffectWaterWake *CreateEffectWaterWakeForPlayer(Player *player);
EffectWaterWake *CreateEffectWaterWakeForPlayer2(Player *player);

#endif // RUSH2_EFFECT_WATERWAKE_H