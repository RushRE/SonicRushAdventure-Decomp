#ifndef RUSH_SEAMAPMJOHNNYICON_H
#define RUSH_SEAMAPMJOHNNYICON_H

#include <seaMap/seaMapEventManager.h>

// --------------------
// ENUMS
// --------------------

enum SeaMapJohnnyIconFlags
{
    SEAMAPJOHNNYICON_FLAG_NONE = 0x00,

    // Determines if this icon is for the story event before sonic reaches coral cave or not
    SEAMAPJOHNNYICON_FLAG_STORY_EVENT = 1 << 0,
};

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapJohnnyIcon_
{
    SeaMapObject objWork;
} SeaMapJohnnyIcon;

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapJohnnyIcon(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject);

// View Check
BOOL SeaMapJohnnyIcon_ArrivalCheck(SeaMapLayoutObject *mapObject, fx32 x, fx32 y, BOOL ignoreDiscoveryCheck);

#endif // RUSH_SEAMAPMJOHNNYICON_H