#ifndef RUSH_EFFECT_EXPLOSION_H
#define RUSH_EFFECT_EXPLOSION_H

#include <stage/effectTask.h>

// --------------------
// ENUMS
// --------------------

enum ExplosionType_
{
    EXPLOSION_ENEMY,
    EXPLOSION_SMALL,
    EXPLOSION_BIG,

    EXPLOSION_COUNT,
};
typedef u32 ExplosionType;

// --------------------
// STRUCTS
// --------------------

typedef struct EffectExplosion_
{
    StageTask objWork;

    OBS_ACTION2D_BAC_WORK ani;
} EffectExplosion;

typedef struct EffectExplosionHazard_
{
    StageTask objWork;

    OBS_ACTION2D_BAC_WORK ani;
    OBS_RECT_WORK collider;
    u16 targetFrame;
} EffectExplosionHazard;

// --------------------
// FUNCTIONS
// --------------------

// EffectExplosion
EffectExplosion *CreateEffectExplosion(StageTask *parent, fx32 velX, fx32 velY, ExplosionType type);

// EffectExplosionHazard
EffectExplosionHazard *CreateEffectExplosionHazard(StageTask *parent, fx32 velX, fx32 velY, s16 left, s16 top, s16 right, s16 bottom, u16 targetFrame, ExplosionType type);
void EffectExplosionHazard_State_Active(EffectExplosionHazard *work);

#endif // RUSH_EFFECT_EXPLOSION_H