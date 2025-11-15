#include <game/graphics/screenShake.h>
#include <game/math/mtMath.h>

// --------------------
// CONSTANTS
// --------------------

#define SHAKE_DURATION_SHORTEST 8
#define SHAKE_DURATION_SHORT    12
#define SHAKE_DURATION_LONG     16
#define SHAKE_DURATION_LONGEST  22

// --------------------
// VARIABLES
// --------------------

static Task *screenShakeTask = NULL;

// --------------------
// FUNCTION DECLS
// --------------------

static void CreateScreenShake(void);
static void DestroyScreenShake(void);
static void ScreenShake_Main(void);
static void ScreenShake_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

ScreenShake *ShakeScreen(ScreenShakeType type)
{
    if (type == SCREENSHAKE_GET_ACTIVE)
    {
        if (screenShakeTask != NULL)
            return TaskGetWork(screenShakeTask, ScreenShake);
        else
            return NULL;
    }
    else
    {
        Task *task = screenShakeTask;
        if (screenShakeTask == NULL)
        {
            CreateScreenShake();
            task = screenShakeTask;

            if (task == NULL)
                return NULL;
        }

        ScreenShake *work = TaskGetWork(task, ScreenShake);
        if (type == SCREENSHAKE_STOP)
        {
            DestroyScreenShake();
            return NULL;
        }

        if (work->type <= type)
        {
            work->type  = type;
            work->flags = SCREENSHAKE_FLAG_ACTIVE;
            work->timer = 0;
        }

        return work;
    }
}

ScreenShake *ShakeScreenCycle(fx32 power, s32 angleSpeed, fx32 deceleration)
{
    Task *task = screenShakeTask;
    if (screenShakeTask == NULL)
    {
        CreateScreenShake();
        task = screenShakeTask;

        if (task == NULL)
            return NULL;
    }

    ScreenShake *work = TaskGetWork(task, ScreenShake);
    work->type        = SCREENSHAKE_CYCLE;
    work->flags       = SCREENSHAKE_FLAG_ACTIVE;

    if (power != FLOAT_TO_FX32(0.0))
        work->power = power;

    work->angleSpeed   = angleSpeed;
    work->deceleration = deceleration;

    return work;
}

s32 GetScreenShakeOffsetX(void)
{
    if (screenShakeTask == NULL)
        return 0;

    ScreenShake *work = TaskGetWork(screenShakeTask, ScreenShake);
    return work->offset.x;
}

s32 GetScreenShakeOffsetY(void)
{
    if (screenShakeTask == NULL)
        return 0;

    ScreenShake *work = TaskGetWork(screenShakeTask, ScreenShake);
    return work->offset.y;
}

void CreateScreenShake(void)
{
    Task *task = TaskCreate(ScreenShake_Main, ScreenShake_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3E00, TASK_GROUP(3), ScreenShake);
    if (task == HeapNull)
        return;

    screenShakeTask = task;

    ScreenShake *work = TaskGetWork(task, ScreenShake);
    TaskInitWork16(work);
}

void DestroyScreenShake(void)
{
    if (screenShakeTask != NULL)
    {
        ScreenShake *work = TaskGetWork(screenShakeTask, ScreenShake);
        TaskInitWork16(work);
    }
}

void ScreenShake_Main(void)
{
    static const s8 shakeMedTable[] = {
        (0) | (2 << 4),
        (0) | (2 << 4),
        (0) | (-2 << 4),
        (0) | (-2 << 4),
    };

    static const s8 shakeWeakTable[] = {
        (0) | (2 << 4),  // [Line formatting comment]
        (0) | (2 << 4),  // [Line formatting comment]
        (0) | (-2 << 4), // [Line formatting comment]
        (0) | (2 << 4),  // [Line formatting comment]
        (0) | (2 << 4),  // [Line formatting comment]
        (0) | (-2 << 4), // [Line formatting comment]
        (0) | (2 << 4),  // [Line formatting comment]
        (0) | (2 << 4),  // [Line formatting comment]
        (0) | (-2 << 4), // [Line formatting comment]
        (0) | (2 << 4),  // [Line formatting comment]
        (0) | (2 << 4),  // [Line formatting comment]
        (0) | (-2 << 4), // [Line formatting comment]
    };

    static const s8 shakeStrongTable[] = {
        (-2 & 0x0F) | (2 << 4),  // [Line formatting comment]
        (2 & 0x0F) | (-4 << 4),  // [Line formatting comment]
        (2 & 0x0F) | (-4 << 4),  // [Line formatting comment]
        (-4 & 0x0F) | (4 << 4),  // [Line formatting comment]
        (4 & 0x0F) | (-2 << 4),  // [Line formatting comment]
        (4 & 0x0F) | (-2 << 4),  // [Line formatting comment]
        (-2 & 0x0F) | (0 << 4),  // [Line formatting comment]
        (4 & 0x0F) | (2 << 4),   // [Line formatting comment]
        (-4 & 0x0F) | (4 << 4),  // [Line formatting comment]
        (2 & 0x0F) | (4 << 4),   // [Line formatting comment]
        (2 & 0x0F) | (4 << 4),   // [Line formatting comment]
        (2 & 0x0F) | (-4 << 4),  // [Line formatting comment]
        (-4 & 0x0F) | (4 << 4),  // [Line formatting comment]
        (-4 & 0x0F) | (4 << 4),  // [Line formatting comment]
        (4 & 0x0F) | (-2 << 4),  // [Line formatting comment]
        (-2 & 0x0F) | (0 << 4),  // [Line formatting comment]
        (-2 & 0x0F) | (0 << 4),  // [Line formatting comment]
        (4 & 0x0F) | (2 << 4),   // [Line formatting comment]
        (-4 & 0x0F) | (-4 << 4), // [Line formatting comment]
        (-4 & 0x0F) | (-4 << 4), // [Line formatting comment]
        (2 & 0x0F) | (2 << 4),   // [Line formatting comment]
    };

    ScreenShake *work = TaskGetWorkCurrent(ScreenShake);

    if ((work->flags & SCREENSHAKE_FLAG_ACTIVE) == 0)
    {
        DestroyCurrentTask();
        return;
    }

    if ((work->flags & SCREENSHAKE_FLAG_PAUSED) == 0)
    {
        work->offset.x = 0;
        work->offset.y = 0;

        if ((work->flags & SCREENSHAKE_FLAG_ACTIVE) != 0)
        {
            switch (work->type)
            {
                case SCREENSHAKE_CYCLE:
                    work->offset.y = FX32_TO_WHOLE(work->power * CosFX((s32)(u16)work->angle));

                    work->power -= work->deceleration;
                    if (work->power < FLOAT_TO_FX32(0.0))
                        work->power = FLOAT_TO_FX32(0.0);

                    work->angle += work->angleSpeed;

                    if (work->power == FLOAT_TO_FX32(0.0))
                        DestroyScreenShake();
                    break;

                case SCREENSHAKE_TINY_SHORT:
                    if (work->timer > SHAKE_DURATION_SHORTEST)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_TINY_MIDDLE:
                    if (work->timer >= SHAKE_DURATION_SHORT)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_TINY_LONG:
                    if (work->timer >= SHAKE_DURATION_SHORT)
                        work->timer = 0;

                    work->offset.x = FX32_FROM_WHOLE((s8)((shakeWeakTable[work->timer] & 0xF) >> 1));
                    work->offset.y = FX32_FROM_WHOLE((s8)((shakeWeakTable[work->timer] >> 4) >> 1));
                    break;

                case SCREENSHAKE_SMALL_SHORT:
                    if (work->timer > SHAKE_DURATION_SHORTEST)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_SMALL_MIDDLE:
                    if (work->timer >= SHAKE_DURATION_SHORT)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_SMALL_LONG:
                    if (work->timer >= SHAKE_DURATION_SHORT)
                        work->timer = 0;

                    work->offset.x = FX32_FROM_WHOLE((s8)(shakeWeakTable[work->timer] & 0xF));
                    work->offset.y = FX32_FROM_WHOLE((s8)(shakeWeakTable[work->timer] >> 4));

                    // if (work->offset.x < 0)
                    if ((work->offset.x & 0x8000) != 0)
                    {
                        work->offset.x = FLOAT_TO_FX32(16.0) - work->offset.x;
                        work->offset.x = -work->offset.x;
                    }
                    break;

                case SCREENSHAKE_MEDIUM_SHORT:
                    if (work->timer >= SHAKE_DURATION_SHORTEST)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_MEDIUM_MIDDLE:
                    if (work->timer >= SHAKE_DURATION_LONG)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_MEDIUM_LONG:
                    if (work->timer >= SHAKE_DURATION_LONG)
                        work->timer = 0;

                    work->offset.x = FX32_FROM_WHOLE((s8)(shakeMedTable[work->timer & 3] & 0xF));
                    work->offset.y = FX32_FROM_WHOLE((s8)(shakeMedTable[work->timer & 3] >> 4));

                    // if (work->offset.x < 0)
                    if ((work->offset.x & 0x8000) != 0)
                    {
                        work->offset.x = FLOAT_TO_FX32(16.0) - work->offset.x;
                        work->offset.x = -work->offset.x;
                    }
                    break;

                case SCREENSHAKE_BIG_SHORT:
                    if (work->timer >= SHAKE_DURATION_SHORTEST)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_BIG_MIDDLE:
                    if (work->timer >= SHAKE_DURATION_LONGEST)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_BIG_LONG:
                    if (work->timer >= SHAKE_DURATION_LONGEST)
                        work->timer = 0;

                    work->offset.x = FX32_FROM_WHOLE((s8)(shakeStrongTable[work->timer] & 0xF));
                    work->offset.y = FX32_FROM_WHOLE((s8)(shakeStrongTable[work->timer] >> 4));

                    // if (work->offset.x < 0)
                    if ((work->offset.x & 0x8000) != 0)
                    {
                        work->offset.x = FLOAT_TO_FX32(16.0) - work->offset.x;
                        work->offset.x = -work->offset.x;
                    }
                    break;

                case SCREENSHAKE_MASSIVE_SHORT:
                    if (work->timer >= SHAKE_DURATION_SHORTEST)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_MASSIVE_MIDDLE:
                    if (work->timer >= SHAKE_DURATION_LONGEST)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_MASSIVE_LONG:
                    if (work->timer >= SHAKE_DURATION_LONGEST)
                        work->timer = 0;

                    work->offset.x = FX32_FROM_WHOLE((s8)(shakeStrongTable[work->timer] & 0xF));
                    work->offset.y = FX32_FROM_WHOLE((s8)(shakeStrongTable[work->timer] >> 4));

                    // if (work->offset.x < 0)
                    if ((work->offset.x & 0x8000) != 0)
                    {
                        work->offset.x = FLOAT_TO_FX32(16.0) - work->offset.x;
                        work->offset.x = -work->offset.x;
                    }

                    work->offset.x *= 2;
                    work->offset.y *= 2;
                    break;

                default:
                    break;
            }

            work->timer++;
        }
    }
}

void ScreenShake_Destructor(Task *task)
{
    screenShakeTask = NULL;
}
