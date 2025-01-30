#ifndef RUSH_EXBOSS_H
#define RUSH_EXBOSS_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// ENUMS
// --------------------

enum ExBossAnimIDs_
{
    bse_body_fw0,
    bse_body_mete0,
    bse_body_mete1,
    bse_body_mete2,
    bse_body_fire0,
    bse_body_fire1,
    bse_body_fire2,
    bse_body_fire3,
    bse_body_fire4,
    bse_body_homi0,
    bse_body_homi1,
    bse_body_homi2,
    bse_body_dora0,
    bse_body_dora1,
    bse_body_dora2,
    bse_body_wave0,
    bse_body_wave1,
    bse_body_wave2,
    bse_body_wave3,
    bse_body_wave4,
    bse_body_line0,
    bse_body_line1,
    bse_body_line2,
    bse_body_dmg0,
    bse_body_dmg1,
    bse_body_bdmg0,
    bse_body_bdmg1,
};
typedef u16 ExBossAnimIDs;

// --------------------
// STRUCTS
// --------------------

typedef struct exBossSysAdminTask_
{
    u8 field_0;
    u8 field_1;
    u8 field_2;
    u8 field_3;
    s32 field_4;
    s32 field_8;
    s32 field_C;
    s32 field_10;
    s32 field_14;
    s32 field_18;
    s32 field_1C;
    s32 field_20;
    s32 field_24;
    s32 field_28;
    s32 field_2C;
    s32 field_30;
    s32 field_34;
    s32 field_38;
    s32 field_3C;
    s32 field_40;
    s16 timer2;
    s16 field_46;
    VecFx32 field_48;
    s16 field_54;
    s16 field_56;
    u16 field_58;
    u16 field_5A;
    s16 field_5C;
    s16 timer;
    s16 field_60;
    s16 health;
    s16 field_64;
    s16 field_66;
    s32 field_68;
    EX_ACTION_NN_WORK aniBoss;
    void (*nextAttackState)(void);
    TaskMain state1;
} exBossSysAdminTask;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void exBossSysAdminTask__RunTaskUnknownEvent(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_StartMete0(void);
NOT_DECOMPILED void exBossSysAdminTask__Func_215DC9C(void);
NOT_DECOMPILED void exBossSysAdminTask__Func_215DCE4(void);
NOT_DECOMPILED void exBossSysAdminTask__Func_215DD2C(void);
NOT_DECOMPILED void exBossSysAdminTask__Func_215DD78(void);
NOT_DECOMPILED void exBossSysAdminTask__Func_215DDC0(void);
NOT_DECOMPILED void exBossSysAdminTask__Func_215DE40(void);
NOT_DECOMPILED void exBossSysAdminTask__Func_215DE88(void);
NOT_DECOMPILED void exBossSysAdminTask__Func_215DEB0(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_FinishMeteorAttack(void);
NOT_DECOMPILED exBossSysAdminTask *exBossSysAdminTask__GetBossWork(void);
NOT_DECOMPILED BOOL exBossSysAdminTask__Func_215DF1C(void);
NOT_DECOMPILED void exBossSysAdminTask__Func_215DF2C(s32 a1, s32 a2);
NOT_DECOMPILED void exBossSysAdminTask__Main_Init(void);
NOT_DECOMPILED void exBossSysAdminTask__Func8(void);
NOT_DECOMPILED void exBossSysAdminTask__Destructor(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_WaitForTitleCard(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_InitialFlee(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_InitialFlee(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_WaitForFlag215DF1C(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_WaitForFlag215DF1C(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_RegenerateHealth(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_RegenerateHealth(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_DragonAttackIdle(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_DragonAttackIdle(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_StartFw0_3(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_StartFw0_3(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_StartFw0_4(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_StartFw0_4(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_StartFw0_5(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_StartFw0_5(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_StartFw0_6(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_StartFw0_6(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_StartFw0_7(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_StartFw0_7(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_StartFw0_8(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_StartFw0_8(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_StartFw0_9(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_StartFw0_9(void);
NOT_DECOMPILED void exBossSysAdminTask__Action_StartFw0_10(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_StartFw0_10(void);
NOT_DECOMPILED void exBossSysAdminTask__SetNextTimer(void);
NOT_DECOMPILED void exBossSysAdminTask__Main_Blank(void);
NOT_DECOMPILED void exBossSysAdminTask__Create(void);
NOT_DECOMPILED void exBossSysAdminTask__GetSingleton(void);
NOT_DECOMPILED void exBossSysAdminTask__Destroy(void);
NOT_DECOMPILED void exBossSysAdminBiforTask__Main_Init(void);
NOT_DECOMPILED void exBossSysAdminBiforTask__Func8(void);
NOT_DECOMPILED void exBossSysAdminBiforTask__Destructor(void);
NOT_DECOMPILED void exBossSysAdminBiforTask__Main_PickNextAttack(void);
NOT_DECOMPILED void exBossSysAdminBiforTask__Main_WaitForAttack(void);
NOT_DECOMPILED void exBossSysAdminBiforTask__Create(void);
NOT_DECOMPILED void exBossSysAdminTask__MoveRandom(void);
NOT_DECOMPILED void exBossSysAdminTask__MoveL(void);
NOT_DECOMPILED void exBossSysAdminTask__MoveR(void);

#endif // RUSH_EXBOSS_H
