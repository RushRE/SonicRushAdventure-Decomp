#ifndef RUSH2_JETPACKROBOT_H
#define RUSH2_JETPACKROBOT_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum JetpackRobotType_
{
    JETPACKROBOT_TYPE_HOVER,
    JETPACKROBOT_TYPE_MOVE,
};
typedef u16 JetpackRobotType;

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyJetpackRobot_
{
    GameObjectTask gameWork;
    void (*onInit)(struct EnemyJetpackRobot_ *work);
    fx32 xMin;
    fx32 yMin;
    fx32 xMax;
    fx32 yMax;
    JetpackRobotType type;

    union
    {
        struct
        {
            u16 animID;
            u16 angle;
            u16 angleSpeed;
        } hover;

        struct
        {
            u16 animUpID;
            u16 animDownID;
            u16 unknown;
            fx32 velocityUp;
            fx32 velocityDown;
            fx32 maxDistanceUp;
            fx32 maxDistanceDown;
        } move;
    };

} EnemyJetpackRobot;

// --------------------
// FUNCTIONS
// --------------------

EnemyJetpackRobot *CreateJetpackRobot(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_JETPACKROBOT_H