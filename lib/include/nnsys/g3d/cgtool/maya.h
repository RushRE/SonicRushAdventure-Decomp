#ifndef NNSG3D_CGTOOL_MAYA_H
#define NNSG3D_CGTOOL_MAYA_H

#include <nnsys/g3d/config.h>
#include <nnsys/g3d/anm.h>
#include <nnsys/g3d/binres/res_struct.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void NNSi_G3dSendJointSRTMaya(const NNSG3dJntAnmResult *result);
void NNSi_G3dGetJointScaleMaya(NNSG3dJntAnmResult *pResult, const fx32 *p, const u8 *cmd, u32 srtflag);
void NNSi_G3dSendTexSRTMaya(const NNSG3dMatAnmResult *anm);

#ifdef __cplusplus
}
#endif

#endif // NNSG3D_CGTOOL_MAYA_H
