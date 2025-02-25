#ifndef RUSH_SCRIPT_H
#define RUSH_SCRIPT_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

enum CutsceneID
{
    CUTSCENE_NONE,
    CUTSCENE_OPENING,
    CUTSCENE_MARINE_APPEARS,
    CUTSCENE_ENCOUNTER,
    CUTSCENE_RICKETY_SHIP_LAUNCH,
    CUTSCENE_GET_THE_MATERIAL,
    CUTSCENE_FOUND_MATERIAL,
    CUTSCENE_WAVE_CYCLONE_COMPLETE,
    CUTSCENE_WAVE_CYCLONE_LAUNCH,
    CUTSCENE_ARRIVAL_AT_PLANT_KINGDOM,
    CUTSCENE_GHOST_REX_APPOACHES,
    CUTSCENE_FOUND_GREEN_MATERIAL,
    CUTSCENE_ARRIVAL_AT_MACHINE_LABYRINTH,
    CUTSCENE_IMPOSING_GHOST_PENDULUM,
    CUTSCENE_FOUND_BRONZE_MATERIAL,
    CUTSCENE_OCEAN_TORNADO_COMPLETE,
    CUTSCENE_OCEAN_TORNADO_LAUNCH,
    CUTSCENE_JOHNNY_APPEARS,
    CUTSCENE_CORAL_CAVE_SURFACES_PART1, // text-based cutscene (part 1)
    CUTSCENE_CORAL_CAVE_APPEARS,        // the island itself appears
    CUTSCENE_CORAL_CAVE_SURFACES_PART2, // text-based cutscene (part 2)
    CUTSCENE_ARRIVAL_AT_CORAL_CAVE,
    CUTSCENE_WHISKER_APPEARS_3D, // 3D part of the cutscene
    CUTSCENE_WHISKER_APPEARS_2D, // 2D/text-based part of the cutscene
    CUTSCENE_REUNION_3D,         // 3D part of the cutscene
    CUTSCENE_REUNION_2D,         // 2D/text-based part of the cutscene
    CUTSCENE_THIS_IS_BLAZES_WORLD,
    CUTSCENE_BUILDING_A_RADIO_TOWER,
    CUTSCENE_STRANGE_ELECTROMAGNETIC_SIGNAL,
    CUTSCENE_KYLOK_ISLAND_EMPTY,
    CUTSCENE_KYLOK_FOUND,
    CUTSCENE_DAIKUN_ISLAND_EMPTY,
    CUTSCENE_ARRIVAL_AT_HAUNTED_SHIP,
    CUTSCENE_HAIR_RAISING_GHOST_PIRATE,
    CUTSCENE_HOVER_WHAT_HAUNTED_SHIP, // the part of the cutscene when they're in haunted ship
    CUTSCENE_HOVER_WHAT_BOAT,         // the part of the cutscene when they're back on their own ship
    CUTSCENE_AQUA_BLAST_COMPLETE,
    CUTSCENE_AQUA_BLAST_LAUNCH,
    CUTSCENE_ARRIVAL_AT_BLIZZARD_PEAKS,
    CUTSCENE_FREEZING_GHOST_WHALE,
    CUTSCENE_LEGENDARY_ANCIENT_RUINS_1,
    CUTSCENE_PIRATE_HIDEOUT_IN_DEPTHS_1,
    CUTSCENE_DAIKUN_DISCOVERED,
    CUTSCENE_TO_SKY_BABYLON,
    CUTSCENE_ARRIVAL_AT_SKY_BABYLON,
    CUTSCENE_LEGENDARY_ANCIENT_RUINS_2,
    CUTSCENE_PIRATE_HIDEOUT_IN_DEPTHS_2,
    CUTSCENE_EARTHQUAKE,
    CUTSCENE_DEEP_TYPHOON_COMPLETE,
    CUTSCENE_DEEP_TYPHOON_LAUNCH,
    CUTSCENE_PIRATES_ISLAND_DISCOVERED,
    CUTSCENE_MYSTERIOUS_MARKER_NO_1,
    CUTSCENE_MYSTERIOUS_MARKER_NO_2,
    CUTSCENE_CLUE_NO_1,
    CUTSCENE_CLUE_NO_2,
    CUTSCENE_CLUE_NO_3,
    CUTSCENE_COLLECTED_THE_CLUES,
    CUTSCENE_CRUEL_TO_BE_KIND,
    CUTSCENE_INVADING_PIRATES_ISLAND,
    CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_ENTRANCE, // the part of the cutscene when they're in front of the door
    CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_DOOR,     // the part of the cutscene when the door opens
    CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_ARRIVAL,  // the part of the cutscene when they're beyond the door
    CUTSCENE_CLASH_WITH_WHISKER_AND_JOHNNY,
    CUTSCENE_AFTER_THEM,
    CUTSCENE_ARRIVAL_AT_BIG_SWELL,
    CUTSCENE_DUEL_WITH_GHOST_TITAN,
    CUTSCENE_GHOST_TITANS_IMPACT,
    CUTSCENE_ENDING,
    CUTSCENE_EX_PROLOGUE,
    CUTSCENE_EGGMANS_DOUBLE_APPEARANCE_3D, // 3D part of the cutscene
    CUTSCENE_EGGMANS_DOUBLE_APPEARANCE_2D, // 2D/text-based part of the cutscene
    CUTSCENE_MAGMA_HURRICANE_COMPLETE,
    CUTSCENE_MAGMA_HURRICANE_LAUNCH,
    CUTSCENE_EGGMANS_THE_SOURCE_OF_POWER_3D, // 3D part of the cutscene
    CUTSCENE_EGGMANS_THE_SOURCE_OF_POWER_2D, // 2D/text-based part of the cutscene
    CUTSCENE_SONIC_AND_BLAZE_TRANSFORM,
    CUTSCENE_FINAL_BATTLE_EGG_WIZARD,
    CUTSCENE_EGG_WIZARD_DESTROYED,
    CUTSCENE_EX_ENDING,
    CUTSCENE_WE_WILL_MEET_AGAIN,

    CUTSCENE_COUNT,

    CUTSCENE_INVALID = 0xFFFF,
};

// --------------------
// STRUCTS
// --------------------

typedef struct AYKHeader_
{
    u32 signature;

    // .text section
    u32 textSize;
    u32 textOffset;
    u32 startAddr; // address of 'main' relative to the text section

    // .rodata section (string constants)
    u32 rodataSize;
    u32 rodataAddr;

    // .data section (int constants)
    u32 dataSize;
    u32 dataAddr;

    // .bss section
    u32 bssSize;

    // .text data
    u32 data[1];
} CutsceneScriptHeader;

// --------------------
// FUNCTIONS
// --------------------

void *LoadCutsceneScriptFile(u32 cutsceneID);
u32 GetScriptStartParam(u32 cutsceneID);
u32 GetScriptCanSkipFlagIn(void);
u32 GetScriptCanSkipFlagOut(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_SCRIPT_H
