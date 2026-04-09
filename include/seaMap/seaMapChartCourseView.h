#ifndef RUSH_SEAMAPCHARTCOURSEVIEW_H
#define RUSH_SEAMAPCHARTCOURSEVIEW_H

#include <seaMap/seaMapView.h>
#include <seaMap/seaMapEventTrigger.h>
#include <seaMap/objects/seaMapIslandDrawIcon.h>
#include <seaMap/objects/seaMapStylusIcon.h>

// --------------------
// TYPES
// --------------------

typedef struct SeaMapChartCourseViewNavTailsTalk_ SeaMapChartCourseViewNavTailsTalk;

// --------------------
// ENUMS
// --------------------

enum SeaMapChartCourseViewType_
{
    SEAMAPCHARTCOURSEVIEW_TYPE_CHART_COURSE,
    SEAMAPCHARTCOURSEVIEW_TYPE_CHANGE_COURSE,
    SEAMAPCHARTCOURSEVIEW_TYPE_TRAINING,

    SEAMAPCHARTCOURSEVIEW_TYPE_COUNT,
};
typedef s32 SeaMapChartCourseViewType;

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapChartCourseView_
{
    SeaMapView view;
    SeaMapChartCourseViewType type;
    SeaMapViewZoomControl zoomControl;
    void (*prevState)(struct SeaMapChartCourseView_ *work);
    void (*state)(struct SeaMapChartCourseView_ *work);
    void (*stateDraw)(struct SeaMapChartCourseView_ *work);
    BOOL isFinished;

    union
    {
        struct
        {
            AnimatorSprite aniInkJar;
            AnimatorSprite aniGaugeBG;
            AnimatorSprite aniGaugeBGEnds;
            AnimatorSprite aniGaugeInk;
            AnimatorSprite aniGaugeInkRemain;
        };

        AnimatorSprite array[5];
    } pathAnimators;

    SeaMapIslandDrawIcon *lastTouchedIcon;
    s32 touchMode;
    BOOL canDrawNavIndicators;
    BOOL disableVoyagePathColorUpdate;

    struct SeaMapChartCourseViewTraining
    {
        TouchField navTailsBubblePromptField;
        const SeaMapChartCourseViewNavTailsTalk *navTailsSequenceList;
        u16 navTailsSequenceCount;
        u16 navTailsSequenceID;
        void (*nextState)(struct SeaMapChartCourseView_ *work);
        BOOL navTailsDimScreenFlag;
        SpriteButtonAnimator bubblePopupButton;
        BOOL navTailsPlayedPopupSfx;
        BOOL navTailsConfirmedPopupBubble;
        u16 navTailsAutoAdvanceTimer;
        SeaMapStylusIcon *stylusIcon;
        SeaMapEventListener *eventListener;
        Task *brightnessModifierTask;
        BOOL trainingReachedIntendedIsland;
        BOOL navTailsExplainedGaugeLimit;
        BOOL navTailsCourseTrainingCongratulated;
        Vec2Fx32 trainingLastScrollPosition;
        s32 trainingZoomLevel;
        fx32 trainingScrollDistance;
        u16 navTailsHintAdvanceTimer;
        s16 trainingLerpPercent;
        u16 trainingTimer;
    } training;
} SeaMapChartCourseView;

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapChartCourseView(BOOL useEngineB, ShipType shipType, SeaMapChartCourseViewType type);
void DestroySeaMapChartCourseView(void);
BOOL IsSeaMapChartCourseViewFinished(void);

#endif // RUSH_SEAMAPCHARTCOURSEVIEW_H