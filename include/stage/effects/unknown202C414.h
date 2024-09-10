#ifndef RUSH2_EFFECT_UNKNOWN202C414_H
#define RUSH2_EFFECT_UNKNOWN202C414_H

#include <stage/effectTask.h>

// --------------------
// CONSTANTS
// --------------------

#define EFFECTUNKNOWN202C414_LIST_SIZE 32

// --------------------
// STRUCTS
// --------------------

typedef struct EffectUnknown202C414Entry_
{
    u16 active;
    u16 angle0;
    u16 angle1;
    u16 angle2;
    VecFx32 position;
    fx32 scale;
} EffectUnknown202C414Entry;

typedef struct EffectUnknown202C414_
{
    StageTask objWork;

    GXDLInfo info;
    const void *cmdList;
    EffectUnknown202C414Entry list[EFFECTUNKNOWN202C414_LIST_SIZE];
} EffectUnknown202C414;

// --------------------
// FUNCTIONS
// --------------------

EffectUnknown202C414 *EffectUnknown202C414__Create(StageTask *parent);
void EffectUnknown202C414__Destructor(Task *task);
void EffectUnknown202C414__State_202C5F8(EffectUnknown202C414 *work);
void EffectUnknown202C414__Draw(void);

#endif // RUSH2_EFFECT_UNKNOWN202C414_H