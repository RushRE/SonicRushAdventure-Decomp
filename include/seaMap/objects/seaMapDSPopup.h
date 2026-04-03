#ifndef RUSH_SEAMAPDSPOPUP_H
#define RUSH_SEAMAPDSPOPUP_H

#include <seaMap/seaMapEventManager.h>
#include <game/graphics/sprite.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapDSPopup_
{
    SeaMapObject objWork;
    s32 timer;
    AnimatorSprite aniSprite;
} SeaMapDSPopup;

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapDSPopup(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject);

#endif // RUSH_SEAMAPDSPOPUP_H