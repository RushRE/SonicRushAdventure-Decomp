#ifndef RUSH_SEAMAPCUTSCENE_H
#define RUSH_SEAMAPCUTSCENE_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/input/touchField.h>
#include <seaMap/seaMapEventManager.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapCutscene_
{
    u32 field_0;
    s16 brightness;
    void (*state2)(struct SeaMapCutscene_ *work);
    void (*state1)(struct SeaMapCutscene_ *work);
    CHEVObject *boat;
    s32 startPos;
    s32 targetPos;
    s32 targetY;
    s16 percent;
    u16 timer2;
    s16 field_24;
    s16 field_26;
    TouchField touchField;
    TouchArea touchArea;
    AnimatorSprite aniPressStart;
    AnimatorSprite aniPressStartButton;
    void *bgCutscene;
    void *sprPressStartButton;
    void *sprPressStart;
} SeaMapCutscene;

// --------------------
// VARIABLES
// --------------------

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void SeaMapCutscene__Create(void);
NOT_DECOMPILED void SeaMapCutscene__TouchCallback(TouchAreaResponse *response, TouchArea *area, void *userData);
NOT_DECOMPILED void SeaMapCutscene__InitDisplay(void);
NOT_DECOMPILED void SeaMapCutscene__Main(void);
NOT_DECOMPILED void SeaMapCutscene__Main_Active(void);
NOT_DECOMPILED void SeaMapCutscene__Main_FadeOut(void);
NOT_DECOMPILED void SeaMapCutscene__Destructor(Task *task);
NOT_DECOMPILED void SeaMapCutscene__Func_2170600(void);
NOT_DECOMPILED void SeaMapCutscene__State2_2170674(SeaMapCutscene *work);
NOT_DECOMPILED void SeaMapCutscene__State1_21706B4(SeaMapCutscene *work);
NOT_DECOMPILED void SeaMapCutscene__State2_21706B8(SeaMapCutscene *work);
NOT_DECOMPILED void SeaMapCutscene__State2_21706D8(SeaMapCutscene *work);
NOT_DECOMPILED void SeaMapCutscene__State2_217077C(SeaMapCutscene *work);
NOT_DECOMPILED void SeaMapCutscene__State_21707A4(SeaMapCutscene *work);
NOT_DECOMPILED void SeaMapCutscene__State1_2170858(SeaMapCutscene *work);
NOT_DECOMPILED void SeaMapCutscene__State2_217085C(SeaMapCutscene *work);
NOT_DECOMPILED void SeaMapCutscene__State2_217087C(SeaMapCutscene *work);
NOT_DECOMPILED void SeaMapCutscene__State2_21708FC(SeaMapCutscene *work);
NOT_DECOMPILED void SeaMapCutscene__State2_217091C(SeaMapCutscene *work);
NOT_DECOMPILED void SeaMapCutscene__State2_2170998(SeaMapCutscene *work);
NOT_DECOMPILED void SeaMapCutscene__State2_2170A3C(SeaMapCutscene *work);
NOT_DECOMPILED void SeaMapCutscene__State2_2170AB4(SeaMapCutscene *work);

#endif // RUSH_SEAMAPCUTSCENE_H