#include <game/game/gameState.h>
#include <game/system/sysEvent.h>
#include <game/graphics/vramSystem.h>
#include <game/stage/gameSystem.h>
#include <game/graphics/renderCore.h>
#include <game/input/replayRecorder.h>
#include <game/save/saveGame.h>
#include <game/audio/sysSound.h>
#include <stage/core/demoPlayer.h>
#include <hub/dockCommon.h>

// --------------------
// FUNCTION DECLS
// --------------------

void InitGameState(void);
static void ExitGameState(void);

// --------------------
// VARIABLES
// --------------------

GameState gameState;

// --------------------
// FUNCTIONS
// --------------------

void InitGameState(void)
{
    MI_SetMainMemoryPriority(MI_PROCESSOR_ARM7);

#ifdef RUSH_CONTEST
    GX_SetMasterBrightness(RENDERCORE_BRIGHTNESS_WHITE);
    GXS_SetMasterBrightness(RENDERCORE_BRIGHTNESS_WHITE);
#endif

    VRAMSystem__Init(VRAM_MODE_0);
    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_2D);
    GX_SetVisiblePlane(GX_PLANEMASK_NONE);
    GX_SetPower(GX_POWER_2D);
    GX_SetDispSelect(GX_DISP_SELECT_MAIN_SUB);
    GX_DispOn();
    GXS_DispOn();

    renderCoreGFXControlA.bgPosition[GRAPHICS_ENGINE_B].x = 0;
    renderCoreGFXControlA.bgPosition[GRAPHICS_ENGINE_B].y = 0;

    InitReplaySystem();

    CreateSysEvent(SYSEVENT_SAVE_INIT, TRUE, TASK_PRIORITY_UPDATE_LIST_START + 0x100, 0xF0);
}

void ExitGameState(void)
{
    ExitSysSound();
    SaveGame__GsExit(0);
}

void ChangeEventForStageStart(void)
{
    if (gameState.gameMode == GAMEMODE_VS_BATTLE)
    {
        // SYSEVENT_VSBATTLE
        RequestSysEventChange(3);
    }
    else if (IsBossStage() == FALSE)
    {
        // SYSEVENT_ZONEACT
        RequestSysEventChange(0);
    }
    else
    {
        if (GetCurrentZoneID() <= ZONE_BLIZZARD_PEAKS)
        {
            // SYSEVENT_BOSS1
            RequestSysEventChange(1);
        }
        else
        {
            // SYSEVENT_BOSS2
            RequestSysEventChange(2);
        }
    }
}

void ChangeEventForStageFinish(BOOL willRestartStage)
{
    GameState *state = GetGameState();

    s32 nextEvent = 0; // SYSEVENT_TITLECARD
    switch (gameState.gameMode)
    {
        case GAMEMODE_STORY:
            if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_PLAYER_DIED) != 0)
            {
                if (willRestartStage == FALSE)
                {
                    nextEvent                           = 3; // SYSEVENT_UPDATE_PROGRESS
                    gameState.talk.state.hubStartAction = HUB_STARTACTION_ZONE_GAME_OVER;
                    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
                }
            }
            else
            {
                nextEvent = 1; // SYSEVENT_STAGE_CLEAR
            }
            break;

        case GAMEMODE_TIMEATTACK:
            if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_PLAYER_DIED) != 0
                || (gameState.gameFlag & (GAME_FLAG_REPLAY_FINISHED | GAME_FLAG_REPLAY_STARTED)) == (GAME_FLAG_REPLAY_FINISHED | GAME_FLAG_REPLAY_STARTED))
            {
                nextEvent = 5; // SYSEVENT_21
            }
            else
            {
                nextEvent = 1; // SYSEVENT_STAGE_CLEAR
            }
            break;

        case GAMEMODE_DEMO:
            if (GetDemoState() == 0)
                nextEvent = 7; // SYSEVENT_SPLASH_SCREEN
            else
                nextEvent = 4; // SYSEVENT_TITLE
            break;

        case GAMEMODE_VS_BATTLE:
            nextEvent = 6; // SYSEVENT_VS_STAGE_CLEAR
            break;

        case GAMEMODE_MISSION:
            if (!state->clearedMission)
            {
                nextEvent                           = 5; // SYSEVENT_21
                gameState.talk.state.hubStartAction = HUB_STARTACTION_RESUME_MISSIONLIST_TALK;
                SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
            }
            else
            {
                nextEvent = 1; // SYSEVENT_STAGE_CLEAR
            }
            break;

        default:
            break;
    }

    RequestSysEventChange(nextEvent);
}

void ChangeEventForPauseMenuAction(BOOL isRestart)
{
    s32 nextEvent;

    if (isRestart)
    {
        nextEvent = 0; // SYSEVENT_TITLECARD (restart stage)
    }
    else
    {
        switch (gameState.gameMode)
        {
            case GAMEMODE_TIMEATTACK:
                nextEvent = 2; // SYSEVENT_24
                break;

            case GAMEMODE_MISSION:
                gameState.talk.state.hubStartAction = HUB_STARTACTION_RESUME_MISSIONLIST_TALK;
                nextEvent                           = 3; // SYSEVENT_UPDATE_PROGRESS
                SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
                break;

            // case GAMEMODE_STORY:
            // case GAMEMODE_VS_BATTLE:
            // case GAMEMODE_DEMO:
            default:
                nextEvent = 3; // SYSEVENT_UPDATE_PROGRESS
                SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
                break;
        }
    }

    RequestSysEventChange(nextEvent);
}

void ResetGameState(void)
{
    ExitGameState();
}

void ExitStageClearSysEvent(void)
{
    GameState *state = GetGameState();

    if (gmCheckGameMode(GAMEMODE_VS_BATTLE) && (state->gameFlag & GAME_FLAG_10) != 0)
    {
        EventID eventID = GetSysEventList()->requestedEventID;
        if (eventID != SYSEVENT_VS_MENU && eventID != SYSEVENT_24)
        {
            return;
        }
        else
        {
            FlushGameSystem(GAMEDATA_LOADPROC_COMMON);
        }
    }
    else
    {
        FlushGameSystem(GAMEDATA_LOADPROC_COMMON);
    }
}
