#ifndef NNS_G2D_CONFIG_H
#define NNS_G2D_CONFIG_H

#include <nnsys/inline.h>
#define NNS_G2D_INLINE NNS_INLINE

#include <nitro.h>

#ifdef __cplusplus
extern "C"
{
#endif

#define NNS_G2D_DMA_NO GX_GetDefaultDMA()

#define NNS_G2D_FONT_USE_OLD_RESOURCE
#define NNS_G2D_FONT_ENABLE_DIRECTION_SUPPORT
#define NNS_G2D_ASSUME_DOUBLEAFFINE_OBJPOS_ADJUSTED

#ifdef __cplusplus
}
#endif

#endif // NNS_G2D_CONFIG_H