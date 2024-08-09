#ifndef RUSH2_EFFECT_PIRATE_SHIP_H
#define RUSH2_EFFECT_PIRATE_SHIP_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectPirateShipCannonBlast_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectPirateShipCannonBlast;

// --------------------
// FUNCTIONS
// --------------------

EffectPirateShipCannonBlast *PirateShipCannonBlast__Create(StageTask *parent, fx32 velX, fx32 velY);

#endif // RUSH2_EFFECT_PIRATE_SHIP_H