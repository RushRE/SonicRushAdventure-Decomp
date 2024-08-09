#include <game/input/micInput.h>

// --------------------
// VARIABLES
// --------------------

static MicInputFlags inputFlags;
MicInputState micInput;

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void TryInitPrevSamplingAddr(MicInputState *state)
{
    state->flags &= ~MIC_INPUT_STATE_NO_PREV_SAMPLE;

    if (state->prevSamplingAddr == NULL)
        state->prevSamplingAddr = state->sampleBuffer;
}

// --------------------
// FUNCTIONS
// --------------------

void InitMicInputSystem(void)
{
    MIC_Init();
    MI_CpuClear16(&micInput, sizeof(micInput));
}

void UpdateMicInput(void)
{
    MicInputState *state = &micInput;

    if ((inputFlags & MIC_INPUT_FLAG_ENABLED) != 0)
    {
        state->prevSamplingAddr = state->samplingAddress;
        state->samplingAddress  = MIC_GetLastSamplingAddress();

        if (state->samplingAddress == NULL)
        {
            state->flags |= MIC_INPUT_STATE_NO_PREV_SAMPLE;
        }
        else
        {
            size_t sampleSize;

            TryInitPrevSamplingAddr(state);

            if (state->prevSamplingAddr < state->samplingAddress)
            {
                DC_InvalidateRange(state->prevSamplingAddr, state->samplingAddress - state->prevSamplingAddr);

                state->flags &= ~MIC_INPUT_STATE_USE_ALT_SAMPLE;

                if ((state->flags & MIC_INPUT_STATE_USE_HALF_SAMPLE) != 0)
                    sampleSize = (state->samplingAddress - state->prevSamplingAddr) << 15;
                else
                    sampleSize = (state->samplingAddress - state->prevSamplingAddr) << 16;

                state->lastSampleSize = sampleSize >> 16;
            }
            else if (state->prevSamplingAddr > state->samplingAddress)
            {
                DC_InvalidateRange(state->prevSamplingAddr, &state->sampleBuffer[state->bufferSize] - state->prevSamplingAddr);
                DC_InvalidateRange(state->sampleBuffer, state->samplingAddress - state->sampleBuffer);

                state->flags |= MIC_INPUT_STATE_USE_ALT_SAMPLE;

                if ((state->flags & MIC_INPUT_STATE_USE_HALF_SAMPLE) != 0)
                    sampleSize = (&state->samplingAddress[state->bufferSize] - state->prevSamplingAddr) << 15;
                else
                    sampleSize = (&state->samplingAddress[state->bufferSize] - state->prevSamplingAddr) << 16;

                state->lastSampleSize = sampleSize >> 16;
            }
        }
    }
}

BOOL IsMicInputEnabled(void)
{
    return (inputFlags & MIC_INPUT_FLAG_ENABLED) != 0;
}