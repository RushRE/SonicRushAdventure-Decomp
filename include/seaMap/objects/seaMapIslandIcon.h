#ifndef RUSH_SEAMAPISLANDICON_H
#define RUSH_SEAMAPISLANDICON_H

#include <seaMap/seaMapEventManager.h>
#include <seaMap/seaMapEventTrigger.h>

// --------------------
// ENUMS
// --------------------

enum SeaMapIslandIconFlags
{
    SEAMAPISLANDICON_FLAG_NONE = 0x00,

    SEAMAPISLANDICON_FLAG_DISCOVERABLE_VIA_VOYAGE = 1 << 0,
};

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapIslandIcon_
{
    SeaMapObject objWork;
    BOOL wasIslandDiscovered;
    SeaMapEventListener *eventListener;
} SeaMapIslandIcon;

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapIslandIcon(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject);
BOOL SeaMapIslandIcon_ArrivalCheck(SeaMapLayoutObject *mapObject, fx32 x, fx32 y, BOOL ignoreDiscoveryCheck);

#endif // RUSH_SEAMAPISLANDICON_H