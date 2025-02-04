#ifndef RUSH_RENDERCORE_H
#define RUSH_RENDERCORE_H

#include <global.h>
#include <game/math/mtMath.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define RENDERCORE_BRIGHTNESS_DEFAULT (0)
#define RENDERCORE_BRIGHTNESS_WHITE   (16)
#define RENDERCORE_BRIGHTNESS_BLACK   (-16)

#define PM_LCD_INVALID ((PMLCDTarget) - 1)

#define RENDERCORE_RESETPARAM_FLAG 0x80000000

#define HW_LCD_CENTER_X (HW_LCD_WIDTH / 2)
#define HW_LCD_CENTER_Y (HW_LCD_HEIGHT / 2)

// --------------------
// ENUMS
// --------------------

enum RenderCoreFlags_
{
    RENDERCORE_FLAG_NONE                 = 0,
    RENDERCORE_FLAG_DISABLE_SOFT_RESET   = 1 << 0,
    RENDERCORE_FLAG_DISABLE_SWAP_BUFFERS = 1 << 1,
    RENDERCORE_FLAG_DISABLE_OAM_RESET    = 1 << 2,
    RENDERCORE_FLAG_UPDATE_WINDOW_PLANE  = 1 << 3,
};
typedef s32 RenderCoreFlags;

enum DMAControlFlags_
{
    DMACONTROL_FLAG_NONE                  = 0,
    DMACONTROL_FLAG_DISABLE_VBLANK_UPDATE = 1 << 0,
    DMACONTROL_FLAG_SWAP_BUFFER           = 1 << 1,
    DMACONTROL_FLAG_ENABLE_SWAP_BUFFER    = 1 << 2,
};
typedef u16 DMAControlFlags;

enum SwapBufferFlags_
{
    SWAPBUFFER_FLAG_NONE                  = 0,
    SWAPBUFFER_FLAG_LINE_BUFFER_UNDERFLOW = 1 << 0,
    SWAPBUFFER_FLAG_LIST_RAM_OVERFLOW     = 1 << 1,
    SWAPBUFFER_FLAG_MTX_STACK_OVERFLOW    = 1 << 2,
};
typedef u32 SwapBufferFlags;

enum OverlayControlFlags_
{
    OVERLAYCONTROL_FLAG_NONE           = 0,
    OVERLAYCONTROL_FLAG_OVERLAY_LOADED = 1 << 0,
};
typedef u32 OverlayControlFlags;

enum FoldDeviceMode_
{
    FOLD_TOGGLE_SLEEP,     // - closing the system toggles sleep mode
    FOLD_TOGGLE_POWER,     // - closing the system toggles the lcd display (on/off)
    FOLD_TOGGLE_BACKLIGHT, // - closing the system toggles lcd backlight (on/off)
};
typedef s32 FoldDeviceMode;

// copied from G2_BLENDTYPE, since rush uses these values directly
typedef enum
{
    BLENDTYPE_NONE,
    BLENDTYPE_ALPHA,
    BLENDTYPE_FADEIN,
    BLENDTYPE_FADEOUT
} RenderCoreBlendType;

// extra enum for when 'effect' value is needed for bitwise math
enum
{
    GX_PLANEMASK_EFFECT = (1 << 5)
};

// --------------------
// STRUCTS
// --------------------

typedef struct FoldDeviceControl_
{
    FoldDeviceMode nextMode;
    FoldDeviceMode mode;
    BOOL isFolded;
    PMLCDTarget target;
} FoldDeviceControl;

typedef struct SwapBufferControl_
{
    SwapBufferFlags flags;
    GXSortMode sortMode;
    GXBufferMode bufferMode;
} SwapBufferControl;

typedef struct OverlayControl_
{
    OverlayControlFlags flags;
    u32 prevID;
    u32 nextID;
    void (*onOverlayChanged)(void);
} OverlayControl;

typedef struct DMAController_
{
    const void *dmaDest;
    const void *dmaSrc[2];
    u32 size;
    u16 bufferID;
    DMAControlFlags flags;
} DMAController;

typedef struct WindowPlaneManagerRegisters_
{
    u8 win0X2;
    u8 win0X1;
    u8 win1X2;
    u8 win1X1;

    u8 win0Y2;
    u8 win0Y1;
    u8 win1Y2;
    u8 win1Y1;

    union
    {
        struct
        {
            u8 plane_BG0 : 1;
            u8 plane_BG1 : 1;
            u8 plane_BG2 : 1;
            u8 plane_BG3 : 1;
            u8 plane_OBJ : 1;

            u8 effect : 1; // See 'RenderCoreBlendType' for types
        };

        struct
        {
            u8 plane : 5;
        };

        u8 value;
    } win0InPlane;

    union
    {
        struct
        {
            u8 plane_BG0 : 1;
            u8 plane_BG1 : 1;
            u8 plane_BG2 : 1;
            u8 plane_BG3 : 1;
            u8 plane_OBJ : 1;

            u8 effect : 1; // See 'RenderCoreBlendType' for types
        };

        struct
        {
            u8 plane : 5;
        };

        u8 value;
    } win1InPlane;

    union
    {
        struct
        {
            u8 plane_BG0 : 1;
            u8 plane_BG1 : 1;
            u8 plane_BG2 : 1;
            u8 plane_BG3 : 1;
            u8 plane_OBJ : 1;

            u8 effect : 1; // See 'RenderCoreBlendType' for types
        };

        struct
        {
            u8 plane : 5;
        };

        u8 value;
    } winOutPlane;

    union
    {
        struct
        {
            u8 plane_BG0 : 1;
            u8 plane_BG1 : 1;
            u8 plane_BG2 : 1;
            u8 plane_BG3 : 1;
            u8 plane_OBJ : 1;

            u8 effect : 1; // See 'RenderCoreBlendType' for types
        };

        struct
        {
            u8 plane : 5;
        };

        u8 value;
    } winOBJOutPlane;

} WindowPlaneManagerRegisters;

typedef struct WindowPlaneManager_
{
    WindowPlaneManagerRegisters registers;

    s32 visible;
} WindowPlaneManager;

typedef struct BlendController_
{

    union
    {
        struct
        {
            u16 plane1_BG0 : 1;
            u16 plane1_BG1 : 1;
            u16 plane1_BG2 : 1;
            u16 plane1_BG3 : 1;
            u16 plane1_OBJ : 1;
            u16 plane1_Backdrop : 1;

            u16 effect : 2; // See 'RenderCoreBlendType' for types

            u16 plane2_BG0 : 1;
            u16 plane2_BG1 : 1;
            u16 plane2_BG2 : 1;
            u16 plane2_BG3 : 1;
            u16 plane2_OBJ : 1;
            u16 plane2_Backdrop : 1;
        };

        struct
        {
            u16 plane1 : 6;
            u16 __unused_effect : 2; // use 'effect' from the above bitfield
            u16 plane2 : 6;
        };

        u16 value;
    } blendControl;

    union
    {
        struct
        {
            u16 ev1 : 5;
            u16 __unused : 3;
            u16 ev2 : 5;
        };

        u16 value;
    } blendAlpha;

    union
    {
        struct
        {
            u16 value5 : 5;
        };

        u16 value;
    } coefficient;

} BlendController;

typedef struct RenderAffineControl_
{
    MtxFx22 matrix;
    s16 centerX;
    s16 centerY;
    s16 x;
    s16 y;
} RenderAffineControl;

typedef struct RenderCoreGFXControl_
{
    Vec2U16 bgPosition[4];
    WindowPlaneManager windowManager;
    BlendController blendManager;
    RenderAffineControl affineA;
    RenderAffineControl affineB;
    s16 brightness;
    u16 mosaicSize;
} RenderCoreGFXControl;

// --------------------
// VARIABLES
// --------------------

extern GXDispSelect renderCurrentDisplay;
extern s32 renderDmaNo;

extern SwapBufferControl renderCoreSwapBuffer;
extern RenderCoreGFXControl renderCoreGFXControlB;
extern RenderCoreGFXControl renderCoreGFXControlA;

extern RenderCoreGFXControl *const VRAMSystem__GFXControl[2];

extern const u32 VRAMSystem__VRAM_PALETTE_BG[2];
extern const u32 VRAMSystem__VRAM_PALETTE_OBJ[2];

extern const u32 VRAMSystem__DisplayControllers[2];

extern const void *VRAMSystem__VRAM_BG[2];
extern const void *VRAMSystem__VRAM_OBJ[2];

extern const void *VRAMSystem__BGControllers[2][4];

// --------------------
// FUNCTIONS
// --------------------

// Game
void InitGameSystems(u32 dmaNo, u32 defaultDMA, s32 main1HeapSize, s32 main2HeapSize, s32 itcmHeapSize, s32 dtcmHeapSize, s32 audioHeapSize, s32 fsHeapSize);
void UpdateGameLoop(void);

// RenderCore
void UpdateDrawLoop(void);
u32 RenderCore_GetTargetVBlankCount(void);
void RenderCore_SetTargetVBlankCount(u32 target);
void RenderCore_WaitVBlank(void);
void RenderCore_SetVBlankCallback(void (*callback)(void));
void RenderCore_PerformSoftReset(void);
u32 RenderCore_GetResetParam(void);
void RenderCore_CPUCopy(void *input, void *output, u32 length);
void RenderCore_DMACopy(const void *srcPixels, void *dstPixels, u32 srcSize);
void RenderCore_CPUCopyCompressed(void *input, void *output);
void RenderCore_ChangeOverlay(int overlayID, void (*changeCB)(void));
void RenderCore_PrepareDMA(u32 id, void *src2, void *src1, void *dst, u32 size);
void RenderCore_StopDMA(u32 id);
void RenderCore_PrepareDMASwapBuffer(u32 id);
void *RenderCore_GetDMASrc(u32 id);
FoldDeviceMode RenderCore_GetNextFoldMode(void);
void RenderCore_SetNextFoldMode(FoldDeviceMode mode);
void RenderCore_HandleDeviceFold(void);
const u8 *RenderCore_GetLanguagePtr(void);
u32 RenderCore_GetDMARenderCount(void);
void RenderCore_DisableSoftReset(BOOL enabled);
u32 RenderCore_GetSoftResetDisabled(void);
void RenderCore_DisableSwapBuffers(BOOL enabled);
void RenderCore_DisableOAMReset(BOOL enabled);
void RenderCore_DisableWindowPlaneUpdate(BOOL enabled);
void RenderCore_SetWnd0InsidePlane(WindowPlaneManager *window, /*GXWndPlaneMask*/ u32 plane, BOOL effect);
void RenderCore_SetWnd1InsidePlane(WindowPlaneManager *window, /*GXWndPlaneMask*/ u32 plane, BOOL effect);
void RenderCore_SetWndOutsidePlane(WindowPlaneManager *window, /*GXWndPlaneMask*/ u32 plane, BOOL effect);
void RenderCore_SetWndOBJOutsidePlane(WindowPlaneManager *window, /*GXWndPlaneMask*/ u32 plane, BOOL effect);
void RenderCore_SetWindow0Position(WindowPlaneManager *window, u32 x1, u32 y1, u32 x2, u32 y2);
void RenderCore_SetWindow1Position(WindowPlaneManager *window, u32 x1, u32 y1, u32 x2, u32 y2);
void RenderCore_DisableBlending(BlendController *manager);
void RenderCore_SetBlendBrightness(u32 addr, int plane, int brightness);
void RenderCore_SetBlendBrightnessExt(u32 addr, int plane1, int plane2, int ev1, int ev2, int brightness);
void RenderCore_ChangeBlendAlpha(BlendController *manager, s32 ev1, s32 ev2);
void RenderCore_ChangeBlendBrightness(u32 addr, int brightness);
void RenderCore_StopAllDMAs(void);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE OSLanguage GetGameLanguage(void)
{
    switch (*RenderCore_GetLanguagePtr())
    {
        case OS_LANGUAGE_JAPANESE:
        case OS_LANGUAGE_ENGLISH:
        case OS_LANGUAGE_FRENCH:
        case OS_LANGUAGE_GERMAN:
        case OS_LANGUAGE_ITALIAN:
        case OS_LANGUAGE_SPANISH:
            return (OSLanguage)*RenderCore_GetLanguagePtr();

        default:
            return DEFAULT_LANGUAGE;
    }
}

// --------------------
// DEBUG FUNCTIONS
// --------------------

#ifdef GDB_DEBUGGING
// describes a single overlay entry, which GDB can inspect to determine which overlays are loaded.
typedef struct
{
    unsigned long vma;
    unsigned long size;
    FSOverlayID id;
    unsigned long mapped;
} struct_overlayTable;

// this is set based on the current number of overlays, other projects might need more!
#define MAX_OVERLAYS 16

// externs required for GDB to access overlay state
extern unsigned long _novlys;
extern struct_overlayTable _ovly_table[MAX_OVERLAYS];

// event callback which GDB will hook and use to refresh overlay state
static void _ovly_debug_event(void);
#endif // GDB_DEBUGGING

#ifdef __cplusplus
}
#endif

#endif // RUSH_RENDERCORE_H
