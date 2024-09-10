#ifndef RUSH2_EFFECT_ENEMY_DEBRIS_H
#define RUSH2_EFFECT_ENEMY_DEBRIS_H

#include <stage/effectTask.h>

// --------------------
// ENUMS
// --------------------

enum EnemyDebrisType_
{
    ENEMYDEBRIS_COIL,
    ENEMYDEBRIS_PLATE,
    ENEMYDEBRIS_SCREW,
    ENEMYDEBRIS_CHIP,
    ENEMYDEBRIS_COIL_RANDOM,
    ENEMYDEBRIS_PLATE_RANDOM,
    ENEMYDEBRIS_SCREW_RANDOM,
    ENEMYDEBRIS_CHIP_RANDOM,
    ENEMYDEBRIS_RANDOM,

    ENEMYDEBRIS_COUNT,
};
typedef s32 EnemyDebrisType;

// --------------------
// STRUCTS
// --------------------

typedef struct EffectEnemyDebris_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectEnemyDebris;

// --------------------
// FUNCTIONS
// --------------------

EffectEnemyDebris *CreateEffectEnemyDebris(StageTask *parent, fx32 offsetX, fx32 offsetY, fx32 velX, fx32 velY, EnemyDebrisType type);
void EffectEnemyDebris_State_Active(EffectEnemyDebris *work);

#endif // RUSH2_EFFECT_ENEMY_DEBRIS_H