#ifndef RUSH2_DASHPANEL_H
#define RUSH2_DASHPANEL_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct DashPanel_
{
    GameObjectTask gameWork;
} DashPanel;

// --------------------
// FUNCTIONS
// --------------------

DashPanel *CreateDashPanel(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_DASHPANEL_H
