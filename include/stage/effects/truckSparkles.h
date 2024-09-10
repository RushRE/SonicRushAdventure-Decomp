#ifndef RUSH2_EFFECT_TRUCK_SPARKLES_H
#define RUSH2_EFFECT_TRUCK_SPARKLES_H

#include <stage/effectTask.h>

// --------------------
// CONSTANTS
// --------------------

#define EFFECT_TRUCK_SPARKLES_PARTICLE_COUNT 16

// --------------------
// STRUCTS
// --------------------

typedef struct EffectTruckSparkles_
{
    StageTask objWork;

    AnimatorSpriteDS aniSparkles[3];
    AnimatorSpriteDS animatorList[EFFECT_TRUCK_SPARKLES_PARTICLE_COUNT];
    VecFx32 positionList[EFFECT_TRUCK_SPARKLES_PARTICLE_COUNT];
    u32 flagsBitfield[1];
    Vec2Fx32 position;
    u16 duration;
    u16 flags;
} EffectTruckSparkles;

// --------------------
// FUNCTIONS
// --------------------

EffectTruckSparkles *EffectTruckSparkles__Create(StageTask *parent, u16 duration, s32 userWork, fx32 offsetX, fx32 offsetY, u16 flags);
void EffectTruckSparkles__Destructor(Task *task);
void EffectTruckSparkles__State_202B86C(EffectTruckSparkles *work);
void EffectTruckSparkles__State_202BA48(EffectTruckSparkles *work);
void EffectTruckSparkles__Draw(void);

#endif // RUSH2_EFFECT_TRUCK_SPARKLES_H