#ifndef RUSH2_EFFECT_DROWNALERT_H
#define RUSH2_EFFECT_DROWNALERT_H

#include <stage/effectTask.h>
#include <stage/effects/waterCommon.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectDrownAlert_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK animator;
} EffectDrownAlert;

// --------------------
// FUNCTIONS
// --------------------

EffectDrownAlert *CreateEffectDrownAlertForPlayer(Player *player, s32 animID);
EffectDrownAlert *CreateEffectDrownAlert(Player *parent, fx32 offsetX, fx32 offsetY, s32 animID);
void EffectDrownAlert_State_Rising(EffectDrownAlert *work);

#endif // RUSH2_EFFECT_DROWNALERT_H