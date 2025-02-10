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
    DOCKAREA_SHIP,
    DOCKAREA_BOAT,
    DOCKAREA_SUBMARINE,
    DOCKAREA_BEACH,
    DOCKAREA_DRILL,

    DOCKAREA_COUNT,
    DOCKAREA_NONE    = DOCKAREA_COUNT,
    DOCKAREA_INVALID = DOCKAREA_NONE + 1,
};
typedef u32 DockArea;

#endif // RUSH_DOCKCOMMON_H