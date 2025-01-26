#ifndef RUSH_EXBOSS_H
#define RUSH_EXBOSS_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// ENUMS
// --------------------

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
    s32 field_44;
    s32 field_48;
    s32 field_4C;
    s32 field_50;
    s16 field_54;
    s16 field_56;
    u16 field_58;
    u16 field_5A;
    s16 field_5C;
    s16 field_5E;
    s16 field_60;
    s16 field_62;
    s16 field_64;
    s16 field_66;
    s32 field_68;
    EX_ACTION_NN_WORK aniBoss;
    u32 field_548;
    TaskMain field_54C;
} exBossSysAdminTask;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void ExBossSysAdminTask__Func_215DC14(void);
NOT_DECOMPILED void ExBossSysAdminTask__BossMain_215DC2C(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215DC9C(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215DCE4(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215DD2C(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215DD78(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215DDC0(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215DE40(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215DE88(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215DEB0(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215DEF8(void);
NOT_DECOMPILED exBossSysAdminTask *ExBossSysAdminTask__GetBossWork(void);
NOT_DECOMPILED BOOL ExBossSysAdminTask__Func_215DF1C(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215DF2C(s32 a1, s32 a2);
NOT_DECOMPILED void exBossSysAdminTask__Main(void);
NOT_DECOMPILED void exBossSysAdminTask__Func8(void);
NOT_DECOMPILED void exBossSysAdminTask__Destructor(void);
NOT_DECOMPILED void ExBossSysAdminTask__Main_215E084(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215E0CC(void);
NOT_DECOMPILED void ExBossSysAdminTask__Main_215E0EC(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215E15C(void);
NOT_DECOMPILED void ExBossSysAdminTask__Main_215E184(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215E1B0(void);
NOT_DECOMPILED void ExBossSysAdminTask__Main_215E1E8(void);
NOT_DECOMPILED void ExBossSysAdminTask__BossMain_215E298(void);
NOT_DECOMPILED void ExBossSysAdminTask__Main_215E2D4(void);
NOT_DECOMPILED void ExBossSysAdminTask__BossMain_215E420(void);
NOT_DECOMPILED void ExBossSysAdminTask__Main_215E458(void);
NOT_DECOMPILED void ExBossSysAdminTask__BossMain_215E580(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215E5B8(void);
NOT_DECOMPILED void ExBossSysAdminTask__BossMain_215E688(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215E6C4(void);
NOT_DECOMPILED void ExBossSysAdminTask__BossMain_215E7FC(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215E834(void);
NOT_DECOMPILED void ExBossSysAdminTask__Main_215E99C(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215E9D4(void);
NOT_DECOMPILED void ExBossSysAdminTask__BossMain_215EAA4(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215EAE0(void);
NOT_DECOMPILED void ExBossSysAdminTask__Main_215EC18(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215EC50(void);
NOT_DECOMPILED void ExBossSysAdminTask__BossMain_215EDF8(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215EE30(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215EF00(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215EF98(void);
NOT_DECOMPILED void exBossSysAdminTask__Create(void);
NOT_DECOMPILED void ExBossSysAdminTask__GetSingleton(void);
NOT_DECOMPILED void ExBossSysAdminTask__Destroy(void);
NOT_DECOMPILED void exBossSysAdminBiforTask__Main(void);
NOT_DECOMPILED void exBossSysAdminBiforTask__Func8(void);
NOT_DECOMPILED void exBossSysAdminBiforTask__Destructor(void);
NOT_DECOMPILED void exBossSysAdminBiforTask__Main_215F0C8(void);
NOT_DECOMPILED void exBossSysAdminBiforTask__Main_215F7CC(void);
NOT_DECOMPILED void exBossSysAdminBiforTask__Create(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215F88C(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215FA10(void);
NOT_DECOMPILED void ExBossSysAdminTask__Func_215FA98(void);

#endif // RUSH_EXBOSS_H
