#ifndef NITRO_GXSTATE_H
#define NITRO_GXSTATE_H

#include <nitro/gx/gx.h>
#include <nitro/gx/gx_vramctrl.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    u16 lcdc;
    u16 bg;
    u16 obj;
    u16 arm7;
    u16 tex;
    u16 texPltt;
    u16 clrImg;
    u16 bgExtPltt;
    u16 objExtPltt;

    u16 sub_bg;
    u16 sub_obj;
    u16 sub_bgExtPltt;
    u16 sub_objExtPltt;
} GX_VRAMCnt_;

typedef struct
{
    GX_VRAMCnt_ vramCnt;
} GX_State;

// --------------------
// VARIABLES
// --------------------

extern GX_State gGXState;

// --------------------
// FUNCTIONS
// --------------------

void GX_InitGXState();

static inline void GX_StateCheck_VRAMCnt(void) {}
static inline void GX_RegionCheck_BG(u32 first, u32 last) {}
static inline void GX_RegionCheck_OBJ(u32 first, u32 last) {}
static inline void GX_RegionCheck_SubBG(u32 first, u32 last) {}
static inline void GX_RegionCheck_SubOBJ(u32 first, u32 last) {}
static inline void GX_RegionCheck_Tex(GXVRamTex tex, u32 first, u32 last) {}
static inline void GX_RegionCheck_TexPltt(GXVRamTexPltt texPltt, u32 first, u32 last) {}

#ifdef __cplusplus
}
#endif

#endif // NITRO_GXSTATE_H
