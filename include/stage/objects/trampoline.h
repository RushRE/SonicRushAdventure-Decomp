#ifndef RUSH_TRAMPOLINE_H
#define RUSH_TRAMPOLINE_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

#define TRAMPOLINE_NODE_MAX 12

// --------------------
// STRUCTS
// --------------------

typedef struct TrampolineNode_
{
    VecFx32 start;
    VecFx32 end;
} TrampolineNode;

typedef struct Trampoline_
{
    GameObjectTask gameWork;
    AnimatorSprite3D aniTrampoline;
    GXDLInfo drawList;
    void *drawData;
    TrampolineNode nodePositionList[TRAMPOLINE_NODE_MAX];
    s16 nodeAngleList[TRAMPOLINE_NODE_MAX];
    VecFx32 position;
    Vec2Fx32 targetPos;
    u16 type;
    s16 field_5CE;
    s32 field_5D0;
    s32 field_5D4;
    s32 field_5D8;
    s32 field_5DC;
    fx32 playerBouncePos;
} Trampoline;

// --------------------
// FUNCTIONS
// --------------------

Trampoline *CreateTrampoline(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_TRAMPOLINE_H
