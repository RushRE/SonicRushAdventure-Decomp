#ifndef RUSH2_EFFECT_BRAKEDUST_H
#define RUSH2_EFFECT_BRAKEDUST_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectBrakeDust_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK animator;
} EffectBrakeDust;

typedef struct EffectBrakeDust3D_
{
    StageTask objWork;
    
    OBS_ACTION3D_BAC_WORK animator;
} EffectBrakeDust3D;

// --------------------
// FUNCTIONS
// --------------------

// BrakeDust
void CreateEffectBrakeDustForPlayer(Player *player);
EffectBrakeDust *CreateEffectBrakeDust(Player *parent, fx32 velX, fx32 velY);

// BrakeDust
EffectBrakeDust3D *CreateEffectBrakeDust3D(Player *parent, fx32 velX, fx32 velY);
EffectBrakeDust3D *CreateEffectBrakeDust3DForPlayer(Player *parent, fx32 velX, fx32 velY);

#endif // RUSH2_EFFECT_BRAKEDUST_H