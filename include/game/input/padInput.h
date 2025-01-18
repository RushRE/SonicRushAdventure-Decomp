#ifndef RUSH_PAD_INPUT_H
#define RUSH_PAD_INPUT_H

#include <global.h>

// --------------------
// TYPES
// --------------------

typedef u16 PadButtonMask;

// --------------------
// CONSTANTS
// --------------------

#define PAD_INPUT_NONE_MASK 0x0000

#define PAD_INPUT_BUTTON_COUNT                       12
#define PAD_INPUT_BUTTON_REPEAT_INITIAL_TIME_DEFAULT 20
#define PAD_INPUT_BUTTON_REPEAT_TIME_DEFAULT         2

#define PAD_INPUT_SOFT_RESET (PAD_BUTTON_R | PAD_BUTTON_L | PAD_BUTTON_SELECT | PAD_BUTTON_START)

// --------------------
// ENUMS
// --------------------

enum PadInputFlags_
{
    PAD_INPUT_FLAG_NONE,
    PAD_INPUT_FLAG_DISABLED = 1 << 0,
};
typedef u16 PadInputFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct PadInputState_
{
    PadButtonMask btnDown;
    PadButtonMask prevBtnDown;
    PadButtonMask btnPress;
    PadButtonMask btnRelease;
    PadButtonMask btnPressRepeat;
    u16 btnRepeatTimer[PAD_INPUT_BUTTON_COUNT];
    u16 btnRepeatInitialTime[PAD_INPUT_BUTTON_COUNT];
    u16 btnRepeatRepeatTime[PAD_INPUT_BUTTON_COUNT];
} PadInputState;

// --------------------
// VARIABLES
// --------------------

extern PadInputState padInput;

// --------------------
// FUNCTIONS
// --------------------

void InitPadInputSystem(void);
void UpdatePadInput(void);
void InitPadInput(PadInputState *state, u16 *btnRepeatInitialTime, u16 *keyRepeatTime);
void ReadPadInput(PadInputState *state, PadButtonMask inputs);
void EnablePadInput(BOOL enabled);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE u16 GetPadButtonMask(void)
{
    return PAD_Read();
}

RUSH_INLINE BOOL CheckPadButtonDown(u16 buttonMask)
{
    return (GetPadButtonMask() & buttonMask) != 0;
}

#endif // RUSH_PAD_INPUT_H
