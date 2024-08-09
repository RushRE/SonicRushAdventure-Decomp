#ifndef RUSH2_RINGBUTTON_H
#define RUSH2_RINGBUTTON_H

#include <stage/gameObject.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define RingButton_mapObjectParam_id     mapObject->left

// --------------------
// STRUCTS
// --------------------

typedef struct RingButton_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniBase;
    VecFx32 buttonPos;
    void (*onActivated)(struct RingButton_ *work);
} RingButton;

// --------------------
// FUNCTIONS
// --------------------

RingButton *CreateRingButton(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_RINGBUTTON_H