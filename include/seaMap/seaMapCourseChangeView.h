#ifndef RUSH_SEAMAPCOURSECHANGEVIEW_H
#define RUSH_SEAMAPCOURSECHANGEVIEW_H

#include <global.h>
#include <game/system/task.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapCourseChangeView_
{
    void (*state)(struct SeaMapCourseChangeView_ *work);
    BOOL destroyQueued;
    u32 field_8;
} SeaMapCourseChangeView;

// --------------------
// VARIABLES
// --------------------

extern Vec2Fx32 SeaMapCourseChangeView_shipPosition;

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapCourseChangeView(void);

#endif // RUSH_SEAMAPCOURSECHANGEVIEW_H