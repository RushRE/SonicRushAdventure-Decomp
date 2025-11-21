#ifndef RUSH_CANNON_H
#define RUSH_CANNON_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum CannonRingType_
{
    CANNONRING_TYPE_A_BUTTON,
    CANNONRING_TYPE_B_BUTTON,
    CANNONRING_TYPE_R_BUTTON,
    CANNONRING_TYPE_COUNT,

    CANNONRING_TYPE_FORCE_COMBO_FINISH = 0x80000000,
};

enum CannonPathModes_
{
    CANNONPATH_MODE_MOVE_TO_PATH,
    CANNONPATH_MODE_READY_PATH_TRAVERSE,
    CANNONPATH_MODE_TRAVERSE_PATH,
    CANNONPATH_MODE_BEGIN_EXIT_PATH,
    CANNONPATH_MODE_EXIT_PATH,
};

enum CannonPlayerEntryType_
{
    PLAYER_CANNON_ENTRY_FALL_INTO,
    PLAYER_CANNON_ENTRY_WALK_INTO,
    PLAYER_CANNON_ENTRY_ROTATE_INTO,
};
typedef s32 CannonPlayerEntryType;

enum CannonPlayerFlags_
{
    PLAYER_CANNON_FLAG_NONE = 0x00,

    PLAYER_CANNON_FLAG_IN_CANNON = 1 << 0,
};

enum CannonPathPlayerFlags_
{
    PLAYER_CANNONPATH_FLAG_NONE = 0x00,

    PLAYER_CANNONPATH_FLAG_UNUSED_1           = 1 << 0,
    PLAYER_CANNONPATH_FLAG_COMBO_B_BUTTON     = 1 << 1,
    PLAYER_CANNONPATH_FLAG_COMBO_A_BUTTON     = 1 << 2,
    PLAYER_CANNONPATH_FLAG_COMBO_R_BUTTON     = 1 << 3,
    PLAYER_CANNONPATH_FLAG_UNUSED_10          = 1 << 4,
    PLAYER_CANNONPATH_FLAG_FORCE_COMBO_FINISH = 1 << 5,
};

// --------------------
// STRUCTS
// --------------------

typedef struct CannonFloor_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_NN_WORK aniCannon;
    StageTaskCollisionObj collisionWorkWallL;
    StageTaskCollisionObj collisionWorkWallR;
} CannonFloor;

typedef struct Cannon_
{
    GameObjectTask gameWork;
    AnimatorMDL aniCannon[2];
} Cannon;

typedef struct CannonPath_
{
    GameObjectTask gameWork;
    VecFx32 cannonPos;
    VecU16 dir;
    s16 percent;
    fx32 pathRemaining;
    fx32 pathFallDistance;
    VecFx32 launchVelocity;
    fx32 fallVelocity;
    VecFx32 pathFinishTargetPos;
    VecFx32 pathFinishStartPos;
} CannonPath;

typedef struct CannonRing_
{
    GameObjectTask gameWork;
    AnimatorSprite3D aniRing;
    AnimatorSprite3D aniButtonPrompt;
    u16 type;
} CannonRing;

// --------------------
// FUNCTIONS
// --------------------

Cannon *CreateCannon(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
CannonFloor *CreateCannonFloor(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
CannonPath *CreateCannonPath(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
CannonRing *CreateCannonRing(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

fx32 GetCannonPlayerPosZ(void);

#endif // RUSH_CANNON_H
