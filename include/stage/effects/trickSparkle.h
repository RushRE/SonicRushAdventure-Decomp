#ifndef RUSH2_EFFECT_TRICKSPARKLE_H
#define RUSH2_EFFECT_TRICKSPARKLE_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectTrickSparkle_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK animator;
} EffectTrickSparkle;

// --------------------
// FUNCTIONS
// --------------------

EffectTrickSparkle *CreateEffectTrickSparkleForPlayer(Player *player);
EffectTrickSparkle *CreateEffectTrickSparkle(Player *parent, fx32 offsetX, fx32 offsetY);

#endif // RUSH2_EFFECT_TRICKSPARKLE_H