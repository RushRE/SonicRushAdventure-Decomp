#ifndef RUSH_CVITALKPURCHASE_HPP
#define RUSH_CVITALKPURCHASE_HPP

#include <hub/hubTask.hpp>
#include <hub/npcPurchase.hpp>
#include <game/graphics/sprite.h>
#include <game/system/threadWorker.h>
#include <hub/dockHelpers.h>

// --------------------
// STRUCTS
// --------------------

#ifdef __cplusplus

class CViTalkPurchase
{

public:
    // --------------------
    // VARIABLES
    // --------------------
    u32 field_0;
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

#endif

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

NOT_DECOMPILED void ViTalkPurchase__Create(s32 param);
NOT_DECOMPILED void ViTalkPurchase__CreateInternal(void);
NOT_DECOMPILED void ViTalkPurchase__MakeTutorialPurchase(void);
NOT_DECOMPILED void ViTalkPurchase__ThreadFunc(CViTalkPurchase *work);
NOT_DECOMPILED void ViTalkPurchase__InitDisplay(CViTalkPurchase *work);
NOT_DECOMPILED void ViTalkPurchase__InitSprites(CViTalkPurchase *work);
NOT_DECOMPILED void ViTalkPurchase__InitNpcPurchase(CViTalkPurchase *work);
NOT_DECOMPILED void ViTalkPurchase__Release(CViTalkPurchase *work);
NOT_DECOMPILED void ViTalkPurchase__ResetDisplay(CViTalkPurchase *work);
NOT_DECOMPILED void ViTalkPurchase__ReleaseSprites(CViTalkPurchase *work);
NOT_DECOMPILED void ViTalkPurchase__ReleaseNpcPurchase(CViTalkPurchase *work);
NOT_DECOMPILED void ViTalkPurchase__Main(void);
NOT_DECOMPILED void ViTalkPurchase__Main_2169CF0(void);
NOT_DECOMPILED void ViTalkPurchase__Main_2169D4C(void);
NOT_DECOMPILED void ViTalkPurchase__Main_2169E10(void);
NOT_DECOMPILED void ViTalkPurchase__Main_2169E4C(void);
NOT_DECOMPILED void ViTalkPurchase__Destructor(Task *task);
NOT_DECOMPILED void ViTalkPurchase__Func_2169FC0(void);
NOT_DECOMPILED void ViTalkPurchase__TalkCallback(CViTalkPurchase *work);
NOT_DECOMPILED BOOL ViTalkPurchase__CanPurchaseShipBuild(s32 id);
NOT_DECOMPILED BOOL ViTalkPurchase__CanPurchaseUnknown(s32 id);
NOT_DECOMPILED BOOL ViTalkPurchase__CanPurchaseInfo(s32 id);
NOT_DECOMPILED BOOL ViTalkPurchase__CanPurchaseShipUpgrade(s32 id);
NOT_DECOMPILED BOOL ViTalkPurchase__GetMaterialCount(u16 type);
NOT_DECOMPILED BOOL ViTalkPurchase__GetRingCount();
NOT_DECOMPILED BOOL ViTalkPurchase__CanMakePurchase(PurchaseCostConfig *config);
NOT_DECOMPILED void ViTalkPurchase__MakePurchase(PurchaseCostConfig *config);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVITALKPURCHASE_HPP