#ifndef RUSH_SEAMAPBOATICON_H
#define RUSH_SEAMAPBOATICON_H

#include <seaMap/seaMapEventManager.h>
#include <game/graphics/sprite.h>

// --------------------
// STRUCTS
// --------------------

struct SeaMapBoatIcon_
{
    SeaMapObject objWork;
    AnimatorSprite aniBoat;
};

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapBoatIcon(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject);

#endif // RUSH_SEAMAPBOATICON_H