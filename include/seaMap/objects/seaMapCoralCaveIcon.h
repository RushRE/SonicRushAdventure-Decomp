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

NOT_DECOMPILED SeaMapObject *SeaMapCoralCaveIcon__Create(CHEVObjectType *objectType, CHEVObject *mapObject);
NOT_DECOMPILED void SeaMapCoralCaveIcon__Main(void);
NOT_DECOMPILED void SeaMapCoralCaveIcon__Destructor(Task *task);
NOT_DECOMPILED void SeaMapCoralCaveIcon__State_2049920(SeaMapCoralCaveIcon *work);
NOT_DECOMPILED void SeaMapCoralCaveIcon__State_2049924(SeaMapCoralCaveIcon *work);
NOT_DECOMPILED void SeaMapCoralCaveIcon__State_204995C(SeaMapCoralCaveIcon *work);
NOT_DECOMPILED void SeaMapCoralCaveIcon__State_20499A0(SeaMapCoralCaveIcon *work);
NOT_DECOMPILED void SeaMapCoralCaveIcon__State_20499D8(SeaMapCoralCaveIcon *work);

#endif // RUSH2_SEAMAPCORALCAVEICON_H