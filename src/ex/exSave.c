#include <ex/system/exSave.h>
#include <ex/system/exSystem.h>
#include <game/save/saveGame.h>
#include <game/stage/gameSystem.h>
#include <game/system/sysEvent.h>

// --------------------
// FUNCTIONS
// --------------------

void EndExBossStage(ExFinishMode mode)
{
    switch (mode)
    {
        case EXFINISHMODE_BOSS_DEFEATED:
        case EXFINISHMODE_STAGE_CLEARED:
            playerGameStatus.ringBonus  = GetExSystemStatus()->rings;
            playerGameStatus.stageTimer = GetExSystemStatus()->time.seconds;
            playerGameStatus.stageTimer += 10 * GetExSystemStatus()->time.tenSeconds;
            playerGameStatus.stageTimer = 60 * (playerGameStatus.stageTimer + 60 * GetExSystemStatus()->time.minutes);
            saveGame.stage.status.lives = GetExSystemLifeCount();
            SaveGame__SetUnknown1(9);
            RequestSysEventChange(0); // SYSEVENT_TITLE
            break;

        case EXFINISHMODE_USER_QUIT:
            saveGame.stage.status.lives = GetExSystemLifeCount();
            RequestSysEventChange(1); // SYSEVENT_LOAD_STAGE
            break;

        case EXFINISHMODE_GAME_OVER:
            saveGame.stage.status.lives = PLAYER_STARTING_LIVES;
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
