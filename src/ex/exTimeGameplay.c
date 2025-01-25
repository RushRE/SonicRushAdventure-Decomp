#include <ex/exTimeGameplay.h>
#include <game/audio/audioSystem.h>

// --------------------
// VARIABLES
// --------------------

static Task *taskSingleton;
static BOOL isTimeOver;

// --------------------
// FUNCTION DECLS
// --------------------

static void ExTimeGameplay_Main_Init(void);
static void ExTimeGameplay_TaskUnknown(void);
static void ExTimeGameplay_Destructor(void);
static void ExTimeGameplay_Main_Active(void);
static void ExTimeGameplay_Action_TimeOver(void);
static void ExTimeGameplay_Main_TimeOver(void);

// --------------------
// FUNCTIONS
// --------------------

void ExTimeGameplay_Main_Init(void)
{
    exTimeGamePlayTask *work = ExTaskGetWorkCurrent(exTimeGamePlayTask);

    taskSingleton      = GetCurrentTask();
    work->time         = &exSysTask__GetStatus()->time;
    work->frameCounter = 0;

    SetCurrentExTaskMainEvent(ExTimeGameplay_Main_Active);
    ExTimeGameplay_Main_Active();
}

void ExTimeGameplay_TaskUnknown(void)
{
    exTimeGamePlayTask *work = ExTaskGetWorkCurrent(exTimeGamePlayTask);
    UNUSED(work);
}

void ExTimeGameplay_Destructor(void)
{
    exTimeGamePlayTask *work = ExTaskGetWorkCurrent(exTimeGamePlayTask);
    UNUSED(work);

    taskSingleton = NULL;
}

void ExTimeGameplay_Main_Active(void)
{
    exTimeGamePlayTask *work = ExTaskGetWorkCurrent(exTimeGamePlayTask);

    isTimeOver = FALSE;

    if (exSysTask__GetStatus()->state != EXSYSTASK_STATE_11 && exSysTask__GetStatus()->state != EXSYSTASK_STATE_7 && exSysTask__GetStatus()->state != EXSYSTASK_STATE_9)
    {
        if (exSysTask__GetStatus()->state >= EXSYSTASK_STATE_4)
        {
            work->frameCounter += 1666.0f;
            work->time->centiseconds = work->frameCounter / 1000;

            if (work->time->centiseconds > 9)
            {
                work->frameCounter -= 10000;
                work->time->centiseconds = 0;

                work->time->frameCounter++;
                if (work->time->frameCounter > 9)
                {
                    work->time->frameCounter = 0;

                    work->time->seconds++;
                    if (work->time->seconds > 9)
                    {
                        if (work->time->minutes == 9 && work->time->tenSeconds >= 3 && work->time->seconds == 10)
                            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_COUNTDOWN);

                        work->time->seconds = 0;
                        
                        work->time->tenSeconds++;
                        if (work->time->tenSeconds > 5)
                        {
                            work->time->tenSeconds = 0;

                            work->time->minutes++;
                            if (work->time->minutes > 9)
                            {
                                ExTimeGameplay_Action_TimeOver();
                                return;
                            }
                        }
                    }
                    else
                    {
                        if (work->time->minutes == 9 && work->time->tenSeconds >= 4)
                        {
                            if ((work->time->seconds % 2) == 0 || work->time->seconds == 10)
                                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_COUNTDOWN);
                        }
                    }
                }
            }
        }

        RunCurrentExTaskUnknownEvent();
    }
}

void ExTimeGameplay_Action_TimeOver(void)
{
    exTimeGamePlayTask *work = ExTaskGetWorkCurrent(exTimeGamePlayTask);

    isTimeOver = TRUE;

    work->time->minutes      = 9;
    work->time->tenSeconds   = 5;
    work->time->seconds      = 9;
    work->time->frameCounter = 9;
    work->time->centiseconds = 9;

    SetCurrentExTaskMainEvent(ExTimeGameplay_Main_TimeOver);
    ExTimeGameplay_Main_TimeOver();
}

void ExTimeGameplay_Main_TimeOver(void)
{
    exTimeGamePlayTask *work = ExTaskGetWorkCurrent(exTimeGamePlayTask);
    UNUSED(work);

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExTimeGameplay(void)
{
    Task *task =
        ExTaskCreate(ExTimeGameplay_Main_Init, ExTimeGameplay_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1200, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exTimeGamePlayTask);

    exTimeGamePlayTask *work = ExTaskGetWork(task, exTimeGamePlayTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExTimeGameplay_TaskUnknown);

    return TRUE;
}

void DestroyExTimeGameplay(void)
{
    if (taskSingleton != NULL)
        DestroyExTask(taskSingleton);
}

BOOL CheckExTimeGameplayIsTimeOver(void)
{
    return isTimeOver;
}

void ResetExTimeGameplayTimeOverFlag(void)
{
    isTimeOver = FALSE;
}
