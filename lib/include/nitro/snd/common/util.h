#ifndef NITRO_SND_COMMON_UTIL_H
#define NITRO_SND_COMMON_UTIL_H

#include <nitro/types.h>
#include <nitro/misc.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define SND_PITCH_DIVISION_BIT   6
#define SND_PITCH_DIVISION_RANGE (1 << SND_PITCH_DIVISION_BIT)

#define SND_PITCH_TABLE_SIZE  (12 * SND_PITCH_DIVISION_RANGE)
#define SND_PITCH_TABLE_BIAS  0x10000
#define SND_PITCH_TABLE_SHIFT 16

#define SND_VOLUME_DB_MIN     (-723)
#define SND_VOLUME_DB_MAX     0
#define SND_VOLUME_TABLE_SIZE (SND_VOLUME_DB_MAX - SND_VOLUME_DB_MIN + 1)

#define SND_CALC_DECIBEL_SCALE_MAX 127

#define SND_DECIBEL_TABLE_SIZE        128
#define SND_DECIBEL_SQUARE_TABLE_SIZE 128

#define SND_SIN_TABLE_SIZE 32
#define SND_SIN_PERIOD     (SND_SIN_TABLE_SIZE * 4)

// --------------------
// VARIABLES
// --------------------

extern const s16 SNDi_DecibelTable[SND_DECIBEL_TABLE_SIZE];
extern const s16 SNDi_DecibelSquareTable[SND_DECIBEL_SQUARE_TABLE_SIZE];

// --------------------
// INLINE FUNCTIONS
// --------------------

static inline s16 SND_CalcDecibel(int scale)
{
    return SNDi_DecibelTable[scale];
}

static inline s16 SND_CalcDecibelSquare(int scale)
{
    return SNDi_DecibelSquareTable[scale];
}

// --------------------
// FUNCTIONS
// --------------------

u16 SND_CalcTimer(int orgTimer, int pitch);
u16 SND_CalcChannelVolume(int dB);

#ifdef SDK_ARM7

u16 SND_CalcRandom(void);
s8 SND_SinIdx(int index);

#endif // SDK_ARM7

#ifdef __cplusplus
}
#endif

#endif // NITRO_SND_COMMON_UTIL_H
