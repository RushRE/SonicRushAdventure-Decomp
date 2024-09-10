#ifndef RUSH2_EFFECT_WATERBUBBLE_H
#define RUSH2_EFFECT_WATERBUBBLE_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectWaterBubble_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectWaterBubble;

// --------------------
// FUNCTIONS
// --------------------

EffectWaterBubble *EffectWaterBubble__Create(fx32 x, fx32 y, s32 anim, u16 duration);
void EffectWaterBubble__State_202A198(EffectWaterBubble *work);

void CreateEffectWaterBubbleForPlayer(Player *player, fx32 x, fx32 y, u16 duration);

#endif // RUSH2_EFFECT_WATERBUBBLE_H