#include <hub/cviTalkGameOver.hpp>
#include <hub/hubControl.hpp>
#include <hub/cviDockNpcTalk.hpp>
#include <game/save/saveGame.h>
#include <game/file/fileUnknown.h>

// resources
#include <resources/narc/vi_msg_ctrl_lz7.h>

// --------------------
// FUNCTIONS
// --------------------

void CViTalkGameOver::Create(s32 param)
{
    Task *task = HubTaskCreate(CViTalkGameOver::Main_Init, CViTalkGameOver::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(16), CViTalkGameOver);

    CViTalkGameOver *work = TaskGetWork(task, CViTalkGameOver);
    if (!param)
        work->disableRetryPrompt = FALSE;
    else
        work->disableRetryPrompt = TRUE;

    work->InitDisplay();

    InitThreadWorker(&work->thread, 0x800);
    CreateThreadWorker(&work->thread, CViTalkGameOver::ThreadFunc, work, 20);
}

void CViTalkGameOver::ThreadFunc(void *arg)
{
    // Nothing.
}

void CViTalkGameOver::InitDisplay()
{
    HubControl::InitEngineAForTalk();
}

void CViTalkGameOver::Release()
{
    JoinThreadWorker(&this->thread);
    ReleaseThreadWorker(&this->thread);

    this->eventTalk.Release();

    this->ResetDisplay();
}

void CViTalkGameOver::ResetDisplay()
{
    HubControl::InitEngineAFor3DHub();
}

void CViTalkGameOver::Main_Init(void)
{
    CViTalkGameOver *work = TaskGetWorkCurrent(CViTalkGameOver);

    if (IsThreadWorkerFinished(&work->thread))
    {
        u16 id;
        if (work->disableRetryPrompt == FALSE)
            id = 1;
        else
            id = 0;

        work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetMsgControlArchive(), ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_OTHER_MCF), id, CVIEVTCMN_RESOURCE_NONE);
        work->eventTalk.SetPage(0);
        SetCurrentTaskMainEvent(CViTalkGameOver::Main_Talking);
    }
}

void CViTalkGameOver::Main_Talking(void)
{
    CViTalkGameOver *work = TaskGetWorkCurrent(CViTalkGameOver);

    work->eventTalk.ProcessDialog();
    if (work->eventTalk.IsFinished())
    {
        if (work->eventTalk.GetAction() == CViEvtCmnTalk::ACTION_TALK_GAMEOVER)
        {
            if (work->eventTalk.GetSelection() == 0)
            {
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_GAMEOVER_RETRY_STAGE);
            }
            else
            {
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_NONE);
                SaveGame__GsExit(0);
            }
        }
        else
        {
            CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_NONE);
        }

        CViDockNpcTalk::SetSelection(0);
        DestroyCurrentTask();
    }
}

void CViTalkGameOver::Destructor(Task *task)
{
    CViTalkGameOver *work = TaskGetWork(task, CViTalkGameOver);

    work->Release();

    HubTaskDestroy<CViTalkGameOver>(task);
}