#ifndef RUSH_WATER_GUN_H
#define RUSH_WATER_GUN_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct WaterGun_
{
    GameObjectTask gameWork;
} WaterGun;

typedef struct WaterGrindTrigger_
{
    GameObjectTask gameWork;
} WaterGrindTrigger;

typedef struct WaterGrindRail_
{
    StageTask objWork;
    AnimatorSpriteDS animators[5];
    u16 instanceID;
    u16 instanceCount;
} WaterGrindRail;

// --------------------
// FUNCTIONS
// --------------------

WaterGun *WaterGun__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
WaterGun *WaterGrindTrigger__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void WaterGun__Destructor(Task *task);
void WaterGun__State_2183EC4(WaterGun *work);
void WaterGun__State_21840B4(WaterGun *work);
void WaterGun__State_2184248(WaterGun *work);
void WaterGun__State_21842A8(WaterGun *work);
void WaterGun__State_21843E4(WaterGun *work);
void WaterGun__Func_218448C(WaterGun *work);
void WaterGun__Draw(void);
void WaterGun__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

void WaterGrindTrigger__State_218477C(WaterGrindTrigger *work);
void WaterGrindTrigger__Draw(void);
void WaterGrindTrigger__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

void WaterGrindRail__Create(s32 id);
void WaterGrindRail__Func_2184D34(s32 id);
void WaterGrindRail__Destructor(Task *task);
void WaterGrindRail__Func_2184DB8(WaterGrindRail *work);
AnimatorSpriteDS *WaterGrindRail__GetAnimator(s32 id);
void WaterGrindRail__Draw(void);

#endif // RUSH_WATER_GUN_H
