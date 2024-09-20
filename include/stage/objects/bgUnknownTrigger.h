#ifndef RUSH2_BGUNKNOWNTRIGGER_H
#define RUSH2_BGUNKNOWNTRIGGER_H

#include <stage/gameObject.h>
#include <game/stage/mapSys.h>

// --------------------
// STRUCTS
// --------------------

typedef struct BGUnknownTrigger_
{
    GameObjectTask gameWork;
    Vec2Fx32 unknown;
} BGUnknownTrigger;

// --------------------
// FUNCTIONS
// --------------------

BGUnknownTrigger *CreateBGUnknownTrigger(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_BGUNKNOWNTRIGGER_H