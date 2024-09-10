#ifndef RUSH2_EFFECT_BATTLEATTACK_H
#define RUSH2_EFFECT_BATTLEATTACK_H

#include <stage/effectTask.h>

// --------------------
// ENUMS
// --------------------

enum EffectBattleAttackTypes_
{
    EFFECTBATTLEATTACK_SLOWMO,
    EFFECTBATTLEATTACK_CONFUSION,
    EFFECTBATTLEATTACK_TENSION_GAIN,
    EFFECTBATTLEATTACK_TENSION_DRAIN,
};

typedef u32 EffectBattleAttackTypes;

// --------------------
// STRUCTS
// --------------------

typedef struct EffectBattleAttack_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK animator;
} EffectBattleAttack;

// --------------------
// FUNCTIONS
// --------------------

EffectBattleAttack *CreateEffectBattleAttack(Player *parent, EffectBattleAttackTypes type);
void EffectBattleAttack_State_SlowMo(EffectBattleAttack *work);
void EffectBattleAttack_State_Confusion(EffectBattleAttack *work);
void EffectBattleAttack_State_TensionGain(EffectBattleAttack *work);
void EffectBattleAttack_State_TensionDrain(EffectBattleAttack *work);

#endif // RUSH2_EFFECT_BATTLEATTACK_H