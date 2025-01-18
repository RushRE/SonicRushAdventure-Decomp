#ifndef RUSH_SNOWFLAKEHEAD_H
#define RUSH_SNOWFLAKEHEAD_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum SnowflakeHeadType_
{
    SNOWFLAKEHEAD_TYPE_IDLE,
    SNOWFLAKEHEAD_TYPE_MOVING_RIGHT,
    SNOWFLAKEHEAD_TYPE_MOVING_LEFT,
    SNOWFLAKEHEAD_TYPE_MOVING_UP,
    SNOWFLAKEHEAD_TYPE_MOVING_DOWN,
};
typedef u8 SnowflakeHeadType;

// --------------------
// STRUCTS
// --------------------

typedef struct EnemySnowflakeHead_
{
    GameObjectTask gameWork;
    fx32 xMin;
    fx32 yMin;
    fx32 xMax;
    fx32 yMax;
    SnowflakeHeadType type;
    s32 timer;
} EnemySnowflakeHead;

// --------------------
// FUNCTIONS
// --------------------

EnemySnowflakeHead *CreateSnowflakeHead(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_SNOWFLAKEHEAD_H