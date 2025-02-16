#include <hub/cviTalkOptions.hpp>
#include <hub/hubControl.hpp>
#include <hub/cviDockNpcTalk.hpp>
#include <game/save/saveGame.h>
#include <game/save/saveManager.h>
#include <game/file/fileUnknown.h>
#include <hub/hubConfig.h>

// --------------------
// FUNCTIONS
// --------------------

void CViTalkOptions::Create(s32 param)
{
    Task *task = HubTaskCreate(CViTalkOptions::Main_Init, CViTalkOptions::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(16), CViTalkOptions);

    CViTalkOptions *work = TaskGetWork(task, CViTalkOptions);

    work->InitDisplay();

    InitThreadWorker(&work->thread, 0x400);
    CreateThreadWorker(&work->thread, CViTalkOptions::ThreadFunc, work, 20);
}

void CViTalkOptions::ThreadFunc(void *arg)
{
    // Nothing to do.
}

void CViTalkOptions::InitDisplay()
{
    HubControl::InitEngineAForTalk();
}

void CViTalkOptions::Release()
{
    JoinThreadWorker(&this->thread);
    ReleaseThreadWorker(&this->thread);

    this->eventTalk.Release();
    this->ResetDisplay();
}

void CViTalkOptions::ResetDisplay()
{
    HubControl::InitEngineAFor3DHub();
}

void CViTalkOptions::Main_Init(void)
{
    CViTalkOptions *work = TaskGetWorkCurrent(CViTalkOptions);

    if (IsThreadWorkerFinished(&work->thread))
    {
        const HubOptionsMsgConfig *config = HubConfig__GetOptionsMsgConfig();

        work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetMsgControlArchive(), config->msgCtrlFile), config->msgTextID[0], CVIEVTCMN_RESOURCE_NONE);
        work->eventTalk.SetPage(0);
        SetCurrentTaskMainEvent(CViTalkOptions::Main_ChooseOption);
    }
}

void CViTalkOptions::Main_ChooseOption(void)
{
    CViTalkOptions *work;
    const HubOptionsMsgConfig *config;

    work = TaskGetWorkCurrent(CViTalkOptions);

    work->eventTalk.ProcessDialog();
    if (work->eventTalk.IsFinished())
    {
        config = HubConfig__GetOptionsMsgConfig();

        u32 action    = work->eventTalk.GetAction();
        u32 selection = work->eventTalk.GetSelection();
        if (action != CViEvtCmnTalk::ACTION_NONE || selection == 0)
        {
            CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_NONE);
            CViDockNpcTalk::SetSelection(0);
            DestroyCurrentTask();
        }
        else
        {
            u16 msgTextID;
            if (selection == 1)
            {
                if (CViTalkOptions::GetNormalDifficultyEnabled())
                    msgTextID = config->msgTextID[1];
                else
                    msgTextID = config->msgTextID[2];

                work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetMsgControlArchive(), config->msgCtrlFile), msgTextID, CVIEVTCMN_RESOURCE_NONE);
                work->eventTalk.SetPage(0);
                SetCurrentTaskMainEvent(CViTalkOptions::Main_ChangeDifficulty);
            }
            else if (selection == 2)
            {
                if (CViTalkOptions::GetTimeLimit())
                    msgTextID = config->msgTextID[3];
                else
                    msgTextID = config->msgTextID[4];

                work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetMsgControlArchive(), config->msgCtrlFile), msgTextID, CVIEVTCMN_RESOURCE_NONE);
                work->eventTalk.SetPage(0);
                SetCurrentTaskMainEvent(CViTalkOptions::Main_ChangeTimeLimit);
            }
            else
            {
                work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetMsgControlArchive(), config->msgCtrlFile), config->msgTextID[5], CVIEVTCMN_RESOURCE_NONE);
                work->eventTalk.SetPage(0);
                SetCurrentTaskMainEvent(CViTalkOptions::Main_ClearSaveDataWarning);
            }
        }
    }
}

void CViTalkOptions::Main_ChangeDifficulty(void)
{
    CViTalkOptions *work;
    const HubOptionsMsgConfig *config;

    BOOL saveError = FALSE;

    work = TaskGetWorkCurrent(CViTalkOptions);

    work->eventTalk.ProcessDialog();
    if (work->eventTalk.IsFinished())
    {
        config = HubConfig__GetOptionsMsgConfig();

        u32 action    = work->eventTalk.GetAction();
        u32 selection = work->eventTalk.GetSelection();
        if (action == CViEvtCmnTalk::ACTION_NONE && selection >= 1)
        {
            switch (selection)
            {
                case 1:
                    if (!CViTalkOptions::EnableNormalDifficulty(TRUE))
                        saveError = TRUE;
                    break;

                default:
                    if (!CViTalkOptions::EnableNormalDifficulty(FALSE))
                        saveError = TRUE;
                    break;
            }
        }

        if (saveError)
        {
            CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_CORRUPT_SAVE);
            CViDockNpcTalk::SetSelection(0);
            DestroyCurrentTask();
        }
        else
        {
            work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetMsgControlArchive(), config->msgCtrlFile), config->msgTextID[0], CVIEVTCMN_RESOURCE_NONE);
            work->eventTalk.SetPage(0);
            SetCurrentTaskMainEvent(CViTalkOptions::Main_ChooseOption);
        }
    }
}

void CViTalkOptions::Main_ChangeTimeLimit(void)
{
    CViTalkOptions *work;
    const HubOptionsMsgConfig *config;

    BOOL saveError = FALSE;

    work = TaskGetWorkCurrent(CViTalkOptions);

    work->eventTalk.ProcessDialog();
    if (work->eventTalk.IsFinished())
    {
        config = HubConfig__GetOptionsMsgConfig();

        u32 action    = work->eventTalk.GetAction();
        u32 selection = work->eventTalk.GetSelection();
        if (action == CViEvtCmnTalk::ACTION_NONE && selection >= 1)
        {
            switch (selection)
            {
                case 1:
                    if (!CViTalkOptions::EnableTimeLimit(TRUE))
                        saveError = TRUE;
                    break;

                default:
                    if (!CViTalkOptions::EnableTimeLimit(FALSE))
                        saveError = TRUE;
                    break;
            }
        }

        if (saveError)
        {
            CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_CORRUPT_SAVE);
            CViDockNpcTalk::SetSelection(0);
            DestroyCurrentTask();
        }
        else
        {
            work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetMsgControlArchive(), config->msgCtrlFile), config->msgTextID[0], CVIEVTCMN_RESOURCE_NONE);
            work->eventTalk.SetPage(0);
            SetCurrentTaskMainEvent(CViTalkOptions::Main_ChooseOption);
        }
    }
}

void CViTalkOptions::Main_ClearSaveDataWarning(void)
{
    CViTalkOptions *work = TaskGetWorkCurrent(CViTalkOptions);

    work->eventTalk.ProcessDialog();
    if (work->eventTalk.IsFinished())
    {
        const HubOptionsMsgConfig *config = HubConfig__GetOptionsMsgConfig();

        s32 action    = work->eventTalk.GetAction();
        s32 selection = work->eventTalk.GetSelection();
        if (action == CViEvtCmnTalk::ACTION_NONE && selection == 1)
        {
            CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_OPEN_DELETE_SAVE_MENU);
            CViDockNpcTalk::SetSelection(0);
            DestroyCurrentTask();
        }
        else
        {
            work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetMsgControlArchive(), config->msgCtrlFile), config->msgTextID[0], CVIEVTCMN_RESOURCE_NONE);
            work->eventTalk.SetPage(0);
            SetCurrentTaskMainEvent(CViTalkOptions::Main_ChooseOption);
        }
    }
}

void CViTalkOptions::Destructor(Task *task)
{
    CViTalkOptions *work = TaskGetWork(task, CViTalkOptions);

    work->Release();

    HubTaskDestroy<CViTalkOptions>(task);
}

BOOL CViTalkOptions::GetNormalDifficultyEnabled(void)
{
    return saveGame.stage.status.difficulty != DIFFICULTY_EASY;
}

BOOL CViTalkOptions::GetTimeLimit(void)
{
    return saveGame.stage.status.timeLimit != FALSE;
}

BOOL CViTalkOptions::EnableNormalDifficulty(BOOL enabled)
{
    if (enabled)
        saveGame.stage.status.difficulty = DIFFICULTY_NORMAL;
    else
        saveGame.stage.status.difficulty = DIFFICULTY_EASY;

    return TrySaveGameData(SAVE_TYPE_STAGE);
}

BOOL CViTalkOptions::EnableTimeLimit(BOOL enabled)
{
    if (enabled)
        saveGame.stage.status.timeLimit = TRUE;
    else
        saveGame.stage.status.timeLimit = FALSE;

    return TrySaveGameData(SAVE_TYPE_STAGE);
}