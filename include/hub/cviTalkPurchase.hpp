#ifndef RUSH_CVITALKPURCHASE_HPP
#define RUSH_CVITALKPURCHASE_HPP

#include <hub/hubTask.hpp>
#include <hub/cviEvtCmn.hpp>
#include <hub/cviEvtCmnPurchase.hpp>
#include <game/graphics/sprite.h>
#include <game/system/threadWorker.h>
#include <hub/hubConfig.h>

// --------------------
// STRUCTS
// --------------------

class CViTalkPurchase
{

public:
    // --------------------
    // ENUMS
    // --------------------

    enum PurchaseType
    {
        PURCHASE_CONSTRUCTION,
        PURCHASE_DECORATION,
        PURCHASE_SHIP_UPGRADE,
        PURCHASE_INFO,
    };

    enum ConstructionType
    {
        CONSTRUCT_JET,
        CONSTRUCT_BOAT,
        CONSTRUCT_HOVER,
        CONSTRUCT_SUBMARINE,
        CONSTRUCT_DRILL, // not used in-game
        CONSTRUCT_RADIO_TOWER,

        CONSTRUCT_INVALID,
    };

    enum DecorType
    {
        DECOR_1,
        DECOR_2,
        DECOR_3,

        DECOR_COUNT,
        DECOR_INVALID,
    };

    enum UpgradeType
    {
        UPGRADE_JET_LEVEL1,
        UPGRADE_JET_LEVEL2,
        UPGRADE_BOAT_LEVEL1,
        UPGRADE_BOAT_LEVEL2,
        UPGRADE_HOVER_LEVEL1,
        UPGRADE_HOVER_LEVEL2,
        UPGRADE_SUBMARINE_LEVEL1,
        UPGRADE_SUBMARINE_LEVEL2,

        UPGRADE_COUNT,
        UPGRADE_INVALID,
    };

    enum InfoType
    {
        INFO_INVALID,
        INFO_HINT,
    };

    enum CostType
    {
        COST_MATERIAL_BLUE,
        COST_MATERIAL_IRON,
        COST_MATERIAL_GREEN,
        COST_MATERIAL_BRONZE,
        COST_MATERIAL_RED,
        COST_MATERIAL_SILVER,
        COST_MATERIAL_AQUA,
        COST_MATERIAL_GOLD,
        COST_MATERIAL_BLACK,
        COST_RINGS,

        COST_INVALID = 0xFFFF,
    };

    // --------------------
    // VARIABLES
    // --------------------

    s32 constructionID;
    s32 decorPurchaseID;
    s32 shipUpgradeID;
    s32 infoPurchaseID;
    BOOL canPurchase;
    CViEvtCmnTalk eventTalk;
    AnimatorSprite aniMaterial;
    AnimatorSprite aniRing;
    AnimatorSprite aniCostBackground;
    u16 costType;
    CViEvtCmnPurchase eventPurchase;
    Thread threadWorker;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void InitDisplay();
    void InitSprites();
    void InitEventPurchase();
    void Release();
    void ResetDisplay();
    void ReleaseSprites();
    void ReleaseEventPurchase();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Create(s32 param);
    static void MakeTutorialPurchase(void);

private:
    static void ThreadFunc(void *arg);
    static void Main_Init(void);
    static void Main_OpenWindow(void);
    static void Main_ShowPurchasePrompt(void);
    static void Main_CloseWindow(void);
    static void Main_ApplyPurchase(void);
    static void Destructor(Task *task);
    static void TalkCallback(u32 type, struct FontAnimator_ *animator, void *context);

    static BOOL CanPurchaseShipBuild(s32 id);
    static BOOL CanPurchaseRadioTower();
    static BOOL CanPurchaseDecor(s32 id);
    static BOOL CanPurchaseShipUpgrade(s32 id);
    static s32 GetMaterialCount(u16 type);
    static BOOL GetRingCount();
    static BOOL CanMakePurchase(const HubPurchaseCostConfig *config);
    static void MakePurchase(const HubPurchaseCostConfig *config);
};

#endif // RUSH_CVITALKPURCHASE_HPP