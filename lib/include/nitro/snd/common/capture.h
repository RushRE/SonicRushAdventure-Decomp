#ifndef NITRO_SND_COMMON_CAPTURE_H
#define NITRO_SND_COMMON_CAPTURE_H

#include <nitro/types.h>

#ifdef SDK_ARM7

#include <nitro/hw/ARM7/io_reg.h>

#endif // SDK_ARM7

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define SND_CAPTURE_NUM 2

#ifndef SDK_TEG

#define SND_CAPTURE_0_OUT_CHANNEL 1
#define SND_CAPTURE_1_OUT_CHANNEL 3

#define SND_CAPTURE_0_IN_CHANNEL 0
#define SND_CAPTURE_1_IN_CHANNEL 2

#define SND_CAPTURE_LEN_MAX 0xffff

#else

#define SND_CAPTURE_0_OUT_CHANNEL 3
#define SND_CAPTURE_1_OUT_CHANNEL 1

#define SND_CAPTURE_0_IN_CHANNEL 2
#define SND_CAPTURE_1_IN_CHANNEL 0

#define SND_CAPTURE_LEN_MAX 0x0fff

#endif

#define SND_CAPTURE_DAD_MASK 0x07fffffc

#define SND_CAPTURE_REG_OFFSET 0x8

// --------------------
// ENUMS
// --------------------

#ifndef SDK_TEG
typedef enum
{
    SND_CAPTURE_0,
    SND_CAPTURE_1
} SNDCapture;
#else
typedef enum
{
    SND_CAPTURE_1,
    SND_CAPTURE_0
} SNDCapture;
#endif

typedef enum
{
    SND_CAPTURE_FORMAT_PCM16,
    SND_CAPTURE_FORMAT_PCM8
} SNDCaptureFormat;

typedef enum
{
    SND_CAPTURE_REPEAT_YES,
    SND_CAPTURE_REPEAT_NO
} SNDCaptureRepeat;

typedef enum
{
    SND_CAPTURE_IN_MIXER,
    SND_CAPTURE_IN_CHANNEL,

    SND_CAPTURE_IN_MIXER_L  = SND_CAPTURE_IN_MIXER,
    SND_CAPTURE_IN_MIXER_R  = SND_CAPTURE_IN_MIXER,
    SND_CAPTURE_IN_CHANNEL0 = SND_CAPTURE_IN_CHANNEL,
    SND_CAPTURE_IN_CHANNEL2 = SND_CAPTURE_IN_CHANNEL
} SNDCaptureIn;

typedef enum
{
    SND_CAPTURE_OUT_NORMAL,
    SND_CAPTURE_OUT_CHANNEL_MIX,

    SND_CAPTURE_OUT_CHANNEL0_MIX = SND_CAPTURE_OUT_CHANNEL_MIX,
    SND_CAPTURE_OUT_CHANNEL2_MIX = SND_CAPTURE_OUT_CHANNEL_MIX
} SNDCaptureOut;

// --------------------
// INLINE FUNCTIONS
// --------------------

#ifdef SDK_ARM7

static inline void SND_StartCapture(SNDCapture capture)
{
    REGType8v *reg = (REGType8v *)(REG_SNDCAP0CNT_ADDR + capture);

    *reg |= REG_SND_SNDCAP0CNT_E_MASK;
}

static inline void SND_StartCaptureBoth(void)
{
    reg_SND_SNDCAPCNT |= REG_SND_SNDCAPCNT_CAP0_E_MASK | REG_SND_SNDCAPCNT_CAP1_E_MASK;
}

static inline void SND_StopCapture(SNDCapture capture)
{
    (*(REGType8v *)(REG_SNDCAP0CNT_ADDR + capture)) = 0;
}

#endif // SDK_ARM7

// --------------------
// FUNCTIONS
// --------------------

#ifdef SDK_ARM7

void SND_SetupCapture(SNDCapture capture, SNDCaptureFormat format, void *buffer_addr, int length, BOOL repeat, SNDCaptureIn in, SNDCaptureOut out);
BOOL SND_IsCaptureActive(SNDCapture capture);

#endif // SDK_ARM7

#ifdef __cplusplus
}
#endif

#endif // NITRO_SND_COMMON_CAPTURE_H
