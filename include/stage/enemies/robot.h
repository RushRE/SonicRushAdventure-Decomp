#ifndef RUSH_ROBOT_H
#define RUSH_ROBOT_H

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

enum SteamBlasterAnimID
{
    STEAMBLASTER_ANI_MOVE,
    STEAMBLASTER_ANI_DETECT,
    STEAMBLASTER_ANI_PREPARE_ATTACK,
    STEAMBLASTER_ANI_ATTACKING,
    STEAMBLASTER_ANI_FINISH_ATTACK,
    STEAMBLASTER_ANI_TURN,

    STEAMBLASTER_ANI_STEAM_START,
    STEAMBLASTER_ANI_STEAM_ACTIVE,
    STEAMBLASTER_ANI_STEAM_END,
    
    STEAMBLASTER_ANI_SMOKE,
};

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
    fx32 yMin;
    fx32 xMax;
    fx32 yMax;
    s16 colliderActivateTimer;
    RobotType type;

    union
    {
        struct EnemyRobotCommonMoveConfig
        {
            u16 aniMove;
            u16 aniTurn;
            u16 aniDetect;
            s16 detectDelay;
            s16 detectDuration;
            fx32 moveSpeed;
        } common;

        struct EnemyRobotPterodactylMoveConfig
        {
            u16 aniMove;
            u16 aniTurn;
            fx32 moveSpeed;
            fx32 jumpRadius;
            u16 angleSpeed;
            u16 angle;
        } pterodactyl;
    } move;

    union
    {
        struct EnemyRobotCommonAttackConfig
        {
            u16 aniAttack;
            fx32 accel;
            fx32 targetSpeed;
            s16 chargeDelay;
            s16 chargeCooldown;
        } common;

        struct EnemyRobotPterodactylAttackConfig
        {
            Vec2Fx32 startPos;
        } pterodactyl;
    } attack;

} EnemyRobot;

// --------------------
// FUNCTIONS
// --------------------

EnemyRobot *CreateRobot(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_ROBOT_H