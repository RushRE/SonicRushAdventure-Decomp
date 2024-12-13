#ifndef RUSH2_SEAMAPDSPOPUP_H
#define RUSH2_SEAMAPDSPOPUP_H

#include <seaMap/seaMapEventManager.h>
#include <game/graphics/sprite.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapDSPopup_
{
    SeaMapObject objWork;
    s32 timer;
    AnimatorSprite aniSprite;
} SeaMapDSPopup;

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *SeaMapDSPopup__Create(CHEVObjectType *objectType, CHEVObject *mapObject);
void SeaMapDSPopup__Main(void);
void SeaMapDSPopup__Destructor(Task *task);

#endif // RUSH2_SEAMAPDSPOPUP_H