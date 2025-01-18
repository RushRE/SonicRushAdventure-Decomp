#ifndef RUSH_PIRATE_H
#define RUSH_PIRATE_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum PirateType_
{
    PIRATE_TYPE_KNIFE,
    PIRATE_TYPE_BAZOOKA,
    PIRATE_TYPE_BALLCHAIN,
    PIRATE_TYPE_BOMB,
    PIRATE_TYPE_SKELETON,
    PIRATE_TYPE_HOVERBOMBER,
    PIRATE_TYPE_HOVERGUNNER,

    PIRATE_TYPE_COUNT,
};
typedef u16 PirateType;

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyBazookaPirateShot_
{
    GameObjectTask gameWork;
} EnemyBazookaPirateShot;

typedef struct EnemyBallChainPirateBall_
{
    GameObjectTask gameWork;
    GameObjectTask chainWork;
    void (*stateBall)(struct EnemyBallChainPirateBall_ *work);
    u16 bounceCount;
    u16 bounceTimer;
    u16 swingAngle;
    Vec2Fx32 offset;
    BOOL playedSwingSfx;
} EnemyBallChainPirateBall;

typedef struct EnemyBombPirateBomb_
{
    GameObjectTask gameWork;
    u16 bounceCount;
    u16 bounceTimer;
} EnemyBombPirateBomb;

typedef struct EnemySkeletonPirateBone_
{
    GameObjectTask gameWork;
} EnemySkeletonPirateBone;

typedef struct EnemyHoverBomberPirateBomb_
{
    GameObjectTask gameWork;
} EnemyHoverBomberPirateBomb;

typedef struct EnemyHoverGunnerPirateShot_
{
    GameObjectTask gameWork;
} EnemyHoverGunnerPirateShot;

typedef struct EnemyPirate_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK colliderDetect;
    Vec2Fx32 detectPlayerPos;
    void (*onInit)(struct EnemyPirate_ *work);
    void (*onDetect)(struct EnemyPirate_ *work);
    fx32 xMin;
    fx32 yMin;
    fx32 xMax;
    fx32 yMax;
    s16 colliderActivateTimer;
    PirateType type;
    BOOL didAttack;
    BOOL thrownBomb;

    union
    {
        struct EnemyPirateMoveConfigCommon
        {
            u16 aniMove;
            u16 aniTurn;
            u16 aniDetect;
            u16 detectDelay;
            u16 detectDuration;
            u16 hoverRadius;
            u16 hoverAngle;
            fx32 moveSpeed;
        } common;
    } move;

    union
    {
        struct EnemyPirateAttackConfigCommon
        {
            u16 anim;
            s16 duration;
            s16 cooldown;
            void (*attackState)(struct EnemyPirate_ *work);
        } common;

        struct EnemyPirateAttackConfigBallChain
        {
            u16 anim;
            s16 duration;
            s16 cooldown;
            void (*attackState)(struct EnemyPirate_ *work);
            EnemyBallChainPirateBall *ball;
        } ballChain;
    } attack;
} EnemyPirate;

// --------------------
// FUNCTIONS
// --------------------

EnemyPirate *CreatePirate(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemyBazookaPirateShot *CreateBazookaPirateShot(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemyBallChainPirateBall *CreateBallChainPirateBall(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemyBombPirateBomb *CreateBombPirateBomb(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemySkeletonPirateBone *CreateSkeletonPirateBone(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemyHoverBomberPirateBomb *CreateHoverBomberPirateBomb(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemyHoverGunnerPirateShot *CreateHoverGunnerPirateShot(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_PIRATE_H