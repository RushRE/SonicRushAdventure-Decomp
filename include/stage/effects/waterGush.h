#ifndef RUSH2_EFFECT_WATERGUSH_H
#define RUSH2_EFFECT_WATERGUSH_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectWaterGush_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectWaterGush;

// --------------------
// FUNCTIONS
// --------------------

EffectWaterGush *EffectWaterGush__Create(StageTask *parent, fx32 velX, fx32 velY, s32 type);

#endif // RUSH2_EFFECT_WATERGUSH_H