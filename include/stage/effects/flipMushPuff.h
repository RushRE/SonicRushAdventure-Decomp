#ifndef RUSH2_EFFECT_FLIP_MUSH_PUFF_H
#define RUSH2_EFFECT_FLIP_MUSH_PUFF_H

#include <stage/effectTask.h>

// --------------------
// ENUMS
// --------------------

enum FlipMushroomAnimIDs
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

typedef struct EffectFlipMushPuff_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectFlipMushPuff;

// --------------------
// FUNCTIONS
// --------------------

EffectFlipMushPuff *EffectFlipMushPuff__Create(fx32 x, fx32 y, fx32 velX, fx32 velY);

#endif // RUSH2_EFFECT_FLIP_MUSH_PUFF_H