#ifndef RUSH2_EFFECT_PISTON_H
#define RUSH2_EFFECT_PISTON_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectPiston_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectPiston;

// --------------------
// FUNCTIONS
// --------------------

EffectPiston *EffectPiston__Create(VecFx32 *position, VecU16 *dir);

#endif // RUSH2_EFFECT_PISTON_H