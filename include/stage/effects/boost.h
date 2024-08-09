#ifndef RUSH2_EFFECT_BOOST_H
#define RUSH2_EFFECT_BOOST_H

#include <stage/effectTask.h>

// --------------------
// ENUMS
// --------------------

enum EffectBoostType_
{
    EFFECTBOOST_START_SUPER, // super boost start fx
    EFFECTBOOST_AURA,        // boost aura
    EFFECTBOOST_PARTICLE,    // boost particles
    EFFECTBOOST_START_BOOST, // boost start fx
};

typedef u16 EffectBoostType;

// --------------------
// STRUCTS
// --------------------

typedef struct EffectBoost_
{
    EffectTask objWork;

    OBS_ACTION2D_BAC_WORK animator;
} EffectBoost;

// --------------------
// FUNCTIONS
// --------------------

// Boost
EffectBoost *CreateEffectBoostSuperStartFX(Player *player);
EffectBoost *CreateEffectBoostAura(Player *player);
EffectBoost *CreateEffectBoostParticle(Player *player, fx32 velX, fx32 velY);
EffectBoost *CreateEffectBoostStartFX(Player *player, fx32 velX, fx32 velY);
EffectBoost *CreateEffectBoost(Player *parent, fx32 velX, fx32 velY, s32 characterID, EffectBoostType type);
void EffectBoost_Draw_Super(void);
void EffectBoost_State_Aura(EffectBoost *work);

#endif // RUSH2_EFFECT_BOOST_H