#include <game/cutscene/ayk.h>
#include <game/file/archiveFile.h>

// --------------------
// ENUMS
// --------------------

enum AYKFileID
{
    AYK_NONE,
    AYK_PLDM_00,
    AYK_PLDM_01,
    AYK_TKDM_00,
    AYK_TKDM_01,
    AYK_PTDM_00,
    AYK_UNKNOWN_1,
    AYK_UNKNOWN_2,
};

// --------------------
// STRUCTS
// --------------------

struct AYKUnknown
{
    u32 aykID;
    u32 unknown;
};

struct AYKRef
{
    const char *file;
    const char *extension;
};

// --------------------
// VARIABLES
// --------------------

// string order matching stuff
#ifndef NON_MATCHING
static const char *aAykNone   = "";
static const char *aLz7Ayk    = "_lz7.ayk";
static const char *aAykPldm00 = "ayk/pldm00";
static const char *aAykPldm01 = "ayk/pldm01";
static const char *aAykTkdm00 = "ayk/tkdm00";
static const char *aAykTkdm01 = "ayk/tkdm01";
static const char *aAykPtdm00 = "ayk/ptdm00";
#endif

static const struct AYKUnknown cutsceneList[CUTSCENE_COUNT] = {
    [CUTSCENE_0] = { .aykID = AYK_UNKNOWN_2, .unknown = 0x00000000 }, [CUTSCENE_1] = { .aykID = AYK_PLDM_00, .unknown = 0x10000022 },
    [CUTSCENE_2] = { .aykID = AYK_PLDM_01, .unknown = 0x10000043 },   [CUTSCENE_3] = { .aykID = AYK_TKDM_00, .unknown = 0x100000BF },
    [CUTSCENE_4] = { .aykID = AYK_TKDM_00, .unknown = 0x100000C0 },   [CUTSCENE_5] = { .aykID = AYK_TKDM_00, .unknown = 0x100000C1 },
    [CUTSCENE_6] = { .aykID = AYK_TKDM_00, .unknown = 0x100000C2 },   [CUTSCENE_7] = { .aykID = AYK_TKDM_00, .unknown = 0x100000C3 },
    [CUTSCENE_8] = { .aykID = AYK_PLDM_01, .unknown = 0x10000044 },   [CUTSCENE_9] = { .aykID = AYK_TKDM_00, .unknown = 0x100000C4 },
    [CUTSCENE_10] = { .aykID = AYK_PLDM_01, .unknown = 0x10000045 },  [CUTSCENE_11] = { .aykID = AYK_TKDM_00, .unknown = 0x100000C5 },
    [CUTSCENE_12] = { .aykID = AYK_TKDM_00, .unknown = 0x100000C6 },  [CUTSCENE_13] = { .aykID = AYK_TKDM_00, .unknown = 0x100000C7 },
    [CUTSCENE_14] = { .aykID = AYK_TKDM_00, .unknown = 0x100000C8 },  [CUTSCENE_15] = { .aykID = AYK_TKDM_00, .unknown = 0x100000C9 },
    [CUTSCENE_16] = { .aykID = AYK_PLDM_01, .unknown = 0x10000046 },  [CUTSCENE_17] = { .aykID = AYK_TKDM_00, .unknown = 0x100000CA },
    [CUTSCENE_18] = { .aykID = AYK_TKDM_00, .unknown = 0x100000CB },  [CUTSCENE_19] = { .aykID = AYK_PLDM_01, .unknown = 0x10000047 },
    [CUTSCENE_20] = { .aykID = AYK_TKDM_00, .unknown = 0x100000CC },  [CUTSCENE_21] = { .aykID = AYK_TKDM_00, .unknown = 0x100000CD },
    [CUTSCENE_22] = { .aykID = AYK_PTDM_00, .unknown = 0x100000E3 },  [CUTSCENE_23] = { .aykID = AYK_TKDM_00, .unknown = 0x100000CE },
    [CUTSCENE_24] = { .aykID = AYK_PTDM_00, .unknown = 0x100000E4 },  [CUTSCENE_25] = { .aykID = AYK_TKDM_00, .unknown = 0x100000CF },
    [CUTSCENE_26] = { .aykID = AYK_TKDM_00, .unknown = 0x100000D0 },  [CUTSCENE_27] = { .aykID = AYK_TKDM_00, .unknown = 0x100000D1 },
    [CUTSCENE_28] = { .aykID = AYK_TKDM_00, .unknown = 0x100000D2 },  [CUTSCENE_29] = { .aykID = AYK_TKDM_00, .unknown = 0x100000D3 },
    [CUTSCENE_30] = { .aykID = AYK_TKDM_00, .unknown = 0x100000D4 },  [CUTSCENE_31] = { .aykID = AYK_TKDM_00, .unknown = 0x100000D5 },
    [CUTSCENE_32] = { .aykID = AYK_TKDM_00, .unknown = 0x100000D6 },  [CUTSCENE_33] = { .aykID = AYK_TKDM_00, .unknown = 0x100000D7 },
    [CUTSCENE_34] = { .aykID = AYK_TKDM_00, .unknown = 0x100000D8 },  [CUTSCENE_35] = { .aykID = AYK_TKDM_00, .unknown = 0x100000D9 },
    [CUTSCENE_36] = { .aykID = AYK_TKDM_00, .unknown = 0x100000DA },  [CUTSCENE_37] = { .aykID = AYK_PLDM_01, .unknown = 0x10000048 },
    [CUTSCENE_38] = { .aykID = AYK_TKDM_00, .unknown = 0x100000DB },  [CUTSCENE_39] = { .aykID = AYK_TKDM_00, .unknown = 0x100000DC },
    [CUTSCENE_40] = { .aykID = AYK_TKDM_00, .unknown = 0x100000DD },  [CUTSCENE_41] = { .aykID = AYK_TKDM_00, .unknown = 0x100000DE },
    [CUTSCENE_42] = { .aykID = AYK_TKDM_00, .unknown = 0x100000DF },  [CUTSCENE_43] = { .aykID = AYK_TKDM_01, .unknown = 0x100000BC },
    [CUTSCENE_44] = { .aykID = AYK_TKDM_01, .unknown = 0x100000BD },  [CUTSCENE_45] = { .aykID = AYK_TKDM_01, .unknown = 0x100000BE },
    [CUTSCENE_46] = { .aykID = AYK_TKDM_01, .unknown = 0x100000BF },  [CUTSCENE_47] = { .aykID = AYK_TKDM_01, .unknown = 0x100000C0 },
    [CUTSCENE_48] = { .aykID = AYK_TKDM_01, .unknown = 0x100000C1 },  [CUTSCENE_49] = { .aykID = AYK_PLDM_01, .unknown = 0x1000004A },
    [CUTSCENE_50] = { .aykID = AYK_TKDM_01, .unknown = 0x100000C2 },  [CUTSCENE_51] = { .aykID = AYK_TKDM_01, .unknown = 0x100000C3 },
    [CUTSCENE_52] = { .aykID = AYK_TKDM_01, .unknown = 0x100000C4 },  [CUTSCENE_53] = { .aykID = AYK_TKDM_01, .unknown = 0x100000C5 },
    [CUTSCENE_54] = { .aykID = AYK_TKDM_01, .unknown = 0x100000C6 },  [CUTSCENE_55] = { .aykID = AYK_TKDM_01, .unknown = 0x100000C7 },
    [CUTSCENE_56] = { .aykID = AYK_TKDM_01, .unknown = 0x100000C8 },  [CUTSCENE_57] = { .aykID = AYK_TKDM_01, .unknown = 0x100000C9 },
    [CUTSCENE_58] = { .aykID = AYK_TKDM_01, .unknown = 0x100000CA },  [CUTSCENE_59] = { .aykID = AYK_TKDM_01, .unknown = 0x100000CB },
    [CUTSCENE_60] = { .aykID = AYK_PLDM_01, .unknown = 0x10000049 },  [CUTSCENE_61] = { .aykID = AYK_TKDM_01, .unknown = 0x100000CC },
    [CUTSCENE_62] = { .aykID = AYK_TKDM_01, .unknown = 0x100000CD },  [CUTSCENE_63] = { .aykID = AYK_TKDM_01, .unknown = 0x100000CE },
    [CUTSCENE_64] = { .aykID = AYK_TKDM_01, .unknown = 0x100000CF },  [CUTSCENE_65] = { .aykID = AYK_PLDM_01, .unknown = 0x1000004B },
    [CUTSCENE_66] = { .aykID = AYK_PLDM_01, .unknown = 0x1000004C },  [CUTSCENE_67] = { .aykID = AYK_TKDM_01, .unknown = 0x100000D0 },
    [CUTSCENE_68] = { .aykID = AYK_TKDM_01, .unknown = 0x100000D1 },  [CUTSCENE_69] = { .aykID = AYK_PTDM_00, .unknown = 0x100000E5 },
    [CUTSCENE_70] = { .aykID = AYK_TKDM_01, .unknown = 0x100000D2 },  [CUTSCENE_71] = { .aykID = AYK_TKDM_01, .unknown = 0x100000D3 },
    [CUTSCENE_72] = { .aykID = AYK_PLDM_01, .unknown = 0x1000004D },  [CUTSCENE_73] = { .aykID = AYK_PTDM_00, .unknown = 0x100000E6 },
    [CUTSCENE_74] = { .aykID = AYK_TKDM_01, .unknown = 0x100000D4 },  [CUTSCENE_75] = { .aykID = AYK_PLDM_01, .unknown = 0x1000004E },
    [CUTSCENE_76] = { .aykID = AYK_PTDM_00, .unknown = 0x100000E7 },  [CUTSCENE_77] = { .aykID = AYK_PTDM_00, .unknown = 0x100000E8 },
    [CUTSCENE_78] = { .aykID = AYK_PTDM_00, .unknown = 0x100000EA },  [CUTSCENE_79] = { .aykID = AYK_PLDM_01, .unknown = 0x10000050 },
};

static struct AYKRef aykList[CUTSCENE_COUNT] = {
    [AYK_NONE]    = { .file = "", .extension = "" },
    [AYK_PLDM_00] = { .file = "ayk/pldm00", .extension = "_lz7.ayk" },
    [AYK_PLDM_01] = { .file = "ayk/pldm01", .extension = "_lz7.ayk" },
    [AYK_TKDM_00] = { .file = "ayk/tkdm00", .extension = "_lz7.ayk" },
    [AYK_TKDM_01] = { .file = "ayk/tkdm01", .extension = "_lz7.ayk" },
    [AYK_PTDM_00] = { .file = "ayk/ptdm00", .extension = "_lz7.ayk" },
};

// --------------------
// FUNCTIONS
// --------------------

void *LoadAYK(u32 cutsceneID)
{
    char filePath[32] = { 0 };

    struct AYKRef *ayk = &aykList[cutsceneList[cutsceneID].aykID];
    STD_CopyString(filePath, ayk->file);
    STD_ConcatenateString(filePath, "_jpn");
    STD_ConcatenateString(filePath, ayk->extension);

    return ArchiveFile__Load(filePath, ARCHIVEFILE_ID_NONE, ARCHIVEFILE_AUTO_ALLOC_HEAD_USER, ARCHIVEFILE_FLAG_IS_COMPRESSED, NULL);
}

u32 GetAYKUnknown(u32 cutsceneID)
{
    return cutsceneList[cutsceneID].unknown;
}

u32 GetAYKUnknown2(void)
{
    return 6;
}

u32 GetAYKUnknown3(void)
{
    return 7;
}
