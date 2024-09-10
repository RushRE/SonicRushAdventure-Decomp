#ifndef RUSH2_EFFECT_START_DASH_H
#define RUSH2_EFFECT_START_DASH_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectStartDash_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectStartDash;

// --------------------
// FUNCTIONS
// --------------------

EffectStartDash *EffectStartDash__Create(StageTask *parent);

#endif // RUSH2_EFFECT_START_DASH_H