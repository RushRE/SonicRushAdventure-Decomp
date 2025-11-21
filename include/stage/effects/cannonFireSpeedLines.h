#ifndef RUSH_EFFECT_CANNONFIRESPEEDLINES_H
#define RUSH_EFFECT_CANNONFIRESPEEDLINES_H

#include <stage/effectTask.h>

// --------------------
// CONSTANTS
// --------------------

#define EFFECTCANNONFIRESPEEDLINES_LIST_SIZE 32

// --------------------
// STRUCTS
// --------------------

typedef struct EffectCannonFireSpeedLine_
{
    u16 active;
    u16 angle0;
    u16 angle1;
    u16 angle2;
    VecFx32 position;
    fx32 scale;
} EffectCannonFireSpeedLine;

typedef struct EffectCannonFireSpeedLines_
{
    StageTask objWork;

    GXDLInfo dlInfo;
    const void *drawList;
    EffectCannonFireSpeedLine list[EFFECTCANNONFIRESPEEDLINES_LIST_SIZE];
} EffectCannonFireSpeedLines;

// --------------------
// FUNCTIONS
// --------------------

EffectCannonFireSpeedLines *EffectCannonFireSpeedLines__Create(StageTask *parent);
void EffectCannonFireSpeedLines__Destructor(Task *task);
void EffectCannonFireSpeedLines__State_Active(EffectCannonFireSpeedLines *work);
void EffectCannonFireSpeedLines__Draw(void);

#endif // RUSH_EFFECT_CANNONFIRESPEEDLINES_H