#ifndef RUSH2_SEAMAPUNKNOWN5_H
#define RUSH2_SEAMAPUNKNOWN5_H

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
void SeaMapUnknown5_Main(void);
void SeaMapUnknown5_Destructor(Task *task);
BOOL SeaMapUnknown5_ViewCheck(CHEVObject *mapObject, fx32 x, fx32 y, BOOL flag);

#endif // RUSH2_SEAMAPUNKNOWN5_H