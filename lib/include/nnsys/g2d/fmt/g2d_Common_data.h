#ifndef NNS_G2D_COMMON_DATA_H
#define NNS_G2D_COMMON_DATA_H

#include <nitro/types.h>
#include <nnsys/g2d/g2d_config.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define NNS_G2D_DUMMY_DATA8  (u8)0xCC
#define NNS_G2D_DUMMY_DATA16 (u16)0xBEEF
#define NNS_G2D_DUMMY_DATA32 (u32)0xDEADBEEF
#define NNS_G2D_DUMMY_PTR    (u32)0x00000000

#define NNS_G2D_BLKSIG_NAMELABEL (u32)('LABL')
#define NNS_G2D_BLKSIG_USEREXT   (u32)('UEXT')

#define NNS_G2D_BIGENDIAN_BITMARK    0xFFFE
#define NNS_G2D_LITTLEENDIAN_BITMARK 0xFEFF

// --------------------
// STRUCTS
// --------------------

typedef struct NNSG2dBinaryFileHeader
{
    u32 signature;
    u16 byteOrder;
    u16 version;
    u32 fileSize;
    u16 headerSize;
    u16 dataBlocks;
} NNSG2dBinaryFileHeader;

typedef struct NNSG2dBinaryBlockHeader
{
    u32 kind;
    u32 size;
} NNSG2dBinaryBlockHeader;

typedef struct NNSG2dUserExDataBlock
{
    u32 blkTypeID;
    u32 blkSize;
} NNSG2dUserExDataBlock;

// --------------------
// INLINE FUNCTIONS
// --------------------

NNS_G2D_INLINE BOOL NNS_G2dIsPad16Valid(u16 pad16)
{
    return (NNS_G2D_DUMMY_DATA16 == pad16) ? TRUE : FALSE;
}

NNS_G2D_INLINE BOOL NNS_G2dIsPad32Valid(u32 pad32)
{
    return (NNS_G2D_DUMMY_DATA32 == pad32) ? TRUE : FALSE;
}

NNS_G2D_INLINE u16 NNS_G2dMakeVersionData(u8 majorVer, u8 minorVer)
{
    return (u16)((u16)majorVer << 8 | ((u16)minorVer & 0x00FF));
}

NNS_G2D_INLINE const NNSG2dUserExDataBlock *NNSi_G2dGetUserExDataBlkByID(const void *pExtendData, u32 blkTypeID)
{
    if (pExtendData != NULL)
    {
        const NNSG2dUserExDataBlock *pBlk = (const NNSG2dUserExDataBlock *)pExtendData;

        if (pBlk->blkTypeID == blkTypeID)
        {
            return pBlk;
        }

        pBlk = (const NNSG2dUserExDataBlock *)((const u8 *)pBlk + pBlk->blkSize);
    }
    return NULL;
}

#ifdef __cplusplus
}
#endif

#endif // NNS_G2D_COMMON_DATA_H