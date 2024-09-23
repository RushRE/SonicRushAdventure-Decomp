#ifndef RUSH2_EFFECT_ICE_BLOCK_DEBRIS_H
#define RUSH2_EFFECT_ICE_BLOCK_DEBRIS_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectIceBlockDebris_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectIceBlockDebris;

// --------------------
// FUNCTIONS
// --------------------

EffectIceBlockDebris *EffectIceBlockDebris__Create(u8 type, fx32 x, fx32 y, fx32 velX, fx32 velY);

#endif // RUSH2_EFFECT_ICE_BLOCK_DEBRIS_H