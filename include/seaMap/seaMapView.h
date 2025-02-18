#ifndef RUSH_SEAMAPVIEW_H
#define RUSH_SEAMAPVIEW_H

#include <global.h>
#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/util/spriteButton.h>
#include <game/input/touchField.h>
#include <game/audio/audioSystem.h>
#include <seaMap/seaMapManager.h>

// --------------------
// ENUMS
// --------------------

enum SeaMapIsland
{
    SEAMAP_ISLAND_SOUTHERN_ISLAND,
    SEAMAP_ISLAND_PLANT_KINGDOM,
    SEAMAP_ISLAND_MACHINE_LABYRINTH,
    SEAMAP_ISLAND_CORAL_CAVE,
    SEAMAP_ISLAND_HAUNTED_SHIP,
    SEAMAP_ISLAND_BLIZZARD_PEAKS,
    SEAMAP_ISLAND_SKY_BABYLON,
    SEAMAP_ISLAND_PIRATES_ISLAND,
    SEAMAP_ISLAND_BIG_SWELL,
    SEAMAP_ISLAND_DEEP_CORE,
    SEAMAP_ISLAND_HIDDEN_ISLAND_1,
    SEAMAP_ISLAND_HIDDEN_ISLAND_2,
    SEAMAP_ISLAND_DAIKUN_ISLAND,
    SEAMAP_ISLAND_13,
    SEAMAP_ISLAND_KYLOK_ISLAND,
    SEAMAP_ISLAND_HIDDEN_ISLAND_3,
    SEAMAP_ISLAND_HIDDEN_ISLAND_4,
    SEAMAP_ISLAND_HIDDEN_ISLAND_5,
    SEAMAP_ISLAND_18,
    SEAMAP_ISLAND_19,
    SEAMAP_ISLAND_20,
    SEAMAP_ISLAND_21,
    SEAMAP_ISLAND_HIDDEN_ISLAND_6,
    SEAMAP_ISLAND_HIDDEN_ISLAND_7,
    SEAMAP_ISLAND_HIDDEN_ISLAND_8,
    SEAMAP_ISLAND_HIDDEN_ISLAND_9,
    SEAMAP_ISLAND_HIDDEN_ISLAND_10,
    SEAMAP_ISLAND_HIDDEN_ISLAND_11,
    SEAMAP_ISLAND_HIDDEN_ISLAND_12,
    SEAMAP_ISLAND_HIDDEN_ISLAND_13,
    SEAMAP_ISLAND_HIDDEN_ISLAND_14,
    SEAMAP_ISLAND_HIDDEN_ISLAND_15,
    SEAMAP_ISLAND_HIDDEN_ISLAND_16,
    SEAMAP_ISLAND_33,
    SEAMAP_ISLAND_34,
    SEAMAP_ISLAND_35,
    SEAMAP_ISLAND_36,
    SEAMAP_ISLAND_37,
    SEAMAP_ISLAND_38,
    SEAMAP_ISLAND_39,
    SEAMAP_ISLAND_40,
    SEAMAP_ISLAND_41,

    SEAMAP_ISLAND_COUNT,
};

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
    fx32 currentVoyageDist;
    GXRgb paletteColor1;
    GXRgb paletteColor2;
    s16 field_7A4;
    u8 field_7A6;
    u8 field_7A7;
    NNSSndHandle *sndHandle;
    s32 field_7AC;
    s32 field_7B0;
} SeaMapView;

// TEMP
// will be split into separate variables when seaMapView is properly decompiled!
typedef struct SeaMapViewStaticVars_
{
    Task *singleton;
    u32 mode;
    u32 unknown1;
    u32 unknown2;
} SeaMapViewStaticVars;

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED fx32 SeaMapCourseChangeView_02134174;

extern SeaMapViewStaticVars SeaMapView__sVars;
extern u32 seaMapViewMode;
extern u32 seaMapViewUnknown1;
extern fx32 seaMapViewUnknown2;

// --------------------
// FUNCTIONS
// --------------------

u32 SeaMapView__GetMode(void);
s32 SeaMapView__Func_203DCB4(void);
BOOL SeaMapView__IsActive(void);
void SeaMapView__Func_203DCE0(s32 x, s32 y);
TouchArea *SeaMapView__GetTouchArea(void);
BOOL SeaMapView__Func_203DD44(void);
void SeaMapView__InitZoomControl(SeaMapViewZoomControl *work, BOOL useEngineB);
BOOL SeaMapView__CanZoomIn(SeaMapViewZoomControl *work);
BOOL SeaMapView__HandleZoomIn(SeaMapViewZoomControl *work);
BOOL SeaMapView__CanZoomOut(SeaMapViewZoomControl *work);
BOOL SeaMapView__HandleZoomOut(SeaMapViewZoomControl *work);
SeaMapView *SeaMapView__GetWork(void);
void SeaMapView__InitView(SeaMapView *work, BOOL useEngineB, ShipType shipType, BOOL allocateSprites);
void SeaMapView__ReleaseAssets(SeaMapView *work);
void SeaMapView__Func_203E898(SeaMapView *work);
void SeaMapView__Func_203E8A8(SeaMapView *work);
void SeaMapView__Func_203E914(SeaMapView *work);
void SeaMapView__GetCursorSpriteSize(void *spriteFile);
void SeaMapView__InitTouchCursor(SeaMapView *work, s32 mode);
void SeaMapView__AllocateSprites(SeaMapView *work);
void SeaMapView__ReleaseSprites(SeaMapView *work);
u32 SeaMapView__Func_203ECA0(SeaMapView *work, s32 id);
u32 SeaMapView__Func_203ECF4(SeaMapView *work, s32 id);
BOOL SeaMapView__IsButtonActive(SeaMapView *work, s32 id);
BOOL SeaMapView__IsTouchAreaActive(SeaMapView *work, s32 id);
void SeaMapView__EnableTouchArea(SeaMapView *work, s32 id, BOOL enabled);
void SeaMapView__EnableButton(SeaMapView *work, s32 id, BOOL enabled);
void SeaMapView__EnableMultipleButtons(SeaMapView *work, const u32 *states);
void SeaMapView__SetButtonMode(SeaMapView *work, s32 mode);
void SeaMapView__ProcessButtons(SeaMapView *work);
void SeaMapView__SetZoomLevel(SeaMapView *work, s32 level);
void SeaMapView__ProcessPadInputs(SeaMapView *work);
void SeaMapView__Func_203F344(SeaMapView *work);
void SeaMapView__Func_203F35C(SeaMapView *work, BOOL flag);
void SeaMapView__SetTouchAreaCallback(SeaMapView *work, TouchAreaCallback callback);
void SeaMapView__TouchAreaCallback2(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
void SeaMapView__TouchAreaCallback(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
void SeaMapView__OnButtonPressed(TouchAreaResponse *response, TouchArea *touchArea, void *userData, u32 id);
void SeaMapView__ButtonCallback1(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
void SeaMapView__ButtonCallback2(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
void SeaMapView__ButtonCallback3(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
void SeaMapView__ButtonCallback4(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
void SeaMapView__ButtonCallback5(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
void SeaMapView__ButtonCallback6(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
void SeaMapView__ButtonCallback7(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
void SeaMapView__ButtonCallback8(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
void SeaMapView__DrawPenMarker(SeaMapView *work);
void SeaMapView__DrawButtons(SeaMapView *work);
void SeaMapView__DrawTouchCursor(SeaMapView *work);
void SeaMapView__DrawPadCursors(SeaMapView *work);
void SeaMapView__Func_203F770(SeaMapView *work);
BOOL SeaMapView__FadeToBlack(SeaMapView *work);
BOOL SeaMapView__FadeActiveScreen(SeaMapView *work);
BOOL SeaMapView__FadeOtherScreen(SeaMapView *work);
void SeaMapView__Func_203F8D4(void);
void SeaMapView__Func_203F91C(void);
void SeaMapView__Func_203F9A4(void);
void SeaMapView__Func_203FA24(void);
void SeaMapView__Func_203FAD4(void);
void SeaMapView__Func_203FB10(void);
void SeaMapView__Func_203FB78(void);
void SeaMapView__Func_203FBE8(void);
s32 SeaMapView__Func_203FC7C(SeaMapView *work, u16 a2, u16 a3);
void SeaMapView__Func_203FE44(SeaMapView *work);
void SeaMapView__Func_203FE80(SeaMapView *work);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void PlayChartSfx(enum SND_SYS_SEQARC_ARC_CHART sfxID)
{
    PlaySfxEx(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQARC_ARC_CHART, sfxID);
}

RUSH_INLINE void PlayHandleChartSfx(NNSSndHandle *handle, enum SND_SYS_SEQARC_ARC_CHART sfxID)
{
    PlaySfxEx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQARC_ARC_CHART, sfxID);
}

#endif // RUSH_SEAMAPVIEW_H