#ifndef RUSH2_CRAB_H
#define RUSH2_CRAB_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyCrab_
{
    GameObjectTask gameWork;
    u32 dword364;
    u32 field_368;
    u32 dword36C;
    u32 field_370;
    u32 dword374;
    u32 field_378;
    u32 field_37C;
    u32 field_380;
} EnemyCrab;

// --------------------
// FUNCTIONS
// --------------------

EnemyCrab *EnemyCrab__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void EnemyCrab__Action_Init(EnemyCrab *work);
void EnemyCrab__State_21570F0(EnemyCrab *work);
void EnemyCrab__Action_Unknown(EnemyCrab *work);
void EnemyCrab__State_215728C(EnemyCrab *work);

#endif // RUSH2_CRAB_H