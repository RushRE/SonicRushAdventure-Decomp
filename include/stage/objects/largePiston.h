#ifndef RUSH_LARGE_PISTON_H
#define RUSH_LARGE_PISTON_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct LargePiston_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_NN_WORK aniPiston3D;
    VecFx32 dword4E0[2];
    VecFx32 field_4F8[2];
    void (*state1)(struct LargePiston_ *work);
    void (*state2)(struct LargePiston_ *work);
    s16 field_518;
    s16 field_51A;
    VecFx32 dword51C;
    VecFx32 dword528;
    VecFx32 dword534;
    VecFx32 dword540;
    VecFx32 dword54C;
    VecFx32 dword558;
    VecFx32 dword564;
    VecFx32 dword570;
    VecU16 direction2;
    VecU16 direction1;
} LargePiston;

// --------------------
// FUNCTIONS
// --------------------

LargePiston *LargePiston__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void LargePiston__State_2167CBC(LargePiston *work);
void LargePiston__State1_2167CEC(LargePiston *work);
void LargePiston__State2_2167F28(LargePiston *work);
void LargePiston__OnDefend_2168194(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void LargePiston__OnDefend_2168300(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void LargePiston__OnDefend_21683F0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void LargePiston__Draw(void);

#endif // RUSH_LARGE_PISTON_H
