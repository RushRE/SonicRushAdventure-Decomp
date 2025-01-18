#ifndef RUSH_EFFECT_INVINCIBLE_H
#define RUSH_EFFECT_INVINCIBLE_H

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

#endif // RUSH_EFFECT_INVINCIBLE_H