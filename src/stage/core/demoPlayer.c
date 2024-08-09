#include <stage/core/demoPlayer.h>
#include <game/system/sysEvent.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/graphics/vramSystem.h>
#include <game/file/binaryBundle.h>
#include <game/graphics/renderCore.h>
#include <game/input/replayRecorder.h>
#include <game/graphics/drawFadeTask.h>
#include <game/graphics/drawReqTask.h>

// --------------------
// VARIABLES
// --------------------

static DemoState demoState;

#ifndef NON_MATCHING
// TODO: not sure how variable ordering works.... these variables force the order of the strings (01, 00, 02) to match the final rom!
static const char *TEMP_02 = "/keydat/pd_game02.dat";
static const char *TEMP_00 = "/keydat/pd_game00.dat";
static const char *TEMP_01 = "/keydat/pd_game01.dat";
#endif

static DemoConfig demoList[] = {
    {
        .keydataPath  = "/keydat/pd_game00.dat",
        .spawnX       = FLOAT_TO_FX32(0.0),
        .spawnY       = FLOAT_TO_FX32(0.0),
        .demoDuration = SECONDS_TO_FRAMES(33.34),
        .stageID      = STAGE_Z11,
        .characterID  = CHARACTER_SONIC,
    },

    {
        .keydataPath  = "/keydat/pd_game01.dat",
        .spawnX       = FLOAT_TO_FX32(0.0),
        .spawnY       = FLOAT_TO_FX32(0.0),
        .demoDuration = SECONDS_TO_FRAMES(34.167),
        .stageID      = STAGE_Z1B,
        .characterID  = CHARACTER_SONIC,
    },

    {
        .keydataPath  = "/keydat/pd_game02.dat",
        .spawnX       = FLOAT_TO_FX32(8199.0),
        .spawnY       = FLOAT_TO_FX32(2642.0),
        .demoDuration = SECONDS_TO_FRAMES(15.734),
        .stageID      = STAGE_Z21,
        .characterID  = CHARACTER_BLAZE,
    },
};

// --------------------
// FUNCTION DECLS
// --------------------

static void DemoPlayer_Destructor(Task *task);
static void DemoPlayer_Main_PlaybackActive(void);
static void DemoPlayer_Main_FinishedPlayback(void);
static void DemoPlayer_Draw(DemoPlayer *work);

// --------------------
// FUNCTIONS
// --------------------

void InitZoneDemoEvent(void)
{
    GameState *state = GetGameState();

    state->characterID[0]      = demoList[state->nextDemoID].characterID;
    state->characterID[1]      = demoList[state->nextDemoID].characterID;
    state->nextDemoCharacterID = demoList[state->nextDemoID].characterID ^ 1; // swap characters after every demo

    state->gameFlag = GAME_FLAG_NONE;
    state->gameMode = GAMEMODE_DEMO;
    state->stageID  = demoList[state->nextDemoID].stageID;
    RequestSysEventChange(0); // SYSEVENT_LOAD_STAGE

    demoState        = DEMOPLAYER_STATE_NOT_SKIPPED;
    state->curDemoID = state->nextDemoID;

    state->nextDemoID++;
    if (state->nextDemoID >= ARRAY_COUNT(demoList))
        state->nextDemoID = 0;

    NextSysEvent();
}

const char *GetCurrentDemoPath(void)
{
    return demoList[gameState.curDemoID].keydataPath;
}

void GetDemoSpawnPosition(fx32 *x, fx32 *y)
{
    *x = demoList[gameState.curDemoID].spawnX;
    *y = demoList[gameState.curDemoID].spawnY;
}

BOOL HasDemoSpawnPos(void)
{
    if (demoList[gameState.curDemoID].spawnX != 0 || demoList[gameState.curDemoID].spawnY != 0)
        return TRUE;
    else
        return FALSE;
}

void CreateDemoPlayer(void)
{
    VRAMPaletteKey pixelKeys[2][2] = { { NULL, NULL }, { NULL, NULL } };

    Task *task = TaskCreate(DemoPlayer_Main_PlaybackActive, DemoPlayer_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0xFFF, TASK_SCOPE_3, DemoPlayer);
    if (task == HeapNull)
        return;

    DemoPlayer *work = TaskGetWork(task, DemoPlayer);
    TaskInitWork16(work);

    work->sprDemoPlay = ReadFileFromBundle("/bb/gm_demoplay.bb", BUNDLE_GM_DEMOPLAY_FILE_DEMO_TEXT_JPN_BAC + GetGameLanguage(), NULL);

    AnimatorSpriteDS *animator = work->aniDemoPlay;
    for (u16 i = 0; i < DEMOPLAY_ANIMATOR_COUNT; i++, animator++)
    {
        u32 size        = Sprite__GetSpriteSize2FromAnim(work->sprDemoPlay, i);
        pixelKeys[i][0] = VRAMSystem__AllocSpriteVram(FALSE, size);

        u32 screensToDraw;
        AnimatorFlags flags;
        if (IsBossStage())
        {
            screensToDraw = SCREEN_DRAW_B;
            flags         = ANIMATOR_FLAG_NONE;
        }
        else
        {
            pixelKeys[i][1] = VRAMSystem__AllocSpriteVram(TRUE, size);
            screensToDraw   = SCREEN_DRAW_NONE;
            flags           = ANIMATOR_FLAG_DISABLE_PALETTES;
        }

        AnimatorSpriteDS__Init(animator, work->sprDemoPlay, i, screensToDraw, flags, PIXEL_MODE_SPRITE, pixelKeys[i][0], PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE,
                               pixelKeys[i][1], PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);

        animator->cParam[0].palette = animator->cParam[1].palette = PALETTE_ROW_2;
        AnimatorSpriteDS__ProcessAnimationFast(animator);

        animator->position[0].x = 128;
        animator->position[0].y = 96;

        animator->position[1].x = 128;
        animator->position[1].y = 96;
    }
}

u32 GetDemoState(void)
{
    return demoState;
}

void DemoPlayer_Destructor(Task *task)
{
    s32 i;
    DemoPlayer *work = TaskGetWork(task, DemoPlayer);

    for (i = 0; i < DEMOPLAY_ANIMATOR_COUNT; i++)
    {
        AnimatorSpriteDS__Release(&work->aniDemoPlay[i]);
    }

    HeapFree(HEAP_USER, work->sprDemoPlay);
}

void DemoPlayer_Main_PlaybackActive(void)
{
    DemoPlayer *work = TaskGetWorkCurrent(DemoPlayer);

    work->timer++;
    if (IsDrawFadeTaskFinished())
    {
        if (CheckPadButtonDown(PAD_BUTTON_A | PAD_BUTTON_B | PAD_BUTTON_START | PAD_BUTTON_X | PAD_BUTTON_Y) != 0 || TouchInput__IsTouchPush(&touchInput))
        {
            demoState = DEMOPLAYER_STATE_WAS_SKIPPED;
            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(4.0));
            NNS_SndPlayerStopSeqAll(4);
            SetCurrentTaskMainEvent(DemoPlayer_Main_FinishedPlayback);
        }
        else if (work->timer >= demoList[gameState.curDemoID].demoDuration)
        {
            demoState = DEMOPLAYER_STATE_NOT_SKIPPED;
            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(1.0));
            NNS_SndPlayerStopSeqAll(16);
            SetCurrentTaskMainEvent(DemoPlayer_Main_FinishedPlayback);
        }

        DemoPlayer_Draw(work);
    }
}

void DemoPlayer_Main_FinishedPlayback(void)
{
    if (IsDrawFadeTaskFinished())
    {
        DestroyCurrentTask();

        SetPadReplayState(REPLAY_MODE_FORCE_QUIT);
        ReleaseGameSystem();
        FlushGameSystem(GAMEDATA_LOADPROC_ALL);

        if (GetDemoState() == DEMOPLAYER_STATE_NOT_SKIPPED)
            RequestNewSysEventChange(SYSEVENT_SPLASH_SCREEN);
        else
            RequestNewSysEventChange(SYSEVENT_TITLE);

        NextSysEvent();
    }
    else
    {
        DemoPlayer *work = TaskGetWorkCurrent(DemoPlayer);
        DemoPlayer_Draw(work);
    }
}

void DemoPlayer_Draw(DemoPlayer *work)
{
    work->flashTimer++;

    // count from 0 -> 80
    // if the timer is between 0-59, draw!
    // if the timer is between 60-80, don't draw!
    if (work->flashTimer > 80)
    {
        work->flashTimer = 0;
    }
    else if (work->flashTimer > 60)
    {
        return;
    }

    if (!IsBossStage())
    {
        work->aniDemoPlay[DEMOPLAY_ANIMATOR_DEMO_PLAY].screensToDraw &= ~3;
        work->aniDemoPlay[DEMOPLAY_ANIMATOR_PRESS_START].screensToDraw &= ~3;

        if (MapSys__GetDispSelect() == GX_DISP_SELECT_SUB_MAIN)
        {
            work->aniDemoPlay[DEMOPLAY_ANIMATOR_DEMO_PLAY].screensToDraw |= SCREEN_DRAW_B;
            work->aniDemoPlay[DEMOPLAY_ANIMATOR_PRESS_START].screensToDraw |= SCREEN_DRAW_A;
        }
        else
        {
            work->aniDemoPlay[DEMOPLAY_ANIMATOR_DEMO_PLAY].screensToDraw |= SCREEN_DRAW_A;
            work->aniDemoPlay[DEMOPLAY_ANIMATOR_PRESS_START].screensToDraw |= SCREEN_DRAW_B;
        }

        AnimatorSpriteDS__DrawFrame(&work->aniDemoPlay[DEMOPLAY_ANIMATOR_DEMO_PLAY]);
        AnimatorSpriteDS__DrawFrame(&work->aniDemoPlay[DEMOPLAY_ANIMATOR_PRESS_START]);
    }
    else
    {
        if (Camera3D__UseEngineA())
            AnimatorSpriteDS__DrawFrame(&work->aniDemoPlay[DEMOPLAY_ANIMATOR_DEMO_PLAY]);
        else
            AnimatorSpriteDS__DrawFrame(&work->aniDemoPlay[DEMOPLAY_ANIMATOR_PRESS_START]);
    }
}
