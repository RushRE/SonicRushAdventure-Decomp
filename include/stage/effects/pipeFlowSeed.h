#ifndef RUSH_EFFECT_PIPE_FLOW_SEED_H
#define RUSH_EFFECT_PIPE_FLOW_SEED_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectFlowerPipeSeed_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectFlowerPipeSeed;

// --------------------
// FUNCTIONS
// --------------------

EffectFlowerPipeSeed *EffectFlowerPipeSeed__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u16 type);
void EffectFlowerPipeSeed__State_202ADFC(EffectFlowerPipeSeed *work);

#endif // RUSH_EFFECT_PIPE_FLOW_SEED_H