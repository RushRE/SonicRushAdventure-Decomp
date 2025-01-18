#ifndef RUSH_DRAWREQTASK_H
#define RUSH_DRAWREQTASK_H

#include <game/system/task.h>
#include <game/graphics/renderCore.h>

// --------------------
// STRUCTS
// --------------------

typedef struct CameraConfig_
{
    u16 projFOV;
    u32 projNear;
    u32 projFar;
    u32 aspectRatio;
    u32 projScaleW;
    VecFx32 matProjPosition;
} CameraConfig;

typedef struct Camera3D_
{
    CameraConfig config;
    VecFx32 lookAtTo;
    VecFx32 lookAtFrom;
    VecFx32 lookAtUp;
    VecFx32 position;
} Camera3D;

typedef struct DirLight_
{
    VecFx16 dir;
    u16 color;
} DirLight;

typedef struct Camera3DTask_
{
    RenderCoreGFXControl gfxControl[2];
    GXOamAttr oam[2][128];
    u16 oamAffineOffset[2];
    u16 oamCount[2];
} Camera3DTask;

typedef struct DrawReqTask_
{
    BOOL enabled;
    s32 field_4;
    u32 screenCanDraw[2];
    GXOamAttr oam[2][128];
    u16 oamAffineOffset[2];
} DrawReqTask;

typedef struct AssetSetupTask_
{
    void *resource;
} AssetSetupTask;

// --------------------
// FUNCTIONS
// --------------------

// DrawReqTask
void InitDrawReqSystem(void);
void GetVRAMPaletteConfig(BOOL useEngineB, u8 bgID, u32 *paletteMode, void **palettePtr);
void GetVRAMCharacterConfig(BOOL useEngineB, u8 bgID, u16 *characterBaseA, u16 *characterBaseBlock);
void GetVRAMTileConfig(BOOL useEngineB, u8 bgID, s32 *mappingsMode, u16 *screenBaseA, u16 *screenBaseBlock);
void GetVRAMPixelConfig(BOOL useEngineB, u8 bgID, u32 *pixelMode, u16 *screenBaseBlock);
void DrawReqTask__Create(u8 pausePriority, BOOL canDrawA, BOOL canDrawB, BOOL createPauseDrawControl);
void DrawReqTask__Enable(void);
BOOL DrawReqTask__GetEnabled(void);

// Camera3D
void Camera3D__Create(void);
void Camera3D__Destroy(void);
Task *Camera3D__GetTask(void);
BOOL Camera3D__UseEngineA(void);
Camera3DTask *Camera3D__GetWork(void);
void Camera3D__LoadState(Camera3D *camera);
void Camera3D__SetLight(GXLightId lightID, DirLight *light);
void Camera3D__SetMatrixMode(void);
void Camera3D__FlushP(void);
void Camera3D__FlushVP(void);
void Camera3D__FlushWVP(void);
void Camera3D__CopyMatrix4x3(const MtxFx43 *src, MtxFx43 *dst);
void Camera3D__CopyMatrix3x3(const MtxFx33 *src, MtxFx33 *dst);

// Asset3DSetup
u32 Asset3DSetup__GetTexSize(void *resource);
void Asset3DSetup__GetTexture(void *resource, void *dest);
void Asset3DSetup__Create(void *resource);
u32 Asset3DSetup__GetTexPaletteLocation(void *texture, u32 id);
u32 Asset3DSetup__PaletteFromName(const NNSG3dResTex *texture, const char *name);

// DrawReqTask (Part 2)
void DrawReqTask__Main(void);
void DrawReqTask__Main_207FB88(void);
void DrawReqTask__Func_207FC10(BOOL useEngineB);

// SysPauseDrawControl
void SysPauseDrawControl__Create(BOOL enabled);
void SysPauseDrawControl__Main(void);

// Asset3DSetup
void Asset3DSetup__Main(void);

// Camera3D (Part 2)
void Camera3D__Main(void);
void Camera3D__ProcessOAMList(void);
void Camera3D__VBlankCallback(void);
void Camera3D__InitMode1(void);
void Camera3D__InitMode2(void);

#endif // RUSH_DRAWREQTASK_H
