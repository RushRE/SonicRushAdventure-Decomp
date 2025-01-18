#ifndef RUSH_EFFECT_GOAL_JEWEL_H
#define RUSH_EFFECT_GOAL_JEWEL_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectGoalJewel_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK aniEffect;
} EffectGoalJewel;

// --------------------
// FUNCTIONS
// --------------------

EffectGoalJewel *EffectGoalJewel__Create(u16 type, fx32 x, fx32 y, fx32 velX, fx32 velY);

#endif // RUSH_EFFECT_GOAL_JEWEL_H