
#include <game/save/saveManager.h>
#include <game/save/saveGame.h>
#include <game/graphics/renderCore.h>
#include <game/game/gameState.h>

// --------------------
// PRIVATE FUNCTIONS
// --------------------

// Thread Funcs
static void ThreadFunc_Save(SaveGameSaveManager *work);
static void ThreadFunc_Load(SaveGameLoadManager *work);
static void ThreadFunc_Create(SaveGameCreateManager *work);

// --------------------
// VARIABLES
// --------------------

static const u32 saveTypes[SAVE_TYPE_COUNT] = { [SAVE_TYPE_ALL]                  = SAVE_BLOCK_FLAG_ALL,
                                                [SAVE_TYPE_STAGE]                = SAVE_BLOCK_FLAG_STAGE,
                                                [SAVE_TYPE_SYSTEM]               = SAVE_BLOCK_FLAG_SYSTEM,
                                                [SAVE_TYPE_PROFILE]              = SAVE_BLOCK_FLAG_ONLINE_PROFILE,
                                                [SAVE_TYPE_LEADERBOARDS]         = SAVE_BLOCK_FLAG_SYSTEM | SAVE_BLOCK_FLAG_ONLINE_LEADERBOARDS,
                                                [SAVE_TYPE_TIME_ATTACK]          = SAVE_BLOCK_FLAG_TIME_ATTACK,
                                                [SAVE_TYPE_SYSTEM_2]             = SAVE_BLOCK_FLAG_SYSTEM,
                                                [SAVE_TYPE_SYSTEM_3]             = SAVE_BLOCK_FLAG_SYSTEM,
                                                [SAVE_TYPE_PROFILE_VS_RECORDS]   = SAVE_BLOCK_FLAG_SYSTEM | SAVE_BLOCK_FLAG_VS_RECORDS | SAVE_BLOCK_FLAG_ONLINE_PROFILE,
                                                [SAVE_TYPE_ALL_2]                = SAVE_BLOCK_FLAG_ALL,
                                                [SAVE_TYPE_PROFILE_2]            = SAVE_BLOCK_FLAG_ONLINE_PROFILE,
                                                [SAVE_TYPE_PROFILE_3]            = SAVE_BLOCK_FLAG_ONLINE_PROFILE,
                                                [SAVE_TYPE_ALL_3]                = SAVE_BLOCK_FLAG_ALL,
                                                [SAVE_TYPE_PROFILE_VS_RECORDS_2] = SAVE_BLOCK_FLAG_SYSTEM | SAVE_BLOCK_FLAG_VS_RECORDS | SAVE_BLOCK_FLAG_ONLINE_PROFILE };

// --------------------
// FUNCTIONS
// --------------------

// SaveFile Saving
BOOL TrySaveGameData(SaveTypes type)
{
    if (SaveGame__SaveData(&saveGame, saveTypes[type]) != SAVE_ERROR_CANT_LOAD)
        return TRUE;

    gameState.lastSaveError = GAMESAVE_ERROR_CANT_SAVE;
    return FALSE;
}

void CreateSaveGameWorker(SaveGameSaveManager *work, SaveTypes type, s32 prio)
{
    work->saveType             = type;
    work->success              = FALSE;
    work->usingFoldTogglePower = FALSE;
    work->canSoftReset         = TRUE;

    if (RenderCore_GetNextFoldMode() == FOLD_TOGGLE_SLEEP)
    {
        RenderCore_SetNextFoldMode(FOLD_TOGGLE_POWER);
        work->usingFoldTogglePower = TRUE;
    }

    if (!RenderCore_GetSoftResetDisabled())
    {
        RenderCore_DisableSoftReset(TRUE);
        work->canSoftReset = FALSE;
    }

    InitThreadWorker(&work->thread, SAVEMANAGER_STACK_SIZE);
    CreateThreadWorker(&work->thread, (ThreadFunc)ThreadFunc_Save, work, prio);
}

BOOL AwaitSaveGameCompletion(SaveGameSaveManager *work)
{
    if (IsThreadWorkerFinished(&work->thread))
    {
        ReleaseThreadWorker(&work->thread);

        if (work->usingFoldTogglePower)
        {
            RenderCore_SetNextFoldMode(FOLD_TOGGLE_SLEEP);
            work->usingFoldTogglePower = FALSE;
        }

        if (!work->canSoftReset)
        {
            RenderCore_DisableSoftReset(FALSE);
            work->canSoftReset = TRUE;
        }

        return TRUE;
    }

    return FALSE;
}

BOOL GetSaveGameSuccess(SaveGameSaveManager *work)
{
    return work->success;
}

// SaveFile Loading
BOOL TryLoadGameData(u32 flags)
{
    if (SaveGame__LoadData2(flags) != SAVE_ERROR_CANT_LOAD)
        return TRUE;

    gameState.lastSaveError = GAMESAVE_ERROR_CANT_SAVE;
    return FALSE;
}

void CreateLoadSaveWorker(SaveGameLoadManager *work, u32 flags, s32 prio)
{
    work->saveFlags            = flags;
    work->success              = FALSE;
    work->usingFoldTogglePower = FALSE;
    work->canSoftReset         = TRUE;

    if (RenderCore_GetNextFoldMode() == FOLD_TOGGLE_SLEEP)
    {
        RenderCore_SetNextFoldMode(FOLD_TOGGLE_POWER);
        work->usingFoldTogglePower = TRUE;
    }

    if (!RenderCore_GetSoftResetDisabled())
    {
        RenderCore_DisableSoftReset(TRUE);
        work->canSoftReset = FALSE;
    }

    InitThreadWorker(&work->thread, SAVEMANAGER_STACK_SIZE);
    CreateThreadWorker(&work->thread, (ThreadFunc)ThreadFunc_Load, work, prio);
}

BOOL AwaitLoadSaveCompletion(SaveGameLoadManager *work)
{
    if (IsThreadWorkerFinished(&work->thread))
    {
        ReleaseThreadWorker(&work->thread);

        if (work->usingFoldTogglePower)
        {
            RenderCore_SetNextFoldMode(FOLD_TOGGLE_SLEEP);
            work->usingFoldTogglePower = FALSE;
        }

        if (!work->canSoftReset)
        {
            RenderCore_DisableSoftReset(FALSE);
            work->canSoftReset = TRUE;
        }

        return TRUE;
    }

    return FALSE;
}

BOOL GetLoadSaveSuccess(SaveGameLoadManager *work)
{
    return work->success;
}

// SaveFile Creation
BOOL TryCreateGameData(void)
{
    if (SaveGame__SaveData2(&saveGame) != SAVE_ERROR_CANT_LOAD)
        return TRUE;

    gameState.lastSaveError = GAMESAVE_ERROR_CANT_SAVE;
    return FALSE;
}

void CreateCreateSaveWorker(SaveGameCreateManager *work, s32 prio)
{
    work->success              = FALSE;
    work->usingFoldTogglePower = FALSE;
    work->canSoftReset         = TRUE;

    if (RenderCore_GetNextFoldMode() == FOLD_TOGGLE_SLEEP)
    {
        RenderCore_SetNextFoldMode(FOLD_TOGGLE_POWER);
        work->usingFoldTogglePower = TRUE;
    }

    if (!RenderCore_GetSoftResetDisabled())
    {
        RenderCore_DisableSoftReset(TRUE);
        work->canSoftReset = FALSE;
    }

    InitThreadWorker(&work->thread, SAVEMANAGER_STACK_SIZE);
    CreateThreadWorker(&work->thread, (ThreadFunc)ThreadFunc_Create, work, prio);
}

BOOL AwaitCreateSaveCompletion(SaveGameCreateManager *work)
{
    if (IsThreadWorkerFinished(&work->thread))
    {
        ReleaseThreadWorker(&work->thread);

        if (work->usingFoldTogglePower)
        {
            RenderCore_SetNextFoldMode(FOLD_TOGGLE_SLEEP);
            work->usingFoldTogglePower = FALSE;
        }

        if (!work->canSoftReset)
        {
            RenderCore_DisableSoftReset(FALSE);
            work->canSoftReset = TRUE;
        }

        return TRUE;
    }

    return FALSE;
}

BOOL GetCreateSaveSuccess(SaveGameCreateManager *work)
{
    return work->success;
}

// Thread Funcs
void ThreadFunc_Save(SaveGameSaveManager *work)
{
    work->success = TrySaveGameData(work->saveType);
}

void ThreadFunc_Load(SaveGameLoadManager *work)
{
    work->success = TryLoadGameData(work->saveFlags);
}

void ThreadFunc_Create(SaveGameCreateManager *work)
{
    work->success = TryCreateGameData();
}
