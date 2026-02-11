#include <game/math/akMath.h>
#include <game/math/mtMath.h>

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE s16 CP_GetDivResult16()
{
    CP_WaitDiv(); 
    return (s16)(*(REGType16 *)REG_DIV_RESULT_ADDR);
}

// --------------------
// FUNCTIONS
// --------------------

BOOL AkMath__Func_2002C40(NNSG3dRS *rs, s32 num, const NNSG3dResName *name)
{
    s32 targetNode = NNS_G3dGetResDictIdxByName(&rs->pRenderObj->resMdl->nodeInfo.dict, name);
    s32 curNode    = NNS_G3dRSGetCurrentNodeDescID(rs);

    if (targetNode != curNode)
        return FALSE;

    NNS_G3dGeStoreMtx(num);

    return TRUE;
}

void AkMath__Func_2002C98(s32 radiusX, s32 radiusY, fx32 *x, fx32 *y, u16 angle)
{
    *x = MultiplyFX(radiusX, CosFX(angle)) - MultiplyFX(radiusY, SinFX(angle));
    *y = MultiplyFX(radiusX, SinFX(angle)) + MultiplyFX(radiusY, CosFX(angle));
}

u16 AkMath__Func_2002D28(u16 angle, u16 targetAngle, s16 percent)
{
    u16 angleDist;

    if (angle == targetAngle)
        return targetAngle;

    if (percent >= 0)
        angleDist = targetAngle - angle;
    else
        angleDist = angle - targetAngle;

    if (angleDist > MATH_ABS(percent))
    {
        angle = angle + percent;
    }
    else
    {
        angle = targetAngle;
    }
    return angle;
}

void AkMath__BlendColors(GXRgb *colorPtr, GXRgb inputColor0, GXRgb inputColor1, s32 count, s32 id)
{
    s32 diff;
    s32 r0;
    s32 r1;
    s32 b0;
    s32 b1;
    s32 g0;
    s32 g1;
    s32 finalR;
    u16 finalG;
    u16 finalB;
    
    diff = count - id;

    // red
    r1 = (inputColor1 & GX_RGB_R_MASK) * id;
    r0 = (inputColor0 & GX_RGB_R_MASK) * diff;
    r0 += r1;

    // green
    g0 = ((inputColor1 & GX_RGB_G_MASK) >> GX_RGB_G_SHIFT) * id;
    g1 = ((inputColor0 & GX_RGB_G_MASK) >> GX_RGB_G_SHIFT) * diff;
    g1 += g0;
    
    CP_SetDiv32_32(r0, count);
    finalR = (u16)CP_GetDivResult16();
    finalR &= GX_RGB_R_MASK;
    
    CP_SetDiv32_32(g1, count);
    
    // blue
    b0 = ((inputColor1 & GX_RGB_B_MASK) >> GX_RGB_B_SHIFT) * id;
    b1 = ((inputColor0 & GX_RGB_B_MASK) >> GX_RGB_B_SHIFT) * diff;
    b1 += b0;

    finalG = CP_GetDivResult16();
    CP_SetDiv32_32(b1, count);
    
    *colorPtr = finalR | ((finalG << GX_RGB_G_SHIFT) & GX_RGB_G_MASK);
    finalB = CP_GetDivResult16();
    
    *colorPtr |= (u16)(finalB << GX_RGB_B_SHIFT & GX_RGB_B_MASK);
}
