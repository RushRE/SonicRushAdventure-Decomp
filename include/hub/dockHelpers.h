#ifndef RUSH_DOCKHELPERS_H
#define RUSH_DOCKHELPERS_H

#include <global.h>
#include <hub/cviDock.hpp>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct Unknown2171FE8_
{
    s16 field_0;
    s16 field_2;
    s32 field_4;
    s32 field_8;
    u32 field_C[3];
    u32 field_18[3];
    u32 field_24[3];
    u32 field_30[3];
    u16 field_3C;
    s16 field_3E;
} Unknown2171FE8;

typedef struct DockStageConfig_
{
    DockArea areaID;
    DockArea nextArea;
    VecFx32 field_8;
    s32 field_14;
    s32 field_18;
    s32 field_1C;
    s32 field_20;
    s32 field_24;
    s32 field_28;
    s32 field_2C;
    s32 field_30;
    s32 field_34;
    fx32 playerTopSpeed;
    s32 field_3C;
    s16 field_40;
    s16 field_42;
} DockStageConfig;

typedef struct DockMapConfig_
{
    DockArea areaID;
    s32 field_4;
    s32 field_8;
    s32 field_C;
    u16 field_10;
    u16 msgSeq;
    s32 field_14;
    s32 field_18;
    s32 field_1C;
    s32 field_20;
    s32 field_24;
} DockMapConfig;

typedef struct ViDockBackConfig_
{
    s32 field_0;
    u16 resModelShip;
    u16 resJointAnimShip;
    u16 resModelDock;
    u16 resJointAnimDock;
    u16 resTextureAnimDock;
    u16 resPatternAnimDock;
    u16 field_10;
    u16 field_12;
    s32 field_14;
    s32 field_18;
} ViDockBackConfig;

typedef struct Unknown2171CCC_
{
    s32 field_0;
    s32 field_4;
    s32 field_8;
    s32 field_C;
    s32 field_10;
    s32 field_14;
    s32 field_18;
    s32 field_1C;
    s32 field_20;
    s32 field_24;
} Unknown2171CCC;

typedef struct CViNpcConfig_
{
    u16 field_0;
    u16 spawnAngle;
    s16 spawnX;
    s16 spawnZ;
    u16 *(*field_8)(void);
} CViNpcConfig;

typedef struct NpcMsgInfo_
{
    u16 msgCtrlFile;
    u16 msgTextID1;
    u16 msgTextID2;
    u16 msgTextID3;
} NpcMsgInfo;

typedef struct OptionsMessageConfig_
{
    u16 msgCtrlFile;
    u16 msgTextID[7];
} OptionsMessageConfig;

typedef struct PurchaseCostConfig_
{
    u32 ringCost;
    u8 materialCost[9];
} PurchaseCostConfig;

typedef struct AnnounceConfig_
{
    u16 mpcFile;
    u16 sequence;
} AnnounceConfig;

typedef struct ViTalkPurchaseMsgConfig_
{
    u16 fileID;
    u16 interactionID;
} ViTalkPurchaseMsgConfig;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED Unknown2171FE8 *HubConfig__Func_2152960(u16 a1);
NOT_DECOMPILED DockStageConfig *HubConfig__Func_2152970(u16 a1);
NOT_DECOMPILED void HubConfig__Func_2152984(void);
NOT_DECOMPILED DockMapConfig *HubConfig__Func_2152994(u16 a1);
NOT_DECOMPILED Unknown2171CCC *HubConfig__Func_21529A8(u16 a1);
NOT_DECOMPILED PurchaseCostConfig *HubConfig__GetShipBuildCost(s32 id);
NOT_DECOMPILED PurchaseCostConfig *HubConfig__GetRadioTowerPurchaseCost();
NOT_DECOMPILED PurchaseCostConfig *HubConfig__GetDecorPurchaseCost(s32 id);
NOT_DECOMPILED PurchaseCostConfig *HubConfig__GetShipUpgradeCost(s32 id);
NOT_DECOMPILED void HubConfig__GetDockBackInfo(void);
NOT_DECOMPILED CViNpcConfig *HubConfig__GetNpcConfig(u16 a1);
NOT_DECOMPILED void HubConfig__Func_2152A20(void);
NOT_DECOMPILED void HubConfig__Func_2152A30(void);
NOT_DECOMPILED void HubConfig__Func_2152A40(void);
NOT_DECOMPILED void HubConfig__GetMapBackConfig(void);
NOT_DECOMPILED void HubConfig__Func_2152A60(void);
NOT_DECOMPILED void HubConfig__Func_2152A70(void);
NOT_DECOMPILED void HubConfig__Func_2152A7C(void);
NOT_DECOMPILED void HubConfig__Func_2152A88(void);
NOT_DECOMPILED void HubConfig__Func_2152A94(void);
NOT_DECOMPILED void HubConfig__Func_2152AA0(void);
NOT_DECOMPILED void HubConfig__Func_2152AAC(void);
NOT_DECOMPILED void HubConfig__Func_2152AB8(void);
NOT_DECOMPILED void HubConfig__Func_2152AC4(void);
NOT_DECOMPILED void HubConfig__Func_2152AD0(void);
NOT_DECOMPILED void HubConfig__Func_2152ADC(void);
NOT_DECOMPILED void HubConfig__Func_2152AE8(void);
NOT_DECOMPILED void HubConfig__Func_2152AF4(void);
NOT_DECOMPILED void HubConfig__Func_2152B00(void);
NOT_DECOMPILED NpcMsgInfo *HubConfig__GetNpcMessageInfo(s32 id);
NOT_DECOMPILED ViTalkPurchaseMsgConfig *HubConfig__Func_2152B1C(s32 id);
NOT_DECOMPILED ViTalkPurchaseMsgConfig *HubConfig__Func_2152B2C(void);
NOT_DECOMPILED ViTalkPurchaseMsgConfig *HubConfig__Func_2152B38(s32 id);
NOT_DECOMPILED ViTalkPurchaseMsgConfig *HubConfig__Func_2152B48(s32 id);
NOT_DECOMPILED ViTalkPurchaseMsgConfig *HubConfig__Func_2152B58(void);
NOT_DECOMPILED AnnounceConfig *HubConfig__GetAnnounceConfig(s32 id);
NOT_DECOMPILED OptionsMessageConfig *HubConfig__GetOptionsMessageInfo(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_DOCKHELPERS_H