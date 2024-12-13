#ifndef RUSH2_SEAMAPVIEW_H
#define RUSH2_SEAMAPVIEW_H

#include <global.h>
#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/util/spriteButton.h>
#include <game/input/touchField.h>
#include <seaMap/seaMapManager.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapViewZoomControl
{
    BOOL useEngineB;
    u16 mode;
} SeaMapViewZoomControl;

typedef struct SeaMapView_
{
    BOOL allocateSprites;
    BOOL useEngineB;
    s16 targetBrightness;
    s16 field_A;
    SeaMapManagerAssets *assets;
    Vec2Fx32 position;
    Vec2Fx32 moveDist2;
    Vec2Fx32 lastMoveDist;
    Vec2Fx32 moveDist1;
    void *vramPixels[5];
    SpriteButtonAnimator buttonAnimators[8];
    AnimatorSprite aniPenMarker;
    AnimatorSprite aniTouchCursor;
    AnimatorSprite aniPadCursor[2];
    AnimatorSprite aniTextBorder;
    TouchArea touchArea;
    s32 selectedButton;
    u16 nodeCount;
    s32 totalVoyageDist;
    s32 currentVoyageDist;
    GXRgb paletteColor1;
    GXRgb paletteColor2;
    s16 field_7A4;
    u8 field_7A6;
    u8 field_7A7;
    NNSSndHandle *sndHandle;
    s32 field_7AC;
    s32 field_7B0;
} SeaMapView;

typedef struct SeaMapViewStaticVars_
{
    Task *singleton;
    u32 mode;
    u32 field_8;
    u32 field_C;
} SeaMapViewStaticVars;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED u32 SeaMapView__GetMode(void);
NOT_DECOMPILED s32 SeaMapView__Func_203DCB4(void);
NOT_DECOMPILED BOOL SeaMapView__IsActive(void);
NOT_DECOMPILED void SeaMapView__Func_203DCE0(s32 x, s32 y);
NOT_DECOMPILED TouchArea *SeaMapView__GetTouchArea(void);
NOT_DECOMPILED BOOL SeaMapView__Func_203DD44(void);
NOT_DECOMPILED void SeaMapView__InitZoomControl(SeaMapViewZoomControl *work, BOOL useEngineB);
NOT_DECOMPILED BOOL SeaMapView__CanZoomIn(SeaMapViewZoomControl *work);
NOT_DECOMPILED BOOL SeaMapView__HandleZoomIn(SeaMapViewZoomControl *work);
NOT_DECOMPILED BOOL SeaMapView__CanZoomOut(SeaMapViewZoomControl *work);
NOT_DECOMPILED BOOL SeaMapView__HandleZoomOut(SeaMapViewZoomControl *work);
NOT_DECOMPILED SeaMapView *SeaMapView__GetWork(void);
NOT_DECOMPILED void SeaMapView__InitView(SeaMapView *work, BOOL useEngineB, ShipType shipType, BOOL allocateSprites);
NOT_DECOMPILED void SeaMapView__ReleaseAssets(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__Func_203E898(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__Func_203E8A8(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__Func_203E914(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__GetCursorSpriteSize(void *spriteFile);
NOT_DECOMPILED void SeaMapView__InitTouchCursor(SeaMapView *work, s32 mode);
NOT_DECOMPILED void SeaMapView__AllocateSprites(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__ReleaseSprites(SeaMapView *work);
NOT_DECOMPILED u32 SeaMapView__Func_203ECA0(SeaMapView *work, s32 id);
NOT_DECOMPILED u32 SeaMapView__Func_203ECF4(SeaMapView *work, s32 id);
NOT_DECOMPILED BOOL SeaMapView__IsButtonActive(SeaMapView *work, s32 id);
NOT_DECOMPILED BOOL SeaMapView__IsTouchAreaActive(SeaMapView *work, s32 id);
NOT_DECOMPILED void SeaMapView__EnableTouchArea(SeaMapView *work, s32 id, BOOL enabled);
NOT_DECOMPILED void SeaMapView__EnableButton(SeaMapView *work, s32 id, BOOL enabled);
NOT_DECOMPILED void SeaMapView__EnableMultipleButtons(SeaMapView *work, u32 *states);
NOT_DECOMPILED void SeaMapView__SetButtonMode(SeaMapView *work, s32 mode);
NOT_DECOMPILED void SeaMapView__ProcessButtons(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__SetZoomLevel(SeaMapView *work, s32 level);
NOT_DECOMPILED void SeaMapView__ProcessPadInputs(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__Func_203F344(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__Func_203F35C(SeaMapView *work, BOOL flag);
NOT_DECOMPILED void SeaMapView__SetTouchAreaCallback(SeaMapView *work, TouchAreaCallback callback);
NOT_DECOMPILED void SeaMapView__TouchAreaCallback2(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
NOT_DECOMPILED void SeaMapView__TouchAreaCallback(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
NOT_DECOMPILED void SeaMapView__OnButtonPressed(TouchAreaResponse *response, TouchArea *touchArea, void *userData, u32 id);
NOT_DECOMPILED void SeaMapView__ButtonCallback1(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
NOT_DECOMPILED void SeaMapView__ButtonCallback2(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
NOT_DECOMPILED void SeaMapView__ButtonCallback3(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
NOT_DECOMPILED void SeaMapView__ButtonCallback4(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
NOT_DECOMPILED void SeaMapView__ButtonCallback5(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
NOT_DECOMPILED void SeaMapView__ButtonCallback6(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
NOT_DECOMPILED void SeaMapView__ButtonCallback7(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
NOT_DECOMPILED void SeaMapView__ButtonCallback8(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
NOT_DECOMPILED void SeaMapView__DrawPenMarker(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__DrawButtons(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__DrawTouchCursor(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__DrawPadCursors(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__Func_203F770(SeaMapView *work);
NOT_DECOMPILED BOOL SeaMapView__FadeToBlack(SeaMapView *work);
NOT_DECOMPILED BOOL SeaMapView__FadeActiveScreen(SeaMapView *work);
NOT_DECOMPILED BOOL SeaMapView__FadeOtherScreen(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__Func_203F8D4(void);
NOT_DECOMPILED void SeaMapView__Func_203F91C(void);
NOT_DECOMPILED void SeaMapView__Func_203F9A4(void);
NOT_DECOMPILED void SeaMapView__Func_203FA24(void);
NOT_DECOMPILED void SeaMapView__Func_203FAD4(void);
NOT_DECOMPILED void SeaMapView__Func_203FB10(void);
NOT_DECOMPILED void SeaMapView__Func_203FB78(void);
NOT_DECOMPILED void SeaMapView__Func_203FBE8(void);
NOT_DECOMPILED s32 SeaMapView__Func_203FC7C(SeaMapView *work, u16 a2, u16 a3);
NOT_DECOMPILED void SeaMapView__Func_203FE44(SeaMapView *work);
NOT_DECOMPILED void SeaMapView__Func_203FE80(SeaMapView *work);

#endif // RUSH2_SEAMAPVIEW_H