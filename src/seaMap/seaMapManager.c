#include <seaMap/seaMapManager.h>
#include <seaMap/seaMapEventTrigger.h>
#include <seaMap/seaMapCollision.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>
#include <game/file/binaryBundle.h>

// resources
#include <resources/bb/ch.h>
#include <resources/bb/ch/lvl.h>
#include <resources/bb/ch/map_jet.h>
#include <resources/bb/ch/map_sailer.h>
#include <resources/bb/ch/map_hover.h>
#include <resources/bb/ch/map_submarine.h>
#include <resources/bb/ch/map_menu.h>

// --------------------
// ENUMS
// --------------------

enum FileList_ArchiveMAP_Common
{
    ARCHIVE_MAP_CMN_FILE_CH_MAP_MASK_NEAR_BBG,
    ARCHIVE_MAP_CMN_FILE_CH_MAP_ISLAND_NEAR_BBG,
    ARCHIVE_MAP_CMN_FILE_CH_MAP_SEA_NEAR_BBG,
    ARCHIVE_MAP_CMN_FILE_CH_MAP_MASK_MID_BBG,
    ARCHIVE_MAP_CMN_FILE_CH_MAP_ISLAND_MID_BBG,
    ARCHIVE_MAP_CMN_FILE_CH_MAP_SEA_MID_BBG,
    ARCHIVE_MAP_CMN_FILE_CH_MAP_MASK_FAR_BBG,
    ARCHIVE_MAP_CMN_FILE_CH_MAP_ISLAND_FAR_BBG,
    ARCHIVE_MAP_CMN_FILE_CH_MAP_SEA_FAR_BBG,
    ARCHIVE_MAP_CMN_FILE_CH_MAP_COL_CHCL,
};

// --------------------
// VARIABLES
// --------------------

struct SeaMapManager__StaticVars
{
    Task *singleton;
    void *archiveCH;
    s32 field_8;
    s32 field_C;
    void *archiveSeaMap;
};

// --------------------
// VARIABLES
// --------------------

static struct SeaMapManager__StaticVars SeaMapManager__sVars;

NOT_DECOMPILED const fx32 SeaMapManager__ZoomOutScaleTable[SEAMAP_ZOOM_COUNT];
NOT_DECOMPILED const fx32 SeaMapManager__ZoomInScaleTable[SEAMAP_ZOOM_COUNT];
NOT_DECOMPILED const u32 _0210FB34[];
NOT_DECOMPILED const u32 dword_210FB40[];

// FORCE_INCLUDE_ARRAY(u16, sSeaMapManagerUnknown, 6, {0x600, 0x240, 0x300, 0x120, 0x200, 0xC0})

// --------------------
// FUNCTIONS
// --------------------

void SeaMapManager__SaveClearCallback_Chart(SaveGame *save, SaveBlockFlags blockFlags)
{
    if ((blockFlags & SAVE_BLOCK_FLAG_CHART) != 0)
    {
        SeaMapManager__ClearSeaMap(save->chart.map);
        SeaMapManager__ClearSaveFlags(save->chart.flags);
    }
}

void SeaMapManager__Create(BOOL useEngineB, ShipType shipType, BOOL isSailing)
{
    SeaMapManager__InitArchives(shipType, isSailing);
    InitSeaMapEventTriggerSystem();

    SeaMapManager__sVars.singleton =
        TaskCreate(SeaMapManager__Main, SeaMapManager__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x100, TASK_GROUP(0), SeaMapManager);

    SeaMapManager *work = TaskGetWork(SeaMapManager__sVars.singleton, SeaMapManager);
    TaskInitWork16(work);

    work->unknownPtr = HeapAllocHead(HEAP_USER, sizeof(SeaMapManagerUnknown));
    MI_CpuClear16(work->unknownPtr, sizeof(SeaMapManagerUnknown));

    work->useEngineB = useEngineB;
    work->zoomLevel  = 0;
    work->state      = SeaMapManager__State_2044DC8;
    work->shipType   = shipType;

    TouchField__Init(&work->touchField);
    work->touchField.mode           = FALSE;
    work->touchField.rectSize2      = 0;
    work->touchField.delayDuration1 = 0;

    SeaMapManager__LoadAssets(&work->assets);
    SeaMapManager__InitBackgrounds(work);
    SeaMapManager__EnableTouchField(TRUE);
    SeaMapManager__SetupDisplay(useEngineB);
    SeaMapManager__LoadBackgroundPixels(work);
    SeaMapManager__LoadBackgroundPalette(work);
    if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_14)
        SeaMapCollision__UpdateMapCollision();
    SeaMapManager__EnableDrawFlags(SEAMAPMANAGER_DRAWFLAG_ALL);
}

void SeaMapManager__Destroy(void)
{
    SeaMapManager__Release();

    if (SeaMapManager__IsActive())
    {
        ReleaseSeaMapEventTriggerSystem();
        DestroyTask(SeaMapManager__sVars.singleton);
    }
}

BOOL SeaMapManager__IsActive(void)
{
    return SeaMapManager__sVars.singleton != NULL;
}

SeaMapManager *SeaMapManager__GetWork(void)
{
    return TaskGetWork(SeaMapManager__sVars.singleton, SeaMapManager);
}

void SeaMapManager__EnableTouchField(BOOL enabled)
{
    SeaMapManager *work = SeaMapManager__GetWork();

    work->touchFieldActive = enabled;
}

void SeaMapManager__EnableDrawFlags(SeaMapManagerDrawFlags flags)
{
    SeaMapManager *work = SeaMapManager__GetWork();

    work->drawFlags |= flags;
}

void SeaMapManager__SetZoomLevel(SeaMapZoomLevel level)
{
    SeaMapManager *work = SeaMapManager__GetWork();

    work->zoomLevel = level;

    SeaMapManager__InitBackgrounds(work);
    SeaMapManager__LoadBackgroundPixels(work);
    SeaMapManager__LoadBackgroundPalette(work);
}

SeaMapZoomLevel SeaMapManager__GetZoomLevel(void)
{
    SeaMapManager *work = SeaMapManager__GetWork();

    return work->zoomLevel;
}

fx32 SeaMapManager__GetZoomOutScale(void)
{
    SeaMapManager *work = SeaMapManager__GetWork();

    return SeaMapManager__ZoomOutScaleTable[work->zoomLevel];
}

fx32 SeaMapManager__GetZoomInScale(void)
{
    SeaMapManager *work = SeaMapManager__GetWork();

    return SeaMapManager__ZoomInScaleTable[work->zoomLevel];
}

void SeaMapManager__Draw(SeaMapManager *work)
{
    if ((work->drawFlags & SEAMAPMANAGER_DRAWFLAG_MAPMASK) != 0)
        SeaMapManager__Draw_MapMask(work);

    if ((work->drawFlags & SEAMAPMANAGER_DRAWFLAG_MAPISLAND) != 0)
        SeaMapManager__Draw_MapIsland(work);

    if ((work->drawFlags & SEAMAPMANAGER_DRAWFLAG_MAPSEA) != 0)
        SeaMapManager__Draw_MapSea(work);

    if ((work->drawFlags & SEAMAPMANAGER_DRAWFLAG_UNKNOWN) != 0)
        SeaMapManager__Draw_Unknown(work);
}

void SeaMapManager__Draw_MapMask(SeaMapManager *work)
{
    fx32 zoomScale = SeaMapManager__GetZoomOutScale();

    work->backgrounds.mapMask.position.x = FX32_TO_WHOLE(MultiplyFX(zoomScale, work->position.x));
    work->backgrounds.mapMask.position.y = FX32_TO_WHOLE(MultiplyFX(zoomScale, work->position.y));

    DrawBackground(&work->backgrounds.mapMask);
}

void SeaMapManager__Draw_MapIsland(SeaMapManager *work)
{
    fx32 zoomScale = SeaMapManager__GetZoomOutScale();

    work->backgrounds.mapIsland.position.x = FX32_TO_WHOLE(MultiplyFX(zoomScale, work->position.x));
    work->backgrounds.mapIsland.position.y = FX32_TO_WHOLE(MultiplyFX(zoomScale, work->position.y));

    DrawBackground(&work->backgrounds.mapIsland);
}

void SeaMapManager__Draw_MapSea(SeaMapManager *work)
{
    fx32 zoomScale = SeaMapManager__GetZoomOutScale();

    work->backgrounds.mapSea.position.x = FX32_TO_WHOLE(MultiplyFX(zoomScale, work->position.x));
    work->backgrounds.mapSea.position.y = FX32_TO_WHOLE(MultiplyFX(zoomScale, work->position.y));

    DrawBackground(&work->backgrounds.mapSea);
}

void SeaMapManager__Draw_Unknown(SeaMapManager *work)
{
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    fx32 zoomScale = SeaMapManager__GetZoomOutScale();

    u16 y;
    u16 x;
    SeaMapManager__Func_2043B28(MultiplyFX(zoomScale, work->position.x), MultiplyFX(zoomScale, work->position.y), &x, &y);
    SeaMapManager__Func_2044F24(x, y);

    DC_StoreRange(unknown->pixelBuffer, sizeof(unknown->pixelBuffer));

    int baseBlock = 0x4000 * 6;
    QueueUncompressedPixels(unknown->pixelBuffer, sizeof(unknown->pixelBuffer), PIXEL_MODE_SPRITE, ((void *)VRAMSystem__VRAM_BG[work->useEngineB] + baseBlock));
}

void SeaMapManager__Func_2043974(fx32 x, fx32 y)
{
    SeaMapManager *work = SeaMapManager__GetWork();

    SeaMapManager__Func_2043C08(x, y, &work->position.x, &work->position.y);
}

fx32 SeaMapManager__GetXPos(void)
{
    SeaMapManager *work = SeaMapManager__GetWork();

    return work->position.x;
}

fx32 SeaMapManager__GetYPos(void)
{
    SeaMapManager *work = SeaMapManager__GetWork();

    return work->position.y;
}

void SeaMapManager__GetPosition(fx32 inX, fx32 inY, fx32 *x, fx32 *y)
{
    SeaMapManager *work = SeaMapManager__GetWork();
    fx32 zoomScale      = SeaMapManager__GetZoomInScale();

    if (x)
        *x = work->position.x + zoomScale * inX;

    if (y)
        *y = work->position.y + zoomScale * inY;
}

void SeaMapManager__Func_2043A04(fx32 inX, fx32 inY, fx16 *x, fx16 *y)
{
    SeaMapManager *work = SeaMapManager__GetWork();
    fx32 zoomScale      = SeaMapManager__GetZoomOutScale();

    if (x)
        *x = FX32_TO_WHOLE(MultiplyFX((inX - work->position.x), zoomScale));

    if (y)
        *y = FX32_TO_WHOLE(MultiplyFX((inY - work->position.y), zoomScale));
}

void SeaMapManager__ConvertWorldPosToMapPos(fx32 inX, fx32 inY, fx16 *x, fx16 *y)
{
    if (x)
        *x = inX >> 15;

    if (y)
        *y = inY >> 15;
}

void SeaMapManager__Func_2043A9C(fx32 inX, fx32 inY, fx16 *x, fx16 *y)
{
    fx32 posX;
    fx32 posY;

    SeaMapManager__GetPosition(inX, inY, &posX, &posY);
    SeaMapManager__Func_2043B28(posX, posY, x, y);
}

void SeaMapManager__Func_2043AD4(fx32 inX, fx32 inY, fx16 *x, fx16 *y)
{
    fx32 posX;
    fx32 posY;

    SeaMapManager__GetPosition2(inX, inY, &posX, &posY);
    SeaMapManager__Func_2043A04(posX, posY, x, y);
}

void SeaMapManager__Func_2043B0C(fx32 inX, fx32 inY, fx16 *x, fx16 *y)
{
    if (x)
        *x = inX >> 2;

    if (y)
        *y = inY >> 2;
}

void SeaMapManager__Func_2043B28(fx32 inX, fx32 inY, fx16 *x, fx16 *y)
{
    if (x)
        *x = inX >> 13;

    if (y)
        *y = inY >> 13;
}

void SeaMapManager__GetPosition2(fx32 inX, fx32 inY, fx32 *x, fx32 *y)
{
    if (x)
        *x = inX << 13;

    if (y)
        *y = inY << 13;
}

void SeaMapManager__Func_2043B60(fx32 inX, fx32 inY, fx16 *x, fx16 *y)
{
    if (x)
        *x = inX >> 12;

    if (y)
        *y = inY >> 12;
}

void SeaMapManager__Func_2043B7C(u8 inX, u8 inY, fx16 *x, fx16 *y)
{
    fx32 posX;
    fx32 posY;

    SeaMapManager__GetPosition(inX, inY, &posX, &posY);
    SeaMapManager__Func_2043B60(posX, posY, x, y);
}

void SeaMapManager__Func_2043BB4(fx32 inX, fx32 inY, fx16 *x, fx16 *y)
{
    if (x)
        *x = inX << 1;

    if (y)
        *y = inY << 1;
}

void SeaMapManager__Func_2043BD0(fx32 inX, fx32 inY, fx16 *x, fx16 *y)
{
    if (x)
        *x = inX >> 1;

    if (y)
        *y = inY >> 1;
}

void SeaMapManager__Func_2043BEC(fx32 inX, fx32 inY, fx16 *x, fx16 *y)
{
    if (x)
        *x = inX >> 3;

    if (y)
        *y = inY >> 3;
}

void SeaMapManager__Func_2043C08(fx32 inX, fx32 inY, fx32 *x, fx32 *y)
{
    fx32 screenX = FX32_FROM_WHOLE(0x600) - (HW_LCD_WIDTH * SeaMapManager__GetZoomInScale());
    fx32 screenY = FX32_FROM_WHOLE(0x240) - (HW_LCD_HEIGHT * SeaMapManager__GetZoomInScale());

    // Another variant of 'inX = MTM_MATH_CLIP(inX, 0, screenX)'
    if (inX < 0)
        inX = 0;
    else if (screenX < inX)
        inX = screenX;

    // Another variant of 'inY = MTM_MATH_CLIP(inY, 0, screenY)'
    if (inY < 0)
        inY = 0;
    else if (screenY < inY)
        inY = screenY;

    *x = inX;
    *y = inY;
}

void SeaMapManager__ClearSaveFlags(u8 *chartFlags)
{
    MI_CpuClear32(chartFlags, sizeof(((SaveBlockChart *)0)->flags));
}

BOOL SeaMapManager__GetSaveFlag_(SeaMapManagerMapFlags *chartFlags, s32 id)
{
    return chartFlags->values[id >> 3] & (1 << (id & 7));
}

BOOL SeaMapManager__GetSaveFlag(SeaMapManagerSaveFlag id)
{
    SeaMapManagerMapFlags *chartFlags = SeaMapManager__GetSaveBlockFlags();
    return SeaMapManager__GetSaveFlag_(chartFlags, id);
}

void SeaMapManager__SetSaveFlag_(SeaMapManagerMapFlags *chartFlags, s32 id, BOOL state)
{
    if (state)
        chartFlags->values[id >> 3] |= 1 << (id & 7);
    else
        chartFlags->values[id >> 3] &= ~(1 << (id & 7));
}

void SeaMapManager__SetSaveFlag(SeaMapManagerSaveFlag id, BOOL state)
{
    SeaMapManagerMapFlags *chartFlags = SeaMapManager__GetSaveBlockFlags();
    SeaMapManager__SetSaveFlag_(chartFlags, id, state);
}

NONMATCH_FUNC void SeaMapManager__LoadMapBackground(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x16c]
	bl GetBackgroundMappings
	mov r8, #0
	mov r6, r0
	add r7, r6, #4
	mov r4, r8
	mov r5, r8
_02043D30:
	mov r9, r5
_02043D34:
	mov r0, r9
	mov r1, r8
	bl SeaMapManager__GetMapPixel
	cmp r0, #0
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	streqh r4, [r7]
	mov r9, r0, lsr #0x10
	cmp r9, #0xc0
	add r7, r7, #2
	blo _02043D34
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #0x48
	blo _02043D30
	add r0, r6, #4
	mov r1, #0x6c00
	bl DC_StoreRange
	ldr r0, =SeaMapManager__sVars
	ldr r0, [r0, #0xc]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x170]
	bl GetBackgroundMappings
	str r0, [sp]
	add r5, r0, #4
	mov r6, #0
_02043DAC:
	bic r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, #0x18
	mul r4, r1, r0
	mov r7, #0
	mov r8, r7
	mov r9, #1
_02043DCC:
	bl SeaMapManager__GetSaveMap
	bic r1, r7, #1
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	add r1, r2, #1
	add r3, r0, r4
	mov ip, r2, asr #5
	mov r0, r1, asr #5
	add r10, r3, ip, lsl #2
	add r11, r3, r0, lsl #2
	ldr r10, [r10, #0x18]
	and r2, r2, #0x1f
	ldr ip, [r3, ip, lsl #2]
	and r10, r10, r9, lsl r2
	ldr r0, [r3, r0, lsl #2]
	and r1, r1, #0x1f
	ldr r11, [r11, #0x18]
	and r2, ip, r9, lsl r2
	and r0, r0, r9, lsl r1
	orr r0, r2, r0
	and r11, r11, r9, lsl r1
	orr r0, r10, r0
	orrs r0, r11, r0
	add r0, r7, #2
	mov r0, r0, lsl #0x10
	streqh r8, [r5]
	mov r7, r0, lsr #0x10
	cmp r7, #0xc0
	add r5, r5, #2
	blo _02043DCC
	add r0, r6, #2
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0x48
	blo _02043DAC
	ldr r0, [sp]
	mov r1, #0x1b00
	add r0, r0, #4
	bl DC_StoreRange
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x174]
	bl GetBackgroundMappings
	str r0, [sp, #4]
	add r5, r0, #4
	mov r11, #0
_02043E80:
	mov r6, #0
	mov r4, #1
_02043E88:
	bl SeaMapManager__GetSaveMap
	mov r8, r0
	mov r0, r6
	mov r1, #3
	bl FX_DivS32
	add r0, r0, r0, lsl #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r0, r11
	mov r1, #3
	bl FX_DivS32
	add r0, r0, r0, lsl #1
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, #0x18
	mla r10, r1, r0, r8
	add r1, r7, #2
	mov r2, r1, asr #5
	add r3, r10, r2, lsl #2
	add r0, r7, #1
	mov lr, r0, asr #5
	mov ip, r7, asr #5
	and r9, r7, #0x1f
	ldr r7, [r3, #0x30]
	and r1, r1, #0x1f
	ldr r3, [r3, #0x18]
	ldr r2, [r10, r2, lsl #2]
	and r8, r7, r4, lsl r1
	and r3, r3, r4, lsl r1
	and r1, r2, r4, lsl r1
	add r2, r10, lr, lsl #2
	ldr r7, [r2, #0x30]
	and r0, r0, #0x1f
	ldr r2, [r2, #0x18]
	ldr lr, [r10, lr, lsl #2]
	and r7, r7, r4, lsl r0
	and r2, r2, r4, lsl r0
	and r0, lr, r4, lsl r0
	add lr, r10, ip, lsl #2
	ldr r10, [r10, ip, lsl #2]
	ldr ip, [lr, #0x30]
	ldr lr, [lr, #0x18]
	and ip, ip, r4, lsl r9
	and lr, lr, r4, lsl r9
	and r9, r10, r4, lsl r9
	orr r0, r9, r0
	orr r0, r1, r0
	orr r0, lr, r0
	orr r0, r2, r0
	orr r0, r3, r0
	orr r0, ip, r0
	orr r0, r7, r0
	orrs r0, r8, r0
	moveq r0, #0
	streqh r0, [r5]
	add r0, r6, #3
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0xc0
	add r5, r5, #2
	blo _02043E88
	add r0, r11, #3
	mov r0, r0, lsl #0x10
	mov r11, r0, lsr #0x10
	cmp r11, #0x48
	blo _02043E80
	ldr r0, [sp, #4]
	mov r1, #0xc00
	add r0, r0, #4
	bl DC_StoreRange
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

SeaMapManagerMapPixel SeaMapManager__GetMapPixel(u16 x, u16 y)
{
    SeaMapManagerMapLayout *map = SeaMapManager__GetSaveMap();

    return map->layout[y][x >> 5] & (1 << (x & 0x1F));
}

NONMATCH_FUNC void SeaMapManager__DiscoverMap_Pixel(s32 x, s32 y)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r6, r0
	mov r5, r1
	cmp r6, #0xc0
	cmplo r5, #0x48
	addhs sp, sp, #8
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SeaMapManager__GetSaveMap
	mov r1, #0x18
	mla r4, r5, r1, r0
	mov r3, r6, asr #5
	ldr r1, [r4, r3, lsl #2]
	and r0, r6, #0x1f
	mov r2, #1
	tst r1, r2, lsl r0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mvn r0, r2, lsl r0
	and r0, r1, r0
	str r0, [r4, r3, lsl #2]
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x16c]
	bl GetBackgroundMappings
	mov r1, #0xc0
	mla r1, r5, r1, r6
	add r4, r0, #4
	mov r3, r1, lsl #1
	mov r2, #0
	add r0, r4, r1, lsl #1
	mov r1, #2
	strh r2, [r4, r3]
	bl DC_StoreRange
	ldr r0, =SeaMapManager__sVars
	ldr r0, [r0, #0xc]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SeaMapManager__GetSaveMap
	bic r1, r5, #1
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	mov r4, #0x18
	add r7, r2, #1
	bic r1, r6, #1
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	add r10, r3, #1
	mla r1, r2, r4, r0
	mov r2, r10, asr #5
	mla r9, r7, r4, r0
	mov r8, r3, asr #5
	ldr r7, [r1, r8, lsl #2]
	ldr r4, [r1, r2, lsl #2]
	and r0, r10, #0x1f
	mov r1, #1
	and r10, r3, #0x1f
	ldr r8, [r9, r8, lsl #2]
	ldr r9, [r9, r2, lsl #2]
	and r3, r7, r1, lsl r10
	and r2, r4, r1, lsl r0
	and r4, r8, r1, lsl r10
	orr r2, r3, r2
	and r1, r9, r1, lsl r0
	orr r0, r4, r2
	orrs r0, r1, r0
	bne _02044120
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x170]
	bl GetBackgroundMappings
	mov r2, r5, asr #1
	mov r1, #0x60
	mul r1, r2, r1
	add r1, r1, r6, asr #1
	add r4, r0, #4
	mov r3, r1, lsl #1
	mov r2, #0
	add r0, r4, r1, lsl #1
	mov r1, #2
	strh r2, [r4, r3]
	bl DC_StoreRange
_02044120:
	bl SeaMapManager__GetSaveMap
	mov r7, r0
	mov r0, r6
	mov r1, #3
	bl FX_DivS32
	add r0, r0, r0, lsl #1
	mov r2, r0, lsl #0x10
	mov r0, r5
	mov r1, #3
	mov r4, r2, lsr #0x10
	bl FX_DivS32
	add r0, r0, r0, lsl #1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r1, #0x18
	add lr, r4, #2
	add r2, r3, #1
	add r8, r3, #2
	mla r0, r3, r1, r7
	mla r3, r2, r1, r7
	mla r2, r8, r1, r7
	add r9, r4, #1
	mov r1, r9, asr #5
	ldr r11, [r2, r1, lsl #2]
	and r9, r9, #0x1f
	mov r10, #1
	and r11, r11, r10, lsl r9
	mov ip, lr, asr #5
	str r11, [sp, #4]
	mov r8, r4, asr #5
	and r7, r4, #0x1f
	and r4, lr, #0x1f
	ldr lr, [r2, ip, lsl #2]
	ldr r2, [r2, r8, lsl #2]
	and lr, lr, r10, lsl r4
	ldr r11, [r3, ip, lsl #2]
	str lr, [sp]
	and lr, r11, r10, lsl r4
	ldr r11, [r0, ip, lsl #2]
	ldr ip, [r3, r1, lsl #2]
	ldr r3, [r3, r8, lsl #2]
	ldr r1, [r0, r1, lsl #2]
	ldr r8, [r0, r8, lsl #2]
	and r0, r3, r10, lsl r7
	and r4, r11, r10, lsl r4
	and r3, r8, r10, lsl r7
	and r1, r1, r10, lsl r9
	orr r1, r3, r1
	orr r1, r4, r1
	and r11, ip, r10, lsl r9
	orr r0, r0, r1
	orr r0, r11, r0
	and r2, r2, r10, lsl r7
	orr r0, lr, r0
	orr r1, r2, r0
	ldr r0, [sp, #4]
	orr r1, r0, r1
	ldr r0, [sp]
	orrs r0, r0, r1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x174]
	bl GetBackgroundMappings
	add r7, r0, #4
	mov r0, r6
	mov r1, #3
	bl FX_DivS32
	mov r4, r0
	mov r0, r5
	mov r1, #3
	bl FX_DivS32
	add r0, r4, r0, lsl #6
	mov r3, r0, lsl #1
	mov r2, #0
	add r0, r7, r0, lsl #1
	mov r1, #2
	strh r2, [r7, r3]
	bl DC_StoreRange
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void SeaMapManager__DiscoverMap_Rect(u16 left, u16 top, u16 right, u16 bottom)
{
    for (u16 y = top; y < bottom; y++)
    {
        for (u16 x = left; x < right; x++)
        {
            SeaMapManager__DiscoverMap_Pixel(x, y);
        }
    }
}

NONMATCH_FUNC void SeaMapManager__DiscoverMap_Elipse(u16 centerX, u16 centerY, u16 radiusX, u16 radiusY)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	str r0, [sp]
	mov r10, r3
	str r1, [sp, #4]
	mov r1, r10
	mov r0, r2, lsl #0xc
	bl FX_DivS32
	rsb r1, r10, #0
	mul r1, r0, r1
	mul r2, r0, r10
	str r0, [sp, #0x18]
	ldr r0, [sp]
	mov r11, #0
	add r0, r0, r1, asr #12
	mov r1, r0, lsl #0x10
	ldr r0, [sp]
	mov r4, r1, asr #0x10
	add r0, r0, r2, asr #12
	mov r2, r10, lsl #1
	mov r6, r0, lsl #0x10
	cmp r4, r6, asr #16
	rsb r5, r2, #2
	bgt _0204434C
_02044328:
	mov r0, r4, lsl #0x10
	ldr r1, [sp, #4]
	mov r0, r0, lsr #0x10
	bl SeaMapManager__DiscoverMap_Pixel
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	cmp r4, r6, asr #16
	ble _02044328
_0204434C:
	ldr r0, [sp, #4]
	add r0, r10, r0
	mov r1, r0, lsl #0x10
	str r0, [sp, #8]
	ldr r0, [sp]
	mov r1, r1, lsr #0x10
	bl SeaMapManager__DiscoverMap_Pixel
	ldr r0, [sp, #4]
	sub r0, r0, r10
	mov r1, r0, lsl #0x10
	ldr r0, [sp]
	mov r1, r1, lsr #0x10
	bl SeaMapManager__DiscoverMap_Pixel
	mov r0, r10, lsl #1
	str r0, [sp, #0x14]
	mov r0, #1
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0xc]
_02044398:
	rsb r0, r10, #0
	cmp r5, r0
	ble _020443C8
	ldr r0, [sp, #0x14]
	sub r10, r10, #1
	sub r0, r0, #2
	rsb r1, r0, #1
	str r0, [sp, #0x14]
	ldr r0, [sp, #8]
	add r5, r5, r1
	sub r0, r0, #1
	str r0, [sp, #8]
_020443C8:
	cmp r5, r11
	bgt _020443F8
	ldr r0, [sp, #0x10]
	ldr r1, [sp, #0xc]
	add r0, r0, #2
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x18]
	add r11, r11, #1
	add r0, r1, r0
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x10]
	add r5, r5, r0
_020443F8:
	cmp r10, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x18]
	rsb r1, r11, #0
	mul r1, r0, r1
	ldr r0, [sp]
	add r0, r0, r1, asr #12
	mov r2, r0, lsl #0x10
	ldr r1, [sp]
	ldr r0, [sp, #0xc]
	mov r9, r2, asr #0x10
	add r3, r1, r0, asr #12
	ldr r0, [sp, #4]
	mov r4, r3, lsl #0x10
	sub r1, r0, r10
	ldr r0, [sp, #8]
	cmp r9, r4, asr #16
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	mov r0, r1, lsl #0x10
	mov r1, r0, asr #0x10
	bgt _02044398
	mov r0, r2, lsl #0x10
	mov r6, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	mov r7, r0, lsr #0x10
_02044464:
	mov r0, r9, lsl #0x10
	mov r8, r0, lsr #0x10
	mov r0, r8
	mov r1, r6
	bl SeaMapManager__DiscoverMap_Pixel
	mov r0, r8
	mov r1, r7
	bl SeaMapManager__DiscoverMap_Pixel
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, asr #0x10
	cmp r9, r4, asr #16
	ble _02044464
	b _02044398
_204449C: // 0x0204449C
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void SeaMapManager__ClearGlobalNodeList(void)
{
    ReleaseSeaMapManagerNodeList(&gameState.seaMapNodeList);
}

void SeaMapManager__UpdateGlobalNodeList(void)
{
    SeaMapManager *work           = SeaMapManager__GetWork();
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    SeaMapManagerNodeList *localNodeList  = &unknown->nodeList;
    SeaMapManagerNodeList *globalNodeList = &GetGameState()->seaMapNodeList;

    ReleaseSeaMapManagerNodeList(globalNodeList);
    SeaMapManagerNodeList_CopyList(localNodeList, globalNodeList);
}

void SeaMapManager__LoadNodeList(void)
{
    SeaMapManager *work           = SeaMapManager__GetWork();
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    SeaMapManagerNodeList *localNodeList  = &unknown->nodeList;
    SeaMapManagerNodeList *globalNodeList = &GetGameState()->seaMapNodeList;

    ReleaseSeaMapManagerNodeList(localNodeList);
    SeaMapManagerNodeList_CopyList(globalNodeList, localNodeList);
}

void SeaMapManager__SetUnknown1(s32 a1)
{
    SeaMapManager__sVars.field_8 = a1;
}

s32 SeaMapManager__GetUnknown1(void)
{
    return SeaMapManager__sVars.field_8;
}

void SeaMapManager__ClearSeaMap(void *chartMap)
{
    MI_CpuFill32(chartMap, 0xFFFFFFFF, sizeof(((SaveBlockChart *)0)->map));
}

SeaMapManagerMapFlags *SeaMapManager__GetSaveBlockFlags(void)
{
    return (SeaMapManagerMapFlags *)saveGame.chart.flags;
}

SeaMapManagerMapLayout *SeaMapManager__GetSaveMap(void)
{
    return (SeaMapManagerMapLayout *)saveGame.chart.map;
}

void SeaMapManager__InitArchives(ShipType shipType, BOOL isSailing)
{
    SeaMapManager__Release();

    GetCompressedFileFromBundle("/bb/ch.bb", BUNDLE_CH_FILE_RESOURCES_BB_CH_LVL_NARC, &SeaMapManager__sVars.archiveCH, TRUE, FALSE);

    u16 seaMapFileID;
    if (isSailing)
    {
        switch (shipType)
        {
            case SHIP_JET:
                seaMapFileID = BUNDLE_CH_FILE_RESOURCES_BB_CH_SAIL_MAP_JET_NARC;
                break;

            case SHIP_BOAT:
                seaMapFileID = BUNDLE_CH_FILE_RESOURCES_BB_CH_SAIL_MAP_SAILER_NARC;
                break;

            case SHIP_HOVER:
                seaMapFileID = BUNDLE_CH_FILE_RESOURCES_BB_CH_SAIL_MAP_HOVER_NARC;
                break;

            case SHIP_SUBMARINE:
                seaMapFileID = BUNDLE_CH_FILE_RESOURCES_BB_CH_SAIL_MAP_SUBMARINE_NARC;
                break;

            case SHIP_MENU:
                seaMapFileID = BUNDLE_CH_FILE_RESOURCES_BB_CH_MAP_MENU_NARC;
                break;
        }
    }
    else
    {
        switch (shipType)
        {
            case SHIP_JET:
                seaMapFileID = BUNDLE_CH_FILE_RESOURCES_BB_CH_MAP_JET_NARC;
                break;

            case SHIP_BOAT:
                seaMapFileID = BUNDLE_CH_FILE_RESOURCES_BB_CH_MAP_SAILER_NARC;
                break;

            case SHIP_HOVER:
                seaMapFileID = BUNDLE_CH_FILE_RESOURCES_BB_CH_MAP_HOVER_NARC;
                break;

            case SHIP_SUBMARINE:
                seaMapFileID = BUNDLE_CH_FILE_RESOURCES_BB_CH_MAP_SUBMARINE_NARC;
                break;

            case SHIP_MENU:
                seaMapFileID = BUNDLE_CH_FILE_RESOURCES_BB_CH_MAP_MENU_NARC;
                break;
        }
    }

    GetCompressedFileFromBundle("/bb/ch.bb", seaMapFileID, &SeaMapManager__sVars.archiveSeaMap, TRUE, FALSE);

    SeaMapManager__sVars.field_C = isSailing;
}

void SeaMapManager__Release(void)
{
    if (SeaMapManager__sVars.archiveCH != NULL || SeaMapManager__sVars.archiveSeaMap != NULL)
    {
        HeapFree(HEAP_USER, SeaMapManager__sVars.archiveCH);
        SeaMapManager__sVars.archiveCH = NULL;

        HeapFree(HEAP_USER, SeaMapManager__sVars.archiveSeaMap);
        SeaMapManager__sVars.archiveSeaMap = NULL;
    }
}

void SeaMapManager__LoadAssets(SeaMapManagerAssets *work)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "ch", SeaMapManager__sVars.archiveCH);
    work->sprChCommon     = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_LVL_FILE_CH_COM_BAC);
    work->objectLayout    = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_LVL_FILE_CH_EVE_CHEV);
    work->attributeLayout = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_LVL_FILE_CH_ATTR_CHAT);
    work->chlv            = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_LVL_FILE_CH_LEVEL_CHLV);
    NNS_FndUnmountArchive(&arc);

    NNS_FndMountArchive(&arc, "ch", SeaMapManager__sVars.archiveSeaMap);
    {
        work->mapMask[SEAMAP_ZOOM_NEAREST]   = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_MAP_CMN_FILE_CH_MAP_MASK_NEAR_BBG);
        work->mapIsland[SEAMAP_ZOOM_NEAREST] = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_MAP_CMN_FILE_CH_MAP_ISLAND_NEAR_BBG);
        work->mapSea[SEAMAP_ZOOM_NEAREST]    = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_MAP_CMN_FILE_CH_MAP_SEA_NEAR_BBG);
    }
    {
        work->mapMask[SEAMAP_ZOOM_MIDDLE]   = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_MAP_CMN_FILE_CH_MAP_MASK_MID_BBG);
        work->mapIsland[SEAMAP_ZOOM_MIDDLE] = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_MAP_CMN_FILE_CH_MAP_ISLAND_MID_BBG);
        work->mapSea[SEAMAP_ZOOM_MIDDLE]    = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_MAP_CMN_FILE_CH_MAP_SEA_MID_BBG);
    }
    {
        work->mapMask[SEAMAP_ZOOM_FARTHEST]   = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_MAP_CMN_FILE_CH_MAP_MASK_FAR_BBG);
        work->mapIsland[SEAMAP_ZOOM_FARTHEST] = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_MAP_CMN_FILE_CH_MAP_ISLAND_FAR_BBG);
        work->mapSea[SEAMAP_ZOOM_FARTHEST]    = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_MAP_CMN_FILE_CH_MAP_SEA_FAR_BBG);
    }
    work->mapCollision = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_MAP_CMN_FILE_CH_MAP_COL_CHCL);
    NNS_FndUnmountArchive(&arc);
}

NONMATCH_FUNC void SeaMapManager__InitBackgrounds(SeaMapManager *work)
{
    // https://decomp.me/scratch/SFxBI -> 74.20%
#ifdef NON_MATCHING
    GraphicsEngine graphicsEngine = work->useEngineB;

    MappingsMode mappingsMode;
    if (graphicsEngine == GRAPHICS_ENGINE_A)
        mappingsMode = MAPPINGS_MODE_TEXT_512x256_A;
    else
        mappingsMode = MAPPINGS_MODE_TEXT_512x256_B;

    void *bgFile;
    switch (work->zoomLevel)
    {
        case SEAMAP_ZOOM_NEAREST:
            bgFile = work->assets.mapMask[SEAMAP_ZOOM_NEAREST];
            break;

        case SEAMAP_ZOOM_MIDDLE:
            bgFile = work->assets.mapMask[SEAMAP_ZOOM_MIDDLE];
            break;

        case SEAMAP_ZOOM_FARTHEST:
            bgFile = work->assets.mapMask[SEAMAP_ZOOM_FARTHEST];
            break;
    }
    int baseBlock     = 0x4000 * 5;
    void *vramPalette = VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_BG[graphicsEngine]);
    void *vramPixels  = (void *)VRAMSystem__VRAM_BG[graphicsEngine] + baseBlock;

    InitBackgroundEx(&work->backgrounds.mapMask, bgFile,
                     BACKGROUND_FLAG_DISABLE_PALETTE | BACKGROUND_FLAG_DISABLE_PIXELS | BACKGROUND_FLAG_ALIGN_EVEN_WIDTH | BACKGROUND_FLAG_ALIGN_EVEN_HEIGHT
                         | BACKGROUND_FLAG_SET_BG_X | BACKGROUND_FLAG_SET_BG_Y,
                     graphicsEngine, BACKGROUND_0, PALETTE_MODE_SPRITE, vramPalette, PIXEL_MODE_SPRITE, vramPixels, mappingsMode, 0, 0, 0, 0, BG_DISPLAY_FULL_WIDTH,
                     BG_DISPLAY_SINGLE_HEIGHT);

    graphicsEngine = work->useEngineB;
    if (graphicsEngine == GRAPHICS_ENGINE_A)
        mappingsMode = MAPPINGS_MODE_TEXT_512x256_A;
    else
        mappingsMode = MAPPINGS_MODE_TEXT_512x256_B;

    switch (work->zoomLevel)
    {
        case SEAMAP_ZOOM_NEAREST:
            bgFile = work->assets.mapIsland[SEAMAP_ZOOM_NEAREST];
            break;

        case SEAMAP_ZOOM_MIDDLE:
            bgFile = work->assets.mapIsland[SEAMAP_ZOOM_MIDDLE];
            break;

        case SEAMAP_ZOOM_FARTHEST:
            bgFile = work->assets.mapIsland[SEAMAP_ZOOM_FARTHEST];
            break;
    }
    baseBlock   = 0x4000 * 1;
    vramPalette = VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_BG[graphicsEngine]);
    vramPixels  = (void *)VRAMSystem__VRAM_BG[graphicsEngine] + baseBlock;
    InitBackgroundEx(&work->backgrounds.mapIsland, bgFile,
                     BACKGROUND_FLAG_SET_BG_Y | BACKGROUND_FLAG_SET_BG_X | BACKGROUND_FLAG_ALIGN_EVEN_HEIGHT | BACKGROUND_FLAG_ALIGN_EVEN_WIDTH | BACKGROUND_FLAG_DISABLE_PIXELS
                         | BACKGROUND_FLAG_DISABLE_PALETTE,
                     graphicsEngine, BACKGROUND_1, PALETTE_MODE_SPRITE, vramPalette, PIXEL_MODE_SPRITE, vramPixels, mappingsMode, 0, 2, 0, 0, BG_DISPLAY_FULL_WIDTH,
                     BG_DISPLAY_SINGLE_HEIGHT);

    graphicsEngine = work->useEngineB;
    if (graphicsEngine == GRAPHICS_ENGINE_A)
        mappingsMode = MAPPINGS_MODE_TEXT_512x256_A;
    else
        mappingsMode = MAPPINGS_MODE_TEXT_512x256_B;

    switch (work->zoomLevel)
    {
        case SEAMAP_ZOOM_NEAREST:
            bgFile = work->assets.mapSea[SEAMAP_ZOOM_NEAREST];
            break;

        case SEAMAP_ZOOM_MIDDLE:
            bgFile = work->assets.mapSea[SEAMAP_ZOOM_MIDDLE];
            break;

        case SEAMAP_ZOOM_FARTHEST:
            bgFile = work->assets.mapSea[SEAMAP_ZOOM_FARTHEST];
            break;
    }

    baseBlock   = 0x4000 * 3;
    vramPalette = VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_BG[graphicsEngine]);
    vramPixels  = (void *)VRAMSystem__VRAM_BG[graphicsEngine] + baseBlock;
    InitBackgroundEx(&work->backgrounds.mapSea, bgFile,
                     BACKGROUND_FLAG_DISABLE_PALETTE | BACKGROUND_FLAG_DISABLE_PIXELS | BACKGROUND_FLAG_ALIGN_EVEN_WIDTH | BACKGROUND_FLAG_ALIGN_EVEN_HEIGHT
                         | BACKGROUND_FLAG_SET_BG_X | BACKGROUND_FLAG_SET_BG_Y,
                     graphicsEngine, BACKGROUND_2, PALETTE_MODE_SPRITE, vramPalette, PIXEL_MODE_SPRITE, vramPixels, mappingsMode, 0, 4, 0, 0, BG_DISPLAY_FULL_WIDTH,
                     BG_DISPLAY_SINGLE_HEIGHT);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x30
	mov r5, r0
	ldr r3, [r5, #0x158]
	ldr r0, [r5, #0]
	cmp r3, #0
	moveq ip, #1
	movne ip, #0xd
	cmp r0, #0
	beq _0204484C
	cmp r0, #1
	beq _02044854
	cmp r0, #2
	ldreq r4, [r5, #0x174]
	b _02044858
_0204484C:
	ldr r4, [r5, #0x16c]
	b _02044858
_02044854:
	ldr r4, [r5, #0x170]
_02044858:
	ldr r1, =VRAMSystem__VRAM_PALETTE_BG
	mov r2, #0
	ldr r0, =VRAMSystem__VRAM_BG
	str r2, [sp]
	ldr r0, [r0, r3, lsl #2]
	ldr r1, [r1, r3, lsl #2]
	str r2, [sp, #4]
	str r1, [sp, #8]
	str r2, [sp, #0xc]
	add r0, r0, #0x14000
	str r0, [sp, #0x10]
	str ip, [sp, #0x14]
	str r2, [sp, #0x18]
	str r2, [sp, #0x1c]
	str r2, [sp, #0x20]
	str r2, [sp, #0x24]
	mov r0, #0x20
	str r0, [sp, #0x28]
	mov r0, #0x18
	str r0, [sp, #0x2c]
	ldr r3, [r5, #0x158]
	ldr r2, =0x000003C3
	mov r1, r4
	add r0, r5, #0x14
	bl InitBackgroundEx
	ldr ip, [r5, #0x158]
	ldr r0, [r5, #0]
	cmp ip, #0
	moveq lr, #1
	movne lr, #0xd
	cmp r0, #0
	beq _020448EC
	cmp r0, #1
	beq _020448F4
	cmp r0, #2
	ldreq r4, [r5, #0x180]
	b _020448F8
_020448EC:
	ldr r4, [r5, #0x178]
	b _020448F8
_020448F4:
	ldr r4, [r5, #0x17c]
_020448F8:
	ldr r1, =VRAMSystem__VRAM_PALETTE_BG
	mov r2, #1
	ldr r0, =VRAMSystem__VRAM_BG
	str r2, [sp]
	mov r3, #0
	ldr r0, [r0, ip, lsl #2]
	ldr r1, [r1, ip, lsl #2]
	str r3, [sp, #4]
	str r1, [sp, #8]
	str r3, [sp, #0xc]
	add r0, r0, #0x4000
	str r0, [sp, #0x10]
	str lr, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #2
	str r0, [sp, #0x1c]
	str r3, [sp, #0x20]
	str r3, [sp, #0x24]
	mov r0, #0x20
	str r0, [sp, #0x28]
	mov r0, #0x18
	str r0, [sp, #0x2c]
	ldr r3, [r5, #0x158]
	mov r1, r4
	add r0, r5, #0x5c
	rsb r2, r2, #0x3c4
	bl InitBackgroundEx
	ldr r3, [r5, #0x158]
	ldr r0, [r5, #0]
	cmp r3, #0
	moveq ip, #1
	movne ip, #0xd
	cmp r0, #0
	beq _02044994
	cmp r0, #1
	beq _0204499C
	cmp r0, #2
	ldreq r4, [r5, #0x18c]
	b _020449A0
_02044994:
	ldr r4, [r5, #0x184]
	b _020449A0
_0204499C:
	ldr r4, [r5, #0x188]
_020449A0:
	ldr r1, =VRAMSystem__VRAM_PALETTE_BG
	mov r2, #2
	ldr r0, =VRAMSystem__VRAM_BG
	str r2, [sp]
	mov r2, #0
	ldr r0, [r0, r3, lsl #2]
	ldr r1, [r1, r3, lsl #2]
	str r2, [sp, #4]
	str r1, [sp, #8]
	str r2, [sp, #0xc]
	add r0, r0, #0xc000
	str r0, [sp, #0x10]
	str ip, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r0, #4
	str r0, [sp, #0x1c]
	str r2, [sp, #0x20]
	str r2, [sp, #0x24]
	mov r0, #0x20
	str r0, [sp, #0x28]
	mov r0, #0x18
	str r0, [sp, #0x2c]
	ldr r3, [r5, #0x158]
	ldr r2, =0x000003C3
	mov r1, r4
	add r0, r5, #0xa4
	bl InitBackgroundEx
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void SeaMapManager__SetupDisplay(BOOL useEngineB)
{
    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];
    MI_CpuClear32(gfxControl, sizeof(*gfxControl));

    MTX_Scale22(&gfxControl->affineBG3.matrix, FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(0.5));

    u16 bankSize;
    GXOBJVRamModeChar bankMode;
    SeaMapManager__GetOBJBankInfo(useEngineB, &bankMode, &bankSize);

    if (useEngineB == GRAPHICS_ENGINE_A)
    {
        GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_3, GX_BG0_AS_2D);

        G2_SetBG0Control(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x14000, GX_BG_EXTPLTT_01);
        G2_SetBG0Priority(1);

        G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
        G2_SetBG1Priority(2);

        G2_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x2000, GX_BG_CHARBASE_0x0c000);
        G2_SetBG2Priority(3);

        G2_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x3000, GX_BG_CHARBASE_0x00000);
        G2_SetBG3Priority(0);

        VRAMSystem__SetupOBJBank(GX_GetBankForOBJ(), bankMode, GX_OBJVRAMMODE_BMP_1D_128K, 0x00, bankSize);

        GX_SetVisiblePlane(GX_PLANEMASK_ALL);
    }
    else
    {
        GXS_SetGraphicsMode(GX_BGMODE_3);

        G2S_SetBG0Control(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x14000, GX_BG_EXTPLTT_01);
        G2S_SetBG0Priority(1);

        G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
        G2S_SetBG1Priority(2);

        G2S_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x2000, GX_BG_CHARBASE_0x0c000);
        G2S_SetBG2Priority(3);

        G2S_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x3000, GX_BG_CHARBASE_0x00000);
        G2S_SetBG3Priority(0);

        VRAMSystem__SetupSubOBJBank(GX_GetBankForSubOBJ(), bankMode, GX_OBJVRAMMODE_BMP_1D_128K, 0x00, bankSize);

        GXS_SetVisiblePlane(GX_PLANEMASK_ALL);
    }
}

void SeaMapManager__GetOBJBankInfo(BOOL useEngineB, GXOBJVRamModeChar *bankMode, u16 *bankSize)
{
    if (useEngineB == GRAPHICS_ENGINE_A)
    {
        switch (GX_GetBankForOBJ())
        {
            case GX_VRAM_OBJ_16_F:
            case GX_VRAM_OBJ_16_G:
                *bankSize = 0x200;
                *bankMode = GX_OBJVRAMMODE_CHAR_1D_32K;
                break;

            default:
                *bankSize = 0x400;
                *bankMode = GX_OBJVRAMMODE_CHAR_1D_32K;
                break;
        }
    }
    else
    {
        switch (GX_GetBankForSubOBJ())
        {
            case GX_VRAM_SUB_OBJ_16_I:
                *bankSize = 0x200;
                *bankMode = GX_OBJVRAMMODE_CHAR_1D_32K;
                break;

            case GX_VRAM_SUB_OBJ_128_D:
                *bankSize = 0x400;
                *bankMode = GX_OBJVRAMMODE_CHAR_1D_32K;
                break;
        }
    }
}

void SeaMapManager__LoadBackgroundPixels(SeaMapManager *work)
{
    LoadCompressedPixels(GetBackgroundPixels(work->backgrounds.mapMask.fileData), work->backgrounds.mapMask.pixelMode, work->backgrounds.mapMask.vramPixels);
    LoadCompressedPixels(GetBackgroundPixels(work->backgrounds.mapIsland.fileData), work->backgrounds.mapIsland.pixelMode, work->backgrounds.mapIsland.vramPixels);
    LoadCompressedPixels(GetBackgroundPixels(work->backgrounds.mapSea.fileData), work->backgrounds.mapSea.pixelMode, work->backgrounds.mapSea.vramPixels);
}

void SeaMapManager__LoadBackgroundPalette(SeaMapManager *work)
{
    LoadCompressedPalette(GetBackgroundPalette(work->backgrounds.mapMask.fileData), work->backgrounds.mapMask.paletteMode, VRAMKEY_TO_KEY(work->backgrounds.mapMask.vramPalette));
}

void SeaMapManager__Main(void)
{
    SeaMapManager *work = TaskGetWorkCurrent(SeaMapManager);

    if (work->touchFieldActive)
        TouchField__Process(&work->touchField);

    work->state(work);

    if (work->lastPosition.x != work->position.x || work->lastPosition.y != work->position.y)
        work->drawFlags |= SEAMAPMANAGER_DRAWFLAG_ALL;
    SeaMapManager__Draw(work);
    work->drawFlags = SEAMAPMANAGER_DRAWFLAG_NONE;

    work->lastPosition.x = work->position.x;
    work->lastPosition.y = work->position.y;
}

void SeaMapManager__Destructor(Task *task)
{
    SeaMapManager *work = TaskGetWork(task, SeaMapManager);

    ReleaseSeaMapManagerNodeList(&work->unknownPtr->nodeList);

    HeapFree(HEAP_USER, work->unknownPtr);
    work->unknownPtr = NULL;

    SeaMapManager__sVars.singleton = NULL;
}

void SeaMapManager__State_2044DC8(SeaMapManager *work)
{
    // Nothing.
}

NONMATCH_FUNC void SeaMapManager__DrawNodeLine2(u16 x1, u16 y1, u16 x2, u16 y2, u16 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x10
	mov r7, r0
	mov r5, r2
	mov r6, r1
	mov r4, r3
	bl SeaMapManager__GetWork
	cmp r7, r5
	cmpeq r6, r4
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldrh ip, [sp, #0x28]
	cmp ip, #0
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	cmp ip, #1
	bne _02044E30
	str r4, [sp]
	ldr r0, [r0, #0x138]
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl SeaMapManager__DrawThinLine
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02044E30:
	ldr r0, [r0, #0x138]
	mov r3, r7
	str r6, [sp]
	str r5, [sp, #4]
	add r2, r0, #0x1e40
	str r4, [sp, #8]
	add r1, r0, #0x9c00
	add r2, r2, #0x8000
	str ip, [sp, #0xc]
	bl SeaMapManager__DrawThickLine
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapManager__DrawNodeLine(s32 x, s32 y, u32 a3)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r2
	mov r7, r0
	mov r6, r1
	bl SeaMapManager__GetWork
	mov r4, r0
	cmp r5, #0
	bne _02044EA4
	ldr r1, [r4, #0x138]
	mov r0, #0x60
	mla r3, r6, r0, r1
	ldrb r2, [r3, r7, asr #3]
	and r0, r7, #7
	mov r1, #1
	orr r0, r2, r1, lsl r0
	strb r0, [r3, r7, asr #3]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02044EA4:
	ldr r0, [r4, #0x138]
	add r1, r0, #0x1e40
	add r0, r0, #0x9c00
	add r1, r1, #0x8000
	bl SeaMapManager__ResetPtr1Ptr2
	ldr r3, [r4, #0x138]
	mov r0, r7
	add r1, r3, #0x1e40
	add r7, r1, #0x8000
	mov r1, r6
	mov r2, r5
	add r3, r3, #0x9c00
	str r7, [sp]
	bl SeaMapManager__Func_2045A58
	add r0, r5, #1
	subs r3, r6, r0, asr #1
	add r0, r6, r0, asr #1
	add r1, r0, #1
	movmi r3, #0
	ldr r0, [r4, #0x138]
	cmp r1, #0x120
	movgt r1, #0x120
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
	add r2, r0, #0x1e40
	mov r3, r3, lsl #0x10
	add r1, r0, #0x9c00
	add r2, r2, #0x8000
	mov r3, r3, lsr #0x10
	str r4, [sp]
	bl SeaMapManager__Func_2045128
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapManager__Func_2044F24(u16 x, u16 y)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r5, r0
	mov r4, r1
	bl SeaMapManager__GetWork
	ldr r1, [r0, #0x138]
	mov r3, #0
	add lr, r1, #0x6c00
	b _02045040
_02044F44:
	add r0, r4, r3
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	mov r0, #0x60
	mla r0, r6, r0, r1
	mov r2, #0
	ldr r7, =dword_210FB40
	b _02045034
_02044F64:
	add r6, r5, r2
	mov r6, r6, lsl #0x10
	mov r8, r6, lsr #0x10
	add ip, r0, r8, asr #3
	ldrb r10, [ip, #1]
	and r6, r8, #7
	rsb r9, r6, #8
	ldrb r8, [r0, r8, asr #3]
	mov r10, r10, lsl r9
	ldrb r9, [ip, #2]
	orr r11, r10, r8, lsr r6
	rsb r8, r6, #0x10
	ldrb r10, [ip, #3]
	orr r11, r11, r9, lsl r8
	rsb r9, r6, #0x18
	ldrb r8, [ip, #4]
	orr r9, r11, r10, lsl r9
	rsb r6, r6, #0x20
	orr r8, r9, r8, lsl r6
	and r10, r8, #0xf
	mov r6, r8, lsr #4
	and r6, r6, #0xf
	mov r9, r8, lsr #8
	ldr ip, [r7, r10, lsl #2]
	and r10, r9, #0xf
	mov r9, r8, lsr #0xc
	and r9, r9, #0xf
	ldr r6, [r7, r6, lsl #2]
	str ip, [lr]
	ldr r10, [r7, r10, lsl #2]
	str r6, [lr, #4]
	ldr r6, [r7, r9, lsl #2]
	str r10, [lr, #8]
	str r6, [lr, #0xc]
	add r6, lr, #0x10
	mov r9, r8, lsr #0x10
	and r10, r9, #0xf
	mov r9, r8, lsr #0x14
	and ip, r9, #0xf
	mov r9, r8, lsr #0x18
	ldr lr, [r7, r10, lsl #2]
	and r9, r9, #0xf
	mov r8, r8, lsr #0x1c
	and r8, r8, #0xf
	ldr r10, [r7, ip, lsl #2]
	str lr, [r6]
	ldr ip, [r7, r9, lsl #2]
	ldr r8, [r7, r8, lsl #2]
	stmib r6, {r10, ip}
	str r8, [r6, #0xc]
	add lr, r6, #0x10
	add r2, r2, #0x20
_02045034:
	cmp r2, #0x80
	blt _02044F64
	add r3, r3, #1
_02045040:
	cmp r3, #0x60
	blt _02044F44
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void SeaMapManager__ClearUnknownPtr(void)
{
    SeaMapManager *work           = SeaMapManager__GetWork();
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    MI_CpuClear32(unknown->field_0, sizeof(unknown->field_0));
}

NONMATCH_FUNC void SeaMapManager__Func_204506C(Vec2Fx32 *a1, MtxFx22 *mtx, Vec2Fx32 *a3, Vec2Fx32 *a4)
{
    // https://decomp.me/scratch/Cf2Ak -> 80.42%
#ifdef NON_MATCHING
    a4->x = MultiplyFX(a1->x, mtx->_00) + MultiplyFX(a1->y, mtx->_01) + a3->x;
    a4->y = MultiplyFX(a1->x, mtx->_10) + MultiplyFX(a1->y, mtx->_11) + a3->y;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r5, [r1, #0]
	ldmia r0, {ip, lr}
	smull r5, r6, ip, r5
	adds r7, r5, #0x800
	ldr r4, [r1, #8]
	adc r6, r6, #0
	smull r5, r4, lr, r4
	adds r5, r5, #0x800
	mov r7, r7, lsr #0xc
	orr r7, r7, r6, lsl #20
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	ldr r6, [r2, #0]
	add r4, r7, r5
	add r4, r6, r4
	str r4, [r3]
	ldr lr, [r0, #4]
	ldr r4, [r1, #4]
	ldr r0, [r1, #0xc]
	smull r1, r4, ip, r4
	adds ip, r1, #0x800
	smull r1, r0, lr, r0
	adc r4, r4, #0
	adds r1, r1, #0x800
	mov ip, ip, lsr #0xc
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr ip, ip, r4, lsl #20
	orr r1, r1, r0, lsl #20
	ldr r2, [r2, #4]
	add r0, ip, r1
	add r0, r2, r0
	str r0, [r3, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void SeaMapManager__ResetPtr1Ptr2(void *ptr1, void *ptr2)
{
    MI_CpuFill16(ptr1, 0x300, 0x240);
    MI_CpuClear16(ptr2, 0x240);
}

NONMATCH_FUNC void SeaMapManager__Func_2045128(u8 *a1, u16 *ptr1, u16 *ptr2, u32 pos, u32 size)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r5, [sp, #0x20]
	add r1, r1, r3, lsl #1
	cmp r3, r5
	add r2, r2, r3, lsl #1
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov ip, #1
	mov r7, #0x60
_02045148:
	ldrh lr, [r1]
	ldrh r4, [r2, #0]
	cmp lr, r4
	bhi _02045184
	mla r4, r3, r7, r0
_0204515C:
	ldrb r9, [r4, lr, asr #3]
	and r8, lr, #7
	add r6, lr, #1
	orr r8, r9, ip, lsl r8
	strb r8, [r4, lr, asr #3]
	ldrh r8, [r2, #0]
	mov r6, r6, lsl #0x10
	mov lr, r6, lsr #0x10
	cmp r8, r6, lsr #16
	bhs _0204515C
_02045184:
	add r3, r3, #1
	mov r3, r3, lsl #0x10
	cmp r5, r3, lsr #16
	add r1, r1, #2
	add r2, r2, #2
	mov r3, r3, lsr #0x10
	bhi _02045148
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapManager__Func_20451A4(Vec2Fx32 *a1, Vec2Fx32 *a2, Vec2Fx32 *a3, Vec2Fx32 *a4, u32 *a5, u32 *a6, s32 a7)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x10
	mov r4, #0
	mov r8, r0
	mov r7, r1
	str r4, [r8]
	sub r9, r4, #0x800
	str r9, [r8, #4]
	str r4, [r7]
	mov r1, #0x800
	mov r6, r2
	str r1, [r7, #4]
	mov r0, #0x1000
	stmia r6, {r0, r1}
	mov r5, r3
	ldr r4, [sp, #0x30]
	stmia r5, {r0, r9}
	ldr r10, [sp, #0x34]
	ldr r0, [r4, #4]
	ldmia r10, {r2, r3}
	ldr r1, [r4, #0]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r9, r0
	mov r0, r9, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	mov ip, r1, lsl #1
	add r1, r1, #1
	ldr r3, =FX_SinCosTable_
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	add r0, sp, #0
	bl MTX_Rot22_
	ldr r1, [r4, #0]
	ldmia r10, {r2, r3}
	ldr r0, [r4, #4]
	sub r1, r2, r1
	sub r0, r3, r0
	smull r10, r3, r1, r1
	smull r2, r1, r0, r0
	adds r10, r10, #0x800
	adc r0, r3, #0
	mov r3, r10, lsr #0xc
	adds r2, r2, #0x800
	orr r3, r3, r0, lsl #20
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r3, r1
	bl FX_Sqrt
	mov r2, r0
	add r0, sp, #0
	ldr r3, [sp, #0x38]
	mov r1, r0
	bl MTX_ScaleApply22
	mov r0, r8
	mov r3, r8
	add r1, sp, #0
	mov r2, r4
	bl SeaMapManager__Func_204506C
	mov r0, r7
	mov r3, r7
	add r1, sp, #0
	mov r2, r4
	bl SeaMapManager__Func_204506C
	mov r0, r6
	mov r3, r6
	add r1, sp, #0
	mov r2, r4
	bl SeaMapManager__Func_204506C
	mov r2, r4
	mov r0, r5
	mov r3, r5
	add r1, sp, #0
	bl SeaMapManager__Func_204506C
	mov r0, r9
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapManager__Func_20452F0(s32 a1, s32 a2, s32 a3, s32 a4, u32 a5, u32 *a6, u32 *a7, u32 *a8, u32 *a9)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r6, [sp, #0x10]
	ldr r5, [sp, #0x14]
	cmp r6, #0x4000
	ldr r4, [sp, #0x18]
	ldr lr, [sp, #0x1c]
	ldr ip, [sp, #0x20]
	bhs _02045324
	str r0, [r5]
	str r2, [r4]
	str r1, [lr]
	str r3, [ip]
	ldmia sp!, {r4, r5, r6, pc}
_02045324:
	cmp r6, #0x4000
	blo _02045348
	cmp r6, #0x8000
	bhs _02045348
	str r1, [r5]
	str r3, [r4]
	str r2, [lr]
	str r0, [ip]
	ldmia sp!, {r4, r5, r6, pc}
_02045348:
	cmp r6, #0x8000
	blo _0204536C
	cmp r6, #0xc000
	bhs _0204536C
	str r2, [r5]
	str r0, [r4]
	str r3, [lr]
	str r1, [ip]
	ldmia sp!, {r4, r5, r6, pc}
_0204536C:
	str r3, [r5]
	str r1, [r4]
	str r0, [lr]
	str r2, [ip]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapManager__Func_2045380(u32 *a1, u32 *a2, s32 *a3, s32 *a4, s32 a5, s32 a6)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	str r2, [sp, #4]
	mov r8, r0
	ldr r0, [sp, #4]
	ldr r2, [r8, #4]
	ldr r9, [r0, #4]
	str r3, [sp, #8]
	ldr r10, [r0, #0]
	str r1, [sp]
	mov r4, r2, asr #0xc
	mov r1, r10, asr #0xc
	movs r5, r9, asr #0xc
	ldr r7, [sp, #0x30]
	ldr r6, [sp, #0x34]
	ldr r3, [r8, #0]
	bmi _0204548C
	subs r0, r4, r5
	bne _02045404
	cmp r5, #0
	blt _0204548C
	cmp r5, #0x120
	bge _0204548C
	cmp r1, #0
	bge _020453F4
	mov r0, r5, lsl #1
	mov r1, #0
	strh r1, [r7, r0]
	b _0204548C
_020453F4:
	cmp r1, #0x300
	movlt r0, r5, lsl #1
	strlth r1, [r7, r0]
	b _0204548C
_02045404:
	sub r0, r3, r10
	sub r1, r2, r9
	bl FX_Div
	cmp r4, #0
	movlt r4, #0
	mov r9, r4, lsl #0xc
	mov r10, r0, asr #0x1f
	mov r11, #0
	b _0204547C
_02045428:
	ldr r1, [r8, #4]
	ldr lr, [r8]
	sub r2, r9, r1
	umull ip, r3, r2, r0
	mla r3, r2, r10, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r1, ip, #0x800
	adc r2, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r2, lsl #20
	adds r1, lr, r1
	movmi r1, r4, lsl #1
	strmih r11, [r7, r1]
	bmi _02045474
	cmp r1, #0x300000
	movlt r2, r1, asr #0xc
	movlt r1, r4, lsl #1
	strlth r2, [r7, r1]
_02045474:
	add r9, r9, #0x1000
	add r4, r4, #1
_0204547C:
	cmp r4, r5
	bgt _0204548C
	cmp r4, #0x120
	blt _02045428
_0204548C:
	ldr r0, [sp, #8]
	ldr r9, [r8, #4]
	ldr r3, [r0, #0]
	ldr r1, [r0, #4]
	mov r5, r9, asr #0xc
	mov r2, r3, asr #0xc
	movs r4, r1, asr #0xc
	ldr r10, [r8, #0]
	bmi _0204557C
	subs r0, r5, r4
	bne _020454F0
	cmp r4, #0
	blt _0204557C
	cmp r4, #0x120
	bge _0204557C
	cmp r2, #0x300
	blt _020454E0
	ldr r1, =0x000002FF
	mov r0, r4, lsl #1
	strh r1, [r6, r0]
	b _0204557C
_020454E0:
	cmp r2, #0
	movge r0, r4, lsl #1
	strgeh r2, [r6, r0]
	b _0204557C
_020454F0:
	sub r0, r10, r3
	sub r1, r9, r1
	bl FX_Div
	cmp r5, #0
	movlt r5, #0
	mov r11, r5, lsl #0xc
	mov ip, r0, asr #0x1f
	ldr lr, =0x000002FF
	b _0204556C
_02045514:
	ldr r1, [r8, #4]
	ldr r10, [r8, #0]
	sub r2, r11, r1
	umull r9, r3, r2, r0
	mla r3, r2, ip, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r1, r9, #0x800
	adc r2, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r2, lsl #20
	add r1, r10, r1
	cmp r1, #0x300000
	movge r1, r5, lsl #1
	strgeh lr, [r6, r1]
	bge _02045564
	cmp r1, #0
	movge r2, r1, asr #0xc
	movge r1, r5, lsl #1
	strgeh r2, [r6, r1]
_02045564:
	add r11, r11, #0x1000
	add r5, r5, #1
_0204556C:
	cmp r5, r4
	bgt _0204557C
	cmp r5, #0x120
	blt _02045514
_0204557C:
	ldr r0, [sp, #4]
	ldr r9, [r0, #0]
	ldr r3, [r0, #4]
	ldr r0, [sp]
	mov r8, r9, asr #0xc
	ldr r1, [r0, #4]
	mov r5, r3, asr #0xc
	movs r4, r1, asr #0xc
	ldr r2, [r0, #0]
	bmi _02045674
	subs r0, r5, r4
	bne _020455E4
	cmp r5, #0
	blt _02045674
	cmp r5, #0x120
	bge _02045674
	cmp r8, #0
	bge _020455D4
	mov r0, r5, lsl #1
	mov r1, #0
	strh r1, [r7, r0]
	b _02045674
_020455D4:
	cmp r8, #0x300
	movlt r0, r5, lsl #1
	strlth r8, [r7, r0]
	b _02045674
_020455E4:
	sub r0, r9, r2
	sub r1, r3, r1
	bl FX_Div
	adds ip, r5, #1
	movmi ip, #0
	mov r1, #0
	mov r10, ip, lsl #0xc
	mov r11, r0, asr #0x1f
	mov lr, r1
	b _02045664
_0204560C:
	ldr r2, [sp, #4]
	ldr r3, [r2, #4]
	ldr r9, [r2, #0]
	sub r3, r10, r3
	umull r8, r5, r3, r0
	mla r5, r3, r11, r5
	mov r2, r3, asr #0x1f
	adds r3, r8, #0x800
	mla r5, r2, r0, r5
	adc r2, r5, lr
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	adds r2, r9, r3
	movmi r2, ip, lsl #1
	strmih r1, [r7, r2]
	bmi _0204565C
	cmp r2, #0x300000
	movlt r3, r2, asr #0xc
	movlt r2, ip, lsl #1
	strlth r3, [r7, r2]
_0204565C:
	add r10, r10, #0x1000
	add ip, ip, #1
_02045664:
	cmp ip, r4
	bgt _02045674
	cmp ip, #0x120
	blt _0204560C
_02045674:
	ldr r0, [sp, #8]
	ldr r8, [r0, #0]
	ldr r3, [r0, #4]
	ldr r0, [sp]
	mov r7, r8, asr #0xc
	ldr r1, [r0, #4]
	mov r5, r3, asr #0xc
	movs r4, r1, asr #0xc
	addmi sp, sp, #0xc
	ldr r2, [r0, #0]
	ldmmiia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	subs r0, r5, r4
	bne _020456F0
	cmp r5, #0
	addlt sp, sp, #0xc
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r5, #0x120
	addge sp, sp, #0xc
	ldmgeia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r7, #0x300
	blt _020456DC
	ldr r1, =0x000002FF
	mov r0, r5, lsl #1
	add sp, sp, #0xc
	strh r1, [r6, r0]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020456DC:
	cmp r7, #0
	movge r0, r5, lsl #1
	add sp, sp, #0xc
	strgeh r7, [r6, r0]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020456F0:
	sub r0, r8, r2
	sub r1, r3, r1
	bl FX_Div
	adds ip, r5, #1
	movmi ip, #0
	mov r10, ip, lsl #0xc
	mov r11, r0, asr #0x1f
	ldr r2, =0x000002FF
	mov r1, #0
	mov lr, #0x800
	b _02045778
_0204571C:
	ldr r3, [sp, #8]
	ldr r5, [r3, #4]
	ldr r9, [r3, #0]
	sub r5, r10, r5
	umull r3, r7, r5, r0
	adds r3, r3, lr
	mov r8, r3, lsr #0xc
	mla r7, r5, r11, r7
	mov r3, r5, asr #0x1f
	mla r7, r3, r0, r7
	adc r3, r7, r1
	orr r8, r8, r3, lsl #20
	add r3, r9, r8
	cmp r3, #0x300000
	movge r3, ip, lsl #1
	strgeh r2, [r6, r3]
	bge _02045770
	cmp r3, #0
	movge r5, r3, asr #0xc
	movge r3, ip, lsl #1
	strgeh r5, [r6, r3]
_02045770:
	add r10, r10, #0x1000
	add ip, ip, #1
_02045778:
	cmp ip, r4
	addgt sp, sp, #0xc
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp ip, #0x120
	blt _0204571C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapManager__DrawThickLine(u8 *field_0, u16 *ptr1, u16 *ptr2, u16 x1, u16 y1, u16 x2, u16 y2, u16 thickness)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x54
	ldrh r5, [sp, #0x74]
	ldrh r4, [sp, #0x78]
	ldrh r6, [sp, #0x70]
	mov ip, r3, lsl #0xc
	mov r8, r5, lsl #0xc
	mov r3, r6, lsl #0xc
	mov r7, r4, lsl #0xc
	mov r6, r0
	str ip, [sp, #0x4c]
	str r3, [sp, #0x50]
	mov r5, r1
	mov r4, r2
	ldrh lr, [sp, #0x7c]
	add r0, sp, #0x4c
	str r8, [sp, #0x44]
	str r7, [sp, #0x48]
	str r0, [sp]
	add ip, sp, #0x44
	str ip, [sp, #4]
	mov ip, lr, lsl #0xc
	add r0, sp, #0x3c
	add r1, sp, #0x34
	add r2, sp, #0x2c
	add r3, sp, #0x24
	str ip, [sp, #8]
	bl SeaMapManager__Func_20451A4
	str r0, [sp]
	add r0, sp, #0x20
	str r0, [sp, #4]
	add r1, sp, #0x1c
	str r1, [sp, #8]
	add r0, sp, #0x18
	str r0, [sp, #0xc]
	add r2, sp, #0x14
	str r2, [sp, #0x10]
	add r0, sp, #0x3c
	add r1, sp, #0x34
	add r2, sp, #0x2c
	add r3, sp, #0x24
	bl SeaMapManager__Func_20452F0
	mov r0, r5
	mov r1, r4
	bl SeaMapManager__ResetPtr1Ptr2
	str r5, [sp]
	str r4, [sp, #4]
	ldr r0, [sp, #0x20]
	ldr r1, [sp, #0x1c]
	ldr r2, [sp, #0x18]
	ldr r3, [sp, #0x14]
	bl SeaMapManager__Func_2045380
	ldr r0, [sp, #0x20]
	ldrh r1, [sp, #0x7c]
	ldr r0, [r0, #4]
	add r1, r1, #1
	mov r0, r0, asr #0xc
	subs r2, r0, r1, asr #1
	ldr r0, [sp, #0x1c]
	movmi r2, #0
	mov r3, r2, lsl #0x10
	ldr r0, [r0, #4]
	mov r2, r4
	mov r0, r0, asr #0xc
	add r0, r0, r1, asr #1
	cmp r0, #0x120
	movgt r0, #0x120
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	mov r0, r6
	mov r1, r5
	mov r3, r3, lsr #0x10
	str ip, [sp]
	bl SeaMapManager__Func_2045128
	add sp, sp, #0x54
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapManager__DrawThinLine(u8 *pixels, u16 startX, u16 startY, u16 endX, u16 endY)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr lr, [sp, #0x28]
	sub r4, r3, r1
	sub r5, lr, r2
	mov r4, r4, lsl #0x10
	mov r5, r5, lsl #0x10
	movs r4, r4, asr #0x10
	rsbmi r4, r4, #0
	mov r5, r5, asr #0x10
	mov r4, r4, lsl #0x10
	cmp r5, #0
	rsblt r5, r5, #0
	mov ip, r4, lsr #0x10
	mov r4, r5, lsl #0x10
	cmp ip, r4, lsr #16
	bls _020459B0
	cmp r2, lr
	movlo r11, #1
	mvnhs r11, #0
	cmp r1, r3
	movlo r5, r1
	movhs r5, r3
	add r5, r5, #1
	movlo r8, #1
	mov r5, r5, lsl #0x10
	movhs r3, r1
	mvnhs r8, #0
	mov r10, r5, lsr #0x10
	mov r9, #0
	cmp r3, r5, lsr #16
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r6, #1
_02045948:
	add r1, r1, r8
	add r5, r9, r4, lsr #16
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r5, r5, lsl #0x10
	cmp ip, r5, lsr #16
	mov r9, r5, lsr #0x10
	bhi _02045980
	sub r7, r9, ip
	add r5, r2, r11
	mov r2, r7, lsl #0x10
	mov r9, r2, lsr #0x10
	mov r2, r5, lsl #0x10
	mov r2, r2, lsr #0x10
_02045980:
	mov r5, #0x60
	mla lr, r2, r5, r0
	ldrb r7, [lr, r1, asr #3]
	and r5, r1, #7
	add r10, r10, #1
	orr r5, r7, r6, lsl r5
	strb r5, [lr, r1, asr #3]
	mov r5, r10, lsl #0x10
	cmp r3, r5, lsr #16
	mov r10, r5, lsr #0x10
	bhs _02045948
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020459B0:
	cmp r1, r3
	movlo r9, #1
	mvnhs r9, #0
	cmp r2, lr
	movlo r3, r2
	movhs r3, lr
	add r3, r3, #1
	movlo r8, #1
	mov r3, r3, lsl #0x10
	movhs lr, r2
	mvnhs r8, #0
	mov r11, r3, lsr #0x10
	mov r10, #0
	cmp lr, r3, lsr #16
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r5, #1
_020459F0:
	add r3, r10, ip
	add r2, r2, r8
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r10, r3, lsr #0x10
	cmp r10, r4, lsr #16
	blo _02045A28
	sub r6, r10, r4, lsr #16
	add r3, r1, r9
	mov r1, r6, lsl #0x10
	mov r10, r1, lsr #0x10
	mov r1, r3, lsl #0x10
	mov r1, r1, lsr #0x10
_02045A28:
	mov r3, #0x60
	mla r7, r2, r3, r0
	ldrb r6, [r7, r1, asr #3]
	and r3, r1, #7
	add r11, r11, #1
	orr r3, r6, r5, lsl r3
	strb r3, [r7, r1, asr #3]
	mov r3, r11, lsl #0x10
	cmp lr, r3, lsr #16
	mov r11, r3, lsr #0x10
	bhs _020459F0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapManager__Func_2045A58(s32 a1, s16 a2, u32 a3, s32 a4, s32 a5)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r4, r2, lsr #1
	add ip, r4, #1
	mov r5, ip, lsl #2
	sub r4, ip, #1
	mul r6, r5, r4
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	add r6, r6, #2
	rsb r5, r2, #0
	mla lr, r5, r2, r6
	rsb r4, ip, #1
	tst r2, #1
	mov r2, r4, lsl #3
	mov r8, r0
	str r1, [sp]
	str r2, [sp, #4]
	ldr r9, [sp, #0x30]
	mov r11, #4
	bne _02045ACC
	add r2, r0, #1
	add r4, r1, #1
	mov r2, r2, lsl #0x10
	mov r4, r4, lsl #0x10
	mov r8, r2, lsr #0x10
	mov r2, r4, lsr #0x10
	str r2, [sp]
_02045ACC:
	cmp ip, #0
	addlt sp, sp, #8
	mov r2, #0
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r6, r0, ip
	add r7, r1, ip
_02045AE4:
	cmp lr, #0
	ble _02045B08
	ldr r4, [sp, #4]
	sub r6, r6, #1
	add lr, lr, r4
	add r4, r4, #8
	str r4, [sp, #4]
	sub r7, r7, #1
	sub ip, ip, #1
_02045B08:
	cmp r1, #0
	blt _02045B38
	cmp r1, #0x120
	bge _02045B38
	subs r5, r8, ip
	movmi r5, #0
	mov r4, r1, lsl #1
	mov r10, r6
	cmp r6, #0x300
	ldrge r10, =0x000002FF
	strh r5, [r3, r4]
	strh r10, [r9, r4]
_02045B38:
	cmp r7, #0
	blt _02045B68
	cmp r7, #0x120
	bge _02045B68
	subs r5, r8, r2
	movmi r5, #0
	mov r4, r7, lsl #1
	mov r10, r0
	cmp r0, #0x300
	ldrge r10, =0x000002FF
	strh r5, [r3, r4]
	strh r10, [r9, r4]
_02045B68:
	ldr r4, [sp]
	subs r10, r4, r2
	bmi _02045B9C
	cmp r10, #0x120
	bge _02045B9C
	subs r4, r8, ip
	movmi r4, #0
	mov r10, r10, lsl #1
	mov r5, r6
	cmp r6, #0x300
	ldrge r5, =0x000002FF
	strh r4, [r3, r10]
	strh r5, [r9, r10]
_02045B9C:
	ldr r4, [sp]
	subs r4, r4, ip
	bmi _02045BD0
	cmp r4, #0x120
	bge _02045BD0
	subs r5, r8, r2
	movmi r5, #0
	mov r4, r4, lsl #1
	mov r10, r0
	cmp r0, #0x300
	ldrge r10, =0x000002FF
	strh r5, [r3, r4]
	strh r10, [r9, r4]
_02045BD0:
	add lr, lr, r11
	add r11, r11, #8
	add r1, r1, #1
	add r0, r0, #1
	add r2, r2, #1
	cmp r2, ip
	ble _02045AE4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapManager__Func_2045BF8(fx32 targetDistance, fx32 *x, fx32 *y)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r6, r1
	mov r5, r2
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x138]
	add r0, r0, #0xa000
	ldr r4, [r0, #0x80]
	ldr r7, [r4, #4]
	cmp r7, #0
	bne _02045C3C
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	mov r2, r6
	mov r3, r5
	bl SeaMapManager__GetPosition2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02045C3C:
	mov r0, r7
	bl SeaMapManagerNodeList_GetNodeDistance
	mov r1, r0
	cmp r8, r1
	bgt _02045CD0
	mov r0, r8
	bl FX_Div
	ldrh r3, [r7, #0xa]
	mov r2, r0, lsl #0x10
	ldrh ip, [r7, #8]
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	mov r4, ip, lsl #0xc
	mov r3, r3, lsl #0xc
	mov r7, r2, asr #0x10
	sub r4, r4, r0, lsl #12
	sub r2, r3, r1, lsl #12
	smull r3, ip, r4, r7
	adds lr, r3, #0x800
	smull r4, r3, r2, r7
	adc r2, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r2, lsl #20
	adds r4, r4, #0x800
	adc r2, r3, #0
	mov r3, r4, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r1, r3, r1, lsl #12
	add r0, ip, r0, lsl #12
	mov r0, r0, lsl #4
	mov r1, r1, lsl #4
	mov r2, r6
	mov r3, r5
	mov r0, r0, lsr #0x10
	mov r1, r1, lsr #0x10
	bl SeaMapManager__GetPosition2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02045CD0:
	mov r4, r7
	ldr r7, [r7, #4]
	sub r8, r8, r1
	cmp r7, #0
	bne _02045C3C
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	mov r2, r6
	mov r3, r5
	bl SeaMapManager__GetPosition2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

fx32 SeaMapManager__AddNode(u16 x, u16 y)
{
    SeaMapManager *work           = SeaMapManager__GetWork();
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    SeaMapManagerNode *node = SeaMapManagerNodeList_AddNode(&unknown->nodeList);
    node->position.x        = x;
    node->position.y        = y;
    return SeaMapManagerNodeList_GetNodeDistance(node);
}

u32 SeaMapManager__RemoveNode(void)
{
    SeaMapManager *work           = SeaMapManager__GetWork();
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    return SeaMapManagerNodeList_RemoveLastNode(&unknown->nodeList);
}

void SeaMapManager__RemoveAllNodes(void)
{
    while (SeaMapManager__RemoveNode() > 0)
    {
        // More nodes to remove...
    }
}

SeaMapManagerNode *SeaMapManager__GetStartNode(void)
{
    SeaMapManager *work           = SeaMapManager__GetWork();
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    return (SeaMapManagerNode *)unknown->nodeList.nodes.headObject;
}

SeaMapManagerNode *SeaMapManager__GetEndNode(void)
{
    SeaMapManager *work           = SeaMapManager__GetWork();
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    return (SeaMapManagerNode *)unknown->nodeList.nodes.tailObject;
}

SeaMapManagerNode *SeaMapManager__GetNextNode(SeaMapManagerNode *node)
{
    SeaMapManager *work           = SeaMapManager__GetWork();
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    return (SeaMapManagerNode *)NNS_FndGetNextListObject(&unknown->nodeList.nodes, node);
}

SeaMapManagerNode *SeaMapManager__GetPrevNode(SeaMapManagerNode *node)
{
    SeaMapManager *work           = SeaMapManager__GetWork();
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    return (SeaMapManagerNode *)NNS_FndGetPrevListObject(&unknown->nodeList.nodes, node);
}

u32 SeaMapManager__GetNodeCount(void)
{
    SeaMapManager *work           = SeaMapManager__GetWork();
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    return unknown->nodeList.nodes.numObjects;
}

fx32 SeaMapManager__GetTotalDistance(void)
{
    fx32 totalDistance = 0;

    SeaMapManager *work           = SeaMapManager__GetWork();
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    SeaMapManagerNode *curNode = (SeaMapManagerNode *)unknown->nodeList.nodes.headObject;
    while (curNode != NULL)
    {
        totalDistance += curNode->distance;
        curNode = (SeaMapManagerNode *)curNode->link.nextObject;
    }

    return totalDistance;
}

void SeaMapManager__GetLastNodePosition(fx16 *x, fx16 *y)
{
    SeaMapManager *work           = SeaMapManager__GetWork();
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    SeaMapManagerNode *node = unknown->nodeList.nodes.tailObject;
    *x                      = node->position.x;
    *y                      = node->position.y;
}

void SeaMapManager__Func_2045E58(u32 nodeCount)
{
    SeaMapManager *work           = SeaMapManager__GetWork();
    SeaMapManagerUnknown *unknown = work->unknownPtr;

    SeaMapManagerNodeList_CompressNodeList(&unknown->nodeList, nodeCount);
}