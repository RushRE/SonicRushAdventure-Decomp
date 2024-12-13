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

NOT_DECOMPILED SeaMapObject *SeaMapDSPopup__Create(CHEVObjectType *objectType, CHEVObject *mapObject);
NOT_DECOMPILED void SeaMapDSPopup__Main(void);
NOT_DECOMPILED void SeaMapDSPopup__Destructor(Task *task);

#endif // RUSH2_SEAMAPDSPOPUP_H