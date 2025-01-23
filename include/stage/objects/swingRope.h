#ifndef RUSH_SWINGROPE_H
#define RUSH_SWINGROPE_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

#define SWINGROPE_NODE_COUNT 12
#define SWINGROPE_MAX_NODES  18

// --------------------
// STRUCTS
// --------------------

typedef struct SwingRope_
{
    GameObjectTask gameWork;
    OBS_ACTION2D_BAC_WORK aniNode;
    s16 nodeCount;
    s16 word416;
    s16 word418;
    u16 field_41A;
    u16 field_41C;
    s16 field_41E;
    Vec2Fx32 nodePositions[SWINGROPE_MAX_NODES];
    OBS_RECT_WORK colliders[SWINGROPE_MAX_NODES];
    u16 nodeAngle[SWINGROPE_MAX_NODES];
} SwingRope;

// --------------------
// FUNCTIONS
// --------------------

void *SwingRope__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_SWINGROPE_H
