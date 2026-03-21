#include <hub/hubControl.hpp>
#include <hub/hubConfig.h>
#include <game/save/saveGame.h>

// --------------------
// CONSTANTS/MACROS
// --------------------

#define SAVE_PROGRESS_INVALID (SAVE_PROGRESS_COUNT + 1)

// used to mark the last entry in the npc check tables
#define LAST_TABLE_ENTRY SAVE_PROGRESS_INVALID, FALSE

// --------------------
// VARIABLES
// --------------------

static const HubControlNpcSpawnCheck sNpcSpawnCheck_BaseNext_OldDS[] = {
    { SAVE_PROGRESS_0, TRUE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_BaseNext_Setter[] = {
    { SAVE_PROGRESS_0, TRUE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Base_Tails[] = {
    { SAVE_PROGRESS_0, TRUE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Boat_Gardon[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_16, TRUE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_BaseNext_Hourglass[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_3, TRUE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Submarine_Daikun[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_36, TRUE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Boat_Norman[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_24, TRUE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Hover_Colonel[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_36, TRUE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Jet_Kylok[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_18, TRUE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Base_Blaze[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_16, TRUE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Beach_Muzy[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_36, TRUE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Jet_Marine[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_2, TRUE },
    { SAVE_PROGRESS_3, FALSE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Boat_Colonel[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_11, TRUE },
    { SAVE_PROGRESS_16, FALSE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Base_Tabby[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_5, TRUE },
    { SAVE_PROGRESS_6, FALSE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Base_Marine[] = {
    { SAVE_PROGRESS_0, TRUE },
    { SAVE_PROGRESS_31, FALSE },
    { SAVE_PROGRESS_36, TRUE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_BaseNext_Colonel[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_21, TRUE },
    { SAVE_PROGRESS_26, FALSE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Jet_Tails[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_2, TRUE },
    { SAVE_PROGRESS_3, FALSE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Hover_Daikun[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_24, TRUE },
    { SAVE_PROGRESS_36, FALSE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Base_Colonel[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_10, TRUE },
    { SAVE_PROGRESS_11, FALSE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Beach_Tabby[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_26, TRUE },
    { SAVE_PROGRESS_36, FALSE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Submarine_Colonel[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_26, TRUE },
    { SAVE_PROGRESS_36, FALSE },
    { LAST_TABLE_ENTRY },
};

static const HubControlNpcSpawnCheck sNpcSpawnCheck_Jet_Tabby[] = {
    { SAVE_PROGRESS_0, FALSE },
    { SAVE_PROGRESS_6, TRUE },
    { SAVE_PROGRESS_21, FALSE },
    { SAVE_PROGRESS_36, TRUE },
    { LAST_TABLE_ENTRY },

    // ???
    // this might not be part of this table?
    { 140, FALSE },
    { 200, FALSE },
};

HubControlNpcSpawnCheck const *gHubNpcSpawnCheckTable[CVIDOCK_NPC_COUNT] = {
    [CVIDOCK_NPC_BASE_TAILS]         = sNpcSpawnCheck_Base_Tails,
    [CVIDOCK_NPC_BASE_MARINE]        = sNpcSpawnCheck_Base_Marine,
    [CVIDOCK_NPC_BASE_BLAZE]         = sNpcSpawnCheck_Base_Blaze,
    [CVIDOCK_NPC_BASE_TABBY]         = sNpcSpawnCheck_Base_Tabby,
    [CVIDOCK_NPC_BASE_COLONEL]       = sNpcSpawnCheck_Base_Colonel,
    [CVIDOCK_NPC_BASENEXT_SETTER]    = sNpcSpawnCheck_BaseNext_Setter,
    [CVIDOCK_NPC_BASENEXT_COLONEL]   = sNpcSpawnCheck_BaseNext_Colonel,
    [CVIDOCK_NPC_BASENEXT_HOURGLASS] = sNpcSpawnCheck_BaseNext_Hourglass,
    [CVIDOCK_NPC_BASENEXT_OLDDS]     = sNpcSpawnCheck_BaseNext_OldDS,
    [CVIDOCK_NPC_JET_TAILS]          = sNpcSpawnCheck_Jet_Tails,
    [CVIDOCK_NPC_JET_MARINE]         = sNpcSpawnCheck_Jet_Marine,
    [CVIDOCK_NPC_JET_TABBY]          = sNpcSpawnCheck_Jet_Tabby,
    [CVIDOCK_NPC_JET_KYLOK]          = sNpcSpawnCheck_Jet_Kylok,
    [CVIDOCK_NPC_BOAT_COLONEL]       = sNpcSpawnCheck_Boat_Colonel,
    [CVIDOCK_NPC_BOAT_GARDON]        = sNpcSpawnCheck_Boat_Gardon,
    [CVIDOCK_NPC_BOAT_NORMAN]        = sNpcSpawnCheck_Boat_Norman,
    [CVIDOCK_NPC_HOVER_COLONEL]      = sNpcSpawnCheck_Hover_Colonel,
    [CVIDOCK_NPC_HOVER_DAIKUN]       = sNpcSpawnCheck_Hover_Daikun,
    [CVIDOCK_NPC_SUBMARINE_COLONEL]  = sNpcSpawnCheck_Submarine_Colonel,
    [CVIDOCK_NPC_SUBMARINE_DAIKUN]   = sNpcSpawnCheck_Submarine_Daikun,
    [CVIDOCK_NPC_BEACH_TABBY]        = sNpcSpawnCheck_Beach_Tabby,
    [CVIDOCK_NPC_BEACH_MUZY]         = sNpcSpawnCheck_Beach_Muzy,
};