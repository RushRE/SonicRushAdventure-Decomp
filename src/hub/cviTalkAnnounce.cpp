#include <hub/cviTalkAnnounce.hpp>
#include <hub/hubControl.hpp>
#include <hub/hubAudio.h>
#include <hub/dockHelpers.h>
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

    HubControl::Func_215A888();

    MI_CpuFill32((u8 *)VRAM_BG + 0x800, 0x3FF03FF, 0x800);
    MI_CpuClearFast((u8 *)VRAM_BG + (0x8000 - 0x20), 0x20);

    const AnnounceConfig *config = HubConfig__GetAnnounceConfig(work->type);
    work->announce.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsg(), config->mpcFile));
    if (CViTalkAnnounce::IsItemAnnouncement(work->type))
    {
        SetHubBGMVolume(AUDIOMANAGER_VOLUME_MAX / 2);
        PlayHubItemJingle();
        work->announce.SetSequence(config->sequence, HUB_SFX_INVALID);
    }
    else
    {
        work->announce.SetSequence(config->sequence, HUB_SFX_V_POPUP);
    }
}

void CViTalkAnnounce::Release()
{
    this->announce.Release();

    HubControl::Func_215A96C();
}

void CViTalkAnnounce::Main(void)
{
    CViTalkAnnounce *work = TaskGetWorkCurrent(CViTalkAnnounce);

    work->announce.Process();
    if (work->announce.CheckIdle())
    {
        if (work->type == CViTalkAnnounce::TYPE_UNLOCKED_JET)
        {
            CViDockNpcTalk::SetTalkAction(17);
            CViDockNpcTalk::SetSelection(0);
        }
        else if (work->type == CViTalkAnnounce::TYPE_UNLOCKED_RADIO_TOWER)
        {
            CViDockNpcTalk::SetTalkAction(21);
            CViDockNpcTalk::SetSelection(28);
        }
        else
        {
            CViDockNpcTalk::SetTalkAction(0);
            CViDockNpcTalk::SetSelection(0);
        }

        if (work->type >= CViTalkAnnounce::TYPE_UPGRADED_JET_LEVEL1 && work->type <= CViTalkAnnounce::TYPE_UPGRADED_SUBMARINE_LEVEL2)
        {
            s32 id    = work->type - CViTalkAnnounce::TYPE_UPGRADED_JET_LEVEL1;
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
    if (type == CViTalkAnnounce::TYPE_UNLOCKED_NEW_MISSION || type == CViTalkAnnounce::TYPE_UNLOCKED_MEDAL)
        return TRUE;

    return FALSE;
}