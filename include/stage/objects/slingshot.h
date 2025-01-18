#ifndef RUSH_SLINGSHOT_H
#define RUSH_SLINGSHOT_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum SlingshotFlags
{
    SLINGSHOT_FLAG_NONE,

    SLINGSHOT_FLAG_ROCK_LAUNCHED = (1 << 0),
};

// --------------------
// STRUCTS
// --------------------

typedef struct Slingshot_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniMachine;
    AnimatorSpriteDS aniCounterweight;
    Vec2Fx32 offset;
    s16 anglePercent;
} Slingshot;

typedef struct SlingshotRock_
{
    GameObjectTask gameWork;
} SlingshotRock;

// --------------------
// FUNCTIONS
// --------------------

Slingshot *CreateSlingshot(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
SlingshotRock *CreateSlingshotRock(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_SLINGSHOT_H
