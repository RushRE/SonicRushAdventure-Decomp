#ifndef RUSH2_EFFECT_HUMMINGTOP_H
#define RUSH2_EFFECT_HUMMINGTOP_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectHummingTop_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK animator;
} EffectHummingTop;

// --------------------
// FUNCTIONS
// --------------------

EffectHummingTop *CreateEffectHummingTopForPlayer(Player *player);
EffectHummingTop *CreateEffectHummingTop(Player *player, fx32 velX, fx32 velY);
void EffectHummingTop_State_Active(EffectHummingTop *work);

#endif // RUSH2_EFFECT_HUMMINGTOP_H