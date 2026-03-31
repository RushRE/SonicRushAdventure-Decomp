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

enum SeaMapViewType_
{
    SEAMAPVIEW_TYPE_NONE,
    SEAMAPVIEW_TYPE_MENU,
    SEAMAPVIEW_TYPE_CUTSCENE,
    SEAMAPVIEW_TYPE_3,
    SEAMAPVIEW_TYPE_4,
    SEAMAPVIEW_TYPE_SAILING,
};
typedef u32 SeaMapViewType;

enum SeaMapViewExitEvent_
{
    SEAMAPVIEW_EXIT_NONE,
    SEAMAPVIEW_EXIT_CONFIRM,
    SEAMAPVIEW_EXIT_BACK,
};
typedef u32 SeaMapViewExitEvent;

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
    u16 zoomState;
} SeaMapViewZoomControl;

typedef struct SeaMapView_
{
    BOOL allocateSprites;
    BOOL useEngineB;
    s16 targetBrightness;
    SeaMapManagerAssets *assets;
    Vec2Fx32 position;
    Vec2Fx32 globalMoveDist;
    Vec2Fx32 lastMoveDist;
    Vec2Fx32 areaLocalMoveDist;
    VRAMPixelKey vramPixels[5];
    SpriteButtonAnimator buttonAnimators[8];
    AnimatorSprite aniPenMarker;
    AnimatorSprite aniTouchCursor;
    AnimatorSprite aniPadCursor[2];
    AnimatorSprite aniTextBorder;
    TouchArea touchArea;
    s32 selectedButton;
    u16 nodeCount;
    s32 totalVoyageDist;
    fx32 remainingVoyageDist;
    GXRgb paletteColor1;
    GXRgb paletteColor2;
    s16 indicatorFlashTimer;
    NNSSndHandle *sndHandle;
    s32 unknown1;
    s32 unknown2;
} SeaMapView;

// --------------------
// VARIABLES
// --------------------

extern fx32 SeaMapCourseChangeView_02134174;

extern Task* gSeaMapTaskSingleton;
extern SeaMapViewType gSeaMapViewType;
extern SeaMapViewExitEvent gSeaMapViewExitEvent;
extern fx32 gSeaMapViewStoredVoyageDist;

// --------------------
// FUNCTIONS
// --------------------

SeaMapViewType GetSeaMapViewType(void);
SeaMapViewExitEvent GetSeaMapViewExitEvent(void);
BOOL IsSeaMapViewActive(void);
void SetSeaMapViewPosition(s32 x, s32 y);
TouchArea *GetSeaMapViewTouchArea(void);
BOOL IsSeaMapViewVoyageInProgress(void);
void InitSeaMapViewZoomControl(SeaMapViewZoomControl *work, BOOL useEngineB);
BOOL SeaMapView_HandleZoomIn_Intro(SeaMapViewZoomControl *work);
BOOL SeaMapView_HandleZoomIn_Outro(SeaMapViewZoomControl *work);
BOOL SeaMapView_HandleZoomOut_Intro(SeaMapViewZoomControl *work);
BOOL SeaMapView_HandleZoomOut_Outro(SeaMapViewZoomControl *work);
void SeaMapView_ResetIndicatorFlashTimer(SeaMapView *work);
void SeaMapView_ProcessIndicatorFlashTimer(SeaMapView *work);
void SeaMapView_SetVoyagePathColors(SeaMapView *work);
SeaMapView *GetSeaMapViewWork(void);
void SeaMapView_InitTouchCursor(SeaMapView *work, s32 id);
void InitSeaMapView(SeaMapView *work, BOOL useEngineB, ShipType shipType, BOOL allocateSprites);
void ReleaseSeaMapView(SeaMapView *work);
BOOL IsSeaMapViewButtonActive(SeaMapView *work, s32 id);
BOOL IsSeaMapViewTouchAreaActive(SeaMapView *work, s32 id);
void SeaMapView_EnableTouchArea(SeaMapView *work, s32 id, BOOL enabled);
void SeaMapView_EnableButton(SeaMapView *work, s32 id, BOOL enabled);
void SeaMapView_EnableMultipleButtons(SeaMapView *work, const u32 *states);
void SeaMapView_SetZoomLevelForZoomButtons(SeaMapView *work, SeaMapZoomLevel zoomLevel);
void SeaMapView_ProcessButtonInputs(SeaMapView *work);
void SeaMapView_SetZoomLevel(SeaMapView *work, SeaMapZoomLevel level);
void SeaMapView_ProcessMapInputs(SeaMapView *work);
void SeaMapView_ClearLocalMoveInputs(SeaMapView *work);
void SeaMapView_SetTouchAreaPriority(SeaMapView *work, BOOL highPriority);
void SeaMapView_SetTouchAreaCallback(SeaMapView *work, TouchAreaCallback callback);
void SeaMapView_TouchAreaCallback_Inactive(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
void SeaMapView_TouchAreaCallback_Active(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
void SeaMapView_DrawPenMarker(SeaMapView *work);
void SeaMapView_DrawButtons(SeaMapView *work);
void SeaMapView_DrawTouchCursor(SeaMapView *work);
void SeaMapView_DrawIndicators(SeaMapView *work);
void SeaMapView_ReadPosition(SeaMapView *work);
BOOL SeaMapView_FadeActiveScreen_ToDefault(SeaMapView *work);
BOOL SeaMapView_FadeActiveScreen_ToTarget(SeaMapView *work);
BOOL SeaMapView_FadeOtherScreen_ToTarget(SeaMapView *work);
void SeaMapView_DrawFinalizedVoyagePath(void);
void SeaMapView_DrawWIPVoyagePath(void);
s32 SeaMapView_TryAddVoyagePathNode(SeaMapView *work, u16 x, u16 y);
void SeaMapView_ClearVoyagePath(SeaMapView *work);
void SeaMapView_CalculateVoyagePath(SeaMapView *work);

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