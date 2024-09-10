#ifndef RUSH2_EFFECT_INVINCIBLESPARKLE_H
#define RUSH2_EFFECT_INVINCIBLESPARKLE_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectInvincibleSparkle_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK animator;
} EffectInvincibleSparkle;

// --------------------
// FUNCTIONS
// --------------------

void CreateEffectInvincibleSparkle(fx32 x, fx32 y, u16 timer);
void EffectInvincibleSparkle_State_SparkleOrbit(EffectInvincibleSparkle *work);

#endif // RUSH2_EFFECT_INVINCIBLESPARKLE_H