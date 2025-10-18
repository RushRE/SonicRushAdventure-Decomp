#include <game/stage/mapFarSys.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/background.h>
#include <game/graphics/mappingsQueue.h>
#include <game/text/fontDMAControl.h>
#include <game/math/unknown2051334.h>

// --------------------
// TYPES
// --------------------

typedef void (*MapFarSysInitFunc)(void);
typedef void (*MapFarSysProcessFunc)(void);
typedef void (*MapFarSysReleaseFunc)(void);

// --------------------
// STRUCTS
// --------------------

typedef struct MapFarSysScroll_
{
    u16 width;
    u16 pos;
} MapFarSysScroll;

typedef union MapFarSysUnknownUnknown_
{
    struct
    {
        s32 timer;

        u8 field_4[16][HW_LCD_HEIGHT];
    } x16;
    struct
    {
        s32 timer;

        u8 field_4[8][HW_LCD_HEIGHT];
    } x8;
} MapFarSysUnknownUnknown;

struct MapFarSysUnknown
{
    u32 flags;
    Task *task;
    fx32 scrollSpeedY[2];
    Vec2Fx32 scrollSpeed[2];
    u8 bg1VOfs[2][192];
    u8 bg1VOfs_sub[2][192];
    u8 bg1VOfs_2[2][192];
    u8 bg1VOfs_sub_2[2][192];
    MapFarSysScroll *scroll1[2][3];
    u16 field_638[2];
    MapFarSysUnknownUnknown field_63C;
};

struct MapFarSysStaticVars
{
    void *asset;
    s32 bbgTileCount;
    struct MapFarSysUnknown *scrollControl;
    u32 flags;
};

struct MapFarSysUnknown200D144
{
    u16 field_0;
    u16 field_2;
    u16 field_4;
    u16 field_6;
};

// --------------------
// VARIABLES
// --------------------

static struct MapFarSysStaticVars MapFarSys__sVars;

NOT_DECOMPILED const MapFarSysScroll _0210E074[];
NOT_DECOMPILED const MapFarSysScroll _0210E07A[];
NOT_DECOMPILED const MapFarSysScroll _0210E080[];
NOT_DECOMPILED const MapFarSysScroll _0210E086[];
NOT_DECOMPILED const MapFarSysScroll _0210E08C[];
NOT_DECOMPILED const MapFarSysScroll _0210E092[];
NOT_DECOMPILED const MapFarSysScroll _0210E094[];
NOT_DECOMPILED const MapFarSysScroll _0210E0A4[];
NOT_DECOMPILED const MapFarSysScroll _0210E0B4[];
NOT_DECOMPILED const MapFarSysScroll _0210E0B6[];
NOT_DECOMPILED const MapFarSysScroll _0210E0C6[];
NOT_DECOMPILED const MapFarSysScroll _0210E0C8[];
NOT_DECOMPILED const MapFarSysScroll _0210E0D8[];
NOT_DECOMPILED const MapFarSysScroll _0210E0F0[];
NOT_DECOMPILED const MapFarSysScroll _0210E108[];
NOT_DECOMPILED void *_0210E120;
NOT_DECOMPILED const MapFarSysScroll _0210E130[];
NOT_DECOMPILED const MapFarSysScroll _0210E140[];
NOT_DECOMPILED const MapFarSysScroll _0210E160[];
NOT_DECOMPILED const MapFarSysScroll _0210E184[];
NOT_DECOMPILED const MapFarSysScroll _0210E1AC[];
NOT_DECOMPILED const MapFarSysScroll _0210E1D4[];
NOT_DECOMPILED const MapFarSysScroll _0210E23C[];
NOT_DECOMPILED const MapFarSysScroll _0210E2A4[];
NOT_DECOMPILED const MapFarSysScroll _0210E30C[];

static MapFarSysProcessFunc MapFarSys__ProcessTable[STAGE_COUNT] = {
    [STAGE_Z11]               = MapFarSys__Process_Z1,
    [STAGE_Z12]               = MapFarSys__Process_Z1,
    [STAGE_TUTORIAL]          = MapFarSys__Process_Z1,
    [STAGE_Z1B]               = NULL,
    [STAGE_Z21]               = MapFarSys__Process_Z2,
    [STAGE_Z22]               = MapFarSys__Process_Z2,
    [STAGE_Z2B]               = NULL,
    [STAGE_Z31]               = MapFarSys__Process_Z3,
    [STAGE_Z32]               = MapFarSys__Process_Z3,
    [STAGE_HIDDEN_ISLAND_1]   = MapFarSys__Process_Z9,
    [STAGE_Z3B]               = NULL,
    [STAGE_Z41]               = MapFarSys__Process_Z4,
    [STAGE_Z42]               = MapFarSys__Process_Z4,
    [STAGE_Z4B]               = NULL,
    [STAGE_Z51]               = MapFarSys__Process_Z5,
    [STAGE_Z52]               = MapFarSys__Process_Z5,
    [STAGE_Z5B]               = MapFarSys__Process_Z9,
    [STAGE_Z61]               = MapFarSys__Process_Z6,
    [STAGE_Z62]               = MapFarSys__Process_Z6,
    [STAGE_HIDDEN_ISLAND_2]   = NULL,
    [STAGE_Z6B]               = NULL,
    [STAGE_Z71]               = MapFarSys__Process_Z7,
    [STAGE_Z72]               = MapFarSys__Process_Z7,
    [STAGE_Z7B]               = NULL,
    [STAGE_BOSS_FINAL]        = NULL,
    [STAGE_HIDDEN_ISLAND_3]   = MapFarSys__Process_Z9,
    [STAGE_HIDDEN_ISLAND_4]   = MapFarSys__Process_Z3,
    [STAGE_HIDDEN_ISLAND_5]   = MapFarSys__Process_Z9,
    [STAGE_HIDDEN_ISLAND_6]   = MapFarSys__Process_Z1,
    [STAGE_HIDDEN_ISLAND_7]   = MapFarSys__Process_Z1,
    [STAGE_HIDDEN_ISLAND_8]   = MapFarSys__Process_Z3,
    [STAGE_HIDDEN_ISLAND_9]   = MapFarSys__Process_Z2,
    [STAGE_HIDDEN_ISLAND_10]  = MapFarSys__Process_Z2,
    [STAGE_HIDDEN_ISLAND_11]  = MapFarSys__Process_Z3,
    [STAGE_HIDDEN_ISLAND_12]  = MapFarSys__Process_Z5,
    [STAGE_HIDDEN_ISLAND_13]  = MapFarSys__Process_Z5,
    [STAGE_HIDDEN_ISLAND_14]  = MapFarSys__Process_Z9,
    [STAGE_HIDDEN_ISLAND_15]  = MapFarSys__Process_Z4,
    [STAGE_HIDDEN_ISLAND_16]  = MapFarSys__Process_Z9,
    [STAGE_HIDDEN_ISLAND_VS1] = MapFarSys__Process_Z1,
    [STAGE_HIDDEN_ISLAND_VS2] = MapFarSys__Process_Z2,
    [STAGE_HIDDEN_ISLAND_VS3] = MapFarSys__Process_Z3,
    [STAGE_HIDDEN_ISLAND_VS4] = MapFarSys__Process_Z4,
    [STAGE_HIDDEN_ISLAND_R1]  = MapFarSys__Process_Z9,
    [STAGE_HIDDEN_ISLAND_R2]  = MapFarSys__Process_Z9,
    [STAGE_HIDDEN_ISLAND_R3]  = MapFarSys__Process_Z9,
};

static MapFarSysInitFunc MapFarSys__BuildTable[STAGE_COUNT] = {
    [STAGE_Z11]               = MapFarSys__Build_Z1,
    [STAGE_Z12]               = MapFarSys__Build_Z1,
    [STAGE_TUTORIAL]          = MapFarSys__Build_Z1,
    [STAGE_Z1B]               = NULL,
    [STAGE_Z21]               = MapFarSys__Build_Z2,
    [STAGE_Z22]               = MapFarSys__Build_Z2,
    [STAGE_Z2B]               = NULL,
    [STAGE_Z31]               = MapFarSys__Build_Z3,
    [STAGE_Z32]               = MapFarSys__Build_Z3,
    [STAGE_HIDDEN_ISLAND_1]   = MapFarSys__Build_Z9,
    [STAGE_Z3B]               = NULL,
    [STAGE_Z41]               = MapFarSys__Build_Z4,
    [STAGE_Z42]               = MapFarSys__Build_Z4,
    [STAGE_Z4B]               = NULL,
    [STAGE_Z51]               = MapFarSys__Build_Z5,
    [STAGE_Z52]               = MapFarSys__Build_Z5,
    [STAGE_Z5B]               = NULL,
    [STAGE_Z61]               = MapFarSys__Build_Z6,
    [STAGE_Z62]               = MapFarSys__Build_Z6,
    [STAGE_HIDDEN_ISLAND_2]   = MapFarSys__Build_Z9,
    [STAGE_Z6B]               = NULL,
    [STAGE_Z71]               = MapFarSys__Build_Z7,
    [STAGE_Z72]               = MapFarSys__Build_Z7,
    [STAGE_Z7B]               = NULL,
    [STAGE_BOSS_FINAL]        = NULL,
    [STAGE_HIDDEN_ISLAND_3]   = MapFarSys__Build_Z9,
    [STAGE_HIDDEN_ISLAND_4]   = MapFarSys__Build_Z3,
    [STAGE_HIDDEN_ISLAND_5]   = MapFarSys__Build_Z9,
    [STAGE_HIDDEN_ISLAND_6]   = MapFarSys__Build_Z1,
    [STAGE_HIDDEN_ISLAND_7]   = MapFarSys__Build_Z1,
    [STAGE_HIDDEN_ISLAND_8]   = MapFarSys__Build_Z3,
    [STAGE_HIDDEN_ISLAND_9]   = MapFarSys__Build_Z2,
    [STAGE_HIDDEN_ISLAND_10]  = MapFarSys__Build_Z2,
    [STAGE_HIDDEN_ISLAND_11]  = MapFarSys__Build_Z3,
    [STAGE_HIDDEN_ISLAND_12]  = MapFarSys__Build_Z5,
    [STAGE_HIDDEN_ISLAND_13]  = MapFarSys__Build_Z5,
    [STAGE_HIDDEN_ISLAND_14]  = MapFarSys__Build_Z9,
    [STAGE_HIDDEN_ISLAND_15]  = MapFarSys__Build_Z4,
    [STAGE_HIDDEN_ISLAND_16]  = MapFarSys__Build_Z9,
    [STAGE_HIDDEN_ISLAND_VS1] = MapFarSys__Build_Z1,
    [STAGE_HIDDEN_ISLAND_VS2] = MapFarSys__Build_Z2,
    [STAGE_HIDDEN_ISLAND_VS3] = MapFarSys__Build_Z3,
    [STAGE_HIDDEN_ISLAND_VS4] = MapFarSys__Build_Z4,
    [STAGE_HIDDEN_ISLAND_R1]  = MapFarSys__Build_Z9,
    [STAGE_HIDDEN_ISLAND_R2]  = MapFarSys__Build_Z9,
    [STAGE_HIDDEN_ISLAND_R3]  = MapFarSys__Build_Z9,
};

static MapFarSysReleaseFunc MapFarSys__ReleaseTable[STAGE_COUNT] = {
    [STAGE_Z11]               = NULL,
    [STAGE_Z12]               = NULL,
    [STAGE_TUTORIAL]          = NULL,
    [STAGE_Z1B]               = NULL,
    [STAGE_Z21]               = NULL,
    [STAGE_Z22]               = NULL,
    [STAGE_Z2B]               = NULL,
    [STAGE_Z31]               = NULL,
    [STAGE_Z32]               = NULL,
    [STAGE_HIDDEN_ISLAND_1]   = NULL,
    [STAGE_Z3B]               = NULL,
    [STAGE_Z41]               = NULL,
    [STAGE_Z42]               = NULL,
    [STAGE_Z4B]               = NULL,
    [STAGE_Z51]               = NULL,
    [STAGE_Z52]               = NULL,
    [STAGE_Z5B]               = NULL,
    [STAGE_Z61]               = NULL,
    [STAGE_Z62]               = NULL,
    [STAGE_HIDDEN_ISLAND_2]   = NULL,
    [STAGE_Z6B]               = NULL,
    [STAGE_Z71]               = NULL,
    [STAGE_Z72]               = NULL,
    [STAGE_Z7B]               = NULL,
    [STAGE_BOSS_FINAL]        = NULL,
    [STAGE_HIDDEN_ISLAND_3]   = NULL,
    [STAGE_HIDDEN_ISLAND_4]   = NULL,
    [STAGE_HIDDEN_ISLAND_5]   = NULL,
    [STAGE_HIDDEN_ISLAND_6]   = NULL,
    [STAGE_HIDDEN_ISLAND_7]   = NULL,
    [STAGE_HIDDEN_ISLAND_8]   = NULL,
    [STAGE_HIDDEN_ISLAND_9]   = NULL,
    [STAGE_HIDDEN_ISLAND_10]  = NULL,
    [STAGE_HIDDEN_ISLAND_11]  = NULL,
    [STAGE_HIDDEN_ISLAND_12]  = NULL,
    [STAGE_HIDDEN_ISLAND_13]  = NULL,
    [STAGE_HIDDEN_ISLAND_14]  = NULL,
    [STAGE_HIDDEN_ISLAND_15]  = NULL,
    [STAGE_HIDDEN_ISLAND_16]  = NULL,
    [STAGE_HIDDEN_ISLAND_VS1] = NULL,
    [STAGE_HIDDEN_ISLAND_VS2] = NULL,
    [STAGE_HIDDEN_ISLAND_VS3] = NULL,
    [STAGE_HIDDEN_ISLAND_VS4] = NULL,
    [STAGE_HIDDEN_ISLAND_R1]  = NULL,
    [STAGE_HIDDEN_ISLAND_R2]  = NULL,
    [STAGE_HIDDEN_ISLAND_R3]  = NULL,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void MapFarSys__Func_200D144(u32 *dst, s32 start, s32 end, s32 waterLevel, s32 a5, s32 a6, s32 a7, struct MapFarSysUnknown200D144 *unknown);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE LoadScrollInfo(void *info)
{
    MapFarSys__sVars.scrollControl->scroll1[GRAPHICS_ENGINE_A][0] = info;
    MapFarSys__sVars.scrollControl->scroll1[GRAPHICS_ENGINE_B][0] = info;
}

// --------------------
// FUNCTIONS
// --------------------

// MapFarSys
void MapFarSys__SetAsset(void *asset)
{
    MapFarSys__sVars.asset = asset;
}

void *MapFarSys__GetAsset(void)
{
    return MapFarSys__sVars.asset;
}

void MapFarSys__Release(void)
{
    if (MapFarSys__sVars.asset != NULL)
    {
        HeapFree(HEAP_USER, MapFarSys__sVars.asset);
        MapFarSys__sVars.asset = NULL;
    }
}

void MapFarSys__Build(void)
{
    void *background = MapFarSys__GetAsset();

    MapFarSys__sVars.flags &= ~3;

    if (background != NULL && !IsBossStage())
    {
        MI_CpuClear32(VRAM_BG + 0x8000, 0x8000);
        MI_CpuClear32(VRAM_DB_BG + 0x8000, 0x8000);
        MI_CpuClear32(VRAM_BG + 0x4000, 0x2000);
        MI_CpuClear32(VRAM_DB_BG + 0x4000, 0x2000);

        MapFarSys__LoadBackgroundGraphics(background);

        MapFarSys__sVars.flags |= 1;

        ((u16 *)VRAM_BG_PLTT)[0]    = GX_RGB_888(0x00, 0x00, 0x00);
        ((u16 *)VRAM_DB_BG_PLTT)[0] = GX_RGB_888(0x00, 0x00, 0x00);

        if (GetBackgroundFormat(background) == BACKGROUND_FORMAT_TEXT_16)
            MapFarSys__sVars.flags |= 2;
    }
}

void MapFarSys__BuildBG(void)
{
    u16 stageID = gameState.stageID;

    if (MapFarSys__BuildTable[stageID] != NULL)
    {
        MapFarSys__sVars.scrollControl = HeapAllocHead(HEAP_USER, sizeof(*MapFarSys__sVars.scrollControl));
        MI_CpuClear16(MapFarSys__sVars.scrollControl, sizeof(*MapFarSys__sVars.scrollControl));

        MapFarSys__sVars.scrollControl->scrollSpeedY[0] = MapFarSys__sVars.scrollControl->scrollSpeedY[1] = 512;

        MapFarSys__BuildTable[stageID]();
    }

    MapFarSys__InitBackgroundLayer();
}

void MapFarSys__ReleaseBG(void)
{
    u16 stageID = gameState.stageID;

    RenderCore_StopDMA(0);
    RenderCore_StopDMA(1);

    if (MapFarSys__ReleaseTable[stageID] != NULL)
        MapFarSys__ReleaseTable[stageID]();

    if (MapFarSys__sVars.scrollControl != NULL)
    {
        if (MapFarSys__sVars.scrollControl->task != NULL)
            DestroyTask(MapFarSys__sVars.scrollControl->task);

        HeapFree(HEAP_USER, MapFarSys__sVars.scrollControl);
        MapFarSys__sVars.scrollControl = NULL;
    }
}

void MapFarSys__ProcessBG(void)
{
    u16 stageID = gameState.stageID;

    if ((MapFarSys__sVars.flags & 1) != 0)
    {
        if (MapFarSys__ProcessTable[stageID] != NULL)
            MapFarSys__ProcessTable[stageID]();

        for (u8 c = 0; c <= 1; c++)
        {
            MapSysCamera *camera = &mapCamera.camera[c];

            VRAMSystem__GFXControl[c]->bgPosition[BACKGROUND_1].x = (0x1FF & FX32_TO_WHOLE(camera->bgPos.x));
            VRAMSystem__GFXControl[c]->bgPosition[BACKGROUND_1].y = (0x1FF & FX32_TO_WHOLE(camera->bgPos.y));
        }
    }
}

void MapFarSys__SetScrollSpeed(s32 id, fx32 x1, fx32 x2)
{
    if (MapFarSys__sVars.scrollControl != NULL)
    {
        MapFarSys__sVars.scrollControl->scrollSpeed[id].x = x1;
        MapFarSys__sVars.scrollControl->scrollSpeed[id].y = x2;
    }
}

void MapFarSys__AdvanceScrollSpeed(s32 id, fx32 move)
{
    if (MapFarSys__sVars.scrollControl != NULL)
        MapFarSys__sVars.scrollControl->scrollSpeed[id].x += move;
}

void MapFarSys__Func_200B524(s32 a1, s32 a2, s32 a3, s8 id)
{
    if (MapFarSys__sVars.scrollControl != NULL && id >= 0 && id < 2)
    {
        if (a3 != MapFarSys__sVars.scrollControl->field_638[id])
        {
            MapFarSys__sVars.scrollControl->field_638[id] = a3;
            MapFarSys__sVars.scrollControl->flags |= 1 << id;
        }
    }
}

NONMATCH_FUNC void MapFarSys__LoadBackgroundGraphics(void *bgFile)
{
	// https://decomp.me/scratch/wijbx -> 99.71%
	// Minor register mismatch
#ifdef NON_MATCHING
    struct BGConfig
    {
        void *destPixelsPtr;
        void *destPalettePtr;
        PaletteMode paletteMode;
        MappingsMode mappingsMode;
    };

    struct BGConfig bgControl[GRAPHICS_ENGINE_COUNT] =
	{
		[GRAPHICS_ENGINE_A] =
		{
			.destPixelsPtr = (VRAM_BG + 0x8000), 
			.destPalettePtr = VRAM_BG_PLTT, 
			.paletteMode = PALETTE_MODE_BG, 
			.mappingsMode = MAPPINGS_MODE_TEXT_512x512_A,
		},
		
		[GRAPHICS_ENGINE_B] =
		{
			.destPixelsPtr = (VRAM_DB_BG + 0x8000), 
			.destPalettePtr = VRAM_DB_BG_PLTT, 
			.paletteMode = PALETTE_MODE_SUB_BG, 
			.mappingsMode = MAPPINGS_MODE_TEXT_512x512_B,
		},
	};

    s32 i;
    u16 height;
    u16 width;
    u8 j;
    BackgroundFormat format;

    format = GetBackgroundFormat(bgFile);
    width  = GetBackgroundWidth(bgFile);
    height = GetBackgroundHeight(bgFile);
    for (i = 0; i < GRAPHICS_ENGINE_COUNT; i++)
    {
        void *pixels;
        void *palette;
        void *mappings;

        pixels = GetBackgroundPixels(bgFile);
        RenderCore_CPUCopyCompressed(pixels, bgControl[i].destPixelsPtr);
        MapFarSys__sVars.bbgTileCount = GetBackgroundTileCount(bgFile);

        palette = GetBackgroundPalette(bgFile);
        switch (format)
        {
            case BACKGROUND_FORMAT_TEXT_16:
                LoadCompressedPalette(palette, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(bgControl[i].destPalettePtr));
                break;

            case BACKGROUND_FORMAT_TEXT_256:
                LoadCompressedPalette(palette, bgControl[i].paletteMode, VRAMKEY_TO_KEY(0x6200));
                break;
        }

        mappings = GetBackgroundMappings(bgFile);
        if (width == (BG_DISPLAY_FULL_WIDTH * 2))
        {
            Mappings__ReadMappings(mappings, 0, 0, BG_DISPLAY_FULL_WIDTH * 2, GetBackgroundFlag(bgFile), bgControl[i].mappingsMode, GX_BGSCROFFSET_0x00000, 8, 0, 0,
                                   BG_DISPLAY_FULL_WIDTH * 2, height);
        }
        else
        {
            for (j = 0; j < BG_DISPLAY_FULL_WIDTH * 2; j += BG_DISPLAY_FULL_WIDTH)
            {
                Mappings__ReadMappings(mappings, 0, 0, BG_DISPLAY_FULL_WIDTH, GetBackgroundFlag(bgFile), bgControl[i].mappingsMode, GX_BGSCROFFSET_0x00000, 8, j, 0,
                                       BG_DISPLAY_FULL_WIDTH, height);
            }
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x48
	ldr r5, =_0210E120
	add r4, sp, #0x28
	mov r10, r0
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r5, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	mov r0, r10
	bl GetBackgroundFormat
	str r0, [sp, #0x20]
	mov r0, r10
	bl GetBackgroundWidth
	str r0, [sp, #0x24]
	mov r0, r10
	bl GetBackgroundHeight
	mov r6, r0
	mov r5, #0
_0200B5C4:
	mov r0, r10
	bl GetBackgroundPixels
	add r1, sp, #0x28
	ldr r1, [r1, r5, lsl #4]
	bl RenderCore_CPUCopyCompressed
	mov r0, r10
	bl GetBackgroundTileCount
	ldr r1, =MapFarSys__sVars
	str r0, [r1, #4]
	mov r0, r10
	bl GetBackgroundPalette
	ldr r1, [sp, #0x20]
	cmp r1, #0
	beq _0200B608
	cmp r1, #1
	beq _0200B620
	b _0200B634
_0200B608:
	add r2, sp, #0x28
	add r2, r2, r5, lsl #4
	ldr r2, [r2, #4]
	mov r1, #0
	bl LoadCompressedPalette
	b _0200B634
_0200B620:
	add r1, sp, #0x28
	add r1, r1, r5, lsl #4
	ldr r1, [r1, #8]
	mov r2, #0x6200
	bl LoadCompressedPalette
_0200B634:
	mov r0, r10
	bl GetBackgroundMappings
	mov r9, r0
	ldr r0, [sp, #0x24]
	cmp r0, #0x40
	bne _0200B698
	mov r0, r10
	bl GetBackgroundFlag
	add r1, sp, #0x28
	str r0, [sp]
	add r0, r1, r5, lsl #4
	mov r1, #0
	ldr r0, [r0, #0xc]
	mov r3, #0x40
	stmib sp, {r0, r1}
	mov r0, #8
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, r9
	mov r2, r1
	str r6, [sp, #0x1c]
	bl Mappings__ReadMappings
	b _0200B6FC
_0200B698:
	add r0, sp, #0x28
	add r0, r0, r5, lsl #4
	ldr r8, [r0, #0xc]
	mov r7, #0
	mov r4, #8
	mov r11, #0x20
_0200B6B0:
	mov r0, r10
	bl GetBackgroundFlag
	stmia sp, {r0, r8}
	mov r0, #0
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r7, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r1, #0
	str r11, [sp, #0x18]
	mov r0, r9
	mov r2, r1
	mov r3, r11
	str r6, [sp, #0x1c]
	bl Mappings__ReadMappings
	add r0, r7, #0x20
	and r7, r0, #0xff
	cmp r7, #0x40
	blo _0200B6B0
_0200B6FC:
	add r5, r5, #1
	cmp r5, #2
	blt _0200B5C4
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void MapFarSys__InitBackgroundLayer(void)
{
    if ((MapFarSys__sVars.flags & 1) != 0)
    {
        mapCamera.camera[0].flags |= MAPSYS_CAMERA_FLAG_4;
        mapCamera.camera[1].flags |= MAPSYS_CAMERA_FLAG_4;
    }
    else
    {
        mapCamera.camera[0].flags &= ~MAPSYS_CAMERA_FLAG_4;
        mapCamera.camera[1].flags &= ~MAPSYS_CAMERA_FLAG_4;

        return;
    }

    if ((MapFarSys__sVars.flags & 2) != 0)
    {
        G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x512, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x4000, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_23);
        G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x512, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x4000, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_23);
    }
    else
    {
        G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x512, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x4000, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_23);
        G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x512, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x4000, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_23);
    }
}

void MapFarSys__Build_Z1(void)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        MapSysCamera *cameraA = MapSys__GetCameraA();
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = MapSys__GetCameraB();
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(272.0);
    }
    else
    {
        MapSysCamera *cameraA = &mapCamera.camera[GRAPHICS_ENGINE_A];
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = &mapCamera.camera[GRAPHICS_ENGINE_B];
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(0.0);
    }

    MapFarSys__sVars.scrollControl->scrollSpeedY[0] = MapFarSys__sVars.scrollControl->scrollSpeedY[1] = 512;

    if (gameState.stageID == STAGE_Z11 || gameState.stageID == STAGE_TUTORIAL)
    {
        RenderCore_PrepareDMA(0, MapFarSys__sVars.scrollControl->bg1VOfs, MapFarSys__sVars.scrollControl->bg1VOfs_2, (void *)REG_BG1VOFS_ADDR, 2);
        RenderCore_PrepareDMA(1, MapFarSys__sVars.scrollControl->bg1VOfs_sub, MapFarSys__sVars.scrollControl->bg1VOfs_sub_2, (void *)REG_DB_BG1VOFS_ADDR, 2);

        if (gameState.stageID == STAGE_Z11)
        {
            if ((gameState.gameFlag & (GAME_FLAG_USE_WIFI | GAME_FLAG_IS_VS_BATTLE)) == (GAME_FLAG_USE_WIFI | GAME_FLAG_IS_VS_BATTLE))
            {
                LoadScrollInfo(_0210E23C);
            }
            else
            {
                LoadScrollInfo(_0210E1D4);
            }
        }
        else
        {
            LoadScrollInfo(_0210E30C);

            MapFarSys__sVars.scrollControl->scrollSpeedY[0] = MapFarSys__sVars.scrollControl->scrollSpeedY[1] = 464;
        }
    }
}

void MapFarSys__Build_Z2(void)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        MapSysCamera *cameraA = MapSys__GetCameraA();
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = MapSys__GetCameraB();
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(272.0);
    }
    else
    {
        MapSysCamera *cameraA = &mapCamera.camera[GRAPHICS_ENGINE_A];
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = &mapCamera.camera[GRAPHICS_ENGINE_B];
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(0.0);
    }

    MapFarSys__sVars.scrollControl->scrollSpeedY[0] = MapFarSys__sVars.scrollControl->scrollSpeedY[1] = 464;

    RenderCore_PrepareDMA(0, MapFarSys__sVars.scrollControl->bg1VOfs, MapFarSys__sVars.scrollControl->bg1VOfs_2, (void *)REG_BG1VOFS_ADDR, 2);
    RenderCore_PrepareDMA(1, MapFarSys__sVars.scrollControl->bg1VOfs_sub, MapFarSys__sVars.scrollControl->bg1VOfs_sub_2, (void *)REG_DB_BG1VOFS_ADDR, 2);

    LoadScrollInfo(_0210E160);
}

void MapFarSys__Build_Z3(void)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        MapSysCamera *cameraA = MapSys__GetCameraA();
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = MapSys__GetCameraB();
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(272.0);
    }
    else
    {
        MapSysCamera *cameraA = &mapCamera.camera[GRAPHICS_ENGINE_A];
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = &mapCamera.camera[GRAPHICS_ENGINE_B];
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(0.0);
    }

    MapFarSys__sVars.scrollControl->scrollSpeedY[0] = FLOAT_TO_FX32(0.125);
    MapFarSys__sVars.scrollControl->scrollSpeedY[1] = FLOAT_TO_FX32(0.125);

    MapFarSysUnknownUnknown *unknown = &MapFarSys__sVars.scrollControl->field_63C;
    MI_CpuClear32(unknown, sizeof(MapFarSys__sVars.scrollControl->field_63C.x16));
    RenderCore_PrepareDMA(0, unknown->x16.field_4[0], unknown->x16.field_4[8], (void *)REG_BG1HOFS_ADDR, 4);
    RenderCore_PrepareDMA(1, unknown->x16.field_4[4], unknown->x16.field_4[12], (void *)REG_DB_BG1OFS_ADDR, 4);
}

void MapFarSys__Build_Z4(void)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        MapSysCamera *cameraA = MapSys__GetCameraA();
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = MapSys__GetCameraB();
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(272.0);
    }
    else
    {
        MapSysCamera *cameraA = &mapCamera.camera[GRAPHICS_ENGINE_A];
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = &mapCamera.camera[GRAPHICS_ENGINE_B];
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(0.0);
    }

    MapFarSys__sVars.scrollControl->scrollSpeedY[0] = FLOAT_TO_FX32(0.125);
    MapFarSys__sVars.scrollControl->scrollSpeedY[1] = FLOAT_TO_FX32(0.125);

    MapFarSysUnknownUnknown *unknown = &MapFarSys__sVars.scrollControl->field_63C;
    MI_CpuClear32(unknown, sizeof(MapFarSys__sVars.scrollControl->field_63C.x8));
    RenderCore_PrepareDMA(0, unknown->x8.field_4[0], unknown->x8.field_4[4], (void *)REG_BG1HOFS_ADDR, 2);
    RenderCore_PrepareDMA(1, unknown->x8.field_4[2], unknown->x8.field_4[6], (void *)REG_DB_BG1OFS_ADDR, 2);
}

void MapFarSys__Build_Z5(void)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        MapSysCamera *cameraA = MapSys__GetCameraA();
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = MapSys__GetCameraB();
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(BOTTOM_SCREEN_CAMERA_OFFSET);
    }
    else
    {
        MapSysCamera *cameraA = &mapCamera.camera[0];
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = &mapCamera.camera[1];
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(0.0);
    }

    MapFarSys__sVars.scrollControl->scrollSpeedY[0] = MapFarSys__sVars.scrollControl->scrollSpeedY[1] = FLOAT_TO_FX32(0.125);
}

void MapFarSys__Build_Z6(void)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        MapSysCamera *cameraA = MapSys__GetCameraA();
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = MapSys__GetCameraB();
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(272.0);
    }
    else
    {
        MapSysCamera *cameraA = &mapCamera.camera[GRAPHICS_ENGINE_A];
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = &mapCamera.camera[GRAPHICS_ENGINE_B];
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(0.0);
    }

    MapFarSys__sVars.scrollControl->scrollSpeedY[0] = MapFarSys__sVars.scrollControl->scrollSpeedY[1] = FLOAT_TO_FX32(0.125);

    MapFarSysUnknownUnknown *unknown = &MapFarSys__sVars.scrollControl->field_63C;
    MI_CpuClear32(unknown, sizeof(MapFarSys__sVars.scrollControl->field_63C.x8));
    RenderCore_PrepareDMA(0, unknown->x8.field_4[0], unknown->x8.field_4[4], (void *)REG_BG1HOFS_ADDR, 2);
    RenderCore_PrepareDMA(1, unknown->x8.field_4[2], unknown->x8.field_4[6], (void *)REG_DB_BG1OFS_ADDR, 2);
}

void MapFarSys__Build_Z7(void)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        MapSysCamera *cameraA = MapSys__GetCameraA();
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = MapSys__GetCameraB();
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(272.0);
    }
    else
    {
        MapSysCamera *cameraA = &mapCamera.camera[GRAPHICS_ENGINE_A];
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = &mapCamera.camera[GRAPHICS_ENGINE_B];
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(0.0);
    }

    MapFarSys__sVars.scrollControl->scrollSpeedY[0] = MapFarSys__sVars.scrollControl->scrollSpeedY[1] = 464; // FLOAT_TO_FX32(0.11328125)

    MapFarSysUnknownUnknown *unknown = &MapFarSys__sVars.scrollControl->field_63C;
    MI_CpuClear32(unknown, sizeof(MapFarSys__sVars.scrollControl->field_63C.x16));
    RenderCore_PrepareDMA(0, unknown->x16.field_4[0], unknown->x16.field_4[8], (void *)REG_BG1HOFS_ADDR, 4);
    RenderCore_PrepareDMA(1, unknown->x16.field_4[4], unknown->x16.field_4[12], (void *)REG_DB_BG1OFS_ADDR, 4);
}

void MapFarSys__Build_Z9(void)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        MapSysCamera *cameraA = MapSys__GetCameraA();
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = MapSys__GetCameraB();
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(272.0);
    }
    else
    {
        MapSysCamera *cameraA = &mapCamera.camera[GRAPHICS_ENGINE_A];
        cameraA->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y      = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = &mapCamera.camera[GRAPHICS_ENGINE_B];
        cameraB->bgPos.x      = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y      = FLOAT_TO_FX32(0.0);
    }

    MapFarSys__sVars.scrollControl->scrollSpeedY[0] = MapFarSys__sVars.scrollControl->scrollSpeedY[1] = FLOAT_TO_FX32(0.125);

    MapFarSysUnknownUnknown *unknown = &MapFarSys__sVars.scrollControl->field_63C;
    MI_CpuClear32(unknown, sizeof(MapFarSys__sVars.scrollControl->field_63C.x8));
    RenderCore_PrepareDMA(0, unknown->x8.field_4[0], unknown->x8.field_4[4], (void *)REG_BG1HOFS_ADDR, 2);
    RenderCore_PrepareDMA(1, unknown->x8.field_4[2], unknown->x8.field_4[6], (void *)REG_DB_BG1OFS_ADDR, 2);
}

NONMATCH_FUNC void MapFarSys__Process_Z1(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r0, #0xe
	bl MapFarSys__DoFarScrollX
	bl MapFarSys__DoFarScrollY
	ldr r0, =MapFarSys__sVars
	ldr r2, =mapCamera
	ldr r0, [r0, #8]
	ldr ip, [r2, #0x38]
	ldr r3, [r0, #0x10]
	ldr r1, =gameState
	add r3, ip, r3
	str r3, [r2, #0x38]
	ldr ip, [r2, #0xa8]
	ldr r3, [r0, #0x18]
	add r3, ip, r3
	str r3, [r2, #0xa8]
	ldrh r1, [r1, #0x28]
	cmp r1, #0
	cmpne r1, #2
	ldmneia sp!, {r3, pc}
	cmp r1, #0
	bne _0200C0C8
	ldr r1, =mapCamera
	ldr r2, [r1, #0xe0]
	ldr r1, [r1, #4]
	tst r2, #1
	beq _0200C03C
	cmp r1, #0x600000
	blt _0200BFF0
	ldr r2, =_0210E2A4
	ldr r1, =MapFarSys__sVars
	str r2, [r0, #0x62c]
	ldr r1, [r1, #8]
	ldr r0, [r1, #0x62c]
	str r0, [r1, #0x620]
	b _0200C0C8
_0200BFF0:
	ldr r1, =gameState
	ldr r1, [r1, #0x10]
	and r1, r1, #0x420
	cmp r1, #0x420
	bne _0200C020
	ldr r2, =_0210E23C
	ldr r1, =MapFarSys__sVars
	str r2, [r0, #0x62c]
	ldr r1, [r1, #8]
	ldr r0, [r1, #0x62c]
	str r0, [r1, #0x620]
	b _0200C0C8
_0200C020:
	ldr r2, =_0210E1D4
	ldr r1, =MapFarSys__sVars
	str r2, [r0, #0x62c]
	ldr r1, [r1, #8]
	ldr r0, [r1, #0x62c]
	str r0, [r1, #0x620]
	b _0200C0C8
_0200C03C:
	cmp r1, #0x600000
	ldrge r1, =_0210E2A4
	strge r1, [r0, #0x620]
	bge _0200C06C
	ldr r1, =gameState
	ldr r1, [r1, #0x10]
	and r1, r1, #0x420
	cmp r1, #0x420
	ldreq r1, =_0210E23C
	streq r1, [r0, #0x620]
	ldrne r1, =_0210E1D4
	strne r1, [r0, #0x620]
_0200C06C:
	ldr r0, =mapCamera
	ldr r0, [r0, #0x74]
	cmp r0, #0x600000
	blt _0200C090
	ldr r0, =MapFarSys__sVars
	ldr r1, =_0210E2A4
	ldr r0, [r0, #8]
	str r1, [r0, #0x62c]
	b _0200C0C8
_0200C090:
	ldr r0, =gameState
	ldr r0, [r0, #0x10]
	and r0, r0, #0x420
	cmp r0, #0x420
	bne _0200C0B8
	ldr r0, =MapFarSys__sVars
	ldr r1, =_0210E23C
	ldr r0, [r0, #8]
	str r1, [r0, #0x62c]
	b _0200C0C8
_0200C0B8:
	ldr r0, =MapFarSys__sVars
	ldr r1, =_0210E1D4
	ldr r0, [r0, #8]
	str r1, [r0, #0x62c]
_0200C0C8:
	bl MapFarSys__ProcessScroll
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Process_Z2(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov lr, #0
	mov r0, #0x1d0
	ldr r1, =_0210E094
	ldr r3, =_0210E160
	ldr r6, =MapFarSys__sVars
	mov r4, lr
	mov r2, r0
	mov ip, #1
_0200C10C:
	ldr r7, [r6, #8]
	ldr r5, [r7, #0]
	tst r5, ip, lsl lr
	beq _0200C17C
	add r5, r7, lr, lsl #1
	add r5, r5, #0x600
	ldrh r5, [r5, #0x38]
	cmp r5, #0
	beq _0200C13C
	cmp r5, #1
	beq _0200C154
	b _0200C168
_0200C13C:
	add r5, r7, r4
	str r3, [r5, #0x620]
	ldr r5, [r6, #8]
	add r5, r5, lr, lsl #2
	str r2, [r5, #8]
	b _0200C168
_0200C154:
	add r5, r7, r4
	str r1, [r5, #0x620]
	ldr r5, [r6, #8]
	add r5, r5, lr, lsl #2
	str r0, [r5, #8]
_0200C168:
	ldr r8, [r6, #8]
	mvn r5, ip, lsl lr
	ldr r7, [r8, #0]
	and r5, r7, r5
	str r5, [r8]
_0200C17C:
	add lr, lr, #1
	cmp lr, #2
	add r4, r4, #0xc
	blt _0200C10C
	mov r0, #0xe
	bl MapFarSys__DoFarScrollX
	bl MapFarSys__DoFarScrollY
	bl MapFarSys__ProcessScroll
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Process_Z3(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	ldr r0, =mapCamera
	ldr r1, =MapFarSys__sVars
	ldr r2, [r0, #0xe0]
	ldr r0, [r1, #8]
	tst r2, #1
	movne r10, #0x1d0
	mov r5, #0
	moveq r10, #0xc0
	str r0, [sp, #0x1c]
	cmp r5, #2
	bge _0200C474
	sub r0, r10, #0xe0
	str r0, [sp, #0x18]
_0200C1E8:
	ldr r0, =MapFarSys__sVars
	ldr r1, [r0, #8]
	and r0, r5, #0xff
	add r1, r1, r5, lsl #3
	ldr r7, [r1, #0x10]
	bl RenderCore_GetDMASrc
	mov r6, r0
	ldr r0, =mapCamera
	mov r1, #0x70
	mla r4, r5, r1, r0
	ldr r1, [r4, #8]
	ldr r0, [r0, #0xe0]
	ldrh r9, [r4, #0x6e]
	mov r8, r1, asr #0xc
	tst r0, #1
	beq _0200C234
	bl MapSys__GetCameraA
	cmp r4, r0
	subne r8, r8, #0x110
_0200C234:
	sub r8, r9, r8
	cmp r8, r10
	bge _0200C290
	ldr r0, =mapCamera+0x00000100
	ldrh r0, [r0, #0x2c]
	sub r0, r0, r10
	sub r1, r9, r0
	sub r0, r8, r1
	mov r0, r0, lsl #0xc
	sub r1, r10, r1
	bl FX_DivS32
	mov r1, #0
	mov r3, r0
	str r1, [sp]
	ldr r0, [sp, #0x18]
	add r1, r10, #0x30
	mov r2, #0x1000
	bl Unknown2051334__Func_2051534
	mov r9, r0
	sub r0, r9, r8
	cmp r0, #0x30
	addlt r9, r8, #0x30
	b _0200C294
_0200C290:
	add r9, r8, #0x30
_0200C294:
	bl MapSys__GetCameraA
	cmp r4, r0
	beq _0200C2B0
	ldr r0, =mapCamera
	ldr r0, [r0, #0xe0]
	tst r0, #1
	bne _0200C2B8
_0200C2B0:
	mov r11, #0
	b _0200C2BC
_0200C2B8:
	mov r11, #0x110
_0200C2BC:
	ldr r0, =mapCamera
	ldr r0, [r0, #0xe0]
	tst r0, #1
	beq _0200C2DC
	bl MapSys__GetCameraA
	cmp r0, r4
	subne r8, r8, #0x110
	subne r9, r9, #0x110
_0200C2DC:
	cmp r8, #0
	ble _0200C334
	ldr r1, [r4, #4]
	cmp r8, #0xc0
	add r1, r1, r7, lsl #4
	suble r0, r8, #1
	str r1, [sp]
	mov r1, #0x100
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp, #8]
	ldr r1, =_0210E140
	movgt r2, #0xbf
	movle r0, r0, lsl #0x10
	movle r2, r0, lsr #0x10
	rsb r0, r11, #0
	mov r0, r0, lsl #0x10
	mov r3, r0, asr #0x10
	str r1, [sp, #0xc]
	mov r0, r6
	mov r1, #0
	bl MapFarSys__Func_200D144
_0200C334:
	cmp r8, #0xc0
	bge _0200C39C
	cmp r9, #0
	ble _0200C39C
	ldr r3, [r4, #4]
	cmp r8, #0
	add r3, r3, r7, lsl #4
	str r3, [sp]
	mov r3, #0x100
	str r3, [sp, #4]
	mov r3, #0
	str r3, [sp, #8]
	ldr r3, =_0210E0A4
	movlt r1, #0
	movge r0, r8, lsl #0x10
	movge r1, r0, lsr #0x10
	cmp r9, #0xc0
	suble r0, r9, #1
	str r3, [sp, #0xc]
	mov r3, r8, lsl #0x10
	movgt r2, #0xbf
	movle r0, r0, lsl #0x10
	movle r2, r0, lsr #0x10
	mov r0, r6
	mov r3, r3, asr #0x10
	bl MapFarSys__Func_200D144
_0200C39C:
	cmp r9, #0xc0
	bge _0200C3EC
	ldr r2, [r4, #4]
	cmp r9, #0
	add r2, r2, r7, lsl #4
	str r2, [sp]
	mov r2, #0x100
	str r2, [sp, #4]
	mov r2, #0x200
	str r2, [sp, #8]
	ldr r2, =_0210E0D8
	mov r3, r9, lsl #0x10
	str r2, [sp, #0xc]
	movlt r1, #0
	movge r0, r9, lsl #0x10
	movge r1, r0, lsr #0x10
	mov r0, r6
	mov r2, #0xbf
	mov r3, r3, asr #0x10
	bl MapFarSys__Func_200D144
_0200C3EC:
	cmp r8, #0xc0
	bge _0200C460
	cmp r8, #0
	rsblt r0, r8, #0
	movlt r1, #0
	movge r0, r8, lsl #0x10
	movge r1, r0, lsr #0x10
	movge r0, #0
	mov r0, r0, lsl #4
	add r4, r0, #0x2000
	mov r2, #0
	stmia sp, {r2, r4}
	sub r0, r1, r9
	mov r2, #0x40
	str r2, [sp, #8]
	mov r2, #0x8000
	str r2, [sp, #0xc]
	mov r2, #0
	str r2, [sp, #0x10]
	ldr r2, [sp, #0x1c]
	mov r3, r0, lsl #0xf
	ldr r4, [r2, #0x63c]
	mov r0, r6
	add r3, r3, r4, lsl #13
	str r3, [sp, #0x14]
	and r1, r1, #0xff
	mov r2, #0xbf
	mov r3, #0
	bl FontDMAControl__Func_20520B0
_0200C460:
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r5, r5, #1
	cmp r5, #2
	blt _0200C1E8
_0200C474:
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp, #0x1c]
	str r1, [r0, #0x63c]
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Process_Z4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	ldr r0, =_0210E074
	ldr r1, =MapFarSys__sVars
	ldrh r9, [r0, #0x18]
	ldrh r8, [r0, #0x1a]
	ldrh r7, [r0, #0x1c]
	ldrh r6, [r0, #0x1e]
	ldrh r5, [r0, #0x10]
	ldrh r4, [r0, #0x12]
	ldrh r3, [r0, #0x14]
	ldrh r2, [r0, #0x16]
	ldr r1, [r1, #8]
	mov r0, #0xe
	strh r9, [sp, #0xc]
	strh r8, [sp, #0xe]
	strh r7, [sp, #0x10]
	strh r6, [sp, #0x12]
	strh r5, [sp, #4]
	strh r4, [sp, #6]
	strh r3, [sp, #8]
	strh r2, [sp, #0xa]
	str r1, [sp]
	bl MapFarSys__DoFarScrollX
	bl MapFarSys__DoFarScrollY
	ldr r0, =MapFarSys__sVars
	ldr r1, =mapCamera
	ldr r4, [r0, #8]
	ldr r3, [r1, #0x38]
	ldr r2, [r4, #0x10]
	mov r0, #0
	add r2, r3, r2
	str r2, [r1, #0x38]
	ldr r3, [r1, #0xa8]
	ldr r2, [r4, #0x18]
	add r2, r3, r2
	str r2, [r1, #0xa8]
	ldr r1, [sp]
	add r3, sp, #4
	ldr r5, [r1, #0x63c]
	add r1, sp, #0x14
_0200C54C:
	mov r4, r0, lsl #1
	ldrsh r2, [r3, r4]
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mul r2, r5, r2
	mov r2, r2, lsr #0xc
	mov r0, r0, lsr #0x10
	strh r2, [r1, r4]
	cmp r0, #4
	blo _0200C54C
	mov r5, #0
	cmp r5, #2
	bge _0200C650
_0200C580:
	and r0, r5, #0xff
	bl RenderCore_GetDMASrc
	ldr r2, =mapCamera
	mov r1, #0x70
	mla r2, r5, r1, r2
	ldr r1, [r2, #0x3c]
	ldr r2, [r2, #0x38]
	mov r1, r1, lsl #4
	mov r2, r2, asr #0xc
	mov r7, #0
	mov r6, r0
	mov r10, r7
	mov r1, r1, lsr #0x10
	mov r4, r2, lsl #0x10
	add r11, sp, #0xc
_0200C5BC:
	mov r0, r10, lsl #1
	ldrh r9, [r11, r0]
	cmp r1, r9
	bhs _0200C628
	sub r0, r9, r1
	mov r0, r0, lsl #0x10
	add r1, r7, r0, lsr #16
	cmp r1, #0xc0
	mov r8, r0, lsr #0x10
	rsbgt r0, r7, #0xc0
	movgt r0, r0, lsl #0x10
	movgt r8, r0, lsr #0x10
	cmp r8, #0
	beq _0200C618
	mov r1, r10, lsl #1
	add r0, sp, #0x14
	ldrh r0, [r0, r1]
	add r1, r6, r7, lsl #1
	mov r2, r8, lsl #1
	add r0, r0, r4, lsr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MIi_CpuClear16
_0200C618:
	add r0, r7, r8
	mov r0, r0, lsl #0x10
	mov r1, r9
	mov r7, r0, lsr #0x10
_0200C628:
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
	cmp r10, #4
	blo _0200C5BC
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r5, r5, #1
	cmp r5, #2
	blt _0200C580
_0200C650:
	ldr r0, [sp]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp]
	str r1, [r0, #0x63c]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void MapFarSys__Process_Z5(void)
{
    MapFarSys__DoFarScrollX(14);
    MapFarSys__DoFarScrollY();

    mapCamera.camera[0].bgPos.x += MapFarSys__sVars.scrollControl->scrollSpeed[0].x;
    mapCamera.camera[1].bgPos.x += MapFarSys__sVars.scrollControl->scrollSpeed[1].x;
}

NONMATCH_FUNC void MapFarSys__Process_Z6(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x3c
	ldr r0, =MapFarSys__sVars
	ldr r3, =_0210E0B4
	ldr r0, [r0, #8]
	add r5, sp, #0x16
	str r0, [sp]
	mov r2, #4
_0200C6E0:
	ldrh r1, [r3, #0]
	ldrh r0, [r3, #2]
	add r3, r3, #4
	strh r1, [r5]
	strh r0, [r5, #2]
	add r5, r5, #4
	subs r2, r2, #1
	bne _0200C6E0
	ldrh r0, [r3, #0]
	ldr r4, =_0210E0C6
	add r3, sp, #4
	strh r0, [r5]
	mov r2, #4
_0200C714:
	ldrh r1, [r4, #0]
	ldrh r0, [r4, #2]
	add r4, r4, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _0200C714
	ldrh r1, [r4, #0]
	mov r0, #0xe
	strh r1, [r3]
	bl MapFarSys__DoFarScrollX
	bl MapFarSys__DoFarScrollY
	ldr r0, =MapFarSys__sVars
	ldr r1, =mapCamera
	ldr r4, [r0, #8]
	ldr r3, [r1, #0x38]
	ldr r2, [r4, #0x10]
	mov r0, #0
	add r2, r3, r2
	str r2, [r1, #0x38]
	ldr r3, [r1, #0xa8]
	ldr r2, [r4, #0x18]
	add r2, r3, r2
	str r2, [r1, #0xa8]
	ldr r1, [sp]
	add r3, sp, #4
	ldr r5, [r1, #0x63c]
	add r1, sp, #0x28
_0200C788:
	mov r4, r0, lsl #1
	ldrsh r2, [r3, r4]
	add r0, r0, #1
	cmp r0, #9
	mul r2, r5, r2
	mov r2, r2, lsr #0xc
	strh r2, [r1, r4]
	blt _0200C788
	mov r5, #0
	cmp r5, #2
	bge _0200C87C
_0200C7B4:
	and r0, r5, #0xff
	bl RenderCore_GetDMASrc
	ldr r2, =mapCamera
	mov r1, #0x70
	mla r2, r5, r1, r2
	ldr r1, [r2, #0x3c]
	ldr r2, [r2, #0x38]
	mov r1, r1, lsl #4
	mov r2, r2, asr #0xc
	mov r7, #0
	mov r6, r0
	mov r10, r7
	mov r1, r1, lsr #0x10
	mov r4, r2, lsl #0x10
	add r11, sp, #0x16
_0200C7F0:
	mov r0, r10, lsl #1
	ldrh r9, [r11, r0]
	cmp r1, r9
	bhs _0200C85C
	sub r0, r9, r1
	mov r0, r0, lsl #0x10
	add r1, r7, r0, lsr #16
	cmp r1, #0xc0
	mov r8, r0, lsr #0x10
	rsbgt r0, r7, #0xc0
	movgt r0, r0, lsl #0x10
	movgt r8, r0, lsr #0x10
	cmp r8, #0
	beq _0200C84C
	mov r1, r10, lsl #1
	add r0, sp, #0x28
	ldrh r0, [r0, r1]
	add r1, r6, r7, lsl #1
	mov r2, r8, lsl #1
	add r0, r0, r4, lsr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MIi_CpuClear16
_0200C84C:
	add r0, r7, r8
	mov r0, r0, lsl #0x10
	mov r1, r9
	mov r7, r0, lsr #0x10
_0200C85C:
	add r10, r10, #1
	cmp r10, #9
	blt _0200C7F0
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r5, r5, #1
	cmp r5, #2
	blt _0200C7B4
_0200C87C:
	ldr r0, [sp]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp]
	str r1, [r0, #0x63c]
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Process_Z7(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x40
	ldr r0, =gameState
	ldr r1, =MapFarSys__sVars
	ldr r2, [r0, #0x10]
	ldr r0, [r1, #8]
	str r0, [sp, #0x2c]
	and r0, r2, #0x420
	cmp r0, #0x420
	bne _0200C8E4
	ldr r0, =_0210E1AC
	str r0, [sp, #0x28]
	ldr r0, =_0210E108
	str r0, [sp, #0x24]
	b _0200C8F4
_0200C8E4:
	ldr r0, =_0210E184
	str r0, [sp, #0x28]
	ldr r0, =_0210E0F0
	str r0, [sp, #0x24]
_0200C8F4:
	ldr r1, =mapCamera
	ldr r0, [r1, #0xe0]
	tst r0, #1
	beq _0200C91C
	bl MapSys__GetCameraA
	str r0, [sp, #0x38]
	bl MapSys__GetCameraA
	str r0, [sp, #0x3c]
	mov r7, #0x1d0
	b _0200C92C
_0200C91C:
	ldr r0, =mapCamera+0x00000070
	str r1, [sp, #0x38]
	str r0, [sp, #0x3c]
	mov r7, #0xc0
_0200C92C:
	mov r0, #0x1c
	bl MapFarSys__DoFarScrollX
	ldr r0, =MapFarSys__sVars
	ldr r10, =mapCamera
	ldr r3, [r0, #8]
	rsb r0, r7, #0x1e0
	ldr r2, [r10, #0x38]
	ldr r1, [r3, #0x10]
	str r0, [sp, #0x20]
	add r0, r2, r1
	str r0, [r10, #0x38]
	rsb r0, r7, #0x208
	ldr r2, [r10, #0xa8]
	ldr r1, [r3, #0x18]
	str r0, [sp, #0x1c]
	add r0, r2, r1
	mvn r4, #0xbf
	str r0, [r10, #0xa8]
	add r0, r4, #0xb8
	mov r5, #0
	str r0, [sp, #0x34]
	str r0, [sp, #0x30]
_0200C984:
	add r0, sp, #0x38
	ldr r0, [r0, r5, lsl #2]
	ldrh r9, [r10, #0x6e]
	str r0, [sp, #0x18]
	ldr r3, [r10, #8]
	ldr r0, [r0, #8]
	cmp r9, #0
	sub r8, r3, r0
	beq _0200C9BC
	ldr r2, =mapCamera+0x00000100
	sub r1, r9, #8
	ldrh r2, [r2, #0x2c]
	sub r2, r2, r1
	b _0200C9CC
_0200C9BC:
	ldr r1, =mapCamera+0x00000100
	ldr r9, =0x0000FFFF
	ldrh r1, [r1, #0x2c]
	mov r2, #0
_0200C9CC:
	mov ip, r9, lsl #0xc
	add r11, r0, r7, lsl #12
	sub r6, ip, #0x8000
	cmp r11, r6
	bgt _0200CA00
	ldr r0, [sp, #0x20]
	sub r1, r1, r7
	mul r0, r3, r0
	bl FX_DivS32
	add r0, r8, r0
	str r0, [r10, #0x3c]
	mov r6, #0xbf
	b _0200CAB4
_0200CA00:
	cmp r0, r1, lsl #12
	bge _0200CA58
	rsb r1, r1, r3, asr #12
	rsb r6, r1, #0
	cmp r6, #0
	ble _0200CA48
	sub r1, r9, #8
	sub r9, r1, r0, asr #12
	sub r0, r7, r9
	mov r0, r0, lsl #0x12
	mov r1, r7
	bl FX_DivS32
	mov r1, r9, lsl #0xc
	rsb r1, r1, #0x1e0000
	sub r0, r1, r0
	add r0, r8, r0
	str r0, [r10, #0x3c]
	b _0200CAB4
_0200CA48:
	rsb r0, r6, #0
	mov r0, r0, lsl #0xc
	str r0, [r10, #0x3c]
	b _0200CAB4
_0200CA58:
	cmp r0, ip
	bge _0200CA78
	rsb r0, r1, r3, asr #12
	rsb r6, r0, #0
	rsb r0, r6, #0
	mov r0, r0, lsl #0xc
	str r0, [r10, #0x3c]
	b _0200CAB4
_0200CA78:
	sub r0, r0, r1, lsl #12
	ldr r1, [sp, #0x1c]
	sub r0, r0, #0x8000
	mul r0, r1, r0
	sub r1, r2, #8
	sub r1, r1, r7
	bl FX_DivS32
	add r0, r0, #0x8000
	add r0, r8, r0
	str r0, [r10, #0x3c]
	ldr r0, [sp, #0x18]
	ldr r0, [r0, #8]
	sub r0, r9, r0, asr #12
	sub r0, r0, #8
	sub r6, r0, r8, asr #12
_0200CAB4:
	and r0, r5, #0xff
	bl RenderCore_GetDMASrc
	mov r8, r0
	cmp r6, #0
	ble _0200CB14
	ldr r1, [r10, #0x38]
	cmp r6, #0xbf
	str r1, [sp]
	mov r1, #0x1000
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp, #8]
	ldr r1, [sp, #0x28]
	movgt r2, #0xbf
	str r1, [sp, #0xc]
	ldr r3, [r10, #0x3c]
	movle r0, r6, lsl #0x10
	rsb r3, r3, #0
	mov r3, r3, lsl #4
	movle r2, r0, lsr #0x10
	mov r0, r8
	mov r1, #0
	mov r3, r3, asr #0x10
	bl MapFarSys__Func_200D144
_0200CB14:
	cmp r6, #0xc0
	bge _0200CC48
	cmp r6, #0
	bgt _0200CB48
	ldr r0, [r10, #0x3c]
	add r2, r6, #8
	rsb r0, r0, #0
	mov r0, r0, lsl #4
	mov r9, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r1, #0
	mov r0, r0, asr #0x10
	b _0200CB5C
_0200CB48:
	mov r0, r6, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r9, r0, asr #0x10
	add r0, r1, #8
	and r0, r0, #0xff
_0200CB5C:
	cmp r0, #0
	movlt r0, #0
	blt _0200CB70
	cmp r0, #0xbf
	movgt r0, #0xbf
_0200CB70:
	ldr r2, [r10, #0x38]
	mov r0, r0, lsl #0x10
	mov r2, r2, lsl #1
	str r2, [sp]
	mov r2, #0x1000
	str r2, [sp, #4]
	mov r2, #0
	str r2, [sp, #8]
	ldr r2, [sp, #0x24]
	mov r11, r0, asr #0x10
	str r2, [sp, #0xc]
	mov r0, r8
	mov r2, #0xbf
	mov r3, r9
	bl MapFarSys__Func_200D144
	ldr r0, [sp, #0x30]
	mov r2, #0x1800
	cmp r6, r0
	ldr r0, [sp, #0x2c]
	mov r3, #0x18000
	ldr r0, [r0, #0x63c]
	mov r6, r0, lsl #0xd
	bge _0200CC14
	ldr r0, [sp, #0x34]
	sub r1, r0, r9
	mul r3, r1, r4
	mov r0, r2
	add r2, r0, r1, lsl #6
	mov r0, #0x18000
	adds r3, r0, r3
	movmi r3, #0
	cmp r1, #0x200
	ldrgt r0, =0x017F4000
	bgt _0200CC10
	mov r0, #0x18000
	add r9, r1, #1
	mul r0, r1, r0
	mul r1, r9, r1
	mul r9, r1, r4
	add r0, r0, r9, asr #1
_0200CC10:
	add r6, r6, r0
_0200CC14:
	mov r0, r8
	mov r8, #0
	str r8, [sp]
	str r2, [sp, #4]
	mov r2, #0x40
	str r2, [sp, #8]
	str r3, [sp, #0xc]
	str r4, [sp, #0x10]
	and r1, r11, #0xff
	mov r2, #0xbf
	mov r3, r8
	str r6, [sp, #0x14]
	bl FontDMAControl__Func_20520B0
_0200CC48:
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r10, r10, #0x70
	add r5, r5, #1
	cmp r5, #2
	blt _0200C984
	ldr r0, [sp, #0x2c]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp, #0x2c]
	str r1, [r0, #0x63c]
	add sp, sp, #0x40
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Process_Z9(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	ldr r0, =_0210E074
	ldr r1, =MapFarSys__sVars
	ldrh r7, [r0, #0xa]
	ldrh r6, [r0, #0xc]
	ldrh r5, [r0, #0xe]
	ldrh r4, [r0, #4]
	ldrh r3, [r0, #6]
	ldrh r2, [r0, #8]
	ldr r1, [r1, #8]
	mov r0, #0xe
	strh r7, [sp, #0xa]
	strh r6, [sp, #0xc]
	strh r5, [sp, #0xe]
	strh r4, [sp, #4]
	strh r3, [sp, #6]
	strh r2, [sp, #8]
	str r1, [sp]
	bl MapFarSys__DoFarScrollX
	bl MapFarSys__DoFarScrollY
	ldr r0, =MapFarSys__sVars
	ldr r1, =mapCamera
	ldr r4, [r0, #8]
	ldr r3, [r1, #0x38]
	ldr r2, [r4, #0x10]
	mov r0, #0
	add r2, r3, r2
	str r2, [r1, #0x38]
	ldr r3, [r1, #0xa8]
	ldr r2, [r4, #0x18]
	add r2, r3, r2
	str r2, [r1, #0xa8]
	ldr r1, [sp]
	add r3, sp, #4
	ldr r5, [r1, #0x63c]
	add r1, sp, #0x10
_0200CD3C:
	mov r4, r0, lsl #1
	ldrsh r2, [r3, r4]
	add r0, r0, #1
	cmp r0, #3
	mul r2, r5, r2
	mov r2, r2, lsr #0xc
	strh r2, [r1, r4]
	blt _0200CD3C
	mov r5, #0
	cmp r5, #2
	bge _0200CE30
_0200CD68:
	and r0, r5, #0xff
	bl RenderCore_GetDMASrc
	ldr r2, =mapCamera
	mov r1, #0x70
	mla r2, r5, r1, r2
	ldr r1, [r2, #0x3c]
	ldr r2, [r2, #0x38]
	mov r1, r1, lsl #4
	mov r2, r2, asr #0xc
	mov r7, #0
	mov r6, r0
	mov r10, r7
	mov r1, r1, lsr #0x10
	mov r4, r2, lsl #0x10
	add r11, sp, #0xa
_0200CDA4:
	mov r0, r10, lsl #1
	ldrh r9, [r11, r0]
	cmp r1, r9
	bhs _0200CE10
	sub r0, r9, r1
	mov r0, r0, lsl #0x10
	add r1, r7, r0, lsr #16
	cmp r1, #0xc0
	mov r8, r0, lsr #0x10
	rsbgt r0, r7, #0xc0
	movgt r0, r0, lsl #0x10
	movgt r8, r0, lsr #0x10
	cmp r8, #0
	beq _0200CE00
	mov r1, r10, lsl #1
	add r0, sp, #0x10
	ldrh r0, [r0, r1]
	add r1, r6, r7, lsl #1
	mov r2, r8, lsl #1
	add r0, r0, r4, lsr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MIi_CpuClear16
_0200CE00:
	add r0, r7, r8
	mov r0, r0, lsl #0x10
	mov r1, r9
	mov r7, r0, lsr #0x10
_0200CE10:
	add r10, r10, #1
	cmp r10, #3
	blt _0200CDA4
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r5, r5, #1
	cmp r5, #2
	blt _0200CD68
_0200CE30:
	ldr r0, [sp]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp]
	str r1, [r0, #0x63c]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void MapFarSys__DoFarScrollX(s32 scrollSpeed)
{
    if (CheckStageUsesLaps() == FALSE)
    {
        MapSysCamera *cameraA = &mapCamera.camera[GRAPHICS_ENGINE_A];
        if ((cameraA->flags2 & 1) == 0)
            cameraA->bgPos.x = cameraA->disp_pos.x / scrollSpeed;

        MapSysCamera *cameraB = &mapCamera.camera[GRAPHICS_ENGINE_B];
        if ((cameraB->flags2 & 1) == 0)
            cameraB->bgPos.x = cameraB->disp_pos.x / scrollSpeed;
    }
}

void MapFarSys__DoFarScrollY(void)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        fx32 scrollSpeed;
        MapSysCamera *cameraA = MapSys__GetCameraA();
        MapSysCamera *cameraB = MapSys__GetCameraB();

        scrollSpeed = MapFarSys__sVars.scrollControl->scrollSpeedY[0];
        if ((cameraA->flags2 & 1) == 0)
            cameraA->bgPos.y = FX_DivS32(cameraA->disp_pos.y * (scrollSpeed - 464), mapCamera.camControl.height - HW_LCD_HEIGHT);

        if ((cameraB->flags2 & 1) == 0)
            cameraB->bgPos.y = FX_DivS32(cameraA->disp_pos.y * (scrollSpeed - 464), mapCamera.camControl.height - HW_LCD_HEIGHT) + FLOAT_TO_FX32(272.0);
    }
    else
    {
        MapSysCamera *cameraA = &mapCamera.camera[GRAPHICS_ENGINE_A];
        fx32 scrollSpeed      = MapFarSys__sVars.scrollControl->scrollSpeedY[0];
        if ((cameraA->flags2 & 1) == 0)
            cameraA->bgPos.y = FX_DivS32(cameraA->disp_pos.y * (scrollSpeed - 464), mapCamera.camControl.height - HW_LCD_HEIGHT);

        MapSysCamera *cameraB = &mapCamera.camera[GRAPHICS_ENGINE_B];
        scrollSpeed           = MapFarSys__sVars.scrollControl->scrollSpeedY[1];
        if ((cameraB->flags2 & 1) == 0)
            cameraB->bgPos.y = FX_DivS32(cameraB->disp_pos.y * (scrollSpeed - 464), mapCamera.camControl.height - HW_LCD_HEIGHT);
    }
}

void MapFarSys__ProcessScroll(void)
{
    MapSysCamera *cameraA = &mapCamera.camera[GRAPHICS_ENGINE_A];
    MapSysCamera *cameraB = &mapCamera.camera[GRAPHICS_ENGINE_B];

    s32 bgYPos[GRAPHICS_ENGINE_COUNT];
    bgYPos[GRAPHICS_ENGINE_A] = FX32_TO_WHOLE(cameraA->bgPos.y);
    bgYPos[GRAPHICS_ENGINE_B] = FX32_TO_WHOLE(cameraB->bgPos.y);

    s32 v14 = 0;
    for (s32 e = 0; e < GRAPHICS_ENGINE_COUNT; e++)
    {
        s32 scrollOffset = 0;
		s32 y;
        s32 localPos, offset;

		MapFarSysScroll *scroll;
        s32 scrollSpeedY;
        if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
        {
            scroll = MapFarSys__sVars.scrollControl->scroll1[GRAPHICS_ENGINE_A][0];
            scrollSpeedY = MapFarSys__sVars.scrollControl->scrollSpeedY[GRAPHICS_ENGINE_A];
        }
        else
        {
            scroll = MapFarSys__sVars.scrollControl->scroll1[e][0];
            scrollSpeedY = MapFarSys__sVars.scrollControl->scrollSpeedY[e];
        }

        while (scrollOffset < scrollSpeedY && scroll->pos != 0)
        {
            if (scrollOffset + scroll->pos > bgYPos[e])
                break;
            
            scrollOffset += scroll->pos;
            scroll++;
        }

        localPos = bgYPos[e] - scrollOffset;
        offset   = localPos;
        mapCamera.camera[e].bgPos.y = FX32_FROM_WHOLE((localPos - scroll->width) & 0x1FF);

        u16 *dmaSrc = (u16 *)RenderCore_GetDMASrc(e);
        for (y = 0; y < HW_LCD_HEIGHT;)
        {
            s32 count = scroll->pos - offset;
            if (y + count >= HW_LCD_HEIGHT)
                count = HW_LCD_HEIGHT - y;
            MI_CpuFill16(dmaSrc, (localPos + scroll->width) & 0x1FF, sizeof(u16) * count);
            y += count;

            offset = 0;
            localPos -= scroll->pos;
            ++scroll;
            dmaSrc += count;
        }

        RenderCore_PrepareDMASwapBuffer(e);
    }
}

NONMATCH_FUNC void MapFarSys__Func_200D144(u32 *dst, s32 start, s32 end, s32 waterLevel, s32 a5, s32 a6, s32 a7, struct MapFarSysUnknown200D144 *unknown)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r5, #0
	mov r10, r2
	mov r9, r3
	ldr r8, [sp, #0x30]
	ldr r7, [sp, #0x34]
	ldr r11, [sp, #0x38]
	ldr r4, [sp, #0x3c]
	str r0, [sp]
	str r1, [sp, #4]
	cmp r9, r10
	mov r6, r5
	addgt sp, sp, #8
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0200D180:
	ldrh r2, [r4, #0]
	ldr r0, [sp, #4]
	ldrh r1, [r4, #4]
	cmp r9, r0
	mul r0, r1, r2
	mov r0, r0, lsl #0x10
	blt _0200D240
	cmp r6, #0
	moveq r6, r2
	b _0200D228
_0200D1A8:
	smull r1, r0, r8, r7
	ldrh r3, [r4, #2]
	ldrh r2, [r4, #4]
	add r3, r3, r5
	sub r5, r2, r5
	sub r2, r3, r9
	adds r3, r1, #0x800
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	adc r0, r0, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	ldr r0, =0x000001FF
	mov r2, r2, lsl #0x17
	and r0, r0, r1, asr #12
	add r1, r9, r5
	cmp r1, r10
	subhi r1, r10, r9
	addhi r5, r1, #1
	ldr r1, [sp]
	orr r0, r0, r2, lsr #7
	add r1, r1, r9, lsl #2
	mov r2, r5, lsl #2
	bl MIi_CpuClear32
	ldrh r1, [r4, #6]
	sub r0, r6, #1
	mov r0, r0, lsl #0x10
	add r9, r9, r5
	add r7, r7, r11
	add r8, r8, r1, lsl #12
	mov r6, r0, lsr #0x10
	mov r5, #0
_0200D228:
	cmp r9, r10
	bgt _0200D238
	cmp r6, #0
	bne _0200D1A8
_0200D238:
	add r4, r4, #8
	b _0200D2B4
_0200D240:
	ldr r3, [sp, #4]
	add r0, r9, r0, lsr #16
	cmp r0, r3
	ble _0200D29C
	mov r0, r3
	sub r5, r0, r9
	mov r0, r5
	bl FX_DivS32
	ldrh r3, [r4, #4]
	ldrh r2, [r4, #6]
	ldrh r1, [r4, #0]
	mul r6, r3, r0
	mov r3, r2, lsl #0xc
	sub r2, r1, r0
	sub r5, r5, r6
	mov r1, r5, lsl #0x10
	mov r2, r2, lsl #0x10
	mla r8, r3, r0, r8
	mla r7, r11, r0, r7
	ldr r9, [sp, #4]
	mov r5, r1, lsr #0x10
	mov r6, r2, lsr #0x10
	b _0200D2B4
_0200D29C:
	ldrh r1, [r4, #6]
	mla r7, r11, r2, r7
	mov r1, r1, lsl #0xc
	mla r8, r1, r2, r8
	mov r9, r0
	add r4, r4, #8
_0200D2B4:
	cmp r9, r10
	ble _0200D180
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}
