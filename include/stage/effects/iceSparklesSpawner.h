#ifndef RUSH_EFFECT_ICE_SPARKLES_SPAWNER_H
#define RUSH_EFFECT_ICE_SPARKLES_SPAWNER_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectIceSparklesSpawner_
{
    StageTask objWork;
} EffectIceSparklesSpawner;

// --------------------
// FUNCTIONS
// --------------------

void EffectIceSparklesSpawner__Create(StageTask *parent);
void EffectIceSparklesSpawner__State_202D19C(EffectIceSparklesSpawner *work);

#endif // RUSH_EFFECT_ICE_SPARKLES_SPAWNER_H