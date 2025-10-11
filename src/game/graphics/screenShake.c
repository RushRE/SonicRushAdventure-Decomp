#include <game/graphics/screenShake.h>
#include <game/math/mtMath.h>

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
    if (type == SCREENSHAKE_CUSTOM)
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

ScreenShake *ShakeScreenEx(s32 lifetime, s32 rotSpeed, s32 lifetimeDrain)
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
    work->type        = SCREENSHAKE_COSINE_WAVE;
    work->flags       = SCREENSHAKE_FLAG_ACTIVE;

    if (lifetime != 0)
        work->lifetime = lifetime;

    work->rotSpeed      = rotSpeed;
    work->lifetimeDrain = lifetimeDrain;

    return work;
}

s32 GetScreenShakeOffsetX(void)
{
    if (screenShakeTask == NULL)
    {
        return 0;
    }

    ScreenShake *work = TaskGetWork(screenShakeTask, ScreenShake);
    return work->offset.x;
}

s32 GetScreenShakeOffsetY(void)
{
    if (screenShakeTask == NULL)
    {
        return 0;
    }

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
                case SCREENSHAKE_COSINE_WAVE:
                    work->offset.y = FX32_TO_WHOLE(work->lifetime * CosFX((s32)(u16)work->angle));

                    work->lifetime -= work->lifetimeDrain;
                    if (work->lifetime < 0)
                        work->lifetime = 0;

                    work->angle += work->rotSpeed;

                    if (work->lifetime == 0)
                        DestroyScreenShake();
                    break;

                case SCREENSHAKE_A_SHORT:
                    if (work->timer > 8)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_A_LONG:
                    if (work->timer >= 12)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_A_LOOP:
                    if (work->timer >= 12)
                        work->timer = 0;

                    work->offset.x = FX32_FROM_WHOLE((s8)((shakeWeakTable[work->timer] & 0xF) >> 1));
                    work->offset.y = FX32_FROM_WHOLE((s8)((shakeWeakTable[work->timer] >> 4) >> 1));
                    break;

                case SCREENSHAKE_B_SHORT:
                    if (work->timer > 8)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_B_LONG:
                    if (work->timer >= 12)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_B_LOOP:
                    if (work->timer >= 12)
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

                case SCREENSHAKE_C_SHORT:
                    if (work->timer >= 8)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_C_LONG:
                    if (work->timer >= 16)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_C_LOOP:
                    if (work->timer >= 16)
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

                case SCREENSHAKE_D_SHORT:
                    if (work->timer >= 8)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_D_LONG:
                    if (work->timer >= 22)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_D_LOOP:
                    if (work->timer >= 22)
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

                case SCREENSHAKE_E_SHORT:
                    if (work->timer >= 8)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_E_LONG:
                    if (work->timer >= 22)
                    {
                        DestroyScreenShake();
                        break;
                    }
                    // fallthrough

                case SCREENSHAKE_E_LOOP:
                    if (work->timer >= 22)
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
