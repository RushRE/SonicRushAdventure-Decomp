#ifndef RUSH_CORKSCREWPATH_H
#define RUSH_CORKSCREWPATH_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum CorkscrewPathObjectFlags
{
    CORKSCREWPATH_OBJFLAG_NONE,

    CORKSCREWPATH_OBJFLAG_RIGHT_TRIGGER = 1 << 0, // dertermines if trigger is left/right trigger (start/end?)
    CORKSCREWPATH_OBJFLAG_2             = 1 << 1,
    CORKSCREWPATH_OBJFLAG_80            = 1 << 7,

    CORKSCREWPATH_OBJFLAG_TYPE_SHIFT = 12,
    CORKSCREWPATH_OBJFLAG_FLAG_MASK  = (1 << CORKSCREWPATH_OBJFLAG_TYPE_SHIFT) - 1,
};

enum CorkscrewPathType
{
    CORKSCREWPATH_TYPE_HORIZONTAL,
    CORKSCREWPATH_TYPE_VERTICAL,
    CORKSCREWPATH_TYPE_2,
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
