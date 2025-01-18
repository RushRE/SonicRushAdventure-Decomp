#ifndef RUSH_EFFECT_SLING_DUST_H
#define RUSH_EFFECT_SLING_DUST_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectSlingDust_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectSlingDust;

// --------------------
// FUNCTIONS
// --------------------

EffectSlingDust *EffectSlingDust__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u8 type);

#endif // RUSH_EFFECT_SLING_DUST_H