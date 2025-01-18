#ifndef RUSH_EFFECT_BREAKABLEOBJ_DEBRIS_H
#define RUSH_EFFECT_BREAKABLEOBJ_DEBRIS_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectBreakableObjDebris_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectBreakableObjDebris;

// --------------------
// FUNCTIONS
// --------------------

EffectBreakableObjDebris *EffectBreakableObjDebris__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u8 type);

#endif // RUSH_EFFECT_BREAKABLEOBJ_DEBRIS_H