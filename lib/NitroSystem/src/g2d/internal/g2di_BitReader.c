#include <nnsys/g2d/g2d_config.h>

#include "include/g2di_BitReader.h"

// --------------------
// INLINE FUNCTIONS
// --------------------

static NNS_G2D_INLINE void BitReaderReload(NNSiG2dBitReader *reader)
{
    reader->bits          = *(reader->src)++;
    reader->availableBits = 8;
}

// --------------------
// FUNCTIONS
// --------------------

u32 NNSi_G2dBitReaderRead(NNSiG2dBitReader *reader, int nBits)
{
    u32 val      = reader->bits;
    int nAvlBits = reader->availableBits;

    if (nAvlBits < nBits)
    {
        int lack = nBits - nAvlBits;
        val <<= lack;
        BitReaderReload(reader);
        val |= NNSi_G2dBitReaderRead(reader, lack);
    }
    else
    {
        val >>= (nAvlBits - nBits);
        reader->availableBits = (s8)(nAvlBits - nBits);
    }

    val &= 0xFF >> (8 - nBits);
    return val;
}
