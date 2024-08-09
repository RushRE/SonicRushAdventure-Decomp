#include <stage/core/stageStart.h>
#include <stage/core/titleCard.h>
#include <game/graphics/drawFadeTask.h>
#include <game/system/sysEvent.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void StageStart_Main(void);

// --------------------
// FUNCTIONS
// --------------------

void CreateStageStart(void)
{
    Task *task = TaskCreate(StageStart_Main, NULL, TASK_FLAG_NONE, 2, TASK_PRIORITY_UPDATE_LIST_START + 0x109D, TASK_SCOPE_3, StageStart);

    StageStart *work = TaskGetWork(task, StageStart);
    TaskInitWork16(work);

    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(1.0));
}

void StageStart_Main(void)
{
    StageStart *work = TaskGetWorkCurrent(StageStart);

    if (!gmCheckVsBattleFlag() && (playerGameStatus.input.btnPress & (PAD_BUTTON_A | PAD_BUTTON_B | PAD_BUTTON_X | PAD_BUTTON_Y)) != 0)
        TitleCard__SetFinished();

    switch (TitleCard__GetProgress())
    {
        case TITLECARD_PROGRESS_WAITING_TITLECARD_START:
            if (work->timer++ > 15)
            {
                work->timer = 0;
                TitleCard__SetAllowContinue();
            }
            break;

        case TITLECARD_PROGRESS_WAITING_TITLECARD_COMPLETE:
            gPlayer->playerFlag &= ~PLAYER_FLAG_DISABLE_INPUT_READ;
            RequestSysEventChange(0);
            NextSysEvent();
            TitleCard__SetAllowContinue();
            DestroyCurrentTask();
            break;
    }
}
