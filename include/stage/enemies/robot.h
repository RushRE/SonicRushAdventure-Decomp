#ifndef RUSH2_ROBOT_H
#define RUSH2_ROBOT_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyRobot_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK collider;
    Vec2Fx32 field_3A4;
    void (*onInit)(struct EnemyRobot_ *work);
    void (*onDetect)(struct EnemyRobot_ *work);
    s32 field_3B4;
    s32 field_3B8;
    s32 field_3BC;
    s32 field_3C0;
    u16 field_3C4;
    u16 type;

    struct EnemyRobotAnimControl
    {
        u16 animID1;
        u16 duration2;
        u16 animID2;
        u16 duration;
        u16 int168;
        u32 dwordC;
    } anim;

    struct EnemyRobotUnknown2
    {
        Vec2Fx32 field_0;
        fx32 dword8;
        u16 field_C;
        u16 int16E;
    } word3D8;

} EnemyRobot;

// --------------------
// FUNCTIONS
// --------------------

EnemyRobot *EnemyRobot__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void EnemyRobot__Func_2155378(EnemyRobot *work);
void EnemyRobot__Func_21553A0(EnemyRobot *work);
void EnemyRobot__OnInit_21553D0(EnemyRobot *work);
void EnemyRobot__State_2155450(EnemyRobot *work);
void EnemyRobot__OnInit_2155620(EnemyRobot *work);
void EnemyRobot__State_2155650(EnemyRobot *work);
void EnemyRobot__OnInit_21557D8(EnemyRobot *work);
void EnemyRobot__State_2155804(EnemyRobot *work);
void EnemyRobot__OnDetect_2155820(EnemyRobot *work);
void EnemyRobot__State_2155894(EnemyRobot *work);
void EnemyRobot__State_21558F0(EnemyRobot *work);
void EnemyRobot__State_21559AC(EnemyRobot *work);
void EnemyRobot__OnDetect_21559D8(EnemyRobot *work);
void EnemyRobot__State_2155A54(EnemyRobot *work);
void EnemyRobot__State_2155AC4(EnemyRobot *work);
void EnemyRobot__OnDetect_2155C5C(EnemyRobot *work);
void EnemyRobot__State_2155C80(EnemyRobot *work);
void EnemyRobot__OnDetect_FoundFX(EnemyRobot *work);
void EnemyRobot__State_2155E44(EnemyRobot *work);
void EnemyRobot__State_2155E80(EnemyRobot *work);
void EnemyRobot__OnDefend_Hurtbox(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void EnemyRobot__OnDefend_Detector(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void EnemyRobot__OnDefend_TutorialEnemy(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // RUSH2_ROBOT_H