#ifndef NNSG3D_CONFIG_H
#define NNSG3D_CONFIG_H

#include <nnsys/inline.h>
#include <nitro.h>

#define NNS_G3D_INLINE NNS_INLINE

#ifndef NNS_G3D_ANMFMT_MAX
#define NNS_G3D_ANMFMT_MAX 10
#endif

#ifndef NNS_G3D_SIZE_JNT_MAX
#define NNS_G3D_SIZE_JNT_MAX 64
#endif

#ifndef NNS_G3D_SIZE_MAT_MAX
#define NNS_G3D_SIZE_MAT_MAX 64
#endif

#ifndef NNS_G3D_SIZE_SHP_MAX
#define NNS_G3D_SIZE_SHP_MAX 64
#endif

#ifndef NNS_G3D_SIZE_COMBUFFER
#define NNS_G3D_SIZE_COMBUFFER 192
#endif

#ifndef NNS_G3D_SIZE_SHP_VTBL_NUM
#define NNS_G3D_SIZE_SHP_VTBL_NUM 4
#endif

#ifndef NNS_G3D_SIZE_MAT_VTBL_NUM
#define NNS_G3D_SIZE_MAT_VTBL_NUM 4
#endif

#ifndef NNS_G3D_FUNC_SENDJOINTSRT_MAX
#define NNS_G3D_FUNC_SENDJOINTSRT_MAX 3
#endif

#ifndef NNS_G3D_FUNC_SENDTEXSRT_MAX
#define NNS_G3D_FUNC_SENDTEXSRT_MAX 4
#endif

#ifndef NNS_G3D_USE_EVPCACHE
#define NNS_G3D_USE_EVPCACHE 1
#endif

#endif // NNSG3D_CONFIG_H
