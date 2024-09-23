#ifndef RUSH2_EFFECT_SAILBOAT_BAZOOKA_H
#define RUSH2_EFFECT_SAILBOAT_BAZOOKA_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectSailboatBazookaSmoke_
{
    EffectTask3D effWork;
} EffectSailboatBazookaSmoke;

// --------------------
// FUNCTIONS
// --------------------

EffectSailboatBazookaSmoke *EffectSailboatBazookaSmoke__Create(StageTask *parent, fx32 velX, fx32 velY, fx32 velZ);

#endif // RUSH2_EFFECT_SAILBOAT_BAZOOKA_H