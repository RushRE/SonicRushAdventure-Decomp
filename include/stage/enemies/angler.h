#ifndef RUSH2_ANGLER_H
#define RUSH2_ANGLER_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum AnglerType_
{
    ANGLER_TYPE_SHOOT,
    ANGLER_TYPE_CHARGE,
};
typedef u16 AnglerType;

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyAngler_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK colliderDetect;
    Vec2Fx32 targetPos;
    fx32 velocityStore;
    u8 shotCount;
    fx32 xMin;
    fx32 field_3B8;
    fx32 xMax;
    fx32 field_3C0;
    u16 type;
} EnemyAngler;

typedef struct EnemyAnglerShot_
{
    GameObjectTask gameWork;
} EnemyAnglerShot;

// --------------------
// FUNCTIONS
// --------------------

EnemyAngler *CreateAngler(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemyAnglerShot *CreateAnglerShot(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_ANGLER_H