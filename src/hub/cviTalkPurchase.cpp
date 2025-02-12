#include <hub/cviTalkPurchase.hpp>
#include <hub/hubControl.hpp>
#include <hub/hubAudio.h>
#include <hub/cviDockNpcTalk.hpp>
#include <game/save/saveGame.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/file/fileUnknown.h>
#include <game/text/fontAnimator.h>

// resources
#include <resources/narc/vi_act_lz7.h>

// --------------------
// FUNCTIONS
// --------------------

void CViTalkPurchase::Create(s32 param)
{
    Task *task = HubTaskCreate(CViTalkPurchase::Main_Init, CViTalkPurchase::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(16), CViTalkPurchase);

    CViTalkPurchase *work = TaskGetWork(task, CViTalkPurchase);

    work->constructionID  = CViTalkPurchase::CONSTRUCT_INVALID;
    work->decorPurchaseID = CViTalkPurchase::DECOR_INVALID;
    work->shipUpgradeID   = CViTalkPurchase::UPGRADE_INVALID;
    work->infoPurchaseID  = CViTalkPurchase::INFO_INVALID;

    if (param == CViTalkPurchase::PURCHASE_CONSTRUCTION)
    {
        work->constructionID = HubControl::GetNextShipToBuild();
        if (work->constructionID < CViTalkPurchase::CONSTRUCT_RADIO_TOWER)
        {
            work->canPurchase = CViTalkPurchase::CanPurchaseShipBuild(work->constructionID);
        }
        else
        {
            if (SaveGame__GetGameProgress() == SAVE_PROGRESS_16)
                work->canPurchase = CViTalkPurchase::CanPurchaseRadioTower();
        }
    }
    else if (param == CViTalkPurchase::PURCHASE_DECORATION)
    {
        for (s32 i = 0; i < CViTalkPurchase::DECOR_COUNT; i++)
        {
            if ((SaveGame__CanBuyDecoration(i) && !SaveGame__GetBoughtDecoration(i)))
            {
                work->decorPurchaseID = i;
                break;
            }
        }

        work->canPurchase = CViTalkPurchase::CanPurchaseDecor(work->decorPurchaseID);
    }
    else if (param == CViTalkPurchase::PURCHASE_SHIP_UPGRADE)
    {
        u16 ship;
        u16 level;
        SaveGame__GetNextShipUpgrade(&ship, &level);
        work->shipUpgradeID = (level - SHIP_LEVEL_1) + 2 * ship;
        work->canPurchase   = CViTalkPurchase::CanPurchaseShipUpgrade(work->shipUpgradeID);
    }
    else if (param == CViTalkPurchase::PURCHASE_INFO)
    {
        work->infoPurchaseID = CViTalkPurchase::INFO_HINT;
        work->canPurchase    = SaveGame__CanBuyInfoHint();
    }

    work->InitDisplay();

    InitThreadWorker(&work->threadWorker, 0x400);
    CreateThreadWorker(&work->threadWorker, CViTalkPurchase::ThreadFunc, work, 20);
}

void CViTalkPurchase::MakeTutorialPurchase(void)
{
    CViTalkPurchase::MakePurchase(HubConfig__GetShipBuildCost(SHIP_JET));
}

void CViTalkPurchase::ThreadFunc(void *arg)
{
    CViTalkPurchase *work = (CViTalkPurchase *)arg;

    work->InitSprites();
    work->InitEventPurchase();
}

void CViTalkPurchase::InitDisplay()
{
    HubControl::InitEngineAForTalk();
    HubControl::InitEngineBForTalkPurchase();
}

void CViTalkPurchase::InitSprites()
{
    void *sprMaterial       = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_DMCMN_MAT32_BAC);
    VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1(sprMaterial));
    AnimatorSprite__Init(&this->aniMaterial, sprMaterial, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                         SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    this->aniMaterial.pos.x          = 16;
    this->aniMaterial.pos.y          = 32;
    this->aniMaterial.cParam.palette = PALETTE_ROW_8;

    void *sprRing = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_DMCMN_RING32_BAC);
    vramPixels    = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1(sprRing));
    AnimatorSprite__Init(&this->aniRing, sprRing, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0,
                         SPRITE_ORDER_0);
    this->aniRing.pos.x          = 16;
    this->aniRing.pos.y          = 32;
    this->aniRing.cParam.palette = PALETTE_ROW_8;

    void *sprMenu = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_VI_MENU_BAC);
    vramPixels    = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1FromAnim(sprMenu, 1));
    AnimatorSprite__Init(&this->aniCostBackground, sprMenu, 1, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                         SPRITE_PRIORITY_0, SPRITE_ORDER_1);
    this->aniCostBackground.pos.x          = 8;
    this->aniCostBackground.pos.y          = 24;
    this->aniCostBackground.cParam.palette = PALETTE_ROW_9;

    this->costType = CViTalkPurchase::COST_INVALID;
}

void CViTalkPurchase::InitEventPurchase()
{
    this->eventPurchase.Init();
    this->eventPurchase.Load(BACKGROUND_2, 960, 1023, 3, PALETTE_ROW_12, PALETTE_ROW_15);
}

void CViTalkPurchase::Release()
{
    JoinThreadWorker(&this->threadWorker);
    ReleaseThreadWorker(&this->threadWorker);

    this->ReleaseEventPurchase();
    this->ReleaseSprites();

    this->eventTalk.Release();

    this->ResetDisplay();
}

void CViTalkPurchase::ResetDisplay()
{
    HubControl::InitEngineAFor3DHub();
    HubControl::InitEngineBFor3DHub();
}

void CViTalkPurchase::ReleaseSprites()
{
    AnimatorSprite__Release(&this->aniCostBackground);
    AnimatorSprite__Release(&this->aniRing);
    AnimatorSprite__Release(&this->aniMaterial);

    this->costType = CViTalkPurchase::COST_INVALID;
}

void CViTalkPurchase::ReleaseEventPurchase()
{
    this->eventPurchase.Release();
}

void CViTalkPurchase::Main_Init(void)
{
    CViTalkPurchase *work = TaskGetWorkCurrent(CViTalkPurchase);

    if (IsThreadWorkerFinished(&work->threadWorker))
    {
        const HubPurchaseMsgConfig *config;
        if (work->decorPurchaseID < CViTalkPurchase::DECOR_COUNT)
        {
            config = HubConfig__GetDecorationPurchaseMsgConfig(work->decorPurchaseID);
        }
        else if (work->constructionID < CViTalkPurchase::CONSTRUCT_RADIO_TOWER)
        {
            config = HubConfig__GetConstructionPurchaseMsgConfig(work->constructionID);
        }
        else if (work->shipUpgradeID < CViTalkPurchase::UPGRADE_COUNT)
        {
            config = HubConfig__GetShipUpgradePurchaseMsgConfig(work->shipUpgradeID);
        }
        else if (work->infoPurchaseID != CViTalkPurchase::INFO_INVALID)
        {
            config = HubConfig__GetInfoPurchaseMsgConfig();
        }
        else
        {
            config = HubConfig__GetRadioTowerPurchaseMsgConfig();
        }

        work->eventTalk.Init(FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsgCtrl(), config->fileID), config->interactionID, CVIEVTCMN_RESOURCE_NONE);
        work->eventTalk.SetCallback(CViTalkPurchase::TalkCallback, (void *)work);
        work->eventPurchase.ProcessGraphics();
        SetCurrentTaskMainEvent(CViTalkPurchase::Main_OpenWindow);
    }
}

void CViTalkPurchase::Main_OpenWindow(void)
{
    CViTalkPurchase *work = TaskGetWorkCurrent(CViTalkPurchase);

    work->eventPurchase.Process();
    if (work->eventPurchase.IsReady())
    {
        work->eventTalk.SetPage(work->canPurchase == FALSE ? 1 : 0);
        SetCurrentTaskMainEvent(CViTalkPurchase::Main_ShowPurchasePrompt);
    }
}

void CViTalkPurchase::Main_ShowPurchasePrompt(void)
{
    CViTalkPurchase *work = TaskGetWorkCurrent(CViTalkPurchase);

    work->eventTalk.ProcessDialog();
    work->eventPurchase.Process();

    if (work->costType != CViTalkPurchase::COST_INVALID)
    {
        if (work->costType == CViTalkPurchase::COST_RINGS)
        {
            AnimatorSprite__ProcessAnimationFast(&work->aniRing);
            AnimatorSprite__DrawFrame(&work->aniRing);
        }
        else
        {
            AnimatorSprite__ProcessAnimationFast(&work->aniMaterial);
            AnimatorSprite__DrawFrame(&work->aniMaterial);
        }

        AnimatorSprite__ProcessAnimationFast(&work->aniCostBackground);
        AnimatorSprite__DrawFrame(&work->aniCostBackground);
    }

    if (work->eventTalk.IsFinished())
    {
        work->eventPurchase.CloseWindow();
        SetCurrentTaskMainEvent(CViTalkPurchase::Main_CloseWindow);
    }
}

void CViTalkPurchase::Main_CloseWindow(void)
{
    CViTalkPurchase *work = TaskGetWorkCurrent(CViTalkPurchase);

    work->eventPurchase.Process();
    if (work->eventPurchase.IsActive())
        SetCurrentTaskMainEvent(CViTalkPurchase::Main_ApplyPurchase);
}

void CViTalkPurchase::Main_ApplyPurchase(void)
{
    static const u16 decorPurchaseSelection[CViTalkPurchase::DECOR_COUNT] = { 5, 8, 17 };

    CViTalkPurchase *work = TaskGetWorkCurrent(CViTalkPurchase);

    switch (work->eventTalk.GetAction())
    {
        case CViEvtCmnTalk::ACTION_2:
            if (work->decorPurchaseID < CViTalkPurchase::DECOR_COUNT)
            {
                CViTalkPurchase::MakePurchase(HubConfig__GetDecorPurchaseCost(work->decorPurchaseID));
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_6);
                CViDockNpcTalk::SetSelection(decorPurchaseSelection[work->decorPurchaseID]);
            }
            else if (work->constructionID < CViTalkPurchase::CONSTRUCT_RADIO_TOWER)
            {
                CViTalkPurchase::MakePurchase(HubConfig__GetShipBuildCost(work->constructionID));
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_4);
                CViDockNpcTalk::SetSelection(work->constructionID);
            }
            else if (work->shipUpgradeID < CViTalkPurchase::UPGRADE_COUNT)
            {
                CViTalkPurchase::MakePurchase(HubConfig__GetShipUpgradeCost(work->shipUpgradeID));
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_29);
                CViDockNpcTalk::SetSelection(work->shipUpgradeID);
            }
            else
            {
                CViTalkPurchase::MakePurchase(HubConfig__GetRadioTowerPurchaseCost());
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_6);
                CViDockNpcTalk::SetSelection(7);
            }
            break;

        case CViEvtCmnTalk::ACTION_20:
            if (work->shipUpgradeID < CViTalkPurchase::UPGRADE_COUNT)
            {
                CViTalkPurchase::MakePurchase(HubConfig__GetShipUpgradeCost(work->shipUpgradeID));
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_29);
                CViDockNpcTalk::SetSelection(work->shipUpgradeID);
            }
            else
            {
                CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_0);
                CViDockNpcTalk::SetSelection(0);
            }
            break;

        case CViEvtCmnTalk::ACTION_22:
            if (!SaveGame__GetProgressFlags_0x100000(0))
            {
                SaveGame__SetProgressFlags_0x100000(0);
                SaveGame__BuyInfoHint();
            }

            CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_0);
            CViDockNpcTalk::SetSelection(0);
            break;

        default:
            CViDockNpcTalk::SetTalkAction(CVIDOCKNPCTALK_ACTION_0);
            CViDockNpcTalk::SetSelection(0);
            break;
    }

    DestroyCurrentTask();
}

void CViTalkPurchase::Destructor(Task *task)
{
    CViTalkPurchase *work = TaskGetWork(task, CViTalkPurchase);

    work->Release();

    HubTaskDestroy<CViTalkPurchase>(task);
}

void CViTalkPurchase::TalkCallback(u32 type, struct FontAnimator_ *animator, void *context)
{
    CViTalkPurchase *work = (CViTalkPurchase *)context;

    if (type >= 10 && type <= 19)
    {
        work->costType = type - 10;

        if (work->costType == CViTalkPurchase::COST_RINGS)
            AnimatorSprite__SetAnimation(&work->aniRing, 0);
        else
            AnimatorSprite__SetAnimation(&work->aniMaterial, work->costType);

        FontAnimator__InitStartPos(animator, 0, 48);
    }
    else if (type == 20)
    {
        work->costType = CViTalkPurchase::COST_INVALID;
        FontAnimator__InitStartPos(animator, 0, 0);
    }
}

BOOL CViTalkPurchase::CanPurchaseShipBuild(s32 id)
{
    return CViTalkPurchase::CanMakePurchase(HubConfig__GetShipBuildCost(id));
}

BOOL CViTalkPurchase::CanPurchaseRadioTower()
{
    return CViTalkPurchase::CanMakePurchase(HubConfig__GetRadioTowerPurchaseCost());
}

BOOL CViTalkPurchase::CanPurchaseDecor(s32 id)
{
    return CViTalkPurchase::CanMakePurchase(HubConfig__GetDecorPurchaseCost(id));
}

BOOL CViTalkPurchase::CanPurchaseShipUpgrade(s32 id)
{
    return CViTalkPurchase::CanMakePurchase(HubConfig__GetShipUpgradeCost(id));
}

s32 CViTalkPurchase::GetMaterialCount(u16 type)
{
    if (type < SAVE_MATERIAL_COUNT)
        return SaveGame__GetMaterialCount(&saveGame.stage, type);
    else
        return 0;
}

BOOL CViTalkPurchase::GetRingCount()
{
    return saveGame.stage.ringCount;
}

BOOL CViTalkPurchase::CanMakePurchase(const HubPurchaseCostConfig *config)
{
    if (config->ringCost > CViTalkPurchase::GetRingCount())
        return FALSE;

    for (s32 t = 0; t < SAVE_MATERIAL_COUNT; t++)
    {
        if (config->materialCost[t] > CViTalkPurchase::GetMaterialCount(t))
            return FALSE;
    }

    return TRUE;
}

void CViTalkPurchase::MakePurchase(const HubPurchaseCostConfig *config)
{
    if (config->ringCost != 0)
        saveGame.stage.ringCount -= config->ringCost;

    for (s32 t = 0; t < SAVE_MATERIAL_COUNT; t++)
    {
        if (config->materialCost[t] != 0)
            SaveGame__UseMaterial(&saveGame.stage, t, config->materialCost[t]);
    }
}