#ifndef RUSH2_EFFECT_GRIND_H
#define RUSH2_EFFECT_GRIND_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectGrind_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK animator;
} EffectGrind;

// --------------------
// FUNCTIONS
// --------------------

// Grind
EffectGrind *CreateEffectGrindSparkForPlayer(Player *player);
EffectGrind *CreateEffectGrindSpark(Player *parent, fx32 velX, fx32 velY);
void EffectGrindSpark_State_FollowParent(EffectGrind *work);

// WaterGrind
EffectGrind *CreateEffectWaterGrindSpark(Player *parent, fx32 velX, fx32 velY);

#endif // RUSH2_EFFECT_GRIND_H