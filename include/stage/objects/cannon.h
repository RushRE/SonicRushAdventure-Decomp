#ifndef RUSH_CANNON_H
#define RUSH_CANNON_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Cannon_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_NN_WORK aniCannon;
    StageTaskCollisionObj collisionWork1;
    StageTaskCollisionObj collisionWork2;
} Cannon;

typedef struct CannonField_
{
    GameObjectTask gameWork;
    AnimatorMDL aniCannon[2];
} CannonField;

typedef struct CannonPath_
{
    GameObjectTask gameWork;
    s32 field_364;
    s32 field_368;
    s32 field_36C;
    u16 field_370;
    u16 field_372;
    u16 field_374;
    s16 field_376;
    fx32 dword378;
    fx32 dword37C;
    VecFx32 field_380;
    fx32 dword38C;
    s32 field_390;
    s32 field_394;
    s32 field_398;
    s32 field_39C;
    s32 field_3A0;
    s32 field_3A4;
} CannonPath;

typedef struct CannonRing_
{
    GameObjectTask gameWork;
    AnimatorSprite3D animator1;
    AnimatorSprite3D animator2;
    u16 type;
} CannonRing;

// --------------------
// FUNCTIONS
// --------------------

CannonField *CannonField__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
Cannon *Cannon__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
CannonPath *CannonPath__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

fx32 CannonPath__GetOffsetZ(void);
CannonRing *CannonRing__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void CannonField__Destructor(Task *task);
void CannonField__State_217B17C(Cannon *work);
void CannonField__State_217B474(Cannon *work);
void CannonField__Draw(void);
void CannonField__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

void Cannon__State_217B7A8(Cannon *work);
void Cannon__Collide(void);

void CannonPath__Destructor(Task *task);
void CannonPath__State_217B868(Cannon *work);

void CannonRing__Destructor(Task *task);
void CannonRing__Draw_217BC38(void);
void CannonRing__OnDefend_217BD90(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void CannonRing__OnDefend_217BE24(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // RUSH_CANNON_H
