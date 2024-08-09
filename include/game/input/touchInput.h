#ifndef RUSH2_TOUCH_INPUT_H
#define RUSH2_TOUCH_INPUT_H

#include <global.h>

// --------------------
// CONSTANTS/MACROS
// --------------------

#define TOUCH_INPUT_SAMPLE_MAX      4
#define TOUCH_INPUT_DATABUFFER_SIZE 5

#define TOUCH_HAS_ON(flags)   (((flags) & (1 << TOUCH_STATE_HAS_ON)) != 0)
#define TOUCH_HAS_PREV(flags) (((flags) & (1 << TOUCH_STATE_HAS_PREV)) != 0)
#define TOUCH_HAS_PUSH(flags) (((flags) & (1 << TOUCH_STATE_HAS_PUSH)) != 0)
#define TOUCH_HAS_PULL(flags) (((flags) & (1 << TOUCH_STATE_HAS_PULL)) != 0)

// --------------------
// ENUMS
// --------------------

enum TouchInputFlags_
{
    TOUCH_INPUT_FLAG_NONE             = 0 << 0,
    TOUCH_INPUT_FLAG_ENABLED          = 1 << 0,
    TOUCH_INPUT_FLAG_SAMPLING_ENABLED = 1 << 1,
};
typedef u16 TouchInputFlags;

enum TouchSampleFlags_
{
    TOUCH_SAMPLE_FLAG_NONE  = 0 << 0,
    TOUCH_SAMPLE_HAS_COORDS = 1 << 0, // touched the screen with valid coords on both axis
    TOUCH_SAMPLE_NO_COORDS  = 1 << 7, // touched the screen with invalid coords on one or both axis
};
typedef u8 TouchSampleFlags;

enum TouchStateFlags_
{
    TOUCH_STATE_HAS_ON   = 0,
    TOUCH_STATE_HAS_PREV = 1,
    TOUCH_STATE_HAS_PUSH = 2,
    TOUCH_STATE_HAS_PULL = 3,

    TOUCH_STATE_HAS_INVALID_TOUCH = 7,
};
typedef u16 TouchStateFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct TouchPos_
{
    u16 x;
    u16 y;
} TouchPos;

typedef struct TouchInputStateCore_
{
    TouchPos sampleBuffer[TOUCH_INPUT_SAMPLE_MAX];
    u8 sampleFreq;
    TouchSampleFlags sampleFlag;
} TouchInputStateCore;

typedef struct TouchInputState_
{
    TouchInputStateCore core;

    TouchStateFlags flags;
    TouchPos on;
    TouchPos prev;
    TouchPos push;
    TouchPos pull;
} TouchInputState;

// --------------------
// VARIABLES
// --------------------

extern TouchInputState touchInput;

// --------------------
// FUNCTIONS
// --------------------

void InitTouchInputSystem(void);
void UpdateTouchInput(void);
BOOL IsTouchInputEnabled(void);
BOOL IsTouchSamplingEnabled(void);
void ResetTouchInput(void);
void ReleaseTouchInput(void);
void StartSamplingTouchInput(u8 frequence);
void StopSamplingTouchInput(void);
void ApplyTouchInputState(TouchInputState *state, TouchInputStateCore *updatedState);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE BOOL TouchInput__IsTouchOn(TouchInputState *state)
{
    return TOUCH_HAS_ON(state->flags);
}

RUSH_INLINE BOOL TouchInput__IsTouchPrev(TouchInputState *state)
{
    return TOUCH_HAS_PREV(state->flags);
}

RUSH_INLINE BOOL TouchInput__IsTouchPush(TouchInputState *state)
{
    return TOUCH_HAS_PUSH(state->flags);
}

RUSH_INLINE BOOL TouchInput__IsTouchPull(TouchInputState *state)
{
    return TOUCH_HAS_PULL(state->flags);
}

#endif // RUSH2_TOUCH_INPUT_H
