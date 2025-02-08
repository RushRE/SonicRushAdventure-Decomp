#include <hub/npcOptions.hpp>
#include <hub/hubControl.hpp>
#include <hub/cviDockNpcTalk.hpp>
#include <game/save/saveGame.h>
#include <game/save/saveManager.h>
#include <game/file/fileUnknown.h>
#include <hub/dockHelpers.h>

// --------------------
// FUNCTIONS
// --------------------

void NpcOptions::Create(s32 param)
{
    Task *task = HubTaskCreate(NpcOptions::Main_Init, NpcOptions::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(16), NpcOptions);

    NpcOptions *work = TaskGetWork(task, NpcOptions);

    work->InitDisplay();

    InitThreadWorker(&work->thread, 0x400);
    CreateThreadWorker(&work->thread, NpcOptions::ThreadFunc, work, 20);
}

void NpcOptions::ThreadFunc(void *arg)
{
    // Nothing to do.
}

void NpcOptions::InitDisplay()
{
    HubControl::Func_215A888();
}

void NpcOptions::Release()
{
    JoinThreadWorker(&this->thread);
    ReleaseThreadWorker(&this->thread);

    this->viEvtCmnTalk.Release();
    this->ResetDisplay();
}

void NpcOptions::ResetDisplay()
{
    HubControl::Func_215A96C();
}

void NpcOptions::Main_Init(void)
{
    NpcOptions *work = TaskGetWorkCurrent(NpcOptions);

    if (IsThreadWorkerFinished(&work->thread))
    {
        OptionsMessageConfig *config = DockHelpers__GetOptionsMessageInfo();

        work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), config->msgCtrlFile), config->msgTextID[0], CVIEVTCMN_RESOURCE_NONE);
        work->viEvtCmnTalk.SetPage(0);
        SetCurrentTaskMainEvent(NpcOptions::Main_ChooseOption);
    }
}

void NpcOptions::Main_ChooseOption(void)
{
    NpcOptions *work;
    OptionsMessageConfig *config;

    work = TaskGetWorkCurrent(NpcOptions);

    work->viEvtCmnTalk.ProcessDialog();
    if (work->viEvtCmnTalk.IsFinished())
    {
        config = DockHelpers__GetOptionsMessageInfo();

        u32 action    = work->viEvtCmnTalk.GetAction();
        u32 selection = work->viEvtCmnTalk.GetSelection();
        if (action != 0 || selection == 0)
        {
            CViDockNpcTalk::SetTalkAction(0);
            CViDockNpcTalk::SetSelection(0);
            DestroyCurrentTask();
        }
        else
        {
            u16 msgTextID;
            if (selection == 1)
            {
                if (NpcOptions::GetNormalDifficultyEnabled())
                    msgTextID = config->msgTextID[1];
                else
                    msgTextID = config->msgTextID[2];

                work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), config->msgCtrlFile), msgTextID, CVIEVTCMN_RESOURCE_NONE);
                work->viEvtCmnTalk.SetPage(0);
                SetCurrentTaskMainEvent(NpcOptions::Main_ChangeDifficulty);
            }
            else if (selection == 2)
            {
                if (NpcOptions::GetTimeLimit())
                    msgTextID = config->msgTextID[3];
                else
                    msgTextID = config->msgTextID[4];

                work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), config->msgCtrlFile), msgTextID, CVIEVTCMN_RESOURCE_NONE);
                work->viEvtCmnTalk.SetPage(0);
                SetCurrentTaskMainEvent(NpcOptions::Main_ChangeTimeLimit);
            }
            else
            {
                work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), config->msgCtrlFile), config->msgTextID[5], CVIEVTCMN_RESOURCE_NONE);
                work->viEvtCmnTalk.SetPage(0);
                SetCurrentTaskMainEvent(NpcOptions::Main_ClearSaveDataWarning);
            }
        }
    }
}

void NpcOptions::Main_ChangeDifficulty(void)
{
    NpcOptions *work;
    OptionsMessageConfig *config;

    BOOL saveError = FALSE;

    work = TaskGetWorkCurrent(NpcOptions);

    work->viEvtCmnTalk.ProcessDialog();
    if (work->viEvtCmnTalk.IsFinished())
    {
        config = DockHelpers__GetOptionsMessageInfo();

        u32 action    = work->viEvtCmnTalk.GetAction();
        u32 selection = work->viEvtCmnTalk.GetSelection();
        if (action == 0 && selection >= 1)
        {
            switch (selection)
            {
                case 1:
                    if (!NpcOptions::EnableNormalDifficulty(TRUE))
                        saveError = TRUE;
                    break;

                default:
                    if (!NpcOptions::EnableNormalDifficulty(FALSE))
                        saveError = TRUE;
                    break;
            }
        }

        if (saveError)
        {
            CViDockNpcTalk::SetTalkAction(30);
            CViDockNpcTalk::SetSelection(0);
            DestroyCurrentTask();
        }
        else
        {
            work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), config->msgCtrlFile), config->msgTextID[0], CVIEVTCMN_RESOURCE_NONE);
            work->viEvtCmnTalk.SetPage(0);
            SetCurrentTaskMainEvent(NpcOptions::Main_ChooseOption);
        }
    }
}

void NpcOptions::Main_ChangeTimeLimit(void)
{
    NpcOptions *work;
    OptionsMessageConfig *config;

    BOOL saveError = FALSE;

    work = TaskGetWorkCurrent(NpcOptions);

    work->viEvtCmnTalk.ProcessDialog();
    if (work->viEvtCmnTalk.IsFinished())
    {
        config = DockHelpers__GetOptionsMessageInfo();

        u32 action    = work->viEvtCmnTalk.GetAction();
        u32 selection = work->viEvtCmnTalk.GetSelection();
        if (action == 0 && selection >= 1)
        {
            switch (selection)
            {
                case 1:
                    if (!NpcOptions::EnableTimeLimit(TRUE))
                        saveError = TRUE;
                    break;

                default:
                    if (!NpcOptions::EnableTimeLimit(FALSE))
                        saveError = TRUE;
                    break;
            }
        }

        if (saveError)
        {
            CViDockNpcTalk::SetTalkAction(30);
            CViDockNpcTalk::SetSelection(0);
            DestroyCurrentTask();
        }
        else
        {
            work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), config->msgCtrlFile), config->msgTextID[0], CVIEVTCMN_RESOURCE_NONE);
            work->viEvtCmnTalk.SetPage(0);
            SetCurrentTaskMainEvent(NpcOptions::Main_ChooseOption);
        }
    }
}

void NpcOptions::Main_ClearSaveDataWarning(void)
{
    NpcOptions *work = TaskGetWorkCurrent(NpcOptions);

    work->viEvtCmnTalk.ProcessDialog();
    if (work->viEvtCmnTalk.IsFinished())
    {
        OptionsMessageConfig *config = DockHelpers__GetOptionsMessageInfo();

        s32 action    = work->viEvtCmnTalk.GetAction();
        s32 selection = work->viEvtCmnTalk.GetSelection();
        if (action == 0 && selection == 1)
        {
            CViDockNpcTalk::SetTalkAction(14);
            CViDockNpcTalk::SetSelection(0);
            DestroyCurrentTask();
        }
        else
        {
            work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), config->msgCtrlFile), config->msgTextID[0], CVIEVTCMN_RESOURCE_NONE);
            work->viEvtCmnTalk.SetPage(0);
            SetCurrentTaskMainEvent(NpcOptions::Main_ChooseOption);
        }
    }
}

void NpcOptions::Destructor(Task *task)
{
    NpcOptions *work = TaskGetWork(task, NpcOptions);

    work->Release();

    HubTaskDestroy<NpcOptions>(task);
}

BOOL NpcOptions::GetNormalDifficultyEnabled(void)
{
    return saveGame.stage.status.difficulty != DIFFICULTY_EASY;
}

BOOL NpcOptions::GetTimeLimit(void)
{
    return saveGame.stage.status.timeLimit != FALSE;
}

BOOL NpcOptions::EnableNormalDifficulty(BOOL enabled)
{
    if (enabled)
        saveGame.stage.status.difficulty = DIFFICULTY_NORMAL;
    else
        saveGame.stage.status.difficulty = DIFFICULTY_EASY;

    return TrySaveGameData(SAVE_TYPE_STAGE);
}

BOOL NpcOptions::EnableTimeLimit(BOOL enabled)
{
    if (enabled)
        saveGame.stage.status.timeLimit = TRUE;
    else
        saveGame.stage.status.timeLimit = FALSE;

    return TrySaveGameData(SAVE_TYPE_STAGE);
}