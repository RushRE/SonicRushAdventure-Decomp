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
// STRUCTS
// --------------------

typedef struct SaveGameUnknown205D65C_
{
    u16 gameProgress;
    u16 zone5Progress;
    u16 zone6Progress;
} SaveGameUnknown205D65C;

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void (*SaveGame__UnknownTable2[])(void);
NOT_DECOMPILED BOOL (*SaveGame__ProgressCheckTable[])(s32 id);
NOT_DECOMPILED void (*SaveGame__UnknownTable1[])(SaveGameNextAction *state);
NOT_DECOMPILED SaveGameNextAction *SaveGame__gameProgressUnknown[SAVE_PROGRESS_COUNT];
NOT_DECOMPILED SaveGameNextAction *SaveGame__unknownProgress1Unknown[SAVE_ZONE5_PROGRESS_COUNT];
NOT_DECOMPILED SaveGameNextAction *SaveGame__unknownProgress2Unknown[SAVE_ZONE6_PROGRESS_COUNT];
NOT_DECOMPILED u16 _021108DC[];
NOT_DECOMPILED u16 _021108EA[];
NOT_DECOMPILED u32 SaveGame_ShipUnlockProgress[];
NOT_DECOMPILED u16 SaveGame__hiddenIslandList[];
NOT_DECOMPILED u16 SaveGame__nextStage[];

NOT_DECOMPILED u16 _021107BE[5];
NOT_DECOMPILED u16 _021107B4[5];
NOT_DECOMPILED u16 _02110B70[42];
NOT_DECOMPILED SaveGameUnknown205D150 _02110C20[];
NOT_DECOMPILED SaveGameUnknown205D65C _02110D00[];
NOT_DECOMPILED u16 _02110D12[];
NOT_DECOMPILED u16 _02110D2A[];
NOT_DECOMPILED u16 _02110B20[];
NOT_DECOMPILED u16 _02110D48[];

// --------------------
// VARIABLES
// --------------------

SaveGame saveGame;

// assert that the size is always the same as the final game
STATIC_ASSERT_MATCHING(sizeof(SaveGame) == 0x1A68, SAVE_GAME_DOES_NOT_MATCH);

// --------------------
// FUNCTIONS
// --------------------

void SaveGame__UpdateProgressEvent(void)
{
    SaveGame__UpdateProgress();
}

void SaveGame__SetProgressType(s32 type)
{
    gameState.saveFile.progressType = type;
}

SaveProgress SaveGame__GetGameProgress(void)
{
    return saveGame.stage.progress.gameProgress;
}

void SaveGame__SetGameProgress(SaveProgress progress)
{
    saveGame.stage.progress.gameProgress = progress;
    gameState.saveFile.progressCounter   = 0;

    if (progress < SAVE_PROGRESS_24)
    {
        saveGame.stage.progress.zone5Progress = SAVE_ZONE5_PROGRESS_0;
        saveGame.stage.progress.zone6Progress = SAVE_ZONE6_PROGRESS_0;
    }
    else if (progress >= SAVE_PROGRESS_25)
    {
        saveGame.stage.progress.zone5Progress = SAVE_ZONE5_PROGRESS_4;
        saveGame.stage.progress.zone6Progress = SAVE_ZONE6_PROGRESS_6;
    }
    else
    {
        if (saveGame.stage.progress.zone5Progress == SAVE_ZONE5_PROGRESS_0)
            saveGame.stage.progress.zone5Progress = SAVE_ZONE5_PROGRESS_1;

        if (saveGame.stage.progress.zone6Progress == SAVE_ZONE6_PROGRESS_0)
            saveGame.stage.progress.zone6Progress = SAVE_ZONE6_PROGRESS_1;
    }

    if (progress < SAVE_PROGRESS_29)
    {
        saveGame.stage.progress.flags &= ~(2 | 4 | 8);
    }
    else if (progress >= SAVE_PROGRESS_30)
    {
        saveGame.stage.progress.flags |= (2 | 4 | 8);
    }

    if (progress <= SAVE_PROGRESS_17)
        saveGame.stage.progress.flags &= ~0x10;

    SaveGame__RemoveProgressFlags_0x100();
    SaveGame__RemoveProgressFlags_0x200();
    SaveGame__RemoveProgressFlags_0x400();

    if (progress >= SAVE_PROGRESS_2)
        saveGame.stage.progress.flags |= 0x80000;
    else
        saveGame.stage.progress.flags &= ~0x80000;

    saveGame.stage.progress.flags &= ~(0x100000 | 0x200000 | 0x400000);

    SaveGame__ApplySystemProgress();
}

u8 SaveGame__GetProgressCounter(void)
{
    return gameState.saveFile.progressCounter;
}

s32 SaveGame__GetZone5Progress(void)
{
    return saveGame.stage.progress.zone5Progress;
}

void SaveGame__SetZone5Progress(s32 progress)
{
    saveGame.stage.progress.zone5Progress = progress;
    gameState.saveFile.progressCounter    = 0;
    saveGame.stage.progress.flags &= ~1;

    SaveGame__RemoveProgressFlags_0x200();
    SaveGame__ApplySystemProgress();
}

s32 SaveGame__GetZone6Progress(void)
{
    return saveGame.stage.progress.zone6Progress;
}

void SaveGame__SetZone6Progress(s32 progress)
{
    saveGame.stage.progress.zone6Progress = progress;
    gameState.saveFile.progressCounter    = 0;
    saveGame.stage.progress.flags |= 1;

    SaveGame__RemoveProgressFlags_0x400();
    SaveGame__ApplySystemProgress();
}

void SaveGame__IncrementUnknown2ForUnknown(void)
{
    gameState.saveFile.progressCounter++;
}

BOOL SaveGame__HasDoorPuzzlePiece(u16 id)
{
    return (saveGame.stage.progress.flags & (2 << id)) != 0;
}

void SaveGame__GetPuzzlePiece(u16 id)
{
    saveGame.stage.progress.flags |= (2 << id);
    SaveGame__ApplySystemProgress();
}

void SaveGame__UpdateProgressForZone5Zone6Cleared(void)
{
    SaveGame__SetGameProgress(SAVE_PROGRESS_25);
}

void SaveGame__UpdateProgressForAllDoorPuzzleKeysCollected(void)
{
    SaveGame__SetGameProgress(SAVE_PROGRESS_31);
}

void SaveGame__UpdateProgressForDockFirstVisited(u32 type)
{
    switch (type)
    {
        case SHIP_BOAT - 1:
            SaveGame__SetGameProgress(SAVE_PROGRESS_10);
            break;

        case SHIP_HOVER - 1:
            SaveGame__SetGameProgress(SAVE_PROGRESS_23);
            break;

        case SHIP_SUBMARINE - 1:
            SaveGame__SetGameProgress(SAVE_PROGRESS_27);
            break;
    }
}

BOOL SaveGame__CheckCollectedAllEmeraldsEvent(void)
{
    SaveBlockChart *chartSave = &saveGame.chart;
    SaveBlockStage *stageSave = &saveGame.stage;

    if (SaveGame__GetGameProgress() != SAVE_PROGRESS_36)
        return FALSE;

    if (SaveGame__GetChaosEmeraldCount(chartSave) >= 7 && SaveGame__GetSolEmeraldCount(stageSave) >= 7)
    {
        SaveGame__SetGameProgress(SAVE_PROGRESS_37);
        return TRUE;
    }

    return FALSE;
}

void SaveGame__SetMissionStatus(u16 id, MissionState status)
{
    u32 state = saveGame.stage.missionState[id / 4];
    u32 shift = (id % 4) << 1;

    state &= ~(MISSION_STATE_COMPLETED << shift);
    saveGame.stage.missionState[id / 4] = state | (status << shift);
}

MissionState SaveGame__GetMissionStatus(u16 id)
{
    return (saveGame.stage.missionState[id / 4] >> ((id % 4) << 1)) & 3;
}

void SaveGame__SetMissionAttempted(u16 id, BOOL attempted)
{
    u32 shift = (id % 8);
    if (attempted)
        saveGame.stage.missionAttemptState[id / 8] |= (1 << shift);
    else
        saveGame.stage.missionAttemptState[id / 8] &= ~(1 << shift);
}

BOOL SaveGame__GetMissionAttempted(u16 id)
{
    return (saveGame.stage.missionAttemptState[id / 8] & (1 << (id % 8))) != 0;
}

u16 SaveGame__GetSystemGameProgress(void)
{
    return saveGame.system.progress.gameProgress;
}

void SaveGame__GsExit(u16 value)
{
    gameState.saveFile.field_52 = value;
}

void SaveGame__UnlockShip(u16 shipID, u16 shipLevel)
{
    u32 id = 0x800 << (2 * shipID) << (shipLevel - 1);

    SaveGameProgress *progress = &saveGame.stage.progress;

    if (shipLevel == SHIP_LEVEL_2 && (progress->flags & (id >> 1)) == 0)
        progress->flags |= id >> 1;

    progress->flags |= id;

    SaveGame__ApplySystemProgress();
}

BOOL SaveGame__GetNextShipUpgrade(u16 *ship, u16 *level)
{
    if (SaveGame__GetGameProgress() < SAVE_PROGRESS_36)
        return FALSE;

    if (SaveGame__GetShipUpgradeStatus(SHIP_SUBMARINE) >= 2)
        return FALSE;

    if (SaveGame__GetShipUpgradeStatus(SHIP_SUBMARINE) == 0)
    {
        for (s32 id = 0; id < SHIP_COUNT; id++)
        {
            if (SaveGame__GetShipUpgradeStatus(id) == SHIP_LEVEL_0)
            {
                if (ship != NULL)
                    *ship = id;

                if (level != NULL)
                    *level = SHIP_LEVEL_1;

                return TRUE;
            }
        }
    }
    else
    {
        for (s32 id = 0; id < SHIP_COUNT; id++)
        {
            if (SaveGame__GetShipUpgradeStatus(id) == SHIP_LEVEL_1)
            {
                if (ship != NULL)
                    *ship = id;

                if (level != NULL)
                    *level = SHIP_LEVEL_2;

                return TRUE;
            }
        }
    }

    return FALSE;
}

BOOL SaveGame__Func_205BEDC(void)
{
    if (!SaveGame__GetStateFlag(2))
        return FALSE;

    SaveGame__DisableStateFlags(2);
    return TRUE;
}

void SaveGame_SetPlayerHasSavedFlag(void)
{
    saveGame.stage.progress.flags |= 0x80000;
    SaveGame__ApplySystemProgress();
}

BOOL SaveGame_CheckPlayerHasSavedFlag(void)
{
    if (saveGame.stage.progress.gameProgress >= SAVE_PROGRESS_2)
        return TRUE;

    if (saveGame.stage.progress.gameProgress < SAVE_PROGRESS_1)
        return FALSE;

    return (saveGame.system.progress.flags & 0x80000) != 0;
}

void SaveGame__SetDoneFirstShipVoyage(s32 id)
{
    SaveGame__EnableStateFlags(4 << id);
}

BOOL SaveGame__HasDoneFirstShipVoyage(s32 id)
{
    if (id == SHIP_JET)
        return TRUE;

    return SaveGame__GetStateFlag(4 << id);
}

void SaveGame__ClearCallback_Stage(SaveGame *save, SaveBlockFlags blockFlags)
{
    if ((blockFlags & SAVE_BLOCK_FLAG_STAGE) == 0)
        return;

    save->stage.status.difficulty = DIFFICULTY_EASY;
    save->stage.status.timeLimit  = FALSE;
    save->stage.status.lives      = PLAYER_STARTING_LIVES;
}

void SaveGame__UpdateProgress(void)
{
    SaveGameNextAction *state = SaveGame__GetNextActionFromProgress();
    if (state != NULL && state->table1Pos < 8)
    {
        SaveGame__UnknownTable1[state->table1Pos](state);
    }
    else
    {
        SaveGame__UnknownTable2[SaveGame__GetProgressType()]();
    }
}

SaveGameNextAction *SaveGame__GetNextActionFromProgress(void)
{
    SaveGameNextAction *config;

    u16 gameProgress;
    u16 zone5Progress;
    u16 zone6Progress;
    u16 progressCounter;
    u16 progressType;

    gameProgress  = SaveGame__GetGameProgress();
    zone5Progress = SaveGame__GetZone5Progress();
    zone6Progress = SaveGame__GetZone6Progress();

    progressCounter = SaveGame__GetProgressCounter();
    progressType    = SaveGame__GetProgressType();

    if (progressType == SAVE_PROGRESSTYPE_4)
        progressType = SAVE_PROGRESSTYPE_3;

    if (progressType == SAVE_PROGRESSTYPE_5)
    {
        if (SaveGame__Func_205D150(gameState.stageID))
        {
            SaveGame__GsExit(0);
        }
    }
    else if (progressType == SAVE_PROGRESSTYPE_9)
    {
        if (SaveGame__GetGameProgress() < SAVE_PROGRESS_39)
        {
            SaveGame__GsExit(0);
        }
    }

    config = NULL;
    u16 count;
    switch (gameProgress)
    {
        default:
            count = _02110B20[gameProgress];
            if (progressCounter < count)
            {
                config = SaveGame__gameProgressUnknown[gameProgress];

                if (config != NULL)
                {
                    config += progressCounter;

                    if (config->type < SAVE_PROGRESSTYPE_COUNT && (config->type != progressType || !SaveGame__ProgressCheckTable[progressType](config->progressCheckValue)))
                    {
                        config = NULL;
                    }
                    else
                    {
                        if (config->allowProgressIncrement)
                        {
                            if (progressCounter + 1 < count)
                            {
                                SaveGame__IncrementProgressCounter();
                            }
                            else
                            {
                                SaveGame__IncrementGameProgress();
                                SaveGame__ResetProgressCounter();
                            }
                        }

                        SaveGame__GsExit(0);
                    }
                }
                break;
            }
            else
            {
                config = NULL;
            }
            // fallthrough

        case SAVE_PROGRESS_24:
            // this was probably an inline function?
            if (0 == NULL)
            {
                count = _021107BE[zone5Progress];

                if (progressCounter < count)
                {
                    config = SaveGame__unknownProgress1Unknown[zone5Progress];

                    if (config != NULL)
                    {
                        config += progressCounter;

                        if (config->type < SAVE_PROGRESSTYPE_COUNT && (config->type != progressType || !SaveGame__ProgressCheckTable[progressType](config->progressCheckValue)))
                        {
                            config = NULL;
                        }
                        else
                        {
                            if (config->allowProgressIncrement)
                            {
                                if (progressCounter + 1 < count)
                                {
                                    SaveGame__IncrementProgressCounter();
                                }
                                else
                                {
                                    SaveGame__IncrementUnknownProgress1();
                                    SaveGame__ResetProgressCounter();
                                }
                            }

                            SaveGame__GsExit(0);
                        }
                    }
                }
            }

            if (config == NULL)
            {
                count = _021108DC[zone6Progress];

                if (progressCounter < count)
                {
                    config = SaveGame__unknownProgress2Unknown[zone6Progress];
                    if (config != NULL)
                    {
                        config += progressCounter;

                        if (config->type < SAVE_PROGRESSTYPE_COUNT && (config->type != progressType || !SaveGame__ProgressCheckTable[progressType](config->progressCheckValue)))
                        {
                            config = NULL;
                        }
                        else
                        {
                            if (config->allowProgressIncrement)
                            {
                                if (progressCounter + 1 < count)
                                {
                                    SaveGame__IncrementProgressCounter();
                                }
                                else
                                {
                                    SaveGame__IncrementUnknownProgress2();
                                    SaveGame__ResetProgressCounter();
                                }
                            }

                            SaveGame__GsExit(0);
                        }
                    }
                }
            }
            break;
    }

    return config;
}

void SaveGame__UpdateProgress2_Type0(void)
{
    SaveGame__ChangeEvent(SYSEVENT_RETURN_TO_HUB);
}

void SaveGame__UpdateProgress2_Type1(void)
{
    SaveGame__StartSeaMapUnknown();
}

void SaveGame__UpdateProgress2_Type2(void)
{
    if (SaveGame__GetStateFlag(1) || gameState.sailUnknown1 != 0)
    {
        SaveGame__DisableStateFlags(1);
        SaveGame__StartSailing();
    }
    else
    {
        u16 cutscene;
        switch (gameState.sailShipType)
        {
            case SHIP_JET:
                cutscene = CUTSCENE_WAVE_CYCLONE_LAUNCH;
                break;

            case SHIP_BOAT:
                cutscene = CUTSCENE_OCEAN_TORNADO_LAUNCH;
                break;

            case SHIP_HOVER:
                cutscene = CUTSCENE_AQUA_BLAST_LAUNCH;
                break;

            case SHIP_SUBMARINE:
                cutscene = CUTSCENE_DEEP_TYPHOON_LAUNCH;
                break;

            default:
                cutscene = CUTSCENE_NONE;
                break;
        }

        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_2);
        SaveGame__EnableStateFlags(1);
        SaveGame__StartCutscene(cutscene, SYSEVENT_UPDATE_PROGRESS, TRUE);
    }
}

void SaveGame__UpdateProgress2_Type3(void)
{
    if (gameState.stageID == STAGE_Z71 && SaveGame__GetGameProgress() < SAVE_PROGRESS_33)
    {
        SaveGame__StartDoorPuzzle(TRUE);
    }
    else
    {
        gameState.characterID[0] = CHARACTER_SONIC;

        if (SaveGame__BlazeUnlocked())
            SaveGame__StartStageSelect();
        else
            SaveGame__StartStoryMode();
    }
}

void SaveGame__UpdateProgress2_Type4(void)
{
    SaveGame__StartStoryMode();
}

void SaveGame__UpdateProgress2_Type5(void)
{
    u32 stageID = gameState.stageID;
    if (stageID == STAGE_Z11)
    {
        if (SaveGame__GetGameProgress() == SAVE_PROGRESS_3)
            SaveGame__SetProgressFlags_0x100();
    }
    else if (stageID == STAGE_Z21)
    {
        if (SaveGame__GetGameProgress() == SAVE_PROGRESS_6)
            SaveGame__SetProgressFlags_0x100();
    }
    else if (stageID == STAGE_Z31)
    {
        if (SaveGame__GetGameProgress() == SAVE_PROGRESS_14)
            SaveGame__SetProgressFlags_0x100();
    }
    else if (stageID == STAGE_Z41)
    {
        if (SaveGame__GetGameProgress() == SAVE_PROGRESS_19)
            SaveGame__SetProgressFlags_0x100();
    }
    else if (stageID == STAGE_Z51)
    {
        if (SaveGame__GetZone5Progress() == SAVE_ZONE5_PROGRESS_2)
            SaveGame__SetProgressFlags_0x200();
    }
    else if (stageID == STAGE_Z61)
    {
        if (SaveGame__GetZone6Progress() == SAVE_ZONE6_PROGRESS_4)
            SaveGame__SetProgressFlags_0x400();
    }
    else if (stageID == STAGE_Z71)
    {
        if (SaveGame__GetGameProgress() == SAVE_PROGRESS_33)
            SaveGame__SetProgressFlags_0x100();
    }

    for (s32 s = 0; s < SAVE_ISLAND_COUNT; s++)
    {
        if (stageID == SaveGame__hiddenIslandList[s] && SaveGame__GetIslandProgress(&saveGame.stage.progress, s) < SAVE_ISLAND_STATE_BEATEN)
        {
            SaveGame__SetIslandProgress(&saveGame.stage.progress, s, SAVE_ISLAND_STATE_BEATEN);
            break;
        }
    }

    SaveGame__ApplySystemProgress();

    if (gameState.saveFile.field_52 == 1)
    {
        gameState.saveFile.field_54 = 1;
        SaveGame__ChangeEvent(SYSEVENT_MAIN_MENU);
    }
    else
    {
        u32 nextStage = SaveGame__nextStage[stageID];
        if (stageID != nextStage)
        {
            // next stage (act) lined up, so advance to the next stage.
            gameState.stageID = nextStage;
            SaveGame__SetProgressType(SAVE_PROGRESSTYPE_4);
        }
        else if (stageID == STAGE_BOSS_FINAL)
        {
            static const u16 cutsceneIDList[] = { CUTSCENE_GHOST_TITANS_IMPACT, CUTSCENE_ENDING, CUTSCENE_INVALID };

            u16 cutsceneID = cutsceneIDList[SaveGame__GetProgressCounter()];
            SaveGame__IncrementUnknown2ForUnknown();
            if (SaveGame__GetProgressCounter() >= 3)
            {
                SaveGame__ResetProgressCounter();
                if (SaveGame__GetGameProgress() <= SAVE_PROGRESS_35)
                    SaveGame__SetGameProgress(SAVE_PROGRESS_36);
            }

            if (cutsceneID != CUTSCENE_INVALID)
            {
                BOOL canSkip                    = SaveGame__GetGameProgress() >= SAVE_PROGRESS_36 ? TRUE : FALSE;
                struct GameCutsceneState *state = &gameState.cutscene;

                state->nextSysEvent = SYSEVENT_UPDATE_PROGRESS;
                state->canSkip      = canSkip;
                state->cutsceneID   = cutsceneID;
                SaveGame__ChangeEvent(SYSEVENT_CUTSCENE);
            }
            else
            {
                gameState.creditsMode = CREDITS_MODE_FINAL_BOSS;
                SaveGame__ChangeEvent(SYSEVENT_CREDITS);
            }

            return;
        }
        else
        {
            if (stageID == STAGE_HIDDEN_ISLAND_3)
            {
                if (SaveGame__GetGameProgress() < SAVE_PROGRESS_29)
                {
                    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
                    SaveGame__StartCutscene(CUTSCENE_MYSTERIOUS_MARKER_NO_1, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }
                else
                {
                    if (!SaveGame__HasDoorPuzzlePiece(0))
                    {
                        SaveGame__GetPuzzlePiece(0);
                        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
                        SaveGame__StartCutscene(CUTSCENE_CLUE_NO_1, SYSEVENT_UPDATE_PROGRESS, TRUE);
                        return;
                    }
                }
            }
            else if (stageID == STAGE_HIDDEN_ISLAND_4)
            {
                if (SaveGame__GetGameProgress() < SAVE_PROGRESS_29)
                {
                    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
                    SaveGame__StartCutscene(CUTSCENE_MYSTERIOUS_MARKER_NO_2, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }

                if (!SaveGame__HasDoorPuzzlePiece(1))
                {
                    SaveGame__GetPuzzlePiece(1);
                    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
                    SaveGame__StartCutscene(CUTSCENE_CLUE_NO_2, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }
            }
            else if (stageID == STAGE_HIDDEN_ISLAND_5)
            {
                if (SaveGame__GetGameProgress() < SAVE_PROGRESS_29)
                {
                    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
                    SaveGame__StartCutscene(CUTSCENE_MYSTERIOUS_MARKER_NO_1, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }
                else
                {
                    if (!SaveGame__HasDoorPuzzlePiece(2))
                    {
                        SaveGame__GetPuzzlePiece(2);
                        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
                        SaveGame__StartCutscene(CUTSCENE_CLUE_NO_3, SYSEVENT_UPDATE_PROGRESS, TRUE);
                        return;
                    }
                }
            }

            SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
        }

        SaveGame__RestartEvent();
    }
}

void SaveGame__UpdateProgress2_Type6(void)
{
    gameState.saveFile.chaosEmeraldID = -1;
    gameState.saveFile.solEmeraldID   = -1;
    SaveGame__StartSailRivalRace();
}

void SaveGame__UpdateProgress2_Type7(void)
{
    gameState.sailShipType = gameState.sailStoredShipType;

    u8 emerald = gameState.saveFile.chaosEmeraldID;
    if (emerald < 7 && !SaveGame__HasChaosEmerald(&saveGame.chart, emerald))
    {
        SaveGame__SetChaosEmeraldCollected(&saveGame.chart, emerald);
        gameState.saveFile.solEmeraldID = -1;
        SaveGame__StartEmeraldCollected();
    }
    else
    {
        SaveGame__StartSailing();
    }
}

void SaveGame__UpdateProgress2_Type8(void)
{
    if (SaveGame__GetProgressCounter() >= 7)
    {
        SaveGame__ResetProgressCounter();
        if (SaveGame__GetGameProgress() <= SAVE_PROGRESS_37)
            SaveGame__SetGameProgress(SAVE_PROGRESS_38);
        SaveGame__StartExBoss();
    }
    else
    {
        u16 id = _021108EA[SaveGame__GetProgressCounter()];
        SaveGame__IncrementUnknown2ForUnknown();
        SaveGame__StartCutscene(id, SYSEVENT_UPDATE_PROGRESS, SaveGame__GetGameProgress() >= SAVE_PROGRESS_38);
    }
}

void SaveGame__UpdateProgress2_Type9(void)
{
    if (gameState.saveFile.field_52 == 1)
    {
        if (!SaveGame__GetProgressCounter())
        {
            SaveGame__IncrementUnknown2ForUnknown();
            SaveGame__ChangeEvent(SYSEVENT_STAGE_CLEAR_EX);
        }
        else
        {
            SaveGame__ResetProgressCounter();
            gameState.saveFile.field_54 = 1;
            SaveGame__ChangeEvent(SYSEVENT_MAIN_MENU);
        }
    }
    else if (SaveGame__GetProgressCounter() >= 5)
    {
        SaveGame__ResetProgressCounter();

        if (SaveGame__GetGameProgress() <= SAVE_PROGRESS_38)
            SaveGame__SetGameProgress(SAVE_PROGRESS_39);

        gameState.creditsMode = CREDITS_MODE_EXTRA_BOSS_STAGE_SELECT;
        SaveGame__ChangeEvent(SYSEVENT_CREDITS);
    }
    else
    {
        u32 id       = SaveGame__GetProgressCounter();
        u16 cutscene = _021107B4[id];

        SaveGame__IncrementUnknown2ForUnknown();

        if (cutscene != CUTSCENE_INVALID)
        {
            BOOL canSkip;
            if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_39)
                canSkip = TRUE;
            else
                canSkip = FALSE;

            struct GameCutsceneState *cutsceneState = &gameState.cutscene;
            cutsceneState->nextSysEvent             = SYSEVENT_UPDATE_PROGRESS;
            cutsceneState->canSkip                  = canSkip;
            cutsceneState->cutsceneID               = cutscene;

            SaveGame__ChangeEvent(SYSEVENT_CUTSCENE);
        }
        else
        {
            if (id == 1)
            {
                SaveGame__ChangeEvent(SYSEVENT_STAGE_CLEAR_EX);
            }
            else
            {
                gameState.creditsMode = CREDITS_MODE_EXTRA_BOSS;
                SaveGame__ChangeEvent(SYSEVENT_CREDITS);
            }
        }
    }
}

void SaveGame__UpdateProgress2_Type10(void)
{
    SaveGame__IncrementUnknown2ForUnknown();
    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_3);
    SaveGame__RestartEvent();
}

void SaveGame__UpdateProgress2_Type11(void)
{
    u16 stage = _02110B70[gameState.field_80];

    if (gameState.field_80 == 14 && SaveGame__GetGameProgress() < SAVE_PROGRESS_17)
    {
        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
        SaveGame__StartCutscene(CUTSCENE_KYLOK_ISLAND_EMPTY, SYSEVENT_UPDATE_PROGRESS, TRUE);
    }
    else if (gameState.field_80 == 14 && SaveGame__GetGameProgress() > SAVE_PROGRESS_17)
    {
        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
        SaveGame__StartCutscene(CUTSCENE_DAIKUN_ISLAND_EMPTY, SYSEVENT_UPDATE_PROGRESS, TRUE);
    }
    else if (gameState.field_80 == 12 && SaveGame__GetZone6Progress() > SAVE_ZONE6_PROGRESS_1)
    {
        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
        SaveGame__StartCutscene(CUTSCENE_DAIKUN_ISLAND_EMPTY, SYSEVENT_UPDATE_PROGRESS, TRUE);
    }
    else
    {
        for (s32 i = 0; i < SAVE_ISLAND_COUNT; i++)
        {
            if (stage == SaveGame__hiddenIslandList[i] && SaveGame__GetIslandProgress(&saveGame.stage.progress, i) < SAVE_ISLAND_STATE_UNLOCKED)
            {
                SaveGame__SetIslandProgress(&saveGame.stage.progress, i, SAVE_ISLAND_STATE_UNLOCKED);
                SaveGame__ApplySystemProgress();
                break;
            }
        }

        if (stage < STAGE_COUNT)
        {
            gameState.stageID = stage;
            SaveGame__SetProgressType(SAVE_PROGRESSTYPE_3);
            SaveGame__RestartEvent();
        }
        else
        {
            SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
            SaveGame__RestartEvent();
        }
    }
}

BOOL SaveGame__ProgressCheck_Type0(s32 id)
{
    if (id == 1)
    {
        if (!SaveGame__HasDoorPuzzlePiece(0))
            return FALSE;

        if (!SaveGame__HasDoorPuzzlePiece(1))
            return FALSE;

        if (!SaveGame__HasDoorPuzzlePiece(2))
            return FALSE;
    }

    return TRUE;
}

BOOL SaveGame__ProgressCheck_Type1(s32 id)
{
    return TRUE;
}

BOOL SaveGame__ProgressCheck_Type2(s32 id)
{
    return id == gameState.sailShipType;
}

BOOL SaveGame__ProgressCheck_Type3(s32 id)
{
    return id == gameState.stageID;
}

BOOL SaveGame__ProgressCheck_Type4(s32 id)
{
    return FALSE;
}

BOOL SaveGame__ProgressCheck_Type5(s32 id)
{
    return id == gameState.stageID;
}

BOOL SaveGame__ProgressCheck_Type6(s32 id)
{
    return TRUE;
}

BOOL SaveGame__ProgressCheck_Type7(s32 id)
{
    return TRUE;
}

BOOL SaveGame__ProgressCheck_Type8(s32 id)
{
    return TRUE;
}

BOOL SaveGame__ProgressCheck_Type9(s32 id)
{
    return TRUE;
}

BOOL SaveGame__ProgressCheck_Type10(s32 id)
{
    return TRUE;
}

BOOL SaveGame__ProgressCheck_Type11(s32 id)
{
    return id == gameState.field_80;
}

void SaveGame__UpdateProgress1_Func_205CB60(SaveGameNextAction *action)
{
    u16 cutscene = action->id;

    if (cutscene == CUTSCENE_LEGENDARY_ANCIENT_RUINS_1)
    {
        if (SaveGame__GetZone6Progress() == SAVE_ZONE6_PROGRESS_6)
            cutscene = CUTSCENE_PIRATE_HIDEOUT_IN_DEPTHS_1;
    }
    else if (cutscene == CUTSCENE_LEGENDARY_ANCIENT_RUINS_2)
    {
        if (SaveGame__GetZone5Progress() != SAVE_ZONE5_PROGRESS_4)
            cutscene = CUTSCENE_PIRATE_HIDEOUT_IN_DEPTHS_2;
    }
    else
    {
        if (cutscene == CUTSCENE_KYLOK_FOUND || cutscene == CUTSCENE_DAIKUN_DISCOVERED)
            SaveGame__SetProgressType(SAVE_PROGRESSTYPE_0);
    }

    SaveGame__StartCutscene(cutscene, action->nextSysEvent, FALSE);
}

void SaveGame__UpdateProgress1_Func_205CBC4(SaveGameNextAction *action)
{
    SaveGame__StartTutorial();
}

void SaveGame__UpdateProgress1_Func_205CBD0(SaveGameNextAction *action)
{
    SaveGame__StartEvent37();
}

void SaveGame__UpdateProgress1_Func_205CBDC(SaveGameNextAction *action)
{
    SaveGame__StartSailJetTraining();
}

void SaveGame__UpdateProgress1_Func_205CBE8(SaveGameNextAction *action)
{
    SaveGame__StartHubMenu();
}

void SaveGame__UpdateProgress1_Func_205CBF4(SaveGameNextAction *action)
{
    SaveGame__StartDoorPuzzle(action->id);
}

void SaveGame__UpdateProgress1_Func_205CC04(SaveGameNextAction *action)
{
    if (action->id == 0)
        SeaMapManager__SetUnknown1(0);
    else
        SeaMapManager__SetUnknown1(1);

    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_5);
    SaveGame__ChangeEvent(SYSEVENT_SEAMAPCUTSCENE);
}

void SaveGame__UpdateProgress1_Func_205CC3C(SaveGameNextAction *action)
{
    if (action->id == 24)
        SaveGame__EnableStateFlags(2);

    gameState.stageID = action->id;
    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_3);
    SaveGame__RestartEvent();
}

void SaveGame__ChangeEvent(s32 sysEvent)
{
    RequestNewSysEventChange((s16)sysEvent);
    NextSysEvent();
}

void SaveGame__RestartEvent(void)
{
    SaveGame__ChangeEvent((u16)GetSysEventList()->currentEventID);
}

void SaveGame__StartCutscene(u16 cutsceneID, s32 nextEvent, BOOL flag)
{
    u16 cutsceneIDList[] = { CUTSCENE_OCEAN_TORNADO_LAUNCH, CUTSCENE_AQUA_BLAST_LAUNCH, CUTSCENE_DEEP_TYPHOON_LAUNCH };

    if (nextEvent == SYSEVENT_NONE)
        nextEvent = (u16)GetSysEventList()->currentEventID;

    struct GameCutsceneState *state = &gameState.cutscene;
    state->nextSysEvent             = nextEvent;
    state->cutsceneID               = cutsceneID;
    state->canSkip                  = TRUE;

    for (u32 i = 0; i < 3; i++)
    {
        if (cutsceneID == cutsceneIDList[i])
        {
            SaveGame__EnableStateFlags(1);
            break;
        }
    }

    SaveGame__ChangeEvent(SYSEVENT_CUTSCENE);
}

void SaveGame__StartTutorial(void)
{
    gameState.characterID[0] = CHARACTER_SONIC;
    gameState.gameMode       = GAMEMODE_STORY;
    gameState.stageID        = STAGE_TUTORIAL;

    SaveGame__ChangeEvent(SYSEVENT_LOAD_STAGE);
}

void SaveGame__StartEvent37(void)
{
    SaveGame__ChangeEvent(SYSEVENT_SEAMAP_TRAINING);
}

void SaveGame__StartSailJetTraining(void)
{
    gameState.missionType                 = MISSION_TYPE_TRAINING;
    gameState.missionConfig.sail.courseID = 1;
    gameState.missionConfig.sail.unknown  = 1;
    gameState.sailShipType                = SHIP_JET;

    SaveGame__ChangeEvent(SYSEVENT_SAILING);
}

void SaveGame__StartHubMenu(void)
{
    SaveGame__ChangeEvent(SYSEVENT_RETURN_TO_HUB);
}

void SaveGame__StartSeaMapUnknown(void)
{
    SaveGame__ChangeEvent(SYSEVENT_SEAMAP_UNKNOWN);
}

void SaveGame__StartSailing(void)
{
    SaveGame__ChangeEvent(SYSEVENT_SAILING);
}

void SaveGame__StartStoryMode(void)
{
    gameState.gameMode = GAMEMODE_STORY;

    SaveGame__ChangeEvent(SYSEVENT_LOAD_STAGE);
}

void SaveGame__StartSailRivalRace(void)
{
    gameState.sailStoredShipType = gameState.sailShipType;
    gameState.sailShipType       = SHIP_JET;

    SaveGame__ChangeEvent(SYSEVENT_SAILING);
}

void SaveGame__StartExBoss(void)
{
    SaveGame__ChangeEvent(SYSEVENT_EXBOSS);
}

void SaveGame__StartDoorPuzzle(BOOL flag)
{
    if (flag == FALSE)
    {
        gameState.doorPuzzleEvent = DOORPUZZLE_EVENT_DISCOVERY;
    }
    else
    {
        if (SaveGame__GetGameProgress() <= SAVE_PROGRESS_31)
            gameState.doorPuzzleEvent = DOORPUZZLE_EVENT_NO_ACCESS;
        else
            gameState.doorPuzzleEvent = DOORPUZZLE_EVENT_HAVE_KEYS;
    }

    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_10);
    SaveGame__ChangeEvent(SYSEVENT_DOOR_PUZZLE);
}

void SaveGame__StartStageSelect(void)
{
    gameState.gameMode = GAMEMODE_STORY;

    SaveGame__ChangeEvent(SYSEVENT_7);
}

void SaveGame__StartEmeraldCollected(void)
{
    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_7);
    SaveGame__ChangeEvent(SYSEVENT_EMERALD_COLLECTED);
}

void SaveGame__IncrementGameProgress(void)
{
    SaveGame__SetGameProgress(saveGame.stage.progress.gameProgress + 1);
}

void SaveGame__IncrementUnknownProgress1(void)
{
    SaveGame__SetZone5Progress(saveGame.stage.progress.zone5Progress + 1);
}

void SaveGame__IncrementUnknownProgress2(void)
{
    SaveGame__SetZone6Progress(saveGame.stage.progress.zone6Progress + 1);
}

void SaveGame__IncrementProgressCounter(void)
{
    gameState.saveFile.progressCounter++;
}

void SaveGame__ResetProgressCounter(void)
{
    gameState.saveFile.progressCounter = 0;
}

s32 SaveGame__GetProgressType(void)
{
    return gameState.saveFile.progressType;
}

BOOL SaveGame__GetStateFlag(u16 id)
{
    return (id & gameState.saveFile.flags) != 0;
}

void SaveGame__EnableStateFlags(u16 mask)
{
    gameState.saveFile.flags |= mask;
}

void SaveGame__DisableStateFlags(u16 mask)
{
    gameState.saveFile.flags &= ~mask;
}

void SaveGame__ApplySystemProgress(void)
{
    SaveGameProgress *stageProgress  = &saveGame.stage.progress;
    SaveGameProgress *systemProgress = &saveGame.system.progress;

    if (systemProgress->gameProgress < stageProgress->gameProgress)
    {
        systemProgress->gameProgress = stageProgress->gameProgress;

        if ((stageProgress->flags & 0x100) != 0)
            systemProgress->flags |= 0x100;
        else
            systemProgress->flags &= ~0x100;
    }
    else
    {
        if (systemProgress->gameProgress == stageProgress->gameProgress && (stageProgress->flags & 0x100) != 0)
            systemProgress->flags |= 0x100;
    }

    if (systemProgress->zone5Progress <= stageProgress->zone5Progress)
    {
        systemProgress->zone5Progress = stageProgress->zone5Progress;

        if (stageProgress->zone5Progress == SAVE_ZONE5_PROGRESS_2 && (stageProgress->flags & 0x200) != 0)
            systemProgress->flags |= 0x200;
    }

    if (systemProgress->zone6Progress <= stageProgress->zone6Progress)
    {
        systemProgress->zone6Progress = stageProgress->zone6Progress;

        if (stageProgress->zone6Progress == SAVE_ZONE6_PROGRESS_4 && (stageProgress->flags & 0x400) != 0)
            systemProgress->flags |= 0x400;
    }

    systemProgress->flags |= stageProgress->flags & ~(0x1 | 0x700 | 0xFFF00000);

    for (s32 i = 0; i < SAVE_ISLAND_COUNT; i++)
    {
        s32 islandProgress = SaveGame__GetIslandProgress(stageProgress, i);
        if (SaveGame__GetIslandProgress(systemProgress, i) < islandProgress)
            SaveGame__SetIslandProgress(systemProgress, i, islandProgress);
    }
}

void SaveGame__SetProgressFlags_0x100(void)
{
    saveGame.stage.progress.flags |= 0x100;
}

void SaveGame__SetProgressFlags_0x200(void)
{
    saveGame.stage.progress.flags |= 0x200;
}

void SaveGame__SetProgressFlags_0x400(void)
{
    saveGame.stage.progress.flags |= 0x400;
}

void SaveGame__RemoveProgressFlags_0x100(void)
{
    saveGame.stage.progress.flags &= ~0x100;
}

void SaveGame__RemoveProgressFlags_0x200(void)
{
    saveGame.stage.progress.flags &= ~0x200;
}

void SaveGame__RemoveProgressFlags_0x400(void)
{
    saveGame.stage.progress.flags &= ~0x400;
}

BOOL SaveGame__Func_205D150(s32 stageID)
{
    u8 gameProgress  = SaveGame__GetGameProgress();
    u8 zone5Progress = SaveGame__GetZone5Progress();
    u8 zone6Progress = SaveGame__GetZone6Progress();

    BOOL flag100;
    if ((saveGame.stage.progress.flags & 0x100) != 0)
        flag100 = TRUE;
    else
        flag100 = FALSE;

    BOOL flag200;
    if ((saveGame.stage.progress.flags & 0x200) != 0)
        flag200 = TRUE;
    else
        flag200 = FALSE;

    BOOL flag400;
    if ((saveGame.stage.progress.flags & 0x400) != 0)
        flag400 = TRUE;
    else
        flag400 = FALSE;

    BOOL result = FALSE;
    if (stageID <= STAGE_BOSS_FINAL)
    {
        SaveGameUnknown205D150 *progress = &_02110C20[stageID];

        if (progress->gameProgress != 0xFF && progress->gameProgress != gameProgress)
        {
            return FALSE;
        }

        if (progress->zone5Progress != 0xFF && progress->zone5Progress != zone5Progress)
        {
            return FALSE;
        }

        if (progress->zone6Progress != 0xFF && progress->zone6Progress != zone6Progress)
        {
            return FALSE;
        }

        switch (progress->mode)
        {
            case 1:
                if (flag100)
                    return FALSE;
                break;

            case 2:
                if (!flag100)
                    return FALSE;
                break;

            case 3:
                if (flag200)
                    return FALSE;
                break;

            case 4:
                if (!flag200)
                    return FALSE;
                break;

            case 5:
                if (flag400)
                    return FALSE;
                break;

            case 6:
                if (!flag400)
                    return FALSE;
                break;
        }

        return TRUE;
    }
    else
    {
        if (stageID <= STAGE_HIDDEN_ISLAND_5)
            return !SaveGame__HasDoorPuzzlePiece(stageID - STAGE_HIDDEN_ISLAND_3);
        else
            return FALSE;
    }
}

NONMATCH_FUNC BOOL SaveGame__IsShipUnlocked(ShipType ship)
{
    // will match when shipUnlockProgress (0x02110CF0) is decompiled
#ifdef NON_MATCHING
    u32 shipUnlockProgress[] = { SAVE_PROGRESS_2, SAVE_PROGRESS_9, SAVE_PROGRESS_22, SAVE_PROGRESS_26 };

    return SaveGame__GetGameProgress() >= shipUnlockProgress[id];
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	ldr r1, =SaveGame_ShipUnlockProgress
	add ip, sp, #0
	mov r4, r0
	ldmia r1, {r0, r1, r2, r3}
	stmia ip, {r0, r1, r2, r3}
	bl SaveGame__GetGameProgress
	add r1, sp, #0
	ldr r1, [r1, r4, lsl #2]
	cmp r0, r1
	movge r0, #1
	movlt r0, #0
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}

// clang-format on
#endif
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

BOOL SaveGame__CheckProgress12(void)
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

BOOL SaveGame__GetProgressFlags_0x10(void)
{
    return (saveGame.stage.progress.flags & 0x10) != 0;
}

void SaveGame__SetProgressFlags_0x10(void)
{
    saveGame.stage.progress.flags |= 0x10;
}

BOOL SaveGame__CanBuyDecoration(u16 id)
{
    s32 gameProgress  = SaveGame__GetGameProgress();
    s32 zone5Progress = SaveGame__GetZone5Progress();
    s32 zone6Progress = SaveGame__GetZone6Progress();

    if (gameProgress >= _02110D00[id].gameProgress && zone5Progress >= _02110D00[id].zone5Progress && zone6Progress >= _02110D00[id].zone6Progress)
        return TRUE;
    else
        return FALSE;
}

BOOL SaveGame__GetBoughtDecoration(u16 id)
{
    return (saveGame.stage.progress.flags & (0x20 << id)) != 0;
}

void SaveGame__SetBoughtDecoration(u16 id)
{
    saveGame.stage.progress.flags |= 0x20 << id;
}

BOOL SaveGame__GetProgressFlags_0x100000(u32 id)
{
    return (saveGame.stage.progress.flags & (0x100000 << id)) != 0;
}

void SaveGame__SetProgressFlags_0x100000(u32 id)
{
    saveGame.stage.progress.flags |= 0x100000 << id;
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

NONMATCH_FUNC s32 SaveGame__Func_205D65C(s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #4
	bl SaveGame__GetGameProgress
	and r10, r0, #0xff
	bl SaveGame__GetZone5Progress
	strb r0, [sp]
	bl SaveGame__GetZone6Progress
	mov r8, #0
	ldr r9, =_02110D48
	ldr r6, =_02110D12
	mov r7, r8
	strb r0, [sp, #1]
	add r5, sp, #0
	mov r4, #6
_0205D694:
	ldrh r0, [r9, #0]
	cmp r10, r0
	blt _0205D734
	ldrh r0, [r9, #2]
	cmp r10, r0
	bge _0205D734
	ldrh r0, [r9, #4]
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	movs r0, r0, asr #0x10
	bmi _0205D6E8
	smulbb r0, r0, r4
	ldrh r1, [r6, r0]
	add r2, r6, r0
	ldrh r0, [r2, #2]
	ldrb r1, [r5, r1]
	cmp r1, r0
	blt _0205D734
	ldrh r0, [r2, #4]
	cmp r1, r0
	bge _0205D734
_0205D6E8:
	cmp r7, #0xc
	blt _0205D728
	cmp r7, #0xe
	bgt _0205D728
	sub r0, r7, #0xc
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetProgressFlags_0x100000
	cmp r0, #0
	beq _0205D734
	sub r0, r7, #0xc
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__HasDoorPuzzlePiece
	cmp r0, #0
	bne _0205D734
_0205D728:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
_0205D734:
	add r7, r7, #1
	cmp r7, #0xf
	add r9, r9, #6
	blt _0205D694
	mov r0, r8
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 SaveGame__Func_205D758(s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r10, r0
	bl SaveGame__GetGameProgress
	and r9, r0, #0xff
	bl SaveGame__GetZone5Progress
	strb r0, [sp]
	bl SaveGame__GetZone6Progress
	mov r7, #0
	ldr r8, =_02110D48
	ldr r5, =_02110D12
	mov r6, r7
	strb r0, [sp, #1]
	add r4, sp, #0
	mov r11, #6
_0205D790:
	ldrh r0, [r8, #0]
	cmp r9, r0
	blt _0205D848
	ldrh r0, [r8, #2]
	cmp r9, r0
	bge _0205D848
	ldrh r0, [r8, #4]
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	movs r0, r0, asr #0x10
	bmi _0205D7E4
	smulbb r0, r0, r11
	ldrh r1, [r5, r0]
	add r2, r5, r0
	ldrh r0, [r2, #2]
	ldrb r1, [r4, r1]
	cmp r1, r0
	blt _0205D848
	ldrh r0, [r2, #4]
	cmp r1, r0
	bge _0205D848
_0205D7E4:
	cmp r6, #0xc
	blt _0205D824
	cmp r6, #0xe
	bgt _0205D824
	sub r0, r6, #0xc
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetProgressFlags_0x100000
	cmp r0, #0
	beq _0205D848
	sub r0, r6, #0xc
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__HasDoorPuzzlePiece
	cmp r0, #0
	bne _0205D848
_0205D824:
	cmp r10, r7
	bne _0205D83C
	ldr r0, =_02110D2A
	mov r1, r6, lsl #1
	ldrh r0, [r0, r1]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0205D83C:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
_0205D848:
	add r6, r6, #1
	cmp r6, #0xf
	add r8, r8, #6
	blt _0205D790
	mov r0, #0x2a
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

ShipLevel SaveGame__GetShipUpgradeStatus(u16 id)
{
    return SaveGame__GetShipUpgradeStatus_(id, saveGame.stage.progress.flags);
}

ShipLevel SaveGame__GetShipUpgradeStatus_(u16 id, u32 flags)
{
    if ((flags & (0x800 << (2 * id))) == 0)
        return SHIP_LEVEL_0;

    if ((flags & ((0x800 << (2 * id)) << 1)) != 0)
        return SHIP_LEVEL_2;

    return SHIP_LEVEL_1;
}

#include <nitro/codereset.h>