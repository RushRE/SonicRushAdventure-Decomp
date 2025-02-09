#include <hub/cviDockNpcTalk.hpp>
#include <hub/cviDock.hpp>
#include <hub/hubControl.hpp>
#include <hub/cviDockNpcGroup.hpp>
#include <hub/talkHelpers.h>
#include <hub/dockHelpers.h>
#include <hub/missionHelpers.h>
#include <game/save/saveGame.h>
#include <game/file/fileUnknown.h>

// talk actions
#include <hub/cviSailPrompt.hpp>
#include <hub/cviTalkPurchase.hpp>
#include <hub/cviTalkMissionList.hpp>
#include <hub/cviTalkAnnounce.hpp>
#include <hub/npcOptions.hpp>
#include <hub/npcCutsceneViewer.hpp>
#include <hub/npcRetry.hpp>

// --------------------
// VARIABLES
// --------------------

static u32 selection;

CViDockNpcGroupTalk talkAction = { 32 };

DockNpcGroupFunc talkActionTable[] = {
    CViDockNpcTalk::Create,        ViSailPrompt__Create, ViTalkPurchase__Create,    ViTalkMissionList__Create, CViDockNpcTalk::CreateMission,    ViTalkAnnounce__Create2,
    CViDockNpcTalk::CreateUnknown, NpcOptions::Create,   NpcCutsceneViewer::Create, NpcRetry::Create,          CViDockNpcTalk::CreateTalkAction,
};

// --------------------
// FUNCTIONS
// --------------------

void CViDockNpcTalk::RunAction(s32 id, s32 param)
{
    talkAction.action = 32;

    talkActionTable[id](param);
}

u32 CViDockNpcTalk::GetTalkAction(void)
{
    return talkAction.action;
}

u32 CViDockNpcTalk::GetSelection(void)
{
    return selection;
}

void CViDockNpcTalk::SetTalkAction(u32 value)
{
    talkAction.action = value;
}

void CViDockNpcTalk::SetSelection(s32 value)
{
    selection = value;
}

void CViDockNpcTalk::CreateMission(s32 param)
{
    u16 talkParam;

    if (gameState.missionFlag == FALSE)
    {
        talkParam = 7;
    }
    else
    {
        talkParam = 6;
        MissionHelpers__Func_2153E4C(MissionHelpers__GetMissionID());
    }

    CViDockNpcTalk::Create(talkParam);
}

void CViDockNpcTalk::CreateUnknown(s32 param)
{
    // nothing
}

void CViDockNpcTalk::CreateTalkAction(s32 param)
{
    talkAction.action = param;
}

void CViDockNpcTalk::Create(s32 messageID)
{
    CViDockNpcTalk::CreatePrivate(messageID);
}

void CViDockNpcTalk::CreatePrivate(s32 messageID)
{
    Task *task = HubTaskCreate(CViDockNpcTalk::Main, CViDockNpcTalk::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(16), CViDockNpcTalk);

    CViDockNpcTalk *work = TaskGetWork(task, CViDockNpcTalk);

    BOOL flag;
    s32 id;
    s32 page;
    u16 value;

    work->messageID = messageID;
    value           = ViDock__Func_215E06C();
    HubControl::Func_215A888();

    NpcMsgInfo msg;
    if (work->messageID == 0)
    {
        id              = ViDock__Func_215E0CC();
        msg.msgCtrlFile = TalkHelpers__GetInteractionCtrl(id);
        msg.msgTextID1  = TalkHelpers__GetInteractionText1(id);
        msg.msgTextID2  = TalkHelpers__GetInteractionText2(id);
        msg.msgTextID3  = TalkHelpers__GetInteractionText3(id);
    }
    else
    {
        MI_CpuCopy16(HubConfig__GetNpcMessageInfo(work->messageID), &msg, sizeof(msg));
    }

    flag = FALSE;
    if (msg.msgTextID3 != CVIEVTCMN_RESOURCE_NONE)
    {
        if (value == 0)
        {
            work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), msg.msgCtrlFile), msg.msgTextID3, CVIEVTCMN_RESOURCE_NONE);
            page = 0;
            flag = TRUE;
        }
        else
        {
            value--;
        }
    }

    if (!flag)
    {
        flag = FALSE;
        if (work->messageID == 0)
        {
            msg.msgTextID3 = TalkHelpers__Func_21536D8(id);
            if (msg.msgTextID3 != CVIEVTCMN_RESOURCE_NONE)
                flag = TRUE;
        }

        if (flag)
        {
            work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), msg.msgCtrlFile), msg.msgTextID3, msg.msgTextID2);
            page = 0;
            ViDock__Func_215E098();
        }
        else
        {
            work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), msg.msgCtrlFile), msg.msgTextID1, msg.msgTextID2);
            page = FX_ModS32(value, work->viEvtCmnTalk.SetInteraction());
        }
    }

    work->viEvtCmnTalk.SetPage(page);
    ViDock__Func_215E340(1, 1);
}

void CViDockNpcTalk::Release()
{
    this->viEvtCmnTalk.Release();
    HubControl::Func_215A96C();
}

void CViDockNpcTalk::Main(void)
{
    CViDockNpcTalk *work = TaskGetWorkCurrent(CViDockNpcTalk);

    work->viEvtCmnTalk.ProcessDialog();
    if (work->viEvtCmnTalk.IsFinished())
    {
        CViDockNpcTalk::SetSelection(work->viEvtCmnTalk.GetSelection());

        switch (work->viEvtCmnTalk.GetAction())
        {
            case 1:
                CViDockNpcTalk::SetTalkAction(3);
                break;

            case 2:
                CViDockNpcTalk::SetTalkAction(4);
                CViDockNpcTalk::SetSelection((u16)HubControl::Func_215B4E0());
                break;

            case 3:
                CViDockNpcTalk::SetTalkAction(7);
                break;

            case 4:
                CViDockNpcTalk::SetTalkAction(8);
                break;

            case 5:
                CViDockNpcTalk::SetTalkAction(12);
                break;

            case 6:
                CViDockNpcTalk::SetTalkAction(13);
                break;

            case 7:
                CViDockNpcTalk::SetTalkAction(19);
                break;

            case 9:
                CViDockNpcTalk::SetTalkAction(0);
                break;

            case 10:
                CViDockNpcTalk::SetTalkAction(22);
                break;

            case 11:
                CViDockNpcTalk::SetTalkAction(5);
                break;

            case 12:
                CViDockNpcTalk::SetTalkAction(23);
                break;

            case 13:
                CViDockNpcTalk::SetTalkAction(24);
                break;

            case 14:
                CViDockNpcTalk::SetTalkAction(25);
                break;

            case 15:
                CViDockNpcTalk::SetTalkAction(7);
                CViDockNpcTalk::SetSelection(work->viEvtCmnTalk.GetSelection() + 5);
                break;

            case 8:
                CViDockNpcTalk::SetTalkAction(10);
                break;

            case 16:
                CViDockNpcTalk::SetTalkAction(11);
                break;

            case 17:
                CViDockNpcTalk::SetTalkAction(26);
                break;

            case 19:
                CViDockNpcTalk::SetTalkAction(28);
                break;

            case 20:
                CViDockNpcTalk::SetTalkAction(29);
                CViDockNpcTalk::SetSelection((u16)HubControl::Func_215B978());
                break;

            case 21:
                CViDockNpcTalk::SetTalkAction(7);
                CViDockNpcTalk::SetSelection(work->viEvtCmnTalk.GetSelection() + 29);
                break;

            case 22: {
                s32 selection = work->viEvtCmnTalk.GetSelection();
                if (!SaveGame__GetProgressFlags_0x100000(selection))
                    SaveGame__SetProgressFlags_0x100000(selection);

                CViDockNpcTalk::SetTalkAction(0);
            }
            break;

            default:
                CViDockNpcTalk::SetTalkAction(0);
                break;
        }

        DestroyCurrentTask();
    }
}

void CViDockNpcTalk::Destructor(Task *task)
{
    CViDockNpcTalk *work = TaskGetWork(task, CViDockNpcTalk);

    work->Release();

    HubTaskDestroy<CViDockNpcTalk>(task);
}