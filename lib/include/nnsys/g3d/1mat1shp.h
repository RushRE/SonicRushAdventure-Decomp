#ifndef NNSG3D_1MAT1SHP_H
#define NNSG3D_1MAT1SHP_H

#include <nnsys/g3d/config.h>
#include <nnsys/g3d/binres/res_struct.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void NNS_G3dDraw1Mat1Shp(const NNSG3dResMdl *pResMdl, u32 matID, u32 shpID, BOOL sendMat);

#ifdef __cplusplus
}
#endif

#endif // NNSG3D_1MAT1SHP_H