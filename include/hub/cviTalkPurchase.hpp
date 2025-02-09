#ifndef RUSH_CVITALKPURCHASE_HPP
#define RUSH_CVITALKPURCHASE_HPP

#include <hub/hubTask.hpp>
#include <hub/cviEvtCmn.hpp>
#include <hub/npcPurchase.hpp>
#include <game/graphics/sprite.h>
#include <game/system/threadWorker.h>
#include <hub/dockHelpers.h>

// --------------------
// STRUCTS
// --------------------

class CViTalkPurchase
{

public:
    // --------------------
    // VARIABLES
    // --------------------
    s32 field_0;
    u32 infoPurchaseID;
    u32 shipUpgradeID;
    u32 unknown2PurchaseID;
    BOOL canPurchase;
    CViEvtCmnTalk evtCmnTalk;
    AnimatorSprite aniMaterial;
    AnimatorSprite aniRing;
    AnimatorSprite aniCostBackground;
    u16 costType;
    u16 field_5FA;
    NpcPurchase npcPurchase;
    Thread threadWorker;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

void ViTalkPurchase__Create(s32 param);
void ViTalkPurchase__CreateInternal(void);
void ViTalkPurchase__MakeTutorialPurchase(void);
void ViTalkPurchase__ThreadFunc(void *arg);
void ViTalkPurchase__InitDisplay(CViTalkPurchase *work);
void ViTalkPurchase__InitSprites(CViTalkPurchase *work);
void ViTalkPurchase__InitNpcPurchase(CViTalkPurchase *work);
void ViTalkPurchase__Release(CViTalkPurchase *work);
void ViTalkPurchase__ResetDisplay(CViTalkPurchase *work);
void ViTalkPurchase__ReleaseSprites(CViTalkPurchase *work);
void ViTalkPurchase__ReleaseNpcPurchase(CViTalkPurchase *work);
void ViTalkPurchase__Main(void);
void ViTalkPurchase__Main_2169CF0(void);
void ViTalkPurchase__Main_2169D4C(void);
void ViTalkPurchase__Main_2169E10(void);
void ViTalkPurchase__Main_2169E4C(void);
void ViTalkPurchase__Destructor(Task *task);
void ViTalkPurchase__TalkCallback(CViTalkPurchase *work);
BOOL ViTalkPurchase__CanPurchaseShipBuild(s32 id);
BOOL ViTalkPurchase__CanPurchaseUnknown(s32 id);
BOOL ViTalkPurchase__CanPurchaseInfo(s32 id);
BOOL ViTalkPurchase__CanPurchaseShipUpgrade(s32 id);
u32 ViTalkPurchase__GetMaterialCount(u16 type);
BOOL ViTalkPurchase__GetRingCount();
BOOL ViTalkPurchase__CanMakePurchase(PurchaseCostConfig *config);
void ViTalkPurchase__MakePurchase(PurchaseCostConfig *config);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVITALKPURCHASE_HPP