#include <game/save/saveGame.h>
#include <game/save/saveManager.h>
#include <game/system/sysEvent.h>
#include <game/file/cardBackup.h>
#include <game/graphics/renderCore.h>
#include <game/cutscene/script.h>
#include <menu/doorPuzzle.h>
#include <menu/credits.h>
#include <seaMap/seaMapManager.h>

// --------------------
// ENUMS
// --------------------

enum SaveTargetFlagCheckID
{
    SAVE_TARGETFLAG_PLANT_KINGDOM,
    SAVE_TARGETFLAG_MACHINE_LABYRINTH,
    SAVE_TARGETFLAG_CORAL_CAVE,
    SAVE_TARGETFLAG_HAUNTED_SHIP,
    SAVE_TARGETFLAG_BLIZZARD_PEAKS,
    SAVE_TARGETFLAG_SKY_BABYLON,
    SAVE_TARGETFLAG_PIRATES_ISLAND,
    SAVE_TARGETFLAG_BIG_SWELL,
    SAVE_TARGETFLAG_HIDDEN_ISLAND_1,
    SAVE_TARGETFLAG_HIDDEN_ISLAND_2,
    SAVE_TARGETFLAG_DAIKUN_ISLAND,
    SAVE_TARGETFLAG_KYLOK_ISLAND,
    SAVE_TARGETFLAG_HIDDEN_ISLAND_3,
    SAVE_TARGETFLAG_HIDDEN_ISLAND_4,
    SAVE_TARGETFLAG_HIDDEN_ISLAND_5,

    SAVE_TARGETFLAG_COUNT,
};

enum SaveTargetFlagExtraCheckID
{
    SAVE_TARGETFLAG_EXTRA_0,
    SAVE_TARGETFLAG_EXTRA_BLIZZARD_PEAKS,
    SAVE_TARGETFLAG_EXTRA_SKY_BABYLON,
    SAVE_TARGETFLAG_EXTRA_HIDDEN_ISLAND_2,
    SAVE_TARGETFLAG_EXTRA_DAIKUN_ISLAND,

    SAVE_TARGETFLAG_EXTRA_COUNT,
};

enum SaveExtraProgressCheckZoneID
{
    SAVE_BRANCH_ZONE_BLIZZARD_PEAKS,
    SAVE_BRANCH_ZONE_SKY_BABYLON,

    SAVE_BRANCH_ZONE_COUNT,
};

// --------------------
// STRUCTS
// --------------------

typedef struct SaveDecorationPurchaseCheck_
{
    u16 gameProgress;
    u16 zone5Progress;
    u16 zone6Progress;
} SaveDecorationPurchaseCheck;

typedef struct SaveTargetFlagProgressCheck_
{
    u16 minGameProgress;
    u16 maxGameProgress;
    u16 extraCheckID;
} SaveTargetFlagProgressCheck;

typedef struct SaveTargetFlagProgressExtraCheck_
{
    u16 zoneID;
    u16 minProgress;
    u16 maxProgress;
} SaveTargetFlagProgressExtraCheck;

// --------------------
// VARIABLES
// --------------------

static const SaveDecorationPurchaseCheck sDecorationPurchaseProgressTable[3] = {
    { .gameProgress = SAVE_PROGRESS_8, .zone5Progress = SAVE_ZONE5_PROGRESS_0, .zone6Progress = SAVE_ZONE6_PROGRESS_0 },
    { .gameProgress = SAVE_PROGRESS_24, .zone5Progress = SAVE_ZONE5_PROGRESS_4, .zone6Progress = SAVE_ZONE6_PROGRESS_0 },
    { .gameProgress = SAVE_PROGRESS_26, .zone5Progress = SAVE_ZONE5_PROGRESS_4, .zone6Progress = SAVE_ZONE6_PROGRESS_6 },
};

static const SaveTargetFlagProgressExtraCheck sTargetFlagProgressExtraCheckList[SAVE_TARGETFLAG_EXTRA_COUNT - 1] = {
    [SAVE_TARGETFLAG_EXTRA_BLIZZARD_PEAKS - 1]  = { .zoneID = SAVE_BRANCH_ZONE_BLIZZARD_PEAKS, .minProgress = SAVE_ZONE5_PROGRESS_0, .maxProgress = SAVE_ZONE5_PROGRESS_4 },
    [SAVE_TARGETFLAG_EXTRA_SKY_BABYLON - 1]     = { .zoneID = SAVE_BRANCH_ZONE_SKY_BABYLON, .minProgress = SAVE_ZONE6_PROGRESS_4, .maxProgress = SAVE_ZONE6_PROGRESS_6 },
    [SAVE_TARGETFLAG_EXTRA_HIDDEN_ISLAND_2 - 1] = { .zoneID = SAVE_BRANCH_ZONE_SKY_BABYLON, .minProgress = SAVE_ZONE6_PROGRESS_2, .maxProgress = SAVE_ZONE6_PROGRESS_4 },
    [SAVE_TARGETFLAG_EXTRA_DAIKUN_ISLAND - 1]   = { .zoneID = SAVE_BRANCH_ZONE_SKY_BABYLON, .minProgress = SAVE_ZONE6_PROGRESS_0, .maxProgress = SAVE_ZONE6_PROGRESS_2 },
};

static const u16 sTargetFlagDiscoveryList[SAVE_TARGETFLAG_COUNT] = {
    [SAVE_TARGETFLAG_PLANT_KINGDOM]     = SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM,     // Formatting Comment
    [SAVE_TARGETFLAG_MACHINE_LABYRINTH] = SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH, // Formatting Comment
    [SAVE_TARGETFLAG_CORAL_CAVE]        = SEAMAPMANAGER_DISCOVER_CORAL_CAVE,        // Formatting Comment
    [SAVE_TARGETFLAG_HAUNTED_SHIP]      = SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP,      // Formatting Comment
    [SAVE_TARGETFLAG_BLIZZARD_PEAKS]    = SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS,    // Formatting Comment
    [SAVE_TARGETFLAG_SKY_BABYLON]       = SEAMAPMANAGER_DISCOVER_SKY_BABYLON,       // Formatting Comment
    [SAVE_TARGETFLAG_PIRATES_ISLAND]    = SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND,    // Formatting Comment
    [SAVE_TARGETFLAG_BIG_SWELL]         = SEAMAPMANAGER_DISCOVER_BIG_SWELL,         // Formatting Comment
    [SAVE_TARGETFLAG_HIDDEN_ISLAND_1]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1,   // Formatting Comment
    [SAVE_TARGETFLAG_HIDDEN_ISLAND_2]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2,   // Formatting Comment
    [SAVE_TARGETFLAG_DAIKUN_ISLAND]     = SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND,     // Formatting Comment
    [SAVE_TARGETFLAG_KYLOK_ISLAND]      = SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND,      // Formatting Comment
    [SAVE_TARGETFLAG_HIDDEN_ISLAND_3]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3,   // Formatting Comment
    [SAVE_TARGETFLAG_HIDDEN_ISLAND_4]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4,   // Formatting Comment
    [SAVE_TARGETFLAG_HIDDEN_ISLAND_5]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5    // Formatting Comment
};

static const SaveTargetFlagProgressCheck sTargetFlagProgressCheckList[SAVE_TARGETFLAG_COUNT] = {
    [SAVE_TARGETFLAG_PLANT_KINGDOM]     = { .minGameProgress = SAVE_PROGRESS_2, .maxGameProgress = SAVE_PROGRESS_5, .extraCheckID = SAVE_TARGETFLAG_EXTRA_0 },
    [SAVE_TARGETFLAG_MACHINE_LABYRINTH] = { .minGameProgress = SAVE_PROGRESS_5, .maxGameProgress = SAVE_PROGRESS_8, .extraCheckID = SAVE_TARGETFLAG_EXTRA_0 },
    [SAVE_TARGETFLAG_CORAL_CAVE]        = { .minGameProgress = SAVE_PROGRESS_14, .maxGameProgress = SAVE_PROGRESS_16, .extraCheckID = SAVE_TARGETFLAG_EXTRA_0 },
    [SAVE_TARGETFLAG_HAUNTED_SHIP]      = { .minGameProgress = SAVE_PROGRESS_18, .maxGameProgress = SAVE_PROGRESS_21, .extraCheckID = SAVE_TARGETFLAG_EXTRA_0 },
    [SAVE_TARGETFLAG_BLIZZARD_PEAKS]    = { .minGameProgress = SAVE_PROGRESS_23, .maxGameProgress = SAVE_PROGRESS_25, .extraCheckID = SAVE_TARGETFLAG_EXTRA_BLIZZARD_PEAKS },
    [SAVE_TARGETFLAG_SKY_BABYLON]       = { .minGameProgress = SAVE_PROGRESS_23, .maxGameProgress = SAVE_PROGRESS_25, .extraCheckID = SAVE_TARGETFLAG_EXTRA_SKY_BABYLON },
    [SAVE_TARGETFLAG_PIRATES_ISLAND]    = { .minGameProgress = SAVE_PROGRESS_26, .maxGameProgress = SAVE_PROGRESS_35, .extraCheckID = SAVE_TARGETFLAG_EXTRA_0 },
    [SAVE_TARGETFLAG_BIG_SWELL]         = { .minGameProgress = SAVE_PROGRESS_35, .maxGameProgress = SAVE_PROGRESS_36, .extraCheckID = SAVE_TARGETFLAG_EXTRA_0 },
    [SAVE_TARGETFLAG_HIDDEN_ISLAND_1]   = { .minGameProgress = SAVE_PROGRESS_10, .maxGameProgress = SAVE_PROGRESS_14, .extraCheckID = SAVE_TARGETFLAG_EXTRA_0 },
    [SAVE_TARGETFLAG_HIDDEN_ISLAND_2]   = { .minGameProgress = SAVE_PROGRESS_23, .maxGameProgress = SAVE_PROGRESS_25, .extraCheckID = SAVE_TARGETFLAG_EXTRA_HIDDEN_ISLAND_2 },
    [SAVE_TARGETFLAG_DAIKUN_ISLAND]     = { .minGameProgress = SAVE_PROGRESS_23, .maxGameProgress = SAVE_PROGRESS_25, .extraCheckID = SAVE_TARGETFLAG_EXTRA_DAIKUN_ISLAND },
    [SAVE_TARGETFLAG_KYLOK_ISLAND]      = { .minGameProgress = SAVE_PROGRESS_17, .maxGameProgress = SAVE_PROGRESS_18, .extraCheckID = SAVE_TARGETFLAG_EXTRA_0 },
    [SAVE_TARGETFLAG_HIDDEN_ISLAND_3]   = { .minGameProgress = SAVE_PROGRESS_29, .maxGameProgress = SAVE_PROGRESS_30, .extraCheckID = SAVE_TARGETFLAG_EXTRA_0 },
    [SAVE_TARGETFLAG_HIDDEN_ISLAND_4]   = { .minGameProgress = SAVE_PROGRESS_29, .maxGameProgress = SAVE_PROGRESS_30, .extraCheckID = SAVE_TARGETFLAG_EXTRA_0 },
    [SAVE_TARGETFLAG_HIDDEN_ISLAND_5]   = { .minGameProgress = SAVE_PROGRESS_29, .maxGameProgress = SAVE_PROGRESS_30, .extraCheckID = SAVE_TARGETFLAG_EXTRA_0 },
};

// --------------------
// FUNCTIONS
// --------------------

BOOL SaveGame__IsShipUnlocked(ShipType ship)
{
    SaveProgress shipUnlockProgress[SHIP_COUNT] = {
        [SHIP_JET]       = SAVE_PROGRESS_2,  // GameProgress required for 'JetSki' to be considered unlocked
        [SHIP_BOAT]      = SAVE_PROGRESS_9,  // GameProgress required for 'Sailboat' to be considered unlocked
        [SHIP_HOVER]     = SAVE_PROGRESS_22, // GameProgress required for 'Hovercraft' to be considered unlocked
        [SHIP_SUBMARINE] = SAVE_PROGRESS_26  // GameProgress required for 'Submarine' to be considered unlocked
    };

    return SaveGame__GetGameProgress() >= shipUnlockProgress[ship];
}

BOOL SaveGame__BlazeUnlocked(void)
{
    return SaveGame__GetGameProgress() >= SAVE_PROGRESS_16;
}

BOOL SaveGame__CheckZoneBeaten(s32 id)
{
    SaveProgress gameProgress = SaveGame__GetGameProgress();
    s32 zone5Progress         = SaveGame__GetZone5Progress();
    s32 zone6Progress         = SaveGame__GetZone6Progress();

    switch (id)
    {
        case ZONE_PLANT_KINGDOM:
            if (gameProgress >= SAVE_PROGRESS_5)
                return TRUE;
            break;

        case ZONE_MACHINE_LABYRINTH:
            if (gameProgress >= SAVE_PROGRESS_8)
                return TRUE;
            break;

        case ZONE_CORAL_CAVE:
            if (gameProgress >= SAVE_PROGRESS_16)
                return TRUE;
            break;

        case ZONE_HAUNTED_SHIP:
            if (gameProgress >= SAVE_PROGRESS_21)
                return TRUE;
            break;

        case ZONE_BLIZZARD_PEAKS:
            if (zone5Progress >= SAVE_ZONE5_PROGRESS_4)
                return TRUE;
            break;

        case ZONE_SKY_BABYLON:
            if (zone6Progress >= SAVE_ZONE6_PROGRESS_6)
                return TRUE;
            break;

        case ZONE_PIRATES_ISLAND:
            if (gameProgress >= SAVE_PROGRESS_35)
                return TRUE;
            break;

        case ZONE_BIG_SWELL:
            if (gameProgress >= SAVE_PROGRESS_36)
                return TRUE;
            break;

        case ZONE_DEEP_CORE:
            if (gameProgress >= SAVE_PROGRESS_39)
                return TRUE;
            break;
    }

    return FALSE;
}

BOOL SaveGame__HasBeatenTutorial(void)
{
    return SaveGame__GetGameProgress() >= SAVE_PROGRESS_1;
}

BOOL SaveGame__GetProgressFlags_0x1(void)
{
    return (saveGame.stage.progress.flags & 1) == 0;
}

BOOL SaveGame__HasEncounteredJohnny(void)
{
    return SaveGame__GetGameProgress() >= SAVE_PROGRESS_12;
}

BOOL SaveGame__CheckProgressZone5OrZone6NotClear(void)
{
    if (SaveGame__GetGameProgress() != SAVE_PROGRESS_24)
        return FALSE;

    if (SaveGame__GetZone5Progress() != SAVE_ZONE5_PROGRESS_4)
        return FALSE;

    return SaveGame__GetZone6Progress() == SAVE_ZONE6_PROGRESS_6;
}

BOOL SaveGame__CheckProgress30(void)
{
    return SaveGame__GetGameProgress() == SAVE_PROGRESS_30;
}

BOOL SaveGame__CheckProgress15(void)
{
    return SaveGame__GetGameProgress() == SAVE_PROGRESS_15 && SaveGame__GetProgressCounter() >= 1;
}

BOOL SaveGame__CheckProgressForShip(u32 id)
{
    SaveProgress progress;
    switch (id)
    {
        case SHIP_BOAT - 1:
            progress = SAVE_PROGRESS_9;
            break;

        case SHIP_HOVER - 1:
            progress = SAVE_PROGRESS_22;
            break;

        case SHIP_SUBMARINE - 1:
            progress = SAVE_PROGRESS_26;
            break;
    }

    return progress == SaveGame__GetGameProgress();
}

BOOL SaveGame__GetProgressFlags_UnlockedMovieList(void)
{
    return (saveGame.stage.progress.flags & SAVE_PROGRESSFLAG_UNLOCKED_MOVIE_LIST) != 0;
}

void SaveGame__SetProgressFlags_UnlockedMovieList(void)
{
    saveGame.stage.progress.flags |= SAVE_PROGRESSFLAG_UNLOCKED_MOVIE_LIST;
}

BOOL SaveGame__CanBuyDecoration(u16 id)
{
    s32 gameProgress  = SaveGame__GetGameProgress();
    s32 zone5Progress = SaveGame__GetZone5Progress();
    s32 zone6Progress = SaveGame__GetZone6Progress();

    if (gameProgress >= sDecorationPurchaseProgressTable[id].gameProgress && zone5Progress >= sDecorationPurchaseProgressTable[id].zone5Progress
        && zone6Progress >= sDecorationPurchaseProgressTable[id].zone6Progress)
        return TRUE;
    else
        return FALSE;
}

BOOL SaveGame__GetBoughtDecoration(u16 id)
{
    return (saveGame.stage.progress.flags & (SAVE_PROGRESSFLAG_BOUGHT_DECORATION_1 << id)) != 0;
}

void SaveGame__SetBoughtDecoration(u16 id)
{
    saveGame.stage.progress.flags |= SAVE_PROGRESSFLAG_BOUGHT_DECORATION_1 << id;
}

BOOL SaveGame__GetProgressFlags_HintInfoPurchased(u32 id)
{
    return (saveGame.stage.progress.flags & (SAVE_PROGRESSFLAG_BOUGHT_HINT_1 << id)) != 0;
}

void SaveGame__SetProgressFlags_HintInfoPurchased(u32 id)
{
    saveGame.stage.progress.flags |= SAVE_PROGRESSFLAG_BOUGHT_HINT_1 << id;
}

BOOL SaveGame__CheckProgressIsHuntingForClues(void)
{
    return SaveGame__GetGameProgress() == SAVE_PROGRESS_29;
}

BOOL SaveGame__CanBuyInfoHint(void)
{
    return saveGame.stage.ringCount >= 800;
}

void SaveGame__BuyInfoHint(void)
{
    saveGame.stage.ringCount -= 800;
}

BOOL SaveGame__CheckProgressIsAllEmeraldsCollected(void)
{
    return SaveGame__GetGameProgress() >= SAVE_PROGRESS_37;
}

u16 SaveGame__GetTargetFlagIconCount(s32 seaMapViewType)
{
    u8 gameProgress = SaveGame__GetGameProgress();

    u8 zoneProgressList[SAVE_BRANCH_ZONE_COUNT];
    zoneProgressList[SAVE_BRANCH_ZONE_BLIZZARD_PEAKS] = SaveGame__GetZone5Progress();
    zoneProgressList[SAVE_BRANCH_ZONE_SKY_BABYLON]    = SaveGame__GetZone6Progress();

    s32 i;
    u16 count = 0;
    for (i = 0; i < SAVE_TARGETFLAG_COUNT; i++)
    {
        const SaveTargetFlagProgressCheck *flagProgressCheck = &sTargetFlagProgressCheckList[i];

        if (gameProgress >= flagProgressCheck->minGameProgress && gameProgress < flagProgressCheck->maxGameProgress)
        {
            s16 id = (flagProgressCheck->extraCheckID - 1);

            if (id >= 0)
            {
                const SaveTargetFlagProgressExtraCheck *progress2 = &sTargetFlagProgressExtraCheckList[id];
                u8 zoneProgress                                   = zoneProgressList[progress2->zoneID];

                if (zoneProgress < progress2->minProgress || zoneProgress >= progress2->maxProgress)
                    continue;
            }

            if (i < 12 || i > 14 || SaveGame__GetProgressFlags_HintInfoPurchased((u16)(i - 12)) && SaveGame__HasDoorPuzzlePiece((u16)(i - 12)) == FALSE)
                count++;
        }
    }

    return count;
}

s32 SaveGame__GetTargetFlagIcon(s32 targetIndex)
{
    u8 gameProgress = SaveGame__GetGameProgress();

    u8 zoneProgressList[SAVE_BRANCH_ZONE_COUNT];
    zoneProgressList[SAVE_BRANCH_ZONE_BLIZZARD_PEAKS] = SaveGame__GetZone5Progress();
    zoneProgressList[SAVE_BRANCH_ZONE_SKY_BABYLON]    = SaveGame__GetZone6Progress();

    s32 i;
    u16 index = 0;
    for (i = 0; i < SAVE_TARGETFLAG_COUNT; i++)
    {
        const SaveTargetFlagProgressCheck *flagProgressCheck = &sTargetFlagProgressCheckList[i];

        if (gameProgress >= flagProgressCheck->minGameProgress && gameProgress < flagProgressCheck->maxGameProgress)
        {
            s16 id = (flagProgressCheck->extraCheckID - 1);

            if (id >= 0)
            {
                const SaveTargetFlagProgressExtraCheck *progress2 = &sTargetFlagProgressExtraCheckList[id];
                u8 zoneProgress                                   = zoneProgressList[progress2->zoneID];

                if (zoneProgress < progress2->minProgress || zoneProgress >= progress2->maxProgress)
                    continue;
            }

            if (i < 12 || i > 14 || SaveGame__GetProgressFlags_HintInfoPurchased((u16)(i - 12)) && SaveGame__HasDoorPuzzlePiece((u16)(i - 12)) == FALSE)
            {
                if (targetIndex == index)
                    return sTargetFlagDiscoveryList[i];

                index++;
            }
        }
    }

    return SEAMAPMANAGER_DISCOVER_42;
}

ShipLevel SaveGame__GetShipUpgradeStatus(u16 id)
{
    return SaveGame__GetShipUpgradeStatus_(id, saveGame.stage.progress.flags);
}

ShipLevel SaveGame__GetShipUpgradeStatus_(u16 id, u32 flags)
{
    if ((flags & (SAVE_PROGRESSFLAG_UPGRADED_SHIP_LV1_JET << (2 * id))) == 0)
        return SHIP_LEVEL_0;

    if ((flags & ((SAVE_PROGRESSFLAG_UPGRADED_SHIP_LV1_JET << (2 * id)) << 1)) != 0)
        return SHIP_LEVEL_2;

    return SHIP_LEVEL_1;
}