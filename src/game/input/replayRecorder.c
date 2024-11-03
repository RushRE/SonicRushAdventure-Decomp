#include <game/input/replayRecorder.h>
#include <game/system/allocator.h>
#include <game/math/mtMath.h>
#include <game/file/fsRequest.h>

// --------------------
// MACROS
// --------------------

#define USING_GLOBAL_INPUT work->destInputState == &padInput

// --------------------
// FUNCTION DECLS
// --------------------

static void ReplayRecorderPad_Destructor(Task *task);
static void ReplayRecorderPad_Main(void);
static void ReplayRecorderTouch_Destructor(Task *task);
static void ReplayRecorderTouch_Main(void);

// --------------------
// VARIABLES
// --------------------

struct ReplayState replayState;

// --------------------
// FUNCTIONS
// --------------------

// Replay Manager
ReplayMode GetPadReplayState(void)
{
    return replayState.pad;
}

void SetPadReplayState(ReplayMode state)
{
    if (replayState.pad)
        replayState.pad = state;
}

void SetTouchReplayState(ReplayMode state)
{
    if (replayState.touch)
        replayState.touch = state;
}

void InitReplaySystem(void)
{
    replayState.pad   = REPLAY_MODE_NONE;
    replayState.touch = REPLAY_MODE_NONE;
}

// ReplayRecorder (button inputs)
void CreateReplayRecorderPad(ReplayRecorderType type, PadInputState *inputState, const char *path, KeyDataPad *keyDataFile, s32 keyDataFileSize)
{
    CreateReplayRecorderPadEx(type, inputState, path, keyDataFile, keyDataFileSize, 7, TASK_PRIORITY_UPDATE_LIST_START + 1);
}

void CreateReplayRecorderPadEx(ReplayRecorderType type, PadInputState *inputState, const char *path, KeyDataPad *keyDataFile, s32 keyDataFileSize, u8 pauseLevel, u16 priority)
{
    Task *task = TaskCreate(ReplayRecorderPad_Main, ReplayRecorderPad_Destructor, TASK_FLAG_NONE, pauseLevel, priority, TASK_GROUP(0), ReplayRecorderPad);

    if (task != HeapNull)
    {
        ReplayRecorderPad *work = TaskGetWork(task, ReplayRecorderPad);
        TaskInitWork8(work);

        work->type           = type;
        work->destInputState = inputState;

        switch (work->type)
        {
            case REPLAYRECORDER_TYPE_RECORD:
                work->flags |= REPLAYRECORDER_FLAG_IS_RECORDING;
                replayState.pad       = REPLAY_MODE_RECORD;
                work->keyDataFile     = keyDataFile;
                work->keyDataFileSize = keyDataFileSize;
                MI_CpuFill8(work->keyDataFile, 0, work->keyDataFileSize);
                work->keyDataFile->header.randSeed = mtMathGetRandSeed();
                work->keyDataFrames                = work->keyDataFile->frames;
                break;

            case REPLAYRECORDER_TYPE_PLAY_MEMORY:
                work->flags |= REPLAYRECORDER_FLAG_IS_REPLAYING;
                replayState.pad       = REPLAY_MODE_PLAYBACK;
                work->keyDataFile     = keyDataFile;
                work->keyDataFileSize = keyDataFileSize;
                mtMathSetRandSeed(work->keyDataFile->header.randSeed);
                work->keyDataFrames = work->keyDataFile->frames;
                work->delay         = 8;
                break;

            case REPLAYRECORDER_TYPE_PLAY_FILE:
                work->flags |= REPLAYRECORDER_FLAG_IS_REPLAYING;
                replayState.pad   = REPLAY_MODE_PLAYBACK;
                work->keyDataFile = FSRequestFileSync(path, FSREQ_AUTO_ALLOC_HEAD);
                work->flags |= REPLAYRECORDER_FLAG_IS_DEMO_PLAYBACK;
                mtMathSetRandSeed(work->keyDataFile->header.randSeed);
                work->keyDataFrames = work->keyDataFile->frames;
                work->delay         = 8;
                break;
        }
    }
}

void ReplayRecorderPad_Destructor(Task *task)
{
    ReplayRecorderPad *work = TaskGetWork(task, ReplayRecorderPad);

    if ((work->flags & REPLAYRECORDER_FLAG_IS_DEMO_PLAYBACK) != 0)
        HeapFree(HEAP_USER, work->keyDataFile);

    replayState.pad = REPLAY_MODE_NONE;

    if (USING_GLOBAL_INPUT)
        EnablePadInput(FALSE);
}

void ReplayRecorderPad_Main(void)
{
    ReplayRecorderPad *work = TaskGetWorkCurrent(ReplayRecorderPad);

    // Mode change
    if (work->mode != replayState.pad)
    {
        work->frameDuration = 0;
        work->frameID       = 0;

        switch (replayState.pad)
        {
            default:
                if (USING_GLOBAL_INPUT)
                    EnablePadInput(FALSE);

                work->flags &= ~(REPLAYRECORDER_FLAG_IS_REPLAYING | REPLAYRECORDER_FLAG_IS_RECORDING);
                break;

            case REPLAY_MODE_PLAYBACK:
            case REPLAY_MODE_4:
                work->delay = 8;
                if (USING_GLOBAL_INPUT)
                    EnablePadInput(TRUE);

                work->flags = (ReplayRecorderFlags)(work->flags & ~(REPLAYRECORDER_FLAG_IS_REPLAYING | REPLAYRECORDER_FLAG_IS_RECORDING) | REPLAYRECORDER_FLAG_IS_REPLAYING);
                break;

            case REPLAY_MODE_RECORD:
                if (work->mode == REPLAY_MODE_4)
                {
                    DestroyCurrentTask();
                    return;
                }

                if (USING_GLOBAL_INPUT)
                    EnablePadInput(FALSE);

                work->flags = (ReplayRecorderFlags)(work->flags & ~(REPLAYRECORDER_FLAG_IS_REPLAYING | REPLAYRECORDER_FLAG_IS_RECORDING) | REPLAYRECORDER_FLAG_IS_RECORDING);
                break;

            case REPLAY_MODE_FORCE_QUIT:
            case REPLAY_MODE_6:
                DestroyCurrentTask();
                return;
        }
    }

    work->mode = replayState.pad;

    if ((work->flags & REPLAYRECORDER_FLAG_IS_REPLAYING) != 0)
    {
        // Playback mode

        if (work->delay)
            work->delay--;

        if ((work->flags & REPLAYRECORDER_FLAG_IS_RECORDING) != 0)
        {
            work->flags &= ~REPLAYRECORDER_FLAG_IS_RECORDING;
            work->frameID = 0;
            work->timer   = 0;
        }

        KeyDataPadFrame *frame = &work->keyDataFrames[work->frameID];
        ReadPadInput(work->destInputState, frame->inputs);

        if (frame->duration <= ++work->frameDuration)
        {
            work->frameID++;
            work->frameDuration = 0;
        }

        // a frame with no duration means it's the last frame!
        if (frame->duration == 0)
        {
            work->flags &= ~REPLAYRECORDER_FLAG_IS_REPLAYING;
            replayState.pad     = REPLAY_MODE_FINISHED;
            work->frameDuration = 0;
        }
    }
    else if ((work->flags & REPLAYRECORDER_FLAG_IS_RECORDING) != 0)
    {
        // Recording mode

        KeyDataPadFrame *frame = &work->keyDataFrames[work->frameID];

        if (frame->duration == 0)
        {
            frame->inputs = work->destInputState->btnDown;
            frame->duration++;
        }
        else
        {
            if (frame->inputs == work->destInputState->btnDown)
            {
                frame->duration++;

                // force a new frame if we've had the same inputs for long enough
                if (frame->duration == REPLAYRECORDER_MAX_FRAME_DURATION)
                    work->frameID++;
            }
            else
            {
                work->frameID++;

                // new frame!
                frame         = &work->keyDataFrames[work->frameID];
                frame->inputs = work->destInputState->btnDown;
                frame->duration++;
            }
        }

        if ((sizeof(KeyDataPadFrame) * work->frameID) >= (work->keyDataFileSize - 6))
        {
            work->flags &= ~REPLAYRECORDER_FLAG_IS_RECORDING;
            replayState.pad = REPLAY_MODE_FINISHED;
        }
    }

    work->timer++;
}

// ReplayRecorder (touch inputs)
void CreateReplayRecorderTouch(ReplayRecorderType type, TouchInputState *inputState, const char *path, KeyDataTouch *keyDataFile, s32 keyDataFileSize)
{
    CreateReplayRecorderTouchEx(type, inputState, path, keyDataFile, keyDataFileSize, 7, TASK_PRIORITY_UPDATE_LIST_START + 1);
}

void CreateReplayRecorderTouchEx(ReplayRecorderType type, TouchInputState *inputState, const char *path, KeyDataTouch *keyDataFile, s32 keyDataFileSize, u8 pauseLevel,
                                 u16 priority)
{
    Task *task = TaskCreate(ReplayRecorderTouch_Main, ReplayRecorderTouch_Destructor, TASK_FLAG_NONE, pauseLevel, priority, TASK_GROUP(0), ReplayRecorderTouch);

    if (task != HeapNull)
    {
        ReplayRecorderTouch *work = TaskGetWork(task, ReplayRecorderTouch);
        TaskInitWork8(work);

        work->type                   = type;
        work->inputState             = inputState;
        work->isTouchEnabled         = IsTouchInputEnabled();
        work->isTouchSamplingEnabled = IsTouchSamplingEnabled();

        if (work->isTouchSamplingEnabled)
        {
            work->sampleFreq = touchInput.core.sampleFreq;
        }
        else if (work->isTouchEnabled)
        {
            work->sampleFreq = 1;
        }
        work->touchInput.sampleFreq = work->sampleFreq;

        switch (work->type)
        {
            case REPLAYRECORDER_TYPE_RECORD:
                work->flags |= REPLAYRECORDER_FLAG_IS_RECORDING;
                replayState.touch     = REPLAY_MODE_RECORD;
                work->keyDataFile     = keyDataFile;
                work->keyDataFileSize = keyDataFileSize;
                MI_CpuFill8(work->keyDataFile, 0, work->keyDataFileSize);
                work->keyDataFile->header.randSeed = mtMathGetRandSeed();
                work->keyDataFrames                = work->keyDataFile->frames;
                break;

            case REPLAYRECORDER_TYPE_PLAY_MEMORY:
                work->flags |= REPLAYRECORDER_FLAG_IS_REPLAYING;
                replayState.touch     = REPLAY_MODE_PLAYBACK;
                work->keyDataFile     = keyDataFile;
                work->keyDataFileSize = keyDataFileSize;
                mtMathSetRandSeed(work->keyDataFile->header.randSeed);
                work->keyDataFrames = work->keyDataFile->frames;
                work->delay         = 8;
                break;

            case REPLAYRECORDER_TYPE_PLAY_FILE:
                work->flags |= REPLAYRECORDER_FLAG_IS_REPLAYING;
                replayState.touch = REPLAY_MODE_PLAYBACK;
                work->keyDataFile = FSRequestFileSync(path, FSREQ_AUTO_ALLOC_HEAD);
                work->flags |= REPLAYRECORDER_FLAG_IS_DEMO_PLAYBACK;
                mtMathSetRandSeed(work->keyDataFile->header.randSeed);
                work->keyDataFrames = work->keyDataFile->frames;
                work->delay         = 8;
                break;
        }
    }
}

void ReplayRecorderTouch_Destructor(Task *task)
{
    ReplayRecorderTouch *work = TaskGetWork(task, ReplayRecorderTouch);

    if ((work->flags & REPLAYRECORDER_FLAG_IS_DEMO_PLAYBACK) != 0)
        HeapFree(HEAP_USER, work->keyDataFile);

    replayState.touch = REPLAY_MODE_NONE;

    if (work->isTouchSamplingEnabled && !IsTouchSamplingEnabled())
    {
        StartSamplingTouchInput(work->sampleFreq);
    }
    else
    {
        if (work->isTouchEnabled)
        {
            if (!IsTouchInputEnabled())
                ResetTouchInput();
        }
    }
}

void ReplayRecorderTouch_Main(void)
{
    ReplayRecorderTouch *work = TaskGetWorkCurrent(ReplayRecorderTouch);

    // Mode change
    if (work->mode != replayState.touch)
    {
        if (work->mode == REPLAY_MODE_RECORD)
        {
            for (u16 f = 0; f < work->frameID; f++)
            {
                // Do... something?
            }
        }

        work->frameDuration = 0;
        work->frameID       = 0;

        switch (replayState.touch)
        {
            default:
                if (work->isTouchSamplingEnabled && !IsTouchSamplingEnabled())
                {
                    StartSamplingTouchInput(work->sampleFreq);
                }
                else
                {
                    if (work->isTouchEnabled && !IsTouchInputEnabled())
                        ResetTouchInput();
                }

                work->flags &= ~(REPLAYRECORDER_FLAG_IS_REPLAYING | REPLAYRECORDER_FLAG_IS_RECORDING);
                break;

            case REPLAY_MODE_PLAYBACK:
            case REPLAY_MODE_4:
                work->delay = 8;

                if (work->isTouchSamplingEnabled)
                {
                    StopSamplingTouchInput();
                }
                else if (work->isTouchEnabled)
                {
                    ReleaseTouchInput();
                }

                work->flags = (ReplayRecorderFlags)(work->flags & ~(REPLAYRECORDER_FLAG_IS_REPLAYING | REPLAYRECORDER_FLAG_IS_RECORDING) | REPLAYRECORDER_FLAG_IS_REPLAYING);
                break;

            case REPLAY_MODE_RECORD:
                if (work->mode == REPLAY_MODE_4)
                {
                    DestroyCurrentTask();
                    return;
                }

                if (work->isTouchSamplingEnabled && !IsTouchSamplingEnabled())
                {
                    StartSamplingTouchInput(work->sampleFreq);
                }
                else
                {
                    if (work->isTouchEnabled && !IsTouchInputEnabled())
                        ResetTouchInput();
                }

                work->flags = (ReplayRecorderFlags)(work->flags & ~(REPLAYRECORDER_FLAG_IS_REPLAYING | REPLAYRECORDER_FLAG_IS_RECORDING) | REPLAYRECORDER_FLAG_IS_RECORDING);
                break;

            case REPLAY_MODE_FORCE_QUIT:
            case REPLAY_MODE_6:
                DestroyCurrentTask();
                return;
        }
    }

    work->mode = replayState.touch;

    if ((work->flags & REPLAYRECORDER_FLAG_IS_REPLAYING) != 0)
    {
        // Playback mode

        if (work->delay)
            work->delay--;

        if ((work->flags & REPLAYRECORDER_FLAG_IS_RECORDING) != 0)
        {
            work->flags &= ~REPLAYRECORDER_FLAG_IS_RECORDING;
            work->frameID = 0;
            work->timer   = 0;
        }

        KeyDataTouchFrame *frame = &work->keyDataFrames[work->frameID];

        work->touchInput.sampleFlag = frame->sampleFlag;
        for (u16 s = 0; s < 4; s++)
        {
            work->touchInput.sampleBuffer[s].x = frame->touchX;
            work->touchInput.sampleBuffer[s].y = frame->touchY;
        }

        ApplyTouchInputState(work->inputState, &work->touchInput);

        if (frame->duration <= ++work->frameDuration)
        {
            work->frameID++;
            work->frameDuration = 0;
        }

        // a frame with no duration means it's the last frame!
        if (frame->duration == 0)
        {
            work->flags &= ~REPLAYRECORDER_FLAG_IS_REPLAYING;
            replayState.touch   = REPLAY_MODE_FINISHED;
            work->frameDuration = 0;
        }
    }
    else if ((work->flags & REPLAYRECORDER_FLAG_IS_RECORDING) != 0)
    {
        // Recording mode

        KeyDataTouchFrame *frame = &work->keyDataFrames[work->frameID];

        if (frame->duration == 0)
        {
            frame->sampleFlag = work->inputState->core.sampleFlag;
            frame->touchX     = work->inputState->core.sampleBuffer[work->inputState->core.sampleFreq - 1].x;
            frame->touchY     = work->inputState->core.sampleBuffer[work->inputState->core.sampleFreq - 1].y;
            frame->duration++;
        }
        else
        {
            if (frame->sampleFlag == work->inputState->core.sampleFlag && frame->touchX == (u8)work->inputState->core.sampleBuffer[work->inputState->core.sampleFreq - 1].x
                && frame->touchY == (u8)work->inputState->core.sampleBuffer[work->inputState->core.sampleFreq - 1].y)
            {
                frame->duration++;

                // force a new frame if we've had the same inputs for long enough
                if (frame->duration == REPLAYRECORDER_MAX_FRAME_DURATION)
                    work->frameID++;
            }
            else
            {
                work->frameID++;

                // new frame!
                frame             = &work->keyDataFrames[work->frameID];
                frame->sampleFlag = work->inputState->core.sampleFlag;
                frame->touchX     = work->inputState->core.sampleBuffer[work->inputState->core.sampleFreq - 1].x;
                frame->touchY     = work->inputState->core.sampleBuffer[work->inputState->core.sampleFreq - 1].y;
                frame->duration++;
            }
        }

        if ((sizeof(KeyDataTouchFrame) * work->frameID) >= (work->keyDataFileSize - 6))
        {
            work->flags &= ~REPLAYRECORDER_FLAG_IS_RECORDING;
            replayState.touch = REPLAY_MODE_FINISHED;
        }
    }

    work->timer++;
}
