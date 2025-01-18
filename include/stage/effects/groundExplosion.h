#ifndef RUSH_EFFECT_GROUND_EXPLOSION_H
#define RUSH_EFFECT_GROUND_EXPLOSION_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectGroundExplosion_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectGroundExplosion;

// --------------------
// FUNCTIONS
// --------------------

EffectGroundExplosion *CreateEffectGroundExplosion(StageTask *parent, fx32 velX, fx32 velY);

#endif // RUSH_EFFECT_GROUND_EXPLOSION_H