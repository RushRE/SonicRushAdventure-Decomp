#ifndef RUSH2_EFFECT_BATTLE_BURST_H
#define RUSH2_EFFECT_BATTLE_BURST_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectBattleBurst_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectBattleBurst;

// --------------------
// FUNCTIONS
// --------------------

EffectBattleBurst *CreateEffectBattleBurst(fx32 x, fx32 y);

#endif // RUSH2_EFFECT_BATTLE_BURST_H