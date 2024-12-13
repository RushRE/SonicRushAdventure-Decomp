#ifndef RUSH2_SEAMAPSKYBABYLONICON_H
#define RUSH2_SEAMAPSKYBABYLONICON_H

#include <seaMap/seaMapEventManager.h>
#include <game/graphics/sprite.h>

// --------------------
// ENUMS
// --------------------

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

NOT_DECOMPILED SeaMapObject *SeaMapSkyBabylonIcon__Create(CHEVObjectType *objectType, CHEVObject *mapObject);
NOT_DECOMPILED void SeaMapSkyBabylonIcon__Main(void);
NOT_DECOMPILED void SeaMapSkyBabylonIcon__Destructor(Task *task);
NOT_DECOMPILED void SeaMapSkyBabylonIcon__State_2049C70(SeaMapSkyBabylonIcon *work);
NOT_DECOMPILED void SeaMapSkyBabylonIcon__State_2049C74(SeaMapSkyBabylonIcon *work);
NOT_DECOMPILED void SeaMapSkyBabylonIcon__State_2049CAC(SeaMapSkyBabylonIcon *work);
NOT_DECOMPILED void SeaMapSkyBabylonIcon__State_2049D54(SeaMapSkyBabylonIcon *work);
NOT_DECOMPILED void SeaMapSkyBabylonIcon__State_2049D8C(SeaMapSkyBabylonIcon *work);

#endif // RUSH2_SEAMAPSKYBABYLONICON_H