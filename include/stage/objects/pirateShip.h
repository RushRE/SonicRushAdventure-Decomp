#ifndef RUSH_PIRATE_SHIP_H
#define RUSH_PIRATE_SHIP_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum PirateShipAnimIDs
{
    PIRATESHIP_ANI_SHIP,
    PIRATESHIP_ANI_SHOOT_EXPLOSION,
    PIRATESHIP_ANI_CANNONBALL,
};

// --------------------
// STRUCTS
// --------------------

typedef struct PirateShip_
{
    GameObjectTask gameWork;
    fx32 originPos;
    fx32 startPos;
    fx32 endPos;
    fx32 speed;
    fx32 unused;
} PirateShip;

typedef struct PirateShipCannonBall_
{
    GameObjectTask gameWork;
} PirateShipCannonBall;

// --------------------
// FUNCTIONS
// --------------------

PirateShip *CreatePirateShip(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
PirateShipCannonBall *CreatePirateShipCannonBall(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_PIRATE_SHIP_H
