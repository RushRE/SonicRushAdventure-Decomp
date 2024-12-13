#ifndef RUSH2_SEAMAPSKYBABYLONICON_H
#define RUSH2_SEAMAPSKYBABYLONICON_H

#include <seaMap/seaMapEventManager.h>
#include <game/graphics/sprite.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapSkyBabylonIcon_
{
    SeaMapObject objWork;
    AnimatorSprite aniIcon;
    AnimatorSprite aniShadow;
    u16 angle;
    void (*state)(struct SeaMapSkyBabylonIcon_ *work);
} SeaMapSkyBabylonIcon;

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapSkyBabylonIcon(CHEVObjectType *objectType, CHEVObject *mapObject);

// States
void SeaMapSkyBabylonIcon_State_BeginAppear(SeaMapSkyBabylonIcon *work);

#endif // RUSH2_SEAMAPSKYBABYLONICON_H