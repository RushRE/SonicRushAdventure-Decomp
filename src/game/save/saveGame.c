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

typedef struct SaveGameUnknown205D150_
{
    u8 gameProgress;
    u8 unknownProgress1;
    u8 unknownProgress2;
    u8 mode;
} SaveGameUnknown205D150;

typedef struct SaveGameUnknown205D65C_
{
    u16 gameProgress;
    u16 unknownProgress1;
    u16 unknownProgress2;
} SaveGameUnknown205D65C;

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void (*SaveGame__UnknownTable2[])(void);
NOT_DECOMPILED u16 SaveGame_cutsceneIDList[];
NOT_DECOMPILED BOOL (*SaveGame__ProgressCheckTable[])(s32 id);
NOT_DECOMPILED void (*SaveGame__SaveDataCallbacks[])(SaveGame *saveGame, SaveBlockFlags blockFlags);
NOT_DECOMPILED void *SaveGame__LoadDataCallbacks;
NOT_DECOMPILED void (*SaveGame__ClearDataCallbacks[])(SaveGame *saveGame, SaveBlockFlags blockFlags);
NOT_DECOMPILED void *_02110DDC;
NOT_DECOMPILED void (*SaveGame__UnknownTable1[])(SaveGameNextAction *state);
NOT_DECOMPILED const char *aSonicRush2;
NOT_DECOMPILED SaveGameNextAction *SaveGame__gameProgressUnknown[40];
NOT_DECOMPILED SaveGameNextAction *SaveGame__unknownProgress1Unknown[5];
NOT_DECOMPILED SaveGameNextAction *SaveGame__unknownProgress2Unknown[7];
NOT_DECOMPILED size_t savedataBlockSizes[9];
NOT_DECOMPILED size_t savedataBlockOffsets[9];
NOT_DECOMPILED u16 _021108DC[];
NOT_DECOMPILED u16 _021108EA[];
NOT_DECOMPILED u32 SaveGame_ShipUnlockProgress[];
NOT_DECOMPILED u16 SaveGame__hiddenIslandList[];
NOT_DECOMPILED u16 SaveGame__nextStage[];
NOT_DECOMPILED u16 _021107AE[];

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

void SaveGame__SetUnknown1(s32 value)
{
    gameState.saveFile.unknown1 = value;
}

SaveProgress SaveGame__GetGameProgress(void)
{
    return saveGame.stage.progress.gameProgress;
}

void SaveGame__SetGameProgress(SaveProgress progress)
{
    saveGame.stage.progress.gameProgress = progress;
    gameState.saveFile.unknown2          = 0;

    if (progress < SAVE_PROGRESS_24)
    {
        saveGame.stage.progress.unknownProgress1 = 0;
        saveGame.stage.progress.unknownProgress2 = 0;
    }
    else if (progress >= SAVE_PROGRESS_25)
    {
        saveGame.stage.progress.unknownProgress1 = 4;
        saveGame.stage.progress.unknownProgress2 = 6;
    }
    else
    {
        if (saveGame.stage.progress.unknownProgress1 == 0)
            saveGame.stage.progress.unknownProgress1 = 1;

        if (saveGame.stage.progress.unknownProgress2 == 0)
            saveGame.stage.progress.unknownProgress2 = 1;
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

u8 SaveGame__GetUnknown2(void)
{
    return gameState.saveFile.unknown2;
}

s32 SaveGame__GetUnknownProgress1(void)
{
    return saveGame.stage.progress.unknownProgress1;
}

void SaveGame__SetUnknownProgress1(s32 progress)
{
    saveGame.stage.progress.unknownProgress1 = progress;
    gameState.saveFile.unknown2              = 0;
    saveGame.stage.progress.flags &= ~1;

    SaveGame__RemoveProgressFlags_0x200();
    SaveGame__ApplySystemProgress();
}

s32 SaveGame__GetUnknownProgress2(void)
{
    return saveGame.stage.progress.unknownProgress2;
}

void SaveGame__SetUnknownProgress2(s32 progress)
{
    saveGame.stage.progress.unknownProgress2 = progress;
    gameState.saveFile.unknown2              = 0;
    saveGame.stage.progress.flags |= 1;

    SaveGame__RemoveProgressFlags_0x400();
    SaveGame__ApplySystemProgress();
}

void SaveGame__Func_205BBBC(void)
{
    gameState.saveFile.unknown2++;
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

void SaveGame__Func_205BC18(void)
{
    SaveGame__SetGameProgress(SAVE_PROGRESS_25);
}

void SaveGame__Func_205BC28(void)
{
    SaveGame__SetGameProgress(SAVE_PROGRESS_31);
}

void SaveGame__Func_205BC38(u32 type)
{
    switch (type)
    {
        case SHIP_JET:
            SaveGame__SetGameProgress(SAVE_PROGRESS_10);
            break;

        case SHIP_BOAT:
            SaveGame__SetGameProgress(SAVE_PROGRESS_23);
            break;

        case SHIP_HOVER:
            SaveGame__SetGameProgress(SAVE_PROGRESS_27);
            break;
    }
}

BOOL SaveGame__Func_205BC7C(void)
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

void SaveGame__Block1__SetFlags1_0x80000(void)
{
    saveGame.stage.progress.flags |= 0x80000;
    SaveGame__ApplySystemProgress();
}

BOOL SaveGame__Func_205BF24(void)
{
    if (saveGame.stage.progress.gameProgress >= SAVE_PROGRESS_2)
        return TRUE;

    if (saveGame.stage.progress.gameProgress < SAVE_PROGRESS_1)
        return FALSE;

    return (saveGame.system.progress.flags & 0x80000) != 0;
}

void SaveGame__Func_205BF5C(s32 id)
{
    SaveGame__EnableStateFlags(4 << id);
}

BOOL SaveGame__Func_205BF78(s32 id)
{
    if (id == 0)
        return TRUE;

    return SaveGame__GetStateFlag(4 << id);
}

void SaveGame__SaveClearCallback_Stage(SaveGame *save, SaveBlockFlags blockFlags)
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
        SaveGame__UnknownTable2[SaveGame__GetUnknown1()]();
    }
}

SaveGameNextAction *SaveGame__GetNextActionFromProgress(void)
{
    SaveGameNextAction *config;
	
    u16 gameProgress;
    u16 unknownProgress1;
    u16 unknownProgress2;
    u16 unknown1;
    u16 unknown2;

    gameProgress     = SaveGame__GetGameProgress();
    unknownProgress1 = SaveGame__GetUnknownProgress1();
    unknownProgress2 = SaveGame__GetUnknownProgress2();

    unknown1         = SaveGame__GetUnknown2();
    unknown2         = SaveGame__GetUnknown1();

    if (unknown2 == 4)
        unknown2 = 3;

    if (unknown2 == 5)
    {
        if (SaveGame__Func_205D150(gameState.stageID))
        {
            SaveGame__GsExit(0);
        }
    }
    else if (unknown2 == 9)
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
            if (unknown1 < count)
            {
                config = SaveGame__gameProgressUnknown[gameProgress];

                if (config != NULL)
                {
                    config += unknown1;

                    if (config->field_0 < 12 && (config->field_0 != unknown2 || !SaveGame__ProgressCheckTable[unknown2](config->progressCheckValue)))
                    {
                        config = NULL;
                    }
                    else
                    {
                        if (config->allowProgressIncrement)
                        {
                            if (unknown1 + 1 < count)
                            {
                                SaveGame__IncrementUnknown2();
                            }
                            else
                            {
                                SaveGame__IncrementGameProgress();
                                SaveGame__ResetUnknown2();
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
                count = _021107BE[unknownProgress1];

                if (unknown1 < count)
                {
                    config = SaveGame__unknownProgress1Unknown[unknownProgress1];

                    if (config != NULL)
                    {
                        config += unknown1;

                        if (config->field_0 < 12 && (config->field_0 != unknown2 || !SaveGame__ProgressCheckTable[unknown2](config->progressCheckValue)))
                        {
                            config = NULL;
                        }
                        else
                        {
                            if (config->allowProgressIncrement)
                            {
                                if (unknown1 + 1 < count)
                                {
                                    SaveGame__IncrementUnknown2();
                                }
                                else
                                {
                                    SaveGame__IncrementUnknownProgress1();
                                    SaveGame__ResetUnknown2();
                                }
                            }

                            SaveGame__GsExit(0);
                        }
                    }
                }
            }

            if (config == NULL)
            {
                count = _021108DC[unknownProgress2];

                if (unknown1 < count)
                {
                    config = SaveGame__unknownProgress2Unknown[unknownProgress2];
                    if (config != NULL)
                    {
                        config += unknown1;

                        if (config->field_0 < 12 && (config->field_0 != unknown2 || !SaveGame__ProgressCheckTable[unknown2](config->progressCheckValue)))
                        {
                            config = NULL;
                        }
                        else
                        {
                            if (config->allowProgressIncrement)
                            {
                                if (unknown1 + 1 < count)
                                {
                                    SaveGame__IncrementUnknown2();
                                }
                                else
                                {
                                    SaveGame__IncrementUnknownProgress2();
                                    SaveGame__ResetUnknown2();
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

void SaveGame__UpdateProgress2_Func_205C28C(void)
{
    SaveGame__ChangeEvent(SYSEVENT_RETURN_TO_HUB);
}

void SaveGame__UpdateProgress2_Func_205C29C(void)
{
    SaveGame__StartEvent35();
}

void SaveGame__UpdateProgress2_Func_205C2A8(void)
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

        SaveGame__SetUnknown1(2);
        SaveGame__EnableStateFlags(1);
        SaveGame__StartCutscene(cutscene, SYSEVENT_UPDATE_PROGRESS, TRUE);
    }
}

void SaveGame__UpdateProgress2_Func_205C344(void)
{
    if (gameState.stageID == STAGE_Z71 && SaveGame__GetGameProgress() < SAVE_PROGRESS_33)
    {
        SaveGame__StartDoorPuzzle(1);
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

void SaveGame__UpdateProgress2_Func_205C39C(void)
{
    SaveGame__StartStoryMode();
}

void SaveGame__UpdateProgress2_Func_205C3A8(void)
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
        if (SaveGame__GetUnknownProgress1() == 2)
            SaveGame__SetBoughtInfo0();
    }
    else if (stageID == STAGE_Z61)
    {
        if (SaveGame__GetUnknownProgress2() == 4)
            SaveGame__SetProgressFlags_0x400();
    }
    else if (stageID == STAGE_Z71)
    {
        if (SaveGame__GetGameProgress() == SAVE_PROGRESS_33)
            SaveGame__SetProgressFlags_0x100();
    }

    for (s32 s = 0; s < 14; s++)
    {
        if (stageID == SaveGame__hiddenIslandList[s] && SaveGame__GetIslandProgress(&saveGame.stage.progress, s) < 2)
        {
            SaveGame__SetIslandProgress(&saveGame.stage.progress, s, 2);
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
            gameState.stageID = nextStage;
            SaveGame__SetUnknown1(4);
        }
        else if (stageID == STAGE_BOSS_FINAL)
        {
            static const u16 cutsceneIDList[] = { CUTSCENE_GHOST_TITANS_IMPACT, CUTSCENE_ENDING, CUTSCENE_INVALID };

            u16 cutsceneID = cutsceneIDList[SaveGame__GetUnknown2()];
            SaveGame__Func_205BBBC();
            if (SaveGame__GetUnknown2() >= 3)
            {
                SaveGame__ResetUnknown2();
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
                    SaveGame__SetUnknown1(0);
                    SaveGame__StartCutscene(CUTSCENE_MYSTERIOUS_MARKER_NO_1, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }
                else
                {
                    if (!SaveGame__HasDoorPuzzlePiece(0))
                    {
                        SaveGame__GetPuzzlePiece(0);
                        SaveGame__SetUnknown1(0);
                        SaveGame__StartCutscene(CUTSCENE_CLUE_NO_1, SYSEVENT_UPDATE_PROGRESS, TRUE);
                        return;
                    }
                }
            }
            else if (stageID == STAGE_HIDDEN_ISLAND_4)
            {
                if (SaveGame__GetGameProgress() < SAVE_PROGRESS_29)
                {
                    SaveGame__SetUnknown1(0);
                    SaveGame__StartCutscene(CUTSCENE_MYSTERIOUS_MARKER_NO_2, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }

                if (!SaveGame__HasDoorPuzzlePiece(1))
                {
                    SaveGame__GetPuzzlePiece(1);
                    SaveGame__SetUnknown1(0);
                    SaveGame__StartCutscene(CUTSCENE_CLUE_NO_2, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }
            }
            else if (stageID == STAGE_HIDDEN_ISLAND_5)
            {
                if (SaveGame__GetGameProgress() < SAVE_PROGRESS_29)
                {
                    SaveGame__SetUnknown1(0);
                    SaveGame__StartCutscene(CUTSCENE_MYSTERIOUS_MARKER_NO_1, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }
                else
                {
                    if (!SaveGame__HasDoorPuzzlePiece(2))
                    {
                        SaveGame__GetPuzzlePiece(2);
                        SaveGame__SetUnknown1(0);
                        SaveGame__StartCutscene(CUTSCENE_CLUE_NO_3, SYSEVENT_UPDATE_PROGRESS, TRUE);
                        return;
                    }
                }
            }

            SaveGame__SetUnknown1(0);
        }

        SaveGame__RestartEvent();
    }
}

void SaveGame__UpdateProgress2_Func_205C700(void)
{
    gameState.saveFile.chaosEmeraldID = -1;
    gameState.saveFile.solEmeraldID = -1;
    SaveGame__StartSailRivalRace();
}

void SaveGame__UpdateProgress2_Func_205C720(void)
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

void SaveGame__UpdateProgress2_Func_205C780(void)
{
    if (SaveGame__GetUnknown2() >= 7)
    {
        SaveGame__ResetUnknown2();
        if (SaveGame__GetGameProgress() <= SAVE_PROGRESS_37)
            SaveGame__SetGameProgress(SAVE_PROGRESS_38);
        SaveGame__StartExBoss();
    }
    else
    {
        u16 id = _021108EA[SaveGame__GetUnknown2()];
        SaveGame__Func_205BBBC();
        SaveGame__StartCutscene(id, SYSEVENT_UPDATE_PROGRESS, SaveGame__GetGameProgress() >= SAVE_PROGRESS_38);
    }
}

void SaveGame__UpdateProgress2_Func_205C7E8(void)
{
    if (gameState.saveFile.field_52 == 1)
    {
        if (!SaveGame__GetUnknown2())
        {
            SaveGame__Func_205BBBC();
            SaveGame__ChangeEvent(SYSEVENT_STAGE_CLEAR_EX);
        }
        else
        {
            SaveGame__ResetUnknown2();
            gameState.saveFile.field_54 = 1;
            SaveGame__ChangeEvent(SYSEVENT_MAIN_MENU);
        }
    }
    else if (SaveGame__GetUnknown2() >= 5)
    {
        SaveGame__ResetUnknown2();

        if (SaveGame__GetGameProgress() <= SAVE_PROGRESS_38)
            SaveGame__SetGameProgress(SAVE_PROGRESS_39);

        gameState.creditsMode = CREDITS_MODE_EXTRA_BOSS_STAGE_SELECT;
        SaveGame__ChangeEvent(SYSEVENT_CREDITS);
    }
    else
    {
        u32 id       = SaveGame__GetUnknown2();
        u16 cutscene = _021107B4[id];

        SaveGame__Func_205BBBC();

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

void SaveGame__UpdateProgress2_Func_205C904(void)
{
    SaveGame__Func_205BBBC();
    SaveGame__SetUnknown1(3);
    SaveGame__RestartEvent();
}

void SaveGame__UpdateProgress2_Func_205C91C(void)
{
    u16 stage = _02110B70[gameState.field_80];

    if (gameState.field_80 == 14 && SaveGame__GetGameProgress() < SAVE_PROGRESS_17)
    {
        SaveGame__SetUnknown1(0);
        SaveGame__StartCutscene(CUTSCENE_KYLOK_ISLAND_EMPTY, SYSEVENT_UPDATE_PROGRESS, TRUE);
    }
    else if (gameState.field_80 == 14 && SaveGame__GetGameProgress() > SAVE_PROGRESS_17)
    {
        SaveGame__SetUnknown1(0);
        SaveGame__StartCutscene(CUTSCENE_DAIKUN_ISLAND_EMPTY, SYSEVENT_UPDATE_PROGRESS, TRUE);
    }
    else if (gameState.field_80 == 12 && SaveGame__GetUnknownProgress2() > 1)
    {
        SaveGame__SetUnknown1(0);
        SaveGame__StartCutscene(CUTSCENE_DAIKUN_ISLAND_EMPTY, SYSEVENT_UPDATE_PROGRESS, TRUE);
    }
    else
    {
        for (s32 i = 0; i < 14; i++)
        {
            if (stage == SaveGame__hiddenIslandList[i] && SaveGame__GetIslandProgress(&saveGame.stage.progress, i) < 1)
            {
                SaveGame__SetIslandProgress(&saveGame.stage.progress, i, 1);
                SaveGame__ApplySystemProgress();
                break;
            }
        }

        if (stage < STAGE_COUNT)
        {
            gameState.stageID = stage;
            SaveGame__SetUnknown1(3);
            SaveGame__RestartEvent();
        }
        else
        {
            SaveGame__SetUnknown1(0);
            SaveGame__RestartEvent();
        }
    }
}

BOOL SaveGame__ProgressCheckFunc_205CA68(s32 id)
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

BOOL SaveGame__ProgressCheckFunc_205CAB8(s32 id)
{
    return TRUE;
}

BOOL SaveGame__ProgressCheckFunc_205CAC0(s32 id)
{
    return id == gameState.sailShipType;
}

BOOL SaveGame__ProgressCheckFunc_205CADC(s32 id)
{
    return id == gameState.stageID;
}

BOOL SaveGame__ProgressCheckFunc_205CAF8(s32 id)
{
    return FALSE;
}

BOOL SaveGame__ProgressCheckFunc_205CB00(s32 id)
{
    return id == gameState.stageID;
}

BOOL SaveGame__ProgressCheckFunc_205CB1C(s32 id)
{
    return TRUE;
}

BOOL SaveGame__ProgressCheckFunc_205CB24(s32 id)
{
    return TRUE;
}

BOOL SaveGame__ProgressCheckFunc_205CB2C(s32 id)
{
    return TRUE;
}

BOOL SaveGame__ProgressCheckFunc_205CB34(s32 id)
{
    return TRUE;
}

BOOL SaveGame__ProgressCheckFunc_205CB3C(s32 id)
{
    return TRUE;
}

BOOL SaveGame__ProgressCheckFunc_205CB44(s32 id)
{
    return id == gameState.field_80;
}

void SaveGame__UpdateProgress1_Func_205CB60(SaveGameNextAction *a1)
{
    u16 cutscene = a1->id;

    if (cutscene == CUTSCENE_LEGENDARY_ANCIENT_RUINS_1)
    {
        if (SaveGame__GetUnknownProgress2() == 6)
            cutscene = CUTSCENE_PIRATE_HIDEOUT_IN_DEPTHS_1;
    }
    else if (cutscene == CUTSCENE_LEGENDARY_ANCIENT_RUINS_2)
    {
        if (SaveGame__GetUnknownProgress1() != 4)
            cutscene = CUTSCENE_PIRATE_HIDEOUT_IN_DEPTHS_2;
    }
    else
    {
        if (cutscene == CUTSCENE_KYLOK_FOUND || cutscene == CUTSCENE_DAIKUN_DISCOVERED)
            SaveGame__SetUnknown1(0);
    }

    SaveGame__StartCutscene(cutscene, a1->nextSysEvent, FALSE);
}

void SaveGame__UpdateProgress1_Func_205CBC4(SaveGameNextAction *a1)
{
    SaveGame__StartTutorial();
}

void SaveGame__UpdateProgress1_Func_205CBD0(SaveGameNextAction *a1)
{
    SaveGame__StartEvent37();
}

void SaveGame__UpdateProgress1_Func_205CBDC(SaveGameNextAction *a1)
{
    SaveGame__StartSailJetTraining();
}

void SaveGame__UpdateProgress1_Func_205CBE8(SaveGameNextAction *a1)
{
    SaveGame__StartHubMenu();
}

void SaveGame__UpdateProgress1_Func_205CBF4(SaveGameNextAction *a1)
{
    SaveGame__StartDoorPuzzle(a1->id);
}

void SaveGame__UpdateProgress1_Func_205CC04(SaveGameNextAction *a1)
{
    if (a1->id == 0)
        SeaMapManager__SetUnknown1(0);
    else
        SeaMapManager__SetUnknown1(1);

    SaveGame__SetUnknown1(5);
    SaveGame__ChangeEvent(SYSEVENT_38);
}

void SaveGame__UpdateProgress1_Func_205CC3C(SaveGameNextAction *a1)
{
    if (a1->id == 24)
        SaveGame__EnableStateFlags(2);

    gameState.stageID = a1->id;
    SaveGame__SetUnknown1(3);
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
    gameState.missionType      = MISSION_TYPE_TRAINING;
    gameState.missionTimeLimit = 1;
    gameState.missionQuota     = 1;
    gameState.sailShipType     = SHIP_JET;

    SaveGame__ChangeEvent(SYSEVENT_SAILING);
}

void SaveGame__StartHubMenu(void)
{
    SaveGame__ChangeEvent(SYSEVENT_RETURN_TO_HUB);
}

void SaveGame__StartEvent35(void)
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

    SaveGame__SetUnknown1(10);
    SaveGame__ChangeEvent(SYSEVENT_DOOR_PUZZLE);
}

void SaveGame__StartStageSelect(void)
{
    gameState.gameMode = GAMEMODE_STORY;

    SaveGame__ChangeEvent(SYSEVENT_7);
}

void SaveGame__StartEmeraldCollected(void)
{
    SaveGame__SetUnknown1(7);
    SaveGame__ChangeEvent(SYSEVENT_EMERALD_COLLECTED);
}

void SaveGame__IncrementGameProgress(void)
{
    SaveGame__SetGameProgress(saveGame.stage.progress.gameProgress + 1);
}

void SaveGame__IncrementUnknownProgress1(void)
{
    SaveGame__SetUnknownProgress1(saveGame.stage.progress.unknownProgress1 + 1);
}

void SaveGame__IncrementUnknownProgress2(void)
{
    SaveGame__SetUnknownProgress2(saveGame.stage.progress.unknownProgress2 + 1);
}

void SaveGame__IncrementUnknown2(void)
{
    gameState.saveFile.unknown2++;
}

void SaveGame__ResetUnknown2(void)
{
    gameState.saveFile.unknown2 = 0;
}

s32 SaveGame__GetUnknown1(void)
{
    return gameState.saveFile.unknown1;
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

    if (systemProgress->unknownProgress1 <= stageProgress->unknownProgress1)
    {
        systemProgress->unknownProgress1 = stageProgress->unknownProgress1;

        if (stageProgress->unknownProgress1 == 2 && (stageProgress->flags & 0x200) != 0)
            systemProgress->flags |= 0x200;
    }

    if (systemProgress->unknownProgress2 <= stageProgress->unknownProgress2)
    {
        systemProgress->unknownProgress2 = stageProgress->unknownProgress2;

        if (stageProgress->unknownProgress2 == 4 && (stageProgress->flags & 0x400) != 0)
            systemProgress->flags |= 0x400;
    }

    systemProgress->flags |= stageProgress->flags & ~0xFFF00701;

    for (s32 i = 0; i < 14; i++)
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

void SaveGame__SetBoughtInfo0(void)
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
    u8 gameProgress     = SaveGame__GetGameProgress();
    u8 unknownProgress1 = SaveGame__GetUnknownProgress1();
    u8 unknownProgress2 = SaveGame__GetUnknownProgress2();

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

        if (progress->unknownProgress1 != 0xFF && progress->unknownProgress1 != unknownProgress1)
        {
            return FALSE;
        }

        if (progress->unknownProgress2 != 0xFF && progress->unknownProgress2 != unknownProgress2)
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
    s32 unknownProgress1      = SaveGame__GetUnknownProgress1();
    s32 unknownProgress2      = SaveGame__GetUnknownProgress2();

    switch (id)
    {
        case 0:
            if (gameProgress >= SAVE_PROGRESS_5)
                return TRUE;
            break;

        case 1:
            if (gameProgress >= SAVE_PROGRESS_8)
                return TRUE;
            break;

        case 2:
            if (gameProgress >= SAVE_PROGRESS_16)
                return TRUE;
            break;

        case 3:
            if (gameProgress >= SAVE_PROGRESS_21)
                return TRUE;
            break;

        case 4:
            if (unknownProgress1 >= 4)
                return TRUE;
            break;

        case 5:
            if (unknownProgress2 >= 6)
                return TRUE;
            break;

        case 6:
            if (gameProgress >= SAVE_PROGRESS_35)
                return TRUE;
            break;

        case 7:
            if (gameProgress >= SAVE_PROGRESS_36)
                return TRUE;
            break;

        case 8:
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

BOOL SaveGame__CheckProgress24(void)
{
    if (SaveGame__GetGameProgress() != SAVE_PROGRESS_24)
        return FALSE;

    if (SaveGame__GetUnknownProgress1() != 4)
        return FALSE;

    return SaveGame__GetUnknownProgress2() == 6;
}

BOOL SaveGame__CheckProgress30(void)
{
    return SaveGame__GetGameProgress() == SAVE_PROGRESS_30;
}

BOOL SaveGame__CheckProgress15(void)
{
    return SaveGame__GetGameProgress() == SAVE_PROGRESS_15 && SaveGame__GetUnknown2() >= 1;
}

BOOL SaveGame__CheckProgressForShip(u32 id)
{
    SaveProgress progress;
    switch (id)
    {
        case 0:
            progress = SAVE_PROGRESS_9;
            break;

        case 1:
            progress = SAVE_PROGRESS_22;
            break;

        case 2:
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
    s32 gameProgress     = SaveGame__GetGameProgress();
    s32 unknownProgress1 = SaveGame__GetUnknownProgress1();
    s32 unknownProgress2 = SaveGame__GetUnknownProgress2();

    if (gameProgress >= _02110D00[id].gameProgress && unknownProgress1 >= _02110D00[id].unknownProgress1 && unknownProgress2 >= _02110D00[id].unknownProgress2)
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

BOOL SaveGame__CheckProgress29(void)
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

BOOL SaveGame__CheckProgress37(void)
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
	bl SaveGame__GetUnknownProgress1
	strb r0, [sp]
	bl SaveGame__GetUnknownProgress2
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
	bl SaveGame__GetUnknownProgress1
	strb r0, [sp]
	bl SaveGame__GetUnknownProgress2
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

#include <nitro/code16.h>

BOOL SaveGame__InitSaveSize(void)
{
    return InitCardBackupSize();
}

NONMATCH_FUNC void SaveGame__ClearData(SaveGame *work, SaveBlockFlags flags)
{
    // https://decomp.me/scratch/zpKjG -> 61.17%
#ifdef NON_MATCHING
    if ((flags & SAVE_BLOCK_FLAG_ALL) == SAVE_BLOCK_FLAG_ALL)
    {
        MI_CpuClear16(work, sizeof(SaveGame));
    }
    else
    {
        for (s32 b = 0; b < SAVE_BLOCK_COUNT; b++)
        {
            if (((1 << b) & flags) != 0)
                MI_CpuClear16((u8 *)work + savedataBlockOffsets[b], savedataBlockSizes[b]);
        }
    }

    for (u32 i = 0; i < 3; i++)
    {
        SaveGame__ClearDataCallbacks[i](work, flags);
    }
#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	ldr r0, =0x000001FE
	mov r6, r1
	and r1, r0
	cmp r1, r0
	bne _0205D8CE
	ldr r2, =0x00001A68
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	b _0205D8F2
_0205D8CE:
	mov r5, #0
	mov r7, #1
_0205D8D2:
	mov r0, r7
	lsl r0, r5
	tst r0, r6
	beq _0205D8EC
	ldr r1, =savedataBlockOffsets
	lsl r3, r5, #2
	ldr r2, =savedataBlockSizes
	ldr r1, [r1, r3]
	ldr r2, [r2, r3]
	mov r0, #0
	add r1, r4, r1
	bl MIi_CpuClear16
_0205D8EC:
	add r5, r5, #1
	cmp r5, #9
	blt _0205D8D2
_0205D8F2:
	mov r5, #0
	ldr r7, =SaveGame__ClearDataCallbacks
	b _0205D904
_0205D8F8:
	lsl r2, r5, #2
	ldr r2, [r7, r2]
	mov r0, r4
	mov r1, r6
	blx r2
	add r5, r5, #1
_0205D904:
	cmp r5, #3
	blo _0205D8F8
	pop {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC SaveErrorTypes SaveGame__SaveData(SaveGame *work, SaveBlockFlags flags)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0xcc
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #0x18]
	mov r0, #1
	lsl r0, r0, #0xa
	str r1, [sp, #4]
	bl _AllocHeadHEAP_USER
	ldr r1, =0xEDB88320
	str r0, [sp, #0x48]
	bl MATHi_CRC32InitTableRev
	ldr r0, [sp, #4]
	mov r1, #1
	bic r0, r1
	str r0, [sp, #4]
	mov r0, #0xc
	mov r5, #0
	bl _AllocHeadHEAP_USER
	mov r4, r0
	mov r0, r5
	mov r1, r4
	mov r2, #0xc
	bl ReadFromCardBackup
	cmp r0, #0
	beq _0205D978
	ldr r1, =aSonicRush2
	mov r0, r4
	mov r2, #0xc
	bl STD_CompareNString
	cmp r0, #0
	bne _0205D96E
	mov r0, #1
	b _0205D970
_0205D96E:
	mov r0, r5
_0205D970:
	cmp r0, #0
	bne _0205D97A
	mov r5, #1
	b _0205D97A
_0205D978:
	mov r5, #2
_0205D97A:
	mov r0, r4
	bl _FreeHEAP_USER
	cmp r5, #0
	beq _0205D99E
	cmp r5, #1
	beq _0205D98E
	cmp r5, #2
	beq _0205D998
	b _0205D99E
_0205D98E:
	ldr r0, [sp, #4]
	mov r1, #1
	orr r0, r1
	str r0, [sp, #4]
	b _0205D99E
_0205D998:
	mov r0, #2
	str r0, [sp, #0x18]
	b _0205DE5E
_0205D99E:
	ldr r0, [sp, #4]
	mov r1, #1
	mov r5, r0
	and r5, r1
	beq _0205D9D0
	mov r0, #0
	add r1, sp, #0xc0
	mov r2, #0xc
	bl MIi_CpuClear16
	ldr r1, =aSonicRush2
	add r0, sp, #0xc0
	mov r2, #0xc
	bl STD_CopyLStringZeroFill
	mov r0, #0
	add r1, sp, #0xc0
	mov r2, #0xc
	bl WriteToCardBackup
	cmp r0, #0
	bne _0205D9D0
	mov r0, #2
	str r0, [sp, #0x18]
	b _0205DE5E
_0205D9D0:
	mov r4, #0
	ldr r6, =SaveGame__SaveDataCallbacks
	b _0205D9E2
_0205D9D6:
	lsl r2, r4, #2
	ldr r0, [sp]
	ldr r1, [sp, #4]
	ldr r2, [r6, r2]
	blx r2
	add r4, r4, #1
_0205D9E2:
	cmp r4, #1
	blo _0205D9D6
	cmp r5, #0
	beq _0205DABC
	mov r0, #1
	str r0, [sp, #0x3c]
	str r0, [sp, #0x40]
_0205D9F0:
	mov r0, #1
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x40]
	ldr r1, =savedataBlockSizes
	lsl r0, r0, #2
	ldr r4, [r1, r0]
	ldr r1, =savedataBlockOffsets
	lsl r5, r4, #1
	add r5, #8
	str r0, [sp, #8]
	ldr r7, [r1, r0]
	mov r0, r5
	bl _AllocHeadHEAP_USER
	mov r6, r0
	mov r0, #0
	mov r1, r6
	mov r2, r5
	bl MIi_CpuClear16
	mov r0, #0
	str r0, [sp, #0x78]
	sub r0, r0, #1
	str r0, [sp, #0x7c]
	ldr r0, [sp, #0x48]
	add r1, sp, #0x7c
	add r2, sp, #0x78
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r2, [sp]
	ldr r0, [sp, #0x48]
	add r1, sp, #0x7c
	add r2, r2, r7
	mov r3, r4
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x7c]
	mov r5, #0
	mvn r0, r0
	str r0, [r6]
	mov r0, r6
	str r0, [sp, #0x4c]
	add r0, #8
	str r5, [r6, #4]
	str r0, [sp, #0x4c]
_0205DA4C:
	ldr r0, [sp]
	mov r2, r4
	ldr r1, [sp, #0x4c]
	mul r2, r5
	add r1, r1, r2
	add r0, r0, r7
	mov r2, r4
	bl MIi_CpuCopy16
	add r5, r5, #1
	cmp r5, #2
	blt _0205DA4C
	ldr r1, =_02110DDC
	ldr r0, [sp, #8]
	lsl r7, r4, #1
	ldr r4, [r1, r0]
	mov r5, #0
	add r7, #8
_0205DA70:
	lsl r0, r5, #0x10
	lsr r1, r0, #0x10
	mov r0, #0x37
	lsl r0, r0, #8
	mul r0, r1
	add r0, #0x80
	add r0, r4, r0
	mov r1, r6
	mov r2, r7
	bl WriteToCardBackup
	cmp r0, #0
	bne _0205DA8E
	mov r0, #0
	str r0, [sp, #0x44]
_0205DA8E:
	add r5, r5, #1
	cmp r5, #4
	blo _0205DA70
	mov r0, r6
	bl _FreeHEAP_USER
	ldr r0, [sp, #0x44]
	cmp r0, #0
	bne _0205DAA4
	mov r0, #0
	str r0, [sp, #0x3c]
_0205DAA4:
	ldr r0, [sp, #0x40]
	add r0, r0, #1
	str r0, [sp, #0x40]
	cmp r0, #9
	blt _0205D9F0
	ldr r0, [sp, #0x3c]
	cmp r0, #0
	beq _0205DAB6
	b _0205DE5E
_0205DAB6:
	mov r0, #1
	str r0, [sp, #0x18]
	b _0205DE5E
_0205DABC:
	mov r0, #0
	str r0, [sp, #0x18]
	mov r0, #1
	str r0, [sp, #0x1c]
	b _0205DE56
_0205DAC6:
	ldr r0, [sp, #0x1c]
	mov r1, #1
	lsl r1, r0
	ldr r0, [sp, #4]
	tst r0, r1
	bne _0205DAD4
	b _0205DE50
_0205DAD4:
	ldr r0, [sp, #0x1c]
	mov r6, #0x37
	lsl r7, r0, #2
	ldr r0, =_02110DDC
	mov r4, #0
	ldr r0, [r0, r7]
	add r5, sp, #0xa0
	str r0, [sp, #0x10]
	lsl r6, r6, #8
	b _0205DB0A
_0205DAE8:
	mov r1, r4
	mul r1, r6
	ldr r0, [sp, #0x10]
	add r1, #0x80
	add r0, r0, r1
	lsl r1, r4, #3
	add r1, r5, r1
	mov r2, #8
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205DB04
	mov r0, #0
	b _0205DB10
_0205DB04:
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
_0205DB0A:
	cmp r4, #4
	blo _0205DAE8
	mov r0, #1
_0205DB10:
	cmp r0, #0
	bne _0205DB18
	mov r0, #2
	b _0205DE3E
_0205DB18:
	mov r4, #0
	add r2, sp, #0xa0
	add r1, sp, #0x90
_0205DB1E:
	lsl r0, r4, #3
	add r3, r2, r0
	lsl r0, r4, #2
	str r3, [r1, r0]
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	cmp r4, #4
	blo _0205DB1E
	mov r2, #0
_0205DB32:
	mov r5, #0
_0205DB34:
	mov r0, #0
	mov ip, r0
	lsl r6, r5, #2
	add r0, sp, #0x90
	add r4, r0, r6
	ldr r3, [r4, #4]
	ldr r0, [r0, r6]
	ldr r1, [r3, #4]
	ldr r6, [r0, #4]
	cmp r6, r1
	bls _0205DB50
	mov r1, #1
	mov ip, r1
	b _0205DB5C
_0205DB50:
	cmp r6, r1
	bne _0205DB5C
	cmp r0, r3
	bls _0205DB5C
	mov r1, #1
	mov ip, r1
_0205DB5C:
	mov r1, ip
	cmp r1, #0
	beq _0205DB66
	str r3, [r4]
	str r0, [r4, #4]
_0205DB66:
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	cmp r5, #3
	blt _0205DB34
	add r0, r2, #1
	lsl r0, r0, #0x10
	lsr r2, r0, #0x10
	cmp r2, #3
	blt _0205DB32
	ldr r0, =savedataBlockSizes
	mov r6, #0
	ldr r5, [r0, r7]
	lsl r0, r5, #1
	str r0, [sp, #0xc]
	add r0, #8
	str r0, [sp, #0xc]
	str r0, [sp, #0x14]
	sub r0, #8
	str r0, [sp, #0x14]
_0205DB8E:
	ldr r0, [sp, #0xc]
	bl _AllocHeadHEAP_USER
	str r0, [sp, #0x24]
	mov r0, #0
	beq _0205DB9C
	str r0, [r0]
_0205DB9C:
	mov r0, #0x37
	lsl r0, r0, #8
	mov r1, r6
	mul r1, r0
	ldr r0, [sp, #0x10]
	add r1, #0x80
	add r0, r0, r1
	ldr r1, [sp, #0x24]
	ldr r2, [sp, #0xc]
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205DBBA
	mov r4, #2
	b _0205DC52
_0205DBBA:
	ldr r0, [sp, #0x14]
	mov r1, #2
	bl FX_DivS32
	mov r4, #0
	str r0, [sp, #0x30]
	mov r0, r4
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x24]
	str r0, [sp, #0x50]
	add r0, #8
	str r0, [sp, #0x50]
_0205DBD2:
	ldr r0, [sp, #0x24]
	add r1, sp, #0x70
	ldr r0, [r0, #0]
	add r2, sp, #0x74
	str r0, [sp, #0x2c]
	ldr r0, [sp, #0x24]
	mov r3, #4
	ldr r0, [r0, #4]
	str r0, [sp, #0x74]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #0x70]
	ldr r0, [sp, #0x48]
	bl MATHi_CRC32UpdateRev
	ldr r2, [sp, #0x30]
	ldr r3, [sp, #0x28]
	ldr r0, [sp, #0x48]
	mul r3, r2
	ldr r2, [sp, #0x50]
	add r1, sp, #0x70
	add r2, r2, r3
	ldr r3, [sp, #0x30]
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x70]
	mvn r1, r0
	ldr r0, [sp, #0x2c]
	cmp r0, r1
	bne _0205DC16
	ldr r0, [sp, #0x28]
	mov r1, #1
	lsl r1, r0
	orr r4, r1
_0205DC16:
	ldr r0, [sp, #0x28]
	add r0, r0, #1
	str r0, [sp, #0x28]
	cmp r0, #2
	blo _0205DBD2
	mov r0, #0
	beq _0205DC26
	str r4, [r0]
_0205DC26:
	cmp r4, #0
	bne _0205DC2E
	mov r4, #4
	b _0205DC52
_0205DC2E:
	cmp r4, #3
	beq _0205DC50
	mov r4, #3
	b _0205DC52
_0205DC50:
	mov r4, #0
_0205DC52:
	ldr r0, [sp, #0x24]
	bl _FreeHEAP_USER
	lsl r1, r6, #2
	add r0, sp, #0x80
	str r4, [r0, r1]
	add r0, r6, #1
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	cmp r6, #4
	blo _0205DB8E
	mov r2, #0
	add r1, sp, #0x80
	b _0205DC80
_0205DC6E:
	lsl r0, r2, #2
	ldr r0, [r1, r0]
	cmp r0, #2
	bne _0205DC7A
	mov r0, #2
	b _0205DE3E
_0205DC7A:
	add r0, r2, #1
	lsl r0, r0, #0x10
	lsr r2, r0, #0x10
_0205DC80:
	cmp r2, #4
	blo _0205DC6E
	mov r2, #0
	add r0, sp, #0x80
	mov r3, #3
	b _0205DCAA
_0205DC8C:
	sub r1, r3, r2
	lsl r1, r1, #2
	ldr r4, [r0, r1]
	cmp r4, #0
	beq _0205DC9A
	cmp r4, #3
	bne _0205DCA4
_0205DC9A:
	add r0, sp, #0x90
	ldr r0, [r0, r1]
	ldr r0, [r0, #4]
	str r0, [sp, #0x38]
	b _0205DCAE
_0205DCA4:
	add r1, r2, #1
	lsl r1, r1, #0x10
	lsr r2, r1, #0x10
_0205DCAA:
	cmp r2, #4
	blo _0205DC8C
_0205DCAE:
	cmp r2, #4
	bne _0205DD5A
	mov r0, #1
	str r0, [sp, #0x20]
	ldr r0, =savedataBlockOffsets
	lsl r4, r5, #1
	add r4, #8
	ldr r7, [r0, r7]
	mov r0, r4
	bl _AllocHeadHEAP_USER
	mov r6, r0
	mov r0, #0
	mov r1, r6
	mov r2, r4
	bl MIi_CpuClear16
	mov r0, #0
	str r0, [sp, #0x6c]
	sub r0, r0, #1
	str r0, [sp, #0x68]
	ldr r0, [sp, #0x48]
	add r1, sp, #0x68
	add r2, sp, #0x6c
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r2, [sp]
	ldr r0, [sp, #0x48]
	add r1, sp, #0x68
	add r2, r2, r7
	mov r3, r5
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x68]
	mov r4, #0
	mvn r0, r0
	str r0, [r6]
	mov r0, r6
	str r0, [sp, #0x54]
	add r0, #8
	str r4, [r6, #4]
	str r0, [sp, #0x54]
_0205DD04:
	ldr r0, [sp]
	mov r2, r5
	ldr r1, [sp, #0x54]
	mul r2, r4
	add r1, r1, r2
	add r0, r0, r7
	mov r2, r5
	bl MIi_CpuCopy16
	add r4, r4, #1
	cmp r4, #2
	blt _0205DD04
	mov r4, #0
	mov r7, #0x37
	mov r5, r4
	lsl r7, r7, #8
_0205DD24:
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	mov r1, r0
	mul r1, r7
	ldr r0, [sp, #0x10]
	add r1, #0x80
	add r0, r0, r1
	ldr r2, [sp, #0xc]
	mov r1, r6
	bl WriteToCardBackup
	cmp r0, #0
	bne _0205DD40
	str r5, [sp, #0x20]
_0205DD40:
	add r4, r4, #1
	cmp r4, #4
	blo _0205DD24
	mov r0, r6
	bl _FreeHEAP_USER
	ldr r0, [sp, #0x20]
	cmp r0, #0
	bne _0205DD56
	mov r0, #1
	b _0205DE3E
_0205DD56:
	mov r0, #0
	b _0205DE3E
_0205DD5A:
	mov r0, #0
	str r0, [sp, #0x34]
	ldr r0, =savedataBlockOffsets
	lsl r6, r5, #1
	ldr r0, [r0, r7]
	add r6, #8
	str r0, [sp, #0x58]
	mov r0, r6
	bl _AllocHeadHEAP_USER
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, r6
	bl MIi_CpuClear16
	ldr r0, [sp, #0x38]
	add r1, sp, #0x64
	add r0, r0, #1
	str r0, [sp, #0x60]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #0x64]
	ldr r0, [sp, #0x48]
	add r2, sp, #0x60
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r3, [sp]
	ldr r2, [sp, #0x58]
	ldr r0, [sp, #0x48]
	add r2, r3, r2
	add r1, sp, #0x64
	mov r3, r5
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x64]
	mov r6, #0
	mvn r0, r0
	str r0, [r4]
	ldr r0, [sp, #0x38]
	add r0, r0, #1
	str r0, [r4, #4]
	mov r0, r4
	str r0, [sp, #0x5c]
	add r0, #8
	str r0, [sp, #0x5c]
_0205DDB8:
	ldr r1, [sp]
	ldr r0, [sp, #0x58]
	mov r2, r5
	add r0, r1, r0
	ldr r1, [sp, #0x5c]
	mul r2, r6
	add r1, r1, r2
	mov r2, r5
	bl MIi_CpuCopy16
	add r6, r6, #1
	cmp r6, #2
	blt _0205DDB8
	mov r5, #0
	add r6, sp, #0x90
	b _0205DE28
_0205DDD8:
	lsl r0, r5, #2
	mov r3, #0
	ldr r1, [r6, r0]
	b _0205DDF0
_0205DDE0:
	lsl r2, r3, #3
	add r0, sp, #0xa0
	add r0, r0, r2
	cmp r0, r1
	beq _0205DDF4
	add r0, r3, #1
	lsl r0, r0, #0x10
	lsr r3, r0, #0x10
_0205DDF0:
	cmp r3, #4
	blo _0205DDE0
_0205DDF4:
	lsl r1, r3, #2
	add r0, sp, #0x80
	ldr r0, [r0, r1]
	cmp r0, #0
	beq _0205DE02
	cmp r0, #3
	bne _0205DE22
_0205DE02:
	ldr r0, =_02110DDC
	mov r1, #0x37
	lsl r1, r1, #8
	mul r1, r3
	ldr r0, [r0, r7]
	add r1, #0x80
	add r0, r0, r1
	ldr r2, [sp, #0xc]
	mov r1, r4
	bl WriteToCardBackup
	cmp r0, #0
	beq _0205DE22
	mov r0, #1
	str r0, [sp, #0x34]
	b _0205DE2C
_0205DE22:
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
_0205DE28:
	cmp r5, #4
	blo _0205DDD8
_0205DE2C:
	mov r0, r4
	bl _FreeHEAP_USER
	ldr r0, [sp, #0x34]
	cmp r0, #0
	bne _0205DE3C
	mov r0, #1
	b _0205DE3E
_0205DE3C:
	mov r0, #0
_0205DE3E:
	cmp r0, #1
	beq _0205DE48
	cmp r0, #2
	beq _0205DE4C
	b _0205DE50
_0205DE48:
	str r0, [sp, #0x18]
	b _0205DE50
_0205DE4C:
	str r0, [sp, #0x18]
	b _0205DE5E
_0205DE50:
	ldr r0, [sp, #0x1c]
	add r0, r0, #1
	str r0, [sp, #0x1c]
_0205DE56:
	ldr r0, [sp, #0x1c]
	cmp r0, #9
	bge _0205DE5E
	b _0205DAC6
_0205DE5E:
	ldr r0, [sp, #0x48]
	cmp r0, #0
	beq _0205DE68
	bl _FreeHEAP_USER
_0205DE68:
	ldr r0, [sp, #0x18]
	add sp, #0xcc
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC SaveErrorTypes SaveGame__SaveData2(SaveGame *work)
{
    // https://decomp.me/scratch/gXQ9s -> 76.41%
#ifdef NON_MATCHING
    SaveErrorTypes error     = SAVE_ERROR_NONE;
    MATHCRC32Table *crcTable = HeapAllocHead(HEAP_USER, sizeof(MATHCRC32Table));
    MATH_CRC32InitTable(crcTable);

    u32 headerError = 0;
    void *signature = HeapAllocHead(HEAP_USER, 12);
    if (ReadFromCardBackup(0, signature, 12))
    {
        if (STD_CompareNString(signature, "sonic_rush2", 12) == 0)
            headerError = 1;
    }
    else
    {
        headerError = 2;
    }

    HeapFree(HEAP_USER, signature);

    if (headerError != 0 && headerError != 1 && headerError == 2)
    {
        error = SAVE_ERROR_CANT_LOAD;
    }
    else
    {
        char signatureW[12];
        MI_CpuClear16(signatureW, 12);
        STD_CopyLStringZeroFill(signatureW, "sonic_rush2", 12);
        if (WriteToCardBackup(0, signatureW, 12) == FALSE)
        {
            error = SAVE_ERROR_CANT_LOAD;
        }
        else
        {
            s32 id = 0;
            while (id == 0)
            {
                SaveGame__SaveDataCallbacks[id](work, 0x1FF);
                id = 1;
            }

            BOOL blockSuccess = TRUE;
            for (s32 b = 1; b < 9; b++)
            {
                BOOL success = TRUE;

                size_t size        = savedataBlockSizes[b];
                size_t offset      = savedataBlockOffsets[b];
                SaveIOBlock *block = (SaveIOBlock *)HeapAllocHead(HEAP_USER, 2 * size + sizeof(SaveIOBlockHeader));
                MI_CpuClear16(block, 2 * size + sizeof(SaveIOBlockHeader));

                u32 writeCount           = 0;
                MATHCRC32Context context = -1;
                MATH_CalcCRC32(crcTable, &context, &writeCount, sizeof(writeCount));
                MATH_CalcCRC32(crcTable, &context, (u8 *)work + offset, size);

                block->header.checksum   = ~context;
                block->header.writeCount = 0;
                for (s32 i = 0; i < 2; i++)
                {
                    MI_CpuCopy16((u8 *)work + offset, &block->data[size * i], size);
                }

                size_t blockByteSize  = 2 * size;
                size_t blockWriteSize = blockByteSize + sizeof(SaveIOBlockHeader);
                for (u32 s = 0; s < 4; s++)
                {
                    if (!WriteToCardBackup(_02110DDC[b] + 0x3700 * (u16)s + 0x80, block, blockWriteSize))
                        success = FALSE;
                }

                HeapFree(HEAP_USER, block);
                if (!success)
                    blockSuccess = FALSE;
            }

            if (!blockSuccess)
                error = SAVE_ERROR_INVALID_FORMAT;
        }
    }

    if (crcTable != NULL)
        HeapFree(HEAP_USER, crcTable);

    return error;
#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x34
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #0x18]
	mov r0, #1
	lsl r0, r0, #0xa
	bl _AllocHeadHEAP_USER
	ldr r1, =0xEDB88320
	str r0, [sp, #0x14]
	bl MATHi_CRC32InitTableRev
	mov r0, #0xc
	mov r5, #0
	bl _AllocHeadHEAP_USER
	mov r4, r0
	mov r0, r5
	mov r1, r4
	mov r2, #0xc
	bl ReadFromCardBackup
	cmp r0, #0
	beq _0205DEC6
	ldr r1, =aSonicRush2
	mov r0, r4
	mov r2, #0xc
	bl STD_CompareNString
	cmp r0, #0
	bne _0205DEBC
	mov r0, #1
	b _0205DEBE
_0205DEBC:
	mov r0, r5
_0205DEBE:
	cmp r0, #0
	bne _0205DEC8
	mov r5, #1
	b _0205DEC8
_0205DEC6:
	mov r5, #2
_0205DEC8:
	mov r0, r4
	bl _FreeHEAP_USER
	cmp r5, #0
	beq _0205DEE0
	cmp r5, #1
	beq _0205DEE0
	cmp r5, #2
	bne _0205DEE0
	mov r0, #2
	str r0, [sp, #0x18]
	b _0205DFEE
_0205DEE0:
	mov r0, #0
	add r1, sp, #0x28
	mov r2, #0xc
	bl MIi_CpuClear16
	ldr r1, =aSonicRush2
	add r0, sp, #0x28
	mov r2, #0xc
	bl STD_CopyLStringZeroFill
	mov r0, #0
	add r1, sp, #0x28
	mov r2, #0xc
	bl WriteToCardBackup
	cmp r0, #0
	bne _0205DF08
	mov r0, #2
	str r0, [sp, #0x18]
	b _0205DFEE
_0205DF08:
	mov r5, #0
	ldr r6, =0x000001FF
	ldr r4, =SaveGame__SaveDataCallbacks
	b _0205DF1C
_0205DF10:
	lsl r2, r5, #2
	ldr r0, [sp]
	ldr r2, [r4, r2]
	mov r1, r6
	blx r2
	add r5, r5, #1
_0205DF1C:
	cmp r5, #1
	blo _0205DF10
	mov r0, #1
	str r0, [sp, #8]
	str r0, [sp, #0xc]
_0205DF26:
	mov r0, #1
	str r0, [sp, #0x10]
	ldr r0, [sp, #0xc]
	ldr r1, =savedataBlockSizes
	lsl r0, r0, #2
	ldr r4, [r1, r0]
	ldr r1, =savedataBlockOffsets
	lsl r5, r4, #1
	add r5, #8
	str r0, [sp, #4]
	ldr r7, [r1, r0]
	mov r0, r5
	bl _AllocHeadHEAP_USER
	mov r6, r0
	mov r0, #0
	mov r1, r6
	mov r2, r5
	bl MIi_CpuClear16
	mov r0, #0
	str r0, [sp, #0x20]
	sub r0, r0, #1
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x14]
	add r1, sp, #0x24
	add r2, sp, #0x20
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r2, [sp]
	ldr r0, [sp, #0x14]
	add r1, sp, #0x24
	add r2, r2, r7
	mov r3, r4
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x24]
	mov r5, #0
	mvn r0, r0
	str r0, [r6]
	mov r0, r6
	str r0, [sp, #0x1c]
	add r0, #8
	str r5, [r6, #4]
	str r0, [sp, #0x1c]
_0205DF82:
	ldr r0, [sp]
	mov r2, r4
	ldr r1, [sp, #0x1c]
	mul r2, r5
	add r1, r1, r2
	add r0, r0, r7
	mov r2, r4
	bl MIi_CpuCopy16
	add r5, r5, #1
	cmp r5, #2
	blt _0205DF82
	ldr r1, =_02110DDC
	ldr r0, [sp, #4]
	lsl r7, r4, #1
	ldr r4, [r1, r0]
	mov r5, #0
	add r7, #8
_0205DFA6:
	lsl r0, r5, #0x10
	lsr r1, r0, #0x10
	mov r0, #0x37
	lsl r0, r0, #8
	mul r0, r1
	add r0, #0x80
	add r0, r4, r0
	mov r1, r6
	mov r2, r7
	bl WriteToCardBackup
	cmp r0, #0
	bne _0205DFC4
	mov r0, #0
	str r0, [sp, #0x10]
_0205DFC4:
	add r5, r5, #1
	cmp r5, #4
	blo _0205DFA6
	mov r0, r6
	bl _FreeHEAP_USER
	ldr r0, [sp, #0x10]
	cmp r0, #0
	bne _0205DFDA
	mov r0, #0
	str r0, [sp, #8]
_0205DFDA:
	ldr r0, [sp, #0xc]
	add r0, r0, #1
	str r0, [sp, #0xc]
	cmp r0, #9
	blt _0205DF26
	ldr r0, [sp, #8]
	cmp r0, #0
	bne _0205DFEE
	mov r0, #1
	str r0, [sp, #0x18]
_0205DFEE:
	ldr r0, [sp, #0x14]
	cmp r0, #0
	beq _0205DFF8
	bl _FreeHEAP_USER
_0205DFF8:
	ldr r0, [sp, #0x18]
	add sp, #0x34
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC SaveErrorTypes SaveGame__LoadData(SaveGame *work, u32 *corruptFlags, u32 *otherFlags)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x94
	str r1, [sp, #4]
	str r0, [sp]
	ldr r0, [sp, #4]
	mov r1, #0
	str r1, [r0]
	mov r0, r2
	str r1, [r0]
	mov r0, #1
	lsl r0, r0, #0xa
	str r2, [sp, #8]
	bl _AllocHeadHEAP_USER
	ldr r1, =0xEDB88320
	str r0, [sp, #0x44]
	bl MATHi_CRC32InitTableRev
	ldr r0, =0x00001A68
	bl _AllocHeadHEAP_USER
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x10]
	ldr r2, =0x00001A68
	mov r0, #0
	bl MIi_CpuClear16
	mov r5, #0
	ldr r6, =0x000001FE
	ldr r4, =SaveGame__ClearDataCallbacks
	b _0205E066
_0205E05A:
	lsl r2, r5, #2
	ldr r0, [sp, #0x10]
	ldr r2, [r4, r2]
	mov r1, r6
	blx r2
	add r5, r5, #1
_0205E066:
	cmp r5, #3
	blo _0205E05A
	mov r0, #0xc
	mov r7, #0
	bl _AllocHeadHEAP_USER
	mov r4, r0
	mov r0, r7
	mov r1, r4
	mov r2, #0xc
	bl ReadFromCardBackup
	cmp r0, #0
	beq _0205E09E
	ldr r1, =aSonicRush2
	mov r0, r4
	mov r2, #0xc
	bl STD_CompareNString
	cmp r0, #0
	bne _0205E094
	mov r0, #1
	b _0205E096
_0205E094:
	mov r0, r7
_0205E096:
	cmp r0, #0
	bne _0205E0A0
	mov r7, #1
	b _0205E0A0
_0205E09E:
	mov r7, #2
_0205E0A0:
	mov r0, r4
	bl _FreeHEAP_USER
	cmp r7, #0
	beq _0205E0B4
	cmp r7, #1
	beq _0205E0B2
	cmp r7, #2
	bne _0205E0B4
_0205E0B2:
	b _0205E3F6
_0205E0B4:
	mov r0, #1
	str r0, [sp, #0x40]
	b _0205E3EE
_0205E0BA:
	ldr r0, [sp, #0x40]
	mov r5, #0
	lsl r1, r0, #2
	ldr r0, =_02110DDC
	str r5, [sp, #0x14]
	ldr r0, [r0, r1]
	mov r4, r5
	str r0, [sp, #0x38]
	ldr r0, =savedataBlockSizes
	add r6, sp, #0x64
	ldr r0, [r0, r1]
	str r0, [sp, #0x3c]
	ldr r0, =savedataBlockOffsets
	ldr r0, [r0, r1]
	str r0, [sp, #0x48]
	b _0205E100
_0205E0DA:
	mov r0, #0x37
	lsl r0, r0, #8
	mov r1, r4
	mul r1, r0
	ldr r0, [sp, #0x38]
	add r1, #0x80
	add r0, r0, r1
	lsl r1, r4, #3
	add r1, r6, r1
	mov r2, #8
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205E0FA
	mov r0, #0
	b _0205E106
_0205E0FA:
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
_0205E100:
	cmp r4, #4
	blo _0205E0DA
	mov r0, #1
_0205E106:
	cmp r0, #0
	bne _0205E110
	mov r0, #2
	str r0, [sp, #0x14]
	b _0205E3AA
_0205E110:
	mov r4, #0
	add r2, sp, #0x64
	add r1, sp, #0x84
_0205E116:
	lsl r0, r4, #3
	add r3, r2, r0
	lsl r0, r4, #2
	str r3, [r1, r0]
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	cmp r4, #4
	blo _0205E116
	mov r5, #0
_0205E12A:
	mov r1, #0
_0205E12C:
	mov r0, #0
	mov ip, r0
	lsl r6, r1, #2
	add r0, sp, #0x84
	add r0, r0, r6
	add r2, sp, #0x84
	ldr r4, [r0, #4]
	ldr r2, [r2, r6]
	ldr r3, [r4, #4]
	ldr r6, [r2, #4]
	cmp r6, r3
	bls _0205E14A
	mov r3, #1
	mov ip, r3
	b _0205E156
_0205E14A:
	cmp r6, r3
	bne _0205E156
	cmp r2, r4
	bls _0205E156
	mov r3, #1
	mov ip, r3
_0205E156:
	mov r3, ip
	cmp r3, #0
	beq _0205E160
	str r4, [r0]
	str r2, [r0, #4]
_0205E160:
	add r0, r1, #1
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	cmp r1, #3
	blt _0205E12C
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	cmp r5, #3
	blt _0205E12A
	ldr r0, [sp, #0x3c]
	lsl r0, r0, #1
	str r0, [sp, #0x1c]
	add r0, #8
	str r0, [sp, #0x1c]
	bl _AllocHeadHEAP_USER
	mov r5, r0
	ldr r0, [sp, #0x1c]
	mov r4, #0
	str r0, [sp, #0xc]
	sub r0, #8
	str r0, [sp, #0xc]
	mov r0, r5
	str r0, [sp, #0x4c]
	add r0, #8
	str r0, [sp, #0x4c]
	b _0205E2A0
_0205E198:
	mov r0, #3
	sub r0, r0, r4
	lsl r0, r0, #0x10
	lsr r2, r0, #0xe
	add r0, sp, #0x84
	mov r1, #0
	ldr r0, [r0, r2]
	b _0205E1B8
_0205E1A8:
	lsl r3, r1, #3
	add r2, sp, #0x64
	add r2, r2, r3
	cmp r2, r0
	beq _0205E1BC
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
_0205E1B8:
	cmp r1, #4
	blo _0205E1A8
_0205E1BC:
	mov r0, #0x37
	mov r2, r1
	lsl r0, r0, #8
	mul r2, r0
	ldr r0, [sp, #0x38]
	add r2, #0x80
	add r0, r0, r2
	ldr r2, [sp, #0x1c]
	mov r1, r5
	mov r6, #0
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205E1DE
	mov r0, #2
	str r0, [sp, #0x18]
	b _0205E24E
_0205E1DE:
	ldr r0, [sp, #0xc]
	mov r1, #2
	bl FX_DivS32
	str r0, [sp, #0x28]
	mov r0, r6
	str r0, [sp, #0x20]
_0205E1EC:
	ldr r0, [r5, #0]
	add r1, sp, #0x54
	str r0, [sp, #0x24]
	ldr r0, [r5, #4]
	add r2, sp, #0x58
	str r0, [sp, #0x58]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #0x54]
	ldr r0, [sp, #0x44]
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r2, [sp, #0x28]
	ldr r3, [sp, #0x20]
	ldr r0, [sp, #0x44]
	mul r3, r2
	ldr r2, [sp, #0x4c]
	add r1, sp, #0x54
	add r2, r2, r3
	ldr r3, [sp, #0x28]
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x54]
	mvn r1, r0
	ldr r0, [sp, #0x24]
	cmp r0, r1
	bne _0205E22C
	ldr r0, [sp, #0x20]
	mov r1, #1
	lsl r1, r0
	orr r6, r1
_0205E22C:
	ldr r0, [sp, #0x20]
	add r0, r0, #1
	str r0, [sp, #0x20]
	cmp r0, #2
	blo _0205E1EC
	cmp r6, #0
	bne _0205E240
	mov r0, #4
	str r0, [sp, #0x18]
	b _0205E24E
_0205E240:
	cmp r6, #3
	beq _0205E24A
	mov r0, #3
	str r0, [sp, #0x18]
	b _0205E24E
_0205E24A:
	mov r0, #0
	str r0, [sp, #0x18]
_0205E24E:
	ldr r0, [sp, #0x18]
	cmp r0, #0
	beq _0205E258
	cmp r0, #3
	bne _0205E292
_0205E258:
	mov r1, #0
	mov r0, #1
	b _0205E26C
_0205E25E:
	mov r2, r0
	lsl r2, r1
	tst r2, r6
	bne _0205E270
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
_0205E26C:
	cmp r1, #2
	blo _0205E25E
_0205E270:
	ldr r0, [sp, #0x3c]
	mov r2, r5
	add r2, #8
	mul r1, r0
	add r0, r2, r1
	ldr r2, [sp, #0x10]
	ldr r1, [sp, #0x48]
	add r1, r2, r1
	ldr r2, [sp, #0x3c]
	bl MIi_CpuCopy16
	ldr r0, [sp, #0x18]
	cmp r0, #3
	bne _0205E2A6
	mov r0, #3
	str r0, [sp, #0x14]
	b _0205E2A6
_0205E292:
	cmp r0, #4
	bne _0205E29A
	mov r0, #3
	str r0, [sp, #0x14]
_0205E29A:
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
_0205E2A0:
	cmp r4, #4
	bhs _0205E2A6
	b _0205E198
_0205E2A6:
	cmp r4, #4
	bne _0205E2B0
	mov r0, #4
	str r0, [sp, #0x14]
	b _0205E3AA
_0205E2B0:
	mov r0, r5
	str r0, [sp, #0x50]
	add r0, #8
	str r0, [sp, #0x50]
	b _0205E3A6
_0205E2BA:
	mov r0, #3
	sub r0, r0, r4
	lsl r0, r0, #0x10
	lsr r2, r0, #0xe
	add r0, sp, #0x84
	mov r1, #0
	ldr r0, [r0, r2]
	b _0205E2DA
_0205E2CA:
	lsl r3, r1, #3
	add r2, sp, #0x64
	add r2, r2, r3
	cmp r2, r0
	beq _0205E2DE
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
_0205E2DA:
	cmp r1, #4
	blo _0205E2CA
_0205E2DE:
	mov r0, #0
	beq _0205E2E4
	str r0, [r0]
_0205E2E4:
	mov r0, #0x37
	mov r2, r1
	lsl r0, r0, #8
	mul r2, r0
	ldr r0, [sp, #0x38]
	add r2, #0x80
	add r0, r0, r2
	ldr r2, [sp, #0x1c]
	mov r1, r5
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205E324
	mov r0, #2
	b _0205E396
_0205E324:
	ldr r0, [sp, #0xc]
	mov r1, #2
	bl FX_DivS32
	mov r6, #0
	str r0, [sp, #0x34]
	mov r0, r6
	str r0, [sp, #0x2c]
_0205E334:
	ldr r0, [r5, #0]
	add r1, sp, #0x5c
	str r0, [sp, #0x30]
	ldr r0, [r5, #4]
	add r2, sp, #0x60
	str r0, [sp, #0x60]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #0x5c]
	ldr r0, [sp, #0x44]
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r2, [sp, #0x34]
	ldr r3, [sp, #0x2c]
	ldr r0, [sp, #0x44]
	mul r3, r2
	ldr r2, [sp, #0x50]
	add r1, sp, #0x5c
	add r2, r2, r3
	ldr r3, [sp, #0x34]
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x5c]
	mvn r1, r0
	ldr r0, [sp, #0x30]
	cmp r0, r1
	bne _0205E374
	ldr r0, [sp, #0x2c]
	mov r1, #1
	lsl r1, r0
	orr r6, r1
_0205E374:
	ldr r0, [sp, #0x2c]
	add r0, r0, #1
	str r0, [sp, #0x2c]
	cmp r0, #2
	blo _0205E334
	mov r0, #0
	beq _0205E384
	str r6, [r0]
_0205E384:
	cmp r6, #0
	bne _0205E38C
	mov r0, #4
	b _0205E396
_0205E38C:
	cmp r6, #3
	beq _0205E394
	mov r0, #3
	b _0205E396
_0205E394:
	mov r0, #0
_0205E396:
	sub r0, r0, #3
	cmp r0, #1
	bhi _0205E3A0
	mov r0, #3
	str r0, [sp, #0x14]
_0205E3A0:
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
_0205E3A6:
	cmp r4, #4
	blo _0205E2BA
_0205E3AA:
	cmp r5, #0
	beq _0205E3B4
	mov r0, r5
	bl _FreeHEAP_USER
_0205E3B4:
	ldr r0, [sp, #0x14]
	cmp r0, #2
	bne _0205E3BE
	mov r7, #2
	b _0205E3F6
_0205E3BE:
	cmp r0, #3
	bne _0205E3D4
	ldr r0, [sp, #8]
	mov r1, #1
	ldr r2, [r0, #0]
	ldr r0, [sp, #0x40]
	lsl r1, r0
	ldr r0, [sp, #8]
	orr r1, r2
	str r1, [r0]
	b _0205E3E8
_0205E3D4:
	cmp r0, #4
	bne _0205E3E8
	ldr r0, [sp, #4]
	mov r1, #1
	ldr r2, [r0, #0]
	ldr r0, [sp, #0x40]
	lsl r1, r0
	ldr r0, [sp, #4]
	orr r1, r2
	str r1, [r0]
_0205E3E8:
	ldr r0, [sp, #0x40]
	add r0, r0, #1
	str r0, [sp, #0x40]
_0205E3EE:
	ldr r0, [sp, #0x40]
	cmp r0, #9
	bge _0205E3F6
	b _0205E0BA
_0205E3F6:
	cmp r7, #1
	beq _0205E3FE
	cmp r7, #2
	bne _0205E428
_0205E3FE:
	ldr r1, [sp, #4]
	mov r0, #0
	str r0, [r1]
	ldr r1, [sp, #8]
	ldr r2, =0x00001A68
	str r0, [r1]
	ldr r1, [sp, #0x10]
	bl MIi_CpuClear16
	mov r4, #0
	ldr r6, =0x000001FE
	ldr r5, =SaveGame__ClearDataCallbacks
	b _0205E424
_0205E418:
	lsl r2, r4, #2
	ldr r0, [sp, #0x10]
	ldr r2, [r5, r2]
	mov r1, r6
	blx r2
	add r4, r4, #1
_0205E424:
	cmp r4, #3
	blo _0205E418
_0205E428:
	mov r4, #1
	ldr r6, =savedataBlockOffsets
	mov r5, r4
_0205E42E:
	ldr r0, [sp, #4]
	ldr r1, [r0, #0]
	mov r0, r5
	lsl r0, r4
	tst r0, r1
	bne _0205E44E
	lsl r2, r4, #2
	ldr r3, [r6, r2]
	ldr r0, [sp, #0x10]
	ldr r1, [sp]
	add r0, r0, r3
	add r1, r1, r3
	ldr r3, =savedataBlockSizes
	ldr r2, [r3, r2]
	bl MIi_CpuCopy16
_0205E44E:
	add r4, r4, #1
	cmp r4, #9
	blt _0205E42E
	mov r4, #0
	ldr r5, =SaveGame__LoadDataCallbacks
	b _0205E464
_0205E45A:
	lsl r1, r4, #2
	ldr r0, [sp]
	ldr r1, [r5, r1]
	blx r1
	add r4, r4, #1
_0205E464:
	cmp r4, #1
	blo _0205E45A
	ldr r0, [sp, #0x44]
	cmp r0, #0
	beq _0205E472
	bl _FreeHEAP_USER
_0205E472:
	ldr r0, [sp, #0x10]
	cmp r0, #0
	beq _0205E47C
	bl _FreeHEAP_USER
_0205E47C:
	mov r0, r7
	add sp, #0x94
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

#include <nitro/codereset.h>