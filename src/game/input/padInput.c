#include <game/input/padInput.h>

// --------------------
// VARIABLES
// --------------------

static PadInputFlags inputFlags;
PadInputState padInput;

// --------------------
// FUNCTIONS
// --------------------

void InitPadInputSystem(void)
{
    inputFlags = PAD_INPUT_FLAG_NONE;

    InitPadInput(&padInput, NULL, NULL);
    ReadPadInput(&padInput, GetPadButtonMask());
}

void UpdatePadInput(void)
{
    if ((inputFlags & PAD_INPUT_FLAG_DISABLED) == 0)
    {
        ReadPadInput(&padInput, GetPadButtonMask());
    }
}

void InitPadInput(PadInputState *state, u16 *btnRepeatInitialTime, u16 *keyRepeatTime)
{
    MI_CpuClear16(state, sizeof(PadInputState));

    if (btnRepeatInitialTime != NULL)
    {
        for (s32 b = 0; b < PAD_INPUT_BUTTON_COUNT; b++)
        {
            state->btnRepeatInitialTime[b] = btnRepeatInitialTime[b];
        }
    }
    else
    {
        for (s32 b = 0; b < PAD_INPUT_BUTTON_COUNT; b++)
        {
            state->btnRepeatInitialTime[b] = PAD_INPUT_BUTTON_REPEAT_INITIAL_TIME_DEFAULT;
        }
    }

    if (keyRepeatTime != NULL)
    {
        for (s32 b = 0; b < PAD_INPUT_BUTTON_COUNT; b++)
        {
            state->btnRepeatRepeatTime[b] = keyRepeatTime[b];
        }
    }
    else
    {
        for (s32 b = 0; b < PAD_INPUT_BUTTON_COUNT; b++)
        {
            state->btnRepeatRepeatTime[b] = PAD_INPUT_BUTTON_REPEAT_TIME_DEFAULT;
        }
    }
}

void ReadPadInput(PadInputState *state, PadButtonMask inputs)
{
    state->prevBtnDown    = state->btnDown;
    state->btnDown        = inputs;
    state->btnPress       = state->btnDown & (state->btnDown ^ state->prevBtnDown);
    state->btnRelease     = state->prevBtnDown & (state->btnDown ^ state->prevBtnDown);
    state->btnPressRepeat = state->btnPress;

    for (s32 b = 0; b < PAD_INPUT_BUTTON_COUNT; b++)
    {
        // if no button is pressed, reset the repeat timer
        if ((state->btnDown & (1 << b)) == 0)
        {
            state->btnRepeatTimer[b] = state->btnRepeatInitialTime[b];
            continue;
        }

        // key repeat timer is active...
        if (state->btnRepeatTimer[b])
        {
            state->btnRepeatTimer[b]--;
            continue;
        }

        // key repeat timer reached zero, add a repeat press!
        state->btnPressRepeat |= 1 << b;
        state->btnRepeatTimer[b] = state->btnRepeatRepeatTime[b];
    }
}

void EnablePadInput(BOOL enabled)
{
    inputFlags &= ~PAD_INPUT_FLAG_DISABLED;
    if (enabled)
        inputFlags |= PAD_INPUT_FLAG_DISABLED;
}