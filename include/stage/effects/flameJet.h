#ifndef RUSH_EFFECT_FLAMEJET_H
#define RUSH_EFFECT_FLAMEJET_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectFlameJet_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK animator;
} EffectFlameJet;

typedef struct EffectFlameJet3D_
{
    StageTask objWork;
    
    OBS_ACTION3D_BAC_WORK animator;
} EffectFlameJet3D;

// --------------------
// FUNCTIONS
// --------------------

// FlameJet
EffectFlameJet *CreateEffectFlameJetForPlayer(Player *player);
EffectFlameJet *CreateEffectFlameJet(Player *player, fx32 velX, fx32 velY);
void EffectFlameJet_State_Active(EffectFlameJet *work);

// FlameJet3D
EffectFlameJet3D *CreateEffectFlameJet3D(Player *player, fx32 velX, fx32 velY);
EffectFlameJet3D *CreateEffectFlameJet3DForPlayer(Player *player, fx32 velX, fx32 velY);
void EffectFlameJet3D_State_Active3D(EffectFlameJet3D *work);

#endif // RUSH_EFFECT_FLAMEJET_H