#include <sail/sailRival.h>
#include <sail/sailPlayer.h>
#include <game/file/fsRequest.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SailRival_Destructor(Task *task);
static void SailRival_Main(void);

// --------------------
// FUNCTIONS
// --------------------

SailRival *CreateSailRival(SailPlayer *parent, SailRivalControllerHeader *controller, const char *path)
{
    u16 taskFlags = TASK_FLAG_NONE;
    if (path == NULL && controller == NULL)
        taskFlags |= TASK_FLAG_DISABLE_DESTROY;

    Task *task = TaskCreate(SailRival_Main, SailRival_Destructor, taskFlags, 0, TASK_PRIORITY_UPDATE_LIST_START + 1, TASK_GROUP(0), SailRival);
    if (task == HeapNull)
        return NULL;

    SailRival *work = TaskGetWork(task, SailRival);
    TaskInitWork16(work);

    work->parent = parent;
    if (controller != NULL)
    {
        work->file = controller;
    }
    else if (path != NULL)
    {
        work->file = FSRequestFileSync(path, FSREQ_AUTO_ALLOC_HEAD);
        work->flags |= 1;
    }

    u16 startActionCount = 0;
    u16 i                = 0;
    while (TRUE)
    {
        if (work->file->entries[i].type == SAILRIVAL_ACTION_NONE)
        {
            if (startActionCount > 0)
            {
                work->nextPosition  = work->file->entries[i].position;
                work->nextTouchPosX = work->file->entries[i].touchOnX;
                break;
            }

            work->curPosition = work->file->entries[i].position;
            startActionCount++;
            work->curTouchPosX = work->file->entries[i].touchOnX;

            if (work->curPosition != 0)
            {
                work->nextPosition  = work->curPosition;
                work->nextTouchPosX = work->curTouchPosX;
                work->curPosition   = 0;
                break;
            }
        }

        // last action, break out of the loop
        if (work->file->entries[i].type == SAILRIVAL_ACTION_END)
            break;

        i++;
    }

    return work;
}

void SailRival_Destructor(Task *task)
{
    SailRival *work = TaskGetWork(task, SailRival);

    if ((work->flags & 1) != 0)
        HeapFree(HEAP_USER, work->file);
}

void SailRival_Main(void)
{
    SailRival *work = TaskGetWorkCurrent(SailRival);

    SailRivalControllerEntry *entryList = &work->file->entries[work->entryID];
    SailPlayer *parent                  = work->parent;

    if (work->disablePrevPosTimer != 0)
        work->disablePrevPosTimer--;

    s32 lastRacePos = work->racePosition;

    work->racePosition += (parent->racePos.z - work->racePosition) + parent->speed;
    work->actions = 0x00;

    if (work->racePosition > work->nextPosition)
    {
        for (u16 i = 0; TRUE; i++)
        {
            SailRivalControllerEntry *entry = &entryList[i];
            if (entry->type == SAILRIVAL_ACTION_NONE)
            {
                if (work->racePosition <= entryList[i].position)
                {
                    work->curPosition   = work->nextPosition;
                    work->curTouchPosX  = work->nextTouchPosX;
                    work->nextPosition  = entryList[i].position;
                    work->nextTouchPosX = entryList[i].touchOnX;
                    break;
                }
            }
            else
            {
                if (entry->type == SAILRIVAL_ACTION_END)
                {
                    work->curTouchPosX = work->nextTouchPosX;
                    break;
                }
            }
        }
    }

    if (work->curTouchPosX == work->nextTouchPosX)
    {
        work->touchPosX = work->curTouchPosX;
    }
    else
    {
        u32 step        = MultiplyFX(work->nextTouchPosX - work->curTouchPosX, FX_Div(work->racePosition - work->curPosition, work->nextPosition - work->curPosition));
        work->touchPosX = step + work->curTouchPosX;
    }

    for (u16 i = 0; TRUE; i++)
    {
        u32 targetRacePos = entryList[i].position;
        u32 racePosition  = work->racePosition;
        if (targetRacePos > racePosition)
            break;

        SailRivalControllerEntry *entry = &entryList[i];
        if (entry->type != SAILRIVAL_ACTION_NONE && lastRacePos <= targetRacePos && racePosition > targetRacePos)
        {
            if (entry->type == SAILRIVAL_ACTION_END)
                break;

            work->actions |= 1 << entry->type;

            if (entry->type == SAILRIVAL_ACTION_DISABLE_PREV_TOUCH_POS)
                work->disablePrevPosTimer = entry->touchOnX;

            work->entryID++;
        }
    }

    work->timer++;
}