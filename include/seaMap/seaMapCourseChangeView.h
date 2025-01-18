#ifndef RUSH_SEAMAPCOURSECHANGEVIEW_H
#define RUSH_SEAMAPCOURSECHANGEVIEW_H

#include <global.h>
#include <game/system/task.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapCourseChangeView_
{
    void (*state)(struct SeaMapCourseChangeView_ *work);
    BOOL flag;
    u32 field_8;
} SeaMapCourseChangeView;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void SeaMapCourseChangeView__Create(void);
NOT_DECOMPILED void SeaMapCourseChangeView__Main(void);
NOT_DECOMPILED void SeaMapCourseChangeView__Destructor(Task *task);
NOT_DECOMPILED void SeaMapCourseChangeView__Destroy(void);
NOT_DECOMPILED void SeaMapCourseChangeView__RunningState(void);
NOT_DECOMPILED void SeaMapCourseChangeView__ResetDisplay(void);
NOT_DECOMPILED void SeaMapCourseChangeView__State_Setup(void);
NOT_DECOMPILED void SeaMapCourseChangeView__State_FadeIn(void);
NOT_DECOMPILED void SeaMapCourseChangeView__State_Active(void);
NOT_DECOMPILED void SeaMapCourseChangeView__State_FadeOut(void);

#endif // RUSH_SEAMAPCOURSECHANGEVIEW_H