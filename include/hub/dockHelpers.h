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

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED Unknown2171FE8 *DockHelpers__Func_2152960(u16 a1);
NOT_DECOMPILED DockStageConfig *DockHelpers__Func_2152970(u16 a1);
NOT_DECOMPILED void DockHelpers__Func_2152984(void);
NOT_DECOMPILED DockMapConfig *DockHelpers__Func_2152994(u16 a1);
NOT_DECOMPILED Unknown2171CCC *DockHelpers__Func_21529A8(u16 a1);
NOT_DECOMPILED void DockHelpers__GetShipBuildCost(void);
NOT_DECOMPILED void DockHelpers__GetUnknownPurchaseCost(void);
NOT_DECOMPILED void DockHelpers__GetInfoPurchaseCost(void);
NOT_DECOMPILED void DockHelpers__GetShipUpgradeCost(void);
NOT_DECOMPILED void DockHelpers__GetDockBackInfo(void);
NOT_DECOMPILED CViNpcConfig *DockHelpers__GetNpcConfig(u16 a1);
NOT_DECOMPILED void DockHelpers__Func_2152A20(void);
NOT_DECOMPILED void DockHelpers__Func_2152A30(void);
NOT_DECOMPILED void DockHelpers__Func_2152A40(void);
NOT_DECOMPILED void DockHelpers__GetMapBackConfig(void);
NOT_DECOMPILED void DockHelpers__Func_2152A60(void);
NOT_DECOMPILED void DockHelpers__Func_2152A70(void);
NOT_DECOMPILED void DockHelpers__Func_2152A7C(void);
NOT_DECOMPILED void DockHelpers__Func_2152A88(void);
NOT_DECOMPILED void DockHelpers__Func_2152A94(void);
NOT_DECOMPILED void DockHelpers__Func_2152AA0(void);
NOT_DECOMPILED void DockHelpers__Func_2152AAC(void);
NOT_DECOMPILED void DockHelpers__Func_2152AB8(void);
NOT_DECOMPILED void DockHelpers__Func_2152AC4(void);
NOT_DECOMPILED void DockHelpers__Func_2152AD0(void);
NOT_DECOMPILED void DockHelpers__Func_2152ADC(void);
NOT_DECOMPILED void DockHelpers__Func_2152AE8(void);
NOT_DECOMPILED void DockHelpers__Func_2152AF4(void);
NOT_DECOMPILED void DockHelpers__Func_2152B00(void);
NOT_DECOMPILED void DockHelpers__GetNpcMessageInfo(void);
NOT_DECOMPILED void DockHelpers__Func_2152B1C(void);
NOT_DECOMPILED void DockHelpers__Func_2152B2C(void);
NOT_DECOMPILED void DockHelpers__Func_2152B38(void);
NOT_DECOMPILED void DockHelpers__Func_2152B48(void);
NOT_DECOMPILED void DockHelpers__Func_2152B58(void);
NOT_DECOMPILED void DockHelpers__GetAnnounceConfig(void);
NOT_DECOMPILED void DockHelpers__GetOptionsMessageInfo(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_DOCKHELPERS_H