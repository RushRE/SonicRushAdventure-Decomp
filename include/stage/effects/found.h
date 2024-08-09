#ifndef RUSH2_EFFECT_FOUND_H
#define RUSH2_EFFECT_FOUND_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectFound_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectFound;

// --------------------
// FUNCTIONS
// --------------------

EffectFound *CreateEffectFound(StageTask *parent, fx32 velX, fx32 velY);

#endif // RUSH2_EFFECT_FOUND_H