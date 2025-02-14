#ifndef RUSH_DOCKCOMMON_H
#define RUSH_DOCKCOMMON_H

#include <global.h>

// --------------------
// ENUMS
// --------------------

enum DockArea_
{
    DOCKAREA_BASE,
    DOCKAREA_BASE_NEXT,
    DOCKAREA_JET,
    DOCKAREA_BOAT,
    DOCKAREA_HOVER,
    DOCKAREA_SUBMARINE,
    DOCKAREA_BEACH,
    DOCKAREA_DRILL,

    DOCKAREA_COUNT,
    DOCKAREA_NONE    = DOCKAREA_COUNT,
    DOCKAREA_INVALID = DOCKAREA_NONE + 1,
};
typedef s32 DockArea;

enum MapArea_
{
    MAPAREA_BASE,
    MAPAREA_JET,
    MAPAREA_BOAT,
    MAPAREA_HOVER,
    MAPAREA_SUBMARINE,
    MAPAREA_BEACH,
    MAPAREA_DRILL,
    MAPAREA_TUTORIAL,

    MAPAREA_COUNT,
    MAPAREA_INVALID,
};
typedef s32 MapArea;

enum HubType_
{
    HUB_TYPE_MAP,
    HUB_TYPE_DOCK,
};
typedef s32 HubType;

#endif // RUSH_DOCKCOMMON_H