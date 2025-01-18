#ifndef RUSH_REPLAYRECORDER_H
#define RUSH_REPLAYRECORDER_H

#include <global.h>
#include <game/system/task.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>

// --------------------
// CONSTANTS
// --------------------

#define REPLAYRECORDER_MAX_FRAME_DURATION 0xFF

// --------------------
// ENUMS
// --------------------

enum ReplayMode_
{
    REPLAY_MODE_NONE,
    REPLAY_MODE_FINISHED,
    REPLAY_MODE_PLAYBACK,
    REPLAY_MODE_RECORD,
    REPLAY_MODE_4,
    REPLAY_MODE_FORCE_QUIT,
    REPLAY_MODE_6,
};
typedef u16 ReplayMode;

typedef enum ReplayRecorderFlags_
{
    REPLAYRECORDER_FLAG_IS_RECORDING     = 1 << 0,
    REPLAYRECORDER_FLAG_IS_REPLAYING     = 1 << 1,
    REPLAYRECORDER_FLAG_IS_DEMO_PLAYBACK = 1 << 2,
} ReplayRecorderFlags;

typedef enum ReplayRecorderType_
{
    REPLAYRECORDER_TYPE_RECORD,
    REPLAYRECORDER_TYPE_PLAY_MEMORY,
    REPLAYRECORDER_TYPE_PLAY_FILE,
} ReplayRecorderType;

// --------------------
// STRUCTS
// --------------------

typedef struct KeyDataHeader_
{
    u32 randSeed;
} KeyDataHeader;

typedef struct KeyDataPadFrame_
{
    u16 inputs;
    u8 duration;
} KeyDataPadFrame;

typedef struct KeyDataTouchFrame_
{
    u8 sampleFlag;
    u8 touchX;
    u8 touchY;
    u8 duration;
} KeyDataTouchFrame;

typedef struct KeyDataPad_
{
    KeyDataHeader header;
    KeyDataPadFrame frames[1]; // C-style variable array
} KeyDataPad;

typedef struct KeyDataTouch_
{
    KeyDataHeader header;
    KeyDataTouchFrame frames[1]; // C-style variable array
} KeyDataTouch;

typedef struct ReplayRecorderPad_
{
    ReplayRecorderFlags flags;
    u32 timer;
    u32 frameID;
    u16 frameDuration;
    ReplayMode mode;
    u16 delay;
    PadInputState *destInputState;
    KeyDataPadFrame *keyDataFrames;
    u32 keyDataFileSize;
    KeyDataPad *keyDataFile;
    ReplayRecorderType type;
} ReplayRecorderPad;

typedef struct ReplayRecorderTouch_
{
    u32 flags;
    s32 timer;
    u32 frameID;
    u16 frameDuration;
    ReplayMode mode;
    u16 delay;
    TouchInputState *inputState;
    KeyDataTouchFrame *keyDataFrames;
    u32 keyDataFileSize;
    BOOL isTouchEnabled;
    BOOL isTouchSamplingEnabled;
    u8 sampleFreq;
    TouchInputStateCore touchInput;
    KeyDataTouch *keyDataFile;
    u32 type;
} ReplayRecorderTouch;

struct ReplayState
{
    ReplayMode pad;
    ReplayMode touch;
};

// --------------------
// VARIABLES
// --------------------

extern struct ReplayState replayState;

// --------------------
// FUNCTIONS
// --------------------

// Replay Manager
ReplayMode GetPadReplayState(void);
void SetPadReplayState(ReplayMode state);
void SetTouchReplayState(ReplayMode state);
void InitReplaySystem(void);

// ReplayRecorder (button inputs)
void CreateReplayRecorderPad(ReplayRecorderType type, PadInputState *inputState, const char *path, KeyDataPad *keyDataFile, s32 keyDataFileSize);
void CreateReplayRecorderPadEx(ReplayRecorderType type, PadInputState *inputState, const char *path, KeyDataPad *keyDataFile, s32 keyDataFileSize, u8 pauseLevel, u16 priority);

// ReplayRecorder (touch inputs)
void CreateReplayRecorderTouch(ReplayRecorderType type, TouchInputState *inputState, const char *path, KeyDataTouch *keyDataFile, s32 keyDataFileSize);
void CreateReplayRecorderTouchEx(ReplayRecorderType type, TouchInputState *inputState, const char *path, KeyDataTouch *keyDataFile, s32 keyDataFileSize, u8 pauseLevel, u16 priority);

#endif // RUSH_REPLAYRECORDER_H