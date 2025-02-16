#include <hub/hubControl.hpp>
#include <hub/cviHubAreaPreview.hpp>
#include <hub/cviMap.hpp>
#include <hub/cviDock.hpp>
#include <hub/cviDockNpcGroup.hpp>
#include <hub/cviDockNpcTalk.hpp>
#include <hub/hubHUD.hpp>
#include <hub/hubAudio.h>
#include <game/audio/sysSound.h>
#include <hub/hubConfig.h>
#include <hub/missionConfig.h>
#include <hub/hubState.h>
#include <game/game/gameState.h>
#include <game/save/saveGame.h>
#include <game/file/fileUnknown.h>
#include <game/file/fsRequest.h>
#include <game/file/binaryBundle.h>
#include <game/system/sysEvent.h>
#include <game/graphics/oamSystem.h>
#include <menu/credits.h>
#include <game/cutscene/script.h>
#include <hub/cviTalkMovieList.hpp>
#include <hub/cviTalkPurchase.hpp>
#include <sail/vikingCupManager.h>

// resources
#include <resources/narc/vi_act_lz7.h>
#include <resources/bb/vi_act_loc.h>
#include <resources/bb/vi_act_loc/vi_act_loc_eng.h>
#include <resources/narc/vi_bg_lz7.h>
#include <resources/bb/vi_bg_up.h>
#include <resources/bb/vi_bg_up/vi_bg_up_eng.h>
#include <resources/bb/vi_msg.h>
#include <resources/narc/vi_msg_ctrl_lz7.h>
#include <resources/bb/tkdm_name.h>
#include <resources/bb/tkdm_down.h>

// --------------------
// VARIABLES
// --------------------

static Task *hubControlTaskSingleton;
static MIProcessor hubMiProcessor;

static const u16 npcCountForArea[DOCKAREA_COUNT]   = { 9, 4, 3, 2, 2, 2, 0, 0 };
static const u16 npcStartIDForArea[DOCKAREA_COUNT] = {
    CVIDOCK_NPC_BASE_TAILS, CVIDOCK_NPC_JET_TAILS, CVIDOCK_NPC_BOAT_COLONEL, CVIDOCK_NPC_HOVER_COLONEL, CVIDOCK_NPC_SUBMARINE_COLONEL, CVIDOCK_NPC_BEACH_TABBY, 0, 0
};

// --------------------
// FUNCTIONS
// --------------------

extern "C" void InitHubSysEvent(void)
{
    HubControl::InitMainMemoryPriorityForHub();

    MI_CpuFill16(OAMSystem__GetList2(GRAPHICS_ENGINE_A), 0x200, HW_OAM_SIZE);
    MI_CpuFill16(OAMSystem__GetList2(GRAPHICS_ENGINE_B), 0x200, HW_OAM_SIZE);

    if (HubState__GetHubStartAction() != 7)
        gameState.saveFile.field_52 = 0;

    if (SaveGame__CheckCollectedAllEmeraldsEvent())
    {
        HubControl::ResetMainMemoryPriorityFromHub();
        gameState.creditsMode = CREDITS_MODE_EXTRA_STAGE_NOTIF;
        RequestNewSysEventChange(SYSEVENT_CREDITS);
        NextSysEvent();
        return;
    }

    if (MissionHelpers__CheckPostGameMissionUnlock())
    {
        HubControl::ResetMainMemoryPriorityFromHub();
        gameState.creditsMode = CREDITS_MODE_MISSION_NOTIF;
        RequestNewSysEventChange(SYSEVENT_CREDITS);
        NextSysEvent();
        return;
    }

    u16 progress       = SaveGame__GetGameProgress();
    u8 progressCounter = SaveGame__GetProgressCounter();

    if (progress == SAVE_PROGRESS_0)
    {
        if (progressCounter <= 6)
            HubControl::InitForNewSave();
        else
            HubControl::InitForUnfinishedTutorial();
    }
    else if (progress == SAVE_PROGRESS_1)
    {
        if (gameState.talk.state.hubStartAction)
            HubControl::Func_21570B8(1);
        else
            HubControl::Func_21570B8(0);
    }
    else if (progress < SAVE_PROGRESS_3)
    {
        if (gameState.talk.state.hubStartAction)
            HubControl::Func_215710C(1);
        else
            HubControl::Func_215710C(0);
    }
    else
    {
        if (HubState__GetHubStartAction() == 4)
        {
            u16 cutscene = CViTalkMovieList::GetNextCutscene(gameState.cutscene.cutsceneID);
            if (cutscene != CUTSCENE_NONE && !gameState.cutscene.canSkip)
            {
                HubControl::ResetMainMemoryPriorityFromHub();
                HubControl::Func_215B8FC(cutscene);
                RequestNewSysEventChange(SYSEVENT_CUTSCENE);
                NextSysEvent();
                return;
            }
        }
        else
        {
            gameState.cutscene.cutsceneID = CUTSCENE_NONE;
        }

        if (HubState__GetHubStartAction() == 5 && gameState.clearedMission)
        {
            u32 emeraldID = MissionHelpers__GetSolEmeraldIDFromMissionID(MissionHelpers__GetMissionID());
            if (emeraldID < 7)
            {
                HubControl::ResetMainMemoryPriorityFromHub();
                gameState.saveFile.chaosEmeraldID = -1;
                gameState.saveFile.solEmeraldID   = emeraldID;
                SaveGame__SetSolEmeraldCollected(&saveGame.stage, emeraldID);
                RequestNewSysEventChange(SYSEVENT_EMERALD_COLLECTED);
                NextSysEvent();
                return;
            }
        }

        if (gameState.talk.state.hubStartAction != 0 && gameState.talk.state.hubStartAction < 8)
        {
            HubControl::Func_215701C(gameState.talk.state.hubStartAction);
        }
        else
        {
            MI_CpuClear32(&gameState.talk, sizeof(gameState.talk));
            HubControl::InitForNoState();
        }
    }
}

void HubControl::InitForNoState()
{
    HubControl::CreateForMap(MAPAREA_BASE);
}

void HubControl::Func_215701C(s32 a1)
{
    if (HubState__GetHubStartAction() == 6 || HubState__GetHubStartAction() == 7)
    {
        u32 field_134;
        if (HubState__GetHubStartAction() == 7)
            field_134 = 1;
        else
            field_134 = 0;

        HubControl::CreateForDock(DOCKAREA_BASE, 0, 0);

        HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);
        work->field_130  = 1;
        work->field_134  = field_134;
    }
    else
    {
        if (HubState__GetHubType() == HUB_TYPE_MAP)
        {
            HubControl::CreateForMap(HubState__GetHubArea());
        }
        else
        {
            if (HubState__GetHubType() == HUB_TYPE_DOCK)
            {
                HubControl::CreateForDock(HubState__GetHubArea(), 1, 0);
            }
            else
            {
                HubControl::InitForNoState();
            }
        }
    }
}

void HubControl::Func_21570B8(s32 a1)
{
    u8 area;

    if (a1 && HubState__GetHubType() == HUB_TYPE_DOCK)
    {
        area = HubState__GetHubArea();

        if (area != DOCKAREA_BASE && area != DOCKAREA_BASE_NEXT)
            area = DOCKAREA_BASE;

        if (gameState.talk.state.hubStartAction == 2)
            area = DOCKAREA_BASE_NEXT;
    }
    else
    {
        area = DOCKAREA_BASE;
    }

    HubControl::CreateForDock(area, a1, 1);
}

void HubControl::Func_215710C(BOOL a2)
{
    HubControl::CreateForDock(DOCKAREA_JET, a2, 1);
}

void HubControl::InitForNewSave()
{
    HubControl::CreateForMap(MAPAREA_BEACH);
    HubControl::SetMapIconArea(MAPAREA_TUTORIAL);
}

void HubControl::InitForUnfinishedTutorial()
{
    HubControl::CreateForMap(MAPAREA_TUTORIAL);
    HubControl::SetMapIconArea(MAPAREA_BASE);
}

void HubControl::DisableTouchInteractions()
{
    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);
    work->touchFlags |= 1;
}

BOOL HubControl::TouchEnabled()
{
    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);
    return (work->touchFlags & 1) == 0;
}

void *HubControl::GetFileFrom_ViAct(u16 id)
{
    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);

    return FileUnknown__GetAOUFile(work->viActArchive, id);
}

void *HubControl::GetFileFrom_ViActLoc(u16 id)
{
    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);

    return FileUnknown__GetAOUFile(work->viActLocArchive, id);
}

void *HubControl::GetFileFrom_ViBG(u16 id)
{
    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);

    return FileUnknown__GetAOUFile(work->viBGArchive, id);
}

void *HubControl::GetFileFrom_ViMsg()
{
    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);

    return work->viMsgArchive;
}

void *HubControl::GetFileFrom_ViMsgCtrl()
{
    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);

    return work->viMsgCtrlArchive;
}

FontWindow *HubControl::GetField54()
{
    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);

    return &work->fontWindow;
}

void *HubControl::GetTKDMNameSprite()
{
    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);

    return work->tkdmNameSprite;
}

void HubControl::InitMainMemoryPriorityForHub()
{
    hubMiProcessor = MI_GetMainMemoryPriority();
    MI_SetMainMemoryPriority(MI_PROCESSOR_ARM7);
}

void HubControl::ResetMainMemoryPriorityFromHub()
{
    if (hubMiProcessor != MI_PROCESSOR_ARM7 && hubMiProcessor != MI_PROCESSOR_ARM9)
        hubMiProcessor = MI_PROCESSOR_ARM9;

    MI_SetMainMemoryPriority(hubMiProcessor);
}

void HubControl::CreateForMap(MapArea mapArea)
{
    HubControl::InitDisplay();

    hubControlTaskSingleton =
        HubTaskCreate(HubControl::Main_InitMap, HubControl::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1050, TASK_GROUP(16), HubControl);

    HubControl *work     = TaskGetWork(hubControlTaskSingleton, HubControl);
    work->flags          = 0x10000;
    work->genericTimer   = 0;
    work->field_8        = 0;
    work->hubAreaPreview = NULL;
    work->nextEvent      = HUBEVENT_INVALID;
    work->dockArea       = DOCKAREA_NONE;
    work->field_10       = HubConfig__GetDockMapIconConfig(mapArea)->field_8;
    work->nextMapArea = work->mapArea = mapArea;
    work->shipConstructID             = CViMap::CONSTRUCT_SHIP_INVALID;
    work->decorConstructID            = CViMap::CONSTRUCT_DECOR_INVALID;
    work->shipUpgradeID               = CViMap::UPGRADE_SHIP_INVALID;

    work->LoadArchives();

    ViMap__Create();
    ViMap__GoToMapArea(work->mapArea, FALSE);
    ViMap__SetType(CViMap::TYPE_DOCK_ACTIVE);
    ViMap__EnableMapIcons(TRUE);

    CViDock::Create();

    if (mapArea == MAPAREA_TUTORIAL)
    {
        work->nextMapArea = mapArea;
        CViDock::InitForInactive();
    }
    else
    {
        CViDock::InitForType1(work->field_10, 0);
        CViDock::EnablePlayerInput(FALSE);
    }

    work->ClearAnimators();
    HubHUD::Create();
    HubHUD::ConfigureViewButton(FALSE, TRUE);
    HubHUD::ConfigureMenuButton(FALSE, TRUE);
    ViMapPaletteAnimation__Create();
    CViHubAreaPreview::Create(work);
    ResetTouchInput();

    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    work->mapIconArea = MAPAREA_INVALID;
    work->field_118   = 0;
    work->field_11C   = 0;
    work->field_124   = 0;
    work->field_128   = 0;
    work->field_12C   = 0;
    work->field_130   = 0;
    work->field_134   = 0;

    ResetHubState();
    InitHubAudio();
    PlayHubBGM();
}

void HubControl::CreateForDock(s32 dockArea, BOOL loadCharacterStates, s32 a3)
{
    HubControl::InitDisplay();

    hubControlTaskSingleton =
        HubTaskCreate(HubControl::Main_InitDock, HubControl::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1050, TASK_GROUP(16), HubControl);

    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);

    work->flags          = 0x10000;
    work->genericTimer   = 0;
    work->field_8        = 0;
    work->hubAreaPreview = 0;
    work->nextEvent      = HUBEVENT_INVALID;
    work->dockArea       = dockArea;
    work->field_10       = 9;
    work->nextMapArea = work->mapArea = HubConfig__GetDockStageConfig(dockArea)->mapArea;
    work->shipConstructID             = CViMap::CONSTRUCT_SHIP_INVALID;
    work->decorConstructID            = CViMap::CONSTRUCT_DECOR_INVALID;
    work->shipUpgradeID               = CViMap::UPGRADE_SHIP_INVALID;

    work->LoadArchives();

    ViMap__Create();
    ViMap__GoToMapArea(work->mapArea, 0);
    ViMap__SetType(CViMap::TYPE_DOCK_ACTIVE);
    ViMap__EnableMapIcons(FALSE);

    CViDock::Create();
    CViDock::InitForPlayerControl(work->dockArea);

    if (loadCharacterStates)
    {
        BOOL loadAngle = TRUE;
        if (HubState__GetHubStartAction() == 1 || HubState__GetHubStartAction() == 3 || HubState__GetHubStartAction() == 5)
            loadAngle = FALSE;

        CViDock::LoadCharacterStates(loadAngle);
    }

    CViDock::EnablePlayerInput(FALSE);
    CViDock::DisableExitArea(a3);

    work->ClearAnimators();

    HubHUD::Create();
    HubHUD::ConfigureViewButton(FALSE, TRUE);
    HubHUD::ConfigureMenuButton(FALSE, TRUE);

    ViMapPaletteAnimation__Create();

    ResetTouchInput();

    renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;

    work->mapIconArea = MAPAREA_INVALID;
    work->field_118   = 0;
    work->field_11C   = a3;
    work->field_124   = 0;
    work->field_128   = 0;
    work->field_12C   = 0;
    work->field_130   = 0;
    work->field_134   = 0;

    if (loadCharacterStates)
    {
        if (HubState__GetHubStartAction() == 2)
        {
            work->field_124 = 1;
        }
        else if (HubState__GetHubStartAction() == 4)
        {
            work->field_128 = 1;
        }
        else if (HubState__GetHubStartAction() == 5)
        {
            work->field_12C = 1;
        }
    }

    ResetHubState();
    InitHubAudio();
    PlayHubBGM();
}

void HubControl::SetMapIconArea(MapArea mapArea)
{
    HubControl *work  = TaskGetWork(hubControlTaskSingleton, HubControl);
    work->mapIconArea = mapArea;
}

void HubControl::Release()
{
    CViHubAreaPreview::Destroy(this);
    this->ReleaseGraphics();
    ViMapPaletteAnimation__Destroy();
    HubHUD::Destroy();
    CViDock::Func_215DB9C();
    ViMap__Destroy();
    this->ReleaseAssets();
    ReleaseHubAudio(HubControl::CheckEventHasBGMChange(this->nextEvent));
}

void HubControl::Main_InitMap()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    s32 mapArea = MAPAREA_INVALID;
    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_DEFAULT, 1) == 0)
    {
        work->flags &= ~0x10000;

        if (work->mapIconArea < MAPAREA_COUNT)
        {
            s32 iconArea = ViMap__GetMapAreaFromMapIconMarker(TRUE);
            if (work->mapIconArea == iconArea)
            {
                mapArea           = work->mapIconArea;
                work->mapIconArea = DOCKAREA_INVALID;
            }
            else
            {
                work->timer = 0;
                SetCurrentTaskMainEvent(HubControl::Main_21588D4);
            }
        }
        else
        {
            if (SaveGame__CheckProgress15())
            {
                work->timer = 0;
                SetCurrentTaskMainEvent(HubControl::Main_2158A04);
            }
            else if (SaveGame__CheckProgress30())
            {
                work->timer = 0;
                SetCurrentTaskMainEvent(HubControl::Main_2158A04);
            }
            else
            {
                ViMap__SetType(CViMap::TYPE_MAP_ACTIVE);
                HubHUD::ConfigureViewButton(TRUE, TRUE);
                HubHUD::ConfigureMenuButton(TRUE, TRUE);
                SetCurrentTaskMainEvent(HubControl::Main_21578CC);
            }
        }
    }

    if (mapArea < MAPAREA_COUNT)
    {
        ViMap__SetType(CViMap::TYPE_DOCK_ACTIVE);
        HubHUD::ConfigureViewButton(FALSE, TRUE);
        HubHUD::ConfigureMenuButton(FALSE, TRUE);

        PlayHubSfx(HUB_SFX_D_DECISION);

        work->mapArea = mapArea;
        work->flags |= 0x10000;

        if (HubConfig__GetDockMapIconConfig(mapArea)->dockArea < DOCKAREA_DRILL)
        {
            CViDock::DisableExitArea(work->field_11C);
            work->dockArea = HubConfig__GetDockMapIconConfig(mapArea)->dockArea;
            SetCurrentTaskMainEvent(HubControl::Main_2157C0C);
        }
        else
        {
            if (mapArea == MAPAREA_DRILL)
            {
                work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
                work->nextSelectionID = SAVE_PROGRESSTYPE_8;
            }
            else if (mapArea == MAPAREA_TUTORIAL)
            {
                work->nextEvent       = HUBEVENT_START_TUTORIAL;
                work->nextSelectionID = 0;
            }
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
        }
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Main_21578CC()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    BOOL flag = FALSE;
    if (ViMap__GetMapAreaFromMapIconMarker(TRUE) < DOCKAREA_COUNT)
    {
        HubHUD::ConfigureViewButton(TRUE, TRUE);
        HubHUD::ConfigureMenuButton(TRUE, TRUE);
        if (HubHUD::LookAroundEnabled())
        {
            ViMap__SetType(CViMap::TYPE_DOCK_ACTIVE);
            SetCurrentTaskMainEvent(HubControl::Main_2157A94);
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            flag = TRUE;
        }
        else if (HubHUD::ShouldOpenMainMenu())
        {
            work->SaveState(TRUE);
            PlayHubSfx(HUB_SFX_PAUSE);
            work->nextEvent       = HUBEVENT_MAIN_MENU;
            work->nextSelectionID = 0;
            ViMap__SetType(CViMap::TYPE_DOCK_ACTIVE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            HubHUD::ConfigureViewButton(FALSE, TRUE);
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            flag = TRUE;
        }
    }
    else
    {
        HubHUD::ConfigureViewButton(TRUE, FALSE);
        HubHUD::ConfigureMenuButton(TRUE, FALSE);
    }

    if (!flag)
    {
        s32 iconArea = ViMap__GetMapAreaFromMapIcon();
        if (iconArea < DOCKAREA_NONE)
        {
            ViMap__SetType(CViMap::TYPE_DOCK_ACTIVE);
            HubHUD::ConfigureViewButton(FALSE, TRUE);
            HubHUD::ConfigureMenuButton(FALSE, TRUE);

            PlayHubSfx(HUB_SFX_D_DECISION);
            work->mapArea = iconArea;
            work->flags |= 0x10000;

            if (HubConfig__GetDockMapIconConfig(iconArea)->dockArea < 7)
            {
                work->dockArea = HubConfig__GetDockMapIconConfig(iconArea)->dockArea;
                SetCurrentTaskMainEvent(HubControl::Main_2157C0C);
            }
            else
            {
                if (iconArea == DOCKAREA_BEACH)
                {
                    work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
                    work->nextSelectionID = SAVE_PROGRESSTYPE_8;
                }
                else if (iconArea == DOCKAREA_DRILL)
                {
                    work->nextEvent       = HUBEVENT_START_TUTORIAL;
                    work->nextSelectionID = 0;
                }

                HubControl::TryFadeOutBGM(work);
                SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            }
        }
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Main_2157A94()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    BOOL flag = FALSE;
    if (!HubHUD::LookAroundEnabled())
    {
        ViMap__SetType(CViMap::TYPE_MAP_ACTIVE);
        SetCurrentTaskMainEvent(HubControl::Main_21578CC);
        flag = TRUE;
    }

    if (!flag)
    {
        s32 iconTouchArea = ViMap__GetMapAreaFromMapIconTouchInput();
        if (iconTouchArea < DOCKAREA_COUNT)
        {
            HubHUD::DisableLookAround();
            ViMap__SetType(CViMap::TYPE_MAP_ACTIVE);
            ViMap__GoToMapArea(iconTouchArea, TRUE);
            SetCurrentTaskMainEvent(HubControl::Main_21578CC);
            flag = TRUE;
        }
    }

    if (!flag)
    {
        u16 startY;
        u16 startX;
        s16 touchMoveY;
        s16 touchMoveX;

        touchMoveX = 0;
        touchMoveY = 0;

        ViMap__GetMapPosition(&startX, &startY);

        if (HubHUD::GetTouchHeld())
        {
            s16 touchY;
            s16 touchX;

            HubHUD::GetTouchMove(&touchMoveX, &touchMoveY);
            HubHUD::GetTouchPos(&touchX, &touchY);
            ViMap__DrawMapCursor(touchX, touchY);
        }
        else
        {
            if (HubHUD::GetLookAroundBtnLeft())
                touchMoveX += 2;

            if (HubHUD::GetLookAroundBtnUp())
                touchMoveY += 2;

            if (HubHUD::GetLookAroundBtnRight())
                touchMoveX -= 2;

            if (HubHUD::GetLookAroundBtnDown())
                touchMoveY -= 2;
        }

        startX = ClampS32(startX - touchMoveX, 0, 64);
        startY = ClampS32(startY - touchMoveY, 16, 64);
        ViMap__WarpToPosition(startX, startY);
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Main_2157C0C()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_BLACK, 1) == 0)
    {
        CViHubAreaPreview::Destroy(work);
        CViDock::InitForPlayerControl(work->dockArea);
        CViDock::EnablePlayerInput(FALSE);
        ViMap__EnableMapIcons(0);

        renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;
        work->flags |= 0x10000;

        SetCurrentTaskMainEvent(HubControl::Main_InitDock);
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Main_InitDock()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_DEFAULT, 1) == 0)
    {
        if (work->field_118)
        {
            work->timer      = 0;
            work->cutsceneID = 0xFFFF;
            work->flags &= ~0x10000;
            SetCurrentTaskMainEvent(HubControl::Main_2158AB4);
        }
        else if (work->field_124)
        {
            work->field_124 = 0;
            CViDock::SetTalkingNpc(CVIDOCK_NPC_BASENEXT_SETTER);
            CViDock::StartTalkingToNpc();
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_OPTIONS, 0);
            SetCurrentTaskMainEvent(HubControl::Main_DoTalkAction);
        }
        else if (work->field_128)
        {
            work->field_128 = 0;
            if (work->dockArea == DOCKAREA_JET)
                CViDock::SetTalkingNpc(CVIDOCK_NPC_JET_KYLOK);

            CViDock::StartTalkingToNpc();
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_MOVIELIST, 0);
            SetCurrentTaskMainEvent(HubControl::Main_DoTalkAction);
        }
        else if (work->field_12C)
        {
            work->field_12C = 0;
            CViDock::SetTalkingNpc(CVIDOCK_NPC_BASE_MARINE);
            CViDock::StartTalkingToNpc();
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_MISSIONCLEARED, 0);
            SetCurrentTaskMainEvent(HubControl::Main_DoTalkAction);
        }
        else if (work->field_130)
        {
            CViDock::SetTalkingNpc(CVIDOCK_NPC_BASE_TAILS);
            CViDock::StartTalkingToNpc();
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            if (work->field_134)
                CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_GAMEOVER, 1);
            else
                CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_GAMEOVER, 0);
            SetCurrentTaskMainEvent(HubControl::Main_DoTalkAction);
            work->field_130 = 0;
            work->field_134 = 0;
        }
        else if (SaveGame__CheckProgressZone5OrZone6NotClear() && work->dockArea == DOCKAREA_BASE)
        {
            SaveGame__UpdateProgressForZone5Zone6Cleared();
            HubControl::StartHubCutscene(CUTSCENE_EARTHQUAKE, DOCKAREA_COUNT);
        }
        else
        {
            if (SaveGame__CheckProgressForShip(SHIP_BOAT - 1) && work->dockArea == DOCKAREA_BOAT)
            {
                SaveGame__Func_205BC38(SHIP_BOAT - 1);
                HubControl::StartHubCutscene(CUTSCENE_OCEAN_TORNADO_COMPLETE, DOCKAREA_BASE);
            }
            else if (SaveGame__CheckProgressForShip(SHIP_HOVER - 1) && work->dockArea == DOCKAREA_HOVER)
            {
                SaveGame__Func_205BC38(SHIP_HOVER - 1);
                HubControl::StartHubCutscene(CUTSCENE_AQUA_BLAST_COMPLETE, DOCKAREA_COUNT);
            }
            else if (SaveGame__CheckProgressForShip(SHIP_SUBMARINE - 1) && work->dockArea == DOCKAREA_SUBMARINE)
            {
                SaveGame__Func_205BC38(SHIP_SUBMARINE - 1);
                HubControl::StartHubCutscene(CUTSCENE_DEEP_TYPHOON_COMPLETE, DOCKAREA_COUNT);
            }
            else
            {
                if (SaveGame__GetGameProgress() == SAVE_PROGRESS_37 && work->dockArea == DOCKAREA_BASE)
                {
                    HubControl::StartHubCutsceneUnknown();
                }
                else
                {
                    work->flags &= ~0x10000;
                    SetCurrentTaskMainEvent(HubControl::Main_InitDockPlayerControl);
                }
            }
        }
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Main_InitDockPlayerControl()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);
    CViDock::EnablePlayerInput(TRUE);
    HubHUD::ConfigureMenuButton(TRUE, TRUE);
    SetCurrentTaskMainEvent(HubControl::Main_ProcessDock);
    HubControl::ProcessGenericTimer(work);
}

void HubControl::Main_ProcessDock()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (CViDock::DidExitArea())
    {
        CViDock::EnablePlayerInput(FALSE);
        HubHUD::ConfigureMenuButton(FALSE, FALSE);
        work->flags |= 0x10000;
        SetCurrentTaskMainEvent(HubControl::Main_FadeOutForExitDockArea);
        PlayHubSfx(HUB_SFX_V_CHANGE);
    }
    else if (work->dockArea != CViDock::GetNextArea())
    {
        CViDock::EnablePlayerInput(FALSE);
        HubHUD::ConfigureMenuButton(FALSE, FALSE);
        work->flags |= 0x10000;
        SetCurrentTaskMainEvent(HubControl::Main_FadeOutForDockChange);
        PlayHubSfx(HUB_SFX_V_CHANGE);
    }
    else
    {
        if (CViDock::HasActiveTalkAction())
        {
            s32 id;
            s32 param;
            CViDock::Func_215E02C(&id, &param);

            if (id == CVIDOCKNPCTALK_NPC || id == CVIDOCKNPCTALK_ACTION)
                PlayHubSfx(HUB_SFX_V_DECIDE);

            CViDock::StartTalkingToNpc();
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            CViDockNpcTalk::CreateTalk(id, param);
            SetCurrentTaskMainEvent(HubControl::Main_DoTalkAction);
        }
        else if (HubHUD::ShouldOpenMainMenu())
        {
            work->SaveState(FALSE);
            PlayHubSfx(HUB_SFX_PAUSE);
            CViDock::EnablePlayerInput(FALSE);
            work->nextEvent       = HUBEVENT_MAIN_MENU;
            work->nextSelectionID = 0;
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
        }
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Main_FadeOutForDockChange()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_DEFAULT, 1) == 0)
    {
        s32 area = CViDock::GetNextArea();
        CViDock::InitForDockChange(area, work->dockArea);
        work->dockArea = area;
        SetCurrentTaskMainEvent(HubControl::Main_WaitForDockChanged);
    }
}

void HubControl::Main_WaitForDockChanged()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (CViDock::CheckThreadIdle())
    {
        u32 mapArea = HubConfig__GetDockStageConfig(work->dockArea)->mapArea;
        if (mapArea != work->mapArea)
        {
            work->mapArea = mapArea;
            ViMap__GoToMapArea(mapArea, TRUE);
        }

        CViDock::ReturnPlayerControl();
        SetCurrentTaskMainEvent(HubControl::Main_InitDock);
    }
}

void HubControl::Main_DoTalkAction()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    switch (CViDockNpcTalk::GetTalkAction())
    {
        case CVIDOCKNPCTALK_ACTION_0:
            CViDock::FinishTalkingToNpc();
            SetCurrentTaskMainEvent(HubControl::Main_InitDockPlayerControl);
            break;

        case CVIDOCKNPCTALK_ACTION_1:
            work->SaveState(FALSE);
            HubControl::Func_215A2E0(work->dockArea, 0);
            work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
            work->nextSelectionID = SAVE_PROGRESSTYPE_1;
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_2:
            work->SaveState(FALSE);
            HubControl::Func_215A2E0(work->dockArea, 1);
            work->nextEvent       = HUBEVENT_SAILING;
            work->nextSelectionID = CViDockNpcTalk::GetSelection();
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_3:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_PURCHASE, CViTalkPurchase::PURCHASE_CONSTRUCTION);
            break;

        case CVIDOCKNPCTALK_ACTION_4:
            work->shipConstructID = CViDockNpcTalk::GetSelection();
            if (work->shipConstructID == CViMap::CONSTRUCT_SHIP_JET)
                CViTalkPurchase::MakeTutorialPurchase();

            work->talkingNpc = CViDock::GetTalkingNpc();
            work->field_8    = work->genericTimer;
            SetCurrentTaskMainEvent(HubControl::Func_2158D28);
            FadeOutHubBGM(12);
            CViDock::EnablePlayerInput(FALSE);
            break;

        case CVIDOCKNPCTALK_ACTION_5:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_PURCHASE, CViTalkPurchase::PURCHASE_DECORATION);
            break;

        case CVIDOCKNPCTALK_ACTION_6:
            work->decorConstructID = CViDockNpcTalk::GetSelection();
            work->talkingNpc       = CViDock::GetTalkingNpc();
            work->field_8          = work->genericTimer;
            SetCurrentTaskMainEvent(HubControl::Func_2158D28);
            CViDock::EnablePlayerInput(FALSE);
            work->SaveState(FALSE);
            break;

        case CVIDOCKNPCTALK_ACTION_7:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_ANNOUNCE, CViDockNpcTalk::GetSelection());
            break;

        case CVIDOCKNPCTALK_ACTION_8:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_MISSIONLIST, 0);
            break;

        case CVIDOCKNPCTALK_ACTION_9:
            work->SaveState(FALSE);
            work->nextEvent       = HUBEVENT_START_MISSION;
            work->nextSelectionID = CViDockNpcTalk::GetSelection();
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_10:
            MissionHelpers__UnlockMission(CViDockNpcTalk::GetSelection());
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_ANNOUNCE, CVITALKANNOUNCE_TYPE_UNLOCKED_MEDAL);
            break;

        case CVIDOCKNPCTALK_ACTION_11: // mission selection
            if (CViDockNpcTalk::GetSelection() < MISSION_COUNT)
            {
                u32 selection = CViDockNpcTalk::GetSelection();
                if (MissionHelpers__GetMissionCompletedReward(selection) < 22)
                {
                    work->decorConstructID = MissionHelpers__GetMissionCompletedReward(selection);
                    work->talkingNpc       = CViDock::GetTalkingNpc();
                    work->field_8          = work->genericTimer;
                    SetCurrentTaskMainEvent(HubControl::Func_2158D28);
                    CViDock::EnablePlayerInput(FALSE);
                    work->SaveState(FALSE);
                }
                else
                {
                    MissionHelpers__CompleteMission(selection);
                    CViDock::FinishTalkingToNpc();
                    SetCurrentTaskMainEvent(HubControl::Main_InitDockPlayerControl);
                }
            }
            else
            {
                MissionHelpers__HandleCompletedMuzyMissions();
                CViDock::FinishTalkingToNpc();
                SetCurrentTaskMainEvent(HubControl::Main_InitDockPlayerControl);
            }
            break;

        case CVIDOCKNPCTALK_ACTION_12:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_OPTIONS, 0);
            break;

        case CVIDOCKNPCTALK_ACTION_13:
            work->SaveState(FALSE);
            work->nextEvent       = HUBEVENT_PLAYER_NAME_MENU;
            work->nextSelectionID = 0;
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_14:
            work->SaveState(FALSE);
            work->nextEvent       = HUBEVENT_DELETE_SAVE_MENU;
            work->nextSelectionID = 0;
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_15:
            work->SaveState(FALSE);
            work->nextEvent       = HUBEVENT_VS_MAIN_MENU;
            work->nextSelectionID = 0;
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_16:
            work->SaveState(FALSE);
            work->nextEvent       = HUBEVENT_STAGE_SELECT;
            work->nextSelectionID = 0;
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_17:
            work->mapIconArea = MAPAREA_JET;
            CViDock::FinishTalkingToNpc();
            work->flags |= 0x10000;
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForExitDockArea);
            PlayHubSfx(HUB_SFX_V_CHANGE);
            break;

        case CVIDOCKNPCTALK_ACTION_18:
            work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
            work->nextSelectionID = SAVE_PROGRESSTYPE_0;
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_19:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_MOVIELIST, 0);
            break;

        case CVIDOCKNPCTALK_ACTION_20:
            work->SaveState(FALSE);
            work->nextEvent       = HUBEVENT_CUTSCENE_1;
            work->nextSelectionID = CViDockNpcTalk::GetSelection();
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_21:
            work->SaveState(FALSE);
            work->nextEvent       = HUBEVENT_CUTSCENE_2;
            work->nextSelectionID = CViDockNpcTalk::GetSelection();
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_22:
            if (SaveGame__GetProgressFlags_0x100000(0) || SaveGame__HasDoorPuzzlePiece(0))
                CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_NPC, 38);
            else
                CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_PURCHASE, CViTalkPurchase::PURCHASE_INFO);
            break;

        case CVIDOCKNPCTALK_ACTION_23:
            work->SaveState(FALSE);
            work->nextEvent       = HUBEVENT_SOUND_TEST;
            work->nextSelectionID = 0;
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_24:
        case CVIDOCKNPCTALK_ACTION_25:
            work->SaveState(FALSE);
            work->nextEvent       = HUBEVENT_VIKING_CUP;
            work->nextSelectionID = 0;
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_26:
            s32 missionID = MISSIONLIST_INVALID;

            for (s32 i = 0; i < MissionHelpers__MarinePostGameMissionCount(); i++)
            {
                if (MissionHelpers__GetMarinePostGameMission(i) == MissionHelpers__GetMissionID())
                {
                    missionID = MissionHelpers__GetMissionID();
                    break;
                }
            }

            if (missionID != MISSIONLIST_INVALID && !MissionHelpers__CheckMissionCompleted(missionID))
            {
                MissionHelpers__CompleteMission(missionID);
                CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_ANNOUNCE, CVITALKANNOUNCE_TYPE_UNLOCKED_NEW_MISSION);
                break;
            }

            CViDock::FinishTalkingToNpc();
            SetCurrentTaskMainEvent(HubControl::Main_InitDockPlayerControl);
            break;

        case CVIDOCKNPCTALK_ACTION_27:
            work->SaveState(FALSE);
            work->nextEvent       = HUBEVENT_LOAD_STAGE;
            work->nextSelectionID = 0;
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_28:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_PURCHASE, CViTalkPurchase::PURCHASE_SHIP_UPGRADE);
            break;

        case CVIDOCKNPCTALK_ACTION_29:
            work->shipUpgradeID = CViDockNpcTalk::GetSelection();
            work->talkingNpc    = CViDock::GetTalkingNpc();
            work->field_8       = work->genericTimer;
            SetCurrentTaskMainEvent(HubControl::Func_2158D28);
            FadeOutHubBGM(12);
            CViDock::EnablePlayerInput(FALSE);
            break;

        case CVIDOCKNPCTALK_ACTION_30:
            work->nextEvent       = HUBEVENT_CORRUPT_SAVE_WARNING;
            work->nextSelectionID = 0;
            CViDock::EnablePlayerInput(FALSE);
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            break;

        case CVIDOCKNPCTALK_ACTION_32:
            break;

        default:
            CViDock::FinishTalkingToNpc();
            SetCurrentTaskMainEvent(HubControl::Main_InitDockPlayerControl);
            break;
    }

    FontWindow__PrepareSwapBuffer(&work->fontWindow);
    HubControl::ProcessGenericTimer(work);
}

void HubControl::Main_FadeOutForExitDockArea()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_BLACK, 1) == 0)
    {
        work->field_10 = HubConfig__GetDockMapIconConfig(work->mapArea)->field_8;
        CViDock::InitForType1(work->field_10, 0);
        work->nextMapArea = work->mapArea;
        CViHubAreaPreview::Create(work);
        ViMap__EnableMapIcons(TRUE);
        work->flags |= 0x10000;
        SetCurrentTaskMainEvent(HubControl::Main_InitMap);
        renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Main_FadeOutForEventChange()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_BLACK, 1) == 0)
    {
        s32 event     = work->nextEvent;
        s32 selection = work->nextSelectionID;

        work->Release();
        DestroyCurrentTask();
        ClearPixelsQueue();
        ClearPaletteQueue();
        Mappings__ClearQueue();

        renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

        HubControl::ChangeEvent(event, selection);
    }
    else
    {
        HubControl::ProcessGenericTimer(work);
    }
}

void HubControl::Main_21588D4()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    work->timer++;
    if (work->timer >= 64)
    {
        ViMap__GoToMapArea(work->mapIconArea, TRUE);
        SetCurrentTaskMainEvent(HubControl::Main_2158918);
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Main_2158918()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (work->mapIconArea == ViMap__GetMapAreaFromMapIconMarker(TRUE))
    {
        work->timer = 0;
        SetCurrentTaskMainEvent(HubControl::Main_2158958);
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Main_2158958()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    work->timer++;
    if (work->timer >= 64)
    {
        if (work->mapIconArea == MAPAREA_BASE)
        {
            HubControl::IncrementGameProgress();
            work->field_11C = 1;
        }
        else if (work->mapIconArea == MAPAREA_JET)
        {
            work->field_11C = 1;
            work->field_118 = 1;
        }
        else if (work->mapIconArea == MAPAREA_TUTORIAL)
        {
            work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
            work->nextSelectionID = SAVE_PROGRESSTYPE_0;
            work->flags |= 0x10000;
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
            return;
        }

        work->flags |= 0x10000;
        SetCurrentTaskMainEvent(HubControl::Main_InitMap);
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Main_2158A04()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    work->timer++;
    if (work->timer >= 64)
    {
        if (SaveGame__CheckProgress30())
        {
            SaveGame__UpdateProgressForAllDoorPuzzleKeysCollected();
            work->SaveState(TRUE);
            work->nextEvent       = HUBEVENT_CUTSCENE_2;
            work->nextSelectionID = CUTSCENE_CRUEL_TO_BE_KIND;
            work->flags |= 0x10000;
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
        }
        else if (SaveGame__CheckProgress15())
        {
            work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
            work->nextSelectionID = SAVE_PROGRESSTYPE_0;
            work->flags |= 0x10000;
            HubControl::TryFadeOutBGM(work);
            SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
        }
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Main_2158AB4()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    work->timer++;
    if (work->timer >= 64)
    {
        if (work->cutsceneID == 0xFFFE)
        {
            work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
            work->nextSelectionID = SAVE_PROGRESSTYPE_8;
        }
        else if (work->cutsceneID == 0xFFFF)
        {
            work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
            work->nextSelectionID = SAVE_PROGRESSTYPE_0;
        }
        else
        {
            work->nextEvent       = HUBEVENT_CUTSCENE_2;
            work->nextSelectionID = work->cutsceneID;
        }

        work->flags |= 0x10000;

        HubControl::TryFadeOutBGM(work);
        SetCurrentTaskMainEvent(HubControl::Main_FadeOutForEventChange);
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Destructor(Task *task)
{
    HubControl *work = TaskGetWork(task, HubControl);

    work->Release();
    HubTaskDestroy<HubControl>(task);

    hubControlTaskSingleton = NULL;
}

// CViHubAreaPreview
void CViHubAreaPreview::Create(HubControl *parent)
{
    CViHubAreaPreview::Destroy(parent);

    parent->hubAreaPreview =
        TaskCreateNoWork(CViHubAreaPreview::Main, CViHubAreaPreview::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1051, TASK_GROUP(16), "CViHubAreaPreview");

    parent->SetAreaSpritesForInit();
    parent->SetAreaSpritesForAreaChange(parent->mapArea);
}

void CViHubAreaPreview::Destroy(HubControl *parent)
{
    if (parent->hubAreaPreview != NULL)
    {
        if (!CViDock::Func_215E4A0())
        {
            CViDock::InitForInactive();
            parent->nextMapArea = DOCKAREA_INVALID;
        }

        DestroyTask(parent->hubAreaPreview);
        parent->hubAreaPreview = NULL;
    }
}

void CViHubAreaPreview::Main()
{
    HubControl *hubControl = TaskGetWork(hubControlTaskSingleton, HubControl);

    s32 mapArea = ViMap__GetMapAreaFromMapIconMarker(FALSE);
    if (mapArea != hubControl->nextMapArea)
    {
        if (hubControl->ProcessHideNpcIcons())
        {
            hubControl->SetAreaSpritesForAreaChange(mapArea);

            if (mapArea == MAPAREA_TUTORIAL)
            {
                hubControl->nextMapArea = mapArea;
                CViDock::InitForInactive();
            }
            else
            {
                hubControl->field_10 = HubConfig__GetDockMapIconConfig(mapArea)->field_8;

                if (hubControl->field_10 < DOCKAREA_COUNT)
                {
                    hubControl->nextMapArea = mapArea;
                    CViDock::InitForType1(hubControl->field_10, 1);
                }
                else
                {
                    hubControl->nextMapArea = DOCKAREA_INVALID;
                    CViDock::InitForInactive();
                }
            }
        }
    }
    else
    {
        if (hubControl->nextMapArea == MAPAREA_TUTORIAL || CViDock::Func_215E4A0())
            hubControl->ProcessShowNpcIcons();
    }

    hubControl->DrawNpcIcons();
}

void CViHubAreaPreview::Destructor(Task *task)
{
    HubControl *hubControl = TaskGetWork(hubControlTaskSingleton, HubControl);

    hubControl->ReleaseAnimators();
}

// HubControl
void HubControl::Func_2158D28()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_BLACK, 1) == 0)
    {
        ViMap__SetType(CViMap::TYPE_CONSTRUCTION_CUTSCENE);

        if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT)
        {
            ReleaseHubAudio(TRUE);
            LoadSysSound(SYSSOUND_GROUP_DOCK);
            PlaySysTrack(SND_SYS_SEQ_SEQ_DOCK, TRUE);
            ViMap__StartShipConstructCutscene(work->shipConstructID);
        }
        else
        {
            if (work->decorConstructID < CViMap::CONSTRUCT_DECOR_COUNT)
            {
                PlayHubDecorationJingle();
                ViMap__StartDecorConstructCutscene(work->decorConstructID);
                SetHubBGMVolume(work->field_13A = AUDIOMANAGER_VOLUME_MAX);
            }
            else
            {
                ReleaseHubAudio(TRUE);
                LoadSysSound(SYSSOUND_GROUP_POWERUP);
                PlaySysTrack(SND_SYS_SEQ_SEQ_POWERUP, TRUE);
                ViMap__StartShipUpgradeCutscene(work->shipUpgradeID);
            }
        }

        CViDock::InitForInactive();
        work->nextMapArea = DOCKAREA_INVALID;
        HubControl::InitEngineAForCutscene();
        work->field_110 = 0;
        work->field_8   = work->genericTimer;
        SetCurrentTaskMainEvent(HubControl::Func_2158E14);
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Func_2158E14()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (work->decorConstructID < CViMap::CONSTRUCT_DECOR_COUNT)
    {
        if (work->field_13A > 63)
        {
            work->field_13A--;
            SetHubBGMVolume(work->field_13A);
        }
    }

    if (work->field_8 - work->genericTimer >= 30)
    {
        work->field_110 += FLOAT_TO_FX32(1.0f / 128.0f);

        if (work->field_110 > FLOAT_TO_FX32(1.0))
            work->field_110 = FLOAT_TO_FX32(1.0);

        ViMap__Func_215C284(work->field_110);
    }

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_DEFAULT, 1) == 0 && work->field_110 >= FLOAT_TO_FX32(1.0))
    {
        if (work->decorConstructID < CViMap::CONSTRUCT_DECOR_COUNT)
            SetHubBGMVolume(AUDIOMANAGER_VOLUME_MAX / 2);

        if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT)
        {
            ViMap__Func_215C408();
            SetCurrentTaskMainEvent(HubControl::Func_2158F28);
        }
        else if (work->decorConstructID < CViMap::CONSTRUCT_DECOR_COUNT)
        {
            work->field_10C = 0;
            work->field_8   = work->genericTimer;
            SetCurrentTaskMainEvent(HubControl::Func_2159084);
        }
        else
        {
            ViMap__Func_215C408();
            SetCurrentTaskMainEvent(HubControl::Func_2158F28);
        }
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Func_2158F28()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (ViMap__Func_215C48C())
    {
        ViMap__Func_215C4CC();
        work->field_10C = 0;
        SetCurrentTaskMainEvent(HubControl::Func_2158F64);
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Func_2158F64()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    BOOL flag = FALSE;

    // ???
    if (ViMap__Func_215C4F8() == FALSE)
    {
        flag = FALSE;
    }

    if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT)
    {
        if (ViMap__Func_215C4F8() && HubControl::HandleFade(RENDERCORE_BRIGHTNESS_WHITE, RENDERCORE_BRIGHTNESS_WHITE, 1) == 0)
        {
            flag = TRUE;
        }
    }
    else
    {
        if (ViMap__Func_215C4F8() && HubControl::HandleFade(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_WHITE, 1) == 0)
        {
            flag = TRUE;
        }
    }

    if (flag)
    {
        if (work->field_10C == 0)
        {
            work->field_10C = 1;
        }
        else
        {
            if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT)
            {
                u16 value = HubConfig__GetDockMapIconConfig(HubConfig__GetDockMapConfig(work->shipConstructID)->unknownArea)->field_3C;
                ViMap__Func_215C524(value);
                ViMap__Func_215C638(value);
                HubControl::InitEngineAForUnknown();
                CViDock::InitForConstructionCutscene(work->shipConstructID);
            }
            else
            {
                const CViMapAreaIconConfig *config = HubConfig__GetDockMapIconConfig(HubConfig__GetDockMapUnknownConfig(work->shipUpgradeID)->unknownArea);
                ViMap__Func_215C76C(config->field_3C);
            }

            work->field_8 = work->genericTimer;
            SetCurrentTaskMainEvent(HubControl::Func_2159104);
        }
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Func_2159084()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (work->genericTimer - work->field_8 >= 60 && HubControl::HandleFade(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_WHITE, 1) == 0)
    {
        if (work->field_10C)
        {
            ViMap__Func_215C58C(work->decorConstructID);
            ViMap__Func_215C6AC();

            work->field_8 = work->genericTimer;
            SetCurrentTaskMainEvent(HubControl::Func_2159104);
        }
        else
        {
            work->field_10C = 1;
        }
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Func_2159104()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    u32 timer;
    u32 duration1;
    u32 duration2;
    s16 fadeTargetA;
    if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT)
    {
        fadeTargetA = RENDERCORE_BRIGHTNESS_DEFAULT;
        duration1   = 210;
        duration2   = 450;
    }
    else
    {
        fadeTargetA = RENDERCORE_BRIGHTNESS_DEFAULT;
        duration1   = 120;
        duration2   = 256;
    }
    timer = work->genericTimer - work->field_8;

    s16 fadeTargetB = RENDERCORE_BRIGHTNESS_DEFAULT;
    if (timer > 60 && HubControl::HandleFade(fadeTargetA, fadeTargetB, 1) == 0)
    {
        if (timer > duration1)
        {
            if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT)
                CViDock::Func_215DF84();

            if (timer > duration2)
            {
                if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT)
                    FadeSysTrack(12);

                work->field_8 = work->genericTimer;
                SetCurrentTaskMainEvent(HubControl::Func_21591A8);
            }
        }
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Func_21591A8()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT)
        CViDock::Func_215DF84();

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_BLACK, 1) == 0)
    {
        ViMap__Func_215C7E0();
        ViMap__SetType(CViMap::TYPE_DOCK_ACTIVE);

        if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT)
        {
            HubControl::UpdateSaveProgressForShipConstructed(work->shipConstructID, TRUE);
        }
        else
        {
            if (work->decorConstructID < CViMap::CONSTRUCT_DECOR_COUNT)
            {
                HubControl::UpdateSaveForDecorConstruction(work->decorConstructID, TRUE);
                HubControl::InitEngineAForUnknown();
            }
            else
            {
                HubControl::InitEngineAForUnknown();
            }
        }

        if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT || work->decorConstructID == CViMap::CONSTRUCT_DECOR_7 || work->shipUpgradeID < CViMap::UPGRADE_SHIP_COUNT)
        {
            work->mapArea     = MAPAREA_BASE;
            work->nextMapArea = MAPAREA_BASE;
            work->dockArea    = DOCKAREA_BASE;
            ViMap__InitMapIcons();
            ViMap__GoToMapArea(work->mapArea, 0);
            CViDock::InitForPlayerControl(work->dockArea);
        }
        else
        {
            ViMap__InitMapIcons();
            ViMap__GoToMapArea(work->mapArea, 0);
            CViDock::InitForPlayerControl(work->dockArea);
            CViDock::LoadCharacterStates(TRUE);
        }

        if (work->decorConstructID < CViMap::CONSTRUCT_DECOR_COUNT)
        {
            ReleaseHubBGM();
            SetHubBGMVolume(AUDIOMANAGER_VOLUME_MAX);
        }
        else
        {
            ReleaseSysSound();
            InitHubAudio();
            PlayHubBGM();
            SetHubBGMVolume(AUDIOMANAGER_VOLUME_MAX);
        }

        work->field_8 = work->genericTimer;
        SetCurrentTaskMainEvent(HubControl::Func_21592E0);
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::Func_21592E0()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_DEFAULT, 1) == 0)
    {
        if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT)
        {
            s32 i;
            for (i = 0; i < CViMap::CONSTRUCT_SHIP_COUNT; i++)
            {
                if (!HubControl::CheckShipConstructed(i))
                    break;
            }

            CViDock::SetTalkingNpc(work->talkingNpc);
            CViDock::StartTalkingToNpc();
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_NPC, i);
            SetCurrentTaskMainEvent(HubControl::Main_DoTalkAction);
        }
        else if (work->decorConstructID < CViMap::CONSTRUCT_DECOR_COUNT)
        {
            CViDock::SetTalkingNpc(work->talkingNpc);
            CViDock::StartTalkingToNpc();
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_NPC, work->decorConstructID + 8);
            SetCurrentTaskMainEvent(HubControl::Main_DoTalkAction);
        }
        else if (work->shipUpgradeID < CViMap::UPGRADE_SHIP_COUNT)
        {
            u16 ship;
            u16 level;
            SaveGame__GetNextShipUpgrade(&ship, &level);

            CViDock::SetTalkingNpc(work->talkingNpc);
            CViDock::StartTalkingToNpc();
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_NPC, level + 29 + 2 * ship);
            SetCurrentTaskMainEvent(HubControl::Main_DoTalkAction);
        }

        work->shipConstructID  = CViMap::CONSTRUCT_SHIP_INVALID;
        work->decorConstructID = CViMap::CONSTRUCT_DECOR_INVALID;
        work->shipUpgradeID    = CViMap::UPGRADE_SHIP_INVALID;
    }

    HubControl::ProcessGenericTimer(work);
}

void HubControl::LoadArchives()
{
    this->viActArchive = ArchiveFileUnknown__LoadFile("narc/vi_act_lz7.narc", FILEUNKNOWN_AUTO_ALLOC_HEAD);

    GetCompressedFileFromBundle("bb/vi_act_loc.bb", BUNDLE_VI_ACT_LOC_FILE_RESOURCES_BB_VI_ACT_LOC_VI_ACT_LOC_JPN_NARC + GetGameLanguage(), &this->viActLocArchive, TRUE, FALSE);

    this->viBGArchive = ArchiveFileUnknown__LoadFile("narc/vi_bg_lz7.narc", FILEUNKNOWN_AUTO_ALLOC_HEAD);

    GetCompressedFileFromBundle("bb/vi_bg_up.bb", BUNDLE_VI_BG_UP_FILE_RESOURCES_BB_VI_BG_UP_VI_BG_UP_JPN_NARC + GetGameLanguage(), &this->viBGUpArchive, TRUE, FALSE);

    GetCompressedFileFromBundle("bb/vi_msg.bb", BUNDLE_VI_MSG_FILE_RESOURCES_BB_VI_MSG_VI_MSG_JPN_NARC + GetGameLanguage(), &this->viMsgArchive, TRUE, FALSE);

    FSRequestArchive("narc/vi_msg_ctrl_lz7.narc", &this->viMsgCtrlArchive, TRUE);

    this->fontFile = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);

    this->tkdmNameSprite = ReadFileFromBundle("bb/tkdm_name.bb", BUNDLE_TKDM_NAME_FILE_RESOURCES_BB_TKDM_NAME_TKDM_NAME_JPN_BAC + GetGameLanguage(), BINARYBUNDLE_AUTO_ALLOC_HEAD);

    FontWindow__Init(&this->fontWindow);
    FontWindow__LoadFromMemory(&this->fontWindow, this->fontFile, TRUE);
    FontWindow__Load_mw_frame(&this->fontWindow);
    FontWindow__SetDMA(&this->fontWindow, 1);
}

void HubControl::ReleaseAssets()
{
    if (this->viMsgArchive != NULL)
    {
        HeapFree(HEAP_USER, this->viMsgArchive);
        this->viMsgArchive = NULL;
    }

    if (this->viMsgCtrlArchive != NULL)
    {
        HeapFree(HEAP_USER, this->viMsgCtrlArchive);
        this->viMsgCtrlArchive = NULL;
    }

    FontWindow__Release(&this->fontWindow);

    if (this->tkdmNameSprite != NULL)
    {
        HeapFree(HEAP_USER, this->tkdmNameSprite);
        this->tkdmNameSprite = NULL;
    }

    if (this->fontFile != NULL)
    {
        HeapFree(HEAP_USER, this->fontFile);
        this->fontFile = NULL;
    }

    if (this->viBGUpArchive != NULL)
    {
        HeapFree(HEAP_USER, this->viBGUpArchive);
        this->viBGUpArchive = NULL;
    }

    if (this->viBGArchive != NULL)
    {
        HeapFree(HEAP_USER, this->viBGArchive);
        this->viBGArchive = NULL;
    }

    if (this->viActLocArchive != NULL)
    {
        HeapFree(HEAP_USER, this->viActLocArchive);
        this->viActLocArchive = NULL;
    }

    if (this->viActArchive != NULL)
    {
        HeapFree(HEAP_USER, this->viActArchive);
        this->viActArchive = NULL;
    }
}

void HubControl::ProcessGenericTimer(HubControl *work)
{
    work->touchFlags = 0;
    work->genericTimer++;
}

void HubControl::SaveState(BOOL isMap)
{
    ResetHubState();

    if (isMap)
    {
        HubState__SetHubType(HUB_TYPE_MAP);
        HubState__SetHubArea(this->mapArea);
    }
    else
    {
        HubState__SetHubType(HUB_TYPE_DOCK);
        HubState__SetHubArea(this->dockArea);
        CViDock::SaveCharacterStates();
    }
}

void HubControl::StartHubCutscene(s16 cutscene, s32 dockArea)
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    ResetHubState();
    HubState__SetHubType(HUB_TYPE_DOCK);

    if (dockArea < DOCKAREA_DRILL)
        HubState__SetHubArea(dockArea);
    else
        HubState__SetHubArea(work->dockArea);

    work->timer      = 0;
    work->cutsceneID = cutscene;
    work->flags &= ~0x10000;

    SetCurrentTaskMainEvent(HubControl::Main_2158AB4);
}

void HubControl::StartHubCutsceneUnknown()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    ResetHubState();

    work->timer      = 0;
    work->cutsceneID = 0xFFFE;
    work->flags &= ~0x10000;

    SetCurrentTaskMainEvent(HubControl::Main_2158AB4);
}

BOOL HubControl::CheckEventHasBGMChange(s32 event)
{
    switch (event)
    {
        case HUBEVENT_UPDATE_PROGRESS:
        case HUBEVENT_SAILING:
        case HUBEVENT_DELETE_SAVE_MENU:
        case HUBEVENT_CUTSCENE_1:
        case HUBEVENT_CUTSCENE_2:
        case HUBEVENT_START_MISSION:
        case HUBEVENT_START_TUTORIAL:
        case HUBEVENT_SOUND_TEST:
        case HUBEVENT_LOAD_STAGE:
        case HUBEVENT_CORRUPT_SAVE_WARNING:
            return TRUE;

        case HUBEVENT_MAIN_MENU:
        case HUBEVENT_PLAYER_NAME_MENU:
        case HUBEVENT_VS_MAIN_MENU:
        case HUBEVENT_STAGE_SELECT:
        case HUBEVENT_VIKING_CUP:
            return FALSE;

        default:
            return TRUE;
    }
}

void HubControl::TryFadeOutBGM(HubControl *work)
{
    if (HubControl::CheckEventHasBGMChange(work->nextEvent))
        FadeSysTrack(8);
}

void HubControl::ClearAnimators()
{
    this->curAreaID  = DOCKAREA_INVALID;
    this->npcCount   = 0;
    this->field_140  = 0;
    this->npcIconPos = 0;

    MI_CpuClear16(this->aniNpcIcon, sizeof(this->aniNpcIcon));
    MI_CpuClear16(&this->aniNpcBackground, sizeof(this->aniNpcBackground));
    MI_CpuClear16(this->aniOptionsIcon, sizeof(this->aniOptionsIcon));
    MI_CpuClear16(this->aniOptionsName, sizeof(this->aniOptionsName));
}

void HubControl::SetAreaSpritesForInit()
{
    HubControl::InitEngineAForAreaSelect();

    void *sprDockHUD    = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_VI_DOCK_UP_BAC);
    void *sprDockHUDLoc = HubControl::GetFileFrom_ViActLoc(ARCHIVE_VI_ACT_LOC_ENG_FILE_VI_DOCK_UP_LOC_BAC);

    AnimatorSprite *aniNpcBackground = &this->aniNpcBackground;
    AnimatorSprite__Init(aniNpcBackground, sprDockHUD, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1FromAnim(sprDockHUD, 0)), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0,
                         SPRITE_ORDER_15);
    aniNpcBackground->cParam.palette = PALETTE_ROW_0;

    s32 i;
    AnimatorSprite *aniNpcIcon;
    u32 size = Sprite__GetSpriteSize1(sprDockHUD);

    aniNpcIcon = &this->aniNpcIcon[0];
    for (i = 0; i < (s32)ARRAY_COUNT(this->aniNpcIcon);)
    {
        AnimatorSprite__Init(aniNpcIcon, sprDockHUD, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, size),
                             PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, i);

        i++;
        aniNpcIcon->cParam.palette = i;

        aniNpcIcon++;
    }

    size                           = Sprite__GetSpriteSize1(sprDockHUD);
    AnimatorSprite *aniOptionsIcon = &this->aniOptionsIcon[0];
    for (i = 0; i < (s32)ARRAY_COUNT(this->aniOptionsIcon); i++)
    {
        AnimatorSprite__Init(aniOptionsIcon, sprDockHUD, i + 12, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, size),
                             PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        aniOptionsIcon->cParam.palette = i + PALETTE_ROW_6;

        aniOptionsIcon++;
    }

    size                           = Sprite__GetSpriteSize1(sprDockHUDLoc);
    AnimatorSprite *aniOptionsName = &this->aniOptionsName[0];
    for (i = 0; i < (s32)ARRAY_COUNT(this->aniOptionsName); i++)
    {
        AnimatorSprite__Init(aniOptionsName, sprDockHUDLoc, i, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, size),
                             PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        aniOptionsName->cParam.palette = PALETTE_ROW_8;

        aniOptionsName++;
    }

    Background background;
    InitBackground(&background, HubControl::GetFileFrom_ViBG(ARCHIVE_VI_BG_LZ7_FILE_VI_UP_FLAME_BBG), BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_A, BACKGROUND_2, BG_DISPLAY_FULL_WIDTH,
                   BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&background);

    InitBackground(&background, HubControl::GetFileFrom_ViBG(ARCHIVE_VI_BG_LZ7_FILE_VI_TUTO_IMAGE_NEAR_BBG), BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_A, BACKGROUND_1,
                   BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&background);

    InitBackground(&background, HubControl::GetFileFrom_ViBG(ARCHIVE_VI_BG_LZ7_FILE_VI_TUTO_IMAGE_FAR_BBG), BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_A, BACKGROUND_3,
                   BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&background);

    InitBackgroundEx(&background, FileUnknown__GetAOUFile(this->viBGUpArchive, ARCHIVE_VI_BG_UP_ENG_FILE_VI_UP_NAME_BBG), BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_A, BACKGROUND_2,
                     PALETTE_MODE_SPRITE, VRAM_BG_PLTT, 0, VRAM_BG, MAPPINGS_MODE_TEXT_256x256_A, 0, 4, 5, 0, 20, 2);
    DrawBackground(&background);
}

void HubControl::ReleaseAnimators()
{
    s32 i;

    for (i = 0; i < 3; i++)
    {
        AnimatorSprite__Release(&this->aniOptionsName[i]);
    }

    for (i = 0; i < 2; i++)
    {
        AnimatorSprite__Release(&this->aniOptionsIcon[i]);
    }

    for (i = 0; i < 5; i++)
    {
        AnimatorSprite__Release(&this->aniNpcIcon[i]);
    }

    AnimatorSprite__Release(&this->aniNpcBackground);

    HubControl::InitEngineAForExitHub();
    this->ClearAnimators();

    MI_CpuClear16(&renderCoreGFXControlA.blendManager, sizeof(renderCoreGFXControlA.blendManager));
}

void HubControl::ReleaseGraphics()
{
    this->ReleaseAnimators();
}

BOOL HubControl::ProcessHideNpcIcons()
{
    if (this->npcIconPos < 16)
    {
        this->npcIconPos += 2;
        if (this->npcIconPos > 16)
            this->npcIconPos = 16;

        return FALSE;
    }

    return TRUE;
}

BOOL HubControl::ProcessShowNpcIcons()
{
    if (this->npcIconPos > 0)
    {
        this->npcIconPos -= 2;
        if (this->npcIconPos < 0)
            this->npcIconPos = 0;

        return FALSE;
    }

    return TRUE;
}

void HubControl::SetAreaSpritesForAreaChange(s32 area)
{
    u16 activeNpcAnimList[5];

    u8 npcAnimIDList[] = { 10, 8, 9, 11, 1, 2, 3, 4, 5, 6, 7, 0xFF, 0xFF };

    u8 backgroundFiles[DOCKAREA_COUNT] = { ARCHIVE_VI_BG_UP_ENG_FILE_VI_UP_PLACE_00_BBG, ARCHIVE_VI_BG_UP_ENG_FILE_VI_UP_PLACE_02_BBG, ARCHIVE_VI_BG_UP_ENG_FILE_VI_UP_PLACE_03_BBG,
                                           ARCHIVE_VI_BG_UP_ENG_FILE_VI_UP_PLACE_04_BBG, ARCHIVE_VI_BG_UP_ENG_FILE_VI_UP_PLACE_05_BBG, ARCHIVE_VI_BG_UP_ENG_FILE_VI_UP_PLACE_07_BBG,
                                           ARCHIVE_VI_BG_UP_ENG_FILE_VI_UP_PLACE_06_BBG, ARCHIVE_VI_BG_UP_ENG_FILE_VI_UP_PLACE_01_BBG };

    s32 i;

    if (area != this->curAreaID)
    {
        this->curAreaID = area;

        MIi_CpuClear16(0xFF, activeNpcAnimList, sizeof(activeNpcAnimList));

        this->npcCount = 0;
        if (area < DOCKAREA_COUNT)
        {
            s32 npcCount = npcCountForArea[area];
            s32 n;
            u16 npcID = npcStartIDForArea[area];

            for (n = 0; n < npcCount; n++)
            {
                if (HubControl::CanSpawnNpcType(npcID))
                {
                    if (HubControl::CanSpawnNpc(npcID))
                    {
                        u8 animID = npcAnimIDList[HubConfig__GetNpcConfig(npcID)->type];
                        if (animID != 0xFF)
                        {
                            activeNpcAnimList[this->npcCount] = animID;
                            this->npcCount++;
                        }
                    }
                }

                npcID++;
            }

            for (i = 0; i < this->npcCount - 1; i++)
            {
                if (activeNpcAnimList[i] == 1)
                {
                    activeNpcAnimList[i]     = activeNpcAnimList[i + 1];
                    activeNpcAnimList[i + 1] = 1;
                }
            }

            for (i = 0; i < this->npcCount; i++)
            {
                AnimatorSprite__SetAnimation(&this->aniNpcIcon[i], activeNpcAnimList[i]);
            }

            if (area == DOCKAREA_DRILL)
                GX_SetVisiblePlane(GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ);
            else
                GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG2 | GX_PLANEMASK_OBJ);

            Background background;
            InitBackgroundEx(&background, FileUnknown__GetAOUFile(this->viBGUpArchive, backgroundFiles[area]), BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_A, BACKGROUND_2,
                             PALETTE_MODE_SPRITE, VRAM_BG_PLTT, PIXEL_MODE_SPRITE, VRAM_BG, MAPPINGS_MODE_TEXT_256x256_A, 0, 4, 6, 2, 20, 2);
            DrawBackground(&background);
        }
    }
}

void HubControl::DrawNpcIcons()
{
    AnimatorSprite *aniNpcName;
    AnimatorSprite *aniNpcIcon;
    AnimatorSprite *aniNpcBackground;
    s32 i;
    s16 x;
    s16 iconPos;

    MI_CpuClear16(&renderCoreGFXControlA.blendManager, sizeof(renderCoreGFXControlA.blendManager));

    if (this->npcIconPos != 0)
    {
        renderCoreGFXControlA.blendManager.coefficient.value5      = this->npcIconPos;
        renderCoreGFXControlA.blendManager.blendControl.effect     = BLENDTYPE_FADEOUT;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG0 = TRUE;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG1 = TRUE;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG3 = TRUE;

        ((u16 *)VRAM_BG_PLTT)[0] = GX_RGB_888(0x00, 0x00, 0x00);
    }

    iconPos          = 3 * this->npcIconPos;
    aniNpcBackground = &this->aniNpcBackground;
    AnimatorSprite__ProcessAnimationFast(aniNpcBackground);

    x = HW_LCD_WIDTH - 40 * this->npcCount;

    for (i = 0; i < this->npcCount; i++)
    {
        aniNpcIcon = &this->aniNpcIcon[i];

        aniNpcIcon->pos.x = x;
        aniNpcIcon->pos.y = iconPos + 152;
        AnimatorSprite__ProcessAnimationFast(aniNpcIcon);
        AnimatorSprite__DrawFrame(aniNpcIcon);

        aniNpcBackground->pos.x = aniNpcIcon->pos.x;
        aniNpcBackground->pos.y = aniNpcIcon->pos.y;
        AnimatorSprite__DrawFrame(aniNpcBackground);

        if (iconPos == 0 && aniNpcIcon->animID == 1)
        {
            aniNpcName        = &this->aniOptionsName[2];
            aniNpcName->pos.x = aniNpcIcon->pos.x;
            aniNpcName->pos.y = aniNpcIcon->pos.y;
            AnimatorSprite__ProcessAnimationFast(aniNpcName);
            AnimatorSprite__DrawFrame(aniNpcName);
        }

        x += 40;
    }

    if (this->curAreaID == DOCKAREA_BASE)
    {
        aniNpcIcon        = &this->aniOptionsIcon[1];
        aniNpcIcon->pos.x = 216;
        aniNpcIcon->pos.y = 4 - iconPos;
        AnimatorSprite__ProcessAnimationFast(aniNpcIcon);
        AnimatorSprite__DrawFrame(aniNpcIcon);

        aniNpcBackground->pos.x = aniNpcIcon->pos.x;
        aniNpcBackground->pos.y = aniNpcIcon->pos.y;
        AnimatorSprite__DrawFrame(aniNpcBackground);

        if (iconPos == 0)
        {
            aniNpcName        = &this->aniOptionsName[1];
            aniNpcName->pos.x = aniNpcIcon->pos.x;
            aniNpcName->pos.y = aniNpcIcon->pos.y;
            AnimatorSprite__ProcessAnimationFast(aniNpcName);
            AnimatorSprite__DrawFrame(aniNpcName);
        }

        if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_3)
        {
            aniNpcIcon        = &this->aniOptionsIcon[0];
            aniNpcIcon->pos.x = 176;
            aniNpcIcon->pos.y = 4 - iconPos;
            AnimatorSprite__ProcessAnimationFast(aniNpcIcon);
            AnimatorSprite__DrawFrame(aniNpcIcon);
            aniNpcBackground->pos.x = aniNpcIcon->pos.x;
            aniNpcBackground->pos.y = aniNpcIcon->pos.y;
            AnimatorSprite__DrawFrame(aniNpcBackground);

            if (iconPos == 0)
            {
                aniNpcName        = &this->aniOptionsName[0];
                aniNpcName->pos.x = aniNpcIcon->pos.x;
                aniNpcName->pos.y = aniNpcIcon->pos.y;
                AnimatorSprite__ProcessAnimationFast(aniNpcName);
                AnimatorSprite__DrawFrame(aniNpcName);
            }
        }
    }

    if (this->curAreaID == DOCKAREA_DRILL)
        renderCoreGFXControlA.bgPosition[BACKGROUND_3].x = this->field_140 >> 5;

    this->field_140++;
}

void HubControl::Func_215A2E0(s32 a1, s32 a2)
{
    if (a2)
    {
        switch (a1)
        {
            case 2:
                if (SaveGame__GetGameProgress() < SAVE_PROGRESS_3)
                {
                    VikingCupManager__EventStartVikingCup(0);
                }
                else
                {
                    VikingCupManager__EventStartVikingCup(1);
                    gameState.talk.state.hubStartAction = 1;
                }
                break;

            case 3:
                VikingCupManager__EventStartVikingCup(2);
                gameState.talk.state.hubStartAction = 1;
                break;

            case 4:
                VikingCupManager__EventStartVikingCup(3);
                gameState.talk.state.hubStartAction = 1;
                break;

            case 5:
                VikingCupManager__EventStartVikingCup(4);
                gameState.talk.state.hubStartAction = 1;
                break;
        }
    }
    else
    {
        gameState.missionType      = 0;
        gameState.missionTimeLimit = 0;
        switch (a1)
        {
            case 2:
                gameState.sailShipType = SHIP_JET;
                break;

            case 3:
                gameState.sailShipType = SHIP_BOAT;
                break;

            case 4:
                gameState.sailShipType = SHIP_HOVER;
                break;

            case 5:
                gameState.sailShipType = SHIP_SUBMARINE;
                break;
        }
    }
}

void HubControl::IncrementGameProgress()
{
    SaveGame__SetGameProgress(SaveGame__GetGameProgress() + 1);
}

void HubControl::ChangeEvent(s32 eventID, s32 selection)
{
    if (eventID >= HUBEVENT_COUNT)
        eventID = HUBEVENT_UPDATE_PROGRESS;

    switch (eventID)
    {
        case HUBEVENT_UPDATE_PROGRESS:
            SaveGame__SetProgressType(selection);
            break;

        case HUBEVENT_MAIN_MENU:
            gameState.saveFile.field_54 = 0;
            break;

        case HUBEVENT_CUTSCENE_1:
            HubControl::Func_215B8FC(selection);
            break;

        case HUBEVENT_CUTSCENE_2:
            HubControl::Func_215B92C(selection);
            break;

        case HUBEVENT_START_MISSION:
            MissionHelpers__StartMission(selection);
            break;

        case HUBEVENT_START_TUTORIAL:
            HubControl::Func_215B958();
            break;

        case HUBEVENT_VIKING_CUP:
            gameState.vikingCupID = 0;
            break;

        case HUBEVENT_LOAD_STAGE:
        case HUBEVENT_CORRUPT_SAVE_WARNING:
            break;
    }

    HubControl::ResetMainMemoryPriorityFromHub();

    const s16 sysEventList[] = {
        SYSEVENT_UPDATE_PROGRESS, SYSEVENT_SAILING,    SYSEVENT_MAIN_MENU,  SYSEVENT_DELETE_SAVE_MENU, SYSEVENT_PLAYER_NAME_MENU,
        SYSEVENT_VS_MENU,         SYSEVENT_24,         SYSEVENT_CUTSCENE,   SYSEVENT_CUTSCENE,         SYSEVENT_INVALID,
        SYSEVENT_LOAD_STAGE,      SYSEVENT_SOUND_TEST, SYSEVENT_VIKING_CUP, SYSEVENT_LOAD_STAGE,       SYSEVENT_CORRUPT_SAVE_WARNING,
    };

    s16 sysEventID = sysEventList[eventID];
    if (sysEventID >= 0)
        RequestNewSysEventChange(sysEventID);

    NextSysEvent();
}
