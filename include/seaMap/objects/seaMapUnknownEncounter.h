#ifndef RUSH_SEAMAPUNKNOWNENCOUNTER_H
#define RUSH_SEAMAPUNKNOWNENCOUNTER_H

#include <seaMap/seaMapEventManager.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapUnknownEncounter_
{
    SeaMapObject objWork;
} SeaMapUnknownEncounter;

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapUnknownEncounter(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject);

// View Check
BOOL SeaMapUnknownEncounter_ArrivalCheck(SeaMapLayoutObject *mapObject, fx32 x, fx32 y, BOOL ignoreDiscoveryCheck);

#endif // RUSH_SEAMAPUNKNOWNENCOUNTER_H