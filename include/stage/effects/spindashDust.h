#ifndef RUSH2_EFFECT_SPINDASHDUST_H
#define RUSH2_EFFECT_SPINDASHDUST_H

#include <stage/effectTask.h>

// --------------------
// ENUMS
// --------------------

enum EffectSpindashDustType_
{
    EFFECTSPINDASHDUST_SMALL_DUST,
    EFFECTSPINDASHDUST_BIG_DUST,
};

typedef u16 EffectSpindashDustType;

// --------------------
// STRUCTS
// --------------------

typedef struct EffectSpindashDust_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK animator;
} EffectSpindashDust;

typedef struct EffectSpindashDust3D_
{
    StageTask objWork;
    
    OBS_ACTION3D_BAC_WORK animator;
} EffectSpindashDust3D;

// --------------------
// FUNCTIONS
// --------------------

// SpindashDust
EffectSpindashDust *CreateEffectSmallSpindashDust(Player *player);
EffectSpindashDust *CreateEffectBigSpindashDust(Player *player);
EffectSpindashDust *CreateEffectSpindashDust(Player *parent, fx32 velX, fx32 velY, s32 characterID, EffectSpindashDustType type);

// SpindashDust3D
EffectSpindashDust3D *CreateEffectSpindashDust3D(Player *parent, fx32 velX, fx32 velY, s32 characterID, EffectSpindashDustType type);
EffectSpindashDust3D *CreateEffectSpindashDust3DForBossArena(Player *player, fx32 velX, fx32 velY, s32 characterID, EffectSpindashDustType type);
void EffectSpindashDust3D_State_SmallDust(EffectSpindashDust3D *work);
void EffectSpindashDust3D_State_BigDust(EffectSpindashDust3D *work);

#endif // RUSH2_EFFECT_SPINDASHDUST_H