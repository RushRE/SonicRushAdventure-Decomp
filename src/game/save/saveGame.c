#include <game/save/saveGame.h>
#include <game/save/saveManager.h>
#include <game/system/sysEvent.h>
#include <game/file/cardBackup.h>
#include <game/graphics/renderCore.h>
#include <game/cutscene/script.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void SeaMapManager__SetUnknown1(s32 a1);

NOT_DECOMPILED void (*SaveGame__UnknownTable2[])(void);
NOT_DECOMPILED void *_02119CB0;
NOT_DECOMPILED u16 SaveGame_cutsceneIDList[];
NOT_DECOMPILED BOOL (*SaveGame__ProgressCheckTable[])(s32 id);
NOT_DECOMPILED void (*SaveGame__SaveDataCallbacks[])(SaveGame *saveGame, SaveBlockFlags blockFlags);
NOT_DECOMPILED void *SaveGame__LoadDataCallbacks;
NOT_DECOMPILED void (*SaveGame__ClearDataCallbacks[])(SaveGame *saveGame, SaveBlockFlags blockFlags);
NOT_DECOMPILED void *_02110DDC;
NOT_DECOMPILED void (*SaveGame__UnknownTable1[])(SaveGameUnknown2119CCC *state);
NOT_DECOMPILED void *_02119C9C;
NOT_DECOMPILED const char *aSonicRush2;
NOT_DECOMPILED void *_02119CCC;
NOT_DECOMPILED size_t savedataBlockSizes[9];
NOT_DECOMPILED size_t savedataBlockOffsets[9];
NOT_DECOMPILED u16 _021108DC[];
NOT_DECOMPILED u16 _021108EA[];
NOT_DECOMPILED u32 SaveGame_ShipUnlockProgress[];
NOT_DECOMPILED u16 SaveGame__hiddenIslandList[];
NOT_DECOMPILED u16 SaveGame__nextStage[];
NOT_DECOMPILED u16 _021107AE[];

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

void SaveGame__Func_205B9F0(s32 value)
{
    gameState.saveFile.field_48 = value;
}

SaveProgress SaveGame__GetGameProgress(void)
{
    return saveGame.stage.progress.gameProgress;
}

NONMATCH_FUNC void SaveGame__SetGameProgress(SaveProgress progress){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =saveGame
	mov r4, r0
	ldr r0, =0x02139554
	strb r4, [r1, #0x2c]
	mov r2, #0
	strh r2, [r0, #0x4c]
	cmp r4, #0x18
	strltb r2, [r1, #0x2d]
	strltb r2, [r1, #0x2e]
	blt _0205BA7C
	cmp r4, #0x19
	blt _0205BA58
	mov r0, #4
	strb r0, [r1, #0x2d]
	mov r0, #6
	strb r0, [r1, #0x2e]
	b _0205BA7C
_0205BA58:
	ldrb r0, [r1, #0x2d]
	cmp r0, #0
	moveq r0, #1
	streqb r0, [r1, #0x2d]
	ldr r0, =saveGame
	ldrb r1, [r0, #0x2e]
	cmp r1, #0
	moveq r1, #1
	streqb r1, [r0, #0x2e]
_0205BA7C:
	cmp r4, #0x1d
	bge _0205BA98
	ldr r0, =saveGame
	ldr r1, [r0, #0x28]
	bic r1, r1, #0xe
	str r1, [r0, #0x28]
	b _0205BAB0
_0205BA98:
	cmp r4, #0x1e
	blt _0205BAB0
	ldr r0, =saveGame
	ldr r1, [r0, #0x28]
	orr r1, r1, #0xe
	str r1, [r0, #0x28]
_0205BAB0:
	cmp r4, #0x11
	bgt _0205BAC8
	ldr r0, =saveGame
	ldr r1, [r0, #0x28]
	bic r1, r1, #0x10
	str r1, [r0, #0x28]
_0205BAC8:
	bl SaveGame__RemoveProgressFlags_0x100
	bl SaveGame__RemoveProgressFlags_0x200
	bl SaveGame__RemoveProgressFlags_0x400
	cmp r4, #2
	ldrlt r0, =saveGame
	ldrlt r1, [r0, #0x28]
	biclt r1, r1, #0x80000
	blt _0205BAF4
	ldr r0, =saveGame
	ldr r1, [r0, #0x28]
	orr r1, r1, #0x80000
_0205BAF4:
	str r1, [r0, #0x28]
	ldr r0, =saveGame
	ldr r1, [r0, #0x28]
	bic r1, r1, #0x700000
	str r1, [r0, #0x28]
	bl SaveGame__Func_205CF9C
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

u8 SaveGame__Func_205BB18(void)
{
    return gameState.saveFile.field_4C;
}

s32 SaveGame__GetUnknownProgress1(void)
{
    return saveGame.stage.progress.unknownProgress1;
}

void SaveGame__SetUnknownProgress1(s32 progress)
{
    saveGame.stage.progress.unknownProgress1 = progress;
    gameState.saveFile.field_4C              = 0;
    saveGame.stage.progress.flags &= ~1;

    SaveGame__RemoveProgressFlags_0x200();
    SaveGame__Func_205CF9C();
}

s32 SaveGame__GetUnknownProgress2(void)
{
    return saveGame.stage.progress.unknownProgress2;
}

void SaveGame__SetUnknownProgress2(s32 progress)
{
    saveGame.stage.progress.unknownProgress2 = progress;
    gameState.saveFile.field_4C              = 0;
    saveGame.stage.progress.flags |= 1;

    SaveGame__RemoveProgressFlags_0x400();
    SaveGame__Func_205CF9C();
}

void SaveGame__Func_205BBBC(void)
{
    gameState.saveFile.field_4C++;
}

BOOL SaveGame__HasDoorPuzzlePiece(u32 id)
{
    return (saveGame.stage.progress.flags & (2 << id)) != 0;
}

void SaveGame__GetPuzzlePiece(u32 id)
{
    saveGame.stage.progress.flags |= (2 << id);
    SaveGame__Func_205CF9C();
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
        case 0:
            SaveGame__SetGameProgress(SAVE_PROGRESS_10);
            break;

        case 1:
            SaveGame__SetGameProgress(SAVE_PROGRESS_23);
            break;

        case 2:
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

NONMATCH_FUNC void SaveGame__SetMissionStatus(u8 id, MissionState status)
{
    // https://decomp.me/scratch/cZorQ -> 95.71%
#ifdef NON_MATCHING
    saveGame.stage.missionState[id / 4] = (saveGame.stage.missionState[id / 4] & ~(MISSION_STATE_COMPLETED << ((id % 4) << 1))) | (status << ((id % 4) << 1));
#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r3, r0, lsr #0x1f
	rsb r2, r3, r0, lsl #30
	ldr lr, =0x02134480
	add r2, r3, r2, ror #30
	mov r3, r2, lsl #1
	mov r2, #3
	ldrb ip, [lr, r0, lsr #2]
	mvn r2, r2, lsl r3
	and r2, ip, r2
	orr r1, r2, r1, lsl r3
	strb r1, [lr, r0, lsr #2]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

MissionState SaveGame__GetMissionStatus(u8 id)
{
    return (saveGame.stage.missionState[id / 4] >> ((id % 4) << 1)) & 3;
}

void SaveGame__SetMissionAttempted(u8 id, BOOL attempted)
{
    u32 shift = (id % 8);
    if (attempted)
        saveGame.stage.missionAttemptState[id / 8] |= (1 << shift);
    else
        saveGame.stage.missionAttemptState[id / 8] &= ~(1 << shift);
}

BOOL SaveGame__GetMissionAttempted(u8 id)
{
    return (saveGame.stage.missionAttemptState[id / 8] & (1 << (id % 8))) != 0;
}

u16 SaveGame__GetBlock1GameProgress(void)
{
    return saveGame.system.progress.gameProgress;
}

void SaveGame__GsExit(u16 value)
{
    gameState.saveFile.field_52 = value;
}

NONMATCH_FUNC void SaveGame__Func_205BDC8(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r0, r0, lsl #1
	mov r2, #0x800
	mov r2, r2, lsl r0
	sub r0, r1, #1
	cmp r1, #2
	mov r1, r2, lsl r0
	ldr r2, =0x02134474
	bne _0205BDF8
	ldr r0, [r2]
	tst r0, r1, lsr #1
	orreq r0, r0, r1, lsr #1
	streq r0, [r2]
_0205BDF8:
	ldr r0, [r2]
	ldr ip, =SaveGame__Func_205CF9C
	orr r0, r0, r1
	str r0, [r2]
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC BOOL SaveGame__GetNextShipUpgrade(u16 *ship, u16 *level){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl SaveGame__GetGameProgress
	cmp r0, #0x24
	movlt r0, #0
	ldmltia sp!, {r4, r5, r6, pc}
	mov r0, #3
	bl SaveGame__GetShipUpgradeStatus
	cmp r0, #2
	movhs r0, #0
	ldmhsia sp!, {r4, r5, r6, pc}
	mov r0, #3
	bl SaveGame__GetShipUpgradeStatus
	cmp r0, #0
	mov r4, #0
	bne _0205BE98
_0205BE58:
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetShipUpgradeStatus
	cmp r0, #0
	bne _0205BE88
	cmp r6, #0
	strneh r4, [r6]
	cmp r5, #0
	movne r0, #1
	strneh r0, [r5]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0205BE88:
	add r4, r4, #1
	cmp r4, #4
	blt _0205BE58
	b _0205BED4
_0205BE98:
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetShipUpgradeStatus
	cmp r0, #1
	bne _0205BEC8
	cmp r6, #0
	strneh r4, [r6]
	cmp r5, #0
	movne r0, #2
	strneh r0, [r5]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0205BEC8:
	add r4, r4, #1
	cmp r4, #4
	blt _0205BE98
_0205BED4:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

BOOL SaveGame__Func_205BEDC(void)
{
    if (!SaveGame__Func_205CF4C(2))
        return FALSE;

    SaveGame__Func_205CF80(2);
    return TRUE;
}

void SaveGame__Block1__SetFlags1_0x80000(void)
{
    saveGame.stage.progress.flags |= 0x80000;
    SaveGame__Func_205CF9C();
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
    SaveGame__Func_205CF68(4 << id);
}

BOOL SaveGame__Func_205BF78(s32 id)
{
    if (id == 0)
        return TRUE;

    return SaveGame__Func_205CF4C(4 << id);
}

void SaveGame__SaveClearCallback_Stage(SaveGame *save, SaveBlockFlags blockFlags)
{
    if ((blockFlags & SAVE_BLOCK_FLAG_STAGE) == 0)
        return;

    save->stage.status.difficulty = DIFFICULTY_EASY;
    save->stage.status.timeLimit  = FALSE;
    save->stage.status.lives      = 2;
}

void SaveGame__UpdateProgress(void)
{
    SaveGameUnknown2119CCC *state = SaveGame__Func_205C00C();
    if (state != NULL && state->field_4 < 8)
    {
        SaveGame__UnknownTable1[state->field_4](state);
    }
    else
    {
        SaveGame__UnknownTable2[SaveGame__Func_205CF3C()]();
    }
}

NONMATCH_FUNC SaveGameUnknown2119CCC *SaveGame__Func_205C00C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bl SaveGame__GetGameProgress
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	bl SaveGame__GetUnknownProgress1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	bl SaveGame__GetUnknownProgress2
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	bl SaveGame__Func_205BB18
	mov r8, r0
	bl SaveGame__Func_205CF3C
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #4
	moveq r9, #3
	cmp r9, #5
	bne _0205C078
	ldr r0, =gameState
	ldrh r0, [r0, #0x28]
	bl SaveGame__Func_205D150
	cmp r0, #0
	beq _0205C094
	mov r0, #0
	bl SaveGame__GsExit
	b _0205C094
_0205C078:
	cmp r9, #9
	bne _0205C094
	bl SaveGame__GetGameProgress
	cmp r0, #0x27
	bge _0205C094
	mov r0, #0
	bl SaveGame__GsExit
_0205C094:
	cmp r5, #0x18
	mov r4, #0
	beq _0205C134
	ldr r0, =0x02110B20
	mov r1, r5, lsl #1
	ldrh r10, [r0, r1]
	cmp r8, r10
	bhs _0205C134
	ldr r0, =_02119CCC
	ldr r4, [r0, r5, lsl #2]
	cmp r4, #0
	beq _0205C264
	mov r0, #0xc
	mul r0, r8, r0
	ldrh r0, [r4, r0]!
	cmp r0, #0xc
	bhs _0205C100
	cmp r0, r9
	bne _0205C0F8
	ldr r1, =SaveGame__ProgressCheckTable
	ldrh r0, [r4, #2]
	ldr r1, [r1, r9, lsl #2]
	blx r1
	cmp r0, #0
	bne _0205C100
_0205C0F8:
	mov r4, #0
	b _0205C264
_0205C100:
	ldrh r0, [r4, #0xa]
	cmp r0, #0
	beq _0205C128
	add r0, r8, #1
	cmp r0, r10
	bge _0205C120
	bl SaveGame__IncrementUnknownCounter
	b _0205C128
_0205C120:
	bl SaveGame__IncrementGameProgress
	bl SaveGame__ResetUnknownCounter
_0205C128:
	mov r0, #0
	bl SaveGame__GsExit
	b _0205C264
_0205C134:
	movs r0, #0
	bne _0205C1CC
	ldr r0, =0x021107BE
	mov r1, r6, lsl #1
	ldrh r5, [r0, r1]
	cmp r8, r5
	bhs _0205C1CC
	ldr r0, =_02119C9C
	ldr r4, [r0, r6, lsl #2]
	cmp r4, #0
	beq _0205C1CC
	mov r0, #0xc
	mul r0, r8, r0
	ldrh r0, [r4, r0]!
	cmp r0, #0xc
	bhs _0205C19C
	cmp r0, r9
	bne _0205C194
	ldr r1, =SaveGame__ProgressCheckTable
	ldrh r0, [r4, #2]
	ldr r1, [r1, r9, lsl #2]
	blx r1
	cmp r0, #0
	bne _0205C19C
_0205C194:
	mov r4, #0
	b _0205C1CC
_0205C19C:
	ldrh r0, [r4, #0xa]
	cmp r0, #0
	beq _0205C1C4
	add r0, r8, #1
	cmp r0, r5
	bge _0205C1BC
	bl SaveGame__IncrementUnknownCounter
	b _0205C1C4
_0205C1BC:
	bl SaveGame__IncrementUnknownProgress1
	bl SaveGame__ResetUnknownCounter
_0205C1C4:
	mov r0, #0
	bl SaveGame__GsExit
_0205C1CC:
	cmp r4, #0
	bne _0205C264
	ldr r0, =0x021108DC
	mov r1, r7, lsl #1
	ldrh r5, [r0, r1]
	cmp r8, r5
	bhs _0205C264
	ldr r0, =_02119CB0
	ldr r4, [r0, r7, lsl #2]
	cmp r4, #0
	beq _0205C264
	mov r0, #0xc
	mul r0, r8, r0
	ldrh r0, [r4, r0]!
	cmp r0, #0xc
	bhs _0205C234
	cmp r0, r9
	bne _0205C22C
	ldr r1, =SaveGame__ProgressCheckTable
	ldrh r0, [r4, #2]
	ldr r1, [r1, r9, lsl #2]
	blx r1
	cmp r0, #0
	bne _0205C234
_0205C22C:
	mov r4, #0
	b _0205C264
_0205C234:
	ldrh r0, [r4, #0xa]
	cmp r0, #0
	beq _0205C25C
	add r0, r8, #1
	cmp r0, r5
	bge _0205C254
	bl SaveGame__IncrementUnknownCounter
	b _0205C25C
_0205C254:
	bl SaveGame__IncrementUnknownProgress2
	bl SaveGame__ResetUnknownCounter
_0205C25C:
	mov r0, #0
	bl SaveGame__GsExit
_0205C264:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

void SaveGame__UnknownTable2Func_205C28C(void)
{
    SaveGame__ChangeEvent(SYSEVENT_RETURN_TO_HUB);
}

void SaveGame__UnknownTable2Func_205C29C(void)
{
    SaveGame__StartEvent35();
}

void SaveGame__UnknownTable2Func_205C2A8(void)
{
    if (SaveGame__Func_205CF4C(1) || gameState.sailUnknown1 != 0)
    {
        SaveGame__Func_205CF80(1);
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

        SaveGame__Func_205B9F0(2);
        SaveGame__Func_205CF68(1);
        SaveGame__StartCutscene(cutscene, SYSEVENT_UPDATE_PROGRESS, TRUE);
    }
}

void SaveGame__UnknownTable2Func_205C344(void)
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

void SaveGame__UnknownTable2Func_205C39C(void)
{
    SaveGame__StartStoryMode();
}

void SaveGame__UnknownTable2Func_205C3A8(void)
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

    SaveGame__Func_205CF9C();

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
            SaveGame__Func_205B9F0(4);
        }
        else if (stageID == STAGE_BOSS_FINAL)
        {
            static const u16 cutsceneIDList[] = { CUTSCENE_GHOST_TITANS_IMPACT, CUTSCENE_ENDING, CUTSCENE_INVALID };

            u16 cutsceneID = cutsceneIDList[SaveGame__Func_205BB18()];
            SaveGame__Func_205BBBC();
            if (SaveGame__Func_205BB18() >= 3)
            {
                SaveGame__ResetUnknownCounter();
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
                gameState.creditsMode = 0;
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
                    SaveGame__Func_205B9F0(0);
                    SaveGame__StartCutscene(CUTSCENE_MYSTERIOUS_MARKER_NO_1, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }
                else
                {
                    if (!SaveGame__HasDoorPuzzlePiece(0))
                    {
                        SaveGame__GetPuzzlePiece(0);
                        SaveGame__Func_205B9F0(0);
                        SaveGame__StartCutscene(CUTSCENE_CLUE_NO_1, SYSEVENT_UPDATE_PROGRESS, TRUE);
                        return;
                    }
                }
            }
            else if (stageID == STAGE_HIDDEN_ISLAND_4)
            {
                if (SaveGame__GetGameProgress() < SAVE_PROGRESS_29)
                {
                    SaveGame__Func_205B9F0(0);
                    SaveGame__StartCutscene(CUTSCENE_MYSTERIOUS_MARKER_NO_2, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }

                if (!SaveGame__HasDoorPuzzlePiece(1))
                {
                    SaveGame__GetPuzzlePiece(1);
                    SaveGame__Func_205B9F0(0);
                    SaveGame__StartCutscene(CUTSCENE_CLUE_NO_2, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }
            }
            else if (stageID == STAGE_HIDDEN_ISLAND_5)
            {
                if (SaveGame__GetGameProgress() < SAVE_PROGRESS_29)
                {
                    SaveGame__Func_205B9F0(0);
                    SaveGame__StartCutscene(CUTSCENE_MYSTERIOUS_MARKER_NO_1, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }
                else
                {
                    if (!SaveGame__HasDoorPuzzlePiece(2))
                    {
                        SaveGame__GetPuzzlePiece(2);
                        SaveGame__Func_205B9F0(0);
                        SaveGame__StartCutscene(CUTSCENE_CLUE_NO_3, SYSEVENT_UPDATE_PROGRESS, TRUE);
                        return;
                    }
                }
            }

            SaveGame__Func_205B9F0(0);
        }

        SaveGame__RestartEvent();
    }
}

void SaveGame__UnknownTable2Func_205C700(void)
{
    gameState.saveFile.field_50 = -1;
    gameState.saveFile.field_51 = -1;
    SaveGame__StartSailRivalRace();
}

NONMATCH_FUNC void SaveGame__UnknownTable2Func_205C720(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r0, =gameState
	ldr r1, [r0, #0xb8]
	str r1, [r0, #0xa0]
	ldrb r4, [r0, #0x150]
	cmp r4, #7
	bhs _0205C770
	ldr r0, =0x0213461C
	mov r1, r4
	bl SaveGame__HasChaosEmerald
	cmp r0, #0
	bne _0205C770
	ldr r0, =0x0213461C
	mov r1, r4
	bl SaveGame__SetChaosEmeraldCollected
	ldr r0, =gameState
	mov r1, #0xff
	strb r1, [r0, #0x151]
	bl SaveGame__StartEmeraldCollected
	ldmia sp!, {r4, pc}
_0205C770:
	bl SaveGame__StartSailing
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void SaveGame__UnknownTable2Func_205C780(void)
{
    if (SaveGame__Func_205BB18() >= 7)
    {
        SaveGame__ResetUnknownCounter();
        if (SaveGame__GetGameProgress() <= SAVE_PROGRESS_37)
            SaveGame__SetGameProgress(SAVE_PROGRESS_38);
        SaveGame__StartExBoss();
    }
    else
    {
        u16 id = _021108EA[SaveGame__Func_205BB18()];
        SaveGame__Func_205BBBC();
        SaveGame__StartCutscene(id, SYSEVENT_UPDATE_PROGRESS, SaveGame__GetGameProgress() >= SAVE_PROGRESS_38);
    }
}

NONMATCH_FUNC void SaveGame__UnknownTable2Func_205C7E8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r0, =0x02139554
	ldrh r0, [r0, #0x52]
	cmp r0, #1
	bne _0205C834
	bl SaveGame__Func_205BB18
	cmp r0, #0
	bne _0205C818
	bl SaveGame__Func_205BBBC
	mov r0, #0x12
	bl SaveGame__ChangeEvent
	ldmia sp!, {r3, r4, r5, pc}
_0205C818:
	bl SaveGame__ResetUnknownCounter
	ldr r1, =0x02139554
	mov r2, #1
	mov r0, #0x1d
	strh r2, [r1, #0x54]
	bl SaveGame__ChangeEvent
	ldmia sp!, {r3, r4, r5, pc}
_0205C834:
	bl SaveGame__Func_205BB18
	cmp r0, #5
	blo _0205C870
	bl SaveGame__ResetUnknownCounter
	bl SaveGame__GetGameProgress
	cmp r0, #0x26
	bgt _0205C858
	mov r0, #0x27
	bl SaveGame__SetGameProgress
_0205C858:
	ldr r1, =gameState
	mov r2, #2
	mov r0, #6
	str r2, [r1, #0x15c]
	bl SaveGame__ChangeEvent
	ldmia sp!, {r3, r4, r5, pc}
_0205C870:
	bl SaveGame__Func_205BB18
	mov r4, r0
	ldr r0, =0x021107B4
	mov r1, r4, lsl #1
	ldrh r5, [r0, r1]
	bl SaveGame__Func_205BBBC
	ldr r0, =0x0000FFFF
	cmp r5, r0
	beq _0205C8C4
	bl SaveGame__GetGameProgress
	cmp r0, #0x27
	movge r3, #1
	ldr r2, =0x02139520
	movlt r3, #0
	mov r1, #0x28
	mov r0, #0x22
	strh r1, [r2, #4]
	str r3, [r2, #8]
	str r5, [r2]
	bl SaveGame__ChangeEvent
	ldmia sp!, {r3, r4, r5, pc}
_0205C8C4:
	cmp r4, #1
	bne _0205C8D8
	mov r0, #0x12
	bl SaveGame__ChangeEvent
	ldmia sp!, {r3, r4, r5, pc}
_0205C8D8:
	ldr r1, =gameState
	mov r2, #1
	mov r0, #6
	str r2, [r1, #0x15c]
	bl SaveGame__ChangeEvent
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void SaveGame__UnknownTable2Func_205C904(void)
{
    SaveGame__Func_205BBBC();
    SaveGame__Func_205B9F0(3);
    SaveGame__RestartEvent();
}

NONMATCH_FUNC void SaveGame__UnknownTable2Func_205C91C(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r0, =gameState
	ldr r1, =0x02110B70
	ldr r2, [r0, #0x80]
	mov r0, r2, lsl #1
	cmp r2, #0xe
	ldrh r4, [r1, r0]
	bne _0205C964
	bl SaveGame__GetGameProgress
	cmp r0, #0x11
	bge _0205C964
	mov r0, #0
	bl SaveGame__Func_205B9F0
	mov r0, #0x1d
	mov r1, #0x28
	mov r2, #1
	bl SaveGame__StartCutscene
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0205C964:
	ldr r0, =gameState
	ldr r0, [r0, #0x80]
	cmp r0, #0xe
	bne _0205C99C
	bl SaveGame__GetGameProgress
	cmp r0, #0x11
	ble _0205C99C
	mov r0, #0
	bl SaveGame__Func_205B9F0
	mov r0, #0x1f
	mov r1, #0x28
	mov r2, #1
	bl SaveGame__StartCutscene
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0205C99C:
	ldr r0, =gameState
	ldr r0, [r0, #0x80]
	cmp r0, #0xc
	bne _0205C9D4
	bl SaveGame__GetUnknownProgress2
	cmp r0, #1
	ble _0205C9D4
	mov r0, #0
	bl SaveGame__Func_205B9F0
	mov r0, #0x1f
	mov r1, #0x28
	mov r2, #1
	bl SaveGame__StartCutscene
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0205C9D4:
	ldr r5, =0x02134474
	ldr r6, =0x02110958
	mov r7, #0
_0205C9E0:
	mov r0, r7, lsl #1
	ldrh r0, [r6, r0]
	cmp r4, r0
	bne _0205CA1C
	mov r0, r5
	mov r1, r7
	bl SaveGame__GetIslandProgress
	cmp r0, #1
	bge _0205CA1C
	ldr r0, =0x02134474
	mov r1, r7
	mov r2, #1
	bl SaveGame__SetIslandProgress
	bl SaveGame__Func_205CF9C
	b _0205CA28
_0205CA1C:
	add r7, r7, #1
	cmp r7, #0xe
	blt _0205C9E0
_0205CA28:
	cmp r4, #0x2e
	bhs _0205CA48
	ldr r1, =gameState
	mov r0, #3
	strh r4, [r1, #0x28]
	bl SaveGame__Func_205B9F0
	bl SaveGame__RestartEvent
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0205CA48:
	mov r0, #0
	bl SaveGame__Func_205B9F0
	bl SaveGame__RestartEvent
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
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

NONMATCH_FUNC void SaveGame__UnknownTable1Func_205CB60(SaveGameUnknown2119CCC *a1)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r4, [r5, #6]
	cmp r4, #0x28
	bne _0205CB84
	bl SaveGame__GetUnknownProgress2
	cmp r0, #6
	moveq r4, #0x29
	b _0205CBB0
_0205CB84:
	cmp r4, #0x2d
	bne _0205CB9C
	bl SaveGame__GetUnknownProgress1
	cmp r0, #4
	movne r4, #0x2e
	b _0205CBB0
_0205CB9C:
	cmp r4, #0x1e
	cmpne r4, #0x2a
	bne _0205CBB0
	mov r0, #0
	bl SaveGame__Func_205B9F0
_0205CBB0:
	ldrh r1, [r5, #8]
	mov r0, r4
	mov r2, #0
	bl SaveGame__StartCutscene
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void SaveGame__UnknownTable1Func_205CBC4(SaveGameUnknown2119CCC *a1)
{
    SaveGame__StartTutorial();
}

void SaveGame__UnknownTable1Func_205CBD0(SaveGameUnknown2119CCC *a1)
{
    SaveGame__StartEvent37();
}

void SaveGame__UnknownTable1Func_205CBDC(SaveGameUnknown2119CCC *a1)
{
    SaveGame__StartSailJetTraining();
}

void SaveGame__UnknownTable1Func_205CBE8(SaveGameUnknown2119CCC *a1)
{
    SaveGame__StartHubMenu();
}

void SaveGame__UnknownTable1Func_205CBF4(SaveGameUnknown2119CCC *a1)
{
    SaveGame__StartDoorPuzzle(a1->id);
}

void SaveGame__UnknownTable1Func_205CC04(SaveGameUnknown2119CCC *a1)
{
    if (a1->id == 0)
        SeaMapManager__SetUnknown1(0);
    else
        SeaMapManager__SetUnknown1(1);

    SaveGame__Func_205B9F0(5);
    SaveGame__ChangeEvent(SYSEVENT_38);
}

void SaveGame__UnknownTable1Func_205CC3C(SaveGameUnknown2119CCC *a1)
{
    if (a1->id == 24)
        SaveGame__Func_205CF68(2);

    gameState.stageID = a1->id;
    SaveGame__Func_205B9F0(3);
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
            SaveGame__Func_205CF68(1);
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
        gameState.doorPuzzleState = 0;
    }
    else
    {
        if (SaveGame__GetGameProgress() <= SAVE_PROGRESS_31)
            gameState.doorPuzzleState = 1;
        else
            gameState.doorPuzzleState = 2;
    }

    SaveGame__Func_205B9F0(10);
    SaveGame__ChangeEvent(SYSEVENT_DOOR_PUZZLE);
}

void SaveGame__StartStageSelect(void)
{
    gameState.gameMode = GAMEMODE_STORY;

    SaveGame__ChangeEvent(SYSEVENT_7);
}

void SaveGame__StartEmeraldCollected(void)
{
    SaveGame__Func_205B9F0(7);
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

void SaveGame__IncrementUnknownCounter(void)
{
    gameState.saveFile.field_4C++;
}

void SaveGame__ResetUnknownCounter(void)
{
    gameState.saveFile.field_4C = 0;
}

s32 SaveGame__Func_205CF3C(void)
{
    return gameState.saveFile.field_48;
}

BOOL SaveGame__Func_205CF4C(u16 id)
{
    return (id & gameState.saveFile.flags) != 0;
}

void SaveGame__Func_205CF68(u16 mask)
{
    gameState.saveFile.flags |= mask;
}

void SaveGame__Func_205CF80(u16 mask)
{
    gameState.saveFile.flags &= ~mask;
}

NONMATCH_FUNC void SaveGame__Func_205CF9C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r4, =0x02134474
	ldr r5, =0x0213445C
	ldrb r1, [r4, #4]
	ldrb r0, [r5, #4]
	cmp r0, r1
	bhs _0205CFDC
	ldr r0, [r4]
	strb r1, [r5, #4]
	tst r0, #0x100
	ldr r0, [r5]
	orrne r0, r0, #0x100
	strne r0, [r5]
	biceq r0, r0, #0x100
	streq r0, [r5]
	b _0205CFF4
_0205CFDC:
	bne _0205CFF4
	ldr r0, [r4]
	tst r0, #0x100
	ldrne r0, [r5]
	orrne r0, r0, #0x100
	strne r0, [r5]
_0205CFF4:
	ldrb r1, [r4, #5]
	ldrb r0, [r5, #5]
	cmp r0, r1
	bhi _0205D024
	strb r1, [r5, #5]
	cmp r1, #2
	bne _0205D024
	ldr r0, [r4]
	tst r0, #0x200
	ldrne r0, [r5]
	orrne r0, r0, #0x200
	strne r0, [r5]
_0205D024:
	ldrb r1, [r4, #6]
	ldrb r0, [r5, #6]
	cmp r0, r1
	bhi _0205D054
	strb r1, [r5, #6]
	cmp r1, #4
	bne _0205D054
	ldr r0, [r4]
	tst r0, #0x400
	ldrne r0, [r5]
	orrne r0, r0, #0x400
	strne r0, [r5]
_0205D054:
	ldr r1, [r4]
	ldr r0, =0x000FF8FE
	ldr r2, [r5]
	and r0, r1, r0
	orr r0, r2, r0
	str r0, [r5]
	mov r7, #0
_0205D070:
	mov r0, r4
	mov r1, r7
	bl SaveGame__GetIslandProgress
	mov r6, r0
	mov r0, r5
	mov r1, r7
	bl SaveGame__GetIslandProgress
	cmp r0, r6
	bge _0205D0A4
	mov r0, r5
	mov r1, r7
	mov r2, r6
	bl SaveGame__SetIslandProgress
_0205D0A4:
	add r7, r7, #1
	cmp r7, #0xe
	blt _0205D070
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
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

NONMATCH_FUNC void SaveGame__Func_205D150(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl SaveGame__GetGameProgress
	and r4, r0, #0xff
	bl SaveGame__GetUnknownProgress1
	and r5, r0, #0xff
	bl SaveGame__GetUnknownProgress2
	ldr r1, =saveGame
	and lr, r0, #0xff
	ldr r2, [r1, #0x28]
	tst r2, #0x100
	movne r0, #1
	moveq r0, #0
	tst r2, #0x200
	movne r1, #1
	moveq r1, #0
	tst r2, #0x400
	movne r2, #1
	moveq r2, #0
	cmp r6, #0x18
	bgt _0205D278
	ldr ip, =0x02110C20
	ldrb r3, [ip, r6, lsl #2]
	add r6, ip, r6, lsl #2
	cmp r3, #0xff
	cmpne r3, r4
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	ldrb r3, [r6, #1]
	cmp r3, #0xff
	cmpne r3, r5
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	ldrb r3, [r6, #2]
	cmp r3, #0xff
	cmpne r3, lr
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	ldrb r3, [r6, #3]
	cmp r3, #6
	addls pc, pc, r3, lsl #2
	b _0205D270
_0205D1F8: // jump table
	b _0205D270 // case 0
	b _0205D214 // case 1
	b _0205D224 // case 2
	b _0205D234 // case 3
	b _0205D244 // case 4
	b _0205D254 // case 5
	b _0205D264 // case 6
_0205D214:
	cmp r0, #0
	beq _0205D270
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0205D224:
	cmp r0, #0
	bne _0205D270
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0205D234:
	cmp r1, #0
	beq _0205D270
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0205D244:
	cmp r1, #0
	bne _0205D270
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0205D254:
	cmp r2, #0
	beq _0205D270
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0205D264:
	cmp r2, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
_0205D270:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0205D278:
	cmp r6, #0x1b
	bgt _0205D2A0
	sub r0, r6, #0x19
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__HasDoorPuzzlePiece
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0205D2A0:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
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
    return SaveGame__GetGameProgress() == SAVE_PROGRESS_15 && SaveGame__Func_205BB18() >= 1;
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

NONMATCH_FUNC void SaveGame__Func_205D520(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl SaveGame__GetGameProgress
	mov r5, r0
	bl SaveGame__GetUnknownProgress1
	mov r4, r0
	bl SaveGame__GetUnknownProgress2
	mov r1, #6
	mul r2, r6, r1
	ldr r1, =0x02110D00
	ldrh r1, [r1, r2]
	cmp r5, r1
	ldrge r1, =0x02110D02
	ldrgeh r1, [r1, r2]
	cmpge r4, r1
	ldrge r1, =0x02110D04
	ldrgeh r1, [r1, r2]
	cmpge r0, r1
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

BOOL SaveGame__GetBoughtInfo(u8 id)
{
    return (saveGame.stage.progress.flags & (0x20 << id)) != 0;
}

void SaveGame__SetBoughtInfo(u8 id)
{
    saveGame.stage.progress.flags |= 0x20 << id;
}

BOOL SaveGame__GetProgressFlags_0x100000(u8 id)
{
    return (saveGame.stage.progress.flags & (0x100000 << id)) != 0;
}

void SaveGame__SetProgressFlags_0x100000(u8 id)
{
    saveGame.stage.progress.flags |= 0x100000 << id;
}

BOOL SaveGame__CheckProgress29(void)
{
    return SaveGame__GetGameProgress() == SAVE_PROGRESS_29;
}

BOOL SaveGame__CheckRingsForPurchase(void)
{
    return saveGame.stage.ringCount >= 800;
}

void SaveGame__UseRingsForPurchase(void)
{
    saveGame.stage.ringCount -= 800;
}

BOOL SaveGame__CheckProgress37(void)
{
    return SaveGame__GetGameProgress() >= SAVE_PROGRESS_37;
}

NONMATCH_FUNC void SaveGame__Func_205D65C(void){
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
	ldr r9, =0x02110D48
	ldr r6, =0x02110D12
	mov r7, r8
	strb r0, [sp, #1]
	add r5, sp, #0
	mov r4, #6
_0205D694:
	ldrh r0, [r9]
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

NONMATCH_FUNC void SaveGame__Func_205D758(void){
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
	ldr r8, =0x02110D48
	ldr r5, =0x02110D12
	mov r6, r7
	strb r0, [sp, #1]
	add r4, sp, #0
	mov r11, #6
_0205D790:
	ldrh r0, [r8]
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
	ldr r0, =0x02110D2A
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

BOOL SaveGame__GetShipUpgradeStatus(u16 id)
{
    return SaveGame__GetShipUpgradeStatus_(id, saveGame.stage.progress.flags);
}

NONMATCH_FUNC BOOL SaveGame__GetShipUpgradeStatus_(u16 id, u32 flags)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r0, r0, lsl #1
	mov r2, #0x800
	tst r1, r2, lsl r0
	mov r0, r2, lsl r0
	moveq r0, #0
	bxeq lr
	tst r1, r0, lsl #1
	movne r0, #2
	moveq r0, #1
	bx lr

// clang-format on
#endif
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

NONMATCH_FUNC SaveErrorTypes SaveGame__SaveData(SaveGame *work, SaveBlockFlags flags){
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
	bl STD_CopyLString
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
        STD_CopyLString(signatureW, "sonic_rush2", 12);
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
                MATH_CRC32Update(crcTable, &context, &writeCount, sizeof(writeCount));
                MATH_CRC32Update(crcTable, &context, (u8 *)work + offset, size);

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
	bl STD_CopyLString
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