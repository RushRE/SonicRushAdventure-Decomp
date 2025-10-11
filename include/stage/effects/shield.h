#ifndef RUSH_EFFECT_SHIELD_H
#define RUSH_EFFECT_SHIELD_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectShield_
{
    StageTask objWork;

    OBS_ACTION3D_SIMPLE_WORK esWork[9];
    s32 alpha;
    u16 field_79C;
    u16 field_79E;
    u16 field_7A0;
    u16 field_7A2;
} EffectShield;

// --------------------
// FUNCTIONS
// --------------------

// RegularShield
void CreateEffectRegularShieldForPlayer(Player *player);
EffectShield *CreateEffectRegularShield(Player *parent);
void EffectRegularShield_State_Active(EffectShield *work);

// ElectricShield
void CreateEffectMagnetShieldForPlayer(Player *player);
EffectShield *CreateEffectMagnetShield(Player *parent);
void EffectMagnetShield_State_Active(EffectShield *work);

#endif // RUSH_EFFECT_SHIELD_H