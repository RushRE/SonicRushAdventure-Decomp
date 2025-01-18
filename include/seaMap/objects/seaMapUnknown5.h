#ifndef RUSH_SEAMAPUNKNOWN5_H
#define RUSH_SEAMAPUNKNOWN5_H

#include <seaMap/seaMapEventManager.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapUnknown5_
{
    SeaMapObject objWork;
} SeaMapUnknown5;

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapUnknown5(CHEVObjectType *objectType, CHEVObject *mapObject);

// View Check
BOOL SeaMapUnknown5_ViewCheck(CHEVObject *mapObject, fx32 x, fx32 y, BOOL flag);

#endif // RUSH_SEAMAPUNKNOWN5_H