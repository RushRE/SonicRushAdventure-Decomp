#ifndef RUSH2_EFFECT_FLIP_MUSH_PUFF_H
#define RUSH2_EFFECT_FLIP_MUSH_PUFF_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectFlipMushPuff_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectFlipMushPuff;

// --------------------
// FUNCTIONS
// --------------------

EffectFlipMushPuff *EffectFlipMushPuff__Create(fx32 x, fx32 y, fx32 velX, fx32 velY);

#endif // RUSH2_EFFECT_FLIP_MUSH_PUFF_H