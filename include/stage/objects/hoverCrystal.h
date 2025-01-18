#ifndef RUSH_HOVERCRYSTAL_H
#define RUSH_HOVERCRYSTAL_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum HoverCrystalObjectFlags
{
    HOVERCRYSTAL_OBJFLAG_NONE,

    HOVERCRYSTAL_OBJFLAG_WEIGHT_MASK = 0x03,
};

// --------------------
// STRUCTS
// --------------------

typedef struct HoverCrystal_
{
    GameObjectTask gameWork;
} HoverCrystal;

// --------------------
// FUNCTIONS
// --------------------

HoverCrystal *CreateHoverCrystal(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_HOVERCRYSTAL_H
