#ifndef RUSH2_SEAMAPMENU_H
#define RUSH2_SEAMAPMENU_H

#include <seaMap/seaMapView.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapMenu_
{
    SeaMapView view;
    SeaMapViewZoomControl zoomControl;
    void (*prevState)(struct SeaMapMenu_ *work);
    void (*state)(struct SeaMapMenu_ *work);
    BOOL isClosed;
    s32 field_7C8;
    BOOL drawPadCursors;
    s32 field_7D0;
    s32 field_7D4;
} SeaMapMenu;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void SeaMapMenu__Create(BOOL useEngineB);
NOT_DECOMPILED u16 SeaMapMenu__GetIslandInfoText(u32 id);
NOT_DECOMPILED s32 SeaMapMenu__Func_20400A0(SeaMapMenu *work);
NOT_DECOMPILED s32 SeaMapMenu__Func_204011C(SeaMapMenu *work);
NOT_DECOMPILED s32 SeaMapMenu__Func_20401B8(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu_Main(void);
NOT_DECOMPILED void SeaMapMenu_Destructor(Task *task);
NOT_DECOMPILED void SeaMapMenu__Draw(void);
NOT_DECOMPILED void SeaMapMenu__Action_ZoomIn(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_ZoomIn(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_TryZoomIn(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_PrepareZoomIn(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_ZoomInFinish(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__Action_ZoomOut(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_ZoomOut(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_TryZoomOut(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_PrepareZoomOut(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_ZoomOutFinish(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_20405D4(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_20405F4(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_204064C(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_2040690(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_2040734(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_Close(SeaMapMenu *work);
NOT_DECOMPILED void SeaMapMenu__State_FadeOut(SeaMapMenu *work);

#endif // RUSH2_SEAMAPMENU_H
