#ifndef RUSH_EFFECT_BOUNCYMUSHROOM_PUFF_H
#define RUSH_EFFECT_BOUNCYMUSHROOM_PUFF_H

#include <stage/effectTask.h>

// --------------------
// ENUMS
// --------------------

enum BouncyMushroomAnimIDs
{
    FLIPMUSHROOM_ANI_MUSHROOM,
    FLIPMUSHROOM_ANI_STEM_V,
    FLIPMUSHROOM_ANI_STEM_D,
    FLIPMUSHROOM_ANI_PUFF,
    FLIPMUSHROOM_ANI_ALT_PALETTE,
};

// --------------------
// STRUCTS
// --------------------

typedef struct EffectBouncyMushroomPuff_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectBouncyMushroomPuff;

// --------------------
// FUNCTIONS
// --------------------

EffectBouncyMushroomPuff *EffectBouncyMushroomPuff__Create(fx32 x, fx32 y, fx32 velX, fx32 velY);

#endif // RUSH_EFFECT_BOUNCYMUSHROOM_PUFF_H