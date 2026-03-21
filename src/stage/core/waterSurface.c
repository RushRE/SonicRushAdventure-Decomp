#include <stage/core/waterSurface.h>
#include <game/game/gameState.h>
#include <game/graphics/renderCore.h>
#include <game/object/objData.h>
#include <game/object/objDraw.h>
#include <game/stage/gameSystem.h>
#include <stage/effects/waterCommon.h>

// --------------------
// TYPES
// --------------------

typedef void (*WaterSurfaceInitFunc)(void);
typedef void (*WaterSurfaceProcessFunc)(void);
typedef void (*WaterSurfaceReleaseFunc)(void);

// --------------------
// STRUCTS
// --------------------

typedef struct WaterSurfaceControlConfigZ2_
{
    PaletteAnimator aniPalette;
} WaterSurfaceControlConfigZ2;

typedef struct WaterSurfaceControlConfigZ3_
{
    PaletteAnimator aniPaletteFG[7];
    PaletteAnimator aniPaletteFG_W[7];
    PaletteAnimator aniPaletteBG[3];
} WaterSurfaceControlConfigZ3;

typedef struct WaterSurfaceControlConfigZ6_
{
    PaletteAnimator aniPaletteFG[4];
    PaletteAnimator aniPaletteBG[2];
} WaterSurfaceControlConfigZ6;

// --------------------
// FUNCTION DECLS
// --------------------

// WaterSurface Management
static void WaterSurface_Init_Zone1(void);
static void WaterSurface_Release_Zone1(void);
static void WaterSurface_Process_Zone1(void);

static void WaterSurface_Init_Zone2(void);
static void WaterSurface_Release_Zone2(void);
static void WaterSurface_Process_Zone2(void);

static void WaterSurface_Init_Zone3(void);
static void WaterSurface_Release_Zone3(void);
static void WaterSurface_Process_Zone3(void);

static void WaterSurface_Init_Zone6(void);
static void WaterSurface_Release_Zone6(void);
static void WaterSurface_Process_Zone6(void);

static void WaterSurface_Init_Zone7(void);
static void WaterSurface_Release_Zone7(void);
static void WaterSurface_Process_Zone7(void);

// WaterSurface
static void CreateWaterSurface(void);
static void ReleaseWaterSurfaceCommon(void);
static void ProcessWaterSurfaceCommon(void);
static void WaterSurface_Main(void);
static void WaterSurface_VAlarmCB_200E26C(void *useEngineB);
static void WaterSurface_VAlarmCB_200E2CC(void *useEngineB);
static void InitUnderwaterPalette(u16 *palettePtr, u32 count);
static void WaterSurface_CopyPalette(BOOL useEngineB);
static void WaterSurface_CopyAltPalette(BOOL useEngineB);

// --------------------
// VARIABLES
// --------------------

static struct WaterSurfaceWork *sWaterSurface;

static const WaterSurfaceProcessFunc sWaterSurfaceProcessTable[STAGE_COUNT] = {
    [STAGE_Z11]               = WaterSurface_Process_Zone1,
    [STAGE_Z12]               = WaterSurface_Process_Zone1,
    [STAGE_TUTORIAL]          = WaterSurface_Process_Zone1,
    [STAGE_Z1B]               = NULL,
    [STAGE_Z21]               = WaterSurface_Process_Zone2,
    [STAGE_Z22]               = WaterSurface_Process_Zone2,
    [STAGE_Z2B]               = NULL,
    [STAGE_Z31]               = WaterSurface_Process_Zone3,
    [STAGE_Z32]               = WaterSurface_Process_Zone3,
    [STAGE_HIDDEN_ISLAND_1]   = NULL,
    [STAGE_Z3B]               = NULL,
    [STAGE_Z41]               = NULL,
    [STAGE_Z42]               = NULL,
    [STAGE_Z4B]               = NULL,
    [STAGE_Z51]               = NULL,
    [STAGE_Z52]               = NULL,
    [STAGE_Z5B]               = NULL,
    [STAGE_Z61]               = WaterSurface_Process_Zone6,
    [STAGE_Z62]               = WaterSurface_Process_Zone6,
    [STAGE_HIDDEN_ISLAND_2]   = NULL,
    [STAGE_Z6B]               = NULL,
    [STAGE_Z71]               = WaterSurface_Process_Zone7,
    [STAGE_Z72]               = WaterSurface_Process_Zone7,
    [STAGE_Z7B]               = NULL,
    [STAGE_BOSS_FINAL]        = NULL,
    [STAGE_HIDDEN_ISLAND_3]   = NULL,
    [STAGE_HIDDEN_ISLAND_4]   = WaterSurface_Process_Zone3,
    [STAGE_HIDDEN_ISLAND_5]   = NULL,
    [STAGE_HIDDEN_ISLAND_6]   = WaterSurface_Process_Zone1,
    [STAGE_HIDDEN_ISLAND_7]   = WaterSurface_Process_Zone1,
    [STAGE_HIDDEN_ISLAND_8]   = WaterSurface_Process_Zone3,
    [STAGE_HIDDEN_ISLAND_9]   = WaterSurface_Process_Zone2,
    [STAGE_HIDDEN_ISLAND_10]  = WaterSurface_Process_Zone2,
    [STAGE_HIDDEN_ISLAND_11]  = WaterSurface_Process_Zone3,
    [STAGE_HIDDEN_ISLAND_12]  = NULL,
    [STAGE_HIDDEN_ISLAND_13]  = NULL,
    [STAGE_HIDDEN_ISLAND_14]  = NULL,
    [STAGE_HIDDEN_ISLAND_15]  = NULL,
    [STAGE_HIDDEN_ISLAND_16]  = NULL,
    [STAGE_HIDDEN_ISLAND_VS1] = WaterSurface_Process_Zone1,
    [STAGE_HIDDEN_ISLAND_VS2] = WaterSurface_Process_Zone2,
    [STAGE_HIDDEN_ISLAND_VS3] = WaterSurface_Process_Zone3,
    [STAGE_HIDDEN_ISLAND_VS4] = NULL,
    [STAGE_HIDDEN_ISLAND_R1]  = NULL,
    [STAGE_HIDDEN_ISLAND_R2]  = NULL,
    [STAGE_HIDDEN_ISLAND_R3]  = NULL,
};

static const WaterSurfaceInitFunc sWaterSurfaceInitTable[STAGE_COUNT] = {
    [STAGE_Z11]               = WaterSurface_Init_Zone1,
    [STAGE_Z12]               = WaterSurface_Init_Zone1,
    [STAGE_TUTORIAL]          = WaterSurface_Init_Zone1,
    [STAGE_Z1B]               = NULL,
    [STAGE_Z21]               = WaterSurface_Init_Zone2,
    [STAGE_Z22]               = WaterSurface_Init_Zone2,
    [STAGE_Z2B]               = NULL,
    [STAGE_Z31]               = WaterSurface_Init_Zone3,
    [STAGE_Z32]               = WaterSurface_Init_Zone3,
    [STAGE_HIDDEN_ISLAND_1]   = NULL,
    [STAGE_Z3B]               = NULL,
    [STAGE_Z41]               = NULL,
    [STAGE_Z42]               = NULL,
    [STAGE_Z4B]               = NULL,
    [STAGE_Z51]               = NULL,
    [STAGE_Z52]               = NULL,
    [STAGE_Z5B]               = NULL,
    [STAGE_Z61]               = WaterSurface_Init_Zone6,
    [STAGE_Z62]               = WaterSurface_Init_Zone6,
    [STAGE_HIDDEN_ISLAND_2]   = NULL,
    [STAGE_Z6B]               = NULL,
    [STAGE_Z71]               = WaterSurface_Init_Zone7,
    [STAGE_Z72]               = WaterSurface_Init_Zone7,
    [STAGE_Z7B]               = NULL,
    [STAGE_BOSS_FINAL]        = NULL,
    [STAGE_HIDDEN_ISLAND_3]   = NULL,
    [STAGE_HIDDEN_ISLAND_4]   = WaterSurface_Init_Zone3,
    [STAGE_HIDDEN_ISLAND_5]   = NULL,
    [STAGE_HIDDEN_ISLAND_6]   = WaterSurface_Init_Zone1,
    [STAGE_HIDDEN_ISLAND_7]   = WaterSurface_Init_Zone1,
    [STAGE_HIDDEN_ISLAND_8]   = WaterSurface_Init_Zone3,
    [STAGE_HIDDEN_ISLAND_9]   = WaterSurface_Init_Zone2,
    [STAGE_HIDDEN_ISLAND_10]  = WaterSurface_Init_Zone2,
    [STAGE_HIDDEN_ISLAND_11]  = WaterSurface_Init_Zone3,
    [STAGE_HIDDEN_ISLAND_12]  = NULL,
    [STAGE_HIDDEN_ISLAND_13]  = NULL,
    [STAGE_HIDDEN_ISLAND_14]  = NULL,
    [STAGE_HIDDEN_ISLAND_15]  = NULL,
    [STAGE_HIDDEN_ISLAND_16]  = NULL,
    [STAGE_HIDDEN_ISLAND_VS1] = WaterSurface_Init_Zone1,
    [STAGE_HIDDEN_ISLAND_VS2] = WaterSurface_Init_Zone2,
    [STAGE_HIDDEN_ISLAND_VS3] = WaterSurface_Init_Zone3,
    [STAGE_HIDDEN_ISLAND_VS4] = NULL,
    [STAGE_HIDDEN_ISLAND_R1]  = NULL,
    [STAGE_HIDDEN_ISLAND_R2]  = NULL,
    [STAGE_HIDDEN_ISLAND_R3]  = NULL,
};

static const WaterSurfaceReleaseFunc sWaterSurfaceReleaseTable[STAGE_COUNT] = {
    [STAGE_Z11]               = WaterSurface_Release_Zone1,
    [STAGE_Z12]               = WaterSurface_Release_Zone1,
    [STAGE_TUTORIAL]          = WaterSurface_Release_Zone1,
    [STAGE_Z1B]               = NULL,
    [STAGE_Z21]               = WaterSurface_Release_Zone2,
    [STAGE_Z22]               = WaterSurface_Release_Zone2,
    [STAGE_Z2B]               = NULL,
    [STAGE_Z31]               = WaterSurface_Release_Zone3,
    [STAGE_Z32]               = WaterSurface_Release_Zone3,
    [STAGE_HIDDEN_ISLAND_1]   = NULL,
    [STAGE_Z3B]               = NULL,
    [STAGE_Z41]               = NULL,
    [STAGE_Z42]               = NULL,
    [STAGE_Z4B]               = NULL,
    [STAGE_Z51]               = NULL,
    [STAGE_Z52]               = NULL,
    [STAGE_Z5B]               = NULL,
    [STAGE_Z61]               = WaterSurface_Release_Zone6,
    [STAGE_Z62]               = WaterSurface_Release_Zone6,
    [STAGE_HIDDEN_ISLAND_2]   = NULL,
    [STAGE_Z6B]               = NULL,
    [STAGE_Z71]               = WaterSurface_Release_Zone7,
    [STAGE_Z72]               = WaterSurface_Release_Zone7,
    [STAGE_Z7B]               = NULL,
    [STAGE_BOSS_FINAL]        = NULL,
    [STAGE_HIDDEN_ISLAND_3]   = NULL,
    [STAGE_HIDDEN_ISLAND_4]   = WaterSurface_Release_Zone3,
    [STAGE_HIDDEN_ISLAND_5]   = NULL,
    [STAGE_HIDDEN_ISLAND_6]   = WaterSurface_Release_Zone1,
    [STAGE_HIDDEN_ISLAND_7]   = WaterSurface_Release_Zone1,
    [STAGE_HIDDEN_ISLAND_8]   = WaterSurface_Release_Zone3,
    [STAGE_HIDDEN_ISLAND_9]   = WaterSurface_Release_Zone2,
    [STAGE_HIDDEN_ISLAND_10]  = WaterSurface_Release_Zone2,
    [STAGE_HIDDEN_ISLAND_11]  = WaterSurface_Release_Zone3,
    [STAGE_HIDDEN_ISLAND_12]  = NULL,
    [STAGE_HIDDEN_ISLAND_13]  = NULL,
    [STAGE_HIDDEN_ISLAND_14]  = NULL,
    [STAGE_HIDDEN_ISLAND_15]  = NULL,
    [STAGE_HIDDEN_ISLAND_16]  = NULL,
    [STAGE_HIDDEN_ISLAND_VS1] = WaterSurface_Release_Zone1,
    [STAGE_HIDDEN_ISLAND_VS2] = WaterSurface_Release_Zone2,
    [STAGE_HIDDEN_ISLAND_VS3] = WaterSurface_Release_Zone3,
    [STAGE_HIDDEN_ISLAND_VS4] = NULL,
    [STAGE_HIDDEN_ISLAND_R1]  = NULL,
    [STAGE_HIDDEN_ISLAND_R2]  = NULL,
    [STAGE_HIDDEN_ISLAND_R3]  = NULL,
};

static void *sUnderwaterPaletteTable[GRAPHICS_ENGINE_COUNT] = { [GRAPHICS_ENGINE_A] = VRAM_BG_PLTT, [GRAPHICS_ENGINE_B] = VRAM_DB_BG_PLTT };
static void *sSurfacePaletteTable[GRAPHICS_ENGINE_COUNT]    = { [GRAPHICS_ENGINE_A] = VRAM_BG_PLTT, [GRAPHICS_ENGINE_B] = VRAM_DB_BG_PLTT };
static void *sSpritePalette2Table[GRAPHICS_ENGINE_COUNT]    = { [GRAPHICS_ENGINE_A] = VRAM_OBJ_PLTT, [GRAPHICS_ENGINE_B] = VRAM_DB_OBJ_PLTT };
static void *sSpritePalette1Table[GRAPHICS_ENGINE_COUNT]    = { [GRAPHICS_ENGINE_A] = VRAM_OBJ_PLTT, [GRAPHICS_ENGINE_B] = VRAM_DB_OBJ_PLTT };

// --------------------
// FUNCTIONS
// --------------------

// WaterSurface Management
void InitWaterSurface(void)
{
    if (sWaterSurfaceInitTable[gameState.stageID] != NULL)
    {
        sWaterSurface = HeapAllocHead(HEAP_USER, sizeof(struct WaterSurfaceWork));
        MI_CpuClear16(sWaterSurface, sizeof(*sWaterSurface));

        sWaterSurfaceInitTable[gameState.stageID]();
    }
}

void ReleaseWaterSurface(void)
{
    if (sWaterSurfaceReleaseTable[gameState.stageID] != NULL)
        sWaterSurfaceReleaseTable[gameState.stageID]();

    if (sWaterSurface != NULL)
    {
        if (sWaterSurface->controlConfig != NULL)
            HeapFree(HEAP_USER, sWaterSurface->controlConfig);

        HeapFree(HEAP_USER, sWaterSurface);
        sWaterSurface = NULL;
    }
}

void ProcessWaterSurface(void)
{
    if (sWaterSurfaceProcessTable[gameState.stageID] != NULL)
        sWaterSurfaceProcessTable[gameState.stageID]();
}

void WaterSurface_Init_Zone1(void)
{
    sWaterSurface->flags |= WATERSURFACE_FLAG_HAS_SPRITE_UNDERWATER_PALETTE;
    sWaterSurface->paletteSize1 = 240;
    sWaterSurface->paletteSize2 = 256;
    CreateWaterSurface();
}

void WaterSurface_Release_Zone1(void)
{
    ReleaseWaterSurfaceCommon();
}

void WaterSurface_Process_Zone1(void)
{
    ProcessWaterSurfaceCommon();
}

void WaterSurface_Init_Zone2(void)
{
    sWaterSurface->controlConfig = HeapAllocHead(HEAP_USER, sizeof(WaterSurfaceControlConfigZ2));

    WaterSurfaceControlConfigZ2 *control = sWaterSurface->controlConfig;
    MI_CpuClear16(control, sizeof(WaterSurfaceControlConfigZ2));

    void *paletteAniFile = ObjDataLoad(NULL, "/bpa/z2_map.bpa", gameArchiveStage);
    InitPaletteAnimator(&control->aniPalette, paletteAniFile, 0, ANIMATORBPA_FLAG_CAN_LOOP, PALETTE_MODE_BG, VRAMKEY_TO_ADDR(0x4000));
}

void WaterSurface_Release_Zone2(void)
{
    WaterSurfaceControlConfigZ2 *control = sWaterSurface->controlConfig;

    ReleasePaletteAnimator(&control->aniPalette);
}

void WaterSurface_Process_Zone2(void)
{
    WaterSurfaceControlConfigZ2 *control = sWaterSurface->controlConfig;

    AnimatePalette(&control->aniPalette);
    if (CheckPaletteAnimationIsValid(&control->aniPalette))
    {
        SetPaletteAnimationTarget(&control->aniPalette, PALETTE_MODE_BG, VRAMKEY_TO_ADDR(0x4000));
        DrawAnimatedPalette(&control->aniPalette);

        SetPaletteAnimationTarget(&control->aniPalette, PALETTE_MODE_BG, VRAMKEY_TO_ADDR(0x6000));
        DrawAnimatedPalette(&control->aniPalette);

        SetPaletteAnimationTarget(&control->aniPalette, PALETTE_MODE_SUB_BG, VRAMKEY_TO_ADDR(0x4000));
        DrawAnimatedPalette(&control->aniPalette);

        SetPaletteAnimationTarget(&control->aniPalette, PALETTE_MODE_SUB_BG, VRAMKEY_TO_ADDR(0x6000));
        DrawAnimatedPalette(&control->aniPalette);
    }
}

void WaterSurface_Init_Zone3(void)
{
    u16 i;

    sWaterSurface->controlConfig = HeapAllocHead(HEAP_USER, sizeof(WaterSurfaceControlConfigZ3));

    WaterSurfaceControlConfigZ3 *control = sWaterSurface->controlConfig;
    MI_CpuClear16(control, sizeof(WaterSurfaceControlConfigZ3));

    sWaterSurface->flags |= WATERSURFACE_FLAG_HAS_SPRITE_UNDERWATER_PALETTE | WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_1 | WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_2
                               | WATERSURFACE_FLAG_HAS_WATER_SURFACE;
    sWaterSurface->paletteSize1 = 240;
    sWaterSurface->paletteSize2 = 256;

    CreateWaterSurface();

    for (i = 0; i < 7; i++)
    {
        void *paletteAniFile = ObjDataLoad(NULL, "/bpa/z3_map.bpa", gameArchiveStage);
        InitPaletteAnimator(&control->aniPaletteFG[i], paletteAniFile, i, ANIMATORBPA_FLAG_CAN_LOOP, PALETTE_MODE_BG, VRAMKEY_TO_ADDR(0x4000));
    }

    for (i = 0; i < 6; i++)
    {
        void *paletteAniFile = ObjDataLoad(NULL, "/bpa/z3_map_w.bpa", gameArchiveStage);
        InitPaletteAnimator(&control->aniPaletteFG_W[i], paletteAniFile, i, ANIMATORBPA_FLAG_CAN_LOOP, PALETTE_MODE_SPRITE, sWaterSurface->underwaterPalette2);
    }
    control->aniPaletteFG_W[6].userFlags |= ANIMATORBPA_FLAG_PAUSED;

    for (i = 0; i < 3; i++)
    {
        void *paletteAniFile = ObjDataLoad(NULL, "/bpa/z3_far.bpa", gameArchiveStage);
        InitPaletteAnimator(&control->aniPaletteBG[i], paletteAniFile, i, ANIMATORBPA_FLAG_CAN_LOOP, PALETTE_MODE_SPRITE, VRAM_BG_PLTT);
    }
}

void WaterSurface_Release_Zone3(void)
{
    s32 i;

    WaterSurfaceControlConfigZ3 *control = sWaterSurface->controlConfig;

    ReleaseWaterSurfaceCommon();

    for (i = 0; i < 7; i++)
    {
        ReleasePaletteAnimator(&control->aniPaletteFG[i]);
    }

    for (i = 0; i < 6; i++)
    {
        ReleasePaletteAnimator(&control->aniPaletteFG_W[i]);
    }

    for (i = 0; i < 3; i++)
    {
        ReleasePaletteAnimator(&control->aniPaletteBG[i]);
    }
}

NONMATCH_FUNC void WaterSurface_Process_Zone3(void)
{
    // https://decomp.me/scratch/rmXW1 -> 85.49%
#ifdef NON_MATCHING
    s32 i;

    WaterSurfaceControlConfigZ3 *control = sWaterSurface->controlConfig;

    sWaterSurface->flags &= ~WATERSURFACE_FLAG_40;
    ProcessWaterSurfaceCommon();

    BOOL flag = FALSE;

    MapSysCamera *cameraA = &mapCamera.camera[0];
    BOOL flagA1                  = cameraA->flags & MAPSYS_CAMERA_FLAG_1000000;
    BOOL flagA2                  = cameraA->flags & MAPSYS_CAMERA_FLAG_2000000;

    MapSysCamera *cameraB = &mapCamera.camera[1];
    BOOL flagB1                  = cameraB->flags & MAPSYS_CAMERA_FLAG_1000000;
    BOOL flagB2                  = cameraB->flags & MAPSYS_CAMERA_FLAG_2000000;

    for (i = 0; i < 7; i++)
    {
        AnimatePalette(&control->aniPaletteFG[i]);
        AnimatePalette(&control->aniPaletteFG_W[i]);

        if (CheckPaletteAnimationIsValid(&control->aniPaletteFG[i]))
        {
            if (!flagA1 || flagA2)
            {
                SetPaletteAnimationTarget(&control->aniPaletteFG[i], PALETTE_MODE_BG, VRAMKEY_TO_ADDR(0x4000));
                DrawAnimatedPalette(&control->aniPaletteFG[i]);
                SetPaletteAnimationTarget(&control->aniPaletteFG[i], PALETTE_MODE_BG, VRAMKEY_TO_ADDR(0x6000));
                DrawAnimatedPalette(&control->aniPaletteFG[i]);
            }
            else
            {
                flag = TRUE;
            }

            if (!flagA1 || flagA2)
            {
                SetPaletteAnimationTarget(&control->aniPaletteFG[i], PALETTE_MODE_SUB_BG, VRAMKEY_TO_ADDR(0x4000));
                DrawAnimatedPalette(&control->aniPaletteFG[i]);
                SetPaletteAnimationTarget(&control->aniPaletteFG[i], PALETTE_MODE_SUB_BG, VRAMKEY_TO_ADDR(0x6000));
                DrawAnimatedPalette(&control->aniPaletteFG[i]);
            }
            else
            {
                flag = TRUE;
            }

            if (flag)
            {
                SetPaletteAnimationTarget(&control->aniPaletteFG[i], PALETTE_MODE_SPRITE, sWaterSurface->surfacePalette2);
                DrawAnimatedPalette(&control->aniPaletteFG[i]);
                DrawAnimatedPalette(&control->aniPaletteFG_W[i]);

                sWaterSurface->flags |= WATERSURFACE_FLAG_40;
            }
        }
    }

    for (i = 0; i < 3; i++)
    {
        AnimatePalette(&control->aniPaletteBG[i]);

        if (CheckPaletteAnimationIsValid(&control->aniPaletteBG[i]))
        {
            if (!flagA1 || flagA2)
            {
                SetPaletteAnimationTarget(&control->aniPaletteBG[i], PALETTE_MODE_SPRITE, VRAM_BG_PLTT);
                DrawAnimatedPalette(&control->aniPaletteBG[i]);
            }
            else
            {
                flag = TRUE;
            }

            if (!flagA1 || flagA2)
            {
                SetPaletteAnimationTarget(&control->aniPaletteBG[i], PALETTE_MODE_SPRITE, VRAM_DB_BG_PLTT);
                DrawAnimatedPalette(&control->aniPaletteBG[i]);
            }
            else
            {
                flag = TRUE;
            }

            if (flag)
            {
                SetPaletteAnimationTarget(&control->aniPaletteBG[i], PALETTE_MODE_SPRITE, sWaterSurface->surfacePalette1);
                DrawAnimatedPalette(&control->aniPaletteBG[i]);

                sWaterSurface->flags |= WATERSURFACE_FLAG_40;
            }
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r0, =sWaterSurface
	ldr r2, [r0, #0]
	ldr r0, [r2, #0x9cc]
	ldr r1, [r2, #0]
	str r0, [sp]
	bic r0, r1, #0x40
	str r0, [r2]
	bl ProcessWaterSurfaceCommon
	ldr r0, =mapCamera
	mov r7, #0
	ldr r2, [r0, #0x70]
	ldr r1, [r0, #0]
	ldr r5, [sp]
	mov r4, r7
	mov r0, r5
	add r6, r0, #0xe0
	and r11, r1, #0x1000000
	and r8, r1, #0x2000000
	and r9, r2, #0x1000000
	and r10, r2, #0x2000000
_0200D7BC:
	mov r0, r5
	bl AnimatePalette
	mov r0, r6
	bl AnimatePalette
	mov r0, r5
	bl CheckPaletteAnimationIsValid
	cmp r0, #0
	beq _0200D8B0
	cmp r11, #0
	beq _0200D7EC
	cmp r8, #0
	beq _0200D820
_0200D7EC:
	mov r0, r5
	mov r1, #1
	mov r2, #0x4000
	bl SetPaletteAnimationTarget
	mov r0, r5
	bl DrawAnimatedPalette
	mov r0, r5
	mov r1, #1
	mov r2, #0x6000
	bl SetPaletteAnimationTarget
	mov r0, r5
	bl DrawAnimatedPalette
	b _0200D824
_0200D820:
	mov r7, #1
_0200D824:
	cmp r9, #0
	beq _0200D834
	cmp r10, #0
	beq _0200D868
_0200D834:
	mov r0, r5
	mov r1, #3
	mov r2, #0x4000
	bl SetPaletteAnimationTarget
	mov r0, r5
	bl DrawAnimatedPalette
	mov r0, r5
	mov r1, #3
	mov r2, #0x6000
	bl SetPaletteAnimationTarget
	mov r0, r5
	bl DrawAnimatedPalette
	b _0200D86C
_0200D868:
	mov r7, #1
_0200D86C:
	cmp r7, #0
	beq _0200D8B0
	ldr r2, =sWaterSurface
	mov r0, r5
	ldr r2, [r2, #0]
	mov r1, #0
	add r2, r2, #0x210
	bl SetPaletteAnimationTarget
	mov r0, r5
	bl DrawAnimatedPalette
	mov r0, r6
	bl DrawAnimatedPalette
	ldr r0, =sWaterSurface
	ldr r1, [r0, #0]
	ldr r0, [r1, #0]
	orr r0, r0, #0x40
	str r0, [r1]
_0200D8B0:
	add r4, r4, #1
	cmp r4, #7
	add r5, r5, #0x20
	add r6, r6, #0x20
	blt _0200D7BC
	ldr r0, [sp]
	mov r8, #0
	ldr r4, =sWaterSurface
	add r6, r0, #0x1c0
	mov r5, r8
	mov r11, #0x5000000
_0200D8DC:
	mov r0, r6
	bl AnimatePalette
	mov r0, r6
	bl CheckPaletteAnimationIsValid
	cmp r0, #0
	beq _0200D988
	cmp r9, #0
	beq _0200D904
	cmp r10, #0
	beq _0200D920
_0200D904:
	mov r0, r6
	mov r1, r5
	mov r2, r11
	bl SetPaletteAnimationTarget
	mov r0, r6
	bl DrawAnimatedPalette
	b _0200D924
_0200D920:
	mov r7, #1
_0200D924:
	cmp r9, #0
	beq _0200D934
	cmp r10, #0
	beq _0200D950
_0200D934:
	ldr r2, =0x05000400
	mov r0, r6
	mov r1, #0
	bl SetPaletteAnimationTarget
	mov r0, r6
	bl DrawAnimatedPalette
	b _0200D954
_0200D950:
	mov r7, #1
_0200D954:
	cmp r7, #0
	beq _0200D988
	ldr r1, [r4, #0]
	mov r0, r6
	add r2, r1, #0x10
	mov r1, #0
	bl SetPaletteAnimationTarget
	mov r0, r6
	bl DrawAnimatedPalette
	ldr r1, [r4, #0]
	ldr r0, [r1, #0]
	orr r0, r0, #0x40
	str r0, [r1]
_0200D988:
	add r8, r8, #1
	cmp r8, #3
	add r6, r6, #0x20
	blt _0200D8DC
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void WaterSurface_Init_Zone6(void)
{
    u16 i;

    sWaterSurface->controlConfig = HeapAllocHead(HEAP_USER, sizeof(WaterSurfaceControlConfigZ6));

    WaterSurfaceControlConfigZ6 *control = sWaterSurface->controlConfig;
    MI_CpuClear16(control, sizeof(WaterSurfaceControlConfigZ6));

    for (i = 0; i < 4; i++)
    {
        void *paletteAniFile = ObjDataLoad(NULL, "/bpa/z6_map.bpa", gameArchiveStage);
        InitPaletteAnimator(&control->aniPaletteFG[i], paletteAniFile, i, ANIMATORBPA_FLAG_CAN_LOOP, PALETTE_MODE_BG, VRAMKEY_TO_ADDR(0x4000));
    }

    for (i = 0; i < 2; i++)
    {
        void *paletteAniFile = ObjDataLoad(NULL, "/bpa/z6_far.bpa", gameArchiveStage);
        InitPaletteAnimator(&control->aniPaletteBG[i], paletteAniFile, i, ANIMATORBPA_FLAG_CAN_LOOP, PALETTE_MODE_SPRITE, VRAM_BG_PLTT);
    }
}

void WaterSurface_Release_Zone6(void)
{
    s32 i;

    WaterSurfaceControlConfigZ6 *control = sWaterSurface->controlConfig;

    for (i = 0; i < 4; i++)
    {
        ReleasePaletteAnimator(&control->aniPaletteFG[i]);
    }

    for (i = 0; i < 2; i++)
    {
        ReleasePaletteAnimator(&control->aniPaletteBG[i]);
    }
}

void WaterSurface_Process_Zone6(void)
{
    s32 i;

    WaterSurfaceControlConfigZ6 *control = sWaterSurface->controlConfig;

    for (i = 0; i < 4; i++)
    {
        AnimatePalette(&control->aniPaletteFG[i]);
        if (CheckPaletteAnimationIsValid(&control->aniPaletteFG[i]))
        {
            SetPaletteAnimationTarget(&control->aniPaletteFG[i], PALETTE_MODE_BG, VRAMKEY_TO_ADDR(0x4000));
            DrawAnimatedPalette(&control->aniPaletteFG[i]);

            SetPaletteAnimationTarget(&control->aniPaletteFG[i], PALETTE_MODE_BG, VRAMKEY_TO_ADDR(0x6000));
            DrawAnimatedPalette(&control->aniPaletteFG[i]);

            SetPaletteAnimationTarget(&control->aniPaletteFG[i], PALETTE_MODE_SUB_BG, VRAMKEY_TO_ADDR(0x4000));
            DrawAnimatedPalette(&control->aniPaletteFG[i]);

            SetPaletteAnimationTarget(&control->aniPaletteFG[i], PALETTE_MODE_SUB_BG, VRAMKEY_TO_ADDR(0x6000));
            DrawAnimatedPalette(&control->aniPaletteFG[i]);
        }
    }

    for (i = 0; i < 2; i++)
    {
        AnimatePalette(&control->aniPaletteBG[i]);
        if (CheckPaletteAnimationIsValid(&control->aniPaletteBG[i]))
        {
            SetPaletteAnimationTarget(&control->aniPaletteBG[i], PALETTE_MODE_SPRITE, VRAM_BG_PLTT);
            DrawAnimatedPalette(&control->aniPaletteBG[i]);

            SetPaletteAnimationTarget(&control->aniPaletteBG[i], PALETTE_MODE_SPRITE, VRAM_DB_BG_PLTT);
            DrawAnimatedPalette(&control->aniPaletteBG[i]);
        }
    }
}

void WaterSurface_Init_Zone7(void)
{
    sWaterSurface->flags |= WATERSURFACE_FLAG_HAS_SPRITE_UNDERWATER_PALETTE | WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_1 | WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_2
                               | WATERSURFACE_FLAG_HAS_WATER_SURFACE;
    sWaterSurface->paletteSize1 = 240;
    sWaterSurface->paletteSize2 = 256;
    CreateWaterSurface();
}

void WaterSurface_Release_Zone7(void)
{
    ReleaseWaterSurfaceCommon();
}

void WaterSurface_Process_Zone7(void)
{
    ProcessWaterSurfaceCommon();
}

// WaterSurface
void CreateWaterSurface(void)
{
    OS_CreateVAlarm(&sWaterSurface->vAlarm[0]);
    OS_CreateVAlarm(&sWaterSurface->vAlarm[1]);

    if ((sWaterSurface->flags & WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_1) != 0)
    {
        MI_CpuCopy32(VRAM_BG_PLTT, sWaterSurface->surfacePalette1, sizeof(sWaterSurface->surfacePalette1));
        MI_CpuCopy32(VRAM_BG_PLTT, sWaterSurface->underwaterPalette1, sizeof(sWaterSurface->underwaterPalette1));
        InitUnderwaterPalette(sWaterSurface->underwaterPalette1, sWaterSurface->paletteSize1);
    }

    if ((sWaterSurface->flags & WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_2) != 0)
    {
        GXVRamBGExtPltt sBGExtPltt = GX_ResetBankForBGExtPltt();
        void *location             = gBgExtPalBankManager->location[2];

        MI_CpuCopy32(location, sWaterSurface->surfacePalette2, sizeof(sWaterSurface->surfacePalette2));
        MI_CpuCopy32(location, sWaterSurface->underwaterPalette2, sizeof(sWaterSurface->underwaterPalette2));
        GX_SetBankForBGExtPltt(sBGExtPltt);

        InitUnderwaterPalette(sWaterSurface->underwaterPalette2, sWaterSurface->paletteSize2);
    }

    if ((sWaterSurface->flags & WATERSURFACE_FLAG_HAS_WATER_SURFACE) != 0)
    {
        OBS_DATA_WORK *dataWork = ObjDataLoad(NULL, "/act/ac_eff_water.bac", gameArchiveStage);

        AnimatorSprite__Init(&sWaterSurface->aniWaterSurface[0], dataWork, WATERBUBBLE_ANI_WATER_SURFACE, ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A,
                             PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(FALSE, 4), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_12);

        AnimatorSprite__Init(&sWaterSurface->aniWaterSurface[1], dataWork, WATERBUBBLE_ANI_WATER_SURFACE, ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_B,
                             PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(TRUE, 4), PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_12);

        u16 paletteRow                               = ObjDrawAllocSpritePalette(dataWork, WATERBUBBLE_ANI_WATER_SURFACE, 33);
        sWaterSurface->aniWaterSurface[0].cParam.palette = sWaterSurface->aniWaterSurface[1].cParam.palette = paletteRow;
    }

    if ((sWaterSurface->flags & (WATERSURFACE_FLAG_HAS_SPRITE_UNDERWATER_PALETTE | WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_1 | WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_2))
        != 0)
    {
        sWaterSurface->task = TaskCreateNoWork(WaterSurface_Main, 0, TASK_FLAG_NONE, 3, TASK_PRIORITY_RENDER_LIST_START + 0x0200, TASK_GROUP(3), "WaterSurface");
    }
}

void ReleaseWaterSurfaceCommon(void)
{
    OS_CancelVAlarm(&sWaterSurface->vAlarm[0]);
    OS_CancelVAlarm(&sWaterSurface->vAlarm[1]);

    for (u32 i = 0; i < 2; i++)
    {
        WaterSurface_CopyPalette(i);
    }

    if ((sWaterSurface->flags & WATERSURFACE_FLAG_HAS_WATER_SURFACE) != 0)
    {
        AnimatorSprite__Release(&sWaterSurface->aniWaterSurface[0]);
        AnimatorSprite__Release(&sWaterSurface->aniWaterSurface[1]);
        ObjDrawReleaseSprite(33);
    }
}

void ProcessWaterSurfaceCommon(void)
{
    if ((sWaterSurface->flags & WATERSURFACE_FLAG_HAS_WATER_SURFACE) != 0)
    {
        AnimatorSprite__ProcessAnimationFast(&sWaterSurface->aniWaterSurface[0]);
        AnimatorSprite__ProcessAnimationFast(&sWaterSurface->aniWaterSurface[1]);
    }

    for (s32 i = 0; i < 2; i++)
    {
        if ((mapCamera.camera[i].flags & MAPSYS_CAMERA_FLAG_2000000) == 0 && (mapCamera.camera[i].flags & MAPSYS_CAMERA_FLAG_1000000) != 0)
        {
            if ((sWaterSurface->flags & WATERSURFACE_FLAG_HAS_WATER_SURFACE) != 0)
            {
                fx32 surfacePosY = FX32_FROM_WHOLE(mapCamera.camera[i].waterLevel) - mapCamera.camera[i].disp_pos.y;
                if (HW_LCD_HEIGHT * mapCamera.camera[i].scale.y > surfacePosY && surfacePosY >= 0)
                {
                    s16 surfacePosX                            = -(FX32_TO_WHOLE(mapCamera.camera[i].disp_pos.x) & 0x3F);
                    sWaterSurface->aniWaterSurface[i].pos.y = FX32_TO_WHOLE(surfacePosY);
                    for (; surfacePosX < HW_LCD_WIDTH; surfacePosX += 64)
                    {
                        sWaterSurface->aniWaterSurface[i].pos.x = surfacePosX;
                        AnimatorSprite__DrawFrame(&sWaterSurface->aniWaterSurface[i]);
                    }
                }
            }
        }
    }
}

void WaterSurface_Main(void)
{
    u32 i;
    fx32 vAlarmCount;
    MapSysCamera *camera = mapCamera.camera;

    for (i = 0; i < 2; i++)
    {
        OS_CancelVAlarm(&sWaterSurface->vAlarm[i]);

        if ((camera->flags & MAPSYS_CAMERA_FLAG_2000000) == 0 && (camera->flags & MAPSYS_CAMERA_FLAG_1000000) != 0)
        {
            fx32 waterLevel = FX32_FROM_WHOLE(camera->waterLevel) - camera->disp_pos.y;
            if (HW_LCD_HEIGHT * camera->scale.y < waterLevel)
            {
                if ((sWaterSurface->flags & (16 << i)) == 0 || (sWaterSurface->flags & WATERSURFACE_FLAG_40) != 0)
                {
                    WaterSurface_CopyPalette(i);
                    sWaterSurface->flags |= 16 << i;
                }
            }
            else
            {
                if (waterLevel > 4 * camera->scale.y)
                {
                    vAlarmCount                      = FX32_TO_WHOLE(FX_Div(waterLevel, camera->scale.y));
                    sWaterSurface->vAlarmCount[i] = vAlarmCount;

                    if ((sWaterSurface->flags & (16 << i)) == 0 || (sWaterSurface->flags & WATERSURFACE_FLAG_40) != 0)
                    {
                        WaterSurface_CopyPalette(i);
                        sWaterSurface->flags |= 16 << i;
                    }

                    OS_SetVAlarm(&sWaterSurface->vAlarm[i], (s16)vAlarmCount, 7, WaterSurface_VAlarmCB_200E26C, INT_TO_VOID(i));
                }
                else
                {
                    u32 prevFlags = sWaterSurface->flags;

                    if ((sWaterSurface->flags & (16 << i)) == 0 && (sWaterSurface->flags & WATERSURFACE_FLAG_40) == 0)
                        sWaterSurface->flags &= ~(WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_1 | WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_2);

                    WaterSurface_CopyAltPalette(i);
                    sWaterSurface->flags &= ~(16 << i);

                    if ((sWaterSurface->flags & (16 << i)) == 0 && (sWaterSurface->flags & WATERSURFACE_FLAG_40) == 0)
                        sWaterSurface->flags |= prevFlags & (WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_1 | WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_2);
                }
            }
        }
        else
        {
            if ((sWaterSurface->flags & (16 << i)) == 0 || (sWaterSurface->flags & WATERSURFACE_FLAG_40) != 0)
            {
                WaterSurface_CopyPalette(i);
                sWaterSurface->flags |= 16 << i;
            }
        }

        camera++;
    }
}

void WaterSurface_VAlarmCB_200E26C(void *useEngineB)
{
    WaterSurface_CopyAltPalette(VOID_TO_INT(useEngineB));
    sWaterSurface->flags &= ~(16 << VOID_TO_INT(useEngineB));

    OS_SetVAlarm(&sWaterSurface->vAlarm[VOID_TO_INT(useEngineB)], 200, 7, WaterSurface_VAlarmCB_200E2CC, INT_TO_VOID(useEngineB));
}

void WaterSurface_VAlarmCB_200E2CC(void *useEngineB)
{
    WaterSurface_CopyPalette(VOID_TO_INT(useEngineB));
    sWaterSurface->flags |= (16 << VOID_TO_INT(useEngineB));

    OS_SetVAlarm(&sWaterSurface->vAlarm[VOID_TO_INT(useEngineB)], sWaterSurface->vAlarmCount[VOID_TO_INT(useEngineB)], 7, WaterSurface_VAlarmCB_200E26C,
                 INT_TO_VOID(useEngineB));
}

NONMATCH_FUNC void InitUnderwaterPalette(u16 *palettePtr, u32 count)
{
    // https://decomp.me/scratch/PARIv -> 77.60%
#ifdef NON_MATCHING
    for (u32 i = 0; i < count; i++)
    {
        GXRgb color = *palettePtr;

        s16 r = MATH_MAX(((color & GX_RGB_R_MASK) >> GX_RGB_R_SHIFT) - 10, 0) << 8;
        s16 g = MATH_MAX(((color & GX_RGB_G_MASK) >> GX_RGB_G_SHIFT) - 1, 0) << 8;
        s16 b = MATH_MAX(((color & GX_RGB_B_MASK) >> GX_RGB_B_SHIFT), 0) << 8;

        *palettePtr = GX_RGB(r, g, b);

        palettePtr++;
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	cmp r1, #0
	mov r3, #0
	ldmlsia sp!, {r4, r5, r6, pc}
	mov r2, r3
	mov r5, r3
_0200E344:
	ldrh lr, [r0]
	add r3, r3, #1
	and r4, lr, #0x1f
	subs r6, r4, #0xa
	and r4, lr, #0x3e0
	movmi r6, r2
	mov ip, r4, asr #5
	mov r4, r6, lsl #0x18
	subs r6, ip, #1
	movmi r6, r5
	and ip, lr, #0x7c00
	mov ip, ip, asr #0xa
	mov lr, r6, lsl #0x18
	mov ip, ip, lsl #0x18
	mov lr, lr, asr #0x13
	mov ip, ip, asr #0x18
	orr r4, lr, r4, asr #24
	orr r4, r4, ip, lsl #10
	cmp r3, r1
	strh r4, [r0], #2
	blo _0200E344
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

void WaterSurface_CopyPalette(BOOL useEngineB)
{
    DC_StoreRange(sWaterSurface->surfacePalette1, sizeof(sWaterSurface->surfacePalette1) * 2);
    DC_StoreRange(gObjDrawPalette2, sizeof(gObjDrawPalette2));
    DC_WaitWriteBufferEmpty();

    if ((sWaterSurface->flags & WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_2) != 0)
    {
        if (useEngineB)
        {
            GXVRamSubBGExtPltt sSubBGExtPltt = GX_ResetBankForSubBGExtPltt();

            RenderCore_DMACopy(sWaterSurface->surfacePalette2, gBgExtPalBankManager[useEngineB].location[2], 2 * sWaterSurface->paletteSize2);
            RenderCore_DMACopy(sWaterSurface->surfacePalette2, gBgExtPalBankManager[useEngineB].location[3], 2 * sWaterSurface->paletteSize2);

            GX_SetBankForSubBGExtPltt(sSubBGExtPltt);
        }
        else
        {
            GXVRamBGExtPltt sBGExtPltt = GX_ResetBankForBGExtPltt();

            RenderCore_DMACopy(sWaterSurface->surfacePalette2, gBgExtPalBankManager[useEngineB].location[2], 2 * sWaterSurface->paletteSize2);
            RenderCore_DMACopy(sWaterSurface->surfacePalette2, gBgExtPalBankManager[useEngineB].location[3], 2 * sWaterSurface->paletteSize2);

            GX_SetBankForBGExtPltt(sBGExtPltt);
        }
    }

    if ((sWaterSurface->flags & WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_1) != 0)
        RenderCore_DMACopy(sWaterSurface->surfacePalette1, sSurfacePaletteTable[useEngineB], 2 * sWaterSurface->paletteSize1);

    if ((sWaterSurface->flags & WATERSURFACE_FLAG_HAS_SPRITE_UNDERWATER_PALETTE) != 0)
    {
        RenderCore_DMACopy((u16 *)gObjDrawPalette2 + 48, (u16 *)sSpritePalette2Table[useEngineB] + 48, sizeof(gObjDrawPalette2) - (sizeof(GXRgb) * 48));
    }
}

void WaterSurface_CopyAltPalette(BOOL useEngineB)
{
    DC_StoreRange(sWaterSurface->underwaterPalette1, sizeof(sWaterSurface->underwaterPalette1) * 2);
    DC_WaitWriteBufferEmpty();
    DC_StoreRange(gObjDrawPalette1, sizeof(gObjDrawPalette1));

    if ((sWaterSurface->flags & WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_2) != 0)
    {
        if (useEngineB)
        {
            GXVRamSubBGExtPltt sSubBGExtPltt = GX_ResetBankForSubBGExtPltt();

            RenderCore_DMACopy(sWaterSurface->underwaterPalette2, gBgExtPalBankManager[useEngineB].location[2], 2 * sWaterSurface->paletteSize2);
            RenderCore_DMACopy(sWaterSurface->underwaterPalette2, gBgExtPalBankManager[useEngineB].location[3], 2 * sWaterSurface->paletteSize2);

            GX_SetBankForSubBGExtPltt(sSubBGExtPltt);
        }
        else
        {
            GXVRamBGExtPltt sBGExtPltt = GX_ResetBankForBGExtPltt();

            RenderCore_DMACopy(sWaterSurface->underwaterPalette2, gBgExtPalBankManager[useEngineB].location[2], 2 * sWaterSurface->paletteSize2);
            RenderCore_DMACopy(sWaterSurface->underwaterPalette2, gBgExtPalBankManager[useEngineB].location[3], 2 * sWaterSurface->paletteSize2);

            GX_SetBankForBGExtPltt(sBGExtPltt);
        }
    }

    if ((sWaterSurface->flags & WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_1) != 0)
        RenderCore_DMACopy(sWaterSurface->underwaterPalette1, sUnderwaterPaletteTable[useEngineB], 2 * sWaterSurface->paletteSize1);

    if ((sWaterSurface->flags & WATERSURFACE_FLAG_HAS_SPRITE_UNDERWATER_PALETTE) != 0)
    {
        DC_WaitWriteBufferEmpty();
        RenderCore_DMACopy((u16 *)gObjDrawPalette1 + 48, (u16 *)sSpritePalette1Table[useEngineB] + 48, sizeof(gObjDrawPalette1) - (sizeof(GXRgb) * 48));
    }
}
