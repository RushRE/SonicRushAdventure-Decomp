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

NOT_DECOMPILED SeaMapObject *SeaMapTargetFlagIcon__Create(CHEVObjectType *objectType, CHEVObject *mapObject);
NOT_DECOMPILED void SeaMapTargetFlagIcon__Main(void);
NOT_DECOMPILED void SeaMapTargetFlagIcon__Destructor(Task *task);

#endif // RUSH2_SEAMAPTARGETFLAGICON_H