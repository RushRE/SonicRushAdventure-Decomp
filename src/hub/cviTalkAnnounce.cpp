#include <hub/cviTalkAnnounce.hpp>
#include <hub/hubControl.hpp>
#include <hub/hubAudio.h>
#include <hub/hubConfig.h>
#include <hub/cviDockNpcTalk.hpp>
#include <game/save/saveGame.h>
#include <game/file/fileUnknown.h>

// --------------------
// FUNCTIONS
// --------------------

void CViTalkAnnounce::Create(s32 param)
{
    CViTalkAnnounce::CreatePrivate(param);
}

void CViTalkAnnounce::CreatePrivate(s32 param)
{
    Task *task = HubTaskCreate(CViTalkAnnounce::Main, CViTalkAnnounce::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(16), CViTalkAnnounce);

    CViTalkAnnounce *work = TaskGetWork(task, CViTalkAnnounce);
    work->type            = param;

    HubControl::InitEngineAForTalk();

    MI_CpuFill32((u8 *)VRAM_BG + sizeof(GXScrText32x32), VRAM_SCRFMT_TEXT_x2(VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0), VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0)), sizeof(GXScrText32x32));
    MI_CpuClearFast((u8 *)VRAM_BG + (0x8000 - sizeof(GXCharFmt16)), sizeof(GXCharFmt16));

    const HubAnnounceMsgConfig *config = HubConfig__GetAnnounceMsgConfig(work->type);
    work->eventAnnounce.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsg(), config->mpcFile));
    if (CViTalkAnnounce::IsItemAnnouncement(work->type))
    {
        SetHubBGMVolume(AUDIOMANAGER_VOLUME_MAX / 2);
        PlayHubItemJingle();
        work->eventAnnounce.SetSequence(config->sequence, HUB_SFX_INVALID);
    }
    else
    {
        work->eventAnnounce.SetSequence(config->sequence, HUB_SFX_V_POPUP);
    }
}

void CViTalkAnnounce::Release()
{
    this->eventAnnounce.Release();

    HubControl::InitEngineAFor3DHub();
}

void CViTalkAnnounce::Main(void)
{
    CViTalkAnnounce *work = TaskGetWorkCurrent(CViTalkAnnounce);

    work->eventAnnounce.Process();
    if (work->eventAnnounce.CheckIdle())
    {
        if (work->type == CVITALKANNOUNCE_TYPE_UNLOCKED_JET)
        {
            CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_17);
            CViDockNpcTalk::SetSelection(0);
        }
        else if (work->type == CVITALKANNOUNCE_TYPE_UNLOCKED_RADIO_TOWER)
        {
            CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_21);
            CViDockNpcTalk::SetSelection(28);
        }
        else
        {
            CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_0);
            CViDockNpcTalk::SetSelection(0);
        }

        if (work->type >= CVITALKANNOUNCE_TYPE_UPGRADED_JET_LEVEL1 && work->type <= CVITALKANNOUNCE_TYPE_UPGRADED_SUBMARINE_LEVEL2)
        {
            s32 id    = work->type - CVITALKANNOUNCE_TYPE_UPGRADED_JET_LEVEL1;
            u16 type  = id / 2;
            u16 level = SHIP_LEVEL_1 + (id % 2);
            SaveGame__UnlockShip(type, level);
        }

        if (CViTalkAnnounce::IsItemAnnouncement(work->type))
        {
            ReleaseHubBGM();
            SetHubBGMVolume(AUDIOMANAGER_VOLUME_MAX);
        }

        DestroyCurrentTask();
    }
}

void CViTalkAnnounce::Destructor(Task *task)
{
    CViTalkAnnounce *work = TaskGetWork(task, CViTalkAnnounce);

    work->Release();

    HubTaskDestroy<CViTalkAnnounce>(task);
}

BOOL CViTalkAnnounce::IsItemAnnouncement(u16 type)
{
    if (type == CVITALKANNOUNCE_TYPE_UNLOCKED_NEW_MISSION || type == CVITALKANNOUNCE_TYPE_UNLOCKED_MEDAL)
        return TRUE;

    return FALSE;
}