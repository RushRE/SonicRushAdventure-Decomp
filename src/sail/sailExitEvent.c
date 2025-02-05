#include <sail/sailExitEvent.h>
#include <game/game/gameState.h>
#include <game/graphics/drawFadeTask.h>
#include <game/input/replayRecorder.h>
#include <game/system/sysEvent.h>
#include <game/system/task.h>
#include <seaMap/seaMapView.h>
#include <sail/vikingCupManager.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SailExitEvent_Main(void);

// --------------------
// FUNCTIONS
// --------------------

void CreateSailExitEvent(void)
{
    TaskCreateNoWork(SailExitEvent_Main, NULL, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 2, TASK_GROUP(4), "SailExitEvent");
}

void SailExitEvent_Main(void)
{
    GameState *state = GetGameState();

    if (!IsDrawFadeTaskFinished())
        return;

    state->sailUnknownFlags &= ~1;
    VikingCupManager__Func_2063C40();

    for (u8 id = 0; id < 6; id++)
    {
        DestroyTaskGroup(id);
    }

    SetPadReplayState(REPLAY_MODE_FORCE_QUIT);
    SetTouchReplayState(REPLAY_MODE_FORCE_QUIT);

    NextSysEvent();
}

BOOL CheckSailExitEventHasMap(void)
{
    return seaMapViewMode == 5;
}