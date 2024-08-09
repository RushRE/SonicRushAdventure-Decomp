#include <game/input/touchInput.h>
#include <game/input/micInput.h>

// --------------------
// VARIABLES
// --------------------

static TouchInputFlags inputFlags;
TouchInputState touchInput;
static TPData touchInputBuffer[TOUCH_INPUT_DATABUFFER_SIZE];

// --------------------
// PRIVATE FUNCTIONS
// --------------------

void TPCallback(TPRequestCommand command, TPRequestResult result, u16 index);
void TouchInputSampleManual(void);
void TouchInputSampleAuto(void);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE BOOL IsTouchInputEnabled_Internal(void)
{
    return (inputFlags & TOUCH_INPUT_FLAG_ENABLED) != 0;
}

RUSH_INLINE BOOL IsTouchSamplingEnabled_Internal(void)
{
    return (inputFlags & TOUCH_INPUT_FLAG_SAMPLING_ENABLED) != 0;
}

RUSH_INLINE void SetTouchInputBit(u16 *val, int shift, BOOL b)
{
    *val = (*val & ~(1 << shift) | b << shift);
}

RUSH_INLINE void ClearTouchInputState(void)
{
    MI_CpuClear16(&touchInput, sizeof(touchInput));
}

RUSH_INLINE void ClearTouchInputBuffers(void)
{
    ClearTouchInputState();
    MI_CpuClear16(touchInputBuffer, sizeof(touchInputBuffer));
}

// --------------------
// FUNCTIONS
// --------------------

void InitTouchInputSystem(void)
{
    TPCalibrateParam param;

    inputFlags = TOUCH_INPUT_FLAG_NONE;
    ClearTouchInputBuffers();
    TP_SetCallback(TPCallback);

    if (!TP_GetUserInfo(&param))
        TP_SetCalibrateParam(NULL);
    else
        TP_SetCalibrateParam(&param);
}

void UpdateTouchInput(void)
{
    if (IsTouchInputEnabled_Internal())
    {
        if (IsTouchSamplingEnabled_Internal())
            TouchInputSampleAuto();
        else
            TouchInputSampleManual();

        ApplyTouchInputState(&touchInput, &touchInput.core);
    }
}

BOOL IsTouchInputEnabled(void)
{
    return IsTouchInputEnabled_Internal();
}

BOOL IsTouchSamplingEnabled(void)
{
    return IsTouchSamplingEnabled_Internal();
}

void ResetTouchInput(void)
{
    if (IsTouchInputEnabled_Internal())
    {
        if (IsTouchSamplingEnabled_Internal() == FALSE)
            return;

        StopSamplingTouchInput();
    }

    ClearTouchInputBuffers();

    touchInput.core.sampleFreq = 1;
    inputFlags |= TOUCH_INPUT_FLAG_ENABLED;
}

void ReleaseTouchInput(void)
{
    touchInput.core.sampleFreq = 0;
    ClearTouchInputState();
    inputFlags &= ~TOUCH_INPUT_FLAG_ENABLED;
}

void StartSamplingTouchInput(u8 frequence)
{
    if (!IsMicInputEnabled())
    {
        if (frequence < 1 || frequence > TOUCH_INPUT_SAMPLE_MAX)
            frequence = 1;

        if (IsTouchSamplingEnabled_Internal())
        {
            if (frequence == touchInput.core.sampleFreq)
                return;

            StopSamplingTouchInput();
        }

        ClearTouchInputBuffers();

        touchInput.core.sampleFreq = frequence;
        if (TP_RequestAutoSamplingStart(0, touchInput.core.sampleFreq, touchInputBuffer, TOUCH_INPUT_DATABUFFER_SIZE) == TP_RESULT_SUCCESS)
            inputFlags |= (TOUCH_INPUT_FLAG_ENABLED | TOUCH_INPUT_FLAG_SAMPLING_ENABLED);
    }
}

void StopSamplingTouchInput(void)
{
    if (IsTouchSamplingEnabled_Internal())
    {
        if (TP_RequestAutoSamplingStop() == TP_RESULT_SUCCESS)
            touchInput.core.sampleFreq = 0;
    }

    ClearTouchInputState();
    inputFlags &= ~(TOUCH_INPUT_FLAG_ENABLED | TOUCH_INPUT_FLAG_SAMPLING_ENABLED);
}

void ApplyTouchInputState(TouchInputState *state, TouchInputStateCore *updatedState)
{
    u32 count;

    BOOL invalidTouchFlag = (updatedState->sampleFlag & TOUCH_SAMPLE_NO_COORDS) != 0;
    BOOL isOn             = (updatedState->sampleFlag & TOUCH_SAMPLE_HAS_COORDS) != 0;
    BOOL wasOn            = (state->flags & (1 << TOUCH_STATE_HAS_ON)) & 1;
    BOOL onChanged        = isOn ^ wasOn;

    SetTouchInputBit(&state->flags, TOUCH_STATE_HAS_INVALID_TOUCH, invalidTouchFlag);
    SetTouchInputBit(&state->flags, TOUCH_STATE_HAS_PREV, wasOn);
    SetTouchInputBit(&state->flags, TOUCH_STATE_HAS_ON, isOn);
    SetTouchInputBit(&state->flags, TOUCH_STATE_HAS_PUSH, onChanged & isOn);
    SetTouchInputBit(&state->flags, TOUCH_STATE_HAS_PULL, onChanged & wasOn);

    // update prev pos
    state->prev.x = state->on.x;
    state->prev.y = state->on.y;

    // update cur pos
    TouchPos *touch = &updatedState->sampleBuffer[updatedState->sampleFreq - 1];
    state->on.x     = touch->x;
    state->on.y     = touch->y;

    if (TouchInput__IsTouchPush(state))
    {
        // update push if needed
        state->push.x = state->on.x;
        state->push.y = state->on.y;
    }
    else if (TouchInput__IsTouchPull(state))
    {
        // update pull if needed
        state->pull.x = state->prev.x;
        state->pull.y = state->prev.y;
    }

    // no need to copy if we're doing a simple update
    if ((TouchInputStateCore *)state == updatedState)
        return;

    // Copy sample buffer
    TouchPos *destPos = state->core.sampleBuffer;
    TouchPos *newPos  = updatedState->sampleBuffer;

    count = TOUCH_INPUT_SAMPLE_MAX;
    while (count != 0)
    {
        u16 x = newPos->x;
        u16 y = newPos->y;
        newPos++;

        destPos->x = x;
        destPos->y = y;
        destPos++;

        count--;
    }

    // what
    destPos->x = newPos->x;
}

void TPCallback(TPRequestCommand command, TPRequestResult result, u16 index)
{
    // Nothin...
}

void TouchInputSampleManual(void)
{
    TPData result;
    TouchInputStateCore *state = (TouchInputStateCore *)&touchInput;

    while (TP_RequestCalibratedSampling(&result) != 0)
    {
        // waiting...
        // (waits until there is data to return!)
    }

    if (result.touch == TP_TOUCH_ON)
    {
        if (result.validity == TP_VALIDITY_VALID)
        {
            // only update sample buffer if the user is touching the screen & both coords are valid

            state->sampleBuffer[0].x = result.x;
            state->sampleBuffer[0].y = result.y;

            state->sampleFlag |= TOUCH_SAMPLE_HAS_COORDS;
            state->sampleFlag &= ~TOUCH_SAMPLE_NO_COORDS;
        }
        else
        {
            state->sampleFlag |= TOUCH_SAMPLE_NO_COORDS;
        }
    }
    else
    {
        state->sampleFlag &= ~(TOUCH_SAMPLE_NO_COORDS | TOUCH_SAMPLE_HAS_COORDS);
    }
}

void TouchInputSampleAuto(void)
{
    u8 i;

    u8 latestIndex = TP_GetLatestIndexInAuto();
    u8 sampleFreq  = touchInput.core.sampleFreq;

    TPData tpData[TOUCH_INPUT_SAMPLE_MAX] = { 0 };

    u8 sampleIndex             = (latestIndex - sampleFreq + 6);
    TouchInputStateCore *state = &touchInput.core;
    TPData *rawBuffer          = touchInputBuffer;

    // init calibrated points
    for (i = 0; i < sampleFreq; i++)
    {
        TP_GetCalibratedPoint(&tpData[i], &rawBuffer[(u8)((sampleIndex + i) % 5)]);
    }

    if (tpData[sampleFreq - 1].touch != SPI_TP_TOUCH_ON)
    {
        // no valid data this time around!
        state->sampleFlag &= ~(TOUCH_SAMPLE_NO_COORDS | TOUCH_SAMPLE_HAS_COORDS);
    }
    else
    {
        state->sampleFlag |= TOUCH_SAMPLE_HAS_COORDS;
        state->sampleFlag &= ~TOUCH_SAMPLE_NO_COORDS;

        if (TouchInput__IsTouchOn(&touchInput) == FALSE)
        {
            // if we don't have a touch position, try and find one!
            u8 firstValid;
            u8 id = 0;
            for (; id < sampleFreq; id++)
            {
                if (tpData[id].touch == SPI_TP_TOUCH_ON && tpData[id].validity == SPI_TP_VALIDITY_VALID)
                {
                    firstValid = id;
                    break;
                }
            }

            if (id == sampleFreq)
            {
                state->sampleFlag &= ~(TOUCH_SAMPLE_NO_COORDS | TOUCH_SAMPLE_HAS_COORDS);
                return;
            }

            // all invalid data is copied from the first valid buffer
            for (i = 0; i < firstValid; i++)
            {
                tpData[i] = tpData[firstValid];
            }
        }

        // assign touch positions to sample buffer
        for (i = 0; i < sampleFreq; i++)
        {
            TPData *data = &tpData[i];

            TouchPos *touchPos = &state->sampleBuffer[i];

            if (data->validity == SPI_TP_VALIDITY_VALID && data->touch == SPI_TP_TOUCH_ON)
            {
                touchPos->x = data->x;
                touchPos->y = data->y;
            }
            else
            {
                state->sampleFlag |= TOUCH_SAMPLE_NO_COORDS;

                TouchPos *src;
                if (i == 0)
                {
                    src = &touchInput.on;
                }
                else
                {
                    src = &state->sampleBuffer[i - 1];
                }

                touchPos->x = src->x;
                touchPos->y = src->y;
            }
        }
    }
}