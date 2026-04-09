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
    SEAMAPVIEW_TYPE_CHART_COURSE_NAVIGATION,
    SEAMAPVIEW_TYPE_CHART_COURSE_DRAWING,
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

enum SeaMapViewButton_
{
    // Non-localized buttons (no text)
    SEAMAPVIEW_BUTTON_BACK,
    SEAMAPVIEW_BUTTON_ZOOM_IN,
    SEAMAPVIEW_BUTTON_ZOOM_OUT,
    SEAMAPVIEW_BUTTON_CONFIRM_PATH,
    SEAMAPVIEW_BUTTON_CANCEL_PATH,

    // Localized buttons (text)
    SEAMAPVIEW_BUTTON_LAND,
    SEAMAPVIEW_BUTTON_CANCEL,
    SEAMAPVIEW_BUTTON_RETURN_VILLAGE,

    SEAMAPVIEW_BUTTON_COUNT,
    SEAMAPVIEW_BUTTON_NON_LOC_COUNT = SEAMAPVIEW_BUTTON_LAND,
    SEAMAPVIEW_BUTTON_LOC_COUNT = SEAMAPVIEW_BUTTON_COUNT - SEAMAPVIEW_BUTTON_NON_LOC_COUNT,

    SEAMAPVIEW_BUTTON_NONE = -1,
};
typedef s32 SeaMapViewButton;

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
    BOOL isPlayingDrawMoveSfx;
    u16 drawMoveSfxTimer;
} SeaMapView;

// --------------------
// VARIABLES
// --------------------

extern fx32 SeaMapCourseChangeMenu_02134174;

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
BOOL IsSeaMapViewButtonActive(SeaMapView *work, SeaMapViewButton id);
BOOL IsSeaMapViewTouchAreaActive(SeaMapView *work, SeaMapViewButton id);
void SeaMapView_EnableTouchArea(SeaMapView *work, SeaMapViewButton id, BOOL enabled);
void SeaMapView_EnableButton(SeaMapView *work, SeaMapViewButton id, BOOL enabled);
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

RUSH_INLINE void StopChartSfx(NNSSndHandle *handle)
{
    NNS_SndPlayerStopSeq(handle, 0);
}

#endif // RUSH_SEAMAPVIEW_H