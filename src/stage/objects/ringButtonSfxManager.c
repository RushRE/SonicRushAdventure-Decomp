#include <stage/objects/ringButtonSfxManager.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>

// --------------------
// VARIABLES
// --------------------

s32 RingButtonSfxManager__timerTable[32];

// --------------------
// FUNCTION DECLS
// --------------------

static void RingButtonSfxManager_Destructor(Task *task);
static void RingButtonSfxManager_Main(void);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE BOOL CheckPlayerActive(RingButtonSfxManager *work)
{
    if ((gPlayer->playerFlag & PLAYER_FLAG_DEATH) != 0)
        work->playerActive = TRUE;

    return work->playerActive && (gPlayer->playerFlag & PLAYER_FLAG_DEATH) == 0;
}

// --------------------
// FUNCTIONS
// --------------------

void RingButtonSfxManager__Create(s16 type, BOOL allocSndHandle)
{
    Task *task =
        TaskCreate(RingButtonSfxManager_Main, RingButtonSfxManager_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, RingButtonSfxManager);
    if (task == HeapNull)
        return;

    RingButtonSfxManager *work = TaskGetWork(task, RingButtonSfxManager);
    TaskInitWork8(work);

    work->type = type;
    if (allocSndHandle)
        work->sndHandle = AllocSndHandle();
}

void RingButtonSfxManager_Destructor(Task *task)
{
    RingButtonSfxManager *work = TaskGetWork(task, RingButtonSfxManager);

    if (work->sndHandle != NULL)
    {
        NNS_SndPlayerStopSeq(work->sndHandle, 0);
        NNS_SndHandleReleaseSeq(work->sndHandle);
        FreeSndHandle(work->sndHandle);
    }

    RingButtonSfxManager__timerTable[work->type] = 0;
}

void RingButtonSfxManager_Main(void)
{
    RingButtonSfxManager *work = TaskGetWorkCurrent(RingButtonSfxManager);

    if (RingButtonSfxManager__timerTable[work->type] != 1020)
    {
        if (RingButtonSfxManager__timerTable[work->type] != 0)
        {
            RingButtonSfxManager__timerTable[work->type]--;
        }
        else
        {
            DestroyCurrentTask();
            return;
        }

        if (!gmCheckRingBattle() && CheckPlayerActive(work))
        {
            DestroyCurrentTask();
        }
        else
        {
            if (work->sndHandle != NULL)
            {
                u32 timer = RingButtonSfxManager__timerTable[work->type];
                if (timer == 60)
                {
                    NNS_SndPlayerSetTempoRatio(work->sndHandle, 512);
                    work->changedTempo = TRUE;
                }
                else if (timer > 60)
                {
                    if (work->changedTempo)
                    {
                        NNS_SndPlayerSetTempoRatio(work->sndHandle, 256);
                        work->changedTempo = FALSE;
                    }
                }
            }
        }
    }
}
