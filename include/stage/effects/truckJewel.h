#ifndef RUSH2_EFFECT_TRUCK_JEWEL_H
#define RUSH2_EFFECT_TRUCK_JEWEL_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectTruckJewel_
{
    EffectTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectTruckJewel;

// --------------------
// FUNCTIONS
// --------------------

EffectTruckJewel *EffectTruckJewel__Create(StageTask *parent, fx32 velX, fx32 velY, fx32 velZ, u8 type, u8 flag);
void EffectTruckJewel__State_202C06C(EffectTruckJewel *work);
void EffectTruckJewel__Draw(void);

#endif // RUSH2_EFFECT_TRUCK_JEWEL_H