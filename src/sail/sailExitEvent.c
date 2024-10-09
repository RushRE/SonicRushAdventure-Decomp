#include <sail/sailExitEvent.h>
#include <game/game/gameState.h>
#include <game/graphics/drawFadeTask.h>
#include <game/input/replayRecorder.h>
#include <game/system/sysEvent.h>
#include <game/system/task.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void MultibootManager__Func_2063C40(void);

// --------------------
// FUNCTIONS
// --------------------

void SailExitEvent__Create(void)
{
    TaskCreateNoWork(SailExitEvent__Main, NULL, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 2, TASK_SCOPE_4, "SailExitEvent");
}

void SailExitEvent__Main(void)
{
    if (!IsDrawFadeTaskFinished())
        return

    gameState.shipType &= ~SHIP_BOAT;
    MultibootManager__Func_2063C40();

    for (u8 id = 0; id < 6; id++)
    {
        ClearTaskScope(id);
    }

    SetPadReplayState(REPLAY_MODE_FORCE_QUIT);
    SetTouchReplayState(REPLAY_MODE_FORCE_QUIT);

    NextSysEvent();
}

BOOL SailExitEvent__Func_218B400(void)
{
    return GetPadReplayState() == REPLAY_MODE_FORCE_QUIT;
}