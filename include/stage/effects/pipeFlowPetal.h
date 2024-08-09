#ifndef RUSH2_EFFECT_PIPE_FLOW_PETAL_H
#define RUSH2_EFFECT_PIPE_FLOW_PETAL_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectPipeFlowPetal_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectPipeFlowPetal;

// --------------------
// FUNCTIONS
// --------------------

EffectPipeFlowPetal *EffectPipeFlowPetal__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u16 type);
void EffectPipeFlowPetal__State_202AC78(EffectPipeFlowPetal *work);

#endif // RUSH2_EFFECT_PIPE_FLOW_PETAL_H