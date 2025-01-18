#ifndef RUSH_SEAMAPBOATICON_H
#define RUSH_SEAMAPBOATICON_H

#include <seaMap/seaMapEventManager.h>
#include <game/graphics/sprite.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapBoatIcon_
{
    SeaMapObject objWork;
    AnimatorSprite aniBoat;
} SeaMapBoatIcon;

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapBoatIcon(CHEVObjectType *objectType, CHEVObject *mapObject);

#endif // RUSH_SEAMAPBOATICON_H