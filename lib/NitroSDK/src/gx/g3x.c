#include <nitro.h>

// --------------------
// FUNCTION DECLS
// --------------------

static asm void GXi_NopClearFifo128_(register void *pDest);

// --------------------
// FUNCTIONS
// --------------------

void G3X_Init(void)
{
    G3X_ClearFifo();
    G3_End();

    while (G3X_IsGeometryBusy())
    {
    }

    reg_G3X_DISP3DCNT = 0;
    reg_G3X_GXSTAT    = 0;

    reg_G2_BG0OFS = 0;

    G3X_ResetListRamOverflow();
    G3X_ResetLineBufferUnderflow();
    G3X_SetShading(GX_SHADING_TOON);
    G3X_AntiAlias(TRUE);
    G3X_AlphaTest(FALSE, 0);

    G3X_ResetMtxStackOverflow();

    G3X_SetFifoIntrCond(GX_FIFOINTR_COND_EMPTY);

    G3X_InitMtxStack();

    reg_G3X_CLEAR_COLOR = 0;
    reg_G3X_CLEAR_DEPTH = 0x7fff;

    reg_G3X_CLRIMAGE_OFFSET = 0;

    reg_G3X_FOG_COLOR = 0;

    // FOG_OFFSET
    reg_G3X_FOG_OFFSET = 0;

    // BG0CNT
    G2_SetBG0Priority(0);

    G3X_InitTable();

    // POLYGON_ATTR
    G3_PolygonAttr(GX_LIGHTMASK_NONE, GX_POLYGONMODE_MODULATE, GX_CULL_BACK, 0, 31, GX_POLYGON_ATTR_MISC_NONE);

    // TEXIMAGE_PARAM
    G3_TexImageParam(GX_TEXFMT_NONE, GX_TEXGEN_NONE, GX_TEXSIZE_S8, GX_TEXSIZE_T8, GX_TEXREPEAT_NONE, GX_TEXFLIP_NONE, GX_TEXPLTTCOLOR0_USE, 0);

    // TEXPLTT_BASE
    G3_Direct1(G3OP_TEXPLTT_BASE, 0);
}

void G3X_Reset(void)
{
    while (G3X_IsGeometryBusy())
    {
    }

    G3X_ResetMtxStackOverflow();
    G3X_ResetListRamOverflow();
    G3X_ResetLineBufferUnderflow();

    G3X_ResetMtxStack();

    // POLYGON_ATTR
    G3_PolygonAttr(GX_LIGHTMASK_NONE, GX_POLYGONMODE_MODULATE, GX_CULL_BACK, 0, 31, GX_POLYGON_ATTR_MISC_NONE);

    // TEXIMAGE_PARAM
    G3_TexImageParam(GX_TEXFMT_NONE, GX_TEXGEN_NONE, GX_TEXSIZE_S8, GX_TEXSIZE_T8, GX_TEXREPEAT_NONE, GX_TEXFLIP_NONE, GX_TEXPLTTCOLOR0_USE, 0);

    // TEXPLTT_BASE
    G3_Direct1(G3OP_TEXPLTT_BASE, 0);
}

void G3X_ClearFifo(void)
{
    GXi_NopClearFifo128_((void *)&reg_G3X_GXFIFO);

    while (G3X_IsGeometryBusy())
    {
    }
}

void G3X_InitMtxStack(void)
{
    s32 levelPV;
    s32 levelPJ;

    G3X_ResetMtxStackOverflow();

    while (G3X_GetMtxStackLevelPV(&levelPV))
        ;
    while (G3X_GetMtxStackLevelPJ(&levelPJ))
        ;

    G3_MtxMode(GX_MTXMODE_TEXTURE);
    G3_Identity();

    G3_MtxMode(GX_MTXMODE_PROJECTION);
    if (levelPJ != 0)
    {
        G3_PopMtx(levelPJ);
    }
    G3_Identity();

    G3_MtxMode(GX_MTXMODE_POSITION_VECTOR);
    G3_PopMtx(levelPV);
    G3_Identity();
}

void G3X_ResetMtxStack(void)
{
    s32 levelPV;
    s32 levelPJ;

    G3X_ResetMtxStackOverflow();

    while (G3X_GetMtxStackLevelPV(&levelPV))
        ;
    while (G3X_GetMtxStackLevelPJ(&levelPJ))
        ;

    G3_MtxMode(GX_MTXMODE_TEXTURE);
    G3_Identity();

    G3_MtxMode(GX_MTXMODE_PROJECTION);
    if (levelPJ != 0)
    {
        G3_PopMtx(levelPJ);
    }

    G3_MtxMode(GX_MTXMODE_POSITION_VECTOR);
    G3_PopMtx(levelPV);
    G3_Identity();
}

void G3X_SetFog(BOOL enable, GXFogBlend fogMode, GXFogSlope fogSlope, int fogOffset)
{
    if (enable)
    {
        reg_G3X_FOG_OFFSET = (u16)fogOffset;

        reg_G3X_DISP3DCNT = (u16)((reg_G3X_DISP3DCNT & ~(REG_G3X_DISP3DCNT_FOG_SHIFT_MASK | REG_G3X_DISP3DCNT_FMOD_MASK | REG_G3X_DISP3DCNT_RO_MASK | REG_G3X_DISP3DCNT_GO_MASK))
                                  | ((fogSlope << REG_G3X_DISP3DCNT_FOG_SHIFT_SHIFT) | (fogMode << REG_G3X_DISP3DCNT_FMOD_SHIFT) | (REG_G3X_DISP3DCNT_FME_MASK)));
    }
    else
    {
        reg_G3X_DISP3DCNT &= (u16) ~(REG_G3X_DISP3DCNT_FME_MASK | REG_G3X_DISP3DCNT_RO_MASK | REG_G3X_DISP3DCNT_GO_MASK);
    }
}

int G3X_GetClipMtx(MtxFx44 *m)
{
    if (G3X_IsGeometryBusy())
    {
        return -1;
    }
    else
    {
        MI_Copy64B((void *)REG_CLIPMTX_RESULT_0_ADDR, &m->_00);
        return 0;
    }
}

int G3X_GetVectorMtx(MtxFx33 *m)
{
    if (G3X_IsGeometryBusy())
    {
        return -1;
    }
    else
    {
        MI_Copy36B((void *)(REG_VECMTX_RESULT_0_ADDR), &m->_00);

        return 0;
    }
}

void G3X_SetEdgeColorTable(const GXRgb *rgb_8)
{
    MI_CpuCopy16(rgb_8, (void *)REG_EDGE_COLOR_0_L_ADDR, 16);
}

void G3X_SetFogTable(const u32 *fogTable)
{
    MI_Copy32B(&fogTable[0], (void *)REG_FOG_TABLE_0_ADDR);
}

void G3X_SetToonTable(const GXRgb *rgb_32)
{
    MI_CpuCopy16(rgb_32, (void *)REG_TOON_TABLE_0_L_ADDR, 64);
}

void G3X_SetClearColor(GXRgb rgb, int alpha, int depth, int polygonID, BOOL fog)
{
    u32 val;

    val = (u32)(rgb | (alpha << REG_G3X_CLEAR_COLOR_ALPHA_SHIFT) | (polygonID << REG_G3X_CLEAR_COLOR_POLYGONID_SHIFT));
    if (fog)
        val |= REG_G3X_CLEAR_COLOR_F_MASK;

    reg_G3X_CLEAR_COLOR = val;
    reg_G3X_CLEAR_DEPTH = (u16)depth;
}

void G3X_InitTable(void)
{
    int i;

    if (GXi_DmaId != GX_DMA_NOT_USE)
    {
        MI_DmaFill32Async(GXi_DmaId, (void *)REG_EDGE_COLOR_0_L_ADDR, 0, 16, NULL, NULL);
        MI_DmaFill32(GXi_DmaId, (void *)REG_FOG_TABLE_0_ADDR, 0, 96);
    }
    else
    {
        MI_CpuFill32((void *)REG_EDGE_COLOR_0_L_ADDR, 0, 16);
        MI_CpuFill32((void *)REG_FOG_TABLE_0_ADDR, 0, 96);
    }

    for (i = 0; i < 32; ++i)
    {
        reg_G3_SHININESS = 0;
    }
}

int G3X_GetMtxStackLevelPV(s32 *level)
{
    if (reg_G3X_GXSTAT & REG_G3X_GXSTAT_SB_MASK)
    {
        return -1;
    }
    else
    {
        *level = (s32)((reg_G3X_GXSTAT & REG_G3X_GXSTAT_PV_MASK) >> REG_G3X_GXSTAT_PV_SHIFT);
        return 0;
    }
}

int G3X_GetMtxStackLevelPJ(s32 *level)
{
    if (reg_G3X_GXSTAT & REG_G3X_GXSTAT_SB_MASK)
    {
        return -1;
    }
    else
    {
        *level = (s32)((reg_G3X_GXSTAT & REG_G3X_GXSTAT_PJ_MASK) >> REG_G3X_GXSTAT_PJ_SHIFT);
        return 0;
    }
}

void G3X_SetDisp1DotDepth(fx32 w)
{
    reg_G3X_DISP_1DOT_DEPTH = (u16)((w >> 9) & 0x7fff);
}

int G3X_GetBoxTestResult(s32 *in)
{
    if (reg_G3X_GXSTAT & REG_G3X_GXSTAT_TB_MASK)
    {
        return -1;
    }
    else
    {
        *in = (s32)(reg_G3X_GXSTAT & REG_G3X_GXSTAT_TR_MASK);
        return 0;
    }
}

int G3X_GetPositionTestResult(VecFx32 *vec, fx32 *w)
{
    if (reg_G3X_GXSTAT & REG_G3X_GXSTAT_TB_MASK)
    {
        return -1;
    }
    else
    {
        vec->x = (fx32)reg_G3X_POS_RESULT_X;
        vec->y = (fx32)reg_G3X_POS_RESULT_Y;
        vec->z = (fx32)reg_G3X_POS_RESULT_Z;
        *w     = (fx32)reg_G3X_POS_RESULT_W;
        return 0;
    }
}

int G3X_GetVectorTestResult(fx16 *vec)
{
    if (reg_G3X_GXSTAT & REG_G3X_GXSTAT_TB_MASK)
    {
        return -1;
    }
    else
    {
        *(vec + 0) = (fx16)reg_G3X_VEC_RESULT_X;
        *(vec + 1) = (fx16)reg_G3X_VEC_RESULT_Y;
        *(vec + 2) = (fx16)reg_G3X_VEC_RESULT_Z;
        return 0;
    }
}

void G3X_SetHOffset(int hOffset)
{
    reg_G2_BG0OFS = (u32)hOffset;
}

#include <nitro/code32.h>

static asm void GXi_NopClearFifo128_(register void *pDest)
{
    // clang-format off
    mov     r1,  #0
    mov     r2,  #0
    mov     r3,  #0
    mov     r12, #0
    
    stmia   r0, {r1-r3, r12} // 0 - 15
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}

    stmia   r0, {r1-r3, r12} // 16 - 31
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}

    stmia   r0, {r1-r3, r12} // 32 - 47
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}

    stmia   r0, {r1-r3, r12} // 48 - 63
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}

    stmia   r0, {r1-r3, r12} // 64 - 79
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}

    stmia   r0, {r1-r3, r12} // 80 - 95
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}

    stmia   r0, {r1-r3, r12} // 96 - 111
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}

    stmia   r0, {r1-r3, r12} // 112 - 127
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}
    stmia   r0, {r1-r3, r12}
    
    bx      lr
    // clang-format on
}

#include <nitro/codereset.h>