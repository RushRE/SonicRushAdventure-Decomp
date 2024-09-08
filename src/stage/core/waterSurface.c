#include <stage/core/waterSurface.h>
#include <game/game/gameState.h>
#include <game/graphics/renderCore.h>
#include <game/object/objData.h>
#include <game/object/objDraw.h>
#include <game/stage/gameSystem.h>

// --------------------
// TYPES
// --------------------

typedef void (*WaterSurfaceInitFunc)(void);
typedef void (*WaterSurfaceProcessFunc)(void);
typedef void (*WaterSurfaceReleaseFunc)(void);

// --------------------
// FUNCTION DECLS
// --------------------

// WaterSurface Management
static void WaterSurface__Init_Zone1(void);
static void WaterSurface__Release_Zone1(void);
static void WaterSurface__Process_Zone1(void);

static void WaterSurface__Init_Zone2(void);
static void WaterSurface__Release_Zone2(void);
static void WaterSurface__Process_Zone2(void);

static void WaterSurface__Init_Zone3(void);
static void WaterSurface__Release_Zone3(void);
static void WaterSurface__Process_Zone3(void);

static void WaterSurface__Init_Zone6(void);
static void WaterSurface__Release_Zone6(void);
static void WaterSurface__Process_Zone6(void);

static void WaterSurface__Init_Zone7(void);
static void WaterSurface__Release_Zone7(void);
static void WaterSurface__Process_Zone7(void);

// --------------------
// VARIABLES
// --------------------

static struct WaterSurfaceStaticVars *waterSurfaceWork;

static const WaterSurfaceReleaseFunc waterSurfaceReleaseTable[STAGE_COUNT] = {
    [STAGE_Z11]               = WaterSurface__Release_Zone1,
    [STAGE_Z12]               = WaterSurface__Release_Zone1,
    [STAGE_TUTORIAL]          = WaterSurface__Release_Zone1,
    [STAGE_Z1B]               = NULL,
    [STAGE_Z21]               = WaterSurface__Release_Zone2,
    [STAGE_Z22]               = WaterSurface__Release_Zone2,
    [STAGE_Z2B]               = NULL,
    [STAGE_Z31]               = WaterSurface__Release_Zone3,
    [STAGE_Z32]               = WaterSurface__Release_Zone3,
    [STAGE_HIDDEN_ISLAND_1]   = NULL,
    [STAGE_Z3B]               = NULL,
    [STAGE_Z41]               = NULL,
    [STAGE_Z42]               = NULL,
    [STAGE_Z4B]               = NULL,
    [STAGE_Z51]               = NULL,
    [STAGE_Z52]               = NULL,
    [STAGE_Z5B]               = NULL,
    [STAGE_Z61]               = WaterSurface__Release_Zone6,
    [STAGE_Z62]               = WaterSurface__Release_Zone6,
    [STAGE_HIDDEN_ISLAND_2]   = NULL,
    [STAGE_Z6B]               = NULL,
    [STAGE_Z71]               = WaterSurface__Release_Zone7,
    [STAGE_Z72]               = WaterSurface__Release_Zone7,
    [STAGE_Z7B]               = NULL,
    [STAGE_BOSS_FINAL]        = NULL,
    [STAGE_HIDDEN_ISLAND_3]   = NULL,
    [STAGE_HIDDEN_ISLAND_4]   = WaterSurface__Release_Zone3,
    [STAGE_HIDDEN_ISLAND_5]   = NULL,
    [STAGE_HIDDEN_ISLAND_6]   = WaterSurface__Release_Zone1,
    [STAGE_HIDDEN_ISLAND_7]   = WaterSurface__Release_Zone1,
    [STAGE_HIDDEN_ISLAND_8]   = WaterSurface__Release_Zone3,
    [STAGE_HIDDEN_ISLAND_9]   = WaterSurface__Release_Zone2,
    [STAGE_HIDDEN_ISLAND_10]  = WaterSurface__Release_Zone2,
    [STAGE_HIDDEN_ISLAND_11]  = WaterSurface__Release_Zone3,
    [STAGE_HIDDEN_ISLAND_12]  = NULL,
    [STAGE_HIDDEN_ISLAND_13]  = NULL,
    [STAGE_HIDDEN_ISLAND_14]  = NULL,
    [STAGE_HIDDEN_ISLAND_15]  = NULL,
    [STAGE_HIDDEN_ISLAND_16]  = NULL,
    [STAGE_HIDDEN_ISLAND_VS1] = WaterSurface__Release_Zone1,
    [STAGE_HIDDEN_ISLAND_VS2] = WaterSurface__Release_Zone2,
    [STAGE_HIDDEN_ISLAND_VS3] = WaterSurface__Release_Zone3,
    [STAGE_HIDDEN_ISLAND_VS4] = NULL,
    [STAGE_HIDDEN_ISLAND_R1]  = NULL,
    [STAGE_HIDDEN_ISLAND_R2]  = NULL,
    [STAGE_HIDDEN_ISLAND_R3]  = NULL,
};

static const WaterSurfaceInitFunc waterSurfaceInitTable[STAGE_COUNT] = {
    [STAGE_Z11]               = WaterSurface__Init_Zone1,
    [STAGE_Z12]               = WaterSurface__Init_Zone1,
    [STAGE_TUTORIAL]          = WaterSurface__Init_Zone1,
    [STAGE_Z1B]               = NULL,
    [STAGE_Z21]               = WaterSurface__Init_Zone2,
    [STAGE_Z22]               = WaterSurface__Init_Zone2,
    [STAGE_Z2B]               = NULL,
    [STAGE_Z31]               = WaterSurface__Init_Zone3,
    [STAGE_Z32]               = WaterSurface__Init_Zone3,
    [STAGE_HIDDEN_ISLAND_1]   = NULL,
    [STAGE_Z3B]               = NULL,
    [STAGE_Z41]               = NULL,
    [STAGE_Z42]               = NULL,
    [STAGE_Z4B]               = NULL,
    [STAGE_Z51]               = NULL,
    [STAGE_Z52]               = NULL,
    [STAGE_Z5B]               = NULL,
    [STAGE_Z61]               = WaterSurface__Init_Zone6,
    [STAGE_Z62]               = WaterSurface__Init_Zone6,
    [STAGE_HIDDEN_ISLAND_2]   = NULL,
    [STAGE_Z6B]               = NULL,
    [STAGE_Z71]               = WaterSurface__Init_Zone7,
    [STAGE_Z72]               = WaterSurface__Init_Zone7,
    [STAGE_Z7B]               = NULL,
    [STAGE_BOSS_FINAL]        = NULL,
    [STAGE_HIDDEN_ISLAND_3]   = NULL,
    [STAGE_HIDDEN_ISLAND_4]   = WaterSurface__Init_Zone3,
    [STAGE_HIDDEN_ISLAND_5]   = NULL,
    [STAGE_HIDDEN_ISLAND_6]   = WaterSurface__Init_Zone1,
    [STAGE_HIDDEN_ISLAND_7]   = WaterSurface__Init_Zone1,
    [STAGE_HIDDEN_ISLAND_8]   = WaterSurface__Init_Zone3,
    [STAGE_HIDDEN_ISLAND_9]   = WaterSurface__Init_Zone2,
    [STAGE_HIDDEN_ISLAND_10]  = WaterSurface__Init_Zone2,
    [STAGE_HIDDEN_ISLAND_11]  = WaterSurface__Init_Zone3,
    [STAGE_HIDDEN_ISLAND_12]  = NULL,
    [STAGE_HIDDEN_ISLAND_13]  = NULL,
    [STAGE_HIDDEN_ISLAND_14]  = NULL,
    [STAGE_HIDDEN_ISLAND_15]  = NULL,
    [STAGE_HIDDEN_ISLAND_16]  = NULL,
    [STAGE_HIDDEN_ISLAND_VS1] = WaterSurface__Init_Zone1,
    [STAGE_HIDDEN_ISLAND_VS2] = WaterSurface__Init_Zone2,
    [STAGE_HIDDEN_ISLAND_VS3] = WaterSurface__Init_Zone3,
    [STAGE_HIDDEN_ISLAND_VS4] = NULL,
    [STAGE_HIDDEN_ISLAND_R1]  = NULL,
    [STAGE_HIDDEN_ISLAND_R2]  = NULL,
    [STAGE_HIDDEN_ISLAND_R3]  = NULL,
};

static const WaterSurfaceProcessFunc waterSurfaceProcessTable[STAGE_COUNT] = {
    [STAGE_Z11]               = WaterSurface__Process_Zone1,
    [STAGE_Z12]               = WaterSurface__Process_Zone1,
    [STAGE_TUTORIAL]          = WaterSurface__Process_Zone1,
    [STAGE_Z1B]               = NULL,
    [STAGE_Z21]               = WaterSurface__Process_Zone2,
    [STAGE_Z22]               = WaterSurface__Process_Zone2,
    [STAGE_Z2B]               = NULL,
    [STAGE_Z31]               = WaterSurface__Process_Zone3,
    [STAGE_Z32]               = WaterSurface__Process_Zone3,
    [STAGE_HIDDEN_ISLAND_1]   = NULL,
    [STAGE_Z3B]               = NULL,
    [STAGE_Z41]               = NULL,
    [STAGE_Z42]               = NULL,
    [STAGE_Z4B]               = NULL,
    [STAGE_Z51]               = NULL,
    [STAGE_Z52]               = NULL,
    [STAGE_Z5B]               = NULL,
    [STAGE_Z61]               = WaterSurface__Process_Zone6,
    [STAGE_Z62]               = WaterSurface__Process_Zone6,
    [STAGE_HIDDEN_ISLAND_2]   = NULL,
    [STAGE_Z6B]               = NULL,
    [STAGE_Z71]               = WaterSurface__Process_Zone7,
    [STAGE_Z72]               = WaterSurface__Process_Zone7,
    [STAGE_Z7B]               = NULL,
    [STAGE_BOSS_FINAL]        = NULL,
    [STAGE_HIDDEN_ISLAND_3]   = NULL,
    [STAGE_HIDDEN_ISLAND_4]   = WaterSurface__Process_Zone3,
    [STAGE_HIDDEN_ISLAND_5]   = NULL,
    [STAGE_HIDDEN_ISLAND_6]   = WaterSurface__Process_Zone1,
    [STAGE_HIDDEN_ISLAND_7]   = WaterSurface__Process_Zone1,
    [STAGE_HIDDEN_ISLAND_8]   = WaterSurface__Process_Zone3,
    [STAGE_HIDDEN_ISLAND_9]   = WaterSurface__Process_Zone2,
    [STAGE_HIDDEN_ISLAND_10]  = WaterSurface__Process_Zone2,
    [STAGE_HIDDEN_ISLAND_11]  = WaterSurface__Process_Zone3,
    [STAGE_HIDDEN_ISLAND_12]  = NULL,
    [STAGE_HIDDEN_ISLAND_13]  = NULL,
    [STAGE_HIDDEN_ISLAND_14]  = NULL,
    [STAGE_HIDDEN_ISLAND_15]  = NULL,
    [STAGE_HIDDEN_ISLAND_16]  = NULL,
    [STAGE_HIDDEN_ISLAND_VS1] = WaterSurface__Process_Zone1,
    [STAGE_HIDDEN_ISLAND_VS2] = WaterSurface__Process_Zone2,
    [STAGE_HIDDEN_ISLAND_VS3] = WaterSurface__Process_Zone3,
    [STAGE_HIDDEN_ISLAND_VS4] = NULL,
    [STAGE_HIDDEN_ISLAND_R1]  = NULL,
    [STAGE_HIDDEN_ISLAND_R2]  = NULL,
    [STAGE_HIDDEN_ISLAND_R3]  = NULL,
};

NOT_DECOMPILED void *_02118C40;
NOT_DECOMPILED void *_02118C48;
NOT_DECOMPILED void *_02118C50;
NOT_DECOMPILED void *_02118C58;

NOT_DECOMPILED const char *aBpaZ2MapBpa;
NOT_DECOMPILED const char *aBpaZ3MapBpa;
NOT_DECOMPILED const char *aBpaZ3MapWBpa;
NOT_DECOMPILED const char *aBpaZ3FarBpa;
NOT_DECOMPILED const char *aBpaZ6MapBpa;
NOT_DECOMPILED const char *aBpaZ6FarBpa;
NOT_DECOMPILED const char *aActAcEffWaterB;

// --------------------
// FUNCTIONS
// --------------------

// WaterSurface Management
void WaterSurface__Init(void)
{
    if (waterSurfaceInitTable[gameState.stageID] != NULL)
    {
        waterSurfaceWork = HeapAllocHead(HEAP_USER, sizeof(struct WaterSurfaceStaticVars));
        MI_CpuClear16(waterSurfaceWork, sizeof(*waterSurfaceWork));

        waterSurfaceInitTable[gameState.stageID]();
    }
}

void WaterSurface__Release(void)
{
    if (waterSurfaceReleaseTable[gameState.stageID] != NULL)
        waterSurfaceReleaseTable[gameState.stageID]();

    if (waterSurfaceWork != NULL)
    {
        if (waterSurfaceWork->aniPalette != NULL)
            HeapFree(HEAP_USER, waterSurfaceWork->aniPalette);

        HeapFree(HEAP_USER, waterSurfaceWork);
        waterSurfaceWork = NULL;
    }
}

void WaterSurface__Process(void)
{
    if (waterSurfaceProcessTable[gameState.stageID] != NULL)
        waterSurfaceProcessTable[gameState.stageID]();
}

void WaterSurface__Init_Zone1(void)
{
    waterSurfaceWork->flags |= (1 << 0);
    waterSurfaceWork->paletteSize1 = 240;
    waterSurfaceWork->paletteSize2 = 256;
    WaterSurface__Create();
}

void WaterSurface__Release_Zone1(void)
{
    WaterSurface__ReleaseCommon();
}

void WaterSurface__Process_Zone1(void)
{
    WaterSurface__Func_200DF78();
}

void WaterSurface__Init_Zone2(void)
{
    waterSurfaceWork->aniPalette = HeapAllocHead(HEAP_USER, sizeof(PaletteAnimator));

    PaletteAnimator *aniPalette = waterSurfaceWork->aniPalette;
    MI_CpuClear16(aniPalette, sizeof(PaletteAnimator));

    void *paletteAniFile = ObjDataLoad(NULL, "/bpa/z2_map.bpa", gameArchiveStage);
    InitPaletteAnimator(aniPalette, paletteAniFile, 0, ANIMATORBPA_FLAG_CAN_LOOP, PALETTE_MODE_BG, VRAMKEY_TO_ADDR(0x4000));
}

void WaterSurface__Release_Zone2(void)
{
    ReleasePaletteAnimator(waterSurfaceWork->aniPalette);
}

void WaterSurface__Process_Zone2(void)
{
    PaletteAnimator *aniPalette = waterSurfaceWork->aniPalette;

    AnimatePalette(aniPalette);
    if (CheckPaletteAnimationIsValid(aniPalette))
    {
        SetPaletteAnimationTarget(aniPalette, PALETTE_MODE_BG, VRAMKEY_TO_ADDR(0x4000));
        DrawAnimatedPalette(aniPalette);

        SetPaletteAnimationTarget(aniPalette, PALETTE_MODE_BG, VRAMKEY_TO_ADDR(0x6000));
        DrawAnimatedPalette(aniPalette);

        SetPaletteAnimationTarget(aniPalette, PALETTE_MODE_SUB_BG, VRAMKEY_TO_ADDR(0x4000));
        DrawAnimatedPalette(aniPalette);

        SetPaletteAnimationTarget(aniPalette, PALETTE_MODE_SUB_BG, VRAMKEY_TO_ADDR(0x6000));
        DrawAnimatedPalette(aniPalette);
    }
}

NONMATCH_FUNC void WaterSurface__Init_Zone3(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r0, #0x220
	bl _AllocHeadHEAP_USER
	ldr r1, =waterSurfaceWork
	mov r2, #0x220
	ldr r3, [r1]
	str r0, [r3, #0x9cc]
	ldr r1, [r1]
	mov r0, #0
	ldr r10, [r1, #0x9cc]
	mov r1, r10
	bl MIi_CpuClear16
	ldr r0, =waterSurfaceWork
	mov r3, #0xf0
	ldr r4, [r0]
	mov r1, #0x100
	ldr r2, [r4]
	orr r2, r2, #0xf
	str r2, [r4]
	ldr r2, [r0]
	strh r3, [r2, #8]
	ldr r0, [r0]
	strh r1, [r0, #0xa]
	bl WaterSurface__Create
	mov r9, #0
	ldr r7, =aBpaZ3MapBpa
	ldr r4, =gameArchiveStage
	mov r8, r9
	mov r6, #1
	mov r5, #0x4000
	mov r11, #2
_0200D5BC:
	ldr r2, [r4]
	mov r0, r8
	mov r1, r7
	bl ObjDataLoad
	mov r1, r0
	str r6, [sp]
	mov r2, r9
	str r5, [sp, #4]
	add r0, r10, r9, lsl #5
	mov r3, r11
	bl InitPaletteAnimator
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #7
	blo _0200D5BC
	mov r9, #0
	ldr r11, =aBpaZ3MapWBpa
	ldr r5, =gameArchiveStage
	ldr r4, =waterSurfaceWork
	add r6, r10, #0xe0
	mov r8, r9
	mov r7, r9
_0200D618:
	ldr r2, [r5]
	mov r0, r8
	mov r1, r11
	bl ObjDataLoad
	str r7, [sp]
	ldr r2, [r4]
	mov r1, r0
	add r0, r2, #0x610
	str r0, [sp, #4]
	add r0, r6, r9, lsl #5
	mov r2, r9
	mov r3, #2
	bl InitPaletteAnimator
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #6
	blo _0200D618
	add r0, r10, #0x100
	ldrh r1, [r0, #0xa0]
	mov r4, #0
	add r6, r10, #0x1c0
	orr r1, r1, #1
	ldr r9, =aBpaZ3FarBpa
	ldr r5, =gameArchiveStage
	strh r1, [r0, #0xa0]
	mov r10, r4
	mov r8, r4
	mov r7, #0x5000000
	mov r11, #2
_0200D690:
	ldr r2, [r5]
	mov r0, r10
	mov r1, r9
	bl ObjDataLoad
	mov r1, r0
	str r8, [sp]
	mov r2, r4
	str r7, [sp, #4]
	add r0, r6, r4, lsl #5
	mov r3, r11
	bl InitPaletteAnimator
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	cmp r4, #3
	blo _0200D690
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterSurface__Release_Zone3(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, =waterSurfaceWork
	ldr r0, [r0]
	ldr r5, [r0, #0x9cc]
	bl WaterSurface__ReleaseCommon
	mov r6, r5
	mov r4, #0
_0200D708:
	mov r0, r6
	bl ReleasePaletteAnimator
	add r4, r4, #1
	cmp r4, #7
	add r6, r6, #0x20
	blt _0200D708
	add r4, r5, #0xe0
	mov r6, #0
_0200D728:
	mov r0, r4
	bl ReleasePaletteAnimator
	add r6, r6, #1
	cmp r6, #6
	add r4, r4, #0x20
	blt _0200D728
	add r4, r5, #0x1c0
	mov r5, #0
_0200D748:
	mov r0, r4
	bl ReleasePaletteAnimator
	add r5, r5, #1
	cmp r5, #3
	add r4, r4, #0x20
	blt _0200D748
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterSurface__Process_Zone3(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r0, =waterSurfaceWork
	ldr r2, [r0]
	ldr r0, [r2, #0x9cc]
	ldr r1, [r2]
	str r0, [sp]
	bic r0, r1, #0x40
	str r0, [r2]
	bl WaterSurface__Func_200DF78
	ldr r0, =mapCamera
	mov r7, #0
	ldr r2, [r0, #0x70]
	ldr r1, [r0]
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
	ldr r2, =waterSurfaceWork
	mov r0, r5
	ldr r2, [r2]
	mov r1, #0
	add r2, r2, #0x210
	bl SetPaletteAnimationTarget
	mov r0, r5
	bl DrawAnimatedPalette
	mov r0, r6
	bl DrawAnimatedPalette
	ldr r0, =waterSurfaceWork
	ldr r1, [r0]
	ldr r0, [r1]
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
	ldr r4, =waterSurfaceWork
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
	ldr r1, [r4]
	mov r0, r6
	add r2, r1, #0x10
	mov r1, #0
	bl SetPaletteAnimationTarget
	mov r0, r6
	bl DrawAnimatedPalette
	ldr r1, [r4]
	ldr r0, [r1]
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

NONMATCH_FUNC void WaterSurface__Init_Zone6(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r0, #0xc0
	bl _AllocHeadHEAP_USER
	ldr r1, =waterSurfaceWork
	mov r2, #0xc0
	ldr r3, [r1]
	str r0, [r3, #0x9cc]
	ldr r1, [r1]
	mov r0, #0
	ldr r10, [r1, #0x9cc]
	mov r1, r10
	bl MIi_CpuClear16
	mov r9, #0
	ldr r7, =aBpaZ6MapBpa
	ldr r4, =gameArchiveStage
	mov r8, r9
	mov r6, #1
	mov r5, #0x4000
	mov r11, #2
_0200D9F8:
	ldr r2, [r4]
	mov r0, r8
	mov r1, r7
	bl ObjDataLoad
	mov r1, r0
	str r6, [sp]
	mov r2, r9
	str r5, [sp, #4]
	add r0, r10, r9, lsl #5
	mov r3, r11
	bl InitPaletteAnimator
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #4
	blo _0200D9F8
	mov r4, #0
	add r6, r10, #0x80
	ldr r9, =aBpaZ6FarBpa
	ldr r5, =gameArchiveStage
	mov r10, r4
	mov r8, r4
	mov r7, #0x5000000
	mov r11, #2
_0200DA58:
	ldr r2, [r5]
	mov r0, r10
	mov r1, r9
	bl ObjDataLoad
	mov r1, r0
	str r8, [sp]
	mov r2, r4
	str r7, [sp, #4]
	add r0, r6, r4, lsl #5
	mov r3, r11
	bl InitPaletteAnimator
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	cmp r4, #2
	blo _0200DA58
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterSurface__Release_Zone6(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, =waterSurfaceWork
	mov r4, #0
	ldr r0, [r0]
	ldr r5, [r0, #0x9cc]
	mov r6, r5
_0200DAC8:
	mov r0, r6
	bl ReleasePaletteAnimator
	add r4, r4, #1
	cmp r4, #4
	add r6, r6, #0x20
	blt _0200DAC8
	add r4, r5, #0x80
	mov r5, #0
_0200DAE8:
	mov r0, r4
	bl ReleasePaletteAnimator
	add r5, r5, #1
	cmp r5, #2
	add r4, r4, #0x20
	blt _0200DAE8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterSurface__Process_Zone6(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r0, =waterSurfaceWork
	mov r8, #1
	ldr r0, [r0]
	mov r7, #0x4000
	ldr r10, [r0, #0x9cc]
	mov r9, #0
	str r10, [sp]
	mov r6, r8
	mov r5, #0x6000
	mov r4, #3
	mov r11, r7
_0200DB38:
	mov r0, r10
	bl AnimatePalette
	mov r0, r10
	bl CheckPaletteAnimationIsValid
	cmp r0, #0
	beq _0200DBB0
	mov r0, r10
	mov r1, r8
	mov r2, r7
	bl SetPaletteAnimationTarget
	mov r0, r10
	bl DrawAnimatedPalette
	mov r0, r10
	mov r1, r6
	mov r2, r5
	bl SetPaletteAnimationTarget
	mov r0, r10
	bl DrawAnimatedPalette
	mov r0, r10
	mov r1, r4
	mov r2, r11
	bl SetPaletteAnimationTarget
	mov r0, r10
	bl DrawAnimatedPalette
	mov r0, r10
	mov r1, #3
	mov r2, #0x6000
	bl SetPaletteAnimationTarget
	mov r0, r10
	bl DrawAnimatedPalette
_0200DBB0:
	add r9, r9, #1
	cmp r9, #4
	add r10, r10, #0x20
	blt _0200DB38
	ldr r0, [sp]
	mov r9, #0
	ldr r4, =0x05000400
	add r8, r0, #0x80
	mov r7, r9
	mov r6, #0x5000000
	mov r5, r9
_0200DBDC:
	mov r0, r8
	bl AnimatePalette
	mov r0, r8
	bl CheckPaletteAnimationIsValid
	cmp r0, #0
	beq _0200DC24
	mov r0, r8
	mov r1, r7
	mov r2, r6
	bl SetPaletteAnimationTarget
	mov r0, r8
	bl DrawAnimatedPalette
	mov r0, r8
	mov r1, r5
	mov r2, r4
	bl SetPaletteAnimationTarget
	mov r0, r8
	bl DrawAnimatedPalette
_0200DC24:
	add r9, r9, #1
	cmp r9, #2
	add r8, r8, #0x20
	blt _0200DBDC
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void WaterSurface__Init_Zone7(void)
{
    waterSurfaceWork->flags |= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3);
    waterSurfaceWork->paletteSize1 = 240;
    waterSurfaceWork->paletteSize2 = 256;
    WaterSurface__Create();
}

void WaterSurface__Release_Zone7(void)
{
    WaterSurface__ReleaseCommon();
}

void WaterSurface__Process_Zone7(void)
{
    WaterSurface__Func_200DF78();
}

// WaterSurface
NONMATCH_FUNC void WaterSurface__Create(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	ldr r0, =waterSurfaceWork
	ldr r0, [r0]
	add r0, r0, #0x810
	bl OS_CreateVAlarm
	ldr r0, =waterSurfaceWork
	ldr r0, [r0]
	add r0, r0, #0x38
	add r0, r0, #0x800
	bl OS_CreateVAlarm
	ldr r0, =waterSurfaceWork
	ldr r1, [r0]
	ldr r0, [r1]
	tst r0, #2
	beq _0200DD10
	add r1, r1, #0x10
	mov r0, #0x5000000
	mov r2, #0x200
	bl MIi_CpuCopy32
	ldr r1, =waterSurfaceWork
	mov r0, #0x5000000
	ldr r1, [r1]
	mov r2, #0x200
	add r1, r1, #0x410
	bl MIi_CpuCopy32
	ldr r0, =waterSurfaceWork
	ldr r0, [r0]
	ldrh r1, [r0, #8]
	add r0, r0, #0x410
	bl WaterSurface__InitPalette
_0200DD10:
	ldr r0, =waterSurfaceWork
	ldr r0, [r0]
	ldr r0, [r0]
	tst r0, #4
	beq _0200DD80
	bl GX_ResetBankForBGExtPltt
	ldr r2, =bgExtPalBankManager
	ldr r1, =waterSurfaceWork
	ldr r5, [r2, #8]
	ldr r1, [r1]
	mov r4, r0
	mov r0, r5
	add r1, r1, #0x210
	mov r2, #0x200
	bl MIi_CpuCopy32
	ldr r1, =waterSurfaceWork
	mov r0, r5
	ldr r1, [r1]
	mov r2, #0x200
	add r1, r1, #0x610
	bl MIi_CpuCopy32
	mov r0, r4
	bl GX_SetBankForBGExtPltt
	ldr r0, =waterSurfaceWork
	ldr r0, [r0]
	ldrh r1, [r0, #0xa]
	add r0, r0, #0x610
	bl WaterSurface__InitPalette
_0200DD80:
	ldr r0, =waterSurfaceWork
	ldr r0, [r0]
	ldr r0, [r0]
	tst r0, #8
	beq _0200DE88
	ldr r0, =gameArchiveStage
	ldr r1, =aActAcEffWaterB
	ldr r2, [r0]
	mov r0, #0
	bl ObjDataLoad
	mov r4, r0
	mov r0, #0
	mov r1, #4
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =0x05000200
	str r1, [sp, #0xc]
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r1, #0xc
	ldr r0, =waterSurfaceWork
	str r1, [sp, #0x18]
	ldr r0, [r0]
	mov r1, r4
	add r0, r0, #0x104
	add r0, r0, #0x800
	mov r2, #3
	mov r3, #0x14
	bl AnimatorSprite__Init
	mov r0, #1
	mov r1, #4
	bl VRAMSystem__AllocSpriteVram
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r1, =0x05000600
	mov r0, #0xc
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r0, =waterSurfaceWork
	mov r1, r4
	ldr r0, [r0]
	mov r2, #3
	add r0, r0, #0x168
	add r0, r0, #0x800
	mov r3, #0x14
	bl AnimatorSprite__Init
	mov r0, r4
	mov r1, #3
	mov r2, #0x21
	bl ObjDrawAllocSpritePalette
	ldr r2, =waterSurfaceWork
	ldr r1, [r2]
	add r1, r1, #0x900
	strh r0, [r1, #0xb8]
	ldr r0, [r2]
	add r0, r0, #0x900
	ldrh r1, [r0, #0xb8]
	strh r1, [r0, #0x54]
_0200DE88:
	ldr r0, =waterSurfaceWork
	ldr r0, [r0]
	ldr r0, [r0]
	tst r0, #7
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, pc}
	mov r0, #0xf200
	mov r1, #0
	str r0, [sp]
	mov r3, #3
	str r3, [sp, #4]
	ldr r0, =WaterSurface__Main
	mov r2, r1
	str r1, [sp, #8]
	bl TaskCreate_
	ldr r1, =waterSurfaceWork
	ldr r1, [r1]
	str r0, [r1, #4]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

void WaterSurface__ReleaseCommon(void)
{
    OS_CancelVAlarm(&waterSurfaceWork->vAlarm[0]);
    OS_CancelVAlarm(&waterSurfaceWork->vAlarm[1]);

    for (u32 i = 0; i < 2; i++)
	{
        WaterSurface__CopyPalette(i);
	}

    if ((waterSurfaceWork->flags & 8) != 0)
    {
        AnimatorSprite__Release(&waterSurfaceWork->aniWaterSurface1[0]);
        AnimatorSprite__Release(&waterSurfaceWork->aniWaterSurface1[1]);
        ObjDrawReleaseSprite(33);
    }
}

NONMATCH_FUNC void WaterSurface__Func_200DF78(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r0, =waterSurfaceWork
	ldr r1, [r0]
	ldr r0, [r1]
	tst r0, #8
	beq _0200DFC0
	add r0, r1, #0x104
	mov r1, #0
	mov r2, r1
	add r0, r0, #0x800
	bl AnimatorSprite__ProcessAnimation
	ldr r0, =waterSurfaceWork
	mov r1, #0
	ldr r0, [r0]
	mov r2, r1
	add r0, r0, #0x168
	add r0, r0, #0x800
	bl AnimatorSprite__ProcessAnimation
_0200DFC0:
	mov r5, #0
	ldr r7, =mapCamera
	mov r8, r5
_0200DFCC:
	ldr r0, [r7]
	tst r0, #0x2000000
	bne _0200E084
	tst r0, #0x1000000
	beq _0200E084
	ldr r4, =waterSurfaceWork
	ldr r3, [r4]
	ldr r0, [r3]
	tst r0, #8
	beq _0200E084
	ldr r1, [r7, #0x28]
	mov r0, #0xc0
	mul r0, r1, r0
	ldrh r2, [r7, #0x6e]
	ldr r1, [r7, #8]
	rsb r2, r1, r2, lsl #12
	cmp r0, r2
	ble _0200E084
	cmp r2, #0
	blt _0200E084
	ldr r0, [r7, #4]
	add r1, r3, r8
	mov r0, r0, asr #0xc
	and r0, r0, #0x3f
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r6, r0, asr #0x10
	mov r2, r2, asr #0xc
	add r0, r1, #0x900
	strh r2, [r0, #0xe]
	cmp r6, #0x100
	bge _0200E084
_0200E04C:
	ldr r0, [r4]
	add r0, r8, r0
	add r0, r0, #0x900
	strh r6, [r0, #0xc]
	ldr r0, [r4]
	add r0, r0, #0x104
	add r0, r0, #0x800
	add r0, r0, r8
	bl AnimatorSprite__DrawFrame
	add r0, r6, #0x40
	mov r0, r0, lsl #0x10
	mov r6, r0, asr #0x10
	cmp r6, #0x100
	blt _0200E04C
_0200E084:
	add r5, r5, #1
	cmp r5, #2
	add r7, r7, #0x70
	add r8, r8, #0x64
	blt _0200DFCC
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterSurface__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r6, #0x10
	mov r7, #0
	ldr r9, =mapCamera
	ldr r4, =waterSurfaceWork
	mov r10, r7
	mov r11, r6
	mov r5, r6
_0200E0C4:
	ldr r0, [r4]
	add r0, r0, #0x810
	add r0, r0, r10
	bl OS_CancelVAlarm
	ldr r0, [r9]
	tst r0, #0x2000000
	bne _0200E210
	tst r0, #0x1000000
	beq _0200E210
	ldr r1, [r9, #0x28]
	mov r0, #0xc0
	mul r2, r1, r0
	ldrh r3, [r9, #0x6e]
	ldr r0, [r9, #8]
	rsb r0, r0, r3, lsl #12
	cmp r2, r0
	bge _0200E13C
	ldr r0, [r4]
	ldr r0, [r0]
	tst r0, r6, lsl r7
	beq _0200E120
	tst r0, #0x40
	beq _0200E248
_0200E120:
	mov r0, r7
	bl WaterSurface__CopyPalette
	ldr r1, [r4]
	ldr r0, [r1]
	orr r0, r0, r6, lsl r7
	str r0, [r1]
	b _0200E248
_0200E13C:
	cmp r0, r1, lsl #2
	ble _0200E1B0
	bl FX_Div
	ldr r1, [r4]
	mov r8, r0, asr #0xc
	add r0, r1, r7, lsl #1
	strh r8, [r0, #0xc]
	ldr r0, [r4]
	ldr r0, [r0]
	tst r0, r11, lsl r7
	beq _0200E170
	tst r0, #0x40
	beq _0200E188
_0200E170:
	mov r0, r7
	bl WaterSurface__CopyPalette
	ldr r1, [r4]
	ldr r0, [r1]
	orr r0, r0, r11, lsl r7
	str r0, [r1]
_0200E188:
	str r7, [sp]
	ldr r0, [r4]
	mov r1, r8, lsl #0x10
	add r0, r0, #0x810
	ldr r3, =WaterSurface__VAlarmCB_200E26C
	mov r2, #7
	add r0, r0, r10
	mov r1, r1, asr #0x10
	bl OS_SetVAlarm
	b _0200E248
_0200E1B0:
	ldr r1, [r4]
	ldr r8, [r1]
	tst r8, r5, lsl r7
	bne _0200E1CC
	tst r8, #0x40
	biceq r0, r8, #6
	streq r0, [r1]
_0200E1CC:
	mov r0, r7
	bl WaterSurface__CopyAltPalette
	ldr r2, [r4]
	mvn r0, r5, lsl r7
	ldr r1, [r2]
	and r0, r1, r0
	str r0, [r2]
	ldr r2, [r4]
	ldr r1, [r2]
	tst r1, r5, lsl r7
	bne _0200E248
	tst r1, #0x40
	bne _0200E248
	and r0, r8, #6
	orr r0, r1, r0
	str r0, [r2]
	b _0200E248
_0200E210:
	ldr r0, [r4]
	ldr r1, [r0]
	mov r0, #0x10
	tst r1, r0, lsl r7
	beq _0200E22C
	tst r1, #0x40
	beq _0200E248
_0200E22C:
	mov r0, r7
	bl WaterSurface__CopyPalette
	ldr r2, [r4]
	mov r0, #0x10
	ldr r1, [r2]
	orr r0, r1, r0, lsl r7
	str r0, [r2]
_0200E248:
	add r7, r7, #1
	cmp r7, #2
	add r9, r9, #0x70
	add r10, r10, #0x28
	blo _0200E0C4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void WaterSurface__VAlarmCB_200E26C(void *useEngineB)
{
    WaterSurface__CopyAltPalette(VOID_TO_INT(useEngineB));
    waterSurfaceWork->flags &= ~(16 << VOID_TO_INT(useEngineB));

    OS_SetVAlarm(&waterSurfaceWork->vAlarm[VOID_TO_INT(useEngineB)], 200, 7, WaterSurface__VAlarmCB_200E2CC, INT_TO_VOID(useEngineB));
}

void WaterSurface__VAlarmCB_200E2CC(void *useEngineB)
{
    WaterSurface__CopyPalette(VOID_TO_INT(useEngineB));
    waterSurfaceWork->flags |= (16 << VOID_TO_INT(useEngineB));

    OS_SetVAlarm(&waterSurfaceWork->vAlarm[VOID_TO_INT(useEngineB)], waterSurfaceWork->vAlarmCount[VOID_TO_INT(useEngineB)], 7, WaterSurface__VAlarmCB_200E26C,
                 INT_TO_VOID(useEngineB));
}

NONMATCH_FUNC void WaterSurface__InitPalette(u16 *palettePtr, u32 count){
#ifdef NON_MATCHING

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

NONMATCH_FUNC void WaterSurface__CopyPalette(BOOL useEngineB){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =waterSurfaceWork
	mov r5, r0
	ldr r0, [r1]
	mov r1, #0x400
	add r0, r0, #0x10
	bl DC_StoreRange
	ldr r0, =objDrawPalette2
	mov r1, #0x200
	bl DC_StoreRange
	bl DC_WaitWriteBufferEmpty
	ldr r0, =waterSurfaceWork
	ldr r0, [r0]
	ldr r0, [r0]
	tst r0, #4
	beq _0200E488
	cmp r5, #0
	beq _0200E438
	bl GX_ResetBankForSubBGExtPltt
	ldr r1, =waterSurfaceWork
	ldr r2, =0x0213A164
	ldr r3, [r1]
	ldr r1, [r2, r5, lsl #4]
	ldrh r2, [r3, #0xa]
	mov r4, r0
	add r0, r3, #0x210
	mov r2, r2, lsl #1
	bl RenderCore_DMACopy
	ldr r0, =waterSurfaceWork
	ldr r1, =0x0213A168
	ldr r0, [r0]
	ldr r1, [r1, r5, lsl #4]
	ldrh r2, [r0, #0xa]
	add r0, r0, #0x210
	mov r2, r2, lsl #1
	bl RenderCore_DMACopy
	mov r0, r4
	bl GX_SetBankForSubBGExtPltt
	b _0200E488
_0200E438:
	bl GX_ResetBankForBGExtPltt
	ldr r1, =waterSurfaceWork
	ldr r2, =0x0213A164
	ldr r3, [r1]
	ldr r1, [r2, r5, lsl #4]
	ldrh r2, [r3, #0xa]
	mov r4, r0
	add r0, r3, #0x210
	mov r2, r2, lsl #1
	bl RenderCore_DMACopy
	ldr r0, =waterSurfaceWork
	ldr r1, =0x0213A168
	ldr r0, [r0]
	ldr r1, [r1, r5, lsl #4]
	ldrh r2, [r0, #0xa]
	add r0, r0, #0x210
	mov r2, r2, lsl #1
	bl RenderCore_DMACopy
	mov r0, r4
	bl GX_SetBankForBGExtPltt
_0200E488:
	ldr r0, =waterSurfaceWork
	ldr r3, [r0]
	ldr r0, [r3]
	tst r0, #2
	beq _0200E4B4
	ldrh r2, [r3, #8]
	ldr r1, =_02118C48
	add r0, r3, #0x10
	ldr r1, [r1, r5, lsl #2]
	mov r2, r2, lsl #1
	bl RenderCore_DMACopy
_0200E4B4:
	ldr r0, =waterSurfaceWork
	ldr r0, [r0]
	ldr r0, [r0]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, =_02118C40
	ldr r2, =objDrawPalette2
	ldr r1, [r0, r5, lsl #2]
	add r0, r2, #0x60
	add r1, r1, #0x60
	mov r2, #0x1a0
	bl RenderCore_DMACopy
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WaterSurface__CopyAltPalette(BOOL useEngineB)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =waterSurfaceWork
	mov r5, r0
	ldr r0, [r1]
	mov r1, #0x400
	add r0, r0, #0x410
	bl DC_StoreRange
	bl DC_WaitWriteBufferEmpty
	ldr r0, =objDrawPalette1
	mov r1, #0x200
	bl DC_StoreRange
	ldr r0, =waterSurfaceWork
	ldr r0, [r0]
	ldr r0, [r0]
	tst r0, #4
	beq _0200E5EC
	cmp r5, #0
	beq _0200E59C
	bl GX_ResetBankForSubBGExtPltt
	ldr r1, =waterSurfaceWork
	ldr r2, =0x0213A164
	ldr r3, [r1]
	ldr r1, [r2, r5, lsl #4]
	ldrh r2, [r3, #0xa]
	mov r4, r0
	add r0, r3, #0x610
	mov r2, r2, lsl #1
	bl RenderCore_DMACopy
	ldr r0, =waterSurfaceWork
	ldr r1, =0x0213A168
	ldr r0, [r0]
	ldr r1, [r1, r5, lsl #4]
	ldrh r2, [r0, #0xa]
	add r0, r0, #0x610
	mov r2, r2, lsl #1
	bl RenderCore_DMACopy
	mov r0, r4
	bl GX_SetBankForSubBGExtPltt
	b _0200E5EC
_0200E59C:
	bl GX_ResetBankForBGExtPltt
	ldr r1, =waterSurfaceWork
	ldr r2, =0x0213A164
	ldr r3, [r1]
	ldr r1, [r2, r5, lsl #4]
	ldrh r2, [r3, #0xa]
	mov r4, r0
	add r0, r3, #0x610
	mov r2, r2, lsl #1
	bl RenderCore_DMACopy
	ldr r0, =waterSurfaceWork
	ldr r1, =0x0213A168
	ldr r0, [r0]
	ldr r1, [r1, r5, lsl #4]
	ldrh r2, [r0, #0xa]
	add r0, r0, #0x610
	mov r2, r2, lsl #1
	bl RenderCore_DMACopy
	mov r0, r4
	bl GX_SetBankForBGExtPltt
_0200E5EC:
	ldr r0, =waterSurfaceWork
	ldr r3, [r0]
	ldr r0, [r3]
	tst r0, #2
	beq _0200E618
	ldrh r2, [r3, #8]
	ldr r1, =_02118C50
	add r0, r3, #0x410
	ldr r1, [r1, r5, lsl #2]
	mov r2, r2, lsl #1
	bl RenderCore_DMACopy
_0200E618:
	ldr r0, =waterSurfaceWork
	ldr r0, [r0]
	ldr r0, [r0]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	bl DC_WaitWriteBufferEmpty
	ldr r0, =_02118C58
	ldr r2, =objDrawPalette1
	ldr r1, [r0, r5, lsl #2]
	add r0, r2, #0x60
	add r1, r1, #0x60
	mov r2, #0x1a0
	bl RenderCore_DMACopy
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}
