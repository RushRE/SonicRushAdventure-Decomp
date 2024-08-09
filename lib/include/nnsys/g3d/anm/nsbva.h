#ifndef NNSG3D_ANM_NSBVA_H
#define NNSG3D_ANM_NSBVA_H

#include <nnsys/g3d/config.h>
#include <nnsys/g3d/binres/res_struct.h>
#include <nnsys/g3d/kernel.h>
#include <nnsys/g3d/anm.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void NNSi_G3dAnmObjInitNsBva(NNSG3dAnmObj *pAnmObj, void *pResAnm, const NNSG3dResMdl *pResMdl);
void NNSi_G3dAnmCalcNsBva(NNSG3dVisAnmResult *pResult, const NNSG3dAnmObj *pAnmObj, u32 dataIdx);

#ifdef __cplusplus
}
#endif

#endif // NNSG3D_ANM_NSBVA_H
