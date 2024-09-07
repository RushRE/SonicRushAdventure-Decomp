#ifndef RUSH2_GHOST_H
#define RUSH2_GHOST_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyGhost_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK collider;
    Vec2Fx32 targetPos;
    u32 field_3AC;
    u32 dword3B0;
    u32 field_3B4;
    u32 dword3B8;
    u32 field_3BC;
    u16 angle;
    u8 byte3C2;
    u32 dword3C4;
    OBS_ACTION2D_BAC_WORK animator;
    u32 dword478;
} EnemyGhost;

typedef struct EnemyGhostBomb_
{
    GameObjectTask gameWork;
} EnemyGhostBomb;

// --------------------
// FUNCTIONS
// --------------------

EnemyGhost *EnemyGhost__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemyGhostBomb *EnemyGhostBomb__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void EnemyGhost__Func_21577F0(EnemyGhost *work);
void EnemyGhost__Func_215799C(EnemyGhost *work);
void EnemyGhost__State_2157A44(EnemyGhost *work);
void EnemyGhost__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void EnemyGhost__State_2157C2C(EnemyGhost *work);
void EnemyGhost__State_2157D70(EnemyGhost *work);
void EnemyGhostBomb__State_2157E1C(EnemyGhostBomb *work);
void EnemyGhostBomb__State_2157E8C(EnemyGhostBomb *work);
void EnemyGhostBomb__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void EnemyGhost__Draw(void);
void EnemyGhost__Destructor(Task *task);

#endif // RUSH2_GHOST_H