#ifndef RUSH2_EFFECT_AIR_EFFECT_H
#define RUSH2_EFFECT_AIR_EFFECT_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectAirEffect_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectAirEffect;

// --------------------
// FUNCTIONS
// --------------------

EffectAirEffect *EffectAirEffect__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, fx32 accX, fx32 accY);
void EffectAirEffect__Destructor(Task *task);
void EffectAirEffect__State_202CFB8(EffectAirEffect *work);
void EffectAirEffect__Draw(void);

#endif // RUSH2_EFFECT_AIR_EFFECT_H