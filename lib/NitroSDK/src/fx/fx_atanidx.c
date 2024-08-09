#include <nitro.h>

#ifdef SDK_ARM9

// --------------------
// MACROS
// --------------------

#define FLOAT_TO_FX16(n) ((fx16)(n * 4000))

// --------------------
// VARIABLES
// --------------------

const fx16 FX_AtanIdxTable_[128 + 1] = { (u16)0,    // fx16 -> [0], angle -> [TODO]
                                         (u16)81,   // fx16 -> [81], angle -> [TODO]
                                         (u16)163,  // fx16 -> [163], angle -> [TODO]
                                         (u16)244,  // fx16 -> [244], angle -> [TODO]
                                         (u16)326,  // fx16 -> [326], angle -> [TODO]
                                         (u16)407,  // fx16 -> [407], angle -> [TODO]
                                         (u16)489,  // fx16 -> [489], angle -> [TODO]
                                         (u16)570,  // fx16 -> [570], angle -> [TODO]
                                         (u16)651,  // fx16 -> [651], angle -> [TODO]
                                         (u16)732,  // fx16 -> [732], angle -> [TODO]
                                         (u16)813,  // fx16 -> [813], angle -> [TODO]
                                         (u16)894,  // fx16 -> [894], angle -> [TODO]
                                         (u16)975,  // fx16 -> [975], angle -> [TODO]
                                         (u16)1056, // fx16 -> [1056], angle -> [TODO]
                                         (u16)1136, // fx16 -> [1136], angle -> [TODO]
                                         (u16)1217, // fx16 -> [1217], angle -> [TODO]
                                         (u16)1297, // fx16 -> [1297], angle -> [TODO]
                                         (u16)1377, // fx16 -> [1377], angle -> [TODO]
                                         (u16)1457, // fx16 -> [1457], angle -> [TODO]
                                         (u16)1537, // fx16 -> [1537], angle -> [TODO]
                                         (u16)1617, // fx16 -> [1617], angle -> [TODO]
                                         (u16)1696, // fx16 -> [1696], angle -> [TODO]
                                         (u16)1775, // fx16 -> [1775], angle -> [TODO]
                                         (u16)1854, // fx16 -> [1854], angle -> [TODO]
                                         (u16)1933, // fx16 -> [1933], angle -> [TODO]
                                         (u16)2012, // fx16 -> [2012], angle -> [TODO]
                                         (u16)2090, // fx16 -> [2090], angle -> [TODO]
                                         (u16)2168, // fx16 -> [2168], angle -> [TODO]
                                         (u16)2246, // fx16 -> [2246], angle -> [TODO]
                                         (u16)2324, // fx16 -> [2324], angle -> [TODO]
                                         (u16)2401, // fx16 -> [2401], angle -> [TODO]
                                         (u16)2478, // fx16 -> [2478], angle -> [TODO]
                                         (u16)2555, // fx16 -> [2555], angle -> [TODO]
                                         (u16)2632, // fx16 -> [2632], angle -> [TODO]
                                         (u16)2708, // fx16 -> [2708], angle -> [TODO]
                                         (u16)2784, // fx16 -> [2784], angle -> [TODO]
                                         (u16)2860, // fx16 -> [2860], angle -> [TODO]
                                         (u16)2935, // fx16 -> [2935], angle -> [TODO]
                                         (u16)3010, // fx16 -> [3010], angle -> [TODO]
                                         (u16)3085, // fx16 -> [3085], angle -> [TODO]
                                         (u16)3159, // fx16 -> [3159], angle -> [TODO]
                                         (u16)3233, // fx16 -> [3233], angle -> [TODO]
                                         (u16)3307, // fx16 -> [3307], angle -> [TODO]
                                         (u16)3380, // fx16 -> [3380], angle -> [TODO]
                                         (u16)3453, // fx16 -> [3453], angle -> [TODO]
                                         (u16)3526, // fx16 -> [3526], angle -> [TODO]
                                         (u16)3599, // fx16 -> [3599], angle -> [TODO]
                                         (u16)3670, // fx16 -> [3670], angle -> [TODO]
                                         (u16)3742, // fx16 -> [3742], angle -> [TODO]
                                         (u16)3813, // fx16 -> [3813], angle -> [TODO]
                                         (u16)3884, // fx16 -> [3884], angle -> [TODO]
                                         (u16)3955, // fx16 -> [3955], angle -> [TODO]
                                         (u16)4025, // fx16 -> [4025], angle -> [TODO]
                                         (u16)4095, // fx16 -> [4095], angle -> [TODO]
                                         (u16)4164, // fx16 -> [4164], angle -> [TODO]
                                         (u16)4233, // fx16 -> [4233], angle -> [TODO]
                                         (u16)4302, // fx16 -> [4302], angle -> [TODO]
                                         (u16)4370, // fx16 -> [4370], angle -> [TODO]
                                         (u16)4438, // fx16 -> [4438], angle -> [TODO]
                                         (u16)4505, // fx16 -> [4505], angle -> [TODO]
                                         (u16)4572, // fx16 -> [4572], angle -> [TODO]
                                         (u16)4639, // fx16 -> [4639], angle -> [TODO]
                                         (u16)4705, // fx16 -> [4705], angle -> [TODO]
                                         (u16)4771, // fx16 -> [4771], angle -> [TODO]
                                         (u16)4836, // fx16 -> [4836], angle -> [TODO]
                                         (u16)4901, // fx16 -> [4901], angle -> [TODO]
                                         (u16)4966, // fx16 -> [4966], angle -> [TODO]
                                         (u16)5030, // fx16 -> [5030], angle -> [TODO]
                                         (u16)5094, // fx16 -> [5094], angle -> [TODO]
                                         (u16)5157, // fx16 -> [5157], angle -> [TODO]
                                         (u16)5220, // fx16 -> [5220], angle -> [TODO]
                                         (u16)5282, // fx16 -> [5282], angle -> [TODO]
                                         (u16)5344, // fx16 -> [5344], angle -> [TODO]
                                         (u16)5406, // fx16 -> [5406], angle -> [TODO]
                                         (u16)5467, // fx16 -> [5467], angle -> [TODO]
                                         (u16)5528, // fx16 -> [5528], angle -> [TODO]
                                         (u16)5589, // fx16 -> [5589], angle -> [TODO]
                                         (u16)5649, // fx16 -> [5649], angle -> [TODO]
                                         (u16)5708, // fx16 -> [5708], angle -> [TODO]
                                         (u16)5768, // fx16 -> [5768], angle -> [TODO]
                                         (u16)5826, // fx16 -> [5826], angle -> [TODO]
                                         (u16)5885, // fx16 -> [5885], angle -> [TODO]
                                         (u16)5943, // fx16 -> [5943], angle -> [TODO]
                                         (u16)6000, // fx16 -> [6000], angle -> [TODO]
                                         (u16)6058, // fx16 -> [6058], angle -> [TODO]
                                         (u16)6114, // fx16 -> [6114], angle -> [TODO]
                                         (u16)6171, // fx16 -> [6171], angle -> [TODO]
                                         (u16)6227, // fx16 -> [6227], angle -> [TODO]
                                         (u16)6282, // fx16 -> [6282], angle -> [TODO]
                                         (u16)6337, // fx16 -> [6337], angle -> [TODO]
                                         (u16)6392, // fx16 -> [6392], angle -> [TODO]
                                         (u16)6446, // fx16 -> [6446], angle -> [TODO]
                                         (u16)6500, // fx16 -> [6500], angle -> [TODO]
                                         (u16)6554, // fx16 -> [6554], angle -> [TODO]
                                         (u16)6607, // fx16 -> [6607], angle -> [TODO]
                                         (u16)6660, // fx16 -> [6660], angle -> [TODO]
                                         (u16)6712, // fx16 -> [6712], angle -> [TODO]
                                         (u16)6764, // fx16 -> [6764], angle -> [TODO]
                                         (u16)6815, // fx16 -> [6815], angle -> [TODO]
                                         (u16)6867, // fx16 -> [6867], angle -> [TODO]
                                         (u16)6917, // fx16 -> [6917], angle -> [TODO]
                                         (u16)6968, // fx16 -> [6968], angle -> [TODO]
                                         (u16)7018, // fx16 -> [7018], angle -> [TODO]
                                         (u16)7068, // fx16 -> [7068], angle -> [TODO]
                                         (u16)7117, // fx16 -> [7117], angle -> [TODO]
                                         (u16)7166, // fx16 -> [7166], angle -> [TODO]
                                         (u16)7214, // fx16 -> [7214], angle -> [TODO]
                                         (u16)7262, // fx16 -> [7262], angle -> [TODO]
                                         (u16)7310, // fx16 -> [7310], angle -> [TODO]
                                         (u16)7358, // fx16 -> [7358], angle -> [TODO]
                                         (u16)7405, // fx16 -> [7405], angle -> [TODO]
                                         (u16)7451, // fx16 -> [7451], angle -> [TODO]
                                         (u16)7498, // fx16 -> [7498], angle -> [TODO]
                                         (u16)7544, // fx16 -> [7544], angle -> [TODO]
                                         (u16)7589, // fx16 -> [7589], angle -> [TODO]
                                         (u16)7635, // fx16 -> [7635], angle -> [TODO]
                                         (u16)7679, // fx16 -> [7679], angle -> [TODO]
                                         (u16)7724, // fx16 -> [7724], angle -> [TODO]
                                         (u16)7768, // fx16 -> [7768], angle -> [TODO]
                                         (u16)7812, // fx16 -> [7812], angle -> [TODO]
                                         (u16)7856, // fx16 -> [7856], angle -> [TODO]
                                         (u16)7899, // fx16 -> [7899], angle -> [TODO]
                                         (u16)7942, // fx16 -> [7942], angle -> [TODO]
                                         (u16)7984, // fx16 -> [7984], angle -> [TODO]
                                         (u16)8026, // fx16 -> [8026], angle -> [TODO]
                                         (u16)8068, // fx16 -> [8068], angle -> [TODO]
                                         (u16)8110, // fx16 -> [8110], angle -> [TODO]
                                         (u16)8151, // fx16 -> [8151], angle -> [TODO]
                                         (u16)8192 };

// --------------------
// FUNCTIONS
// --------------------

u16 FX_AtanIdx(fx32 x)
{
    if (x >= 0)
    {
        if (x > FX32_ONE)
        {
            return (u16)(16384 - FX_AtanIdxTable_[FX_Inv(x) >> 5]);
        }
        else if (x < FX32_ONE)
        {
            return (u16)FX_AtanIdxTable_[x >> 5];
        }
        else
        {
            return (u16)8192;
        }
    }
    else // if x < 0
    {
        if (x < -FX32_ONE)
        {
            return (u16)(-16384 + FX_AtanIdxTable_[FX_Inv(-x) >> 5]);
        }
        else if (x > -FX32_ONE)
        {
            return (u16)-FX_AtanIdxTable_[-x >> 5];
        }
        else
        {
            return (u16)-8192;
        }
    }
}

u16 FX_Atan2Idx(fx32 y, fx32 x)
{
    fx32 a, b;
    int c;
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
                c   = 16384;
                sgn = 0;
            }
            else
            {
                return (u16)8192;
            }
        }
        else if (x < 0)
        {
            x = -x;
            if (x < y)
            {
                a   = x;
                b   = y;
                c   = 16384;
                sgn = 1;
            }
            else if (x > y)
            {
                a   = y;
                b   = x;
                c   = 32768;
                sgn = 0;
            }
            else
            {
                return (u16)24576;
            }
        }
        else
        {
            return (u16)16384;
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
                c   = -32768;
                sgn = 1;
            }
            else if (x < y)
            {
                a   = x;
                b   = y;
                c   = -16384;
                sgn = 0;
            }
            else
            {
                return (u16)-24576;
            }
        }
        else if (x > 0)
        {
            if (x < y)
            {
                a   = x;
                b   = y;
                c   = -16384;
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
                return (u16)-8192;
            }
        }
        else
        {
            return (u16)-16384;
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
            return (u16)32768;
        }
    }

    if (b == 0)
        return 0;

    if (sgn)
        return (u16)(c + FX_AtanIdxTable_[FX_Div(a, b) >> 5]);
    else
        return (u16)(c - FX_AtanIdxTable_[FX_Div(a, b) >> 5]);
}

#endif