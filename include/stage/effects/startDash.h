#ifndef RUSH_EFFECT_START_DASH_H
#define RUSH_EFFECT_START_DASH_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectStartDash_
{
    EffectTask3D effWork;
} EffectStartDash;

// --------------------
// FUNCTIONS
// --------------------

EffectStartDash *EffectStartDash__Create(StageTask *parent);

#endif // RUSH_EFFECT_START_DASH_H