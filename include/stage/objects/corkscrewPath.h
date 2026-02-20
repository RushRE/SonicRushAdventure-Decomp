#ifndef RUSH_CORKSCREWPATH_H
#define RUSH_CORKSCREWPATH_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum CorkscrewPathObjectFlags
{
    CORKSCREWPATH_OBJFLAG_NONE,

    CORKSCREWPATH_OBJFLAG_LEFTWARDS = 1 << 0,      // If set, while in the corkscrew sequence, the player will go from right to left if horizontal (object 104),
                                                   // or will do so in the first half-loop if vertical (object 105).
    CORKSCREWPATH_OBJFLAG_UPWARDS        = 1 << 1, // If set, when in a vertical corkscrew sequence the player will go upwards.
    CORKSCREWPATH_OBJFLAG_RAIL_CORKSCREW = 1 << 7, // Set for when grinding on rails (as in Hidden Island 16) or snowboarding.

    CORKSCREWPATH_OBJFLAG_TYPE_SHIFT = 12,
    CORKSCREWPATH_OBJFLAG_FLAG_MASK  = (1 << CORKSCREWPATH_OBJFLAG_TYPE_SHIFT) - 1,
};

enum CorkscrewPathType
{
    CORKSCREWPATH_TYPE_HORIZONTAL,
    CORKSCREWPATH_TYPE_VERTICAL,
    CORKSCREWPATH_TYPE_HORIZONTAL_RAIL,
};

enum CorkscrewVerticalPathType
{
    CORKSCREWVERTICALPATH_TYPE_RUSH_LEAF_STORM_2, // This goes unused in Rush Adventure
    CORKSCREWVERTICALPATH_TYPE_SKY_BABYLON,
};

// --------------------
// STRUCTS
// --------------------

typedef struct CorkscrewPath_
{
    GameObjectTask gameWork;
} CorkscrewPath;

// --------------------
// FUNCTIONS
// --------------------

CorkscrewPath *CreateCorkscrewPath(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_CORKSCREWPATH_H
