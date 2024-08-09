#include <nitro.h>

#ifdef SDK_ARM9

// --------------------
// MACROS
// --------------------

#define FLOAT_TO_FX16(n) ((fx16)(n * 4000))

// --------------------
// VARIABLES
// --------------------

const fx16 FX_AtanTable_[128 + 1] = {
    (fx16)0x0000, // fx16 -> [0x0000], angle -> 0.000
    (fx16)0x0020, // fx16 -> [0x0020], angle -> 0.008
    (fx16)0x0040, // fx16 -> [0x0040], angle -> 0.016
    (fx16)0x0060, // fx16 -> [0x0060], angle -> 0.023
    (fx16)0x0080, // fx16 -> [0x0080], angle -> 0.031
    (fx16)0x00a0, // fx16 -> [0x00a0], angle -> 0.039
    (fx16)0x00c0, // fx16 -> [0x00c0], angle -> 0.047
    (fx16)0x00e0, // fx16 -> [0x00e0], angle -> 0.055
    (fx16)0x0100, // fx16 -> [0x0100], angle -> 0.062
    (fx16)0x0120, // fx16 -> [0x0120], angle -> 0.070
    (fx16)0x013f, // fx16 -> [0x013f], angle -> 0.078
    (fx16)0x015f, // fx16 -> [0x015f], angle -> 0.086
    (fx16)0x017f, // fx16 -> [0x017f], angle -> 0.094
    (fx16)0x019f, // fx16 -> [0x019f], angle -> 0.101
    (fx16)0x01be, // fx16 -> [0x01be], angle -> 0.109
    (fx16)0x01de, // fx16 -> [0x01de], angle -> 0.117
    (fx16)0x01fd, // fx16 -> [0x01fd], angle -> 0.124
    (fx16)0x021d, // fx16 -> [0x021d], angle -> 0.132
    (fx16)0x023c, // fx16 -> [0x023c], angle -> 0.140
    (fx16)0x025c, // fx16 -> [0x025c], angle -> 0.147
    (fx16)0x027b, // fx16 -> [0x027b], angle -> 0.155
    (fx16)0x029a, // fx16 -> [0x029a], angle -> 0.163
    (fx16)0x02b9, // fx16 -> [0x02b9], angle -> 0.170
    (fx16)0x02d8, // fx16 -> [0x02d8], angle -> 0.178
    (fx16)0x02f7, // fx16 -> [0x02f7], angle -> 0.185
    (fx16)0x0316, // fx16 -> [0x0316], angle -> 0.193
    (fx16)0x0335, // fx16 -> [0x0335], angle -> 0.200
    (fx16)0x0354, // fx16 -> [0x0354], angle -> 0.208
    (fx16)0x0372, // fx16 -> [0x0372], angle -> 0.215
    (fx16)0x0391, // fx16 -> [0x0391], angle -> 0.223
    (fx16)0x03af, // fx16 -> [0x03af], angle -> 0.230
    (fx16)0x03cd, // fx16 -> [0x03cd], angle -> 0.238
    (fx16)0x03eb, // fx16 -> [0x03eb], angle -> 0.245
    (fx16)0x0409, // fx16 -> [0x0409], angle -> 0.252
    (fx16)0x0427, // fx16 -> [0x0427], angle -> 0.260
    (fx16)0x0445, // fx16 -> [0x0445], angle -> 0.267
    (fx16)0x0463, // fx16 -> [0x0463], angle -> 0.274
    (fx16)0x0481, // fx16 -> [0x0481], angle -> 0.281
    (fx16)0x049e, // fx16 -> [0x049e], angle -> 0.289
    (fx16)0x04bb, // fx16 -> [0x04bb], angle -> 0.296
    (fx16)0x04d9, // fx16 -> [0x04d9], angle -> 0.303
    (fx16)0x04f6, // fx16 -> [0x04f6], angle -> 0.310
    (fx16)0x0513, // fx16 -> [0x0513], angle -> 0.317
    (fx16)0x052f, // fx16 -> [0x052f], angle -> 0.324
    (fx16)0x054c, // fx16 -> [0x054c], angle -> 0.331
    (fx16)0x0569, // fx16 -> [0x0569], angle -> 0.338
    (fx16)0x0585, // fx16 -> [0x0585], angle -> 0.345
    (fx16)0x05a1, // fx16 -> [0x05a1], angle -> 0.352
    (fx16)0x05be, // fx16 -> [0x05be], angle -> 0.359
    (fx16)0x05da, // fx16 -> [0x05da], angle -> 0.366
    (fx16)0x05f5, // fx16 -> [0x05f5], angle -> 0.372
    (fx16)0x0611, // fx16 -> [0x0611], angle -> 0.379
    (fx16)0x062d, // fx16 -> [0x062d], angle -> 0.386
    (fx16)0x0648, // fx16 -> [0x0648], angle -> 0.393
    (fx16)0x0663, // fx16 -> [0x0663], angle -> 0.399
    (fx16)0x067e, // fx16 -> [0x067e], angle -> 0.406
    (fx16)0x0699, // fx16 -> [0x0699], angle -> 0.412
    (fx16)0x06b4, // fx16 -> [0x06b4], angle -> 0.419
    (fx16)0x06cf, // fx16 -> [0x06cf], angle -> 0.426
    (fx16)0x06e9, // fx16 -> [0x06e9], angle -> 0.432
    (fx16)0x0703, // fx16 -> [0x0703], angle -> 0.438
    (fx16)0x071e, // fx16 -> [0x071e], angle -> 0.445
    (fx16)0x0738, // fx16 -> [0x0738], angle -> 0.451
    (fx16)0x0751, // fx16 -> [0x0751], angle -> 0.457
    (fx16)0x076b, // fx16 -> [0x076b], angle -> 0.464
    (fx16)0x0785, // fx16 -> [0x0785], angle -> 0.470
    (fx16)0x079e, // fx16 -> [0x079e], angle -> 0.476
    (fx16)0x07b7, // fx16 -> [0x07b7], angle -> 0.482
    (fx16)0x07d0, // fx16 -> [0x07d0], angle -> 0.488
    (fx16)0x07e9, // fx16 -> [0x07e9], angle -> 0.494
    (fx16)0x0802, // fx16 -> [0x0802], angle -> 0.500
    (fx16)0x081a, // fx16 -> [0x081a], angle -> 0.506
    (fx16)0x0833, // fx16 -> [0x0833], angle -> 0.512
    (fx16)0x084b, // fx16 -> [0x084b], angle -> 0.518
    (fx16)0x0863, // fx16 -> [0x0863], angle -> 0.524
    (fx16)0x087b, // fx16 -> [0x087b], angle -> 0.530
    (fx16)0x0893, // fx16 -> [0x0893], angle -> 0.536
    (fx16)0x08aa, // fx16 -> [0x08aa], angle -> 0.542
    (fx16)0x08c2, // fx16 -> [0x08c2], angle -> 0.547
    (fx16)0x08d9, // fx16 -> [0x08d9], angle -> 0.553
    (fx16)0x08f0, // fx16 -> [0x08f0], angle -> 0.559
    (fx16)0x0907, // fx16 -> [0x0907], angle -> 0.564
    (fx16)0x091e, // fx16 -> [0x091e], angle -> 0.570
    (fx16)0x0934, // fx16 -> [0x0934], angle -> 0.575
    (fx16)0x094b, // fx16 -> [0x094b], angle -> 0.581
    (fx16)0x0961, // fx16 -> [0x0961], angle -> 0.586
    (fx16)0x0977, // fx16 -> [0x0977], angle -> 0.592
    (fx16)0x098d, // fx16 -> [0x098d], angle -> 0.597
    (fx16)0x09a3, // fx16 -> [0x09a3], angle -> 0.602
    (fx16)0x09b9, // fx16 -> [0x09b9], angle -> 0.608
    (fx16)0x09ce, // fx16 -> [0x09ce], angle -> 0.613
    (fx16)0x09e3, // fx16 -> [0x09e3], angle -> 0.618
    (fx16)0x09f9, // fx16 -> [0x09f9], angle -> 0.623
    (fx16)0x0a0e, // fx16 -> [0x0a0e], angle -> 0.628
    (fx16)0x0a23, // fx16 -> [0x0a23], angle -> 0.634
    (fx16)0x0a37, // fx16 -> [0x0a37], angle -> 0.638
    (fx16)0x0a4c, // fx16 -> [0x0a4c], angle -> 0.644
    (fx16)0x0a60, // fx16 -> [0x0a60], angle -> 0.648
    (fx16)0x0a74, // fx16 -> [0x0a74], angle -> 0.653
    (fx16)0x0a89, // fx16 -> [0x0a89], angle -> 0.658
    (fx16)0x0a9c, // fx16 -> [0x0a9c], angle -> 0.663
    (fx16)0x0ab0, // fx16 -> [0x0ab0], angle -> 0.668
    (fx16)0x0ac4, // fx16 -> [0x0ac4], angle -> 0.673
    (fx16)0x0ad7, // fx16 -> [0x0ad7], angle -> 0.677
    (fx16)0x0aeb, // fx16 -> [0x0aeb], angle -> 0.682
    (fx16)0x0afe, // fx16 -> [0x0afe], angle -> 0.687
    (fx16)0x0b11, // fx16 -> [0x0b11], angle -> 0.692
    (fx16)0x0b24, // fx16 -> [0x0b24], angle -> 0.696
    (fx16)0x0b37, // fx16 -> [0x0b37], angle -> 0.701
    (fx16)0x0b49, // fx16 -> [0x0b49], angle -> 0.705
    (fx16)0x0b5c, // fx16 -> [0x0b5c], angle -> 0.710
    (fx16)0x0b6e, // fx16 -> [0x0b6e], angle -> 0.714
    (fx16)0x0b80, // fx16 -> [0x0b80], angle -> 0.719
    (fx16)0x0b92, // fx16 -> [0x0b92], angle -> 0.723
    (fx16)0x0ba4, // fx16 -> [0x0ba4], angle -> 0.728
    (fx16)0x0bb6, // fx16 -> [0x0bb6], angle -> 0.732
    (fx16)0x0bc8, // fx16 -> [0x0bc8], angle -> 0.736
    (fx16)0x0bd9, // fx16 -> [0x0bd9], angle -> 0.740
    (fx16)0x0beb, // fx16 -> [0x0beb], angle -> 0.745
    (fx16)0x0bfc, // fx16 -> [0x0bfc], angle -> 0.749
    (fx16)0x0c0d, // fx16 -> [0x0c0d], angle -> 0.753
    (fx16)0x0c1e, // fx16 -> [0x0c1e], angle -> 0.757
    (fx16)0x0c2f, // fx16 -> [0x0c2f], angle -> 0.761
    (fx16)0x0c3f, // fx16 -> [0x0c3f], angle -> 0.765
    (fx16)0x0c50, // fx16 -> [0x0c50], angle -> 0.770
    (fx16)0x0c60, // fx16 -> [0x0c60], angle -> 0.773
    (fx16)0x0c71, // fx16 -> [0x0c71], angle -> 0.778
    (fx16)0x0c81, // fx16 -> [0x0c81], angle -> 0.781
    (fx16)0x0c91  // 0.785
};

// --------------------
// FUNCTIONS
// --------------------

fx16 FX_Atan(fx32 x)
{
    if (x >= 0)
    {
        if (x > FX32_ONE)
        {
            return (fx16)(6434 - FX_AtanTable_[FX_Inv(x) >> 5]);
        }
        else if (x < FX32_ONE)
        {
            return FX_AtanTable_[x >> 5];
        }
        else
        {
            return (fx16)3217;
        }
    }
    else // if x < 0
    {
        if (x < -FX32_ONE)
        {
            return (fx16)(-6434 + FX_AtanTable_[FX_Inv(-x) >> 5]);
        }
        else if (x > -FX32_ONE)
        {
            return (fx16)-FX_AtanTable_[-x >> 5];
        }
        else
        {
            return (fx16)-3217;
        }
    }
}

fx16 FX_Atan2(fx32 y, fx32 x)
{
    fx32 a, b, c;
    int sgn;

    if (y > 0)
    {
        if (x > 0)
        {
            if (x > y)
            {
                a   = y;
                b   = x;
                c   = 0;
                sgn = 1;
            }
            else if (x < y)
            {
                a   = x;
                b   = y;
                c   = 6434;
                sgn = 0;
            }
            else
            {
                return (fx16)3217;
            }
        }
        else if (x < 0)
        {
            x = -x;
            if (x < y)
            {
                a   = x;
                b   = y;
                c   = 6434;
                sgn = 1;
            }
            else if (x > y)
            {
                a   = y;
                b   = x;
                c   = 12868;
                sgn = 0;
            }
            else
            {
                return (fx16)9651;
            }
        }
        else
        {
            return (fx16)6434;
        }
    }
    else if (y < 0)
    {
        y = -y;
        if (x < 0)
        {
            x = -x;
            if (x > y)
            {
                a   = y;
                b   = x;
                c   = -12868;
                sgn = 1;
            }
            else if (x < y)
            {
                a   = x;
                b   = y;
                c   = -6434;
                sgn = 0;
            }
            else
            {
                return (fx16)-9651;
            }
        }
        else if (x > 0)
        {
            if (x < y)
            {
                a   = x;
                b   = y;
                c   = -6434;
                sgn = 1;
            }
            else if (x > y)
            {
                a   = y;
                b   = x;
                c   = 0;
                sgn = 0;
            }
            else
            {
                return (fx16)-3217;
            }
        }
        else
        {
            return (fx16)-6434;
        }
    }
    else // if y == 0
    {
        if (x >= 0)
        {
            return 0;
        }
        else
        {
            return (fx16)12868;
        }
    }

    if (b == 0)
        return 0;

    if (sgn)
        return (fx16)(c + FX_AtanTable_[FX_Div(a, b) >> 5]);
    else
        return (fx16)(c - FX_AtanTable_[FX_Div(a, b) >> 5]);
}

#endif