#ifndef RUSH2_SEAMAPTARGETFLAGICON_H
#define RUSH2_SEAMAPTARGETFLAGICON_H

#include <seaMap/seaMapEventManager.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapTargetFlagIcon_
{
    SeaMapObject objWork;
} SeaMapTargetFlagIcon;

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapTargetFlagIcon(CHEVObjectType *objectType, CHEVObject *mapObject);

#endif // RUSH2_SEAMAPTARGETFLAGICON_H