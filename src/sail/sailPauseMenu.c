#include <sail/sailPauseMenu.h>
#include <sail/sailHUD.h>
#include <sail/sailManager.h>
#include <game/input/replayRecorder.h>
#include <sail/sailInitEvent.h>
#include <game/graphics/drawReqTask.h>
#include <sail/sailAudio.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED StageTask *SailPauseMessage__Create(void);
NOT_DECOMPILED StageTask *SailArriveMessageOptionFail__Create(void);
NOT_DECOMPILED void SailRetireEvent__CreateFadeOut(void);
NOT_DECOMPILED u16 SailMessageCommon__Func_21729F4(StageTask *work);

// --------------------
// FUNCTIONS
// --------------------

static void SailReplayPauseMenu_Main(void);
static void SailPauseMenu_Main(void);

// --------------------
// FUNCTIONS
// --------------------

void CreateSailPauseMenu(void)
{
    Task *task;
    SailPauseMenu *work;

    SailManager *manager = SailManager__GetWork();

    task = TaskCreate(SailPauseMenu_Main, NULL, TASK_FLAG_NONE, TASK_PAUSELEVEL_3, TASK_PRIORITY_UPDATE_LIST_START + 0x1000, TASK_GROUP(1), SailPauseMenu);
    work = TaskGetWork(task, SailPauseMenu);
    TaskInitWork16(work);

    if (CheckTaskPaused(&work->prevPausePriority))
        work->flags |= SAILPAUSEMENU_FLAG_DID_PAUSE;

    DrawReqTask__Create(TASK_PAUSELEVEL_2, TRUE, TRUE, TRUE);

    work->flags |= SAILPAUSEMENU_FLAG_PLAY_PAUSE_SFX;
    manager->flags |= SAILMANAGER_FLAG_10000000;

    work->parent = SailPauseMessage__Create();
}

void CreateSailReplayPauseMenu(void)
{
    Task *task;
    SailPauseMenu *work;

    SailManager *manager = SailManager__GetWork();

    task = TaskCreate(SailReplayPauseMenu_Main, NULL, TASK_FLAG_NONE, 3, TASK_PRIORITY_UPDATE_LIST_START + 0x1000, TASK_GROUP(1), SailPauseMenu);
    work = TaskGetWork(task, SailPauseMenu);
    TaskInitWork16(work);

    if (CheckTaskPaused(&work->prevPausePriority))
        work->flags |= SAILPAUSEMENU_FLAG_DID_PAUSE;

    DrawReqTask__Create(TASK_PAUSELEVEL_2, TRUE, TRUE, TRUE);

    work->flags |= SAILPAUSEMENU_FLAG_PLAY_PAUSE_SFX;

    SetPadReplayState(REPLAY_MODE_FINISHED);
    SetTouchReplayState(REPLAY_MODE_FINISHED);

    manager->flags |= SAILMANAGER_FLAG_10000000;

    work->parent = SailArriveMessageOptionFail__Create();
}

void SailReplayPauseMenu_Main(void)
{
    SailPauseMenu *work  = TaskGetWorkCurrent(SailPauseMenu);
    SailManager *manager = SailManager__GetWork();

    if (work->parent != NULL && IsStageTaskDestroyed(work->parent))
    {
        work->selection = SailMessageCommon__Func_21729F4(work->parent);
        work->parent    = NULL;
    }

    if ((work->flags & SAILPAUSEMENU_FLAG_PLAY_PAUSE_SFX) != 0)
    {
        NNS_SndPlayerPauseAll(TRUE);
        SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_T_DECIDE, NULL);
        work->flags &= ~SAILPAUSEMENU_FLAG_PLAY_PAUSE_SFX;
    }
    else if ((manager->flags & SAILMANAGER_FLAG_10) == 0)
    {
        DrawReqTask__Enable();

        if ((work->flags & SAILPAUSEMENU_FLAG_DID_PAUSE) != 0)
            DrawReqTask__Create(work->prevPausePriority, TRUE, TRUE, TRUE);

        NNS_SndPlayerMoveVolume(&defaultTrackPlayer, 0, 30);
        SailRetireEvent__CreateFadeOut();
        SetPadReplayState(REPLAY_MODE_PLAYBACK);
        SetTouchReplayState(REPLAY_MODE_PLAYBACK);
        DestroyCurrentTask();
    }
}

void SailPauseMenu_Main(void)
{
    SailPauseMenu *work;
    SailManager *manager;
    GameState *state;

    work    = TaskGetWorkCurrent(SailPauseMenu);
    state   = GetGameState();
    manager = SailManager__GetWork();

    if (work->parent != NULL && IsStageTaskDestroyed(work->parent))
    {
        work->selection = SailMessageCommon__Func_21729F4(work->parent);
        work->parent    = NULL;
    }

    if ((work->flags & SAILPAUSEMENU_FLAG_PLAY_PAUSE_SFX) != 0)
    {
        NNS_SndPlayerPauseAll(TRUE);
        SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_T_DECIDE, NULL);
        work->flags &= ~SAILPAUSEMENU_FLAG_PLAY_PAUSE_SFX;
    }
    else if ((manager->flags & SAILMANAGER_FLAG_10) == 0)
    {
        DrawReqTask__Enable();
        NNS_SndPlayerPauseAll(FALSE);

        if ((work->flags & SAILPAUSEMENU_FLAG_DID_PAUSE) != 0)
            DrawReqTask__Create(work->prevPausePriority, TRUE, TRUE, TRUE);

        manager->flags |= SAILMANAGER_FLAG_DISABLE_BTN_PRESS;

        if ((manager->flags & SAILMANAGER_FLAG_FREEZE_DAYTIME_TIMER) != 0 && (work->flags & SAILPAUSEMENU_FLAG_UNKNOWN2) == 0)
            work->flags |= SAILPAUSEMENU_FLAG_UNKNOWN1;

        if ((manager->flags & (SAILMANAGER_FLAG_2000000 | SAILMANAGER_FLAG_4000 | SAILMANAGER_FLAG_40 | SAILMANAGER_FLAG_20 | SAILMANAGER_FLAG_8)) != 0)
            work->selection = 0; // set selection to 'resume'

        switch ((s16)work->selection)
        {
                // case 0: // resume
                //     break;

            case 1: // restart
                state->missionType                 = manager->missionType;
                state->missionConfig.sail.courseID = manager->missionID;
                state->missionConfig.sail.unknown  = manager->missionQuota;
                state->sailVsJohnny                = manager->isRivalRace;
                state->sailVsJohnnyID              = manager->rivalRaceID;

                if ((manager->flags & SAILMANAGER_FLAG_100000) != 0)
                    state->sailVsJohnnyID += 10;

                if (manager->isRivalRace == FALSE)
                {
                    UNUSED(SailManager__GetWork());
                }

                manager->nextEvent = 4;
                manager->flags |= SAILMANAGER_FLAG_8;
                manager->flags |= SAILMANAGER_FLAG_8000;
                NNS_SndPlayerMoveVolume(&defaultTrackPlayer, 0, 30);
                SailRetireEvent__CreateFadeOut();
                break;

            case 2: // return to hub
                ResetSailState();
                manager->nextEvent = 0;
                manager->flags |= SAILMANAGER_FLAG_8;
                NNS_SndPlayerMoveVolume(&defaultTrackPlayer, 0, 30);
                SailRetireEvent__CreateFadeOut();
                break;
        }

        DestroyCurrentTask();
    }
}
