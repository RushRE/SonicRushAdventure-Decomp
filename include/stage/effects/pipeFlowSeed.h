#ifndef RUSH2_EFFECT_PIPE_FLOW_SEED_H
#define RUSH2_EFFECT_PIPE_FLOW_SEED_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectPipeFlowSeed_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectPipeFlowSeed;

// --------------------
// FUNCTIONS
// --------------------

EffectPipeFlowSeed *EffectPipeFlowSeed__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u16 type);
void EffectPipeFlowSeed__State_202ADFC(EffectPipeFlowSeed *work);

#endif // RUSH2_EFFECT_PIPE_FLOW_SEED_H