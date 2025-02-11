#include <hub/cviTalkMissionList.hpp>
#include <hub/hubControl.hpp>
#include <hub/hubAudio.h>
#include <hub/hubConfig.h>
#include <hub/missionConfig.h>
#include <hub/cviDockNpcTalk.hpp>
#include <hub/cviDock.hpp>
#include <game/save/saveGame.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/file/fileUnknown.h>
#include <game/graphics/unknown2056570.h>
#include <game/text/mpc.h>

// resources
#include <resources/bb/vi_msg/vi_msg_eng.h>
#include <resources/narc/vi_msg_ctrl_lz7.h>
#include <resources/narc/vi_act_lz7.h>
#include <resources/bb/vi_act_loc/vi_act_loc_eng.h>
#include <resources/narc/vi_bg_lz7.h>

// --------------------
// CONSTANTS/MACROS
// --------------------

#define CVITALKMISSIONLIST_ID_INVALID -1

// --------------------
// ENUMS
// --------------------

// ev_mission file is formatted as 100 sets of these 3 sequences
enum MissionListSequence
{
    MISSIONLIST_SEQ_NAME,
    MISSIONLIST_SEQ_CLIENT,
    MISSIONLIST_SEQ_DESCRIPTION,

    MISSIONLIST_SEQ_COUNT,
};

// --------------------
// FUNCTIONS
// --------------------

void CViTalkMissionList::Create(s32 param)
{
    Task *task =
        HubTaskCreate(CViTalkMissionList::Main_Init, CViTalkMissionList::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(16), CViTalkMissionList);

    CViTalkMissionList *work = TaskGetWork(task, CViTalkMissionList);

    InitThreadWorker(&work->thread, 0x800);
    CreateThreadWorker(&work->thread, CViTalkMissionList::ThreadFunc_Load, work, 20);
}

void CViTalkMissionList::ThreadFunc_Load(void *arg)
{
    CViTalkMissionList *work = (CViTalkMissionList *)arg;

    work->mpcFile = FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsg(), ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_MISSION_MPC);

    work->missionCount = FX_DivS32(MPC__GetSequenceCount(work->mpcFile), MISSIONLIST_SEQ_COUNT);
    work->missionCount--;

    work->selection = 0;
    work->missionSelected = FALSE;
    work->lastMissionSelected = FALSE;

    work->InitDisplay();
    work->InitSprites();
    work->InitList();
}

void CViTalkMissionList::InitDisplay()
{
    HubControl::Func_215A888();
    HubControl::Func_215A9D8();

    CViTalkMissionList::InitWindow(FALSE, 0);
}

void CViTalkMissionList::InitSprites()
{
    this->lastDrawnMissionNum = CVITALKMISSIONLIST_ID_INVALID;
    this->missionID           = CVITALKMISSIONLIST_ID_INVALID;
    this->nextMissionID       = CVITALKMISSIONLIST_ID_INVALID;
    this->isWindowOpen        = FALSE;

    FontWindowAnimator__Init(&this->fontWindowAnimator);
    FontWindowAnimator__Load2(&this->fontWindowAnimator, HubControl::GetField54(), 0, 0, 2, 3, 2, 26, 21, GRAPHICS_ENGINE_B, 1, 15, 0);

    FontAnimator__Init(&this->fontAnimator);
    s32 fontSize = (u16)(FontAnimator__LoadFont1(&this->fontAnimator, HubControl::GetField54(), 0, 5, 5, 22, 12, GRAPHICS_ENGINE_B, BACKGROUND_3, 0, 128) + 128);

    FontAnimator__LoadMPCFile(&this->fontAnimator, this->mpcFile);

    this->missionNumberPixels = HeapAllocHead(HEAP_USER, 0x20 * 3);
    Unknown2056570__Init(&this->unknown, GRAPHICS_ENGINE_B, BACKGROUND_3, 0, 5, 3, 3, 1, this->missionNumberPixels, 0, fontSize * 32);
    Unknown2056570__Func_2056688(&this->unknown, 1);
    Unknown2056570__Func_205683C(&this->unknown);

    MIi_CpuCopy16(GetBackgroundPalette(HubControl::GetFileFrom_ViBG(ARCHIVE_VI_BG_LZ7_FILE_VI_MS_NUMBER_BBG))->data, (u8 *)VRAM_DB_BG_PLTT + 0x20, 16 * sizeof(GXRgb));

    void *sprMapHUD    = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_VI_FIX_BAC);
    void *sprMapLocHUD = HubControl::GetFileFrom_ViActLoc(ARCHIVE_VI_ACT_LOC_ENG_FILE_VI_FIX_LOC_BAC);
    void *sprDockHUD   = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_VI_DOCK_UP_BAC);
    void *sprName      = HubControl::GetTKDMNameSprite();

    VRAMPaletteKey vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, Sprite__GetSpriteSize3FromAnim(sprMapLocHUD, 4));
    AnimatorSprite__Init(&this->aniMissionStatus, sprMapLocHUD, 4, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT,
                         SPRITE_PRIORITY_1, SPRITE_ORDER_6);
    this->aniMissionStatus.cParam.palette = PALETTE_ROW_12;

    vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, Sprite__GetSpriteSize3FromAnim(sprMapHUD, 4));
    AnimatorSprite__Init(&this->aniMissionNumBackdrop, sprMapHUD, 4, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT,
                         SPRITE_PRIORITY_1, SPRITE_ORDER_8);
    this->aniMissionNumBackdrop.cParam.palette = PALETTE_ROW_13;

    vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, Sprite__GetSpriteSize3FromAnim(sprMapHUD, 5));
    AnimatorSprite__Init(&this->aniMissionStatusBackdrop, sprMapHUD, 5, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT,
                         SPRITE_PRIORITY_1, SPRITE_ORDER_8);
    this->aniMissionStatusBackdrop.cParam.palette = PALETTE_ROW_13;

    vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, Sprite__GetSpriteSize3(sprName));
    AnimatorSprite__Init(&this->aniCharacterName, sprName, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT,
                         SPRITE_PRIORITY_1, SPRITE_ORDER_6);
    this->aniCharacterName.cParam.palette = PALETTE_ROW_14;

    vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, Sprite__GetSpriteSize3(sprDockHUD));
    AnimatorSprite__Init(&this->aniCharacterCircle, sprDockHUD, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT,
                         SPRITE_PRIORITY_1, SPRITE_ORDER_6);
    this->aniCharacterCircle.cParam.palette = PALETTE_ROW_15;

    vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, Sprite__GetSpriteSize3FromAnim(sprDockHUD, 0));
    AnimatorSprite__Init(&this->aniCharacterPortrait, sprDockHUD, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT,
                         SPRITE_PRIORITY_1, SPRITE_ORDER_7);
    this->aniCharacterPortrait.cParam.palette = PALETTE_ROW_1;
}

void CViTalkMissionList::InitList()
{
    this->missionList = (NpcTalkListEntry *)HeapAllocHead(HEAP_SYSTEM, 4 * this->missionCount);

    for (s32 i = 0; i < this->missionCount; i++)
    {
        NpcTalkListEntry *entry = &this->missionList[i];

        u16 missionID = MissionHelpers__GetMissionFromSelection(i);

        entry->flags = 0;
        if (MissionHelpers__CheckMissionUnlocked(missionID))
        {
            entry->flags |= 1;
            entry->id = MISSIONLIST_SEQ_COUNT * i;
        }
        else
        {
            entry->id = MISSIONLIST_SEQ_COUNT * this->missionCount;
        }

        if (MissionHelpers__CheckMissionAttempted(missionID) == TRUE)
        {
            entry->flags |= 2;
        }

        if (MissionHelpers__CheckMissionBeaten(missionID) == TRUE)
        {
            entry->flags |= 4;
        }
    }

    ViTalkListConfig config;
    config.fontWindow      = HubControl::GetField54();
    config.mpcFile         = this->mpcFile;
    config.entryList       = this->missionList;
    config.entryCount      = this->missionCount;
    config.selection       = 0;
    config.field_22        = 3;
    config.vi_fix_loc      = HubControl::GetFileFrom_ViActLoc(ARCHIVE_VI_ACT_LOC_ENG_FILE_VI_FIX_LOC_BAC);
    config.vi_menu         = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_VI_MENU_BAC);
    config.vi_ms_ret       = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_VI_MS_RET_BAC);
    config.nl_cursor_ikari = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_NL_CURSOR_IKARI_BAC);
    config.headerAnim      = 5;
    config.windowSizeX     = 0;
    config.windowSizeY     = 4;
    config.field_28        = 2;

    NpcUnknown__Func_216EDCC(&this->npcTalk);
    NpcUnknown__Func_216EDF8(&this->npcTalk, &config);
}

void CViTalkMissionList::Release()
{
    this->StopThreadWorker();

    ReleaseThreadWorker(&this->thread);

    this->ReleaseList();
    this->ReleaseGraphics();
    this->ResetDisplay();
}

void CViTalkMissionList::ResetDisplay()
{
    HubControl::Func_215A96C();
    HubControl::Func_215AB84();

    CViTalkMissionList::InitWindow(FALSE, 0);
}

void CViTalkMissionList::ReleaseGraphics()
{
    AnimatorSprite__Release(&this->aniCharacterPortrait);
    AnimatorSprite__Release(&this->aniCharacterCircle);
    AnimatorSprite__Release(&this->aniCharacterName);
    AnimatorSprite__Release(&this->aniMissionStatusBackdrop);
    AnimatorSprite__Release(&this->aniMissionNumBackdrop);
    AnimatorSprite__Release(&this->aniMissionStatus);

    Unknown2056570__Func_2056670(&this->unknown);

    HeapFree(HEAP_USER, this->missionNumberPixels);

    FontAnimator__Release(&this->fontAnimator);
    FontWindowAnimator__Release(&this->fontWindowAnimator);
}

void CViTalkMissionList::ReleaseList()
{
    NpcUnknown__Func_216EE98(&this->npcTalk);

    if (this->missionList != NULL)
    {
        HeapFree(HEAP_SYSTEM, this->missionList);
        this->missionList = NULL;
    }
}

void CViTalkMissionList::Main_Init(void)
{
    CViTalkMissionList *work = TaskGetWorkCurrent(CViTalkMissionList);

    if (IsThreadWorkerFinished(&work->thread))
    {
        work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_MS_MCF), 0, CVIEVTCMN_RESOURCE_NONE);
        work->viEvtCmnTalk.SetPage(0);

        SetCurrentTaskMainEvent(CViTalkMissionList::Main_ShowMissionSelectPrompt);
    }
}

void CViTalkMissionList::Main_ShowMissionSelectPrompt(void)
{
    CViTalkMissionList *work = TaskGetWorkCurrent(CViTalkMissionList);

    work->viEvtCmnTalk.ProcessDialog();
    if (work->viEvtCmnTalk.IsFinished())
    {
        work->viEvtCmnTalk.Release();

        CViTalkMissionList::SetMissionListWindowVisible(FALSE);
        CViTalkMissionList::SetMissionUnknownVisible(FALSE);
        CViTalkMissionList::SetMissionListVisible(FALSE);
        CViTalkMissionList::SetMissionDescriptionVisible(FALSE);

        NpcUnknown__Func_216EEC0(&work->npcTalk, 0, 1);

        work->DrawUpperMissionNumber(work->selection);

        FontWindowAnimator__Func_20599B4(&work->fontWindowAnimator);
        FontAnimator__LoadMappingsFunc(&work->fontAnimator);
        FontAnimator__LoadPaletteFunc(&work->fontAnimator);

        SetCurrentTaskMainEvent(CViTalkMissionList::Main_OpeningMissionList);
    }
}

void CViTalkMissionList::Main_OpeningMissionList(void)
{
    CViTalkMissionList *work = TaskGetWorkCurrent(CViTalkMissionList);

    NpcUnknown__Func_216EF50(&work->npcTalk);
    work->selection = NpcUnknown__Func_216EF70(&work->npcTalk);

    work->DrawUpperMissionNumber(work->selection);
    work->Draw();

    if (NpcUnknown__Func_216EF80(&work->npcTalk))
    {
        ViDock__Func_215E4BC(1);

        if (NpcUnknown__Func_216EFDC(&work->npcTalk) == 0xFFFF)
        {
            work->DrawUpperMissionNumber(CVITALKMISSIONLIST_ID_INVALID);
        }
        else if (NpcUnknown__Func_216EFDC(&work->npcTalk) == MISSION_99)
        {
            work->DrawUpperMissionNumber(CVITALKMISSIONLIST_ID_INVALID);
        }

        SetCurrentTaskMainEvent(CViTalkMissionList::Main_MissionListActive);
    }
    else if (NpcUnknown__Func_216EF78(&work->npcTalk))
    {
        ViDock__Func_215E4BC(0);
    }
}

void CViTalkMissionList::Main_MissionListActive(void)
{
    CViTalkMissionList *work = TaskGetWorkCurrent(CViTalkMissionList);

    NpcUnknown__Func_216EF50(&work->npcTalk);
    work->Draw();

    if (NpcUnknown__Func_216EFC0(&work->npcTalk))
    {
        if (NpcUnknown__Func_216EF88(&work->npcTalk))
        {
            if (NpcUnknown__Func_216EFDC(&work->npcTalk) == MISSION_99)
            {
                if (work->CheckThreadIdle())
                {
                    if (MissionHelpers__CheckMissionCompleted(MISSION_99))
                    {
                        // "Well? D'ya like it, mate?"
                        work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_RAC_MCF), 25,
                                                CVIEVTCMN_RESOURCE_NONE);
                    }
                    else
                    {
                        // "You cleared every mission, mate!"
                        work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_RAC_MCF), 24,
                                                CVIEVTCMN_RESOURCE_NONE);
                    }

                    work->viEvtCmnTalk.SetPage(0);
                    SetCurrentTaskMainEvent(CViTalkMissionList::Main_ClearedAllMissionsDialog);
                }
            }
            else
            {
                // "Do you want to play this mission?"
                work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_MS_MCF), 1, CVIEVTCMN_RESOURCE_NONE);
                work->viEvtCmnTalk.SetPage(0);
                SetCurrentTaskMainEvent(CViTalkMissionList::Main_MissionSelected);
            }
        }
        else if (work->CheckThreadIdle())
        {
            // "See you later!"
            work->viEvtCmnTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_MS_MCF), 2, CVIEVTCMN_RESOURCE_NONE);
            work->viEvtCmnTalk.SetPage(0);
            SetCurrentTaskMainEvent(CViTalkMissionList::Main_CloseMissionListDialog);
        }
    }
}

void CViTalkMissionList::Main_MissionSelected(void)
{
    CViTalkMissionList *work = TaskGetWorkCurrent(CViTalkMissionList);

    work->Draw();

    work->viEvtCmnTalk.ProcessDialog();
    if (work->viEvtCmnTalk.IsFinished())
    {
        s32 selection = work->viEvtCmnTalk.GetSelection();
        work->viEvtCmnTalk.Release();

        switch (selection)
        {
            case 0:
                work->missionSelected = TRUE;
                work->DrawUpperMissionNumber(CVITALKMISSIONLIST_ID_INVALID);
                SetCurrentTaskMainEvent(CViTalkMissionList::Main_Finished);
                break;

            case 1:
                break;

            case 2:
                NpcUnknown__Func_216EEC0(&work->npcTalk, work->selection, 1);
                SetCurrentTaskMainEvent(CViTalkMissionList::Main_OpeningMissionList);
                break;
        }
    }
}

void CViTalkMissionList::Main_ClearedAllMissionsDialog(void)
{
    CViTalkMissionList *work = TaskGetWorkCurrent(CViTalkMissionList);

    work->viEvtCmnTalk.ProcessDialog();
    if (work->viEvtCmnTalk.IsFinished())
    {
        if (work->viEvtCmnTalk.GetAction() == 16)
        {
            work->lastMissionSelected = TRUE;
            DestroyCurrentTask();
        }
        else
        {
            NpcUnknown__Func_216EEC0(&work->npcTalk, work->selection, 1);
            work->DrawUpperMissionNumber(work->selection);
            SetCurrentTaskMainEvent(CViTalkMissionList::Main_OpeningMissionList);
        }
    }
}

void CViTalkMissionList::Main_CloseMissionListDialog(void)
{
    CViTalkMissionList *work = TaskGetWorkCurrent(CViTalkMissionList);

    work->viEvtCmnTalk.ProcessDialog();
    if (work->viEvtCmnTalk.IsFinished())
    {
        s32 selection = work->viEvtCmnTalk.GetSelection();
        work->viEvtCmnTalk.Release();

        switch (selection)
        {
            case 0:
                break;

            case 1:
                work->missionSelected = FALSE;
                DestroyCurrentTask();
                break;

            case 2:
                NpcUnknown__Func_216EEC0(&work->npcTalk, work->selection, 1);
                work->DrawUpperMissionNumber(work->selection);
                SetCurrentTaskMainEvent(CViTalkMissionList::Main_OpeningMissionList);
                break;
        }
    }
}

void CViTalkMissionList::Main_Finished(void)
{
    CViTalkMissionList *work = TaskGetWorkCurrent(CViTalkMissionList);

    work->Draw();

    if (work->CheckThreadIdle())
        DestroyCurrentTask();
}

void CViTalkMissionList::Destructor(Task *task)
{
    CViTalkMissionList *work = TaskGetWork(task, CViTalkMissionList);

    if (work->lastMissionSelected)
    {
        if (MissionHelpers__CheckMissionAttempted(MISSION_99))
            MissionHelpers__ResetMissionAttempted(MISSION_99);

        CViDockNpcTalk::SetTalkAction(11);
        CViDockNpcTalk::SetSelection(MISSION_99);
    }
    else if (work->missionSelected)
    {
        s32 id = MissionHelpers__GetMissionFromSelection(work->selection);
        if (MissionHelpers__CheckMissionAttempted(id))
            MissionHelpers__ResetMissionAttempted(id);

        CViDockNpcTalk::SetTalkAction(9);
        CViDockNpcTalk::SetSelection(id);
    }
    else
    {
        CViDockNpcTalk::SetTalkAction(0);
        CViDockNpcTalk::SetSelection(0);
    }

    work->Release();

    HubTaskDestroy<CViTalkMissionList>(task);
}

void CViTalkMissionList::DrawUpperMissionNumber(s32 selection)
{
    if (this->lastDrawnMissionNum != selection)
    {
        if (selection == CVITALKMISSIONLIST_ID_INVALID)
        {
            Unknown2056570__Func_205683C(&this->unknown);
        }
        else
        {
            BackgroundBlock *pixelBlock = GetBackgroundPixels(HubControl::GetFileFrom_ViBG(ARCHIVE_VI_BG_LZ7_FILE_VI_MS_NUMBER_BBG));

            // change from 0-indexed id to 1-indexed id
            s32 missionNum = selection + 1;
            if (selection + 1 >= MISSION_COUNT)
                missionNum = MISSION_COUNT;

            u8 *pixels = pixelBlock->data;
            s32 digit3 = FX_ModS32(missionNum, 10);
            s32 div    = FX_DivS32(missionNum, 10);
            s32 digit2 = FX_ModS32(div, 10);
            s32 digit1 = FX_DivS32(div, 10);

            u8 *dest = (u8 *)Unknown2056570__Func_2056834(&this->unknown);
            MI_CpuCopyFast(&pixels[32 * digit1], &dest[0x00], 0x20);
            MI_CpuCopyFast(&pixels[32 * digit2], &dest[0x20], 0x20);
            MI_CpuCopyFast(&pixels[32 * digit3], &dest[0x40], 0x20);
        }

        Unknown2056570__Func_2056B8C(&this->unknown);

        if (selection == CVITALKMISSIONLIST_ID_INVALID)
        {
            if (this->lastDrawnMissionNum != CVITALKMISSIONLIST_ID_INVALID)
            {
                FontWindowAnimator__InitAnimation(&this->fontWindowAnimator, 4, 12, 0, 0);
                FontWindowAnimator__StartAnimating(&this->fontWindowAnimator);
                this->isWindowOpen = TRUE;
            }
        }
        else
        {
            if (this->lastDrawnMissionNum == CVITALKMISSIONLIST_ID_INVALID)
            {
                FontWindowAnimator__InitAnimation(&this->fontWindowAnimator, 1, 12, 0, 0);
                FontWindowAnimator__StartAnimating(&this->fontWindowAnimator);
                this->isWindowOpen = TRUE;
            }
        }

        this->lastDrawnMissionNum = selection;
    }
}

void CViTalkMissionList::Draw()
{
    u8 charNameAniTable[]   = { 2, 1, 6, 7, 8, 9, 10, 12, 11, 13, 14, 0xFF, 0xFF };
    u8 charCircleAniTable[] = { 10, 8, 9, 11, 1, 2, 3, 4, 5, 6, 7, 0xFF, 0xFF };

    if (this->nextMissionID != CVITALKMISSIONLIST_ID_INVALID && IsThreadWorkerFinished(&this->thread))
    {
        this->missionID = this->nextMissionID;
        if (this->missionID > this->missionCount)
            this->missionID = CVITALKMISSIONLIST_ID_INVALID;

        this->nextMissionID = CVITALKMISSIONLIST_ID_INVALID;
    }

    if (this->lastDrawnMissionNum == this->missionID)
    {
        FontAnimator__Draw(&this->fontAnimator);
        if (this->isWindowOpen || this->lastDrawnMissionNum == CVITALKMISSIONLIST_ID_INVALID)
            CViTalkMissionList::SetMissionDescriptionVisible(FALSE);
        else
            CViTalkMissionList::SetMissionDescriptionVisible(TRUE);
    }
    else if (this->nextMissionID == CVITALKMISSIONLIST_ID_INVALID)
    {
        if (this->lastDrawnMissionNum == CVITALKMISSIONLIST_ID_INVALID)
            this->nextMissionID = this->missionCount + 1;
        else
            this->nextMissionID = this->lastDrawnMissionNum;
        CreateThreadWorker(&this->thread, CViTalkMissionList::ThreadFunc_ChangeMissionText, this, 20);
    }

    if (!this->isWindowOpen && this->missionID != CVITALKMISSIONLIST_ID_INVALID)
    {
        AnimatorSprite__ProcessAnimation(&this->aniMissionNumBackdrop, 0, 0);
        AnimatorSprite__DrawFrame(&this->aniMissionNumBackdrop);

        AnimatorSprite__ProcessAnimation(&this->aniMissionStatusBackdrop, 0, 0);
        AnimatorSprite__DrawFrame(&this->aniMissionStatusBackdrop);

        if ((this->missionList[this->missionID].flags & 1) != 0)
        {
            u16 npcType = MissionHelpers__GetNpcNameAnimForMission(this->missionID);

            AnimatorSprite *aniCharacterName = &this->aniCharacterName;
            if (aniCharacterName->animID != charNameAniTable[npcType])
                AnimatorSprite__SetAnimation(aniCharacterName, charNameAniTable[npcType]);
            aniCharacterName->pos.x = 132;
            aniCharacterName->pos.y = 160;
            AnimatorSprite__ProcessAnimationFast(aniCharacterName);
            AnimatorSprite__DrawFrame(aniCharacterName);

            AnimatorSprite *aniCharacterCircle = &this->aniCharacterCircle;
            if (aniCharacterCircle->animID != charCircleAniTable[npcType])
                AnimatorSprite__SetAnimation(aniCharacterCircle, charCircleAniTable[npcType]);
            aniCharacterCircle->pos.x = 190;
            aniCharacterCircle->pos.y = 138;
            AnimatorSprite__ProcessAnimationFast(aniCharacterCircle);
            AnimatorSprite__DrawFrame(aniCharacterCircle);

            AnimatorSprite *aniCharacterPortrait = &this->aniCharacterPortrait;
            aniCharacterPortrait->pos.x          = 190;
            aniCharacterPortrait->pos.y          = 138;
            AnimatorSprite__ProcessAnimationFast(aniCharacterPortrait);
            AnimatorSprite__DrawFrame(aniCharacterPortrait);

            if ((this->missionList[this->missionID].flags & 4) != 0)
            {
                AnimatorSprite__ProcessAnimationFast(&this->aniMissionStatus);
                AnimatorSprite__DrawFrame(&this->aniMissionStatus);
            }
        }
    }

    if (this->isWindowOpen)
    {
        FontWindowAnimator__ProcessWindowAnim(&this->fontWindowAnimator);
        if (FontWindowAnimator__IsFinishedAnimating(&this->fontWindowAnimator))
        {
            FontWindowAnimator__SetWindowOpen(&this->fontWindowAnimator);
            this->isWindowOpen = FALSE;
        }
    }

    if (this->isWindowOpen || (this->lastDrawnMissionNum != CVITALKMISSIONLIST_ID_INVALID && this->missionID != CVITALKMISSIONLIST_ID_INVALID))
        FontWindowAnimator__Draw(&this->fontWindowAnimator);
}

BOOL CViTalkMissionList::CheckThreadIdle()
{
    return this->lastDrawnMissionNum == CVITALKMISSIONLIST_ID_INVALID && IsThreadWorkerFinished(&this->thread) && !this->isWindowOpen;
}

void CViTalkMissionList::StopThreadWorker()
{
    if (this->nextMissionID != CVITALKMISSIONLIST_ID_INVALID)
    {
        JoinThreadWorker(&this->thread);
        this->nextMissionID = CVITALKMISSIONLIST_ID_INVALID;
    }
}

void CViTalkMissionList::ThreadFunc_ChangeMissionText(void *arg)
{
    CViTalkMissionList *work = (CViTalkMissionList *)arg;

    if (work->nextMissionID <= work->missionCount)
    {
        u16 sequence;
        if ((work->missionList[work->nextMissionID].flags & 1) != 0)
            sequence = MISSIONLIST_SEQ_COUNT * work->nextMissionID + MISSIONLIST_SEQ_CLIENT;
        else
            sequence = MISSIONLIST_SEQ_COUNT * work->missionCount + MISSIONLIST_SEQ_CLIENT;

        FontAnimator__SetMsgSequence(&work->fontAnimator, sequence + (MISSIONLIST_SEQ_DESCRIPTION - 1));
        FontAnimator__LoadCharacters(&work->fontAnimator, 0);
    }
    else
    {
        FontAnimator__ClearPixels(&work->fontAnimator);
    }
}

void CViTalkMissionList::SetMissionListWindowVisible(BOOL enabled)
{
    if (enabled)
        GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_BG2);
    else
        GX_SetVisiblePlane(GX_GetVisiblePlane() & ~GX_PLANEMASK_BG2);
}

void CViTalkMissionList::SetMissionUnknownVisible(BOOL enabled)
{
    if (enabled)
        GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG2);
    else
        GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~GX_PLANEMASK_BG2);
}

void CViTalkMissionList::SetMissionListVisible(BOOL enabled)
{
    if (enabled)
        GX_SetVisiblePlane(GX_GetVisiblePlane() | (GX_PLANEMASK_BG1 | GX_PLANEMASK_BG3));
    else
        GX_SetVisiblePlane(GX_GetVisiblePlane() & ~(GX_PLANEMASK_BG1 | GX_PLANEMASK_BG3));
}

void CViTalkMissionList::SetMissionDescriptionVisible(BOOL enabled)
{
    if (enabled)
        GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG3);
    else
        GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~GX_PLANEMASK_BG3);
}

void CViTalkMissionList::InitWindow(BOOL enabled, s32 scrollPos)
{
    if (scrollPos == 0)
        enabled = FALSE;

    if (!enabled)
    {
        scrollPos                                   = 0;
        renderCoreGFXControlB.windowManager.visible = FALSE;
    }
    else
    {
        renderCoreGFXControlB.windowManager.registers.win0X2 = CVITALKMISSIONLIST_ID_INVALID;
        renderCoreGFXControlB.windowManager.registers.win0X1 = 0;
        renderCoreGFXControlB.windowManager.registers.win0Y2 = scrollPos;
        renderCoreGFXControlB.windowManager.registers.win0Y1 = 0;

        renderCoreGFXControlB.windowManager.registers.win0InPlane.plane_BG0 = TRUE;
        renderCoreGFXControlB.windowManager.registers.win0InPlane.plane_BG1 = TRUE;
        renderCoreGFXControlB.windowManager.registers.win0InPlane.plane_BG2 = FALSE;
        renderCoreGFXControlB.windowManager.registers.win0InPlane.plane_BG3 = FALSE;
        renderCoreGFXControlB.windowManager.registers.win0InPlane.plane_OBJ = TRUE;

        renderCoreGFXControlB.windowManager.registers.winOutPlane.plane_BG0 = TRUE;
        renderCoreGFXControlB.windowManager.registers.winOutPlane.plane_BG1 = TRUE;
        renderCoreGFXControlB.windowManager.registers.winOutPlane.plane_BG2 = TRUE;
        renderCoreGFXControlB.windowManager.registers.winOutPlane.plane_BG3 = TRUE;
        renderCoreGFXControlB.windowManager.registers.winOutPlane.plane_OBJ = TRUE;

        renderCoreGFXControlB.windowManager.visible = TRUE;
    }
}