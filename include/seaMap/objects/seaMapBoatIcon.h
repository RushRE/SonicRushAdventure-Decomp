#ifndef RUSH2_SEAMAPBOATICON_H
#define RUSH2_SEAMAPBOATICON_H

#include <seaMap/seaMapEventManager.h>
#include <game/graphics/sprite.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapBoatIcon_
{
    SeaMapObject objWork;
    AnimatorSprite aniBoat;
} SeaMapBoatIcon;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED SeaMapObject *SeaMapBoatIcon__Create(CHEVObjectType *objectType, CHEVObject *mapObject);
NOT_DECOMPILED void SeaMapBoatIcon__Main(void);
NOT_DECOMPILED void SeaMapBoatIcon__Destructor(Task *task);

#endif // RUSH2_SEAMAPBOATICON_H