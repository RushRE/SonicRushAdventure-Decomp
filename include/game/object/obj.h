#ifndef RUSH_OBJ_H
#define RUSH_OBJ_H

#include <stage/stageTask.h>

// --------------------
// VARIABLES
// --------------------

extern u32 _obj_disp_rand;

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void ObjDispSRand(u32 seed)
{
    _obj_disp_rand = seed;
}

RUSH_INLINE u32 ObjDispRandSeed(void)
{
    return _obj_disp_rand;
}

// returns a random value between 0 and 0xFFFF
RUSH_INLINE u16 ObjDispRand(void)
{
    _obj_disp_rand = (u32)(1663525 * (s32)_obj_disp_rand + 1013904223);
    return (u16)(_obj_disp_rand >> 16);
}

// returns a random value between 0 and (max - 1)
RUSH_INLINE s32 ObjDispRandRepeat(s32 max)
{
    return ObjDispRand() & (max - 1);
}

// returns a random value between 'min' and (max - 1)
RUSH_INLINE s32 ObjDispRandRange(s32 min, s32 max)
{
    return (-min - 1) - (ObjDispRand() & ((max - 1) * 2));
}

// returns a random value between 'min' and (max - 1)
RUSH_INLINE s32 ObjDispRandRange2(s32 min, s32 max)
{
    return min + ObjDispRandRepeat(max - min);
}

// returns a random value between 'min' and (max - 1)
RUSH_INLINE s32 ObjDispRandRange3(s32 min, s32 max)
{
    return (-min - 1) - (ObjDispRand() & (max - 1));
}

#define ObjDispRandRange4(min, max) (((min) - 1) - ((ObjDispRand() & (((max - min) - 1) * 2))))

// returns a random value between 'min' and (max - 1)
RUSH_INLINE s32 ObjDispRandRange5(s32 min, s32 max)
{
    return (-min) - ObjDispRandRepeat(max - min);
}


// --------------------
// FUNCTIONS
// --------------------

fx32 ObjSpdUpSet(fx32 value, fx32 step, fx32 target);
fx32 ObjSpdDownSet(fx32 value, fx32 step);
s32 ObjShiftSet(s32 value, s32 target, u16 shift, s32 maxChange, s32 minChange);
s32 ObjDiffSet(s32 value, s32 target, s32 start, u16 shift, s32 maxChange, s32 minChange);

fx32 ObjAlphaSet(fx32 target, fx32 start, u16 percent); // lerp
s32 ObjRoopMove16(u32 dir, u32 targetDir, fx32 speed);  // move from dir to targetDir by speed
s32 ObjRoopDiff16(u32 dir1, u32 dir2);                  // distance between 2 directions

// check if player touched within a rect in world-space
BOOL ObjTouchCheck(StageTask *work, OBS_RECT_WORK *rect);
BOOL ObjTouchCheckPush(StageTask *work, OBS_RECT_WORK *rect);

#endif // RUSH_OBJ_H
