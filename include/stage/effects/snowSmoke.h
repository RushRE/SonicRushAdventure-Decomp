#ifndef RUSH2_EFFECT_SNOWSMOKE_H
#define RUSH2_EFFECT_SNOWSMOKE_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectSnowSmoke_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK animator;
} EffectSnowSmoke;

// --------------------
// FUNCTIONS
// --------------------

EffectSnowSmoke *CreateSmallEffectSnowSmokeForPlayer(Player *player);
EffectSnowSmoke *CreateLargeEffectSnowSmokeForPlayer(Player *player);
EffectSnowSmoke *CreateEffectSnowSmoke(Player *parent, fx32 offsetX, fx32 offsetY, s32 animID);

#endif // RUSH2_EFFECT_SNOWSMOKE_H