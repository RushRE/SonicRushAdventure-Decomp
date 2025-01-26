#include <ex/system/exSave.h>
#include <ex/system/exSystem.h>
#include <game/save/saveGame.h>
#include <game/stage/gameSystem.h>
#include <game/system/sysEvent.h>

// --------------------
// FUNCTIONS
// --------------------

void exSysTask__EndStage(s32 mode)
{
    switch (mode)
    {
        case 2:
        case 3:
            playerGameStatus.ringBonus  = GetExSystemStatus()->rings;
            playerGameStatus.stageTimer = GetExSystemStatus()->time.seconds;
            playerGameStatus.stageTimer += 10 * GetExSystemStatus()->time.tenSeconds;
            playerGameStatus.stageTimer = 60 * (playerGameStatus.stageTimer + 60 * GetExSystemStatus()->time.minutes);
            saveGame.stage.status.lives = GetExSystemLifeCount();
            SaveGame__SetUnknown1(9);
            RequestSysEventChange(0); // SYSEVENT_TITLE
            break;

        case 5:
            saveGame.stage.status.lives = GetExSystemLifeCount();
            RequestSysEventChange(1); // SYSEVENT_LOAD_STAGE
            break;

        case 8:
            saveGame.stage.status.lives = 2;
            gameState.talk.field_DC     = 6;
            RequestSysEventChange(1); // SYSEVENT_LOAD_STAGE
            break;

        default:
            saveGame.stage.status.lives = GetExSystemLifeCount();
            RequestSysEventChange(1); // SYSEVENT_LOAD_STAGE
            break;
    }

    NextSysEvent();
}
