#ifndef RUSH2_SNOWBALL_H
#define RUSH2_SNOWBALL_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemySnowball_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK colliderDetect;
    u8 isExposed;
    u16 field_3A6;
    s32 field_3A8;
    s32 field_3AC;
    s32 field_3B0;
    s32 field_3B4;
    s32 field_3B8;
    s32 field_3BC;
    void *exposedOnDefendFunc;
} EnemySnowball;

typedef struct EnemySnowballShot_
{
    GameObjectTask gameWork;
} EnemySnowballShot;

// --------------------
// FUNCTIONS
// --------------------

EnemySnowball *EnemySnowball__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemySnowballShot *EnemySnowballShot__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void EnemySnowball__Func_2158844(EnemySnowball *work);
void EnemySnowball__Func_215886C(EnemySnowball *work);
void EnemySnowballShot__Func_2158934(EnemySnowballShot *work);
void EnemySnowballShot__Func_215896C(EnemySnowballShot *work);
void EnemySnowballShot__State_21589DC(EnemySnowballShot *work);
void EnemySnowballShot__State_2158A14(EnemySnowballShot *work);
void EnemySnowballShot__OnDefend_2158AC4(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void EnemySnowballShot__State_2158B30(EnemySnowballShot *work);
void EnemySnowball__Func_2158B60(EnemySnowball *work);
void EnemySnowball__Func_2158B94(EnemySnowball *work);
void EnemySnowballShot__State_2158D24(EnemySnowballShot *work);

#endif // RUSH2_SNOWBALL_H