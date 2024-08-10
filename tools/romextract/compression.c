#include "compression.h"

// --------------------
// FUNCTIONS
// --------------------

static void WriteU32LE(uint8_t *uncompressedData, int32_t* dstPos, uint32_t* buff, int *buffPos)
{
    uncompressedData[*dstPos + 3] = ((*buff) >> 24) & 0xFF;
    uncompressedData[*dstPos + 2] = ((*buff) >> 16) & 0xFF;
    uncompressedData[*dstPos + 1] = ((*buff) >> 8) & 0xFF;
    uncompressedData[*dstPos + 0] = ((*buff) >> 0) & 0xFF;
    *dstPos += 4;

    *buff = 0;
    *buffPos = 0;
}

static uint32_t ReadU32LE(uint8_t *compressedData, int *pos)
{
    uint32_t tmp = compressedData[*pos + 0];
    tmp |= compressedData[*pos + 1] << 8;
    tmp |= compressedData[*pos + 2] << 16;
    tmp |= compressedData[*pos + 3] << 24;
    (*pos) += 4;

    return tmp;
}

uint8_t* TryDecompress(uint8_t* fileData, size_t compressedSize, uint8_t* compression, size_t *uncompressedSize)
{
#define NONE_TAG  0x00
#define LZ10_TAG  0x10
#define HUFF_TAG  0x20
#define RLE_TAG  0x30

    if (fileData == NULL)
        return NULL;

    *compression = fileData[0];
    *uncompressedSize = 0;

    switch (*compression & 0xF0)
    {
    default:
        *compression = 0xFF; // no compression at all
        return NULL;

    case NONE_TAG:
        return NULL;

    case LZ10_TAG:
        for (int i = 0; i < 3; i++)
            *uncompressedSize += fileData[1 + i] << (i * 8);

        if (*uncompressedSize == 0)
            return NULL; // likely invalid compression

        return ReadLZ77(fileData + 4, *uncompressedSize);

    case HUFF_TAG:
        for (int i = 0; i < 3; i++)
            *uncompressedSize += fileData[1 + i] << (i * 8);

        if (*uncompressedSize == 0)
            return NULL; // likely invalid compression

        // handle some format signatures that may clash with compression signature checks
        if (*compression == '#')
        {
            if (((*uncompressedSize >> 0) & 0xFF) == 'B' && ((*uncompressedSize >> 8) & 0xFF) == 'P' && ((*uncompressedSize >> 16) & 0xFF) == 'A')
            {
                *compression = 0xFF; // no compression at all
                return NULL;
            }

            if (((*uncompressedSize >> 0) & 0xFF) == 'M' && ((*uncompressedSize >> 8) & 0xFF) == 'C' && ((*uncompressedSize >> 16) & 0xFF) == 'F')
            {
                *compression = 0xFF; // no compression at all
                return NULL;
            }

            if (((*uncompressedSize >> 0) & 0xFF) == 'F' && ((*uncompressedSize >> 8) & 0xFF) == 'N' && ((*uncompressedSize >> 16) & 0xFF) == 'T')
            {
                *compression = 0xFF; // no compression at all
                return NULL;
            }
        }

        return ReadHuff(fileData, *compression, compressedSize, *uncompressedSize);

    case RLE_TAG:
        for (int i = 0; i < 3; i++)
            *uncompressedSize += fileData[1 + i] << (i * 8);

        if (*uncompressedSize == 0)
            return NULL; // likely invalid compression

        return ReadRLE(fileData + 4, *uncompressedSize);
    }

}

uint8_t* ReadLZ77(uint8_t* compressedData, size_t uncompressedSize)
{
    uint8_t* uncompressedData = malloc(uncompressedSize);
    memset(uncompressedData, 0, uncompressedSize);

    int32_t pos = 0;
    while (pos < uncompressedSize)
    {
        uint8_t flags = *compressedData++;

        for (uint8_t r = 0; r < 8; ++r)
        {
            if ((flags & 0x80) != 0)
            {
                // info is big-endian
                uint8_t b1 = *compressedData++;
                uint8_t b2 = *compressedData++;
                int info = (b1 << 8) | (b2 << 0);

                int count = 3 + ((info >> 12) & 0xF);
                int disp = info & 0xFFF;

                int ptr = pos - disp - 1;
                for (int i = 0; i < count; i++)
                {
                    uncompressedData[pos++] = uncompressedData[ptr++];

                    if (pos >= uncompressedSize)
                        break;
                }
            }
            else
            {
                uncompressedData[pos++] = *compressedData++;
            }

            flags <<= 1;

            if (pos >= uncompressedSize)
                break;
        }
    }

    return uncompressedData;
}

uint8_t* ReadHuff(uint8_t* compressedData, uint8_t compression, size_t compressedSize, size_t uncompressedSize)
{
    uint8_t* uncompressedData = malloc(uncompressedSize);
    memset(uncompressedData, 0, uncompressedSize);

    uint8_t bitDepth = compression & 15;
    if (bitDepth != 4 && bitDepth != 8)
        return NULL;

    size_t destSize = uncompressedSize;

    int treePos = 5;
    int treeSize = (compressedData[4] + 1) * 2;
    int srcPos = 4 + treeSize;
    int curValPos = 0;
    uint32_t destTmp = 0;
    uint32_t window;

    int32_t dstPos = 0;
    while (true)
    {
        if (srcPos >= compressedSize)
            break;

        window = ReadU32LE(compressedData, &srcPos);
        for (int i = 0; i < 32; i++)
        {
            int curBit = (int)((window >> 31) & 1);
            uint8_t treeView = compressedData[treePos];
            bool isLeaf = ((treeView << curBit) & 0x80) != 0;
            treePos &= ~1; // align
            treePos += ((treeView & 0x3F) + 1) * 2 + curBit;
            if (isLeaf)
            {
                destTmp >>= bitDepth;
                destTmp |= (uint32_t)(compressedData[treePos] << (32 - bitDepth));
                curValPos++;
                if (curValPos == (32 / bitDepth))
                {
                    WriteU32LE(uncompressedData, &dstPos, &destTmp, &curValPos);
                    if (dstPos == destSize)
                    {
                        return uncompressedData;
                    }
                }
                treePos = 5;
            }
            window <<= 1;
        }
    }

    return NULL;
}

uint8_t* ReadRLE(uint8_t* compressedData, size_t uncompressedSize)
{
    const uint32_t MAX_OUTSIZE = 0xA00000;

    if (uncompressedSize > MAX_OUTSIZE || uncompressedSize == 0)
        return NULL;

    uint8_t* uncompressedData = malloc(uncompressedSize);
    memset(uncompressedData, 0, uncompressedSize);


    size_t curr_size = 0;
    while (true)
    {
        uint8_t flag = *compressedData++;

        bool compressed = (flag & 0x80) > 0;
        
        uint8_t rl = flag & 0x7F;
        if (compressed)
            rl += 3;
        else
            rl += 1;

        if (compressed)
        {
            uint8_t b = *compressedData++;

            for (int i = 0; i < rl; i++)
            {
                uncompressedData[curr_size++] = b;
            }
        }
        else
        {
            for (int i = 0; i < rl; i++)
            {
                uncompressedData[curr_size++] = *compressedData++;
            }
        }

        if (curr_size > uncompressedSize)
        {
            break; // invalid size
        }

        if (curr_size == uncompressedSize)
            break;
    }

    return uncompressedData;
}