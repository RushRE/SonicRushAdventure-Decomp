#ifndef RUSH_EFFECT_MEDAL_H
#define RUSH_EFFECT_MEDAL_H

#include <stage/effectTask.h>
#include <game/graphics/paletteAnimation.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectMedal_
{
    StageTask objWork;

    OBS_ACTION2D_BAC_WORK aniSprite;
    PaletteAnimator aniPalette;
    u32 sparkleTimer;
} EffectMedal;

// --------------------
// FUNCTIONS
// --------------------

EffectMedal *EffectMedal__Create(StageTask *parent);
void EffectMedal__Destructor(Task *task);
void EffectMedal__State_202D514(EffectMedal *work);

#endif // RUSH_EFFECT_MEDAL_H