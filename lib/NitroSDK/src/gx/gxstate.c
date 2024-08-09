#include <nitro.h>

// --------------------
// VARIABLES
// --------------------

GX_State gGXState;

// --------------------
// FUNCTIONS
// --------------------

#include <nitro/code32.h>
void GX_InitGXState()
{
    gGXState.vramCnt.lcdc       = 0;
    gGXState.vramCnt.bg         = 0;
    gGXState.vramCnt.obj        = 0;
    gGXState.vramCnt.arm7       = 0;
    gGXState.vramCnt.tex        = 0;
    gGXState.vramCnt.texPltt    = 0;
    gGXState.vramCnt.clrImg     = 0;
    gGXState.vramCnt.bgExtPltt  = 0;
    gGXState.vramCnt.objExtPltt = 0;

    gGXState.vramCnt.sub_bg         = 0;
    gGXState.vramCnt.sub_obj        = 0;
    gGXState.vramCnt.sub_bgExtPltt  = 0;
    gGXState.vramCnt.sub_objExtPltt = 0;

    reg_GX_VRAMCNT                = 0;
    *((u8 *)&reg_GX_WVRAMCNT + 0) = 0;
    *((u8 *)&reg_GX_WVRAMCNT + 1) = 0;
    *((u8 *)&reg_GX_WVRAMCNT + 2) = 0;
    reg_GX_VRAM_HI_CNT            = 0;
}
#include <nitro/codereset.h>