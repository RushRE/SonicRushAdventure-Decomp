#include <sail/sailDemoPlayer.h>
#include <game/game/gameState.h>
#include <game/graphics/drawFadeTask.h>
#include <game/input/replayRecorder.h>
#include <game/system/sysEvent.h>
#include <game/file/binaryBundle.h>
#include <game/object/objectManager.h>
#include <sail/sailExitEvent.h>
#include <sail/vikingCupManager.h>

// resources
#include <resources/bb/gm_demoplay.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SailDemoPlayerDemo_
{
    const char *keyDataPad;
    const char *keyDataTouch;
    u32 duration;
    u32 id;
} SailDemoPlayerDemo;

// --------------------
// VARIABLES
// --------------------

static const SailDemoPlayerDemo sailDemoList[] = {
    { .keyDataPad = "/keydat/pd_ship00.dat", .keyDataTouch = "/keydat/tp_ship00.dat", .duration = SECONDS_TO_FRAMES(20.0), .id = 5 }
};

// --------------------
// FUNCTION DECLS
// --------------------

static void SailDemoPlayer_State_Playback(StageTask *work);

// --------------------
// FUNCTIONS
// --------------------

void CreateSailDemoPlayer(void)
{
    StageTask *work;
    GameState *state = GetGameState();

    state->curDemoID = state->unknownDemoID;

    work = CreateStageTaskSimpleEx(TASK_PRIORITY_UPDATE_LIST_START + 2, TASK_GROUP(4));
    StageTask__SetType(work, 2);

    work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_SCREEN_RELATIVE;
    work->moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->state = SailDemoPlayer_State_Playback;

    if (GetObjectDataWork(OBJDATAWORK_81)->fileData == NULL)
    {
        void *memory                    = ReadFileFromBundle("/bb/gm_demoplay.bb", BUNDLE_GM_DEMOPLAY_FILE_RESOURCES_BB_GM_DEMOPLAY_GM_DEMOPLAY_JPN_BAC + GetGameLanguage(), BINARYBUNDLE_AUTO_ALLOC_HEAD);
        GetObjectDataWork(OBJDATAWORK_81)->fileData = memory;
    }

    ObjObjectAction2dBACLoad(work, NULL, NULL, GetObjectDataWork(OBJDATAWORK_81), NULL, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(work, 0, 1055);
    StageTask__SetAnimatorPriority(work, 0);

    work->position.x = FLOAT_TO_FX32(128.0);
    work->position.y = FLOAT_TO_FX32(96.0);
    CreateReplayRecorderPad(REPLAYRECORDER_TYPE_PLAY_FILE, &padInput, sailDemoList[state->curDemoID].keyDataPad, NULL, 0);
    CreateReplayRecorderTouch(REPLAYRECORDER_TYPE_PLAY_FILE, &touchInput, sailDemoList[state->curDemoID].keyDataTouch, NULL, 0);

    VikingCupManager__EventStartVikingCup(sailDemoList[state->curDemoID].id);
}

void SailDemoPlayer_State_Playback(StageTask *work)
{
    GameState *state = GetGameState();

    work->userTimer++;

    work->userWork++;
    if (work->userWork > 160)
        work->userWork = 0;

    // Handle flashing sprite
    work->displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
    if (work->userWork > 60 && work->userWork < 80 || work->userWork > 140)
        work->displayFlag |= DISPLAY_FLAG_NO_DRAW;

    if (work->userWork == 0)
        StageTask__SetAnimation(work, 0);

    if (work->userWork == 80)
        StageTask__SetAnimation(work, 1);

    if ((work->userFlag & 1) == 0 && IsDrawFadeTaskFinished())
    {
        if ((PAD_Read() & (PAD_BUTTON_Y | PAD_BUTTON_X | PAD_BUTTON_START | PAD_BUTTON_B | PAD_BUTTON_A)) != 0 || CheckAnyTouchForSailDemoPlayer())
        {
            RequestSysEventChange(5); // SYSEVENT_TITLE
            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(4.0));
            work->userFlag |= 1;
            CreateSailExitEvent();
        }

        if (work->userTimer > sailDemoList[state->curDemoID].duration)
        {
            RequestSysEventChange(6); // SYSEVENT_SPLASH_SCREEN
            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(1.0));
            work->userFlag |= 1;
            CreateSailExitEvent();
        }
    }
}

BOOL CheckAnyTouchForSailDemoPlayer(void)
{
    TPData result;

    while (TP_RequestCalibratedSampling(&result) != 0)
    {
        // waiting...
        // (waits until there is data to return!)
    }

    return result.touch == TP_TOUCH_ON && result.validity == TP_VALIDITY_VALID;
}