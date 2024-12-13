#ifndef RUSH2_SEAMAPUNKNOWN5_H
#define RUSH2_SEAMAPUNKNOWN5_H

#include <seaMap/seaMapEventManager.h>

// --------------------
// ENUMS
// --------------------

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

NOT_DECOMPILED SeaMapObject *SeaMapUnknown5__Create(CHEVObjectType *objectType, CHEVObject *mapObject);
NOT_DECOMPILED void SeaMapUnknown5__Main(void);
NOT_DECOMPILED void SeaMapUnknown5__Destructor(Task *task);
NOT_DECOMPILED BOOL SeaMapUnknown5__ViewCheck(CHEVObject *mapObject, fx32 x, fx32 y, BOOL flag);

#endif // RUSH2_SEAMAPUNKNOWN5_H