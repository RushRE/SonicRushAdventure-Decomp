#ifndef RUSH_BARREL_H
#define RUSH_BARREL_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Barrel_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniBarrel1;
    AnimatorSpriteDS aniBarrel2;
    s32 timer;
    s32 field_4B0;
    s32 field_4B4;
    s16 field_4B8;
    s16 field_4BA;
} Barrel;

// --------------------
// FUNCTIONS
// --------------------

Barrel *Barrel__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void Barrel__Destructor(Task *task);
void Barrel__Func_21777F4(Barrel *work);
void Barrel__State_2177894(Barrel *work);
void Barrel__Func_21779A0(Barrel *work);
void Barrel__State_21779F0(Barrel *work);
void Barrel__Func_2177B14(Barrel *work);
void Barrel__State_2177B64(Barrel *work);
void Barrel__Draw(void);
void Barrel__OnDefend_2178178(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void Barrel__OnDefend_21781A8(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // RUSH_BARREL_H
