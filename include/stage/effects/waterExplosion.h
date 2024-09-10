#ifndef RUSH2_EFFECT_WATER_EXPLOSION_H
#define RUSH2_EFFECT_WATER_EXPLOSION_H

#include <stage/effectTask.h>

// --------------------
// ENUMS
// --------------------

enum WaterExplosionType_
{
    WATEREXPLOSION_BOMB,
    WATEREXPLOSION_BUBBLES,

    WATEREXPLOSION_COUNT,
};
typedef u32 WaterExplosionType;

// --------------------
// STRUCTS
// --------------------

typedef struct EffectWaterExplosion_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectWaterExplosion;

// --------------------
// FUNCTIONS
// --------------------

EffectWaterExplosion *CreateEffectWaterExplosion(StageTask *parent, fx32 velX, fx32 velY, WaterExplosionType type);

#endif // RUSH2_EFFECT_WATER_EXPLOSION_H