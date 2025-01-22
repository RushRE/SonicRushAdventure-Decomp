#ifndef RUSH_EFFECT_PIPE_FLOW_PETAL_H
#define RUSH_EFFECT_PIPE_FLOW_PETAL_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectFlowerPipePetal_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectFlowerPipePetal;

// --------------------
// FUNCTIONS
// --------------------

EffectFlowerPipePetal *EffectFlowerPipePetal__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u16 type);
void EffectFlowerPipePetal__State_202AC78(EffectFlowerPipePetal *work);

#endif // RUSH_EFFECT_PIPE_FLOW_PETAL_H