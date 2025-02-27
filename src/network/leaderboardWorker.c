#include <network/leaderboardWorker.h>
#include <network/networkHandler.h>
#include <game/save/saveManager.h>
#include <game/util/akUtil.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED s32 MultibootManager__GetField8(void);
NOT_DECOMPILED void MultibootManager__Func_2061BF0(BOOL a1);
NOT_DECOMPILED BOOL MultibootManager__CheckValidConsole(void);
NOT_DECOMPILED BOOL MultibootManager__CheckHasProfile(void);

// --------------------
// VARIABLES
// --------------------

static Task *leaderboardsWorkerTaskSingleton;

NOT_DECOMPILED const char16 *LeaderboardWorker_NullName;

// --------------------
// FUNCTION DECLS
// --------------------

static void LeaderboardWorker_Main(void);
static void LeaderboardWorker_Destructor(Task *task);
static void LeaderboardWorker_State_TryStart(LeaderboardWorker *work);
static void LeaderboardWorker_State_BeginWorking(LeaderboardWorker *work);
static void LeaderboardWorker_State_UploadingScore(LeaderboardWorker *work);
static void LeaderboardWorker_State_LoadingRanks_Top(LeaderboardWorker *work);
static void LeaderboardWorker_State_LoadingRanks_Near(LeaderboardWorker *work);
static void LeaderboardWorker_State_SavingRanks(LeaderboardWorker *work);
static void LeaderboardWorker_Action_Start(LeaderboardWorker *work);
static void LeaderboardWorker_Action_BeginWorking(LeaderboardWorker *work);
static void LeaderboardWorker_Action_UploadScore(LeaderboardWorker *work);
static void LeaderboardWorker_Action_LoadRanks_Top(LeaderboardWorker *work);
static void LeaderboardWorker_Action_LoadRanks_Near(LeaderboardWorker *work);
static void LeaderboardWorker_Action_SaveRanks(LeaderboardWorker *work);
static void LeaderboardWorker_Action_SavedRanks(LeaderboardWorker *work);
static void LeaderboardWorker_Action_Error(LeaderboardWorker *work);
static void LeaderboardWorker_Action_Cancelled(LeaderboardWorker *work);
static void LeaderboardWorker_Action_ForceFinish(LeaderboardWorker *work);
static BOOL LeaderboardWorker_CreateRankDataForUpload(LeaderboardRankUserdata *rankData, BOOL flag, s32 stage);
static u32 LeaderboardWorker_GetRankCategory(s32 stage);
static s32 LeaderboardWorker_GetRankScore(s32 stage);
static void LeaderboardWorker_LoadRankListTop(LeaderboardWorker *work);
static void LeaderboardWorker_LoadRankListNear(LeaderboardWorker *work);
static u64 LeaderboardWorker_GetSaveSeconds(void);
static BOOL LeaderboardWorker_SetSaveSeconds(u64 seconds, BOOL writeSaveFile);
static SaveBlockOnlineProfile *LeaderboardWorker_GetUserProfile(void);
static void LeaderboardWorker_SaveRankLists(LeaderboardWorker *work);
static s32 LeaderboardWorker_GetRankScore_Internal(s32 stage);
static u16 LeaderboardWorker_GetTimeFromScore(s32 score);
static u16 LeaderboardWorker_GetCharacterID(s32 stage);
static s32 LeaderboardWorker_GetStageID(s32 stage);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE s32 GetNameLength(SavePlayerName *name)
{
    s32 length;
    for (length = 0; length < SAVEGAME_MAX_NAME_LEN; length++)
    {
        if (name->text[length] == 0x00)
            break;
    }

    return length;
}

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateLeaderboardWorker(s32 stage, BOOL wantUpload, BOOL flag)
{
    if (!MultibootManager__CheckHasProfile() || !MultibootManager__CheckValidConsole())
        return FALSE;

    leaderboardsWorkerTaskSingleton =
        TaskCreate(LeaderboardWorker_Main, LeaderboardWorker_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(0), LeaderboardWorker);

    LeaderboardWorker *work = TaskGetWork(leaderboardsWorkerTaskSingleton, LeaderboardWorker);

    work->status        = LEADERBOARDWORKER_STATUS_WORKING;
    work->failedToLoad  = FALSE;
    work->rankCategory  = LeaderboardWorker_GetRankCategory(stage);
    work->rankScore     = LeaderboardWorker_GetRankScore(stage);
    work->stage         = stage;
    work->wantUpload    = wantUpload;
    work->forceFinish       = FALSE;
    work->hasUploadData = LeaderboardWorker_CreateRankDataForUpload(&work->uploadRankData, flag, stage);

    if (work->hasUploadData == 0 || work->rankScore < 0)
        work->wantUpload = 0;

    work->state = NULL;
    LeaderboardWorker_Action_Start(work);

    return TRUE;
}

LeaderboardWorkerStatus GetLeaderboardWorkerStatus(void)
{
    if (leaderboardsWorkerTaskSingleton == NULL)
        return LEADERBOARDWORKER_STATUS_INACTIVE;

    return TaskGetWork(leaderboardsWorkerTaskSingleton, LeaderboardWorker)->status;
}

void DestroyLeaderboardWorker(void)
{
    DestroyTask(leaderboardsWorkerTaskSingleton);

    leaderboardsWorkerTaskSingleton = NULL;
}

void LeaderboardWorker_Main(void)
{
    LeaderboardWorker *work = TaskGetWorkCurrent(LeaderboardWorker);

    if (work->state != NULL)
        work->state(work);
}

void LeaderboardWorker_Destructor(Task *task)
{
    leaderboardsWorkerTaskSingleton = NULL;
}

void LeaderboardWorker_State_TryStart(LeaderboardWorker *work)
{
    if (MultibootManager__GetField8() != 17)
    {
        LeaderboardWorker_Action_Error(work);
        return;
    }

    if (work->forceFinish)
    {
        LeaderboardWorker_Action_ForceFinish(work);
        return;
    }

    RTCDate date;
    RTCTime time;
    if (DWC_GetDateTime(&date, &time))
    {
        s64 seconds = RTC_ConvertDateTimeToSecond(&date, &time);
        if (seconds >= *(s64 *)work->rankSecondsTime + 120)
        {
            if (LeaderboardWorker_SetSaveSeconds(seconds, TRUE) == FALSE)
            {
                work->failedToLoad = TRUE;
                LeaderboardWorker_Action_Error(work);
            }
            else
            {
                LeaderboardWorker_Action_BeginWorking(work);
            }
        }
    }
}

void LeaderboardWorker_State_BeginWorking(LeaderboardWorker *work)
{
    if (MultibootManager__GetField8() != 17 || GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_ERROR)
    {
        LeaderboardWorker_Action_Error(work);
        return;
    }

    if (GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_CANCELLED)
    {
        LeaderboardWorker_Action_Cancelled(work);
        return;
    }

    if (work->forceFinish)
    {
        LeaderboardWorker_Action_ForceFinish(work);
        return;
    }

    if (GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_IDLE)
    {
        if (work->wantUpload)
            LeaderboardWorker_Action_UploadScore(work);
        else
            LeaderboardWorker_Action_LoadRanks_Top(work);
    }
}

void LeaderboardWorker_State_UploadingScore(LeaderboardWorker *work)
{
    if (MultibootManager__GetField8() != 17 || GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_ERROR)
    {
        LeaderboardWorker_Action_Error(work);
        return;
    }

    if (GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_CANCELLED)
    {
        LeaderboardWorker_Action_Cancelled(work);
        return;
    }

    if (work->forceFinish)
    {
        LeaderboardWorker_Action_ForceFinish(work);
        return;
    }

    if (GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_IDLE)
    {
        LeaderboardWorker_Action_LoadRanks_Top(work);
        return;
    }

    if (GetLeaderboardsManagerStatus() != LEADERBOARDSMANAGER_STATUS_PUTTING_SCORE)
    {
        LeaderboardWorker_Action_Error(work);
    }
}

void LeaderboardWorker_State_LoadingRanks_Top(LeaderboardWorker *work)
{
    if (MultibootManager__GetField8() != 17 || GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_ERROR)
    {
        LeaderboardWorker_Action_Error(work);
        return;
    }

    if (GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_CANCELLED)
    {
        LeaderboardWorker_Action_Cancelled(work);
        return;
    }

    if (work->forceFinish)
    {
        LeaderboardWorker_Action_ForceFinish(work);
        return;
    }

    if (GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_IDLE)
    {
        LeaderboardWorker_LoadRankListTop(work);

        if (work->hasUploadData)
            LeaderboardWorker_Action_LoadRanks_Near(work);
        else
            LeaderboardWorker_Action_SaveRanks(work);

        return;
    }

    if (GetLeaderboardsManagerStatus() != LEADERBOARDSMANAGER_STATUS_LOADING_SCORES)
    {
        LeaderboardWorker_Action_Error(work);
    }
}

void LeaderboardWorker_State_LoadingRanks_Near(LeaderboardWorker *work)
{
    if (MultibootManager__GetField8() != 17 || GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_ERROR)
    {
        LeaderboardWorker_Action_Error(work);
        return;
    }

    if (GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_CANCELLED)
    {
        LeaderboardWorker_Action_Cancelled(work);
        return;
    }

    if (work->forceFinish)
    {
        LeaderboardWorker_Action_ForceFinish(work);
        return;
    }

    if (GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_IDLE)
    {
        LeaderboardWorker_LoadRankListNear(work);
        LeaderboardWorker_Action_SaveRanks(work);
        return;
    }

    if (GetLeaderboardsManagerStatus() != LEADERBOARDSMANAGER_STATUS_LOADING_SCORES)
    {
        LeaderboardWorker_Action_Error(work);
    }
}

void LeaderboardWorker_State_SavingRanks(LeaderboardWorker *work)
{
    if (MultibootManager__GetField8() != 17 || GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_ERROR)
    {
        LeaderboardWorker_Action_Error(work);
        return;
    }

    if (work->forceFinish)
    {
        LeaderboardWorker_Action_ForceFinish(work);
        return;
    }

    if (GetLeaderboardsManagerStatus() == LEADERBOARDSMANAGER_STATUS_INACTIVE)
    {
        RTCDate date;
        RTCTime time;
        if (DWC_GetDateTime(&date, &time))
        {
            LeaderboardWorker_SetSaveSeconds(RTC_ConvertDateTimeToSecond(&date, &time), FALSE);
        }
        LeaderboardWorker_SaveRankLists(work);
        LeaderboardWorker_Action_SavedRanks(work);
    }
}

void LeaderboardWorker_Action_Start(LeaderboardWorker *work)
{
    *(u64 *)work->rankSecondsTime = LeaderboardWorker_GetSaveSeconds();

    work->state = LeaderboardWorker_State_TryStart;
}

void LeaderboardWorker_Action_BeginWorking(LeaderboardWorker *work)
{
    CreateLeaderboardsManager(&LeaderboardWorker_GetUserProfile()->userData);

    work->state = LeaderboardWorker_State_BeginWorking;
}

void LeaderboardWorker_Action_UploadScore(LeaderboardWorker *work)
{
    DWCRnkRegion region;
#if defined(RUSH_EUROPE)
    region = DWC_RNK_REGION_EU;
#elif defined(RUSH_USA)
    region = DWC_RNK_REGION_US;
#elif defined(RUSH_JAPAN)
    region = DWC_RNK_REGION_JP;
#endif

    PutScoreToLeaderboards(work->rankCategory, region, work->rankScore, &work->uploadRankData, sizeof(work->uploadRankData));

    work->state = LeaderboardWorker_State_UploadingScore;
}

void LeaderboardWorker_Action_LoadRanks_Top(LeaderboardWorker *work)
{
    LoadLeaderboardRanksTopList(work->rankCategory, DWC_RNK_REGION_ALL, FALSE, 0, ARRAY_COUNT(work->rankListTop));

    work->state = LeaderboardWorker_State_LoadingRanks_Top;
}

void LeaderboardWorker_Action_LoadRanks_Near(LeaderboardWorker *work)
{
    LoadLeaderboardRanksNear(work->rankCategory, DWC_RNK_REGION_ALL, FALSE, 0, ARRAY_COUNT(work->rankListNear));

    work->state = LeaderboardWorker_State_LoadingRanks_Near;
}

void LeaderboardWorker_Action_SaveRanks(LeaderboardWorker *work)
{
    DestroyLeaderboardsManager();

    work->state = LeaderboardWorker_State_SavingRanks;
}

void LeaderboardWorker_Action_SavedRanks(LeaderboardWorker *work)
{
    DestroyLeaderboardsManager();

    work->status = LEADERBOARDWORKER_STATUS_FINISHED;
    work->state  = NULL;
}

void LeaderboardWorker_Action_Error(LeaderboardWorker *work)
{
    if (MultibootManager__GetField8() != 0)
        MultibootManager__Func_2061BF0(work->failedToLoad);

    DestroyLeaderboardsManager();

    work->status = LEADERBOARDWORKER_STATUS_ERROR;
    work->state  = NULL;
}

void LeaderboardWorker_Action_Cancelled(LeaderboardWorker *work)
{
    DestroyLeaderboardsManager();

    work->status = LEADERBOARDWORKER_STATUS_CANCELLED;
    work->state  = NULL;
}

void LeaderboardWorker_Action_ForceFinish(LeaderboardWorker *work)
{
    DestroyLeaderboardsManager();

    work->status = LEADERBOARDWORKER_STATUS_FINISHED;
    work->state  = NULL;
}

BOOL LeaderboardWorker_CreateRankDataForUpload(LeaderboardRankUserdata *rankData, BOOL flag, s32 stage)
{
    MI_CpuClear16(rankData, sizeof(*rankData));

    if (flag)
        rankData->flags |= LEADERBOARDRANKUSERDATA_FLAG_UNKNOWN;

    MI_CpuCopy16(&saveGame.system.name, &rankData->name, sizeof(rankData->name));

    u16 characterID = LeaderboardWorker_GetCharacterID(stage);
    if (characterID >= CHARACTER_COUNT)
        return FALSE;

    if (characterID == CHARACTER_BLAZE)
        rankData->flags |= LEADERBOARDRANKUSERDATA_FLAG_IS_BLAZE;

    return TRUE;
}

u32 LeaderboardWorker_GetRankCategory(s32 stage)
{
    return stage;
}

s32 LeaderboardWorker_GetRankScore(s32 stage)
{
    return LeaderboardWorker_GetRankScore_Internal(stage);
}

void LeaderboardWorker_LoadRankListTop(LeaderboardWorker *work)
{
    u32 count = GetLeaderboardsRankCount();

    s32 r = 0;
    for (; r < count; r++)
    {
        DWCRnkData *rankData = GetLeaderboardsRankData(r);

        MI_CpuClear16(&work->rankListTop[r], sizeof(work->rankListTop[r]));

        if (rankData->size == sizeof(work->rankListTop[r].userData))
        {
            work->rankListTop[r].score = rankData->score;
            MI_CpuCopy16(rankData->userdata, &work->rankListTop[r].userData, sizeof(work->rankListTop[r].userData));
            work->rankListTop[r].userData.flags |= LEADERBOARDRANKUSERDATA_FLAG_LOADED;
        }
    }

    for (; r < (s32)ARRAY_COUNT(work->rankListTop); r++)
    {
        MI_CpuClear16(&work->rankListTop[r], sizeof(work->rankListTop[r]));
    }
}

void LeaderboardWorker_LoadRankListNear(LeaderboardWorker *work)
{
    work->rankOrder = GetLeaderboardsRankOrder();

    if (work->rankOrder == 0)
    {
        work->rankOrder = 0;
    }
    else
    {
        u32 count = GetLeaderboardsRankCount();

        s32 r = 0;
        for (; r < count; r++)
        {
            DWCRnkData *rankData = GetLeaderboardsRankData(r);

            MI_CpuClear16(&work->rankListNear[r], sizeof(work->rankListNear[r]));

            if (rankData->size == sizeof(work->rankListNear[r].userData))
            {
                work->rankListNear[r].score = rankData->score;
                MI_CpuCopy16(rankData->userdata, &work->rankListNear[r].userData, sizeof(work->rankListNear[r].userData));
                work->rankListNear[r].userData.flags |= LEADERBOARDRANKUSERDATA_FLAG_LOADED;
            }
        }

        for (; r < (s32)ARRAY_COUNT(work->rankListNear); r++)
        {
            MI_CpuClear16(&work->rankListNear[r], sizeof(work->rankListNear[r]));
        }

        work->rankNearCount = 0;
        if ((work->rankListNear[0].userData.flags & LEADERBOARDRANKUSERDATA_FLAG_LOADED) != 0)
        {
            while (work->rankNearCount < 4)
            {
                if ((work->rankListNear[work->rankNearCount + 1].userData.flags & LEADERBOARDRANKUSERDATA_FLAG_LOADED) == 0)
                    break;

                if (work->rankListNear[work->rankNearCount].score >= work->rankListNear[work->rankNearCount + 1].score)
                    break;

                LeaderboardRankData temp;
                MI_CpuCopy16(&work->rankListNear[work->rankNearCount], &temp, sizeof(temp));
                MI_CpuCopy16(&work->rankListNear[work->rankNearCount + 1], &work->rankListNear[work->rankNearCount], sizeof(work->rankListNear[work->rankNearCount]));
                MI_CpuCopy16(&temp, &work->rankListNear[work->rankNearCount + 1], sizeof(work->rankListNear[work->rankNearCount + 1]));

                work->rankNearCount++;
            }
        }
    }
}

u64 LeaderboardWorker_GetSaveSeconds(void)
{
    return saveGame.system.rankSeconds;
}

BOOL LeaderboardWorker_SetSaveSeconds(u64 seconds, BOOL writeSaveFile)
{
    saveGame.system.rankSeconds = seconds;

    if (writeSaveFile)
    {
        if (TrySaveGameData(SAVE_TYPE_SYSTEM_2) == FALSE)
            return FALSE;
    }

    return TRUE;
}

SaveBlockOnlineProfile *LeaderboardWorker_GetUserProfile(void)
{
    return &saveGame.onlineProfile;
}

NONMATCH_FUNC void LeaderboardWorker_SaveRankLists(LeaderboardWorker *work)
{
    // https://decomp.me/scratch/3UGCj -> 99.15%
    // minor register issues
#ifdef NON_MATCHING
    BOOL isBlaze;
    s32 r;

    if (work->hasUploadData != FALSE && work->rankOrder != 0)
    {
        if (work->rankOrder > 9999999)
            work->rankOrder = 9999999;

        SaveGame__SaveLeaderboardRankOrder(work->stage, work->rankOrder);
    }

    for (r = 0; r < (s32)ARRAY_COUNT(work->rankListTop); r++)
    {
        if ((work->rankListTop[r].userData.flags & LEADERBOARDRANKUSERDATA_FLAG_LOADED) == 0)
        {
            SaveGame__SaveLeaderboardRank_Top(work->stage, r, L"", 0, 0, isBlaze);
        }
        else
        {
            isBlaze    = (work->rankListTop[r].userData.flags & LEADERBOARDRANKUSERDATA_FLAG_IS_BLAZE) != 0;
            s32 length = GetNameLength(&work->rankListTop[r].userData.name);
            u16 time   = LeaderboardWorker_GetTimeFromScore(work->rankListTop[r].score);

            SaveGame__SaveLeaderboardRank_Top(work->stage, r, work->rankListTop[r].userData.name.text, length, time, isBlaze);
        }
    }

    for (r = 0; r < (s32)ARRAY_COUNT(work->rankListNear); r++)
    {
        if (work->hasUploadData == FALSE || (work->rankListNear[r].userData.flags & LEADERBOARDRANKUSERDATA_FLAG_LOADED) == 0 || work->rankOrder == 0)
        {
            SaveGame__SaveLeaderboardRank_Near(work->stage, r, L"", 0, 0, isBlaze);
        }
        else
        {
            isBlaze  = (work->rankListNear[r].userData.flags & LEADERBOARDRANKUSERDATA_FLAG_IS_BLAZE) != 0;
            u16 time = LeaderboardWorker_GetTimeFromScore(work->rankListNear[r].score);

            if (r == work->rankNearCount)
            {
                SaveGame__SaveLeaderboardRank_Near(work->stage, r, 0, 0, time, isBlaze);
            }
            else
            {
                s32 length = GetNameLength(&work->rankListNear[r].userData.name);
                SaveGame__SaveLeaderboardRank_Near(work->stage, r, work->rankListNear[r].userData.name.text, length, time, isBlaze);
            }
        }
    }

    SaveGame__SetLeaderboardLastUpdatedTime(work->stage);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r0
	ldr r0, [r10, #0x38]
	cmp r0, #0
	ldrne r1, [r10, #0x100]
	cmpne r1, #0
	beq _021752CC
	ldr r0, =0x0098967F
	cmp r1, r0
	strhi r0, [r10, #0x100]
	ldr r0, [r10, #0x2c]
	ldr r1, [r10, #0x100]
	bl SaveGame__SaveLeaderboardRankOrder
_021752CC:
	mov r5, #0
	ldr r11, =LeaderboardWorker_NullName
	mov r8, r10
	add r9, r10, #0x44
	mov r4, r5
_021752E0:
	ldr r0, [r8, #0x40]
	tst r0, #0x80000000
	bne _0217530C
	stmia sp, {r4, r7}
	mov r1, r5, lsl #0x10
	ldr r0, [r10, #0x2c]
	mov r2, r11
	mov r3, r4
	mov r1, r1, lsr #0x10
	bl SaveGame__SaveLeaderboardRank_Top
	b _02175360
_0217530C:
	tst r0, #2
	movne r7, #1
	moveq r7, #0
	mov r6, #0
_0217531C:
	add r0, r8, r6, lsl #1
	ldrh r0, [r0, #0x44]
	cmp r0, #0
	beq _02175338
	add r6, r6, #1
	cmp r6, #8
	blt _0217531C
_02175338:
	ldr r0, [r8, #0x3c]
	bl LeaderboardWorker_GetTimeFromScore
	mov r1, r6, lsl #0x10
	mov r3, r1, lsr #0x10
	stmia sp, {r0, r7}
	mov r1, r5, lsl #0x10
	ldr r0, [r10, #0x2c]
	mov r1, r1, lsr #0x10
	mov r2, r9
	bl SaveGame__SaveLeaderboardRank_Top
_02175360:
	add r5, r5, #1
	cmp r5, #3
	add r8, r8, #0x18
	add r9, r9, #0x18
	blt _021752E0
	mov r4, r10
	add r5, r10, #0x8c
	mov r6, #0
_02175380:
	ldr r0, [r10, #0x38]
	cmp r0, #0
	beq _021753A0
	ldr r1, [r4, #0x88]
	tst r1, #0x80000000
	ldrne r0, [r10, #0x100]
	cmpne r0, #0
	bne _021753C0
_021753A0:
	mov r3, #0
	stmia sp, {r3, r7}
	mov r1, r6, lsl #0x10
	ldr r0, [r10, #0x2c]
	ldr r2, =LeaderboardWorker_NullName
	mov r1, r1, lsr #0x10
	bl SaveGame__SaveLeaderboardRank_Near
	b _0217543C
_021753C0:
	ldr r0, [r4, #0x84]
	tst r1, #2
	movne r7, #1
	moveq r7, #0
	bl LeaderboardWorker_GetTimeFromScore
	ldr r1, [r10, #0xfc]
	mov r2, #0
	cmp r6, r1
	bne _02175400
	stmia sp, {r0, r7}
	mov r1, r6, lsl #0x10
	ldr r0, [r10, #0x2c]
	mov r3, r2
	mov r1, r1, lsr #0x10
	bl SaveGame__SaveLeaderboardRank_Near
	b _0217543C
_02175400:
	add r1, r4, r2, lsl #1
	ldrh r1, [r1, #0x8c]
	cmp r1, #0
	beq _0217541C
	add r2, r2, #1
	cmp r2, #8
	blt _02175400
_0217541C:
	mov r3, r2, lsl #0x10
	stmia sp, {r0, r7}
	mov r1, r6, lsl #0x10
	ldr r0, [r10, #0x2c]
	mov r2, r5
	mov r1, r1, lsr #0x10
	mov r3, r3, lsr #0x10
	bl SaveGame__SaveLeaderboardRank_Near
_0217543C:
	add r6, r6, #1
	cmp r6, #5
	add r4, r4, #0x18
	add r5, r5, #0x18
	blt _02175380
	ldr r0, [r10, #0x2c]
	bl SaveGame__SetLeaderboardLastUpdatedTime
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

s32 LeaderboardWorker_GetRankScore_Internal(s32 stage)
{
    u32 timeAttackStageID = LeaderboardWorker_GetStageID(stage);
    u32 characterID       = LeaderboardWorker_GetCharacterID(stage);

    if (characterID >= CHARACTER_COUNT)
        return -1;

    s32 time = SaveGame__GetTimeAttackRecord(&saveGame.timeAttack, characterID, timeAttackStageID, 1);

    if (time < 1)
        time = 1;

    if (time > (s32)AKUTIL_TIME_TO_FRAMES(9, 59, 99))
        time = (s32)AKUTIL_TIME_TO_FRAMES(9, 59, 99);

    return (saveGame.timeAttack.recordBitfield[stage + 4] & 0x7FFF) | ((AKUTIL_TIME_TO_FRAMES(9, 59, 99) - time) << 15);
}

u16 LeaderboardWorker_GetTimeFromScore(s32 score)
{
    u16 time = AKUTIL_TIME_TO_FRAMES(9, 59, 99) - (score >> 15);

    if (time < 1)
        time = 1;

    if (time > AKUTIL_TIME_TO_FRAMES(9, 59, 99))
        time = AKUTIL_TIME_TO_FRAMES(9, 59, 99);

    return time;
}

u16 LeaderboardWorker_GetCharacterID(s32 stage)
{
    s32 timeAttackStageID = LeaderboardWorker_GetStageID(stage);

    SaveBlockTimeAttack *timeAttack = &saveGame.timeAttack;

    u32 sonicRecord = SaveGame__GetTimeAttackRecord(timeAttack, CHARACTER_SONIC, timeAttackStageID, 1);
    u32 blazeRecord = SaveGame__GetTimeAttackRecord(timeAttack, CHARACTER_BLAZE, timeAttackStageID, 1);

    if (sonicRecord != 0 && blazeRecord != 0)
        return (timeAttack->recordBitfield[timeAttackStageID / 16] >> (timeAttackStageID % 16)) & 1;

    if (sonicRecord != 0)
        return CHARACTER_SONIC;

    if (blazeRecord != 0)
        return CHARACTER_BLAZE;

    return 0xFFFF;
}

s32 LeaderboardWorker_GetStageID(s32 stage)
{
    return (stage % 2) + (3 * (stage / 2));
}