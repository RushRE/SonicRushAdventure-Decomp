#include <game/object/obj.h>
#include <game/object/objRect.h>
#include <game/input/touchInput.h>
#include <game/object/objectManager.h>

// --------------------
// VARIABLES
// --------------------

u32 _obj_disp_rand;

// --------------------
// FUNCTIONS
// --------------------

fx32 ObjSpdUpSet(fx32 value, fx32 step, fx32 target)
{
    value += MultiplyFX(step, g_obj.speed);

    if (target == 0)
        return value;

    if (step >= 0)
    {
        if (value > target)
            value = target;
    }
    else
    {
        if (value < -target)
            value = -target;
    }

    return value;
}

fx32 ObjSpdDownSet(fx32 value, fx32 step)
{
    if (value > 0)
    {
        value -= MultiplyFX(step, g_obj.speed);
        if (value < 0)
            value = 0;
    }
    else
    {
        value += MultiplyFX(step, g_obj.speed);
        if (value > 0)
            value = 0;
    }

    return value;
}

s32 ObjShiftSet(s32 value, s32 target, u16 shift, s32 max, s32 min)
{
    if (value == target)
        return value;

    if (min == 0)
        min = 1;

    s32 change = (target - value) >> shift;

    // clamp to max if needed
    if (max != 0)
    {
        if (change > max)
            change = max;

        if (change < -max)
            change = -max;
    }

    // clamp to min if needed
    if (min != 0)
    {
        if (change > 0)
        {
            if (change < min)
                change = min;
        }
        else if (change < 0)
        {
            if (change > -min)
                change = -min;
        }
        else
        {
            if (target - value > 0 && change < min)
                change = min;

            if (target - value < 0 && change > -min)
                change = -min;
        }
    }

    value += change;

    if (change > 0)
    {
        if (value > target)
            value = target;
    }
    else
    {
        if (change < 0 && value < target)
            value = target;
    }

    return value;
}

s32 ObjDiffSet(s32 value, s32 target, s32 start, u16 shift, s32 max, s32 min)
{
    if (value == target)
        return value;

    if (min == 0)
        min = 1;

    s32 change = (value - start) >> shift;

    if (target > start && change < 0)
        change = 0;

    if (target < start && change > 0)
        change = 0;

    // clamp to max if needed
    if (max != 0)
    {
        if (change > max)
            change = max;

        if (change < -max)
            change = -max;
    }

    // clamp to min if needed
    if (min != 0)
    {
        if (change > 0)
        {
            if (change < min)
                change = min;
        }
        else if (change < 0)
        {
            if (change > -min)
                change = -min;
        }
        else
        {
            if ((target - value) > 0 && change < min)
                change = min;

            if ((target - value) < 0 && change > -min)
                change = -min;
        }
    }

    value += change;

    if (change > 0)
    {
        if (value > target)
            value = target;
    }
    else
    {
        if (change < 0 && value < target)
            value = target;
    }

    return value;
}

fx32 ObjAlphaSet(fx32 target, fx32 start, u16 percent)
{
    if (percent == FLOAT_TO_FX32(0.0))
        return start;

    if (percent == FLOAT_TO_FX32(1.0))
        return target;

    return start + MultiplyFX(target - start, percent);
}

s32 ObjRoopMove16(u32 dir, u32 targetDir, fx32 speed)
{
    if (targetDir == dir)
        return targetDir;

    u32 dist = (u16)MATH_ABS(((s32)dir - (s32)targetDir));

    s32 targetPos;
    if (dir > targetDir)
        targetPos = (u16)(FLOAT_DEG_TO_IDX(360.0) - dir + targetDir);
    else
        targetPos = (u16)(FLOAT_DEG_TO_IDX(360.0) - targetDir + dir);

    if (dist <= targetPos)
    {
        if (dir > targetDir)
        {
            dir -= speed;

            if ((s32)targetDir > (s32)dir)
            {
                dir = targetDir;
            }
            else
            {
                dir &= 0xFFFF;
            }
        }
        else if (dir < targetDir)
        {
            dir += speed;

            if ((s32)targetDir < (s32)dir)
            {
                dir = targetDir;
            }
            else
            {
                dir &= 0xFFFF;
            }
        }
    }
    else
    {
        if (dir > targetDir)
        {
            if ((s32)targetDir + FLOAT_DEG_TO_IDX(360.0) < (s32)dir + speed)
            {
                dir = targetDir;
            }
            else
            {
                dir += speed;
                dir &= 0xFFFF;
            }
        }
        else if (dir < targetDir)
        {
            if ((s32)targetDir > (s32)dir - speed + FLOAT_DEG_TO_IDX(360.0))
            {
                dir = targetDir;
            }
            else
            {
                dir -= speed;
                dir &= 0xFFFF;
            }
        }
    }

    return dir;
}

s32 ObjRoopDiff16(u32 dir1, u32 dir2)
{
    if (dir2 == dir1)
        return 0;

    s16 num1 = (dir1 - dir2);

    s16 num2;
    if (dir1 > dir2)
        num2 = (FLOAT_DEG_TO_IDX(360.0) - dir1 + dir2);
    else
        num2 = (FLOAT_DEG_TO_IDX(360.0) - dir2 + dir1);

    return MATH_ABS(num1) > MATH_ABS(num2) ? num2 : num1;
}

BOOL ObjTouchCheck(StageTask *work, OBS_RECT_WORK *rect)
{
    if (IsTouchInputEnabled() && TouchInput__IsTouchOn(&touchInput))
    {
        rect->parent = work;

        fx32 x;
        fx32 y;
        if (g_obj.camera[0].y > g_obj.camera[1].y)
        {
            x = FX32_TO_WHOLE(g_obj.camera[0].x);
            y = FX32_TO_WHOLE(g_obj.camera[0].y);
        }
        else
        {
            x = FX32_TO_WHOLE(g_obj.camera[1].x);
            y = FX32_TO_WHOLE(g_obj.camera[1].y);
        }

        return ObjRect__PointCheck(rect, touchInput.on.x + x, touchInput.on.y + y, 0);
    }

    return FALSE;
}

BOOL ObjTouchCheckPush(StageTask *work, OBS_RECT_WORK *rect)
{
    if (IsTouchInputEnabled() && TouchInput__IsTouchPush(&touchInput))
    {
        rect->parent = work;

        fx32 x;
        fx32 y;
        if (g_obj.camera[0].y > g_obj.camera[1].y)
        {
            x = FX32_TO_WHOLE(g_obj.camera[0].x);
            y = FX32_TO_WHOLE(g_obj.camera[0].y);
        }
        else
        {
            x = FX32_TO_WHOLE(g_obj.camera[1].x);
            y = FX32_TO_WHOLE(g_obj.camera[1].y);
        }

        // despite checking for push, it actually compares with touch.on?
        return ObjRect__PointCheck(rect, touchInput.on.x + x, touchInput.on.y + y, 0);
    }

    return FALSE;
}
