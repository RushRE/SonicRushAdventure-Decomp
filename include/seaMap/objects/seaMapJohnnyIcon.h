#ifndef RUSH2_SEAMAPMJOHNNYICON_H
#define RUSH2_SEAMAPMJOHNNYICON_H

#include <seaMap/seaMapEventManager.h>

// --------------------
// ENUMS
// --------------------

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

SeaMapObject *CreateSeaMapJohnnyIcon(CHEVObjectType *objectType, CHEVObject *mapObject);

// View Check
BOOL SeaMapJohnnyIcon_ViewCheck(CHEVObject *mapObject, fx32 x, fx32 y, BOOL flag);

#endif // RUSH2_SEAMAPMJOHNNYICON_H