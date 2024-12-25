#ifndef RUSH2_SEAMAPCORALCAVEICON_H
#define RUSH2_SEAMAPCORALCAVEICON_H

#include <seaMap/seaMapEventManager.h>
#include <game/graphics/sprite.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapCoralCaveIcon_
{
    SeaMapObject objWork;
    AnimatorSprite aniIcon;
    void (*state)(struct SeaMapCoralCaveIcon_ *work);
} SeaMapCoralCaveIcon;

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapCoralCaveIcon(CHEVObjectType *objectType, CHEVObject *mapObject);

#endif // RUSH2_SEAMAPCORALCAVEICON_H