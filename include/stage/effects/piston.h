#ifndef RUSH_EFFECT_PISTON_H
#define RUSH_EFFECT_PISTON_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectPiston_
{
    EffectTask3D effWork;
} EffectPiston;

// --------------------
// FUNCTIONS
// --------------------

EffectPiston *EffectPiston__Create(VecFx32 *position, VecU16 *dir);

#endif // RUSH_EFFECT_PISTON_H