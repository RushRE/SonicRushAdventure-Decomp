#ifndef RUSH_SEAMAPCHARTCOURSEVIEW_H
#define RUSH_SEAMAPCHARTCOURSEVIEW_H

#include <seaMap/seaMapView.h>
#include <seaMap/objects/seaMapStylusIcon.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapChartCourseViewNavTailsTalk_
{
    u16 navTailsSequence;
    u32 dword4;
} SeaMapChartCourseViewNavTailsTalk;

typedef struct SeaMapChartCourseView_
{
    SeaMapView view;
    s32 type;
    SeaMapViewZoomControl zoomControl;
    void (*prevState)(struct SeaMapChartCourseView_ *work);
    void (*state)(struct SeaMapChartCourseView_ *work);
    void (*stateDraw)(struct SeaMapChartCourseView_ *work);
    BOOL disableDrawing;
    AnimatorSprite field_7D0;
    AnimatorSprite field_834;
    AnimatorSprite field_898;
    AnimatorSprite field_8FC;
    s32 field_960;
    s32 field_964;
    s32 field_968;
    s32 field_96C;
    s32 field_970;
    s32 field_974;
    s32 field_978;
    s32 field_97C;
    s32 field_980;
    s32 field_984;
    s32 field_988;
    s32 field_98C;
    s32 field_990;
    s32 field_994;
    s32 field_998;
    s32 field_99C;
    s32 field_9A0;
    s32 field_9A4;
    s32 field_9A8;
    s32 field_9AC;
    s32 field_9B0;
    s32 field_9B4;
    s32 field_9B8;
    s32 field_9BC;
    s32 field_9C0;
    s32 field_9C4;
    s32 touchMode;
    s32 field_9CC;
    s32 field_9D0;
    TouchField field_9D4;
    SeaMapChartCourseViewNavTailsTalk *navTailsSequenceList;
    s16 navTailsSequenceCount;
    u16 navTailsSequenceID;
    void (*nextState)(struct SeaMapChartCourseView_ *work);
    s32 field_9F8;
    AnimatorSprite field_9FC;
    s32 field_A60;
    s32 field_A64;
    s32 field_A68;
    s32 field_A6C;
    s32 field_A70;
    s32 field_A74;
    s32 field_A78;
    s32 field_A7C;
    s32 field_A80;
    s32 field_A84;
    s32 field_A88;
    s32 field_A8C;
    s32 field_A90;
    s32 field_A94;
    s32 field_A98;
    s32 field_A9C;
    s32 field_AA0;
    s32 field_AA4;
    s32 field_AA8;
    SeaMapStylusIcon *stylusIcon;
    s32 field_AB0;
    Task *penPalette;
    s32 field_AB8;
    s32 field_ABC;
    s32 field_AC0;
    Vec2Fx32 field_AC4;
    s32 field_ACC;
    s32 field_AD0;
    s16 field_AD4;
    s16 field_AD6;
    u16 field_AD8;
    s16 field_ADA;
} SeaMapChartCourseView;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void SeaMapChartCourseView__Create(BOOL useEngineB, ShipType shipType, s32 mode);
NOT_DECOMPILED void SeaMapChartCourseView__Destroy(void);
NOT_DECOMPILED BOOL SeaMapChartCourseView__Func_2040978(void);
NOT_DECOMPILED void SeaMapChartCourseView__TouchAreaCallback(TouchAreaResponse *response, TouchArea *area, void *userData);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2040B90(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2040C54(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2040C7C(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2040D28(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2040DE0(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2040EEC(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__SetTouchCallback(SeaMapChartCourseView *work, s32 mode);
NOT_DECOMPILED BOOL SeaMapChartCourseView__Func_2040FE8(SeaMapChartCourseView *work, int a2, int a3, int a4);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2041048(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2041104(int a1, int a2, int a3);
NOT_DECOMPILED BOOL SeaMapChartCourseView__Func_2041268(void);
NOT_DECOMPILED void SeaMapChartCourseView__Main(void);
NOT_DECOMPILED void SeaMapChartCourseView__Destructor(Task *task);
NOT_DECOMPILED void SeaMapChartCourseView__Draw_2041440(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Draw_20414A0(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_204153C(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_20416D8(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_20416F0(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2041708(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_204176C(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2041794(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2041804(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2041834(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_204184C(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_20418B0(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_20418D8(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2041948(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2041978(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_20419B0(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2041A18(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2041A68(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2041ADC(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2041C64(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2041D04(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2041DD0(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2041E24(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2041E30(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2041E3C(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2041E80(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2041F20(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2041F8C(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_204201C(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2042178(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_20421AC(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__Func_2042208(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__StartNavTailsTalk(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042278(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_20422D4(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_204231C(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042388(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_20424DC(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042524(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_204258C(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_20425AC(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_20425D0(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_20425F8(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_204261C(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042640(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042668(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_TryZoomIn(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_20426EC(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_ZoomIn(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_20427B0(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_20427D8(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042844(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042934(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042978(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_20429AC(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_20429F8(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042B04(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042B34(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042B5C(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042BDC(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042C04(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042C2C(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042C6C(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042CB0(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042D14(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042D98(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2042FA8(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2043080(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2043148(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_2043180(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_20431B0(SeaMapChartCourseView *work);
NOT_DECOMPILED void SeaMapChartCourseView__State_20431D4(SeaMapChartCourseView *work);

#endif // RUSH_SEAMAPCHARTCOURSEVIEW_H