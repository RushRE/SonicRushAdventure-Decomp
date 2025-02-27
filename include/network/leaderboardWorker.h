#ifndef RUSH_LEADERBOARDWORKER_H
#define RUSH_LEADERBOARDWORKER_H

#include <global.h>
#include <game/system/task.h>
#include <game/save/saveGame.h>

// --------------------
// ENUMS
// --------------------

enum LeaderboardWorkerStatus_
{
    LEADERBOARDWORKER_STATUS_ERROR,
    LEADERBOARDWORKER_STATUS_CANCELLED,
    LEADERBOARDWORKER_STATUS_WORKING,
    LEADERBOARDWORKER_STATUS_FINISHED,
    LEADERBOARDWORKER_STATUS_UNKNOWN,
    LEADERBOARDWORKER_STATUS_INACTIVE,
};
typedef u32 LeaderboardWorkerStatus;

enum LeaderboardRankUserdataFlags_
{
    LEADERBOARDRANKUSERDATA_FLAG_NONE = 0x00,

    LEADERBOARDRANKUSERDATA_FLAG_UNKNOWN  = 1 << 0,
    LEADERBOARDRANKUSERDATA_FLAG_IS_BLAZE = 1 << 1,

    LEADERBOARDRANKUSERDATA_FLAG_LOADED = 1 << 31u,
};
typedef u32 LeaderboardRankUserdataFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct LeaderboardRankUserdata_
{
    LeaderboardRankUserdataFlags flags;
    SavePlayerName name;
} LeaderboardRankUserdata;

typedef struct LeaderboardRankData_
{
    s32 score;
    LeaderboardRankUserdata userData;
} LeaderboardRankData;

typedef struct LeaderboardWorker_
{
    LeaderboardWorkerStatus status;
    BOOL failedToLoad;
    LeaderboardRankUserdata uploadRankData;
    u32 rankSecondsTime[2];
    u32 rankCategory;
    s32 rankScore;
    s32 stage;
    BOOL wantUpload;
    u32 forceFinish;
    BOOL hasUploadData;
    LeaderboardRankData rankListTop[3];
    LeaderboardRankData rankListNear[5];
    u32 rankNearCount;
    u32 rankOrder;
    void (*state)(struct LeaderboardWorker_ *work);
} LeaderboardWorker;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateLeaderboardWorker(s32 stage, BOOL wantUpload, BOOL flag);
LeaderboardWorkerStatus GetLeaderboardWorkerStatus(void);
void DestroyLeaderboardWorker(void);

#endif // RUSH_LEADERBOARDWORKER_H