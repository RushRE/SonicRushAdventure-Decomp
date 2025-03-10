#include <game/graphics/drawFadeTask.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/drawReqTask.h>
#include <game/math/mtMath.h>

// --------------------
// VARIABLES
// --------------------

static Task *drawFadeTask;

// --------------------
// FUNCTION DECLS
// --------------------

static void DrawFadeTask_Destructor(Task *task);
static void DrawFadeTask_Main(void);
static void SetDrawFadeTaskBrightness(DrawFadeTask *work);

// --------------------
// FUNCTIONS
// --------------------

DrawFadeTask *CreateDrawFadeTask(DrawFadeTaskFlags flags, fx32 fadeSpeed)
{
    Task *task;
    DrawFadeTask *work;

    TaskFlags taskFlag = TASK_FLAG_NONE;
    BOOL disableSetup  = FALSE;

    if (CheckTaskPaused(NULL))
        taskFlag = TASK_FLAG_IGNORE_PAUSELEVEL;

    if (drawFadeTask != NULL)
    {
        work         = TaskGetWork(drawFadeTask, DrawFadeTask);
        disableSetup = TRUE;
        drawFadeTask->usrFlags |= taskFlag;
    }
    else
    {
        task = TaskCreate(DrawFadeTask_Main, DrawFadeTask_Destructor, taskFlag, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3E00, TASK_GROUP(3), DrawFadeTask);
        if (task == HeapNull)
            return NULL;

        drawFadeTask = task;
        work         = TaskGetWork(task, DrawFadeTask);
        TaskInitWork16(work);
    }

    work->fadeSpeed = fadeSpeed;
    work->flags     = flags;
    work->delay     = 0;

    if (!disableSetup || (work->flags & DRAW_FADE_TASK_FLAG_ALWAYS_INIT) != 0)
    {
        if ((work->flags & DRAW_FADE_TASK_FLAG_FADE_TO_BLACK) != 0)
            work->brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE + 1);
        else
            work->brightness = RENDERCORE_BRIGHTNESS_DEFAULT;
    }

    if ((work->flags & DRAW_FADE_TASK_FLAG_INIT_WITH_FADE) == 0)
        SetDrawFadeTaskBrightness(work);

    return work;
}

void DrawFadeTask_Destructor(Task *task)
{
    drawFadeTask = NULL;
}

void DrawFadeTask_Main(void)
{
    DrawFadeTask *work = TaskGetWorkCurrent(DrawFadeTask);

    if ((work->flags & DRAW_FADE_TASK_FLAG_FADE_TO_BLACK) != 0)
    {
        if (work->brightness <= 0)
        {
            work->flags |= DRAW_FADE_TASK_FLAG_FINISHED;
            if ((work->flags & DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED) == 0)
            {
                DestroyCurrentTask();
                return;
            }
        }

        if (work->delay != 0)
            work->delay--;
        else
            work->brightness -= work->fadeSpeed;
    }
    else
    {
        if (work->brightness >= FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE))
        {
            work->flags |= DRAW_FADE_TASK_FLAG_FINISHED;
            if ((work->flags & DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED) == 0)
            {
                DestroyCurrentTask();
                return;
            }
        }

        if (work->delay)
            work->delay--;
        else
            work->brightness += work->fadeSpeed;
    }

    if (work->brightness < FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT))
        work->brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT);

    if (work->brightness > FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE))
        work->brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE);

    SetDrawFadeTaskBrightness(work);
}

void SetDrawFadeTaskBrightness(DrawFadeTask *work)
{
    s16 brightness;
    if (work->brightness > FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE))
        brightness = RENDERCORE_BRIGHTNESS_WHITE;
    else
        brightness = FX32_TO_WHOLE(work->brightness);

    if ((work->flags & DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS) == 0)
        brightness = -brightness;

    if ((work->flags & (DRAW_FADE_TASK_FLAG_ENGINEA_ONLY | DRAW_FADE_TASK_FLAG_ENGINEB_ONLY)) != 0)
    {
        if ((work->flags & DRAW_FADE_TASK_FLAG_ENGINEA_ONLY) != 0)
            renderCoreGFXControlA.brightness = brightness;

        if ((work->flags & DRAW_FADE_TASK_FLAG_ENGINEB_ONLY) != 0)
            renderCoreGFXControlB.brightness = brightness;
    }
    else
    {
        renderCoreGFXControlA.brightness = brightness;
        renderCoreGFXControlB.brightness = brightness;
    }

    if (Camera3D__GetTask())
    {
        Camera3DTask *camera3D = Camera3D__GetWork();
        if ((work->flags & (DRAW_FADE_TASK_FLAG_ENGINEA_ONLY | DRAW_FADE_TASK_FLAG_ENGINEB_ONLY)) != 0)
        {
            if ((work->flags & DRAW_FADE_TASK_FLAG_ENGINEA_ONLY) != 0)
                camera3D->gfxControl[0].brightness = brightness;

            if ((work->flags & DRAW_FADE_TASK_FLAG_ENGINEB_ONLY) != 0)
                camera3D->gfxControl[1].brightness = brightness;
        }
        else
        {
            camera3D->gfxControl[0].brightness = brightness;
            camera3D->gfxControl[1].brightness = brightness;
        }
    }

    if ((work->flags & DRAW_FADE_TASK_FLAG_APPLY_BRIGHTNESS_TO_SYSTEM) != 0)
    {
        work->flags &= ~DRAW_FADE_TASK_FLAG_APPLY_BRIGHTNESS_TO_SYSTEM;

        if ((work->flags & (DRAW_FADE_TASK_FLAG_ENGINEA_ONLY | DRAW_FADE_TASK_FLAG_ENGINEB_ONLY)) != 0)
        {
            if ((work->flags & DRAW_FADE_TASK_FLAG_ENGINEA_ONLY) != 0)
                GX_SetMasterBrightness(renderCoreGFXControlA.brightness);

            if ((work->flags & DRAW_FADE_TASK_FLAG_ENGINEB_ONLY) != 0)
                GXS_SetMasterBrightness(renderCoreGFXControlB.brightness);
        }
        else
        {
            GX_SetMasterBrightness(renderCoreGFXControlA.brightness);
            GXS_SetMasterBrightness(renderCoreGFXControlB.brightness);
        }
    }
}

void DestroyDrawFadeTask(void)
{
    if (drawFadeTask != NULL)
        DestroyTask(drawFadeTask);
}

BOOL IsDrawFadeTaskFinished(void)
{
    if (drawFadeTask == NULL)
        return TRUE;

    DrawFadeTask *work = TaskGetWork(drawFadeTask, DrawFadeTask);
    return (work->flags & DRAW_FADE_TASK_FLAG_FINISHED) != 0;
}
