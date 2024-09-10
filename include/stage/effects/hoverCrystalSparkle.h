#ifndef RUSH2_EFFECT_HOVER_CRYSTAL_SPARKLE_H
#define RUSH2_EFFECT_HOVER_CRYSTAL_SPARKLE_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectHoverCrystalSparkle_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectHoverCrystalSparkle;

// --------------------
// FUNCTIONS
// --------------------

EffectHoverCrystalSparkle *EffectHoverCrystalSparkle__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, fx32 accX, fx32 accY);
void EffectHoverCrystalSparkle__Destructor(Task *task);
void EffectHoverCrystalSparkle__State_202CFB8(EffectHoverCrystalSparkle *work);
void EffectHoverCrystalSparkle__Draw(void);

#endif // RUSH2_EFFECT_HOVER_CRYSTAL_SPARKLE_H