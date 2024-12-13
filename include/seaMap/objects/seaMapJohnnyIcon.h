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

NOT_DECOMPILED SeaMapObject *SeaMapJohnnyIcon__Create(CHEVObjectType *objectType, CHEVObject *mapObject);
NOT_DECOMPILED void SeaMapJohnnyIcon__Main(void);
NOT_DECOMPILED void SeaMapJohnnyIcon__Destructor(Task *task);
NOT_DECOMPILED BOOL SeaMapJohnnyIcon__ViewCheck(CHEVObject *mapObject, fx32 x, fx32 y, BOOL flag);

#endif // RUSH2_SEAMAPMJOHNNYICON_H