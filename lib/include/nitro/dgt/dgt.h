#ifndef NITRO_DGT_DGT_H
#define NITRO_DGT_DGT_H

#include <nitro/dgt/common.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct DGTHash1Context
{
    union
    {
        struct
        {
            unsigned long a, b, c, d;
        };
        unsigned long state[4];
    };
    unsigned long long length;
    union
    {
        unsigned long buffer32[16];
        unsigned char buffer8[64];
    };
} DGTHash1Context;

typedef struct DGTHash2Context
{
    unsigned long Intermediate_Hash[5];
    unsigned long Length_Low;
    unsigned long Length_High;
    int Message_Block_Index;
    unsigned char Message_Block[64];
    int Computed;
    int Corrupted;
} DGTHash2Context;

// --------------------
// FUNCTIONS
// --------------------

void DGT_Hash1Reset(DGTHash1Context *ctx);
void DGT_Hash1SetSource(DGTHash1Context *ctx, unsigned char *, unsigned long);
void DGT_Hash1GetDigest_R(unsigned char digest[16], DGTHash1Context *);

void DGT_Hash2Reset(DGTHash2Context *ctx);
void DGT_Hash2SetSource(DGTHash2Context *ctx, unsigned char *, unsigned long);
void DGT_Hash2GetDigest(DGTHash2Context *ctx, unsigned char digest[20]);

void DGT_Hash1CalcHmac(void *digest, void *bin_ptr, int bin_len, void *key_ptr, int key_len);
void DGT_Hash2CalcHmac(void *digest, void *bin_ptr, int bin_len, void *key_ptr, int key_len);

void DGTi_hash2_arm4_small(void *result, void *a2, int a3);

#ifdef __cplusplus
}
#endif

#endif // NITRO_DGT_DGT_H