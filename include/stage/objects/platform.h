#ifndef RUSH2_PLATFORM_H
#define RUSH2_PLATFORM_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Platform_
{
    GameObjectTask gameWork;
} Platform;

typedef struct Platform2_
{
    GameObjectTask gameWork;
    Vec2Fx32 fallPosition[3][3];
    Vec2Fx32 fallVelocity[3][3];
} Platform2;

// --------------------
// FUNCTIONS
// --------------------

Platform *Platform__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void Platform__Destructor(Task *task);
void Platform__State_Move(Platform *work);
void Platform__Action_Init(Platform *work);
void Platform__HandleMovement(Platform *work);
void Platform__Action_Collapse(Platform *work);
void Platform__State_Collapse(Platform2 *work);
void Platform__Draw_Collapse(void);

#endif // RUSH2_PLATFORM_H