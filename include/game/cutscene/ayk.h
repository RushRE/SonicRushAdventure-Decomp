#ifndef RUSH2_AYK_H
#define RUSH2_AYK_H

#include <global.h>

// --------------------
// ENUMS
// --------------------

enum CutsceneID
{
    CUTSCENE_0,
    CUTSCENE_1,
    CUTSCENE_2,
    CUTSCENE_3,
    CUTSCENE_4,
    CUTSCENE_5,
    CUTSCENE_6,
    CUTSCENE_7,
    CUTSCENE_8,
    CUTSCENE_9,
    CUTSCENE_10,
    CUTSCENE_11,
    CUTSCENE_12,
    CUTSCENE_13,
    CUTSCENE_14,
    CUTSCENE_15,
    CUTSCENE_16,
    CUTSCENE_17,
    CUTSCENE_18,
    CUTSCENE_19,
    CUTSCENE_20,
    CUTSCENE_21,
    CUTSCENE_22,
    CUTSCENE_23,
    CUTSCENE_24,
    CUTSCENE_25,
    CUTSCENE_26,
    CUTSCENE_27,
    CUTSCENE_28,
    CUTSCENE_29,
    CUTSCENE_30,
    CUTSCENE_31,
    CUTSCENE_32,
    CUTSCENE_33,
    CUTSCENE_34,
    CUTSCENE_35,
    CUTSCENE_36,
    CUTSCENE_37,
    CUTSCENE_38,
    CUTSCENE_39,
    CUTSCENE_40,
    CUTSCENE_41,
    CUTSCENE_42,
    CUTSCENE_43,
    CUTSCENE_44,
    CUTSCENE_45,
    CUTSCENE_46,
    CUTSCENE_47,
    CUTSCENE_48,
    CUTSCENE_49,
    CUTSCENE_50,
    CUTSCENE_51,
    CUTSCENE_52,
    CUTSCENE_53,
    CUTSCENE_54,
    CUTSCENE_55,
    CUTSCENE_56,
    CUTSCENE_57,
    CUTSCENE_58,
    CUTSCENE_59,
    CUTSCENE_60,
    CUTSCENE_61,
    CUTSCENE_62,
    CUTSCENE_63,
    CUTSCENE_64,
    CUTSCENE_65,
    CUTSCENE_66,
    CUTSCENE_67,
    CUTSCENE_68,
    CUTSCENE_69,
    CUTSCENE_70,
    CUTSCENE_71,
    CUTSCENE_72,
    CUTSCENE_73,
    CUTSCENE_74,
    CUTSCENE_75,
    CUTSCENE_76,
    CUTSCENE_77,
    CUTSCENE_78,
    CUTSCENE_79,

    CUTSCENE_COUNT,

    CUTSCENE_INVALID = 0xFFFF,
};

// --------------------
// STRUCTS
// --------------------

typedef struct AYKHeader_
{
    u32 signature;
    u32 block1Offset;
    u32 block2Offset;
    u32 block3Offset;
    u32 block4Offset;
    u32 block5Offset;
    u32 blockUserSize;
    u32 *blockUserPtr;
    u32 size2;
    u32 data[1];
} AYKHeader;

// --------------------
// FUNCTIONS
// --------------------

void *LoadAYK(u32 cutsceneID);
u32 GetAYKUnknown(u32 cutsceneID);
u32 GetAYKUnknown2(void);
u32 GetAYKUnknown3(void);

#endif // RUSH2_AYK_H
