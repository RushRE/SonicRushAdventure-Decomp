#ifndef RUSH_EFFECT_BOUNCYMUSHROOM_PUFF_H
#define RUSH_EFFECT_BOUNCYMUSHROOM_PUFF_H

#include <stage/effectTask.h>

// --------------------
// ENUMS
// --------------------

enum BouncyMushroomAnimIDs
{
    BOUNCYMUSHROOM_ANI_MUSHROOM,
    BOUNCYMUSHROOM_ANI_STEM_V,
    BOUNCYMUSHROOM_ANI_STEM_D,
    BOUNCYMUSHROOM_ANI_PUFF,
    BOUNCYMUSHROOM_ANI_ALT_PALETTE,
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