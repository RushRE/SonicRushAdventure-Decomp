#include <seaMap/seaMapBrightnessModifier.h>
#include <seaMap/seaMapChartCourseView.h>
#include <game/graphics/renderCore.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapBrightnessModifier_Main(void);
static void SeaMapBrightnessModifier_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

Task *CreateSeaMapBrightnessModifier(SeaMapView *parent)
{
#ifdef RUSH_BUG_FIX
    Task *task =
        TaskCreate(SeaMapBrightnessModifier_Main, SeaMapBrightnessModifier_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_RENDER_LIST_END, TASK_GROUP(0), SeaMapBrightnessModifier);
#else
    // This uses 'sizeof(SeaMapChartCourseView)' instead of the correct 'sizeof(SeaMapBrightnessModifier)
#ifdef RUSH_DEBUG
    Task *task = TaskCreate_(SeaMapBrightnessModifier_Main, SeaMapBrightnessModifier_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_RENDER_LIST_END, TASK_GROUP(0),
                             sizeof(SeaMapChartCourseView), "SeaMapBrightnessModifier");
#else
    Task *task = TaskCreate_(SeaMapBrightnessModifier_Main, SeaMapBrightnessModifier_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_RENDER_LIST_END, TASK_GROUP(0),
                             sizeof(SeaMapChartCourseView));
#endif
#endif

    SeaMapBrightnessModifier *work = TaskGetWork(task, SeaMapBrightnessModifier);
    work->graphicsEngine           = parent->useEngineB;
    TaskInitWork16(work);

    MI_CpuCopy16((const void *)VRAMSystem__VRAM_PALETTE_BG[parent->useEngineB], work->originalPaletteBG, sizeof(work->originalPaletteBG));
    MI_CpuCopy16((const void *)VRAMSystem__VRAM_PALETTE_OBJ[parent->useEngineB], work->originalPaletteOBJ, sizeof(work->originalPaletteOBJ));

    VRAM_SET_PALETTE_COLOR(work->originalPaletteBG, 255, parent->paletteColor1);
    VRAM_SET_PALETTE_COLOR(work->originalPaletteOBJ, 78, parent->paletteColor1);
    VRAM_SET_PALETTE_COLOR(work->originalPaletteOBJ, 79, parent->paletteColor2);

    MI_CpuCopy16(work->originalPaletteBG, work->activePaletteBG, sizeof(work->originalPaletteBG));
    MI_CpuCopy16(work->originalPaletteOBJ, work->activePaletteOBJ, sizeof(work->originalPaletteOBJ));

    return task;
}

void DestroySeaMapBrightnessModifier(Task *task)
{
    DestroyTask(task);
}

SeaMapBrightnessModifierMode GetSeaMapBrightnessModifierMode(Task *task)
{
    SeaMapBrightnessModifier *work = TaskGetWork(task, SeaMapBrightnessModifier);
    return work->mode;
}

void SetSeaMapBrightnessModifierMode(Task *task, SeaMapBrightnessModifierMode mode)
{
    SeaMapBrightnessModifier *work = TaskGetWork(task, SeaMapBrightnessModifier);

    if (work->mode != mode)
    {
        work->timer = 0;
        work->mode  = mode;
    }
}

void SeaMapBrightnessModifier_Main(void)
{
    SeaMapBrightnessModifier *work = TaskGetWorkCurrent(SeaMapBrightnessModifier);

    DC_StoreRange(work, sizeof(*work));

    RenderCore_DMACopy(work->activePaletteBG, (const void *)VRAMSystem__VRAM_PALETTE_BG[work->graphicsEngine], 0x100 * sizeof(GXRgb));
    RenderCore_DMACopy(work->activePaletteOBJ, (const void *)VRAMSystem__VRAM_PALETTE_OBJ[work->graphicsEngine], 0xF0 * sizeof(GXRgb));

    switch (work->mode)
    {
        case SEAMAPBRIGHTNESSMODIFIER_MODE_IDLE:
            break;

        case SEAMAPBRIGHTNESSMODIFIER_MODE_DARKEN:
            DarkenColors(work->activePaletteBG, work->activePaletteBG, 0x100, 1);
            DarkenColors(work->activePaletteOBJ, work->activePaletteOBJ, 0xF0, 1);

            work->timer++;
            if (work->timer >= 8)
            {
                work->timer = 0;
                work->mode  = SEAMAPBRIGHTNESSMODIFIER_MODE_IDLE;
            }
            break;

        case SEAMAPBRIGHTNESSMODIFIER_MODE_BRIGHTEN:
            LerpColors(work->activePaletteBG, work->originalPaletteBG, work->activePaletteBG, 0x100, 1);
            LerpColors(work->activePaletteOBJ, work->originalPaletteOBJ, work->activePaletteOBJ, 0xF0, 1);

            work->timer++;
            if (work->timer > 8)
            {
                work->timer = 0;
                work->mode  = SEAMAPBRIGHTNESSMODIFIER_MODE_IDLE;
            }
            break;
    }
}

void SeaMapBrightnessModifier_Destructor(Task *task)
{
    SeaMapBrightnessModifier *work = TaskGetWork(task, SeaMapBrightnessModifier);
    UNUSED(work);
}