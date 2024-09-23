#ifndef RUSH2_EFFECT_ICE_SPARKLES_H
#define RUSH2_EFFECT_ICE_SPARKLES_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectIceSparkles_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectIceSparkles;

// --------------------
// FUNCTIONS
// --------------------

EffectIceSparkles *EffectIceSparkles__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, s32 type);

#endif // RUSH2_EFFECT_ICE_SPARKLES_H