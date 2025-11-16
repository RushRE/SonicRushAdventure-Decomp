#ifndef RUSH_WATER_GUN_H
#define RUSH_WATER_GUN_H

#include <stage/gameObject.h>

// --------------------
// enums
// --------------------

enum WaterGunUserFlags
{
    WATERGUN_USERFLAG_NONE,

    WATERGUN_USERFLAG_USED_GUN = 1 << 0,
    WATERGUN_USERFLAG_AIMING_UPWARDS = 1 << 1,
};

// --------------------
// STRUCTS
// --------------------

typedef struct WaterGun_
{
    GameObjectTask gameWork;
} WaterGun;

typedef struct WaterGrindRailSegment_
{
    GameObjectTask gameWork;
} WaterGrindRailSegment;

typedef struct WaterGrindRailManager_
{
    StageTask objWork;
    AnimatorSpriteDS animators[5];
    u16 instanceID;
    u16 instanceCount;
} WaterGrindRailManager;

// --------------------
// FUNCTIONS
// --------------------

WaterGun *CreateWaterGun(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
WaterGrindRailSegment *CreateWaterGrindRailSegment(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_WATER_GUN_H
