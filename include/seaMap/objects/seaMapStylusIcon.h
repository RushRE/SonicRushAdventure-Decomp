#ifndef RUSH2_SEAMAPSTYLUSICON_H
#define RUSH2_SEAMAPSTYLUSICON_H

#include <seaMap/seaMapEventManager.h>
#include <game/graphics/sprite.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapStylusIcon_
{
    SeaMapObject objWork;
    void (*state)(struct SeaMapStylusIcon_ *work);
    AnimatorSprite aniStylus;
    Vec2Fx32 startPos;
    Vec2Fx32 endPos;
    u16 speed;
    u16 percent;
    u16 timer;
} SeaMapStylusIcon;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED SeaMapObject *SeaMapStylusIcon__Create(CHEVObjectType *objectType, CHEVObject *mapObject);
NOT_DECOMPILED u32 SeaMapStylusIcon_GetSpriteSize(void);
NOT_DECOMPILED void SeaMapStylusIcon__Main(void);
NOT_DECOMPILED void SeaMapStylusIcon__Destructor(Task *task);
NOT_DECOMPILED void SeaMapStylusIcon__State_20492D4(SeaMapStylusIcon *work);
NOT_DECOMPILED void SeaMapStylusIcon__State_2049340(SeaMapStylusIcon *work);
NOT_DECOMPILED void SeaMapStylusIcon__State_2049360(SeaMapStylusIcon *work);
NOT_DECOMPILED void SeaMapStylusIcon__State_2049384(SeaMapStylusIcon *work);
NOT_DECOMPILED void SeaMapStylusIcon__State_20493E8(SeaMapStylusIcon *work);
NOT_DECOMPILED void SeaMapStylusIcon__State_2049400(SeaMapStylusIcon *work);
NOT_DECOMPILED void SeaMapStylusIcon__State_20494A0(SeaMapStylusIcon *work);
NOT_DECOMPILED void SeaMapStylusIcon__State_20494B8(SeaMapStylusIcon *work);
NOT_DECOMPILED void SeaMapStylusIcon__State_20494D8(SeaMapStylusIcon *work);
NOT_DECOMPILED void SeaMapStylusIcon__State_2049510(SeaMapStylusIcon *work);

#endif // RUSH2_SEAMAPSTYLUSICON_H