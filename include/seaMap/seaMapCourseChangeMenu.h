#ifndef RUSH_SEAMAPCOURSECHANGEMENU_H
#define RUSH_SEAMAPCOURSECHANGEMENU_H

#include <game/system/task.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapCourseChangeMenu_
{
    void (*state)(struct SeaMapCourseChangeMenu_ *work);
    BOOL destroyQueued;
    u32 unused;
} SeaMapCourseChangeMenu;

// --------------------
// VARIABLES
// --------------------

extern Vec2Fx32 gSeaMapCourseChangeMenu_shipPosition;

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapCourseChangeMenu(void);

#endif // RUSH_SEAMAPCOURSECHANGEMENU_H