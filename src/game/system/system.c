#include <game/system/system.h>
#include <game/system/allocator.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/drawState.h>
#include <game/file/binaryBundle.h>
#include <game/graphics/background.h>
#include <game/graphics/sprite.h>
#include <game/graphics/renderCore.h>
#include <game/audio/spatialAudio.h>
#include <game/unknown/unknown2085404.h>
#include <game/file/fsRequest.h>
#include <game/math/cppMath.hpp>

// --------------------
// VARIABLES
// --------------------

u32 systemFrameCounter;
static u8 unknownArray[8];

// --------------------
// FUNCTIONS
// --------------------

void InitSystems(void)
{
    // constants
    const u32 DMA_NO = 3;

    // Init OS
    OS_Init();
    OS_InitThread();
    OS_InitTick();
    OS_InitAlarm();
    OS_InitVAlarm();
    RTC_Init();

    // Init Graphics & Input
    FX_Init();
    GX_InitEx(DMA_NO);
    G3X_Init();
    TP_Init();
    NNS_G3dInit();
    NNS_G3dGlbInit();

    // Init Game
    InitGameSystems(DMA_NO, FS_DMA_NOT_USE, ALLOCATOR_SYSTEM_HEAP_SIZE, ALLOCATOR_USER_HEAP_SIZE, ALLOCATOR_ITCM_HEAP_SIZE, ALLOCATOR_DTCM_HEAP_SIZE, AUDIOMANAGER_HEAP_SIZE,
                    FSREQ_HEAP_SIZE);
    InitSpriteSystem();
    InitBackgroundSystem();
    InitBinaryBundleSystem();
    InitDrawStateSystem();
    InitUnknown2085404System();
    InitPaletteAnimationSystem();
    InitSpatialAudioSystem();
    InitUnknown2085D08System();
    ReleaseAudioSystem();
    ReleaseAudioSystem();
    ReleaseAudioSystem();
    ReleaseAudioSystem();
    MI_CpuClear16(unknownArray, sizeof(unknownArray));
    PM_SetAmp(PM_AMP_OFF);

    // Init 3D state
    G3X_SetShading(GX_SHADING_TOON);
    G3X_AntiAlias(TRUE);
    G3X_AlphaTest(FALSE, 0);
    G3X_AlphaBlend(TRUE);
    G3X_EdgeMarking(FALSE);
    MI_CpuClear16(&reg_G3X_EDGE_COLOR_0_L, 16);

    G3X_SetClearColor(GX_RGB_888(0x00, 0x00, 0x00), GX_COLOR_FROM_888(0x00), 0x7FFF, 0, FALSE);
    G3_ViewPort(0, 0, HW_LCD_WIDTH - 1, HW_LCD_HEIGHT - 1);
    GX_SetPower(GX_POWER_2D_MAIN | GX_POWER_2D_SUB);
    GX_DispOn();
    GXS_DispOn();
}

void *GetSystemUnknown(void)
{
    return unknownArray;
}

void ResetRenderAffine(void)
{
    for (s32 i = 0; i < 2; i++)
    {
        RenderCoreGFXControl *control = VRAMSystem__GFXControl[i];
        MI_CpuClear16(control, sizeof(RenderCoreGFXControl));

        MTX_Identity22(&control->affineA.matrix);
        control->affineA.centerX = control->affineA.centerY = 0;
        control->affineA.x = control->affineA.y = 0;

        MTX_Identity22(&control->affineB.matrix);
        control->affineB.centerX = control->affineB.centerY = 0;
        control->affineB.x = control->affineB.y = 0;
    }
}

u32 GetSystemFrameCounter(void)
{
    return systemFrameCounter;
}

void UnknownSystemHandler(void)
{
    // Nothin'
}