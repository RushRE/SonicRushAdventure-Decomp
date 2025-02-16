#include <hub/cviDockNpcTalk.hpp>
#include <hub/cviDock.hpp>
#include <hub/hubControl.hpp>
#include <hub/cviDockNpcGroup.hpp>
#include <hub/talkHelpers.h>
#include <hub/hubConfig.h>
#include <hub/missionConfig.h>
#include <game/save/saveGame.h>
#include <game/file/fileUnknown.h>

// talk actions
#include <hub/cviTalkSailPrompt.hpp>
#include <hub/cviTalkPurchase.hpp>
#include <hub/cviTalkMissionList.hpp>
#include <hub/cviTalkAnnounce.hpp>
#include <hub/cviTalkOptions.hpp>
#include <hub/cviTalkMovieList.hpp>
#include <hub/cviTalkGameOver.hpp>

// --------------------
// VARIABLES
// --------------------

static u32 selection;

CViDockNpcGroupTalk talkAction = { CVIDOCKNPCTALK_ACTION_32 };

DockNpcGroupFunc talkActionTable[CVIDOCKNPCTALK_COUNT] = {
    CViDockNpcTalk::Create,                 // CVIDOCKNPCTALK_NPC
    CViTalkSailPrompt::Create,              // CVIDOCKNPCTALK_SAILPROMPT
    CViTalkPurchase::Create,                // CVIDOCKNPCTALK_PURCHASE
    CViTalkMissionList::Create,             // CVIDOCKNPCTALK_MISSIONLIST
    CViDockNpcTalk::CreateMissionClearTalk, // CVIDOCKNPCTALK_MISSIONCLEARED
    CViTalkAnnounce::Create,                // CVIDOCKNPCTALK_ANNOUNCE
    CViDockNpcTalk::CreateUnknown,          // CVIDOCKNPCTALK_6
    CViTalkOptions::Create,                 // CVIDOCKNPCTALK_OPTIONS
    CViTalkMovieList::Create,               // CVIDOCKNPCTALK_MOVIELIST
    CViTalkGameOver::Create,                // CVIDOCKNPCTALK_GAMEOVER
    CViDockNpcTalk::CreateTalkAction,       // CVIDOCKNPCTALK_ACTION
};

// --------------------
// FUNCTIONS
// --------------------

void CViDockNpcTalk::CreateTalk(s32 type, s32 param)
{
    talkAction.action = CVIDOCKNPCTALK_ACTION_32;

    talkActionTable[type](param);
}

u32 CViDockNpcTalk::GetTalkAction(void)
{
    return talkAction.action;
}

u32 CViDockNpcTalk::GetSelection(void)
{
    return selection;
}

void CViDockNpcTalk::SetTalkAction(u32 action)
{
    talkAction.action = action;
}

void CViDockNpcTalk::SetSelection(s32 param)
{
    selection = param;
}

void CViDockNpcTalk::CreateMissionClearTalk(s32 param)
{
    u16 talkParam;

    if (gameState.clearedMission == FALSE)
    {
        // "Aw, that's too bad. No worries, though, ay, mate? No worries, though, ay, mate?"
        talkParam = 7;
    }
    else
    {
        // "You did it, mate! That was ace!"
        talkParam = 6;
        MissionHelpers__BeatMission(MissionHelpers__GetMissionID());
    }

    CViDockNpcTalk::Create(talkParam);
}

void CViDockNpcTalk::CreateUnknown(s32 param)
{
    // Nothing.
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
    u16 talkCount;

    work->messageID = messageID;
    talkCount       = CViDock::GetTalkingNpcTalkCount();
    HubControl::InitEngineAForTalk();

    HubNpcMsgConfig msg;
    if (work->messageID == 0)
    {
        id              = CViDock::GetTalkingNpc();
        msg.msgCtrlFile = TalkHelpers__GetInteractionCtrl(id);
        msg.msgTextID1  = TalkHelpers__GetInteractionText1(id);
        msg.msgTextID2  = TalkHelpers__GetInteractionText2(id);
        msg.msgTextID3  = TalkHelpers__GetInteractionText3(id);
    }
    else
    {
        MI_CpuCopy16(HubConfig__GetNpcMsgConfig(work->messageID), &msg, sizeof(msg));
    }

    flag = FALSE;
    if (msg.msgTextID3 != CVIEVTCMN_RESOURCE_NONE)
    {
        if (talkCount == 0)
        {
            work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), msg.msgCtrlFile), msg.msgTextID3, CVIEVTCMN_RESOURCE_NONE);
            page = 0;
            flag = TRUE;
        }
        else
        {
            talkCount--;
        }
    }

    if (!flag)
    {
        flag = FALSE;
        if (work->messageID == 0)
        {
            msg.msgTextID3 = TalkHelpers__GetInteractionText4(id);
            if (msg.msgTextID3 != CVIEVTCMN_RESOURCE_NONE)
                flag = TRUE;
        }

        if (flag)
        {
            work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), msg.msgCtrlFile), msg.msgTextID3, msg.msgTextID2);
            page = 0;
            CViDock::Func_215E098();
        }
        else
        {
            work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), msg.msgCtrlFile), msg.msgTextID1, msg.msgTextID2);
            page = FX_ModS32(talkCount, work->eventTalk.GetPageCount());
        }
    }

    work->eventTalk.SetPage(page);
    CViDock::Func_215E340(TRUE, TRUE);
}

void CViDockNpcTalk::Release()
{
    this->eventTalk.Release();
    HubControl::InitEngineAFor3DHub();
}

void CViDockNpcTalk::Main(void)
{
    CViDockNpcTalk *work = TaskGetWorkCurrent(CViDockNpcTalk);

    work->eventTalk.ProcessDialog();
    if (work->eventTalk.IsFinished())
    {
        CViDockNpcTalk::SetSelection(work->eventTalk.GetSelection());

        switch (work->eventTalk.GetAction())
        {
            case CViEvtCmnTalk::ACTION_1:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_3);
                break;

            case CViEvtCmnTalk::ACTION_2:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_4);
                CViDockNpcTalk::SetSelection((u16)HubControl::GetNextShipToBuild());
                break;

            case CViEvtCmnTalk::ACTION_3:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_7);
                break;

            case CViEvtCmnTalk::ACTION_4:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_8);
                break;

            case CViEvtCmnTalk::ACTION_5:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_12);
                break;

            case CViEvtCmnTalk::ACTION_6:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_13);
                break;

            case CViEvtCmnTalk::ACTION_7:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_19);
                break;

            case CViEvtCmnTalk::ACTION_9:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_0);
                break;

            case CViEvtCmnTalk::ACTION_10:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_22);
                break;

            case CViEvtCmnTalk::ACTION_11:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_5);
                break;

            case CViEvtCmnTalk::ACTION_12:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_23);
                break;

            case CViEvtCmnTalk::ACTION_13:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_24);
                break;

            case CViEvtCmnTalk::ACTION_14:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_25);
                break;

            case CViEvtCmnTalk::ACTION_15:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_7);
                CViDockNpcTalk::SetSelection(work->eventTalk.GetSelection() + 5);
                break;

            case CViEvtCmnTalk::ACTION_8:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_10);
                break;

            case CViEvtCmnTalk::ACTION_16:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_11);
                break;

            case CViEvtCmnTalk::ACTION_17:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_26);
                break;

            case CViEvtCmnTalk::ACTION_19:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_28);
                break;

            case CViEvtCmnTalk::ACTION_20:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_29);
                CViDockNpcTalk::SetSelection((u16)HubControl::Func_215B978());
                break;

            case CViEvtCmnTalk::ACTION_21:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_7);
                CViDockNpcTalk::SetSelection(work->eventTalk.GetSelection() + 29);
                break;

            case CViEvtCmnTalk::ACTION_22: {
                s32 selection = work->eventTalk.GetSelection();
                if (!SaveGame__GetProgressFlags_0x100000(selection))
                    SaveGame__SetProgressFlags_0x100000(selection);

                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_0);
            }
            break;

            default:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_0);
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