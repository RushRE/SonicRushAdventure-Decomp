#ifndef RUSH2_ROBOT_H
#define RUSH2_ROBOT_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum RobotType_
{
    ROBOT_TYPE_TRICERATOPS,
    ROBOT_TYPE_FLYING_FISH,
    ROBOT_TYPE_PTERODACTYL,
    ROBOT_TYPE_SPANNER_BOT,
    ROBOT_TYPE_STEAM_BLASTER,

    ROBOT_TYPE_COUNT,
};
typedef u16 RobotType;

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyRobot_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK colliderDetect;
    Vec2Fx32 detectPlayerPos;
    void (*onInit)(struct EnemyRobot_ *work);
    void (*onDetect)(struct EnemyRobot_ *work);
    fx32 xMin;
    fx32 field_3B8;
    fx32 xMax;
    fx32 field_3C0;
    s16 colliderActivateTimer;
    RobotType type;

    union
    {
        struct EnemyRobotTriceratopsGfx
        {
            u16 aniMove;
            u16 aniTurn;
            u16 aniDetect;
            s16 detectDelay;
            s16 detectDuration;
            fx32 moveSpeed;
        } common;

        struct EnemyRobotPterodactylGfx
        {
            u16 aniMove;
            u16 aniTurn;
            fx32 moveSpeed;
            fx32 jumpRadius;
            u16 angleSpeed;
            u16 angle;
        } pterodactyl;
    } gfx;

    union
    {
        struct EnemyRobotTriceratopsUnknown
        {
            u16 aniAttack;
            fx32 accel;
            fx32 targetSpeed;
            s16 chargeDelay;
            s16 chargeCooldown;
        } common;

        struct EnemyRobotPterodactylUnknown
        {
            Vec2Fx32 startPos;
        } pterodactyl;
    } unknown;

} EnemyRobot;

// --------------------
// FUNCTIONS
// --------------------

EnemyRobot *CreateRobot(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_ROBOT_H