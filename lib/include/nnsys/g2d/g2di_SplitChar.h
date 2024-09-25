#ifndef G2DI_SPLITCHAR_H
#define G2DI_SPLITCHAR_H

#include <nitro.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// TYPES
// --------------------

typedef u16 (*NNSiG2dSplitCharCallback)(const void **ppChar);

// --------------------
// FUNCTIONS
// --------------------

u16 NNSi_G2dSplitCharUTF16(const void **ppChar);
u16 NNSi_G2dSplitCharUTF8(const void **ppChar);
u16 NNSi_G2dSplitCharShiftJIS(const void **ppChar);
u16 NNSi_G2dSplitChar1Byte(const void **ppChar);

#ifdef __cplusplus
}
#endif

#endif // G2DI_SPLITCHAR_H