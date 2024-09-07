#ifndef RUSH2_DIVEBAT_H
#define RUSH2_DIVEBAT_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyDiveBat_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK collider;
    u32 dword3A4;
    u32 dword3A8;
    Vec2Fx32 dword3AC;
    Vec2Fx32 field_3B4;
    u32 field_3BC;
    u32 dword3C0;
    u16 angle;
    u8 type;
} EnemyDiveBat;

// --------------------
// FUNCTIONS
// --------------------

EnemyDiveBat *EnemyDiveBat__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void EnemyDiveBat__Destructor(Task *task);
void EnemyDiveBat__CreateChild(MapObject *mapObject);
void EnemyDiveBat__Action_215C804(EnemyDiveBat *work);
void EnemyDiveBat__State_215C820(EnemyDiveBat *work);
void EnemyDiveBat__Draw(void);
void EnemyDiveBat__Action_Init(EnemyDiveBat *work);
void EnemyDiveBat__State_215C9D8(EnemyDiveBat *work);
void EnemyDiveBat__Action_215CBEC(EnemyDiveBat *work);
void EnemyDiveBat__State_215CC18(EnemyDiveBat *work);
void EnemyDiveBat__Action_215CC38(EnemyDiveBat *work);
void EnemyDiveBat__State_215CD40(EnemyDiveBat *work);
void EnemyDiveBat__Action_215CE0C(EnemyDiveBat *work);
void EnemyDiveBat__State_215CE4C(EnemyDiveBat *work);
void EnemyDiveBat__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // RUSH2_DIVEBAT_H