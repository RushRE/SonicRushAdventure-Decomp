#ifndef RUSH2_EFFECT_INVINCIBLE_H
#define RUSH2_EFFECT_INVINCIBLE_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectInvincible_
{
    StageTask objWork;
} EffectInvincible;

// --------------------
// FUNCTIONS
// --------------------

void CreateEffectInvincible(Player *parent);
void EffectInvincible_State_Active(EffectInvincible *work);

#endif // RUSH2_EFFECT_INVINCIBLE_H