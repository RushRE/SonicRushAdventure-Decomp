#ifndef RUSH2_SKYMOON_H
#define RUSH2_SKYMOON_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemySkymoon_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK collider;
    fx32 xMin;
    fx32 xMax;
    s32 timer;
    u16 angle;
} EnemySkymoon;

typedef struct EnemySkymoonLaser_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK collider;
    fx32 xMin;
    fx32 xMax;
    s32 timer;
    u16 angle;
} EnemySkymoonLaser;

// --------------------
// FUNCTIONS
// --------------------

EnemySkymoon *EnemySkymoon__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemySkymoonLaser *EnemySkymoonLaser__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void EnemySkymoon__Func_215D36C(EnemySkymoon *work);
void EnemySkymoon__Func_215D390(EnemySkymoon *work);
void EnemySkymoon__State_215D3E0(EnemySkymoon *work);
void EnemySkymoon__Func_215D414(EnemySkymoon *work);
void EnemySkymoon__Func_215D450(EnemySkymoon *work);
void EnemySkymoon__Func_215D50C(EnemySkymoon *work);
void EnemySkymoon__Func_215D55C(EnemySkymoon *work);
void EnemySkymoon__State_215D590(EnemySkymoon *work);
void EnemySkymoon__OnDefend_215D6A4(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void EnemySkymoonLaser__State_215D750(EnemySkymoonLaser *work);

#endif // RUSH2_SKYMOON_H