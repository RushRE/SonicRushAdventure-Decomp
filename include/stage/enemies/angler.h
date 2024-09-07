#ifndef RUSH2_ANGLER_H
#define RUSH2_ANGLER_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyAngler_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK collider;
    Vec2Fx32 targetPos;
    s32 field_3AC;
    u8 field_3B0;
    u8 field_3B1;
    u16 field_3B2;
    u32 dword3B4;
    u32 field_3B8;
    u32 dword3BC;
    u32 field_3C0;
    u16 word3C4;
} EnemyAngler;

typedef struct EnemyAnglerShot_
{
    GameObjectTask gameWork;
} EnemyAnglerShot;

// --------------------
// FUNCTIONS
// --------------------

EnemyAngler *EnemyAngler__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemyAnglerShot *EnemyAnglerShot__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void EnemyAngler__Action_Init(EnemyAngler *work);
void EnemyAngler__State_21569D0(EnemyAngler *work);
void EnemyAngler__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void EnemyAngler__State_2156C90(EnemyAngler *work);
void EnemyAnglerShot__State_2156E48(EnemyAnglerShot *work);
void EnemyAngler__State_2156E78(EnemyAngler *work);

#endif // RUSH2_ANGLER_H