#ifndef RUSH2_SNOWFLAKEHEAD_H
#define RUSH2_SNOWFLAKEHEAD_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemySnowflakeHead_
{
    GameObjectTask gameWork;
    s32 dword364;
    s32 yMin;
    s32 dword36C;
    s32 yMax;
    u8 type;
    s32 timer;
} EnemySnowflakeHead;

// --------------------
// FUNCTIONS
// --------------------

EnemySnowflakeHead *EnemySnowflakeHead__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void EnemySnowflakeHead__Action_Init(EnemySnowflakeHead *work);
void EnemySnowflakeHead__State_21583A0(EnemySnowflakeHead *work);
void EnemySnowflakeHead__State_215841C(EnemySnowflakeHead *work);
void EnemySnowflakeHead__State_2158494(EnemySnowflakeHead *work);
void EnemySnowflakeHead__Func_21584AC(EnemySnowflakeHead *work);
void EnemySnowflakeHead__State_2158540(EnemySnowflakeHead *work);

#endif // RUSH2_SNOWFLAKEHEAD_H