#include <nitro.h>

#include <nitro/code32.h>
void G3CS_Direct0(GXDLInfo *info, int op)
{
    if (op != G3OP_NOP && ((u32)info->curr_cmd & 0x3) != 0)
    {
        info->param0_cmd_flg = TRUE;
    }

    *info->curr_cmd = (u8)(op);
}

void G3CS_Direct1(GXDLInfo *info, int op, u32 param0)
{
    info->param0_cmd_flg = FALSE;

    *info->curr_cmd   = (u8)(op);
    *info->curr_param = param0;
}

void G3CS_Direct2(GXDLInfo *info, int op, u32 param0, u32 param1)
{
    info->param0_cmd_flg = FALSE;

    *info->curr_cmd         = (u8)(op);
    *(info->curr_param + 0) = param0;
    *(info->curr_param + 1) = param1;
}

void G3CS_Direct3(GXDLInfo *info, int op, u32 param0, u32 param1, u32 param2)
{
    info->param0_cmd_flg = FALSE;

    *info->curr_cmd         = (u8)(op);
    *(info->curr_param + 0) = param0;
    *(info->curr_param + 1) = param1;
    *(info->curr_param + 2) = param2;
}

void G3CS_DirectN(GXDLInfo *info, int op, int nParams, const u32 *params)
{
    if (nParams == 0)
    {
        G3CS_Direct0(info, op);
        return;
    }

    info->param0_cmd_flg = FALSE;

    *info->curr_cmd = (u8)(op);
    while (--nParams >= 0)
    {
        *(info->curr_param + nParams) = *(params + nParams);
    }
}

void G3CS_LoadMtx44(GXDLInfo *info, const MtxFx44 *m)
{
    info->param0_cmd_flg = FALSE;

    *info->curr_cmd = G3OP_MTX_LOAD_4x4;
#ifndef SDK_WIN32
    MI_Copy64B(&m->_00, (void *)info->curr_param);
#else
    *(info->curr_param + 0) = (u32)m->_00;
    *(info->curr_param + 1) = (u32)m->_01;
    *(info->curr_param + 2) = (u32)m->_02;
    *(info->curr_param + 3) = (u32)m->_03;

    *(info->curr_param + 4) = (u32)m->_10;
    *(info->curr_param + 5) = (u32)m->_11;
    *(info->curr_param + 6) = (u32)m->_12;
    *(info->curr_param + 7) = (u32)m->_13;

    *(info->curr_param + 8)  = (u32)m->_20;
    *(info->curr_param + 9)  = (u32)m->_21;
    *(info->curr_param + 10) = (u32)m->_22;
    *(info->curr_param + 11) = (u32)m->_23;

    *(info->curr_param + 12) = (u32)m->_30;
    *(info->curr_param + 13) = (u32)m->_31;
    *(info->curr_param + 14) = (u32)m->_32;
    *(info->curr_param + 15) = (u32)m->_33;
#endif
}

void G3CS_LoadMtx43(GXDLInfo *info, const MtxFx43 *m)
{
    info->param0_cmd_flg = FALSE;

    *info->curr_cmd = G3OP_MTX_LOAD_4x3;
#ifndef SDK_WIN32
    MI_Copy48B(&m->_00, (void *)info->curr_param);
#else
    *(info->curr_param + 0) = (u32)m->_00;
    *(info->curr_param + 1) = (u32)m->_01;
    *(info->curr_param + 2) = (u32)m->_02;

    *(info->curr_param + 3) = (u32)m->_10;
    *(info->curr_param + 4) = (u32)m->_11;
    *(info->curr_param + 5) = (u32)m->_12;

    *(info->curr_param + 6) = (u32)m->_20;
    *(info->curr_param + 7) = (u32)m->_21;
    *(info->curr_param + 8) = (u32)m->_22;

    *(info->curr_param + 9)  = (u32)m->_30;
    *(info->curr_param + 10) = (u32)m->_31;
    *(info->curr_param + 11) = (u32)m->_32;
#endif
}

void G3CS_MultMtx44(GXDLInfo *info, const MtxFx44 *m)
{
    info->param0_cmd_flg = FALSE;

    *info->curr_cmd = G3OP_MTX_MULT_4x4;
#ifndef SDK_WIN32
    MI_Copy64B(&m->_00, (void *)info->curr_param);
#else
    *(info->curr_param + 0) = (u32)m->_00;
    *(info->curr_param + 1) = (u32)m->_01;
    *(info->curr_param + 2) = (u32)m->_02;
    *(info->curr_param + 3) = (u32)m->_03;

    *(info->curr_param + 4) = (u32)m->_10;
    *(info->curr_param + 5) = (u32)m->_11;
    *(info->curr_param + 6) = (u32)m->_12;
    *(info->curr_param + 7) = (u32)m->_13;

    *(info->curr_param + 8)  = (u32)m->_20;
    *(info->curr_param + 9)  = (u32)m->_21;
    *(info->curr_param + 10) = (u32)m->_22;
    *(info->curr_param + 11) = (u32)m->_23;

    *(info->curr_param + 12) = (u32)m->_30;
    *(info->curr_param + 13) = (u32)m->_31;
    *(info->curr_param + 14) = (u32)m->_32;
    *(info->curr_param + 15) = (u32)m->_33;
#endif
}

void G3CS_MultMtx43(GXDLInfo *info, const MtxFx43 *m)
{
    info->param0_cmd_flg = FALSE;

    *info->curr_cmd = G3OP_MTX_MULT_4x3;
#ifndef SDK_WIN32
    MI_Copy48B(&m->_00, (void *)info->curr_param);
#else
    *(info->curr_param + 0) = (u32)m->_00;
    *(info->curr_param + 1) = (u32)m->_01;
    *(info->curr_param + 2) = (u32)m->_02;

    *(info->curr_param + 3) = (u32)m->_10;
    *(info->curr_param + 4) = (u32)m->_11;
    *(info->curr_param + 5) = (u32)m->_12;

    *(info->curr_param + 6) = (u32)m->_20;
    *(info->curr_param + 7) = (u32)m->_21;
    *(info->curr_param + 8) = (u32)m->_22;

    *(info->curr_param + 9)  = (u32)m->_30;
    *(info->curr_param + 10) = (u32)m->_31;
    *(info->curr_param + 11) = (u32)m->_32;
#endif
}

void G3CS_MultMtx33(GXDLInfo *info, const MtxFx33 *m)
{
    info->param0_cmd_flg = FALSE;

    *info->curr_cmd = G3OP_MTX_MULT_3x3;
#ifndef SDK_WIN32
    MI_Copy36B(&m->_00, (void *)info->curr_param);
#else
    *(info->curr_param + 0) = (u32)m->_00;
    *(info->curr_param + 1) = (u32)m->_01;
    *(info->curr_param + 2) = (u32)m->_02;

    *(info->curr_param + 3) = (u32)m->_10;
    *(info->curr_param + 4) = (u32)m->_11;
    *(info->curr_param + 5) = (u32)m->_12;

    *(info->curr_param + 6) = (u32)m->_20;
    *(info->curr_param + 7) = (u32)m->_21;
    *(info->curr_param + 8) = (u32)m->_22;
#endif
}

void G3CS_MultTransMtx33(GXDLInfo *info, const MtxFx33 *mtx, const VecFx32 *trans)
{
    info->param0_cmd_flg = FALSE;

    *info->curr_cmd = G3OP_MTX_MULT_4x3;
#ifndef SDK_WIN32
    MI_Copy36B(&mtx->_00, (void *)info->curr_param);
    MI_CpuCopy32(trans, (u32 *)info->curr_param + 9, sizeof(VecFx32));
#else
    *((u32 *)info->curr_param + 0) = (u32)mtx->_00;
    *((u32 *)info->curr_param + 1) = (u32)mtx->_01;
    *((u32 *)info->curr_param + 2) = (u32)mtx->_02;

    *((u32 *)info->curr_param + 3) = (u32)mtx->_10;
    *((u32 *)info->curr_param + 4) = (u32)mtx->_11;
    *((u32 *)info->curr_param + 5) = (u32)mtx->_12;

    *((u32 *)info->curr_param + 6) = (u32)mtx->_20;
    *((u32 *)info->curr_param + 7) = (u32)mtx->_21;
    *((u32 *)info->curr_param + 8) = (u32)mtx->_22;

    *((u32 *)info->curr_param + 9)  = trans->x;
    *((u32 *)info->curr_param + 10) = trans->y;
    *((u32 *)info->curr_param + 11) = trans->z;
#endif
}

#include <nitro/codereset.h>

void G3C_Direct0(GXDLInfo *info, int op)
{
    G3CS_Direct0(info, op);
    G3C_UpdateGXDLInfo(info, 0);
}

void G3C_Direct1(GXDLInfo *info, int op, u32 param0)
{
    G3CS_Direct1(info, op, param0);

    G3C_UpdateGXDLInfo(info, 1);
}

void G3C_Direct2(GXDLInfo *info, int op, u32 param0, u32 param1)
{
    G3CS_Direct2(info, op, param0, param1);

    G3C_UpdateGXDLInfo(info, 2);
}

void G3C_Direct3(GXDLInfo *info, int op, u32 param0, u32 param1, u32 param2)
{
    G3CS_Direct3(info, op, param0, param1, param2);

    G3C_UpdateGXDLInfo(info, 3);
}

void G3C_DirectN(GXDLInfo *info, int op, int nParams, const u32 *params)
{
    G3CS_DirectN(info, op, nParams, params);

    G3C_UpdateGXDLInfo(info, nParams);
}

void G3C_UpdateGXDLInfo(GXDLInfo *info, int n)
{
    info->curr_param += n;

    if (((u32)(++info->curr_cmd) & 0x3) == 0)
    {
        if (info->param0_cmd_flg)
        {
            *(u32 *)(info->curr_param++) = 0;
            info->param0_cmd_flg         = FALSE;
        }
        info->curr_cmd = (u8 *)(info->curr_param++);
    }
}

void G3C_Nop(GXDLInfo *info)
{
    G3CS_Nop(info);
    G3C_UpdateGXDLInfo(info, G3OP_NOP_NPARAMS);
}

void G3C_MtxMode(GXDLInfo *info, GXMtxMode mode)
{
    G3CS_MtxMode(info, mode);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_MODE_NPARAMS);
}

void G3C_PushMtx(GXDLInfo *info)
{
    G3CS_PushMtx(info);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_PUSH_NPARAMS);
}

void G3C_PopMtx(GXDLInfo *info, int num)
{
    G3CS_PopMtx(info, num);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_POP_NPARAMS);
}

void G3C_StoreMtx(GXDLInfo *info, int num)
{
    G3CS_StoreMtx(info, num);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_STORE_NPARAMS);
}

void G3C_RestoreMtx(GXDLInfo *info, int num)
{
    G3CS_RestoreMtx(info, num);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_RESTORE_NPARAMS);
}

void G3C_Identity(GXDLInfo *info)
{
    G3CS_Identity(info);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_IDENTITY_NPARAMS);
}

void G3C_LoadMtx44(GXDLInfo *info, const MtxFx44 *m)
{
    G3CS_LoadMtx44(info, m);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_LOAD_4x4_NPARAMS);
}

void G3C_LoadMtx43(GXDLInfo *info, const MtxFx43 *m)
{
    G3CS_LoadMtx43(info, m);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_LOAD_4x3_NPARAMS);
}

void G3C_MultMtx44(GXDLInfo *info, const MtxFx44 *m)
{
    G3CS_MultMtx44(info, m);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_MULT_4x4_NPARAMS);
}

void G3C_MultMtx43(GXDLInfo *info, const MtxFx43 *m)
{
    G3CS_MultMtx43(info, m);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_MULT_4x3_NPARAMS);
}

void G3C_MultMtx33(GXDLInfo *info, const MtxFx33 *m)
{
    G3CS_MultMtx33(info, m);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_MULT_3x3_NPARAMS);
}

void G3C_MultTransMtx33(GXDLInfo *info, const MtxFx33 *mtx, const VecFx32 *trans)
{
    G3CS_MultTransMtx33(info, mtx, trans);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_MULT_4x3_NPARAMS);
}

void G3C_Scale(GXDLInfo *info, fx32 x, fx32 y, fx32 z)
{
    G3CS_Scale(info, x, y, z);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_SCALE_NPARAMS);
}

void G3C_Translate(GXDLInfo *info, fx32 x, fx32 y, fx32 z)
{
    G3CS_Translate(info, x, y, z);
    G3C_UpdateGXDLInfo(info, G3OP_MTX_TRANS_NPARAMS);
}

void G3C_Color(GXDLInfo *info, GXRgb rgb)
{
    G3CS_Color(info, rgb);
    G3C_UpdateGXDLInfo(info, G3OP_COLOR_NPARAMS);
}

void G3C_Normal(GXDLInfo *info, fx16 x, fx16 y, fx16 z)
{
    G3CS_Normal(info, x, y, z);
    G3C_UpdateGXDLInfo(info, G3OP_NORMAL_NPARAMS);
}

void G3C_TexCoord(GXDLInfo *info, fx32 s, fx32 t)
{
    G3CS_TexCoord(info, s, t);
    G3C_UpdateGXDLInfo(info, G3OP_TEXCOORD_NPARAMS);
}

void G3C_Vtx(GXDLInfo *info, fx16 x, fx16 y, fx16 z)
{
    G3CS_Vtx(info, x, y, z);
    G3C_UpdateGXDLInfo(info, G3OP_VTX_16_NPARAMS);
}

void G3C_Vtx10(GXDLInfo *info, fx16 x, fx16 y, fx16 z)
{
    G3CS_Vtx10(info, x, y, z);
    G3C_UpdateGXDLInfo(info, G3OP_VTX_10_NPARAMS);
}

void G3C_VtxXY(GXDLInfo *info, fx16 x, fx16 y)
{
    G3CS_VtxXY(info, x, y);
    G3C_UpdateGXDLInfo(info, G3OP_VTX_XY_NPARAMS);
}

void G3C_VtxXZ(GXDLInfo *info, fx16 x, fx16 z)
{
    G3CS_VtxXZ(info, x, z);
    G3C_UpdateGXDLInfo(info, G3OP_VTX_XZ_NPARAMS);
}

void G3C_VtxYZ(GXDLInfo *info, fx16 y, fx16 z)
{
    G3CS_VtxYZ(info, y, z);
    G3C_UpdateGXDLInfo(info, G3OP_VTX_YZ_NPARAMS);
}

void G3C_VtxDiff(GXDLInfo *info, fx16 x, fx16 y, fx16 z)
{
    G3CS_VtxDiff(info, x, y, z);
    G3C_UpdateGXDLInfo(info, G3OP_VTX_DIFF_NPARAMS);
}

void G3C_PolygonAttr(GXDLInfo *info, int light, GXPolygonMode polyMode, GXCull cullMode, int polygonID, int alpha, int misc)
{
    G3CS_PolygonAttr(info, light, polyMode, cullMode, polygonID, alpha, misc);
    G3C_UpdateGXDLInfo(info, G3OP_POLYGON_ATTR_NPARAMS);
}

void G3C_TexImageParam(GXDLInfo *info, GXTexFmt texFmt, GXTexGen texGen, GXTexSizeS s, GXTexSizeT t, GXTexRepeat repeat, GXTexFlip flip, GXTexPlttColor0 pltt0, u32 addr)
{
    G3CS_TexImageParam(info, texFmt, texGen, s, t, repeat, flip, pltt0, addr);

    G3C_UpdateGXDLInfo(info, G3OP_TEXIMAGE_PARAM_NPARAMS);
}

void G3C_TexPlttBase(GXDLInfo *info, u32 addr, GXTexFmt texfmt)
{
    G3CS_TexPlttBase(info, addr, texfmt);

    G3C_UpdateGXDLInfo(info, G3OP_TEXPLTT_BASE_NPARAMS);
}

void G3C_MaterialColorDiffAmb(GXDLInfo *info, GXRgb diffuse, GXRgb ambient, BOOL IsSetVtxColor)
{
    G3CS_MaterialColorDiffAmb(info, diffuse, ambient, IsSetVtxColor);
    G3C_UpdateGXDLInfo(info, G3OP_DIF_AMB_NPARAMS);
}

void G3C_MaterialColorSpecEmi(GXDLInfo *info, GXRgb specular, GXRgb emission, BOOL IsShininess)
{
    G3CS_MaterialColorSpecEmi(info, specular, emission, IsShininess);
    G3C_UpdateGXDLInfo(info, G3OP_SPE_EMI_NPARAMS);
}

void G3C_LightVector(GXDLInfo *info, GXLightId lightID, fx16 x, fx16 y, fx16 z)
{
    G3CS_LightVector(info, lightID, x, y, z);
    G3C_UpdateGXDLInfo(info, G3OP_LIGHT_VECTOR_NPARAMS);
}

void G3C_LightColor(GXDLInfo *info, GXLightId lightID, GXRgb rgb)
{
    G3CS_LightColor(info, lightID, rgb);
    G3C_UpdateGXDLInfo(info, G3OP_LIGHT_COLOR_NPARAMS);
}

void G3C_Shininess(GXDLInfo *info, const u32 *table)
{
    G3CS_Shininess(info, table);
    G3C_UpdateGXDLInfo(info, G3OP_SHININESS_NPARAMS);
}

void G3C_Begin(GXDLInfo *info, GXBegin primitive)
{
    G3CS_Begin(info, primitive);
    G3C_UpdateGXDLInfo(info, G3OP_BEGIN_NPARAMS);
}

void G3C_End(GXDLInfo *info)
{
    G3CS_End(info);
    G3C_UpdateGXDLInfo(info, G3OP_END_NPARAMS);
}

void G3C_SwapBuffers(GXDLInfo *info, GXSortMode am, GXBufferMode zw)
{
    G3CS_SwapBuffers(info, am, zw);
    G3C_UpdateGXDLInfo(info, G3OP_SWAP_BUFFERS_NPARAMS);
}

void G3C_ViewPort(GXDLInfo *info, int x1, int y1, int x2, int y2)
{
    G3CS_ViewPort(info, x1, y1, x2, y2);
    G3C_UpdateGXDLInfo(info, G3OP_VIEWPORT_NPARAMS);
}

void G3C_BoxTest(GXDLInfo *info, const GXBoxTestParam *box)
{
    G3CS_BoxTest(info, box);
    G3C_UpdateGXDLInfo(info, G3OP_BOX_TEST_NPARAMS);
}

void G3C_PositionTest(GXDLInfo *info, fx16 x, fx16 y, fx16 z)
{
    G3CS_PositionTest(info, x, y, z);
    G3C_UpdateGXDLInfo(info, G3OP_POS_TEST_NPARAMS);
}

void G3C_VectorTest(GXDLInfo *info, fx16 x, fx16 y, fx16 z)
{
    G3CS_VectorTest(info, x, y, z);
    G3C_UpdateGXDLInfo(info, G3OP_VEC_TEST_NPARAMS);
}