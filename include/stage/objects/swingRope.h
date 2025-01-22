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
    AnimatorSpriteDS aniNode;
    u32 field_408;
    OBS_SPRITE_REF *spriteRef;
    u32 field_410;
    s16 nodeCount;
    s16 word416;
    s16 word418;
    u16 field_41A;
    u16 field_41C;
    s16 field_41E;
    Vec2Fx32 nodePositions[SWINGROPE_MAX_NODES];
    OBS_RECT_WORK colliders[SWINGROPE_MAX_NODES];
    s16 nodeAngle[SWINGROPE_MAX_NODES];
} SwingRope;

// --------------------
// FUNCTIONS
// --------------------

SwingRope *SwingRope__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void SwingRope__Destructor(Task *task);
void SwingRope__Action_Init(SwingRope *work);
void SwingRope__State_2162520(SwingRope *work);
void SwingRope__Draw(void);
void SwingRope__Collide(void);
void SwingRope__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void SwingRope__HandleNodePositions(SwingRope *work);

#endif // RUSH_SWINGROPE_H
