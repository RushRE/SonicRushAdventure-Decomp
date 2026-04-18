#include <seaMap/seaMapChartCourseView.h>
#include <seaMap/navTails.h>
#include <seaMap/seaMapCollision.h>
#include <seaMap/seaMapEventTrigger.h>
#include <seaMap/seaMapBrightnessModifier.h>
#include <seaMap/objects/seaMapIslandIcon.h>
#include <game/graphics/renderCore.h>

// --------------------
// ENUMS
// --------------------

enum SeaMapChartCourseViewBubblePrompt_
{
    SEAMAPCHARTCOURSEVIEW_BUBBLE_CONTINUE,
    SEAMAPCHARTCOURSEVIEW_BUBBLE_OK,

    SEAMAPCHARTCOURSEVIEW_BUBBLE_COUNT,

    SEAMAPCHARTCOURSEVIEW_BUBBLE_NONE = SEAMAPCHARTCOURSEVIEW_BUBBLE_COUNT,
};
typedef s32 SeaMapChartCourseViewBubblePrompt;

enum SeaMapChartCourseViewPathAnimator_
{
    SEAMAPCHARTCOURSEVIEW_PATHANIM_INKJAR,
    SEAMAPCHARTCOURSEVIEW_PATHANIM_GAUGE_BG,
    SEAMAPCHARTCOURSEVIEW_PATHANIM_GAUGE_ENDS,
    SEAMAPCHARTCOURSEVIEW_PATHANIM_GAUGE_INK,
    SEAMAPCHARTCOURSEVIEW_PATHANIM_GAUGE_INK_REMAIN,

    SEAMAPCHARTCOURSEVIEW_PATHANIM_COUNT,
};

enum SeaMapChartCourseViewTouchMode_
{
    SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE,
    SEAMAPCHARTCOURSEVIEW_TOUCHMODE_NAVIGATE_ONLY,

    SEAMAPCHARTCOURSEVIEW_TOUCHMODE_COUNT,
};
typedef s32 SeaMapChartCourseViewTouchMode;

// --------------------
// STRUCTS
// --------------------

struct SeaMapChartCourseViewNavTailsTalk_
{
    u16 navTailsSequence;
    SeaMapChartCourseViewBubblePrompt promptType;
};

typedef struct SeaMapChartCourseViewBubblePromptConfig_
{
    u8 animID[OS_LANGUAGE_CODE_MAX];
    u8 _padding[2];
    u8 paletteRow[3];
} SeaMapChartCourseViewBubblePromptConfig;

typedef struct SeaMapChartCourseViewPathAnimatorConfig_
{
    u8 animID;
    u8 spriteOrder;
} SeaMapChartCourseViewPathAnimatorConfig;

// --------------------
// VARIABLES
// --------------------

static const u16 sNavTailsHint_CourseTrainingInitial[2] = { NAVTAILS_MSGSEQ_TUTORIAL_LETS_DRAW_A_COURSE, NAVTAILS_MSGSEQ_TUTORIAL_TOUCH_AND_DRAG_TO_DRAW };

static const u16 sNavTailsHint_NavigationTraining[3] = { NAVTAILS_MSGSEQ_TUTORIAL_CAN_SCROLL_WITH_DPAD_TOO, NAVTAILS_MSGSEQ_TUTORIAL_MAP_OF_THE_WORLD,
                                                         NAVTAILS_MSGSEQ_TUTORIAL_CENTER_IS_SOUTHERN_ISLAND };

static const u16 sNavTailsHint_CourseTrainingDrawing[3] = { NAVTAILS_MSGSEQ_TUTORIAL_WHEN_DRAWN_ROUTE_PRESS_TO_END, NAVTAILS_MSGSEQ_TUTORIAL_LETS_DRAW_A_COURSE,
                                                            NAVTAILS_MSGSEQ_TUTORIAL_YOU_CAN_DRAW_UNTIL_GAUGE_RUNS_OUT };

static const SeaMapChartCourseViewNavTailsTalk sNavTailsDialog_FinishNavigationTraining[1] = {
    {
        .navTailsSequence = NAVTAILS_MSGSEQ_TUTORIAL_YOU_GOT_HANG_OF_SCROLLING,
        .promptType       = SEAMAPCHARTCOURSEVIEW_BUBBLE_OK,
    },
};

static const SeaMapChartCourseViewNavTailsTalk sNavTailsDialog_FinishCourseTraining[1] = {
    {
        .navTailsSequence = NAVTAILS_MSGSEQ_TUTORIAL_GOOD_JOB,
        .promptType       = SEAMAPCHARTCOURSEVIEW_BUBBLE_OK,
    },
};

static const SeaMapChartCourseViewNavTailsTalk sNavTailsDialog_IntroduceTraining[1] = {
    {
        .navTailsSequence = NAVTAILS_MSGSEQ_TUTORIAL_MAP_OF_THE_WORLD,
        .promptType       = SEAMAPCHARTCOURSEVIEW_BUBBLE_OK,
    },
};

static const SeaMapChartCourseViewNavTailsTalk sNavTailsDialog_FinishAllTraining[1] = {
    {
        .navTailsSequence = NAVTAILS_MSGSEQ_TUTORIAL_YOU_GOT_HANG_OF_DRAWING,
        .promptType       = SEAMAPCHARTCOURSEVIEW_BUBBLE_NONE,
    },
};

static const SeaMapChartCourseViewNavTailsTalk sNavTailsDialog_ExplainGaugeLimit[1] = {
    {
        .navTailsSequence = NAVTAILS_MSGSEQ_TUTORIAL_YOU_CAN_DRAW_UNTIL_GAUGE_RUNS_OUT,
        .promptType       = SEAMAPCHARTCOURSEVIEW_BUBBLE_OK,
    },
};

static const SeaMapChartCourseViewNavTailsTalk sNavTailsDialog_ExplainDestination[1] = {
    {
        .navTailsSequence = NAVTAILS_MSGSEQ_TUTORIAL_HEAD_FOR_MARKED_ISLAND,
        .promptType       = SEAMAPCHARTCOURSEVIEW_BUBBLE_OK,
    },
};

static const SeaMapChartCourseViewPathAnimatorConfig sPathAnimatorConfigList[SEAMAPCHARTCOURSEVIEW_PATHANIM_COUNT] = { 
    [SEAMAPCHARTCOURSEVIEW_PATHANIM_INKJAR] = 
    {
        .animID      = SEAMAP_CHCOM_ANI_25,
        .spriteOrder = SPRITE_ORDER_3,
    },

    [SEAMAPCHARTCOURSEVIEW_PATHANIM_GAUGE_BG] = 
    {
        .animID      = SEAMAP_CHCOM_ANI_26,
        .spriteOrder = SPRITE_ORDER_3,
    },

    [SEAMAPCHARTCOURSEVIEW_PATHANIM_GAUGE_ENDS] = 
    {
        .animID      = SEAMAP_CHCOM_ANI_27,
        .spriteOrder = SPRITE_ORDER_3,
    },

    [SEAMAPCHARTCOURSEVIEW_PATHANIM_GAUGE_INK] = 
    {
        .animID      = SEAMAP_CHCOM_ANI_28,
        .spriteOrder = SPRITE_ORDER_2,
    },

    [SEAMAPCHARTCOURSEVIEW_PATHANIM_GAUGE_INK_REMAIN] = 
    {
        .animID      = SEAMAP_CHCOM_ANI_28,
        .spriteOrder = SPRITE_ORDER_2,
    } 
};

static const SeaMapChartCourseViewNavTailsTalk sNavTailsDialog_ExplainNavigationTraining[2] = {
    {
        .navTailsSequence = NAVTAILS_MSGSEQ_TUTORIAL_CENTER_IS_SOUTHERN_ISLAND,
        .promptType       = SEAMAPCHARTCOURSEVIEW_BUBBLE_CONTINUE,
    },
    {
        .navTailsSequence = NAVTAILS_MSGSEQ_TUTORIAL_SCROLL_MAP_BY_SLIDING,
        .promptType       = SEAMAPCHARTCOURSEVIEW_BUBBLE_OK,
    },
};

static const SeaMapChartCourseViewNavTailsTalk sNavTailsDialog_ExplainCourseChartTraining[2] = {
    {
        .navTailsSequence = NAVTAILS_MSGSEQ_TUTORIAL_LETS_DRAW_A_COURSE,
        .promptType       = SEAMAPCHARTCOURSEVIEW_BUBBLE_CONTINUE,
    },
    {
        .navTailsSequence = NAVTAILS_MSGSEQ_TUTORIAL_TOUCH_AND_DRAG_TO_DRAW,
        .promptType       = SEAMAPCHARTCOURSEVIEW_BUBBLE_OK,
    },

};

static const SeaMapChartCourseViewBubblePromptConfig sBubblePromptButtonConfigList[SEAMAPCHARTCOURSEVIEW_BUBBLE_COUNT] = {
    [SEAMAPCHARTCOURSEVIEW_BUBBLE_CONTINUE] =
    {
        .animID     = { [OS_LANGUAGE_JAPANESE] = SEAMAP_CHCOM_ANI_103, [OS_LANGUAGE_ENGLISH] = SEAMAP_CHCOM_ANI_107, [OS_LANGUAGE_FRENCH] = SEAMAP_CHCOM_ANI_111,
                        [OS_LANGUAGE_GERMAN] = SEAMAP_CHCOM_ANI_115,   [OS_LANGUAGE_ITALIAN] = SEAMAP_CHCOM_ANI_119, [OS_LANGUAGE_SPANISH] = SEAMAP_CHCOM_ANI_123 },
        .paletteRow = { PALETTE_ROW_15, PALETTE_ROW_15, PALETTE_ROW_15 },
    },

    [SEAMAPCHARTCOURSEVIEW_BUBBLE_OK] =
    {
        .animID     = { [OS_LANGUAGE_JAPANESE] = SEAMAP_CHCOM_ANI_101, [OS_LANGUAGE_ENGLISH] = SEAMAP_CHCOM_ANI_105, [OS_LANGUAGE_FRENCH] = SEAMAP_CHCOM_ANI_109,
                        [OS_LANGUAGE_GERMAN] = SEAMAP_CHCOM_ANI_113,   [OS_LANGUAGE_ITALIAN] = SEAMAP_CHCOM_ANI_117, [OS_LANGUAGE_SPANISH] = SEAMAP_CHCOM_ANI_121 },
        .paletteRow = { PALETTE_ROW_15, PALETTE_ROW_15, PALETTE_ROW_15 },
    },
};

static const BOOL sSeaMapViewButtonState_Selected[SEAMAPVIEW_BUTTON_COUNT] = {
    [SEAMAPVIEW_BUTTON_BACK] = FALSE,        [SEAMAPVIEW_BUTTON_ZOOM_IN] = FALSE, [SEAMAPVIEW_BUTTON_ZOOM_OUT] = FALSE, [SEAMAPVIEW_BUTTON_CONFIRM_PATH] = FALSE,
    [SEAMAPVIEW_BUTTON_CANCEL_PATH] = FALSE, [SEAMAPVIEW_BUTTON_LAND] = FALSE,    [SEAMAPVIEW_BUTTON_CANCEL] = TRUE,    [SEAMAPVIEW_BUTTON_RETURN_VILLAGE] = TRUE
};

static const BOOL sSeaMapViewButtonState_None[SEAMAPVIEW_BUTTON_COUNT] = {
    [SEAMAPVIEW_BUTTON_BACK] = FALSE,        [SEAMAPVIEW_BUTTON_ZOOM_IN] = FALSE, [SEAMAPVIEW_BUTTON_ZOOM_OUT] = FALSE, [SEAMAPVIEW_BUTTON_CONFIRM_PATH] = FALSE,
    [SEAMAPVIEW_BUTTON_CANCEL_PATH] = FALSE, [SEAMAPVIEW_BUTTON_LAND] = FALSE,    [SEAMAPVIEW_BUTTON_CANCEL] = FALSE,   [SEAMAPVIEW_BUTTON_RETURN_VILLAGE] = FALSE
};

static const BOOL sSeaMapViewButtonState_Navigate[SEAMAPVIEW_BUTTON_COUNT] = {
    [SEAMAPVIEW_BUTTON_BACK] = TRUE,         [SEAMAPVIEW_BUTTON_ZOOM_IN] = TRUE, [SEAMAPVIEW_BUTTON_ZOOM_OUT] = TRUE, [SEAMAPVIEW_BUTTON_CONFIRM_PATH] = FALSE,
    [SEAMAPVIEW_BUTTON_CANCEL_PATH] = FALSE, [SEAMAPVIEW_BUTTON_LAND] = FALSE,   [SEAMAPVIEW_BUTTON_CANCEL] = FALSE,  [SEAMAPVIEW_BUTTON_RETURN_VILLAGE] = FALSE
};

static const BOOL sSeaMapViewButtonState_ConfirmPath[SEAMAPVIEW_BUTTON_COUNT] = {
    [SEAMAPVIEW_BUTTON_BACK] = FALSE,       [SEAMAPVIEW_BUTTON_ZOOM_IN] = TRUE, [SEAMAPVIEW_BUTTON_ZOOM_OUT] = TRUE, [SEAMAPVIEW_BUTTON_CONFIRM_PATH] = TRUE,
    [SEAMAPVIEW_BUTTON_CANCEL_PATH] = TRUE, [SEAMAPVIEW_BUTTON_LAND] = FALSE,   [SEAMAPVIEW_BUTTON_CANCEL] = FALSE,  [SEAMAPVIEW_BUTTON_RETURN_VILLAGE] = FALSE
};

// --------------------
// FUNCTION DECLS
// --------------------

// Common Utilities
static void SeaMapChartCourseView_TouchAreaCallback_DrawActive(TouchAreaResponse *response, TouchArea *area, void *userData);
static void SeaMapChartCourseView_InitInkGaugeSprites(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_ReleaseInkGaugeSprites(SeaMapChartCourseView *work);
static BOOL SeaMapChartCourseView_HandleButtons_Navigation(SeaMapChartCourseView *work);
static BOOL SeaMapChartCourseView_HandleStartDrawingButton(SeaMapChartCourseView *work);
static BOOL SeaMapChartCourseView_HandleButtons_DrawPath(SeaMapChartCourseView *work);
static BOOL SeaMapChartCourseView_HandleButtons_CancelVoyage(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_SetTouchMode(SeaMapChartCourseView *work, SeaMapChartCourseViewTouchMode mode);
static BOOL SeaMapChartCourseView_AddVoyagePathNode(SeaMapChartCourseView *work, u8 x, u8 y);
static void SeaMapChartCourseView_ClearVoyagePath(SeaMapChartCourseView *work);
static SeaMapChartCourseViewTouchMode SeaMapChartCourseView_DetermineTouchMode(SeaMapChartCourseView *work, u8 centerX, u8 centerY);
static BOOL SeaMapChartCourseView_CheckTouchPosIsInvalidLocation(SeaMapChartCourseView *work);

// Task Core
static void SeaMapChartCourseView_Main(void);
static void SeaMapChartCourseView_Destructor(Task *task);

// Drawing
static void SeaMapChartCourseView_Draw_Main(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_Draw_Training(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_DrawInkGauge(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_GetInkGaugeSegmentDrawPos(u16 id, u16 *x, u16 *y);

// Zoom In States
static void SeaMapChartCourseView_Action_ZoomIn(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_ZoomIn(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartZoomIn(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_ApplyZoomIn(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_EndZoomIn(SeaMapChartCourseView *work);

// Zoom Out States
static void SeaMapChartCourseView_Action_ZoomOut(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_ZoomOut(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartZoomOut(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_ApplyZoomOut(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_EndZoomOut(SeaMapChartCourseView *work);

// Chart Course States
static void SeaMapChartCourseView_State_FadeIn(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartChartCourse(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_WaitForStartDrawing(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartDrawingPath(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_DrawingPath(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_ConfirmDrawnPath(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_ConfirmDrawnPathResponse(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_ConfirmCancelVoyage(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_ConfirmCancelVoyageResponse(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_FinishedDrawingPath(SeaMapChartCourseView *work);

// Training Helpers
static void SeaMapChartCourseView_EventCallback_Training(SeaMapEventTriggerType type, void *work, void *eventData, void *param);
static BOOL SeaMapChartCourseView_HandleTrainingHintMessages(SeaMapChartCourseView *work, const u16 *sequenceList, u16 sequenceCount);
static size_t SeaMapChartCourseView_GetBubblePromptSpriteSize(SeaMapChartCourseView *work, SeaMapChartCourseViewBubblePrompt id);
static void SeaMapChartCourseView_TouchAreaCallback_BubblePrompt(TouchAreaResponse *response, TouchArea *touchArea, void *userData);
static void SeaMapChartCourseView_InitBubblePrompt(SeaMapChartCourseView *work, s32 id);
static void SeaMapChartCourseView_ReleaseBubblePrompt(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_CreateTrainingStylusPrompt(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_DestroyTrainingStylusPrompt(SeaMapChartCourseView *work);

// NavTails Logic & States
static void SeaMapChartCourseView_StartNavTailsExplain(SeaMapChartCourseView *work, const SeaMapChartCourseViewNavTailsTalk *seqList, s16 seqCount,
                                                       void (*nextState)(SeaMapChartCourseView *work), BOOL dimScreen);
static void SeaMapChartCourseView_State_StartNavTailsExplain(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_NavTailsExplainWaitForScreenDim(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartNavTailsExplainWaitForConfirm(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_NavTailsExplainWaitForConfirm(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_NavTailsExplainWaitForScreenUndim(SeaMapChartCourseView *work);

// Training States
static void SeaMapChartCourseView_State_InitTraining(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingFadeIn(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartTrainingPrepare(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingPrepare(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartTrainingIntroText(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartTrainingZoomInDelay(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingZoomInDelay(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartTrainingZoomIn_Intro(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingZoomIn_Intro(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartTrainingZoomIn_Outro(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingZoomIn_Outro(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartNavigationTrainingText(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartNavigationTraining(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_NavigationTraining(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_FinishNavigationTrainingText(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TryTrainingLookAtIslands(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartTrainingLookAtIslands(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingLookAtIslands(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartTrainingZoomInToLookAtIslands_Intro(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingZoomInToLookAtIslands_Intro(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartTrainingZoomInToLookAtIslands_Outro(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingZoomInToLookAtIslands_Outro(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartCourseTrainingText(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartCourseTraining(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_ShowCourseTrainingStylusPrompt(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingWaitForStartDrawing(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingStartDrawingPath(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingDrawingPath(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingConfirmDrawnPath(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingConfirmDrawnPathResponse(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartTrainingScreenDim(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingScreenDim(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_StartFinishAllTrainingText(SeaMapChartCourseView *work);
static void SeaMapChartCourseView_State_TrainingFadeOut(SeaMapChartCourseView *work);

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapChartCourseView(BOOL useEngineB, ShipType shipType, SeaMapChartCourseViewType type)
{
    s32 prevBrightness;

    gSeaMapViewType      = SEAMAPVIEW_TYPE_CHART_COURSE_NAVIGATION;
    gSeaMapViewExitEvent = SEAMAPVIEW_EXIT_NONE;

    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];
    prevBrightness                   = gfxControl->brightness;
    SeaMapManager__Create(useEngineB, shipType, FALSE);
    gfxControl->brightness = prevBrightness;

    SeaMapManager__LoadMapBackground();

    Task *task =
        TaskCreate(SeaMapChartCourseView_Main, SeaMapChartCourseView_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0xFF, TASK_GROUP(0), SeaMapChartCourseView);
    gSeaMapTaskSingleton = task;

    SeaMapChartCourseView *work = TaskGetWork(task, SeaMapChartCourseView);
    TaskInitWork16(work);

    if (type != SEAMAPCHARTCOURSEVIEW_TYPE_CHANGE_COURSE)
    {
        gSeaMapViewStoredVoyageDist     = FLOAT_TO_FX32(0.0);
        SeaMapCourseChangeMenu_02134174 = FLOAT_TO_FX32(0.0);
        gameState.sailUnknown3          = FLOAT_TO_FX32(0.0);
    }

    InitSeaMapView(&work->view, useEngineB, shipType, TRUE);

    if (type == SEAMAPCHARTCOURSEVIEW_TYPE_TRAINING)
    {
        TouchField__Init(&work->training.navTailsBubblePromptField);
        work->state     = SeaMapChartCourseView_State_InitTraining;
        work->stateDraw = SeaMapChartCourseView_Draw_Training;
    }
    else
    {
        work->state     = SeaMapChartCourseView_State_FadeIn;
        work->stateDraw = SeaMapChartCourseView_Draw_Main;
    }

    work->type = type;
    SeaMapChartCourseView_InitInkGaugeSprites(work);
    SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_Navigate);

    if (type == SEAMAPCHARTCOURSEVIEW_TYPE_CHANGE_COURSE)
    {
        SeaMapView_EnableTouchArea(&work->view, SEAMAPVIEW_BUTTON_CONFIRM_PATH, FALSE);
    }
    else if (type == SEAMAPCHARTCOURSEVIEW_TYPE_TRAINING)
    {
        SeaMapView_EnableTouchArea(&work->view, SEAMAPVIEW_BUTTON_BACK, FALSE);
    }

    if (type == SEAMAPCHARTCOURSEVIEW_TYPE_TRAINING)
        SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_FARTHEST);
    else
        SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_NEAREST);

    CreateSeaMapEventManager();

    if (type == SEAMAPCHARTCOURSEVIEW_TYPE_CHART_COURSE || (s32)type == SEAMAPCHARTCOURSEVIEW_TYPE_CHANGE_COURSE)
        CreateSeaMapEventManagerDSPopup();
}

void DestroySeaMapChartCourseView(void)
{
    if (gSeaMapTaskSingleton != NULL)
    {
        DestroyTask(gSeaMapTaskSingleton);
        gSeaMapTaskSingleton = NULL;

        DestroySeaMapEventManager();
        SeaMapManager__Destroy();
        DestroyNavTails();
    }
}

BOOL IsSeaMapChartCourseViewFinished(void)
{
    if (gSeaMapTaskSingleton == NULL)
        return FALSE;

    SeaMapChartCourseView *work = TaskGetWork(gSeaMapTaskSingleton, SeaMapChartCourseView);
    return work->isFinished == FALSE;
}

void SeaMapChartCourseView_TouchAreaCallback_DrawActive(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
    SeaMapChartCourseView *work = (SeaMapChartCourseView *)userData;

    TouchAreaResponseFlags areaFlags = touchArea->responseFlags;

    switch (response->flags)
    {
        case TOUCHAREA_RESPONSE_ENTERED_AREA_ALT:
            if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
            {
                if (SeaMapChartCourseView_AddVoyagePathNode(work, touchInput.on.x, touchInput.on.y))
                    SeaMapView_DrawWIPVoyagePath();

                SeaMapView_InitTouchCursor(&work->view, -1);
            }
            break;

        case TOUCHAREA_RESPONSE_ENTERED_AREA_3:
            if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
            {
                if (work->view.drawMoveSfxTimer != 0)
                {
                    work->view.drawMoveSfxTimer--;
                    if (work->view.drawMoveSfxTimer == 0)
                    {
                        StopChartSfx(work->view.sndHandle);
                        work->view.isPlayingDrawMoveSfx = FALSE;
                    }
                }
            }
            break;

        case TOUCHAREA_RESPONSE_EXITED_AREA_ALT:
            if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
            {
                SeaMapView_CalculateVoyagePath(&work->view);
                SeaMapView_DrawFinalizedVoyagePath();

                StopChartSfx(work->view.sndHandle);
                work->view.isPlayingDrawMoveSfx = FALSE;
            }
            break;

        case TOUCHAREA_RESPONSE_MOVED_IN_AREA_ALT:
            if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
            {
                if (SeaMapChartCourseView_AddVoyagePathNode(work, touchInput.on.x, touchInput.on.y))
                    SeaMapView_DrawWIPVoyagePath();

                SeaMapView_InitTouchCursor(&work->view, -1);

                if (work->view.remainingVoyageDist > FLOAT_TO_FX32(3.0))
                {
                    if (response->move.x != 0 || response->move.y != 0)
                    {
                        if (work->view.isPlayingDrawMoveSfx == FALSE)
                        {
                            PlayHandleChartSfx(work->view.sndHandle, SND_SYS_SEQARC_ARC_CHART_SEQ_SE_C_ROOT);
                            work->view.isPlayingDrawMoveSfx = TRUE;
                        }
                        work->view.drawMoveSfxTimer = 8;
                    }
                }
            }
            break;
    }
}

void SeaMapChartCourseView_InitInkGaugeSprites(SeaMapChartCourseView *work)
{
    u32 i;
    AnimatorSprite *animator;
    const SeaMapChartCourseViewPathAnimatorConfig *config;

    for (i = 0; i < SEAMAPCHARTCOURSEVIEW_PATHANIM_COUNT; i++)
    {
        animator = &work->pathAnimators.array[i];
        config   = &sPathAnimatorConfigList[i];

        AnimatorSprite__Init(animator, work->view.assets->sprChCommon, config->animID, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, work->view.useEngineB, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(work->view.useEngineB, Sprite__GetSpriteSize1FromAnim(work->view.assets->sprChCommon, config->animID)),
                             PALETTE_MODE_SPRITE, VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[work->view.useEngineB]), SPRITE_PRIORITY_0, config->spriteOrder);
        animator->cParam.palette = PALETTE_ROW_4;
        AnimatorSprite__ProcessAnimationFast(animator);
        animator->flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    }
}

void SeaMapChartCourseView_ReleaseInkGaugeSprites(SeaMapChartCourseView *work)
{
    for (u32 i = 0; i < SEAMAPCHARTCOURSEVIEW_PATHANIM_COUNT; i++)
    {
        AnimatorSprite__Release(&work->pathAnimators.array[i]);
    }
}

BOOL SeaMapChartCourseView_HandleButtons_Navigation(SeaMapChartCourseView *work)
{
    BOOL madeSelection = TRUE;
    switch (work->view.selectedButton)
    {
        case SEAMAPVIEW_BUTTON_BACK:
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_V_CANCELL);
            gSeaMapViewExitEvent = SEAMAPVIEW_EXIT_BACK;
            if (work->type == SEAMAPCHARTCOURSEVIEW_TYPE_TRAINING)
                work->state = SeaMapChartCourseView_State_TrainingFadeOut;
            else
                work->state = SeaMapChartCourseView_State_FinishedDrawingPath;
            break;

        case SEAMAPVIEW_BUTTON_ZOOM_IN:
            SeaMapChartCourseView_Action_ZoomIn(work);
            break;

        case SEAMAPVIEW_BUTTON_ZOOM_OUT:
            SeaMapChartCourseView_Action_ZoomOut(work);
            break;

        default:
            madeSelection = FALSE;
            break;
    }

    work->view.selectedButton = SEAMAPVIEW_BUTTON_NONE;

    return madeSelection;
}

BOOL SeaMapChartCourseView_HandleStartDrawingButton(SeaMapChartCourseView *work)
{
    SeaMapManager *manager = SeaMapManager__GetWork();
    UNUSED(manager);

    SeaMapEventManager *eventManager = GetSeaMapEventManagerWork2();

    BOOL madeSelection = TRUE;
    switch (eventManager->lastTouchedIconType)
    {
        case SEAMAPOBJECT_ISLAND_DRAW_ICON: {
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_CURSOL);

            work->lastTouchedIcon = eventManager->lastTouchedIcon;

            SeaMapEventManager_ClearLastTouchedIcon();

            fx16 y;
            fx16 x;
            SeaMapManager__Func_2043B28(FX32_FROM_WHOLE(work->lastTouchedIcon->objWork.position.x), FX32_FROM_WHOLE(work->lastTouchedIcon->objWork.position.y), &x, &y);
            SeaMapManager__AddNode(x, y);

            if (work->type == SEAMAPCHARTCOURSEVIEW_TYPE_TRAINING)
                work->state = SeaMapChartCourseView_State_TrainingStartDrawingPath;
            else
                work->state = SeaMapChartCourseView_State_StartDrawingPath;
        }
        break;

        default:
            madeSelection = FALSE;
            break;
    }

    return madeSelection;
}

BOOL SeaMapChartCourseView_HandleButtons_DrawPath(SeaMapChartCourseView *work)
{
    BOOL madeSelection = TRUE;
    switch (work->view.selectedButton)
    {
        case SEAMAPVIEW_BUTTON_CANCEL_PATH:
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_V_CANCELL);
            if (work->type == SEAMAPCHARTCOURSEVIEW_TYPE_CHANGE_COURSE)
            {
                if (SeaMapManager__GetNodeCount() > 1)
                {
                    SeaMapChartCourseView_ClearVoyagePath(work);
                }
                else
                {
                    work->state = SeaMapChartCourseView_State_ConfirmCancelVoyage;
                }
            }
            else
            {
                SeaMapChartCourseView_ClearVoyagePath(work);
            }
            break;

        case SEAMAPVIEW_BUTTON_CONFIRM_PATH:
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_PAUSE);
            SeaMapChartCourseView_DestroyTrainingStylusPrompt(work);
            if (work->type == SEAMAPCHARTCOURSEVIEW_TYPE_TRAINING)
                work->state = SeaMapChartCourseView_State_TrainingConfirmDrawnPath;
            else
                work->state = SeaMapChartCourseView_State_ConfirmDrawnPath;
            break;

        case SEAMAPVIEW_BUTTON_ZOOM_IN:
            SeaMapChartCourseView_Action_ZoomIn(work);
            SeaMapView_DrawFinalizedVoyagePath();
            break;

        case SEAMAPVIEW_BUTTON_ZOOM_OUT:
            SeaMapChartCourseView_Action_ZoomOut(work);
            SeaMapView_DrawFinalizedVoyagePath();
            break;

        default:
            madeSelection = FALSE;
            break;
    }

    work->view.selectedButton = SEAMAPVIEW_BUTTON_NONE;

    return madeSelection;
}

BOOL SeaMapChartCourseView_HandleButtons_CancelVoyage(SeaMapChartCourseView *work)
{
    BOOL madeSelection = TRUE;
    switch (work->view.selectedButton)
    {
        case SEAMAPVIEW_BUTTON_CANCEL:
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_V_CANCELL);
            if (work->touchMode == SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE || (s32)work->touchMode == SEAMAPCHARTCOURSEVIEW_TOUCHMODE_NAVIGATE_ONLY)
                work->state = SeaMapChartCourseView_State_StartDrawingPath;
            break;

        case SEAMAPVIEW_BUTTON_RETURN_VILLAGE:
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_PAUSE);
            gSeaMapViewExitEvent = SEAMAPVIEW_EXIT_BACK;
            work->state          = SeaMapChartCourseView_State_FinishedDrawingPath;
            break;

        default:
            madeSelection = FALSE;
            break;
    }

    work->view.selectedButton = SEAMAPVIEW_BUTTON_NONE;

    return madeSelection;
}

void SeaMapChartCourseView_SetTouchMode(SeaMapChartCourseView *work, SeaMapChartCourseViewTouchMode mode)
{
    switch (mode)
    {
        case SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE:
            SeaMapView_SetTouchAreaCallback(&work->view, SeaMapChartCourseView_TouchAreaCallback_DrawActive);
            break;

        case SEAMAPCHARTCOURSEVIEW_TOUCHMODE_NAVIGATE_ONLY:
            SeaMapView_SetTouchAreaCallback(&work->view, SeaMapView_TouchAreaCallback_Active);
            break;
    }

    work->touchMode = mode;
}

BOOL SeaMapChartCourseView_AddVoyagePathNode(SeaMapChartCourseView *work, u8 x, u8 y)
{
    u16 outY;
    u16 outX;

    SeaMapManager__Func_2043A9C(x, y, &outX, &outY);

    switch (SeaMapView_TryAddVoyagePathNode(&work->view, outX, outY))
    {
        case -2:
        case -1:
        case 0:
            return TRUE;

        default:
            return FALSE;
    }
}

void SeaMapChartCourseView_ClearVoyagePath(SeaMapChartCourseView *work)
{
    if (work->type == SEAMAPCHARTCOURSEVIEW_TYPE_CHANGE_COURSE)
    {
        SeaMapManagerNode *startNode = SeaMapManager__GetStartNode();
        u16 x                        = startNode->position.x;
        u16 y                        = startNode->position.y;

        SeaMapView_ClearVoyagePath(&work->view);
        SeaMapManager__AddNode(x, y);
        SeaMapView_DrawFinalizedVoyagePath();
        SeaMapView_EnableTouchArea(&work->view, SEAMAPVIEW_BUTTON_CONFIRM_PATH, FALSE);
    }
    else
    {
        SeaMapEventManager_ClearDrawIconButtonState(work->lastTouchedIcon);
        work->lastTouchedIcon = NULL;
        SeaMapEventManager_ClearLastTouchedIcon();
        SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_Navigate);

        SeaMapView_ClearVoyagePath(&work->view);
        SeaMapView_DrawFinalizedVoyagePath();

        SeaMapView_SetTouchAreaCallback(&work->view, SeaMapView_TouchAreaCallback_Active);

        if (work->type == SEAMAPCHARTCOURSEVIEW_TYPE_TRAINING)
        {
            work->training.trainingReachedIntendedIsland = FALSE;
            work->state                                  = SeaMapChartCourseView_State_ShowCourseTrainingStylusPrompt;
        }
        else
        {
            work->state = SeaMapChartCourseView_State_StartChartCourse;
        }
    }
}

SeaMapChartCourseViewTouchMode SeaMapChartCourseView_DetermineTouchMode(SeaMapChartCourseView *work, u8 centerX, u8 centerY)
{
    fx16 screenX;
    fx16 screenY;
    u16 lastX;
    u16 lastY;
    fx32 distanceX;
    fx32 distanceY;

    if (IsSeaMapViewVoyageInProgress())
        return SEAMAPCHARTCOURSEVIEW_TOUCHMODE_NAVIGATE_ONLY;

    if (SeaMapManager__GetNodeCount() == 0)
        return SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE;

    SeaMapManager__GetLastNodePosition(&lastX, &lastY);

    SeaMapManager__Func_2043AD4(lastX, lastY, &screenX, &screenY);

    if (screenX < 0 || screenX >= HW_LCD_WIDTH || screenY < 0 || screenY >= HW_LCD_HEIGHT)
        return SEAMAPCHARTCOURSEVIEW_TOUCHMODE_NAVIGATE_ONLY;

    distanceY = FX32_FROM_WHOLE(screenY - centerY);
    distanceX = FX32_FROM_WHOLE(screenX - centerX);

    distanceX = MATH_ABS(distanceX);
    distanceY = MATH_ABS(distanceY);

    fx32 distance;
    if (distanceX > distanceY)
        distance = MultiplyFX(distanceX, FLOAT_TO_FX32(0.96045)) + MultiplyFX(distanceY, FLOAT_TO_FX32(0.3978));
    else
        distance = MultiplyFX(distanceY, FLOAT_TO_FX32(0.96045)) + MultiplyFX(distanceX, FLOAT_TO_FX32(0.3978));

    if (distance > FLOAT_TO_FX32(8.0))
        return SEAMAPCHARTCOURSEVIEW_TOUCHMODE_NAVIGATE_ONLY;

    return SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE;
}

BOOL SeaMapChartCourseView_CheckTouchPosIsInvalidLocation(SeaMapChartCourseView *work)
{
    fx16 mapY;
    fx16 mapX;
    u16 x;
    u16 y;

    SeaMapManager__Func_2043B7C(touchInput.on.x, touchInput.on.y, &x, &y);

    if (SeaMapCollision__Collide(x, y, TRUE))
    {
        SeaMapManagerNode *endNode = SeaMapManager__GetEndNode();
        SeaMapManager__Func_2043AD4(endNode->position.x, endNode->position.y, &mapX, &mapY);

        fx32 distanceX;
        fx32 distanceY;
        distanceY = FX32_FROM_WHOLE(touchInput.on.y - mapY);
        distanceX = FX32_FROM_WHOLE(touchInput.on.x - mapX);

        distanceX = MATH_ABS(distanceX);
        distanceY = MATH_ABS(distanceY);

        fx32 distance;
        if (distanceX > distanceY)
            distance = MultiplyFX(distanceX, FLOAT_TO_FX32(0.96045)) + MultiplyFX(distanceY, FLOAT_TO_FX32(0.3978));
        else
            distance = MultiplyFX(distanceY, FLOAT_TO_FX32(0.96045)) + MultiplyFX(distanceX, FLOAT_TO_FX32(0.3978));

        if (distance > FLOAT_TO_FX32(8.0))
            return TRUE;
    }

    return FALSE;
}

void SeaMapChartCourseView_Main(void)
{
    SeaMapChartCourseView *work = TaskGetWorkCurrent(SeaMapChartCourseView);

    work->state(work);

    if (work->isFinished == FALSE)
        work->stateDraw(work);
}

void SeaMapChartCourseView_Destructor(Task *task)
{
    SeaMapChartCourseView *work = TaskGetWork(task, SeaMapChartCourseView);

    SeaMapChartCourseView_ReleaseInkGaugeSprites(work);

    if (work->type == SEAMAPCHARTCOURSEVIEW_TYPE_TRAINING)
    {
        if (work->training.eventListener)
            SeaMapEventTrigger_RemoveEventListener(work->training.eventListener);
    }

    ReleaseSeaMapView(&work->view);

    gSeaMapViewType      = SEAMAPVIEW_TYPE_NONE;
    gSeaMapTaskSingleton = NULL;
}

void SeaMapChartCourseView_Draw_Main(SeaMapChartCourseView *work)
{
    SeaMapChartCourseView_DrawInkGauge(work);
    SeaMapView_ProcessIndicatorFlashTimer(&work->view);

    if (work->canDrawNavIndicators)
        SeaMapView_DrawIndicators(&work->view);

    SeaMapView_ReadPosition(&work->view);
    SeaMapView_DrawButtons(&work->view);
    SeaMapView_DrawTouchCursor(&work->view);
    SeaMapView_DrawPenMarker(&work->view);

    if (!work->disableVoyagePathColorUpdate)
        SeaMapView_SetVoyagePathColors(&work->view);
}

void SeaMapChartCourseView_Draw_Training(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    SeaMapChartCourseView_DrawInkGauge(work);

    if (SeaMapManager__GetWork()->touchFieldActive)
    {
        SeaMapView_ProcessIndicatorFlashTimer(&work->view);
        if (work->canDrawNavIndicators)
            SeaMapView_DrawIndicators(&work->view);
    }

    SeaMapView_ReadPosition(&work->view);
    SeaMapView_DrawButtons(&work->view);
    SeaMapView_DrawTouchCursor(&work->view);
    SeaMapView_DrawPenMarker(&work->view);

    if (!work->disableVoyagePathColorUpdate)
        SeaMapView_SetVoyagePathColors(&work->view);

    if (training->navTailsPlayedPopupSfx)
    {
        AnimatorSprite__ProcessAnimationFast(&training->bubblePopupButton.animator);
        AnimatorSprite__DrawFrame(&training->bubblePopupButton.animator);
    }
}

void SeaMapChartCourseView_DrawInkGauge(SeaMapChartCourseView *work)
{
    AnimatorSprite *animator1 = &work->pathAnimators.aniInkJar;
    animator1->pos.x          = 14;
    animator1->pos.y          = 15;
    AnimatorSprite__DrawFrame(animator1);

    u16 totalDistSegments = FX_DivS32(FX32_TO_WHOLE(work->view.totalVoyageDist), 8);
    u16 i;
    AnimatorSprite *animator2 = &work->pathAnimators.aniGaugeBG;
    for (i = 0; i < totalDistSegments; i++)
    {
        SeaMapChartCourseView_GetInkGaugeSegmentDrawPos(i, &animator2->pos.x, &animator2->pos.y);
        AnimatorSprite__DrawFrame(animator2);
    }

    AnimatorSprite *animator0 = &work->pathAnimators.aniGaugeBGEnds;
    SeaMapChartCourseView_GetInkGaugeSegmentDrawPos(totalDistSegments, &animator0->pos.x, &animator0->pos.y);
    AnimatorSprite__DrawFrame(animator0);

    CP_SetDiv32_32(FX32_TO_WHOLE(work->view.remainingVoyageDist), 8);
    u16 remainDistSegments         = CP_GetDivResult32();
    u16 remainDistSegmentsLeftover = FX_DivS32((CP_GetDivRemainder32() & 0xFFFF) << 3, 8);

    AnimatorSprite *animator3 = &work->pathAnimators.aniGaugeInk;
    for (i = 0; i < remainDistSegments; i++)
    {
        SeaMapChartCourseView_GetInkGaugeSegmentDrawPos(i, &animator3->pos.x, &animator3->pos.y);
        AnimatorSprite__DrawFrame(animator3);
    }

    if (remainDistSegmentsLeftover > 0)
    {
        AnimatorSprite *animator4 = &work->pathAnimators.aniGaugeInkRemain;
        AnimatorSprite__SetAnimation(animator4, SEAMAP_CHCOM_ANI_36 - remainDistSegmentsLeftover);
        AnimatorSprite__ProcessAnimationFast(animator4);
        SeaMapChartCourseView_GetInkGaugeSegmentDrawPos(remainDistSegments, &animator4->pos.x, &animator4->pos.y);
        AnimatorSprite__DrawFrame(animator4);
    }
}

void SeaMapChartCourseView_GetInkGaugeSegmentDrawPos(u16 id, u16 *x, u16 *y)
{
    *x = 28 + 8 * id;
    *y = 8;
}

void SeaMapChartCourseView_Action_ZoomIn(SeaMapChartCourseView *work)
{
    work->prevState = work->state;
    work->state     = SeaMapChartCourseView_State_ZoomIn;
}

void SeaMapChartCourseView_State_ZoomIn(SeaMapChartCourseView *work)
{
    InitSeaMapViewZoomControl(&work->zoomControl, work->view.useEngineB);
    SeaMapManager__EnableTouchField(FALSE);

    PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_ZOOMIN);

    work->state = SeaMapChartCourseView_State_StartZoomIn;
    work->state(work);
}

void SeaMapChartCourseView_State_StartZoomIn(SeaMapChartCourseView *work)
{
    if (SeaMapView_HandleZoomIn_Intro(&work->zoomControl))
        work->state = SeaMapChartCourseView_State_ApplyZoomIn;
}

void SeaMapChartCourseView_State_ApplyZoomIn(SeaMapChartCourseView *work)
{
    switch (SeaMapManager__GetZoomLevel())
    {
        case SEAMAP_ZOOM_MIDDLE:
            SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_NEAREST);
            break;

        case SEAMAP_ZOOM_FARTHEST:
            SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_MIDDLE);
            break;
    }

    SeaMapView_ProcessMapInputs(&work->view);
    SeaMapView_DrawFinalizedVoyagePath();
    InitSeaMapViewZoomControl(&work->zoomControl, work->view.useEngineB);

    work->state = SeaMapChartCourseView_State_EndZoomIn;
    work->state(work);
}

void SeaMapChartCourseView_State_EndZoomIn(SeaMapChartCourseView *work)
{
    if (SeaMapView_HandleZoomIn_Outro(&work->zoomControl))
    {
        work->state = work->prevState;
        SeaMapManager__EnableTouchField(TRUE);
    }
}

void SeaMapChartCourseView_Action_ZoomOut(SeaMapChartCourseView *work)
{
    work->prevState = work->state;
    work->state     = SeaMapChartCourseView_State_ZoomOut;
}

void SeaMapChartCourseView_State_ZoomOut(SeaMapChartCourseView *work)
{
    InitSeaMapViewZoomControl(&work->zoomControl, work->view.useEngineB);
    SeaMapManager__EnableTouchField(FALSE);

    PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_ZOOMOUT);

    work->state = SeaMapChartCourseView_State_StartZoomOut;
    work->state(work);
}

void SeaMapChartCourseView_State_StartZoomOut(SeaMapChartCourseView *work)
{
    if (SeaMapView_HandleZoomOut_Intro(&work->zoomControl))
        work->state = SeaMapChartCourseView_State_ApplyZoomOut;
}

void SeaMapChartCourseView_State_ApplyZoomOut(SeaMapChartCourseView *work)
{
    switch (SeaMapManager__GetZoomLevel())
    {
        case SEAMAP_ZOOM_NEAREST:
            SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_MIDDLE);
            break;

        case SEAMAP_ZOOM_MIDDLE:
            SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_FARTHEST);
            break;
    }

    SeaMapView_ProcessMapInputs(&work->view);
    SeaMapView_DrawFinalizedVoyagePath();
    InitSeaMapViewZoomControl(&work->zoomControl, work->view.useEngineB);

    work->state = SeaMapChartCourseView_State_EndZoomOut;
    work->state(work);
}

void SeaMapChartCourseView_State_EndZoomOut(SeaMapChartCourseView *work)
{
    if (SeaMapView_HandleZoomOut_Outro(&work->zoomControl))
    {
        work->state = work->prevState;
        SeaMapManager__EnableTouchField(TRUE);
    }
}

void SeaMapChartCourseView_State_FadeIn(SeaMapChartCourseView *work)
{
    if (SeaMapView_FadeActiveScreen_ToDefault(&work->view))
    {
        if (work->type == SEAMAPCHARTCOURSEVIEW_TYPE_CHANGE_COURSE)
            work->state = SeaMapChartCourseView_State_StartDrawingPath;
        else
            work->state = SeaMapChartCourseView_State_StartChartCourse;
    }
}

void SeaMapChartCourseView_State_StartChartCourse(SeaMapChartCourseView *work)
{
    gSeaMapViewType = SEAMAPVIEW_TYPE_CHART_COURSE_NAVIGATION;

    SeaMapView_ResetIndicatorFlashTimer(&work->view);
    SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_Navigate);

    SeaMapView_SetZoomLevelForZoomButtons(&work->view, SeaMapManager__GetZoomLevel());

    NavTailsSpeak(NAVTAILS_MSGSEQ_WHATS_OUR_NEXT_DESTINATION, SECONDS_TO_FRAMES(10));
    work->canDrawNavIndicators = TRUE;

    work->state = SeaMapChartCourseView_State_WaitForStartDrawing;
    work->state(work);
}

void SeaMapChartCourseView_State_WaitForStartDrawing(SeaMapChartCourseView *work)
{
    SeaMapView_ProcessMapInputs(&work->view);
    SeaMapView_ProcessButtonInputs(&work->view);

    if (GetSeaMapEventManagerWork2()->lastTouchedIconType != SEAMAPOBJECT_NONE)
    {
        if (SeaMapChartCourseView_HandleStartDrawingButton(work))
        {
            work->state(work);
        }
    }
    else
    {
        SeaMapChartCourseView_HandleButtons_Navigation(work);
    }
}

void SeaMapChartCourseView_State_StartDrawingPath(SeaMapChartCourseView *work)
{
    gSeaMapViewType = SEAMAPVIEW_TYPE_CHART_COURSE_DRAWING;

    SeaMapView_ResetIndicatorFlashTimer(&work->view);
    work->canDrawNavIndicators = TRUE;
    SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_ConfirmPath);
    SeaMapView_SetZoomLevelForZoomButtons(&work->view, SeaMapManager__GetZoomLevel());
    SeaMapChartCourseView_SetTouchMode(work, SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE);
    SeaMapView_SetTouchAreaPriority(&work->view, 0);

    work->state = SeaMapChartCourseView_State_DrawingPath;
    work->state(work);
}

void SeaMapChartCourseView_State_DrawingPath(SeaMapChartCourseView *work)
{
    SeaMapEventManager *eventManager = GetSeaMapEventManagerWork2();
    UNUSED(eventManager);

    SeaMapView_ProcessMapInputs(&work->view);

    if (IsTouchInputEnabled() && TouchInput__IsTouchPush(&touchInput))
    {
        SeaMapChartCourseView_SetTouchMode(work, SeaMapChartCourseView_DetermineTouchMode(work, touchInput.push.x, touchInput.push.y));

        if (work->touchMode != SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE)
            SeaMapView_ClearLocalMoveInputs(&work->view);
    }
    else if (IsTouchInputEnabled() && TouchInput__IsTouchPull(&touchInput))
    {
        SeaMapView_ResetIndicatorFlashTimer(&work->view);

        if (work->touchMode == SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE)
        {
            StopChartSfx(work->view.sndHandle);
            work->view.isPlayingDrawMoveSfx = FALSE;

            if (SeaMapManager__GetNodeCount() == 1)
            {
                SeaMapChartCourseView_ClearVoyagePath(work);
                return;
            }

            if (SeaMapManager__GetNodeCount() > 1)
            {
                if (SeaMapManager__GetTotalDistance() < FLOAT_TO_FX32(8.0))
                {
                    SeaMapChartCourseView_ClearVoyagePath(work);
                    return;
                }
                else
                {
                    if (work->type == SEAMAPCHARTCOURSEVIEW_TYPE_CHANGE_COURSE && IsSeaMapViewTouchAreaActive(&work->view, SEAMAPVIEW_BUTTON_CONFIRM_PATH) == FALSE)
                        SeaMapView_EnableTouchArea(&work->view, SEAMAPVIEW_BUTTON_CONFIRM_PATH, TRUE);
                }
            }
        }
    }
    else if (IsTouchInputEnabled() && TouchInput__IsTouchOn(&touchInput) && work->touchMode == SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE
             && SeaMapChartCourseView_CheckTouchPosIsInvalidLocation(work) && GetNavTailsActiveSpeakMsg() != NAVTAILS_MSGSEQ_WE_CANT_GO_THERE_IN_THIS_SHIP)
    {
        NavTailsSpeak(NAVTAILS_MSGSEQ_WE_CANT_GO_THERE_IN_THIS_SHIP, SECONDS_TO_FRAMES(10.0));
    }

    SeaMapView_ProcessButtonInputs(&work->view);
    SeaMapChartCourseView_HandleButtons_DrawPath(work);
}

void SeaMapChartCourseView_State_ConfirmDrawnPath(SeaMapChartCourseView *work)
{
    work->canDrawNavIndicators = FALSE;
    SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_None);

    SpriteButtonConfig config;
    InitSpriteButtonConfig(&config, work->view.useEngineB, SPRITE_BUTTON_ACTIVEBUTTON_YES_NO);
    config.vramPixels[0] = work->view.vramPixels[2];
    config.vramPixels[1] = work->view.vramPixels[3];
    config.paletteRow[0] = PALETTE_ROW_1;
    config.paletteRow[1] = PALETTE_ROW_2;
    config.paletteRow[2] = PALETTE_ROW_3;
    config.oamPriority   = SPRITE_PRIORITY_0;
    config.oamOrder      = SPRITE_ORDER_4;
    config.field_16      = 0x3540;
    CreateSpriteButton(&config);

    SeaMapManager__EnableTouchField(FALSE);
    NavTailsSpeak(NAVTAILS_MSGSEQ_IS_THIS_OKAY, 0);

    work->state = SeaMapChartCourseView_State_ConfirmDrawnPathResponse;
}

void SeaMapChartCourseView_State_ConfirmDrawnPathResponse(SeaMapChartCourseView *work)
{
    switch (GetSelectedSpriteButton())
    {
        case SPRITE_BUTTON_YES:
            DestroySpriteButton();
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_PAUSE);
            SeaMapManager__UpdateGlobalNodeList();

            gSeaMapViewExitEvent = SEAMAPVIEW_EXIT_CONFIRM;
            work->state          = SeaMapChartCourseView_State_FinishedDrawingPath;
            break;

        case SPRITE_BUTTON_NO:
            DestroySpriteButton();
            SeaMapManager__EnableTouchField(TRUE);
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_V_CANCELL);
            NavTailsSpeak(NAVTAILS_MSGSEQ_WHATS_OUR_NEXT_DESTINATION, SECONDS_TO_FRAMES(10.0));

            if (work->touchMode == SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE || (s32)work->touchMode == SEAMAPCHARTCOURSEVIEW_TOUCHMODE_NAVIGATE_ONLY)
                work->state = SeaMapChartCourseView_State_StartDrawingPath;
            break;
    }
}

void SeaMapChartCourseView_State_ConfirmCancelVoyage(SeaMapChartCourseView *work)
{
    work->canDrawNavIndicators = FALSE;

    SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_Selected);
    SeaMapView_SetTouchAreaCallback(&work->view, SeaMapView_TouchAreaCallback_Inactive);
    SeaMapView_SetTouchAreaPriority(&work->view, TRUE);

    NavTailsSpeak(NAVTAILS_MSGSEQ_IS_THIS_OKAY, 0);

    work->state = SeaMapChartCourseView_State_ConfirmCancelVoyageResponse;
}

void SeaMapChartCourseView_State_ConfirmCancelVoyageResponse(SeaMapChartCourseView *work)
{
    SeaMapChartCourseView_HandleButtons_CancelVoyage(work);
}

void SeaMapChartCourseView_State_FinishedDrawingPath(SeaMapChartCourseView *work)
{
    work->isFinished = TRUE;
}

void SeaMapChartCourseView_EventCallback_Training(SeaMapEventTriggerType type, void *workOpaque, void *eventData, void *param)
{
    SeaMapChartCourseView *work   = (SeaMapChartCourseView *)workOpaque;
    SeaMapLayoutObject *mapObject = (SeaMapLayoutObject *)eventData;

    if (type == SEAMAPEVENTTRIGGER_EVENT_ISLAND_ON_CHART_MAP)
    {
        switch (SeaMapEventManager_GetObjectType(mapObject))
        {
            case SEAMAPOBJECT_ISLAND_ICON_ELIPSE:
            case SEAMAPOBJECT_ISLAND_ICON_RECT:
                if ((mapObject->usrFlags & SEAMAPISLANDICON_FLAG_DISCOVERABLE_VIA_VOYAGE) == 0 && mapObject->id == SEAMAPMANAGER_DISCOVER_CORAL_CAVE)
                    work->training.trainingReachedIntendedIsland = TRUE;
                break;
        }
    }
}

BOOL SeaMapChartCourseView_HandleTrainingHintMessages(SeaMapChartCourseView *work, const u16 *sequenceList, u16 sequenceCount)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    if (training->navTailsHintAdvanceTimer++ >= SECONDS_TO_FRAMES(10.0))
    {
        u16 activeMsg = GetNavTailsActiveSpeakMsg();

        u16 i = 0;
        for (; i < sequenceCount; i++)
        {
            if (activeMsg == sequenceList[i])
            {
                i += 1;
                break;
            }
        }

        if (sequenceCount <= i)
            i = 0;

        NavTailsSpeak(sequenceList[i], 0);
        training->navTailsHintAdvanceTimer = 0;
        return TRUE;
    }

    return FALSE;
}

size_t SeaMapChartCourseView_GetBubblePromptSpriteSize(SeaMapChartCourseView *work, SeaMapChartCourseViewBubblePrompt id)
{
    const SeaMapChartCourseViewBubblePromptConfig *config = &sBubblePromptButtonConfigList[id];

    void *sprChCommon;
    size_t maxSize = 0;
    s32 i;

    sprChCommon = work->view.assets->sprChCommon;

    for (i = 0; i < 8; i++)
    {
        for (s32 a = 0; a < SEAMAPCHARTCOURSEVIEW_BUBBLE_COUNT; a++)
        {
            size_t spriteSize = Sprite__GetSpriteSize1FromAnim(sprChCommon, config->animID[i] + a);
            if (maxSize < spriteSize)
                maxSize = spriteSize;
        }
    }

    return maxSize;
}

void SeaMapChartCourseView_TouchAreaCallback_BubblePrompt(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
    SeaMapChartCourseView *work = (SeaMapChartCourseView *)userData;

    struct SeaMapChartCourseViewTraining *training = &work->training;
    TouchAreaResponseFlags areaFlags               = touchArea->responseFlags;

    switch (response->flags)
    {
        case TOUCHAREA_RESPONSE_ENTERED_AREA:
        case TOUCHAREA_RESPONSE_ENTERED_AREA_ALT:
            if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
            {
                SetSpriteButtonState(&training->bubblePopupButton, SPRITE_BUTTON_STATE_HOVERED);
            }
            break;

        case TOUCHAREA_RESPONSE_EXITED_AREA:
        case TOUCHAREA_RESPONSE_EXITED_AREA_ALT:
            if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
            {
                SetSpriteButtonState(&training->bubblePopupButton, SPRITE_BUTTON_STATE_IDLE);
            }
            break;

        case TOUCHAREA_RESPONSE_40000:
            training->navTailsConfirmedPopupBubble = TRUE;
            break;
    }
}

void SeaMapChartCourseView_InitBubblePrompt(SeaMapChartCourseView *work, SeaMapChartCourseViewBubblePrompt id)
{
    const SeaMapChartCourseViewBubblePromptConfig *config;
    struct SeaMapChartCourseViewTraining *training;
    SpriteButtonAnimator *button;
    GraphicsEngine graphicsEngine;

    training = &work->training;
    config   = &sBubblePromptButtonConfigList[id];

    button         = &training->bubblePopupButton;
    graphicsEngine = work->view.useEngineB;

    button->animID = config->animID[GetGameLanguage()];
    for (s32 i = 0; i < 3; i++)
    {
        button->paletteRow[i] = config->paletteRow[i];
    }

    AnimatorSprite *aniButton = &button->animator;
    AnimatorSprite__Init(aniButton, work->view.assets->sprChCommon, button->animID, ANIMATOR_FLAG_DISABLE_LOOPING, graphicsEngine, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(graphicsEngine, SeaMapChartCourseView_GetBubblePromptSpriteSize(work, id)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[graphicsEngine]), SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    aniButton->cParam.palette = button->paletteRow[0];
    aniButton->pos.x          = HW_LCD_CENTER_X;
    aniButton->pos.y          = HW_LCD_CENTER_X;

    HitboxRect rect;
    AnimatorSprite__GetBlockData(aniButton, 0, &rect);

    TouchArea *touchArea = &button->touchArea;
    TouchField__InitAreaShape(touchArea, &aniButton->pos, TouchField__PointInRect, (TouchRectUnknown *)&rect, SeaMapChartCourseView_TouchAreaCallback_BubblePrompt, work);
    TouchField__AddArea(&training->navTailsBubblePromptField, touchArea, 0x10);
    SetSpriteButtonState(button, SPRITE_BUTTON_STATE_IDLE);
}

void SeaMapChartCourseView_ReleaseBubblePrompt(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training;
    SpriteButtonAnimator *button;

    training = &work->training;
    button   = &training->bubblePopupButton;

    AnimatorSprite__Release(&button->animator);
    TouchField__RemoveArea(&training->navTailsBubblePromptField, &button->touchArea);

    MI_CpuClear16(button, sizeof(*button));
}

void SeaMapChartCourseView_CreateTrainingStylusPrompt(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    if (training->stylusIcon == NULL)
    {
        SeaMapLayoutObject *southernIsland = SeaMapEventManager_GetObjectFromID(SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND);
        SeaMapLayoutObject *plantKingdom   = SeaMapEventManager_GetObjectFromID(SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM);

        training->stylusIcon = (SeaMapStylusIcon *)CreateSeaMapEventManagerStylusIcon(FX32_FROM_WHOLE(southernIsland->position.x), FX32_FROM_WHOLE(southernIsland->position.y),
                                                                                      FX32_FROM_WHOLE(plantKingdom->position.x), FX32_FROM_WHOLE(plantKingdom->position.y), 22);
    }
}

void SeaMapChartCourseView_DestroyTrainingStylusPrompt(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    SeaMapStylusIcon *stylusIcon = training->stylusIcon;
    if (stylusIcon != NULL)
    {
        DestroySeaMapEventManagerStylusIcon(&stylusIcon->objWork);
        training->stylusIcon = NULL;
    }
}

void SeaMapChartCourseView_StartNavTailsExplain(SeaMapChartCourseView *work, const SeaMapChartCourseViewNavTailsTalk *seqList, s16 seqCount,
                                                void (*nextState)(SeaMapChartCourseView *work), BOOL dimScreen)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    training->navTailsSequenceList  = seqList;
    training->navTailsSequenceCount = seqCount;
    training->nextState             = nextState;
    training->navTailsSequenceID    = 0;
    training->navTailsDimScreenFlag = dimScreen;

    StopStageSfx(work->view.sndHandle);

    work->view.isPlayingDrawMoveSfx = FALSE;
    work->state                     = SeaMapChartCourseView_State_StartNavTailsExplain;
}

void SeaMapChartCourseView_State_StartNavTailsExplain(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    SeaMapView_ClearLocalMoveInputs(&work->view);
    SeaMapView_ProcessMapInputs(&work->view);

    if (training->navTailsDimScreenFlag)
    {
        training->brightnessModifierTask = CreateSeaMapBrightnessModifier(&work->view);
        SetSeaMapBrightnessModifierMode(training->brightnessModifierTask, SEAMAPBRIGHTNESSMODIFIER_MODE_DARKEN);
        work->disableVoyagePathColorUpdate = TRUE;
        work->state                        = SeaMapChartCourseView_State_NavTailsExplainWaitForScreenDim;
    }
    else
    {
        work->state = SeaMapChartCourseView_State_StartNavTailsExplainWaitForConfirm;
    }
}

void SeaMapChartCourseView_State_NavTailsExplainWaitForScreenDim(SeaMapChartCourseView *work)
{
    if (GetSeaMapBrightnessModifierMode(work->training.brightnessModifierTask) == SEAMAPBRIGHTNESSMODIFIER_MODE_IDLE
        && (IsTouchInputEnabled() == FALSE || TouchInput__IsTouchOn(&touchInput) == FALSE))
    {
        work->state = SeaMapChartCourseView_State_StartNavTailsExplainWaitForConfirm;
    }
}

void SeaMapChartCourseView_State_StartNavTailsExplainWaitForConfirm(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    const SeaMapChartCourseViewNavTailsTalk *speakSequence = &training->navTailsSequenceList[training->navTailsSequenceID];
    NavTailsSpeak(speakSequence->navTailsSequence, 0);

    if (speakSequence->promptType < SEAMAPCHARTCOURSEVIEW_BUBBLE_COUNT)
    {
        SeaMapChartCourseView_InitBubblePrompt(work, speakSequence->promptType);
        training->navTailsConfirmedPopupBubble = FALSE;
        training->navTailsPlayedPopupSfx       = FALSE;
    }
    else
    {
        training->navTailsAutoAdvanceTimer = 0;
    }

    work->state = SeaMapChartCourseView_State_NavTailsExplainWaitForConfirm;
    work->state(work);
}

void SeaMapChartCourseView_State_NavTailsExplainWaitForConfirm(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    const SeaMapChartCourseViewNavTailsTalk *speakSequence = &training->navTailsSequenceList[training->navTailsSequenceID];

    if (CheckNavTailsLastDialog())
    {
        BOOL advanceSequence = FALSE;

        if (speakSequence->promptType < SEAMAPCHARTCOURSEVIEW_BUBBLE_COUNT)
        {
            if (!training->navTailsPlayedPopupSfx)
            {
                PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_V_POPUP);
                training->navTailsPlayedPopupSfx = TRUE;
            }

            TouchField__Process(&training->navTailsBubblePromptField);

            if (training->navTailsConfirmedPopupBubble)
            {
                PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_PAUSE);
                SeaMapChartCourseView_ReleaseBubblePrompt(work);

                training->navTailsPlayedPopupSfx = FALSE;
                advanceSequence                  = TRUE;
            }
        }
        else
        {
            if (training->navTailsAutoAdvanceTimer++ > SECONDS_TO_FRAMES(5.0))
                advanceSequence = TRUE;
        }

        if (advanceSequence)
        {
            training->navTailsSequenceID++;
            if (training->navTailsSequenceID < training->navTailsSequenceCount)
            {
                work->state = SeaMapChartCourseView_State_StartNavTailsExplainWaitForConfirm;
            }
            else
            {
                if (training->navTailsDimScreenFlag)
                {
                    SetSeaMapBrightnessModifierMode(training->brightnessModifierTask, SEAMAPBRIGHTNESSMODIFIER_MODE_BRIGHTEN);
                    work->state = SeaMapChartCourseView_State_NavTailsExplainWaitForScreenUndim;
                }
                else
                {
                    work->state = training->nextState;
                    work->state(work);
                }
            }
        }
    }
}

void SeaMapChartCourseView_State_NavTailsExplainWaitForScreenUndim(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    if (GetSeaMapBrightnessModifierMode(training->brightnessModifierTask) == SEAMAPBRIGHTNESSMODIFIER_MODE_IDLE)
    {
        work->disableVoyagePathColorUpdate = FALSE;
        DestroySeaMapBrightnessModifier(training->brightnessModifierTask);
        training->brightnessModifierTask = NULL;

        work->state = training->nextState;
        work->state(work);
    }
}

void SeaMapChartCourseView_State_InitTraining(SeaMapChartCourseView *work)
{
    SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_Navigate);
    SeaMapView_SetZoomLevelForZoomButtons(&work->view, SeaMapManager__GetZoomLevel());
    SeaMapManager__EnableTouchField(FALSE);

    SeaMapLayoutObject *southernIsland = SeaMapEventManager_GetObjectFromID(SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND);
    SetSeaMapViewPosition(FX32_FROM_WHOLE(southernIsland->position.x), FX32_FROM_WHOLE(southernIsland->position.y));
    SeaMapView_ProcessMapInputs(&work->view);

    work->state = SeaMapChartCourseView_State_TrainingFadeIn;
    work->state(work);
}

void SeaMapChartCourseView_State_TrainingFadeIn(SeaMapChartCourseView *work)
{
    if (SeaMapView_FadeActiveScreen_ToDefault(&work->view))
        work->state = SeaMapChartCourseView_State_StartTrainingPrepare;
}

void SeaMapChartCourseView_State_StartTrainingPrepare(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    training->trainingTimer = 0;

    work->state = SeaMapChartCourseView_State_TrainingPrepare;
    work->state(work);
}

void SeaMapChartCourseView_State_TrainingPrepare(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    if (training->trainingTimer++ > SECONDS_TO_FRAMES(1.0))
        work->state = SeaMapChartCourseView_State_StartTrainingIntroText;
}

void SeaMapChartCourseView_State_StartTrainingIntroText(SeaMapChartCourseView *work)
{
    SeaMapChartCourseView_StartNavTailsExplain(work, sNavTailsDialog_IntroduceTraining, ARRAY_COUNT(sNavTailsDialog_IntroduceTraining), SeaMapChartCourseView_State_StartTrainingZoomInDelay,
                                               TRUE);
}

void SeaMapChartCourseView_State_StartTrainingZoomInDelay(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    training->trainingTimer = 0;

    work->state = SeaMapChartCourseView_State_TrainingZoomInDelay;
    work->state(work);
}

void SeaMapChartCourseView_State_TrainingZoomInDelay(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    if (training->trainingTimer++ > SECONDS_TO_FRAMES(0.5))
        work->state = SeaMapChartCourseView_State_StartTrainingZoomIn_Intro;
}

void SeaMapChartCourseView_State_StartTrainingZoomIn_Intro(SeaMapChartCourseView *work)
{
    InitSeaMapViewZoomControl(&work->zoomControl, work->view.useEngineB);

    PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_ZOOMIN);

    work->state = SeaMapChartCourseView_State_TrainingZoomIn_Intro;
    work->state(work);
}

void SeaMapChartCourseView_State_TrainingZoomIn_Intro(SeaMapChartCourseView *work)
{
    if (SeaMapView_HandleZoomIn_Intro(&work->zoomControl))
        work->state = SeaMapChartCourseView_State_StartTrainingZoomIn_Outro;
}

void SeaMapChartCourseView_State_StartTrainingZoomIn_Outro(SeaMapChartCourseView *work)
{
    switch (SeaMapManager__GetZoomLevel())
    {
        case SEAMAP_ZOOM_FARTHEST:
            SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_MIDDLE);
            break;

        case SEAMAP_ZOOM_MIDDLE:
            SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_NEAREST);
            break;
    }

    SeaMapLayoutObject *southernIsland = SeaMapEventManager_GetObjectFromID(SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND);
    SetSeaMapViewPosition(FX32_FROM_WHOLE(southernIsland->position.x), FX32_FROM_WHOLE(southernIsland->position.y));

    SeaMapView_ProcessMapInputs(&work->view);

    InitSeaMapViewZoomControl(&work->zoomControl, work->view.useEngineB);

    work->state = SeaMapChartCourseView_State_TrainingZoomIn_Outro;
    work->state(work);
}

void SeaMapChartCourseView_State_TrainingZoomIn_Outro(SeaMapChartCourseView *work)
{
    if (SeaMapView_HandleZoomIn_Outro(&work->zoomControl))
    {
        if (SeaMapManager__GetZoomLevel() != SEAMAP_ZOOM_NEAREST)
            work->state = SeaMapChartCourseView_State_StartTrainingZoomInDelay;
        else
            work->state = SeaMapChartCourseView_State_StartNavigationTrainingText;
    }
}

void SeaMapChartCourseView_State_StartNavigationTrainingText(SeaMapChartCourseView *work)
{
    SeaMapChartCourseView_StartNavTailsExplain(work, sNavTailsDialog_ExplainNavigationTraining, ARRAY_COUNT(sNavTailsDialog_ExplainNavigationTraining),
                                               SeaMapChartCourseView_State_StartNavigationTraining, TRUE);
}

void SeaMapChartCourseView_State_StartNavigationTraining(SeaMapChartCourseView *work)
{
    SeaMapManager *manager = SeaMapManager__GetWork();

    struct SeaMapChartCourseViewTraining *training = &work->training;

    training->navTailsHintAdvanceTimer     = 0;
    training->trainingScrollDistance       = 0;
    training->trainingLastScrollPosition.x = manager->position.x;
    training->trainingLastScrollPosition.y = manager->position.y;

    SeaMapManager__EnableTouchField(TRUE);
    CreateSeaMapEventManagerDSPopup();

    SeaMapView_ResetIndicatorFlashTimer(&work->view);
    work->canDrawNavIndicators = TRUE;

    SeaMapView_SetTouchAreaPriority(&work->view, 1);

    work->state = SeaMapChartCourseView_State_NavigationTraining;
    work->state(work);
}

void SeaMapChartCourseView_State_NavigationTraining(SeaMapChartCourseView *work)
{
    SeaMapManager *manager = SeaMapManager__GetWork();

    SeaMapView_ProcessMapInputs(&work->view);
    SeaMapView_ProcessButtonInputs(&work->view);

    SeaMapChartCourseView_HandleButtons_DrawPath(work);
    SeaMapChartCourseView_HandleTrainingHintMessages(work, sNavTailsHint_NavigationTraining, ARRAY_COUNT(sNavTailsHint_NavigationTraining));

    if (work->training.trainingZoomLevel == SeaMapManager__GetZoomLevel())
    {
        fx32 zoomScale = SeaMapManager__GetZoomOutScale();
        fx32 moveX     = manager->position.x - work->training.trainingLastScrollPosition.x;
        fx32 moveY     = manager->position.y - work->training.trainingLastScrollPosition.y;
        work->training.trainingScrollDistance += MultiplyFX(FX_Sqrt(MultiplyFX(moveX, moveX) + MultiplyFX(moveY, moveY)), zoomScale);
    }

    work->training.trainingLastScrollPosition.x = manager->position.x;
    work->training.trainingLastScrollPosition.y = manager->position.y;
    work->training.trainingZoomLevel            = SeaMapManager__GetZoomLevel();

    if (work->training.trainingScrollDistance > FLOAT_TO_FX32(600.0))
    {
        DestroySeaMapEventManagerDSPopup();
        work->state = SeaMapChartCourseView_State_FinishNavigationTrainingText;
    }
}

void SeaMapChartCourseView_State_FinishNavigationTrainingText(SeaMapChartCourseView *work)
{
    SeaMapView_SetTouchAreaPriority(&work->view, FALSE);
    SeaMapManager__EnableTouchField(FALSE);

    SeaMapChartCourseView_StartNavTailsExplain(work, sNavTailsDialog_FinishNavigationTraining, ARRAY_COUNT(sNavTailsDialog_FinishNavigationTraining),
                                               SeaMapChartCourseView_State_TryTrainingLookAtIslands, TRUE);
}

void SeaMapChartCourseView_State_TryTrainingLookAtIslands(SeaMapChartCourseView *work)
{
    if (SeaMapManager__GetZoomLevel() == SEAMAP_ZOOM_NEAREST)
        work->state = SeaMapChartCourseView_State_StartTrainingLookAtIslands;
    else
        work->state = SeaMapChartCourseView_State_StartTrainingZoomInToLookAtIslands_Intro;

    work->state(work);
}

void SeaMapChartCourseView_State_StartTrainingLookAtIslands(SeaMapChartCourseView *work)
{
    SeaMapManager *manager = SeaMapManager__GetWork();

    struct SeaMapChartCourseViewTraining *training = &work->training;

    training->trainingLastScrollPosition.x = manager->position.x + FX32_FROM_WHOLE(HW_LCD_CENTER_X);
    training->trainingLastScrollPosition.y = manager->position.y + FX32_FROM_WHOLE(HW_LCD_CENTER_Y);
    training->trainingLerpPercent          = FLOAT_TO_FX32(0.0);

    work->state = SeaMapChartCourseView_State_TrainingLookAtIslands;
    work->state(work);
}

void SeaMapChartCourseView_State_TrainingLookAtIslands(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    SeaMapLayoutObject *southernIsland = SeaMapEventManager_GetObjectFromID(SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND);
    SeaMapLayoutObject *plantKingdom   = SeaMapEventManager_GetObjectFromID(SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM);

    fx16 startX = southernIsland->position.x;
    fx16 endX   = plantKingdom->position.x;
    fx16 startY = southernIsland->position.y;
    fx16 endY   = plantKingdom->position.y;

    training->trainingLerpPercent += FLOAT_TO_FX32(1.0 / 120.0);

    fx32 targetX = (startX + endX) >> 1;
    fx32 targetY = (startY + endY) >> 1;
    if (training->trainingLerpPercent >= FLOAT_TO_FX32(1.0))
    {
        training->trainingLerpPercent = FLOAT_TO_FX32(1.0);
        work->state                   = SeaMapChartCourseView_State_StartCourseTrainingText;
    }

    fx32 viewX = mtLerpEx(training->trainingLerpPercent, training->trainingLastScrollPosition.x, FX32_FROM_WHOLE(targetX), 2);
    fx32 viewY = mtLerpEx(training->trainingLerpPercent, training->trainingLastScrollPosition.y, FX32_FROM_WHOLE(targetY), 2);

    SetSeaMapViewPosition(viewX, viewY);
}

void SeaMapChartCourseView_State_StartTrainingZoomInToLookAtIslands_Intro(SeaMapChartCourseView *work)
{
    InitSeaMapViewZoomControl(&work->zoomControl, work->view.useEngineB);

    work->state = SeaMapChartCourseView_State_TrainingZoomInToLookAtIslands_Intro;
    work->state(work);
}

void SeaMapChartCourseView_State_TrainingZoomInToLookAtIslands_Intro(SeaMapChartCourseView *work)
{
    if (SeaMapView_HandleZoomIn_Intro(&work->zoomControl))
        work->state = SeaMapChartCourseView_State_StartTrainingZoomInToLookAtIslands_Outro;
}

void SeaMapChartCourseView_State_StartTrainingZoomInToLookAtIslands_Outro(SeaMapChartCourseView *work)
{
    SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_NEAREST);

    SeaMapLayoutObject *southernIsland = SeaMapEventManager_GetObjectFromID(SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND);
    SeaMapLayoutObject *plantKingdom   = SeaMapEventManager_GetObjectFromID(SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM);
    SetSeaMapViewPosition(FX32_FROM_WHOLE((southernIsland->position.x + plantKingdom->position.x) >> 1),
                          FX32_FROM_WHOLE((southernIsland->position.y + plantKingdom->position.y) >> 1));

    SeaMapView_ProcessMapInputs(&work->view);

    InitSeaMapViewZoomControl(&work->zoomControl, work->view.useEngineB);

    work->state = SeaMapChartCourseView_State_TrainingZoomInToLookAtIslands_Outro;
    work->state(work);
}

void SeaMapChartCourseView_State_TrainingZoomInToLookAtIslands_Outro(SeaMapChartCourseView *work)
{
    if (SeaMapView_HandleZoomIn_Outro(&work->zoomControl))
        work->state = SeaMapChartCourseView_State_StartCourseTrainingText;
}

void SeaMapChartCourseView_State_StartCourseTrainingText(SeaMapChartCourseView *work)
{
    SeaMapChartCourseView_StartNavTailsExplain(work, sNavTailsDialog_ExplainCourseChartTraining, ARRAY_COUNT(sNavTailsDialog_ExplainCourseChartTraining),
                                               SeaMapChartCourseView_State_StartCourseTraining, TRUE);
}

void SeaMapChartCourseView_State_StartCourseTraining(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    training->eventListener = SeaMapEventTrigger_AddEventListener(SeaMapChartCourseView_EventCallback_Training, work);
    SeaMapManager__EnableTouchField(TRUE);

    CreateSeaMapEventManagerDSPopup();

    work->state = SeaMapChartCourseView_State_ShowCourseTrainingStylusPrompt;
    work->state(work);
}

void SeaMapChartCourseView_State_ShowCourseTrainingStylusPrompt(SeaMapChartCourseView *work)
{
    gSeaMapViewType = SEAMAPVIEW_TYPE_CHART_COURSE_NAVIGATION;

    SeaMapView_ResetIndicatorFlashTimer(&work->view);
    work->canDrawNavIndicators = TRUE;

    SeaMapChartCourseView_CreateTrainingStylusPrompt(work);

    work->state = SeaMapChartCourseView_State_TrainingWaitForStartDrawing;
    work->state(work);
}

void SeaMapChartCourseView_State_TrainingWaitForStartDrawing(SeaMapChartCourseView *work)
{
    SeaMapView_ProcessMapInputs(&work->view);
    SeaMapView_ProcessButtonInputs(&work->view);

    if (GetSeaMapEventManagerWork2()->lastTouchedIconType != SEAMAPOBJECT_NONE)
    {
        if (SeaMapChartCourseView_HandleStartDrawingButton(work))
        {
            work->state(work);
            return;
        }
    }
    else
    {
        SeaMapChartCourseView_HandleButtons_Navigation(work);
    }

    SeaMapChartCourseView_HandleTrainingHintMessages(work, sNavTailsHint_CourseTrainingInitial, ARRAY_COUNT(sNavTailsHint_CourseTrainingInitial));
}

void SeaMapChartCourseView_State_TrainingStartDrawingPath(SeaMapChartCourseView *work)
{
    gSeaMapViewType = SEAMAPVIEW_TYPE_CHART_COURSE_DRAWING;

    SeaMapView_ResetIndicatorFlashTimer(&work->view);
    work->canDrawNavIndicators = TRUE;

    SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_ConfirmPath);
    SeaMapView_SetZoomLevelForZoomButtons(&work->view, SeaMapManager__GetZoomLevel());

    SeaMapChartCourseView_SetTouchMode(work, SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE);
    SeaMapView_SetTouchAreaPriority(&work->view, FALSE);
    SeaMapManager__EnableTouchField(TRUE);

    SeaMapChartCourseView_CreateTrainingStylusPrompt(work);

    work->state = SeaMapChartCourseView_State_TrainingDrawingPath;
    work->state(work);
}

void SeaMapChartCourseView_State_TrainingDrawingPath(SeaMapChartCourseView *work)
{
    struct SeaMapChartCourseViewTraining *training = &work->training;

    SeaMapEventManager *eventManager = GetSeaMapEventManagerWork2();
    UNUSED(eventManager);

    SeaMapView_ProcessMapInputs(&work->view);

    if (IsTouchInputEnabled() && TouchInput__IsTouchPush(&touchInput))
    {
        SeaMapChartCourseView_SetTouchMode(work, SeaMapChartCourseView_DetermineTouchMode(work, touchInput.push.x, touchInput.push.y));

        if (work->touchMode != SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE)
            SeaMapView_ClearLocalMoveInputs(&work->view);
    }
    else if (IsTouchInputEnabled() && TouchInput__IsTouchPull(&touchInput))
    {
        SeaMapView_ResetIndicatorFlashTimer(&work->view);

        if (work->touchMode == SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE)
        {
            StopChartSfx(work->view.sndHandle);
            work->view.isPlayingDrawMoveSfx = FALSE;

            if (SeaMapManager__GetNodeCount() == 1)
            {
                SeaMapChartCourseView_ClearVoyagePath(work);
                return;
            }
            else if (SeaMapManager__GetNodeCount() > 1 && SeaMapManager__GetTotalDistance() < FLOAT_TO_FX32(8.0))
            {
                SeaMapChartCourseView_ClearVoyagePath(work);
                return;
            }
        }
    }
    else if (IsTouchInputEnabled() && TouchInput__IsTouchOn(&touchInput) && work->touchMode == SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE
             && SeaMapChartCourseView_CheckTouchPosIsInvalidLocation(work) && GetNavTailsActiveSpeakMsg() != NAVTAILS_MSGSEQ_WE_CANT_GO_THERE_IN_THIS_SHIP)
    {
        NavTailsSpeak(NAVTAILS_MSGSEQ_WE_CANT_GO_THERE_IN_THIS_SHIP, SECONDS_TO_FRAMES(10.0));
    }

    if (training->navTailsCourseTrainingCongratulated == FALSE && training->trainingReachedIntendedIsland)
    {
        training->navTailsCourseTrainingCongratulated = TRUE;
        SeaMapManager__EnableTouchField(FALSE);
        SeaMapChartCourseView_StartNavTailsExplain(work, sNavTailsDialog_FinishCourseTraining, ARRAY_COUNT(sNavTailsDialog_FinishCourseTraining),
                                                   SeaMapChartCourseView_State_TrainingStartDrawingPath, TRUE);
    }
    else if (training->navTailsExplainedGaugeLimit == FALSE && FX_Div(work->view.remainingVoyageDist, work->view.totalVoyageDist) < FLOAT_TO_FX32(0.1))
    {
        training->navTailsExplainedGaugeLimit = TRUE;
        SeaMapManager__EnableTouchField(FALSE);
        SeaMapChartCourseView_StartNavTailsExplain(work, sNavTailsDialog_ExplainGaugeLimit, ARRAY_COUNT(sNavTailsDialog_ExplainGaugeLimit),
                                                   SeaMapChartCourseView_State_TrainingStartDrawingPath, TRUE);
    }
    else
    {
        SeaMapChartCourseView_HandleTrainingHintMessages(work, sNavTailsHint_CourseTrainingDrawing, ARRAY_COUNT(sNavTailsHint_CourseTrainingDrawing));
        SeaMapView_ProcessButtonInputs(&work->view);
        SeaMapChartCourseView_HandleButtons_DrawPath(work);
    }
}

void SeaMapChartCourseView_State_TrainingConfirmDrawnPath(SeaMapChartCourseView *work)
{
    SeaMapManager__EnableTouchField(FALSE);

    if (work->training.trainingReachedIntendedIsland)
    {
        work->canDrawNavIndicators = FALSE;
        SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_None);

        SpriteButtonConfig config;
        InitSpriteButtonConfig(&config, work->view.useEngineB, SPRITE_BUTTON_ACTIVEBUTTON_YES_NO);
        config.vramPixels[0] = work->view.vramPixels[2];
        config.vramPixels[1] = work->view.vramPixels[3];
        config.paletteRow[0] = PALETTE_ROW_1;
        config.paletteRow[1] = PALETTE_ROW_2;
        config.paletteRow[2] = PALETTE_ROW_3;
        config.oamPriority   = SPRITE_PRIORITY_0;
        config.oamOrder      = SPRITE_ORDER_4;
        config.field_16      = 0x3540;
        CreateSpriteButton(&config);

        NavTailsSpeak(NAVTAILS_MSGSEQ_IS_THIS_OKAY, 0);
        work->state = SeaMapChartCourseView_State_TrainingConfirmDrawnPathResponse;
    }
    else
    {
        SeaMapChartCourseView_StartNavTailsExplain(work, sNavTailsDialog_ExplainDestination, ARRAY_COUNT(sNavTailsDialog_ExplainDestination),
                                                   SeaMapChartCourseView_State_TrainingStartDrawingPath, TRUE);
    }
}

void SeaMapChartCourseView_State_TrainingConfirmDrawnPathResponse(SeaMapChartCourseView *work)
{
    switch (GetSelectedSpriteButton())
    {
        case SPRITE_BUTTON_YES:
            DestroySpriteButton();
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_PAUSE);

            gSeaMapViewExitEvent = SEAMAPVIEW_EXIT_CONFIRM;
            work->state          = SeaMapChartCourseView_State_StartTrainingScreenDim;
            break;

        case SPRITE_BUTTON_NO:
            DestroySpriteButton();
            SeaMapManager__EnableTouchField(TRUE);
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_V_CANCELL);
            work->training.navTailsHintAdvanceTimer = SECONDS_TO_FRAMES(10.0);

            if (work->touchMode == SEAMAPCHARTCOURSEVIEW_TOUCHMODE_DRAW_AND_NAVIGATE || (s32)work->touchMode == SEAMAPCHARTCOURSEVIEW_TOUCHMODE_NAVIGATE_ONLY)
                work->state = SeaMapChartCourseView_State_TrainingStartDrawingPath;
            break;
    }
}

void SeaMapChartCourseView_State_StartTrainingScreenDim(SeaMapChartCourseView *work)
{
    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[work->view.useEngineB];

    RenderCore_SetBlendBrightness(VOID_TO_INT(&gfxControl->blendManager), GX_PLANEMASK_ALL | GX_PLANEMASK_EFFECT, -1);

    work->state = SeaMapChartCourseView_State_TrainingScreenDim;
}

void SeaMapChartCourseView_State_TrainingScreenDim(SeaMapChartCourseView *work)
{
    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[work->view.useEngineB];

    if (gfxControl->blendManager.coefficient.value < 4)
        gfxControl->blendManager.coefficient.value++;
    else
        work->state = SeaMapChartCourseView_State_StartFinishAllTrainingText;
}

void SeaMapChartCourseView_State_StartFinishAllTrainingText(SeaMapChartCourseView *work)
{
    SeaMapChartCourseView_StartNavTailsExplain(work, sNavTailsDialog_FinishAllTraining, ARRAY_COUNT(sNavTailsDialog_FinishAllTraining), SeaMapChartCourseView_State_TrainingFadeOut,
                                               TRUE);
}

void SeaMapChartCourseView_State_TrainingFadeOut(SeaMapChartCourseView *work)
{
    if (SeaMapView_FadeActiveScreen_ToTarget(&work->view))
    {
        s32 worldX;
        s32 worldY;
        u16 mapX;
        u16 mapY;

        fx32 distance = SeaMapManager__GetTotalDistance();
        for (fx32 progress = 0; progress < distance; progress += 0x10000)
        {
            SeaMapManager__Func_2045BF8(progress, &worldX, &worldY);
            SeaMapManager__ConvertWorldPosToMapPos(worldX, worldY, &mapX, &mapY);
            SeaMapManager__DiscoverMap_Elipse(mapX, mapY, 3, 3);
        }
        SeaMapManager__Func_2045BF8(distance, &worldX, &worldY);
        SeaMapManager__ConvertWorldPosToMapPos(worldX, worldY, &mapX, &mapY);
        SeaMapManager__DiscoverMap_Elipse(mapX, mapY, 3, 3);

        RenderCore_DisableBlending(&VRAMSystem__GFXControl[work->view.useEngineB]->blendManager);
        work->isFinished = TRUE;
    }
}