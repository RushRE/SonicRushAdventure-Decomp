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
    // BUG: this uses 'sizeof(SeaMapChartCourseView)' instead of the correct 'sizeof(SeaMapPenPalette)
    Task *task = TaskCreate_(SeaMapPenPalette_Main, SeaMapPenPalette_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_RENDER_LIST_END, TASK_GROUP(0), sizeof(SeaMapChartCourseView));

    SeaMapPenPalette *work = TaskGetWork(task, SeaMapPenPalette);
    work->useEngineB       = parent->useEngineB;
    TaskInitWork16(work);

    MIi_CpuCopy16((const void *)VRAMSystem__VRAM_PALETTE_BG[parent->useEngineB], work->palette1, sizeof(work->palette1));
    MIi_CpuCopy16((const void *)VRAMSystem__VRAM_PALETTE_OBJ[parent->useEngineB], work->palette2, sizeof(work->palette2));

    work->palette1[255] = parent->paletteColor1;
    work->palette2[78]  = parent->paletteColor1;
    work->palette2[79]  = parent->paletteColor2;

    MIi_CpuCopy16(work->palette1, work->paletteStore1, sizeof(work->palette1));
    MIi_CpuCopy16(work->palette2, work->paletteStore2, sizeof(work->palette2));

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

    RenderCore_DMACopy(work->paletteStore1, (const void *)VRAMSystem__VRAM_PALETTE_BG[work->useEngineB], 0x100 * sizeof(GXRgb));
    RenderCore_DMACopy(work->paletteStore2, (const void *)VRAMSystem__VRAM_PALETTE_OBJ[work->useEngineB], 0xF0 * sizeof(GXRgb));

    switch (work->mode)
    {
        case 0:
            break;

        case 1:
            DarkenColors(work->paletteStore1, work->paletteStore1, 0x100, 1);
            DarkenColors(work->paletteStore2, work->paletteStore2, 0xF0, 1);

            work->timer++;
            if (work->timer >= 8)
            {
                work->timer = 0;
                work->mode  = 0;
            }
            break;

        case 2:
            LerpColors(work->paletteStore1, work->palette1, work->paletteStore1, 0x100, 1);
            LerpColors(work->paletteStore2, work->palette2, work->paletteStore2, 0xF0, 1);

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