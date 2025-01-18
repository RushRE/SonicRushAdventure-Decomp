#ifndef RUSH_SAVE_SPRITE_BUTTON_H
#define RUSH_SAVE_SPRITE_BUTTON_H

#include <game/system/task.h>
#include <game/input/touchField.h>
#include <game/graphics/sprite.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SaveSpriteButtonCore_
{
    u16 hoverID;
    u16 timer;
    s32 type;
    s32 selectionID;
    TouchField touchRect;
    u32 field_24;
    TouchArea yesNoButtonArea[2];
    AnimatorSprite aniYesNoButtons[2];
    AnimatorSprite aniCursor;
    AnimatorSprite aniWifiIcon;
    BOOL useEngineB;
    Vec2Fx16 position;
    u16 paletteRow;
    u8 oamPriority;
    u8 oamOrder;
    void *sprYesButton;
    void *sprCursor;
    void *sprWiFiIcon;
    void (*state)(void);
} SaveSpriteButtonCore;

typedef struct SaveSpriteButton_
{
    SaveSpriteButtonCore work;
    FontAnimator fontAnimator;
    FontWindowAnimator fontWindowAni;
    void (*state2)(void);
    s16 field_370;
    s16 field_372;
    s32 field_374;
    s32 field_378;
    s32 field_37C;
} SaveSpriteButton;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void SaveSpriteButton__LoadAssets(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__Release(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__Func_2064588(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__Func_20645D8(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__RunState(SaveSpriteButton *work);
NOT_DECOMPILED BOOL SaveSpriteButton__CheckInvalidState(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__Func_2064614(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__Func_2064660(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State_InitButtons(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State_InitRects(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State_Selecting(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State_MadeSelection(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State_2064EB8(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State_2064ED0(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State_2064F08(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State_2064FC4(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State_206505C(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State_Release(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__Func_20650E0(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__Func_206515C(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__Func_20651A4(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__Func_20651D4(SaveSpriteButton *work, s32 a2, BOOL useEngineB, u16 a4, u8 a5, u8 a6, FontWindow *window, void *mpcFile, u16 a9, s32 a10,
                                                   u16 a11);
NOT_DECOMPILED void SaveSpriteButton__Func_20653AC(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__RunState2(SaveSpriteButton *work);
NOT_DECOMPILED BOOL SaveSpriteButton__CheckState2Thing(SaveSpriteButton *work);
NOT_DECOMPILED BOOL SaveSpriteButton__CheckInvalidState2(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__Func_206546C(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__Func_2065498(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__SetState2(SaveSpriteButton *work, void *state);
NOT_DECOMPILED void SaveSpriteButton__State2_20654B4(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State2_20654F8(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State2_2065574(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State2_20655C4(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State2_2065604(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State2_2065640(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__State2_206569C(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__Func_20656D4(SaveSpriteButton *work);
NOT_DECOMPILED void SaveSpriteButton__Func_20656E8(SaveSpriteButton *work);

#endif // RUSH_SAVE_SPRITE_BUTTON_H