#ifndef RUSH_MIC_INPUT_H
#define RUSH_MIC_INPUT_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

enum MicInputFlags_
{
    MIC_INPUT_FLAG_NONE,
    MIC_INPUT_FLAG_ENABLED = 1 << 0,
    MIC_INPUT_FLAG_2       = 1 << 1,
    MIC_INPUT_FLAG_4       = 1 << 2,
};
typedef u16 MicInputFlags;

enum MicInputStateFlags_
{
    MIC_INPUT_STATE_FLAG_NONE,
    MIC_INPUT_STATE_FLAG_1          = 1 << 0,
    MIC_INPUT_STATE_NO_PREV_SAMPLE  = 1 << 1,
    MIC_INPUT_STATE_USE_ALT_SAMPLE  = 1 << 2,
    MIC_INPUT_STATE_USE_HALF_SAMPLE = 1 << 3,
};
typedef u32 MicInputStateFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct MicInputState_
{
    u8 *sampleBuffer;
    u32 bufferSize;
    u8 *prevSamplingAddr;
    u8 *samplingAddress;
    size_t lastSampleSize;
    MicInputStateFlags flags;

    // all unused?
    s32 field_18;
    s32 field_1C;
    s32 field_20;
    s32 field_24;
    s32 field_28;
    s32 field_2C;
    s32 field_30;
    s32 field_34;
    s32 field_38;
    s32 field_3C;
} MicInputState;

// --------------------
// VARIABLES
// --------------------

extern MicInputState micInput;

// --------------------
// FUNCTIONS
// --------------------

void InitMicInputSystem(void);
void UpdateMicInput(void);
BOOL IsMicInputEnabled(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_MIC_INPUT_H
