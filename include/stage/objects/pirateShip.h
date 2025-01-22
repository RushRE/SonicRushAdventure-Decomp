#ifndef RUSH_PIRATE_SHIP_H
#define RUSH_PIRATE_SHIP_H

#include <stage/gameObject.h>

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
    fx32 field_374;
} PirateShip;

typedef struct PirateShipCannonBall_
{
    GameObjectTask gameWork;
} PirateShipCannonBall;

// --------------------
// FUNCTIONS
// --------------------

PirateShip *PirateShip__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
PirateShipCannonBall *PirateShipCannonBall__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void PirateShip__State_217A358(PirateShip *work);
void PirateShip__State_217A444(PirateShip *work);
void PirateShip__State_217A714(PirateShip *work);
void PirateShip__OnDefend_217A7E0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
fx32 PirateShip__GetPlayerVelocity(Player *player);
void PirateShipCannonBall__State_217A90C(PirateShipCannonBall *work);
void PirateShipCannonBall__OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // RUSH_PIRATE_SHIP_H
