#include <game/graphics/screenEffect.h>
#include <game/graphics/renderCore.h>

// --------------------
// VARIABLES
// --------------------

static Task *ScreenEffectTask;

static ScreenEffectEvent const defaultScreenEvents[] = {
    {
        .color    = GX_RGBA_888(0xFF, 0xFF, 0xFF, 0xFF),
        .type     = 2,
        .duration = 2,
    },

    {
        .color    = GX_RGBA_888(0x00, 0x00, 0x00, 0x00),
        .type     = 0,
        .duration = 0,
    },
};

// --------------------
// FUNCTION DECLS
// --------------------

static void ScreenEffect_Main(void);
static void ScreenEffect_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

void CreateScreenEffect(const ScreenEffectEvent *controller)
{
    ScreenEffect *work;

    if (ScreenEffectTask != NULL)
    {
        work = TaskGetWork(ScreenEffectTask, ScreenEffect);
    }
    else
    {
        Task *task = TaskCreate(ScreenEffect_Main, ScreenEffect_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3E00, TASK_GROUP(3), ScreenEffect);
        if (task == HeapNull)
            return;

        ScreenEffectTask = task;
        work                 = TaskGetWork(task, ScreenEffect);
        TaskInitWork16(work);

        work->visiblePlane[0] = GX_GetVisiblePlane();
        work->visiblePlane[1] = GXS_GetVisiblePlane();
    }

    if (controller != NULL)
        work->controller = controller;
    else
        work->controller = defaultScreenEvents;

    work->timer                              = work->controller->duration;
    *((u16 *)VRAMSystem__VRAM_PALETTE_BG[0]) = work->controller->color;
    *((u16 *)VRAMSystem__VRAM_PALETTE_BG[1]) = work->controller->color;

    GX_SetVisiblePlane(GX_PLANEMASK_OBJ);
    GXS_SetVisiblePlane(GX_PLANEMASK_OBJ);
}

void ScreenEffect_Main(void)
{
    ScreenEffect *work = TaskGetWorkCurrent(ScreenEffect);

    work->timer--;
    if (!work->timer)
    {
        work->controller++;
        work->timer                              = work->controller->duration;
        *((u16 *)VRAMSystem__VRAM_PALETTE_BG[0]) = work->controller->color;
        *((u16 *)VRAMSystem__VRAM_PALETTE_BG[1]) = work->controller->color;

        if (work->controller->type != 0 && work->timer != 0)
        {
            GX_SetVisiblePlane(GX_PLANEMASK_OBJ);
            GXS_SetVisiblePlane(GX_PLANEMASK_OBJ);
        }
        else
        {
            GX_SetVisiblePlane(work->visiblePlane[0]);
            GXS_SetVisiblePlane(work->visiblePlane[1]);
        }

        if (work->timer == 0)
            DestroyCurrentTask();
    }
}

void ScreenEffect_Destructor(Task *task)
{
    ScreenEffect *work = TaskGetWork(task, ScreenEffect);

    GX_SetVisiblePlane(work->visiblePlane[0]);
    GXS_SetVisiblePlane(work->visiblePlane[1]);

    ScreenEffectTask = NULL;
}