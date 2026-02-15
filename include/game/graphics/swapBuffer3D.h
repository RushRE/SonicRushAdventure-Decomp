#ifndef RUSH_SWAPBUFFER3D_H
#define RUSH_SWAPBUFFER3D_H

#include <game/system/task.h>
#include <game/graphics/renderCore.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

enum SwapBuffer3DPrimaryEngine_
{
    SWAPBUFFER3D_PRIMARY_BOTTOM,
    SWAPBUFFER3D_PRIMARY_TOP,
};
typedef u32 SwapBuffer3DPrimaryScreen;

// --------------------
// STRUCTS
// --------------------

typedef struct ProjectionDisplayConfig_
{
    u16 fov;
    u32 nearPlane;
    u32 farPlane;
    u32 aspectRatio;
    u32 scaleW;
    VecFx32 position;
} ProjectionDisplayConfig;

typedef struct ViewDisplayConfig_
{
    VecFx32 camPos;
    VecFx32 camTarget;
    VecFx32 camUp;
    VecFx32 position;
} ViewDisplayConfig;

typedef struct Camera3D_
{
    ProjectionDisplayConfig projection;
    ViewDisplayConfig view;
} Camera3D;

typedef struct DirLight_
{
    VecFx16 dir;
    u16 color;
} DirLight;

typedef struct SwapBuffer3D_
{
    RenderCoreGFXControl gfxControl[2];
    GXOamAttr oam[2][128];
    u16 oamAffineOffset[2];
    u16 oamCount[2];
} SwapBuffer3D;

typedef struct SysPause_
{
    BOOL isFinished;
    BOOL isActive;
    BOOL engineActive[2];
    GXOamAttr oam[2][128];
    u16 oamAffineOffset[2];
} SysPause;

typedef struct AssetSetupTask_
{
    void *resource;
} AssetSetupTask;

// --------------------
// FUNCTIONS
// --------------------

// SysPause
void InitDrawReqSystem(void);
void GetVRAMPaletteConfig(BOOL useEngineB, u8 bgID, u32 *paletteMode, void **palettePtr);
void GetVRAMCharacterConfig(BOOL useEngineB, u8 bgID, u16 *characterBaseA, u16 *characterBaseBlock);
void GetVRAMTileConfig(BOOL useEngineB, u8 bgID, s32 *mappingsMode, u16 *screenBaseA, u16 *screenBaseBlock);
void GetVRAMPixelConfig(BOOL useEngineB, u8 bgID, u32 *pixelMode, u16 *screenBaseBlock);
void BeginSysPause(u8 pauseLevel, BOOL engineActiveA, BOOL engineActiveB, BOOL disableSwapBuffers);
void EndSysPause(void);
BOOL SysPause_IsActive(void);

// SwapBuffer3D
void CreateSwapBuffer3D(void);
void DestroySwapBuffer3D(void);
Task *GetSwapBuffer3DTask(void);
SwapBuffer3DPrimaryScreen SwapBuffer3D_GetPrimaryScreen(void);
SwapBuffer3D *GetSwapBuffer3DWork(void);
void SwapBuffer3D_ApplyCameraState(Camera3D *camera);
void SwapBuffer3D_SetLight(GXLightId lightID, DirLight *light);
void SwapBuffer3D_Op_Init(void);
void SwapBuffer3D_Op_FlushP(void);
void SwapBuffer3D_Op_FlushVP(void);
void SwapBuffer3D_Op_FlushWVP(void);
void SwapBuffer3D_CopyMatrix_Standard(const FXMatrix43 *src, FXMatrix33 *dst);
void SwapBuffer3D_CopyMatrix_Billboard(const FXMatrix43 *src, FXMatrix33 *dst);

// Asset3DSetup
u32 Asset3DSetup_GetResourceSize(void *resource);
void Asset3DSetup_CopyResourceData(void *resource, void *dest);
void CreateAsset3DSetup(void *resource);
u32 Asset3DSetup_GetPaletteFromIndex(const NNSG3dResTex *texture, u32 id);
u32 Asset3DSetup_GetPaletteFromName(const NNSG3dResTex *texture, const char *name);

#ifdef __cplusplus
}
#endif

#endif // RUSH_SWAPBUFFER3D_H
