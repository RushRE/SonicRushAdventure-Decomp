#ifndef RUSH2_EFFECT_EXPLOSION_H
#define RUSH2_EFFECT_EXPLOSION_H

#include <stage/effectTask.h>

// --------------------
// ENUMS
// --------------------

enum ExplosionType_
{
    EXPLOSION_ENEMY,
    EXPLOSION_ITEMBOX,
    EXPLOSION_BIG,

    EXPLOSION_COUNT,
};
typedef u32 ExplosionType;

// --------------------
// STRUCTS
// --------------------

typedef struct EffectExplosion_
{
    EffectTask objWork;

    OBS_ACTION2D_BAC_WORK ani;
} EffectExplosion;

typedef struct EffectExplosion2_
{
    EffectTask objWork;

    OBS_ACTION2D_BAC_WORK ani;
    OBS_RECT_WORK collider;
    u16 targetFrame;
} EffectExplosion2;

// --------------------
// FUNCTIONS
// --------------------

// EffectExplosion
EffectExplosion *CreateEffectExplosion(StageTask *parent, fx32 velX, fx32 velY, ExplosionType type);

// EffectExplosion2
EffectExplosion2 *CreateEffectHarmfulExplosion(StageTask *parent, fx32 velX, fx32 velY, s16 left, s16 top, s16 right, s16 bottom, u16 targetFrame, ExplosionType type);
void EffectHarmfulExplosion_State_Active(EffectExplosion2 *work);

#endif // RUSH2_EFFECT_EXPLOSION_H