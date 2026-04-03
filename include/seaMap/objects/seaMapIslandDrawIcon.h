#ifndef RUSH_SEAMAPISLANDDRAWICON_H
#define RUSH_SEAMAPISLANDDRAWICON_H

#include <seaMap/seaMapEventManager.h>
#include <game/util/spriteButton.h>
#include <game/input/touchField.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct SeaMapIslandDrawIcon_
{
    SeaMapObject objWork;
    SpriteButtonAnimator aniDrawIcon;
};

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapIslandDrawIcon(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject);

#endif // RUSH_SEAMAPISLANDDRAWICON_H