#ifndef RUSH_DRAWSTATE_H
#define RUSH_DRAWSTATE_H

#include <global.h>
#include <game/graphics/drawReqTask.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

enum DrawStateSystems_
{
    DRAWSTATE_LOOKAT           = 1 << 0,
    DRAWSTATE_PROJECTION       = 1 << 1,
    DRAWSTATE_SWAPBUFFERMODE   = 1 << 2,
    DRAWSTATE_LIGHT0           = 1 << 3,
    DRAWSTATE_LIGHT1           = 1 << 4,
    DRAWSTATE_LIGHT2           = 1 << 5,
    DRAWSTATE_LIGHT3           = 1 << 6,
    DRAWSTATE_SHININESS        = 1 << 7,
    DRAWSTATE_SHADING_STYLE    = 1 << 8,
    DRAWSTATE_TOONTABLE        = 1 << 9,
    DRAWSTATE_ALPHATEST        = 1 << 10,
    DRAWSTATE_ALPHABLEND       = 1 << 11,
    DRAWSTATE_SWAPSORTMODE     = 1 << 12,
    DRAWSTATE_FOGOFFSET        = 1 << 13,
    DRAWSTATE_FOGCOLOR         = 1 << 14,
    DRAWSTATE_FOGTABLE         = 1 << 15,
    DRAWSTATE_EDGEMARKING      = 1 << 16,
    DRAWSTATE_EDGECOLORTABLE   = 1 << 17,
    DRAWSTATE_ANTIALIASING     = 1 << 18,
    DRAWSTATE_DISPLAY1DOTDEPTH = 1 << 19,
    DRAWSTATE_CLEARCOLOR       = 1 << 20,

    DRAWSTATE_COUNT = 21,

    DRAWSTATE_LIGHT_ALL = DRAWSTATE_LIGHT0 | DRAWSTATE_LIGHT1 | DRAWSTATE_LIGHT2 | DRAWSTATE_LIGHT3,
    DRAWSTATE_ALL = DRAWSTATE_LOOKAT | DRAWSTATE_PROJECTION | DRAWSTATE_SWAPBUFFERMODE | DRAWSTATE_LIGHT_ALL | DRAWSTATE_SHININESS | DRAWSTATE_SHADING_STYLE | DRAWSTATE_TOONTABLE
                    | DRAWSTATE_ALPHATEST | DRAWSTATE_ALPHABLEND | DRAWSTATE_SWAPSORTMODE | DRAWSTATE_FOGOFFSET | DRAWSTATE_FOGCOLOR | DRAWSTATE_FOGTABLE | DRAWSTATE_EDGEMARKING
                    | DRAWSTATE_EDGECOLORTABLE | DRAWSTATE_ANTIALIASING | DRAWSTATE_DISPLAY1DOTDEPTH | DRAWSTATE_CLEARCOLOR,
};
typedef u32 DrawStateSystems;

// --------------------
// STRUCTS
// --------------------

typedef struct DrawState_
{
    u32 signature;

    struct
    {
        u32 useAlphaTesting : 1;
        u32 useAlphaBlending : 1;
        u32 useEdgeMarking : 1;
        u32 useAntiAliasing : 1;
        u32 useFog : 1;
        u32 unused5 : 1;
        u32 unused6 : 1;
        u32 unused7 : 1;
        u32 unused8 : 1;
        u32 unused9 : 1;
        u32 unused10 : 1;
        u32 unused11 : 1;
        u32 unused12 : 1;
        u32 unused13 : 1;
        u32 unused14 : 1;
        u32 unused15 : 1;
        u32 useOrthoProjection : 1;
        u32 bufferMode : 1;
        u32 shadingStyle : 1;
        u32 sortMode : 1;
        u32 fogBlendMode : 1;
        u32 unused21 : 1;
        u32 unused22 : 1;
        u32 unused23 : 1;
        u32 unused24 : 1;
        u32 unused25 : 1;
        u32 unused26 : 1;
        u32 unused27 : 1;
        u32 unused28 : 1;
        u32 unused29 : 1;
        u32 unused30 : 1;
        u32 unused31 : 1;
    } flags;

    VecFx32 lookAtTo;
    VecFx32 lookAtFrom;

    union
    {
        struct BSDPerspectiveMatrix
        {
            u16 fov;
            fx32 aspectRatio;
        } perspective;

        struct BSDOrthoMatrix
        {
            fx32 width;
            fx32 height;
        } ortho;

    } projection;

    fx32 matProjNear;
    fx32 matProjFar;
    fx32 matProjScaleW;
    DirLight lights[4];
    u32 shininessTable[32];
    GXRgb toonTable[32];
    GXRgb fogColor;
    u8 fogAlpha;
    u8 fogSlope;
    u16 fogOffset;
    u16 fogTable[16];
    u16 alphaTestRef;
    u16 edgeColorTable[8];
    fx32 display1DotDepthConfig;
    u16 clearColor;
    u8 clearColorAlpha;
    u8 clearColorPolygonID;
    u16 clearColorDepth;
} DrawState;

// --------------------
// FUNCTIONS
// --------------------

void InitDrawStateSystem(void);
void LoadDrawState(void *fileData, DrawStateSystems systems);
BOOL GetDrawStateCameraProjection(DrawState *state, Camera3D *camera);
void GetDrawStateCameraView(DrawState *state, Camera3D *camera);
void GetDrawStateLight(DrawState *state, DirLight *light, GXLightId id);

#ifdef __cplusplus
}
#endif

#endif // RUSH_DRAWSTATE_H
