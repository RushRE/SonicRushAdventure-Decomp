#ifndef RUSH_DIVESTAND_H
#define RUSH_DIVESTAND_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct DiveStand_
{
    GameObjectTask gameWork;
    void *sprDiveStand3D;
    AnimatorSprite3D aniDiveStand[1];
    GXDLInfo drawList;
    void *drawData;
    VecFx32 vertices[25][2];
    u16 angles[24];
    s32 dword70C;
    u16 field_710;
    u16 field_712;
} DiveStand;

// --------------------
// FUNCTIONS
// --------------------

DiveStand *DiveStand__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void DiveStand__Func_2169F6C(DiveStand *work);
void DiveStand__Destructor(Task *task);
void DiveStand__State_Active(DiveStand *work);
void DiveStand__Draw(void);
void DiveStand__OnDefend_DiveStandSolid(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void DiveStand__OnDefend_DiveTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // RUSH_DIVESTAND_H
