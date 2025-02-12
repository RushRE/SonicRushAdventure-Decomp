#include <hub/npcRetry.hpp>
#include <hub/hubControl.hpp>
#include <hub/cviDockNpcTalk.hpp>
#include <game/save/saveGame.h>
#include <game/file/fileUnknown.h>

// resources
#include <resources/narc/vi_msg_ctrl_lz7.h>

// --------------------
// FUNCTIONS
// --------------------

void NpcRetry::Create(s32 param)
{
    Task *task = HubTaskCreate(NpcRetry::Main_Init, NpcRetry::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(16), NpcRetry);

    NpcRetry *work = TaskGetWork(task, NpcRetry);
    if (!param)
        work->disableRetryPrompt = FALSE;
    else
        work->disableRetryPrompt = TRUE;

    work->InitDisplay();

    InitThreadWorker(&work->thread, 0x800);
    CreateThreadWorker(&work->thread, NpcRetry::ThreadFunc, work, 20);
}

void NpcRetry::ThreadFunc(void *arg)
{
    // Nothing.
}

void NpcRetry::InitDisplay()
{
    HubControl::InitEngineAForTalk();
}

void NpcRetry::Release()
{
    JoinThreadWorker(&this->thread);
    ReleaseThreadWorker(&this->thread);

    this->evtCmnTalk.Release();

    this->ResetDisplay();
}

void NpcRetry::ResetDisplay()
{
    HubControl::InitEngineAFor3DHub();
}

void NpcRetry::Main_Init(void)
{
    NpcRetry *work = TaskGetWorkCurrent(NpcRetry);

    if (IsThreadWorkerFinished(&work->thread))
    {
        u16 id;
        if (work->disableRetryPrompt == FALSE)
            id = 1;
        else
            id = 0;

        work->evtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_OTHER_MCF), id, CVIEVTCMN_RESOURCE_NONE);
        work->evtCmnTalk.SetPage(0);
        SetCurrentTaskMainEvent(NpcRetry::Main_Talking);
    }
}

void NpcRetry::Main_Talking(void)
{
    NpcRetry *work = TaskGetWorkCurrent(NpcRetry);

    work->evtCmnTalk.ProcessDialog();
    if (work->evtCmnTalk.IsFinished())
    {
        if (work->evtCmnTalk.GetAction() == 18)
        {
            if (work->evtCmnTalk.GetSelection() == 0)
            {
                CViDockNpcTalk::SetTalkAction(27);
            }
            else
            {
                CViDockNpcTalk::SetTalkAction(0);
                SaveGame__GsExit(0);
            }
        }
        else
        {
            CViDockNpcTalk::SetTalkAction(0);
        }

        CViDockNpcTalk::SetSelection(0);
        DestroyCurrentTask();
    }
}

void NpcRetry::Destructor(Task *task)
{
    NpcRetry *work = TaskGetWork(task, NpcRetry);

    work->Release();

    HubTaskDestroy<NpcRetry>(task);
}