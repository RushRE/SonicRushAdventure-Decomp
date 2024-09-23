#ifndef RUSH2_EFFECT_SNOW_SLIDE_H
#define RUSH2_EFFECT_SNOW_SLIDE_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectSnowSlide_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectSnowSlide;

// --------------------
// FUNCTIONS
// --------------------

EffectSnowSlide *EffectAvalanche__Create(fx32 x, fx32 y, fx32 velX, fx32 velY);
EffectSnowSlide *EffectAvalancheDebris__Create(u8 type, fx32 x, fx32 y, fx32 velX, fx32 velY);

#endif // RUSH2_EFFECT_SNOW_SLIDE_H