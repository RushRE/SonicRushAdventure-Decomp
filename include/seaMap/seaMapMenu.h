#ifndef RUSH_SEAMAPMENU_H
#define RUSH_SEAMAPMENU_H

#include <seaMap/seaMapView.h>
#include <seaMap/seaMapEventManager.h>

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
    CHEVObject *selectedIsland;
    BOOL drawPadCursors;
} SeaMapMenu;

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapMenu(BOOL useEngineB);

#endif // RUSH_SEAMAPMENU_H
