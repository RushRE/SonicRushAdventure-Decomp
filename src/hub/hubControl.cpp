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
static const u16 npcStartIDForArea[DOCKAREA_COUNT] = { 0, 9, 13, 16, 18, 20, 0, 0 };

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
            HubControl::Func_2157124();
        else
            HubControl::Func_215713C();
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

        if (gameState.talk.state.hubStartAction && gameState.talk.state.hubStartAction < 8)
        {
            HubControl::Func_215701C(gameState.talk.state.hubStartAction);
        }
        else
        {
            MI_CpuClear32(&gameState.talk, sizeof(gameState.talk));
            HubControl::Func_215700C();
        }
    }
}

void HubControl::Func_215700C()
{
    HubControl::Create(DOCKAREA_BASE);
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

        HubControl::Create2(DOCKAREA_BASE, 0, 0);

        HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);
        work->field_130  = 1;
        work->field_134  = field_134;
    }
    else
    {
        if (HubState__GetHubType() == 0)
        {
            HubControl::Create(HubState__GetHubArea());
        }
        else
        {
            if (HubState__GetHubType() == 1)
            {
                HubControl::Create2(HubState__GetHubArea(), 1, 0);
            }
            else
            {
                HubControl::Func_215700C();
            }
        }
    }
}

void HubControl::Func_21570B8(s32 a1)
{
    u8 area;

    if (a1 && HubState__GetHubType() == 1)
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

    HubControl::Create2(area, a1, 1);
}

void HubControl::Func_215710C(BOOL a2)
{
    HubControl::Create2(DOCKAREA_JET, a2, 1);
}

void HubControl::Func_2157124()
{
    HubControl::Create(DOCKAREA_SUBMARINE);
    HubControl::Func_21576AC(7);
}

void HubControl::Func_215713C()
{
    HubControl::Create(DOCKAREA_DRILL);
    HubControl::Func_21576AC(0);
}

void HubControl::Func_2157154()
{
    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);
    work->flags |= 1;
}

BOOL HubControl::Func_2157178()
{
    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);
    return (work->flags & 1) == 0;
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

void HubControl::Create(s32 area)
{
    HubControl::InitDisplay();

    hubControlTaskSingleton = HubTaskCreate(HubControl::Main1, HubControl::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1050, TASK_GROUP(16), HubControl);

    HubControl *work     = TaskGetWork(hubControlTaskSingleton, HubControl);
    work->field_0        = 0x10000;
    work->field_4        = 0;
    work->field_8        = 0;
    work->hubAreaPreview = NULL;
    work->nextEvent      = HUBEVENT_INVALID;
    work->field_C        = DOCKAREA_NONE;
    work->field_10       = HubConfig__Func_2152960(area)->field_8;
    work->nextAreaID2 = work->nextAreaID = area;
    work->shipConstructID                = CViMap::CONSTRUCT_SHIP_INVALID;
    work->decorConstructID               = CViMap::CONSTRUCT_DECOR_INVALID;
    work->shipUpgradeID                  = CViMap::UPGRADE_SHIP_INVALID;

    work->LoadArchives();

    ViMap__Create();
    ViMap__Func_215BCE4(work->nextAreaID, FALSE);
    ViMap__SetType(1);
    ViMap__Func_215C84C(1);

    ViDock__Create();

    if (area == DOCKAREA_DRILL)
    {
        work->nextAreaID2 = area;
        ViDock__Func_215DEF4();
    }
    else
    {
        ViDock__Func_215DD64(work->field_10, 0);
        ViDock__Func_215DF64(0);
    }

    work->ClearAnimators();
    HubHUD::Create();
    HubHUD::ConfigureViewButton(FALSE, TRUE);
    HubHUD::ConfigureMenuButton(FALSE, TRUE);
    ViMapPaletteAnimation__Create();
    CViHubAreaPreview::Create(work);
    ResetTouchInput();

    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    work->field_114 = 9;
    work->field_118 = 0;
    work->field_11C = 0;
    work->field_124 = 0;
    work->field_128 = 0;
    work->field_12C = 0;
    work->field_130 = 0;
    work->field_134 = 0;

    ResetHubState();
    InitHubAudio();
    PlayHubBGM();
}

void HubControl::Create2(s32 area, BOOL a2, s32 a3)
{
    HubControl::InitDisplay();

    hubControlTaskSingleton = HubTaskCreate(HubControl::Main2, HubControl::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1050, TASK_GROUP(16), HubControl);

    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);

    work->field_0        = 0x10000;
    work->field_4        = 0;
    work->field_8        = 0;
    work->hubAreaPreview = 0;
    work->nextEvent      = HUBEVENT_INVALID;
    work->field_C        = area;
    work->field_10       = 9;
    work->nextAreaID2 = work->nextAreaID = HubConfig__GetDockStageConfig(area)->nextArea;
    work->shipConstructID                = CViMap::CONSTRUCT_SHIP_INVALID;
    work->decorConstructID               = CViMap::CONSTRUCT_DECOR_INVALID;
    work->shipUpgradeID                  = CViMap::UPGRADE_SHIP_INVALID;

    work->LoadArchives();

    ViMap__Create();
    ViMap__Func_215BCE4(work->nextAreaID, 0);
    ViMap__SetType(1);
    ViMap__Func_215C84C(0);

    ViDock__Create();
    ViDock__Func_215DBC8(work->field_C);

    if (a2)
    {
        BOOL flag = TRUE;
        if (HubState__GetHubStartAction() == 1 || HubState__GetHubStartAction() == 3 || HubState__GetHubStartAction() == 5)
            flag = FALSE;

        ViDock__Func_215E578(flag);
    }

    ViDock__Func_215DF64(0);
    ViDock__Func_215E658(a3);

    work->ClearAnimators();

    HubHUD::Create();
    HubHUD::ConfigureViewButton(FALSE, TRUE);
    HubHUD::ConfigureMenuButton(FALSE, TRUE);

    ViMapPaletteAnimation__Create();

    ResetTouchInput();

    renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;

    work->field_114 = 9;
    work->field_118 = 0;
    work->field_11C = a3;
    work->field_124 = 0;
    work->field_128 = 0;
    work->field_12C = 0;
    work->field_130 = 0;
    work->field_134 = 0;

    if (a2)
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

void HubControl::Func_21576AC(s32 a1)
{
    HubControl *work = TaskGetWork(hubControlTaskSingleton, HubControl);
    work->field_114  = a1;
}

void HubControl::Release()
{
    CViHubAreaPreview::Func_2158C04(this);
    this->ReleaseGraphics();
    ViMapPaletteAnimation__Destroy();
    HubHUD::Destroy();
    ViDock__Func_215DB9C();
    ViMap__Destroy();
    this->ReleaseAssets();
    ReleaseHubAudio(HubControl::Func_2159854(this->nextEvent));
}

void HubControl::Main1()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    s32 area = DOCKAREA_INVALID;
    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_DEFAULT, 1) == 0)
    {
        work->field_0 &= ~0x10000;

        if (work->field_114 < DOCKAREA_COUNT)
        {
            s32 iconArea = ViMap__GetMapIconDockArea(TRUE);
            if (work->field_114 == iconArea)
            {
                area            = work->field_114;
                work->field_114 = DOCKAREA_INVALID;
            }
            else
            {
                work->field_120 = 0;
                SetCurrentTaskMainEvent(HubControl::Main_21588D4);
            }
        }
        else
        {
            if (SaveGame__CheckProgress15())
            {
                work->field_120 = 0;
                SetCurrentTaskMainEvent(HubControl::Main_2158A04);
            }
            else if (SaveGame__CheckProgress30())
            {
                work->field_120 = 0;
                SetCurrentTaskMainEvent(HubControl::Main_2158A04);
            }
            else
            {
                ViMap__SetType(0);
                HubHUD::ConfigureViewButton(TRUE, TRUE);
                HubHUD::ConfigureMenuButton(TRUE, TRUE);
                SetCurrentTaskMainEvent(HubControl::Main_21578CC);
            }
        }
    }

    if (area < DOCKAREA_COUNT)
    {
        ViMap__SetType(1);
        HubHUD::ConfigureViewButton(FALSE, TRUE);
        HubHUD::ConfigureMenuButton(FALSE, TRUE);

        PlayHubSfx(HUB_SFX_D_DECISION);

        work->nextAreaID = area;
        work->field_0 |= 0x10000;

        if (HubConfig__Func_2152960(area)->field_4 < 7)
        {
            ViDock__Func_215E658(work->field_11C);
            work->field_C = HubConfig__Func_2152960(area)->field_4;
            SetCurrentTaskMainEvent(HubControl::Main_2157C0C);
        }
        else
        {
            if (area == DOCKAREA_BEACH)
            {
                work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
                work->nextSelectionID = SAVE_PROGRESSTYPE_8;
            }
            else if (area == DOCKAREA_DRILL)
            {
                work->nextEvent       = HUBEVENT_START_TUTORIAL;
                work->nextSelectionID = 0;
            }
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
        }
    }

    HubControl::Func_2159740(work);
}

void HubControl::Main_21578CC()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    BOOL flag = FALSE;
    if (ViMap__GetMapIconDockArea(TRUE) < DOCKAREA_COUNT)
    {
        HubHUD::ConfigureViewButton(TRUE, TRUE);
        HubHUD::ConfigureMenuButton(TRUE, TRUE);
        if (HubHUD::LookAroundEnabled())
        {
            ViMap__SetType(1);
            SetCurrentTaskMainEvent(HubControl::Main_2157A94);
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            flag = TRUE;
        }
        else if (HubHUD::ShouldOpenMainMenu())
        {
            work->Func_2159758(1);
            PlayHubSfx(HUB_SFX_PAUSE);
            work->nextEvent       = HUBEVENT_MAIN_MENU;
            work->nextSelectionID = 0;
            ViMap__SetType(1);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
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
        s32 iconArea = ViMap__GetDockAreaFromMapIcon();
        if (iconArea < DOCKAREA_NONE)
        {
            ViMap__SetType(1);
            HubHUD::ConfigureViewButton(FALSE, TRUE);
            HubHUD::ConfigureMenuButton(FALSE, TRUE);

            PlayHubSfx(HUB_SFX_D_DECISION);
            work->nextAreaID = iconArea;
            work->field_0 |= 0x10000;

            if (HubConfig__Func_2152960(iconArea)->field_4 < 7)
            {
                work->field_C = HubConfig__Func_2152960(iconArea)->field_4;
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

                HubControl::Func_21598B4(work);
                SetCurrentTaskMainEvent(HubControl::Main_2158868);
            }
        }
    }

    HubControl::Func_2159740(work);
}

void HubControl::Main_2157A94()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    BOOL flag = FALSE;
    if (!HubHUD::LookAroundEnabled())
    {
        ViMap__SetType(0);
        SetCurrentTaskMainEvent(HubControl::Main_21578CC);
        flag = TRUE;
    }

    if (!flag)
    {
        s32 iconTouchArea = ViMap__GetMapIconDockAreaFromTouchPos();
        if (iconTouchArea < DOCKAREA_COUNT)
        {
            HubHUD::DisableLookAround();
            ViMap__SetType(0);
            ViMap__Func_215BCE4(iconTouchArea, TRUE);
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

        ViMap__Func_215BC40(&startX, &startY);

        if (HubHUD::GetTouchHeld())
        {
            s16 touchY;
            s16 touchX;

            HubHUD::GetTouchMove(&touchMoveX, &touchMoveY);
            HubHUD::GetTouchPos(&touchX, &touchY);
            ViMap__Func_215C878(touchX, touchY);
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
        ViMap__Func_215BBAC(startX, startY);
    }

    HubControl::Func_2159740(work);
}

void HubControl::Main_2157C0C()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_BLACK, 1) == 0)
    {
        CViHubAreaPreview::Func_2158C04(work);
        ViDock__Func_215DBC8(work->field_C);
        ViDock__Func_215DF64(0);
        ViMap__Func_215C84C(0);

        renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;
        work->field_0 |= 0x10000;

        SetCurrentTaskMainEvent(HubControl::Main2);
    }

    HubControl::Func_2159740(work);
}

void HubControl::Main2()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_DEFAULT, 1) == 0)
    {
        if (work->field_118)
        {
            work->field_120 = 0;
            work->field_138 = 0xFFFF;
            work->field_0 &= ~0x10000;
            SetCurrentTaskMainEvent(HubControl::Main_2158AB4);
        }
        else if (work->field_124)
        {
            work->field_124 = 0;
            ViDock__Func_215E104(5);
            ViDock__Func_215E178();
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_OPTIONS, 0);
            SetCurrentTaskMainEvent(HubControl::Main_2158160);
        }
        else if (work->field_128)
        {
            work->field_128 = 0;
            if (work->field_C == DOCKAREA_JET)
                ViDock__Func_215E104(12);

            ViDock__Func_215E178();
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_MOVIELIST, 0);
            SetCurrentTaskMainEvent(HubControl::Main_2158160);
        }
        else if (work->field_12C)
        {
            work->field_12C = 0;
            ViDock__Func_215E104(1);
            ViDock__Func_215E178();
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_MISSIONCLEARED, 0);
            SetCurrentTaskMainEvent(HubControl::Main_2158160);
        }
        else if (work->field_130)
        {
            ViDock__Func_215E104(0);
            ViDock__Func_215E178();
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            if (work->field_134)
                CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_GAMEOVER, 1);
            else
                CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_GAMEOVER, 0);
            SetCurrentTaskMainEvent(HubControl::Main_2158160);
            work->field_130 = 0;
            work->field_134 = 0;
        }
        else if (SaveGame__CheckProgressZone5OrZone6NotClear() && work->field_C == DOCKAREA_BASE)
        {
            SaveGame__UpdateProgressForZone5Zone6Cleared();
            HubControl::Func_21597A4(CUTSCENE_EARTHQUAKE, 8);
        }
        else
        {
            if (SaveGame__CheckProgressForShip(SHIP_BOAT - 1) && work->field_C == DOCKAREA_SHIP)
            {
                SaveGame__Func_205BC38(SHIP_BOAT - 1);
                HubControl::Func_21597A4(CUTSCENE_OCEAN_TORNADO_COMPLETE, 0);
            }
            else if (SaveGame__CheckProgressForShip(SHIP_HOVER - 1) && work->field_C == DOCKAREA_BOAT)
            {
                SaveGame__Func_205BC38(SHIP_HOVER - 1);
                HubControl::Func_21597A4(CUTSCENE_AQUA_BLAST_COMPLETE, 8);
            }
            else if (SaveGame__CheckProgressForShip(SHIP_SUBMARINE - 1) && work->field_C == DOCKAREA_SUBMARINE)
            {
                SaveGame__Func_205BC38(SHIP_SUBMARINE - 1);
                HubControl::Func_21597A4(CUTSCENE_DEEP_TYPHOON_COMPLETE, 8);
            }
            else
            {
                if (SaveGame__GetGameProgress() == SAVE_PROGRESS_37 && work->field_C == DOCKAREA_BASE)
                {
                    HubControl::Func_2159810();
                }
                else
                {
                    work->field_0 &= ~0x10000;
                    SetCurrentTaskMainEvent(HubControl::Main_2157F2C);
                }
            }
        }
    }

    HubControl::Func_2159740(work);
}

void HubControl::Main_2157F2C()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);
    ViDock__Func_215DF64(1);
    HubHUD::ConfigureMenuButton(TRUE, TRUE);
    SetCurrentTaskMainEvent(HubControl::Main_2157F64);
    HubControl::Func_2159740(work);
}

void HubControl::Main_2157F64()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (ViDock__Func_215DFA0())
    {
        ViDock__Func_215DF64(0);
        HubHUD::ConfigureMenuButton(FALSE, FALSE);
        work->field_0 |= 0x10000;
        SetCurrentTaskMainEvent(HubControl::Main_21587D8);
        PlayHubSfx(HUB_SFX_V_CHANGE);
    }
    else if (work->field_C != ViDock__Func_215DFE4())
    {
        ViDock__Func_215DF64(0);
        HubHUD::ConfigureMenuButton(FALSE, FALSE);
        work->field_0 |= 0x10000;
        SetCurrentTaskMainEvent(HubControl::Main_21580C0);
        PlayHubSfx(HUB_SFX_V_CHANGE);
    }
    else
    {
        if (ViDock__Func_215E000())
        {
            s32 id;
            s32 param;
            ViDock__Func_215E02C(&id, &param);

            if (id == CVIDOCKNPCTALK_NPC || id == CVIDOCKNPCTALK_ACTION)
                PlayHubSfx(HUB_SFX_V_DECIDE);

            ViDock__Func_215E178();
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            CViDockNpcTalk::CreateTalk(id, param);
            SetCurrentTaskMainEvent(HubControl::Main_2158160);
        }
        else if (HubHUD::ShouldOpenMainMenu())
        {
            work->Func_2159758(0);
            PlayHubSfx(HUB_SFX_PAUSE);
            ViDock__Func_215DF64(0);
            work->nextEvent       = HUBEVENT_MAIN_MENU;
            work->nextSelectionID = 0;
            HubHUD::ConfigureMenuButton(FALSE, TRUE);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
        }
    }

    HubControl::Func_2159740(work);
}

void HubControl::Main_21580C0()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_DEFAULT, 1) == 0)
    {
        s32 area = ViDock__Func_215DFE4();
        ViDock__Func_215DC80(area, work->field_C);
        work->field_C = area;
        SetCurrentTaskMainEvent(HubControl::Main_2158108);
    }
}

void HubControl::Main_2158108()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (ViDock__Func_215DD00())
    {
        u32 area = HubConfig__GetDockStageConfig(work->field_C)->nextArea;
        if (area != work->nextAreaID)
        {
            work->nextAreaID = area;
            ViMap__Func_215BCE4(area, TRUE);
        }

        ViDock__Func_215DD2C();
        SetCurrentTaskMainEvent(HubControl::Main2);
    }
}

void HubControl::Main_2158160()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    switch (CViDockNpcTalk::GetTalkAction())
    {
        case CVIDOCKNPCTALK_ACTION_0:
            ViDock__Func_215E410();
            SetCurrentTaskMainEvent(HubControl::Main_2157F2C);
            break;

        case CVIDOCKNPCTALK_ACTION_1:
            work->Func_2159758(0);
            HubControl::Func_215A2E0(work->field_C, 0);
            work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
            work->nextSelectionID = SAVE_PROGRESSTYPE_1;
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
            break;

        case CVIDOCKNPCTALK_ACTION_2:
            work->Func_2159758(0);
            HubControl::Func_215A2E0(work->field_C, 1);
            work->nextEvent       = HUBEVENT_SAILING;
            work->nextSelectionID = CViDockNpcTalk::GetSelection();
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
            break;

        case CVIDOCKNPCTALK_ACTION_3:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_PURCHASE, CViTalkPurchase::PURCHASE_CONSTRUCTION);
            break;

        case CVIDOCKNPCTALK_ACTION_4:
            work->shipConstructID = CViDockNpcTalk::GetSelection();
            if (work->shipConstructID == CViMap::CONSTRUCT_SHIP_JET)
                CViTalkPurchase::MakeTutorialPurchase();

            work->field_28 = ViDock__GetTalkingNpc();
            work->field_8  = work->field_4;
            SetCurrentTaskMainEvent(HubControl::Func_2158D28);
            FadeOutHubBGM(12);
            ViDock__Func_215DF64(0);
            break;

        case CVIDOCKNPCTALK_ACTION_5:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_PURCHASE, CViTalkPurchase::PURCHASE_DECORATION);
            break;

        case CVIDOCKNPCTALK_ACTION_6:
            work->decorConstructID = CViDockNpcTalk::GetSelection();
            work->field_28         = ViDock__GetTalkingNpc();
            work->field_8          = work->field_4;
            SetCurrentTaskMainEvent(HubControl::Func_2158D28);
            ViDock__Func_215DF64(0);
            work->Func_2159758(0);
            break;

        case CVIDOCKNPCTALK_ACTION_7:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_ANNOUNCE, CViDockNpcTalk::GetSelection());
            break;

        case CVIDOCKNPCTALK_ACTION_8:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_MISSIONLIST, 0);
            break;

        case CVIDOCKNPCTALK_ACTION_9:
            work->Func_2159758(0);
            work->nextEvent       = HUBEVENT_START_MISSION;
            work->nextSelectionID = CViDockNpcTalk::GetSelection();
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
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
                    work->field_28         = ViDock__GetTalkingNpc();
                    work->field_8          = work->field_4;
                    SetCurrentTaskMainEvent(HubControl::Func_2158D28);
                    ViDock__Func_215DF64(0);
                    work->Func_2159758(0);
                }
                else
                {
                    MissionHelpers__CompleteMission(selection);
                    ViDock__Func_215E410();
                    SetCurrentTaskMainEvent(HubControl::Main_2157F2C);
                }
            }
            else
            {
                MissionHelpers__HandleCompletedMuzyMissions();
                ViDock__Func_215E410();
                SetCurrentTaskMainEvent(HubControl::Main_2157F2C);
            }
            break;

        case CVIDOCKNPCTALK_ACTION_12:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_OPTIONS, 0);
            break;

        case CVIDOCKNPCTALK_ACTION_13:
            work->Func_2159758(0);
            work->nextEvent       = HUBEVENT_PLAYER_NAME_MENU;
            work->nextSelectionID = 0;
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
            break;

        case CVIDOCKNPCTALK_ACTION_14:
            work->Func_2159758(0);
            work->nextEvent       = HUBEVENT_DELETE_SAVE_MENU;
            work->nextSelectionID = 0;
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
            break;

        case CVIDOCKNPCTALK_ACTION_15:
            work->Func_2159758(0);
            work->nextEvent       = HUBEVENT_VS_MAIN_MENU;
            work->nextSelectionID = 0;
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
            break;

        case CVIDOCKNPCTALK_ACTION_16:
            work->Func_2159758(0);
            work->nextEvent       = HUBEVENT_STAGE_SELECT;
            work->nextSelectionID = 0;
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
            break;

        case CVIDOCKNPCTALK_ACTION_17:
            work->field_114 = 1;
            ViDock__Func_215E410();
            work->field_0 |= 0x10000;
            SetCurrentTaskMainEvent(HubControl::Main_21587D8);
            PlayHubSfx(HUB_SFX_V_CHANGE);
            break;

        case CVIDOCKNPCTALK_ACTION_18:
            work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
            work->nextSelectionID = SAVE_PROGRESSTYPE_0;
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
            break;

        case CVIDOCKNPCTALK_ACTION_19:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_MOVIELIST, 0);
            break;

        case CVIDOCKNPCTALK_ACTION_20:
            work->Func_2159758(0);
            work->nextEvent       = HUBEVENT_CUTSCENE_1;
            work->nextSelectionID = CViDockNpcTalk::GetSelection();
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
            break;

        case CVIDOCKNPCTALK_ACTION_21:
            work->Func_2159758(0);
            work->nextEvent       = HUBEVENT_CUTSCENE_2;
            work->nextSelectionID = CViDockNpcTalk::GetSelection();
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
            break;

        case CVIDOCKNPCTALK_ACTION_22:
            if (SaveGame__GetProgressFlags_0x100000(0) || SaveGame__HasDoorPuzzlePiece(0))
                CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_NPC, 38);
            else
                CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_PURCHASE, CViTalkPurchase::PURCHASE_INFO);
            break;

        case CVIDOCKNPCTALK_ACTION_23:
            work->Func_2159758(0);
            work->nextEvent       = HUBEVENT_SOUND_TEST;
            work->nextSelectionID = 0;
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
            break;

        case CVIDOCKNPCTALK_ACTION_24:
        case CVIDOCKNPCTALK_ACTION_25:
            work->Func_2159758(0);
            work->nextEvent       = HUBEVENT_VIKING_CUP;
            work->nextSelectionID = 0;
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
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

            ViDock__Func_215E410();
            SetCurrentTaskMainEvent(HubControl::Main_2157F2C);
            break;

        case CVIDOCKNPCTALK_ACTION_27:
            work->Func_2159758(0);
            work->nextEvent       = HUBEVENT_LOAD_STAGE;
            work->nextSelectionID = 0;
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
            break;

        case CVIDOCKNPCTALK_ACTION_28:
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_PURCHASE, CViTalkPurchase::PURCHASE_SHIP_UPGRADE);
            break;

        case CVIDOCKNPCTALK_ACTION_29:
            work->shipUpgradeID = CViDockNpcTalk::GetSelection();
            work->field_28      = ViDock__GetTalkingNpc();
            work->field_8       = work->field_4;
            SetCurrentTaskMainEvent(HubControl::Func_2158D28);
            FadeOutHubBGM(12);
            ViDock__Func_215DF64(0);
            break;

        case CVIDOCKNPCTALK_ACTION_30:
            work->nextEvent       = HUBEVENT_CORRUPT_SAVE_WARNING;
            work->nextSelectionID = 0;
            ViDock__Func_215DF64(0);
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
            break;

        case CVIDOCKNPCTALK_ACTION_32:
            break;

        default:
            ViDock__Func_215E410();
            SetCurrentTaskMainEvent(HubControl::Main_2157F2C);
            break;
    }

    FontWindow__PrepareSwapBuffer(&work->fontWindow);
    HubControl::Func_2159740(work);
}

void HubControl::Main_21587D8()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_BLACK, 1) == 0)
    {
        work->field_10 = HubConfig__Func_2152960(work->nextAreaID)->field_8;
        ViDock__Func_215DD64(work->field_10, 0);
        work->nextAreaID2 = work->nextAreaID;
        CViHubAreaPreview::Create(work);
        ViMap__Func_215C84C(TRUE);
        work->field_0 |= 0x10000;
        SetCurrentTaskMainEvent(HubControl::Main1);
        renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;
    }

    HubControl::Func_2159740(work);
}

void HubControl::Main_2158868()
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

        HubControl::Func_215A400(event, selection);
    }
    else
    {
        HubControl::Func_2159740(work);
    }
}

void HubControl::Main_21588D4()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    work->field_120++;
    if (work->field_120 >= 64)
    {
        ViMap__Func_215BCE4(work->field_114, TRUE);
        SetCurrentTaskMainEvent(HubControl::Main_2158918);
    }

    HubControl::Func_2159740(work);
}

void HubControl::Main_2158918()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (work->field_114 == ViMap__GetMapIconDockArea(TRUE))
    {
        work->field_120 = 0;
        SetCurrentTaskMainEvent(HubControl::Main_2158958);
    }

    HubControl::Func_2159740(work);
}

void HubControl::Main_2158958()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    work->field_120++;
    if (work->field_120 >= 64)
    {
        if (work->field_114 == 0)
        {
            HubControl::IncrementGameProgress();
            work->field_11C = 1;
        }
        else if (work->field_114 == 1)
        {
            work->field_11C = 1;
            work->field_118 = 1;
        }
        else if (work->field_114 == 7)
        {
            work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
            work->nextSelectionID = SAVE_PROGRESSTYPE_0;
            work->field_0 |= 0x10000;
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
            return;
        }

        work->field_0 |= 0x10000;
        SetCurrentTaskMainEvent(HubControl::Main1);
    }

    HubControl::Func_2159740(work);
}

void HubControl::Main_2158A04()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    work->field_120++;
    if (work->field_120 >= 64)
    {
        if (SaveGame__CheckProgress30())
        {
            SaveGame__UpdateProgressForAllDoorPuzzleKeysCollected();
            work->Func_2159758(1);
            work->nextEvent       = HUBEVENT_CUTSCENE_2;
            work->nextSelectionID = CUTSCENE_CRUEL_TO_BE_KIND;
            work->field_0 |= 0x10000;
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
        }
        else if (SaveGame__CheckProgress15())
        {
            work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
            work->nextSelectionID = SAVE_PROGRESSTYPE_0;
            work->field_0 |= 0x10000;
            HubControl::Func_21598B4(work);
            SetCurrentTaskMainEvent(HubControl::Main_2158868);
        }
    }

    HubControl::Func_2159740(work);
}

void HubControl::Main_2158AB4()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    work->field_120++;
    if (work->field_120 >= 64)
    {
        if (work->field_138 == 0xFFFE)
        {
            work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
            work->nextSelectionID = SAVE_PROGRESSTYPE_8;
        }
        else if (work->field_138 == 0xFFFF)
        {
            work->nextEvent       = HUBEVENT_UPDATE_PROGRESS;
            work->nextSelectionID = SAVE_PROGRESSTYPE_0;
        }
        else
        {
            work->nextEvent       = HUBEVENT_CUTSCENE_2;
            work->nextSelectionID = work->field_138;
        }

        work->field_0 |= 0x10000;

        HubControl::Func_21598B4(work);
        SetCurrentTaskMainEvent(HubControl::Main_2158868);
    }

    HubControl::Func_2159740(work);
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
    CViHubAreaPreview::Func_2158C04(parent);

    parent->hubAreaPreview =
        TaskCreateNoWork(CViHubAreaPreview::Main, CViHubAreaPreview::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1051, TASK_GROUP(16), "CViHubAreaPreview");

    parent->Func_215993C();
    parent->Func_2159D84(parent->nextAreaID);
}

void CViHubAreaPreview::Func_2158C04(HubControl *parent)
{
    if (parent->hubAreaPreview != NULL)
    {
        if (!ViDock__Func_215E4A0())
        {
            ViDock__Func_215DEF4();
            parent->nextAreaID2 = DOCKAREA_INVALID;
        }

        DestroyTask(parent->hubAreaPreview);
        parent->hubAreaPreview = NULL;
    }
}

void CViHubAreaPreview::Main()
{
    HubControl *hubControl = TaskGetWork(hubControlTaskSingleton, HubControl);

    s32 area = ViMap__GetMapIconDockArea(FALSE);
    if (area != hubControl->nextAreaID2)
    {
        if (hubControl->Func_2159D14())
        {
            hubControl->Func_2159D84(area);

            if (area == DOCKAREA_DRILL)
            {
                hubControl->nextAreaID2 = area;
                ViDock__Func_215DEF4();
            }
            else
            {
                hubControl->field_10 = HubConfig__Func_2152960(area)->field_8;

                if (hubControl->field_10 < 8)
                {
                    hubControl->nextAreaID2 = area;
                    ViDock__Func_215DD64(hubControl->field_10, 1);
                }
                else
                {
                    hubControl->nextAreaID2 = DOCKAREA_INVALID;
                    ViDock__Func_215DEF4();
                }
            }
        }
    }
    else
    {
        if (hubControl->nextAreaID2 == DOCKAREA_DRILL || ViDock__Func_215E4A0())
            hubControl->Func_2159D4C();
    }

    hubControl->Func_215A014();
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
        ViMap__SetType(2);

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

        ViDock__Func_215DEF4();
        work->nextAreaID2 = DOCKAREA_INVALID;
        HubControl::InitEngineAForCutscene();
        work->field_110 = 0;
        work->field_8   = work->field_4;
        SetCurrentTaskMainEvent(HubControl::Func_2158E14);
    }

    HubControl::Func_2159740(work);
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

    if (work->field_8 - work->field_4 >= 30)
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
            work->field_8   = work->field_4;
            SetCurrentTaskMainEvent(HubControl::Func_2159084);
        }
        else
        {
            ViMap__Func_215C408();
            SetCurrentTaskMainEvent(HubControl::Func_2158F28);
        }
    }

    HubControl::Func_2159740(work);
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

    HubControl::Func_2159740(work);
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
                u16 value = HubConfig__Func_2152960(HubConfig__GetDockMapConfig(work->shipConstructID)->unknownArea)->field_3C;
                ViMap__Func_215C524(value);
                ViMap__Func_215C638(value);
                HubControl::InitEngineAForUnknown();
                ViDock__Func_215DE40(work->shipConstructID);
            }
            else
            {
                const Unknown2171FE8 *config = HubConfig__Func_2152960(HubConfig__GetDockMapUnknownConfig(work->shipUpgradeID)->unknownArea);
                ViMap__Func_215C76C(config->field_3C);
            }

            work->field_8 = work->field_4;
            SetCurrentTaskMainEvent(HubControl::Func_2159104);
        }
    }

    HubControl::Func_2159740(work);
}

void HubControl::Func_2159084()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (work->field_4 - work->field_8 >= 60 && HubControl::HandleFade(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_WHITE, 1) == 0)
    {
        if (work->field_10C)
        {
            ViMap__Func_215C58C(work->decorConstructID);
            ViMap__Func_215C6AC();

            work->field_8 = work->field_4;
            SetCurrentTaskMainEvent(HubControl::Func_2159104);
        }
        else
        {
            work->field_10C = 1;
        }
    }

    HubControl::Func_2159740(work);
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
    timer = work->field_4 - work->field_8;

    s16 fadeTargetB = RENDERCORE_BRIGHTNESS_DEFAULT;
    if (timer > 60 && HubControl::HandleFade(fadeTargetA, fadeTargetB, 1) == 0)
    {
        if (timer > duration1)
        {
            if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT)
                ViDock__Func_215DF84();

            if (timer > duration2)
            {
                if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT)
                    FadeSysTrack(12);

                work->field_8 = work->field_4;
                SetCurrentTaskMainEvent(HubControl::Func_21591A8);
            }
        }
    }

    HubControl::Func_2159740(work);
}

void HubControl::Func_21591A8()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    if (work->shipConstructID < CViMap::CONSTRUCT_SHIP_COUNT)
        ViDock__Func_215DF84();

    if (HubControl::HandleFade(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_BLACK, 1) == 0)
    {
        ViMap__Func_215C7E0();
        ViMap__SetType(1);

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
            work->nextAreaID  = DOCKAREA_BASE;
            work->nextAreaID2 = DOCKAREA_BASE;
            work->field_C     = DOCKAREA_BASE;
            ViMap__Func_215C82C();
            ViMap__Func_215BCE4(work->nextAreaID, 0);
            ViDock__Func_215DBC8(work->field_C);
        }
        else
        {
            ViMap__Func_215C82C();
            ViMap__Func_215BCE4(work->nextAreaID, 0);
            ViDock__Func_215DBC8(work->field_C);
            ViDock__Func_215E578(1);
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

        work->field_8 = work->field_4;
        SetCurrentTaskMainEvent(HubControl::Func_21592E0);
    }

    HubControl::Func_2159740(work);
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

            ViDock__Func_215E104(work->field_28);
            ViDock__Func_215E178();
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_NPC, i);
            SetCurrentTaskMainEvent(HubControl::Main_2158160);
        }
        else if (work->decorConstructID < CViMap::CONSTRUCT_DECOR_COUNT)
        {
            ViDock__Func_215E104(work->field_28);
            ViDock__Func_215E178();
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_NPC, work->decorConstructID + 8);
            SetCurrentTaskMainEvent(HubControl::Main_2158160);
        }
        else if (work->shipUpgradeID < CViMap::UPGRADE_SHIP_COUNT)
        {
            u16 ship;
            u16 level;
            SaveGame__GetNextShipUpgrade(&ship, &level);

            ViDock__Func_215E104(work->field_28);
            ViDock__Func_215E178();
            CViDockNpcTalk::CreateTalk(CVIDOCKNPCTALK_NPC, level + 29 + 2 * ship);
            SetCurrentTaskMainEvent(HubControl::Main_2158160);
        }

        work->shipConstructID  = CViMap::CONSTRUCT_SHIP_INVALID;
        work->decorConstructID = CViMap::CONSTRUCT_DECOR_INVALID;
        work->shipUpgradeID    = CViMap::UPGRADE_SHIP_INVALID;
    }

    HubControl::Func_2159740(work);
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

void HubControl::Func_2159740(HubControl *work)
{
    work->flags = 0;
    work->field_4++;
}

void HubControl::Func_2159758(s32 a2)
{
    ResetHubState();

    if (a2)
    {
        HubState__SetHubType(0);
        HubState__SetHubArea(this->nextAreaID);
    }
    else
    {
        HubState__SetHubType(1);
        HubState__SetHubArea(this->field_C);
        ViDock__Func_215E4DC();
    }
}

void HubControl::Func_21597A4(s16 a1, s32 a2)
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    ResetHubState();
    HubState__SetHubType(1);

    if (a2 < DOCKAREA_DRILL)
        HubState__SetHubArea(a2);
    else
        HubState__SetHubArea(work->field_C);

    work->field_120 = 0;
    work->field_138 = a1;
    work->field_0 &= ~0x10000;

    SetCurrentTaskMainEvent(HubControl::Main_2158AB4);
}

void HubControl::Func_2159810()
{
    HubControl *work = TaskGetWorkCurrent(HubControl);

    ResetHubState();

    work->field_120 = 0;
    work->field_138 = 0xFFFE;
    work->field_0 &= ~0x10000;

    SetCurrentTaskMainEvent(HubControl::Main_2158AB4);
}

BOOL HubControl::Func_2159854(s32 event)
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

void HubControl::Func_21598B4(HubControl *work)
{
    if (HubControl::Func_2159854(work->nextEvent))
        FadeSysTrack(8);
}

void HubControl::ClearAnimators()
{
    this->curAreaID = DOCKAREA_INVALID;
    this->npcCount  = 0;
    this->field_140 = 0;
    this->field_142 = 0;

    MI_CpuClear16(this->aniNpcIcon, sizeof(this->aniNpcIcon));
    MI_CpuClear16(&this->aniNpcBackground, sizeof(this->aniNpcBackground));
    MI_CpuClear16(this->aniOptionsIcon, sizeof(this->aniOptionsIcon));
    MI_CpuClear16(this->aniOptionsName, sizeof(this->aniOptionsName));
}

void HubControl::Func_215993C()
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
    for (i = 0; i < 5;)
    {
        AnimatorSprite__Init(aniNpcIcon, sprDockHUD, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, size),
                             PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, i);

        i++;
        aniNpcIcon->cParam.palette = i;

        aniNpcIcon++;
    }

    size                           = Sprite__GetSpriteSize1(sprDockHUD);
    AnimatorSprite *aniOptionsIcon = &this->aniOptionsIcon[0];
    for (i = 0; i < 2; i++)
    {
        AnimatorSprite__Init(aniOptionsIcon, sprDockHUD, i + 12, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, size),
                             PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        aniOptionsIcon->cParam.palette = i + PALETTE_ROW_6;

        aniOptionsIcon++;
    }

    size                           = Sprite__GetSpriteSize1(sprDockHUDLoc);
    AnimatorSprite *aniOptionsName = &this->aniOptionsName[0];
    for (i = 0; i < 3; i++)
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

BOOL HubControl::Func_2159D14()
{
    if (this->field_142 < 16)
    {
        this->field_142 += 2;
        if (this->field_142 > 16)
            this->field_142 = 16;

        return FALSE;
    }

    return TRUE;
}

BOOL HubControl::Func_2159D4C()
{
    if (this->field_142 > 0)
    {
        this->field_142 -= 2;
        if (this->field_142 < 0)
            this->field_142 = 0;

        return FALSE;
    }

    return TRUE;
}

void HubControl::Func_2159D84(s32 area)
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
                if (HubControl::Func_215B850(npcID))
                {
                    if (HubControl::Func_215B858(npcID))
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

void HubControl::Func_215A014()
{
    AnimatorSprite *aniNpcName;
    AnimatorSprite *aniNpcIcon;
    AnimatorSprite *aniNpcBackground;
    s32 i;
    s16 x;
    s16 y;

    MI_CpuClear16(&renderCoreGFXControlA.blendManager, sizeof(renderCoreGFXControlA.blendManager));

    if (this->field_142 != 0)
    {
        renderCoreGFXControlA.blendManager.coefficient.value5      = this->field_142;
        renderCoreGFXControlA.blendManager.blendControl.effect     = BLENDTYPE_FADEOUT;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG0 = TRUE;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG1 = TRUE;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG3 = TRUE;

        ((u16 *)VRAM_BG_PLTT)[0] = GX_RGB_888(0x00, 0x00, 0x00);
    }

    y                = 3 * this->field_142;
    aniNpcBackground = &this->aniNpcBackground;
    AnimatorSprite__ProcessAnimationFast(aniNpcBackground);

    x = HW_LCD_WIDTH - 40 * this->npcCount;

    for (i = 0; i < this->npcCount; i++)
    {
        aniNpcIcon = &this->aniNpcIcon[i];

        aniNpcIcon->pos.x = x;
        aniNpcIcon->pos.y = y + 152;
        AnimatorSprite__ProcessAnimationFast(aniNpcIcon);
        AnimatorSprite__DrawFrame(aniNpcIcon);

        aniNpcBackground->pos.x = aniNpcIcon->pos.x;
        aniNpcBackground->pos.y = aniNpcIcon->pos.y;
        AnimatorSprite__DrawFrame(aniNpcBackground);

        if (y == 0 && aniNpcIcon->animID == 1)
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
        aniNpcIcon->pos.y = 4 - y;
        AnimatorSprite__ProcessAnimationFast(aniNpcIcon);
        AnimatorSprite__DrawFrame(aniNpcIcon);

        aniNpcBackground->pos.x = aniNpcIcon->pos.x;
        aniNpcBackground->pos.y = aniNpcIcon->pos.y;
        AnimatorSprite__DrawFrame(aniNpcBackground);

        if (y == 0)
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
            aniNpcIcon->pos.y = 4 - y;
            AnimatorSprite__ProcessAnimationFast(aniNpcIcon);
            AnimatorSprite__DrawFrame(aniNpcIcon);
            aniNpcBackground->pos.x = aniNpcIcon->pos.x;
            aniNpcBackground->pos.y = aniNpcIcon->pos.y;
            AnimatorSprite__DrawFrame(aniNpcBackground);

            if (y == 0)
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

void HubControl::Func_215A400(s32 eventID, s32 selection)
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
