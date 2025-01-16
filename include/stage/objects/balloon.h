#ifndef RUSH2_BALLOON_H
#define RUSH2_BALLOON_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Balloon_
{
    GameObjectTask gameWork;

    union
    {
        struct
        {

            AnimatorSpriteDS aniBalloon;
            AnimatorSpriteDS aniCrystal;
        };

        AnimatorSpriteDS animators[2];
    };
} Balloon;

typedef struct BalloonSpawner_
{
    GameObjectTask gameWork;
    Balloon *balloon;
} BalloonSpawner;

// --------------------
// FUNCTIONS
// --------------------

BalloonSpawner *CreateBalloonSpawner(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
Balloon *CreateBalloon(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_BALLOON_H
