#ifndef RUSH2_EFFECT_CORAL_DEBRIS_H
#define RUSH2_EFFECT_CORAL_DEBRIS_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectCoralDebris_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectCoralDebris;

// --------------------
// FUNCTIONS
// --------------------

EffectCoralDebris *EffectCoralDebris__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u32 type);

#endif // RUSH2_EFFECT_CORAL_DEBRIS_H