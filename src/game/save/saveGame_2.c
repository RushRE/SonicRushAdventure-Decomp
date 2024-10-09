#include <game/save/saveGame.h>
#include <game/save/saveManager.h>
#include <game/system/sysEvent.h>
#include <game/file/cardBackup.h>
#include <game/graphics/renderCore.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void SeaMapManager__SetUnknown1(void);
NOT_DECOMPILED BOOL SeaMapManager__GetSaveFlag_(u8 *flags, u32 id);
NOT_DECOMPILED void SeaMapManager__SetSaveFlag_(u8 *flags, u32 id, BOOL state);

NOT_DECOMPILED void *aSonic;

// const size_t savedataBlockSizes[9] = { 0, 0x28, 0x1A8, 0x6C8, 0x474, 0x12C, 0x18, 0x3C8, 0x850 };
// const size_t _02110DDC[9] = { 0, 0, 0x80, 0x400, 0x1200, 0x1B00, 0x1D80, 0x1E00, 0x2600 };
// const size_t savedataBlockOffsets[9] = { 0, 0, 0x28, 0x1D0, 0x898, 0xD0C, 0xE38, 0xE50, 0x1218 };

static const u8 missionForSolEmerald[7] = { 19, 77, 29, 86, 81, 69, 71 };

// --------------------
// VARIABLES
// --------------------

// --------------------
// FUNCTIONS
// --------------------

#include <nitro/code16.h>

NONMATCH_FUNC void SaveGame__SaveClearCallback_Common(SaveGame *save, SaveBlockFlags blockFlags)
{
    // https://decomp.me/scratch/JxrCv -> 56.98%
#ifdef NON_MATCHING
    s32 i;
    
    if ((blockFlags & SAVE_BLOCK_FLAG_ONLINE_PROFILE) != 0)
    {
        DWC_CreateUserData(&save->onlineProfile.userData, 'A3YJ');

        for (i = 0; i < SAVEGAME_MAX_FRIEND_COUNT; i++)
        {
            DWC_DeleteBuddyFriendData(&save->onlineProfile.friendList[i]);
        }
    }

    if ((blockFlags & SAVE_BLOCK_FLAG_STAGE) != 0)
    {
        for (i = 0; i < SAVEGAME_MATERIAL_TYPE_COUNT; i++)
        {
            save->stage.materialCount[i] = SAVEGAME_MATERIAL_NONE;
        }

        for (i = 0; i < STAGE_HIDDEN_ISLAND_R1; i++)
        {
            save->stage.stageRecords[DIFFICULTY_EASY][i].score = 0;
            save->stage.stageRecords[DIFFICULTY_EASY][i].rank  = 3;

            save->stage.stageRecords[DIFFICULTY_NORMAL][i].score = 0;
            save->stage.stageRecords[DIFFICULTY_NORMAL][i].rank  = 3;
        }
    }

    if ((blockFlags & SAVE_BLOCK_FLAG_SYSTEM) != 0)
    {
        OSOwnerInfo ownerInfo;
        OS_GetOwnerInfo(&ownerInfo);

        if (ownerInfo.nickNameLength == 0)
        {
#ifdef RUSH2_JAPAN
            SaveGame__SetPlayerName(&save->system.name, L"SONIC", 4);
#else
            SaveGame__SetPlayerName(&save->system.name, L"SONIC", 5);
#endif
        }
        else if (ownerInfo.nickNameLength >= SAVEGAME_MAX_NAME_LEN + 1)
        {
            SaveGame__SetPlayerName(&save->system.name, ownerInfo.nickName, SAVEGAME_MAX_NAME_LEN - 1);
            save->system.name.text[7] = 0x2026; // '…'
        }
        else
        {
            SaveGame__SetPlayerName(&save->system.name, ownerInfo.nickName, ownerInfo.nickNameLength);
        }
    }
#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x5c
	str r1, [sp]
	mov r5, r0
	ldr r0, [sp]
	mov r1, #0x80
	tst r0, r1
	beq _0205EB30
	mov r0, #0xe5
	lsl r0, r0, #4
	ldr r1, =0x4133594A
	add r0, r5, r0
	bl DWC_CreateUserData
	mov r0, #0xe9
	lsl r0, r0, #4
	mov r4, #0
	add r6, r5, r0
	mov r7, #0xc
	b _0205EB2C
_0205EB20:
	mov r0, r4
	mul r0, r7
	add r0, r6, r0
	bl DWC_DeleteBuddyFriendData
	add r4, r4, #1
_0205EB2C:
	cmp r4, #0x1e
	blt _0205EB20
_0205EB30:
	ldr r0, [sp]
	mov r1, #4
	tst r0, r1
	beq _0205EB88
	mov r2, #0xff
	mov r0, r2
	mov r4, #0
	add r0, #0xc5
	b _0205EB48
_0205EB42:
	add r1, r5, r4
	strb r2, [r1, r0]
	add r4, r4, #1
_0205EB48:
	cmp r4, #9
	blt _0205EB42
	mov r0, #0x11
	lsl r0, r0, #4
	mov r3, r5
	add r1, r5, r0
	mov r0, #3
	mov r4, #0
	add r3, #0x64
	str r0, [sp, #8]
	mov r7, r0
	b _0205EB84
_0205EB60:
	lsl r2, r4, #2
	ldr r6, [r3, r2]
	ldr r0, [sp, #8]
	str r6, [sp, #4]
	bic r6, r0
	str r6, [sp, #4]
	ldr r0, [sp, #4]
	mov r6, #3
	orr r0, r6
	str r0, [r3, r2]
	ldr r0, [r1, r2]
	add r4, r4, #1
	bic r0, r7
	mov ip, r0
	mov r0, r6
	mov r6, ip
	orr r0, r6
	str r0, [r1, r2]
_0205EB84:
	cmp r4, #0x2b
	blt _0205EB60
_0205EB88:
	ldr r0, [sp]
	mov r1, #2
	tst r0, r1
	beq _0205EBC4
	add r0, sp, #0xc
	bl OS_GetOwnerInfo
	add r0, sp, #0xc
	ldrh r2, [r0, #0x18]
	cmp r2, #0
	bne _0205EBAA
	ldr r1, =aSonic
	mov r0, r5
	mov r2, #5 // ROM DIFF: international = 5, JP = 4
	bl SaveGame__SetPlayerName
	b _0205EBC4
_0205EBAA:
	cmp r2, #9
	add r1, sp, #0x10
	blo _0205EBBE
	mov r0, r5
	mov r2, #7
	bl SaveGame__SetPlayerName
	ldr r0, =0x00002026
	strh r0, [r5, #0xe]
	b _0205EBC4
_0205EBBE:
	mov r0, r5
	bl SaveGame__SetPlayerName
_0205EBC4:
	add sp, #0x5c
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void SaveGame__SaveSaveCallback_OnlineProfile(SaveGame *save, SaveBlockFlags blockFlags)
{
    if ((blockFlags & SAVE_BLOCK_FLAG_ONLINE_PROFILE) != 0 && DWC_CheckHasProfile(&save->onlineProfile.userData))
    {
        if (DWC_CheckDirtyFlag(&save->onlineProfile.userData))
            DWC_ClearDirtyFlag(&save->onlineProfile.userData);
    }
}

void SaveGame__SaveLoadCallback_Unknown(SaveGame *save)
{
	UNUSED(save);
    // Nothin'
}

NONMATCH_FUNC size_t SaveGame__GetPlayerNameLength(SaveBlockSystem *work)
{
    // https://decomp.me/scratch/xIBYe -> 80%
#ifdef NON_MATCHING
    size_t len = 0;
    while (len < SAVEGAME_MAX_NAME_LEN && work->saveName.text[len] != 0)
    {
        len++;
    }

    return len;
#else
    // clang-format off
	mov r2, #0
	b _0205EC16
_0205EC10:
	add r2, r2, #1
	cmp r2, #8
	bhs _0205EC1E
_0205EC16:
	lsl r1, r2, #1
	ldrh r1, [r0, r1]
	cmp r1, #0
	bne _0205EC10
_0205EC1E:
	mov r0, r2
	bx lr

// clang-format on
#endif
}

void SaveGame__SetPlayerName(SavePlayerName *name, char16 *text, size_t len)
{
    MI_CpuClear16(name, sizeof(SavePlayerName));

    for (u16 c = 0; c < len && c < SAVEGAME_MAX_NAME_LEN; c++)
    {
        name->text[c] = text[c];
    }
}

s32 SaveGame__GetIslandProgress(SaveGameProgress *progress, s32 id)
{
    return (progress->islandProgress[id >> 2] >> ((u8)(id << 6) / 32)) & 3;
}

NONMATCH_FUNC void SaveGame__SetIslandProgress(SaveGameProgress *progress, s32 id, u8 state)
{
#ifdef NON_MATCHING
    u32 shift = (2 * id) & 7;
    progress->islandProgress[id >> 2] &= ~(3 << shift);
    progress->islandProgress[id >> 2] |= (state << shift);
#else
    // clang-format off
	push {r4, r5}
	lsl r3, r1, #0x1e
	lsr r4, r3, #0x1d
	add r3, r0, #7
	asr r0, r1, #2
	mov r1, #3
	lsl r1, r4
	ldrb r5, [r3, r0]
	mvn r1, r1
	and r1, r5
	strb r1, [r3, r0]
	mov r1, r2
	ldrb r5, [r3, r0]
	lsl r1, r4
	orr r1, r5
	strb r1, [r3, r0]
	pop {r4, r5}
	bx lr

// clang-format on
#endif
}

void SaveGame__GiveRings(SaveBlockStage *work, s32 amount)
{
    work->ringCount += amount;

    if (work->ringCount > SAVEGAME_RING_MAX)
        work->ringCount = SAVEGAME_RING_MAX;
}

BOOL SaveGame__HasChaosEmerald(SaveBlockChart *work, u8 id)
{
    return SeaMapManager__GetSaveFlag_(work->flags, id + 57);
}

void SaveGame__SetChaosEmeraldCollected(SaveBlockChart *work, u8 id)
{
    return SeaMapManager__SetSaveFlag_(work->flags, id + 57, TRUE);
}

u32 SaveGame__GetChaosEmeraldCount(SaveBlockChart *work)
{
    u8 i;
    u8 count = 0;

    for (i = 0; i < SAVEGAME_EMERALD_COUNT; i++)
    {
        if (SaveGame__HasChaosEmerald(work, i))
            count++;
    }

    return count;
}

NONMATCH_FUNC BOOL SaveGame__HasSolEmerald(SaveBlockStage *work, u8 id)
{
#ifdef NON_MATCHING
    return ((saveGame.stage.missionState[missionForSolEmerald[id] / 4] >> ((missionForSolEmerald[id] % 4) << 1)) & 3) >= MISSION_STATE_COMPLETED;
#else
    // clang-format off
	push {r3, r4}
	ldr r2, =missionForSolEmerald
	ldrb r4, [r2, r1]
	lsr r1, r4, #2
	add r0, r0, r1
	ldrb r3, [r0, #0xc]
	lsr r2, r4, #0x1f
	lsl r1, r4, #0x1e
	sub r1, r1, r2
	mov r0, #0x1e
	ror r1, r0
	add r0, r2, r1
	lsl r0, r0, #1
	mov r1, r3
	asr r1, r0
	mov r0, #3
	and r0, r1
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	cmp r0, #2
	blo _0205ED20
	mov r0, #1
	pop {r3, r4}
	bx lr
_0205ED20:
	mov r0, #0
	pop {r3, r4}
	bx lr

// clang-format on
#endif
}

u32 SaveGame__GetSolEmeraldCount(SaveBlockStage *work)
{
    u8 i;
    u8 count = 0;

    for (i = 0; i < SAVEGAME_EMERALD_COUNT; i++)
    {
        if (SaveGame__HasSolEmerald(work, i))
            count++;
    }

    return count;
}

NONMATCH_FUNC void SaveGame__SetSolEmeraldCollected(SaveBlockStage *work, u8 id)
{
#ifdef NON_MATCHING
    u32 shift = (missionForSolEmerald[id] % 4) << 1;
    if (((work->missionState[missionForSolEmerald[id] / 4] >> shift) & 3) < MISSION_STATE_COMPLETED)
    {
        work->missionState[missionForSolEmerald[id] / 4] &= ~(3 << shift);
        work->missionState[missionForSolEmerald[id] / 4] |= MISSION_STATE_COMPLETED << shift;
    }
#else
    // clang-format off
	push {r4, r5}
	ldr r2, =missionForSolEmerald
	add r0, #0xc
	ldrb r2, [r2, r1]
	mov r5, #3
	asr r1, r2, #1
	lsr r1, r1, #0x1e
	add r1, r2, r1
	lsr r4, r2, #0x1f
	lsl r2, r2, #0x1e
	asr r3, r1, #2
	sub r2, r2, r4
	mov r1, #0x1e
	ror r2, r1
	add r1, r4, r2
	ldrb r2, [r0, r3]
	lsl r1, r1, #1
	mov r4, r2
	asr r4, r1
	and r4, r5
	lsl r4, r4, #0x18
	lsr r4, r4, #0x18
	cmp r4, #2
	bhs _0205ED9C
	mov r4, r5
	lsl r4, r1
	mvn r4, r4
	and r2, r4
	strb r2, [r0, r3]
	mov r2, #2
	lsl r2, r1
	lsl r1, r2, #0x18
	ldrb r4, [r0, r3]
	lsr r1, r1, #0x18
	orr r1, r4
	strb r1, [r0, r3]
_0205ED9C:
	pop {r4, r5}
	bx lr

// clang-format on
#endif
}

BOOL SaveGame__HasMaterial(SaveBlockStage *work, u32 type)
{
    return work->materialCount[type] != SAVEGAME_MATERIAL_NONE;
}

NONMATCH_FUNC void SaveGame__GiveMaterial(SaveBlockStage *work, u32 type, s32 amount)
{
    // https://decomp.me/scratch/YZxL8 -> 99.35%
    // minor register issue near 'count'
#ifdef NON_MATCHING
    if (amount == 0)
        return;

    s32 count = SaveGame__HasMaterial(work, type) ? work->materialCount[type] : 0;

    work->materialCount[type] = MATH_MIN(count + amount, SAVEGAME_MATERIAL_MAX);
#else
    // clang-format off
	push {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r1
	mov r6, r2
	beq _0205EDE6
	bl SaveGame__HasMaterial
	cmp r0, #0
	beq _0205EDD4
	mov r0, #0x67
	add r1, r5, r4
	lsl r0, r0, #2
	ldrb r2, [r1, r0]
	b _0205EDD6
_0205EDD4:
	mov r2, #0
_0205EDD6:
	add r2, r2, r6
	cmp r2, #0x63
	ble _0205EDDE
	mov r2, #0x63
_0205EDDE:
	mov r0, #0x67
	add r1, r5, r4
	lsl r0, r0, #2
	strb r2, [r1, r0]
_0205EDE6:
	pop {r4, r5, r6, pc}

// clang-format on
#endif
}

void SaveGame__UseMaterial(SaveBlockStage *work, u32 type, s32 amount)
{
    work->materialCount[type] = MATH_MAX(work->materialCount[type] - amount, 0);
}

u32 SaveGame__GetMaterialCount(SaveBlockStage *work, u32 type)
{
    if (SaveGame__HasMaterial(work, type))
        return work->materialCount[type];

    return 0;
}

u32 SaveGame__GetTimeAttackRecord(SaveBlockTimeAttack *work, u32 character, u32 stage, u32 rank)
{
    switch (character)
    {
        case CHARACTER_SONIC:
            rank--;
            return work->records[CHARACTER_SONIC][stage].times[rank];

        // case CHARACTER_BLAZE:
        default:
            rank--;
            return work->records[CHARACTER_BLAZE][stage].times[rank];
    }
}

u8 SaveGame__AddTimeAttackRecord(SaveBlockTimeAttack *work, u8 character, s32 stage, u16 record)
{
    struct SaveTimeAttackRecord *leaderboard;
    if (character == CHARACTER_SONIC)
    {
        leaderboard = &work->records[CHARACTER_SONIC][stage];
    }
    else
    {
        leaderboard = &work->records[CHARACTER_BLAZE][stage];
    }

    s32 rank;
    for (rank = 0; rank < 5; rank++)
    {
        if (leaderboard->times[rank] == 0 || record < leaderboard->times[rank])
        {
            for (s32 r = 3; r >= rank; r--)
            {
                leaderboard->times[r + 1] = leaderboard->times[r];
            }

            leaderboard->times[rank] = record;

            if (rank == 0)
            {
                if (character == CHARACTER_SONIC)
                {
                    if (work->records[CHARACTER_BLAZE][stage].times[0] == 0 || record < work->records[CHARACTER_BLAZE][stage].times[0])
                    {
                        SaveGame__UpdateTimeForRecord(work, stage);
                        work->recordBitfield[stage / 16] &= ~(1 << (stage % 16));
                    }
                }
                else
                {
                    if (work->records[CHARACTER_SONIC][stage].times[0] == 0 || record < work->records[CHARACTER_SONIC][stage].times[0])
                    {
                        SaveGame__UpdateTimeForRecord(work, stage);
                        work->recordBitfield[stage / 16] |= (1 << (stage % 16));
                    }
                }
            }

            return rank + 1;
        }
    }

    return 0;
}

void SaveGame__AddTimeAttackUnknown(SaveBlockTimeAttack *work, s32 stage, u32 trickBonus, u32 ringBonus)
{
    if (trickBonus > 0xFFFF)
        trickBonus = 0xFFFF;

    if (ringBonus > 127)
        ringBonus = 127;

    work->unknownBitfield[stage] = ((trickBonus / 2) & (0xFF << 7)) | ringBonus;
}

void SaveGame__DeleteOnlineProfile_KeepFriends(SaveGame *save)
{
    void *friendList  = HeapAllocHead(HEAP_SYSTEM, sizeof(save->onlineProfile.friendList));
    void *friendTimes = HeapAllocHead(HEAP_SYSTEM, sizeof(save->onlineProfile.friendTimes));
    void *friendNames = HeapAllocHead(HEAP_SYSTEM, sizeof(save->onlineProfile.friendNames));
    MI_CpuCopy8(save->onlineProfile.friendList, friendList, sizeof(save->onlineProfile.friendList));
    MI_CpuCopy8(save->onlineProfile.friendTimes, friendTimes, sizeof(save->onlineProfile.friendTimes));
    MI_CpuCopy8(save->onlineProfile.friendNames, friendNames, sizeof(save->onlineProfile.friendNames));

    SaveGame__ClearData(save, SAVE_BLOCK_FLAG_ONLINE_LEADERBOARDS | SAVE_BLOCK_FLAG_ONLINE_PROFILE);

    MI_CpuCopy8(friendList, save->onlineProfile.friendList, sizeof(save->onlineProfile.friendList));
    MI_CpuCopy8(friendTimes, save->onlineProfile.friendTimes, sizeof(save->onlineProfile.friendTimes));
    MI_CpuCopy8(friendNames, save->onlineProfile.friendNames, sizeof(save->onlineProfile.friendNames));
    HeapFree(HEAP_SYSTEM, friendNames);
    HeapFree(HEAP_SYSTEM, friendTimes);
    HeapFree(HEAP_SYSTEM, friendList);
}

#include <nitro/codereset.h>

BOOL SaveGame__IsValidFriend(u16 id)
{
    return DWC_IsValidFriendData(&saveGame.onlineProfile.friendList[id]);
}

u16 SaveGame__GetFriendCount(void)
{
    s32 i;
    u32 count = 0;

    for (i = 0; i < SAVEGAME_MAX_FRIEND_COUNT; i++)
    {
        if (SaveGame__IsValidFriend(i))
            count++;
    }

    return count;
}

void SaveGame__AddFriendViaKey(u64 friendKey)
{
    DWCFriendData friend;

    DWC_CreateFriendKeyToken(&friend, friendKey);
    SaveGame__AddFriend(&friend);
    SaveGame__SetNameToFriendKey(&saveGame.onlineProfile.friendNames[0], friendKey);
}

u16 SaveGame__FindFriendViaKey(u64 friendKey)
{
    DWCFriendData friend;

    DWC_CreateFriendKeyToken(&friend, friendKey);
    return SaveGame__GetFriendIndex(&friend);
}

void SaveGame__AddFriend(DWCFriendData *friend)
{
    s32 f;
    for (f = 0; f < SAVEGAME_MAX_FRIEND_COUNT; f++)
    {
        if (!SaveGame__IsValidFriend(f))
            break;
    }

    RenderCore_CPUCopy(friend, &saveGame.onlineProfile.friendList[f], sizeof(saveGame.onlineProfile.friendList[f]));
    SaveGame__MoveFriendToFront(f);
    MI_CpuClear16(&saveGame.onlineProfile.friendNames[0], sizeof(saveGame.onlineProfile.friendNames[0]));
}

u16 SaveGame__GetFriendIndex(DWCFriendData *friend)
{
    for (s32 f = 0; f < SAVEGAME_MAX_FRIEND_COUNT; f++)
    {
        if (SaveGame__IsValidFriend(f) && DWC_IsEqualFriendData(friend, &saveGame.onlineProfile.friendList[f]))
            return f;
    }

    return 0xFFFF;
}

void SaveGame__DeleteFriend(s32 id)
{
    DWC_DeleteBuddyFriendData(&saveGame.onlineProfile.friendList[id]);
    SaveGame__RefreshFriendList();
}

NONMATCH_FUNC void SaveGame__MoveFriendToFront(u16 id)
{
    // https://decomp.me/scratch/chGlr -> 65.57%
#ifdef NON_MATCHING
    DWCFriendData friendData;
    SaveRecordDate friendTime;
    SavePlayerName friendName;

    RenderCore_CPUCopy(&saveGame.onlineProfile.friendList[id], &friendData, sizeof(saveGame.onlineProfile.friendList[id]));
    RenderCore_CPUCopy(&saveGame.onlineProfile.friendTimes[id], &friendTime, sizeof(saveGame.onlineProfile.friendTimes[id]));
    RenderCore_CPUCopy(&saveGame.onlineProfile.friendNames[id], &friendName, sizeof(saveGame.onlineProfile.friendNames[id]));

    RTCDate date;
    RTC_GetDate(&date);
    friendTime.year  = date.year;
    friendTime.month = date.month;
    friendTime.day   = date.day;

    for (s32 f = id - 1; f >= 0; f--)
    {
        RenderCore_CPUCopy(&saveGame.onlineProfile.friendList[f], &saveGame.onlineProfile.friendList[f + 1], sizeof(saveGame.onlineProfile.friendList[f]));
        RenderCore_CPUCopy(&saveGame.onlineProfile.friendTimes[f], &saveGame.onlineProfile.friendTimes[f + 1], sizeof(saveGame.onlineProfile.friendTimes[f]));
        RenderCore_CPUCopy(&saveGame.onlineProfile.friendNames[f], &saveGame.onlineProfile.friendNames[f + 1], sizeof(saveGame.onlineProfile.friendNames[f]));
    }

    RenderCore_CPUCopy(&friendData, &saveGame.onlineProfile.friendList[0], sizeof(saveGame.onlineProfile.friendList[0]));
    RenderCore_CPUCopy(&friendTime, &saveGame.onlineProfile.friendTimes[0], sizeof(saveGame.onlineProfile.friendTimes[0]));
    RenderCore_CPUCopy(&friendName, &saveGame.onlineProfile.friendNames[0], sizeof(saveGame.onlineProfile.friendNames[0]));
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x30
	ldr r1, =saveGame+0x00000E90
	mov r4, r0
	mov r2, #0xc
	mla r0, r4, r2, r1
	add r1, sp, #0x24
	bl RenderCore_CPUCopy
	ldr r0, =saveGame+0x00000FF8
	add r1, sp, #0
	add r0, r0, r4, lsl #1
	mov r2, #2
	bl RenderCore_CPUCopy
	ldr r0, =saveGame+0x00001034
	add r1, sp, #0x14
	add r0, r0, r4, lsl #4
	mov r2, #0x10
	bl RenderCore_CPUCopy
	add r0, sp, #4
	bl RTC_GetDate
	ldr r0, [sp, #4]
	ldrh r5, [sp]
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	bic r5, r5, #0x7f
	and r1, r3, #0x7f
	orr r1, r5, r1
	strh r1, [sp]
	mov r8, #0xc
	sub r10, r4, #1
	ldrh r3, [sp]
	mov r1, r2, lsl #0x1c
	mov r0, r0, lsl #0x1b
	bic r2, r3, #0x780
	orr r1, r2, r1, lsr #21
	strh r1, [sp]
	ldrh r1, [sp]
	ldr r9, =saveGame+0x00000E90
	ldr r7, =saveGame+0x00000FF8
	bic r1, r1, #0xf800
	orr r0, r1, r0, lsr #16
	strh r0, [sp]
	mov r11, #2
	ldr r6, =saveGame+0x00001034
	mov r4, r8
	mov r5, r8
	b _0205F2C0
_0205F280:
	add r2, r10, #1
	mla r1, r2, r5, r9
	mla r0, r10, r4, r9
	mov r2, r8
	bl RenderCore_CPUCopy
	add r0, r10, #1
	add r1, r7, r0, lsl #1
	mov r2, r11
	add r0, r7, r10, lsl #1
	bl RenderCore_CPUCopy
	add r1, r10, #1
	add r0, r6, r10, lsl #4
	add r1, r6, r1, lsl #4
	mov r2, #0x10
	bl RenderCore_CPUCopy
	sub r10, r10, #1
_0205F2C0:
	cmp r10, #0
	bge _0205F280
	ldr r1, =saveGame+0x00000E90
	add r0, sp, #0x24
	mov r2, #0xc
	bl RenderCore_CPUCopy
	ldr r1, =saveGame+0x00000FF8
	add r0, sp, #0
	mov r2, #2
	bl RenderCore_CPUCopy
	ldr r1, =saveGame+0x00001034
	add r0, sp, #0x14
	mov r2, #0x10
	bl RenderCore_CPUCopy
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

u16 SaveGame__GetFriendAddedYear(u16 id)
{
    return saveGame.onlineProfile.friendTimes[id].year;
}

u16 SaveGame__GetFriendAddedMonth(u16 id)
{
    return saveGame.onlineProfile.friendTimes[id].month;
}

u16 SaveGame__GetFriendAddedDay(u16 id)
{
    return saveGame.onlineProfile.friendTimes[id].day;
}

BOOL SaveGame__IsFriendNameAString(u16 id)
{
    return SaveGame__GetFriendKeyFromName_Internal(&saveGame.onlineProfile.friendNames[id]) == 0;
}

u64 SaveGame__GetFriendKeyFromName(u16 id)
{
    return SaveGame__GetFriendKeyFromName_Internal(&saveGame.onlineProfile.friendNames[id]);
}

SavePlayerName *SaveGame__GetFriendName(u16 id)
{
    return &saveGame.onlineProfile.friendNames[id];
}

void SaveGame__SetFrontFriendName(SavePlayerName *name)
{
    SaveGame__SetFriendName(0, name);
}

BOOL SaveGame__RefreshFriendList(void)
{
    s32 f;

    DWCFriendData *newFriendList   = saveGame.onlineProfile.friendList;
    SaveRecordDate *newFriendTimes = saveGame.onlineProfile.friendTimes;
    SavePlayerName *newFriendKeys  = saveGame.onlineProfile.friendNames;

    s32 friendCount = 0;
    BOOL updated    = FALSE;

    DWCFriendData *oldFriendList   = saveGame.onlineProfile.friendList;
    SaveRecordDate *oldFriendTimes = saveGame.onlineProfile.friendTimes;
    SavePlayerName *oldFriendKeys  = saveGame.onlineProfile.friendNames;
    for (f = 0; f < SAVEGAME_MAX_FRIEND_COUNT; f++)
    {
        if (SaveGame__IsValidFriend(f))
        {
            if (friendCount != f)
            {
                MI_CpuCopy8(&oldFriendList[f], &newFriendList[friendCount], sizeof(oldFriendList[f]));
                MI_CpuCopy8(&oldFriendTimes[f], &newFriendTimes[friendCount], sizeof(oldFriendTimes[f]));
                MI_CpuCopy8(&oldFriendKeys[f], &newFriendKeys[friendCount], sizeof(oldFriendKeys[f]));
                updated = TRUE;
            }
            friendCount++;
        }
    }

    for (f = friendCount; f < SAVEGAME_MAX_FRIEND_COUNT; f++)
    {
        MI_CpuClear8(&oldFriendList[f], sizeof(saveGame.onlineProfile.friendList[f]));
        MI_CpuClear8(&oldFriendTimes[f], sizeof(saveGame.onlineProfile.friendTimes[f]));
        MI_CpuClear8(&oldFriendKeys[f], sizeof(saveGame.onlineProfile.friendNames[f]));
    }

    return updated;
}

void SaveGame__DeleteFriendCallback(int deletedIndex, int srcIndex, void *param)
{
	UNUSED(param);

    SavePlayerName *friendNames = saveGame.onlineProfile.friendNames;

    if (SaveGame__GetFriendKeyFromName_Internal(&saveGame.onlineProfile.friendNames[srcIndex]) == 0)
        return; // not a valid friend key

    if (SaveGame__GetFriendKeyFromName_Internal(&saveGame.onlineProfile.friendNames[deletedIndex]) == 0)
        MI_CpuCopy8(&friendNames[deletedIndex], &friendNames[srcIndex], sizeof(friendNames[srcIndex]));
}

void SaveGame__SetNameToFriendKey(SavePlayerName *name, u64 friendKey)
{
    name->text[0] = 0;
    name->text[1] = 0xFFFF;

    name->text[2] = friendKey & 0xFFFF;
    name->text[3] = (friendKey >> 16) & 0xFFFF;
    name->text[4] = (friendKey >> 32) & 0xFFFF;
    name->text[5] = 0xFFFF & (friendKey >> 48);
}

NONMATCH_FUNC u64 SaveGame__GetFriendKeyFromName_Internal(SavePlayerName *name)
{
	// https://decomp.me/scratch/jaq8d -> 81.39%
#ifdef NON_MATCHING
    if (name->text[0] != 0 || name->text[1] != 0xFFFF)
        return 0; // this is a string, not a numeric key

    u64 friendKey = ((u64)name->text[2] << 0) | ((u64)name->text[3] << 16) | ((u64)name->text[4] << 32) | ((u64)name->text[5] << 48);

    if (!DWC_CheckFriendKey(&saveGame.onlineProfile.userData, friendKey))
        friendKey = 0; // this key is not valid

    return friendKey;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldrh r1, [r0, #0]
	cmp r1, #0
	ldreqh r2, [r0, #2]
	ldreq r1, =0x0000FFFF
	cmpeq r2, r1
	movne r0, #0
	movne r1, r0
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r4, [r0, #4]
	ldrh r2, [r0, #6]
	mov r1, #0
	mov r3, r1, lsl #0x10
	mov ip, r1
	orr r1, r4, #0
	orr r1, r1, r2, lsl #16
	orr r4, r1, #0
	ldrh r1, [r0, #8]
	ldrh r0, [r0, #0xa]
	orr ip, ip, #0
	orr r3, r3, r2, lsr #16
	orr r2, ip, r3
	orr r1, r2, r1
	orr r5, r1, r0, lsl #16
	ldr r0, =saveGame+0x00000E50
	mov r1, r4
	mov r2, r5
	bl DWC_CheckFriendKey
	cmp r0, #0
	moveq r4, #0
	moveq r5, r4
	mov r0, r4
	mov r1, r5
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void SaveGame__SetFriendName(u16 id, SavePlayerName *name)
{
    s32 i = 0;

    SavePlayerName *friendName = &saveGame.onlineProfile.friendNames[id];

    for (; i < SAVEGAME_MAX_NAME_LEN; i++)
    {
        if (name->text[i] == 0)
            break;

        friendName->text[i] = name->text[i];
    }

    for (; i < SAVEGAME_MAX_NAME_LEN; i++)
    {
        friendName->text[i] = 0;
    }
}

u16 SaveGame__AddWirelessRaceRecord(SaveVsRecordType matchResult)
{
    u16 *record = &saveGame.vsRecords.wireless.race[matchResult];
    if (*record < SAVEGAME_VSRECORD_MAX)
        *record += 1;

    return *record;
}

u16 SaveGame__AddWirelessRingBattleRecord(SaveVsRecordType matchResult)
{
    u16 *record = &saveGame.vsRecords.wireless.ringBattle[matchResult];
    if (*record < SAVEGAME_VSRECORD_MAX)
        *record += 1;

    return *record;
}

u16 SaveGame__AddNetworkRaceRecord(SaveVsRecordType matchResult)
{
    u16 *record = &saveGame.vsRecords.network.race[matchResult];
    if (*record < SAVEGAME_VSRECORD_MAX)
        *record += 1;

    return *record;
}

u16 SaveGame__AddNetworkRingBattleRecord(SaveVsRecordType matchResult)
{
    u16 *record = &saveGame.vsRecords.network.ringBattle[matchResult];
    if (*record < SAVEGAME_VSRECORD_MAX)
        *record += 1;

    return *record;
}

u16 SaveGame__GetWirelessRaceRecord(SaveVsRecordType type)
{
    return saveGame.vsRecords.wireless.race[type];
}

u16 SaveGame__GetWirelessRingBattleRecord(SaveVsRecordType type)
{
    return saveGame.vsRecords.wireless.ringBattle[type];
}

u16 SaveGame__GetNetworkRaceRecord(SaveVsRecordType type)
{
    return saveGame.vsRecords.network.race[type];
}

u16 SaveGame__GetNetworkRingBattleRecord(SaveVsRecordType type)
{
    return saveGame.vsRecords.network.ringBattle[type];
}

u32 SaveGame__GetOnlineScore_(void)
{
    return saveGame.onlineProfile.score;
}

NONMATCH_FUNC void SaveGame__UpdateTimeForRecord(SaveBlockTimeAttack *work, u32 stage)
{
    // https://decomp.me/scratch/A5g1Z -> 97.17%
#ifdef NON_MATCHING
    RTCDate date;
    RTCTime time;
    RTC_GetDateTime(&date, &time);

    work->recordDates[stage].date.year  = date.year;
    work->recordDates[stage].date.month = date.month;
    work->recordDates[stage].date.day   = date.day;

    work->recordDates[stage].time.hour   = time.hour;
    work->recordDates[stage].time.minute = time.minute;
#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	mov r5, r1
	add r0, sp, #0xc
	add r1, sp, #0
	bl RTC_GetDateTime
	ldr r2, [sp, #0xc]
	add r0, r4, #0x398
	mov r1, r5, lsl #2
	ldrh r3, [r0, r1]
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	bic r3, r3, #0x7f
	and r2, r2, #0x7f
	orr r2, r3, r2
	strh r2, [r0, r1]
	ldr r2, [sp, #0x10]
	ldrh ip, [r0, r1]
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	add r2, r4, #0x9a
	bic r4, ip, #0x780
	mov r3, r3, lsl #0x1c
	orr r3, r4, r3, lsr #21
	strh r3, [r0, r1]
	ldr r3, [sp, #0x14]
	ldrh r4, [r0, r1]
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	bic r4, r4, #0xf800
	mov r3, r3, lsl #0x1b
	orr r3, r4, r3, lsr #16
	strh r3, [r0, r1]
	add r0, r2, #0x300
	ldr r2, [sp]
	ldrh r3, [r0, r1]
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	bic r3, r3, #0x1f
	and r2, r2, #0x1f
	orr r2, r3, r2
	strh r2, [r0, r1]
	ldr r2, [sp, #4]
	ldrh r3, [r0, r1]
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	bic r3, r3, #0x7e0
	mov r2, r2, lsl #0x1a
	orr r2, r3, r2, lsr #21
	strh r2, [r0, r1]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

s64 SaveGame__GetTimeFromTimeAttackRecord(u32 stage)
{
    RTCDate date;
    date.year  = saveGame.timeAttack.recordDates[stage].date.year;
    date.month = saveGame.timeAttack.recordDates[stage].date.month;
    date.day   = saveGame.timeAttack.recordDates[stage].date.day;
    date.week  = RTC_WEEK_SUNDAY;

    RTCTime time;
    time.hour   = saveGame.timeAttack.recordDates[stage].time.hour;
    time.minute = saveGame.timeAttack.recordDates[stage].time.minute;
    time.second = 0;

    return RTC_ConvertDateTimeToSecond(&date, &time);
}

NONMATCH_FUNC void SaveGame__Block4__GetLastUsedCharacter(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r5, =saveGame+0x00000898
	mov r4, r0
	mov r0, r5
	mov r2, r4
	mov r1, #0
	mov r3, #1
	bl SaveGame__GetTimeAttackRecord
	mov r1, #1
	mov r6, r0
	mov r0, r5
	mov r2, r4
	mov r3, r1
	bl SaveGame__GetTimeAttackRecord
	cmp r6, #0
	cmpne r0, #0
	beq _0205F948
	mov r0, r4, asr #3
	add r0, r4, r0, lsr #28
	mov r0, r0, asr #4
	add r0, r5, r0, lsl #1
	add r0, r0, #0x400
	mov r2, r4, lsr #0x1f
	ldrh r3, [r0, #0x50]
	rsb r1, r2, r4, lsl #28
	add r0, r2, r1, ror #28
	mov r0, r3, asr r0
	and r0, r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0205F948:
	cmp r6, #0
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	cmp r0, #0
	movne r0, #1
	ldreq r0, =0x0000FFFF
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

u32 SaveGame__SetVikingCupJetskiRecord(u32 actID, u32 time)
{
    if (time == 0)
        return 0xFFFF;

    return SaveGame__SetVikingCupTimeRecord(&saveGame.vikingCup.jetski[actID], time);
}

u32 SaveGame__SetVikingCupSailboatRecord(u32 actID, u32 score)
{
    if (score == 0)
        return 0xFFFF;

    return SaveGame__SetVikingCupScoreRecord(&saveGame.vikingCup.sailboat[actID], score);
}

u32 SaveGame__SetVikingCupHovercraftRecord(u32 actID, u32 score)
{
    if (score == 0)
        return 0xFFFF;

    return SaveGame__SetVikingCupScoreRecord(&saveGame.vikingCup.hovercraft[actID], score);
}

u32 SaveGame__SetVikingCupSubmarineRecord(u32 actID, u32 score)
{
    if (score == 0)
        return 0xFFFF;

    return SaveGame__SetVikingCupScoreRecord(&saveGame.vikingCup.submarine[actID], score);
}

u32 SaveGame__GetVikingCupJetskiRecord(u32 actID, u32 rank)
{
    return saveGame.vikingCup.jetski[actID].records[rank];
}

u32 SaveGame__GetVikingCupSailboatRecord(u32 actID, u32 rank)
{
    return saveGame.vikingCup.sailboat[actID].records[rank];
}

u32 SaveGame__GetVikingCupHovercraftRecord(u32 actID, u32 rank)
{
    return saveGame.vikingCup.hovercraft[actID].records[rank];
}

u32 SaveGame__GetVikingCupSubmarineRecord(u32 actID, u32 rank)
{
    return saveGame.vikingCup.submarine[actID].records[rank];
}

void SaveGame__SaveLeaderboardRankOrder(s32 stage, u32 order)
{
    saveGame.leaderboards.entries[stage].rankOrder = order;
}

NONMATCH_FUNC void SaveGame__SaveLeaderboardRank_Top(s32 stage, u16 rank, char16 *name, size_t nameLength, u16 time, s32 flag)
{
    // when below func is matched, this one should match using the same changes!
#ifdef NON_MATCHING
    struct SaveOnlineLeaderboardsStageEntry *leaderboard = &saveGame.leaderboards.entries[stage];

    if (time == 0)
    {
        MI_CpuClear8(&leaderboard->top3[rank].name, sizeof(leaderboard->top3[rank].name));
        leaderboard->top3[rank].time = 0;
        return;
    }

    if (name == NULL)
    {
        MI_CpuClear8(&leaderboard->top3[rank].name, sizeof(leaderboard->top3[rank].name));
    }
    else
    {
        if (nameLength == 0)
        {
            leaderboard->top3[rank].name.text[0] = '0';
            leaderboard->top3[rank].name.text[1] = 0;
            MI_CpuClear8(&leaderboard->top3[rank].name.text[2], (SAVEGAME_MAX_NAME_LEN - 2) * sizeof(char16));
        }
        else
        {
            SaveGame__SetPlayerName(&leaderboard->top3[rank].name, name, nameLength);
        }
    }

    leaderboard->top3[rank].time = time;

    if (time != 0)
        time = 1;

    switch (rank)
    {
        case 0:
            leaderboard->topRankFlag1 = time;
            break;

        case 1:
            leaderboard->topRankFlag2 = time;
            break;

        case 2:
            leaderboard->topRankFlag3 = time;
            break;
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r6, =saveGame+0x00001218
	mov r4, #0x98
	mla r4, r0, r4, r6
	ldrh r5, [sp, #0x10]
	mov r6, r1
	mov r0, #0x12
	cmp r5, #0
	ldr r5, [sp, #0x14]
	bne _0205FAF4
	add r1, r4, #4
	mla r0, r6, r0, r1
	mov r1, #0
	mov r2, #0x10
	bl MI_CpuFill8
	mov r0, #0x12
	mla r0, r6, r0, r4
	mov r1, #0
	strh r1, [r0, #0x14]
	ldmia sp!, {r4, r5, r6, pc}
_0205FAF4:
	cmp r2, #0
	bne _0205FB14
	add r1, r4, #4
	mla r0, r6, r0, r1
	mov r1, #0
	mov r2, #0x10
	bl MI_CpuFill8
	b _0205FB5C
_0205FB14:
	cmp r3, #0
	bne _0205FB48
	mul r2, r6, r0
	add r0, r4, #8
	add r3, r4, r2
	mov r1, #0x30
	strh r1, [r3, #4]
	mov r1, #0
	add r0, r0, r2
	mov r2, #0xc
	strh r1, [r3, #6]
	bl MI_CpuFill8
	b _0205FB5C
_0205FB48:
	add r1, r4, #4
	mla r0, r6, r0, r1
	mov r1, r2
	mov r2, r3
	bl SaveGame__SetPlayerName
_0205FB5C:
	mov r0, #0x12
	mla r0, r6, r0, r4
	ldrh r1, [sp, #0x10]
	cmp r5, #0
	movne r5, #1
	strh r1, [r0, #0x14]
	cmp r6, #0
	beq _0205FB90
	cmp r6, #1
	beq _0205FBA8
	cmp r6, #2
	beq _0205FBC0
	ldmia sp!, {r4, r5, r6, pc}
_0205FB90:
	ldr r1, [r4, #0]
	mov r0, r5, lsl #0x1f
	bic r1, r1, #0x1000000
	orr r0, r1, r0, lsr #7
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}
_0205FBA8:
	ldr r1, [r4, #0]
	mov r0, r5, lsl #0x1f
	bic r1, r1, #0x2000000
	orr r0, r1, r0, lsr #6
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}
_0205FBC0:
	ldr r1, [r4, #0]
	mov r0, r5, lsl #0x1f
	bic r1, r1, #0x4000000
	orr r0, r1, r0, lsr #5
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SaveGame__SaveLeaderboardRank_Near(s32 stage, u16 rank, char16 *name, size_t nameLength, u16 time, s32 flag)
{
    // https://decomp.me/scratch/FU8lZ -> 68.72%
#ifdef NON_MATCHING
    struct SaveOnlineLeaderboardsStageEntry *leaderboard = &saveGame.leaderboards.entries[stage];

    if (time == 0)
    {
        MI_CpuClear8(&leaderboard->yourRanking[rank].name, sizeof(leaderboard->yourRanking[rank].name));
        leaderboard->yourRanking[rank].time = 0;
        return;
    }

    if (name == NULL)
    {
        MI_CpuClear8(&leaderboard->yourRanking[rank].name, sizeof(leaderboard->yourRanking[rank].name));
    }
    else
    {
        if (nameLength == 0)
        {
            leaderboard->yourRanking[rank].name.text[0] = '0';
            leaderboard->yourRanking[rank].name.text[1] = 0;
            MI_CpuClear8(&leaderboard->yourRanking[rank].name.text[2], (SAVEGAME_MAX_NAME_LEN - 2) * sizeof(char16));
        }
        else
        {
            SaveGame__SetPlayerName(&leaderboard->yourRanking[rank].name, name, nameLength);
        }
    }

    leaderboard->yourRanking[rank].time = time;

    if (time != 0)
        time = 1;

    switch (rank)
    {
        case 0:
            leaderboard->nearRankFlag1 = time;
            break;

        case 1:
            leaderboard->nearRankFlag2 = time;
            break;

        case 2:
            leaderboard->nearRankFlag3 = time;
            break;

        case 3:
            leaderboard->nearRankFlag4 = time;
            break;

        case 4:
            leaderboard->nearRankFlag5 = time;
            break;
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r6, =saveGame+0x00001218
	mov r4, #0x98
	mla r4, r0, r4, r6
	ldrh r5, [sp, #0x10]
	mov r6, r1
	mov r0, #0x12
	cmp r5, #0
	ldr r5, [sp, #0x14]
	bne _0205FC2C
	add r1, r4, #0x3a
	mla r0, r6, r0, r1
	mov r1, #0
	mov r2, #0x10
	bl MI_CpuFill8
	mov r0, #0x12
	mla r0, r6, r0, r4
	mov r1, #0
	strh r1, [r0, #0x4a]
	ldmia sp!, {r4, r5, r6, pc}
_0205FC2C:
	cmp r2, #0
	bne _0205FC4C
	add r1, r4, #0x3a
	mla r0, r6, r0, r1
	mov r1, #0
	mov r2, #0x10
	bl MI_CpuFill8
	b _0205FC94
_0205FC4C:
	cmp r3, #0
	bne _0205FC80
	mul r2, r6, r0
	add r0, r4, #0x3e
	add r3, r4, r2
	mov r1, #0x30
	strh r1, [r3, #0x3a]
	mov r1, #0
	add r0, r0, r2
	mov r2, #0xc
	strh r1, [r3, #0x3c]
	bl MI_CpuFill8
	b _0205FC94
_0205FC80:
	add r1, r4, #0x3a
	mla r0, r6, r0, r1
	mov r1, r2
	mov r2, r3
	bl SaveGame__SetPlayerName
_0205FC94:
	mov r0, #0x12
	mla r0, r6, r0, r4
	ldrh r1, [sp, #0x10]
	cmp r5, #0
	movne r5, #1
	strh r1, [r0, #0x4a]
	cmp r6, #4
	addls pc, pc, r6, lsl #2
	ldmia sp!, {r4, r5, r6, pc}
_0205FCB8: // jump table
	b _0205FCCC // case 0
	b _0205FCE4 // case 1
	b _0205FCFC // case 2
	b _0205FD14 // case 3
	b _0205FD2C // case 4
_0205FCCC:
	ldr r1, [r4, #0]
	mov r0, r5, lsl #0x1f
	bic r1, r1, #0x8000000
	orr r0, r1, r0, lsr #4
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}
_0205FCE4:
	ldr r1, [r4, #0]
	mov r0, r5, lsl #0x1f
	bic r1, r1, #0x10000000
	orr r0, r1, r0, lsr #3
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}
_0205FCFC:
	ldr r1, [r4, #0]
	mov r0, r5, lsl #0x1f
	bic r1, r1, #0x20000000
	orr r0, r1, r0, lsr #2
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}
_0205FD14:
	ldr r1, [r4, #0]
	mov r0, r5, lsl #0x1f
	bic r1, r1, #0x40000000
	orr r0, r1, r0, lsr #1
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}
_0205FD2C:
	ldr r0, [r4, #0]
	bic r0, r0, #0x80000000
	orr r0, r0, r5, lsl #31
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SaveGame__SetLeaderboardLastUpdatedTime(u32 stage)
{
    // https://decomp.me/scratch/OeS12 -> 93.70%
#ifdef NON_MATCHING
    RTCDate date;
    RTCTime time;
    RTC_GetDateTime(&date, &time);

    saveGame.leaderboards.entries[stage].lastUpdatedDate.year  = date.year;
    saveGame.leaderboards.entries[stage].lastUpdatedDate.month = date.month;
    saveGame.leaderboards.entries[stage].lastUpdatedDate.day   = date.day;

    saveGame.leaderboards.entries[stage].lastUpdatedTime.hour   = time.hour;
    saveGame.leaderboards.entries[stage].lastUpdatedTime.minute = time.minute;
#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	add r0, sp, #0xc
	add r1, sp, #0
	bl RTC_GetDateTime
	mov r0, #0x98
	ldr r2, [sp, #0xc]
	mul r0, r4, r0
	ldr r1, =saveGame+0x000012AC
	mov r2, r2, lsl #0x10
	mov r4, r2, lsr #0x10
	ldr r2, [sp, #0x10]
	ldrh r5, [r1, r0]
	mov r2, r2, lsl #0x10
	ldr r3, [sp, #0x14]
	mov lr, r2, lsr #0x10
	mov r2, r3, lsl #0x10
	mov ip, r2, lsr #0x10
	bic r3, r5, #0x7f
	and r2, r4, #0x7f
	orr r2, r3, r2
	strh r2, [r1, r0]
	ldrh r4, [r1, r0]
	ldr r2, [sp]
	mov r3, lr, lsl #0x1c
	bic r4, r4, #0x780
	orr r3, r4, r3, lsr #21
	strh r3, [r1, r0]
	ldrh lr, [r1, r0]
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	ldr r2, [sp, #4]
	bic lr, lr, #0xf800
	mov ip, ip, lsl #0x1b
	orr ip, lr, ip, lsr #16
	mov r2, r2, lsl #0x10
	ldr r4, =saveGame+0x000012AE
	strh ip, [r1, r0]
	mov r2, r2, lsr #0x10
	ldrh ip, [r4, r0]
	mov r1, r2, lsl #0x1a
	and r3, r3, #0x1f
	bic r2, ip, #0x1f
	orr r2, r2, r3
	strh r2, [r4, r0]
	ldrh r2, [r4, r0]
	bic r2, r2, #0x7e0
	orr r1, r2, r1, lsr #21
	strh r1, [r4, r0]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

BOOL SaveGame__CheckLeaderboardHasRecords(u32 stage)
{
    return SaveGame__GetLeaderboardsTime_Top(stage, 0) != 0;
}

u32 SaveGame__GetLeaderboardRankOrder(u32 stage)
{
    return saveGame.leaderboards.entries[stage].rankOrder;
}

SaveOnlineLeaderboardsRankEntry *SaveGame__GetLeaderboardsEntry_Top(s32 stage, u16 rank)
{
    return &saveGame.leaderboards.entries[stage].top3[rank];
}

u16 SaveGame__GetLeaderboardsNameLen_Top(s32 stage, u16 rank)
{
    SaveOnlineLeaderboardsRankEntry *entry = SaveGame__GetLeaderboardsEntry_Top(stage, rank);

    s32 i;
    for (i = 0; i < SAVEGAME_MAX_NAME_LEN; i++)
    {
        if (entry->name.text[i] == 0)
        {
            break;
        }
    }

    return i;
}

u16 SaveGame__GetLeaderboardsTime_Top(s32 stage, u16 rank)
{
    return saveGame.leaderboards.entries[stage].top3[rank].time;
}

u16 SaveGame__GetLeaderboardRankFlag_Top(s32 stage, u16 rank)
{
    switch (rank)
    {
        case 0:
            return saveGame.leaderboards.entries[stage].topRankFlag1;

        case 1:
            return saveGame.leaderboards.entries[stage].topRankFlag2;

        case 2:
            return saveGame.leaderboards.entries[stage].topRankFlag3;
    }

    return 0;
}

SaveOnlineLeaderboardsRankEntry *SaveGame__GetLeaderboardsEntry_Near(s32 stage, u16 rank)
{
    return &saveGame.leaderboards.entries[stage].yourRanking[rank];
}

u16 SaveGame__GetLeaderboardsNameLen_Near(s32 stage, u16 rank)
{
    SaveOnlineLeaderboardsRankEntry *entry = SaveGame__GetLeaderboardsEntry_Near(stage, rank);

    s32 i;
    for (i = 0; i < SAVEGAME_MAX_NAME_LEN; i++)
    {
        if (entry->name.text[i] == 0)
        {
            break;
        }
    }

    return i;
}

u16 SaveGame__GetLeaderboardsTime_Near(s32 stage, u16 rank)
{
    return saveGame.leaderboards.entries[stage].yourRanking[rank].time;
}

u16 SaveGame__GetLeaderboardRankFlag_Near(s32 stage, u16 rank)
{
    switch (rank)
    {
        case 0:
            return saveGame.leaderboards.entries[stage].nearRankFlag1;

        case 1:
            return saveGame.leaderboards.entries[stage].nearRankFlag2;

        case 2:
            return saveGame.leaderboards.entries[stage].nearRankFlag3;

        case 3:
            return saveGame.leaderboards.entries[stage].nearRankFlag4;

        case 4:
            return saveGame.leaderboards.entries[stage].nearRankFlag5;
    }

    return 0;
}

s64 SaveGame__GetLeaderboardLastUpdatedTime(u32 stage)
{
    if (SaveGame__CheckLeaderboardHasRecords(stage) == FALSE)
    {
        return -1;
    }

    RTCDate date;
    date.year  = saveGame.leaderboards.entries[stage].lastUpdatedDate.year;
    date.month = saveGame.leaderboards.entries[stage].lastUpdatedDate.month;
    date.day   = saveGame.leaderboards.entries[stage].lastUpdatedDate.day;
    date.week  = RTC_WEEK_SUNDAY;

    RTCTime time;
    time.hour   = saveGame.leaderboards.entries[stage].lastUpdatedTime.hour;
    time.minute = saveGame.leaderboards.entries[stage].lastUpdatedTime.minute;
    time.second = 0;

    return RTC_ConvertDateTimeToSecond(&date, &time);
}

u32 SaveGame__GetOnlineScore(void)
{
    return SaveGame__GetOnlineScore_();
}

void SaveGame__UpdateOnlineScore(SaveVsRecordType matchResult, s32 opponentScore)
{
    s32 score = SaveGame__GetOnlineScore();
    s32 scoreChange;

    if (matchResult == SAVE_VSRECORD_DRAW)
        return; // no score change.

    s32 scoreDifference = opponentScore - score;
    if (scoreDifference >= 0)
    {
        // if opponent has the greater score...

        if (scoreDifference < 1000)
        {
            if (matchResult == SAVE_VSRECORD_WIN)
            {
                scoreChange = 100;
            }
            else
            {
                scoreChange = -20;
            }
        }
        else if (scoreDifference < 2000)
        {
            if (matchResult == SAVE_VSRECORD_WIN)
            {
                scoreChange = 120;
            }
            else
            {
                scoreChange = -15;
            }
        }
        else if (scoreDifference < 3000)
        {
            if (matchResult == SAVE_VSRECORD_WIN)
            {
                scoreChange = 150;
            }
            else
            {
                scoreChange = -10;
            }
        }
        else
        {
            if (matchResult == SAVE_VSRECORD_WIN)
            {
                scoreChange = 200;
            }
            else
            {
                scoreChange = -5;
            }
        }
    }
    else
    {
        // if player has the greater score...

        scoreDifference = -scoreDifference;
        if (scoreDifference < 1000)
        {
            if (matchResult == SAVE_VSRECORD_WIN)
            {
                scoreChange = 100;
            }
            else
            {
                scoreChange = -20;
            }
        }
        else if (scoreDifference < 2000)
        {
            if (matchResult == SAVE_VSRECORD_WIN)
            {
                scoreChange = 80;
            }
            else
            {
                scoreChange = -25;
            }
        }
        else if (scoreDifference < 3000)
        {
            if (matchResult == SAVE_VSRECORD_WIN)
            {
                scoreChange = 60;
            }
            else
            {
                scoreChange = -30;
            }
        }
        else
        {
            if (matchResult == SAVE_VSRECORD_WIN)
            {
                scoreChange = 40;
            }
            else
            {
                scoreChange = -40;
            }
        }
    }

    score += scoreChange;

    if (score < SAVEGAME_VS_SCORE_MIN)
        score = SAVEGAME_VS_SCORE_MIN;

    if (score > SAVEGAME_VS_SCORE_MAX)
        score = SAVEGAME_VS_SCORE_MAX;

    saveGame.onlineProfile.score = score;
}

u32 SaveGame__GetStageScore(u32 stageID)
{
    u32 difficulty = saveGame.stage.status.difficulty;
    if (!SaveGame__CheckStageAllowDifficulties(stageID))
        difficulty = DIFFICULTY_EASY;

    return saveGame.stage.stageRecords[difficulty][stageID].score;
}

u32 SaveGame__GetStageRank(u32 stageID)
{
    u32 difficulty = saveGame.stage.status.difficulty;
    if (!SaveGame__CheckStageAllowDifficulties(stageID))
        difficulty = DIFFICULTY_EASY;

    return saveGame.stage.stageRecords[difficulty][stageID].rank;
}

BOOL SaveGame__UpdateStageRecord(u32 stageID, u32 score, u32 rank)
{
    u32 difficulty     = saveGame.stage.status.difficulty;
    BOOL updatedRecord = FALSE;

    if (!SaveGame__CheckStageAllowDifficulties(stageID))
        difficulty = DIFFICULTY_EASY;

    struct SaveStageRecord *records = saveGame.stage.stageRecords[difficulty];
    if (score > records[stageID].score)
    {
        records[stageID].score = score;
        updatedRecord          = TRUE;
    }

    if (rank < records[stageID].rank)
    {
        records[stageID].rank = rank;
        updatedRecord         = TRUE;
    }

    return updatedRecord;
}

void SaveGame__SetLastPlayedVsMode(BOOL isVsRace)
{
    if (isVsRace)
    {
        saveGame.system.lastPlayedVsMode |= 1;
        saveGame.system.lastPlayedVsMode &= ~2;
    }
    else
    {
        saveGame.system.lastPlayedVsMode &= ~1;
        saveGame.system.lastPlayedVsMode |= 2;
    }

    TrySaveGameData(SAVE_TYPE_SYSTEM_3);
}

BOOL SaveGame__GetLastPlayedVsMode(void)
{
    return (saveGame.system.lastPlayedVsMode & 3) != 0;
}

void SaveGame__SetNoLastPlayedVsMode(void)
{
    saveGame.system.lastPlayedVsMode &= ~1;
    saveGame.system.lastPlayedVsMode &= ~2;
}

void SaveGame__DisconnectLoseVsMatch(void)
{
    if (SaveGame__GetLastPlayedVsMode() == 0)
        return;

    if ((saveGame.system.lastPlayedVsMode & 1) != 0)
        SaveGame__AddNetworkRaceRecord(SAVE_VSRECORD_LOSS);
    else
        SaveGame__AddNetworkRingBattleRecord(SAVE_VSRECORD_LOSS);

    SaveGame__UpdateOnlineScore(SAVE_VSRECORD_LOSS, 0);
}

BOOL SaveGame__HandlePlayerVsDisconnect(void)
{
    if (SaveGame__GetLastPlayedVsMode() == 0)
        return TRUE;

    SaveGame__DisconnectLoseVsMatch();
    SaveGame__SetNoLastPlayedVsMode();

    return TrySaveGameData(SAVE_TYPE_PROFILE_VS_RECORDS_2);
}

BOOL SaveGame__Func_2060458(void)
{
    if (!SaveGame__GetLastPlayedVsMode())
        return TRUE;

    SaveGame__SetNoLastPlayedVsMode();

    return TrySaveGameData(SAVE_TYPE_SYSTEM_3);
}

BOOL SaveGame__Func_206047C(s32 a1)
{
    if (SaveGame__GetLastPlayedVsMode() && (SaveGame__SetNoLastPlayedVsMode(), a1 != 0))
        return TrySaveGameData(SAVE_TYPE_SYSTEM_3);

    return TRUE;
}

u16 SaveGame__SetVikingCupScoreRecord(struct SaveVikingCupRecord *recordList, u32 score)
{
    u16 rank;
    s32 r;
    for (r = 0; r < 5; r++)
    {
        if (recordList->records[r] < score)
        {
            rank = r;
            break;
        }
    }

    if (r >= 5)
        return 0xFFFF;

    for (s32 r = 4; r > rank; r--)
    {
        recordList->records[r] = recordList->records[r - 1];
    }

    recordList->records[rank] = score;

    return rank;
}

u16 SaveGame__SetVikingCupTimeRecord(struct SaveVikingCupRecord *recordList, u32 time)
{
    u16 rank;
    s32 r;
    for (r = 0; r < 5; r++)
    {
        if (recordList->records[r] == 0 || recordList->records[r] > time)
        {
            rank = r;
            break;
        }
    }

    if (r >= 5)
        return 0xFFFF;

    for (s32 r = 4; r > rank; r--)
    {
        recordList->records[r] = recordList->records[r - 1];
    }

    recordList->records[rank] = time;

    return rank;
}

BOOL SaveGame__CheckStageAllowDifficulties(u32 stageID)
{
    // always false, stages only allow one difficulty
    return FALSE;
}