#include <nitro.h>

// --------------------
// FUNCTIONS
// --------------------

void G3i_FrustumW_(fx32 t, fx32 b, fx32 l, fx32 r, fx32 n, fx32 f, fx32 scaleW, BOOL draw, MtxFx44 *mtx)
{
    fx64c inv1, inv2;
    fx32 dblN;
    fx32 tmp1, tmp2;
    vs32 *p;

    FX_InvAsync(r - l);

    if (draw)
    {
        G3_MtxMode(GX_MTXMODE_PROJECTION);
        p = (vs32 *)&reg_G3_MTX_LOAD_4x4;
    }

    if (mtx != NULL)
    {
        mtx->_01 = 0;
        mtx->_02 = 0;
        mtx->_03 = 0;
        mtx->_10 = 0;
        mtx->_12 = 0;
        mtx->_13 = 0;
        mtx->_23 = -scaleW;
        mtx->_30 = 0;
        mtx->_31 = 0;
        mtx->_33 = 0;
    }

    dblN = n << 1;

    inv1 = FX_GetInvResultFx64c(); // r - l
    FX_InvAsyncImm(t - b);

    if (scaleW != FX32_ONE)
    {
        inv1 = (inv1 * scaleW) / FX32_ONE;
    }

    // Row 0
    tmp1 = FX_Mul32x64c(dblN, inv1);

    if (draw)
    {
        *p = tmp1; // _00
        *p = 0;    // _01
        *p = 0;    // _02
        *p = 0;    // _03
    }
    if (mtx != NULL)
    {
        mtx->_00 = tmp1;
    }

    // Row 1
    inv2 = FX_GetInvResultFx64c(); // t - b
    FX_InvAsyncImm(n - f);

    if (scaleW != FX32_ONE)
    {
        inv2 = (inv2 * scaleW) / FX32_ONE;
    }
    tmp1 = FX_Mul32x64c(dblN, inv2);

    if (draw)
    {
        *p = 0;    // _10
        *p = tmp1; // _11
        *p = 0;    // _12
        *p = 0;    // _13
    }
    if (mtx != NULL)
    {
        mtx->_11 = tmp1;
    }

    // Row 2
    tmp1 = FX_Mul32x64c(r + l, inv1);
    tmp2 = FX_Mul32x64c(t + b, inv2);
    if (draw)
    {
        *p = tmp1; // _20
        *p = tmp2; // _21
    }
    if (mtx != NULL)
    {
        mtx->_20 = tmp1;
        mtx->_21 = tmp2;
    }

    inv1 = FX_GetInvResultFx64c(); // n - f
    if (scaleW != FX32_ONE)
    {
        inv1 = (inv1 * scaleW) / FX32_ONE;
    }

    tmp1 = FX_Mul32x64c(f + n, inv1);

    // Row 3
    tmp2 = FX_Mul32x64c(FX_Mul(dblN, f), inv1);
    if (draw)
    {
        *p = tmp1;    // _22
        *p = -scaleW; // _23
        *p = 0;       // _30
        *p = 0;       // _31
        *p = tmp2;    // _32
        *p = 0;       // _33
    }
    if (mtx != NULL)
    {
        mtx->_22 = tmp1;
        mtx->_32 = tmp2;
    }
}

void G3i_PerspectiveW_(fx32 fovySin, fx32 fovyCos, fx32 aspect, fx32 n, fx32 f, fx32 scaleW, BOOL draw, MtxFx44 *mtx)
{
    fx32 one_tan;
    fx32 tmp1, tmp2;
    fx64 t;
    vs32 *p;

    one_tan = FX_Div((fx32)fovyCos, (fx32)fovySin);
    if (scaleW != FX32_ONE)
    {
        one_tan = (one_tan * scaleW) / FX32_ONE;
    }

    FX_DivAsyncImm(one_tan, aspect);
    if (draw)
    {
        G3_MtxMode(GX_MTXMODE_PROJECTION);
        p = (vs32 *)&reg_G3_MTX_LOAD_4x4;
    }

    if (mtx != NULL)
    {
        mtx->_01 = 0;
        mtx->_02 = 0;
        mtx->_03 = 0;

        mtx->_10 = 0;
        mtx->_12 = 0;
        mtx->_13 = 0;

        mtx->_20 = 0;
        mtx->_21 = 0;
        mtx->_23 = -scaleW;

        mtx->_30 = 0;
        mtx->_31 = 0;
        mtx->_33 = 0;
    }

    tmp1 = FX_GetDivResult(); // cos / (aspect * sin)
    FX_InvAsyncImm(n - f);

    if (draw)
    {
        *p = tmp1; // _00
        *p = 0;    // _01
        *p = 0;    // _02
        *p = 0;    // _03

        *p = 0;       // _10
        *p = one_tan; // _11
        *p = 0;       // _12
        *p = 0;       // _13

        *p = 0; // _20
        *p = 0; // _21
    }

    if (mtx != NULL)
    {
        mtx->_00 = tmp1;
        mtx->_11 = one_tan;
    }

    t = FX_GetInvResultFx64c(); // n - f
    if (scaleW != FX32_ONE)
    {
        t = (t * scaleW) / FX32_ONE;
    }

    tmp1 = FX_Mul32x64c(f + n, t);
    tmp2 = FX_Mul32x64c(FX_Mul(n << 1, f), t);

    if (draw)
    {
        *p = tmp1;    // _22
        *p = -scaleW; // _23

        *p = 0;    // _30
        *p = 0;    // _31
        *p = tmp2; // _32
        *p = 0;    // _33
    }

    if (mtx != NULL)
    {
        mtx->_22 = tmp1;
        mtx->_32 = tmp2;
    }
}

void G3i_OrthoW_(fx32 t, fx32 b, fx32 l, fx32 r, fx32 n, fx32 f, fx32 scaleW, BOOL draw, MtxFx44 *mtx)
{
    fx64c inv1, inv2, inv3;
    fx32 tmp1, tmp2, tmp3;
    vs32 *p;

    FX_InvAsync(r - l);
    if (draw)
    {
        G3_MtxMode(GX_MTXMODE_PROJECTION);
        p = (vs32 *)&reg_G3_MTX_LOAD_4x4;
    }

    if (mtx != NULL)
    {
        mtx->_01 = 0;
        mtx->_02 = 0;
        mtx->_03 = 0;

        mtx->_10 = 0;
        mtx->_12 = 0;
        mtx->_13 = 0;

        mtx->_20 = 0;
        mtx->_21 = 0;
        mtx->_23 = 0;

        mtx->_33 = scaleW;
    }

    inv1 = FX_GetInvResultFx64c(); // r - l
    FX_InvAsyncImm(t - b);

    if (scaleW != FX32_ONE)
    {
        inv1 = (inv1 * scaleW) / FX32_ONE;
    }

    // Row 0
    tmp1 = FX_Mul32x64c(FX32_ONE * 2, inv1);
    if (draw)
    {
        *p = tmp1; // _00
        *p = 0;    // _01
        *p = 0;    // _02
        *p = 0;    // _03

        // Row 1
        *p = 0; // _10
    }
    if (mtx != NULL)
    {
        mtx->_00 = tmp1;
    }

    inv2 = FX_GetInvResultFx64c(); // t - b
    FX_InvAsyncImm(n - f);
    if (scaleW != FX32_ONE)
    {
        inv2 = (inv2 * scaleW) / FX32_ONE;
    }

    tmp1 = FX_Mul32x64c(FX32_ONE * 2, inv2);
    if (draw)
    {
        *p = tmp1; // _11
        *p = 0;    // _12
        *p = 0;    // _13

        // Row 2
        *p = 0; // _20
        *p = 0; // _21
    }

    if (mtx != NULL)
    {
        mtx->_11 = tmp1;
    }

    inv3 = FX_GetInvResultFx64c(); // n - f
    if (scaleW != FX32_ONE)
    {
        inv3 = (inv3 * scaleW) / FX32_ONE;
    }

    tmp1 = FX_Mul32x64c(FX32_ONE * 2, inv3);
    if (draw)
    {
        *p = tmp1; // _22
        *p = 0;    // _23
    }

    if (mtx != NULL)
    {
        mtx->_22 = tmp1;
    }

    // Row 3
    tmp1 = FX_Mul32x64c(-r - l, inv1);
    tmp2 = FX_Mul32x64c(-t - b, inv2);
    tmp3 = FX_Mul32x64c(f + n, inv3);
    if (draw)
    {
        *p = tmp1;   // _30
        *p = tmp2;   // _31
        *p = tmp3;   // _32
        *p = scaleW; // _33
    }

    if (mtx != NULL)
    {
        mtx->_30 = tmp1;
        mtx->_31 = tmp2;
        mtx->_32 = tmp3;
    }
}

void G3i_LookAt_(const VecFx32 *camPos, const VecFx32 *camUp, const VecFx32 *target, BOOL draw, MtxFx43 *mtx)
{
    VecFx32 vLook, vRight, vUp;
    fx32 tmp1, tmp2, tmp3;
    vs32 *p;

    // use negative value to look down (-Z) axis
    vLook.x = camPos->x - target->x;
    vLook.y = camPos->y - target->y;
    vLook.z = camPos->z - target->z;
    VEC_Normalize(&vLook, &vLook);

    VEC_CrossProduct(camUp, &vLook, &vRight);
    VEC_Normalize(&vRight, &vRight);

    VEC_CrossProduct(&vLook, &vRight, &vUp);

    if (draw)
    {
        G3_MtxMode(GX_MTXMODE_POSITION_VECTOR);
        p  = (vs32 *)&reg_G3_MTX_LOAD_4x3;
        *p = vRight.x; // _00
        *p = vUp.x;    // _01
        *p = vLook.x;  // _02

        *p = vRight.y; // _10
        *p = vUp.y;    // _11
        *p = vLook.y;  // _12

        *p = vRight.z; // _20
        *p = vUp.z;    // _21
        *p = vLook.z;  // _22
    }
    tmp1 = -VEC_DotProduct(camPos, &vRight);
    tmp2 = -VEC_DotProduct(camPos, &vUp);
    tmp3 = -VEC_DotProduct(camPos, &vLook);

    if (draw)
    {
        *p = tmp1; // _30
        *p = tmp2; // _31
        *p = tmp3; // _32
    }

    if (mtx != NULL)
    {
        mtx->_00 = vRight.x;
        mtx->_01 = vUp.x;
        mtx->_02 = vLook.x;
        mtx->_10 = vRight.y;
        mtx->_11 = vUp.y;
        mtx->_12 = vLook.y;
        mtx->_20 = vRight.z;
        mtx->_21 = vUp.z;
        mtx->_22 = vLook.z;
        mtx->_30 = tmp1;
        mtx->_31 = tmp2;
        mtx->_32 = tmp3;
    }
}