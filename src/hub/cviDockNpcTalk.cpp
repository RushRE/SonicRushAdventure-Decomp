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

CViDockNpcGroupTalk talkAction = { CVIDOCKNPCTALK_ACTION_INVALID };

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
    talkAction.action = CVIDOCKNPCTALK_ACTION_INVALID;

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
            work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetMsgControlArchive(), msg.msgCtrlFile), msg.msgTextID3, CVIEVTCMN_RESOURCE_NONE);
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
            work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetMsgControlArchive(), msg.msgCtrlFile), msg.msgTextID3, msg.msgTextID2);
            page = 0;
            CViDock::DecrementTalkingNpcTalkCount();
        }
        else
        {
            work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetMsgControlArchive(), msg.msgCtrlFile), msg.msgTextID1, msg.msgTextID2);
            page = FX_ModS32(talkCount, work->eventTalk.GetPageCount());
        }
    }

    work->eventTalk.SetPage(page);
    CViDock::MoveCameraForNpcTalk(TRUE, TRUE);
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
            case CViEvtCmnTalk::ACTION_TALKPURCHASE_SHIP:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_TALKPURCHASE_SHIP);
                break;

            case CViEvtCmnTalk::ACTION_CONSTRUCT_SHIP:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_CONSTRUCT_SHIP);
                CViDockNpcTalk::SetSelection((u16)HubControl::GetNextShipToBuild());
                break;

            case CViEvtCmnTalk::ACTION_ANNOUNCE_SHIP_CONSTRUCTION:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_ANNOUNCE_FROM_SELECTION);
                break;

            case CViEvtCmnTalk::ACTION_TALK_MISSIONLIST:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_TALK_MISSIONLIST);
                break;

            case CViEvtCmnTalk::ACTION_TALK_OPTIONS:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_TALK_OPTIONS);
                break;

            case CViEvtCmnTalk::ACTION_OPEN_PLAYER_NAME_MENU:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_OPEN_PLAYER_NAME_MENU);
                break;

            case CViEvtCmnTalk::ACTION_TALK_MOVIELIST:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_TALK_MOVIELIST);
                break;

            case CViEvtCmnTalk::ACTION_TALK_UNKNOWN:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_NONE);
                break;

            case CViEvtCmnTalk::ACTION_TALKPURCHASE_INFO:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_TALKPURCHASE_INFO);
                break;

            case CViEvtCmnTalk::ACTION_TALKPURCHASE_DECORATION:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_TALKPURCHASE_DECORATION);
                break;

            case CViEvtCmnTalk::ACTION_OPEN_SOUND_TEST:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_SOUND_TEST);
                break;

            case CViEvtCmnTalk::ACTION_OPEN_VIKING_CUP:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_VIKING_CUP);
                break;

            case CViEvtCmnTalk::ACTION_OPEN_VIKING_CUP_2:
                // unused seemingly..?
                // also, 'CVIDOCKNPCTALK_ACTION_VIKING_CUP_2' does the same thing as 'CVIDOCKNPCTALK_ACTION_VIKING_CUP' anyways?
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_VIKING_CUP_2);
                break;

            case CViEvtCmnTalk::ACTION_ANNOUNCE_RADIO_TOWER:

                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_ANNOUNCE_FROM_SELECTION);
                CViDockNpcTalk::SetSelection(work->eventTalk.GetSelection() + 5);
                break;

            case CViEvtCmnTalk::ACTION_ANNOUNCE_NEW_MISSION:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_ANNOUNCE_NEW_MISSION);
                break;

            case CViEvtCmnTalk::ACTION_CONSTRUCT_DECORATION_MISSION_REWARD:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_CONSTRUCT_DECORATION_MISSION_REWARD);
                break;

            case CViEvtCmnTalk::ACTION_TALK_MISSION_COMPLETED:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_TALK_MISSION_COMPLETED);
                break;

            case CViEvtCmnTalk::ACTION_TALKPURCHASE_SHIP_UPGRADE:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_TALKPURCHASE_SHIP_UPGRADE);
                break;

            case CViEvtCmnTalk::ACTION_UPGRADE_SHIP:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_UPGRADE_SHIP);
                CViDockNpcTalk::SetSelection((u16)HubControl::GetNextShipUpgrade());
                break;

            case CViEvtCmnTalk::ACTION_ANNOUNCE_SHIP_UPGRADED:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_ANNOUNCE_FROM_SELECTION);
                CViDockNpcTalk::SetSelection(work->eventTalk.GetSelection() + 29);
                break;

            case CViEvtCmnTalk::ACTION_TALK_PURCHASED_INFO: {
                s32 selection = work->eventTalk.GetSelection();
                if (!SaveGame__GetProgressFlags_0x100000(selection))
                    SaveGame__SetProgressFlags_0x100000(selection);

                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_NONE);
            }
            break;

            default:
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_NONE);
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