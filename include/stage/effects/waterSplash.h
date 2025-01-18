#ifndef RUSH_EFFECT_WATERSPLASH_H
#define RUSH_EFFECT_WATERSPLASH_H

#include <stage/effectTask.h>
#include <stage/effects/waterCommon.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectWaterSplash_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectWaterSplash;

// --------------------
// FUNCTIONS
// --------------------

EffectWaterSplash *CreateEffectWaterSplash(StageTask *parent, fx32 offsetX, fx32 positionY, fx32 offsetY);

EffectWaterSplash *CreateEffectWaterSplashForPlayer(Player *player);

#endif // RUSH_EFFECT_WATERSPLASH_H