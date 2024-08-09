#ifndef RUSH2_EFFECT_ICE_SPARKLES_SPAWNER_H
#define RUSH2_EFFECT_ICE_SPARKLES_SPAWNER_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectIceSparklesSpawner_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectIceSparklesSpawner;

// --------------------
// FUNCTIONS
// --------------------

EffectIceSparklesSpawner *EffectIceSparklesSpawner__Create(StageTask *parent);
void EffectIceSparklesSpawner__State_202D19C(EffectIceSparklesSpawner *work);

#endif // RUSH2_EFFECT_ICE_SPARKLES_SPAWNER_H