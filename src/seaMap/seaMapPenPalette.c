#include <seaMap/seaMapPenPalette.h>
#include <seaMap/seaMapChartCourseView.h>
#include <game/graphics/renderCore.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapPenPalette_Main(void);
static void SeaMapPenPalette_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

Task *CreateSeaMapPenPalette(SeaMapView *parent)
{
#ifdef RUSH_BUG_FIX
    Task *task = TaskCreate(SeaMapPenPalette_Main, SeaMapPenPalette_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_RENDER_LIST_END, TASK_GROUP(0), SeaMapPenPalette);
#else
    // This uses 'sizeof(SeaMapChartCourseView)' instead of the correct 'sizeof(SeaMapPenPalette)
#ifdef RUSH_DEBUG
    Task *task = TaskCreate_(SeaMapPenPalette_Main, SeaMapPenPalette_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_RENDER_LIST_END, TASK_GROUP(0), sizeof(SeaMapChartCourseView),
                             "SeaMapPenPalette");
#else
    Task *task = TaskCreate_(SeaMapPenPalette_Main, SeaMapPenPalette_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_RENDER_LIST_END, TASK_GROUP(0), sizeof(SeaMapChartCourseView));
#endif
#endif

    SeaMapPenPalette *work = TaskGetWork(task, SeaMapPenPalette);
    work->useEngineB       = parent->useEngineB;
    TaskInitWork16(work);

    MI_CpuCopy16((const void *)VRAMSystem__VRAM_PALETTE_BG[parent->useEngineB], work->paletteBG, sizeof(work->paletteBG));
    MI_CpuCopy16((const void *)VRAMSystem__VRAM_PALETTE_OBJ[parent->useEngineB], work->paletteOBJ, sizeof(work->paletteOBJ));

    VRAM_SET_PALETTE_COLOR(work->paletteBG, 255, parent->paletteColor1);
    VRAM_SET_PALETTE_COLOR(work->paletteOBJ, 78, parent->paletteColor1);
    VRAM_SET_PALETTE_COLOR(work->paletteOBJ, 79, parent->paletteColor2);

    MI_CpuCopy16(work->paletteBG, work->paletteStoreBG, sizeof(work->paletteBG));
    MI_CpuCopy16(work->paletteOBJ, work->paletteStoreOBJ, sizeof(work->paletteOBJ));

    return task;
}

void DestroySeaMapPenPalette(Task *task)
{
    DestroyTask(task);
}

u32 GetSeaMapPenPaletteMode(Task *task)
{
    SeaMapPenPalette *work = TaskGetWork(task, SeaMapPenPalette);
    return work->mode;
}

void SetSeaMapPenPaletteMode(Task *task, u32 mode)
{
    SeaMapPenPalette *work = TaskGetWork(task, SeaMapPenPalette);

    if (work->mode != mode)
    {
        work->timer = 0;
        work->mode  = mode;
    }
}

void SeaMapPenPalette_Main(void)
{
    SeaMapPenPalette *work = TaskGetWorkCurrent(SeaMapPenPalette);

    DC_StoreRange(work, sizeof(*work));

    RenderCore_DMACopy(work->paletteStoreBG, (const void *)VRAMSystem__VRAM_PALETTE_BG[work->useEngineB], 0x100 * sizeof(GXRgb));
    RenderCore_DMACopy(work->paletteStoreOBJ, (const void *)VRAMSystem__VRAM_PALETTE_OBJ[work->useEngineB], 0xF0 * sizeof(GXRgb));

    switch (work->mode)
    {
        case 0:
            break;

        case 1:
            DarkenColors(work->paletteStoreBG, work->paletteStoreBG, 0x100, 1);
            DarkenColors(work->paletteStoreOBJ, work->paletteStoreOBJ, 0xF0, 1);

            work->timer++;
            if (work->timer >= 8)
            {
                work->timer = 0;
                work->mode  = 0;
            }
            break;

        case 2:
            LerpColors(work->paletteStoreBG, work->paletteBG, work->paletteStoreBG, 0x100, 1);
            LerpColors(work->paletteStoreOBJ, work->paletteOBJ, work->paletteStoreOBJ, 0xF0, 1);

            work->timer++;
            if (work->timer > 8)
            {
                work->timer = 0;
                work->mode  = 0;
            }
            break;
    }
}

void SeaMapPenPalette_Destructor(Task *task)
{
    SeaMapPenPalette *work = TaskGetWork(task, SeaMapPenPalette);
    UNUSED(work);
}