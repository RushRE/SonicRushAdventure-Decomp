#ifndef RUSH_SAVEMANAGER_H
#define RUSH_SAVEMANAGER_H

#include <game/system/task.h>
#include <game/system/threadWorker.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define SAVEMANAGER_STACK_SIZE 0x800

// --------------------
// ENUMS
// --------------------

enum SaveTypes_
{
    SAVE_TYPE_ALL,
    SAVE_TYPE_STAGE,
    SAVE_TYPE_SYSTEM,
    SAVE_TYPE_PROFILE,
    SAVE_TYPE_LEADERBOARDS,
    SAVE_TYPE_TIME_ATTACK,
    SAVE_TYPE_SYSTEM_2,
    SAVE_TYPE_SYSTEM_3,
    SAVE_TYPE_PROFILE_VS_RECORDS,
    SAVE_TYPE_ALL_2,
    SAVE_TYPE_PROFILE_2,
    SAVE_TYPE_PROFILE_3,
    SAVE_TYPE_ALL_3,
    SAVE_TYPE_PROFILE_VS_RECORDS_2,

    SAVE_TYPE_COUNT,
};
typedef u32 SaveTypes;

// --------------------
// STRUCTS
// --------------------

typedef struct SaveGameSaveManager_
{
    SaveTypes saveType;
    BOOL success;
    BOOL usingFoldTogglePower;
    BOOL canSoftReset;
    Thread thread;
} SaveGameSaveManager;

typedef struct SaveGameLoadManager_
{
    u32 saveFlags;
    BOOL success;
    BOOL usingFoldTogglePower;
    BOOL canSoftReset;
    Thread thread;
} SaveGameLoadManager;

typedef struct SaveGameCreateManager_
{
    BOOL success;
    BOOL usingFoldTogglePower;
    BOOL canSoftReset;
    Thread thread;
} SaveGameCreateManager;

// --------------------
// FUNCTIONS
// --------------------

// SaveFile Saving
BOOL TrySaveGameData(SaveTypes type);
void CreateSaveGameWorker(SaveGameSaveManager *work, SaveTypes type, s32 prio);
BOOL AwaitSaveGameCompletion(SaveGameSaveManager *work);
BOOL GetSaveGameSuccess(SaveGameSaveManager *work);

// SaveFile Loading
BOOL TryLoadGameData(u32 flags);
void CreateLoadSaveWorker(SaveGameLoadManager *work, u32 flags, s32 prio);
BOOL AwaitLoadSaveCompletion(SaveGameLoadManager *work);
BOOL GetLoadSaveSuccess(SaveGameLoadManager *work);

// SaveFile Creation
BOOL TryCreateGameData(void);
void CreateCreateSaveWorker(SaveGameCreateManager *work, s32 prio);
BOOL AwaitCreateSaveCompletion(SaveGameCreateManager *work);
BOOL GetCreateSaveSuccess(SaveGameCreateManager *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_SAVEMANAGER_H
