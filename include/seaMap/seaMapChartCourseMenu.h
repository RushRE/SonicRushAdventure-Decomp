#ifndef RUSH_SEAMAPCHARTCOURSEMENU_H
#define RUSH_SEAMAPCHARTCOURSEMENU_H

#include <game/system/task.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapChartCourseMenu_
{
    void (*state)(struct SeaMapChartCourseMenu_ *work);
    BOOL destroyQueued;
    u32 unused;
} SeaMapChartCourseMenu;

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapChartCourseMenu(void);

#endif // RUSH_SEAMAPCHARTCOURSEMENU_H