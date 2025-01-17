#ifndef RUSH2_SAILSEAMAPVIEW_H
#define RUSH2_SAILSEAMAPVIEW_H

#include <seaMap/seaMapView.h>
#include <seaMap/objects/seaMapBoatIcon.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SailSeaMapView_
{
    SeaMapView view;
    SeaMapBoatIcon *boatIcon;
    void (*state)(struct SailSeaMapView_ *work);
    s32 storedVoyageProgress;
    s32 useStoredProgress;
    Vec2Fx32 position;
} SailSeaMapView;

// --------------------
// FUNCTIONS
// --------------------

void CreateSailSeaMapView(ShipType type);
void DestroySailSeaMapView(void);
void SailSeaMapView_GetPosition(fx32 *x, fx32 *y);
SailSeaMapView *SailSeaMapView_GetWork(void);
fx32 SailSeaMapView_GetVoyageCompetionPercent(void);
s32 SailSeaMapView_GetNodesFromPercent(s32 progress, u16 *nodeX, u16 *nodeY, SeaMapManagerNode **prevNodePtr, SeaMapManagerNode **nextNodePtr);

#endif // !RUSH2_SAILSEAMAPVIEW_H