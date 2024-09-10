#ifndef RUSH2_EFFECT_MEDAL_H
#define RUSH2_EFFECT_MEDAL_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectMedal_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectMedal;

// --------------------
// FUNCTIONS
// --------------------

EffectMedal *EffectMedal__Create(StageTask *parent);
void EffectMedal__Destructor(Task *task);
void EffectMedal__State_202D514(EffectMedal *work);

#endif // RUSH2_EFFECT_MEDAL_H