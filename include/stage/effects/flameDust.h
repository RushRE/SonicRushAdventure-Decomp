#ifndef RUSH2_EFFECT_FLAMEDUST_H
#define RUSH2_EFFECT_FLAMEDUST_H

#include <stage/effectTask.h>

// --------------------
// ENUMS
// --------------------

enum EffectFlameDustType_
{
    EFFECTFLAMEDUST_0,
    EFFECTFLAMEDUST_1,
    EFFECTFLAMEDUST_2,
    EFFECTFLAMEDUST_3,
};

typedef s32 EffectFlameDustType;

// --------------------
// STRUCTS
// --------------------

typedef struct EffectFlameDust_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK animator;
} EffectFlameDust;

// --------------------
// FUNCTIONS
// --------------------

EffectFlameDust *CreateEffectFlameDustForPlayer(Player *player);
EffectFlameDust *CreateEffectFlameDustForPlayer2(Player *player);
EffectFlameDust *CreateEffectFlameDustForPlayer3(Player *player);
EffectFlameDust *CreateEffectFlameDustForPlayerBlaze(Player *player);
EffectFlameDust *CreateEffectFlameDust(Player *player, fx32 velX, fx32 velY, EffectFlameDustType type);
void EffectFlameDust_State_Type2(EffectFlameDust *work);

#endif // RUSH2_EFFECT_FLAMEDUST_H