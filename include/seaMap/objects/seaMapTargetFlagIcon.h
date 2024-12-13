#ifndef RUSH2_SEAMAPTARGETFLAGICON_H
#define RUSH2_SEAMAPTARGETFLAGICON_H

#include <seaMap/seaMapEventManager.h>

// --------------------
// ENUMS
// --------------------

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

SeaMapObject *SeaMapTargetFlagIcon__Create(CHEVObjectType *objectType, CHEVObject *mapObject);
void SeaMapTargetFlagIcon__Main(void);
void SeaMapTargetFlagIcon__Destructor(Task *task);

#endif // RUSH2_SEAMAPTARGETFLAGICON_H