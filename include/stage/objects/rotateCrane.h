#ifndef RUSH_ROTATECRANE_H
#define RUSH_ROTATECRANE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct RotateCrane_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_NN_WORK aniVRotCraneMdl;
    AnimatorSpriteDS aniVRotCraneSpr;
    StageTaskCollisionObj collisionWork1;
    StageTaskCollisionObj collisionWork2;
} RotateCrane;

// --------------------
// FUNCTIONS
// --------------------

RotateCrane *RotateCrane__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void RotateCrane__Destructor(Task *task);
void RotateCrane__State_216D970(RotateCrane *work);
void RotateCrane__State_216DA08(RotateCrane *work);
void RotateCrane__State_216DD4C(RotateCrane *work);
void RotateCrane__Draw(void);
void RotateCrane__Collide(void);
void RotateCrane__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // RUSH_ROTATECRANE_H
