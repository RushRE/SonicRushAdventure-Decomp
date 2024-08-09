#include <game/graphics/drawState.h>
#include <game/graphics/renderCore.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void DrawState_SetupLookAtMatrix(DrawState *state);
static void DrawState_SetupProjectionMatrix(DrawState *state);
static void DrawState_SetupSwapBufferMode(DrawState *state);
static void DrawState_SetupLight0(DrawState *state);
static void DrawState_SetupLight1(DrawState *state);
static void DrawState_SetupLight2(DrawState *state);
static void DrawState_SetupLight3(DrawState *state);
static void DrawState_SetupShininessTable(DrawState *state);
static void DrawState_SetupShadingStyle(DrawState *state);
static void DrawState_SetupToonTable(DrawState *state);
static void DrawState_SetupAlphaTest(DrawState *state);
static void DrawState_SetupAlphaBlend(DrawState *state);
static void DrawState_SetupSwapSortMode(DrawState *state);
static void DrawState_SetupFogOffset(DrawState *state);
static void DrawState_SetupFogColor(DrawState *state);
static void DrawState_SetupFogTable(DrawState *state);
static void DrawState_SetupEdgeMarking(DrawState *state);
static void DrawState_SetupEdgeColorTable(DrawState *state);
static void DrawState_SetupAntiAliasing(DrawState *state);
static void DrawState_SetupDisplay1DotDepth(DrawState *state);
static void DrawState_SetupClearColor(DrawState *state);

// --------------------
// VARIABLES
// --------------------

typedef void (*DrawStateFunc)(DrawState *state);

DrawStateFunc DrawStateSystemSetupTable[] = {
    DrawState_SetupLookAtMatrix,     // DRAWSTATE_LOOKAT
    DrawState_SetupProjectionMatrix, // DRAWSTATE_PROJECTION
    DrawState_SetupSwapBufferMode,   // DRAWSTATE_SWAPBUFFERMODE
    DrawState_SetupLight0,           // DRAWSTATE_LIGHT0
    DrawState_SetupLight1,           // DRAWSTATE_LIGHT1
    DrawState_SetupLight2,           // DRAWSTATE_LIGHT2
    DrawState_SetupLight3,           // DRAWSTATE_LIGHT3
    DrawState_SetupShininessTable,   // DRAWSTATE_SHININESS
    DrawState_SetupShadingStyle,     // DRAWSTATE_SHADING_STYLE
    DrawState_SetupToonTable,        // DRAWSTATE_TOONTABLE
    DrawState_SetupAlphaTest,        // DRAWSTATE_ALPHATEST
    DrawState_SetupAlphaBlend,       // DRAWSTATE_ALPHABLEND
    DrawState_SetupSwapSortMode,     // DRAWSTATE_SWAPSORTMODE
    DrawState_SetupFogOffset,        // DRAWSTATE_FOGOFFSET
    DrawState_SetupFogColor,         // DRAWSTATE_FOGCOLOR
    DrawState_SetupFogTable,         // DRAWSTATE_FOGTABLE
    DrawState_SetupEdgeMarking,      // DRAWSTATE_EDGEMARKING
    DrawState_SetupEdgeColorTable,   // DRAWSTATE_EDGECOLORTABLE
    DrawState_SetupAntiAliasing,     // DRAWSTATE_ANTIALIASING
    DrawState_SetupDisplay1DotDepth, // DRAWSTATE_DISPLAY1DOTDEPTH
    DrawState_SetupClearColor,       // DRAWSTATE_CLEARCOLOR
};

// --------------------
// FUNCTIONS
// --------------------

void InitDrawStateSystem(void)
{
    // Nothin
}

void LoadDrawState(void *fileData, DrawStateSystems systems)
{
    for (u16 i = 0; i < DRAWSTATE_COUNT; i++)
    {
        if ((systems & (1 << i)))
            DrawStateSystemSetupTable[i]((DrawState *)fileData);
    }
}

BOOL GetDrawStateCameraProjection(DrawState *state, Camera3D *camera)
{
    if (state->flags.useOrthoProjection)
        return TRUE;

    camera->config.projFOV     = state->projection.perspective.fov >> 1;
    camera->config.projNear    = state->matProjNear;
    camera->config.projFar     = state->matProjFar;
    camera->config.aspectRatio = state->projection.perspective.aspectRatio;
    camera->config.projScaleW  = state->matProjScaleW;
    return FALSE;
}

void GetDrawStateCameraView(DrawState *state, Camera3D *camera)
{
    MI_CpuCopy32(&state->lookAtTo, &camera->lookAtTo, sizeof(camera->lookAtTo));
    MI_CpuCopy32(&state->lookAtFrom, &camera->lookAtFrom, sizeof(camera->lookAtFrom));

    // Vector3.Up
    camera->lookAtUp.x = FLOAT_TO_FX32(0.0);
    camera->lookAtUp.y = FLOAT_TO_FX32(1.0);
    camera->lookAtUp.z = FLOAT_TO_FX32(0.0);

    MI_CpuClear32(&camera->position, sizeof(camera->position));
}

void GetDrawStateLight(DrawState *state, DirLight *light, GXLightId id)
{
    MI_CpuCopy16(&state->lights[id].dir, &light->dir, sizeof(VecFx16));
    light->color = state->lights[id].color;
}

// SYSTEM SETUP

void DrawState_SetupLookAtMatrix(DrawState *state)
{
    VecFx32 up;
    MI_CpuClear16(&up, sizeof(up));

    // Vector3.UP
    up.y = FLOAT_TO_FX32(1.0);

    NNS_G3dGlbLookAt(&state->lookAtTo, &up, &state->lookAtFrom);
}

void DrawState_SetupProjectionMatrix(DrawState *state)
{
    if (state->flags.useOrthoProjection)
    {
        NNS_G3dGlbOrthoW(0, state->projection.ortho.height, 0, state->projection.ortho.width, state->matProjNear, state->matProjFar, state->matProjScaleW);
    }
    else
    {
        u32 fov = (u32)(state->projection.perspective.fov << 15) >> 16;
        NNS_G3dGlbPerspectiveW(FX_SinIdx(fov & 0xFFFF), FX_CosIdx(fov & 0xFFFF), state->projection.perspective.aspectRatio, state->matProjNear, state->matProjFar,
                               state->matProjScaleW);
    }
}

void DrawState_SetupSwapBufferMode(DrawState *state)
{
    GXBufferMode mode               = state->flags.bufferMode ? GX_BUFFERMODE_W : GX_BUFFERMODE_Z;
    renderCoreSwapBuffer.bufferMode = mode;
}

void DrawState_SetupLight0(DrawState *state)
{
    DirLight light;

    MI_CpuClear16(&light, sizeof(light));
    GetDrawStateLight(state, &light, GX_LIGHTID_0);
    Camera3D__SetLight(GX_LIGHTID_0, &light);
}

void DrawState_SetupLight1(DrawState *state)
{
    DirLight light;

    MI_CpuClear16(&light, sizeof(light));
    GetDrawStateLight(state, &light, GX_LIGHTID_1);
    Camera3D__SetLight(GX_LIGHTID_1, &light);
}

void DrawState_SetupLight2(DrawState *state)
{
    DirLight light;

    MI_CpuClear16(&light, sizeof(light));
    GetDrawStateLight(state, &light, GX_LIGHTID_2);
    Camera3D__SetLight(GX_LIGHTID_2, &light);
}

void DrawState_SetupLight3(DrawState *state)
{
    DirLight light;

    MI_CpuClear16(&light, sizeof(light));
    GetDrawStateLight(state, &light, GX_LIGHTID_3);
    Camera3D__SetLight(GX_LIGHTID_3, &light);
}

void DrawState_SetupShininessTable(DrawState *state)
{
    NNS_G3dGeShininess(state->shininessTable);
}

void DrawState_SetupShadingStyle(DrawState *state)
{
    GXShading shading = state->flags.shadingStyle ? GX_SHADING_HIGHLIGHT : GX_SHADING_TOON;
    G3X_SetShading(shading);
}

void DrawState_SetupToonTable(DrawState *state)
{
    G3X_SetToonTable(state->toonTable);
}

void DrawState_SetupAlphaTest(DrawState *state)
{
    BOOL enabled = state->flags.useAlphaTesting;
    G3X_AlphaTest(enabled, state->alphaTestRef);
}

void DrawState_SetupAlphaBlend(DrawState *state)
{
    BOOL enabled = state->flags.useAlphaBlending;
    G3X_AlphaBlend(enabled);
}

void DrawState_SetupSwapSortMode(DrawState *state)
{
    GXSortMode mode               = state->flags.sortMode ? GX_SORTMODE_AUTO : GX_SORTMODE_MANUAL;
    renderCoreSwapBuffer.sortMode = mode;
}

void DrawState_SetupFogOffset(DrawState *state)
{
    GXFogBlend mode = state->flags.fogBlendMode ? GX_FOGBLEND_ALPHA : GX_FOGBLEND_COLOR_ALPHA;
    G3X_SetFog(TRUE, mode, (GXFogSlope)state->fogSlope, state->fogOffset);
}

void DrawState_SetupFogColor(DrawState *state)
{
    G3X_SetFogColor(state->fogColor, state->fogAlpha);
}

void DrawState_SetupFogTable(DrawState *state)
{
    u32 table[8];

    MI_CpuCopy16(state->fogTable, table, sizeof(state->fogTable));
    G3X_SetFogTable(table);
}

void DrawState_SetupEdgeMarking(DrawState *state)
{
    BOOL enabled = state->flags.useEdgeMarking;
    G3X_EdgeMarking(enabled);
}

void DrawState_SetupEdgeColorTable(DrawState *state)
{
    G3X_SetEdgeColorTable(state->edgeColorTable);
}

void DrawState_SetupAntiAliasing(DrawState *state)
{
    BOOL enabled = state->flags.useAntiAliasing;
    G3X_AntiAlias(enabled);
}

void DrawState_SetupDisplay1DotDepth(DrawState *state)
{
    G3X_SetDisp1DotDepth(state->display1DotDepthConfig);
}

void DrawState_SetupClearColor(DrawState *state)
{
    BOOL fogEnabled = state->flags.useFog;
    G3X_SetClearColor(state->clearColor, state->clearColorAlpha, state->clearColorDepth, state->clearColorPolygonID, fogEnabled);
}
