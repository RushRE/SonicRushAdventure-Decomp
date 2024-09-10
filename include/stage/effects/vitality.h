#ifndef RUSH2_EFFECT_VITALITY_H
#define RUSH2_EFFECT_VITALITY_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectVitality_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectVitality;

// --------------------
// FUNCTIONS
// --------------------

EffectVitality *CreateEffectVitality(StageTask *parent, fx32 velX, fx32 velY, u8 health);

#endif // RUSH2_EFFECT_VITALITY_H