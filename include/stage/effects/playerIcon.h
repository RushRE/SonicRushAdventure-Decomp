#ifndef RUSH_EFFECT_PLAYERICON_H
#define RUSH_EFFECT_PLAYERICON_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectPlayerIcon_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK animator;
} EffectPlayerIcon;

// --------------------
// FUNCTIONS
// --------------------

EffectPlayerIcon *CreateEffectPlayerIcon(Player *parent);
void EffectPlayerIcon_State_TrackParent(EffectPlayerIcon *work);

#endif // RUSH_EFFECT_PLAYERICON_H