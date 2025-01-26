#ifndef RUSH_EXPLAYER_H
#define RUSH_EXPLAYER_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// ENUMS
// --------------------

enum ExPlayerCharacter
{
    EXPLAYER_CHARACTER_SONIC,
    EXPLAYER_CHARACTER_BLAZE,
    
    EXPLAYER_CHARACTER_COUNT,
};

// --------------------
// STRUCTS
// --------------------

struct exPlayerUnknown1
{
    u16 field_0;
    u16 prevAnim;
    EX_ACTION_NN_WORK manager;
};

typedef struct exPlayerAdminTaskWorker_
{
    u8 field_0;
    u8 field_1;
    u8 field_2;
    u8 field_3;
    u32 field_4;
    s32 field_8;
    s32 field_C;
    u8 field_10;
    u8 field_11;
    u8 field_12;
    u8 field_13;
    u8 field_14;
    u8 field_15;
    u8 field_16;
    u8 field_17;
    u8 field_18;
    u8 field_19;
    u8 field_1A;
    u8 field_1B;
    s32 field_1C;
    s16 field_20;
    u8 field_22;
    u8 field_23;
    u8 field_24;
    u8 field_25;
    u8 field_26;
    u8 field_27;
    u8 field_28;
    u8 field_29;
    u8 field_2A;
    u8 field_2B;
    u8 field_2C;
    u8 field_2D;
    u8 field_2E;
    u8 field_2F;
    u8 field_30;
    u8 field_31;
    u8 field_32;
    u8 field_33;
    s32 field_34;
    s32 field_38;
    s16 field_3C;
    s16 field_3E;
    s16 field_40;
    s16 field_42;
    s16 field_44;
    s16 field_46;
    u8 field_48;
    u8 field_49;
    u8 field_4A;
    u8 field_4B;
    u8 field_4C;
    u8 field_4D;
    u8 field_4E;
    u8 field_4F;
    u8 field_50;
    u8 field_51;
    u8 field_52;
    u8 field_53;
    u8 field_54;
    u8 field_55;
    u8 field_56;
    u8 field_57;
    u8 field_58;
    u8 field_59;
    u8 field_5A;
    u8 field_5B;
    u8 field_5C;
    u8 field_5D;
    u8 field_5E;
    u8 field_5F;
    s16 field_60;
    u8 field_62;
    u8 field_63;
    u8 field_64;
    u8 field_65;
    u8 field_66;
    u8 field_67;
    u8 field_68;
    u8 field_69;
    struct
    {
        u8 value_1 : 1;
        u8 value_2 : 1;
        u8 value_4 : 1;
        u8 value_8 : 1;
        u8 value_10 : 1;
        u8 value_20 : 1;
        u8 value_40 : 1;
        u8 value_80 : 1;
    } activeCharacter;
    u8 field_6B;
} exPlayerAdminTaskWorker;

typedef struct exPlayerAdminTask_
{
    s32 field_0;
    exPlayerAdminTaskWorker *worker;
    struct exPlayerUnknown1 *aniSonic;
    struct exPlayerUnknown1 *aniBlaze;
    EX_ACTION_NN_WORK *activeModelMain;
    EX_ACTION_NN_WORK *activeModelSub;
    EX_ACTION_BAC3D_WORK spriteSonic;
    EX_ACTION_BAC3D_WORK spriteBlaze;
    EX_ACTION_BAC3D_WORK *activeSprite;
    EX_ACTION_TRAIL_WORK trailA;
    EX_ACTION_TRAIL_WORK trailB;
} exPlayerAdminTask;

// --------------------
// FUNCTIONS
// --------------------

// ExPlayer helpers
NOT_DECOMPILED exPlayerAdminTaskWorker *exPlayerAdminTask__GetUnknown2(void);

// ExPlayerScreenMover
NOT_DECOMPILED void exPlayerScreenMoveTask__SetFollowX(void);
NOT_DECOMPILED void exPlayerScreenMoveTask__Main(void);
NOT_DECOMPILED void exPlayerScreenMoveTask__Func8(void);
NOT_DECOMPILED void exPlayerScreenMoveTask__Destructor(void);
NOT_DECOMPILED void exPlayerScreenMoveTask__Main_216E478(void);
NOT_DECOMPILED void exPlayerScreenMoveTask__Create(void);

// ExPlayer
NOT_DECOMPILED void exPlayerAdminTask__Main(void);
NOT_DECOMPILED void exPlayerAdminTask__Func8(void);
NOT_DECOMPILED void exPlayerAdminTask__Destructor(void);
NOT_DECOMPILED void exPlayerAdminTask__Main_216E70C(void);
NOT_DECOMPILED void exPlayerAdminTask__Main_216E744(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216E790(void);
NOT_DECOMPILED void exPlayerAdminTask__Main_216E7B4(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216E7F4(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216E8F0(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216E938(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216EA68(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216EAAC(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216EB28(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216ECAC(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216ED94(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216EDF4(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216EEE4(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216EFD4(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216F184(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216F254(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216F284(void);
NOT_DECOMPILED void exPlayerAdminTask__Action_Die(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216F514(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216F5A4(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216F60C(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216F6B0(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216F6DC(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216F704(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216F824(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216F8D4(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216F990(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216FA14(void);
NOT_DECOMPILED void exPlayerAdminTask__Action_CreateBarrier(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216FAAC(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216FC38(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216FCBC(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216FD10(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216FD60(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216FDD4(void);
NOT_DECOMPILED void exPlayerAdminTask__Action_ShootFireball(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216FE6C(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_216FEAC(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_2170088(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_21700D4(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_217023C(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_2170284(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_21702C4(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_2170320(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_217035C(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_2170518(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_2170548(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_21705D8(void);
NOT_DECOMPILED void exPlayerAdminTask__HandleMovement(void);
NOT_DECOMPILED void exPlayerAdminTask__HandlePlayerSwap(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_2170CC4(void);
NOT_DECOMPILED void exPlayerAdminTask__HandleControl(void);
NOT_DECOMPILED void exPlayerAdminTask__DelayCallback(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_2171624(void);
NOT_DECOMPILED void exPlayerAdminTask__Create(void);
NOT_DECOMPILED void exPlayerAdminTask__Destroy_2171730(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_217175C(void);
NOT_DECOMPILED void exPlayerAdminTask__LoadSuperSonicAssets(void);
NOT_DECOMPILED void exPlayerAdminTask__SetSuperSonicAnimation(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_2171954(void);
NOT_DECOMPILED void exPlayerAdminTask__GetSonicAssets(void);
NOT_DECOMPILED void exPlayerAdminTask__LoadSonicAssets(void);
NOT_DECOMPILED void exPlayerAdminTask__SetSonicAnimation(void);
NOT_DECOMPILED void exPlayerAdminTask__Func_2171B80(void);

#endif // RUSH_EXPLAYER_H
