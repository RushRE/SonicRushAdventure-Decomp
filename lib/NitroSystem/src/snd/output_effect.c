#include <nnsys/snd/output_effect.h>

#include <nitro.h>

#include <nnsys/misc.h>
#include <nnsys/snd/capture.h>
#include <nnsys/snd/config.h>

#define SAMPLING_RATE 32000

#define SURROUND_MIX_DELAY   2
#define HEADEPHONE_MIX_DELAY 24
#define HEADEPHONE_SHIFT     2

#define DECAY_RATIO 0x3000

#define S16_MAX ((s16)0x7fff)
#define S16_MIN ((s16)-0x8000)

// --------------------
// TYPES
// --------------------

struct CallbackInfo;

typedef void (*EffectFunc)(void *bufferL_p, void *bufferR_p, u32 len, struct CallbackInfo *info);

// --------------------
// STRUCTS
// --------------------

typedef struct CallbackInfo
{
    NNSSndCaptureOutputEffectType type;
    EffectFunc effectFunc;
    NNSSndCaptureCallback cbFunc;
    void *cbArg;
    NNSSndCaptureCallback cbPostFunc;
    void *cbPostArg;
    union
    {
        s32 surround[SURROUND_MIX_DELAY];
        s32 headphone[HEADEPHONE_MIX_DELAY][2];
    } buffer;
} CallbackInfo;

// --------------------
// VARIABLES
// --------------------

static CallbackInfo sCallbackInfo = { (NNSSndCaptureOutputEffectType)-1, NULL, NULL, NULL, NULL, NULL };

// --------------------
// FUNCTION DECLS
// --------------------

static void EffectCallback(void *bufferL_p, void *bufferR_p, u32 len, NNSSndCaptureFormat format, void *arg);
static void SurroundProc(void *bufferL_p, void *bufferR_p, u32 len, CallbackInfo *info);
static void NothingProc(void *bufferL_p, void *bufferR_p, u32 len, CallbackInfo *info);

static void HeadphoneProc(void *bufferL_p, void *bufferR_p, u32 len, CallbackInfo *info);
static void MonoProc(void *bufferL_p, void *bufferR_p, u32 len, CallbackInfo *info);

static s16 Cut_S32toS16(s32 val);

// --------------------
// INLINE FUNCTIONS
// --------------------

static NNS_SND_INLINE s16 Cut_S32toS16(s32 val)
{
    if (val < S16_MIN)
        val = S16_MIN;
    else if (val > S16_MAX)
        val = S16_MAX;
    return (s16)val;
}

// --------------------
// FUNCTIONS
// --------------------

BOOL NNS_SndCaptureStartOutputEffect(void *buffer, u32 bufSize, NNSSndCaptureOutputEffectType type)
{
    NNS_SndCaptureChangeOutputEffect(type);

    return NNS_SndCaptureStartEffect(buffer, bufSize, NNS_SND_CAPTURE_FORMAT_PCM16, SAMPLING_RATE, 2, EffectCallback, &sCallbackInfo);
}

void NNS_SndCaptureStopOutputEffect(void)
{
    if (sCallbackInfo.type == NNS_SND_CAPTURE_OUTPUT_EFFECT_SURROUND)
    {
        SNDi_SetSurroundDecay(0);
    }

    NNS_SndCaptureStopEffect();
}

void NNS_SndCaptureChangeOutputEffect(NNSSndCaptureOutputEffectType type)
{
    OSIntrMode enabled;

    if (type == sCallbackInfo.type)
        return;

    if (sCallbackInfo.type == NNS_SND_CAPTURE_OUTPUT_EFFECT_SURROUND)
    {
        SNDi_SetSurroundDecay(0);
    }

    enabled = OS_DisableInterrupts();

    MI_CpuClear16(&sCallbackInfo.buffer, sizeof(sCallbackInfo.buffer));
    sCallbackInfo.type = type;

    switch (type)
    {
        case NNS_SND_CAPTURE_OUTPUT_EFFECT_SURROUND:
            sCallbackInfo.effectFunc = SurroundProc;
            break;

        case NNS_SND_CAPTURE_OUTPUT_EFFECT_HEADPHONE:
            sCallbackInfo.effectFunc = HeadphoneProc;
            break;

        case NNS_SND_CAPTURE_OUTPUT_EFFECT_MONO:
            sCallbackInfo.effectFunc = MonoProc;
            break;

        case NNS_SND_CAPTURE_OUTPUT_EFFECT_NORMAL:
            sCallbackInfo.effectFunc = NothingProc;
            break;

        default:
            sCallbackInfo.effectFunc = NothingProc;
            break;
    }

    (void)OS_RestoreInterrupts(enabled);

    if (type == NNS_SND_CAPTURE_OUTPUT_EFFECT_SURROUND)
    {
        SNDi_SetSurroundDecay(DECAY_RATIO);
    }
}

void NNS_SndCaptureSetOutputEffectCallback(NNSSndCaptureCallback func, void *arg)
{
    OSIntrMode enabled = OS_DisableInterrupts();
    ;

    sCallbackInfo.cbFunc = func;
    sCallbackInfo.cbArg  = arg;

    (void)OS_RestoreInterrupts(enabled);
}

void NNS_SndCaptureSetPostOutputEffectCallback(NNSSndCaptureCallback func, void *arg)
{
    OSIntrMode enabled = OS_DisableInterrupts();

    sCallbackInfo.cbPostFunc = func;
    sCallbackInfo.cbPostArg  = arg;

    (void)OS_RestoreInterrupts(enabled);
}

static void EffectCallback(void *bufferL_p, void *bufferR_p, u32 len, NNSSndCaptureFormat format, void *arg)
{
    CallbackInfo *info = (CallbackInfo *)arg;

    if (info->cbFunc != NULL)
    {
        info->cbFunc(bufferL_p, bufferR_p, len, format, info->cbArg);
    }

    info->effectFunc(bufferL_p, bufferR_p, len, info);

    if (info->cbPostFunc != NULL)
    {
        info->cbPostFunc(bufferL_p, bufferR_p, len, format, info->cbPostArg);
    }

    DC_FlushRange(bufferL_p, len);
    DC_FlushRange(bufferR_p, len);
}

static void NothingProc(void *, void *, u32, CallbackInfo *) {}

static void SurroundProc(void *bufferL_p, void *bufferR_p, u32 len, CallbackInfo *info)
{
    s16 *lp = (s16 *)bufferL_p;
    s16 *rp = (s16 *)bufferR_p;
    s16 org[SURROUND_MIX_DELAY];
    const unsigned long samples = len >> 1;
    long i;

#if SURROUND_MIX_DELAY >= 1
    for (i = 0; i < SURROUND_MIX_DELAY; i++)
    {
        s32 temp = lp[i + samples - SURROUND_MIX_DELAY] - rp[i + samples - SURROUND_MIX_DELAY];
        org[i]   = Cut_S32toS16(temp);
    }
#endif

    {
        s16 *lpi = &lp[samples - 1];
        s16 *rpi = &rp[samples - 1];
        for (; lpi >= &lp[SURROUND_MIX_DELAY]; lpi--, rpi--)
        {
            s32 diff  = lpi[-SURROUND_MIX_DELAY] - rpi[-SURROUND_MIX_DELAY];
            s32 templ = *lpi + diff;
            s32 tempr = *rpi - diff;

            if (diff >= 0)
            {
                if (templ < (s32)S16_MAX)
                    *lpi = (s16)templ;
                else
                    *lpi = S16_MAX;
                if (tempr > (s32)S16_MIN)
                    *rpi = (s16)tempr;
                else
                    *rpi = S16_MIN;
            }
            else
            {
                if (templ > (s32)S16_MIN)
                    *lpi = (s16)templ;
                else
                    *lpi = S16_MIN;
                if (tempr < (s32)S16_MAX)
                    *rpi = (s16)tempr;
                else
                    *rpi = S16_MAX;
            }
        }
    }

#if SURROUND_MIX_DELAY >= 1
    for (i = SURROUND_MIX_DELAY - 1; i >= 0; i--)
    {
        s32 temp = lp[i] + info->buffer.surround[i];
        lp[i]    = Cut_S32toS16(temp);
        temp     = rp[i] - info->buffer.surround[i];
        rp[i]    = Cut_S32toS16(temp);
    }

    for (i = 0; i < SURROUND_MIX_DELAY; i++)
    {
        info->buffer.surround[i] = org[i];
    }
#endif
}

static void HeadphoneProc(void *bufferL_p, void *bufferR_p, u32 len, CallbackInfo *info)
{
    s16 *lp                     = (s16 *)bufferL_p;
    s16 *rp                     = (s16 *)bufferR_p;
    const unsigned long samples = len >> 1;
    int i;
    s32 l;
    s32 r;
    int offset;
    unsigned long rest_samples;

    offset = 0;
    while (samples > HEADEPHONE_MIX_DELAY + offset)
    {
        for (i = 0; i < HEADEPHONE_MIX_DELAY; i++)
        {
            const register int x = i + offset;

            l = lp[x] + info->buffer.headphone[i][0];
            r = rp[x] + info->buffer.headphone[i][1];

            lp[x]                        = Cut_S32toS16(l);
            rp[x]                        = Cut_S32toS16(r);
            info->buffer.headphone[i][0] = (r + 1) >> HEADEPHONE_SHIFT;
            info->buffer.headphone[i][1] = (l + 1) >> HEADEPHONE_SHIFT;
        }
        offset += HEADEPHONE_MIX_DELAY;
    }

    rest_samples = samples - offset;
    for (i = 0; i < rest_samples; i++)
    {
        const int x = i + offset;

        l     = lp[x] + info->buffer.headphone[i][0];
        r     = rp[x] + info->buffer.headphone[i][1];
        lp[x] = Cut_S32toS16(l);
        rp[x] = Cut_S32toS16(r);
    }

    for (i = 0; i < HEADEPHONE_MIX_DELAY - rest_samples; i++)
    {
        info->buffer.headphone[i][0] = info->buffer.headphone[i + rest_samples][0];
        info->buffer.headphone[i][1] = info->buffer.headphone[i + rest_samples][1];
    }

    for (i = 0; i < rest_samples; i++)
    {
        const long x = (long)(i + HEADEPHONE_MIX_DELAY - rest_samples);

        info->buffer.headphone[x][0] = (rp[i + offset] + 1) >> HEADEPHONE_SHIFT;
        info->buffer.headphone[x][1] = (lp[i + offset] + 1) >> HEADEPHONE_SHIFT;
    }
}

static void MonoProc(void *bufferL_p, void *bufferR_p, u32 len, CallbackInfo *)
{
    s16 *lp                     = (s16 *)bufferL_p;
    s16 *rp                     = (s16 *)bufferR_p;
    const unsigned long samples = len >> 1;
    register s32 x;
    int i;

    for (i = 0; i < samples; i++)
    {
        x = lp[i];
        x += rp[i];
        x++;
        x >>= 1;
        lp[i] = (s16)x;
    }
    MI_CpuCopyFast(bufferL_p, bufferR_p, len);
}