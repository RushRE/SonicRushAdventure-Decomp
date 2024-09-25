#ifndef G2DI_BITREADER_H
#define G2DI_BITREADER_H

#include <nitro.h>

#include <nnsys/g2d/g2d_config.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct NNSiG2dBitReader
{
    const u8 *src;
    s8 availableBits;
    u8 bits;
    u8 padding_[2];
} NNSiG2dBitReader;

// --------------------
// INLINE FUNCTIONS
// --------------------

NNS_G2D_INLINE void NNSi_G2dBitReaderInit(NNSiG2dBitReader *reader, const void *src)
{
    reader->availableBits = 0;
    reader->src           = (const u8 *)src;
    reader->bits          = 0;
}

NNS_G2D_INLINE void NNSi_G2dBitReaderAlignByte(NNSiG2dBitReader *reader)
{
    reader->availableBits &= 8;
}

// --------------------
// FUNCTIONS
// --------------------

u32 NNSi_G2dBitReaderRead(NNSiG2dBitReader *reader, int nBits);

#ifdef __cplusplus
}
#endif

#endif // G2DI_BITREADER_H