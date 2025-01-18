#ifndef RUSH_SEAMAPSTYLUSICON_H
#define RUSH_SEAMAPSTYLUSICON_H

#include <seaMap/seaMapEventManager.h>
#include <game/graphics/sprite.h>

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
    s16 speed;
    s16 percent;
    u16 timer;
} SeaMapStylusIcon;

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapStylusIcon(CHEVObjectType *objectType, CHEVObject *mapObject);

#endif // RUSH_SEAMAPSTYLUSICON_H