#include <game/cutscene/script.h>
#include <cutscene/cutsceneScript.h>
#include <game/file/archiveFile.h>

// --------------------
// ENUMS
// --------------------

enum ScriptFileID
{
    SCRIPT_NONE,
    SCRIPT_PLDM_00,
    SCRIPT_PLDM_01,
    SCRIPT_TKDM_00,
    SCRIPT_TKDM_01,
    SCRIPT_PTDM_00,
    SCRIPT_UNKNOWN_1, // ???
    SCRIPT_UNKNOWN_2, // ???
};

// --------------------
// STRUCTS
// --------------------

struct CutsceneInfo
{
    u32 scriptID;
    u32 startParam;
};

struct ScriptFile
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

static const struct CutsceneInfo cutsceneList[CUTSCENE_COUNT] = {
    [CUTSCENE_NONE]                               = { .scriptID = SCRIPT_UNKNOWN_2, .startParam = 0x00000000 },
    [CUTSCENE_OPENING]                            = { .scriptID = SCRIPT_PLDM_00, .startParam = 0x10000022 },
    [CUTSCENE_MARINE_APPEARS]                     = { .scriptID = SCRIPT_PLDM_01, .startParam = 0x10000043 },
    [CUTSCENE_ENCOUNTER]                          = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000BF },
    [CUTSCENE_RICKETY_SHIP_LAUNCH]                = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000C0 },
    [CUTSCENE_GET_THE_MATERIAL]                   = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000C1 },
    [CUTSCENE_FOUND_MATERIAL]                     = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000C2 },
    [CUTSCENE_WAVE_CYCLONE_COMPLETE]              = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000C3 },
    [CUTSCENE_WAVE_CYCLONE_LAUNCH]                = { .scriptID = SCRIPT_PLDM_01, .startParam = 0x10000044 },
    [CUTSCENE_ARRIVAL_AT_PLANT_KINGDOM]           = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000C4 },
    [CUTSCENE_GHOST_REX_APPOACHES]                = { .scriptID = SCRIPT_PLDM_01, .startParam = 0x10000045 },
    [CUTSCENE_FOUND_GREEN_MATERIAL]               = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000C5 },
    [CUTSCENE_ARRIVAL_AT_MACHINE_LABYRINTH]       = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000C6 },
    [CUTSCENE_IMPOSING_GHOST_PENDULUM]            = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000C7 },
    [CUTSCENE_FOUND_BRONZE_MATERIAL]              = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000C8 },
    [CUTSCENE_OCEAN_TORNADO_COMPLETE]             = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000C9 },
    [CUTSCENE_OCEAN_TORNADO_LAUNCH]               = { .scriptID = SCRIPT_PLDM_01, .startParam = 0x10000046 },
    [CUTSCENE_JOHNNY_APPEARS]                     = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000CA },
    [CUTSCENE_CORAL_CAVE_SURFACES_PART1]          = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000CB },
    [CUTSCENE_CORAL_CAVE_APPEARS]                 = { .scriptID = SCRIPT_PLDM_01, .startParam = 0x10000047 },
    [CUTSCENE_CORAL_CAVE_SURFACES_PART2]          = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000CC },
    [CUTSCENE_ARRIVAL_AT_CORAL_CAVE]              = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000CD },
    [CUTSCENE_WHISKER_APPEARS_3D]                 = { .scriptID = SCRIPT_PTDM_00, .startParam = 0x100000E3 },
    [CUTSCENE_WHISKER_APPEARS_2D]                 = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000CE },
    [CUTSCENE_REUNION_3D]                         = { .scriptID = SCRIPT_PTDM_00, .startParam = 0x100000E4 },
    [CUTSCENE_REUNION_2D]                         = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000CF },
    [CUTSCENE_THIS_IS_BLAZES_WORLD]               = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000D0 },
    [CUTSCENE_BUILDING_A_RADIO_TOWER]             = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000D1 },
    [CUTSCENE_STRANGE_ELECTROMAGNETIC_SIGNAL]     = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000D2 },
    [CUTSCENE_KYLOK_ISLAND_EMPTY]                 = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000D3 },
    [CUTSCENE_KYLOK_FOUND]                        = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000D4 },
    [CUTSCENE_DAIKUN_ISLAND_EMPTY]                = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000D5 },
    [CUTSCENE_ARRIVAL_AT_HAUNTED_SHIP]            = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000D6 },
    [CUTSCENE_HAIR_RAISING_GHOST_PIRATE]          = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000D7 },
    [CUTSCENE_HOVER_WHAT_HAUNTED_SHIP]            = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000D8 },
    [CUTSCENE_HOVER_WHAT_BOAT]                    = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000D9 },
    [CUTSCENE_AQUA_BLAST_COMPLETE]                = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000DA },
    [CUTSCENE_AQUA_BLAST_LAUNCH]                  = { .scriptID = SCRIPT_PLDM_01, .startParam = 0x10000048 },
    [CUTSCENE_ARRIVAL_AT_BLIZZARD_PEAKS]          = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000DB },
    [CUTSCENE_FREEZING_GHOST_WHALE]               = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000DC },
    [CUTSCENE_LEGENDARY_ANCIENT_RUINS_1]          = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000DD },
    [CUTSCENE_PIRATE_HIDEOUT_IN_DEPTHS_1]         = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000DE },
    [CUTSCENE_DAIKUN_DISCOVERED]                  = { .scriptID = SCRIPT_TKDM_00, .startParam = 0x100000DF },
    [CUTSCENE_TO_SKY_BABYLON]                     = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000BC },
    [CUTSCENE_ARRIVAL_AT_SKY_BABYLON]             = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000BD },
    [CUTSCENE_LEGENDARY_ANCIENT_RUINS_2]          = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000BE },
    [CUTSCENE_PIRATE_HIDEOUT_IN_DEPTHS_2]         = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000BF },
    [CUTSCENE_EARTHQUAKE]                         = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000C0 },
    [CUTSCENE_DEEP_TYPHOON_COMPLETE]              = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000C1 },
    [CUTSCENE_DEEP_TYPHOON_LAUNCH]                = { .scriptID = SCRIPT_PLDM_01, .startParam = 0x1000004A },
    [CUTSCENE_PIRATES_ISLAND_DISCOVERED]          = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000C2 },
    [CUTSCENE_MYSTERIOUS_MARKER_NO_1]             = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000C3 },
    [CUTSCENE_MYSTERIOUS_MARKER_NO_2]             = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000C4 },
    [CUTSCENE_CLUE_NO_1]                          = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000C5 },
    [CUTSCENE_CLUE_NO_2]                          = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000C6 },
    [CUTSCENE_CLUE_NO_3]                          = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000C7 },
    [CUTSCENE_COLLECTED_THE_CLUES]                = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000C8 },
    [CUTSCENE_CRUEL_TO_BE_KIND]                   = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000C9 },
    [CUTSCENE_INVADING_PIRATES_ISLAND]            = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000CA },
    [CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_ENTRANCE] = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000CB },
    [CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_DOOR]     = { .scriptID = SCRIPT_PLDM_01, .startParam = 0x10000049 },
    [CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_ARRIVAL]  = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000CC },
    [CUTSCENE_CLASH_WITH_WHISKER_AND_JOHNNY]      = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000CD },
    [CUTSCENE_AFTER_THEM]                         = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000CE },
    [CUTSCENE_ARRIVAL_AT_BIG_SWELL]               = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000CF },
    [CUTSCENE_DUEL_WITH_GHOST_TITAN]              = { .scriptID = SCRIPT_PLDM_01, .startParam = 0x1000004B },
    [CUTSCENE_GHOST_TITANS_IMPACT]                = { .scriptID = SCRIPT_PLDM_01, .startParam = 0x1000004C },
    [CUTSCENE_ENDING]                             = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000D0 },
    [CUTSCENE_EX_PROLOGUE]                        = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000D1 },
    [CUTSCENE_EGGMANS_DOUBLE_APPEARANCE_3D]       = { .scriptID = SCRIPT_PTDM_00, .startParam = 0x100000E5 },
    [CUTSCENE_EGGMANS_DOUBLE_APPEARANCE_2D]       = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000D2 },
    [CUTSCENE_MAGMA_HURRICANE_COMPLETE]           = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000D3 },
    [CUTSCENE_MAGMA_HURRICANE_LAUNCH]             = { .scriptID = SCRIPT_PLDM_01, .startParam = 0x1000004D },
    [CUTSCENE_EGGMANS_THE_SOURCE_OF_POWER_3D]     = { .scriptID = SCRIPT_PTDM_00, .startParam = 0x100000E6 },
    [CUTSCENE_EGGMANS_THE_SOURCE_OF_POWER_2D]     = { .scriptID = SCRIPT_TKDM_01, .startParam = 0x100000D4 },
    [CUTSCENE_SONIC_AND_BLAZE_TRANSFORM]          = { .scriptID = SCRIPT_PLDM_01, .startParam = 0x1000004E },
    [CUTSCENE_FINAL_BATTLE_EGG_WIZARD]            = { .scriptID = SCRIPT_PTDM_00, .startParam = 0x100000E7 },
    [CUTSCENE_EGG_WIZARD_DESTROYED]               = { .scriptID = SCRIPT_PTDM_00, .startParam = 0x100000E8 },
    [CUTSCENE_EX_ENDING]                          = { .scriptID = SCRIPT_PTDM_00, .startParam = 0x100000EA },
    [CUTSCENE_WE_WILL_MEET_AGAIN]                 = { .scriptID = SCRIPT_PLDM_01, .startParam = 0x10000050 },
};

static struct ScriptFile scriptList[CUTSCENE_COUNT] = {
    [SCRIPT_NONE]    = { .file = "", .extension = "" },
    [SCRIPT_PLDM_00] = { .file = "ayk/pldm00", .extension = "_lz7.ayk" },
    [SCRIPT_PLDM_01] = { .file = "ayk/pldm01", .extension = "_lz7.ayk" },
    [SCRIPT_TKDM_00] = { .file = "ayk/tkdm00", .extension = "_lz7.ayk" },
    [SCRIPT_TKDM_01] = { .file = "ayk/tkdm01", .extension = "_lz7.ayk" },
    [SCRIPT_PTDM_00] = { .file = "ayk/ptdm00", .extension = "_lz7.ayk" },
};

// --------------------
// FUNCTIONS
// --------------------

void *LoadCutsceneScriptFile(u32 cutsceneID)
{
    char filePath[32] = { 0 };

    struct ScriptFile *script = &scriptList[cutsceneList[cutsceneID].scriptID];
    STD_CopyString(filePath, script->file);
    STD_ConcatenateString(filePath, "_jpn");
    STD_ConcatenateString(filePath, script->extension);

    return ArchiveFile__Load(filePath, ARCHIVEFILE_ID_NONE, ARCHIVEFILE_AUTO_ALLOC_HEAD_USER, ARCHIVEFILE_FLAG_IS_COMPRESSED, NULL);
}

u32 GetScriptStartParam(u32 cutsceneID)
{
    return cutsceneList[cutsceneID].startParam;
}

u32 GetScriptCanSkipFlagIn(void)
{
    return 6; // 6 * sizeof(s32)
}

u32 GetScriptCanSkipFlagOut(void)
{
    return 7; // 7 * sizeof(s32)
}
